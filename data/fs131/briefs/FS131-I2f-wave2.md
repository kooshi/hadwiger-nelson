# Brief FS131-I2f — wave 2 of the Lean backlog, continued: every remaining leaf on branch `fs131-w2` (the Opus-implementer trial)

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I2f
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; for this job you run on Opus rather than Sonnet, a trial Kooshi authorized (inventory item 103)
  role: the sixth implementer on wave 2 — prove the wave's remaining leaves and children (K2c's and K2d's plans), saving after each, run the full gate when the last is proved, and land wave 2 on `main`
  launch: now, beside FS131-I3f and FS131-I4 (implementers), FS131-W2 (a planner) and EXT-HN1 (an outside audit), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I2f.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I2-implementation.md` (on branch `fs131-w2`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w2` (branch `fs131-w2`): the wave-2 modules (`Proofs/HadwigerNelson/Plane/MaximalCover.lean`, `Slack.lean`, `Stationary.lean`, `FalconerReduction.lean`, `YesLimit.lean`, `CoverExamples.lean`, and `Proofs/HadwigerNelson/Arith/PlaceHom.lean`, `FalconerField.lean`, `Dyadic.lean`, and `Proofs/HadwigerNelson/Instances/FalconerOrbit.lean`), supporting lemmas in the wave's foundation (`Proofs/HadwigerNelson/Plane/Cover.lean`, `Suprema.lean`, `CPColouring.lean`) and in the shared foundation under `Proofs/HadwigerNelson/Plane/`, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 2's carriers only — § The vacuity step), `plans/FS131-I2-implementation.md`, `tools/fs131_i2_*.py`, `data/fs131/i2/`, `data/fs131/reports/FS131-I2f.md`; and, at the landing only, `main` by fast-forward
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are the sixth implementer on wave 2, and the first on this milestone to run on Opus: Kooshi authorized one trial of an Opus implementer,
and wave 2 has the most Sonnet history on comparable hard leaves to compare it with (five sessions, FS131-I2 to -I2e). Nothing about the job changes
for that: count what you close, as every implementer does, and stop at a saved stage when your context says so.

Wave 2 is the measurable-colouring rows — covers and maximal covers, the slack suprema, stationary colourings, the worked examples R7, DISC7, HC and
IRREG — and the arithmetic rows on place homomorphisms, Falconer fields and the dyadic lemma. Two planners on Opus have broken every remaining leaf into
stated children: FS131-K2c (the analysis in `Plane/Slack`, `Plane/Cover`, `Plane/FalconerReduction`, `Plane/YesLimit`, `Arith/Dyadic`; its handoff is
the plan's § 13) and FS131-K2d (`Plane/CoverExamples`, `Arith/PlaceHom`, `Arith/FalconerField`, with the orbit facts proved outright in
`Instances/FalconerOrbit`; its handoff is § 18). FS131-I2e proved four of K2c's leaves and 31 children. K2d's branch is already merged into
`fs131-w2` (`ddc5b5c8`, by the coordinator; the merge touched no Lean file beyond K2d's), so you start from one tree.

## Why this job

A wave counts as held only when all of it passes the gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`); wave 2's 28 rows are
derived until its last leaf is proved. Kooshi's standing word: formalization is never a cost that ranks routes (`CLAUDE.md` § Counter-priors).

## The statements

The statements are every `sorry` on branch `fs131-w2` at `ddc5b5c8` (154 lines that are exactly `sorry`: `Plane/Slack` 46, `Plane/CoverExamples` 62,
`Arith/PlaceHom` 14, `Arith/Dyadic` 12, `Plane/FalconerReduction` 9, `Arith/FalconerField` 5, `Plane/YesLimit` 4, `Plane/Cover` 2), read back against
their rows in `.claude/worktrees/fs131-w2/plans/FS131-w2-kernel-plan.md` §§ 4.1 and 7.3, each child's statement fixed by K2c (§ 12) or K2d (§§ 15–17).
What you may change:

> - **May**: prove any child or leaf; add further children (state each as a lemma before using it, and add its `scripts/Axioms.lean` record);
> — source: .claude/worktrees/fs131-w2/plans/FS131-w2-kernel-plan.md § Stage 13 — SAVED: the handoff for the fifth implementer (stage 10's form, brought to this stage)

(the section continues with what you may not change, the order for K2c's leaves, and the amended landing; § 18 restates the same rules for K2d's.)
What K2d's handoff says is left in its three files:

> - **What is left**: 77 `sorry`ed children (lane A 19: § 15.2's tables; CoverExamples 58: §§ 16–17's tables) and 4 leaves whose assemblies
> — source: .claude/worktrees/fs131-w2/plans/FS131-w2-kernel-plan.md § Stage 18 — SAVED: the handoff for the next implementer, for these 18 leaves (stage 13's form)

One open point to know before you reach it: `exists_not_uniform_kept`'s fringe colouring (§ 17.1) does not yet handle unit pairs between two fringe
points; K2d's note is that fringes of nearby grid edges need disjoint colour sets (`k = 9 + 3N`) and that the properness child is where that is
proved. If no formula proper at every unit pair comes out, message me: that is a deriver's question (FS106-TQ's control C2 written out), not yours.

## Done means

1. **Your readback first**: check both quotations against their sources; build the branch once as given (`ddc5b5c8`; K2d's modules rebuild); restate in
   your record what you may and may not change. Commit and push.
2. **Leaves and children proved**, in the order you judge unblocks most (§ 13's and § 18's orders are recommendations), saving after each; no statement
   changed, no new `axiom`, no `native_decide`. Re-price from your first two hard children and say so in the record.
3. **When the last is proved**, the full gate as § 13 gives it, on one commit in the worktree (the build with zero warnings; `scripts/axioms.sh` clean
   with `falconer_lemma2_nonempty` the one declared import; `scripts/vacuity.sh` and `--self-test` green with wave 2's carriers registered under FS131-T1's
   procedure; `tools/check_architecture.py` exit 0; each check's negative control watched going red), then the landing: merge `main`, re-run the gate,
   fast-forward `main`, push — never force-push.
4. **Your record**, `plans/FS131-I2-implementation.md` (you continue it), in stages headed "Stage n — SAVED", with "Theorems this phase proved": one line
   per row theorem — its declaration, its axioms (from a saved audit log when the gate runs, else from a `#print axioms` print, saying which), the row it
   was read against — and a count of the leaves and children you closed, for the trial.
5. The report, in standing rule 11's form. Stopping at a saved stage with leaves left, and naming them, is a good report.

## The vacuity step

The scan now tracks the backlog's carriers (`scripts/Vacuity.lean`'s `trackedProps`, with FS131-T1's procedure for a wave's own in its docstring) and
audits stated `≠` and `¬` conclusions (FS131-T2). Wave 2 brings its own carriers — `AeCover`, maximal covers, partial colourings and the rest; decide
each in or out under T1's procedure, with a control per new carrier and the counts reconciled. Wave 3's implementer will register wave 3's
carriers in the same list on its own branch: whichever wave lands second merges the other's entries, keeping both. A concrete carrier with no proved
inhabitant reads UNKNOWN and cannot enter the baseline (it only shrinks): `sq9` inhabits `AeColouring 9`; if another concrete carrier lacks one, prove
it or message me.

## What is yours to decide

The proofs, their children and order (the planners' §§ 13 and 18 are recommendations), where a supporting lemma lives, and each wave-2 carrier's in-or-out
call. Re-price from your first two hard leaves and say so. If a leaf cannot be proved as written, stop that leaf, message me at once with the declaration,
the reason, and the smallest counterexample or the missing hypothesis, and go on with the others. Three failed attempts on one route is a dispatch to
the companion your identity names, never a fourth.

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them (inventory ruling 5); on
exit 75 wait ten minutes and retry. `lake env lean` is for iteration only, never evidence. The worktree's `.lake/build` is its own copy; never replace
it with a symlink — two trees compiling into one build race on the same compiled files.

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).
