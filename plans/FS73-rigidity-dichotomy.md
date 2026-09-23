# FS-73 — the rigidity dichotomy: when does a lattice force a pair? (subplan)

*Planner: de Bruijn (Opus 5.5), 2026-09-23, from `plans/STUB-rigidity-dichotomy.md`, under WORKFLOW 2.0 steps 3–5. Product
owner: the coordinating session (review by artifact). Advisor for this stage: Poros (agent `a20773e5a80987272`, its own
record `plans/POROS-2026-09-23-fs73-plan.md`). This file has one writer (the planner of the stage in hand). The modeling
passes (step 6) have NOT run. They come after the product owner scores §G and the plan.*

*How to read it: §0 is the milestone after the reframe, in one page. §G is the re-grokking (every grokking, every ledger
row, every § B line, every method rule, one verdict each). §PA is the prior-art gate. §S is the subplan (routes, phases,
sequencing). §C is the text for the competition's briefs. §K is the Lean skeleton. §P is the registered predictions.
§X records the exchange with Poros and its retractions. §R is empty and fills as phases report.*

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
  `not_periodicForces_of_voltageEscape` (§K).

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
   about the periodic colourings of a *product* of local targets. That is FS-67's question at four colours, and FS58-T3's
   tensor-product shape is its precedent. It is phase 2's theoretical backbone, not the competition's question.
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
- A census of informative instances (phase 1).

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
- **G9** B — the 791-point forcer forces 4 and 4/√3 (antipodal) at four colours. On de Grey's lattice under T10 those
  targets escape (distance 4 under five of six colourings): **the 791-core's forced pairs are not lattice-forced**, which
  is consistent (Forces is monotone upward, G31). They are census rows with a known answer → P1d.
- **G10** S (weak) — forcing distributed, no organ. It predicts nothing about the lattice question beyond G17's carriers.
- **G11** S — Moser-free five-forcers by landing a forced pair; no bearing on the inheritance mechanism.
- **G12** B — the quadrature law: a detuned copy couples along one thin conic. The cross-edge set of a rank-6 bilayer
  lattice is the conic's → P4 (C2's reading).
- **G13** B — a fan gap is exactly the failure of coverage, and one gap frees every pair above it. The degenerate case of
  T10 (`Q₀ = {0̄}`) → P1b (gap-aimed finder first, before any Kempe run).
- **G14** B — a matching carries no colour pressure. A rank-6 extension joined to the rank-4 base by a matching-shaped
  cross set predicts looseness → P4.
- **G15** S (weak) — pigeonhole × kill. Harder's forcer may factor so, but the inheritance question is about the colouring
  space, not the argument's shape.
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
  census's finders need completeness at the target, not halving.
- **G59** S — the wall at six (finite planes' independence).
- **G60** S — fractional colourings.
- **G61** B — at three colours rigidity is periodic and local, and supply of unit vectors decides. The three-colour
  classification over ℚ(√167) (FS-59's question) is P2's `k = 3` row. "Quotient screens are blind at three colours on
  affine colourings" is the reason that row uses the gap-aimed finder and T10, not colourability → P2.
- **G62** B — bilayers are coincidence rotations, and commensurate ⟹ periodic ⟹ bounded (M63H3-T8). A rank-6 lattice built
  by a commensurate twist is a sublattice of a rank-4 one's scaled copy, and the reading of question 3 starts there → P4.
- **G63** S — transcendence.
- **G64** S — six as a value.
- **G65** B — the degree law prices balls; a word ball has a combinatorial ceiling. Census forcing asks are aimed at degree
  ≥ 14 on Minkowski balls, never word balls → P1d, P1e.
- **G66** B — "ask the whole graph clique-pinned before any finder", and "CDCL refuses nothing up a tower it cannot refuse at
  the bottom" (FS66-T6). The census's ball asks at a target outside every refusing quotient's reach are expected to be hard
  from the start. Lemma W (fibre shares leave the polytope) is the corpus's own warning that local-to-global transfers can
  fail → P1, §C.
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
- **22–24** S (weak) — closures that are exactly 4-chromatic with explicit colourings; periodic colourings of rank-2
  and rank-4 K-objects, known SAT answers. Possible census controls, not needed.
- **25** S — ρσ² = −1.
- **26** B — the 791-point forcer forces exactly six pairs. Known answers for the census's K rows → P1d.
- **27–30** S — quadrature, kill engine, stacking, mechanism hunt (arenas and carriers).
- **31** B (as a warning) — `core9_plane` and `core122_plane` are vacuous. The standing instance of G30's mode 5, to which
  `PeriodicForces`' vacuous case is sibling → §K.
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
- **72** B — the 3-adic barrier, and the tensor rigidity that is only measured (FS-67). C3-local's three-colour precedent →
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
- M63-T1 S · M63-T2 S · M63-T3 S · M63C-T1 S · M63C-T2 S · M63C-T3 S · M63D-T1 S · M63D-T2 S · M63D-T3 S · M63D-T4 S · M63D-T5 S · M63D-T6 S · M63D-T7 S (the reduction loop's soundness; no Λ).
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
- FS58-T3 B (periodic 3-colourings factor through a tensor product: the composite-period column's precedent → P2, P4).
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
| P1e | FS70-T8 (generator-only, `N ∈ {2,4}`): odd-`N` gap-aimed quotients at 5, 7 first (P-M2's live half), then saturation, then balls. FS70-T1/T7: targets by depth |
| P1f | G21: every row states its graph (saturated or generators), periods, finder, verdict |
| P1g | Poros's L3 card (composite period), minutes, before P4 is written in detail |
| P2 | G1/G35/G56/M53-T5/FS54-T2/row 63/M58-T3: column (b). G43/G44/R52-T1/M58-T1/M61-T1/T2/FS53-T4/rows 52–53: columns (c) with the target and quotient spectra separate. FS58-T1/T2/T3/row 72: `k = 3` locality and the composite column. FS70-T3/T4/T5/T9: the table's template. FS61-T3/row 74: lattice per field by supply, none transferred. M63H2-T6: saturation priced. FS38-D2-A/FS53-T1/FS54-T7: the spectral column. ASTRA-T2/G55: chainable-target column. G48/row 64: the `k = 5` pilot row. G61/row 73: the `k = 3` row with ℚ(√11) as positive control. FS66-E/T: ramified targets' impotence and the carry caveat |
| P3 | G51: the protocol, retractions counted. G16/G70/MASCOT-T6/T8/T10/T11/row 11/FS58-T6/T7/rows 70, 75/FS66-W/FS66-T8/FS38-D2-B/M57-T1/T3/T6/T7/M56-T4/G42/G47/row 43/M62-T4/FS56-T1/ASTRA-T5/M61-T4/FS25-T2/M63H3-T3/FS54-T6: §C's "mathematics you stand on" and "things worth knowing" |
| P4 | G7/G12/G14/G62/M31-T1/M32-T1/MASCOT-T7/M63H2-T1/M63H3-T1/T4/T7/T8/row 65: rank-6 lattices as bilayers, their cross sets in closed form, the additive slice at `4 | n`. FS58-T3: the tensor shape. Row 60: residue targets never force |
| P5 | G30/row 31/M56-T2: vacuity (`InheritanceQuestion` carries existence; `VoltageEscape` has a named inhabitant). G40/M55-T1/T3/row 49: the swap as a repaint. Rows 51, 56, 66: existing kernel lemmas. Searching rules: query Mathlib by shape before writing |
| P6 | G67: form of new entries. G69 correction (745 vs 23,083). Row 77 / FS58-T4 kernel note and FS-39's phase A (Mathlib holds the compactness lemma) |

*Tally, counted by script and by hand (G21: a count typed before counting was wrong by 16 in § B and by 4 in the grokkings,
and is corrected here): grokkings B 43 / S 27; rows B 33 / S 44; § B B 91 / S 163; method rules in §G.4 B 17 / S 2. Every B
appears as an instruction in the table above or in §S's phase rows.*

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
| **P1d** | A | **The H1 census over K.** De Grey's lattice and its rank-4 siblings: the Moser lattice of row 46 if different, and `⟨ζ₁₂, ρ^{±1,±2}⟩` if rank 4. Targets: every lattice point with `|δ| ≤ 4`, graded by the 2-adic depth at each prime above 2 (row 59, R59-T1, MASCOT-T1/T2). Periodic screen at `N ∈ {2,4,6,8,10,12}` lists the **H1-found** targets. Subtract the known-forced: 8/3 (Harder), 8/√3 (M56), and any whose status is in record (row 26, G9). For the rest, **forcing asks**: Minkowski balls aimed at average degree ≥ 14 by G65's law, never word balls; asked on their `k+1`-cores (M55-T4, M63H4-T2/T3); cubes on a pinned pigeonhole when monolithic CDCL caps (G18); growth mode after the first undecided radius (G33); M53-T12's no-finite-extension certificate wherever it applies (G36); every refusal checked for an empty critical set (G39, M54-T1). **Positive control**: Harder's 8/3 refuses (reproduce 2.7 s at 23,083 points). **Negative controls**: 2 and 4 escape. Register row 67's P-D3 depth by depth (§P) | ≤ 5 core-h; ≤ 1,500 s per ask; stop per target after 3 radii or 3 undecided asks | `data/fs73/census/K-rows.jsonl`, one row per verdict; `python3 tools/fs73_screen.py census K --resume` skips rows present; a kill redoes the one ask in flight |
| **P1e** | A | **The rich 2-unit lattices over ℚ(√3,√5)** (`twounits:14/30/42`), rigid under FS-70 only on generator graphs at `N ∈ {2,4}` plus the 48 additive colourings (T8). **First** the gap-aimed finder at `N = 5, 7` (P-M2's live half; a gap closes them by T6). Then saturation, priced first; if unaffordable, every row is labelled "generator graph". Then forcing asks at the five depth classes (FS70-T1/T7), P-D3 in view | ≤ 3 core-h | `data/fs73/census/rich-rows.jsonl`, as P1d |
| **P1f** | A | Census record `data/fs73/census/README.md`: every row gives lattice, saturated or generators, `N`, finder, verdict, target, `W′`, seconds, machine (G21). The **informative-instance list**: targets that are H1-found with forcing undecided, or forced where H1 was established another way. **Uninformative outcome, declared and reachable:** every target is known-forced, escapes, or is undecided at every radius afforded. Then the competition is briefed with that negative list, which is itself §C content | — | — |
| **P1g** | A | **Poros's card** (P-R1): on L3's `N = 2` colouring, the Smith form of `V` in `2Λ`, the escape at each target, the re-periodised colouring's period, and whether it is constant on the cosets of `2Λ` or of some `3^jΛ` | ≤ 30 min | none |
| **P2** | A (if < 300k tokens), else a fresh B | **The classification.** Rows: **K** (control), **ℚ(√3,√5)** (control: reproduce T5's six-subfield table), **ℚ(√3,√23)**, **ℚ(√3,√47)** (FS-48), **ℚ(√11) at k = 3** (positive control, row 73), **ℚ(√167) at k = 3** (FS-59's question), **one CM subfield of K(√7) at k = 5** (the pilot for six: G48, row 64). Columns per quartic CM subfield `E` and saturated lattice `Λ_D` (D ∈ {6, 12, 24}, priced): (a) the 3-adic pole (FS70-T3, row 45); (b) the 2-adic column, 2-unit or wall-broken, with C1 as a sub-column (G1, G35, G56, M53-T5, FS54-T2, row 63, M58-T3); (c) **spectral**: `m(Λ)/d` against `−1/(k−1)` and the minimisers' torsion orders (FS38-D2-A, FS53-T1, FS54-T7); (d) per admissible `N ≤ 12`: colourable or refused, gapped, with **target and quotient spectra kept apart** (G44, R52-T1, M58-T1, M61-T2); (e) **composite**: `N` a product of two primes whose single-prime quotients both refuse (FS58-T3's tensor shape); (f) T10 at the **chainable** targets `1/δ ∈ ℤ[U]` (ASTRA-T2, G55). Verdict: loose by theorem (a gap, or an exhibited periodic separator) / rigid-found (with the periods searched) / refusing. Lattices are chosen per field by supply, never carried between fields (FS61-T3, row 74). Ramified targets' first levels are impotent (FS66-E), and every spectral column is blind to the carry (FS66-T); both are stated in the table's header | ≤ 8 core-h; ≤ 300 s per quotient ask | `data/fs73/table/rows.jsonl`; `python3 tools/fs73_screen.py table FIELD --resume`; a kill redoes one ask |
| **P3** | competitors "de Bruijn" and "Coxeter" (fresh Opus 5.5 each) + advisor "Poros" (fresh, or this one if its context allows; the PO decides) | **The competition on C3-inherit**, under `plans/PROTOCOL-competitor-and-advisor.md`: briefs from §C with the census and table pasted in, identical but for the names; isolated scratchpads; teasing hints only; prior art shared; retractions counted by the advisor. **Deliverable** (the PO's ruling, 2026-09-23): a theorem or a counterexample. If neither lands, the headline is **"not landed"**, and under it, each reported as exactly what it is: **(a)** the sharpened reductions; **(b)** the K instance explained by its local lemma (G70, `[Polymath16wikiR2]` Cor. 9) or the statement of why not; **(c)** a sufficient condition (a class of lattices where C3-inherit is proved); **(d)** the census's candidate list, including any counterexample candidate. A theorem's key step is re-derived by the other competitor or by the advisor, and one step by the PO. A counterexample is an explicit construction with proof, plus exact verification of properness and separation on a large finite window | ≤ 400k tokens per competitor; one working session each (≤ 8 h wall); stop when both report | each competitor keeps `plans/FS73-C3-<name>.md` current at every claim or retraction; a killed competitor is replaced by a fresh one reading its file; a kill redoes the thinking in flight |
| **P4** | implementer (A, B, or fresh C) | **Rank 6, re-aimed** (question 3). P1g's answer first. Then for L2, L3, L6 and any rank-6 K-lattice (de Grey's lattice with one ρ₁₅ word, if rank 6): `NΛ/V` under every periodic colouring at `N ≤ 6`, the targets' images, and the re-periodised separators' periods. Read against: C2 and the cross-set closed forms (MASCOT-T7, M63H3-T1, M31-T1, M32-T1, G12, G14); the bilayer as a Σ = n coincidence rotation (G7, G62, M63H2-T1, M63H3-T7/T8); the additive slice at `4 | n` (row 65, M63H3-T4); and Poros's reading that `[NΛ:V]` is an ideal norm (P-R2). Residue targets never force (row 60), so any rank-6 forcing is composite or 2-adic. Deliverable: a mechanism statement (hand) or a typed null. **T10.2's "the deciding invariant" is re-worded at the close** | ≤ 4 core-h; ≤ 250k tokens | `data/fs73/rank6/rows.jsonl`; re-run resumes |
| **P5** | implementer K (Opus 5.5) | **The kernel**: every `sorry` of `Proofs/HadwigerNelson/Kempe.lean` (§K). Query Mathlib by shape before writing (the Searching rules; FS58-T4's note missed `Finsubgraph.lean`). The residual-finiteness step of `not_periodicForces_of_voltageEscape` may need the structure theorem (`AddCommGroup.equiv_free_prod_directSum_zmod`) or a Smith-form argument; price it before starting and report if it exceeds a day. `voltageEscapeZ` must be fully proved (vacuity: every structure-typed hypothesis has a named inhabitant). No statement changes without the planner's re-check | ≤ 2 working days; ≤ 400k tokens | the file itself; every `./scripts/build.sh` run is a checkpoint; a kill redoes the current leaf |
| **P6** | planner (fresh) | **The close** (WORKFLOW 9): `plans/FS73-derivation.md` and `LEDGER.md` § B lines; row 78; the §G re-read; new grokkings in G67's form; P1–P4's predictions scored. Corrections: G69 (745 against 23,083 and "three orders"); FS58-T4's kernel note and FS-39 phase A (Mathlib holds the compactness lemma); T10.2's wording; "rigid" qualified against `[PeledSpinka2023]` and `[AlonEtAl2021]`; the Semantic Scholar re-check. New stubs: C3-aper (`[AbrishamiEtAl2025]` 4.6 at ℤ^r); a `k = 5` rigidity table for 6-open fields if P2's pilot is informative; C3-local merged into FS-67's stub | — | — |

### §S.3 Acceptance checklists (what · verified how · pass condition)

| phase | what | verified how | pass condition |
|---|---|---|---|
| P1a | lattice layer | the four controls | de Grey 54/rank 4, Λ′ 46/rank 4, L3 42/rank 6, ℚ(√11) shape 108; saturation complete to `D` (a brute-force enumeration to `D` agrees) |
| P1b | screens | §R0 reproduced; Theorem B's and Fischer's colourings accepted as solutions; L1 gap found; FS-70's selftest plants all fire | every number equal; every plant fires; no control passes "for the wrong reason" (a paired faithful stub passes) |
| P1c | cross-check | the two instruments' verdicts | agree (the expected, uninformative outcome), or the disagreement is traced to one instrument |
| P1d | K census | rows file; the positive and negative controls | Harder's 8/3 refuses; 2 and 4 escape; every refusal has an empty critical set; every UNKNOWN is typed with its budget |
| P1e | rich lattices | N = 5, 7 gap finder rows; saturation stated per row | every verdict names its graph (saturated or generators) |
| P1f | census record | the PO reads the informative-instance list against the rows | every listed instance traceable to rows; the uninformative outcome, if it happened, stated as such |
| P1g | Poros's card | Smith form printed; coset-constancy test on the swapped colouring, with a planted colouring that *is* 2Λ-periodic as the control | the answer is one of three, stated with the control's pass |
| P2 | table | T5 reproduced for ℚ(√3,√5); K rigid-found at 8/3; ℚ(√11) rigid-found at 3u (k = 3) | the three controls pass; every row's verdict carries its periods searched and its lattice's saturation |
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
   - **T10**: the `(a,b)`-Kempe component of `0` meets each class `x̄` in `p(x̄) + V`, `V` the voltage lattice, and a target
     with `δ − p(δ̄) ∉ V` escapes. This is the periodic Kempe screen, `tools/fs70_periodic_kempe.py`.
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
`Cay(Λ, U)` force it (equivalently, by R1, does every proper 4-colouring identify `0` and `δ`)?

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
  offered as a thing worth knowing, not a result.
- **The 2-adic side is proved at the level of the local plane.** Every 4-colouring of the 2-adic tower of K(i) is pulled
  back from level 4 (FS38-D2-B, row 67). But row 67 registers **P-D3: no finite K²-graph forces 2-adic depth 4**, although
  the tower forces it. The local plane's forcing does not inherit at depth 4, and it does at depth 6 (8/3). That depth
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
  - (b) the K instance explained by its local lemma, or why the local lemma does not explain it;
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
uninformative (§C.2's third bullet); the census and table ([CENSUS], [TABLE]); the four "things worth knowing" on the
discipline, transport, the 2-adic depth split and local-transfer failure.

**"The challenge"**: §C.2's first paragraph, verbatim, and the reporting rule with its four fallbacks.

**Keep "What I want from you" as the template has it**, with one addition: *"Count the retractions on both sides, with what
killed each; and before either competitor's first theorem is believed, ask the second question whose shape the first
could not have answered (the §10a rule of `plans/COXETER-2026-09-08-mascot.md`)."* If the PO reuses this stage's Poros
(`a20773e5a80987272`), its record `plans/POROS-2026-09-23-fs73-plan.md` §0 already holds its written expectation for C3. A
fresh advisor writes its own before its first message.

---

## §K. The Lean skeleton

`Proofs/HadwigerNelson/Kempe.lean`, not imported by `Proofs.lean` until P5 closes it. Elaborated by `./scripts/build.sh`
(2026-09-23: build OK, 177/177 batches, the module rebuilt, `sorry` only at leaves, no other warning after the field
docstrings). Statements:

| declaration | kind | status | source |
|---|---|---|---|
| `KempeClosed C a b K` | def | — | T10's component, graph-generic |
| `kempeClosed_empty`, `kempeClosed_twoColour` | theorem | **proved** (the named inhabitants) | — |
| `kempeSwap` | def | `sorry` in the properness proof | T2/T10 |
| `kempeSwap_apply_of_mem`, `kempeSwap_apply_of_not_mem` | theorem | `sorry` | — |
| `not_forces_of_kempeClosed` | theorem | `sorry` | T2/T10's conclusion |
| `forces_iff_exists_finite` | theorem | `sorry` | **R1**, FS58-T4, Mathlib's `nonempty_hom_of_forall_finite_subgraph_hom` |
| `VoltageEscape π S D k` | structure | — | T10's data as a certificate |
| `VoltageEscape.lift`, `.zero_mem_lift`, `.kempeClosed` | def / theorem | `sorry` (two) | T10 |
| `not_forces_of_voltageEscape` | theorem | **proved from the leaves** | T10.1 |
| `forces_iff_of_quotient_fanGap` | theorem | **proved** (two lines over `FanGap.lean`) | **T6** |
| `not_forces_of_additiveKempe` | theorem | `sorry` | **T2** |
| `IsPeriodicUnder`, `PeriodicForces` | def | — | H1 |
| `not_periodicForces_of_voltageEscape` | theorem | `sorry` | **R3** |
| `InheritanceQuestion` | def (a `Prop`, never a theorem) | — | C3-inherit |
| `voltageEscapeZ` | def | `sorry` in five proof fields | the named inhabitant of `VoltageEscape` (the fan-gap case on ℤ) |
| two `example`s | spec | one `sorry`, one `rfl` | — |

**Read aloud against the informal claims.**
- `not_forces_of_voltageEscape` says: no graph on `A` with edges in `S` forces `(0, δ)` when `δ` lies outside the
  certificate's lift. That is T10.1.
- `forces_iff_of_quotient_fanGap` says: any graph with a homomorphism into the lattice graph has `Forces ↔ =` once one gapped
  quotient colouring exists. That is T6.
- `forces_iff_exists_finite` is R1.
- `InheritanceQuestion` is §C.2's challenge with `k` general: the existence hypothesis (i) is its first premise, H1 its
  second.

**Kernel decision:** the escape direction only; no "rigid" verdict has a kernel consumer. The instances (Λ′, L6, L3,
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
| P-K1 | P5: every leaf closes within budget; the residual-finiteness step of R3 is the costliest | medium | a leaf that needs a statement change / all close |

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

**Retractions in the window, all free.** The planner's count is five: three the planner's (1, 2, 3) and two Poros's
(P-S1 and the walls note). Poros's own count is three and one: it records P-S1 as a lost prediction, not a retraction.
The planner's mid-stage status message to the PO said "four mine and one Poros's". That was wrong, and the hand-back
corrects it. None was committed. **Disagreements outstanding: none.** One
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
