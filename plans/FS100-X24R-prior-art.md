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

## Stage 2 — SAVED (11:30–11:38 UTC): Question 1 (the value) and Question 3 (S-adic / number-field Einsiedler–Fish)

### 2.1 Question 1 — is `χ(ℚ(√47)²) = 5`, five for any real field without √3, or a triangle-free five-chromatic unit-distance graph in the plane, in print?

**Answer: not found in any venue searched.** Every source below was searched or read on 2026-09-26; each negative names its queries.

| venue | queries / what was read | result | reading status |
|---|---|---|---|
| zbMATH author listings (stage 1, §1.2) + four more posers of the lineage named by `[Soifer2024]` ch. 11 (p. 89: "Peter D. Johnson, Jr. … Joseph Zaks … Klaus Fischer … Kiran B. Chilakamarri … Michael Reid, Douglas Jungreis, and David Witte … and Timothy Chow"): `au:"Zaks, Joseph"` (84), `au:"Chilakamarri, Kiran B."` (26), `au:"Chow, Timothy Y."` (40), `au:"Jungreis, Douglas" & au:"Reid, Michael"` (2) | every on-subject title is about `ℚⁿ` (Zaks 0766.05032, 0705.05033; Chilakamarri 0642.05047, 0705.05034, 0803.05021; Chow 0771.05035; JRW 0771.05039) or triangle-free *four*-chromatic graphs (Chilakamarri 0848.05027) | none on a real quadratic field, none at five colours without triangles | zbMATH reviews (reviewer's) read for 0766.05032, 0803.05021, 0848.05028, 0783.05046 |
| zbMATH abstract search (`data/fs100/x24r/zb/q1_*.txt`) | `ab:"triangle-free" & ab:"unit distance" & ab:"chromatic"` (3); `ti:"triangle-free" & ti:"unit distance"` (4); `ab:"triangle-free" & ab:"5-chromatic"` (2); `ab:"triangle-free" & ab:"chromatic number of the plane"` (2); `ab:"unit distance" & ab:"number field"` (2); `ab:"chromatic number" & ab:"quadratic field"` (0); `ab:"chromatic number" & ab:"quadratic extension"` (1); `ab:"chromatic number" & ab:"algebraic extension" & ab:"plane"` (0); `ab:"forbid" & ab:"distance one" & ab:"rational"` (0); `ab:"unit distance" & ab:"rational points" & py:2015-2026` (0); `ab:"Hadwiger-Nelson" & py:2019-2026` (18); `ti:"chromatic number of the plane" & py:2020-2026` (10); `ab:"five colors" & ab:"unit distance"` (3); `ab:"girth" & ab:"unit distance" & ab:"chromatic"` (7); `so:"Geombinatorics" & py:2024-2026` (37) | triangle-free: only four-chromatic planar graphs (O'Donnell 1995, 2000; Exoo–Ismailescu 2016, Zbl 1362.05039; Silva Filho arXiv:2607.19995, which certifies the coordinate fields of the 17- and 19-vertex *four*-chromatic ones) and **five-chromatic only in ℝ³** (de Grey, Geombinatorics 2026, Zbl 1581.05080: *"We present an embedding of a 61-vertex, 5-chromatic graph of girth 4 in ℝ³"*); number fields: nothing on colouring | titles and zbMATH summaries/reviews; the arXiv abstracts of 2607.19995, 2312.06898, 2606.27352 read (abstracts, not readings) |
| arXiv API (`arxs_*.xml`, `arx_chplane_all.txt`, `arx_recent_ud.xml`) | `abs:"triangle-free" AND abs:"unit distance" AND abs:"chromatic"`; `abs:"quadratic field" AND abs:"chromatic number"`; `abs:"unit distance" AND abs:"number field" AND abs:"chromatic"`; `abs:"rational points" AND abs:"chromatic number" AND abs:"distance"`; `abs:"Hadwiger-Nelson" AND abs:field`; four unquoted variants; **positive control** `abs:chromatic AND abs:plane` (259 hits, every abstract scanned for "triangle-free", "quadratic", "number field", "√47"); the 40 newest papers matching "unit distance" or "chromatic number of the plane" (to 2026-09-21) | nothing on five colours over a field without √3; the triangle-free hits are intersection graphs; the newest (Solymosi 2609.17453, Guth 2609.10791, Dúcz 2606.12325, Dúcz–Varga 2606.28157, Didin–Voronov 2607.19946) are on other questions | abstracts only |
| Polymath16, held text (`library/notes/polymath16-threads-1-18-text.txt`, fetched 2026-09-09, comments to August 2026) | grep: "triangle-free"/"triangle free" (all hits read in context), `sqrt{47}`, `sqrt(47)`, `Sqrt[47]`, `√47`, `quadratic field` (0), `quadratic extension` (3), `number field` (3), `Moorhouse` (0) | triangle-free five-chromatic appears only as Soifer's question and in ℝ³ (de Grey's 61-vertex graph; an anonymous 2025-12-04 comment: *"I have seen a claim in a 2013 paper of an unpublished triangle‑free, 5‑chromatic graph, but I haven't been able to find such a publication or construction"* — in the context *"What is true for n = 3"*); Haugstrup's triangle-free 6-chromatic UDG is in ℝ⁴ | read in context, every hit |
| Polymath16, **live** eighteenth thread (fetched now, `data/fs100/x24r/pm18-live.html`/`.txt`) | every comment after the held snapshot: 2026-09-13 to 2026-09-24 (de Grey on `[Haugland2026]`; Voronov; Raigorodskii on SDP bounds; Voronov 2026-09-24: *"In the next few days I hope to submit some findings. But none of them improves the bounds from this project."*) | nothing on ℚ(√47), fields without √3, or planar triangle-free five | read in full (the new comments) |
| `[Soifer2024]` (held PDF, text layer) ch. 55, p. 699, read in full | *"Construct 5-Chromatic Triangle-Free UDG 55.1 (2019, [Soi46]). Construct a triangle-free 5-chromatic unit-distance graph."* and *"Smallest 5-Chromatic Triangle-Free UDG 55.2 (2019, [Soi46]). Find a 5-chromatic triangle-free unit-distance graph of the smallest order."* — posed, no partial result | open as of the book | ch. 55 read in full; ch. 11 pp. 87–90 read (Open Problems 11.1, 11.5, 11.6; the lineage paragraph) |
| Soifer's newest problem papers | Zbl 1569.05108 (Geombinatorics 2025, review read: 6-colourings, two-distance, `ℝⁿ`); Zbl 1559.05062 (2024, no review text) | nothing on number fields or triangle-free five | review only / title only |
| `[Johnson2000]`, `[Johnson2006]` | galley URL `geombinatorics.uccs.edu/archive/index.php/home/article/view/62/198` → **HTTP 403** (Cloudflare, as recorded); zbMATH 1506.05069 has **no review text** | **still unread** — the standing debt | not held |
| Bau–Johnson–Noble 2021, *On single-distance graphs on the rational points in Euclidean spaces*, Canad. Math. Bull. 64 (2021) 13–24, doi 10.4153/S0008439520000181, Zbl 1461.05078 (not in `BIBLIOGRAPHY.md`) | Crossref abstract read: *"let `G(ℚⁿ, d)` denote the graph whose vertices are the set of rational points `ℚⁿ`, with `u, v ∈ ℚⁿ` being adjacent if and only if the Euclidean distance between `u` and `v` is equal to `d`"* | about `ℚⁿ`, not field extensions | abstract only |

**Scope of the negative (G21):** it measures zbMATH's and arXiv's indexing and my query words, the held and live Polymath16 text, and two
chapters of `[Soifer2024]`. It does **not** reach `[Johnson2000]`, `[Johnson2006]` (unobtainable by script), Geombinatorics issues after
zbMATH's indexing horizon (2026 issues are partly indexed: de Grey, Haugstrup, Fox–Pach, Sakai, Voloshin seen), or talks and theses. **The
value is not claimed first until `[Johnson2006]` is read** — the one unread source that by `[Johnson2010]`'s own words treats `G(ℚ(√m)², D)`
(`CLOSED-QUESTIONS.md` §1.7) — but no source read today mentions five colours for any real quadratic field, and the posed questions
(Moorhouse's slides 2010; Soifer's 55.1, 2019/2024; Exoo–Ismailescu's smallest-subfield question) were still stated open in the latest
texts read (Soifer 2024; Polymath16 through 2026-09-24).

**What the claim answers, stated at its exact scope** (for the front page, not a finding of the gate): 55.1 asks to *"Construct"*; a
field-level `χ(ℚ(√47)²) = 5` gives a finite triangle-free five-chromatic unit-distance graph by de Bruijn–Erdős, **not a construction** — the
brief's "existence half" is the right label.

### 2.2 Question 3 — is EF_F⁺ (or any S-adic / number-field Einsiedler–Fish) in print?

**Answer: not found.** EF's theorem and all its known relatives are statements on the circle `ℝ/ℤ` or on tori `ℝⁿ/ℤⁿ` with integer matrices.

| item | what was done | finding | reading status |
|---|---|---|---|
| Sataev 1975, *"On measures invariant with respect to polynomial semigoups of circle transformations. Uspehi Mat. Nauk. 30 (1975), no.2, 203-204"* (Huang 2017's `[Sat75]`, verbatim with its typo) | zbMATH `au:"Sataev"` (79 records): his 1975–77 items are on flows on surfaces and monotone equivalence — **this note is not in zbMATH**; one Math-Net.ru issue-page fetch returned a page with no contents; one web search in Russian found nothing | by Huang's description (§1, p. 2: *"a theorem which is independently discovered by E. A. Sataev in 1975 [Sat75, Thm. 1] and M. Einsiedler and A. Fish in 2010 [EF10, Thm. 1.2]"*, stated for *"a multiplicative semigroup S of positive integers"* on `T`) it is the **circle** theorem, so it is prior art for EF's Thm 1.2, not for EF_F⁺ | **not held, not read**; Huang's §1 and Remark 5.4 re-read for the citation |
| Huang 2017 (Zbl 1402.37006), Huang–Li–Shi–Xu 2023 (Zbl 1537.37013) | X01D's reading confirmed from the held PDFs' §1 | circle; tori with integer matrices, Fourier method — not S-adic, not solenoids | §1 each (X01D; Huang §1/Rem. 5.4 re-read here) |
| **Citers of Einsiedler–Fish 2010**, two databases, identifiers compared (G49) | OpenAlex holds the **published** version (W2053719596, doi 10.1017/s014338570800103x, 5 citers) and the **arXiv** version (W2950049815, 3 citers, two of them ETDS cover matter) **separately**; Semantic Scholar merges them (11 citers). Union: *On C\*-algebras of irreversible algebraic dynamical systems* (JFA 2015, arXiv:1411.2776; authors not checked), *Counter-examples to an infinitesimal version of the Furstenberg conjecture* (ETDS 2015), Huang 2017, Badea–Grivaux *Kazhdan constants…* (CMH 2020, arXiv:1804.01369), HLSX 2023; **S2 only:** Zhao arXiv:2608.24503 (2026), Badea–Grivaux arXiv:2303.01089 (2023), Gilat arXiv:1909.06866 (Discrete Anal. 2019), arXiv:1006.4491 (optimal transport), an AQUE lecture | every citer is on the circle or `ℝⁿ/ℤⁿ`; Zhao 2026 is *"finitely generated nonlacunary multiplicative semigroup"* on `T`; none is S-adic, adelic or a number field | abstracts of the three S2-only arXiv citers read (abstracts only) |
| zbMATH in the discipline's words (`zb/q3_*.txt`) | `ab:"invariant measures" & ab:"solenoid"` (5); `ab:"invariant measure" & ab:"adele"` (2); `ab:"norm one torus" & ab:"invariant"` (1); `ab:"S-arithmetic" & ab:"measure rigidity"` (4); `ab:"nonlacunary" & ab:"invariant measure"` (1: Johnson 1992, the circle); `ab:"multiplicative semigroup" & ab:"invariant measure"` (2); `ab:"adelic solenoid"` (4); `ab:"Rudolph" & ab:"Johnson" & ab:"entropy" & ab:"invariant"` (6); `ab:"polynomial growth" & ab:"invariant measure" & ab:"torus"` (1) | the S-arithmetic hits are homogeneous-space rigidity (Ratner 1993, Einsiedler–Lindenstrauss joinings 2019, Mohammadi 2011); **the one adelic-solenoid measure classification is Bekka–Francini** (§3 below), for groups generated by unipotents | titles and reviews |
| arXiv in the discipline's words (`arxq3_*.xml`) | `abs:nonlacunary AND abs:invariant AND abs:measures` (1: Zhao); `abs:"invariant measures" AND abs:solenoid AND abs:entropy` (2, SRB/Fourier decay); `abs:"measure rigidity" AND abs:"number field" AND abs:torus` (1: ELMV periodic torus orbits, homogeneous spaces); two more (0) | nothing | titles |

**Finding.** EF_F⁺ — *"every `U`-invariant finite positive Borel measure `μ` on `R̂` such that `h_μ(u*) = 0` for one non-torsion `u* ∈ U`
satisfies `μ(R̂ ∖ (T + A)) = 0`"* — has no printed antecedent in the citation graph of Einsiedler–Fish (both databases) or in zbMATH/arXiv
under the words above; the circle theorem it generalizes is Sataev 1975 / EF 2010 (credit both). The gap in the search: the *"Kra"*,
*"Berend"* and Einsiedler–Lind entropy-rank-one lineages were not walked for measure versions (Berend's are topological and held; see
`[Berend1984]`); an S-adic EF would most likely cite EF 2010, and none of its eleven citers is one.

## Stage 3 — SAVED (11:38–11:47 UTC): Question 2 (EL2021 §2) and Question 4 (the discipline's names for MR); proposed rows

### 3.1 Question 2 — is PE-2 or EF_F⁺ in EL2021 §2, "Actions on adelic solenoids"?

**No.** Read in full from the held copy (`~/source/library/pdf/EinsiedlerLindenstrauss2022-…pdf`, text layer, pp. 5–9): §2.1 (adeles,
local and global fields; the normalisation (2.1)), §2.2 (adelic `ℤ^d`-actions on `X_m = A^m/ℚ^m` from `d` commuting matrices in
`GL_m(ℚ)`; Lemma 2.1, adelic subgroups ⟺ `ℚ`-linear annihilators), §2.3 (Proposition 2.2: *"every A-irreducible action of `ℤ^d` arises in
this way from a global number field and d of its elements"*; Proposition 2.3, the product formula), §2.4 (Lemma 2.4, a filtration by
A-irreducible factors). It is set-up for **finitely generated** acting groups (`ℤ^d`) and holds no statement about invariant measures, zero
entropy, infinitely generated groups or limits over growing modules. Also read, because X02D's question is the passage between solenoids:
§4.1–§4.3 (pp. 14–17). **Lemma 4.2** lifts a `ℤ^d`-action on a solenoid `X = X_m/K` (`K = V^⊥`, `X̂ = V ⊆ ℚ^m`) to the adelic solenoid, the
measure lifted as *"a probability measure µ_K on X_m that is invariant under K and modulo K equals µ"* — a **factor** step for one fixed
`ℤ^d`, not an inverse limit over `ℤ[Γ]`-submodules and not a passage from `Γ ≅ ℤ^d` to the infinitely generated `U`. A grep of the whole
paper for "infinitely generated", "countable group", "semigroup", "inverse limit", "projective limit", "isometric", "norm one" finds
none of them (only zero-entropy *extensions* inside the proof of Thm 4.1). **So PE-2's step is not in EL2021, and neither is EF_F⁺.**

*A reading for the derivation lane, one mind, not checked:* EL's solenoid is *"a compact, connected, abelian group whose Pontryagin dual
X̂ can be embedded into a finite-dimensional vector space over ℚ"* (p. 2), so `R̂` itself is one (`R ⊂ L`, torsion-free, finite ℚ-rank).
Thm 1.2 still cannot be applied on `R̂` directly: `ℤ[Γ′]^⊥` is a proper infinite closed `Γ′`-invariant subgroup of `R̂` (`R/ℤ[Γ′]` is an
infinite torsion group), so the action is not totally irreducible — which is why X02D descends to `M̂` (X02D §3). Whether EL's **Thm 1.3**
(hypothesis only *"no virtually cyclic factors"*) applies on `R̂` directly for admissible `Γ` — every factor is dual to a `Γ`-stable
`N ⊆ R` with `ℚN = L`, on which `Γ` acts faithfully by multiplication — is a question for X02D's successor, not a finding.

### 3.2 Question 4 — the discipline's names for MR, and what they find

| name (discipline) | queries | hits that matter | reading status |
|---|---|---|---|
| "invariant measures" + "norm one torus" / "rational points" / "S-arithmetic" / "S-integers" / "adelic solenoid" (ergodic theory) | zbMATH: `ab:"norm one torus" & ab:"invariant"` (1, a rationality paper); `ab:"invariant measures" & ab:"rational points" & ab:"torus"` (1, S.-W. Zhang, algebraic dynamics); `ab:"S-arithmetic" & ab:"measure rigidity"` (4, homogeneous spaces); `ab:"invariant measures" & ab:"S-integers"` (0); `ab:"unit circle" & ab:"invariant measure" & ab:"number field"` (0); `ab:"adelic solenoid"` (4); arXiv: `abs:"norm one" AND abs:torus AND abs:"invariant measure"` (0) | nothing on a norm-one torus's rational points acting on a solenoid | titles/reviews |
| **"character rigidity" / "traces" / "characters" of `R ⋊ U`** (operator algebras, group theory) | zbMATH: `ab:"character rigidity"` (9: lattices, `SL_n`); `ab:"characters" & ab:"number field" & ab:"algebraic group" & py:2015-2026` (5); `ab:"traces" & ab:"semidirect product" & ab:"invariant measures"` (0); arXiv: `abs:characters AND abs:Furstenberg AND abs:invariant AND abs:measures` (3); `abs:"character rigidity" AND abs:solvable` (0); `abs:traces AND abs:"adelic solenoid"` (0) | **(a) Bekka–Francini 2022** (`[BekkaFrancini2022]`, already held and read by X03D; my fetch was byte-identical, md5 `f2be9857…`, deleted): Char(`G(k)`) *"under the assumption that G(k) is generated by its unipotent elements"*; the invariant-measure step (Thm 5.8) is for groups generated by unipotent one-parameter subgroups, by Ratner; Remark 1.2 (iv): *"A general result about Char(G) cannot be expected when the condition L = L⁺ is dropped"*. `R ⋊ U` (an anisotropic torus over `F`) is outside it. **(b) Laca–Warren, arXiv:1801.07802 (2018), new to the bibliography**: *"the extremal traces of C*(J ⋊ O*) are parametrized by pairs consisting of an ergodic invariant measure for the action of O* on Ĵ together with a character of the isotropy subgroup"* (via Neshveyev's characterization of traces on transformation-group C*-algebras), and for unit rank ≥ 2 *"whether normalized Haar measure and equiprobabilities supported on finite orbits are the only ergodic O*-invariant probability measures is a higher-dimensional version of the celebrated Furstenberg conjecture"* (p. 7) — **the discipline's name for MR's character form is "extremal traces / KMS states" and for its measure form "the generalized Furstenberg conjecture"; theirs is the finitely generated case (units on a torus), stated open; MR is the infinitely generated norm-one-torus case on a solenoid, not found**. (c) Bader–Vigdorovich arXiv:2208.07347 (stiffness of stationary measures on character spaces) | (a) §1 pp. 1–6 and Thm 5.8's statement; (b) abstract, pp. 7–9 (Prop. 3.5–3.8) and pp. 13–14 (Cor. 4.10, Thm 4.11); (c) abstract only |
| "Schoenberg" / "radial positive definite" over number fields (harmonic analysis) | zbMATH: `ab:"positive definite" & ab:"radial" & ab:"p-adic"` (0); `ab:"Schoenberg" & ab:"number field"` (0); `ab:"Schoenberg" & ab:"p-adic"` (1, a proceedings volume); `ab:"positive definite" & ab:"number field" & ab:"invariant"` (12, theta functions and quadratic forms); `ab:"radial" & ab:"positive definite" & ab:"rational"` (6, numerical analysis); arXiv: `abs:"positive definite" AND abs:"number field" AND abs:radial` (0) | nothing | titles |

**Finding.** MR(F), *"every `U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure"*, was not found in
print under any of these names. Its nearest printed neighbours are (i) EF 2010 / Sataev 1975 on the circle (the infinitely generated
semigroup case, which MR generalizes to a norm-one torus over a number field), (ii) EL2021 for `ℤ^d` on solenoids (positive entropy only),
(iii) Bekka–Francini for unipotent-generated groups on adelic solenoids, and (iv) Laca–Warren's "generalized Furstenberg conjecture" for
finitely generated unit groups on tori (open). A reviewer in operator algebras would ask about (iv) first.

### 3.3 Proposed `BIBLIOGRAPHY.md` rows (the front-page lane writes them)

| key | entry | role | copy | read |
|---|---|---|---|---|
| **[LacaWarren2018]** (new) | M. Laca, J. M. Warren, *Phase transitions on C\*-algebras arising from number fields and the generalized Furstenberg conjecture*, arXiv:1801.07802 (journal not checked) | names MR's character form (extremal traces of `C*(J ⋊ O*)` ↔ ergodic invariant measure + isotropy character, via Neshveyev) and the finitely generated case as the open "generalized Furstenberg conjecture" | `data/fs100/x24r/LacaWarren2018-1801.07802.pdf` | abstract; pp. 7–9, 13–14 (X24R) |
| **[BauJohnsonNoble2021]** (new) | S. Bau, P. D. Johnson Jr., M. Noble, *On single-distance graphs on the rational points in Euclidean spaces*, Canad. Math. Bull. 64 (2021) 13–24, doi 10.4153/S0008439520000181, Zbl 1461.05078 | `χ(ℚⁿ, d)`; checked for a quadratic-field value, none | not held | abstract (Crossref) only |
| **[Soifer2025open]** (new) | A. Soifer, *New results and new open problems and conjectures related to the chromatic number of the plane problem*, Geombinatorics (2025), Zbl 1569.05108; and *New open problems and conjectures in the new mathematical coloring book* (2024), Zbl 1559.05062 | the poser's latest problem lists; checked for 55.1's status | not held | zbMATH review (2025) / title only (2024) |
| `[EinsiedlerLindenstrauss2022]` (amend the read column) | — | §2 is set-up only; PE-2 and EF_F⁺ not in it; Lemma 4.2 is a lift for fixed `ℤ^d` | held | **§1, §2 (pp. 5–9), §4.1–§4.3 (pp. 14–17) read** (X24R, 2026-09-26); §§3, 5–9 unread |
| `[BekkaFrancini2022]` (amend) | — | add: Thm 5.8's statement read; the torus case is excluded by hypothesis | held (`data/fs100/x03d/`) | + §1 pp. 1–6 (X24R) |
| `[EinsiedlerFish2010]`, `[Huang2017]`, `[HuangLiShiXu2023]`, `[Sataev1975]` (X01D's proposals) | add to `[Sataev1975]`: **not in zbMATH** (author listing checked); one Math-Net.ru fetch and one Russian web search failed; by Huang's description a circle theorem | EF's Thm 1.2's first proof | not held | not read |
| EF 2010's citers (one line under `[EinsiedlerFish2010]`) | OpenAlex splits the ETDS and arXiv records (5 + 3 citers); Semantic Scholar merges them (11); none is S-adic or number-field; S2-only: Zhao arXiv:2608.24503 (2026), Badea–Grivaux arXiv:2303.01089, Gilat arXiv:1909.06866 | EF_F⁺ negative | — | abstracts |

### 3.4 Proposed `CLOSED-QUESTIONS.md` text (the front-page lane decides)

- **§1.7 (Moorhouse's `ℚ(√47)`):** add one sentence: *"Prior-art gate for the value (X24R, 2026-09-26, `plans/FS100-X24R-prior-art.md` §2.1):
  no printed value of `χ(ℚ(√47)²)` and no printed five-colour lower bound for any real field without √3 were found in zbMATH (author
  listings of Moorhouse, Soifer, Exoo, Ismailescu, Fischer, Johnson, Madore, Manturov, Zaks, Chilakamarri, Chow, Jungreis–Reid; abstract
  searches), arXiv, the Polymath16 threads (held text and the live eighteenth thread to 2026-09-24) or `[Soifer2024]` chs. 11 and 55;
  `[Johnson2000]` and `[Johnson2006]` remain unread."* The section's rule stands: nothing recorded as closed until they are read.
- **§3 (Soifer's Open Problem 55.1):** if the value lands, the answer is to 55.1's **existence** question only — 55.1 reads *"Construct a
  triangle-free 5-chromatic unit-distance graph"*, and a field-level value gives a finite graph by de Bruijn–Erdős, not a construction.
  Nothing in print (to 2026-09-24) has a planar triangle-free five-chromatic unit-distance graph; the only five-chromatic triangle-free
  one is in ℝ³ (de Grey, Geombinatorics 2026, Zbl 1581.05080).
- **§3 (Exoo–Ismailescu's smallest subfield):** a quadratic field needing five would be of the least degree possible (ℚ's plane is
  two-chromatic), so "smallest" would be answered by degree; whether ℚ(√47) is the smallest *quadratic* one is a separate question
  (ℚ(√d) with `d < 47` all have `χ ≤ 4`: `CLOSED-QUESTIONS.md` §1.7's classification, `L ≤ 4` below 47).
