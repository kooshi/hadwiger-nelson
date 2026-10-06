# FS-131 wave 6 — `MapColouring`'s open leaf and its model: the implementation record (de Bruijn, the implementer)

*Job FS131-I6B, de Bruijn (Opus 5.5), launched 2026-10-06 on branch `fs131-w6m` (cut from `fs131-w6` at `3928644b`), in the worktree
`.claude/worktrees/fs131-w6m`. Brief `data/fs131/briefs/FS131-I6B-wave6.md` (on `main`), with `plans/STANDING-RULES.md`, `LEAN.md`,
`RUNNING.md` § Building and § Make the gate fail. Working files `data/fs131/i6b/`; tools `tools/fs131_i6b_*.py`. Nothing in this milestone is
blind (ruling 1).*

**What this job may change, and what it may not.**
- *May*: the proof of `sat_inP` (`Proofs/HadwigerNelson/Plane/Saturated/MapColouring.lean`) and its docstring's inhabitant note; new helper
  declarations under names no other module declares; new modules beside it (with their `Proofs.lean` and `ARCHITECTURE.md` lines);
  `scripts/Axioms.lean` (a block headed "FS131-I6B" above the `=== PURCHASED ===` banner); this record; `tools/fs131_i6b_*.py`;
  `data/fs131/i6b/`; `data/fs131/reports/FS131-I6B.md`.
- *May not*: any statement or definition (`sat_inP`'s hypotheses and conclusion, `SeparatesAt`, `InP`, `OnLevel`, `ArcMap`, …);
  `Plane/Saturated/Basic.lean`; `Plane/Saturated/Pinch.lean` (the other implementer's); the planners' record; any landed module beyond new
  declarations; `main`; no new `axiom`, no `native_decide`; no merge, no gate run.

## Theorems this phase proved

*(filled at each saved stage; built by the worktree's build, the axiom audit being the gate's — each line gives the declaration and the
axioms its `#print axioms` reads on this branch)*

- none yet (Stage 1 is the readback).

## Stage 1 — SAVED (FS131-I6B): the readback, the as-given build, the route

### 1.1 The brief's quotations against their sources (standing rule 3)

By script (`tools/fs131_i6b_quotes.py`: exact substring match of each `>`-block against the file its `— source:` line names; output
`data/fs131/i6b/logs/quotes.out`): **9 quotations, 9 exact, 0 mismatched**, exit 0. With one character of the first quotation altered
(`--plant`) it reports 1 mismatch and exits 1 (`quotes-plant.out`); with no quotation found it exits 2. No finding about the brief.

### 1.2 Read

The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building and § Make the gate fail; the planners' record
`plans/FS131-w6-kernel-plan.md` Stages 1–9 whole; `Plane/Saturated/Basic` and `Plane/Saturated/MapColouring` whole; inventory items 486, 495
(490's heading only: the bridge is not this file's); the row FS121-C1-SAT (`data/fs131/k6/backlog-rows-w6.md` l. 408–431) and its argument
(`plans/FS121-C1-proof.md` § 2.3, l. 191–214). From upstream, read as needed: `Plane/ArcMap` (the structure), `Plane/LocalMap` (regions),
`Plane/LocalStructure` (`GoodAt`, `GoodAt.exists_local_curve`, `curveAt`, the sector chart's declarations by signature), `Plane/Cover` and
`Plane/CoverExamples` (densities, `sq9`'s saturation, `isClosed_unitShadow`), `Plane/SVMap` l. 900–1040 (`sevenBrickMap`, the pattern for a
grid as an `ArcMap`). **Not read**: `Plane/Saturated/Pinch` beyond its declaration list (not this job's file); the FS-121 job records other
than § 2.3 of C1's.

### 1.3 The branch builds as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — all 1799 modules already up to date, nothing built,
2 modules with warnings**, every warning `declaration uses sorry` (8: `MapColouring` 1 at l. 194, `Pinch` 7), exit 0
(`build/gate/build/20261006T133946Z-283761.log`; driver log `data/fs131/i6b/logs/build-0-as-given.log`).

### 1.4 The route, and where it leaves the plan's

The plan's § 5 row for `sat_inP` has three parts: `bound_iff`; (S1) the unit shadow of a closed set is closed; (S3) a sector chart at `x`, two
cyclically adjacent sectors of colours `i` and `m`, and the density of `region i` at the points of their common branch.

- **(S1) is on the tree already**: `isClosed_unitShadow` (`Plane/CoverExamples`, wave 2). No child.
- **(S3) is replaced** by a route that reads no sector chart, only wave 3's good radius (`GoodAt`, `GoodAt.exists_local_curve`: inside a good
  ball about `x`, near a point `z ≠ x` every arc point lies on one full curve — a line or a circle through `x`):
  1. *the punctured good ball is connected* (the image of `(0, ρ) × ℝ` under polar coordinates);
  2. the two open sets "no other colour near" and "colour `i` not near" are disjoint in it (interior points are dense) and each is non-empty
     (`x` is in the closure of `region i` and of `region m`, `m ≠ i`), so some `z ≠ x` in the ball is in the closure of `region i` and of the
     other colours' interior points;
  3. *at such a `z`* all arcs near lie on one curve; **each side of a line or a circle in a small ball about a point of it is connected**
     (inside: convex; outside: every point is joined to the far half-disc by a segment along the outward normal), so each side is in one
     region; one side is `region i` and the other is not; each side holds the disc of radius `r/4` tangent at `z`, so `region i` has upper
     density at least `1/16` at `z` and is not of density `1` there: `z` is an essential boundary point of `region i`;
  4. essential boundaries, supports and density sets are those of `c.cls i` (a.e. equal); saturation puts `z` at distance `1` from
     `supp (c.cls i) = closure (region i)`; `z` is as near `x` as wished, and the shadow is closed.
  The plan's warning stands and is obeyed: step 2 is connectedness of an open set in the plane, not of the density topology.
- **Expected finding** (to be confirmed by the proof, then reported): steps 1–4 never read the second clause of `SeparatesAt` (the ball inside
  `closure (S i) ∪ closure (S m)`), nor `σ` beyond `i ≠ m` — for a saturated plane map, every point of `closure (region i) ∩ closure
  (region m)`, `i ≠ m`, is `i`-bound, a cusp of colour `i` at a vertex included (the edges bounding the cusp accumulate at the vertex). The
  plan's § 3.3 says the closure-level form "would make FS121-C1-SAT false at a vertex where colour `i` has a cusp".

### 1.5 The model against the leaf

`sq9` as an `ArcMap 9` (the half-integer grid as unit-half segments, `col = sq9Col`) needs: non-degeneracy, local finiteness, local constancy
of `sq9Col` off the grid, the grid null (so `sq9.cls j =ᵐ region j`), and `Saturated sq9.cls` (held: `sq9_tight_saturated`). By
`sevenBrickMap`'s size on the tree this is about 200 lines against about 400 for the leaf: **the model is not larger than the leaf**, and is
not split off. It goes in a module of its own, `Plane/Saturated/Sq9Map`, upstream of `MapColouring` (the fragment rows of this wave will want
`sq9Map` as an inhabitant without importing the map-colouring lane).

### 1.6 Registered before the first leaf

| # | expectation | probability / interval |
|---|---|---|
| Z1 | `sat_inP` closes with no statement change | 0.9 |
| Z2 | the proof does not read `SeparatesAt`'s ball clause | 0.85 |
| Z3 | lines of Lean for the leaf's helpers and proof | median 450, 80 % interval [300, 800] |
| Z4 | lines for the model | median 220, [120, 400] |
| Z5 | the price: the plan's "2 days" is high by more than a factor of three (this job closes leaf and model within its budget) | 0.75 |
