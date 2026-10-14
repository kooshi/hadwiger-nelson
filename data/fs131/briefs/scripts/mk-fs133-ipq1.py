exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS133-IPQ1: the density equality's last two leaves, Q4 and Q5 of lane D (C133-PAIR).
# Usage: mk-fs133-ipq1.py <inventory item of FS133-ICD1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
IC=int(sys.argv[1])
TREE="fs133-wk1"; BR="fs133-wpq"; JOB="FS133-IPQ1"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"status","--porcelain")=="" and sh("git","-C",W,"branch","--show-current")=="fs133-wcd"
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs133/claims-K1.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
PLAN=W+"plans/FS133-kernel-plan.md"; ICD=W+"plans/FS133-ICD1-implementation.md"; OC=W+"Proofs/HadwigerNelson/Plane/OneClass/"
for p in (PLAN,ICD,OC+"Pair.lean",W+"tools/fs133_ib2_moved.py",ROOT+"plans/FS133-E1-derivation.md"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the density equality's last two leaves: a measurable labelling admissible almost everywhere, and back

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: an implementer on a planned module of eight files, after five who proved all of it but two leaves — you take those two, which together are the module's claim about labellings by pairs, in both directions
  launch: now, in the tree the last implementer handed back, on a new branch cut from its head; the port of the outside release, which this module's landing waits on, runs in `fs132-wi1`; the chain's planner works in `fs131-wch`; the build slot is shared
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if a lemma the route needs is larger than one long stage (say which and its price before you build it), and if a record the plan's § 5.5 lists on the standard three alone prints the declared import; the report goes to `data/fs133/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`{TIP}`; its build is current for that commit): `Proofs/HadwigerNelson/Plane/OneClass/Pair.lean` — **proofs and private helpers only, no statement changes**; new lemmas the route needs (the two pieces named below) in `Pair.lean` as private helpers, or as public lemmas in a new module under `Proofs/HadwigerNelson/Plane/OneClass/` with its lines in the build's lists and `ARCHITECTURE.md` if another file would read them; `plans/{JOB}-implementation.md`; `data/fs133/ipq1/`; `data/fs133/reports/{JOB}.md`. Nothing on `main`; nothing in the module's other files
  budget: {BUDGET}

Hello. This module is the density equality for the real plane, and as of the last implementer's hand-back its
headlines have nothing unproved beneath them, resting on the standard three axioms and one declared theorem of the
outside release that the port is turning into a theorem. What is left is its second claim, about labellings of the
plane by a finite set of labels with forbidden pairs at unit distance: two leaves, one each way.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The module passes the gate whole or not at all: until these two leaves are proved, it cannot land, and the density
equality with it.

## The statements

The claim these two leaves prove, and what it does not claim, from the claim list fixed before the module was planned:

{Q(C,"K133-PAIR: ","§ Statements")}
{Q(C,"K133-NC-PAIR: ","§ Not claimed")}
The last implementer's hand-back as I logged it, with my rulings (ruling 1 is this job):

{item(IC)}
**Your two leaves** are the `sorry`s of `{OC}Pair.lean`: **Q4** `exists_measurable_admissibleAe` (in the last implementer's
words, "admissible on `E` gives a labelling with Borel fibres admissible a.e.") and **Q5**
`exists_admissibleOn_of_ae` ("null-measurable fibres admissible a.e. give a labelling admissible at every pair"). Their statements are the file's; read them in the source. **The plan**: `{PLAN}` § 5.4 (lane D) and § 5.5
(which records rest on the standard three alone); the last implementer's record `{ICD}` (its table in § 1 restates
both leaves beside their routes; its § 4.5 prices them and names what Q5 needs that the library lacks: a density-point
lemma for two sets at radius `r`, and an extension lemma for a pattern of forbidden label pairs — the library's
`exists_proper_ae_eq_of_proper_on_conull` concludes only `f x ≠ f y`). The derivation: `plans/FS133-E1-derivation.md`
(the entry for C133-PAIR).

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; both leaves restated in one line
   beside the plan's route; `Pair`'s stored statements dumped from the built tree before any edit.
2. **Q4** (a saved stage); re-price Q5 from it and say so.
3. **Q5** (saved stages), with its two new pieces stated and proved; if either is larger than one long stage, tell me
   before you build it.
4. **No statement changed**, shown from the kernel's side against item 1's dump (the instrument
   `{W}tools/fs133_ib2_moved.py` is the pattern; a planted change watched firing); no `sorry` left anywhere in the
   module; one build under the slot with no warning from `Pair`; the axioms of every public declaration of the module
   printed from the built tree, each matching its list in the plan's § 5.5, with a planted record watched showing.
5. **Drafts for the landing**, in your record: the audit's lines for C133-PAIR's records (the last implementer's
   draft block names four to file once these are proved); the model for each new hypothesis; the front-page sentence
   for C133-PAIR at its grade, with what is not claimed.
6. The report in the standing rules' form. Leave no process running or queued. Say whether this tree's compiled
   library is still needed after you (the landing will want it).

## What is yours to decide

The proofs; private helpers or a new module for the two pieces; another route for a leaf where the plan's does not go
through (tell me which). An unread binder of a statement in `Pair` is dropped without asking, listed in your
statement check as a ruled difference, and named in your report (the standing word of item 726). Anything else about
a statement comes to me first.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with only small modules stale about 7 to
13 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ipq1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. On exit 75 wait ten
minutes and retry. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off:
anything your record cites lives under `data/fs133/ipq1/`. Report at once any disk, memory or count reading near its
limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs133/briefs/{JOB}-pairs.md","w").write(b); print("ok",len(b))
