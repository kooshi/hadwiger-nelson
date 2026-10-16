exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-FIF1: the Clerk files the density landing's drafts and the prior-art lines held for it (item 1064).
# Usage: mk-fs131-fif1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-FIF1"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",W,"branch","--show-current")==BR
assert subprocess.run(["git","-C",W,"merge-base","--is-ancestor","main","HEAD"]).returncode==0
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
REC="plans/FS131-IFR2-density.md"; PRE="plans/FS131-IFR1-density.md"; PAS="plans/FS131-PAS1-prior-art.md"
for p in (REC,PRE,PAS,"README.md","CLAUDE.md","LEDGER.md","ROADMAP.md","LEAN.md","ARCHITECTURE.md","CLOSED-QUESTIONS.md","plans/KERNEL-HOLDS.md","plans/FILINGS.md",
          "tools/claude_md_fact_audit.py","tools/check_architecture.py"):
    assert os.path.exists(W+p),p
I1063=item(1063); I1064=item(1064)
b=f'''# Brief {JOB} — file the density landing's drafts, with the prior-art lines held for it

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; you file drafts verbatim and decide nothing
  role: Keryx's pen for the filing of a landing that is already merged: its drafts for the front files, each at the slot it names
  launch: now, in a worktree with no Lean build, on a branch cut from `main`; beside you two implementers in other worktrees, writing none of your files
  mission: § Why this job
  statements: § Why this job
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a draft's slot text does not occur exactly once, or a draft is unclear; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published)
  record: `data/fs131/reports/{JOB}.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{BR}` at `{HEAD}`; no Lean build): `CLAUDE.md`, `plans/KERNEL-HOLDS.md`, `plans/FILINGS.md`, `LEDGER.md` (row 129 only), `README.md` (§ 5's Prior art bullet only), `CLOSED-QUESTIONS.md`; your script under `data/fs131/fcs1/`; `data/fs131/reports/{JOB}.md`. Commit on your branch by explicit path; I merge it; never push. A commit hook runs the privacy guard: if it refuses a commit, reword nothing — message me with the file and rule
  budget: about 150k by the harness's count, as guidance; hand back before about 250k

Hello. The density form of the collapse landed on `main` an hour ago; this filing brings the front files to what the
kernel now holds.

## Why this job

The landing, with my ruling on where its two extra results go:

{I1063}
My ruling on what you file and what you hold:

{I1064}
## What to file

From `{REC}` § Stage 4 (the drafts restated with this gate's counts): **D-1, D-2, D-3 and D-5**, verbatim, each at the slot it
names. **D-4 and D-6** say "unchanged from the predecessor's text and slot": file them from `{PRE}` § Drafts for the front
page, the predecessor's drafts of the same names, verbatim. Then from `{PAS}` § 3.4: **items 1, 2 and 3** (`README.md` § 5's
Prior art bullet, row 129's prior-art field, and the new `CLOSED-QUESTIONS.md` entry beside Soifer's 55.1), verbatim.

**D-5** moves the current "Last filed" entry to the top of `plans/FILINGS.md` as that file's header says (its first entry
reads "before it **…**"): do the same. **Do not file** D-7, D-8, D-9 or D-10.

Where a slot text differs from its file only by line wrapping, match ignoring whitespace; where it differs in words,
stop and message me.

## Done means

1. **The script** (`data/fs131/fcs1/file.py`): every slot found exactly once (whitespace-insensitive) before anything is
   written; a plant (one slot changed by a character) seen to fail first.
2. **The checks after filing:** `python3 tools/check_architecture.py` (its last line); the fact audit,
   `python3 tools/claude_md_fact_audit.py --base main --also .claude/skills/grokkings/SKILL.md plans/GROKKINGS-RETIRED.md RUNNING.md plans/CLAUDE-MD-HISTORY.md LEAN.md plans/WHERE-THE-PROBLEM-STANDS.md plans/HISTORY-WORKFLOW-3.0.md plans/KERNEL-HOLDS.md plans/FILINGS.md`
   — report every `FAIL` line; superseded counts replaced by the drafts' new counts are expected, anything else is a finding;
   `CLAUDE.md`'s size from the audit's `size:` line.
3. **The report**, in the standing rules' form: each item filed with its file and line after filing, each substitution
   made (where), any slot that did not match, and the checks' outputs.

## What is yours to decide

Nothing beyond how the script finds each slot. Do not reword, merge, shorten or reorder a draft.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-filing.md"
open(out,"w").write(b); print(out)
