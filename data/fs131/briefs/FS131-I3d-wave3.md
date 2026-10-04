# Brief FS131-I3d — wave 3 of the Lean backlog, continued: the 16 `sorry` declarations left on branch `fs131-w3`, the gate, the landing

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I3d
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow
  role: the fourth implementer on wave 3 — prove the 16 declarations left (the sector-structure engine first), run the full gate, and land wave 3 on `main`
  launch: now, beside FS131-K2c (wave 2's re-planner) and FS131-W (Woodall's chain, a planner), each in its own worktree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I3d.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I3-implementation.md` (on branch `fs131-w3`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w3` (branch `fs131-w3`): the nine wave-3 modules (`Proofs/HadwigerNelson/Plane/LocalMap.lean`, `LocalMapExamples.lean`, `CircleColouring.lean`, `LocalStructure.lean`, `SixFragment.lean`, `Tiles.lean`, `RingGerm.lean`, `Lens.lean`, `RingBand.lean` — supporting lemmas only in the three foundation ones), supporting lemmas in the foundation modules the handoff names (`Proofs/HadwigerNelson/Plane/ArcMap.lean`, `UnitPairs.lean`, `Basic.lean`, `Chord.lean`, `DensityPoints.lean`), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 3's carriers only, last — § The vacuity step), `plans/FS131-I3-implementation.md`, `tools/fs131_i3_*.py`, `data/fs131/i3/`, `data/fs131/reports/FS131-I3d.md`; and, at the landing only, `main` by fast-forward
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are the fourth implementer on wave 3. Three Sonnet implementers before you (FS131-I3, -I3b, -I3c, de Bruijn like you) proved 80 of its 96 leaves — `Plane/Tiles`, FS129-SR1-RINGBAND, FS116-S1-EXIT, the germ dichotomy and FS116-Y4-FLANK's geometry among them, each on the standard three axioms in a real audit log — and the last left a plan for every one of the 16 still open in the shared record's Stage 3, your handoff. Its findings are routes, not defects: engine 3 without a sector parametrization (distance strictly monotone along each branch; a farthest-point argument; at most 2·(#arcs) arcs on a small sphere); `sixCol (e(π/3)·x) = sixCol x + 1` as the key to SixFragment's trio; and, for `qfree4` and the FIVERING leaves, the sub-arc `germ_dichotomy`'s proof already builds plus the finiteness of the exceptional set Z. I3c moved `re_e`, `im_e`, `sq_norm_eq`, `e_mul_conj_e` and `conj_e` into wave 1's `Plane/Chord` (allowed; it rebuilds Chord's dependents — mind it at the merge). The rest of this letter is the original brief, kept for the whole picture: you are building wave 3 of the milestone that turns this project's hand-derived results into kernel-checked ones. Wave 1 landed earlier today
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

> Branch `fs131-w3`, commits after `3012c049` (I3b's head). **21 `sorry` declarations at the start, 16 now.** Build `build/gate/build/20261004T091636Z-2402026.log`:
> — source: .claude/worktrees/fs131-w3/plans/FS131-I3-implementation.md § Stage 3 — SAVED (FS131-I3c): Lens, germ_dichotomy, FLANK's geometry and cones; the build; 16 leaves left

(the stage continues with "What is left (16)", a table giving each leaf's plan: `LocalStructure` 4, `SixFragment` 3, `RingGerm` 9). Read §§ 7.1–7.3 in full first: the worktree, the build, what you may and may not change (no statement of § 5, no definition of `Plane/LocalMap`,
`Plane/CircleColouring` or `Plane/SixFragment`), and how the wave lands. One statement already carries a correction the coordinator accepted:
`hz : z ∈ F.dom` in FS116-V5-U1's last clauses (inventory item 39).

## Done means

1. **Your readback first**: check both quotations against their sources; confirm the branch is as I3c left it (`98f4b279`); restate what you may and may
   not change. Then every one of the 16 remaining declarations proved, no statement changed, no new `axiom`, no `native_decide`.
2. **The full gate green on one commit in the worktree**: the build with zero warnings; `scripts/axioms.sh` clean, every wave-3 record on the standard
   three axioms or fewer; `scripts/vacuity.sh` and `--self-test` green with wave 3's carriers registered (§ The vacuity step); `tools/check_architecture.py`
   exit 0; each check's negative control watched going red. Read the saved logs under the worktree's `build/gate/`, not the line that says a gate passed.
3. **The landing** (§ 7.3): merge `main` into `fs131-w3`, keep both sides of the append-only lines, re-run the gate, fast-forward `main` to the branch,
   push. If `main` has moved by then, merge once more and re-run; never force-push.
4. **Your record**, `plans/FS131-I3-implementation.md` on the branch, in stages headed "Stage n — SAVED", with "Theorems this phase proved": one line per
   row theorem — its declaration, its axioms from the saved audit log, the row it was read against.
5. **Drafts for the front page** in your record (`## Drafts for the front page`): the gate's new counts for `CLAUDE.md` § The gate and § Trust ledger and
   for `scripts/vacuity-baseline.txt`'s header. Nothing for `LEDGER.md` (rows are regraded at the milestone's filing).
6. The report, in standing rule 11's form. Stopping at a saved stage with leaves left, and naming them, is a good report: a fifth implementer continues
   from your record if needed. Leaves have cost up to 100k tokens each here: save after each one.

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

