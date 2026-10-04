# Brief FS131-I2c — wave 2 of the Lean backlog, continued: the 43 `sorry` leaves left on branch `fs131-w2`, the gate, the landing

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I2c
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow
  role: the successor of FS131-I2 and FS131-I2b — prove the 43 leaves they left, run the full gate, and land wave 2 on `main`
  launch: now, beside the day's Searcher (small, under 8 GiB) and FS131-I3b (wave 3's second implementer, in its own worktree)
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I2c.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I2-implementation.md` (on branch `fs131-w2`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w2` (branch `fs131-w2`): the wave-2 modules (`Proofs/HadwigerNelson/Plane/MaximalCover.lean`, `Slack.lean`, `Stationary.lean`, `FalconerReduction.lean`, `YesLimit.lean`, `CoverExamples.lean`, and `Proofs/HadwigerNelson/Arith/PlaceHom.lean`, `FalconerField.lean`, `Dyadic.lean`), supporting lemmas in the wave's foundation (`Proofs/HadwigerNelson/Plane/Cover.lean`, `Suprema.lean`, `CPColouring.lean`) and in the shared foundation under `Proofs/HadwigerNelson/Plane/`, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 2's carriers only — § The vacuity step), `plans/FS131-I2-implementation.md`, `tools/fs131_i2_*.py`, `data/fs131/i2/`, `data/fs131/reports/FS131-I2c.md`; and, at the landing only, `main` by fast-forward
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are the third implementer on wave 2. FS131-I2 proved 23 of the 71 leaves and FS131-I2b five more (28 in all), both de Bruijn on Sonnet like you; each kept the build green with only `sorry` warnings and handed back with what is left listed in the shared record, whose Stage 4 is your handoff. Two rulings were applied in Stage 4 (inventory items 56 and 57: `IsLowerGraphOf` on the density set; `CurvatureLeOne` testing from below). The rest of this letter is the original brief, kept so you have the whole picture: you are building wave 2 of the milestone that turns this project's hand-derived results into kernel-checked ones. Wave 1 landed earlier today
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

> **Left (43)**: `Plane/MaximalCover` 3 (`curvatureLeOne`, `semiconcaveWith`, `exists_grundy`); `Plane/Slack` 15 (as Stage 3); `Plane/Stationary` 1
> — source: .claude/worktrees/fs131-w2/plans/FS131-I2-implementation.md § Stage 4 — SAVED (FS131-I2b): five leaves, two rulings applied; the build is green; 43 leaves left

(the paragraph continues there; Stage 4 also holds plans for `face` and `exists_tight`). **One leaf has an open question, recorded in Stage 4**: in `curvatureLeOne`'s exterior case, the equator configuration (the contact at the exterior disc's equator, vertical tangent) gives no supporting arc. The coordinator's inference, offered for you to check and not as a route: with test functions touching from below (item 57), a graph that must avoid that disc drops like `−√(2t)` beside the contact, so perhaps no C² test function touches there at all and the case is vacuous. If it is not, and the clause is genuinely false there, message me with the configuration — that is a statement defect, not yours to repair. One ruling already applied: `vesica_apex_exact` carries `0 ≤ h` (inventory item 48).

## Done means

1. **Your readback first**: check both quotations against their sources; confirm the branch builds as I2b left it (`23c92109`); restate in your record what
   you may and may not change. `main` has moved since the branch last merged it (`0b97dd89`): merge it now (keep both sides of the append-only lines).
2. Every one of the 43 remaining leaves proved, no statement changed, no new `axiom`, no `native_decide`.
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
   three to five implementer sessions; you are the third, and a fourth continues from your record if needed. The second
   measured about 40k tokens per leaf: plan your stages so a hand-back loses nothing.

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
