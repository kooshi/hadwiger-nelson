# Brief FS131-LEB — Lebesgue's covering theorem for the square, in the kernel

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-LEB
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: plan the formalization of Lebesgue's covering theorem for the square (two dimensions, three sets) as a self-contained module that lands on `main` by itself — a source read, a route chosen, the skeleton with `sorry` at every leaf, a plan per leaf, the implementer's handoff — proving children yourself where that is the quickest way to show the route works
  launch: now, beside four implementers and a code-quality auditor, each in its own tree
  mission: § Why this job
  statements: § The statement
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect, a shorter route, a missing lemma, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-LEB.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-LEB-kernel-plan.md` (on branch `fs131-leb`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-leb` (branch `fs131-leb`, made for you from `main` at `bbee15f0`): one new module or a small new directory of modules for the theorem and its supporting combinatorics (under `Proofs/HadwigerNelson/Topology/`, say), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-LEB-kernel-plan.md`, `tools/fs131_leb_*.py`, `data/fs131/leb/`, `data/fs131/reports/FS131-LEB.md`
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. Wave 4 of the Lean backlog and Woodall's "maps need six" chain both rest, through FS106-TS-T (every valid map of the plane has a point of at least
three colours), on Lebesgue's covering theorem for the square. Mathlib has neither it nor Brouwer's fixed-point theorem nor Sperner's lemma, so both
branches carry it as a `sorry`ed theorem, and neither can land until it is proved. It is a classical result with a combinatorial proof, and a gap in
Mathlib that every later use of plane topology here will want.

## Why this job

The coordinator's ruling when the theorem first appeared:

> 66. **Ruling — Lebesgue's covering theorem for the square** (K4b's OUT-LEB; TS-T's first clause rests on it; Mathlib has neither it nor Brouwer nor Sperner):
> — source: plans/FS131-close-inventory.md

(the ruling continues there, with the bibliography debt: Hurewicz–Wallman, *Dimension Theory*, Thm IV 2, recalled, not read, not held). Kooshi's standing
word: formalization is never a cost that ranks routes (`CLAUDE.md` § Counter-priors); all implementers now run on Opus (item 137).

## The statement

Wave 4's skeleton states it in `Plane/SVMap` (branch `fs131-w4`); the docstring opens:

> /-- **Lebesgue's covering theorem for the square** (`n = 2`): if a closed square is covered by finitely many closed sets none of
> — source: .claude/worktrees/fs131-w4/Proofs/HadwigerNelson/Plane/SVMap.lean

The definition and the statement, copied by script from that file (one path in the docstring rewritten to its worktree address):

```lean
/-- The closed axis-parallel square `[c.re, c.re + s] × [c.im, c.im + s]`. -/
def closedSquare (c : ℂ) (s : ℝ) : Set ℂ := {z | c.re ≤ z.re ∧ z.re ≤ c.re + s ∧ c.im ≤ z.im ∧ z.im ≤ c.im + s}

/-- **Lebesgue's covering theorem for the square** (`n = 2`): if a closed square is covered by finitely many closed sets none of
which meets two opposite sides, some point of the square lies in three of them. Hurewicz–Wallman, *Dimension Theory* (1941), Thm IV 2
(the `n`-cube, `n + 1` sets); SB's step 6 (`plans/FS106-SB-verification.md` § 2.5). **An outside theorem, its disposition owed**
(`.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 7: a separate formalization job, or an `axiom` with `LEAN.md` § Assumptions' four items). -/
theorem lebesgue_covering_square {m : ℕ} (c : ℂ) {s : ℝ} (hs : 0 < s) (F : Fin m → Set ℂ) (hF : ∀ i, IsClosed (F i))
    (hcov : closedSquare c s ⊆ ⋃ i, F i)
    (hLR : ∀ i, ¬ ((∃ z ∈ F i ∩ closedSquare c s, z.re = c.re) ∧ ∃ z ∈ F i ∩ closedSquare c s, z.re = c.re + s))
    (hBT : ∀ i, ¬ ((∃ z ∈ F i ∩ closedSquare c s, z.im = c.im) ∧ ∃ z ∈ F i ∩ closedSquare c s, z.im = c.im + s)) :
    ∃ z ∈ closedSquare c s, ∃ i j l : Fin m, i ≠ j ∧ i ≠ l ∧ j ≠ l ∧ z ∈ F i ∧ z ∈ F j ∧ z ∈ F l := by
  sorry
```

Your module states the same theorem, self-contained and depending on nothing from waves 2–4 (define the square in your module, or use `Set.Icc` products
and prove the bridge to this `closedSquare` as a one-line lemma the wave-4 implementer can call), so that it lands on `main` by itself, ahead of the waves
that use it. A generalization to the `n`-cube with `n + 1` sets is welcome if it costs little; the square is what is owed.

## Done means

1. **Your readback first**: check the two quotations against their sources and restate the statement in your record; confirm the worktree builds as given
   (one build under the slot). Commit and push (`git push -u origin fs131-leb`).
2. **A source read** — Hurewicz–Wallman if you can obtain it, or a modern proof (Sperner's lemma and a compactness argument is the standard route; a
   textbook or lecture notes you can cite) — with what you read recorded per section, and a proposed `BIBLIOGRAPHY.md` row in your report.
3. **The route chosen and stated**: the combinatorial core (Sperner, or another), the compactness step, the reduction from closed sets to the triple point;
   Mathlib names confirmed with `#check` at the pin; a search of Mathlib by the statement's shape for anything already there (`LEAN.md` § Searching).
4. **The skeleton**: the module(s) with `sorry` at every leaf, building through the worktree's `./scripts/build.sh` with only `sorry` warnings;
   `tools/check_architecture.py` exit 0; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` updated.
5. **A plan per leaf** (route, children, an honest price for an Opus implementer) and **the handoff** (where it is, the build, what may and may not
   change, the order, the landing: the gate on this branch, then merge `main` and fast-forward), in the form of `plans/FS131-kernel-plan.md` § 6.1.
6. Your record in stages headed "Stage n — SAVED"; the report in standing rule 11's form. If the whole proof is within your reach, you may prove it and run
   the gate yourself; say so, and the landing is then a ruling of mine.

## What is yours to decide

The source, the route, the module layout, the generality, and whether to prove leaves yourself. If the statement as wave 4 wrote it is false or
mis-stated, message me with the counterexample.

## The machine

Build only from inside your worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Several trees are building today, so on exit 75 wait ten minutes and retry. `lake env lean` is for iteration
only. The worktree's `.lake/packages` is a symlink to the main tree's and its `.lake/build` its own copy (copied from `main`'s); never replace the build
with a symlink. Nothing with a `sorry` reaches `main`. You start no agents of your own (standing rule 1: delegation is one level deep, because the
coordinator can only review work it knows exists).
