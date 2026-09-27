# Standing rules for every job of the consolidation and library run, 2026-09-27 — part of every brief

*Written by the product owner (the top-level session), from `data/fs110/briefs/STANDING-RULES.md`. Read it in full.*

0. **Read `CLAUDE.md` § The aim and § Counter-priors before anything else.** Rule 1 there governs every ranking you touch: *"Rank a route by its
   bearing on the answer, never by its difficulty, its length or its formalization effort."*

1. **No children.** Do not use the Agent tool, a fork, a workflow or anything else that starts another agent. Delegation is one level
   deep (`CLAUDE.md` § "Delegation — one level deep"). **The reason:** staffing is Kooshi's budget decision (at most three agents at once,
   all Opus 5.5), and the owner can only review work it knows about. If the work outgrows your context, stop at a saved stage and say what is
   left. That is a good report, never a failure.

2. **Work in stages, and keep each response short.** Save your record after every stage: add the stage's section, headed `Stage n — SAVED`,
   and commit it before the next stage starts. **Resuming:** if your record already exists when you start, you are resuming — check the last
   SAVED stage against `git log -- <record>` and continue at the first stage not SAVED. Working files a successor would need go under
   `data/consolidation-2026-09-27/<your job id, lower case>/`, committed with the stage, never only in `/tmp` (`/tmp` is RAM).

3. **The ban on finite-witness search runs to 2026-10-01** (`CLAUDE.md` § Toolchain). This run searches nothing of that kind; reading, fetching,
   exact checks of seconds, and existing checkers are in. Keep a "would have searched here" log if the urge arises.

4. **All novel knowledge is a success; novelty is "not found in print", never "first".** A paper that pre-empts one of our results is a
   finding, stated plainly, with the attribution moved to it (`CLAUDE.md` G49: `[Fischer1994]` is the instance). Audit a result you like at
   the rate of one you do not (G21).

5. **Quote verbatim, never paraphrase.** Every statement you hand on from a paper goes in quotation marks with its address (page, and the
   theorem or problem number). When a scan is hard to read, say which words are uncertain. Paraphrases inside quotation marks have cost this
   project twice in two days; a quoted block cut by line range is a paraphrase too.

6. **Commits by explicit path.** Up to four sessions share the tree.
   - `git add <new file>`, then `git commit <paths> -m …`; never a bare `git commit`, never `git add -A`, never amend. On an `index.lock`
     error, wait a few seconds and retry.
   - **Push after each commit** (`git push origin main`; if rejected, `git pull --rebase origin main`, then push). **Never force-push.** A
     rebase conflict in a shared front file is yours to resolve by keeping both sides' edits.
   - Subjects neutral, naming the job and stage ("LP: stage 2"). End each message with your harness's attribution lines.

7. **Touch only the files your brief names.** Front-file edits outside them go into your record as drafts for the owner.

8. **The Geombinatorics archive.** Fetch only through `tools/geomb_fetch.sh` (its usage is in `tools/geomb_fetch.py`'s header).
   - **Never read `.env`**, never source it yourself, never print your environment (`env`, `printenv`, `set`, `declare -p`), and never edit
     `tools/geomb_fetch.py` or `tools/geomb_fetch.sh`. The wrapper loads the credentials into its own process and types them only into the
 If the tool fails, report the failure to the owner and continue with what is held.
   - Download into `~/source/library/geombinatorics/` (issues) or `~/source/library/pdf/` (single papers), with descriptive names. Before
     fetching, check whether the issue is already held (`ls ~/source/library/geombinatorics/`).
   - One fetch at a time, from one job at a time.
     three times per file.

9. **Reading scans.** Old issues are image scans, two journal pages per landscape sheet, with no text layer, and no OCR tool is installed.
   Render sheets with `pdftoppm -r 150 -f N -l N -png <pdf> <scratch prefix>` (higher resolution for formulas) into your scratch directory and
   view them with the Read tool. Recent issues have a text layer: `pdftotext -layout`.

10. **Bibliography rule** (`BIBLIOGRAPHY.md`'s own rules; `CLAUDE.md` § The mission): every paper you read gets an entry, or its entry updated —
    where our copy is, what of ours rests on it, and how much was read, per section. Before calling a paper unheld, grep `BIBLIOGRAPHY.md` and
    the library. Run `python3 tools/bib_audit.py` after each stage that edits it, and read its exit status directly, never through a pipe.

11. **Report** to the path your brief names, committed, and by SendMessage to `"main"` (always address `"main"` explicitly). Your final turn's
    text is the line your brief gives.
