*FS-114 round 3: the owner's comparison of round 2 (protocol rule 14; no advisor ran) and the meeting point. **Identical for every side.** Written by
the product owner, 2026-09-28, 07:00 UTC. It adds to `data/fs114/briefs/ROUND2-card.md`, which still holds. Statements are quoted or summarised from the
records named, at their grades.*

## Held since round 2's card

- **CV-EXISTS, two minds, blind to each other** (FS114-CV, FS114-CVB): every valid map has a vertex of at least four colours. So **C114-LOCAL-F alone is
  the unit-arc NO, Siamese or not**: no valid fragment holds a disc of some radius `R` about a vertex of at least four colours. FS114-Y-DIAL puts `R`
  above `φ²/√2 ≈ 1.8512`.
- FS112-C-COMPOSE, C-PARTNERS and C-DOUBLE: two minds. C-ENDS: TRUE with an empty residue, two minds.
- **C114-THOM-TOP, settled 2–1**: `M − x` stays connected at a pinch point and breaks at a hole. Thomassen's steps other than the rainbow step hold for every
  valid map, Siamese pairs allowed.

## Round 2: the two sides met at K1, blind to each other

- **The proof side (FS114-N3, one mind)**: K1 is a GAP, not derivable at radius `1 + ε`. It derived the escape **DR**: two width-1 Reuleaux triangles
  meeting at a degree-4 vertex `p`, one pointed each way, all four edges at `p` tactic (charge −2).
  - **N3-DR0** (exact at named values): DR's degenerate member, with a ring change point 60° from a Reuleaux corner, does not exist.
  - **N3-DR1/DR2**: the lune's `p`-tile and a corner partner reach a ring change point.
  - **N3-CONT**: every tactic-edge end at `p` and every Reuleaux corner carries a non-tactic edge.
  - **N3-JOINT**: route T's kill restated as a fractional assignment, `N + U + 3V₆ = V₄`. **N3-PAY**: DR is paid by its four continuation ends.
  - K2-loc is moot. GAP-μ stands. SIAM-KILL is subsumed by C114-LOCAL-F.
- **The construction side (FS114-Y2, one mind, exact)**, without seeing DR: **FS114-Y2-BOWTIE**.
  - A non-Siamese valid fragment by formula, 20 tiles over ℚ(√3), D2-symmetric, holds the closed disc of radius `3√3/5 ≈ 1.039` about a degree-4 vertex
    `p` of colours 1–4 whose four edges are tactic.
  - Two width-1 Reuleaux triangles `t1 = (p, e(30°), e(−30°))` and its mirror `t3` meet corner to corner at `p`. Each edge is a unit arc about
    `q_i = e(±30°), e(180° ± 30°)`, and each `q_i` has five colours.
  - It is accepted by FS114-YB's checker, unedited, which also accepts the five controls. Tool: `tools/fs114_y2_k1.py`, output
    `data/fs114/fs114-y2/k1.out`.
- **FS114-Y2-GAPS** (hand, one mind), about every valid map:
  - At a tactic centre `q`, the inner tile and the outer-colour tile fill cones of width at most `180° − β` each, so two more cones of width at least
    `β` hold other tiles.
  - In a non-Siamese map, every tile meeting the open unit disc about a vertex `p` is a tile at `p` or has a colour absent at `p`.

## The meeting point now

**Does the bowtie extend to radius 2 about `p`, or where does it stop?**
- In Y2's design each `q_i` has five colours and its ring lies within radius 2 of `p`.
- By FS112-SIX (two minds, one blind), a five-colour vertex whose ring lies inside a valid map carries unit arcs about it totalling at least 180°. The
  fragment carries about 66.9° about `q1`.
- So an extension must add about 113° of unit arcs about each `q_i`; then A4SIX applies at `top` and `bot`, the four-colour vertices at distance 1
  from `p`.
- **An extension to radius 2 refutes K1 at its reported radius.** Then route T's kill must be the joint payment (N3-JOINT, N3-PAY).
- **A stop at a named radius is a local exclusion about a four-colour vertex**: a first piece of C114-LOCAL-F, for this configuration.
- Y2 did not derive that the five colours at `q_i` are forced in every map with a Reuleaux bowtie at `p`: its argument covers the design's arrangement
  only.
