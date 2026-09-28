# Standing rules — part of every brief

*The rules every job in lean-dir's pipeline shares. Every brief names this file in its `standing rules:` field and says "it is part of
this brief; read it in full." Its frame is Keryx's template (`.claude/skills/keryx/scripts/standing-rules.md`). Its lean-dir rules are
the crunch runs', where each was learned, most of them from an incident: the incidents are `plans/PROTOCOL-crunch.md` §7, and the
rules' earlier text is that file's §5 before 2026-09-28 (`git show 280aad6a:plans/PROTOCOL-crunch.md`). A crunch adds
its own clock, queue and follow-on-job lines on top (§5 there). Delete a rule only when its reason no longer holds; Keryx is this file's writer.*

1. **No agents of your own.** Do not use the Agent tool, a fork, a workflow, or anything else that starts another agent. Delegation
   here is one level deep. The pipeline's agent files withhold the Agent and Workflow tools, so this rule is also enforced
   mechanically. The reason is in two parts. Staffing is Kooshi's budget decision, nested agents multiply its token spend, and an agent you start
   overrides it silently. And
   Keryx reviews by artifact, so it cannot review work by an agent it does not know exists, nor trust a bibliography entry's
   read-status when the reading was a grandchild's summary (G50). Kooshi's rule, 2026-09-19, was minted the
   day a planner briefed as "exactly one planner" started a subagent that started two more. If the work outgrows your context, stop at
   a saved stage and say what is left. That is a good report, never a failure.

2. **Work in stages, and keep each response short.** Add each stage's section to your record, headed "Stage n — SAVED", and commit it
   before the next stage starts. The reasons: a response lost to the output-token limit cannot be recovered (FS-86 lost three), and a
   halt then costs one stage instead of the job.
   - **Resuming.** If your record already exists when you start, you are resuming. Read it and your brief, check the last SAVED stage
     against `git log -- <record>`, and continue at the first stage that is not saved. Redo nothing that is saved.
   - **Working files.** Files a successor would need go under the `data/…` path your brief names, committed with the stage. `/tmp`
     is RAM here and dies with the session.
   - **Long runs.** A run expected to exceed about fifteen minutes checkpoints and resumes exactly. Your record names the checkpoint's
     path and the resume command (`CLAUDE.md` § Building).

3. **Quote statements verbatim; never paraphrase.** Every statement you hand on goes in a quotation with its source address, because
   a paraphrase can widen a statement, narrow it or empty it, and the reader cannot tell which. Paraphrases in briefs here have
   invented a gap, widened a statement and emptied a claim. Your first stage checks every quotation in your brief against its source
   and logs the result. A mismatch is a finding about the brief, and Keryx wants it.

4. **Every outcome counts.** Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."*
   - TRUE, FALSE with a counterexample, and GAP at a named step are all results.
   - Do not lean toward yes. This project's recorded failure mode is selection (`CLAUDE.md` G21): the defects that flatter the work
     survive. Audit a result you like as hard as one you dislike.
   - State each result at its grade, with its count of independent minds; say "not found in print", never "first". Never raise a
     grade, a scope or a verdict you are copying.

5. **The ban on finite-witness search runs to 2026-10-01** (`CLAUDE.md` § Toolchain). Kooshi's intent: *"to eliminate the crutch of
   feeling like we're accomplishing something by asking uncomputable problems for days at a time."*
   - **Out:** SAT, MaxSAT and #SAT solvers; MILP/CP and local-search colourers; Θ relation trees and float Θ finders;
     quotient-colouring searches; lattice sweeps hunting survivors.
   - **In:** hand derivation; exact arithmetic that checks a derived claim; existing checkers on existing certificates; the Lean
     kernel. A complete exact enumeration of a finite set whose extent a derivation fixed first is in, and is logged as such. "Try
     cases until one works" is out.
   - Keep a **"would have searched here" log** in your record: one line per move you would have made by search, and what you did
     instead.
   - Delete this rule after 2026-10-01 unless Kooshi extends it.

6. **Commits by explicit path.** Other agents share the tree.
   - `git add <new file>`, then `git commit <paths> -m …`. Never a bare `git commit`, never `git add -A`, never amend.
   - Push after each commit (`git push origin <branch>`); on a ref-lock race, sleep 4 and retry. Never force-push.
   - Subjects are neutral, naming the job and the stage ("FS115-D1: stage 2"), because a newly launched agent is shown recent commit
     subjects and a blind job must not read a verdict there.
   - End each commit message with your harness's attribution lines.

7. **Your record, your tools, and the files you do not write.**
   - Your record is the path your brief names. Give it a heading **"Theorems this phase proved"**: one line per theorem, with its
     grade and its address (Kooshi, 2026-09-22). A job that proves nothing says so under the heading.
   - Your exact checks go in `tools/<job-prefix>_*.py`. Plant a fault in each and watch it fire: a plant that cannot fire tests
     nothing (G21).
   - Never edit a frozen tool (`tools/fs58_*`, `tools/fs61_*`, `tools/fs66_*`, `tools/fs73_*check*.py`, `tools/fs73v2_check.py`,
     `data/fs73/coxeter-c3/certcheck.py`) or another job's tools.
   - **One writer per file.** Keryx alone writes `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `plans/GROKKING-INSTANCES.md`,
     `BIBLIOGRAPHY.md`, the close inventory, the claim lists once frozen, and this file, unless your brief makes you the front-page
     lane. Propose edits in your record, each written to be copied as it stands.

8. **Fences.** If your brief fences a path and a search prints fenced text, stop reading it, and log the touch at once in your record
   and your report: the time, the file, and what it carried. A disclosed touch costs little; an undisclosed one voids the grade. The
   session transcripts (`~/.claude/projects/`, `chats-bak/`) hold every earlier agent's route: a fenced job does not read them. Never
   write anything about an open milestone (a verdict, a route, a hunch) into the auto-memory, `~/.claude/projects/…/memory/`: the
   harness gives its index to every agent at launch, blind ones included. Never copy an agent id (a string like `a1b2c3…`) into any
   file. Never read credential files (`auth.json`, `.env`, keyrings).

9. **The machine.**
   - Any job over about 2 GiB or 2 minutes runs under `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`, with an honest `--mem`.
     On exit 75, wait ten minutes and retry; never raise a cap; after three refusals, report BLOCKED.
   - Never run `lake build`, bare or named. Lean builds go through `./scripts/build.sh` under a slot, in the kernel lane only.
   - Read every exit status directly, never through a pipe, and never chain a commit after a gate with `;`.
   - Stop a process by its PID or process group, never by matching a command line (`CLAUDE.md` § Building).
   - On any unexplained crash of any process, halt and report. Do not diagnose or retry.

10. **Reading.** Grep `BIBLIOGRAPHY.md` by arXiv id and Zbl number, and look in `~/source/library/`, before calling a paper unheld or
    fetching it (G50). Record a reading status per section: an abstract is not a reading, and "recalled, not read" is said where it is
    true. Never commit a paper's PDF; name it for the library. Propose `BIBLIOGRAPHY.md` rows in your record.

11. **The report.** When you finish, and at any halt you can foresee, write this to the report path your brief names, commit it, and
    send the same text to "main" by `SendMessage`:
    ```
    JOB <id> — <DONE | STAGE n SAVED | BLOCKED: reason>   harness≈<k> (own≈<k>)
    RESULT: <one line per claim: TRUE, FALSE with the counterexample, or GAP at the step; or the result's name and grade>
    RECORD: <path>   COMMITS: <hashes>
    INVENTORY: <one line per item — kind — one line — source address>
    HELD FOR THE COORDINATOR: <a decision or a slip, one line each; or "none">
    ```
    INVENTORY kinds: result, correction owed, prediction scored, retraction (counted per mind), slip, tool defect, prior-art debt,
    stub to mint or re-aim, fence touch, statement defect, question for another lane. Your last words are exactly "<id> idle; report sent to the coordinator", with
    no content: a hand-back is delivered to whichever agent last woke you, which may not be the coordinator.

12. **Budget.** Your brief names a size as guidance and a hand-back line. An overrun is not a slip (Kooshi, 2026-09-27). Leave margin:
    the loaded context at launch is itself large, and agents' own counts of their context have run at 29–70 % of the harness's (the
    crunch runs; FS-89 measured 55–70 %). Hand back at a saved stage before your brief's line.
