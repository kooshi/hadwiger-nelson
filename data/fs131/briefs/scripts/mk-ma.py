exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import sys
LANE=sys.argv[1]   # "A" or "B"
M=WT+("fs131-wm/" if LANE=="A" else "fs131-wmb/"); MD=M+"Proofs/HadwigerNelson/Plane/Models/"
KP=M+"plans/FS131-models-kernel-plan.md"
if LANE=="A":
    JOB="FS131-MA1"; SLUG="FS131-MA1-models-moves.md"; TREE="fs131-wm"; FILES="`Proofs/HadwigerNelson/Plane/Models/Paint.lean`, `Proofs/HadwigerNelson/Plane/Models/Moves.lean`"
    NOT="`Proofs/HadwigerNelson/Plane/Models/Stuck.lean`, `Proofs/HadwigerNelson/Plane/Models/Bends.lean` (implementer B's, later, on a branch cut from yours)"
    WHAT="the general layer's open leaves (`Paint`) and the two painted pictures that are models of the four local moves (`Moves`): `hornModel` for SHAVE and OPEN, `twoHornModel` for MERGE-RAY and MERGE"
    ST=f'''{Q(MD+"Moves.lean","theorem hornModel_shave ")}
{Q(MD+"Moves.lean","theorem hornModel_open ")}
{Q(MD+"Moves.lean","theorem twoHornModel_rayMerge ")}
{Q(MD+"Moves.lean","theorem twoHornModel_merge ")}'''
else:
    JOB="FS131-MB1"; SLUG="FS131-MB1-models-stuck.md"; TREE="fs131-wmb"; FILES="`Proofs/HadwigerNelson/Plane/Models/Stuck.lean`, `Proofs/HadwigerNelson/Plane/Models/Bends.lean`"
    NOT="`Proofs/HadwigerNelson/Plane/Models/Paint.lean`, `Proofs/HadwigerNelson/Plane/Models/Moves.lean` (implementer A's)"
    WHAT="the stuck vertex's model and the doubly shadowed band's (`Stuck`: `stuckModel`, `shadowModel`) and the bends' (`Bends`: `cuspFrag`'s ring arc, `awayModel`, and — ruled, about 30 lines — a plane-map model of `bend_away_whole`)"
    ST=f'''{Q(MD+"Stuck.lean","theorem stuckModel_hyps ")}
{Q(MD+"Stuck.lean","theorem shadowModel_flank_ne ")}
{Q(MD+"Bends.lean","theorem cuspFrag_bend_away ")}'''
b=f'''# Brief {JOB} — the example maps built, half {LANE}: {WHAT.split(":")[0]}

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: implementer {LANE} of the example maps — {WHAT}; every `sorry` leaf of your files proved without changing a statement, in the planner's order, saving after each group
  launch: when a slot frees, on `main`'s line, beside wave 5's jobs on other branches
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the reason: the planner named three places this is most likely), a hypothesis of a landed theorem that the model turns out not to satisfy (at once: that is the finding this lane exists to catch), or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on your branch)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`: {FILES}; new helpers as new declarations in your own files; `scripts/Axioms.lean` (a block of your own, headed "{JOB}", above the `=== PURCHASED ===` banner), `plans/{JOB}-implementation.md`, `tools/fs131_m{LANE.lower()}_*.py`, `data/fs131/m{LANE.lower()}/`, `data/fs131/reports/{JOB}.md`; **not** {NOT}, any landed module (no statement, definition or docstring of a landed declaration is edited: the docstring lines that will name these models are applied when the lane lands), `main`
  budget: {BUDGET}

Hello. You are building Lean objects that show this milestone's central theorems are about something. The milestone, FS-131, turns this project's
hand-derived results into kernel-checked ones, and its gate asks one thing the kernel cannot: that a theorem's hypotheses hold together on some real
object. An audit found that the four local moves the termination procedure runs on, the stuck vertex's family and the bends have no Lean object
satisfying their hypotheses at once — only hand models. A planner has since reduced all of them to one construction — the seven-colour brick map
read in more colours, with a small picture painted in spare colours — proved its general layer, and written a skeleton in which each model theorem
*is the landed theorem applied to the model*. What is left is the leaves: the local facts of each picture.

## Why this job

For the four moves this is an open gate item on results already on `main` (`LEAN.md` § The gate, the inhabitant bullet; inventory rulings 419 (d),
427 (d)): the theorems are kernel-checked, and until a model lands nothing in Lean shows their hypothesis sets are not empty. Kooshi, on pricing this
work:

{KOOSHI}
The plan's hand-back and the rulings in force:

{item(460)}
{item(461)}
{item(426)}
{item(427)}
## The statements

No statement changes in this job. The heads of your files (each `sorry` at its leaves; read every leaf's docstring, which states its route):

{ST}
The plan (read it whole; § 2 is the construction, § 3 the plan per leaf, § 3.9 the split, § 3.11 what is weak):

{Q(KP,"## Stage 3 — SAVED")}
## Done means

1. **Your readback first**: check every quotation above against its source; read the planner's record whole, the general layer in `Paint`, and the
   landed theorems your models apply. Build the branch once as given (59 distinct `sorry` warnings, all in the four model files; half B's tree
   was copied from a build of `main`'s line, so there the four model files compile at this first build). **One naming rule, new today**
   (`LEAN.md` § Searching — Lean, last bullet; read it from the main checkout, `/home/kooshi/source/lean-dir/LEAN.md`): two branches never state
   one lemma under one name. The other half works in the other two files of `Plane/Models` on a branch of its own; a general fact about `paint`
   or `brickBase` that you need and `Paint` lacks goes in your own file under a name that begins with your model's name, and into your report. Open your record with what you may and may not change. Commit and push.
2. **The leaves**, in the planner's order, saving after each group (a build, the axioms print for the group, the statement check, commit, push).
   Re-price after your first two leaves and say so. The three brick facts are stated in coordinates and re-proved here (wave 5's `BrickMap` is not
   on `main`); after wave 5 lands they become three lines each — note the names for that tidy, do not wait for it.
3. **The receipt**: each model theorem — the landed theorem applied to the model — on the standard three, with a control that fires; no `sorry` in
   your files; `tools/check_architecture.py` exit 0.
4. No statement or definition changed anywhere; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge
   another branch into this one, run the gate, or touch `main`. Leave no background process running, and keep what your record cites under your
   `data/` folder.
5. **Your record**, stages headed "Stage n — SAVED ({JOB})", "Theorems this phase proved"; the report in standing rule 11's form, ending with what
   is left and its route. Stopping at a saved stage with one model whole and the next begun is a good report — one model whole is worth more than
   two half done.

## What is yours to decide

The route inside each leaf, your helpers, and the order within the plan's dependencies. The plan's routes are one mind's, priced from three measured
models and not from proofs; change a route that does not go and say so. A leaf's statement is not yours to change: if one is false — the planner
names `hornArcs`' rim-piece angles, `brickBase_col_zero` and `stuckModel_terminal` as the likeliest — that is a message to me, and a finding. Three
failed attempts on one route is a dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+SLUG,"w").write(b)
print("written",SLUG)
