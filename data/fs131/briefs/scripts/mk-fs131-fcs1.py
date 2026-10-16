exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-FCS1: the Clerk files the five-colour landing's drafts and the prior-art verdict held for it (item 1057).
# Usage: mk-fs131-fcs1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-FCS1"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",W,"branch","--show-current")==BR
assert subprocess.run(["git","-C",W,"merge-base","--is-ancestor","main","HEAD"]).returncode==0
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
REC="plans/FS131-ICS1-class.md"; PAS="plans/FS131-PAS1-prior-art.md"
for p in (REC,PAS,"CLAUDE.md","LEDGER.md","ROADMAP.md","LEAN.md","ARCHITECTURE.md","CLOSED-QUESTIONS.md","plans/KERNEL-HOLDS.md","plans/FILINGS.md",
          "tools/claude_md_fact_audit.py","tools/check_architecture.py"):
    assert os.path.exists(W+p),p
I1057=item(1057); I1055=item(1055)
b=f'''# Brief {JOB} — file the five-colour landing's drafts, with the prior-art verdict held for it

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
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{BR}` at `{HEAD}`; no Lean build): `CLAUDE.md`, `plans/KERNEL-HOLDS.md`, `plans/FILINGS.md`, `LEDGER.md` (row 123 only), `ROADMAP.md`, `LEAN.md`, `ARCHITECTURE.md` (the `Rigidity/ClassRatio` row only), `CLOSED-QUESTIONS.md`; your script under `data/fs131/fcs1/`; `data/fs131/reports/{JOB}.md`. Commit on your branch by explicit path; I merge it; never push. A commit hook runs the privacy guard: if it refuses a commit, reword nothing — message me with the file and rule
  budget: about 150k by the harness's count, as guidance; hand back before about 250k

Hello. The five-colour fields landed on `main` an hour ago; this filing brings the front files to what the kernel now
holds.

## Why this job

The landing:

{I1055}
My ruling on what you file, what you substitute and what you hold:

{I1057}
## What to file

From `{REC}` § Drafts for the front page: **D1, D2, D3, D4, D5, D6, D7, D8, D10, D12 and D14**, verbatim, each at the slot it
names, with exactly two substitutions inside the text you file (nowhere else):
- "prior art not yet searched" → "prior art not found in print as a classification (FS131-PAS1)"
- "statement not yet searched" → "statement not found in print as a classification (FS131-PAS1)"
Then from `{PAS}` § 4.4: **item 1** (row 123's prior-art field), verbatim, at its slot.

**D5** moves the current "Last filed" entry to the top of `plans/FILINGS.md` as that file's header says (its first entry
reads "before it **…**"): do the same. **Do not file** D9, D11 or D13.

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
