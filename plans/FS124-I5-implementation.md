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
