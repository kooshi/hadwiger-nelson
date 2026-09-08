# FS-18 — Read the library (pre-subplan stub)

*Minted 2026-09-08 by Opus 5 on Kooshi's override of the backlog plan: "our goal will be to read everything
which is unread in our library and see what we learn." Ranked 1 in `plans/FRONTIER-STUBS.md`. This stub is
written to survive a compaction: a fresh session with no conversation memory can execute it from this file
alone.*

## 0. Why this is rank 1, and why it is a prerequisite rather than a detour

On 2026-09-08 a prior-art check (`plans/A1-theorem-A-kernel.md` §11, `CLAUDE.md` § Grokkings **G49**) found:

* **`[Moorhouse2010]`** — a public, indexed, unpublished draft — contains M58's finite-plane bound (§8.2,
  §10.3), M58's `χ(𝔽₁₁²) = 5` (Table 6.1), M58's ring-generic plane (§1), M61's Cayley-hom lemma (§4.2), the
  `𝔭`-integrality M58 left as a hand step (Lemma 2.3), and a Hedetniemi tie for composite ideals (§9). **Four
  milestones reconstructed it.** It was one web search away.
* **`[Fischer1990]`** — held and read here since M56 — contains the component lemma and the unit argument that
  the Theorem A close offered as findings.
* **`[CervantesKrebs2023]`** — **listed unread in our own bibliography for two days** — systematizes M61's
  periodic quotient (an abelian Cayley graph is an integer matrix; row operations are graph homomorphisms to
  smaller Cayley graphs, hence `χ` upper bounds).
* **`[Krebs2022]`** determines the **clique numbers** of exactly our graphs completely, for every finite field
  and every dimension, and bounds their chromatic numbers with conditions for `χ > ω` — which is G24/G40/G44's
  own subject.
* **`[Soifer2024]`** — the survey whose number-field chapter would have settled the question — has been on the
  shelf, unread, since 2026-09-06.

**Every stub in the frontier set is ranked on an assessment of what is known, and that assessment is now
measured to be wrong.** Reading the shelf is not bookkeeping; it is the cheapest available correction to the
ranking itself.

## 1. The discipline for this milestone

**Reading is not passive here.** Each item below carries **the question it is being read to answer** and
**what would change if the answer is yes**. A read that answers its question with "no" is recorded as such —
a negative is a finding about where the unworked ground is (G49).

Standing rules for the pass:

* **Every work read gets its `BIBLIOGRAPHY.md` entry updated the same day** (the bibliography rule, Kooshi
  2026-09-06): what of ours rests on it, where our copy is, how much was actually read. Move rows from §B/§C
  into §A when they become load-bearing.
* **Anything that corrects the record gets an in-place correction** in `CLAUDE.md` § Frontier (marked
  `PRIOR-ART CORRECTION <date>`, as rows 47, 52, 53, 56 now are) and an amendment to the affected grokking.
  Never a silent rewrite; never a deletion.
* **Anything that answers a stated open question of ours, or that we answer of theirs, is recorded both ways.**
  Theorem B answering Moorhouse §1 is the template.
* **Read for the QUESTION as well as the method.** Every paper's "open problems" section is scanned for
  problems this project has already solved, and for problems it is about to spend a milestone on.
* Budget: a day, possibly two. If an item threatens to eat the budget, record what was read, what was not, and
  move on — the pass is breadth-first by design.

## 2. The inventory, in reading order

### Tier 1 — could correct or complete the record (read these first)

| # | work | held at | status | the question it answers | what changes if yes |
|---|---|---|---|---|---|
| 1 | **`[Soifer2024]`** *The New Mathematical Coloring Book*, Springer 2024 — the number-field chapters (11–12 in the 2009 edition; ch. 58 covers Exoo–Ismailescu) | `library/Alexander Soifer - The New Mathematical Coloring Book_ … (2024).pdf` | **unread since 2026-09-06** | What does the survey say is known about `χ(K²)` for number fields? Does it contain Theorem B, the finite-plane bound, Moorhouse, or Fischer's classification? Does it name open problems this project has answered? | the whole field-wall arc's novelty assessment; possibly further corrections to rows 47, 52, 53 |
| 2 | **`[Fischer1990]`** pp. 8–15 — Theorems 6–10, the real-quadratic classification, "the remaining cases" | `library/papers/1-s2.0-0012365X9090324B-main.pdf` | pp. 1–7 read (2026-09-08); **the rest unread** | Does his classification already settle any field this project claims (`ℚ(√3)`, `ℚ(√7)`, the multiquadratic cases, `d ≡ 23 mod 24`)? What exactly is his `1/k ∈ Σ₀` obstruction's scope? | G35/G38's wall criterion; T23's reconciliation; the multiquadratic claim's standing |
| 3 | **`[Krebs2022]`** *Clique numbers of finite unit-quadrance graphs*, J. Algebraic Combin. 57 (2023) | **not held** — paywalled; try the author's page, arXiv, ResearchGate, or ILL | Closed form for `ω(UD(𝔽_q, n))`; the conditions under which `χ > ω`; do his chromatic bounds fix or bound `χ(𝔽₁₇²)` or `χ(𝔽₂₃²)`? | M59's per-prime `ω` decides become instances; G24/G40/G44's `χ`-vs-`ω` readings get a theorem; **possibly settles FS-17/B3 without compute** |
| 4 | **`[CervantesKrebs2023]`** *Chromatic numbers of Cayley graphs of abelian groups: a matrix method*, Lin. Alg. Appl. (2023), arXiv:2303.06262 + 2303.06272; follow-up arXiv:2511.03028 (rank two, 2025) | **not held** — free on arXiv | Does the matrix method compute `χ` for the finite Euclidean planes? Does it subsume M61's `unitQuadrance_colorable_of_quotient`? Is the periodic-quotient certificate a special case? | row 56's correction; a possibly stronger instrument than the one we built by hand |
| 5 | **`[Chilakamarri1988]`** pp. 4–6 — the clique numbers `ω(n)` of `ℚⁿ` | `library/papers/1-s2.0-0012365X88900490-main.pdf` | pp. 1–3 read (2026-09-08: `U₁…U₄` disconnected, `Uₙ` connected for `n ≥ 5`) | the clique numbers, and whether the rational-space background of the field-wall note's §2 is his | the note's §2 attribution |

### Tier 2 — load-bearing conditionals and second-hand claims (verify what the record rests on)

| # | work | held at | status | the question | what changes |
|---|---|---|---|---|---|
| 6 | **`[Voronov2023]`** arXiv:2304.10163, Exoo's conjecture proved | not held — free on arXiv | **M43/G24/G29's headline is CONDITIONAL on this and it has never been verified here.** Does it prove what we say it does? | a conditional becomes unconditional, or a headline gets qualified |
| 7 | **`[MMST1996]`** Medrano–Myers–Stark–Terras, *Finite analogues of Euclidean space* | not held — J. Comput. Appl. Math. 68 (1996) | M58's `λ(c) = −K(1, c/4)` was verified numerically to `10⁻¹³` but **never read against the paper** | G44's foundation moves from "recalled + measured" to "read" |
| 8 | **`[SchneiderSilva2013]`** arXiv:1306.6050 | not held — free on arXiv | Our planes are generalized Paley graphs `GP(q², q−1)`; when do clique and chromatic numbers coincide, and what does synchronization theory give? | a new discipline on Kooshi's ladder; possibly a criterion for the `ω`-vs-`χ` gap |
| 9 | **`[Johnson1990]`**, **`[Chow1993]`** | `library/papers/1-s2.0-0012365X9090033E-main.pdf`, `…93904818-main.pdf` | abstract / unread | the 2-adic lineage of the residue colouring; Fischer's "if" half in more generality; `ℚ³` and `Aₙ` | G35/G38's lineage; the note's §2 |
| 10 | **`[Zaks1992]`** (believed) | `library/papers/volume-33-paper-23.pdf` | unread; **identity unconfirmed** | is this the Zaks paper at all, and what does it settle for rational spaces? | a bibliography row that currently says "to confirm it is this paper" |

### Tier 3 — the held-but-unread arXiv pile (fetched 2026-09-05, never opened)

`library/pdf/`: `0707.1177` (*Unit distance graphs with ambiguous chromatic number*), `1206.1934`,
`1501.01647` (**Cranston–Rabern**, the fractional chromatic number of the plane — cites Fischer),
`1509.03667` (*Chromatic properties of the Euclidean plane*), `2103.02757`, `2106.05333`,
`2108.07713` (*Embedding Euclidean distance graphs in ℝⁿ and ℚⁿ*), `2201.00275`, `2303.09513` (Joe & Noble —
restates Johnson and Chow; currently second-hand), `2305.07770`, and `raigorodskii-borsuk-survey-RU`
(Russian; `./fetch-papers.sh ocr` makes it searchable). Titles for the bare arXiv ids are in
`library/fetch-papers.sh`; five were fetched with the one-line reason "cites Fischer" or "number-field
planes" and those are the ones to read first.

**The question for the whole tier:** does any of them contain the finite-plane bound, a number-field
chromatic result, or a citation of Moorhouse? Scan-then-read: abstract and reference list first, full read only
on a hit.

### Tier 4 — the §C search-listing backlog

`BIBLIOGRAPHY.md` §C holds ~30 titles seen only in search listings. Triage by title against what Tiers 1–3
turn up; fetch only what they make relevant. **Two are already flagged as likely prior art for our own
work:** arXiv:2502.01958 (map-type colourings — possible prior art for M37–M40's cell family) and
arXiv:2303.06262/06272 (now Tier 1 #4).

## 3. Registered predictions (score at the close)

* **P1** — at least one further correction to `CLAUDE.md` § Frontier lands from Tier 1 (i.e. Moorhouse was not
  the only one).
* **P2** — `[Soifer2024]`'s number-field chapter does **not** contain Theorem B's exact value for
  `ℚ(√3, √11)`, so that result stands. (Registered because the opposite would be the single most important
  thing this pass could find.)
* **P3** — `[Krebs2022]` does **not** fix `χ(𝔽₁₇²)` or `χ(𝔽₂₃²)`; the first digit stays open and FS-17/B3's
  budget stays justified.
* **P4** — `[CervantesKrebs2023]`'s matrix method **does** subsume M61's periodic quotient as a special case,
  and is a stronger instrument than the one we hand-built.
* **P5** — `[Voronov2023]` proves what M43 says it proves, and the conditional in G24/G29 becomes
  unconditional.
* **P6** — at least one paper in Tiers 1–3 states an open problem this project has already answered.
  (Moorhouse §1 was one; the base rate is now above zero.)

## 4. Deliverables

1. `BIBLIOGRAPHY.md` fully updated — every row's "read" column true, §B emptied into §A or §C with reasons,
   §D's standing tasks discharged or re-stated.
2. Every correction owed to `CLAUDE.md` § Frontier and § Grokkings, made in place and marked.
3. A `## §R` results section in this file: what each item answered, the negatives included, and the scored
   predictions.
4. **A re-ranked `plans/FRONTIER-STUBS.md`** — the point of the exercise. The ranking is currently built on a
   wrong assessment of what is known; the pass exists to rebuild it.
5. A line in `data/m53/jobs-ledger.txt`.

## 5. What this milestone is NOT

Not a novelty audit for its own sake. **The measure of success is whether the frontier ranking changes** — if
a day of reading leaves every stub exactly where it was, the pass under-delivered and G49's falsifier gets its
first tick. The second measure is free theorems: results we would otherwise re-derive (`[Krebs2022]`'s clique
numbers, `[Moorhouse2010]` §9's Hedetniemi tie) folded into the record at zero cost.

---

# §R — RESULTS (FS-18 closed 2026-09-08, one day, Opus 5 on branch `backlog`)

*Executed from this file after Kooshi's compaction, on his "You are go for the library read." Twenty-one works
read, seven fetched the same day, five named and not obtained. Every claim below is either a verbatim quotation
from the paper or a computation done here and named as such.*

## §R0 — the headline

**The pass changed the ranking, which §5 registered as its measure of success, and it produced more corrections
than the check that caused it.** Five corrections to `CLAUDE.md` § Frontier, all marked in place; one conditional
the record had carried since M43 discharged; two further stated open questions found that Theorem B answers; one
closed-form theorem recovered that retires two milestones' worth of per-prime computation; and one error found
in the published literature.

## §R1 — what was corrected (five, all marked in place)

| # | what the record said | what the literature says | where marked |
|---|---|---|---|
| 1 | M56's **L7** (`1/d² ∈ Σ₀` from every spindle rotation ⟹ no additive `k`-colouring on a wall-broken plane) is ours | **[Fischer1990] Theorem 10(ii)**, same mechanism: a norm-one `ξ` has `ξ + ξ̄ ∈ Σ₀`, hence `1/k ∈ Σ₀`, hence no additive `k`-colouring. A spindle rotation IS a norm-one element, with `ρ + ρ̄ = 2 − 1/d²`. His Example 4 (`N = 167`) states G38's punchline in 1990 | ledger row 50, G41 |
| 2 | the finite-plane bound has one prior source ([Moorhouse2010]) | **a third, and we held it unread**: [Manturov2012] Theorems 17–19 give the reduction along a ring homomorphism in all dimensions. No usable-prime analysis, no exact values, no number fields | ledger row 52 |
| 3 | the cell family needs `≥ 7` at every scale — ours, conditional on Voronov | **[SokolovVoronov2025] Theorem 2: `χ_poly(ℝ²) = 7`.** A cell-constant colouring is polygonal, so the floor follows in one line, unconditionally, for every lattice and cell shape | ledger rows 34, 35, 36, 40; G22, G24 |
| 4 | `ω(UD(𝔽₁₁,2)) = 3`, `ω(UD(𝔽₁₉,2)) = 2` by kernel `decide`; "`ω = 3` iff `p ≡ 11 mod 12`" a scope correction | **[Vinh2006]: `ω ≤ 4` for every `q`, and triangle-free iff `q ≡ ±7 (mod 12)` (2005/2006).** And better — see §R3 | ledger rows 53, 54; G44 |
| 5 | the `χ`-versus-`ω` gap on the finite planes is the programme's own subject | **[SchneiderSilva2013] Thm 4.7(3): `ω = χ ⟺ m ∣ (p+1)`; our `m = p−1`, so `ω ≠ χ` for every `p ≥ 5`.** A clean group-theoretic proof, independent of the spectral bound | ledger row 53; G44 |

## §R2 — what was discharged

**[Voronov2023] was read and proves exactly what M43 says it proves.** Theorem 1.1: `χ_[1−ε,1+ε](ℝ²) ≥ 7` for
every `ε > 0` and every 2-dimensional norm. The proof is **non-computational** (continuity of colourings of the
unit circle; computer experiments appear once, as an aside in Remark 5.1) — better than we had assumed. So
G24/G29's four-week-old conditional is retired, and the same conclusion now arrives twice over, since
[SokolovVoronov2025] gives it without the interval theorem at all.

Three things came free with it, none previously held: **Corollary 1.1** (`= 7` exactly for `ε ≤ 0.138…`),
**Theorem 1.2** (two unit circles at `1 < ‖u−v‖ < 2` need 4), and **Theorem 1.3 — a disc of RADIUS 3 covered by
six closed sets realizes the unit distance**, an explicit bounded region bearing directly on M44's limit lemma
and G29's `ν` curve. Plus his summary of the state of the art, which we did not hold:
`5 ≤ χ ≤ χ_mes ≤ χ_map ≤ 7 ≤ χ_[1−ε,1+ε]` and `6 ≤ χ_map ≤ χ_nice = 7`.

## §R3 — what came free

**The clique number of every finite Euclidean plane, in closed form.** `[Krebs2022]` is closed access with no
preprint (Unpaywall: `oa_status: closed`, no repository copy; zbMATH's review withheld under conflicting
licences), but `[LorenzZimmermann2023]` state their Theorem 4.4 as *"a generalized version of the main results of
M. Krebs"*, and specialising their table to `q = ⟨1,1⟩`, `a = 1`, `n = 2` gives

> **`ω(UD(𝔽_q, 2)) = 3` if `char = 3` or 3 is a square in `𝔽_q`, and `2` otherwise** — for `p ≡ 3 (mod 4)`,
> `ω = 3` iff `p ≡ 11 (mod 12)` and `ω = 2` iff `p ≡ 7 (mod 12)`.

Checked against all six values this project holds — kernel `decide`s at `p = 11` (3) and `p = 19` (2), and M61's
measurements at 23, 31, 43, 47 (3, 2, 2, 3) — **six for six.** M59's and M61's per-prime `ω` computations are
retired. *(The specialisation is ours; the theorem it specialises is presented by its own authors as generalising
Krebs.)*

**The one piece that could not be reached, and is now the most wanted page in the literature for this project:
Krebs's stated criterion for when `χ` strictly exceeds `ω`.** No citing paper reproduces it. It is exactly
G24/G40/G44's subject. Interlibrary loan or an author request — see §R7.

## §R4 — what the project gave back

**Theorem B answers two more stated open questions, making three in all, posted independently by three groups
who do not cite one another.**

1. **Benda–Perles Open Problem 11.6**, via [Soifer2024] ch. 11, verbatim: *"Find the chromatic number of `ℚ²(√2)`
   and, in general, of any algebraic extension of `ℚ²`."* (Circulated as an unpublished manuscript from 1976;
   published in Geombinatorics in 2000.)
2. **[CranstonRabern2015]**, verbatim: *"What is the fractional chromatic number of `ℚ(√3,√11) × ℚ(√3,√11)`?
   What about its chromatic number?"* — asked after showing `χ_f(K²) ≥ 76/21` on a graph built from a triangular
   lattice plus Moser spindles at integer multiples of `arccos(5/6)`, **which is this project's own direction
   ladder (T13)**. Theorem B closes the second question and **brackets the first at `76/21 ≤ χ_f(K²) ≤ 4`**.
3. [Moorhouse2010] §1, already on record from 2026-09-08's earlier entry.

That the same problem was posed three times across fifty years, and answered here in ignorance of every posting,
is G49's two-literatures diagnosis measured a second time rather than argued.

## §R5 — one error found in the literature (ours)

[Vinh2006] restates his own 2005 lower bound as `1 + (q − (−1)^{(q−1)/2})/q^{1/2}`, **dropping a factor 2 in the
denominator**. That form gives `χ(UD(𝔽₁₉,2)) ≥ 6`, contradicting our kernel-checked
`chromaticNumber_finitePlane19_le_five`. Exact spectra computed here settle it:

| `q` | degree | `λ_min` | `2√q` | Hoffman `1 + deg/(−λ_min)` | the printed 2006 bound |
|---|---|---|---|---|---|
| 11 | 12 | −4.796 | 6.633 | **3.502** | 4.618 |
| 19 | 20 | −7.610 | 8.718 | **3.628** | 5.588 |
| 23 | 24 | −7.961 | 9.592 | **4.015** | 6.004 |
| 59 | 60 | −14.918 | 15.362 | **5.022** | 8.811 |

`|λ_min|` is bounded by `2√q`, not `√q`; the 2005 source's asymptotic form `q^{1/2}(1/2 + o(1))` is correct and
agrees with our M58 numbers exactly. Vinh's 2006 Theorem 4 (`D_q` not perfect except `D₃`) leans on the bad
form — its conclusion is nonetheless true, and **[SchneiderSilva2013] Thm 4.7(3) proves it properly.**

## §R6 — one thing the read got right by going back to the source

[SokolovVoronov2025]'s gloss of [Manta2021] (*"it would take 7 colors to color a plane divided into triangles"*)
reads like earlier prior art for the cell family. **It is not.** Manta's Theorem 2.2 needs a vertex of
**degree ≥ 4**, and the nearest-point cells of a triangular lattice are hexagons meeting **three** at a vertex.
He says so himself: his Question 6.1 asks precisely for the all-vertices-degree-≤-3 case, notes that is where
the classical hexagonal and square 7-colourings live, and observes that settling it would give `χ_poly = 7`.
**That question is what Sokolov–Voronov answer**, and it is their theorem, not his, that subsumes our floor.
Also from Manta, and new to us: **for triangle colourings the value is 7 or 8, undecided.**

This is G21 applied to a citation rather than to a search: a gloss measures the glosser's purpose, not the paper.

## §R7 — the negatives, recorded so they are not re-scanned

* **[Soifer2024] contains NO finite-field or number-field chromatic theory.** Zero occurrences of Moorhouse,
  Vinh, Paley, `p`-adic, "finite field" or "number field" in 838 pages. (The six "Kloosterman" hits are the
  Leiden analyst in the Van der Waerden biography; the three "valuation" hits are "evaluation".) Its ch. 11
  hands the algebraic direction off to a 2006 survey we could not obtain.
* **Zero citations of Moorhouse, Vinh, Medrano–Myers–Stark–Terras or Krebs across all eleven** Tier-3 papers.
  This is evidence *for* G49's two-literatures explanation, not an excuse for it.
* **Zapletal (2103.02757, 2201.00275)** — choiceless set theory on the *rational-distance* graph; no field
  result, no residue colouring, cites none of the named authors. 2201 supersedes 2103. No bearing.
* **Noble (2106.05333, 2108.07713)** — graph dimension and `ℚⁿ` embeddings; no fields. One useful datum: as of
  2023 *"it is unknown as to whether there even exists `G` satisfying `dim(G) = 2` and `χ(G) ∈ {6,7}`"*.
* **Johnson (1989/90), Chow (1993), Chilakamarri (1988), Zaks (1992)** — read in full; **none leaves `ℚ`**, and
  **none uses a residue map**: the universal mechanism is odd cycles in a Cayley graph, an existence proof with
  no colour formula. **The step from "a 2-colouring exists" to "colour by the residue of a homomorphism" is
  [Fischer1990]'s.** Chow's *two-index* is `v₂(d²)` and his Theorem 1 is a complete classification of forbidden
  distance sets for `ℚ³` and every `Aₙ`. Chilakamarri's Lemma 1 (*"b is either odd or twice an odd integer"*) is
  the rational shadow of our unit-vector integrality lemma, used only to disconnect `U₄`.
* **`volume-33-paper-23.pdf` identified**: Zaks, *On the Chromatic Number of Some Rational Spaces*, Ars
  Combinatoria 33 (1992) 253–256 — the bibliography's "to confirm it is this paper" is discharged. (Scanned
  image, no text layer; read from 300 dpi renders.)
* **Not obtained, named, and ranked**: `[Krebs2022]` (closed access, no preprint — the `χ > ω` criterion is the
  wanted page), `[Johnson2006]` (the compendium of the whole algebraic direction — the most likely place for
  further number-field prior art), `[Fischer1990b]` (the multiquadratic component paper), `[BendaPerles2000]`,
  `[MMST1996]` (still second-hand), `[Coulson2004]`, `[Townsend2005]`. The Geombinatorics and Congressus
  Numerantium items are print-only and need a library, not a fetch. **`[Johnson1987]`'s main theorem was
  recovered from its zbMATH review** and is in the bibliography.

## §R8 — the predictions, scored

| | registered | outcome |
|---|---|---|
| **P1** | at least one further correction lands from Tier 1 | **MET, and under-called: five corrections, from Tiers 1, 2 and 3.** |
| **P2** | `[Soifer2024]`'s number-field chapter does not contain Theorem B's value, so it stands | **MET** — and better than registered: its ch. 11 carries the *open problem* Theorem B answers |
| **P3** | `[Krebs2022]` does not fix `χ(𝔽₁₇²)` or `χ(𝔽₂₃²)`; FS-17's budget stays justified | **MET** — no citing paper reports any chromatic value from him; his abstract claims bounds and a `χ > ω` criterion, not exact values. But his **clique** numbers do land in closed form (§R3) |
| **P4** | `[CervantesKrebs2023]`'s matrix method subsumes M61's periodic quotient and is a stronger instrument | **SPLIT: met on the mechanism, REFUTED on the instrument.** Row operations on a Heuberger matrix are quotient homs to smaller Cayley graphs — the same genre — but our `addCayleyMap` is the more general *statement*, and they solve only dimension ≤ 3 with rank ≤ 2 while `UD(𝔽_p,2)` has rank `(p+1)/2`. *"The cases `r = 2, m ≥ 4` as well as `r ≥ 3` are left for future investigation."* **The matrix method cannot compute `χ` of any finite Euclidean plane.** |
| **P5** | `[Voronov2023]` proves what M43 says; the conditional becomes unconditional | **MET** (§R2) |
| **P6** | at least one paper states an open problem this project has answered | **MET twice** (§R4), plus four more open problems recorded that we have *not* answered (§R9) |

Four met, one met-and-under-called, one split. **The registered measure of success — "whether the frontier
ranking changes" — is met**: FS-18 closes, the cell-family rows lose their novelty, and two new stubs enter.

## §R9 — other people's open problems, recorded (none of these are ours yet)

* **[CervantesKrebs2023]**, verbatim: *"Does there exist an algebraic number `ω ∈ ℂ` such that the Cayley graph
  of `ℂ` generated by the non-negative powers of `ω` is not 3-colorable?"* Their Example 2.14 shows `χ ≥ 4`
  forces `|p(1)| = |p(−1)| = 1` for `p = min_ℤ ω` — a criterion on a rotation's **minimal polynomial**, which is
  this project's own vocabulary (the Moser twist has `3x² − 5x + 3`, `ρ₁₅` has `4x² − 7x + 4`).
* **[CranstonRabern2015]**: the fractional half of their question — `χ_f(K²)`, now bracketed `76/21 ≤ · ≤ 4` —
  and *"The natural extension of our construction is to attach spindles at all rotations that are integer
  multiples of `arccos(5/6)` … Does this graph have larger fractional chromatic number? We do not know."*
  **That graph is ours** (`Copy.lean`, T13).
* **[Soifer2024] ch. 61**: Conjecture 61.1 (a 7-chromatic two-distance graph exists), Problem 61.2 (an
  8-chromatic one, or a proof there is none), Problem 61.3 (maximise `χ(G{1,d})` over `d`) — the μ-dial's
  neighbourhood (M49/M50).
* **[Manta2021]** §6: is the chromatic number of triangle colourings 7 or 8?
* **[Chow1993]**: his Theorem 1 completely classifies the distance sets forbidden by 2-colourings of `ℚ³` and
  every `Aₙ`, by the two-index `v₂(d²)`. **The number-field analogue — classify the distance sets forbidden by
  the `N(𝔭)`-residue colouring, by `v_𝔭(d²)` — appears unasked, and Theorem A already has the machinery.**
  Minted as **FS-19**.

## §R10 — deliverables

1. `BIBLIOGRAPHY.md` — fifteen new §A entries; every held work's read column now true; §B emptied into §A and
   into explicit negatives; §C's promoted rows struck through with what they turned out to be; §D rules 0b
   (the shelf is read), **0c (a §C row is a liability, not an archive)** and 0d (what is still not held, ranked).
2. `CLAUDE.md` § Frontier — a new FS-18 narrative section; corrections marked in place on ledger rows **17, 34,
   35, 36, 40, 50, 52, 53**; row 57 and the Moorhouse narrative extended with the two further open questions.
3. `CLAUDE.md` § Grokkings — **G22, G24, G29, G41, G44 amended** (originals kept, never deleted); **G49
   confirmed with its falsifier not firing**; **G50 minted** — *the prior-art gate has a second half, and it is
   the cheaper one: read what the search already found.*
4. `plans/FRONTIER-STUBS.md` re-ranked; **FS-19 minted**.
5. This §R.
6. A line in `data/m53/jobs-ledger.txt`.
