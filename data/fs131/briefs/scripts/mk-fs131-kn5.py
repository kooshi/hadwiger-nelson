exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-KN5: successor planner on the three-and-four-colours line — the modeling passes, the first build, the dyadic leaves.
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE="fs131-wr2"; JOB="FS131-KN5"; W=WT+TREE+"/"; assert os.path.isdir(W+".lake/build")
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs131/claims-NF4.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
TH=Q(C,"NF4-THEOREM: ","§ The theorem (the asking lane's wording, rank 2)")
DL="\n".join(Q(C,"- 2026-10-13",None,k) for k in ("Three statements widened","NF4-S9 is untrue as written","Two statements added"))
PLAN=f"/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/plans/FS131-KN4-three-four-colours-plan.md"
REP=f"/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/data/fs131/reports/FS131-KN4.md"
b=f'''# Brief {JOB} — before anyone proves over them: the modeling passes on a 29-leaf skeleton, its first build, and a plan an implementer can follow for its two thinnest leaves

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; you are the successor of the planner who typed this skeleton today and ran out of budget before three steps of the lane's workflow
  role: the kernel lane's planner finishing a plan — run the modeling passes the first planner could not (they may change the form of a statement, which is why they come before the proofs), get the skeleton through its first real build with the linters, and turn two leaves whose route is "a sketch by one mind" into a plan per leaf or a precise question
  launch: now, in the first planner's tree — it has handed back and nobody else writes there; implementers work on another module in the trees `fs131-wnf` and `fs131-wq1`, and a landing is in flight in `fs131-wkc`: the build slot is shared and you will wait for it
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement whose form a modeling pass changes (the old and the new form, and why), for a statement defect, for a dyadic leaf that needs a derivation and not a plan (say the exact step), and with one line when the build is green with the linters read; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/FS131-KN5-three-four-colours-passes.md` (new, on branch `{TREE}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, at `{TIP}`; its `.lake/build` is an old landing's — the first build compiles two landings of modules under `Proofs/HadwigerNelson/Plane/` as well as this line's four): the four skeleton modules of this line under `Proofs/HadwigerNelson/Arith/` (`ThreeColourCharacter`, `TorsionExtraction`, `ThreeColourCriterion`, `DyadicQuadratic`) and the planned joining text under `data/fs131/kn4/lean/` — statements and definitions may change **only by a modeling pass, each change recorded with its reason**; `plans/FS131-KN5-three-four-colours-passes.md`; a dated section appended to the first planner's plan where a leaf's plan changes; `data/fs131/kn5/`; `data/fs131/reports/{JOB}.md`. Nothing on `main`; nothing in another tree
  budget: about 250k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback, after each pass, when the build is green, and after each dyadic leaf's plan; hand back at a saved stage rather than start a step you cannot finish

Hello. A planner of this lane typed a four-module skeleton today — three and four colours over real number fields,
the finding the field gets first — found a false shared leaf by typing it, widened three statements, and stopped at
its budget with three things undone, each of which it named. This job is those three things, so that the
implementers who follow start on statements that will not move under them.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
An implementer may not change a statement; a modeling pass may. If the passes run after the proofs, every change
costs a proof. The first planner said so in its hand-back: the passes "were not run as fresh skill invocations",
"no full build" (its build request waited behind other lines' builds for the whole job, so the linters have never
read these files), and the two leaves added late "want a deriver's page or a second planning pass before an
implementer", with one residue class "the thinnest".

## The statements

The claim list `data/fs131/claims-NF4.md`, its theorem and the three dated lines that changed it today:

{TH}
{DL}
The skeleton and its plan: `{PLAN}` (a plan per leaf in its § 4; the two dyadic leaves in its § 4.5; the modeling
passes it owes in its § Stage 3); the first planner's report `{REP}`.

## Done means

1. **Readback** (a saved stage): the four quoted lines checked against the claim list; the plan's § 4 and the four
   modules' statements read; each definition and each headline listed with the claim it answers.
2. **The modeling passes, as fresh invocations of your lane's skills** (a saved stage each): the domain pass on
   every definition and headline statement of the four modules and the joining text; the obligation pass on the
   leaves the plan calls long; the experience pass on what a reader of the published statements meets (names,
   argument order, what a docstring must say about whose result a value is). For each change: the old form, the
   new form, the reason, and the re-elaboration. A pass that changes nothing says so with what it weighed.
3. **The first build**, under the slot, and the linters' verdict read from its log; fix what they flag in the
   skeleton (an unused variable, a missing docstring) without touching a statement's meaning; send the wall time
   and peak memory.
4. **The two dyadic leaves**: for each of the three residue classes the first planner names, a plan an implementer
   can follow — the objects typed, the route in steps, the lemmas by full name as found — or, where the route needs
   mathematics nobody has written down, the exact step as a question for the derive lane. Check each class against
   a small exact computation where one is cheap, with a planted fault watched firing.
5. **The split confirmed** for implementers after your changes: which of the four modules two implementers can
   take at once, and what the joining module needs from the other line (`fs131-wnf`, whose first file is now fully
   proved on its branch).
6. The report in the standing rules' form.

## What is yours to decide

Every change a pass makes; whether a dyadic leaf is restated in a form that is easier to prove and equally useful
to the table; the batch size of your build once you have seen the first. If the passes show the skeleton is
already right, the job is short and that is a good result.

Not yours: proving the leaves (prove one only if it falls in a few lines while you test a plan); the other
module; the five-colour chain.

## The machine

**This session is on the laptop: 12 cores, 31 GB.** Measured today: one file through `lake env lean` costs 3 to 24
seconds and 3.6 GB; a build is a 24-minute walk at `BATCH=2` and 6.5 minutes at `BATCH=8` when only small modules
are stale, 4.5 GB at its peak; a rebuild of 117 real modules by the landing is in progress now and is the first
measurement of that kind. Run the memory tool as

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name kn5 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree
(the first planner's `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wr2/data/fs131/kn4/lean1.sh` does this). The build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=4
./scripts/build.sh` from inside the worktree — four cores, so that it can run beside another line's build; never
`lake build`. **The landing has priority on the slot**: if your build has waited an hour, tell me. Stop a process by
its PID, never by matching its command line, and leave none running or queued when you hand back — the first
planner's queued build outlived it and I had to stop it. `/tmp` is wiped at power-off: anything your record cites
lives under `data/fs131/kn5/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists).
'''
open(ROOT+"data/fs131/briefs/FS131-KN5-passes-and-build.md","w").write(b); print("ok",len(b))
