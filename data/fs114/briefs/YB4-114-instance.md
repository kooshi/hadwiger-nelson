*Instance file for job **FS114-YB4**, the blind verifier of FS-114's construction side, round 5 (FS114-Y5). The brief is the template
`data/fs114/briefs/YB114-verify-construction.md`, with the changes below. Written by the product owner, 2026-09-28. **Each statement is copied
verbatim from `plans/FS114-Y5-construction.md`'s theorem table by a script**; grades and proofs withheld.*

## Changes to the template

- **Your record** is `plans/FS114-YB4-verification.md`. Working files go in `data/fs114/fs114-yb4/`, tools in `tools/fs114_yb4_*.py`, the report in
  `data/fs114/reports/FS114-YB4.md`. Subjects are "FS114-YB4: stage n", neutral. Final text: "FS114-YB4 idle; report sent to the owner by SendMessage".
- **Reading adds** the round cards `data/fs114/briefs/ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md`; `plans/FS114-Y4-construction.md`,
  `plans/FS114-YB3-verification.md` and `plans/FS114-YB2-verification.md` with their tools (SIDES, UPDOWN, W, YB2-DE: open to you); FS112-U1,
  FS112-N3-COR3 (`plans/FS112-derivation.md`); `plans/FS114-L60-audit.md` (FS112-L60 is "at most 60°"). Vocabulary: a **tactic edge** at `p` is a
  whole unit arc on `ω(q)`, `|p − q| = 1`, with inner tile `x` (`q ∈ cl x`) and a tile of the outer tile's colour touching `x` at `q` alone; the
  **pinwheel** is a degree-4 vertex `p` with four tactic edges, each tile at `p` inner for one edge, blade `t_j`, centres `q_j`, cones `α_j`; the **ring**
  is `ω(p)`; **simple**: "every tile an open disc whose closure meets each other tile's closure in a connected set or not at all, and does not meet
  itself"; **non-Siamese**: every two tiles of one colour are far (their closures at distance at least 1).
- **Fences, until your stage 1 is committed:** `plans/FS114-Y5-construction.md`, `data/fs114/fs114-y5/`, `tools/fs114_y5_*`. **Always:** every proof-side
  record, directory and tool (`plans/FS114-N*-proof.md`, `data/fs114/fs114-n*/`, `tools/fs114_n*`) and the proof verifiers' (`plans/FS114-NB*`,
  `data/fs114/fs114-nb*/`) — the proof side excluded part of the pinwheel by another route, and your derivation must stay independent of it;
  `plans/FS114-close-inventory.md`; FS-111's files; the template's other fences.

## The statements

1. **FS114-Y5-RAINBOW** — in a non-Siamese valid map two distinct tiles of one colour cannot both share a boundary arc of positive length with one tile (C114-EDGE-RAINBOW's non-Siamese form: each tile's edge-neighbours carry distinct colours)
2. **FS114-Y5-REGION** — in a non-Siamese pinwheel `t_{j+1} ⊂ B̄(p, 1) ∩ B̄(q_j, 1) ∖ B(q_{j+1}, 1)` (N5-PIN0's region, re-derived)
3. **FS114-Y5-MU** — for a blade `t_{j+1}` whose clockwise edge `j` is shorter than 60°: every 5/6 tile bordering its counter-clockwise side `M_j` (from `q_j` to `w_{j+1}`) is one tile `μ_j`, and every 5/6 tile bordering the inside part of its clockwise side `L_j` is one tile of the other colour; so `w_{j+1} ∈ cl μ_j`
4. **FS114-Y5-ALT** — consecutive pocket colours differ, `m_j ≠ m_{j+1}`, unless `t_{j+2}`'s side `M_{j+1}` is a unit arc centred at `w_{j+1}` (exception E2)
5. **FS114-Y5-POCKET** — outside E2 the tile bordering `t_{j+1}`'s side `M_j` also borders the whole inside part of `t_{j+2}`'s side `L_{j+1}` (`μ_j = Λ_{j+1}`)
6. **FS114-Y5-CASE** — at each centre `q_k`, outside E1 and E2: either (B) `α_k = 60°` and `μ_{k−1} ∋ q_k`, or (A) `t_{k+1}` borders the ring clockwise from `q_k` for `λ_k ∈ [α_k − 60°, 60°]`, the outside tile there has colour `k − 1`, and `α_{k−1} + α_k ≤ 180°`; so every cone is at most `120°`
7. **FS114-Y5-REDUCE** — outside E1 and E2, every pinwheel at radius `1 + ε` has cones `(x, 180° − x, x, 180° − x)` with `60° < x < 120°` (the family `P_x`)
8. **FS114-Y5-PIN120-60** — no non-Siamese simple valid fragment containing a neighbourhood of `B̄(p, 1)` holds a pinwheel at `p` in which the tile across the outer edge of a 120° tile has a 60° cone — the alternating member `(120°, 60°, 120°, 60°)` included; radius `1 + ε`
9. **FS114-Y5-PX** — in `P_x` (outside E2): `λ_k = α_k − 60°`, `v_{k+1} = e(φ_k + 60°)`, each `q_k` is a degree-4 vertex with exactly the tiles `O_k` (colour `k − 1`), `T_k` (`k`), `μ_k` (`m_k`), `t_{k+1}`; `μ_k` crosses the ring at `q_k`; `T_k`'s sector lies in `[φ_k − 90° + β_k, φ_k + 30°]`; the pocket colours alternate
10. **FS114-Y5-PXKILL** — no non-Siamese simple valid fragment containing a neighbourhood of `B̄(p, 1)` holds a pinwheel of the family `P_x` (`60° < x < 120°`), outside E2: `T_k` and `O_{k+1}`, both of colour `k`, border the pocket tile `μ_k` along `ω(v_{k+1})` from `q_k` and along `ω(q_k)` from `v_{k+1}`, both outward, and come within `√(1 − 2tt′) < 1`
11. **FS114-Y5-PINALL** — **no non-Siamese simple valid fragment containing a neighbourhood of the closed unit disc about `p` holds a pinwheel at `p`**, except possibly under E1 (an edge at `p` of length exactly `60°`) or E2 (a blade's counter-clockwise side a unit arc centred at its clockwise edge end)
12. **FS114-Y5-PIN120** — K1-PIN120 is closed at radius `1 + ε`: no member exists unless E2 holds at the blade two past the 120° tile

**Priority:** the side's own weakest steps first — FS114-Y5-POCKET at `w_{j+1}`, FS114-Y5-CASE (A)'s colour `k − 1`, and the sector colours at
`v_{k+1}` in FS114-Y5-PXKILL — then MU, REDUCE, PIN120-60 and PINALL. PINALL flatters the NO: audit it at the rate of a result you would want false,
and say whether its two exceptions E1 and E2 are exactly the cases the chain misses.
