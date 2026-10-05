# Brief FS131-I4e — wave 4 of the Lean backlog, continued: the 50 remaining `sorry` declarations on branch `fs131-w4`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I4e
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 4's fifth implementer — `lock` (one argument, three clauses), the bowtie near `E` by the cusp pattern, then the rest in § 14.1's order, saving after each; the gate and the landing when the last leaf is proved
  launch: now, beside FS131-I2i (wave 2) and FS131-IWc (Woodall's chain), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I4e.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I4-implementation.md` (on branch `fs131-w4`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4` (branch `fs131-w4`): the five skeleton modules (`Proofs/HadwigerNelson/Plane/StuckChain.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BaseSteps.lean`, `Proofs/HadwigerNelson/Plane/SVMap.lean`), the foundation `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` (the engines, sorry-free), supporting lemmas in the foundation modules § 14.2 names (statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 4's carriers only, at the gate), `plans/FS131-I4-implementation.md`, `tools/fs131_i4_*.py`, `data/fs131/i4/`, a new wave-4 module for `localSectors` if item 126 makes it yours (`Proofs/HadwigerNelson/Plane/ValidMap/Sectors.lean`, say), `data/fs131/reports/FS131-I4e.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are wave 4's fifth implementer, on Opus. Wave 4 is the valid-map machinery the frontier's local exclusion rests on. 36 of its 86 leaves are
proved; the last implementer, FS131-I4d, wrote the bridge from the landed sector structure to wave 4's sector vocabulary (`Plane/ValidMap/Sectors`), closed
TS-T's vertex step (so `Plane/SVMap` is sorry-free), added the impossible-assumption audit's inhabitants — among them the library's first proved horn — and
worked out `lock`'s route. 50 leaves are left: Contact 10, UnitArc 20 (`lock` among them), BaseSteps 20.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Woodall's chain lands
after wave 4.

## The statements

The 50 `sorry` declarations on branch `fs131-w4` at `c1255fc5`, read back in `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` §§ 3.2, 7.2, 8.2,
12.2, planned in § 13, handoff § 14. What you may change:

> **It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md § 14.2 What the implementer may and may not change

Where I4d left it:

> **The merge** (`05968b36`): `origin/main` at `cff2c33e` (`localSectors` landed, item 171) into `fs131-w4`. One conflict, at the append point of
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/plans/FS131-I4-implementation.md ## Stage 8 — SAVED (FS131-I4d): `main` merged, the bridge to `localSectors`, `exists_hasDegree_of_mem_dom`, QA2's items 2–5, `lock` ruled; 50 `sorry` left

(its stage gives `lock`'s argument — one argument for all three clauses — and "What is left", with the bowtie's route: near `E = 0` the bowtie's only arcs are
its two unit arcs, since both ends of each of its 28 segments lie on one side of `|re| = 1/13` or `|im| = 1/13`, so `bowtie_isHorn`, `bowtie_flanks` and
`bowtie_coloursAt_zero` can follow `cuspFrag_isHorn`'s pattern). `lock`'s clause 3 is the restated local form:

> 177. **FS131-I4d mid-job, on `ArcMap.lock`** (FS112-LOCK; `fs131-w4`, `Plane/ValidMap/UnitArc.lean`): (1) **clause 1 closes with no N-E2** — `IsRingArc`'s
> — source: plans/FS131-close-inventory.md

(the item continues there; if one of the three bends needs more than the local form, stop that leaf and message me). **Before the gate**: the four older
linter warnings in `UnitArc` (unused `hF` near lines 234 and 236; `push_cast` doing nothing near 664 and 666) cleared, since the gate counts warnings;
`AeProperRegions` registered as a vacuity carrier (item 144); TS-T's Condition-5 clause kept in its carried form (item 142). Name collisions with Woodall's
branch (`abs_dot_le`, `dot_add_left`, `dot_e_e`, `isOpen_shadow`, identical) are resolved by whichever branch lands second.

## Done means

1. **Your readback first**: check the three quotations against their sources; build the branch once as given (`c1255fc5`) before editing anything; restate in your
   record what you may and may not change. Commit and push.
2. **`lock`**, then **the bowtie near `E`**, then the rest in § 14.1's order, saving after each; no statement changed, no new `axiom`, no `native_decide`;
   re-price from your first two hard leaves. A merge commit is the one commit made without paths; say so in its message.
3. **When the last leaf is proved**, the gate as § 14.4 gives it (warnings counted — `scripts/build.sh` exits 0 with warnings), then the landing: merge `main`,
   resolve collisions, re-run the gate, fast-forward `main` (`git push origin HEAD:main` from the worktree), never force-push.
4. **Your record** (continue it), stages headed "Stage n — SAVED", "Theorems this phase proved"; drafts for the front page at the gate; the report in standing
   rule 11's form. Stopping at a saved stage with leaves left, and naming them, is a good report.

## What is yours to decide

The proofs, their children and order within § 14.1's, where a supporting lemma lives, and each carrier's in-or-out call at the gate. If a leaf cannot be
proved as written, stop that leaf, message me at once with the declaration, the reason, and the smallest counterexample or the missing hypothesis, and go
on with the others: implementers on this milestone have already found several statements that needed a hypothesis the hand derivation hid, and each was a correction to the record. Three failed attempts
on one route is a dispatch to the companion your identity names, never a fourth.

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them (inventory ruling 5), and
several trees are building today, so on exit 75 wait ten minutes and retry. `lake env lean` (with § 14.1's flags) is for iteration only, never evidence.
The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`. You start no agents of your own
(standing rule 1).
