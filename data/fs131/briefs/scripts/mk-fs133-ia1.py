exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS133-IA1: the first implementer of the density equality's module — lane A, the outside side (the port, the heaviest link, the axiom's two leaves).
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE="fs133-wk1"; BR="fs133-wa1"; JOB="FS133-IA1"; W=WT+TREE+"/"
assert sh("git","-C",ROOT,"branch","--list",BR)=="" and not os.path.exists(ROOT+f"data/fs133/briefs/{JOB}-lane-a.md")
assert sh("git","-C",W,"status","--porcelain")==""
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs133/claims-K1.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
PLAN=W+"plans/FS133-kernel-plan.md"; REP=W+"data/fs133/reports/FS133-K1.md"
for p in (PLAN,REP): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the outside side of the density equality: port the release's generic lemmas, prove the field theorem that is the module's heaviest link, and give the declared theorem its model

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the first implementer of a planned module of eight files and 43 leaves — you take one of its four lanes, the one that touches the outside release: a ported module made by the generator, the field theorem proved over it, and the two leaves beside the declared outside theorem
  launch: now, in the planner's tree on a new branch — the planner has handed back and nobody else writes there; a landing of another module is in its final pass in `fs131-wnf` and has priority on the build slot
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if the port needs a patch on anything but a proof line, if the declared statement would have to change by one character, and with one line when the ported module builds; the report goes to `data/fs133/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`{TIP}`; its build is current for that commit): the new generated module the plan calls `Outside/OAI158Transfer` with its line in the build's lists and its row in `ARCHITECTURE.md`; in `Proofs/HadwigerNelson/Outside/OAI158Rigidity.lean` and `Proofs/HadwigerNelson/Plane/OneClass/Field.lean` **proofs and private helpers only — no statement changes, and not one character of the declared `axiom`**; `plans/{JOB}-implementation.md`; `data/fs133/ia1/`; `data/fs133/reports/{JOB}.md`. Nothing on `main`; nothing in the other six files of the module (three other lanes own them); nothing in the outside release's clone, which is read only
  budget: {BUDGET}

Hello. A planner finished this module's plan an hour ago: every statement typed and read back, eight files that build
with `sorry` at 43 leaves and nowhere else, a plan per leaf, and the leaves split into four lanes that share no file.
You are the first implementer, on the lane the planner says carries the most risk and so goes first.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The finding is that the largest density of a set in the plane with no two points at distance one is the same whether
the set is arbitrary or measurable — an answer to a question two recent papers pose — and it is ours by hand only,
one mind, a week old. In the kernel it will rest on one declared theorem of an outside Lean release, which the planner
has declared, with its read-back, in `Outside/OAI158Rigidity`. Your lane is everything between that declaration and
the rest of the module: the release's own generic lemmas brought here by port (kernel-checked here, no axiom), and
over them the one theorem — the planner calls it the field theorem — from which the other three lanes read
everything they need of the outside side. Until it is proved, every headline of the module prints an unproved
dependency.

One more thing rides on your first leaf. The port you make is the first measurement of what it costs to bring a
module of the release's transfer proof to this library's version of Mathlib, and Kooshi has a decision pending on
porting the whole of it. What your port needed — patches, renames, minutes — is wanted as a result in its own right.

## The statements

The claim your lane serves, and what the module does not claim, from the claim list fixed before it was planned:

{Q(C,"K133-ALG: ","§ Statements")}
{Q(C,"K133-NC-ALG: ","§ Not claimed")}
{Q(C,"K133-NC-ALL: ","§ Not claimed")}
**Your four leaves**, by the plan's letters: **P**, the ported module; **F**, `OneClass.exists_field` in
`Proofs/HadwigerNelson/Plane/OneClass/Field.lean`; **X**, `Spectral.residual_fourier_cross`, and **M**,
`Spectral.residual_fourier_model`, both in `Proofs/HadwigerNelson/Outside/OAI158Rigidity.lean`. Their statements are
the files'; read them in the source. **The plan per leaf**: `{PLAN}` § 5.1 (lane A), with § 5.0 (the split), § 5.5
(what each headline's axioms must read when its leaves are done), § 2 (how the declared theorem entered, and the grade
of its read-back in § 2.4) and § 6 (what the modeling passes changed). The planner's report: `{REP}`.

## Done means

1. **Readback** (a saved stage): the four quoted lines checked against their sources; each leaf's statement
   restated in one line beside the plan's route for it.
2. **P, the port** (a saved stage): made with the generator the last port used (`tools/fs132_i2_port.py`, which
   refuses a patch to a statement or a definition), the licence text beside it
   (`Proofs/HadwigerNelson/Outside/OAIMath2026-LICENSE.txt`), its read-back run with a control that fires
   (`tools/fs132_i2_readback.py`), and every declaration of it printing the standard three axioms and nothing else.
   **And the measurement**: per ported declaration group, what the generator needed at this pin (patches on proof
   lines, renamed Mathlib constants, anything refused), the wall time, and one paragraph on what this says about
   porting the rest of the transfer's cone. Send me the one line when it builds.
3. **M and X** (a saved stage). M's axioms are the standard three: the model must not read the declared theorem.
4. **F** (saved stages as its parts fall). If P stalls, the plan says how F can be written without it; tell me
   before you take that road.
5. **No statement changed**, shown from the kernel's side for your three files (a comparison of stored statements
   before and after, with a planted change watched firing); no `sorry` left in them; one build under the slot with
   no warning from them; the axioms of every public declaration of your lane printed from the built tree and set
   against the plan's § 5.5 — a declaration on its second list that prints the import is a route that went wrong.
6. **Drafts for the landing**, in your record: the audit's block for your files, the model for each hypothesis, and
   anything a reader of the declared theorem's docstring should be told that it does not yet say.
7. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; the order inside your lane beyond "P first"; how the ported module is cut into
declaration groups. Not yours: any statement; the declared theorem's text; the optional leaf the plan calls R (ruled
out of this job: it waits on the decision about the port); the other three lanes; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB.** Measured today: one file through `lake env lean` costs 3 to 24
seconds and 3.6 GB; a build with only small modules stale takes 6 to 10 minutes; one such build at `BATCH=8` peaked
at 12.3 GB summed over its processes. Write against `lake env lean` and build rarely; do not edit a module file while
a build walks.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ia1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree (the
planner's `{W}data/fs133/k1/lean1.sh` does this). The build: `--mem 12 --cpus 4 -- env MEMMAX=12G BATCH=4
./scripts/build.sh` from inside the worktree; never `lake build`. A landing's gate steps have priority on the slot.
Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off: anything your record
cites lives under `data/fs133/ia1/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

{NOSPAWN}
'''
open(ROOT+f"data/fs133/briefs/{JOB}-lane-a.md","w").write(b); print("ok",len(b))
