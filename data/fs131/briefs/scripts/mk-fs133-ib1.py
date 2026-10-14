exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS133-IB1: the density equality's second implementer — the invariant laws and the section density (lane B, two of its three files).
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE="fs133-wk1"; BR="fs133-wb1"; JOB="FS133-IB1"; W=WT+TREE+"/"
assert sh("git","-C",ROOT,"branch","--list",BR)=="" and not os.path.exists(ROOT+f"data/fs133/briefs/{JOB}-laws-and-density.md")
assert sh("git","-C",W,"status","--porcelain")=="" and sh("git","-C",W,"branch","--show-current")=="fs133-wa1"
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs133/claims-K1.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
PLAN=W+"plans/FS133-kernel-plan.md"; IA=W+"plans/FS133-IA1-implementation.md"
for p in (PLAN,IA): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the invariant laws and the section density: fourteen leaves of the density equality's module, the two compactness leaves first

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: an implementer on a planned module of eight files, after the one who took its outside side — you take two files of its lane on measure and laws: the existence of an invariant law on the edge-free sets of a graph with the bound it gives, and the density of a random measurable set's sections; fourteen leaves, the two the plan calls risky first
  launch: now, in the tree the module's first implementer handed back an hour ago, on a new branch cut from its head; a planner works on another chain in `fs131-wch` and a planner-prover on another line in `fs131-wrc`; no landing is in flight; the build slot is shared
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if a leaf's route in the plan does not go through and you take another (say which), and with one line when the two compactness leaves are proved; the report goes to `data/fs133/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`{TIP}`, the first implementer's; its build is current for that commit): `Proofs/HadwigerNelson/Plane/OneClass/InvariantLaw.lean` and `Proofs/HadwigerNelson/Plane/OneClass/SectionDensity.lean` — **proofs and private helpers only, no statement changes**; one dated section appended to `plans/FS133-kernel-plan.md` (§ Done means item 6); `plans/{JOB}-implementation.md`; `data/fs133/ib1/`; `data/fs133/reports/{JOB}.md`. Nothing on `main`; nothing in the other six files of the module (the third file of this lane, `Defs`, is another implementer's)
  budget: {BUDGET}

Hello. This module's first implementer handed back an hour ago with the lane the plan called riskiest done: the
release's generic lemmas ported, the field theorem proved over them, and the declared outside theorem's statement
shown, by this library's own kernel, to be the release's. You take the next lane.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The finding is that the largest density of a set in the plane with no two points at distance one is the same whether
the set is arbitrary or measurable — ours by hand only, one mind, a week old. Its kernel module is planned to the
leaf. Your two files hold the two statements that everything on the plane's side is assembled from: that a graph on
the algebraic plane with a symmetric rotation-invariant set of steps carries an invariant law on its independent
sets whose weight at the origin is the infimum of the finite ratios, and that a random measurable set whose points
are each covered with probability at least α has sections of positive density with positive probability. Until they
are proved, every headline of the module prints an unproved dependency.

## The statements

The two claims your files answer, and what they do not claim, from the claim list fixed before the module was
planned (its dated line says where the planner typed them wider):

{Q(C,"K133-INV-CLASS: ","§ Statements")}
{Q(C,"K133-NC-INV-CLASS: ","§ Not claimed")}
{Q(C,"K133-DENS-CLASS: ","§ Statements")}
{Q(C,"K133-NC-DENS-CLASS: ","§ Not claimed")}
**Your fourteen leaves**, by the plan's letters: **I1–I7** in `InvariantLaw` (the plan's I3 and I4 are the two
compactness leaves: an invariant law for the shifts from a Følner sequence, and a common fixed point for the
rotations with no fixed-point theorem imported) and **D1–D5** in `SectionDensity`, with the children the plan names.
Their statements are the files'; read them in the source. **The plan per leaf**: `{PLAN}` § 5.2 (lane B), with § 5.0
(the split), § 5.5 (what each headline's axioms must read: everything in your two files rests on the standard three
and must not print the declared outside theorem) and § 6 (what the modeling passes changed). The first implementer's
record `{IA}` ends with what it learned that the plan does not say; two of its notes are for you: since two import
lines were added to the declared theorem's module, **a comparison of your statements before and after must be made
against this branch's tree, not the planner's**, and one statement of your lane (`Plane.isIndepSet_ball_half`) is
stored on another instance path than at the planner's head — in instance arguments only.

## Done means

1. **Readback** (a saved stage): the five quoted lines checked against their sources; each leaf's statement
   restated in one line beside the plan's route; the stored statements of your two files dumped from the built tree
   before any edit.
2. **I3 and I4 first** (a saved stage each). Send me the one line when both are proved, or the exact step where one
   stops.
3. **The other twelve leaves**, without changing a statement; re-price what is left from the first two you finish
   and say so in your record.
4. **No statement changed**, shown from the kernel's side for your two files against the dump of item 1 (a planted
   change watched firing); no `sorry` left in them; one build under the slot with no warning from them; the axioms
   of every public declaration of the two files printed from the built tree — the standard three and nothing else,
   with a planted record watched showing.
5. **Drafts for the landing**, in your record: the audit's block for your files and the model for each hypothesis.
6. One small filing on your branch: the first implementer's draft D4 — a dated note correcting the cause the plan
   gives for the declared statement's read-back — appended to the plan word for word where the draft says it goes.
7. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The proofs; private helpers; the order after the two compactness leaves; another route for a leaf where the plan's
does not go through (tell me which). Not yours: any statement; the third file of this lane; the other lanes; the
landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB.** Measured today: one file through `lake env lean` costs 3 to 24
seconds and 3.6 GB; a build with only small modules stale takes 6 to 10 minutes; one such build at `BATCH=8` peaked
at 12.3 GB summed over its processes. Write against `lake env lean` and build rarely; do not edit a module file while
a build walks.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ib1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 12 --cpus 4 -- env MEMMAX=12G BATCH=4 ./scripts/build.sh` from inside the worktree; never `lake build`.
Two other jobs build from time to time: on exit 75 wait ten minutes and retry. Stop a process by its PID, never by
matching its command line. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs133/ib1/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

{NOSPAWN}
'''
open(ROOT+f"data/fs133/briefs/{JOB}-laws-and-density.md","w").write(b); print("ok",len(b))
