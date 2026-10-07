exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS124-I4: the third job on FS-124's second module — the witnesses (Plane/ClosePairModel) and Plane/SectorPoint's two planned
# leaves, on branch fs124-wi3 in its worktree (both implementers have handed back). Not the landing; not the θ-lemma.
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
TREE="fs124-wi3"; JOB="FS124-I4"; W=WT+TREE+"/"; assert os.path.isdir(W)
BASE=sh("git","-C",W,"rev-parse","--short=8","HEAD")
RQ="data/external/EXT-OAI1-request.md"; INV4="plans/FS124-close-inventory.md"; INV6="plans/FS136-close-inventory.md"
KP=W+"plans/FS124-kernel-plan-2.md"; P=W+"Proofs/HadwigerNelson/Plane/"
os.makedirs(ROOT+"data/fs124/i4",exist_ok=True)
IDENT_I="de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus"
def inv(path,n,c):
    l=line(path,f"{n}. **",c); return "> "+l+"\n> — source: "+path+" § Items\n"
THM="\n".join([Q(P+"ClosePairModel.lean","theorem exists_closePair_seven_not_separatesAt"),Q(P+"ClosePairModel.lean","theorem exists_closePair_not_separatesAt"),
               Q(P+"ClosePairModel.lean","theorem exists_closePair_full"),Q(P+"SectorPoint.lean","theorem sectorPoint_isSector"),Q(P+"SectorPoint.lean","theorem exists_closePair_sector")])
PLAN="\n".join([Q(KP,"| `exists_closePair_seven_not_separatesAt` |","§ 3.2"),Q(KP,"| `exists_closePair_not_separatesAt` |","§ 3.2"),Q(KP,"| `exists_closePair_full` |","§ 3.2"),
                Q(KP,"| `exists_closePair_sector` |","§ 3.2"),Q(KP,"**What is hard, in order.**","§ 3.2")])
b=f'''# Brief {JOB} — the witnesses: three colourings by formula that show the pair theorems are about something, on `{TREE}`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT_I}
  role: the third implementer of the second module of the milestone derived today — prove three existence statements, each a colouring by formula on three small discs, that inhabit the hypotheses of four theorems already proved; then two leaves of the module that states the claim list's sector point; changing no statement
  launch: now, in the worktree of the branch that holds the four statement modules proved — both earlier implementers have handed back and nobody else writes there; a planner of the kernel lane starts beside you in another worktree on one leaf you do not touch (the θ-lemma); a deriver works under `plans/` and `data/` on `main`; no landing is in flight
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage — **when the first two witnesses are proved, with the third's price as you measure it from its first inequality (lines, and whether you would go on), before you go on**; at once for a statement that is false as stated or cannot be inhabited by any colouring you can write down (say what fails); and for a question you cannot work around. The report goes to `data/fs124/reports/{JOB}.md` on your branch, and its text is your final message
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, at `{BASE}`; its `.lake/build` is its own, built by the last implementer an hour ago): `Proofs/HadwigerNelson/Plane/ClosePairModel.lean` (proofs; helpers under names no other module declares) and, in `Proofs/HadwigerNelson/Plane/SectorPoint.lean`, the proofs of `sectorPoint_isSector` and `exists_closePair_sector` only; a new helper module beside them if a witness's geometry wants one, with whole new lines in `Proofs.lean` and `ARCHITECTURE.md`; `plans/{JOB}-implementation.md`, `data/fs124/i4/`, `data/fs124/reports/{JOB}.md`; **not** any statement or definition; **not** the four proved modules (a lemma you need there in another form is a helper in your file, and a line in your report); **not** `ThreePiece.IsSector.hasArcEdges` — it stays `sorry`: it is the planner's job beside you; **not** `scripts/Axioms.lean`, `scripts/Assumptions.lean` (a later landing registers everything: you draft your audit block as a file under `data/fs124/i4/`), `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `main`
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so use this: **a saved stage after each witness; a leaf on which three attempts fail stays `sorry` with a note, and you go on; after the second witness you message me the third's price and wait for nothing — go on unless your own measure says it is more than about twice the plan's 700 lines, in which case stop at that saved stage and hand back**

Hello. Today two derivers worked out by hand what a measurable six-colouring must do one unit from two nearby meeting
points of three colours each; a planner stated nine statements of it in Lean; and two implementers proved all of them this
afternoon — 124 leaves, the standard three axioms, no statement changed. Four of those theorems speak about a pair of
meeting points whose six colours are all different. Their proofs are checked; what is not yet in the kernel is that such a
pair exists in any colouring of any open set at all — and a theorem about nothing is the one thing this library's gate
exists to keep out. The planner wrote down three small colourings by formula that would show it. They are yours.

## Why this job

The four statement modules do not land until their hypotheses have inhabitants in the kernel (my ruling, with what was
weighed: read the item whole):

{inv(INV4,42,"FS124-I3 done")}
Kooshi's word of this morning, and what he has said of formalizing:

{Q(RQ,"> I agree with all 3.")}
{KOOSHI}
One of the three is more than an inhabitant: at seven colours, a pair at whose common unit point neither member separates.
The pair theorems spend the number six in one sentence; that witness is the kernel's proof that the sentence is needed.

## The statements

**In your worktree**: `{P}ClosePairModel.lean` (three statements) and `{P}SectorPoint.lean` (two of its three
`sorry` are yours). First lines; read each whole in its file, with its docstring:

{THM}
**The planner's record**, `{KP}` — read it whole for these: § 2.5 (no statement is empty: the models, and what they
cost), § 3.2's last two tables, § 4.4 (the derivers' models beside its own, and its sampled check of the two six-colour
witnesses, `{W}data/fs124/k2/square_model_check.py` — the formulas, in floats: an instrument, not a proof),
Stage 5 (where an implementer starts; § 4.6 on iterating with `lean` against a copy of the build). What it says of your
leaves (first lines):

{PLAN}
**The two implementers' records** (`{W}plans/FS124-I2-implementation.md`, `{W}plans/FS124-I3-implementation.md`):
what they proved that you will use — the three-sector point and the petal point as decompositions with every field
proved, the three-disc model of a tight pair, the lemma that a colouring proper on a set with no unit pair inside each
piece is a weak colouring — and the helper names you must not reuse (each record's "Theorems this phase proved").

**A second candidate for the third witness, should the unit square price badly** — a reading by a deriver, floats, one
mind, nothing in the kernel: on the Searcher's kept model the centre has three partners at distance exactly 1, each pair
with both common unit points inside (read the item for what was read and where):

{inv(INV6,4,"FS136-E1, verdicts through its Stage 3")}
The three statements are existence statements: any colouring that inhabits them will do.

## Done means

1. **Your readback first**: the quotations against their sources; the planner's sections; your two files whole and what
   they import. Build the branch once as given, under the slot (it should end with 6 `declaration uses sorry` warnings
   and no other). Open your record. Commit and push.
2. **The seven-colour control, then the lone witness**, each by the planner's construction unless it fails — then yours,
   said in your record. After each: build under the slot, commit by explicit path, push, a saved stage.
3. **The price of the third**: state its first distance inequality as a small real-variable lemma carrying only its own
   hypotheses, prove it, and from that measure the rest. **Message me the price.** Then the witness, or the other
   candidate, or a stop at the saved stage by the budget's rule.
4. **`sectorPoint_isSector` and `exists_closePair_sector`**, last, if the third witness is in; the θ-lemma stays `sorry`.
5. **Statements**: unchanged; the statement check the last implementer left (`{W}data/fs124/i3/statement_diff.py`) run on
   your two files, with its control.
6. **When your last leaf is in**: the axioms of every theorem of your files printed, with a control that fires; your
   audit block as a file; `tools/check_architecture.py` exit 0; `./scripts/dupnames.sh`. You do not run the full gate,
   merge `main`, or touch `main`.
7. **Read aloud**, in your record: each witness against the hypotheses of the theorem it inhabits — hypothesis by
   hypothesis, so that a reader sees no hypothesis of `closePair_forced_pieces`, `closePair_lone`, `closePair_both_separate`,
   `closePair_both_saved` or `closePair_four` is left without a model — and for the seven-colour control, the one
   sentence of the six-colour proof it shows cannot be dropped.
8. **Your record**, in stages headed "Stage n — SAVED ({JOB})", with "Theorems this phase proved", the price as
   measured, every leaf left `sorry` by name with what was tried, and drafts for the landing (the audit block; what the
   five claims' docstring notes should say if a witness is missing). The report in standing rule 11's form. **Stopping at
   a saved stage with the first two witnesses proved and the third priced is a good report.**

## What is yours to decide

The witnesses themselves, their geometry, the helpers, how you iterate. Three failed attempts on one route is a dispatch
to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs124/briefs/"+JOB+"-witnesses.md","w").write(b)
print("written",JOB,"base",BASE,len(b))
