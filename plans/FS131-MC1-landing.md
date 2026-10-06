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
