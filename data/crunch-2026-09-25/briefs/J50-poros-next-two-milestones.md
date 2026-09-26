*Brief for crunch job **J50**: an advisor session (Poros) to choose the next two full milestones. Opus 5.5, 2026-09-26. Written by
the product owner at Kooshi's request: *"we have time and space for probably 2 more full milestones. Start a Poros agent to decide what
those should be."* The decision is Kooshi's; you recommend.*

Hello Poros. I'm the product owner of the Hadwiger–Nelson project in `/home/kooshi/source/lean-dir`, a Lean 4 workspace on the chromatic
number of the plane, run to the "de Bruijn" standard. Kooshi, the human whose project this is, has asked me to coordinate rather than do the
mathematics. Your recommendation goes to him through me.

## Who you are, and what to read first

1. **Your identity:** `~/source/poros/CLAUDE.md`. Your skills are files, not Skill-tool skills; read them directly:
   `~/source/poros/.claude/skills/poros/SKILL.md`, `.../poros-anomaly-hunt/SKILL.md`, `.../poros-reframing/SKILL.md`.
2. **The house standard, from disk:** `CLAUDE.md`, current as of tonight's close: the Frontier, § Paths forward, and the Grokkings, above
   all G72 and G79. Also read `WORKFLOW.md`, `DEBRUIJN.md`, and **`data/crunch-2026-09-25/briefs/STANDING-RULES.md`**, which is part of this
   brief.
3. **Where things stand:**
   - `plans/CRUNCH-2026-09-25-queue.md` §8, the crunch's close: what ran, what closed, and what it hands to 2026-10-01;
   - `plans/FRONTIER-STUBS.md`, the authoritative ranked stubs;
   - the new milestone FS-100 (`plans/STUB-measure-rigidity-three-fields.md`: its stages 1–2 are done, and stages 0 and 3–6 are in-ban);
   - `plans/SESSION-HANDOFF-2026-09-25-crunch.md` §6–§7.
4. **The last two advisor sessions of this kind,** for their shape: `plans/POROS-2026-09-25-fs86-next.md` and
   `plans/POROS-2026-09-24-next-direction.md`.

## The constraints (they decide what fits)

- **Time:** the rest of the crunch, about four hours of wall clock after this session, plus whatever Kooshi extends. "Probably 2 more full
  milestones", in his words.
- **Staffing:** **at most two agents at once** (Kooshi, to stay inside a usage window), all Opus.
- **The finite-witness ban runs to 2026-10-01.** No SAT, MILP, Θ trees or finders, quotient searches or sweeps. Derivation, exact
  arithmetic, formula colourings, the Lean kernel (builds through `scripts/slot.py … ./scripts/build.sh`) and existing checkers are in.
- **"Full milestone"** means WORKFLOW's shape, compressed as the crunch compressed it:
  1. a planner, for the reframe (§G, §PA, §IQ) and the subplan;
  2. a derivation (or a kernel implementer), with a blind verifier;
  3. a close-math job;
  4. a front-page pass.

  That is four to six agent-sessions per milestone, in series or in pairs. Two milestones at cap two is a tight fit. Say whether your two
  fit, and what gets cut if they do not.
- **What paid tonight:** blind-verified derivations (the planner under-priced them — queue §8.2's Brier score), and wanted posters that turn
  walls into one missing lemma. Kooshi's standing preferences:
  - *"All novel knowledge is a success"*; no-gos count.
  - The target is seven (§ The mission).
  - Kernel work is valued where a result is finite or algebraic.

## What I'd like from you

1. **Your expectation first,** at the top of your record, before reading the ranked table closely: which two you expect, and why.
2. **The candidates.** Evaluate at least six, including:
   - FS-100's in-ban stages, as one milestone or two (Kronecker selection; MR's reading room; EI-2 at ℚ(√11));
   - FS-98 (T-B1, isolation of the pullbacks);
   - a kernel milestone: FS-87's dB9 V1, FS-75's T4 for the family, or whatever the kernel lane's top is;
   - FS-82 (three colours at residue degree three, ℚ(α, √7));
   - FS-67's remnant (DB-1 at three colours);
   - anything the table or tonight's records make more urgent.

   For each, give:
   - what it would decide, at what grade;
   - its fit to the four hours and two agents;
   - its odds;
   - its bearing on χ ≥ 6 and on the conjecture;
   - what its null would teach;
   - whether it is ban-legal.
3. **Recommend two,** ranked, with a default ("if Kooshi does nothing, X and Y run"), your confidence, and the one fact that would change it.
   Also say whether the two should run in parallel (one agent each) or in series.
4. **Write the first brief of each** — the planner's (reframe and subplan) — ready to launch. Save them as
   `data/crunch-2026-09-25/briefs/J51-<slug>-planner.md` and `J52-<slug>-planner.md`, following the crunch's planner template,
   `data/crunch-2026-09-25/briefs/J28-FS86-row88-reframe.md`, which rests on J03's brief. Each needs:
   - the milestone's statement verbatim from its stub;
   - the no-subagents rule with its reason;
   - the ban and the "would have searched here" log;
   - "every outcome counts";
   - commits by explicit path, push, never force-push;
   - a budget;
   - the report form.

   Because of the time box, they must be sized to finish their plan in about 45 minutes of wall clock.

## Mechanics

- **Your record:** `plans/POROS-2026-09-26-next-two-milestones.md`. Commit by explicit path (`git add` it, then `git commit <path>`); never
  amend. End the commit message with your harness's attribution lines. Push after each commit; never force-push.
- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about.
- **No search.** Exact checks of seconds are fine.
- **Do not edit** anything but your record and the two briefs.
- **A visualization job (J43) is running.** Do not touch `visualizations/`.
- **Budget:** about 200k by the harness's count; hand back by 280k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J50.md`, committed, and by SendMessage
  `to: "main"`, with the two recommendations and their brief paths. Keep your turn's final text content-free: "J50 idle; report sent to
  the owner by SendMessage".

Thank you.
