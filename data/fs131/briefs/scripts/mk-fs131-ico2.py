exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-ICO2: the successor implementer finishes the collapse (ledger row 128) from FS131-ICO1's stage 5.
# Usage: mk-fs131-ico2.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-ICO2"; W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
assert sh("git","-C",W,"status","--porcelain")==""
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
REC="plans/FS131-ICO1-collapse.md"
for p in (REC,"data/fs131/reports/FS131-ICO1.md","plans/FS131-KCL1-collapse-plan.md","data/fs131/clone1/run-gate.sh"): assert os.path.exists(W+p),p
I993=item(993)
I988=item(988)
b=f'''# Brief {JOB} — finish the collapse: the last three modules, the build, the gate and the drafts

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus
  role: the successor implementer of the collapse (ledger row 128's field equality) — the previous implementer proved four of its seven modules and the two approved edits and handed back at its budget line; you prove the last three, build, run the gate on one commit, and draft the front page
  launch: now, in the same worktree and on the same branch as the job before you; no other job is running
  mission: § Why this job
  statements: § Where the work stands
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be proved as typed (a statement defect goes back through me), and when the gate is green on one commit; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published). Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/{JOB}-collapse.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (at `{HEAD}`, clean): the modules under `Proofs/HadwigerNelson/Collapse/` (proofs; statements only as ruled below or by my word); `Proofs.lean`; `ARCHITECTURE.md`'s seven module rows; the gate's inputs by the gate's own rules; `plans/{JOB}-collapse.md`; your scripts and logs under `data/fs131/ico2/`; `data/fs131/reports/{JOB}.md`. Front-file edits are drafted in your record, each naming its slot. Commit on your branch by explicit path; never push
  budget: about 450k by the harness's count, as guidance; save a stage after each module, after the build, after the gate and after the drafts; hand back at a saved stage before about 550k

Hello. You arrive at a good point: the hard new mathematics of this module — thickness by Weil's bound, the mixing on
the compact factor, the colour dichotomy — is proved, and what is left is mostly a copy of landed modules at `k` colours
and the headline assembly, about 600 lines on the last job's own re-price.

## Why this job

The collapse is the statement that the plane over ℚ(√635087) needs exactly as many colours as the whole plane, proved
with no hypothesis of ours, on the two outside theorems the five-colour results already rest on. My log of the planner's
hand-back, with the announcement rule this landing must meet:

{I988}
## Where the work stands

{I993}
The brief the previous job worked to is `data/fs131/briefs/FS131-ICO1-collapse.md`: its § The statements (the three
headlines and my rulings 1–4 and 6), § Done means and § The machine are part of this brief and still hold. Its ruling 5
is replaced by item 993's ruling above. Your starting list is § Stage 5 of `{REC}` (each remaining leaf with its route);
the plan per leaf is `plans/FS131-KCL1-collapse-plan.md` § 4.3. Item 993's ruling, in practice: keep the committed
`omit` at `Collapse.ThickAt.mono`, use an `omit` at `Collapse/Slice`'s `measure_ne_eq_k` if it does not read
`[NumberField F]`, and list both in the gate's statement comparison as ruled changes, from the kernel's side.

## Done means

1. **Stage 1 — the readback**: check the quotations; check the branch against the previous record's stage 5; restate
   the order of work.
2. **`Collapse/Slice`, `Collapse/Selection`, `Collapse/Headline`**, in that order, a saved stage after each; then the
   experience pass the brief before you owes (`debruijn-experience-modeling`: the headline names and docstrings as a
   mathematician would cite them).
3. **The build** through `./scripts/build.sh` under the slot, with no `sorry` anywhere in `Proofs/HadwigerNelson/Collapse/`.
4. **Merge `main`**, then **the gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copied under
   `data/fs131/ico2/`), every count change explained against `main`'s last gate (`data/fs131/il5/gate/`, the named
   theorem's, gated on `113ca8ece`), the statement comparison against `data/fs131/ico1/statements-before.txt.gz` with the
   ruled changes listed, the vacuity scan's new sites with each structure hypothesis's inhabitant named, and
   `#print axioms` of the three headlines and of D-E1 and D-E2.
5. **The read-aloud** of each headline against `LEDGER.md` row 128, in your record.
6. **The drafts** for the front files (the planner's § 4.7 brought to what is proved), each naming its slot.
7. **The report**, in the standing rules' form.

## What is yours to decide

Every proof, helper lemmas, the order within each module. Not yours: any stored statement beyond the ruled `omit`s.

## The machine

The laptop, 12 cores, 31 GB, and no other job running: from inside the worktree,
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 16 --cpus 10 -- env MEMMAX=16G BATCH=6 ./scripts/build.sh`;
never `lake build`; `lake env lean` for iteration only; keep what your record cites under `data/fs131/ico2/`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-collapse.md"
open(out,"w").write(b); print(out)
