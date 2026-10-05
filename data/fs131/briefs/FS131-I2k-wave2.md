# Brief FS131-I2k — wave 2 of the Lean backlog, continued: the 36 remaining `sorry` lines on branch `fs131-w2`, the carriers, the gate, the landing

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I2k
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the eleventh implementer on wave 2 — prove its remaining leaves and children, saving after each, register its vacuity carriers, then the full gate and the landing on `main`
  launch: now, beside FS131-I4f (wave 4) and FS131-IWd (Woodall's chain), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I2k.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I2-implementation.md` (on branch `fs131-w2`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w2` (branch `fs131-w2`): the wave-2 modules (`Proofs/HadwigerNelson/Plane/MaximalCover.lean`, `Slack.lean`, `Stationary.lean`, `FalconerReduction.lean`, `YesLimit.lean`, `CoverExamples.lean`, and `Proofs/HadwigerNelson/Arith/PlaceHom.lean`, `FalconerField.lean`, `Dyadic.lean`, and `Proofs/HadwigerNelson/Instances/FalconerOrbit.lean`), supporting lemmas in the wave's foundation (`Proofs/HadwigerNelson/Plane/Cover.lean`, `Suprema.lean`, `CPColouring.lean`) and in the shared foundation under `Proofs/HadwigerNelson/Plane/`, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 2's carriers only — § The vacuity step), `plans/FS131-I2-implementation.md`, `tools/fs131_i2_*.py`, `data/fs131/i2/`, `data/fs131/reports/FS131-I2k.md`; and, at the landing only, `main` by fast-forward
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are the eleventh implementer on wave 2, on Opus. Wave 2 is the measurable-colouring rows. It stands at 36 open lines: the tenth implementer,
FS131-I2j, made the slack limits (µ_k(ε) → µ_k⁰), the attainment clause and FS106-COMP sorry-free, and assembled the equivalence `χ_m⁰ ≤ k ⟺ µ_k⁰ = 1`, which
now waits only on one leaf, `unitForm_tendsto` (the Rajchman step). Left: that leaf and `integral_circleAvg_sq` in `Plane/Slack`, then the worked examples in
`Plane/CoverExamples` (R7, (G1), HC and IRREG), then the carriers, the gate and the landing.

## Why this job

A wave counts as held only when all of it passes the gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Wave 2 is the Lean side of the
measurable collapse (`CLAUDE.md` § The aim, items 1–2).

## The statements

Every `sorry` on branch `fs131-w2` at `9e32ab1d` (36 lines: `Plane/Slack` 2, `Plane/CoverExamples` 34), read back against their rows in
`.claude/worktrees/fs131-w2/plans/FS131-w2-kernel-plan.md` §§ 4.1 and 7.3, children fixed by K2c (§ 12) and K2d (§§ 15–17). The rule:

> - **May**: prove any child or leaf; add further children (state each as a lemma before using it, and add its `scripts/Axioms.lean` record);
> — source: .claude/worktrees/fs131-w2/plans/FS131-w2-kernel-plan.md § Stage 13 — SAVED: the handoff for the fifth implementer (stage 10's form, brought to this stage)

Where I2j left it:

> **Still `sorry`** (36): `Plane/Slack` 2 — `integral_circleAvg_sq` and `unitForm_tendsto` (the Rajchman step); `Plane/CoverExamples` 34 — R7 8
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w2/plans/FS131-I2-implementation.md ## Stage 21 — SAVED (FS131-I2j): the two compactness assemblies; Slack 4 → 2; the build is green; handoff — 36 `sorry` left

and its routes for the two Slack leaves begin:

> **For the next implementer.** (1) `integral_circleAvg_sq`: `(∫_θ f)² = ∫∫ f(θ) f(φ)` on `arcLength ⊗ arcLength` (`integral_prod_mul`), swap with
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w2/plans/FS131-I2-implementation.md ## Stage 21 — SAVED (FS131-I2j): the two compactness assemblies; Slack 4 → 2; the build is green; handoff — 36 `sorry` left

(the paragraph continues there, with (2) `unitForm_tendsto`'s route, (3) the cheapest CoverExamples leaves, and (4) the iteration recipe and a binder trap).
**Owed before the gate**: wave 2's vacuity carriers registered under FS131-T1's procedure, with a control each and the counts reconciled — Stage 18's
recommendation: `CPColouring` IN (empty at `k ≤ 1`, inhabited at 9), the family and set predicates OUT by T1's set-variable rule. Each inhabitant exercises
every clause at a parameter the theorem does not refute (`LEAN.md` § The gate). The IMPORTED move, the docstrings and the Dyadic `hi` change (item 134) are
done; keep them. The untracked `build-i2*.log` files at the worktree's root are earlier implementers' scratch: leave them uncommitted.

## Done means

1. **Your readback first**: check the three quotations against their sources; build the branch once as given (`9e32ab1d`) before editing anything; restate in your
   record what you may and may not change. Commit and push.
2. **Leaves and children proved**, saving after each; no statement changed, no new `axiom`, no `native_decide`; re-price from your first two hard children.
3. **The carriers**, then **the full gate** on one commit (build with zero warnings — count them, since `scripts/build.sh` exits 0 with warnings; `scripts/axioms.sh`
   clean with the four records under IMPORTED and `--self-test` green; `scripts/vacuity.sh` and `--self-test` green; `tools/check_architecture.py` exit 0; each
   negative control watched going red), then **the landing**: merge `main` (run `tools/fs131_qa1_dupes.py`), re-run the gate, fast-forward `main` (`git push
   origin HEAD:main` from the worktree), never force-push.
4. **Your record** (continue it), stages headed "Stage n — SAVED", "Theorems this phase proved", drafts for the front page at the gate (the Trust ledger's three
   counts, the imported count rising from 0; § The gate's counts; the baseline header); the report in standing rule 11's form. Stopping at a saved stage with
   leaves left, and naming them, is a good report.

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
