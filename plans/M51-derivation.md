# M51 — the theorem audit (FS-71 batch 2b; no ledger row)

*Filed 2026-09-22 by the batch-2b implementer. Enumeration: `plans/M51-descent-engine.md` read in full
(mission context, §B–§Bʹʹʹ, §0–§2, §R0–§R-E2, §R-INC5, §S-CONT in full including the 2026-09-01 "Q8"
session log, §R-INC6 to the file's end); `Proofs/HadwigerNelson/SpareColour.lean`,
`Proofs/HadwigerNelson/EntropyFloor.lean` read in full; `plans/STANDING-QUESTIONS.md` spot-checked
(K1, K4 entries only — a living cross-milestone theory document, NOT part of this batch's assigned
files, last touched 2026-09-17, well past M51/M52's dates; grepped, not read, per "files skipped and
why" in the batch report). **M51 has no dedicated row in `LEDGER.md`** — the brief's own mapping
(`plans/FS71-theorem-audit.md` §G.2, "Batch 2 — M37–M52 (rows 34–46)") assigns four milestones
(M49–M52) to three rows (44–46); confirmed by `grep -n "M51" LEDGER.md` (zero hits). This file exists
anyway, per the batch's per-milestone-not-per-row instruction (brief: "Milestones M49–M52; ledger rows
44–46"), because M51 unambiguously ran (127 KB of plan, real incidents, a real kernel sitting,
`data/m51/`) and is not a stub.*

## Why this file holds no `§ B`-eligible theorem

M51's mathematical design work — the spare-colour lemma and the entropy floor theorem, both sketched
with `sorry`s at §C and two-line proof arguments walked at §Bʺ — is **fully proved in the kernel at
this milestone** (`Proofs/HadwigerNelson/SpareColour.lean`, `Proofs/HadwigerNelson/EntropyFloor.lean`,
§R0, "Phase 0k — the kernel sitting... LANDED first sitting"). Per FS-71 §M.1's disposition table, a
kernel theorem is "the ledger row's; not filed again" — but see `plans/M50-derivation.md`'s "Kernel
already, one milestone later" section for the full account (these theorems' proof sketches were
*designed* at M50, so their derivation-file entry lives there, pointing forward to their kernel
address here) and the flagged gap (no ledger row names either file). Filed at M50, not repeated here.

## The one finding this milestone produced that IS outside the kernel and does need a home

**M51-T1 — A new 5-chromatic unit-distance witness, glue-lattice-grown then detuned. [tools; Kooshi's construction, verified by the M51 implementer]**
`U ∪ R₂₀₆(U)` (3,695 points, 25,486 unit edges) is a new 5-chromatic unit-distance graph, one ρ₁₅
spindle copy fused to a descended seed. Let `U` be the unit part of the M50/M51-descended object at iteration 4 (1,834 live
points, 12,735 unit edges, 4-colourable), a graph in `K(√5) = ℚ(√3,√5,√11)` (the M50-descent seed lies
in `K = ℚ(√3,√11)`, per M52-T1 below, found the following milestone; the ρ₁₅ rotation adjoins `√5`).
Let `R := rotAbout 206 ρ₁₅` (`ρ₁₅ = (7+i√15)/8`, the record's own detuning rotation, G7's `n = 4`
member). Then `U ∪ R(U)` (identifying `206` with its own image, both rotation signs, 34 cross chords)
is **not 4-colourable** — hence a 5-chromatic unit-distance graph, by the spindle-free direct
route (a k = 4 UNSAT ask on the union, not a forced-pair argument): checked UNSAT in three independent
SAT encodings (one-hot with degree-order breaking, 6.8 s; one-hot with no breaking; a 2-bit encoding,
260 s), with all 34 cross chords verified unit to 250-digit precision (`tools/copy_exact.py`, worst
residual 4.4 × 10⁻²⁵¹). A companion copy about the seed's centroid `v0` (58 chords) is likewise UNSAT
at k = 4, with **no single load-bearing chord among its 58** (multiple disjoint routes, unlike the
206-copy's four load-bearing chords). *Mechanism, as measured, not claimed as a theorem*: exactly four
of the 206-copy's 34 chords are individually load-bearing, pairing two depth-one glue points at
distance exactly `1/√3` from each other (the two-circle inner radius); the complete forced-equal sweep
of `U` alone at four colours (142 calls) finds 137 forced-equal pairs, all at radicands `247/9` or
`253/3` — both **outside** this project's owned fields — so the lock is read as a compound
compulsion, not a single Moser-style spindle. This event fulfils a pre-registered halt clause: the
milestone's own "phase monitor" (`Forces.not_colorable`, `SpareColour.lean`, kernel already —
M50-derivation.md) predicted the descended object's unit part must cross from 4-colourable to
not-4-colourable strictly before the descent completes, minting a certified new witness as a side
effect; this is that witness. *Proof:* `plans/M51-descent-engine.md` §S-CONT, the entries timestamped
"2026-09-01 03:20Z–04:00Z" ("Q8: KOOSHI'S DUPLICATE-AND-DETUNE IDEA...") and "04:00Z–05:20Z" (follow-up
measurements); `plans/Q8-FIVE-CHROMATIC-OBJECTS.md` is named in the record as the durable object-card
file recovered after two auto-compactions — **that file is explicitly assigned to FS-71 batch 3**
(`plans/FS71-theorem-audit.md` §G.2, "Batch 3... plans `M53…M61`,... `Q8-FIVE-CHROMATIC-OBJECTS`") and
was **not opened by this batch** (out of scope, and reading it risks duplicating work batch 3 is
staffed for) — batch 3 should reconcile against this entry rather than re-derive it independently, and
the product owner should decide which file is the theorem's permanent home. *Proof verdict:* closes
(tools grade — the geometry and the SAT refutation are both exhibited and cross-checked in three
encodings; no gap found in what is on disk). *Rests on it:* nothing downstream in M51/M52 adopts this
object as the descent's material (the plan records the decision explicitly: "the lock is monotone under
added material, so nothing is thrown away... THEN the composed object... gets the full count" — i.e.
M52 studied compositions built from it, see M52's census note on "the seven compositions", but M52's
own front-runner was ultimately the *plain* object, not this composed one, F3 in `M52-copy-lock-objects.md`).
*Prior art:* ours — Kooshi's own construction idea ("duplicate the object and detune the copy... to
manufacture the χ(unit-part) 4→5 crossing"), explicitly citing the genre of de Grey's and Heule's own
witnesses as the template; the object itself (a glue-lattice-grown seed unioned with one ρ₁₅ rotated
copy) is new, "no published witness's genre" per the record's own words — an internal claim, not
independently checked against the literature by this entry (a fresh prior-art gate on "5-chromatic
unit-distance graph glue-lattice construction rotated copy" is owed if this object is ever promoted to
a certified ledger row). zbMATH: `ab:"unit distance graph" & ab:"chromatic number" & ab:"construction"`
(14 hits, the general Hadwiger–Nelson construction literature — de Grey, Heule, Exoo–Ismailescu among
them by author search, nothing matching this specific glue-then-rotate genre by title); `au:"de Grey"`
(3 hits, his own papers). *Kernel:* **not attempted — "kernel certificate pending" in the record's own
words**, and no later milestone's kernel work (checked: `rg -n "3695\|3,695\|copyOfV0\|U ∪ R" Proofs/`
returns nothing) closes it. Priced nowhere; declined by default until named as a target.

## Readings and measurements that were called theorems

- **WO-9's "criticality witness... downward-closed" argument** (§S-CONT, "WO-9 FROZEN... with a
  NEGATIVE verdict, by theorem") is a real, correctly-argued monotonicity fact (a surviving colouring
  of `halo ∖ {v}` survives every subset halo too) — but it is entirely about the sibling `descent-engine`
  Rust repository's internal shrink algorithm, not about unit-distance graphs or chromatic numbers, and
  has no Lean-representable content. Out of this project's mathematical scope; not filed.
- **The 883-core's field re-pricing** (§8½ of M52, but the finding is M51's own atlas work continuing
  into M52 — flagged here to avoid a seam): "T14... every live point of the object has coordinates in
  ℚ(√3,√5,√11)" is the theorem M52-T1 files in full; the M51 log's Q8 session anticipates part of the
  same field fact in prose ("their spindle never left the seam tower") without the exact verification —
  the exact verification is M52's, and is filed there.
- Every other §S-CONT entry (engine swaps, incidents INC4–INC6, WO-7/WO-10/WO-11/WO-14 acceptance
  measurements, the server/NUMA planning) is Rust-engine performance engineering, correctly classified
  throughout its own record as measurement, method or incident, never claimed as mathematics.

## Conjectures surfaced, not claimed

None found with a stated but unclosed proof.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M51-T1 | declined by default — no kernel work attempted; flagged as a target if the object is ever promoted |
