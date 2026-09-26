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

## Stage 2 — SAVED

*Question 1 (the question itself), then question 3 (where `χ_CP` sits), with the coordinator's two added queries (the advisor's): (a) does
ignoring null sets change the measurable chromatic number; (b) what Shelah–Soifer prove about the plane. Every zbMATH query is saved as
`data/fs103/fs103-g/zb/qNN.{tsv,json.gz}` (query string in the file's first line). Web searches are named with their words.*

### 2.1 Question 1 — is the collapse, `χ = χ_m`, `χ = χ_B`, a stationary colouring number, or a single field attaining `χ(ℝ²)` in print?

**Verdict: none of the collapse, `χ(ℝ²) = χ_m(ℝ²)`, `χ(ℝ²) = χ_B(ℝ²)`, or `χ(ℝ²) = χ_CP(ℝ²)` was found in print** (queries §2.4). What is in
print leans the other way, and says so in words:

| source (reading status) | verbatim | what it settles |
|---|---|---|
| **Shelah–Soifer 2003**, JCTA 103, 387–391 (Zbl 1030.03035) — **read in full** (5 pp., fetched from Shelah's archive, `data/fs103/fs103-g/shelah-soifer-2003-…pdf`) | "Falconer, for example, showed [F] that χ is at least 5 if monochromatic sets are Lebesgue measurable." Conditional Theorem: "Assume that any finite unit distance plane graph has chromatic number not exceeding 4. Then: (∗) In ZFC the chromatic number of the plane is 4. (∗∗) In ZF + DC + LM the chromatic number of the plane is 5, 6 or 7." Closing: "Perhaps, the problem of finding the chromatic number of the plane has withstood all assaults in the general case, leaving us with a wide range for χ being 4, 5, 6 or 7 precisely because the answer depends upon the system of axioms we choose for set theory?" | **the coordinator's (b).** They prove nothing about the plane unconditionally; their example is a graph on ℝ (edges `s − t − √2 ∈ ℚ`) with `χ = 2` in ZFC and not countably colourable in ZF + AC_ℵ₀ + LM. The plane enters only through the Conditional Theorem, whose hypothesis de Grey refuted in 2018 (`[Soifer2024]` ch. 64: "Today, the following theorem has only a historic, or anthropological interest"). **They do not state `χ = χ_m` as an open problem in those words**; they pose, as a question, that the value may depend on the axioms — i.e. that `χ_ZFC(ℝ²)` and `χ_{ZF+DC+LM}(ℝ²)` may differ |
| **`[Soifer2024]`** ch. 62–64 (pp. 755–769) — **read**: §62 end, §63.2, §64.1–64.3 | Open AC Problem 62.14: "For which values of n is the chromatic number χ(Eⁿ) of the n-space Eⁿ is defined 'in the absolute,' i.e., in ZF regardless of the addition of the Axiom of Choice or its relative?"; Theorem 64.2: "χ_ZFS+(E²) ≥ 5" (ZFS+ = ZF + DC + LM); Conjecture 64.3: "χ(E²) = 7"; Graham's $1,000 Problem 64.5: "Prove or disprove the existence of a 6-chromatic unit-distance graph." | the book's form of the question: whether `χ(ℝ²)` is absolute. A proof of `χ_ZFC(ℝ²) = χ_ZFS+(ℝ²)` would answer 62.14 at `n = 2`. **Not** `χ = χ_m` in ZFC, and no statement about stationary colourings |
| **`[KechrisMarks2020]`** §5.1 Example 5.1 — **read** (held) | "the unit distance graph on R², … is known to have 5 ≤ χ(U) ≤ χ_µ(U) ≤ χ_B(U) ≤ 7, see [DG] and [So], but the exact values of χ(U), χ_µ(U), χ_B(U) are unknown." | the three numbers are each unknown; equality between them is **not posed** as a separate problem |
| **`[Payne2009]`** (Electron. J. Combin. 16, N31; arXiv:0707.1177v3) — **read in full** (held; re-read 2026-09-26) | Abstract: "…may be seen as further evidence that the chromatic number of the plane might depend on set theory." Prop. 1: "The measurable chromatic number of TKⁿ is at least the (general) chromatic number of Rⁿ. That is, χm (TKⁿ) ≥ χ(Rⁿ)." Prop. 2: "χ(Kⁿ) = χ(TKⁿ)." §3: "In the most famous case of the plane we have χ(TQ²) = 2 while χm(TQ²) ≥ 5." Here `TKⁿ` has vertex set `ℝⁿ` and "two vertices are joined by an edge if their difference is a unit vector in Kⁿ", `ℚ ⊆ K ⊆ ℝ` | **the literature's word for the gap the collapse closes: "ambiguous chromatic number" (`χ ≠ χ_m`).** See §2.3 (the recognition) |
| **Székely 1984** (Combinatorica 4, 213–218; Zbl 0558.05020) — **second-hand** through Payne §1 | Payne: "He gave an example of a graph which could be 2-coloured in general, but which needed 3 colours in the measurable case. … Székely concluded that (assuming the Axiom of Choice) chromatic number and measurable chromatic number were not in general the same." | the origin of "χ ≠ χ_m for geometric graphs" (1984); not the plane |
| **Polymath16, fourteenth thread region** (held text, `library/notes/polymath16-threads-1-18-text.txt`, line 40; domotorp, 16 April 2019) — **read (the comment)** | "If we accept that the measurable chromatic number is the same as the chromatic number, then I agree with you." | the equality used **as a heuristic assumption** in a blog comment about spheres — not a claim, not a conjecture |
| **`[Madore2015]`** ¶1.3, ¶5.4, §7.1–7.2 — **read** (held) | ¶5.4: "One consequence is that χ(Rᵈ) = χ((Q^{r−alg})ᵈ) where Q^{r−alg} stands for the real closure of Q (which can be seen as the set of real algebraic numbers)." §7.1: "One might therefore argue that the 'right' Hadwiger-Nelson problem in the absence of choice concerns the value of χ_fin(R²) … the value of χ_fin(R²) is a purely arithmetical question, and therefore independent of set-theoretical subtleties." | **a single countable subfield attaining `χ(ℝ²)` IS in print — the real algebraic numbers (2015)**, and "attained by some number field" follows from de Bruijn–Erdős (both known here: `CLAUDE.md` G63, FS-39's bridge). **No named number field** attaining `χ(ℝ²)` was found. So the owner's at-once trigger ("any single field attaining `χ(ℝ²)` in print") fires only in this known, non-constructive form, and I did not send it as news |

**Known consequences of `χ = χ_m` that would transfer to the collapse** (question 1's last part). None is stated in print as a consequence.
Two follow from the sources above: a ZFC proof that `χ(ℝ²) = χ_B(ℝ²)` would make `χ(ℝ²)` absolute between ZFC and ZF + DC + LM (a Borel
colouring's code is absolute, and Falconer's argument runs under DC — Shelah–Soifer §2: "DC is sufficient for Falconer's result"), answering
Soifer's Open AC Problem 62.14 at `n = 2`; and every lower bound for `χ_m(ℝ²)` (Falconer's five; the density bounds) would become a lower
bound for `χ(ℝ²)`. **F1 claims only `χ = χ_CP`,** so neither transfers until C-FMT (plan §6) places `χ_CP` against `χ_m` and `χ_B`.

### 2.2 The coordinator's (a) — does ignoring null sets change the measurable chromatic number of the plane?

**Not found in print, as a question or as either inequality** (queries q24–q28, the web search in §2.4). What is in print:

- **`[BachocEtAl2014]`** §2.4, §2.6, §3.1 — **read** (held): the *chromatic number of an operator*, "the smallest number k such that one can
  partition V into k independent sets", where (Def. 2.1) "A measurable set I ⊆ V is called an independent set of A if (Af, f) = 0 for each
  f ∈ L²(V) which vanishes almost everywhere outside of I. Notice that sets of µ-measure zero are always independent." For `A = A_ν`
  (convolution by a measure `ν` on the unit sphere) independence ignores null sets of pairs, and §2.6 proves "`χ(A) ≤ χ_m(G)`" for every
  operator that "respects G", with spectral lower bounds on `χ(A)`. **This is the null-set-tolerant measurable chromatic number, in print,
  with the inequality `χ(A_ν) ≤ χ_m`; the reverse inequality is not stated.** It is the claim list's `χ_m⁰` (`data/fs103/claims.md` D-M)
  up to the choice of `ν`.
- **The density bounds are null-set tolerant, by their own mechanism, though stated for everywhere-avoiding sets.** `[OliveiraVallentin2010]`
  Thm 1.1 (read) and `[AmbrusEtAl2023]` Thm 1 (read in full) use the autocorrelation `f(x)` and, in Ambrus et al. Lemma 1, the atoms
  `a_X(ε)`; with a set that avoids distance 1 only off a null set of pairs, `f` still vanishes on the unit circle (it is continuous) and the
  non-independent atoms are still zero. **Reading, not in print**: `m₁(ℝ²) ≤ 0.2470` holds for such sets, hence for the classes of a
  stationary CP colouring, where the atoms are the probabilities of cylinder events (this is how the claim list's I-CP57 already uses it).
- **Falconer's argument, as Soifer prints it**, uses properness at translated diamonds for a positive-measure set of translations and
  a.e. orientation, and on density points of the circle of radius `√3`; **`[Payne2009]` Lemma 1** ("Let S be a measurable set which is
  admissible as a colour set for TKⁿ and suppose that x ∈ Rⁿ is at unit distance from a point in S̃. Then d_S(x) = 0.") is the step in a
  form that only needs the density points. **Reading, not in print**: Falconer's `≥ 5` survives for colourings proper off a null set of
  pairs. Killing test: a measurable four-colouring of `ℝ²` proper at almost every unit pair. (Either way five already follows from the
  density bound above.)

### 2.3 The recognition — what the gate teaches about the object (WORKFLOW 9's §PA sweep, done now because it bears on the verifiers)

1. **The literature's name for the gap is "ambiguous chromatic number"** (`[Payne2009]`; Székely 1984; Shelah–Soifer): a graph is
   ambiguous when `χ ≠ χ_m`. Payne's graph `TK²` — `ℝ²` with edges the unit vectors of `K²` — is, as a graph, disjoint copies of `K²`
   (his Prop. 2), and his Prop. 1 is the measurable form of I-CPUP ("`χ(F²) ≤ χ_CP(ℝ²)`"). In those words **F1 says: given MR, at a field
   with every stable place `k`-thick, `TF²` is not ambiguous in CP form at `k`**. Payne's ambiguous examples — `ℚ`, `ℚ(√n)` for
   `n ≡ 1, 2 (mod 4)` and for the classes where Fischer's colourings exist, `ℚ(√3)` ("χ = 3 and χm ≥ 5") — are exactly fields with a
   non-thick place (a dyadic or 3-adic place carrying the colouring). They are in-print positive controls for the claim list's CTL-Q2 and
   CTL-K-4: the chain must stop at each of them. Payne's Lemma 1 (density-point transport along a dense set of unit directions) is the
   measurable twin of the CP step "`U_F` dense in `S¹` plus continuity in probability extends properness to every unit vector".
2. **The fractional shadow of F1 contradicts a conjecture stated twice in print.** `[AmbrusEtAl2023]` §4 Remark (read in full here before;
   re-read): "we venture to conjecture that χf(R²) = χgf(R²) = 4. This would imply that α₁(R²) = 1/4 and m₁(R²) ≤ 0.247 hold
   simultaneously, providing an interesting example of a natural infinite graph for which the measurable and the non-measurable variants of a
   parameter have different values." `[MatolcsiEtAl2025]` (arXiv:2311.10069, held; §2 (14), §3, Conjecture 1 read): "Conjecture 1.
   χf,0(R²) = 4, and for all finite unit distance graphs G ⊆ R² we have χf(G) < 4", and "(14) 0.22936... = δCroft ≤ m₁(R²) ≤ α₁(R²) ≤ 1/4".
   Here `α₁(ℝ²) = inf{α(G)/|G| : G finite}`. **The connection (a reading, one mind, for the planner and the verifiers):** a translation-
   invariant random independent set of `F²` has density at least `α₁(ℝ²)` (Følner sets of the countable abelian group `F²` span finite
   unit-distance graphs); a stationary CP random independent set of `ℝ²` has density at most `m₁(ℝ²) ≤ 0.2470` (§2.2). So **if the chain's
   direction "a colouring of `F²` gives a CP colouring of `ℝ²`" runs on one colour class at a time** — one random independent set of
   density `δ`, with thickness at `λ* < δ/(1−δ)` — then at `F_dG` (every stable place has `λ* ≤ 0.1734 < 1/3`) it proves
   `α₁(ℝ²) ≤ m₁(ℝ²) < 1/4`, i.e. a finite unit-distance graph with `χ_f > 4.04`, refuting the published conjecture and moving the
   fractional record (`χ_f(ℝ²) ≥ 4`, `[MatolcsiEtAl2025]`). If it does not, the step where the other classes enter (the pigeonhole on the
   dominant class across a unit edge, which is where `1/(k−1)` comes from) is where integrality carries F1. **Either outcome is
   informative; the verifiers should be asked which** (proposed control CTL-FRAC, §3.3). This bears on `CLAUDE.md` G24 ("the step to seven
   is integrality") and G60, and the held paper was read in full (J26) without this bearing being drawn — a G50 instance.
3. **Continuity in probability is the whole content of `χ_CP`.** Tao's probabilistic formulation on Polymath16 (fourth thread, 3 May 2018,
   held text line 13): "Let c_{R²} denote a random 4-coloring obtained by starting with the deterministic 4-coloring and applying a random
   Euclidean isometry … However by using the device of ultrafilters, it is possible to make this concept rigorous, at the cost of making the
   probability measure only finitely additive rather than countably additive." So an isometry-invariant random `k`-colouring exists for
   every `k ≥ χ(ℝ²)` (finitely additive in Tao's form; countably additive on `[k]^{ℝ²}` by a Følner limit, my reading); dropping continuity
   in probability makes the stationary number equal `χ`. The planner's CTL-ABS (`Cay(ℝ, {±1, ±√2})`, `χ = 2`, `χ_CP = 3`) is the CP form
   of Shelah–Soifer's line example (`s − t − √2 ∈ ℚ`).
4. **"Removing measurability from Falconer's argument" was attempted on Polymath16 and not done.** domotorp (6 May 2018, held text):
   "This is a proposal of a way to prove that we can start with a similar assumption in case of non-measurable colorings … At the moment I
   can only prove this statement for m=2". Mixon (9 May 2018): "If you can't k-color a unit-distance graph with a bichromatic vertex, then
   you can run part of Falconer's argument to conclude that the measurable chromatic number is at least k+1. I don't know how to remove
   'measurable' from the conclusion." Tao (11 May 2018): "One small remark (coming from an attempt to remove measurability from the
   Falconer argument)…". The CP format is a third route between the two: stationary and continuous in probability, but not measurable.

### 2.4 Question 3 — where `χ_CP` sits: random and stationary colourings of `ℝⁿ`

**Not found in print**: any definition of, or result on, a translation-invariant random colouring of `ℝⁿ` avoiding a distance that is
countably additive and continuous in probability. The factor-of-IID colouring literature (Conley–Marks–Tucker-Drob 2016, Zbl 1528.03196,
summary read; Lyons; Tóth 2021) works on Cayley graphs of countable groups, not on `ℝⁿ` distance graphs. The closest objects in print:
`[BachocEtAl2014]`'s operator chromatic number (§2.2; `≤ χ_m`), `[AmbrusEtAl2023]`'s geometric fractional chromatic number (Def. 2; a
finite-graph LP with congruence constraints, `χ_gf ≥ χ_f`), `[MatolcsiEtAl2025]`'s finitary `χ_f,0` against measurable `m₁` (§2.3),
`[DeCorteOliveiraVallentin2022]`'s locally independent sets and `α_ω` (compact spaces; read before), Tao's finitely additive invariant
random colouring (§2.3). **Doob's measurable modification** (a process continuous in probability has a jointly measurable version) is
standard probability (Doob 1953); no paper applying it to colourings was found. None of the harmonic-analysis papers defines a colouring
number **between** `χ` and `χ_m`: BDOV's `χ(A)` is below `χ_m` and not compared with `χ`.

| # | database | query (in the discipline's words) | hits | opened / verdict |
|---|---|---|---|---|
| q01 | zbMATH | `ab:"measurable chromatic number" & ab:plane` | 3 | Payne 2009 (read); Measurable colorings of `S²_r` (2015); taxicab plane (2018) — listings; negative for the question |
| q02 | zbMATH | `ab:"chromatic number of the plane" & ab:"axiom of choice"` | 3 | Shelah–Soifer III (review read), Payne, Krebs 2021 (summary read) |
| q03 | zbMATH | `ab:"ambiguous chromatic number"` | 1 | Payne 2009 |
| q04 | zbMATH | `ab:"translation invariant" & ab:coloring & ab:distance` | 3 | Szlam-lemma papers (translates of point sets) — negative |
| q05 | zbMATH | `ab:stationary & ab:coloring & ab:distance` | 9 | proceedings volumes, 3-colouring model on `ℤ^d`, finitely dependent processes — negative for `ℝⁿ` |
| q06 | zbMATH | `ab:"factor of i.i.d." & ab:coloring` | 0 | negative (the phrase is rarely in summaries; see the web search below) |
| q07 | zbMATH | `ab:"Borel chromatic number" & (ab:Euclidean \| ab:"unit distance" \| ab:plane)` | 2 | Bardestani–Mallahi-Karai 2017 (`[BardestaniMallahiKarai2017]`, known); basis theorems 2008 — negative |
| q08 | zbMATH | `ab:"invariant random" & (ab:coloring \| ab:colouring)` | 1 | Tóth 2021, Schreier decorations of unimodular random networks — negative |
| q09 | zbMATH | `ab:"continuous in probability" & (ab:coloring \| ab:colouring)` | 0 | negative |
| q10 | zbMATH | `ab:Solovay & ab:chromatic` | 3 | Kanovei 1997 (review read), Zapletal 2025 *Triangles and Vitali sets* (review read: equilateral-triangle hypergraph in ZF + DC) — negative for the plane's unit distance graph |
| q11 | zbMATH | `ab:measurable & ab:"Hadwiger-Nelson"` | 4 | hyperbolic plane, taxicab, tropical norm, Kovač 2026 — negative |
| q12 | zbMATH | `ti:"chromatic number" & ab:"Lebesgue measurable"` | 4 | the Shelah–Soifer series; Kupavskii-type 2015 — negative |
| q13 | zbMATH | `ab:"chromatic number of the plane" & (ab:"algebraic numbers" \| ab:subfield \| ab:"number field")` | 0 | negative (Madore's ¶5.4 is not in a summary) |
| q14 | zbMATH | `ab:"random coloring" & (ab:"unit distance" \| ab:"distance graph")` | 0 | negative |
| q15 | zbMATH | `ab:measurable & ab:"chromatic number" & ab:"unit distance"` | 7 | Shelah–Soifer III, Payne, OV 2010, BNOV-line density papers — negative |
| q16 | zbMATH | `ab:"measurable coloring" & ab:plane` | 2 | Euclidean Ramsey 2015; Kovač 2026 — negative |
| q17–q23 | zbMATH | stochastic geometry and fractional: `ab:"random closed set" & ab:"unit distance"`; `ab:"stationary random set" & (ab:distance \| ab:coloring)`; `ab:realizability & ab:covariance & ab:"random set"`; `ab:"autocorrelation" & ab:"avoiding" & ab:distance`; `ab:"measurable" & ab:"non-measurable" & ab:"unit distance"`; `ab:"fractional chromatic number" & ab:plane & ab:measurable`; `ti:"chromatic number" & ab:"Doob"` | 0, 2, 0, 1, 0, 1, 1 | Bellitto et al. 2021 (known); nothing else on topic — negative |
| q24–q27 | zbMATH | the coordinator's (a): `ab:"measurable chromatic" & (ab:"almost every" \| ab:"almost all" \| ab:"null set" \| ab:"measure zero")`; `ab:"chromatic number of an operator"`; `ab:"independent set" & ab:"operator" & ab:"measurable chromatic number"`; `ab:"measurable" & ab:"everywhere" & ab:"coloring" & ab:"distance"` | 0, 0, 0, 0 | negative — **but q25 missed BDOV 2014, whose summary is withheld**; the control q28 `ti:"chromatic number of an operator"` finds it (Zbl 1302.05047). G49's `ab:` blind spot, met again |
| W1 | web | "measurable chromatic number" of the plane equals chromatic number of the plane conjecture | — | Payne, BNOV, Wikipedia; the Székely attribution (via Payne) |
| W2 | web | chromatic number of the plane "translation-invariant" random coloring stationary unit distance | — | Kloeckner 2013 (translation-invariant *metrics*) — negative |
| W3 | web | Székely conjectured measurable chromatic number of the plane not equal … axiom of choice | — | Payne 2009 (the source of the sentence), Bukh 2008, Shelah–Soifer 2004 |
| W4 | web | "factor of iid" OR "invariant random" proper coloring Euclidean distance graph … | — | factor-of-IID colourings of trees and lattices — negative for `ℝⁿ` |
| W5 | web | "measurable chromatic number" "Borel chromatic number" unit distance graph plane equal open problem … | — | Kechris–Marks; Didin–Voronov 2026 (arXiv:2607.19946, *dense colour classes*, abstract read: "12 dense colors suffice to color R²"); Marks's ICM survey (fetched, keyword-scanned: no unit-distance passage) |
| W6 | web | measurable chromatic number plane "almost every" pair … "proper almost everywhere" | — | negative (the coordinator's (a)) |
| W7 | web | chromatic number of the plane in the Solovay model … | — | Shelah–Soifer 2003 (fetched, read) |
| C1 | OpenAlex + Semantic Scholar | works citing `[Falconer1981]` (54 and 64; lists cross-checked, `data/fs103/fs103-g/cites/`) | 64 | titles all scanned; none states `χ = χ_m` or a stationary colouring number; S2-only extras listed in the file |
| C2 | Semantic Scholar | works citing `[Payne2009]` | 14 | titles scanned; one crank (arXiv:1507.00025), the rest surveys and distance-graph papers — negative |
| P1 | held Polymath16 threads | grep "stationary", "random colo", "translation.invariant", "Borel", "Falconer", "measurable chromatic", "invariant measure", "ergodic" | 0, 3, 0, 1, 8, 4, 0, 0 | the passages quoted in §2.1 and §2.3 |

### 2.5 More author listings (the planner's §PA.0.3), filtered in their own vocabulary

Bachoc (49), DeCorte (5), Matolcsi (70), Ambrus (41), Croft (30), Székely (176), Johnson Jr. (194), Madore (13), Moorhouse (28), Perles (70),
Tamuz (55), Lyons (115), Bowen (80), Gaboriau (41); `au:"Townsend, Stephen P"`, `au:"Benda, Miro"`, `ai:conley.clinton-t` return **0** (name
forms not in zbMATH's author index under these strings — Conley appears as a co-author in Kechris's and Marks's listings). On-topic entries
not already above: Ambrus–Matolcsi 2022 *Density estimates of 1-avoiding sets via higher order correlations* (Zbl 1493.52015, review read:
upper bound 0.25442); Székely–Wormald 1989 *Bounds on the measurable chromatic number of ℝ* (Zbl 0683.05021); Székely 1983 *Remarks on the
chromatic number of geometric graphs*; Johnson–Rodger 2002/2005 *Coloring the vertices of a graph with measurable sets in a probability
space* (fractional set colourings, not random colourings of `ℝⁿ`); Johnson 2000 *Infinite graphs and the fractional chromatic number: some
recent surprises* (review read: fractional chromatic number of infinite graphs against their finite subgraphs); Johnson 2011 *Euclidean
distance graphs on the rational points* (survey of `χ(ℚⁿ, {d})`). None states the question.
