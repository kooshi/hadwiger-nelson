exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-ICO1: de Bruijn's implementer proves the collapse (ledger row 128) from FS131-KCL1's skeleton and plan.
# Usage: mk-fs131-ico1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-ICO1"; W=WT+TREE+"/"
# fresh(JOB) is not called: the one commit of this id before the brief is my merge of main into the branch, made to
# start the job (its subject 'FS131-ICO1: main merged into the collapse skeleton's branch …'); nothing else carries it.
import glob
assert not glob.glob(ROOT+f'plans/{JOB}-*') and not glob.glob(ROOT+f'data/fs131/briefs/{JOB}-*')
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
PLAN="plans/FS131-KCL1-collapse-plan.md"
for p in (PLAN,"data/fs131/reports/FS131-KCL1.md","Proofs/HadwigerNelson/Collapse/Headline.lean","data/fs131/clone1/run-gate.sh",
          "data/fs131/clone1/gate/run-pass.out","LEAN.md"): assert os.path.exists(W+p),p
def wl(path,first,last):
    ls=open(W+path).read().split("\n")[first-1:last]
    return "".join("> "+l+"\n" for l in ls)+"> — source: "+path+"\n"
T1=wl("Proofs/HadwigerNelson/Collapse/Headline.lean",116,117)
T2=wl("Proofs/HadwigerNelson/Collapse/Headline.lean",70,71)
T3=wl("Proofs/HadwigerNelson/Collapse/Headline.lean",165,166)
assert "theorem chromaticNumber_planeOver_sqrt635087 :" in T1 and "theorem chromaticNumber_planeOver_eq_plane_of_thick" in T2 and "theorem chromaticNumber_planeOver_deGrey :" in T3
R128=Q("LEDGER.md","| 128 |")
W2=Q("data/fs131/REQUEST-2026-10-13.md","W2: ")
b=f'''# Brief {JOB} — prove the collapse: the plane over ℚ(√635087) has the plane's chromatic number, from the skeleton and its plan

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus
  role: the implementer of seven modules a planner typed and planned — ledger row 128's field equality, proved in the kernel with no hypothesis of ours — every `sorry` replaced by a proof without changing a statement, then the full gate on one commit
  launch: now, in the planner's worktree, on a branch cut from its skeleton with `main` merged in; beside you an implementer of one short theorem in another worktree, which may run the gate; neither writes the other's files
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be proved as typed (a statement defect goes back through me, never edited by you), and when the gate is green on one commit; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/{JOB}-collapse.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (at `{HEAD}`: the planner's branch `fs131-kcl1` with `main` merged in; `.lake/build` current for the skeleton): the seven modules under `Proofs/HadwigerNelson/Collapse/` (their proofs; their statements only by my word); the two drafted edits D-E1 (`Proofs/HadwigerNelson/Arith/FloorPlanes.lean`) and D-E2 (`Proofs/HadwigerNelson/Rigidity/ClassRatio.lean`), which I approve below; `Proofs.lean`; `ARCHITECTURE.md`'s seven module rows (the planner's draft); the gate's inputs (`scripts/Axioms.lean` and the rest) by the gate's own rules; `plans/{JOB}-collapse.md`; your scripts and logs under `data/fs131/ico1/`; `data/fs131/reports/{JOB}.md`. Front-file edits (`LEDGER.md` rows 120 and 128, `CLAUDE.md`, `ROADMAP.md`, `README.md`) are drafted in your record, each naming its slot. Commit on your branch by explicit path; never push
  budget: about 500k by the harness's count, as guidance; save a stage after each module or pair of modules; hand back at a saved stage before about 550k, saying what is left — a successor continues from your record, and that is a good report

Hello. The planner who typed these modules answered a question this morning that decides a good deal: the measure
rigidity the library already proves is exactly what ledger row 128 needs. So the statement that the plane over one
real quadratic field needs as many colours as the whole plane can be a kernel theorem with no hypothesis of ours.
The skeleton builds green; you prove its leaves.

## Why this job

{W2}
Row 128 is that kind of finding: this project's derivation, [hand], given MR. It is one of the strongest things the
library can say about planes over number fields — with the outside release's `6 ≤ χ(ℝ²)` it puts the plane over
ℚ(√635087) at six or seven colours — and with this module it stops being conditional.

## The statements

The row, as the ledger states it now:

{R128}
The skeleton's three headline statements, on your branch (the plan names every other):

{T1}
{T2}
{T3}
The plan is `{PLAN}` on your branch: § 4.1 reads the target aloud against the row; § 4.2 lists the skeleton; § 4.3 is the
plan per leaf (48 `sorry` leaves); § 4.4 the price (about 3,270 lines) and the order of the leaves; § 4.5 the drafted edits;
§ 4.6 the modeling passes it did not run; § 4.7 the front-page corrections it drafted; § 4.8 its build. Its report is
`data/fs131/reports/FS131-KCL1.md`.

**My rulings on the plan's open choices:**
1. **D-E1 and D-E2 are approved** as drafted in § 4.5 (new public theorems; no stored statement moves). *Why:* about 140
   lines in place of about 350 copied from a private chain, and the two-sided bound is the form a reader wants. Their
   dependents recompile; measure that before you commit to it, and if the rebuild is far over an hour on this laptop,
   say so and take the copy instead.
2. **D-E3 is declined** (it would move a landed stored statement).
3. **De Grey's field rides in this job** (about 65 lines; it discharges row 128's "MR at degree 16 … one checking
   reading").
4. **The general form stays as typed** — every real number field whose stable primes are uniformly `c`-thick with
   `c < 1/5`, no "totally real" — because the kernel is the check; if a leaf turns out to need total reality, that is a
   statement defect: message me.
5. The one non-`sorry` warning (`unusedSectionVars` at `Collapse.ThickAt.mono`) is fixed by the `omit` line the plan names.
6. The experience-modeling pass the planner skipped is owed before the landing (`debruijn-experience-modeling`): the
   headline names and docstrings read as a mathematician would cite them.

## Done means

1. **Stage 1 — the readback.** Check the quotations; restate the target and the order of work in your record.
2. **The leaves**, in the plan's order, re-pricing from the first two leaves of each kind (a copy leaf, a new leaf) and
   writing the re-price into your record; every module built through `./scripts/build.sh` under the slot; a saved stage
   after each module or pair.
3. **The gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copy it under `data/fs131/ico1/` and point its
   logs there), every count change explained against this morning's run (`data/fs131/clone1/gate/`), the vacuity scan's
   new sites and each structure hypothesis's inhabitant named (`LEAN.md` § The gate), and `#print axioms` of the three
   headlines (expected: the standard three, `Rigidity.positive_entropy_rigidity`, `StandingFive.kloosterman_bound`; the
   six-or-seven corollary adds `Outside.OAI158.no_proper_five_coloring`).
4. **The read-aloud** of each headline against row 128, in your record.
5. **The drafts** for the front files (the planner's § 4.7, brought to what is proved), each naming its slot; novelty as
   the ledger words it — the field equality "prior art: not found in print"; the plane equality is `[OAIMath2026]`'s.
6. **The report**, in the standing rules' form.

## What is yours to decide

The order within the plan's order, every proof, helper lemmas and their modules, and whether a leaf is better proved
another way than the plan says — say so in your record. Not yours: any stored statement of the skeleton or of `main`
(message me with the defect and the form you need).

## The machine

This is the laptop: 12 cores, 31 GB, shared with one other implementer. From inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 12 --cpus 6 -- env MEMMAX=12G BATCH=4 ./scripts/build.sh`;
on exit 75 wait ten minutes and retry; never `lake build`. `lake env lean` (with `-DautoImplicit=false
-DrelaxedAutoImplicit=false`) is for iteration only. `/tmp` is a tmpfs: keep what your record cites under `data/fs131/ico1/`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-collapse.md"
open(out,"w").write(b); print(out)
