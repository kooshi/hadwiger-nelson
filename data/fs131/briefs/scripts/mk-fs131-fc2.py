exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-FC2: the Clerk files the front-page drafts of the first number-field module's landing, verbatim, on its own branch.
import subprocess,os
now=subprocess.run(["date","-u","+%Y-%m-%d %H:%M UTC"],capture_output=True,text=True).stdout.strip()
TREE="fs131-wnf"; BR="fs131-f2"; JOB="FS131-FC2"; INV="plans/FS131-close-inventory.md"; REC="plans/FS131-LU1-landing.md"
assert not os.path.exists(ROOT+f"data/fs131/briefs/{JOB}-filing.md")
b=f'''# Brief {JOB} — file the sixteen front-page drafts of a landing that is already on `main`, verbatim, and run the checks that read the front page

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; here you are the coordinator's pen for one filing
  role: the pen for one filing — a Lean module landed on `main` two hours ago and the front page shows the counts from before it; you put the landing agent's sixteen drafts into their slots word for word, run the checks that compare the front page with the gate's receipts, and report every place where you would have had to choose
  launch: now, in a tree of your own; two other jobs work in other trees and write no file you write; no landing is in flight, **and the next landing waits on this filing**, because its own drafts will quote the front page
  mission: § Why this job
  statements: § What is filed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a draft's slot is not found exactly once, if two drafts touch the same words, or if a check fails in a way no draft explains; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `data/fs131/reports/{JOB}.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{BR}`, cut from `main` just now; the tree holds a compiled library you do not need and must not touch; no build is run): the files the drafts name — `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `plans/FS131-KN1-number-field-kernel-map.md`, `data/fs131/claims-NF1.md`, `tools/claude_md_fact_audit.py` — and nothing else of the front files; your own script and outputs under `data/fs131/fc2/`; `data/fs131/reports/{JOB}.md`. Commit on your branch by explicit path; the coordinator merges it
  budget: about 150k by the harness's count, as guidance; save a stage (a commit) after the slots are checked, after the drafts are in, and after the checks; hand back at a saved stage if you pass about 250k

Hello. This morning a clerk filed the drafts of the day's first landing, guessed at nothing, and raised five checks
that were all real. This is the same job for the landing that followed.

## Why this job

Two hours ago a module landed on `main` through the full gate: every real number field's plane needs no more colours
than its residue targets, with four values closed by it — prior art in the kernel, none of it this project's
mathematics. Its landing agent wrote sixteen drafts for the front page, each with the exact words it replaces or
follows. Until they are filed the front page (`CLAUDE.md`) shows 7,454 records where the library has 7,506, and the
script that compares the front page with a gate's receipts reports it stale. The next landing — three and four
colours over number fields — is being joined now and waits on this, because its own drafts will quote the front page
as it stands after yours.

The drafts are a lane's words and go in verbatim: I coordinate and do not author, and you are my pen. Where you would
otherwise have to guess, write a `CHECK:` line and do not guess.

## What is filed

The landing as I logged it, with my receipt:

{Q(INV,"702. **FS131-LU1 handed back")}
**The sixteen drafts** are in `{REC}`, section "Drafts for the front page (FS131-LU1)" (from its line 629 to the
heading "Open gate items at this landing"). Each names its file, its section and the exact words on `main` it
replaces or follows. The landing agent's checker of those slots is `data/fs131/lu1/drafts-slots.py`; I ran it against
`main` just before writing this: "slots: 29 checked, 0 bad", the control absent.

**My choices where a draft leaves one to the coordinator** (file what the drafts say; use these only where a draft
offers alternatives or says "the coordinator's"):

1. Every homomorphism of a plane to a residue target is **into** it. Where the landing's draft for a ledger row
   differs from an earlier planner's draft of the same row, the landing's is the one filed.
2. Nothing of this landing is filed as this project's mathematics: the values and upper bounds are prior art, the
   kernel proofs are ours; a draft that says so already is filed as drafted.
3. The milestone this belongs to (the Lean backlog) changes no state by this filing.
4. No draft gives facts for the proof atlas; the atlas is not touched by this job.

## Done means

1. **Slots first** (a saved stage): run `python3 data/fs131/lu1/drafts-slots.py main` in your tree; every slot found
   exactly once and the control absent, or you stop and message me with the slot that failed.
2. **The drafts in, by a script** (`data/fs131/fc2/file_fs131_lu1.py`; the pattern is this morning's
   `data/fs131/fc1/file_fs131_lc1.py`): it asserts every slot before it writes anything, replaces or inserts each
   draft's quoted text exactly (the lines under `>` in the record, joined as the target file wraps its lines; nothing
   reworded, nothing added), and prints what it did per draft. A draft that says counts "stand" changes nothing and
   is reported as such. (A saved stage.)
3. **The checks that read the front page**, each with its full output kept under `data/fs131/fc2/`:
   - the three digests of this landing's receipts against the previous landing's:
     `python3 scripts/gate_report.py axioms data/fs131/lu1/gate/receipt-axioms-final.log data/fs131/lc1/gate/receipt-axioms-final.log CLAUDE.md`,
     the same with `vacuity` and `scripts/vacuity-baseline.txt` before `CLAUDE.md`, and with `assumptions` and
     `scripts/assumptions-ledger.txt` before `CLAUDE.md`;
   - `python3 tools/claude_md_fact_audit.py --base 147e38bc8` and the same tool with `--dupes`. **A token the audit
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
what the report cites under `data/fs131/fc2/`.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-filing.md","w").write(b); print("ok",len(b))
