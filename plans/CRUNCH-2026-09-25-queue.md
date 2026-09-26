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
  (J24, then J25; J05 if it runs), one job at a time; readers and closes propose rows in their records. A milestone is closed when the
  front-page job that carries it commits (WORKFLOW 9's rule that a close updates the Frontier).
- **CLAUDE.md's byte budget is 300,000 bytes** (Kooshi's ruling, commit 1263d964: *"Increase the CLAUDE.md budget to 300kB. It probably
  still won't be enough, but hopefully it'll buy time."*). The file stands at 275,129, so about **25,000 bytes must last the whole crunch**.
  Every crunch close adds at most **4,000 bytes net** to it; details live in `LEDGER.md` rows and the plans (one home per fact). The fact
  audit (`--base <the previous close>`, and `--dupes`) runs at every front-page commit. The lossless compression job J05 is demoted to a
  P3 filler: run it only if the front page nears 295,000 bytes, or if a slot would otherwise idle.

### 1.6 RAM and the kernel lane
- **The global ceiling is about 100 GB**, enforced by `scripts/slot.py`. Any job over about 2 GiB or 2 minutes runs under
  `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>` with an honest `--mem`; `/tmp` and swap are RAM.
- **One kernel job at a time** (a Lean build takes 60 GB: `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`).
  The owner never launches a second kernel job while one runs; the kernel jobs are chained in §2 by dependency. Iteration uses
  `scripts/slot.py --mem 16 --cpus 4 -- lake env lean <file>` (it builds nothing; declare the measured peak after the first run). **Never
  `lake build`**, bare or named.
- **Worktrees** (Kooshi's ruling, relayed 2026-09-25; the recipe of `plans/CONSOLIDATION-PARALLEL-PLAN.md` §1). The crunch needs none by
  default: kernel jobs are serial and work in the main tree, and every other job writes only `plans/` and `data/`. If the owner ever runs
  a second Lean-*editing* job beside the kernel lane, it works in a worktree with **`.lake/packages` symlinked** (`mkdir -p <wt>/.lake &&
  ln -s /home/kooshi/source/lean-dir/.lake/packages <wt>/.lake/packages`) and **`.lake/build` copied** (`cp -a`, about 4.3 GB, a minute).
  Only a worktree that stays read-only for Lean may symlink the build: two trees compiling different edits race on the same `.olean` paths,
  and the corruption looks like a proof failure. A worktree buys editing parallelism, never build parallelism: one Lean build at a time.
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
| J01 | Opus | blind verifier (stage 0) | M1 | PA-B2 and PA-B3 (FS-89 item 41): is `RS_k(S)` true for every `k < 2·min S`, `\|S\| ≥ 2`, and so `RQ_k` for every `k ≤ 9`? Verdicts at `k = 6, 8, 9`, naming any line that uses `k ≤ 5` | brief J01; the statements verbatim; `plans/FS89-S1VB-verification.md` (VB1–VB4 at `k = 4, 5`), `…-S1V-…`, `…-S0A-…`, `…-S0B-…`; Berend 1984 PDF | `plans/FS91-S0V-band-to-nine.md` | none | 2.5 | 350 | a verdict per claim saved, or 350k | TRUE: J08 runs unconditionally. GAP: a lemma job on the named step. FALSE: J08 is re-aimed at the band-1/6 exit lemma | P1 | DONE |
| J02 | Opus | stage 0 (derive an advisor's sketch) | M1 | Poros's F1: `χ(F²) ≤ 3 ⟹ L(F) ≤ 3` for every real number field, so the conjecture's `L ≤ 4` clause holds everywhere; its instance is `χ(ℚ(α,√7)²) = 4` (FS-82) | brief J02; the sketch verbatim; `plans/FS89-derivation.md` CL2; S0A-3; `plans/FS81-derivation.md` T3, T4, T7; FS73-T22; the FS-82 stub | `plans/FS91-S0F-three-colours.md` | none | 2.5 | 330 | a proof, a named gap, or a counterexample, saved | a proof: J09. A gap: a lemma job. A counterexample: FS-82 as stubbed, into M1's plan | P1 | DONE |
| J03 | Opus | reframe | M1 | M1's §G, §PA, §IQ, subplan and modeling passes; writes briefs J07, J08, J12 and the fixed lists for J10, J11, J13 | brief J03; `CLAUDE.md`, `LEDGER.md` (read in full), stubs FS-91, FS-82, FS-83; FS-89's §R-close | `plans/FS91-character-local-global.md`; briefs J07, J08, J10–J13 | none | 2.5 | 350 | the plan and five briefs committed, or 350k with §G/§PA/§IQ saved | J07, J08, J12 (and their verifiers) | P1 | DONE |
| J04 | Opus | reframe (kernel; §IQ for FS-39's hand step only) | M2 | M2's §G (three columns), §PA (Mathlib and core), the leaf skeletons priced from their first two leaves; writes briefs K1–K3 and D-bridge | brief J04; stubs FS-45, FS-87, FS-39; `Proofs/HadwigerNelson/Copy.lean`, `Homogeneous.lean`, `OneDefect.lean`; G55, G63 | `plans/M2-kernel-lane.md`; briefs J14, J15, J16, J17 | none | 2.5 | 350 | plan and four briefs committed | J14–J17 | P1 | DONE |
| J05 | Opus | front-page (compression; optional since the 300,000-byte ruling) | lane | `CLAUDE.md` compressed without loss by at least 15,000 bytes: the fact audit passes against the pre-job commit, with `--dupes` at 11; no `[PROTECTED]` paragraph, grokking status tag, *Do* line or killing test touched | brief J05; `tools/claude_md_fact_audit.py` | `CLAUDE.md`; `plans/CRUNCH-2026-09-25-compression.md` (its log) | the third FS-89 close planner has handed back | 2.5 | 350 | ≥ 15,000 bytes freed with the audit green, or 350k (commit what passed) | — | P3 | ready |
| J06 | Opus | reframe | M3 | M3's §G (two columns), §PA, §IQ; writes briefs J18–J22 | brief J06 (skeleton §4.2); stubs FS-76, FS-64; FS-79's T34–T36; FS-86's row 92 record (FS86-CL1) | `plans/M3-exotic-colourings.md`; briefs J18, J20–J22 (J19's only if J18 stalls) | the first free slot | 2.5 | 350 | plan and briefs committed | J18, J20–J22 | P1 | DONE |
| J07 | Opus | derivation | M1 | the local–global theorem for character colourings: a character `k`-colouring of `F²` forces a `k`-colourable residue target, `k = 4, 5` (to 9 given J01, as a named hypothesis); its product step PA-T4 or a sumset; the archimedean circle as a factor | brief J07 (by J03) | `plans/FS91-S1D-character.md` | J03 | 3 | 350 | claims stated with grades, saved per stage | J10 | P2 | DONE |
| J08 | Opus | derivation | M1 | character six-colourings at the exposed fields — ℚ(√167) (23, 43, …), `K(√7)`, de Grey's field: is there one? The level-one sumset question at the stable places, after Lemma SW collapses the tower | brief J08 (by J03) | `plans/FS91-S1D-six.md` | J03; J01 (else conditional) | 3 | 350 | the same | J11 | P2 | DONE |
| J09 | Opus | blind derivation (stage 0, beside J02) | M1 | the same statements as J02, from the statements alone, blind to Poros's sketch and to J02 [P, change 2]: the pair can earn row 82's grade, "two independent derivations" | brief J09 (this plan); the statements verbatim; FS89 CL2, FS81 T3/T4/T7, FS73-T22 | `plans/FS91-S0FV-three-colours-blind.md` | none | 2.5 | 350 | a verdict per claim, then (after J02 commits) a divergence table | a divergence item to M1's inventory | P1 | DONE |
| J10 | Opus | blind verifier | M1 | J07's claims; the fixed list is written by J03 before J07 runs | brief J10 (by J03) | `plans/FS91-S1V-character.md` | J07 | 2.5 | 350 | a verdict per claim | — | P2 | DONE |
| J11 | Opus | blind verifier | M1 | J08's claims | brief J11 (by J03) | `plans/FS91-S1V-six.md` | J08 | 2.5 | 350 | the same | — | P2 | DONE |
| J12 | Opus | derivation | M1 | one prime: U3 (`RS₄({p})` false at every `p ≡ 1 (mod 4)`; proved at 5 only) and `MS₄({5})` (are the rank-one minimal sets in `T + A`?) | brief J12 (by J03) | `plans/FS91-S1D-one-prime.md` | J03 | 3 | 350 | the same | J13 | P3 | DONE |
| J13 | Opus | blind verifier | M1 | J12's claims | brief J13 (by J03) | `plans/FS91-S1V-one-prime.md` | J12 | 2 | 300 | the same | — | P3 | DONE |
| J14 | Opus | kernel | M2 | K1: FS-45's chain theorem in Lean (a forced pair at `δ` with `1/δ` a sum of unit vectors refuses `k` colours on `F²`); its 18-vertex, 33-edge ℚ(√2,√3) instance by `decide +kernel`; `five_le_chromaticNumber_planeOver (K(√7))` stated **conditionally on G₄** (the 588-core's 8/3 forcing) as a named hypothesis — G₄ has no proof log on disk and a fresh LRAT needs a solver run, banned [P-c] | brief J14 (by J04) | `Proofs/HadwigerNelson/…` (J04 names the module) and the plan's phase record | J04 | 3 | 350 | the gate green on its modules, or the leaves left named | J15 | P2 | DONE |
| J15 | Opus | kernel | M2 | K2: FS-39 route C, `χ(F(t)²) = χ(F²)` for transcendental `t`, from the existing valuation-subring lemmas (`normOne_subset_valuationSubring`, `colorable_unitDistance_induce_of_valuationSubring`) [P-a] | brief J15 (by J04) | the same | J14 (the kernel lane is serial) | 2.5 | 300 | the same | J16 | P2 | DONE |
| J16 | Opus | kernel | M2 | K3: FS-87's stripe lemma (V2-T5: under NT₀ every proper four-colouring of the triangular lattice is striped); **or FS-47's prime inversion** (`1/p ∈ ℤ[U]` iff no stable prime above `p`, the ring the character results stand on) if J04 prices the stripe lemma above one job [P-a] | brief J16 (by J04) | the same | J15 | 3 | 350 | the same | the other of the two, if time remains | P2 | DONE |
| J17 | Opus | derivation | M2 | FS-39's hand step: `χ(ℝ²) = sup_F χ(F²)` over real number fields, with Fischer 1990 Remark 1's flawed reduction repaired by real places (Artin–Lang). Hand only: Mathlib holds no real algebraic geometry, so its kernel form is not priced this crunch [P-a] | brief J17 (by J04) | `plans/M2-S1D-bridge.md` | J04 | 2 | 280 | the same | a verifier job, if J04 did not budget one | P2 | DONE |
| J18 | Opus | derivation | M3 | FS-76 rank one: "every phase rigid ⟹ no wall" at four colours, or a counterexample | brief J18 (by J06) | `plans/M3-S1A-rank-one.md` | J06 | 3 | 350 | a stage gate at about 2.5 h: a proof, a counterexample, or a stall at a named step, saved | J20; on a named stall, J19 on that step | P2 | DONE |
| J19 | Opus | derivation (conditional second mind) | M3 | only if J18 stalls at a named step: that step, by a second mind given J18's statement of it [P-b] — rank one is one-dimensional subshift territory, whose route is known in outline, so the seventh run's shape applies and a second mind is paid for only on failure | brief J19 (by J06, from J18's stall) | `plans/M3-S1B-rank-one.md` | J18 stalled | 2.5 | 300 | the same | J20 | P2 | DONE |
| J20 | Opus | blind verifier | M3 | whichever of J18 or J19 claims a result; the fixed list is written by J06 | brief J20 (by J06) | `plans/M3-S1V-rank-one.md` | J18 or J19 claims | 2.5 | 350 | a verdict per claim | — | P2 | DONE |
| J21 | Opus | derivation | M3 | FS-64 at five colours: can a measurable window colouring over finitely many places five-colour ℚ(√167)'s plane? (FS86-CL1 excluded four; at five the real place's `m₁ ≥ 0.229 > 1/5` breaks its count) | brief J21 (by J06) | `plans/M3-S1D-windows-five.md` | J06 | 3 | 350 | the same | J22 | P2 | DONE |
| J22 | Opus | blind verifier | M3 | J21's claims | brief J22 (by J06) | `plans/M3-S1V-windows-five.md` | J21 | 2.5 | 350 | the same | — | P2 | DONE (resumed by J22b) |
| J23 | Opus | close-math | each M | the derivation file, §R-close, predictions scored, verdict ruled, ledger rows and stub edits *drafted* in the plan; one job per milestone (J23a M1, J23b M2, J23c M3) | the close inventory; the records | `plans/<M>-derivation.md`, the plan's §R-close | the milestone's verifiers and kernel jobs DONE | 1.5 | 300 | every inventory item ticked or declined | J24 or J25 | P2 | wait |
| J24 | Opus | front-page | lane | the first batch: every closed milestone's drafts applied to `CLAUDE.md`, `LEDGER.md`, `FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`; the fact audit green; ≤ 4,000 bytes net per milestone | the close-math drafts | those four files | ≥ 1 J23; never beside J05 | 2 | 330 | audit green, committed | — | P2 | DONE |
| J25 | Opus | front-page | lane | the final batch, and the crunch's own close (§5 scored, queue banner) | the same | the same, plus §8 of this file | J24; the last J23 | 2 | 330 | the same | — | P2 | wait |
| J26 | Opus | reader (audit) | — | FS-86 item 70: find `[AmbrusEtAl2023]`'s published verification code and certificate (arXiv 2207.14179 and its ancillary files), and run it unmodified. C14's real-place input is `m₁(ℝ²) ≤ 0.2470`. A run of hours is out (§1.7): stop at pricing | brief (skeleton §4.3) | `plans/PA-ambrus2023-audit.md` | a free slot | 2 | 250 | re-checked, priced out, or not found | a front-page note | P3 | DONE |
| J27 | Opus | reframe + derivation | FS-67 | the product question's remainder after the Greenwell–Lovász reading: the equal-ratio case with an IS-imprimitive factor, and the gap `χ_f(H) ≤ k < χ(H)` | the FS-67 stub (after the third close planner hands it back); `plans/PA-products-GL1974-LT2002.md` | `plans/FS67-…` | the third close planner has handed back; a fourth milestone slot is free | 3 | 350 | the same | a verifier | P3 | DONE |
| J28 | Opus | derivation | FS-86 | row 88's own question: a non-character four-colouring of ℚ(√59)'s plane, or a proof that `(0, 4)` is forced. The true frontier; prior 0.05–0.1 | the FS-86 records, rows 88–92 and 96 | `plans/FS86-row88-…` | idle capacity only, after the P2 jobs | 3 | 350 | the same | — | P3 | DONE |
| J29 | Opus | reframe (post-ban; first of the P3 jobs) | FS-84 | ℚ(√47)'s plan for 2026-10-01 on: which solver runs are worth making, now that rows 92 and 96 exclude windows and characters | the FS-84 stub; row 84 | `plans/FS84-five-colours-47.md` (§G, §PA, §IQ, and the post-ban stages) | the first idle slot | 2.5 | 350 | the plan committed | the post-ban queue | P3 | DONE |
| J17V | Opus | blind verifier | M2 | C1–C4 blind, then divergence | brief J17V-M2-bridge-blind.md | `plans/M2-S1V-bridge.md` | J17 | 1 | 150 | verdicts committed | — | P3 | declined by the owner (J17's recommendation; Lemma NP goes to the kernel instead) |
| J03a | Opus | blind verifier | M1 | J01-7: Lemma SW-m at every k ≥ 3 and its consequences RS_k, RQ_k every k, Θ_k(R_F) ⊆ T + A every F ⊆ ℝ | brief data/crunch-2026-09-25/briefs/J03a-SWm-blind-reading.md | `plans/FS91-S0V2-SWm-second-reading.md` | none | 2 | 250 | a verdict per claim saved, or 250k | none | P1 | DONE |
| J17K | Opus | kernel | M2 | B0 IsRealClosed instances, B1 bridge + C4 conditional, Lemma NP via Polynomial.abc | brief data/crunch-2026-09-25/briefs/J17K-M2-bridge-kernel.md | `plans/M2-S4K-bridge.md` | J16 | 3 | 350 | gate green or leaves named | — | P2 | DONE |
| J30 | Opus | bookkeeping audit | crunch-wide | rescue scratch files, cross-check job reports and inventories, front-page proposals (Kooshi's request) | brief data/crunch-2026-09-25/briefs/J30-wiring-audit.md | `plans/CRUNCH-2026-09-25-INDEX.md` | — | — | 190 | — | none | P1 | DONE |
| J24a | Opus | front-page | crunch-wide | front-page pointers | brief data/crunch-2026-09-25/briefs/J24a-front-page-pointers.md | — | — | — | — | — | none | P1 | DONE |
| J09v | Opus | blind verifier | M1 | J4, J4-C, J4-A (no-mixing, second blind route) | brief data/crunch-2026-09-25/briefs/J09v-M1-no-mixing-blind.md | `plans/FS91-S1V-no-mixing.md` | J09 | — | — | — | none | P2 | DONE |
| J23p | Opus | prior-art gate | M1 | §PA sweep for M1's derivations | brief data/crunch-2026-09-25/briefs/J23p-M1-prior-art-gate.md | `plans/FS91-PA-close.md` | — | — | — | — | none | P2 | DONE |
| J17K2 | Opus | kernel | M2 | Lemma NP, C3 one-variable (C3⁺ if time) in the kernel via Polynomial.abc | brief data/crunch-2026-09-25/briefs/J17K2-M2-lemma-NP-kernel.md; M2-S1D-bridge §2.3; M2-S4K-bridge | `NoParam.lean`, `plans/M2-S5K-noparam.md` | J17K | 3 | 300 | 3 h or 300k: land green, name leaves | none | P3 | DONE |
| J23a | Opus | close-math | M1 | M1's derivation file, §R-close drafts | brief: write from queue §4.5 when launched; the close inventory; the records | `plans/FS91-derivation.md`, `plans/FS91-character-local-global.md` §R-close | J13 | 1.5 | 300 | every inventory item ticked or declined | none | P2 | DONE |
| J23a2 | Opus | close-math (resumed) | M1 | resumes J23a at stage 3 (§R-close) | same brief as J23a (queue §4.5); `plans/FS91-character-local-global.md` §R-close stage headings; the inventory's ticks | `plans/FS91-derivation.md`, `plans/FS91-character-local-global.md` §R-close | J13 | 1.5 | 300 | every inventory item ticked or declined | — | P2 | DONE |
| J23b | Opus | close-math | M2 | M2's derivation file, §R-close drafts | brief data/crunch-2026-09-25/briefs/J23b-M2-close-math.md; the close inventory; the records | `plans/M2-derivation.md`, `plans/M2-kernel-lane.md` §R-close | J17K2 | 1.5 | 300 | every inventory item ticked or declined | — | P2 | DONE |
| J23c | Opus | close-math | M3 | M3's derivation file, §R-close drafts | brief data/crunch-2026-09-25/briefs/J23c-M3-close-math.md; the close inventory; the records | `plans/M3-derivation.md`, `plans/M3-exotic-colourings.md` §R-close | J18/J19, J20, J21, J22 | 1.5 | 300 | every inventory item ticked or declined | — | P2 | DONE |
| J27D | Opus | derivation | FS-67 | DA-1′–DD-2: the Hedetniemi transfer, three colours, the spectral pullbacks, the tight and equal cases | plans/FS67-tight-products.md §4.1, §4.3, §5.1 | plans/FS67-J27D-derivation.md | J27 committed | 3 | 350 | hand back by 420k; DD may end GAP | a verifier (J27V, written) | P3 — brief data/crunch-2026-09-25/briefs/J27D-FS67-derivation.md | DONE |
| J27V | Opus | blind verifier | FS-67 | the fixed list V-DA-1′–V-DD-2 | the brief's verified inputs | plans/FS67-J27V-verification.md | blind phase: none; stages 3–4: J27D's report | 2.5 | 300 | blind phase ≤ 60 % of budget | none | P3 — brief data/crunch-2026-09-25/briefs/J27V-FS67-verifier.md | run |
| J28D | Opus | derivation | row 88 (FS-86; plans/FS86-row88-rigidity.md) | T-A (Q-μ/Q-tr decomposition), T-C (Theorem C over real type-(B) fields), T-C(A) (ℚ(√47)), T-B1, T-B2 — each TRUE/FALSE/GAP | brief data/crunch-2026-09-25/briefs/J28D-row88-derivation.md | plans/FS86-R88-D-derivation.md | J28 (done) | 3 | 350 | every claim with a verdict; hand back by 420k | J28V's lemma phase reads its lemma statements | P3 | DONE |
| J28V | Opus | blind verifier | row 88 (FS-86) | verdicts on T-A, T-B1, T-B2, T-C, T-C(A) from the fixed list | brief data/crunch-2026-09-25/briefs/J28V-row88-verifier.md | plans/FS86-R88-V-verification.md | none for the blind phase; J28D stage 5 for the lemma phase | 3 | 350 | a verdict per claim; divergence table | none | P3 | wait |
| J31 | opus | derivation | FS-84 | S1a–S1e | plan §M | plans/FS84-S1-derivation.md | none | 3 | 350 | GAP named after two stalls | S1V | post-ban (from 2026-10-01; solver-free, could run earlier on the owner's ruling) | DONE |
| FS84-S1V | opus | blind verifier | FS-84 | V1–V3 | rows 75,88,92,95,96 | plans/FS84-S1V-verification.md | S1 | 2 | 300 | per-claim verdict; lemma-statement fallback | none | post-ban (from 2026-10-01) | run |
| J29-S4-FS84-colouring-side | opus | SAT+finders | FS-84 | survivors coloured or not | S1c, FS-81 records | plans/FS84-S4-colouring.md | S1 | 4 | 350 | per-lattice first colouring; 4 h walls | S2 brief if a survivor stands | post-ban (from 2026-10-01) | wait |
| J23bd | — | — | M2 | both corrections TRUE against the held PDFs — [Fischer1990] is Discrete Math. 82; the valuation lemma's generality is [Madore2015] Prop. 3.2 at d = 2; module doc rewritten | — | data/m2/j23bd/record.md | — | — | — | — | none | — | DONE |
| J23cpa | — | prior-art gate | M3 | J21-MX as stated (arbitrary first factor, compact K, Borel/measurable) NOT FOUND by 53 zbMATH queries, 6 papers read; partly in print (Pak–Vilenchik 2013 Thm 3; BEL/[Tardif2008] Thm 3.2) | — | plans/M3-PA-mixing.md | — | — | — | — | none | — | DONE |
| J32 | — | — | — | tool defect fix: scripts/gate_report.py now reads both recorded sources (baseline header; CLAUDE.md § The gate; § Trust ledger) with controls; real gate run found CLAUDE.md § The gate's recorded counts stale (6795/278/275/253 → 7051/304/279/257) | — | data/gate-fix/j32/record.md | — | — | — | — | none | — | DONE |
| J33 | — | — | — | — (no report or SPAWN line available to the clerk this run; git status shows uncommitted edits to several plans/*-derivation.md files, not committed by the clerk per this run's instruction) | — | — | — | — | — | — | — | — | run |

**Startable at minute zero:** J01, J02, J09, J03, J04 — five, every one Opus. J06 takes the first slot that frees. The P3 order, when a
slot would idle: J29 (if J02 and J09 land F1, the conjecture's testable range below the problem shrinks to `L = 5` — ℚ(√47), ℚ(√143),
ℚ(√311), ℚ(√335), ℚ(√3,√5), four-colour questions no character decides — so FS-84's post-ban plan comes first [P]), then J26, J27, J12,
J05, J28.

**The kernel lane is serial:** J14 (FS-45) → J15 (FS-39 route C) → J16 (FS-87's stripe lemma, or FS-47), each holding the one Lean build. **The front-page lane is serial:** J24 → J25, with J05 (if run) never beside either.

**Not queued, with the reason:**
- **A kernel port of RQ₄**: weeks of topological dynamics on solenoids (compactness of `R̂_S`, minimal sets), for which Mathlib holds only
  pieces. J04 may price its statement's skeleton as a note; it is not a job.
- **FS-59 and FS-84's solver routes** (the `Θ₄` finders, quotients, balls): banned.
- **FS-57, FS-65, FS-69** (relaxations and exact independence numbers): machine-long certificates, not without Kooshi's ruling [P-F6].
- **FS-90's two sanctioned hours**: Kooshi's call (FS-89 item 6).
- **FS-45's D3, the unconditional `K(√7)` instance**: it needs a fresh LRAT for G₄, so a solver run. It is post-ban (2026-10-01 on); J14 states the instance conditionally.
- **FS-80's averaged certificate**: its LP is allowed only once a derivation fixes its shape. That derivation is M3's, if J06's §IQ asks for
  it.
- **The `[Johnson2000]` and `[Johnson2006]` reading**: not held. Obtaining them is Kooshi's call (§7 item 3); they block the novelty claim
  on row 82 and on J02's result alike.

---

## §3. The briefs written by this plan (ready to paste: a launch is "Your brief is on disk: read `<path>` in full first.")

| job | brief | notes |
|---|---|---|
| all | `data/crunch-2026-09-25/briefs/STANDING-RULES.md` | part of every brief. It carries: the no-children rule and its reason, work in stages and its reason, the resume paragraph, the ban and Kooshi's intent, the would-have-searched log, "all novel knowledge is a success" and don't lean to a yes, verbatim quotation, commits by path, the report form |
| J00 | `…/briefs/J00-clerk.md` | Sonnet; recurring; the launch line also names the jobs started since the last fold |
| J01 | `…/briefs/J01-band-to-nine-verifier.md` | blind; fenced from the PA-B3 argument; reports after `k = 6` too |
| J02 | `…/briefs/J02-three-colours-stage0.md` | carries Poros's sketch verbatim, including the sharpened message, which exists nowhere else on disk |
| J09 | `…/briefs/J09-three-colours-blind.md` | blind to the sketch and to J02; waits for J02's lemma statements at stage 4 |
| J03 | `…/briefs/J03-M1-reframe.md` | the reframe template; writes J07, J08, J10–J13 |
| J04 | `…/briefs/J04-M2-kernel-reframe.md` | writes J14–J17 (and J17V); the kernel lines every kernel brief carries verbatim |
| J06 | `…/briefs/J06-M3-reframe.md` | writes J18, J20–J22 and J19's skeleton |

## §4. Skeletons for every other brief (for the job that writes it)

### 4.1 Derivation, blind verifier, kernel (written by the milestone's reframe job)
```
*Brief for crunch job **J<nn>**, milestone <M> (<stub>), <kind>. Opus 5.5, <date>. Written by <writer job> (<plan path> §S).*
Hello. You are de Bruijn (DEBRUIJN.md), <role>, in /home/kooshi/source/lean-dir. Read CLAUDE.md, WORKFLOW.md, DEBRUIJN.md from disk.
STANDING-RULES.md is part of this brief; read it in full.
## The question, and why now            — plain words; what either answer would buy; "every outcome counts" (rule 4) in one line
## The statements (verbatim)            — each in quotation marks with its source address; the definitions' addresses
## Read first, from disk                — the verified inputs, by path and theorem id
## Fenced until <stage> is committed    — records, briefs, inventories, commits that carry a route (verifiers: the derivation's
                                          record, data, tools, brief, the close inventory, the plan's route sections)
## Stages                               — each with a token size; stage 1 = the quotation check + C0 (a probability per claim);
                                          for a verifier: blind phase, then the lemma-statement phase, then the divergence table;
                                          for a kernel job: the skeleton's first two leaves priced before anything else
## Record and paths                     — record path; data/<m>/<job>/; tools/crunch_<job>_*.py; budget (harness) and hand-back line;
                                          the report after which stages
```
Kernel briefs add J04's five verbatim lines (the build line, the slot refusal, the gate, `--` comments, "you are the only kernel job").

### 4.2 Reframe (J29, J27's reframe, and any milestone a job proposes): copy J03's brief and change
the milestone block (its questions, verbatim from its stub), the verdict columns, the §PA disciplines, the briefs it must write, and the
paths. **J29 (FS-84, post-ban)**: add "the plan's stages after the reframe run from 2026-10-01; write their briefs, and price each solver
run against row 84's band (the degree law's four-colour aim is about 18.4), rows 92 and 96 (windows and characters are excluded), and the
advisor's point that if M1's stage 0 lands, `L = 5` is the only testable range below the problem itself."

### 4.3 Reader or audit (J26 and prior-art readers)
Copy `data/fs89/briefs/PA-tardif2023-reader-brief.md`'s form, with the questions to answer, the verdict vocabulary ("not in X; the
method is X's", never "new"), the rule that bibliography rows are proposed in the record and never written, and G50's "an abstract is
not a reading". **J26 specifically:**
- find `[AmbrusEtAl2023]`'s verification code and certificate (arXiv 2207.14179, its ancillary files, the authors' pages);
- if found, run it unmodified under `scripts/slot.py`, and only if its documented runtime is under about an hour;
- otherwise price it and stop.

A run of hours is a machine-long certificate (§1.7).

### 4.4 Front-page (J24, J25) and compression (J05)
Copy `data/fs89/briefs/CL-close-planner-brief.md`'s front-page sections, and add:
- the single-writer rule (§1.5);
- the byte cap: at most 4,000 bytes net per milestone, and the file under 300,000;
- the fact audit `python3 tools/claude_md_fact_audit.py --base <the previous front-page commit>`, with `--dupes`, run before each commit
  and its verdict quoted in the record;
- "never touch a `[PROTECTED …]` paragraph, a grokking's status tag, a *Do* line or a killing test";
- the forward propagation of every new grokking to the stubs it bears on (WORKFLOW 9).

J05 is the same with no milestone, and a target of freeing at least 15,000 bytes.

### 4.5 Close-math (J23a–c)
Copy `data/fs89/briefs/CL2-close-planner-brief.md`'s form, with these outputs:
- `plans/<M>-derivation.md`, the theorems filed per WORKFLOW 9;
- the plan's §R-close: the §G re-read, the §PA sweep, the §IQ re-read and G72's count, the predictions scored once, the verdict ruled in
  four parts, the would-have-searched log counted;
- **drafts** of the `LEDGER.md` rows, the `CLAUDE.md` Frontier lines (at most 4,000 bytes net), the stub banners and the FRONTIER-STUBS
  re-rank, all written in the plan, never in those files;
- every inventory item ticked or declined.

Then SPAWN the front-page job if none is queued.

---

## §5. Registered expectations (the planner's, before any job runs; scored once by J25)

Kooshi's line applies: *"All novel knowledge is a success."* A no-go, a GAP with its step named, or a counterexample is a result, and
these probabilities are about which result, never about whether a job "worked".

| id | expectation | p |
|---|---|---|
| E1 | J01: PA-B2 TRUE | 0.85 |
| E1b | J01: PA-B3 TRUE at `k = 6` (so `RQ₆`) | 0.65 |
| E1c | J01: PA-B3 TRUE at every `k ≤ 9` | 0.50 |
| E1d | J01: FALSE at some `k ≤ 9` | 0.10 |
| E2 | J02 proves S1 (the advisor holds 0.75) | 0.65 |
| E2b | J09 reaches S1 TRUE blind, and the two agree ("two independent derivations") | 0.40 |
| E2c | a point of `Θ₃(ℚ(α,√7))` (a falsifier at `L = 4`) | 0.03 |
| E3 | J07 and J10: the character local–global theorem at `k = 4, 5` proved and blind-verified | 0.40 |
| E4 | J08 decides the character six-colourings of ℚ(√167), either way | 0.35 |
| E4b | given E4: none exists | 0.80 |
| E4c | a six-colour band character of `Γ₂₃` at level one, hence `χ(Γ₂₃) = 6` | 0.03 |
| E5 | J12: U3 proved at every `p ≡ 1 (mod 4)` | 0.35 |
| E6 | FS-76 rank one: "every phase rigid ⟹ no wall" proved | 0.25 |
| E6b | FS-76 rank one: a counterexample | 0.05 |
| E6c | FS-76 rank one: J18 stalls at a named step, and J19 runs | 0.55 |
| E7 | FS-64: five-colour measurable windows over ℚ(√167) excluded | 0.30 |
| E7b | FS-64: such a window colouring constructed | 0.03 |
| E8 | kernel: J14's chain theorem and 18-vertex instance green | 0.60 |
| E8b | kernel: J15's route C green | 0.55 |
| E8c | kernel: J16 green | 0.35 |
| E8d | kernel: at least one new module through the full gate | 0.80 |
| E9 | the advisor's hunch's falsifier: at least 3.5 agents on derivation, verification or kernel work, averaged over the first 8 h | 0.40 |
| E9b | at least 20 jobs reach DONE | 0.50 |
| E9c | a halt costs more than one stage anywhere | 0.10 |
| E10 | M1 closed on the front page | 0.60 |
| E10b | at least two milestones closed | 0.45 |
| E10c | all three milestones closed | 0.25 |
| E11 | at least three new `LEDGER.md` rows | 0.60 |
| E12 | a lower bound above five | < 0.01 |

**A good crunch**, stated so it can be scored:
1. At least one class theorem at the grade "two independent derivations" or "derivation plus blind verification", from E2b or E3. I put
   this at 0.65.
2. At least one kernel promotion (E8d).
3. Every milestone that landed is closed on the front page, within the byte cap.
4. No work is lost to a halt beyond one stage.

Every no-go filed at its grade counts toward (1) as fully as a yes.

## §6. The advisor's advice, and where I disagreed

Poros's record: `plans/POROS-2026-09-25-crunch-plan.md`. One draft was exchanged: the protocol at 7e35da20, and its reply.

| item | advice | taken? |
|---|---|---|
| F1 | FS-82 as a corollary of row 95; the sketch sharpened to seven steps and three checks | **yes**: J02, stage 0, carries it verbatim |
| F2 | the character local–global theorem as the unifying target | **yes**: M1's question 1, J07 |
| F3 | concurrent milestones need Kooshi's word; amortise the reframe and the close; open inventories at launch | **yes** (§1.1, §1.5, §7 item 1), **except** "the crunch planner carries §G for the first milestones" (below) |
| F4, F6 | one serial kernel lane with a slot-refusal rule; no machine-long certificates | **yes** (§1.6, §1.7) |
| F5 | say first that the crunch cannot land a bound above five | **yes**, the opening paragraph |
| (a) | kernel order FS-45 → FS-39 route C → FS-87, FS-47 if K2 runs long; Artin–Lang by hand only | **yes** (J14–J17) |
| (b) | FS-76 rank one: one mind plus a verifier, and a second mind only on a named stall | **yes** (J18–J20) |
| (c) | FS-45's unconditional `K(√7)` instance needs a solver: condition it on G₄ | **yes** (J14; the post-ban item in §2) |
| change 1 | J05 off minute zero | **yes**; Kooshi's 300,000-byte ruling made it optional |
| change 2 | J09 blind beside J02 from minute zero | **yes**; the cost is that J06 moves to the first free slot |
| frame | if F1 lands, `L = 5` is the only testable range below the problem, so FS-84's post-ban plan comes first of P3 | **yes** (J29) |

**Disagreements, recorded:**
1. **"The crunch planner carries the §G bearings for the first milestones" — declined.**
   - WORKFLOW 3.1 item 4 wants the milestone's own planner to walk the corpus with `LEDGER.md` open, fresh.
   - My budget (about 300k) cannot hold `LEDGER.md` (about 75k tokens) and a three-column walk as well.
   - The reframe jobs pay the corpus load once per pair instead (§1.9).
   - Confidence: high.
2. **"A prior-art reader for F1 and F2 at minute zero" — declined.**
   - M1's reframe runs §PA in the recognition's words within its first two hours.
   - The papers that actually block a novelty claim, the Johnson pair, are not held (§7 item 3).
   - A separate reader would duplicate §PA's queries.
   - Confidence: medium. If J03's §PA overruns its time box, the owner can split it into a reader job.

**My own deviations from WORKFLOW, for the owner to hold me to:**
- the clerk writes close inventories as the owner's pen (§1.3);
- the close is split into close-math and a batched front page (§1.5);
- stage-0 jobs run before their milestone's reframe (§1.1, FS-89's precedent).

## §7. For Kooshi, through the owner (ranked)

**Must decide before the crunch starts (1)**
1. **Several milestones open at once.**
   - WORKFLOW says "finish and commit a milestone's quality gate before reframing the next". Five agents need up to three open milestones.
   - **Recommendation:** at most three open at once, and no job consumes another open milestone's unverified claim except as a named
     hypothesis.
   - **Alternative:** one milestone at a time with five agents on it. That starves: M1 has at most four parallel jobs, and its reframe
     gates most of them.
   - **Default if he says nothing:** the owner runs the queue as written, reading his "4–5 agents nonstop … jobs can spawn new jobs" as
     that word, and records it. Confidence: high.

**Decide when convenient (1)**

3. **Obtain `[Johnson2000]` and `[Johnson2006]`** (Geombinatorics IX(4) 170–179 and XVI(1) 209–218; `BIBLIOGRAPHY.md` rows 2–3 of the
   request list).
   - They block the novelty claim on row 82, and would block one on J02's result.
   - **Default:** both rows say "not claimed new while unread".

**Already settled, skip (1)**

2. **CLAUDE.md's budget.** Kooshi raised it to 300,000 bytes (commit 1263d964), so the compression job J05 is an optional filler.
   - Each close adds at most 4,000 bytes net, against about 25,000 of room for the whole crunch.
   - The owner had asked for either an early compression job or a question to Kooshi. The ruling arrived first; the byte cap is the
     planner's choice. Confidence: high.

**Know, don't decide (3)**

4. **Not queued without his ruling:**
   - FS-90's two sanctioned search hours (FS-89 item 6);
   - FS-57's machine-long relaxation;
   - FS-45's unconditional `K(√7)` instance (post-ban).
5. **FS-89's carried items 5 and 17 stay his.** The crunch applies item 17's reading pending his ruling: a complete enumeration of a
   finite set that a derivation fixed first is in, and logged.
6. **The crunch cannot land a lower bound above five** (the opening paragraph).

## §8. The crunch's close

*Written by J25: the jobs run and their harness totals; §5 scored; the milestones closed; what the queue hands to 2026-10-01.*
