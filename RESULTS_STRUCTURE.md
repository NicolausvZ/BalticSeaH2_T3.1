# Results Folder Structure and Documentation

**Project:** BalticSeaH2 T3.1 — Water availability for hydrogen production in southern Finland  
**Last updated:** April 2026  

---

## Overview

The `Results/` folder contains all outputs from the HYPE hydrological modelling workflow for 27 river catchments in southern Finland, spanning from Sirppujoki in the west to Juustilanjoki in the east. The workflow covers four scenarios (baseline, climate change, urban growth, and combined), calibrated against observed daily discharge using PEST automatic parameter estimation.

---

## Top-Level Structure

```
Results/
└── model_setups/
    ├── _aggregates/          ← Region-wide aggregate PEST calibration run
    ├── catchments/           ← Per-catchment model inputs, outputs, and results
    └── grid_gen_input/       ← Spatial preprocessing inputs (DEM, land cover, soils)
```

---

## Catchments

There are **27 catchments** in the study domain, each with its own subfolder under `model_setups/catchments/`:

| Catchment | Region |
|---|---|
| Sirppujoki | West |
| Hirvijoki | West |
| Laajoki | West |
| Mynajoki | West |
| Aurajoki | Southwest |
| Paimionjoki | Southwest |
| Halikonjoki | Southwest |
| Uskelanjoki | Southwest |
| Kiskonjoki | Southwest |
| Karjaanjoki | South |
| Siuntionjoki | South |
| Vantaanjoki | South (Helsinki metropolitan area) |
| Sipoonjoki | South |
| Mustijoki | South |
| Porvoonjoki | South |
| Ilolanjoki | South |
| Tervajoki | South |
| Hounijoki | South |
| Vilajoki | South |
| Koskenkylanjoki | South |
| Taasianjoki | East |
| Summajoki | East |
| Vehkajoki | East |
| Urpalanjoki | East |
| Vaalimaanjoki | East |
| Vironjoki | East |
| Juustilanjoki | East |

Of the 27 catchments, **15 have observed discharge records** used for calibration and validation. The remaining 12 are **production-only catchments** — PEST updates their parameters using the regional parameter set but they contribute no observations to the objective function.

---

## Per-Catchment Folder Structure

Each catchment folder follows an identical structure:

```
catchments/{CatchmentName}/
├── catch_data/                  ← Primary results and spatial data
├── hype_data/                   ← Catchment-outlet level HYPE baseline run
├── hype_data_subcatchments/     ← BASELINE scenario: subcatchment-level outputs
├── hype_data_climate/           ← CLIMATE CHANGE scenario outputs
├── hype_data_urban/             ← URBAN GROWTH scenario outputs
├── hype_data_combined/          ← COMBINED scenario outputs
└── pest_data/                   ← Per-catchment PEST calibration files
```

---

## catch_data — Primary Results

This is the most important folder for analysis. It contains pre-processed results ready for plotting and aggregation.

```
catch_data/
├── water_availability.gpkg           ← Baseline scenario: seasonal discharge statistics
├── water_availability_climate.gpkg   ← Climate scenario: seasonal discharge statistics
├── water_availability_urban.gpkg     ← Urban growth scenario: seasonal discharge statistics
├── water_availability_combined.gpkg  ← Combined scenario: seasonal discharge statistics
├── calib_disch_data.csv              ← Observed daily discharge (all gauges, 2016–2023)
├── calib_disch_data_results.csv      ← Observed + simulated daily discharge (all gauges)
├── catchment.gpkg                    ← Catchment boundary polygon
├── subcatchments.gpkg                ← Subcatchment boundary polygons
├── disch_stations.gpkg               ← Discharge gauge locations (point layer)
├── disch_points.gpkg                 ← Additional discharge point data
├── disch_data.json                   ← Discharge data in JSON format
├── calib_disch_data.json             ← Calibration discharge data in JSON format
├── streams.gpkg                      ← River network (polyline layer)
├── municipality_subcatchment_overlap.csv  ← Area-weighted municipality fractions per subcatchment
└── gof_plot_XXXX.png                 ← Pre-generated goodness-of-fit plots per gauge
```

### water_availability GeoPackages

Each of the four `water_availability*.gpkg` files contains a single layer (`water_availability`) with one row per subcatchment. The coordinate reference system is **ETRS89 / TM35FIN(E,N)** (EPSG:3067).

**Columns:**

| Column | Description |
|---|---|
| `taso4_osat` | SYKE subcatchment identifier (taso4 hierarchy) |
| `catchment` | Catchment name (populated for outlet subcatchment) |
| `urban_frac` | Urban land cover fraction (0–1) |
| `agri_frac` | Agricultural land cover fraction (0–1) |
| `forest_frac` | Forest land cover fraction (0–1) |
| `wetland_frac` | Wetland land cover fraction (0–1) |
| `water_frac` | Open water land cover fraction (0–1) |
| `peat_frac` | Peat soil fraction (0–1) |
| `winter_min` | Winter (Dec–Feb) minimum daily discharge (m³/s) |
| `winter_q10` | Winter 10th percentile discharge — primary low-flow indicator (m³/s) |
| `winter_median` | Winter median discharge (m³/s) |
| `winter_mean` | Winter mean discharge (m³/s) |
| `winter_max` | Winter maximum discharge (m³/s) |
| `spring_*` | Spring (Mar–May) equivalents of above |
| `summer_*` | Summer (Jun–Aug) equivalents of above |
| `autumn_*` | Autumn (Sep–Nov) equivalents of above |
| `annual_*` | Annual equivalents of above |
| `geom` | Subcatchment polygon geometry (MULTIPOLYGON) |

The **Q10 statistic** (discharge exceeded 90% of the time) is the primary indicator of reliably available water for hydrogen production assessment.

### calib_disch_data_results.csv

Paired observed and simulated daily discharge for all gauged subcatchments, covering the full model period (2016–2023). Columns alternate between observed (`X{station_id}`) and simulated (`simulated_{subcatchment_id}`) for each gauge pair.

| Period | Dates | Role |
|---|---|---|
| Warm-up | 2019 | Model state initialisation — excluded from metrics |
| Calibration | 2020–2022 | Used in PEST objective function |
| Validation | 2023 | Withheld from calibration — independent performance check |

---

## hype_data_subcatchments — Baseline Scenario

Contains the full HYPE model setup and raw output files for the **baseline scenario** at subcatchment level. Numbered text files (`0001001.txt` … `000XXXX.txt`) are HYPE output timeseries, one per subcatchment. Also contains the model input files used for the run:

| File | Description |
|---|---|
| `GeoData.txt` | Subcatchment attributes (area, slope, SLC fractions, routing) |
| `GeoClass.txt` | Soil–land use combination (SLC) class definitions |
| `LakeData.txt` | Lake routing parameters |
| `par.txt` | Calibrated HYPE parameter set (output from PEST) |
| `Pobs.txt` | Daily precipitation forcing per subcatchment |
| `Tobs.txt` | Daily temperature forcing per subcatchment |
| `Description.txt` | HYPE run description |
| `info.txt` | Run metadata |
| `hyss_*.log` | HYPE run log files (one per parallel worker) |

The same file structure is replicated in `hype_data_climate/`, `hype_data_urban/`, and `hype_data_combined/` for their respective scenarios.

---

## Scenarios

| Folder | Scenario | Description |
|---|---|---|
| `hype_data_subcatchments/` | **Baseline** | Calibrated model, observed forcing 2019–2023 |
| `hype_data_climate/` | **Climate change** | SSP2-4.5 delta-change factors applied to temperature (+2.3 to +3.2°C) and precipitation (−1% to +14% by month); 2040–2069 horizon |
| `hype_data_urban/` | **Urban growth** | Urban SLC fractions increased per Statistics Finland 2021 population projections to 2040; growth 0–12 percentage points depending on municipality |
| `hype_data_combined/` | **Combined** | Climate forcing and urban land use changes applied simultaneously |

All scenarios use the same calibrated parameter set from PEST. Scenario differences are driven purely by changes in forcing (climate) or model inputs (urban land cover).

---

## pest_data — Calibration Files

### Per-catchment (`catchments/{Name}/pest_data/`)

Contains PEST instruction files (`.ins`) linking HYPE output files to observation targets, a parameter template (`par.tpl`), and the catchment-specific PEST control file (`.pst`).

### Aggregate (`_aggregates/all_rivers/pest_data/`)

Contains the region-wide PEST run that calibrated all 27 catchments simultaneously using a shared parameter set. Key files:

| File | Description |
|---|---|
| `all_rivers.par` | Final calibrated parameter values |
| `all_rivers.res` | Residuals: observed vs modelled discharge for all observations |
| `all_rivers.rei` | Residuals at end of final optimisation iteration |
| `all_rivers.rec` | Full PEST run record including convergence history and objective function |
| `all_rivers.sen` | Parameter sensitivity coefficients |
| `all_rivers.seo` | Observation sensitivity coefficients |
| `all_rivers.pst` | Master PEST control file |
| `all_rivers.jco` | Jacobian matrix (parameter–observation relationships) |
| `run_all_rivers.sh` | Shell script used to execute the calibration run |

---

## grid_gen_input

Spatial preprocessing inputs used to generate HYPE model inputs. Contains raw GIS layers (DEM, CORINE land cover, GTK superficial deposits, SYKE catchment delineations) before reclassification and intersection into HYPE SLC fractions.

---

## Analysis Scripts

R scripts for processing and visualising these results are located in the project root under `scripts/` (to be created). Planned scripts:

| Script | Purpose |
|---|---|
| `01_compute_gof_metrics.R` | Compute NSE, KGE, R², PBIAS, RMSE per gauge for calibration and validation periods |
| `02_aggregate_water_availability.R` | Merge all 27 catchment GeoPackages into region-wide spatial datasets |
| `03_plot_hydrographs.R` | Observed vs simulated hydrograph plots per gauge |
| `04_plot_seasonal_maps.R` | Seasonal Q10 choropleth maps across the region |
| `05_plot_scenario_comparison.R` | Scenario delta plots (% change from baseline) |
