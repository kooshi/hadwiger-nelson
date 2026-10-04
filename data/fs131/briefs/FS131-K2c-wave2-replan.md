# Brief FS131-K2c — wave 2 of the Lean backlog, re-planned: break its 34 hard leaves into pieces an implementer can close

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K2c
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: re-plan wave 2's 34 remaining `sorry` leaves — decompose each into named children small enough for a Sonnet implementer to close, confirm every route's Mathlib names with `#check`, decide each outside theorem the routes need, and write the next implementer's handoff
  launch: now, beside FS131-I3c (wave 3's implementer) and FS131-K4c (wave 4's planner), each in its own worktree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect, a generalization, a missing lemma, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K2c.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w2-kernel-plan.md` (on branch `fs131-w2`; you add stages to it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w2` (branch `fs131-w2`): the wave-2 modules (children only — new `sorry`ed lemmas and the leaves' proofs re-pointed at them; no row statement changes), supporting definitions in the wave's foundation, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-w2-kernel-plan.md`, `tools/fs131_k2c_*.py`, `data/fs131/k2c/`, `data/fs131/reports/FS131-K2c.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. Wave 2 — measurable colourings, covers, stationary colourings, the worked examples, Falconer fields — has had four Sonnet implementers in a row
(FS131-I2, -I2b, -I2c, -I2d). Together they proved 37 of its 71 leaves, with real progress on hard ones (the corrected curvature clause of FS111-M-COVER-SC
and its semiconcavity corollary are now proved). But the last two stopped early, each judging that none of the remaining leaves would close in the context
it had left: the 34 that remain are mostly the ones the planners priced hard, and several rest on mathematics the plan sketched in a line (a jointly
measurable modification of a process continuous in probability; a P-local Kummer–Dedekind lemma; Falconer fans with place homomorphisms). A fifth
implementer on the same plan would likely do the same. So this is a planning job: you are closer to the mathematics than an implementer, and your work
is to turn each hard leaf into steps an implementer can take.

## Why this job

A wave counts as held only when all of it passes the gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), so wave 2's 37 proved
leaves are not yet held. Kooshi's standing word on Lean work: formalization is never a cost that ranks routes, and ambition sets the target
(`CLAUDE.md` § Counter-priors).

## The statements

The 34 `sorry` leaves on branch `fs131-w2` at `3bd6cf52`, in the wave's modules, read back against their rows in `.claude/worktrees/fs131-w2/plans/FS131-w2-kernel-plan.md` §§ 4.1 and 7.3 (statements fixed
by the planners and the rulings — inventory items 18–19, 34, 37, 48, 56, 57, 63, 72). The implementers' shared record says what each needs; one line of its
latest stage:

> - `chiM0_le_chiCP` needs a jointly measurable modification of a process continuous in probability (dyadic approximation); `face` and `keptAt_band` are
> — source: .claude/worktrees/fs131-w2/plans/FS131-I2-implementation.md § Stage 6 — SAVED (FS131-I2d): four leaves, one ruling applied; the build is green; 34 `sorry` left

(that stage continues with `IsMUA.add_normal_mem_essSupport`'s costed route, a plan for `sq9_saturated_both`, and the H leaves not started:
`sqrt3_local_of_congr`, `falconerFan_five_*`, `exists_placeHom`; stages 3–5 list the rest, with I2c's finding that `exists_tight` and
`exists_bandNull_aeCover_of_mu_eq_one` need continuity in r of the three-dimensional unit-pair mass, and item 64's note on `sqrt3_local`).

## Done means

1. **A table of the 34 leaves** in your record: each with its route, its children (named, each a `sorry`ed lemma in the skeleton with its statement), the
   Mathlib lemmas each child uses (confirmed with `#check` at the pin), an honest price per child for a Sonnet implementer, and the order. A child priced
   above about 40k tokens is split again or explained.
2. **The children in the skeleton**, building through the worktree's `./scripts/build.sh` with only `sorry` warnings; no row statement changed (a statement
   change is a ruling — message me); `scripts/Axioms.lean` records for every new child.
3. **Each outside theorem a route needs, decided** (`LEAN.md` § Assumptions): formalized here when under about an hour of agent work, else an `axiom` with
   its four items or its own planner-and-implementer job, named — with a source read for each import, and a proposed `BIBLIOGRAPHY.md` row in your report.
4. **The handoff** for the fifth implementer: where it is, the build, what it may and may not change, the order, the landing (the form of `.claude/worktrees/fs131-w2/plans/FS131-w2-kernel-plan.md` § Stage 10).
5. Your stages appended to the record, headed "Stage n — SAVED" from the next number; "Theorems this phase proved" (usually none); the report in standing rule
   11's form.

## What is yours to decide

Every route and decomposition. If a leaf's route turns out to need new mathematics — not a formalization step — that is a missing lemma: state it and
message me, and I route it to a deriver. If a statement turns out false or mis-stated, message me with the counterexample. You may prove a child yourself
where that is the quickest way to show a route works; say so.

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them (inventory ruling 5); on exit 75
wait ten minutes and retry. `lake env lean` is for iteration only. The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing
with a `sorry` reaches `main`. `main` has moved since the branch last merged it; leave the merge to the landing.
