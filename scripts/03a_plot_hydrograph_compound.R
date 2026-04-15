# =============================================================================
# 03a_plot_hydrograph_compound.R
# Compound figure showing 6 representative gauges in a 3x2 grid, covering
# the range of calibration performance from best to worst.
#
# Panel selection (by NSE calibration):
#   A - Vantaanjoki    2101220  NSE=0.87  (best)
#   B - Porvoonjoki    1800500  NSE=0.80  (good)
#   C - Siuntionjoki   2200310  NSE=0.77  (good-medium)
#   D - Koskenkylanjoki 1600110 NSE=0.69  (medium)
#   E - Sirppujoki     3200400  NSE=0.33  (poor)
#   F - Karjaanjoki    2300100  NSE=-0.67 (worst)
#
# Output:
#   figures/hydrograph_compound.png
# =============================================================================

library(sf)

# -----------------------------------------------------------------------------
# Paths
# -----------------------------------------------------------------------------
repo        <- "C:/Users/KVZKARL/Source/Repos/BalticSeaH2_T3.1"
results_dir <- file.path(repo, "Results")
fig_dir     <- file.path(repo, "figures")

metrics <- read.csv(file.path(repo, "tables", "gof_metrics.csv"))

# -----------------------------------------------------------------------------
# Panel definitions
# -----------------------------------------------------------------------------
panels <- list(
  list(catchment = "Vantaanjoki",     station = "2101220", subcatch = "1071"),
  list(catchment = "Porvoonjoki",     station = "1800500", subcatch = "1065"),
  list(catchment = "Siuntionjoki",    station = "2200310", subcatch = "1016"),
  list(catchment = "Koskenkylanjoki", station = "1600110", subcatch = "1023"),
  list(catchment = "Sirppujoki",      station = "3200400", subcatch = "1019"),
  list(catchment = "Karjaanjoki",     station = "2300100", subcatch = "1063")
)

panel_labels <- c("(a)", "(b)", "(c)", "(d)", "(e)", "(f)")

# Period boundaries
calib_start <- as.Date("2020-01-01")
calib_end   <- as.Date("2022-12-31")
valid_start <- as.Date("2023-01-01")
valid_end   <- as.Date("2023-12-31")
plot_start  <- as.Date("2019-01-01")
plot_end    <- as.Date("2023-12-31")

# Colours
col_obs   <- "#2c3e50"
col_sim   <- "#e74c3c"
col_calib <- "#d5e8d4"
col_valid <- "#dae8fc"

# -----------------------------------------------------------------------------
# Helper: load discharge data for one panel
# -----------------------------------------------------------------------------
load_panel_data <- function(p) {
  csv_path <- file.path(results_dir, "model_setups/catchments",
                        p$catchment, "catch_data",
                        "calib_disch_data_results.csv")
  df       <- read.csv(csv_path)
  df$Date  <- as.Date(df$Date)

  obs_col  <- paste0("X", p$station)
  sim_col  <- paste0("simulated_", p$subcatch)

  mask     <- df$Date >= plot_start & df$Date <= plot_end

  list(
    dates = df$Date[mask],
    obs   = df[[obs_col]][mask],
    sim   = df[[sim_col]][mask]
  )
}

# -----------------------------------------------------------------------------
# Helper: get metric string for annotation
# -----------------------------------------------------------------------------
get_metrics <- function(station_id, period) {
  m <- metrics[metrics$station_id == station_id &
               metrics$period == period, ]
  if (nrow(m) == 0) return("NSE=NA  KGE=NA")
  sprintf("NSE=%s  KGE=%s  PBIAS=%s%%",
          ifelse(is.na(m$NSE[1]),   "NA", sprintf("%.2f", m$NSE[1])),
          ifelse(is.na(m$KGE[1]),   "NA", sprintf("%.2f", m$KGE[1])),
          ifelse(is.na(m$PBIAS[1]), "NA", sprintf("%.1f", m$PBIAS[1])))
}

# -----------------------------------------------------------------------------
# Draw compound figure
# -----------------------------------------------------------------------------
out_path <- file.path(fig_dir, "hydrograph_compound.png")

png(out_path, width = 3600, height = 2000, res = 200)

par(
  mfrow  = c(2, 3),
  mar    = c(3.2, 4.0, 2.8, 0.8),
  oma    = c(1, 0, 0, 0),
  bg     = "white"
)

for (i in seq_along(panels)) {
  p    <- panels[[i]]
  data <- load_panel_data(p)

  y_max <- max(c(data$obs, data$sim), na.rm = TRUE) * 1.18
  y_min <- 0

  # Base plot
  plot(data$dates, data$obs,
       type = "n",
       xlim = c(plot_start, plot_end),
       ylim = c(y_min, y_max),
       xlab = "",
       ylab = expression(Q~(m^3~s^{-1})),
       main = paste0(panel_labels[i], "  ", p$catchment,
                     "  [", p$station, "]"),
       cex.main = 0.88,
       cex.axis = 0.78,
       cex.lab  = 0.82,
       las  = 1,
       xaxt = "n")

  # Shaded backgrounds
  rect(calib_start, -1, calib_end, y_max * 10,
       col = col_calib, border = NA)
  rect(valid_start, -1, valid_end, y_max * 10,
       col = col_valid, border = NA)

  # Period boundary lines
  abline(v = c(calib_start, valid_start, valid_end),
         col = "grey60", lty = 2, lwd = 0.7)

  # Simulated then observed
  lines(data$dates, data$sim, col = col_sim, lwd = 1.1)
  lines(data$dates, data$obs, col = col_obs, lwd = 1.3)

  # X axis
  year_starts <- seq(as.Date("2019-01-01"), as.Date("2024-01-01"), by = "year")
  axis(1, at = year_starts, labels = format(year_starts, "%Y"),
       cex.axis = 0.78)

  # Period labels
  mtext("Warm-up",     side = 3, at = as.Date("2019-07-01"),
        cex = 0.58, col = "grey45", line = 0.15)
  mtext("Calibration", side = 3, at = as.Date("2021-04-01"),
        cex = 0.58, col = "grey45", line = 0.15)
  mtext("Val.",        side = 3, at = as.Date("2023-04-01"),
        cex = 0.58, col = "grey45", line = 0.15)

  # Metrics annotation — calibration and validation
  cal_str <- get_metrics(p$station, "calibration")
  val_str <- get_metrics(p$station, "validation")

  legend("topright",
         legend = c("Observed", "Simulated",
                    paste0("Cal: ", cal_str),
                    paste0("Val: ", val_str)),
         lty    = c(1, 1, NA, NA),
         lwd    = c(1.3, 1.1, NA, NA),
         col    = c(col_obs, col_sim, NA, NA),
         cex    = 0.60,
         bty    = "o",
         bg     = "white",
         box.col = "grey70")

  box(col = "grey70")
}

dev.off()
message("Saved: ", out_path)
