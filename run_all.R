# =============================================================================
# run_all.R
# Smart runner for the BalticSeaH2 T3.1 analysis pipeline.
#
# Each script is only run if:
#   (a) its output files are missing, OR
#   (b) its input files are newer than its output files
#
# This means scripts are skipped if upstream HYPE results have not changed,
# avoiding unnecessary long reruns when only tweaking visualisations.
#
# Run order:
#   01 -> 02 -> 03 -> 03a -> 04 -> 05
#
# Usage:
#   source("run_all.R")
#
# To force rerun of all scripts regardless of timestamps:
#   source("run_all.R")  # after setting FORCE_RERUN <- TRUE below
# =============================================================================

FORCE_RERUN <- FALSE  # set TRUE to rerun everything regardless of timestamps

# -----------------------------------------------------------------------------
# Paths
# -----------------------------------------------------------------------------
repo        <- "C:/Users/KVZKARL/Source/Repos/BalticSeaH2_T3.1"
results_dir <- file.path(repo, "Results")
scripts_dir <- file.path(repo, "scripts")
tables_dir  <- file.path(repo, "tables")
figures_dir <- file.path(repo, "figures")

# -----------------------------------------------------------------------------
# Logging
# -----------------------------------------------------------------------------
log_path <- file.path(repo, "run_all.log")
log_con  <- file(log_path, open = "at")  # append mode

log <- function(...) {
  msg <- paste0("[", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "]  ", ...)
  message(msg)
  writeLines(msg, log_con)
}

log("=================================================================")
log("run_all.R started")
log(paste0("FORCE_RERUN = ", FORCE_RERUN))

# -----------------------------------------------------------------------------
# Helper: newest mtime among a vector of file paths (ignores missing files)
# -----------------------------------------------------------------------------
newest_mtime <- function(paths) {
  paths   <- paths[file.exists(paths)]
  if (length(paths) == 0) return(as.POSIXct(0, origin = "1970-01-01"))
  mtimes  <- file.info(paths)$mtime
  max(mtimes, na.rm = TRUE)
}

oldest_mtime <- function(paths) {
  paths  <- paths[file.exists(paths)]
  if (length(paths) == 0) return(as.POSIXct(0, origin = "1970-01-01"))
  mtimes <- file.info(paths)$mtime
  min(mtimes, na.rm = TRUE)
}

all_exist <- function(paths) all(file.exists(paths))

# -----------------------------------------------------------------------------
# Helper: decide whether to run a script
# -----------------------------------------------------------------------------
should_run <- function(script_name, inputs, outputs) {
  if (FORCE_RERUN) {
    log(paste0("FORCE_RERUN: will run ", script_name))
    return(TRUE)
  }
  if (!all_exist(outputs)) {
    log(paste0("Outputs missing: will run ", script_name))
    return(TRUE)
  }
  in_time  <- newest_mtime(inputs)
  out_time <- oldest_mtime(outputs)
  if (in_time > out_time) {
    log(paste0("Inputs newer than outputs: will run ", script_name))
    return(TRUE)
  }
  log(paste0("Up to date: skipping ", script_name))
  return(FALSE)
}

# -----------------------------------------------------------------------------
# Helper: run a script and log duration
# -----------------------------------------------------------------------------
run_script <- function(script_name) {
  path  <- file.path(scripts_dir, script_name)
  log(paste0("--- Running: ", script_name, " ---"))
  t0    <- proc.time()
  tryCatch({
    source(path, local = FALSE)
    elapsed <- round((proc.time() - t0)["elapsed"], 1)
    log(paste0("--- Finished: ", script_name, " (", elapsed, "s) ---"))
  }, error = function(e) {
    log(paste0("--- ERROR in ", script_name, ": ", e$message, " ---"))
    stop(e)
  })
}

# =============================================================================
# Script 01 — compute_gof_metrics
# =============================================================================
catchment_dirs <- list.dirs(
  file.path(results_dir, "model_setups/catchments"),
  recursive = FALSE
)

inputs_01 <- unlist(lapply(catchment_dirs, function(d) {
  file.path(d, "catch_data", "calib_disch_data_results.csv")
}))

outputs_01 <- file.path(tables_dir, "gof_metrics.csv")

if (should_run("01_compute_gof_metrics.R", inputs_01, outputs_01)) {
  run_script("01_compute_gof_metrics.R")
}

# =============================================================================
# Script 02 — aggregate_water_availability
# =============================================================================
inputs_02 <- unlist(lapply(catchment_dirs, function(d) {
  c(
    file.path(d, "catch_data", "water_availability.gpkg"),
    file.path(d, "catch_data", "water_availability_climate.gpkg"),
    file.path(d, "catch_data", "water_availability_urban.gpkg"),
    file.path(d, "catch_data", "water_availability_combined.gpkg")
  )
}))

outputs_02 <- file.path(results_dir, c(
  "water_availability_region.gpkg",
  "water_availability_region_climate.gpkg",
  "water_availability_region_urban.gpkg",
  "water_availability_region_combined.gpkg"
))

if (should_run("02_aggregate_water_availability.R", inputs_02, outputs_02)) {
  run_script("02_aggregate_water_availability.R")
}

# =============================================================================
# Script 03 — plot_hydrographs
# =============================================================================
inputs_03  <- c(inputs_01, outputs_01)
outputs_03 <- list.files(
  file.path(figures_dir, "hydrographs"),
  pattern = "\\.png$", full.names = TRUE
)
# If no PNGs exist yet, use a dummy missing path to trigger the run
if (length(outputs_03) == 0) {
  outputs_03 <- file.path(figures_dir, "hydrographs", "dummy_missing.png")
}

if (should_run("03_plot_hydrographs.R", inputs_03, outputs_03)) {
  run_script("03_plot_hydrographs.R")
}

# =============================================================================
# Script 03a — plot_hydrograph_compound
# =============================================================================
inputs_03a  <- c(outputs_01,
                 file.path(results_dir, "model_setups/catchments/Vantaanjoki/catch_data/calib_disch_data_results.csv"))
outputs_03a <- file.path(figures_dir, "hydrograph_compound.png")

if (should_run("03a_plot_hydrograph_compound.R", inputs_03a, outputs_03a)) {
  run_script("03a_plot_hydrograph_compound.R")
}

# =============================================================================
# Script 04 — plot_seasonal_maps
# =============================================================================
inputs_04  <- outputs_02
outputs_04 <- list.files(
  file.path(figures_dir, "maps"),
  pattern = "\\.png$", full.names = TRUE
)
# Expect 100 maps
if (length(outputs_04) < 100) {
  outputs_04 <- file.path(figures_dir, "maps", "dummy_missing.png")
}

if (should_run("04_plot_seasonal_maps.R", inputs_04, outputs_04)) {
  run_script("04_plot_seasonal_maps.R")
}

# =============================================================================
# Script 05 — plot_scenario_comparison
# =============================================================================
inputs_05  <- outputs_02
outputs_05 <- list.files(
  file.path(figures_dir, "maps_delta"),
  pattern = "\\.png$", full.names = TRUE
)
# Expect 75 maps
if (length(outputs_05) < 75) {
  outputs_05 <- file.path(figures_dir, "maps_delta", "dummy_missing.png")
}

if (should_run("05_plot_scenario_comparison.R", inputs_05, outputs_05)) {
  run_script("05_plot_scenario_comparison.R")
}

# =============================================================================
# Done
# =============================================================================
log("=================================================================")
log("run_all.R completed successfully")
log("=================================================================")

close(log_con)
message("\nLog written to: ", log_path)
