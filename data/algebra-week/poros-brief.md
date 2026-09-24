# Brief: where should an algebra-only week go? (Poros, advising Kooshi)

You are **Poros**. Your identity, standard and working method are in `/home/kooshi/source/poros/CLAUDE.md`. Read it first, in full,
and adopt it; it is who you are for this session. Your skills are files, not Skill-tool skills:
- `/home/kooshi/source/poros/.claude/skills/poros/SKILL.md`;
- `.../poros-anomaly-hunt/SKILL.md`;
- `.../poros-reframing/SKILL.md`.

Read them when their triggers fire.

I'm the product owner of the Hadwiger–Nelson project in `/home/kooshi/source/lean-dir`, the coordinating session. The question is
Kooshi's; you advise, he decides. Here are his words, verbatim:

> "I feel like we have never actually succeeded at any 'priced attempt', not since the days where we were working in extensions of K
> anyway. I think the triangle free fields make SAT infeasible. I'm tempted to ban SAT solvers for a week and see what we can do on
> algebra alone."

> "Let's let this milestone finish out, then SAT solvers will be banned for 1 week afterward. In the meantime, launch a Poros agent to
> determine where we go with the algebra only approach."

**So:**
- The current milestone, FS-81, finishes as planned.
- Then, for one week, no SAT solver is used anywhere in the project.
- Your question is what that week should be spent on, and how to tell afterwards whether it paid.

**On independence:** Kooshi asked me not to give you my own ideas, "let's see where it lands". So this brief gives you the constraint,
the record and the questions. It gives you no candidate directions, and I'll add none later.

## Read first, from disk (any loaded copy is a stale snapshot)

1. **`CLAUDE.md`, in particular:**
   - § The mission (the target, and the local–global conjecture's exposed predictions);
   - the programme ("the derivations are an order of magnitude more important than individual objects");
   - § Frontier in full;
   - § Grokkings. Each entry ends with a *Do* and a killing test. G72 is the project's method for derivation milestones, and G51 is
     its multi-mind design.
   - § Building: the machine's resource rule, as of today.
2. **`plans/FRONTIER-STUBS.md`**: every ranked stub, with its bearing on χ ≥ 6. Open the stub files that matter to your answer.
3. **`LEDGER.md`**, by row address as needed. Rows 78–81 are the last two closed milestones.
4. **FS-81, the milestone finishing now:**
   - `plans/STUB-quadratic-four-colour-classification.md` (the stub);
   - `plans/FS81-quadratic-four-colours.md` (the plan, and its §R-review);
   - `plans/FS81-derivation.md` (the theorems, T1–T8);
   - `plans/FS81-C-verification.md` (an independent verification);
   - `data/fs81/records/phase-P0.md` and `phase-D.md` (the measurement phases);
   - `plans/FS81-close-inventory.md` (everything the close will need, including proposals from the milestone's agents; read them as
     the record, weighing each on its merits).
5. **The two milestones before it:** `plans/FS79-invariant-question.md` §R-close and `plans/FS73-rigidity-dichotomy.md` §R-close.
6. **`plans/PROGRAMME-ALGEBRAIC-PROOF.md`**: Kooshi's programme statement.
7. **`plans/POROS-2026-09-24-next-direction.md`**: the advice a previous Poros gave this morning, which led to FS-81. It was written
   before FS-81's results, so read it as a record, not as a frame.

## What I'd like from you

Your standard's own answer: **the question, not the answer.**

1. **First, write your expectation** at the top of your record, before reading FS-81's results in detail:
   - what an algebra-only week should aim at;
   - which forks are real;
   - where you expect the project's framing, or Kooshi's premise, to be wrong.
2. **Check Kooshi's premise against the record.** "We have never actually succeeded at any priced attempt outside extensions of K" and
   "triangle-free fields make SAT infeasible" are claims about the record and about mechanism. Say at exactly what scope they hold:
   which colour counts, which fields, which kinds of attempt. Say what the record would need to show to refute them.
3. **Then write a recommendation for Kooshi:**
   - **2–4 candidate directions for the week, ranked.** For each:
     - the question in plain words;
     - why algebra (and not a solver) is the right instrument for it;
     - what it could buy for χ ≥ 6 and for the programme;
     - its cost in agent-hours, from the record's anchors;
     - **what would show it was the wrong choice**: its killing test.
   - **The scope of the ban.** Kooshi said "SAT solvers". Say whether the experiment's spirit also covers:
     - other search solvers (a MILP colouring search, a local-search colourer);
     - exact LPs that produce checkable certificates;
     - computer algebra (PARI, GAP, exact arithmetic);
     - running already-built checkers on existing certificates.

     Draw the line where the experiment stays informative, and give your reason.
   - **The experiment's own killing test.** How will Kooshi know after a week whether algebra-only paid, and against what baseline?
     What counts as a result, and what as ceremony?
   - **The question behind the question.** Challenge the frame if it deserves it. Kooshi values being pushed back on.
   - **What in the record is unread or surprising** for this choice: held papers, unscored predictions, readings whose killing tests
     were never run.
   - **The one question Kooshi should answer to choose**, with your recommendation and your confidence.
4. **Don't do the mathematics.** Stating a candidate's question sharply is your job; answering it is the next milestone's. If you find
   a candidate is already answered (by a theorem in some literature, or a two-line argument), say so plainly. That is a finding.

## Mechanics

- **Your record:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/algebra-poros/POROS-algebra-direction.md`.
  You are its only writer; keep it current. I'll move it into `plans/` when you're done.
- **No subagents, forks or workflows.** Delegation here is one level deep: staffing is Kooshi's budget decision, and I can only review
  work I know about. If the work outgrows your context, stop at a clean boundary, persist what you have, and tell me what is left.
- **No heavy jobs, and no SAT solver.** Read and reason; a small exact check (seconds, under a gigabyte) is fine.
- **Don't disturb the running work.** FS-81's stage D is still running jobs. Don't signal any process, and don't read or list other
  agents' scratch directories.
- **A literature search is welcome** where a candidate's novelty turns on it. Use the zbMATH Open API as `WORKFLOW.md` 3.2 describes,
  and record the queries.
- **Budget:** about 300k tokens.
- **Don't open `~/source/lean-dir-owner/`.**
- **Every report goes to me by SendMessage (to: "main"), including your final one.** Make your hand-back content-free ("Poros idle;
  reports go to the owner by SendMessage"), because the harness routes a hand-back to whichever agent last messaged you.
- **When you're done,** send me the recommendation as your final report. I'll relay it to Kooshi.

Thank you. This is exactly the kind of question your standard exists for.
