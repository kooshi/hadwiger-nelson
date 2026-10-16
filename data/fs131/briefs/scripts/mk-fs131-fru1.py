exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-FRU1: the Clerk files the ring of unit vectors' drafts and the prior-art line held for it (item 1068).
# Usage: mk-fs131-fru1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-FRU1"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",W,"branch","--show-current")==BR
assert subprocess.run(["git","-C",W,"merge-base","--is-ancestor","main","HEAD"]).returncode==0
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
REC="plans/FS131-IRU2-ring.md"; PAS="plans/FS131-PAS1-prior-art.md"
for p in (REC,PAS,"CLAUDE.md","LEDGER.md","ROADMAP.md","LEAN.md","plans/KERNEL-HOLDS.md","plans/FILINGS.md",
          "plans/POROS-2026-10-13-number-field-findings.md","plans/FS131-KCS1-class-plan.md",
          "tools/claude_md_fact_audit.py","tools/check_architecture.py"):
    assert os.path.exists(W+p),p
I1068=item(1068)
b=f'''# Brief {JOB} — file the ring of unit vectors' drafts, with the prior-art line held for it

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; you file drafts verbatim and decide nothing
  role: Keryx's pen for the filing of a landing that is already merged: its drafts for the front files, each at the slot it names
  launch: now, in a worktree with no Lean build, on a branch cut from `main`; no other agent is running
  mission: § Why this job
  statements: § Why this job
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a draft's slot text does not occur exactly once, or a draft is unclear; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published)
  record: `data/fs131/reports/{JOB}.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{BR}` at `{HEAD}`; no Lean build): `CLAUDE.md`, `plans/KERNEL-HOLDS.md`, `plans/FILINGS.md`, `LEDGER.md` (rows 100 and 105, and a new row 168), `ROADMAP.md` (§ 3 only), `LEAN.md`, `plans/POROS-2026-10-13-number-field-findings.md` (§ 3.3 only), `plans/FS131-KCS1-class-plan.md` (§ 2.6's banner only); your script `data/fs131/fcs1/file-fru1.py` and its outputs beside it; `data/fs131/reports/{JOB}.md`. Commit on your branch by explicit path; I merge it; never push. A commit hook runs the privacy guard: if it refuses a commit, reword nothing — message me with the file and rule
  budget: about 150k by the harness's count, as guidance; hand back before about 250k

Hello. The ring of unit vectors landed on `main` a few minutes ago; this filing brings the front files to what the
kernel now holds. The last filing of this kind (FS131-FIF1) is a good model: its script is `data/fs131/fcs1/file-fif1.py`.

## Why this job

The landing, with my rulings on what is filed, by whom, and where the new row goes:

{I1068}
## What to file

From `{REC}` § Stage 4 — SAVED: the drafts' counts (§ Drafts for the front page, and the `LEAN.md` § Building draft after
it): **D1, D2, D3, D4, D5, D6, D8, D9, D10, D11, and the `LEAN.md` § Building line**, verbatim, each at the slot it names.
Then from `{PAS}` § 5.4: **item 1**, verbatim, in row 100's **Prior art** field, as D3's last bullet says.

- **Substitutions, inside the filed text only:** "<landing>" → "FS131-IRU1" (in D3 and D4); and in D5, "| FS-131 |" at the
  row's end → "| FS-131 (2026-10-16) |", the ledger's form for its last column.
- **D5** is the new row **168**: its text without the outer quotation marks, prefixed by "| 168 | ", as a new line directly
  after row 167 (the line beginning "| 167 |"), before the blank line and § B.
- **D8** has two halves. The first replaces `CLAUDE.md`'s "Last filed" entry as drafted; the entry it replaces (the density
  form's, from "**the density form of the collapse** (FS131-KFR1, FS131-IFR1, FS131-IFR2, 2026-10-16:" to "no value of
  `χ(ℝ²)` moved.)") goes, in full, to the top of `plans/FILINGS.md` in that file's own form, as its header says and as
  FS131-FIF1 did for the five-colour entry. The second half is the insertion into `plans/KERNEL-HOLDS.md` after the slot it
  names. **Do not** add a clause to `CLAUDE.md`'s "In short:" list: I write that one.
- **Do not file** D7 (the Proof Atlas), FS131-PAS1's § 5.4 item 2 or § 6.4 item 2 (the public-page lines: I write those with
  the README row), or anything in `BIBLIOGRAPHY.md` (its rows are already filed).

Where a slot text differs from its file only by line wrapping, match ignoring whitespace; where it differs in words,
stop and message me.

## Done means

1. **The script** (`data/fs131/fcs1/file-fru1.py`): every slot found exactly once (whitespace-insensitive) before anything
   is written; a plant (one slot changed by a character) seen to fail first.
2. **The checks after filing:** `python3 tools/check_architecture.py` (its last line); the fact audit,
   `python3 tools/claude_md_fact_audit.py --base main --also .claude/skills/grokkings/SKILL.md plans/GROKKINGS-RETIRED.md RUNNING.md plans/CLAUDE-MD-HISTORY.md LEAN.md plans/WHERE-THE-PROBLEM-STANDS.md plans/HISTORY-WORKFLOW-3.0.md plans/KERNEL-HOLDS.md plans/FILINGS.md`
   — report every `FAIL` line; superseded counts replaced by the drafts' new counts are expected, anything else is a finding;
   `CLAUDE.md`'s size from the audit's `size:` line; and `--dupes` (its exit status).
3. **The report**, in the standing rules' form: each item filed with its file and line after filing, each substitution
   made (where), any slot that did not match, and the checks' outputs.

## What is yours to decide

Nothing beyond how the script finds each slot. Do not reword, merge, shorten or reorder a draft. Where you would have to
guess, write a `CHECK:` line in the report instead.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-filing.md"
open(out,"w").write(b); print(out)
