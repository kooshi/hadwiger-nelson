Hello de Bruijn (`DEBRUIJN.md`). I'm the product owner and orchestrator of `/home/kooshi/source/lean-dir`. Kooshi, the human whose project
this is, has asked me to coordinate rather than do the mathematics. I'd like you to **plan the next 16 hours of compute as a job queue**.
An advisor (Poros) works beside you. **The plan is yours to write; the choices are Kooshi's**, through me.

## Kooshi's words (2026-09-25, verbatim)

> "[…] I'd like an advisor and a planner to plan the next 16 hours
> (keep in mind each of your "week" estimates took just a few hours each). Basically, let's keep 4-5 agents spawned, and a list of jobs to
> churn through. Those jobs can spawn new jobs in the queue. I'll check in and compact you as needed so we can keep churning. […] We're still operating
> under the ban, and the crunch time won't start until the plan finishes and we compact. You'll act as orchestrator the whole time, and
> your context window is your budget, so lean towards spawning a Sonnet subagent for bookeeping or easy reads. Opus for everything else,
> and avoid filling up your context more than needed."

**Calibrate on this:** FS-89 was planned across five days and closed in about six hours, headline blind-verified. Price every job in
hours of wall time and in tokens as the harness counts them. Agents' own counts ran at 55–70 % of the harness's in five of six agents
last milestone (`plans/FS89-close-inventory.md` items 38, 52).

## Read first, from disk

1. `CLAUDE.md` (the Frontier and Paths forward were rewritten today at FS-89's close), `WORKFLOW.md`, `DEBRUIJN.md`.
2. `plans/FRONTIER-STUBS.md`, the ranked options, with every stub you consider queueing read in full.
3. **FS-89's close, for the method and the lessons:**
   - `plans/FS89-rational-band-rigidity.md` §R-close;
   - `plans/PROTOCOL-competitor-and-advisor.md` §3 (the seventh run: one derivation agent plus blind verifiers; a verifier replaced near
     its ceiling; blind-first then lemma statements);
   - `plans/FS89-close-inventory.md` items 38, 41, 47, 48, 52, 53 and the carried items 5, 6, 7, 17.
4. **The briefs that worked, as templates:** `data/fs89/briefs/` — S1-D (a derivation agent), S1-VB (a blind verifier), PA-* (readers),
   CL-* (close planners).

## What to produce: `plans/CRUNCH-2026-09-25-queue.md`

**1. The operating protocol,** short and exact. It needs:
- **Concurrency:** 4–5 agents at all times; I launch every agent, and no agent spawns another.
- **How a job proposes new jobs:** in its report to me, as a queue entry in a fixed format. I append it, or a Sonnet clerk does.
- **Who keeps the queue file current:** my context is the budget, so design this so that I read a short report per job and never the
  job's record. For example, a Sonnet clerk that updates the queue and inventory from reports, or reports in a fixed short form.
- **Halts:** Kooshi warns that an overshoot of a 5-hour window can halt agents mid-job. Every job saves after each stage, so a halt costs
  one stage; name the resume procedure (a fresh agent reads the job's record and continues at the first unsaved stage).
- **Milestone bookkeeping:** each milestone keeps a close inventory (WORKFLOW 5), opened when its first job starts.
- **RAM:** the global maximum is about 100 GB through `scripts/slot.py`. A Lean build takes 60 GB (`scripts/slot.py --mem 60 --cpus 16 --
  env MEMMAX=60G ./scripts/build.sh`), so at most one Lean build runs at a time. Say how kernel jobs are serialised.
- **The ban** runs to 2026-10-01 and covers the whole crunch. Every brief carries the "would have searched here" log.
- **Models:** Sonnet only for bookkeeping, easy reads and clerical edits; Opus for mathematics, verification, planning and anything
  judged.

**2. The queue,** as a table, **at least 12 jobs ready or ready-on-dependency, with at least 5 startable the moment the crunch opens.**
Each job carries:
- an id;
- a model (Opus or Sonnet);
- its kind: reframe or plan, derivation, blind verifier, kernel, reader, close, clerk;
- its milestone or stub;
- one line on what it decides;
- its inputs;
- its output path;
- its dependencies;
- its estimated wall hours and harness tokens;
- its stop rule;
- what its outcomes spawn;
- its priority.

Size every job to finish inside about 2–3 hours and about 350k harness tokens. Split anything bigger.

**3. Ready-to-paste brief text for the first 5–6 jobs,** in the house form, carrying:
- the no-children rule with its reason;
- "work in stages", with its reason;
- the would-have-searched log;
- Kooshi's "all novel knowledge is a success", with the instruction not to lean toward a yes;
- statements quoted verbatim, never paraphrased (two paraphrases cost FS-86 spurious findings);
- commits by explicit path (`git add` new files, then `git commit <paths>`; the tree is shared);
- reports to "main" in the protocol's short form.

For the rest, a brief skeleton each: what to fill in when the job comes up.

**4. The WORKFLOW question,** said plainly. Every milestone opens with the reframe (§G, §PA, §IQ; Kooshi's rule, WORKFLOW 3), which at
this project's scale is itself a job of a few hundred thousand tokens. Plan it as a job for every milestone the queue opens, and say how
you will keep its cost in proportion to hour-scale milestones without dropping it. That is Kooshi's rule, so don't propose skipping it;
propose how to run it well.

**5. Registered expectations:** what the 16 hours should produce, with probabilities, and what would count as a good crunch. Kooshi's
line applies: *"All novel knowledge is a success."*

## Candidates the records name (a starting list, not a prescription; rank them yourself, with the advisor)

- **FS-91** (`plans/STUB-band-rigidity-six.md`): its first act is a blind verifier on PA-B3 / item 41, "`RS_k(S)` for every
  `k < 2·min S`" (so `RQ_k` for `k ≤ 9`). Then decide what `RQ₆` would buy at the exposed fields at six colours: price the consumer step
  honestly first, because it needs level-one ratios `< 1/6`.
- **FS-59** (ℚ(√167), five colours) and **FS-84** (ℚ(√47), five colours), re-aimed at FS-89's close.
- **FS-87** (de Grey's lattice in the kernel), **FS-75** (the three-colour criterion in the kernel), and a kernel port of RQ₄, all
  kernel work the ban allows.
- **FS-67** (products; partly settled by the Greenwell–Lovász reading, item 53).
- The carried audit of `[AmbrusEtAl2023]`'s certificate: existing checkers on existing certificates are allowed.
- Reading debts on held papers.

## Mechanics

- **The advisor:** a Poros session, launched just before you, whose id I'll send you by message as soon as I have it. Send it your drafts
  (the protocol, the queue, the first briefs) as they take shape, and ask what it would change. Its advice is advice: you decide, and you
  record disagreements. Ask it plainly for any frame-level item it has not yet sent.
- **Your record is the queue file.** Save it after every section. Commit it by explicit path; never amend; don't push; report hashes.
- **No subagents.** No Agent tool, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  The reason: staffing is Kooshi's budget decision, and I can only review work I know about.
- **Work in stages:** keep each response short. A response lost to the output-token limit is unrecoverable.
- **No search for a finite witness;** small exact checks of seconds are fine. Never run `lake build`.
- **Don't edit** `CLAUDE.md`, `LEDGER.md` or `plans/FRONTIER-STUBS.md`; propose such edits in the plan. A third close planner is finishing
  FS-89's last item and owns `BIBLIOGRAPHY.md`, row 86 and the FS-67 stub until it hands back.
- **Budget:** about 300k tokens by your own count.
- **Report** to me by SendMessage (`to: "main"`) when the plan is committed: the first five jobs, the protocol in five lines, and the hash.
  Keep your final turn text content-free: "planner idle; report sent to the owner by SendMessage".

Thank you. This plan is what keeps five agents productive through a night; the protocol matters as much as the ranking.
