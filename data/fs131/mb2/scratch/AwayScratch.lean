import Proofs.HadwigerNelson.Plane.Models.Bends

namespace HadwigerNelson.Plane.Scratch

open Complex Real Set Filter Topology Metric

section AwayHelpers

open ArcMap

/-! ### Coordinates, the two circles and the two bricks of `awayModel` (FS131-MB2's helpers) -/

/-- The centre in coordinates. -/
theorem awayModel_P_coords : awayP.re = -3 / 5 ∧ awayP.im = 3 / 10 := by
  constructor <;> simp [awayP]

/-- The squared distance to the centre, in coordinates. -/
theorem awayModel_dist_sq (z : ℂ) : dist z awayP ^ 2 = (z.re + 3 / 5) ^ 2 + (z.im - 3 / 10) ^ 2 := by
  rw [Complex.dist_eq_re_im, Real.sq_sqrt (by positivity), awayModel_P_coords.1, awayModel_P_coords.2]; ring

/-- The point of the circle of radius `ρ` about the centre at the angle `θ`, in coordinates. -/
theorem awayModel_circPt (ρ θ : ℝ) : (awayP + (ρ : ℂ) * e θ).re = -3 / 5 + ρ * Real.cos θ ∧
    (awayP + (ρ : ℂ) * e θ).im = 3 / 10 + ρ * Real.sin θ := by
  obtain ⟨h1, h2⟩ := awayModel_P_coords
  constructor
  · rw [Complex.add_re, Complex.re_ofReal_mul, re_e, h1]
  · rw [Complex.add_im, Complex.im_ofReal_mul, im_e, h2]

/-- **A point of the circle of radius `ρ` about the centre, to the right of it and within `ρ s` of its height, lies on the arc
`circ awayP ρ (−arcsin s) (arcsin s)`.** -/
theorem awayModel_mem_circ {ρ s : ℝ} (hρ : 0 < ρ) (hs : s ≤ 1) {z : ℂ} (hz : dist z awayP = ρ) (hre : -3 / 5 ≤ z.re)
    (him : |z.im - 3 / 10| ≤ ρ * s) : z ∈ (Arc.circ awayP ρ (-(Real.arcsin s)) (Real.arcsin s)).carrier := by
  set t := (z.im - 3 / 10) / ρ with ht
  have hsq := awayModel_dist_sq z
  rw [hz] at hsq
  have htb : |t| ≤ s := by rw [ht, abs_div, abs_of_pos hρ, div_le_iff₀ hρ]; linarith
  obtain ⟨ht1, ht2⟩ := abs_le.mp htb
  have hsin : Real.sin (Real.arcsin t) = t := Real.sin_arcsin (by linarith) (by linarith)
  have hcos : Real.cos (Real.arcsin t) = (z.re + 3 / 5) / ρ := by
    have h1 : 1 - t ^ 2 = ((z.re + 3 / 5) / ρ) ^ 2 := by rw [ht]; field_simp; linarith
    rw [Real.cos_arcsin, h1, Real.sqrt_sq (div_nonneg (by linarith) hρ.le)]
  refine ⟨Real.arcsin t, ⟨?_, Real.arcsin_le_arcsin ht2⟩, ?_⟩
  · rw [← Real.arcsin_neg]; exact Real.arcsin_le_arcsin ht1
  · obtain ⟨h1, h2⟩ := awayModel_circPt ρ (Real.arcsin t)
    apply Complex.ext
    · rw [h1, hcos]; field_simp; ring
    · rw [h2, hsin, ht]; field_simp; ring

/-- The two new arcs lie on the circles of radii `1` and `2` about the centre. -/
theorem awayModel_arcs_subset {z : ℂ} (hz : z ∈ ⋃ a ∈ awayArcs, a.carrier) : dist z awayP = 1 ∨ dist z awayP = 2 := by
  simp only [awayArcs, biUnion_insert, biUnion_singleton, mem_union, Arc.carrier, mem_image] at hz
  rcases hz with ⟨θ, -, rfl⟩ | ⟨θ, -, rfl⟩
  · left; rw [dist_eq_norm, add_sub_cancel_left, norm_mul_e zero_le_one]
  · right; rw [dist_eq_norm, add_sub_cancel_left, norm_mul_e zero_le_two]

/-- An open rectangle of the row `0 < im < 3/5` is open. -/
theorem awayModel_isOpen_rect (a b : ℝ) : IsOpen {w : ℂ | a < w.re ∧ w.re < b ∧ 0 < w.im ∧ w.im < 3 / 5} :=
  (isOpen_lt continuous_const Complex.continuous_re).and ((isOpen_lt Complex.continuous_re continuous_const).and
    ((isOpen_lt continuous_const Complex.continuous_im).and (isOpen_lt Complex.continuous_im continuous_const)))

/-- The closure of such a rectangle lies in the closed rectangle. -/
theorem awayModel_closure_rect {a b : ℝ} {z : ℂ} (hz : z ∈ closure {w : ℂ | a < w.re ∧ w.re < b ∧ 0 < w.im ∧ w.im < 3 / 5}) :
    a ≤ z.re ∧ z.re ≤ b ∧ 0 ≤ z.im ∧ z.im ≤ 3 / 5 := by
  have hcl : IsClosed {w : ℂ | a ≤ w.re ∧ w.re ≤ b ∧ 0 ≤ w.im ∧ w.im ≤ 3 / 5} :=
    (isClosed_le continuous_const Complex.continuous_re).and ((isClosed_le Complex.continuous_re continuous_const).and
      ((isClosed_le continuous_const Complex.continuous_im).and (isClosed_le Complex.continuous_im continuous_const)))
  exact closure_minimal (show {w : ℂ | a < w.re ∧ w.re < b ∧ 0 < w.im ∧ w.im < 3 / 5} ⊆
    {w : ℂ | a ≤ w.re ∧ w.re ≤ b ∧ 0 ≤ w.im ∧ w.im ≤ 3 / 5} from fun w hw => ⟨hw.1.le, hw.2.1.le, hw.2.2.1.le, hw.2.2.2.le⟩) hcl hz

/-- A frontier point of such a rectangle is in the closed rectangle and on one of its four walls. -/
theorem awayModel_frontier_rect {a b : ℝ} {z : ℂ}
    (hz : z ∈ frontier {w : ℂ | a < w.re ∧ w.re < b ∧ 0 < w.im ∧ w.im < 3 / 5}) :
    (a ≤ z.re ∧ z.re ≤ b ∧ 0 ≤ z.im ∧ z.im ≤ 3 / 5) ∧ (z.re = a ∨ z.re = b ∨ z.im = 0 ∨ z.im = 3 / 5) := by
  have hc := awayModel_closure_rect hz.1
  have hn : z ∉ {w : ℂ | a < w.re ∧ w.re < b ∧ 0 < w.im ∧ w.im < 3 / 5} := by
    rw [← (awayModel_isOpen_rect a b).interior_eq]; exact hz.2
  refine ⟨hc, ?_⟩
  by_contra h
  push Not at h
  exact hn ⟨lt_of_le_of_ne hc.1 (Ne.symm h.1), lt_of_le_of_ne hc.2.1 h.2.1, lt_of_le_of_ne hc.2.2.1 (Ne.symm h.2.2.1),
    lt_of_le_of_ne hc.2.2.2 h.2.2.2⟩

/-- **The four walls of the brick `(4c/5, 4c/5 + 4/5) × (0, 3/5)` lie on the brick map's edges**: its bottom and left edges are its own,
its right edge the next brick's left, and its top the bottoms of the two bricks of the row above it. -/
theorem awayModel_wall_mem (c : ℤ) {a b : ℝ} (ha : a = 4 / 5 * (c : ℝ)) (hb : b = 4 / 5 * (c : ℝ) + 4 / 5) {z : ℂ}
    (hc : a ≤ z.re ∧ z.re ≤ b ∧ 0 ≤ z.im ∧ z.im ≤ 3 / 5) (hw : z.re = a ∨ z.re = b ∨ z.im = 0 ∨ z.im = 3 / 5) :
    z ∈ ⋃ a ∈ sevenBrickArcs, a.carrier := by
  subst ha hb
  obtain ⟨h1, h2, h3, h4⟩ := hc
  rcases hw with h | h | h | h
  · exact mem_sevenBrickArcs_of_left (c := c) (r := 0) (by push_cast; linarith) (by push_cast; linarith) (by push_cast; linarith)
  · exact mem_sevenBrickArcs_of_left (c := c + 1) (r := 0) (by push_cast; linarith) (by push_cast; linarith)
      (by push_cast; linarith)
  · exact mem_sevenBrickArcs_of_bottom (c := c) (r := 0) (by push_cast; linarith) (by push_cast; linarith)
      (by push_cast; linarith)
  · rcases le_total z.re (4 / 5 * (c : ℝ) + 2 / 5) with h' | h'
    · exact mem_sevenBrickArcs_of_bottom (c := c - 1) (r := 1) (by push_cast; linarith) (by push_cast; linarith)
        (by push_cast; linarith)
    · exact mem_sevenBrickArcs_of_bottom (c := c) (r := 1) (by push_cast; linarith) (by push_cast; linarith)
        (by push_cast; linarith)

/-- The painted set, by its two pieces. -/
theorem awayModel_mem_awayW {z : ℂ} : z ∈ awayW ↔
    ((0 < z.re ∧ z.re < 4 / 5 ∧ 0 < z.im ∧ z.im < 3 / 5) ∧ dist z awayP < 1) ∨
    ((4 / 5 < z.re ∧ z.re < 8 / 5 ∧ 0 < z.im ∧ z.im < 3 / 5) ∧ ¬ dist z awayP ≤ 2) := Iff.rfl

/-- The two bricks lie among the base's interior points. -/
theorem awayModel_rect_subset {z : ℂ} :
    ((0 < z.re ∧ z.re < 4 / 5 ∧ 0 < z.im ∧ z.im < 3 / 5) → z ∈ (brickBase 8 (by norm_num)).interiorPts) ∧
    ((4 / 5 < z.re ∧ z.re < 8 / 5 ∧ 0 < z.im ∧ z.im < 3 / 5) → z ∈ (brickBase 8 (by norm_num)).interiorPts) :=
  ⟨fun h => brickBase_mem_interiorPts _ (c := 0) (r := 0) (by constructor <;> push_cast <;> linarith [h.1, h.2.1])
      (by constructor <;> push_cast <;> linarith [h.2.2.1, h.2.2.2]),
    fun h => brickBase_mem_interiorPts _ (c := 1) (r := 0) (by constructor <;> push_cast <;> linarith [h.1, h.2.1])
      (by constructor <;> push_cast <;> linarith [h.2.2.1, h.2.2.2])⟩

/-- The first brick is within `2` of the centre, the second beyond `1` from it. -/
theorem awayModel_rect_dist {z : ℂ} :
    ((0 < z.re ∧ z.re < 4 / 5 ∧ 0 < z.im ∧ z.im < 3 / 5) → dist z awayP < 2) ∧
    ((4 / 5 < z.re ∧ z.re < 8 / 5 ∧ 0 < z.im ∧ z.im < 3 / 5) → 1 < dist z awayP) := by
  have hsq := awayModel_dist_sq z
  have hd := dist_nonneg (x := z) (y := awayP)
  refine ⟨fun h => ?_, fun h => ?_⟩
  · obtain ⟨h1, h2, h3, h4⟩ := h
    have : dist z awayP ^ 2 < 2 ^ 2 := by rw [hsq]; nlinarith
    exact (lt_iff_sq_lt_sq' hd (by norm_num)).mpr this
  · obtain ⟨h1, h2, h3, h4⟩ := h
    have : (1 : ℝ) ^ 2 < dist z awayP ^ 2 := by rw [hsq]; nlinarith [sq_nonneg (z.im - 3 / 10)]
    exact (lt_iff_sq_lt_sq' (by norm_num) hd).mpr this

/-- The painted set misses the new arcs: its first piece is inside the unit circle, its second outside the circle of radius `2`. -/
theorem awayModel_not_mem_arcs {z : ℂ} (hz : z ∈ awayW) : z ∉ ⋃ a ∈ awayArcs, a.carrier := by
  intro ha
  rcases awayModel_mem_awayW.mp hz with ⟨h, hd⟩ | ⟨h, hd⟩ <;> rcases awayModel_arcs_subset ha with h' | h'
  · linarith
  · linarith [awayModel_rect_dist.1 h]
  · linarith [awayModel_rect_dist.2 h]
  · linarith

/-- No two points of the painted set are at distance `1`: each brick is open of diameter `1`, and the two pieces are separated by the
annulus between the circles of radii `1` and `2`. -/
theorem awayModel_no_unit_pair {x y : ℂ} (hx : x ∈ awayW) (hy : y ∈ awayW) : dist x y ≠ 1 := by
  have rect : ∀ {a b : ℝ}, (a < x.re ∧ x.re < b ∧ 0 < x.im ∧ x.im < 3 / 5) → (a < y.re ∧ y.re < b ∧ 0 < y.im ∧ y.im < 3 / 5) →
      b - a = 4 / 5 → dist x y ≠ 1 := by
    rintro a b ⟨h1, h2, h3, h4⟩ ⟨k1, k2, k3, k4⟩ hab h
    have hsq : dist x y ^ 2 = (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 := by
      rw [Complex.dist_eq_re_im, Real.sq_sqrt (by positivity)]
    rw [h] at hsq
    have e1 : (x.re - y.re) ^ 2 < (4 / 5) ^ 2 := sq_lt_sq' (by linarith) (by linarith)
    have e2 : (x.im - y.im) ^ 2 < (3 / 5) ^ 2 := sq_lt_sq' (by linarith) (by linarith)
    nlinarith
  have far : ∀ {u w : ℂ}, dist u awayP < 1 → ¬ dist w awayP ≤ 2 → dist u w ≠ 1 := fun {u w} h1 h2 h => by
    have := dist_triangle w u awayP
    rw [dist_comm w u] at this
    linarith
  rcases awayModel_mem_awayW.mp hx with ⟨hx, hdx⟩ | ⟨hx, hdx⟩ <;> rcases awayModel_mem_awayW.mp hy with ⟨hy, hdy⟩ | ⟨hy, hdy⟩
  · exact rect hx hy (by norm_num)
  · exact far hdx hdy
  · rw [dist_comm]; exact far hdy hdx
  · exact rect hx hy (by norm_num)

end AwayHelpers

theorem awayArcs_nondegenerate : ∀ a ∈ awayArcs, a.Nondegenerate := by
  have hπ := Real.pi_pos
  have h1 : 0 < Real.arcsin (3 / 10) := Real.arcsin_pos.mpr (by norm_num)
  have h2 : 0 < Real.arcsin (3 / 20) := Real.arcsin_pos.mpr (by norm_num)
  have h1' := Real.arcsin_le_pi_div_two (3 / 10)
  have h2' := Real.arcsin_le_pi_div_two (3 / 20)
  intro a ha
  simp only [awayArcs, mem_insert_iff, mem_singleton_iff] at ha
  rcases ha with rfl | rfl
  · exact ⟨by norm_num, by linarith, by linarith⟩
  · exact ⟨by norm_num, by linarith, by linarith⟩

theorem frontier_awayW_subset : frontier awayW ⊆ ⋃ a ∈ (brickBase 8 (by norm_num)).arcs ∪ awayArcs, a.carrier := by
  intro z hz
  rw [biUnion_union]
  have hbase : ∀ w : ℂ, w ∈ ⋃ a ∈ sevenBrickArcs, a.carrier → w ∈ ⋃ a ∈ (brickBase 8 (by norm_num)).arcs, a.carrier :=
    fun w hw => hw
  have harc1 : ∀ w : ℂ, dist w awayP = 1 → (0 ≤ w.re ∧ w.re ≤ 4 / 5 ∧ 0 ≤ w.im ∧ w.im ≤ 3 / 5) →
      w ∈ ⋃ a ∈ awayArcs, a.carrier := fun w hd hc =>
    mem_iUnion₂.mpr ⟨_, Or.inl rfl, awayModel_mem_circ one_pos (by norm_num) hd (by linarith [hc.1])
      (by rw [abs_le]; constructor <;> linarith [hc.2.2.1, hc.2.2.2])⟩
  have harc2 : ∀ w : ℂ, dist w awayP = 2 → (4 / 5 ≤ w.re ∧ w.re ≤ 8 / 5 ∧ 0 ≤ w.im ∧ w.im ≤ 3 / 5) →
      w ∈ ⋃ a ∈ awayArcs, a.carrier := fun w hd hc =>
    mem_iUnion₂.mpr ⟨_, Or.inr rfl, awayModel_mem_circ two_pos (by norm_num) hd (by linarith [hc.1])
      (by rw [abs_le]; constructor <;> linarith [hc.2.2.1, hc.2.2.2])⟩
  unfold awayW at hz
  rcases frontier_union_subset _ _ hz with ⟨h, -⟩ | ⟨-, h⟩
  · rcases frontier_inter_subset _ _ h with ⟨h', -⟩ | ⟨h', h''⟩
    · obtain ⟨hc, hw⟩ := awayModel_frontier_rect h'
      exact Or.inl (hbase z (awayModel_wall_mem 0 (by norm_num) (by norm_num) hc hw))
    · rw [frontier_ball awayP one_ne_zero] at h''
      exact Or.inr (harc1 z h'' (awayModel_closure_rect h'))
  · rw [sdiff_eq] at h
    rcases frontier_inter_subset _ _ h with ⟨h', -⟩ | ⟨h', h''⟩
    · obtain ⟨hc, hw⟩ := awayModel_frontier_rect h'
      exact Or.inl (hbase z (awayModel_wall_mem 1 (by norm_num) (by norm_num) hc hw))
    · rw [frontier_compl, frontier_closedBall awayP two_ne_zero] at h''
      exact Or.inr (harc2 z h'' (awayModel_closure_rect h'))

section AwayModelHelpers

open ArcMap

/-! ### The class of `7` in `awayModel`, and the ring arc's points (FS131-MB2's helpers) -/

/-- `awayModel` is a map of the plane. -/
theorem awayModel_isPlaneMap : awayModel.IsPlaneMap := ArcMap.paint_isPlaneMap (brickBase_isPlaneMap 8 _)

/-- **The class of `7` is the painted set**: the base has no class of `7`, and the painted set misses the new arcs. -/
theorem awayModel_region_seven : awayModel.region 7 = awayW := by
  unfold awayModel
  rw [ArcMap.region_paint, brickBase_region_spare _ (by decide)]
  ext z
  constructor
  · rintro ⟨h | h, -⟩
    · exact absurd h.1 (notMem_empty z)
    · exact h.1.2
  · intro hz
    refine ⟨Or.inr ⟨⟨?_, hz⟩, rfl⟩, awayModel_not_mem_arcs hz⟩
    rcases awayModel_mem_awayW.mp hz with ⟨h, -⟩ | ⟨h, -⟩
    · exact awayModel_rect_subset.1 h
    · exact awayModel_rect_subset.2 h

/-- **In the brick `(0, 4/5) × (0, 3/5)` the map is the unit circle's two sides**: a point off `ω(awayP)` is an interior point, of
colour `7` inside the circle and of the brick's colour `0` outside it. -/
theorem awayModel_brick {w : ℂ} (hw : 0 < w.re ∧ w.re < 4 / 5 ∧ 0 < w.im ∧ w.im < 3 / 5) :
    (dist w awayP ≠ 1 → w ∈ awayModel.interiorPts) ∧ (dist w awayP < 1 → awayModel.col w = 7) ∧
    (¬ dist w awayP < 1 → awayModel.col w = 0) := by
  refine ⟨fun hne => ?_, fun hlt => ?_, fun hge => ?_⟩
  · unfold awayModel
    rw [ArcMap.interiorPts_paint]
    refine ⟨awayModel_rect_subset.1 hw, fun ha => ?_⟩
    rcases awayModel_arcs_subset ha with h | h
    · exact hne h
    · linarith [awayModel_rect_dist.1 hw]
  · exact ArcMap.paint_col_of_mem (awayModel_mem_awayW.mpr (Or.inl ⟨hw, hlt⟩))
  · have hnW : w ∉ awayW := fun h => by
      rcases awayModel_mem_awayW.mp h with ⟨-, h'⟩ | ⟨h', -⟩
      · exact hge h'
      · linarith [hw.2.1, h'.1]
    have h0 := brickBase_col_zero (k := 8) (by norm_num) ⟨hw.1, hw.2.1⟩ ⟨hw.2.2.1, hw.2.2.2⟩
    have hc : awayModel.col w = (brickBase 8 (by norm_num)).col w := ArcMap.paint_col_of_not_mem hnW
    rw [hc]
    exact Fin.ext h0

/-- The sine and cosine of an angle of the open ring arc. -/
theorem awayModel_trig {s θ : ℝ} (hs0 : 0 ≤ s) (hs1 : s ≤ 1) (hθ : θ ∈ Icc (-(Real.arcsin s)) (Real.arcsin s)) :
    |Real.sin θ| ≤ s ∧ 0 ≤ Real.cos θ ∧ (θ ∈ Ioo (-(Real.arcsin s)) (Real.arcsin s) → |Real.sin θ| < s ∧ 0 < Real.cos θ) := by
  have hπ := Real.pi_pos
  have hA := Real.arcsin_le_pi_div_two s
  have hA0 : 0 ≤ Real.arcsin s := Real.arcsin_nonneg.mpr hs0
  have hsA : Real.sin (Real.arcsin s) = s := Real.sin_arcsin (by linarith) hs1
  have hsA' : Real.sin (-(Real.arcsin s)) = -s := by rw [Real.sin_neg, hsA]
  refine ⟨?_, Real.cos_nonneg_of_neg_pi_div_two_le_of_le (by linarith [hθ.1]) (by linarith [hθ.2]), fun hθ' => ⟨?_, ?_⟩⟩
  · rw [abs_le]
    constructor
    · rw [← hsA']; exact Real.sin_le_sin_of_le_of_le_pi_div_two (by linarith) (by linarith [hθ.2]) hθ.1
    · rw [← hsA]; exact Real.sin_le_sin_of_le_of_le_pi_div_two (by linarith [hθ.1]) hA hθ.2
  · rw [abs_lt]
    constructor
    · rw [← hsA']; exact Real.sin_lt_sin_of_lt_of_le_pi_div_two (by linarith) (by linarith [hθ.2]) hθ'.1
    · rw [← hsA]; exact Real.sin_lt_sin_of_lt_of_le_pi_div_two (by linarith [hθ.1]) hA hθ'.2
  · exact Real.cos_pos_of_mem_Ioo ⟨by linarith [hθ'.1], by linarith [hθ'.2]⟩

/-- **A point of the open ring arc is strictly inside the brick `(0, 4/5) × (0, 3/5)`.** -/
theorem awayModel_ringPt_mem {θ : ℝ} (hθ : θ ∈ Ioo (-(Real.arcsin (3 / 10))) (Real.arcsin (3 / 10))) :
    0 < (ringPt awayP θ).re ∧ (ringPt awayP θ).re < 4 / 5 ∧ 0 < (ringPt awayP θ).im ∧ (ringPt awayP θ).im < 3 / 5 := by
  obtain ⟨-, -, h⟩ := awayModel_trig (s := 3 / 10) (by norm_num) (by norm_num) ⟨hθ.1.le, hθ.2.le⟩
  obtain ⟨hs, hc⟩ := h hθ
  rw [abs_lt] at hs
  have hsq := Real.sin_sq_add_cos_sq θ
  have hc1 := Real.cos_le_one θ
  have hre : (ringPt awayP θ).re = -3 / 5 + Real.cos θ := by
    rw [ringPt, Complex.add_re, re_e, awayModel_P_coords.1]
  have him : (ringPt awayP θ).im = 3 / 10 + Real.sin θ := by
    rw [ringPt, Complex.add_im, im_e, awayModel_P_coords.2]
  rw [hre, him]
  refine ⟨by nlinarith, by linarith, by linarith, by linarith⟩

/-- **The approach to a radius-2 contact, in real variables**: from the point at the angle `θ` (`C = cos θ`, `S = sin θ`, `|S| ≤ 3/20`)
of the circle of radius `2`, the point a fraction `t` of the way to `(3/2, 3/10)` is strictly inside the brick `(4/5, 8/5) × (0, 3/5)`,
further than `2` from the centre, and less than `t` away. -/
theorem awayModel_approach_real {C S t : ℝ} (h : C ^ 2 + S ^ 2 = 1) (hC0 : 0 ≤ C) (hS : |S| ≤ 3 / 20) (ht0 : 0 < t) (ht1 : t ≤ 1 / 2) :
    (4 / 5 < -3 / 5 + 2 * C + t * (21 / 10 - 2 * C) ∧ -3 / 5 + 2 * C + t * (21 / 10 - 2 * C) < 8 / 5 ∧
      0 < 3 / 10 + 2 * S - t * (2 * S) ∧ 3 / 10 + 2 * S - t * (2 * S) < 3 / 5) ∧
    4 < (2 * C + t * (21 / 10 - 2 * C)) ^ 2 + (2 * S - t * (2 * S)) ^ 2 ∧
    (t * (21 / 10 - 2 * C)) ^ 2 + (t * (2 * S)) ^ 2 < t ^ 2 := by
  obtain ⟨hS1, hS2⟩ := abs_le.mp hS
  have hC1 : C ≤ 1 := by nlinarith [sq_nonneg S]
  have hC : 39 / 40 < C := by nlinarith [sq_nonneg S, sq_nonneg (C - 39 / 40)]
  have hu0 : 0 < t * (21 / 10 - 2 * C) := mul_pos ht0 (by linarith)
  have hu1 : t * (21 / 10 - 2 * C) ≤ 1 / 2 * (3 / 20) := mul_le_mul ht1 (by linarith) (by linarith) (by norm_num)
  have hv1 : t * (2 * S) ≤ t * (3 / 10) := mul_le_mul_of_nonneg_left (by linarith) ht0.le
  have hv2 : t * (-(3 / 10)) ≤ t * (2 * S) := mul_le_mul_of_nonneg_left (by linarith) ht0.le
  refine ⟨⟨by linarith, by linarith, by nlinarith, by nlinarith⟩, ?_, ?_⟩
  · have key : (2 * C + t * (21 / 10 - 2 * C)) ^ 2 + (2 * S - t * (2 * S)) ^ 2 =
        4 * (C ^ 2 + S ^ 2) + t * (42 / 5 * C - 8 * (C ^ 2 + S ^ 2)) + (t * (21 / 10 - 2 * C)) ^ 2 + (t * (2 * S)) ^ 2 := by ring
    rw [key, h]
    nlinarith [mul_pos ht0 (by linarith : (0 : ℝ) < 42 / 5 * C - 8), sq_nonneg (t * (21 / 10 - 2 * C)), sq_nonneg (t * (2 * S))]
  · have key : (t * (21 / 10 - 2 * C)) ^ 2 + (t * (2 * S)) ^ 2 = t ^ 2 * ((21 / 10 - 2 * C) ^ 2 + (2 * S) ^ 2) := by ring
    rw [key]
    have h1 : (21 / 10 - 2 * C) ^ 2 ≤ (3 / 20) ^ 2 := sq_le_sq' (by linarith) (by linarith)
    have h2 : (2 * S) ^ 2 ≤ (3 / 10) ^ 2 := sq_le_sq' (by linarith) (by linarith)
    nlinarith [sq_pos_of_pos ht0]

end AwayModelHelpers

theorem awayModel_hyps : awayModel.Valid ∧ awayModel.IsPlaneMap ∧
    awayModel.IsRingArc awayP (-(Real.arcsin (3 / 10))) (Real.arcsin (3 / 10)) 7 0 ∧ (7 : Fin 8) ∉ awayModel.coloursAt awayP ∧
    ∀ θ ∈ Ioo (-(Real.arcsin (3 / 10))) (Real.arcsin (3 / 10)), ∃ r > 0, awayModel.Γ ∩ ball (ringPt awayP θ) r ⊆ sphere awayP 1 := by
  have hA0 : 0 < Real.arcsin (3 / 10) := Real.arcsin_pos.mpr (by norm_num)
  set O : Set ℂ := {w : ℂ | 0 < w.re ∧ w.re < 4 / 5 ∧ 0 < w.im ∧ w.im < 3 / 5} with hOdef
  have hO : IsOpen O := awayModel_isOpen_rect 0 (4 / 5)
  refine ⟨?_, awayModel_isPlaneMap, ⟨by linarith, fun z hz => ?_, fun θ hθ => ?_⟩, fun h => ?_, fun θ hθ => ?_⟩
  · -- valid: no unit pair inside the painted set, and the base has no class of `7`
    unfold awayModel
    refine ArcMap.paint_valid (brickBase_valid 8 _) (fun x hx y hy _ _ hxy => absurd hxy (awayModel_no_unit_pair hx hy))
      (fun x _ _ y hy => ?_)
    rw [brickBase_region_spare _ (by decide)] at hy
    exact absurd hy (notMem_empty y)
  · -- the closed arc lies on the new unit arc
    obtain ⟨θ, hθ, rfl⟩ := hz
    refine ⟨by rw [awayModel_isPlaneMap]; exact mem_univ _, mem_iUnion₂.mpr ⟨Arc.circ awayP 1 _ _, Or.inr (Or.inl rfl), θ, hθ, ?_⟩⟩
    simp [ringPt]
  · -- the sides: `7` inside, `0` outside
    set z := ringPt awayP θ with hz
    have hzO : z ∈ O := awayModel_ringPt_mem hθ
    have hzP : dist z awayP = 1 := dist_ringPt awayP θ
    constructor
    · ext c
      simp only [ArcMap.innerColours, mem_setOf_eq, mem_singleton_iff]
      constructor
      · intro h
        obtain ⟨w, hwO, hw, hwb⟩ := mem_closure_iff.mp h O hO hzO
        rw [mem_ball] at hwb
        rw [← hw.2, (awayModel_brick hwO).2.1 hwb]
      · rintro rfl
        have hzU : z ∈ closure (O ∩ ball awayP 1) :=
          hO.inter_closure ⟨hzO, by rw [closure_ball awayP one_ne_zero, mem_closedBall, hzP]⟩
        refine closure_mono (fun w hw => ?_) hzU
        have hwb : dist w awayP < 1 := hw.2
        exact ⟨⟨(awayModel_brick hw.1).1 hwb.ne, (awayModel_brick hw.1).2.1 hwb⟩, hw.2⟩
    · ext c
      simp only [ArcMap.outerColours, mem_setOf_eq, mem_singleton_iff]
      constructor
      · intro h
        obtain ⟨w, hwO, hw, hwb⟩ := mem_closure_iff.mp h O hO hzO
        rw [mem_closedBall, not_le] at hwb
        rw [← hw.2, (awayModel_brick hwO).2.2 (not_lt.mpr hwb.le)]
      · rintro rfl
        have hzU : z ∈ closure (O ∩ (closedBall awayP 1)ᶜ) :=
          hO.inter_closure ⟨hzO, by
            rw [closure_compl, interior_closedBall awayP one_ne_zero, mem_compl_iff, mem_ball, hzP]; exact lt_irrefl 1⟩
        refine closure_mono (fun w hw => ?_) hzU
        have hwb : 1 < dist w awayP := by have := hw.2; rwa [mem_compl_iff, mem_closedBall, not_le] at this
        exact ⟨⟨(awayModel_brick hw.1).1 hwb.ne', (awayModel_brick hw.1).2.2 (not_lt.mpr hwb.le)⟩, hw.2⟩
  · -- `7` is not carried at the centre: its class lies to the right of the line `re = 0`
    have h' : awayP ∈ closure awayW := by rw [← awayModel_region_seven]; exact h
    have hsub : awayW ⊆ {w : ℂ | 0 ≤ w.re} := fun w hw => by
      rcases awayModel_mem_awayW.mp hw with ⟨hw, -⟩ | ⟨hw, -⟩
      · exact hw.1.le
      · exact le_trans (by norm_num) hw.1.le
    have := closure_minimal hsub (isClosed_le continuous_const Complex.continuous_re) h'
    rw [mem_setOf_eq, awayModel_P_coords.1] at this
    norm_num at this
  · -- near an interior point of the arc, `Γ` is the unit circle
    obtain ⟨r, hr, hball⟩ := Metric.isOpen_iff.mp hO _ (awayModel_ringPt_mem hθ)
    refine ⟨r, hr, fun w hw => ?_⟩
    have hwO : w ∈ O := hball hw.2
    have hwΓ : w ∈ ⋃ a ∈ (brickBase 8 (by norm_num)).arcs ∪ awayArcs, a.carrier := hw.1.2
    rw [biUnion_union] at hwΓ
    rcases hwΓ with hb | ha
    · exact absurd hb (awayModel_rect_subset.1 hwO).2
    · rcases awayModel_arcs_subset ha with h1 | h2
      · exact h1
      · linarith [awayModel_rect_dist.1 hwO]

theorem awayModel_r2Contacts : awayModel.r2Contacts awayP (-(Real.arcsin (3 / 10))) (Real.arcsin (3 / 10)) 7 =
    Icc (-(Real.arcsin (3 / 20))) (Real.arcsin (3 / 20)) := by
  have hπ := Real.pi_pos
  have hmono : Real.arcsin (3 / 20) ≤ Real.arcsin (3 / 10) := Real.arcsin_le_arcsin (by norm_num)
  have hB := Real.arcsin_le_pi_div_two (3 / 10)
  have hq : ∀ θ : ℝ, (awayP + 2 * e θ).re = -3 / 5 + 2 * Real.cos θ ∧ (awayP + 2 * e θ).im = 3 / 10 + 2 * Real.sin θ := fun θ => by
    have := awayModel_circPt 2 θ
    simpa using this
  ext θ
  simp only [ArcMap.r2Contacts, mem_setOf_eq, awayModel_region_seven]
  constructor
  · rintro ⟨hθ, hcl⟩
    have hsub : awayW ⊆ {w : ℂ | 0 ≤ w.im ∧ w.im ≤ 3 / 5} := fun w hw => by
      rcases awayModel_mem_awayW.mp hw with ⟨hw, -⟩ | ⟨hw, -⟩
      · exact ⟨hw.2.2.1.le, hw.2.2.2.le⟩
      · exact ⟨hw.2.2.1.le, hw.2.2.2.le⟩
    have him := closure_minimal hsub
      ((isClosed_le continuous_const Complex.continuous_im).and (isClosed_le Complex.continuous_im continuous_const)) hcl
    rw [mem_setOf_eq, (hq θ).2] at him
    have hθ1 : -(π / 2) ≤ θ := by linarith [hθ.1]
    have hθ2 : θ ≤ π / 2 := by linarith [hθ.2]
    have harc : Real.arcsin (Real.sin θ) = θ := Real.arcsin_sin hθ1 hθ2
    constructor
    · rw [← harc, ← Real.arcsin_neg]; exact Real.arcsin_le_arcsin (by linarith [him.1])
    · rw [← harc]; exact Real.arcsin_le_arcsin (by linarith [him.2])
  · intro hθ
    refine ⟨⟨by linarith [hθ.1], by linarith [hθ.2]⟩, ?_⟩
    obtain ⟨hS, hC0, -⟩ := awayModel_trig (s := 3 / 20) (by norm_num) (by norm_num) hθ
    have hsq := Real.sin_sq_add_cos_sq θ
    rw [Metric.mem_closure_iff]
    intro ε hε
    set t := min (1 / 2) ε with ht
    have ht0 : 0 < t := lt_min (by norm_num) hε
    have ht1 : t ≤ 1 / 2 := min_le_left _ _
    obtain ⟨hrect, hfar, hnear⟩ := awayModel_approach_real (C := Real.cos θ) (S := Real.sin θ) (by linarith) hC0 hS ht0 ht1
    refine ⟨⟨-3 / 5 + 2 * Real.cos θ + t * (21 / 10 - 2 * Real.cos θ), 3 / 10 + 2 * Real.sin θ - t * (2 * Real.sin θ)⟩,
      awayModel_mem_awayW.mpr (Or.inr ⟨hrect, ?_⟩), ?_⟩
    · rw [not_le]
      refine (lt_iff_sq_lt_sq' (by norm_num) dist_nonneg).mpr ?_
      rw [awayModel_dist_sq]
      have e1 : -3 / 5 + 2 * Real.cos θ + t * (21 / 10 - 2 * Real.cos θ) + 3 / 5 = 2 * Real.cos θ + t * (21 / 10 - 2 * Real.cos θ) := by
        ring
      have e2 : 3 / 10 + 2 * Real.sin θ - t * (2 * Real.sin θ) - 3 / 10 = 2 * Real.sin θ - t * (2 * Real.sin θ) := by ring
      rw [e1, e2]; linarith
    · refine lt_of_lt_of_le ((lt_iff_sq_lt_sq' dist_nonneg ht0.le).mpr ?_) (min_le_right _ _)
      rw [Complex.dist_eq_re_im, Real.sq_sqrt (by positivity), (hq θ).1, (hq θ).2]
      have e1 : -3 / 5 + 2 * Real.cos θ - (-3 / 5 + 2 * Real.cos θ + t * (21 / 10 - 2 * Real.cos θ)) =
          -(t * (21 / 10 - 2 * Real.cos θ)) := by ring
      have e2 : 3 / 10 + 2 * Real.sin θ - (3 / 10 + 2 * Real.sin θ - t * (2 * Real.sin θ)) = t * (2 * Real.sin θ) := by ring
      rw [e1, e2, neg_sq]; exact hnear

section AwayModelCentre

open ArcMap

/-! ### The centre of `awayModel`'s arc carries the colour `6` alone: the toward bend on a map of the plane (FS131-MB2) -/

/-- **In the centre's brick `(−4/5, 0) × (0, 3/5)` the map is the base**: every point is an interior point of colour `6` (the brick map's
colour of the cell of column `−1` and row `0`). -/
theorem awayModel_centre_brick {w : ℂ} (hw : -(4 / 5) < w.re ∧ w.re < 0 ∧ 0 < w.im ∧ w.im < 3 / 5) : w ∈ awayModel.region 6 := by
  have hnW : w ∉ awayW := fun hW => by
    rcases awayModel_mem_awayW.mp hW with ⟨h', -⟩ | ⟨h', -⟩
    · linarith [hw.2.1, h'.1]
    · linarith [hw.2.1, h'.1]
  have hre : 2 / 5 * ((0 : ℤ) : ℝ) + 4 / 5 * ((-1 : ℤ) : ℝ) < w.re ∧ w.re < 2 / 5 * ((0 : ℤ) : ℝ) + 4 / 5 * (((-1 : ℤ) : ℝ) + 1) := by
    constructor <;> push_cast <;> linarith [hw.1, hw.2.1]
  have him : 3 / 5 * ((0 : ℤ) : ℝ) < w.im ∧ w.im < 3 / 5 * (((0 : ℤ) : ℝ) + 1) := by
    constructor <;> push_cast <;> linarith [hw.2.2.1, hw.2.2.2]
  have hd : dist w awayP < 1 := by
    refine (lt_iff_sq_lt_sq' dist_nonneg zero_le_one).mpr ?_
    rw [awayModel_dist_sq]
    have e1 : (w.re + 3 / 5) ^ 2 < (3 / 5) ^ 2 := sq_lt_sq' (by linarith [hw.1]) (by linarith [hw.2.1])
    have e2 : (w.im - 3 / 10) ^ 2 < (3 / 10) ^ 2 := sq_lt_sq' (by linarith [hw.2.2.1]) (by linarith [hw.2.2.2])
    nlinarith
  refine ⟨?_, ?_⟩
  · unfold awayModel
    rw [ArcMap.interiorPts_paint]
    refine ⟨brickBase_mem_interiorPts _ hre him, fun ha => ?_⟩
    rcases awayModel_arcs_subset ha with h | h <;> linarith
  · have hc : awayModel.col w = (brickBase 8 (by norm_num)).col w := ArcMap.paint_col_of_not_mem hnW
    obtain ⟨h1, h2⟩ := brick_floor_eq hre him
    have h6 : sevenBrick.table (zmodIdx 7 (by norm_num) (-1)) (zmodIdx 7 (by norm_num) 0) = 6 := by decide
    show awayModel.col w = 6
    rw [hc]
    show Fin.castLE (by norm_num) (sevenBrickMap.col w) = 6
    rw [sevenBrick_color_eq h1 h2, h6]
    rfl

/-- **The centre carries the colour `6` and no other**: neither side colour of the arc is carried at it. -/
theorem awayModel_coloursAt : awayModel.coloursAt awayP = {6} := by
  set U : Set ℂ := {w : ℂ | -(4 / 5) < w.re ∧ w.re < 0 ∧ 0 < w.im ∧ w.im < 3 / 5} with hU
  have hUo : IsOpen U := awayModel_isOpen_rect (-(4 / 5)) 0
  have hPU : awayP ∈ U := by
    obtain ⟨h1, h2⟩ := awayModel_P_coords
    show -(4 / 5) < awayP.re ∧ awayP.re < 0 ∧ 0 < awayP.im ∧ awayP.im < 3 / 5
    rw [h1, h2]; norm_num
  ext j
  simp only [ArcMap.coloursAt, mem_setOf_eq, mem_singleton_iff]
  constructor
  · intro h
    obtain ⟨w, hwU, hw⟩ := mem_closure_iff.mp h U hUo hPU
    have h6 : awayModel.col w = 6 := (awayModel_centre_brick hwU).2
    have hj : awayModel.col w = j := hw.2
    rw [← hj, h6]
  · rintro rfl
    exact subset_closure (awayModel_centre_brick hPU)

end AwayModelCentre

/-- **A model of `bend_toward` on a map of the plane**: the toward bend applied to `awayModel`'s arc of `ω(awayP)`. The centre carries a
colour (`6`: `awayModel_coloursAt`) and not the arc's outer colour `0` — where `cuspFrag_bend_toward`'s centre is off its fragment and
carries no colour at all. -/
theorem awayModel_bend_toward : ∃ F' : ArcMap 8, F'.Valid ∧
    ∀ θ ∈ Ioo (-(Real.arcsin (3 / 10))) (Real.arcsin (3 / 10)), ¬ F'.OnRingArc awayP (ringPt awayP θ) := by
  obtain ⟨F', h1, -, -, h2, -⟩ := ArcMap.bend_toward awayModel_hyps.1 awayModel_hyps.2.2.1
    (by rw [awayModel_coloursAt]; decide) one_pos
  exact ⟨F', h1, h2⟩

end HadwigerNelson.Plane.Scratch
