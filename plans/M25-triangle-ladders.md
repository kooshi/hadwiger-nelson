# M25 — The 3-pivot + metapivot ladder system, unconditionally (PRE-SUBPLAN STUB)

*Recorded 2026-08-08 (post-M23 roadmap discussion). Numbers tentative; order
shiftable; nothing here is spent until a subplan registers it.*

## Scope

The **four-ladder object**: natural ladders of the pivots 0, 1, ζ₆ AND of the
metapivot m = (1+ζ₆)/3 (the metapivot gets its own ladder — Kooshi,
2026-08-08), closed under ALL unit chords among their points. Deliverables:

1. Complete chord lists: the three unit-axis cross-webs (M24 theorems apply
   verbatim — anchor-independence) + the three axis-1/√3 pivot–metapivot webs
   (norm forms from M24's derivation batch) + intra families (backbone).
   Sporadic counts PROVEN, not computed.
2. The colouring theorem: χ(four-ladder object) decided exactly. This is the
   sharpest form of M23's broadcast-cycle question — the first place the
   triangle's cyclic structure meets a complete chord list.
3. The overlap-aware pattern census (the M23 §0.2.1 protocol discovery made
   into the registered instrument): pattern triples consistent on the shared
   ten-point structure; registered BEFORE building.

## Ask

* Decision at subplan: if tools-side triage finds χ = 5 forced, the milestone
  pivots to certifying THAT (a 5-forcing countable structured object would mean
  the family can exceed 4 — the recursion/tiling thread comes alive toward 6);
  if χ = 4, the constructive pattern + splice machinery from M24 carries.
* Compute: SAT battery on the 4-ladder object at depth; desktop-scale.

## Evidence in hand

`Triangle.lean` (self-gluing, ten-point theorem, metapivot couplings, chord
classifications, seam hexagon); census A (34-point inventory, field closure);
the M23 loop census (seam relations need all three pivots); the matched-pair
period-1 pattern (`build/m23-ladderpair-pattern.json`); M23 §0.2.1 finding
(unit triangles never "far" — cover sets interlock through the shared glue
points, so the pattern machinery must be overlap-aware from the start).
