# FS131-MA1 — the example maps built, half A: `Paint`'s open leaves and the two models of the four local moves (de Bruijn, the implementer)

*Brief: `data/fs131/briefs/FS131-MA1-models-moves.md` (on `main`'s checkout). Branch `fs131-wm`, worktree `.claude/worktrees/fs131-wm`.
Started 2026-10-06 08:32 UTC. The plan this job builds is `plans/FS131-models-kernel-plan.md` (FS131-KM1), Stage 3.*

## Theorems this phase proved

Listed at the last saved stage, in § "Theorems this phase proved, final". Until that section exists, the stage sections below hold the
list as it grows.

## Stage 1 — SAVED (FS131-MA1): the readback

### 1.1 The brief's quotations (standing rule 3)

`tools/fs131_ma_quotes.py` reads each `> text` / `> — source: path` pair of the brief and counts the text in the file the source line
names; a relative path is looked up in the worktree and in `main`'s checkout, and the row says which copy held the text. Output
`data/fs131/ma/quotes.out`: **10 quotations, 10 found verbatim, none missing.** `--self-test` changes the last character of every
quotation and requires all 10 to be reported missing: `10 of 10 … OK`, exit 0 (the planted fault fires).

Two of the ten — inventory items 460 and 461 — are in `main`'s copy of `plans/FS131-close-inventory.md` only (filed after this branch
was cut; `worktree=0 main=1`). That is no mismatch: the brief lives on `main` and quotes `main`. I read both items whole there, with
items 462–463 beside them (a doubled theorem name can make an axioms print read clean over a `sorry` copy; so no helper of mine reuses
a name the library holds — § 1.4).

The four theorem heads are as quoted, each once, in `Proofs/HadwigerNelson/Plane/Models/Moves.lean`.

### 1.2 What was read, and how far

| file | read |
|---|---|
| the brief; `plans/STANDING-RULES.md`; `LEAN.md` | whole |
| `RUNNING.md` § Building, § Make the gate fail, and watch it fail | whole |
| `plans/FS131-models-kernel-plan.md` (the planner's record) | whole |
| `Plane/Models/Paint.lean`, `Plane/Models/Moves.lean` | whole, every docstring |
| `plans/FS131-close-inventory.md` (main's copy) | items 460–463 |
| `Plane/ArcMap.lean` | whole |
| `Plane/ValidMap/Basic.lean` | l. 1–300 (every definition a move's hypothesis names), l. 360–610 (the frame algebra) |
| `Plane/ValidMap/Contact.lean` | `exists_shave`, `exists_rayMerge`, `exists_merge` with their docstrings (l. 1490–1531) |
| `Plane/ValidMap/OpenMove.lean` | l. 1–125 (`HasHornCount`, `ne_hornSet_of_interior_coneAt`, the spec examples), `exists_open` with its docstring |
| `Plane/SVMap.lean` | l. 835–1320: `sevenBrickMap`, `not_mem_sevenBrickArcs`, `mem_sevenBrickArcs_of_bottom`/`_of_left`, the corner, `sevenBrick_color_eq`, `sevenBrick_corner_col` |
| `Plane/ValidMap/Surgery.lean` | `germArc`, `carrier_germArc`, `germArc_nondegenerate`; `isOpen_hornSet`, `isPreconnected_hornSet`, `eq_branchPt_of_tanHeight_eq_zero`, `encard_sectorsOf_of_partition`, `carrier_circ_full'` |
| `Plane/ValidMap/Sectors.lean` | l. 1–220: `connectedComponentIn_eq_of_iUnion`, `frame_polar`, `tanHeight_polar`, `sectorBetween_eq_hornSet`, `isSector_iff_of_partition`, `encard_sectors_of_partition` |
| `Plane/ValidMap/Cone.lean` | `tanHeight_anti`, `hornSet_mono`, `mem_coneAt_hornSet`, `hornSet_mono_radius`; the `dot` lemmas by their heads |
| `Plane/LocalMap.lean` | `coneAt`, `mem_closure_of_mem_coneAt`, `TileOf` and the `IsTile` lemmas by their heads |

### 1.3 The build as given

`/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` in the worktree,
2026-10-06 08:32 UTC: `All targets up-to-date (5754 jobs)`, `OK — all 1771 modules already up to date, nothing built, 4 module(s) with
warnings, 2s`, exit 0 (`data/fs131/ma/build-0.log`). **59 distinct `declaration uses 'sorry'` warnings, all in the four model files**
(`Stuck` 21, `Moves` 18, `Paint` 13, `Bends` 7); 0 other warnings. As the brief expects.

### 1.4 What I may and may not change

**Mine**: the proofs of the 31 `sorry` leaves of `Plane/Models/Paint.lean` (13) and `Plane/Models/Moves.lean` (18); new helper
declarations in those two files; a block headed "FS131-MA1" in `scripts/Axioms.lean`, above the `=== PURCHASED ===` banner; this record;
`tools/fs131_ma_*.py`; `data/fs131/ma/`; the report `data/fs131/reports/FS131-MA1.md`.

**Not mine**: any statement of the skeleton — hypothesis, conclusion, or a definition the statements use (`hornW`, `hornB`, `twoHornW`,
`twoHornB`, `hornModel`, `twoHornModel`, `holedTile`, `hornArcs`, `fanRest`, `tangentDisc`, `plantPt`, `plantDir`, `brickBase`, `relabel`,
`paint`); `Plane/Models/Stuck.lean` and `Bends.lean` (implementer B's); any landed module, its docstrings included; `main`; a new `axiom`;
`native_decide`; the gate; a merge of another branch. A leaf that is false as stated is a message to the coordinator, never an edit.

**A rule I add for myself, from inventory items 462–463**: every helper I declare is checked against the library by name before it is
written (`rg` over `Proofs/`), so that no name is declared twice.

### 1.5 The leaves read against the mathematics, before any proof

Each of the 31 statements was worked by hand before a line of Lean, the three the planner flagged first:

- **`hornArcs`' rim piece — the angles are right.** In polar form about `v` a point of the closure at distance `ρ` with `frameX > 0` is
  `v + ρ e(α + ψ)`, `|ψ| < π/2`, and `tanHeight κ = ρ (sin ψ − κρ/2)` (`tanHeight_polar`); the weak inequalities of the closure give
  `κ₁ρ/2 ≤ sin ψ ≤ κ₂ρ/2`, that is `ψ ∈ [arcsin(κ₁ρ/2), arcsin(κ₂ρ/2)]`. So `frontier_hornSet_subset` is true as stated.
- **`brickBase_col_zero` — true as stated.** `sevenBrick_corner_col`'s own proof closes the cell `(c, r) = (0, 0)` by
  `sevenBrick_color_eq` and `decide` at the value `0`; the brick `(0, 4/5) × (0, 3/5)` is that cell.
- `fanRest_ne_hornSet` carries no hypothesis on `κlo`, `κhi`, and needs none: the rest always holds the open half-disc behind the vertex.
- `hornModel_valid`, `twoHornModel_valid`: horn against disc is the one inequality with content. With `w = z − v = (x, y)`, `s = x² + y²`,
  a point of a horn between curvatures in `[−3/4, 3/4]` has `x > 0`, `s < 1/100`, `|y| ≤ 3s/8`, and then
  `‖z − c‖² − (19/20)² = s − (19/10)(3x/5 + 4y/5) ≤ 0`: the horn lies in the closed disc of radius `19/20` about the tangent disc's
  centre, so it is less than `1` from every point of the tangent disc. One real lemma serves all three horns of the two models.
- `hornModel_holedTile`: the brick `(2/5, 6/5) × (3/5, 6/5)` is cell `(c, r) = (0, 1)`; its top edge is the bottom edges of the cells
  `(−1, 2)` and `(0, 2)`, its right edge the left edge of `(1, 1)`. A rectangle off a closed disc is **not** a finite union of convex
  sets, so the planner's route ("four overlapping convex rectangles") cannot close the connectedness as written; mine is: the four
  rectangles off the disc's bounding square are convex and chained at the corners, and every other point is joined to them by the
  radial segment `[z, c + (3/2)(z − c)]`, which stays in the brick and off the disc. A route changed, no statement.

No statement was found false.

## Stage 2 — SAVED (FS131-MA1): `Paint` whole — its 13 leaves proved, no `sorry` left in the file

### 2.1 The leaves, in the planner's order

| leaf | route taken | lines, about (planner's price) |
|---|---|---|
| `brickBase_mem_interiorPts`, `brickBase_col_eq`, `brickBase_col_zero` | one child `brick_floor_eq` (the two floors of a point strictly inside a brick are `r` and `c`), then `not_mem_sevenBrickArcs` with `not_int_between`; `sevenBrick_color_eq`; the cell `(0, 0)` by `decide` on the table, stated first without the free `k` | 12 + 6 + 5 + 7 (M, S, S — "about 120") |
| `norm_plantDir`, `tangentDisc_subset_ball` | coordinates (`plantPt_re`, …, `tangentCentre_im`); the one tangent point from `(q − v)·u ≥ 1`, two `nlinarith` steps | 5 + 27 (S, M) |
| `hornArcs_nondegenerate` | as planned | 13 (S) |
| `frontier_hornSet_subset`, `hornArcs_carrier_subset` | the closure's weak inequalities by `closure_minimal` (`closure_hornSet_subset`), as the plan warned; the normal line gives `v`; a vanishing height gives the germ's arc (`mem_carrier_germArc_of_tanHeight_eq_zero`, over `eq_branchPt_of_tanHeight_eq_zero`); **the rim piece by `sectorBetween_eq_hornSet` at radius `2ρ`** — the point is in the wider horn, the library hands back its polar form, and `s = ρ` — in place of the planned `tanHeight_polar` computation | 45 + 16, helpers 50 (M, S) |
| `isOpen_fanRest`, `isPreconnected_fanRest` | as planned: three convex sets (`convex_frameX_neg`, and two discs by `tanBelow_iff_of_neg`, `tanAbove_iff_of_pos`), joined at `fromFrame v α (−t) (∓t)` | 10 + 40, helpers 30 (S, M) |
| `ball_diff_fan` | as planned, with `exists_sign_change` by `Fin.induction` (11 lines); a point of a germ's arc has `tanHeight κ' = ‖z − v‖²(κ − κ')/2` (`frame_of_mem_carrier_germArc`, over `tanHeight_branchPt`) | 50, helpers 30 (M–H) |
| `isSector_fan_iff`, `fanRest_ne_hornSet` | the partition as a named family `fanPiece : Option (Fin (m + 1)) → Set ℂ` with `fanPiece_data` (open, connected, disjoint, non-empty, the vertex in each closure) and `iUnion_fanPiece`; the rest's cone holds the open half-turn behind the vertex (`Ioo_subset_coneAt_fanRest`), which gives its non-emptiness, its closure clause and `fanRest_ne_hornSet` at once | 13 + 2, helpers 95 (M, S) |

**The re-pricing, from the first two leaves** (brief, Done means 2): the brick facts came to about 30 lines against "about 120", and
`tangentDisc_subset_ball` to 27 against "M (30–120)" — a quarter to a half of the plan's table. Re-priced on that: `Paint` 300–400 lines
(plan: 450–650), `Moves` 350–500 (plan: 500–700). **Measured at this stage, and my re-pricing was low**: `Paint` went from 330 to 825
lines (`git diff --stat`: 509 inserted, 14 deleted) — 495 net, **inside the plan's band and above mine**. The first two leaves were the
cheap ones; the fan cost what the plan said (its helpers alone are about 155 lines). The per-leaf counts in the table are read off the
file by eye, to within a few lines. `Moves` stays priced at the plan's 500–700.

### 2.2 What is new beside the leaves (helpers, all in `Paint`, all new names)

27 declarations: `brick_floor_eq`, `not_int_between`; `plantPt_re`, `plantPt_im`, `plantDir_re`, `plantDir_im`, `tangentCentre_re`,
`tangentCentre_im`, `dist_tangentCentre`; `closure_hornSet_subset`, `tanHeight_zero_left`, `half_le_one_sub`, `abs_frameY_le`,
`eq_of_frame_eq_zero`, `self_mem_carrier_germArc`, `mem_carrier_germArc_of_tanHeight_eq_zero`; `frameX_combo`, `convex_frameX_neg`,
`dist_fromFrame_lt`; `exists_sign_change`, `frame_of_mem_carrier_germArc`, `fan_tanHeight_of_mem_hornSet`; **`fanPiece`** (a definition:
the fan's pieces indexed by `Option (Fin (m + 1))`, so that `ArcMap.encard_sectorsOf_of_partition` counts a colour's sectors on it — the
shape `Moves`' sector leaves want), `iUnion_fanPiece` (its spec), `Ioo_subset_coneAt_fanRest`, `interior_coneAt_fanRest_nonempty`,
`fanPiece_data`.

### 2.3 Two observations about statements, neither a defect

- `frontier_hornSet_subset` carries `h12 : κ₁ < κ₂` and does not need it (for `κ₂ ≤ κ₁` the horn set is empty). The statement stands as
  written; the proof names the hypothesis (`have _ := h12`) so that no linter reports it. A generalization, for the inventory.
- `fanRest_ne_hornSet` carries no hypothesis on `κlo`, `κhi`, correctly: the rest holds the half-disc behind the vertex whatever they are.

### 2.4 The receipts

- **Build**: `data/fs131/ma/build-1.log` (2026-10-06 08:47 UTC, the tree as committed for `Proofs/`): `build: OK — 452 of 452 batches,
  5 module(s) rebuilt, 3 module(s) with warnings`, exit 0. `declaration uses 'sorry'`: `Moves` 18, `Stuck` 21, `Bends` 7 — **46, none
  in `Paint`**; 0 other warnings.
- **Axioms**: `tools/fs131_ma_axioms.py` over `data/fs131/ma/MAAxioms.lean` → `MAAxioms-1.out`: **58 of 58 theorems of `Paint` on the
  standard three** (every theorem of the file: the general layer, the 13 leaves, the helpers); the two controls — `stuckModel_hyps`,
  `awayModel_hyps`, implementer B's, open on this branch — are reported with `sorryAx`. `--self-test`: three planted faults (an open
  record listed as claimed; a clean record listed as a control; a misspelt name), each fails with its own message, exit 0.
- **The statement check**: `tools/fs131_ma_statements.py --names --no-sorry …/Paint.lean` → `statements-1.out`: 132 skeleton
  declarations of the four model files compared against `fe9d6d32` — every theorem's statement (the text up to the `:=` that ends
  it), every definition's whole text, the context lines — **0 problems; 27 added; 0 `sorry` in `Paint`; no added name declared
  elsewhere under `Proofs/`.** `--self-test`: five planted faults fire (a hypothesis's bound, a definition's body, an `open` line, a
  helper named after an identifier of a statement, the library's known doubled name `conj_e` treated as added), and the unplanted
  text passes.
- `scripts/Axioms.lean`: a block "FS131-MA1" above the `=== PURCHASED ===` banner, listing the `Paint` records KM1's block does not.

### Theorems this phase proved, so far (all **[kernel]**, `Plane/Models/Paint`, each on the standard three by `MAAxioms-1.out`)

`brickBase_mem_interiorPts`, `brickBase_col_eq`, `brickBase_col_zero`, `norm_plantDir`, `tangentDisc_subset_ball`,
`hornArcs_nondegenerate`, `frontier_hornSet_subset`, `hornArcs_carrier_subset`, `isOpen_fanRest`, `isPreconnected_fanRest`,
`ball_diff_fan`, `isSector_fan_iff`, `fanRest_ne_hornSet` — the 13 leaves — and the 26 helper theorems of § 2.2.

## Stage 3 — SAVED (FS131-MA1): `Moves` whole — its 18 leaves proved; the four model theorems on the standard three

### 3.1 What stands

**Both models are whole.** `Plane/Models/Moves.lean` holds no `sorry`; the four model theorems — each the landed move applied to the
model, every hypothesis a named fact about the one object — rest on exactly `[propext, Classical.choice, Quot.sound]`:

| model theorem | the landed theorem it applies | the facts it is given |
|---|---|---|
| `hornModel_shave` | `ArcMap.exists_shave`, `n = 0`, `σ = 0` | `hornModel_valid`, `hornModel_covers`, `hornModel_hasSectors`, `hornModel_isHorn`, `−1 ≤ −1/2`, `1/2 ≤ 1`, `hornModel_flanks` (both), `−1/2 ≤ 0 ≤ 1/2`, `hornModel_clear` |
| `hornModel_open` | `ArcMap.exists_open`, `δ = 1` | `hornModel_valid`, `hornModel_covers`, `hornModel_isHorn`, `hornModel_hasSectors`, `hornModel_cone`, `hornModel_hasDegree`, `hornModel_hasHornCount` |
| `twoHornModel_rayMerge` | `ArcMap.exists_rayMerge`, `n = 1` | `twoHornModel_valid`, `twoHornModel_covers`, `twoHornModel_hasSectors.1`, `−1/2 < 1/2`, `twoHornModel_isHorn` (both), `−1 ≤ −3/4`, `3/4 ≤ 1` |
| `twoHornModel_merge` | `ArcMap.exists_merge`, `n = 1` | `twoHornModel_valid`, `twoHornModel_covers`, `1 ≤ 1`, `twoHornModel_hasSectors.1`, `twoHornModel_cone.1` |

The four heads were not touched: their text is the skeleton's, byte for byte (the statement check, § 3.4). So the open gate item on the
four moves (`LEAN.md` § The gate, the inhabitant bullet; inventory rulings 419 (d), 427 (d)) has its Lean objects: a valid map of the
plane in eight colours on which the hypotheses of SHAVE and OPEN hold at once, and one on which those of MERGE-RAY and MERGE do.

### 3.2 The leaves, and the routes taken

Three shared obligations closed most of them, as the plan's § 3.7 predicted; each is a named lemma now.

1. **The painted class is the painted set**: `ArcMap.region_paint_of_region_eq_empty` (a colour the base does not use has the class
   `(F.interiorPts ∩ W ∩ g⁻¹{j}) ∖ ⋃ B`) gives `hornModel_region_seven : hornModel.region 7 = hornW` and `twoHornModel_region_seven`;
   `ArcMap.region_paint_subset` (a colour not painted only shrinks) gives clearness (`ArcMap.isClear_paint_of_mem_region`).
2. **Near the vertex the map is a fan**: `ArcMap.interiorPts_paint_inter_ball` with `hornB_inter_ball` / `twoHornB_inter_ball` (inside
   the open ball the new arcs are the fan's tangent arcs: the rim pieces are on the sphere, the tangent circle is `9/10` away) feeds
   `isSector_fan_iff`, read as `hornModel_isSector_iff` (the rest, the horn) and `twoHornModel_isSector_iff` (the rest, the lower horn,
   the gap, the upper horn) for every radius up to `1/10`. The counts are then explicit finite sets (`encard_singleton`, `encard_pair`).
3. **The contact reads the class only**: `ArcMap.tangent_contact_cone` — for any map and colour whose class lies in `B(plantPt, 1)`,
   holds the tangent disc and reaches `ω(plantPt)`, in its closure, at the tangent point only: the tangent point is an in-type contact
   and no out-type one (the tangent disc's own tile is the witness), the allowed cone is the closed half-plane `d · plantDir ≥ 0`. One
   lemma, applied to both models.

| leaf | route | where it differs from the plan |
|---|---|---|
| `hornB_nondegenerate`, `frontier_hornW_subset`, `twoHornB_nondegenerate`, `frontier_twoHornW_subset` | `hornArcs_nondegenerate`; `frontier_union_subset`, `frontier_hornSet_subset`, `frontier_ball` | the general-radius circle lemma exists (`carrier_circ_full'`, `Surgery`): no child was needed |
| `hornModel_valid`, `twoHornModel_valid` | `paint_valid`; horn against disc by `horn_ineq` (a real-variable lemma with its own context, as `LEAN.md` asks) → `dist_tangentCentre_le_of_mem_hornSet` → `dist_lt_one_of_hornZone` | the inequality is mine (§ 1.5): the horn lies in the closed disc of radius `19/20` about the tangent disc's centre, for any curvatures in `[−3/4, 3/4]`, so one lemma serves all three horns; the plan's `(z − v)·(q − v) ≥ 0.495 |z − v|` was not used |
| `hornModel_isHorn`, `_hasSectors`, `_hasDegree`, `_hasHornCount`; `twoHornModel_isHorn`, `_hasSectors` | obligation 2; a sector of one colour holds no point of another (`ArcMap.IsSector.false_of_col`) | counts by explicit sets, not by `encard_sectorsOf_of_partition`: with two and four pieces the sets are shorter than the colour function |
| `hornModel_flanks`, `hornModel_clear` | the flank horns lie in the fan's rest, which is of colour `0` (`hornModel_fanRest_subset_region`); obligation 1 | — |
| `hornModel_contact`, `hornModel_cone`, `twoHornModel_cone` | obligation 3, with `closure_inter_sphere_subset` | one general lemma in place of three proofs |
| `hornModel_holedTile` | open, in the interior points, connected (`isPreconnected_holedTile`), and closed in them (`mem_holedTile_of_mem_closure`: the brick's four walls are cell edges, `mem_tangentBrick_of_mem_interiorPts`); the last clause by `frontier_closedBall` and `IsOpen.inter_closure` | **the connectedness**: not four convex rectangles (a rectangle off a closed disc is no finite union of convex sets) but the four rectangles off the disc's bounding square, chained at three corners, and the radial segment `[y, c + (3/2)(y − c)]` from any other point (§ 1.5) |

### 3.3 What is new beside the leaves

78 declarations since stage 2: **41 in `Paint`** (general — the planted disc and the tangent disc's brick, horns against arcs and against
each other, the fan's pieces in the radius, the contact lemma; implementer B's models read the same base and may use them) and **37 in
`Moves`** (the two models' local pictures). Two definitions among them besides `fanPiece`: `tangentBrick` (the open cell
`(2/5, 6/5) × (3/5, 6/5)`; `holedTile = tangentBrick ∖ B̄(c, 1/20)` is `holedTile_eq`), and the fans `hornFan = ![−1/2, 1/2]`,
`twoHornFan = ![−3/4, −1/2, 1/2, 3/4]`. No name is declared elsewhere under `Proofs/` (`statements-2.out`).

**Measured**: `Moves` 196 → 817 lines (661 inserted); `Paint` 825 → 1,219 (394 inserted, shared helpers the plan priced under `Moves`).
Against the plan's `Moves` 500–700: the leaves and their own helpers are inside it; with the shared layer in `Paint` the two files
together added 1,544 lines against the plan's 950–1,350 for both — **above the band by about 200 lines**, the holed tile's connectedness
(105 lines) and the general helpers' docstrings being the difference.

### 3.4 The receipts

- **Build**: `data/fs131/ma/build-2.log` (2026-10-06 09:10 UTC, the tree as committed for `Proofs/`): `build: OK — 452 of 452 batches,
  5 module(s) rebuilt, 2 module(s) with warnings, 8m28s`, exit 0. `declaration uses 'sorry'`: `Stuck` 21, `Bends` 7 — **28, none in
  `Paint` or `Moves`**; 0 other warnings.
- **Axioms**: `tools/fs131_ma_axioms.py` over `data/fs131/ma/MAAxioms.lean` → `MAAxioms-2.out`: **163 of 163 theorems of `Paint` (98)
  and `Moves` (65) on the standard three**, the four model theorems on exactly the three. **4 of 4 controls fire**: implementer B's
  `stuckModel_hyps` and `awayModel_hyps` (open on this branch), and two planted ones that stay valid after the lane lands —
  `MAControl.planted_shave` (`hornModel_shave` re-proved over a `sorry` copy of the validity leaf) and `MAControl.planted_merge`
  (`twoHornModel_merge` over a `sorry` copy of the cone leaf): a model theorem's print goes red when one leaf beneath it is reopened.
  `--self-test`: three planted faults, each fails with its own message. **A defect of the instrument, found by its own failure and
  repaired**: the list's header sentence mentioned the marker `-- CONTROL`, the tool split at the mention, and the run read "0 of 0
  claimed, 4 of 167 controls fire, FAIL" — loud, not silent; the marker is now the one line that *begins* with it, and the tool
  refuses a list with none or two.
- **The statement check**: `tools/fs131_ma_statements.py --names --no-sorry Paint.lean Moves.lean` → `statements-2.out`: 132 skeleton
  declarations compared against `fe9d6d32`, **0 problems**; 105 added (68 in `Paint`, 37 in `Moves`); 0 `sorry` in either file; no
  added name declared elsewhere under `Proofs/`.
- `tools/check_architecture.py`: exit 0, `RESULT: PASS` (`data/fs131/ma/arch.out`).
- `scripts/Axioms.lean`: the "FS131-MA1" block now lists the `Moves` records KM1's block does not, and three of `Paint`'s.
- **Not run**: the gate (`axioms.sh`, `vacuity.sh`, the linters) — the brief keeps it for the landing.

### Theorems this phase proved, so far (all **[kernel]**, each on the standard three by `MAAxioms-2.out`)

In `Plane/Models/Moves`: **`hornModel_shave`, `hornModel_open`, `twoHornModel_rayMerge`, `twoHornModel_merge`** (the four moves
applied), `hornModel_shaveAvailable`, `twoHornModel_available`; the 18 leaves — `hornB_nondegenerate`, `frontier_hornW_subset`,
`hornModel_valid`, `hornModel_isHorn`, `hornModel_hasSectors`, `hornModel_hasDegree`, `hornModel_hasHornCount`, `hornModel_flanks`,
`hornModel_clear`, `hornModel_contact`, `hornModel_cone`, `hornModel_holedTile`, `twoHornB_nondegenerate`, `frontier_twoHornW_subset`,
`twoHornModel_valid`, `twoHornModel_isHorn`, `twoHornModel_hasSectors`, `twoHornModel_cone` — and their helpers. In `Plane/Models/Paint`:
stage 2's, and the 41 shared helpers of § 3.3.

## Stage 4 — SAVED (FS131-MA1): the tidy — the cone as a half-plane, the fan's counts, deterministic proofs, the notes; the final receipts

### 4.1 What changed after stage 3 (no skeleton statement touched; the statement check again 0 problems)

- **The allowed cone is stated, not only used**: `ArcMap.allowedCone_tangent` (in `Paint`: at the tangent disc's contact the tangent
  point is in-type and not out-type and `allowedCone plantPt c = {d | 0 ≤ dot d plantDir}`), with `hornModel_allowedCone`,
  `twoHornModel_allowedCone` and the hypotheses as one named fact per model (`hornModel_tangent`, `twoHornModel_tangent`).
  `ArcMap.tangent_contact_cone` is now its corollary through `halfPlane_plantDir`. The plan's docstring line for `exists_open`
  ("`D₇` the closed half-plane of its one in-type contact") is thereby a theorem.
- **The fan's degree and horn count, in general**: `encard_sectors_fan` (`m + 2` sectors) and `encard_horns_fan` (`m + 1` horns: the
  rest is no horn set), in `Paint`; **`twoHornModel_hasDegree : HasDegree plantPt 4` and `twoHornModel_hasHornCount : HasHornCount
  plantPt 3`** (the gap between the two painted horns is a horn set of the brick's colour). The plan's § 3.8 asks for these two for
  wave 5's `exists_vertexStep` on `twoHornModel`; they are statable on `main`, so they are here.
- **No bare `simp` before another tactic is left** in what this job added: the fans' monotonicity and bounds are `show` and
  `norm_num` per index; the tangent centre's coordinates are rewrites; the holed tile's corner points are `x + y i` with real `x, y`
  (`re_add_mul_I`, `im_add_mul_I`, `mk_mem_tangentBrick`, `holedTile_base_mem`). The `simp` calls that remain close their goals.
- **Spec examples** for the definitions added: `tangentBrick` (it holds the tangent disc's centre and not the planted vertex),
  `hornFan`, `twoHornFan` (their values); `fanPiece` has `iUnion_fanPiece`.
- **Notes naming the inhabitant** on every helper whose hypothesis is a map (`LEAN.md` § The gate): each names the model theorem that
  applies it; the two module headers say what MA1 added.
- **The axioms list checks itself against the files**: `tools/fs131_ma_axioms.py` now fails when the claimed list is not exactly the
  theorems of `Paint` and `Moves` (`LIST STALE`), and `--write-list` rewrites it from the files. Watched to fire unplanted: after
  this stage's first edits the old list read "10 theorem(s) of the files not listed", exit 1.

### 4.2 The final receipts (the tree as committed)

- **Build**: `data/fs131/ma/build-4.log` (2026-10-06 09:36 UTC): `build: OK — 452 of 452 batches, 5 module(s) rebuilt, 2 module(s) with
  warnings, 8m44s`, exit 0. `declaration uses 'sorry'`: `Stuck` 21, `Bends` 7 — **28, all implementer B's; none in `Paint` or
  `Moves`**; 0 other warnings, 0 errors. (An intermediate build of this stage, before the fan's counts were added, was also green; its
  log described a tree never committed and is not kept.)
- **Axioms**: `MAAxioms-4.out`: **177 of 177 theorems of `Paint` (115) and `Moves` (62) on the standard three**; `hornModel_shave`,
  `hornModel_open`, `twoHornModel_rayMerge`, `twoHornModel_merge` each on exactly `[propext, Classical.choice, Quot.sound]`; **4 of 4
  controls fire**; `--self-test` OK.
- **The statement check**: `statements-4.out`: 132 skeleton declarations against `fe9d6d32`, **0 problems**; 119 added (75 in `Paint`,
  44 in `Moves`); 0 `sorry` in either file; no added name declared elsewhere under `Proofs/`; `--self-test` OK (five plants fire).
- `tools/check_architecture.py`: exit 0, `RESULT: PASS` (`arch.out`).
- `scripts/Axioms.lean`: the "FS131-MA1" block holds 30 records, none repeated from KM1's 36; the two blocks printed together by
  `lake env lean`: **57 of 66 clean, 9 on `sorryAx`** — implementer B's (`stuckModel_hyps`, `stuckModel_contacts`,
  `stuckModel_flanks`, `stuckModel_terminal`, `shadowModel_flank_ne`, `cuspFrag_bend_away`, `cuspFrag_bend_toward`, `awayModel_hyps`,
  `awayModel_r2Contacts`). So `scripts/axioms.sh` fails on this branch by design until `Stuck` and `Bends` are whole.
- **Not run** (the brief keeps them for the landing): `scripts/axioms.sh`, `scripts/vacuity.sh`, the environment linters,
  `lean4checker`. What I did in their place, by reading: every definition added has a docstring; no hypothesis of an added theorem is
  unused (`frontier_hornSet_subset`'s `h12` is the skeleton's, named in its proof); every added theorem taking a map carries a note.
  **A lint or vacuity finding on these two files at the landing is this job's to answer.**
- **Measured**: `Paint` 330 → 1,317 lines, `Moves` 196 → 890; against the skeleton 1,718 lines inserted, 37 deleted. The plan priced
  the two files at 950–1,350 added lines; the excess is the shared layer's docstrings and notes, the holed tile's connectedness, and
  stage 4's additions (about 170 lines).

### 4.3 After wave 5 lands — the tidy the brief asks to be noted, by name

Read on `origin/fs131-w5` (`Plane/ValidMap/BrickMap`, heads only): `brickCell`, `mem_brickCell` (an `Iff.rfl`),
`sevenBrick_mem_interiorPts : z ∈ sevenBrickMap.interiorPts ↔ ∃ c r, z ∈ brickCell c r`, `sevenBrick_col_val : z ∈ brickCell c r →
(sevenBrickMap.col z : ℕ) = ((c % 7).toNat + 3 * (r % 7).toNat) % 7`, `isOpen_brickCell`, `convex_brickCell`, `closure_brickCell`.

| here | becomes |
|---|---|
| `brickBase_mem_interiorPts` | `sevenBrick_mem_interiorPts.mpr ⟨c, r, mem_brickCell.mpr …⟩` (the hypotheses differ from `mem_brickCell` only in `4/5 * (c + 1)` against `4/5 * c + 4/5`, a `linarith`) |
| `brickBase_col_eq`, `brickBase_col_zero` | `sevenBrick_col_val` at both points; at `(0, 0)` its right side is `0` by `rfl` |
| `brick_floor_eq`, `not_int_between` | no longer used by anything; delete, or keep `brick_floor_eq` as `sevenBrick_floor_bounds`' corollary |
| `tangentBrick`, `isOpen_tangentBrick`, `convex_tangentBrick`, `closure_tangentBrick_subset` | `tangentBrick = brickCell 0 1` (state it, then the three lemmas are `isOpen_brickCell`, `convex_brickCell`, `closure_brickCell`) |
| `mem_tangentBrick_of_mem_interiorPts` | from `sevenBrick_mem_interiorPts` and `brickCell_eq_of_mem_closure` |

No name of mine is one of `BrickMap`'s (checked against its heads). After the merge, run `tools/fs131_ma_statements.py --names` on the
merged tree: it lists any added name that the merge has made a doubled one.

## Drafts for the front page

*Each names its slot. I ran no gate, so no gate count is drafted as a number I read; the deltas below are what the lane adds, to be
read off the gate's own output at the landing.*

1. **`CLAUDE.md` § Trust ledger** (the sentence "the current audit reads … clean and … declared purchases, and … imported"): at the
   landing of this lane the clean count rises by the records of the two blocks in `scripts/Axioms.lean` — 36 (FS131-KM1) + 30
   (FS131-MA1) = 66, of which 57 are clean on this branch today and 9 wait for implementer B. No purchase, no import.
2. **`CLAUDE.md` § The gate** (the vacuity counts): unread; the lane adds 119 declarations in `Paint` and `Moves` (77 theorems beyond the
   skeleton's, 4 definitions), none concluding `False`, none with a colouring binder.
3. **`ARCHITECTURE.md`**, the rows `Plane/Models/Paint` and `Plane/Models/Moves` (not mine to edit under this brief):
   - `Paint`: for "**FS-131, the example maps, skeleton** (job FS131-KM1; record `plans/FS131-models-kernel-plan.md`)" read "**FS-131,
     the example maps** (FS131-KM1 the construction; FS131-MA1 its leaves and what the models share; records
     `plans/FS131-models-kernel-plan.md`, `plans/FS131-MA1-implementation.md`)"; for "`sorry` at 15 leaves until the lane's implementer
     lands it" read "no `sorry` (FS131-MA1); also the classes of a painting (`region_paint_of_region_eq_empty`, `region_paint_subset`),
     the fan's partition and counts (`fanPiece`, `fanPiece_data`, `encard_sectors_fan`, `encard_horns_fan`), the tangent disc's cell
     (`tangentBrick`) and its contact (`ArcMap.allowedCone_tangent`)". (The row's "15 leaves" was 13 at the skeleton's commit.)
   - `Moves`: for "**FS-131, the example maps, skeleton** (FS131-KM1)" read "**FS-131, the example maps** (FS131-KM1; proved by
     FS131-MA1)"; for "`sorry` at the leaf facts" read "no `sorry`: the four model theorems on the standard three; also
     `hornModel_allowedCone`, `twoHornModel_hasDegree` (`4`), `twoHornModel_hasHornCount` (`3`)".
4. **The docstring lines of the plan's § 3.10, for whoever lands the lane** — the five that name these two models stand as the planner
   wrote them, read against what is proved: `exists_shave` / `exists_shave_aux`, `exists_open`, `exists_rayMerge` /
   `exists_rayMerge_aux`, `exists_merge` / `exists_merge_aux`, `HasHornCount`. One addition, at `exists_open`: after
   "(`hornModel_contact`)" add ", the cone itself `hornModel_allowedCone`".
5. **The inventory** (`plans/FS131-close-inventory.md`, Keryx's): the open gate item on the four moves (rulings 419 (d), 427 (d)) has
   its Lean inhabitants on `fs131-wm` — `hornModel` (`exists_shave`, `exists_open`) and `twoHornModel` (`exists_rayMerge`,
   `exists_merge`), each model theorem the move applied, on the standard three; it closes when the lane lands on `main`.
6. **No ledger row, no Frontier line and no Proof Atlas grade moves by this job**: the four moves were kernel theorems already; what
   closes is a gate item about them.

## Theorems this phase proved, final

All **[kernel]**: built by the worktree's `./scripts/build.sh` (`build-4.log`), each on a subset of the standard three axioms
`[propext, Classical.choice, Quot.sound]` by `MAAxioms-4.out` (177 of 177). Addresses are `Proofs/HadwigerNelson/Plane/Models/`.

**The four moves applied to their models** (`Moves.lean`; statements the skeleton's, unchanged):

- `hornModel_shave` — `ArcMap.exists_shave` applied to `hornModel` at `plantPt`. Axioms: the standard three.
- `hornModel_open` — `ArcMap.exists_open` applied to `hornModel` at `plantPt`. Axioms: the standard three.
- `twoHornModel_rayMerge` — `ArcMap.exists_rayMerge` applied to `twoHornModel` at `plantPt`. Axioms: the standard three.
- `twoHornModel_merge` — `ArcMap.exists_merge` applied to `twoHornModel` at `plantPt`. Axioms: the standard three.
- `hornModel_shaveAvailable`, `twoHornModel_available` (KM1's, proved from the leaves; now free of `sorryAx`). The standard three.

**The 18 leaves of `Moves`**: `hornB_nondegenerate`, `frontier_hornW_subset`, `hornModel_valid`, `hornModel_isHorn`,
`hornModel_hasSectors`, `hornModel_hasDegree`, `hornModel_hasHornCount`, `hornModel_flanks`, `hornModel_clear`, `hornModel_contact`,
`hornModel_cone`, `hornModel_holedTile`, `twoHornB_nondegenerate`, `frontier_twoHornW_subset`, `twoHornModel_valid`,
`twoHornModel_isHorn`, `twoHornModel_hasSectors`, `twoHornModel_cone`. Each on the standard three.

**The 13 leaves of `Paint`**: `brickBase_mem_interiorPts`, `brickBase_col_eq`, `brickBase_col_zero`, `norm_plantDir`,
`tangentDisc_subset_ball`, `hornArcs_nondegenerate`, `frontier_hornSet_subset`, `hornArcs_carrier_subset`, `isOpen_fanRest`,
`isPreconnected_fanRest`, `ball_diff_fan`, `isSector_fan_iff`, `fanRest_ne_hornSet`. Each on the standard three (some on fewer).

**Beyond the skeleton** (new statements, this job's): in `Moves` — `hornModel_region_seven`, `twoHornModel_region_seven` (the class of
`7` is the painted set), `hornModel_isSector_iff`, `twoHornModel_isSector_iff` (the sectors at every radius up to `1/10`),
`hornModel_allowedCone`, `twoHornModel_allowedCone` (the closed half-plane), `twoHornModel_hasDegree` (`4`),
`twoHornModel_hasHornCount` (`3`), `isPreconnected_holedTile`, and 35 further helpers; in `Paint` — `ArcMap.region_paint_of_region_eq_empty`,
`ArcMap.region_paint_subset`, `ArcMap.isClear_paint_of_mem_region`, `ArcMap.interiorPts_paint_inter_ball`, `fanPiece_data`,
`encard_sectors_fan`, `encard_horns_fan`, `ArcMap.allowedCone_tangent`, `ArcMap.tangent_contact_cone`,
`dist_tangentCentre_le_of_mem_hornSet`, and 61 further helpers. The full list with each one's axioms is `MAAxioms-4.out`.

**The informal statement each model theorem was read against** (aloud, at the close): *there is a valid map of the plane on which every
hypothesis of the move holds at once, and the move's conclusion follows for it* — for SHAVE and OPEN the eight-colour brick map with a
horn of the spare colour between the tangent arcs of curvatures `∓1/2` at the centre of a brick and a disc of that colour internally
tangent to the unit circle about the horn's vertex; for MERGE-RAY and MERGE the same with two horns on one ray, between the
curvatures `−3/4, −1/2` and `1/2, 3/4`. Each Lean statement says exactly that the move's conclusion holds for the named map; that the
hypotheses hold is what its proof term is — the landed theorem applied to named facts — and that is read in the source, not in the
statement (§ 3.1's table).

## What is left, and its route

- **Implementer B** (`Stuck`, `Bends`; 28 leaves): cut its branch from this one. `Paint` now holds, beyond the plan: the classes of a
  painting for a spare colour and for an unpainted one, the fan's partition as a named family with its counts, `plantBall_subset_brick`
  and the planted disc's colour, `closure_hornSet_subset`, `disjoint_hornSet_hornArcs`, `ArcMap.IsSector.false_of_col`. The plan's § 3.5
  routes for `Stuck` can be read against them; `stuckModel`'s contacts are not the tangent disc's, so `ArcMap.allowedCone_tangent` does
  not serve it.
- **The landing**: the gate, on the merged tree; the docstring lines of the plan's § 3.10 (draft 4 above); the `ARCHITECTURE.md` rows
  (draft 3); `MAAxioms.lean`'s control 1 (two lines) is dropped when `Stuck` and `Bends` are whole — the planted controls 2 and 3 stay.
- **After wave 5**: § 4.3's tidy, and the plan's § 3.8 applications; `twoHornModel`'s degree and horn count are already here for
  `exists_vertexStep`.
