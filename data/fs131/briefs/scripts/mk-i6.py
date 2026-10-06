exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import sys
LANE=sys.argv[1]  # A (Pinch) or B (MapColouring)
T={"A":("fs131-w6p","FS131-I6A","`Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean` (seven leaves: `pinch_not_in_in`, `pinch`, `TwoColourOn.essBoundary_inter_eq`, `c11_discs`, `c11_split`, `half_upperDensity`, `sq9_isTangentAt`)","the pinch at a two-colour point and its first consequences","Pinch"),
   "B":("fs131-w6m","FS131-I6B","`Proofs/HadwigerNelson/Plane/Saturated/MapColouring.lean` (one leaf, `sat_inP`, and the Lean model its hypotheses owe: `sq9` as an `ArcMap 9`)","a saturated map colouring's regions, and the model the statement owes","MapColouring")}[LANE]
TREE,JOB,FILES,WHAT,MOD=T
W=WT+TREE+"/"; K6=W+"plans/FS131-w6-kernel-plan.md"
V=W+"Proofs/HadwigerNelson/Plane/Saturated/"
if LANE=="A":
    STMTS="\n".join(Q(V+"Pinch.lean",p) for p in ["theorem pinch_not_in_in ","theorem pinch ","theorem TwoColourOn.essBoundary_inter_eq ","theorem c11_discs ","theorem c11_split ","theorem half_upperDensity ","theorem sq9_isTangentAt :"])+"\n"
    PLAN="\n".join([Q(K6,"## Stage 9 — SAVED: the foundation restated over two sets and a family"),Q(K6,"### 9.2 The leaves restated, each against its row"),
          Q(K6,"### 9.4 The plan per leaf, where it changed"),Q(K6,"## Stage 5 — SAVED: the plan per leaf")])+"\n"
    ORDER="the order the plans give — `pinch_not_in_in` first (`pinch` uses it), `pinch`, `TwoColourOn.essBoundary_inter_eq`, `c11_discs`, `c11_split`; `half_upperDensity` and `sq9_isTangentAt` are independent of the rest"
    EXTRA="When `sq9_isTangentAt` is proved, `half_upperDensity` and `pinch` have their Lean model (`sq9` at `sqEdgePt`): say so in each docstring, in `LEAN.md` § The gate's form (a docstring line is not a statement change; your statement check says which lines it allows)."
    NLEAF="eight `sorry` leaves over the two files: seven yours, one the other implementer's"
else:
    STMTS=Q(V+"MapColouring.lean","theorem sat_inP ")+"\n"
    PLAN="\n".join([Q(K6,"## Stage 5 — SAVED: the plan per leaf"),Q(K6,"| `sat_inP` | "),Q(K6,"### 7.1 For wave 6's implementer"),
          Q(K6,"- **Inhabitants owed with the leaves**:")])+"\n"
    ORDER="the plan's children (S1), (S3) and what it names after them, then the model"
    EXTRA="**The model is part of done**: `sq9` as an `ArcMap 9` (the grid lines as segments, each region the interior of a class), satisfying every hypothesis of `sat_inP` at once, as a named theorem in your file or a new module beside it, with `sat_inP`'s docstring naming it (`LEAN.md` § The gate, the inhabitant rule). If the model is larger than the leaf, say so at your first saved stage: it can be split off."
    NLEAF="eight `sorry` leaves over the two files: one yours, seven the other implementer's"
b=f'''# Brief {JOB} — wave 6, {WHAT}: the open leaves of `{MOD}`, on `{TREE}`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: one of wave 6's first two implementers, split by file — prove the open leaves of {FILES} from the planners' plans, without changing a statement, saving after each leaf or group
  launch: when a slot frees, on a branch cut from the commit at which the wave's second planner fixed these statements; that planner (FS131-K6b) is still working on `fs131-w6`, adding modules downstream of yours
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me, and the planner is building on these statements now), a definition in `Basic` you need changed or a lemma you need exported from it, or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from `fs131-w6` at `3928644b`): {FILES} — proofs, and new helper declarations under names no other module declares (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name); a new module of your own beside it if the helpers want one, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (a block of your own, headed "{JOB}", above the `=== PURCHASED ===` banner), `plans/{JOB}-implementation.md`, `tools/fs131_i6{LANE.lower()}_*.py`, `data/fs131/i6{LANE.lower()}/`, `data/fs131/reports/{JOB}.md`; **not** `Proofs/HadwigerNelson/Plane/Saturated/Basic.lean` (the planner and the other implementer both read it: a need there is a message), the wave's other file, the planners' record, any landed module beyond new declarations, `main`
  budget: {BUDGET}

Hello. You are proving the first leaves of wave 6 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 6 is about *saturated* colourings — measurable colourings whose classes are carved by unit
circles about their own points — and its first theorem is the pinch: where exactly two colours meet and each has a point of its own class at
distance 1, the two contacts are one point or antipodal, and the interface there is a unit arc or lies between two tangent unit discs. Two
planners have laid the wave's foundation; the second restated every predicate this morning over two sets on an open set, which is the class the
argument reads, and fixed the statements at the commit your branch is cut from. Nothing is proved over them yet. This file is yours.

## Why this job

A result counts as held only when its Lean module passes the gate. Everything else in the wave — the fan at a singular point, the ladder, the
fragment — reads these leaves, and a deriver's argument filed today (the bridge from "the singular set is locally finite" to the fan) applies the
pinch at every point of one neighbourhood, which is why its statement was widened. Kooshi, on pricing this work:

{KOOSHI}
What the planners handed back and the rulings in force (read each item whole in the inventory):

{item(486)}
{item(495)}
{item(490)}
## The statements

No statement changes in this job. Your leaves, as they stand in your tree (read each whole, with its docstring):

{STMTS}The plans (the planners' record, `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/plans/FS131-w6-kernel-plan.md`: read Stages 3, 5, 7 and 9
whole — the second planner's § 9.4 changes the first's § 5 where the statements changed, and § 9.1 says what each predicate is and why):

{PLAN}## Done means

1. **Your readback first**: check the quotations against their sources; read the planners' record (Stages 1–9), `Basic` whole and your file,
   and your rows' derivation entries at the addresses the record's § 2 gives (`plans/FS111-M-regularity.md` §§ 2.1, 3.1–3.6 for the pinch).
   Build the branch once as given ({NLEAF}). Open your record with what you may and may not change. Commit and push.
2. **The leaves**, in {ORDER}; saving after each leaf or group (a build, the axioms print for it with a control that fires, a statement check
   against `3928644b`, commit, push). Re-price after your first two leaves and say so: the first planner expects its prices to be high by a
   factor of two to three.
3. {EXTRA}
4. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge
   another branch, run the gate, or touch `main`. Leave no background process running, and keep what your record cites under your `data/`
   folder.
5. **Your record**, stages headed "Stage n — SAVED ({JOB})", "Theorems this phase proved", each read against its row; the report in standing
   rule 11's form, ending with what is left and its route. Stopping at a saved stage with part of the leaves proved is a good report.

## What is yours to decide

The route inside each leaf, your helpers and where they live, and the order within the plans' dependencies. The plans are two minds' on paper,
written before any of these proofs existed; change a route that does not go and say so. A statement is not yours to change: one that is false,
or true only with a hypothesis the plan did not see, is a message to me, and a finding — the second planner's mutation audit (its § 9.2) says
which hypotheses it believes each statement needs, and a proof that never reads one of them is worth a line in your report. Three failed attempts
on one route is a dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-wave6.md","w").write(b)
print("written",JOB)
