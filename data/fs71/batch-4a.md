# FS-71 batch 4a — the theorem audit of M62, M64 and FS-32 (ledger row 62)

*Filed 2026-09-22/23 by the batch-4a implementer, a Sonnet 5 agent working alone (no subagent, fork or workflow
spawned — see "What was delegated" at the end). Read first, per the brief: `plans/FS71-theorem-audit.md` in full,
`plans/FS70-derivation.md` (the template), `ls plans/*-derivation.md`, `data/fs71/batch-1.md`, `LEDGER.md` row 62
(and rows 64–65 for orientation) and § B, `data/fs71/batch-2a.md`/`batch-2b.md` § "Where the brief was wrong",
`data/fs71/batch-3c.md` in full (it flagged `plans/POROS-2026-09-10-b-closure-equality.md` as this batch's file).*

## Headline

**M62 + M64 + FS-32: 9 theorems filed in 3 files, 0 re-attributed wholesale to prior art, 0 demoted (gap);
enumeration complete.** Four theorems from M62 (`plans/M62-derivation.md`), three from M64
(`plans/M64-derivation.md`, including row 62's own orbit-closure theorem in its final, corrected form), two from
FS-32 (`plans/FS32-derivation.md`). No milestone in the batch is empty.

None of the three milestones beats the 509-vertex record — the batch's honest headline is that a night-plus of
derivation and search produced a best certified 1-minimal object of **583 vertices** (M62 §R23) and, separately, a
reusable piece of mathematics: **the orbit-closure theorem**, which explains *why* `[Parts2020a]`'s own
"overcompression" phenomenon happens (his §5.8/§6, stated as a nuisance of his search method, is now an instance of
a four-line theorem about upward-closed families and group actions on a finite atom set), together with a
subgroup-lattice monotonicity corollary that turns M62's own apparently-anomalous symmetry ladder into a certified
search failure rather than a mathematical puzzle.

**The most consequential finding, structural rather than a new result**: the orbit-closure theorem was derived
**twice**, by two different agents, four days apart, inside the same milestone file — once by the M64 implementer
at §R5 (a correct but not-tight one-directional inequality, restricted to `H ≤ Aut(A)` and to minimum-*size*
refusers) and once by the advisor Poros at §R10(a) (the general equality, over inclusion-minimal refusers, with no
equivariance hypothesis at all). Both derivations are filed as one theorem (M62/M64-T1's history, `plans/
M64-derivation.md`), since the second strictly subsumes the first and the milestone's own text says the correction
is "the same two lines" — this is the audit's M.2 rule ("the home of a theorem is where it was proved") applied
to a theorem proved incrementally in one file rather than across two milestones.

## The census table

*One row per milestone in the batch. "Candidates" lists what the ledger row plus the plan files' own content
offered; "classified as" gives kernel / measurement / reading / instance / prior art / conjecture with one line
why, per candidate.*

| milestone | ledger row | candidates found | filed as | classified as |
|---|---|---|---|---|
| M62 | 62 (shared with M64, FS-32) | the rotation-admissibility trichotomy (§0b/§R1, an exact field-arithmetic decision procedure); the pattern-clash correctness theorem for the two-block acceptance test (§R8, corrected by Poros at §R11–§R13); the `ρ₁₅` cross-edge radius bound (§R22); the identification of Parts's order-24 group as `⟨ζ₆⟩ ⋊ Gal(K(i)/ℚ)` and its preservation of unit distance and the cross-edge law (§R19); the exhaustive 32-subset subtype law (§R20); the cost-structure inversion (§R6); the "1,336 rotation classes" count (§R1, later SUPERSEDED); the speed-campaign findings (§R23) | **M62-T1, M62-T2, M62-T3, M62-T4** | hand, closes, filed (T1–T4) · measurement, not filed, object-specific (the 32-subset law, §R6's cost inversion, the superseded rotation count, §R23's speed findings) |
| M64 | 62 | the orbit-closure theorem, both the inequality form (§R5) and its equality correction (§R10(a), Poros); the direct hitting-set corollary (§R10(b)); the subgroup-lattice monotonicity theorem (§R10(c)); the matroid refutation by exhibited counterexample (§0(viii)); the idealness question (§PA(a)/§R6, left undecided); the two conservation laws and the profile-map factorisation facts (§0(i)–(iv), §R9, object-specific); the convexity-cannot-fail finding (§0(v)); the termination-measure conjecture C3 (§2, not tested) | **M64-T1, M64-T2, M64-T3** | hand, closes, filed (T1, T2) · tools, closes, filed (T3, by exhibited counterexample) · undecided, not filed, its own falsifier unmet (idealness) · measurement, object-specific, not filed (the conservation laws, the factorisation facts, §R1's decisive-experiment numbers — already correctly recorded in row 62) · conjecture, not established, noted (C3) |
| FS-32 | 62 (§R3) | the MUS/MCS correction-set duality re-derived from monotonicity (§M2); the `L↔S` involution as an arena isometry (§M1 decision 2); the soundness argument for the hitting-set loop's lower bound and termination (§M2, standard); "reaching Parts's record by pure reduction is closed" (§R3, the row's own headline verdict) | **FS32-T1, FS32-T2** | hand, closes, filed (T1, prior art Liffiton–Sakallah; T2, ours) · standard/not separately novel, not filed (the loop's soundness argument) · **priced negative measurement, not a theorem** — bounds an engineering quantity (search capacity in measured time against 84% required), not the record's true minimum |

## Progress and resume

**Batch 4a is complete: M62, M64 and FS-32 all filed.** No successor is needed for this batch. Per
`plans/FS71-theorem-audit.md` §S.6's seventeen-reader partition, batches 4b (`M63` phases C–G), 4c (`M63` phase H2)
and 4d (`M63` phases H3–H4) are next, each a separate reader — none of `M63`'s own content was opened here (out of
this batch's assigned file list; confirmed by `ls plans/M63-*.md`, thirty files, none read).

## Theorems this phase proved

**None** — as expected for an audit. This phase's own product is nine filed theorems that M62, M64 and FS-32
proved and left unindexed (M62-T1–T4, M64-T1–T3, FS32-T1–T2), one classification of a headline verdict as a
measurement rather than a theorem (FS-32's "pure reduction is closed"), and the structural note above about the
orbit-closure theorem's two-stage derivation. No new mathematics was produced.

## Proposed edits to `CLAUDE.md`

**None.** `CLAUDE.md` § "Closed as directions" already correctly cites FS-32's §R3 as the source of "reaching
Parts's record by pure reduction" without calling it a theorem, and no grokking (G1–G69) states or depends on
anything this batch's audit corrected. Row 62 itself (`LEDGER.md` § A) already states the orbit-closure theorem in
its final, tight form — the audit found no defect in the row's own wording, only that the row compresses a
two-stage derivation (implementer's inequality, then Poros's equality) into one sentence, which is exactly what a
row is for; the derivation file is where the two stages are told apart.

## Where the brief was wrong

- **Mostly right, and the one correction is in the brief's own favour.** The seed (plan §G.2, batch 4, written
  before the seventeen-reader split) named every substantive candidate this audit filed: the orbit-closure theorem,
  the prior-art exposure (symmetry gap of symmetric IP, idealness, semilinear sets, MUS/MCS enumeration), the
  L-stage numbers (375/3,264 etc., correctly classified here as measurement, not theorem), M62's own derivations,
  and FS-32's §R3 verdict, which the brief explicitly flagged for classification ("a theorem, a priced negative, or
  a measurement?") and which this audit classifies as a **priced negative measurement**.
- **The brief's file table lists `plans/POROS-2026-09-10-m62.md` and `plans/POROS-2026-09-10-orbit-polytope.md`
  as this batch's files, and both were grepped (not read in full) after confirming their theorem-shaped content is
  already fully paraphrased in M62's own §R11–§R14 and M64's own §PA/§0/§R5.** This is a deliberate scope decision:
  batch 3c already established (and this batch independently re-confirmed by heading/keyword search) that
  `plans/POROS-2026-09-10-b-closure-equality.md` is the third Poros file and is entirely about M64's orbit-closure
  material — read in full by batch 3c, cross-checked here by grep against M64's §R10 and found to match line for
  line (the theorem statement, the two corrected hypotheses, the rung-lattice table). Reading all three Poros files
  in full in addition to the two milestone plans (already ~150 KB together) would have cost tokens for zero new
  content; the grep-first approach found nothing the milestones' own text had not already stated in its own voice.
- **Nothing else was wrong.** File sizes matched the brief's table exactly (100,052 / 50,663 / 28,731 / 16,376 /
  23,076 / 15,175 bytes, confirmed by `ls -la` before reading); the four STUB files were all confirmed superseded/
  absorbed by their own banners with no unabsorbed content (matching batch 1's pattern for demoted-and-unrun
  milestone stubs); `data/m62/README.md` and the two tool docstrings (`tools/parts_faces.py`,
  `tools/parts_reduce.py`) were tools-side/provenance only, restating rather than adding, per every prior batch's
  repeated finding.

## The enumeration

**Files read in full:** `plans/FS71-theorem-audit.md`, `plans/FS70-derivation.md`, `data/fs71/batch-1.md`,
`data/fs71/batch-2a.md` (headline + "Where the brief was wrong"), `data/fs71/batch-2b.md` (same),
`data/fs71/batch-3c.md` (in full, per the brief), `LEDGER.md` row 62 region (rows 60–76) and § B (read twice —
before and after insertion), `plans/M62-evolutionary-type-m.md` (1,500 lines, §PA through §R23, in full),
`plans/M64-orbit-filling-polytope.md` (766 lines, §PA through §R10, in full), `plans/FS32-smus-reduction.md`
(415 lines, §PA through §R3, in full), the four now-superseded stub headers (`plans/STUB-orbit-filling-polytope.md`,
`plans/STUB-parts-base-reconciliation.md`, `plans/STUB-parts-reproduction.md`, `plans/STUB-smus-reduction.md`).

**Files grepped, with the patterns used:** `grep -n "^#|Theorem|theorem|derivation|derived|proof:"` across
`plans/POROS-2026-09-10-m62.md`, `plans/POROS-2026-09-10-orbit-polytope.md`, `plans/POROS-2026-09-10-b-closure-
equality.md` (located every theorem-labelled paragraph in all three; cross-checked each against M62/M64's own
§R11–§R14/§PA/§0/§R5/§R10 and found no content the milestone files do not already state in their own voice);
`rg -n "^#"` on `plans/M62-evolutionary-type-m.md` and `plans/M64-orbit-filling-polytope.md` (located every §-level
heading for navigation, then read every §R and §0 section in full per the §S.4 discipline); `grep -n
"HerrRehnSchurmann|IgnatievEtAl2015|LiffitonSakallah|Wagner2021|MundingerEtAl2025|Kaibel|GinsburgSpanier|
BarvinokWoods|Lehman" BIBLIOGRAPHY.md` (confirmed every prior-art item named at M62/M64/FS-32's own §PA gates is
already correctly recorded there as "not held / named only", so no new bibliography rows or re-attributions are
needed); zbMATH Open queries, recorded verbatim inside each filed theorem's *Prior art:* field (eleven fresh
queries across M62-T1, M62-T2, M62-T4, M64-T1, M64-T3, FS32-T1 — all returned 0 hits for the specific combinations
searched, consistent with every prior batch's finding that this project's construction genre returns zero); `rg -n
"^theorem |^lemma |^def "` — not run, since no theorem filed cites a specific Lean declaration as its kernel home
(all nine are declined); `data/m62/README.md` read in full (tools-side provenance only, no theorem content);
`tools/parts_faces.py` (docstring, ~40 lines) and `tools/parts_reduce.py` (docstring, ~40 lines) spot-checked, per
the standing finding that tool docstrings restate their plan file rather than add content.

**Files skipped, and why:** `plans/M63-*.md` (thirty files, per `ls`) — explicitly out of this batch's scope
(batches 4b/4c/4d); `data/m62/*.json` beyond `README.md`'s own summary table — provenance, not proofs, per the
brief's own instruction and every prior batch's precedent; `tools/typem.py`, `typem_exact.py`, `parts_repro.py`,
`parts_stage.py`, `parts_report.py`, `parts_vtx.py`, `gmus.py`, `hitset.py`, `portfolio.py`, `memetic.py`,
`lns_worker.py`, `lns_guided.py` — every derivation these implement is already stated in the plan files' own §0/§R
sections, which the grep-then-read discipline located first, per every prior batch's repeated finding that tool
code restates rather than adds; no tool was run, no solver, no `lake build`, no `lake env lean`.

## What was delegated

**Nothing.** No subagent, fork, or workflow was started at any point in this batch; every file above was read
directly by this agent, every zbMATH query was executed directly, and every gate
(`tools/fs71_ledger_b_check.py`, `tools/claude_md_fact_audit.py --base <the commit before this batch>`,
`tools/check_architecture.py`) was run directly, after each milestone's own commit. `tools/bib_audit.py` was not
run because no bibliography row was touched (every prior-art item found was already correctly recorded).

**One markdown-parsing incident, caught and fixed before hand-back, recorded because the mechanism is worth
knowing for later batches.** `tools/fs71_ledger_b_check.py`'s entry header regex requires the theorem's title (the
text between the em dash and the opening `[grade]` bracket) to sit on **one physical line** — it uses `.+?`, which
does not match a newline — and separately requires the `[grade]` bracket's own contents to contain no unescaped
`]` (a citation like `` `[Parts2020a]` `` written inside the grade bracket truncates the match at its own closing
bracket). Two of this batch's own first-draft entries (M62-T4's header wrapped across two lines; M62-T4's grade
field originally quoted a bracketed citation) tripped both bugs at once, and a third defect (the literal marker
`*Proof verdict:*`/`*Rests on it:*`/`*Prior art:*` broken across a manually-wrapped line, so the substring check
never finds it) hit four more entries. All fixed by re-flowing the affected paragraphs so no field marker or entry
header crosses a line break; `tools/fs71_ledger_b_check.py` (non-strict) now reports a clean `PASS` on this
batch's nine entries, with only the pre-existing FS70/M18 field warnings and the FS38/FS66 placeholder row
remaining (none of them this batch's to fix, per the brief).
