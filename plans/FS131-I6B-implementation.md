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

Every line below: built by `build-3-final.log`; `#print axioms` reads `[propext, Classical.choice, Quot.sound]`
(`data/fs131/i6b/logs/axioms-3.txt`, 46 records, all the standard three). Grade: [kernel] once the wave's gate passes; until then, built.

- **FS121-C1-SAT**, first clause — `sat_inP` (`Plane/Saturated/MapColouring`), statement as fixed at `3928644b`. Read against the row
  (`data/fs131/k6/backlog-rows-w6.md` l. 413–415): "a locally finite map colouring with k colours whose edges are finite chains of segments and
  circular arcs" is `F : ArcMap k` with `F.IsPlaneMap`; "whose classes form an honest saturated colouring" is `c : AeColouring k`,
  `c.cls j =ᵐ F.region j`, `Saturated c.cls`; "is a member of 𝒫_k under every total order of its colours" is `InP F.region σ` for every `σ`.
- **FS121-C1-SAT**, the "so" clause — `sat_noPar` (the planner's proof from `sat_inP`; now free of `sorry`).
- **FS121-C1-SAT at a wider class** — `ArcMap.bound_of_saturatedOn`: an arc map whose regions are a.e. a family `C` saturated on an open `U`;
  every point of `U` in the domain and in the closures of two different colours' regions is `i`-bound. No colouring, no null unit pairs, no
  plane map, no order, and no neighbourhood free of other colours (`SeparatesAt`'s second clause). `sat_bound_of_mem_closure`: the same on the
  plane for a colouring. Wider than the row and than `sat_inP`.
- **The local fact** ("each of density 1/2 … an essential boundary point", `plans/FS121-C1-proof.md` § 2.3) —
  `ArcMap.exists_mem_essBoundary_region`, `ArcMap.mem_essBoundary_region_of_curve` (`Plane/Saturated/MapEdge`), over
  `isPreconnected_curveSide_pos`, `convex_curveSide_neg`, `exists_segment_curveSide_pos`, `curveSide_neg_of_mem_ball`,
  `curveSide_pos_of_mem_ball`, `curveSide_rebase`, `MapEdge.isPreconnected_puncturedBall` and the density facts of namespace `MapEdge`.
  The row's "density 1/2" is proved as "upper density at least 1/16 on each side", which is what the essential boundary reads.
- **The model** — `sq9Map : ArcMap 9`, `sq9Map_isPlaneMap`, `sq9Map_region_ae`, `mem_sq9Grid_iff`, `volume_sq9Grid`
  (`Plane/Saturated/Sq9Map`); `sq9Map_separatesAt`, **`sq9Map_sat_model`** (`Plane/Saturated/MapColouring`): every hypothesis of `sat_inP` at
  once, at `k = 9`, with a separating point; four `example`s apply `sat_inP`, `ArcMap.bound_of_saturatedOn` (on a ball),
  `ArcMap.exists_mem_essBoundary_region` and `ArcMap.mem_essBoundary_region_of_curve` to it.

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

## Stage 2 — SAVED (FS131-I6B): the leaf and its model, built

### 2.1 What was built

| module | lines | content |
|---|---|---|
| `Plane/Saturated/MapEdge` (new) | 519 | the two sides of a line or a circle; the punctured disc; `ArcMap.exists_mem_essBoundary_region`; density facts under namespace `MapEdge` |
| `Plane/Saturated/Sq9Map` (new) | 268 | `sq9Map` and its facts at the edge point |
| `Plane/Saturated/MapColouring` | 208 → 302 | `ArcMap.bound_of_saturatedOn`, `sat_bound_of_mem_closure`, `sat_inP`'s proof (five lines), the model theorem and five `example`s |

`Proofs.lean` (two imports), `ARCHITECTURE.md` (two rows added, `MapColouring`'s rewritten; `tools/check_architecture.py` PASS,
`data/fs131/i6b/logs/check-architecture.log`), `scripts/Axioms.lean` (block "FS131-I6B", 46 lines, `sat_noPar` among them: it was unlisted
while it rested on the leaf).

### 2.2 The route as proved (against § 1.4)

As planned in § 1.4, with one step more general than planned:
1. `MapEdge.isPreconnected_puncturedBall` — the image of `(0, ρ) × ℝ` under wave 3's `polarPt`.
2. In a good ball about `x` (wave 3's `exists_goodAt`), the open sets `(closure (interiorPts ∖ region i))ᶜ` and `(closure (region i))ᶜ`
   are disjoint on the punctured ball (`dense_interiorPts`) and each meets it; so some `z ≠ x` in it is in both closures.
3. `z` is on an arc (else its own region is a neighbourhood); `GoodAt.exists_local_curve` puts every arc point near `z` on the full curve
   through `x`; `curveSide_rebase` re-bases that curve at `z` (data `b − κ (z − x)`, same size). `ArcMap.mem_essBoundary_region_of_curve`:
   the negative side of the curve in a ball of radius at most `‖b‖` is convex, the positive side preconnected (every point is pushed along
   `−b` into the far half-disc, three real inequalities in `MapEdge.push_real`), so each is in one region; a point of `region i` and a point
   of another region off the curve name the sides' colours; the tangent discs of radius `r/4` give `upperDensityAt_pos_of_balls` (wave 2) on
   each side, and `MapEdge.notMem_densitySet_of_disjoint` finishes.
4. `ArcMap.bound_of_saturatedOn`: a.e. equality carries `essBoundary` and `essSupport`; saturation on `U` at the essential boundary points
   within a ball inside `U`; `isClosed_unitShadow` (wave 2). `sat_inP` is then `bound_iff` and `i ≠ m` from `σ i < σ m`.

No companion skill was invoked: no obligation failed three times (the first elaboration of each of the three modules failed on at most six
lines, each repaired at once).

### 2.3 The finding: `sat_inP` never reads the second clause of `SeparatesAt`

`sat_inP`'s proof uses of `SeparatesAt F.region i m x` only `x ∈ closure (F.region i) ∩ closure (F.region m)` (`hsep.1`); the clause
`∃ r > 0, ball x r ⊆ closure (S i) ∪ closure (S m)` is not read, and `σ` only for `i ≠ m`. `ArcMap.bound_of_saturatedOn` is the statement
without them, kernel-checked. So for the class this module's rows are about — plane maps bounded by locally finitely many segments and
circular arcs, a.e. a saturated family — **the closure-level form of `𝒫_k` holds too**: every point of `closure (region i) ∩ closure
(region m)`, `i ≠ m`, is `i`-bound, a vertex where `region i` has a cusp included (the edges bounding the cusp are essential boundary of
`region i` and accumulate at the vertex).

This contradicts one sentence of the planners' record, `plans/FS131-w6-kernel-plan.md` § 3.3: "The closure-level alternative (`x ∈ closure (S
i) ∩ closure (S m)`, no ball) is strictly stronger and would make FS121-C1-SAT false at a vertex where colour `i` has a cusp." As a definition
of `InP` the closure-level form is still stronger (more points are asked about), so `NoPar` would be weaker under it and `gmap_i` would need
its points; nothing here proposes a change. What it does change: the "lemma owed" of § 3.3 (the equivalence of `InP` with the edge form, for
Jordan-arc maps) is not needed to apply FS121-C1-SAT at vertices, and FS116-O1-SATPIN's "saturated on a disc" has its bound lemma already
(`SaturatedOn F.region (ball p ρ)` is `ArcMap.bound_of_saturatedOn` with `C = F.region`, `U = ball p ρ`).

**Hypotheses read** (the brief's question): `hF` (only to put `x` in the domain), `hc` (essential boundary, support, and null unit pairs of
`region i` for `bound_iff`), `hsat`, `c`'s colouring structure only through `c.unitPairsNull i`. Not read: the ball clause; `σ` beyond `i ≠ m`.
Believed, not proved: without `hF` the statement stays true (two regions of positive measure in every ball about a point force an essential
boundary point there — the connectedness of the density topology, the route the plan forbade); the proof here needs `x ∈ F.dom`.

### 2.4 Checks, each with its control

| check | result | its control |
|---|---|---|
| build (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`) | **OK — 465 of 465 batches, 3 modules rebuilt, 1 module with warnings** (`Pinch`'s seven `sorry`, the other implementer's; none in this job's three modules), exit 0; `build/gate/build/20261006T142137Z-528180.log`, driver log `data/fs131/i6b/logs/build-3-final.log` (`build-1`, `build-2`: the two earlier builds, both OK) | three faults planted in scratch copies, elaborated alone: `curveSide` with the wrong sign (5 errors, first at `mem_curveAt_iff_curveSide`), `sq9Arcs` without the left edges (`mem_sq9Grid_iff` fails), `sq9Map` with one colour (6 errors, first at the region inclusions) — `control-PlantA/B/C.out` |
| axioms of the block (`tools/fs131_i6b_axioms.py`, iteration grade: the audit is the gate's) | 46 records, 46 the standard three, exit 0 (`axioms-3.out`, `axioms-3.txt`) | `--plant`: a theorem by `sorry` is named with `sorryAx`, exit 1 (`axioms-3-plant.out`) |
| statements against `3928644b` (`tools/fs131_i6b_statements.py`: every non-doc line of `Basic`, `Pinch`, `MapColouring` at the base, less `sorry`, stands in order) | 3 files kept, exit 0 (`statements-3.out`) | `--plant`: `InP`'s `<` changed to `≤` in memory fails on `MapColouring`, exit 1 (`statements-3-plant.out`). **The first plant passed**: it altered the same words in the module docstring, which the check rightly ignores — a control that could not fire; the plant now asserts it changed a line the check reads |
| no name declared twice (`./scripts/dupnames.sh`, run once after build 2; the last build added `example`s and doc comments only) | OK — no name is declared by two modules, exit 0 (`dupnames-1.log`) | the scan's own `--self-test` is the gate's, not run here. Two collisions were met by grep before any build and avoided: `isPreconnected_ball_diff_singleton` (`Plane/ValidMap/Limit`, the same statement) and `eventually_floor_eq` (`Plane/SVMap`) — neither module is upstream; this job's copies are `MapEdge.isPreconnected_puncturedBall` and a local `have` |
| `sorry` in this job's three modules | none (`rg`, exit 1) | — |

Not run, by the brief: the gate (`axioms.sh`, `vacuity.sh`, linters).

### 2.5 Re-pricing, and the expectations scored

The plan priced `sat_inP` at 2 days and wave 3's sector machinery as its cost. As-given build 13:39Z; final build done 14:31Z: **leaf and
model in under an hour**, because the route reads `GoodAt.exists_local_curve` and no sector chart. The plan's price was high by more than a
factor of ten here; the brief's "two to three" understated it. (One leaf, so no second leaf to re-price from.)

| # | registered | outcome |
|---|---|---|
| Z1 | no statement change, 0.9 | none |
| Z2 | the proof does not read the ball clause, 0.85 | it does not |
| Z3 | leaf: 450 lines, [300, 800] | about 560 (`MapEdge` 519 with its docstrings, about 45 in `MapColouring`) |
| Z4 | model: 220, [120, 400] | about 300 (`Sq9Map` 268, about 35 in `MapColouring`) |
| Z5 | price high by more than three, 0.75 | by more than ten |

### 2.6 Names of this module's own, for the join

Stated under names of their own because the natural name is held, or may be taken, by a module that is not upstream (`LEAN.md` § Searching —
Lean, last bullet): `MapEdge.isPreconnected_puncturedBall` (= `isPreconnected_ball_diff_singleton`, `Plane/ValidMap/Limit` l. 1215);
`MapEdge.densityRatio_congr_ae`, `MapEdge.essBoundary_congr_ae`, `MapEdge.essSupport_congr_ae`, `MapEdge.notMem_densitySet_of_disjoint`
(generic density facts the other implementer's leaves may also state); the local `hfl` in `sq9Col_locallyConstant` (= `eventually_floor_eq`,
`Plane/SVMap` l. 871).

## Drafts for the front page

*This job ran no gate (the brief: the wave's gate is the coordinator's), so no counts are drafted.*

- **`LEDGER.md`, the row FS121-C1-SAT was filed under at its derivation (FS-121's rows 142–144), regraded when the wave's gate passes** —
  draft: "FS121-C1-SAT [kernel]: `sat_inP`, `sat_noPar` (`Proofs/HadwigerNelson/Plane/Saturated/MapColouring`), on the standard three axioms;
  wider: `ArcMap.bound_of_saturatedOn` (a family saturated on an open set; no neighbourhood free of other colours). Assumptions by name:
  `sat_noPar` takes C121-NOPAR as the hypothesis `NoPar 𝒞` (a named open statement, proved nowhere); `sat_inP` none. Inhabitant:
  `sq9Map_sat_model`."
- **`plans/FS131-w6-kernel-plan.md` § 3.3** (the planners' record; not this job's to edit) — the sentence "would make FS121-C1-SAT false at a
  vertex where colour `i` has a cusp" is refuted for arc maps by `ArcMap.bound_of_saturatedOn` (§ 2.3).
- **Frontier, Proof Atlas**: no line of the Frontier moves; the Atlas's node for FS121-C1-SAT goes from [hand] to [kernel] at the gate.
