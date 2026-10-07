exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import sys,re
LANE=sys.argv[1]  # L (CoverHull, then Parallel), Z (Centre), K (Accumulation) — the third planning pass's leaves, wave 6
CELLS=sys.argv[2] if len(sys.argv)>2 else None  # for Z: the commit of `fs131-w6g` that holds the three cell lemmas of a fan, if FS131-I6E is back
S="Proofs/HadwigerNelson/Plane/Saturated/"
T={"L":dict(tree="fs131-w6l",job="FS131-I6L",mods=["CoverHull","Parallel"],
     what="the pinch on a cover and the unit parallels — the ladder's base",
     files=f"`{S}CoverHull.lean` (four leaves) and then `{S}Parallel.lean` (thirteen leaves)",
     rows=["| `pinch_of_cover` |","| `IsRegularMUA.exterior_ball` |","| `.frontier_subset_infDist` |","| `.frontier_subset_onLevel` |","| `twoColourNhd_ball_of_open` |","| `partner_point` |","| `tangent_parallel_out`, `_in`, `_line` |","| `finite_bad_directions` |","| `out_family` |","| `chain_in` |","| `radius_integer` |","| `curvature_integer_ae` |","| `finite_pieces_of_radius` |","| `arc_interior`, `segment_interior` |"],
     lines=["| H | `Plane/Saturated/CoverHull` |","| L | `Plane/Saturated/Parallel` |","- **Order within L**:"],
     order="`CoverHull`'s four first (set algebra over held lemmas: they re-price the rest), then `Parallel` in the planner's order, quoted above — `curvature_integer_ae` and `finite_pieces_of_radius` last",
     extra=f'''**`pinch_of_cover` is a proof you adapt, not one you find**: `pinch` is proved, on another branch
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6p/{S}Pinch.lean`, at `43ea4886`; in your tree it is still a `sorry`, and you use
   its statement). Read that proof with the planner's note on where it uses disjointness, and write the cover's form in `CoverHull`; do not
   edit that file — at the join `pinch` becomes a one-line case of yours.
4. **Two leaves have no kernel route yet**: `curvature_integer_ae` (the derivation's step is two lines) and `finite_pieces_of_radius` (one
   mind). Three failed attempts on either is not a fourth: save what is proved and message me — the question for a deriver is already
   drafted (the planner's record § 15.4 item 3), and stopping there with the other eleven proved is a good report.
5. **You own one shared fact** (ruling 531 (c)): "a tangent-type point has positive upper density of each colour". The planner names it as
   a child of the parallels; declare it under a name of your choice as its own lemma, and name it in your report — another implementer
   (`Centre`) will take it from your branch by ancestry.''',
     nleaf="65 `sorry` leaves on the branch: seventeen yours (four in `CoverHull`, thirteen in `Parallel`)"),
   "Z":dict(tree="fs131-w6z",job="FS131-I6Z",mods=["Centre"],
     what="the centre of a chain and the sectors at a singular point",
     files=f"`{S}Centre.lean` (seven leaves)",
     rows=["| `inner_support_near_centre`, `outer_…` |","| `Fan.angle_le_pi` |","| `Fan.ends_centre` |","| `vt_w` |","| `erosion` |","| `pencil_window` |"],
     lines=["| Z | `Plane/Saturated/Centre` |"],
     order="`inner_support_near_centre` and `outer_support_near_centre` (facts about one measurable set: they re-price the rest), `angle_le_pi`, `ends_centre`, then `vt_w`, `erosion`, `pencil_window` — and before you prove those last two, `#check` them: the file's section variable `(F : c.Fan z)` appears in neither statement, so the kernel's `erosion` and `pencil_window` take no fan (`LEAN.md` § Searching — Lean, last bullet; inventory item 556). The planner says `erosion` reads none; confirm that `pencil_window` is meant so too, and message me if its row reads the fan",
     extra="__CELLS__",
     nleaf="65 `sorry` leaves on the branch: seven yours"),
   "K":dict(tree="fs131-w6k",job="FS131-I6K",mods=["Accumulation"],
     what="accumulation of interface pieces — rays, large-radius arcs, symmetry, holes",
     files=f"`{S}Accumulation.lean` (ten leaves)",
     rows=["| `ray_subset_singularSet` |","| `rays_false` |","| `not_lra_of_windowsGE` |","| `thin_arcs_of_lra` |","| `cocompact_of_periods` |","| `windowsGE_of_cocompact` |","| `finite_radii_of_cocompact` |","| `ext` |","| `frontier_hole_subset_singularSet` |","| `no_hole_of_singLocallyFinite` |"],
     lines=["| A | `Plane/Saturated/Accumulation` |"],
     order="the short ones first (`rays_false` after `ray_subset_singularSet`, `cocompact_of_periods`, `no_hole_of_singLocallyFinite`: they re-price the rest), then `ext`, `finite_radii_of_cocompact`, `thin_arcs_of_lra`, and the three the planner says carry the price — `not_lra_of_windowsGE`, `windowsGE_of_cocompact`, `frontier_hole_subset_singularSet` — last",
     extra='''**The accumulation rows share one local obligation and one covering lemma**, by the planner's obligation-modeling pass (its § 14.5,
   decision (d), quoted above): off the singular set the closure of the interface near a point is one simple arc, and a path inside a
   simple arc whose ends lie on opposite sides covers the middle. Prove each once, as lemmas of your own, before the rows that read them.
4. **Most of these theorems have no known object satisfying their hypotheses** — their docstrings say so, with the open question named
   (the planner's § 14.6). That is as ruled: do not strengthen or weaken a hypothesis to make a model exist, and do not delete a
   "satisfiability open" line. A refutation's docstring names the model of its other hypotheses; keep it.''',
     nleaf="65 `sorry` leaves on the branch: ten yours")}[LANE]
if LANE=="Z":
    if CELLS:
        T["extra"]=f'''**The three cell lemmas of a fan are another implementer's, and they are in** (ruling 531 (c)): a cell is preconnected, lies in its
   colour's density set, and holds the initial part of each ray strictly between its directions. They are on `origin/fs131-w6g` at
   `{CELLS}`; merge that commit into your branch before you start (`git merge --no-edit {CELLS}` — the one merge this brief allows; it brings
   `FanBridge`'s proved lemmas by ancestry) and use them under their names. Declare none of the three again.
4. **"A tangent-type point has positive upper density of each colour" is the `Parallel` implementer's** (ruling 531 (c)): if I have sent
   you its commit, take it the same way; otherwise take the fact as a hypothesis of a helper under a name of your own, and say where, so
   the join discharges it in a line.'''
    else:
        T["extra"]='''**The three cell lemmas of a fan are another implementer's** (ruling 531 (c)): a cell is preconnected, lies in its colour's density set,
   and holds the initial part of each ray strictly between its directions. `angle_le_pi`, `ends_centre` and `vt_w` read them. They are
   not in at this writing: take each as a hypothesis of your helpers under a name of your own (never the names another branch will
   declare), and say where, so the join discharges them in a line each. If I send you their commit mid-job, merge it then and drop the
   hypotheses.
4. **"A tangent-type point has positive upper density of each colour" is the `Parallel` implementer's** (ruling 531 (c)): the same — a
   hypothesis under a name of your own unless I send its commit.'''
TREE,JOB=T["tree"],T["job"]
NX=4+len(re.findall(r"\n[45]\. ",T["extra"]))
W=WT+TREE+"/"; KP=W+"plans/FS131-w6-kernel-plan.md"; V=W+S
def leaves(mod):
    t=open(V+mod+".lean").read().split("\n"); cur=None; out=[]
    for l in t:
        if re.match(r"^(theorem|lemma) ",l): cur=l
        if re.match(r"^\s*sorry\s*$",l) or ":= sorry" in l or "by sorry" in l:
            assert cur; out.append(cur); cur=None
    return out
STM=[(m,l) for m in T["mods"] for l in leaves(m)]
STMTS="\n".join(Q(V+m+".lean",l) for m,l in STM)+"\n"
PLAN="\n".join([Q(KP,"### 15.1 For implementers: the split by file")]+[Q(KP,p) for p in T["lines"]]+[Q(KP,"- **Two branches never state one lemma under one name**"),Q(KP,"### 14.5 The plan per leaf"),Q(KP,"The obligation-modeling pass's decisions:")]+[Q(KP,p) for p in T["rows"]]+[Q(KP,"**The price**:"),Q(KP,"### 14.6 Vacuity and inhabitants")])+"\n"
b=f'''# Brief {JOB} — wave 6, {T["what"]}: open leaves of the third planning pass, on `{TREE}`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: one of three implementers of wave 6's third planning pass, split by file — prove the open leaves of {T["files"]} from the planner's plan and the arguments it names, without changing a statement, saving after each leaf or group
  launch: when a slot frees, on a branch cut from the commit at which the wave's third planner handed back, beside the wave's other implementers on branches of their own
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me, and other branches read these statements), a step of a hand argument that fails or does not formalize (with its address: it goes to a deriver), or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from `fs131-w6` at `6fc27fa1`): {T["files"]} — proofs, and new helper declarations under names no other module declares (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name; run `./scripts/dupnames.sh` before each push that adds names); a new module of your own beside them if the helpers want one, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (lines of your own in the block headed "FS131-K6c", or a block headed "{JOB}", above the `=== PURCHASED ===` banner), `plans/{JOB}-implementation.md`, `tools/fs131_i6{LANE.lower()}_*.py`, `data/fs131/i6{LANE.lower()}/`, `data/fs131/reports/{JOB}.md`; **not** the wave's other modules (other implementers', each on its own branch — a `sorry` you see there is theirs, and you use its statement), any statement, the planners' record, any landed module beyond new declarations, `main`
  budget: {BUDGET}

Hello. You are proving part of wave 6 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 6 is thirty-five rows about *saturated* colourings — classes carved by unit circles
about their own points — the regularity half of this project's route to the answer. Three planning passes have stated twenty-nine of
them; the third stated seventeen in four new files, each read from its argument, and reported nine generalizations on the way. This part is yours: {T["what"]}.

## Why this job

A result counts as held only when its Lean module passes the gate. These rows are the ladder of unit parallels and what follows from it —
integer radii, sectors at the singular set, what cannot accumulate — which the frontier's next milestones cite most (`LEDGER.md` rows
139–148; `CLAUDE.md` § Where the problem stands, item 31). Until their leaves are proved they are hand results of one or two minds. Kooshi,
on pricing this work:

{KOOSHI}
What the planner handed back and the rulings in force (read each item whole in the inventory):

{item(531)}
{item(526)}
{item(530)}
{item(516)}
## The statements

No statement changes in this job. Your leaves, as they stand in your tree (read each whole, with its docstring):

{STMTS}The plan (the planners' record, `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/plans/FS131-w6-kernel-plan.md`: read Stages 13–15
whole, and of the earlier stages what your files import; the rows for your leaves give a route, its children, what is hard, and a price on
the planners' scale):

{PLAN}## Done means

1. **Your readback first**: check the quotations against their sources; read the record's Stages 13–15, your files and the modules they
   import, and for each leaf the argument the plan's row names. Build the branch once as given ({T["nleaf"]}). Open your record with what
   you may and may not change. Commit and push.
2. **The leaves**, in this order — {T["order"]}; saving after each leaf or group (a build, the axioms print for it with a control that
   fires, a statement check against `6fc27fa1`, commit, push). Re-price after your first two leaves and say so: the planner's prices are on
   a scale this wave's first two implementers beat by an order of magnitude on set-algebra leaves, and not on the hard ones.
3. {T["extra"]}
{NX}. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge
   another branch but as this brief says, run the gate, or touch `main`. Leave no background process running, and keep what your record
   cites under your `data/` folder.
{NX+1}. **Your record**, stages headed "Stage n — SAVED ({JOB})", "Theorems this phase proved", each read against its row; the report in standing
   rule 11's form, ending with what is left and its route. When you report a defect, say which kind: a *statement* that needs a hypothesis
   it lacks, or a *route* that reads more than the statement needs. Stopping at a saved stage with part of the leaves proved is a good
   report.

## What is yours to decide

The route inside each leaf, your helpers, and the order within the plan's dependencies. The plan is one mind's, written today and compiled
only as far as its statements; change a route that does not go and say so. A statement is not yours to change: one that is false, or true
only with a hypothesis the plan did not see, is a message to me, and a finding — the planner expected four such among these rows and found
none, so one you find is news. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth.
{NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-wave6-third.md","w").write(b)
print("written",JOB,len(STM),"leaves")
