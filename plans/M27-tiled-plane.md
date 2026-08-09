# M27 — The plane tiled with the hexagonal construction (HORIZON STUB)

*Recorded 2026-08-08 (Kooshi, verbatim intent: "colorability of the infinite
plane tiled with this hexagonal construction, including all sporadic chords
between all possible points"). Gated on M24–M26 landing with χ still 4.*

## Scope

The construction iterated over the whole plane: the unit triangular lattice's
vertices + all triangle centroids as pivots (the hexagram's tiling closure),
each carrying its two circles and its ladder; the colouring of the FULL
countable object with ALL chords between all ladder points classified.

## The finiteness observation that makes this well-posed (2026-08-08)

A unit chord between two systems' points requires the axis length d ≤ 3
(points lie within distance 1 of their centres... within d ± 2; a unit chord
needs d − 2 ≤ 1). So the cross-web derivation batch runs over the FINITELY
many lattice axis classes of length ≤ 3 (lattice vectors + centroid offsets,
up to the tiling's symmetry group) — the tiled plane's chord problem is
finite-axis-class, and each class is one M24-style norm-form theorem.

## Ask

* The finite axis-class enumeration (exact, cheap) + one norm form per class.
* The colouring candidate: lattice-periodic (torus/fundamental-domain SAT, the
  Strip.lean method scaled up); if a periodic 4-colouring exists, the theorem
  assembles as pattern + per-class properness + completeness.
* The stakes, stated at registration: 4-colourable ⟹ major structural
  negative (this entire density family cannot force a 5th colour — the hunt
  redirects); 5 forced anywhere ⟹ the family is alive toward 6.

## Evidence in hand

M24–M26's per-axis machinery (by construction); the hexagram self-similarity;
field closure (all pivots/centroids in rational combinations over the seam
field — no growth under tiling).
