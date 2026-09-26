# Standing rules for the 2026-09-26 documentation consolidation — part of every brief

*Written by the product owner. Adapted from `data/crunch-2026-09-25/briefs/STANDING-RULES.md`, which it replaces for these jobs.*

1. **No children.** Do not use the Agent tool, a fork, a workflow or anything else that starts another agent. Delegation here is one level
   deep (`CLAUDE.md` § "Delegation — one level deep"). **The reason:** staffing is Kooshi's budget decision, and the owner can only review work
   it knows about. If the work outgrows your context, stop at a saved stage and say what is left — a good report, never a failure.
2. **Work in stages; keep each response short.** Save your record after every stage (a section headed `Stage n — SAVED`), commit it, then
   start the next. If your record already exists you are resuming: check the last SAVED stage against `git log -- <record>` and continue at the
   first stage not saved. Working files a successor needs go under the `data/…` path your brief names — never only in `/tmp`, which is RAM.
3. **The ban on finite-witness search runs to 2026-10-01.** None of these jobs needs a search; if you would have made one, log it in a "would
   have searched here" list and do something else.
4. **All novel knowledge is a success; state things at their grade.** Do not upgrade a grade, a scope or a verdict while consolidating. Every
   result stays at the grade its record gives it ([hand], [kernel], …, with its count of minds); "not found in print", never "first".
5. **Quote statements verbatim, never paraphrase** — above all when you move or shorten a claim. Two owner paraphrases this very day emptied a
   claim (the flip lost "affine, `U`-invariant"; NA₀ lost "positive"). When you rewrite a claim to current state, copy the source's words.
6. **Commits by explicit path.** `git add <new file>`, then `git commit <paths> -m …`; never a bare `git commit`, never `git add -A`, never
   amend. Push after each commit (`git push origin main`; on a ref-lock race `sleep 4` and retry); never force-push. Subjects name the job and
   stage ("C1: stage 2"). End each message with your harness's attribution lines.
7. **Never edit a frozen tool:** `tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*`, `tools/fs73_*check*.py`, `tools/fs73v2_check.py`,
   `data/fs73/coxeter-c3/certcheck.py`. Never read credential files (`auth.json`, `.env`, keyrings) — skip them in any directory survey.
8. **Machine.** Anything over about 2 GiB or 2 minutes runs under `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`. Never run `lake build`.
   On any unexplained crash of any process, halt and report. Read every exit status directly, never through a pipe.
9. **The report.** Write it to `data/consolidation-2026-09-26/reports/<job id>.md`, commit it, and send the same text to `"main"` by
   SendMessage, at most 12 lines:
   ```
   JOB <id> — <DONE | STAGE n SAVED | BLOCKED: reason>   harness≈<k if known>
   RESULT: <one line>
   RECORD: <path>   COMMITS: <hashes>
   FOUND: <n lines: kind — one line — address>   (kinds: lost-and-rescued, orphan-wired, stale-claim-fixed, citation-fixed, owed)
   HELD FOR THE OWNER: <one line each, or "none">
   ```
   The final text of your turn: "<job id> idle; report sent to the owner by SendMessage".
