exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS124-L2: the landing of FS-124's second module — eight modules on two branches joined, through the full gate and onto main.
# Worktree fs124-wi3 (branch fs124-wi3: the four statement modules, the witnesses, the sector module); the θ-lemma's module is
# on branch fs124-wk3. Run after FS124-I5 has handed back.
import subprocess,os
TREE="fs124-wi3"; JOB="FS124-L2"; L=WT+TREE+"/"; K=WT+"fs124-wk3/"
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
TIP=sh("git","-C",L,"rev-parse","--short=8","HEAD"); TIP3=sh("git","-C",ROOT,"rev-parse","--short=8","origin/fs124-wk3")
MAIN=sh("git","-C",ROOT,"rev-parse","--short=8","origin/main")
assert "sorry" not in open(K+"Proofs/HadwigerNelson/Plane/ThreeArcs.lean").read(),"the θ-lemma's module must hold no sorry"
RQ="data/external/EXT-OAI1-request.md"; INV4="plans/FS124-close-inventory.md"
P=L+"Proofs/HadwigerNelson/Plane/"
os.makedirs(ROOT+"data/fs124/l2",exist_ok=True)
IDENT_L="de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus"
def inv(n,c):
    l=line(INV4,f"{n}. **",c); return "> "+l+"\n> — source: "+INV4+" § Items\n"
ITEMS="\n".join([inv(34,"FS124-K2 done"),inv(40,"FS124-L1 done"),inv(42,"FS124-I3 done"),inv(44,"FS124-K3, the price"),inv(47,"FS124-I4 done"),inv(48,"FS124-I5, mid-job")])
THM="\n".join([Q(P+"OnePiece.lean","theorem shadow_open "),Q(P+"OnePiece.lean","theorem piece_type "),Q(P+"OnePiece.lean","theorem centre_half "),Q(P+"OnePiece.lean","theorem tight_centre "),
               Q(P+"OnePiece.lean","theorem tight_straddle "),Q(P+"ClosePair.lean","theorem closePair_forced_pieces "),Q(P+"ClosePair.lean","theorem closePair_lone "),
               Q(P+"ClosePair.lean","theorem closePair_both_separate "),Q(P+"ClosePair.lean","theorem closePair_both_saved "),Q(P+"ClosePair.lean","theorem closePair_four "),
               Q(P+"SectorPoint.lean","theorem closePair_both_saved_of_isSector "),Q(P+"SectorPoint.lean","theorem IsSector.hasArcEdges ")])
ROWS="\n".join([Q("LEDGER.md","| 162 | "),Q("LEDGER.md","| 163 | ")])
GATE="\n".join([Q("CLAUDE.md","as a set); the current audit reads ","§ Trust ledger"),Q("CLAUDE.md","**What the library assumes, in both forms**","§ Trust ledger"),Q("CLAUDE.md","`declarations=","§ The gate")])
b=f'''# Brief {JOB} — the landing: nine statements about what a region of one colour forces, with their witnesses and the three-arcs lemma — two branches joined, through the full gate and onto `main`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT_L}
  role: the landing implementer of the second module of the milestone derived today — join two branches on which eight modules stand proved but for one leaf that two written lines close, join them with `main` (which holds the first module's landing since this evening), finish the registrations, run the full gate on one commit, fast-forward `main`, and draft the counts and the front-page sentences for the filing
  launch: now, in the worktree of the module's branch; every implementer of this module has handed back and nobody else writes there or on the other branch; a record job works under `plans/` and `data/` on `main`, and a planner of the kernel lane works blind on a branch cut from yours — neither writes a file you write; no other landing is in flight
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you; a planner is working blind from seven statements of the next milestone and is shown recent commit subjects, so your commit subjects say what you did and name no statement outside this module
  channel: message the coordinator ("main") by SendMessage mid-job, **at once**, for: a gap between a theorem below and the sentence it is read aloud against; a declaration that prints an axiom other than the standard three; the vacuity scan reading a new site as vacuous or unknown, or the assumptions step asking for a declaration you cannot class; a merge conflict in a file under `Proofs/`; a gate step red for a reason you cannot repair within your touches; or a question you cannot work around. **And one line when the gate is green on the commit you will push, before you push.** The report goes to `data/fs124/reports/{JOB}.md` on your branch, and its text is your final message
  standing rules: {STAND}
  record: `plans/{JOB}-landing.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, at `{TIP}`; its `.lake/build` is its own, built by the last implementer two hours ago): the merge of branch `fs124-wk3` (at `{TIP3}` on `origin`: the three-arcs module) and the merge of `main`; in `Proofs/HadwigerNelson/Plane/SectorPoint.lean` — one import line, the two lines that close `ThreePiece.IsSector.hasArcEdges`, one spec example; docstrings and module headers of the module's eight files (the rewordings the implementers drafted; no statement); `Proofs.lean`, `ARCHITECTURE.md`; `scripts/Axioms.lean` (the four implementers' audit blocks, each a file on a branch, and the section prose where a count is said), `scripts/Assumptions.lean` and `scripts/assumptions-ledger.txt` (the second by `--write-ledger` only), `scripts/axioms-controls.txt` only if a control's expected count moves with your state, `scripts/vacuity-baseline.txt` (its header's count lines only, after the scan's final run; an entry is a message to me); `plans/{JOB}-landing.md`, `tools/fs124_l2_*.py`, `data/fs124/l2/`, `data/fs124/reports/{JOB}.md`; `main` by the one fast-forward push this brief names; **not** the statement of any theorem or definition (a statement that must change is a message), `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `tools/claude_md_fact_audit.py`, the derivation files (drafts for those go in your record), the outside clone at `/home/kooshi/source/math`
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so use this: **save a stage after each numbered item below, and if you have made three full gate runs without a green one, stop at a saved stage and hand back**

Hello. Today two derivers of this project worked out by hand what a measurable six-colouring of the plane must do one unit
from an open region of one colour, and from two nearby meeting points of three colours each. A planner stated nine
statements of it in Lean; four implementers proved them, with witnesses that show the theorems are about something and a
lemma of plane topology one clause rests on — about 250 theorems, each on the standard three axioms, no statement changed
on the way. They stand on two branches. One leaf is still a `sorry`, and the two lines that close it are written and
checked. None of it has been through the gate. You join it, take it there, and onto `main`.

## Why this job

These nine are the only statements this project holds about measurable six-colourings that cross a boundary running along
a unit circle, and the milestone opened after this one is built on them. Until they pass the gate the ledger says
"[hand], one mind, kernel pending" of each. The gate is what turns proofs that compile into statements a reader who
trusts none of us may rely on. Kooshi's word of this morning, and what he has said of formalizing:

{Q(RQ,"> I agree with all 3.")}
{KOOSHI}
How the two branches came to be, the landing of this milestone's first module three hours ago — whose record is your
pattern — and my rulings on what lands and how (read each item whole in its inventory):

{ITEMS}
## The statements

**No statement changes in this job.** The nine claims' theorems, the clause in the claim list's own words, and the leaf
you close, in your worktree (first lines; read each whole, with its docstring):

{THM}
**The rows they are read aloud against**, as filed:

{ROWS}
and the theorem record's entries, `plans/FS124-derivation.md` §§ 2–3 (C124-SHADOW-OPEN, -TYPE, -CENTRE-HALF, -CENTRE,
-STRADDLE, -FORCED-PIECES, -LONE, -BOTH, -FOUR), and the kernel claim list, `data/fs124/claims-K2.md`, with its dated line
on how the skeleton states them.

**The gate's recorded state on `main`**, which your counts are reconciled against (refiled at the last landing):

{GATE}
**The records to read.** In your worktree: the planner's (`{L}plans/FS124-kernel-plan-2.md`: § 3.7, what the landing
needs) and the three implementers' (`{L}plans/FS124-I2-implementation.md`, `{L}plans/FS124-I3-implementation.md`,
`{L}plans/FS124-I4-implementation.md`: each with its audit block as a file, its drafts for the landing, and the docstring
rewordings the last one drafted in its § 4.5). In the other branch's worktree, read-only for you until you merge it:
`{K}plans/FS124-kernel-plan-3.md` (§ 3.1: the two lines that close the leaf; § 4.4: the spec example the landing owes,
and the gate's items for the new module) and `{K}plans/FS124-I5-implementation.md` if it is there. On `main`: the last
landing's record, `plans/FS124-L1-landing.md`, for the gate's procedure step by step — its stage 8 says which check went
red on its first pass and why — with its receipts under `data/fs124/l1/gate/` and its gate runner
`data/fs124/l1/run-gate.sh`.

## Done means

1. **Your readback first**: check every quotation above against its source; read the records and the last landing's;
   `LEAN.md` § The gate, § Assumptions and § Trust ledger as they stand on `main`. Build the branch once as given (one
   `declaration uses sorry` warning, the leaf, and no other). Open your record. Commit and push.
2. **The join.** Trial each merge and name its conflicts before you make it. Merge `origin/fs124-wk3`; in the sector
   module add the import, the two lines of the planner's § 3.1, and the spec example of its § 4.4. Build: **no `sorry`
   in the eight modules** (`CircleCrossing`, `OnePiece`, `ThreePiece`, `ClosePair`, `ClosePairWitness`,
   `ClosePairModel`, `ThreeArcs`, `SectorPoint`). Then merge `main` (at `{MAIN}` when this was written): my trial reports
   conflicts in the architecture file and none under `Proofs/` — keep both sides; one under `Proofs/` is a message.
   Build.
3. **The registrations**: the audit blocks as one block of yours in the audit script, every record under the clean
   banner on exactly the standard three or fewer (the implementers' counts: 80, 91 and 130 records, and the new module's;
   definitions that hold proofs are filed, by my ruling at the last landing); the architecture rows, with the two that
   still say "a skeleton" corrected; the docstring rewordings; `tools/check_architecture.py` exit 0; the doubled-name
   check on the joined tree.
4. **What the library assumes.** `./scripts/assumptions.sh --self-test`, then `./scripts/assumptions.sh`: no theorem of
   these modules rests on a declared outside theorem and none takes an assumption in hypothesis form — if the step says
   otherwise, that is a message. List every row the ledger gains, if any.
5. **The vacuity step**: `scripts/vacuity.sh` and its `--self-test`; say how the scan classes every new site; and, since
   the scan tracks no carrier of these modules, **name by hand the kernel model of each hypothesis of the nine claims'
   theorems, of the clause in the list's words, and of the three-arcs lemma** — the third implementer read the pair
   theorems' binders against its three witnesses (its record § 4.3); the first two name the one-piece models.
6. **Read aloud.** In your record: each of the nine claims' theorems against its entry's statement and *not claimed*
   line and against the sentences of rows 162 and 163, clause by clause; **for C124-BOTH's second clause, both forms** —
   the one for arc-edged decompositions and the one in the claim list's words — and what the three-arcs lemma's
   hypotheses assume of the classical fact; and **which of this milestone's thirty entries are then kernel theorems and
   which stay by hand**, each of the latter with its reason (no kernel job; needs a held object's tiles; a reading).
7. **The full gate on one commit**: `./scripts/build.sh` with zero warnings; zero `sorry` in `Proofs/` (a search whose
   plant fires); the doubled-name check and its `--self-test`; `scripts/axioms.sh` clean **with `--self-test` green**
   (the last landing's first pass went red there: read its stage 8 before your first pass); `scripts/vacuity.sh` and
   `--self-test` green, the counts reconciled; `./scripts/assumptions.sh` and its `--self-test` green;
   `tools/check_architecture.py` exit 0; the guarded lint (`lake lint --no-build -- --no-build --trace` under the slot
   with `--mem 8`), silent; the notes check and the records check as the last landing ran them. Take the three digests
   against the last landing's receipts (`data/fs124/l1/gate/receipt-axioms-final.log`,
   `data/fs124/l1/gate/receipt-vacuity-final.log`, `data/fs124/l1/gate/receipt-assumptions-final.log`). Save every
   step's log under `data/fs124/l2/` and name them. **Message me one line when it is green, before you push.**
8. **The landing**: if `main` moved meanwhile, merge it again; when the new commits touch only `plans/`, `data/`,
   `.claude/`, `BIBLIOGRAPHY.md`, `LEDGER.md`, `LEAN.md`, `RUNNING.md`, say so with the diff that shows it, otherwise
   re-run the gate on the merged commit. Then `git push origin HEAD:main` from the worktree — a fast-forward only, never
   a force-push; on a rejected push, fetch, merge and try again.
9. **Drafts for the filing**, in your record under "Drafts for the front page ({JOB})", each with the log line it comes
   from and **the exact words on `main` it replaces**, each slot checked to occur once: `CLAUDE.md` § Trust ledger and
   § The gate's count lines; a `GATE_CHANGES` entry; the open-milestones sentence on this milestone's second module, and
   whether the milestone's Lean phase is then complete for every statement a planner planned; item 31's clause on rows
   161–164; `LEDGER.md` rows 162 and 163's grade sentences (and row 164's, if nothing of it lands, a sentence saying
   so); the theorem record's dated lines for the nine entries, and the corrected `uses only` line of C124-FORCED (the
   three-arcs planner drafted it); `LEAN.md` (the lines the planners and implementers drafted and nobody has filed);
   the atlas grades. And **the open gate items at this landing**, by name.
10. **Your record**, stages headed "Stage n — SAVED ({JOB})"; the report in standing rule 11's form, the counts read from
    the gate's saved logs. Leave no background process running. **Stopping at a saved stage with the gate red at a named
    check is a good report** — say which check, its log, and what you would try next.

## What is yours to decide

How the merges are resolved; the wording of docstrings and rows; how each gate step's finding is repaired within your
touches. Not yours: any statement — if the gate shows a theorem says less or other than its row, that is the most
valuable message this job can send, and nothing is repaired around it. Three failed attempts on one route is a dispatch
to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs124/briefs/"+JOB+"-landing.md","w").write(b)
print("written",JOB,"tip",TIP,"wk3",TIP3,"main",MAIN,len(b))
