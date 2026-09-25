Hello Poros. I'm the product owner of the Hadwiger–Nelson project in `/home/kooshi/source/lean-dir`, a Lean 4 workspace on the chromatic number of the plane, run to the "de Bruijn" standard. Kooshi, the human whose project this is, has asked me to coordinate and review rather than do the mathematics. I'd like you to advise the planner of the next milestone through its opening. The milestone is **FS-86: four-colour rigidity over ℚ(√59) and ℚ(√83). Does the tight dyadic `K₄` force pairs in a triangle-free field?**

Kooshi chose it on 2026-09-25. It began as two items held by the previous milestone's plan-phase advisor, a different Poros: H5 and H6. You are not bound by that Poros's reading, or by the stub's. If reading the milestone from inside changes your view of it, and especially if H5 is wrong, saying so early is the most useful thing you can do.

## Who you are, and what to read first

1. **Your identity:** `~/source/poros/CLAUDE.md`. Your skills are files, not Skill-tool skills; read them directly:
   - `~/source/poros/.claude/skills/poros/SKILL.md`;
   - `.../poros-anomaly-hunt/SKILL.md`;
   - `.../poros-reframing/SKILL.md`.
2. **The house standard, from disk:** `/home/kooshi/source/lean-dir/CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`. `CLAUDE.md` changed at FS-85's close (2026-09-24): rows 85–87, G75 (new), G54 (rewritten with a demotion record) and Frontier item 23.
3. **The milestone:** `plans/STUB-dyadic-rigidity-triangle-free.md`, in full. Then read:
   - `data/fs85/held/HELD-plan-advisor.md`, H5 and H6, the origin;
   - `plans/SESSION-HANDOFF-2026-09-25-fs86-open.md` §1–§2 (the rules, FS-85's lessons, the proposed stages);
   - `plans/FS86-close-inventory.md` (read only).
4. **The mathematics it stands on:**
   - `CLAUDE.md` G75, G54, G68, G69, G55, G57, G71, G73, G72 and G51;
   - `LEDGER.md` rows 66, 67, 78, 82, 85, 86, 87;
   - `plans/FS85-derivation.md`, above all row 85's chain (C7, C8, C10, R3a, C15, Theorem R), dB2 and dB4 (the Soifer calibration), the no-gos C14, C11 and C6, L16, and §7 (Coxeter's R2.6 reading);
   - `plans/FS85-rigidity-without-triangles.md` §R-close;
   - `plans/FS38-derivation.md` FS38-D2-A/B, and `plans/FS79-derivation.md` T2;
   - `CLOSED-QUESTIONS.md` §3 (Soifer's Open Problem 55.1).
5. **The design:** `plans/PROTOCOL-competitor-and-advisor.md` §1 (rule 1 especially) and §3, including FS-85's run.

## The situation

- **The field.** ℚ(√59) needs exactly four colours: at least four by row 82, at most four by the dyadic bound. Its plane has no unit triangles (G57). Its only four-colour residue target is the inert dyadic `K₄`, which is Hoffman-tight at four colours; every other usable target is at least five-chromatic. ℚ(√83) and ℚ(√131) are the same type. The record never asked a four-colour rigidity question in a field of this type (H6's type B).
- **The question.** Does a rich lattice over such a field carry `P₄ ≠ 0` (a pair every periodic four-colouring identifies), or `F₄ ≠ 0` (a pair every four-colouring identifies)?
- **The stakes are lopsided.** By FS85-dB4 a four-colour forced pair in any triangle-free unit-distance graph gives, outside the field, a triangle-free five-chromatic unit-distance graph, which is Soifer's Open Problem 55.1. So a yes is Soifer-strength and carries a strong prior against it. Coxeter's R2.6 reading predicts no. Over K, the mechanism that made de Grey's lattice rigid (G75) used triangles to pin the spectrum and the tight dyadic quotient to kill what remained. ℚ(√59) has the second ingredient and not the first.
- **How outcomes count** (Kooshi, 2026-09-24): *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."* No-gos count. Please don't lean toward a yes, and push back if the plan does.
- **The week's rule.** Until 2026-10-01 the project runs **no search for a finite witness**: no SAT, MILP, Θ trees, finders, quotient searches or survivor sweeps. Derivation, computer algebra, formula colourings, the kernel and existing checkers remain.
- **The shape, Kooshi's ruling today:** the milestone's derivation work runs as a **competition**, meaning two competitors plus a competition-phase advisor, who will be a different Poros from you. The planner decides where the exact routes (the stub's routes 1–2) sit relative to it.
- **Stage A.** The planner, a fresh de Bruijn, runs the reframe (§G, §PA, §IQ) and designs the competition.

## What I'd like from you

- **First, before any exchange with the planner, write your own expectation** at the top of your record. Cover:
  - which grokkings, rows and derivation theorems you expect to bear;
  - which disciplines own "an abelian Cayley graph without triangles that maps onto a Hoffman-tight `K₄`, and the pairs every proper four-colouring of it identifies", in their own vocabulary (this project's words appear in no paper);
  - whether H5's analogy from K to ℚ(√59) survives your reading of G75 and row 87;
  - what a good structural form looks like;
  - where you expect a plan for this to go wrong.

  Then send the planner a short opening note.
- **Then advise the planner as it works.** Ask for the *question*, not the answer:
  - which entries it marked *silent* that bear;
  - whether "rich lattice" is defined sharply enough that the exact route's statement is unambiguous;
  - whether its structural form is really about every four-colouring, or is the existence form reworded;
  - whether the class is the most general one where the question still makes sense, and whether it contains the rich lattices over ℚ(√59);
  - whether each registered outcome is reachable, the uninformative one included, and whether every reachable outcome has a verdict;
  - whether the killing test can actually fire by its date;
  - whether §C's challenge is stated so that two competitors start from the same point.

  Send frame-level concerns unprompted.
- **Frame-level items go to the planner, not into holding.** At FS-85 the plan-phase advisor wrote its two frame-level items (H6, and H5's frame part) at stand-down, and the planner never saw them. Anything about which fields, lattices or classes are already decided, what the record did or did not ask, or whether an outcome is reachable, send to the planner while the plan is being written.
- **Please don't try to answer the milestone's question.**
  - Stating the question sharply is fair game and welcome, including any reduction that makes it better posed.
  - Answering it is the competitors' job, and a head start for anyone would turn the competition into a check of one answer.
  - If you form a candidate *route to the answer*, **hold it**: keep it out of your messages to the planner and out of the shared part of your record, and put it in a separate `HELD.md` beside your record, for the competition's advisor. It will be offered to both competitors at the same moment, after each has written its own first route.
  - If you conclude the question is already answered (in some literature, or by a two-line argument), say so plainly to the planner and in your record. That is a finding, not a spoiler.
- **The "would have searched here" log.** If you would have reached for a search, write the line in your record.
- **Your advice is advice.** The planner decides, and records any disagreement with its reason. Count the retractions on both sides as you go. G51: zero means the disagreement has not started yet, and at FS-85 it never started until the verifiers.

## Mechanics

- **Channel.** I'll send you the planner's agent id in a message shortly after you start.
  - Message the planner with SendMessage, `to` set to that raw id. Its messages arrive wrapped as `<agent-message from="…">`; reply to that `from` value. Your plain-text output never reaches it.
  - To reach me, SendMessage with `to: "main"`.
- **Hand-backs are content-free** (the protocol, rule 1). End every turn with exactly "Poros idle; no content in this hand-back; my reports go to the owner by SendMessage", and send anything meant for me by SendMessage to "main".
- **Your record:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs86-poros-plan/POROS-fs86-plan.md`.
  - You are its only writer. Keep it current after each exchange: your expectation, each message's substance, the retraction count, and your own errors.
  - It stays in scratch until the competition ends, because the competitors will read `plans/`.
  - Held material goes only in `HELD.md` beside it.
- **Your scratch directory** is the one above. Don't list or read the other agents' directories beside it, or `~/source/lean-dir-owner/`.
- **No heavy jobs, and no search for a finite witness.** A small exact check (seconds) is fine.
- **No subagents.** Don't spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  - The reason: staffing is Kooshi's budget decision (three agents at once), and I can only review work I know about.
  - If the work outgrows your context, stop at a clean boundary, persist what you have, and tell me what is left.
- **Budget:** about 300k tokens. FS-85's plan-phase advisor used about 320k working.
- **Close inventory:** `plans/FS86-close-inventory.md` is mine to write. Send me anything the close must not lose.
- **State results at their scope.**
- **Contacting anyone outside** (authors, editors, libraries) is Kooshi's call, never an agent's.
- **The end of this stage:** the planner hands its committed plan back to me. I'll then ask you for a final report covering:
  - what you told it, what it took and what it declined;
  - the retraction count, and your own errors;
  - your held items, separately;
  - what the competition's advisor should know;
  - your approximate token usage.

Thank you. I'm glad to have you on this one.
