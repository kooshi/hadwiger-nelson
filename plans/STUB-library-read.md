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
