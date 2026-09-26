# FS103-G — the prior-art gate for FS-103, the collapse (WORKFLOW 3.2)

*Job FS103-G, a reader (brief `data/fs103/briefs/G103-prior-art-gate.md`, standing rules `data/fs103/briefs/STANDING-RULES.md`).
Opus 5.5, 2026-09-26. This record becomes the plan's §PA. Every negative below names its queries and measures their words (G21);
every paper carries a reading status per section (G50). Novelty is "not found in print", never "first".*

## Theorems this phase proved

None. This job reads; it proves nothing. (Any inequality noted below is marked as a question for the planner, not a result.)

## Would-have-searched-here log (standing rule 3)

- Nothing. No step of this job would have used a finite-witness search.

## Stage 1 — SAVED

### 1.0 Quotation check of the brief against its sources (standing rule 5)

| brief's quotation or reference | source | verdict |
|---|---|---|
| Kooshi: *"If we end up at a wall which collapses HN to another known open problem, that in itself would be a writeup."* | `CLAUDE.md` § The mission, § Publication; `plans/STUB-collapse-cp-plane.md` § Kooshi's words | **verbatim** |
| `χ_CP(ℝ²)` "the least `k` admitting a translation-invariant random `k`-colouring of the plane, continuous in probability and proper for every unit pair almost surely (the stub quotes the definition verbatim)" | `plans/FS100-BC-verification.md` line 68–71: *"a random map `c : G → [k]` (a family of random variables on one probability space) whose law is invariant under every translation of `G`, with `P(c(x) ≠ c(y)) → 0` as `y → x`, and `P(c(x) = c(x + w)) = 0` for every `x ∈ G` and `w ∈ T`. No joint measurability is part of the definition. `χ_CP(ℝ²)`: the least `k` for which `UD(ℝ²)` carries one."* | the brief's sentence is a **paraphrase, labelled as such**; the stub's quotation matches FS100-BC **verbatim**. The paraphrase keeps "translation-invariant", "continuous in probability", "almost surely"; it does not drop a qualifier. Note: "proper for every unit pair almost surely" is the definition's `P(c(x) = c(x + w)) = 0` **for each fixed pair** — not "almost surely proper on every pair at once"; the brief's wording could be read the second way |
| `[Falconer1981]` "JCTA 31 (1981) 184–189", "unheld" | `BIBLIOGRAPHY.md` line 168 (*"not held \| second-hand"*); Crossref and zbMATH 0469.05021 | **matches**; DOI 10.1016/0097-3165(81)90014-5 |
| "Kechris–Marks Example 5.1" | `BIBLIOGRAPHY.md` line 343: *"The unit-distance passage is Example 5.1 in §5.1, **not §4.7**"* | **matches** the corrected location |
| `[OliveiraVallentin2010]`, `[BachocEtAl2009]`, `[BachocEtAl2014]`, `[AmbrusEtAl2023]`, `[DeCorteOliveiraVallentin2022]` | `BIBLIOGRAPHY.md` lines 270, 273, 269, 276, 295 | all keys **resolve** |
| "Shelah–Soifer" | `BIBLIOGRAPHY.md` | **no key** — a prior-art debt (rows proposed in §3.4) |
| "Soifer's book" | `[Soifer2024]`, held: `~/source/library/Alexander Soifer - The New Mathematical Coloring Book_ ….pdf` | resolves |

### 1.1 Held and unheld — `BIBLIOGRAPHY.md` and `~/source/library/` grep (by key, author, arXiv id, Zbl)

| work | key | held? | read status in `BIBLIOGRAPHY.md` |
|---|---|---|---|
| Falconer, *The realization of distances in measurable subsets covering ℝⁿ*, JCTA 31 (1981) 184–189, Zbl 0469.05021 | `[Falconer1981]` | **not held** (fetch blocked, §1.2) | second-hand |
| Kechris–Marks, *Descriptive graph combinatorics* (2020 survey) | `[KechrisMarks2020]` | held, `library/pdf/KechrisMarks-descriptive-graph-combinatorics-2020.pdf` | read: §3 p. 16, §4.6, §4.7, §5.1 Example 5.1 |
| Soifer, *The New Mathematical Coloring Book* (Springer 2024), Zbl 1551.05001 | `[Soifer2024]` | held (library top level) | chapters 11, 54, 58 named elsewhere; the axiom-of-choice / measurability chapters **not read** here yet |
| Shelah–Soifer, JCTA 103 (2003) 387–391, Zbl 1030.03035; Soifer–Shelah, JCTA 105 (2004) 359–364, Zbl 1057.03036; Shelah–Soifer, Geombinatorics 13(1) (2003) 41–46, Zbl 1049.05038; Soifer, JCTA 110 (2005) 169–173, Zbl 1063.03035; Soifer, Geombinatorics 17(2) (2007) 85–87, Zbl 1506.03106 | none | **not held** | none — a debt |
| Oliveira Filho–Vallentin 2010 (arXiv:0808.1822) | `[OliveiraVallentin2010]` | held | Thm 1.1, §1 |
| Bachoc–Nebe–Oliveira–Vallentin 2009 (arXiv:0801.1059) | `[BachocEtAl2009]` | held | §10.1 read by FS-58's sweep; not by de Bruijn |
| Bachoc–DeCorte–Oliveira–Vallentin 2014 (arXiv:1301.1054) | `[BachocEtAl2014]` | held | Def. 2.1, Thm 2.2, Thm 2.3 statement, §§2.3–2.4, §3.2 |
| Ambrus–Csiszárik–Matolcsi–Varga–Zsámboki (arXiv:2207.14179) | `[AmbrusEtAl2023]` | held | §§1–9 in full |
| DeCorte–Oliveira–Vallentin 2022 (arXiv:1804.09099) | `[DeCorteOliveiraVallentin2022]` | held | Def. 2.1, Thm 2.2, 5.1, 7.1 |
| Keleti–Matolcsi–Oliveira–Ruzsa (arXiv:1501.00168) | `[KMOR2016]` | held | Lemma 3.2 (named in rows) |
| Bukh, *Measurable sets with excluded distances*, GAFA 18 (2008), Zbl 1169.52005 | `[Bukh2008]` | not held | named only |
| Conley–Kechris 2013, Zbl 1315.03082 | `[ConleyKechris2013]` | not held | author's summary only |
| Kechris–Solecki–Todorčević 1999, Zbl 0918.05052 | `[KechrisSoleckiTodorcevic1999]` | not held | not read |
| Székely 1984, Combinatorica 4 | listing (§ C line 734) | not held | listing only |
| Croft 1967 | `[Croft1967]` | not held | unread |
| Polymath16 threads 1–18 (text) | `[Polymath16threads]` | held, `library/notes/polymath16-threads-1-18-text.txt` | M3 grepped "measurable" (Mixon, Tao on Falconer's proof: `plans/M3-S1D-windows-five.md` §1.1 Q10–Q11) |

In-project prior mentions of the measurable question: `plans/M3-exotic-colourings.md` §PA.1 (zbMATH `ab:"measurable chromatic number"`,
17 hits; Kechris–Marks; the Polymath16 measurable threads) and `plans/M3-S1D-windows-five.md` §1.1 (KM's `χ_µ` definition, verbatim).
This gate does not re-run those; it extends them to the collapse's question.

### 1.2 `[Falconer1981]` — the fetch

- Identity: DOI `10.1016/0097-3165(81)90014-5`; Elsevier open archive ("bronze", OpenAlex W2006159486; Crossref licence
  `open-access/userlicense/1.0` from 2013-07-17); Semantic Scholar: 64 citations, publisher elides the abstract; zbMATH 0469.05021 carries
  **no review text** (listing only).
- **Blocked**, every scripted route: ScienceDirect `…/pii/0097316581900145/pdf` and `/pdfft` → HTTP 403 (challenge page); WebFetch on the
  article page → 403; the Elsevier text-mining API returns metadata only without a key (`view=FULL` → "Invalid API Key"; `application/pdf`
  → "restricted"); OpenAlex, Unpaywall and Semantic Scholar hold no repository copy (`any_repository_has_fulltext: false`).
- **Route for Kooshi** (the fetch-routes memory: *"for a blocked free paper, give Kooshi the URL and target filename"*): a browser save of
  `https://www.sciencedirect.com/science/article/pii/0097316581900145` → `~/source/library/papers/falconer-1981-realization-distances-measurable-subsets-covering-Rn-jcta-31-184-189.pdf`
  (six pages, 184–189; free, open archive). Until then question 2 is answered from held second-hand sources (stage 3), marked so.
- Its companion the same year, **Croft–Falconer, *On maximal Euclidean sets avoiding certain distance configurations*, Math. Proc. Camb.
  Philos. Soc. 89 (1981) 79–88, Zbl 0494.52008** — found by Falconer's author listing, not in `BIBLIOGRAPHY.md`; listing only (no review).

### 1.3 zbMATH Open API — the posers' complete author listings (WORKFLOW 3.2 item 8)

Tool: `tools/fs103_g_zb.py` (fetches every page; prints the API's total beside the count fetched and flags a mismatch; self-test:
the item-8 query `ti:"chromatic number" & ab:"additive" & ab:"coloring" & py:1985-2000` must return `[Fischer1994]`, and a nonsense author
must return zero. **Two plants fired for their own reasons**: the known title altered → `fischer1994_found=False`, exit 1; the nonsense
author replaced by a real one → `total=156`, exit 1). Listings saved under `data/fs103/fs103-g/zb/` (`.json.gz` all records, `.tsv` digest).

| author (query) | total = fetched | on-topic entries (titles; each a **listing** unless a review is quoted in §2) |
|---|---|---|
| Falconer `ai:falconer.kenneth-j` | 157 | 0469.05021 (the 1981 JCTA paper); 0494.52008 Croft–Falconer 1981; 0599.28008, 0599.28009 (1986, distances in plane sets of positive measure/density) |
| Soifer `ai:soifer.alexander` | 127 | the Shelah–Soifer axiom-of-choice series (1030.03035, 1057.03036, 1049.05038, 1066.05067, 1063.03035, 1138.05023 with Karabash); **1506.03106 *Chromatic number of the plane theorem in Solovay's set theory*, Geombinatorics 17(2) (2007) 85–87** (no review); 1559.05062 (2024) and 1569.05108 (2025) *new open problems and conjectures*; the books 1221.05001 (2009) and 1551.05001 (2024) |
| Shelah `ai:shelah.saharon` | 1362 (full); filtered `& (ti:chromatic \| ab:chromatic \| ti:coloring \| ti:colouring)`: 28 | the Soifer series above; 1200.05059 *The odd-distance plane graph* (2009); 1420.03131 *Avoiding equal distances* (2017); arXiv:2302.10141 Poór–Shelah, weak Borel chromatic number (2023); 0705.03028 (1990, large cardinals ⟹ definable sets measurable) |
| Kechris `ai:kechris.alexander-s` | 166 | 0918.05052 KST 1999 *Borel chromatic numbers*; 1315.03082 Conley–Kechris 2013 |
| Marks `ai:marks.andrew-s` | 22 | 1528.03196 Conley–Marks–Tucker-Drob (measurable Brooks; factor-of-IID colourings); 1539.03153 Conley–Marks–Unger 2020; 1566.03232 Marks, *Measurable graph combinatorics*, ICM 2022 |
| Oliveira Filho `ai:de-oliveira-filho.fernando-mario \| ai:filho.fernando-m-de-oliveira` | 28 | 1214.05022 (BNOV 2009), 1205.90196 (OV 2010), 1302.05047 (BDOV 2014), 1335.05048 (KMOR 2016), 1433.52019 (Larman–Rogers counterexample 2019), 1495.46060 (DOV 2022), 1495.05199 (2022), **1587.46051 Bekker–Kuryatnikova–Oliveira–Vera, *Optimization hierarchies for distance-avoiding sets in compact spaces*, TAMS 379 (2026)** |
| Vallentin `ai:vallentin.frank` | 63 | the same line; 1479.05123, 1569.05111 (lattice colourings) |
| Bukh `ai:bukh.boris` | 68 | 1169.52005 (GAFA 2008) and 1236.52015 (2007 version), *Measurable sets with excluded distances* |

*What stage 1 settles:* the Shelah–Soifer series is the literature's own statement that `χ(ℝ²)` and a measurable-world chromatic number
can come apart, and it is the thing any claim "`χ = χ_m`" must face; stage 2 reads it. No listing title states `χ = χ_m`, `χ_B`, or a
stationary colouring number for the plane.
