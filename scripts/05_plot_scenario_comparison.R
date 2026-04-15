# =============================================================================
# 05_plot_scenario_comparison.R
# Delta maps showing percentage change from baseline for climate, urban and
# combined scenarios. One PNG per scenario x season x statistic = 75 maps.
#
# Colour scheme: blue = increase, red = decrease, white = no change
#
# Input:
#   Results/water_availability_region*.gpkg  (4 files)
#
# Output:
#   figures/maps_delta/{scenario}_{season}_{stat}_delta.png
# =============================================================================

library(sf)
library(rnaturalearth)

# -----------------------------------------------------------------------------
# Paths
# -----------------------------------------------------------------------------
repo        <- "C:/Users/KVZKARL/Source/Repos/BalticSeaH2_T3.1"
results_dir <- file.path(repo, "Results")
fig_dir     <- file.path(repo, "figures", "maps_delta")
dir.create(fig_dir, recursive = TRUE, showWarnings = FALSE)

# -----------------------------------------------------------------------------
# Load all 4 scenarios
# -----------------------------------------------------------------------------
scenario_files <- list(
  baseline = "water_availability_region.gpkg",
  climate  = "water_availability_region_climate.gpkg",
  urban    = "water_availability_region_urban.gpkg",
  combined = "water_availability_region_combined.gpkg"
)

message("Loading GeoPackages...")
wa <- lapply(names(scenario_files), function(s) {
  message("  ", s)
  st_read(file.path(results_dir, scenario_files[[s]]), quiet = TRUE)
})
names(wa) <- names(scenario_files)

# -----------------------------------------------------------------------------
# Basemap
# -----------------------------------------------------------------------------
message("Preparing basemap...")
europe      <- ne_countries(continent = "europe", scale = "medium",
                            returnclass = "sf")
europe      <- st_transform(europe, 3067)
bbox        <- st_bbox(wa[["baseline"]])
bbox["xmin"] <- bbox["xmin"] - 60000
bbox["xmax"] <- bbox["xmax"] + 60000
bbox["ymin"] <- bbox["ymin"] - 90000
bbox["ymax"] <- bbox["ymax"] + 50000
europe_crop <- suppressWarnings(st_crop(europe, bbox))

# -----------------------------------------------------------------------------
# Labels
# -----------------------------------------------------------------------------
seasons <- c("winter", "spring", "summer", "autumn", "annual")
stats   <- c("min", "q10", "median", "mean", "max")
delta_scenarios <- c("climate", "urban", "combined")

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
  climate  = "Climate change (SSP2-4.5, 2040-2069) vs Baseline",
  urban    = "Urban growth (to 2040) vs Baseline",
  combined = "Combined (climate + urban) vs Baseline"
)

# -----------------------------------------------------------------------------
# Diverging palette — blue = increase, red = decrease, white = zero
# -----------------------------------------------------------------------------
diverging_pal <- function(n = 11) {
  colorRampPalette(c("#d73027", "#f46d43", "#fdae61", "#fee090",
                     "#ffffff",
                     "#e0f3f8", "#abd9e9", "#74add1", "#4575b4"))(n)
}

classify_delta <- function(x, n = 11) {
  # Symmetric breaks around zero based on max absolute value
  max_abs <- max(abs(x), na.rm = TRUE)
  if (max_abs == 0) {
    return(list(cls = rep(ceiling(n / 2), length(x)), breaks = seq(-1, 1, length.out = n + 1)))
  }
  # Round up to a nice number
  lim    <- ceiling(max_abs / 10) * 10
  breaks <- seq(-lim, lim, length.out = n + 1)
  cls    <- cut(x, breaks = breaks, include.lowest = TRUE, labels = FALSE)
  list(cls = cls, breaks = breaks)
}

# -----------------------------------------------------------------------------
# Plot one delta map
# -----------------------------------------------------------------------------
plot_delta_map <- function(delta_vals, title, subtitle, out_path) {

  n_cols  <- 11
  result  <- classify_delta(delta_vals, n = n_cols)
  cls     <- result$cls
  breaks  <- result$breaks
  pal     <- diverging_pal(n_cols)
  colors  <- pal[cls]
  colors[is.na(cls)] <- "grey85"

  # Legend labels
  fmt <- function(x) sprintf("%+.1f%%", x)
  leg_labels <- paste0(fmt(breaks[-length(breaks)]), " to ", fmt(breaks[-1]))
  leg_cols   <- diverging_pal(length(leg_labels))

  # Canvas
  png(out_path, width = 2400, height = 1200, res = 180)
  par(mar = c(0.5, 0.5, 2.8, 0.5), bg = "white")

  # Basemap
  plot(st_geometry(europe_crop),
       col    = "grey92",
       border = "grey70",
       lwd    = 0.5,
       xlim   = c(bbox["xmin"], bbox["xmax"]),
       ylim   = c(bbox["ymin"], bbox["ymax"]),
       axes   = FALSE)

  # Delta choropleth
  plot(st_geometry(wa[["baseline"]]),
       col    = colors,
       border = NA,
       add    = TRUE)

  # Subtle outlines
  plot(st_geometry(wa[["baseline"]]),
       col    = NA,
       border = "#ffffff30",
       lwd    = 0.12,
       add    = TRUE)

  # Titles
  mtext(title,    side = 3, line = 1.4, cex = 0.95, font = 2)
  mtext(subtitle, side = 3, line = 0.3, cex = 0.75, col = "grey30")

  # Legend
  legend(
    x       = bbox["xmax"] - (bbox["xmax"] - bbox["xmin"]) * 0.22,
    y       = bbox["ymin"] + (bbox["ymax"] - bbox["ymin"]) * 0.60,
    legend  = leg_labels,
    fill    = leg_cols,
    border  = NA,
    title   = "% change",
    cex     = 0.55,
    bty     = "o",
    bg      = "white",
    box.col = "grey70",
    title.cex = 0.62
  )

  # Zero reference note
  mtext("Blue = increase  |  Red = decrease  |  White = no change",
        side = 1, line = -1, cex = 0.62, col = "grey40")

  box(col = "grey70")
  dev.off()
}

# -----------------------------------------------------------------------------
# Main loop — 3 scenarios x 5 seasons x 5 stats = 75 maps
# -----------------------------------------------------------------------------
total <- length(delta_scenarios) * length(seasons) * length(stats)
count <- 0

message("Generating ", total, " delta maps...")

for (scenario_name in delta_scenarios) {
  sf_scen <- wa[[scenario_name]]
  sf_base <- wa[["baseline"]]

  for (season in seasons) {
    for (stat in stats) {

      col_name <- paste0(season, "_", stat)
      if (!col_name %in% names(sf_scen)) next

      base_vals  <- as.numeric(sf_base[[col_name]])
      scen_vals  <- as.numeric(sf_scen[[col_name]])

      # % change — handle zeros in baseline gracefully
      delta <- ifelse(
        is.na(base_vals) | is.na(scen_vals),
        NA_real_,
        ifelse(
          base_vals == 0,
          ifelse(scen_vals == 0, 0, NA_real_),  # 0->0 = 0%, 0->x = undefined
          (scen_vals - base_vals) / base_vals * 100
        )
      )

      count    <- count + 1
      title    <- paste0(season_labels[season], "  |  ", stat_labels[stat],
                         "  |  % change from baseline")
      subtitle <- scenario_labels[scenario_name]
      fname    <- paste0(scenario_name, "_", season, "_", stat, "_delta.png")
      out_path <- file.path(fig_dir, fname)

      plot_delta_map(delta, title, subtitle, out_path)

      if (count %% 10 == 0) message("  ", count, "/", total, " done...")
    }
  }
}

message("\nDone. ", count, " delta maps saved to: ", fig_dir)
