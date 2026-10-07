exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# Wave 7's implementers after the third planning pass (ruling 604 (c)). Usage: mk-i7.py L|B1|B2|FA
#   L  — FS131-I7L : `FourColour/Local`'s nine leaves, with `anchor` (RouteT/Rainbow) first        tree fs131-w7l
#   B1 — FS131-I7B1: `FourColour/Bowtie`'s first eight leaves                                       tree fs131-w7b
#   B2 — FS131-I7B2: `Bowtie`'s FS114-Y4-DIAG leaves and the composition, after B1, on B1's branch  tree fs131-w7b
#   FA — FS131-I7FA: the bowtie fragment's first job (the object), new module                       tree fs131-w7f
# Make the lane's tree from wave 7's tip first. With DRY=1 OUT=<scratch path> the planner's tree (fs131-w7) is read instead
# and the brief goes to scratch for a gate dry run — never launch a dry run.
import sys,subprocess,re,os
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
LANE=sys.argv[1]; DRY=os.environ.get("DRY")=="1"
TREE={"L":"fs131-w7l","B1":"fs131-w7b","B2":"fs131-w7b","FA":"fs131-w7f"}[LANE]
JOB={"L":"FS131-I7L","B1":"FS131-I7B1","B2":"FS131-I7B2","FA":"FS131-I7FA"}[LANE]
W=WT+(TREE if not DRY else "fs131-w7")+"/"
BASE=sh("git","-C",W,"rev-parse","--short=8","HEAD")
assert BASE,"make the worktree first (or DRY=1)"
P="Proofs/HadwigerNelson/Plane/"; V=W+P; REC=W+"plans/FS131-w7-kernel-plan.md"
HASMAIN=subprocess.run(["git","-C",W,"cat-file","-e","HEAD:"+P+"RingCalculus/SemiHub.lean"],capture_output=True).returncode==0
LANDED8=sh("git","-C",ROOT,"ls-tree","--name-only","origin/main",P+"RingCalculus/SemiHub.lean")!=""
MAIN=sh("git","-C",ROOT,"rev-parse","--short=8","origin/main")
def leaves(path):
    t=open(path).read(); out=[]
    for m in re.finditer(r"^theorem (\S+)(.*?)(?=^(?:theorem|lemma|def|structure|/--|end |namespace |section |@\[|variable|omit|include)|\Z)",t,re.M|re.S):
        if re.search(r"^\s*sorry\s*$|:= sorry|by sorry",m.group(0),re.M): out.append(m.group(1))
    return out
LOC=V+"FourColour/Local.lean"; BOW=V+"FourColour/Bowtie.lean"; RAIN=V+"RouteT/Rainbow.lean"
# FINALIZE this list from the third planner's handoff before a B lane is launched (it was still editing `Bowtie` when this was written).
DIAG=["IsReuleauxBowtie.top_arc","IsReuleauxBowtie.top_arc'","IsReuleauxBowtie.corner_tiles_toward","IsReuleauxBowtie.outside_ring_colour","col_eq_of_tiles_toward","not_mem_dom_of_tiles_toward","IsReuleauxBowtie.partner_cone_of_far","IsReuleauxBowtie.rstopAll"]
SH8=(P+"RingCalculus/SemiHub.lean") if LANDED8 else WT+"fs131-w8c/"+P+"RingCalculus/SemiHub.lean"
COPY=f"to spare a rebuild of everything `main` gained, copy a green build of `main`'s line over yours before you build — `cp -a /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8l/.lake/build/. {W}.lake/build/` — and only while no `lake` runs in that source tree (`pgrep -x lake`, then `readlink /proc/<pid>/cwd` for each)"
ITEMS=[604,601,553,564,556,573,596]
EXTRA=""; PRE=""
if LANE=="L":
    L=leaves(LOC); assert len(L)==9,L
    WHAT="the local lemmas at a four-colour vertex"; FILES=f"`{P}FourColour/Local.lean` (nine leaves) and `anchor` in `{P}RouteT/Rainbow.lean`"
    ROLE="wave 7's implementer for the local lemmas — prove `anchor`, then the nine open leaves of `Local`, from the planners' plan, without changing a statement, saving after each leaf or group"
    LAUNCH="when a slot frees and `main` holds wave 8; the wave's other implementers work on `Bowtie` and on the fragment in trees of their own, from the same line"
    STM="\n".join([Q(RAIN,"theorem anchor ")]+[Q(LOC,"theorem "+n+" ") for n in L])+"\n"
    PLANQ=["- **`Plane/FourColour/Local`** (13 leaves","*Re-priced from this pass's proved leaves","**The obligation-modeling pass**","- **J1 ","- **J2 ","- **J3 ","- **J5 ","Mutation audit (statement level)",
           "| `sides`, `sides'` |","| `pair` |","| `ring_odd`, `ring_odd'` |","| `IsTacticAt.lens_cone` |","| `IsTacticAt.flank` |","| `IsTacticAt.four_le_centre` |",
           "**Leaves whose statement this stage changed** (all in `Local`","- **A statement defect of the skeleton, found here","- **J4 is not minted**"]
    PLAN="\n".join(Q(REC,p) for p in PLANQ)+"\n"+Q(REC,"| `qArc_others_absent` |",contains="four tiles at `p`")
    W8Q="\n".join(Q(SH8,"theorem "+n+" ") for n in ["simpleOn_not_hasRepeatedColour","qcol_inner_tile"])+"\n"
    if HASMAIN:
        PRE="Your tree holds `main` with wave 8 (the planner merged it): the two lemmas of wave 8 quoted below are in your tree."
        MERGE="Build the branch once as given."
    else:
        assert LANDED8 or DRY,"I7L launches only when wave 8 is on main (ruling 604 (c))"
        PRE=f"**Your first act merges `origin/main`** (at `{MAIN}`): two of your leaves cite lemmas of wave 8, which landed there today."
        MERGE=f"**Merge `origin/main`** (at `{MAIN}`): my trial of it into the wave's line conflicts in `ARCHITECTURE.md`, `Proofs.lean` and `scripts/Axioms.lean` and nowhere else — registry files, adjacent lines, both sides kept; `Plane/SimpleOn` and `Plane/RingCalculus/Basic` are the same files on both sides, by ancestry. And {COPY}. Build once; `./scripts/dupnames.sh`. Commit, push, and **send me the merge's hash** (the wave's line is moved onto it)."
    EXTRA=f'''**The two lemmas of wave 8 your leaves cite** — `four_le_centre` cites the first (the planner's joint J4 is not minted: it is
this lemma), and `qArc_inner`'s old arc clause is the second (no longer stated in `Local`; cite it where a proof wants it):

{W8Q}
'''
    ORDER="`anchor` first (rulings 564 (a)–(b): `Rainbow` may import `Plane.ValidMap.Pushforward` and `Plane.ValidMap.Contact`, with `ARCHITECTURE.md`'s row and `tools/check_architecture.py` exit 0); then the joints J1, J2, J3 and J5's second half as lemmas of your own; then `sides`, `sides'`, `pair`; `lens_cone` (at its corrected statement, `ψ < ψ'` — one mind's correction, not yet proved: if it too is false, that is a message), `flank`, `four_le_centre`; `qArc_others_absent`; `ring_odd`, `ring_odd'` last (its parity lemma is the one piece with an induction)"
    PRICE="about 1,050 lines for the nine and about 140 for `anchor`, by the planners"
    NOT=f"`{P}FourColour/Bowtie.lean` and anything else under `{P}FourColour/` (other implementers'), `{P}RouteT/Count.lean` and `Grid12.lean` (proved)"
    TOUCH=f"`{P}FourColour/Local.lean` and `{P}RouteT/Rainbow.lean` — proofs, the two import lines ruled for `Rainbow`, and new helper declarations under names no other module declares"
elif LANE in ("B1","B2"):
    L=leaves(BOW); B2=[n for n in L if n in DIAG]; B1=[n for n in L if n not in DIAG]
    if LANE=="B1":
        MINE=B1
        WHAT="the bowtie's first half — the lune, the side germs, the cap"; FILES=f"`{P}FourColour/Bowtie.lean` (its first {len(B1)} open leaves)"
        ROLE="wave 7's first implementer for the bowtie — prove `own`, the side germs, the two absent-colour leaves, `lune` and the three cap leaves, from the planners' plan, without changing a statement, saving after each leaf or group"
        LAUNCH="when a slot frees; the second half of the file (FS114-Y4-DIAG's leaves and the stop) is a later job's, on your branch after you"
        PLANQ=["| `own` |","| `IsReuleauxCross.lune` |","| `cap_colour`, `cap_colour'`, `exists_cap_tile` |","**The children** (`Bowtie.lean`","| `IsReuleauxCross.exists_side_germs` (any `k`) |","| `IsReuleauxCross.side_colour_absent`, `'` (any `k`) |","- **J1 ","- **J3 ","**D1 (N3-HALF's last clause).**"]
        ORDER="`own`; `exists_side_germs`, then `side_colour_absent` and its mirror; `lune` (the planner's largest of yours: its step (3) wants a connectedness argument on the side arc in place of the hand proof's rotation at a vertex); then the three cap leaves"
        PRICE="about 900 lines by the second planner, plus about 200 for the three side leaves the third added"
        NOT=f"the six leaves of the file's second half ({', '.join('`'+n+'`' for n in B2)} — a later job's: leave their `sorry`), `{P}FourColour/Local.lean` (another implementer's: its leaves are statements you may cite and may not prove), anything else under `{P}FourColour/`"
    else:
        MINE=B2
        assert not B1 or DRY,"I7B2 launches after I7B1's hand-back, on its branch"
        WHAT="the bowtie's stop — FS114-Y4-DIAG's five steps and the composition"; FILES=f"`{P}FourColour/Bowtie.lean` (its last {len(B2)} open leaves)"
        ROLE="wave 7's second implementer for the bowtie — prove `top_arc` and its mirror, `corner_tiles_toward`, `outside_ring_colour`, `partner_cone_of_far` and the composition `rstopAll`, from the third planner's split, without changing a statement, saving after each leaf"
        LAUNCH="when a slot frees, on the branch the bowtie's first implementer handed back"
        PLANQ=["**The hypothesis narrows:","**YB2-RPREC, and why the split needs no second-order estimate.**","**The children** (`Bowtie.lean`","| `IsReuleauxBowtie.top_arc`, `top_arc'` |","| `IsReuleauxBowtie.corner_tiles_toward` |","| `IsReuleauxBowtie.outside_ring_colour` |","| `IsReuleauxBowtie.partner_cone_of_far` |","About 1,650 lines with the cap leaves' reuse","- **J1 ","- **J3 "]
        ORDER="the shared lemma about the tiles at `top` first (the planner prices it as saving about 200 lines across `top_arc` and its mirror); `top_arc`, `top_arc'`; `corner_tiles_toward`; `outside_ring_colour`; `partner_cone_of_far`; `rstopAll` last, with the one helper its row names as owed"
        PRICE="about 1,450 lines by the third planner"
        NOT=f"`{P}FourColour/Local.lean` (another implementer's), the first half of `Bowtie` (proved by your predecessor: cite it), anything else under `{P}FourColour/`"
    ROLE=ROLE; STM="\n".join(Q(BOW,"theorem "+n+" ") for n in MINE)+"\n"
    PLAN="\n".join(Q(REC,p) for p in PLANQ)+"\n"+(Q(REC,"| `IsReuleauxBowtie.rstopAll` |",contains="the composition") if LANE=="B2" else "")
    MERGE="Build the branch once as given."
    PRE="`main` is not merged into your branch and need not be: nothing of yours reads wave 8."
    TOUCH=f"`{P}FourColour/Bowtie.lean` — proofs of your leaves, and new helper declarations under names no other module declares"
else:
    WHAT="the bowtie fragment, first job — the object"; FILES=f"a new module `{P}FourColour/BowtieFragment.lean`"
    ROLE="the first of four implementers who put the wave's explicit example map in the kernel — define the twenty-tile six-colour map by formula from the tool that built it, prove its colour function locally constant, identify its twenty tiles, and prove it covers the closed disc of radius `3√3/5`; fix the names the other three jobs will prove things about"
    LAUNCH="when a slot frees; the three jobs after you (validity; non-Siamese and simple; the bowtie predicates and the examples) start from your hand-back and run side by side"
    STM="\n".join([Q(V+"FourColour/Basic.lean","structure IsTacticAt "),Q(V+"FourColour/Basic.lean","structure IsReuleauxCross "),Q(V+"FourColour/Basic.lean","structure IsReuleauxBowtie "),
                   Q(P+"ArcMap.lean","def Covers "),Q(P+"ArcMap.lean","def Valid ")])+"\n"
    PLANQ=["**This section replaces § 7.5's paragraph","**The object** — `tools/fs114_yb2_run.py` ll. 152–215","- **Points**:","- **Seven base tiles**","- **Twenty tiles** by `D₂`","- **Same-colour pairs: 46**","- **The rim**:","- **At the named points**:",
           "**What the first job checks at its readback, and stops on**","- **(A)** the object","- **(B)** validity","- **(C)** non-Siamese","- **(D)** `IsReuleauxBowtie 0 0 t2 t4`","(A) fixes the names;","**The route: the map by formula, as wave 3's `sixFrag`**","**Price: about 5,500 lines"]
    PLAN="\n".join(Q(REC,p) for p in PLANQ)+"\n"
    MERGE="Build the branch once as given."
    PRE="`main` is not merged into your branch and need not be: nothing of yours reads wave 8."
    ORDER=""; PRICE="about 1,400 lines by the planner, for this job of the four"
    NOT=f"`{P}FourColour/Local.lean`, `Bowtie.lean`, `Basic.lean` (the wave's stated modules: other implementers', and the foundation), `{P}SixFragment.lean` (landed: read it as the pattern, change nothing)"
    TOUCH=f"the new module `{P}FourColour/BowtieFragment.lean` (and a second beside it if the object and its tile lemmas want two), with `Proofs.lean` and `ARCHITECTURE.md` for it"
ITEMQ="\n".join(item(n) for n in ITEMS)+"\n"
lane=LANE.lower()
HEAD=f'''# Brief {JOB} — wave 7, {WHAT}, on `{TREE}`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: {ROLE}
  launch: {LAUNCH}
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf or a hypothesis that is false or cannot be met as stated (at once, with the configuration: a statement change goes back through me — and say which kind you have, a *statement* that needs a hypothesis it lacks, or a *route* that reads more than the statement needs), a helper you need that another of the wave's implementers would need too (so that one of you writes it), or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, at `{BASE}`): {TOUCH} (`./scripts/dupnames.sh` before each push that adds names); `scripts/Axioms.lean` (a block of your own, headed "{JOB}", above the `=== PURCHASED ===` banner), `plans/{JOB}-implementation.md`, `tools/fs131_i7{lane}_*.py`, `data/fs131/i7{lane}/`, `data/fs131/reports/{JOB}.md`; **not** any statement, {NOT}, `{P}SimpleOn.lean` and `{P}RingCalculus/` (wave 8's), any landed module, `main`
  budget: {BUDGET}
'''
INTRO='''Hello. You are proving part of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked
ones. Wave 7 is about a vertex where four colours meet in a tight six-colour map of the plane — what such a vertex forces within an
explicit radius. Three planners have worked on it: the first stated and an implementer proved the counting half; the second wrote the
four-colour foundation (the tactic edge, the Reuleaux cross and bowtie) and stated two modules of leaves; the third, today, read every
one of those leaves back from the kernel, corrected seven statements, split the longest leaf into eight, and settled which explicit map
the wave's examples are about.'''
WHY=f'''A result counts as held only when its Lean module passes the gate. These leaves are the local half of the unit-arc question (`LEDGER.md`
rows 137–138; `CLAUDE.md` § Where the problem stands, item 31): the bowtie's stop says a Reuleaux bowtie at a four-colour vertex cannot
live in a disc of radius `√3`. Kooshi, on pricing this work:

{KOOSHI}
What the planners handed back, and the rulings in force (read each item whole in the inventory, `plans/FS131-close-inventory.md`):

{ITEMQ}'''
TAIL=f'''4. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not
   merge another branch beyond what item 1 names, run the gate, or touch `main`. **After your last green build, the guarded lint** —
   `lake lint --no-build -- --no-build --trace` under the slot with `--mem 8` (`LEAN.md` § The gate), its output saved (inventory item
   573). Leave no background process running, and keep what your record cites under your `data/` folder.
5. **Your record**, stages headed "Stage n — SAVED ({JOB})", "Theorems this phase proved", each read against its row; the report in
   standing rule 11's form, ending with what is left and its route. Stopping at a saved stage with part of the work done is a good
   report.
'''
CHECKS=f'''a build, the axioms print for it with a control that fires, a statement check on elaborated signatures against `{BASE}` — the wave's
   instruments are on your branch: `{W}tools/fs131_i7a_stmt_check.py` and the third planner's kernel-signature reader
   `{W}tools/fs131_k7c_kernelsig.py` with `{W}data/fs131/k7c/kernel-sigs.lean` — commit, push'''
if LANE!="FA":
    body=f'''{HEAD}
{INTRO} One of those two modules' halves is yours. {PRE}

## Why this job

{WHY}## The statements

No statement changes in this job. Your leaves, as they stand in your tree (each head's first line; read each whole, with its docstring):

{STM}
{EXTRA}The plan — the planners' record, `{REC}`: read Stages 5–7 (the second pass) and 11–13 (the third) whole; these are the first lines of
the paragraphs and rows that are yours:

{PLAN}
## Done means

1. **Your readback first**: check the quotations against their sources; read the record's stages named above, your module and those
   it imports, and each row's derivation entry at the address the record gives. {MERGE} `#check` every leaf of yours and read the
   binders the kernel shows (inventory item 556) — the third planner did this for all of them an hour ago, so a difference is a
   finding. Open your record with what you may and may not change. Commit and push.
2. **The leaves**, in this order: {ORDER}. Save after each leaf or group ({CHECKS}). **Before you prove a helper, search the tree
   for its statement's shape, not for a name** (inventory item 596: an implementer wrote two weaker copies of landed theorems, and
   three lemmas a plan called missing were in the library). Re-price after your first two leaves and say so: {PRICE}.
3. **The inhabitant is not yours, and its absence is not a defect**: every structure-valued hypothesis here names the bowtie fragment
   as its Lean model, and that map is being put in the kernel by four other jobs; each leaf's docstring keeps the planner's line on
   what is owed. A hypothesis you find no map can meet is a message to me — that would be a finding about the row.
{TAIL}
## What is yours to decide

The route inside each leaf, your helpers, and the order within the plan's dependencies. The plan is three minds', none of whom proved
your leaves: change a route that does not go and say so. A statement is not yours to change: one that is false, or true only with a
hypothesis the plan did not see, is a message to me, and a finding — the third planner found one that way this morning. Three failed
attempts on one route is a dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
else:
    body=f'''{HEAD}
{INTRO} What none of them could do is exhibit the map itself: every hypothesis of the wave that is a structure — a tactic edge, a
Reuleaux cross, a bowtie — names one explicit twenty-tile map as its example, and that map exists today only as a Python tool's output.
Until it is a Lean object the wave cannot pass the gate, whatever is proved about it. Putting it there is four jobs; yours is the first,
and the other three build on the names you fix. {PRE}

## Why this job

{WHY}**Which map**, since two are on file: the coordinator ruled this morning (inventory item 601, ruling (a)) that the kernel holds the
verifier's rebuild — `tools/fs114_yb2_run.py` — and not the original construction's (`tools/fs114_y2_k1.py`), because the rebuild is an
example for strictly more of what waves 7 and 8 state. The ruling carries a condition, and you are the one who checks it (item 1 below).

## The statements

There is no leaf to prove: you write the object and its first theorems. The structures the object must in the end inhabit (the fourth
job proves that it does; you make sure the object is the one that can), and the two predicates your own theorems are about:

{STM}
The plan — the third planner's Stage 13 and the second's § 7.5 in the wave's record, `{REC}`: read both whole; these are the first
lines of the paragraphs that are yours:

{PLAN}
## Done means

1. **Your readback, and the ruling's condition.** Check the quotations against their sources. Read the tool (`tools/fs114_yb2_run.py`,
   ll. 152–215) and its description in words (`plans/FS114-YB2-verification.md` ll. 110–132), the foundation module, and wave 3's
   `{P}SixFragment.lean` — the pattern you follow, a six-colour map by inequalities. Then, before any Lean: **check on paper and with
   the tool as it is that the rebuild meets each hypothesis the planner lists** — the Reuleaux cross at the centre, the four tactic
   edges with their partners, "simple" at the two corners and at the centre — and that its pair bounds do not price well above the
   plan's. **If one fails, stop and message me with which and why**: the ruling then turns to the other map, and nothing you would
   have built is lost. You may run the existing tools on the objects they hold; nothing that searches. Build the branch once as given.
   Open your record. Commit and push.
2. **The object**: the map by formula — its colour function by inequalities over `ℚ(√3)` data, as `sixFrag` is — named `bowtieFrag`,
   in the module the plan names, with its named points and its twenty tiles as declarations the next three jobs can cite. The two
   reflections are carried by hand (no isometry transport of an `ArcMap` exists in the library): the planner makes that small
   transport for this one map's colour function your first child.
3. **Its first theorems**: local constancy of the colour function, each of the twenty tiles identified with its region, and
   `bowtieFrag.Covers 0 (3 * √3 / 5)`. Save after each ({CHECKS.replace("a statement check on elaborated signatures against `"+BASE+"` — the wave's","the wave's")}). **Before you prove a helper, search the tree for its statement's shape, not for a name** (inventory item 596) —
   `SixFragment` and the example maps under `{P}Models/` hold many of the lemmas a map by formula needs. Re-price after the object and
   its first theorem, and say so: {PRICE}.
3a. **The hand-off to the three jobs after you** is part of this job: in your record, the names you fixed, each tile's defining
   inequalities in one table, the list of same-colour pairs by symmetry class (the planner leaves the dozen classes to you, from the
   tool's output), and what each of jobs (B), (C), (D) can cite — written so that three colleagues can start side by side from your
   last commit without asking you anything.
{TAIL}
## What is yours to decide

The form of the colour function, the layout of the module, the names, and the order after item 1. The plan is one mind's reading of a
tool and a verifier's record; it was not elaborated. If the rebuild is harder to state by formula than the plan expects, say what makes
it so — that is information the ruling wants. Three failed attempts on one route is a dispatch to the companion your identity names,
never a fourth. {NOSPAWN}

{MACHINE}'''
SLUG={"L":"wave7-local","B1":"wave7-bowtie-first","B2":"wave7-bowtie-second","FA":"wave7-fragment-object"}[LANE]
OUT=os.environ.get("OUT") if DRY else ROOT+"data/fs131/briefs/"+JOB+"-"+SLUG+".md"
open(OUT,"w").write(body)
print("written",JOB,"base",BASE,"| has main:",HASMAIN,"| wave 8 landed:",LANDED8,"| dry:",DRY,"->",OUT)
