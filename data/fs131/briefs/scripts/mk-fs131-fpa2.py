exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-FPA2: the Clerk files FS131-PAS2's drafts ruled for now (item 1080) and the owed bibliography pass (item 1054).
# Usage: mk-fs131-fpa2.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-FPA2"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",W,"branch","--show-current")==BR
assert subprocess.run(["git","-C",W,"merge-base","--is-ancestor","main","HEAD"]).returncode==0
HEAD=sh("git","-C",W,"rev-parse","--short=9","HEAD")
REC="plans/FS131-PAS2-prior-art.md"; PAS1="plans/FS131-PAS1-prior-art.md"
for p in (REC,PAS1,"BIBLIOGRAPHY.md","CLOSED-QUESTIONS.md","LEDGER.md","tools/bib_audit.py","plans/FS131-KRU1-ring-plan.md",
          "data/fs131/fpa1/file.py"):
    assert os.path.exists(W+p),p
I1080=item(1080); I1054=item(1054)
b=f'''# Brief {JOB} — file the prior-art job's drafts that are ruled for now, and the owed bibliography pass

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; you file drafts verbatim and decide nothing
  role: Keryx's pen for one filing — a prior-art job's drafts ruled for now, each at the slot it names, word for word — and a bibliography pass that files what the records already say
  launch: now, in a worktree with no Lean build, on a branch cut from `main`; beside you one kernel planner in another worktree, writing none of your files
  mission: § Why this job
  statements: § Why this job
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a draft's slot text does not occur exactly once, or a draft or a rule here is unclear; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published)
  record: `data/fs131/reports/{JOB}.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{BR}` at `{HEAD}`; no Lean build): `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md` (§ 1.6 only), `LEDGER.md` (row 71 only); your script `data/fs131/fpa2/file.py` and its outputs beside it; `data/fs131/reports/{JOB}.md`. Commit on your branch by explicit path; I merge it; never push. A commit hook runs the privacy guard: if it refuses a commit, reword nothing — message me with the file and rule
  budget: about 150k by the harness's count, as guidance; hand back before about 250k

Hello. A prior-art search finished an hour ago and drafted the lines that bring the bibliography and two entries up to
what it read. You file the ones ruled for now, exactly as written, and close a small bibliography debt from yesterday.
The last filing of this kind (FS131-FPA1) is a good model: its script is `data/fs131/fpa1/file.py`.

## Why this job

The search's hand-back and my ruling on what is filed now and what waits:

{I1080}
The bibliography debt it names, from yesterday's filing:

{I1054}
## What to file

**Part 1 — the search's drafts, verbatim**, all in `{REC}`:
- **§ 4.4, items 1, 2 and 3**: `CLOSED-QUESTIONS.md` § 1.6 (the insertion after its last sentence), `LEDGER.md` row 71 (the
  insertion after the words it names), and the `BIBLIOGRAPHY.md` lines (three status-cell appends and one § C listing row).
- **§ 2.4, item 4**: the `BIBLIOGRAPHY.md` rows and status lines (the same in both of its forms).
- **Do not file** § 2.4 items 1, 2 or 3, § 4.4's "C14's novelty line", or anything in § 3.2 (filed already).

**Part 2 — the bibliography pass.** Each line below is my ruling; file what the named record already says, no more.
1. **`[Davidson2026]`**: check its copy path against the library (`ls ~/source/library/pdf/ | grep -i davidson`); if the
   row's path is wrong or missing, write the file's path; if no file is held, say so in a `CHECK:` line.
2. **`[deGrey2026]` and `[Haugstrup2026]`** (rows 8 and 9 of § R.4, the paywall list): the issue is held, so each moves to
   § A. Write each § A row in § A's columns (key | work | what of ours rests on it | copy | read) from the § R.4 row's own
   cells: the citation as the work; for "what of ours rests on it", the `CLOSED-QUESTIONS.md` entry and the README § 5 line
   that cite it (find them by `grep`); the copy, the held file's path (`ls`); the read status, the § R.4 row's status cell.
   Append both at the end of § A's table, then delete the two § R.4 rows (do not renumber the others).
3. **`[Shimura1964]`**: it has two rows, § R.4 #17 (a request) and § A (the citation). Keep both, so that the request
   stays visible; in the § R.4 row, write the key as a plain reference (`` `[Shimura1964]` ``, not bold), so that the § A row is
   the key's one definition. If `BIBLIOGRAPHY.md` § D gives a different rule for a key both requested and cited, follow § D
   and say so.
4. **§ B rows for newly held files**: for every file in `~/source/library/pdf/` modified on or after 2026-10-16
   (`find -newermt 2026-10-16`) that has no § B row, add one in § B's form (path | key | read status), the key and status taken from
   its § A or § C row; a file with no row anywhere goes in a `CHECK:` line, not into the table.
5. **The keys and arXiv ids `tools/bib_audit.py` lists as unlogged**: for each, a row from what the citing record says
   about it — an arXiv id cited in `{PAS1}` or `{REC}` gets a § C listing row (its title and the record's verdict, by that
   record's words); `[Neukirch1999]`, cited in `plans/FS131-KRU1-ring-plan.md`, gets a § A row with what the plan uses it for
   and "not held; cited by the planner, not read here"; arXiv:2602.17943 gets a § C row with FS131-PAS2's verdict
   (Istrate–Zara, no bearing). Any id or key whose record says nothing you could file: a `CHECK:` line.

Where a slot text differs from its file only by line wrapping, match ignoring whitespace; where it differs in words,
stop and message me.

## Done means

1. **The script** (`data/fs131/fpa2/file.py`): every part-1 slot found exactly once (whitespace-insensitive) before
   anything is written; a plant (one slot changed by a character) seen to fail first.
2. **The checks after filing:** `python3 tools/bib_audit.py` (every cited key resolves; read its last line — the goal is
   no unlogged prior art); every new row's library path exists (`ls`).
3. **The report**, in the standing rules' form: each item filed with its file and line after filing; each part-2 ruling
   carried out, with what you wrote; any slot that did not match; the checks' outputs.

## What is yours to decide

Nothing beyond how the script finds each slot and where in a table a row goes when this brief does not say. Do not
reword, merge, shorten or reorder a draft. Where you would have to guess, write a `CHECK:` line instead.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-filing.md"
open(out,"w").write(b); print(out)
