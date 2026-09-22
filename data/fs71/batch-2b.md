# FS-71 batch 2b — the theorem audit of M49–M52 (ledger rows 44–46)

*Filed 2026-09-22 by the batch-2b implementer, a Sonnet 5 agent working alone (no subagent, fork or
workflow spawned — see "What was delegated" at the end). Read first, per the brief:
`plans/FS71-theorem-audit.md` in full, `plans/FS70-derivation.md` (the template), the existing
derivation files (`plans/M18…M48-derivation.md`), `data/fs71/batch-1.md`, `data/fs71/batch-2a.md`,
`LEDGER.md` rows 44–46 and § B.*

## Headline

**M49–M52: 8 theorems filed in 4 files (0 empty), 0 re-attributed wholesale to prior art, 0 demoted
(gap); enumeration complete.**

Eight theorems, all confirmed on re-reading and every one closing on its own stated terms: three from
M49 (`plans/M49-derivation.md`), two from M50 (`plans/M50-derivation.md`), one from M51
(`plans/M51-derivation.md` — **filed despite M51 having no dedicated ledger row**, see below), two
from M52 (`plans/M52-derivation.md`). No milestone in the batch was empty; all four ran real work and
all four produced at least one theorem outside the kernel.

**The most consequential finding is not a filed theorem but an undocumented kernel gap, found while
tracing M49's dangling `Instances/OneTwo` reference through M50 into M51**: M50's own constructive
centrepiece — the spare-colour lemma (*"a (k−1)-colourable graph admits no pair compulsion of either
polarity between non-adjacent vertices at k colours"*) — and its companion, the entropy floor theorem
(*"if χ(G) ≤ k−1 on n vertices then G has ≥ 2^⌈n/(k−1)⌉ proper k-colourings"*), were both sketched with
proof outlines at M50 and then **fully proved in the kernel the very next milestone**
(`Proofs/HadwigerNelson/SpareColour.lean`, `Proofs/HadwigerNelson/EntropyFloor.lean`, M51 §R0, "the
kernel sitting... LANDED first sitting"), on axioms exactly `[propext, Classical.choice, Quot.sound]`.
**Neither file is named anywhere in `LEDGER.md` or `CLAUDE.md`** (`grep -n "SpareColour\|EntropyFloor"
LEDGER.md CLAUDE.md` returns nothing), even though the spare-colour lemma is a live, named dependency
of grokking G40 and of `FS70-T3`'s own parenthetical (*"carries no four-colour pair compulsion (the
spare-colour lemma)"*) — this is exactly the M33→M34 pattern batch 1 found (a hand sketch promoted to
kernel one milestone later), and it is why M51, which produced no theorem of its own outside the
kernel, still gets a derivation file: to record why, and to flag the gap.

**A second finding, also load-bearing and also newly found**: M51's session log (2026-09-01, "Q8: Kooshi's
duplicate-and-detune idea") records the construction and tools-level verification of a **new
5-chromatic unit-distance witness**, `U ∪ R₂₀₆(U)` (3,695 points, 25,486 unit edges — a glue-lattice-grown
seed plus one `ρ₁₅` spindle copy, verified not-4-colourable in three SAT encodings with 250-digit exact
geometry), that appears in no ledger row. Filed as `M51-T1`, with an explicit flag: the fuller record
of this object almost certainly lives in `plans/Q8-FIVE-CHROMATIC-OBJECTS.md`, a file **FS-71's own
batch assignment gives to batch 3** (`plans/FS71-theorem-audit.md` §G.2, "Batch 3"), not this one — it
was not opened here (out of this batch's scope and budget), and batch 3 should reconcile against this
entry before filing anything that might duplicate it.

## The census table

*One row per milestone M49–M52. "Candidates" lists every grade-tagged clause of the milestone's ledger
row plus what the plan files added under the grep discipline; "classified as" gives kernel /
measurement / reading / instance / prior art / conjecture with one line why, per candidate.*

| milestone | ledger row | candidates found | filed as | classified as |
|---|---|---|---|---|
| M49 | 44 | kernel spindle theorem + one-defect theorem + hex-shell consumer (all landed, row's own text); the {1,2} six-forcer `H` re-derived exactly (paper's counts reproduced, 35/35 colourings force `A=B`); the kernel certificate priced (~24.0/22.9/19.8M hints per cube) and deferred, `Instances/OneTwo.lean` never built; Parts's `G31` edge-criticality (56/56); the μ_H sandwich (29 ≤ μ_H ≤ 252); §R3–R3′'s k=4 calibration (P4a/b/c scored predictions); §R8–R9's enumeration screen and designed kills (explicitly "to be written", a corollary of the already-kernel `Glue.sphere_inter_sphere`); §R10's registered ideas for successors | **M49-T1, M49-T2, M49-T3** | kernel (row's own citations) · tools, closes, filed (T1, T2, T3) · scored predictions, not theorems (§R3–R6) · corollary of a held theorem, not filed (§R8–R9's completeness caveat) · registered ideas for M51/M52, not results (§R10) |
| M50 | 45 | kernel `Glue.eq_gluePoint_of_dist_pair`/`Glue.finite_two_unit_neighbors` (row's own text, confirmed — the row cites the GENERAL form, a later consolidation of the `(1,1)`-corollary `eq_gluePoint_of_unit_pair` the milestone originally designed, both present in `PartnerLattice.lean`); batch composition soundness (monotonicity + orbit-filter, proved in §Bʺ); 148 absolute virtual edges + 412-triple complete census (correcting a 16-triple sampled undercount); the spare-colour lemma and the entropy floor theorem, sketched here with `sorry`s; the LP-duality stall bound and the entropy-floor "contrapositive" misapplication, both REFUTED by the milestone's own adversarial pass; K₅'s projectivity (confirmed prior art, `[GreenwellLovasz1974]`/`[LaroseTardif2002]`); §R5's exact geometric observations on one object (blind centres, metapivot hexagon, four-point pigeonhole) | **M50-T1, M50-T2** | kernel (row's own citations, confirmed) · hand, closes, filed (T1) · tools, closes, filed (T2) · **kernel one milestone later, flagged as a gap, not filed here** (spare-colour lemma, entropy floor — see `plans/M50-derivation.md` "Kernel already, one milestone later") · demoted, recorded not filed (LP duality, entropy-floor misapplication) · prior art, not read, new bibliography row (K₅ projectivity) · object-specific measurement, already row 45 (§R5) |
| M51 | *(none — folded into rows 44–46's four-milestone/three-row mapping)* | the spare-colour lemma and entropy floor theorem LANDED in the kernel here (`SpareColour.lean`, `EntropyFloor.lean`, §R0); K3 ("more edges only force more") already held via `Forces.mono`/`Forces.comap`, nothing minted; a new 5-chromatic witness `U ∪ R₂₀₆(U)` (the "Q8" session, 2026-09-01, tools-level, kernel certificate pending); WO-9's downward-closedness argument (a real monotonicity fact, but about the sibling Rust engine's internal algorithm, no Lean content); extensive Rust-engine performance engineering (INC4–INC6, engine swaps, WO-7/10/11/14 acceptance) | **M51-T1** | kernel (`SpareColour.lean`, `EntropyFloor.lean` — filed under M50, where designed, not M51, per FS-71's home-is-where-proved rule; **flagged as an undocumented ledger gap**, proposed edit below) · tools, closes, filed (T1, the new witness — flagged for batch-3 reconciliation against `Q8-FIVE-CHROMATIC-OBJECTS.md`) · engineering method, out of mathematical scope, not filed (WO-9, the Rust incidents) |
| M52 | 46 | kernel `spindleRot`, `copyUnion`, `chromaticNumber_copyUnion_le` and five further `Copy.lean` lemmas (row's own citations, all confirmed present and proved); the object's exact field (`ℚ(√3,√11)`, copies in `ℚ(√3,√5,√11)`, PSLQ + exact `Fraction` verification — "T14"); the copies-kill-nothing finding (P5 refuted, read as an application of the already-kernel spare-colour lemma as "a halo statement"); the cull-by-enumeration soundness invariant (proved, §Bʺ); the seven compositions' exact censuses and the 883-core kill table (object-specific measurements, already row 46) | **M52-T1, M52-T2** | kernel (row's own citations, confirmed) · tools, closes, filed (T1) · application of a held kernel theorem, not filed separately (the halo reading) · hand, closes, filed (T2) · measurement, already row 46 |

## Progress and resume

**Batch 2b is complete: every milestone M49–M52 filed or classified, none empty.** No successor is
needed for this batch under the current FS-71 numbering (`plans/FS71-theorem-audit.md` §S.6 lists ten
batches total: 1, 2a, 2b, 3a, 3b, 4a, 4b, 4c, 5, 6a, 6b — batch 3a is next, M53–M57 and the
2026-09-06/08/09 consolidation, ledger rows 47–54ish per the split). **One item for batch 3 specifically,
flagged above and in `plans/M51-derivation.md`**: reconcile `M51-T1` (this batch's filing of the new
5-chromatic witness `U ∪ R₂₀₆(U)`) against whatever `plans/Q8-FIVE-CHROMATIC-OBJECTS.md` holds — that
file is assigned to batch 3 and was not opened here.

## Theorems this phase proved

**None** — as expected for an audit. This phase's own product is eight filed theorems that M49–M52
proved and left unindexed (M49-T1/T2/T3, M50-T1/T2, M51-T1, M52-T1/T2), one undocumented kernel gap
found and flagged (`SpareColour.lean`/`EntropyFloor.lean`, M51), one undocumented new 5-chromatic
witness found and flagged (M51-T1, with the batch-3 reconciliation note), two demotions pointed at
(the LP-duality stall bound and the entropy-floor misapplication, both already self-corrected within
M50's own record by its adversarial pass), and one new bibliography row (`[LaroseTardif2002]`). No new
mathematics was produced.

## Proposed edits to `CLAUDE.md`

**None to `CLAUDE.md` directly** (no grokking in G1–G69 states or depends on anything this batch
corrected). **One proposed edit to `LEDGER.md` § A**, left to the owner per the batch's writer rules
(§ A is current-state-only, numbered-row content; this batch writes § B and the derivation files, not
§ A):

1. **Row 45's "Where" column is missing the two files that carry the milestone's most consequential
   kernel content, because that content landed one milestone later.**
   - Current: `| 45 | **Batch descent** (G33): ... the spare-colour lemma ((k−1)-colourable ⟹ no pair
     compulsion at k). | `PartnerLattice.lean`, `tools/batchkill.py` | M50 |`
   - Proposed: append `SpareColour.lean`, `EntropyFloor.lean` to the "Where" column (they are M51's,
     not M50's, but M51 has no row of its own to carry them — either extending row 45's address list
     to cover both milestones, or minting a dedicated row for M51 at this close, is the owner's call);
     and reword the row's own prose clause — *"the spare-colour lemma ((k−1)-colourable ⟹ no pair
     compulsion at k)"* — to say it is now **kernel** (`not_forces_of_colorable`,
     `not_separated_of_colorable`, `SpareColour.lean`), not merely a `[tools]`-tagged idea, since the
     row currently lists it inside a `[tools]` sentence alongside measured facts.
   - Reason: `SpareColour.lean` and `EntropyFloor.lean` are cited by name nowhere in `LEDGER.md` or
     `CLAUDE.md`, and the spare-colour lemma is a named, live dependency of grokking G40 and of
     `FS70-T3` — a theorem nobody can find from the ledger is not held, per the milestone's own
     mission sentence.

## Where the brief was wrong

- **Mostly right, with one real gap it could not have anticipated.** The seed correctly named every
  candidate this batch filed (row 44's six-forcer and Parts's forcer and the μ sandwich; row 45's batch
  composition and 148 virtual edges; row 46's field-membership fact and the cull) and correctly flagged
  the `Instances/OneTwo` dangling address as something to record. What the seed's row-44/45/46 summary
  could not show, because it compresses three plan files' worth of prose into three ledger rows, is
  that **the spare-colour lemma named in row 45's text is not M50's** — it is M51's kernel theorem,
  designed but not proved at M50. Chasing this down (via `rg` for the actual declaration names in
  `Proofs/`, following the brief's own "hand sketches often became kernel theorems a milestone later"
  lesson from batch 1) is what surfaced the undocumented-kernel-content finding above; a batch that
  filed row 45's spare-colour-lemma clause at face value (as if it were M50's own tools-side idea)
  would have missed that it is fully proved in the kernel one file, one milestone, away.
- **M51 genuinely has no ledger row**, confirmed by `grep -n "M51" LEDGER.md` (zero hits) before
  writing anything — the brief's "Milestones M49–M52; ledger rows 44–46" already signalled this (four
  milestones, three rows) but did not spell out which milestone is the odd one out. Filing
  `plans/M51-derivation.md` anyway, with an explanatory header rather than leaving it out, seemed the
  more honest choice than silently absorbing M51's real content into M50's or M52's file under a
  different milestone's name.
- **`plans/Q8-FIVE-CHROMATIC-OBJECTS.md` is explicitly assigned to batch 3** in
  `plans/FS71-theorem-audit.md` §G.2, yet its subject matter (the new 5-chromatic witness) is *also*
  recorded inline, in full, inside `plans/M51-descent-engine.md`'s own §S-CONT — which **is** in this
  batch's assigned file list. This is a genuine seam between batches, not a brief error exactly, but it
  is the kind of thing a fresh batch-3 reader could easily re-derive from scratch without realizing this
  batch already found and filed it; flagged loudly above and in `plans/M51-derivation.md` itself so the
  duplication risk is visible from either direction.
- **Nothing else was wrong.** The file sizes matched (`67013 / 103173 / 127692 / 81014` bytes,
  confirmed by `ls -la` before reading); `data/m51/README.md` and `data/m52/README.md` existed as
  promised and the rest of those directories was JSON, not opened beyond `ls`; the four Lean-declaration
  kernel citations in rows 44/45/46 (`not_colorable_of_forced_equal`,
  `add_one_le_chromaticNumber_unitDistance_of_one_defect`, `seven_le_chromaticNumber_hexShell_distances`,
  `Glue.eq_gluePoint_of_dist_pair`, `Glue.finite_two_unit_neighbors`, `spindleRot`, `copyUnion`,
  `chromaticNumber_copyUnion_le`) all resolve exactly as stated.

## The enumeration

**Files read in full:** `plans/FS71-theorem-audit.md`, `plans/FS70-derivation.md`, `LEDGER.md` (rows
1–76, § A and § B, twice — once at the opening, once after inserting this batch's rows to confirm the
diff), `data/fs71/batch-1.md`, `data/fs71/batch-2a.md`, `plans/M49-two-distance-descent.md` (in full —
§A–§S, all sections; 67 KB), `plans/M50-batch-descent.md` (in full — the stub, §B–§Bʹʹʹ, §0–§4, §S,
§Sʹ–§Sⁱᵛ, §Sⁱᵛ-adv, §S-CONT, §R1–§R6; 103 KB), `plans/M51-descent-engine.md` (in full — mission
context through §R-INC6 to the file's end, including the full 2026-09-01 "Q8" session log inside
§S-CONT; 128 KB), `plans/M52-copy-lock-objects.md` (in full — §1–§13, §Bʹ–§Bʹʹʹ, §R0–§R5, the
post-milestone follow-ups; 81 KB), `Proofs/HadwigerNelson/SpareColour.lean`,
`Proofs/HadwigerNelson/EntropyFloor.lean`, `Proofs/HadwigerNelson/PartnerLattice.lean`,
`Proofs/HadwigerNelson/Copy.lean` (all in full, to confirm every kernel claim exactly).

**Files grepped, with the patterns used:** the §S.4 discipline pattern
(`theorem|lemma|proposition|corollary|claim|derivation|derived|by hand|\[hand\]|\[derived\]|\[cert\]|
\[proof\]|we prove|proof:|QED|∎|iff|if and only if|exactly when|for every|for all|conjecture|not claimed`)
across all four plan files, used to locate every `§0a`/`§R`/`§Sⁱᵛ`-style heading before reading the
neighbourhood or the whole section (per batch 1's lesson, applied here mostly by reading the flagged
plan files whole regardless, since all four fit inside budget once split at the milestone boundary —
this is closer to batch 1's approach than batch 2a's, and cost more tokens than a pure grep-and-section
pass would have, but caught the Q8 witness and the STANDING-QUESTIONS.md cross-reference that a
narrower pass on section headings alone might have missed); `rg -n "OneTwo" Proofs/` /
`find Proofs -iname '*onetwo*'` (confirmed the dangling reference, located both citing docstrings
exactly); `rg -n "not_forces_of_colorable|not_separated_of_colorable|two_pow_le_card_coloring"
Proofs/` (located `SpareColour.lean`/`EntropyFloor.lean` and confirmed the kernel landing); `grep -n
"SpareColour\|EntropyFloor\|not_forces_of_colorable\|two_pow_le_card_coloring" LEDGER.md CLAUDE.md`
(confirmed the undocumented-gap finding — zero hits); `grep -n "M51" LEDGER.md` (confirmed no row);
`grep -n "glue-lattice-grown\|Q8\|3,695\|25,486 unit" LEDGER.md CLAUDE.md` (confirmed the new witness
is nowhere recorded); `rg -n "extends_of_repaint|extends_of_matching" Proofs/HadwigerNelson/Absorb.lean`
(checked the brief's own suggested candidate for the spare-colour lemma's kernel address — a *related*
but distinct lemma, `Extends.not_forces_of_colorable`/`Extends.not_separated_of_colorable`, which cite
the true base lemma in `SpareColour.lean` rather than being it); `rg -n "K1|K4|spare.colour lemma|
entropy floor" plans/STANDING-QUESTIONS.md` (spot-check only, confirming the cross-milestone
provenance note in `EntropyFloor.lean`'s docstring — this 80 KB file is **not** part of this batch's
assigned file list and was not read beyond these five grep hits: it is a living document plainly
touched by many milestones after M52, last modified 2026-09-17); zbMATH Open queries, recorded verbatim
inside each filed theorem's *Prior art:* field (§ PA.1's procedure), roughly a dozen calls in total.

**Files skipped, and why:** `tools/twodist.py`, `killengine.py`, `batchkill.py`, `cull_enum.py` — per
batch 1's finding (confirmed again here) that a plan's `§0a`/`§Bʺ` sections are the primary source and
tool docstrings restate rather than add; `data/m49-*.json` through `data/m52-*.json` and everything
under `data/m51/`, `data/m52/` beyond their two `README.md` files — provenance JSON, not proofs, per
the brief's own instruction; `plans/STANDING-QUESTIONS.md`, `plans/Q8-FIVE-CHROMATIC-OBJECTS.md`,
`plans/DESCENT-ALGORITHM.md` — all referenced from inside M51/M52's own text but outside this batch's
assigned file list (380 KB of the four milestone plans; these three add up to well over 150 KB more
and are explicitly batch 3's territory for `Q8-FIVE-CHROMATIC-OBJECTS.md`); no tool was run, no solver,
no `lake build`. Lean modules named in the rows and in every filed theorem's "Kernel" field: read in
full where the entry's proof depended on the exact statement (`SpareColour.lean`, `EntropyFloor.lean`,
`PartnerLattice.lean`, `Copy.lean`), existence-only `rg` checks for the rest (`DistanceGraph.lean`,
`OneDefect.lean`, `Instances/HexShell.lean`, `Instances/OneDefectSpec.lean`, `Absorb.lean`).

## What was delegated

**Nothing.** No subagent, fork, or workflow was started at any point in this batch; every file above
was read directly by this agent, and every zbMATH query and every gate run
(`tools/fs71_ledger_b_check.py`, `tools/claude_md_fact_audit.py --base <the commit before this batch>`
and `--dupes`, `tools/check_architecture.py`, `tools/bib_audit.py`) was executed directly, after each
milestone's commit.
