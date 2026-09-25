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

---

## §2. The queue

**Milestones the crunch opens** (at most three at once, §1.1):
- **M1 — FS-91, opened as "the character local–global theorem, and band rigidity to nine colours."** It absorbs FS-82 (its `k = 3` case,
  [P-F1]) and FS-83's `k ≥ 6` remainder [P-F2]. The plan file is `plans/FS91-character-local-global.md`; the close inventory is
  `plans/FS91-close-inventory.md`.
- **M2 — the kernel lane: FS-45's chain theorem, FS-87's stripe lemma, FS-39's bridge.** This is grade debt; FS-39's Artin–Lang repair is
  derived by hand first. The plan file is `plans/M2-kernel-lane.md`; the close inventory is `plans/M2-close-inventory.md`.
- **M3 — FS-76 in rank one, and FS-64 at five colours over ℚ(√167): colourings no periodic colouring or character gives.** The plan file
  is `plans/M3-exotic-colourings.md`; the close inventory is `plans/M3-close-inventory.md`.

**Status** is kept by the clerk: `ready` (dependencies met), `wait` (on its dependencies), `run`, `DONE`, `HALTED@n`, `BLOCKED`,
`declined`. **Priority:** P1 starts at minute zero or at the first free slot; P2 starts the moment its dependencies are DONE; P3 fills idle
slots. **Kinds:** reframe (WORKFLOW 3–6 in one job), stage-0, derivation, blind verifier, kernel, reader, close-math, front-page, clerk.
Wall hours and harness tokens are the planner's prices; the report records the actuals beside them.

| id | model | kind | M | decides | inputs | output | deps | h | k | stop rule | spawns | pri | status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| J00 | Sonnet | clerk | all | nothing; folds reports into §2, the close inventories and `READY.md` | unfolded `data/crunch-2026-09-25/reports/*.md` | this table, `READY.md`, `plans/<M>-close-inventory.md` | ≥ 1 new report | 0.2 | 40 | every unfolded report folded | nothing | recurring | ready |
| J01 | Opus | blind verifier (stage 0) | M1 | PA-B2 and PA-B3 (FS-89 item 41): is `RS_k(S)` true for every `k < 2·min S`, `\|S\| ≥ 2`, and so `RQ_k` for every `k ≤ 9`? Verdicts at `k = 6, 8, 9`, naming any line that uses `k ≤ 5` | brief J01; the statements verbatim; `plans/FS89-S1VB-verification.md` (VB1–VB4 at `k = 4, 5`), `…-S1V-…`, `…-S0A-…`, `…-S0B-…`; Berend 1984 PDF | `plans/FS91-S0V-band-to-nine.md` | none | 2.5 | 350 | a verdict per claim saved, or 350k | TRUE: J08 runs unconditionally. GAP: a lemma job on the named step. FALSE: J08 is re-aimed at the band-1/6 exit lemma | P1 | ready |
| J02 | Opus | stage 0 (derive an advisor's sketch) | M1 | Poros's F1: `χ(F²) ≤ 3 ⟹ L(F) ≤ 3` for every real number field, so the conjecture's `L ≤ 4` clause holds everywhere; its instance is `χ(ℚ(α,√7)²) = 4` (FS-82) | brief J02; the sketch verbatim; `plans/FS89-derivation.md` CL2; S0A-3; `plans/FS81-derivation.md` T3, T4, T7; FS73-T22; the FS-82 stub | `plans/FS91-S0F-three-colours.md` | none | 2.5 | 330 | a proof, a named gap, or a counterexample, saved | a proof: J09. A gap: a lemma job. A counterexample: FS-82 as stubbed, into M1's plan | P1 | ready |
| J03 | Opus | reframe | M1 | M1's §G, §PA, §IQ, subplan and modeling passes; writes briefs J07, J08, J12 and the fixed lists for J10, J11, J13 | brief J03; `CLAUDE.md`, `LEDGER.md` (read in full), stubs FS-91, FS-82, FS-83; FS-89's §R-close | `plans/FS91-character-local-global.md`; briefs J07, J08, J10–J13 | none | 2.5 | 350 | the plan and five briefs committed, or 350k with §G/§PA/§IQ saved | J07, J08, J12 (and their verifiers) | P1 | ready |
| J04 | Opus | reframe (kernel; §IQ for FS-39's hand step only) | M2 | M2's §G (three columns), §PA (Mathlib and core), the leaf skeletons priced from their first two leaves; writes briefs K1–K3 and D-bridge | brief J04; stubs FS-45, FS-87, FS-39; `Proofs/HadwigerNelson/Copy.lean`, `Homogeneous.lean`, `OneDefect.lean`; G55, G63 | `plans/M2-kernel-lane.md`; briefs J14, J15, J16, J17 | none | 2.5 | 350 | plan and four briefs committed | J14–J17 | P1 | ready |
| J05 | Opus | front-page (compression) | lane | `CLAUDE.md` compressed without loss to at most 255,000 bytes: the fact audit passes against the pre-job commit, with `--dupes` at 11; no `[PROTECTED]` paragraph, grokking status tag, *Do* line or killing test touched | brief J05; `tools/claude_md_fact_audit.py` | `CLAUDE.md`; `plans/CRUNCH-2026-09-25-compression.md` (its log) | the third FS-89 close planner has handed back | 2.5 | 350 | ≥ 20,000 bytes freed with the audit green, or 350k (commit what passed) | J24 may run | P1 | wait |
| J06 | Opus | reframe | M3 | M3's §G (two columns), §PA, §IQ; writes briefs J18–J22 | brief J06 (skeleton §4.2); stubs FS-76, FS-64; FS-79's T34–T36; FS-86's row 92 record (FS86-CL1) | `plans/M3-exotic-colourings.md`; briefs J18–J22 | a free slot | 2.5 | 350 | plan and briefs committed | J18–J22 | P1 | ready |
| J07 | Opus | derivation | M1 | the local–global theorem for character colourings: a character `k`-colouring of `F²` forces a `k`-colourable residue target, `k = 4, 5` (to 9 given J01, as a named hypothesis); its product step PA-T4 or a sumset; the archimedean circle as a factor | brief J07 (by J03) | `plans/FS91-S1D-character.md` | J03 | 3 | 350 | claims stated with grades, saved per stage | J10 | P2 | wait |
| J08 | Opus | derivation | M1 | character six-colourings at the exposed fields — ℚ(√167) (23, 43, …), `K(√7)`, de Grey's field: is there one? The level-one sumset question at the stable places, after Lemma SW collapses the tower | brief J08 (by J03) | `plans/FS91-S1D-six.md` | J03; J01 (else conditional) | 3 | 350 | the same | J11 | P2 | wait |
| J09 | Opus | blind verifier | M1 | J02's statements, blind (a fixed list quoted verbatim from J02's record) | brief J09 (written by J02 and checked by the owner) | `plans/FS91-S0FV-verification.md` | J02 DONE with a claimed proof | 2.5 | 350 | a verdict per claim | a divergence item to M1's inventory | P2 | wait |
| J10 | Opus | blind verifier | M1 | J07's claims; the fixed list is written by J03 before J07 runs | brief J10 (by J03) | `plans/FS91-S1V-character.md` | J07 | 2.5 | 350 | a verdict per claim | — | P2 | wait |
| J11 | Opus | blind verifier | M1 | J08's claims | brief J11 (by J03) | `plans/FS91-S1V-six.md` | J08 | 2.5 | 350 | the same | — | P2 | wait |
| J12 | Opus | derivation | M1 | one prime: U3 (`RS₄({p})` false at every `p ≡ 1 (mod 4)`; proved at 5 only) and `MS₄({5})` (are the rank-one minimal sets in `T + A`?) | brief J12 (by J03) | `plans/FS91-S1D-one-prime.md` | J03 | 3 | 350 | the same | J13 | P3 | wait |
| J13 | Opus | blind verifier | M1 | J12's claims | brief J13 (by J03) | `plans/FS91-S1V-one-prime.md` | J12 | 2 | 300 | the same | — | P3 | wait |
| J14 | Opus | kernel | M2 | K1: FS-45's chain theorem in Lean (a forced pair at `δ` with `1/δ` a sum of unit vectors refuses `k` colours on `F²`), with its 18-vertex, 33-edge ℚ(√2,√3) instance | brief J14 (by J04) | `Proofs/HadwigerNelson/…` (J04 names the module) and the plan's phase record | J04 | 3 | 350 | the gate green on its modules, or the leaves left named | J15 | P2 | wait |
| J15 | Opus | kernel | M2 | K2: FS-87's stripe lemma (V2-T5: under NT₀ every proper four-colouring of the triangular lattice is striped) | brief J15 (by J04) | the same | J14 (the kernel lane is serial) | 3 | 350 | the same | J16 | P2 | wait |
| J16 | Opus | kernel | M2 | K3: FS-39 route C, `χ(F(t)²) = χ(F²)` for transcendental `t`, from the existing valuation-subring lemmas | brief J16 (by J04) | the same | J15 | 3 | 350 | the same | — | P2 | wait |
| J17 | Opus | derivation | M2 | FS-39's hand step: `χ(ℝ²) = sup_F χ(F²)` over real number fields, with Fischer 1990 Remark 1's flawed reduction repaired by real places (Artin–Lang), plus a blind check of it inside J04's fixed list | brief J17 (by J04) | `plans/M2-S1D-bridge.md` | J04 | 2 | 280 | the same | a verifier job, if J04 did not budget one | P2 | wait |
| J18 | Opus | derivation (mind A) | M3 | FS-76 rank one: "every phase rigid ⟹ no wall" at four colours, or a counterexample | brief J18 (by J06) | `plans/M3-S1A-rank-one.md` | J06 | 3 | 350 | a proof, a counterexample, or a named obstruction, saved | J20 | P2 | wait |
| J19 | Opus | derivation (mind B, fenced from A) | M3 | the same question by an independent route: the protocol's next-use line names FS-76 in rank one for two minds | brief J19 (by J06) | `plans/M3-S1B-rank-one.md` | J06 | 3 | 350 | the same | J20 | P2 | wait |
| J20 | Opus | blind verifier | M3 | whichever of J18 or J19 claims a result; the fixed list is written by J06 | brief J20 (by J06) | `plans/M3-S1V-rank-one.md` | J18 or J19 claims | 2.5 | 350 | a verdict per claim | — | P2 | wait |
| J21 | Opus | derivation | M3 | FS-64 at five colours: can a measurable window colouring over finitely many places five-colour ℚ(√167)'s plane? (FS86-CL1 excluded four; at five the real place's `m₁ ≥ 0.229 > 1/5` breaks its count) | brief J21 (by J06) | `plans/M3-S1D-windows-five.md` | J06 | 3 | 350 | the same | J22 | P2 | wait |
| J22 | Opus | blind verifier | M3 | J21's claims | brief J22 (by J06) | `plans/M3-S1V-windows-five.md` | J21 | 2.5 | 350 | the same | — | P2 | wait |
| J23 | Opus | close-math | each M | the derivation file, §R-close, predictions scored, verdict ruled, ledger rows and stub edits *drafted* in the plan; one job per milestone (J23a M1, J23b M2, J23c M3) | the close inventory; the records | `plans/<M>-derivation.md`, the plan's §R-close | the milestone's verifiers and kernel jobs DONE | 1.5 | 300 | every inventory item ticked or declined | J24 or J25 | P2 | wait |
| J24 | Opus | front-page | lane | the first batch: every closed milestone's drafts applied to `CLAUDE.md`, `LEDGER.md`, `FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`; the fact audit green; ≤ 4,000 bytes net per milestone | the close-math drafts | those four files | J05; ≥ 1 J23 | 2 | 330 | audit green, committed | — | P2 | wait |
| J25 | Opus | front-page | lane | the final batch, and the crunch's own close (§5 scored, queue banner) | the same | the same, plus §8 of this file | J24; the last J23 | 2 | 330 | the same | — | P2 | wait |
| J26 | Opus | reader (audit) | — | FS-86 item 70: find `[AmbrusEtAl2023]`'s published verification code and certificate (arXiv 2207.14179 and its ancillary files), and run it unmodified. C14's real-place input is `m₁(ℝ²) ≤ 0.2470`. A run of hours is out (§1.7): stop at pricing | brief (skeleton §4.3) | `plans/PA-ambrus2023-audit.md` | a free slot | 2 | 250 | re-checked, priced out, or not found | a front-page note | P3 | ready |
| J27 | Opus | reframe + derivation | FS-67 | the product question's remainder after the Greenwell–Lovász reading: the equal-ratio case with an IS-imprimitive factor, and the gap `χ_f(H) ≤ k < χ(H)` | the FS-67 stub (after the third close planner hands it back); `plans/PA-products-GL1974-LT2002.md` | `plans/FS67-…` | the third close planner has handed back; a fourth milestone slot is free | 3 | 350 | the same | a verifier | P3 | wait |
| J28 | Opus | derivation | FS-86 | row 88's own question: a non-character four-colouring of ℚ(√59)'s plane, or a proof that `(0, 4)` is forced. The true frontier; prior 0.05–0.1 | the FS-86 records, rows 88–92 and 96 | `plans/FS86-row88-…` | idle capacity only, after the P2 jobs | 3 | 350 | the same | — | P3 | wait |
| J29 | Opus | reframe (post-ban) | FS-84 | ℚ(√47)'s plan for 2026-10-01 on: which solver runs are worth making, now that rows 92 and 96 exclude windows and characters | the FS-84 stub; row 84 | `plans/FS84-five-colours-47.md` (§G, §PA, §IQ, and the post-ban stages) | a free slot late in the crunch | 2.5 | 350 | the plan committed | the post-ban queue | P3 | wait |

**Startable at minute zero:** J01, J02, J03, J04, J06 (five), with J05 waiting only on the third FS-89 close planner's hand-back and J26 as
a filler. If J05 is still waiting when the crunch opens, J06 takes its slot and J05 takes the first slot that frees.

**The kernel lane is serial:** J14 → J15 → J16, each holding the one Lean build. **The front-page lane is serial:** J05 → J24 → J25.

**Not queued, with the reason:**
- **A kernel port of RQ₄**: weeks of topological dynamics on solenoids (compactness of `R̂_S`, minimal sets), for which Mathlib holds only
  pieces. J04 may price its statement's skeleton as a note; it is not a job.
- **FS-59 and FS-84's solver routes** (the `Θ₄` finders, quotients, balls): banned.
- **FS-57, FS-65, FS-69** (relaxations and exact independence numbers): machine-long certificates, not without Kooshi's ruling [P-F6].
- **FS-90's two sanctioned hours**: Kooshi's call (FS-89 item 6).
- **FS-80's averaged certificate**: its LP is allowed only once a derivation fixes its shape. That derivation is M3's, if J06's §IQ asks for
  it.
- **The `[Johnson2000]` and `[Johnson2006]` reading**: not held. Obtaining them is Kooshi's call (§7 item 3); they block the novelty claim
  on row 82 and on J02's result alike.
