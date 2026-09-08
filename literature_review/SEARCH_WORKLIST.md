# Search worklist for literature review expansion

Current reference count: 66 entries in `references.bib` (19 → 21 batch 1 → 44 batch 2 → 50 batch 3 → 66 batch 4: +16 net, after excluding several candidates on quality/topical-fit grounds; see `LITERATURE_REVIEW_LOG.md` "Papers read but excluded this batch" for the full accounting). Target: 30-40, substantially exceeded; the priority now is closing the two remaining 🔴 critical gaps (1.2, 1.3) and quality-auditing what is already cited (Priority 0), not adding further volume. This document lists concrete gaps in the manuscript's citation coverage, organised by section and priority. Each item gives search terms to run and, where a specific paper has already been checked against Crossref and confirmed to exist with correct metadata, that paper is named directly as a starting point.

Workflow: pick an item, search it, download the PDF, and drop it in `Biblio/`. Tell me which item number you found something for (or just tell me the filename) and I will read it, decide where it fits, write the citation into the manuscript, add the BibTeX entry, and log it in `LITERATURE_REVIEW_LOG.md`.

---

## 🔴 CRITICAL — still needed (read this first)

Two seminal, foundational papers remain unresolved after four full search batches. Both are named or clearly implied in the manuscript's own text, so their absence is the single most reviewer-visible gap left in the whole reference list. Everything else on this worklist is lower priority than closing these two.

**🔴 1. Nash & Sutcliffe (1970), "River flow forecasting through conceptual models part I: A discussion of principles," *Journal of Hydrology*, 10(3), 282-290.** Defines the NSE metric used throughout this manuscript. Four batches of candidate papers (real-time forecasting studies, SWAT applications, landslide/rain-garden/Manning-roughness papers) have all been topically unrelated. See item 1.2 below for narrower search strategies.

**🔴 2. Moriasi et al. (2007), "Model evaluation guidelines for systematic quantification of accuracy in watershed simulations," *Transactions of the ASABE*, 50(3), 885-900.** The standard reference for the "satisfactory/good" NSE and PBIAS classification language already used in Section 3.1. See item 1.3 below for narrower search strategies, including the more accessible 2015 update.

Five other methodological papers were added this batch to strengthen the calibration/validation discussion in the meantime (Ritter & Muñoz-Carpena 2013, Pfannerstill et al. 2017, Arsenault et al. 2018, Abbaspour 2022, Geza & McCray 2008), but none of them is a substitute for the two papers above. Please keep searching for these two specifically.

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


Updated note; Okay so I found these

1) Real-time forecasting with a conceptual hydrologic model: 2. Applications and results
2) Real-time forecasting with a conceptual hydrologic model: 1. Analysis of uncertainty
3) River flow modelling: comparison of performance and evaluation of uncertainty using data-driven models and conceptual hydrological model
4) Fuzzy Conceptual Hydrological Model for Water Flow Prediction
5) Comparison of four updating models for real-time river flow forecasting
6) A conceptual and neural network model for real-time flood forecasting of the Tiber River in Rome
7) River flow forecasting using artificial neural networks

**STATUS: none of these fit either.** 🔴 Still critical, still open. All 7 papers were read. They are genuine, in some cases classic, papers in real-time hydrological forecasting and data assimilation (Kitanidis & Bras 1980, items 1-2, are foundational in that specific subfield and highly cited), but none of them defines or discusses the origin of NSE, and this manuscript does not perform real-time/operational forecasting, so none of them fit anywhere else in the paper either. See `LITERATURE_REVIEW_LOG.md` "Papers read but excluded this batch" for the full list with journals. None used.

The recurring problem across three search attempts is that "conceptual model" + "river flow forecasting" style searches surface a whole subfield of real-time forecasting papers that happen to share vocabulary with the Nash & Sutcliffe (1970) title, without being that paper or citing it as their origin. Please try the narrower strategies above (exact-title quoting, library discovery layer, ResearchGate, textbook fallback) rather than broader keyword variations, which keep returning the same kind of false positive.

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


Updated notes: I found these

1) Model Performance Sensitivity to Objective Function during Automated Calibrations
2) How to Constrain Multi-Objective Calibrations of the SWAT Model Using Water Balance Components
3) Performance evaluation of hydrological models: Statistical significance for reducing subjectivity in goodness-of-fit assessments
4) The fallacy in the use of the “best-fit” solution in hydrologic modeling
5) The hazards of split-sample validation in hydrological model calibration
6) Effects of soil data resolution on SWAT model stream flow and water quality predictions

**STATUS: still 🔴 not resolved for Moriasi itself, but 5 of 6 integrated as supporting methods citations elsewhere.** None of these 6 papers is the Moriasi et al. (2007) paper or discusses fixed GOF classification thresholds directly, so the critical gap remains open. However, 5 of the 6 turned out to be genuinely strong, on-topic methodological papers once read in full, and were integrated:
- Item 2 (Pfannerstill et al. 2017, JAWRA) and item 3 (Ritter & Muñoz-Carpena 2013, J Hydrol) → Section 2.2.5, model evaluation metrics
- Item 5 (Arsenault et al. 2018, J Hydrol) → Section 2.2.4, split-sample validation methodology
- Item 4 (Abbaspour 2022, Sci Total Environ) and item 6 (Geza & McCray 2008, J Environ Manag) → Section 4.3, new uncertainty paragraph on parameter equifinality and soil data resolution

Item 1, "Model Performance Sensitivity to Objective Function during Automated Calibrations," was listed but **no matching PDF was found in `Biblio/`** — please check whether the file upload for this one did not complete, and re-add it if you still want it read. See `LITERATURE_REVIEW_LOG.md` entries 36-40 for full detail on the 5 that were used.

---

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


Note: I added the following papers;

1) Understanding local opposition to renewable energy projects in the Nordic countries: A systematic literature review
2) PhD thesis: Towards a resilient hydrogen economy: climate impact, safety, cybersecurity, and the foundations for public trust
3) Aaltonen, Kirsi, Elina Jääskä, and Jaakko Kujala. Approaches to social license to operate (SLO) in emerging nuclear projects. Research report, 2026.
4) Danilova, Polina. Permitting procedures for renewable energy projects in the European Union. Diss. Technische Universität Wien, 2024.
5) Beyond Community Acceptance: Examining Energy Justice in Northern Norway's Green Hydrogen Transition
6) Fast, Cheap and Popular – Can You Have All Three? Comparing Reverse Auctions for Renewable Energy in Finland and Australia

**STATUS: integrated, item complete, but only 1 of 6 was usable.** Item 1 (Sanchez Nieminen & Laitinen 2025, *Energy Research & Social Science*) is an excellent fit and is now cited in Section 4.5 alongside Laukka et al. (2021). See `LITERATURE_REVIEW_LOG.md` entry 41.

The other 5 were excluded on quality or topical-fit grounds, per your instruction to prioritise seminal, reputable sources:
- Item 2 (Alfasfos PhD thesis) is about hydrogen safety/cybersecurity/public trust, not water or siting; a Crossref check for published papers from the same author found only cybersecurity conference papers, also off-topic.
- Item 3 (Aaltonen et al., University of Oulu research report) is nuclear-specific and not peer-reviewed.
- Item 4 (Danilova, MSc thesis) is a Master's-level thesis, the weakest publication type found this session, and not peer-reviewed.
- Item 5 (Cheng & Kristoffersen, "Beyond Community Acceptance") is topically an excellent match, arguably better than item 1, but exists only as an unpublished SSRN preprint (confirmed via Crossref: DOI resolves to `10.2139/ssrn.6582674`, no journal DOI exists). **Worth revisiting once/if this is published** — if you can find a later, peer-reviewed version, that would likely be an even stronger addition than item 1.
- Item 6 (Heikkinen PhD thesis) is about renewable energy procurement auctions, not social acceptance of siting.

---

## Priority 0: Reference quality audit (added after user feedback)

The user flagged that some references added so far come from low-quality or "garbage" journals and asked for a stricter standard. The policy now applied to all new citations (see `LITERATURE_REVIEW_LOG.md` for the full statement) is: prefer established specialty hydrology/water-resources/energy journals or official technical reports; treat MDPI journals as requiring extra scrutiny rather than automatic exclusion; treat low-circulation regional journals as candidates for replacement, especially where the claim is redundant with a stronger source; prefer a peer-reviewed journal paper over a PhD thesis when both exist; check that a paper's actual finding, not just its title, supports the claim it is attached to.

**Action already taken:** `Baghel2018` (*Journal of The Institution of Engineers (India): Series A*, a low-circulation regional engineering journal) was removed from `references.bib` and the manuscript; the claim it supported is fully covered by `Gopal2013` alone.

**Open items needing your input:**

**0.1 Replace or supplement `veijalainen2019severe`** (Veijalainen et al. 2019, "Severe drought in Finland", published in *Sustainability*, MDPI). This is a pre-existing citation (added before this literature review process started) used in two places: the Introduction (Water Act/permit context) and Section 4.2 (geographic pattern of Finnish drought vulnerability, east-west lake-storage contrast). *Sustainability* is one of the MDPI titles most frequently criticised for volume-driven, low-selectivity publishing.
- Search terms: `Finland drought vulnerability water supply catchment SYKE`, `Finland hydrological drought 2018 OR 2021 impact assessment`, `Nordic drought risk water security catchment review`, `Ahopelto Marttunen Finland drought` (co-authors of the existing paper, in case a companion paper from the same research group exists in a stronger journal)
- Also worth checking SYKE's own technical reports directly (syke.fi), since Veijalainen and co-authors are SYKE researchers and the underlying study may also exist as a citable SYKE report rather than only the MDPI journal article.
- **Partial candidate found this batch:** Barthel et al. (2021), "Current understanding of groundwater recharge and groundwater drought in Sweden compared to countries with similar geology and climate," *Geografiska Annaler: Series A, Physical Geography* (Taylor & Francis, non-MDPI, reputable). This is now cited in the Introduction MAR paragraph for a related but distinct claim (groundwater drought independence from surface water drought). It covers Sweden and "similar geology and climate" countries rather than Finland specifically, and groundwater rather than surface-water drought, so it does not directly replace `veijalainen2019severe`, but it is a strong candidate to search around for a genuinely Finland-specific, non-MDPI surface-water drought paper (check its reference list and citing papers for Finnish-specific companions).

**0.2 Reconsider `HernandezHerraez2025`** (*Applied Sciences*, MDPI), added in the previous batch as the sole citation for the "80% GIS share" systematic review statistic opening the Section 4.1 hydrogen-siting paragraph.
- Search terms: `hydrogen value chain GIS geospatial systematic review`, `green hydrogen siting methods review geospatial techniques`, `electrolyser siting spatial analysis review 2024 OR 2025`
- Alternative if no better source is found: rewrite the opening sentence to lead with one of the non-MDPI national siting studies (Köhl et al. 2026 or Herrera et al. 2026) instead of the systematic review statistic, and keep Hernández-Herráez et al. as a secondary, non-anchoring citation.
- **STATUS: still open, not addressed this batch.** No candidate found or searched for yet.

**0.3 New this batch: `SachinRameshThampi2023`** (*Environmental Earth Sciences*, Springer). Not MDPI and legitimately peer-reviewed, but a more modest-standing regional journal than the field's top specialty titles. Used only as one supporting example among several stronger sources (Tharme 2003, Pastor 2014, Messager 2024) in the Section 4.3 environmental flow paragraph, not as a load-bearing sole citation, so this is a lower-priority quality concern than 0.1/0.2. No action needed unless you want to replace it.

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

Note: Papers I have found under this topic;

1) Comparative Life Cycle Water Use Assessment of Diverse Hydrogen Production Pathways
2) Water Consumption in Hydrogen Production Through Electrolysis: Overview, State-of-the-Art, and Future Trends
3) Prospective life cycle assessment of hydrogen production by waste photoreforming
4) Life cycle environmental impacts and costs of water electrolysis technologies for green hydrogen production in the future
5) Prospective LCA of alkaline and PEM electrolyser systems
6) Green hydrogen production by PEM water electrolysis up to the year 2050: Prospective life cycle assessment using learning curves
7) Comparative experimental study of alkaline and proton exchange membrane water electrolysis for green hydrogen production

**STATUS: integrated, item complete, but only 2 of 7 actually support the water-consumption claim.** Item 1 (Qin et al. 2025, *Environmental Science & Technology*) and item 2 (Santos Sánchez et al. 2026, *WIREs Energy and Environment*) are both directly on-topic, high-quality sources and are now cited in the Introduction, replacing the old uncited "close to 9 litres per kilogram" figure with a sourced, more precise breakdown (17.5 L/kg for PEM, 51%/49% process/cooling split).

The other 5 were excluded after checking their actual content rather than just their titles, per your quality-control instruction:
- Items 5 and 6 (Krishnan et al. 2024, *International Journal of Hydrogen Energy*; Koj et al. 2025, *Journal of Industrial Ecology*) and item 4 (Koj et al. 2024, *Energy, Sustainability and Society*, same authors) are all legitimate LCA papers in reputable journals, but none of them actually discusses water consumption; they assess greenhouse gas emissions and cost. This looked like a strong match on title keywords ("PEM", "alkaline", "electrolyser", "LCA") but was not a match on content.
- Item 7 (Wang et al. 2024, *Applied Energy*) is about dynamic response and cold-start performance, not water use.
- Item 3 (Rumayor et al. 2022, *Journal of Cleaner Production*) is about a different production pathway (waste photoreforming) outside the PEM/alkaline electrolysis scope of this paragraph.

See `LITERATURE_REVIEW_LOG.md` entries 42-43 and the "Papers read but excluded" section for full detail.

**4.2 Managed aquifer recharge, global context beyond Finland**
Section 4.5 (or wherever MAR is discussed as an alternative source) currently cites only Finnish MAR papers (Kurki 2013, Laukka 2021). A global MAR review would support the claim that MAR is a viable but not risk-free alternative more broadly.
- Search terms: `managed aquifer recharge global review Dillon`
- Candidate (well known, not yet Crossref-verified): Dillon, P., et al. (2019). Sixty years of global progress in managed aquifer recharge. *Hydrogeology Journal*, 27(1), 1-30.

Note: papers I found in this topic;

1) Sixty years of global progress in managed aquifer recharge
2) Global advances in managed aquifer recharge: a systematic synthesis
3) Review: Implementation challenges of managed aquifer recharge in developing countries
4) Reviewing regulatory settings and their impacts on managed aquifer recharge implementation: evidence from six countries
5) Using managed aquifer recharge to address land subsidence: Insights from a global literature review
6) A review of the managed aquifer recharge: Historical development, current situation and perspectives
7) Inventory of managed aquifer recharge sites in Europe: historical development, current situation and perspectives
8) Overview of groundwater sources and water-supply systems, and associated microbial pollution, in Finland, Norway and Iceland
9) Book chapter: Taylor, Richard, et al. "Groundwater, aquifers and climate change." (2022): 101-114.
10) Current understanding of groundwater recharge and groundwater drought in Sweden compared to countries with similar geology and climate

**STATUS: integrated, item complete.** 5 of the 10 sources were selected and are now cited in the expanded Introduction MAR paragraph: item 1 (Dillon et al. 2019, seminal global review), item 7 (Sprenger et al. 2017, European inventory), item 8 (Kløve et al. 2017, Finland/Norway/Iceland specific), item 10 (Barthel et al. 2021, Swedish groundwater drought), and item 4 (Seidl et al. 2026, regulatory barriers). The other 5 were excluded to avoid stacking redundant global reviews: items 2 and 6 (Sinshaw et al.; Zhang et al.) substantially overlap with Dillon et al.'s more authoritative review; item 3 (de Witt et al., developing-country focus) has weak relevance to Finland's mature MAR context; item 5 (land subsidence) is not a relevant risk in Finland's till/bedrock geology; item 9 (UNESCO-IHP/IAH book chapter) is not peer-reviewed and overlaps with Dillon et al. See `LITERATURE_REVIEW_LOG.md` entries 44-48 and "Papers read but excluded" for full detail.

**4.3 IPCC regional climate projections for Northern/Eastern Europe**
Currently the manuscript relies entirely on one Finnish national climate projection (Ruosteenoja & Jylhä 2021) for the SSP2-4.5 justification. An IPCC AR6 regional chapter citation would situate this within the broader international assessment framework, which AGU reviewers typically expect.
- Search terms: `IPCC AR6 WG1 regional climate change information Europe chapter`

Note: Papers and other publications found under this topic;

1) Synthesis report of the IPCC Sixth Assessment Report (AR6), Longer report. IPCC.
2) Book: Crok, Marcel, and Andy May. The frozen climate views of the IPCC: An analysis of AR6. Andy May Petrophysicist LLC, 2023.
3) Synthesis Report of the IPCC Sixth Assessment Report (AR6)
4) Implementation of FAIR principles in the IPCC: the WGI AR6 Atlas repository
5) Book: Chen, Deliang, et al. "Framing, Context, and Methods (Chapter 1)." IPCC 2021: Climate Change 2021: The Physical Science Basis. Contribution of Working Group I to the Sixth Assessment Report of the Intergovernmental Panel on Climate Change (2023): 147-286.
6) The Worldwide C3S CORDEX Grand Ensemble: A Major Contribution to Assess Regional Climate Change in the IPCC AR6 Atlas
7) Climate Change 2022 - Impacts, Adaption and Vulnerability. Summary for Policymakers
8) Team, Extended Writing, and Jean-Charles Hourcade. "SYNTHESIS REPORT OF THE IPCC SIXTH ASSESSMENT REPORT (AR6)."

**STATUS: integrated, item complete.** Items 1/3/8 are the same document (IPCC AR6 Synthesis Report, Longer Report, 2023), now cited once in Section 2.2.7 alongside item 7 (IPCC AR6 WGII Summary for Policymakers, 2022) and item 6 (Diez-Sierra et al. 2022, *Bulletin of the American Meteorological Society*, the CORDEX ensemble underlying the IPCC AR6 Atlas). Item 4 (Iturbide et al. 2022, *Scientific Data*) is a legitimate peer-reviewed paper but describes data repository infrastructure (FAIR principles) rather than climate projections themselves, so it was not needed. Item 5 (IPCC AR6 WGI Chapter 1) is official but general methodological framing rather than regional-projection-specific content already covered by the Synthesis Report and WGII SPM, so it was left out to avoid redundant IPCC citations.

🔴 **Item 2 requires your attention: "The Frozen Climate Views of the IPCC" (Crok & May, self-published via Clintel.org) is NOT a legitimate scientific source and has NOT been cited.** Clintel is a climate-change-contrarian advocacy organisation and this is a polemical, non-peer-reviewed critique of mainstream IPCC science, directly at odds with the SSP-based climate projections this manuscript itself relies on. Citing it would seriously damage the manuscript's credibility with any AGU reviewer. Please do not add this one to a future batch; if you encountered it while searching for IPCC material, it is worth knowing it is not a neutral or citable academic source for a paper like this one. See `LITERATURE_REVIEW_LOG.md` for the full explanation.

---

## Notes on writing style for anything I draft using these sources
Per your instructions, new text will avoid: em dashes, promotional or exaggerated language, parallel negation constructions ("not only X but also Y"), vague attributions ("some argue"), summary phrases ("in summary", "overall"), and rigid formulaic paragraph structure. Claims will be stated directly and cited concretely. If you notice any of these creeping back in, flag it and I will fix it.
