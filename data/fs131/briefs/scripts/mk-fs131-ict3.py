exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-ICT3: the second successor takes the three-colour criterion (ledger row 79) from FS131-ICT2's stage 2 to the gate.
# Usage: mk-fs131-ict3.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-ICT3"; W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
assert subprocess.run(["git","-C",W,"merge-base","--is-ancestor","main","HEAD"]).returncode==0
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
REC="plans/FS131-ICT2-three-colour.md"
for p in (REC,"data/fs131/reports/FS131-ICT1.md","plans/FS131-KTC1-three-colour-plan.md","data/fs131/clone1/run-gate.sh",
          "data/fs131/ict1/statements-before.txt.gz","data/fs131/ict1/lean/StatementDump.lean","data/fs131/ico2/statements.py",
          "data/fs131/ico2/gate/run-pass.out","data/fs131/briefs/FS131-ICT1-three-colour.md","plans/FS131-ICT1-three-colour.md",
          "data/fs131/ict2/run-gate.sh","data/fs131/ict2/lean/StatementDump.lean","data/fs131/ict2/lean/ReAdd.lean","tools/fs131_ict2_statements.py",
          "data/fs131/ict2/lean/AxiomsAll.lean","tools/fs131_ict2_audit_block.py","data/fs131/ict2/lean/VacuityNew.lean","data/fs131/ict2/lean/ReadAloud.lean"): assert os.path.exists(W+p),p
I1003=item(1003); I1012=item(1012); I1019=item(1019); I1020=item(1020)
b=f'''# Brief {JOB} — the three-colour criterion to the gate: lint, the ruled drops, the gate on one commit, the read-aloud and the drafts

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the successor implementer of ledger row 79's three-colour criterion — every leaf is proved and built by the first job, and the second applied the two ruled statement drops, rebuilt green and wrote the gate's tools before a pause Kooshi called; you add five spec examples, run lint, the full gate on one commit with the statement comparison, read the head statements aloud against row 79, and draft the front page
  launch: now, in the same worktree and on the same branch as the two jobs before you; beside you the `p`-adic implementer and the density form's implementer in other worktrees, writing none of your files
  mission: § Why this job
  statements: § Where the work stands
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage at once if a statement cannot be kept or a gate step fails in a way no rule explains, and when the gate is green on one commit; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-three-colour.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (at `{HEAD}`: the second job's last commit, with `main` merged in since, no Lean; `.lake/build` holds the second job's green build of exactly these sources, so a rebuild after the spec examples recompiles only what they touch): the three modules under `Proofs/HadwigerNelson/CayleyThree/` (proofs; statements only as ruled below); `Proofs.lean`; `ARCHITECTURE.md`'s rows for these modules; the gate's inputs by the gate's own rules; `plans/{JOB}-three-colour.md`; your scripts and logs under `data/fs131/ict3/` (the second job's tools under `data/fs131/ict2/` and `tools/fs131_ict2_*.py` are yours to run and fix in place); `data/fs131/reports/{JOB}.md`. Front-file edits are drafted in your record, each naming its slot. Commit on your branch by explicit path; never push
  budget: about 400k by the harness's count, as guidance; save a stage after the spec examples and lint, after the gate, after the read-aloud and after the drafts; hand back at a saved stage before about 500k

Hello. You arrive with the mathematics done: every leaf of the three modules is proved, the two ruled drops are in, and
the build is green. What is left is five small examples and the check that makes it a landing. The job before you stopped
at a pause Kooshi called, with its stage saved and the rest written out in order; it cannot be resumed (item 1020 below),
so its record is yours to start from.

## Why this job

The rule this project publishes by is Kooshi's W2 (`data/fs131/REQUEST-2026-10-13.md`): any finding of ours is
formalized. Ledger row 79 is one; the first job proved it in a wider form than the row states, by my ruling of item
996. The brief the first job worked to, `data/fs131/briefs/FS131-ICT1-three-colour.md`, holds the head statements as typed and
its § Done means steps 3–7, which still hold.

## Where the work stands

My log of the second job's stop, and why you, not it, carry on:

{I1019}
{I1020}
My log of the first job's hand-back, with my ruling on its two unread hypotheses (the second job applied it):

{I1012}
And the earlier ruling on the false skeleton statement it corrected:

{I1003}
The second job's record is `{REC}`: its § 2.4 is the remaining work in order, and its § 2.3 lists the gate's
tools it wrote — none run or plant-tested yet, so run each with its control first and fix what the first run shows. The
first job's record is `plans/FS131-ICT1-three-colour.md`: §§ 3.4, 4 and 5 list the new public helper constants for the
statement comparison's allow-list. The plan is `plans/FS131-KTC1-three-colour-plan.md`; its § 3.7 names the structures
whose models the vacuity scan will ask for, and its § 3.8 drafts the front-page lines.

One wording rule, new today (inventory item 1022): the repository is public, and the second job's record gives the
reason for Kooshi's pause in words the privacy guard refuses. Do not repeat them: in your record, messages and report,
the pause is "a pause Kooshi called", nothing more. I will reword the predecessor's lines at the merge.

## Done means

1. **Stage 1 — the readback**: check the four quotations above; restate in your record what is left and the order (the second job's § 2.4, corrected where the source disagrees).
2. **The spec examples, then lint**: an `example` for each of the five definitions with none of its own —
   `circularColoring`, `tightSet`, `fibre`, `Winding.flip`, `coloringOneTwo` — each one that would fail if the definition
   drifted (`LEAN.md` § The gate); the build green; then `lake lint` (a saved stage). The two ruled drops are done
   (item 1019); check them in the source, nothing more.
3. **The gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (the second job's copy, `data/fs131/ict2/run-gate.sh`; its logs
   under `data/fs131/ict3/gate/`), every count change explained against `main`'s last gate (`data/fs131/ico2/gate/`, the collapse's, gated on
   `7c72b9bf7`); the statement comparison against `data/fs131/ict1/statements-before.txt.gz` (the dumper
   `data/fs131/ict1/lean/StatementDump.lean`; a comparator shaped like `data/fs131/ico2/statements.py`), with the three
   ruled changes (`mcshane_model`'s conclusion, the two drops) and the new helper constants listed; the vacuity scan's new
   sites with each structure hypothesis's inhabitant named; `#print axioms` of every head statement (expected: the
   standard three). Commit any statement dump you add gzipped, as `data/fs131/ict1/statements-before.txt.gz` is (inventory item 1011:
   two uncompressed 48.7 MB dumps went public before this rule).
4. **The read-aloud** of each head statement against ledger row 79, in your record, with what is not claimed.
5. **The drafts** for the front files (the plan's § 3.8, brought to what is proved), each naming its slot. The prior-art
   search the plan's § 3.6 asks for has not been run (item 1000): word nothing as new; say "prior art not yet searched"
   where a novelty line would go.
6. **The report**, in the standing rules' form.

## What is yours to decide

Every proof change the drops need, and how the comparator is built. Not yours: any stored statement beyond the three
ruled changes.

## The machine

The laptop: 12 cores, 31 GB, shared with two other implementers. From inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 5 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`;
never `lake build`. When the slot waits, another job holds the memory; on exit 75 wait ten minutes and retry. `lake env
lean` is for iteration only. The worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` is a
tmpfs: keep what your record cites under `data/fs131/ict3/`. Nothing with a `sorry` reaches `main`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-three-colour.md"
open(out,"w").write(b); print(out)
