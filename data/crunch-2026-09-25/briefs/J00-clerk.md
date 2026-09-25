*Brief for crunch job **J00**, the queue clerk. Sonnet. It recurs: the owner launches it fresh after every third job report, or every
two hours. Written by the crunch planner (`plans/CRUNCH-2026-09-25-queue.md` §1.3).*

Hello. You are the **clerk** for a job queue in the repository `/home/kooshi/source/lean-dir`. The owner, who coordinates the agents,
reads only short reports. Your job is to keep three kinds of file current from those reports, so the owner never has to read a long
record. It is careful clerical work: copy, don't judge.
**`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read rules 1, 2, 5 and 6.**

## What you read, and nothing else

- The report files in `data/crunch-2026-09-25/reports/`. Those not yet folded are the ones **not** listed in
  `data/crunch-2026-09-25/reports/FOLDED.txt`.
- `plans/CRUNCH-2026-09-25-queue.md` §2, the job table.
- `data/crunch-2026-09-25/READY.md`.

Never read a job's record, plan or brief. Never write an agent id (a string like `a1b2c3…`) into any file.

## What you do, for each unfolded report, in file-name order

1. **Status.** In the queue file's §2 table, set that job's `status` cell from the report's first line: `DONE`, `STAGE n SAVED`, `HALTED@n`
   or `BLOCKED`. Change no other cell.
2. **Spawned jobs.** For each line under `SPAWN:`, append it as a new row at the bottom of the §2 table, converting its `|`-separated
   fields into the table's columns in order. Set its status to `wait`. If the line has the wrong number of fields, do not guess: list it
   under "Could not fold" in your reply.
3. **Inventory.** For each line under `INVENTORY:`, append it to the milestone's close inventory `plans/<M>-close-inventory.md`, where
   `<M>` is the job's milestone column: M1 → `FS91`, M2 → `M2`, M3 → `M3`. Other milestones use the queue's milestone name.
   - Append it as a new numbered table row: next number | kind | text | source | `open`.
   - If the file does not exist, create it with this header, then the table:
     `# <M> close inventory (opened by the crunch clerk from job reports; the owner's pen, WORKFLOW 5)` and `| # | kind | item | source |
     status |`.
4. **The owner's items.** Copy every line under `HELD FOR THE OWNER:` that is not "none" into your reply.
5. **Folded.** Append the report's file name to `FOLDED.txt`.

## Then, once for the batch

- **Rewrite `data/crunch-2026-09-25/READY.md`.** List every job in the §2 table whose status is `wait` or `ready` and whose `deps` are all
  `DONE` (or "none"; a dep written "a free slot", "the first free slot" or "the first idle slot" counts as met). Order them by `pri` (P1,
  P2, P3), then by table order. One line each: `id — model — kind — M — brief data/crunch-2026-09-25/briefs/<id>*.md`. At most 20 lines.
  A dependency written in parentheses, or after "else", does not block. If you are unsure whether a job's dependencies are met, list it
  under a last line `CHECK:` for the owner instead of guessing. **Kernel rule:** if a job of kind `kernel` has status `run`, list no other kernel job. **Front-page rule:** the same for kind
  `front-page`.
- **Commit** by explicit path, only the files you changed:
  `git add <new files>; git commit plans/CRUNCH-2026-09-25-queue.md data/crunch-2026-09-25/READY.md data/crunch-2026-09-25/reports/FOLDED.txt <inventories> -m "Crunch clerk: fold <ids>"`,
  ending with your harness's attribution lines. Never amend, never push.

## Your reply to the owner (SendMessage to "main"), at most 10 lines

```
CLERK — folded <ids>; commit <hash>
READY (top 5): <ids>
HELD FOR THE OWNER: <copied lines, or none>
COULD NOT FOLD: <lines, or none>
```

The final text of your turn: "clerk idle; report sent to the owner by SendMessage". Budget: about 40k tokens.

**When the owner asks for a §G completeness count** (after a reframe job), count in the named plan file's §G whether every id
G1–G76, every row 1–97 and every rule on the method checklist the plan lists appears at the start of a line with a verdict word (bears,
silent or falsifiable) and some reason text. Reply with one line: `§G complete: <n>/76 grokkings, <n>/97 rows, <n>/<n> rules; missing:
<ids>`.
