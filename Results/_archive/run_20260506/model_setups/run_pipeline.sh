#!/bin/bash
# ============================================================
# BalticSeaH2 — full processing pipeline
# ============================================================
#
# STAGE OVERVIEW
# --------------
#  1. Setup          main.py             GIS → HYPE input files for all 27 catchments
#  2. Calibration    pest                PEST parameter optimisation (aggregate)
#  3. Sync params    shell loop          Copy calibrated par.txt → hype_data_subcatchments/
#  4. Base HYPE      hype (×27)          Run HYPE with calibrated params, all subcatchments
#  5. GOF            compute_gof.py      NSE / KGE / plots against observations
#  6. Catchment tbl  compute_catch.py    Characteristics table for Methods section
#  7. Base water      extract_stats.py   Seasonal discharge stats → water_availability.gpkg
#  8. Combine base   combine_avail.py    Merge all catchments → combined_water_availability.gpkg
#  9. Scenarios      create_scenarios.py Create climate / urban / combined HYPE input folders
# 10. Scenario HYPE  hype (×27×3)        Run HYPE for each scenario folder
# 11. Scenario water extract_stats.py   Seasonal stats per scenario → water_availability_X.gpkg
# 12. Combine scen.  combine_avail.py   Merge per scenario → combined_water_availability_X.gpkg
# ============================================================

set -e   # Stop on first error

# ── Shared paths ─────────────────────────────────────────────────────────────
INI="/home/lwlassi/projects/BalticSeaH2/model_setups/catchment_tools.ini"
CATCH_ROOT="/home/lwlassi/projects/BalticSeaH2/model_setups/catchments"
MODEL_ROOT="/home/lwlassi/projects/BalticSeaH2/model_setups"
SCRIPTS="/home/lwlassi/development/catchment_tools/catchment_tools"
HYPE="/home/lwlassi/development/hype-code/hype"
PEST="/home/lwlassi/development/pest18/pest_bin/pest"

echo "============================================================"
echo " STAGE 1: Setup — main.py"
echo "============================================================"
python "$SCRIPTS/main.py" "$INI"


echo ""
echo "============================================================"
echo " STAGE 2: Calibration — aggregate PEST"
echo "============================================================"
"$PEST" "$MODEL_ROOT/_aggregates/all_rivers/pest_data/all_rivers.pst"


echo ""
echo "============================================================"
echo " STAGE 3: Sync calibrated par.txt → hype_data_subcatchments"
echo "============================================================"
for d in "$CATCH_ROOT"/*/; do
    [ -d "$d" ] || continue
    if [ -f "${d}hype_data/par.txt" ] && [ -d "${d}hype_data_subcatchments" ]; then
        cp -f "${d}hype_data/par.txt" "${d}hype_data_subcatchments/par.txt"
        echo "  Synced: $(basename $d)"
    fi
done


echo ""
echo "============================================================"
echo " STAGE 4: Base HYPE run — all 27 catchments"
echo "============================================================"
for CATCHMENT in \
    Sirppujoki Laajoki Mynajoki Hirvijoki Aurajoki \
    Paimionjoki Halikonjoki Uskelanjoki Kiskonjoki Karjaanjoki \
    Siuntionjoki Vantaanjoki Sipoonjoki Mustijoki Porvoonjoki \
    Ilolanjoki Koskenkylanjoki Taasianjoki Summajoki Vehkajoki \
    Vironjoki Vaalimaanjoki Urpalanjoki Vilajoki Tervajoki \
    Hounijoki Juustilanjoki; do
    echo "  Running HYPE: $CATCHMENT"
    "$HYPE" "$CATCH_ROOT/$CATCHMENT/hype_data_subcatchments/"
done
# Kymijoki is excluded — catchment network problems
## "$HYPE" "$CATCH_ROOT/Kymijoki/hype_data_subcatchments/"


echo ""
echo "============================================================"
echo " STAGE 5: Extract sim vs obs results (for GOF)"
echo "============================================================"
for CATCHMENT in \
    Sirppujoki Laajoki Mynajoki Hirvijoki Aurajoki \
    Paimionjoki Halikonjoki Uskelanjoki Kiskonjoki Karjaanjoki \
    Siuntionjoki Vantaanjoki Sipoonjoki Mustijoki Porvoonjoki \
    Ilolanjoki Koskenkylanjoki Taasianjoki Summajoki Vehkajoki \
    Vironjoki Vaalimaanjoki Urpalanjoki Vilajoki Tervajoki \
    Hounijoki Juustilanjoki; do
    python "$SCRIPTS/extract_simulation_results.py" \
        "$CATCH_ROOT/$CATCHMENT/catch_data/calib_disch_data.csv" \
        "$CATCH_ROOT/$CATCHMENT/hype_data/" \
        "$CATCH_ROOT/$CATCHMENT/catch_data/calib_disch_data_results.csv"
done


echo ""
echo "============================================================"
echo " STAGE 6: Goodness-of-fit metrics and hydrograph plots"
echo "============================================================"
python "$SCRIPTS/compute_goodness_of_fit.py" \
    "$CATCH_ROOT" \
    "$MODEL_ROOT/model_performance_summary.csv" \
    --calib-start 2017-01-01 --calib-end 2022-12-31 \
    --valid-start 2023-01-01 --valid-end 2025-12-31


echo ""
echo "============================================================"
echo " STAGE 7: Catchment statistics table (Methods section)"
echo "============================================================"
python "$SCRIPTS/compute_catchment_statistics.py" \
    "$CATCH_ROOT" \
    "$MODEL_ROOT/catchment_statistics.csv"


echo ""
echo "============================================================"
echo " STAGE 8: Base scenario — water availability per subcatchment"
echo "============================================================"
for CATCHMENT in \
    Sirppujoki Laajoki Mynajoki Hirvijoki Aurajoki \
    Paimionjoki Halikonjoki Uskelanjoki Kiskonjoki Karjaanjoki \
    Siuntionjoki Vantaanjoki Sipoonjoki Mustijoki Porvoonjoki \
    Ilolanjoki Koskenkylanjoki Taasianjoki Summajoki Vehkajoki \
    Vironjoki Vaalimaanjoki Urpalanjoki Vilajoki Tervajoki \
    Hounijoki Juustilanjoki; do
    python "$SCRIPTS/extract_subcatchment_statistics.py" \
        "$CATCH_ROOT/$CATCHMENT/" \
        "$CATCH_ROOT/$CATCHMENT/catch_data/subcatchments.gpkg" \
        "$CATCH_ROOT/$CATCHMENT/catch_data/water_availability.gpkg"
done

python "$SCRIPTS/combine_water_availability.py" \
    "$CATCH_ROOT" \
    "$MODEL_ROOT/combined_water_availability.gpkg"


echo ""
echo "============================================================"
echo " STAGE 9: Create scenario HYPE input folders"
echo "          (climate, urban, combined — reads ini for deltas)"
echo "============================================================"
# NOTE: must run AFTER the base HYPE run and par.txt sync (stages 3-4)
# because scenario folders are copied from hype_data_subcatchments/
# which by this point contains the calibrated par.txt.
# Also writes catch_data/municipality_subcatchment_overlap.csv (cached).
python "$SCRIPTS/create_scenario_hype_inputs.py" "$INI"


echo ""
echo "============================================================"
echo " STAGE 10: Scenario HYPE runs (climate / urban / combined)"
echo "============================================================"
for SCENARIO in climate urban combined; do
    echo "  --- Scenario: $SCENARIO ---"
    for d in "$CATCH_ROOT"/*/; do
        [ -d "$d" ] || continue
        HYPE_FOLDER="${d}hype_data_${SCENARIO}"
        if [ -d "$HYPE_FOLDER" ]; then
            echo "  Running HYPE: $(basename $d) [$SCENARIO]"
            "$HYPE" "$HYPE_FOLDER/"
        fi
    done
done


echo ""
echo "============================================================"
echo " STAGE 11: Scenario water availability per subcatchment"
echo "============================================================"
for SCENARIO in climate urban combined; do
    echo "  --- Scenario: $SCENARIO ---"
    for d in "$CATCH_ROOT"/*/; do
        [ -d "$d" ] || continue
        HYPE_FOLDER="${d}hype_data_${SCENARIO}"
        if [ -d "$HYPE_FOLDER" ]; then
            python "$SCRIPTS/extract_subcatchment_statistics.py" \
                "$d" \
                "${d}catch_data/subcatchments.gpkg" \
                "${d}catch_data/water_availability_${SCENARIO}.gpkg" \
                --hype-subfolder "hype_data_${SCENARIO}"
        fi
    done
done


echo ""
echo "============================================================"
echo " STAGE 12: Combine scenario water availability"
echo "============================================================"
for SCENARIO in climate urban combined; do
    python "$SCRIPTS/combine_water_availability.py" \
        "$CATCH_ROOT" \
        "$MODEL_ROOT/combined_water_availability_${SCENARIO}.gpkg" \
        --gpkg-name "water_availability_${SCENARIO}.gpkg"
done


echo ""
echo "============================================================"
echo " Pipeline complete."
echo "============================================================"