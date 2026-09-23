# FS-73 — the rigidity dichotomy: when does a lattice force a pair? (subplan)

**Closed 2026-09-23** (rows 78–79 in `LEDGER.md`; theorems `plans/FS73-derivation.md`; G71). **Read §R-close at the end first:** the §G re-read, the §PA sweep, the predictions scored once, the retraction tally, the honesty record and the errata E1–E13 to this plan. The body below is the plan as accepted and run; statements it superseded are marked "[superseded: E#]", not rewritten.

*Planner: de Bruijn (Opus 5.5), 2026-09-23, from `plans/STUB-rigidity-dichotomy.md`, under WORKFLOW 2.0 steps 3–5. Product
owner: the coordinating session (review by artifact). Advisor for this stage: Poros (agent `a20773e5a80987272`, its own
record `plans/POROS-2026-09-23-fs73-plan.md`). This file has one writer (the planner of the stage in hand). The modeling
passes (step 6) are recorded in §M, by a fresh de Bruijn (Opus 5.5), after the product owner's amendments below.*

*The plan was **accepted by the product owner on 2026-09-23**, at `9d1fe367`, `974ec8fa` and `73114a7f`. Poros's final
record is `ed7be12b`.*
- *The planner's four settled decisions stood:*
  1. *census and classification before the competition;*
  2. *the existence hypothesis in the challenge;*
  3. *question 3 re-aimed at the voltage set;*
  4. *the kernel phase in parallel with phase 1.*
- *The PO's two rulings stood.*
  - *R1: two advisor items (H-1, H-2) are held by the PO for the competition's advisor, and are deliberately not in this
    plan.*
  - *R2: question (1)'s target stays "a theorem or a counterexample", with the "not landed" headline and fallbacks (a)–(d).*
- *One spec defect was routed to the modeling stage: P1d's "the finite group `P_found / F_known`", which is infinite when
  `F_known` has rank 2. It was fixed under amendment A1, below.*

*The PO's review amendments (2026-09-23), applied before the modeling passes:*
- *A1: P1d's instance list became a finite generating set, and P-C4's informative outcome was extended.*
- *A2: the period-search extension got its own row, P1d′.*
- *A3: the subgroup form is the plan's normal form (§0 "The normal form", §C, P1d–P1f, P2's verdict column).*
- *A4: the discretionary items. The decision on each is recorded in §G.1 at G60 and G66.*

*One refinement of A1 is the modeling stage's own. With the Kempe re-periodisations included, `P_found` lies inside every
voltage group. So it contains `lcm(N)·Λ` only when every voltage group has full rank. That holds at K and fails on L3
(§0).*

*How to read it:*
- *§0 is the milestone after the reframe, in one page, with the subgroup normal form.*
- *§G is the re-grokking: every grokking, every ledger row, every § B line and every method rule, one verdict each.*
- *§PA is the prior-art gate.*
- *§S is the subplan: routes, phases, sequencing, and each stage-1 phase's "what to read first".*
- *§C is the text for the competition's briefs.*
- *§K is the Lean skeleton.*
- *§P is the registered predictions.*
- *§M records the modeling passes.*
- *§X records the exchange with Poros and its retractions.*
- *§R holds the phase records, and fills as phases report.*

---

## §0. The milestone after the reframe

**The object.** Let `Λ ⊂ ℂ` be a finitely generated additive group of rank `r` (a *lattice* in this project's sense: the
ℤ-span of finitely many unit vectors of a real field's plane), `U = Λ ∩ S¹` its complete unit-vector set (finite,
`−U = U`), and `X = X(Λ, k)` the set of proper `k`-colourings of the Cayley graph `Cay(Λ, U)`. In the discipline that owns
it, `X` is a **ℤ^r subshift of finite type**: a *colouring shift* (Hom(Cay(ℤ^r, U), K_k)). It would be a *hom-shift* if `U`
were the standard generators. Its **periodic points** are the colourings invariant under a finite-index subgroup `W`. For
`W = NΛ` they are FS-70's quotient colourings (`Cay(Λ/NΛ, U mod N)`). A pair is **forced at `δ`** when every point of `X` has
`c(0) = c(δ)`.

**Three reductions (none is a proof of the inheritance question; each changes its statement).**

* **R1: compactness.** *Some finite ball forces `(0, δ)` ⟺ every colouring in `X` identifies `0` and `δ`.* This is König's
  lemma / Tychonoff, or Mathlib's `SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom` applied to `Cay(Λ, U) + edge(0, δ)`.
  **In-house prior art: FS58-T4** (three colours, FS-58). Kernel leaf `forces_iff_exists_finite` (§K). The finite ball costs
  nothing, and compactness gives no radius bound. What is left of C3 is a statement about `X`.
* **R2: the vacuous case.** If `X ≠ ∅` but `X` has no periodic point, "rigid under every periodic colouring" holds
  vacuously for every `δ`, including `δ ∈ U`, where the conclusion would contradict `X ≠ ∅`. So the stub's C3, read "for
  every δ", *contains* the claim that **every `k`-colourable lattice graph has a periodic `k`-colouring**. That claim is a
  separate open question, **C3-aper**. It is `[AbrishamiEtAl2025]` Problem 4.6 restricted to 1-ended abelian Cayley
  graphs. It is proved there only for 2-ended groups, and ℤ² is not "strongly periodic" (Berger; `[CarrollPenland2015]`).
  FS-72's rank-8 lattice (no periodic colouring found at `N ≤ 4`) sits exactly in this case. G30's failure mode 5,
  inside the milestone's own statement (Poros, §X).
* **R3: H1 ⟺ H2** (Poros, §X, checked by the planner). Write **H1**: every periodic colouring has `c(0) = c(δ)`. Write
  **H2**: G69's "rigid", meaning that under every periodic colouring the `(c(0), b)`-Kempe component of `0` holds `δ` for
  every `b`. H2 ⟹ H1 trivially. **H1 ⟹ H2:** if some periodic `C` (period `NΛ`) has an escape, its Kempe components are
  permuted by `NΛ`; `NΛ/V` is finitely generated abelian, hence residually finite; so some finite-index `W′ ⊇ V` misses
  `δ − p(δ̄)`, and swapping on `K₀ + W′` gives a **periodic** separating colouring. So one period-`N` colouring run
  through T10 tests H1 at every period `W′ ⊇ V` at once. **What decides an escape is `δ − p(δ̄) ∈ V`, not the index
  `[NΛ : V]`** (T10.2's wording is corrected in §S phase 4). The only approximation the instruments make is **"-found"**:
  H1 has only ever been measured over the colourings a solver returned, at `N ≤ 12`. Kernel leaf
  `notMem_periodicForcedSubgroup_of_voltageEscape` (§K).

**The normal form: two subgroups of Λ.** This comes from the PO's amendments A1–A3 and Poros (§X 14, 20), and was settled
by the domain pass (§M.1).

*The groups.*
- For a colouring `c ∈ X`, let `Per(c)` be its group of periods.
- Let `KPer(c)` be its **Kempe period group**: the translations that fix every `(a, b)`-Kempe component of `c`, for every pair
  of colours `a ≠ b`. The pair must be distinct. With `a = b`, every set of `a`-coloured vertices is Kempe-closed, and
  `KPer` would collapse to `{0}`; the domain pass found this adversarial member.
- Since `k ≥ 3`, `KPer(c) ⊆ Per(c)`: a translate of `x` lying in `x`'s `(c(x), b)`-component for two different `b` has
  `x`'s colour.

*The two sides of C3.* Both are subgroups, by translation invariance.
- The **forced group** is `F = {δ : (0, δ) forced} = ⋂_{c ∈ X} Per(c) = ⋂_{c ∈ X} KPer(c)`.
  The second equality holds because a swap on any one component is again a colouring.
- The **H1 group** is `P = {δ : every periodic colouring identifies 0 and δ} = ⋂_{c periodic} Per(c) = ⋂_{c periodic} KPer(c)`.
  The second equality is R3: a swap on `K + W′` is periodic.
- `F ⊆ P`, and **C3-inherit holds at Λ for every δ exactly when `P = F`.** With no periodic colouring, `P = ⊤`: that is R2's
  vacuous case, which is why the question carries the existence hypothesis. In the kernel this is `InheritanceQuestion`
  and `inheritanceQuestion_iff` (§K).
- Speak in vectors (cosets), never distances. √3 ∉ E = ℚ(√−3,√−11), so "8/√3" on de Grey's lattice is the vector
  `(8/3)(1+ζ₆) ∈ (8/3)ℤ[ζ₆]`.

*What the census works with.* The census computes a sandwich of four subgroups:
```
F_known  ⊆  F  ⊆  P  ⊆  P_found
```
- `F_known` is the span of the orbits of certified forced vectors under the graph automorphisms fixing 0 (ζ₆, conjugation,
  the Galois flip; G27, M62-T4).
- `P_found = ⋂_{N searched} P_N ∩ ⋂_{c found} KPer(c)`.
- `P_N` is the H1 group at period `N`. It is computed exactly by a counterexample-guided loop over generators (P1d).
- `KPer(c)` is read off every Kempe component of `c`, at every colour pair, not only the origin's (T10's voltage groups).

*Consequences, each two lines.*
1. **`F_known = P_found` proves C3 at Λ.** It is a theorem whose certificates are the forcing refusals and the exhibited
   periodic colourings.
2. **C3 at Λ needs `rank F = rank P`.** When `rank P_found = rank F_known`, the quotient `P_found / F_known` is finite, and
   the census asks once per nontrivial coset.
3. **If `P` has finite index, C3 at Λ holds exactly when `F` has finite index.**
   - If `F` has finite index, every colouring is `F`-periodic, hence periodic, so `P = F`.
   - Conversely, `P = F` makes `F` of finite index.
   - So under a finite-index `P`, an `F` of lower rank is a counterexample at Λ.
4. **`P_found ⊇ lcm(N)·Λ` only when every voltage group `V` of every found colouring has full rank**, because
   `KPer(c) ⊆ V`.
   - At K this holds. `V` has rank 4 and index 1–4 in `NΛ` at every `N ≤ 12` and every `b`
     (`data/fs70/quotient/degrey-K-periodic-kempe.json`).
   - So at K, `P_found` has finite index, and with `F_known = (8/3)ℤ[ζ₆]` of rank 2 (P-C4), `P_found / F_known ≅ ℤ² × finite`.
   - On L3 it fails: the `b = 3` component has `V` of deficient rank (`data/fs70/records/phase-1e.md` §7, P2).
5. **K itself may be the instance under test.** [superseded: E2 — `F = P = 8Λ`] Suppose `P_found` stabilises at finite index as periods are added, while `F`
   stays rank 2. Then K is a *counterexample candidate* (P1d′, P-C4, P-C5). It stays a candidate, because a finite search
   never proves that `P` has finite index.
6. **The census can confirm C3 at a lattice (consequence 1), but it never refutes C3.** A refutation needs `δ ∈ P`
   *proved*, over every period, together with a separating colouring given by a rule.

*Credit for consequence 4.* The rank condition is the modeling stage's correction of A1's premise (de Bruijn, 2026-09-23;
the PO checked and accepted it). A1 had assumed every voltage group has full rank.

**The gap between F and P, split by invariant measures (A4; the PO's ruling of 2026-09-23 puts it in §0, §G and §C).**
Λ ≅ ℤ^r is amenable, so the colouring shift `X` carries Λ-invariant probability measures.

*The third subgroup.* Let **`F_μ`** be the set of `δ` with `μ{c : c(0) ≠ c(δ)} = 0` for every invariant probability
measure `μ` on `X`.
- `F_μ` is a subgroup. The separation events obey a triangle inequality, and shift-invariance does the rest.
- `F ⊆ F_μ`: a forced pair has an empty separation event.
- `F_μ ⊆ P`: a periodic separator's finite orbit carries an invariant uniform measure, with positive mass on the separation
  event.

*So C3-inherit splits into two halves.*
- **The walls half, `F = F_μ`.** It fails exactly when some colouring separates `(0, δ)` only on a set of zero upper Banach
  density. When the density is positive, a Følner limit gives a separating `μ` (the Furstenberg correspondence principle).
  MASCOT-T10's phase walls and the tri-sectors are the corpus's candidates.
- **The recurrent half, `F_μ = P`.** It holds whenever the periodic-orbit measures are weak-* dense among the invariant
  measures on `X`, because the separation event is a clopen cylinder. That is a density-of-periodic-measures question, in
  ergodic theory's words.
- G66's analytic chain sits here as well. The *continuous* colourings of the odometer (Λ acting on its profinite
  completion Λ̂) are exactly the periodic colourings. Its *measurable* colourings push Haar measure to invariant measures on
  `X`. So `F ⊆ F_μ ⊆ F_meas ⊆ F_clopen = P`: C3-inherit is the compulsion analogue of `χ_clopen = χ`, and the Borel and
  measurable colourings sit between the two (descriptive combinatorics; Gao–Jackson–Krohne–Seward's Memoir, §PA.2).

*No instrument for `F_μ` runs at K.* A window LP on pattern frequencies certifies `δ ∈ F_μ` only when the window
contains a forcing set, because the LP converges from above. At 8/3 that is 745 points, and no pattern LP of that size is
priced. The split is a statement of the question, offered to both competitors as fallback (a)'s kind of product. It is not
a phase.

**The three questions, re-posed.**

1. **C3-inherit (the competition's question).** *If some periodic proper `k`-colouring of `Cay(Λ, U)` exists and every
   periodic one identifies `0` and `δ` (H1), is `(0, δ)` forced?* Equivalently: must a non-periodic colouring that separates
   the pair be matched by a periodic one? A sufficient condition is **density of periodic points** in `X`, or only
   "every 2-site pattern of `X` occurs in a periodic point". The gap between H1 and forcing lives in two places: recurrent
   non-periodic colourings, and non-recurrent ones (domain walls between periodic phases, of which MASCOT-T10's phase
   walls and `[Polymath16wikiR2]`'s tri-sectors are the corpus's instances). **Its one known positive instance is
   uninformative**: over K at `δ = 8/3` (Harder), H1 is known only because the conclusion holds (Poros). The informative
   instances are those where H1 holds by another route with forcing open, or where forcing fails. Phases 1–2 manufacture
   them before the competition runs.
   **C3-aper** (existence of periodic colourings) is split off and named. The competitors may take it up; nothing depends
   on it here. **C3-local** (FS-70's C3 read as an iff: local conditions at the odd primes and at 2 ⟹ H1) is a question
   about the periodic colourings of a graph that sits *inside* the product of local targets as a diagonal subgraph. `U` is
   finite, so it is not the product. FS-67 (colourings of products pulled back from one factor) is context, not a route,
   and FS58-T3's tensor identification needed an infinite `U` (Poros's correction, §X). It is phase 2's backdrop, not the
   competition's question.
2. **The classification (phase 2).** Per field, per quartic CM subfield `E` of `F(i)`: arithmetic columns (2-unit or
   wall-broken, 3-adic pole), then **computed** columns. The lattice's own spectral sign `m(Λ) = min_θ Σ_u cos 2πθ·u` against
   `−d/(k−1)` (G54 for the lattice itself). The period-`N` quotients' colourability, gaps and Kempe verdicts at every
   chainable target. **A composite-period column**: a quotient at `N = p` is a *subgraph* of the residue target, so the
   target's Weil/Hoffman refusal proves nothing about the quotient (§X, retraction 2). The prime-by-prime table cannot see
   composite periods.
3. **The rank-6 mechanism (phase 4), re-aimed.** Not "what decides the index `[NΛ : V]`" but **what determines `NΛ/V` and
   the targets' images in it**. The first measurement is Poros's card: `[2Λ : V] = 81 = 3⁴` on L3 means its escape colouring
   is `162Λ`-periodic. Is it local at 2, local at 3, or neither (P-R1, §P)?

**The planner's measurement that shaped the phases (phase 0, §R0).** De Grey's K-lattice (rank 4, 54 unit vectors) is
**spectrally slack** at four colours as a lattice graph: min over `T⁴` is `−22.41`, against `−18` for tightness. Its
period-2, 4 and 6 quotients are exactly tight (`−18`). Its period-5 and period-11 refusals are **not spectral** (Hoffman
floors 3.99 and 3.50), so T9's prime-by-prime SAT reading stands. Poros's reading P-S1 (tight, with minimisers at
2-power torsion) **lost**. So the spectral route to H1 ("tight ⟹ every periodic colouring is `H_min`-periodic") is
unavailable on the one known positive instance, except at periods ≤ 4. Whatever forces Harder's pair is not the lattice's
Hoffman sign.

**What the milestone produces.**
- For (1): a theorem, a counterexample, or, under the product owner's ruling of 2026-09-23, **"not landed"** with the
  named fallbacks listed under it (§S phase 3).
- For (2): the table.
- For (3): the composite-period finding and a mechanism statement, or its null.
- The kernel forms of T2, T6, T10's escape direction, R1 and R3 (§K).
- The census (phase 1): one subgroup sandwich per lattice, P1d′'s stabilisation series at K, and the informative
  instances read off them.

**Bearing on χ ≥ 6: none directly.** High on the programme: it is the statement of where a forcer can live in a field,
which every six-forcer question over a window field will need in the same words (k = 5, a pilot row in phase 2).

---

## §G. The re-grokking (WORKFLOW 3.1)

*Walked with `CLAUDE.md` (disk copy, confirmed equal to the loaded copy but for the staffing hunk of `776b05dd`) and
`LEDGER.md` open, 2026-09-23. Verdicts: **B** = bears (what it says about FS-73, and the phase it changes: `→ P1a` etc.,
phases in §S). **S** = silent (why). **F** = falsifiable here (registered in §P). Every B is extracted into §S's phase
table as an instruction; §G.5 is the index of those extractions.*

### §G.1 Grokkings G1–G70

- **G1** B — a wall-standing lattice is four-coloured by the residue at 2, so rigidity at four colours needs a
  wall-breaking root or a 3-adic pole. Column (b) of the table → P2.
- **G2** S — rotation-centre anatomy of witnesses; no lattice colouring space.
- **G3** S — radii vs angles of certified witnesses.
- **G4** S — shell inventory of five-forcers.
- **G5** S — 1-sum structure of de Grey's 1581 (the lattice question is about the infinite Cayley graph, not that object).
- **G6** S — hexagram containment.
- **G7** B — the type-M family is the rotation that turns a rank-4 base into a rank-6 or rank-8 bilayer. L2/L3 are such
  extensions → P4 (name each rank-6 lattice by its rotation's `n`).
- **G8** B — de Grey's lattice is generated by the direction group's words. The census uses exactly
  `⟨ζ₆^m ρ^n, |n| ≤ 2⟩` (the owner's control) → P1a.
- **G9** B — the 791-point forcer forces 4 and 4/√3 (antipodal) at four colours. On de Grey's lattice under T10 the vector 4
  escapes under five of six colourings (and "4/√3" is a distance realised by a vector, not a real point: √3 ∉ E): **the 791-core's forced pairs are not lattice-forced**, which
  is consistent (Forces is monotone upward, G31). They are census rows with a known answer → P1d.
- **G10** S (weak) — forcing distributed, no organ. It predicts nothing about the lattice question beyond G17's carriers.
- **G11** S — Moser-free five-forcers by landing a forced pair; no bearing on the inheritance mechanism.
- **G12** B — the quadrature law: a detuned copy couples along one thin conic. The cross-edge set of a rank-6 bilayer
  lattice is the conic's → P4 (C2's reading).
- **G13** B — a fan gap is exactly the failure of coverage, and one gap frees every pair above it. The degenerate case of
  T10 (`Q₀ = {0̄}`) → P1b (gap-aimed finder first, before any Kempe run).
- **G14** B — a matching carries no colour pressure. A rank-6 extension joined to the rank-4 base by a matching-shaped
  cross set predicts looseness → P4.
- **G15** B (moved from S at Poros's review) — pigeonhole × kill is the shape fallback (b) should take over K. Act One is
  G70's dichotomy: a clean colouring is a residue colouring, which identifies 8/3 ∈ 2R, and otherwise some √3-pair is
  monochromatic. The open work is the kill on the dirty branch, and M56/M57's cores are its material → P3, §C.
- **G16** B — the distance-2 pigeonhole, and its converse on the Moser lattice (G70). "√3-clean ⟹ residue" is the local
  lemma behind rigidity over K. Fallback deliverable (b) of phase 3 is "the K instance explained by its local lemma" → P3.
- **G17** B — sub-rung compulsions have small carriers, and four-colour forcing on a 4-colourable lattice is sub-rung.
  Harder's 745-point forcer is the measured carrier. Predicts that census forcing asks refuse on modest balls where they
  refuse at all → P1d's ball-size ladder.
- **G18** B — certify components, compose in the kernel, pin palettes. The census's ball asks use cubes on a
  kernel-covered pigeonhole when monolithic CDCL caps → P1d, P1e.
- **G19** S — five-colour pattern sweeps.
- **G20** S — brick colourings.
- **G21** B (method) — a negative measures its enumeration. H1 is only ever H1-*found*: every "rigid" verdict names its
  colourings, periods and U (saturated or generators). The census states which graph each row is about → P1, P2 (a
  mandatory column).
- **G22** S — six-colourings of the plane.
- **G23** S — cell-family scale.
- **G24** S — the gap law in the cell family.
- **G25** S — the recursive forcing ladder (six-forcer pricing).
- **G26** S (for FS-73) — the six-target; its bearing is the programme's, recorded in §0.
- **G27** B — Galois automorphisms are graph automorphisms of multiquadratic objects. The transport group of a forced pair
  is larger than the point group (§C, "things worth knowing"). The census breaks Galois symmetry too → P1b.
- **G28** S — fine-tail virtual edges.
- **G29** S — the cell family closed.
- **G30** B (method) — failure mode 5 (a theorem over an empty domain) is R2, and mode 7 (a hypothesis implied by emptiness)
  is the same shape. `InheritanceQuestion` carries the existence of a periodic colouring as a hypothesis; §K ships a named
  inhabitant for `VoltageEscape` → §K, P5.
- **G31** B — `Forces` is monotone upward, so refuting a pair on a subgraph says nothing about the whole. Generator-only
  escapes are sound only for generator fabric (T10.6). Every census escape is re-verified on the saturated graph → P1b.
- **G32** S — the two-distance dial (five colours, arenas).
- **G33** B — counterexample-guided growth. The census's forcing asks grow by killing each separating colouring's local
  defect before building a bigger ball → P1d (growth mode after the first undecided ball).
- **G34** S — in-field descent.
- **G35** B — the wall's local criterion at every prime above 2; column (b) → P2.
- **G36** B — the residue colouring is the canonical separating colouring. M53-T12's 2-SAT transversal certifies that *no
  finite extension* of a K-object forces its cheats. That is a dual certificate to forcing, and the census uses it where it
  applies (K-point objects) → P1d.
- **G37** B — "K-fabric grown to four-colour rigidity supplies its own wall-breaking angle": the record's own first use of
  "rigid" meant *forced*, not Kempe-rigid. The distinction is now named (§0) → §C.
- **G38** B — linear/additive colourings give 2, 3, 4 then 7. Additive colourings are period-`exp(G)` colourings, so the
  additive screen is the `N = 4` (ℤ/4) and `N = 2` (Klein) slice of H1 → P1b.
- **G39** B — a forced pair confines the critical set to `N(p) ∩ N(q)`. A census ball that forces a pair at `d > 2` has an
  empty critical set: a free check on every refusal → P1d acceptance.
- **G40** B — absorption: a set whose colourings all extend carries only its own compulsions. A Kempe-closed set's swap is
  an extension in this sense → §K (the kernel form of T10 reuses `Extends`' pattern where it fits) → P5.
- **G41** B — additive colourings bound compulsions from one side; `[Fischer1994]`'s ℤ/4 colouring of K² separates the
  distance-2 pair that residue colourings identify. On de Grey's lattice, the census's `N = 4` row must contain Fischer's
  colouring. It is a known positive control for the finder → P1b control.
- **G42** B — additive rigidity is Kempe closure and "the family dies before it closes". Every unit-distance object held is
  Kempe-open *under additive homs*. H2 over all periodic colourings is strictly more than the additive gauge. §C states
  the difference → P1b, §C.
- **G43** B — the residue plane seals; the shadow sieve. The target shapes of T9's reading, and the usable-prime
  vocabulary for column (c) → P2.
- **G44** B — Kloosterman spectra of `Γ_p`. The *targets'* spectra; the quotient's spectrum is a subgraph's (§X, retraction
  2) → P2 (two spectral columns: target and quotient).
- **G45** S — lifting from a finite plane.
- **G46** B (method) — name the object in its theory. The colouring shift is a ℤ^r SFT, and the recognition is the gate's
  query (§PA) → §0, §PA.
- **G47** B — a forced pair on a Cayley graph needs a period of every colouring. That is the transport statement: forcing
  at `δ` makes every colouring periodic under the ℤ-span of `Pδ` (`P` the lattice's point group, extended by G27's Galois
  automorphisms) → §C "things worth knowing".
- **G48** B — the tightness mechanism, and the conjecture that FS-73's table serves. "Where a forcer can live" is the
  question the chain route needs in a 6-open field → P2's `k = 5` pilot row.
- **G49** B (method) — the gate in the discipline's words, under two disciplines, walking the poser's citation graph. Run
  in §PA; the competitors run their own → §C obligations.
- **G50** B (method) — read what the search found. `[AlonEtAl2021]` (mixing of colourings of ℤ^d), "pointer only" since
  FS-70, was fetched and read at the level recorded in §PA.
- **G51** B — the competition design, retractions counted. Five retractions so far in this stage's own window (§X) → P3.
- **G52** S — σ-criterion for rotations (arenas).
- **G53** S — the counting compulsion (arenas).
- **G54** B + F — tight/slack. D2-A makes every colouring of a tight Cayley graph periodic under `H_min`. For the lattice
  graph itself the sign is `m(Λ)` against `−d/(k−1)`. Measured slack on de Grey's lattice (phase 0, P-S1 lost). **F:**
  G54's "middle case unobserved" is *not* tested by lattice quotients (Poros, §X): any slack Cayley graph with a forced pair
  is gap-free trivially → P1c relabelled as a cross-check.
- **G55** B — the chain theorem's transport (every colouring periodic under `δR`), prime inversion, and Harder's forcer as
  `G₄`. The consumer of anything FS-73 lands → §C, and P2's column "chainable targets" (`1/δ ∈ ℤ[U]`).
- **G56** B — the 2-adic trichotomy (split/ramified/inert) and the usable `q`. Columns (b) and (c) → P2.
- **G57** B — `ω = 3` iff `√3 ∈ F`. Clique pinning in every census SAT ask depends on it (triangle pin where `√3` is present,
  edge pin otherwise) → P1, P2.
- **G58** S (weak) — the antipodal conjecture. A finder restricted to antipodal colourings would halve instances, but the
  census's finders need completeness at the target, not halving. Poros reports a reason it bears on (1). It says the PO
  holds that item for the competition phase, so the verdict is left unchanged here.
- **G59** B (moved from S at Poros's review; a caution) — its product escape hatch is about categorical products of
  targets. A lattice quotient `Cay(Λ/NΛ, U mod N)` is only a diagonal *subgraph* of the product of its local targets,
  because `U` is finite (de Grey's 54 vectors against 24 × 48 pairs at N = 35). So product bounds bound the quotient from
  one side only, and FS58-T3's tensor identification, which used an infinite `U`, does not transfer → P2 column (e), §0.
- **G60** B (moved from S at the PO's amendment A4, decided at the modeling stage). The blow-up's engine is an
  invariant measure on an amenable group, and Λ ≅ ℤ^r is amenable. So a separating colouring's orbit closure carries an
  invariant measure, which defines the third subgroup `F_μ` with `F ⊆ F_μ ⊆ P`. That splits C3-inherit into a walls half
  and a recurrent half (§0). G60's own LP instrument does not run at K (§0, last paragraph) → §0, §C.
- **G61** B — at three colours rigidity is periodic and local, and supply of unit vectors decides. The three-colour
  classification over ℚ(√167) (FS-59's question) is P2's `k = 3` row. "Quotient screens are blind at three colours on
  affine colourings" is the reason that row uses the gap-aimed finder and T10, not colourability → P2.
- **G62** B — bilayers are coincidence rotations, and commensurate ⟹ periodic ⟹ bounded (M63H3-T8). A rank-6 lattice built
  by a commensurate twist is a sublattice of a rank-4 one's scaled copy, and the reading of question 3 starts there → P4.
- **G63** S — transcendence.
- **G64** B (weak; moved from S at Poros's review) — the norm reading. If `V` is stable under the colouring's symmetries,
  `NΛ/V` is a module quotient and its order a norm (P-R2) → P4.
- **G65** B — the degree law prices balls; a word ball has a combinatorial ceiling. Census forcing asks are aimed at degree
  ≥ 14 on Minkowski balls, never word balls → P1d, P1e.
- **G66** B — "ask the whole graph clique-pinned before any finder", and "CDCL refuses nothing up a tower it cannot refuse at
  the bottom" (FS66-T6). The census's ball asks at a target outside every refusing quotient's reach are expected to be hard
  from the start. Lemma W (fibre shares leave the polytope) is the corpus's own warning that local-to-global transfers can
  fail → P1, §C. **Also its first sentence (A4, modeling stage):** periodic colourings are exactly the continuous colourings of
  the odometer Λ ↷ Λ̂, so `P = F_clopen`, and C3-inherit is the compulsion analogue of `χ_clopen = χ`, with the measurable
  colourings in between (`F ⊆ F_μ ⊆ F_meas ⊆ P`) → §0, §C.
- **G67** B (method) — every grokking minted at the close carries a trigger-led *Do* and a killing test → P6.
- **G68** B — ask the quotient before the ball, and read it for a gap. P1b runs it at every admissible `N` before any census
  ball, with the complete-U soundness edge stated per row.
- **G69** B — the whole stub. Its two killing tests are P3's counterexample shape (a non-periodic escape) and P2's second
  shape ("a rank-4 lattice loose at every odd prime that still forces"). **Correction for the close**: "Harder's forcer lives
  at 23,083 points" compares our ball with a ball; Harder's smallest forcing subgraph is 745 points (row 76), and the
  "three orders of magnitude" is nearer four against the known object (Poros) → P6.
- **G70** B — √3-clean ⟹ residue colouring on the Moser lattice; the dichotomy. C3-inherit over K asks whether the √3-*dirty*
  colourings, which carry the depth stratification, can separate 8/3. They cannot, by Harder, and nothing explains why.
  That explanation is fallback (b) → P3, §C.

### §G.2 Ledger rows 1–77 (mechanisms)

- **1** S — two-circle 3-colourability. · **2** S — seam identity. · **3** S — coverage ratchet (monotonicity only). ·
  **4** B — fan ⟺ coverage: a gap is the failure of coverage. The gap finder's clause → P1b. · **5–10** S — pivot/class
  geometry, greedy, balanced colouring of de Grey's graph; no lattice colouring space.
- **11** B — the **strip automaton**: the colouring space grows ×12 per column and every window colouring extends. The
  corpus's one explicit *non-periodic* colouring family of an infinite structure, and a shape a counterexample could take
  → §C (non-periodic constructions).
- **12, 13, 15, 16, 18–21** S — coupling statistics and negative knowledge of M17–M23.
- **14, 17** S — circle-intersection classifications.
- **22–24** S (pending one check, P1f) — closures that are exactly 4-chromatic with explicit colourings (row 22's
  proved through mod-3 congruences, row 24's `hexColor` rot6-equivariant). If any explicit colouring is non-periodic, it
  joins §C's list of non-periodic constructions and this verdict becomes B (Poros).
- **25** S — ρσ² = −1.
- **26** B — the 791-point forcer forces exactly six pairs. Known answers for the census's K rows → P1d.
- **27–30** S — quadrature, kill engine, stacking, mechanism hunt (arenas and carriers).
- **31** B (as a warning) — `core9_plane` and `core122_plane` are vacuous. The standing instance of G30's mode 5, to which
  `periodicForcedSubgroup`'s vacuous case (`P = ⊤` with no periodic colouring) is sibling → §K.
- **32–41** S — six-programme hosts, brick and coset colourings, cell family, limit lemma.
- **42** B — arity floor, `Forces`/`Separated` at arity 2. The census reports both pins (T10.5 kills `Separated`) → P1.
- **43** B — homogeneity (`transport_pair_of_isometry`): forced pairs transport along isometries of the lattice → §C.
- **44** B — the spindle theorem, the consumer of a forced pair (with row 76's chain) → §0.
- **45** B — spare-colour lemma (behind the 3-adic gate) and the entropy floor → P2 column (a).
- **46** B — every unit edge of the descended object lies on the Moser lattice. Identifies the lattice the K rows use → P1a.
- **47** B — Harder's 8/3 pair (Polymath16, 28 April 2018); our 588-core; K(√247). The K instance → §C.
- **48** B — critical-set localisation; free check on census refusals → P1d.
- **49** B — absorption (`Extends`) → §K.
- **50** B — the additive yardstick and the 1/k obstruction; `1/2 ∈ Λ` kills additive colourings → P1b (additive rows
  are empty on wall-broken lattices).
- **51** B — additive rigidity (`forces_of_additivelyRigid`); rigid under additive homs is a special H2. The kernel
  sibling of T2 → P5.
- **52, 53** B — the finite-plane bound at odd residue degree, the sieve, Kloosterman. Targets and their spectra → P2.
- **54** S — lift obstruction.
- **55** B — the residue obstruction; "the transfer is freeness only". The residue direction frees and never forces; the
  inheritance question is the other direction → §0.
- **56** B — `addCayleyMap`, `unitQuadrance_colorable_of_quotient`; the periodic quotient in the kernel → §K.
- **57** B — Theorems A and B, and `[Fischer1994]`'s exponent-4 colouring. The two canonical periodic colourings of the
  K-lattice → P1b controls.
- **58** S — Moser recipe threshold (minimal gadgets).
- **59** B — 2-adic valuation law over K: a forced pair needs `v_𝔭(d) > 0`. Targets to census are graded by depth → P1d.
- **60** B — plane freedom: `Forces ↔ =` on colourable prime-field planes. The residue *targets* never force, so all forcing
  on a lattice comes from its composite and 2-adic structure → P2, P4.
- **61, 62** S — six-target statement generality; orbit-closure gap.
- **63** B — two colours from inertia; the 2-adic splitting. Column (b) for multiquadratic fields → P2.
- **64** B (for the `k = 5` pilot) — the ρ₆₃ arena in K(√7): 5-chromatic, zero forced pairs. The six-level analogue of
  "rigid lattice?" → P2 pilot row.
- **65** B — the free-circle kill (`4 | n`): additive pairs forced to the centre's colour. The additive slice of H1 on type-M
  lattices → P4.
- **66** B — the fan gap and its transport. T6's premises → §K, P1b.
- **67** B + F — the 2-adic tower forces depth ≥ 4 locally; "says nothing about any finite chunk"; **P-D3: no finite
  K²-graph forces depth 4**. De Grey's lattice escaping at 4 under T10 agrees on one lattice. Registered as P-C3 with
  P-D3 in view (§P) → P1d, P1e.
- **68–71** S — six at 83, the window, 27, 23, `χ_f(K²) = 4`, except **70** B: U₃₂'s complete rigidity ("tight can be rigid
  and force nothing") and inert towers keeping `λ_min/d`. That is a cautionary instance: rigidity of the colouring space
  and forcing are different things → §C.
- **72** B — the 3-adic barrier, and the tensor rigidity that is only measured (FS-67): context for C3-local, not its route →
  P2.
- **73** B — ℚ(√11): a 52-point graph forces `c(0) = c(3u)` at **three** colours and the chain closes. A second forced
  instance (at `k = 3`). Uninformative for C3 like K's, but a positive control for the `k = 3` census row → P2.
- **74** B — the census of quadratic fields: supply of unit vectors decides, and shapes do not transfer (FS61-T3). P2's
  lattice choice per field is by supply, and no lattice is carried between fields.
- **75** B — the fibre-share inequality, Lemma W (local transfers fail), Lemma T (instruments blind to the carry), and
  `χ_Bor` of `ℚ_p²`. The limit of periodic colourings up a tower is the clopen chromatic number: C3-local's 2-adic half in
  the discipline's words → §C.
- **76** B — FS-70 entire: the screens, T9, the rank-8 lattice (C3-aper's instance), Harder's control ball of 23,083
  points, the rich lattices' Kempe rigidity (generator-only, `N ∈ {2, 4}`). The census starts from its records → P1.
- **77** B — the audit that filed § B. FS58-T4's kernel note ("no Mathlib compactness wrapper") is wrong: Mathlib holds
  `nonempty_hom_of_forall_finite_subgraph_hom` (Poros). Correction owed at the close → P6.

### §G.3 LEDGER.md § B, 254 lines

*One verdict per line. "no Λ" abbreviates "concerns a finite object, an arena, a witness or a plane, not the colouring space
of a lattice graph".*

**M17–M45.** M18-T1 S (roots of unity; no Λ). · M31-T1 B (quadrature law; C2's reading for rank-6 bilayers → P4). ·
M32-T1 B (the stacking law's translation matching; G14's matching → P4). · M35-T1 S (hexagonal sublattice norms;
coset-colouring floor, not four-colour lattice colourings). · M36-T1 S (brick family). · M39-T1 S (Voronoi edge criterion).
· M40-T1 S · M40-T2 S · M40-T3 S · M40-T4 S · M40-T5 S (cell-family bands). · M41-T1 S (fractional numbers of cores). ·
M43-T1 S · M43-T2 S (band thresholds, clique windows). · M45-T1 S (arity-3 compulsions on a fine-tail stage; no Λ). ·
M48-T1 S (Jung's cap on pigeonhole sets).

**M49–M52, Q8.** M49-T1 S (E–I's forcer at five colours; no Λ). · M49-T2 S · M49-T3 S. · M50-T1 S (halo composition). ·
M50-T2 S (E–I stage census). · M51-T1 S (a witness). · M52-T1 S (field membership). · M52-T2 S (cull soundness). · Q8-T1 S ·
Q8-T2 S (witnesses).

**M53.**
- M53-T1 B (Theorem A: the target of every periodic colouring → P2).
- M53-T2 B (2's splitting in K(i): the K rows' 2-adic target, `K₄ × K₄` at level 1 → P1a).
- M53-T3 B (Theorem B: the period-2 colouring of the K-lattice → P1b control).
- M53-T4 S (smallest spindle field).
- M53-T5 B (the criterion at 2: column (b) → P2).
- M53-T7 S (quadratic classification by `d mod 8`).
- M53-T8 B (Theorem A′: additive refinements are periodic colourings → P1b).
- M53-T9 S (glue points stay multiquadratic).
- M53-T10 S · M53-T11 S (K objects and five colours).
- M53-T12 B (the 2-SAT certificate that *no finite extension* forces: a dual certificate to forcing, where applicable →
  P1d).
- M53-T13 S · M53-T14 S · M53-T15 S (μ ≥ 3; witnesses).

**M54–M57.**
- M54-T1 B (critical set of a forced pair; free check → P1d).
- M54-T2 S · M54-T3 S · M54-T4 S.
- M55-T1 B (`Extends`: colourings of a set that all extend → §K).
- M55-T2 S (hub matchings).
- M55-T3 B (the repaint lemma: the swap's engine is the same move → §K).
- M55-T4 B (peeling to the `(k+1)`-core carries every compulsion; census balls are asked on their cores → P1d).
- M55-T5 S · M55-T6 S · M55-T7 S.
- M56-T1 B (exponent-`e` homs identify `eΛ`; additive H1 slice → P1b).
- M56-T2 B (additive colourings are proper; "no admissible hom proves nothing" is the vacuous-case warning in its additive
  form → §K).
- M56-T3 B (rank-4 hom enumeration is `m⁴`: the additive screen's cost → P1b).
- M56-T4 B (valuation-4 classes are carried by NON-additive colourings: the additive slice of H1 is strictly weaker than
  H1 → §C).
- M56-T5 S · M56-T6 S (colour-count bounds of additive families).
- M56-T7 S (additive spindle theorem).
- M57-T1 B (additive rigidity ⟹ Forces; the kernel-held special case of C3 for the additive slice → §C).
- M57-T2 B (forced/free/mixed on `Λ/kΛ`; the period-`k` classification at additive level → P1b).
- M57-T3 B (the gauge γ: Kempe connectivity of every admissible hom; T10's ancestor → §C).
- M57-T4 S · M57-T5 S.
- M57-T6 B (the four-colour bridging bed Kempe-open under every ℤ/4 hom, 2,000 colourings non-additive: the additive slice
  never closes on K-fabric → §C).
- M57-T7 B (E–I's `G` additively rigid, but a forcing subset keeps > 5,000 non-additive colourings: "rigidity sufficient,
  far from necessary". The additive-slice analogue of C3's converse direction → §C).
- M57-T8 S · M57-T9 S.

**MASCOT (2026-09-08).**
- MASCOT-T1 B (the parity law: forced pairs at steps divisible by 3; target list → P1d).
- MASCOT-T2 B (a forced pair needs `4 | (2c+1)` 2-adically; target filter → P1d).
- MASCOT-T3 S · MASCOT-T4 S · MASCOT-T5 S (the minimal-gadget impossibility; finite gadgets only).
- MASCOT-T6 B (the rigidity theorem, the local lemma → P3, §C).
- MASCOT-T7 B (cross edges of a twisted pair: exactly six pairs plus the star; the rank-6 cross-edge set in closed form →
  P4).
- MASCOT-T8 B (the ρ₄ pigeonhole: a transported dichotomy across two copies; a template for "walls must respect the pair"
  → §C).
- MASCOT-T9 S (core9's field).
- MASCOT-T10 B (phase walls on ℤ[ζ₆]: the corpus's open non-periodic case → §C).
- MASCOT-T11 B (triple-based methods are blind to phase walls; which instruments cannot see walls → §C).

**R57, R52, M58–M61.**
- R57-T1 S (χ(ℚ⁴) = 4).
- R52-T1 B (the finite-plane bound at odd residue degree: target shape → P2).
- R52-T2 S · R52-T3 S · R52-T4 S.
- M58-T1 B (Kloosterman: target spectra → P2).
- M58-T2 S · M58-T3 B (the wall criterion over `K(√d)`: column (b) for the K(√d) pilot → P2).
- M59-T1 S · M59-T2 S · M59-T3 S · M59-T4 S · M59-T5 S · M59-T6 S (lifts).
- M60-T1 B (compulsion sets are unions of norm classes on a Cayley plane; the census reads targets by class → P1d).
- M60-T2 S · M60-T3 S.
- M61-T1 B (`L(F)` bookkeeping, which primes contribute → P2).
- M61-T2 B (Weil + Hoffman over `𝔽_q`, targets only → P2).
- M61-T3 S.
- M61-T4 B (the periodic quotient is a circulant along a null direction; partial periodicity's shape → §C).
- M61-T5 B (the tightness mechanism: the spindle removes the sealing prime → §0 bearing line).

**R59, M62–M64, FS-32.**
- R59-T1 B (the valuation law is `d ↦ 1/d`-invariant; the census's target grading → P1d).
- R59-T2 S.
- M62-T1 S · M62-T2 S · M62-T3 S.
- M62-T4 B (the base group `⟨ζ₆⟩ ⋊ Gal`: the transport group of forced pairs, point group plus Galois → §C).
- M64-T1 S · M64-T2 S · M64-T3 S · FS32-T1 S · FS32-T2 S (hitting sets, reductions).

**M63.**
- M63-T1 S · M63-T2 S · M63-T3 S · M63C-T1 S · M63C-T2 S · M63C-T3 S · M63D-T1 S · M63D-T2 S · M63D-T3 S · M63D-T4 S · M63D-T5 S · M63D-T6 S (the reduction loop's soundness; no Λ). · M63D-T7 B (moved from S at Poros's review: the
  transfer lattice. Separations found among periodic colourings carry up to "not forced"; refusals carry only down. The
  missing direction is C3-inherit itself, so no H1-found target is ever promoted to a forcing claim → P1d, P1f
  acceptance).
- M63G-T1 S · M63G-T2 S · M63G-T3 S · M63G-T4 S · M63G-T5 S (rotation screens for arenas).
- M63H2-T1 B (the one-integer family: names every rank-6 twist → P4).
- M63H2-T2 S · M63H2-T3 S · M63H2-T4 S · M63H2-T5 S.
- M63H2-T6 B (the shell-counting formula: the unit-vector supply of a saturated lattice at denominator `D`, which prices
  P2's saturation → P2).
- M63H2-T7 S · M63H2-T8 S · M63H2-T9 S · M63H2-T10 S · M63H2-T11 S.
- M63H3-T1 B (the cross-edge law in closed form: the rank-6 cross set → P4).
- M63H3-T2 S.
- M63H3-T3 B (growing a base only shrinks the achievable interface patterns: monotonicity in the lattice, the inheritance
  direction's easy half → §C).
- M63H3-T4 B (the free-circle kill: the additive slice at `4 | n` → P4).
- M63H3-T5 S · M63H3-T6 S.
- M63H3-T7 B (the coincidence identity: rank-6 = Σ = n bilayer → P4).
- M63H3-T8 B (commensurate ⟹ periodic ⟹ bounded → P4).
- M63H3-T9 S.
- M63H4-T1 S.
- M63H4-T2 B (superset-neutrality: a D-reducible deletion does not change the pattern set; census balls may be reduced to
  cores → P1d).
- M63H4-T3 B (`Extends` is D-reducibility, the degree-≤4 boundary; the census's pruning rule → P1d).
- M63H4-T4 S.

**FS-25, FS-36, FS-38.**
- FS25-T1 B (de Grey's 1581 forces no pair because of three critical vertices; the census's finite-object check → P1d).
- FS25-T2 B (the periodic quotient along a circle-missing line is a circulant; partial periodicity → §C).
- FS25-T3 S.
- FS25-T4 B (the valuation law is the exponent-2 additive member → P1b).
- FS36-T1 S · FS36-T2 S.
- FS38-D1 B (level-2 colourings of the 2-adic plane are periodic; the period-set census → P1d).
- FS38-D2-A B (tight ⟹ balanced, gap-free, `H_min`-periodic: the spectral route to H1 → P2 column).
- FS38-D2-B B (the tower's colourings pulled back from level 4: C3-local's 2-adic half, proved → §C).
- FS38-L1 B · FS38-L2 B · FS38-L3 B (propagation up the level map, the certificate for depth 4; the lattice-level analogue
  is P2's spectral column).
- FS38-D3 B (sign propagation; `UD(ℤ/9,2)` 3-periodic → P2).

**ASTRA (2026-09-14).**
- ASTRA-2026-09-14-T1 S · ASTRA-2026-09-14-T2 B (prime inversion: the chainable-target column → P2).
- ASTRA-2026-09-14-T3 S · ASTRA-2026-09-14-T4 S.
- ASTRA-2026-09-14-T5 B (the chain theorem: transport, periodicity under `δR` → §C).
- ASTRA-2026-09-14-T6 S.
- ASTRA-2026-09-14-T7 B (the consumer of Harder's forcer → §0).
- ASTRA-2026-09-14-T8 S · ASTRA-2026-09-14-T9 S · ASTRA-2026-09-14-T10 S.

**FS-50, FS-53, FS-54.** FS50-T1 S · FS50-T2 S · FS50-T3 S · FS50-T4 S · FS50-T5 S · FS50-T6 S (certificate soundness; `L(K(√7))`; no Λ). · FS53-T1 B (tightness needs `(k−1) | (q+1)`: an
arithmetic filter on P2's spectral column at residue targets). · FS53-T2 S · FS53-T3 S. · FS53-T4 B (usable `q` iff `p ≡ 3
(mod 4)` and `f` odd → P2). · FS54-T1 S · FS54-T2 B (2-adic trichotomy → P2) · FS54-T3 S · FS54-T4 S · FS54-T5 S ·
FS54-T6 B (U₃₂: complete rigidity forcing nothing → §C caution) · FS54-T7 B (inert towers keep the ratio → P2) · FS54-T8 S · FS54-T9 S · FS54-T10 S · FS54-T11 S.

**FS-56, FS-58, FS-39, FS-62, FS-61.**
- FS56-T1 B (congruences are field-rational isometries: the transport group → §C).
- FS56-T2 S · FS56-T3 S · FS56-T4 S · FS56-T5 S · FS56-T6 S · FS56-T7 S.
- FS58-T1 B · FS58-T2 B (the 3-adic tower is tight, and colourings are pulled back from level 1: the `k = 3` local half →
  P2).
- FS58-T3 B (periodic 3-colourings factor through a tensor product. That is the composite column's *shape*, but its
  identification used an infinite `U`, and a finite-`U` quotient is only a subgraph of the product: Poros, §X 13 → P2, P4).
- FS58-T4 B (**R1, at three colours**: this is the credit → §0, §K; kernel note to be corrected → P6).
- FS58-T5 B (the direction-set quotient screen: G68's ancestor → P1b).
- FS58-T6 B (a distance-2 virtual edge plus a run forces at three colours: a forcing mechanism on a lattice → §C).
- FS58-T7 B (the pigeonhole-forcing lemma from Wormald: how finite forcers arise → §C).
- FS58-T8 S · FS58-T9 S.
- FS39-T1 S · FS62-T1 S · FS62-T2 S · FS62-T3 S · FS62-T4 S · FS62-T5 S · FS62-T6 S.
- FS61-T1 S · FS61-T2 S.
- FS61-T3 B (shapes do not transfer between fields → P2).
- FS61-T4 S.
- FS61-T5 B (the degree law → P1d, P1e).

**FS-66.** FS66-L1 S · FS66-L2 S · FS66-L3 S · FS66-L4 S · FS66-L5 S · FS66-L6 S (the fibre-share certificate; no Λ). ·
FS66-W B (a local transfer cannot prove "the tower never rises": the corpus's precedent that local rigidity need not
transfer → §C). · FS66-E B (towers over rings containing their residue field are impotent: ramified targets' first levels
→ P2). · FS66-T B (instruments blind to the carry: P2's spectral columns cannot see the carry, so state it). · FS66-T1 S ·
FS66-T2 S · FS66-T3 S · FS66-T4 S · FS66-T5 S · FS66-T6 B (a level's refutation projects to the level below: census ball
asks at targets no quotient refuses are expected hard → P1d) · FS66-T7 S · FS66-T8 B (the tower's limit is the clopen
chromatic number of `ℤ_p²`: C3-local's 2-adic half, named → §C) · FS66-T9 S.

**FS-70.** FS70-T1 B (the triangle lemma: chainable targets on 2-unit fabric → P1e) · FS70-T2 B (the additive Kempe screen
→ §K T2) · FS70-T3 B (the 3-adic gate → P2) · FS70-T4 B (commensurate ⟹ 2-unit in `E₀` → P2) · FS70-T5 B (the CM-subfield
table; P2's template) · FS70-T6 B (§K T6) · FS70-T7 B (the split-prime tower; depth classes → P1e) · FS70-T8 B (the rich
lattices' Kempe rigidity, generator-only, `N ∈ {2, 4}`: census row (ii) → P1e) · FS70-T9 B (periodic = residue, prime by
prime; P2's column (c), corrected by the composite column) · FS70-T10 B (§K; H1 ⟺ H2) · FS70-T11 B (L3's arity floor; P4's
object).

*Count, by script over this file against `LEDGER.md` § B (every id found once, none missing): 254 lines walked; B 91, S 163,
F none (the falsifiable items are in §G.1–2 and §P).*

### §G.4 Method rules (`CLAUDE.md` § Grokkings [method] entries and § Toolchain / Building / cost model / Searching)

- **G21, G30, G46, G49, G50, G67**: in §G.1 above.
- **G51**: in §G.1 above.
- **Toolchain: the SAT solver and the installed tools** — B: the census uses kissat and CaDiCaL with PySAT rechecks
  (four code bases) → P1.
- **Break the symmetry before any (UN)SAT search** — B. Every census ask pins a clique (triangle iff `√3 ∈` the lattice's
  field, G57), adds colour precedence, and never reports an unbroken UNKNOWN → P1, P2.
- **Python 3.14 forkserver** — B: census workers use `mp_context=get_context("fork")` or rebuild state → P1a.
- **Two machines; name the machine; CPU seconds, minimum of three** — B: every timing in §R names the desktop → P1.
- **Predicted vs measured throughput** — B: P1d prices ball asks by G65's law and reconciles → P1d.
- **Always build through `./scripts/build.sh`** — B → P5 (and this stage's skeleton was so built).
- **`lake env lean` is not the same check** — B → P5.
- **The batch is the plan; the cap is a backstop** — S (no new wide batches).
- **On any unexplained crash, halt and report** — B → every phase's stop rule.
- **One heavy job at a time** — B: the shared lock → every phase.
- **Every long-running phase checkpoints and resumes exactly (PROTECTED)** — B: every phase's checkpoint and resume
  command → §S.
- **A run that blocks something is presumed killable (PROTECTED)** — B: P1's census runs are killable at any row boundary →
  §S.
- **Kill by PID or process group, verify by effect** — B → every phase.
- **A pipe can kill the producer** — B: no gate's status read through a pipe → P1, P5.
- **Never edit a running shell script** — B → P1.
- **Generated modules and invalidation** — S (no generated modules planned; §K is hand-written).
- **Kernel cost model** (`decide +kernel`, literals, `List.all`, numerals at type indices, feed the core) — B (P5, only if a
  census instance is certified in the kernel: none is planned; the skeleton is abstract).
- **Searching: `ugrep` alternation, `^` inside patterns, `rg -uu` for completeness, a failed `exact?`** — B: P5's queries,
  and the lesson of FS58-T4's kernel note (a search of `Coloring*.lean` missed `Finsubgraph.lean`) → P5.
- **§ The gate: vacuity, inhabitants, spec examples, negative controls, "state the uninformative outcome and confirm it is
  reachable"** — B: every phase's acceptance names its uninformative outcome (Poros: the census can confirm C3 but never
  refute it) → §S.

### §G.5 Extraction index: every B, the phase instruction it became

| phase | instructions drawn from §G (entry → instruction) |
|---|---|
| P1a | G8, row 46, M53-T2: de Grey's lattice exactly as the owner's control; Python fork context |
| P1b | G13/row 4: gap-aimed finder first. G68/FS58-T5: quotient at every admissible `N` before any ball. G38/M53-T8/M56-T1/FS25-T4/row 50: additive rows as the `N = 2, 4` slice. G41/row 57/M53-T3: Fischer's ℤ/4 and Theorem B's colouring as finder controls. G31/T10.6: re-verify every escape on the saturated graph. G27: Galois symmetry break. R3: report the separating periodic colouring's period `W′`, not the index |
| P1c | G54 relabelled: forces refusal vs gap finder, a two-instrument cross-check (no claim about G54's middle case) |
| P1d | G9/row 26: known-answer rows. G17/G65/FS61-T5: ball ladder aimed at degree ≥ 14. G18: cubes when monolithic CDCL caps. G33: growth mode. G36/M53-T12: the no-finite-extension certificate where it applies. G39/M54-T1/row 48: critical-set check on every refusal. M55-T4/M63H4-T2/T3: ask cores. FS66-T6/G66: expect hardness where no quotient refuses. MASCOT-T1/T2/row 59/R59-T1: targets graded by depth. Row 67/P-D3: register depth-by-depth. FS38-D1: period census at 2 |
| P1d′ | A2 (PO): the period extension with its own budget and stop rule. G59 and the composite column: composite and prime-power periods. G21 and the § Gate rule on reachable uninformative outcomes: an UNSAT period is no plateau step, and outcome (c) is declared |
| P1e | FS70-T8 (generator-only, `N ∈ {2,4}`): odd-`N` gap-aimed quotients at 5, 7 first (P-M2's live half), then saturation, then balls. FS70-T1/T7: targets by depth |
| P1f | G21: every row states its graph (saturated or generators), periods, finder, verdict. M63D-T7: no H1-found target promoted to a forcing claim. Rows 22–24: check their explicit colourings for periodicity |
| P1g | Poros's L3 card (composite period), minutes, before P4 is written in detail |
| P2 | G59: the quotient is a diagonal subgraph of the product of targets, so column (e) is computed, never inferred. G1/G35/G56/M53-T5/FS54-T2/row 63/M58-T3: column (b). G43/G44/R52-T1/M58-T1/M61-T1/T2/FS53-T4/rows 52–53: columns (c) with the target and quotient spectra separate. FS58-T1/T2/T3/row 72: `k = 3` locality and the composite column. FS70-T3/T4/T5/T9: the table's template. FS61-T3/row 74: lattice per field by supply, none transferred. M63H2-T6: saturation priced. FS38-D2-A/FS53-T1/FS54-T7: the spectral column. ASTRA-T2/G55: chainable-target column. G48/row 64: the `k = 5` pilot row. G61/row 73: the `k = 3` row with ℚ(√11) as positive control. FS66-E/T: ramified targets' impotence and the carry caveat |
| P3 | G51: the protocol, retractions counted. G15: fallback (b) as pigeonhole × kill. G16/G70/MASCOT-T6/T8/T10/T11/row 11/FS58-T6/T7/rows 70, 75/FS66-W/FS66-T8/FS38-D2-B/M57-T1/T3/T6/T7/M56-T4/G42/G47/row 43/M62-T4/FS56-T1/ASTRA-T5/M61-T4/FS25-T2/M63H3-T3/FS54-T6: §C's "mathematics you stand on" and "things worth knowing" |
| P4 | G64 (NΛ/V a module quotient, P-R2). G7/G12/G14/G62/M31-T1/M32-T1/MASCOT-T7/M63H2-T1/M63H3-T1/T4/T7/T8/row 65: rank-6 lattices as bilayers, their cross sets in closed form, the additive slice at `4 | n`. FS58-T3: the tensor shape. Row 60: residue targets never force |
| P5 | G30/row 31/M56-T2: vacuity (`InheritanceQuestion` carries existence, and a spec `example` inhabits it; `VoltageEscape` has a named inhabitant; F is shown to be neither `⊥` nor `⊤` on the path ℤ). G40/M55-T1/T3/row 49: the swap as a repaint. Rows 51, 56, 66: existing kernel lemmas. Searching rules: query Mathlib by shape before writing |
| §0, §C | G60 (A4): the invariant-measure subgroup `F_μ` and the walls/recurrent split. G66's first sentence (A4): `P = F_clopen` on the odometer, with the measurable colourings in between |
| P6 | G67: form of new entries. G69 correction (745 vs 23,083). Row 77 / FS58-T4 kernel note and FS-39's phase A (Mathlib holds the compactness lemma) |

*Tally, counted by script and by hand after Poros's review of the silent verdicts (G21: a count typed before counting was
wrong by 16 in § B and by 4 in the grokkings, and is corrected here): grokkings B 47 / S 23 (G60 moved at A4, recounted by script at the modeling stage); rows B 33 / S 44 (22–24
pending one check); § B B 92 / S 162; method rules in §G.4 B 17 / S 2. Every B appears as an instruction in the
table above or in §S's phase rows.*

### §G.6 What the re-grokking changed in the plan (the test of 3.1)

1. **The competition's question changed.** The stub's C3 ("rigid ⟹ forced") becomes C3-inherit: non-vacuous, at H1, with
   R1 making the finite ball free and R3 making "Kempe-rigid" and H1 one condition. C3-aper and C3-local are split off and
   named. (G30, G21, FS58-T4, G69, T10, row 67.)
2. **A phase was added before the competition**: the H1 census (P1). Without it the competition has only an uninformative
   positive instance. (Poros's question; G21; FS70-T8's generator-only verdicts; row 67's P-D3.)
3. **The classification changed shape**: a spectral column for the lattice itself, target and quotient spectra kept apart,
   and a composite-period column. T9's single-prime reading is not complete at rank 6, and a quotient is a subgraph of
   its target. (G54, FS58-T3, retraction 2, FS70-T11.)
4. **Question 3 was re-aimed** from the index to `NΛ/V` and the targets' images, and its first measurement moved into P1
   (P1g). (R3, Poros's card.)
5. **Nulls predicted before being run**: every census ball at a target no periodic colouring separates is expected to be
   slow (FS66-T6). The rich lattices may die at `N = 5` or `7` by a gap (P-M2's live half). A de Grey quotient at 8 will
   show no gap (a corollary of Harder + T6).
6. **The kernel scope grew by two leaves** (R1 and R3) beyond the stub's T2/T6/T10, and T6's composition is already
   proved in the skeleton.
7. **Poros's review of the silent verdicts moved four** (G15, G59, G64, M63D-T7) **and corrected a framing.** C3-local is
   not "FS-67 at four colours": a finite-`U` quotient is a diagonal subgraph of the product of targets. That changed §0, P2
   column (e), P6, fallback (b)'s guidance, and P1d/P1f's acceptance.

---
## §PA. The prior-art gate (WORKFLOW 3.2)

*Run by the planner, 2026-09-23, in the recognition's words (§0), before the phases were written. zbMATH Open API queries
through `curl`, 46 in all; every query and its hit count below. Where a hit's text was read, it says whether it was a
reviewer's review or an author's summary; "withheld" means the API returned no text for licensing reasons. A negative
measures its query's words (G21).*

### §PA.1 The eight questions

1. **The object, in its discipline's words.** The space of proper `k`-colourings of a Cayley graph of ℤ^r with a finite
   connection set is a **ℤ^r subshift of finite type**. A forced pair is a two-site pattern shared by every configuration.
   C3-inherit asks whether **periodic points witness every two-site pattern**; density of periodic points suffices. C3-aper
   is **the existence of periodic points**. The discipline's word nearest to our "rigid" is **frozen**, and its
   statistical-mechanics twin is the zero-temperature antiferromagnetic Potts model on the lattice with interaction set
   `U`, whose ground states are our colourings and whose cluster moves are Kempe swaps.
2. **Two disciplines (four, in the event).**
   - Symbolic dynamics: SFTs, hom-shifts, periodic points, strong irreducibility, the domino problem.
   - Graph theory: periodic colourings of quasi-transitive graphs, distance graphs on ℤ, Kempe equivalence,
     undecidability of colouring periodic graphs.
   - Descriptive combinatorics: the continuous chromatic number of ℤ^d actions.
   - Statistical mechanics (from Poros's expectation): the Potts antiferromagnet, the Wang–Swendsen–Kotecký algorithm,
     periodic ground states.
3. **The question, not the method.**
   - Posed: **`[AbrishamiEtAl2025]` Problem 4.6**, *"is every locally finite graph G with a periodic proper vertex-colouring
     periodically χ(G)-colourable?"* That is C3-aper in general form. It is answered yes for 2-ended graphs (Thm 5.2,
     through `[CarrollPenland2015]`), no for some ∞-ended ones (§4.3), and nothing is said for ℤ^d with d ≥ 2.
   - **Not found posed anywhere:** "do periodic colourings detect forced pairs?" (C3-inherit). Also not found: any join of
     Kempe chains to unit-distance colourings of lattices (FS-70's six phrasings, re-run here in the new vocabulary with the
     same null).
4. **Outside arXiv.**
   - `[Burr1984]` (Discrete Math., reviewer's review): colouring-extension problems on doubly periodic graphs with ≥ 3
     colours are undecidable.
   - `[EggletonErdosSkilton1990]` (Graphs Combin., reviewer's review): in rank 1 a periodic χ-colouring always exists, and
     some `D` admit aperiodic ones.
   - `[Polymath16wikiR2]` (held; statements re-scanned today): Prop. 6 (tri-sectors), Cor. 9 (2R₁-periodicity propagates
     from `R₁` to `R₁ + ρR₁` over K).
5. **The poser's citation graph.** `[AbrishamiEtAl2025]`'s reference list was walked for the relevant entries:
   `[CarrollPenland2015]` (strongly periodic groups), Piantadosi 2008 (free groups not strongly periodic), Cohen 2017
   (strongly aperiodic SFTs), Esperet–Giocanti–Legrand-Duchesne 2024 (the domino problem on minor-excluded graphs, the
   origin of Problems 1.1–1.2), and Timár 2011 (Question 4.8, planar 4-colourings). Its only citing work found is
   `[Waite2026]` (by web search).
6. **Every citing work in the neighbourhood opened.** `[Waite2026]`: abstract and §1 read. It covers planar 1-ended graphs,
   with a periodic colouring always existing and five colours in the Euclidean case. It does not reach our non-planar
   lattice graphs.
7. **Two databases.** OpenAlex: `[AbrishamiEtAl2025]` is recorded with **0** citing works, which is wrong by at least
   `[Waite2026]`. Semantic Scholar: HTTP 429, not read. **The cross-check did not complete, and the plan says so**. The
   close re-runs it (P6).
8. **Author listings, in their vocabulary, in zbMATH.**
   - Chandgotia (18 entries; hom-shifts, frozen colourings, pivot property), Lightwood (4), Burr (the undecidable ones),
     Esperet and Hamann (with "periodic"/"coloring": 1 each, the paper itself), Radin (2).
   - Abstract searches in their words: "hom-shift", "dense periodic points", "strongly irreducible", "domino problem",
     "Wang–Swendsen–Kotecký", "frozen".
   - One vocabulary lesson: `[AlonEtAl2021]`'s abstract search returned 0 because the API withholds its summary. The paper
     was found by author listing and by the FS-70 pointer, not by abstract.

### §PA.2 Queries and hit counts (zbMATH Open API, 2026-09-23)

| query | hits | what was relevant |
|---|---|---|
| `ab:"periodic points" & ab:"shift of finite type" & ab:"dense"` | 2 | Robinson–Şahin 2001 (review); adjacent |
| `ab:"dense periodic points" & ab:"subshift"` | 7 | none on colouring shifts |
| `ab:"strongly irreducible" & ab:"periodic points"` | 2 | **`[Hochman2025]`** (summary): strongly irreducible ℤ² systems with no periodic point |
| `ab:"hom-shift"` / `ti:"hom-shifts"` | 1 / 2 | `[ChandgotiaMarcus2018]`, `[GangloffEtAl2026]` (withheld) |
| `ab:"proper colorings" & ab:"shift of finite type"` | 0 | — |
| `ab:"periodic coloring" & ab:"Cayley graph"` | 0 | — |
| `ab:"periodic tiling conjecture"` | 11 | **`[GreenfeldTao2024]`** (review) |
| `ab:"periodic graph" & ab:"undecidable" & ab:"color"` | 0 | — |
| `au:"Burr, Stefan A." & ab:"undecidable"` | 2 | **`[Burr1984]`** (review) |
| `ab:"twelve tiles"` | 0 | (GJKS's term; their Memoir found by the next query) |
| `ab:"continuous chromatic number"` | 3 | Gao–Jackson–Krohne–Seward, *Continuous combinatorics of abelian group actions*, Memoirs AMS (2025; withheld) |
| `ab:"Kempe equivalence" & ab:"infinite"` | 1 | edge-Kempe classes; no |
| `ab:"domino problem" & ab:"Cayley graph"` | 4 | EGLD 2024 (withheld) |
| `ab:"domino problem" & ab:"coloring"` | 5 | Kari–Moutot (low-complexity tilings; withheld) |
| `ab:"graph homomorphisms" & ab:"subshift"` | 3 | textile systems; no |
| `ab:"frozen" & ab:"colorings" & ab:"lattice"` | 0 | (the paper exists; summary withheld — see item 8) |
| `au:"Chandgotia, Nishant"` | 18 | **`[AlonEtAl2021]`**, Chandgotia 2017 (pivot property; summary read), `[ChandgotiaMarcus2018]` |
| `au:"Lightwood, Samuel"` | 4 | `[Lightwood2003]` (reviews) |
| `ab:"chromatic number" & ab:"distance graph" & ab:"periodic"` | 4 | **`[EggletonErdosSkilton1990]`** (review); Cervantes–Krebs 2025 |
| `ab:"Kempe chain" & ab:"infinite"` | 0 | — |
| `ab:"unit distance graph" & ab:"lattice" & ab:"coloring"` | 0 | — |
| `ab:"unit distance" & ab:"forced" & ab:"color"` | 0 | — |
| `ab:"periodic colorings" & ab:"lattice"` | 1 | `[VallentinEtAl2025]` (withheld) |
| `ab:"colorings" & ab:"periodic" & ab:"aperiodic" & ab:"graph"` | 1 | no |
| `ab:"periodic chromatic number"` | 0 | — |
| `ab:"integer distance graph" & ab:"period"` | 1 | Cervantes–Krebs 2025 |
| `ab:"Cayley graph" & ab:"abelian" & ab:"periodic" & ab:"coloring"` | 1 | Silva 2022 (HNN extensions; no) |
| `ab:"lattice" & ab:"coloring" & ab:"periodic" & ab:"Z^d"` | 2 | **`[PeledSpinka2023]`** (withheld; vocabulary collision "rigidity") |
| `ti:"distance graphs" & ab:"lattice" & ab:"chromatic"` | 4 | `[ChilakamarriMahoney1996]` (review; negative) |
| `au:"Krebs, Mike" & ab:"periodic"` | 1 | Cervantes–Krebs 2025 |
| `ab:"aperiodic" & ab:"subshift of finite type" & ab:"coloring"` | 0 | — |
| `ab:"uniquely colorable" & ab:"infinite graph"` | 0 | — |
| `ab:"periodic" & ab:"coloring" & ab:"domino problem"` | 2 | Kari–Moutot |
| `ab:"Cayley graph" & ab:"k-colorable" & ab:"decidable"` | 0 | — |
| `ab:"aperiodic" & ab:"proper coloring"` | 0 | — |
| `ab:"strongly aperiodic" & ab:"coloring"` | 2 | Aubrun–Barbieri–Thomassé 2019 (review): aperiodic subshifts on groups |
| `au:"Esperet, Louis" & ab:"periodic"` | 1 | **`[AbrishamiEtAl2025]`** (zbMATH 1581.05075) |
| `au:"Hamann, Matthias" & ab:"coloring"` | 1 | the same |
| `ab:"strongly periodic" & ab:"shift of finite type"` | 0 | — |
| `ab:"antiferromagnetic Potts" & ab:"zero temperature" & ab:"periodic"` | 1 | Salas–Sokal 2001 (transfer matrices) |
| `ab:"Wang-Swendsen-Kotecky"` | 10 | **Mohar–Salas 2009** (*a new Kempe invariant*; withheld), Salas–Sokal 2022 (WSK ergodicity on tori), **Moore–Newman 2000** (four-state triangular Potts antiferromagnet, height representation; withheld) |
| `au:"Radin, Charles" & ab:"periodic"` | 2 | Radin 1986 (review): ground states tend to periodicity "in an average sense" in 2D/3D |
| `ab:"ground state" & ab:"periodic" & ab:"lattice" & ab:"undecidable"` | 0 | — |
| `ab:"voltage graph" & ab:"derived graph" & ab:"components"` | 0 | (Gross–Tucker's theorem is textbook; not in zbMATH abstracts) |
| `ab:"Kempe" & ab:"Potts"` | 3 | Mohar–Salas 2009; Bonamy–Bousquet–Feghali–Johnson 2019 |

Web: two searches, which found `[AbrishamiEtAl2025]` (arXiv:2411.01951) and `[ChandgotiaMarcus2018]`. Pages fetched:
arXiv:2411.01951, arXiv:1607.08357 (abstracts), then the three PDFs in §PA.3.

### §PA.3 What the gate found, and what it does to the plan

- **C3-aper is a posed, open question in graph theory** (`[AbrishamiEtAl2025]` Problem 4.6). It stays a named side
  question, and FS-72's rank-8 lattice is its local instance. A new stub at the close (P6).
- **No general SFT theorem will prove C3-inherit.** ℤ² SFTs can be aperiodic (Berger; `[GreenfeldTao2024]` in tiling form),
  strongly irreducible systems can lack periodic points (`[Hochman2025]`), and colouring periodic graphs is undecidable
  (`[Burr1984]`). A proof must use the lattice's arithmetic or geometry. A counterexample in the abstract class (Cay(ℤ^r, S),
  arbitrary S) is plausible from these encodings, and would say the geometry must enter. §C invites both.
- **The rank-1 shadow is decidable and positive for existence** (`[EggletonErdosSkilton1990]`). §C offers it as a
  laboratory: C3-inherit on distance graphs of ℤ is a finite-automaton question.
- **"Rigid" collides.** The discipline's word for our property is *frozen* (`[AlonEtAl2021]`); `[PeledSpinka2023]`'s
  "rigidity" is another notion. The close must not publish "rigid" unqualified (P6).
- **Statistical mechanics owns Kempe classes on tori** (Mohar–Salas 2009), i.e. Kempe classes of periodic colourings.
  That is FS-2's territory and a P4 reading. Moore–Newman's height representation of four-colourings of the triangular
  lattice is the physics form of MASCOT-T10's striped colourings (§C "things worth knowing"). Both are listing/withheld;
  P3's competitors may fetch them.
- **Nothing found anticipates** FS-70's screens, the voltage form of the Kempe component on a lattice, or the arithmetic
  classification of rigid lattices (T9). They stay ours.
- **Owed at the close:** read `[PeledSpinka2023]` enough to state the collision exactly; re-run the Semantic Scholar check;
  fetch Mohar–Salas 2009 if P4 uses Kempe classes on tori.

---

## §S. The subplan

### §S.1 Routes, in one table

| question | route | why this one (against the alternative named) |
|---|---|---|
| (1) C3-inherit | a **derivation competition** (G51) on the re-posed question, briefed from §C, **after** a census that supplies informative instances | Against running the competition first (Poros is warm now): the only positive instance is uninformative (§0), so competitors would derive against a single case where the conclusion holds for another reason. A census that exhibits even one H1-found target with forcing undecided, or one candidate counterexample, gives both sides something to break |
| (1′) C3-aper | named, briefed as optional, not a phase | a posed open question in graph theory (`[AbrishamiEtAl2025]`); nothing in FS-73 needs it; FS-72 holds its instance |
| (2) classification | the screens of P1 run per field and per quartic CM subfield, with the three new columns (spectral, target vs quotient, composite) | against T9's arithmetic-only table: retraction 2 shows the arithmetic reads the target, not the quotient, and composite periods escape any prime-by-prime column |
| (3) rank 6 | first Poros's composite-period card (P1g, minutes), then a mechanism reading of `NΛ/V` on every rank-6 lattice held | against "what decides the index": R3 shows membership, not index, decides |
| kernel | burn down §K's leaves (T2, T6, T10's escape, R1, R3) | against deferring (FS-2): the escape direction and R1 are what any FS-73 theorem would cite, and T6 is already proved in the skeleton |

### §S.2 The phases

*Every phase carries these standing items. They are not repeated per row.*
- **One heavy job at a time**, under the shared lock `…/scratchpad/locks/heavy.lock`, for any build, solver or numerical
  job over ~2 minutes or ~8 GB.
- Commits by explicit path.
- Kill by pid or pgid, verify by effect.
- On any unexplained crash, halt and tell the product owner.
- No agent spawns agents: delegation is one level deep, because staffing is Kooshi's budget decision and review needs
  every agent known.
- Every phase record opens with **"Theorems this phase proved"**, each one line with its grade and proof address.
- Every run over ~15 minutes checkpoints at each verdict and resumes by re-running with `--resume`.
- Checkpoints live under `data/fs73/`, never `build/`.

| phase | who | what, and the instructions §G extracted into it | budget · stop rule | checkpoint · resume · what a kill redoes |
|---|---|---|---|---|
| **P0** | planner | **done**: de Grey's lattice spectrum (§R0) | — | `data/fs73/phase0/` |
| **P1a** | implementer A | `tools/fs73_lattice.py`, a field-generic lattice layer: `E = ℚ(√a,√b)(i)`, `ℚ(√d)(i)` or K(i); generators → HNF lattice → **saturation to denominator `D`** (complete `U`, priced first by M63H2-T6's shell count); integer coordinates; the lattice's point group and the Galois automorphisms preserving it (G27, M62-T4). Controls reproduce FS-70's numbers: de Grey's 54 / rank 4 (G8, row 46, the owner's construction), Λ′'s 46, L3's 42, and ℚ(√11)'s 108-vector shape (row 74). Python workers use the fork context | ≤ 3 h; stop when the four controls reproduce | none needed (minutes) |
| **P1b** | A | `tools/fs73_screen.py`, the screens as one driver, reusing `fs70_periodic_kempe`'s algorithms: **(i)** the lattice spectrum `m(Λ)` and each quotient's minimum, reproducing §R0 exactly; **(ii)** at every admissible `N ≤ 12` (5 and 7 always): quotient colourability with a pinned clique (triangle iff `√3` in the field, G57) and colour precedence. **The gap-aimed finder first** (G13, G68), then `sep`-aimed finders per target, then T10 on every colouring found. **Escapes report the period `W′` of the re-periodised separating colouring** (R3, from the Smith form of `NΛ/V`), never the index, and are re-verified on the saturated graph (G31, T10.6). **(iii)** The additive screen as the `N = 2, 4` slice (G38, M56-T1, FS25-T4); `1/2 ∈ Λ` ⟹ empty (row 50). Controls: Theorem B's colouring (N = 2) and `[Fischer1994]`'s ℤ/4 colouring (N = 4) on de Grey's lattice are verified as solutions (G41, row 57); L1's gapped `N = 5` colouring is found (T6 plant); `fs70_periodic_kempe selftest --plants` passes | ≤ 4 h; stop when every control passes | none |
| **P1c** | A | The two-instrument cross-check on de Grey's lattice at N = 8, 10, 12. Instrument one: the gap finder (a second encoding and a second solver). Instrument two: Harder's forces refusal on the 23,083-point ball. **Uninformative outcome (expected):** they agree, no gap. **Informative:** a gapped colouring, which falsifies one instrument. **Not** a test of G54's middle case (§X) | ≤ 1 h | none |
| **P1d** | A | **The H1 census over K: compute the sandwich `F_known ⊆ F ⊆ P ⊆ P_found`** (§0, "The normal form"). This is Poros's spec fix (§X 14), corrected at A1 and at the modeling stage. Four steps. **(1) `P_N` exactly, at N ∈ {2, 4, 6, 8, 10, 12}**, by a counterexample-guided loop over generators. The first guess is the common periods of the colourings found at `N`. For each generator `g` of the guess modulo `NΛ`, make one SAT ask on the quotient, clique-pinned and with colour precedence, adding the constraint `c(0̄) ≠ c(ḡ)`. SAT returns a new colouring, which shrinks the guess. UNSAT confirms `g`. Stop when every generator is confirmed; the guess is then `P_N`. At rank 4 this is a few dozen asks per `N`. **(2) `KPer(c)` for every colouring `c` found.** First read `c`'s true period group, checked on `Λ/NΛ`. Then compute the voltage group `V_Q` of *every* component `Q` of every two-colour quotient subgraph, at all six colour pairs; FS-70 computed only the origin's component. `KPer(c) = ⋂_Q V_Q`. **(3) Form `P_found = ⋂_N P_N ∩ ⋂_c KPer(c)` and `F_known`.** `F_known` is the span of the certified forced vectors' orbits under the automorphisms fixing 0: ζ₆, complex conjugation, and the Galois flip √−11 ↦ −√−11 (G27, M62-T4). Compute both by exact HNF. **Targets are vectors, never distances**: "8/√3" is `(8/3)(1+ζ₆)`, coordinates `[24,0,24,0]`, already in `F_known`. For each of `F_known` and `P_found`, report its rank and the invariant factors of Λ modulo it. Also report the structure `ℤ^m × T` of `P_found / F_known`. At K, `F_known` should have rank 2: the transport orbit of 8/3 spans only `(8/3)ℤ[ζ₆]`, because ρ is not a multiplier of Λ (ρ³ ∉ Λ, checked on the lattice's coordinates). **(4) The informative-instance list.** It is a finite generating set of `P_found` modulo `F_known`. (i) If `rank P_found = rank F_known`, the quotient is finite: make one forcing ask per nontrivial coset, at a short representative (§0, consequence 2). (ii) Otherwise the quotient is `ℤ^m × finite`; at K, `ℤ² × finite` is expected (§0, consequence 4). Make one forcing ask per *short* generator, and one per short vector of `P_found ∖ F_known` within the askable Minkowski radius, up to translation by `F_known` and the automorphisms. (iii) Some generators are forced only because they lie in the periods searched: in `lcm(N)·Λ`, or in a voltage group bounded by `NΛ`. They are artifacts of the search, and they are Minkowski-long: a vector of `27,720·Λ` is about 10⁴ times Harder's radius in both embeddings (Poros, §X 20). No ball can ask them. Decide those directions by extending the period search (P1d′), and report whether `P_found` shrinks toward `F_known`. (iv) If the true `P` has finite index, C3 at K holds exactly when `F` has full rank, and a rank-2 `F` is a counterexample at K (§0, consequence 3). **Ask discipline.** Use Minkowski balls aimed at average degree ≥ 14 by G65's law, never word balls. Ask on their `k+1`-cores (M55-T4, M63H4-T2/T3). Use cubes on a pinned pigeonhole when monolithic CDCL caps (G18). Switch to growth mode after the first undecided radius (G33). Use M53-T12's no-finite-extension certificate wherever it applies (G36). Check every refusal for an empty critical set (G39, M54-T1). **Controls.** Positive: Harder's 8/3 refuses; reproduce 2.7 s at 23,083 points. Negative: the vectors 2 and 4 lie outside `P_found`, with their separators exhibited. On the subgroup computation: assert `F_known ⊆ P_found`; a planted colouring that separates a known generator must shrink the guess; the loop, re-run from an empty found set, reproduces `P_N`. Register row 67's P-D3 coset by coset (§P). | ≤ 5 core-h; ≤ 1,500 s per ask; stop per target after 3 radii or 3 undecided asks | `data/fs73/census/K-rows.jsonl`, one row per verdict; `python3 tools/fs73_screen.py census K --resume` skips rows present; a kill redoes the one ask in flight |
| **P1d′** | A | **The period extension. Does `P_found` stabilise? This is the census's decisive quantity** (A2). It repeats P1d's steps (1)–(3) one period at a time. Periods are taken in order of the quotient's class count `N⁴`, admissible `N` only (`9 ∣ N` is inadmissible, since `1 ∈ 9Λ`): the 2-power periods 16 and 32; the `3·2^k` periods 24 (and 48 if affordable); and the composite and prime-power periods built from K's refusing primes 5, 7, 11, 13, namely 14, 15, 20, 21, 22, 25, 26, 28, 33, 35. Why the composite periods: a quotient at a composite or prime-power `N` is only a diagonal subgraph of its local targets' product. A colouring at a prime quotient pulls back to it, but a refusal there does not push up, so it can colour where every prime refuses (G59, the composite column's reason). Ask each period for colourability first. After each period is added, write one row: `P_N`, the `KPer` of each new colouring, **`P_found`'s rank and invariant factors, and the structure of `P_found / F_known`**. **Outcomes.** (a) `rank P_found` falls to `rank F_known`: the quotient is finite, and P1d's step (4)(i) closes it coset by coset. (b) `P_found` plateaus, unchanged across three consecutive *colourable* periods, with rank above `F_known`'s: K becomes a counterexample candidate (§0, consequence 5; P-C4, P-C5). (c) **Uninformative, declared and reachable**: `P_found` shrinks at every colourable period through the budget, with no plateau and no rank drop. It says only that the colourings found are not yet representative. It is reachable: the voltage groups' index in `NΛ` already varies (1, 2, 4) across `N ≤ 12`, and each new colourable 2-power period can supply new Kempe structure. **An UNSAT period counts as no step.** It adds nothing to `P_found`. It is reported but not counted toward a plateau, because a run of UNSAT periods is a vacuous stabilisation. | ≤ 8 core-h; ≤ 1,500 s per ask; skip any `N` whose CNF would exceed 40 GB RSS at the measured bytes per clause (price `N = 32` by a dry build of its CNF first); stop at outcome (a), at outcome (b), or at the budget | `data/fs73/census/K-periods.jsonl`, one row per `(N, ask)` verdict, with the guess's generators before and after; `P_found` is recomputed from the rows, never stored alone; `python3 tools/fs73_screen.py periods K --resume` skips rows present; a kill redoes the one ask in flight |
| **P1e** | A | **The rich 2-unit lattices over ℚ(√3,√5)** (`twounits:14/30/42`), rigid under FS-70 only on generator graphs at `N ∈ {2,4}` plus the 48 additive colourings (T8). **First** the gap-aimed finder at `N = 5, 7` (P-M2's live half; a gap closes them by T6). Then saturation, priced first; if unaffordable, every row is labelled "generator graph". Then forcing asks at the five depth classes (FS70-T1/T7), P-D3 in view. **Every lattice's row reports the sandwich (§0): the ranks and invariant factors of `F_known` and `P_found`, with the periods searched.** A gapped colouring makes `P_found = 0`, and then `F = P = 0` by T6 | ≤ 3 core-h; ≤ 1,500 s per ask; stop per target as P1d | `data/fs73/census/rich-rows.jsonl`; `python3 tools/fs73_screen.py census RICH --resume`; a kill redoes the one ask in flight |
| **P1f** | A | Census record `data/fs73/census/README.md`. **Its headline is one sandwich per lattice**: the ranks and invariant factors of `F_known` and `P_found`, the structure of `P_found / F_known`, and P1d′'s stabilisation series at K. Below that, every row gives the lattice, whether its graph is saturated or generators-only, `N`, the finder, the verdict, the target *vector*, `W′`, seconds and machine (G21). The **informative-instance list** holds two kinds of vector: those in `P_found ∖ F_known` whose forcing is undecided, and those forced where H1 was established by another route. If K's `P_found` plateaus above rank 2, K itself heads the list as a counterexample candidate. **Written for the reviewer** (§ The standard of evidence: *what must someone who trusts none of this check?*). Each number carries what it measures: for example, "`P_found` over the colourings found at `N ∈ {…}`", never a bare "rigid". Every group is given by integer generators in the lattice's stated basis, so it can be re-derived by hand or in PARI. A frozen standalone checker, `tools/fs73_census_check.py`, reads only the committed rows and the lattice file, and re-verifies the evidence in order of marginal value: (i) every exhibited periodic colouring is proper on its quotient and has the stated periods, which alone makes `P_found` a sound upper bound for `P`; (ii) every `KPer` is recomputed from its colouring; (iii) `F_known`'s generators trace to certified refusals (Harder's is `data/fs70/harder-control/`); (iv) last, the UNSAT confirmations behind "`P_N` exactly", which are solver claims, recorded with their CNF hashes. (iv) is the only step that trusts a solver, and a reviewer can skip it without losing the sandwich's soundness. **Uninformative outcome, declared and reachable:** every target is known-forced, escapes, or is undecided at every radius afforded. Then the competition is briefed with that negative list, which is itself §C content | — | — |
| **P1g** | A | **Poros's card** (P-R1): on L3's `N = 2` colouring, the Smith form of `V` in `2Λ`, the escape at each target, the re-periodised colouring's period, and whether it is constant on the cosets of `2Λ` or of some `3^jΛ` | ≤ 30 min | none |
| **P2** | A (if < 300k tokens), else a fresh B | **The classification.** Rows: **K** (control), **ℚ(√3,√5)** (control: reproduce T5's six-subfield table), **ℚ(√3,√23)**, **ℚ(√3,√47)** (FS-48), **ℚ(√11) at k = 3** (positive control, row 73), **ℚ(√167) at k = 3** (FS-59's question), **one CM subfield of K(√7) at k = 5** (the pilot for six: G48, row 64). Columns per quartic CM subfield `E` and saturated lattice `Λ_D` (D ∈ {6, 12, 24}, priced): (a) the 3-adic pole (FS70-T3, row 45); (b) the 2-adic column, 2-unit or wall-broken, with C1 as a sub-column (G1, G35, G56, M53-T5, FS54-T2, row 63, M58-T3); (c) **spectral**: `m(Λ)/d` against `−1/(k−1)` and the minimisers' torsion orders (FS38-D2-A, FS53-T1, FS54-T7); (d) per admissible `N ≤ 12`: colourable or refused, gapped, with **target and quotient spectra kept apart** (G44, R52-T1, M58-T1, M61-T2); (e) **composite**: `N` a product of two primes whose single-prime quotients both refuse. The quotient is a diagonal
  *subgraph* of the product of the two targets, so neither factor's refusal nor a product theorem decides it: computed
  (G59, FS58-T3's shape without its infinite-`U` identification); (f) T10 at the **chainable** targets `1/δ ∈ ℤ[U]` (ASTRA-T2, G55). **Verdict, in the subgroup form (§0):** the ranks and invariant factors of `F_known` and `P_found`, with the periods searched, and where each chainable target sits. A target is *loose by theorem* if it lies outside `P_found`; a gap makes `P_found = 0`. It is *rigid-found* if it lies in `P_found ∖ F_known`, and *forced* if it lies in `F_known`. A lattice with no periodic colouring at any `N` searched is *refusing*, which is C3-aper's case. Lattices are chosen per field by supply, never carried between fields (FS61-T3, row 74). Ramified targets' first levels are impotent (FS66-E), and every spectral column is blind to the carry (FS66-T); both are stated in the table's header | ≤ 8 core-h; ≤ 300 s per quotient ask | `data/fs73/table/rows.jsonl`; `python3 tools/fs73_screen.py table FIELD --resume`; a kill redoes one ask |
| **P3** | competitors "de Bruijn" and "Coxeter" (fresh Opus 5.5 each) + advisor "Poros" (fresh, or this one if its context allows; the PO decides) | **The competition on C3-inherit**, under `plans/PROTOCOL-competitor-and-advisor.md`: briefs from §C with the census and table pasted in, identical but for the names; isolated scratchpads; teasing hints only; prior art shared; retractions counted by the advisor. **Deliverable** (the PO's ruling, 2026-09-23): a theorem or a counterexample. If neither lands, the headline is **"not landed"**, and under it, each reported as exactly what it is: **(a)** the sharpened reductions; **(b)** the K instance explained by its local lemma (G70, `[Polymath16wikiR2]` Cor. 9) or the statement of why not; **(c)** a sufficient condition (a class of lattices where C3-inherit is proved); **(d)** the census's candidate list, including any counterexample candidate. A theorem's key step is re-derived by the other competitor or by the advisor, and one step by the PO. A counterexample is an explicit construction with proof, plus exact verification of properness and separation on a large finite window | ≤ 400k tokens per competitor; one working session each (≤ 8 h wall); stop when both report | each competitor keeps `plans/FS73-C3-<name>.md` current at every claim or retraction; a killed competitor is replaced by a fresh one reading its file; a kill redoes the thinking in flight |
| **P4** | implementer (A, B, or fresh C) | **Rank 6, re-aimed** (question 3). P1g's answer first. Then for L2, L3, L6 and any rank-6 K-lattice (de Grey's lattice with one ρ₁₅ word, if rank 6): `NΛ/V` for *every* Kempe component (not only the origin's) under every periodic colouring at `N ≤ 6`, hence each colouring's `KPer(c)` and the lattice's `P_found` in the normal form (§0), the targets' images, and the re-periodised separators' periods. Read against: C2 and the cross-set closed forms (MASCOT-T7, M63H3-T1, M31-T1, M32-T1, G12, G14); the bilayer as a Σ = n coincidence rotation (G7, G62, M63H2-T1, M63H3-T7/T8); the additive slice at `4 | n` (row 65, M63H3-T4); and Poros's reading that `[NΛ:V]` is an ideal norm (P-R2). Residue targets never force (row 60), so any rank-6 forcing is composite or 2-adic. Deliverable: a mechanism statement (hand) or a typed null. **T10.2's "the deciding invariant" is re-worded at the close** | ≤ 4 core-h; ≤ 250k tokens; stop when every rank-6 lattice held has its `NΛ/V` table at `N ≤ 6` | `data/fs73/rank6/rows.jsonl`; `python3 tools/fs73_screen.py rank6 SPEC --resume`; a kill redoes one lattice-period pair |
| **P5** | implementer K (Opus 5.5) | **The kernel**: every `sorry` of `Proofs/HadwigerNelson/Kempe.lean` (§K), burned down in the order and by the routes of §M.2's table (children first; R1 by `Finset.rado_selection`; R3 last, over its children; the residual-finiteness instance priced at ½ day). Query Mathlib by shape before writing (the Searching rules; FS58-T4's note missed `Finsubgraph.lean`). The residual-finiteness step of `not_periodicForces_of_voltageEscape` may need the structure theorem (`AddCommGroup.equiv_free_prod_directSum_zmod`) or a Smith-form argument; price it before starting and report if it exceeds a day. `voltageEscapeZ` must be fully proved (vacuity: every structure-typed hypothesis has a named inhabitant). No statement changes without the planner's re-check | ≤ 2 working days; ≤ 400k tokens | the file itself; every `./scripts/build.sh` run is a checkpoint; a kill redoes the current leaf |
| **P6** | planner (fresh) | **The close** (WORKFLOW 9): `plans/FS73-derivation.md` and `LEDGER.md` § B lines; row 78; the §G re-read; new grokkings in G67's form; P1–P4's predictions scored. Corrections: G69 (745 against 23,083 and "three orders"); FS58-T4's kernel note and FS-39 phase A (Mathlib holds the compactness lemma); T10.2's wording; "rigid" qualified against `[PeledSpinka2023]` and `[AlonEtAl2021]`; the Semantic Scholar re-check. New stubs: C3-aper (`[AbrishamiEtAl2025]` 4.6 at ℤ^r); a `k = 5` rigidity table for 6-open fields if P2's pilot is informative; C3-local as a note on FS-67's stub (context, not a route: the finite-`U` quotient is a subgraph of the product) | — | — |

### §S.3 Acceptance checklists (what · verified how · pass condition)

| phase | what | verified how | pass condition |
|---|---|---|---|
| P1a | lattice layer | the four controls | de Grey 54/rank 4, Λ′ 46/rank 4, L3 42/rank 6, ℚ(√11) shape 108; saturation complete to `D` (a brute-force enumeration to `D` agrees) |
| P1b | screens | §R0 reproduced; Theorem B's and Fischer's colourings accepted as solutions; L1 gap found; FS-70's selftest plants all fire | every number equal; every plant fires; no control passes "for the wrong reason" (a paired faithful stub passes) |
| P1c | cross-check | the two instruments' verdicts | agree (the expected, uninformative outcome), or the disagreement is traced to one instrument |
| P1d | K census | rows file; `P_found` and `F_known` printed with generators, ranks and invariant factors, and `P_found / F_known`'s structure; the loop's three controls; the positive and negative controls | each `P_N` confirmed generator by generator (every generator's UNSAT on file); `P_found ⊇ F_known` checked; Harder's 8/3 refuses; 2 and 4 escape; every refusal has an empty critical set; every UNKNOWN is typed with its budget; no H1-found target is reported as forced without a refusal (M63D-T7: refusals carry only down) |
| P1d′ | period extension | `K-periods.jsonl`; one stabilisation row per colourable `N` | the outcome is (a), (b) or (c), named in the record; every plateau step is a colourable period; UNSAT periods are listed separately |
| P1e | rich lattices | N = 5, 7 gap finder rows; saturation stated per row | every verdict names its graph (saturated or generators) and its lattice's `F_known` / `P_found` ranks |
| P1f | census record; rows 22–24's explicit colourings checked for periodicity; the frozen checker | the PO reads the informative-instance list against the rows, and runs the checker cold | every listed instance traceable to rows; the checker re-verifies (i)–(iii) with no solver, and a planted improper colouring makes it fail; the uninformative outcome, if it happened, stated as such |
| P1g | Poros's card | Smith form printed; coset-constancy test on the swapped colouring, with a planted colouring that *is* 2Λ-periodic as the control | the answer is one of three, stated with the control's pass |
| P2 | table | T5 reproduced for ℚ(√3,√5); K has 8/3 ∈ `F_known`; ℚ(√11) has 3u ∈ `P_found` (k = 3) | the three controls pass; every row's verdict carries its periods searched, its lattice's saturation, and the ranks of `F_known` and `P_found` |
| P3 | competition | each report classified (theorem, counterexample, not landed); the verification steps above | a theorem survives the other side's re-derivation and the PO's one-step check; a counterexample's window check is exact; "not landed" lists (a)–(d) |
| P4 | rank 6 | rows file; the mechanism statement's proof or null | the null is typed; T10.2's re-wording drafted |
| P5 | kernel | `./scripts/build.sh`, `scripts/axioms.sh`, `scripts/vacuity.sh`, linters | zero `sorry` in `Kempe.lean`; axioms the standard three; `voltageEscapeZ` proved; vacuity counts updated in `CLAUDE.md` at the close |

### §S.4 Sequencing under the three-agent cap and one heavy job

*The PO is the top-level session and not counted. "Agent" means a spawned agent.*

| stage | agents live | phases | why this shape |
|---|---|---|---|
| now | planner, Poros (2) | this plan; then the modeling passes (step 6), by this planner or a fresh one | — |
| 1 | implementer A, implementer K (2) | P1 (A) ∥ P5 (K) | independent. The lock serialises A's solver asks against K's builds; P5 is short-build work |
| 2 | A (or fresh B), K (2) | P2 ∥ P5's remainder | P2 reuses P1's tools; K finishes |
| 3 | competitor ×2, advisor (3) | P3 | the cap is full; A, B and K must be finished or stopped at a checkpointed boundary. A derivation phase needs no heavy jobs, so the lock is free for the competitors' small exact checks |
| 4 | one implementer (1) | P4, then P6 (fresh planner) | P4 reads P3's outcome, which may re-aim it |

**Decision, in four parts.**
- **Choice:** census and classification before the competition.
- **Alternative:** competition first, while this Poros is warm and the derivation needs no compute.
- **Why:** the known positive instance is uninformative (§0), and P1–P2 can produce an informative one, or a counterexample
  candidate, in about two working days. That is cheaper than a competition deriving against nothing it can break.
- **Confidence:** medium. The fact that would change it: if P1–P2 run past three working days, start P3 with whatever
  rows exist, since §C's census slot accepts a partial list.

### §S.5 Stage 1: what to read first (letters to the two implementers)

*Stage 1 runs implementer A on P1 and implementer K on P5, in parallel. Each arrives with no memory of the planning. The
phase rows are the specification; these notes are the reading order that makes the rows self-sufficient. The PO's brief
carries the standing rules, with their reasons.*

**Implementer A: P1, the census (rows P1a–P1g, P1d′).**
1. `CLAUDE.md` from disk: § The standard of evidence above rung B, § Toolchain (the solver list and "break the symmetry
   before any SAT search"), § Building (the PROTECTED checkpointing paragraph, and kill by pid). `WORKFLOW.md` step 7
   ("Theorems this phase proved").
2. This plan, in this order:
   - §0 in full, especially "The normal form". The census computes the four nested subgroups
     `F_known ⊆ F ⊆ P ⊆ P_found`, and every verdict is stated in them.
   - §S.2 rows P1a–P1g and P1d′, with §S.3's acceptance rows.
   - §P's P-C1 to P-C5 (register nothing new without the PO).
   - §R0 (the phase-0 spectrum, which P1b must reproduce).
3. The FS-70 instruments you reuse, read as code, not as prose (G46):
   - `tools/fs70_periodic_kempe.py` (T10; its selftest plants; `records/phase-1e.md` §2 for the controls, §3.2 for de
     Grey's lattice, §8 for the big-endian and little-endian trap);
   - `tools/fs70_quotient.py` (quotient colourability, gap-aimed finder);
   - `tools/fs70_harder.py` with `data/fs70/harder-control/` (the positive control);
   - `tools/fs70_kempe_rich.py` and `data/fs70/records/phase-1e.md` §3.4 for the rich lattices.
   The data are `data/fs70/quotient/degrey-K-periodic-kempe.json` (V's rank and index per `N` and `b`, the numbers §0
   cites) and `data/fs73/phase0/`.
4. The derivations the tools rest on: `plans/FS70-derivation.md` T6, T9, T10; `plans/MASCOT-derivation.md` T6 (G70).
5. Your first commit is P1a's lattice layer with its four controls reproduced. Your first *finding* is P1d's step (3):
   the ranks of `F_known` and `P_found` at K.

**Implementer K: P5, the kernel (`Proofs/HadwigerNelson/Kempe.lean`).**
1. `DEBRUIJN.md` and `CLAUDE.md` from disk: § Building ("always `./scripts/build.sh`, never `lake build`", and why
   `lake env lean` is not the gate); § The gate (vacuity, named inhabitants); § The kernel's cost model; § Searching
   (query Mathlib by shape; `rg`, not `grep -E` alternation).
2. This plan: §K (the declaration table and the read-aloud list), then **§M.2's table, your agenda**. Each `sorry` has
   there the statement it derives from, a route and a price, and the order is children first, R3 last. §M.1 explains
   why the statements have the shape they have. **Change no statement without the PO's re-check.** A leaf that needs a
   statement change is a finding: report it (P-K1's informative outcome), do not route around it.
3. The existing API you build on:
   - `Proofs/HadwigerNelson/Forcer.lean` (`Forces`, `Forces.comap`);
   - `ResidueObstruction.lean` (`addCayleyTranslate`, `forces_iff_forces_zero_sub`, `not_forces_zero_of_not_periodic`);
   - `LocalGlobal.lean` (`addCayleyMap`, `addCayleyColoring`);
   - `FanGap.lean` (T6's pieces).
   From Mathlib: `Finset.rado_selection` (`Combinatorics/Compactness.lean`), `addCayley_adj'`,
   `AddGroup.ResiduallyFinite` and `AddCommGroup.equiv_free_prod_directSum_zmod`, `AddSubgroup.finiteIndex_of_le`,
   `Function.Periodic.add_period`.
4. The costliest leaf is `exists_finiteIndex_between_notMem`, priced at ½ day. If it passes one day, stop and report.
5. Done means: zero `sorry` in the file, `scripts/axioms.sh` shows the standard three, `scripts/vacuity.sh` is green
   with its counts reported, and the module is added to `Proofs.lean`. The vacuity counts in `CLAUDE.md` change only at
   the close; report them, do not edit.

---

## §C. The competition's brief: the slots of `plans/PROTOCOL-competitor-and-advisor.md` §4 and §5, filled

*To be pasted into two briefs identical except for `{NAME}` / `{OTHER}` ("de Bruijn" / "Coxeter"). Everything outside
these slots (the register, the hint protocol, "what is yours to decide", the two standing obligations) is the template's.
Three additions to the template, each with its reason:*
- *the one-level delegation rule, because a competitor that spawns helpers breaks the head-count and the review;*
- *the heavy-job lock, because the desktop cannot run two;*
- *the reminder that `CLAUDE.md` on disk is authoritative, because a spawned agent sees the parent's loaded snapshot.*

*Before pasting, the PO replaces the two bracketed slots `[CENSUS]` and `[TABLE]` with P1f's informative-instance list and
P2's rigid-found rows.*

### §C.1 "The mathematics you are standing on" (competitor brief)

The project attacks the Hadwiger–Nelson problem: how many colours the plane needs so that no two points exactly one unit
apart share a colour; the answer is 5, 6 or 7. Over a real field `F` the plane `F²` has unit vectors `z = x + iy`,
`x, y ∈ F`, `|z| = 1`. A **lattice** here is the ℤ-span `Λ ⊂ ℂ` of finitely many such unit vectors (rank `r`); `U = Λ ∩ S¹`
is its complete, finite set of unit vectors; `G = Cay(Λ, U)` is its unit-distance graph. A pair `(0, δ)` is **forced at
`k` colours** if every proper `k`-colouring has `c(0) = c(δ)`. That is `Forces` in
`Proofs/HadwigerNelson/Forcer.lean`, and forcing is the fuel of every lower bound this project builds (the spindle theorem,
`OneDefect.lean`; the chain theorem, `plans/ASTRA-2026-09-14-derivation.md` T5).

1. **The one known instance.** Over `K = ℚ(√3,√11)`, on de Grey's lattice `Λ = ⟨ζ₆^m ρ^n : |n| ≤ 2⟩`
   (`ρ = (5 + i√11)/6`; rank 4, 54 unit vectors), the pair `(0, 8/3)` is forced at four colours. This is **Harder's**
   (Polymath16, 28 April 2018): his smallest forcing subgraph has 745 points, our 588-point core is a smaller
   rediscovery (M56), and our control ball has 23,083 points and refuses in 2.7 s (`LEDGER.md` rows 47, 76;
   `tools/fs70_harder.py`, `data/fs70/harder-control/`).
2. **Periodic colourings and the screens.** A colouring invariant under a finite-index subgroup `W` is **periodic**. For
   `W = NΛ` it is a colouring of the finite quotient `Cay(Λ/NΛ, U mod N)` (kernel: `LocalGlobal.lean`, `addCayleyMap`,
   `unitQuadrance_colorable_of_quotient`). Two theorems close `Forces` from one periodic colouring:
   - **T6** (`plans/FS70-derivation.md`): a colour missing from one closed neighbourhood (a *fan gap*) frees every pair
     (`FanGap.lean`, row 66).
   - **T10**: the `(a,b)`-Kempe component `K₀` of `0` meets each class `x̄` of the quotient component `Q₀` in
     `p(x̄) + V`, `V` the voltage lattice. A target outside `K₀` (either `δ̄ ∉ Q₀`, or `δ − p(δ̄) ∉ V`) escapes. This is
     the periodic Kempe screen, `tools/fs70_periodic_kempe.py`.
   The kernel skeleton is `Proofs/HadwigerNelson/Kempe.lean`.
3. **Three reductions** (`plans/FS73-rigidity-dichotomy.md` §0):
   - **R1**: a finite ball forces `(0, δ)` iff the infinite graph does, by compactness. This is FS58-T4 at three colours;
     Mathlib's `SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom` gives it.
   - **R2**: with no periodic colouring at all, "every periodic colouring identifies the pair" is vacuous.
   - **R3**: "every periodic colouring identifies `(0, δ)`" (**H1**) is *equivalent* to "every periodic colouring is
     Kempe-rigid at `δ`". An escape re-periodises through a finite-index `W′ ⊇ V`, since `NΛ/V` is residually finite.
4. **Why the lattice over K is rigid, as far as it is understood.**
   - **G70 / MASCOT-T6** (`plans/MASCOT-derivation.md`; Coxeter, 2026-09-08): a four-colouring of the Moser lattice with no
     monochromatic `√3`-pair *is* one of Theorem B's two residue colourings. The hexagon lemma plus
     `R/2R ≅ 𝔽₄ × 𝔽₄` and the unique colourability of `K₄ × K₄`. So √3-clean colourings identify every `2R`-pair, 8/3
     included, and the √3-*dirty* ones are where anything else happens.
   - **`[Polymath16wikiR2]`** (`~/source/library/notes/polymath16-coloring-R2-2018.txt`): the renormalised colouring
     `ρ_z(a) = c(z+a) + a` over the Eisenstein lattice. Its colour classes are convex (Lemma 1). The three-valued case is
     periodic or **tri-sector**, a non-periodic colouring (Prop. 6). And `2R₁`-periodicity on `R₁` propagates to
     `R₁ + ρR₁` (Cor. 9): the one hand proof of a rigidity step over K.
   - **T9** (`data/fs70/owner/mechanism-periodic-colourings-2026-09-22.md`): the lattice's odd-period quotients at 5 and 7
     are the residue planes at 25 and 49, which refuse four colours. So its periodic colourings are 2-adic.
5. **What the spectrum does not do** (the planner's measurement, `data/fs73/phase0/`). As a lattice graph de Grey's lattice
   is Hoffman-*slack* at four colours (min eigenvalue −22.41 against −18). Its refusals at periods 5 and 11 are not spectral.
   No "tight ⟹ periodic" argument covers the one known instance.
6. **Where the hypothesis fails and forcing fails with it.** Over ℚ(√3,√5) every lattice FS-70 built (rank ≤ 6) has a
   periodic colouring that separates every chainable target (T6, T10, T11; row 76). The rank-6 L3 does so by Kempe
   escapes of index `[2Λ : V] = 81`.
7. **The corpus's non-periodic colourings of a lattice, the shapes a counterexample could take.**
   - Phase walls on `ℤ[ζ₆]`: striped colourings `c(m + nζ₆) = P_{n mod 2}[(m + φ_n) mod 2]` with a non-constant phase
     sequence. MASCOT-T10 case (ii), open; triple-based methods are blind to them (MASCOT-T11).
   - Tri-sectors (`[Polymath16wikiR2]` Prop. 6).
   - The strip automaton, whose colouring space grows ×12 per column (row 11).
   - The √3-dirty colourings of G70, whose periodicity nobody has examined.

[CENSUS]: *the informative instances from phase 1: lattice, target, periods searched, forcing verdict (or UNKNOWN with
budget).*
[TABLE]: *the rigid-found rows of phase 2.*

### §C.2 "The challenge" (competitor brief)

**Decide C3-inherit.** Let `Λ ⊂ ℂ` be a finitely generated additive group of unit vectors of a real field's plane,
`U = Λ ∩ S¹` (finite), `k = 4`, `δ ∈ Λ`. Suppose **(i)** some proper 4-colouring of `Cay(Λ, U)` is periodic, and **(ii)**
every periodic proper 4-colouring has `c(0) = c(δ)`. **Is `(0, δ)` forced**, that is, does some finite piece of
`Cay(Λ, U)` force it (equivalently, by R1, does every proper 4-colouring identify `0` and `δ`)? At one lattice and every
`δ` at once, the question is whether the H1 subgroup `P` equals the forced subgroup `F`. In the kernel it is
`InheritanceQuestion S k` in `Proofs/HadwigerNelson/Kempe.lean`: if a periodic colouring exists, then
`periodicForcedSubgroup S k ≤ forcedSubgroup S k`. State a theorem so that it could instantiate that `Prop`.

- **A theorem** proves it, for every such lattice or for a named class (a class-level theorem is fallback (c) below; say
  which you have).
- **A counterexample** is a lattice (or, first, any `Cay(ℤ^r, S)` with `S` finite, the *abstract class*) satisfying (i) and
  (ii), with a proper 4-colouring that separates `(0, δ)`. The colouring must be given by a rule with a proof that it is
  proper and separates. A search result is not a counterexample; a colouring rule found by search and then proved is. An
  abstract-class counterexample is a finding in its own right: it says the lattice's geometry or arithmetic must enter.
  Report it as exactly that.
- **The known positive instance proves nothing about the inference**: at 8/3 over K, hypothesis (ii) is known only
  because the conclusion holds. Instances where (ii) holds by another route are in [CENSUS], if the census found any.
- **The hard constraint**: this is a derivation. Exact computation to check something you derived is encouraged (sympy,
  exact rationals, the census tools on a small object, a `decide` in Lean). A new solver search over lattices is not part
  of this challenge: the census phase did the searching, and its rows are yours to use.
- **If the challenge as posed is subtly the wrong challenge, say so**: that is a finding, not a refusal.

**Things worth knowing before you choose a line**, all in the record:
- **The discipline owns the frame.** The colourings form a **ℤ^r subshift of finite type**. C3-inherit asks whether its
  **periodic points witness every two-site pattern**; density of periodic points suffices. No general theorem gives
  that: ℤ² SFTs can be aperiodic (Berger 1966; `[GreenfeldTao2024]` for tilings), strongly irreducible ℤ² systems can
  lack periodic points (`[Hochman2025]`), and colouring periodic graphs is undecidable from three colours (`[Burr1984]`).
  **Existence of a periodic colouring at all** is `[AbrishamiEtAl2025]` Problem 4.6, open for ℤ^d with d ≥ 2 (their
  Thm 5.2 proves it for virtually-ℤ groups). It is C3-aper, optional here.
- **The rank-1 shadow is decidable.** For distance graphs on ℤ, periodic optimal colourings always exist and aperiodic ones
  can coexist (`[EggletonErdosSkilton1990]`). C3-inherit there is a finite-automaton question, a laboratory for intuition,
  not a lattice.
- **Transport.** A forced pair at `δ` is forced at `gδ` for every automorphism `g` of `Λ`'s graph fixing 0: rotations by
  unit vectors `u` with `uΛ = Λ` and `uU = U` (G47, row 43), and Galois automorphisms that preserve `Λ` (G27, M62-T4). So
  forcing at `δ` makes **every** colouring periodic under the ℤ-span of the orbit `{gδ}` (the chain theorem's transport,
  ASTRA-T5, restricted to `Λ`). If that span has full rank, forcing makes the colouring space finite. This is two lines,
  offered as a thing worth knowing, not a result. **At K it does not have full rank.** ρ is not a multiplier of de Grey's
  lattice (ρ³ = (16/9)ρ − 5/3, and every lattice element's ρ-coefficient lies in (1/3)ℤ[ζ₆]). So 8/3's orbit spans
  `(8/3)ℤ[ζ₆]`, rank 2. Every colouring is periodic along that plane, and the effective shift at K is two-dimensional,
  where Berger/Robinson-type aperiodicity lives (Poros; checked by the planner).
- **Both sides are subgroups, and that is the question's normal form** (the plan's §0, "The normal form").
  - The forced set `F` and the H1 set `P` are subgroups of Λ, with `F ⊆ P`.
  - Each is an intersection of *Kempe period groups*, the translations that fix every Kempe component of a colouring: `F`
    over all colourings, `P` over the periodic ones.
  - So C3-inherit at a lattice, for every δ, is exactly `P = F`. It needs `rank F = rank P`. If `P` has finite index, it
    holds exactly when `F` does, that is, when every colouring is periodic.
  - Speak in vectors (cosets), never distances: "8/√3" on de Grey's lattice is the vector `(8/3)(1+ζ₆)`, already forced by
    transport.
- **K itself may be the instance under test.** [superseded: E2] The census reports four nested subgroups, `F_known ⊆ F ⊆ P ⊆ P_found`, at
  K. There `F_known = (8/3)ℤ[ζ₆]` has rank 2, and `P_found` has had finite index at every period searched.
  - If `P_found` stays of finite index as the periods grow, K is a counterexample candidate. Deciding it would take a
    non-periodic separating colouring of de Grey's lattice given by a rule.
  - If `P_found` falls to rank 2, C3 at K reduces to finitely many cosets.
  - [CENSUS] says which happened.
- **The gap between `F` and `P` splits in two, by invariant measures.**
  - Λ is amenable. Let `F_μ` be the set of `δ` to which every Λ-invariant probability measure on the colouring shift gives
    zero separation mass, `μ{c(0) ≠ c(δ)} = 0`. It is a subgroup, and `F ⊆ F_μ ⊆ P`: a periodic separator's finite orbit
    carries a uniform invariant measure.
  - **The walls half, `F = F_μ`.** By the **Furstenberg correspondence principle** (a Følner limit of a colouring's
    translates), it fails exactly when some colouring separates `(0, δ)` only on a set of zero upper Banach density. MASCOT-
    T10's phase walls and the tri-sectors are the corpus's shapes of that kind.
  - **The recurrent half, `F_μ = P`.** It holds whenever periodic-orbit measures are weak-* dense among invariant measures,
    because the separation event is a clopen cylinder.
  - In descriptive combinatorics' words: the periodic colourings are exactly the *continuous* colourings of the odometer
    (Λ acting on its profinite completion), and the measurable ones sit between. So C3-inherit is the compulsion analogue of
    "the continuous chromatic number equals the chromatic number" (Gao–Jackson–Krohne–Seward, *Continuous combinatorics of
    abelian group actions*, is the discipline's reference for ℤ^d).
  - The split is a restatement, not a result. A sharpened statement of this kind is fallback (a).
- **The 2-adic side is proved at the level of the local plane.** Every 4-colouring of the 2-adic tower of K(i) is pulled
  back from level 4 (FS38-D2-B, row 67). But row 67 registers **P-D3: no finite K²-graph forces 2-adic depth 4**, although
  the tower forces it. The local plane's forcing does not inherit at depth 4, and it does at depth 6 (8/3) [superseded: E4 — depth 3 per prime]. That depth
  split is data your answer must explain.
- **Local transfers can fail.** FS-66's Lemma W (`plans/FS66-tower-conjecture.md` §3.1): fibre shares of a level-two set
  leave level one's polytope, so no pointwise transfer works there. `U₃₂` (row 70) is completely rigid and forces nothing.
- **Statistical mechanics has the objects under other names**: zero-temperature antiferromagnetic Potts models; Kempe
  classes on tori (Mohar–Salas 2009, *A new Kempe invariant and the (non)-ergodicity of the Wang–Swendsen–Kotecký
  algorithm*); four-colourings of the triangular lattice via height functions (Moore–Newman 2000). Not read here; fetch them
  if your line needs them.
- **Reporting**, under the product owner's ruling (2026-09-23): the target is a theorem or a counterexample. If neither
  lands, report "not landed" and list under it, each as exactly what it is:
  - (a) any sharpened reduction;
  - (b) the K instance explained by its local lemma, or why the local lemma does not explain it. The expected shape is
    G15's pigeonhole × kill: Act One is G70's dichotomy, and the open work is the kill on the √3-dirty branch, whose
    material is M56's and M57's cores;
  - (c) a sufficient condition, a class of lattices where you proved C3-inherit;
  - (d) any candidate counterexample, and what deciding it would take.
- **Your working file** is `plans/FS73-C3-{NAME}.md`, current at every claim and every retraction, with retractions kept
  and marked. The advisor counts them, and zero means the disagreement has not started.
- **Standing rules**:
  - Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk (any copy in your context is the briefing session's
    snapshot).
  - Do not spawn agents (delegation is one level deep, because staffing is a budget decision and review needs every agent
    known).
  - Any job over ~2 minutes or ~8 GB takes the shared lock `flock -n <lock> <cmd>`, because the desktop cannot run two.
  - Your scratchpad is `{SCRATCH}`, and you do not read the other competitor's.
  - Your budget is about 400k tokens; stop at a clean boundary and report if the work outgrows it.

### §C.3 The advisor's slots (§5 of the protocol)

**"The situation"**, items: the object and the three reductions (§C.1 items 1–3 verbatim); the known instance and why it is
uninformative (§C.2's third bullet); the census and table ([CENSUS], [TABLE]); the "things worth knowing" on the
discipline, the subgroup form and K as the instance under test, the invariant-measure split, transport, the 2-adic depth split
and local-transfer failure.

**"The challenge"**: §C.2's first paragraph, verbatim, and the reporting rule with its four fallbacks.

**Keep "What I want from you" as the template has it**, with one addition: *"Count the retractions on both sides, with what
killed each; and before either competitor's first theorem is believed, ask the second question whose shape the first
could not have answered (the §10a rule of `plans/COXETER-2026-09-08-mascot.md`)."* If the PO reuses this stage's Poros
(`a20773e5a80987272`), its record `plans/POROS-2026-09-23-fs73-plan.md` §0 already holds its written expectation for C3. A
fresh advisor writes its own before its first message.

---

## §K. The Lean skeleton

`Proofs/HadwigerNelson/Kempe.lean`, not imported by `Proofs.lean` until P5 closes it. It is elaborated by
`./scripts/build.sh`.
- 2026-09-23, planner: build OK, 177/177 batches.
- 2026-09-23, after the domain pass: build OK, 177/177 batches, the module rebuilt, `sorry` only at leaves (15 warnings,
  all `sorry`), log `build/gate/build/20260923T061337Z-124350.log`.
- 2026-09-23, after the obligation pass: build OK, 177/177, 22 warnings, all `sorry`, log
  `build/gate/build/20260923T062152Z-144678.log`.
- 2026-09-23, after the experience pass: build OK, 177/177, 22 warnings, all `sorry`, log
  `build/gate/build/20260923T062646Z-161662.log`.

The domain pass (§M.1) put the H1 half into the subgroup normal form: `IsPeriodicUnder` and `PeriodicForces` were
replaced by `periods`, `IsPeriodic`, `forcedSubgroup` and `periodicForcedSubgroup`. Statements:

| declaration | kind | status | source |
|---|---|---|---|
| `KempeClosed C a b K` | def | — | T10's component, graph-generic |
| `kempeClosed_empty`, `kempeClosed_twoColour` | theorem | **proved** (the named inhabitants) | — |
| `kempeSwap` | def | `sorry` in the properness proof | T2/T10 |
| `kempeSwap_apply_of_mem`, `kempeSwap_apply_of_notMem` (`@[simp]`) | theorem | `sorry` | — |
| `not_forces_of_kempeClosed` | theorem | `sorry` | T2/T10's conclusion |
| `forces_iff_exists_finite` | theorem | `sorry` | **R1**, FS58-T4, Mathlib's `nonempty_hom_of_forall_finite_subgraph_hom` |
| `VoltageEscape π S D k` | structure | — | T10's data as a certificate |
| `VoltageEscape.lift`, `.zero_mem_lift`, `.kempeClosed` | def / theorem | `sorry` (two) | T10 |
| `not_forces_of_voltageEscape` | theorem | **proved from the leaves** | T10.1 |
| `forces_iff_of_quotient_fanGap` | theorem | **proved** (two lines over `FanGap.lean`) | **T6** |
| `not_forces_of_additiveKempe` | theorem | `sorry` | **T2** |
| `periods C` | def (`AddSubgroup`, carrier `Function.Periodic C`) | **proved** (closure from Mathlib's `Periodic.add_period`, `.neg`) | `Per(c)`, §0 |
| `IsPeriodic C` | def: `(periods C).FiniteIndex` | — | "periodic" with no existential over `W` |
| `forcedSubgroup S k`, `periodicForcedSubgroup S k` | def (`⨅` of `periods`) | — | **F** and **P** (§0); `P = ⊤` with no periodic colouring (R2) |
| `mem_forcedSubgroup`, `mem_periodicForcedSubgroup` | theorem | `sorry` | the bridges to `Forces … 0 δ` and to H1 pointwise |
| `forcedSubgroup_le_periodicForcedSubgroup` | theorem | **proved** | `F ≤ P` |
| `notMem_periodicForcedSubgroup_of_voltageEscape` | theorem | `sorry` | **R3** (escape direction) |
| `InheritanceQuestion S k` | def (a `Prop`, never a theorem): existence ⟹ `P ≤ F` | — | C3-inherit, normal form |
| `inheritanceQuestion_iff` | theorem | **proved** | C3-inherit ⟺ `P = F` |
| `voltageEscapeZ` | def | `sorry` in five proof fields | the named inhabitant of `VoltageEscape` (the fan-gap case on ℤ) |
| **the obligation pass's children** (§M.2): `kempeSwap_ne_of_mem_of_notMem`, `exists_coloring_ne_of_forall_finset`, `VoltageEscape.add_mem_lift_iff`, `periods_le_periods_comap_translate`, `ker_le_periods_comap`, `periodic_kempeSwap`, `exists_finiteIndex_between_notMem` | theorem | `sorry` | the statements the leaves derive from; routes and prices in §M.2 |
| `VoltageEscape.enlarge`, `isPeriodic_comap`, `notMem_periodicForcedSubgroup_of_ne` | def / theorem | **proved** | R3's engine (monotone in `V`), periodicity of a pulled-back colouring, one separator refutes H1 |
| four `example`s | spec | three `sorry`, one `rfl` | the escape at 2 on ℤ; the certificate's projection; **a periodic 2-colouring of the path ℤ** (the model of `InheritanceQuestion`'s hypothesis); **`2 ∈ F`, `1 ∉ F` on the path** (F is neither `⊥` nor `⊤`) |

**Read aloud against the informal claims.**
- `not_forces_of_voltageEscape` says: no graph on `A` with edges in `S` forces `(0, δ)` when `δ` lies outside the
  certificate's lift. That is T10.1.
- `forces_iff_of_quotient_fanGap` says: any graph with a homomorphism into the lattice graph has `Forces ↔ =` once one gapped
  quotient colouring exists. That is T6.
- `forces_iff_exists_finite` is R1.
- `InheritanceQuestion S k` is §C.2's challenge with `k` general, for every `δ` at once: if some colouring is periodic
  (hypothesis (i)), then `P ≤ F`. Per target the question is `δ ∈ P → δ ∈ F`. Hypothesis (ii) is `δ ∈ P`, which is H1
  by `mem_periodicForcedSubgroup`, and the conclusion `δ ∈ F` is "forced" by `mem_forcedSubgroup`.
- `notMem_periodicForcedSubgroup_of_voltageEscape` says: an escape certificate at a finite-index period produces a
  periodic colouring separating `0` and `δ`. That is R3's escape direction, stated as non-membership in `P`.

**Kernel decision:** the escape direction only; no "rigid" verdict has a kernel consumer. **The Kempe period group
`KPer(c)`, and R3 in its intrinsic form, are declined for FS-73's kernel, with this reason.** The intrinsic form is
`P = ⋂_{c periodic} KPer(c)`, that is, `P ≤ KPer(c)` for every periodic `c`. It needs Kempe *components* as a kernel
notion: the least Kempe-closed set containing a point, disjointness of components, and the stabiliser of a component.
Every tools-side use is covered by the certificate form, whose lift is given. Both identities are hand theorems for
`plans/FS73-derivation.md` (§0 states them):
- `F = ⋂_c KPer(c)`. It is two lines: swap on one component.
- `P = ⋂_{c periodic} KPer(c)`. It is R3 with components. The instances (Λ′, L6, L3,
FS-70's exhibitions) stay tools-grade unless P5 finishes early. Their price is a finite ball with an explicit escape, which
is FS-2's second target.

---

## §P. Registered predictions (each with both outcomes reachable)

| id | prediction | confidence | informative outcome / uninformative outcome |
|---|---|---|---|
| **P-Q1** | The competition's outcome on C3-inherit: **"not landed"** 0.60; counterexample 0.30 (most of it in the abstract class; in the geometric class 0.10); theorem 0.10 | — | Reachable: a theorem through a full-rank local lemma (G70-type propagation) is conceivable; an abstract counterexample through SFT encodings (`[Burr1984]`'s kind) is plausible; "not landed" is the default |
| P-S1 | (Poros) de Grey's lattice is Hoffman-tight at 4 with 2-power-torsion minimisers | — | **LOST** (§R0): slack, −22.41 |
| P-C1 | P1c: the gap finder and Harder's forces refusal agree at N = 8, 10, 12 | high | disagreement (one instrument defective) / agreement |
| P-C2 | P1d: every H1-found target on de Grey's lattice in the box has 2-adic depth ≥ 3 at both primes above 2 (8/3's depth), and every one asked is forced. No depth-2 target (4, 4/√3, …) is H1-found. P-D3's sibling | medium | an H1-found depth-2 target, or an H1-found target a ball does not force / as predicted |
| P-C3 | P1e, depth by depth with P-D3 in view: **(a)** a rich 2-unit lattice has a gapped colouring at N = 5 or 7 (0.55); **(b)** if not, the depth-4 targets escape under some odd or composite period; **(c)** 8/3 stays H1-found | medium / medium-low / low-medium | each part's opposite is reachable by the same run |
| P-R1 | (Poros) L3's escape colouring is local at neither 2 nor 3: not constant on the cosets of `2Λ`, nor of any `3^jΛ` | medium | local at one prime (T9's single-prime reading survives at rank 6) / neither |
| P-R2 | (Poros) `[NΛ : V]` is an ideal norm (81 = 3⁴), `V` being stable under the colouring's stabiliser in the multiplier ring | low-medium | a non-norm index or an unstable `V` / a norm |
| P-T1 | P2: K is the only field in the table with a rigid-found rank-4 CM lattice at k = 4 | medium-low | a second rigid-found lattice (which becomes a census instance) / only K |
| P-T2 | P2: ℚ(√167)'s lattices at k = 3 are loose by theorem at every chainable target | medium | a rigid-found ℚ(√167) lattice: FS-59's first informative object / loose |
| P-T3 | P2 pilot: the chosen CM subfield of K(√7) is loose at k = 5 (a gapped period colouring, the 5-colourable slack targets at 11 or 19 being the likely source) | medium | rigid-found at five colours / loose |
| **P-C4** | (Poros) At K the census finds `F_known` of rank 2 (the plane `(8/3)ℤ[ζ₆]`) and forces no vector outside it | medium | a forced vector off that plane, giving F rank 4: every colouring periodic, C3 at K trivial, fallback (b) at once; **or `P_found` stabilises at finite index while `F` stays rank 2: a counterexample candidate at K** (A1; §0, consequence 3) / F stays rank 2 and `P_found` keeps shrinking, so the effective shift is two-dimensional and C3 at K is open |
| **P-C5** | P1d′, the stabilisation series at K. Outcome (c), no stabilisation within budget: 0.50. Outcome (b), a plateau above rank 2 (a counterexample candidate at K): 0.25. Outcome (a), a rank drop to 2: 0.25 | low | (a) or (b) / (c). (c) is the uninformative outcome, and the modeling stage expects it most, because the voltage groups' index already moves with `N` at `N ≤ 12`. It is registered so that a plateau or a drop, if one comes, is read as evidence against a stated expectation |
| P-K1 | P5: every leaf closes within budget; the residual-finiteness step of R3 is the costliest | medium | a leaf that needs a statement change / all close |

---

## §M. The modeling passes (WORKFLOW 6)

*By a fresh de Bruijn (Opus 5.5), 2026-09-23. Order: domain, then obligation, then experience. Each pass was a fresh Skill-tool
invocation and has its own commit. Filled pass by pass below.*

### §M.1 Domain pass (`debruijn-domain-modeling`, fresh invocation)

**The model it converged on.** Both sides of C3 are subgroups of Λ. Each is an intersection of period groups (and of
Kempe period groups): `F` over every colouring, `P` over the periodic ones. The whole question is `P ≤ F`. Everything
else the milestone computes is an upper bound for `P` or a lower bound for `F`: `F_known ⊆ F ⊆ P ⊆ P_found`. The
convergence signal is that the statements shortened:
- `F ≤ P` is one line (`le_iInf₂`).
- "C3 ⟺ `P = F`" is one line.
- R3's conclusion needs one periodic colouring and one point, because non-membership in an infimum is witnessed by a
  single factor.

**What changed, and why.**

| change | the ugliness or the intrinsic fact that demanded it |
|---|---|
| **Skeleton: `IsPeriodicUnder C W` and `PeriodicForces S k δ` were replaced.** The replacements are `periods C : AddSubgroup A` (carrier `Function.Periodic C`), `IsPeriodic C := (periods C).FiniteIndex`, `forcedSubgroup S k := ⨅ C, periods C` and `periodicForcedSubgroup S k := ⨅ C (_ : IsPeriodic C), periods C` | The old H1 was `∀ W, W.FiniteIndex → ∀ C, (∀ w ∈ W, ∀ x, …) → C 0 = C δ`. That was a pointwise costume of a subgroup, with an existential period threaded through a hypothesis no consumer inspected. As an infimum, closure under sums and negatives comes free (no translation argument), and "periodic" loses its existential. R2 becomes visible as `P = ⊤`. It also reuses the corpus's predicate `Function.Periodic`, which `ResidueObstruction.not_forces_zero_of_not_periodic` already consumes, instead of minting a parallel `∀ w ∈ W, ∀ x` form |
| `InheritanceQuestion S k δ` became `InheritanceQuestion S k`: existence ⟹ `P ≤ F`. Also added: `inheritanceQuestion_iff` (⟺ `P = F`), `forcedSubgroup_le_periodicForcedSubgroup`, and the bridges `mem_forcedSubgroup` (to `Forces … 0 δ`) and `mem_periodicForcedSubgroup` (to H1 pointwise) | The PO's A3, and the fact that C3 at a lattice is one inequality between two groups. The per-target form is membership (`δ ∈ P → δ ∈ F`), so nothing is lost |
| R3 became `notMem_periodicForcedSubgroup_of_voltageEscape` (`δ ∉ P`) | Same statement in the normal form. The name follows Mathlib's `notMem_` convention: 130 declarations at our pin against 2 for `not_mem_` |
| `not_forces_of_additiveKempe` lost its hypothesis `φ δ = 0` | G30 mode 6: the hypothesis was narrower than the truth. The pair-sum closure lies in `ker φ`, so any `δ` off the kernel satisfies `hδ` and is separated by `φ` itself. The proof splits on the case, and the statement is stronger |
| Two spec `example`s: a periodic 2-colouring of the path ℤ (the model of `InheritanceQuestion`'s hypothesis), and `2 ∈ F ∧ 1 ∉ F` on the path | G30 mode 7 (the premise must be inhabited). The second guards the definitions against drifting to `⊥` or `⊤`. On the path, `P = F = 2ℤ`: the smallest instance where C3-inherit holds and is non-trivial |
| **Declined in the kernel**: `KPer(c)` and R3's intrinsic form `P = ⋂_{periodic} KPer` | They need Kempe components as a kernel notion. Every consumer is tools-side and covered by the certificate form. Both identities are hand theorems for the derivation file (§K) |
| Plan: the census computes `P_N` *exactly*, by a counterexample-guided loop over generators, and `KPer(c)` over *every* component (P1d, P1d′, P4) | FS-70's screen read only the origin's component, and only the colourings a finder happened to return. Its "rigid" therefore measured the finder (G21). `P_N` by a loop whose UNSAT answers confirm generators is a statement about every colouring at period `N`. `KPer` over one component is an upper bound on `KPer`, not `KPer` |
| Plan: `KPer`'s colour pairs are distinct (§0) | The adversarial member. With `a = b`, every set of `a`-coloured vertices is Kempe-closed, and `KPer` collapses to `{0}`, which would make the sandwich's upper bound read "C3 holds" whenever `F = 0` |

**What did not change, and why.**
- `KempeClosed` stays graph-generic and set-valued, not component-valued. Kempe-closed sets are exactly the unions of
  components, and they are closed under intersection. So every statement the kernel needs is expressible without
  connectivity machinery. Components enter only where they are declined above.
- `VoltageEscape` keeps `V` as a parameter bounded by the kernel of `π`, not the voltage span. That makes the
  certificate monotone in `V`, and monotonicity is R3's proof engine (enlarge `V` to a finite-index `W′` that misses the
  escape). `D` stays for compatibility with `addCayleyMap`.
- `forces_iff_exists_finite` keeps `Set` + `.Finite`, which matches Mathlib's `Subgraph.verts.Finite` in
  `nonempty_hom_of_forall_finite_subgraph_hom`.
- The plan's phases, routes and sequencing are unchanged. The normal form re-states what P1 computes, not what is run.

**Build:** `./scripts/build.sh` under the heavy lock, OK, 177/177 batches, `sorry` only at leaves (§K).

### §M.2 Obligation pass (`debruijn-obligation-modeling`, fresh invocation)

**The partition.**
- *Prove*: every leaf in the table below.
- *Test*: the spec `example`s; the tools' controls in P1b and P1d.
- *Assume*, as named hypotheses:
  - `hab : a ≠ b` for swaps;
  - `hS`, `hD` (the quotient map is a graph homomorphism);
  - `hfin` (the period map has finite-index kernel);
  - `[AddGroup.FG A]`, for R3 only;
  - `hSneg`, for T2 only (the unit-vector set is symmetric).

**The statements the proofs derive from.** Every leaf is decomposed into a named child, with no induction anywhere; the
proofs are case splits and one compactness citation. The children now in the skeleton, each `sorry` (22 in all,
counted from the build):

| leaf | the statement it derives from (a child in the skeleton unless marked "plan") | route | price |
|---|---|---|---|
| `kempeSwap` properness | case split on `v ∈ K`, `w ∈ K`. A non-member neighbour of a member wears neither `a` nor `b` (`KempeClosed`'s second clause, read in the contrapositive), and `Equiv.swap a b` is injective and preserves `{a, b}` | four cases, two symmetric | 1 h |
| `kempeSwap_apply_of_mem` / `_notMem` | unfold `Coloring.mk`, then `if_pos` / `if_neg` | `simp [kempeSwap, hv]` | minutes |
| **`kempeSwap_ne_of_mem_of_notMem`** (new) | `swap a b c ≠ c` for `c ∈ {a, b}` and `a ≠ b` (`Equiv.swap_apply_ne_self_iff`) | the one computation shared by `not_forces_of_kempeClosed` and R3 | 30 min |
| `not_forces_of_kempeClosed` | case `C u ≠ C v` (C separates), else the child above | 4 lines | minutes |
| **`exists_coloring_ne_of_forall_finset`** (new) | Mathlib's **`Finset.rado_selection`** (`Combinatorics/Compactness.lean`, de Bruijn–Erdős) with `g s` the given function. Properness is read at `s = {x, y}`, separation at `s = {u, v}` | no subgraph coercions; this replaces the `nonempty_hom_of_forall_finite_subgraph_hom` route, which needs `G ⊔ edge u v` and `Subgraph.coe` | 2 h |
| `forces_iff_exists_finite` | ⟸: `Forces.comap` along `Embedding.induce`. ⟹: the contrapositive. For a finset `t`, take `s = t ∪ {u, v}`, use the separating colouring of `G.induce s`, extend it by a default colour (inhabited through `u ∈ s`), and apply the child | ⟸ one line, ⟹ 20 lines | 2 h |
| `VoltageEscape.zero_mem_lift` | `map_zero`, `zero_mem`, `neg_mem p_zero` | 2 lines | minutes |
| **`VoltageEscape.enlarge`** (new, **proved**) | the certificate is monotone in `V` | a record update | — |
| **`VoltageEscape.add_mem_lift_iff`** (new) | `V_ker` and `add_sub_right_comm` | 3 lines | 30 min |
| `VoltageEscape.kempeClosed` | `addCayley_adj'` (adjacency is a step `±s`), then `closed` and the voltage identity in the docstring | 20 lines | 2 h |
| `not_forces_of_additiveKempe` (T2) | split on `φ δ = 0`. Off the kernel, the additive colouring separates. On it, `not_forces_of_kempeClosed` with the choice-free set in the docstring, which needs no voltage `p b` and no case split on whether `b` is hit | a `Γ ≃ Fin k` from `hk`, one Kempe-closure check with three step cases | 3 h |
| `mem_forcedSubgroup` | `AddSubgroup.mem_iInf`. ⟹ is `Periodic` at `0`; ⟸ is `not_forces_zero_of_not_periodic` (`ResidueObstruction`) | 6 lines | 30 min |
| **`periods_le_periods_comap_translate`** (new) | `C (x + (y + d)) = C ((x + y) + d)`, by `add_assoc` | 3 lines | 30 min |
| `mem_periodicForcedSubgroup` | ⟹ `Periodic` at `0`. ⟸ translate by `x` and apply the child with `AddSubgroup.finiteIndex_of_le` | 8 lines | 1 h |
| **`ker_le_periods_comap`** (new); `isPeriodic_comap` (**proved** from it) | `π (x + w) = π x` for `w ∈ ker π`; the `addCayleyColoring` and `addCayleyMap` apply lemmas | 3 lines | 30 min |
| **`periodic_kempeSwap`** (new) | case split on `x ∈ K`, with `hKw` and `hC` | 6 lines | 30 min |
| **`exists_finiteIndex_between_notMem`** (new) | **residual finiteness.** Mathlib holds `AddGroup.ResiduallyFinite` and `exists_finiteIndexNormalSubgroup_notMem`, but at our pin no instance for finitely generated abelian groups. Build one for `A ⧸ V` from `AddCommGroup.equiv_free_prod_directSum_zmod`: `ℤ` by `n ∉ (\|n\|+1)ℤ`; `Fin r → ℤ` as a finite product; the torsion part is finite (instance exists); transport along the equivalence. Then `W = comap mk M ⊓ H` | 60–80 lines. **The costliest leaf** (P-K1) | ½ day |
| **`notMem_periodicForcedSubgroup_of_ne`** (new, **proved**) | one periodic separator refutes H1: non-membership in an infimum, witnessed by one factor | 1 line | — |
| **R3**, `notMem_periodicForcedSubgroup_of_voltageEscape` | Let `C` be the pulled-back colouring (periodic by `isPeriodic_comap`). If `C 0 ≠ C δ`, the previous child applies. Else choose `W`: `ker π` when `π δ ∉ Q0`, and otherwise `exists_finiteIndex_between_notMem` applied to `e = δ − p (π δ) ∈ ker π ∖ V`. Swap `C` on `(e.enlarge W …).lift`, which is Kempe-closed and `W`-invariant by `add_mem_lift_iff`; `periodic_kempeSwap` makes the swap `W`-periodic, `kempeSwap_ne_of_mem_of_notMem` makes it separate, and `notMem_periodicForcedSubgroup_of_ne` closes | 25 lines over the children | 2 h |
| `voltageEscapeZ` (5 fields), the escape `example` | finite facts over `ZMod 2` and `t ∈ {±1}`: `fin_cases`, `decide`, `simp` | 15 lines | 1 h |
| spec: periodic 2-colouring of the path | `isPeriodic_comap` with `Int.castAddHom (ZMod 2)` and an equivalence `ZMod 2 ≃ Fin 2`; the kernel has finite index by `AddSubgroup.finiteIndex_ker` (a finite range) | 6 lines | 1 h |
| spec: `2 ∈ F ∧ 1 ∉ F` on the path | `mem_forcedSubgroup`. `2`: two colours and two edges `0–1–2` force `C 0 = C 2` (`omega` on the values in `Fin 2`). `1`: the parity colouring separates an edge | 10 lines | 1 h |

**The price.** Roughly 1½ working days of focused work for the whole file, inside P5's 2-day budget. The residual
finiteness instance is the one leaf that could overrun, and it is also a candidate Mathlib contribution
("finitely generated abelian groups are residually finite"; deferred with every upstreaming, § Publication). P-K1's
"the residual-finiteness step is the costliest" now has a number.

**Changes this pass made.**
- *Skeleton*: nine children added as named declarations. Three are proved outright (`enlarge`, `isPeriodic_comap`,
  `notMem_periodicForcedSubgroup_of_ne`); six are `sorry` leaves. T2's docstring now names the choice-free route.
  Build OK under the heavy lock, 177/177, 22 `sorry` warnings and nothing else
  (`build/gate/build/20260923T062152Z-144678.log`).
- *Plan*: R1's route moves from `nonempty_hom_of_forall_finite_subgraph_hom` to `Finset.rado_selection`, which is the
  same compactness (Mathlib's file cites de Bruijn–Erdős 1951) without subgraph coercions. The correction owed at P6 to
  FS58-T4's kernel note should name both lemmas.
- *No statement of the domain pass changed.* Every obligation closed against the normal form as stated, which is the
  convergence signal.

### §M.3 Experience pass (`debruijn-experience-modeling`, fresh invocation)

*Four surfaces, each read cold as its consumer at the moment of use.*

| surface and consumer | what the consumer holds | change | why |
|---|---|---|---|
| **The census record** (P1f), read by the PO and a later reviewer | the committed rows and nothing else | reviewer-first. Every number names what it measures, and every group is given by integer generators in a stated basis. A frozen checker, `tools/fs73_census_check.py`, re-verifies in order of marginal value: colourings, then `KPer`, then `F_known`'s refusals, then (last and skippable) the solver's UNSAT confirmations. §S.3's P1f row gains the checker, with a planted improper colouring as its red control | § The standard of evidence ("write the certificate for the reviewer early"; "order a verification's steps by marginal evidential value"). The sandwich's soundness rests only on exhibited colourings, so the reviewer's cheapest check is the decisive one |
| **The competition brief** (§C), read by two competitors and an advisor | the brief, then whatever files they open | one pointer. The kernel form of the question is `InheritanceQuestion S k`, and a theorem should be stated so it could instantiate it. Nothing else changed: the subgroup form, "K may be the instance under test" and the `F_μ` split were already written into the brief at A3/A4, in the template's slots | a competitor who proves something should be able to say which `Prop` it proves. The brief's length is the template's, and the new bullets replaced one ("both sides are subgroups") rather than stacking on it |
| **The lemma API** (`Kempe.lean`), read by P5's implementer, `exact?` and `simp` | the statements' shapes and the tags | `kempeSwap_apply_of_not_mem` renamed to `kempeSwap_apply_of_notMem`, matching Mathlib's `notMem` convention (130 declarations to 2 at our pin). Both apply lemmas tagged `@[simp]`: the swap's normal form is its value, and simp discharges the membership hypothesis from context. Docstrings added where missing (`mem_periods`, the apply lemmas, `isPeriodic_comap`). **Deliberately untagged**: `mem_forcedSubgroup` and `mem_periodicForcedSubgroup` | one deviant name plants a false guess across every later search. Tagging the membership bridges would rewrite every goal about the groups into `Forces`, a def with its own API, and fight `AddSubgroup.mem_iInf`. Users need both sides, so the bridges stay citable, not automatic. `mem_periods` is tagged because its right side is the corpus's own predicate |
| **The stage-1 letters** (§S.5), read by implementers A and K with zero memory | the PO's brief, then this plan | new §S.5: a reading order per implementer, the tools as code (G46), the first commit and first finding (A), and the agenda, forbidden moves and definition of done (K) | the rows were complete as specifications but not as letters. P1d refers to T10 voltages, `fs70_periodic_kempe`'s endianness trap and FS-70's data by name, and a cold reader needs the addresses |

**What did not change, and why.** The binders stay as the corpus has them: `hS` and `hD` are explicit, as in
`addCayleyMap`, so a caller's existing proofs slot in. `InheritanceQuestion` stays a `def` of a `Prop`: never a theorem,
an instance or a class, because it is a question. The competition brief's rules, register and hint protocol are the
template's, and this pass did not touch them.

---

## §X. The exchange with Poros (this stage), and its retractions

*Poros's full log is `plans/POROS-2026-09-23-fs73-plan.md` §2. Summary by the planner.*

| # | from | substance | outcome |
|---|---|---|---|
| 1 | Poros | R1 (compactness), R2 (vacuous case, FS-72 as its instance), two C3s | accepted; R1 reached independently by the planner; R1's credit is **FS58-T4** (Poros, message 11) |
| 2 | planner | H1/H2/H2-found; C3-local vs C3-inherit; a q ≈ 37 Weil cutoff | two claims retracted in 4 |
| 3 | Poros | **H1 ⟺ H2** by re-periodisation; the cutoff cannot exist (quotient ⊂ target); the lattice spectrum as the right object | accepted after checking |
| 4 | planner | **retraction 1**: "infinite-index escapes survive under H1"; **retraction 2**: the q ≈ 37 cutoff | — |
| 5 | planner | the de Grey spectrum: slack; P-S1 lost; "G54's middle case observed at N = 8" | **retraction 3** in 7 |
| 6 | Poros | **retraction 4 (Poros's)**: P-S1; **retraction 5 (Poros's)**: "walls" as *the* question (two places: recurrent and non-recurrent); the N = 8 result is a corollary of Harder + T6, not G54's middle case | accepted |
| 7 | planner | informative instances: the census; the corpus's non-periodic constructions | Poros: census right, with four design points (message 9) |
| 8 | Poros | the rank-6 card (81 = 3⁴ ⟹ composite period) | adopted as P1g and P-R1 |
| 9–10 | Poros | the census can confirm C3 but never refute it (uninformative outcome stated); the rich lattices were screened only at N ∈ {2, 4} on generator graphs; register P-D3 depth by depth; the 745 vs 23,083 record fix | all adopted (P1e, P1f, P-C3, P6) |
| 11 | Poros | FS58-T4 is R1 in-house; its kernel note missed Mathlib's lemma; FS58-T3's tensor product is the composite column's precedent | adopted |
| 12 | planner | plan committed (`9d1fe367`); asks which SILENT verdicts bear | — |
| 14 | Poros | P1d's target set was infinite (a rank-4 subgroup of ℂ is dense). Both sides of C3 are subgroups, so the census computes `P_found / F_known`; targets are cosets, not distances (8/√3 is the vector (8/3)(1+ζ₆)); ρ is not a multiplier, so F_known has rank 2 at K | adopted after the planner checked ρ³ ∉ Λ and the orbit's rank on the lattice's coordinates (after the hand-back, commit following 974ec8fa) |
| 13 | Poros | G59 bears as a caution: the quotient is a diagonal *subgraph* of the product of targets (finite `U`), so FS58-T3's tensor identification does not transfer. **Poros retracts message 11's finite-`U` precedent claim**, and the planner withdraws "C3-local = FS-67 at four colours". G15 bears (fallback (b) as pigeonhole × kill). M63D-T7 bears (refusals carry only down). G64 weakly bears. Rows 22–24 need one periodicity check. G58 has a reason held by the PO for the competition phase. M45-T1, MASCOT-T5 and FS66-T9 agreed silent | all adopted |

**Retractions in the window, all free.**
- **The planner's own: four.** (1) Infinite-index escapes survive under H1. (2) The q ≈ 37 cutoff. (3) "G54's middle
  case observed at N = 8". (4) "C3-local is FS-67's question at four colours", withdrawn at message 13.
- **Poros's own: two by Poros's convention.** The walls note, and message 11's finite-`U` precedent claim. Poros counts
  P-S1 as a lost prediction, not a retraction. By the planner's first convention, which counted P-S1, it would be three.
- **A correction.** The planner's mid-stage status message to the PO said "four mine and one Poros's". At that moment it
  was three and one (or three and two), and the hand-back corrects it.
- None was committed. **Disagreements outstanding: none.** One
difference of emphasis is recorded. Poros's expectation (§0.4 item 1) says balls are an instrument for (2), not for (1).
The plan keeps balls in P1d/P1e, but only to *produce instances* for the competition, never as evidence for or against
C3, with the uninformative outcome declared in P1f. Poros agreed to that form (message 9).

---

## §R. Records

### §R0. Phase 0 — the planner's measurement (2026-09-23, desktop)

**Theorems this phase proved:** none (a measurement). **Measured** [floats; `data/fs73/phase0/`]:
- De Grey's K-lattice `⟨ζ₆^m ρ^n, |n| ≤ 2⟩`: rank 4, `d = 54`.
- The minimum of `Σ_u cos 2πθ·u` over each period-`N` quotient's characters, with `N` and value:
  - 2: −18 (6 minimisers); 4: −18; 6: −18;
  - 5: −18.034; 7: −14.345; 8: −18.142 (≈ −4 − 10√2); 9: −9.518; 10: −18.271; 11: −21.581; 12: −18.928;
  - 3: +24 (N = 3 inadmissible).
- The continuous minimum over `T⁴` is **−22.4095** at θ ≈ (0.070, 0.842, 0.035, 0.956), from 4,000 BFGS starts.
- Against FS-70's quotient table (`data/fs70/quotient/degrey-K-control.json`): N = 5, 11, 13 refuse by solver with Hoffman
  floors 3.99 and 3.50 (5, 11); N = 7 refuses with floor 4.76 (spectral).
- **Reading:** slack as a lattice graph; tight at N = 2, 4, 6; the odd refusals at 5 and 11 are arithmetic or
  combinatorial, not spectral.
- P-S1 lost. The N = 8 gap-freedom is a corollary of Harder + T6 (§X, message 6).

---

## §R-close. The close (WORKFLOW 9, 2026-09-23)

*Written by the second close planner (de Bruijn, Opus 5.5) from the phase records, the first close planner's notes
(`plans/FS73-close-inventory.md`) and the owner's running notes. Results: `LEDGER.md` rows 78–79; theorems:
`plans/FS73-derivation.md` T1–T44 (§8 holds the conjecture sweep); understanding: G71 and the corrections listed in the
inventory's §3. This section holds what the close must not lose and has no other home: the §G re-read, the §PA sweep, the
forward propagation, the predictions scored once, the retraction tally, the errata to this plan, and the honesty record.*

### §R-close.1 The §G re-read: which extractions paid, and which entries should have borne and did not

**Paid** (the extraction in §G.5, then what it bought):

| entry → phase | what it bought |
|---|---|
| G68 → P1b, P2 (the gap-aimed finder before any ball) | every rank-4 CM lattice in the table but de Grey's closed as loose by a gapped periodic colouring at `N ∈ {2, 3, 5, 7}`, in minutes (row 78); the fixed-prime gap lemma (T14) is G68 lifted from a lattice to a CM field; C's period-23 colouring of `L3e1c94c6` is gapped (T17) |
| G21 → P1f (every row names its graph, periods and finder; "H1-found", never "H1") | the census design: the rich ℚ(√3,√5) lattices were recorded as "rigid-found, forcing undecided" and never promoted (T10, row 78) |
| G27 → P1b (the Galois point group) | more than its instruction: the order-24 group `⟨ζ₆·⟩ ⋊ Gal(E/ℚ)` gave `v`'s orbit rank 4 and index 4,096 (T6), where P-C4 expected rank 2 from `ζ₆` alone |
| R3 / T10 → P1b, P4 (report `W′`; membership) | T10.2's membership reading became F's fibre-collision sandwich `D_Q ⊆ V_Q` (T33) |
| G65 → P1d (the ball ladder aimed at degree ≥ 14) | the census's certification: `v` refused on the degree-aimed ball (T6) |
| G51 → P3 (the protocol, retractions counted) | a theorem at three colours, reached twice independently, with every retraction free (§R-close.6) |
| FS58-T4 / R1 → P5 (compactness) | the kernel's `forces_iff_exists_finite` (row 78) |
| G70 → P1 (as a test) | held on all 12 classes of de Grey's lattice (T8) |
| G54 → P1c, P2 (the spectral column, target and quotient kept apart) | a classifier, once its two sign defects were fixed (phase-P2.md "Defects" 1–2; `data/fs73/table/CORRECTIONS.md`) |
| G60, G66 → §0 (A4) | the frame `F ⊆ F_μ ⊆ F_meas ⊆ P = F_clopen` (T38) |

**Missed** (each an instance of WORKFLOW 3.1's failure: an entry in context and not reasoned from):

1. **G21, twice — a periodic search measures its period cap.** P2 read `L3e1c94c6` as having no periodic three-colouring
   because its search stopped at `N = 20`; the least period is 23 (T17). P2b's `N ≤ 30` and circular `N ≤ 120` missed
   `Ld14c588b`'s linear colouring of period index 1,080 (T27). Both were read as "none", not as "none at the periods
   searched". Now written into G21.
2. **G7 and G62 — `L21cc6506` is a five-layer twist, and its rotation is G7's `n = 42`.** Its unit vectors are
   `U = {1, v, v̄, z, z̄}·U_R`, the 12 rational unit vectors rotated five ways (T40), and `v = (83 + i√167)/84` **is the type-M
   rotation at `n = 42`**: `cos θ = 83/84 = (2n − 1)/(2n)`, `sin θ = √167/84 = √(4n − 1)/(2n)`, radicand `4·42 − 1 = 167` — by
   G62 the `Σ = 42` coincidence rotation of the order of discriminant −167. (The second rotation
   `z = (1 + i)(15 − i√167)/28` is not a type-M member: its cosine `(15 + √167)/28` is irrational; it carries the Gaussian
   prime `1 + i`.) G62's *Do* — name every bilayer by its rotation and decide it layer by layer — predicts T40's product
   route (`θ ∈ Θ₃` iff each layer's pull-back lies in the rational pattern's rotation set `Θ_R`). Nobody extracted it:
   Coxeter's float tree stalled on the 1,764 lifts, E found the product structure by hand, and V2's relation tree succeeded
   without it. The identification `v = ρ₄₂` is this close's (checked by the arithmetic above); it is written into G62.
3. **G65 — the owner's "smallest refusing ball".** The owner asked for the smallest refusing ball, which G65 names as the
   slow one; it walked a solver into the hardness band (5 UNKNOWNs, about 2 hours; §R-close.8, owner error 1).

**The misses the §PA sweep holds** (§R-close.2): the gate found the heights and did not carry them into §C; and **the milestone's
four-colour headline was on the Polymath16 blog in 2018** (Hubai's count) and its `8/9` pair in 2021 (Parts), in a text we hold.

### §R-close.2 The §PA sweep: what the gate taught us about our own object

- **The object is a hom-shift.** The colourings of `Cay(Λ, U)` with `k` colours are the graph-homomorphism shift
  `X(Λ, k) = Hom(Cay(Λ, U), K_k)`, and the inheritance question is the density of its periodic points (`P = F_clopen`, G66's
  odometer sentence). §PA.1 found Chandgotia's height functions for four-cycle-free targets and Moore–Newman's height for the
  four-state triangular Potts antiferromagnet, **and §PA.3 did not extract "three colours have heights, four do not" into
  §C.** Both competitors derived it for themselves (T21, T29). *Promoted:* **G71** (three colours are linear, four are not).
- **"Rigid" is the discipline's *frozen*** (`[AlonEtAl2021]`); `[PeledSpinka2023]`'s *rigidity* is another notion. *Promoted:*
  the qualifier in G69.
- **C3-aper is `[AbrishamiEtAl2025]` Problem 4.6.** Answered at three colours for every Cayley graph of a finitely generated
  torsion-free abelian group (row 79). *Promoted:* FS-76 at `k ≥ 4`.
- **The one four-colour height**: Baxter's three-colouring model on hexagonal fabric (Coxeter §6, after Moore–Newman). *Promoted:*
  FS-74's third lead.
- **Colouring periodic graphs is undecidable** (`[Burr1984]`, several vertex orbits), and whether 4-colourability of
  Cayley graphs of ℤ^r is decidable is unknown (T29). *Promoted:* FS-76.
- Mohar–Salas 2009 (Kempe classes on tori): **declined** — P4 did not use Kempe classes on tori.
- **The miss, found at the close: row 78's headline count is Hubai's (2018), and `8/9` is Parts's (2021).** Grepping the archived
  Polymath16 threads we hold (`~/source/library/notes/polymath16-threads-1-18-text.txt`, `[Polymath16threads]`) for the milestone's own
  numbers found Tamás Hubai's comment of 9 May 2018 (fourth thread): the Moser ring `R₂` — closed, as his computation uses it, under
  rotation by `η = ω₃^{1/2}` — has *"9120 colourings (380 if we fix the colouring of a triangle)"*, all unchanged by translation by 8, with
  stripes of period 2 on the Eisenstein sublattice and one chirality choice. FS-73's census reached 380 and 9,120 **without anyone having
  looked at his comment — an independent confirmation of his count, credited to him** (`[Hubai2018]`). And Jaan Parts's comments: a
  four-colour mono-pair at `(0,0)–(8/9,0)` in his graph 4H4, two of them joined by an edge as a five-chromatic graph in ℚ(√3,√7,√11)
  (seventeenth thread, February 2021); a graph forcing every vertex at radius `8/√27 = |v|` (twelfth thread, April 2019) — checked: its six
  vertices there are `(8/9)√−3·ζ₆^m`, not `v`'s orbit (`data/fs73/prior-art/parts_v.py`). **What is left ours** is the lattice form on the
  smaller graph (`Λ` is not closed under `η`; `8/3` reaches only rank 2 on it; the lattice statement implies the ring's 8-periodicity, so it is the stronger; the equal counts suggest the same colourings, unproved), `v` and
  `Λ = (1/9)·O_E`, the independently verified certificate, `F = P` as an inheritance instance, the 12-class table and G70's test (row 78,
  rewritten). **Why the gate missed it:** the text was held and had been read thirteen days earlier (2026-09-10) for a different question —
  who first stated the 2-adic law — and the bibliography row it produced recorded Hubai's "22 colourings" without the count or the
  periodicity; §PA's zbMATH and citation searches cannot reach blog comments. **The rule it instances** (WORKFLOW 3.2: a held paper is prior
  art for questions it was not read for): **re-read the held Polymath16 threads for every milestone's headline object, in the discipline's
  words** ("ring", "periodic", "colourings of `R₂`", the milestone's own numbers). Written into G49.

### §R-close.3 The conjecture sweep

`grep -n -i "conjecture\|not claimed"` over this plan: four hits, none new (G48, G58, the periodic tiling conjecture, FS-66's
tower conjecture). The milestone's own readings — B's tight-prime reading, F's collision reading, Coxeter's chirality reading,
Baxter's height, C3-aper at four colours, decidability — are filed with their fates in `plans/FS73-derivation.md` §8.

### §R-close.4 Forward propagation (every new grokking to the open stubs it bears on)

**G71** goes into the provisional-bearings lines of: FS-48 (`plans/STUB-biquadratic-table.md`: χ = 3 against 4 is decided by
`Θ₃`), FS-72 (`plans/STUB-last-lattice.md`: four colours have no `Θ`; L3's gap-free looseness; the Kempe-period criterion), FS-60
(`plans/STUB-quadratic-witnesses-kernel.md`: the `Θ` certificate replaces LRATs, T26, T39), FS-46
(`plans/STUB-three-colour-classification.md`), FS-67 (`plans/STUB-tight-product-colourings.md`, with the finite-`U` quotient
note) and FS-59 (`plans/STUB-four-colours-167.md`, rewritten). **G70's hold** (all 12 classes) and **G54's restated reading**
go into FS-74. The new stubs FS-74 to FS-78 carry their own bearings.

### §R-close.5 The registered predictions, scored once

| outcome | predictions |
|---|---|
| won | P-C1 (gap finder and forces refusal agree at N = 8, 10, 12), P-C2 (every H1-found target at K has depth ≥ 3), P-C6 (`P_32 = 8Λ`, registered before the run), P-T1 (K the only rigid rank-4 lattice at four colours — the registered uninformative outcome), P-R1 (the index-81 component's escapes local at neither prime; T9), C's P-C1 and P-C1b (the dense ball colours; a longer circular period — 23, exactly), P-F1, P-F2, P-F4 |
| lost | P-S1 (Poros: de Grey's lattice Hoffman-tight — slack, §R0), P-C4 (Poros: `F_known` rank 2 at K — rank 4 by the Galois group), P-C3(b), E's P3b prediction (`Θ₃(L21cc6506)` nonempty, 0.60), **P-T2 (final score):** loose by theorem on the 52 lattices with gapped colourings, but `L21cc6506` is not three-colourable, so "loose at every chainable target" fails there (vacuously rigid) |
| decided | P-C5: `P_found` plateaued at `8Λ` from `N = 8` (outcome (b)'s plateau, registered at 0.25), and the certificate `F = 8Λ` closed it as `P = F` — no counterexample candidate |
| split | P-Q1: "theorem" (0.10) at three colours, "not landed" (0.60) at four; P-T3 won on the verdict, lost on the mechanism (the pilot field has no fixed prime at 11 or 19); P-K1: every leaf closed within budget (won), "residual finiteness the costliest" (lost; T2 was, by length) |
| void | P-C3(a) (registered on inadmissible periods — owner error 3), P-F3 (unreachable at registration: `F ⊇ 8Λ_dG` by monotonicity) |
| unscored | P-R2 (`[NΛ : V]` an ideal norm): T33 relocated the index to the unit vectors' fibres mod 2, and the norm question was not asked |
| held / killed | G70 held; Poros's hunches "both competitors drift to rigidity" and "no inheritance theorem" killed (the latter at three colours) |

*A namespace collision, recorded so it does not recur:* the plan's P-C1 and implementer C's P-C1 (phase-P2b-q167.md) are
different predictions under one id. Registrations name their phase in the id from now on.

### §R-close.6 Retractions, counted (G51)

| stage | count | what |
|---|---|---|
| plan (§X) | planner 4; Poros 2 (3 by the planner's first convention, which counted P-S1) | the inventory's "Poros 4 / planner 4" is corrected here from §X's own list |
| competition (P3) | Poros 1 (a pointer recalled as fact: the rank-1 criterion "κ(D) ≥ 1/3"), de Bruijn 1 (a labelled guess, R1), Coxeter 0 | all inside the free window |
| verification (V2) | 1 | a planted fault that could not fire ("scale one multiplier by 3": a scaled Farkas combination with slack stays valid), replaced before the verdict by zeroed and negated plants (verify-P3b-q167.md §4) |

None was committed; none cost solver time.

### §R-close.7 Errata to this plan (read these before the body; the body is not edited except for pointers)

- **E1** (§0 l. 72–75, T10.2): what decides an escape is `e ∉ V_Q`, with `V_Q = D_Q +` the cycle voltages (T33) —
  membership, not the index.
- **E2** (§0, consequence 5, "K itself may be the instance under test"; §C's bullet of the same name; P-C4's and P-C5's framing
  of K at rank 2): **superseded.** `F = P = 8Λ` has rank 4 (T7); K is not a counterexample candidate.
- **E3** (§0): a lattice is loose ⟺ finitely many periodic colourings' Kempe period groups intersect in 0; a gap is one way,
  L3 (gap-free at every period, T32) the other.
- **E4** (§C, "it does at depth 6 (8/3)"): the convention clashes with 2-adic depth per prime; `8/3` has depth 3 at each of
  the two primes above 2 (T4), and `16/3` depth 4 (T3, P-D3 refuted).
- **E5** (P1d′'s outcomes): add "P = F certified" — the outcome that happened.
- **E6** (P-R1): restate per Kempe component. The least-`ℓ` rule is a convention; 301 of 2,304 colourings escape only
  non-locally (phase-P1.md, P1g).
- **E7** (P4's row, "de Grey's lattice with one ρ₁₅ word"): that lattice is KR6 (T34).
- **E8** (P1e's first step): "the gap finder at every admissible period with an odd part, including composite period groups".
- **E9** (P1f): the `W′` column is n/a for census asks.
- **E10** (T9's single-prime reading, §G.6 item 3): it assumes integrality at the prime.
- **E11** (implementer B's four, phase-P2.md "proposed plan edits"): the 2-unit verdict is not inherited from T5; rank-2
  denominator lattices are marked; chainability is field-relative (`1/2 ∉ ℤ[U]` over K, so `8/3` is not chainable in K²);
  the command is `tools/fs73_table.py table FIELD`.
- **E12** (FS70-T5's table): the prime of ℚ(√5) above 3 splits in ℚ(√5, i); the table read "inert then ramified". Corrected in
  place in `data/fs70/owner/cm-subfields-2026-09-22.md` at this close (the derivation file's T5 prose never stated it).
- **E13** (P4's record): L3's certificate colouring is "2L3-periodic"; its exact period group is coarser (index 4, additive
  into `V₄`). Harmless (`data/fs73/table/CORRECTIONS.md`).

### §R-close.8 Honesty: the owner's errors, the agents' slips, the kills

**The product owner's errors, each caught and each with its cost:**
1. Asked for the "smallest refusing ball", which walked the solver into G65's hardness band: 5 UNKNOWNs, about 2 hours.
2. Paraphrased to the verifier "2 separable by a period-2 colouring"; `2 ∈ 2Λ`, so no period-2 colouring separates it.
3. Registered P-C3(a) on inadmissible periods (void).
4. The first briefs omitted the `to: "main"` reply channel (Kooshi caught it).
5. Retired the ~500k-token replacement rule together with the Opus quirks (Kooshi restored it; `CLAUDE.md` § Delegation).
6. The P4 brief claimed the rank-6 lattices were loose by the fixed-prime gap lemma; the lemma does not reach them, and
   implementer F caught it before any run (T14's scope).
7. The first competition drafts put the working files and the advisor's record in `plans/`, which every competitor reads — a
   covert channel. Caught by the owner before launch; now the protocol's rule.
8. The P1 brief and the close inventory both called `F = P = 8Λ` new without re-reading the held Polymath16 threads, where Hubai's
   2018 count sat (§R-close.2). Found at the close; row 78 rewritten.

**The agents' slips, recorded without blame:** two reported commit hashes that did not exist (A, V) — every hash is now checked
against `git log`; Coxeter's `pkill -f` killed its own shell (exit 144; nothing lost); two runs over 2 minutes without the lock
(Coxeter); **a killed `flock` wrapper's child held the lock about 17 minutes** (Coxeter, 15:29–15:46: the wrapper had already
started its child, which inherited the lock's descriptor and ran an obsolete search orphaned — found by a `ps` sorted by CPU,
killed by PID, verified absent); C's self-deadlock (an outer `flock` around a tool that takes the lock itself; killed by
process group, verified by effect, forfeit about 2 minutes); an orphaned kissat (pid 884222) outlived its table driver; F's
finished agent kept re-waking and re-sending its hand-back until stopped.

**The owner's kills this milestone, with what each forfeited:** the orphan kissat 884222 (nothing: nothing read its result);
A's down-ladder run (the forfeit recorded in phase-P1.md); de Bruijn's redundant `q167.py 348` run (nothing: that lattice was
settled).

### §R-close.9 Tool defects and their homes

- `tools/fs73_table.py`'s quotient ask takes the heavy lock itself (through `fs73_screen`'s lock), so a `flock` wrap
  deadlocks; its scratch path (`SCRATCH`) and `fs73_screen.LOCK` are this session's `/tmp` scratchpad, so a later session must
  repoint both. Recorded in the tool's docstring at this close.
- Killing a `flock` wrapper can orphan a child that holds the lock: `CLAUDE.md` § Building's kill rule, its ninth instance.
- The table's stale spectral label and the four "REFUSING" verdicts: `data/fs73/table/CORRECTIONS.md`.

### §R-close.10 The prior-art items owed at the close (WORKFLOW 3.2; queries through the zbMATH Open API, 2026-09-23)

*Every query and its hit count; a negative measures its query's words (G21). Script: `…/scratchpad/fs73-close/pa/zb.py` (throwaway).*

| item | what was run | result |
|---|---|---|
| `8/9` or `v` as a four-colour forced pair over K | grep of the held Polymath16 threads for `8/9`, `4/9`, `8/√27`, `sqrt{-11}` | **found — Parts (2019, 2021) and Hubai (2018)**; §R-close.2 and row 78. Parts's radius-`8/√27` vertices checked against `v`'s orbit: not among them (`data/fs73/prior-art/parts_v.py`) |
| is `χ(ℚ(√167)²) ≥ 4` in print? | `ab:"unit distance" & ab:"quadratic field"` 0; `ab:"real quadratic" & ab:"chromatic number"` 0; `ti:"chromatic number" & ab:"quadratic field"` 0; `ab:"chromatic number" & ab:"number field" & ab:"unit distance"` 0; `ab:"sqrt{167}"` (three spellings) 0; `ab:"rational plane" & ab:"chromatic number"` 2 (Fischer 1990; Axenovich et al. 2014, both held or known); `au:"Fischer, Klaus G."` colouring entries 2 (1990, 1994, both read); `ab:"Hadwiger-Nelson" & py:2024-2026` 11 (none on quadratic fields); the held threads mention 167 three times, none as a field | **not found.** FS-61's gate (2026-09-19) had searched the real-quadratic question in full; nothing since. Row 79 keeps "that it is new: not claimed" → now "not found in print (zbMATH, the held threads)" |
| the three-colour criterion for abelian Cayley graphs with arbitrary `S`, and its rank-1 case (`G(ℤ, D)` 3-colourable ⟺ `κ(D) ≥ 1/3`) | `ab:"distance graph" & ab:"fractional chromatic number"` 14; `… & ab:"circular chromatic number" & py:1995-2015` 9; `ab:"distance graph" & ab:"kappa(D)"` 1 (Liu–Robinson–Chavez 2020); `ab:"distance graph" & ab:"3-colorable"` 0; `ab:"lonely runner" & ab:"distance graph" & ab:"chromatic"` 2; `ab:"height function" & ab:"proper 3-coloring" & ab:"Z^d"` 0; `ab:"3-colorings" & ab:"Z^d"` 3 (Galvin–Kahn–Randall–Sorkin, Chandgotia–Peled–Sheffield–Tassy: statistical mechanics); `ab:"circular coloring" & ab:"Cayley graph" & ab:"abelian"` 0; `ab:"hom-shift"` 1 (`[GangloffEtAl2026]`, held as listing); `ti:"Kirszbraun"` 22 (`[ChandgotiaPakTassy2019]`, already listed) | **not found stated.** Read: Chang–Liu–Zhu 1999's review (it fixes `D = {1..m} ∖ {k}`), Liu–Zhu 2005's summary (fractional and circular numbers for large cliques; the `κ`/lonely-runner link). The ⟸ direction (`⌊3{tx}⌋`) is classical; the ⟹ direction at rank 1 is in no text read. Liu's 2008 survey (Zbl 1168.05310) has its summary withheld and stays owed before any write-up |
| is 4-colourability of Cayley graphs of ℤ^r decidable? | `ab:"Cayley graph" & ab:"Z^d" & ab:"undecidable" & ab:"colo"` 0; `ab:"periodic graph" & ab:"coloring" & ab:"decidable"` 0; `ab:"chromatic number" & ab:"undecidable" & ab:"periodic"` 0; `ab:"Cayley graphs of Z^n" & ab:"chromatic"` 0 | **not found.** `[Burr1984]` (several vertex orbits) stays the nearest; FS-76 carries the question |
| the Semantic Scholar cross-check of `[AbrishamiEtAl2025]` | Semantic Scholar citations API; OpenAlex `cites:` | Semantic Scholar 2 (`[Waite2026]`, new `[TanZhang2026]`); OpenAlex 0 for the published version. Both in `BIBLIOGRAPHY.md` |
| `[PeledSpinka2023]`'s notion | the arXiv abstract (1808.03597) | long-range order of random proper colourings — confirmed a different notion; the bibliography row upgraded from listing to abstract |
| Mohar–Salas 2009 | — | **declined**: P4 did not use Kempe classes on tori |
| row 79's headline in the held threads (G49's new rule, applied at once) | grep for "3-colourable", "three-colour", "3-colouring" beside lattice, periodic, ring, distance graph or height; "height function" | nothing on the criterion: `A₂`'s unique 3-colouring by cosets, strips, the Moser spindle's minimality |
| new in the neighbourhood | `ab:"Moser lattice"` 4 | `[Ruhland2024]` (rank-4 lattice families with unbounded unit-vector counts; `L₃` the Moser lattice), abstract read, added |
