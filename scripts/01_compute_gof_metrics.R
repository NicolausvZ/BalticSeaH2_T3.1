# =============================================================================
# 01_compute_gof_metrics.R
# Compute calibration and validation goodness-of-fit metrics for all gauged
# catchments. Reads calib_disch_data_results.csv from each catchment's
# catch_data folder, computes NSE, KGE, R2, PBIAS and RMSE per gauge per
# period, and writes a single summary table to tables/.
#
# Periods:
#   Warm-up     : 2019        (excluded)
#   Calibration : 2020-2022   (metrics computed)
#   Validation  : 2023        (metrics computed)
#   Other       : 2016-2018, 2024-2025 (excluded)
#
# Output:
#   tables/gof_metrics.csv
# =============================================================================

library(sf)

# -----------------------------------------------------------------------------
# Paths
# -----------------------------------------------------------------------------
repo        <- "C:/Users/KVZKARL/Source/Repos/BalticSeaH2_T3.1"
results_dir <- file.path(repo, "Results")
tables_dir  <- file.path(repo, "tables")

catchment_dirs <- list.dirs(
  file.path(results_dir, "model_setups/catchments"),
  recursive = FALSE
)

# -----------------------------------------------------------------------------
# Metric functions
# -----------------------------------------------------------------------------
nse <- function(obs, sim) {
  valid <- !is.na(obs) & !is.na(sim)
  obs <- obs[valid]; sim <- sim[valid]
  if (length(obs) < 10) return(NA_real_)
  1 - sum((obs - sim)^2) / sum((obs - mean(obs))^2)
}

log_nse <- function(obs, sim) {
  valid <- !is.na(obs) & !is.na(sim) & obs > 0 & sim > 0
  obs <- log(obs[valid]); sim <- log(sim[valid])
  if (length(obs) < 10) return(NA_real_)
  1 - sum((obs - sim)^2) / sum((obs - mean(obs))^2)
}

kge <- function(obs, sim) {
  valid <- !is.na(obs) & !is.na(sim)
  obs <- obs[valid]; sim <- sim[valid]
  if (length(obs) < 10) return(NA_real_)
  r   <- cor(obs, sim)
  b   <- mean(sim) / mean(obs)          # bias ratio
  g   <- (sd(sim) / mean(sim)) /
         (sd(obs) / mean(obs))          # variability ratio (CV)
  1 - sqrt((r - 1)^2 + (b - 1)^2 + (g - 1)^2)
}

r2 <- function(obs, sim) {
  valid <- !is.na(obs) & !is.na(sim)
  obs <- obs[valid]; sim <- sim[valid]
  if (length(obs) < 10) return(NA_real_)
  cor(obs, sim)^2
}

pbias <- function(obs, sim) {
  valid <- !is.na(obs) & !is.na(sim)
  obs <- obs[valid]; sim <- sim[valid]
  if (length(obs) < 10) return(NA_real_)
  100 * sum(obs - sim) / sum(obs)
}

rmse <- function(obs, sim) {
  valid <- !is.na(obs) & !is.na(sim)
  obs <- obs[valid]; sim <- sim[valid]
  if (length(obs) < 10) return(NA_real_)
  sqrt(mean((obs - sim)^2))
}

# -----------------------------------------------------------------------------
# Compute metrics for one catchment
# -----------------------------------------------------------------------------
compute_catchment_metrics <- function(catch_dir) {
  catchment_name <- basename(catch_dir)
  csv_path <- file.path(catch_dir, "catch_data", "calib_disch_data_results.csv")

  if (!file.exists(csv_path)) {
    message("  Skipping ", catchment_name, " — no CSV found")
    return(NULL)
  }

  df <- read.csv(csv_path)
  df$Date <- as.Date(df$Date)

  # Identify observed/simulated column pairs
  # Pattern: X{station} followed by simulated_{subcatchment}
  col_names <- names(df)
  obs_cols <- grep("^X[0-9]", col_names, value = TRUE)
  sim_cols <- grep("^simulated_",  col_names, value = TRUE)

  if (length(obs_cols) != length(sim_cols)) {
    message("  Warning: unequal obs/sim columns in ", catchment_name)
    n_pairs <- min(length(obs_cols), length(sim_cols))
    obs_cols <- obs_cols[seq_len(n_pairs)]
    sim_cols <- sim_cols[seq_len(n_pairs)]
  }

  # Period masks
  calib_mask <- df$Date >= as.Date("2020-01-01") & df$Date <= as.Date("2022-12-31")
  valid_mask <- df$Date >= as.Date("2023-01-01") & df$Date <= as.Date("2023-12-31")

  # Compute metrics per gauge pair per period
  results <- lapply(seq_along(obs_cols), function(i) {
    obs_col <- obs_cols[i]
    sim_col <- sim_cols[i]
    station_id     <- sub("^X", "", obs_col)
    subcatchment_id <- sub("^simulated_", "", sim_col)

    obs <- df[[obs_col]]
    sim <- df[[sim_col]]

    # Skip if observed is all NA (production-only, no gauge)
    if (all(is.na(obs))) return(NULL)

    do.call(rbind, lapply(
      list(
        list(label = "calibration", mask = calib_mask),
        list(label = "validation",  mask = valid_mask)
      ),
      function(p) {
        o <- obs[p$mask]
        s <- sim[p$mask]
        data.frame(
          catchment      = catchment_name,
          station_id     = station_id,
          subcatchment_id = subcatchment_id,
          period         = p$label,
          n_obs          = sum(!is.na(o)),
          NSE            = round(nse(o, s),    3),
          logNSE         = round(log_nse(o, s), 3),
          KGE            = round(kge(o, s),    3),
          R2             = round(r2(o, s),     3),
          PBIAS          = round(pbias(o, s),  2),
          RMSE           = round(rmse(o, s),   4),
          stringsAsFactors = FALSE
        )
      }
    ))
  })

  do.call(rbind, Filter(Negate(is.null), results))
}

# -----------------------------------------------------------------------------
# Run across all catchments
# -----------------------------------------------------------------------------
message("Computing GOF metrics for ", length(catchment_dirs), " catchments...")

all_metrics <- do.call(rbind, lapply(catchment_dirs, function(d) {
  message("  Processing: ", basename(d))
  compute_catchment_metrics(d)
}))

# Sort by catchment and period
all_metrics <- all_metrics[order(all_metrics$catchment, all_metrics$period,
                                 all_metrics$station_id), ]
rownames(all_metrics) <- NULL

# -----------------------------------------------------------------------------
# Write output
# -----------------------------------------------------------------------------
out_path <- file.path(tables_dir, "gof_metrics.csv")
write.csv(all_metrics, out_path, row.names = FALSE)
message("Done. Metrics written to: ", out_path)

# Quick summary to console
message("\n--- Summary across all gauges ---")
for (p in c("calibration", "validation")) {
  sub <- all_metrics[all_metrics$period == p, ]
  message(sprintf(
    "%s  n=%d  NSE: median=%.2f min=%.2f  KGE: median=%.2f min=%.2f  |PBIAS|<10%%: %d/%d",
    p, nrow(sub),
    median(sub$NSE,  na.rm = TRUE), min(sub$NSE,  na.rm = TRUE),
    median(sub$KGE,  na.rm = TRUE), min(sub$KGE,  na.rm = TRUE),
    sum(abs(sub$PBIAS) < 10, na.rm = TRUE), nrow(sub)
  ))
}

print(all_metrics)
