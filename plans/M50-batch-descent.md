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

---

# SUBPLAN (2026-08-19, on Kooshi's go; WORKFLOW step 3)

## §B. Decisions settled at subplanning (measure → shape)

**B1. Start object = `H` itself, batch = the full 29-edge floor.** Alternative: start from the
543-point composed object (14 already removed). `H` wins on three measurements: (i) `S_B` for
`B ⊆ B'` is exactly the palette-invariant FILTER of `S_B'` (a colouring of `H − B'` proper on
`B' ∖ B` is a colouring of `H − B`; properness is palette-invariant, so one representative per
orbit filters to one representative per orbit) — **one enumeration of `S₂₉` serves every
sub-batch**; (ii) every M49 asset (17 depth-one kill points, 7 certified gadgets, the per-edge
`m49-sep-*` lists) is a cover seed and a green control on `H`; (iii) the composed object's lists
can only be supersets. Fallback if `S₂₉` outruns the cap: commit the known 14 first and enumerate
the residual floor's list on the composed object. Confidence high.

**B2. Design = greedy set-cover of the colouring list, sound by monotonicity.** The load-bearing
fact (already exploited in M49's whole-set tests, now stated as the design principle): **killing is
monotone increasing in the point set** — adding points adds constraints, so infeasibility is
preserved. Hence the union of per-colouring kills kills every colouring it covers, and the design
loop is: pick an uncovered colouring `c` (hardest first — fewest small lists), find a kill `K_c`
(lookup ddmin against `{c}` alone — cheap), add it, recompute coverage of ALL colourings by lookup
(one small SAT per colouring), repeat until covered; then one global ddmin shrink against the full
list if affordable, else per-point necessity witnesses only, and the shrink level is stated in the
row. Alternative rejected: ddmin of the whole union against the whole list from the start — each
check costs `|S|` SATs (M49's shrink at `|S| ≤ 19` took minutes; at `|S| ~ 10⁴` it would take
days).

**B3. Provenance from birth.** Every candidate point carries a construction record —
`("seed", i)` or `("glue", a, b, sign)` with `a, b` earlier point indices — so exact sympy
coordinates and the field tower are derived recursively, never searched for after the fact (M49's
`certify_halo` had to rediscover each point's defining pair). This is also what makes the
recursion's certification object-generic.

**B4. Instrument = new `tools/batchkill.py`, object-generic.** `killengine.py` computes `H`-specific
globals at import; the recursion needs an `Obj` (points + provenance, unit edges by `cKDTree`
census, cheat edges, `A`/`B` indices, fingerprint) threaded through every function. `killengine`'s
exact-geometry helpers (`seed_exact`/`intersect`/`is_unit`) are imported, not duplicated.

**B5. Soundness note, stated once and cited by rows.** The lookup kills fixed colourings; the
certification ask (`(H − B) + halo`, `A ≠ B`, one-hot + 3-bit) quantifies over ALL colourings — the
bridge is that `S_B` is enumerated EXACTLY up to palette and halo feasibility is invariant under
global palette permutation. Validated at M49 (the 867-ask solver census agreed with the lookup
exactly; nine gadgets certified). The enumeration's breaking order is FIXED (degree order of
`H − B₂₉`'s edge set) so sub-batch filters stay one-per-orbit.

## §C. The kernel skeleton (phase 0 — a sitting)

New leaf file `Proofs/HadwigerNelson/PartnerLattice.lean` (importing `Glue`; §Bʹ item 2):

```lean
/-- **Depth-one completeness.** A point at unit distance from two DISTINCT points is one of the two
glue points of their unit circles — no side condition: both annulus bounds are derivable
(`0 = |1−1| ≤ dist x y` and `dist x y ≤ dist x p + dist p y = 2`). The engine's "single-point kills
live in the partner lattice, in any field" as a theorem. -/
theorem eq_gluePoint_of_unit_pair {p x y : ℂ} (hne : x ≠ y)
    (hx : dist p x = 1) (hy : dist p y = 1) :
    p = gluePoint x y 1 1 ∨ p = reflAxis x y (gluePoint x y 1 1) := sorry

/-- The depth-one candidate space over a finite set is finite: at most `2 · |V|²` points have two
distinct unit neighbours in `V`. Consumer shape for the census claims. -/
theorem finite_two_unit_neighbors (V : Finset ℂ) :
    {p : ℂ | ∃ x ∈ V, ∃ y ∈ V, x ≠ y ∧ dist p x = 1 ∧ dist p y = 1}.Finite := sorry
```

Spec examples: the seed pair `(0, 8)`'s common neighbours 64 and 196 (M49's exact self-test) as a
`#guard`-style example over ℚ-coordinates is NOT available in ℂ — instead one concrete example
(`p = gluePoint 0 1 1 1` satisfies both distances, `decide`-free via `norm_num`), plus the red:
at `x = y` the statement is vacuous by hypothesis, and a point with two neighbours at distance
`> 2` apart cannot exist (`not_exists` via the triangle inequality) — stated as the adversarial
example.

## §Bʹ. The domain-modeling pass (2026-08-19, fresh invocation) — what it changed

1. **The kernel statement's shape is the POINTWISE disjunction, and that is where the hypotheses
   vanish.** The set form (`sphere x 1 ∩ sphere y 1 = {glue, mirror}`) needs `dist x y ≤ 2` as a
   hypothesis (beyond it the set is empty, not the pair); the pointwise form derives BOTH annulus
   bounds from the witness itself (`0 = |1−1| ≤ dist x y` always; `dist x y ≤ dist x p + dist p y
   = 2` by the triangle inequality through `p`). The consumer is pointwise (a candidate point
   exists; where can it be), so `eq_gluePoint_of_unit_pair` keeps only `x ≠ y` — which is genuinely
   load-bearing (at `x = y` the intersection is a whole circle). At `dist x y = 2` the two glue
   points coincide and the disjunction holds degenerately — no special case. `finite_two_unit_
   neighbors` follows by covering with the finite biUnion of pair-sets; the numeric bound
   `2·|V|²` is prose, not a lemma (no consumer).
2. **Phase 0 lands in a NEW file `Proofs/HadwigerNelson/PartnerLattice.lean`** (importing `Glue`),
   not inside `Glue.lean`: `Glue` has heavy dependents (OneDefect, Triangle, MetaLadder, …) and any
   declaration added there queues their rebuilds (the M11 trace lesson); a new leaf file costs
   nothing downstream.
3. **Provenance is an append-only construction DAG, enforced by a smart constructor and a cheap
   runnable check.** A point is `("seed", i)` or `("glue", a, b, ±1)` with `a, b` STRICTLY EARLIER
   indices; `Obj.add_glue` computes the float coordinates FROM the parents (never accepts free
   coordinates), and `Obj.check()` re-derives every point at 30-digit mpmath from provenance and
   compares — parse-don't-validate at the recursion's boundary, run as a planted control per
   iteration. Cheat edges are pairs of SEED indices and never change across the recursion; unit
   edges are derived data (cKDTree census + fingerprint, recomputed per commit). Exact sympy
   geometry is derived from provenance only at certification (and the field census computes
   radicands EXACTLY only for certified kill points; pool-level radicand statistics are 50-digit
   numeric with clustering, labelled as such).
4. **The design loop gains a stage 0: the empty-list sweep.** Under a FIXED colouring `c`, a
   candidate point whose avail mask is empty is a single-point kill of `c` — a bitmask scan, no
   CSP. M49's data says forced/empty-list points are common per colouring (~50 forced of ~200
   small-list at depth one), so most of `S` should be covered by single points before any CSP kill
   is designed; the greedy cover runs: empty-avail sweep → per-colouring CSP kills for the residue
   → coverage recheck (monotonicity: the halo only grows, so covered only grows). New planted
   control in `--self-test`: a known kill must REMAIN a kill after adding random points
   (monotonicity probe).

## §Bʺ. The obligation-modeling pass (2026-08-19, fresh invocation) — proofs derived, invariants partitioned

**The two kernel proofs derive in a few lines each; both were walked before writing.**
`eq_gluePoint_of_unit_pair`: `h2 : dist x y ≤ 2` by the triangle through `p` (`dist_triangle` +
`dist_comm` + the two unit hypotheses); `h0 : |1 − 1| ≤ dist x y` is `dist_nonneg`; then
`p ∈ sphere x 1 ∩ sphere y 1` by `Metric.mem_sphere`, rewrite with `sphere_inter_sphere hne h0 h2`,
and pair-set membership IS the disjunction (`simpa`). `finite_two_unit_neighbors`:
`Set.Finite.subset` of the biUnion over `(V ×ˢ V).finite_toSet` of two-element sets
(`finite_insert`/`finite_singleton`), the subset map sending each witness through
`eq_gluePoint_of_unit_pair`. Red spec example: `¬ ∃ p : ℂ, dist p 0 = 1 ∧ dist p 3 = 1`
(triangle) — the `dist > 2` vacuity, pinned. Mutation audit at the gate: dropping `hne` must break
(at `x = y` the intersection is a circle).

**The instrument's invariants, partitioned prove / test / execute:**
* **Killing is monotone in the point set** (P ⊆ Q ⟹ kill(P,c) → kill(Q,c)): a solution of Q's CSP
  restricts to one of P's (P's constraints are a subset; lists depend only on the fixed colouring).
  Two-line prose in the module docstring; TESTED by the monotonicity probe (§Bʹ). Corollary used by
  the design: coverage rechecks after halo growth can only mark MORE covered — recheck is an
  optimization, never a correctness need.
* **Cover-loop termination, with the measure named**: per depth, the work queue of uncovered
  colourings strictly shrinks each iteration — a found kill covers its target; a FAILED kill (the
  full depth pool cannot kill `c`) permanently stalls `c` AT THAT DEPTH, by monotonicity (no subset
  of the pool can do what the whole pool cannot). Stalled colourings re-enter only when a deeper
  pool opens. ≤ |S| × #depths attempts, no retry loops. The recursion's measure: the cheat count
  strictly decreases per committed iteration, bounded by 446.
* **The sub-batch filter is one-representative-per-orbit** — complete argument, recorded here
  because the control leans on it: (i) a filtered `c` is a separating colouring of `H − B`
  (properness on `H−B'`'s edges plus `B'∖B` = properness on `H−B`'s); (ii) complete — any separating
  colouring `d` of `H − B` is one of `H − B'`, so its orbit has a rep `c ∈ S_{B'}`, and properness
  on `B'∖B` and `c(A) ≠ c(B)` are palette-invariant, so `c` passes the filter; (iii) one per orbit,
  inherited. TESTED end-to-end: the filters must reproduce M49's 684 and 1,010 (phase 2's control).
* **The certification bridge is explanation, never a substitute**: lookup-killing every rep implies
  the solver ask is UNSAT (any separating colouring is a palette image of a rep; the halo CSP is
  palette-covariant) — but the ask is ALWAYS RUN; rows certify the run, "nothing in tools/ is
  trusted" intact. New planted control from this pass: after each commit, ONE known kill's lookup
  verdict is re-checked against a direct solver ask on the GROWN object — the bridge spot-check,
  catching exactly the implementation trap this pass surfaced: **avail masks must range over ALL
  current object vertices (halo points adjacent to A, B, or earlier halos included), not the
  original 214** — the lists' domain grows with the recursion.
## §Bʹʹʹ. The experience-modeling pass (2026-08-19, fresh invocation) — the surface a resuming session meets

The primary consumer is a FUTURE SESSION with nothing but the artifact directory (compaction is
planned); Kooshi reads rows and the report; Lean automation meets the two kernel names. Changes:

1. **Resume is the zero-annotation path.** Every phase command is idempotent: re-running it loads
   its checkpoint, prints what was loaded and what remains, and continues (or no-ops if done). No
   bespoke resume scripts (the M49 pain). `--status` prints the whole campaign state — the first
   command a cold session runs.
2. **The verdict enum cannot say "clean" and cannot promote a pool.** Per-colouring:
   `killed(pool)` / `survives-pool(pool)` (complete AT THAT DEPTH for constructible halos — the row
   cites the §R10 caveat) / `stalled-at-depth(d)`. Per-commit: `committed` (triple) / `candidate`
   (one-hot only) / `refused`. Every row: pool name + fingerprint + parameters, `|S|` with
   `exact|capped` status, the pinned breaking order.
3. **The rigidity gate is structural, not narrative**: enumeration rows carry `gate: proceed |
   blocked`; the design phase REFUSES a capped list unless `--pool-choice-ack` names the sample
   explicitly (G21 made a flag).
4. **The stall list is a first-class deliverable** (`build/m50-stall.json`): per surviving
   colouring — the colouring itself, its mono-cheat set, every pool it survived — because the stall
   is G32's falsifier and next milestone's input, not a leftover.
5. Kernel names stay `Glue.eq_gluePoint_of_unit_pair` / `Glue.finite_two_unit_neighbors` (the
   `Glue` namespace keeps dot-access to the `gluePoint`/`reflAxis` API; docstrings state the
   mirror disjunct and the derived-hypotheses fact, which IS the discovery surface).

## §0. Registered predictions (BEFORE any campaign instrument runs)

Verdict vocabulary as M49: `unknown` is never a verdict; a "removed"/"committed" claim needs the
triple (one-hot UNSAT, 3-bit UNSAT, minimality with witnesses, geometry exact-or-labelled).
**Jackpot clause, verbatim: any μ ≤ 1 at five colours is χ(ℝ²) ≥ 6 — HALT, re-derive the object
independently, re-refute in a second encoding, and report before interpreting.**

* **P1 (the list is enumerable).** `|S₂₉|` exact ≤ 30,000, enumeration complete within 12 h wall
  (checkpointed). Prior 0.6. Failure clause: report the partial count, fall back to B1's composed-
  object route, and state the pool-choice in every downstream row.
* **P2 (depth profile).** (a) The whole depth-one set kills ≥ 40 % of `S₂₉`'s colourings — prior
  0.5. (b) The whole restricted-depth-two union kills ≥ 80 % — prior 0.5. (These are the M49
  17-refuser fractions read forward: depth one killed 12/29 edges but the batch list mixes easy and
  hard colourings.)
* **P3 (the batch commit).** A certified cover halo at depth ≤ 2 removes AT LEAST the 12-edge
  sub-batch in ONE commit (M49's twelve, re-derived with composition by construction). Prior 0.7.
* **P4 (the stall exists).** Some colourings of `S₂₉` survive the whole depth-3 beam — prior 0.6.
  The falsifier is the jackpot path and fires the halt-and-verify clause, not a celebration.
* **P5 (the field question).** Every certified kill's radicands lie in `H`'s 59-list (no genuinely
  new field needed at depth ≤ 2; depth-2 roots come from depth-1-to-depth-1 distances and may
  leave the list — count them either way). Prior 0.4, genuinely open.
* **P6 (rigidity persists — the engine-viability gate).** On the committed object `O₁`, the next
  floor's list `|S_{B'}|` ≤ 30,000 (enumerable). Prior 0.5. Failure clause: the recursion stops
  with the measured blow-up curve as the finding; the engine's scope sentence gains "one
  iteration deep on this seed".
* **P7 (the dial moves).** At the close the composed object's cheat count is ≤ 400 (from 446).
  Prior 0.6.

## §1. Phases (each closes with its numbers in §R before the next starts)

| # | phase | deliverable | control |
|---|---|---|---|
| 0 | **Kernel corollary** (§C) | `eq_gluePoint_of_unit_pair`, `finite_two_unit_neighbors`, standard three axioms | the `dist x y > 2` red; spec examples |
| 1 | **`tools/batchkill.py`** — `Obj` with provenance, cKDTree unit census, checkpointed enumeration, sub-batch filter, whole-set verdicts, per-colouring kill, greedy cover, shrink, provenance certification, field census, stall report; `--self-test` | instrument + tests green | **green control: the 17 M49 depth-one points + 2 composed gadgets, as a halo on `H − B₁₄`, must cover the FILTERED `S₁₄` (1,010) by lookup, and its certification must reproduce the composed object's verdict**; planted-failure reds (a fake kill refused; a moved point failing the census) |
| 2 | **Enumerate `S₂₉`** exact, checkpointed, fixed breaking order; publish the count and the per-sub-batch filter counts (12/14/19/29 vs M49's 684/1,010/≥3,469/≥5,366) | `build/m50-S29.jsonl` + counts | the 684 and 1,010 must REPRODUCE as filters (P1's own control) |
| 3 | **Depth profile** of `S₂₉`: per-colouring whole-set verdicts at depth 1 → restricted depth 2 → local unrestricted depth 2 (cKDTree) → depth-3 beam | P2, P4 numbers; the surviving-colouring list | monotonicity check: kill sets nest by depth |
| 4 | **Cover design → certify → commit** the largest killable sub-batch (target: all of `B₂₉` minus the stall colourings' forced edges) | the halo, its certification row, the new object `O₁`; P3, P5 | triple-check per commit; jackpot armed |
| 5 | **Recurse on `O₁`** (census → floor `B'` → enumerate → design) while lists stay ≤ 30k; stall study (structure of surviving colourings) + field census throughout | P6, P7; `build/m50-*.json` | rigidity gate explicit in every row |
| R | §R, Frontier (ledger row, G-entries), report | | |

## §2. Instruments (the new module's surface)

`tools/batchkill.py` — object-generic, nothing trusted, every row carries `claim_scope`:
* `Obj`: points (floats) + provenance (`("seed",i) | ("glue",a,b,±1)`), unit edges (cKDTree census
  at 1e-7 with the planted-assertion control), cheat edges, `A`/`B`, `fingerprint`.
* `enumerate_seps(obj, B, path, cap_wall)` — blocking clauses, `_brk_full` on the FIXED degree
  order of `obj − B`, one colouring per line (jsonl), resume by replaying the file into clauses.
* `filter_sub(S, keep_edges)` — sub-batch lists by properness masks.
* `partners(obj, centres)` / `depth_pool(obj, level, restrict)` — candidate generation with
  provenance; `beam3(obj, colouring)` — new centres only where lists ≤ 2 (a pool-choice, stated).
* `whole_set_verdict(obj, pool, colouring)` — one list-colouring SAT; `sweep(obj, pool, S)` —
  parallel per-colouring verdicts.
* `kill_for(obj, colouring, pool)` — lookup ddmin against one colouring; `cover(obj, S, pools)` —
  the greedy set-cover loop (B2), checkpointed.
* `certify(obj, B, halo)` — exact sympy coordinates from provenance (10-s simplify budget,
  labelled `numeric-200` fallback), every unit edge verified, one-hot + 3-bit on the true object,
  the row; `field_census(halo)` — the radicand list per point.
* `stall_report(S_surviving)` — mono-edge structure, pairwise distances, shared patterns.
* `--self-test` — the phase-1 controls, runnable any time.

## §3. Discipline

M49's §3 verbatim (double-encoding or kernel for every claim; `unknown` recorded as `unknown`;
triple for removals; jackpot HALT AND VERIFY; segfault HALT; one heavy job at a time; waiters
anchored `pgrep -f "^python3 -u …"`). Plus M50's own: every pool is a CHOICE and its scope
sentence says so; the constructibility caveat (§ stub) is cited in every "no kill at depth ≤ d"
claim; the breaking order is pinned in the artifact header so filters are reproducible.

## §4. Practical notes

Desktop (32 cores, 125 GB). Measured costs the shape already leans on: enumeration
2–3 colourings/s (declining with blocking clauses — the 12-h cap is ~10⁵ at worst); whole-set SAT
1–8 s per colouring at the 52k-point union (30-wide parallel → ~20–40 min per sweep over 10⁴
colourings); single-colouring ddmin minutes. Phase 1 re-measures the sweep cost on a 500-colouring
sample before phase 3 commits its schedule.

## §R. Results (filled as phases close)

### §R1–§R2. The instrument and the exact batch list (phases 1–2) — LANDED, with one incident

* **`tools/batchkill.py`** (§2 surface as modelled): provenance `Obj` (smart constructor; 30-digit
  mpmath `check()`; planted corruption caught), cKDTree pools with fingerprints, checkpointed
  enumeration, per-colouring profile, greedy cover with the empty-avail stage 0, provenance-recursive
  certification, resume-default CLI. `--self-test` PASS (the depth-1 census reproduces M49's
  9,271/25-with-5/22-with-8; the (76,78) kill found by the mask sweep; the monotonicity probe; a
  fake kill refused).
* **The enumeration went through three engines, each forced by a measurement.** The sequential
  blocking loop (M49's instrument) ran at 9/s decaying to 0.5/s — the whole 40 MB CNF rewritten per
  colouring — and would have needed ~30 h. Cube-parallelism v1 (fixed pins, one worker per cube)
  closed 118 of 125 cubes in 100 s and then serialized on 4 heavy lineages — a global-order pin is
  nearly constant inside a heavy cube, so splitting it moved no mass (Kooshi's "still only ~4
  threads" caught it). **v3, the landed engine: entropy-guided adaptive splitting** — an open cube
  splits on the vertex whose colour histogram over its own found colourings is most balanced;
  round-based 300-s stretches; per-cube blocking clauses only; manifest + lockfile. From scratch:
  **|S₂₉| = 51,350 EXACT in 24 min** (five rounds, 461 cubes, every leaf closed by UNSAT).
* **The incident, recorded (G30 genre):** a failed compound command left a first enumerator running
  and a "clean relaunch" started a second — two processes raced the same cube directory for ~20
  minutes and produced conflicting rows (51,350 vs 33,462). Both were discarded, the state wiped,
  a LOCKFILE added, and the clean single-process run re-derived the list from scratch. Its count
  equals the raced run's 51,350 (independent consistency), the serial run's 31,720 are a subset,
  and the sub-batch filters reproduce M49's exact 684 (12-edge) and 1,010 (14-edge) — the §Bʺ
  one-per-orbit argument tested end to end. All three controls green.
* **P1 verdict: MISSED on size** (51,350 > 30,000; the gate's 30k bound was a cost heuristic and is
  now reported as such — the list is EXACT, which is the soundness half; the 12-h half was met with
  hours to spare once parallel). Cost basis for the sweeps: |S| = 51,350, ~10 ms/colouring for
  masks, ~0.3–2 s/colouring for a whole-set SAT at depth 1.

### §R3. The depth profile and the hitting set (phase 3) — 99.2 % of the batch list dies by restricted depth two, and the committable batch is 19 of 29

* **Depth 1** (9,271 points, the complete single-point-kill lattice): **50,192 of 51,350 colourings
  killed (97.7 %)** — whole-set verdicts, every ask decided, 543 s for the full sweep (~95/s at 30
  workers). Reproduced exactly on the rerun that persisted the survivor indices. **P2a (≥ 40 %):
  MET at more than double the bound.**
* **Depth 2 restricted** (52,139 points about seed ∪ the 284 strong depth-1 points): kills **754 of
  the 1,158 depth-1 survivors** — cumulative **50,946 / 51,350 = 99.2 %**; **404 colourings survive
  both pools** (whole-set verdicts, 2,556 s). **P2b (≥ 80 %): MET.**
* **The 404 spread over 22 of the 29 cheats, but the right cut is a HITTING SET**: keep a minimum
  set of cheats such that every surviving colouring is mono on at least one kept cheat — then the
  kept edges exclude all 404 from the committed object's colouring space. Exact minimum (HiGHS, 22
  columns × 404 rows): **keep 10** — `(4,205), (21,210), (38,211), (71,107), (98,213), (118,212),
  (126,203), (206,210), (206,211), (210,211)` — **exactly M49's ten hold-out refusers, rediscovered
  by the batch view** (the five one-or-two-short and the five untouched of M49 §R9). **Committable
  batch: 19 of 29 in ONE commit**; the halo must kill the filtered list of **5,602** colourings
  (proper on the kept ten), every one pool-killable by construction. `build/m50-hitting.json`.
* Per-colouring mono-cheat counts among the 404: 42 colourings pin exactly one cheat, 109 two,
  123 three, 98 four, 32 five — the stall structure is concentrated, not diffuse (the ten kept
  cheats are a genuine core, not an artifact of the minimizer).

### §R4. The batch commit (phase 4) — NINETEEN cheats removed in ONE certified commit

* **The cover**: greedy set-cover over the 5,602-colouring committable list on the depth-2r pool
  (52,139 candidates), most-constrained-first with the empty-avail stage 0. First acceptance: a
  5-point ddmin kill whose points covered 2,876 of 5,602 outright; **full coverage with ZERO
  stalls**; raw halo 709 → global lookup-ddmin shrink → **465 points** (~70 min cover + ~50 min
  shrink; the numpy avail matrix and uncovered-only rechecks are what made it affordable).
* **The commit, certified**: lookup re-check on all 5,602 green; **+11 construction auxiliaries**
  (depth-1 parents of kept depth-2 points — the kill is monotone under adding points, the geometry
  needs the parents; the assert that caught this is the §Bʺ topological-order obligation working);
  all **476 points defined exactly from provenance** (sympy recursion), **2,954 halo unit edges
  verified — 2,646 exact, 308 at 200-digit numeric, labelled per edge**; **one-hot UNSAT + 3-bit
  UNSAT** on the true object (4,165 s end to end). The successful commit subsumes the bridge
  spot-check control (lookup said killed; the solver confirmed UNSAT on the whole object).
* **The object after one turn of the batch loop: 690 points, 427 cheats (446 − 19)** —
  `build/m50-object-S29-depth2r.json` (object-relative provenance; rebuilt deterministically and
  fingerprint-verified). **P3 (a depth-≤2 cover halo commits at least the 12-edge sub-batch in one
  commit): MET at 19 edges.** M49's entire sequential campaign removed 14 in its composed object;
  the batch frame removed 19 in one halo with composition by construction, exactly as designed.

### §R6. Iteration 2 (in progress at the time of writing; TWO instrument incidents, both caught by controls)

**Incident 2 (2026-08-22, caught by the always-run-the-ask discipline):** the iteration-2
enumeration computed its stage as "all cheats minus the floor", silently RE-ADDING the 19
iteration-1-removed cheats as edges — an under-enumeration (1,429 was too small). The design
covered that list, the lookup re-check passed on it, and the CERTIFICATION ASK refused: its
separating colouring was mono on `(22,134)` and `(143,210)`, two removed cheats — diagnosed by a
clause-level witness check after the O(n²) census audit found zero real violations. Fix: removal
sets ACCUMULATE (stage = object − removed − floor), the hitting set draws candidates from the floor
only, artifacts bumped to `-it2v2`, re-enumeration launched. The soundness chain worked exactly as
§Bʺ designed it: the lookup is never a substitute for the ask.


* Floor of the committed object: **36** (kept 10 + 26 newly essential; 427 asks, 0 unknown, 162 s).
* **The seed-projection architecture** (§Bʹ follow-on, forced by measurement): the full-space
  iteration-2 enumeration grew LINEARLY past 31k with 58 leaves open (old-halo colour freedom
  multiplies orbits without adding design information) and was replaced by enumeration blocked on
  the 214 SEED vertices only, with the old halo's colours as CSP VARIABLES in every design ask —
  **|S| = 1,429 seed-classes, exact, 339 s**. The list stays seed-sized at every recursion depth.
* Iteration-2 depth-1 profile (175,166-point pool over the 690-point object, halo variables in
  every ask): **1,325 killed / 41 survive / 63 unknown at cap** of 1,429 (10,824 s).
* Hitting set over the conservative 104 (survivors + unknowns): they touch only 11 of the 36;
  **keep 5, commit 31**. And the five kept are EXACTLY M49's five "untouched" refusers —
  `(4,A), (71,107), (126,203), (206,210), (206,211)` — while M49's five "one-or-two-short"
  refusers all became committable: **the M49 depth-2 status column predicted the split exactly.**
  The refuser core is 10 → 5 after one batch iteration.

### §R5. Kooshi's observations on the refuser-core tool (2026-08-20), verified exactly

The tool (`claude.ai/code/artifact/53172e9e…`, `scratchpad/refuser_core.html`) was built on request
("build it as a tool, give me knobs"); all three observations made on it VERIFY in exact arithmetic:

* **The blind centres v58 / v115.** Neither is a refuser endpoint, yet each locks into the core at
  exact named distances: v58 at distance **1** from endpoints {118, 126} and **2** from
  {71, 98, 107, 213}; v115 at **1** from {98, 107} and **2** from {118, 126, 203, 212} — six exact
  locks each, the two points aligned with the core's "crystal-tip" fan. These are the A1-at-a-
  blind-centre genre (M49's kill mechanism) sitting INSIDE the seed: candidate coverage centres the
  next design round should probe first.
* **The metapivot hexagon.** v0 carries six vertices {14, 161, 105, 49, 126, 70} at EXACTLY equal
  distance `d² = (34 + √33)/12` (≈ 1.947²/… d ≈ 1.9470) at exact angles 0°, ±60°, ±120°, 180° —
  and the ring's six edges all have the SAME length: a perfect equilateral hexagon about v0, at a
  ℚ(√33) ring radius — G4's seam-ring vocabulary at a pivot distance LONGER than the two-circle
  constructions', with one ring vertex (126) a refuser endpoint. The seed is metapivot-shaped at a
  distance nobody has swept.
* **The four-point pigeonhole, and it is total — corrected to Kooshi's intended set and SHARPER.**
  His set was {98, 118, 107, 126} (a typo first gave 213; BOTH close a total pigeonhole). On the
  corrected set the structure is clean: **98≠107 and 118≠126 in ALL 51,350** separating colourings
  (forced-distinct pairs), and **some CROSS pair of {98,107} × {118,126} is monochromatic in every
  one of the 51,350** (mono mass: 107=118 20,524; 98=126 19,576; 98=118 = 107=126 11,250 each).
  And the geometry closes the loop with the blind centres: **{98, 107} are exactly v115's two
  unit neighbours in the core, and {118, 126} are exactly v58's** — each crystal-tip point pins a
  forced-distinct pair on its unit circle, and the four cross pairs carry the total disjunctive
  pigeonhole. Design lever: force the FOUR cross pairs distinct and every survivor dies at once —
  the stall study's first concrete target, four pairs instead of seven.
* **The full forcing sweep over the 17 core points** (his ask, "check the rest"; all 51,350 + the
  404, pairwise + all 3/4-subsets by agreement bitmasks): every forced-distinct pair over the FULL
  space is edge-explained (honest null); on the 404 stall space two genuine conditional virtual
  edges appear, **v71–v118 and v98–v203, both non-edges at distance 3** (120/51,350 overall, 0/404);
  and there are **NO total 3-set pigeonholes but FIFTEEN minimal 4-set ones**, all drawn from the
  same cast (98/107/118/126 recur throughout), Kooshi's quadrilateral the cleanest at four live
  pairs, the family's live-distance vocabulary exactly {√3, √7, 2√3, 3, 2-removed}. Design
  formulation this yields: force distinct a HITTING SET of live pairs across the fifteen
  pigeonholes and every survivor dies — the stall reduced to a handful of named pair-targets.
* **Kooshi's no-stall reframing, registered** (his question, 2026-08-22): if EVERY reachable
  non-5-colourable {1,2}-graph with a distance-2 edge admits a unit augmentation removing one, then
  induction on the cheat count (kernel ends already in `OneDefect.lean`) gives χ(ℝ²) ≥ 6 WITHOUT
  exhibiting the final graph — a de Bruijn–Erdős-flavoured, non-constructive proof shape. Correctly
  stated it must quantify over reachable objects (per-edge removability of the SEED does not
  compose — the all-19 SAT measurement), and in full generality the lemma is EQUIVALENT to χ ≥ 6
  (a unit 6-forcer removes everything at once). Its value: χ ≥ 6 reframed as "stalls have
  impossible anatomy" — and the near-stall anatomy is already sharply constrained (the pigeonhole
  quadrilateral family, blind centres, live distances {√3, √7, 2√3, 3}). A restricted no-stall
  lemma, for the class the descent provably stays inside, plus the concrete chain, would BE the
  theorem. Composes with the crystal generator (material supply vs target statement).
* **Kooshi's construction idea, registered** (his words, 2026-08-20): sweep pivot distances (or
  prove the pivot-ring classification in Lean) while recursing through unit-radius connections to
  build arbitrary crystals, then apply the copy-and-rotate (detune) trick that got the field to
  five — the seed is largely symmetric, unlike the 5-chromatic witnesses, so combining
  longer-distance pivots + recursive unit material + rotation could be a generator of new seeds.
  Filed for the close's ranking (it composes with G2/G7: rings about rotation centres; detuning as
  the mechanism).
### §R0. The kernel piece (phase 0) — LANDED, first sitting

`Proofs/HadwigerNelson/PartnerLattice.lean` (new leaf file, §Bʹ item 2 — no rebuild cascade):
**`Glue.eq_gluePoint_of_unit_pair`** — a point at unit distance from two distinct points is the
glue point of their unit circles or its mirror, only `x ≠ y` assumed (both annulus bounds derived
from the witness, exactly as §Bʺ walked it — the proof is the derivation transcribed: triangle
through `p`, `sphere_inter_sphere`, pair-set membership); **`Glue.finite_two_unit_neighbors`** —
the depth-one candidate space over any finite vertex set is finite (biUnion cover); the red spec
example (no common unit neighbour at distance 3) pinned. Both on axioms exactly
`[propext, Classical.choice, Quot.sound]`; audit lines added (gate seen red first: the M50 block
initially landed in the PURCHASED region and `axioms.sh` refused it — the cross-check working —
then moved to the clean section; 535 clean, the 5 pre-existing purchases). Build green.

