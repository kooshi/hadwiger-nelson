exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS133-ICD1: the density equality's last two lanes — C (the plane: Algebraic, Fractional) and D (pairs: Pair).
# Usage: mk-fs133-icd1.py <inventory item of FS133-IB2's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
IB=int(sys.argv[1])
TREE="fs133-wk1"; BR="fs133-wcd"; JOB="FS133-ICD1"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"status","--porcelain")=="" and sh("git","-C",W,"branch","--show-current")=="fs133-wb2"
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
C="data/fs133/claims-K1.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
PLAN=W+"plans/FS133-kernel-plan.md"; IA=W+"plans/FS133-IA1-implementation.md"; IB1=W+"plans/FS133-IB1-implementation.md"; IB2=W+"plans/FS133-IB2-implementation.md"
OC=W+"Proofs/HadwigerNelson/Plane/OneClass/"
for p in (PLAN,IA,IB1,IB2,OC+"Algebraic.lean",OC+"Fractional.lean",OC+"Pair.lean",OC+"Defs.lean",W+"tools/fs133_ib2_moved.py"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the density equality's last two lanes: the plane (the algebraic plane to the real one, and the fractional chromatic number) and pairs

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: an implementer on a planned module of eight files, after four who took its outside side, its measure and laws, and its definitions — you take its last two lanes, three files and thirteen leaves, the module's headlines among them
  launch: now, in the tree the last implementer handed back, on a new branch cut from its head; the port of the outside release, which this module's landing waits on, runs in `fs132-wi1`; the chain's Pontryagin-duality planner works in `fs131-wq1`; the build slot is shared
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, if a leaf's route does not go through and you take another (say which), and if a record the plan's § 5.5 lists on the standard three alone prints the declared import; the report goes to `data/fs133/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`{TIP}`; its build is current for that commit): `Proofs/HadwigerNelson/Plane/OneClass/Algebraic.lean`, `Proofs/HadwigerNelson/Plane/OneClass/Fractional.lean` and `Proofs/HadwigerNelson/Plane/OneClass/Pair.lean` — **proofs and private helpers only, no statement changes**; in `Proofs/HadwigerNelson/Plane/OneClass/Defs.lean` only two edits, by the rulings quoted below: `upperDensity_congr_ae` made public with its statement unchanged, and the docstring of `Plane.isIndepSet_ball_half` rewritten to say what its statement asserts; `plans/{JOB}-implementation.md`; `data/fs133/icd1/`; `data/fs133/reports/{JOB}.md`. Nothing on `main`; nothing in the module's other files; the import of `Mathlib.Algebra.AlgebraicCard` in `InvariantLaw` stays (ruled)
  budget: {BUDGET}

Hello. This module is the density equality for the real plane: the largest density of a set with no two points at
distance one is the same whether the set is arbitrary or measurable, and with it the fractional chromatic number of
the plane is one over that density. Its outside side, its field theorem, its invariant laws, its section density and
its definitions are proved, all on the standard three axioms or on the one outside theorem the plan names. Yours are
the files that state the result.

## Why this job

Kooshi's rule for what goes out:

{Q(RQ,"W2: ")}
The finding is ours by hand, one mind, and it answers a question the literature has posed (the module's claim list
says which). Until these three files are proved its headlines read as unproved. The module's landing waits on the port
of the outside release, which turns its one declared outside theorem into a theorem of this library; your files are
done before the port is, so the landing is not held up by them.

## The statements

The claim the module proves, and what it does not claim, from the claim list fixed before it was planned:

{Q(C,"K133-ONE: ","§ Statements")}
{Q(C,"K133-NC-ONE: ","§ Not claimed")}
The last implementer's hand-back as I logged it, with my rulings (rulings 1, 2 and 4 bind you):

{item(IB)}
**Your thirteen leaves** are the `sorry`s of `{OC}Algebraic.lean` (five), `{OC}Fractional.lean` (three) and
`{OC}Pair.lean` (five) — the plan's lanes C (A1–A5, C1–C3) and D (Q1–Q5). Their statements are the files'; read them
in the source. **The plan per leaf**: `{PLAN}` § 5.3 (lane C) and § 5.4 (lane D), with § 5.5 (what each headline's
axioms must read — the standard three, or the standard three and the declared `Spectral.residual_fourier`, list by
list: a record of the second list that prints the import is a route that went wrong). The three earlier
implementers' records, `{IA}`, `{IB1}` and `{IB2}`, end with what each learned that the plan does not say.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; each leaf restated in one line
   beside the plan's route; the stored statements of the three files and of `Defs` dumped from the built tree before
   any edit.
2. **Lane C** (saved stages as leaves fall), then **lane D**; re-price what is left from the first two leaves and say so.
3. **The two edits to `Defs`**: the lemma made public (its stored type unchanged, shown by the dump), the docstring
   rewritten.
4. **No statement changed**, shown from the kernel's side against item 1's dump (the instrument
   `{W}tools/fs133_ib2_moved.py` is the pattern; a planted change watched firing), the visibility change listed; no
   `sorry` left in the three files; one build under the slot with no warning from them; the axioms of every public
   declaration of the module printed from the built tree, each matching its list in the plan's § 5.5, with a planted
   record watched showing.
5. **Drafts for the landing**, in your record: the audit's block for the three files; the model for each hypothesis
   that lacks one; the front-page lines for the module's headlines, at their grades, with what is not claimed.
6. The report in the standing rules' form. Leave no process running or queued. Say whether this tree's compiled
   library is still needed after you (the landing will want a tree).

## What is yours to decide

The proofs; private helpers; another route for a leaf where the plan's does not go through (tell me which). An
unread binder of a statement in your three files — a hypothesis or an instance that neither the statement nor its
proof reads — is dropped without asking, listed in your statement check as a ruled difference, and named in your
report (the standing word given to the earlier implementers, item 726). Anything else about a statement comes to me
first.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** One file through `lake env lean`: 3 to 24 seconds, 3.6 GB; a build with only small modules stale about 7 to
13 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name icd1 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. On exit 75 wait ten
minutes and retry. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off:
anything your record cites lives under `data/fs133/icd1/`. Report at once any disk, memory or count reading near its
limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs133/briefs/{JOB}-plane-pairs.md","w").write(b); print("ok",len(b))
