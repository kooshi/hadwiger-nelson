*FS-114 round 4: the owner's comparison of round 3 (protocol rule 14) and the meeting point. **Identical for every side.** Written by the product owner,
2026-09-28, 09:05 UTC. It adds to `ROUND2-card.md` and `ROUND3-card.md`, which still hold. Statements are summarised from the records named, at their
grades.*

## Round 3: both sides reached `√3`, blind to each other

- **A Reuleaux bowtie** is two width-1 Reuleaux triangles meeting corner to corner at a degree-4 vertex `p`, with **all four edges at `p` tactic**: unit
  arcs about `q_i = e(±30°), e(180° ± 30°)`. This is reading R-T, the owner's ruling.
- **It exists as a fragment.** FS114-Y2-BOWTIE holds the closed disc of radius `3√3/5 ≈ 1.039` about `p`, rebuilt independently by FS114-YB2 (two minds,
  exact). Most of the design is forced: at `q1` the only order is `t1, V (3), T1 (4), Z (6), X (5)`.
- **The construction side's stop** (FS114-Y3-RSTOP, two minds with YB2): the bowtie does not extend to radius `√3`.
  - No valid fragment agreeing with it near `q1`, `q2` contains a neighbourhood of `r = (√3, 0)`, the fourth corner of the unit rhombus `p, q1, r, q2`.
  - The stop is the cone `(−60°, 60°)` at `r`, and Siamese pairs change nothing.
  - FS114-Y3-R, one mind, says any bowtie reaching `r` needs escape **E1** or **E2**:
    - **E1**: `T2`'s sector at `q2` lies inside `[240°, 300°]`.
    - **E2**: a tile at `q1` whose sector starts after 60°, and whose colour has no tile at `q2` pointing toward `r`.
  - Y2's symmetry class has neither escape (Y3-D2, two minds under R-T). The class with `x ↦ −x` acting as `(1 3)` is empty (YB2-EMPTY13, one mind).
- **The proof side's exclusion** (FS114-N4, one mind; a blind check, FS114-NB4, is running): **N4-BOWTIE**. No valid fragment (non-Siamese, simple) on the
  closed disc of radius `√3` about `p` holds a Reuleaux bowtie whose lune rings are free of `Γ`: N4-D for the degenerate lune, N4-G for the general one.
  - N4-FIVE: five colours at a corner iff the lune's ring is degenerate, otherwise four.
  - N4-OWN, N4-LENS, N4-OPP: local tools, listed on the proof side's record.
- **FS112-L60 is corrected** (FS114-L60): a unit arc with constant sides has angular length at most 60°, not below; at 60° both side tiles lie in the lens
  of its ends. **The chain N2-RED → COR3 → N3-BASE → DENSE3 → CV-EXISTS is intact** (one mind). So the reduction stands: **the unit-arc NO is C114-LOCAL-F**,
  a local exclusion about one four-colour vertex (two minds).

## What K1 still needs (K1: a degree-4 vertex of a non-Siamese valid map has at most two tactic edges)

- **K1-ΓRING**: the Reuleaux bowtie with a lune ring carrying arcs of `ω(p)`. The proof side registered p 0.6 that N4's three moves exclude it at
  `R ≤ 2`.
- **Asymmetric bowties through E1 or E2**, and Y2's x-action with `y ↦ −y` acting as `(2 4)`, where E2 survives.
- **Non-Reuleaux lenses** at four tactic edges.
- **K1-PIN**: the pinwheel (each tile inner for one edge), the `(2, 1, 1, 0)` patterns, and three tactic edges in general. None walked yet.

If K1 holds at a uniform radius, route T's torus NO needs K2 (the extreme's shape) and GAP-μ; the whole NO is C114-LOCAL-F.
