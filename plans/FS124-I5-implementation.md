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
