import Proofs.HadwigerNelson.Plane.OneClass.Defs
import Proofs.HadwigerNelson.Plane.Slack

/-!
# The triangular packing of half-unit discs: `m₁(ℝ²) ≥ π/(8√3) > 1/5` (FS-131, jobs FS131-KFR1 and FS131-IFR1; module D4)

**Read aloud.** The open discs of radius `1/2` centred at the triangular lattice of spacing `2`
(`triCentre m n = 2m + n(1 + i√3)`) hold no two points at distance one — two points of one disc are less than `1` apart, and
two of different discs more than `2 − 1 = 1` — and fill `π/(8√3) = 0.2267…` of the plane (one disc of area `π/4` per cell of
area `2√3`). So `m₁(ℝ²) ≥ π/(8√3) > 1/5`, which FS103-F-ROUND's "the density route never gives six" needs
(`1/m₁ < 4.42 < 5`). The kernel's earlier bounds, `1/7` (`OneClass.one_seventh_le_mOne`) and `2π/(21√3)`
(`Collapse.disc7_le_mOne`), are below `1/5`.

**Not claimed:** Croft's `0.22936` (`[Croft1967]`'s tortoises) or any value of `m₁`.

**Models.** `triPacking` itself is the object; `0 ∈ triPacking` (`zero_mem_triPacking`).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Metric
open scoped ENNReal

noncomputable section

/-- The triangular lattice of spacing `2`: `2m + n(1 + i√3)`. -/
def triCentre (m n : ℤ) : ℂ := (((2 * m + n : ℤ) : ℝ) : ℂ) + (((n : ℝ) * Real.sqrt 3 : ℝ) : ℂ) * I

/-- **The packing**: the open discs of radius `1/2` about the lattice points. -/
def triPacking : Set ℂ := ⋃ (m : ℤ) (n : ℤ), ball (triCentre m n) (1 / 2)

example : triCentre 0 0 = 0 := by simp [triCentre]

theorem zero_mem_triPacking : (0 : ℂ) ∈ triPacking :=
  mem_iUnion₂.2 ⟨0, 0, by simp [triCentre]⟩

theorem measurableSet_triPacking : MeasurableSet triPacking :=
  (isOpen_iUnion fun _ => isOpen_iUnion fun _ => isOpen_ball).measurableSet

/-- The difference of two lattice points, coordinate by coordinate. -/
theorem triCentre_sub (m n m' n' : ℤ) :
    triCentre m n - triCentre m' n' = triCentre (m - m') (n - n') := by
  simp only [triCentre]; push_cast; ring

/-- Distinct lattice points are at least `2` apart (`|2a + b(1 + i√3)|² = 4(a² + ab + b²) ≥ 4`). -/
theorem two_le_dist_triCentre {m n m' n' : ℤ} (h : (m, n) ≠ (m', n')) : 2 ≤ dist (triCentre m n) (triCentre m' n') := by
  rw [dist_eq_norm, triCentre_sub]
  set a := m - m' with ha
  set b := n - n' with hb
  have hab : a ≠ 0 ∨ b ≠ 0 := by
    by_contra hc
    push Not at hc
    exact h (Prod.ext (by omega) (by omega))
  have hQ : 1 ≤ a ^ 2 + a * b + b ^ 2 := by
    have h1 : 1 ≤ a ^ 2 + b ^ 2 := by
      rcases hab with h0 | h0
      · have := pow_pos (abs_pos.2 h0) 2; rw [sq_abs] at this; nlinarith [sq_nonneg b]
      · have := pow_pos (abs_pos.2 h0) 2; rw [sq_abs] at this; nlinarith [sq_nonneg a]
    have h2 : 1 ≤ 2 * (a ^ 2 + a * b + b ^ 2) := by nlinarith [sq_nonneg (a + b)]
    generalize a ^ 2 + a * b + b ^ 2 = Q at h2 ⊢
    omega
  have hQr : (1 : ℝ) ≤ (a : ℝ) ^ 2 + a * b + b ^ 2 := by exact_mod_cast hQ
  have h3 : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have hn : ‖triCentre a b‖ ^ 2 = 4 * ((a : ℝ) ^ 2 + a * b + b ^ 2) := by
    rw [Complex.sq_norm, Complex.normSq_apply]
    simp only [triCentre, Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.I_re, Complex.ofReal_im,
      Complex.I_im, Complex.add_im, Complex.mul_im]
    push_cast
    nlinarith [h3]
  nlinarith [norm_nonneg (triCentre a b)]

/-- **No two points of the packing are at distance one.** -/
theorem isIndepSet_triPacking : (unitDistance ℂ).IsIndepSet triPacking := by
  rw [isIndepSet_unitDistance_iff]
  intro x hx y hy hxy
  obtain ⟨m, n, hx⟩ := mem_iUnion₂.1 hx
  obtain ⟨m', n', hy⟩ := mem_iUnion₂.1 hy
  rw [mem_ball] at hx hy
  by_cases h : (m, n) = (m', n')
  · obtain ⟨rfl, rfl⟩ := Prod.mk.inj h
    have := dist_triangle_right x y (triCentre m n)
    linarith
  · have h2 := two_le_dist_triCentre h
    have := dist_triangle4 (triCentre m n) x y (triCentre m' n')
    rw [dist_comm (triCentre m n) x] at this
    linarith

/-- A translate of the packing by a lattice vector is the packing. -/
private theorem triPacking_add {v : ℂ} {p q : ℤ} (hv : ∀ m n, triCentre (m + p) (n + q) = triCentre m n + v) (x : ℂ) :
    x + v ∈ triPacking ↔ x ∈ triPacking := by
  simp only [triPacking, mem_iUnion, mem_ball]
  constructor
  · rintro ⟨m, n, h⟩
    refine ⟨m - p, n - q, ?_⟩
    have e := hv (m - p) (n - q)
    simp only [sub_add_cancel] at e
    rwa [e, dist_add_right] at h
  · rintro ⟨m, n, h⟩
    exact ⟨m + p, n + q, by rwa [hv, dist_add_right]⟩

/-- The packing is periodic under the lattice `ℤ·2 + ℤ·(1 + i√3)`. -/
theorem triPacking_periodic (x : ℂ) : (x + 2 ∈ triPacking ↔ x ∈ triPacking) ∧
    (x + (1 + ((Real.sqrt 3 : ℝ) : ℂ) * I) ∈ triPacking ↔ x ∈ triPacking) :=
  ⟨triPacking_add (p := 1) (q := 0) (fun m n => by simp only [triCentre]; push_cast; ring) x,
    triPacking_add (p := 0) (q := 1) (fun m n => by simp only [triCentre]; push_cast; ring) x⟩

theorem linearIndependent_triLattice : LinearIndependent ℝ ![(2 : ℂ), 1 + ((Real.sqrt 3 : ℝ) : ℂ) * I] := by
  rw [LinearIndependent.pair_iff]
  intro s t hst
  have h3 : (0 : ℝ) < Real.sqrt 3 := by positivity
  have hre := congrArg Complex.re hst
  have him := congrArg Complex.im hst
  simp only [Complex.real_smul, Complex.add_re, Complex.mul_re, Complex.mul_im, Complex.add_im, Complex.ofReal_re,
    Complex.ofReal_im, Complex.I_re, Complex.I_im, Complex.zero_re, Complex.zero_im, Complex.one_re,
    Complex.one_im] at hre him
  norm_num at hre him
  obtain rfl : t = 0 := by simpa [h3.ne'] using him
  exact ⟨by simpa using hre, rfl⟩

/-- An open disc of radius `1/2` has area `π/4`. -/
private theorem volume_ball_half (z : ℂ) : volume (ball z (1 / 2)) = ENNReal.ofReal (Real.pi / 4) := by
  rw [Complex.volume_ball, ← ENNReal.ofReal_pow (by norm_num), ← ENNReal.ofReal_coe_nnreal (p := NNReal.pi),
    NNReal.coe_real_pi, ← ENNReal.ofReal_mul (by norm_num)]
  congr 1
  ring

/-- **Its density is `π/(8√3)`** (`upperDensity_of_periodic`; the fundamental parallelogram holds one disc's area, `π/4`,
of its `2√3`). -/
theorem upperDensity_triPacking : upperDensity triPacking = ENNReal.ofReal (Real.pi / (8 * Real.sqrt 3)) := by
  set v₁ : ℂ := 2 with hv₁
  set v₂ : ℂ := 1 + ((Real.sqrt 3 : ℝ) : ℂ) * I with hv₂
  have hP : {x : ℂ | ∃ s t : ℝ, s ∈ Ico (0 : ℝ) 1 ∧ t ∈ Ico (0 : ℝ) 1 ∧ x = s * v₁ + t * v₂} = parallelogram v₁ v₂ :=
    rfl
  rw [upperDensity_of_periodic linearIndependent_triLattice measurableSet_triPacking triPacking_periodic, hP]
  obtain ⟨hDm, -, -, hcov, hdisj⟩ := parallelogram_tiling linearIndependent_triLattice
  set g := latticePt v₁ v₂ with hg
  have hgc : ∀ p q : ℤ, g (p, q) = triCentre p q := by
    intro p q
    simp only [hg, latticePt, hv₁, hv₂, triCentre]; push_cast; ring
  have hgneg : ∀ pq, g (-pq) = -g pq := by
    intro pq; simp only [hg, latticePt, Prod.fst_neg, Prod.snd_neg]; push_cast; ring
  have hunion : triPacking = ⋃ pq : ℤ × ℤ, ball (g pq) (1 / 2) := by
    ext x
    simp only [triPacking, mem_iUnion, Prod.exists, hgc]
  have hdisjB : Pairwise (Function.onFun Disjoint fun pq : ℤ × ℤ => ball (g pq) (1 / 2)) := by
    rintro ⟨p, q⟩ ⟨p', q'⟩ hne
    refine Set.disjoint_left.2 fun x hx hx' => ?_
    rw [mem_ball, hgc] at hx hx'
    have h2 := two_le_dist_triCentre hne
    have := dist_triangle_right (triCentre p q) (triCentre p' q') x
    rw [dist_comm (triCentre p q) x, dist_comm (triCentre p' q') x] at this
    linarith
  have hB : ∀ pq, (fun x => x + g pq) ⁻¹' (ball (g pq) (1 / 2) ∩ parallelogram v₁ v₂) =
      ball 0 (1 / 2) ∩ {x | x + g pq ∈ parallelogram v₁ v₂} := by
    intro pq; ext x
    simp only [mem_preimage, mem_inter_iff, mem_ball, mem_setOf_eq, dist_eq_norm, add_sub_cancel_right, sub_zero]
  have hgoal1 : volume (triPacking ∩ parallelogram v₁ v₂) = ENNReal.ofReal (Real.pi / 4) := by
    rw [hunion, iUnion_inter, measure_iUnion (fun pq pq' hne => (hdisjB hne).mono inter_subset_left inter_subset_left)
      (fun pq => measurableSet_ball.inter hDm)]
    have hterm : ∀ pq, volume (ball (g pq) (1 / 2) ∩ parallelogram v₁ v₂) =
        volume (ball 0 (1 / 2) ∩ {x | x + g pq ∈ parallelogram v₁ v₂}) := by
      intro pq; rw [← hB, measure_preimage_add_right]
    rw [tsum_congr hterm]
    have hU := measure_iUnion (μ := volume)
      (f := fun pq => ball (0 : ℂ) (1 / 2) ∩ {x | x + g pq ∈ parallelogram v₁ v₂})
      (fun pq pq' hne => Set.disjoint_left.2 fun x hx hx' => hne (by
          have := hdisj (-pq) (-pq') x (by rw [hgneg, sub_neg_eq_add]; exact hx.2)
            (by rw [hgneg, sub_neg_eq_add]; exact hx'.2)
          exact neg_injective this))
      (fun pq => measurableSet_ball.inter ((measurable_id.add_const _) hDm))
    rw [← hU, ← inter_iUnion]
    have hcovU : (⋃ pq, {x | x + g pq ∈ parallelogram v₁ v₂}) = univ := by
      refine eq_univ_of_forall fun x => mem_iUnion.2 ?_
      obtain ⟨mn, h⟩ := hcov x
      exact ⟨-mn, by rw [mem_setOf_eq, hgneg, ← sub_eq_add_neg]; exact h⟩
    rw [hcovU, inter_univ, volume_ball_half]
  have hgoal2 : volume (parallelogram v₁ v₂) = ENNReal.ofReal (2 * Real.sqrt 3) := by
    set f : ℂ →ₗ[ℝ] ℂ := Complex.reLm.smulRight v₁ + Complex.imLm.smulRight v₂ with hf
    have hfz : ∀ z : ℂ, f z = (z.re : ℂ) * v₁ + (z.im : ℂ) * v₂ := by
      intro z; simp [hf, Complex.real_smul]
    have himg : parallelogram v₁ v₂ = f '' squareWin 0 1 := by
      ext x
      constructor
      · rintro ⟨s, t, hs, ht, rfl⟩
        refine ⟨(s : ℂ) + (t : ℂ) * I, ?_, ?_⟩
        · simp only [squareWin, mem_setOf_eq]; simp; exact ⟨hs.1, hs.2, ht.1, ht.2⟩
        · rw [hfz]; simp
      · rintro ⟨z, ⟨h1, h2, h3, h4⟩, rfl⟩
        simp only [Complex.zero_re, Complex.zero_im, zero_add] at h1 h2 h3 h4
        exact ⟨z.re, z.im, ⟨h1, h2⟩, ⟨h3, h4⟩, hfz z⟩
    have hdet : LinearMap.det f = 2 * Real.sqrt 3 := by
      rw [← LinearMap.det_toMatrix Complex.basisOneI, Matrix.det_fin_two]
      simp only [LinearMap.toMatrix_apply, Complex.coe_basisOneI_repr, Complex.coe_basisOneI, hfz]
      simp [hv₁, hv₂]
    rw [himg, MeasureTheory.Measure.addHaar_image_linearMap, volume_squareWin 0 zero_le_one, hdet]
    rw [abs_of_pos (by positivity), one_pow, ENNReal.ofReal_one, mul_one]
  rw [hgoal1, hgoal2, ← ENNReal.ofReal_div_of_pos (by positivity)]
  congr 1
  field_simp
  ring

/-- **`m₁(ℝ²) ≥ π/(8√3)`.** -/
theorem pi_div_le_mOne : ENNReal.ofReal (Real.pi / (8 * Real.sqrt 3)) ≤ mOne :=
  upperDensity_triPacking ▸ upperDensity_le_mOne measurableSet_triPacking isIndepSet_triPacking

/-- **`1/5 < m₁(ℝ²)`** (`π/(8√3) > 0.2267`). -/
theorem fifth_lt_mOne : (5 : ℝ≥0∞)⁻¹ < mOne := by
  refine lt_of_lt_of_le ?_ pi_div_le_mOne
  have h3 : Real.sqrt 3 < 7 / 4 := (Real.sqrt_lt' (by norm_num)).2 (by norm_num)
  have h3p : 0 < Real.sqrt 3 := by positivity
  rw [show (5 : ℝ≥0∞)⁻¹ = ENNReal.ofReal 5⁻¹ by
    rw [ENNReal.ofReal_inv_of_pos (by norm_num)]; norm_num]
  rw [ENNReal.ofReal_lt_ofReal_iff (by positivity), lt_div_iff₀ (by positivity)]
  nlinarith [Real.pi_gt_three]

end

end HadwigerNelson.Plane
