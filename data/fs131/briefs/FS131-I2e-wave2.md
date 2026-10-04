# Brief FS131-I2e — wave 2 of the Lean backlog, continued: the 16 re-planned leaves whose children are stated, on branch `fs131-w2`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I2e
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow
  role: the fifth implementer on wave 2 — prove the 16 leaves FS131-K2c re-planned into stated children, then as many of the rest as their children allow, run the full gate, and land wave 2 on `main`
  launch: now, beside FS131-I3d (wave 3's implementer) and FS131-E1 (a deriver, no Lean); FS131-K2d (a planner, stating children for wave 2's other 18 leaves) may later run beside you in its own worktree, touching only `Plane/CoverExamples`, `Arith/PlaceHom` and `Arith/FalconerField` — leave those three files to it
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I2e.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I2-implementation.md` (on branch `fs131-w2`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w2` (branch `fs131-w2`): the wave-2 modules (`Proofs/HadwigerNelson/Plane/MaximalCover.lean`, `Slack.lean`, `Stationary.lean`, `FalconerReduction.lean`, `YesLimit.lean`, `CoverExamples.lean`, and `Proofs/HadwigerNelson/Arith/PlaceHom.lean`, `FalconerField.lean`, `Dyadic.lean`), supporting lemmas in the wave's foundation (`Proofs/HadwigerNelson/Plane/Cover.lean`, `Suprema.lean`, `CPColouring.lean`) and in the shared foundation under `Proofs/HadwigerNelson/Plane/`, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 2's carriers only — § The vacuity step), `plans/FS131-I2-implementation.md`, `tools/fs131_i2_*.py`, `data/fs131/i2/`, `data/fs131/reports/FS131-I2e.md`; and, at the landing only, `main` by fast-forward
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are the fifth implementer on wave 2. Four Sonnet implementers before you proved 37 of its 71 leaves; the last two stopped early on the hard ones, so a planner, FS131-K2c (de Bruijn on Opus), re-planned all 34 that were left: routes, named children, prices and an order (the plan's § 12.2), with the children stated in the skeleton for 16 of them — all twelve in `Plane/Slack`, `falconer_reduction`, `chiM0_le_of_fragments` (now proved from its child), `exists_grundy`, and both Dyadic leaves. Those 16 are yours first. The other 18 (lane A's four, CoverExamples' thirteen, `exists_not_uniform_kept`) wait for a later planning stage. Rulings applied so far: items 48, 56, 57, 63, 72, 86; and item 93 makes `[Falconer1981]` Lemma 2 (i) an axiom (`falconer_lemma2_nonempty`, its four items done), so wave 2's landing will read six declared purchases and `scripts/axioms.sh` must learn that name. The rest of this letter is the original brief, kept so you have the whole picture: you are building wave 2 of the milestone that turns this project's hand-derived results into kernel-checked ones. Wave 1 landed earlier today
(14 rows, `d59ffcdf`). Wave 2 is the measurable-colouring rows — covers and maximal covers, the slack suprema `µ_k(ε)`, stationary colourings and the
CP number, the worked examples R7, DISC7, HC, IRREG — and the arithmetic rows on place homomorphisms, Falconer fields and the dyadic lemma. Two
planners on Opus wrote it: FS131-K2 the foundation (sorry-free) and 22 rows, FS131-K2b the last six, the obligation-modeling pass and the handoff you
work from. They caught two false clauses on the way (inventory items 18–19 and 37), both already corrected in the statements you will prove.

## Why this job

A wave counts as held only when its declarations pass the full gate and their axioms are read from the gate's saved log (the milestone's announcement
rule, `plans/FS131-close-inventory.md`). Your proofs are what turns these 28 results from derived into held.

## The statements

The statements are the 71 leaves on branch `fs131-w2` as the planners left them (head `41c66271`; 48 still `sorry` at `0e5febba`), read back against their rows in
`.claude/worktrees/fs131-w2/plans/FS131-w2-kernel-plan.md` § 4.1 (K2's 22) and § 7.3 (the six), with the leaf plans in §§ 4.2 and 7.4 as corrected by §§ 8
and 9, and the order of work in § 9.2. The rule that governs them:

> **It may not** change any statement, add or drop a hypothesis, or change a definition's meaning (`r7Col`, `disc7`, `hcSet`, `G1Bounds`,
> — source: .claude/worktrees/fs131-w2/plans/FS131-w2-kernel-plan.md § Stage 10 — SAVED: where it is, and how the implementer works (stage 5 brought to all 28 rows)

Read Stage 10 in full first: the worktree, the build, what you may and may not change, the order, and how the wave lands. Then FS131-I2's record, whose stage 3 lists what is left:

> - **May**: prove any child or leaf; add further children (state each as a lemma before using it, and add its `scripts/Axioms.lean` record);
> — source: .claude/worktrees/fs131-w2/plans/FS131-w2-kernel-plan.md § Stage 13 — SAVED: the handoff for the fifth implementer (stage 10's form, brought to this stage)

(the section continues with what you may not change, the order, and the amended landing; read Stage 13 in full, then § 12.2's table for each leaf's route.)

## Done means

1. **Your readback first**: check both quotations against their sources; confirm the branch builds as K2c left it (`bdba8ff5`); restate in your record what
   you may and may not change. Leave the merge of `main` to the landing.
2. The 16 re-planned leaves proved through their children, then any other leaf whose route is complete;, no statement changed, no new `axiom`, no `native_decide`.
3. **The full gate green on one commit in the worktree**: the build with zero warnings; `scripts/axioms.sh` clean, every wave-2 record on the standard
   three axioms or fewer (the named hypotheses `Row130M1`, `hR78`, `hR88`, `hR88per` appear as hypotheses, never as axioms); `scripts/vacuity.sh` and
   `--self-test` green with wave 2's carriers registered (§ The vacuity step); `tools/check_architecture.py` exit 0; each check's negative control watched
   going red. Read the saved logs under the worktree's `build/gate/`, not the line that says a gate passed.
4. **The landing**: merge `main` into `fs131-w2` again, re-run the gate, fast-forward `main` to the branch, push. If `main` has moved by then, merge once
   more and re-run; never force-push.
5. **Your record**, `plans/FS131-I2-implementation.md` on the branch, in stages headed "Stage n — SAVED", with "Theorems this phase proved": one line per
   row theorem — its declaration, its axioms from the saved audit log, the row it was read against.
6. **Drafts for the front page** in your record (`## Drafts for the front page`): the gate's new counts for `CLAUDE.md` § The gate and § Trust ledger and
   for `scripts/vacuity-baseline.txt`'s header. Nothing for `LEDGER.md`.
7. The report, in standing rule 11's form. Stopping at a saved stage with leaves left, and naming them, is a good report: the planner priced the wave at
   three to five implementer sessions; you are the fifth, and the wave lands only when all 71 are proved — likely after the next planning stage and
   another implementer. Save after each leaf.

## The vacuity step

The scan now tracks the backlog's carriers (`scripts/Vacuity.lean`'s `trackedProps`, with FS131-T1's procedure for a wave's own in its docstring) and
audits stated `≠` and `¬` conclusions (FS131-T2). Wave 2 brings its own carriers — `AeCover`, maximal covers, partial colourings and the rest; decide
each in or out under T1's procedure, with a control per new carrier and the counts reconciled. Wave 3's implementer, FS131-I3, will register wave 3's
carriers in the same list on its own branch: whichever wave lands second merges the other's entries, keeping both. A concrete carrier with no proved
inhabitant reads UNKNOWN and cannot enter the baseline (it only shrinks): `sq9` inhabits `AeColouring 9`; if another concrete carrier lacks one, prove
it or message me.

## What is yours to decide

The proofs, their children and order (the planner's § 9.2 is a recommendation), where a supporting lemma lives, and each wave-2 carrier's in-or-out
call. Re-price from your first two hard leaves and say so. If a leaf cannot be proved as written, stop that leaf, message me at once with the declaration,
the reason, and the smallest counterexample or the missing hypothesis, and go on with the others. Three failed attempts on one route is a dispatch to
the companion your identity names, never a fourth.

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them (inventory ruling 5); on
exit 75 wait ten minutes and retry. `lake env lean` is for iteration only, never evidence. The worktree's `.lake/build` is its own copy; never replace
it with a symlink — two trees compiling into one build race on the same compiled files.
