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
