exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IQP1 and FS131-ICT1: de Bruijn's implementers for the two skeletons planned by FS131-KPA1 (the p-adic plane)
# and FS131-KTC1 (three-colourings of abelian Cayley graphs), each in its planner's worktree and on its branch.
# Usage: mk-fs131-impl2.py IQP1|ICT1
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
WHICH=sys.argv[1]
if WHICH=="IQP1":
    JOB,TREE,BR,PJOB,SLUG,HEADC="FS131-IQP1","il5","fs131-kpa1","FS131-KPA1","padic","621ccacc4"
    PLAN="plans/FS131-KPA1-padic-plan.md"; ROW="75"; DATA="data/fs131/iqp1/"
    MODS="`Proofs/HadwigerNelson/PadicPlane/` (`Basic`, `Measure`, `Upper`, `Tower`, `Values`) and the three certificate modules at 7 the plan names (`Arith/FibreCert7`, `FibreCert7Check`, `FibreCert7Bound`)"
    SRC="Proofs/HadwigerNelson/PadicPlane/Values.lean"
    BLOCKS=[(53,80,"/-- **Hoffman's bound of `UD"),(125,149,"/-! ## The values -/")]
    ITEMS=[997,999]
    WHAT="the Borel chromatic number of the anisotropic p-adic plane, at least `1 + (p+1)/κ` for every prime `p ≡ 3 (mod 4)` and so unbounded in `p`, with its values at 3, 7, 11, 19 and 23"
    AX="the bound and the unboundedness on the standard three and `StandingFive.kloosterman_bound`; each value on the standard three, or with Weil's bound where its lower half reads it — the record says which"
    EXTRA='''**Item 999's ruling (2), in practice:** `six_le_borelChromaticNumber_padicPlane_twentyThree` leaves the landing's
modules (nothing with a `sorry` reaches `main`); keep its statement and its plan in your record, and state at 23 what is
proved (the upper bound eight, and whatever lower bound the held pieces give). The reduced certificate it needs is search
request 26 in `plans/SEARCH-QUEUE.md`; a later job adds it. Ruling (1): T0 by route A, from public pieces, with no edit to
`Proofs/HadwigerNelson/Rigidity/ClassRatio.lean` — another job's branch edits that file.
'''
else:
    JOB,TREE,BR,PJOB,SLUG,HEADC="FS131-ICT1","kel1","fs131-ktc1","FS131-KTC1","three-colour","29be81111"
    PLAN="plans/FS131-KTC1-three-colour-plan.md"; ROW="79"; DATA="data/fs131/ict1/"
    MODS="`Proofs/HadwigerNelson/CayleyThree/` (`Circular`, `Fibre`, `Density`)"
    SRC="Proofs/HadwigerNelson/CayleyThree/Circular.lean"
    BLOCKS=[(79,124,"/-- **The three-colour criterion")]
    SRC2,BLOCKS2="Proofs/HadwigerNelson/CayleyThree/Density.lean",[(96,107,"/-- **Periodic 3-colourings are dense**")]
    ITEMS=[996,1000]
    WHAT="the three-colour criterion for Cayley graphs of abelian groups — three-colourable exactly when a character puts every step in the middle third of the circle, exactly when (for finitely generated groups) a periodic three-colouring exists — and the density of periodic three-colourings"
    AX="the standard three, on every head statement"
    EXTRA='''**Item 1000's ruling, in practice:** the plan's order — `Circular` first (alone it gives the periodic form), then
`Fibre`, then `Density` — re-pricing at the two leaves the plan marks (`exists_le_mul_of_imp_eq_zero`,
`exists_slack_bound`) and writing the re-price into your record. If the re-price is far above the plan, say so by message:
`Circular` may then land alone. The coset reduction (plan § 3.5) rides only if the re-price leaves room; the dichotomy's
cell clause (§ 2.5) is a later module.
'''
W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
assert subprocess.run(["git","-C",W,"merge-base","--is-ancestor",HEADC,"HEAD"]).returncode==0
assert subprocess.run(["git","-C",W,"merge-base","--is-ancestor","main","HEAD"]).returncode==0
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
for p in (PLAN,f"data/fs131/reports/{PJOB}.md","data/fs131/clone1/run-gate.sh",SRC): assert os.path.exists(W+p),p
def wl(path,first,last,must):
    ls=open(W+path).read().split("\n")[first-1:last]
    assert ls[0].startswith(must),(path,first,ls[0][:60])
    return "".join("> "+l+"\n" for l in ls)+"> — source: "+path+"\n"
HEADS="\n".join(wl(SRC,a,b,m) for a,b,m in BLOCKS)
if WHICH=="ICT1": HEADS+="\n"+"\n".join(wl(SRC2,a,b,m) for a,b,m in BLOCKS2)
W2=Q("data/fs131/REQUEST-2026-10-13.md","W2: ")
RULE="\n".join(item(n) for n in ITEMS)
b=f'''# Brief {JOB} — implement the {SLUG} skeleton: every `sorry` proved, the build, the gate on one commit and the drafts

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the implementer of the modules a planner typed and planned ({PJOB}) — {WHAT} — every `sorry` replaced by a proof without changing a statement, then the full gate on one commit
  launch: now, in the planner's worktree and on its branch; beside you two other jobs (the collapse's implementer, which may be gating, and the implementer of the other skeleton planned this afternoon), neither of which writes a file you write
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be proved as typed (a statement defect goes back through me, never edited by you), for a generalization, and when the gate is green on one commit; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-{SLUG}.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (at `{HEAD}`: the planner's last commit `{HEADC}` with `main` merged in, no Lean changed; `.lake/build` holds the built skeleton): {MODS} — their proofs, and their statements only by my word; new helper modules you create, each named in your record; `Proofs.lean`; `ARCHITECTURE.md`'s rows for these modules; the gate's inputs (`scripts/Axioms.lean` and the rest) by the gate's own rules; `plans/{JOB}-{SLUG}.md`; your scripts and logs under `{DATA}`; `data/fs131/reports/{JOB}.md`. Front-file edits (`LEDGER.md`, `CLAUDE.md`, `LEAN.md`, `ROADMAP.md`, `README.md`, `CLOSED-QUESTIONS.md`, `BIBLIOGRAPHY.md`) are drafted in your record, each naming its slot. Commit on your branch by explicit path; never push
  budget: about 450k by the harness's count, as guidance; save a stage after each module; hand back at a saved stage before about 550k, saying what is left — a successor continues from your record, and that is a good report

Hello. The planner who typed these modules handed back an hour ago with a plan per leaf and a skeleton that builds
green; you prove the leaves.

## Why this job

{W2}
This row of the ledger (row {ROW}) is a finding of ours held by hand; with this module it becomes a kernel theorem. My
rulings on the planner's open choices, from the inventory:

{RULE}
{EXTRA}
## The statements

The head statements as the skeleton types them on your branch (the plan names every other):

{HEADS}
The plan is `{PLAN}` on your branch (also on `main`): its read-aloud of the head statements against ledger row {ROW}, the
plan per leaf with routes, Mathlib names at the pin and line counts, the price, and its drafts for the front files. Its
report is `data/fs131/reports/{PJOB}.md`.

## Done means

1. **Stage 1 — the readback.** Check the quotations above against their sources; restate in your record the targets and
   the order of work; dump the skeleton's stored statements before your first proof, for the gate's comparison (the
   collapse job's method: `/home/kooshi/source/lean-dir/.claude/worktrees/kcl1/data/fs131/ico1/lean/StatementDump.lean`
   and `/home/kooshi/source/lean-dir/.claude/worktrees/kcl1/data/fs131/ico2/statements.py`, in that job's worktree; read
   them, never write there).
2. **The leaves**, in the plan's order, re-pricing from the first two leaves of each kind and writing the re-price into
   your record; a saved stage after each module.
3. **The build** through `./scripts/build.sh` under the slot, with no `sorry` in the landing's modules, and `lake lint`.
4. **Merge `main`**, then **the gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copied under
   `{DATA}`, its logs pointed there), every count change explained against the last gate on `main` (at present
   `data/fs131/il5/gate/`, gated on `113ca8ece`; if the collapse lands on `main` before your gate, its gate is the
   baseline, and I will tell you), the statement comparison against your stage-1 dump, the vacuity scan's new sites with
   each structure hypothesis's inhabitant named (`LEAN.md` § The gate), and `#print axioms` of every head statement
   (expected: {AX}).
5. **The read-aloud** of each head statement against ledger row {ROW}, in your record, with what is not claimed.
6. **The drafts** for the front files (the planner's, brought to what is proved), each naming its slot; novelty in the
   ledger's words ("prior art: not found in print" only where that is the finding).
7. **The report**, in the standing rules' form.

## What is yours to decide

Every proof, helper lemmas and their modules, the order within the plan's order, and whether a leaf is better proved
another way than the plan says — say so in your record. Not yours: any stored statement of the skeleton or of `main`
(message me with the defect and the form you need).

## The machine

The laptop: 12 cores, 31 GB, shared with two other jobs, one of which builds at 16 GiB until its gate is done. From inside
your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 5 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`
(or `--mem 4 --cpus 1 -- lake env lean …` for one file); never `lake build`. When the slot waits, another job holds the
memory; on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`)
is for iteration only, never evidence. The worktree's `.lake/build` is its own copy; never replace it with a symlink.
`/tmp` is a tmpfs: keep what your record cites under `{DATA}`. Nothing with a `sorry` reaches `main`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-{SLUG}.md"
open(out,"w").write(b); print(out)
