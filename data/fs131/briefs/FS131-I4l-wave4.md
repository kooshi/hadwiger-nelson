# Brief FS131-I4l — wave 4 of the Lean backlog, continued: the merge of the `Contact` lane and the 7 remaining `sorry` declarations in `UnitArc` and `BaseSteps` on branch `fs131-w4`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I4l
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 4's twelfth implementer — merge branch `fs131-w4c` into `fs131-w4` first (inventory item 267), then `n3_end`, `UnitArc`'s five leaves and `pair_i`, saving after each; no edit to `Contact`
  launch: now, beside FS131-I2n (wave 2, on `fs131-w2`), FS131-IM2 (wave 4's moves, on `fs131-w4m`) and FS131-QA3 (a read-only definitions audit), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I4l.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I4-implementation.md` (on branch `fs131-w4`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4` (branch `fs131-w4`): the skeleton modules except `Contact` (`Proofs/HadwigerNelson/Plane/StuckChain.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BaseSteps.lean`, `Proofs/HadwigerNelson/Plane/SVMap.lean`), the foundation `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` (the engines, sorry-free), supporting lemmas in the foundation modules § 14.2 names (statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 4's carriers only, at the gate), `plans/FS131-I4-implementation.md`, `tools/fs131_i4_*.py`, `data/fs131/i4/`, a new wave-4 module for `localSectors` if item 126 makes it yours (`Proofs/HadwigerNelson/Plane/ValidMap/Sectors.lean`, say), `data/fs131/reports/FS131-I4l.md`; `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` only by merging the parallel implementer's branch, or under item 194's fallback; `Proofs/HadwigerNelson/Plane/LocalStructure.lean` for `localSectors_disj` only (item 244 (b))
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k


Hello. You are wave 4's twelfth implementer, on Opus. Wave 4 is the valid-map machinery the frontier's local exclusion rests on, and it is split across three
branches. The `Contact` lane (`fs131-w4c`) has just finished: FS131-IC5 proved `stuck_structure` and `stuck_chain`, so `Contact`'s only `sorry` are the three
simplifying moves, which FS131-IM2 is proving on `fs131-w4m`. Your branch, `fs131-w4`, holds `UnitArc` and `BaseSteps`, where FS131-I4k left seven leaves.
Your first job is to bring the `Contact` lane's work onto your branch, which also unblocks `n3_end`.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Woodall's chain and
wave 5 land after wave 4. Wave 4's landing waits on the moves, so your leaves and this merge make sure nothing else is left when they arrive.

## The statements

The `sorry` declarations in `Proofs/HadwigerNelson/Plane/ValidMap/BaseSteps.lean` and `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean` on branch
`fs131-w4` at `d391f480`, read back in `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` §§ 3.2, 7.2, 8.2, 12.2, planned in § 13, handoff § 14.
Where I4k left them:

> **What is left (7 in this job's files: UnitArc `bend_toward`, `bend_away`, `flankQ_upper`, `flankQ_lower`, `nb4p`; BaseSteps `pair_i`, `n3_end`).**
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/plans/FS131-I4-implementation.md Stage 32 — SAVED (FS131-I4k): `pair_i` gains `h3 : dist u₁ u₂ < 3` (ruling 258); 7 `sorry` left in `BaseSteps` and `UnitArc`, and the handoff

(the routes follow there). What you may change:

> **It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md § 14.2 What the implementer may and may not change

The merge, ruled:

> 267. **Ruling: `fs131-w4c` merges into `fs131-w4` now, as the I4 lane's successor's first stage; the moves branch merges into `fs131-w4` later.** Choice: FS131-I4l
> — source: plans/FS131-close-inventory.md

`pair_i`'s statement now carries one more hypothesis:

> 258. **Ruling on item 257: `pair_i` gains `(h3 : dist u₁ u₂ < 3)`.** Choice: add the hypothesis `dist u₁ u₂ < 3`, which excludes exactly I4k's isolated configuration
> — source: plans/FS131-close-inventory.md

(read items 257–258 and 264 in full there; 264 records that the repair's inference holds on paper, with the critical-point argument you will need).
What the `Contact` lane hands you:

> 266. **FS131-IC5 handed back, done** (harness ≈ 510k; report `fs131-w4c`'s `data/fs131/reports/FS131-IC5.md`; commits `9988cbb8`, `f3a5c724`, `f975677b`).
> — source: plans/FS131-close-inventory.md

Earlier rulings that still stand on this branch: item 244 (`localSectors_disj` in wave 3's `Plane/LocalStructure`; keep it at every merge), item 177
(`lock`'s clause 3 in its local form), item 185 and item 258's last sentence (binder renames). **Before the gate** (run by whoever merges the moves branch, on
my word): `AeProperRegions` registered as a vacuity carrier (item 144), TS-T's Condition-5 clause in its carried form (item 142), `stuck_structure`'s note
(items 252, 266), the axiom self-test re-run (item 260); collisions with Woodall's branch are resolved by whichever lands second.

## Done means

1. **Your readback first**: check every quotation above against its source; read I4k's Stage 32 and the inventory items named; build the branch once as given
   (`d391f480`) before editing anything. Commit and push.
2. **The merge** (item 267): `git merge fs131-w4c` in the worktree; resolve `scripts/Axioms.lean` and `ARCHITECTURE.md` by keeping both sides' additions; stop and
   message me if any other file conflicts. Then `tools/fs131_qa1_dupes.py` (no duplicate declaration names), `tools/fs131_i4_stmts.py` against `d391f480` and
   against `f975677b` (no statement changed on either side), and a green build with only `sorry` warnings (expect `Contact` 3, `UnitArc` 5, `BaseSteps` 2). A merge
   commit is the one commit made without paths; say so in its message. Push. This stage alone is a good hand-back.
3. **The leaves**: `n3_end`, `UnitArc`'s five, `pair_i`, in the order you judge, saving after each; no statement changed, no new `axiom`, no `native_decide`;
   never edit `Contact` (IM2's branch deletes its first 2,593 lines, and any edit there would conflict). Do not edit a file while a build of it runs.
4. **Your record** (continue it), stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. You do not merge
   `fs131-w4m`, run wave 4's gate, or touch `main`. Stopping at a saved stage with leaves left, and naming them, is a good report.

## What is yours to decide

The proofs, their children and order, and where a supporting lemma lives (statements unchanged). If a leaf cannot be proved as written, stop that leaf,
message me at once with the declaration, the reason, and the smallest counterexample or the missing hypothesis, and go on with the others: implementers on this
milestone have found several statements that needed a hypothesis the hand derivation hid, `pair_i` among them, and each was a correction to the record. Three
failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation
is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them (inventory ruling 5), and
several trees are building today, so on exit 75 wait ten minutes and retry. `lake env lean` (with § 14.1's flags) is for iteration only, never evidence.
The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`. You start no agents of your own
(standing rule 1).
