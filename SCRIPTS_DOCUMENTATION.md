# Analysis Scripts Documentation

**Project:** BalticSeaH2 T3.1 — Water availability for hydrogen production in southern Finland  
**Last updated:** April 2026

---

## Overview

The `scripts/` folder contains five R scripts that process the HYPE hydrological modelling results into tables, figures, and an interactive dashboard for the paper. The scripts are designed to be run in order, as later scripts depend on outputs from earlier ones.

```
scripts/
├── 01_compute_gof_metrics.R        ← Calibration/validation performance metrics
├── 02_aggregate_water_availability.R  ← Merge per-catchment GeoPackages region-wide
├── 03_plot_hydrographs.R           ← Observed vs simulated hydrograph plots
├── 03a_plot_hydrograph_compound.R  ← Compound figure of 6 representative gauges
├── 04_plot_seasonal_maps.R         ← Seasonal discharge maps (100 PNGs)
├── 04a_dashboard.R                 ← Interactive Shiny dashboard
└── 05_plot_scenario_comparison.R   ← Scenario delta maps (75 PNGs)
```

---

## Dependencies

All scripts require the following R packages:

```r
install.packages(c("sf", "rnaturalearth", "rnaturalearthdata", "shiny", "leaflet"))
```

---

## Script Descriptions

---

### `01_compute_gof_metrics.R`

**Purpose:** Compute goodness-of-fit metrics for all gauged catchments, split by calibration and validation periods.

**Input:**
- `Results/model_setups/catchments/{Name}/catch_data/calib_disch_data_results.csv` — paired observed and simulated daily discharge for all 27 catchments

**Output:**
- `tables/gof_metrics.csv` — one row per gauge per period with the following metrics:

| Metric | Description |
|---|---|
| NSE | Nash-Sutcliffe Efficiency — sensitive to high flows |
| logNSE | Log-transformed NSE — sensitive to low flows |
| KGE | Kling-Gupta Efficiency — decomposed into correlation, bias, variability |
| R² | Coefficient of determination |
| PBIAS | Percent bias (%) — positive = underestimation, negative = overestimation |
| RMSE | Root mean squared error (m³/s) |

**Periods:**

| Period | Dates | Role |
|---|---|---|
| Warm-up | 2019 | Excluded from metrics |
| Calibration | 2020–2022 | PEST objective function |
| Validation | 2023 | Independent performance check |

**Run with:**
```r
source("scripts/01_compute_gof_metrics.R")
```

---

### `02_aggregate_water_availability.R`

**Purpose:** Read the per-catchment `water_availability*.gpkg` files from all 27 catchments and merge them into 4 region-wide GeoPackages, one per scenario.

**Input:**
- `Results/model_setups/catchments/{Name}/catch_data/water_availability.gpkg` (×4 scenarios, ×27 catchments = 108 files)

**Output:**
- `Results/water_availability_region.gpkg` — baseline scenario, 1158 subcatchments
- `Results/water_availability_region_climate.gpkg` — climate change scenario
- `Results/water_availability_region_urban.gpkg` — urban growth scenario
- `Results/water_availability_region_combined.gpkg` — combined scenario

Each GeoPackage contains one row per subcatchment with seasonal and annual discharge statistics (min, Q10, median, mean, max) for winter, spring, summer, autumn, and annual periods, plus land cover fractions. CRS is ETRS89 / TM35FIN(E,N) (EPSG:3067).

**Note:** This script must be run before scripts 04, 04a, and 05.

**Run with:**
```r
source("scripts/02_aggregate_water_availability.R")
```

---

### `03_plot_hydrographs.R`

**Purpose:** Plot observed vs simulated daily discharge hydrographs for all gauged catchments, with calibration and validation periods marked by shaded backgrounds.

**Input:**
- `Results/model_setups/catchments/{Name}/catch_data/calib_disch_data_results.csv`
- `tables/gof_metrics.csv` (for metric annotation)

**Output:**
- `figures/hydrographs/{Catchment}_{StationID}.png` — one PNG per gauge (28 total)

Each plot shows:
- Dark line = observed discharge
- Red line = simulated discharge
- Green shading = calibration period (2020–2022)
- Blue shading = validation period (2023)
- NSE, KGE, PBIAS annotated in the top-right corner for both periods
- Plot window: 2019–2023 (includes warm-up year for context)

**Run with:**
```r
source("scripts/03_plot_hydrographs.R")
```

---

### `03a_plot_hydrograph_compound.R`

**Purpose:** Compound figure showing 6 representative gauges in a 3×2 grid, covering the full range of calibration performance from best to worst. Intended as a paper figure.

**Panel selection:**

| Panel | Catchment | Station | Calibration NSE |
|---|---|---|---|
| (a) | Vantaanjoki | 2101220 | 0.87 — best |
| (b) | Porvoonjoki | 1800500 | 0.80 — good |
| (c) | Siuntionjoki | 2200310 | 0.77 — good-medium |
| (d) | Koskenkylanjoki | 1600110 | 0.69 — medium |
| (e) | Sirppujoki | 3200400 | 0.33 — poor |
| (f) | Karjaanjoki | 2300100 | −0.67 — worst |

**Output:**
- `figures/hydrograph_compound.png` — 3600×2000px at 200 DPI (journal-ready)

**Run with:**
```r
source("scripts/03a_plot_hydrograph_compound.R")
```

---

### `04_plot_seasonal_maps.R`

**Purpose:** Choropleth maps of discharge statistics across all 1158 subcatchments for all combinations of scenario × season × statistic. Grey European country basemap with Gulf of Finland coastline included.

**Input:**
- `Results/water_availability_region*.gpkg` (4 files, from Script 02)

**Output:**
- `figures/maps/{scenario}_{season}_{stat}.png` — 100 PNGs total

**Combinations:**
- 4 scenarios × 5 seasons × 5 statistics = 100 maps
- Seasons: winter, spring, summer, autumn, annual
- Statistics: min, Q10, median, mean, max
- Colour scheme: light-to-dark blue (low to high discharge)
- Classification: quantile breaks, robust to zero-heavy distributions

**Run with:**
```r
source("scripts/04_plot_seasonal_maps.R")
```

---

### `04a_dashboard.R`

**Purpose:** Interactive Shiny dashboard for exploring water availability results. Intended for internal use and sharing with project partners.

**Input:**
- `Results/water_availability_region*.gpkg` (4 files)
- `tables/gof_metrics.csv`
- `Results/model_setups/catchments/{Name}/catch_data/calib_disch_data_results.csv`
- `Results/model_setups/catchments/{Name}/catch_data/disch_stations.gpkg`

**Features:**
- Interactive Leaflet map — click any subcatchment to select it
- Dropdowns for scenario, statistic, and season
- Seasonal statistics table and bar chart for selected subcatchment
- Nearest gauge hydrograph with calibration/validation shading and metrics
- Plain-language interpretation of selected values
- Q10 flagging for low water availability conditions

**Run with:**
```r
shiny::runApp("scripts/04a_dashboard.R")
```

---

### `05_plot_scenario_comparison.R`

**Purpose:** Delta maps showing percentage change from baseline for the climate, urban, and combined scenarios. Uses a diverging colour palette to highlight increases and decreases in discharge.

**Input:**
- `Results/water_availability_region*.gpkg` (4 files, from Script 02)

**Output:**
- `figures/maps_delta/{scenario}_{season}_{stat}_delta.png` — 75 PNGs total

**Combinations:**
- 3 scenarios (climate, urban, combined) × 5 seasons × 5 statistics = 75 maps
- Colour scheme: blue = increase, red = decrease, white = no change
- Scale: symmetric diverging breaks around zero based on max absolute % change
- Subcatchments where baseline = 0 and scenario > 0 are shown as grey (undefined % change)

**Run with:**
```r
source("scripts/05_plot_scenario_comparison.R")
```

---

## Suggested Run Order

```r
repo <- "C:/Users/KVZKARL/Source/Repos/BalticSeaH2_T3.1"

# Must run first — produces tables/gof_metrics.csv
source(file.path(repo, "scripts/01_compute_gof_metrics.R"))

# Must run second — produces region-wide GeoPackages used by 04, 04a, 05
source(file.path(repo, "scripts/02_aggregate_water_availability.R"))

# Can run in any order after 01 and 02
source(file.path(repo, "scripts/03_plot_hydrographs.R"))
source(file.path(repo, "scripts/03a_plot_hydrograph_compound.R"))
source(file.path(repo, "scripts/04_plot_seasonal_maps.R"))
source(file.path(repo, "scripts/05_plot_scenario_comparison.R"))

# Dashboard — run interactively
shiny::runApp(file.path(repo, "scripts/04a_dashboard.R"))
```

---

## Output Summary

| Location | Contents |
|---|---|
| `tables/` | `gof_metrics.csv` — calibration/validation performance for all gauges |
| `Results/` | 4 region-wide GeoPackages (one per scenario) |
| `figures/hydrographs/` | 28 hydrograph PNGs (one per gauge) |
| `figures/` | `hydrograph_compound.png` — journal-ready compound figure |
| `figures/maps/` | 100 seasonal discharge maps |
| `figures/maps_delta/` | 75 scenario delta maps |
