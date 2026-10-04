# Brief FS131-I2h — wave 2 of the Lean backlog, continued: the 91 remaining `sorry` lines on branch `fs131-w2`, the gate, the landing

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I2h
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the eighth implementer on wave 2 — prove its remaining leaves and children, saving after each, then the full gate (with the four imported records moved and `CPColouring` registered) and the landing on `main`
  launch: now, beside FS131-I3i (`localSectors`, on `fs131-w3b`) and FS131-W3 (Woodall's chain), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I2h.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I2-implementation.md` (on branch `fs131-w2`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w2` (branch `fs131-w2`): the wave-2 modules (`Proofs/HadwigerNelson/Plane/MaximalCover.lean`, `Slack.lean`, `Stationary.lean`, `FalconerReduction.lean`, `YesLimit.lean`, `CoverExamples.lean`, and `Proofs/HadwigerNelson/Arith/PlaceHom.lean`, `FalconerField.lean`, `Dyadic.lean`, and `Proofs/HadwigerNelson/Instances/FalconerOrbit.lean`), supporting lemmas in the wave's foundation (`Proofs/HadwigerNelson/Plane/Cover.lean`, `Suprema.lean`, `CPColouring.lean`) and in the shared foundation under `Proofs/HadwigerNelson/Plane/`, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 2's carriers only — § The vacuity step), `plans/FS131-I2-implementation.md`, `tools/fs131_i2_*.py`, `data/fs131/i2/`, `data/fs131/reports/FS131-I2h.md`; and, at the landing only, `main` by fast-forward
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are the eighth implementer on wave 2. Wave 2 is the measurable-colouring rows — covers and maximal covers, the slack suprema, stationary
colourings, the worked examples R7, DISC7, HC and IRREG — and the arithmetic rows on place homomorphisms, Falconer fields and the dyadic lemma. Seven
implementers before you brought it from 154 open lines to 91; FS129-SA1-FALC-RED is sorry-free over the milestone's one declared outside theorem
(`falconer_lemma2_nonempty`, Falconer 1981 Lemma 2 (i)). Waves 1 and 3 and Lebesgue's covering theorem have landed on `main`; the axiom gate now has an
IMPORTED section for exactly your case (FS131-T3). You are the first Opus implementer on this wave since the trial, which closed 37 lines in a session.

## Why this job

A wave counts as held only when all of it passes the gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Wave 2's rows include the
measurable collapse's Lean side (`CLAUDE.md` § The aim, items 1–2) — the part of the frontier stated about measurable colourings.

## The statements

Every `sorry` on branch `fs131-w2` at `59976a11` (91 lines: `Plane/Slack` 39, `Plane/CoverExamples` 44, `Arith/Dyadic` 4, `Plane/YesLimit` 4), read back against
their rows in `.claude/worktrees/fs131-w2/plans/FS131-w2-kernel-plan.md` §§ 4.1 and 7.3, each child's statement fixed by K2c (§ 12) or K2d (§§ 15–17). The rule:

> - **May**: prove any child or leaf; add further children (state each as a lemma before using it, and add its `scripts/Axioms.lean` record);
> — source: .claude/worktrees/fs131-w2/plans/FS131-w2-kernel-plan.md § Stage 13 — SAVED: the handoff for the fifth implementer (stage 10's form, brought to this stage)

(the section continues; § 18 restates it for K2d's files). Where I2g left it:

> **Closed since Stage 11** (statements untouched):
> — source: .claude/worktrees/fs131-w2/plans/FS131-I2-implementation.md ## Stage 12 — SAVED (FS131-I2g): `comap_conductor_sup_eq_top`, seven `Plane/Slack` leaves; handoff — 91 `sorry` left

(the stage continues with what is left and the hard remainder: the Kummer–Dedekind engine `dyadicConclusion_of_minpoly`, and Slack's compactness and Rajchman
block; `exists_not_uniform_kept`'s fringe formula not yet reached — if no formula proper at every unit pair comes out, message me). Item 134's Dyadic repair is
applied; keep it.

**Owed before the gate, from the code-quality audit (inventory item 144 (d)) and the gate repair (item 160):** docstrings for the 84 wave-2 theorems that
lack them (`tools/fs131_qa1_quality.py` lists them); FALC-HOSTS (iv)'s docstring (`falconerFan_five_mem_P`, `.claude/worktrees/fs131-w2/Proofs/HadwigerNelson/Arith/FalconerField.lean` near line 274) saying the
frame proves only that a fan's `t − a` is a non-zero forced difference of `R`, the fields and `P = R ∩ 𝔓⁴` entering on instantiation; the four records that
rest on `falconer_lemma2_nonempty` — `falconer_reduction`, `le_chiM_of_falconerFan`, `exists_mem_falconerE`, `fan_tip_ae_mem` — moved to the IMPORTED section
by the procedure beside its banner in `scripts/Axioms.lean` (`data/fs131/t3/wave_dryrun.sh .claude/worktrees/fs131-w2 HadwigerNelson.Plane.falconer_lemma2_nonempty`
lists them for any later state); `CPColouring` registered as a vacuity carrier (empty at `k ≤ 1`, as `AeColouring` was) under FS131-T1's procedure, with a
control. **At the merge of `main`**: wave 3's landed names collide with two of yours — `dist_rot`, `eq_norm_mul_e_arg` — rename or delete yours before the gate
(`tools/fs131_qa1_dupes.py`, item 142).

## Done means

1. **Your readback first**: check both quotations against their sources; build the branch once as given (`59976a11`) before editing anything; restate in your
   record what you may and may not change. Commit and push.
2. **Leaves and children proved**, saving after each; no statement changed, no new `axiom`, no `native_decide`; re-price from your first two hard children.
3. **The owed items above**, then **the full gate** on one commit (build with zero warnings; `scripts/axioms.sh` clean with the four records under IMPORTED and
   `--self-test` green; `scripts/vacuity.sh` and `--self-test` green with wave 2's carriers registered; `tools/check_architecture.py` exit 0; each negative
   control watched going red), then **the landing**: merge `main`, resolve the collisions, re-run the gate, fast-forward `main` (`git push origin HEAD:main`
   from the worktree), never force-push.
4. **Your record** (you continue it), stages headed "Stage n — SAVED", "Theorems this phase proved" (axioms from a saved audit log when the gate runs, else a
   print, saying which), and drafts for the front page (the new counts, the Trust ledger sentence's three counts); the report in standing rule 11's form.
   Stopping at a saved stage with leaves left, and naming them, is a good report.

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
