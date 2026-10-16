# Standing rules — part of every brief

*The rules every job in lean-dir's pipeline shares. Every brief names this file in its `standing rules:` field; it is part of the brief,
read in full. Keryx is this file's writer. A crunch adds its own clock and queue lines (`plans/PROTOCOL-crunch.md` §5).*

1. **No agents of your own.** Do not use the Agent tool, a fork, a workflow, or anything else that starts another agent: delegation is one
   level deep, and the agent files withhold those tools. Staffing is Kooshi's budget, and Keryx reviews by artifact, so it cannot review
   work by an agent it does not know exists. If the work outgrows your context, stop at a saved stage and say what is left — a good
   report, never a failure.

2. **Work in stages, saved.** Add each stage's section to your record, headed "Stage n — SAVED", and commit it before the next stage
   starts: a halt then costs one stage instead of the job, and a response lost to the output limit cannot be recovered.
   - **Resuming.** If your record already exists, you are resuming: check its last SAVED stage against `git log -- <record>` and continue
     at the first stage not saved. Redo nothing saved.
   - **Working files** a successor would need go under the `data/…` path your brief names, committed with the stage — never in the
     session's scratch directory, and never only in `/tmp`, which is RAM and dies with the session. **Every other working file too,
     however temporary, goes under your own `data/…` path:** the session's scratch directory is shared by every running job, so a
     file there can be overwritten or read by another job's file of the same name (one job's read-aloud once arrived in another
     job's record that way).
   - **Long runs.** A run expected to exceed about fifteen minutes checkpoints and resumes exactly; your record names the checkpoint's
     path and the resume command (`RUNNING.md` § Building).

3. **Quote statements verbatim, with their source address; never paraphrase.** A paraphrase can widen, narrow or empty a statement, and
   the reader cannot tell which. Your first stage checks every quotation in your brief against its source and logs the result; a
   mismatch is a finding about the brief, and Keryx wants it.

4. **Every outcome counts.** Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."*
   TRUE, FALSE with a counterexample, and GAP at a named step are all results. Do not lean toward yes: the defects that flatter the work
   are the ones that survive (`CLAUDE.md` G21). State each result at its grade; say "not found in print", never "first"; never raise a
   grade, a scope or a verdict you are copying.

5. **No search, except by the Searcher.** No job runs SAT, MaxSAT or #SAT solvers, MILP/CP or local-search colourers, Θ relation trees or
   float Θ₄ finders, quotient-colouring searches, or lattice sweeps hunting survivors (`CLAUDE.md` § Toolchain has the in-list: hand
   derivation, computer algebra and exact arithmetic, colourings given by formula, the Lean kernel, existing checkers on existing
   certificates, an exact LP whose shape a derivation fixed). A step a search could decide goes in your report's INVENTORY as a
   `search request`: what it would decide, the object, its size. The Searcher (`.claude/agents/searcher.md`) runs searches once a day.

6. **Commits by explicit path.** Other agents share the tree.
   - `git add <new file>`, then `git commit <paths> -m …`. Never a bare `git commit`, never `git add -A`, never amend.
   - **Never push.** This repository's `origin` is public (`https://github.com/kooshi/hadwiger-nelson`), so a push publishes, and a
     published detail cannot be fully recalled. Commit on your branch; every branch is visible to Keryx in the shared repository, and
     Keryx pushes only at Kooshi's word, after checking the text against the publication's private lists.
   - Subjects name the job and the stage ("FS130-D1: stage 2"). End each message with your harness's attribution lines.

7. **Your record, your tools, and the files you do not write.**
   - Your record is the path your brief names, with a heading **"Theorems this phase proved"**: one line per theorem, with its grade
     and its address, or a line saying it proved none.
   - Your exact checks go in `tools/<job-prefix>_*.py`. Plant a fault in each and watch it fire (`RUNNING.md` § Make the gate fail, and
     watch it fail). Never edit a frozen tool (`tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*`, `tools/fs73_*check*.py`,
     `tools/fs73v2_check.py`, `data/fs73/coxeter-c3/certcheck.py`) or another job's tools.
   - **One writer per file.** `CLAUDE.md` § The pipeline names the files Keryx alone writes; unless your brief makes you its pen, draft
     edits to them in your record, each naming its slot (the file, the section, and the words it replaces or follows).

8. **Never**: an agent id (a string like `a1b2c3…`) in any file; a credential file (`auth.json`, `.env`, keyrings) read; anything about an
   open milestone written into the auto-memory, which every agent is shown at launch. If your brief fences a path — de Bruijn's planner
   is fenced from the derivation's records until its plan is committed — do not read it until your brief allows; if a search prints
   fenced text, stop reading and log the touch in your record and your report: the time, the file, and what it carried.

9. **The machine.**
   - Any job over about 2 GiB or 2 minutes runs under `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`, with an honest `--mem`. On exit
     75, wait ten minutes and retry; never raise a cap; after three refusals, report BLOCKED.
   - Never run `lake build`, bare or named; Lean builds go through `./scripts/build.sh` under a slot, in de Bruijn's lane (`LEAN.md`).
   - Read every exit status directly, never through a pipe, and never chain a commit after a gate with `;`.
   - Stop a process by its PID or process group, never by matching a command line.
   - On any unexplained crash of any process, halt and report. Do not diagnose or retry.
   - `RUNNING.md` is this rule's long form; read it before any run over about fifteen minutes and before building any tool.

10. **Reading.** Grep `BIBLIOGRAPHY.md` by arXiv id and Zbl number, and look in `~/source/library/`, before calling a paper unheld or
    fetching it. Record a reading status per section: an abstract is not a reading, and "recalled, not read" is said where it is true.
    Never commit a paper's PDF; name it for the library. Propose `BIBLIOGRAPHY.md` rows in your report.

11. **The report.** When you finish, and at any halt you can foresee, write this to the report path your brief names, commit it, and end
    with the same text as your final message — your hand-back reaches Keryx, so send no separate message:
    ```
    JOB <id> — <DONE | STAGE n SAVED | BLOCKED: reason>   harness≈<k> (own≈<k>)
    RESULT: <one line per claim: TRUE, FALSE with the counterexample, or GAP at the step; or the result's name and grade>
    RECORD: <path>   COMMITS: <hashes>
    INVENTORY: <one line per item — kind — one line — source address>
    HELD FOR THE COORDINATOR: <a decision or a slip, one line each; or "none">
    ```
    INVENTORY kinds: result, correction owed, prediction scored, slip, tool defect, prior-art debt, stub to mint or re-aim, statement
    defect, generalization, invention signal (`CLAUDE.md` G87: two truths that contradict, or a whiff of them — both sides quoted with
    their addresses, no side picked), search request, question for another lane. Mid-job, message "main" only for a question you cannot
    work around, or a finding that cannot wait: a statement defect, a generalization, a refutation.

12. **Budget.** Your brief names a size as guidance and a hand-back line; an overrun is not a slip. Leave margin: the context loaded at
    launch is itself large, and agents' own counts of their context run at 30–70 % of the harness's. Hand back at a saved stage before
    your brief's line.

13. **Everything you commit may be published.** Write nothing personal into a tracked file, a commit message or a report: no
    personal name beyond the GitHub handle, no e-mail address, no private host or URL, and no path or name of a project on this
    machine that is not this one (the document library `~/source/library/`, the outside release's clone `~/source/math`, other
    worktrees of this repository and the descent engine may be named). Where such a thing matters, say its kind ("a private
    server", "an unrelated project") or ask Keryx. Novelty is worded "prior art: not found in print", never "new" or "first".
