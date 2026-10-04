# FS131-LEB — Lebesgue's covering theorem for the square, in the kernel (de Bruijn, the planner)

*Job FS131-LEB, de Bruijn (Opus 5.5), launched 2026-10-04 in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-leb`
(branch `fs131-leb`, from `main` at `bbee15f0`). Brief `data/fs131/briefs/FS131-LEB-lebesgue.md`, with `plans/STANDING-RULES.md`,
`LEAN.md` and `RUNNING.md` § Building. No fence (inventory ruling 1). Working files `data/fs131/leb/`.*

## Theorems this phase proved

None yet (updated at each stage).

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation | source | result |
|---|---|---|
| "66. **Ruling — Lebesgue's covering theorem for the square** (K4b's OUT-LEB; TS-T's first clause rests on it; Mathlib has neither it nor Brouwer nor Sperner):" | `plans/FS131-close-inventory.md` line 385 | **verbatim** |
| the docstring's first line, "/-- **Lebesgue's covering theorem for the square** (`n = 2`): if a closed square is covered by finitely many closed sets none of" | `.claude/worktrees/fs131-w4/Proofs/HadwigerNelson/Plane/SVMap.lean` line 249 (branch `fs131-w4`, HEAD `6bd00949`) | **verbatim** |
| the code block (`closedSquare`, the docstring, `lebesgue_covering_square` with `sorry`) | same file, lines 246–258 | **verbatim**, except the one path the brief says it rewrote: the source reads `` (`plans/FS131-w4-kernel-plan.md` § 7: `` where the brief reads `` (`.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 7: `` |
| "all implementers now run on Opus (item 137)" | inventory line 825, item 137 (Kooshi, 2026-10-04: "all implementers should be Opus") | matches |
| the ruling's bibliography debt ("Hurewicz–Wallman, *Dimension Theory*, Thm IV 2, recalled, not read, not held") | inventory item 66, lines 386–390 | matches |

Context the brief does not quote, checked: wave 4's two declarations live in `namespace HadwigerNelson.Plane` (SVMap.lean line 28), so
their full names are `HadwigerNelson.Plane.closedSquare` and `HadwigerNelson.Plane.lebesgue_covering_square`; SVMap.lean opens
`Complex Real Set Filter Topology Metric` (line 30). This module therefore uses namespaces that `open Topology` cannot reach
(`HadwigerNelson.SpernerGrid`, `HadwigerNelson.LebesgueCovering`; a namespace `HadwigerNelson.Topology` would be opened by wave 4's
`open … Topology …` from inside `HadwigerNelson`, and its `closedSquare` would then be ambiguous with wave 4's).

### 1.2 The statement, restated

For a point `c : ℂ` and a side `s > 0`, let `Q = closedSquare c s = [c.re, c.re + s] × [c.im, c.im + s]`. Let `F : Fin m → Set ℂ` be
closed sets with `Q ⊆ ⋃ i, F i`, such that no `F i ∩ Q` has both a point with `re = c.re` (the left side) and a point with
`re = c.re + s` (the right side), and no `F i ∩ Q` has both a point with `im = c.im` (bottom) and a point with `im = c.im + s` (top).
Then some `z ∈ Q` lies in `F i`, `F j`, `F l` for three pairwise distinct indices `i, j, l`.

**Read against the classical theorem** (Hurewicz–Wallman Thm IV 2, read in Stage 2): the cube there is decomposed into closed sets
"none of which contains points of two opposite faces", and the conclusion is that "at least n + 1 of these closed sets have a common
point". Wave 4's statement is the case `n = 2` applied to the closed sets `F i ∩ Q`: the hypothesis is stated for `F i ∩ Q`, the
opposite faces of the square are its opposite sides, and "n + 1 of these sets" is read as three distinct *indices* (the stronger
reading when two `F i` coincide; the proof below gives distinct indices directly). **Same statement; true; not vacuous** (a model:
`m = 3`, `c = 0`, `s = 1`, `F 0 = [0, ½] × [0, 1]`, `F 1 = [½, 1] × [0, ½]`, `F 2 = [½, 1] × [½, 1]`; the triple point is `½ + ½ i`).
For `m < 3` the hypotheses are contradictory, as the theorem implies; no hypothesis is missing (a finite index type is necessary:
the singletons of `Q` are a closed cover by sets meeting no two sides, and no point lies in two of them).

### 1.3 The build as given

`/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the worktree,
launched 07:26 (log `data/fs131/leb/build-stage1.log`); at this stage's commit it is still waiting for the slot (ledger 80 of 90 GiB,
two other trees building). Its result is recorded in Stage 2. Because `scripts/build_order.py` builds every file under `Proofs/`, that
build includes the skeleton modules of Stage 3 (already elaborated with `lake env lean`, sorry warnings only).
