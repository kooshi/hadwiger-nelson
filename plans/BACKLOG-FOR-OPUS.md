# The stub backlog, triaged for an engineer (written 2026-09-08 by de Bruijn at the M61 close, for Opus 5 on Kooshi's request)

*Kooshi's framing: Opus 5 builds to a spec and optimizes existing code as well as I do or better; what it should not be asked
for is the recognition step (G46) — which classical theory a wall belongs to, which reading to promote, which stub to rank.
So this file splits the frontier set into work that has a spec and an acceptance gate (BUILD), work that is a bounded
measurement whose numbers I read later (MEASURE ONLY), and work that is derivation or judgment (LEAVE). Every BUILD item names
its inputs, its steps, its acceptance gate, and its stop rule. Read `CLAUDE.md` (all of it — the standing rules are the
expensive lessons), `WORKFLOW.md`, `DEBRUIJN.md` first; the trust discipline is the point of the repository.*

## Ground rules for every item

* **Branch `backlog`**; one commit per item's natural checkpoints; commit messages say what landed and what its trust is.
* **Never `lake build`** (bare or named) — always `./scripts/build.sh`; one heavy job at a time; HALT on any unexplained crash;
  checkpoint anything over fifteen minutes; run long jobs from a snapshot copy of the script in `build/` (gitignored).
* **Every verdict line names its population and its trust word** ("verified colouring" / "the solver's refusal, untrusted" /
  "unknown at N s"); a solver's UNSAT is never written as a fact; a SAT model is re-verified against the property it was asked
  for, not only against properness (M61 §R5 is the incident).
* **Do not edit** `Proofs/HadwigerNelson/{UnitQuadrance,ResidueObstruction,Lift,Sat/*}.lean` or any module a certificate imports
  (rebuild hours); new content goes in new modules and `Instances/`; register new theorems in `scripts/Axioms.lean`.
* **Do not write** to `CLAUDE.md` § Frontier / § Grokkings, `plans/FRONTIER-STUBS.md`'s ranking, or any milestone's §S/§M
  sections. Results go into the stub the item belongs to as a `## §B. Built (Opus 5, <date>)` section, records into `data/`
  with a README row (the licence column: what a reader may conclude, kernel or not), and a line in `data/m53/jobs-ledger.txt`.
* **Never delete a stub**; demote with a banner. **Never resume the descent** (M51/M53): it is residue-blocked by theorem (M60 §R7).
* Report in the house format (`WORKFLOW.md` § How to report): plain English, every decision with its alternative and confidence.

## BUILD — spec-shaped, with acceptance gates (in the order I would run them)

### B1. Theorem B in the kernel — `plans/STUB-field-wall-kernel.md` (FS-4). **The highest-value item.**
The stub is already a build spec: §2 gives the elementary route (the order ℤ[ζ₁₂, T], the residue map to 𝔽₄, conjugation
preserving the prime, the DVR characterisation, unit vectors are units, the coset colouring), §3 the Mathlib names probed against
the pinned version, §4 the two design choices (take the `IntermediateField ℚ ℝ` carrier and an explicit `𝔽₄ ≃ Fin 4`), §5 the
price (600–900 lines), §6 the spec examples that MUST ship (the Moser spindle's seven points coloured by φ and proper on its
eleven edges; the four residues of ζ₆, ρ, σ, τ₅; the planted red at distance 2). Deliverable: `Proofs/HadwigerNelson/FieldWall4.lean`
(or a name matching the module's content) with `four_colorable_of_seam_field`, its `le_antisymm` with the Moser instance giving
`χ(K²) = 4` exactly, registered in `scripts/Axioms.lean`, on `[propext, Classical.choice, Quot.sound]`. Acceptance: gate green
(build, axioms, lint), the three spec examples, and `#print axioms` on the headline. Stop rule: if `AdjoinRoot` over ℤ fights
(the stub's named risk), take the fallback the stub names (`Algebra.adjoin ℤ {ζ₁₂, T}` as a subalgebra of ℂ); if the DVR TFAE's
hypotheses cost more than 300 lines, stop and write down exactly which hypothesis and why. Run the WORKFLOW's modeling passes
freshly (they are Skill invocations); they will not change the mathematics, they will change the statement's shape, and the
change is welcome.

### B2. Kernel promotions with the existing pipelines
(a) **`χ(UD(𝔽₁₉, 2)) = 5` exactly.** The upper half is in the kernel (`chromaticNumber_finitePlane19_le_five`, M61). The lower
half is the solver's refusal of four colours on 361 vertices / 3,610 edges (`data/fplane/chi-p19-k4.json`): produce its LRAT with
the M42 chain (`Instances/Core23/` is the template: the CNF at k = 4 with the pinned palette closure over a clique — at 19 there
are no triangles, pin an edge — the emitter, the segmented replay) and state `chromaticNumber_finitePlane19 : (finitePlane 19).chromaticNumber = 5`
in a new `Instances/FinitePlane19.lean`. Acceptance: kernel-replayed, standard three axioms, a red (a corrupted clause table refused).
Price: the M42 chain took an afternoon at 23 vertices; here the CNF is 1,444 variables — measure the LRAT size before committing
to the segment layout; if it exceeds ~200,000 lines, stop and report the size (it would be M06-class).
(b) **`χ(UD(𝔽₇, 2)) = 4` and `χ(UD(𝔽₃, 2)) = 3` exactly** (the planes Vinh computed and the web session verified): tiny LRATs
(49 and 9 vertices) or, at 3, `decide` over all `3⁹` functions if it elaborates in under a minute; same module family. Low
value each, but they complete the kernel's table of every known exact plane.
(c) **The 883-point copy-lock core** — `plans/STUB-certify-core883.md`: priced there (the M06 geometry pipeline at height 4 in
`ℚ(√3, √5, √11)`, the M42 LRAT chain at k = 4 over 4,625 edges). Acceptance as in the stub (`core883_not_colorable_four`,
`core883_unit`, the corollary). It is a known bound by a new witness; Kooshi's call whether it is worth its two to four sittings —
ask him before starting, with B1 and B2(a) done first.

### B3. The first digit at 23, as a budgeted computation — `plans/STUB-first-digit-23.md` (FS-17)
Two priced routes, both pure engineering: (i) cube-and-conquer on the PLAIN five-colouring instance of UD(𝔽₂₃, 2) (529 vertices,
6,348 edges; `tools/fplane.py chi --p 23 --k 5 --pin-clique` writes the base CNF), cubes = the proper 4-colourings of ONE hexagon of
the origin's neighbourhood (732 colourings, reduced under the stabilizer and the palette to ~15 — write the reduction and verify it
by re-deriving the count), each cube an external-cadical run under a wall, checkpointed per cube; (ii) the same split on the
independence instance at 106 (`build/m61/alpha.py`'s CNF, or `fplane.py alpha --p 23 --N 106`). Hard budget: 24 desktop-hours total,
then stop. Outcomes and what to do: a 5-colouring FOUND → verify it, write `chi-p23-k5.json` with the colouring, and certify it in the
kernel as a 529-entry table through the M58 pattern (`Instances/FinitePlane23.lean`: `chromaticNumber_finitePlane23_le_five`) — that
is spec-shaped and settles the first digit at 23 as "5" (its lower half stays the spectral floor); every cube REFUSED → write the
record (χ(23) ≥ 6 on the solver's word) and STOP — do not attempt the LRAT (M06-scale) and do not mint a field list (mine);
undecided at budget → the record says so with the cube tally. Never report a refusal as a value.

### B4. The arity floor of the 11-plane: 4 or 5 (T43)
`tools/fpcompel.py arity --p 11 --k 5` does arity 3 (31,602 questions through the origin, all realized). Extend it to arity 4 through
the origin (4.2 million (4-set, pattern) questions) with the M48 engine (`tools/arity.py`: pair colour-agreement masks over a
harvest of colourings, observe-then-confirm, the solver only on what nothing wore, every model returned to the pool). Acceptance:
either every question realized on a verified colouring (`arityFloor(UD(𝔽₁₁,2), 5) = 5` — the floor bracket `{3,4,5}` is in the kernel,
the `≥ 4` half would be by colourings alone, tools only) or a compulsion confirmed in two encodings with its sub-3-sets verified
free. Record `data/fplane/arity4-p11-k5.json`, README row, the verdict's population in the headline. Price: the M48 sweep did
3.3 billion questions in 46 s of masks plus 900 s of solver; this is smaller.

### B5. The residue-allowed asks (FS-16's measurement half) — `plans/STUB-residue-allowed-distances.md`
The 51 undecided asks of M55 at residue norm 1 (`data/fplane/residue-filter-W-plus-cross-depth2-p11.json`) — run each as a
five-colour virtual-edge ask on the assembled 10,541-point stage with the walled external cadical (M55's ask protocol,
`tools/five_dial.py` / `absorb_dial.py`; 2-h wall each, checkpoint per ask, parallel across cores). Record every verdict with its
trust; a SAT model is verified as a proper colouring that IDENTIFIES the pair. A virtual edge found (UNSAT in two encodings) is
the jackpot clause: HALT AND VERIFY, then stop and report — do not build the spindle, do not interpret. Also spec-shaped: the
per-stage "residue-allowed graph" census the stub's D1 asks for (count pairs at residue norm 1 per stage; the fraction against
the 1/11 baseline). The "why" stays with me.

### B6. The hub scan's rainbow test (FS-12 D1) — `plans/STUB-hub-scan-design.md`
`tools/fplift.py hubs` lists an object's exact depth-one hubs at a prime. Add, per hub, the A1 test: is the hub's support (its
unit neighbours in the object) forced rainbow in every five-colouring of the object — one SAT ask (restrict the support to four
colours; UNSAT = forced rainbow = the hub is a kill point at five colours; SAT model verified). Run on Heule-510 at 131 (1,171 hubs)
and the 1581 at 131 (3,739 hubs), walled and checkpointed. Record `hubs-<stage>-p131-rainbow.json`; headline: how many hubs of
support ≥ s are forced rainbow, by s. Any nonzero count at five colours is a HALT AND VERIFY (two encodings) — a kill point at five
colours over a 6-open field would be the first, and it is mine to read.

### B7. The Haugland 7-adic check — `plans/STUB-haugland-7adic.md` (FS-8)
Fetch arXiv:2608.04542 into `~/source/library/` (the bibliography rule: add the copy path and the read status to `BIBLIOGRAPHY.md`);
extract his field (ℚ(cos 2π/7) plus whichever square roots the detuning adjoins) and, if published, his coordinates. Run the stub's
D1 (the residue degree at 7 of each adjoined radical — 7 is totally ramified in ℚ(cos 2π/7) with residue field 𝔽₇, so a degree-one
prime exists unless some radical is a non-square mod 𝔭) and, with coordinates, D2 (reduce every vertex modulo 𝔭 and check every
edge lands on the circle of UD(𝔽₇, 2) — `fplane.py reduce` is the template; the cubic base needs its own residue map, written and
self-tested against the ring radii). Outcome: either his field has 7 usable and χ(UD(𝔽₇,2)) = 4 makes his 5-chromatic claim
suspect (report; do not adjudicate), or a named radical makes 7 inert and the sieve's row for his field is written. Cheap.

### B8. The plane instance of `extends_of_hubs` (FS-5's spec-shaped half)
`Absorb.lean` holds `extends_of_hubs`; M55 measured that every spindle-copy union satisfies its hypotheses (each cross chord but the
spindle chord is a hub chord). Build one kernel instance: a `Copy.copyUnion` (M52's `Copy.lean`) shown to satisfy the hypotheses
from census data, so the union's extension at five colours is a theorem — the certificate shape for "this union carries no
compulsion among the fabric". Spec: the two-spindle full-fabric union of M54 is the natural object; the hypotheses are decidable
on the edge list. The ν = number-of-spindles law (T25) is a derivation — leave it.

### B9. FS-6's instruments, prepared but not interpreted — `plans/STUB-family-keeping-thickening.md` §H
FS-6 is the next derivation milestone and stays mine (its §S, its passes, its close). Its phase-A COMPUTATIONS are spec-shaped and
can be built and run now, results left in `data/` for me:
(i) **the forced-distance table** — on every held object over a 5-sealed field (Heule-510 and its closure, W and its F₂₄₇ cross
lattice at depths 1–2, the two-core union), every pair with residue norm 0 at 11 (`fpcompel.py filter --pairs` reports the norm;
add `--norm 0` and the exact `d²`, the spindle radicand `4d² − 1`, its squarefree part, and the sieve's verdict on the spindle field
via `fplane.py map`); (ii) **pullback-rigidity at 11** — one SAT ask per object: is there a proper five-colouring NOT constant on some
residue fibre (auxiliary variables over same-residue vertex pairs; the model verified to be proper and to split a fibre); record
`pullback-<stage>-p11.json`; a stage with NO such colouring is HALT AND VERIFY (two encodings) — it would be the first
pullback-rigid object and the milestone's jackpot; (iii) **the residue-pruned forced-pair sweep** — on the stages the M54/M55 sweeps
never covered (the depth-2 cross-thickened witness, the Heule closure), ask forcing at five ONLY for the norm-0 pairs of (i), walled,
checkpointed, two encodings on any UNSAT. Report numbers; do not write the milestone's derivations.

### B10. Cheap table-filling (an hour each)
`fplane.py periodic --below 200` and `theta --below 200` (budgets as they are); `chi --q 27` with the external cadical at a 6-h
wall for the five-colour question; `equivariant --p 31/43/47 --k 5` (the refusals are seconds; the half-turn rows may run to the
budget). Records and README rows; no interpretation.

## MEASURE ONLY — bounded runs whose numbers I read later
* FS-2's Kempe walk (`plans/STUB-kempe-classes.md`): the reconfiguration graph of U's 4-colourings from the eight additive ones
  (M56's `kempe`) and of the 252-cheat object's 5,000 colourings on disk — component counts, whether the forced pair is constant per
  component. The instruments exist; the reading is a mechanism question.
* FS-13 phase 0 (`plans/STUB-finite-plane-cores.md`): the sphere shrink at 59 with hour walls (`fplift.py cores`), one core record.
  The autopsy is mine.

## LEAVE — derivation, judgment, or no spec yet
* **FS-6 itself** (re-aimed by G48, `plans/STUB-family-keeping-thickening.md` §H): the subplan's derivations, the modeling passes, the
  reading of B9's numbers, the close. Mine.
* **FS-9 topological bounds, FS-10 Nullstellensatz certificates**: reading rooms — no recognition yet, so nothing checkable to build
  (G46's corollary). Reading the literature and writing what a checkable statement WOULD be is welcome; building is not.
* **FS-16's "why"** (T44), **FS-12's design reading**, **FS-13's autopsy**, **T25's derivation**, **FS-17's field list if 23 refuses**.
* **The demoted and proved stubs**: `STUB-thickened-material.md` (demoted), `STUB-field-wall.md` (proved; B1 is its kernel form),
  `STUB-nominated-gadgets.md` (the descent's stall response — the descent is closed by theorem).
* **Anything touching the Frontier narrative, the grokkings, or the ranking.** Results reach those through me.
* **Monolithic SAT on the 131 plane or the 1581's 55-direction shadow** (known undecided, CDCL-bound; M58/M59), **the 1581's general
  arity-4 sweep** (2.6·10¹¹ questions), **`lean4checker`** (a publication gate, deferred by standing policy).
