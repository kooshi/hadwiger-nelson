# M30 — The de Grey anatomy: the field jump's opening measurement

*Subplanned 2026-08-09 from the pre-subplan stub written at the field-jump decision
(Kooshi: "I'm losing interest in this field when the temptation to jump to de Grey's
is there… We can do anything"). The stub's mission context is preserved in § Context
below; §0 carries the registered predictions — the stub's E1–E4 were committed at
`fcbee06` BEFORE any instrument ran, and the refinements R1–R7 in this subplan are
likewise committed before any instrument runs. **This is an instruments milestone**:
no Lean obligations beyond the optional one-line lemma (item 6), and the standing
rule applies — nothing in `tools/` is trusted; every claim that matters later is
re-derived in Lean at M32.*

## Context (the field-wall thesis, from the stub)

The construction ladder (M24 pair → M25 four-ladder → M26 hexagram) proved three
infinite, genuinely-coupled unit-distance objects **exactly 4-chromatic**, on axioms
exactly `[propext, Classical.choice, Quot.sound]`. The colouring never shifted;
every rung's tables had slack. The reason, found at the jump decision:

> **The Moser spindle's twist rotation lies inside the seam group.** With
> σ = (√3 + i√33)/6 the seam, σ² = (−5 + i√11)/6, so the spindle rotation ρ
> (cos θ = 5/6, sin θ = √11/6) is **ρ = −σ̄² = ζ₆³ · σ⁻²**.

The classical 4-forcers are *native* to ⟨ζ₆, σ⟩ — and three milestones of exact
classification say 4 always suffices there. The only known 5-forcers (de Grey 1581;
Heule 553/510, all kernel-certified here) have coordinates in ℚ(√3, √5, √7, √11):
√5 and √7 are not in the seam field. **The 5-wall is a field wall.** The hunt moves
fields; the method (script-verified design → master-identity engine → kernel-checked
exactness) is the asset carried over.

One theorem transfers free and is cited, not re-proved: the two-circle theorem (M19)
and the one-pivot cap (M20) are stated for ALL circle points — uncountably — so any
field's densification of a one-pivot system inherits χ = 4 exactly. **There is no
one-pivot 5-forcer in any field.** The new ladder starts at pairs.

## Ground facts (deep-dive 2026-08-09, read-only — no instrument was run)

What the repository already holds, verified by reading code and data shapes:

* **The exact field is one module.** `tools/field.py`: ℚ(√3,√5,√7,√11) as
  16-integer vectors over basis {√∏S : S ⊆ {3,5,7,11}}, coordinates cleared by one
  common denominator; `is_unit` is an integer identity. Five generators already
  import it.
* **The 1581 is derived data with addresses.** `tools/construct.py` rebuilds de
  Grey's committed table point-for-point in the exact field (`regen-check`, M13):
  `G = spindle( delete₂( spindle( orbit(S, hex₁₂), (0,0), (2,0) ) ), (−2,0), (2,0) )`
  from the 39 seed points `degrey.S`. Sizes along the way: orbit(S, hex₁₂) = 397
  points, first spindle → 793, deletion → **791 (the forcer)**, second spindle →
  1581. The committed frame differs by one global rotation (cos 1/8, sin 3√7/8
  about (−2,0)), applied in `degrey_matches_committed`. So **every vertex carries a
  construction address** (copy tag × hex₁₂ element × seed index) for free, and
  collisions between addresses are the fusion record.
* **The spindle rotations are exact and named.** `spindle_rotation(r²)`:
  cos = (2r²−1)/(2r²), sin = √(4r²−1)/(2r²). r² = 4 → ρ₁₅ = (7+i√15)/8;
  r² = 16 → ρ₆₃ = (31+i√63)/32. `field.py`'s table records the four project roots
  as the spindle radicals of r² = 1, 3/2, 2, 3 (√3, √5, √7, √11).
* **The witnesses share one format.** `tools/degrey_cert.json` (1581 coords, denom
  768, 7877 edges), `tools/heule510.json` (510, denom 96, 2504 edges),
  `tools/heule553.json` (553, denom 288, 2722 edges) — names/denom/coords/edges/
  primes, all 16-vector exact. Heule's two have NO construction provenance (read
  from published coordinates) — for them only direction-inventory and
  group-membership run, which makes them **independent** cross-checks of E1.
* **The three-outcome SAT oracle exists.** `tools/forcer.py`: `forces(n,edges,p,q,k)`
  answers `forced`/`separated`/`unknown` — unknown never folded into separated;
  `backbone(n,edges,pivot,k)` maintains `confirmed ⊆ BB ⊆ confirmed ∪ candidates ∪
  unknown` (sample-then-confirm). `tools/coloring.py` holds the CNF encoding;
  cadical ships with the toolchain. **M13 measured the positive control**: the 791
  forcer (and the 793 pre-deletion set) forces {(−2,0),(2,0)} at k = 4; the full
  1581 refutes 4-colouring in ~27 s (desktop-era number, re-time before batching).
* **The exact motion group machinery exists.** `construct.py`'s `Motion` class:
  2×2 field-element matrices with a common denominator, reduced to lowest terms,
  hashable, with `motion_group` closing a generator list to a fixpoint under a cap.
  Rotations with surd cosines (σ, ρ₁₅, ρ₆₃) are representable directly.
* **The visualizer architecture exists.** `tools/hexagram-viz.html` (M26): canvas,
  pan/zoom, per-class chord toggles with live counts, colouring fill, tooltips,
  numeric completeness sweep. The anatomy visualizer reuses this architecture with
  a new data block.

## §0 — Registered predictions and controls (committed before any instrument runs)

The stub's E1–E4, restated verbatim in force, plus refinements R1–R7 that make them
falsifiable at a *pre-committed* granularity (the M22 lesson: a post-hoc reading of
a census is an anecdote; only a registered granularity can fail honestly).

* **E1 — the group.** The edge-difference units of the 1581 factor as words in
  **⟨ζ₆, σ, ρ₁₅, ρ₆₃⟩** (with lattice translations), with √5 entering only through
  √15 = √3·√5 and √7 only through √63 = 3√7.
  * **R1 (frame discipline).** Absolute edge directions are frame-dependent (the
    committed table is one global rotation off the construction frame), so E1 is
    tested on **ratios**: fix a reference edge direction u₀; the inventory is
    {u/u₀} and, for frame-free relative rotations, {u/v}. A global rotation g
    multiplies every direction by g and cancels in every ratio.
  * **R2 (the inventory is small).** The number of distinct edge directions of the
    1581 up to ratio-by-u₀ and sign is **≤ 200**. (From the construction: seed-edge
    directions × hex₁₂ × four copy words, heavily collided. Confidence medium; the
    count itself is a deliverable either way.)
  * **R3 (word length).** Every edge-direction ratio is reached by a word of length
    **≤ 6** over {ζ₁₂-frame elements, σ±, ρ₁₅±, ρ₆₃±} in the BFS closure. (The
    construction uses each spindle once, so long words would mean the anatomy sees
    structure the construction didn't put there — worth knowing either way.)
  * E1 is **confirmed** when every direction ratio of all three witnesses lands in
    the BFS closure at the achieved depth; **refuted** if any ratio provably needs
    a root outside ℚ(√3,√5,√7,√11) or stays unreached at depth ≥ R3+2 (reported as
    "unreached at depth d", never as absence).
* **E2 — the seam algebra one field up.** The analogues of π = (1+i√11)/2
  (π² = π − 3, norm 3): **(1+i√15)/2 with x² = x − 4 (norm 4 = 2²)** and
  **(1+i√63)/2 with x² = x − 16 (norm 16 = 2⁴)**. Prediction: the new webs clear
  **2-adically**, not 3-adically — the biggest research risk for M32.
  * **R4 (what M30 actually checks).** M30 characterizes, per generator, the
    minimal polynomial and norm of the associated half-integer algebraic integer,
    and — from the anatomy's concentrated families — WHICH primes' arithmetic the
    dominant webs will clear through. No Lean here; the characterization is the
    M32 handoff.
* **E3 — concentration.** ≥ 70% of the 1581's edges fall in ≤ 6 classes.
  * **R5 (the registered currency — fixed NOW, before measurement).** The coarse
    class of an edge is the pair **(copy-pair tag, radius family)**: copy tags are
    the four construction copies {base, ρ₁₅·, ρ₆₃·, ρ₆₃ρ₁₅·} (10 unordered
    copy-pairs incl. intra); the radius family is the unordered pair of exact
    squared distances from the endpoints to the construction centre (0,0). A vertex
    with several addresses (a fusion) contributes its lexicographically-least tag,
    so the histogram is well-defined. **E3 passes iff the top 6 coarse classes
    carry ≥ 70% of the 7877 edges.** The fine class (relative motion × seed-pair
    orbit) is also computed — it is the real anatomy — but E3's verdict is at the
    registered coarse level only.
* **E4 — rigidity.** The hexagram calibration chunk's proper-4-colouring space,
  quotiented by (rot6 × colour-palette S₄), is SMALL (order tens, not thousands),
  and every 4-colouring forces colour-equality on the fused triples.
  * **R6 (chunk selection, fixed procedure).** The calibration chunk is the
    hexagram at seam-height bound B for the smallest B ∈ {0, 1, 2} whose chunk is
    4-chromatic (SAT-checked first; expected B ∈ {0,1}). E4 attaches to that
    chunk. If the space exceeds the enumeration cap (10⁴ classes up to symmetry),
    E4 is **refuted at face value** and reported as "> cap", never trimmed.
* **R7 — the load-bearing classes (new, registered).** Removing all edges of a
  single top-6 coarse class from the 1581 makes it 4-colourable (SAT returns a
  colouring) for **at least one** such class — i.e. the 5-forcing has a
  load-bearing family, the analogue of M22's "outer-circle constraints necessary
  in every ambient kill". Refuted if the graph stays 5-chromatic under every
  single-class deletion (which would say the forcing is redundant across families
  — also worth knowing, and M31 targets change accordingly).

**Registered instrument controls** (each must be seen to fail before its instrument
is believed — the make-the-gate-fail rule):

| Control | Instrument | Must show |
|---|---|---|
| Rhombus, k = 3 | rigidity | forced-equal = exactly the far pair; colouring count **1** up to palette; no virtual edges |
| Rhombus minus one edge, k = 3 | rigidity | the forced pair **vanishes** (deleted edge loosens the space) |
| Moser spindle, k = 3 | rigidity | reported **UNSAT-chunk, loudly** — never "every pair forced" (vacuous forcing is a named failure mode, not a finding) |
| 791 forcer, k = 4 | rigidity | forced-equal contains {(−2,0),(2,0)} — M13's independently measured fact; a registered decoy pair reports `separated` |
| Planted unreachable rotation (a direction multiplied by √2-free junk, e.g. a rotation with cos 3/5) | group extraction | reported unreached/out-of-field **by name** |
| Shuffled-coordinate graph (1581 coords permuted against edges) | anatomy classifier | non-unit edges refused; the run aborts naming the first offender |
| Visualizer replica sweep | visualizer | 0 non-unit rendered chords; 0 unclassified edges; class counts equal the anatomy table's |

## §1 — The instruments (the work items, in build order)

### 1. `tools/rigidity.py` — the colour-space instrument (new equipment)

Generalizes `forcer.py`'s per-pivot backbone to the full pairwise structure.
Inputs: a graph JSON (the standard names/coords/edges shape or bare n/edges), k,
an optional symmetry group (vertex permutations, supplied by the caller), caps and
timeouts. Outputs, in one JSON:

* **χ-check**: SAT/UNSAT at k (and at k−1), so every downstream claim knows which
  regime it is in. An UNSAT chunk halts forced-pair analysis with a loud banner
  (vacuous forcing is not forcing).
* **Forced-equal pairs**: all {u,v} with c(u) = c(v) in every proper k-colouring.
  Sample-then-confirm (the M13 backbone invariant, generalized): maintain
  `confirmed ⊆ FE ⊆ confirmed ∪ candidates ∪ unknown`; models kill candidates in
  batches; survivors get the UNSAT confirmation (`proper ∧ c(u) ≠ c(v)`); three
  outcomes per pair, unknown never folded.
* **Forced-distinct pairs** (virtual edges): non-adjacent {u,v} with c(u) ≠ c(v)
  always — the gadget currency (a virtual edge is what a spindle wants). Same
  oracle with the mirrored query (`proper ∧ c(u) = c(v)` UNSAT).
* **The colour-space census**: enumeration by blocking clauses over
  symmetry-canonicalized solutions (canonical form: lexicographically-least under
  the supplied group × palette S_k), capped; reports exact count or "> cap".
* **A representative-colouring dump** per orbit, for the visualizer overlay.

Design notes pinned now: reuse `coloring.py`'s CNF and `forcer.py`'s `_solve`;
model diversity via cadical's random phases + per-candidate push queries; the
symmetry group is caller-supplied data (for the hexagram: rot6 as an address
permutation; for de Grey chunks: hex₁₂ on the orbit part), never derived inside
the instrument. Calibration per R6/E4, controls per the table above.

### 2. Group extraction — `tools/anatomy.py` (new, thin over existing machinery)

* **Addressing pass**: re-run `degrey_from_primitives()` with provenance: every
  point carries its (copy tag, hex₁₂ element, seed index) multiset through dedup.
  Assert the regen-check still matches the committed table (existing code).
* **Direction inventory**: the 7877 edge differences as exact field elements;
  ratio-normalize per R1; dedup; report the count (R2's verdict).
* **Word factorization**: BFS closure of ⟨ζ₆ (and the hex₁₂ frame), σ, ρ₁₅, ρ₆₃⟩
  as exact `Motion`s to depth 8 (R3 + 2), matched against the inventory. Report
  per-direction word length or "unreached at depth 8" (E1's verdict). Same
  membership run for 510/553 inventories (no addressing pass — no provenance).
* **Output**: the generator list with exact values, the word-length histogram, the
  per-witness membership table.

### 3. The anatomy — same tool, second mode

* **Classification**: every edge of the 1581 gets its fine class (relative motion
  as an exact `Motion`, seed-pair, up to the global hex₁₂ action and swap) and its
  registered coarse class (R5). Histograms both levels; E3's verdict at coarse.
* **The load-bearing probe (R7)**: for each top-6 coarse class, delete the class
  and SAT the remainder at k = 4 (~30 s each, any machine). Report which classes
  are load-bearing. Cross-check the reading against 510/553 by direction-class
  (their classes come from the membership run, not addresses).
* **The written reading**: which families carry the 5-forcing, cross-checked
  between witnesses — the M31 input.

### 4. The anatomy visualizer — `tools/degrey-viz.html` (deliverable)

The `hexagram-viz.html` architecture with the anatomy data block: the 1581 (and
510/553, switchable) rendered from float projections of the exact coordinates;
edges coloured by coarse class with per-class toggles and live counts; copy-tag
and radius-family filters; the forced-equality/virtual-edge overlay from
instrument 1 (on the 791 at k = 4, and on the 1581 at k = 5); address and
word-factorization tooltips; pan/zoom; the replica completeness sweep (last row of
the controls table). *The first picture of the 5-forcing organs anyone has seen.*

### 5. Closure candidates — the M31 handoff

From the anatomy: rank the smallest group-closed objects (fewest centres,
generators, radii) containing the load-bearing families; for each candidate, its
generator set, radius spectrum, estimated chunk growth rate, and which witness
edges it covers. Delivered as a table in the M31 stub (updating it is part of this
milestone's close — the stub rule).

### 6. Optional, small, certified

* The Lean lemma **ρ = ζ₆³·σ⁻²** (σ = `TwoCircle.seam`, ζ₆ from the ladder
  development; one `linear_combination` over ℂ after clearing) — makes the
  field-wall thesis kernel-checked. Landed only if it stays one afternoon.
* The concentric-k-circle probe (census + SAT, one evening) — parked unless the
  main line lands early; expectation (registered in the stub): concentricity does
  not force 5 at any k probed.

## §2 — What "landed" means (the gate for an instruments milestone)

* Every control in §0's table run and seen red/green on cue, recorded in the
  instrument output (the self-test pattern of `couple.py --self-test`).
* E1–E4 + R2/R3/R5/R7 verdicts reported **at face value** in the closing report
  and the Frontier — confirmations and refutations alike.
* The visualizer committed, replica-swept.
* The M31 stub updated with the candidate table (a close that does not update the
  affected stubs is not a close).
* Frontier updated; this plan updated with results; commit.
* Lean gate only if item 6's lemma lands (then: build.sh, axioms entry, the
  standard audit).

## §3 — Cost and machines

Everything here is laptop-scale except possibly the R7 probes (top-6 × ~30 s SAT
refutations — fine anywhere; re-time one refutation before batching, and name the
machine beside the number). No Lean builds beyond the optional lemma. One heavy
job at a time as always; no builds may run concurrently with SAT batches.

## Failure clauses (registered, carried from the stub)

* **E1 false** (units do not factor in ⟨ζ₆, σ, ρ₁₅, ρ₆₃⟩): the group is bigger
  than M13's reading implied — report the actual factorization; the milestone's
  value survives (the anatomy uses the true group).
* **E3 false** (forcing spread thinly): the minimal-closure strategy weakens;
  report at face value and re-rank — M31 then targets the smallest closure
  containing a whole witness (510 cheapest) rather than a family bundle.
* **E4 false** (colour space huge): report "> cap"; the rigidity instrument is
  still calibrated by the forced-pair controls, and forced-equality extraction
  (which never needs full enumeration) remains the deliverable.
* **R7 refuted** (no single class load-bearing): the 5-forcing is redundant
  across families — report it; M31's family-bundle candidate then needs ≥ 2
  families from the start, and the candidate ranking says which pairs.
