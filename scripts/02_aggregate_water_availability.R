# =============================================================================
# 02_aggregate_water_availability.R
# Read water_availability*.gpkg from all 27 catchments and merge into 4
# region-wide GeoPackages, one per scenario. Adds catchment name column.
#
# Input (per catchment):
#   catch_data/water_availability.gpkg          <- baseline
#   catch_data/water_availability_climate.gpkg  <- climate scenario
#   catch_data/water_availability_urban.gpkg    <- urban growth scenario
#   catch_data/water_availability_combined.gpkg <- combined scenario
#
# Output:
#   Results/water_availability_region.gpkg
#   Results/water_availability_region_climate.gpkg
#   Results/water_availability_region_urban.gpkg
#   Results/water_availability_region_combined.gpkg
# =============================================================================

library(sf)

# -----------------------------------------------------------------------------
# Paths
# -----------------------------------------------------------------------------
repo        <- "C:/Users/KVZKARL/Source/Repos/BalticSeaH2_T3.1"
results_dir <- file.path(repo, "Results")

catchment_dirs <- list.dirs(
  file.path(results_dir, "model_setups/catchments"),
  recursive = FALSE
)

scenarios <- list(
  baseline = "water_availability.gpkg",
  climate  = "water_availability_climate.gpkg",
  urban    = "water_availability_urban.gpkg",
  combined = "water_availability_combined.gpkg"
)

# -----------------------------------------------------------------------------
# Helper: read one gpkg and tag with catchment name
# -----------------------------------------------------------------------------
read_wa <- function(catch_dir, gpkg_filename) {
  path <- file.path(catch_dir, "catch_data", gpkg_filename)
  if (!file.exists(path)) {
    message("  Missing: ", path)
    return(NULL)
  }
  sf_obj <- st_read(path, quiet = TRUE)
  sf_obj$catchment_name <- basename(catch_dir)
  sf_obj
}

# -----------------------------------------------------------------------------
# Loop over scenarios
# -----------------------------------------------------------------------------
for (scenario_name in names(scenarios)) {

  gpkg_file <- scenarios[[scenario_name]]
  message("Processing scenario: ", scenario_name)

  # Read and bind all catchments
  layers <- lapply(catchment_dirs, function(d) {
    message("  Reading: ", basename(d))
    read_wa(d, gpkg_file)
  })
  layers <- Filter(Negate(is.null), layers)

  if (length(layers) == 0) {
    message("  No data found for scenario: ", scenario_name)
    next
  }

  # Merge into single sf object
  region <- do.call(rbind, layers)
  rownames(region) <- NULL

  # Reorder columns: identifiers first, then land cover, then flow stats, then geom
  id_cols    <- c("catchment_name", "taso4_osat", "catchment")
  lc_cols    <- c("urban_frac", "agri_frac", "forest_frac",
                  "wetland_frac", "water_frac", "peat_frac")
  stat_cols  <- c(
    "winter_min", "winter_q10", "winter_median", "winter_mean", "winter_max",
    "spring_min", "spring_q10", "spring_median", "spring_mean", "spring_max",
    "summer_min", "summer_q10", "summer_median", "summer_mean", "summer_max",
    "autumn_min", "autumn_q10", "autumn_median", "autumn_mean", "autumn_max",
    "annual_min", "annual_q10", "annual_median", "annual_mean", "annual_max"
  )
  all_cols <- c(id_cols, lc_cols, stat_cols)
  # Keep only columns that exist
  all_cols <- all_cols[all_cols %in% names(region)]
  region   <- region[, all_cols]

  # Write output
  out_suffix <- if (scenario_name == "baseline") "" else paste0("_", scenario_name)
  out_path <- file.path(
    results_dir,
    paste0("water_availability_region", out_suffix, ".gpkg")
  )

  st_write(region, out_path, delete_dsn = TRUE, quiet = TRUE)
  message("  Written: ", basename(out_path),
          " (", nrow(region), " subcatchments)")
}

# -----------------------------------------------------------------------------
# Verify outputs
# -----------------------------------------------------------------------------
message("\n--- Output files ---")
out_files <- list.files(results_dir, pattern = "water_availability_region.*\\.gpkg")
for (f in out_files) {
  lyr <- st_read(file.path(results_dir, f), quiet = TRUE)
  message(sprintf("  %-50s  %d subcatchments  %d catchments",
                  f, nrow(lyr),
                  length(unique(lyr$catchment_name))))
}

message("\nDone.")
