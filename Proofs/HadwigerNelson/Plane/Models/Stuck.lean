import Proofs.HadwigerNelson.Plane.Models.Paint

/-!
# A stuck vertex in a valid map of the plane, and a doubly shadowed band under Condition 5 (FS131-KM1, skeleton)

`plans/FS131-models-kernel-plan.md` § 4; the hand objects are FS131-E7's `P₅` and `P₄` (`plans/FS131-E7-derivation.md` §§ 7, 6).

* `stuckModel : ArcMap 12` — the brick map with five spare colours painted in three bricks: in `B(plantPt, 1/10)` the bowtie's picture
  (`7` inside `B(N, 1)`, `8` inside `B(S′, 1)`, `9` on the two horns between `ω(N)` and `ω(S′)`), and about each pole a square of side
  `1/10` cut by its diagonals into four wedges (`7` or `8` toward the vertex, `9` away from it, `10` and `11` at the sides). **The model of
  `Valid ∧ Covers v 1 ∧ IsStuck v`** (`stuckModel_hyps`), in place of the completed bowtie; E7's discs at the poles are squares here, so
  that every new arc but the four unit arcs and one circle is a segment with rational ends.
* `shadowModel : ArcMap 9` — the brick map with two spare colours: `7` on the flank above a band at `plantPt` and on a horn at the lower
  pole, `8` on their mirror images. **The model of `flank_ne_of_doublyShadowed`** (`shadowModel_flank_ne`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## The stuck vertex -/

/-- The open square of side `1/10` about `p`. -/
def poleSq (p : ℂ) : Set ℂ := {z | |(z - p).re| < 1 / 20 ∧ |(z - p).im| < 1 / 20}

/-- The four sides and the two diagonals of the square about `p`. -/
noncomputable def poleSqArcs (p : ℂ) : Set Arc :=
  {Arc.seg (p + (-1 / 20 - 1 / 20 * I)) (p + (1 / 20 - 1 / 20 * I)), Arc.seg (p + (1 / 20 - 1 / 20 * I)) (p + (1 / 20 + 1 / 20 * I)),
    Arc.seg (p + (1 / 20 + 1 / 20 * I)) (p + (-1 / 20 + 1 / 20 * I)), Arc.seg (p + (-1 / 20 + 1 / 20 * I)) (p + (-1 / 20 - 1 / 20 * I)),
    Arc.seg (p + (-1 / 20 - 1 / 20 * I)) (p + (1 / 20 + 1 / 20 * I)), Arc.seg (p + (-1 / 20 + 1 / 20 * I)) (p + (1 / 20 - 1 / 20 * I))}

/-- The painted set of `stuckModel`: the disc about the vertex and the squares about its poles. -/
noncomputable def stuckW : Set ℂ := ball plantPt (1 / 10) ∪ poleSq plantN ∪ poleSq plantS

/-- The new arcs of `stuckModel`: the circle of radius `1/10`; the arcs of `ω(N)` and of `ω(S′)` inside it, each as its two tangent arcs
from the vertex; the squares' sides and diagonals. -/
noncomputable def stuckArcs : Set Arc :=
  {Arc.circ plantPt (1 / 10) 0 (2 * π), germArc plantPt 0 1 (1 / 10), germArc plantPt π (-1) (1 / 10),
    germArc plantPt 0 (-1) (1 / 10), germArc plantPt π 1 (1 / 10)} ∪ poleSqArcs plantN ∪ poleSqArcs plantS

/-- The painting of `stuckModel` (read on `stuckW` only). -/
noncomputable def stuckCol (z : ℂ) : Fin 12 := by
  classical
  exact
    if dist z plantPt < 1 / 10 then
      (if dist z plantN < 1 then 7 else if dist z plantS < 1 then 8 else 9)
    else if z ∈ poleSq plantN then
      (if (z - plantN).im < -|(z - plantN).re| then 7
        else if |(z - plantN).re| < (z - plantN).im then 9
        else if |(z - plantN).im| < (z - plantN).re then 10 else 11)
    else
      (if |(z - plantS).re| < (z - plantS).im then 8
        else if (z - plantS).im < -|(z - plantS).re| then 9
        else if |(z - plantS).im| < (z - plantS).re then 10 else 11)

theorem stuckArcs_nondegenerate : ∀ a ∈ stuckArcs, a.Nondegenerate := by
  sorry

theorem stuckArcs_finite : stuckArcs.Finite := by
  sorry

theorem frontier_stuckW_subset : frontier stuckW ⊆ ⋃ a ∈ (brickBase 12 (by norm_num)).arcs ∪ stuckArcs, a.carrier := by
  sorry

theorem stuckCol_locallyConstant : ∀ x ∈ stuckW, x ∉ ⋃ a ∈ (brickBase 12 (by norm_num)).arcs ∪ stuckArcs, a.carrier →
    ∀ᶠ y in 𝓝 x, stuckCol y = stuckCol x := by
  sorry

/-- **The planted bowtie** (FS131-E7's `P₅`): a valid map of the plane in twelve colours with a stuck vertex at `plantPt`. -/
noncomputable def stuckModel : ArcMap 12 :=
  (brickBase 12 (by norm_num)).paint stuckW stuckArcs stuckArcs_nondegenerate stuckArcs_finite frontier_stuckW_subset stuckCol
    stuckCol_locallyConstant

/-- `stuckModel` is a map of the plane. -/
theorem stuckModel_isPlaneMap : stuckModel.IsPlaneMap := ArcMap.paint_isPlaneMap (brickBase_isPlaneMap 12 _)

/-- `stuckModel` covers the closed unit disc about its vertex. -/
theorem stuckModel_covers : stuckModel.Covers plantPt 1 := ArcMap.covers_of_isPlaneMap stuckModel_isPlaneMap _ _

/-- `stuckModel` is valid (FS131-E7 § 7.2, with squares at the poles). -/
theorem stuckModel_valid : stuckModel.Valid := by
  sorry

/-- The colours at the vertex are `7`, `8`, `9`. -/
theorem stuckModel_coloursAt : stuckModel.coloursAt plantPt = {7, 8, 9} := by
  sorry

/-- The horn colour `9` has two sectors at the vertex, each flank colour one. -/
theorem stuckModel_hasSectors : stuckModel.HasSectors plantPt 9 2 ∧ stuckModel.HasSectors plantPt 7 1 ∧
    stuckModel.HasSectors plantPt 8 1 := by
  sorry

/-- The two horns of colour `9`, along `e 0` and `e π`, each between the unit arcs of `ω(S′)` and `ω(N)`. -/
theorem stuckModel_isHorn : stuckModel.IsHorn plantPt 0 (-1) 1 9 ∧ stuckModel.IsHorn plantPt π (-1) 1 9 := by
  sorry

/-- The flanks: along `e 0`, `7` above and `8` below; along `e π` (whose normal is `−i`), `8` above and `7` below. -/
theorem stuckModel_flanks : (stuckModel.IsFlankAbove plantPt 0 1 7 ∧ stuckModel.IsFlankBelow plantPt 0 (-1) 8) ∧
    (stuckModel.IsFlankAbove plantPt π 1 8 ∧ stuckModel.IsFlankBelow plantPt π (-1) 7) := by
  sorry

/-- The contacts at the poles: the flank colours in-type (`7` at `N`, `8` at `S′`), the horn colour out-type at both. -/
theorem stuckModel_contacts :
    (stuckModel.IsContact plantPt 7 plantN ∧ stuckModel.InType plantPt 7 plantN) ∧
    (stuckModel.IsContact plantPt 8 plantS ∧ stuckModel.InType plantPt 8 plantS) ∧
    (stuckModel.IsContact plantPt 9 plantN ∧ stuckModel.OutType plantPt 9 plantN) ∧
    (stuckModel.IsContact plantPt 9 plantS ∧ stuckModel.OutType plantPt 9 plantS) := by
  sorry

/-- No MERGE at the vertex: only `9` is repeated, and its allowed cone lies in the line across the two poles' directions. -/
theorem stuckModel_not_mergeAvailable : ¬ stuckModel.MergeAvailable plantPt := by
  sorry

/-- No MERGE-RAY at the vertex: its two horns lie along different rays. -/
theorem stuckModel_not_rayAvailable : ¬ stuckModel.RayAvailable plantPt := by
  sorry

/-- No SHAVE at the vertex: every point of either horn is in the shadow of both flank colours (the wedges toward the vertex at the two
poles). -/
theorem stuckModel_not_shaveAvailable : ¬ stuckModel.ShaveAvailable plantPt := by
  sorry

/-- The vertex of `stuckModel` is stuck. -/
theorem stuckModel_isStuck : stuckModel.IsStuck plantPt :=
  ⟨stuckModel_not_mergeAvailable, stuckModel_not_rayAvailable, stuckModel_not_shaveAvailable, 9, 2, le_rfl, stuckModel_hasSectors.1⟩

/-- **The model of `Valid ∧ Covers v 1 ∧ IsStuck v`** — the hypotheses FLANK-Q, `FlankUA` and `Terminal`'s any-`k` stuck lemmas share —
on a map of the plane. -/
theorem stuckModel_hyps : stuckModel.Valid ∧ stuckModel.IsPlaneMap ∧ stuckModel.Covers plantPt 1 ∧ stuckModel.IsStuck plantPt :=
  ⟨stuckModel_valid, stuckModel_isPlaneMap, stuckModel_covers, stuckModel_isStuck⟩

/-- **`stuckModel` is terminal**: no move is available at any point of the plane (FS131-E7 § 7.4: the vertex is the only point with a
repeated colour or a horn). -/
theorem stuckModel_terminal : stuckModel.Terminal := by
  sorry

/-! ## A doubly shadowed band under Condition 5 -/

/-- The class of `7` in `shadowModel`: the flank above the band at the vertex, and a horn at the lower pole. -/
noncomputable def shadowWg : Set ℂ := hornSet plantPt 0 (1 / 2) (3 / 4) (1 / 10) ∪ hornSet plantS 0 (1 / 10) (1 / 5) (1 / 20)

/-- The class of `8` in `shadowModel`: the mirror images. -/
noncomputable def shadowWh : Set ℂ := hornSet plantPt 0 (-3 / 4) (-1 / 2) (1 / 10) ∪ hornSet plantN 0 (-1 / 5) (-1 / 10) (1 / 20)

/-- The new arcs of `shadowModel`: the boundaries of the four horn sets. -/
noncomputable def shadowArcs : Set Arc :=
  hornArcs plantPt 0 (1 / 2) (3 / 4) (1 / 10) ∪ hornArcs plantS 0 (1 / 10) (1 / 5) (1 / 20) ∪
    (hornArcs plantPt 0 (-3 / 4) (-1 / 2) (1 / 10) ∪ hornArcs plantN 0 (-1 / 5) (-1 / 10) (1 / 20))

/-- The painting of `shadowModel` (read on `shadowWg ∪ shadowWh` only). -/
noncomputable def shadowCol (z : ℂ) : Fin 9 := by
  classical
  exact if z ∈ shadowWg then 7 else 8

theorem shadowArcs_nondegenerate : ∀ a ∈ shadowArcs, a.Nondegenerate := by
  sorry

theorem shadowArcs_finite : shadowArcs.Finite :=
  ((hornArcs_finite _ _ _ _ _).union (hornArcs_finite _ _ _ _ _)).union
    ((hornArcs_finite _ _ _ _ _).union (hornArcs_finite _ _ _ _ _))

theorem frontier_shadowW_subset :
    frontier (shadowWg ∪ shadowWh) ⊆ ⋃ a ∈ (brickBase 9 (by norm_num)).arcs ∪ shadowArcs, a.carrier := by
  sorry

theorem shadowCol_locallyConstant : ∀ x ∈ shadowWg ∪ shadowWh,
    x ∉ ⋃ a ∈ (brickBase 9 (by norm_num)).arcs ∪ shadowArcs, a.carrier → ∀ᶠ y in 𝓝 x, shadowCol y = shadowCol x := by
  sorry

/-- **The doubly shadowed band** (FS131-E7's `P₄`): the brick map in nine colours with `7` and `8` painted in three bricks. -/
noncomputable def shadowModel : ArcMap 9 :=
  (brickBase 9 (by norm_num)).paint (shadowWg ∪ shadowWh) shadowArcs shadowArcs_nondegenerate shadowArcs_finite
    frontier_shadowW_subset shadowCol shadowCol_locallyConstant

/-- `shadowModel` is a map of the plane. -/
theorem shadowModel_isPlaneMap : shadowModel.IsPlaneMap := ArcMap.paint_isPlaneMap (brickBase_isPlaneMap 9 _)

/-- `shadowModel` is valid (FS131-E7 § 6.2: the flank lies inside the circle of radius `4` about `plantPt + 4i`, the source outside the
concentric circle of radius `5`). -/
theorem shadowModel_valid : shadowModel.Valid := by
  sorry

/-- `shadowModel` has Condition 5: its new arcs have radii `2`, `4/3`, `5`, `10`, `1/10`, `1/20`. -/
theorem shadowModel_condition5 : shadowModel.Condition5 := by
  sorry

/-- The flanks at the vertex: `7` above the arc of curvature `1/2`, `8` below the arc of curvature `−1/2`. -/
theorem shadowModel_flanks : shadowModel.IsFlankAbove plantPt 0 (1 / 2) 7 ∧ shadowModel.IsFlankBelow plantPt 0 (-1 / 2) 8 := by
  sorry

/-- **The band is doubly shadowed** (FS131-E7 § 6.3.1): between the curvatures `∓1/8` every point near the vertex is at distance `1` from
a point of the horn of `7` at the lower pole and from a point of the horn of `8` at the upper pole. -/
theorem shadowModel_doublyShadowed : shadowModel.DoublyShadowed plantPt 0 (-1 / 2) (1 / 2) 7 8 := by
  sorry

/-- **The model of `flank_ne_of_doublyShadowed`**: the theorem applied to `shadowModel` — every hypothesis holds on it at once. -/
theorem shadowModel_flank_ne : (7 : Fin 9) ≠ 8 :=
  ArcMap.flank_ne_of_doublyShadowed shadowModel_valid shadowModel_condition5
    (ArcMap.covers_of_isPlaneMap shadowModel_isPlaneMap _ _) (by norm_num) (by norm_num) (by norm_num) shadowModel_flanks.1
    shadowModel_flanks.2 shadowModel_doublyShadowed

end HadwigerNelson.Plane
