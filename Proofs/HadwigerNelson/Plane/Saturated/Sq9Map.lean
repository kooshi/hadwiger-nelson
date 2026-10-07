import Proofs.HadwigerNelson.Plane.Saturated.Basic

/-!
# `sq9` as a map of the plane (FS-131 wave 6, FS131-I6B)

The half-square nine-colouring `sq9` (`Plane/Cover`; FS111-W-SQ9) as an `ArcMap 9`: the domain is the plane, the arcs are
the edges of the half-integer grid (the bottom and the left edge of each square, as segments), the colour is `sq9Col`. It is
the model the wave's map statements owe: a plane map bounded by segments whose regions are, up to the null grid, the classes
of a saturated colouring (`sq9_tight_saturated`).

* `sq9Map`, `sq9Map_isPlaneMap`, `mem_sq9Grid_iff` (the arcs cover exactly the points with `2 re z ∈ ℤ` or `2 im z ∈ ℤ`),
  `volume_sq9Grid`, `sq9Map_region_ae` (`sq9.cls j =ᵐ sq9Map.region j`).
* At the edge point `sqEdgePt = 1/2 + i/4` (`Plane/Saturated/Basic`): in `B(sqEdgePt, 1/8)` the interior points are the
  points off the line `re z = 1/2` (`sqEdge_mem_interiorPts`), the left half lies in `region sqColA` and the right half in
  `region sqColB`; the point is in both closures and the ball in their union.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

/-- The lower-left corner `n/2 + i m/2` of the grid square `(n, m)`. -/
noncomputable def sq9Corner (n m : ℤ) : ℂ := ⟨(n : ℝ) / 2, (m : ℝ) / 2⟩

/-- The edges of the half-integer grid: the bottom and the left edge of each square. -/
def sq9Arcs : Set Arc :=
  ⋃ (n : ℤ) (m : ℤ), {Arc.seg (sq9Corner n m) (sq9Corner (n + 1) m), Arc.seg (sq9Corner n m) (sq9Corner n (m + 1))}

theorem mem_sq9Arcs {a : Arc} : a ∈ sq9Arcs ↔ ∃ n m : ℤ, a = Arc.seg (sq9Corner n m) (sq9Corner (n + 1) m) ∨
    a = Arc.seg (sq9Corner n m) (sq9Corner n (m + 1)) := by
  simp only [sq9Arcs, mem_iUnion, mem_insert_iff, mem_singleton_iff]

/-- The bottom edge of the square `(n, m)`. -/
theorem mem_sq9_bottom {n m : ℤ} {p : ℂ} : p ∈ segment ℝ (sq9Corner n m) (sq9Corner (n + 1) m) ↔
    p.im = (m : ℝ) / 2 ∧ (n : ℝ) / 2 ≤ p.re ∧ p.re ≤ ((n : ℝ) + 1) / 2 := by
  constructor
  · rintro ⟨s, t, hs, ht, hst, rfl⟩
    simp only [sq9Corner, Complex.add_re, Complex.add_im, Complex.real_smul, Complex.mul_re, Complex.mul_im,
      Complex.ofReal_re, Complex.ofReal_im, zero_mul, sub_zero, add_zero, Int.cast_add, Int.cast_one]
    have hs' : s = 1 - t := by linarith
    subst hs'
    exact ⟨by ring, by linarith, by linarith⟩
  · rintro ⟨him, h1, h2⟩
    refine ⟨(n : ℝ) + 1 - 2 * p.re, 2 * p.re - n, by linarith, by linarith, by ring, ?_⟩
    apply Complex.ext
    · simp only [sq9Corner, Complex.add_re, Complex.real_smul, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im,
        zero_mul, sub_zero, Int.cast_add, Int.cast_one]
      ring
    · simp only [sq9Corner, Complex.add_im, Complex.real_smul, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im,
        zero_mul, add_zero, him]
      ring

/-- The left edge of the square `(n, m)`. -/
theorem mem_sq9_left {n m : ℤ} {p : ℂ} : p ∈ segment ℝ (sq9Corner n m) (sq9Corner n (m + 1)) ↔
    p.re = (n : ℝ) / 2 ∧ (m : ℝ) / 2 ≤ p.im ∧ p.im ≤ ((m : ℝ) + 1) / 2 := by
  constructor
  · rintro ⟨s, t, hs, ht, hst, rfl⟩
    simp only [sq9Corner, Complex.add_re, Complex.add_im, Complex.real_smul, Complex.mul_re, Complex.mul_im,
      Complex.ofReal_re, Complex.ofReal_im, zero_mul, sub_zero, add_zero, Int.cast_add, Int.cast_one]
    have hs' : s = 1 - t := by linarith
    subst hs'
    exact ⟨by ring, by linarith, by linarith⟩
  · rintro ⟨hre, h1, h2⟩
    refine ⟨(m : ℝ) + 1 - 2 * p.im, 2 * p.im - m, by linarith, by linarith, by ring, ?_⟩
    apply Complex.ext
    · simp only [sq9Corner, Complex.add_re, Complex.real_smul, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im,
        zero_mul, sub_zero, hre]
      ring
    · simp only [sq9Corner, Complex.add_im, Complex.real_smul, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im,
        zero_mul, add_zero, Int.cast_add, Int.cast_one]
      ring

/-- **The grid**: the arcs cover exactly the points with `2 re z` or `2 im z` an integer. -/
theorem mem_sq9Grid_iff {z : ℂ} :
    z ∈ ⋃ a ∈ sq9Arcs, a.carrier ↔ (∃ n : ℤ, 2 * z.re = n) ∨ ∃ m : ℤ, 2 * z.im = m := by
  constructor
  · intro hz
    obtain ⟨a, ha, hza⟩ := mem_iUnion₂.1 hz
    obtain ⟨n, m, rfl | rfl⟩ := mem_sq9Arcs.1 ha
    · exact Or.inr ⟨m, by have := (mem_sq9_bottom.1 hza).1; linarith⟩
    · exact Or.inl ⟨n, by have := (mem_sq9_left.1 hza).1; linarith⟩
  · rintro (⟨n, hn⟩ | ⟨m, hm⟩)
    · refine mem_iUnion₂.2 ⟨Arc.seg (sq9Corner n ⌊2 * z.im⌋) (sq9Corner n (⌊2 * z.im⌋ + 1)),
        mem_sq9Arcs.2 ⟨n, ⌊2 * z.im⌋, Or.inr rfl⟩, mem_sq9_left.2 ⟨by linarith, ?_, ?_⟩⟩
      · have := Int.floor_le (2 * z.im); linarith
      · have := Int.lt_floor_add_one (2 * z.im); linarith
    · refine mem_iUnion₂.2 ⟨Arc.seg (sq9Corner ⌊2 * z.re⌋ m) (sq9Corner (⌊2 * z.re⌋ + 1) m),
        mem_sq9Arcs.2 ⟨⌊2 * z.re⌋, m, Or.inl rfl⟩, mem_sq9_bottom.2 ⟨by linarith, ?_, ?_⟩⟩
      · have := Int.floor_le (2 * z.re); linarith
      · have := Int.lt_floor_add_one (2 * z.re); linarith

/-- Every grid edge has positive length. -/
theorem sq9Arcs_nondegenerate : ∀ a ∈ sq9Arcs, a.Nondegenerate := by
  intro a ha
  obtain ⟨n, m, rfl | rfl⟩ := mem_sq9Arcs.1 ha
  · show sq9Corner n m ≠ sq9Corner (n + 1) m
    intro h
    have := congrArg Complex.re h
    simp only [sq9Corner, Int.cast_add, Int.cast_one] at this
    linarith
  · show sq9Corner n m ≠ sq9Corner n (m + 1)
    intro h
    have := congrArg Complex.im h
    simp only [sq9Corner, Int.cast_add, Int.cast_one] at this
    linarith

/-- Only finitely many grid edges meet a unit ball. -/
theorem sq9Arcs_locallyFinite :
    ∀ x ∈ (univ : Set ℂ), ∃ t ∈ 𝓝 x, {a | a ∈ sq9Arcs ∧ (a.carrier ∩ t).Nonempty}.Finite := by
  intro x _
  refine ⟨ball x 1, ball_mem_nhds x one_pos, ?_⟩
  let f : ℤ × ℤ × Bool → Arc := fun q =>
    if q.2.2 then Arc.seg (sq9Corner q.1 q.2.1) (sq9Corner (q.1 + 1) q.2.1)
    else Arc.seg (sq9Corner q.1 q.2.1) (sq9Corner q.1 (q.2.1 + 1))
  have hfin : (Icc (⌊2 * x.re⌋ - 3) (⌊2 * x.re⌋ + 3) ×ˢ Icc (⌊2 * x.im⌋ - 3) (⌊2 * x.im⌋ + 3) ×ˢ
      (univ : Set Bool)).Finite := (finite_Icc _ _).prod ((finite_Icc _ _).prod finite_univ)
  refine (hfin.image f).subset ?_
  rintro a ⟨ha, p, hpa, hpx⟩
  rw [mem_ball, dist_eq_norm] at hpx
  have hre := lt_of_le_of_lt (Complex.abs_re_le_norm (p - x)) hpx
  have him := lt_of_le_of_lt (Complex.abs_im_le_norm (p - x)) hpx
  rw [Complex.sub_re, abs_lt] at hre
  rw [Complex.sub_im, abs_lt] at him
  have f1 := Int.floor_le (2 * x.re)
  have f2 := Int.lt_floor_add_one (2 * x.re)
  have f3 := Int.floor_le (2 * x.im)
  have f4 := Int.lt_floor_add_one (2 * x.im)
  obtain ⟨n, m, rfl | rfl⟩ := mem_sq9Arcs.1 ha
  · obtain ⟨h0, h1, h2⟩ := mem_sq9_bottom.1 hpa
    have k1 : (⌊2 * x.re⌋ : ℝ) - 3 < n := by linarith
    have k2 : (n : ℝ) < ⌊2 * x.re⌋ + 3 := by linarith
    have k3 : (⌊2 * x.im⌋ : ℝ) - 3 < m := by linarith
    have k4 : (m : ℝ) < ⌊2 * x.im⌋ + 3 := by linarith
    have l1 : ⌊2 * x.re⌋ - 3 < n := by exact_mod_cast k1
    have l2 : n < ⌊2 * x.re⌋ + 3 := by exact_mod_cast k2
    have l3 : ⌊2 * x.im⌋ - 3 < m := by exact_mod_cast k3
    have l4 : m < ⌊2 * x.im⌋ + 3 := by exact_mod_cast k4
    exact ⟨(n, m, true), ⟨⟨l1.le, l2.le⟩, ⟨l3.le, l4.le⟩, mem_univ _⟩, by simp [f]⟩
  · obtain ⟨h0, h1, h2⟩ := mem_sq9_left.1 hpa
    have k1 : (⌊2 * x.re⌋ : ℝ) - 3 < n := by linarith
    have k2 : (n : ℝ) < ⌊2 * x.re⌋ + 3 := by linarith
    have k3 : (⌊2 * x.im⌋ : ℝ) - 3 < m := by linarith
    have k4 : (m : ℝ) < ⌊2 * x.im⌋ + 3 := by linarith
    have l1 : ⌊2 * x.re⌋ - 3 < n := by exact_mod_cast k1
    have l2 : n < ⌊2 * x.re⌋ + 3 := by exact_mod_cast k2
    have l3 : ⌊2 * x.im⌋ - 3 < m := by exact_mod_cast k3
    have l4 : m < ⌊2 * x.im⌋ + 3 := by exact_mod_cast k4
    exact ⟨(n, m, false), ⟨⟨l1.le, l2.le⟩, ⟨l3.le, l4.le⟩, mem_univ _⟩, by simp [f]⟩

/-- `sq9Col` is locally constant off the grid. -/
theorem sq9Col_locallyConstant : ∀ x ∈ (univ : Set ℂ), x ∉ ⋃ a ∈ sq9Arcs, a.carrier →
    ∀ᶠ y in 𝓝 x, sq9Col y = sq9Col x := by
  intro x _ hx
  rw [mem_sq9Grid_iff, not_or, not_exists, not_exists] at hx
  -- the floor is locally constant off the integers (`eventually_floor_eq` of `Plane/SVMap`, not upstream of this module)
  have hfl : ∀ {t : ℝ}, (∀ n : ℤ, t ≠ n) → ∀ᶠ u in 𝓝 t, ⌊u⌋ = ⌊t⌋ := by
    intro t ht
    have h1 : (⌊t⌋ : ℝ) < t := lt_of_le_of_ne (Int.floor_le t) (Ne.symm (ht _))
    have h2 : t < ⌊t⌋ + 1 := Int.lt_floor_add_one t
    filter_upwards [Ioo_mem_nhds h1 h2] with u hu
    rw [Int.floor_eq_iff]
    exact ⟨hu.1.le, hu.2⟩
  have h1 : ∀ᶠ y : ℂ in 𝓝 x, ⌊2 * y.re⌋ = ⌊2 * x.re⌋ :=
    ((continuous_const.mul Complex.continuous_re).tendsto x).eventually (hfl hx.1)
  have h2 : ∀ᶠ y : ℂ in 𝓝 x, ⌊2 * y.im⌋ = ⌊2 * x.im⌋ :=
    ((continuous_const.mul Complex.continuous_im).tendsto x).eventually (hfl hx.2)
  filter_upwards [h1, h2] with y hy1 hy2
  simp only [sq9Col, sq9Index, hy1, hy2]

/-- **`sq9` as a map of the plane**: the half-integer grid's edges as segments, coloured by `sq9Col`. -/
noncomputable def sq9Map : ArcMap 9 where
  dom := univ
  isOpen_dom := isOpen_univ
  arcs := sq9Arcs
  nondegenerate := sq9Arcs_nondegenerate
  locallyFinite := sq9Arcs_locallyFinite
  col := sq9Col
  locallyConstant := sq9Col_locallyConstant

/-- `sq9Map` is a map of the plane. -/
theorem sq9Map_isPlaneMap : sq9Map.IsPlaneMap := rfl

/-- The interior points of `sq9Map` are the points off the grid. -/
theorem mem_sq9Map_interiorPts {z : ℂ} :
    z ∈ sq9Map.interiorPts ↔ (∀ n : ℤ, 2 * z.re ≠ n) ∧ ∀ m : ℤ, 2 * z.im ≠ m := by
  have h : z ∈ sq9Map.interiorPts ↔ z ∉ ⋃ a ∈ sq9Arcs, a.carrier :=
    ⟨fun h => h.2, fun h => ⟨mem_univ z, h⟩⟩
  rw [h, mem_sq9Grid_iff, not_or, not_exists, not_exists]

/-- The grid is null. -/
theorem volume_sq9Grid : volume (⋃ a ∈ sq9Arcs, a.carrier) = 0 := by
  have hc : sq9Arcs.Countable := countable_iUnion fun n => countable_iUnion fun m => (Set.toFinite _).countable
  exact (measure_biUnion_null_iff hc).2 fun a _ => a.volume_carrier

/-- **The regions of `sq9Map` are the classes of `sq9`**, up to the null grid. -/
theorem sq9Map_region_ae (j : Fin 9) : sq9.cls j =ᵐ[volume] sq9Map.region j := by
  have hsub : sq9Map.region j ⊆ sq9.cls j := fun z hz => hz.2
  rw [ae_eq_set]
  refine ⟨measure_mono_null (fun z hz => ?_) volume_sq9Grid, by rw [Set.sdiff_eq_empty.2 hsub]; exact measure_empty⟩
  by_contra hno
  exact hz.2 ⟨⟨mem_univ z, hno⟩, hz.1⟩

/-! ## At the edge point -/

/-- In `B(sqEdgePt, 1/8)` the interior points of `sq9Map` are the points off the line `re z = 1/2`. -/
theorem sqEdge_mem_interiorPts {z : ℂ} (hz : z ∈ ball sqEdgePt (1 / 8)) (hre : z.re ≠ 1 / 2) :
    z ∈ sq9Map.interiorPts := by
  obtain ⟨h1, h2⟩ := sqEdge_coords hz
  rw [abs_lt] at h1 h2
  rw [mem_sq9Map_interiorPts]
  constructor
  · intro n hn
    have a1 : (0 : ℝ) < n := by linarith
    have a2 : (n : ℝ) < 2 := by linarith
    have b1 : 0 < n := by exact_mod_cast a1
    have b2 : n < 2 := by exact_mod_cast a2
    have hn1 : n = 1 := by omega
    rw [hn1] at hn
    push_cast at hn
    exact hre (by linarith)
  · intro m hm
    have a1 : (0 : ℝ) < m := by linarith
    have a2 : (m : ℝ) < 1 := by linarith
    have b1 : 0 < m := by exact_mod_cast a1
    have b2 : m < 1 := by exact_mod_cast a2
    omega

/-- Spec, the other way: the edge point itself is on the grid. -/
example : sqEdgePt ∉ sq9Map.interiorPts := by
  rw [mem_sq9Map_interiorPts]
  exact fun h => h.1 1 (by norm_num [sqEdgePt])

/-- The left half of `B(sqEdgePt, 1/8)` lies in the region of `sqColA`. -/
theorem sqEdge_left_subset_region :
    ball sqEdgePt (1 / 8) ∩ {z : ℂ | 0 < (-1 : ℝ) * (z.re - 1 / 2)} ⊆ sq9Map.region sqColA := by
  rintro z ⟨hz, hlt⟩
  have hre : z.re < 1 / 2 := by simp only [mem_setOf_eq] at hlt; linarith
  exact ⟨sqEdge_mem_interiorPts hz hre.ne, by show sq9Col z = sqColA; rw [sq9Col_near_edge hz, if_pos hre]⟩

/-- The right half of `B(sqEdgePt, 1/8)` lies in the region of `sqColB`. -/
theorem sqEdge_right_subset_region :
    ball sqEdgePt (1 / 8) ∩ {z : ℂ | 0 < (1 : ℝ) * (z.re - 1 / 2)} ⊆ sq9Map.region sqColB := by
  rintro z ⟨hz, hlt⟩
  have hre : 1 / 2 < z.re := by simp only [mem_setOf_eq] at hlt; linarith
  exact ⟨sqEdge_mem_interiorPts hz hre.ne', by
    show sq9Col z = sqColB; rw [sq9Col_near_edge hz, if_neg (not_lt.2 hre.le)]⟩

/-- The edge point is in the closures of the regions of both squares' colours. -/
theorem sqEdgePt_mem_closure_regions :
    sqEdgePt ∈ closure (sq9Map.region sqColA) ∩ closure (sq9Map.region sqColB) :=
  ⟨closure_mono sqEdge_left_subset_region (sqEdgePt_mem_closure_half (-1) (Or.inr rfl)),
    closure_mono sqEdge_right_subset_region (sqEdgePt_mem_closure_half 1 (Or.inl rfl))⟩

/-- Near the edge point no third colour has closure: `B(sqEdgePt, 1/8)` lies in the two closures. -/
theorem sqEdge_ball_subset_closure_regions :
    ball sqEdgePt (1 / 8) ⊆ closure (sq9Map.region sqColA) ∪ closure (sq9Map.region sqColB) := by
  intro z hz
  rw [← closure_union]
  have h1 : z ∈ ball sqEdgePt (1 / 8) ∩ closure sq9Map.interiorPts :=
    ⟨hz, sq9Map.dense_interiorPts (mem_univ z)⟩
  refine closure_mono ?_ (isOpen_ball.inter_closure h1)
  rintro w ⟨hw, hwI⟩
  have hcol : sq9Col w = if w.re < 1 / 2 then sqColA else sqColB := sq9Col_near_edge hw
  by_cases h : w.re < 1 / 2
  · exact Or.inl ⟨hwI, by show sq9Col w = sqColA; rw [hcol, if_pos h]⟩
  · exact Or.inr ⟨hwI, by show sq9Col w = sqColB; rw [hcol, if_neg h]⟩

end HadwigerNelson.Plane
