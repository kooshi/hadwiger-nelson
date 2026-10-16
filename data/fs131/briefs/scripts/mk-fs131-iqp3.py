exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IQP3: the second successor takes the p-adic plane (ledger row 75, FS66-T7) from FS131-IQP2's stage 1 (the readback) to the gate.
# Usage: mk-fs131-iqp3.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-IQP3"; W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
assert subprocess.run(["git","-C",W,"merge-base","--is-ancestor","main","HEAD"]).returncode==0
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
REC="plans/FS131-IQP2-padic.md"
for p in (REC,"data/fs131/reports/FS131-IQP1.md","plans/FS131-KPA1-padic-plan.md","data/fs131/clone1/run-gate.sh",
          "data/fs131/iqp1/statements-before.txt","data/fs131/iqp1/lean/StatementDump.lean","data/fs131/iqp1/leaves-23.lean",
          "data/fs131/ico2/statements.py","data/fs131/ico2/gate/run-pass.out","data/fs131/briefs/FS131-IQP1-padic.md",
          "Proofs/HadwigerNelson/Arith/CircleCos.lean","plans/FS131-IQP1-padic.md"): assert os.path.exists(W+p),p
I1002=item(1002); I1014=item(1014); I1018=item(1018); I1020=item(1020)
b=f'''# Brief {JOB} — the p-adic plane to the gate: the ruled drops, five colours at 23, lint, the gate on one commit, the read-aloud and the drafts

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the successor implementer of the p-adic plane's Borel bound and values (ledger row 75, FS66-T7) — every leaf of the landing is proved and built by the first job; the second read back its brief and planned the rest, then stopped at a pause Kooshi called, with no Lean edited; you apply two ruled drops, prove five colours at 23 in place of four, run lint and the full gate on one commit with the statement comparison, read the head statements aloud against row 75, and draft the front page
  launch: now, in the same worktree and on the same branch as the two jobs before you; beside you the three-colour implementer and the density form's implementer in other worktrees, writing none of your files
  mission: § Why this job
  statements: § Where the work stands
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be kept or a gate step fails in a way no rule explains, and when the gate is green on one commit; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so, as the job before you did)
  standing rules: {STAND}
  record: `plans/{JOB}-padic.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (at `{HEAD}`: the second job's readback commit on top of the first job's work with `main` merged in — the collapse's Lean and the joined import blocks of `Proofs.lean`; `.lake/build` is a copy of `main`'s build as of that merge, untouched since, so the first build recompiles the eight landing modules and the root): the modules under `Proofs/HadwigerNelson/PadicPlane/` and the three `Arith/FibreCert7*` modules (proofs; statements only as ruled below); `Proofs.lean`; `ARCHITECTURE.md`'s rows for these modules; the gate's inputs by the gate's own rules; `plans/{JOB}-padic.md`; your scripts and logs under `data/fs131/iqp3/`; `data/fs131/reports/{JOB}.md`. Front-file edits are drafted in your record, each naming its slot. Commit on your branch by explicit path; never push
  budget: about 400k by the harness's count, as guidance; save a stage after the drops and the value at 23, after the gate, after the read-aloud and after the drafts; hand back at a saved stage before about 500k

Hello. You arrive with the mathematics done but for one small improvement: every leaf of the landing is proved and the
build is green. What is left is that improvement and the check that makes it a landing. The job before you was stopped
after its readback, at a pause Kooshi called; it saved that stage and wrote out the rest in order, and it
cannot be resumed (item 1020 below), so its plan is yours to start from.

## Why this job

The rule this project publishes by is Kooshi's W2 (`data/fs131/REQUEST-2026-10-13.md`): any finding of ours is
formalized. The p-adic bound answers a question posed in print (`[BardestaniMallahiKarai2017]` Question 1). The brief the
job before you worked to, `data/fs131/briefs/FS131-IQP1-padic.md`, holds the head statements as typed and its § Done
means steps 3–7, which still hold.

## Where the work stands

My log of the second job's stop, and why you, not it, carry on:

{I1018}
{I1020}
My log of the first job's hand-back, with my rulings on its two findings:

{I1014}
And the ruling on the three leaves at 23 that wait on a search:

{I1002}
The second job's record is `{REC}`: its § 1.2 is the remaining work in order, with the drops' call sites and the route
to five colours at 23 already read, and you may start from it (check it against the source as you go). The first job's
record is `plans/FS131-IQP1-padic.md`, its report `data/fs131/reports/FS131-IQP1.md`; the leaves at 23 are kept in `data/fs131/iqp1/leaves-23.lean`. The plan is
`plans/FS131-KPA1-padic-plan.md`. The cosine bound at 23 is in `Proofs/HadwigerNelson/Arith/CircleCos.lean`.

## Done means

1. **Stage 1 — the readback**: check the four quotations above; restate in your record what is left and the order (the second job's § 1.2, corrected where the source disagrees).
2. **The ruled changes**: drop `hk` from `PadicPlane.exists_levelEmbedding` and `hpP` from
   `charSum_levelOne_of_unitCircle`, their call sites updated; prove `five_le_borelChromaticNumber_padicPlane_twentyThree`
   from `CircleCos.circleCos_ge` through `le_borelChromaticNumber_of_charSum`, in place of `four_le_…` (or keep `four_le_…`
   and say why, if it runs far over its 50–70 lines); the build green; `lake lint` (a saved stage).
3. **The gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copied under `data/fs131/iqp3/`, its logs
   there), every count change explained against `main`'s last gate (`data/fs131/ico2/gate/`, the collapse's, gated on
   `7c72b9bf7`, unless I tell you another landed first); the statement comparison against
   `data/fs131/iqp1/statements-before.txt` (the dumper `data/fs131/iqp1/lean/StatementDump.lean`, the three `FibreCert7`
   modules added to its list; a comparator shaped like `data/fs131/ico2/statements.py`, with a planted control watched),
   the ruled changes listed (the three leaves at 23 moved out, the two drops, `four_le` → `five_le`, the new helpers); the
   vacuity scan's new sites with each structure hypothesis's inhabitant named (the previous record names one: the colouring
   binders at `p = 3`, `k = 3`); `#print axioms` of every head statement (expected: the bound by characters on the standard
   three; the Weil form, the unboundedness, the value at 3 and the lower end at 23 with `StandingFive.kloosterman_bound` or
   on the standard three as the proofs read it — the record says which; the values at 7, 11, 19 on the standard three).
   Commit any statement dump you add gzipped (inventory item 1011).
4. **The read-aloud** of each head statement against ledger row 75 and FS66-T7, in your record, with what is not claimed
   (the plain chromatic number of `ℚ_p²`; `6 ≤ χ_Bor(ℚ₂₃²)`; the level clause at 23).
5. **The drafts** for the front files (the planner's § 5.2–5.6 brought to what is proved, the two `LEAN.md` lines the
   previous report names among them), each naming its slot; the posers' question credited to them.
6. **The report**, in the standing rules' form.

## What is yours to decide

Every proof the changes need, and how the comparator is built. Not yours: any stored statement beyond the ruled changes.

## The machine

The laptop: 12 cores, 31 GB, shared with two other implementers. From inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 5 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`;
never `lake build`. When the slot waits, another job holds the memory; on exit 75 wait ten minutes and retry. `lake env
lean` is for iteration only. The worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` is a
tmpfs: keep what your record cites under `data/fs131/iqp3/`. Nothing with a `sorry` reaches `main`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-padic.md"
open(out,"w").write(b); print(out)
