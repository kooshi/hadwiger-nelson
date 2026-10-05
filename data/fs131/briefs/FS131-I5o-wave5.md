# Brief FS131-I5o — wave 5 of the Lean backlog: the planar chain merged into `fs131-w5`, then `bv_l3`, `exists_preBend` and `disc1_local`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I5o
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's non-`Terminal` lane — first merge `fs131-w5p` (the finished planar chain) into `fs131-w5` and check it, then prove `bv_l3`, `exists_preBend` and `disc1_local`, saving after each
  launch: now, beside FS131-IMM4 (MERGE's last two clauses, on `fs131-w4mm`) and FS131-I5p (wave 5's `Terminal` half, on `fs131-w5c`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a merge conflict that is more than keeping both sides, a leaf that cannot be proved as written, a statement that looks false, a strengthened bend that needs more than wave 4's bend machinery, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I5o.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (on branch `fs131-w5`; you continue it from Stage 38; the merge brings in `fs131-w5p`'s `plans/FS131-planar-implementation.md`, which stays that branch's record)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5` (branch `fs131-w5`): the merge of `fs131-w5p` (every file it brings, conflicts resolved by keeping both sides' declarations and blocks); then `Proofs/HadwigerNelson/Plane/ValidMap/HexRing.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/Dense.lean` (`disc1_local` and children), `Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean` (`exists_preBend` and children, not `cv_exists`), supporting lemmas in `FlankUA`, `BrickMap`, `Chain`, `MapTopology`, `PlaneTopology`'s neighbours or wave 3–4's foundation modules as plan § 10.2 allows (statements unchanged); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (your blocks), `plans/FS131-I5-implementation.md`, `tools/fs131_i5_*.py`, `data/fs131/i5m/`, `data/fs131/i5o/`, `data/fs131/reports/FS131-I5o.md`; **not** `Terminal.lean` (the `Terminal` half's, on `fs131-w5c`), any statement on either side of the merge, `main`, or wave 4's modules
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are taking wave 5's non-`Terminal` lane to its end, on Opus. Wave 5 is **termination and density**: the terminal valid map the moves reach, the
ends of stuck chains, row 134's base step with unit arcs, and the density results built on it. The milestone, FS-131, turns this project's hand-derived
results into kernel-checked ones; waves 1–4 and Woodall's chain are on `main`. The planar chain — the plane topology wave 5 needed and Mathlib lacked — has
just been finished on `fs131-w5p` by six implementers (the boundary walk's SEP was the last), so `row134BaseUA` and FS114-CVB-THOM can now rest on proofs. Your
first job is to bring it into `fs131-w5`; then the last three leaves of this lane.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and wave 5's landing
needs all three branches merged and every leaf proved. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

The merge's ruling, and what the planar chain's last job handed back:

> 358. **Ruling on RS1's slot: FS131-I5o on `fs131-w5`** — (1) **merge `fs131-w5p` (at `5086e856`) into `fs131-w5`** (both sides touch only `ARCHITECTURE.md`,
> — source: plans/FS131-close-inventory.md

> 357. **FS131-RS1 done: SEP is held — the planar chain is complete** (harness ≈ 295k by the task notice; record `fs131-w5p`'s
> — source: plans/FS131-close-inventory.md

Your three leaves, after the merge. `bv_l3` and `exists_preBend`, where I5m left them (read its Stage 37 in full):

> - **`bv_l3`** (H; off the walk's path). The route, every input named:
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md Stage 37 — SAVED: the linkage to first order (five children for `bv_l3`); `bv_l3` moved below `bv_nd`; the handoff

> - **`exists_preBend`** (H): the strengthened bend (ruling 317 (b)) — not attempted; E4-BEND-UN (`plans/FS131-E4-derivation.md`) not read in this job.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md Stage 37 — SAVED: the linkage to first order (five children for `bv_l3`); `bv_l3` moved below `bv_nd`; the handoff

and `disc1_local`, `sorry` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/Dense.lean` (read it whole there):

> /-- **FS112-DISC1 on a fragment** (FS129-OR1-LOCALDENSE's use: "read on a fragment: its argument nests tiles surrounding `x`, each of
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/Dense.lean

> theorem disc1_local (hF : F.Valid) {x : ℂ} (hx : F.Covers x 1) : ∃ y ∈ closedBall x 1, 3 ≤ (F.coloursAt y).ncard := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/Dense.lean

What I5m handed back, and the strengthened bend's rulings (read `plans/FS131-E4-derivation.md` for E4-BEND-UN in full; `bend_toward` is `sorry` on this
branch and proved on `main` — cite it by statement):

> 349. **FS131-I5m handed back** (Stage 37 SAVED, harness ≈ 423k by the task notice; record `fs131-w5`'s `plans/FS131-I5-implementation.md`, Stages 34–37; report
> — source: plans/FS131-close-inventory.md

> 317. **Rulings on I5f's questions, and its slot.** (a) **I5f's slot → FS131-I5g on `fs131-w5`**, the same half: `row134BaseUA`'s four first (`reduce` by I5f's
> — source: plans/FS131-close-inventory.md

> 226. **FS131-E4 done, harness ≈ 480k** (report `data/fs131/reports/FS131-E4.md`; record `plans/FS131-E4-derivation.md`; commits `fffe465f` … `e2928a7b`, checked;
> — source: plans/FS131-close-inventory.md

The planar job's fence (now lifted by the merge for the files it brings, which are yours to cite, never to restate):

> 274. **Rulings on QA3's held items and the freed slot.** (a) **`InMK`**: restated when its first consumer is planned, not now (no theorem uses it; a definition
> — source: plans/FS131-close-inventory.md

What you may change:

> **It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md ### 10.2 What the implementer may and may not change

`exists_merge` has its own path (items 347–348): nothing in this lane cites it.

> 295. **Ruling: MERGE leaves wave 4; the freed slot goes to FS131-IX1 as ruled.** Choice: (a) wave 4 lands without `exists_merge` — at wave 4's merge-and-gate,
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read I5m's Stages 34–37 and RS1's Stage 29 (on `fs131-w5p`); build `fs131-w5` once
   as given (`f33ef153`) before editing anything. Commit and push.
2. **The merge**: `git merge origin/fs131-w5p` (at `5086e856`) into `fs131-w5`; resolve conflicts by keeping both sides (the five shared files: `ARCHITECTURE.md`,
   `BaseDense`, `BaseWalk`, `Proofs.lean`, `scripts/Axioms.lean`); build; then check, and record: (a) every statement in `BaseWalk`, `BaseDense`, `MapGraph`,
   `MapTopology`, `CurveGraph`, `PlaneTopology`, `Thomassen` byte-identical to its side's tip (a script over both parents); (b) `BaseWalk`'s planar three and
   `MapGraph`'s leaves on the standard three in an axioms print against the merged build, `row134BaseUA` and `cvb_thom_reduced` among them, with a control on
   `sorryAx`; (c) the `sorry` count by file before and after. Commit the merge as its own stage (a merge commit, attribution lines in its message) and push.
3. **The leaves**: `bv_l3`, then `exists_preBend` (over the strengthened-bend child you state and read back against E4-BEND-UN), then `disc1_local`. Save after
   each; no statement changed, no new `axiom`, no `native_decide`; run `tools/fs131_i5_stmt_check.py d61edefc` before each stage commit. Do not edit a file while
   a build of it runs.
4. **Your record**, stages headed "Stage n — SAVED (FS131-I5o)", "Theorems this phase proved", each with its build log and an axioms print including a control
   on `sorryAx`; the report in standing rule 11's form. You do not merge `fs131-w5c` or `main`, apply `framePt → fromFrame`, run the gate, or touch `main`. Leave
   no background process running. Stopping at a saved stage with leaves left, named, is a good report.

## What is yours to decide

The merge's mechanics, the proofs, their children and order within the leaves' dependencies, and the strengthened bend's exact statement. I5m's routes are
notes, not rules. If the merge meets a conflict that is more than keeping both sides — a statement both sides changed, a name both sides declare — stop and
message me with the hunks. If a leaf cannot be proved as written, stop that leaf, message me with the declaration, the reason, and the smallest counterexample
or the missing hypothesis, and go on with the others. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth.
You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink (the merge brings new modules, so its first build compiles them). Nothing with a
`sorry` reaches `main`.
