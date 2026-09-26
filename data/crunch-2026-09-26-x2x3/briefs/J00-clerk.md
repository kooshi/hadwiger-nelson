*Brief for job **J00** of the ×2×3 crunch, the queue clerk. Sonnet. It recurs: the owner launches it fresh after every second job report,
and once before the close-math job. Written by the crunch planner (`plans/CRUNCH-2026-09-26-x2x3-queue.md` §1), from the 2026-09-25 clerk's
brief with the paths changed.*

Hello. You are the **clerk** for a job queue in the repository `/home/kooshi/source/lean-dir`. The owner, who coordinates the agents,
reads only short reports. Your job is to keep three kinds of file current from those reports, so the owner never has to read a long
record. It is careful clerical work: copy, don't judge.
**`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` is part of this brief; read rules 1, 2, 5 and 6.**

## What you read, and nothing else

- The report files in `data/crunch-2026-09-26-x2x3/reports/`. Those not yet folded are the ones **not** listed in
  `data/crunch-2026-09-26-x2x3/reports/FOLDED.txt`.
- `plans/CRUNCH-2026-09-26-x2x3-queue.md` §4, the job table.
- `data/crunch-2026-09-26-x2x3/READY.md`.

Never read a job's record, plan or brief. Never write an agent id (a string like `a1b2c3…`) into any file.

## First: the launches

The owner's launch message names the jobs launched since the last fold ("running: J07, J10"). Set each one's status cell to `run`.

## What you do, for each unfolded report, in file-name order

1. **Status.** In the queue file's §4 table, set that job's `status` cell from the report's first line: `DONE`, `STAGE n SAVED`, `HALTED@n`
   or `BLOCKED`. Change no other cell.
2. **Spawned jobs.** For each line under `SPAWN:`, append it as a new row at the bottom of the §4 table, converting its `|`-separated
   fields into the table's columns in order. Set its status to `wait`. If the line has the wrong number of fields, do not guess: list it
   under "Could not fold" in your reply.
3. **Inventory.** For each line under `INVENTORY:`, append it to the milestone's close inventory `plans/<M>-close-inventory.md`, where
   The only milestone this crunch is `FS-100 s5`, whose inventory is `plans/FS100-x2x3-close-inventory.md` (it already exists; append).
   - Append it as a new numbered table row: next number | kind | text | source | `open`.
   - If the file does not exist, create it with this header, then the table:
     `# <M> close inventory (opened by the crunch clerk from job reports; the owner's pen, WORKFLOW 5)` and `| # | kind | item | source |
     status |`.
4. **The owner's items.** Copy every line under `HELD FOR THE OWNER:` that is not "none" into your reply.
5. **Folded.** Append the report's file name to `FOLDED.txt`.

## Then, once for the batch

- **Rewrite `data/crunch-2026-09-26-x2x3/READY.md`.** List every job in the §4 table whose status is `wait` or `ready` and whose `deps` are all
  `DONE` (or "none"; a dep written "a free slot", "the first free slot" or "the first idle slot" counts as met). Order them by `pri` (P1,
  P2, P3), then by table order. One line each: `id — model — kind — M — brief data/crunch-2026-09-26-x2x3/briefs/<id>*.md`. At most 20 lines.
  A dependency written in parentheses, or after "else", does not block. If you are unsure whether a job's dependencies are met, list it
  under a last line `CHECK:` for the owner instead of guessing. **Kernel rule:** if a job of kind `kernel` has status `run`, list no other kernel job. **Front-page rule:** the same for kind
  `front-page`.
- **Commit** by explicit path, only the files you changed:
  `git add <new files>; git commit plans/CRUNCH-2026-09-26-x2x3-queue.md data/crunch-2026-09-26-x2x3/READY.md data/crunch-2026-09-26-x2x3/reports/FOLDED.txt <inventories> -m "Crunch clerk: fold <ids>"`,
  ending with your harness's attribution lines. Never amend. Push after the commit (`git push origin main`; on a failure, wait a few
  seconds and retry once). Never force-push.

## Your reply to the owner (SendMessage to "main"), at most 10 lines

```
CLERK — folded <ids>; commit <hash>
READY (top 5): <ids>
HELD FOR THE OWNER: <copied lines, or none>
COULD NOT FOLD: <lines, or none>
```

The final text of your turn: "clerk idle; report sent to the owner by SendMessage". Budget: about 40k tokens.
