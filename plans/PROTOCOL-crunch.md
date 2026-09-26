# The crunch: a time-boxed run of many agents from a job queue — the protocol, the templates, and the two runs

*Written 2026-09-26 by consolidation job P1 (brief `data/consolidation-2026-09-26/briefs/P1-crunch-protocol.md`), at Kooshi's request:
"Please promote our "crunch" into a proper protocol like "competition". It worked spectacularly twice in a row. We'll definitely reuse it in
the future." Its model is `plans/PROTOCOL-competitor-and-advisor.md`. It is written so that a session with no memory of 2026-09-25/26 can
run the third crunch from this file, the two queues it cites, and the briefs it points to. No agent id appears here; jobs are named by
their job ids.*

**Shape, and why it differs from the brief's list.** The brief's seven sections are here in its order, with three changes: §0 (the design in
one paragraph, as in the model) is added in front; §3 is written as a runbook with the owner's acts at each phase, because the reader this
file is for has to *run* a crunch, not only understand one; and **the consolidation is a phase of its own, §4**, at Kooshi's word, relayed
by the owner mid-job: "tell it to include the consolidation phase after the crunch too please". So the brief's §4–§7 are §5–§8 here. The
record of this job is §R at the end.

## 0. The design in one paragraph

Kooshi gives a block of usage-hours, a number of agent slots and a model. A **planner** and an **advisor** (Poros) write a **queue**: jobs
of one to three hours, each with a brief on disk, each ending in a report of at most twelve lines. The **owner** (the main session)
coordinates only: it launches every agent, reads reports and never records, rules on held items, and keeps its own context as the budget.
A **Sonnet clerk** folds the reports into the queue table, the close inventories and a ready list, so the owner never has to. Derivations run
**beside blind verifiers on claim lists fixed verbatim before any derivation starts**; a milestone closes through a **close-math** job and a
**front-page** job; and after the crunch a **consolidation** rescues scratch, indexes and wires the work and brings the claims current.
What it bought, twice: sixteen hours closed five milestones and landed eighteen ledger rows (2026-09-25); two hours landed a 0.05-prior
headline, `χ(ℚ(√47)²) = 5` at [hand], and the main clause of the local–global conjecture through five (2026-09-26). The mechanism is
parallel verification on fixed statements plus a coordinator who never reads what it can have folded.

## 1. What a crunch is, and when to use it

**A crunch is:** a time-boxed run (two to sixteen hours) of many agents at once (four to seven slots), fed from a queue that jobs may
extend, coordinated by the owner through short reports. Kooshi sets three things and may change each mid-run:

| Kooshi sets | run 1 (2026-09-25) | run 2 (2026-09-26) |
|---|---|---|
| hours | sixteen usage-hours ("We have 16 hours remaining, at roughly 4-5 concurrent agents nonstop") | two ("Quick crunch. 2 hours, 6 agent slots") |
| slots | 4–5, cut to 4 at ~20:30 and to 2 at ~22:15 | 6, raised to 7 at 06:32, cut to 4 at 07:01 |
| model | Opus for everything judged, Sonnet for bookkeeping ("lean towards spawning a Sonnet subagent for bookeeping or easy reads. Opus for everything else") | the same |
| `CLAUDE.md` budget | 300,000 bytes, then 325,000 until the crunch ended | none during the crunch ("CLAUDE.md unbounded temporarily so we don't need to compress on the fly"), 300,000 after |

**When it beats a single milestone** (the evidence is §8):
- **Many fixed statements, each checkable in hours.** Both runs were a set of claims that could be written down verbatim first: three
  milestones' claim lists in run 1, three routes' lists (then three wanted posters') in run 2. Each claim got a derivation and a blind check
  in parallel. The milestone before run 1, FS-89, had taken about six hours for one headline with one derivation agent and blind verifiers;
  run 1 closed five milestones in sixteen hours, run 2 closed a stage and its follow-on wave in about two.
- **A result lands and opens questions the same hour.** Run 2's wave 3 ("Do these findings transfer to the other wanted posters?") was
  planned, fixed and launched within seven minutes of Kooshi's ask, because the machinery (briefs, fences, clerk, close) was already
  running.
- **Grade debt and derivations of known shape.** Run 1's kernel lane (M2) ran serially beside two derivation milestones; kernel jobs
  priced in hours closed in minutes (§7).
- **The planner under-prices it, in one direction.** Run 1's seven missed expectations were all things that happened below even odds
  (derivations with a blind verifier behind them, the milestone count); run 2's headline was a 0.05 outcome.

**When not to use it:**
- **The question has no statement yet.** A crunch runs fixed claim lists; a question still looking for its statement is the competition's
  domain (`plans/PROTOCOL-competitor-and-advisor.md`, runs FS-73 and FS-79).
- **One step gates everything.** Run 1's M3 (FS-76 in rank one) stalled at one named step with three minds on it; more slots did not help.
  Put one derivation plus a verifier on it, and a second mind only on a named stall (run 1's advisor, item (b)).
- **The result needs a finite witness or a machine-long certificate.** Both runs were under the ban on finite-witness search (to
  2026-10-01), and run 1's planner said first that the crunch could not land a bound above five for that reason.
- **The budget is short.** A crunch burns tokens fast (run 1: 33 of about 60 reports gave a harness count, summing to 9.6M; the
  planner had priced the whole crunch at about 9M). A five-hour usage window overshoot halts agents mid-job; stages make that cheap, not free.
- **Its costs.** Speed produces owner slips (run 1's close logged seven, run 2 three; §7), a bookkeeping debt that needs a consolidation after
  (§4), and byte pressure on `CLAUDE.md` that ended, both times, in a ruling from Kooshi.

## 2. Roles

| role | who | does | never does | best instance |
|---|---|---|---|---|
| **Kooshi** | the human | sets hours, slots, model and the `CLAUDE.md` budget; extends or cuts the run; decides held items; may give standing conditional instructions ("If 47 lands at 5, …") | — | — |
| **Owner** | the main session (de Bruijn as product owner) | launches every agent; reads each ≤ 12-line report, verifies its hashes on `origin`, rules on held items in WORKFLOW's four parts, launches the next job from `READY.md`; keeps the job log (agent ids) in its scratch only; checks one step of a key claim by a short script or grep, or leaves it to the blind verifier; re-runs every gate at the end; writes the handoff and memory | reads a job's record (its context is the budget); spawns a job that edits a file another running job edits; paraphrases a statement in a brief | owner job logs, `~/source/lean-dir-rescue/owner-scratch-2026-09-26-x2x3/live-agents.md` (holds ids; off-repo) |
| **Planner** | Opus, de Bruijn | writes the queue file: protocol (deltas), the reframe in proportion, the fixed claim lists, the table, the first briefs as files, `STANDING-RULES.md`, the clerk's brief, registered expectations, the close inventory; records where it disagreed with the advisor | derives the claims; launches anything | `plans/CRUNCH-2026-09-25-queue.md`, `plans/CRUNCH-2026-09-26-x2x3-queue.md` |
| **Advisor** | Opus, Poros | writes its expectation first, before the planner's drafts; sends frame-level items early; advises the planner by message; the planner decides. Later, **resumed off-slot on a named question with hard fences** (run 2: X01V's GAP against its own sketch, 05:57–06:01) | carries one side's route to a fenced job; counts as an independent mind for a sketch that is its own (run 2, stage 7) | `plans/POROS-2026-09-25-crunch-plan.md`, `plans/POROS-2026-09-26-x2x3-crunch.md` |
| **Clerk** | Sonnet, fresh each run | folds unfolded reports into the queue's status cells, appends SPAWN rows, appends INVENTORY lines to the close inventory as the owner's pen, rewrites `READY.md`, commits by path. Kooshi: "It's ok if the bookkeeping takes a bit. I'd rather it be thorough than miss something. Sonnet is cheap anyway." | reads a record; judges; writes an agent id; runs beside another writer of the same inventory | `data/crunch-2026-09-26-x2x3/briefs/J00-clerk.md`; a one-edit clerk: `…/K0-clerk-budget-line.md` |
| **Reframe job** | Opus | WORKFLOW 3–6 for a milestone in one job (§G, §PA, §IQ, subplan, modeling passes) and writes that milestone's derivation, verifier and kernel briefs, the verifier's claim list first | — | `data/crunch-2026-09-25/briefs/J03-M1-reframe.md` (kernel form: `J04-M2-kernel-reframe.md`) |
| **Derivation agent** | Opus | derives a fixed claim list: TRUE, FALSE with a counterexample, or GAP at a named step; C0 priors first | leans toward TRUE | `data/crunch-2026-09-26-x2x3/briefs/X01D-einsiedler-fish-derivation.md` |
| **Blind verifier** | Opus | the same list, fenced from the derivation until its own verdicts are committed; controls first; then (FS-89's fallback) the derivation's lemma statements, then a divergence table | opens a fenced file before its blind stage is committed | `data/crunch-2026-09-25/briefs/J51V-FS100-kronecker-verifier.md` |
| **Blind second derivation** | Opus | one claim, fenced for the whole job, own route; launched when a verification was not blind (a checking reading) or when one derivation carries a headline | — | `data/crunch-2026-09-26-x2x3/briefs/X12B-ef-plus-blind-derivation.md` |
| **Reader** | Opus | a prior-art gate, a paper audit or a reading check of one step; proposes bibliography rows in its record | writes `BIBLIOGRAPHY.md`; calls a paper unheld before grepping by arXiv id and Zbl number | `…/2026-09-26-x2x3/briefs/X24R-prior-art-gate.md`; `…/2026-09-25/briefs/J26-ambrus2023-audit.md`, `J03a-SWm-blind-reading.md` |
| **Advisor sessions mid-run** | Opus, Poros | one named question Kooshi raises (run 1: J36 on "infinitely many primes", J37–J39 the wanted posters, J50 the next two milestones) | — | `data/crunch-2026-09-25/briefs/J37-39-poros-wanted-posters.md` |
| **Kernel job** | Opus | one Lean job at a time (a build takes 60 GB); prices its first two leaves before anything else | runs beside another kernel job; runs `lake build` | `data/crunch-2026-09-25/briefs/J14-M2-chain-kernel.md`; `…/2026-09-26-x2x3/briefs/X11K-lean-47-dependencies.md` |
| **Bookkeeper** | Opus | mid-run or after: nothing lost (scratch is RAM), then an index, then a reverse index and address-only pointer blocks in the older files the work bears on | writes results into a file a blind job reads | `data/crunch-2026-09-25/briefs/J30-wiring-audit.md`; `data/consolidation-2026-09-26/briefs/C1-rescue-and-wiring.md` |
| **Close-math** | Opus | per milestone: the derivation file (WORKFLOW 9), §R-close, predictions scored, the verdict in four parts, **drafts** of ledger rows, `CLAUDE.md` lines, banners and re-ranks; ticks the inventory | writes the four front files | `data/crunch-2026-09-25/briefs/J23a-M1-close-math.md`; `…/2026-09-26-x2x3/briefs/X09C-close-math.md` |
| **Front page** | Opus | applies the closes' drafts to `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md` under the gates; scores the queue's expectations; banners the queue CLOSED | writes new mathematics; runs beside another front-page job | `data/crunch-2026-09-25/briefs/J24-front-page.md`, `J55-front-page-FS100.md`; `…/2026-09-26-x2x3/briefs/X10F-front-page.md` |
| **Follow-on fold** | Opus | close-math and front page in one small job, for results that report after the close | runs before the front page it follows has handed back | `data/crunch-2026-09-26-x2x3/briefs/X31C-tr-rot-fold.md` |
| **Consolidation jobs** | Opus | after the crunch: rescue and wiring, citations, claims in the front files, claims in the stubs, then the size jobs if the budget binds (§4) | — | `data/consolidation-2026-09-26/briefs/C1-…`, `C2-…`, `C3a-…`, `C3b-…` |

## 3. The run, phase by phase (a runbook)

### 3.1 Opening (Kooshi's word)

1. **Write Kooshi's words to memory at once**, verbatim: hours, slots, model, the `CLAUDE.md` budget, and any **standing conditional**
   ("If 47 lands at 5, tell all running agents the news, and launch one to start formalizing the dependencies in Lean") with its trigger
   defined in the plan's own terms (run 2 defined "lands" as the headline rule, §3.4). The memory file for run 2 is
   `~/.claude/projects/-home-kooshi-source-lean-dir/memory/crunch-mode-2026-09-26-x2x3.md`.
2. **Make the directory** `data/crunch-<date>[-<topic>]/` with `briefs/`, `reports/` and `READY.md`.
3. **Write the planner's and the advisor's briefs** from the templates (§6), with Kooshi's words verbatim and the clock. If the `CLAUDE.md`
   budget changes for the crunch, a one-edit Sonnet clerk records it in the header first (run 2's K0, gated by the fact audit).
4. **Launch the planner and the advisor together.** Send each the other's id by message. Keep ids in the owner's scratch job log only.

### 3.2 Setup (planner and advisor)

- **The advisor writes its expectation first**, at the top of its record, before any draft reaches it. It sends frame-level items as they
  occur (at FS-85 an advisor held two until its stand-down and the planner never saw them). Run 2's frame item — Einsiedler–Fish 2010,
  "multiplier semigroups of polynomial growth are rigid" — arrived eighteen minutes in and re-ordered the queue.
- **The planner commits in stages and the owner launches from the first commit.** Run 2: queue table, claim lists and the first briefs
  committed by 05:41 (fifteen minutes after opening); three derivations launched at once, the rest polished while they ran.
- **The planner's outputs** (run 1's §1 is the full protocol; later runs write only the deltas and cite it):
  1. protocol deltas (clock, slots, directory, clerk cadence, halts, the `CLAUDE.md` budget, when the close starts);
  2. **the reframe, in proportion, never skipped** (WORKFLOW 3; run 1 §1.9's five devices: one job runs WORKFLOW 3–6 end to end; one walk
     with a verdict column per milestone; terse fixed verdict lines; §PA time-boxed at about 45 minutes; §G scored by summary and checked for
     completeness by the clerk). In a two-hour run the planner walks it with the advisor reading beside it: bears one line each, silent
     grouped by the reason they share (run 2 §3);
  3. **the fixed claim lists, verbatim, before any derivation** (run 2 §2, fixed 05:45; wave 3's at 06:25); a list may be revised only
     before any of its jobs launch (run 2's X23 list, revised 06:27 on the advisor's items);
  4. the queue table, in run 1's columns: `id | model | kind | M | decides | inputs | output | deps | h | k | stop rule | spawns | pri | status`;
  5. briefs as files, `STANDING-RULES.md`, the clerk's brief;
  6. registered expectations with probabilities, and what would make the run good;
  7. the close inventory, opened as its own file (WORKFLOW 5), with the **headline rule** in it (§3.4).
- **Record the advisor's advice and the planner's disagreements** in the queue (run 1 §6, run 2 §6), each with its confidence.

### 3.3 Waves (the owner's cycle)

**A launch is one line:** "Your brief is on disk: read `<path>` in full first." plus, at most, a few essentials (a path correction, a fence,
the launch order). **Per report:**
1. Read the report (≤ 12 lines). Verify its commit hashes exist and are on `origin`; push if needed.
2. Log it in the owner's scratch job log: time, job, verdict, harness count, commits, rulings.
3. Rule on each held item in four parts (choice, alternative, why, confidence); the clerk logs rulings into the inventory as owner lines.
4. Launch the next job from `READY.md` into the free slot.
5. Launch the clerk after every second report (run 2) or third (run 1), and once before each close-math job. The clerk never runs beside
   another writer of the same inventory (§7).

**Concurrency rules the runs settled:**
- **At most three milestones open at once**, and no job consumes another open milestone's unverified claim except as a hypothesis named in
  its statement. **A milestone whose close-math is done counts as closed for the cap** (the front page is bookkeeping; owner ruling,
  run 1, 18:49).
- **One kernel job at a time**; the clerk's `READY.md` lists no second kernel job while one runs, and the same for front-page jobs.
- **Stage 0 before a reframe** is allowed where a job verifies or derives a statement that already exists (run 1's J01, J02, J09).
- **A verifier's second phase waits for the derivation's stage** it reads; a stood-down verifier is resumed by a **fresh agent on the same
  brief** (run 1's J10 → J10b; J22 → J22b; J23a → J23a2), never by messaging the old one past its line.
- **Halts:** every job saves after every stage; a halted job is resumed by a fresh agent on the same brief, which checks its last SAVED
  stage against `git log -- <record>`. In the last 30–90 minutes, launch no derivation's first stage.
- **Slot changes are Kooshi's and take effect at the next launch:** "Existing jobs may continue" (run 2, 07:01) — never stop a running job
  to meet a cut; launch nothing until the live count is under the new cap.

### 3.4 The headline rule, and when an announcement may go out

- **Pre-register the headline rule before any job reports**, in the close inventory, with the advisor: run 2's item 8 read "`χ(ℚ(√47)²) = 5`
  may be claimed only if X01 and X02 land **and** X05V's blind check of SP-Cor passes. Otherwise the claim is "MR(F) given PE-2 and EF_F"."
- **"Lands" means what the close-math will grade, on the rule's letter.** A checking reading that follows a withdrawn blind GAP is not a
  second mind (X09C's ruling, `plans/FS100-three-field-lemma.md` §R-close (stage 5) 1.4). If a blind second derivation is missing, launch one
  (X12B) and hold the announcement for it — about 35 minutes in run 2.
- **The announcement to Kooshi states the grade in words** ("lands, pending one blind confirmation"), and **the broadcast to running jobs
  skips every job whose blind stage is not yet committed** (run 2: X12B was told only after its blind stage).
- **A standing conditional launch** (run 2's Lean job) has its brief drafted in the owner's scratch and committed only at launch, so no blind
  job can read it early.

### 3.5 Follow-on waves (Kooshi extends the run)

- **Resume the planner and the advisor if each is under about 470k by the harness's count; otherwise launch fresh ones** from their briefs
  and records. Run 2 resumed both at 06:18 for wave 3 (planner handed back at 405k).
- The new wave's claim lists are fixed verbatim before any of its derivations launch, and state the new inputs' grade and scope ("given MR
  at the grade and scope just described").
- Launch order when slots bind: the widest result first (run 2: the X23 pair before its prior-art reader, "time-critical, widest result").

### 3.6 The close

- **Launch close-math when every derivation of the wave has reported, not by the clock** (X09C at 06:06, fifty minutes before its scheduled
  06:55; X29C at 06:42). Tell it to audit the landing and to fold the late blind jobs when they report.
- **The front page after close-math, one front-page job at a time**; it applies drafts exactly, scores the queue's expectations once, sets
  every status final and banners the queue "CLOSED … by <job>". Its standing mechanical-fix ruling is in its template (§6).
- **The follow-on fold** for results that report after the close: one small job doing close-math and front page together, launched after
  the front page it follows has handed back (X31C after X30F).
- **The owner re-runs every gate at the end** and records the numbers (run 2 at 90abbea2: fact audit `--base` over the whole crunch PASS,
  `--dupes` 10, fs71 `--strict` PASS, bib PASS, architecture PASS, build, axioms, vacuity).

### 3.7 After the crunch, the same night

Run 1's machinery kept running at a normal cap once Kooshi ended the crunch ("…returns to the 3 agent cap for competitions, or whatever it
was for normal milestones, we generally don't parallelize more than 3 or so, but back to normal"): a compression job (J05), an advisor
session choosing the next two milestones (J50), and both milestones (FS-100's in-ban round; FS-75's minimal instance) through planner →
derivation + blind verifier (or kernel job) → close-math → one front page, overnight, under his standing authorisation "Please carry on with
the remaining agents and milestones. […]" The defaults held; anything his (outsiders, installs, budget raises, force-pushes,
the ban) waited for the morning.

### 3.8 Then the consolidation — §4

Every crunch ends in the consolidation of §4. It is a phase of the protocol, not an optional tidy-up.

### 3.9 Memory and handoff

- **At every compaction point and at the end**, write the state into a handoff file in `plans/` (run 1's
  `plans/SESSION-HANDOFF-2026-09-25-crunch.md` §0 "First acts, after compaction" is the model: what to read, what is running, what to launch
  next, the rulings in force, the held items with their defaults).
- **Update the memory file** with the state, Kooshi's rulings verbatim, and the held items.
- **Copy the owner's scratch job log off-repo** (`~/source/lean-dir-rescue/owner-scratch-<date>/`); it holds agent ids.

## 4. The consolidation — the phase after every crunch

**Kooshi's words that opened it (2026-09-26):** "Now, next, I want to do a documentation consolidation. Let's audit our main files and just
make sure that our citations are clean, all findings are wired in, all files in /tmp that can't be regenerated are rescued, and all claims are
brought up to date with our new evidence."

### 4.1 Why it follows every crunch

- **Scratch is RAM.** `/tmp` and the agents' scratch directories die with the session. Run 1's mid-run bookkeeper (J30) rescued about 600
  scratch items; after run 2, C1 swept 2,594 files and rescued 266 into the repository and 140 to disk, among them application scripts that
  front-page records cite, a kernel job's scratch module and gate logs, and a paper's source that no library held.
- **Work is orphaned.** Many jobs leave records reachable only from their own report. C1 wired 29 older stubs, plans and registers with
  address-only pointer blocks, and found X26B's record reachable from nothing but its report.
- **Claims go stale away from the front page.** The crunch's front-page jobs apply drafts under a clock; everything else that states an old
  bound stays old. C3a rewrote 34 claims in `CLAUDE.md`, 17 in `LEDGER.md` and 9 in `CLOSED-QUESTIONS.md`; C3b brought the ranked stubs and
  22 stub files current.
- **Citations drift.** Readers under a clock re-fetch held papers (G50) and leave fields half-filled. C2 fixed 13 missing or wrong fields,
  a wrong read status and seven library items with no row.
- **The byte budget returns.** Both runs suspended or raised `CLAUDE.md`'s budget; the consolidation restores it and, if it binds, runs the
  size jobs of §4.2 steps 5–7.

### 4.2 The jobs, in order

**Rule for order:** jobs whose touch lists are disjoint run in parallel (at the normal cap, three); **jobs that write the same file run in
sequence**. The owner relays one job's "owed" items to the job that owns the file, by message. Every consolidation job carries the same
standing rules (`data/consolidation-2026-09-26/briefs/STANDING-RULES.md`); its rule 4 forbids raising a grade, a scope or a verdict.

| step | job | what it does | touches | runs | template (brief) | what it found (report) |
|---|---|---|---|---|---|---|
| 1 | **C1** rescue, index, wiring (J30's method) | nothing lost first: `git status`, unpushed commits, every `/tmp` file classed (in the repo, regenerable by a named command, rescued, junk) with a manifest; then the crunch's index per job; then the reverse index and address-only pointer blocks in every older file the work bears on | `plans/CRUNCH-<date>-INDEX.md`, `data/…/rescued/`, pointer blocks in stubs and plans | first, beside C2 and C3a | `data/consolidation-2026-09-26/briefs/C1-rescue-and-wiring.md` (from `data/crunch-2026-09-25/briefs/J30-wiring-audit.md`) | `…/reports/C1.md` |
| 1 | **C2** citations | `bib_audit`, every held-at address and checksum, read status per section, aliases for journal-year keys, rests-on lines, the debts list | `BIBLIOGRAPHY.md` | beside C1 | `…/briefs/C2-citations.md` | `…/reports/C2.md` |
| 1 | **C3a** claims in the front files | every stale claim in `CLAUDE.md`, `LEDGER.md`, `CLOSED-QUESTIONS.md` rewritten to current state, copying the source's words and grade; the budget line restored; Kooshi's rulings quoted | those three files | beside C1 | `…/briefs/C3a-claims-front-page.md` | `…/reports/C3a.md` |
| 2 | **C3b** claims in the stubs | `plans/FRONTIER-STUBS.md` and every stub file the new rows touch; closed milestones bannered, not deleted; ranks kept so the numbering stands | stubs | **after C1** (both write stub files) | `…/briefs/C3b-claims-stubs.md` | `…/reports/C3b.md` |
| 3 | **The owner's gate re-run** | fact audit `--base <pre-consolidation>`, `--dupes`, fs71 `--strict`, bib, architecture; `CLAUDE.md`'s bytes | — | after C3b | — | run 2: all PASS at 6a7c62cf, dupes 10, `CLAUDE.md` 299,491 bytes |
| 4 | **D1** the size proposal (only if the budget binds) | a read-only proposal for how `CLAUDE.md` carries the knowledge; options measured, one recommended; Kooshi decides | its proposal file only | may run beside C3b (read-only) | `…/briefs/D1-claude-md-restructure-proposal.md` | `…/reports/D1.md`; `plans/PROPOSAL-claude-md-knowledge-cache.md` |
| 5 | **E1** the extraction Kooshi chose | run 2: design (b), "Remove incidentals, keep intrinsics" — incidentals moved verbatim to `plans/GROKKING-INSTANCES.md` with pointers; the fact audit extended to the new file | `CLAUDE.md`, the new home, `LEDGER.md` | after Kooshi's ruling on D1; alone on `CLAUDE.md` | `…/briefs/E1-extract-incidentals.md` | `…/reports/E1.md` |
| 6 | **E2** the intrinsics check | re-reads E1's diff: every moved passage landed verbatim; anything that was a rule's only statement is judged intrinsic and restored word for word | `CLAUDE.md`, the new home | after E1 | `…/briefs/E2-intrinsics-check.md` | `…/reports/E2.md` (two passages restored) |
| 7 | **F1** the history audit | `CLAUDE.md`'s git history, for what earlier compression passes removed; Kooshi: "When that's done, have one audit the git history to catch instances that were previously compressed out. It's been a long struggle to maintain the balance." | `CLAUDE.md`, the new home | after E2 | `…/briefs/F1-history-audit.md` | **running at this writing** (stage 1 committed, 8db071bc); `…/reports/F1.md` when it lands |
| 8 | **Method updates** | the lessons into the method files: run 2's WORKFLOW step 9 line (new instances go to `plans/GROKKING-INSTANCES.md`, e5b3a507); this protocol (P1); its pointer line in `CLAUDE.md`, applied by the owner after F1 | `WORKFLOW.md`; `plans/PROTOCOL-*.md`; one `CLAUDE.md` line | last; the `CLAUDE.md` line after every other writer of it | `…/briefs/P1-crunch-protocol.md` | `…/reports/P1.md` |
| 9 | **The owner's final gate re-run, and memory** | every gate once more after the last writer; the memory file and the handoff brought to the end state (§3.9) | — | last | — | run 2: pending F1 |

**Kooshi's rulings that shaped steps 4–7 (2026-09-26, verbatim):** "the 300kB limit returns, and we'll likely need to find a way to extract
what's not necessary, treat the grokkings there as a cache for a dedicated grokking file, or merge things to reduce it from here on out.
There's just too much new knowledge to carry in every session."; "Implement b on the file. Remove incidentals, keep intrinsics."; "We'll
revisit a cache implementation next time we hit the cap at a point where we're too dense to compress or remove further incidentals." Steps
4–7 run only when the budget binds; steps 1–3, 8 and 9 run after every crunch.

## §R. Record (job P1)

### Stage 1 — SAVED (§0–§4: design, when to use it, roles, the run, the consolidation)

Written from the sources the brief names, read at the addresses cited above. §4 added mid-stage at Kooshi's word, relayed by the owner
("tell it to include the consolidation phase after the crunch too please"); F1's report was not on disk at this writing, so F1 is marked
running (its stage 1 is committed, 8db071bc). Harness count at this save: about 390k by the counter (the loaded system prompt was about 165k
of it) — already past the brief's 350k hand-back line; a slip, reported. Would have searched here: nothing.
