
## Stage 3 — SAVED (FS131-I8D): `crossed_changePoint`, `crossed_semiHub`, `semiHub_places` — the six leaves of `SemiHubPlaces` closed

Every leaf closed at first or second elaboration (the proofs were drafted in a copy of the module under `data/fs131/i8d/scratch/`
while a build held the module, then installed). The module went from 155 lines to 1,010: about 855 written against 1,430 priced.

### 3.1 `crossed_changePoint` (about 60 lines against 200)

Each germ of `ω(y)` at `p` lies in a colour class (`germ_dichotomy`; an arc would be `F.OnRingArc y p`, excluded by `hna`), whose
colour is absent at `y` (`not_mem_coloursAt_of_mem_sphere`), so `a` or `b` (`crossed_four`); its tile is the tile of `p` of that
colour, and approaches `p` along the germ's tangent — **a lemma the plan lists as a child and the library did not hold**:
`GermIn.tangent_mem_coneAt` (`θ + s.sign * (π / 2) ∈ coneAt S (ringPt p θ)`, class-free, over a chord identity
`e_add_sub_e_sub`). The crossed star puts `ψ + 270°` outside the cone of `t_a` and `ψ + 90°` outside the cone of `t_b`
(`add_notMem_angleIcc`, `sub_notMem_angleIcc`, wave 3; no C1). `p ∈ Γ`: four colours, so no interior point.

### 3.2 `crossed_semiHub` — the row's weakest clause closes in the kernel (about 150 lines against 300)

The step the blind second mind left open (`plans/FS116-V5-verification.md` ll. 650–660) is `crossed_not_germOnQ_inside`: no germ of
`ω(y)` running inside `B(p, 1)` from `r(ω)`, `ω` within `60°` of `ψ`, lies on a (Q) arc of the ring of `y`. The route is the plan's,
with two landed lemmas in place of two it priced as children: wave 4's `IsRingArc.disjoint_coneAt` (`Plane/ValidMap/Cor3`: the cones at
the centre of an arc's two side classes are disjoint) for `disjoint_angleIcc_antipodal`, and wave 3's `exists_mem_coneAt_region` (every
direction at a point of the domain is in the cone of some class) for `iUnion_coneAt_tileAt`. The side colours are not `a'`, `b'` (the
tile of `p` of that colour would hold `r(ω)`, by `mem_closure_tile_of_near` along the germ, and it approaches `p` along the star's
`e₃`, more than `90°` from `ω`); so they are the ring's `X`, `X'`, with disjoint cones at `y`; the closed half-circle
`[ψ + 90°, ψ + 270°]` at `y` is covered by the two closed cones (a tile of `y` of colour `a'` or `b'` reaching into `B(p, 1)` would be a
tip), `ψ + 90°` is in the one and `ψ + 270°` in the other (the ring's own germs at `y`, by the tangent lemma): `isPreconnected_Icc`.
The tip pair is not free: `ringGerm_inward` at `y` would give a tile of `y` holding `p`, a tip (`isTip_comm`), and there is none.

**Two hypotheses are idle, and stay as filed** (a generalization, reported): the freedom of the outer pair of `y` (`ho`: referenced by
`have _ := ho`, as `doubleTip` does for its three) and *simple* at `y` (`hS` is read at `{p}` only). The clause holds at a closed
change point of `p`'s ring too.

### 3.3 `semiHub_places` (about 430 lines with its seven children against 650)

The plan's case table, with three of its cells merged by two lemmas that need no case on *which* side colour:

- `disjoint_ball_of_far_witness` — a tile `C ∋ y` of colour `o` misses `B(w, 1)` when `w` carries `o` and some closure point of the
  class of `o` is nearer than `1` to `w` and more than `1` from `y` (the tile of `o` at `w` would hold it). One proof for "`o` the inner
  colour" and "`o` the outer colour" of the arc at `u` (the plan's two sub-cases: "that one is `p`'s tile, or holds outer points of the
  arc more than `1` from `y`").
- `mem_closure_of_coneAt_toward` — a tile approaching `y` along a direction within `90°` of `γ` holds `y + e(γ)` when that point
  carries its colour. One proof for the tip `τ` whether its colour is the inner or the outer colour of the arc at `u` (kind T).
- `semiHub_edge` — FS116-N3-CONE (c) composed once: `exists_initialPiece_of_ncard_le_three` (K2 at three colours),
  `isRingArc_of_edge`, `four_le_of_bothKind`.
- In the "otherwise" cells the pairs are not disjoint because four distinct colours of a four-colour vertex are all of them
  (`eq_of_ncard_eq_four`, with `IsRingArc.inner_ne_outer`: the two side colours of an arc differ when the inner one is carried at the
  centre — from `IsRingArc.disjoint_coneAt`, no star); then `germPair_dicho` gives the swap, and the star (`fullSemiHub_star_parallel`,
  `…_parallel_T`) places the third colour's tile: `t_front` is barred to an outer colour by `star_outer_cone` (it holds `ψ`), `t_back`
  to a tip (it holds `ψ + 180°`).
- Kind T's tip is taken as *the* tile `ringGerm_inward` gives along `ψ + 180°`, so "a single tip" needs no argument.

**The shared lemmas served as stated**: C1 and C2 were not needed in this module (every window was closed by a direction the cone
holds and a cosine, or by `add_notMem_angleIcc` / `sub_notMem_angleIcc`); G1 is used three times; K2 at three colours once, in
exactly the shape the join job handed (`hα`, `hB`, `hBT` of `isRingArc_of_edge`); K1 not at all (no sector is named). No corollary of a
shared lemma was needed, and no message about them.

### 3.4 The save

