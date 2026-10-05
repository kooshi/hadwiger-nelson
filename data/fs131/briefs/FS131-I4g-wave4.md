# Brief FS131-I4g — wave 4 of the Lean backlog, continued: the 29 remaining `sorry` declarations in `UnitArc` and `BaseSteps` on branch `fs131-w4`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I4g
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 4's seventh implementer — the bowtie's moves, then `UnitArc` and `BaseSteps`' remaining leaves (not `Contact`, reserved for a parallel implementer), saving after each; the gate and the landing when the last leaf is proved
  launch: now, beside FS131-I2k (wave 2) and FS131-K5 (wave 5's planner), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I4g.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I4-implementation.md` (on branch `fs131-w4`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4` (branch `fs131-w4`): the skeleton modules except `Contact` (`Proofs/HadwigerNelson/Plane/StuckChain.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BaseSteps.lean`, `Proofs/HadwigerNelson/Plane/SVMap.lean`), the foundation `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` (the engines, sorry-free), supporting lemmas in the foundation modules § 14.2 names (statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 4's carriers only, at the gate), `plans/FS131-I4-implementation.md`, `tools/fs131_i4_*.py`, `data/fs131/i4/`, a new wave-4 module for `localSectors` if item 126 makes it yours (`Proofs/HadwigerNelson/Plane/ValidMap/Sectors.lean`, say), `data/fs131/reports/FS131-I4g.md`; `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` only by merging the parallel implementer's branch, or under item 194's fallback
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are wave 4's seventh implementer, on Opus. Wave 4 is the valid-map machinery the frontier's local exclusion rests on. 47 of its 86 leaves are
proved. The last implementer, FS131-I4f, proved the bowtie fragment's colouring (`bowtieCol_locallyConstant`, so the structure `bowtie` is sorry-free), its
validity, its double shadow, its contact type, its unit arcs' ends and its neighbours, and a general sector lemma for tiles (`coloursAt_hasSectors_of_tiles`).
39 leaves are left: BaseSteps 10, UnitArc 19, Contact 10. **Wave 4 now splits by file** (the ruling is quoted below): yours are `BaseSteps` and `UnitArc`,
29 leaves; `Contact` goes to a parallel implementer in its own worktree when a slot frees, so leave `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` alone.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Woodall's chain lands
after wave 4, so wave 4's landing unblocks it.

## The statements

The 29 `sorry` declarations in `Proofs/HadwigerNelson/Plane/ValidMap/BaseSteps.lean` (10) and `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean` (19) on
branch `fs131-w4` at `8a184ec1`, read back in `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` §§ 3.2, 7.2, 8.2, 12.2, planned in § 13, handoff
§ 14. What you may change:

> **It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md § 14.2 What the implementer may and may not change

Where I4f left it:

> **What is left (39), in the order I would take it.**
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/plans/FS131-I4-implementation.md ## Stage 14 — SAVED (FS131-I4f): `bowtie_unitArcEnds`, `bowtie_neighbours`; 39 `sorry` left, and the handoff

(the list follows there: the bowtie's moves, then UnitArc, Contact and the base's steps). Its first entry begins:

> - *The bowtie's moves* (BaseSteps, 3): `bowtie_isStuck`, `bowtie_terminalOn`, `flank_incomplete_bowtie`. The easy halves: `¬ IsStuck (±i)` and `¬ MergeAvailable (±i)`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/plans/FS131-I4-implementation.md ## Stage 14 — SAVED (FS131-I4f): `bowtie_unitArcEnds`, `bowtie_neighbours`; 39 `sorry` left, and the handoff

One correction to Stage 11's handoff, from I4f: `n2_env_near` is not "one identity" — it needs a lens estimate with `s ≤ ψ·Δ(φ)` near the ends (Stage 14).
The split:

> 194. **Ruling: wave 4 splits by file** (item 191's condition met: six leaves a session on wave 4's last two sessions, 39 left). Choice: the next wave-4 implementer
> — source: plans/FS131-close-inventory.md

`lock`'s clause 3 stays in its ruled local form:

> 177. **FS131-I4d mid-job, on `ArcMap.lock`** (FS112-LOCK; `fs131-w4`, `Plane/ValidMap/UnitArc.lean`): (1) **clause 1 closes with no N-E2** — `IsRingArc`'s
> — source: plans/FS131-close-inventory.md

and the binder rename in `l60_eq_third` stands:

> 185. **Ruling: `l60_eq_third`'s binder `hF` → `_hF` accepted** (I4e's held question). Choice: accept. Alternative weighed: restore `hF` and silence the linter
> — source: plans/FS131-close-inventory.md

**Before the gate** (whichever of the two wave-4 implementers finishes second runs it, after merging the other's branch): `AeProperRegions` registered as a
vacuity carrier (item 144); TS-T's Condition-5 clause kept in its carried form (item 142). Name collisions with Woodall's branch (`abs_dot_le`,
`dot_add_left`, `dot_e_e`, `isOpen_shadow`, identical) are resolved by whichever branch lands second; run `tools/fs131_qa1_dupes.py` after merging `main`.

## Done means

1. **Your readback first**: check the six quotations against their sources; build the branch once as given (`8a184ec1`) before editing anything; restate in
   your record what you may and may not change. Commit and push.
2. **The bowtie's moves**, then `UnitArc` and `BaseSteps`' other leaves in Stage 14's order (yours to change), saving after each; no statement
   changed, no new `axiom`, no `native_decide`; re-price from your first two hard leaves. Do not edit a file while a build of it runs (I4e's slip, Stage 10).
   A merge commit is the one commit made without paths; say so in its message.
3. **When your 29 are proved** and the `Contact` branch is merged (or, if no parallel implementer has started, when `Contact`'s 10 are proved too), the gate as § 14.4 gives it (warnings counted — `scripts/build.sh` exits 0 with warnings), then the landing: merge `main`,
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
