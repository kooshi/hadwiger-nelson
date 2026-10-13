exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# Implementers on the three-and-four-colours line, one module each, from FS131-KN4's skeleton as finished by FS131-KN5.
# usage: mk-fs131-i4.py T|C|R|D <tree>
import os,sys,re,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
key,TREE=sys.argv[1],sys.argv[2]
CFG={"T":("FS131-IT1","TorsionExtraction","it1","if one third is an integer combination of unit vectors, the plane's number is never three — and with it, at least four colours over every field holding the square root of a number that is 11 modulo 12"),
     "C":("FS131-IC1","ThreeColourCharacter","ic1","a three-colouring of a plane over a field gives a character of its ring of unit vectors whose values on unit vectors stay in the middle third"),
     "R":("FS131-IR1","ThreeColourCriterion","ir1","the three-colour criterion toward the prime, in the ring of unit vectors, and the two-colour end"),
     "D":("FS131-ID1","DyadicQuadratic","id1","two and four colours for planes over real quadratic fields by an additive map in coordinates — the upper halves of two rows of the table")}
JOB,MOD,TAG,WHAT=CFG[key]
W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build"),"make the worktree first"
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
FILE=f"Arith/{MOD}.lean"; SRC=W+"Proofs/HadwigerNelson/"+FILE
L=open(SRC).read().split("\n"); names=[]; cur=None
for l in L:
    m=re.match(r"^(theorem|lemma)\s+([A-Za-z0-9_.']+)",l)
    if m: cur=m.group(2)
    if re.search(r"\bsorry\b",l) and cur and cur not in names: names.append(cur)
C="data/fs131/claims-NF4.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
P1="/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wr2/plans/FS131-KN4-three-four-colours-plan.md"
P2="/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wr2/plans/FS131-KN5-three-four-colours-passes.md"
TH=Q(C,"NF4-THEOREM: ","§ The theorem (the asking lane's wording, rank 2)")
DL="\n".join(Q(C,"- 2026-10-13",None,k) for k in ("Three statements widened","NF4-S9 is untrue as written","Two statements added"))
b=f'''# Brief {JOB} — {len(names)} leaves of one module: {WHAT}

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the implementer of one module of the three-and-four-colours line — replace every `sorry` in it with a proof, changing no statement; print the axioms of its headline theorems; build once at the end; draft what the landing will need
  launch: now, in a tree of your own; the line's other three modules are separate jobs in other trees, each reading upstream leaves as stated; another module's last leaves and a landing are in flight in other trees — the build slot is shared
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

Hello. Two planners of this lane built this skeleton today. The first typed it and caught a false shared statement
by typing it; the second ran the lane's three modeling passes before any proof, changed three statements while that
was still free, re-derived every leaf by hand, and built the skeleton three times with the linters silent. Two other
modules planned the same way this morning were proved this afternoon with the plan holding on every leaf.

## Why this job

The project is being wound down and published. Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
By the asking lane's ranking the finding the field gets first is the one that needs no hypothesis: the exact number
of colours for planes over real quadratic fields, through four, and the criterion for exactly three over every real
number field. It was asked twice in print by name, and a paper posted last week calls the upper bounds known and
leaves the exact values. This module is one of its four: {WHAT}.

## The statements

The theorem the line proves, and the three dated lines that changed its claim list today:

{TH}
{DL}
**Your leaves, by name** — `Proofs/HadwigerNelson/{FILE}` in your tree, {len(names)} of them:
{", ".join("`"+n+"`" for n in names)}. Their statements are the file's: read them in the source, and read each back
against the plan before you prove it.

**The plans, in this order**: the dated section at the end of `{P1}` (where the second planner changed the first's
plan), then `{P2}` — § Stage 3 (the long leaves split into children, each with a route), § Stage 5 (the dyadic
leaves), § Stage 7 (the leaf list after the passes, the split, and what each module reads from upstream as stated);
then the first plan's § 4 for the leaves the second did not touch. Their name checks are under
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wr2/data/fs131/kn5/`.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against the claim list; every leaf's statement read in the
   source and restated in one line in your record with the plan's route beside it; a leaf whose statement and plan
   disagree is a message before you start it.
2. **The leaves**, in the plan's order, each proved without changing a statement. A helper you need is private to
   the file unless the plan names it. A leaf that resists after two honest routes is left as `sorry` with a comment
   holding what you have, and reported by name: that is a good stage, not a failure.
3. **No statement changed**, shown from the kernel's side against the skeleton at `{TIP}` (the scripts of today's two
   implementers are the pattern: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/data/fs131/iu1/` — and
   read the tool defect its record names before you copy it: a statement printed from two paths can differ in an
   instance binder's name), with a planted fault watched firing.
4. **The axioms** of the file's headline theorems printed from the built module: the standard three and nothing
   else — or the one declared outside theorem the plan says a leaf reads, named — or `sorryAx` with the leaf it
   comes from.
5. **One build at the end**, under the slot, zero warnings from your file.
6. **Drafts for the landing**, in your record: the audit block's records for this file (every declaration a person
   typed), an inhabitant or model named for each hypothesis of the headlines, and anything a reader of the
   statements should be told that the docstrings do not say — the attribution of each value above all (what is this
   project's, what is an outside model's, what is Fischer's and Johnson's, as the docstrings already try to say).
7. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; the order within the plan's dependency order; whether a leaf is better proved in a
more general form privately. If a statement can be strengthened at no cost, tell me and keep the skeleton's form.

Not yours: any statement; the other modules; the joining module; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB.** Measured today: one file through `lake env lean` costs 3 to 6
seconds and 3.6 GB once the imports are read; a build is 6 to 9 minutes at `BATCH=8` when only small modules are
stale, about 5 GB at its peak. **Write against `lake env lean`, and build once.** Do not edit a module file while a
build walks.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name {TAG} -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree.
The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. A landing's gate
steps have priority on the slot: keep proving against `lake env lean` while you wait. Stop a process by its PID,
never by matching its command line. `/tmp` is wiped at power-off: anything your record cites lives under
`data/fs131/{TAG}/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-leaves.md","w").write(b); print("ok",JOB,len(names),len(b))
