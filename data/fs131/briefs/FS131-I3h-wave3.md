# Brief FS131-I3h — wave 3 of the Lean backlog: its last two leaves, the gate, the landing; then the sector structure

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I3h
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the eighth implementer on wave 3 — prove `sixFrag_valid` and `sixFrag_nonSiamese`, run the full gate, land wave 3 on `main`; then, on a fresh branch from the landed `main`, state and prove `localSectors` in branch form and the separation lemma
  launch: now, beside FS131-I2g and FS131-IW (implementers) and FS131-LEB (Lebesgue's covering theorem, about to land on `main`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I3h.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I3-implementation.md` (on branch `fs131-w3`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w3` (branch `fs131-w3`): the nine wave-3 modules (`Proofs/HadwigerNelson/Plane/LocalMap.lean`, `LocalMapExamples.lean`, `CircleColouring.lean`, `LocalStructure.lean`, `SixFragment.lean`, `Tiles.lean`, `RingGerm.lean`, `Lens.lean`, `RingBand.lean` — supporting lemmas only in the three foundation ones), supporting lemmas in the foundation modules the handoff names (`Proofs/HadwigerNelson/Plane/ArcMap.lean`, `UnitPairs.lean`, `Basic.lean`, `Chord.lean`, `DensityPoints.lean`), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (wave 3's carriers only, last — § The vacuity step), `plans/FS131-I3-implementation.md`, `tools/fs131_i3_*.py`, `data/fs131/i3/`, and after the landing a worktree `.claude/worktrees/fs131-w3b` on a new branch `fs131-w3b` from `main` (make it with the recipe in § The machine) for `localSectors`, `data/fs131/reports/FS131-I3h.md`; and, at the landing only, `main` by fast-forward
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are the eighth implementer on wave 3, and the first on Opus: Kooshi moved every implementer to Opus after a trial (inventory items 129 and
137). Wave 3 is two leaves from landing. Seven Sonnet implementers before you proved 94 of its 96 leaves; the seventh, FS131-I3g, proved
`four_of_bothKind` and `flank_edge_exists` on an inversion-coordinates engine it made public at the end of `Plane/LocalStructure`. What is left are two long
explicit geometry leaves about the six-colour fragment, `sixFrag_valid` and `sixFrag_nonSiamese` in `Plane/SixFragment`, with routes written by FS131-I3f.
Then the gate and the landing — wave 3 would be the second wave held in the kernel. After that, wave 4 needs the sector structure at a point
(`localSectors`), which you build on a fresh branch from the landed `main`.

## Why this job

A wave counts as held only when its declarations pass the full gate and their axioms are read from the gate's saved log (the milestone's announcement
rule, `plans/FS131-close-inventory.md`). About twenty of wave 4's remaining leaves wait on `localSectors`.

## The statements

The leaves are the two `sorry` declarations on branch `fs131-w3` at `93ca3468`, read back against FS116-Y2-SIXFRAG in `.claude/worktrees/fs131-w3/plans/FS131-w3-kernel-plan.md` § 5.2. The rule that governs
them:

> **It may**: add lemmas (children) anywhere in the wave's modules — the three engines (`Valid.dist_lt_or_gt_of_isPreconnected`, `mem_closure_tile`,
> — source: .claude/worktrees/fs131-w3/plans/FS131-w3-kernel-plan.md § 7.2 What the implementer may and may not change

I3f's routes for the two are its record's Stage 6, which opens:

> **Readback.** Both brief quotations match their sources (plan § 7.2 "It may: add lemmas..."; this record's Stage 5 "9 sorry declarations at the start, 5 now"). The branch was `4f7b949d`; it builds
> — source: .claude/worktrees/fs131-w3/plans/FS131-I3-implementation.md ## Stage 6 — SAVED (FS131-I3f): readback; `sixCol_locallyConstant` proved; rotation lemmas; routes for the other four

(the stage continues with the route for each: for `sixFrag_valid`, rotate to colour 0, classify interior points into S, Q and G, and prove six pair
bounds, the QQ pair the hard one, by a corner reduction in `r` and an angle identity — `nlinarith` failed on it and `tools/fs131_i3_cert.py` found no
certificate at product degree 3, so it needs squares or a hand derivation; for `sixFrag_nonSiamese`, pieces that are the rotated colour-0 pieces, open,
connected — I3e's correction: S_0, Q_4 and G_2, cut at 3/2, must each be shown connected — and inside `interiorPts`, with an explicit far pair between
tiles in different pieces). I3g's state, its Stage 7:

> **Readback.** The three brief quotations match their sources (plan § 6.1 item 3; plan § 7.2 "It may"; Stage 6 above). The branch was `5537611a`; it builds (`build/gate/build/20261004T120117Z-3341389.log`: "build: OK", 2 modules with warnings, 4 `sorry`).
> — source: .claude/worktrees/fs131-w3/plans/FS131-I3-implementation.md ## Stage 7 — SAVED (FS131-I3g): readback; the inversion engine; `four_of_bothKind` and `flank_edge_exists` proved; 2 leaves left

**After the landing**, the sector structure, in the form wave 4 asked for (inventory item 136): for `v ∈ dom`, some `r₀` and a finite list of branch germs —
each a tangent direction and a signed curvature (0 for a segment) — whose union is the arcs in `ball v r₀`; for `r < r₀` the sectors are exactly the regions
between consecutive branches, finite and constant in number; each sector's cone an angle interval. Beside it the separation lemma from FS131-E2's record
(`plans/FS131-E2-derivation.md` § 2.7, `Simple.coneAt_eq_angleIcc_sep`), and, with it, `four_of_bothKind_simple` restored to its `05cb0a3e` statement
(no `hnc`) by that record's § 2.4 route (item 139). I3g's Stage 7 gives the branches in closed form and the route. State `localSectors` in wave 3's
vocabulary; the bridge to wave 4's `IsSector` and `hornSet` is wave 4's.

## Done means

1. **Your readback first**: check the three quotations against their sources; confirm the branch builds as I3g left it (`93ca3468`, one build under the
   slot; exactly two `sorry` warnings); restate what you may and may not change. Commit and push.
2. **`sixFrag_valid` and `sixFrag_nonSiamese` proved**, no statement changed, no new `axiom`, no `native_decide`; save after each.
3. **The gate, then the landing**, as below (items 4–7 of this list); before the gate on the merged branch, run `tools/fs131_qa1_dupes.py` (item 142) —
   wave 3 lands first, so the other branches rename against you, but report what it finds.
4. **The full gate green on one commit in the worktree**: the build with zero warnings; `scripts/axioms.sh` clean, every wave-3 record on the standard
   three axioms or fewer; `scripts/vacuity.sh` and `--self-test` green with wave 3's carriers registered (§ The vacuity step); `tools/check_architecture.py`
   exit 0; each check's negative control watched going red. Read the saved logs under the worktree's `build/gate/`, not the line that says a gate passed.
5. **The landing** (§ 7.3): merge `main` into `fs131-w3`, keep both sides of the append-only lines, re-run the gate, fast-forward `main` to the branch,
   push. If `main` has moved by then, merge once more and re-run; never force-push.
6. **Your record**, `plans/FS131-I3-implementation.md` on the branch, in stages headed "Stage n — SAVED", with "Theorems this phase proved": one line per
   row theorem — its declaration, its axioms from the saved audit log, the row it was read against.
7. **Drafts for the front page** in your record (`## Drafts for the front page`): the gate's new counts for `CLAUDE.md` § The gate and § Trust ledger and
   for `scripts/vacuity-baseline.txt`'s header. Nothing for `LEDGER.md` (rows are regraded at the milestone's filing).
8. **Then `localSectors` and the separation lemma** on `fs131-w3b` from the landed `main`, built and committed, with `scripts/Axioms.lean` records; message me
   the commit at once (wave 4's next implementer will build on it), and land that branch too by the same gate if you get that far.
9. The report, in standing rule 11's form. Stopping at a saved stage with leaves left, and naming them, is a good report: a ninth implementer continues
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

**The worktree for `fs131-w3b`**, after the landing: `git worktree add -b fs131-w3b .claude/worktrees/fs131-w3b main` from the main tree; then
`mkdir -p .claude/worktrees/fs131-w3b/.lake`, `ln -s /home/kooshi/source/lean-dir/.lake/packages .claude/worktrees/fs131-w3b/.lake/packages`, and
`cp -a .claude/worktrees/fs131-w3/.lake/build .claude/worktrees/fs131-w3b/.lake/build` (the landed tree's build, nearly current; never a symlink).
