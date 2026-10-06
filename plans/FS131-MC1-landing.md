# FS131-MC1 — the example maps finished and landed (de Bruijn, the implementer)

*Brief: `data/fs131/briefs/FS131-MC1-models-land.md` (on `main`). Branch `fs131-wmb`, worktree `.claude/worktrees/fs131-wmb`, from
`b9b3a9e5`. Started 2026-10-06 10:20 UTC. Logs and working files: `data/fs131/mc/`.*

## Theorems this phase proved

*Filled at each saved stage; the final list is the section "Theorems this phase proved, final" at the end of this file.*

## Stage 1 — SAVED (FS131-MC1): the readback, the build as given

### 1.1 The brief's quotations (standing rule 3)

Each of the brief's fourteen quotations was searched verbatim (`grep -cF`) in its named source; each is found exactly once: `CLAUDE.md`
§ The standard of evidence (1); `plans/FS131-close-inventory.md` items 466, 471, 472, 474, 475, 479, 480 (7; each read in full);
`Plane/Models/Stuck.lean` `stuckModel_terminal` and `stuckModel_hyps` (2); `Plane/Models/Bends.lean` `awayModel_hyps` (1);
`Plane/Models/Moves.lean` `hornModel_shave` (1); `plans/FS131-models-kernel-plan.md`'s Stage 3 heading (1);
`plans/FS131-MB1-implementation.md` § 8.4's heading (1). **No mismatch.**

### 1.2 What was read, and how far

- `plans/STANDING-RULES.md`, `LEAN.md` (this branch's copy, and `main`'s diff against it: the naming rule and the `dupnames.sh` bullet),
  `RUNNING.md` § Building and § Make the gate fail — in full.
- The planner's record `plans/FS131-models-kernel-plan.md` §§ 3.1–3.13 in full; MA1's record Stage 4, its drafts and "What is left";
  MB1's record Stage 4 and drafts; MB2's Stages 7–8, drafts and theorem list — in full. The earlier stages of the three records: headings
  only.
- `plans/FS131-L5-landing.md` (on `main`) Stages 4–6 and the drafts, in full: the gate's order and its instruments.
- `plans/FS131-E7-derivation.md` §§ 7.1–7.6 in full (the terminal claim and what it does to the stuck family's docstrings).
- The inventory's items named above.

### 1.3 The build as given

`data/fs131/mc/build-asgiven.log` (2026-10-06 10:26 UTC, `HEAD=b9b3a9e5`): `build: OK — all 1771 modules already up to date, nothing
built, 1 module(s) with warnings`, `exit=0`; the one warning replayed is `Plane/Models/Stuck.lean:1362:8: declaration uses 'sorry'`
(`stuckModel_terminal`). MB2's full log of the same sources (`data/fs131/mb2/build-3-full.log`) holds no other warning.

### 1.4 What I may and may not change

No statement or definition of a landed declaration; no statement of the lane's skeleton. New declarations in the four model modules (or
beside them); docstrings only in landed modules; the registrations the gate's procedures ask.

## Stage 2 — SAVED (FS131-MC1): `main` merged in (`abe678bb`); the joined tree builds; no doubled name

- **The trial** (`git merge-tree --write-tree --name-only HEAD origin/main`, `data/fs131/mc/merge-trial.txt`; `origin/main` at
  `c52be9e9`, merge base `f46430e2`): one conflict, `scripts/Axioms.lean`; `ARCHITECTURE.md` and `Proofs.lean` merge by themselves.
- **The merge `abe678bb`** (`git merge --no-ff origin/main`): `scripts/Axioms.lean` keep-both, `main`'s blocks first and the example
  maps' block after them, above the `=== PURCHASED ===` banner — 5,328 `#print axioms` lines = `main`'s 5,221 + the lane's 107;
  `git diff origin/main -- scripts/Axioms.lean` removes no line. Against `main`, `Proofs.lean` gains the four `Plane.Models` imports
  and `ARCHITECTURE.md` the four rows, nothing else.
- **The build tree.** Wave 5's compiled modules were copied in from the idle landing worktree before the build
  (`rsync -a --update .claude/worktrees/fs131-w5c/.lake/build/ .lake/build/`, `data/fs131/mc/rsync-w5c-build.txt`: 76 `.olean` files
  written, 24 of them new; that tree is at `ad611866`, whose `Proofs/` is `main`'s — `git diff --name-only 1351ebc2 origin/main --
  Proofs Proofs.lean lakefile.toml lake-manifest.json lean-toolchain` is empty). Lake checks each module's trace by hash, so a
  copied file that did not match its source would have been rebuilt.
- **The build of the joined tree** (`data/fs131/mc/build-merge.log`, `HEAD=abe678bb`): `build: OK — 465 of 465 batches, 5 module(s)
  rebuilt, 1 module(s) with warnings, 8m41s`, `exit=0`; the full log (`build-merge-full.log`) ends `Build completed successfully
  (5807 jobs)` and holds one warning, twice printed: `Plane/Models/Stuck.lean:1362:8: declaration uses 'sorry'`. The five rebuilt are
  the four model modules and `Proofs`.
- **`./scripts/dupnames.sh` on the joined tree, before anything else** (`data/fs131/mc/dupnames-joined.log`, `exit=0`): `dupnames: OK
  — no name is declared by two modules (23 generated on demand, listed above)`. The three brick facts re-proved in this lane carry
  names of their own (`brickBase_mem_interiorPts`, `brickBase_col_eq`, `brickBase_col_zero`), so the join made no doubled name; the
  tidy to wave 5's `BrickMap` is Stage 3's.

### 2.1 A finding sent to the coordinator at this stage (by message, 2026-10-06)

Read by script over the nineteen stuck-family heads of `Plane/ValidMap/Terminal`: `F.Terminal` alone is a hypothesis of `n3_end_chain`
(and of the three `n3_end_*` steps whose `hno` the model fails by design); `cv_l0`, `hornBoundsQR_of_isChainVertex`,
`horn_upper_ne_one`, `c_ends`, `run_ends` take `hM : F.IsTerminalMap`, which is `Valid ∧ IsPlaneMap ∧ Terminal ∧ QROnly`
(`Plane/ValidMap/Chain.lean` l. 76). `stuckModel.QROnly` is not a declaration of the skeleton. So `stuckModel_terminal` proved would
serve one docstring line in full (`n3_end_chain`); `cv_l0`'s needs `QROnly` beside it. The other fifteen heads take `Covers` or
`IsPlaneMap` with `IsStuck` or `IsChainVertex`, which `stuckModel_hyps` supplies.
