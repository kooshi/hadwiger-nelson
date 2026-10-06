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
