exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-FC10: the Clerk files FS131-ICO2's drafts D1–D13 (the collapse's landing) verbatim, with the fact audit's transition.
# Usage: mk-fs131-fc10.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-FC10"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",W,"branch","--show-current")==BR
assert sh("git","-C",W,"rev-parse","HEAD")==sh("git","-C",ROOT,"rev-parse","main")
MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main")
REC="plans/FS131-ICO2-collapse.md"
for p in (REC,"data/fs131/reports/FS131-ICO2.md","data/fs131/ico2/gate/digest-axioms.txt","data/fs131/ico2/gate/digest-vacuity.txt",
          "data/fs131/ico2/gate/digest-assumptions.txt","data/fs131/ico2/gate/receipt-axioms.log","tools/claude_md_fact_audit.py",
          "visualizations/proof-atlas/README.md","tools/check_architecture.py"): assert os.path.exists(W+p),p
I1004=item(1004)
PREV=Q("tools/claude_md_fact_audit.py",'    (("10650", "5"), ("10651", "5")): ')
TRANS='''    (("10651", "5"), ("10747", "5")): "FS-131, the collapse — the seven Collapse/ modules and the edits D-E1, D-E2 through the gate on one commit: χ(ℚ(√635087)²) = χ(ℝ²) (Collapse.chromaticNumber_planeOver_sqrt635087) and χ(ℚ(√3,√5,√7,√11)²) = χ(ℝ²) (Collapse.chromaticNumber_planeOver_deGrey), on Weil's bound and [EinsiedlerLindenstrauss2022] Thm 1.3, and χ(F²) = χ(ℝ²) at every real number field uniformly c-thick with c < 1/5 (Collapse.chromaticNumber_planeOver_eq_plane_of_thick) on Thm 1.3 alone; the derivation this project's, row 128 (FS131-KCL1, FS131-ICO1, FS131-ICO2; copy data/fs131/ico2/gate/receipt-axioms.log, gated commit 7c72b9bf7): 11,398 records, 10,747 clean, 569 axiom-free, 77 imported, 5 purchases",'''
b=f'''# Brief {JOB} — the collapse's filing: FS131-ICO2's thirteen drafts, word for word, and the audits

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; here you are the coordinator's pen for one filing
  role: the pen for the drafts a kernel implementer wrote when its module landed on `main` — thirteen drafts, each naming its slot, filed word for word by a script, then the audits
  launch: now, in a worktree with no Lean build, on a fresh branch cut from `main`; beside you two kernel implementers in other worktrees, writing none of these files
  mission: § Why this job
  statements: § What is filed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a slot is not found exactly once, or a check fails in a way no draft explains; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published)
  record: `data/fs131/reports/{JOB}.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{BR}`, cut from `main` at `{MAIN}`; no Lean build): `CLAUDE.md`, `LEDGER.md`, `README.md`, `ROADMAP.md`, `ARCHITECTURE.md` — each only at the slots the drafts name; `tools/claude_md_fact_audit.py` at its transition table only (one entry, given below); for D13, `tools/viz_proof_atlas_facts.py`, `data/viz/proof-atlas/facts.json` and the built `visualizations/proof-atlas/index.html`, by that folder's README; your scripts and outputs under `data/fs131/fc10/`; `data/fs131/reports/{JOB}.md`. Commit on your branch by explicit path; the coordinator merges it; never push; publish nothing
  budget: about 200k by the harness's count, as guidance; save a stage after the readback, after the filing, and after the checks; hand back at a saved stage before about 300k

Hello. A kernel module landed on `main` this afternoon: the statement that the plane over ℚ(√635087) needs exactly as
many colours as the whole plane, now proved with no hypothesis of ours. Its implementer drafted every front-page line the
landing changes. You put them in, exactly as drafted.

## Why this job

The repository is public, and its front page has to say what the kernel now holds. My log of the landing's gate:

{I1004}
The merge is `0f81fe2a3` on `main`; the implementer's record is `{REC}` and its report `data/fs131/reports/FS131-ICO2.md`.

## What is filed

1. **The drafts D1–D13** in `{REC}` § Drafts for the front page (D1–D8 `CLAUDE.md`, D9 `LEDGER.md` row 128, D10
   `README.md`, D11 `ROADMAP.md`, D12 `ARCHITECTURE.md` § 5, D13 the Proof Atlas). Each names its slot and the words it
   replaces or follows; the implementer checked each slot once in its tree, and `main` has changed since only in `plans/`
   and `data/`, so each should still be found exactly once.
2. **The audit's transition**, because the gate's audit counts move (item 991 of the inventory: last time the audit
   failed on its last line for want of this). The previous entry in `tools/claude_md_fact_audit.py`:

{PREV}
   Add this entry directly after it, exactly as written here (I wrote it; it is the coordinator's bookkeeping):

```
{TRANS}
```

3. **D13**: change node `R128`'s entries as the draft says, then rebuild by `visualizations/proof-atlas/README.md` (its
   checker re-reads the quotes from the filed ledger row, so file D9 first); commit the rebuilt page; publish nothing.

## Done means

1. **Stage 1 — the readback.** Check the two quotations above against their sources; list each draft with its slot as
   you find it on your branch (found once, or not).
2. **Stage 2 — the filing, by a script** (`data/fs131/fc10/file_ico2.py`): it asserts every slot exactly once before it
   writes anything, puts each draft's words in exactly, and prints what it did per draft; then the transition; then D13's
   rebuild. (A saved stage.)
3. **Stage 3 — the checks**, each output under `data/fs131/fc10/`:
   `python3 tools/claude_md_fact_audit.py --base 8cab63fa2` and `--base {MAIN}` (the last filing, and this `main`), each
   with its **last line** quoted in your report; the same with `--dupes`; `python3 tools/bib_audit.py`;
   `python3 tools/check_architecture.py`; `CLAUDE.md`'s size against its 80,000-byte budget; and a table of every count
   in `data/fs131/ico2/gate/digest-axioms.txt`, `data/fs131/ico2/gate/digest-vacuity.txt` and
   `data/fs131/ico2/gate/digest-assumptions.txt` against the same count
   as now written in `CLAUDE.md` § Trust ledger and § The gate, `scripts/vacuity-baseline.txt`'s header and
   `scripts/assumptions-ledger.txt`'s header (count, digest, filed, equal or not).
4. **The report**, in the standing rules' form: per draft filed or `CHECK:` with its reason; each check's last lines.

## What is yours to decide

How your script matches a slot and joins a draft to the file's wrapping. Where a draft would make a statement false
against the ledger or the kernel's print, two drafts touch the same words, `CLAUDE.md` goes over its budget, or the audit
reports a token lost, write a `CHECK:` and do not choose: never allow-list a lost token yourself.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-collapse-filing.md"
open(out,"w").write(b); print(out)
