# Brief FS131-M6 — `fs131-w5` (with `main`) merged into `fs131-w5c`, then lane B's two `Terminal` children

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-M6
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's second sync — merge `origin/fs131-w5` (now carrying `main`, the planar chain and the non-`Terminal` lane) into `fs131-w5c`, applying `framePt → fromFrame` on this branch's side and removing copies, and check it; then, as budget allows, lane B's `run_hornBoundsQR` and `stuckRun_ne_univ`
  launch: now, beside FS131-IO1 (OPEN, on `fs131-wop`) and FS131-KP2 (the collar construction's planner, on `fs131-w5`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a conflict that is more than keeping both sides (or `main`'s proved side for a wave-4 declaration), a name both sides declare with different statements, a statement the merge shows false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-M6.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (on branch `fs131-w5c`; you continue it, headed as yours, after the merge has joined both sides' stages)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` (branch `fs131-w5c`): the merge's files (conflicts resolved as § Done means 2 says); this branch's own modules for the rename and the deletions of copies only (no statement or definition changes); `Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean` (`run_hornBoundsQR`, `stuckRun_ne_univ` and children beside them); in `Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean` only `badCount_lt_top`'s unused `hc` (item 389 (a)); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-I5-implementation.md`, `tools/fs131_m6_*.py`, `data/fs131/m6/`, `data/fs131/reports/FS131-M6.md`; **not** `main`, `fs131-w5`, `exists_vertexStep`, `exists_arcStep`, `exists_terminalSeq`, `BendCollar`, nor the gate scripts' recorded counts
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are joining wave 5's two main branches. The milestone, FS-131, turns this project's hand-derived results into kernel-checked ones; on `main` are
waves 1–4, Woodall's chain and MERGE. Wave 5 has run on two branches since `75689a4c`: `fs131-w5` (the planar chain, the non-`Terminal` lane, and now `main`,
merged by FS131-M5) and this one, `fs131-w5c` (the `Terminal` lane and the limit constructions). Since their base they share six changed files. You bring
`fs131-w5` into `fs131-w5c`; then lane B's two theorems about every terminal six-map are yours if budget allows.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`); this merge leaves wave
5's landing only the collar construction's later commits and the procedure's last steps. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

The rulings that launch you, and what the last jobs handed back:

> 389. **Rulings on IL2's held items, and its slot.** (a) **`badCount_lt_top`'s `hc` dropped** by the next job that touches `Procedure` (a stronger theorem; its
> — source: plans/FS131-close-inventory.md

> 388. **FS131-IL2 done: the limit's lane A is complete** (harness ≈ 525k by the task notice; record `fs131-w5c`'s `plans/FS131-limit-kernel-plan.md`, Stages 9–11;
> — source: plans/FS131-close-inventory.md

> 386. **FS131-M5 done: `main` merged into `fs131-w5`** (harness ≈ 368k by the task notice; record `fs131-w5`'s `plans/FS131-I5-implementation.md`, Stages 47–51;
> — source: plans/FS131-close-inventory.md

> 355. **FS131-I5n handed back** (Stage 42 SAVED, harness ≈ 429k by the task notice; record `fs131-w5c`'s `plans/FS131-I5-implementation.md`, Stages 39–42;
> — source: plans/FS131-close-inventory.md

> 340. **FS131-I5k handed back: FS112-N3-END is held** (Stage 34 SAVED, harness ≈ 434k by the task notice; record `fs131-w5c`'s `plans/FS131-I5-implementation.md`,
> — source: plans/FS131-close-inventory.md

> 373. **FS131-KL1 done: the limit constructions planned** (planner; stage 4 SAVED, harness ≈ 418k by the task notice; record `fs131-w5c`'s
> — source: plans/FS131-close-inventory.md

## The statements

No backlog statement changes in this job. After the merge, lane B's two leaves (`sorry` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean` at `8d84435e`; read each whole there, with its route in
KL1's plan § 3.1), their first lines:

> theorem run_hornBoundsQR {F : ArcMap 6} (hM : F.IsTerminalMap) {v : ℂ} {α : ℝ} (hv : F.StuckAlong v α)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean

> theorem stuckRun_ne_univ {F : ArcMap 6} (hM : F.IsTerminalMap) {v : ℂ} {α : ℝ} (hv : F.StuckAlong v α)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean

## Done means

1. **Your readback first**: check every quotation above against its source; read M5's merge stage (48, on `fs131-w5`'s record) for how it took `main`'s side and
   checked it; build `fs131-w5c` once as given (`8d84435e`) before editing anything. Commit and push.
2. **The merge**: `git merge origin/fs131-w5` into `fs131-w5c`. The six shared files: `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean` — keep both sides;
   `plans/FS131-I5-implementation.md` — keep both sides' stages, `fs131-w5`'s numbered as they are and this branch's after, with a line naming the join;
   `BaseDense` — keep both sides (`exists_preBend`'s children from `fs131-w5`, `cv_exists`'s proof from here); `Contact` — `fs131-w5`'s (that is `main`'s)
   `exists_merge`, proved, whose statement equals this branch's (item 355). Apply `framePt → fromFrame` on this branch's side (`HornShadow`, `Terminal`, and any
   other file of this branch that uses it); check no `framePt` resolves to wave 2's `Plane/Slack.framePt`. Remove this branch's copies of lemmas `fs131-w5` or
   `main` now holds (`isPreconnected_hornSet_unit`, `IsHorn.isRingArc_lower_ua`, `Arc.ptL`/`paramsL`/`subL` and their lemmas,
   `branchPt_mem_closure_sector_pair`, and any `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/tools/fs131_m5_dupes.py <branch> origin/main <fork>` or your own script finds — with a plant), renaming their
   uses. Run a three-way statement check (M5's `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/tools/fs131_m5_merge_check.py` adapted, or I5o's): every statement of either side byte-identical to the side that
   changed it, up to the declared renames. Build; an axioms print against the merged build (`flankQ_upper`, `flankQ_lower`, `cv_class`, `c_double`, `c_ends`,
   `exists_merge` on the standard three; a control on `sorryAx`); the `sorry` count by file before and after. Commit the merge as its own stage and push.
3. **Lane B**, as budget allows: `run_hornBoundsQR`, `stuckRun_ne_univ` (with `shadow_recursion`, KL1's route); and drop `badCount_lt_top`'s unused `hc`. Save
   after each; no other statement changed, no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs.
4. **Your record**, stages headed "Stage n — SAVED (FS131-M6)", "Theorems this phase proved"; the report in standing rule 11's form. You do not merge into
   `fs131-w5`, run the full gate, or touch `main`. Leave no background process running. Stopping at a saved stage with work left, named, is a good report.

## What is yours to decide

The merge's mechanics and its checks, the order of the leaves, and where a supporting lemma lives within your touches. If the merge meets a conflict that is
more than the six files' resolutions above, or a name both sides declare with different statements, stop and message me with the hunks. Three failed attempts
on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; the merge brings many changed modules, so the first build after it is long. Never replace the build with a symlink.
Nothing with a `sorry` reaches `main`.
