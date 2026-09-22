# Q8 — the five-chromatic-objects note — the theorem audit (FS-71 batch 3b)

*Filed 2026-09-22 by the batch-3b implementer. Enumeration: `plans/Q8-FIVE-CHROMATIC-OBJECTS.md` (in full, 174
lines); `plans/M51-derivation.md` (in full, already committed by batch 2b — re-read here specifically to
reconcile M51-T1 against Q8, per this batch's brief); `plans/M52-derivation.md` (in full, already committed by
batch 2b — re-read to confirm which of Q8's findings it already covers); `LEDGER.md` § B (M51-T1, M52-T1, M52-T2).
No ledger row exists for Q8 directly — its content was folded into M51-T1 (row-level: M51 has no numbered ledger
row of its own; its object is indexed only in § B) by batch 2b, which explicitly flagged Q8 as out of its own
scope and assigned to batch 3 (`plans/M51-derivation.md`'s M51-T1 entry, *Proof:* field: "that file is explicitly
assigned to FS-71 batch 3... and was not opened by this batch... batch 3 should reconcile against this entry
rather than re-derive it independently").*

## Reconciliation of M51-T1 against `plans/Q8-FIVE-CHROMATIC-OBJECTS.md`

**M51-T1's numbers are confirmed correct, with no correction needed.** Q8's Object Card 1 (`U ∪ R₂₀₆(U)`, "the
primary object") states 3,695 points, 25,486 unit edges, 34 cross chords, k = 4 UNSAT "in three encodings (one-hot
+ degree breaking 6.8 s; one-hot no breaking; 2-bit)", all 34 cross chords unit "to 250 digits (worst
`|d−1| = 4.4·10⁻²⁵¹`)", and "only 4 of 34 chords individually load-bearing" — **every one of these numbers matches
M51-T1's entry exactly** (3,695 points, 25,486 edges; three SAT encodings named identically, 6.8 s and 260 s
timed; 250-digit precision, the identical worst residual `4.4 × 10⁻²⁵¹`; four load-bearing chords). Q8's Object
Card 2 (`U ∪ R_v0(U)`, "the origin copy") states 58 cross chords, UNSAT both signs in two encodings (717 s), "no
single load-bearing chord (0 of 58)" — **also matches M51-T1's companion-copy clause exactly** (58 chords, no
single load-bearing chord). **Verification answered**: three independent SAT encodings (one-hot with degree-order
breaking; one-hot with no breaking; a 2-bit encoding), exact geometry checked to 250-digit precision via
`tools/copy_exact.py`. No further edit to `plans/M51-derivation.md` is made here — the entry already carries this
detail in full and cites the exact same figures; a second statement of the same fact under a `Q8-T` id would
duplicate it, against `plans/FS71-theorem-audit.md` §M.2's rule.

**What Q8 holds beyond M51-T1 and M52-T1/T2: two further objects, filed below as Q8-T1 and Q8-T2.**

## The theorems

**Q8-T1 — An 883-point 1-minimal core of the primary witness, in `K(√5)`. [tools; Kooshi's construction, verified
by the M51 implementer]** Deleting vertices from `U ∪ R₂₀₆(U)` (M51-T1's 3,695-point witness) under a minimality
search yields an **883-point** sub-object (434 original — 102 seed-descended + 332 halo, at provenance depths
1:154/2:103/3:60/4:15 — plus 449 copy-side points; 4,625 unit edges, 20 cross chords) that is **1-minimal**
(deleting any further vertex admits a 4-colouring) and **still not 4-colourable**, certified over 3,412 individual
deletion asks with **0 unknown** and a control UNSAT confirming the base object itself. This is "a distributed
refutation, de Grey-like, not a small gadget" (the source's own words) — the smallest certified sub-object of
M51-T1's witness found, at roughly a quarter of the full union's size. Field: by M52-T1 (already filed, batch 2b),
every point of this object lies in `ℚ(√3,√5,√11)` (the original side in `K = ℚ(√3,√11)`, the copy side adjoining
only `√5`). *Proof:* `plans/Q8-FIVE-CHROMATIC-OBJECTS.md` Object Card 4 (lines 47–52), the graph file
`data/m51/m51-copycore-about206-graph.json` (not re-verified in this batch — the 3,412-ask census and its control
are recorded but not re-run here). *Proof verdict:* closes at `[tools]` grade over the recorded census; no gap
found in what is on disk, but **the 3,412-ask deletion census itself was not re-executed by this batch** (per
FS-71's no-solver rule) — the verdict rests on the record's own control (UNSAT, unperturbed) matching M51-T1's
already-confirmed base refutation. *Rests on it:* nothing downstream in M51/M52/M53 adopts this specific
883-point core as descent material (M52's own front-runner for iteration 5 was the plain, uncoupled object — see
M52-derivation.md's readings section); it stands as a smaller alternative certificate target to M51-T1's full
3,695-point union, priced nowhere. *Prior art:* ours — the same construction genre as M51-T1 (no published
witness combines a glue-lattice-descended seed with a rotated spindle copy), minimised further by this project's
own deletion search; no fresh zbMATH query (the genre-level search was already run by M51-T1's entry: `ab:"unit
distance graph" & ab:"chromatic number" & ab:"construction"`, 14 hits, none matching). *Kernel:* declined —
"kernel certificate is priced and pending" per the source's own words (line 7); `rg -n "883" Proofs/` returns
nothing, so no later milestone closed it either.

**Q8-T2 — The four-copy composition refutes at four colours, and a full search for a sixth colour found none.
[tools; Kooshi's construction, verified by the M51 implementer]** Unioning both rotation signs about vertex 206
and both about the seed's centroid `v0` onto `U` gives a **9,194-point, 63,770-edge** object with 189 cross chords
(4 fused at the shared centres); it is **not 4-colourable** (UNSAT, 15.2 s), and remains not 4-colourable under
the full cheat set at five colours plus a control (UNSAT, 539 s — confirming the union really is at least
5-chromatic, not an artefact of a weaker ask). **A targeted search for a sixth colour** — separating the original
seed's forced pair `(205,206)` with zero cheats present, the "jackpot" ask — returned **SAT at 4,704 s**: **no
χ ≥ 6 witness was found on this object**, though the ask took roughly 40× longer than the single-copy refutation
(a hardness increase, not a colour-count increase). *Proof:* `plans/Q8-FIVE-CHROMATIC-OBJECTS.md` Object Card 3
(lines 40–45). *Proof verdict:* closes as a tools-grade census of exactly this one composed object (not a general
claim about compositions of this genre); the "no χ ≥ 6" half is a **negative finding, reported honestly as a
search result** — a SAT model was found, which is a certificate of *not* six-chromatic on this object, at this
ask, not evidence that no composition of this genre could ever be six-chromatic. *Rests on it:* nothing
downstream — M52's own front-runner for the descent abandoned the composed objects in favour of the plain one
(M52-derivation.md's readings section, "P5... refuted... kill fraction exactly 0.0000"); this entry is the record
of the one explicit χ ≥ 6 search this project's mascot-adjacent construction genre received before that
abandonment. *Prior art:* ours — an exhaustive-for-this-object SAT search; no external analogue (this is a
negative result over one specific held construction, not a general theorem). *Kernel:* declined (a solver
verdict over one finite object; no consumer named).

## Readings and measurements that were called theorems

- **"Witnesses, not descent material"** (`plans/Q8-FIVE-CHROMATIC-OBJECTS.md`, "What the copies are, after M52",
  lines 162–173): a ρ₁₅ copy is 4-colourable material attached by a few dozen chords, and at five colours the
  fifth colour "colours around it" — **zero of 15,218 separating-colouring classes killed**, 20 of 20 sampled
  classes extending with the copy side 4-coloured. **This is already filed, correctly, as a reading in
  `plans/M52-derivation.md`'s "Readings and measurements that were called theorems" section** ("the spare-colour
  lemma read as a statement about halos... kill fraction exactly 0.0000 across every composition") — not
  re-filed here, per this batch's own precedent of not duplicating a prior batch's already-correct classification.
- **Object Card 5** (the it-4 committed-object lock, `plans/Q8-FIVE-CHROMATIC-OBJECTS.md` lines 66–69): two
  further UNSAT confirmations (36 chords, 6.3 s; 64 chords, 4.2 s) on a *different* base fingerprint, showing "the
  lock survives the commit" — a robustness re-measurement of the same mechanism M51-T1 already certifies on the
  primary object, not independent content; not filed separately.
- **The atlas cards** (`tools/copy_anatomy.py --md` output, lines 105–159): ring censuses, direction-class counts
  and PSLQ-identified radii for five composed objects — the source's own docstring says these are "a census not a
  proof" (line 115 etc.); measurement, not theorems.
- **The lock-centre map** (lines 71–80): which seed/halo vertices individually "lock" (remain load-bearing under
  deletion) — a descriptive census consumed by M52's own culling work (already filed there), not separate content.

## Conjectures surfaced, not claimed

None found beyond what M51-derivation.md and M52-derivation.md already record (the field-tower question and the
composed-object adoption decision are both closed by measurement in those files, not left open here).

## Prior art re-attributed

None — M51-T1's existing zbMATH queries (`ab:"unit distance graph" & ab:"chromatic number" & ab:"construction"`,
14 hits; `au:"de Grey"`, 3 hits) already cover this construction genre; no new search run for Q8-T1/T2, which are
the same genre at different sizes.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| Q8-T1 (883-point core) | declined (priced nowhere; kernel certificate for M51-T1's parent object is itself "pending") |
| Q8-T2 (four-copy composition, jackpot null) | declined |
