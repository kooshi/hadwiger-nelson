exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS136-K1: the kernel lane's planner on FS-136's first statements, blind first from data/fs136/claims-K1.md.
# Worktree fs136-wk1 (the retired fs124-wk2 tree, moved; branch fs136-wk1 cut from fs124-wi3's tip).
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
TREE="fs136-wk1"; JOB="FS136-K1"; W=WT+TREE+"/"; assert os.path.isdir(W),"make the worktree first"
BASE=sh("git","-C",W,"rev-parse","--short=8","HEAD")
CK="data/fs136/claims-K1.md"; RQ="data/external/EXT-OAI1-request.md"
P=W+"Proofs/HadwigerNelson/Plane/"
os.makedirs(ROOT+"data/fs136/k1",exist_ok=True)
IDENT_P="de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow: blind first from the claim list, then open"
NAMES=["C136-TABLE","C136-COVER","C136-ONE","C136-CORNERS","C136-CLASS","C136-FORCED","C136-COLLAR"]
CLAIMS="\n".join(Q(CK,f"**{n}** — statement:") for n in NAMES)
OURS="\n".join([Q(P+"OnePiece.lean","structure IsPieceAt"),Q(P+"OnePiece.lean","theorem IsPieceAt.ae_ne_region"),Q(P+"ClosePair.lean","theorem ae_onSide_of_label"),
                Q(P+"ClosePair.lean","theorem exists_inner_outer_of_cover")])
b=f'''# Brief {JOB} — the kernel module for which side of a unit circle a label may sit on, and what follows where one label is left: seven statements, planned blind, then open

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT_P}
  role: the kernel lane's planner for the first module of the milestone opened this afternoon — state in Lean seven statements claimed by hand today about measurable colourings of an open set that are proper at almost every unit pair; find your own route to each, or to its failure, before you see the derivers'; then, with the derivations open, give an implementer a skeleton and a plan per leaf
  launch: now, in a tree of your own cut from the branch that holds the module these statements stand on; an implementer works on another branch, a record job works under `plans/` and `data/` on `main` — you touch neither; no landing is in flight
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: § Fences
  channel: message the coordinator ("main") by SendMessage **when your phase-1 plan is committed** (the fence lifts by my reply, dated by that commit); **at once** for a statement defect (a statement that does not survive typing — untrue as written, vacuous, or narrower than it need be), for a step you can see no route to, for a generalization, or for a definition that should be shared with the module below; and for a question you cannot work around; the report goes to `data/fs136/reports/{JOB}.md` on your branch, and its text is your final message
  standing rules: {STAND}
  record: `plans/FS136-kernel-plan.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from branch `fs124-wi3` at `{BASE}`; the tree is a retired one moved here, so **its `.lake/build` is older than the branch and your first build recompiles several modules**): new modules of this milestone under `Proofs/HadwigerNelson/Plane/` (statements, definitions, and `sorry` at every leaf you do not close — nothing with a `sorry` reaches `main`), whole new lines in `Proofs.lean` and `ARCHITECTURE.md`; `plans/FS136-kernel-plan.md`, `data/fs136/k1/`, `data/fs136/reports/{JOB}.md`; **not** the modules already on the branch (their statements are fixed; a lemma you need added or widened there is a message), the claim lists (`{CK}` is the coordinator's), `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `main`, the outside clone at `/home/kooshi/source/math`
  budget: about 300k by the harness's count, as guidance; you cannot read that count, so: save a stage after the definitions, after the statements are typed, and at the phase-1 commit; in phase 2 a stage per three statements; hand back when the plan per leaf is final, or earlier at a saved stage if a statement will not type after three attempts

Hello. The Hadwiger–Nelson problem — how many colours the plane needs so that no two points at distance 1 share one — stands
at six or seven, and the plane's number is that of measurable colourings proper at almost every unit pair. Today this
project put into the kernel, on the branch you stand on, a module about what an open region of one colour forces one unit
away. This afternoon a second milestone was opened on top of it: what the regions at several points, each one unit from a
common point, leave possible near that point. Seven statements of it are in your claim list — a head statement, two counts
under it, two lemmas of plane geometry, and two statements that conclude a colour where the others conclude a restriction.
Each is one mind's, by hand, written today. Nobody outside their authors' lane has looked at them. Your blind phase is the
second look, in the strongest form there is: a route found without seeing theirs.

## Why this job

Two of the seven are the first statements of this project that put a region of one colour where nobody assumed one; the
last of them gives that region a definite length. Later questions will be posed on them. If one does not survive typing —
if a hypothesis is missing, a conclusion is met by a degenerate case, a "connected" is not earned — the cheapest moment to
learn it is now, and a statement defect found by you is worth more than the module. Kooshi's word of this morning, and what
he has said of formalizing:

{Q(RQ,"> I agree with all 3.")}
{KOOSHI}
His last sentence binds you: what a planned statement rests on that this library does not hold is planned too — stated as a
leaf, or ported — and nothing becomes a new hypothesis or a new axiom without a message to me first.

## The statements

The kernel claim list is `{CK}`: three paragraphs of definitions, then the seven statements with their not-claimed lines,
copied by script, in the order to take them. Read it whole. Their first lines:

{CLAIMS}
The last three are written in a language of *corners* — a germ of a region between two curves from a point. Whether the
kernel statement should speak of corners, or of pieces as the module below does, or of something a proof suggests, is
yours: the list's words fix what must be true, not the type it is said in. Say for each which you chose and what, if
anything, the other form would add.

**What they are stated over** (none of it fenced — read all of it): the module on your branch — pieces at a point, the
side of a unit circle a piece lies on, and the two statements nearest yours:

{OURS}
Also open: every module on the main line and on your branch (search by the shape of a statement before you state a
helper), `LEAN.md`, and that module's planner's and implementers' records on your branch
(`{W}plans/FS124-kernel-plan-2.md`, `{W}plans/FS124-I2-implementation.md`, `{W}plans/FS124-I3-implementation.md`,
`{W}plans/FS124-I4-implementation.md`) for how its definitions were shaped and what its leaves cost.

## Fences

**Until your phase-1 plan is committed and I have replied, do not read** — by file, by `git show`, `git log -p`, or search
output — any of: `plans/FS136-E1-derivation.md`, `plans/FS136-E2-derivation.md`, `plans/FS136-the-point-across.md`,
`plans/FS136-derivation.md` and `plans/FS136-Z1-record.md` (the derivers' records and plan, and the record job's files, some
still being written), `plans/FS136-close-inventory.md` and `plans/FS124-close-inventory.md` (my receipts describe the
routes), `data/fs136/claims.md` (its dated lines do too), `plans/STUB-covering-pairs.md` and
`plans/POROS-2026-10-07-fs136-round1.md` (the asking lane's cards name what it expects each statement to use),
`plans/SEARCH-QUEUE.md`, `plans/SESSION-HANDOFF-2026-10-07.md`, everything under `data/fs136/e1/`, `data/fs136/e2/`,
`data/fs136/p1/`, `data/fs136/z1/`, `data/fs136/reports/` and `data/fs136/briefs/` but this brief, and the commit bodies
that touch those paths. The session transcripts and the shared scratch directory are closed to you throughout. Commit
subjects on the main line from this afternoon name some of these statements and say how their authors' work came out;
you will be shown a few at launch: say so in your record — they carry no route. If you touch a fenced file by accident,
say so with what you saw: a disclosed touch costs the second route for that statement and nothing else — the blindness
serves discovery and carries no grade. The kernel claim list, the module below with its records, and every module on
the main line are open.

## Done means

1. **Your readback**: this brief's quotations against their sources; `LEAN.md` whole; the module below (six files) and its
   planner's record. Build your branch once as given, under the slot (it should end with one `declaration uses sorry`
   warning — a leaf another job holds — and no other). Open your record. Commit and push.
2. **Phase 1, blind — the statements in Lean and your own routes.** In the list's order:
   - **the definitions first**, each with a model, so that no statement is empty by accident: a family of pieces at a
     point and a label's purity at a far point; and whatever you state the last three over;
   - **each statement typed and read back aloud against its words**, clause by clause, with the *not claimed* line as the
     list of what your Lean statement must not say; for each, whether it reads the number of labels, and where;
   - **your own route to each**, as a plan per leaf. Where you see no route to a statement, or to one clause of it, say
     where you stop, what you can reach, and what is missing. Where a statement does not survive typing, that is a
     message to me at once;
   - **the skeleton**: a module, or more, that builds with `sorry` at every leaf you have not closed, under the slot.
   **Commit the phase-1 plan and message me.** That commit dates your blindness.
3. **Phase 2, open — after my reply.** Read the derivers' entries for these statements with their arguments. For each:
   where your route and theirs part, which an implementer should build and why, and a plan per leaf in final form — each
   leaf with the Mathlib and library names it will use, found by shape at this pin and checked under the module's own
   imports, and its size. **Any step of theirs you cannot make a leaf of is a message to me with the step's address.**
4. **The price, from leaves tried**: take two leaves of your choice through the kernel to measure the rate, and say what
   the module costs and in what order an implementer should take it.
5. Your record in stages headed "Stage n — SAVED ({JOB})", committed by explicit path and pushed; no `axiom`, no
   `native_decide`; you merge nothing and nothing with a `sorry` reaches `main`. The report in standing rule 11's form.
   **Stopping at a saved stage with phase 1 committed is a good report** — say exactly where a successor takes over.

## What is yours to decide

The form of every definition and statement within what its words say; the module's names and places; your routes; what
of the seven you judge plannable now and what should wait for a consumer. The statements are two minds', written in one
afternoon: a difference you find between a statement's words and what can be typed is the most valuable thing this job
can report. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth.
{NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs136/briefs/"+JOB+"-kernel-plan.md","w").write(b)
print("written",JOB,"base",BASE,len(b))
