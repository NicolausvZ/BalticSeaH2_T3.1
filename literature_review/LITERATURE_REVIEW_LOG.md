# Literature review log

Tracks every paper read and cited during the literature review expansion, for audit purposes. Each entry records what the source says, where it was used in the manuscript, and the exact page/section the claim came from, so any entry can be checked against the original PDF.

Papers are logged in the order they were processed. The BibTeX key links each entry to `references.bib`.

---

## How to read this log

Each entry has:
- **File**: the PDF filename as placed in `Biblio/`
- **Full citation**: author, year, title, journal
- **BibTeX key**: the citation key used in `references.bib` and `\cite{}` calls
- **Source page(s)**: where in the PDF the cited claim appears
- **Claim used**: the specific fact, number, or finding taken from the paper, close to verbatim
- **Where cited**: section and approximate sentence in `agujournaltemplate.tex`
- **Why this paper**: one or two sentences on why it was the right source for that claim

---

## Entries

<!-- Template for new entries:

### [N]. Author(s) (Year) — Short title

- **File:** `Biblio/filename.pdf`
- **Full citation:** Author, A. B., & Author, C. D. (Year). Title. *Journal*, vol(issue), pages. DOI
- **BibTeX key:** `citekey`
- **Source page(s):** p. X (or pp. X-Y)
- **Claim used:** "..."
- **Where cited:** Section X.X, paragraph starting "..."
- **Why this paper:** ...

-->

### 1. Terlouw, Rosa, Bauer & McKenna (2024) — Future hydrogen economies imply environmental trade-offs and a supply-demand mismatch

- **File:** `Biblio/Future hydrogen economies imply environmental trade-offs and a supply-demand mismatch.pdf`
- **Full citation:** Terlouw, T., Rosa, L., Bauer, C., & McKenna, R. (2024). Future hydrogen economies imply environmental trade-offs and a supply-demand mismatch. *Nature Communications*, 15, 7043. https://doi.org/10.1038/s41467-024-51251-7
- **BibTeX key:** `Terlouw2024`
- **Source page(s):** p. 3 (section "Water-scarce regions")
- **Claim used:** "more than 60% of the global electrolysis-based onshore hydrogen production potential is situated in water scarce regions"
- **Where cited:** Introduction, second sentence of paragraph 1 ("This is a significant oversight even at the global scale...")
- **Why this paper:** direct global-scale evidence that water availability, not just energy potential, constrains where hydrogen production can be sited. Supports the paper's central argument that water needs to be a primary siting variable.

### 2. Oliveira, Beswick & Yan (2021) — A green hydrogen economy for a renewable energy society

- **File:** `Biblio/A green hydrogen economy for a renewable energy society.pdf`
- **Full citation:** Oliveira, A. M., Beswick, R. R., & Yan, Y. (2021). A green hydrogen economy for a renewable energy society. *Current Opinion in Chemical Engineering*, 33, 100701. https://doi.org/10.1016/j.coche.2021.100701
- **BibTeX key:** `OliveiraBeswickYan2021`
- **Source page(s):** p. 1 (abstract and introduction)
- **Claim used:** projected global hydrogen demand of 2.3 Gt annually, driven by decarbonisation of industrial feedstock, heavy transport, buildings heat, and seasonal power storage
- **Where cited:** Introduction, paragraph 1, alongside the existing IEA/European Commission demand-growth citations
- **Why this paper:** adds an independent, peer-reviewed demand projection next to the two policy-report citations already used (IEA 2024, European Commission 2020), broadening the evidence base beyond grey literature.

### 3. European Commission (2015) — Ecological flows in the implementation of the Water Framework Directive (correction to existing entry)

- **File:** `Biblio/Guidance No 31 - Ecological flows (final version).pdf`
- **Full citation:** European Commission. (2015). Ecological flows in the implementation of the Water Framework Directive (Guidance Document No. 31). Publications Office of the European Union, Luxembourg. ISBN 978-92-79-45758-6. https://doi.org/10.2779/775712
- **BibTeX key:** `directive2014ecological` (key unchanged to avoid breaking existing `\cite{}` calls; only the entry fields were corrected)
- **Source page(s):** p. 1-2 (title page and imprint)
- **Claim used:** no new claim; this was a citation accuracy fix, not a new addition
- **Where cited:** Introduction, paragraph 3 ("EU guidance on ecological flows under the Water Framework Directive...")
- **Why this paper:** the entry already existed in `references.bib` dated 2014, but the source PDF's title page and imprint (ISBN, DOI, Publications Office record) confirm publication year 2015. Corrected year, author, publisher, and added the DOI and ISBN, which were missing.

---

## Batch 2: Search worklist items 1.1-1.4 and 2.1-2.3 (26 PDFs supplied by user)

The entries below were added after the user completed literature searches following `SEARCH_WORKLIST.md` sections 1.1-2.3 and placed 26 new PDFs in `Biblio/`. Metadata for all 26 files were extracted with PyMuPDF and cross-checked against Crossref where the DOI was not printed on the PDF itself (this caught two self-introduced DOI errors, for Huang2024 and Messager2024, which were corrected before committing).

### 4. Gupta, Kling, Yilmaz & Martinez (2009) — Decomposition of the mean squared error and NSE performance criteria

- **File:** `Biblio/1-s2.0-S0022169409004843-main.pdf`
- **Full citation:** Gupta, H. V., Kling, H., Yilmaz, K. K., & Martinez, G. F. (2009). Decomposition of the mean squared error and NSE performance criteria: Implications for improving hydrological modelling. *Journal of Hydrology*, 377(1-2), 80-91. https://doi.org/10.1016/j.jhydrol.2009.08.003
- **BibTeX key:** `Gupta2009`
- **Source page(s):** p. 1 (abstract, definition of KGE decomposition)
- **Claim used:** KGE decomposes model error into correlation, bias, and variability components, providing diagnostic information that a single aggregate NSE score does not
- **Where cited:** Section 2.2.5 (model evaluation metrics list)
- **Why this paper:** this is the original paper defining the Kling-Gupta Efficiency metric already reported throughout the results; the manuscript used the metric without citing its source, which is now fixed. Worklist item 1.1.

### 5. Krause, Boyle & Bäse (2005) — Comparison of different efficiency criteria for hydrological model assessment

- **File:** `Biblio/adgeo-5-89-2005.pdf`
- **Full citation:** Krause, P., Boyle, D. P., & Bäse, F. (2005). Comparison of different efficiency criteria for hydrological model assessment. *Advances in Geosciences*, 5, 89-97. https://doi.org/10.5194/adgeo-5-89-2005
- **BibTeX key:** `Krause2005`
- **Source page(s):** p. 1-2 (introduction of the log-transformed NSE)
- **Claim used:** log-transforming discharge before computing NSE flattens the influence of peak flows and increases sensitivity to low-flow performance
- **Where cited:** Section 2.2.5, in the definition of the log-transformed NSE (logNSE) metric
- **Why this paper:** original source for logNSE, which the manuscript reports for all 15 calibration/validation gauges but had not previously cited. Worklist item 1.4.

### 6. Schneider, Laizé, Acreman & Flörke (2013) — How will climate change modify river flow regimes in Europe?

- **File:** `Biblio/hess-17-325-2013.pdf`
- **Full citation:** Schneider, C., Laizé, C. L. R., Acreman, M. C., & Flörke, M. (2013). How will climate change modify river flow regimes in Europe? *Hydrology and Earth System Sciences*, 17, 325-339. https://doi.org/10.5194/hess-17-325-2013
- **BibTeX key:** `Schneider2013`
- **Source page(s):** p. 1 (abstract, continental classification of flow regime change by climate zone)
- **Claim used:** the direction and magnitude of hydrological alteration under climate change varies systematically by European climate zone
- **Where cited:** Section 4.2, second Nordic/Fennoscandian paragraph, continental-scale framing sentence
- **Why this paper:** places the southern Finnish results within a European-scale pattern rather than treating the region in isolation. Worklist item 2.1.

### 7. Bergström, Carlsson, Gardelin, Lindström, Pettersson & Rummukainen (2001) — Climate change impacts on runoff in Sweden

- **File:** `Biblio/c016p101.pdf`
- **Full citation:** Bergström, S., Carlsson, B., Gardelin, M., Lindström, G., Pettersson, A., & Rummukainen, M. (2001). Climate change impacts on runoff in Sweden - assessments by global climate models, dynamical downscaling and hydrological modelling. *Climate Research*, 16, 101-112. https://doi.org/10.3354/cr016101
- **BibTeX key:** `Bergstrom2001`
- **Source page(s):** p. 1 (abstract, sensitivity of runoff projections to GCM and PET method choice)
- **Claim used:** early SWECLIM-era regional climate modelling for Sweden, using the HBV model, found substantial sensitivity of projected seasonal runoff to the choice of global climate model and evapotranspiration formulation
- **Where cited:** Section 4.2, closing sentence of the second Nordic paragraph, on uncertainty from single-pathway climate scenarios
- **Why this paper:** one of the earliest Nordic hydrological climate-impact studies and directly relevant because it uses HBV, the model HYPE was developed to extend, giving methodological continuity with the present study. Worklist item 2.1.

### 8. Vormoor, Lawrence, Heistermann & Bronstert (2015) — Climate change impacts on the seasonality and generation processes of floods

- **File:** `Biblio/hess-19-913-2015.pdf`
- **Full citation:** Vormoor, K., Lawrence, D., Heistermann, M., & Bronstert, A. (2015). Climate change impacts on the seasonality and generation processes of floods - projections and uncertainties for catchments with mixed snowmelt/rainfall regimes. *Hydrology and Earth System Sciences*, 19, 913-931. https://doi.org/10.5194/hess-19-913-2015
- **BibTeX key:** `Vormoor2015`
- **Source page(s):** p. 1 (abstract, shift from snowmelt- to rainfall-dominated flood generation)
- **Claim used:** Norwegian catchments with mixed snowmelt/rainfall regimes are projected to shift from spring/summer snowmelt-dominated flood events to autumn/winter rainfall-dominated events
- **Where cited:** Section 4.2, second Nordic paragraph
- **Why this paper:** the snow-to-rain seasonal shift described here is the same mechanism driving the winter Q10 increase found in this study's climate scenario, giving independent process-level support. Worklist item 2.1.

### 9. Wilson, Hisdal & Lawrence (2010) — Has streamflow changed in the Nordic countries?

- **File:** `Biblio/1-s2.0-S0022169410005901-main.pdf`
- **Full citation:** Wilson, D., Hisdal, H., & Lawrence, D. (2010). Has streamflow changed in the Nordic countries? Recent trends and comparisons to hydrological projections. *Journal of Hydrology*, 394(3-4), 334-346. https://doi.org/10.1016/j.jhydrol.2010.09.010
- **BibTeX key:** `Wilson2010`
- **Source page(s):** p. 1, p. 3 (151 streamflow records, trend test results by season)
- **Claim used:** Mann-Kendall trend tests on 151 Nordic streamflow records show increasing trends dominate annual, winter and spring flows, while summer trends are more spatially variable
- **Where cited:** Section 4.2, first Nordic paragraph
- **Why this paper:** large-sample Nordic-wide trend analysis that matches the divergent seasonal Q10 response (summer decreasing, winter/spring increasing) projected in this study. Worklist item 2.1.

### 10. Matti, Dahlke, Dieppois, Lawler & Lyon (2017) — Flood seasonality across Scandinavia

- **File:** `Biblio/Hydrological Processes - 2017 - Matti - Flood seasonality across Scandinavia Evidence of a shifting hydrograph.pdf`
- **Full citation:** Matti, B., Dahlke, H. E., Dieppois, B., Lawler, D. M., & Lyon, S. W. (2017). Flood seasonality across Scandinavia - Evidence of a shifting hydrograph? *Hydrological Processes*, 31(26), 4661-4680. https://doi.org/10.1002/hyp.11365
- **BibTeX key:** `Matti2017`
- **Source page(s):** p. 1, p. 6 (magnitude of winter/spring peak flow increase, 5 to 35%)
- **Claim used:** winter and spring maximum daily flows in near-natural Scandinavian catchments increased by 5 to 35% over the past century
- **Where cited:** Section 4.2, first Nordic paragraph
- **Why this paper:** gives an independent quantitative benchmark (5-35% increase) for the winter Q10 increase direction found in this study's climate scenario, at the Scandinavian rather than Finnish scale. Worklist item 2.1.

### 11. Stahl, Hisdal, Hannaford, Tallaksen, van Lanen, Sauquet, Demuth, Fendekova & Jódar (2010) — Streamflow trends in Europe

- **File:** `Biblio/hess-14-2367-2010.pdf`
- **Full citation:** Stahl, K., Hisdal, H., Hannaford, J., Tallaksen, L. M., van Lanen, H. A. J., Sauquet, E., Demuth, S., Fendekova, M., & Jódar, J. (2010). Streamflow trends in Europe: evidence from a dataset of near-natural catchments. *Hydrology and Earth System Sciences*, 14, 2367-2382. https://doi.org/10.5194/hess-14-2367-2010
- **BibTeX key:** `Stahl2010`
- **Source page(s):** p. 1, p. 3-4 (441 catchments, 1962-2004 record, seasonal trend direction)
- **Claim used:** across 441 near-natural European catchments (1962-2004), winter months show positive streamflow trends across most of the continent, and low flows decrease in regions where the lowest mean monthly flow occurs in summer
- **Where cited:** Section 4.2, first Nordic paragraph
- **Why this paper:** the largest-sample European near-natural streamflow trend study available, giving continental context for the specific summer-down/winter-up seasonal pattern found in the baseline Q10 statistics. Worklist item 2.1.

### 12. Teutschbein, Grabs, Karlsen, Laudon & Bishop (2015) — Hydrological response to changing climate conditions

- **File:** `Biblio/Water Resources Research - 2015 - Teutschbein - Hydrological response to changing climate conditions  Spatial streamflow.pdf`
- **Full citation:** Teutschbein, C., Grabs, T., Karlsen, R. H., Laudon, H., & Bishop, K. (2015). Hydrological response to changing climate conditions: Spatial streamflow variability in the boreal region. *Water Resources Research*, 51(12), 9425-9446. https://doi.org/10.1002/2015WR017337
- **BibTeX key:** `Teutschbein2015`
- **Source page(s):** p. 3 (14-catchment boreal Sweden study design), p. 12-13 (projected seasonal streamflow change 2062-2090)
- **Claim used:** a 15-model climate ensemble combined with HBV across 14 boreal Swedish catchments projects lower spring and summer streamflow alongside substantially higher winter streamflow by 2062-2090
- **Where cited:** Section 4.2, second Nordic paragraph, opening sentence
- **Why this paper:** directly comparable boreal climate-hydrology modelling study (same general climate zone, HBV-family model) reaching the same seasonal direction of change over a longer projection horizon. Worklist item 2.1.

### 13. Huang, Eisner, Wong & Cattaneo (2024) — The potential impacts of climate and forest changes on streamflow in Norway

- **File:** `Biblio/1-s2.0-S2214581824004968-main.pdf`
- **Full citation:** Huang, S., Eisner, S., Wong, W. K., & Cattaneo, N. (2024). The potential impacts of climate and forest changes on streamflow for micro-, meso- and macro-scale catchments in Norway. *Journal of Hydrology: Regional Studies*, 53, 102147. https://doi.org/10.1016/j.ejrh.2024.102147
- **BibTeX key:** `Huang2024`
- **Source page(s):** p. 1, p. 8-9 (six catchments, relative contribution of climate vs. forest change to streamflow)
- **Claim used:** across six forest-dominated Norwegian catchments spanning micro to macro scale, climate is the dominant driver of projected streamflow change relative to forest growth, with median annual streamflow changes of -2% to +8% depending on catchment
- **Where cited:** Section 4.2, second Nordic paragraph
- **Why this paper:** directly supports the finding that climate change dominates over land-cover change (urban growth in this study) as a driver of future streamflow, from an independent Nordic catchment set. The DOI printed in the PDF (10.1016/j.ejrh.2024.102147) was verified against Crossref after an initial transcription error was caught. Worklist item 2.1.

### 14. Hernández-Herráez, Velaz-Acera, Del Pozo & Lagüela (2025) — The Role of Geospatial Techniques for Renewable Hydrogen Value Chain

- **File:** `Biblio/applsci-15-08777.pdf`
- **Full citation:** Hernández-Herráez, G., Velaz-Acera, N., Del Pozo, S., & Lagüela, S. (2025). The Role of Geospatial Techniques for Renewable Hydrogen Value Chain: A Systematic Review of Current Status, Challenges and Future Developments. *Applied Sciences*, 15(16), 8777. https://doi.org/10.3390/app15168777
- **BibTeX key:** `HernandezHerraez2025`
- **Source page(s):** p. 1 (abstract, 80% GIS share of reviewed studies; identified gap in hydrological resource mapping)
- **Claim used:** a systematic review found that GIS methods dominate 80% of geospatial hydrogen value-chain studies, mostly for site suitability and potential assessment, and identified hydrological resource mapping for electrolysis as an underdeveloped research direction
- **Where cited:** Section 4.1, opening sentence of the hydrogen-siting paragraph
- **Why this paper:** frames the whole hydrogen-siting comparison paragraph; establishes that this study's seasonal, subcatchment-resolved hydrological approach fills a gap the review itself identifies. Worklist item 2.2.

### 15. Köhl, Nenoff, Weber, Höflinger & Rönsch (2026) — GIS-based multi-criteria site analysis of electrolyzer systems in Germany

- **File:** `Biblio/1-s2.0-S0360319926011079-main.pdf`
- **Full citation:** Köhl, P., Nenoff, C., Weber, L., Höflinger, J., & Rönsch, S. (2026). GIS-based multi-criteria site analysis of electrolyzer systems for the production of green hydrogen in Germany. *International Journal of Hydrogen Energy*, 154470. https://doi.org/10.1016/j.ijhydene.2026.154470
- **BibTeX key:** `Kohl2026`
- **Source page(s):** p. 1, p. 4-5 (71.1% of land area excluded once water availability added as a constraint)
- **Claim used:** combining GIS multi-criteria analysis with forecast 2040 water availability in Germany found 71.1% of land area became unsuitable once water availability was included as a siting constraint
- **Where cited:** Section 4.1, hydrogen-siting paragraph
- **Why this paper:** gives a directly comparable national-scale figure for how much a siting assessment narrows once water constraints are added, of the same order of magnitude as the 58.5%/60.8% of subcatchments below this study's abstraction threshold. Worklist item 2.2.

### 16. Herrera, Ordoñez & Valdez (2026) — Hydrogen production potential in Mexico: An estimation

- **File:** `Biblio/1-s2.0-S0360319926019555-main.pdf`
- **Full citation:** Herrera, J. A., Ordoñez, L. C., & Valdez, S. I. (2026). Hydrogen production potential in Mexico: An estimation. *International Journal of Hydrogen Energy*, 155317. https://doi.org/10.1016/j.ijhydene.2026.155317
- **BibTeX key:** `Herrera2026`
- **Source page(s):** p. 1-2 (reduction in feasible area once groundwater and drought conditions included)
- **Claim used:** incorporating groundwater availability and drought conditions into a national hydrogen siting assessment for Mexico reduced the feasible production area by more than 53% relative to a renewable-resource-only screening
- **Where cited:** Section 4.1, hydrogen-siting paragraph
- **Why this paper:** a second national-scale example (after Köhl et al.) of hydrological constraints substantially narrowing hydrogen siting feasibility, supporting the argument that mean-flow-based screening overestimates available water. Worklist item 2.2.

### 17. Uçar (2026) — Spatial optimization of green hydrogen production hubs for Türkiye

- **File:** `Biblio/1-s2.0-S0360319926036700-main.pdf`
- **Full citation:** Uçar, M. G. (2026). Spatial optimization of green hydrogen production hubs and capacity allocation: A hybrid MCDA-MILP framework for Türkiye. *International Journal of Hydrogen Energy*, 157032. https://doi.org/10.1016/j.ijhydene.2026.157032
- **BibTeX key:** `Ucar2026`
- **Source page(s):** p. 1 (abstract, multi-criteria decision analysis combined with water constraints)
- **Claim used:** regional siting study combining multi-criteria decision analysis with water availability constraints, at national/regional temporal resolution rather than seasonal
- **Where cited:** Section 4.1, hydrogen-siting paragraph, listed alongside El-Aassar (Egypt) and Raja et al. (Pakistan)
- **Why this paper:** broadens the geographic range of comparable siting studies beyond Germany/Mexico, supporting the statement that none of the compared studies use seasonal, subcatchment-resolved hydrology. Worklist item 2.2.

### 18. El-Aassar, Hagagg & Hussien (2026) — Multicriteria site suitability for solar-powered green hydrogen production in Egypt

- **File:** `Biblio/s41598-026-44081-8.pdf`
- **Full citation:** El-Aassar, A. M., Hagagg, K. H., & Hussien, R. A. (2026). Multicriteria site suitability for solar-powered green hydrogen production plants along the Northwestern coast of Egypt. *Scientific Reports*. https://doi.org/10.1038/s41598-026-44081-8
- **BibTeX key:** `ElAassar2026`
- **Source page(s):** p. 1 (abstract, multi-criteria decision analysis with water quality/availability constraints)
- **Claim used:** regional siting study combining multi-criteria decision analysis with water availability and quality constraints for coastal Egypt
- **Where cited:** Section 4.1, hydrogen-siting paragraph
- **Why this paper:** second of the three regional siting comparators used to make the same point as Uçar 2026 above. Worklist item 2.2.

### 19. Raja, Ahmad, Feroze, Jahanzeb, Usman & Genc (2026) — Probabilistic resilience and circular-resource assessment of solar-green hydrogen hybrid systems in Pakistan

- **File:** `Biblio/1-s2.0-S0196890426000531-main.pdf`
- **Full citation:** Raja, I. B., Ahmad, Y., Feroze, T., Jahanzeb, M., Usman, M., & Genc, B. (2026). Probabilistic resilience and circular-resource assessment of solar-green hydrogen hybrid systems (SGHHS) with industrial waste water reuse across varying climatic regions of Pakistan. *Energy Conversion and Management*, 121084. https://doi.org/10.1016/j.enconman.2026.121084
- **BibTeX key:** `Raja2026`
- **Source page(s):** p. 1-2, p. 7 (more than 90% reduction in freshwater abstraction via industrial wastewater reuse)
- **Claim used:** coupling hydrogen production with industrial wastewater reuse can reduce freshwater abstraction by more than 90% relative to conventional supply
- **Where cited:** Section 4.1, hydrogen-siting paragraph, final sentence noting relevance to the most water-constrained western catchments
- **Why this paper:** gives a concrete, quantified alternative-supply option (wastewater reuse) directly relevant to the recommendation that constrained western catchments in this study may need alternative water sources. Worklist item 2.2.

### 20. Yolcan (2026) — HydroNexus: A global techno-economic framework for resolving the energy-water conflict in green hydrogen production

- **File:** `Biblio/1-s2.0-S0360319926018951-main.pdf`
- **Full citation:** Yolcan, O. O. (2026). HydroNexus: A global techno-economic framework for resolving the energy-water conflict in green hydrogen production. *International Journal of Hydrogen Energy*, 155257. https://doi.org/10.1016/j.ijhydene.2026.155257
- **BibTeX key:** `Yolcan2026`
- **Source page(s):** p. 1, p. 4 (more than 60% of high-potential solar zones facing critical water scarcity; winter production framing)
- **Claim used:** more than 60% of high-potential solar zones worldwide face critical water scarcity; winter production is identified as a way to bridge a seasonal energy-water gap at higher latitudes
- **Where cited:** Section 4.1, closing sentence of the hydrogen-siting paragraph
- **Why this paper:** the winter-production framing is consistent with the winter Q10 increase this study projects under climate change, linking a global-scale finding to the seasonal results in Section 3.3. Worklist item 2.2.

### 21. Tharme (2003) — A global perspective on environmental flow assessment

- **File:** `Biblio/River Research   Apps - 2003 - Tharme - A global perspective on environmental flow assessment  emerging trends in the.pdf`
- **Full citation:** Tharme, R. E. (2003). A global perspective on environmental flow assessment: emerging trends in the development and application of environmental flow methodologies for rivers. *River Research and Applications*, 19(5-6), 397-441. https://doi.org/10.1002/rra.736
- **BibTeX key:** `Tharme2003`
- **Source page(s):** p. 1 (well over 200 methodologies, at least 44 countries; hydrological/Tennant-type methods approx. 30% of applications)
- **Claim used:** global environmental flow assessment comprises well over 200 distinct methodologies applied in at least 44 countries; reconnaissance-level hydrological methods, including Tennant-method variants, account for roughly 30% of applications worldwide
- **Where cited:** Section 4.3, opening two sentences of the environmental flow paragraph
- **Why this paper:** the standard global survey of environmental flow methods, used to establish scale and context before narrowing to the specific quantitative studies (Pastor 2014, Messager 2024) that follow. Worklist item 2.3.

### 22. Linnansaari, Monk, Baird & Curry (2013) — Review of approaches and methods to assess Environmental Flows across Canada and internationally

- **File:** `Biblio/2012_039-eng.pdf`
- **Full citation:** Linnansaari, T., Monk, W. A., Baird, D. J., & Curry, R. A. (2013). Review of approaches and methods to assess Environmental Flows across Canada and internationally (Research Document 2012/039). Fisheries and Oceans Canada, Canadian Science Advisory Secretariat, Ottawa.
- **BibTeX key:** `Linnansaari2013`
- **Source page(s):** p. 1-2 (executive summary, inconsistent use of environmental flow terminology across jurisdictions)
- **Claim used:** environmental flow terminology is applied inconsistently across jurisdictions, complicating direct comparison between studies that use the same term to mean different things
- **Where cited:** Section 4.3, environmental flow paragraph
- **Why this paper:** a government technical review (Fisheries and Oceans Canada) rather than a journal article, giving a practitioner/regulatory perspective on terminology inconsistency that is directly relevant to how this study's own Q10-based indicator should be labelled and interpreted. Worklist item 2.3.

### 23. Messager, Dickens, Eriyagama & Tharme (2024) — Limited comparability of global and local estimates of environmental flow requirements

- **File:** `Biblio/Messager_2024_Environ._Res._Lett._19_024012.pdf`
- **Full citation:** Messager, M. L., Dickens, C. W. S., Eriyagama, N., & Tharme, R. E. (2024). Limited comparability of global and local estimates of environmental flow requirements to sustain river ecosystems. *Environmental Research Letters*, 19, 024012. https://doi.org/10.1088/1748-9326/ad1cb5
- **BibTeX key:** `Messager2024`
- **Source page(s):** p. 2 (1,194 sites across 25 countries; limited agreement between global and local EFR estimates)
- **Claim used:** benchmarking global environmental flow models against locally-derived estimates at 1,194 sites across 25 countries found limited agreement between the two, cautioning against applying a single global method uncritically at subcatchment scale
- **Where cited:** Section 4.3, environmental flow paragraph
- **Why this paper:** directly supports the recommendation that a Finland- or Baltic-specific EFR method would be preferable to a generic global rule for the catchments studied here. The DOI (10.1088/1748-9326/ad1cb5) was verified against Crossref after an initial transcription error was caught before committing. Worklist item 2.3.

### 24. Baghel, Gaur, Karthik & Dohare (2018) — Global Trends in Environmental Flow Assessment: An Overview (removed, see reference quality policy below)

- **File:** `Biblio/s40030-018-0332-5.pdf`
- **Full citation:** Baghel, D. S., Gaur, A., Karthik, M., & Dohare, D. (2018). Global Trends in Environmental Flow Assessment: An Overview. *Journal of The Institution of Engineers (India): Series A*. https://doi.org/10.1007/s40030-018-0332-5
- **BibTeX key:** `Baghel2018` (removed from `references.bib` and `agujournaltemplate.tex` this batch; entry kept here for audit continuity)
- **Source page(s):** p. 1 (abstract, review conclusion that no single method is universally best)
- **Claim used:** reviews of environmental flow methodology consistently find that no single method performs best across all criteria
- **Where cited:** was cited jointly with Gopal 2013 in Section 4.3; no longer cited as of this batch
- **Why this paper was removed:** a low-circulation, narrow-scope regional engineering journal duplicating a claim already fully supported by `Gopal2013`. See "Reference quality policy" below.

### 25. Gopal (2013) — Methodologies for the assessment of environmental flows

- **File:** `Biblio/134 Methodologies for environmental flows.pdf`
- **Full citation:** Gopal, B. (2013). Methodologies for the assessment of environmental flows. In B. Gopal (Ed.), *Environmental Flows: An Introduction for Water Resources Managers* (pp. 129-182). National Institute of Ecology, New Delhi.
- **BibTeX key:** `Gopal2013`
- **Source page(s):** pp. 129-134 (introductory overview of methodology diversity and lack of consensus)
- **Claim used:** no single method performs best across all criteria (now the sole citation for this claim, following removal of Baghel2018)
- **Where cited:** Section 4.3, environmental flow paragraph
- **Why this paper:** a book chapter (rather than journal article) giving a manager-facing synthesis of methodological diversity. Worklist item 2.3.

### 26. Pastor, Ludwig, Biemans, Hoff & Kabat (2014) — Accounting for environmental flow requirements in global water assessments

- **File:** `Biblio/hess-18-5041-2014.pdf` (published version used; the duplicate preprint `Accounting_for_environmental_flow_requir.pdf` in the same folder was excluded as it is the same paper)
- **Full citation:** Pastor, A. V., Ludwig, F., Biemans, H., Hoff, H., & Kabat, P. (2014). Accounting for environmental flow requirements in global water assessments. *Hydrology and Earth System Sciences*, 18, 5041-5059. https://doi.org/10.5194/hess-18-5041-2014
- **BibTeX key:** `Pastor2014`
- **Source page(s):** p. 1, pp. 9-11 (37% mean annual EFR reservation, 46-71% during low-flow months)
- **Claim used:** comparing five global environmental flow methods against 11 locally-assessed case studies found that, on average, 37% of annual discharge was required to sustain environmental flows, rising to 46-71% during low-flow months
- **Where cited:** Section 4.3, environmental flow paragraph
- **Why this paper:** the most directly quantitative source found for how much of the gross Q10 reported in this study might need to be reserved for environmental flows once that step is carried out (identified as outstanding work in Section 4.3). Worklist item 2.3.

### 27. Brown & King (2010) — Environmental Flows in Shared Watercourses

- **File:** `Biblio/TransboundaryWaterManagementauthor_scopy1.pdf`
- **Full citation:** Brown, C., & King, J. (2010). Environmental Flows in Shared Watercourses: Review of Assessment Methods and Relevance in the Transboundary Setting. In A. Earle, A. Jägerskog, & J. Öjendal (Eds.), *Transboundary Water Management: Principles and Practice* (pp. 107-124). Earthscan, London and Washington, DC.
- **BibTeX key:** `BrownKing2010`
- **Source page(s):** pp. 107-109 (recommendation to incorporate environmental flow assessment early in water-resource planning)
- **Claim used:** environmental flow assessment is most useful when incorporated at an early stage of water-resource planning rather than retrofitted after siting decisions have already been made
- **Where cited:** Section 4.3, closing sentence of the environmental flow paragraph
- **Why this paper:** frames how the Q10 results in this study should be used going forward, as an early-stage siting input rather than a final abstraction limit, which is the practical takeaway for the reader. Worklist item 2.3.

### 28. Hatfield & Paul (2015) — A comparison of desktop hydrologic methods for determining environmental flows

- **File:** `Biblio/A comparison of desktop hydrologic methods for determining environmental flows.pdf`
- **Full citation:** Hatfield, T., & Paul, A. J. (2015). A comparison of desktop hydrologic methods for determining environmental flows. *Canadian Water Resources Journal*, 40(3), 303-318. https://doi.org/10.1080/07011784.2015.1050459
- **BibTeX key:** `HatfieldPaul2015`
- **Source page(s):** p. 1 (abstract, comparison of six desktop methods on three Canadian rivers)
- **Claim used:** a comparison of six desktop hydrological methods applied to three Canadian rivers found that method choice materially changes the resulting trade-off between water availability for abstraction and protection of ecosystem health
- **Where cited:** Section 4.3, environmental flow paragraph
- **Why this paper:** a concrete case study demonstrating that EFR method choice is not a neutral technical detail but changes the substantive result, reinforcing the caution raised via Messager 2024 about method sensitivity. Worklist item 2.3.

---

## Reference quality policy (added after user feedback, this batch)

The user flagged that some references added so far come from low-quality or "garbage" journals and asked for a stricter standard going forward. Applying this retroactively to the full bibliography turned up two issues, addressed below, and the policy now applied to all new additions is:

- Prefer specialty hydrology, water-resources, or energy journals from established publishers (Elsevier, Wiley, Springer Nature, Copernicus/EGU, IOP, Taylor & Francis, AGU/Wiley) or official government/agency technical reports.
- Treat MDPI journals (e.g. *Water*, *Remote Sensing*, *Sustainability*, *Applied Sciences*) as a flag requiring extra scrutiny, not an automatic exclusion. MDPI's rapid turnaround and volume-driven business model has drawn sustained criticism in the hydrology community (some MDPI titles were removed from Norway's national quality-assured journal list in 2020). An MDPI-published paper is only used if (a) no non-MDPI source makes the same claim, and (b) the specific claim is checkable and consistent with other evidence.
- Treat regional/national-scope engineering journals with low citation counts and narrow readership as candidates for replacement, especially when a claim is duplicated by a stronger source anyway.
- A PhD thesis is used only if no peer-reviewed journal version of the same work exists; where both exist, the peer-reviewed version is used and the thesis is not separately cited.
- Do not cite a paper purely because it contains the search keyword; check that the paper's actual finding, not just its title, supports the claim it is attached to.

**Action taken this batch:**

- **Removed `Baghel2018`** (Baghel, D. S., Gaur, A., Karthik, M., & Dohare, D. (2018). Global Trends in Environmental Flow Assessment: An Overview. *Journal of The Institution of Engineers (India): Series A*). This is a low-circulation, narrow-scope regional engineering journal and the specific claim it supported ("no single environmental flow method performs best across all criteria") is already fully supported by `Gopal2013`, a purpose-built book chapter on the same topic. Removing it loses no content and tightens reference quality. File remains in `Biblio/` but is no longer cited.
- **Flagged but not removed: `veijalainen2019severe`** (Veijalainen et al. (2019). Severe drought in Finland. *Sustainability*, 11(8), 2450, MDPI). This citation predates this literature review workflow entirely (added in commit `44ea4bb`, before the review process began) and is used in two important places: the Introduction (Water Act permitting context) and Section 4.2 (geographic pattern of Finnish drought vulnerability). *Sustainability* is one of the MDPI titles most frequently singled out for volume/rigor concerns. No replacement has been found yet; see `SEARCH_WORKLIST.md` new item 1.5 for suggested search terms to find a non-MDPI source that makes the same or a similar claim, either to replace or to supplement this citation.
- **Flagged but not removed: `HernandezHerraez2025`** (Applied Sciences, MDPI), added in the previous batch. This is currently the sole citation for the opening sentence of the Section 4.1 hydrogen-siting paragraph (the "80% GIS share" systematic review statistic). No non-MDPI alternative for this specific claim has been found. Recommend the user decide whether to keep it, seek a supplementary non-MDPI source, or rewrite the opening sentence to rely on the (non-MDPI) national siting studies that follow instead.

---

## Batch 3: Worklist item 2.4 (groundwater-surface water interaction limitation) and one item reassigned to 2.3

10 papers were supplied for worklist item 2.4 (representation of groundwater-surface water interaction in conceptual/semi-distributed models). Of these, 6 were integrated (the most directly on-topic and best-fitting journals); the other 4 were read but excluded as either redundant with the 6 used or a weaker topical fit, to avoid citation-stuffing a single limitation paragraph. One additional paper, supplied while searching for a substitute for worklist item 1.3 (Moriasi et al. 2007, still not found), was off-topic for 1.3 but was a good fit for the existing environmental flow paragraph (item 2.3) and was added there instead.

### 29. Pfannerstill, Guse & Fohrer (2014) — A multi-storage groundwater concept for the SWAT model

- **File:** `Biblio/Hydrological Processes - 2013 - Pfannerstill - A multi‐storage groundwater concept for the SWAT model to emphasize.pdf` (filename says 2013; the paper's formal publication year, verified via Crossref, is 2014 — it appeared online first in 2013)
- **Full citation:** Pfannerstill, M., Guse, B., & Fohrer, N. (2014). A multi-storage groundwater concept for the SWAT model to emphasize nonlinear groundwater dynamics in lowland catchments. *Hydrological Processes*, 28(22), 5599-5612. https://doi.org/10.1002/hyp.10062
- **BibTeX key:** `Pfannerstill2014`
- **Source page(s):** p. 1 (abstract: percent bias reduction from splitting the groundwater store)
- **Claim used:** splitting SWAT's two-storage groundwater module into fast- and slow-contributing aquifers reduced percent bias in the low segment of the flow duration curve from 46.8% to 14.8%
- **Where cited:** Section 4.3, new paragraph on groundwater representation limitations, immediately after the "Key uncertainties" paragraph
- **Why this paper:** the most directly quantitative demonstration that a lumped groundwater store (the same simplification HYPE uses) causes measurable low-flow bias, and that resolving fast/slow flow paths separately fixes it. Worklist item 2.4.

### 30. Samadi, Tufford & Carbone (2017) — Assessing Parameter Uncertainty of a Semi-Distributed Hydrology Model for a Shallow Aquifer Dominated Environmental System

- **File:** `Biblio/J American Water Resour Assoc - 2017 - Samadi - Assessing Parameter Uncertainty of a Semi‐Distributed Hydrology Model for a.pdf`
- **Full citation:** Samadi, S., Tufford, D. L., & Carbone, G. J. (2017). Assessing Parameter Uncertainty of a Semi-Distributed Hydrology Model for a Shallow Aquifer Dominated Environmental System. *Journal of the American Water Resources Association*, 53(6), 1368-1389. https://doi.org/10.1111/1752-1688.12596
- **BibTeX key:** `Samadi2017`
- **Source page(s):** p. 1 (abstract, sensitivity of parameter uncertainty to calibration algorithm and channel roughness)
- **Claim used:** parameter uncertainty in a semi-distributed model (SWAT) applied to a shallow, aquifer-dominated coastal watershed was sensitive to the choice of calibration algorithm and to channel roughness assumptions
- **Where cited:** Section 4.3, groundwater representation paragraph
- **Why this paper:** directly parallels HYPE's own situation (a semi-distributed model in a shallow-aquifer-influenced setting), supporting the point that such catchments carry structural uncertainty beyond a single calibrated parameter set. Note: an initial DOI transcription for this paper (10.1111/1752-1688.12522) was wrong and resolved to an unrelated snowmelt paper; corrected to 10.1111/1752-1688.12596 after a targeted Crossref bibliographic search, before the error reached the manuscript. Worklist item 2.4.

### 31. Efstratiadis, Nalbantis, Koukouvinos, Rozos & Koutsoyiannis (2008) — HYDROGEIOS: a semi-distributed GIS-based hydrological model for modified river basins

- **File:** `Biblio/hess-12-989-2008.pdf`
- **Full citation:** Efstratiadis, A., Nalbantis, I., Koukouvinos, A., Rozos, E., & Koutsoyiannis, D. (2008). HYDROGEIOS: a semi-distributed GIS-based hydrological model for modified river basins. *Hydrology and Earth System Sciences*, 12, 989-1006. https://doi.org/10.5194/hess-12-989-2008
- **BibTeX key:** `Efstratiadis2008`
- **Source page(s):** p. 1 (abstract, semi-distributed structure with explicit groundwater/surface-water allocation)
- **Claim used:** HYDROGEIOS couples a semi-distributed hydrological model to an explicit groundwater and surface-water allocation scheme for heavily modified river basins
- **Where cited:** Section 4.3, groundwater representation paragraph
- **Why this paper:** shows a concrete alternative model design that resolves the groundwater-surface water coupling HYPE simplifies, at a clearly stated cost in complexity, giving a fair point of comparison rather than an unqualified criticism. Worklist item 2.4.

### 32. Garavaglia, Le Lay, Gottardi, Garçon, Gailhard, Paquet & Mathevet (2017) — Impact of model structure on flow simulation and hydrological realism

- **File:** `Biblio/hess-21-3937-2017.pdf`
- **Full citation:** Garavaglia, F., Le Lay, M., Gottardi, F., Garçon, R., Gailhard, J., Paquet, E., & Mathevet, T. (2017). Impact of model structure on flow simulation and hydrological realism: from a lumped to a semi-distributed approach. *Hydrology and Earth System Sciences*, 21, 3937-3952. https://doi.org/10.5194/hess-21-3937-2017
- **BibTeX key:** `Garavaglia2017`
- **Source page(s):** p. 1 (abstract, 50-catchment comparison of lumped vs. semi-distributed structure)
- **Claim used:** comparing lumped and semi-distributed versions of the same model across 50 French mountain catchments found that spatial discretisation materially changed low-flow and snowpack representation
- **Where cited:** Section 4.3, groundwater representation paragraph, closing point about the 12 production-only catchments
- **Why this paper:** extends the limitation discussion beyond groundwater storage alone to spatial discretisation generally, directly relevant to this study's own production-only catchments that lack discharge observations. Worklist item 2.4.

### 33. Chen, Lucianetti & Hartmann (2023) — Understanding groundwater storage and drainage dynamics of a high mountain catchment with complex geology

- **File:** `Biblio/1-s2.0-S0022169423010090-main.pdf`
- **Full citation:** Chen, Z., Lucianetti, G., & Hartmann, A. (2023). Understanding groundwater storage and drainage dynamics of a high mountain catchment with complex geology using a semi-distributed process-based modelling approach. *Journal of Hydrology*, 625, 130067. https://doi.org/10.1016/j.jhydrol.2023.130067
- **BibTeX key:** `Chen2023`
- **Source page(s):** p. 1 (abstract, dual aquifer conceptualisation: fractured bedrock vs. unconsolidated slope deposits)
- **Claim used:** separating a fractured bedrock aquifer from an unconsolidated, coarse-material slope aquifer in a semi-distributed model produced markedly different drainage dynamics between the two
- **Where cited:** Section 4.3, groundwater representation paragraph
- **Why this paper:** the closest topical match to the manuscript's own wording ("coarse-material aquifers"); demonstrates concretely why a single lumped store cannot represent this distinction. Worklist item 2.4.

### 34. Tran, Willems & Huysmans (2019) — Coupling catchment runoff models to groundwater flow models in a multi-model ensemble approach

- **File:** `Biblio/s10040-019-02018-8.pdf` (the same author's 2019 KU Leuven PhD dissertation, `PhDmanuscript_TranQuocQuan.pdf`, covers overlapping material; the peer-reviewed journal version was used and the thesis was not separately cited, per the reference-quality policy above)
- **Full citation:** Tran, Q. Q., Willems, P., & Huysmans, M. (2019). Coupling catchment runoff models to groundwater flow models in a multi-model ensemble approach for improved prediction of groundwater recharge, hydraulic heads and river discharge. *Hydrogeology Journal*, 27, 3043-3061. https://doi.org/10.1007/s10040-019-02018-8
- **BibTeX key:** `Tran2019`
- **Source page(s):** p. 1 (abstract, trade-off between fully distributed and conceptual recharge models)
- **Claim used:** fully distributed, physically based recharge models are more reliable for impact studies extrapolating beyond the calibration range, but introduce equifinality challenges that simpler conceptual models avoid
- **Where cited:** Section 4.3, closing sentence of the groundwater representation paragraph
- **Why this paper:** frames the limitation as a genuine trade-off rather than a simple deficiency, consistent with the paragraph's overall tone. An initial page-range guess (2905-2921) was wrong and was corrected to 3043-3061 after Crossref verification, before the error reached the manuscript. Worklist item 2.4.

### 35. Sachin Ramesh & Thampi (2023) — Application of hydrologic and hydraulic methods to calculate the environmental flow requirements of the Chaliyar river

- **File:** `Biblio/s12665-023-10850-1.pdf`
- **Full citation:** Sachin Ramesh, V. V., & Thampi, S. G. (2023). Application of hydrologic and hydraulic methods to calculate the environmental flow requirements of the Chaliyar river. *Environmental Earth Sciences*, 82, 166. https://doi.org/10.1007/s12665-023-10850-1
- **BibTeX key:** `SachinRameshThampi2023`
- **Source page(s):** p. 1 (abstract, IHA and wetted-perimeter methods compared for three sub-basins)
- **Claim used:** applying hydrologic (IHA) and hydraulic (wetted perimeter) methods to the same river sub-basins gave different critical minimum flow estimates
- **Where cited:** Section 4.3, environmental flow paragraph, inserted as a catchment-scale example of the method-dependent divergence Messager et al. (2024) document at the global scale
- **Why this paper:** this paper surfaced while searching for a Moriasi et al. (2007) substitute (worklist item 1.3) and was off-topic for that need, but it directly strengthens the existing EFR discussion with a concrete case study, so it was reassigned here rather than discarded. *Environmental Earth Sciences* (Springer) is a legitimate, Scopus/Web of Science-indexed journal, though of more modest standing than the field's top specialty titles; used here as one supporting example among several stronger sources rather than as a sole citation.

---

## 🔴 CRITICAL — seminal sources still needed (unresolved after four search batches)

Two primary methodological citations remain unresolved despite four rounds of searching. Both are directly invoked by name in the manuscript's own language and a reviewer at *Water Resources Research* will very likely flag their absence. These are the single highest-priority items on the entire worklist.

- **Nash & Sutcliffe (1970)**, "River flow forecasting through conceptual models part I: A discussion of principles," *Journal of Hydrology*, 10(3), 282-290. This is the paper that defines the Nash-Sutcliffe Efficiency (NSE), the primary goodness-of-fit metric used throughout Sections 2, 3, and Table 2 of this manuscript. Four batches of candidate papers found by the user (real-time forecasting studies, landslide/rain-garden/Manning-roughness papers, SWAT application papers) have all turned out to be topically unrelated: they use NSE as one evaluation metric among several, but none of them is the founding paper or even discusses where NSE comes from. See worklist item 1.2 for updated, more targeted search strategies (exact-title quoted search, library discovery layer, ResearchGate, textbook fallback).
- **Moriasi et al. (2007)**, "Model evaluation guidelines for systematic quantification of accuracy in watershed simulations," *Transactions of the ASABE*, 50(3), 885-900. This is the standard reference for the NSE/PBIAS performance classification ("satisfactory," "good") used in the opening sentence of Section 3.1. Not found despite three search batches. See worklist item 1.3 for updated strategies, including the more accessible 2015 update and the ASABE society's own portal.

**What has been done instead, this batch:** rather than leave the manuscript's evaluation methodology under-cited while these two papers remain unfound, five additional, high-quality, directly relevant methodological papers were integrated (entries 36-40 below) that substantiate specific aspects of the calibration/validation approach: statistical rigor of fixed GOF thresholds, multi-objective calibration against water balance components, split-sample validation practice, parameter equifinality, and input data resolution effects. These strengthen the methods section considerably and partially substitute for what Moriasi and Nash & Sutcliffe would provide, but they are not replacements. The two founding papers should still be pursued.

---

## Batch 4: Worklist items 1.2/1.3 (partial), 2.5, 4.1, 4.2, 4.3 (38 PDFs supplied by user)

This batch also introduced the user's explicit request for stricter quality control ("make use of seminal papers, high quality papers and journals that are reputable"). Every candidate below was checked for (a) whether its actual content, not just its title, supports the claim it would be attached to, and (b) journal/publisher reputation, before being added. Several candidates were excluded specifically on these grounds; see the "Papers read but not cited" subsections below and in-line notes.

### 36. Ritter & Muñoz-Carpena (2013) — Performance evaluation of hydrological models: Statistical significance for reducing subjectivity in goodness-of-fit assessments

- **File:** `Biblio/1-s2.0-S0022169412010608-main.pdf`
- **Full citation:** Ritter, A., & Muñoz-Carpena, R. (2013). Performance evaluation of hydrological models: Statistical significance for reducing subjectivity in goodness-of-fit assessments. *Journal of Hydrology*, 480, 33-45. https://doi.org/10.1016/j.jhydrol.2012.12.004
- **BibTeX key:** `RitterMunozCarpena2013`
- **Source page(s):** p. 1 (abstract, block bootstrapping for statistical significance of GOF metrics)
- **Claim used:** fixed goodness-of-fit thresholds do not account for sample size or residual autocorrelation, and confidence-interval-based significance testing via block bootstrapping is a less subjective alternative
- **Where cited:** Section 2.2.5, model evaluation metrics, immediately following the FDC diagnostics sentence
- **Why this paper:** a highly-cited (1000+ citations), methodologically rigorous *Journal of Hydrology* paper that directly engages with the exact critique a reviewer might raise about fixed NSE/PBIAS thresholds; used here to acknowledge the limitation of the fixed-threshold convention while the primary source for that convention (Moriasi et al. 2007) remains unfound. Worklist items 1.2/1.3 (partial, does not replace Moriasi).

### 37. Pfannerstill, Bieger, Guse, Bosch, Fohrer & Arnold (2017) — How to Constrain Multi-Objective Calibrations of the SWAT Model Using Water Balance Components

- **File:** `Biblio/J American Water Resour Assoc - 2017 - Pfannerstill - How to Constrain Multi‐Objective Calibrations of the SWAT Model Using.pdf`
- **Full citation:** Pfannerstill, M., Bieger, K., Guse, B., Bosch, D. D., Fohrer, N., & Arnold, J. G. (2017). How to Constrain Multi-Objective Calibrations of the SWAT Model Using Water Balance Components. *JAWRA Journal of the American Water Resources Association*, 53, 532-546. https://doi.org/10.1111/1752-1688.12524
- **BibTeX key:** `Pfannerstill2017`
- **Source page(s):** p. 1 (abstract, discharge-only calibration does not guarantee realistic water balance)
- **Claim used:** a good discharge simulation is not necessarily evidence of a realistic simulation of hydrological processes within the catchment; constraining calibration against water balance components (surface runoff, groundwater flow, evapotranspiration) in addition to discharge produces a more robust calibration
- **Where cited:** Section 2.2.5, immediately after the Ritter & Muñoz-Carpena citation
- **Why this paper:** same lead author as the already-cited `Pfannerstill2014` groundwater paper, and directly names a limitation (discharge-only calibration) that applies to this study's own PEST calibration, which had no independent water balance observations to constrain against. Worklist item 1.3 (does not replace Moriasi, but strengthens the methods discussion around it).

### 38. Arsenault, Brissette & Martel (2018) — The hazards of split-sample validation in hydrological model calibration

- **File:** `Biblio/1-s2.0-S0022169418307145-main.pdf`
- **Full citation:** Arsenault, R., Brissette, F., & Martel, J.-L. (2018). The hazards of split-sample validation in hydrological model calibration. *Journal of Hydrology*, 566, 346-362. https://doi.org/10.1016/j.jhydrol.2018.09.027
- **BibTeX key:** `Arsenault2018`
- **Source page(s):** p. 1 (abstract, split-sample calibration/validation practice)
- **Claim used:** split-sample validation, calibrating on one period and validating on an independent withheld period, is standard practice for assessing whether calibrated parameters generalise beyond the fitting period
- **Where cited:** Section 2.2.4, sentence introducing the warm-up/calibration/validation period split
- **Why this paper:** directly names and examines the exact validation methodology used in this study (calibrate on 2017-2022, validate on 2023-2025); a *Journal of Hydrology* paper from an established Canadian hydrology research group, highly relevant despite not being found via the original Moriasi/Nash-Sutcliffe search terms.

### 39. Abbaspour (2021/2022) — The fallacy in the use of the "best-fit" solution in hydrologic modeling

- **File:** `Biblio/1-s2.0-S0048969721047884-main.pdf`
- **Full citation:** Abbaspour, K. C. (2022). The fallacy in the use of the "best-fit" solution in hydrologic modeling. *Science of The Total Environment*, 802, 149713. https://doi.org/10.1016/j.scitotenv.2021.149713 (article available online 2021, formally issued in the 2022 volume)
- **BibTeX key:** `Abbaspour2021`
- **Source page(s):** p. 1 (abstract, non-uniqueness of the best objective function value and its parameter set)
- **Claim used:** the single best-fit parameter set from an automated calibration is not significantly better than the next-best values, whose parameter sets can differ substantially, so treating one calibrated realisation as definitive is misleading
- **Where cited:** Section 4.3, new sentence following the "Key uncertainties" paragraph, on equifinality in the PEST-calibrated parameter set
- **Why this paper:** a discussion piece by a leading SWAT/hydrological uncertainty researcher (Eawag/Texas A&M) in a well-regarded Elsevier journal, directly relevant because this study uses a single PEST-optimised parameter set without an ensemble or uncertainty bound around it.

### 40. Geza & McCray (2008) — Effects of soil data resolution on SWAT model stream flow and water quality predictions

- **File:** `Biblio/1-s2.0-S0301479707000990-main.pdf`
- **Full citation:** Geza, M., & McCray, J. E. (2008). Effects of soil data resolution on SWAT model stream flow and water quality predictions. *Journal of Environmental Management*, 88, 393-406. https://doi.org/10.1016/j.jenvman.2007.03.016
- **BibTeX key:** `Geza2008`
- **Source page(s):** p. 1 (abstract, STATSGO vs SSURGO soil database resolution comparison)
- **Claim used:** switching between coarse and fine-resolution soil databases changed the number of hydrological response units substantially and altered simulated streamflow accordingly
- **Where cited:** Section 4.3, same new sentence block, applied to the GTK 1:200,000-scale superficial deposits map used to derive HYPE soil classes in this study
- **Why this paper:** directly on-topic for a specific, previously uncited input-data-resolution uncertainty in this study's own soil classification pipeline.

### 41. Sanchez Nieminen & Laitinen (2025) — Understanding local opposition to renewable energy projects in the Nordic countries: A systematic literature review

- **File:** `Biblio/1-s2.0-S2214629625000763-main.pdf`
- **Full citation:** Sanchez Nieminen, G., & Laitinen, E. (2025). Understanding local opposition to renewable energy projects in the Nordic countries: A systematic literature review. *Energy Research & Social Science*, 128, 103995. https://doi.org/10.1016/j.erss.2025.103995
- **BibTeX key:** `SanchezNieminen2025`
- **Source page(s):** p. 1 (abstract, 60 peer-reviewed studies 2014-2024, drivers of local conflict)
- **Claim used:** local opposition to Nordic renewable energy projects is driven by environmental disruption, distrust in regulatory processes, inadequate compensation, and threats to cultural heritage; equitable, culturally sensitive engagement is recommended to avoid delays
- **Where cited:** Section 4.5, "Social dimensions and distributional impacts," alongside the existing Laukka et al. (2021) MAR citation
- **Why this paper:** *Energy Research & Social Science* is the leading specialty journal in this subfield (Elsevier, high impact factor); this is the strongest available source for worklist item 2.5 and by far the best fit found. Notably co-authored by a VTT (Technical Research Centre of Finland) researcher, the same institute delivering this manuscript's underlying water assessment.

### 42. Qin, Zhai & Quillinan (2025) — Comparative Life Cycle Water Use Assessment of Diverse Hydrogen Production Pathways

- **File:** `Biblio/es5c14837.pdf`
- **Full citation:** Qin, D., Zhai, H., & Quillinan, S. (2025). Comparative Life Cycle Water Use Assessment of Diverse Hydrogen Production Pathways. *Environmental Science & Technology*, 59, 25237-25250. https://doi.org/10.1021/acs.est.5c14837
- **BibTeX key:** `Qin2025`
- **Source page(s):** pp. 1-2 (introduction, pathway comparison and treatment-loss underestimation)
- **Claim used:** wind-powered electrolysis has the lowest life cycle water use of any hydrogen production pathway; electricity source materially changes the water footprint; unrecoverable concentrate losses from non-traditional feedwater treatment (brackish water, wastewater) are often left out of water use estimates
- **Where cited:** Introduction, electrolyser water consumption paragraph, second half
- **Why this paper:** *Environmental Science & Technology* is a top-tier ACS journal (impact factor consistently above 10) and this is the most comprehensive, most rigorous life cycle water use comparison found across production pathways. Strongest possible source for this claim.

### 43. Santos Sánchez, Nonato, Silva, dos Reis Nogueira, Rebello, Medeiros & Hunt (2026) — Water Consumption in Hydrogen Production Through Electrolysis: Overview, State-of-the-Art, and Future Trends

- **File:** `Biblio/WIREs Energy   Environment - 2026 - Sánchez - Water Consumption in Hydrogen Production Through Electrolysis  Overview .pdf`
- **Full citation:** Santos Sánchez, A., Nonato, G. V., Silva, A. L., dos Reis Nogueira, I. B., Rebello, C. M., Medeiros, D. L., & Hunt, J. D. (2026). Water Consumption in Hydrogen Production Through Electrolysis: Overview, State-of-the-Art, and Future Trends. *WIREs Energy and Environment*, 15, e70035. https://doi.org/10.1002/wene.70035
- **BibTeX key:** `SantosSanchez2026`
- **Source page(s):** p. 1 (abstract, 17.5 L/kg average consumption, 51%/49% process/cooling split)
- **Claim used:** PEM electrolysis, the more water-efficient of the two commercial technologies, consumes an average of 17.5 L of water per kg of hydrogen, with 51% used directly in electrolysis and 49% allocated to cooling
- **Where cited:** Introduction, electrolyser water consumption paragraph, replacing the previous single "close to 9 litres per kilogram" figure with this more precise, explicitly sourced breakdown
- **Why this paper:** *WIREs Energy and Environment* is a well-regarded Wiley review journal (open access); this is a dedicated, up-to-date overview specifically on electrolysis water consumption, giving the exact figure the Introduction needed a citation for.

### 44. Dillon et al. (2019) — Sixty years of global progress in managed aquifer recharge

- **File:** `Biblio/s10040-018-1841-z.pdf`
- **Full citation:** Dillon, P., Stuyfzand, P., Grischek, T., et al. (30 co-authors) (2019). Sixty years of global progress in managed aquifer recharge. *Hydrogeology Journal*, 27, 1-30. https://doi.org/10.1007/s10040-018-1841-z
- **BibTeX key:** `Dillon2019`
- **Source page(s):** p. 1 (abstract, global MAR practice synthesis)
- **Claim used:** intentional groundwater replenishment (MAR) is a well-established, if unevenly regulated, tool for balancing seasonal and inter-annual water supply variability, based on 60 years of accumulated global experience
- **Where cited:** Introduction, MAR paragraph, opening sentence of the expanded global-context material
- **Why this paper:** the seminal MAR review in the field, authored collectively by the International Association of Hydrogeologists' MAR commission (30 co-authors representing national MAR programmes worldwide) and published in *Hydrogeology Journal*, the IAH's own journal. This is the single strongest possible citation for worklist item 4.2.

### 45. Kløve, Kvitsand, Pitkänen, Gunnarsdottir, Gaut, Gardarsson, Rossi & Miettinen (2017) — Overview of groundwater sources and water-supply systems, and associated microbial pollution, in Finland, Norway and Iceland

- **File:** `Biblio/s10040-017-1552-x.pdf`
- **Full citation:** Kløve, B., Kvitsand, H. M. L., Pitkänen, T., Gunnarsdottir, M. J., Gaut, S., Gardarsson, S. M., Rossi, P. M., & Miettinen, I. (2017). Overview of groundwater sources and water-supply systems, and associated microbial pollution, in Finland, Norway and Iceland. *Hydrogeology Journal*, 25, 1033-1044. https://doi.org/10.1007/s10040-017-1552-x
- **BibTeX key:** `Klove2017`
- **Source page(s):** p. 1 (abstract, seasonal recharge timing)
- **Claim used:** groundwater recharge in Finland, Norway, and Iceland is typically highest in autumn, winter, or following snowmelt
- **Where cited:** Introduction, MAR paragraph, linking Nordic groundwater seasonality to the surface water low-flow seasonality identified in this study
- **Why this paper:** directly Finland-specific (one of only three countries covered) and published in *Hydrogeology Journal*; the seasonal recharge timing finding connects naturally to this study's own seasonal Q10 framing, a link the previous version of this paragraph did not make.

### 46. Sprenger, Hartog, Hernández, Vilanova, Grützmacher, Scheibler & Hannappel (2017) — Inventory of managed aquifer recharge sites in Europe: historical development, current situation and perspectives

- **File:** `Biblio/s10040-017-1554-8.pdf`
- **Full citation:** Sprenger, C., Hartog, N., Hernández, M., Vilanova, E., Grützmacher, G., Scheibler, F., & Hannappel, S. (2017). Inventory of managed aquifer recharge sites in Europe: historical development, current situation and perspectives. *Hydrogeology Journal*, 25, 1909-1922. https://doi.org/10.1007/s10040-017-1554-8
- **BibTeX key:** `Sprenger2017`
- **Source page(s):** p. 1 (abstract, 224 MAR sites across 23 European countries)
- **Claim used:** a systematic European inventory identifies 224 active MAR sites across 23 countries, supplying substantial volumes of drinking water
- **Where cited:** Introduction, MAR paragraph, giving European-scale context between the global (Dillon et al.) and Finnish (Kurki et al.) scales already present
- **Why this paper:** fills the missing continental-scale link in the existing global-to-Finland citation chain; *Hydrogeology Journal* again.

### 47. Barthel, Stangefelt, Giese, Nygren, Seftigen & Chen (2021) — Current understanding of groundwater recharge and groundwater drought in Sweden compared to countries with similar geology and climate

- **File:** `Biblio/Current understanding of groundwater recharge and groundwater drought in Sweden compared to countries with similar geology and climate.pdf`
- **Full citation:** Barthel, R., Stangefelt, M., Giese, M., Nygren, M., Seftigen, K., & Chen, D. (2021). Current understanding of groundwater recharge and groundwater drought in Sweden compared to countries with similar geology and climate. *Geografiska Annaler: Series A, Physical Geography*, 103, 323-345. https://doi.org/10.1080/04353676.2021.1969130
- **BibTeX key:** `Barthel2021`
- **Source page(s):** p. 1 (abstract, groundwater drought independent of surface water drought)
- **Claim used:** groundwater drought can develop and persist independently of surface water drought, particularly in unconfined aquifers with limited storage, in Sweden and geologically/climatically similar countries (which includes Finland)
- **Where cited:** Introduction, MAR paragraph, cautioning against assuming groundwater is a drought-proof substitute for constrained surface water
- **Why this paper:** *Geografiska Annaler* is a well-established (founded 1919), reputable Taylor & Francis physical geography journal; the paper is directly relevant to Nordic/Fennoscandian geology and is also a candidate the user should consider for worklist item 0.1 (as an alternative or supplement to the MDPI-published `veijalainen2019severe` drought citation), flagged separately in `SEARCH_WORKLIST.md`.

### 48. Seidl, Page & Wheeler (2026) — Reviewing regulatory settings and their impacts on managed aquifer recharge implementation: evidence from six countries

- **File:** `Biblio/1-s2.0-S1877343526000278-main.pdf`
- **Full citation:** Seidl, C., Page, D., & Wheeler, S. A. (2026). Reviewing regulatory settings and their impacts on managed aquifer recharge implementation: evidence from six countries. *Current Opinion in Environmental Sustainability*, 78, 101631. https://doi.org/10.1016/j.cosust.2026.101631
- **BibTeX key:** `Seidl2026`
- **Source page(s):** p. 1 (abstract, common regulatory barriers across six countries)
- **Claim used:** unclear water rights, absent MAR-specific legislation, and complex permitting are common barriers to MAR implementation internationally, not a distinctly Finnish problem
- **Where cited:** Introduction, MAR paragraph, alongside the existing Laukka et al. (2021) Finnish MAR governance citation
- **Why this paper:** *Current Opinion in Environmental Sustainability* is a well-regarded Elsevier "Current Opinion" series journal; this internationalises the governance-challenge claim that was previously supported only by a single Finnish case study.

### 49. IPCC (2023) — Climate Change 2023: Synthesis Report (AR6)

- **File:** `Biblio/IPCC_AR6_SYR_LongerReport.pdf` (two further duplicate copies of the same report, `IPCC_AR6_SYR_LongerReport (1).pdf` and `ARuaneIPCC6thAssessSynthesisAccepted.pdf`, were identified as the same document and not separately catalogued)
- **Full citation:** IPCC (2023). Climate Change 2023: Synthesis Report. Contribution of Working Groups I, II and III to the Sixth Assessment Report of the Intergovernmental Panel on Climate Change [Core Writing Team, H. Lee and J. Romero (eds.)]. IPCC, Geneva, Switzerland, pp. 35-115. https://doi.org/10.59327/IPCC/AR6-9789291691647
- **BibTeX key:** `IPCC_AR6_SYR2023`
- **Source page(s):** front matter (SSP scenario framework, core writing team)
- **Claim used:** SSP2-4.5 is one of the core scenarios assessed in the IPCC Sixth Assessment Report and represents an intermediate greenhouse gas emissions trajectory
- **Where cited:** Section 2.2.7 (Scenario analysis), climate change scenario description, replacing the prior `% TODO` marker for a general IPCC framing citation
- **Why this paper:** the official IPCC assessment report is the gold-standard citation for situating a specific emissions pathway (SSP2-4.5) within the broader international climate assessment framework, exactly as worklist item 4.3 requested. Not journal-peer-reviewed in the conventional sense, but subject to an extensive multi-stage government and expert review process that is widely regarded as at least as rigorous.

### 50. IPCC (2022) — Climate Change 2022: Impacts, Adaptation and Vulnerability. Summary for Policymakers (AR6 WGII)

- **File:** `Biblio/IPCC_AR6_WGII_SummaryForPolicymakers.pdf`
- **Full citation:** IPCC (2022). Climate Change 2022: Impacts, Adaptation and Vulnerability. Summary for Policymakers. Contribution of Working Group II to the Sixth Assessment Report of the Intergovernmental Panel on Climate Change [Pörtner, H.-O. et al. (eds.)]. Cambridge University Press, Cambridge, UK and New York, USA. https://doi.org/10.1017/9781009325844.001
- **BibTeX key:** `IPCC_AR6_WGII_SPM2022`
- **Source page(s):** front matter (SPM scope: impacts, adaptation, vulnerability)
- **Claim used:** freshwater availability is among the climate-sensitive systems for which impacts scale substantially with emissions pathway, implying higher-emission scenarios than SSP2-4.5 would produce more severe summer low-flow reductions than reported in this study
- **Where cited:** Section 2.2.7, immediately after the AR6 SYR citation, framing the single-pathway limitation
- **Why this paper:** official IPCC WGII assessment; the chapter-level DOI (`.001` suffix) was verified against Crossref to confirm it resolves specifically to the Summary for Policymakers rather than the full report.

### 51. Diez-Sierra et al. (2022) — The Worldwide C3S CORDEX Grand Ensemble: A Major Contribution to Assess Regional Climate Change in the IPCC AR6 Atlas

- **File:** `Biblio/bams-BAMS-D-22-0111.1.pdf`
- **Full citation:** Diez-Sierra, J., Iturbide, M., Gutiérrez, J. M., et al. (2022). The Worldwide C3S CORDEX Grand Ensemble: A Major Contribution to Assess Regional Climate Change in the IPCC AR6 Atlas. *Bulletin of the American Meteorological Society*, 103, E2804-E2826. https://doi.org/10.1175/BAMS-D-22-0111.1
- **BibTeX key:** `DiezSierra2022`
- **Source page(s):** p. 1 (abstract, CORDEX ensemble underpinning the IPCC AR6 Atlas)
- **Claim used:** the multi-model regional climate ensemble (CORDEX) underpinning the IPCC AR6 Atlas provides the regional climate change patterns for Northern Europe against which this study's FMI-derived delta-change factors can be situated
- **Where cited:** Section 2.2.7, same sentence block as the IPCC SYR citation
- **Why this paper:** *Bulletin of the American Meteorological Society* is a top-tier AMS journal; this paper is the primary reference for the regional climate modelling infrastructure behind the IPCC AR6 Atlas, giving a peer-reviewed methodological anchor alongside the IPCC's own institutional reports.

---

## Papers read but excluded this batch (quality control and topical fit)

Following the user's explicit instruction to prioritise seminal, high-quality, reputable sources, the following candidates were read in full and excluded. This section exists so the reasoning is auditable; none of these are cited in `references.bib` or the manuscript.

**Excluded as topically irrelevant to the claim searched for (title matched search terms, content did not):**
- Seven "conceptual model" real-time forecasting papers found while searching for the Nash & Sutcliffe (1970) NSE origin paper (worklist item 1.2): Kitanidis & Bras (1980, *Water Resources Research*, two parts), Zhang et al. (2018, *Stochastic Environmental Research and Risk Assessment*), Turan & Yurdusev (2015, *Water Resources Management*), Xiong & O'Connor (2002, *Hydrological Sciences Journal*), Napolitano et al. (2010, *Journal of Hydrology*), and Dibike & Solomatine (2001, *Physics and Chemistry of the Earth*). These are legitimate, in some cases seminal, papers in real-time hydrological forecasting and data assimilation (the Kitanidis & Bras papers in particular are classics in that subfield), but none of them define or discuss the origin of NSE, and this manuscript does not perform real-time/operational forecasting, so none had a natural home elsewhere either. Not cited.
- Krishnan et al. (2024, *International Journal of Hydrogen Energy*), "Prospective LCA of alkaline and PEM electrolyser systems," and two papers by Koj, Zapp, Wieland, Görner & Kuckshinrichs (2024, *Energy, Sustainability and Society*; 2025, *Journal of Industrial Ecology*), all found under worklist item 4.1 (electrolyser water consumption). All three are legitimate LCA papers in reputable journals, but on inspection none of them actually discuss water consumption; they assess greenhouse gas emissions, cost, and other environmental impact categories for alkaline/PEM electrolysers. Citing them for a water-consumption claim would have been a title-match rather than a content-match, which the user's quality-control instruction specifically asked to guard against. Not cited.
- Wang et al. (2024, *Applied Energy*), "Comparative experimental study of alkaline and proton exchange membrane water electrolysis for green hydrogen production." A reputable, high-impact journal, but the paper is about dynamic response and cold-start performance, not water consumption. Same reasoning as above. Not cited.
- Rumayor et al. (2022, *Journal of Cleaner Production*), "Prospective life cycle assessment of hydrogen production by waste photoreforming." Legitimate journal, but the production pathway (photoreforming) is outside the PEM/alkaline electrolysis scope of the Introduction's water-consumption paragraph. Not cited.

**Excluded on publication-type or quality grounds (per the reference quality policy):**
- Cheng & Kristoffersen, "Beyond Community Acceptance: Examining Energy Justice in Northern Norway's Green Hydrogen Transition" (SSRN preprint, DOI 10.2139/ssrn.6582674). Topically an excellent fit for worklist item 2.5 (arguably better than the paper that was used), but confirmed via Crossref to exist only as an unpublished SSRN preprint with no peer-reviewed version yet. Flagged in `SEARCH_WORKLIST.md` for the user to watch for publication; not cited while unpublished.
- Alfasfos, "Towards a Resilient Hydrogen Economy: Climate Impact, Safety, Cybersecurity, and the Foundations for Public Trust" (PhD dissertation, Acta Universitatis Lappeenrantaensis). A Crossref search for published constituent papers found only cybersecurity/safety conference papers by the same author, not on the water/siting/public-trust theme needed here. Thesis not cited per the quality policy (peer-reviewed version preferred when it exists; here the closest published counterparts are off-topic).
- Aaltonen, Jääskä & Kujala, "Approaches to social license to operate (SLO) in emerging nuclear projects" (University of Oulu research report, not peer-reviewed, nuclear-specific). Wrong sector (nuclear, not hydrogen or general renewables) and not peer-reviewed. Not cited.
- Danilova, "Permitting Procedures for Renewable Energy Projects in the European Union" (MSc thesis, TU Wien, 2024). Master's-level thesis, not peer-reviewed; the weakest publication type encountered this session. Not cited.
- Heikkinen, "Fast, Cheap and Popular – Can You Have All Three? Comparing Reverse Auctions for Renewable Energy in Finland and Australia" (PhD thesis, University of Technology Sydney). About renewable energy procurement/auction market design, not social acceptance of siting; weak topical fit even setting aside publication type. Not cited.
- de Witt, Roets & Watson (2025, *Hydrogeology Journal*), "Review: Implementation challenges of managed aquifer recharge in developing countries." Legitimate journal, but the paper's scope (developing-country implementation barriers: financing, capacity, piloting-phase struggles) has weak relevance to Finland's mature, well-regulated MAR context. Not cited, to keep the MAR paragraph focused.
- Seidl, Page & Wheeler (2024, *Water Security*), "Using managed aquifer recharge to address land subsidence: Insights from a global literature review." Land subsidence from groundwater over-extraction is not a relevant risk in Finland's till/bedrock geological setting. Not cited.
- Zhang, Xu & Kanyerere (2020, *Physics and Chemistry of the Earth*) and Sinshaw, Dahlke, Viers & Safeeq (2026, *Environmental Reviews*), both general global MAR reviews. Both are legitimate, reasonably-regarded journals, but their content substantially overlaps with the more authoritative and more widely cited Dillon et al. (2019) review already used; kept the stronger single source rather than stacking three overlapping global reviews. Not cited.
- Taylor, Aureli, Allen, Banks, Villholth & Stigter, "Groundwater, aquifers and climate change" (UNESCO-IHP/IAH book chapter). Authoritative institutional body, but a book chapter rather than a peer-reviewed journal article, and its content overlaps with Dillon et al. (2019). Not cited.
- Iturbide et al. (2022, *Scientific Data*), "Implementation of FAIR principles in the IPCC: the WGI AR6 Atlas repository." A legitimate Nature-family peer-reviewed paper, but it describes data infrastructure and repository design (FAIR data principles) rather than regional climate projections themselves; tangential to the claim needed here. Not cited.
- IPCC AR6 WGI Chapter 1, "Framing, Context, and Methods." Official IPCC chapter, but its content is general methodological framing for the whole WGI report rather than material specific to regional projections or the SSP2-4.5 pathway; the Synthesis Report and WGII SPM citations already used cover the framing need more directly. Not cited, to avoid redundant IPCC citations.

**Excluded as inappropriate for scientific citation (serious quality flag):**
- Crok, M., & May, A. (Eds.). *The Frozen Climate Views of the IPCC: An Analysis of AR6* (self-published via Clintel.org and "Andy May Petrophysicist LLC"). This is **not a legitimate scientific source**. Clintel is a climate-change-contrarian advocacy organisation, and this publication is a polemical critique disputing mainstream IPCC climate science; it is not peer-reviewed, not published by an academic or scientific press, and directly contradicts the physical basis (including SSP-based warming projections) that this manuscript's own climate change scenario relies on. Citing it in an AGU journal submission would be a serious credibility problem, not a minor quality issue. Flagged here explicitly so it is never mistaken for a usable source in a future pass. **Do not cite.**


### Papers read but not cited (this batch)

The following papers, supplied for worklist items 1.2, 1.3, and 2.4, were read and judged not to fit any current claim in the manuscript, or to be redundant with a stronger source already cited. They remain in `Biblio/` in case a future revision finds a use for them, but are not in `references.bib`.

- **For item 1.2 (NSE origin substitute):** none of the 6 papers found (landslide risk in Thailand, deep-learning stream temperature modelling, urban rain garden flood mitigation in Japan, Manning roughness rating-curve uncertainty, Jordan climate change impacts, Chaliyar river EFR methods) actually define or discuss the origin of the Nash-Sutcliffe Efficiency metric; they surfaced as general hydrology search results rather than answers to this specific citation need. The Chaliyar river paper was reassigned to item 2.3 (see entry 35). The rating-curve uncertainty paper (Vatanchi & Maghrebi 2019, *Water Resources Management*) is topically closest to a discharge-measurement-uncertainty argument but is narrowly scoped to one specific roughness-estimation method (isovel-contour rating curves tested on two rivers) and was judged too tangential to include without a stronger connecting claim.
- **For item 1.3 (Moriasi threshold substitute):** none of the 3 papers found (SWAT sediment transport in Taiwan, Kalman-filter soil moisture assimilation, Greek data-scarce catchment climate impacts) discuss goodness-of-fit performance thresholds; they are general SWAT/hydrological-modelling application papers that happen to report NSE values without defining classification bands.
- **For item 2.4 (groundwater representation, papers read but excluded):** El-Nasr et al. (2005, *Hydrological Processes*, distributed vs. semi-distributed model comparison) makes a similar point to Garavaglia et al. (2017) already cited and was judged redundant; Perrin et al. (2012, *Journal of Hydrology*, semi-arid Indian watershed water availability) is a weaker topical fit, being about general water availability assessment rather than groundwater store structure specifically; the Tran Quoc Quan PhD thesis (2019, KU Leuven) is superseded by the peer-reviewed journal paper from the same author already cited (`Tran2019`); Ouyang et al. (*Ecological Processes*, parameter uncertainty in a small headwater catchment in Northwest China) makes a similar parameter-uncertainty point to Samadi et al. (2017) already cited and was judged redundant.
