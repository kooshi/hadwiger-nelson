# Standing rules for every job of the ×2×3 crunch (2026-09-26, 10:26–12:26 UTC) — part of every brief

*Written by the crunch planner (`plans/CRUNCH-2026-09-26-x2x3-queue.md` §1), from the 2026-09-25 crunch's rules with the deltas changed.
Every brief points here, and this file is part of it; read it in full.*

1. **No children.** Do not use the Agent tool, a fork, a workflow or anything else that starts another agent. Delegation here is one
   level deep (`CLAUDE.md` § "Delegation — one level deep"). **The reason:** staffing is Kooshi's budget decision, and the owner can only
   review work it knows about. If the work outgrows your context, stop at a saved stage and say what is left. That is a good report,
   never a failure.

2. **Work in stages, and keep each response short.** Save your record after every stage: add the stage's section, headed
   `Stage n — SAVED`, then commit it before the next stage starts. **The reasons:** at FS-86 an agent lost three responses to the
   output-token limit, and nothing can recover a lost response. Also, a 5-hour usage window can halt you mid-job; a halt then costs one
   stage, not the job.
   - **Resuming:** if your record already exists when you start, you are resuming. Read it and your brief, check the last SAVED stage
     against `git log -- <record>`, and continue at the first stage that is not SAVED. Redo nothing that is saved.
   - Working files a successor would need go under the `data/…` path your brief names, committed with the stage, never only in `/tmp`.
     `/tmp` is RAM and dies with the session.

3. **The ban on finite-witness search runs to 2026-10-01.**
   - **Out:** SAT, MaxSAT, #SAT, MILP/CP, local-search colourers, `Θ` relation trees and float `Θ` finders, quotient-colouring searches,
     and lattice sweeps hunting survivors. Also out are machine-long certificates such as multi-hour relaxations.
   - **Kooshi's intent, in his words:** *"The intent of the ban is to eliminate the crutch of feeling like we're accomplishing something by
     asking uncomputable problems for days at a time."*
   - **In:** hand derivation; exact arithmetic of seconds that checks a derived claim; existing checkers on existing certificates; the
     Lean kernel.
   - **At the edge:** a complete exact enumeration of a finite set whose extent a derivation fixed first (FS-89's band-set computation,
     which Kooshi allowed) is in, and is logged as such. "Try cases until one works" is out.
   - **Keep a "would have searched here" log** in your record: one line for each move you would have made by search, and what you did
     instead.

4. **All novel knowledge is a success.** Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge is a
   success."*
   - Do not lean toward a yes. This project's recorded failure mode is selection (`CLAUDE.md` G21): defects that flatter the work survive,
     and defects that displease are found within the hour.
   - Audit a result you like as hard as one you dislike.
   - FALSE with a counterexample, or GAP with the missing step named, is as valuable as TRUE.

5. **Quote statements verbatim, never paraphrase.** Every statement you hand on goes in quotation marks with its source address. Two
   paraphrases in briefs cost FS-86 spurious findings: one invented a gap, and one widened a statement. **Your first stage checks every
   quotation in your brief against its source** and logs the result.

6. **Commits by explicit path.** The tree is shared by six agents.
   - `git add <new file>`, then `git commit <paths> -m …`; never a bare `git commit`, and never `git add -A`.
   - Never amend. **Push after each commit** (`git push origin main`); if a push fails because another agent was pushing at the same moment, retry once after a few seconds. **Never force-push.** (Corrected 19:55 by the owner: an earlier text said "never push"; Kooshi's rule is push freely, never force-push, and a brief that says push is right.)
   - Subjects are neutral, naming the job and the stage ("J07: stage 2"), because the harness shows every agent the last five subjects.
   - End the message with your harness's attribution lines.

7. **Records and tools.**
   - Your record is the path your brief names. Give it a heading **"Theorems this phase proved"**: one line per theorem, with its grade
     (§ Notation's grades) and its address.
   - Your exact checks go in `tools/<job-prefix>_*.py`. Plant a fault in each and watch it fire. A plant that cannot fire tests nothing.
   - Never edit a frozen tool: `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*`, `tools/fs73_*check*.py`, `tools/fs73v2_check.py`,
     `data/fs73/coxeter-c3/certcheck.py`, or any other job's tools.
   - Never edit `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md` or `BIBLIOGRAPHY.md`. The front-page lane writes them; you propose
     edits in your record.

8. **Machine.**
   - Any job over about 2 GiB or 2 minutes runs under `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`, with an honest `--mem`.
   - On exit 75 (not admitted after 1,800 s), wait ten minutes and retry. Never raise a cap. After three refusals, report BLOCKED.
   - Never run `lake build`, bare or named. Kernel jobs follow their brief's build line.
   - On any unexplained crash of any process, halt and report. Do not diagnose or retry.

9. **The report.** When you finish, and at any halt you can foresee, write this and commit it to
   `data/crunch-2026-09-26-x2x3/reports/<your job id>.md`. Then send the same text to `"main"` by SendMessage:
   ```
   JOB <id> — <DONE | STAGE n SAVED | BLOCKED: reason>   harness≈<k if you know it> (own≈<k>)
   RESULT: <one line; per claim TRUE / FALSE / GAP-at-step, or the theorem's name and grade>
   RECORD: <path>   COMMITS: <hashes>
   INVENTORY: <n lines follow, each "kind — one line — source address">
   SPAWN: <n lines follow in the queue's format, or "none">
   HELD FOR THE OWNER: <a decision or a slip, one line each; or "none">
   ```
   - **INVENTORY kinds:** result, correction owed, prediction scored, slip, tool defect, prior-art debt, stub to mint or re-aim.
   - **SPAWN lines** use `plans/CRUNCH-2026-09-25-queue.md` §1.2's format (the columns of `plans/CRUNCH-2026-09-26-x2x3-queue.md` §4), and each comes with its brief written as a file under
     `data/crunch-2026-09-26-x2x3/briefs/`, following `plans/CRUNCH-2026-09-25-queue.md` §4's skeleton.
   - **The final text of your turn:** "<job id> idle; report sent to the owner by SendMessage".

10. **Budget and clock.** Your brief names the budget, in the harness's count. Hand back with your record saved before 300k. Agents' own
    counts have run at 55–70 % of the harness's, so leave a margin. **The crunch ends at about 12:26 UTC, and the close reads reports from
    06:55:** check `date` at every stage, and at 06:50 finish the current claim, save, and report, whatever is left.

11. **Reading is in; cite what you read.** Fetching and reading papers is allowed (the ban is on finite-witness search). Grep
    `BIBLIOGRAPHY.md` (by arXiv id and Zbl number) and `~/source/library/` before calling a paper unheld, and record a reading status per
    section (G50). An abstract is not a reading. Propose `BIBLIOGRAPHY.md` rows in your record; the front-page job writes them.
