# Analysis Scripts Documentation

**Project:** BalticSeaH2 T3.1 — Water availability for hydrogen production in southern Finland  
**Last updated:** August 2026 (validation period corrected — see [REVIEWS.md](REVIEWS.md))

---

## Overview

The `scripts/` folder contains R scripts that process the HYPE hydrological modelling results into tables, figures, and an interactive dashboard for the paper, plus a standalone audit/verification script. Scripts `01`–`05` are designed to be run in order, as later scripts depend on outputs from earlier ones; `00_verify_q10_period.R` is independent and can be run at any time.

```
scripts/
├── 00_verify_q10_period.R          ← Audit: empirically verifies the Q10 statistics' date range
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

### `00_verify_q10_period.R`

**Purpose:** Audit script (added 2026-08-25, see [REVIEWS.md](REVIEWS.md) item R3) that empirically verifies which date range was used to compute the seasonal Q10 discharge statistics in `water_availability*.gpkg`. This was needed because those statistics are produced by an external Python pipeline not included in this repository, so its source could not be read directly.

**Method:** For a random sample of subcatchments per catchment, it (1) robustly maps `water_availability.gpkg` rows to raw HYPE output files by joining on subcatchment area (`GeoData.txt` `AREA` vs `subcatchments.gpkg` `Shape_STAr` — **not** by assuming row order, which was tried first and produced spurious mismatches), (2) recomputes winter/summer/annual Q10 directly from `hype_data_subcatchments/000XXXX.txt` over several candidate date ranges, and (3) checks which candidate reproduces the recorded values to within 0.001 m³/s.

**Result:** the full HYPE run period (2016-01-01 to 2025-12-31) matched exactly for every subcatchment tested (45/45 across 15 gauged catchments), with zero matches for any shorter candidate (including the "2019–2023" window previously — and incorrectly — described in the documentation and an earlier manuscript draft). No regeneration of `water_availability*.gpkg` was necessary; only the documentation wording was corrected.

**Input:**
- `Results/model_setups/catchments/{Name}/hype_data_subcatchments/GeoData.txt`, `000XXXX.txt` (raw HYPE output)
- `Results/model_setups/catchments/{Name}/catch_data/water_availability.gpkg`, `subcatchments.gpkg`

**Output:**
- Console summary of match rates per candidate period
- `tables/q10_period_verification.csv` — per-subcatchment match results

**Run with:**
```r
source("scripts/00_verify_q10_period.R")
# or from the command line:
# Rscript scripts/00_verify_q10_period.R                          # all catchments, 4 samples each
# Rscript scripts/00_verify_q10_period.R Aurajoki Karjaanjoki      # specific catchments
# Rscript scripts/00_verify_q10_period.R --n-samples 10            # more samples per catchment
```

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

**Periods (revised 2026-08-25 — see [REVIEWS.md](REVIEWS.md) items R1 and R5):**

| Period | Dates | Role |
|---|---|---|
| Warm-up | 2016 | Excluded from metrics (HYPE run spans 2016-01-01 to 2025-12-31) |
| Calibration | 2017–2022 | PEST objective function (corrected 2026-08-25 from an initially assumed 2020–2022 — see [REVIEWS.md](REVIEWS.md) item R5; verified directly against PEST control file observation weights) |
| Validation | 2023–2025 | Independent performance check (extended from 2023-only — see REVIEWS.md) |

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
- Green shading = calibration period (2017–2022)
- Blue shading = validation period (2023–2025)
- NSE, KGE, PBIAS annotated in the top-right corner for both periods
- Plot window: 2019–2025 (includes warm-up year for context)

**Run with:**
```r
source("scripts/03_plot_hydrographs.R")
```

---

### `03a_plot_hydrograph_compound.R`

**Purpose:** Compound figure showing 6 representative gauges in a 3×2 grid, covering the full range of calibration performance from best to worst. Intended as a paper figure.

**Panel selection (calibration NSE over the corrected 2017–2022 window — see [REVIEWS.md](REVIEWS.md) item R5):**

| Panel | Catchment | Station | Calibration NSE |
|---|---|---|---|
| (a) | Vantaanjoki | 2101220 | 0.88 — best |
| (b) | Porvoonjoki | 1800500 | 0.82 — good |
| (c) | Siuntionjoki | 2200310 | 0.78 — good-medium |
| (d) | Koskenkylanjoki | 1600110 | 0.75 — medium |
| (e) | Sirppujoki | 3200400 | 0.42 — poor |
| (f) | Karjaanjoki | 2300340 | −0.76 — worst |

Panel (f) was changed from Karjaanjoki 2300100 to Karjaanjoki 2300340 on 2026-08-25: the corrected 2017–2022 calibration window improves 2300100's NSE to +0.17 (no longer the worst), while 2300340 is the true worst performer under the corrected window.

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
