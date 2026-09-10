# Questions the literature posed, and this project answered

*Created 2026-09-09 on Kooshi's instruction. **A running ledger, amended whenever another one
closes** — the same maintenance rule as `BIBLIOGRAPHY.md` and `CLAUDE.md` § Frontier.*

**Why this file exists.** This project's publication policy defers write-ups by default
(`CLAUDE.md`, standing since 2026-08-04). The bar was amended on 2026-09-08 to a specific shape:
*a result that answers a question the literature has independently and repeatedly posed clears it,
whatever its size.* That amendment turns "which questions have we actually answered?" into the
governing question for what gets written, and the answer was scattered across a ledger, a
bibliography and ninety plan files. It is here now.

**What goes in.** A row belongs here when (a) somebody outside this project **posed the question in
writing**, and (b) we have an answer. Not "we proved something nobody happened to have proved" —
that is the whole ledger. **Posed, in print or in a public archive, by someone else.**

**What every row must carry, and why.** The question **verbatim**, its author and date, our answer,
where the proof lives, whether the kernel checked it, **and what prior art constrains the claim**.
That last column is not modesty; it is the thing this project has been wrong about most often
(`CLAUDE.md` § Grokkings G49, G50 — six independent derivations of one reduction across five
decades, and four of our own milestones reconstructing a 2010 draft that was one search away).
A row with an empty prior-art column has not been checked, and says so.

---

## §1 — Closed

### 1.1 The chromatic number of the plane over `ℚ(√3, √11)`

**`χ(K²) = 4` for `K = ℚ(√3, √11)`.** Kernel-checked (`Proofs/HadwigerNelson/FieldWall4.lean`,
`chromaticNumber_seamPlane`, zero `sorry`, axioms exactly `[propext, Classical.choice, Quot.sound]`).
Ledger row 57.

**This one question was posed independently at least seven times across fifty years by people who do
not cite one another**, which is why it is first and why it is the reason the publication bar moved.

| # | who, when | verbatim |
|---|---|---|
| 1 | **Benda & Perles**, circulated **1976**, published 2000; recorded in `[Soifer2024]` ch. 11 as **Open Problem 11.6** | *"Find the chromatic number of `ℚ²(√2)` and, in general, of any algebraic extension of `ℚ²`."* |
| 2 | **`[Moorhouse2010]`** §1 (unpublished draft, 3 March 2010) | *"We have not determined the exact value of `χ(K²)` in this case."* — having named `ℚ(√3,√11)` as the smallest number field whose plane holds a Moser spindle, and proved `χ ≥ 4` |
| 3 | **`[Madore2015]`** Prop. 4.6 (arXiv:1509.07023) | proves `4 ≤ χ(ℚ(√3,√11)²) ≤ 5` and leaves it there — **the bracket stood eleven years** |
| 4 | **`[CranstonRabern2015]`** (Combinatorica) | *"What is the fractional chromatic number of `ℚ(√3,√11) × ℚ(√3,√11)`? What about its chromatic number?"* |
| 5 | **`[ExooIsmailescu2019]`** (Discrete Comput. Geom. 64) | asks it three lines above its Madore citation |
| 6 | **`[Polymath16threads]`**, thread 4, **2 May 2018** | *"Madore proved that `ℚ[√3,√11] × ℚ[√3,√11]` can be 5-colored. As Dustin asked in one of his posts, it would be nice to decide if the chromatic number of this subfield is 5"* |
| 7 | **`[Aggarwal2025]`** (MIT PRIMES) | names *"computing … `χ(K^d)` for certain fields `K`, particularly when `K = Q(√3,√11)`"* as the open case |

**Our answer.** Four, exactly. The upper half is an explicit residue colouring modulo a
conjugation-fixed prime above 2; the lower half is the Moser spindle exhibited as an identity in the
order, with no `Real.sqrt` anywhere.

**Also closed by it:** `[CranstonRabern2015]`'s *second* question outright, and their first is
bracketed `76/21 ≤ χ_f(K²) ≤ 4`.

**Prior art that constrains the claim.** `[Madore2015]`'s `4 ≤ χ ≤ 5` is the closest anyone came.
The residue mechanism is not new — Fischer 1990, Moorhouse 2010, Manturov 2012 and Madore 2015 each
derived a version — and the Polymath16 wiki sketched the recipe in 2018. **What is new is the exact
value and the kernel proof.**

**Searched for a contradicting claim** on 2026-09-08 and again 2026-09-09 (all four Madore citations
opened; the 47 citations of the paper that posed it walked; two citation databases cross-checked).
None found.

**Status: written up as `plans/STUB-theorem-B-writeup.md` (FS-20). Not published.**

---

### 1.2 The general form of the residue colouring

**Theorem A** — a graph *drawn* in an abelian group, edge differences in a subgroup and non-zero
under a homomorphism out of it, is `|G|`-colourable. No metric, no field, no ring, no valuation, no
Cayley structure, and the homomorphism may be **partial**. Kernel-checked
(`Proofs/HadwigerNelson/ResidueColouring.lean`, `colorable_of_residue`).

> **`[Madore2015]`**, Prop. 3.9, on needing a subgroup that is not a ring and doing the coset
> construction by hand: *"which the author has not found the courage to try to formulate under the
> most general auspices."*

**Our answer.** That formulation, and the kernel checked it.

**Prior art that constrains the claim.** His Prop. 3.2 *is* the valuation-subring form, so
`colorable_unitDistance_induce_of_valuationSubring` is his theorem, not ours. The general
form — the step he declined — is ours. The delimitation is written into ledger row 57 and must
survive into any manuscript.

**Status: not written up.**

---

### 1.3 Which distances can carry a four-colour compulsion over `K`

**The 2-adic law** (ledger row 59, kernel-checked, `ValuationLaw.lean` and `ResidueColouring.lean` §4):
over `K`, a pair forced monochromatic at four colours lies at a distance **inside** the prime above 2,
and a pair forced distinct lies at a distance **outside** it.

> **`[Heule2021]`** (*Odd-distance virtual edges in unit-distance graphs*, Geombinatorics 31(2))
> states a reciprocal duality — if an odd `d` is a virtual edge then so is `1/d` — and
> **`[Parts2020a]`** records a finite counterexample and writes that *"a more accurate formulation
> of the statement and its proof are of certain interest."*

**Our answer.** The valuation formulation is that statement on the necessary side: `v_𝔭(1/d) =
−v_𝔭(d)`, so the condition is **invariant under `d ↦ 1/d`** — which is why the duality could only
ever have been stated for odd distances, and why Parts's finite counterexample does not touch it
(the condition is necessary, not sufficient).

**It also explains two published tables that their authors present as unexplained observations:**
all seven rows of `[Parts2020a]`'s Table 1, and `[Heule2019]`'s §5 *"Observed patterns of points in
`Q[√3,√11] × Q[√3,√11]`"*.

**Prior art that constrains the claim, and it is substantial.** `[Ducz2026]` (10 June 2026 —
**three months before we proved it**) gives the identification half in coordinates: two points of
the Moser lattice share a colour iff `N + M ≡ 0 (mod 4)` where `‖z‖² = (N + M√33)/6`. Checked here:
his congruence reproduces **ten for ten** of the data our law explains. **What survives is
delimited**: the field-level statement over `K²` (rank 8, not his rank-4 ring), the valuation
formulation, the **compulsion** consumers (the step from "this colouring identifies these pairs" to
"no proper four-colouring of any `K`-object can force the others"), and the kernel proof. The `8/3`
instance is older still — Polymath16 blog, **9 May 2018**, due to Jannis Harder.

**Status: not written up. The delimitation above is the hard part of writing it.**

---

### 1.4 Does `5/3` receive the same colour as `0` in every five-colouring?

> **`[Polymath16threads]`**, verbatim: *"Does `5/3` receive the same color as `0` in every
> 5-coloring of `R`? These two points are always monochromatic for homomorphic colorings, and if
> this behavior persists for general colorings, then a spindling argument implies `χ ≥ 6`."*

**Our answer: no, and the reason is a congruence.** M60's distance law (ledger row 55,
kernel-checked at `p = 11`): over a field where 11 is usable — which includes `K` and every field
the descent ever used — a pair forced equal at five colours needs `11 ∣ d²`, and `(5/3)² ≡ 4 ≢ 0
(mod 11)`. So the behaviour cannot persist and their spindling argument cannot fire there.

**Why it matters beyond the negative:** they had the right *shape* — the design target this project
now calls FS-6 — and no way to filter the distance. The residue law is that filter, and it says
where to look instead.

**Status: not written up.**

---

### 1.5 `χ(𝔽₁₃²)`

> **`[Moorhouse2010]`** Table 6.1 leaves `χ(𝔽₁₃²) ∈ {5, 6}`.

**Our answer: 5.** Measured at the 2026-09-06 pivot (`tools/fplane.py`, `data/fplane/`), *without
knowing it was open* — the paper was found two days later. **Verified colouring plus a solver
refusal; not kernel-checked.** Promoting it is a day's work on the M58 template, which already
carries `χ(UD(𝔽₁₁,2)) = 5` with no solver at all.

**Status: not written up, and not kernel-checked. The weakest row in this file.**

---

## §2 — Answered in one direction, or with a caveat that must travel

### 2.1 Type-M constructions with other rotations *(new, 2026-09-09, M62)*

> **`[Parts2020a]`** §4, verbatim: *"Working constructions of type M with other rotations are not
> known yet."* Every 5-chromatic graph of the record's family ever built uses one rotation.

**What we have: a candidate list where the literature has none.** The rotation admitting a cross
edge between two radii is forced to adjoin `√D` with `D` computable in `K`, so the enumeration is
exact and finite. On one 873-point Moser-lattice base: **1,336 rotation classes escape `K`, of
which 412 admit the ≥ 2 cross-edge kinds Parts calls essential** — and the record's own rotation is
among them, carrying both of its known kinds, ranked 58th. Forty-six seconds
(`tools/typem.py`, `data/m62/rotations-moser-r2.05.json`).

**The caveat that must travel: admissibility is necessary, not sufficient.** No claim is made that
any of the 411 others yields a 5-chromatic object; that is the search, and it has not been run. The
count is also a property of *that base's* radius spectrum and does not transfer.

**Also, and independently:** the record's rotation admits **seven** radius families and Parts uses
**two** — his subtype classification counts how much of the *second* kind is used and never
considers a third.

**Status: phase A of M62. Not written up.**

### 2.2 The clique-versus-chromatic gap on finite Euclidean planes

`[Krebs2022]` states a criterion for `χ > ω` that **no citing paper reproduces** and that we have
not obtained. Our G24/G40/G44 material is about exactly this. **Not closed — listed here so it is
not mistaken for closed**, and because obtaining that page is the single most wanted item in the
literature for this project.

---

## §3 — Adjacent, open, and cheap for us

*Questions posed by others that we have NOT answered but are unusually well placed to.*

- **`χ(𝔽₁₇²) ∈ {5,6,7}`** — `[Moorhouse2010]` Table 6.1, still open, **never touched here**. 289
  vertices against the 23-plane's 529. A `6` there would answer the range question of M61's "first
  digit". *(17 ≡ 1 mod 4, so it is never a usable prime — this bears on the range, not on the sieve.)*
- **`χ_f(K²) = 4` exactly** — `[CranstonRabern2015]`'s first question. Our bracket is `76/21 ≤ χ_f ≤ 4`.
  `[MatolcsiEtAl2025]`'s amenability argument uses the full Euclidean group; the subgroup preserving
  `K²` is metabelian, hence amenable, and dense in it. **If their Følner step survives the
  restriction, the question closes.** Not attempted.
- **`d(6) = 1`** — `[deGreyParts2022]` §4 asks whether a more general polygonal tiling could reach it;
  `[SokolovVoronov2025]` answers no. Already closed *by them*, recorded so we do not re-close it.

---

## §4 — The deferral, stated so this file cannot be mistaken for a publication plan

Everything above is **deferred**. The standing policy (`CLAUDE.md`) defers all write-ups and
upstreaming; the amended trigger fires on exactly two things — **χ(ℝ²) ≥ 6 or its refutation**, and
**a result answering a question the literature has independently and repeatedly posed**. §1.1 is the
one row that has fired it, and its manuscript is stubbed at `plans/STUB-theorem-B-writeup.md`.

**A row entering §1 is not authorisation to write it up.** It is Kooshi's call, every time.

**Maintenance:** amend at every milestone close that closes or partially closes a posed question,
and whenever a prior-art pass finds that a row's question was posed somewhere new — the count in
§1.1 went from one to seven that way, and that count is the row's whole argument.
