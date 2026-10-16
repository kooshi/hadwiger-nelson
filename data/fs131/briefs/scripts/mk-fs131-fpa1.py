exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-FPA1: the Clerk files FS131-PAS1's drafts that item 1052 rules for filing now, verbatim.
# Usage: mk-fs131-fpa1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-FPA1"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",W,"branch","--show-current")==BR
assert subprocess.run(["git","-C",W,"merge-base","--is-ancestor","main","HEAD"]).returncode==0
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
REC="plans/FS131-PAS1-prior-art.md"
for p in (REC,"LEDGER.md","README.md","RESULTS.md","CLOSED-QUESTIONS.md","BIBLIOGRAPHY.md","plans/FS100-derivation.md","tools/bib_audit.py"):
    assert os.path.exists(W+p),p
I1052=item(1052)
b=f'''# Brief {JOB} — file the prior-art job's drafts that are ruled for filing now, verbatim

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; you file drafts verbatim and decide nothing
  role: Keryx's pen for one filing: the prior-art job's drafts listed below, each at the slot it names, word for word
  launch: now, in a worktree with no Lean build, on a branch cut from `main`; beside you two implementers in other worktrees, writing none of your files
  mission: § Why this job
  statements: § Why this job
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a draft's slot text does not occur exactly once, or a draft is unclear; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published)
  record: `data/fs131/reports/{JOB}.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{BR}` at `{HEAD}`; no Lean build): `LEDGER.md` (row 79 only), `README.md`, `RESULTS.md`, `CLOSED-QUESTIONS.md`, `BIBLIOGRAPHY.md`, `plans/FS100-derivation.md` (one erratum entry under FS100-CLS); your script under `data/fs131/fpa1/`; `data/fs131/reports/{JOB}.md`. Commit on your branch by explicit path; I merge it; never push. A commit hook runs the privacy guard: if it refuses a commit, reword nothing — message me with the file and rule
  budget: about 120k by the harness's count, as guidance; hand back before about 200k

Hello. A prior-art search job finished today, and its record drafts the lines that bring the front files up to what it
found. You file the ones that are ruled for now, exactly as written.

## Why this job

My ruling on which drafts are filed now and which wait:

{I1052}
## What to file, all in `{REC}`

File these, verbatim, each at the slot it names:
- **§ 2.4, items 1–5** (all of it): `LEDGER.md` row 79; `README.md`'s three-colour section, its Prior art bullet; `RESULTS.md`
  § 10, its Whose bullet; `CLOSED-QUESTIONS.md` § 2.4; and its `BIBLIOGRAPHY.md` updates and new rows.
- **§ 3.4, item 4** — the `BIBLIOGRAPHY.md` items only.
- **§ 4.4, item 2** (the erratum entry under FS100-CLS in `plans/FS100-derivation.md`, the original text left standing) and
  **item 4** (`BIBLIOGRAPHY.md`).
- **§ 5.4, item 3** — `BIBLIOGRAPHY.md`.
- **§ 6.4, item 3** — `BIBLIOGRAPHY.md`.

Do **not** file § 3.4 items 1–3, § 4.4 items 1 and 3, § 5.4 items 1–2 or § 6.4 items 1–2: they wait for the landings that
rewrite those rows. If a filed item mentions one of them, file it as written and name the mention in your report.

The README and `RESULTS.md` changed since the drafts were written for the three-colour section: its Prior art bullet now
ends "for the wider class the Lean proof covers, prior art not yet searched." and `RESULTS.md` § 10's Whose bullet ends "the
wider class the kernel proves: prior art not yet searched. The kernel proof is this project's." — the drafts' slot texts.
Where a slot text differs from the file by line wrapping only, match ignoring whitespace; where it differs in words, stop
and message me.

## Done means

1. **The script** (`data/fs131/fpa1/file.py`): each draft's slot found exactly once (whitespace-insensitive), the
   replacement or insertion made, and a plant — one slot text changed by a character — seen to fail before the real run.
2. **The checks after filing:** `python3 tools/bib_audit.py` (every cited key resolves; read its last line); every
   new `BIBLIOGRAPHY.md` row's library path exists (`ls`); the guard runs through the commit hook.
3. **The report**, in the standing rules' form: each item filed with its slot and its file's line number after filing; any
   slot that did not match and what you did; the checks' outputs.

## What is yours to decide

Nothing beyond how the script finds each slot. Do not reword, merge, shorten or reorder a draft.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-filing.md"
open(out,"w").write(b); print(out)
