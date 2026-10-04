# Brief FS131-I3g — wave 3 of the Lean backlog, continued: the sector engine (`localSectors`) and the two `RingGerm` leaves on it, then the rest

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I3g
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow
  role: the seventh implementer on wave 3 — state and prove the sector structure at a point (`localSectors`) as wave 3's plan specifies it, prove `four_of_bothKind` and `flank_edge_exists` on it, then any of the two `SixFragment` leaves your context allows; the gate and the landing when the last leaf is proved
  launch: now, beside FS131-I2g, FS131-I4b and FS131-IW (implementers) and FS131-E2 (a deriver, no Lean), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I3g.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I3-implementation.md` (on branch `fs131-w3`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w3` (branch `fs131-w3`): the nine wave-3 modules (`Proofs/HadwigerNelson/Plane/LocalMap.lean`, `LocalMapExamples.lean`, `CircleColouring.lean`, `LocalStructure.lean`, `SixFragment.lean`, `Tiles.lean`, `RingGerm.lean`, `Lens.lean`, `RingBand.lean` — supporting lemmas only in the three foundation ones), supporting lemmas in the foundation modules the handoff names (`Proofs/HadwigerNelson/Plane/ArcMap.lean`, `UnitPairs.lean`, `Basic.lean`, `Chord.lean`, `DensityPoints.lean`), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 3's carriers only, last — § The vacuity step), `plans/FS131-I3-implementation.md`, `tools/fs131_i3_*.py`, `data/fs131/i3/`, `data/fs131/reports/FS131-I3g.md`; and, at the landing only, `main` by fast-forward
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are the seventh implementer on wave 3, which is four leaves from landing. Six Sonnet implementers before you (de Bruijn like you) proved
92 of its 96 leaves on the standard three axioms. FS131-I3f, the sixth, proved `sixCol_locallyConstant` and the rotation lemmas, and wrote routes for the
four that remain (its record's Stage 6). Two of them, `four_of_bothKind` and `flank_edge_exists` in `Plane/RingGerm`, each need a sector engine — the local
structure of the map's arcs around one point — and wave 4's implementer, running now, needs the same engine for six of its own leaves. So you build that
engine once, as wave 3's plan specified it, and prove the two `RingGerm` leaves on it. The other two leaves, `sixFrag_valid` and `sixFrag_nonSiamese` in
`Plane/SixFragment`, are long explicit geometry with routes ready; take them if your context allows, else a successor will.

## Why this job

A wave counts as held only when its declarations pass the full gate and their axioms are read from the gate's saved log (the milestone's announcement
rule, `plans/FS131-close-inventory.md`). The sector engine is the one piece two waves wait on.

## The statements

The leaves are the four `sorry` declarations on branch `fs131-w3` at `5537611a`, read back against their rows in
`.claude/worktrees/fs131-w3/plans/FS131-w3-kernel-plan.md` § 5.2, with the plan in § 6. The engine you state first, as the plan specifies it:

> 3. **The sector structure at a point** (`Plane/LocalStructure`, child `localSectors`): for `x ∈ dom` there are `r > 0` and finitely many
> — source: .claude/worktrees/fs131-w3/plans/FS131-w3-kernel-plan.md § 6.1 What the pass found: three statements from which most leaves derive

(the item continues there for several lines: the branches, the open sectors between them, and the corollaries it was planned to give —
`finite_tiles_near`, which I3e has since proved another way, `coneAt_region_eq_biUnion`, `Simple.coneAt_eq_angleIcc`, `germ_dichotomy` and
`flank_edge_exists`). State it as a lemma in `Plane/LocalStructure` with its `scripts/Axioms.lean` record. I3e's `GoodAt` machinery (the record's Stage 5:
a good radius about `x`, every arc through `x` on a full line or circle `curveAt x κ b`, distinct curves meeting only at `x`) is the natural base for its
proof. If the plan's statement turns out wrong or needs design to state (I3e's route suggests a different shape may serve better), message me before
writing a different one: wave 4 will build on whatever you state. The rule that governs the rest:

> **It may**: add lemmas (children) anywhere in the wave's modules — the three engines (`Valid.dist_lt_or_gt_of_isPreconnected`, `mem_closure_tile`,
> — source: .claude/worktrees/fs131-w3/plans/FS131-w3-kernel-plan.md § 7.2 What the implementer may and may not change

I3f's routes for the four leaves are in its record:

> **Readback.** Both brief quotations match their sources (plan § 7.2 "It may: add lemmas..."; this record's Stage 5 "9 sorry declarations at the start, 5 now"). The branch was `4f7b949d`; it builds
> — source: .claude/worktrees/fs131-w3/plans/FS131-I3-implementation.md ## Stage 6 — SAVED (FS131-I3f): readback; `sixCol_locallyConstant` proved; rotation lemmas; routes for the other four

Two statements carry coordinator rulings: `hz : z ∈ F.dom` in FS116-V5-U1's last clauses (item 39), and item 112's — `four_of_bothKind`'s `hint` takes
`β₁ < β₂`, and `four_of_bothKind_simple` takes `hnc`, no cusp at `z`. A deriver (FS131-E2) is working on whether the cusp case holds anyway; it does not
change your statements. `four_of_bothKind` also needs `c ≠ c′`, which I3f reads off the two cone inclusions of `IsRingArc`, and a disjoint-interiors lemma
for distinct tiles' cones at a point — the engine should give it.

## Done means

1. **Your readback first**: check the three quotations against their sources; confirm the branch builds as I3f left it (`5537611a`, one build under the
   slot); restate what you may and may not change. Commit and push.
2. **`localSectors` stated and proved** in `Plane/LocalStructure`; then message me the commit at once, so wave 4's implementer can iterate against it.
3. **`four_of_bothKind` and `flank_edge_exists` proved**, then `sixFrag_valid` and `sixFrag_nonSiamese` as far as your context goes (I3f's Stage 6 routes;
   `nlinarith` failed on the QQ pair and on the sector cross lemma, and `tools/fs131_i3_cert.py` found no certificate at product degree 3 — those need
   squares or a hand derivation). No statement changed, no new `axiom`, no `native_decide`. I3f's slip: `LocalStructure`'s module docstring (line 32)
   still says "Every leaf is sorry" — fix it with your `localSectors` edit, since that rebuilds the dependents anyway.
4. **When the last leaf is proved, the full gate green on one commit in the worktree**: the build with zero warnings; `scripts/axioms.sh` clean, every wave-3 record on the standard
   three axioms or fewer; `scripts/vacuity.sh` and `--self-test` green with wave 3's carriers registered (§ The vacuity step); `tools/check_architecture.py`
   exit 0; each check's negative control watched going red. Read the saved logs under the worktree's `build/gate/`, not the line that says a gate passed.
5. **The landing** (§ 7.3): merge `main` into `fs131-w3`, keep both sides of the append-only lines, re-run the gate, fast-forward `main` to the branch,
   push. If `main` has moved by then, merge once more and re-run; never force-push.
6. **Your record**, `plans/FS131-I3-implementation.md` on the branch, in stages headed "Stage n — SAVED", with "Theorems this phase proved": one line per
   row theorem — its declaration, its axioms from the saved audit log, the row it was read against.
7. **Drafts for the front page** in your record (`## Drafts for the front page`): the gate's new counts for `CLAUDE.md` § The gate and § Trust ledger and
   for `scripts/vacuity-baseline.txt`'s header. Nothing for `LEDGER.md` (rows are regraded at the milestone's filing).
8. The report, in standing rule 11's form. Stopping at a saved stage with leaves left, and naming them, is a good report: an eighth implementer continues
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

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).
