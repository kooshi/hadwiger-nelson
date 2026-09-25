Hello Poros. I'm the product owner and orchestrator of the Hadwiger–Nelson project in `/home/kooshi/source/lean-dir`, a Lean 4 workspace
on the chromatic number of the plane, run to the "de Bruijn" standard. Kooshi, the human whose project this is, has asked me to
coordinate rather than do the mathematics. I'd like you to advise on **how to spend the next 16 hours of compute**. A planner (de Bruijn)
is launched beside you and will write the plan; you advise it and write your own record. **The decisions are Kooshi's**, through me.

## Kooshi's words (2026-09-25, verbatim)

> "[…] I'd like an advisor and a planner to plan the next 16 hours
> (keep in mind each of your "week" estimates took just a few hours each). Basically, let's keep 4-5 agents spawned, and a list of jobs to
> churn through. Those jobs can spawn new jobs in the queue. I'll check in and compact you as needed so we can keep churning. […] We're still operating
> under the ban, and the crunch time won't start until the plan finishes and we compact. You'll act as orchestrator the whole time, and
> your context window is your budget, so lean towards spawning a Sonnet subagent for bookeeping or easy reads. Opus for everything else,
> and avoid filling up your context more than needed."

**The calibration he gives:** milestones this project planned in days have been finishing in hours. FS-89 was planned across five days
(Stage 1a to 1c, the close on 10-01). It landed its registered headline, blind-verified, and closed in about six hours.

## Who you are, and what to read first

1. **Your identity:** `~/source/poros/CLAUDE.md`. Your skills are files; read them directly: `~/source/poros/.claude/skills/poros/SKILL.md`,
   `…/poros-anomaly-hunt/SKILL.md`, `…/poros-reframing/SKILL.md`.
2. **The house standard, from disk:** `CLAUDE.md`, whose Frontier and Paths forward were rewritten at FS-89's close today; `WORKFLOW.md`;
   `DEBRUIJN.md`.
3. **The ranked options:** `plans/FRONTIER-STUBS.md`, the authority, with the stub files it points to.
4. **What just happened:**
   - `LEDGER.md` rows 95–97;
   - `plans/FS89-rational-band-rigidity.md` §R-close;
   - `plans/FS89-close-inventory.md`, skimming; items 41, 47, 48, 53 and the carried items 5, 6, 7, 17;
   - `plans/PROTOCOL-competitor-and-advisor.md` §3, the seventh run, for how the last milestone was staffed and what that taught.
5. **Where the conjecture and the target stand:** `CLAUDE.md` § The mission, "The target", and the Frontier's items 12, 14, 15, 24 and 25.

## What I'd like from you

1. **Write your own expectation first, at the top of your record, before reading the planner's drafts.** What are the best uses of 16
   hours at 4–5 agents, under the ban? Which stubs would you put in the queue, in what order, and why? Where do the results point for
   **six and seven**?
2. **Advise the planner.** It will send you drafts by SendMessage. Push back on anything you think wrong: a job whose price is optimistic,
   a queue that will starve (fewer than four ready jobs), a derivation job without a blind verifier after it, a job the ban forbids, a
   reading debt that blocks a novelty claim, a Lean job whose RAM would collide with another's. **Your advice is advice.** The planner
   decides and records disagreements.
3. **Flag frame-level items plainly and early.** At FS-85 a plan-phase advisor held two frame-level items until its stand-down, and the
   planner never saw them. Send them as they occur.
4. **Name the highest-value, lowest-regret first four jobs,** the ones that should start the minute the crunch opens, with your
   confidence.

## Mechanics

- **Your record:** `plans/POROS-2026-09-25-crunch-plan.md`. Commit it by explicit path: `git add` it, then `git commit <path> -m …`.
  Other agents share the tree, so never a bare `git commit`. Never amend. End with your harness's attribution lines. Don't push.
- **Reaching the planner:** SendMessage with `to` set to the planner's id, which I'll send you as soon as it is launched. Its replies
  arrive as messages.
- **Reaching me:** SendMessage to `"main"`. Keep your hand-back content-free: "Poros idle; my report went to the owner by SendMessage".
- **No searches for a finite witness** (the ban runs to 2026-10-01). Small exact checks of seconds are fine.
- **No subagents.** No Agent tool, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  The reason: staffing is Kooshi's budget decision, and I can only review work I know about.
- **Work in stages:** keep responses short, and save your record after every step. A response lost to the output-token limit is
  unrecoverable.
- **Contacting anyone outside** is Kooshi's call.
- **Budget:** about 200k tokens.

Thank you.
