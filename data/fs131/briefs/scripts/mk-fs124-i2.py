exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS124-I2 and FS124-I3: the two implementers of FS-124's second module, from the planner's skeleton (branch fs124-wk2, tip 92f09e14).
# I2: Plane/CircleCrossing and Plane/OnePiece, in the planner's own worktree (fs124-wk2).  I3: Plane/ThreePiece and Plane/ClosePair,
# in a worktree of its own (fs124-wi3, cut from the same tip; make it first, build copied while the planner's tree is idle).
# The two write disjoint files and may run at once; the models (Plane/ClosePairModel, Plane/SectorPoint) are a third job's.
# usage: mk-fs124-i2.py I2|I3
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
WHICH=sys.argv[1]; assert WHICH in ("I2","I3")
JOB="FS124-"+WHICH; TREE={"I2":"fs124-wk2","I3":"fs124-wi3"}[WHICH]; OTHER={"I2":"FS124-I3","I3":"FS124-I2"}[WHICH]
W=WT+TREE+"/"; assert os.path.isdir(W),"make the worktree first"
BASE=sh("git","-C",W,"rev-parse","--short=8","HEAD")
RQ="data/external/EXT-OAI1-request.md"; CK="data/fs124/claims-K2.md"; INV4="plans/FS124-close-inventory.md"
KP=W+"plans/FS124-kernel-plan-2.md"; P=W+"Proofs/HadwigerNelson/Plane/"
os.makedirs(ROOT+"data/fs124/"+WHICH.lower(),exist_ok=True)
IDENT_I="de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus"
def inv(n,c):
    l=line(INV4,f"{n}. **",c); return "> "+l+"\n> — source: "+INV4+" § Items\n"
if WHICH=="I2":
    MODS=["CircleCrossing","OnePiece"]; NLEAVES="sixty-three"; LEFT="23 and 40"
    TITLE="what one piece of one colour forces: two modules of a planner's skeleton, sixty-three leaves"
    NAMES=["C124-SHADOW-OPEN","C124-TYPE","C124-CENTRE-HALF","C124-CENTRE","C124-STRADDLE"]
    THM="\n".join(Q(P+"OnePiece.lean",f"theorem {t} ") for t in ["shadow_open","piece_type","centre_half","tight_centre","tight_straddle"])
    WHAT="the circle geometry every later statement stands on, and the first five claims: what an open set of one colour forbids at distance exactly 1, and what follows for a piece, for a centre, and for a pair of points one unit apart"
    ORDER="`Plane/CircleCrossing` top to bottom, then `Plane/OnePiece` in its file's order (the interface, the type of a piece and its corollaries, the centre, the tight pairs, the three-disc model and its examples)"
    HAND="`/home/kooshi/source/lean-dir/plans/FS124-E1-derivation.md`, Stage 4 (the unit shadow of an open piece; the centre, the straddle), and `/home/kooshi/source/lean-dir/plans/FS124-E2-derivation.md`, § Argument — one piece, one side"
    GOOD="Stopping at a saved stage with the first module proved is a good report"
    AXLINE="the five claims' theorems"
else:
    MODS=["ThreePiece","ClosePair"]; NLEAVES="sixty-one"; LEFT="29 and 32"
    TITLE="what two meeting points of complementary colours force one unit from both: two modules of a planner's skeleton, sixty-one leaves"
    NAMES=["C124-FORCED-PIECES","C124-LONE","C124-BOTH","C124-FOUR"]
    THM="\n".join(Q(P+"ClosePair.lean",f"theorem {t} ") for t in ["closePair_forced_pieces","closePair_lone","closePair_both_separate","closePair_both_saved","closePair_four"])
    WHAT="the last four claims: at a point one unit from two three-piece points whose six labels are all different, a piece of one of them lies inside and another outside that point's unit circle; what it forces when one member pays alone; that both pay when both are full; and that exactly four labels are then present"
    ORDER="`Plane/ThreePiece`'s interface (every leaf down to and including `hasUnitArcFrom_of_arc_subset_sphere`); then `Plane/ClosePair` whole — the four claims are then proved; then `Plane/ThreePiece`'s two constructions (the three-sector point and the petal point, with their measurability leaves and examples), last"
    HAND="`/home/kooshi/source/lean-dir/plans/FS124-E2-derivation.md`, Stage 4 (§ Argument — four regions, six pieces) and Stage 5 (§ Argument — the save by one member: the half-collar, Steps I and II, Both, Four labels) — a dated correction stands under Step II, filed today from the planner's second look: read it with the step"
    GOOD="Stopping at a saved stage with the interface and the four claims proved and the two constructions left is a good report"
    AXLINE="the five theorems quoted below"
CLAIMS="\n".join(Q(CK,f"**{n}** — statement:") for n in NAMES)
PLAN="\n".join([Q(KP,"**What the module costs.**","Stage 5"),Q(KP,"2. Order: `Plane/CircleCrossing` top to bottom (23 left)","Stage 5"),Q(KP,"**What is hard, in order.**","§ 3.2")])
FILES=", ".join(f"`Proofs/HadwigerNelson/Plane/{m}.lean`" for m in MODS)
b=f'''# Brief {JOB} — {TITLE}, on `{TREE}`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT_I}
  role: one of two implementers of the second module of the milestone derived today — replace every `sorry` in two files of a planner's skeleton with a proof, changing no statement; print the axioms; draft what a landing will need
  launch: {"now, in the planner's own worktree — the planner has handed back and nobody else writes there" if WHICH=="I2" else "into the next free slot, in a worktree of your own cut from the planner's tip"}; the other implementer ({OTHER}) works in another worktree on the other two statement files and writes none of yours; a landing of this milestone's first module is in flight on `main`, and a deriver works under `plans/` and `data/` on `main` — you touch neither
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a leaf that is false as stated, vacuous, or provable only with a hypothesis it lacks (say which: the *statement* needs it, or your *route* does) — and for a leaf of the other implementer's files that you need in a different form; **with one line when {AXLINE} print their axioms**; and for a question you cannot work around; the report goes to `data/fs124/reports/{JOB}.md` on your branch, and its text is your final message
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, at `{BASE}`; its `.lake/build` is its own, {"built by the planner today" if WHICH=="I2" else "copied today from the planner's tree after its last build"}): {FILES} (proofs only; helpers under names no other module declares, in these two files); `plans/{JOB}-implementation.md`, `data/fs124/{WHICH.lower()}/`, `data/fs124/reports/{JOB}.md`; **not** any statement or definition (a statement that will not go through comes back through me); **not** the other four modules of the skeleton — two are the other implementer's, and the two that hold the models are a third job's; **not** `scripts/Axioms.lean`, `scripts/Assumptions.lean`, `Proofs.lean` or `ARCHITECTURE.md` (two implementers work at once, and one job joins the branches and registers everything: you draft your audit block as a file under `data/fs124/{WHICH.lower()}/`); the planner's record, `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `main`
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so use this: **save a stage after each file; a leaf on which three attempts fail stays `sorry` with a note in your record, and you go on; if three leaves are so left, stop at the next saved stage and hand back**

Hello. The Hadwiger–Nelson problem — how many colours the plane needs so that no two points at distance 1 share one — stands
at six or seven, and by an outside theorem this library declares, the plane's number is that of measurable colourings proper
at almost every unit pair. Today two derivers of this project worked out by hand what such a colouring is forced to do
wherever it has a region of one colour: one lemma about the points at distance exactly 1 from an open one-colour set, and
from it nine statements, ending with what two nearby meeting points of three colours each must show one unit away. A
planner then stated the nine in Lean, working blind from the statements; it reached each by a route of its own (three by a
shorter one than the derivers'), found that none uses measurability, and left a skeleton that builds, with fourteen leaves
proved and a route written for every other. Two implementers take the statement files. This brief is for
{"the first two" if WHICH=="I2" else "the last two"}: {WHAT}.

## Why this job

These nine are, so far, the only statements this project holds about measurable six-colourings that cross a boundary
running along a unit circle — the configuration every earlier exclusion stopped at — and the milestone opened after this
one cites them in its first claims. They are held by hand, one mind each; the kernel is the second check, and until it has
run nobody may build on them as held. A leaf proved by changing what it says would be worse than a leaf left open:
consumers will cite these statements by name. Kooshi's word of this morning, and what he has said of formalizing:

{Q(RQ,"> I agree with all 3.")}
{KOOSHI}
How the skeleton came to be, as I logged it (read the item whole):

{inv(34,"FS124-K2 done")}
## The statements

**The claims**, in the kernel lane's claim list `{CK}` (read it whole, with its dated line of today on how the skeleton
states them): the first lines of yours —

{CLAIMS}
**The skeleton**, in your worktree under `{P}` — six files; yours are {FILES}. The theorems your two files are for (first
lines; read each whole in its file, with its docstring — the planner states wide forms as the cores and the claims' words
as corollaries under them):

{THM}
**The planner's record**, `{KP}` — read it whole: Stage 2 (the definitions with a model each; the nine typed and read back;
§ 2.3 what the typing found), Stage 3 (§ 3.1 the routes; **§ 3.2 every leaf with its route, its Mathlib names checked at
this pin, and its size**; §§ 3.3–3.5 the three passes), Stage 4 (its routes beside the derivers'; § 4.6 how to iterate
with `lean` against a copy of the build), Stage 5 (the price from fourteen leaves, and where an implementer starts). What
it says the job costs, its order for one implementer, and what is hard (first lines):

{PLAN}
**Your order**: {ORDER}. Your two files have {LEFT} leaves left. A leaf of the other implementer's files is used as it
stands — its statement is fixed, and its `sorry` is theirs.

**The hand arguments**, should a leaf's route fail and you want the other side's wording: {HAND}.

## Done means

1. **Your readback first**: the quotations against their sources; the planner's record; your two files whole and the
   files they import. Build the branch once as given, under the slot (it should end with 130 `declaration uses sorry`
   warnings and no other). Open your record. Commit and push.
2. **Your two files, in the order above**, each leaf by its route in § 3.2 unless it fails — then yours, said in your
   record. **Before you prove a helper, search this library and Mathlib for its statement's shape, not for a name.**
   After each file: build under the slot, commit by explicit path, push, a saved stage.
3. **Statements**: unchanged. An unused hypothesis is reported, not dropped; anything that must change is a message to me.
4. **When your last leaf is in**: the axioms of every theorem of your two files printed (a scratch file under
   `data/fs124/{WHICH.lower()}/`, its output saved), with a control that fires — a theorem that still rests on a `sorry`
   of yours or of the other implementer's prints it, and you say which; **message me the lines of {AXLINE}**. Your
   audit block drafted as a file; `tools/check_architecture.py` exit 0; `./scripts/dupnames.sh`. You do not run the
   full gate, merge another branch, or touch `main`.
5. **Read aloud**, in your record: each of your claims' theorems against the claim list's words, clause by clause, and
   against its *not claimed* line.
6. **Your record**, in stages headed "Stage n — SAVED ({JOB})", with "Theorems this phase proved", the price as measured
   (leaves, lines, builds), every leaf left `sorry` by name with what was tried, and drafts for the landing (the audit
   block; the count of records; any line for `LEAN.md`). The report in standing rule 11's form. **{GOOD}** — say
   exactly which leaves are left.

## What is yours to decide

The route for a leaf whose planned route fails; the helpers; how you iterate. The planner's routes were each checked
against the pin and fourteen of them through the build; where one does not go, change it and say so. Three failed attempts
on one route is a dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
out=ROOT+"data/fs124/briefs/"+JOB+"-"+("one-piece" if WHICH=="I2" else "close-pair")+".md"
open(out,"w").write(b)
print("written",JOB,"base",BASE,len(b),out)
