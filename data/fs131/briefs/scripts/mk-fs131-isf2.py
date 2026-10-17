exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-ISF2: the successor merges main (rank 7's RationalFour) into the fractional chromatic number's branch, makes item
# 1089's docstring amendment, and runs the full gate once (item 1092).
# Usage: mk-fs131-isf2.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-ISF2"; W=WT+TREE+"/"
fresh(JOB)
assert os.path.isdir(W+".lake/build") and os.path.islink(W+".lake/packages")
assert sh("git","-C",W,"branch","--show-current")==BR
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main")
REC="plans/FS131-ISF1-seam-fractional.md"
for p in (REC,"data/fs131/reports/FS131-ISF1.md","data/fs131/clone1/run-gate.sh","tools/fs131_isf1_statements.py",
          "data/fs131/isf1/lean/AxiomsAll.lean","data/fs131/isf1/modules.txt","LEAN.md"):
    assert os.path.exists(W+p),p
I1092=item(1092); I1089=item(1089)
b=f'''# Brief {JOB} — the fractional chromatic number over ℚ(√3, √11): merge `main`, make one ruled docstring edit, and run the full gate once

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the successor implementer of the fractional chromatic number over ℚ(√3, √11) — every proof is done and the build is green; you merge `main` into the branch, make one docstring edit I ruled, run the full gate once on one commit, and restate the count drafts
  launch: now, in the predecessor's worktree and on its branch; no other agent is running
  mission: § Why this job
  statements: § Where the work stands
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage at once if a merge conflict is not a gate input's list (a proof or a statement), or a gate step fails in a way no rule explains, and when the gate is green on one commit; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back (if the harness refuses the file, put the full text in the hand-back and say so)
  standing rules: {STAND}
  record: `plans/{JOB}-seam-fractional.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}`, on its branch `{BR}` (at `{HEAD}`; its `.lake/build` is the predecessor's green build of that commit): the merge of `main` (at `{MAIN}` or later) and its conflict resolutions; the module docstrings (only) of `Proofs/HadwigerNelson/RationalFour/Compulsion.lean` and `Proofs/HadwigerNelson/RationalFour/Forbid.lean`, as ruled; the gate's inputs by the gate's own rules (`scripts/Axioms.lean`, `scripts/axioms-controls.txt`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt`'s header, `Proofs.lean`, `ARCHITECTURE.md` rows); no proof or stored statement; `plans/{JOB}-seam-fractional.md`; your scripts and logs under `data/fs131/isf2/`; `data/fs131/reports/{JOB}.md`. Commit on your branch by explicit path; never push. A commit hook runs the privacy guard: if it refuses a commit, reword what it names and commit again, never `--no-verify`
  budget: about 250k by the harness's count, as guidance; save a stage after the merge and after the gate; hand back before about 350k

Hello. The mathematics here is done and checked by the build: the kernel holds that the fractional chromatic number of
the plane over ℚ(√3, √11) is 4, through a certificate it checks in full. What is left is making the gate hold on the tree
that will land, after another landing went in beside it.

## Why this job

The predecessor's hand-back and my ruling:

{I1092}
## Where the work stands

The landing that went in beside it, whose gate is your baseline, and my ruling on the two stale docstrings:

{I1089}
The predecessor's record is `{REC}`: its § 5.3, "What is left", lists every step of the gate, the scripts it prepared
(`data/fs131/isf1/lean/AxiomsAll.lean` over `data/fs131/isf1/modules.txt` for the `scripts/Axioms.lean` block; its
statement comparator `tools/fs131_isf1_statements.py`), and § 5.2 its drafts. Follow it.

## Done means

1. **Stage 1 — the readback.** Check the quotations above against their source; restate in your record what the merge
   must keep, the docstring edit, and the order of work.
2. **The merge and the edit.** `git merge main` into `{BR}`; every conflict in a gate input resolved by keeping both sides'
   entries; `main`'s build files copied in only for modules that are `main`'s and not this branch's (the main tree's build
   is current for `main`); the docstring edit in both modules — "prior art: pending `[KubickiLehelMorayne2002]`" →
   "prior art: not found in print (FS131-PAS2, FS131-PAS3; `CLOSED-QUESTIONS.md` § 3)" — and nothing else in them; the build
   green under the slot; a saved stage.
3. **The gate on one commit**: the steps of `data/fs131/clone1/run-gate.sh` (copied under `data/fs131/isf2/`, its logs
   there); every count change explained against `main`'s last gate (`/home/kooshi/source/lean-dir/data/fs131/irf1/gate/` in the main tree; in yours after the merge); the statement comparison
   against the predecessor's dump (its `SeamFractional` and `G27` statements unchanged) and against `main`'s `RationalFour`
   statements (unchanged: the edit is docstrings only); the vacuity scan's new sites with each structure hypothesis's
   inhabitant named (`LEAN.md` § The gate); `#print axioms` of every head statement (expected: the standard three, no
   outside theorem). A saved stage.
4. **The drafts' counts**: the predecessor's front-page drafts (its record § 5.2) and the count lines for `CLAUDE.md`
   (§ The gate, § Trust ledger, "Last filed"), restated in your record with this gate's counts, each naming its slot; for
   C14's novelty line, FS131-PAS2's line as the predecessor quoted it.
5. **The report**, in the standing rules' form.

## What is yours to decide

How you resolve each gate-input conflict, as long as every landing's entries stand. Not yours: any proof or stored
statement. {NOSPAWN}

## The machine

The laptop: 12 cores, 31 GB; no other job builds. From inside your worktree:
`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 16 --cpus 10 -- env MEMMAX=16G BATCH=4 ./scripts/build.sh`;
never `lake build`. The generated `G27` modules need up to about 5 GB each. On exit 75 wait ten minutes and retry. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Keep every working file under
`data/fs131/isf2/` (standing rule 2). Nothing with a `sorry` reaches `main`.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-seam-fractional.md"
open(out,"w").write(b); print(out)
