# Brief FS131-I4 — wave 4 of the Lean backlog: replace the 86 `sorry` declarations on branch `fs131-w4`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I4
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow
  role: wave 4's first implementer — prove the wave's leaves from the planners' skeleton and per-leaf plans, in the plan's order, saving after each, and run the full gate when the last is proved
  launch: now, beside FS131-I3e (wave 3's implementer), FS131-K2d and FS131-W2 (planners) and EXT-HN1 (an outside audit), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I4.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I4-implementation.md` (on branch `fs131-w4`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4` (branch `fs131-w4`): the five skeleton modules (`Proofs/HadwigerNelson/Plane/StuckChain.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BaseSteps.lean`, `Proofs/HadwigerNelson/Plane/SVMap.lean`), the foundation `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` (the engines, sorry-free), supporting lemmas in the foundation modules § 14.2 names (statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 4's carriers only, at the gate), `plans/FS131-I4-implementation.md`, `tools/fs131_i4_*.py`, `data/fs131/i4/`, `data/fs131/reports/FS131-I4.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are the first implementer on wave 4 of the milestone that turns this project's hand-derived results into kernel-checked ones. Wave 4 is the
valid-map machinery that the frontier's local exclusion rests on: contacts between tiles, unit arcs on the circle about a vertex, the stuck chain, the
Sokolov–Voronov map steps and the base steps of the bowtie. Three planners on Opus wrote it (FS131-K4, -K4b, -K4c): a sorry-free foundation, five skeleton
modules with 86 `sorry` declarations, read-backs, seven shared engines, a plan per leaf and the handoff you work from. Wave 1 is landed on `main`; wave 3,
whose vocabulary wave 4 uses, is nine leaves from landing on its own branch.

## Why this job

A wave counts as held only when its declarations pass the full gate and their axioms are read from the gate's saved log (the milestone's announcement
rule, `plans/FS131-close-inventory.md`). Your proofs are what turn wave 4's 25 rows from derived into held. Kooshi's standing word: formalization is never a
cost that ranks routes (`CLAUDE.md` § Counter-priors).

## The statements

The statements are the 86 `sorry` declarations on branch `fs131-w4` at `f620977c`, read back in `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md`
§§ 3.2, 7.2, 8.2 and 12.2, with the plan per leaf in § 13 and the handoff in § 14. Read § 14 in full first. What you may change:

> **It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md § 14.2 What the implementer may and may not change

and what you may not:

> **It may not**: change any statement of §§ 3.2, 7.2, 8.2, 12.2 (the row theorems, their hypotheses and conclusions), any definition of
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md § 14.2 What the implementer may and may not change

(both sentences continue there). One ruling from wave 3 bears on a wave-4 leaf, logged before your launch:

> **Wave 4 note**: FS112-N3-NOBOTH (`noBoth`, "four colours or a repeated colour") likely has the same cusp case — for wave 4's implementer brief.
> — source: plans/FS131-close-inventory.md

That is: wave 3's implementer found that a tile may meet a point in a cusp (a cone of one direction, between two tangent arcs), which breaks the route of
its four-colour clause; the ruling added "no cusp at `z`" there (item 112). If `noBoth`'s proof reaches the same case, stop that leaf and message me with
the stuck goal; do not add the hypothesis yourself.

## Done means

1. **Your readback first**: check the three quotations against their sources; restate in your record what you may and may not change; build the worktree
   once as given (`f620977c`). Commit and push.
2. **The leaves proved in § 14.1's order** — the engines first, then `StuckChain` as the warm-up that re-prices the wave, then the modules in turn — no
   statement changed, no new `axiom`, no `native_decide`. Save after each leaf; re-price from your first two hard leaves and say so in the record.
   `lebesgue_covering_square` is not yours (FS131-LEB's).
3. **When the last leaf is proved**, the gate as § 14.4 gives it, on one commit in the worktree, with wave 4's carriers registered under FS131-T1's
   procedure (§ 14.3 is the planner's recommendation). The landing itself waits for wave 3 and for FS131-LEB; merge `fs131-w3` only when wave 3 has landed
   on `main`, since its branch is still moving.
4. **Your record**, in stages headed "Stage n — SAVED", with "Theorems this phase proved": one line per row theorem — its declaration, its axioms (from a
   saved audit log when the gate runs, else from a `#print axioms` print, saying which), the row it was read against.
5. The report, in standing rule 11's form. Stopping at a saved stage with leaves left, and naming them, is a good report: 86 leaves will outrun one
   context, and a successor continues from your record.

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
