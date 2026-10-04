# Brief FS131-I3c — wave 3 of the Lean backlog, continued: the 21 `sorry` declarations left on branch `fs131-w3`, the gate, the landing

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I3c
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow
  role: the successor of FS131-I3 and FS131-I3b — prove the 21 declarations they left (the sector-structure engine first), run the full gate, and land wave 3 on `main`
  launch: now, beside FS131-I2d (wave 2's fourth implementer) and FS131-K4b (wave 4's second planner), each in its own worktree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I3c.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I3-implementation.md` (on branch `fs131-w3`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w3` (branch `fs131-w3`): the nine wave-3 modules (`Proofs/HadwigerNelson/Plane/LocalMap.lean`, `LocalMapExamples.lean`, `CircleColouring.lean`, `LocalStructure.lean`, `SixFragment.lean`, `Tiles.lean`, `RingGerm.lean`, `Lens.lean`, `RingBand.lean` — supporting lemmas only in the three foundation ones), supporting lemmas in the foundation modules the handoff names (`Proofs/HadwigerNelson/Plane/ArcMap.lean`, `UnitPairs.lean`, `Basic.lean`, `Chord.lean`, `DensityPoints.lean`), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 3's carriers only, last — § The vacuity step), `plans/FS131-I3-implementation.md`, `tools/fs131_i3_*.py`, `data/fs131/i3/`, `data/fs131/reports/FS131-I3c.md`; and, at the landing only, `main` by fast-forward
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are the third implementer on wave 3. FS131-I3 proved 55 of the 96 leaves (`Plane/Tiles` complete, engines 1 and 2 built); FS131-I3b proved FS129-SR1-RINGBAND in full — all twelve leaves on the standard three axioms in a real audit log — and SixFragment's easy half, and left 21 `sorry` declarations with an order of work in the shared record's Stage 2, your handoff. Rulings applied: item 39 (`hz : z ∈ F.dom` in FS116-V5-U1) and item 61 (RINGBAND (iv)'s genuine change set). I3b restored the `=== PURCHASED ===` banner in the branch's `scripts/Axioms.lean`; recheck it when you merge `main`. The rest of this letter is the original brief, kept for the whole picture: you are building wave 3 of the milestone that turns this project's hand-derived results into kernel-checked ones. Wave 1 landed earlier today
(14 rows, `d59ffcdf`); wave 3 is the local geometry of a planar map around a point — tiles, the ring of colours on the unit circle about a vertex,
germs, change points, (Q) arcs, RINGBAND's circle colourings — and waves 4 to 9 stand on it. Two planners on Opus wrote it: FS131-K3 the foundation
(sorry-free), FS131-K3b the skeleton of 20 rows and the 6 merged into them, with read-backs, a plan per leaf, an obligation-modeling pass, and the
handoff you work from.

## Why this job

A wave counts as held only when its declarations pass the full gate and their axioms are read from the gate's saved log (the milestone's
announcement rule, `plans/FS131-close-inventory.md`). Your proofs are what turns these 26 results from derived into held.

## The statements

The statements are the 96 `sorry`-ed declarations on branch `fs131-w3` (head `05cb0a3e`), read back against their rows in
`.claude/worktrees/fs131-w3/plans/FS131-w3-kernel-plan.md` § 5.2, with the leaf plans in § 6 (the three engines first, the order in § 6.3). The rule
that governs them:

> **It may**: add lemmas (children) anywhere in the wave's modules — the three engines (`Valid.dist_lt_or_gt_of_isPreconnected`, `mem_closure_tile`,
> — source: .claude/worktrees/fs131-w3/plans/FS131-w3-kernel-plan.md § 7.2 What the implementer may and may not change

FS131-I3's record groups what is left, the first row of its table being:

> Branch `fs131-w3`, commits after `8a850e85`. **41 leaves at the start, 21 `sorry` declarations now** (build `data/fs131/i3/build-stage2-full.log`,
> — source: .claude/worktrees/fs131-w3/plans/FS131-I3-implementation.md § Stage 2 — SAVED (FS131-I3b): RingBand sorry-free; SixFragment's easy half; the audit run

(the paragraph continues there). I3b's recommended order: (1) engine 3, `localSectors`, which blocks `LocalStructure`'s five leaves, `flank_edge_exists` and `four_of_bothKind`; (2) `RingGerm`; (3) SixFragment's exact-geometry leaves `sixFrag_valid` and `sixFrag_nonSiamese`, then `sixCol_locallyConstant`; (4) `Lens`. Read §§ 7.1–7.3 in full first: the worktree, the build, what you may and may not change (no statement of § 5, no definition of `Plane/LocalMap`,
`Plane/CircleColouring` or `Plane/SixFragment`), and how the wave lands. One statement already carries a correction the coordinator accepted:
`hz : z ∈ F.dom` in FS116-V5-U1's last clauses (inventory item 39).

## Done means

1. **Your readback first**: check both quotations against their sources; confirm the branch is as I3b left it (`3012c049`); restate what you may and may
   not change. Then every one of the 21 remaining declarations proved, no statement changed, no new `axiom`, no `native_decide`.
2. **The full gate green on one commit in the worktree**: the build with zero warnings; `scripts/axioms.sh` clean, every wave-3 record on the standard
   three axioms or fewer; `scripts/vacuity.sh` and `--self-test` green with wave 3's carriers registered (§ The vacuity step); `tools/check_architecture.py`
   exit 0; each check's negative control watched going red. Read the saved logs under the worktree's `build/gate/`, not the line that says a gate passed.
3. **The landing** (§ 7.3): merge `main` into `fs131-w3`, keep both sides of the append-only lines, re-run the gate, fast-forward `main` to the branch,
   push. If `main` has moved by then, merge once more and re-run; never force-push.
4. **Your record**, `plans/FS131-I3-implementation.md` on the branch, in stages headed "Stage n — SAVED", with "Theorems this phase proved": one line per
   row theorem — its declaration, its axioms from the saved audit log, the row it was read against.
5. **Drafts for the front page** in your record (`## Drafts for the front page`): the gate's new counts for `CLAUDE.md` § The gate and § Trust ledger and
   for `scripts/vacuity-baseline.txt`'s header. Nothing for `LEDGER.md` (rows are regraded at the milestone's filing).
6. The report, in standing rule 11's form. Stopping at a saved stage with leaves left, and naming them, is a good report: a fourth implementer continues
   from your record if needed.

## The vacuity step

FS131-T1 taught the scan the backlog's carriers and wrote, in `scripts/Vacuity.lean`'s `trackedProps` docstring, the procedure by which a wave registers
its own (in or out, each with its reason; a control per new carrier; a run with the counts reconciled). The planner's recommendation for wave 3's
predicates is in § 7.2 of its plan. FS131-T2 has landed on `main` (`66f679a6`). Do this step last: merge `main`, then register wave 3's carriers on top of T2's version. Wave 2's implementer
registers wave 2's carriers in the same list on its own branch: whichever wave lands second merges the other's entries, keeping both.

## What is yours to decide

The proofs, their children and order, where a supporting lemma lives, and each wave-3 carrier's in-or-out call under T1's procedure. Re-price from your
first two hard leaves and say so. If a leaf cannot be proved as written, stop that leaf, message me at once with the declaration, the reason, and the
smallest counterexample or the missing hypothesis, and go on with the others. Three failed attempts on one route is a dispatch to the companion your
identity names, never a fourth.

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them (inventory ruling 5); on
exit 75 wait ten minutes and retry. `lake env lean` (with the flags § 7.1 gives) is for iteration only, never evidence. The worktree's `.lake/build` is its
own copy; never replace it with a symlink — two trees compiling into one build race on the same compiled files.

