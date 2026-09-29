# Brief CL1 — the Clerk: file the bibliography rows the two openings proposed tonight

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: CL1
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow
  role: Keryx's pen for `BIBLIOGRAPHY.md`, for this job only: file the rows and reading statuses the two opening jobs recorded, in the file's own format, deciding nothing
  launch: now; five derivation and verification jobs are running and none writes `BIBLIOGRAPHY.md`
  mission: § Why this job
  statements: none — a filing job; its inputs are the two opening records' bibliography notes, named by address in § What you file
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — you are not a blind job; but read only the sections named below, since two blind verifiers are running and your record must carry nothing of those sections beyond the bibliographic facts
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/workflow3/reports/CL1.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/WORKFLOW3-CL1-bibliography.md`
  touches: `plans/WORKFLOW3-CL1-bibliography.md`, `BIBLIOGRAPHY.md`, `data/workflow3/reports/CL1.md`
  budget: about 150k by the harness's count, as guidance; hand back at a saved stage before about 250k

Hello. This is a short filing job.

## Why this job

`CLAUDE.md` asks that every external work the project cites or depends on be an entry in `BIBLIOGRAPHY.md` the day it is first used,
with what rests on it, where the copy is, and how much of it has been read, per section. Tonight's two opening jobs (FS-116's and
FS-121's) searched the literature and recorded new works and new reading statuses in their records. `BIBLIOGRAPHY.md` has one writer,
the coordinator; for this job you are its pen, copying what the records say and nothing more.

## What you file

From `plans/FS116-local-exclusion.md` § 2.1–2.4 (read those sections only):
- a new row for `[DolbilinSchattschneider1998]`, "The local theorem for tilings" (Zbl 0918.52007), seen at zbMATH only, unread;
- the Google-group row's reading status (it sits near l. 902 of `BIBLIOGRAPHY.md`): the thread J_Tw1_hUxQI read at ll. 4290–4790 plus grep
  hits, and thread a701Kwnhp_A held and grep-read, as § 2.2 records;
- the one work citing `[SokolovVoronov2025]` that § 2.4 names, title only and unread, if the file's format has a place for a work seen in a
  listing only (the header says titles seen only in search listings are marked as such).

From `plans/FS121-map-step.md` § 2.2 (read that section only):
- `[Tolmachev2025]` (arXiv:2411.13248), with the reading status the section records;
- `[Alper2020]` (Zbl 1442.05019) and `[Howard1999]` (Zbl 0958.53024), listing only;
- `[Walther1999]` (Zbl 0933.52003), not held, named for the library;
- `[CohenMani2025]`'s reading status, updated to what § 2.2 records for its § 5.

Before adding any row, search `BIBLIOGRAPHY.md` for the key, the arXiv id and the Zbl number (standing rule 10): a key already defined is
updated in place, never duplicated.

## Done means

1. `BIBLIOGRAPHY.md` carries each item above in its existing format, each row's "what rests on it" taken from the record's words, and
   `python3 tools/bib_audit.py` exits 0 after your edit (read the exit status directly).
2. **Your record**, `plans/WORKFLOW3-CL1-bibliography.md`: the readback, one line per item (filed, updated, or not filed and why), and the
   audit's exit status.
3. **The report** in the standing rules' form, with a `CHECK:` line for anything you would have had to guess. Your last words are exactly
   "CL1 idle; report sent to the coordinator".

## What is yours to decide

Only the placement and the formatting, following the file's own conventions. Where a record does not say what a row needs (a role, a read
status), leave that field as the file does for an unread work and list it on a `CHECK:` line. Never characterise a paper from its title.

## Stages (save and commit each; standing rule 2)

1. The readback and the items found in the two records.
2. The rows filed, the audit run, the report.

Thank you.
