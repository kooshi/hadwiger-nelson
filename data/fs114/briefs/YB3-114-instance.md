*Instance file for job **FS114-YB3**, the blind verifier of FS-114's construction side, round 4 (FS114-Y4). The brief is the template
`data/fs114/briefs/YB114-verify-construction.md`, with the changes below. Written by the product owner, 2026-09-28. **Each statement is copied
verbatim from `plans/FS114-Y4-construction.md`'s theorem table by a script**; grades and proofs withheld.*

## Changes to the template

- **Your record** is `plans/FS114-YB3-verification.md`. Working files go in `data/fs114/fs114-yb3/`, tools in `tools/fs114_yb3_*.py`, the report in
  `data/fs114/reports/FS114-YB3.md`. Subjects are "FS114-YB3: stage n". Final text: "FS114-YB3 idle; report sent to the owner by SendMessage".
- **Reading adds** the round cards `data/fs114/briefs/ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md`; `plans/FS114-Y2-construction.md`,
  `plans/FS114-Y3-construction.md` and `plans/FS114-YB2-verification.md` with their tools (the bowtie, RSTOP, D2, YB2-EMPTY13: open to you); FS112-U1,
  FS112-N3-COR3 (`plans/FS112-derivation.md`); `plans/FS114-L60-audit.md` (FS112-L60 is "at most 60°"). The proof side's vocabulary, from its records
  (`plans/FS114-N3-proof.md` header and §2.2; `plans/FS114-N-proof.md` N2-3): the **ring** at `p` is `ω(p)`; a **change point** is a point of `Γ ∩ ω(p)` where the ring's colour off `Γ` differs on its two sides; a **lune** is the
  region at `p` in the cone between the two Reuleaux triangles, bounded by their facing arcs, and its ring is the arc of `ω(p)` in that cone; **simple**:
  "every tile an open disc whose closure meets each other tile's closure in a connected set or not at all, and does not meet itself"; a lune ring is
  **Γ-free** when it carries no boundary arc along `ω(p)`, only isolated change points.
- **Fences, until your stage 1 is committed:** `plans/FS114-Y4-construction.md`, `data/fs114/fs114-y4/`, `tools/fs114_y4_*`. **Always:** every proof-side
  record, directory and tool (`plans/FS114-N*-proof.md`, `data/fs114/fs114-n*/`, `tools/fs114_n*`) and the proof verifiers' (`plans/FS114-NB*`,
  `data/fs114/fs114-nb*/`) — the proof side reached `√3` for part of this family by another route, and your derivation must stay independent of it;
  `plans/FS114-close-inventory.md`; FS-111's files; the template's other fences.

## The statements

A **Reuleaux bowtie** (reading R-T) is two width-1 Reuleaux triangles `t1 = Reul(p, q1, q2)` and its opposite `t3` meeting corner to corner at a degree-4
vertex `p`, all four edges at `p` tactic; `r = q1 + q2`; `top`, `bot` as in the round cards.

1. **FS114-Y4-LUNE** — In a non-Siamese simple valid map with a Reuleaux bowtie at `p`, the two side tiles of each lune differ in colour: `c(X1) ≠ c(X4)`, `c(X2) ≠ c(X3)`; with SIDES the pattern is diagonal (`c(X1) = c(X3)`, `c(X2) = c(X4)`). Proof: a same-colour lune puts two frontier arcs, from the points where `t2` meets `X1` on `S1` and `X4` on `S4`, inside `cl t2` at mutual distance exactly 1 — infinitely many points on two circles
2. **FS114-Y4-DIAG** — In a diagonal bowtie containing neighbourhoods of `top` and `bot`: `top` carries `X1`, `N` (4), `X4`; each `q_i` has exactly five colours with the sliver forced and `X1` starting at exactly `60°`; so the ring of `q1` above `r` forces E1 (`T2 ⊂ [240°, 300°]`), and then `bot`'s sector `(240°, 300°)` has no colour: **no neighbourhood of `r`**
3. **FS114-Y4-RSTOPALL** — **No non-Siamese simple valid fragment holding a Reuleaux bowtie at `p` contains neighbourhoods of the closed unit disc about `p` and of `r`**: RSTOP extends to every Reuleaux bowtie, symmetric or not, Γ-free or ΓRING; none holds a closed disc of radius `√3` about `p`. E1, E2 and E0 are all excluded
4. **FS114-Y4-SIDES** — Let `t1 = Reul(p, q1, q2)` be a tile of a valid map; the tile `X1` along its side `p q1` at `q1` and the tile `X2` along its side `p q2` at `q2` (both outside `t1`) are distinct and of **different colours**, Siamese pairs allowed: the side points `q2 + e(90° + ε)`, `q1 + e(270° − ε)` are `2cos ε − 1 < 1` apart, and the two tiles have points more than 1 apart. In a non-Siamese Reuleaux bowtie `{c(X1), c(X2)} = {5, 6}`
5. **FS114-Y4-UPDOWN** — If `|u − v| = 1`, a tile at `u` with a direction `ψ` at `u` with `cos(ψ − arg(v − u)) > 0` has points within `< 1` of `v`, hence of every tile at `v`: in a non-Siamese map its colour is absent at `v` unless it is that tile
6. **FS114-Y4-W** — In a non-Siamese simple Reuleaux bowtie the tile along `t1`'s outer side at `q1` and the one at `q2` are **one tile `W`, of colour 3** (the colour of `t3`); `W ⊂ B̄(q1, 1) ∩ B̄(q2, 1)`, so its sector is inside `[300°, 360°]` at `q1` and `[0°, 60°]` at `q2`, pointing toward `r` at both. Likewise `t3`'s outer tile is one tile of colour 1
7. **FS114-Y4-D2ALL** — **Every `y ↦ −y`-symmetric Reuleaux bowtie acts on colours 5, 6 by the swap** (SIDES), so the class of my brief — Y2's `x`-action with `y ↦ −y` acting as `(2 4)` — **is empty**, with no neighbourhood of `top` needed; with YB2-EMPTY13 (`x ↦ −x` fixing 5, 6: empty) and FS114-Y3-D2 (both swaps: stops before `r`), **no `D2`-symmetric Reuleaux bowtie containing `top` contains a neighbourhood of `r`**
8. **FS114-Y4-E2X** — In the class with `x ↦ −x` acting as `(1 3)(5 6)` (no `y`-symmetry assumed; FS114-Y3-D2 steps 1–4 hold), **E2 is impossible**: `λ > 60°` makes the sliver between `T1` and `L` colour 3 (colour 6 would straddle `σ_x(L) ∋ top`), and then `W` has colour 6 = `c(X2)` and cannot reach `q2`, contradicting FS114-Y4-W

**Priority:** 1–3 (the Y4 record names LUNE item 1 and DIAG steps 1, 4 and 5 as its audit targets; RSTOPALL flatters the NO, so audit it at the rate
of a result you would want false), then 4–8. Build any object the statements need by formula and check it exactly with a calibrated checker.
