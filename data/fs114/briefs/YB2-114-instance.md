*Instance file for job **FS114-YB2**, the blind verifier of FS-114's construction side, rounds 2 and 3. The brief is the template
`data/fs114/briefs/YB114-verify-construction.md`, with the changes below. Written by the product owner, 2026-09-28, 07:40 UTC. The objects and statements
are FS114-Y2's and FS114-Y3's, quoted from their records with the construction rule each object needs; grades and proofs withheld.*

## Changes to the template

- **Your record** is `plans/FS114-YB2-verification.md`. Working files go in `data/fs114/fs114-yb2/`, tools in `tools/fs114_yb2_*.py`, the report in
  `data/fs114/reports/FS114-YB2.md`. Subjects are "FS114-YB2: stage n". Final text: "FS114-YB2 idle; report sent to the owner by SendMessage".
- **Reading adds** `data/fs114/briefs/ROUND2-card.md` (the proof side's results are on it; you may read it), FS112-U1, FS112-SIX and FS112-A4SIX
  (statements and grades in `plans/FS112-derivation.md`), and `plans/FS114-YB-verification.md` with its checker `tools/fs114_yb_exact.py` (you may run it
  unedited beside your own).
- **Fences, until your stage 1 is committed:** `plans/FS114-Y2-construction.md`, `plans/FS114-Y3-construction.md`, `data/fs114/fs114-y2/`,
  `data/fs114/fs114-y3/`, `tools/fs114_y2_*`, `tools/fs114_y3_*`, and `data/fs114/briefs/ROUND3-card.md` (it retells Y2's object). **Always:** the proof
  side's records and tools (`plans/FS114-N*-proof.md`, `data/fs114/fs114-n*/`, `tools/fs114_n*`) and the template's other fences; FS-111's files.

## Object 1 — the Reuleaux bowtie (rebuild it from this rule)

**FS114-Y2-BOWTIE.** A non-Siamese valid fragment, twenty tiles over ℚ(√3), D2-symmetric, holds the closed disc of radius `3√3/5 ≈ 1.0392` about a
degree-4 vertex `p` of colours 1–4. Two width-1 Reuleaux triangles `t1 = (p, e(30°), e(−30°))` and its mirror `t3` meet corner to corner at `p`, with `t2`
above and `t4` below. **All four edges at `p` are tactic**: unit arcs about `q_i = e(±30°), e(180° ± 30°)`, each `q_i` a vertex of five colours with a tile
`T_i` of the outer tile's colour meeting the inner tile at `q_i` alone. The symmetry acts on colours as: `x ↦ −x` as `(1 3)(5 6)`, `y ↦ −y` as `(2 4)(5 6)`.
**Design and build your own fragment meeting these conditions**, or derive that none exists; check it exactly, with the ACCEPT audited as the suspect
verdict.

## Statements

2. **FS114-Y3-RSTOP**: no valid fragment (Siamese pairs allowed) that agrees with the bowtie near `q1` and `q2` contains a neighbourhood of
   `r = q1 + e(330°) = (√3, 0)`; so the bowtie extends to no closed disc of radius `√3` or more about `p`.
3. **FS114-Y3-R**: in every valid map with a Reuleaux bowtie at `p` that contains a neighbourhood of `r`, the ring of `q1` just above `r` carries, on it or
   just outside it, a colour `c` with two properties:
   - (i) `c` is absent at `q1`, or its `q1`-tile lies in the open cone `(60°, 240°)` at `q1`;
   - (ii) `c` has no tile at `q2` with a direction within 90° of `30°`.
   With five colours at `q1` this is **E1** (`T2`'s sector at `q2` inside `[240°, 300°]`) or **E2** (a tile at `q1` whose sector starts after `60°`, its
   colour pointing nowhere near `r` from `q2`).
4. **FS114-Y3-D2**: in a non-Siamese valid fragment with a Reuleaux bowtie at `p` that contains a neighbourhood of `top` and is invariant under Y2's
   action, each `q_i` has exactly five colours in Y2's arrangement, and no such fragment contains a neighbourhood of `r`. So none holds the closed disc of
   radius `√3` about `p`.
5. **FS114-Y3-FOUR**: in every non-Siamese valid map with a Reuleaux bowtie at `p` containing a neighbourhood of `top`, in which `q1` and `q4` each have
   exactly four colours:
   - `P_cl(q1) = {1, 3, 4, b}` with `b ∈ {5, 6}`;
   - the tile at `top` in the sector `(0°, 60°)` has the other colour `b̄`, which is absent at `q1`.
   So five colours at `q_i` are not forced by the bowtie.
6. **FS114-Y3-13**: in the class where `x ↦ −x` acts as `(1 3)` (5 and 6 fixed), every non-Siamese bowtie fragment containing `top` has exactly four
   colours at each `q_i`, and FS114-Y3-R does not stop the class at `r`. **Whether the class holds any valid fragment is the construction side's open
   step.** Build one, or derive that none exists: the step is filling the region between `t1` and `t3` inside `B(p, 1)`.
7. **FS114-Y2-GAPS**: at the centre `q` of a tactic edge from `p` whose arc subtends `β` at `q`, the inner tile and the outer-colour tile fill cones of width
   at most `180° − β` each, so `q` carries further tiles in two cones of width at least `β`, one inside `B(p, 1)`. And in a non-Siamese map, every tile
   meeting the open unit disc about a vertex `p` is a tile at `p` or has a colour absent at `p`.

**Priority:** 1, 2, 4, then 3, 5, 7, then 6 if context remains. 2 and 4 are the results read into K1's route: audit them at the rate of a result you
would want false.
