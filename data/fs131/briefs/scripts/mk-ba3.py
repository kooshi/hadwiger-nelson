exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
Z=WT+"fs131-w5z/"
V=Z+"Proofs/HadwigerNelson/Plane/ValidMap/"
BG=V+"BendGap.lean"; HC=V+"HornChart.lean"; BC=V+"BendCollar.lean"
RB=Z+"plans/FS131-BA2-implementation.md"
b=f'''# Brief FS131-BA3 — the outward bend's last two children on `fs131-w5z`: `CollarFitOut.map_R1` and `map_R2`, the mirrors of the toward bend's unit-arc clauses

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-BA3
  identity: {IDENT}
  role: FS131-BA2's successor — first three ruled removals of unread hypotheses in this lane's own files, then the two children left under the outward bend, `CollarFitOut.map_R1` and `CollarFitOut.map_R2`, by mirroring the toward bend's proofs as BA2's record lays out; with them `bend_away_part` is whole
  launch: now, in the tree FS131-BA2 has handed back, beside FS131-M7 (the join of wave 5's lines, on `fs131-w5c`) and FS131-KM1 (the example maps' planner, on `fs131-wm`)
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a clause of `map_R1` or `map_R2` that is false for the outward lens (at once, with the configuration: the planner's hand check of R1 at a pinch is one mind's), a private helper of the toward bend's modules you cannot reach by a new declaration, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-BA3.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/FS131-BA2-implementation.md` (on branch `fs131-w5z`; BA2's record, your stages from 5, headed FS131-BA3)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5z` (branch `fs131-w5z`, at `dae3d93e`): `Proofs/HadwigerNelson/Plane/ValidMap/BendGap.lean` and `Proofs/HadwigerNelson/Plane/ValidMap/HornChart.lean`; new helpers as new declarations in `BendGap` (a `private` helper of `BendCollar` or `CollarMap` that a mirror needs is re-proved there or made public by a new declaration — ruling 421 (c)); `scripts/Axioms.lean` (a block of your own, headed "FS131-BA3", above the `=== PURCHASED ===` banner), `plans/FS131-BA2-implementation.md`, `tools/fs131_ba3_*.py`, `data/fs131/ba3/`, `data/fs131/reports/FS131-BA3.md`; **not** `BendStep.lean` (its horn child keeps `hF` until a later pass, because its callers live on another branch), the other half's three modules, the toward bend's modules beyond new declarations, `Procedure.lean`, `main`
  budget: {BUDGET}

Hello. You are closing the last construction on wave 5's path in the Lean backlog. The milestone, FS-131, turns this project's hand-derived results
into kernel-checked ones. Wave 5's arc step needed one bend that was proved nowhere, the bend of a unit arc away from its centre. In a day it was
stated, planned as 36 children, and 34 of them proved by two implementers — the piece of new mathematics among them. Two are left, both mirrors of
proofs the toward bend already has: the outward bent map creates no constant-sided unit arc (R1) and keeps the ones off the bent arc (R2). When they
close, `bend_away_part` and everything above it in wave 5 rests on no open leaf of the bend's.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). The arc
step is proved over this bend on a sibling branch that is being joined to wave 5's trunk now; these two children are the last open leaves the
landing waits on. Kooshi, on pricing this work:

{KOOSHI}
What the last jobs handed back, and the rulings in force:

{item(456)}
{item(457)}
{item(454)}
{item(445)}
## The statements

The two children (`sorry`; read each whole with its docstring), and the toward bend's proofs they mirror:

{Q(BG,"theorem CollarFitOut.map_R1 ")}
{Q(BG,"theorem CollarFitOut.map_R2 ")}
{Q(BC,"theorem CollarFit.map_R1 ")}
{Q(BC,"theorem CollarFit.map_R2 ")}
BA2's route for them (read § 4 whole; § 4.6 is your work list):

{Q(RB,"### 4.6 ")}
The three statements that lose a hypothesis their proofs do not read (ruling 457 (b)):

{Q(HC,"theorem hasHornCount_zero_of_two_spheres ")}
{Q(HC,"theorem hasHornCount_iff_of_germ_swap ")}
{Q(BG,"theorem CollarFitOut.map_hornCount_le ")}
## Done means

1. **Your readback first**: check every quotation above against its source; read BA2's record whole, BA1's record § 4
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/plans/FS131-BA1-implementation.md`; its files are merged into your tree), the
   planner's § 2.1 on R1 at a pinch (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/plans/FS131-bendaway-kernel-plan.md`), and
   `BendCollar`'s `exists_one_side`, `sides_end`, `sides_eq`, `map_R1`, `map_R2`, `map_R3`. Build the branch once as given (expect it up to date: 5
   distinct `sorry` warnings, two of them in `BendGap`). Open your stages in the record with what you may and may not change. Commit and push.
2. **Three ruled removals, one stage**: `hρ` and `hρ'` out of `hasHornCount_zero_of_two_spheres`, `hκ` out of `hasHornCount_iff_of_germ_swap`,
   `hF` out of `CollarFitOut.map_hornCount_le` — each with its calls, all inside `HornChart` and `BendGap` (if a call sits elsewhere, stop and
   message me). Check by script that exactly these three statements changed and nothing else; build; commit.
3. **The two mirrors**, by BA2's § 4.6: `exists_one_side` for the outward fit, the closed lens, `sides_end`, `sides_eq`, then `map_R1` and
   `map_R2`. Save after the helpers and after each of the two (a build, the axioms print, the statement check, commit, push). The collar is the
   toward bend's own set, so the frame and side lemmas apply as they stand; the lens is on the other side of the circle and holds the inner colour,
   which is where a mirror is not a flipped inequality — BA1 met one such step (its record § 3.1).
4. **The receipt**: with both proved, an axioms print in which `CollarFitOut.awayBend`, `bend_away_gap`, `bend_away_subdiv`, `bend_away_part` are
   on the standard three, with a control that fires; the build's `sorry` warnings — expect none in the bend's seven modules (the three left,
   `Procedure` 2 and `Terminal` 1, are this branch's old copies of files proved on another branch).
5. No statement or definition changed anywhere beyond the three ruled ones; no new `axiom`, no `native_decide`. Do not edit a file while a build of
   it runs. You do not merge another branch into this one, run the gate, or touch `main`. Leave no background process running, and keep what your
   record cites under `data/fs131/ba3/`.
6. **Your record**, stages headed "Stage n — SAVED (FS131-BA3)", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a
   saved stage with one mirror proved is a good report.

## What is yours to decide

The route inside each mirror, your helpers, and whether the two share a lemma the toward bend proved twice. BA2's work list is one mind's, written
at the end of a long session and never elaborated; where it is wrong, change it and say so. A child's statement is not yours to change: if R1 or R2
is false for the outward lens, that is a message to me with the configuration, and a finding. Three failed attempts on one route is a dispatch to
the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/FS131-BA3-bend-away-mirrors.md","w").write(b)
