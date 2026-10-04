import Proofs.HadwigerNelson.Plane.LocalMap

/-!
# FS116-Y2-SIXFRAG: a valid non-Siamese six-coloured fragment about a vertex of six colours

The milestone's six-colour inhabitant (`plans/FS131-kernel-plan.md` § 7.3 item 5): the hypotheses of FS129-SR1-SIXQ
(`Plane/RingGerm`) are met by it. The object (`plans/FS116-Y2-construction.md` § 2.3, `tools/fs116_y2_six.py frag`), about
`p = 0`, cut at `|x| = 3/2`:

* the **unit sector flower**: `S_j`, the open sector of the unit disc between the angles `60°j` and `60°(j + 1)`, colour `j`;
* the six **lenses** `Q_j`: the points outside `ω(0)` within `1` of `e(60°j − 30°)` and of `e(60°j + 30°)`, colour `j + 2`;
* the six **gap tiles** `G_j` at `e(60°j + 30°)`: the points outside `ω(0)` between `Q_j` and `Q_{j+1}` (at distance at least `1`
  from `e(60°j − 30°)` and from `e(60°j + 90°)`), colour `j + 4` (mod 6).

**The arcs** (`sixArcs`): the six radial segments `[0, e(60°j)]`, the unit circle, and the twelve lens sides — about
`e(60°j − 30°)` from the angle `60°j + 30°` (the far vertex `√3 e(60°j)`) to `60°j + 90°` (the corner `e(60°j + 30°)`), and
about `e(60°j + 30°)` from `60°j − 90°` (the corner `e(60°j − 30°)`) to `60°j − 30°` (the far vertex). The domain `B(0, 3/2)`
cuts the lens sides.

**The colour** (`sixCol`), by formula: inside the unit disc, the sector index `⌊arg x / 60°⌋ mod 6`; outside, `j + 2` when `x`
lies within `1` of both `e(60°j ± 30°)` for the nearest lens index `j = round(arg x / 60°)`, and otherwise the sector index
plus `4`. Indices are computed in `ZMod 6`, which is `Fin 6`.

**Validity** is the pair certificate of the derivation, re-proved: colour `0` is carried by `S_0`, `Q_4` and `G_2` (rotation by
`60°` maps colour `j` to `j + 1`), whose three diameters are below `1` and whose three cross distances are above `1`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- The sector index `⌊arg x / 60°⌋ mod 6`. -/
noncomputable def sixSector (x : ℂ) : ZMod 6 := ((⌊Complex.arg x / (π / 3)⌋ : ℤ) : ZMod 6)

/-- The nearest lens index `round(arg x / 60°)` (as an integer; the lens centres `e(60°m ± 30°)` depend on it mod 6). -/
noncomputable def sixRound (x : ℂ) : ℤ := round (Complex.arg x / (π / 3))

/-- `x` lies in the open lens about the direction `60°m`: within `1` of `e(60°m − 30°)` and of `e(60°m + 30°)`. -/
def InSixLens (m : ℤ) (x : ℂ) : Prop :=
  dist x (e (m * (π / 3) - π / 6)) < 1 ∧ dist x (e (m * (π / 3) + π / 6)) < 1

/-- The colour of FS116-Y2-SIXFRAG: sector index inside the unit disc; lens index `+ 2` in a lens; sector index `+ 4` in a
gap. -/
noncomputable def sixCol (x : ℂ) : Fin 6 :=
  open Classical in
  if ‖x‖ < 1 then sixSector x
  else if InSixLens (sixRound x) x then ((sixRound x : ZMod 6) + 2 : ZMod 6)
  else (sixSector x + 4 : ZMod 6)

/-- The arcs of FS116-Y2-SIXFRAG: six radial segments, the unit circle, twelve lens sides. -/
noncomputable def sixArcs : Set Arc :=
  {a | ∃ j : Fin 6, a = .seg 0 (e (j * (π / 3)))} ∪ {.circ 0 1 0 (2 * π)} ∪
    {a | ∃ j : Fin 6, a = .circ (e (j * (π / 3) - π / 6)) 1 (j * (π / 3) + π / 6) (j * (π / 3) + π / 2)} ∪
    {a | ∃ j : Fin 6, a = .circ (e (j * (π / 3) + π / 6)) 1 (j * (π / 3) - π / 2) (j * (π / 3) - π / 6)}

/-- The arcs of `sixArcs` have positive length. -/
theorem sixArcs_nondegenerate : ∀ a ∈ sixArcs, a.Nondegenerate := by
  sorry

/-- Finitely many arcs: every point has a neighbourhood meeting finitely many. -/
theorem sixArcs_locallyFinite : ∀ x ∈ ball (0 : ℂ) (3 / 2), ∃ t ∈ 𝓝 x,
    {a | a ∈ sixArcs ∧ (a.carrier ∩ t).Nonempty}.Finite := by
  sorry

/-- `sixCol` is locally constant off the arcs, inside `B(0, 3/2)`: the floor of `arg x / 60°` jumps only on the rays
`60°j`, which inside the disc are radial segments and outside lie in lenses (where the round is constant); the round
jumps only on the rays `60°j + 30°`, which outside the disc lie in gaps (where it is not read); `arg` jumps only on the
ray `180°`; the lens test changes only on the lens sides; `‖x‖ < 1` changes only on the unit circle. -/
theorem sixCol_locallyConstant : ∀ x ∈ ball (0 : ℂ) (3 / 2), x ∉ ⋃ a ∈ sixArcs, a.carrier →
    ∀ᶠ y in 𝓝 x, sixCol y = sixCol x := by
  sorry

/-- **FS116-Y2-SIXFRAG's fragment**: the six-coloured map of `B(0, 3/2)` by the unit sector flower, six lenses and six gap
tiles. -/
noncomputable def sixFrag : ArcMap 6 where
  dom := ball 0 (3 / 2)
  isOpen_dom := isOpen_ball
  arcs := sixArcs
  nondegenerate := sixArcs_nondegenerate
  locallyFinite := sixArcs_locallyFinite
  col := sixCol
  locallyConstant := sixCol_locallyConstant

/-! ## Spec examples of the colour (each fails if `sixCol` drifts) -/

/-- The point `1/2` of the sector `S_0` has colour `0`. -/
example : sixCol (1 / 2) = 0 := by
  have h : ‖(1 / 2 : ℂ)‖ < 1 := by norm_num
  have harg : Complex.arg (1 / 2 : ℂ) = 0 := by
    rw [show (1 / 2 : ℂ) = ((1 / 2 : ℝ) : ℂ) by push_cast; ring]
    exact Complex.arg_ofReal_of_nonneg (by norm_num)
  simp only [sixCol, h, if_true, sixSector, harg, zero_div, Int.floor_zero, Int.cast_zero]
  rfl

/-- The point `6/5` of the lens `Q_0` has colour `2`. -/
example : sixCol (6 / 5) = 2 := by
  sorry

/-- The point `(6/5) e(30°)` of the gap tile `G_0` has colour `4`. -/
example : sixCol ((6 / 5 : ℂ) * e (π / 6)) = 4 := by
  sorry

/-- The point `(1/2) e(210°)` of the sector `S_3` (an angle with negative `arg`) has colour `3`. -/
example : sixCol ((1 / 2 : ℂ) * e (7 * π / 6)) = 3 := by
  sorry

/-! ## The row: FS116-Y2-SIXFRAG -/

/-- **FS116-Y2-SIXFRAG**, validity: no two interior points of one colour are at distance exactly `1`. Colour `0` (and every
other, by the rotation by `60°`) is carried by `S_0`, `Q_4`, `G_2`: three diameters below `1`, three cross distances above
`1`, exact in `ℚ(√3, √7)` (the cut points of the lenses have cosine `3/4`). -/
theorem sixFrag_valid : sixFrag.Valid := by
  sorry

/-- **FS116-Y2-SIXFRAG**, non-Siamese: two distinct tiles of one colour always have a pair of points at distance at least
`1`. -/
theorem sixFrag_nonSiamese : sixFrag.NonSiamese := by
  sorry

/-- **FS116-Y2-SIXFRAG**, the disc: the fragment holds `B̄(0, R)` for every `R < 3/2`. -/
theorem sixFrag_covers {R : ℝ} (hR : R < 3 / 2) : sixFrag.Covers 0 R :=
  fun _ hx => lt_of_le_of_lt (mem_closedBall.mp hx) hR

/-- **FS116-Y2-SIXFRAG**, the vertex: all six colours are carried at `0`. -/
theorem sixFrag_coloursAt_zero : sixFrag.coloursAt 0 = univ := by
  sorry

/-- **FS116-Y2-SIXFRAG**, the ring lies in `Γ`. -/
theorem sixFrag_sphere_subset_Γ : sphere (0 : ℂ) 1 ⊆ sixFrag.Γ := by
  sorry

/-- **FS116-Y2-SIXFRAG**, every arc of `Γ` on `ω(0)` (with constant sides) is a (Q) arc. -/
theorem sixFrag_isQArc {θ₁ θ₂ : ℝ} {c c' : Fin 6} (h : sixFrag.IsRingArc 0 θ₁ θ₂ c c') :
    sixFrag.IsQArc 0 θ₁ θ₂ := by
  sorry

/-- The last clause is not vacuous: `r([0°, 30°])` is an arc of `Γ` on `ω(0)`, inner colour `0` (the sector `S_0`), outer
colour `2` (the lens `Q_0`). -/
theorem sixFrag_isRingArc : sixFrag.IsRingArc 0 0 (π / 6) 0 2 := by
  sorry

end HadwigerNelson.Plane
