exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IU1 / FS131-IQ1: implementers on the residue module's two files, from FS131-KN2's skeleton and plan.
# usage: mk-fs131-iu.py U|Q
import os,sys,re,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
which=sys.argv[1]
CFG={"U":dict(job="FS131-IU1",tree="fs131-wnf",file="Arith/UpperHalf.lean",tag="iu1",claims=("S1A","S1B"),other="FS131-IQ1, on `Arith/QuadraticPrime.lean` in another tree",
              what="a plane over a real number field maps homomorphically onto its residue target at every stable prime, at every level — and what follows: the bound by the local bound, the two-colour case, the converse half"),
     "Q":dict(job="FS131-IQ1",tree="fs131-wq1",file="Arith/QuadraticPrime.lean",tag="iq1",claims=("S2",),other="FS131-IU1, on `Arith/UpperHalf.lean` in the tree `fs131-wnf`",
              what="a field that embeds in the p-adic numbers has a prime of its integers with p elements in the quotient — so every field of square roots whose radicands are nonzero squares modulo p has one, and, with one radicand divisible by p exactly once, so does that field")}[which]
JOB,TREE,FILE,TAG=CFG["job"],CFG["tree"],CFG["file"],CFG["tag"]
W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build"),"make the worktree first"
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
SRC=W+"Proofs/HadwigerNelson/"+FILE
L=open(SRC).read().split("\n"); names=[]; cur=None
for l in L:
    m=re.match(r"^(theorem|lemma)\s+([A-Za-z0-9_.']+)",l)
    if m: cur=m.group(2)
    if re.search(r"\bsorry\b",l) and cur and cur not in names: names.append(cur)
C="data/fs131/claims-NF1.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
PLAN="/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/plans/FS131-KN2-upper-half-plan.md"
ST="\n".join(Q(C,f"NF1-{n}: ","§ Statements") for n in CFG["claims"])
DL="\n".join(Q(C,"- 2026-10-13",None,k) for k in ("NF1-S2's second sentence is false as written","Three statements widened"))
b=f'''# Brief {JOB} — {len(names)} leaves of one file: {CFG["what"]}

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the implementer of one file of the first number-field module — replace every `sorry` in it with a proof, changing no statement; print the axioms of its headline theorems; build once at the end; draft what the landing will need
  launch: now, in a tree of your own; the other file of the module has its own implementer ({CFG["other"]}); a landing of another module is in flight in a third tree and two planners work in others — the build slot is shared, and you will wait for it at times
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a leaf that is false as stated, vacuous, or provable only with a hypothesis it lacks (say which: the *statement* needs it, or your *route* does); for a library or Mathlib lemma the plan names that does not exist as named; and with one line when the file has no `sorry` and its headlines print their axioms; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on your branch)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, at `{TIP}`): `Proofs/HadwigerNelson/{FILE}` — proofs and private helper lemmas only, **no statement of the skeleton changes** — and nothing else under `Proofs/`; `plans/{JOB}-implementation.md`; `data/fs131/{TAG}/`; `data/fs131/reports/{JOB}.md`. Nothing on `main`; no push
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback and after every two or three leaves; re-price a long leaf from its first child and say the price in your record; hand back at a saved stage before you would guess 500k, with the leaves done and left by name

Hello. This is the first implementation job of the restart, on a skeleton a planner of this lane finished an hour
ago. Its plan is unusually complete: every leaf has a route, the names it cites were checked by a probe, and it found
and repaired a false statement before anyone tried to prove it.

## Why this job

The project is being wound down and published. Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The results about planes over number fields come first, and nearly all of them stand on one short piece of
mathematics that the kernel held only in part: {CFG["what"]}. Thirteen ledger rows wait on its consequences; it
discharges a named hypothesis under the project's best number-field theorem; and with its sibling file it closes exact
values at once — the plane over the field of the square root of 11 needs exactly four colours, among them. Until these
leaves are proved, those values print `sorryAx`.

## The statements

The claims this file answers, from the claim list fixed before the skeleton was planned, with its two dated lines (a
statement corrected by a counterexample, and three widened):

{ST}
{DL}
**The leaves, by name, as the skeleton has them** — `Proofs/HadwigerNelson/{FILE}` in your tree, {len(names)} of them:
{", ".join("`"+n+"`" for n in names)}. Their statements are the file's and are not restated here: read them in the
source, and read each back against the plan before you prove it.

**The plan**: `{PLAN}` — § Stage 4 has a plan per leaf (the route in steps, the lemmas by full name as the planner
found them, what it tried that failed); § D has the split between the two files and what the landing needs; § Stage 2
has the read-back of each statement and the three changes its modeling pass made. Its probes, which print every cited
name under the module's imports, are under `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/data/fs131/kn2/probes/`.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against the claim list; every leaf's statement read in the
   source and restated in one line in your record with the plan's route beside it; a leaf whose statement and plan
   disagree is a message before you start it.
2. **The leaves**, in the plan's order, each proved without changing a statement. A helper lemma you need is private
   to the file unless the plan names it. A leaf that resists after two honest routes is left as `sorry` with a comment
   holding what you have — the helper statements, the route, where it stops — and reported by name: that is a good
   stage, not a failure.
3. **No statement changed**, shown: the stored types of the file's declarations compared with the skeleton's at
   `{TIP}` from the kernel's side (the last implementers' comparison scripts are the pattern:
   `data/fs136/i1/` on branch `fs136-wk1`, or write your own with a planted fault watched firing).
4. **The axioms** of the file's headline theorems printed from a check file: the standard three and nothing else —
   or `sorryAx` named with the leaf it comes from.
5. **One build at the end**, under the slot, zero warnings from your file (the unused-variable and unused-instance
   linters run there; the plan says where an `omit` is already in place).
6. **Drafts for the landing**, in your record: the audit block's records for this file (every declaration a person
   typed), an inhabitant or model named for each hypothesis of the headlines, and anything a reader of the statements
   should be told that the docstrings do not say.
7. The report in the standing rules' form. Leave no background process running.

## What is yours to decide

The proofs; private helpers; the order within the plan's dependency order; whether a leaf is better proved in a more
general form privately. If a statement can be strengthened at no cost, tell me and keep the skeleton's form — the
planner fixed these and another file reads them.

Not yours: any statement; the other file; the instances file; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB — the desktop's numbers in `RUNNING.md` and `LEAN.md` do not
apply.** Measured today by the planner of this module: one file through `lake env lean` costs 2 to 3 seconds and
3.6 GB once the imports are read; a build is 24 minutes at `BATCH=2` and 6.5 minutes at `BATCH=8`, almost all of it
Lake starting once per batch, with 4.5 GB at its peak. **So: write against `lake env lean`, and build once.** Do not
edit a module file while a build walks.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --name {TAG} -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2`, from inside your worktree
(the planner's script `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/data/fs131/kn2/lean1.sh` does exactly this and times it). The build:
`--mem 10 --cpus 8 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh` from inside your worktree; never `lake build`. Others
build too: on exit 75 wait and retry — a landing's gate steps can hold the slot for a long time, so keep proving
against `lake env lean` meanwhile. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at
power-off: anything your record cites lives under `data/fs131/{TAG}/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-leaves.md","w").write(b); print("ok",JOB,len(names),len(b))
