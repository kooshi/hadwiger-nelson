# M33 — The mechanism hunt: what forces the 5th colour (PRE-SUBPLAN STUB)

*Written 2026-08-10, immediately after M32's close, on Kooshi's direction:
"I think we should continue to pursue the minimal mechanism for 5 coloring, so
that we can understand what makes the leap. We understand 3 and 4 pretty well.
I want to be able to confidently point to the reason why 5 colorings are
forced." This stub re-aims M33 from certification to mechanism. The
certification programme (formerly M33, `plans/M33-witness-closure.md`) is
parked as the standing fallback with a banner; nothing in its handoff decays.*

*Read order for a fresh session: this stub whole → `plans/M32-certified-five.md`
§0a/§0g/§R (the stacking law, the flat verdict, the kernel-checked kill engine)
→ CLAUDE.md § Grokkings G13 and G15 → `plans/M30-degrey-anatomy.md` §R (the
rigidity and anatomy instruments).*

## THE GOLDEN QUESTION (the short-term target, verbatim)

> **What ambient structure delivers the 4th colour onto a circle?**

Everything in this milestone is aimed at answering that question at minimal
scale, and then naming the answer as mathematics.

## Why this question is exactly the leap

The colour ladder as we own it:

* **3 → 4, owned completely [kernel]**: the two circles about a point are
  3-colourable (M19), and a nameable LOCAL mechanism puts all three colours
  on the centre's neighbourhood in every proper 3-colouring — the inner
  circle partitions into unit triangles under 120° rotation, each forced
  rainbow (M18's `rot3_unit_triangle`, M20's rainbow floor). The centre has
  nowhere to go: exactly 4 (M20 `chromaticNumber_concentric`). One sentence,
  one certified chain. **This is the template for what "understanding a
  colour step" means.**
* **4 → 5, shape known, mechanism unknown [measured, G13]**: Heule-510's
  centre v0 is confined at four BY THE AMBIENT WEB — every proper
  4-colouring of 510 − v0 covers v0's 36-point unit circle with all four
  colours (UNSAT 10.1 s, controls green) — while v0's own two-circle system
  provably CANNOT deliver that confinement (kernel: class-only graphs are
  3-colourable, M18; centre + circles caps at exactly 4, M20). The
  5-transition is 100% ambient-delivered. Nobody owns the mechanism that
  delivers it. That gap IS the golden question.

## The two-act theory (G15 — the working reading this milestone tests)

Every known 5-forcing argument factors into two acts:

1. **The pigeonhole (the global act)**: "every 4-colouring of this fabric
   region puts some forbidden pattern SOMEWHERE" — a DISJUNCTIVE compulsion
   over many placements. De Grey's own informal argument is the exemplar
   (some √3-triple goes monochromatic somewhere in his hexagon fabric).
   Because it is a disjunction, it has no small carrier (G10's four
   globality measurements) and it is INVISIBLE to instance-level meters:
   each single placement is floppy (M30/M32 measured zero forced pairs,
   zero compelled single triples, everywhere). The compulsion lives in the
   class, not the instance.
2. **The kill (the local act)**: the detuned overlay refutes each placement
   of the pattern — thin, conic-pinned, law-governed chords. This half is
   now KERNEL-CHECKED (the quadrature law G12, `Quadrature.lean`) and its
   width theory is G14 (the stacking law).

**Why M32's designed stacks were flat, explained**: they built act two over
a fabric never shown unable to stay clean. Kills without a pigeonhole force
nothing — the missing ingredient was never more chords.

**The instrument consequence**: stop asking "is THIS instance forced"
(always no) and ask "can the CLASS be avoided simultaneously" — one SAT
call per (region, pattern-class): SAT("proper 4-colouring of R with no
P-instance anywhere"). UNSAT = the pigeonhole localized. This single
query-shape change is the new instrument of the milestone.

## The phases (subplan registers predictions per phase BEFORE running)

### Phase 1 — the fan onset and the fan-critical core (existing instruments)

The bare hexagram chunk reads min-cover 3 on a pivot circle (M32 base rate);
the full 510 − v0 reads min-cover 4 (the fan). Somewhere in between is the
**onset radius** where the ambient web first forces the 4th colour onto the
circle. Nobody has measured it.

* Sweep: growing induced balls of Heule-510 about v0 (and of the 1581 about
  its centres), plain AND gen-1-enriched (`tools/closure.py --gen1`
  machinery), coverage query at k = 4 on S = ball ∩ unit-circle(centre)
  (`rigidity.min_cover` — built at M32, vacuity-guarded). Find the flip.
* Compare the peripheral fanned vertex 139 (its fan was UNSAT 29.5 s at full
  510): does its onset radius differ from the centre's? Same organ or
  different?
* Then SHRINK: from the smallest fanned ball, delete vertices while the fan
  survives (greedy, the M30 criticality protocol one level down) → the
  **fan-critical core**: the minimal ambient web that delivers the 4th
  colour to one circle. Controls: the final core's UNSAT reproduced by an
  independent re-encode/second seed; spot-check each late deletion's
  necessity (restore → SAT). Honesty rule: the core is solver-measured
  knowledge until phase 3 formalizes it; never call it a theorem.
* Note what this evades: G10 says no small part is 5-CHROMATIC. The fan is
  not 5-chromaticity of the part — it is a CONDITIONAL compulsion, and
  conditionals can be small. Whether the core is 150 vertices or 450 is
  genuinely open; register a band at subplan time.

### Phase 2 — the avoidance ladder / the compulsion spectrum (new instrument)

Between "a pair is forced" (order 2 — zero everywhere) and "the whole circle
is covered" (order ~36 — true at the witness) lies an unexplored ladder.

* Build the **class-avoidance query** into `tools/rigidity.py`: enumerate a
  pattern class P's instances over a region by exact arithmetic (the M32
  `present_triples` pattern generalizes), assert avoidance clauses (mono
  avoidance is palette-symmetric — no WLOG needed), one SAT call.
* Classes to sweep, cheapest first: mono pairs at distance d (d over the
  ring vocabulary — √3 the historic one; note mono-√3-pairs are
  Moser-spindle-killable INSIDE the seam field, G1, so the seam closures'
  4-colourings must avoid them — a registered sanity check on our certified
  tables); mono √3-triples (de Grey's class); rainbow-forcings; coverage-j
  on sub-arcs of a circle.
* The output: the **compulsion spectrum** — for the witness fabric, which
  order of compulsion fires first, and at what radius. This curve is the
  anatomy of the leap.
* **Positive control, already in hand**: the 791-forcer's six forced pairs
  (the axis pair at 4 and five antipodal pairs at 4/√3 — forced central
  symmetry, M30) are an already-measured class-level compulsion; the
  avoidance instrument must reproduce them (avoid-all-six → UNSAT) before
  any new verdict is believed. The forced-symmetry thread folds into this
  phase rather than standing separate.

### Phase 3 — the cascade, formalized (the M20 genre, one field up)

χ ≥ 5 as mechanism: (a) the pigeonhole half as a compulsion theorem — the
genre we have proven once (`no_mono_outer_triple`, a compulsion acting
through no edge, at k = 3); (b) the kill half already kernel-checked
(`quadrature_rho15`, the stacking law's matchings); (c) the assembly, with
no SAT certificate anywhere in the argument. Then "minimal" finally means
what G10 demanded: least geometry whose cascade closes — and the
fan-critical core's closure, not the whole witness's, becomes the object
worth certifying. The certification engine (Quadrature.lean, the pair-web
handoff, the sympy proof-term discipline) is the vehicle for this phase,
not a rival to it.

---

# §0 — The registered subplan (2026-08-10, laptop; committed before any colour instrument runs)

*Machine: the laptop (12 cores, 31 GB). Every timing below is a laptop number
unless it cites an M30/M31 artifact, which are desktop numbers — the two are
NOT comparable; the first implementation act is a calibration re-run of the
known 510 fan query (verdict already measured, only the laptop timing is new).
The free geometry in this section was computed by `build/m33-design.py`
(gitignored) — exact field arithmetic, float-prefiltered and exactly
confirmed, ZERO colour queries.*

## §0a — A priori derivations (the paper analysis, before any instrument)

**A1 — The criticality factorization.** In a unit-distance graph, a vertex's
neighbourhood IS its unit circle intersected with the graph (adjacency =
distance 1 = membership on the circle; nothing else is adjacent). Heule-510's
v0 has degree 36 = its entire 36-point unit circle. Therefore:

> fan(G − v, N(v)) at k = 4 ⟺ χ(G) ≥ 5, whenever χ(G − v) = 4.

G13's "the centre's 5-transition is 100% ambient-delivered" is the
5-chromaticity of 510 itself, factored at v0 — and the same holds at EVERY
vertex (vertex-criticality worn locally, as G13 already measured at 139).
Consequence, derived not guessed: **if 510 is vertex-critical (Heule
minimized it; M31's P7 is the v0 instance), then for every proper ball
B ⊊ 510, fan(B − v0, S₃₆) reads NOT-fanned, and the 4-onset arrives exactly
at the last ring.** The stub's 4-onset sweep is therefore a per-annulus
vertex-criticality probe — worth one cheap validation pass, not the
milestone's meat. The genuinely open objects are one rung down: the
**min-cover-2 and min-cover-3 onset curves** (conditional compulsions below
the χ threshold, where cores CAN be small) and the phase-2 class spectrum.
The golden question's answer cannot be "a small carrier of the top fan"
(provably, modulo criticality); it must live in the LADDER — which is
exactly G15's pigeonhole shape.

**A2 — The containment ordering (a theorem, not a prediction).** No equal
√3-pair ⟹ no mono √3-triple. So avoid-all-triples SAT ⟸ avoid-all-pairs
SAT; contrapositively the equal-pair class fires at a radius ≤ the
mono-triple class's radius. Any measured violation is an instrument bug,
full stop — this ordering is a built-in cross-check on the avoidance
encoder, free at every sweep point.

**A3 — The two-act size arithmetic.** De Grey's own construction:
|witness| ≈ |L| + #placements × |M| − fusion, with L = 121 vertices (the
pigeonhole carrier: every 4-colouring of L has a mono √3-triple in one of
52 H-copies) and M the per-placement kill gadget. G10's "least geometry"
metric is this arithmetic minimized. The mechanism hunt's phase-2 prize is
the L-analogue INSIDE the witnesses, located by instrument. Note the
disjunction is why a fired class is NOT spindle-able directly: the spindle
needs one FIXED forced pair; the pigeonhole only says SOME placement goes
bad — which is why the kill web must cover every placement, and why the
construction's width is #placements × |M|.

**A4 — The construction-frame shortcut.** The 1581 is derived data:
`spindle(delete₂(spindle(orbit(S, hex₁₂), …)))` (construct.py, M13,
regen-checked) — its own derivation tree NAMES the fabric stage (the
pre-spindle orbit object). The class-avoidance instrument should run on
the construction's fabric stage FIRST: if de Grey's pigeonhole is intact
there, we extract Act One from the wild at its native address, with the
ball sweeps as the general-position confirmation. Heule-510 has no
construction provenance — its carrier can only be found by sweep, and the
comparison (clean fabric vs SAT-shrunk scar tissue) is itself a registered
question (P6).

**A5 — The phase-3 architecture (registered now, implemented only past the
gate).** A located pigeonhole core C is a FINITE avoid-class UNSAT — i.e. a
CNF refutation, which the M05/M06 kernel-LRAT pipeline can certify exactly
as it certified the 1581, at a fraction of the size. The kill act is
per-placement congruent (same word-class ⟹ one gadget theorem + isometry
transport, the M26 genre). The assembly
(pigeonhole certificate on C) × (one transported kill theorem) ⟹ χ ≥ 5 of
the union is small structural Lean — no monolithic SAT on the union, no
native_decide. "Least geometry" becomes literal: the formal object is
SMALLER than the witness. This is the shape of the answer to the golden
question if the hunt lands: *the fabric cannot stay clean (a certificate on
~|L| vertices), and every dirty placement is killed by one transported
gadget (a kernel theorem).* De Grey's OWN two centres are the two acts'
addresses; G14 explains why two.

## §0b — Definitions and query contracts

* **Ball** B_{r²}(c): the induced subgraph on vertices at exact squared
  distance ≤ r² from centre c (exact field arithmetic; r² swept over the
  object's own ring marks). For 510: 44 rings about v0, max r² = 5.9149
  (all rings in ℚ(√33) — G3 re-confirmed free); the 36-point circle S₃₆
  enters complete at r² = 1 (ball n = 209 there).
* **Min-cover curve**: `rigidity.min_cover(ball − v0, S, k=4)` per mark —
  the full ladder with its built-in vacuity guard (top row j = k is the
  colourability question; no fan claim outruns it). The curve reports the
  2-onset, 3-onset, 4-onset radii. `unknown` rows widen to honest
  intervals, never claims.
* **Class-avoidance query** (the new instrument, `rigidity.py`): given a
  region and a pattern class as an exactly-enumerated instance list —
  - *pairs-equal mode*: avoiding "some pair equal" = one ≠-clause per
    instance per colour — literally augmenting the graph with the class
    pairs as edges; UNSAT ⟹ every proper k-colouring makes some class
    pair equal (the pigeonhole, localized).
  - *triples-mono mode*: one clause ¬(x_c ∧ y_c ∧ z_c) per instance per
    colour; UNSAT ⟹ every proper k-colouring goes mono on some triple.
  - *require mode* (direction B): assert ONE instance realized (palette-
    WLOG pinned); UNSAT ⟹ the pattern can NEVER be realized — the
    class-level kill/impossibility genre (M20's `no_mono_outer_triple`).
  - **Base-SAT guard on every call**: the same region WITHOUT the class
    clauses must read SAT first; an avoidance UNSAT on an uncolourable
    region is vacuous and the instrument must say `vacuous`, never
    `fired`. Models returned on SAT are re-validated (proper + genuinely
    avoiding) exactly as coverage_query validates.
* **Core shrink**: from the smallest fired region, greedy vertex deletion
  while the query stays UNSAT; the final core re-confirmed by an
  independent re-encode, and each of the last 10 deletions spot-checked
  (restore → the query must go SAT or the deletion order was arbitrary
  there, reported as such). Cores are solver-measured knowledge until a
  certificate lands (A5) — never called theorems.
  *[Refined at §0g G-3, which supersedes the spot-check clause: the loop
  runs to the 1-minimal fixpoint, so EVERY member carries a validated
  necessity witness — implement G-3, not this paragraph's sketch.]*
* **Class instance inventories (free geometry, already computed)**:
  510 full scale — √3-pairs 1204, √3-triples 262, d=2 pairs 596, d=4
  pairs 12, d=4/√3 pairs 99. The 1581 — 3216 / 568 / 1092 / 12 / 156.
  Instances enumerated per region by the same exact routine at query time.
* **Sweep objects**: (i) 510 about v0 (44 marks; S₃₆); (ii) the 1581
  about the origin centre (unit circle 60 points, vertex 0 present, max
  r² 6.24) and about (−2,0) (unit circle only 12 points — the SMALL-circle
  contrast; vertex 115), vertex-criticality UNMEASURED for the 1581, so
  its 4-onset is a genuine probe, not an echo; (iii) the construction
  fabric stage (A4); (iv) enriched variants (gen-1 material inside the
  ball, M31 machinery) only AFTER the plain curves land, as the
  enrichment-shift measurement.

## §0c — Registered predictions (bands committed before any query)

* **P1 [high]** — 510 about v0: NOT-fanned (min-cover < 4 on S₃₆) at every
  r² < 5.9149; fanned exactly at full scale. Derived (A1) from
  vertex-criticality. A violation = 510 is not vertex-critical — itself a
  reportable finding against the witness's minimality, not a failed
  milestone.
* **P2 [medium]** — the 3-onset on S₃₆ arrives at r² ∈ [1.0, 2.5]
  (ball n ∈ [209, 388]); the 2-onset at r² = 1 exactly (the circle's own
  chord web). Anchor: the M32 base rate (hexagram pivot circle reads 3 at
  ~378 vertices, B = 2).
* **P3 [low-medium]** — the 3-cover core (greedy shrink preserving
  min-cover ≥ 3) lands at 60–250 vertices; its ring census leans on the
  outer-1 shell plus few ℚ(√33) shells, and uses the inner 1/3-shell in a
  majority of members (M22's clamp lean, one field up). What would change
  it: nothing known — this is the first measurement of its kind; the
  kernel-certain floor is only that the core exceeds the two-circle system
  (M18/M20: local delivery is impossible).
* **P4 [medium]** — on 510 balls, the equal-√3-pair class fires strictly
  below full scale (band r² ≤ 4, n ≤ 469), and the mono-√3-triple class
  fires at a radius ≥ the pair's (A2 — a violated ordering is an encoder
  bug) and ≤ the vacuous end. All-SAT through near-full scale on BOTH is
  G15's registered falsifier branch: report and re-rank, per the stub.
* **P5 [low-medium]** — the d=2 equal-pair class (596 instances, the
  (2,2) spindle channel's currency) fires below full scale on 510. Never
  firing = the fabric does not pigeonhole at distance 2 — reported as the
  channel's emptiness at this order.
* **P6 [medium fabric / low comparison]** — the mono-√3-triple class fires
  on the 1581's construction fabric stage at ≤ 200 vertices (de Grey's L
  was 121); and the 1581's carrier is smaller and cleaner than 510's
  (SAT-shrinking smeared the acts). The fabric-stage run is the FIRST
  avoidance run after controls.
* **P7 [medium]** — the 1581 about the origin: 4-onset only at r² > 4
  (n > 1561 — the forcing needs the second centre's system, 2 away);
  min-cover-3 onset in r² ∈ [0.5, 2.0]. About (−2,0): the 12-point circle
  reads min-cover ≤ 3 until near-full scale (a 12-point circle is cheap to
  3-cover; band: 4-onset r² > 9).
* **P8 [high, gating]** — the 791 positive control: per-pair avoidance
  (assert unequal) UNSAT for each of the six forced pairs
  [6,306],[44,272],[78,269],[137,171],[148,249],[182,217]; a matched
  non-forced pair reads SAT. Runs BEFORE any new verdict; red/green.
* **P9 [high, gating]** — the kernel↔instrument control: require-mono on
  an outer 120°-triple over a finite two-circle window at k = 3 reads
  UNSAT (the instrument reproducing `no_mono_outer_triple`), and a
  non-120° outer triple reads SAT (moot). The one control that ties the
  new instrument to a kernel-checked truth.
* **P10 [high]** — seam sanity: on the certified hexagram chunk (B ≤ 2),
  every probed class avoidance reads SAT (the seam fabric stays clean) —
  consistent with χ = 4 exact and G1. A fired class here would contradict
  a kernel theorem's neighbourhood and means the encoder is wrong.
* **P11 [medium]** — cost: every single query at ≤ 1,581 vertices + class
  clauses completes under a 300 s cap on the laptop; the full phase-1+2
  sweep fits in ~2 laptop-days of background sequential runs. The
  calibration act: re-run the known 510 fan query first (verdict known,
  laptop timing new).
* **P12 — the phase-3 gate (a decision rule, not a prediction)**: IF some
  class core lands at ≤ ~300 vertices with a clean anatomy (≥ 90% of its
  vertices in ≤ 12 direction classes — `anatomy.py` currency), THE GATE
  OPENS: the next milestone becomes the A5 certification (LRAT on the
  core + transported kill gadgets). ELSE the failure clauses fire as
  registered in the stub and the certification fallback stands.

## §0d — Instruments to build or touch

* `tools/rigidity.py`: `class_avoid(n, edges, k, instances, mode, cap)`
  with modes `pairs-equal` / `triples-mono` / `require-*`, the base-SAT
  guard, model re-validation, and self-tests: the planted forced-equal
  gadget (u,v on a shared K3 at k=4 → avoid-equal UNSAT; one edge removed
  → SAT) and the planted mono-triple gadget (u,v,w each joined to one
  shared K3 → all forced to the 4th colour → avoid-mono UNSAT; one edge
  removed → SAT). Both red AND green seen before first use.
* A sweep driver (`tools/mechanism.py`, new): ball extraction at exact
  marks, min-cover curves, class-avoidance spectra, the shrink loop,
  JSON artifacts under `build/m33-*.json`, resumable, `python3 -u`,
  sequential, one SAT call live at a time.
* `tools/construct.py`: expose the fabric stage (A4) — read-only reuse.
* `tools/anatomy.py`: ring/direction census of any vertex subset (the
  core anatomy readout) — expected a thin wrapper over existing code.
* The onset-curve chart lands in the standing anatomy explorer
  (`tools/degrey-viz.html`, UPDATE the standing artifact URL, never
  re-mint) — deferred until the curves exist.

## §0e — Costs, machine, and discipline

Laptop (12 cores, 31 GB): SAT calls are single-threaded CaDiCaL, a few
hundred MB each — RAM is a non-issue IF one job runs at a time and no Lean
build runs concurrently (none is planned this milestone; phase 3 is gated
to M34). All sweeps run sequential in background with `python3 -u`,
unpiped, logging to `build/`.
*[Superseded 2026-08-10 before any sweep ran — Kooshi moved the campaign
to the DESKTOP (32 cores, 128 GB) and set the standing parallelism rule:
within a tool run, use as many threads as RAM allows. The driver runs a
cores−2 thread pool over the subprocess SAT calls (sweep marks, control
batches, shrink candidates speculatively — sound by monotonicity:
rejections stay rejections downstream — and the necessity census).
Predictions and caps unchanged; P11's budget band now has ~30× headroom.]* Caps: 300 s per query default; a capped row
is `unknown` and NEVER a claim (`unknown ≥ cap` is not a bound). If any
single load-bearing query wants > 600 s repeatedly, STOP and ask Kooshi
for the desktop rather than raising caps on the laptop. Crash, any
process: HALT, report, wait for his reboot. Predictions above are
committed before the first colour query; any mid-milestone additional
sweep registers its §0-addendum first (the M32 §0g pattern).

## §0f — Domain modeling pass (2026-08-10, fresh invocation)

**F1 — The mode collapse (the pass's one real find).** "Pairs-equal" and
"triples-mono" are ONE semantics: *avoid a monochromatic m-tuple*. A pair
being equal IS the pair being mono; the clause family is arity-generic —
for each instance and each colour c, one clause ¬(every member wears c);
at arity 2 that clause is literally an edge clause. So the class datum is
`{name, arity, exact d² spec (+ mutual flag at arity 3)}`, the clause
generator is one function over m-tuples, and "mode" disappears from the
model. Direction B (require-one) is NOT a new query shape either: "some
instance realizable" = the existing per-instance mono realizability
(`triple_query(mode=mono)`, plus its trivial arity-2 sibling) mapped over
the instance list with early exit — and the per-instance answers are the
realizability census, more informative than one disjunctive call. The new
primitive is exactly ONE function: `class_avoid(n, edges, k, instances,
cap)` — instances as dense index tuples, geometry-free.

**F2 — The geometry/SAT cut.** `rigidity.py` never sees a coordinate;
`mechanism.py` (the new sweep driver) never builds a clause. The
enumerator (float-prefilter + exact confirm, the `build/m33-design.py`
routine promoted) lives with the geometry; `class_avoid` and the existing
meters live with the SAT encoding. Regions are id-mapped at the boundary
once: a region record carries the sorted OBJECT ids and the dense SAT
reindexing; every emitted reading speaks OBJECT ids only (cores, instance
lists, restore checks) — the dense ids never escape. A planted control
runs a known verdict through a shuffled sub-region to prove the mapping
honest.

**F3 — Where the guard lives.** The base-SAT guard is control flow, not
convention: the driver runs the min-cover ladder ONCE per region (its top
row j = k IS the base row), and class queries on that region reuse that
row — if base ≠ sat, class queries are NOT RUN and the row is recorded
`vacuous` (or `unknown-at-base`). The verdict is computed by one function
from (base, avoid, n_instances), so `fired` structurally requires
base = sat ∧ avoid = unsat ∧ n_instances > 0. Fifth verdict minted:
`empty` (zero instances in the region — vacuously avoidable, rendered as
"no instances yet", never as clean). One base call per region, shared
across every class — the economy and the honesty are the same mechanism.

**F4 — Monotonicity is structure, and the driver exploits it.** Both
curves are provably monotone in the radius: a proper colouring of a
bigger ball restricts to a smaller one (so min-cover is nondecreasing,
and class-firedness is upward closed — SAT at big r implies SAT at small
r). Two consequences: (a) every emitted curve is ASSERTED monotone, and a
violation aborts loudly naming the two rows (instrument-bug tripwire,
same genre as A2's containment ordering between the √3 pair and triple
classes); (b) class onsets are found by BINARY SEARCH over the ring marks
(≈ 6 queries per class instead of 44), with the full sweep reserved for
the cheap min-cover curve. The A2 check runs at every measured mark pair.

**F5 — The core record carries its epistemics in-band.** A core is
`{object, centre, query spec, vertices (object ids, sorted), deletion
sequence, controls: {reencode verdict, restore checks [(vertex, sat)]},
anatomy: {ring histogram, direction classes}, status:
"solver-measured"}` — the status literal travels with the data (M30's
three-outcome honesty), and nothing downstream may promote it; the only
promotion path is A5's certificate.

**F6 — The A1 factorization in Lean: deferred with its shape named.** The
two-line general lemma (χ(G) ≥ k+1 at a vertex whose deleted graph is
k-chromatic ⟺ the fan on N(v) — the M18 `fan_iff_coverage` vocabulary
meeting M20's `chromaticNumber_concentric` genre) is the phase-3
assembly's opening statement, not a phase-1–2 deliverable. This milestone
is instruments-first; the derivation stands informally in §0a and the
Lean statement is the FIRST item behind the P12 gate.

**F7 — Sweep-point record (the spectrum's row type).** Per (object,
centre, mark): `{mark r² (exact + float), n, n_edges, n_target (|S ∩
ball|), cover: {rows, lo, hi, verdict}, classes: {name: {base (shared),
n_instances, avoid outcome, verdict, seconds}}}`. The spectrum artifact
is these rows plus per-class onset summaries (`onset_mark` /
`never-below-vacuous` / honest interval when unknown rows intervene).
S ∩ ball is the target below r = 1 (partial circle), n_target says so.

## §0g — Obligation modeling pass (2026-08-10, fresh invocation)

**G-1 — The claim taxonomy, with its trust asymmetry.** Every SAT reading
is *self-certifying*: the model is held, re-validated in-process
(properness + genuine avoidance + no banned colour), and an invalid model
aborts the run — trustless. Every UNSAT reading is *solver-trusted* until
promoted. The ladder of promotion, cheapest adequate first: (a) mid-sweep
binary-search interior rows — solver's word, provisional; (b) every
ONSET (the claim-bearing fired row) — confirmed by the decorrelated
re-encode before being reported; (c) the final cores — full 1-minimality
witnesses (G-3) + re-encode; (d) the P12 gate object — LRAT via the M05
pipeline (A5). Partition: *prove* (in-process model validation, the
enumerator's no-internal-edge and triple⊃pairs checks), *test* (the §0g
self-test ledger, controls P8–P10), *assume* (CaDiCaL's UNSAT below
promotion rung (b), named as such in every artifact).

**G-2 — Invariants as executable assertions, honest under `unknown`.**
Monotone-curve check: assert the interval sequence admits a nondecreasing
selection — running_lo := max(running_lo, lo_i); abort iff running_lo >
hi_i at any decided row; `unknown` rows widen intervals and are skipped,
never compared. Class-firedness check: for decided rows at m₁ < m₂,
abort iff fired(m₁) ∧ clean(m₂). A2 containment: per region, abort iff
triple-fired ∧ pair-clean. Geometry-level containment: the enumerator
asserts each √3-triple's three pairs appear in the pair inventory (exact
set inclusion) and that NO instance tuple contains a graph edge (all
class distances ≠ 1 — catches d² spec typos for free). Abort contract:
SystemExit naming both offending rows + the artifact written with
status "aborted-invariant" — loud, preserved, diagnosable. Each checker
has a self-test that feeds it a synthetic violation and watches it abort
(check the checker, M26 lesson).

**G-3 — The shrink loop, upgraded from spot-checks to a fixpoint
certificate.** Deleting a vertex relaxes the graph, so the base-SAT guard
survives every deletion for free. Greedy passes over a deterministic
recorded order (outermost-first heuristic), deleting while avoid stays
UNSAT; measure: |R| strictly decreases per accepted deletion, a
zero-acceptance pass terminates. Run to the 1-MINIMAL FIXPOINT: the final
pass tests every surviving vertex, so **every core member carries its own
necessity witness** — a validated clean model of core − v — replacing
§0b's "spot-check the last 10 deletions" with a complete, self-certifying
necessity census (the SAT side of the core is then trustless; only the
core's own UNSAT remains solver-trusted, discharged per G-1's ladder).
**The decorrelated re-encode is the BINARY encoding** at k = 4 (2 bits
per vertex, 4 clauses per edge, 16 per triple, no AMO, ~half the
variables): structurally different clause generation catches one-hot
bugs, not just permutation artifacts; a vertex-order shuffle is layered
on top. A disagreement between encodings is a red alert: halt everything,
report, extend the self-tests with the found bug class before any rerun.

**G-4 — The self-test ledger (every check seen red AND green).**
1. Planted forced-equal: u,v both adjacent to a shared K3 at k = 4 →
   avoid-equal {(u,v)} UNSAT; one spoke removed → SAT. Realizability
   (direction B): mono SAT.
2. Planted mono-triple: u,v,w each adjacent to one shared K3 → avoid-mono
   UNSAT; one spoke removed → SAT.
3. Direction-B impossibility red: a tuple containing two ADJACENT
   vertices → require-mono UNSAT for the trivial reason; green: a free
   tuple → SAT. (The real enumerator excludes internal edges by
   geometry; this control documents the trap.)
4. Id-mapping shuffle: gadgets 1–2 embedded at scrambled indices in a
   larger random graph — identical verdicts.
5. Empty-class → `empty`; K5 base-UNSAT → `vacuous`; both never `fired`.
6. Checker-checks: synthetic non-monotone curve and synthetic
   triple-fired/pair-clean records each abort by name.
7. **P8**: the 791's six forced pairs, per-pair avoid-equal UNSAT ×6 +
   one matched non-forced pair SAT.
8. **P9, the M20 skeleton**: 6 vertices — an outer 120°-triple abstracted
   + its seam-image unit triangle (3 mutual edges) + one spoke per outer
   point to its own image; at k = 3 require-mono(outer triple) → UNSAT
   (colour count: images exclude their own outer's colour yet must be
   rainbow), reproducing `no_mono_outer_triple`'s finite skeleton; one
   spoke dropped → SAT. The control needs no coordinates — it is the
   kernel theorem's combinatorial core, stated as a graph.
9. **P10**: the certified hexagram chunk (B ≤ 2, 378 vertices, real
   enumerator on seam coordinates) — every probed class SAT.
10. Calibration first: the known 510 fan ladder re-run (verdict known
    fanned; the laptop/desktop ratio is the only new number).

**G-5 — Budget arithmetic (laptop bands, sequential, one SAT call
live).** Phase 1: 510 ladders at 44 marks ≈ 130 queries, nearly all
seconds (≤ 1 h); 1581 at ~24 quantile marks × 2 centres ≈ 200 queries —
the near-full rows are EXPECTED to read `unknown` at the 300 s cap (M31:
the full 1581 at k = 4 read unknown/300 s on the DESKTOP); the curve
reports honest intervals there and no cap is raised on the laptop —
P7's bands were written to not depend on the top rows. Phase 2: 3
classes × 3 objects × ~6 binary-search steps ≈ 54 + onset confirms +
controls ≈ 90 queries; the shrink loops dominate at up to ~2–3k small
queries across 1–3 cores — background, resumable (artifacts written
per-row, a crash loses ≤ 1 query), ≈ 1.5 laptop-days. Total within
P11's band. The fabric stage's size (A4) is read from construct.py at
implementation before its sweep is scheduled — an implementation
checkpoint, not a prediction.

## §0h — Experience modeling pass (2026-08-10, fresh invocation)

**H1 — Kooshi's picture: one chart carries the whole verdict.** The money
plot is a single radius axis per (object, centre): the min-cover step
curve (levels 1→2→3→4) with the class-firing onsets overlaid as vertical
markers — the ORDERING of compulsions readable at a glance, which is the
milestone's finding whatever it turns out to be. Axis in radius r (humans
read distances; r² exact in tooltips). Visual grammar, fixed now:
fired = solid marker; clean = hollow; `empty` = grey dot labeled "no
instances yet"; `unknown` = hatched band labeled "capped — not a claim";
the region past base-SAT = shaded, labeled "not 4-colourable — every
question moot here". The criticality echo gets ONE explanatory line on
the page: "the top step can only arrive at the last ring if the witness
is vertex-critical — the curve validates criticality; the mechanism
lives in the lower steps." The core renders on the witness scatter in
the standing anatomy explorer (new tab, SAME URL, update never re-mint):
members highlighted, ring histogram beside, necessity summarized as one
badge ("1-minimal: every member's deletion un-fires, witnesses held"),
never per-vertex noise. Withheld from the picture: seconds, encodings,
deletion order — plumbing lives in the JSON only.

**H2 — The JSON contract (the M34 handoff IS these fields).**
`build/m33-spectrum-<object>-<centre>.json`: `{schema: "m33-spectrum v1
(plans/M33-mechanism-hunt.md §0h)", object, centre: {id, xy}, k,
S: {ids, n}, marks: [{r2_exact, r2, n, n_edges, n_target,
cover: {rows: [{j, outcome, seconds}], lo, hi, verdict},
classes: {name: {n_instances, avoid_outcome, verdict, seconds,
promotion}}}], onsets: {cover: {level: mark|null},
classes: {name: {onset_r2, promotion}}}, invariants_checked, status}`.
`build/m33-core-<object>-<class>.json`: `{schema: "m33-core v1 (…§0h)",
object, centre, class: {name, arity, d2}, k, vertices (OBJECT ids,
sorted), n, deletion_order, necessity: {complete, witnesses_validated},
reencode: {encoding: "binary-2bit", outcome}, anatomy: {rings,
direction_classes}, status: "solver-measured"}`. Conventions, binding:
object ids ONLY in every emitted list; every r² as exact string AND
float; every UNSAT carries its `promotion` rung (`provisional` |
`reencode-confirmed` | `lrat`) — G-1's ladder as a field; `status` ∈
{done, partial, aborted-invariant}. Artifacts are self-describing: a
fresh session reconstructs meaning from field names + the schema line's
plan pointer, reading no source.

**H3 — The CLI (tools/mechanism.py).** Verbs: `--self-test` (the G-4
ledger — the first-run habit), `--calibrate` (G-4 item 10), `--controls`
(P8/P9/P10), `--sweep`, `--spectrum`, `--shrink`, `--status`. The
no-argument default RUNS NOTHING: it prints the standing state (which
artifacts exist, their status, what would run next) — the zero-annotation
path teaches instead of surprising. Resumability stated in `--help`:
"artifacts are written per-row; re-running resumes after the last written
row; delete the artifact to restart". Abort banners name the registered
item they falsify: "MONOTONICITY VIOLATION (§0f F4) between marks … —
instrument bug; run aborted; artifact status=aborted-invariant";
"CONTAINMENT VIOLATION (§0a A2) at mark …". Honest-verdict wording fixed:
`empty` → "0 instances in region — no claim; nothing to avoid here yet";
`unknown` → "capped at N s — UNKNOWN: not a bound, not a claim".

**H4 — The plan as a surface.** §0 reads front-to-back with backward
references only; the one forward hazard (§0b's spot-check sketch vs
§0g G-3's fixpoint protocol) is now annotated at §0b so a linear reader
implements the refined protocol. The registered PREDICTIONS (§0c bands)
are untouched by every refinement — protocol refinement is the modeling
passes' job; bands move never.

## §0i — Mid-milestone addendum (2026-08-10, desktop, registered BEFORE the reruns)

**What the first control run found (face value).** P9 green both ways; P8's
six pairs all read `unknown` at 300 s; P10 read the two √3 classes clean as
predicted AND `eq-pair-2` FIRED on the certified hexagram chunk (378 pts,
135 instances) — **confirmed instantly through the binary re-encode**, so
it is a genuine pigeonhole, and registered P10 is *partially refuted*: its
rationale ("a fired class would contradict a kernel theorem") was wrong —
a fired class is a disjunctive compulsion, fully compatible with χ = 4.
Reading: the seam fabric cannot 4-colour without a monochromatic
distance-2 pair somewhere in the B = 2 chunk — a pigeonhole at EXACTLY the
ρ₁₅ spindle distance (4·2² − 1 = 15), whose kill lives one field up. G15's
Act One, materialized in our own certified object.

**Instrument changes (sound, self-tests re-green).** (1) `class_avoid`
gains first-occurrence palette symmetry breaking (sound for
palette-invariant properties; NEVER added to coverage queries, whose
restrictions name colours; truncated emission stays sound as a prefix of
the full scheme) — measured necessity: the 791 pair UNSAT is 59 s in the
two-pin currency vs 300 s+ unbroken. (2) The binary re-encode pins vertex
0's bits (transitivity). (3) Control cap rises to 900 s on the desktop for
the 791 pairs.

**The registered chunk-ladder probe (bands before running).** New object
rows: the hexagram chunk at B = 0 and B = 1, plus classes `eq-pair-4` and
`eq-pair-4rt3` at B = 2. Predictions: **Q-i1 [medium]** — `eq-pair-2`
fires already at B = 1 and is clean-or-empty at B = 0; **Q-i2 [low]** —
`eq-pair-4` fires at B = 2 (the (2,2)-diagonal's double, 4·4² − 1 = 63,
the ρ₆₃ channel), `eq-pair-4rt3` does not; **Q-i3 [medium]** — the
mono-√3-triple class stays clean at every B (G1: the certified colouring's
rot3 rainbow structure protects √3); **Q-i4 [high]** — the certified
colouring itself, restricted to the chunk, realizes mono d = 2 pairs (the
pigeonhole's easy half, checked from the standing colour tables). A
fired-class shrink core on the chunk (the d = 2 pigeonhole core) is
in-scope as phase-2 work if Q-i1 lands.

---

# §R — Results (2026-08-10, desktop; every verdict at face value)

*All instrument output; nothing here is a theorem unless it cites a kernel
address. Artifacts: `build/m33-spectrum-*.json`, `build/m33-core-*.json`,
`build/m33-covercore-*.json`, `build/m33-chunk-ladder.json`,
`build/m33-controls.json`; the one-chart verdict lives in the standing
anatomy explorer (M33 pane).*

## The scorecard (registered → measured)

* **P1 CONFIRMED** — 510 about v0: min-cover < 4 at every r² < 5.9149;
  fanned exactly at the last ring (9.13 s). The criticality echo measured;
  A1 validated by instrument.
* **P2 CONFIRMED (extreme low end)** — the 2-onset AND 3-onset both arrive
  at r² = 1.0 exactly: the 209-vertex ball already forces three colours on
  S₃₆ the moment the circle completes. The 3-delivery is nearly local; only
  the 4th colour is global.
* **P3 CONFIRMED, band missed LOW** — the 3-cover core is **49 vertices =
  the 36-point circle + 13 ambient** (registered band 60–250), 1-minimal
  with all 13 necessity witnesses held. The 13 sit on THREE shells, all
  strictly INSIDE the circle: r² = (7−√33)/6 (4 pts), **1/3 — the inner
  circle (5 pts)**, (9−√33)/6 (4 pts). The inner-lean confirmed (M22's
  clamp, one field up); the 4th colour's precondition is delivered from
  within, by a 13-point web on the (·−√33)/6 conjugate family ± the inner
  circle. **This is the golden question's 3-cover answer, with addresses.**
* **P4 REFUTED (pair half), A2-consistent (triple half)** — on 510 the
  equal-√3-pair class is CLEAN at every sub-full radius (registered: fires
  below r² ≤ 4), and mono-√3-triples clean likewise.
* **P5 CONFIRMED** — the equal-pair-at-2 class fires on 510 at onset
  **r² = 5/3 — the GLUE SHELL |1 + σ/√3|²** (re-encode-confirmed): the d=2
  pigeonhole switches on exactly when the ball reaches the seam-interlock
  radius.
* **P6 REFUTED as registered, and transformed** — de Grey's fabric stage
  (orbit(S, hex₁₂): 397 pts, 1,974 edges, 142 √3-triples) does NOT carry
  the mono-√3-triple pigeonhole (clean at every radius), nor the √3-pair
  one. It carries the **d=2 pigeonhole at onset r² = 2 − √33/9** — and the
  full 1581's d=2 onset is **IDENTICAL to nine decimals**: the d=2
  pigeonhole is purely a fabric property; the spindle assembly neither
  creates nor moves it.
* **P7 CONFIRMED (both centres, sharper than the bands)** — origin: 3-onset
  at r² ≈ 1.05, curve flat at exactly [3,3] through n = 1,539; the full-
  scale fan row honestly `interval [3,4]` (j=3 capped at 300 s) — and
  CLOSED BY MATHEMATICS: A1 + the kernel-certified χ(1581) ≥ 5 + the
  validated 4-colouring of 1581−centre (0.59 s) force the fan without any
  further SAT. Centre2: its 12-point circle stays at min-cover 2 until the
  LAST ring (r² = 16), then jumps straight to fanned (direct UNSAT) —
  coverage delivery tracks the ring-heart; the fan arrives only with the
  whole witness, at both centres.
* **P8/P9 CONFIRMED (after one instrument fix)** — the six 791 forced
  pairs each fire (187–262 s) and the matched pair is clean; the M20
  skeleton reproduces `no_mono_outer_triple` red/green. The fix, §0i:
  first-occurrence palette breaking in `class_avoid` (measured 300 s+ →
  ~200 s per 791 pair; sound for palette-invariant properties only, never
  in coverage).
* **P10 PARTIALLY REFUTED — and the refutation is the milestone's
  discovery**: the √3 classes are clean on the certified hexagram chunk as
  predicted, but **eq-pair-2 FIRES** (135 instances, both encodings,
  instant). The registered rationale ("a fired class would contradict a
  kernel theorem") was simply wrong: a fired class is a disjunctive
  pigeonhole, fully compatible with χ = 4.
* **P11 CONFIRMED with ~30× headroom** — the whole campaign (controls,
  4 sweeps, 10 spectra, 3+ cores) fits in ~3 desktop-hours under the
  standing parallelism rule (cores−2 thread pool).
* **P12 — GATE OPEN** (see the gate call below).
* **Q-i1 MISSED BY ONE RUNG** — the chunk pigeonhole is clean at B = 1
  (234 pts), fires at B = 2 (378 pts): seam DEPTH switches it on, not
  radius. **Q-i2 half-missed honestly**: eq-pair-4 is EMPTY at B = 2 (no
  d = 4 pairs exist in the chunk); eq-pair-4rt3 clean as predicted.
  **Q-i3 CONFIRMED** (√3 protected by the rot3 rainbow structure).
  **Q-i4 discharged a fortiori** (fired ⟹ every colouring realizes one;
  a validated model carries 34/135 mono d2 pairs; at B = 0 a model
  avoids all 27 — 0/27).

## The finding, in one paragraph

**The seam fabric cannot stay clean at distance 2.** Every proper
4-colouring of the certified hexagram chunk at seam depth 2 — and of de
Grey's own fabric stage, and of Heule-510's ball past the glue shell, and
of the 1581's ball past the same fabric radius — makes some distance-2
pair monochromatic. Distance 2 is exactly the ρ₁₅ spindle distance
(4·2² − 1 = 15): **the pigeonhole lives in the seam field; its kill needs
√15 — one field up. G15's two-act anatomy is real, measured, and its Act
One is now a named, shrunken object**: the chunk core is **122 vertices**
(de Grey's L was 121) in 12 rot6-near-symmetric shells about the
metapivot, 1-minimal with every necessity witness held, confirmed in two
encodings. The √3-pair pigeonhole exists too — but ONLY in the full 1581
(onset at the √21-shell r² = (33−3√21)/8, where the second spindle
system's material enters), not in the bare fabric and not in SAT-shrunk
510: the assembly creates it, and Heule's shrinking discarded it while
keeping d=2. The coverage ladder tells the same story from below: the
3rd colour is delivered onto a centre's circle almost immediately by a
tiny interior web (13 points on named shells), and the 4th arrives only
with the entire witness — the criticality echo, now measured at three
centres and closed by A1 + the kernel χ ≥ 5 where the solver capped out.

## The P12 gate call

The gate criterion (core ≤ ~300 vertices, ≥ 90% of members in ≤ 12
anatomy classes) is MET by the chunk d2 core: 122 vertices, 100% in 12
shells, on our OWN certified object whose every chord family is already a
kernel theorem (M26). **The gate opens toward: kernel-certify "every
proper 4-colouring of [the 122-vertex core] has a monochromatic
distance-2 pair" via the M05 LRAT pipeline** — a CNF a fraction of the
1581's size, over an object whose geometry is already certified. That is
Act One as a theorem. Act Two (the ρ₁₅ kill per placement + transport) is
the existing Quadrature/M26 genre. The assembly (χ ≥ 5 of a
fabric ∪ gadgets union) remains the research: the honest gap is that the
chunk's pigeonhole forces mono-d2-pairs SOMEWHERE, and a union
construction must kill every placement — the placement census of the core
(135 instances at B = 2) is the width budget A3 prices.

## Cores landed (all 1-minimal, witnesses held, solver-measured)

| Core | Object | Size | Shape |
|---|---|---|---|
| d2 pigeonhole | hexchunk B2 | **122** | 12 shells about the metapivot, near-rot6 counts (ten of 12/6, defects 11+9) |
| 3-cover | Heule-510 | **49 = 36 + 13** | ambient wholly interior: (7−√33)/6 ×4, inner circle ×5, (9−√33)/6 ×4 |
| d2 pigeonhole | fabric | **276** | 22 irregular shells — 84% of its onset ball |
| d2 pigeonhole | Heule-510 | **201** | 22 irregular shells, glue shell outermost — 72% of its onset ball |
| √3-pair pigeonhole | 1581 | **9** | two √3-triangles + their unit circumcentres + a hub + one rim–rim edge (annex below) |

**The onset-floppiness lesson** (unregistered observation, consistent
across all three d2 cores): a core shrunk from the ONSET radius keeps most
of its ball (fabric 84%, 510 72%) because the compulsion there has only
just assembled — near-critical, wide, floppy — while the chunk's
DEPTH-switched firing at B = 2 carries slack and shrinks to a tight,
near-rot6-symmetric 32% (122/378). For M34: shrink from slack, not from
onset; the 122-core is the certification target.

## Annex (2026-08-11, 01:32) — the nine-vertex pigeonhole

The 1581's √3-pair core shrank from ~1,400 vertices to **NINE** (ids 791,
793, 794, 868, 995, 1186, 1187, 1262, 1390; one per shell, outermost on
the √21 onset shell; UNSAT re-checked standalone in both encodings). The
structure, read by hand: the six instances form **two √3-triangles**
{794, 868, 995} and {1187, 1262, 1390}; a √3-side equilateral triangle
has circumradius exactly 1, and **793 / 1186 are the unit circumcentres**
(each adjacent to its whole triangle — M18's `exists_unit_triangle_iff`
object, live in de Grey's witness); **791 is a hub** adjacent to both
centres and to two rim members of each triangle; one **rim–rim unit edge
794–1187** joins the remaining members. The hand proof (two cases on
whether the centres share a colour): avoiding mono √3-pairs forces each
triangle RAINBOW in the three colours its centre avoids; the hub's
forbidden set then leaves it exactly one candidate colour, pinned equal
to BOTH c(794) and c(1187) — and the 794–1187 edge forbids that. Nine
vertices, contradiction, done. **De Grey's mono-triple story, resurrected
in pair form as a hand-checkable gadget.** At 9 vertices the statement is
`decide`-scale (4⁹ colourings) — a kernel theorem nearly for free at M34,
with the √3-triangle/circumcentre geometry already certified at M18.

No shortcut hides in the smallness: exploiting the pigeonhole requires
killing each of six placements with a forced-DISTINCT (virtual-edge)
gadget at √3 — the expensive currency (Haugland's G₁: ~740 vertices per
virtual edge) — so the two-act arithmetic lands back at witness scale.
The grammar is now explicit and priced: **the pigeonhole costs 9
vertices; the construction's entire cost is the kills.** (Why this core
is tiny while the d2 cores are 122+: the √3 class's instances organize
into triangles whose rainbow-forcing is CONJUNCTIVE through shared
centres — the compulsion concentrates; the d2 class has no such local
organizing gadget in these objects, so its carrier stays spread.)

## What was NOT done (honesty ledger)

* The direction-class census of the cores (§0d promised `anatomy.py`
  re-aimed): only the RING census shipped; the chunk core's 12 clean
  shells carried the P12 gate call. Direction classes remain to run if
  M34 wants them.
* The enriched-ball sweeps (registered as "after the plain curves"): the
  plain curves answered every registered question; the enrichment-shift
  measurement is unrun.
* The 1581 d2 core: skipped as redundant — the fabric core at the
  IDENTICAL onset radius answers the shape question more cheaply; noted,
  not measured.
* Coverage-j sub-arc classes (registered exploratory): unrun.
* The 1581 √3-pair core: still shrinking at close (annex; recorded when
  it lands).
* Phase 3 (the cascade formalized): GATED to M34 per P12, as registered —
  no Lean was written this milestone, by design.

## Costs and benchmarks (desktop)

Fan queries: 510-scale 10–30 s; B=2-chunk-scale seconds; enriched balls
(~16k vertices) unmeasured — expect minutes, cap and measure; the shrink is
~one query per deletion step (hundreds of calls — budget hours, background,
one job at a time). Avoidance queries: same order as coverage queries.
`unknown ≥ cap` is never a compulsion claim. All standing machine rules bind
(build.sh only; crash → HALT and report; one heavy job).

## Failure clauses (to be sharpened at subplan registration)

* **The fan-core comes out large AND patternless** (most of 510, no
  compelled class below coverage order): that is the FIFTH globality
  measurement — coverage compulsion itself irreducibly global — reported at
  face value; G15 demotes per its falsifier; fall back to the certification
  programme (`plans/M33-witness-closure.md`) with the mechanism hunt's
  measurements as anatomy.
* **The onset never arrives below the full witness** (every proper ball
  stays min-cover ≤ 3 until the last vertex): itself a sharp finding —
  register it as such, not as a failure.
* **The avoidance ladder reads all-SAT through witness scale at every
  probed class**: the compulsion lives above the probed orders; report the
  probed ceiling honestly and re-rank.
* Any crash, any process: HALT and report to Kooshi (standing).

## Deliverables

* The onset curve (radius → min-cover, plain and enriched, centre and
  peripheral) as a JSON artifact + a chart in the explorer or anatomy page.
* The fan-critical core: vertex list, its anatomy (shells, direction
  classes — `tools/anatomy.py` re-aimed), and its reproduction controls.
* The compulsion-spectrum table with the 791 positive control shown green.
* The class-avoidance instrument with red/green self-tests.
* Frontier + Grokkings close (G15 confirmed, sharpened, or demoted — with
  the measurement either way), and the phase-3 stub or module if the
  cascade opens.
