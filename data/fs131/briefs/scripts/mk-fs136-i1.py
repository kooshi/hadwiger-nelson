exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS136-I1: the implementer of FS-136's kernel module (four files of a planner's skeleton), on branch fs136-wk1 in its worktree.
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
TREE="fs136-wk1"; JOB="FS136-I1"; W=WT+TREE+"/"; assert os.path.isdir(W)
BASE=sh("git","-C",W,"rev-parse","--short=8","HEAD")
RQ="data/external/EXT-OAI1-request.md"; INV6="plans/FS136-close-inventory.md"; CK="data/fs136/claims-K1.md"
KP=W+"plans/FS136-kernel-plan.md"; P=W+"Proofs/HadwigerNelson/Plane/"
os.makedirs(ROOT+"data/fs136/i1",exist_ok=True)
IDENT_I="de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus"
def inv(n,c):
    l=line(INV6,f"{n}. **",c); return "> "+l+"\n> — source: "+INV6+" § Items\n"
THM="\n".join([Q(P+"CutCorner.lean","theorem exists_forall_mem_closure_cutCorner"),Q(P+"Collar.lean","theorem isPreconnected_ball_diff_closedBall"),
               Q(P+"Collar.lean","theorem exists_collar"),Q(P+"Collar.lean","theorem collar_of_corners"),Q(P+"CornerClass.lean","theorem corner_innerAt_iff")])
CLAIMS="\n".join(Q(CK,f"**{n}** — statement:") for n in ["C136-CORNERS","C136-CLASS","C136-FORCED","C136-COLLAR"])
FILES=", ".join(f"`Proofs/HadwigerNelson/Plane/{m}.lean`" for m in ["PieceTable","CornerClass","CutCorner","Collar"])
b=f'''# Brief {JOB} — a corner reaches its point, a corner's side is read from its two edges, and a band is forced along an arc: twenty-seven leaves of a planner's skeleton, on `{TREE}`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT_I}
  role: the implementer of the kernel module of the milestone derived this evening — replace every `sorry` in four files of a planner's skeleton with a proof, changing no statement; print the axioms; draft what a landing will need
  launch: now, in the planner's own worktree — the planner has handed back and nobody else writes there; a landing of the module your branch is cut from is in flight on `main` (another worktree), and a deriver works under `plans/` and `data/` on `main` — you touch neither
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a leaf that is false as stated, vacuous, or provable only with a hypothesis it lacks (say which: the *statement* needs it, or your *route* does); **with one line when the forward step's and the collar's theorems print their axioms**; and for a question you cannot work around. The report goes to `data/fs136/reports/{JOB}.md` on your branch, and its text is your final message
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, at `{BASE}`; its `.lake/build` is its own, built by the planner an hour ago): {FILES} (proofs only; helpers under names no other module declares — **search `Proofs/` by name before you state one**: the planner's first build failed on a name the library already held); `plans/{JOB}-implementation.md`, `data/fs136/i1/`, `data/fs136/reports/{JOB}.md`; **not** any statement or definition; **not** the modules below these four (one leaf there is another job's, in a landing now in flight: it stays as it is on your branch); not `scripts/Axioms.lean`, `scripts/Assumptions.lean` (you draft your audit block as a file under `data/fs136/i1/`), `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `main`
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so use this: **a saved stage after each of the planner's five groups of leaves; re-price each of the three long leaves from its first child and say the price in your record; a leaf on which three attempts fail stays `sorry` with a note, and you go on; if three leaves are so left, stop at the next saved stage and hand back**

Hello. This evening a milestone of this project was derived by hand: what the regions at the points one unit from a point
leave possible near it, in a measurable six-colouring proper at almost every unit pair — and, run the other way, that where
they leave one colour, that colour must be there, down to a band forced along an arc of a unit circle. A planner stated
seven statements of it in Lean without seeing the derivations, proved four of them outright, reduced two more to one leaf
each of plane geometry, and left a route for every remaining leaf. Twenty-seven are left. They are yours.

## Why this job

Two of these statements are the first this project holds that put a region of one colour where nobody assumed one, and the
milestone opened after this one cites them in its first claims. They are held by hand, one mind each; a second mind has
read them and found no error; the kernel is the check that counts. A leaf proved by changing what it says would be worse
than a leaf left open. Kooshi's word of this morning, and what he has said of formalizing:

{Q(RQ,"> I agree with all 3.")}
{KOOSHI}
How the skeleton came to be, and what its planner found on the way (read each item whole):

{inv(22,"FS136-K1: its phase-1 plan is committed")}
{inv(24,"FS136-K1 done")}
## The statements

**The kernel claim list**, `{CK}` (read it whole): the four whose leaves are yours —

{CLAIMS}
**The skeleton**, in your worktree: {FILES}. The two leaves everything waits on, and the theorems they close (first
lines; read each whole in its file, with its docstring):

{THM}
**The planner's record**, `{KP}` — read it whole: Stage 2 (the definitions with a model each; the seven typed and read
back; § 2.3 what the typing found), Stage 3 (§ 3.1 the routes; **§ 3.2 every leaf with its route, its names checked at
this pin, and its size**; § 3.5 the docstring edits it owes), Stage 4 (its routes beside the derivers'; § 4.2 what the
derivers' arguments leave implicit — two of those steps are leaves of yours; § 4.5 the two clauses that are deferred and
are **not** yours), Stage 5 (the price, and the order: the leaf on which a corner reaches its point first; then the outer
half-disc; the models; the order of curves; the collar in the claim list's words).

**The hand arguments**, should a route fail: `/home/kooshi/source/lean-dir/plans/FS136-E2-derivation.md` Stage 2 (the
two lemmas on corners; the forward step) and Stage 8 (the collar), with the dated corrections filed under them today.

## Done means

1. **Your readback first**: the quotations against their sources; the planner's record; your four files whole and what
   they import. Build the branch once as given, under the slot (28 `declaration uses sorry` warnings — 27 yours, one the
   leaf below — and no other). Open your record. Commit and push.
2. **The leaves, in the planner's order**, each by its route unless it fails — then yours, said in your record. After
   each of its five groups: build under the slot, commit by explicit path, push, a saved stage.
3. **Statements**: unchanged. An unused hypothesis is reported, not dropped; anything that must change is a message.
4. **When your last leaf is in**: the axioms of every theorem of the four files printed, with a control that fires;
   **message me the lines of the forward step's and the collar's theorems**; the statement check the earlier
   implementers used (a stored-type comparison against the skeleton, with its control); your audit block as a file;
   `tools/check_architecture.py` exit 0; `./scripts/dupnames.sh`. You do not run the full gate, merge another branch,
   or touch `main`.
5. **Read aloud**, in your record: the forward step's theorems and the collar's against the claim list's words and
   *not claimed* lines, clause by clause — and for each, the kernel model of its hypotheses the planner planned.
6. **Your record**, in stages headed "Stage n — SAVED ({JOB})", with "Theorems this phase proved", the price as measured,
   every leaf left `sorry` by name with what was tried, and drafts for the landing. The report in standing rule 11's
   form. **Stopping at a saved stage with the two closing leaves proved and the order of curves left is a good report.**

## What is yours to decide

The route for a leaf whose planned route fails; the helpers; how you iterate. Three failed attempts on one route is a
dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs136/briefs/"+JOB+"-module.md","w").write(b)
print("written",JOB,"base",BASE,len(b))
