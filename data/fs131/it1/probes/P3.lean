import Proofs.HadwigerNelson.Arith.ThreeColourCharacter

namespace HadwigerNelson.TorsionExtraction

open HadwigerNelson.CharacterColouring HadwigerNelson.SpectralChain HadwigerNelson.SquareClass SimpleGraph

variable {F : Subfield ℝ}

theorem exists_zmod_hom_of_mem_torsionBy {M : Type*} [AddCommGroup M] {N : ℕ} [NeZero N] {θ : M →+ UnitAddCircle}
    (h : θ ∈ torsionBy M N) : ∃ l : M →+ ZMod N, ∀ x, θ x = ZMod.toAddCircle (l x) := by
  sorry

/-- **Induction on `ℤ[U_F]`**: it is the additive span of the unit vectors, so a property of `0` that passes to sums and
holds at every unit vector holds everywhere (`UnitRing.exists_sum_eq_of_mem_unitRingOver`). -/
private theorem unitRing_induction {p : unitRing F → Prop} (h0 : p 0) (hadd : ∀ x y, p x → p y → p (x + y))
    (hu : ∀ u ∈ unitSet F, p u) (x : unitRing F) : p x := by
  obtain ⟨x, hx⟩ := x
  obtain ⟨n, u, hu1, huF, rfl⟩ := UnitRing.exists_sum_eq_of_mem_unitRingOver hx
  have hsum : (⟨∑ j, u j, hx⟩ : unitRing F) =
      ∑ j, (⟨u j, UnitRing.unit_mem_unitRingOver (huF j) (hu1 j)⟩ : unitRing F) := by
    apply Subtype.ext
    simp
  rw [hsum]
  exact Finset.sum_induction _ p hadd h0 fun j _ => hu _ ⟨huF j, hu1 j⟩

/-- `band 2` is the one point `1/2`. -/
private theorem eq_half_of_mem_band_two {t : UnitAddCircle} (h : t ∈ band 2) : t = ((1 / 2 : ℝ) : UnitAddCircle) := by
  obtain ⟨x, ⟨hx1, hx2⟩, rfl⟩ := h
  have hx : x = 1 / 2 := by
    push_cast at hx1 hx2
    linarith
  rw [hx]

/-- `1/2 ≠ 0` in `ℝ/ℤ`. -/
private theorem half_ne_zero : ((1 / 2 : ℝ) : UnitAddCircle) ≠ 0 := by
  intro h
  obtain ⟨n, hn⟩ := (AddCircle.coe_eq_zero_iff (1 : ℝ)).mp h
  rw [zsmul_one] at hn
  have h2 : (2 * n : ℤ) = 1 := by
    have : (2 : ℝ) * n = 1 := by linarith
    exact_mod_cast this
  omega

theorem colorable_two_iff_fieldBandSet_two_nonempty (F : Subfield ℝ) :
    ((unitDistance ℂ).induce (planeOver F)).Colorable 2 ↔ (fieldBandSet F (band 2)).Nonempty := by
  constructor
  · rintro ⟨C⟩
    -- the points of the ring are points of the plane; `f x = C x − C 0`, read in `ZMod 2`
    have hsub : ∀ x : unitRing F, (x : ℂ) ∈ planeOver F := fun x =>
      UnitRing.unitRingOver_le_planeOverSubring F x.2
    let c : unitRing F → ZMod 2 := fun x => C ⟨x, hsub x⟩
    let f : unitRing F → ZMod 2 := fun x => c x - c 0
    have hflip : ∀ p q : ZMod 2, p ≠ q → p = q + 1 := by decide
    -- a unit step changes the colour
    have hstep : ∀ x u : unitRing F, u ∈ unitSet F → f (x + u) = f x + 1 := by
      intro x u hu
      have hadj : ((unitDistance ℂ).induce (planeOver F)).Adj ⟨((x + u : unitRing F) : ℂ), hsub _⟩ ⟨x, hsub x⟩ := by
        show dist ((x + u : unitRing F) : ℂ) (x : ℂ) = 1
        rw [Subring.coe_add, dist_eq_norm, add_sub_cancel_left]
        exact hu.2
      have hc : c (x + u) = c x + 1 := hflip _ _ (C.valid hadj)
      show c (x + u) - c 0 = c x - c 0 + 1
      rw [hc]
      ring
    have hf0 : f 0 = 0 := sub_self _
    have hfu : ∀ u ∈ unitSet F, f u = 1 := fun u hu => by
      have := hstep 0 u hu
      rwa [zero_add, hf0, zero_add] at this
    -- the invariant `∀ x, f (x + y) = f x + f y` holds at unit vectors and passes to sums
    have hadd : ∀ y x : unitRing F, f (x + y) = f x + f y := by
      refine unitRing_induction (p := fun y => ∀ x, f (x + y) = f x + f y) ?_ ?_ ?_
      · intro x
        rw [add_zero, hf0, add_zero]
      · intro y z hy hz x
        rw [← add_assoc, hz (x + y), hy x, hz y, add_assoc]
      · intro u hu x
        rw [hstep x u hu, hfu u hu]
    let l : unitRing F →+ ZMod 2 := AddMonoidHom.mk' f fun x y => hadd y x
    refine ⟨ZMod.toAddCircle.comp l, fun u hu => ?_⟩
    show ZMod.toAddCircle (f u) ∈ band 2
    rw [hfu u hu]
    have h1 : ZMod.toAddCircle (1 : ZMod 2) = ((1 / 2 : ℝ) : UnitAddCircle) := by
      have := ZMod.toAddCircle_natCast (N := 2) 1
      simpa using this
    exact ⟨1 / 2, ⟨by norm_num, by norm_num⟩, h1.symm⟩
  · rintro ⟨θ, hθ⟩
    have hhalf : ∀ u ∈ unitSet F, θ u = ((1 / 2 : ℝ) : UnitAddCircle) := fun u hu =>
      eq_half_of_mem_band_two (hθ u hu)
    -- `θ` is killed by 2, so it is a `ZMod 2`-valued functional, non-zero at every unit vector
    have h2 : θ ∈ torsionBy (unitRing F) 2 := by
      rw [mem_torsionBy]
      ext x
      show 2 • θ x = 0
      refine unitRing_induction (p := fun x => 2 • θ x = 0) ?_ ?_ ?_ x
      · rw [map_zero, smul_zero]
      · intro x y hx hy
        rw [map_add, smul_add, hx, hy, add_zero]
      · intro u hu
        rw [hhalf u hu, ← AddCircle.coe_nsmul, show (2 • (1 / 2 : ℝ)) = 1 by norm_num]
        exact AddCircle.coe_period 1
    obtain ⟨l, hl⟩ := exists_zmod_hom_of_mem_torsionBy h2
    have hl1 : ∀ u ∈ unitSet F, l u ≠ 0 := fun u hu h0 =>
      half_ne_zero (by rw [← hhalf u hu, hl, h0, map_zero])
    -- the residue colouring of `ResidueColouring`, at `G = ZMod 2`
    let ψ : (unitRing F).toAddSubgroup →+ ZMod 2 := l
    have hmem : ∀ ⦃v w : planeOver F⦄, ((unitDistance ℂ).induce (planeOver F)).Adj v w →
        (v : ℂ) - w ∈ unitVectors F := fun v w hvw =>
      ⟨(UnitRing.planeOverSubfield F).sub_mem v.2 w.2, by rw [← dist_eq_norm]; exact hvw⟩
    have := colorable_of_residue (G := ZMod 2) ((unitDistance ℂ).induce (planeOver F)) (fun v => (v : ℂ)) ψ
      (fun v w hvw => unitVectors_subset_unitRing F (hmem hvw)) fun v w hvw => by
        rw [cosetResidue_apply_of_mem ψ (unitVectors_subset_unitRing F (hmem hvw))]
        exact hl1 ⟨_, unitVectors_subset_unitRing F (hmem hvw)⟩ (hmem hvw)
    rwa [ZMod.card] at this

theorem mem_fieldBandSet_two_of_inv_three_mem (h3 : (3 : ℂ)⁻¹ ∈ unitRing F) {τ : unitRing F →+ UnitAddCircle}
    (hτ : τ ∈ fieldBandSet F (band 3)) (h6 : τ ∈ torsionBy (unitRing F) 6) : τ ∈ fieldBandSet F (band 2) := by
  intro u hu
  -- `u = 3 • (3⁻¹ u)`, so `2 • τ u = 6 • τ (3⁻¹ u) = 0`
  have hu3 : u = 3 • ((⟨(3 : ℂ)⁻¹, h3⟩ : unitRing F) * u) := by
    apply Subtype.ext
    rw [nsmul_eq_mul, Subring.coe_mul, Subring.coe_mul, Subring.coe_natCast, Nat.cast_ofNat, ← mul_assoc,
      mul_inv_cancel₀ (by norm_num), one_mul]
  have h2 : 2 • τ u = 0 := by
    have h6' : 6 • τ ((⟨(3 : ℂ)⁻¹, h3⟩ : unitRing F) * u) = 0 := by
      have := congrArg (fun f : unitRing F →+ UnitAddCircle => f ((⟨(3 : ℂ)⁻¹, h3⟩ : unitRing F) * u))
        (mem_torsionBy.mp h6)
      simpa using this
    conv_lhs => rw [hu3]
    rw [map_nsmul, smul_smul]
    exact h6'
  -- `τ u = ↑t` with `t ∈ [1/3, 2/3]` and `2t ∈ ℤ`, so `t = 1/2`
  obtain ⟨t, ⟨ht1, ht2⟩, ht⟩ := hτ u hu
  have ht' : τ u = (t : UnitAddCircle) := ht.symm
  rw [ht', ← AddCircle.coe_nsmul, AddCircle.coe_eq_zero_iff] at h2
  obtain ⟨n, hn⟩ := h2
  rw [zsmul_one, nsmul_eq_mul] at hn
  push_cast at ht1 ht2 hn
  have hn1 : n = 1 := by
    have h0 : (0 : ℝ) < n := by linarith
    have h2 : (n : ℝ) < 2 := by linarith
    have h0' : 0 < n := by exact_mod_cast h0
    have h2' : n < 2 := by exact_mod_cast h2
    omega
  rw [hn1, Int.cast_one] at hn
  refine ⟨1 / 2, ⟨by norm_num, by norm_num⟩, ?_⟩
  show ((1 / 2 : ℝ) : UnitAddCircle) = τ u
  rw [ht']
  congr 1
  linarith

/-- **`1/n = 2 − v − v̄`** with `v`, `v̄` unit vectors of `F²`, for `d + 1 = 4n` and `F ∋ √d`:
`v = ((2n − 1) + i√d)/(2n)` (`[Fischer1990]` Thm 10(ii)'s vector). -/
private theorem exists_unitVectors_inv_natCast {d n : ℕ} (hd : d + 1 = 4 * n) (hF : Real.sqrt d ∈ F) :
    ∃ v v' : ℂ, v ∈ unitVectors F ∧ v' ∈ unitVectors F ∧ (n : ℂ)⁻¹ = 2 - v - v' := by
  have hn : (n : ℝ) ≠ 0 := by
    have : n ≠ 0 := by omega
    exact_mod_cast this
  have hdR : (d : ℝ) = 4 * n - 1 := by
    have : ((d + 1 : ℕ) : ℝ) = ((4 * n : ℕ) : ℝ) := by rw [hd]
    push_cast at this
    linarith
  have h2n : (2 * n : ℝ) ∈ F := F.mul_mem (ofNat_mem F 2) (natCast_mem F n)
  have hxF : (2 * n - 1 : ℝ) / (2 * n) ∈ F := F.div_mem (F.sub_mem h2n F.one_mem) h2n
  have hyF : Real.sqrt d / (2 * n) ∈ F := F.div_mem hF h2n
  have hxy : ((2 * n - 1 : ℝ) / (2 * n)) ^ 2 + (Real.sqrt d / (2 * n)) ^ 2 = 1 := by
    rw [div_pow, div_pow, Real.sq_sqrt (Nat.cast_nonneg d), hdR]
    field_simp
    ring
  refine ⟨⟨(2 * n - 1 : ℝ) / (2 * n), Real.sqrt d / (2 * n)⟩, ⟨(2 * n - 1 : ℝ) / (2 * n), -(Real.sqrt d / (2 * n))⟩,
    ⟨⟨hxF, hyF⟩, ?_⟩, ⟨⟨hxF, F.neg_mem hyF⟩, ?_⟩, ?_⟩
  · rw [Complex.norm_eq_sqrt_sq_add_sq, hxy, Real.sqrt_one]
  · rw [Complex.norm_eq_sqrt_sq_add_sq]
    show Real.sqrt (((2 * n - 1 : ℝ) / (2 * n)) ^ 2 + (-(Real.sqrt d / (2 * n))) ^ 2) = 1
    rw [neg_sq, hxy, Real.sqrt_one]
  · apply Complex.ext
    · simp
      field_simp
      ring
    · simp

theorem inv_natCast_mem_unitRing_of_sqrt_mem {d n : ℕ} (hd : d + 1 = 4 * n) (hF : Real.sqrt d ∈ F) :
    (n : ℂ)⁻¹ ∈ unitRing F := by
  obtain ⟨v, v', hv, hv', h⟩ := exists_unitVectors_inv_natCast hd hF
  rw [h]
  exact sub_mem (sub_mem (ofNat_mem _ 2) (unitVectors_subset_unitRing F hv)) (unitVectors_subset_unitRing F hv')

theorem inv_three_mem_unitRing_of_sqrt_mem {d : ℕ} (hd : d % 12 = 11) (hF : Real.sqrt d ∈ F) :
    (3 : ℂ)⁻¹ ∈ unitRing F := by
  obtain ⟨k, hk0, hk⟩ : ∃ k : ℕ, k ≠ 0 ∧ d + 1 = 4 * (3 * k) := ⟨(d + 1) / 12, by omega, by omega⟩
  have h := inv_natCast_mem_unitRing_of_sqrt_mem hk hF
  have hk' : (k : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hk0
  have h3 : (3 : ℂ)⁻¹ = (k : ℂ) * ((3 * k : ℕ) : ℂ)⁻¹ := by
    push_cast
    field_simp
  rw [h3]
  exact mul_mem (natCast_mem _ k) h

theorem not_colorable_two_of_sqrt_mem {d : ℕ} (hd : d % 4 = 3) (hF : Real.sqrt d ∈ F) :
    ¬ ((unitDistance ℂ).induce (planeOver F)).Colorable 2 := by
  intro hcol
  obtain ⟨θ, hθ⟩ := (colorable_two_iff_fieldBandSet_two_nonempty F).mp hcol
  have hhalf : ∀ u ∈ unitSet F, θ u = ((1 / 2 : ℝ) : UnitAddCircle) := fun u hu =>
    eq_half_of_mem_band_two (hθ u hu)
  obtain ⟨n, hn0, hn⟩ : ∃ n : ℕ, n ≠ 0 ∧ d + 1 = 4 * n := ⟨(d + 1) / 4, by omega, by omega⟩
  obtain ⟨v, v', hv, hv', h⟩ := exists_unitVectors_inv_natCast hn hF
  have h1U : (1 : unitRing F) ∈ unitSet F := ⟨(UnitRing.planeOverSubfield F).one_mem, by simp⟩
  -- `1 = n • (1 + 1 − v − v̄)`, and `θ` of the bracket is `1/2 + 1/2 − 1/2 − 1/2 = 0`
  have hone : (1 : unitRing F) = n • (1 + 1 - (⟨v, unitVectors_subset_unitRing F hv⟩ : unitRing F) -
      (⟨v', unitVectors_subset_unitRing F hv'⟩ : unitRing F)) := by
    apply Subtype.ext
    have hn' : (n : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hn0
    have h2 : (1 : ℂ) + 1 - v - v' = (n : ℂ)⁻¹ := by rw [h]; ring
    simp [h2, hn']
  have h0 : θ 1 = 0 := by
    conv_lhs => rw [hone]
    rw [map_nsmul, map_sub, map_sub, map_add, hhalf 1 h1U, hhalf _ hv, hhalf _ hv', add_sub_cancel_right, sub_self,
      smul_zero]
  rw [hhalf 1 h1U] at h0
  exact half_ne_zero h0

end HadwigerNelson.TorsionExtraction
