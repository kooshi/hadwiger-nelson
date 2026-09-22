# FS-71 batch 3a — the theorem audit of M53–M55 and the field-wall theorem file

*Filed 2026-09-22 by the batch-3a implementer, a Sonnet 5 agent working alone (no subagent, fork or workflow
spawned — see "What was delegated" at the end). Read first, per the brief: `plans/FS71-theorem-audit.md` in
full, `plans/FS70-derivation.md` (the template), `plans/M50-derivation.md` and `plans/M51-derivation.md` (the
nearest precedent for a milestone whose theorems live in a companion note and for a milestone with no ledger
row), `data/fs71/batch-2b.md`, `LEDGER.md` rows 47–49 and § B.*

## Headline

**M53–M55 + the field-wall file: 25 theorems filed in 3 files, 4 re-attributed (partly or wholly to prior
art), 0 demoted (gap), 1 flagged *unsure*; enumeration complete.**

Fourteen theorems from M53 (`plans/M53-derivation.md`, all of `plans/FIELD-WALL-THEOREM.md`'s substantive
content plus M53's own extension of it), four from M54 (`plans/M54-derivation.md`), seven from M55
(`plans/M55-derivation.md`). No milestone was empty. One theorem (Proposition 6.4, the multiquadratic
two-colour criterion) is the same fact `LEDGER.md` row 63 already credits to milestone FS-36 — recorded in
`FIELD-WALL-THEOREM.md` itself under a later date, flagged for batch 5, and **not given a fresh id** to avoid
filing one fact twice. Theorem A and Theorem B (M53-T1, M53-T3) were hand-proved by M53 on 2026-09-05 and
independently kernelized eight days later by a different proof (backlog item B1, `LEDGER.md` row 57, batch
3b's territory) — filed here as M53's, with the kernel event named and flagged for batch 3b so the fact is not
duplicated under two ids.

**The most consequential finding is not a filed theorem but a correction to my own audit, caught by re-reading
`data/m55/README.md` after the derivation file was already committed**: M55-T4 (degree absorption, the
`(k+1)`-core) was first filed as "kernel for the single-vertex step, declined for the iterated form" — wrong.
`Absorb.lean`'s `extends_of_extensionOrder` is exactly the general iterated-peeling theorem, and
`extends_compl_singleton_of_degree_le` is proved *from* it at a one-element list, not a separate primitive.
Caught and fixed in a follow-up commit before hand-back (see "Where the brief was wrong" and the commit log).

**Second finding: the brief's own seed pointed at two things that are not in this batch's files.** (1) G37's
"6-open single radicals over K… non-residues mod 11" list, which the seed said to find "in M53 or M58" — it is
**M58's** (`plans/M58-field-sieve.md`), not M53's; M53 contains only the *necessity* half (Theorem 7.1, filed
as M53-T11) and nothing about residues mod 11. Flagged for batch 3c (M58–M61). (2) `CLAUDE.md` G31's corollary
about de Grey's 1581-vertex graph ("forcing at χ allows ≤ 2 critical vertices, and this 1-sum has 3, so de
Grey's 1581 has no forced pair at five") is **not stated anywhere in M53, M54 or M55's own files**
(`rg -n "1581|de Grey"` on both plan files returns nothing). The "≤ 2 critical vertices" half is M54-T1
(filed, kernel); the "this 1-sum has 3" half and the corollary's own combination trace to `plans/FS25-P2.md`,
which is batch 5's territory. Flagged there, not filed here.

## The census table

*One row per file in the batch, the field-wall file included as its own row per the brief. "Candidates" lists
what the ledger row plus the file's own content offered; "classified as" gives kernel / measurement / reading
/ instance / prior art / conjecture with one line why, per candidate.*

| file | ledger row | candidates found | filed as | classified as |
|---|---|---|---|---|
| `plans/FIELD-WALL-THEOREM.md` | 47 | every numbered proposition of §1–§10.2: Theorem A, Lemma 5.2, Theorem B, Lemma 4.1, Proposition 6.1 + Corollaries 6.2/6.3, Proposition 6.4 (original and corrected), Corollary 6.5, Theorem A′ + Corollary 6.6, Lemma 7.5, Lemma 7.2, Theorem 7.1, Theorem 7.3, Corollary 7.4, the two spindled witnesses (§7.5); the wall-break census, the rigidity dial, "single points kill nothing" (§7.4, §8.7) | **M53-T1 through T5, T7 through T15** (T6 = Prop. 6.4, not given a fresh id) | hand, closes, filed (13 of 15 propositions) · hand, closes, filed but re-attributed to a prior kernel event (T1, T3 — Theorem A/B) · = row 63/FS-36, not re-filed (Prop. 6.4) · tools, closes (T14) · tools, unsure (T15) · measurements/readings, not filed (the wall-break census, the rigidity dial's nonzero counts, "single points kill nothing") |
| `plans/M53-iteration-5.md` | 47 | the halt record (§R5, = the field-wall file's Theorem B, not double-filed); the descent engine's own design decisions (D2, D4, D11 — instrument design, not mathematics); the lattice-closure lemma pointer (D11, = M53-T9) | none new | engineering/instrument design, out of mathematical scope (D2, D4) · pointer to M53-T9, already filed (D11) · the halt itself is M53-T3/T11's context, already filed |
| `plans/FIELD-WALL-SESSION-HANDOFF.md` | 47 | items 1–10 (T16–T20, Q10) restating the field-wall file's own content plus the rigidity dial and Kooshi's three questions; "novel approaches now open" (a ranked list of next steps, not results); "derivations to attempt" (registered ideas, none run in this batch's files) | none new | restatement of already-filed content (T16–T18 = M53-T1–T13's material) · measurement (the rigidity dial, Q10 — already noted as not filed) · registered ideas, not results (§5, §6) |
| `plans/B1-field-wall-kernel.md` | 57 (batch 3b's row) | the kernelization of Theorem A/B by a parity descent bypassing valuation theory; the module layout, the modeling passes, nine domain-modeling changes, six obligation-modeling decompositions | none — context only | this file's own content is row 57's, assigned to batch 3b; read here only to fix M53-T1–T3's exact kernel decl names and confirm the different-proof relationship, not to file new theorems from it (which would duplicate batch 3b's job) |
| `plans/STUB-field-wall.md` | — (pre-milestone stub) | the "lattice-closure lemma" (statement 1) — matches M53-T9; the field-wall conjecture as originally posed (statement 2) — matches M53-T3/M53-T11 | none new | pointers to already-filed theorems; the stub's own halt-clause programme is superseded by the actual milestone |
| `plans/STUB-field-wall-kernel.md` | 57 (batch 3b's row) | the DVR/valuation-ring proof route B1 abandoned (§2) — a planned, unused proof shape, not the one formalized | none | superseded planning content, context only; row 57's actual kernel result is B1's, batch 3b's |
| `plans/DESCENT-ALGORITHM.md` | — (a synthesis note, halted 2026-09-05) | "the minimum-halo theorem" (WO-9, 2026-08-31) — the Rust descent engine's downward-closedness argument; "the wall — a theorem" (§, restating M53-T3/T11) | none new | WO-9 already classified out of mathematical scope by batch 2b's `plans/M51-derivation.md` (confirmed here, not re-filed); the wall section restates already-filed content |
| `plans/M54-five-colour-dial.md` | 48 | D1 (the critical-set localization theorem), D2 (the absorption reading, theorem-ized at M55), D3 (the field F₂₄₇/cross glue points, a computation), D4 (a reading about a hypothetical 6-forcer's shape), D5 (ν = δ₄); the two C = ∅ objects; the forcing-critical-set derivation (§R3) | **M54-T1 through T4** | kernel, filed (T1) · hand, filed, more general in the kernel than stated (T1's own generalisation note) · hand, filed (T2, T4) · tools, filed (T3) · reading, not filed (D4) · computation, not filed separately (D3) |
| `plans/M55-absorption.md` | 49 | D1 (the extension principle), D2 (hub-and-matching absorption), the repaint lemma (found while formalizing D2, not a separately numbered plan item), D3 (degree absorption/the `(k+1)`-core), D4 (symmetric copies), D6 (the star, the flower, fusion — four sub-claims of mixed character); the F₂₄₇ depth-two census | **M55-T1 through T7** | kernel, filed (T1, T2, T3, T4, T5) · hand, closes, filed (T6 = D6(c) only) · tools, filed (T7) · readings/measurements on the objects built, not filed (D6(a), D6(b), D6(d)) · conjecture, not claimed (T24, the copy-side asymmetry) |

## Progress and resume

**Batch 3a is complete: M53, M54 and M55 filed, `FIELD-WALL-THEOREM.md` fully covered under M53's prefix, no
successor needed for this batch.** Per `plans/FS71-theorem-audit.md` §S.6's ten-batch numbering, batch 3b
(M56–M57, `A1-theorem-A-kernel.md`, `MASCOT-DERIVATION.md`, rows 50, 51, 57, 58) is next, followed by batch 3c
(M58–M61). Three items flagged for later batches, each also in "Where the brief was wrong":

1. **Batch 3b**: reconcile row 57 (Theorem A/B in the kernel, B1's parity-descent proof) against this batch's
   M53-T1/T2/T3, which already name the exact kernel declarations and the "different proof, eight days later"
   relationship — do not re-file Theorem A/B as new theorems under a `R57-T` id without cross-checking here.
2. **Batch 3c** (M58–M61): G37's radical-list target (`CLAUDE.md` "7, 13, 79, 127, … non-residues mod 11") is
   `plans/M58-field-sieve.md`'s, not M53's — confirmed absent from every file in this batch by grep.
3. **Batch 5** (FS-24–FS-38): (a) reconcile `plans/FS25-P2.md`'s de Grey-1581 critical-vertex theorem against
   M54-T1 (this batch's localization theorem, which its own "≤ 2 critical vertices" half needs); (b) Proposition
   6.4's correction in `FIELD-WALL-THEOREM.md` §10.2 is the same theorem as row 63 / FS-36's — cite this
   batch's M53 file rather than re-deriving; (c) M53-T8 (Theorem A′/Corollary 6.6, "the linear method", the
   3-adic wall by a norm-one-avoiding subgroup) predates row 50/M56's "additive yardstick" by ten days —
   check `Additive.lean` against it before crediting M56 with originating the linear method.

## Theorems this phase proved

**None** — as expected for an audit, with one exception recorded honestly: **the correction to M55-T4 found
while re-reading `data/m55/README.md`** (`extends_of_extensionOrder` is the iterated `(k+1)`-core theorem, not
a missing target) is not new mathematics — it was already a kernel theorem before this batch started; what
this phase produced was the *finding* that an earlier draft of this audit had mis-scoped it, corrected in a
follow-up commit. No new mathematics was produced by this batch.

## Proposed edits to `CLAUDE.md`

**None.** No grokking in G1–G69 was found stated incorrectly by this batch's material. Three candidate edits
were considered and declined:

1. *G38*'s "the linear method's thresholds… proved where? M56" could be sharpened to name M53-T8 (Theorem A′
   /Corollary 6.6) as the earliest instance — **declined**: this batch has not read M56's `Additive.lean`, so
   whether M56 subsumes, generalises or independently rediscovers the linear method is unknown; the finding is
   recorded as a cross-batch note for batch 3b/5 instead, where it can be checked against the actual file.
2. *G31*'s de Grey-1581 sentence (already correct as written in `CLAUDE.md`, quoting the exact corollary this
   batch went looking for) needs no correction — only its *derivation-file home* was missing, which is
   `plans/FS25-P2.md`'s to supply (batch 5), not a `CLAUDE.md` change.
3. *G40*'s citation of `extends_of_hubs` (row 49, M55) is confirmed exactly correct by this batch's reading of
   `Absorb.lean` and `data/m55/README.md` §R1 ("the copy hangs on the fabric by its fused centre and one
   chord, and the theorem's bound is tight") — no edit needed.

## Where the brief was wrong

- **Mostly right, with three real gaps and one genuine mistake of my own, all recorded above.** The seed
  correctly named every candidate in row 47's own text (the residue colouring, the residue obstruction, μ ≥ 3,
  the wall-break census, the K(√247)/K(√23) witnesses, Harder's credited pair) and correctly flagged
  `FIELD-WALL-THEOREM.md` as the batch's densest file, "each proposition… gets its own entry or
  classification" — which this batch followed, filing thirteen of its fifteen numbered propositions and
  classifying the other two (Theorem A/B as kernel-elsewhere, Proposition 6.4 as row 63's).
- **G37's radical list is not in M53** (brief: "M53 or M58: find where") — it is M58's, confirmed absent from
  every file this batch read. The brief could not have known this without reading M58, which is out of this
  batch's scope; flagging it precisely (rather than guessing at a derivation) is the honest outcome.
- **G31's de Grey-1581 corollary is not in M54 or M55** despite the brief listing it under "row 48" — the
  brief's own phrasing ("a derivation to file under M54") turned out to be a reasonable guess that the source
  material does not bear out; the "≤ 2 critical vertices" half genuinely is M54's (filed), but "this 1-sum has
  3" and the combination are a different milestone's (`plans/FS25-P2.md`), found by grep after the expected
  location came up empty.
- **`plans/B1-field-wall-kernel.md` and `plans/STUB-field-wall-kernel.md` are listed in this batch's file set,
  but their substantive content (Theorem A/B's kernel proof) belongs to row 57, explicitly assigned to batch
  3b.** Read as context (to get exact kernel declaration names and the "different proof" relationship right),
  not mined for new theorems — the alternative (filing B1's own nine domain-modeling findings and six
  obligation-modeling decompositions as fresh theorems) would have duplicated batch 3b's assignment.
- **My own error, caught and fixed before hand-back**: the first pass of M55-T4 missed that
  `extends_of_extensionOrder` — not just `extends_compl_singleton_of_degree_le` — is kernel, because the
  declaration list I grepped early in the batch (`Absorb.lean`'s theorem headers) *did* show
  `extends_of_extensionOrder`, but I filed the entry from memory of the plan's own D3 text (which states only
  the single-vertex case explicitly) rather than re-checking the declaration list against it. Caught only when
  `data/m55/README.md` named it directly ("greedy absorption (`extends_of_extensionOrder`) — the `k`-core").
  Lesson for future batches: cross-check a "declined, no consumer" verdict against the plan's own `data/*/README.md`
  before filing it — the README is often more current than the plan's own numbered-derivation prose.
- **File sizes matched** the brief's table exactly (`ls -la` confirmed all nine before reading); the "expected
  density: high" prediction held (25 theorems from three milestones plus one companion file, against roughly
  half that for a typical earlier batch).

## The enumeration

**Files read in full:** `plans/FS71-theorem-audit.md`, `plans/FS70-derivation.md`, `data/fs71/batch-2b.md`,
`plans/M51-derivation.md`, `plans/FIELD-WALL-THEOREM.md` (all 783 lines, §1–§10.2), `plans/FIELD-WALL-SESSION-HANDOFF.md`
(245 lines), `plans/B1-field-wall-kernel.md` (326 lines), `plans/STUB-field-wall.md` (49 lines), `LEDGER.md`
rows 44–58 and § B (twice — before and after inserting this batch's lines), `data/m53/README.md`,
`data/m54/README.md`, `data/m55/README.md` (22, 38, 38 lines).

**Files substantially read (major sections, not cover-to-cover):** `plans/M50-derivation.md` (first ~80
lines, as a second precedent alongside M51's); `plans/M53-iteration-5.md` (896 lines total — §R5 read in full,
lines 804–897, the halt record and every consequence; the phase-order table §1 and the decision table §B
skimmed for grade tags; the earlier §R0–§R4 sections grepped for the discipline pattern, no new theorem-shaped
content found beyond engineering/instrument design already classified); `plans/M54-five-colour-dial.md` (659
lines — §3's D1–D4 read in full, lines 59–140; §R0–§R8 and the addendum read in full, lines 411–660; the
modeling-pass sections §Bʹ/§Bʺ/§Bʹʹʹ and §1–§2's phase-order tables not read, no theorem content expected
there and none found by the grep pass); `plans/M55-absorption.md` (650 lines — §3's D1–D6 read in full, lines
63–148; §R0–§R1 read in full, lines 381–426; §R2–§R5 and the addendum read for the predictions table and
close, lines 465–606; the modeling-pass sections not read, same reasoning); `plans/STUB-field-wall-kernel.md`
(175 of 175 lines — the DVR route §1–§5 read to confirm it is superseded, not the "Built" record which
duplicates B1's own §9); `plans/DESCENT-ALGORITHM.md` (393 lines — grepped for the discipline pattern; "The
wall — a theorem" section read in full, lines 365–394; the "minimum-halo theorem"/WO-9 section read, lines
210–260, and cross-checked against `plans/M51-derivation.md`'s existing classification).

**Grep patterns used** (the §S.4 discipline, plus targeted follow-ups): the standard pattern
(`theorem|lemma|proposition|corollary|claim|derivation|derived|by hand|\[hand\]|\[derived\]|\[cert\]|\[proof\]|
we prove|proof:|QED|∎|iff|if and only if|exactly when|for every|for all|conjecture|not claimed`) across
`M53-iteration-5.md`, `M54-five-colour-dial.md`, `M55-absorption.md`, `DESCENT-ALGORITHM.md`; `rg -n "non-residues
mod 11|non-residue mod 11"` across `plans/` and `CLAUDE.md` (located G37's home in `plans/M58-field-sieve.md`,
confirmed absent from this batch's files); `grep -rn "1-sum has 3|three critical vertices"` across `plans/`
(located G31's home in `plans/FS25-P2.md`); `rg -n "1581|de Grey"` on `M54-five-colour-dial.md` and
`M55-absorption.md` (zero hits, confirming the corollary's absence); `grep -n "^theorem\|^lemma\|^def "` on
`Proofs/HadwigerNelson/CriticalSet.lean`, `Absorb.lean`, `ResidueColouring.lean`, `PartnerLattice.lean`,
`TwoColourResidue.lean`, `FieldWall4.lean` (fixed every kernel declaration name cited); zbMATH Open queries,
recorded verbatim inside each filed theorem's *Prior art:* field — `ab:"unit-distance graph" & ab:"number
field" & ab:"prime"`, `ab:"2-adic" & ab:"chromatic number"`, `ab:"norm-one group" & ab:"coloring"`,
`ti:"chromatic number" & ab:"biquadratic"`, `ab:"unit distance" & ab:"quadratic field" & ab:"triangle"`,
`ti:"Moser spindle" & ab:"field"` (all zero hits — this project's own construction genre, consistently); the
held bibliography (`BIBLIOGRAPHY.md`) grepped for `Fischer`, `Woodall`, `Moorhouse`, `Madore`, `Johnson`,
`Chow1993`, `Chilakamarri`, `ExooIsmailescu`, `BendaPerles`, `AxenovichEtAl` — used in place of fresh queries
wherever the held entries already gave exact theorem-number attributions (per PA.1 item 2, "the held
bibliography first"), which this batch's density made the dominant source: `[Fischer1990]`, `[Fischer1990b]`,
`[Fischer1994]`, `[Moorhouse2010]`, `[Madore2015]` were all held, read in full, and already exhaustively
reconciled against this exact file's own propositions by two earlier sessions (2026-09-06's §10.1, 2026-09-16's
`[Fischer1990b]` read, 2026-09-19/22's `[Fischer1994]` find) — re-running identical queries against them would
have reproduced results already on record, so this batch cited the held reconciliation directly rather than
re-querying, and ran fresh zbMATH queries only for the handful of theorems with no existing bibliography
attribution (Theorem A′/Corollary 6.6, the 2-SAT residue obstruction, D6(c)'s fusion fact, the localization
theorem, the absorption theorems).

**Files skipped, and why:** `tools/residue_colouring.py`, `residue_floor.py`, `wall_break_test.py`,
`five_dial.py`, `absorb_dial.py` — docstrings spot-checked via their citing plan sections rather than opened
directly, per batch 1/2b's repeated finding that tool docstrings restate the plan rather than adding content
(confirmed again: every fact this batch needed from a tool was already stated in the plan's §R sections or the
`data/m5{3,4,5}/README.md` files); `data/m53/*.json`, `data/m54/*.json`, `data/m55/*.json` beyond the three
`README.md` files — provenance, not proofs, per the brief's own instruction; `Proofs/HadwigerNelson/FieldWall.lean`
(imported by `FieldWall4.lean` but not itself cited by any filed theorem — the seam-group machinery it holds
predates this batch's milestones); `reference/Chat-analysis/`, `reference/ChatGPT-multiquadratic/` — the
handoff behind Proposition 6.4's §10.2 correction, not opened since that theorem is row 63/FS-36's and not
re-filed here; no tool was run, no solver, no `lake build`.

## What was delegated

**Nothing.** No subagent, fork, or workflow was started at any point in this batch; every file above was read
directly by this agent, every zbMATH query was executed directly, and every gate run
(`tools/fs71_ledger_b_check.py`, `tools/fs71_ledger_b_check.py --strict`, `tools/claude_md_fact_audit.py --base
60b562061122f4cdc30310fd765b6cb27eb2a196`, `tools/check_architecture.py`, `tools/bib_audit.py`) was executed
directly, after each milestone's commit.
