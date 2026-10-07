exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import subprocess
# FS131-K7c: wave 7's third planning pass. Re-runnable while the job is unlaunched: it reads whether wave 8 has landed on origin/main
# and words the merge of `main` accordingly (a brief not yet launched is rewritten, never amended).
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
KP="plans/FS131-kernel-plan.md"
PIDENT="de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow"
TREE="fs131-w7"; JOB="FS131-K7c"; W=WT+TREE+"/"
TIP=sh("git","-C",W,"rev-parse","--short=8","HEAD")
M7=sh("git","-C",ROOT,"rev-parse","--short=8","origin/fs131-w7m")
MAIN=sh("git","-C",ROOT,"rev-parse","--short=8","origin/main")
P="Proofs/HadwigerNelson/Plane/"
LANDED8=sh("git","-C",ROOT,"ls-tree","--name-only","origin/main",P+"RingCalculus/SemiHub.lean")!=""
SH8=(P+"RingCalculus/SemiHub.lean") if LANDED8 else WT+"fs131-w8c/"+P+"RingCalculus/SemiHub.lean"
REC=W+"plans/FS131-w7-kernel-plan.md"
LOC=W+P+"FourColour/Local.lean"; BOW=W+P+"FourColour/Bowtie.lean"; RG=P+"RingGerm.lean"
COPY=f'''to spare a rebuild of everything `main` gained since your branch left it, copy a green build of `main`'s line over
   yours before you build — `cp -a /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8l/.lake/build/. {W}.lake/build/` — and only
   while no `lake` runs in that source tree (`pgrep -x lake`, then `readlink /proc/<pid>/cwd` for each)'''
if LANDED8:
    W8NOW=f"wave 8 landed on `main` today (`origin/main` is at `{MAIN}`)"
    MERGE8=f'''Then merge `origin/main` (at `{MAIN}`): it brings wave 8 — eleven modules of the ring calculus — wave 10, half of wave 6
   and the gate's new step. My trial of `origin/main` into `origin/fs131-w7` conflicts in `ARCHITECTURE.md`, `Proofs.lean` and
   `scripts/Axioms.lean` and nowhere else — registry files, adjacent lines, both sides kept. `Plane/SimpleOn` and
   `Plane/RingCalculus/Basic` are the same files on both sides, by ancestry. And {COPY}.'''
    HOLD="`main` is merged at this point, so the cut needs nothing more"
    BUILD="Then build once"
else:
    W8NOW="wave 8 is landing as you start: a landing job is running the gate on its joined tree"
    MERGE8=f'''**`main` is merged later, on my message.** Wave 8 — eleven modules of the ring calculus — is landing as you start. When it
   has landed I send you one message with `main`'s hash: at your next saved stage merge `origin/main` then (my trial of `origin/main`
   into `origin/fs131-w7` today conflicts in `ARCHITECTURE.md`, `Proofs.lean` and `scripts/Axioms.lean` and nowhere else — registry
   files, adjacent lines, both sides kept; wave 8's files will add to those three and to no Lean file of yours); {COPY}; build; and tell
   me the hash. Until then wave 8's statements are read at their path in its implementer's tree (quoted above), and nothing of yours
   restates one.'''
    BUILD="Build once now, on the first merge alone"
    HOLD="if `main` is not merged yet, say so in that message: I hold the cut until it is, because `four_le_centre` cites a lemma that arrives with it"
ITEMS=[553,556,564,571,593,595,568,592]
ITEMQ="\n".join(item(n) for n in ITEMS)+"\n"
RQ=["**The third planning pass, FS131-K7c**","1. **Unread arguments**","2. **Rows not stated**","3. **Rows stated in part**","4. **Held dispositions it should re-read**",
    "- **S1 ","- **D1 ","**Price: about 5,500 lines","| `IsReuleauxBowtie.rstopAll` |","- **`Plane/FourColour/Bowtie`**, second job","- **J4 ","**Totals**:"]
RECQ="\n".join(Q(REC,p) for p in RQ)+"\n"
DQ=["| FS114-N5-GRING |","| FS114-Y2-BOWTIE |","| FS114-Y3-RSTOP |","| FS114-N6-NOQ |","| FS114-N7-QOPP |","| FS114-Y5-PINALL |","| FS129-SR3-E2ONE |","| FS114-Y6-E2RED |","| FS114-N4-LEMMAS |","| FS114-Y6-HALF |","- **the pinwheel**:"]
DISQ="\n".join(Q(REC,p) for p in DQ)+"\n"
QOPP="\n".join(Q(LOC,"theorem "+n+" ") for n in ["qArc_inner","qArc_outer","qArc_ne","qArc_cone_disjoint","qArc_others_absent"])+"\n"
RSTOP=Q(BOW,"theorem IsReuleauxBowtie.rstopAll ")
W3="\n".join(Q(RG,"theorem "+n+" ") for n in ["ringArc_cone_inner","ringArc_cone_outer"])+"\n"
W8="\n".join(Q(SH8,"theorem "+n+" ") for n in ["qcol_inner_tile","simpleOn_not_hasRepeatedColour"])+"\n"
ASSUME=Q("LEAN.md","- **Every assumption in hypothesis form is declared to the gate**","§ Assumptions")
b=f'''# Brief {JOB} — wave 7's third planning pass: three answers that implementers wait on, then the pinwheel

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {PIDENT}
  role: wave 7's third planner — merge the proved count and its six-colour model into the wave's line; check the nineteen stated leaves in the kernel and re-read five of them against what wave 8 found; settle which object the bowtie fragment is, from two filed records that disagree; decide one hypothesis of the bowtie's stop; then write the pinwheel's foundation and state the rows the second pass did not reach, `sorry` at each leaf, each statement read back against its row, a plan and a price per leaf, the inhabitants and vacuity lines, and a handoff implementers can split by file
  launch: when a slot frees, in the tree the second pass (FS131-K7b) handed back; no implementer has started on its nineteen leaves, and none starts before your word
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for each of the three early answers below (items 3, 4, 5 of § Done means — each unblocks a line of implementers, so send it when it is saved, not at the hand-back), a statement defect in a row (at once, with the entry's address and the line of the argument: it goes to a deriver), a correction owed to a filed record, a change you find you need in a module that is fixed (below), a generalization or a shorter route, an outside theorem you would import, or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate: the inhabitant rule and the doubled-name check; § Assumptions; § Searching — Lean, last bullets), and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w7-kernel-plan.md` (on branch `{TREE}`; the two earlier passes' record — your stages continue its numbering from Stage 8, headed {JOB})
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, at `{TIP}`): **new modules under `{P}FourColour/`** (the first pass proposed `Pinwheel` and `BowtieFragment`; the layout is yours); **the statements and docstrings of the nineteen open leaves** of `{P}FourColour/Local.lean` and `{P}FourColour/Bowtie.lean` (no implementer has started them: a statement you correct is logged in your record with its reason and named in your message to me); new declarations in `{P}FourColour/Basic.lean`; `Proofs.lean`, `ARCHITECTURE.md` and `scripts/Axioms.lean` (a block of your own, headed "{JOB}", above the `=== PURCHASED ===` banner) for them and for the merges; `plans/FS131-w7-kernel-plan.md`, `tools/fs131_k7c_*.py`, `data/fs131/k7c/`, `data/fs131/reports/{JOB}.md`; **not** an existing declaration of `{P}FourColour/Basic.lean` (`Local` and `Bowtie` read it: a change there is a message first), `{P}SimpleOn.lean` and everything under `{P}RingCalculus/` (wave 8's, shared by ancestry and landing on `main`), `{P}RouteT/` (proved), any landed module beyond new declarations, the derivation records under `plans/` (a correction owed goes to me by message), `main`, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`
  budget: {BUDGET}

Hello. You are the third planner of wave 7 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5, wave 10 and half of wave 6 are on `main`, and {W8NOW}. Wave 7 is twenty rows about a vertex where four
colours meet in a tight six-colour map. Its first planner stated route T's count, which an implementer has since proved, with a six-colour
model of it in the kernel. Its second wrote the four-colour foundation, proved ten declarations, stated nineteen leaves in two modules — and
stopped, past its line, with eight rows and the pinwheel unstated, their arguments unread, and one discrepancy between two filed records
written down with both sides quoted and no side picked. Those are yours. Three lines of implementers wait on your first three answers, which
is why the order below is what it is.

## Why this job

A result counts as held only when its Lean module passes the gate. What is left of wave 7 is the pinwheel — the degree-4 vertex of four
colours whose four tiles turn like blades — and its exclusion with two exceptions; with the bowtie's stop it is the local half of the
unit-arc question (`LEDGER.md` rows 137–138; `CLAUDE.md` § Where the problem stands, item 31). No mind in this milestone has read the
pinwheel's arguments: the second planner read their entries only, and says so. And wave 7 cannot pass the gate until the bowtie fragment —
the explicit twenty-tile map that every structure-valued hypothesis of the wave names as its inhabitant — is in the kernel: four implementer
jobs, which cannot be briefed while two filed records disagree about what that object's central ring carries. Kooshi, on pricing this work:

{KOOSHI}
What the earlier passes and the wave's implementers handed back, and the rulings in force (read each item whole in the inventory,
`plans/FS131-close-inventory.md`; the first lines are quoted here as addresses):

{ITEMQ}The milestone's plan binds every wave's planning job (read its §§ 7.1–7.5 whole):

{Q(KP,"### 7.3 What each wave's planning job must hold")}
{Q(KP,"1. **Reads its rows' derivation entries in full**")}
{Q(KP,"3. **States every row at the class its argument reads**")}
{Q(KP,"5. **Checks vacuity at the seam**")}
And since today the gate lists what the library assumes:

{ASSUME}
## The statements

**What the second pass left you, in its words** — the first lines of the paragraphs that are yours; read its record whole
(`/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/plans/FS131-w7-kernel-plan.md`, Stages 5–7, and §§ 4.1–4.3 of the first pass):

{RECQ}
**The first pass's dispositions of the rows not yet stated whole** (each from the row's entry only — its "read" column says E):

{DISQ}
**FS114-N7-QOPP as the second pass stated it** — five leaves of `Local`, none proved — and the bowtie's stop, whose `SimpleOn` hypothesis
item 5 below asks about (each head's first line; the whole statement is at its address):

{QOPP}
{RSTOP}
**Wave 3's two cone lemmas, on `main`** — which wave 8's second planner reads as carrying four of those five (inventory item 571):

{W3}
**Two lemmas wave 8 has proved** (the first is `qArc_inner`'s first clause under another name; the second is the joint your record calls
J4):

{W8}
## Done means

1. **Your readback first**: check every quotation above against its source; read the record whole, the wave's modules, and the plan's
   §§ 7.1–7.5. Register, before reading the unread arguments: which of the unstated rows you expect to hide a statement defect, which to
   be one theorem with another, how many you will state whole, and which side of the discrepancy (item 4) you expect to be the object.
   Open your stages in the record with what you may and may not change. Commit and push.
2. **The merges, and one build.** Merge `origin/fs131-w7m` (at `{M7}`): it holds route T's count proved (`{P}RouteT/Count.lean`, no
   `sorry`) and the six-colour model in the kernel (`{P}RouteT/Grid12.lean`), whole. My trial merge of it into `origin/fs131-w7`
   conflicts in `scripts/Axioms.lean` only — keep both sides' blocks. {MERGE8}
   {BUILD}, and bring `ARCHITECTURE.md`'s row for `Count` up to what the module now holds (`tools/check_architecture.py` exit 0).
   Commit and push.
3. **The nineteen stated leaves, read from the kernel, and FS114-N7-QOPP re-read — so that `Local`'s implementer can start.**
   (a) `#check` every leaf of `Local` and `Bowtie` and compare the kernel's statement with the file's: a section `variable` enters a
   theorem only if its statement mentions it, and four leaves of this wave's count were false as stated for exactly that reason (inventory
   items 556, 564). The instrument that found them compares elaborated signatures, with controls, and is yours to reuse:
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/tools/fs131_i7a_stmt_check.py` (on your branch after the merge).
   (b) **The relay from wave 8** (item 571; its planner's reading, one mind, not checked by me): of the five `qArc_*`, the cone clause
   of `qArc_inner` and all of `qArc_outer` follow from wave 3's two lemmas with `NonSiamese` idle; `qArc_cone_disjoint` and `qArc_ne`
   are angle arithmetic over those; only `qArc_inner`'s first clause reads `NonSiamese` — and that clause is the lemma wave 8 has since
   proved as `qcol_inner_tile`. Decide, from the arguments: which hypotheses each of the five keeps (one its proof does not read is
   removed now, while the statements are still yours to change), and whether `qArc_inner`'s first clause is stated here at all once
   `main` is merged (two lines never state one lemma: with wave 8's module in your tree it is a citation, not a leaf).
   (c) **J4 is proved** — wave 8's `simpleOn_not_hasRepeatedColour`: your plan's row for `four_le_centre` cites it; nobody mints it.
   (d) Read each leaf's binders against its row's *not claimed* line. Twice today a planner's hypothesis did not match its row, and the
   build could not see it: `interior` of a cone admitted the whole circle where the argument read an open arc (item 568), and "at least
   four colours" stood where the argument read "exactly four" (item 592).
   Then commit, push, and **send me the hash with the line "`Local`'s implementer may be cut from here"** and the list of every leaf
   whose statement you changed, each with its reason; {HOLD}.
4. **The discrepancy about the bowtie fragment** (ruling 553 (a); your record's § 7.2, S1). Which object does `tools/fs114_y2_k1.py`
   build; what does the ring survey (`data/fs116/n1/ring-survey-bowtie.out`, made by `tools/fs116_n1_ring.py`) mean by "off Gamma" on
   the centre's ring between 60° and 120° — a convention under which an arc bounding a tile whose colour is carried at the centre is not
   counted, or a different object surveyed; and do the two model lines (`plans/FS114-derivation.md` ll. 496, 547) and FS116-Z2's
   erratum sentence stand. Read the construction's record (`plans/FS114-Y2-construction.md`) and both tools. This is a question of
   which object was built, not a derivation: you may run the two tools as they are, on the objects they hold, and nothing that
   searches. **By message to me as soon as it is saved**: the answer in one paragraph with the lines that decide it; each correction
   owed (the file, the line, the corrected sentence — I route it to the errata, you edit no derivation record); which rows the
   fragment can be the inhabitant for; and whether your record's § 7.5 stands — its route, its description of the object and its four
   jobs — because the fragment's first job is briefed from that answer: say, by line, what its brief should take as the object. If the
   records and the tools do not settle it, say what would: that is a good answer, and I send it to a deriver.
5. **The bowtie's stop, before `Bowtie`'s implementers.** The second pass planned `rstopAll`'s last two steps from one record without
   its verifiers': read `plans/FS114-YB2-verification.md` (RPREC) and `plans/FS114-YB3-verification.md` (DIAG's step 7, CUSP), and
   decide whether `hS : F.SimpleOn (closedBall p √3)` narrows to the set the argument's points lie in (the second pass names the closed
   unit disc as the candidate) — and, where your reading gives them to you, state DIAG's five steps as `sorry` children, so that the
   1,400-line leaf is split before a job starts on it. With it, your record's D1: N3-HALF's last clause and the exception its own proof
   names. Commit, push, and tell me "`Bowtie`'s implementers may be cut from here".
6. **The pinwheel's foundation**: blades, centres, pockets, and the three exceptions' predicates E0, E1, E2, as definitions with a
   spec example each, by `debruijn-domain-modeling` (invoked fresh), in a module of yours — over what your tree then holds, which
   since the merge of `main` includes all of wave 8's ring calculus (stars, semi-hubs, tips, change points, the tiles at a point in
   cyclic order). **Before you state a helper, search the tree for its statement's shape, not for a name**: today an implementer wrote
   two weaker copies of landed theorems, and three lemmas a plan called missing were already in the library (inventory items 584, 596).
7. **The rows, stated**: the unstated rows and the parts left of the four stated in part (your record's § 7.7, items 2 and 3), each
   with `sorry` at its leaves, read back against its row and its *not claimed* line, and `#check`ed as in item 3 (a). FS114-Y2-BOWTIE's
   own statements wait for the fragment's first job unless your answer to item 4 lets you write them now about an object to come —
   your call. A row whose argument does not support its statement is a message to me at once — and say which kind you have: a
   *statement* that needs a hypothesis its entry lacks, or a *route* that reads more than the statement needs (a shorter-route note,
   no defect).
8. **Vacuity, inhabitants, assumptions.** The pinwheel's rows are refutations with no held fragment at `1 + ε` outside its exceptions:
   each docstring says so in `LEAN.md` § The gate's form and names the object meeting the local hypotheses but one. Every other
   structure-valued hypothesis has a named Lean inhabitant or an owed one named (the six-colour count's is `RouteT.grid12`, which the
   merge brings; `kill` has none, and its docstring says so). **And list, for the wave's landing, every assumption in hypothesis form
   that any statement of the wave takes** — a named `Prop` or one written out in a binder, standing for an outside theorem, a hand
   result of ours or an open question — each with its kind and source, in the form of `LEAN.md` § Assumptions: the gate's new step
   fails on one not declared, and the landing declares from your list. You declare nothing yourself and run no gate.
9. **Rows over `SimpleOn`** (inventory item 533 (d)): a non-existence row stated with `F.SimpleOn S` implies the row as filed
   (`Simple.simpleOn`), but a row that is an implication between two class statements does not — its hypothesis grows with the class
   too. State such a row in both readings (on the disc, and literal `Simple`); one argument proves both.
10. **The skeleton**: builds through the worktree's `./scripts/build.sh` with only `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md`
   (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated; no new `axiom`, no `native_decide`; `./scripts/dupnames.sh`
   on your tree — no name declared by two modules.
11. **Your record**: a plan per leaf (route, the Mathlib and library lemmas confirmed with `#check`, what is hard, a price **in lines of
   Lean and in implementer jobs, never in days** — inventory item 541: this milestone's planners' line counts have been right to within
   a factor of two and their day counts high by ten in jobs; one job proves about 1,300 lines), the obligation-modeling pass
   (`debruijn-obligation-modeling`, invoked fresh), and a handoff for implementers by file that says which jobs can run side by side
   and from which commit. A leaf you can prove in about an hour, prove, and say so.
12. The report, in standing rule 11's form. You do not merge a branch into this one beyond the two named in item 2, run the gate, or
    touch `main`. Leave no background process running, and keep what your record cites under `data/fs131/k7c/`. **This is more than
    one pass may hold.** Items 2–5 come first because implementers wait on them; then the pinwheel's foundation; then its rows in the
    order of their dependencies. Stopping at a saved stage and saying exactly where a fourth pass takes over is a good report — the
    second pass did exactly that, and its handoff is why you can start where it stopped.

## What is yours to decide

The modules and their layout; the statements of the nineteen open leaves, corrected where an argument or the kernel says so; the answer
to the discrepancy, or the statement that the records cannot give one; whether `rstopAll`'s hypothesis narrows; the form of each new
statement within what its row claims; which rows are one theorem and its corollary; what is formalized and what is named as a
hypothesis; and the order after item 5. Two minds planned what you stand on, and neither read the pinwheel's arguments: where the
foundation does not carry what a row reads, say so by message before working around it — a change now is cheap. Attack the rows: a
statement true only at a narrower class than its entry says is the finding this job is best placed to make, and the second pass made
three. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-wave7-third.md","w").write(b)
print("written",JOB,"at tip",TIP,"| w7m",M7,"| main",MAIN,"| wave 8 landed:",LANDED8)
