# =============================================================================
# 04_plot_seasonal_maps.R
# Choropleth maps of discharge statistics across all 1158 subcatchments for
# all combinations of scenario x season x statistic.
#
# Produces 100 PNGs saved to figures/maps/:
#   {scenario}_{season}_{statistic}.png
#
# Input:
#   Results/water_availability_region*.gpkg  (4 files)
#
# Output:
#   figures/maps/{scenario}_{season}_{stat}.png
# =============================================================================

library(sf)
library(rnaturalearth)

# -----------------------------------------------------------------------------
# Paths
# -----------------------------------------------------------------------------
repo        <- "C:/Users/KVZKARL/Source/Repos/BalticSeaH2_T3.1"
results_dir <- file.path(repo, "Results")
fig_dir     <- file.path(repo, "figures", "maps")
dir.create(fig_dir, recursive = TRUE, showWarnings = FALSE)

# -----------------------------------------------------------------------------
# Load all 4 region-wide GeoPackages
# -----------------------------------------------------------------------------
scenario_files <- list(
  baseline = "water_availability_region.gpkg",
  climate  = "water_availability_region_climate.gpkg",
  urban    = "water_availability_region_urban.gpkg",
  combined = "water_availability_region_combined.gpkg"
)

message("Loading region GeoPackages...")
wa <- lapply(names(scenario_files), function(s) {
  message("  ", s)
  st_read(file.path(results_dir, scenario_files[[s]]), quiet = TRUE)
})
names(wa) <- names(scenario_files)

# -----------------------------------------------------------------------------
# Basemap — Europe countries cropped to study area
# -----------------------------------------------------------------------------
message("Preparing basemap...")
europe      <- ne_countries(continent = "europe", scale = "medium", returnclass = "sf")
europe      <- st_transform(europe, 3067)

bbox         <- st_bbox(wa[["baseline"]])
bbox["xmin"] <- bbox["xmin"] - 60000
bbox["xmax"] <- bbox["xmax"] + 60000
bbox["ymin"] <- bbox["ymin"] - 90000
bbox["ymax"] <- bbox["ymax"] + 50000

europe_crop <- suppressWarnings(st_crop(europe, bbox))

# -----------------------------------------------------------------------------
# Labels and combinations
# -----------------------------------------------------------------------------
seasons <- c("winter", "spring", "summer", "autumn", "annual")
stats   <- c("min", "q10", "median", "mean", "max")

season_labels <- c(
  winter = "Winter (Dec-Feb)",
  spring = "Spring (Mar-May)",
  summer = "Summer (Jun-Aug)",
  autumn = "Autumn (Sep-Nov)",
  annual = "Annual"
)

stat_labels <- c(
  min    = "Minimum discharge",
  q10    = "Q10 — low-flow indicator",
  median = "Median discharge",
  mean   = "Mean discharge",
  max    = "Maximum discharge"
)

scenario_labels <- c(
  baseline = "Baseline (2020-2023)",
  climate  = "Climate change (SSP2-4.5, 2040-2069)",
  urban    = "Urban growth (to 2040)",
  combined = "Combined (climate + urban)"
)

# -----------------------------------------------------------------------------
# Colour palette
# -----------------------------------------------------------------------------
make_palette <- function(n = 9) {
  colorRampPalette(c("#f7fbff", "#c6dbef", "#6baed6",
                     "#2171b5", "#08306b"))(n)
}

# -----------------------------------------------------------------------------
# Classify values into quantile bins, robust to zero-heavy distributions
# -----------------------------------------------------------------------------
classify <- function(x, n = 9) {
  x_valid <- x[!is.na(x)]

  if (diff(range(x_valid)) == 0) {
    cls <- rep(1L, length(x))
    cls[is.na(x)] <- NA_integer_
    return(cls)
  }

  breaks <- unique(quantile(x_valid, probs = seq(0, 1, length.out = n + 1)))

  if (length(breaks) < 4) {
    x_pos <- x_valid[x_valid > 0]
    if (length(x_pos) == 0) {
      cls <- rep(1L, length(x))
      cls[is.na(x)] <- NA_integer_
      return(cls)
    }
    breaks <- sort(unique(c(0, quantile(x_pos,
                                        probs = seq(0, 1, length.out = n),
                                        na.rm = TRUE))))
  }

  cut(x, breaks = breaks, include.lowest = TRUE, labels = FALSE)
}

# -----------------------------------------------------------------------------
# Plot one map
# -----------------------------------------------------------------------------
plot_map <- function(sf_obj, col_name, title, subtitle, out_path) {

  vals     <- sf_obj[[col_name]]
  cls      <- classify(vals, n = 9)
  n_actual <- max(cls, na.rm = TRUE)
  pal      <- make_palette(n_actual)
  colors   <- pal[cls]
  colors[is.na(cls)] <- "grey85"

  # Legend labels
  breaks_leg <- unique(quantile(vals, probs = seq(0, 1, length.out = 10),
                                na.rm = TRUE))
  fmt <- function(x) ifelse(x < 0.01, sprintf("%.4f", x),
                     ifelse(x < 1,    sprintf("%.3f", x),
                                      sprintf("%.2f", x)))
  leg_labels <- paste0(fmt(breaks_leg[-length(breaks_leg)]),
                       " – ", fmt(breaks_leg[-1]))
  leg_cols   <- make_palette(length(leg_labels))

  # Canvas — landscape
  png(out_path, width = 2400, height = 1200, res = 180)
  par(mar = c(0.5, 0.5, 2.8, 0.5), bg = "white")

  # Background countries
  plot(st_geometry(europe_crop),
       col    = "grey92",
       border = "grey70",
       lwd    = 0.5,
       xlim   = c(bbox["xmin"], bbox["xmax"]),
       ylim   = c(bbox["ymin"], bbox["ymax"]),
       axes   = FALSE)

  # Subcatchments coloured by statistic
  plot(st_geometry(sf_obj), col = colors, border = NA, add = TRUE)

  # Subtle subcatchment outlines
  plot(st_geometry(sf_obj), col = NA, border = "#ffffff30",
       lwd = 0.12, add = TRUE)

  # Titles
  mtext(title,    side = 3, line = 1.4, cex = 0.95, font = 2)
  mtext(subtitle, side = 3, line = 0.3, cex = 0.75, col = "grey30")

  # Legend
  legend(
    x       = bbox["xmax"] - (bbox["xmax"] - bbox["xmin"]) * 0.20,
    y       = bbox["ymin"] + (bbox["ymax"] - bbox["ymin"]) * 0.55,
    legend  = leg_labels,
    fill    = leg_cols,
    border  = NA,
    title   = expression(m^3~s^{-1}),
    cex     = 0.58,
    bty     = "o",
    bg      = "white",
    box.col = "grey70",
    title.cex = 0.65
  )

  # North arrow

  # Scale bar

  box(col = "grey70")
  dev.off()
}

# -----------------------------------------------------------------------------
# Main loop — 100 maps
# -----------------------------------------------------------------------------
total <- length(scenario_files) * length(seasons) * length(stats)
count <- 0
message("Generating ", total, " maps...")

for (scenario_name in names(scenario_files)) {
  sf_obj <- wa[[scenario_name]]
  for (season in seasons) {
    for (stat in stats) {
      col_name <- paste0(season, "_", stat)
      if (!col_name %in% names(sf_obj)) next
      count    <- count + 1
      out_path <- file.path(fig_dir,
                            paste0(scenario_name, "_", season, "_", stat, ".png"))
      plot_map(sf_obj, col_name,
               title    = paste0(season_labels[season], "  |  ", stat_labels[stat]),
               subtitle = scenario_labels[scenario_name],
               out_path = out_path)
      if (count %% 10 == 0) message("  ", count, "/", total, " done...")
    }
  }
}

message("\nDone. ", count, " maps saved to: ", fig_dir)
