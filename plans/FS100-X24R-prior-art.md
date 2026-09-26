# FS-100 X24R — the prior-art gate for MR(F) and for the value χ(ℚ(√47)²) = 5

*Job X24R of the ×2×3 crunch (2026-09-26), a reader. Brief: `data/crunch-2026-09-26-x2x3/briefs/X24R-prior-art-gate.md` with
`STANDING-RULES.md`. Procedure: `CLAUDE.md` G49, G50; WORKFLOW 3.2's eight items. Fetched material: `data/fs100/x24r/` (zbMATH JSON under
`zb/`, one query per file; the helper `data/fs100/x24r/zbq.py` prints one line per hit). No subagents; no finite-witness search.*

## Theorems this phase proved

None. This is a reading job: its products are prior-art findings (positive or negative, each with its queries) and proposed
`BIBLIOGRAPHY.md` / `CLOSED-QUESTIONS.md` rows.

## "Would have searched here" log

- None so far: nothing in this job is a finite-witness search. (Fetching and reading are in, standing rule 11.)

## Stage 1 — SAVED (11:25–11:30 UTC)

### 1.0 Quotation check (standing rule 5)

| brief's quotation | source | verdict |
|---|---|---|
| Moorhouse: "What about `χ(ℚ(√47)²)`?" | `CLOSED-QUESTIONS.md` l. 264, quoting `[Moorhouse2010slides]`: *"… If `d ≢ 47, 59 or 83 mod 84`, then `χ(K²) ≤ 4`. **What about `χ(ℚ(√47)²)`?**"* | matches (the brief calls it "Moorhouse's §1.7": it is `CLOSED-QUESTIONS.md` §1.7's quotation of the slides) |
| X01D: "EF's Thm 1.2 first, per Huang 2017" | `data/crunch-2026-09-26-x2x3/reports/X01D.md` INVENTORY: *"Sataev 1975 (Uspekhi 30:2, 203–204; EF's Thm 1.2 first, per Huang 2017) not held, unread"* | matches |
| MR(F) "every rotation-invariant `E`-null measure on `R̂` is Haar" | `plans/STUB-measure-rigidity-three-fields.md` l. 74, quoting J38 §3.5: *"**MR(F)** is 'every `U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure'"* | the brief's is a paraphrase ("rotation-invariant" for `U`-invariant, "is Haar" for "a multiple of Haar"); faithful in content; the source form is used below |
| EF_F⁺ "invariance under a norm-one torus's rational points, carried by `T + A`" | `plans/FS100-X01D-derivation.md` l. 194: *"**EF_F⁺.** For every real number field `F`: every `U`-invariant finite positive Borel measure `μ` on `R̂` such that `h_μ(u*) = 0` for **one** non-torsion `u* ∈ U` satisfies `μ(R̂ ∖ (T + A)) = 0`."* | the brief's gloss omits the zero-entropy hypothesis; the source form is used below |
| PE-2 | `plans/FS100-X02D-derivation.md` l. 21: *"For every real number field `F` and every `U`-invariant finite positive measure `τ` on `R̂`: `τ = a·m + τ′` with `a ≥ 0`, `τ′` a `U`-invariant finite positive measure, and `h_{τ′}(u) = 0` for every `u ∈ U`."* | used verbatim |

### 1.1 What the repository already holds (grep of `BIBLIOGRAPHY.md` by key / Zbl / arXiv id, and of `~/source/library/`)

| item | in `BIBLIOGRAPHY.md` | copy | reading status before this job |
|---|---|---|---|
| `[Johnson2000]` Geombinatorics 9(4) 170–179, Zbl 0974.05029 | yes (l. 294; § R item 3) | **not held** (Geombinatorics archive, Cloudflare-blocked; loan) | zbMATH review only |
| `[Johnson2006]` Geombinatorics 16(1) 209–218, Zbl 1506.05069 | yes (l. 120; § R item 2) | **not held** (same) | not read |
| `[Johnson2011rational]` / `[Johnson2010]` "Euclidean distance graphs on the rational points", Zbl 1243.05082 | yes (l. 228, l. 361) | `library/pdf/ramsey-theory-yesterday-today-tomorrow-2010-soifer-ed.pdf` | `[Johnson2010]` read (per its row) |
| `[EinsiedlerLindenstrauss2022]` arXiv:2101.11120 | yes (l. 337) | `library/pdf/EinsiedlerLindenstrauss2022-…pdf` | §1 pp. 1–3 read; §§2–9 unread |
| Einsiedler–Fish 2010, arXiv:0804.3586, Zbl 1189.37005 | **no row** (X01D proposed one) | `data/crunch-2026-09-26-x2x3/poros/` (per X01D) | in full (X01D) |
| Huang 2017, arXiv:1606.06078, Zbl 1402.37006 | **no row** | `data/fs100/x01d/huang2017-1606.06078.pdf` | §1, Rem. 5.4, refs (X01D) |
| Huang–Li–Shi–Xu 2023, arXiv:1908.02611, Zbl 1537.37013 | **no row** | `data/fs100/x01d/hlsx2023-1908.02611.pdf` | §1 (X01D) |
| Sataev 1975, Uspekhi 30:2 203–204 | **no row** | not held | not read |
| `[Wang2012]`, `[LindenstraussWang2012]` | yes (l. 336, l. 669) | Wang2012 in `library/pdf/` | see rows |
| `[Moorhouse2010slides]`, `[Soifer2024]`, `[ExooIsmailescu2019]`, `[Madore2015]`, `[Manturov2012]` | yes | all in `library/` | read (per rows) |
| `[Polymath16threads]` | yes (l. 191) | `library/papers/…/polymath16-threads-1-18-text.txt` | searched 2026-09-09 (FS-23) for other questions |

### 1.2 zbMATH author listings (WORKFLOW 3.2 item 8), the posers of the value question

Queries (zbMATH Open API, 2026-09-26 ~11:26 UTC), saved under `data/fs100/x24r/zb/<tag>.json` and `.txt`:

| poser | query | total | on-subject titles (chromatic number of planes / fields / unit-distance) |
|---|---|---|---|
| Moorhouse | `au:"Moorhouse, G. Eric"` | 28 | **none** — finite geometry only; the 2010 draft and slides are not indexed |
| Soifer | `au:"Soifer, Alexander"` | 127 | the chromatic-number essays; newest: **Zbl 1569.05108 (2025)** *New results and new open problems and conjectures related to the chromatic number of the plane problem* (review read: two pages, 6-colourings, a 7-chromatic two-distance conjecture, `ℝⁿ` — nothing on number fields or triangle-free graphs) and **Zbl 1559.05062 (2024)** *New open problems and conjectures in the new mathematical coloring book* (no review text); neither in `BIBLIOGRAPHY.md` |
| Exoo | `au:"Exoo, Geoffrey"` | 102 | 1362.05039 (2016) *Small order triangle-free 4-chromatic unit distance graphs* (in `BIBLIOGRAPHY.md` once); 1445.05040; 1360.05032; 1452.05048; 1407.05072; 1302.05051; 1559.05053 (hyperbolic plane) — none on five colours without triangles |
| Ismailescu | `au:"Ismailescu, Dan"` | 46 | the same joint papers with Exoo; 1423.05187 — nothing further |
| Fischer | `ai:fischer.klaus-g` (the author is **Klaus** G. Fischer; `au:"Fischer, Kurt G."` returns nothing) | 31 | exactly three on-subject: 0744.05061 (1990), 0733.05048 (1990), 0836.05030 (1994) — all held and read |
| Johnson | `au:"Johnson, Peter D. jun."` | 188 | on-subject: 0648.05006 (1987, held), 0701.05005 (1990), 0974.05029 (2000, `[Johnson2000]`), 0951.05038 (2000, intro to Benda–Perles), 1243.05082 (2011), **1461.05078 (2021)** *On single-distance graphs on the rational points in Euclidean spaces* (Canad. Math. Bull., doi 10.4153/S0008439520000181; zbMATH text withheld; not in `BIBLIOGRAPHY.md`), 0990.05048 (2001; in `BIBLIOGRAPHY.md`) |
| Madore | `au:"Madore, David A."` | 13 | only 1479.05123 (2021) *Coloring the Voronoi tessellation of lattices*; his 2015 arXiv paper is not indexed |
| Manturov | `au:"Manturov, Vassily O."` | 167 | only 1343.05065 (2016) (`[Manturov2012]`) |

**Stage 1 finding:** no poser has a zbMATH-indexed work whose title or review text claims five colours for any real quadratic field, a number
field without √3, or a triangle-free five-chromatic unit-distance graph. Candidates to open in stage 2: Johnson 2021 (Zbl 1461.05078), Soifer
2024 (Zbl 1559.05062), the Polymath16 threads, `[Soifer2024]` ch. 11 and ch. 55.
