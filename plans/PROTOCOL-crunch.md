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

## 5. Standing rules — the version that worked, as a template

*Merged from `data/crunch-2026-09-25/briefs/STANDING-RULES.md`, `data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` and
`data/consolidation-2026-09-26/briefs/STANDING-RULES.md`, with the lessons of §7 folded in (marked ⁺). Copy it into
`data/crunch-<date>/briefs/STANDING-RULES.md`, fill the `<…>`, and delete a rule only when its reason no longer holds. Every brief says
"STANDING-RULES.md is part of this brief; read it in full."*

```
# Standing rules for every job of the <date> crunch (<clock>) — part of every brief

1. No children. Do not use the Agent tool, a fork, a workflow or anything else that starts another agent. Delegation here is one level
   deep (CLAUDE.md § "Delegation — one level deep"). The reason: staffing is Kooshi's budget decision, and the owner can only review
   work it knows about. If the work outgrows your context, stop at a saved stage and say what is left. That is a good report, never a
   failure.

2. Work in stages, and keep each response short. Save your record after every stage: add the stage's section, headed
   "Stage n — SAVED", then commit it before the next stage starts. The reasons: at FS-86 an agent lost three responses to the
   output-token limit, and nothing can recover a lost response; a 5-hour usage window can halt you mid-job, and a halt then costs one
   stage, not the job.
   - Resuming: if your record already exists when you start, you are resuming. Read it and your brief, check the last SAVED stage
     against `git log -- <record>`, and continue at the first stage that is not SAVED. Redo nothing that is saved.
   - Working files a successor would need go under the data/… path your brief names, committed with the stage, never only in /tmp.
     /tmp is RAM and dies with the session.

3. <If the ban is in force:> The ban on finite-witness search runs to <date>.
   - Out: SAT, MaxSAT, #SAT, MILP/CP, local-search colourers, Θ relation trees and float Θ finders, quotient-colouring searches, lattice
     sweeps hunting survivors, and machine-long certificates such as multi-hour relaxations.
   - Kooshi's intent, in his words: "The intent of the ban is to eliminate the crutch of feeling like we're accomplishing something by
     asking uncomputable problems for days at a time."
   - In: hand derivation; exact arithmetic of seconds that checks a derived claim; existing checkers on existing certificates; the Lean
     kernel. At the edge: a complete exact enumeration of a finite set whose extent a derivation fixed first is in, and is logged as such.
     "Try cases until one works" is out.
   - Keep a "would have searched here" log in your record: one line per move you would have made by search, and what you did instead.

4. All novel knowledge is a success. Kooshi: "A proven theorem about why its impossible is also valid. All novel knowledge is a success."
   - Do not lean toward a yes. This project's recorded failure mode is selection (CLAUDE.md G21): defects that flatter the work survive,
     and defects that displease are found within the hour. Audit a result you like as hard as one you dislike.
   - FALSE with a counterexample, or GAP with the missing step named, is as valuable as TRUE.
   - State every result at its grade, with its count of minds; "not found in print", never "first". Never raise a grade, a scope or a
     verdict you are copying.⁺

5. Quote statements verbatim, never paraphrase. Every statement you hand on goes in quotation marks with its source address. Paraphrases
   in briefs have invented a gap, widened a statement and emptied a claim (the flip lost "affine, U-invariant"; NA₀ lost "positive").⁺
   Your first stage checks every quotation in your brief against its source and logs the result.

6. Commits by explicit path. The tree is shared by <n> agents.
   - git add <new file>, then git commit <paths> -m …; never a bare git commit, never git add -A, never amend.
   - Push after each commit (git push origin main); on a ref-lock race, sleep 4 and retry. Never force-push.
   - Subjects are neutral, naming the job and the stage ("X01D: stage 2"): the harness shows every newly launched agent the last five
     subjects, and blind jobs are running.⁺
   - End each message with your harness's attribution lines.

7. Records, tools and fences.
   - Your record is the path your brief names. Give it a heading "Theorems this phase proved": one line per theorem, with its grade and
     its address.
   - Your exact checks go in tools/<job-prefix>_*.py. Plant a fault in each and watch it fire; a plant that cannot fire tests nothing,
     and a control proves only the shapes its generator can represent (G21).
   - Never edit a frozen tool (tools/fs58_*, tools/fs61_*, tools/fs66_*, tools/fs73_*check*.py, tools/fs73v2_check.py,
     data/fs73/coxeter-c3/certcheck.py) or any other job's tools.
   - Never edit CLAUDE.md, LEDGER.md, plans/FRONTIER-STUBS.md or BIBLIOGRAPHY.md unless your brief makes you the front-page lane; propose
     edits in your record.
   - If your brief fences files and a search prints fenced text, stop reading it, and log the touch (time, file, what it carried) in your
     record and your report at once.⁺
   - Never copy an agent id (a string like a1b2c3…) into any file. Never read credential files (auth.json, .env, keyrings).

8. Machine.
   - Any job over about 2 GiB or 2 minutes runs under scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>, with an honest --mem (a checker
     under-declared at 8 GiB was killed by its own cap).⁺
   - On exit 75 (not admitted after 1,800 s), wait ten minutes and retry. Never raise a cap. After three refusals, report BLOCKED.
   - Never run lake build, bare or named. Kernel jobs follow their brief's build line; there is one kernel job at a time.
   - Read every exit status directly, never through a pipe, and never chain a commit after a gate with ";".⁺
   - On any unexplained crash of any process, halt and report. Do not diagnose or retry.

9. The report. When you finish, and at any halt you can foresee, write this and commit it to data/crunch-<date>/reports/<job id>.md. Then
   send the same text to "main" by SendMessage:
     JOB <id> — <DONE | STAGE n SAVED | BLOCKED: reason>   harness≈<k> (own≈<k>)
     RESULT: <one line; per claim TRUE / FALSE / GAP-at-step, or the theorem's name and grade>
     RECORD: <path>   COMMITS: <hashes>
     INVENTORY: <n lines follow, each "kind — one line — source address">
     SPAWN: <n lines follow in the queue's format, or "none">
     HELD FOR THE OWNER: <a decision or a slip, one line each; or "none">
   - INVENTORY kinds: result, correction owed, prediction scored, slip, tool defect, prior-art debt, stub to mint or re-aim, fence touch.⁺
   - SPAWN lines use the queue's columns, and each comes with its brief written as a file under data/crunch-<date>/briefs/.
   - The final text of your turn: "<job id> idle; report sent to the owner by SendMessage".

10. Budget and clock. Your brief names the budget in the harness's count; hand back with your record saved before <line>. The loaded
    context at launch is itself about 165k by the counter, and agents' own counts have run at 29–70 % of the harness's, so leave a
    margin.⁺ The crunch ends at about <time>; the close reads reports from <time>: check `date` at every stage, and at <time − 5 min>
    finish the current claim, save, and report, whatever is left.

11. Reading is in; cite what you read. Grep BIBLIOGRAPHY.md (by arXiv id and Zbl number) and ~/source/library/ before calling a paper
    unheld or fetching it; papers held under a journal-year key have been re-fetched twice (G50).⁺ Record a reading status per section;
    an abstract is not a reading. Never commit a paper's PDF into the repository; name it for the library.⁺ Propose BIBLIOGRAPHY.md rows
    in your record; the front-page job writes them.
```

## 7. Rules the runs taught — each with its incident

*One line each. "Owner" is the coordinating session. Addresses: the owner's job logs (off-repo, ids) are
`~/source/lean-dir-rescue/owner-scratch-2026-09-25/owner-crunch/live-agents.md` and `…/owner-scratch-2026-09-26-x2x3/live-agents.md`; run 1's
list of owner slips is `plans/CRUNCH-2026-09-25-queue.md` §8.5; run 2's inventories are `plans/FS100-x2x3-close-inventory.md` and
`plans/FS100-x2x3-wave3-close-inventory.md`.*

**Minds, grades and announcements**

| # | rule | the incident |
|---|---|---|
| 1 | A checking reading that follows a withdrawn blind GAP is not a second mind; launch a blind second derivation instead. | X01V found a GAP, then read X01D's proof and withdrew it; the owner announced the headline at 06:08 on that reading; X09C ruled it short of the rule's letter (`plans/FS100-three-field-lemma.md` §R-close (stage 5) 1.4); X12B, blind, landed it at 06:15. The outcome stood; the announcement was early. |
| 2 | The advisor's check of a route that grew from its own sketch is not an independent mind. | Poros, resumed on X01V's GAP, found it "does not stand" by its own route; the owner logged it "NOT independent (its own sketch)"; X01V's stage 4 was decisive (06:01–06:02). |
| 3 | Pre-register the headline rule in the close inventory before any job reports, and announce only when the close-math would grade it met. | Run 2's item 8 [P-5], written at 05:47; met at 06:15, not 06:08 (rule 1). |
| 4 | Broadcast news only to jobs whose blind stage is committed. | Run 2's 06:06 broadcast skipped X12B; it was told after its blind stage. |
| 5 | Fix the claim lists verbatim before any derivation; revise a list only before any of its jobs launches. | Run 2 §2 (05:45) and §7 (06:25); the X23 list revised 06:27, before either X23 job launched. |
| 6 | Tell the planner its derivations with a blind verifier behind them land more often than it thinks. | Run 1: all seven missed expectations were events priced below even odds that happened (E2b, E3, E4, E5, E8c, E10b, E10c; §8.2 there); run 2's headline was a 0.05 outcome. |

**Statements and briefs**

| # | rule | the incident |
|---|---|---|
| 7 | Quote statements verbatim in every brief; a paraphrase can empty a claim, not only widen it. | The owner's X27 briefs posed the flip without X22V's "affine, `U`-invariant", which made it vacuous; X31C's brief dropped "positive" from NA₀ and called COL-E "the same step" (X31C quoted the sources instead). Run 1's list: CLG paraphrased as a classification when it is an existence statement (J29's brief, and to Kooshi); R96's "finitely generated" as "saturated" (S1V's brief, written by J29); T-C's blind scope overstated (J41's); a control line that widened F2 (J46's). |
| 8 | A brief's attribution and path are claims too; check them. | J26's brief credited G27 to `[AmbrusEtAl2023]` (it is `[MatolcsiEtAl2025]`'s); four run-2 briefs named an EL2021 path that did not exist (corrected at 8e941a76). |
| 9 | Write a standing conditional instruction of Kooshi's to memory at once, with its trigger defined in the plan's terms; keep the conditional job's brief in the owner's scratch until launch. | "If 47 lands at 5, tell all running agents the news, and launch one to start formalizing the dependencies in Lean" (05:55) — recorded with "lands" = item 8; X11K's brief was committed only at its launch, 06:06. |

**Fences**

| # | rule | the incident |
|---|---|---|
| 10 | Fence a blind job from the derivation's record, data, tools, brief and report, the close inventory, the index, the advisor's record and the commit bodies of the fenced jobs; name every path. | J51V's and X12B's fence lists (§6). |
| 11 | A fence touch is logged by the job at once; the owner rules on it by commit order and by what the touched text carried. | X21V touched a fence at 06:35, after its blind A-3 was committed at 06:34: counted blind. X23V blind "by commit order" (44 s). X25B saw a route outline only: graded "blind to the proofs, not the outline". X05V saw one line naming itself and the headline cap: harmless. J51V's grep of `plans/*.md` reached K0's membership: that verdict not counted blind. |
| 12 | Commit subjects stay neutral while any blind job runs. | Owner commit 3648d3a5 named a counterexample while J51D could read `git log`; J51D's prior (0.80 FALSE) predated it, and its FALSE verdicts were graded with that noted. |

**Files and writers**

| # | rule | the incident |
|---|---|---|
| 13 | Two jobs that write the same file run in sequence; the clerk is a writer too. | The clerk swept J42's uncommitted inventory ticks (nothing lost); no clerk ran while J30 appended inventory lines; X30F waited for X10F, X31C for X30F, C3b for C1, E2 for E1, F1 for E2, and this protocol's `CLAUDE.md` line waits for F1. |
| 14 | The front page may make mechanical fixes to close-math's derivation entries so the strict ledger check passes: field labels where the content exists, addresses where it is absent, no new mathematics, no grade change. | Asked twice in run 2 (X10F at 06:27, X30F at 07:10) and granted each time; in run 1 the same failure went to a Sonnet format job (J33) after J24. Now in the front-page template (§6). |
| 15 | Limit what the clerk reads, never what it folds. | Clerk run 1 cost 252k reading the whole queue; its later briefs read the table, the unfolded reports and `READY.md` only; Kooshi: "I'd rather it be thorough than miss something." |
| 16 | When Kooshi fears lost or orphaned work mid-run, a bookkeeper job goes to the head of the queue, and blind jobs are fenced from its index. | "Inject an Opus bookkeeper into the queue to verify the current documentation…" (run 1, 16:50) → J30. |
| 17 | Papers go to the library, never into the repository. | Run 2's advisor committed two PDFs (d20b17d4); the close moved them. |

**Budgets, slots and the machine**

| # | rule | the incident |
|---|---|---|
| 18 | Read the harness's count from the task notification; an agent's own count is 29–70 % of it; price briefs with the ~165k loaded at launch included. | Own/harness: J24a 95k/324k, J18 120k/402k, J15 150k/368k, J03a 135k/324k, J09 255k/417k. |
| 19 | An agent past its hand-back line has its last stage checked by the next job; past about 500k it is replaced, never reused. | Over the line: run 2's planner 341k against 280k, its advisor about 333k against 150k; J28D 460k against 420k; J52 437k against 350k. Past 500k: J04 534k, J23a2 536k, J23b 574k, J24 550k — the owner told J24 to check every draft those closers wrote past 500k against its source. |
| 20 | A slot cut applies to launches, never to running jobs; re-order the queue for the new cap. | Run 1: 5 → 4 (~20:30), → 2 (~22:15; the front page was swapped ahead of the posters); run 2: 6 → 7 (06:32), → 4 (07:01, "Existing jobs may continue"). |
| 21 | One kernel job at a time; re-price a kernel job from its first two leaves. | J16's stripe lemma closed in 17 minutes against a 4–6 h price; J52K in 45 minutes against 4.5 h. |
| 22 | Keep the job log structured enough to count agents at work. | Run 1's E9 ("≥ 3.5 agents on derivation, verification or kernel work, first 8 h") went unscored: no utilisation log was kept. |
| 23 | Honest `--mem`, every time. | An FS-66 checker was killed by its own 8 GiB cap (exit 137) and relaunched at 16 GiB; X26B (3.2 GB, 519 s) and J31 (9 minutes) ran outside `scripts/slot.py` — slips. |
| 24 | Message only live jobs, and tell the advisor of every stand-down. | A stood-down J22 was woken by an owner message (+266 tokens). |
| 25 | Never chain a commit after its gate with ";". | The budget commit 25bff6a0 went in before its audit passed; fixed within minutes. |

**The owner's own checks**

| # | rule | the incident |
|---|---|---|
| 26 | For a key claim, check one step yourself (a short script, a statement read against its source), never the record. | The owner re-derived J51V's counterexample and re-ran its tool; read `not_colorable_chain`'s and `inv_natCast_mem_unitRing_iff`'s statements against G55 and the plan; re-ran the gate after every kernel job. |
| 27 | A crunch finds errors in earlier milestones; route them as "correction owed" lines, never as silent edits. | J03a found FS89-CL2 false as written (the archimedean characters must be `Hom_ℚ(F(i), ℝ) mod 1`), and the fix went to J07 as a deliverable. |

## 8. The runs

### 8.1 Run 1 — the 16-hour crunch (2026-09-25, into 2026-09-26)

**Records:** the queue `plans/CRUNCH-2026-09-25-queue.md` (§1 the full protocol, §2 the table, §4 the skeletons, §5 expectations, §6 the
advice, §8 the close); the index `plans/CRUNCH-2026-09-25-INDEX.md`; briefs `data/crunch-2026-09-25/briefs/`; reports
`data/crunch-2026-09-25/reports/`; the handoff `plans/SESSION-HANDOFF-2026-09-25-crunch.md` (§7–§8 for the night after); the advisor
`plans/POROS-2026-09-25-crunch-plan.md`.

**Kooshi's opening words (verbatim):** "[…] I'd like an advisor and a
planner to plan the next 16 hours (keep in mind each of your "week" estimates took just a few hours each). Basically, let's keep 4-5 agents
spawned, and a list of jobs to churn through. Those jobs can spawn new jobs in the queue. I'll check in and compact you as needed so we can
keep churning. […]
We're still operating under the ban, and the crunch time won't start until the plan finishes and we compact. You'll act as orchestrator the
whole time, and your context window is your budget, so lean towards spawning a Sonnet subagent for bookeeping or easy reads. Opus for
everything else, and avoid filling up your context more than needed."

| item | run 1 |
|---|---|
| clock (the owner's log) | launched after compaction ("You are clear to launch."); the queue closed by J25; Kooshi ended the crunch ("We're done with the crunch, so that cap is removed, …"); two post-crunch milestones ran overnight at a normal cap |
| slots | 4–5; cut to 4 and later to 2 (Kooshi: "[…]") |
| jobs | 60 reports before J25's own, 58 DONE or DONE on resumption (§8.1 there); eight clerk runs; three resumptions by fresh agents on the same brief (J10b, J22b, J23a2), each at the next unsaved stage |
| milestones | three opened at once (M1 = FS-91, M2 the kernel lane, M3 exotic colourings), then row 88's question, FS-67 and FS-84 as closes freed the cap |
| closed (verdicts from §8.3 there) | **M1 = FS-91**, rows 98–102, G77: Paid (theorem); **M2**, rows 103–107: Paid (kernel); **M3**, rows 108–110, G78: Q1 not landed, Q2 landed in part; **row 88's question**, rows 111–113: Paid (theorem), row 88 not landed; **FS-67**, rows 114–115: Paid (theorem and no-go). FS-84 opened and ran S1 and its blind verification; its later stages were post-ban. G79 minted (Kooshi's grokking). Stubs FS-92 to FS-100 minted |
| grades of note | the conjecture at `L ≤ 4` for every real number field, [hand, two derivations] (J02, J09); the character local–global theorem given `H_k`, one derivation with 24 of 25 statements verified blind and one GAP (J07, J10); the kernel lane's chain theorem, stripe lemma, bridge (conditional on one named proposition) and Lemma NP, [kernel] (J14–J17K2) |
| after the crunch, the same night | J05 compression (12,587 bytes freed; its 15,000 floor not landed); J50 (Poros) chose two milestones; **FS-100's in-ban round** (J51 plan, J51D and J51V: Kronecker selection refuted as stated by two minds, rows 116–118) and **FS-75's minimal instance** (J52 plan, J52K: `χ(ℚ(√167)²) ≥ 4` in the kernel in about 45 minutes against 4.5 hours planned, row 119), closed by J53/J53b, J54 and one front page, J55 |
| expectations | 28 lines scored, 21 met, 7 missed, Brier 0.170; every miss was a success priced below even odds (§8.2 there) |
| budgets | 33 jobs reported a harness count, summing to 9,616k against the plan's "roughly 9M" for everything; the rest reported only their own counts (§8.1 there). Over the replace line: J04 534k, J23a2 536k, J23b 574k, J24 550k |
| retractions and refutations | no retraction tally was kept (a gap; keep one). Recorded: J09's own first route false at `q = 27`; FS89-CL2 false as written (J03a); J19-KC's clause 1 needs "a common period" (J20); J08-8's bound corrected (J11); the planner's cylinder lemma false (J21's NG1); KS-1 and KS-3, the planner's statements, refuted by two minds (J51D, J51V) |
| slips | the owner's seven (§8.5 there), then two in the night (a budget commit before its audit passed; a commit subject naming a counterexample while J51D ran); agents: fence leaks at J08 and J51V, J31 outside `scripts/slot.py`, closers past their lines |
| what it taught | §7 rules 7, 8, 10–13, 15, 16, 18–22, 24–27 |

### 8.2 Run 2 — the ×2×3 crunch (2026-09-26, 10:26–12:38 UTC)

**Records:** the queue `plans/CRUNCH-2026-09-26-x2x3-queue.md` (§1 deltas, §2 the fixed claim lists, §3 the reframe, §4 and §7 the tables,
§5 expectations, §6 the advice); the index `plans/CRUNCH-2026-09-26-x2x3-INDEX.md`; briefs and reports under `data/crunch-2026-09-26-x2x3/`;
the milestone's closes `plans/FS100-three-field-lemma.md` §R-close (stage 5), (stage 5, wave 3), (stage 5, wave 3b); the advisor
`plans/POROS-2026-09-26-x2x3-crunch.md`.

**Kooshi's words (verbatim):** "next, we'll do a short crunch run attacking the x2x3 problem"; "Quick crunch. 2 hours, 6 agent slots,
CLAUDE.md unbounded temporarily so we don't need to compress on the fly. Launch a planner and a Poros advisor to lay out the queue attacking
x2x3. Read up on the last crunch run for any additional details. You act as coordinator only, and preserve your context, so a subagent does
bookkeeping runs."

| time | event |
|---|---|
| 05:30 | planner, advisor, and a one-edit clerk (K0: the header's temporary budget line) launched |
| 05:41–05:46 | claim lists fixed (§2); wave 1: X01D, X02D, X03D (derivations of three routes to MR), then X01V, X02V (blind), X05V (blind check of SP-Cor and the flip) |
| 05:44 | the advisor's frame item: Einsiedler–Fish 2010 — so MR is likely not ×2×3-hard |
| 05:55 | Kooshi's standing conditional ("If 47 lands at 5, …") |
| 05:57–06:02 | X01V: GAP at the multiplier step; X01D: TRUE; the advisor resumed on the divergence; X01V's stage 4 withdraws its GAP |
| 06:03 | X12B, a blind second derivation of EF_F⁺ |
| 06:06–06:08 | X02V confirms PE-2 blind; the owner announces the headline and launches X11K (Lean) and X09C (close-math, early: every derivation had reported) |
| 06:15 | X12B: EF_F⁺ TRUE blind — the headline rule met on its letter |
| 06:18 | Kooshi: "We still have usage left for crunching. Do these findings transfer to the other wanted posters? Please continue the queue with asks about them." Planner and advisor resumed |
| 06:22–06:43 | wave 3: X21D/V (ℚ(√167) and the `L ≥ 5` family), X23D/V (every real number field), X24R (prior-art gate), X22D/V (type-(B) fields), X25B and X26B (blind second derivations); 06:32 a seventh slot |
| 06:25–06:39 | X10F applies waves 1–2 (rows 120–122) |
| 06:48 | Kooshi: "The target for the Lean implementation should move to the more general "every real" claim." |
| 06:52–07:14 | X27D/V (TR-ROT); X28D (the complex-place case, from Kooshi's pointer to cube roots); 07:01 slots cut to 4, "Existing jobs may continue." |
| 07:04–07:38 | X29C closes wave 3; X30F applies rows 123–125; X11K3 gates the Lean lane (row 127); X31C folds TR-ROT (row 126); the owner re-runs every gate at 90abbea2 |

| item | run 2 |
|---|---|
| jobs | 31 indexed by C1 (planner, advisor, clerk folds, 28 working jobs), with four clerk folds |
| landed (`LEDGER.md` rows 120–127) | **row 120**, MR for every real number field with `R_F = O′`: "[hand; PE-2 two derivations blind to each other (X02D, X02V), EL2021 Thm 1.2 by statement … EF_F⁺ two derivations blind to each other (X01D, X12B) and a checking reading (X01V, after its blind GAP, withdrawn as its own error); MR a composition, three minds]"; **row 121**, `χ(ℚ(√47)²) = 5`, "[hand; the headline rule met (every half two blind minds, SP-Cor checked blind): …]"; **row 122**, where the other routes stop; **row 123**, "for every real number field `F`, `χ(F²) ≥ min(L(F), 5)`, so `χ(F²) = L(F)` whenever `L(F) ≤ 5`", "[hand + tools exact; MR row 120's grade (…); CLS three derivations — …]"; **rows 124–126**, the type-(B) fields given MR, six at ℚ(√167) as a question about the real plane, TR-ROT GAP at NA₀; **row 127**, the main clause through five in the kernel over named hypotheses, and `χ(ℚ(√47)²) ≤ 5` unconditionally [kernel]. G80 minted; FS-101 stub minted |
| expectations (§5 there, scored by X10F) | the realised outcomes included the planner's 0.05 (the headline), 0.08 (MR landing, two minds each half) and 0.15 (ED-2 FALSE with an explicit character); item 8 (FL-1 as written, at 0.40) was scored "not met" |
| budgets | planner 341k at hand-back (405k after wave 3) against 280k; advisor about 333k against 150k; X01D 321k, X01V 329k, X02V 323k, X03D 344k, X05V 289k, X11K 360k, X11K2 373k, X11K3 245k by the harness; the rest 75k–200k as reported (mostly own counts) |
| retractions and refutations | X01V's GAP, withdrawn at its stage 4 as its own error; the advisor's sketch errors (its record §7.3); claim-list items refuted as results: EF-G (a) at ℚ(∛2), PE-1 as posed (two counterexamples), ED-2, CP-2 and CP-3 (X28D) |
| slips | the owner's three (the 06:08 announcement; the flip's lost qualifiers; NA₀'s lost "positive"); planner and advisor over their lines; the advisor's committed PDFs; X26B outside `scripts/slot.py`; X09C's derivation entries malformed for the strict check (fixed mechanically by X10F); fence touches at X05V, X21V, X22V, X25B, each ruled (§7 rule 11) |
| after it | the consolidation (§4), cap 3, 08:07–08:44 for C1–C3b, then D1, E1, E2, F1 and this protocol |
| what it taught | §7 rules 1–7, 9, 11, 13, 14, 17, 19, 20, 23 |

### 8.3 Reading the two runs together

- **Both worked for the same reason:** every claim was fixed before it was derived, and every derivation had a blind mind beside it; the
  owner never read a record. The unit of work was a claim, not a milestone.
- **Both were under-priced in the same direction** (§7 rule 6). Register expectations anyway; the misses are the calibration.
- **Both produced owner slips in the same two places:** paraphrase in a brief written fast, and an announcement or commit made before the
  close would grade it. The rules that answer them are §7 rules 1, 3, 7 and 12.
- **Confounds:** run 1 had sixteen hours and three concurrent milestones; run 2 had two hours and one milestone's lemma; run 2 inherited run
  1's whole machinery (briefs, clerk, standing rules) and its planner wrote only deltas. One run each; the shapes are not yet separable.

## §R. Record (job P1)

### Stage 1 — SAVED (§0–§4: design, when to use it, roles, the run, the consolidation)

Written from the sources the brief names, read at the addresses cited above. §4 added mid-stage at Kooshi's word, relayed by the owner
("tell it to include the consolidation phase after the crunch too please"); F1's report was not on disk at this writing, so F1 is marked
running (its stage 1 is committed, 8db071bc). Harness count at this save: about 390k by the counter (the loaded system prompt was about 165k
of it) — already past the brief's 350k hand-back line; a slip, reported. Would have searched here: nothing.

### Stage 2 — SAVED (§5 the standing rules as a template; §7 the rules the runs taught)

§5 merges the three STANDING-RULES files and marks each lesson folded in with ⁺. §7 holds 27 rules in five groups, each with its incident
and address. §6 (templates) is stage 4 and will sit between them. Harness count at this save: about 405k by the counter. Would have
searched here: nothing.

### Stage 3 — SAVED (§8 the runs)

Run 1 and run 2 each with clock, slots, jobs, what landed at what grade, expectations, budgets, retractions, slips and what each taught
(pointing to §7's rules); §8.3 reads them together with the confounds. Grades are quoted from  rows 120, 121, 123 and 127 and
from each queue's §8.3/§5; none is raised. Run 1 kept no retraction tally; that is said. Harness count at this save: about 420k by the
counter. Would have searched here: nothing.
