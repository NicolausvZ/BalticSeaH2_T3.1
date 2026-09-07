# Search worklist for literature review expansion

Current reference count: 19 entries in `references.bib`. Target: 30-40. This document lists concrete gaps in the manuscript's citation coverage, organised by section and priority. Each item gives search terms to run and, where a specific paper has already been checked against Crossref and confirmed to exist with correct metadata, that paper is named directly as a starting point.

Workflow: pick an item, search it, download the PDF, and drop it in `Biblio/`. Tell me which item number you found something for (or just tell me the filename) and I will read it, decide where it fits, write the citation into the manuscript, add the BibTeX entry, and log it in `LITERATURE_REVIEW_LOG.md`.

---

## Priority 1: Methodological citations that are currently missing entirely

These are the most urgent gap. The manuscript uses NSE and KGE as primary goodness-of-fit metrics throughout Sections 2 and 3, and states performance thresholds (NSE > 0.75 = good, 0.50-0.75 = satisfactory, |PBIAS| > 25% = poor) without citing where these definitions or thresholds come from. A reviewer will flag this.

**1.1 KGE origin paper** (verified via Crossref, exists exactly as expected)
- Gupta, H. V., Kling, H., Yilmaz, K. K., & Martinez, G. F. (2009). Decomposition of the mean squared error and NSE performance criteria: Implications for improving hydrological modelling. *Journal of Hydrology*, 377(1-2), 80-91. https://doi.org/10.1016/j.jhydrol.2009.08.003
- Needed to cite the origin of the KGE metric itself (correlation, bias ratio, variability ratio decomposition), used in Section 2.2.5 and throughout Results.

**1.2 NSE origin paper** (not re-verified due to a rate limit on this search session, but this is one of the most cited papers in hydrology and the title/journal/year below are standard knowledge; confirm exact page numbers when you find it)
- Nash, J. E., & Sutcliffe, J. V. (1970). River flow forecasting through conceptual models part I: A discussion of principles. *Journal of Hydrology*, 10(3), 282-290.
- Search terms if the above does not resolve directly: `"Nash-Sutcliffe" 1970 "river flow forecasting through conceptual models"`

**1.3 GOF performance threshold classification** (verified via Crossref)
- Moriasi, D. N., Arnold, J. G., Van Liew, M. W., Bingner, R. L., Harmel, R. D., & Veith, T. L. (2007). Model evaluation guidelines for systematic quantification of accuracy in watershed simulations. *Transactions of the ASABE*, 50(3), 885-900. https://doi.org/10.13031/2013.23153
- This is the standard reference for the NSE/PBIAS/RSR performance classification thresholds used in Section 3.1 (satisfactory/good/poor). Extremely widely cited (over 10,000 citations), a reviewer will expect to see it.

**1.4 logNSE / log-transformed efficiency for low-flow evaluation**
- Search terms: `log-transformed Nash-Sutcliffe efficiency low flow evaluation hydrological model`, `Krause Boyle Base weighted efficiency criteria hydrology 2005`
- Candidate: Krause, P., Boyle, D. P., & Base, F. (2005). Comparison of different efficiency criteria for hydrological model assessment. *Advances in Geosciences*, 5, 89-97. (Not yet verified against Crossref; check DOI when found.)
- Needed because the manuscript treats logNSE as "the most relevant performance indicator for this study" (Section 3.1) without citing why log-transformation is appropriate for low-flow assessment.

---

## Priority 2: Discussion section, marked as open TODOs in the manuscript text

**2.1 Nordic/Fennoscandian climate change impact on streamflow, beyond Finland alone**
Section 4.2 ("Comparison to existing Finnish and Nordic studies") currently only cites two Finnish papers plus one Finnish climate projection paper. It needs broader Nordic or Scandinavian comparison to justify the "Nordic" framing in its own heading.
- Search terms: `Sweden Norway streamflow climate change projection low flow`, `Scandinavia hydrological regime shift snow to rain climate warming`, `Fennoscandia river discharge seasonality climate change review`
- Also worth checking for a Baltic Sea region-wide or circum-Baltic hydrological synthesis paper, since this is a BalticSeaH2 project deliverable.

**2.2 Water-energy nexus / siting studies for hydrogen production specifically (not just general hydrogen demand)**
The Introduction cites Terlouw (2024) and Ellersdorfer (2025) for global water-hydrogen constraints, but the Discussion has no international comparison for how other regions have approached hydrogen siting relative to water. This would strengthen Section 4.1 ("Comparison to other water-availability assessment approaches").
- Search terms: `green hydrogen siting water availability regional assessment`, `water footprint electrolysis site selection GIS`, `hydrogen production water stress index mapping`

**2.3 Environmental flow requirement calculation methods**
Section 4.3 states that environmental flow requirements have "not yet [been] subtracted from simulated Q10" and cites only the EU CIS guidance document. A methods-comparison paper would strengthen this limitation statement and could inform a future revision.
- Search terms: `environmental flow methods comparison hydrological presumptive standard`, `Tennant method environmental flow review`, `global review environmental flow assessment methods Tharme`
- Candidate (well known, not yet Crossref-verified): Tharme, R. E. (2003). A global perspective on environmental flow assessment: emerging trends in the development and application of environmental flow methodologies for rivers. *River Research and Applications*, 19(5-6), 397-441.

**2.4 Groundwater-surface water interaction representation in conceptual hydrological models**
Section 4.3 states HYPE's conceptual groundwater store "may underestimate baseflow in coarse-material aquifers" without a supporting citation.
- Search terms: `conceptual hydrological model groundwater baseflow representation limitation`, `semi-distributed model aquifer storage low flow simulation uncertainty`

**2.5 Social acceptance of energy or water infrastructure beyond MAR specifically**
Section 4.5 ("Social dimensions and distributional impacts") currently relies only on one Finnish MAR-specific paper (Laukka et al. 2021). Broader energy-infrastructure siting and public acceptance literature would strengthen this section, since the topic here is industrial hydrogen siting, not MAR.
- Search terms: `public acceptance renewable energy infrastructure siting review`, `social license industrial water abstraction community`, `NIMBY green hydrogen infrastructure siting Finland OR Nordic`

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
