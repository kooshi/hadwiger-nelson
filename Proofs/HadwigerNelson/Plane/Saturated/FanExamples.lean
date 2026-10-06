import Proofs.HadwigerNelson.Plane.Saturated.Fan

/-!
# The fan's inhabitant: `sq9` at a grid vertex (FS-131 wave 6)

`sq9` — the nine-colouring by squares of side `1/2` (wave 2, `Plane/Cover`; saturated: `sq9_tight_saturated`) — at the
vertex `sqVertex = 1/2 + i/2`, in the disc of radius `1/4` (FS131-E8's model for FS131-E8-FAN,
`plans/FS131-E8-derivation.md` § 3.6):

* `sq9Col_near_vertex` — the colour is read from the two sides; `sqQuad b b'` are the four quadrants' colours, distinct.
* `sq9_not_isCuspAt_near_vertex` — no cusp near the vertex; `sq9_axis_of_mem_essBdry`, `sq9_mem_essBdry_of_re`,
  `sq9_mem_essBdry_of_im` — the essential boundary is the two axes; `sq9_twoColourNhd_of_re`, `sq9_twoColourNhd_of_im` —
  every axis point but the vertex has a two-colour ball; `sqVertex_mem_singularSet` — the vertex is singular.
* **`sq9Fan : sq9.Fan sqVertex`** — four branches along the half-axes (constant angles `0, π/2, π, 3π/2`), four regions
  of four colours; `sq9Fan_hasSector` (each a sector of angle `π/2`), `sq9Fan_not_hasHorn`.

So the hypotheses "a fan at `z`", "`z ∈ Σ`", "`Σ ∩ B(z, R) ⊆ {z}`" and "saturated" are met together, at `k = 9`.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

/-! ## `sq9` near the grid vertex `1/2 + i/2` -/

/-- The grid vertex `1/2 + i/2` of `sq9`, where four squares of four colours meet. -/
noncomputable def sqVertex : ℂ := ⟨1 / 2, 1 / 2⟩

/-- The colour of the quadrant at `sqVertex`: `b` for `re ≥ 1/2`, `b'` for `im ≥ 1/2`. -/
def sqQuad (b b' : Bool) : Fin 9 := finProdFinEquiv ((if b then 1 else 0 : ZMod 3), (if b' then 1 else 0 : ZMod 3))

/-- The sign of a side: `1` for `true`, `-1` for `false`. -/
def sqSg : Bool → ℝ
  | true => 1
  | false => -1

/-- The four quadrants have four colours. -/
theorem sqQuad_inj : ∀ {b₁ b₁' b₂ b₂' : Bool}, sqQuad b₁ b₁' = sqQuad b₂ b₂' → b₁ = b₂ ∧ b₁' = b₂' := by decide

/-- Coordinates of a point of `B(sqVertex, 1/4)`. -/
theorem sqVertex_coords {z : ℂ} (hz : z ∈ ball sqVertex (1 / 4)) :
    |z.re - 1 / 2| < 1 / 4 ∧ |z.im - 1 / 2| < 1 / 4 := by
  rw [mem_ball, dist_eq_norm] at hz
  have h1 := abs_re_le_norm (z - sqVertex)
  have h2 := abs_im_le_norm (z - sqVertex)
  rw [Complex.sub_re] at h1
  rw [Complex.sub_im] at h2
  exact ⟨lt_of_le_of_lt h1 hz, lt_of_le_of_lt h2 hz⟩

/-- In `B(sqVertex, 1/4)` the colour of `sq9` is read from the two sides. -/
theorem sq9Col_near_vertex {z : ℂ} (hz : z ∈ ball sqVertex (1 / 4)) :
    sq9Col z = sqQuad (decide (1 / 2 ≤ z.re)) (decide (1 / 2 ≤ z.im)) := by
  obtain ⟨hre, him⟩ := sqVertex_coords hz
  obtain ⟨h1, h2⟩ := abs_lt.mp hre
  obtain ⟨h3, h4⟩ := abs_lt.mp him
  have fre : ⌊2 * z.re⌋ = if 1 / 2 ≤ z.re then 1 else 0 := by
    split_ifs with h
    · exact Int.floor_eq_iff.mpr ⟨by push_cast; linarith, by push_cast; linarith⟩
    · have h' := not_le.1 h
      exact Int.floor_eq_iff.mpr ⟨by push_cast; linarith, by push_cast; linarith⟩
  have fim : ⌊2 * z.im⌋ = if 1 / 2 ≤ z.im then 1 else 0 := by
    split_ifs with h
    · exact Int.floor_eq_iff.mpr ⟨by push_cast; linarith, by push_cast; linarith⟩
    · have h' := not_le.1 h
      exact Int.floor_eq_iff.mpr ⟨by push_cast; linarith, by push_cast; linarith⟩
  rw [sq9Col_of_floor fre fim]
  simp [sqQuad]

/-- The side of a coordinate, read by `decide`, is a closed side. -/
theorem sqSg_decide_mul_nonneg (x : ℝ) : 0 ≤ sqSg (decide (1 / 2 ≤ x)) * (x - 1 / 2) := by
  by_cases h : 1 / 2 ≤ x
  · rw [decide_eq_true h]
    show 0 ≤ (1 : ℝ) * (x - 1 / 2)
    linarith
  · rw [decide_eq_false h]
    show 0 ≤ (-1 : ℝ) * (x - 1 / 2)
    linarith [not_le.1 h]

/-- A point of `B(sqVertex, 1/4)` in a closed quadrant has positive upper density for the quadrant's colour. -/
theorem sq9_essClosure_of_quad {w : ℂ} (hw : w ∈ ball sqVertex (1 / 4)) {b b' : Bool}
    (h : 0 ≤ sqSg b * (w.re - 1 / 2)) (h' : 0 ≤ sqSg b' * (w.im - 1 / 2)) :
    w ∈ essClosure (sq9.cls (sqQuad b b')) := by
  obtain ⟨hre, him⟩ := sqVertex_coords hw
  obtain ⟨h1, h2⟩ := abs_lt.mp hre
  obtain ⟨h3, h4⟩ := abs_lt.mp him
  have key : ∀ n m : ℤ, w ∈ sq9Sq n m → finProdFinEquiv ((n : ZMod 3), (m : ZMod 3)) = sqQuad b b' →
      w ∈ essClosure (sq9.cls (sqQuad b b')) := fun n m hsq hcol => hcol ▸ sq9Sq_subset_essClosure n m hsq
  cases b <;> cases b'
  · have a1 : 0 ≤ (-1 : ℝ) * (w.re - 1 / 2) := h
    have a2 : 0 ≤ (-1 : ℝ) * (w.im - 1 / 2) := h'
    exact key 0 0 ⟨by push_cast; linarith, by push_cast; linarith, by push_cast; linarith, by push_cast; linarith⟩
      (by simp [sqQuad])
  · have a1 : 0 ≤ (-1 : ℝ) * (w.re - 1 / 2) := h
    have a2 : 0 ≤ (1 : ℝ) * (w.im - 1 / 2) := h'
    exact key 0 1 ⟨by push_cast; linarith, by push_cast; linarith, by push_cast; linarith, by push_cast; linarith⟩
      (by simp [sqQuad])
  · have a1 : 0 ≤ (1 : ℝ) * (w.re - 1 / 2) := h
    have a2 : 0 ≤ (-1 : ℝ) * (w.im - 1 / 2) := h'
    exact key 1 0 ⟨by push_cast; linarith, by push_cast; linarith, by push_cast; linarith, by push_cast; linarith⟩
      (by simp [sqQuad])
  · have a1 : 0 ≤ (1 : ℝ) * (w.re - 1 / 2) := h
    have a2 : 0 ≤ (1 : ℝ) * (w.im - 1 / 2) := h'
    exact key 1 1 ⟨by push_cast; linarith, by push_cast; linarith, by push_cast; linarith, by push_cast; linarith⟩
      (by simp [sqQuad])

/-- Near the vertex, a point of the support of a class lies in a closed quadrant of that class's colour. -/
theorem sq9_essSupport_near_vertex {w : ℂ} (hw : w ∈ ball sqVertex (1 / 4)) {j : Fin 9}
    (hj : w ∈ essSupport (sq9.cls j)) :
    ∃ b b' : Bool, sqQuad b b' = j ∧ 0 ≤ sqSg b * (w.re - 1 / 2) ∧ 0 ≤ sqSg b' * (w.im - 1 / 2) := by
  set K : Set ℂ := ⋃ p : Bool × Bool,
    {z : ℂ | sqQuad p.1 p.2 = j ∧ 0 ≤ sqSg p.1 * (z.re - 1 / 2) ∧ 0 ≤ sqSg p.2 * (z.im - 1 / 2)} with hKdef
  have hK : IsClosed K := by
    refine isClosed_iUnion_of_finite fun p => ?_
    by_cases hp : sqQuad p.1 p.2 = j
    · have hset : {z : ℂ | sqQuad p.1 p.2 = j ∧ 0 ≤ sqSg p.1 * (z.re - 1 / 2) ∧ 0 ≤ sqSg p.2 * (z.im - 1 / 2)} =
          {z : ℂ | 0 ≤ sqSg p.1 * (z.re - 1 / 2)} ∩ {z : ℂ | 0 ≤ sqSg p.2 * (z.im - 1 / 2)} := by
        ext z
        simp only [mem_setOf_eq, mem_inter_iff, hp, true_and]
      rw [hset]
      exact (isClosed_le continuous_const (continuous_const.mul (Complex.continuous_re.sub continuous_const))).inter
        (isClosed_le continuous_const (continuous_const.mul (Complex.continuous_im.sub continuous_const)))
    · have hset : {z : ℂ | sqQuad p.1 p.2 = j ∧ 0 ≤ sqSg p.1 * (z.re - 1 / 2) ∧ 0 ≤ sqSg p.2 * (z.im - 1 / 2)} = ∅ := by
        ext z
        simp only [mem_setOf_eq, hp, false_and, mem_empty_iff_false]
      rw [hset]
      exact isClosed_empty
  have hsub : sq9.cls j ∩ ball sqVertex (1 / 4) ⊆ K := by
    rintro z ⟨hzj, hzb⟩
    refine mem_iUnion.2 ⟨(decide (1 / 2 ≤ z.re), decide (1 / 2 ≤ z.im)), ?_, sqSg_decide_mul_nonneg _,
      sqSg_decide_mul_nonneg _⟩
    rw [← sq9Col_near_vertex hzb]
    exact hzj
  have hmem : w ∈ closure (sq9.cls j ∩ ball sqVertex (1 / 4)) := by
    rw [Metric.mem_closure_iff]
    intro ε hε
    rw [mem_ball] at hw
    have hδ : 0 < min ε (1 / 4 - dist w sqVertex) := lt_min hε (by linarith)
    obtain ⟨z, hzj, hzb⟩ := nonempty_of_measure_ne_zero (ne_of_gt (hj _ hδ))
    rw [mem_ball] at hzb
    have t1 := min_le_left ε (1 / 4 - dist w sqVertex)
    have t2 := min_le_right ε (1 / 4 - dist w sqVertex)
    have t3 := dist_triangle z w sqVertex
    exact ⟨z, ⟨hzj, by rw [mem_ball]; linarith⟩, by rw [dist_comm]; linarith⟩
  obtain ⟨p, hp, h1, h2⟩ := mem_iUnion.1 (closure_minimal hsub hK hmem)
  exact ⟨p.1, p.2, hp, h1, h2⟩

/-- **`sq9` has no cusp near the vertex**: a point of the support of a class has positive upper density for it. -/
theorem sq9_not_isCuspAt_near_vertex {w : ℂ} (hw : w ∈ ball sqVertex (1 / 4)) (j : Fin 9) :
    ¬ IsCuspAt (sq9.cls j) w := by
  rintro ⟨hs, hn⟩
  obtain ⟨b, b', rfl, h1, h2⟩ := sq9_essSupport_near_vertex hw hs
  exact hn (sq9_essClosure_of_quad hw h1 h2)

/-- A point of `B(sqVertex, 1/4)` in two closed quadrants of different colours is an essential boundary point. -/
theorem sq9_mem_essBdry_of_quads {w : ℂ} (hw : w ∈ ball sqVertex (1 / 4)) {b₁ b₁' b₂ b₂' : Bool}
    (hne : sqQuad b₁ b₁' ≠ sqQuad b₂ b₂') (h1 : 0 ≤ sqSg b₁ * (w.re - 1 / 2)) (h1' : 0 ≤ sqSg b₁' * (w.im - 1 / 2))
    (h2 : 0 ≤ sqSg b₂ * (w.re - 1 / 2)) (h2' : 0 ≤ sqSg b₂' * (w.im - 1 / 2)) : w ∈ sq9.essBdry :=
  mem_iUnion.2 ⟨sqQuad b₁ b₁', sq9_essClosure_of_quad hw h1 h1', fun hd =>
    notMem_essClosure_of_mem_densitySet (sq9.measurableSet_cls _) (sq9.pairwise_disjoint_cls hne) hd
      (sq9_essClosure_of_quad hw h2 h2')⟩

/-- A point of the vertical axis near the vertex is an essential boundary point. -/
theorem sq9_mem_essBdry_of_re {w : ℂ} (hw : w ∈ ball sqVertex (1 / 4)) (hre : w.re = 1 / 2) : w ∈ sq9.essBdry := by
  refine sq9_mem_essBdry_of_quads hw (b₁ := false) (b₁' := decide (1 / 2 ≤ w.im)) (b₂ := true)
    (b₂' := decide (1 / 2 ≤ w.im)) (fun h => absurd (sqQuad_inj h).1 (by decide)) ?_ (sqSg_decide_mul_nonneg _) ?_
    (sqSg_decide_mul_nonneg _) <;> rw [hre] <;> simp

/-- A point of the horizontal axis near the vertex is an essential boundary point. -/
theorem sq9_mem_essBdry_of_im {w : ℂ} (hw : w ∈ ball sqVertex (1 / 4)) (him : w.im = 1 / 2) : w ∈ sq9.essBdry := by
  refine sq9_mem_essBdry_of_quads hw (b₁ := decide (1 / 2 ≤ w.re)) (b₁' := false) (b₂ := decide (1 / 2 ≤ w.re))
    (b₂' := true) (fun h => absurd (sqQuad_inj h).2 (by decide)) (sqSg_decide_mul_nonneg _) ?_
    (sqSg_decide_mul_nonneg _) ?_ <;> rw [him] <;> simp

/-- Near the vertex, an essential boundary point lies on one of the two axes. -/
theorem sq9_axis_of_mem_essBdry {w : ℂ} (hw : w ∈ ball sqVertex (1 / 4)) (hb : w ∈ sq9.essBdry) :
    w.re = 1 / 2 ∨ w.im = 1 / 2 := by
  obtain ⟨j, hj⟩ := mem_iUnion.1 hb
  obtain ⟨n, m, rfl, hsq⟩ := sq9_essClosure_subset hj.1
  obtain ⟨hre, him⟩ := sqVertex_coords hw
  obtain ⟨h1, h2⟩ := abs_lt.mp hre
  obtain ⟨h3, h4⟩ := abs_lt.mp him
  have int1 : ∀ {q : ℤ} {x : ℝ}, x = q / 2 → -(1 / 4) < x - 1 / 2 → x - 1 / 2 < 1 / 4 → x = 1 / 2 := by
    intro q x hx l1 l2
    have a1 : (0 : ℝ) < q := by linarith
    have a2 : (q : ℝ) < 2 := by linarith
    have b1 : 0 < q := by exact_mod_cast a1
    have b2 : q < 2 := by exact_mod_cast a2
    have hq : q = 1 := by omega
    rw [hx, hq]; norm_num
  have int2 : ∀ {q : ℤ} {x : ℝ}, x = (q + 1) / 2 → -(1 / 4) < x - 1 / 2 → x - 1 / 2 < 1 / 4 → x = 1 / 2 := by
    intro q x hx l1 l2
    have a1 : (-1 : ℝ) < q := by linarith
    have a2 : (q : ℝ) < 1 := by linarith
    have b1 : -1 < q := by exact_mod_cast a1
    have b2 : q < 1 := by exact_mod_cast a2
    have hq : q = 0 := by omega
    rw [hx, hq]; norm_num
  rcases sq9_mem_edge_of_not_mem_densitySet hsq hj.2 with h | h | h | h
  · exact Or.inl (int1 h h1 h2)
  · exact Or.inl (int2 h h1 h2)
  · exact Or.inr (int1 h h3 h4)
  · exact Or.inr (int2 h h3 h4)

/-- The vertical axis is null near the vertex. -/
theorem volume_sqVertex_vline : volume (ball sqVertex (1 / 4) ∩ {z : ℂ | z.re = 1 / 2}) = 0 := by
  refine measure_mono_null ?_ (volume_segment_eq_zero (⟨1 / 2, 0⟩ : ℂ) ⟨1 / 2, 1⟩)
  rintro z ⟨hz, hre⟩
  obtain ⟨-, him⟩ := sqVertex_coords hz
  obtain ⟨h3, h4⟩ := abs_lt.mp him
  refine ⟨1 - z.im, z.im, by linarith, by linarith, by ring, ?_⟩
  apply Complex.ext
  · simp only [Complex.add_re, Complex.real_smul, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im]
    rw [show z.re = 1 / 2 from hre]; ring
  · simp only [Complex.add_im, Complex.real_smul, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im]
    ring

/-- The horizontal axis is null near the vertex. -/
theorem volume_sqVertex_hline : volume (ball sqVertex (1 / 4) ∩ {z : ℂ | z.im = 1 / 2}) = 0 := by
  refine measure_mono_null ?_ (volume_segment_eq_zero (⟨0, 1 / 2⟩ : ℂ) ⟨1, 1 / 2⟩)
  rintro z ⟨hz, him⟩
  obtain ⟨hre, -⟩ := sqVertex_coords hz
  obtain ⟨h1, h2⟩ := abs_lt.mp hre
  refine ⟨1 - z.re, z.re, by linarith, by linarith, by ring, ?_⟩
  apply Complex.ext
  · simp only [Complex.add_re, Complex.real_smul, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im]
    ring
  · simp only [Complex.add_im, Complex.real_smul, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im]
    rw [show z.im = 1 / 2 from him]; ring

/-- A point of the vertical axis near the vertex, other than the vertex, has a two-colour ball. -/
theorem sq9_twoColourNhd_of_re {w : ℂ} (hw : w ∈ ball sqVertex (1 / 4)) (hre : w.re = 1 / 2) (him : w.im ≠ 1 / 2) :
    ∃ ρ a b, TwoColourNhd sq9.cls (ball w ρ) a b := by
  have hw' := hw
  rw [mem_ball] at hw'
  have hρ0 : 0 < min |w.im - 1 / 2| (1 / 4 - dist w sqVertex) :=
    lt_min (abs_pos.2 (sub_ne_zero.2 him)) (by linarith)
  set ρ : ℝ := min |w.im - 1 / 2| (1 / 4 - dist w sqVertex) with hρ
  have hρ1 : ρ ≤ |w.im - 1 / 2| := min_le_left _ _
  have hρ2 : ρ ≤ 1 / 4 - dist w sqVertex := min_le_right _ _
  have hsub : ball w ρ ⊆ ball sqVertex (1 / 4) := by
    intro z hz
    rw [mem_ball] at hz ⊢
    have := dist_triangle z w sqVertex
    linarith
  have hside : ∀ z ∈ ball w ρ, decide (1 / 2 ≤ z.im) = decide (1 / 2 ≤ w.im) := by
    intro z hz
    rw [mem_ball, dist_eq_norm] at hz
    have h1 : |z.im - w.im| ≤ ‖z - w‖ := by
      have := abs_im_le_norm (z - w); rwa [Complex.sub_im] at this
    have h3 : |z.im - w.im| < |w.im - 1 / 2| := by linarith
    rw [abs_lt] at h3
    rw [decide_eq_decide]
    rcases lt_or_gt_of_ne him with h | h
    · rw [abs_of_neg (by linarith)] at h3
      constructor <;> intro <;> linarith
    · rw [abs_of_pos (by linarith)] at h3
      constructor <;> intro <;> linarith
  have hdist : ∀ s : ℝ, |s| < ρ → w + (s : ℂ) ∈ ball w ρ := by
    intro s hs
    rw [mem_ball, dist_eq_norm, add_sub_cancel_left, Complex.norm_real, Real.norm_eq_abs]
    exact hs
  refine ⟨ρ, sqQuad false (decide (1 / 2 ≤ w.im)), sqQuad true (decide (1 / 2 ≤ w.im)), ?_⟩
  refine sq9.twoColourNhd_of_halves isOpen_ball (convex_ball w ρ) (H₁ := {z : ℂ | z.re < 1 / 2})
    (H₂ := {z : ℂ | 1 / 2 < z.re}) (isOpen_lt Complex.continuous_re continuous_const)
    (isOpen_lt continuous_const Complex.continuous_re) (convex_halfSpace_re_lt _) (convex_halfSpace_re_gt _)
    ?_ ?_ ?_ (fun h => absurd (sqQuad_inj h).1 (by decide)) ?_ ?_
  · refine ⟨w + ((-(ρ / 2) : ℝ) : ℂ), hdist _ (by rw [abs_neg, abs_of_pos (by linarith)]; linarith), ?_⟩
    show (w + ((-(ρ / 2) : ℝ) : ℂ)).re < 1 / 2
    rw [Complex.add_re, Complex.ofReal_re, hre]; linarith
  · refine ⟨w + ((ρ / 2 : ℝ) : ℂ), hdist _ (by rw [abs_of_pos (by linarith)]; linarith), ?_⟩
    show 1 / 2 < (w + ((ρ / 2 : ℝ) : ℂ)).re
    rw [Complex.add_re, Complex.ofReal_re, hre]; linarith
  · refine measure_mono_null ?_ volume_sqVertex_vline
    rintro z ⟨hzN, hzn⟩
    refine ⟨hsub hzN, ?_⟩
    show z.re = 1 / 2
    have a1 : ¬ z.re < 1 / 2 := fun h => hzn (Or.inl h)
    have a2 : ¬ 1 / 2 < z.re := fun h => hzn (Or.inr h)
    exact le_antisymm (not_lt.1 a2) (not_lt.1 a1)
  · rintro z ⟨hzN, hz⟩
    show sq9Col z = _
    rw [sq9Col_near_vertex (hsub hzN), hside z hzN, decide_eq_false (not_le.2 hz)]
  · rintro z ⟨hzN, hz⟩
    show sq9Col z = _
    rw [sq9Col_near_vertex (hsub hzN), hside z hzN, decide_eq_true (le_of_lt hz)]

/-- A point of the horizontal axis near the vertex, other than the vertex, has a two-colour ball. -/
theorem sq9_twoColourNhd_of_im {w : ℂ} (hw : w ∈ ball sqVertex (1 / 4)) (him : w.im = 1 / 2) (hre : w.re ≠ 1 / 2) :
    ∃ ρ a b, TwoColourNhd sq9.cls (ball w ρ) a b := by
  have hw' := hw
  rw [mem_ball] at hw'
  have hρ0 : 0 < min |w.re - 1 / 2| (1 / 4 - dist w sqVertex) :=
    lt_min (abs_pos.2 (sub_ne_zero.2 hre)) (by linarith)
  set ρ : ℝ := min |w.re - 1 / 2| (1 / 4 - dist w sqVertex) with hρ
  have hρ1 : ρ ≤ |w.re - 1 / 2| := min_le_left _ _
  have hρ2 : ρ ≤ 1 / 4 - dist w sqVertex := min_le_right _ _
  have hsub : ball w ρ ⊆ ball sqVertex (1 / 4) := by
    intro z hz
    rw [mem_ball] at hz ⊢
    have := dist_triangle z w sqVertex
    linarith
  have hside : ∀ z ∈ ball w ρ, decide (1 / 2 ≤ z.re) = decide (1 / 2 ≤ w.re) := by
    intro z hz
    rw [mem_ball, dist_eq_norm] at hz
    have h1 : |z.re - w.re| ≤ ‖z - w‖ := by
      have := abs_re_le_norm (z - w); rwa [Complex.sub_re] at this
    have h3 : |z.re - w.re| < |w.re - 1 / 2| := by linarith
    rw [abs_lt] at h3
    rw [decide_eq_decide]
    rcases lt_or_gt_of_ne hre with h | h
    · rw [abs_of_neg (by linarith)] at h3
      constructor <;> intro <;> linarith
    · rw [abs_of_pos (by linarith)] at h3
      constructor <;> intro <;> linarith
  have hdist : ∀ s : ℝ, |s| < ρ → w + (s : ℂ) * I ∈ ball w ρ := by
    intro s hs
    rw [mem_ball, dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, Complex.norm_I, mul_one,
      Real.norm_eq_abs]
    exact hs
  refine ⟨ρ, sqQuad (decide (1 / 2 ≤ w.re)) false, sqQuad (decide (1 / 2 ≤ w.re)) true, ?_⟩
  refine sq9.twoColourNhd_of_halves isOpen_ball (convex_ball w ρ) (H₁ := {z : ℂ | z.im < 1 / 2})
    (H₂ := {z : ℂ | 1 / 2 < z.im}) (isOpen_lt Complex.continuous_im continuous_const)
    (isOpen_lt continuous_const Complex.continuous_im) (convex_halfSpace_im_lt _) (convex_halfSpace_im_gt _)
    ?_ ?_ ?_ (fun h => absurd (sqQuad_inj h).2 (by decide)) ?_ ?_
  · refine ⟨w + ((-(ρ / 2) : ℝ) : ℂ) * I, hdist _ (by rw [abs_neg, abs_of_pos (by linarith)]; linarith), ?_⟩
    show (w + ((-(ρ / 2) : ℝ) : ℂ) * I).im < 1 / 2
    rw [Complex.add_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, Complex.I_re, Complex.I_im, him]
    linarith
  · refine ⟨w + ((ρ / 2 : ℝ) : ℂ) * I, hdist _ (by rw [abs_of_pos (by linarith)]; linarith), ?_⟩
    show 1 / 2 < (w + ((ρ / 2 : ℝ) : ℂ) * I).im
    rw [Complex.add_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, Complex.I_re, Complex.I_im, him]
    linarith
  · refine measure_mono_null ?_ volume_sqVertex_hline
    rintro z ⟨hzN, hzn⟩
    refine ⟨hsub hzN, ?_⟩
    show z.im = 1 / 2
    have a1 : ¬ z.im < 1 / 2 := fun h => hzn (Or.inl h)
    have a2 : ¬ 1 / 2 < z.im := fun h => hzn (Or.inr h)
    exact le_antisymm (not_lt.1 a2) (not_lt.1 a1)
  · rintro z ⟨hzN, hz⟩
    show sq9Col z = _
    have hd : decide (1 / 2 ≤ z.im) = false := decide_eq_false (not_le.2 hz)
    rw [sq9Col_near_vertex (hsub hzN), hside z hzN, hd]
  · rintro z ⟨hzN, hz⟩
    show sq9Col z = _
    have hd : decide (1 / 2 ≤ z.im) = true := decide_eq_true (le_of_lt hz)
    rw [sq9Col_near_vertex (hsub hzN), hside z hzN, hd]

/-- **The vertex is the only singular point of `sq9` in `B(sqVertex, 1/4)`.** -/
theorem sq9_singular_near_vertex : sq9.singularSet ∩ ball sqVertex (1 / 4) ⊆ {sqVertex} := by
  rintro w ⟨hwS, hwb⟩
  by_contra hne
  rcases hwS with ⟨hb, hno⟩ | ⟨j, hc⟩
  · rcases sq9_axis_of_mem_essBdry hwb hb with hre | him
    · exact hno (sq9_twoColourNhd_of_re hwb hre fun him => hne (Complex.ext hre him))
    · exact hno (sq9_twoColourNhd_of_im hwb him fun hre => hne (Complex.ext hre him))
  · exact sq9_not_isCuspAt_near_vertex hwb j hc

/-- **The vertex is a singular point of `sq9`**: an essential boundary point every ball about which holds four
colours. -/
theorem sqVertex_mem_singularSet : sqVertex ∈ sq9.singularSet := by
  have hv : sqVertex ∈ ball sqVertex (1 / 4) := mem_ball_self (by norm_num)
  have hq : ∀ b b' : Bool, sqVertex ∈ essClosure (sq9.cls (sqQuad b b')) := fun b b' =>
    sq9_essClosure_of_quad hv (by show 0 ≤ sqSg b * ((1 / 2 : ℝ) - 1 / 2); simp)
      (by show 0 ≤ sqSg b' * ((1 / 2 : ℝ) - 1 / 2); simp)
  refine Or.inl ⟨sq9_mem_essBdry_of_re hv rfl, ?_⟩
  rintro ⟨ρ, a, b, h⟩
  have key : ∀ q q' : Bool, sqQuad q q' = a ∨ sqQuad q q' = b := by
    intro q q'
    by_contra hcon
    rw [not_or] at hcon
    exact (essClosure_subset_essSupport _ (hq q q') ρ h.radius_pos).ne' (h.h1 _ hcon.1 hcon.2)
  rcases key false false with h1 | h1 <;> rcases key false true with h2 | h2 <;>
    rcases key true false with h3 | h3 <;>
    first
    | exact absurd (sqQuad_inj (h1.trans h2.symm)).2 (by decide)
    | exact absurd (sqQuad_inj (h1.trans h3.symm)).1 (by decide)
    | exact absurd (sqQuad_inj (h2.trans h3.symm)).1 (by decide)

/-! ## The fan of `sq9` at the vertex -/

/-- The angle of branch `i` of `sq9`'s fan at the vertex: the constant `i π/2`. -/
noncomputable def sq9Fanφ (i : Fin 4) (_ : ℝ) : ℝ := (i : ℕ) * (Real.pi / 2)

/-- The colour of the quadrant counter-clockwise of the half-axis `m`. -/
def sq9FanCol : ℕ → Fin 9
  | 0 => sqQuad true true
  | 1 => sqQuad false true
  | 2 => sqQuad false false
  | _ => sqQuad true false

/-- After branch `i` comes the half-axis a quarter turn on. -/
theorem cyclicNext_sq9Fanφ (i : Fin 4) (t : ℝ) : cyclicNext sq9Fanφ i t = ((i : ℕ) + 1) * (Real.pi / 2) := by
  by_cases h : (i : ℕ) + 1 < 4
  · rw [cyclicNext_of_lt _ h]
    show (((i : ℕ) + 1 : ℕ) : ℝ) * (Real.pi / 2) = _
    push_cast; ring
  · rw [cyclicNext_of_not_lt _ h]
    have hi : (i : ℕ) = 3 := by have := i.2; omega
    show ((0 : ℕ) : ℝ) * (Real.pi / 2) + 2 * Real.pi = _
    rw [hi]; push_cast; ring

/-- The cosine and sine at the four half-axes. -/
theorem cos_sin_quarter_turn :
    (Real.cos (((0 : ℕ) : ℝ) * (Real.pi / 2)) = 1 ∧ Real.sin (((0 : ℕ) : ℝ) * (Real.pi / 2)) = 0) ∧
    (Real.cos (((1 : ℕ) : ℝ) * (Real.pi / 2)) = 0 ∧ Real.sin (((1 : ℕ) : ℝ) * (Real.pi / 2)) = 1) ∧
    (Real.cos (((2 : ℕ) : ℝ) * (Real.pi / 2)) = -1 ∧ Real.sin (((2 : ℕ) : ℝ) * (Real.pi / 2)) = 0) ∧
    (Real.cos (((3 : ℕ) : ℝ) * (Real.pi / 2)) = 0 ∧ Real.sin (((3 : ℕ) : ℝ) * (Real.pi / 2)) = -1) := by
  have h2 : ((2 : ℕ) : ℝ) * (Real.pi / 2) = Real.pi := by push_cast; ring
  have h3 : ((3 : ℕ) : ℝ) * (Real.pi / 2) = Real.pi / 2 + Real.pi := by push_cast; ring
  refine ⟨⟨by simp, by simp⟩, ⟨by simp, by simp⟩, ⟨by rw [h2, Real.cos_pi], by rw [h2, Real.sin_pi]⟩,
    ⟨by rw [h3, Real.cos_add_pi, Real.cos_pi_div_two, neg_zero],
      by rw [h3, Real.sin_add_pi, Real.sin_pi_div_two]⟩⟩

/-- A point of a half-axis at the vertex, in polar form. -/
theorem sq9_polarGraph_eq (m : ℕ) (hm : m < 4) {t : ℝ} :
    polarPt sqVertex t (sq9Fanφ ⟨m, hm⟩ t) =
      ⟨1 / 2 + t * Real.cos ((m : ℝ) * (Real.pi / 2)), 1 / 2 + t * Real.sin ((m : ℝ) * (Real.pi / 2))⟩ :=
  Complex.ext (polarPt_re _ _ _) (polarPt_im _ _ _)

/-- **The essential boundary of `sq9` in the punctured disc at the vertex is the four half-axes.** -/
theorem sq9_bdry_near_vertex :
    sq9.essBdry ∩ (ball sqVertex (1 / 4) \ {sqVertex}) = ⋃ i, polarGraph sqVertex (1 / 4) (sq9Fanφ i) := by
  obtain ⟨⟨c0, s0⟩, ⟨c1, s1⟩, ⟨c2, s2⟩, ⟨c3, s3⟩⟩ := cos_sin_quarter_turn
  apply subset_antisymm
  · rintro w ⟨hb, hwb, hwz⟩
    obtain ⟨hre, him⟩ := sqVertex_coords hwb
    obtain ⟨h1, h2⟩ := abs_lt.mp hre
    obtain ⟨h3, h4⟩ := abs_lt.mp him
    have hne : ¬ (w.re = 1 / 2 ∧ w.im = 1 / 2) := fun h => hwz (Complex.ext h.1 h.2)
    rcases sq9_axis_of_mem_essBdry hwb hb with hr | hi
    · rcases lt_trichotomy w.im (1 / 2) with h | h | h
      · refine mem_iUnion.2 ⟨⟨3, by norm_num⟩, 1 / 2 - w.im, ⟨by linarith, by linarith⟩, ?_⟩
        rw [sq9_polarGraph_eq 3 (by norm_num), c3, s3]
        exact Complex.ext (by show w.re = 1 / 2 + (1 / 2 - w.im) * 0; linarith)
          (by show w.im = 1 / 2 + (1 / 2 - w.im) * -1; linarith)
      · exact absurd ⟨hr, h⟩ hne
      · refine mem_iUnion.2 ⟨⟨1, by norm_num⟩, w.im - 1 / 2, ⟨by linarith, by linarith⟩, ?_⟩
        rw [sq9_polarGraph_eq 1 (by norm_num), c1, s1]
        exact Complex.ext (by show w.re = 1 / 2 + (w.im - 1 / 2) * 0; linarith)
          (by show w.im = 1 / 2 + (w.im - 1 / 2) * 1; linarith)
    · rcases lt_trichotomy w.re (1 / 2) with h | h | h
      · refine mem_iUnion.2 ⟨⟨2, by norm_num⟩, 1 / 2 - w.re, ⟨by linarith, by linarith⟩, ?_⟩
        rw [sq9_polarGraph_eq 2 (by norm_num), c2, s2]
        exact Complex.ext (by show w.re = 1 / 2 + (1 / 2 - w.re) * -1; linarith)
          (by show w.im = 1 / 2 + (1 / 2 - w.re) * 0; linarith)
      · exact absurd ⟨h, hi⟩ hne
      · refine mem_iUnion.2 ⟨⟨0, by norm_num⟩, w.re - 1 / 2, ⟨by linarith, by linarith⟩, ?_⟩
        rw [sq9_polarGraph_eq 0 (by norm_num), c0, s0]
        exact Complex.ext (by show w.re = 1 / 2 + (w.re - 1 / 2) * 1; linarith)
          (by show w.im = 1 / 2 + (w.re - 1 / 2) * 0; linarith)
  · intro w hw
    obtain ⟨i, hi⟩ := mem_iUnion.1 hw
    have hsub := polarGraph_subset _ _ _ hi
    refine ⟨?_, hsub⟩
    obtain ⟨t, -, rfl⟩ := hi
    obtain ⟨m, hm⟩ := i
    rw [sq9_polarGraph_eq m hm] at hsub ⊢
    interval_cases m
    · rw [c0, s0] at hsub ⊢
      exact sq9_mem_essBdry_of_im hsub.1 (by show (1 / 2 : ℝ) + t * 0 = 1 / 2; ring)
    · rw [c1, s1] at hsub ⊢
      exact sq9_mem_essBdry_of_re hsub.1 (by show (1 / 2 : ℝ) + t * 0 = 1 / 2; ring)
    · rw [c2, s2] at hsub ⊢
      exact sq9_mem_essBdry_of_im hsub.1 (by show (1 / 2 : ℝ) + t * 0 = 1 / 2; ring)
    · rw [c3, s3] at hsub ⊢
      exact sq9_mem_essBdry_of_re hsub.1 (by show (1 / 2 : ℝ) + t * 0 = 1 / 2; ring)

/-- **Each open quadrant at the vertex lies in one class of `sq9`.** -/
theorem sq9_region_near_vertex (i : Fin 4) :
    polarRegion sqVertex (1 / 4) (sq9Fanφ i) (cyclicNext sq9Fanφ i) ⊆ sq9.cls (sq9FanCol i) := by
  rintro w ⟨t, ht, θ, ⟨hθ1, hθ2⟩, rfl⟩
  rw [cyclicNext_sq9Fanφ] at hθ2
  have hθ1' : ((i : ℕ) : ℝ) * (Real.pi / 2) < θ := hθ1
  have hball : polarPt sqVertex t θ ∈ ball sqVertex (1 / 4) := by
    rw [mem_ball, dist_polarPt _ ht.1.le]; exact ht.2
  have hpi := Real.pi_pos
  show sq9Col _ = _
  rw [sq9Col_near_vertex hball, polarPt_re, polarPt_im]
  have hpos : ∀ x : ℝ, 0 < x → decide ((1 : ℝ) / 2 ≤ sqVertex.re + t * x) = true ∧
      decide ((1 : ℝ) / 2 ≤ sqVertex.im + t * x) = true := fun x hx =>
    ⟨decide_eq_true (by show (1 : ℝ) / 2 ≤ 1 / 2 + t * x; nlinarith [ht.1]),
      decide_eq_true (by show (1 : ℝ) / 2 ≤ 1 / 2 + t * x; nlinarith [ht.1])⟩
  have hneg : ∀ x : ℝ, x < 0 → decide ((1 : ℝ) / 2 ≤ sqVertex.re + t * x) = false ∧
      decide ((1 : ℝ) / 2 ≤ sqVertex.im + t * x) = false := fun x hx =>
    ⟨decide_eq_false (not_le.2 (by show (1 : ℝ) / 2 + t * x < 1 / 2; nlinarith [ht.1])),
      decide_eq_false (not_le.2 (by show (1 : ℝ) / 2 + t * x < 1 / 2; nlinarith [ht.1]))⟩
  obtain ⟨m, hm⟩ := i
  simp only at hθ1' hθ2
  interval_cases m
  · have hc : 0 < Real.cos θ := Real.cos_pos_of_mem_Ioo ⟨by linarith, by linarith⟩
    have hs : 0 < Real.sin θ := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
    rw [(hpos _ hc).1, (hpos _ hs).2]; rfl
  · have hc : Real.cos θ < 0 := Real.cos_neg_of_pi_div_two_lt_of_lt (by linarith) (by linarith)
    have hs : 0 < Real.sin θ := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
    rw [(hneg _ hc).1, (hpos _ hs).2]; rfl
  · have hc : Real.cos θ < 0 := Real.cos_neg_of_pi_div_two_lt_of_lt (by linarith) (by linarith)
    have hs : Real.sin θ < 0 := by
      rw [← Real.sin_sub_two_pi]; exact Real.sin_neg_of_neg_of_neg_pi_lt (by linarith) (by linarith)
    rw [(hneg _ hc).1, (hneg _ hs).2]; rfl
  · have hc : 0 < Real.cos θ := by
      rw [← Real.cos_sub_two_pi]; exact Real.cos_pos_of_mem_Ioo ⟨by linarith, by linarith⟩
    have hs : Real.sin θ < 0 := by
      rw [← Real.sin_sub_two_pi]; exact Real.sin_neg_of_neg_of_neg_pi_lt (by linarith) (by linarith)
    rw [(hpos _ hc).1, (hneg _ hs).2]; rfl

/-- **The inhabitant of `Fan`**: `sq9` at the grid vertex `1/2 + i/2`, in the disc of radius `1/4` — four branches
along the half-axes with constant angles `0, π/2, π, 3π/2`, four regions (the open quadrants) of four colours. -/
noncomputable def sq9Fan : sq9.Fan sqVertex where
  r := 1 / 4
  r_pos := by norm_num
  n := 4
  φ := sq9Fanφ
  dir := fun i => (i : ℕ) * (Real.pi / 2)
  col := fun i => sq9FanCol i
  cont := fun _ => continuousOn_const
  tendsto := fun _ => tendsto_const_nhds
  mono := fun _ _ i j hij => by
    show ((i : ℕ) : ℝ) * (Real.pi / 2) < ((j : ℕ) : ℝ) * (Real.pi / 2)
    have h : ((i : ℕ) : ℝ) < (j : ℕ) := by exact_mod_cast hij
    nlinarith [Real.pi_pos]
  wrap := fun _ _ i j => by
    show ((i : ℕ) : ℝ) * (Real.pi / 2) < ((j : ℕ) : ℝ) * (Real.pi / 2) + 2 * Real.pi
    have hi : ((i : ℕ) : ℝ) ≤ 3 := by exact_mod_cast Nat.lt_succ_iff.1 i.2
    have hj : (0 : ℝ) ≤ ((j : ℕ) : ℝ) := Nat.cast_nonneg _
    nlinarith [Real.pi_pos]
  singular := sq9_singular_near_vertex
  bdry := sq9_bdry_near_vertex
  region := fun i => Eventually.of_forall (sq9_region_near_vertex i)

/-- Every region of `sq9`'s fan at the vertex has angle `π/2`. -/
theorem sq9Fan_dir_lt_nextDir (i : Fin 4) : sq9Fan.dir i < sq9Fan.nextDir i := by
  show ((i : ℕ) : ℝ) * (Real.pi / 2) < cyclicNext sq9Fanφ i 0
  rw [cyclicNext_sq9Fanφ]
  nlinarith [Real.pi_pos]

/-- Spec for `HasSector`: each of the four quadrant colours occupies a sector of positive angle at the vertex. -/
theorem sq9Fan_hasSector (i : Fin 4) : sq9Fan.HasSector (sq9FanCol i) := ⟨i, rfl, sq9Fan_dir_lt_nextDir i⟩

/-- Spec for `HasHorn`: `sq9` has no zero-angle region at the vertex. -/
theorem sq9Fan_not_hasHorn (j : Fin 9) : ¬ sq9Fan.HasHorn j := fun ⟨i, _, h⟩ =>
  (sq9Fan_dir_lt_nextDir i).ne h

end HadwigerNelson.Plane
