exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-FC9: a successor Clerk files what FS131-FC8 left: Amendment 1's rows and the bibliography appends.
# Usage: mk-fs131-fc9.py <tree> <branch>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR=sys.argv[1],sys.argv[2]; JOB="FS131-FC9"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",W,"branch","--show-current")==BR
assert sh("git","-C",W,"rev-parse","HEAD")==sh("git","-C",ROOT,"rev-parse","main")
MAIN=sh("git","-C",ROOT,"rev-parse","--short=9","main")
for p in ("data/fs131/fc8/owed.md","data/fs131/fc8/rows.py","data/fs131/fc8/file_owed.py","data/fs131/reports/FS131-FC8.md",
          "data/fs131/briefs/FS131-FC8-second-filing.md"): assert os.path.exists(W+p),p
I983=item(983)
b=f'''# Brief {JOB} — the rest of the second filing: the rows the last clerk's budget left, by my rulings

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; here you are the coordinator's pen for the rest of one filing
  role: the pen for the rows of the second filing that the previous clerk located but did not file — a short list, each with its draft found and my ruling on where it goes
  launch: now, in the worktree the previous clerk used, on a fresh branch; beside you two kernel planners in other worktrees, writing none of these files
  mission: § Why this job
  statements: § What is filed
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if a slot is not found exactly once or a check fails in a way no draft explains; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published)
  record: `data/fs131/reports/{JOB}.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{BR}`, cut from `main` at `{MAIN}`; no Lean build): `BIBLIOGRAPHY.md`, `LEAN.md`, `ARCHITECTURE.md`, `plans/FS84-SI-D-derivation.md`, `plans/FS100-derivation.md`, `plans/FS136-derivation.md` — each only at the rows named below; your scripts and outputs under `data/fs131/fc9/`; `data/fs131/reports/{JOB}.md`. Commit on your branch by explicit path; the coordinator merges it; never push
  budget: about 150k by the harness's count, as guidance; save a stage after the readback, after the filing, and after the checks; hand back at a saved stage before about 250k

Hello. The clerk before you built a table of 109 owed items and filed 53 of them word for word before its budget ran
out; I merged its work. What is left is small and every row of it is already located. You finish it.

## Why this job

The repository is public, and its front files should carry what the lanes drafted. The previous job is logged as item 983
of the inventory, quoted in the next section.

## What is filed

The previous job, as I logged it:

{I983}
The table is `data/fs131/fc8/owed.md` (each row's id, draft address and slot), built by `data/fs131/fc8/rows.py`; the
previous clerk's filing script is `data/fs131/fc8/file_owed.py`, and its report `data/fs131/reports/FS131-FC8.md`. My
rulings are the section "Amendment 1" at the end of `data/fs131/briefs/FS131-FC8-second-filing.md`: read it in full;
it is part of this brief. The rows to file, by the table's ids:

1. The amendment's "File" list: **AXIOMS-ARCH** (probe first, then file or report it filed), **LEAN-KN7-A**,
   **ERR-FS84-N1**, **ERR-FS100-Q47**, **FS136-NOTE**.
2. The 13 bibliography reading-status appends the table marks ready (the rows from **BIB-EL-KN7** through
   **BIB-K12A-Ambrus**), each appended to the cell its draft names, word for word.
3. **BIB-Tate-Weil**: one row each for `[Tate1950]` and `[Weil1967]` from KN9's draft (the later of the two drafts),
   placed beside the other rows marked "not held, not read"; the columns the draft leaves empty say "—".

Every other row of the table stays as it is: filed, declined by the amendment, or "no draft".

## Done means

1. **Stage 1 — the readback.** Check the quotation above against its source; restate the rows you will file and, for
   each, its draft's address and its slot as you find it on `main`.
2. **Stage 2 — the filing, by a script** (`data/fs131/fc9/file_rest.py`): it asserts every slot exactly once before it
   writes anything, puts each draft's words in exactly, and prints what it did per row. (A saved stage.)
3. **Stage 3 — the checks**, each with its output under `data/fs131/fc9/`: `python3 tools/claude_md_fact_audit.py --base {MAIN}`
   (a token reported lost is never allow-listed by you: list it as a `CHECK:`), the same with `--dupes`, and
   `python3 tools/bib_audit.py`.
4. **The report**, in the standing rules' form: per row filed or `CHECK:` with its reason; each check's last lines.

## What is yours to decide

How your script matches a slot and joins a draft to the file's wrapping. Where a draft would make a statement false
against the ledger or the kernel's print, or two drafts touch the same words, write a `CHECK:` and do not choose.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-rest.md"
open(out,"w").write(b); print(out)
