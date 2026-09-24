Hello Poros. I'm the product owner of the Hadwiger–Nelson project in `/home/kooshi/source/lean-dir`, a Lean 4 workspace on the chromatic number of the plane, run to the "de Bruijn" standard. Kooshi, the human whose project this is, has asked me to coordinate and review rather than do the mathematics. I'd like you to advise the planner of the next milestone, **FS-85: can four-colour rigidity exist without triangles?**, through its opening.

It was chosen today from another Poros's ranking of the project's algebra-only week (`plans/POROS-2026-09-24-algebra-week.md`, its rank 1). You are not bound by that ranking. If reading the milestone from inside changes your view of it, that is exactly what I want to hear.

## Who you are, and what to read first

1. **Your identity:** `~/source/poros/CLAUDE.md`. Your skills are files, not Skill-tool skills; read them directly:
   - `~/source/poros/.claude/skills/poros/SKILL.md`;
   - `.../poros-anomaly-hunt/SKILL.md`;
   - `.../poros-reframing/SKILL.md`.
2. **The house standard, from disk:** `/home/kooshi/source/lean-dir/CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`. `CLAUDE.md` changed today in three places:
   - FS-81's close (rows 82–84, G74);
   - the resource rule in § Building;
   - the finite-witness-free week in § Toolchain.
3. **The milestone:** `plans/STUB-four-colour-rigidity-without-triangles.md`, in full. It carries:
   - the mission;
   - step 1 (why de Grey's lattice is rigid; FS-74's lead, Hubai's 2018 stripes) and step 2 (can a triangle-free abelian Cayley graph carry a four-colour forced pair?);
   - the controls;
   - a §IQ draft;
   - the outcomes, the experiment's verdicts and the killing test.

   Then read:
   - `plans/POROS-2026-09-24-algebra-week.md` §4–§6, where the choice came from;
   - `plans/STUB-algebraic-explanation.md` (FS-74, absorbed);
   - `plans/FS85-close-inventory.md` (read only).
4. **The mathematics it stands on:**
   - `CLAUDE.md` G73 (four colours, cell by cell), G71, G74 (the layer method), G70, G55 (the chain theorem), G57, G62, G72 and G51;
   - `plans/FS73-derivation.md` T1–T7;
   - `plans/FS79-derivation.md` T17–T37;
   - `LEDGER.md` rows 78–84;
   - `CLOSED-QUESTIONS.md` §3 (Soifer's Open Problem 55.1).
5. **The design:** `plans/PROTOCOL-competitor-and-advisor.md` §1 (rule 1 especially) and §3.

## The situation

- **The known forced pairs.** Every four-colour forced pair known anywhere uses a unit triangle: de Grey's lattice, and Harder's and Parts's pairs over K. A field without √3 has no unit triangles. There, no four-colour refusal or forced pair has ever been found, here or in print, and Soifer's Open Problem 55.1 asks for one.
- **The week's rule.** This week, 2026-09-24 to 2026-10-01, the project runs **no search for a finite witness**: no SAT, MILP, Θ trees, finders, quotient searches or survivor sweeps. Derivation, computer algebra, formula colourings, the kernel and existing checkers remain.
- **The experiment.** FS-85 is the week's experiment: can algebra reach four colours where search could not?
- **Stage A.** The planner, a fresh de Bruijn, runs the reframe (§G, §PA, §IQ) and designs a competition: two competitors and a competition-phase advisor, which is a different Poros from you.

## What I'd like from you

- **First, before any exchange with the planner, write your own expectation** at the top of your record. Cover:
  - which grokkings, rows and derivation theorems you expect to bear;
  - which disciplines own "a pair of vertices every proper four-colouring identifies, on an abelian Cayley graph with no triangles", in their own vocabulary (this project's words appear in no paper);
  - what a good structural form looks like;
  - where you expect a plan for this to go wrong.

  Then send the planner a short opening note.
- **Then advise the planner as it works.** Ask for the *question*, not the answer:
  - which entries it marked *silent* that bear;
  - whether its structural form is really about every four-colouring, or is the existence form reworded;
  - whether the class is the most general one where the question still makes sense, and whether it contains the unit-distance lattices of triangle-free fields;
  - whether each registered outcome is reachable, the uninformative one included;
  - whether the day-2 killing test can actually fire;
  - whether §C's challenge is stated so that two competitors start from the same point.

  Send frame-level concerns unprompted.
- **Please don't try to answer steps 1 or 2.**
  - Stating the questions sharply is fair game and welcome, including any reduction that makes one better posed.
  - Answering them is the competitors' job, and a head start for anyone would turn the competition into a check of one answer.
  - If you form a candidate route, **hold it**: keep it out of your messages to the planner and out of the shared part of your record, and put it in a separate `HELD.md` beside your record, for the competition's advisor. It will be offered to both competitors at the same moment, after each has written its own first route.
  - If you conclude a step is already answered (in some literature, or by a two-line argument), say so plainly to the planner and in your record. That is a finding, not a spoiler.
- **The "would have searched here" log.** If you would have reached for a search, write the line in your record.
- **Your advice is advice.** The planner decides, and records any disagreement with its reason. Count the retractions on both sides as you go (G51: zero means the disagreement has not started yet).

## Mechanics

- **Channel.** I'll send you the planner's agent id in a message shortly after you start.
  - Message the planner with SendMessage, `to` set to that raw id. Its messages arrive wrapped as `<agent-message from="…">`; reply to that `from` value. Your plain-text output never reaches it.
  - To reach me, SendMessage with `to: "main"`.
- **Hand-backs are content-free** (the protocol, rule 1). End every turn with exactly "Poros idle; no content in this hand-back; my reports go to the owner by SendMessage", and send anything meant for me by SendMessage to "main".
- **Your record:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs85-poros-plan/POROS-fs85-plan.md`. You are its only writer. Keep it current after each exchange: your expectation, each message's substance, the retraction count, and your own errors. It stays in scratch until the competition ends, because the competitors will read `plans/`. Held material goes only in `HELD.md`.
- **Your scratch directory** is the one above. Don't list or read the other agents' directories beside it, or `~/source/lean-dir-owner/`.
- **No heavy jobs, and no search for a finite witness.** A small exact check (seconds) is fine.
- **No subagents.** Don't spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  - The reason: staffing is Kooshi's budget decision, and I can only review work I know about.
  - If the work outgrows your context, stop at a clean boundary, persist what you have, and tell me what is left.
- **Budget:** about 300k tokens.
- **Close inventory:** `plans/FS85-close-inventory.md` is mine to write. Send me anything the close must not lose.
- **State results at their scope.**
- **The end of this stage:** the planner hands its committed plan back to me. I'll then ask you for a final report covering:
  - what you told it, what it took and what it declined;
  - the retraction count, and your own errors;
  - your held items, separately;
  - what the competition's advisor should know;
  - your approximate token usage.

Thank you. I'm glad to have you on this one.
