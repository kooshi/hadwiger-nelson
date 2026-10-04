# Brief FS131-I2g — wave 2 of the Lean backlog, continued: the 117 remaining `sorry` lines on branch `fs131-w2`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I2g
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow
  role: the seventh implementer on wave 2 — prove the wave's remaining leaves and children (K2c's and K2d's plans), saving after each, run the full gate when the last is proved, and land wave 2 on `main`
  launch: now, beside FS131-I4b, FS131-I3f and FS131-IW (implementers) and FS131-E2 (a deriver, no Lean), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I2g.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I2-implementation.md` (on branch `fs131-w2`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w2` (branch `fs131-w2`): the wave-2 modules (`Proofs/HadwigerNelson/Plane/MaximalCover.lean`, `Slack.lean`, `Stationary.lean`, `FalconerReduction.lean`, `YesLimit.lean`, `CoverExamples.lean`, and `Proofs/HadwigerNelson/Arith/PlaceHom.lean`, `FalconerField.lean`, `Dyadic.lean`, and `Proofs/HadwigerNelson/Instances/FalconerOrbit.lean`), supporting lemmas in the wave's foundation (`Proofs/HadwigerNelson/Plane/Cover.lean`, `Suprema.lean`, `CPColouring.lean`) and in the shared foundation under `Proofs/HadwigerNelson/Plane/`, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 2's carriers only — § The vacuity step), `plans/FS131-I2-implementation.md`, `tools/fs131_i2_*.py`, `data/fs131/i2/`, `data/fs131/reports/FS131-I2g.md`; and, at the landing only, `main` by fast-forward
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are the seventh implementer on wave 2. The sixth, FS131-I2f (de Bruijn on Opus, a trial), closed 37 `sorry` lines and five rows: the
place-homomorphism row, the no-affine row, both clauses of the Falconer-residue row, the SQ9 example and the band clause, plus two of DISC7's three
clauses. 117 lines are left. Wave 2 is the measurable-colouring rows — covers and maximal covers, the slack suprema, stationary colourings, the worked
examples R7, DISC7, HC and IRREG — and the arithmetic rows on place homomorphisms, Falconer fields and the dyadic lemma. Every remaining leaf has stated
children: FS131-K2c's for `Plane/Slack`, `Plane/Cover`, `Plane/FalconerReduction`, `Plane/YesLimit` and `Arith/Dyadic` (the plan's § 13), FS131-K2d's for
`Plane/CoverExamples` (§ 18).

## Why this job

A wave counts as held only when all of it passes the gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`); wave 2's 28 rows are
derived until its last leaf is proved. Kooshi's standing word: formalization is never a cost that ranks routes (`CLAUDE.md` § Counter-priors).

## The statements

The statements are every `sorry` on branch `fs131-w2` at `7c890ed9` (117 lines that are exactly `sorry`: `Plane/Slack` 46, `Plane/CoverExamples` 44,
`Arith/Dyadic` 12, `Plane/FalconerReduction` 9, `Plane/YesLimit` 4, `Plane/Cover` 2), read back against their rows in
`.claude/worktrees/fs131-w2/plans/FS131-w2-kernel-plan.md` §§ 4.1 and 7.3, each child's statement fixed by K2c (§ 12) or K2d (§§ 15–17). What you may change:

> - **May**: prove any child or leaf; add further children (state each as a lemma before using it, and add its `scripts/Axioms.lean` record);
> — source: .claude/worktrees/fs131-w2/plans/FS131-w2-kernel-plan.md § Stage 13 — SAVED: the handoff for the fifth implementer (stage 10's form, brought to this stage)

(the section continues with what you may not change and the amended landing; § 18 restates the rules for K2d's files.) I2f's suggested order:

> - Order by row closure per child: DISC7's last three plus `upperDensity_of_periodic` close FS111-M2-DISC7; (G1)'s four close `g1Bounds_hcGap`;
> — source: .claude/worktrees/fs131-w2/plans/FS131-I2-implementation.md ## Stage 9 — SAVED (FS131-I2f): BAND (1) closed; DISC7's first two clauses closed; the build is green; 117 `sorry` left — handoff

(it continues there; read I2f's whole "For the next implementer" paragraph — its iteration recipe and two deprecations at the Mathlib pin save time). One
trap I2f found: the coordinator's shared scratch directory holds an olean overlay (`ol`) with real olean files from earlier wave-2 sessions, stale against
the branch — use a private overlay of your own, as I2f did. One open point: `exists_not_uniform_kept`'s fringe colouring (§ 17.1) does not yet handle unit
pairs between two fringe points (K2d proposed fringes of nearby grid edges with disjoint colour sets, `k = 9 + 3N`); if no formula proper at every unit pair
comes out, message me — that is a deriver's question, not yours.

## Done means

1. **Your readback first**: check both quotations against their sources; build the branch once as given (`7c890ed9`) before editing anything; restate in
   your record what you may and may not change. Commit and push.
2. **Leaves and children proved**, in the order you judge unblocks most, saving after each; no statement changed, no new `axiom`, no `native_decide`.
   Re-price from your first two hard children and say so in the record.
3. **When the last is proved**, the full gate as § 13 gives it, on one commit in the worktree (the build with zero warnings; `scripts/axioms.sh` clean
   with `falconer_lemma2_nonempty` the one declared import; `scripts/vacuity.sh` and `--self-test` green with wave 2's carriers registered under FS131-T1's
   procedure; `tools/check_architecture.py` exit 0; each check's negative control watched going red), then the landing: merge `main`, re-run the gate,
   fast-forward `main`, push — never force-push.
4. **Your record**, `plans/FS131-I2-implementation.md` (you continue it), in stages headed "Stage n — SAVED", with "Theorems this phase proved": one line
   per row theorem — its declaration, its axioms (from a saved audit log when the gate runs, else from a `#print axioms` print, saying which), the row it
   was read against.
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

## Amendment 2026-10-04 (Keryx) — the Dyadic statements, ruled

Your finding is ruled as `plans/FS131-close-inventory.md` item 134. In `.claude/worktrees/fs131-w2/Proofs/HadwigerNelson/Arith/Dyadic.lean`, the hypothesis
`hi` becomes `∃ ι : L, ι ^ 2 = -1 ∧ ι ∉ Set.range (algebraMap F L)` in exactly five declarations — `exists_root_quadratic`, `dyadicConclusion_of_coeffs`,
`sqrt3_local_of_congr`, `sqrt3_local` and `sqrt3_dyadic` — with their docstrings saying so and the item number, and the change recorded in your record. Nothing
else changes, and you still start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).
