### 20.2 What is left: the four cases, each with its route (the next implementer's work list)

Common to all four, with `F'` the move's surgery at radius `ρ` and `F'' := F'.cleanKeep` — **one line each** (IR1's § 17.3, re-read against
the kit): `F''.Valid` (`cleanKeep_valid`), `F''.IsClean` (`cleanKeep_isClean`), `LocalStep F F'' (closedBall v ρ)`
(`surgery_cleanKeep_localStep`), `F''.coloursAt v ⊆ F.coloursAt v` (`coloursAt_cleanKeep`, the move's clause), `F''.dom = F.dom`,
`F''.RingArcsWithin F` (`cleanKeep_isModification` after the move's clause), and `IsModification`'s third clause off the closed disc
(`coloursAt_eq_of_agreesOn` on the open complement) and at `v`. **Left, per case, are four things**: (a) the radius below `δ`; (b) at most
three colours at every `x ≠ v` of the closed disc; (c) the count at `v`; (d) no site at any `x ≠ v` of the closed disc.

**A fact that removes three sub-cases** (`Near.col_ne_next_of_isClean`): in a clean map consecutive chart sectors differ in colour. So
`Moves`' cut constructions never occur here — `exists_shave_of_flankAbove`/`_flankBelow` (a flank of the horn's colour) and the first
branch of `exists_rayMerge_of_clear` (the sector just above the lower horn has colour `c`) — nor MERGE with adjacent `c`-sectors
(`a + 1 = b`), nor a phantom germ (`MergeMove`'s `Phantom`). Each is closed by `absurd` from that lemma; the constructions actually met are
`mergeArcs`/`mergeCol` (two scales, `ρ/2` and `ρ`), `RayConfig.exists_merge` (`Near.move`, kept germs `rayKeep`, the full rim circle),
`exists_shave_recolour` (`Near.move` with `shaveArcs`, `shaveCol`, the full rim circle), and OPEN's surgery (two scales).

**(a) the radius.** OPEN: `exists_open` gives it. MERGE: `exists_merge_aux`'s body is public pieces (`Near.exists_gap`, `merge_hlc`,
`merge_valid`, …, all in `ArcMap.Near`); re-run it in `Procedure` with `ρ := min (min (ρ'/2) (ρc/2)) (δ/2)` — no new declaration in
`MergeMove` is needed for the radius. MERGE-RAY: `exists_rayMerge_of_clear`'s body with `(X.eventually_small.and hclear).and
(Ioo_mem_nhdsGT hδ)`; its pieces are public (`Near.horn_index`, `RayGap.curv_le_of_hornSet_subset`, `Near.RayConfig`), and
`RayConfig.exists_merge` hides its map — add beside it in `Moves` a named form whose conclusion is about
`X.move h (X.rayKeep α κ₂ κ₃) ∅ (F.rayCol v α κ₁ κ₄ ρ c) …` (ruling 421 (c); its proof is the present one, split at `set F' := …`). SHAVE:
the same for `exists_shave_recolour` (its radius is chosen inside; the named form takes `X`, `hs : X.Small ρ` and the clearness at `ρ`).

**(c) the count at `v`**, from Stage 19:
- OPEN — `exists_open`'s clause (`m' ≤ m`, `j' < j` for `F'`) and `cleanKeep_pot_le hvd hm' hj' …`: done in three lines once `F'` is in hand.
- MERGE, MERGE-RAY — `pot_lt_of_interior X (X.two_le_of_isClean hc hn0) hsub hdrop hdeg hhorn …` with `F₂ := F''`: `hsub` — an interior
  point of `F` in `B(v, r)`, `r` small, lies on no new arc (`mem_merge_interiorPts_iff`, `mem_move_interiorPts_iff` with
  `mem_newArcs_iff`), so it is interior to `F'`, hence to `F''` (`interiorPts_subset_cleanKeep`); `hdrop` — the points near `v` of one
  germ inside the recoloured gap are interior to `F'` (MERGE: a germ of `gapGerm s a b`, not among `mergeArcs` inside `ρ/2`; MERGE-RAY:
  the lower horn's upper germ `next i₀`, not in `rayKeep`).
- SHAVE — `pot_lt_of_sectors` with `H` the horn `X.G.sector v r i₀`: a sector `S₂` of `F''` holds an interior point `z` of `F` off the
  `σ`-arc; if `z ∉ H`, its chart sector is interior to `F''` and lies in `S₂` (as `exists_isSector_subset`); if `z ∈ H` above the `σ`-arc,
  then `hornSet v α σ κ₂ r`, a point of the germ `next i₀` and the flank sector above are a connected set of `F''`-interior points (the
  germ's points carry the one colour `g` in `F'`: `g` above, and `g` on the recoloured upper part), so `S₂` contains the flank sector;
  below, the same with `h`. (When `σ = κ₂` there is no upper part, when `σ = κ₁` no lower part; the argument is unchanged.)

**(b), (d) at `x ≠ v` strictly inside the scale where the move acts, on no junction** — one lemma each from Stage 20's kit, once
"`Γ` of `F''` near `x` lies on one line or circle through `x`" is shown: `F''.Γ ⊆ F'.Γ` (`cleanKeep_Γ`, `essSet_subset_Γ`), `F'.Γ` in the
open ball is the union of finitely many germ-like arcs `branchPt v β κ '' Icc 0 ρ` (kept germs, SHAVE's `σ`-arc, OPEN's ray) pairwise
meeting only at `v` (`Near.hdisj`), each a closed set; so some ball about `x` meets at most one, which lies on a full curve through `v`
(`exists_curveGerm_eq`, `branchPt_curveGerm_mem`), the same curve read from `x`. Then `hasHornCount_zero_of_germs` with the curve's two
germs at `x` (`exists_eq_branchPt_curveGerm`; their directions are opposite) gives horn count `0` and degree at most `2`;
`not_hasRepeatedColour_of_degree_le_three` gives no repeated colour; `exists_hasDegree_of_mem_dom` gives at most two colours. (A draft
of this lemma, `not_isSite_of_curve`, and of the change of base point `curveAt_rebase`, is `data/fs131/ir/ir2/scratch/Curve.lean` —
see § 20.4 for whether it was checked.)

**(b), (d) at the junctions** — the finitely many points where a germ or new arc meets a rim: the circle of radius `ρ` for MERGE-RAY
and SHAVE (`Near.move` adds the whole circle), **the circle of radius `ρ/2` for MERGE and OPEN** (their surgery recolours inside `ρ/2`
and re-presents the germs between `ρ/2` and `ρ`; so their statements' rim clauses, which speak of `sphere v ρ`, do not cover the
junctions, which lie strictly inside the disc — IR1's finding (b), located). At a junction `x` the arcs of `F''` near `x` lie on two
curves through `x` with different tangents there (the rim circle, `curveAt x 1 (v - x)`, and the germ's curve; they are tangent only if
`x` is antipodal to `v` on the germ's circle, excluded by `|κ| ρ < 2`), so `hasHornCount_zero_of_germs` with the four germs gives horn
count `0`; and **one of the four branches is dead** in every case (its points near `x` carry one colour in `F'`): the germ's inner
branch where the germ lies inside the recoloured region, or a rim branch where the sector on that side keeps its colour across the
rim. The lemma's last clause then gives degree at most `3`, hence no repeated colour (`not_hasRepeatedColour_of_degree_le_three`) and at
most three colours. No identification of which branch is the inner one is needed: the dead points `w` (on the germ inside the rim, or
on the rim) are curve points near `x`, each `branchPt x (curveGerm …σ) ‖w - x‖` for some `σ = ±1`, and one `σ` occurs for points
arbitrarily near `x` (`Filter.Frequently` over two cases). Where both rim branches are dead (the sectors on both sides keep their
colours) the junction is a point on one curve and the previous paragraph applies. The colour facts are read from each construction's
colour function on chart sectors (`mergeCol_of_mem_sector`, `mergeCol_of_mem_sector_out`, `rayCol_of_mem`/`_of_not_mem` with
`RayConfig.sector_disjoint`, `shaveCol_of_above`/`_of_not_above`/`_of_not_mem`, `openCol_of_mem`/`_of_not_mem`), at a chart radius above
`ρ` for the points just outside the rim.

**Points of `sphere v ρ` in MERGE and OPEN** carry the old map near them (the surgery only re-presents the arcs there): no site, since
`F` has none in the punctured good ball (`not_isSite_of_goodAt hc X.hG`, transferred by `isSite_iff_of_agreesOff` on a small closed
ball's complement, or read directly by the one-curve lemma).

**Order suggested**: MERGE-RAY first (one scale, no new arc inside, the kit's simplest instance: it fixes the junction lemma's final
form), then SHAVE (one new arc), then MERGE and OPEN (two scales; OPEN's count is free). Price, from this session's first two leaves
(Stages 19–20: about 420 lines in a quarter of a session, no geometry): the kit was cheap; **the cases are where the lines are** — I
price each at 300–500 lines, the junction lemma's two-curve form (transversality at `x`, the dead branch) at about 150 once, so **two
sessions** for the four, as IR1 priced it; nothing found so far says more.
