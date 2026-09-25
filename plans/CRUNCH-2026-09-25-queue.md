# The crunch queue — 16 hours at 4–5 agents (planned 2026-09-25)

*Planner: de Bruijn (Opus 5.5), from the owner's brief `data/crunch-2026-09-25/briefs/PLN-crunch-planner-brief.md` (commit 3304d902).
Advisor: Poros, whose record is `plans/POROS-2026-09-25-crunch-plan.md`; its items are marked **[P-Fn]** where they changed this plan, and
§6 records where I disagreed. The plan is mine; the choices are Kooshi's, through the owner.*

**What this crunch can and cannot do (said first, per the advisor's F5).** It cannot land a lower bound above five. Such a bound needs a
finite witness, which the ban forbids to 2026-10-01, or a certificate that is not cell-local (G73), and none is in reach. What it can do:
- **prove class theorems about character colourings**: the conjecture at `L ≤ 4` for every real number field, and the character form of
  the conjecture at four to nine colours. These confine where six (and any falsifier) can hide to colourings no character gives (G64, G76);
- **push on the four-colour wall** that every lower bound above five must cross (FS-76 in rank one);
- **pay grade debt**: the ban window produced 171 hand theorems and no Lean change (FS-89 §R-close.9), so a kernel lane runs throughout.

---

## §1. The operating protocol

### 1.1 Concurrency and launching
- **Five agents at all times, four at the least.** The orchestrator (the owner) launches every agent; **no agent spawns another** — no
  Agent tool, fork or workflow (`CLAUDE.md` § Delegation; staffing is Kooshi's budget decision, and the owner can only review work it knows
  about). The Sonnet clerk (§1.3) counts as one of the five while it runs, and runs for minutes.
- **A launch is one line**: "Your brief is on disk: read `<brief path>` in full first." Every brief is a file under
  `data/crunch-2026-09-25/briefs/`, written by this plan (the first six) or by the job that proposed it (§1.2).
- **Open milestones: at most three at once**, and **no job consumes another open milestone's unverified claim** except as a hypothesis
  named in its statement ("given PA-B3, unverified"). *This needs Kooshi's word* (§7 item 1): WORKFLOW's "finish and commit a milestone's
  quality gate before reframing the next" forbids concurrent milestones [P-F3].
- **Stage 0 before a reframe is allowed** where a job verifies or derives a fixed statement that already exists (FS-89's precedent: the
  blind check of the advisor's gluing sketch and the band-set computation ran before its planner). It keeps agents busy while the reframe runs.

### 1.2 How a job proposes a job
In its report, one line per proposed job, in the queue's fixed format (§2's columns, `|`-separated):
`Q | id | model | kind | milestone | decides | inputs | output | deps | wall h | harness k | stop rule | spawns | priority`
**and** its brief as a file (`data/crunch-2026-09-25/briefs/<id>.md`), written in the house form from §4's skeleton, with every
statement it hands on **quoted verbatim with its source address** (two paraphrases cost FS-86 spurious findings). The receiving agent's
first act is to check each quoted statement against its source and log the result in its record's first section. The clerk appends the
line; the owner may reorder or decline it.

### 1.3 Who keeps the queue current — the owner reads one short report per job, never a record
- **Every job ends with a report in the fixed short form (≤ 12 lines)**, written to `data/crunch-2026-09-25/reports/<id>.md`, committed,
  and sent to `"main"` by SendMessage:
  ```
  JOB <id> — <DONE | STAGE n SAVED | HALTED at stage n | BLOCKED: reason>   harness≈<k> (own≈<k>)
  RESULT: <one line; per claim TRUE / FALSE / GAP-at-step, or the theorem's name and grade>
  RECORD: <path>   COMMITS: <hashes>
  INVENTORY: <n lines follow, each "kind — one line — source address">
  SPAWN: <n Q-lines follow, or "none">
  HELD FOR THE OWNER: <a decision or a slip, one line each; or "none">
  ```
- **The owner's cycle per report:** read the report (≤ 12 lines); read `data/crunch-2026-09-25/READY.md` (≤ 20 lines, the next launchable
  jobs in priority order); launch into the free slot; after every third report, or two hours, launch the clerk.
- **The Sonnet clerk (job J00, recurring, fresh each time).** It reads only the report files not yet folded, then: sets each job's status
  in §2's table; appends SPAWN lines to §2; appends INVENTORY lines to the milestone's close inventory (`plans/<M>-close-inventory.md`),
  creating it at the milestone's first job; rewrites `READY.md` (every job whose dependencies are DONE, by priority, then queue order);
  commits by explicit path. It never reads a record, never judges, never writes an agent id into any file, and never writes into a fenced
  file's content beyond appending inventory lines. **WORKFLOW 5 says the coordinator is the inventory's only writer; the clerk writes as
  the owner's pen, from reports only** — a deviation the owner authorises by launching it (§6).

### 1.4 Halts (a 5-hour window overshoot can stop an agent mid-job)
- **Every job saves after every stage**: its record gains the stage's section, headed `Stage n — SAVED`, committed by path, before the next
  stage starts. Working files that a successor needs live under `data/<milestone>/<job>/`, committed with the stage — never only in `/tmp`,
  which is RAM and dies with the session. A halt costs at most one stage.
- **Resume:** the owner launches a fresh agent of the same model **on the same brief file**. Every brief carries the same paragraph:
  *"If your record already exists, you are resuming: read it and the brief, check the last SAVED stage against `git log -- <record>`,
  and continue at the first stage not SAVED. Redo nothing saved."* A halted job's report is written by its successor, marked
  "resumed from stage n".
- **Near a window's end** (if Kooshi tells the owner when one ends): in its last 90 minutes launch only short jobs (the clerk, a verifier's
  single stage, a reader), never a derivation's first stage.
- **Replace, don't reuse:** a job budgeted at 350k harness hands back with its record saved by 420k; the owner reads the **harness's**
  count from the task notification, never the agent's own (agents under-counted at 55–70 % in five of six FS-89 agents; inventory item 52).

### 1.5 Milestone bookkeeping
- **A close inventory per milestone** (`plans/<M>-close-inventory.md`, WORKFLOW 5), opened by the clerk when the milestone's first job is
  launched, appended from reports only. Blind verifiers are fenced from it (it logs routes).
- **The close is two jobs** [P-F3, batched]: a **close-math** job per milestone (Opus: derivation file, §R-close, predictions scored,
  verdict, the ledger rows *drafted* in the plan), then a **front-page** job that applies every closed milestone's drafts at once.
- **Single-writer lanes.** `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md` and `BIBLIOGRAPHY.md` are written only by the front-page lane
  (J05 first, then J24 and J25), one job at a time; readers and closes propose rows in their records. A milestone is closed when the
  front-page job that carries it commits (WORKFLOW 9's rule that a close updates the Frontier).
- **CLAUDE.md's byte budget** stands at 274,995 of 275,000. The first front-page job (J05) compresses it without loss before any close
  writes to it, and every crunch close adds at most **4,000 bytes net** to it (details live in `LEDGER.md` rows and the plans; one home per
  fact). §7 item 2 records why a job, not a question to Kooshi.

### 1.6 RAM and the kernel lane
- **The global ceiling is about 100 GB**, enforced by `scripts/slot.py`. Any job over about 2 GiB or 2 minutes runs under
  `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>` with an honest `--mem`; `/tmp` and swap are RAM.
- **One kernel job at a time** (a Lean build takes 60 GB: `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`).
  The owner never launches a second kernel job while one runs; the kernel jobs are chained in §2 by dependency. Iteration uses
  `scripts/slot.py --mem 16 --cpus 4 -- lake env lean <file>` (it builds nothing; declare the measured peak after the first run). **Never
  `lake build`**, bare or named.
- **A slot refusal (exit 75 after 1,800 s)**: wait ten minutes and retry; never raise the cap or bypass the slot [P-F4]; after three refusals
  report BLOCKED.

### 1.7 The ban (2026-09-24 to 2026-10-01; the whole crunch)
- **Out:** SAT, MaxSAT, #SAT, MILP/CP, local-search colourers, `Θ` relation trees and float `Θ` finders, quotient-colouring searches,
  lattice sweeps hunting survivors — and **machine-long certificates** (FS-57's semidefinite runs at 47), which the list does not name but
  Kooshi's intent covers: *"The intent of the ban is to eliminate the crutch of feeling like we're accomplishing something by asking
  uncomputable problems for days at a time."* Not queued without his ruling [P-F6].
- **In:** hand derivation; exact arithmetic of seconds that checks a derived claim; existing checkers on existing certificates; the kernel.
  A complete exact enumeration of a finite set fixed by a derivation (FS-89's band-set computation, Kooshi's item-2 ruling) is in, and is
  logged.
- **Every brief carries the "would have searched here" log**: one line per move the agent would have made by search, and what it did
  instead.

### 1.8 Models
**Sonnet** only for the clerk and mechanical checks (§G completeness counts, report folding). **Opus** for every derivation, verification,
reframe, reading, kernel job and close.

### 1.9 The reframe, run well (Kooshi's rule; WORKFLOW 3) — the plan's answer to the brief's §4
Every milestone the queue opens is reframed first, as a job. Five devices keep it in proportion to hour-scale milestones without dropping
any part of it:
1. **One job runs WORKFLOW 3–6 end to end**: §G, §PA, §IQ, the subplan, the modeling passes (fresh Skill invocations), and it writes the
   milestone's downstream briefs — the derivation's and the blind verifier's fixed claim list, the latter before any claim exists (FS-89's
   V-A). No separate planner job.
2. **One walk, a verdict column per milestone.** Where two milestones open together, one agent walks the corpus once — every grokking,
   every `LEDGER.md` row's mechanism, every method rule, fresh from disk — with a verdict and reason per milestone. The corpus load
   (`CLAUDE.md` in context plus `LEDGER.md`, about 150k tokens) is paid once. It is a fresh walk, not a summary: WORKFLOW 3.1 item 4 holds.
3. **Terse, fixed verdict lines**: `G54 — bears: <≤ 25 words> → phase <n>`; `silent: <≤ 10 words>`; `falsifiable: registered as P-<x>`.
4. **§PA time-boxed** at about 45 minutes and 60k tokens, in the recognition's words, the zbMATH API for discovery (WORKFLOW 3.2 item 8);
   negatives recorded. For a kernel milestone §PA includes the Mathlib and core search for the statements to be ported.
5. **Scored by summary, checked for completeness mechanically.** The owner scores §G from the report's bears list and §IQ's two forms
   (≤ 25 lines); the clerk counts that every grokking G1–G76, every row 1–97 and every rule on the method checklist has a verdict with a
   reason, and reports one line.

**Cost:** four reframe jobs of about 330k harness each, about 1.3M of the crunch's roughly 9M tokens (≈ 14 %), against FS-89's 448k for one
milestone's planner.
