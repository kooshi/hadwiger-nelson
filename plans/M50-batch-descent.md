# M50 — The batch descent (pre-subplan stub; the stub rule, WORKFLOW § Plan)

*Written 2026-08-19 at the M49 close, on Kooshi's go ("write it up with scope, evidence, and
motivation"). This stub carries everything the deciding session knew, so a fresh session with zero
conversation memory can subplan it with all meaning intact. Read `plans/M49-two-distance-descent.md`
§A–§B (the reduction and the dial), §R8–§R10 (the kill engine and the two closing measurements)
first; the engine is `tools/killengine.py`, the campaign scripts as run are `tools/m49/`.*

## Mission context, in plain language

χ(ℝ²) ∈ {5, 6, 7}. To prove ≥ 6 you must exhibit a finite unit-distance graph that is not
5-colourable. Exoo–Ismailescu (arXiv:1909.13177) built a 214-point graph `H` in the seam field
ℚ(√3,√11) that forces two named points `A, B` at distance 5 to be EQUAL in every proper 5-colouring
— but only when its 446 distance-2 pairs are also edges ("cheats"). M49 defined the dial: **μ_H =
the fewest distance-2 edges keeping A = B forced**. The kernel ends are done
(`Proofs/HadwigerNelson/OneDefect.lean`): a forced-equal pair at ANY distance ≥ ½ refutes
5-colourability by a spindle (`not_colorable_of_forced_equal`), so **μ = 1 on any {1,d} forcer IS
χ(ℝ²) ≥ 6**, and μ = 0 is a witness outright. M49's turn of the dial: of the 29 distance-2 edges
that provably lie in EVERY forcing subset ("the floor" — delete any one alone and a separating
colouring exists), **14 are removed in one certified 543-point object** (12 by single seam-lattice
points, 2 by depth-two gadgets), 15 in one more object (one-hot only, §R10). Every removal was
certified: UNSAT with the halo added, second encoding UNSAT, halo 1-minimal with witnesses.

## The engine (M49 §R8–§R9), and why the solver left the loop

The seed is RIGID: `H − e` for a floor edge `e` has only **2–19** proper-5-colourings-up-to-palette
separating A from B (enumerated exactly by blocking clauses, seconds to a minute each,
`build/m49-sep-*.json`). Therefore a unit halo kills `e` iff its **list-colouring problem** — lists
= colours unused on each halo point's seed neighbourhood, halo unit edges as ≠ — is infeasible under
EVERY listed colouring: bit masks and tiny SATs, no forcing asks. (Green cross-check: the 867-ask
solver census agreed with the lookup exactly.)

The candidate space is FINITE per depth, in any field: a killing point needs ≥ 2 unit neighbours in
the object, so it is an intersection of unit circles about two object points — M22's certified
gluing classification (`Glue.sphere_inter_sphere`: intersection = {a point, its mirror}, coordinates
in the object's field extended by `√(4 − d²)`). Depth one over `H`: 9,485 points, **59 radicands**,
51 with ≥ 5 seed neighbours. Depth two: intersections about seed ∪ depth-one points. Feasibility of
the list-colouring is monotone in the point set, so a **whole-set test decides a depth completely**:
depth one is EXHAUSTED for all 17 refusers in every field (some separating colouring extends to all
9,271 points); the restricted depth-two union (52,139 points about seed ∪ the 284 strong depth-one
points) kills 7, shrunk to 1-minimal gadgets of 87–267 points by ddmin under the lookup oracle, all
certified on `H − e` with exact sympy geometry (10-s simplify budget, labelled 200-digit fallback).

**Cost per depth, measured: 1 point at depth one; 87–267 at depth two; whole-set tests are seconds.**

## The two closing measurements that shaped this milestone (§R10)

1. **Kills are context-dependent and order matters, weakly.** All nineteen certified removals at
   once is SAT (each gadget was designed against `H − e` with the OTHER 445 cheats present).
   Sequential commits: 2–3 of the seven gadgets compose depending on order (small separating-lists
   first was best; context can HELP too — `(133,150)`'s gadget works only after others changed the
   object). So per-edge design + sequential commit wastes certified work.
2. **Batch lists are enumerable.** `|S_B|`, the separating colourings of `H` minus a whole batch
   `B` of cheats (no halos): **684** for the twelve, **1,010** for fourteen, ≥ 3,469 (19 edges) and
   ≥ 5,366 (all 29) at a 30-min cap, climbing 2–3/s — thousands to tens of thousands, not millions.

**Therefore the milestone's frame: design ONE halo against the WHOLE batch list.** A halo that is
list-uncolourable under every colouring of `S_B` removes every edge of `B` at once, with composition
guaranteed by construction — the ordering question is designed out, and certified work is never
discarded.

## Scope — the loop, and the questions inside it

Iterate on the current object (start: `H` itself, or the 543-point composed object — subplan
decides; starting from `H` keeps the lists smallest and re-derives the M49 removals as a control):

1. **Census** (parallel single-deletion, M49 phase-2 instrument): the floor `B` = cheats essential
   alone. The floor GROWS as other cheats are removed — re-census every iteration.
2. **Enumerate `S_B`** exactly (blocking clauses, checkpointed; resume-safe). If it blows past
   ~10⁵: fall back to M48's observe-then-confirm (harvested-colouring masks screen, solver
   confirms), stated as a pool-choice in the rows.
3. **Design one halo against `S_B`** with the kill engine, depth-laddered:
   depth-one whole-set test (complete verdict per colouring) → restricted depth-two → LOCAL
   unrestricted depth-two (all depth-one centres near the hard colourings' mono edges — build the
   unit census with `scipy.spatial.cKDTree`; the coarse grid hung at 600k points, §R9) → pruned
   depth-3 beam (new centres only where a listed colouring leaves lists of size ≤ 2; a beam is a
   pool-choice, not a completeness claim). Shrink by lookup ddmin; per-point necessity witnesses.
4. **Certify** (exact geometry; one-hot + 3-bit on the true object) and **commit**; recurse.
5. **Instrument the stalls**: for colourings no constructible halo kills, record WHICH colourings
   survive and their structure (the ten M49 holdouts' 4–16 colourings are the seed of this study);
   run the **field census** of every kill found (which radicands `√(4−d²)` the points actually
   needed — Kooshi's "odd ratio" question, made a finite report).
6. **Kernel piece** (small): the depth-one completeness corollary — every point at unit distance
   from two object points is a `Glue.sphere_inter_sphere` glue point, so the depth-one lattice is
   complete for single-point kills in any field. Consumer-shaped statement; a sitting, not a phase.

**Completeness caveat, carried from §R10 (state it in every claim):** the depth-`d` lattice is
exactly the unit-compass-constructible points over the object (a 2-tower of quadratic extensions,
height ≤ `d`); a MINIMAL kill has min degree ≥ 2 but need not be 2-generated in construction order
(K₃,₃-type rigid halos escape every depth). "No kill at depth ≤ d" is about constructible halos.
Measured: `H`'s own unit graph is 2-generated from 4,011 of its 22,791 point pairs.

## Evidence this is the highest-leverage move (the close's ranking, 2026-08-19)

* The ONLY from-below direction that has ever returned a nonzero, certified, mechanistic gradient
  (M30–M48 pair/arity campaigns: complete zeros; M49: nineteen certified removals, fourteen composed).
* The instrument is built, cheap (lookups; whole-set tests in seconds), checkpointed, and its two
  designed weaknesses (order, per-edge context) are exactly what the batch frame removes.
* Both exits pay: μ falling toward 1 approaches χ(ℝ²) ≥ 6 (jackpot clause verbatim: **any μ ≤ 1 at
  five colours is HALT AND VERIFY** — re-derive independently, second encoding, report before
  interpreting); a stall is a named finite obstruction (an irreducible distance-2 core at every
  constructible depth) with its surviving colourings as the study objects — G32's registered
  falsifier, found or refuted.
* The mechanism is understood, not pattern-matched: kills are the kernel's own A1
  (`not_colorable_iff_covers`) at points outside the object — forced-rainbow neighbourhoods —
  measured on `(76,78)` (M49 §R4).

## Priors to register at subplanning (sharpen there; these are the deciding session's)

* P-batch: the depth ≤ 2 engine kills ≥ 500 of the ~684-colouring twelve-edge batch list in one
  designed halo — prior 0.5; full batch at depth ≤ 2 — prior 0.25.
* P-floor: after one committed batch iteration the re-census floor grows past 40 — prior 0.6.
* P-stall: some iteration stalls with an irreducible core of ≥ 10 cheats at constructible depth ≤ 3
  — prior 0.6 (the falsifier: it does not, and μ keeps falling — that is the jackpot path).
* P-field: every kill's radicands lie in the 59-list of `H` (no genuinely new field at depth 2 —
  the new roots are distances between depth-one points; count them) — prior 0.4, genuinely open.

## Practical notes

Desktop (32 cores). Rigidity is the engine's fuel: enumerate-then-lookup ONLY where lists
are ≤ ~10⁴ (the k = 4 calibration object, > 20,000 colourings, is NOT engine-suitable — measured,
§R9). Waiters: anchor `pgrep -f "^python3 -u …"` (self-match lesson, memory). One heavy job at a
time. Every row carries `claim_scope`; `unknown` is never a verdict; removals need the triple.
Artifacts land in `build/m50-*.json`; the M49 explorer
(https://claude.ai/code/artifact/97ebb92e-066d-42ea-93aa-662a4cc3cff8) gains an M50 pane at close.
