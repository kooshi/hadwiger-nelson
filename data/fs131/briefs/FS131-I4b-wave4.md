# Brief FS131-I4b — wave 4 of the Lean backlog, continued: the 60 remaining `sorry` declarations on branch `fs131-w4`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I4b
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow
  role: wave 4's second implementer — prove the wave's remaining leaves from the planners' skeleton and plans and its predecessor's record, saving after each, and run the full gate when the last is proved
  launch: now, beside FS131-I2g, FS131-I3f and FS131-IW (implementers) and FS131-E2 (a deriver, no Lean), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I4b.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I4-implementation.md` (on branch `fs131-w4`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4` (branch `fs131-w4`): the five skeleton modules (`Proofs/HadwigerNelson/Plane/StuckChain.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BaseSteps.lean`, `Proofs/HadwigerNelson/Plane/SVMap.lean`), the foundation `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` (the engines, sorry-free), supporting lemmas in the foundation modules § 14.2 names (statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 4's carriers only, at the gate), `plans/FS131-I4-implementation.md`, `tools/fs131_i4_*.py`, `data/fs131/i4/`, a new wave-4 module for `localSectors` if item 126 makes it yours (`Proofs/HadwigerNelson/Plane/ValidMap/Sectors.lean`, say), `data/fs131/reports/FS131-I4b.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are wave 4's second implementer. Wave 4 is the valid-map machinery that the frontier's local exclusion rests on: contacts between tiles,
unit arcs on the circle about a vertex, the stuck chain, the Sokolov–Voronov map steps and the base steps of the bowtie. Three planners on Opus wrote it
(FS131-K4, -K4b, -K4c); the first implementer, FS131-I4 (de Bruijn on Sonnet, like you), proved 26 of its 86 leaves and wrote iteration tools that save time.

## Why this job

A wave counts as held only when its declarations pass the full gate and their axioms are read from the gate's saved log (the milestone's announcement
rule, `plans/FS131-close-inventory.md`). Kooshi's standing word: formalization is never a cost that ranks routes (`CLAUDE.md` § Counter-priors).

## The statements

The statements are the 60 `sorry` declarations on branch `fs131-w4` at `d011c17d`, read back in `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md`
§§ 3.2, 7.2, 8.2 and 12.2, with the plan per leaf in § 13 and the handoff in § 14. Where I4 left it:

> **Where it stands.** Proved (sorry-free): StuckChain 5/5; Contact 6 (`contact_inType_or_outType`, `coneAt_subset_allowedCone`, `lens_dist_lt_one_of_up`,
> — source: .claude/worktrees/fs131-w4/plans/FS131-I4-implementation.md ## Stage 3 — SAVED: 26 of 86 leaves, and the wave-3 snapshot for iteration

(the stage continues with "What is left", a route for each, and its tools: `.claude/worktrees/fs131-w4/data/fs131/i4/iter.sh`, `.claude/worktrees/fs131-w4/data/fs131/i4/chk.sh`, and `.claude/worktrees/fs131-w4/data/fs131/i4/w3snap.sh`, which compiles wave 3's
proved modules into a scratch mirror so wave 4 iterates against them without merging). What you may change:

> **It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md § 14.2 What the implementer may and may not change

Three things from I4's report bear on your leaves. **First, a gap in the plan**, ruled:

> 126. **Ruling — whose is `localSectors`**: it is stated as wave 3's plan specifies it (`.claude/worktrees/fs131-w3/plans/FS131-w3-kernel-plan.md` § 6, item 3), in
> — source: plans/FS131-close-inventory.md

(the ruling continues there). Wave 3's implementer, FS131-I3f, has been told; its report will say whether it stated `localSectors`. So: if wave 3 has
landed on `main` with `localSectors`, merge `main` and use it; if it landed without it, state it yourself in a new wave-4 module as wave 3's plan specifies
it, on I3e's `GoodAt` machinery; until wave 3 lands, work the leaves that do not need it (`BaseSteps`, most of `UnitArc`). **Second, two corrections to the
plan**: § 13.5's polar-region connectedness for the shadow leaves is unnecessary (one explicit ray point does it: `shadow_inside`, `shadow_outside`), and
`bowtie_mem_dom` is not E — it needs `0 ∈ interior (closure bowtieTiles)`. **Third, the cusp note for `noBoth`**:

> **Wave 4 note**: FS112-N3-NOBOTH (`noBoth`, "four colours or a repeated colour") likely has the same cusp case — for wave 4's implementer brief.
> — source: plans/FS131-close-inventory.md

If `noBoth`'s proof reaches the cusp case, stop that leaf and message me with the stuck goal; a deriver (FS131-E2) is working the case now.

## Done means

1. **Your readback first**: check the four quotations against their sources; restate in your record what you may and may not change; build the worktree
   once as given (`d011c17d`) before editing anything. Commit and push.
2. **The leaves proved**, in the order you judge unblocks most (§ 14.1's order and I4's "What is left" are recommendations), saving after each; no statement
   changed, no new `axiom`, no `native_decide`. `lebesgue_covering_square` is not yours (FS131-LEB's).
3. **When the last leaf is proved**, the gate as § 14.4 gives it, with wave 4's carriers registered under FS131-T1's procedure. The landing waits for wave 3
   and FS131-LEB.
4. **Your record** (you continue I4's), in stages headed "Stage n — SAVED", with "Theorems this phase proved": one line per row theorem — its declaration,
   its axioms (from a saved audit log when the gate runs, else from a `#print axioms` print, saying which), the row it was read against.
5. The report, in standing rule 11's form. Stopping at a saved stage with leaves left, and naming them, is a good report.

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
