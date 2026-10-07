exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import subprocess
# FS131-K9b: wave 9's second planning pass (short). Re-runnable while the job is unlaunched: it reads whether wave 8 has landed on
# origin/main and words the merge of `main` accordingly (a brief not yet launched is rewritten, never amended).
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
KP="plans/FS131-kernel-plan.md"
PIDENT="de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow"
TREE="fs131-w9"; JOB="FS131-K9b"; W=WT+TREE+"/"
TIP=sh("git","-C",W,"rev-parse","--short=8","HEAD")
MAIN=sh("git","-C",ROOT,"rev-parse","--short=8","origin/main")
W6TIP=sh("git","-C",ROOT,"rev-parse","--short=8","origin/fs131-w6")
P="Proofs/HadwigerNelson/Plane/"
LANDED8=sh("git","-C",ROOT,"ls-tree","--name-only","origin/main",P+"RingCalculus/SemiHub.lean")!=""
W8=(P+"RingCalculus/") if LANDED8 else WT+"fs131-w8c/"+P+"RingCalculus/"
REC=W+"plans/FS131-w9-kernel-plan.md"
BEND=W+P+"Classes/Bend.lean"; QF=W+P+"Classes/QFree.lean"; MAPS=W+P+"Reduction/Maps.lean"; RB=W+P+"Reduction/Basic.lean"
RI=WT+"fs131-w6/"+P+"Saturated/ReduceI.lean"
VM=P+"ValidMap/"
COPY=f'''to spare a rebuild of everything `main` gained since your branch left it, copy a green build of `main`'s line over
   yours before you build — `cp -a /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8l/.lake/build/. {W}.lake/build/` — and only
   while no `lake` runs in that source tree (`pgrep -x lake`, then `readlink /proc/<pid>/cwd` for each)'''
TRIAL="my trial of `origin/main` into `origin/fs131-w9` conflicts in `ARCHITECTURE.md`, `Proofs.lean` and `scripts/Axioms.lean` and nowhere else — registry files, adjacent lines, both sides kept; `Plane/SimpleOn` and `Plane/RingCalculus/Basic` are the same files on both sides, by ancestry"
if LANDED8:
    W8NOW=f"wave 8 landed on `main` today (`origin/main` is at `{MAIN}`)"
    MERGE8=f'''2. **Merge `origin/main`** (at `{MAIN}`), your first act after the readback: it brings wave 8 — the ring calculus, with the two
   lemmas quoted above — and the gate's new step; {TRIAL}. And {COPY}. Build once. Commit and push.'''
else:
    W8NOW="wave 8 is landing as you start: a landing job is running the gate on its joined tree"
    MERGE8=f'''2. **`main` is merged on my message.** Wave 8 — the ring calculus, with the two lemmas quoted above — is landing as you start.
   When it has landed I send you one message with `main`'s hash: at your next saved stage merge `origin/main` then ({TRIAL});
   {COPY}; build; and tell me the hash. Items 5 and 6 below wait for that merge; items 3, 4 and 7 do not. Until then build the
   branch once as given (five `sorry` leaves).'''
ITEMS=[533,536,566,593,556,568,592]
ITEMQ="\n".join(item(n) for n in ITEMS)+"\n"
RQ=["- **A second planning pass** is small","- **Two implementers split by file.**","- **At the join with wave 8**","**B. `bendAny`**","- B1. ","- B2. ","- B3. ","- B4. ","- B5. ","- **Price**: 400–700k tokens",
    "**D. `not_hasRepeatedColour_of_simpleOn`**","**M. Models owed before","- **FS129-SR1-BENDANY** — row quoted","| `Row130Collapse` |","| `WEqKLimit K k` |","| `MapNO 6` (Q-NO) |","Inside the milestone, discharged at a join"]
RECQ="\n".join(Q(REC,p) for p in RQ)+"\n"
L9="\n".join([Q(BEND,"theorem bendAny "),Q(QF,"theorem not_hasRepeatedColour_of_simpleOn "),Q(QF,"def GammaFreeEmptyNS "),Q(QF,"theorem qfreeNS "),
              Q(MAPS,"def ReduceToMap "),Q(MAPS,"theorem top5 "),Q(RB,"theorem exists_arcMap_of_arcBounded ")])+"\n"
L8="\n".join([Q(W8+"SemiHub.lean","theorem simpleOn_not_hasRepeatedColour "),Q(W8+"Empty.lean","theorem emptyNS ")])+"\n"
L6="\n".join([Q(RI,"def HasArcInterfaces "),Q(RI,"theorem exists_arcMap_of_hasArcInterfaces "),Q(RI,"def ArcInterfacesOfRegJ "),Q(RI,"theorem reduce_i_of_arcInterfaces ")])+"\n"
L5="\n".join([Q(VM+"CollarMapOut.lean","structure CollarFitOut "),Q(VM+"BendGap.lean","theorem exists_collarFitOut "),Q(VM+"BendGap.lean","theorem bend_away_gap "),
              Q(VM+"UnitArc.lean","theorem bend_away_whole "),Q(VM+"BendCollar.lean","theorem bend_toward_collar "),Q(P+"Tiles.lean","theorem not_mem_closure_wholeRestrict_R₂ ")])+"\n"
ASSUME=Q("LEAN.md","- **Every assumption in hypothesis form is declared to the gate**","§ Assumptions")
b=f'''# Brief {JOB} — wave 9's second planning pass: the long leaf split for implementers, and the wave's two joins

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {PIDENT}
  role: wave 9's second planner, a short pass — put the wave's long leaf (`bendAny`, the bend on a fragment at any number of colours) through the obligation-modeling pass the first planner did not run, decide its hard child's route against the landed source, and state its children as `sorry` leaves in a split that fits implementers' budgets; retire a leaf that wave 8 has proved; make the join with wave 8 and plan the join with wave 6; list the wave's assumptions for its landing
  launch: when a slot frees, in the tree the first pass (FS131-K9) handed back; no implementer has started on `Classes/`, and an implementer may be at work on `Reduction/` on a branch of its own while you plan
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a statement of landed wave 5 you find you need a twin of (at once, with the statement: I rule where it lives), a defect in `bendAny`'s statement (at once — three proved theorems read its clauses), a statement you change at a join, a generalization or a shorter route, or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate: the inhabitant rule and the doubled-name check; § Assumptions; § Searching — Lean, last bullets), and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w9-kernel-plan.md` (on branch `{TREE}`; the first pass's record — your stages continue its numbering from Stage 6, headed {JOB})
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, at `{TIP}`): `{P}Classes/Bend.lean` and `{P}Classes/QFree.lean` (new declarations and `sorry` children; an existing statement only as items 5 and 6 below say, or after a message), new modules under `{P}Classes/`, with `Proofs.lean`, `ARCHITECTURE.md` and `scripts/Axioms.lean` (a block of your own, headed "{JOB}", above the `=== PURCHASED ===` banner) for them and for the merge; `plans/FS131-w9-kernel-plan.md`, `tools/fs131_k9b_*.py`, `data/fs131/k9b/`, `data/fs131/reports/{JOB}.md`; **not** anything under `{P}Reduction/` (three of its leaves and a new models module are an implementer's, on a branch cut from `{TIP}`), `{P}SimpleOn.lean` and `{P}RingCalculus/` (wave 8's), any landed module (a twin of a landed statement goes in a module of yours, never into the landed file), wave 6's tree, `main`, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 450k — read your token count at every saved stage

Hello. You are the second planner of wave 9 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5, wave 10 and half of wave 6 are on `main`, and {W8NOW}. Wave 9 is eleven rows: the reductions from a
measurable colouring to a map, and the bend on a fragment that carries the "no (Q) arc" results from the simple class to every class. Its
first planner stated all eleven and proved five; five leaves are left, and one of them — `bendAny` — is priced above what one implementer
holds and was decomposed from a reading alone. The planner said so plainly, and asked for exactly this pass.

## Why this job

A result counts as held only when its Lean module passes the gate. `bendAny` is the wave's weight: three theorems are already proved from
it and are not theorems until it is, among them the statement that in the class with no Siamese pair a four-colour vertex whose ring
carries no (Q) arc dies just past radius 1 (`LEDGER.md` row 149). Its fourth child bends *away* on a fragment of radius below 2, where
the landed away bend's hypothesis is false — the one place in this wave where a new geometric lemma, or a twin of a landed one, may be
owed. An implementer started on the leaf as it stands would meet that question at 300k tokens with no way to split the work; you meet it
first, with the landed source open. Kooshi, on pricing this work:

{KOOSHI}
What the first pass handed back, what has happened since, and the rulings in force (read each item whole in the inventory,
`plans/FS131-close-inventory.md`; the first lines are quoted here as addresses):

{ITEMQ}The milestone's plan binds every wave's planning job (read its §§ 7.1–7.5 whole):

{Q(KP,"### 7.3 What each wave's planning job must hold")}
{Q(KP,"3. **States every row at the class its argument reads**")}
{Q(KP,"5. **Checks vacuity at the seam**")}
And since today the gate lists what the library assumes:

{ASSUME}
## The statements

**What the first pass left you, in its words** — the first lines of the paragraphs that are yours; read its record whole
(`/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/plans/FS131-w9-kernel-plan.md`):

{RECQ}
**Wave 9's statements this pass works on** (each head's first line; the whole statement is at its address):

{L9}
**Two theorems wave 8 has proved** — the first is your leaf `not_hasRepeatedColour_of_simpleOn`, binder for binder but for names (compared
by me, by reading both); the second is what `GammaFreeEmptyNS` abbreviates:

{L8}
**Wave 6's statements at the other join** (on `origin/fs131-w6` at `{W6TIP}`, a planning line with open leaves; not on your branch and
not to be merged into it):

{L6}
**The landed bends your record's B3 and B4 name** (wave 5, on `main`):

{L5}
## Done means

1. **Your readback first**: check every quotation above against its source; read the record whole, the wave's five modules, and the
   plan's §§ 7.1–7.5. Register, before you read the landed bends' source: whether B4 will need a twin of a landed statement, how many
   children `bendAny` will have, and how many implementer jobs. Open your stages in the record with what you may and may not change.
   Commit and push.
{MERGE8}
3. **`bendAny` through `debruijn-obligation-modeling`** (invoked fresh) — the first pass's disclosed omission: its B1–B5 are from a
   reading. `#check` the leaf as stated and compare the kernel's statement with the file's (a section `variable` enters a theorem only
   if its statement mentions it: inventory items 556, 564), and read its binders against the row's *not claimed* line (items 568, 592:
   twice today a planner's hypothesis did not match its row, and the build could not see it). A defect is a message to me before you
   change anything: `bendLE3`, `exists_gammaFree_of_qFree` and `qfree_class` are proved from its clauses.
4. **B4's route, decided against the landed source.** Read `CollarFitOut`'s fields, `exists_collarFitOut`'s use of the domain, and
   `bend_away_whole`, with N2's route in `plans/FS129-SR1-audit.md` § 2.1. Either the collar away bend follows from the landed
   statements with `hR2` in place of the domain hypothesis, and your plan says how; or a twin of a landed statement is needed — then
   **message me at once with the twin's statement**, and state it in a module of yours as a `sorry` leaf (the landed file is not
   edited). A fit of that structure on a concrete map is being built at this moment by an implementer on another branch — a named
   `CollarFitOut` on `awayModel`'s gap; its record,
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wd2/plans/FS131-MD2-implementation.md`, shows how each field is met in
   practice, and bears on your model M4 too. It is not landed: read it, cite nothing from it.
5. **Leaf D is not proved again** (inventory item 593). Once `main` is merged, `not_hasRepeatedColour_of_simpleOn` is wave 8's
   `simpleOn_not_hasRepeatedColour`: close it by that citation, or remove the name and have its readers cite wave 8's — yours; say
   which in your record. Before the merge, leave it.
6. **The join with wave 8**, once `main` is merged: `GammaFreeEmptyNS` is discharged by `emptyNS` (check the two binder for binder as
   `emptyNS` stands today), and the hypothesis `hE` leaves `qfreeNS` and every statement that carried it — the gate's new step lists
   every named hypothesis a theorem takes, and one that is a theorem of the library is not an assumption. Each statement this changes
   is named in your record and your report.
7. **The join with wave 6, planned and not made** (rulings 533 (a), 566 (a)). You do **not** merge wave 6's line: it holds sixty-two
   open leaves, two of them a deriver's, and a merge would chain this wave's landing to all of them. Read `ReduceI` at its path and
   write in your record the exact declaration that will make `top5`'s instance — which `P`, which `RegJ`, and
   `reduce_i_of_arcInterfaces` over `ArcInterfacesOfRegJ 5` discharging `ReduceToMap` — to be made at whichever of the two landings
   comes second. And compare your proved `exists_arcMap_of_arcBounded` with wave 6's open leaf `exists_arcMap_of_hasArcInterfaces`: if
   the leaf follows from the theorem in a few lines, write the lines, so that wave 6's implementer cites it after this wave lands in
   place of proving it from nothing (one statement, one proof); if it does not, say what the leaf needs beyond it.
8. **The children, stated**: `bendAny`'s decomposition as `sorry` leaves beneath it, each `#check`ed, in a split that fits
   implementers — a job proves about 1,300 lines (inventory item 541) — with which jobs can run side by side and from which commit.
   **Before you state a helper, search the tree for its statement's shape, not for a name** (items 584, 596: today an implementer wrote
   two weaker copies of landed theorems, and three lemmas a plan called missing were in the library).
9. **Inhabitants and assumptions.** The five models M1–M5 are a condition of the wave's gate (ruling 536 (c)); for M4 and M5, which go
   with `bendAny`'s implementer, read the candidate's statement and say whether it is the model or what is missing. **And list, for the
   wave's landing, every assumption in hypothesis form that any statement of the wave takes** — `Row130Collapse` (declared on `main`
   already), `WEqKLimit`, `MapNO`, the binder `ReduceToMap P RegJ` of `top5`, and any other — each with its kind (an outside theorem, a
   hand result of ours, an open question) and source, in the form of `LEAN.md` § Assumptions: the landing declares from your list. You
   declare nothing yourself and run no gate.
10. **Both readings of "simple" land** (ruling 536 (b)): there is nothing to collapse, whatever the first pass's handoff says.
11. **The skeleton**: builds through the worktree's `./scripts/build.sh` with only `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md`
   (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated; no new `axiom`, no `native_decide`; `./scripts/dupnames.sh`
   on your tree — no name declared by two modules.
12. **Your record**: a plan per child (route, the Mathlib and library lemmas confirmed with `#check`, what is hard, a price **in lines
   of Lean and in implementer jobs, never in days**), and a handoff for implementers by file. A child you can prove in about an hour,
   prove, and say so. Then the report, in standing rule 11's form. You run no gate and do not touch `main`. Leave no background
   process running, and keep what your record cites under `data/fs131/k9b/`. Stopping at a saved stage and saying what is left is a
   good report.

## What is yours to decide

B4's route; the children and their statements; the split into jobs; what happens to leaf D's name; the form of the two joins within the
rulings quoted; and the order after the readback. One mind planned what you stand on, and it flagged B4 as the place it was least sure of:
if the landed source shows the route does not go, say so with the line that decides it — that is the finding this pass exists to make,
and a deriver's question if it comes to that. Three failed attempts on one route is a dispatch to the companion your identity names,
never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-wave9-second.md","w").write(b)
print("written",JOB,"at tip",TIP,"| main",MAIN,"| w6",W6TIP,"| wave 8 landed:",LANDED8)
