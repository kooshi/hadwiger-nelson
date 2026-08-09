# M24 — Chord completeness and the unconditional matched-pair theorem (PRE-SUBPLAN STUB)

*Recorded 2026-08-08 from the post-M23 discussion with Kooshi (roadmap agreed
there; scope confirmations his). Subplanning starts on his go.*

## The object distinction (crisp, so we prove the right theorems)

"Total colourability of the two-pivot system" in this programme means the
**matched ladder pair**: the two pivots' natural ladders (countable), closed
under ALL unit chords between their points — with the chord list made EXACT by
completeness theorems, not by a census window. It does NOT mean the uncountable
`Coupled.pairSystem` (all points of all four circles): that object's χ is the
M21 fork, still parked. Same convention for M25/M26: the ladder objects of
their configurations, with complete chord lists.

## Roadmap (agreed 2026-08-08)

* **M24**: the two-pivot matched ladder pair, unconditionally — completeness
  theorems for every chord family + the colouring theorem (χ = 4 exactly).
* **M25**: the same for the 3-pivot + metapivot system — four ladders (the
  metapivot's included), all cross-webs, proven sporadic counts, colouring.
* **M26**: the same for the 6+1 hexagram system (second triangle = the mirror
  centroids, promoted; adds the 2/√3 axis with the triple tangency at m).
* Stubs with full scope/ask/evidence: `plans/M25-triangle-ladders.md`,
  `M26-hexagram.md`, `M27-tiled-plane.md`, `M28-recursion.md`,
  `M29-uncountable-pair.md` (numbers tentative; order shiftable — recorded so
  the context survives any session).
* **Horizon after M26, if χ is still 4 (Kooshi, recorded verbatim in intent)**:
  (a) colourability of the INFINITE PLANE tiled with the hexagonal
  construction, including all sporadic chords between all possible points;
  (b) colourability of the construction RECURSED — possibly infinitely.
  Either outcome is decisive for this thread: 4-colourability of the full
  tiled/recursed family is a major structural negative (this family cannot
  force a 5th colour); a forced 5 anywhere is the finding.

## M24 scope

1. **The derivation batch — ALL axes, not just unit** (Kooshi: the M24 formulas
   serve M25/M26; derive the metapivot's chords now). Chord-classification
   identities and their lattice norm forms for:
   - unit axis (done at M23: oo rigid; ii Möbius → `(√3u−1)(√3v−1) = −2`;
     oi/io → `√3(x−1)(x−v²) = v(3x²−4x+3)`);
   - **axis 1/√3** (pivot–metapivot and hexagram-neighbour pairs): the four
     radius combinations' chord conditions + norm forms — the metapivot's own
     ladder (its two circles under its own hex/seam operators) and its
     cross-webs derived alongside;
   - (M26 consumes: axis 2/√3 including the tangent ii case — derive if cheap,
     else M26.)
2. **Completeness theorems** (the count of sporadics PROVEN, not computed):
   - intra-ladder families: reduce to the zpow backbone + Re-pinning
     (kernel-cheap; write first);
   - outer–outer: already a theorem (`unit_chord_outer_outer`);
   - inner–inner: the norm-form equation over ⟨ζ₆, σ⟩ — valuation argument in
     K = ℚ(i, √3, √11) where √3σ = (1+i√11)/2 =: π, an algebraic integer with
     π·π̄ = 3 (prime above 3 in ℚ(√−11)); compare π-adic valuations of
     ζ₆^aπ^b − √3^{b−1} against v(−2·√3^{b+d−2}) to bound b, then finite check.
     Tools-first (pari/sympy valuation experiment), then Lean;
   - mixed oi/io: the 3-term identity — probe tools-first before scoping; this
     is the hard half and the milestone's main risk.
3. **The colouring theorem**: the period-1 pattern + defect splice
   (`build/m23-ladderpair-pattern.json`) as literal tables, properness per
   family, assembled into χ(matched pair) = 4 with NO conditional clause.
4. Instruments: the deep-census script (`build/m24-deepcensus.py`, exact
   verdicts, O(B²) — fix the candidate net if reused) as the §0 control bed;
   planted-sporadic controls standing.

## Assets in hand

M23's `Triangle.lean` (chord classifications, backbone, gluing layer);
`Glue.lean` (axis-general gluing + tangency case, unconsumed); census clean to
|b| ≤ 30 exact (twelve sporadics, everything else fused-endpoint); the M22/M23
standing constraints (predictions registered before instruments; builds via
scripts/build.sh; segfault ⇒ halt; one heavy job).
