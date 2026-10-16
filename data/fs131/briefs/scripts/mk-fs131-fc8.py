exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-FC8: the Clerk as the coordinator's pen for the second filing — locate every owed front-page draft, file the
# ready ones verbatim, and table the rest. Usage: mk-fs131-fc8.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-FC8"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",W,"branch","--show-current")==BR
assert sh("git","-C",W,"rev-parse","HEAD")==sh("git","-C",ROOT,"rev-parse","main")
MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main")
BASE=sh("git","-C",ROOT,"log","-1","--format=%h","--fixed-strings","--grep","FS-131: the five-colour chain's front page filed (FS131-FC7, branch fs131-f7)")
assert BASE
for p in ("data/fs131/filing2/pr1-drafts.md","plans/FS131-ER1-davies-reading.md","plans/FS131-EN1-derivation.md",
          "tools/claude_md_fact_audit.py","tools/bib_audit.py","data/fs131/fc6/file_fs131_ldb1.py",
          "plans/SESSION-HANDOFF-2026-10-13.md","plans/SESSION-HANDOFF-2026-10-14.md","plans/SESSION-HANDOFF-2026-10-15.md"): assert os.path.exists(W+p),p
def block(path,first,last,heading):
    ls=open(ROOT+path).read().split("\n")[first-1:last]
    assert all(l.strip() for l in ls),(path,first,last)
    return "".join("> "+l+"\n" for l in ls)+"> — source: "+path+" § "+heading+"\n"
L16=block("plans/SESSION-HANDOFF-2026-10-16.md",47,48,"4. Next, in order")
L15=block("plans/SESSION-HANDOFF-2026-10-15.md",73,82,"6. Owed, in the new working copy")
L14=block("plans/SESSION-HANDOFF-2026-10-14.md",83,90,"6. Owed, not done")
L13=block("plans/SESSION-HANDOFF-2026-10-13.md",113,119,"7. Owed, not done")
assert L16.startswith("> 3. **The second filing**") and L15.startswith("> - `LEDGER.md` notes") and L14.startswith("> - **The second filing**") and L13.startswith("> - **One filing by the Clerk")
I948=item(948); I951=item(951)
b=f'''# Brief {JOB} — the second filing: find every front-page draft the last two weeks left unfiled, file the ready ones word for word, and table the rest

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; here you are the coordinator's pen for one filing, and before it its finder
  role: the finder and pen for one filing — four lists of corrections and drafts owed to the front files (`CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `ARCHITECTURE.md`, and a few stubs) were written across four handoffs; you find, for each item, whether it is already filed, where its drafted words are, and whether their slot is on `main` exactly once; you file the ready ones word for word, and table every other one for my ruling
  launch: now, in a worktree of your own; beside you a kernel planner works in another worktree and writes none of these files
  mission: § Why this job
  statements: § What is owed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage when stage 2's table is committed, and at once if a check fails in a way no draft explains; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (rules 6 and 13 changed today: never push; everything committed may be published)
  record: `data/fs131/reports/{JOB}.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{BR}`, cut from `main` at `{MAIN}`; no Lean build, no `.lake`): the files the ready drafts name — of `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `BIBLIOGRAPHY.md`, `ARCHITECTURE.md`, `CLOSED-QUESTIONS.md`, `plans/FRONTIER-STUBS.md` and the `plans/STUB-*.md` files — and nothing else of the front files; never a file under `Proofs/` or `scripts/`; your table, scripts and outputs under `data/fs131/fc8/`; `data/fs131/reports/{JOB}.md`. Commit on your branch by explicit path; the coordinator merges it; never push
  budget: about 250k by the harness's count, as guidance; save a stage (a commit) after each stage below; hand back at a saved stage before about 350k

Hello. Seven filings like this have been done here; the clerks who did them guessed at nothing and wrote `CHECK:` where
they would have had to, and every one of those lines was ruled on. This one is larger and older: its items were
written down across four days, and some may already be done.

## Why this job

The repository went public this morning (`https://github.com/kooshi/hadwiger-nelson`). Its front page and ledger still
carry a few statements that the records already correct — one undersells a result of ours as "not new" where the
reading says its plane case is not in print, one row's "Not claimed" still lists a kernel proof the kernel now holds —
and a backlog of `LEAN.md` lines and bibliography lines the lanes drafted and nobody filed. Those drafts are the lanes'
words and go in verbatim: I coordinate and do not author, and you are my pen. Where you would have to guess, write a
`CHECK:` line and do not guess.

## What is owed

The newest list, which names the next older one:

{L16}
That older list (the 2026-10-15 handoff's "second filing"):

{L15}
It names the 2026-10-14 handoff's list, whose first bullet is:

{L14}
which in turn names the 2026-10-13 handoff's § 7, whose first bullet is:

{L13}
The README job's drafts D1–D8 are copied, unchanged, into `data/fs131/filing2/pr1-drafts.md` (its record is not in this
repository's history; the copy's header says where it came from). The two inventory items that bear on them:

{I948}
{I951}
Other drafts named above are in this repository: `plans/FS131-ER1-davies-reading.md` § 9.2 (the `[Davies2026]` cell
and rows 121, 123, 128, 129's prior-art lines); each job record the 2026-10-14 bullet names (`plans/FS131-<job>-*.md`,
their sections that draft `LEAN.md` or `BIBLIOGRAPHY.md` lines); `plans/FS131-EN1-derivation.md` (EN1-UQ4); the
inventory items each list cites (`plans/FS131-close-inventory.md`, one numbered line each). An item's later filing may
be recorded in a later inventory item or in a commit (`git log -S'<distinctive words>' -- <file>` finds when words
entered a file).

## Done means

1. **Stage 1 — the readback.** Check each quotation above against its source; restate in your report, in a short
   list, the four lists' items as you read them, and log any mismatch.
2. **Stage 2 — the table** (`data/fs131/fc8/owed.md`), one row per owed item, every item of all four lists and each
   of D1–D8 and § 9.2's drafts its own row: the item in a few words; its source (list and item number); its draft's
   address (file, section or line) or "no draft found"; its slot on `main` (the file and the exact words it replaces or
   follows) and how many times those words occur; and one status of four — **filed** (where and, if you can find it,
   by which commit), **ready** (a draft found and its slot found exactly once), **CHECK** (a draft found but its slot
   not found exactly once, or two drafts touch the same words, or the draft offers a choice — say which), or **no
   draft** (a list names a correction but no lane drafted its words — say what the list says is wrong and quote what
   the file says now). Commit; message me the counts of each status. Then go straight on to stage 3 with the
   **ready** rows; I rule on the others from the table.
3. **Stage 3 — the ready drafts in, by a script** (`data/fs131/fc8/file_owed.py`; the pattern is
   `data/fs131/fc6/file_fs131_ldb1.py`): it asserts every slot before it writes anything, puts each draft's text in
   exactly (nothing reworded, nothing added; joined as the target file wraps its lines), and prints what it did per
   row. A draft whose slot moved between your table and the script is skipped and becomes a `CHECK:`. (A saved stage.)
4. **Stage 4 — the checks**, each with its full output under `data/fs131/fc8/`:
   - `python3 tools/claude_md_fact_audit.py --base {MAIN}` (nothing lost by this filing) and the same with
     `--base {BASE}` (the last filing; tokens it reports lost that this filing did not touch are listed, not acted on),
     and with `--dupes`. **A token reported lost is never allow-listed by you**: list it as a `CHECK:` with where it was
     and what replaced it;
   - `python3 tools/bib_audit.py`;
   - the size budgets the fact audit enforces (`CLAUDE.md` under 80,000 bytes — it is at 79,235 now, so the
     `CLAUDE.md` drafts may not all fit: if one would cross the line, file nothing more in `CLAUDE.md` and write a
     `CHECK:` with the byte count, because the move that meets a budget is mine to rule).
5. **The report** (`data/fs131/reports/{JOB}.md`, and the same text as your hand-back), in the standing rules' form:
   the table's counts, per filed row what it did, each check's last lines, every `CHECK:`, the commits on your branch.

## What is yours to decide

How you search, the table's layout beyond the columns above, and how your script matches a slot. Where a draft in one
list is superseded by a later one for the same words, the later one is ready and the earlier is filed-by-supersession;
say so in the row. If an item looks wrong to you — a draft that would make a statement false against the ledger or the
kernel's print — mark it `CHECK:` and say why: a wrong draft reported is a finding. **My choices where a draft leaves
one to the coordinator:**

1. D7 (row 120's grade) is filed as its proposal reads.
2. D5 means `plans/FS131-ER1-davies-reading.md` § 9.2's drafts as written.
3. Whose a result is, exactly as the drafts say it: "prior art: not found in print" for ours; never "new" or "first",
   and never "not new" for a result of ours.
4. No milestone changes state in this filing, and the Proof Atlas is not touched.
5. Rows that need a lane's words that nobody drafted (prices to correct, predictions to score, a grade to restate) are
   **no draft**, never written by you.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-second-filing.md"
open(out,"w").write(b); print(out)
