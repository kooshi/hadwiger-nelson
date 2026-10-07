exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-I9B: wave 9's first implementer — `Reduction/Uniform`'s three leaves and the models M1–M3 in a new module, on the tree
# fs131-w9b cut from the first planner's hand-back tip (make the tree first). Runs beside the wave's second planner (FS131-K9b).
import subprocess
TREE="fs131-w9b"; JOB="FS131-I9B"; W=WT+TREE+"/"
BASE=subprocess.run(["git","-C",W,"rev-parse","--short=8","HEAD"],capture_output=True,text=True).stdout.strip()
assert BASE,"make the worktree first"
P="Proofs/HadwigerNelson/Plane/"; V=W+P+"Reduction/"
REC=W+"plans/FS131-w9-kernel-plan.md"
LEAVES="\n".join(Q(V+"Uniform.lean","theorem "+n+" ") for n in ["upperDensity_compl_of_latticePeriodic","IsTiled.isArcDesign","iInf_delta0_le"])+"\n"
HEADS="\n".join([Q(V+"Basic.lean","theorem exists_arcMap_of_arcBounded "),Q(V+"Maps.lean","theorem v0_clean "),Q(V+"Maps.lean","theorem exists_arcMap_of_regular_cover ")])+"\n"
DEFS="\n".join([Q(V+"Basic.lean","def IsArcSystem "),Q(V+"Basic.lean","def ArcComplexity "),Q(V+"Basic.lean","def ArcBounded "),Q(V+"Basic.lean","def IsArcDesign "),
                Q(V+"Basic.lean","def IsLatticePeriodic "),Q(V+"Basic.lean","noncomputable def holeInf "),Q(V+"Basic.lean","noncomputable def delta0 "),
                Q(P+"Suprema.lean","def IsTiled "),Q(P+"Suprema.lean","noncomputable def upperDensity "),Q(P+"Suprema.lean","noncomputable def muZero ")])+"\n"
LANDED="\n".join([Q(P+"Slack.lean","theorem upperDensity_of_periodic "),Q(P+"Slack.lean","theorem eventually_le_muPer "),Q(P+"SVMap.lean","noncomputable def sevenBrickMap ")])+"\n"
PLAN="\n".join(Q(REC,p) for p in ["| `Plane/Reduction/Uniform` | 3 |","**U. `Reduction/Uniform`'s three**","**M. Models owed before","- **Two implementers split by file.**","**Re-priced from the first leaves proved here**",
                                   "- **FS111-C1-UNIF** — row","- **FS111-V0-CLEAN** — row","- **FS111-M2-REDUCE-C** — row"])+"\n"
b=f'''# Brief {JOB} — wave 9, the reductions: three leaves of the uniform bound, and three models the wave's gate asks for, on `{TREE}`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: wave 9's first implementer — prove the three open leaves of `{P}Reduction/Uniform.lean` from the planner's plan, without changing a statement, and build the Lean models M1–M3 its plan names in a new module, saving after each leaf or model
  launch: when a slot frees, on a branch cut from the commit at which the wave's first planner handed back; the wave's second planner works on the wave's other two modules in a tree of its own at the same time
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me — and say which kind you have, a *statement* that needs a hypothesis it lacks, or a *route* that reads more than the statement needs), a model that cannot be built as the plan names it (with what fails), or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, cut from `fs131-w9` at `{BASE}`): `{P}Reduction/Uniform.lean` — proofs, and new helper declarations under names no other module declares (`./scripts/dupnames.sh` before each push that adds names); a new module `{P}Reduction/Models.lean`, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (a block of your own, headed "{JOB}", above the `=== PURCHASED ===` banner), `plans/{JOB}-implementation.md`, `tools/fs131_i9b_*.py`, `data/fs131/i9b/`, `data/fs131/reports/{JOB}.md`; **not** any statement, `{P}Reduction/Basic.lean` and `{P}Reduction/Maps.lean` beyond new declarations (they are proved, and the models read them), anything under `{P}Classes/` (the second planner's and a later implementer's), any landed module, `main`
  budget: {BUDGET}

Hello. You are proving part of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked
ones. Wave 9 is the reductions: how a measurable colouring of the plane, proper at almost every unit pair, becomes a map, and what the
bound on holes says once it is uniform in a complexity bound. Its planner stated all eleven rows and proved five; of the five leaves left,
three are in one module and are yours, with three small models the planner found the wave's gate would ask for. A second planner is
splitting the wave's long leaf at the same time, in another tree; you share no file with it.

## Why this job

A result counts as held only when its Lean module passes the gate. The module you finish carries the sentence the project's direction
rests on in its sharpest form — seven colours are needed almost everywhere exactly when the hole bound stays positive uniformly in the
complexity (`CLAUDE.md` § The aim, item 5; `LEDGER.md` rows 131, 139) — as `seven_le_chiM0_iff_delta0`, already proved over your three
leaves and not a theorem until they are. And the gate's inhabitant rule asks, of every theorem whose hypotheses are structures, for a
Lean object meeting all of them at once: three of the wave's proved theorems have none yet. Kooshi, on pricing this work:

{KOOSHI}
What the planner handed back, and the rulings in force (read each item whole in the inventory, `plans/FS131-close-inventory.md`):

{item(536)}
{item(556)}
{item(573)}
{item(596)}
## The statements

No statement changes in this job. Your three leaves, as they stand in your tree (read each whole, with its docstring):

{LEAVES}
The three proved theorems the models are for (M1, M2, M3 in the plan's order):

{HEADS}
The definitions they read (your tree, and `main`):

{DEFS}
Landed lemmas and the landed map the plan's routes name:

{LANDED}
The plan (the planner's record, `{REC}`, Stages 1–5: read it whole — its § 4.3 has a route per leaf and per model, its § 4.2 each
theorem read back against its row):

{PLAN}
## Done means

1. **Your readback first**: check the quotations against their sources; read the planner's record whole, the wave's three reduction
   modules and what they import, and the row's derivation entry at the address the record gives. `#check` each of your three leaves and
   the three theorems the models are for, and read the binders the kernel shows (inventory item 556: a section `variable` enters a
   theorem only if its statement mentions it — a leaf whose kernel statement lacks a hypothesis its row reads is a message to me before
   you prove it). Build the branch once as given (five `sorry` leaves in the wave, three yours). Open your record with what you may and
   may not change. Commit and push.
2. **The three leaves**, in the planner's order U1, U2, U3; saving after each (a build, the axioms print for it with a control that
   fires, a statement check on elaborated signatures against `{BASE}` — the milestone's instrument is
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/tools/fs131_i7a_stmt_check.py`, on another wave's branch: copy it under a
   name of your own and say so — commit, push). **Before you prove a helper, search the tree for its statement's shape, not for a
   name** (item 596: an implementer wrote two weaker copies of landed theorems today). Re-price after U1 and say so: about 340 lines
   by the planner, the counting in U2 the work.
3. **The models M1, M2, M3**, in a new module `{P}Reduction/Models.lean`: each a Lean object meeting every hypothesis of its theorem
   at once, with the theorem applied to it (`LEAN.md` § The gate, the inhabitant rule) — the plan names the brick map and its regions
   for all three. A model that cannot be built as named is a message to me with what fails, and an open gate item named in your report
   (ruling 536 (c)); it is not a reason to weaken a hypothesis. M4 and M5 are another job's.
4. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not
   merge another branch, run the gate, or touch `main`. **After your last green build, the guarded lint** — `lake lint --no-build --
   --no-build --trace` under the slot with `--mem 8` (`LEAN.md` § The gate), its output saved (inventory item 573). Leave no background
   process running, and keep what your record cites under your `data/` folder.
5. **Your record**, stages headed "Stage n — SAVED ({JOB})", "Theorems this phase proved", each read against its row; a draft of the
   lines the wave's landing will want for what you proved (the ledger's rows, the docstrings that named a model as owed); the report in
   standing rule 11's form, ending with what is left and its route. Stopping at a saved stage with part of the work done is a good
   report.

## What is yours to decide

The route inside each leaf, your helpers, the models' construction, and the order within the plan's dependencies. The plan is one
mind's, and it says of itself that its Mathlib names for your leaves were read, not elaborated against: change a route that does not go
and say so. A statement is not yours to change: one that is false, or true only with a hypothesis the plan did not see, is a message to
me, and a finding. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+"-wave9-uniform.md","w").write(b)
print("written",JOB,"base",BASE)
