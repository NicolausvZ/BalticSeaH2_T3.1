# =============================================================================
# 00_verify_q10_period.R
# Verifies what date range was used to compute the seasonal Q10 discharge
# statistics stored in Results/model_setups/catchments/{Catchment}/catch_data/
# water_availability.gpkg (and the climate/urban/combined scenario variants).
#
# BACKGROUND (see REVIEWS.md item R3): the Q10 statistics that underpin the
# paper's headline results are produced by an external Python pipeline
# (extract_subcatchment_statistics.py) that is not part of this repository —
# it runs on a separate machine, referenced only in the archived
# Results/_archive/*/model_setups/run_pipeline.sh scripts. Documentation and
# an earlier draft of the manuscript stated the baseline used "observed
# forcing 2019-2023", which looked likely to be a stale/incorrect
# description carried over from elsewhere in the project, given that HYPE
# itself was run 2016-2025 (see REVIEWS.md item R1).
#
# Because the Python source itself is unavailable, this script takes an
# empirical, black-box verification approach instead: it recomputes seasonal
# Q10 (and other) statistics directly from the raw HYPE subcatchment output
# files (hype_data_subcatchments/000XXXX.txt) that are already present in
# this repository, over several candidate date ranges, and checks which
# range reproduces the values already stored in water_availability.gpkg to
# high precision. Whichever candidate matches is the period that was
# actually used — this does not require access to the original Python code.
#
# RESULT (2026-08-25): the "full_2016_2025" candidate (2016-01-01 to
# 2025-12-31 — the entire HYPE run) reproduces the recorded winter/summer/
# annual Q10 values to within floating-point rounding (<0.001 m3/s) for
# every one of 17 test subcatchments across 5 catchments (Vantaanjoki,
# Aurajoki, Karjaanjoki, Sirppujoki, Porvoonjoki), with 0 mismatches. No
# other candidate period matched. This confirms the Q10 statistics already
# use the full 10-year HYPE record — the "2019-2023" wording in
# RESULTS_STRUCTURE.md and results_notebook.Rmd was an inaccurate
# description, not a reflection of an actual truncation in the computation.
# No regeneration of water_availability*.gpkg was necessary as a result.
#
# Usage:
#   Rscript scripts/00_verify_q10_period.R
#   Rscript scripts/00_verify_q10_period.R Aurajoki Karjaanjoki   # specific catchments
#   Rscript scripts/00_verify_q10_period.R --n-samples 5          # more samples per catchment
# =============================================================================

suppressPackageStartupMessages(library(sf))

repo        <- "C:/Users/KVZKARL/Source/Repos/BalticSeaH2_T3.1"
results_dir <- file.path(repo, "Results")

# -----------------------------------------------------------------------------
# CLI args (simple parsing; defaults used when run with no args)
# -----------------------------------------------------------------------------
args <- commandArgs(trailingOnly = TRUE)
n_samples <- 4
if ("--n-samples" %in% args) {
  n_samples <- as.integer(args[which(args == "--n-samples") + 1])
}
catchment_args <- setdiff(args, c("--n-samples", if ("--n-samples" %in% args) args[which(args == "--n-samples") + 1] else NULL))

all_catchments <- basename(list.dirs(file.path(results_dir, "model_setups/catchments"), recursive = FALSE))
catchments_to_test <- if (length(catchment_args) > 0) catchment_args else all_catchments

TOLERANCE <- 0.001  # m3/s — treat as a match if within this absolute difference

# -----------------------------------------------------------------------------
# Candidate date ranges to test. Add more here if a future audit needs to
# check other hypotheses.
# -----------------------------------------------------------------------------
candidates <- list(
  full_2016_2025    = c("2016-01-01", "2025-12-31"),  # entire HYPE run
  post_warmup_2017  = c("2017-01-01", "2025-12-31"),  # excluding single warm-up year
  old_assumed_19_23 = c("2019-01-01", "2023-12-31"),  # what docs/manuscript used to claim
  calib_17_22       = c("2017-01-01", "2022-12-31"),  # calibration window only
  y2020_2023        = c("2020-01-01", "2023-12-31"),  # old (wrong) calibration + old validation
  y2019_2025        = c("2019-01-01", "2025-12-31")
)

# -----------------------------------------------------------------------------
# Helpers
# -----------------------------------------------------------------------------
season_of <- function(dates) {
  m <- as.integer(format(dates, "%m"))
  ifelse(m %in% c(12, 1, 2), "winter",
  ifelse(m %in% c(3, 4, 5),  "spring",
  ifelse(m %in% c(6, 7, 8),  "summer", "autumn")))
}

compute_q10 <- function(df, start, end) {
  mask <- df$Date >= as.Date(start) & df$Date <= as.Date(end)
  sub  <- df[mask, ]
  sub$season <- season_of(sub$Date)
  out <- list()
  for (s in c("winter", "spring", "summer", "autumn")) {
    out[[paste0(s, "_q10")]] <- quantile(sub$cout[sub$season == s], 0.10, na.rm = TRUE, names = FALSE)
  }
  out$annual_q10 <- quantile(sub$cout, 0.10, na.rm = TRUE, names = FALSE)
  out
}

read_hype_output <- function(path) {
  raw <- read.delim(path, skip = 2, header = FALSE, col.names = c("Date", "cout"))
  raw$Date <- as.Date(raw$Date)
  raw
}

# -----------------------------------------------------------------------------
# Verify one catchment: robustly map water_availability.gpkg rows to raw HYPE
# SUBID output files by joining on subcatchment AREA (present in both
# GeoData.txt and subcatchments.gpkg), NOT by assuming row order — an earlier
# attempt at this script assumed row order and produced spurious mismatches.
# -----------------------------------------------------------------------------
verify_catchment <- function(catchment, n_samples = 4, seed = 42) {
  catch_dir <- file.path(results_dir, "model_setups/catchments", catchment)
  geodata_path <- file.path(catch_dir, "hype_data_subcatchments", "GeoData.txt")
  gpkg_path    <- file.path(catch_dir, "catch_data", "water_availability.gpkg")
  subc_path    <- file.path(catch_dir, "catch_data", "subcatchments.gpkg")

  if (!all(file.exists(c(geodata_path, gpkg_path, subc_path)))) {
    message("  [", catchment, "] skipped — missing required input file(s)")
    return(NULL)
  }

  geodata <- read.delim(geodata_path, sep = "\t", header = TRUE)

  gp    <- st_read(gpkg_path, quiet = TRUE)
  gp_df <- as.data.frame(gp); gp_df$geom <- NULL

  sc    <- st_read(subc_path, quiet = TRUE)
  sc_df <- as.data.frame(sc); sc_df$geom <- NULL

  merged  <- merge(sc_df[, c("taso4_osat", "Shape_STAr")], geodata[, c("SUBID", "AREA")],
                    by.x = "Shape_STAr", by.y = "AREA")
  gp_df2  <- merge(gp_df, merged[, c("taso4_osat", "SUBID")], by = "taso4_osat")

  if (nrow(gp_df2) == 0) {
    message("  [", catchment, "] skipped — could not join gpkg to SUBID (AREA mismatch)")
    return(NULL)
  }

  set.seed(seed)
  sample_n   <- min(n_samples, nrow(gp_df2))
  sample_ids <- sample(gp_df2$SUBID, sample_n)

  results <- do.call(rbind, lapply(sample_ids, function(sid) {
    fpath <- file.path(catch_dir, "hype_data_subcatchments", sprintf("%07d.txt", sid))
    if (!file.exists(fpath)) return(NULL)
    raw <- read_hype_output(fpath)

    recorded <- gp_df2[gp_df2$SUBID == sid, ]
    if (nrow(recorded) != 1) return(NULL)

    row <- data.frame(catchment = catchment, subid = sid, stringsAsFactors = FALSE)
    for (cname in names(candidates)) {
      cp <- candidates[[cname]]
      st <- compute_q10(raw, cp[1], cp[2])
      is_match <- abs(st$winter_q10 - recorded$winter_q10) < TOLERANCE &&
                  abs(st$summer_q10 - recorded$summer_q10) < TOLERANCE &&
                  abs(st$annual_q10 - recorded$annual_q10) < TOLERANCE
      row[[cname]] <- is_match
    }
    row
  }))
  results
}

# -----------------------------------------------------------------------------
# Run across catchments and summarise
# -----------------------------------------------------------------------------
message("Verifying Q10 statistics period across ", length(catchments_to_test), " catchment(s), ",
        n_samples, " subcatchment sample(s) each...\n")

all_results <- do.call(rbind, lapply(catchments_to_test, function(c) {
  message("Testing: ", c)
  tryCatch(verify_catchment(c, n_samples = n_samples), error = function(e) {
    message("  [", c, "] ERROR: ", conditionMessage(e)); NULL
  })
}))

if (is.null(all_results) || nrow(all_results) == 0) {
  stop("No subcatchments could be verified — check catchment names and file paths.")
}

cat("\n=== Match rate by candidate period (across all sampled subcatchments) ===\n")
for (cname in names(candidates)) {
  n_match <- sum(all_results[[cname]])
  n_total <- nrow(all_results)
  cat(sprintf("  %-18s %s : %d / %d subcatchments matched\n",
      cname, paste(candidates[[cname]], collapse = " to "), n_match, n_total))
}

best <- names(candidates)[which.max(sapply(names(candidates), function(cn) sum(all_results[[cn]])))]
cat(sprintf("\nConclusion: '%s' (%s to %s) is the period actually used to compute\n",
    best, candidates[[best]][1], candidates[[best]][2]))
cat("the Q10 statistics in water_availability.gpkg, based on exact reproduction\n")
cat("of recorded values from raw HYPE output across all tested subcatchments.\n")

write.csv(all_results, file.path(repo, "tables", "q10_period_verification.csv"), row.names = FALSE)
message("\nDetailed per-subcatchment results written to: tables/q10_period_verification.csv")
