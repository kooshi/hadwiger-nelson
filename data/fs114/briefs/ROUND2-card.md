*FS-114 round 2: the owner's comparison of round 1 (protocol rule 14; no advisor ran) and the meeting point. **Identical for both sides.** Written by
the product owner, 2026-09-28, 05:40 UTC. Every statement below is quoted or summarised from a record named beside it, at the grade the record gives.
"Two minds" means a blind verifier agreed.*

## What round 1 holds

**About counting** (proof side FS114-N and FS114-N2, blind verifier FS114-NB):
- **N114-RD, the rainbow deficit** (two minds, one blind; NB: it reads radius `1 + 1/√3` about the tile's centre). In a valid map every repeat at a tile
  `x` is (S) a close pair; or (A) a unit arc of `∂x`, shared with one member and centred at a point `q ∈ F ∪ R` where the other member touches `x` at `q`
  alone; or (B) two members touching `x` only at vertices `p, q ∈ F ∪ R` with `|p − q| = 1 = diam x`.
- **N114-EULER** (two minds; `μ` must count a face meeting itself). On a cellular torus map:
  `Σ_f (deg_M(f) − (k − 1)) = (7 − k)F + Σ_v (d − 2)(d − 3) − μ`.
- **The five-colour control closes** (two minds: NB's NB-ABSENT, re-derived by N2). A colour repeats around a tile through vertex contacts only if it is
  absent from the tile's edge-neighbours, and at most three tiles carry it. **N2-FIVE-PLANE** (one mind): no simple non-Siamese valid five-colour map of
  the plane exists, at any complexity.
- **The six-colour count, exact** (N2-SLACK and NB-ARCS; one mind each, agreeing), on non-Siamese cellular torus maps with `μ = 0`:
  - The number of tactic unit-arc edges is `A = E′ − V₄ + 3V₆ + U`, where `U ≥ 0` is unused absent-colour capacity.
  - **N2-ENDS**: with `n(p)` the number of non-tactic edges at a vertex `p`, the charges `n` (degree 3), `n − 2` (degree 4), `n` (degree 5) and
    `n + 6` (degree 6), plus `2U`, sum to zero.
  - The charge is negative at exactly one vertex type: **a degree-4 vertex with three or four tactic edges.**
  - Each tactic edge at `p` names a four-colour vertex at distance exactly 1 from `p`, sharing a tile with it.
- **N2-VCAP** (one mind): no per-vertex supply bound can be the kill, because the strip's midline vertices attain the cap `d(d − 3)` at degree 4.
  **N2-DIAM** (one mind): a tile's inner tactic arcs total at most 180°.
- **N2-KILL** (one mind): a torus NO for non-Siamese maps with `μ = 0` follows from two statements, K1 and K2.
  - **K1**: a degree-4 vertex of a non-Siamese valid map has at most two tactic edges.
  - **K2**: no such map realises the zero-charge extreme.
  - **The extreme's shape** (derived): its non-tactic edges form disjoint closed curves through the four-colour vertices. Every other edge is a unit arc
    centred at a four-colour vertex 1 from both its ends. Every tile with an absent colour lies in a Reuleaux triangle of width 1, whose corners have
    degree at least 5.
- **N2-GSD** (one mind): GS-D is a GAP at four named steps:
  1. **K1** (local, radius 2);
  2. **K2-loc**: the extreme excluded at a uniform radius;
  3. **GAP-μ**: pockets and holes, which the count does not charge;
  4. **the Siamese class**, which the count cannot see (N2-SIAM) and where no density bound holds (N2-REFINE).
  With steps 1–3 closed, route T gives the NO for every non-Siamese valid map at every complexity. It never gives the Siamese half.
- C114-THOM-TOP: the two minds disagree on "`M − x` connected" at pinch points. N says GAP; NB says TRUE, since the pocket tile and an outside tile both
  touch the pinch vertex. A third mind is owed. Both agree that Thomassen's route fails on valid maps only at the rainbow step.

**About objects** (construction side FS114-Y, blind verifier FS114-YB; rebuilds identical tile for tile):
- **FS114-Y-DIAL** (two minds, one blind, exact): the strip with each top tile capped by the unit arc about its own valley. It is a valid fragment holding
  the closed disc about a midline four-colour vertex for every `R < φ²/√2 ≈ 1.8512`, and no extension of the strip does better.
- **FS114-Y-PENT, -STRIPK6, -STRIPRIGID, -DISKRIGID** (two minds, one blind): neither printed geometry, the strip or the disk, is part of any valid map
  under any colouring.
- **FS114-Y-PAIRSHARE and FS114-Y-K6** (two minds, one blind), about every valid map:
  - Any two close complementary cubic trichromatic partners of a cubic trichromatic vertex share a unit point with it.
  - Two cubic vertices closer than 2 whose six tiles pairwise straddle distance 1 must have every common unit point as a leaving centre of both.
- **C114-RAINBOW's third case** (YB, one mind, exact): both faces touch `x` only in finite sets, every cross distance 1. It is realised on a valid
  fragment of radius 3/5.
- **C114-DUAL-COUNT, settled in substance by four readings**: the quads emit `2n + 2p₅ + 6p₆` distinct unit arcs (at least 80 % of the edges), exactly
  `2n` when no vertex has degree 5 or 6.

## The meeting point

**A degree-4 four-colour vertex with three or four tactic edges, in a non-Siamese valid map.**
- K1 says none exists, and it reads radius 2.
- A valid fragment by formula carrying one refutes K1. It would also be the one vertex type that pays for the rest of any six-colour torus map's charge,
  so a YES needs such vertices at a density that N2-ENDS fixes.
- Behind it is K2's extreme, a shape a YES would have to take if K1 holds.
- **And the Siamese class**, where no count reaches and a YES might live.
