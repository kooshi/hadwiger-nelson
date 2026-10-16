exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IRU2: the successor merges main (the five-colour and density landings) into the ring lemma's branch and runs
# the full gate once on that merge commit (item 1065).
# Usage: mk-fs131-iru2.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-IRU2"; W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main")
REC="plans/FS131-IRU1-ring.md"
for p in (REC,"data/fs131/reports/FS131-IRU1.md","data/fs131/iru1/gate/run-pass.out","tools/fs131_iru1_audit_block.py","tools/fs131_iru1_statements.py"):
    assert os.path.exists(W+p),p
I1065=item(1065); I1063=item(1063); I1025=item(1025)
b=f'''# Brief {JOB} — the ring of unit vectors: merge `main`, keep every landing's gate inputs, and run the full gate once

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the successor implementer of the ring of unit vectors (Lemma C′, the components clause, the dichotomy) — every proof is done and gated on a commit that predates two landings; you merge `main` into the branch, reconcile the gate's input files so every landing's entries stand, and run the full gate once on that merge commit
  launch: now, in the predecessor's worktree and on its branch; beside you a filing clerk in another worktree, writing none of your files
  mission: § Why this job
  statements: § Where the work stands
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage at once if a merge conflict is not a gate input's list (a proof or a statement), or a gate step fails in a way no rule explains, and when the gate is green on one commit; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: {STAND}
  record: `plans/{JOB}-ring.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (at `{HEAD}`; its `.lake/build` is the predecessor's gated build of `e849029c3`): the merge of `main` (at `{MAIN}` or later) and its conflict resolutions; the gate's inputs by the gate's own rules (`scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt`'s header, `Proofs.lean`, `ARCHITECTURE.md` rows); no proof or statement; `plans/{JOB}-ring.md`; your scripts and logs under `data/fs131/iru2/`; `data/fs131/reports/{JOB}.md`; the counts in the predecessor's drafts brought to your gate, written into your own record. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard: if it refuses a commit, reword what it names and commit again, never `--no-verify`
  budget: about 250k by the harness's count, as guidance; save a stage after the merge and after the gate; hand back before about 350k

Hello. The mathematics here is done and checked; what is left is making the check hold on the tree that will land.

## Why this job

The landing rule is that `main`, after the merge, equals the gated commit in `Proofs/`, `scripts/` and the package files.
Two other modules landed after this branch's gate, and each edits the same gate inputs. The predecessor's hand-back and
my rulings on it:

{I1065}
## Where the work stands

The landing that went in just before you, whose gate is your baseline:

{I1063}
On history and commits:

{I1025}
The predecessor's record is `{REC}` (on `main` too): its § 3.5 lists the gate inputs this branch edits (its CLEAN audit
block, the retired `.condition` entry for `Arith.IsUsablePrime`, the vacuity header), and its report's last held item says
what the aborted merge showed. The density landing's successor solved the same problem: `plans/FS131-IFR2-density.md`, with
its two comparison tools `tools/fs131_ifr2_statements.py` and `tools/fs131_ifr2_axioms_diff.py`, on `main`.

## Done means

1. **Stage 1 — the readback.** Check the quotations above against their source; restate in your record what the merge
   must keep and the order of work.
2. **The merge.** `git merge main` into `{BR}`; every conflict in a gate input resolved by keeping both sides' entries
   (lists of `#print axioms` lines, state-control counts, ledger rows, import lines); `main`'s build files copied in by
   checksum (`rsync -a --checksum`, no `--delete`; a dry run first); the build green under the slot; a saved stage.
3. **The gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copied under `data/fs131/iru2/`), with the
   audit block's coverage over this branch's records, `--write-ledger` re-run and the retired `.condition` entry kept
   retired; every count change explained against the density landing's gate (`data/fs131/ifr2/gate/` on `main`); this
   branch's modules' stored statements and axioms shown unchanged from the predecessor's gated prints; `#print axioms` of
   the head statements (expected: the standard three, as the predecessor printed them). A saved stage.
4. **The drafts' counts**: the predecessor's front-page drafts (its record § Drafts for the front page) restated in your
   record with this gate's counts, each naming its slot; nothing else in them changed.
5. **The report**, in the standing rules' form.

## What is yours to decide

How you resolve each gate-input conflict, as long as every landing's entries stand. Not yours: any proof or statement.

## The machine

The laptop: 12 cores, 31 GB, shared with a filing clerk. From inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 5 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh`;
never `lake build`. On exit 75 wait ten minutes and retry. The worktree's `.lake/build` is its own copy; never replace it
with a symlink. Keep every working file under `data/fs131/iru2/` (standing rule 2). Nothing with a `sorry` reaches `main`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-ring.md"
open(out,"w").write(b); print(out)
