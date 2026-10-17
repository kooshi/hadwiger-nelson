exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IRF1: de Bruijn's implementer proves FS131-KFS1's Part A (C7, rational four-space at four colours), with A3 stated
# (item 1082).
# Usage: mk-fs131-irf1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-IRF1"; W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
PLAN="plans/FS131-KFS1-four-space-plan.md"; M="Proofs/HadwigerNelson/"
for p in (PLAN,"data/fs131/reports/FS131-KFS1.md",M+"RationalFour/Basic.lean",M+"RationalFour/Order.lean",M+"RationalFour/Compulsion.lean",
          M+"RationalFour/Forbid.lean",M+"Instances/SeamFractional.lean","data/fs131/clone1/run-gate.sh","tools/fs131_iru2_statements.py","LEAN.md"):
    assert os.path.exists(W+p),p
def wl(path,first,last,must):
    ls=open(W+path).read().split("\n")[first-1:last]
    t="".join("> "+l+"\n" for l in ls)+"> — source: "+path+"\n"
    assert must in t,(path,first,must); return t
T1=wl(M+"RationalFour/Compulsion.lean",105,106,"theorem forall_coloring_eq_iff")
T2=wl(M+"RationalFour/Forbid.lean",51,53,"theorem exists_coloring_forbidding_iff")
CQ=wl("CLOSED-QUESTIONS.md",674,690,"- **Which distances can a four-colouring of `ℚ⁴` forbid beside 1?**")
W2=Q("data/fs131/REQUEST-2026-10-13.md","W2: ")
I1082=item(1082); I1075=item(1075); I1025=item(1025)
b=f'''# Brief {JOB} — prove which distances a four-colouring of rational four-space can forbid: the compulsion law, Johnson's question, and the structure clause, from the skeleton and its plan

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the implementer of the planner's Part A — four skeleton modules under `Proofs/HadwigerNelson/RationalFour/` (about 1,190 lines, 36 `sorry`s), plus the structure clause A3 (about 40 lines) — every `sorry` replaced by a proof without changing a stored statement, through the full gate on one commit
  launch: now, in the planner's worktree and on its branch; beside you one implementer in another worktree proving the planner's Part B (the fractional chromatic number over ℚ(√3, √11)) on its own branch, writing none of your files
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be proved as typed (a statement defect goes back through me, never edited by you), when a re-price moves the total by more than a third, and when the gate is green on one commit; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: {STAND}
  record: `plans/{JOB}-four-space.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (at `{HEAD}`: the planner's skeletons of both parts; `.lake/build` the planner's, current for the skeleton): the four `RationalFour` modules and new modules beside them; the removal of Part B's skeleton (`Proofs/HadwigerNelson/Instances/SeamFractional.lean`, its import line in `Proofs.lean` and its `ARCHITECTURE.md` row) in your first commit; `Proofs.lean`'s import lines and `ARCHITECTURE.md` rows for your modules; the gate's inputs by the gate's own rules (`scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt`'s header); the merge of `main` before the gate; `plans/{JOB}-four-space.md`; your scripts and logs under `data/fs131/irf1/`; `data/fs131/reports/{JOB}.md`. Front-file lines are drafted in your record, not made. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard: if it refuses a commit, reword what it names and commit again, never `--no-verify`
  budget: about 500k by the harness's count, as guidance; save a stage after each module; hand back at a saved stage before about 550k, saying what is left — a successor continues from your record, and that is a good report

Hello. In 2006 Johnson asked which distances a four-colouring of rational four-space that forbids distance 1 can also
forbid. This project derived the answer by hand, the planner mapped every step to Lean and built the skeleton, and you
prove it.

## Why this job

{W2}
The question, its answer and the derivation's outline:

{CQ}
## The statements

Two of the skeleton's head statements, on your branch (the plan's § 3.2 lists every one, read aloud):

{T1}
{T2}
The plan is `{PLAN}` on your branch: § 2.1 the route; § 3.1–3.3 the modules, the heads and the plan per leaf; § 3.5 the
price; Stage 4 the drafts. Its report is `data/fs131/reports/FS131-KFS1.md`.

## My rulings

{I1082}
Why A3 matters now — a 2002 paper may hold it, and the library should state it in the form a reader compares:

{I1075}
On history and commits:

{I1025}
In short, for you: state and prove A3 (the plan's A3, the structure clause, in the vocabulary the skeleton already has)
as a head statement; remove Part B's skeleton from this branch in your first commit, so that nothing with a `sorry`
from it can reach `main` with yours; merge `main` before the gate.

## Done means

1. **Stage 1 — the readback.** Check every quotation above against its source; restate the target, the rulings and the
   order of work in your record; report any mismatch as a finding. Take a dump of the skeleton's stored statements before
   your first proof edit (a comparator shaped like `tools/fs131_iru2_statements.py`, with a planted control watched).
2. **The leaves**, in the plan's order, re-pricing from the first two leaves and writing the re-price into your record;
   every module built through `./scripts/build.sh` under the slot; a saved stage after each module.
3. **The gate on one commit**, after merging `main`: the steps of `data/fs131/clone1/run-gate.sh` (copied under
   `data/fs131/irf1/`, its logs there); every count change explained against `main`'s last gate (`data/fs131/iru2/gate/`,
   the ring of unit vectors', unless I tell you another landed first); the statement comparison against your dump, A3 the
   one added head; the vacuity scan's new sites with each structure hypothesis's inhabitant named (`LEAN.md` § The gate);
   `#print axioms` of every head statement (expected: the standard three, no outside theorem). Commit any statement dump
   gzipped.
4. **The read-aloud** of each head statement against `CLOSED-QUESTIONS.md` § 3's entry and `[Johnson2006]` p. 212's
   question, in your record, with what is not claimed.
5. **The drafts** for the front files (the plan's Stage 4 brought to what is proved), each naming its slot. No novelty
   wording: C7's prior art waits on a paper not yet read (item 1075) — write "prior art: pending `[KubickiLehelMorayne2002]`"
   where a novelty line would go.
6. **The report**, in the standing rules' form.

## What is yours to decide

The order within the plan's order, every proof, helper lemmas and their modules, and whether a leaf is better proved
another way than the plan says — say so in your record. Not yours: any stored statement of the skeleton or of `main`
(message me with the defect and the form you need). {NOSPAWN}

## The machine

The laptop: 12 cores, 31 GB, shared with one other implementer that builds and will run a full gate. From inside your
worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 5 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`;
never `lake build`. When the slot waits, another job holds the memory; on exit 75 wait ten minutes and retry. `lake env
lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The worktree's
`.lake/build` is its own copy; never replace it with a symlink. `/tmp` is a tmpfs: keep what your record cites under
`data/fs131/irf1/`. Nothing with a `sorry` reaches `main`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-four-space.md"
open(out,"w").write(b); print(out)
