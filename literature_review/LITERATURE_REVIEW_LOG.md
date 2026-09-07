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

### Papers read but not cited (this batch)

The following papers, supplied for worklist items 1.2, 1.3, and 2.4, were read and judged not to fit any current claim in the manuscript, or to be redundant with a stronger source already cited. They remain in `Biblio/` in case a future revision finds a use for them, but are not in `references.bib`.

- **For item 1.2 (NSE origin substitute):** none of the 6 papers found (landslide risk in Thailand, deep-learning stream temperature modelling, urban rain garden flood mitigation in Japan, Manning roughness rating-curve uncertainty, Jordan climate change impacts, Chaliyar river EFR methods) actually define or discuss the origin of the Nash-Sutcliffe Efficiency metric; they surfaced as general hydrology search results rather than answers to this specific citation need. The Chaliyar river paper was reassigned to item 2.3 (see entry 35). The rating-curve uncertainty paper (Vatanchi & Maghrebi 2019, *Water Resources Management*) is topically closest to a discharge-measurement-uncertainty argument but is narrowly scoped to one specific roughness-estimation method (isovel-contour rating curves tested on two rivers) and was judged too tangential to include without a stronger connecting claim.
- **For item 1.3 (Moriasi threshold substitute):** none of the 3 papers found (SWAT sediment transport in Taiwan, Kalman-filter soil moisture assimilation, Greek data-scarce catchment climate impacts) discuss goodness-of-fit performance thresholds; they are general SWAT/hydrological-modelling application papers that happen to report NSE values without defining classification bands.
- **For item 2.4 (groundwater representation, papers read but excluded):** El-Nasr et al. (2005, *Hydrological Processes*, distributed vs. semi-distributed model comparison) makes a similar point to Garavaglia et al. (2017) already cited and was judged redundant; Perrin et al. (2012, *Journal of Hydrology*, semi-arid Indian watershed water availability) is a weaker topical fit, being about general water availability assessment rather than groundwater store structure specifically; the Tran Quoc Quan PhD thesis (2019, KU Leuven) is superseded by the peer-reviewed journal paper from the same author already cited (`Tran2019`); Ouyang et al. (*Ecological Processes*, parameter uncertainty in a small headwater catchment in Northwest China) makes a similar parameter-uncertainty point to Samadi et al. (2017) already cited and was judged redundant.
