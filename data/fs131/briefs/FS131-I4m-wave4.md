# Brief FS131-I4m — wave 4 of the Lean backlog, continued: the 6 remaining `sorry` declarations in `UnitArc` and `BaseSteps` on branch `fs131-w4`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I4m
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 4's thirteenth implementer — the six leaves left on `fs131-w4` outside `Contact`: `UnitArc`'s `bend_toward`, `bend_away`, `flankQ_upper_shadow`, `flankQ_lower_shadow`, `nb4p`, and `BaseSteps`' `n3_end`, saving after each; no edit to `Contact`
  launch: now, beside FS131-IM3 (wave 4's moves, on `fs131-w4m`), FS131-I5c (wave 5, on `fs131-w5`) and FS131-KP (the planar planner, on `fs131-w5p`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I4m.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I4-implementation.md` (on branch `fs131-w4`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4` (branch `fs131-w4`): the skeleton modules except `Contact` (`Proofs/HadwigerNelson/Plane/StuckChain.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BaseSteps.lean`, `Proofs/HadwigerNelson/Plane/SVMap.lean`), the foundation `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` (the engines, sorry-free), supporting lemmas in the foundation modules § 14.2 names (statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 4's carriers only, at the gate), `plans/FS131-I4-implementation.md`, `tools/fs131_i4_*.py`, `data/fs131/i4/`, a new wave-4 module for `localSectors` if item 126 makes it yours (`Proofs/HadwigerNelson/Plane/ValidMap/Sectors.lean`, say), `data/fs131/reports/FS131-I4m.md`; `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` only by merging the parallel implementer's branch, or under item 194's fallback; `Proofs/HadwigerNelson/Plane/LocalStructure.lean` for `localSectors_disj` only (item 244 (b))
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k



Hello. You are wave 4's thirteenth implementer, on Opus. Wave 4 is the valid-map machinery the frontier's local exclusion rests on. Its branch, `fs131-w4`,
now holds everything but the three simplifying moves (FS131-IM3 proves them on `fs131-w4m`, which merges in at the end): FS131-I4l merged the finished
`Contact` lane in, proved `pair_i`, built engine 5 and proved FLANK-Q over one child each. Six leaves are left in your files.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Wave 4 lands when its
moves and these six are done, and Woodall's chain and wave 5 land after it.

## The statements

The `sorry` declarations in `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean` and `Proofs/HadwigerNelson/Plane/ValidMap/BaseSteps.lean` on branch
`fs131-w4` at `68ca5f0f`, read back in `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` §§ 3.2, 7.2, 8.2, 12.2, planned in § 13, handoff § 14.
What I4l handed back, and the rulings on it:

> 280. **FS131-I4l handed back** (Stage 37 SAVED, harness 511k by the task notice; report `fs131-w4`'s `data/fs131/reports/FS131-I4l.md`; commits `efd70aa6`,
> — source: plans/FS131-close-inventory.md

> 281. **Rulings on I4l's held items, and its slot.** (a) `flankQ_upper`'s `hcN` and `flankQ_lower`'s `hcS` renamed `_hcN`, `_hcS` (ruling 185's reasons: a binder
> — source: plans/FS131-close-inventory.md

The shadow clause's route is I4l's Stage 36, and where it stopped is its Stage 37:

> **What is left (6 in this job's files): UnitArc `bend_toward`, `bend_away`, `flankQ_upper_shadow`, `flankQ_lower_shadow`, `nb4p`; BaseSteps `n3_end`.**
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/plans/FS131-I4-implementation.md Stage 37 — SAVED (FS131-I4l): engine 5 (lower), and `flankQ_lower` proved over its (R2) shadow child; 9 `sorry` left on the branch (Contact 3, UnitArc 5, BaseSteps 1), and the handoff

What you may change:

> **It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md § 14.2 What the implementer may and may not change

`exists_merge`'s colour clause is its vertex instance only (items 268–269): `n3_end` reads `F'.coloursAt v ⊆ F.coloursAt v` and nothing else of it. Rulings
still in force on this branch: item 244 (`localSectors_disj` in wave 3's `Plane/LocalStructure`; keep it at every merge), item 177 (`lock`'s clause 3 in its
local form), items 185, 258 and 281 (a) (binder renames).

## Done means

1. **Your readback first**: check every quotation above against its source; read I4l's Stages 33–37 and the inventory items named; build the branch once as
   given (`68ca5f0f`) before editing anything. Commit and push.
2. **`n3_end`'s question first**: read NB3-END item 1 (`plans/FS112-NB3-verification.md` l. 221–243) against `n3_end`'s statement; if its proof needs FLANK-Q's
   (Q)/(R2) dichotomy and the statement does not carry `hQR`, stop that leaf and message me with the reading (a missing hypothesis is a statement defect).
3. **The leaves**, in the order you judge, saving after each; no statement changed, no new `axiom`, no `native_decide`; never edit `Contact` (IM3's branch
   changes it, and the final merge must meet disjoint hunks). Do not edit a file while a build of it runs.
4. **Your record** (continue it), stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. You do not merge
   `fs131-w4m`, run wave 4's gate, or touch `main`. Stopping at a saved stage with leaves left, and naming them, is a good report.

## What is yours to decide

The proofs, their children and order, and where a supporting lemma lives (statements unchanged). If a leaf cannot be proved as written, stop that leaf,
message me at once with the declaration, the reason, and the smallest counterexample or the missing hypothesis, and go on with the others: implementers on this
milestone have found several statements that needed a hypothesis the hand derivation hid, and each was a correction to the record. Three failed attempts on
one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them (inventory ruling 5), and
several trees are building today, so on exit 75 wait ten minutes and retry. `lake env lean` (with § 14.1's flags) is for iteration only, never evidence.
The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`. You start no agents of your own
(standing rule 1).
