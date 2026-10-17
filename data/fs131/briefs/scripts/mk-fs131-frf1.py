exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-FRF1: the Clerk files rational four-space's drafts with the prior-art substitutions (item 1089).
# Usage: mk-fs131-frf1.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-FRF1"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",W,"branch","--show-current")==BR
assert subprocess.run(["git","-C",W,"merge-base","--is-ancestor","main","HEAD"]).returncode==0
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
REC="plans/FS131-IRF1-four-space.md"; PAS="plans/FS131-PAS3-kubicki-lehel-morayne.md"
for p in (REC,PAS,"CLAUDE.md","LEDGER.md","ROADMAP.md","LEAN.md","plans/KERNEL-HOLDS.md","plans/FILINGS.md",
          "CLOSED-QUESTIONS.md","BIBLIOGRAPHY.md",
          "tools/claude_md_fact_audit.py","tools/check_architecture.py"):
    assert os.path.exists(W+p),p
I1089=item(1089)
b=f'''# Brief {JOB} — file rational four-space's drafts, with its prior-art line

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; you file drafts verbatim and decide nothing
  role: Keryx's pen for the filing of a landing that is already merged: its drafts for the front files, each at the slot it names
  launch: now, in a worktree with no Lean build, on a branch cut from `main`; beside you one implementer in another worktree, writing none of your files
  mission: § Why this job
  statements: § Why this job
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a draft's slot text does not occur exactly once, or a draft is unclear; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published)
  record: `data/fs131/reports/{JOB}.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{BR}` at `{HEAD}`; no Lean build): `CLAUDE.md`, `plans/KERNEL-HOLDS.md`, `plans/FILINGS.md`, `LEDGER.md` (a new row 169), `CLOSED-QUESTIONS.md` (§ 3's `ℚ⁴` entry only), `BIBLIOGRAPHY.md` (the "what of ours rests on it" cells draft 8 names), `LEAN.md`; your script `data/fs131/fcs1/file-frf1.py` and its outputs beside it; `data/fs131/reports/{JOB}.md`. Commit on your branch by explicit path; I merge it; never push. A commit hook runs the privacy guard: if it refuses a commit, reword nothing — message me with the file and rule
  budget: about 150k by the harness's count, as guidance; hand back before about 250k

Hello. Rational four-space at four colours landed on `main` a few minutes ago; this filing brings the front files to
what the kernel now holds. The last filing of this kind (FS131-FRU1) is a good model: its script is `data/fs131/fcs1/file-fru1.py`.

## Why this job

The landing, with my rulings on what is filed, by whom, and where the new row goes:

{I1089}
## What to file

From `{REC}` § Drafts for the front page: **drafts 1, 2, 3, 4, 5, 6 and 8**, and its two `LEAN.md` lines (§ Searching —
Lean; the record's Stage 2 drafts them), verbatim, each at the slot it names. **Not draft 7** (the Proof Atlas) and not
draft 9 (applied on the branch already).

- **Substitutions, inside the filed text only:**
  - in draft 3 (the new ledger row), "**Prior art:** pending `[KubickiLehelMorayne2002]`." → "**Prior art:** " followed by
    the text of `{PAS}` § 3.4 item 5 (the novelty line) from "the answer to" to "The kernel proof is this project's." —
    verbatim, its outer quotation marks dropped;
  - anywhere else in the filed drafts, "pending `[KubickiLehelMorayne2002]`" → "not found in print (FS131-PAS2, FS131-PAS3)";
  - "its number Keryx's" or any placeholder for the row number → **169**.
- **Draft 3** is the new row **169**, as a new line directly after row 168 (the line beginning "| 168 |"), in the ledger's
  four columns (`#` | result | where | when), its last column "FS-131 (2026-10-17)".
- **Draft 6** replaces `CLAUDE.md`'s "Last filed" entry; the entry it replaces (the ring of unit vectors') goes, in full, to
  the top of `plans/FILINGS.md` in that file's own form, as FS131-FRU1 did for the density form's entry.
- **Do not** add a clause to `CLAUDE.md`'s "In short:" list, nor touch `README.md` or `RESULTS.md`: I write those.

Where a slot text differs from its file only by line wrapping, match ignoring whitespace; where it differs in words,
stop and message me.

## Done means

1. **The script** (`data/fs131/fcs1/file-frf1.py`): every slot found exactly once (whitespace-insensitive) before anything
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
