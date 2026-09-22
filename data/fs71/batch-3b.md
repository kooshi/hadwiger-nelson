# FS-71 batch 3b — the theorem audit of M56–M57, the mascot day, row 57's consolidation, and Q8

*Filed 2026-09-22 by the batch-3b implementer, a Sonnet 5 agent working alone (no subagent, fork or workflow
spawned — see "What was delegated" at the end). Read first, per the brief: `plans/FS71-theorem-audit.md` in full,
`plans/FS70-derivation.md` (the template), the existing derivation files (`ls plans/*-derivation.md`),
`data/fs71/batch-3a.md`, `LEDGER.md` rows 50, 51, 57, 58 and § B.*

## Headline

**M56–M57 + Mascot + row 57: 30 theorems filed in 5 files, 3 attributions confirmed/cross-referenced, 0 gaps,
2 conjectures surfaced not claimed; enumeration complete.**

Seven theorems from M56 (`plans/M56-derivation.md`), nine from M57 (`plans/M57-derivation.md`), eleven from the
2026-09-08/09 mascot-challenge day — five from the project's own working session, six from a parallel exploration
credited "Coxeter" per `CLAUDE.md` G51's naming (`plans/MASCOT-derivation.md`), one from row 57's non-kernel
Hurwitz-order instance (`plans/R57-derivation.md`), and two from reconciling the M51-era `Q8` note against
`plans/M51-derivation.md`'s already-committed M51-T1 (`plans/Q8-derivation.md`). No milestone in the batch was
empty; every ledger row's grade-tagged clause is accounted for.

**The most consequential finding is that the mascot day holds six real theorems with no grokking-level presence
in `CLAUDE.md` at all.** Row 58 cites only `Mascot.lean`'s kernel content (filed here as MASCOT-T5); the parallel
session's rigidity theorem (K-fabric's `√3`-clean colourings are exactly Theorem B's two residue colourings, via
a `K₄ × K₄` quotient identifying the two primes above 2), its cross-edge theorem (explaining exactly why
`[Parts2020hv]`'s human-verifiable proof needs `√5`), and its `ρ₄` theorem (an unconditional `√3`-pigeonhole
realised inside `K(√7)`-fabric, the first known there once its carrier is shown not to embed the existing
`core9_plane` carrier) were sitting in a 561-line same-day record, cited by no ledger row and no grokking. This is
not a mistake — the session that produced them did not reach a kernel theorem and was correctly not promoted at
the time — but it means six hand theorems existed unindexed for two weeks, exactly FS-71's target case.

**Second finding: the Hurwitz-order instance of Theorem A (`χ(ℚ⁴) = 4`) has no plan file at all.** Its
mathematical write-up was composed directly into `LEDGER.md` row 57's own text, with `tools/quaternion_q4_check.py`
as its sole verification artifact — `rg` across `plans/` and `data/` for "Hurwitz", "quaternion", "BendaPerles"
and "ℚ⁴" returns nothing outside the ledger row and the tool. Filed as R57-T1, with the ledger row's own text
treated as the theorem's proof address (per `plans/FS71-theorem-audit.md` §M.3's allowance for a proof that
"is" the row plus a tool, when no other record exists).

## The census table

*One row per file in the batch. "Candidates" lists what the ledger row plus the file's own content offered;
"classified as" gives kernel / measurement / reading / instance / prior art / conjecture with one line why, per
candidate.*

| file | ledger row | candidates found | filed as | classified as |
|---|---|---|---|---|
| `plans/M56-arithmetic-of-tightness.md` | 50 | L1–L8 (seven derivations, one conjecture); the pre-milestone stub's `certify-not-colorable` and jackpot clauses (withdrawn); the field-as-input Σ₀-ring reading | **M56-T1 through T7** | hand, closes, filed (L1–L6, L8) · kernel-partial (L1's base case, L2 fully) · conjecture, not claimed, forward-pointed to G55/batch 5 (L7) · readings not filed (the defect gauge on `W`, the registered-prediction scoring tables) |
| `plans/M57-additive-rigidity.md` | 51 | D1–D5 (five derivations); four tools-grade census sections (R1, R2, R3, R4/R5) | **M57-T1 through T9** | kernel (D1) · hand, closes, filed (D2–D5) · tools, closes, filed (the four census entries) · readings not filed (the richness formula's genericity mismatch on real objects, the scoring tables) |
| `plans/MASCOT-DERIVATION.md` | 58 | the parity law, the chord-ratio identity, the uniqueness search, the deep-chord sieve, the kernel theorem (already row 58's) | **MASCOT-T1 through T5** | hand, closes, filed (T1, T2, T4) · tools, closes, filed (T3) · kernel, filed with full quantifiers (T5, already row 58's citation) · the `core9_plane` vacuity retraction confirmed as row 31's, not re-filed |
| `plans/COXETER-2026-09-08-mascot.md` | 58 (no prior citation) | the hexagon lemma + rigidity theorem + dichotomy (bundled), the cross-edge theorem + pinning consequences (bundled), the `ρ₄` theorem, the `core9` non-embedding finding, the one-case dichotomy, the triangle exhaustion; §10's methodological finding (not filed, already G21/G51's) | **MASCOT-T6 through T11** | hand, closes, filed (all six) · one conjecture surfaced per entry where the source itself reports "not closed" (MASCOT-T7's Consequence 3 gap, MASCOT-T10's case (ii)) |
| `plans/POROS-2026-09-08-mascot.md` | 58 (no prior citation) | a registered card (structural-vs-finite question) with a falsifier; an amendment splitting it cheaper after `[ExooIsmailescu2019]` was read | none — a reading, not a theorem | a registered open question with an explicit falsifier, unresolved by anything else in this batch's files; noted in MASCOT-derivation.md's readings section, not filed |
| `plans/A1-theorem-A-kernel.md`, `plans/STUB-theorem-A-kernel.md` | 57 | the field-level gap ("not proved..."); the Hurwitz-order instance (found only in `LEDGER.md` row 57 and `tools/quaternion_q4_check.py`, not in either plan file); a self-graded unformalised vacuity argument (R6) | **R57-T1**; the gap filed as a named conjecture | tools, closes, filed (R57-T1, the Hurwitz instance) · conjecture, stub-pointed to FS-47 (the field-level gap, row 57's own "not proved" words) · reading, self-graded "not a theorem" by its own docstring, not filed (R6's vacuity argument) |
| `plans/Q8-FIVE-CHROMATIC-OBJECTS.md` | — (folded into M51-T1) | Object Cards 1–2 (confirmed = M51-T1, no correction); Object Card 3 (the four-copy composition + jackpot null); Object Card 4 (the 883-point 1-minimal core); Object Card 5 (a robustness re-confirmation); the atlas censuses; "witnesses, not descent material" (confirmed = M52-derivation.md's existing reading) | **Q8-T1, Q8-T2** | tools, closes, filed (the 883-core, the four-copy composition + null search) · confirmation, not re-filed (Cards 1–2 = M51-T1 exactly) · reading, already correctly filed elsewhere, not duplicated (Card 5, the atlas, the spare-colour-halo reading) |

## Progress and resume

**Batch 3b is complete: M56, M57, the mascot day (both sessions), row 57's consolidation, and Q8 all filed — no
successor needed for this batch.** Per `plans/FS71-theorem-audit.md` §S.6's ten-batch numbering, batch 3c
(M58–M61) is next.

## Theorems this phase proved

**None** — as expected for an audit; the audit's own products are demotions, attributions, and the one genuine
correction below (a finding about the corpus, not new mathematics).

**One finding worth flagging as a correction, not a new theorem**: `plans/FS71-theorem-audit.md` §G.1's own table
entry for G38 asks "the linear method's thresholds (2, 3, 4, then nothing below 7 — proved where? M56)". Having
now read both M53's field-wall file (via batch 3a's report and `LEDGER.md`'s M53-T8) and M56's own text in full,
**the answer is M53-T8 ("Theorem A′ + Corollary 6.6: a norm-one-avoiding additive subgroup refines the residue
colouring"), not M56**: M56's own content is exclusively about Fischer's *abelian-group-homomorphism* additive
colouring apparatus (a different, related mechanism from Fischer's coset-of-a-norm-one-avoiding-subgroup
construction that G38 and M53-T8 describe), and M56 nowhere claims to originate the coset method. This confirms
batch 3a's own flag (item 3c of their "flagged for later batches" list) rather than contradicting it. No
`CLAUDE.md` text misattributes this (G38's own prose names no milestone), so no edit is proposed — the open
question was only in this audit's own planning table, and it is now closed by cross-reference.

## Proposed edits to `CLAUDE.md`

**None.** No grokking in G1–G69 was found stated incorrectly by this batch's material — G42's gauge
characterisation, cited as "kernel, derived or hand?" in the brief, is confirmed **hand** (M57-T3/D3), correctly
described by G42's existing text with no correction needed. Two candidates were considered and declined:

1. **A new grokking for the mascot day's six unindexed Coxeter theorems** (the K-fabric rigidity theorem, the
   cross-edge theorem, the `ρ₄` pigeonhole) — **declined**: minting a grokking is a judgement about what the
   project's *understanding* should hold going forward, which is the deciding session's call at a milestone's
   close (`WORKFLOW.md` step 9), not this audit's. Flagged here for Kooshi's attention instead: these are real,
   filed, hand-proved theorems with no promotion path currently pointing at them.
2. **G38's origin milestone** — considered above; declined because `CLAUDE.md`'s own G38 text already makes no
   claim about which milestone proved it, so there is nothing in `CLAUDE.md` to correct.

## Where the brief was wrong

- **Mostly right, with one real gap in its own file inventory.** The seed correctly named every candidate in
  rows 50, 51, 57, 58's own text (M56's L1–L7, M57's `AdditivelyRigid`/G42, the field-level gap, the Hurwitz
  instance, Mascot.lean's kernel theorems) and correctly flagged the M53-T8/M56 cross-reference question left by
  batch 3a. **What it did not anticipate: `plans/COXETER-2026-09-08-mascot.md` holds six substantive theorems of
  its own, not merely "hand steps the derivation proves beyond what `Mascot.lean` states"** (the brief's phrasing
  suggested Coxeter's file would supplement the working session's derivation, when in fact it is an independent,
  differently-routed exploration that never merged with it — the two files share only their date and their
  subject, not their content or their conclusions). Filed anyway, per the brief's own instruction to "file
  whatever hand steps the derivation proves beyond what `Mascot.lean` states" read broadly (Coxeter's session was
  part of the same day's work, credited per `CLAUDE.md` G51's own naming convention).
- **`plans/POROS-2026-09-08-mascot.md` held less theorem-shaped content than its length suggested.** At 101
  lines it reads as if it might carry independent derivations; on reading in full it is a registered card (an
  open question with a falsifier) plus a same-day amendment, both explicitly framed as questions rather than
  results ("Not a milestone... nothing here is a new measurement"). Correctly classified as a reading, not
  under-read.
- **The Hurwitz-order instance (row 57) genuinely has no separate plan file** — the brief's own file list
  (`plans/A1-theorem-A-kernel.md`, `plans/STUB-theorem-A-kernel.md`) does not contain it, confirmed by `rg` for
  every plausible search term across `plans/` and `data/`. This is not a brief error so much as an artifact of
  how the original 2026-09-08 session worked (composing directly into the ledger rather than a plan file); flagged
  because a future reader searching `plans/` for this theorem's derivation would find nothing without this file's
  header note explaining where to look instead.
- **File sizes matched** the brief's table for M56/M57 (93,778 and 93,604 bytes; both grepped and read per §S.4's
  discipline rather than read whole, keeping the whole batch well inside the ~350k token budget); the mascot
  files (19,225 + 40,538 + 7,634 bytes) were small enough to read in full, which is what surfaced Coxeter's
  unindexed content.

## The enumeration

**Files read in full:** `plans/FS71-theorem-audit.md`, `plans/FS70-derivation.md`, `data/fs71/batch-3a.md`,
`plans/M53-derivation.md` (the header/provenance section, to confirm the M53-T8/G38 cross-reference), `LEDGER.md`
rows 47–58 and § B (repeatedly, before and after each of the five commits); `plans/MASCOT-DERIVATION.md` (273
lines); `plans/COXETER-2026-09-08-mascot.md` (561 lines); `plans/POROS-2026-09-08-mascot.md` (101 lines);
`plans/Q8-FIVE-CHROMATIC-OBJECTS.md` (174 lines); `data/m56/README.md`, `data/m57/README.md`;
`Proofs/HadwigerNelson/Additive.lean` (123 lines), `Proofs/HadwigerNelson/AdditiveRigid.lean` (declaration list),
`Proofs/HadwigerNelson/Mascot.lean` (declaration list), `Proofs/HadwigerNelson/Instances/Core9.lean` (declaration
list); `plans/M51-derivation.md`, `plans/M52-derivation.md` (both in full, to reconcile Q8 and to confirm no
double-filing); `tools/quaternion_q4_check.py` (docstring plus enough of the module to confirm the (H1)–(H3)/(LB)
checks it performs, ~150 lines, not the whole file).

**Files substantially read (major sections, not cover-to-cover):** `plans/M56-arithmetic-of-tightness.md` (§S1
"The derivations, done", lines 248–327, in full; §M1, lines 424–513, in full, including M1.7's L7 and M1.8's
kernel-scope note; §M2.1's proof table, lines 516–530; §R3–R6, lines 756–825, in full; §§1–2, 4–9, §B, §S2–S5,
§S7 not read, superseded prose per the file's own structure); `plans/M57-additive-rigidity.md` (§S1, lines
211–297, in full; §R0–R8, lines 672–865, in full, including the R5 addendum; §1–9, §B, §H, §M1–M3 not read, same
reasoning); `plans/A1-theorem-A-kernel.md` (§10 "Results", lines 415–499, in full; §11's literature-check headers
skimmed to confirm no new attribution beyond what row 57/batch 3a already record; §§1–9, 12–13 not read — setup,
module-layout and modeling-pass prose the results section supersedes); `plans/STUB-theorem-A-kernel.md` (~50
lines, the target statement and the A1/A2 split, confirming it is superseded context per batch 3a's precedent for
comparably-named stub files).

**Grep patterns used** (the §S.4 discipline): the standard pattern
(`theorem|lemma|proposition|corollary|claim|derivation|derived|by hand|\[hand\]|\[derived\]|\[cert\]|\[proof\]|
we prove|proof:|QED|∎|iff|if and only if|exactly when|for every|for all|conjecture|not claimed`) across
`M56-arithmetic-of-tightness.md` and `M57-additive-rigidity.md` to locate section boundaries before reading them
in full by line range; `rg -n "L7"` on M56's plan (located every M1.7/M2.1/R3 mention, confirmed the conjecture
status); `rg -rln "Hurwitz order|χ(ℚ⁴)|chi(Q\^4)|BendaPerles"` across `plans/`, `data/`, `tools/`, `CLAUDE.md`,
`LEDGER.md` (located every file mentioning the quaternion instance, confirming no dedicated plan file exists);
`grep -n "883|1-minimal|composed four-copy|9,194|9194|jackpot"` on `plans/M51-derivation.md`,
`plans/M52-derivation.md` (confirmed neither already files Q8's Objects 3–4); `grep -n "15,218|15218|spare-colour|
witnesses, not descent"` on `plans/M52-derivation.md` (confirmed the "witnesses, not descent material" finding is
already correctly filed as a reading there); zbMATH Open queries, recorded verbatim inside each filed theorem's
*Prior art:* field where a fresh query was run (eight queries total: `ab:"additive coloring" & ab:"unit
distance"`, `ab:"Kempe chain" & ab:"connected" & ab:"coloring"`, `ti:"chromatic number" & ab:"lattice" &
ab:"homomorphism"`, `ab:"twisted" & ab:"unit distance graph"`, `ab:"spindle" & ab:"chromatic number"`, `ab:"Moser
spindle" & ab:"field"`, `ab:"rotation" & ab:"unit distance graph" & ab:"pinning"`, `ti:"chromatic number of the
plane" & ab:"human-verifiable"`, `ab:"quaternion" & ab:"chromatic number"`, `ti:"unit distance" &
ab:"quaternion"`); the held bibliography (`BIBLIOGRAPHY.md`) grepped for `Fischer1990`, `Fischer1990b`,
`Fischer1994`, `BendaPerles2000`, `Madore2015`, `ExooIsmailescu2019`, `Parts2020hv` — used in place of fresh
queries wherever the held entries already gave exact attributions, per batch 3a's precedent (this batch's L6/L7
of M56, R57-T1, and MASCOT-T7/T8's field attribution all cite held rows rather than re-querying an already-answered
question).

**Files skipped, and why:** `tools/additive.py`, `tools/additive_rigid.py` (docstrings not opened; per batch
1/2b/3a's repeated finding that a tool's docstring restates its plan, and `data/m56/README.md`/`data/m57/README.md`
already gave the subcommand tables in full); `plans/M53-derivation.md`'s theorem entries beyond the header (already
filed by batch 3a, read only for the header's provenance note); every `data/m5{1,2,6,7}/*.json` file (provenance,
not proofs, per the brief's own instruction and batch 3a's precedent); `data/m51/m51-copycore-about206-graph.json`
(the 883-core's graph data, not re-verified — per FS-71's no-solver rule, this batch does not re-run the 3,412-ask
census); no tool was run, no solver, no `lake build`, no `lake env lean`.

## What was delegated

**Nothing.** No subagent, fork, or workflow was started at any point in this batch; every file above was read
directly by this agent, every zbMATH query was executed directly, and every gate run
(`tools/fs71_ledger_b_check.py --strict`, `tools/claude_md_fact_audit.py --base <commit>`,
`tools/check_architecture.py`, `tools/bib_audit.py`) was executed directly, after each of the five commits.
