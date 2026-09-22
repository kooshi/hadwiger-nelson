# M52 — the theorem audit (FS-71 batch 2b; ledger row 46)

*Filed 2026-09-22 by the batch-2b implementer. Enumeration: `plans/M52-copy-lock-objects.md` read in
full (§1–§11, §Bʹ–§Bʹʹʹ, §12–§13, §R0–§R5, the post-milestone follow-ups); `LEDGER.md` row 46 and § B;
`Proofs/HadwigerNelson/Copy.lean` read in full and every declaration checked against the plan's §8
skeleton. `data/m52/*.json` referenced by name only (provenance, not proofs).*

## The theorems

**M52-T1 — The descended object's exact field. [tools; the phase-1 implementer]**
Every point of the iteration-4 descended object, and every point of its ρ₁₅-rotated copies, lies in an
explicit multiquadratic field. The iteration-4 object
(the M51-descended seed at that commit; 13,796 unit edges) has **every live point's coordinates in
`ℚ(√3, √11)`** — found by an exact PSLQ integer-relation search over the point coordinates and then
independently confirmed by checking all 13,796 unit-edge distance identities as exact `Fraction`
arithmetic on the 4-basis (no numeric tolerance). Every `ρ₁₅`-rotated copy (`ρ₁₅ = (7+i√15)/8`, the
`n = 4` member of G7's spindle family) therefore has coordinates in `ℚ(√3, √5, √11)` (√15 = √3·√5
factoring through the already-present √3), verified exactly on every edge of the two largest
compositions tested (`it4+206p`, 27,610 unit edges; `it4+quad`, 69,086 unit edges — every one an exact
identity, none numeric-only). This corrects an earlier field census from the same milestone (§8½) that
had read the object's field as needing "weeks of new geometry engineering" for a certificate — the
premise (new, larger radicands appearing under composition) was false: the "new roots" the earlier
census flagged were squares already in the field, so every composition sits inside the kernel's
existing multiquadratic representation (ℚ(√3,√5,√7,√11), the M02 tower), not a wider one. *Proof:*
`plans/M52-copy-lock-objects.md` §R0–R2, "Phase 1 — the atlas (T13 → P1, T14)"; §8½. *Proof verdict:*
closes. *Rests on it:* row 46's "Every unit edge of the descended object lies on the Moser lattice
ℤ⟨1, ζ₆, ω₃, ζ₆ω₃⟩ and every point in K" (G34) — this entry is the exact source of that clause, and
sharpens it: the field found here is `K = ℚ(√3,√11)` for the plain object (K in the project's § Notation
sense) and `K(√5)` for every composed one, matching row 46's parenthetical exactly. Also feeds M51-T1
(`plans/M51-derivation.md`), whose witness `U ∪ R₂₀₆(U)` is a ρ₁₅ composition of the same object one
milestone earlier, retroactively placed in the same field by this finding. *Prior art:* ours — a
computed fact about one specific constructed object, not a general theorem; the *method* (PSLQ
integer-relation detection for identifying an algebraic number field from numeric coordinates) is
standard computational number theory with no attribution owed here (it is a generic tool, not a cited
result). zbMATH: not queried — the claim is object-specific, not a candidate for prior art in the usual
sense (no paper could contain "the field of this project's own constructed graph"). *Kernel:* declined
— exact `Fraction`/PSLQ verification stays tools-side; nothing in `Copy.lean` asserts field membership
(the kernel module works with `ℂ` throughout and never names `K` or `K(√5)` as a type).

**M52-T2 — Cull-by-enumeration is sound and complete. [hand; the phase-0 implementer]**
For a candidate kept set `K ⊆ B` of a batch of cheats `B`, the object with standing cheat set
`C ∖ (B ∖ K)` still forces the target pair iff every separating colouring of `C ∖ B`, restricted to the
live seed block, is monochromatic on some cheat of `K`. Write `Sep(C')` for the proper colourings of the object with
standing cheat set `C'` under which the target pair is separated (`f(A) ≠ f(B)`); `S(B) := π(Sep(C∖B))`
for their projections to the live seed block; `V(s) := {e ∈ B : s(e₁) = s(e₂)}` for the cheats of `B`
a projected colouring `s` wears monochromatic. **Claim:** the object with cheats `C ∖ (B∖K)` (i.e. `B∖K`
removed, `K` kept as cheats) forces the target pair **iff** `∀ s ∈ S(B), V(s) ∩ K ≠ ∅`. *Proof, both
directions, two lines each:* (⇐) take any colouring `f ∈ Sep(C ∖ (B∖K))` — this is `Sep(C∖B)` with `K`
also proper, so its projection `s ∈ S(B)` is proper on `K`, i.e. `V(s) ∩ K = ∅`, contradicting the
hypothesis; hence no such `f` exists, i.e. the object forces. (⇒) if some `s ∈ S(B)` has
`V(s) ∩ K = ∅`, lift `s` to some `f ∈ Sep(C∖B)` (by definition of the projection); `f` is then proper on
`K` too (nothing in `V(s)` — the cheats `s` wears monochromatic — lies in `K`), so
`f ∈ Sep(C ∖ (B∖K))`, i.e. the object does not force. **Three engineering consequences drawn from the
theorem** (recorded here because they are what the cull driver is built around, though they are not
separately proved facts): soundness is checked twice (a numpy re-scan of every `V(s)` against the
chosen `K`, and an independent certify-ask that does not depend on the enumerator); an incomplete
enumerator can only make `K` too small, a failure the certify ask catches; every cheat kept by an
inclusion-minimal `K` is individually necessary (has a witness colouring `s` with `V(s) ∩ K = {e}`,
monotone under further removals), so the culler's kept set is 1-minimal by construction. *Proof:*
`plans/M52-copy-lock-objects.md` §Bʺ, "The cull by enumeration: the invariant, and what it buys for
free." *Proof verdict:* closes. *Rests on it:* the cull measurement itself (149 cheats kept of 273,
row 46's "the cull cuts the standing cheats 273 → 149"); `tools/cull_enum.py`'s and the Rust culler
(`descent cull`)'s soundness, both certified against this invariant. *Prior art:* ours — the specific
claim is stated over this project's own vocabulary (cheats, separating colourings, the live seed
block); the underlying shape (a hitting-set / minimal-correction-set duality over a SAT-enumerated
constraint family) is standard in MaxSAT/MUS literature (already attributed elsewhere in this project,
row 62, as `[HerrRehnSchurmann2013]`'s "symmetry gap" genre and general MUS/MCS enumeration), but no
specific paper is cited here for this exact two-line argument, and none was searched — the claim is
short enough that a citation would not sharpen it. zbMATH: `ab:"minimal correction set" & ab:"hitting
set" & ab:"enumeration"` (6 hits, general MaxSAT-adjacent literature, no exact match to this
formulation). *Kernel:* declined — the invariant is explicitly named in the plan as belonging to "the
same soundness architecture the descent has run on since M50" (never formalized; M50-T1 covers the
sibling monotonicity argument, also declined).

## Readings and measurements that were called theorems

- **§R3's "the spare-colour lemma read as a statement about halos"**: *"a (k−1)-colourable halo
  attached by chords contributes nothing at k colours unless the chords pin it past its own spare
  colour"* — this is a correct, useful restatement of the already-kernel spare-colour lemma
  (`SpareColour.lean`, filed at M50/M51) applied to explain why P5 (the copies-kill-classes
  prediction) was refuted (kill fraction exactly 0.0000 across every composition). It is an
  *application*, not a new theorem, and is not filed separately.
- **The seven compositions' exact censuses** (`it4+206p`, `it4+0p`, `it4+206pm`, `it4+0pm`,
  `it4+quad`; edge counts, cross-chord counts, k=4 UNSAT timings) are object-specific measurements,
  already summarized in row 46's tools clause.
- **P9's "chord endpoints carry the centre's colour far above chance"** and the kill-table statistics
  on the 883-core (§R0–R2 Phase 2) are measurements of one object's colouring statistics, with the
  plan's own honesty note that P9 "missed as registered... met in direction" — a scored prediction,
  not a theorem.
- **The efficiency findings of §12′/§R4** (sequential drop acceptance, the chunk-repair lever, the
  culler's 10.7× wall-clock factor) are engineering measurements about the cull driver's performance,
  out of this project's mathematical scope.

## Conjectures surfaced, not claimed

None found with a stated but unclosed proof; every claim checked above closes on its own terms.

## Prior art re-attributed

None — both filed theorems are object-specific computations with no external theorem to attribute
to.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M52-T1 | declined — exact PSLQ/Fraction verification, tools-side only; `Copy.lean` never names a field |
| M52-T2 | declined — tool-side soundness architecture, same genre as M50-T1, never formalized |
