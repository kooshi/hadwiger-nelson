# Brief FS131-I4h — wave 4 of the Lean backlog, continued: the 24 remaining `sorry` declarations in `UnitArc` and `BaseSteps` on branch `fs131-w4`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IC1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 4's parallel implementer for `Contact` — its 10 leaves (the contact types, Woodall's cone, the three moves, the stuck structure), in a worktree of its own; then hand the branch over for merging into `fs131-w4`, saving after each; the gate and the landing when the last leaf is proved
  launch: now, beside FS131-I2l (wave 2) and FS131-I4h (wave 4's `BaseSteps` and `UnitArc`, on `fs131-w4`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IC1.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IC-implementation.md` (new, on branch `fs131-w4c`; yours alone — `plans/FS131-I4-implementation.md` is FS131-I4h's)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4c` (branch `fs131-w4c`): `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean`, supporting lemmas in a new module of your own if you need one (say `Proofs/HadwigerNelson/Plane/ValidMap/ContactAux.lean`, imported by `Contact`) and in the foundation `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` (statements unchanged; additions only), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (your own block, headed "FS131-IC1"), `plans/FS131-IC-implementation.md`, `tools/fs131_ic_*.py`, `data/fs131/ic/`, `data/fs131/reports/FS131-IC1.md`; not `UnitArc`, `BaseSteps`, `SVMap` or `StuckChain`, which FS131-I4h edits on `fs131-w4`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are wave 4's parallel implementer, on Opus, for one file: `Plane/ValidMap/Contact`. Wave 4 is the valid-map machinery the frontier's local
exclusion rests on; 52 of its 86 leaves are proved. Since its implementers were closing about five leaves a session, I split the wave by file: FS131-I4h works
`BaseSteps` and `UnitArc` on branch `fs131-w4`, and you work `Contact`'s 10 leaves on branch `fs131-w4c`, branched from `fs131-w4` at `68f34f18`. Nobody has
touched `Contact` since the skeleton, so its plan per leaf is the planners' (wave 4's plan § 13), with the engines and children wave 4's implementers have since
added in `Basic`, `Sectors`, `UnitArc` and `BaseSteps` there to use.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Wave 4 now gates
Woodall's landing and wave 5's: your branch is half of what is left of it.

## The statements

The 10 `sorry` declarations in `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` on branch `fs131-w4c` at `68f34f18`, read back in
`.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` §§ 3.2 and 7.2, planned in § 13, handoff § 14 (that plan is on `fs131-w4`; your tree holds the same
file at `68f34f18`). What you may change:

> **It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md § 14.2 What the implementer may and may not change

The 10, as the last implementer to list them by name wrote:

> **What is left (50) and the order I would take it.** Contact 10: `clear_of_subset_interior_allowedCone`, `woodallCone`, `woodallCone_strict` (now has
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/plans/FS131-I4-implementation.md ## Stage 8 — SAVED (FS131-I4d): `main` merged, the bridge to `localSectors`, `exists_hasDegree_of_mem_dom`, QA2's items 2–5, `lock` ruled; 50 `sorry` left

(the line continues with UnitArc's and BaseSteps' leaves, which are not yours). The split:

> 194. **Ruling: wave 4 splits by file** (item 191's condition met: six leaves a session on wave 4's last two sessions, 39 left). Choice: the next wave-4 implementer
> — source: plans/FS131-close-inventory.md

and where you were placed:

>      Confidence: high. (b) The carriers' in/out recommendation goes to wave 5's implementer at its gate, under T1's procedure (no ruling now). (c) **K5b's slot
> — source: plans/FS131-close-inventory.md

(the line continues there: your worktree, your record, and the merge into `fs131-w4` before wave 4's gate). Two engines the others built that you may want: the
ray engine `eventually_ray_not_mem_hornSet` / `IsSector.disjoint_of_rays` (`BaseSteps`) and `ArcMap.Valid.dist_ne_one_of_isOpen_subset_closure` (`UnitArc`) —
both on your branch. A note for the moves: wave 4's plan § 14.5 records their form (G-MOVES-UA: `exists_shave`, `exists_rayMerge`, `exists_merge` conclude
`F'.RingArcsWithin F` and `F'.AgreesOff F (closedBall v ρ)`), and wave 5 will need **strengthened** forms (every point of four or more colours after a move had
them before) as new lemmas beside yours — a child you may add if it comes cheaply, never a change to the statements. `stuck_structure` assumes Condition 5
(FS110-NB-4's conclusion, a named hypothesis, wave 4's plan § 14.5): keep it so.

## Done means

1. **Your readback first**: check the four quotations against their sources; build the branch once as given (`68f34f18`) before editing anything; open your
   record with what you may and may not change. Commit and push (`git push -u origin fs131-w4c`).
2. **`Contact`'s 10 leaves**, in the order you judge unblocks most (`woodallCone` first is the planners' order: `exists_merge` and FS131-I4h's `n3_end` both
   read it), saving after each; no statement changed, no new `axiom`, no `native_decide`; re-price from your first two hard leaves. Do not edit a file while a
   build of it runs.
3. **The handover**: when the 10 are proved (or at your hand-back line), your record's last stage says what is proved and what is left, with the build log and
   an axioms print against that build's oleans. You do not merge into `fs131-w4` or run wave 4's gate: whichever of you and FS131-I4h finishes second does
   that, on my word, so the two branches never race. Never push to `main`.
4. **Your record**, stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage with leaves
   left, and naming them, is a good report.

## What is yours to decide

The proofs, their children and order, and where a supporting lemma lives (the carriers and the gate are the merging implementer's). If a leaf cannot be
proved as written, stop that leaf, message me at once with the declaration, the reason, and the smallest counterexample or the missing hypothesis, and go
on with the others: implementers on this milestone have already found several statements that needed a hypothesis the hand derivation hid, and each was a correction to the record. Three failed attempts
on one route is a dispatch to the companion your identity names, never a fourth.

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them (inventory ruling 5), and
several trees are building today, so on exit 75 wait ten minutes and retry. `lake env lean` (with § 14.1's flags) is for iteration only, never evidence.
The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`. You start no agents of your own
(standing rule 1).
