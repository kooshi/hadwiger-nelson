# Brief FS131-I4n — wave 4 of the Lean backlog, continued: the moves branch merged, `n3_end` moved to wave 5, and the two bends in `UnitArc` and `BaseSteps` on branch `fs131-w4`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I4n
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 4's fourteenth implementer — merge branch `fs131-w4m` (the moves' `Surgery`, SHAVE, RAY) into `fs131-w4`, make `Contact` cite the two proved moves, move `n3_end` out to wave 5 (inventory item 289), and prove `bend_toward` and `bend_away`
  launch: now, beside FS131-IMM1 (wave 4's MERGE, on `fs131-w4mm`), FS131-I5d (wave 5, on `fs131-w5`) and FS131-IP1 (the planar implementer, on `fs131-w5p`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I4n.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I4-implementation.md` (on branch `fs131-w4`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4` (branch `fs131-w4`): the skeleton modules except `Contact` (`Proofs/HadwigerNelson/Plane/StuckChain.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BaseSteps.lean`, `Proofs/HadwigerNelson/Plane/SVMap.lean`), the foundation `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` (the engines, sorry-free), supporting lemmas in the foundation modules § 14.2 names (statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 4's carriers only, at the gate), `plans/FS131-I4-implementation.md`, `tools/fs131_i4_*.py`, `data/fs131/i4/`, a new wave-4 module for `localSectors` if item 126 makes it yours (`Proofs/HadwigerNelson/Plane/ValidMap/Sectors.lean`, say), `data/fs131/reports/FS131-I4n.md`; `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` only by merging the parallel implementer's branch, or under item 194's fallback; `Proofs/HadwigerNelson/Plane/LocalStructure.lean` for `localSectors_disj` only (item 244 (b))
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k




Hello. You are wave 4's fourteenth implementer, on Opus. Wave 4 is the valid-map machinery the frontier's local exclusion rests on, and it is nearly done.
FS131-I4m proved FLANK-Q's shadow clause and NB4P on `fs131-w4`; FS131-IM3 proved two of the three simplifying moves, SHAVE and MERGE-RAY, on `fs131-w4m`,
over a surgery module (`Plane/ValidMap/Surgery`); FS131-IMM1 is proving the third, MERGE, on `fs131-w4mm`. Your job brings the moves branch in, cites the
two proved moves, moves one leaf out to wave 5 where its tools are being built, and proves the two bends. After you, wave 4 waits only on MERGE.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Wave 4 gates Woodall's
landing and wave 5's.

## The statements

`bend_toward` and `bend_away` in `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean` on branch `fs131-w4` at `a0c29483`, read back in
`.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 12.2, planned in § 13 (engine 3). Where I4m left the branch:

> **What is left (3 in this job's files): UnitArc `bend_toward`, `bend_away`; BaseSteps `n3_end`.** Contact's three moves are IM3's.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/plans/FS131-I4-implementation.md Stage 40 — SAVED (FS131-I4m): `nb4p` (FS112-NB4P); 6 `sorry` left on the branch (Contact 3, UnitArc 2, BaseSteps 1), and the handoff

What I4m handed back, and the rulings on it — read both items in full:

> 288. **FS131-I4m handed back** (Stage 40 SAVED, harness 466k by the task notice; report `fs131-w4`'s `data/fs131/reports/FS131-I4m.md`; commits `70075915`,
> — source: plans/FS131-close-inventory.md

> 289. **Rulings on I4m's items: `n3_end` moves to wave 5; the next wave-4 job merges the moves branch and proves the bends.** (a) **`n3_end`'s reading** (Stage 38)
> — source: plans/FS131-close-inventory.md

What IM3 handed back (the branch you merge):

> 286. **FS131-IM3 handed back** (Stage 10 SAVED, harness 538k by the task notice; report `fs131-w4m`'s `data/fs131/reports/FS131-IM3.md`; commits `8ab4f838`,
> — source: plans/FS131-close-inventory.md

What you may change:

> **It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md § 14.2 What the implementer may and may not change

Rulings still in force on this branch: item 244 (`localSectors_disj` in wave 3's `Plane/LocalStructure`; keep it at every merge), item 177 (`lock`'s clause 3),
items 185, 258 and 281 (a) (binder renames), item 269 (`exists_merge`'s vertex clause, which arrives with the merge).

## Done means

1. **Your readback first**: check every quotation above against its source; read I4m's Stages 38–40 and IM3's record §§ 7–10 (on `fs131-w4m`); build the branch
   once as given (`a0c29483`). Commit and push.
2. **The merge**: `git merge origin/fs131-w4m` (at `67256973`). `Contact` should merge cleanly (IM2 and IM3 deleted its prefix, d4f946ae l. 26–2593, and
   changed `exists_merge`'s statement; IC5's hunks lie below l. 3249); keep both sides in `scripts/Axioms.lean` (records above the `=== PURCHASED ===` banner,
   never after it) and `ARCHITECTURE.md`; if a Lean file conflicts otherwise, stop and message me. Then `tools/fs131_qa1_dupes.py` and
   `tools/fs131_i4_treedupes.py`, the statement comparison against both parents, and a green build. A merge commit is the one commit made without paths.
3. **The citations**: `Contact`'s `exists_shave` and `exists_rayMerge` proved by `exists_shave_aux` and `exists_rayMerge_aux` (statements identical:
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4m/tools/fs131_im_statements.py`, arriving with the merge); `exists_merge` stays `sorry` until MERGE arrives.
4. **`n3_end` moved out** (item 289 (b)): delete its declaration and docstring from `BaseSteps` and its `#print axioms` line from `scripts/Axioms.lean`, in one
   commit whose message names item 289; FS131-I5d adds it verbatim to wave 5's `Terminal`.
5. **The bends**: read `Surgery`'s cut and surgery (`Near.exists_cut`, `ArcMap.surgery`) before you state engine 3, and reuse them where they serve; prove
   `bend_toward` and `bend_away`, saving after each child; no statement changed, no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs.
6. **Your record** (continue it), stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. You do not merge
   `fs131-w4mm`, run wave 4's gate, or touch `main`. Stopping at a saved stage with work left, named, is a good report.

## What is yours to decide

The proofs, their children and order, and where a supporting lemma lives (statements unchanged). If a bend cannot be proved as written, stop it, message me with
the declaration, the reason, and the smallest counterexample or the missing hypothesis. Three failed attempts on one route is a dispatch to the companion your
identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it
knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them (inventory ruling 5), and
several trees are building today, so on exit 75 wait ten minutes and retry. `lake env lean` (with § 14.1's flags) is for iteration only, never evidence.
The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`. You start no agents of your own
(standing rule 1).


## Amendment, 2026-10-04 — `bend_away`'s statement (inventory items 290–291)

Your finding is logged as item 290 and ruled in item 291, whose first line is:

> 291. **Ruling on item 290: `bend_away` gains the domain hypothesis; `bend_away_whole` is proved directly; `bend_away` leaves wave 4 if it is not done when MERGE
> — source: plans/FS131-close-inventory.md

Your touches gain `bend_away`'s statement (that one hypothesis and its docstring) and `bend_away_whole`'s proof. You start no agents of your own (standing rule
1: delegation is one level deep, because the coordinator can only review work it knows exists).

## Amendment, 2026-10-05 — MERGE leaves wave 4 (inventory items 294–295)

FS131-IMM1 handed back at its line with MERGE not yet proved (two to three sessions left), and nothing in Lean consumes `exists_merge`. The ruling:

> 295. **Ruling: MERGE leaves wave 4; the freed slot goes to FS131-IX1 as ruled.** Choice: (a) wave 4 lands without `exists_merge` — at wave 4's merge-and-gate,
> — source: plans/FS131-close-inventory.md

For you this changes one thing: `bend_away`'s trigger. If the repaired `bend_away` is not proved when you hand back, it moves out of wave 4 (item 291 (d)),
and your report says so. Leave `exists_merge` and `exists_merge_aux` as they are (`sorry`); the merge-and-gate job deletes them. Your work order, touches and
budget are unchanged. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).
