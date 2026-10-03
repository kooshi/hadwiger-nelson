# Brief CL3 — the Clerk: count, from the record, where the search ban changed what a job did

*Written 2026-10-03 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: CL3
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow
  role: a reading-and-counting job: collect every "would have searched here" log line written while the ban was in force, sort each by a fixed rule from the record's own words, and count; decide nothing about the mathematics
  launch: now, beside R2 (Poros's re-rank; it writes nothing you read)
  mission: § Why this job
  statements: none — a counting job; what to collect and the sorting rule are § What to collect and § The sorting rule
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — no blind job is running
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/workflow3/reports/CL3.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/WORKFLOW3-CL3-ban-audit.md`
  touches: `plans/WORKFLOW3-CL3-ban-audit.md`, `data/workflow3/cl3/`, `tools/cl3_*.py`, `data/workflow3/reports/CL3.md`
  budget: about 250k by the harness's count, as guidance; hand back at a saved stage before about 400k

Hello. This is a counting job for a decision Kooshi will make, so the care is in counting what the record says and nothing more.

## Why this job

From 2026-09-24 to 2026-10-01 no job could search for a finite witness (`CLAUDE.md` § Toolchain, the paragraph opening "No search for a finite
witness runs from 2026-09-24 to 2026-10-01"; `plans/STANDING-RULES.md` rule 5). Every brief in that time asked for a "would have searched here" log:
one line per move the job would have made by search, and what it did instead. The ban's dates have passed, and Kooshi is deciding what replaces it.
His words, 2026-10-03:

> As for the ban - have a clerk count the number of times it actually hindered us in the short time it was active. We didn't get to have a full week of it, but I want to know how it affected our approach before we remove it outright. I'm thinking of restricting search to a wallclock budget per day and per week. A lot of progress was made without it.
> — source: plans/FS116-close-inventory.md row O7

## What to collect

1. **Every log line.** In every file under `plans/` and `data/` that has a section headed "Would-have-searched-here log" (or "would have searched",
   in any case and any heading level), every bullet or line in that section. About 277 files mention the phrase (`grep -lis 'would.have.searched'`).
   Keep a line only if its job ran on or after 2026-09-24: take the date from the record's header, or else from the first commit that added the file
   (`git log --diff-filter=A --format=%ad --date=short -- <file>`). Mark each line written after 2026-10-01 (the ban's dates had passed; FS-116's frozen
   list still forbade enumeration, its § 9).
2. **Every request to search and its ruling.** In the close inventories (`plans/*close-inventory.md`) and the crunch records (`plans/CRUNCH-*.md`)
   dated 2026-09-24 or later: every item that rules on running a solver, a search or an enumeration, or on whether something a job ran was a search.
   Copy each with its address. Two you will find: `plans/FS116-close-inventory.md` items 82 and 86.
3. **Progress, for context only**: for each milestone whose derivation file was written between 2026-09-24 and 2026-10-03 (`plans/*-derivation.md`;
   date by first commit), the number of `derivation:` entries in it, or for an older-shape file the number of theorem entries its own header
   counts. Copy the count and how you counted.

## The sorting rule

Sort each log line by its own words, and the words of the record section it points to, into exactly one class:
- **R — replaced**: the line, or the section it points to, names a result reached instead (derived, proved, excluded, computed exactly, checked, a
  lemma or an obstruction found) at that step.
- **O — left open**: it says the step stayed open: stalled, a GAP, not attempted, not reached, stopped, deferred, or left for a search after the ban.
- **N — none**: the line says no search was wanted at that stage ("none", "no search").
- **U — unclear**: the words do not settle it. Put every U on a `CHECK:` line with its address; do not guess.

For each O line, one further copy: search the derivation files written after it for the object the line names (by its exact words) and list any
entry whose statement names it, as "a later entry names it: <id>, <file>" — a candidate, not a finding. One you will find: FS116-Y3's stage-4 line
(HEX3's star) and FS116-Y4-EMPTY (`plans/FS116-close-inventory.md` items 86, 122, 139).

## Done means

1. data/workflow3/cl3/lines.tsv (a new file): one row per log line — file, line number, job, date, after-10-01 flag, the line verbatim, its class,
   and for an O line the later-entry candidates.
2. data/workflow3/cl3/rulings.md (a new file): the requests and rulings of § What to collect item 2, each verbatim with its address.
3. **Your record**, `plans/WORKFLOW3-CL3-ban-audit.md`: the readback; how you found the files and the sections (the script, `tools/cl3_*.py`, with a
   planted fault that makes it fail and the run showing it fail); the counts — lines per class, in total, per milestone and per job kind (proof,
   construction, verifier, opening, Poros, other); the number of jobs that kept a log and the number whose log has at least one O line; the O lines
   listed in full; the context counts of item 3.
4. **The report** in the standing rules' form, with the counts in its RESULT lines and `CHECK:` lines for every U. Your last words are exactly
   "CL3 idle; report sent to the coordinator", and the hand-back carries nothing else.

## What is yours to decide

Only the class of each line, by the rule above, and how to find the sections. Whether the ban helped or hindered overall is not yours, nor mine: it
is Kooshi's, from your counts.

## Stages (save and commit each; standing rule 2)

1. The readback, the file list and the extraction script with its failing plant.
2. The lines sorted, the rulings copied, the context counts.
3. The record and the report.

You start no agent of your own (`plans/STANDING-RULES.md` rule 1: staffing is Kooshi's budget, and I can review only work I know exists).

Thank you.
