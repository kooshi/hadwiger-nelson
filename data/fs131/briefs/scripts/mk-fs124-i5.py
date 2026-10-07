exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS124-I5: the implementer of Plane/ThreeArcs (the θ-lemma's module), on the planner's branch fs124-wk3 in its worktree.
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
TREE="fs124-wk3"; JOB="FS124-I5"; W=WT+TREE+"/"; assert os.path.isdir(W)
BASE=sh("git","-C",W,"rev-parse","--short=8","HEAD")
RQ="data/external/EXT-OAI1-request.md"; INV4="plans/FS124-close-inventory.md"
KP=W+"plans/FS124-kernel-plan-3.md"; P=W+"Proofs/HadwigerNelson/Plane/"
os.makedirs(ROOT+"data/fs124/i5",exist_ok=True)
IDENT_I="de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus"
def inv(n,c):
    l=line(INV4,f"{n}. **",c); return "> "+l+"\n> — source: "+INV4+" § Items\n"
THM="\n".join([Q(P+"ThreeArcs.lean","structure IsTriod (x : ℂ) (r : ℝ) (J : Fin 3 → C(unitInterval, ℂ)) : Prop where"),
               Q(P+"ThreeArcs.lean","structure IsTriodCut (x : ℂ) (r : ℝ) (J : Fin 3 → C(unitInterval, ℂ)) (P : Fin 3 → Set ℂ) : Prop"),
               Q(P+"ThreeArcs.lean","theorem exists_opposite (h : IsTriodCut x r J P) :"),
               Q(P+"ThreeArcs.lean","theorem exists_arc (h : IsTriodCut x r J P)")])
START=Q(KP,"1. **Start**: `Proofs/HadwigerNelson/Plane/ThreeArcs.lean` on branch `fs124-wk3`:","§ 4.4")
b=f'''# Brief {JOB} — three arcs from a point, each bordering exactly two of three regions: twenty leaves of a planner's skeleton, on `{TREE}`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT_I}
  role: the implementer of one module of plane topology — replace every `sorry` in a planner's skeleton with a proof, changing no statement — on which one clause of this milestone's nine statements rests
  launch: now, in the planner's own worktree — the planner has handed back and nobody else writes there; another implementer works in another worktree on the module's witnesses and holds a file you do not write; a record job works under `plans/` and `data/` on `main`; no landing is in flight
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a leaf that is false as stated, vacuous, or provable only with a hypothesis it lacks (say which: the *statement* needs it, or your *route* does); **with one line when the module's last theorem prints its axioms**; and for a question you cannot work around. The report goes to `data/fs124/reports/{JOB}.md` on your branch, and its text is your final message
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, at `{BASE}`; its `.lake/build` is its own, built by the planner an hour ago): `Proofs/HadwigerNelson/Plane/ThreeArcs.lean` (proofs only; helpers under names no other module declares); `plans/{JOB}-implementation.md`, `data/fs124/i5/`, `data/fs124/reports/{JOB}.md`; **not** any statement or definition; **not** `Proofs/HadwigerNelson/Plane/SectorPoint.lean` — the other implementer holds it, and the two lines that close its leaf over your theorem are already written and checked (the planner's record § 3.1): they go in at the join, by another job; not the library's plane-topology module or any other proved module (a lemma they lack is a helper of yours); not `scripts/Axioms.lean`, `scripts/Assumptions.lean` (you draft your audit block as a file under `data/fs124/i5/`), `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `main`
  budget: about 300k by the harness's count, as guidance; you cannot read that count, so use this: **a saved stage after every five leaves; a leaf on which three attempts fail stays `sorry` with a note in your record, and you go on; if three leaves are so left, stop at the next saved stage and hand back**

Hello. Today this project stated and proved in Lean nine statements about measurable six-colourings of the plane. One clause
of one of them speaks of a point from which three arcs run to the rim of a small disc, cutting it into three regions, and
needs that every two of the regions share an initial part of one of the arcs. That is half of a classical fact about three
arcs in a disc. A planner found this afternoon that the other half — that there are exactly three regions — is already
assumed by the definition in use, and that the half that is owed follows from two lemmas this library holds: the plane's
unicoherence and the crossing of two continua in a disc. It stated the fact in a module of its own, proved twenty-one of its
forty-one theorems, and left a route for each of the other twenty. They are yours.

## Why this job

Kooshi's word of this morning is that what a module rests on is formalized in the milestone's own Lean phase, not declared:

{Q(RQ,"> I agree with all 3.")}
{KOOSHI}
I weighed the other way out — redefining the point so that no such fact is needed — against the planner's price, and ruled
that the fact is proved (read both items whole):

{inv(44,"FS124-K3, the price")}
{inv(46,"FS124-K3 done")}
## The statements

**The skeleton**, in your worktree: `{P}ThreeArcs.lean` — 41 theorems, 21 proved, 20 `sorry`. The two structures and the
two theorems the module is for (first lines; read each whole in its file, with its docstring):

{THM}
**The planner's record**, `{KP}` — read it whole: Stage 2 (what exists, here and outside), § 3.1 (the statement and the
two lines that close the consumer's leaf), § 3.2 (the route), §§ 4.1–4.2 (its two passes, and what they changed), **§ 4.3
(the plan per leaf for the twenty, with the Mathlib and library names it checked under the module's own imports)**, § 4.4
(where you start), Stage 5 (the price in final form). Its first line on your start:

{START}
**What the route stands on**, held by this library: `/home/kooshi/source/lean-dir/Proofs/HadwigerNelson/Plane/PlaneTopology.lean`
(unicoherence; two continua in a closed disc joining interleaved points of its circle meet; the frontier of a
complementary component of a closed preconnected set is preconnected) and the module yours imports.

## Done means

1. **Your readback first**: the quotations against their sources; the planner's record; the module whole and the
   statements it uses from the plane-topology module. Build the branch once as given, under the slot (it should end with
   26 `declaration uses sorry` warnings and no other). Open your record. Commit and push.
2. **The twenty leaves, in the order of § 4.3**, each by its route unless it fails — then yours, said in your record.
   **Before you prove a helper, search this library and Mathlib for its statement's shape, not for a name.** After every
   five leaves: build under the slot, commit by explicit path, push, a saved stage.
3. **Statements**: unchanged. An unused hypothesis is reported, not dropped; anything that must change is a message to me.
4. **When the last leaf is in**: the axioms of every theorem of the module printed (a scratch file under
   `data/fs124/i5/`, its output saved), with a control that fires; **message me the line of the module's last theorem**;
   check once more that the two lines of the planner's § 3.1 elaborate against your finished module (a scratch file — you
   do not edit the consumer's file); your audit block drafted as a file; `tools/check_architecture.py` exit 0;
   `./scripts/dupnames.sh`. You do not run the full gate, merge another branch, or touch `main`.
5. **Read aloud**, in your record: the module's two headline theorems against the sentence "each of three arcs from the
   centre of a disc to its rim borders exactly two of the three complementary regions, and every two regions share one" —
   and say which half of the classical fact the hypotheses assume.
6. **Your record**, in stages headed "Stage n — SAVED ({JOB})", with "Theorems this phase proved", the price as measured
   (leaves, lines, builds), every leaf left `sorry` by name with what was tried, and drafts for the landing (the audit
   block; the count of records; any line for `LEAN.md`). The report in standing rule 11's form. **Stopping at a saved
   stage with ten of the twenty proved is a good report** — say exactly which leaves are left.

## What is yours to decide

The route for a leaf whose planned route fails; the helpers; how you iterate. The planner's routes were checked for names
under the module's imports and twenty-one of them through the build; one earlier sketch of this proof, by another
planner, did not go as written — where a route does not go, change it and say so. Three failed attempts on one route is a
dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs124/briefs/"+JOB+"-three-arcs.md","w").write(b)
print("written",JOB,"base",BASE,len(b))
