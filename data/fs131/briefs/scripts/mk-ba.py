exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import sys
LANE=sys.argv[1]            # "1" or "2"
TREE={"1":"fs131-w5a","2":"fs131-w5z"}[LANE]
OTHER={"1":"FS131-BA2 (the other half, on `fs131-w5z`)","2":"FS131-BA1 (the other half, on `fs131-w5a`)"}[LANE]
A=WT+TREE+"/"
V=A+"Proofs/HadwigerNelson/Plane/ValidMap/"
KP=A+"plans/FS131-bendaway-kernel-plan.md"
BS=V+"BendStep.lean"
Y=WT+"fs131-w5y/"
if LANE=="1":
    JOB="FS131-BA1"; SLUG="FS131-BA1-bend-away-lens.md"
    TITLE="the outward collar bend, its lens and its composition: lanes G and D of FS131-KA1's plan, on `fs131-w5a`"
    FILES="`Proofs/HadwigerNelson/Plane/ValidMap/LensOut.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/CollarMapOut.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BendAway.lean`, and one line of `Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean` (the call of `AwayBend.idle` in `bend_away_subdiv`, for the ruled change below)"
    NOT="`R2Cap.lean`, `HornChart.lean`, `BendGap.lean` and the rest of `BendStep.lean` (FS131-BA2's, on `fs131-w5z`)"
    ROLE="implementer 1 of the outward bend — the outward push and its lens (`LensOut`), the bent map (`CollarMapOut`), and the clause package with its composition (`BendAway`): lanes G and D of the planner's handoff, in its order, saving after each group"
    STMTS=f'''{Q(V+"LensOut.lean","noncomputable def pushOutHomeo ")}
{Q(V+"LensOut.lean","theorem dist_lt_one_of_thin ")}
{Q(V+"CollarMapOut.lean","structure CollarFitOut ")}
{Q(V+"CollarMapOut.lean","theorem CollarFitOut.map_valid ")}
{Q(V+"BendAway.lean","structure AwayBend ")}
{Q(V+"BendAway.lean","theorem AwayBend.idle ")}
{Q(V+"BendAway.lean","theorem LocalStep.of_cutArcs ")}'''
    EXTRA=f'''2. **One ruled statement change, first** (inventory item 446 (b)): `AwayBend.idle` loses `hA` and `hε`, which its proof will not read; change it
   and its one call in `BendStep`'s `bend_away_subdiv`, check by script that nothing else changed, build, commit.
3. **Lane G, then lane D**, in the planner's order (§ 3.6: G1, G2, G4 — independent; G3; G5–G7; then D1–D6), saving after each group (a build,
   the axioms print for the group, the statement check, commit, push). Re-price after G1 and G4 and say so in your record.
4. **`LocalStep.of_cutArcs` (D5) is already proved** — by FS131-IA2, with this exact signature, in
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/Proofs/HadwigerNelson/Plane/ValidMap/ArcStep.lean` (l. 584 on; branch `fs131-w5y` at
   `3f8270c0`). Copy that proof into `BendAway` (with any helper it uses, as new declarations there), credit it in the docstring, and do not
   re-derive it. At the final sync the copy in `ArcStep` is deleted.'''
else:
    JOB="FS131-BA2"; SLUG="FS131-BA2-bend-away-gap.md"
    TITLE="the outward collar bend, its clearance, its charts and its horn count: lanes C and H of FS131-KA1's plan, on `fs131-w5z`"
    FILES="`Proofs/HadwigerNelson/Plane/ValidMap/R2Cap.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/HornChart.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BendGap.lean`, and in `Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean` the one child `CollarFit.map_hornCount_le`"
    NOT="`LensOut.lean`, `CollarMapOut.lean`, `BendAway.lean` (FS131-BA1's, on `fs131-w5a`; you read their **statements**, which stand in your tree as `sorry`, so you wait for nothing) and the rest of `BendStep.lean`"
    ROLE="implementer 2 of the outward bend — the radius-2 crescent and the subdivision (`R2Cap`), the horn counts (`HornChart`, and the toward bend's open horn child), and the gap's bend with its one piece of new mathematics, the lens's clearance (`BendGap`): lanes C and H of the planner's handoff, in its order, saving after each group"
    STMTS=f'''{Q(V+"R2Cap.lean","theorem exists_r2_crescent_free ")}
{Q(V+"R2Cap.lean","theorem r2_side_dichotomy ")}
{Q(V+"BendGap.lean","theorem exists_lensOut_clear ")}
{Q(V+"BendGap.lean","theorem bend_away_gap ")}
{Q(V+"HornChart.lean","theorem hasHornCount_iff_of_germ_swap ")}
{Q(BS,"theorem CollarFit.map_hornCount_le ")}'''
    EXTRA=f'''2. **Lanes H and C**, in the planner's order (§ 3.6: H1, H2, C1 — independent; H3, H4, C2, C3; C4; C5–C9), saving after each group (a build,
   the axioms print for the group, the statement check, commit, push). Re-price after C1 and H3 and say so in your record.
3. **C4, `exists_lensOut_clear`, is the new mathematics**: its hand proof (the plan's § 2.5) is the planner's own derivation over FS131-E5's two
   lemmas, one mind, read by nobody else — you are its first check. If a step of it fails, stop that child, write the configuration, and message
   me at once: a deriver takes it. Do not weaken its statement to get past.
4. **The horn child of the toward bend**, `CollarFit.map_hornCount_le` (the plan's § 4): after lane H. Two proved theorems on the sibling branch
   `fs131-w5y` rest on it alone, and the arc step with them. One lemma there may save you work — W6, `exists_hasHornCount_isHorn_iff` ("the
   horn count exists, and a horn has its tip there iff the count is at least 1"), in
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/Proofs/HadwigerNelson/Plane/ValidMap/ArcStep.lean`; it is downstream of your modules,
   so you can read it and not import it: if you need it, restate it identically in `HornChart` with its proof copied and credited, and say so
   (the final sync keeps one).'''
b=f'''# Brief {JOB} — {TITLE}

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: {ROLE}
  launch: now, beside {OTHER} and FS131-IR3 (the vertex step's cases, on `fs131-w5c`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a child whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me, never made in place), a statement of the other half's that you need changed, a private helper of the toward bend's modules you cannot reach by a new declaration, or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`; a record of your own — the two halves append to no shared file — which opens by pointing at the planner's)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, at `dd8c2c33`): {FILES}; new helpers as new declarations in your own files (a `private` helper of `BendCollar` or `CollarMap` that a mirror needs is re-proved in the mirror's file or made public by a new declaration there — ruling 421 (c)); `scripts/Axioms.lean` (a block of your own, headed "{JOB}", above the `=== PURCHASED ===` banner), `plans/{JOB}-implementation.md`, `tools/fs131_ba{LANE}_*.py`, `data/fs131/ba{LANE}/`, `data/fs131/reports/{JOB}.md`; **not** {NOT}, `Procedure.lean`, `Terminal.lean`, the toward bend's modules beyond new declarations, `main`
  budget: {BUDGET}

Hello. You are building half of the last construction on wave 5's path in the Lean backlog. The milestone, FS-131, turns this project's hand-derived
results into kernel-checked ones. Wave 5's termination procedure bends a bad unit arc off its circle; the bend toward the centre is proved (the collar
bend), and the bend away from it was missing in a form the procedure can read. A planner, FS131-KA1, has just laid it out: the outward bend is the
toward bend on the same collar with a different lens, applied gap by gap between the points where the inner colour's class touches the circle of
radius 2, and composed. `bend_away_part` is proved from 36 children, each a `sorry` with a route and a price. Two implementers take them, split by
file so that neither waits on the other. You are one.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and
`exists_terminalMap` — every valid map of the plane has a terminal valid modification — now waits on this bend more than on anything else: the arc
step's assembly over it is already proved on a sibling branch. Kooshi, on pricing this work:

{KOOSHI}
The plan's hand-back and the rulings in force:

{item(445)}
{item(446)}
{item(444)}
{item(442)}
## The statements

No statement changes in this job{" but the one ruled below" if LANE=="1" else ""}. The bend, proved from its children, and the heads of your lanes (read each whole in its file; every child's
docstring states its route):

{Q(BS,"theorem bend_away_part ")}
{STMTS}
The plan: the modules, what is reused as it stands, the plan per child, and the handoff that splits the work (read §§ 2–3 whole{", and § 4 for the horn child" if LANE=="2" else ""}):

{Q(KP,"### 3.1 The modules")}
{Q(KP,"### 3.3 The plan per child")}
{Q(KP,"### 3.6 The handoff: two implementers, split by file")}
## Done means

1. **Your readback first**: check every quotation above against its source; read the planner's record whole and the modules you hold; the toward
   bend's four modules as far as your mirrors name them. Build the branch once as given (expect it up to date: 39 distinct `sorry` warnings). Open
   your record with what you may and may not change. Commit and push.
{EXTRA}
5. No statement or definition changed anywhere{" beyond the ruled one" if LANE=="1" else ""} (the planner's `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/tools/fs131_ka_stmt.py`, with `EDITABLE` extended to your files and the base
   moved to the skeleton's commit, is the check; watch a plant fire); no new `axiom`, no `native_decide`. Do not edit a file while a build of it
   runs. You do not merge another branch into this one, run the gate, or touch `main`. Leave no background process running, and keep what your
   record cites under `data/fs131/ba{LANE}/`.
6. **Your record**, stages headed "Stage n — SAVED ({JOB})", "Theorems this phase proved"; the report in standing rule 11's form, ending with what
   is left and its route for a successor. This half is priced at about two sessions: stopping at a saved stage with part of your lanes proved is a
   good report.

## What is yours to decide

The route inside each child, your helpers and where in your files they live, and the order within the planner's dependency constraints. The plan's
routes are one mind's, priced from a table and not from proofs; where a mirror does not go through by flipping an inequality, or a child wants a
lemma in a different form, change the route and say so. A child's **statement** is not yours to change: if one is false or too weak to be used by
its parent, that is a message to me with the configuration, and it is a finding, not a failure. Three failed attempts on one route is a dispatch to
the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+SLUG,"w").write(b)
print("written",SLUG)
