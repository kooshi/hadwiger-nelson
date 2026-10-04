# Brief FS131-I3b — wave 3 of the Lean backlog, continued: the 41 `sorry` leaves FS131-I3 left on branch `fs131-w3`, the gate, the landing

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I3b
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow
  role: the successor of FS131-I3 — prove the 41 leaves it left (the sector-structure engine among them), run the full gate, and land wave 3 on `main`
  launch: now, beside the day's Searcher (small) and FS131-I2c (wave 2's third implementer, in its own worktree)
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I3b.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I3-implementation.md` (on branch `fs131-w3`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w3` (branch `fs131-w3`): the nine wave-3 modules (`Proofs/HadwigerNelson/Plane/LocalMap.lean`, `LocalMapExamples.lean`, `CircleColouring.lean`, `LocalStructure.lean`, `SixFragment.lean`, `Tiles.lean`, `RingGerm.lean`, `Lens.lean`, `RingBand.lean` — supporting lemmas only in the three foundation ones), supporting lemmas in the foundation modules the handoff names (`Proofs/HadwigerNelson/Plane/ArcMap.lean`, `UnitPairs.lean`, `Basic.lean`, `Chord.lean`, `DensityPoints.lean`), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 3's carriers only, last — § The vacuity step), `plans/FS131-I3-implementation.md`, `tools/fs131_i3_*.py`, `data/fs131/i3/`, `data/fs131/reports/FS131-I3b.md`; and, at the landing only, `main` by fast-forward
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are picking up wave 3's proofs from a colleague who ran out of room. FS131-I3 (de Bruijn on Sonnet, like you) proved 55 of the 96 leaves with no statement changed — `Plane/Tiles` complete, nine rows sorry-free, engines 1 and 2 built — and handed back at its context line with the 41 left grouped by what they need, an iteration recipe, and a re-pricing. Its record is your handoff; its last build of the branch is green (440/440, `data/fs131/i3/build-stage1.log` on the branch, ending "build: OK"). The rest of this letter is the original brief, kept for the whole picture: you are building wave 3 of the milestone that turns this project's hand-derived results into kernel-checked ones. Wave 1 landed earlier today
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

> | `LocalStructure` (5) | `finite_tiles_near`, `mem_coloursAt_iff_exists_tileOf`, `coneAt_region_eq_biUnion`, `germ_dichotomy`, `Simple.coneAt_eq_angleIcc` | engine 3 (`localSectors`) for the first, third, fifth; `germ_dichotomy` is M without it (finitely many arcs meet `ω(p)` off the ring arcs: `Arc.finite_inter_sphere_or_eq_circ`; a short germ avoids them; the ring-arc case needs a strip free of `Γ`, by compactness of a closed sub-arc) |
> — source: .claude/worktrees/fs131-w3/plans/FS131-I3-implementation.md § Open: the 41 leaves, grouped by what they need

(the table continues with `SixFragment` 11, `RingGerm` 11, `Lens` 2, `RingBand` 12). Engine 3, `localSectors`, is the one hard piece the five `LocalStructure` leaves, `flank_edge_exists` and `four_of_bothKind` wait on; `RingBand`, `Lens`, `SixFragment` and most of `RingGerm` do not. Read §§ 7.1–7.3 in full first: the worktree, the build, what you may and may not change (no statement of § 5, no definition of `Plane/LocalMap`,
`Plane/CircleColouring` or `Plane/SixFragment`), and how the wave lands. One statement already carries a correction the coordinator accepted:
`hz : z ∈ F.dom` in FS116-V5-U1's last clauses (inventory item 39).

## Done means

1. **Your readback first**: check both quotations against their sources; confirm the branch is as I3 left it (`8a850e85`); restate what you may and may
   not change. Then every one of the 41 remaining leaves proved, no statement changed, no new `axiom`, no `native_decide`.
2. **The full gate green on one commit in the worktree**: the build with zero warnings; `scripts/axioms.sh` clean, every wave-3 record on the standard
   three axioms or fewer; `scripts/vacuity.sh` and `--self-test` green with wave 3's carriers registered (§ The vacuity step); `tools/check_architecture.py`
   exit 0; each check's negative control watched going red. Read the saved logs under the worktree's `build/gate/`, not the line that says a gate passed.
3. **The landing** (§ 7.3): merge `main` into `fs131-w3`, keep both sides of the append-only lines, re-run the gate, fast-forward `main` to the branch,
   push. If `main` has moved by then, merge once more and re-run; never force-push.
4. **Your record**, `plans/FS131-I3-implementation.md` on the branch, in stages headed "Stage n — SAVED", with "Theorems this phase proved": one line per
   row theorem — its declaration, its axioms from the saved audit log, the row it was read against.
5. **Drafts for the front page** in your record (`## Drafts for the front page`): the gate's new counts for `CLAUDE.md` § The gate and § Trust ledger and
   for `scripts/vacuity-baseline.txt`'s header. Nothing for `LEDGER.md` (rows are regraded at the milestone's filing).
6. The report, in standing rule 11's form. Stopping at a saved stage with leaves left, and naming them, is a good report: a third implementer continues
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

