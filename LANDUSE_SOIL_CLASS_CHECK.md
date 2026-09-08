# Land use / soil class count discrepancy — needs Lassi + Karl to check

**Status: unresolved, needs input from someone with access to the original CORINE-to-HYPE and GTK-to-HYPE reclassification scripts (not found in this repo).**

## Summary

The manuscript (`agujournaltemplate.tex`, Section 2.1) and `results_notebook.Rmd` (line 74) both state:

> "7 land use classes (urban, other impermeable, agriculture/low vegetation, bare soil, forest, swamp, water) and 6 soil types (rock outcrop, clay, till, coarse materials, peat, water)"

I checked this against the actual `GeoClass.txt` files for all 27 primary catchments (`Results/model_setups/catchments/*/hype_data/GeoClass.txt`) and the aggregate PEST parameter file (`Results/model_setups/_aggregates/all_rivers/pest_data/all_rivers.pst`) used for calibration. The actual numbers do not match the documented "7 land use / 6 soil" claim, and the mismatch runs in **opposite directions** for land use and soil:

| | Documented (manuscript + notebook) | Distinct codes actually assigned to at least one subcatchment, across all 27 catchments | Parameter slots reserved in the aggregate PEST file |
|---|---|---|---|
| **Land use** | 7 classes | **6** codes: `{2, 4, 5, 6, 7, 8}` | 8 slots (parameter suffixes `_10` to `_17`, i.e. code + 9) |
| **Soil type** | 6 classes | **7** codes: `{1, 2, 3, 4, 5, 6, 7}` | 7 slots (parameter suffixes `_1` to `_7`, i.e. code directly) |

So: land use codes **1 and 3** have a reserved, calibrated (or fixed) parameter value in the PEST file, but are **never actually assigned to any subcatchment in any of the 27 catchments** — they are dead/unused in this specific domain. Meanwhile soil type has **7** distinct codes genuinely in use across the domain (all 7 PEST soil parameter slots are populated with real subcatchments), one more than the "6 soil types" the manuscript names.

This is not just a documentation typo — the soil-type count discrepancy (7 codes in use vs. 6 named types) means one of the six named soil categories in the text ("rock outcrop, clay, till, coarse materials, peat, water") is either missing a category, or one of those six names is secretly covering two different numeric codes (e.g. two different "water" codes for lake vs. river, or two different "till" texture subclasses). Either way, someone should check which is true before this table caption or the Methods text goes into a final submission.

## Exact evidence

**Files checked:**
- `Results/model_setups/catchments/<Catchment>/hype_data/GeoClass.txt` for all 27 primary catchments (Kymijoki excluded, as it was never part of the PEST calibration domain)
- `Results/model_setups/_aggregates/all_rivers/pest_data/all_rivers.pst` (parameter data block, 146 individual PEST parameters)

**Land use codes, by catchment** (column 2 of `GeoClass.txt`, `Landuse`):

| Catchment | Land use codes present | Soil codes present |
|---|---|---|
| Aurajoki | 2, 4, 5, 6, 7, 8 | 1, 2, 3, 6 |
| Halikonjoki | 2, 4, 6, 7, 8 | 3, 7 |
| Hirvijoki | 2, 4, 5, 6, 7 | 2, 3, 6 |
| Hounijoki | 2, 4, 5, 6, 7, 8 | 2, 5, 6 |
| Ilolanjoki | 2, 4, 5, 6, 7, 8 | 2, 3, 4, 6 |
| Juustilanjoki | 2, 4, 5, 6, 7, 8 | 2, 3, 5, 7 |
| Karjaanjoki | 2, 4, 5, 6, 7, 8 | 2, 3, 4, 5, 7 |
| Kiskonjoki | 2, 4, 5, 6, 7, 8 | 2, 3, 4, 5 |
| Koskenkylanjoki | 2, 4, 5, 6, 7, 8 | 2, 3, 4, 6, 7 |
| Laajoki | 2, 4, 6, 7, 8 | 2, 3, 4, 6, 7 |
| Mustijoki | 2, 4, 5, 6, 7, 8 | 2, 3, 4, 5 |
| Mynajoki | 2, 4, 6, 7, 8 | 2, 3, 6 |
| Paimionjoki | 2, 4, 6, 7, 8 | 2, 3, 4, 7 |
| Porvoonjoki | 2, 4, 5, 6, 7, 8 | 2, 3, 4, 5 |
| Sipoonjoki | 2, 4, 5, 6, 8 | 2, 3 |
| Sirppujoki | 2, 4, 6, 7, 8 | 2, 4, 6 |
| Siuntionjoki | 2, 4, 5, 6, 7, 8 | 2, 3, 5 |
| Summajoki | 2, 4, 5, 6, 7, 8 | 2, 3, 4, 5, 6 |
| Taasianjoki | 2, 4, 5, 6, 7, 8 | 2, 3, 4, 7 |
| Tervajoki | 4, 6, 8 | 2, 7 |
| Urpalanjoki | 2, 4, 5, 6, 7, 8 | 2, 3, 4, 5, 6 |
| Uskelanjoki | 2, 4, 5, 6, 7, 8 | 2, 3, 4, 5 |
| Vaalimaanjoki | 2, 4, 5, 6, 7, 8 | 2, 3, 4, 6 |
| Vantaanjoki | 2, 4, 5, 6, 7, 8 | 1, 2, 3, 4, 5, 6, 7 |
| Vehkajoki | 2, 4, 5, 6, 7, 8 | 2, 3, 5 |
| Vilajoki | 2, 4, 5, 6, 7, 8 | 2 |
| Vironjoki | 2, 4, 5, 6, 7, 8 | 2, 3, 4, 5 |

**Union across all 27 catchments:** land use = `{2, 4, 5, 6, 7, 8}` (6 codes), soil = `{1, 2, 3, 4, 5, 6, 7}` (7 codes).

**How often each code is actually used** (count of SLC rows across all 27 `GeoClass.txt` files, 455 rows total):

Land use:
| Code | 2 | 4 | 5 | 6 | 7 | 8 |
|---|---|---|---|---|---|---|
| SLC rows | 78 | 101 | 42 | 98 | 56 | 80 |

Soil type:
| Code | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
|---|---|---|---|---|---|---|---|
| SLC rows | 6 | 126 | 117 | 68 | 54 | 48 | 36 |

Note soil code 1 is rare (only 6 rows domain-wide, all in Aurajoki and Vantaanjoki) but is definitely present and calibrated, not a phantom.

**PEST parameter naming:** land-use-dependent parameters (`ttmp`, `cmlt`, `cevp`, `srrcs`, `frost`) use suffixes `_10` through `_17`; soil-type-dependent parameters (`rrcs1`, `rrcs2`, `trrcs`, `mperc1`, `mperc2`, `sfrost`, `macrate`, `mactrinf`, `mactrsm`, `srrate`, `wcwp`, `wcfc`, `wcep`) use suffixes `_1` through `_7`. The land-use suffix pattern is consistent with `code + 9` (code 1 → `_10`, code 8 → `_17`); the soil suffix pattern is the code directly. Land use codes **1 and 3** have reserved PEST parameter entries (`ttmp_10`, `ttmp_12`, etc.) but, per the table above, no subcatchment in any of the 27 catchments is ever actually assigned land use code 1 or 3.

## What I could not resolve myself

I do not have access to the actual CORINE-to-HYPE land use crosswalk or GTK-to-HYPE soil crosswalk (the script or config that assigns a numeric HYPE code to each CORINE Level-3 category or GTK superficial deposit type). I searched the repo for anything resembling this (`.py`, `.R` scripts, lookup tables, config files containing the class names) and found nothing beyond the class names appearing as plain prose in the manuscript and `results_notebook.Rmd`. That crosswalk is what would tell us definitively:
- what land use codes 1 and 3 are actually supposed to represent, and whether it is expected/correct that they never occur in this specific 27-catchment domain (e.g. maybe code 1 = a CORINE class that simply doesn't exist in southern Finland, like glaciers or bare rock at high elevation) or whether this points to a mapping bug where some CORINE input class silently failed to reclassify to its intended HYPE code and got dropped or merged into a different code instead
- which HYPE soil code corresponds to which of the six named soil types, and specifically whether the "water" soil type (or another type) is secretly split across two different numeric codes, which would explain the 7-vs-6 count without there being an error at all

## Action items for Lassi and Karl

1. **Find the actual CORINE→HYPE and GTK→HYPE reclassification script/config** (likely lives outside this repo, in whatever preprocessing pipeline or GIS toolchain built `GeoClass.txt`) and get the authoritative code→name legend for both land use and soil.
2. **Check land use codes 1 and 3**: confirm whether it's expected that these never occur in any of the 27 catchments (in which case the manuscript text should say "up to 8 possible land use classes, of which 6 occur in the 27-catchment domain" rather than a flat "7"), or whether this indicates a reclassification bug that silently lost a category.
3. **Check soil code 1**: confirm what it represents and why it's so rare (6 rows total, only in Aurajoki and Vantaanjoki) — and resolve whether "6 named soil types" is simply undercounting a real 7th category, or whether two of the six names should map to two different codes.
4. **Once resolved, update:**
   - `agujournaltemplate.tex`, Section 2.1 ("Land cover" and "Soils and superficial deposits" subsections) — correct the class descriptions and counts
   - `results_notebook.Rmd` line 74 — same correction, since it currently states the same "7/6" figures
   - Table 3's caption in the manuscript, which currently just says the class-dependency mapping "should be verified against the project's own model configuration before final submission" — once the true legend is known, that caveat can be replaced with the correct, specific class names per code

## Scripts used to produce this analysis

Ad hoc, not committed to the repo (run directly against `Results/model_setups/`, which is gitignored):
- Parsed all 27 `hype_data/GeoClass.txt` files, extracted the `Landuse` and `Soil` columns, and computed the union and per-catchment set of codes actually in use.
- Parsed `all_rivers.pst`'s parameter data block to get the full list of 146 individual PEST parameter names and grouped them by base parameter name, confirming the `_10`–`_17` (land use) and `_1`–`_7` (soil) suffix ranges.

If useful, I can turn this into a small committed script (e.g. `scripts/00_check_slc_classes.py`) so this check can be re-run automatically whenever `GeoClass.txt` files are regenerated — let me know if you want that.
