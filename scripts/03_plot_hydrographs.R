# =============================================================================
# 03_plot_hydrographs.R
# Plot observed vs simulated hydrographs for all gauged catchments.
# Calibration (2020-2022) and validation (2023) periods marked with shaded
# backgrounds. One PNG per gauge saved to figures/hydrographs/.
#
# Input:
#   catch_data/calib_disch_data_results.csv  (per catchment)
#   tables/gof_metrics.csv                   (for annotation)
#
# Output:
#   figures/hydrographs/{catchment}_{station_id}.png
# =============================================================================

library(sf)

# -----------------------------------------------------------------------------
# Paths
# -----------------------------------------------------------------------------
repo        <- "C:/Users/KVZKARL/Source/Repos/BalticSeaH2_T3.1"
results_dir <- file.path(repo, "Results")
fig_dir     <- file.path(repo, "figures", "hydrographs")
dir.create(fig_dir, recursive = TRUE, showWarnings = FALSE)

catchment_dirs <- list.dirs(
  file.path(results_dir, "model_setups/catchments"),
  recursive = FALSE
)

# Load GOF metrics for annotation
metrics <- read.csv(file.path(repo, "tables", "gof_metrics.csv"))

# Period date boundaries
calib_start <- as.Date("2020-01-01")
calib_end   <- as.Date("2022-12-31")
valid_start <- as.Date("2023-01-01")
valid_end   <- as.Date("2023-12-31")

# -----------------------------------------------------------------------------
# Colour palette
# -----------------------------------------------------------------------------
col_obs    <- "#2c3e50"   # dark blue-grey for observed
col_sim    <- "#e74c3c"   # red for simulated
col_calib  <- "#d5e8d4"   # light green shading for calibration
col_valid  <- "#dae8fc"   # light blue shading for validation

# -----------------------------------------------------------------------------
# Helper: format metric value for annotation
# -----------------------------------------------------------------------------
fmt_metric <- function(x) {
  if (is.na(x)) return("NA") else sprintf("%.2f", x)
}

# -----------------------------------------------------------------------------
# Plot one gauge
# -----------------------------------------------------------------------------
plot_gauge <- function(dates, obs, sim, catchment_name, station_id,
                       subcatchment_id, metrics_df) {

  # Filter to plot window: 2019-01-01 to 2023-12-31
  mask <- dates >= as.Date("2019-01-01") & dates <= as.Date("2023-12-31")
  dates <- dates[mask]
  obs   <- obs[mask]
  sim   <- sim[mask]

  if (sum(!is.na(obs)) < 10) {
    message("  Skipping ", station_id, " — insufficient observed data")
    return(invisible(NULL))
  }

  # Pull metrics
  m_cal <- metrics_df[metrics_df$station_id == station_id &
                         metrics_df$period == "calibration", ]
  m_val <- metrics_df[metrics_df$station_id == station_id &
                         metrics_df$period == "validation", ]

  nse_cal  <- if (nrow(m_cal) > 0) fmt_metric(m_cal$NSE[1])  else "NA"
  kge_cal  <- if (nrow(m_cal) > 0) fmt_metric(m_cal$KGE[1])  else "NA"
  pb_cal   <- if (nrow(m_cal) > 0) fmt_metric(m_cal$PBIAS[1]) else "NA"
  nse_val  <- if (nrow(m_val) > 0) fmt_metric(m_val$NSE[1])  else "NA"
  kge_val  <- if (nrow(m_val) > 0) fmt_metric(m_val$KGE[1])  else "NA"
  pb_val   <- if (nrow(m_val) > 0) fmt_metric(m_val$PBIAS[1]) else "NA"

  # Y axis limits
  y_max <- max(c(obs, sim), na.rm = TRUE) * 1.15
  y_min <- 0

  # Output path
  out_path <- file.path(fig_dir,
    paste0(catchment_name, "_", station_id, ".png"))

  png(out_path, width = 1600, height = 700, res = 150)

  # Margins: bottom, left, top, right
  par(mar = c(4, 4.5, 3.5, 1.5), bg = "white")

  # Empty plot to set up axes
  plot(dates, obs,
       type = "n",
       xlim = range(dates),
       ylim = c(y_min, y_max),
       xlab = "",
       ylab = expression(Discharge~(m^3~s^{-1})),
       main = paste0(catchment_name, "  |  Station ", station_id,
                     "  (subcatchment ", subcatchment_id, ")"),
       cex.main = 0.95,
       cex.axis = 0.85,
       cex.lab  = 0.90,
       las = 1,
       xaxt = "n")

  # Shaded period backgrounds (draw before lines)
  rect(calib_start, y_min, calib_end, y_max * 10,
       col = col_calib, border = NA)
  rect(valid_start, y_min, valid_end, y_max * 10,
       col = col_valid, border = NA)

  # Period boundary lines
  abline(v = calib_start, col = "grey50", lty = 2, lwd = 0.8)
  abline(v = valid_start, col = "grey50", lty = 2, lwd = 0.8)
  abline(v = valid_end,   col = "grey50", lty = 2, lwd = 0.8)

  # Simulated line
  lines(dates, sim, col = col_sim, lwd = 1.2)

  # Observed line on top
  lines(dates, obs, col = col_obs, lwd = 1.4)

  # X axis with year ticks
  year_starts <- seq(as.Date("2019-01-01"), as.Date("2024-01-01"), by = "year")
  axis(1, at = year_starts, labels = format(year_starts, "%Y"),
       cex.axis = 0.85)

  # Period labels at top of shaded regions
  mtext("Warm-up", side = 3, at = as.Date("2019-07-01"),
        cex = 0.7, col = "grey40", line = 0.2)
  mtext("Calibration", side = 3, at = as.Date("2021-07-01"),
        cex = 0.7, col = "grey40", line = 0.2)
  mtext("Validation", side = 3, at = as.Date("2023-07-01"),
        cex = 0.7, col = "grey40", line = 0.2)

  # Metrics annotation box (bottom right)
  legend_text <- c(
    "Observed", "Simulated",
    paste0("Calibration:  NSE=", nse_cal,
           "  KGE=", kge_cal, "  PBIAS=", pb_cal, "%"),
    paste0("Validation:    NSE=", nse_val,
           "  KGE=", kge_val, "  PBIAS=", pb_val, "%")
  )
  legend("topright",
         legend = legend_text,
         lty    = c(1, 1, NA, NA),
         lwd    = c(1.4, 1.2, NA, NA),
         col    = c(col_obs, col_sim, NA, NA),
         cex    = 0.72,
         bty    = "o",
         bg     = "white",
         box.col = "grey70")

  # Box around plot
  box(col = "grey70")

  dev.off()
  message("  Saved: ", basename(out_path))
}

# -----------------------------------------------------------------------------
# Loop over all catchments
# -----------------------------------------------------------------------------
message("Plotting hydrographs...")

for (catch_dir in catchment_dirs) {
  catchment_name <- basename(catch_dir)
  csv_path <- file.path(catch_dir, "catch_data",
                        "calib_disch_data_results.csv")

  if (!file.exists(csv_path)) next

  message("Processing: ", catchment_name)

  df <- read.csv(csv_path)
  df$Date <- as.Date(df$Date)

  obs_cols <- grep("^X[0-9]", names(df), value = TRUE)
  sim_cols <- grep("^simulated_", names(df), value = TRUE)
  n_pairs  <- min(length(obs_cols), length(sim_cols))

  for (i in seq_len(n_pairs)) {
    station_id      <- sub("^X", "", obs_cols[i])
    subcatchment_id <- sub("^simulated_", "", sim_cols[i])

    plot_gauge(
      dates           = df$Date,
      obs             = df[[obs_cols[i]]],
      sim             = df[[sim_cols[i]]],
      catchment_name  = catchment_name,
      station_id      = station_id,
      subcatchment_id = subcatchment_id,
      metrics_df      = metrics
    )
  }
}

message("\nDone. Plots saved to: ", fig_dir)
message("Total PNGs: ", length(list.files(fig_dir, pattern = "\\.png$")))
