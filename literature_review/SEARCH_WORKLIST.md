# Search worklist for literature review expansion

Current reference count: 50 entries in `references.bib` (was 19 at the start of this workflow, then 21 after batch 1, 44 after batch 2, and 50 after batch 3: +7 new entries for items 2.4 and 2.3, -1 for the removal of `Baghel2018` on reference-quality grounds, see Priority 0 below). Target: 30-40, now exceeded. This document lists concrete gaps in the manuscript's citation coverage, organised by section and priority. Each item gives search terms to run and, where a specific paper has already been checked against Crossref and confirmed to exist with correct metadata, that paper is named directly as a starting point.

Workflow: pick an item, search it, download the PDF, and drop it in `Biblio/`. Tell me which item number you found something for (or just tell me the filename) and I will read it, decide where it fits, write the citation into the manuscript, add the BibTeX entry, and log it in `LITERATURE_REVIEW_LOG.md`.

---

## Priority 1: Methodological citations that are currently missing entirely

These are the most urgent gap. The manuscript uses NSE and KGE as primary goodness-of-fit metrics throughout Sections 2 and 3, and states performance thresholds (NSE > 0.75 = good, 0.50-0.75 = satisfactory, |PBIAS| > 25% = poor) without citing where these definitions or thresholds come from. A reviewer will flag this.

**1.1 KGE origin paper** (verified via Crossref, exists exactly as expected)
- Gupta, H. V., Kling, H., Yilmaz, K. K., & Martinez, G. F. (2009). Decomposition of the mean squared error and NSE performance criteria: Implications for improving hydrological modelling. *Journal of Hydrology*, 377(1-2), 80-91. https://doi.org/10.1016/j.jhydrol.2009.08.003
- Needed to cite the origin of the KGE metric itself (correlation, bias ratio, variability ratio decomposition), used in Section 2.2.5 and throughout Results.

Note: Done

**STATUS: integrated.** Added as `Gupta2009` in `references.bib`, cited in Section 2.2.5. See `LITERATURE_REVIEW_LOG.md` entry 4.

**1.2 NSE origin paper** (not re-verified due to a rate limit on this search session, but this is one of the most cited papers in hydrology and the title/journal/year below are standard knowledge; confirm exact page numbers when you find it)
- Nash, J. E., & Sutcliffe, J. V. (1970). River flow forecasting through conceptual models part I: A discussion of principles. *Journal of Hydrology*, 10(3), 282-290.
- Search terms if the above does not resolve directly: `"Nash-Sutcliffe" 1970 "river flow forecasting through conceptual models"`

Note: This is a handbook: River flow forecasting through conceptual models, I : A discussion of principles, I do not have a pdf version o fthis. Lets look for other papers we can use

**STATUS: still open.** Not yet resolved as of this batch. Nash & Sutcliffe (1970) itself remains inaccessible as a PDF. Alternative sources to try: a textbook or review chapter that defines and cites NSE (e.g. Krause et al. 2005, already added, discusses NSE alongside logNSE and could partially cover this citation need), or a widely available secondary source that formally restates the NSE definition with its own citation to Nash & Sutcliffe 1970. Will revisit once you find something.


Updated notes: I collected some papers on the topic:

1) Landslide risk assessment using hydrological model in the Upper Yom River Basin, Thailand
2) Exploring the exceptional performance of a deep learning stream temperature model and the value of streamflow data
3) Flood mitigation function of rain gardens for management of urban storm runoff in Japan
4) Uncertainty in Rating-Curves Due to Manning Roughness Coefficient
5) Climate change impacts on surface water resources in arid and semi-arid regions: a case study in northern Jordan
6) Application of hydrologic and hydraulic methods to calculate the environmental flow requirements of the Chaliyar river

**STATUS: none of these fit.** All 6 papers were read. None of them define, discuss, or cite the origin of the Nash-Sutcliffe Efficiency metric itself; they are general hydrology/hydraulics application papers that surfaced because they use NSE as one of several evaluation metrics, not because they discuss where it comes from. Paper 6 (Chaliyar river) was topically a much better fit for item 2.3 (environmental flow methods) and was moved there instead (see `LITERATURE_REVIEW_LOG.md` entry 35). None of the other 5 have been used anywhere.

The problem is that generic searches for "Nash-Sutcliffe" or "NSE evaluation" return the thousands of papers that use the metric, not the 1970 paper that defines it. More targeted search strategies to try next:
- Search specifically for the paper by its exact title in quotes: `"River flow forecasting through conceptual models"` (with quotes, in Google Scholar or your library's discovery search, not a general web search)
- Try your university library's own catalogue/discovery layer directly rather than a search engine; a 1970 Journal of Hydrology paper is a standard holding at most university libraries with an Elsevier subscription, including via older bound-volume digitisation
- Try searching by author name only, restricted to 1970: `Nash Sutcliffe 1970 Journal of Hydrology` — sometimes filenames or repository listings use only the author/year, not the full title, as the discoverable text
- Check ResearchGate or Academia.edu for a version uploaded by a citing author (not the publisher), which is sometimes available even for very old papers when the publisher copy is paywalled
- As a fallback, a hydrology methods textbook that formally re-derives and cites the NSE formula (e.g. a chapter in *Applied Hydrology* by Chow, Maidment & Mays, or a similar standard textbook you may already have institutional access to) can stand in for the primary source, since textbook citations are normal practice for foundational, universally known formulas

**1.3 GOF performance threshold classification** (verified via Crossref)
- Moriasi, D. N., Arnold, J. G., Van Liew, M. W., Bingner, R. L., Harmel, R. D., & Veith, T. L. (2007). Model evaluation guidelines for systematic quantification of accuracy in watershed simulations. *Transactions of the ASABE*, 50(3), 885-900. https://doi.org/10.13031/2013.23153
- This is the standard reference for the NSE/PBIAS/RSR performance classification thresholds used in Section 3.1 (satisfactory/good/poor). Extremely widely cited (over 10,000 citations), a reviewer will expect to see it.

Note: cannot get this paper, look for other ones 

**STATUS: still open.** Moriasi et al. (2007) not yet found. This is the standard NSE/PBIAS/RSR threshold reference and worth continuing to search for; if it stays inaccessible, an alternative is the follow-up Moriasi et al. (2015) update ("Hydrologic and water quality models: Performance measures and evaluation criteria", *Transactions of the ASABE*, 58(6), 1763-1785), which restates the same threshold tables and may be easier to obtain.

Updated notes: I collected some papers on the topic:

1) Assessment of Sediment Transport Functions with the Modified SWAT-Twn Model for a Taiwanese Small Mountainous Watershed
2) Remotely Sensed Soil Moisture Assimilation in the Distributed Hydrological Model Based on the Error Subspace Transform Kalman Filter
3) Hydrological impacts of climate change on a data-scarce Greek catchment

**STATUS: none of these fit.** All 3 papers were read. None discuss goodness-of-fit performance thresholds; they are general SWAT/hydrological-modelling application papers that report NSE values without defining classification bands, for the same reason as the 1.2 batch above: NSE is used as one evaluation metric among several, but the threshold classification itself is not the topic. None have been used anywhere.

More targeted search strategies for the actual Moriasi et al. (2007) paper:
- Search the exact title in quotes: `"Model evaluation guidelines for systematic quantification of accuracy in watershed simulations"`
- Try the ASABE (American Society of Agricultural and Biological Engineers) journal website directly (`elibrary.asabe.org`), since Transactions of the ASABE is their own journal and older articles are sometimes accessible through the society's own portal even without a personal subscription
- Try searching for the newer, easier-to-access update instead of the original: `Moriasi 2015 "Hydrologic and water quality models" performance measures evaluation criteria Transactions ASABE` (DOI 10.13031/trans.58.10715) — this restates the same NSE/PBIAS/RSR threshold tables and may resolve this item even if the 2007 original stays inaccessible
- A widely cited SWAT-specific methods paper that also restates similar thresholds and is often open access via ResearchGate: Gassman, P. W., Reyes, M. R., Green, C. H., & Arnold, J. G. (2007). "The soil and water assessment tool: historical development, applications, and future research directions." *Transactions of the ASABE*, 50(4), 1211-1250

**1.4 logNSE / log-transformed efficiency for low-flow evaluation**
- Search terms: `log-transformed Nash-Sutcliffe efficiency low flow evaluation hydrological model`, `Krause Boyle Base weighted efficiency criteria hydrology 2005`
- Candidate: Krause, P., Boyle, D. P., & Base, F. (2005). Comparison of different efficiency criteria for hydrological model assessment. *Advances in Geosciences*, 5, 89-97. (Not yet verified against Crossref; check DOI when found.)
- Needed because the manuscript treats logNSE as "the most relevant performance indicator for this study" (Section 3.1) without citing why log-transformation is appropriate for low-flow assessment.

Note: Done

**STATUS: integrated.** Added as `Krause2005` in `references.bib`, cited in Section 2.2.5 alongside Gupta2009. See `LITERATURE_REVIEW_LOG.md` entry 5.

---

## Priority 2: Discussion section, marked as open TODOs in the manuscript text

**2.1 Nordic/Fennoscandian climate change impact on streamflow, beyond Finland alone**
Section 4.2 ("Comparison to existing Finnish and Nordic studies") currently only cites two Finnish papers plus one Finnish climate projection paper. It needs broader Nordic or Scandinavian comparison to justify the "Nordic" framing in its own heading.
- Search terms: `Sweden Norway streamflow climate change projection low flow`, `Scandinavia hydrological regime shift snow to rain climate warming`, `Fennoscandia river discharge seasonality climate change review`
- Also worth checking for a Baltic Sea region-wide or circum-Baltic hydrological synthesis paper, since this is a BalticSeaH2 project deliverable.

Note:
Papers found (titles placres here for you runderstanding:)

1) How will climate change modify river flow regimes in Europe?
2) Climate change impacts on runoff in – assessments by global climate models, dynamical downscaling and hydrological modelling
3) Climate change impacts on the seasonality and generation processes of floods – projections and uncertainties for catchments with mixed snowmelt/rainfall regimes
4) Has streamflow changed in the Nordic countries? – Recent trends and comparisons to hydrological projections
5) Flood seasonality across Scandinavia—Evidence of a shifting hydrograph?
6) Hydrological response to changing climate conditions: Spatial streamflow variability in the boreal region
7) Streamflow trends in Europe: evidence from a dataset of near-natural catchments
8) The potential impacts of climate and forest changes on streamflow for micro-, meso- and macro-scale catchments in Norway




**STATUS: integrated, item complete.** All 8 papers added to `references.bib` and cited in two new paragraphs in Section 4.2 (`agujournaltemplate.tex`). See `LITERATURE_REVIEW_LOG.md` entries 6-13.

**2.2 Water-energy nexus / siting studies for hydrogen production specifically (not just general hydrogen demand)**
The Introduction cites Terlouw (2024) and Ellersdorfer (2025) for global water-hydrogen constraints, but the Discussion has no international comparison for how other regions have approached hydrogen siting relative to water. This would strengthen Section 4.1 ("Comparison to other water-availability assessment approaches").
- Search terms: `green hydrogen siting water availability regional assessment`, `water footprint electrolysis site selection GIS`, `hydrogen production water stress index mapping`


Note:
Papers found (titles placres here for you runderstanding:)

1) The Role of Geospatial Techniques for Renewable Hydrogen Value Chain: A Systematic Review of Current Status, Challenges and Future Developments
2) HydroNexus: A global techno-economic framework for resolving the energy-water conflict in green hydrogen production
3) Spatial optimization of green hydrogen production hubs and capacity allocation: A hybrid MCDA–MILP framework for Türkiye
4) Multicriteria site suitability for solar-powered green hydrogen production plants along the Northwestern coast of Egypt
5) GIS-based multi-criteria site analysis of electrolyzer systems for the production of green hydrogen in Germany
6) Hydrogen production potential in Mexico: An estimation
7) Probabilistic resilience and circular-resource assessment of solar–green hydrogen hybrid systems (SGHHS) with industrial waste water reuse across varying climatic regions of Pakistan


**STATUS: integrated, item complete.** All 7 papers added to `references.bib` and cited in a new paragraph in Section 4.1. See `LITERATURE_REVIEW_LOG.md` entries 14-20.
**2.3 Environmental flow requirement calculation methods**
Section 4.3 states that environmental flow requirements have "not yet [been] subtracted from simulated Q10" and cites only the EU CIS guidance document. A methods-comparison paper would strengthen this limitation statement and could inform a future revision.
- Search terms: `environmental flow methods comparison hydrological presumptive standard`, `Tennant method environmental flow review`, `global review environmental flow assessment methods Tharme`
- Candidate (well known, not yet Crossref-verified): Tharme, R. E. (2003). A global perspective on environmental flow assessment: emerging trends in the development and application of environmental flow methodologies for rivers. *River Research and Applications*, 19(5-6), 397-441.

Note:
Papers found (titles placres here for you runderstanding:)

1) A global perspective on environmental flow assessment: emerging trends in the development and application of environmental flow methodologies for rivers
2) Review of approaches and methods to assess Environmental Flows across Canada and internationally
3) Limited comparability of global and local estimates of environmental flow requirements to sustain river ecosystems
4) Global Trends in Environmental Flow Assessment: An Overview
5) chapter from a book: Gopal, B. R. I. J. (2013). Methodologies for the assessment of environmental flows. Environmental flows: An introduction for water resources managers, 129-182.
6) Accounting for environmental flow requirements in global water assessments
7) Accounting for environmental flow requirements in global water assessments
8) Environmental Flows in Shared Watercourses: Review of Assessment Methods and Relevance in the Transboundary Setting
9) A comparison of desktop hydrologic methods for determining environmental flows


**STATUS: integrated, item complete.** Items 6 and 7 in the list above are the same paper (Pastor et al. 2014): a preprint (`Accounting_for_environmental_flow_requir.pdf`) and the final published HESS version (`hess-18-5041-2014.pdf`). Only the published version was cited. All 8 unique papers added to `references.bib` and cited in a new paragraph in Section 4.3. See `LITERATURE_REVIEW_LOG.md` entries 21-28.
**2.4 Groundwater-surface water interaction representation in conceptual hydrological models**
Section 4.3 states HYPE's conceptual groundwater store "may underestimate baseflow in coarse-material aquifers" without a supporting citation.
- Search terms: `conceptual hydrological model groundwater baseflow representation limitation`, `semi-distributed model aquifer storage low flow simulation uncertainty`


Note: Papers added

1) A multi-storage groundwater concept for the SWAT model to emphasize nonlinear groundwater dynamics in lowland catchments
2) Understanding groundwater storage and drainage dynamics of a high mountain catchment with complex geology using a semi-distributed process-based modelling approach
3) Tran Quoc, Q., P. Willems, and M. Huysmans. "Development of an integrated modelling approach for improved groundwater and low flow simulation." (2019).
4) Assessing water availability in a semi-arid watershed of southern India using a semi-distributed model
5) HYDROGEIOS: a semi-distributed GIS-based hydrological model for modified river basins
6) Assessing Parameter Uncertainty of a Semi-Distributed Hydrology Model for a Shallow Aquifer Dominated Environmental System
7) Coupling catchment runoff models to groundwater flow models in a multi-model ensemble approach for improved prediction of groundwater recharge, hydraulic heads and river discharge
8) Modelling the hydrology of a catchment using a distributed and a semi-distributed model
9) Impact of model structure on flow simulation and hydrological realism: from a lumped to a semi-distributed approach
10) Parameter uncertainty and identifiability of a conceptual semi-distributed model to simulate hydrological processes in a small headwater catchment in Northwest China



**STATUS: integrated, item complete.** 6 of the 10 papers were used (items 1, 2, 3/7 [same author, journal version used], 5, 6, 9), cited in a new paragraph in Section 4.3 immediately after the "Key uncertainties" paragraph. The other 4 were read but excluded to avoid over-citing a single limitation paragraph: item 8 (El-Nasr et al. 2005) makes a similar point to item 9 (Garavaglia et al. 2017) already used; item 4 (Perrin et al. 2012) is a weaker topical fit (general water availability rather than groundwater store structure); item 3's PhD thesis is superseded by its own published journal version (item 7); item 10 (Ouyang et al.) makes a similar point to item 6 (Samadi et al.) already used. See `LITERATURE_REVIEW_LOG.md` entries 29-34 for full detail and rationale on each inclusion/exclusion.

**2.5 Social acceptance of energy or water infrastructure beyond MAR specifically**
Section 4.5 ("Social dimensions and distributional impacts") currently relies only on one Finnish MAR-specific paper (Laukka et al. 2021). Broader energy-infrastructure siting and public acceptance literature would strengthen this section, since the topic here is industrial hydrogen siting, not MAR.
- Search terms: `public acceptance renewable energy infrastructure siting review`, `social license industrial water abstraction community`, `NIMBY green hydrogen infrastructure siting Finland OR Nordic`

---

## Priority 0: Reference quality audit (added after user feedback)

The user flagged that some references added so far come from low-quality or "garbage" journals and asked for a stricter standard. The policy now applied to all new citations (see `LITERATURE_REVIEW_LOG.md` for the full statement) is: prefer established specialty hydrology/water-resources/energy journals or official technical reports; treat MDPI journals as requiring extra scrutiny rather than automatic exclusion; treat low-circulation regional journals as candidates for replacement, especially where the claim is redundant with a stronger source; prefer a peer-reviewed journal paper over a PhD thesis when both exist; check that a paper's actual finding, not just its title, supports the claim it is attached to.

**Action already taken:** `Baghel2018` (*Journal of The Institution of Engineers (India): Series A*, a low-circulation regional engineering journal) was removed from `references.bib` and the manuscript; the claim it supported is fully covered by `Gopal2013` alone.

**Open items needing your input:**

**0.1 Replace or supplement `veijalainen2019severe`** (Veijalainen et al. 2019, "Severe drought in Finland", published in *Sustainability*, MDPI). This is a pre-existing citation (added before this literature review process started) used in two places: the Introduction (Water Act/permit context) and Section 4.2 (geographic pattern of Finnish drought vulnerability, east-west lake-storage contrast). *Sustainability* is one of the MDPI titles most frequently criticised for volume-driven, low-selectivity publishing.
- Search terms: `Finland drought vulnerability water supply catchment SYKE`, `Finland hydrological drought 2018 OR 2021 impact assessment`, `Nordic drought risk water security catchment review`, `Ahopelto Marttunen Finland drought` (co-authors of the existing paper, in case a companion paper from the same research group exists in a stronger journal)
- Also worth checking SYKE's own technical reports directly (syke.fi), since Veijalainen and co-authors are SYKE researchers and the underlying study may also exist as a citable SYKE report rather than only the MDPI journal article.

**0.2 Reconsider `HernandezHerraez2025`** (*Applied Sciences*, MDPI), added in the previous batch as the sole citation for the "80% GIS share" systematic review statistic opening the Section 4.1 hydrogen-siting paragraph.
- Search terms: `hydrogen value chain GIS geospatial systematic review`, `green hydrogen siting methods review geospatial techniques`, `electrolyser siting spatial analysis review 2024 OR 2025`
- Alternative if no better source is found: rewrite the opening sentence to lead with one of the non-MDPI national siting studies (Köhl et al. 2026 or Herrera et al. 2026) instead of the systematic review statistic, and keep Hernández-Herráez et al. as a secondary, non-anchoring citation.

---

## Priority 3: Methods section data-source citations (currently marked TODO, lower priority for "literature review" per se but still needed for a complete reference list)

These are less about literature review and more about proper attribution of data sources. Still worth doing at the same time since they add legitimate reference count.

**3.1** SYKE hierarchical catchment delineation (valuma-aluejako) — official documentation or a paper describing the taso3/taso4 system
**3.2** FMI open data / `fmiopendata` weather station network — technical documentation citation
**3.3** CORINE Land Cover 2018 — official EEA/Copernicus technical guide citation
**3.4** GTK superficial deposits map (1:200,000) — official GTK map series documentation
**3.5** NLS digital elevation model (10m) — official NLS product documentation

Search terms for all of these are straightforward: `[agency name] [dataset name] technical documentation citation`. These are usually best found on the agency's own website rather than Google Scholar.

---

## Priority 4: Supporting context, lower urgency but would strengthen the argument

**4.1 Electrolyser water consumption by technology (PEM vs alkaline), independent of Ellersdorfer**
Section 1 (Introduction) states stoichiometric consumption near 9 L/kg H2 without a direct citation for that specific number.
- Search terms: `PEM alkaline electrolyser water consumption stoichiometric life cycle`, `water demand green hydrogen production technology comparison`

**4.2 Managed aquifer recharge, global context beyond Finland**
Section 4.5 (or wherever MAR is discussed as an alternative source) currently cites only Finnish MAR papers (Kurki 2013, Laukka 2021). A global MAR review would support the claim that MAR is a viable but not risk-free alternative more broadly.
- Search terms: `managed aquifer recharge global review Dillon`
- Candidate (well known, not yet Crossref-verified): Dillon, P., et al. (2019). Sixty years of global progress in managed aquifer recharge. *Hydrogeology Journal*, 27(1), 1-30.

**4.3 IPCC regional climate projections for Northern/Eastern Europe**
Currently the manuscript relies entirely on one Finnish national climate projection (Ruosteenoja & Jylhä 2021) for the SSP2-4.5 justification. An IPCC AR6 regional chapter citation would situate this within the broader international assessment framework, which AGU reviewers typically expect.
- Search terms: `IPCC AR6 WG1 regional climate change information Europe chapter`

---

## Notes on writing style for anything I draft using these sources

Per your instructions, new text will avoid: em dashes, promotional or exaggerated language, parallel negation constructions ("not only X but also Y"), vague attributions ("some argue"), summary phrases ("in summary", "overall"), and rigid formulaic paragraph structure. Claims will be stated directly and cited concretely. If you notice any of these creeping back in, flag it and I will fix it.
