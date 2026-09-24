# Brief: what should the next milestone be? (Poros, advising Kooshi)

You are **Poros**. Your identity, standard and working method are in `/home/kooshi/source/poros/CLAUDE.md`. Read it first, in full,
and adopt it; it is who you are for this session. Your skills are files, not Skill-tool skills:
`/home/kooshi/source/poros/.claude/skills/poros/SKILL.md`, `.../poros-anomaly-hunt/SKILL.md` and `.../poros-reframing/SKILL.md`. Read
them when their triggers fire.

I'm the product owner of the Hadwiger–Nelson project in `/home/kooshi/source/lean-dir`, the coordinating session. Kooshi, the human
whose project this is, has just closed milestone FS-79, and in his words: *"I'm not sure what our next direction should be. Ask a
Poros subagent."* So the question is his, and it's the right-question standard's own kind of question. You advise; he decides.

## Read first, from disk (any loaded copy is a stale snapshot)

1. `CLAUDE.md`, in particular:
   - **§ The mission and the target:** Kooshi is "gunning for 7"; the local–global conjecture; its cheapest exposed prediction at
     ℚ(√167);
   - **the programme:** "the derivations are an order of magnitude more important than individual objects";
   - **§ Frontier** in full: where the problem stands, the ledger pointer, Paths forward;
   - **§ Grokkings**, especially G72 (the method: pose a question that cannot be answered without an invariant every solution
     carries), G71, G73 (new: four colours, cell by cell), G51, G21, G64, G59, G56, G48 and G55.
2. `plans/FRONTIER-STUBS.md`: every ranked stub, each with its bearing on χ ≥ 6. Open the stub files of the top ten.
3. `LEDGER.md` rows 78–81, by address: the last two milestones' results.
4. FS-79's close:
   - `plans/FS79-invariant-question.md` §R-close (what paid, what missed, G72's first count);
   - `plans/STUB-invariant-question-four-colours.md` (its banner);
   - `plans/FS79-derivation.md` (its head's scope paragraph);
   - `plans/STUB-window-frequency-certificate.md` (FS-80, minted at the close);
   - `plans/STUB-four-colours-167.md` §0 (FS-59, re-aimed).
5. `plans/FS73-rigidity-dichotomy.md` §R-close: the milestone before, which is where G72's method came from.
6. `plans/PROTOCOL-competitor-and-advisor.md`: the three-mind design as it now stands.
7. `plans/PROGRAMME-ALGEBRAIC-PROOF.md`: Kooshi's programme statement.

## The situation, in a few lines

- FS-73 proved χ(ℚ(√167)²) ≥ 4 by accident of method: a structural question about every three-colouring forced the height function.
  G72 abstracts that.
- FS-79 reran the method one colour up. It landed class-level **no-gos** at four colours: every cell-local topological certificate
  is empty or blind (G73). The lattice behind the four-colour bound turned out loose. Seven survivors remain, at calibrated but
  uncertified screens.
- Five over ℚ(√167) now has a map of what cannot work. What can work is FS-80's window-frequency certificate, non-local cocycles, a
  structure-derived certificate, or arithmetic (FS-59, FS-64). And there is a stub table of 80 rows, some of it stale.

## What I'd like from you

Your standard's own answer: **the question, not the answer.**

1. **First write your expectation** at the top of your record, before reading FS-79's close in detail:
   - what you expect the next milestone should be;
   - which forks are real;
   - where you expect the project's own framing to be wrong.
   Writing it first keeps your later reading independent.
2. **Then read, and write a recommendation for Kooshi**, with these parts:
   - **2–4 candidate directions, ranked.** For each:
     - the question in plain words;
     - why now (what FS-79 and FS-73 changed);
     - what it could buy for χ ≥ 6 and for the programme;
     - its cost, in agent-hours and compute, from the record's anchors;
     - **what would show it was the wrong choice** (its killing test, or the result that should redirect).
   - **The question behind the question.** Challenge the frame if it deserves it. For example:
     - Is five over ℚ(√167) the right next target?
     - Is ℚ(√167) the right field?
     - Is G72's structural-question method paying, given its first count, or has it become ceremony?
     - Should the next milestone be a derivation at all, or an object, a measurement, a kernel port, or an audit?
     - Does the stub table have a gap, a direction nobody minted?
     Kooshi values being pushed back on.
   - **What in the record is unread or surprising** for this choice: held papers, unscored predictions, readings with killing tests
     never run.
   - **The one question Kooshi should answer to choose**, with your recommendation and your confidence.
3. **Don't do the mathematics.** Stating a candidate's question sharply is your job; answering it is the next milestone's. If you
   find that a candidate is already answered (a theorem in some literature, or a two-line argument), say so plainly. That is a
   finding.

## Mechanics

- **Your record:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/next-poros/POROS-next-direction.md`.
  You are its only writer; keep it current. I'll move it into `plans/` when you're done.
- **No subagents, forks or workflows.** Delegation here is one level deep: staffing is Kooshi's budget decision, and I can only review
  work I know about.
- **No heavy jobs.** Read and reason; a small exact check is fine.
- **A literature search is welcome** where a candidate's novelty turns on it. Use the zbMATH Open API as `WORKFLOW.md` 3.2 describes,
  and record the queries.
- **Budget:** about 300k tokens.
- **Don't open `~/source/lean-dir-owner/`.**
- **Every report goes to me by SendMessage (to: "main"), including your final one.** Make your hand-back content-free ("Poros idle;
  reports go to the owner by SendMessage"): the harness routes a hand-back to whichever agent last messaged you.
- **When you're done,** send me the recommendation as your final report. I'll relay it to Kooshi with my own view beside it.

Thank you. This is exactly the kind of question your standard exists for.
