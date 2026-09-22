# FS-71 batch 2a — the theorem audit of M37–M48 (ledger rows 34–43)

*Filed 2026-09-22 by the batch-2a implementer, a Sonnet 5 agent working alone (no subagent, fork or workflow
spawned — see "What was delegated" at the end). Read first, per the brief: `plans/FS71-theorem-audit.md` in full,
`plans/FS70-derivation.md` (the template), batch 1's derivation files and `data/fs71/batch-1.md`, `LEDGER.md` rows
34–43 and § B.*

## Headline

**M37–M48: 13 theorems filed in 7 files, 0 re-attributed wholesale to prior art, 3 demoted (1 found in error, 2
withdrawn/superseded — none newly discovered here as a "gap: the step fails" proof defect); enumeration complete.**

Thirteen theorems, all confirmed on re-reading and none needing a Lean-side correction, filed across seven
derivation files: `plans/M37-derivation.md` (M37-T1, hand, *unsure*), `plans/M39-derivation.md` (M39-T1, hand,
*closes*), `plans/M40-derivation.md` (M40-T1…T5, four hand + one cert, all *closes*), `plans/M41-derivation.md`
(M41-T1, cert, *closes*), `plans/M43-derivation.md` (M43-T1, M43-T2, hand, *closes*), `plans/M45-derivation.md`
(M45-T1, tools, *closes*), `plans/M48-derivation.md` (M48-T1, hand, *closes*). Five milestones hold no theorem
outside the kernel (M38, M42, M44, M46, M47), and one file inside the batch is a parked stub that was never
subplanned (M44-from-below-gadget.md) — every one classified in the census table below, none omitted.

**The three demotions, the batch's most consequential finding beyond the filed theorems:**

1. **M41's "a 6-forcer needs exactly one k = 5 forced-distinct gadget at √3 or 2" is an error, found on
   re-reading** — not a rounding, not a scope narrowing (`plans/M41-derivation.md` §"Conjectures surfaced"). The
   corpus's own later kernel theorem (M48's D1, `six_le_chromaticNumber_plane_of_forced_pairs`, already row 43's
   content and CLAUDE.md's G26) requires virtual edges at **both** `√3` **and** `2`, "never either alone" — and
   M48's own §R1 independently confirms this reading, stating in so many words that the project's Frontier had
   carried the wrong "or" reading since the day M41 wrote it, until M48 corrected it. This audit reached the same
   conclusion from M41's file alone, before opening M48, then found M48's own account of the correction — two
   independent routes to one finding, cross-referenced in both derivation files.
2. **M43's "the fine-tail forcing does NOT factor as pigeonhole × kill... zero virtual edges at k = 6" is
   withdrawn** — already fully recorded as CLAUDE.md's G28 demotion record (M45 re-asked the identical 241-vertex
   stage and found the seven virtual edges M43's six anchored asks never posed). Nothing from M43 is filed as a
   theorem on this point, per the seed's own instruction; not re-derived, only pointed at from both
   `plans/M43-derivation.md` and `plans/M45-derivation.md`.
3. **M39's "the scaled-shell route is exhausted at `M ∈ {1,3}`" is false**, per M40's own correction banner
   (found the `M = 4` band), and **M43's D5 supersedes both** with the final, complete classification
   `M ∈ {1,3,4}` and no others — filed as M43-T2, with the two-step correction history recorded in both
   `plans/M39-derivation.md` and `plans/M43-derivation.md`.

No proof-defect "gap" (a theorem whose own argument does not close) was found anywhere in the batch; every closed
proof this audit checked does close. Two genuinely new-to-the-ledger findings surfaced and are filed: **M45-T1**,
the project's only confirmed arity-3 compulsion (three triples, every sub-pair independently verified free, never
recorded in any row), and **M48-T1**, the Jung's-theorem argument that rules out an arity-3 pigeonhole in the
hex-shell's own `{1, √3, 2}` distance vocabulary (also uncaptured).

## The census table

*One row per milestone M37–M48, the empty ones included. "Candidates" lists every grade-tagged clause of the
milestone's ledger row plus what the plan files added under the grep discipline; "classified as" gives kernel /
measurement / reading / instance / prior art / conjecture with one line why, per candidate.*

| milestone | ledger row | candidates found | filed as | classified as |
|---|---|---|---|---|
| M37 | 34 | the whole triangular-lattice coset bound and its sharpness (`seven_values`, `seven_le_card`, `exists_proper_coset_colouring`, `coset_chromatic_eq_seven`); "What was NOT done": a crude Hermite-plus-covering bound `k ≥ 6` for **any** planar lattice, `k ≥ 9` for the square lattice, asserted with no worked chain | **M37-T1** | kernel (the main theorem, row 34) · hand, unsure, filed (the general-lattice bound — never written up, only concluded) |
| M38 | 35 | `seven_labels_of_cell_constant`, `seven_le_card_of_cell_constant`, `cell_chromatic_eq_seven`; "What was NOT done" is pure scope disclaimer (no new claim) | none | kernel throughout (row 35) |
| M39 | 36 | `eight_le_card_of_cell_constant`, `seven_le_card_fine` (kernel); §0a C1's exact min/max-over-hexagon edge criterion (the foundation of `tools/celllat.py`, reused through M40/M42/M43); §0e's "scaled-shell route exhausted at `M ∈ {1,3}`" | **M39-T1** | kernel (row 36) · hand, closes, filed (the exact criterion) · demoted, recorded not filed (the scaled-shell claim — false, per M40's own correction) |
| M40 | 37 | D1 (bands keyed by dihedral orbit); D2 (a 10-clique, superseded within the same milestone by the exact 12-clique already in row 37); D3 (the `G*` headline, already row 37); D4 (census-artifact fix, method); D5 (`ω = 3` for `p ≤ 1/7`, via an Eisenstein-unit triangle + a four-point ratio bound); D6 (the torus-wrap Hoffman bound, diagnostic-only); D7 (the fractional discriminator, standard fact + a [tools] value already row 37); D8 (the interval-distance bridge, dominated by `[Voronov2023]`); D9 (no coset seven-colouring — the seed's headlined target) | **M40-T1…T5** | measurement, already row 37/38 (D2, D3, D7's numeric value) · method, not filed (D4) · hand, closes, filed (T1 = D1, T2 = D5, T3 = D6, T5 = D8, with T5's consequences found dominated by held prior art) · cert, closes, filed (T4 = D9; kernel on the `G*` band via M42's `no_coset_seven_on_gap`) |
| M41 | 38 | the seed's G24 target: exact `χ_f` at the 23/53/117-cores (`130/23`, `501/74`, `≈4.83796`), missing from row 38's text; the five-of-five factorization, the Galois orbit (`W^[3],W^[5],W^[3,5]`), the moment ladder (all already row 38); "the plane-side reduction... one gadget at √3 or 2, nine copies close χ ≥ 6" | **M41-T1** | cert, closes, filed (the fractional certificates) · measurement, already row 38 (factorization, Galois orbit, moment ladder) · demoted, found in error, recorded not filed (the one-gadget claim) |
| M42 | 39 | the whole §0a repricing derivation, landed the same day: `seven_le_card_shell4`, `twelve_le_card_of_cell_constant`, `no_coset_seven_on_gap`, `exists_unit_pair_corner`, `core23_not_colorable_six`, `core23_colorable_seven`, `Coset.seven_le_card_gap` | none | kernel throughout (row 39; "items 1–3 LANDED... item 4 LANDED same day") |
| M43 | 40 | D1 (closed-form `arrive`/`depart` threshold formulas); D2 (the exact 1/7 flank bands, a [tools] instance); D3 (evidence re-keying, elementary); D4 (`ω = 3` on both flanks, an instance of M40-T2); D5 (the scaled-shell classification `M ∈ {1,3,4}`, correcting M39 and M40's partial correction); D6 (coset sixes already dead, a trivial corollary of M37); D7 (the pinning-ladder SAT-encoding soundness, method); §R's "the 1/7 forcing does NOT factor" (withdrawn, G28); §R's Hoffman bracket at the coarse flank (the seed's G24 target, a [tools] instance of M40-T3) | **M43-T1, M43-T2** | hand, closes, filed (T1 = D1, T2 = D5) · instance/trivial/method, not filed (D2–D4, D6, D7) · demoted, pointed at G28, not refiled (the "does not factor" finding) · measurement, already row 40 (the Hoffman bracket) |
| M44 | 41 (`M44-epsilon-dial.md`) | D1–D3 (the realization lemma, the limit lemma, the headline corollary) — all landed fully in the kernel (`Limit.lean`); the defect curve `ν(ε)` points, the interval axis, the phase-1 scale-invariance re-measurement — all [tools], already row 41/G29 | none | kernel throughout (row 41) · measurement, already row 41/G29 |
| — | (none) | `M44-from-below-gadget.md`: a parked stub, re-ranked down the day after minting, never subplanned or run (no §R section) | none | not run — classified like batch 1's M27–M29 |
| M45 | 42 | R0/D1–D5 (the `arityFloor` machinery, kernel); R1 (the seven virtual edges refuting M43 — already G28's demotion record); R2 (coverage-vs-criticality, measurement matching G28); **R3 (three genuine arity-3 compulsions, every sub-pair free, two encodings each — never recorded anywhere)**; R4 (orbit-completeness, inverted, its own control flagged suspect and the follow-up not run) | **M45-T1** | kernel (row 42) · measurement, already row 42/G28 (R1, R2) · tools, closes, filed (R3) · open/unresolved, recorded not filed (R4) |
| — | (none) | `M46-colouring-automaton.md`: a pure stub (transfer-matrix/automaton proposal), feasibility gate never run, no §R section | none | not run |
| — | (none) | `M47-multidistance.md`: a pure stub (χ(ℝ²;{1,√3,2}) proposal), literature-check gate never run, no §R section | none | not run |
| M48 | 43 | D1 (the correction of G26's "or" to "and" — landed in the kernel the same milestone, `six_le_chromaticNumber_plane_of_forced_pairs`); D2 (Jung's-theorem argument: no arity-3 pigeonhole exists in `{1,√3,2}` — never captured anywhere); D3 (the ladder theorem, kernel); D4 (plane homogeneity, kernel); the complete arity-2/3/4 sweeps on the 1581/gen-1 (measurement, already row 43/G31); §R8's sampler-artifact diagnosis of P6 (method) | **M48-T1** | kernel (D1, D3, D4; row 43) · hand, closes, filed (D2) · measurement, already row 43/G31 · method, not filed (P6's diagnosis) |

## Progress and resume

**Batch 2a is complete: every milestone M37–M48 filed or classified.** No successor is needed for this batch. Batch
2b (M49–M52, ledger rows 44–46) is a separate reader, briefed fresh from the repository, per the original split.

## Theorems this phase proved

**None** — as expected for an audit. This phase's own product is thirteen filed theorems that earlier milestones
proved and left unindexed (M37-T1, M39-T1, M40-T1…T5, M41-T1, M43-T1/T2, M45-T1, M48-T1), plus three demotions
(one found in error on re-reading — M41's "or" claim — and two pointers to demotions already recorded in
`CLAUDE.md`'s G28 and M40's own correction banner). No new mathematics was produced.

## Proposed edits to `CLAUDE.md`

**None.** Unlike batch 1 (which found two grade-tag corrections, G12 and G20), this batch found no grokking whose
tag or text needs changing. G26 and G28 — the two grokkings this batch's demotions bear on most directly — are
already worded correctly and already carry the right attribution; this audit's job on both was to confirm the
record, not correct it. The one error this batch found (M41's "or" claim) lived entirely inside a milestone plan
file, never in `CLAUDE.md` itself, and is corrected in place inside `plans/M41-derivation.md`'s "Conjectures
surfaced" section — no ledger row or grokking ever repeated it.

## Where the brief was wrong

- **The seed's row-38 (M41) target line bundles two milestones' content under one grokking (G24), and only half
  of it lives in M41.** "The exactly certified `χ_f` values (130/23, 501/74, ≈4.83796) **and the Hoffman bracket
  at p = 1/7**" reads as one M41 target; the fractional certificates are M41's (`plans/M41-derivation.md` T1), but
  the Hoffman bracket "at p = 1/7" is **M43's** (`plans/M43-fine-tail.md` §R: "the certified Hoffman bracket at the
  coarse flank is χ ≥ 3.56... converged 246,635 boxes"), the coarse flank being the band immediately above
  `p = 1/7`. It is a [tools]-grade *instance* of M40-T3's torus-wrap Hoffman bound (filed under M40, not M43 or
  M41) rather than a separate theorem, so nothing new needed filing for it, but a reader following the seed's
  literal wording into M41 alone would not find it — noted explicitly in `plans/M43-derivation.md`'s "Readings and
  measurements" section so a future reader is not sent looking in the wrong file.
- **The seed's batch-2 target list (plan §G.2) undercounts M40's richness by a wide margin.** It names only row
  37's headline ("no coset 7-colouring on G*") as the batch's cert-grade target; M40's own plan (`plans/M40-chi-
  omega-hunt.md`) carries **nine** hand derivations (D1–D9) before any instrument runs, of which five turned out
  to be independently filable theorems (M40-T1, T2, T3, T5, and T4 = the seed's own target) beyond what row 37's
  compressed text states. This is the single largest gap between the seed's provisional density estimate ("medium")
  and what the files actually held for one milestone; the seed's own §G.2 entry for M40 (embedded inside "Batch 2"
  without a milestone-by-milestone breakdown) gave no signal of this in advance.
- **Two milestone numbers in the batch's file range (M46, M47) never became milestones at all**, and a third file
  (`M44-from-below-gadget.md`) is a stub that kept the "M44" number after the actual M44 ran under a different plan
  file (`M44-epsilon-dial.md`) — none of the three has a ledger row, and none has a `§R` section. The brief's file
  list named all three among the batch's twelve files without flagging this, which cost a few minutes of searching
  for a nonexistent result section in each before concluding they were never run; recorded here so a future batch
  facing a similarly-numbered-but-unrun stub knows the tell (no `§R` heading) is fast to check first.
- **Nothing else was wrong.** The seed correctly named every ledger row's content, correctly flagged G28's
  demotion (so M43's "does not factor" content was never at risk of being mis-filed as a theorem), and correctly
  predicted "medium" density for the batch as a whole (13 filed theorems across 12 milestone-numbers, in line with
  batch 1's "low" 5-in-20 and the expectation that M37–M48 sits above that but below the "high" batches to come).

## The enumeration

**Files read in full:** `plans/FS71-theorem-audit.md`, `plans/FS70-derivation.md`, `data/fs71/batch-1.md`,
`plans/M18-derivation.md`, `plans/M31-derivation.md` (spot-read for shape confirmation), `LEDGER.md` (in full, rows
1–76 and § B), `plans/M37-coset-bound.md`, `plans/M38-cell-bound.md`, `plans/M39-constraint-graph.md`, `plans/M40-
chi-omega-hunt.md`, `plans/M41-k5-gradient.md`, `plans/M42-gap-kernel.md`, `plans/M43-fine-tail.md`, `plans/M44-
epsilon-dial.md`, `plans/M44-from-below-gadget.md` (all in full — largest, M45, was read in full via targeted
section reads covering every heading), `plans/M45-arity-floor.md` (every section read, §§1–14 and §R in full),
`plans/M46-colouring-automaton.md`, `plans/M47-multidistance.md` (both under 8 KB, read whole), `plans/M48-from-
below-arity.md` (every section read: §0a–§9, §R0–§R9 in full).

**Files grepped, with the patterns used:** `rg -n -i 'theorem|lemma|proposition|corollary|claim|derivation|
derived|by hand|\[hand\]|\[derived\]|\[cert\]|\[proof\]|we prove|proof:|QED|∎|iff|if and only if|exactly when|for
every|for all|conjecture|not claimed'` across all twelve plan files (the §S.4 discipline; used to locate every
`§0a`/`§R` heading and every hand-derivation paragraph before reading the surrounding section in full — batch 1's
lesson that a derivation can sit ten or more lines below its own heading was applied by reading each flagged
section whole, never a ±40-line window); `rg -n "no_coset_seven_on_gap|exists_unit_pair_corner|
core23_not_colorable_six" Proofs/HadwigerNelson/*.lean` and similar declaration-existence checks for every Lean
name a plan file or the ledger row cited (M37's `Coset.lean` declarations, M40/M42's `no_coset_seven_on_gap`,
M44's `Limit.lean` declarations, M45/M48's `Arity.lean`/`Homogeneous.lean` declarations — all resolved); `rg -rn
"nine gadget\|gadget copies\|forced-distinct gadget"` and `rg -rn "M46\|M47"` across `plans/`, `LEDGER.md`,
`CLAUDE.md` (both searches run to confirm, respectively, that M41's "one gadget" claim was never pursued further
and that M46/M47 hold no ledger row anywhere); `rg -n "130/23\|501/74\|4\.83796\|23-core\|53-core\|117-core"`
across `plans/M4[0-8]*.md` (located G24's target content precisely in M41, not M40 or M42); `rg -n "Hoffman"`
across `plans/M41-k5-gradient.md plans/M43-fine-tail.md` (located the seed's second G24 target in M43).

**Tools spot-checked, not read whole:** `tools/celllat.py` (docstring only, confirmed it restates `plans/M39-
constraint-graph.md` §0a rather than adding content, per batch 1's finding that tool docstrings restate rather
than add). **Not run**: any tool, any solver, `lake build`.

**Files skipped, and why:** `tools/gradient.py`, `arity.py`, `m48.py`, `embed.py`, `verify_defect.py` — beyond
`celllat.py`'s spot-check, every derivation actually used by this batch was already stated in its plan file's
`§0a`/`§R` sections, which the grep discipline located before any tool code was opened; `data/m37…m48` and
`data/m4[0-8]`: confirmed absent (no such directories exist under `data/`, checked with `ls data/ | grep -E
'^m4[0-8]'`, zero hits — the batch's measured artifacts live under `build/`, which is gitignored and not part of
the enumeration). Lean modules named in the rows and in every filed theorem's "Kernel" field: existence checked
with `rg -n "<name>" Proofs/`, never opened beyond the declaration and its immediately surrounding docstring —
`Coset.lean`, `Limit.lean`, `Arity.lean`, `Homogeneous.lean`, `Instances/HexShell.lean`, `Instances/Core23/*.lean`
(seven files, `#check`-grade reads only, no `lake build`, no `lake env lean`).

## What was delegated

**Nothing.** No subagent, fork, or workflow was started at any point in this batch; every file above was read
directly by this agent, and every zbMATH query and every gate run (`tools/fs71_ledger_b_check.py`,
`tools/claude_md_fact_audit.py --base <pre-batch commit>`, `tools/check_architecture.py`, `tools/bib_audit.py`)
was executed directly, after each milestone's commit, exactly as the brief specifies.
