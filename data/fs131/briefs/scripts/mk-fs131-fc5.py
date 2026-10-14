exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-FC5: the Clerk files the front-page drafts of the density equality's landing (FS133-LD1), verbatim, on its own branch.
# Usage: mk-fs131-fc5.py <item of LD1's hand-back and merge>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KH=int(sys.argv[1])
TREE="fs133-wk1"; BR="fs131-f5"; JOB="FS131-FC5"; REC="plans/FS133-LD1-landing.md"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",W,"branch","--show-current")==BR and sh("git","-C",W,"status","--porcelain")==""
assert sh("git","-C",W,"rev-parse","HEAD")==sh("git","-C",ROOT,"rev-parse","main")
for p in (REC,"data/fs133/ld1/drafts-slots.py","data/fs131/fc4/file_fs131_lp1.py",
          "data/fs133/ld1/gate/receipt-axioms-final.log","data/fs131/lp1/gate/receipt-axioms-final.log"): assert os.path.exists(ROOT+p),p
NS=sum(1 for l in open(ROOT+"data/fs133/ld1/drafts-slots.out") if l.startswith("ok    1"))
b=f'''# Brief {JOB} — file the front-page drafts of a landing that is already on `main`, verbatim, and run the checks that read the front page

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; here you are the coordinator's pen for one filing
  role: the pen for one filing — the density equality's Lean module landed on `main` just now, closing its milestone, and the front page shows the counts and the milestone's state from before it; you put the landing agent's drafts into their slots word for word, run the checks that compare the front page with the gate's receipts, and report every place where you would have had to choose
  launch: now, in a tree of your own; three other jobs work in other trees and write no file you write; the next landing will quote the front page as it stands after yours
  mission: § Why this job
  statements: § What is filed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a draft's slot is not found exactly once, if two drafts touch the same words, or if a check fails in a way no draft explains; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `data/fs131/reports/{JOB}.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{BR}`, cut from `main` just now; the tree holds a compiled library you do not need and must not touch; no build is run): the files the drafts name — whichever of `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `ARCHITECTURE.md`, `plans/FRONTIER-STUBS.md`, `plans/STUB-one-class-transfer.md` and `tools/claude_md_fact_audit.py` they name — and nothing else of the front files; your own script and outputs under `data/fs131/fc5/`; `data/fs131/reports/{JOB}.md`. Commit on your branch by explicit path; the coordinator merges it
  budget: about 200k by the harness's count, as guidance; save a stage (a commit) after the slots are checked, after the drafts are in, and after the checks; hand back at a saved stage if you pass about 300k

Hello. Four filings like this one were done on this machine in the last two days; the last clerk guessed at nothing,
filed 24 drafts, and raised two lost tokens I then ruled on. This is the same job for the landing that followed.

## Why this job

The density equality landed on `main` just now through the full gate: the largest density of a planar set with no two
points at distance one is the same measured in the plane, in the algebraic plane and over finite point sets, and the
plane's fractional chromatic number is one over it — on the standard three axioms, with no hypothesis. With it its
milestone (FS-133, the one-class transfer) is Closed. Its landing agent wrote {NS} drafts for the front page, each with
the exact words it replaces or follows. Until they are filed the front page (`CLAUDE.md`) shows 9,024 records and the
milestone as Derived.

The drafts are a lane's words and go in verbatim: I coordinate and do not author, and you are my pen. Where you would
otherwise have to guess, write a `CHECK:` line and do not guess.

## What is filed

The landing's hand-back and its merge, as I logged them, with my receipts:

{item(KH)}
**The drafts** are in `{REC}`, section "Drafts for the front page (FS133-LD1)" (to the heading "Open gate items at
this landing"). Each names its file, its section and the exact words on
`main` it replaces or follows. The landing agent's checker of those slots is `data/fs133/ld1/drafts-slots.py`.

**My choices where a draft leaves one to the coordinator** (file what the drafts say; use these only where a draft
offers alternatives or says "the coordinator's"):

1. Whose it is, exactly as the drafts say it: the statement is not new (`[Davies2026]` proves it in dimension four and
   up and names the plane as its aim); the kernel proof is this project's; the residual Fourier step is the outside
   release's (`[OAIMath2026]`), its proof ported. Nothing here moves a value.
2. The milestone FS-133 moves from Derived to Closed wherever the drafts say so; nothing else changes state.
3. The proof atlas is not touched by this job (one rebuild at the publication pass).

## Done means

1. **Slots first** (a saved stage): run `python3 data/fs133/ld1/drafts-slots.py main` in your tree; every slot found
   exactly once and the control absent, or you stop and message me with the slot that failed.
2. **The drafts in, by a script** (`data/fs131/fc5/file_fs133_ld1.py`; the pattern is the last filing's
   `data/fs131/fc4/file_fs131_lp1.py`): it asserts every slot before it writes anything, replaces or inserts each
   draft's quoted text exactly (the lines under `>` in the record, joined as the target file wraps its lines; nothing
   reworded, nothing added), and prints what it did per draft. A draft that says counts "stand" changes nothing and
   is reported as such. (A saved stage.)
3. **The checks that read the front page**, each with its full output kept under `data/fs131/fc5/`:
   - the three digests of this landing's receipts against the previous landing's:
     `python3 scripts/gate_report.py axioms data/fs133/ld1/gate/receipt-axioms-final.log data/fs131/lp1/gate/receipt-axioms-final.log CLAUDE.md`,
     the same with `vacuity` and `scripts/vacuity-baseline.txt` before `CLAUDE.md`, and with `assumptions` and
     `scripts/assumptions-ledger.txt` before `CLAUDE.md`;
   - `python3 tools/claude_md_fact_audit.py --base 684d5fe5e` and the same tool with `--dupes`. **A token the audit
     reports lost is not allow-listed by you**: list it as a `CHECK:` with where it was and what replaced it;
   - `python3 tools/bib_audit.py`;
   - the size budgets the fact audit enforces (`CLAUDE.md` under 80,000 bytes).
4. **The report** (`data/fs131/reports/{JOB}.md`, and the same text as your hand-back): per draft — filed, or
   "stands", or `CHECK:` with the reason; each check's last lines; every `CHECK:`; the commits on your branch.

## What is yours to decide

How the script is written; the order of the drafts; how to join a draft's lines to the target file's wrapping.
Nothing about the words: if a draft looks wrong to you — a count that does not match the receipt it cites, a
sentence that contradicts the record's own table — file nothing for that draft and say what you saw.

## The machine

This session is on the laptop, away from the remote: **commit on your branch and do not push**. No Lean build
is part of this job; do not start one, and do not touch the tree's `.lake` folder. `/tmp` is wiped at power-off: keep
what the report cites under `data/fs131/fc5/`.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-filing.md","w").write(b); print("ok",len(b))
