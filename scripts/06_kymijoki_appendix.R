# =============================================================================
# 06_kymijoki_appendix.R
# Standalone analysis for the Kymijoki catchment appendix (Appendix B in the
# manuscript). Kymijoki is NOT one of the 27 primary calibration catchments —
# it is heavily regulated by a cascade of hydropower plants, was excluded
# from the PEST multi-catchment calibration, and no observed discharge was
# used to constrain the model here. The regionally calibrated parameter set
# (from the 27 southern Finnish catchments) was instead applied to Kymijoki's
# own subcatchment delineation to produce a first-order estimate of natural
# (unregulated) water availability.
#
# This script is intentionally NOT part of the run_all.R pipeline and does
# NOT feed into the main 1,158-subcatchment regional statistics — Kymijoki
# is reported separately, in its own appendix section, with explicit caveats.
#
# Input:
#   Results/model_setups/catchments/Kymijoki/catch_data/water_availability*.gpkg
#   (4 scenario files: baseline, climate, urban, combined — delivered
#   separately, not produced by this repo's HYPE/PEST pipeline)
#
# Output:
#   tables/kymijoki_q10_summary.csv       — baseline seasonal Q10 summary
#   tables/kymijoki_delta_summary.csv     — scenario delta summary (summer/winter)
#   figures_manuscript/figB1_kymijoki_baseline_summer_q10.png
#   figures_manuscript/figB2_kymijoki_climate_summer_q10_delta.png
# =============================================================================

library(sf)
library(rnaturalearth)

repo        <- "C:/Users/KVZKARL/Source/Repos/BalticSeaH2_T3.1"
kymi_dir    <- file.path(repo, "Results/model_setups/catchments/Kymijoki/catch_data")
tables_dir  <- file.path(repo, "tables")
fig_dir     <- file.path(repo, "figures_manuscript")

# -----------------------------------------------------------------------------
# Load scenarios
# -----------------------------------------------------------------------------
message("Loading Kymijoki GeoPackages...")
scenario_files <- list(
  baseline = "water_availability.gpkg",
  climate  = "water_availability_climate.gpkg",
  urban    = "water_availability_urban.gpkg",
  combined = "water_availability_combined.gpkg"
)
wa <- lapply(scenario_files, function(f) st_read(file.path(kymi_dir, f), quiet = TRUE))
names(wa) <- names(scenario_files)

base <- wa[["baseline"]]
n_total <- nrow(base)
n_valid <- sum(!is.na(base$annual_q10))
area_km2_total <- sum(as.numeric(st_area(base)), na.rm = TRUE) / 1e6

message(sprintf("Subcatchments: %d total, %d with valid discharge statistics", n_total, n_valid))
message(sprintf("Total catchment area: %.0f km2", area_km2_total))

# -----------------------------------------------------------------------------
# 1. Baseline seasonal Q10 summary table
# -----------------------------------------------------------------------------
seasons <- c("winter", "spring", "summer", "autumn", "annual")
q10_summary <- do.call(rbind, lapply(seasons, function(s) {
  col <- paste0(s, "_q10")
  x   <- base[[col]][!is.na(base[[col]])]
  data.frame(
    season        = s,
    n             = length(x),
    median_q10    = round(median(x), 4),
    p10_q10       = round(quantile(x, 0.10, names = FALSE), 4),
    p90_q10       = round(quantile(x, 0.90, names = FALSE), 4),
    n_below_0.05  = sum(x < 0.05),
    pct_below_0.05 = round(100 * mean(x < 0.05), 1)
  )
}))
print(q10_summary)
write.csv(q10_summary, file.path(tables_dir, "kymijoki_q10_summary.csv"), row.names = FALSE)
message("Written: tables/kymijoki_q10_summary.csv")

# -----------------------------------------------------------------------------
# 2. Scenario delta summary (summer + winter Q10, climate/urban/combined)
# -----------------------------------------------------------------------------
compute_delta_stats <- function(base_vals, scen_vals) {
  valid <- !is.na(base_vals) & !is.na(scen_vals) & base_vals > 0
  delta <- (scen_vals[valid] - base_vals[valid]) / base_vals[valid] * 100
  data.frame(
    n              = length(delta),
    median_pct     = round(median(delta), 1),
    p10_pct        = round(quantile(delta, 0.10, names = FALSE), 1),
    p90_pct        = round(quantile(delta, 0.90, names = FALSE), 1),
    pct_decreasing = round(100 * mean(delta < 0), 1),
    pct_increasing = round(100 * mean(delta > 0), 1)
  )
}

delta_summary <- do.call(rbind, lapply(c("summer", "winter"), function(season) {
  col <- paste0(season, "_q10")
  do.call(rbind, lapply(c("climate", "urban", "combined"), function(scen) {
    stats <- compute_delta_stats(base[[col]], wa[[scen]][[col]])
    cbind(season = season, scenario = scen, stats)
  }))
}))
print(delta_summary)
write.csv(delta_summary, file.path(tables_dir, "kymijoki_delta_summary.csv"), row.names = FALSE)
message("Written: tables/kymijoki_delta_summary.csv")

# -----------------------------------------------------------------------------
# Basemap — Europe countries cropped to Kymijoki's (larger, more northerly)
# extent, since it extends well north of the main 27-catchment domain
# -----------------------------------------------------------------------------
message("Preparing basemap...")
europe <- ne_countries(continent = "europe", scale = "medium", returnclass = "sf")
europe <- st_transform(europe, 3067)

bbox <- st_bbox(base)
bbox["xmin"] <- bbox["xmin"] - 40000
bbox["xmax"] <- bbox["xmax"] + 40000
bbox["ymin"] <- bbox["ymin"] - 40000
bbox["ymax"] <- bbox["ymax"] + 40000
europe_crop <- suppressWarnings(st_crop(europe, bbox))

# -----------------------------------------------------------------------------
# Colour palettes and classification (identical logic to scripts 04/05, for
# visual consistency with the main-text figures)
# -----------------------------------------------------------------------------
make_palette <- function(n = 9) {
  colorRampPalette(c("#f7fbff", "#c6dbef", "#6baed6", "#2171b5", "#08306b"))(n)
}
diverging_pal <- function(n = 11) {
  colorRampPalette(c("#d73027", "#f46d43", "#fdae61", "#fee090",
                     "#ffffff",
                     "#e0f3f8", "#abd9e9", "#74add1", "#4575b4"))(n)
}

classify <- function(x, n = 9) {
  x_valid <- x[!is.na(x)]
  if (diff(range(x_valid)) == 0) {
    cls <- rep(1L, length(x)); cls[is.na(x)] <- NA_integer_
    return(cls)
  }
  breaks <- unique(quantile(x_valid, probs = seq(0, 1, length.out = n + 1)))
  if (length(breaks) < 4) {
    x_pos <- x_valid[x_valid > 0]
    if (length(x_pos) == 0) {
      cls <- rep(1L, length(x)); cls[is.na(x)] <- NA_integer_
      return(cls)
    }
    breaks <- sort(unique(c(0, quantile(x_pos, probs = seq(0, 1, length.out = n), na.rm = TRUE))))
  }
  cut(x, breaks = breaks, include.lowest = TRUE, labels = FALSE)
}

classify_delta <- function(x, n = 11) {
  max_abs <- max(abs(x), na.rm = TRUE)
  if (max_abs == 0) {
    return(list(cls = rep(ceiling(n / 2), length(x)), breaks = seq(-1, 1, length.out = n + 1)))
  }
  lim    <- ceiling(max_abs / 10) * 10
  breaks <- seq(-lim, lim, length.out = n + 1)
  cls    <- cut(x, breaks = breaks, include.lowest = TRUE, labels = FALSE)
  list(cls = cls, breaks = breaks)
}

# -----------------------------------------------------------------------------
# Figure B1 — baseline summer Q10 map
# -----------------------------------------------------------------------------
message("Plotting Figure B1: baseline summer Q10...")
vals     <- base$summer_q10
cls      <- classify(vals, n = 9)
n_actual <- max(cls, na.rm = TRUE)
pal      <- make_palette(n_actual)
colors   <- pal[cls]
colors[is.na(cls)] <- "grey85"

breaks_leg <- unique(quantile(vals, probs = seq(0, 1, length.out = 10), na.rm = TRUE))
fmt <- function(x) ifelse(x < 0.01, sprintf("%.4f", x),
                   ifelse(x < 1,    sprintf("%.3f", x), sprintf("%.2f", x)))
leg_labels <- paste0(fmt(breaks_leg[-length(breaks_leg)]), " - ", fmt(breaks_leg[-1]))
leg_cols   <- make_palette(length(leg_labels))

out_path <- file.path(fig_dir, "figB1_kymijoki_baseline_summer_q10.png")
png(out_path, width = 1500, height = 2100, res = 180)
par(mar = c(0.5, 0.5, 2.8, 0.5), bg = "white")
plot(st_geometry(europe_crop), col = "grey92", border = "grey70", lwd = 0.5,
     xlim = c(bbox["xmin"], bbox["xmax"]), ylim = c(bbox["ymin"], bbox["ymax"]), axes = FALSE)
plot(st_geometry(base), col = colors, border = NA, add = TRUE)
plot(st_geometry(base), col = NA, border = "#ffffff30", lwd = 0.12, add = TRUE)
mtext("Kymijoki catchment: baseline summer (Jun-Aug) Q10 discharge", side = 3, line = 1.4, cex = 0.95, font = 2)
mtext("Regionally calibrated parameter set applied to Kymijoki (not independently calibrated)", side = 3, line = 0.3, cex = 0.68, col = "grey30")
legend(x = bbox["xmax"] - (bbox["xmax"] - bbox["xmin"]) * 0.24,
       y = bbox["ymin"] + (bbox["ymax"] - bbox["ymin"]) * 0.50,
       legend = leg_labels, fill = leg_cols, border = NA,
       title = expression(m^3~s^{-1}), cex = 0.60, bty = "o", bg = "white",
       box.col = "grey70", title.cex = 0.68)
box(col = "grey70")
dev.off()
message("  Saved: ", out_path)

# -----------------------------------------------------------------------------
# Figure B2 — climate change summer Q10 delta map
# -----------------------------------------------------------------------------
message("Plotting Figure B2: climate summer Q10 delta...")
base_vals <- as.numeric(base$summer_q10)
scen_vals <- as.numeric(wa[["climate"]]$summer_q10)
delta <- ifelse(is.na(base_vals) | is.na(scen_vals), NA_real_,
          ifelse(base_vals == 0, ifelse(scen_vals == 0, 0, NA_real_),
                 (scen_vals - base_vals) / base_vals * 100))

n_cols <- 11
result <- classify_delta(delta, n = n_cols)
cls    <- result$cls
breaks <- result$breaks
pal    <- diverging_pal(n_cols)
colors <- pal[cls]
colors[is.na(cls)] <- "grey85"

fmt2 <- function(x) sprintf("%+.1f%%", x)
leg_labels2 <- paste0(fmt2(breaks[-length(breaks)]), " to ", fmt2(breaks[-1]))
leg_cols2   <- diverging_pal(length(leg_labels2))

out_path2 <- file.path(fig_dir, "figB2_kymijoki_climate_summer_q10_delta.png")
png(out_path2, width = 1500, height = 2100, res = 180)
par(mar = c(0.5, 0.5, 2.8, 0.5), bg = "white")
plot(st_geometry(europe_crop), col = "grey92", border = "grey70", lwd = 0.5,
     xlim = c(bbox["xmin"], bbox["xmax"]), ylim = c(bbox["ymin"], bbox["ymax"]), axes = FALSE)
plot(st_geometry(base), col = colors, border = NA, add = TRUE)
plot(st_geometry(base), col = NA, border = "#ffffff30", lwd = 0.12, add = TRUE)
mtext("Kymijoki catchment: change in summer Q10 under SSP2-4.5 (2040-2069) vs baseline", side = 3, line = 1.4, cex = 0.95, font = 2)
mtext("Regionally calibrated parameter set applied to Kymijoki (not independently calibrated)", side = 3, line = 0.3, cex = 0.68, col = "grey30")
legend(x = bbox["xmax"] - (bbox["xmax"] - bbox["xmin"]) * 0.26,
       y = bbox["ymin"] + (bbox["ymax"] - bbox["ymin"]) * 0.55,
       legend = leg_labels2, fill = leg_cols2, border = NA,
       title = "% change", cex = 0.58, bty = "o", bg = "white",
       box.col = "grey70", title.cex = 0.65)
mtext("Blue = increase  |  Red = decrease  |  White = no change", side = 1, line = -1, cex = 0.62, col = "grey40")
box(col = "grey70")
dev.off()
message("  Saved: ", out_path2)

message("\nDone.")
