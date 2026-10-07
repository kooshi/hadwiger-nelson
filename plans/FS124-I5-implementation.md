# FS-124 — the implementation of three arcs from a point: the twenty leaves of `Plane/ThreeArcs` (job FS124-I5)

*De Bruijn, the implementer. Brief: `data/fs124/briefs/FS124-I5-three-arcs.md` (on `main`). The module:
`Proofs/HadwigerNelson/Plane/ThreeArcs.lean`, on branch `fs124-wk3`, from the planner's tip `8cd74a6b`. The plan:
`plans/FS124-kernel-plan-3.md` (§ 4.3, the route per leaf). Working files: `data/fs124/i5/`. The record is written in
stages; each is committed before the next starts.*

## Theorems this phase proved

*(Filled stage by stage; the final list with axioms is at the last stage.)*

## Stage 1 — SAVED (FS124-I5): the readback and the build as given

**The quotations.** `data/fs124/i5/readback.py` (the planner's reader, copied unchanged but for its first line) on the
brief: **9 of 9 quotations found in their sources**, exit 0 (`data/fs124/i5/logs/readback.txt`); the control (one
letter of each quotation changed) finds none of the nine, exit 0 (`data/fs124/i5/logs/readback-control.txt`). No
mismatch.

**Read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and
watch it fail; the planner's record `plans/FS124-kernel-plan-3.md` (Stages 1–5); the module (513 lines: 41 theorems, 21
proved, 20 `sorry`); and the statements the route reads from outside it — `exists_inter_of_finite_closed_cover`
(`Plane/PlaneTopology`), `inter_nonempty_of_interleaved_radius` and `polarPt_ne_of_sub` (`Plane/ValidMap/MapTopology`),
`polarPt`, `norm_polarPt_sub` (`Plane/LocalStructure`), `e`, `e_add_two_pi` (`Plane/Basic`).

**The build as given.** `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from this
worktree at `8cd74a6b`: `EXIT 0`, "all 1854 modules already up to date, nothing built", **26 `declaration uses sorry`
warnings and no other** — 3 in `Plane/ClosePairModel`, 3 in `Plane/SectorPoint`, 20 in `Plane/ThreeArcs`
(`data/fs124/i5/logs/build-as-given.log`).

**How I iterate.** `data/fs124/k3/lean1.sh` (`lake env lean` with the lakefile's two options and the docstring linter):
never evidence. Evidence is the build under the slot at each saved stage.

## Stage 2 — SAVED (FS124-I5): leaves 1–5

**Proved, by the planner's route each** (`plans/FS124-kernel-plan-3.md` § 4.3, rows 1–5):
`exists_arc_range_subset_inter`, `IsTriod.range_subset_of_isPreconnected`, `IsTriod.apply_one_eq_polarPt`,
`IsTriod.exists_rimOrder` (the sort: `Tuple.sort`, `Tuple.monotone_sort`), `IsTriod.notMem_iUnion_range_of_mem_Ioo`.
One helper, new: `IsTriod.polarPt_mem_sphere` (a point at radius `r` about `x` is on the rim; searched by shape —
`rg "polarPt.*(sphere|closedBall)"` over `Proofs/` — and held nowhere as a lemma).

**The build** (`data/fs124/i5/logs/build-1.log`): `EXIT 0`, 477 of 477 batches, 2 modules rebuilt (`Plane/ThreeArcs`,
`Proofs`), **21 `declaration uses sorry` warnings and no other** — the 6 as given and 15 in `Plane/ThreeArcs`.

**The statement check, built at this stage** (`data/fs124/i5/statements.sh`, with
`data/fs124/i5/lean/StatementDump.footer`): the planner's skeleton (`git show 8cd74a6b:…/ThreeArcs.lean`) and a
candidate file are each elaborated with a footer that prints every declaration's stored type and its hash; the check
passes iff every line of the skeleton's print is a line of the candidate's. It reads the statements as the elaborator
stored them, not as text (`LEAN.md` § Searching — Lean, on reading a leaf as the kernel has it). Its own check: each
of the 41 `theorem` names written in the skeleton must be in the skeleton's print. **Control**
(`data/fs124/i5/logs/statements-control.txt`): one hypothesis added to `IsTriodCut.mem_closure` in a copy — the check
exits 1 and names that theorem.

## Stage 3 — SAVED (FS124-I5): leaves 6–20 — the module holds no `sorry`

**Proved, in the order of § 4.3 (rows 6–20), each by the planner's route**: `IsTriodCut.piece_subset_ball`,
`disjoint_iUnion_range`, `exists_unique_mem_closure`, `closure_inter_closure_subset`, `exists_forall_rimArc`,
`ne_of_rimOrder`, `exists_rimPieces`, `closure_inter_nonempty`, `isPreconnected_closure_inter`, `rimPiece_spec`,
`exists_opposite` (**the θ-lemma**), `exists_range_subset`, `closure_inter_closure_inter_ball`, `mem_closure`,
`exists_arc`. No leaf failed an attempt on its route; no leaf is left `sorry`; no companion was dispatched to.

**Where a proof's shape differs from the plan's row** (the route is the same):
- row 14 (`isPreconnected_closure_inter`): the second closed set is `⋃ j : {j // j ≠ i}, (T ∪ closure (P j))` — a union
  over the two other pieces as a subtype — not the union over all `j` with an `if`; closed by
  `isClosed_iUnion_of_finite`, preconnected by `isPreconnected_iUnion` through `x`, each member by
  `IsPreconnected.union` at a point of `closure (P j) ∩ T` (row 13).
- row 16 (`exists_opposite`): `opp` is `Equiv.ofBijective` of the `if`-function, its bijectivity from surjectivity
  (`Finite.injective_iff_surjective`), which is three cases; the two conjuncts by nine and three cases.
- row 10: the midpoint's piece, then `exists_inter_of_finite_closed_cover` as planned; the uniqueness clause is proved
  first and the closed arc read from it.

**Nine more helpers** (ten with stage 2's), each under a name no other module declares (`rg` over `Proofs/` for each
name: no hit outside this module), each searched by its statement's shape first:
- `polarPt_add_turn` — `polarPt x r (φ + 2π) = polarPt x r φ`. **The same statement is held as `polarPt_add_two_pi`
  in `Plane/Saturated/FanBridge`, which is outside this module's import closure** (the planner's § 4.3 note); it is
  restated here under a name of its own (`LEAN.md` § Searching — Lean: a line that needs another line's lemma states
  it under its own name and says so). The landing may keep both or move one.
- `fin_three_eq_or_of_ne`, `exists_ne_ne_fin_three`, `fin_three_add_one_ne` — three facts of `Fin 3` by `decide`
  (the shape of the first is `RimOrder.eq_or`'s, without the order; `Topology/SpernerGrid` holds it for its own
  structure `Rainbow`, outside the closure).
- `IsTriodCut.mem_diff_of_mem`, `exists_mem_piece` — the fill clause read in each direction;
  `eq_of_mem_of_mem_closure` — a point of a piece is in no other piece's closure (Mathlib's
  `Disjoint.closure_right`); `closure_piece_subset_closedBall`; `disjoint_range_union_range`.

**An unused hypothesis, reported and not dropped** (the brief's § Done means, 3): `IsTriodCut.exists_range_subset`'s
`hij : i ≠ j` is not read by its proof — for `i = j` the statement says a piece's closure holds a whole arc, which is
true as well. The statement is unchanged; the proof holds `have _ := hij` with a comment, so that no linter reports
the binder.

**The statements are unchanged** (`data/fs124/i5/logs/statements.txt`): `statements.sh` on the module — the skeleton
prints 79 declarations (62 theorems to the kernel: the 41 written and the structures' fields), the module 89 (the ten
helpers more), and **every declaration of the skeleton is in the module with the same stored type**, exit 0.

**The build** (`data/fs124/i5/logs/build-2.log`): `EXIT 0`, 477 of 477 batches, 2 modules rebuilt (`Plane/ThreeArcs`,
`Proofs`), **6 `declaration uses sorry` warnings and no other** — the 6 as given (3 in `Plane/ClosePairModel`, 3 in
`Plane/SectorPoint`), **none in `Plane/ThreeArcs`**.

**The axioms, from the built library** (`data/fs124/i5/lean/Axioms.lean`, generated by `data/fs124/i5/axioms.py gen`
from the module's own `theorem` lines; the print: `data/fs124/i5/axioms.txt`; the verdict:
`data/fs124/i5/logs/axioms-verdict.txt`): **51 theorems written in the module, 51 printed on a subset of `[propext,
Classical.choice, Quot.sound]`**, exit 0. The module's last theorem:

> 'HadwigerNelson.Plane.IsTriodCut.exists_arc' depends on axioms: [propext, Classical.choice, Quot.sound]
> — source: data/fs124/i5/axioms.txt

**Controls, each watched to fire**: a theorem closed by `sorry` in the scratch file prints `sorryAx`; a theorem on a
planted axiom prints that axiom; and the checker run on the library as built at stage 2 (fifteen leaves open) exits 1
— it names the fifteen on `sorryAx` and the nine helpers not yet there
(`data/fs124/i5/logs/axioms-control-build1-verdict.txt`).

**A slip, disclosed**: the brief asks for a saved stage after every five leaves. Leaves 6–20 were written against a
working copy while the build of leaves 1–5 walked (nine minutes), all fifteen elaborated before it ended, and they
are saved here in one stage after one build, not three. Nothing was at risk meanwhile but the nine minutes of the
build: the working copy was on disk.
