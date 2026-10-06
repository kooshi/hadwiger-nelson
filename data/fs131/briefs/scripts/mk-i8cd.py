exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-I8C (SemiHub) and FS131-I8D (SemiHubPlaces with outerAdj): wave 8's two parallel implementers, each on a tree cut from
# FS131-I8B's hand-back tip. Usage: mk-i8cd.py C|D   (make the tree fs131-w8c / fs131-w8d first)
import sys,subprocess,re
LANE=sys.argv[1]
TREE={"C":"fs131-w8c","D":"fs131-w8d"}[LANE]; JOB="FS131-I8"+LANE; W=WT+TREE+"/"
BASE=subprocess.run(["git","-C",W,"rev-parse","--short=8","HEAD"],capture_output=True,text=True).stdout.strip()
assert BASE,"make the worktree first"
P="Proofs/HadwigerNelson/Plane/RingCalculus/"; V=W+P
KP=W+"plans/FS131-w8-kernel-plan.md"; SC=V+"StarChart.lean"
def leaves(fn):
    t=open(V+fn).read()
    out=[]
    for m in re.finditer(r"^theorem (\S+)(.*?)(?=^(?:theorem|lemma|def|structure|/--|end |namespace |section |@\[|variable|omit|include)|\Z)",t,re.M|re.S):
        if re.search(r"^\s*sorry\s*$|:= sorry|by sorry",m.group(0),re.M): out.append(m.group(1))
    return out
if LANE=="C":
    MOD="SemiHub.lean"; L=leaves(MOD); FILES=f"`{P}SemiHub.lean` ({len(L)} leaves)"
    WHAT="the semi-hub rows' first module"; OTHER="`SemiHubPlaces` and `outerAdj` (FS131-I8D's)"
    PLANQ=["### 9.1 The statements the proofs derive from","### 9.2 `Plane/RingCalculus/SemiHub` — seventeen leaves","### 9.5 Prices","### 9.6 Inhabitants and vacuity","### 9.8 The handoff","- **Order inside a file**"]
    STM=[(MOD,"theorem "+n+" ") for n in L]
    NOTE="its § 9.2 has a route per leaf, and its § 9.8 the order: `qcol_inner_tile`, the sub-arc lemmas, `germPair_inner_ne`, `qcol_not_one_arc`, the four `ringTile_*`, then `exists_isStar4`, `ringArc_star`, the three stars, `germPair_dicho`, then `isRingArc_of_edge`, `four_le_of_bothKind`"
    PRICE="about 1,700 lines by the planner; expect to hand back with part of it and say what is left"
else:
    MOD="SemiHubPlaces.lean"; L=leaves(MOD); L2=[n for n in leaves("Empty.lean")]
    FILES=f"`{P}SemiHubPlaces.lean` ({len(L)} leaves) and `outerAdj` in `{P}Empty.lean`"
    WHAT="the semi-hub rows' second module, and the outer-adjacency row"; OTHER="`SemiHub` (FS131-I8C's)"
    PLANQ=["### 9.1 The statements the proofs derive from","### 9.3 `Plane/RingCalculus/SemiHubPlaces` — six leaves","### 9.4 `outerAdj` (`Plane/RingCalculus/Empty`) — the plan","### 9.5 Prices","### 9.6 Inhabitants and vacuity","### 9.8 The handoff","- **Order inside a file**"]
    STM=[(MOD,"theorem "+n+" ") for n in L]+[("Empty.lean","theorem "+n+" ") for n in L2]
    NOTE="its § 9.3 has a route per leaf and § 9.4 the plan for `outerAdj` (about 380 lines, on the template of the sole-tip lemma in `SoleTip`); the order: `crossed_no_tip`, `crossed_outer`, `crossed_four`, `crossed_changePoint`, `semiHub_places` (the largest leaf), `crossed_semiHub` last, then `outerAdj`"
    PRICE="about 1,430 and 380 lines by the planner, one job or two; expect to hand back with part of it and say what is left"
OWED=(" **One model is owed by the join job and is yours, first** (ruling 586 (b)): a Lean object of the class the shared lemmas speak of — valid, non-Siamese, simple at a point — for `ncard_tileAt_eq`, `exists_sectorChart_tileAt` and `exists_initialPiece_of_ncard_le_three`; its record names the half-disc map at the origin, about 25 lines, as an `example` in a module of yours." if LANE=="C" else "")
STMTS="\n".join(Q(V+f,p) for f,p in STM)+"\n"
PLAN="\n".join(Q(KP,p) for p in PLANQ)+"\n"
SH="\n".join(Q(SC,"theorem "+n+" ") for n in ["exists_int_of_angleIcc_subset","int_eq_zero_of_two_pi_mul_lt","mem_closure_tile_of_near","IsSectorChart.tileAt_equiv","exists_sectorChart_tileAt","IsSectorChart.exists_initialPiece_between","exists_initialPiece_of_ncard_le_three"])+"\n"
b=f'''# Brief {JOB} — wave 8, {WHAT}: the open leaves of the second planning pass, on `{TREE}`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: one of wave 8's two parallel implementers — prove the open leaves of {FILES} from the second planner's plan and the shared lemmas a first job has proved, without changing a statement, saving after each leaf or group
  launch: when a slot frees, on a branch cut from the commit at which the wave's join job handed back; the other implementer works on {OTHER} in a tree of its own, from the same commit
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me — and say which kind you have, a *statement* that needs a hypothesis it lacks, or a *route* that reads more than the statement needs), a shared lemma that does not serve a use the plan names (with the use), a helper you need that the other implementer would need too (so that one of you writes it and the other takes it), or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from `fs131-w8b` at `{BASE}`): {FILES} — proofs, and new helper declarations under names no other module declares (`./scripts/dupnames.sh` before each push that adds names); a new module of your own beside them if your helpers want one, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (a block of your own, headed "{JOB}", above the `=== PURCHASED ===` banner), `plans/{JOB}-implementation.md`, `tools/fs131_i8{LANE.lower()}_*.py`, `data/fs131/i8{LANE.lower()}/`, `data/fs131/reports/{JOB}.md`; **not** any statement, the shared module `StarChart` (it is both jobs': a change to it is a message to me), {OTHER}, the wave's other modules, any landed module, `main`
  budget: {BUDGET}

Hello. You are proving part of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked
ones. Wave 8 is the *ring calculus*: what the unit circle about a vertex of a valid map (its *ring*) carries, in the class with no
Siamese pair (two tiles of one colour nearer than 1). Today its first theorem was proved — no four-colour vertex has a ring free of
boundary arcs — its second planner stated nine more rows about *semi-hubs* in two modules, and a join job proved the lemmas those two
modules share. One of the two modules is yours; a colleague has the other, from the same commit, at the same time.

## Why this job

A result counts as held only when its Lean module passes the gate. These rows are the calculus the frontier's next milestone — the ring
that carries boundary arcs — starts from (`CLAUDE.md` § Paths forward, the first ranked stub). Kooshi, on pricing this work:

{KOOSHI}
What the planner and the join job handed back, and the rulings in force (read each item whole in the inventory):

{item(572)}
{item(571)}
{item(568)}
{item(584)}
{item(586)}
## The statements

No statement changes in this job. Your leaves, as they stand in your tree (read each whole, with its docstring):

{STMTS}The shared lemmas, proved — cite them, declare none of them again:

{SH}The plan (the planner's record, `{KP}`, Stages 6–10: read it whole; {NOTE}):

{PLAN}## Done means

1. **Your readback first**: check the quotations against their sources; read the planner's record whole, the join job's record on the
   shared lemmas (`/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/plans/FS131-I8B-implementation.md` — its section for the two
   implementers who start from its tip), your module and those it imports, and each row's derivation entry at the address the record
   gives. `#check` every leaf of yours and read the binders the kernel shows (inventory item 556: a section `variable` enters a
   theorem only if its statement mentions it — a leaf whose kernel statement lacks a hypothesis its row reads is a message to me before
   you prove it). Build the branch once as given. Open your record with what you may and may not change. Commit and push.
2. **The leaves**, in the planner's order; saving after each leaf or group (a build, the axioms print for it with a control that
   fires, a statement check on elaborated signatures against `{BASE}` — the wave's tool is
   `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/tools/fs131_i8a_stmt.py` — commit, push). Re-price after your first two leaves
   and say so: {PRICE}. This milestone's implementers have come in at a third to two thirds of their planners' line counts on leaves
   whose route exists, and the planner says of its own plans that they are one mind's and were not elaborated.
3. **The planner's own cautions, which are yours to test**: its plans for the shared lemmas' uses were written before those lemmas
   had Lean statements — where a route asks of a shared lemma something its statement does not give, write a corollary under a name of
   your own and say so, or message me if the other implementer needs it too; and no Lean model of a star or of a semi-hub exists, so
   each leaf's docstring keeps the planner's line on what is owed.{OWED}
4. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not
   merge another branch, run the gate, or touch `main`. **After your last green build, the guarded lint** — `lake lint --no-build --
   --no-build --trace` under the slot with `--mem 8` (`LEAN.md` § The gate), its output saved (inventory item 573). Leave no background
   process running, and keep what your record cites under your `data/` folder.
5. **Your record**, stages headed "Stage n — SAVED ({JOB})", "Theorems this phase proved", each read against its row; the report in
   standing rule 11's form, ending with what is left and its route. Stopping at a saved stage with part of the leaves proved is a
   good report.

## What is yours to decide

The route inside each leaf, your helpers, and the order within the plan's dependencies. The plan is one mind's, written today; change
a route that does not go and say so. A statement is not yours to change: one that is false, or true only with a hypothesis the plan
did not see, is a message to me, and a finding. Three failed attempts on one route is a dispatch to the companion your identity names,
never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-wave8-semihub.md","w").write(b)
print("written",JOB,"base",BASE,"leaves",len(STM))
