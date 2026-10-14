exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS133-IB2: the density equality's definitions file (the third file of lane B), and the join note of FS133-IB1.
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE="fs133-wk1"; BR="fs133-wb2"; JOB="FS133-IB2"; W=WT+TREE+"/"
assert sh("git","-C",ROOT,"branch","--list",BR)=="" and not os.path.exists(ROOT+f"data/fs133/briefs/{JOB}-definitions.md")
assert sh("git","-C",W,"status","--porcelain")=="" and sh("git","-C",W,"branch","--show-current")=="fs133-wb1"
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs133/claims-K1.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
PLAN=W+"plans/FS133-kernel-plan.md"; IA=W+"plans/FS133-IA1-implementation.md"; IB=W+"plans/FS133-IB1-implementation.md"
for p in (PLAN,IA,IB,W+"tools/fs133_ib1_moved.py"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the definitions of the density equality's module: thirteen leaves, the model of its field theorem among them

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: an implementer on a planned module of eight files, after two who took its outside side and two files of its lane on measure and laws — you take the lane's third file, the definitions and their basic lemmas, thirteen leaves; and you retire two private lemmas the last implementer wrote while this file was unproved
  launch: now, in the tree the last implementer handed back, on a new branch cut from its head; a planner works on the five-colour chain in `fs131-wq1` and another plans a port of the outside release in `fs132-wi1`; no landing is in flight; the build slot is shared
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, or if a leaf's route does not go through and you take another (say which); the report goes to `data/fs133/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`{TIP}`; its build is current for that commit): `Proofs/HadwigerNelson/Plane/OneClass/Defs.lean` — **proofs and private helpers only, no statement changes**; in `Proofs/HadwigerNelson/Plane/OneClass/InvariantLaw.lean` only the two private lemmas named in § Done means item 4 and the proofs that call them; `plans/{JOB}-implementation.md`; `data/fs133/ib2/`; `data/fs133/reports/{JOB}.md`. Nothing on `main`; nothing in the module's other files
  budget: {BUDGET}

Hello. This module is the density equality for the real plane: the largest density of a set with no two points at
distance one is the same whether the set is arbitrary or measurable. Four implementers' worth of it is done: the
outside side, the field theorem, the invariant laws and the section density, all on the standard three axioms. Yours
is the file the others read their definitions from.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The finding is ours by hand, one mind. The module's definitions file holds the finite independence ratio and its two
readings, the bound by colourings, and the model that shows the field theorem's hypotheses can be met; until its
leaves are proved, the module's headlines read them as unproved, and the field theorem has no model in the kernel.

## The statements

The claim the definitions serve, and what the module does not claim, from the claim list fixed before it was planned:

{Q(C,"K133-ONE: ","§ Statements")}
{Q(C,"K133-NC-ONE: ","§ Not claimed")}
**Your thirteen leaves** are the `sorry`s of `Proofs/HadwigerNelson/Plane/OneClass/Defs.lean` (the plan's G leaves,
with the model the field theorem's hypotheses need, `IsInvariantLaw.isPlaneSystem`). Their statements are the
file's; read them in the source. **The plan per leaf**: `{PLAN}` § 5.2 (lane B), with § 5.5 (what each headline's
axioms must read: everything in this file rests on the standard three). The two earlier implementers' records,
`{IA}` and `{IB}`, end with what each learned that the plan does not say; the second also names the two private
lemmas that item 4 below retires.

## Done means

1. **Readback** (a saved stage): the three quoted lines checked against their sources; each leaf restated in one
   line beside the plan's route; the file's stored statements dumped from the built tree before any edit.
2. **The thirteen leaves**, without changing a statement; re-price what is left from the first two and say so.
3. **The model**: `IsInvariantLaw.isPlaneSystem` proved, and named in your record as the field theorem's model in
   the kernel (the last implementer's draft says which law exercises its third clause).
4. **The join**: the two private lemmas the last implementer wrote in `InvariantLaw` while this file was unproved
   (`card_le_indepNum_induce`, `exists_indep_subset`) re-pointed at this file's public lemmas, or deleted where a
   public lemma replaces them, with the proofs that call them adjusted — no duplicate proof goes to the landing.
5. **No statement changed**, shown from the kernel's side against item 1's dump and for `InvariantLaw` against its
   implementer's (the instrument `{W}tools/fs133_ib1_moved.py` is the pattern; a planted change watched
   firing); no `sorry` left in this file; one build under the slot with no warning from it; the axioms of every
   public declaration printed from the built tree — the standard three, with a planted record watched showing.
6. **Drafts for the landing**, in your record: the audit's block for this file; the model for each hypothesis.
7. The report in the standing rules' form. Leave no process running or queued. **Say whether this tree's compiled
   library is still needed after you**: two more lanes of this module will want a tree.

## What is yours to decide

The proofs; private helpers; another route for a leaf where the plan's does not go through (tell me which). An
unread binder of a statement in this file — a hypothesis or an instance that neither the statement nor its proof
reads — is dropped without asking, listed in your statement check as a ruled difference, and named in your report
(the standing word given to the last implementer, item 726). Anything else about a statement comes to me first.

## The machine

**This session is on the laptop: 12 cores, 31 GB; 330 GB of disk free.** One file through `lake env lean`: 3 to 24
seconds, 3.6 GB; a build with only small modules stale about 7 to 13 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ib2 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. On exit 75 wait ten
minutes and retry. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off:
anything your record cites lives under `data/fs133/ib2/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

{NOSPAWN}
'''
open(ROOT+f"data/fs133/briefs/{JOB}-definitions.md","w").write(b); print("ok",len(b))
