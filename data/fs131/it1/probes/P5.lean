import Proofs.HadwigerNelson.Arith.ThreeColourCharacter

namespace HadwigerNelson.TorsionExtraction

open HadwigerNelson.CharacterColouring HadwigerNelson.SpectralChain HadwigerNelson.SquareClass SimpleGraph

variable {F : Subfield ℝ}

/-- `1/5 = w + w⁻¹ − 1` as an element of `ℤ[U_F]`. -/
noncomputable def inv5 (F : Subfield ℝ) : unitRing F := ⟨(5 : ℂ)⁻¹, unitRing_mono bot_le inv_five_mem_Qring⟩

private theorem unitRing_induction {p : unitRing F → Prop} (h0 : p 0) (hadd : ∀ x y, p x → p y → p (x + y))
    (hu : ∀ u ∈ unitSet F, p u) (x : unitRing F) : p x := by
  sorry

theorem tendsto_layer {θ : unitRing F →+ UnitAddCircle} (hθ : θ ∈ fieldBandSet F (band 3)) {b : unitRing F}
    (hb : b ∈ unitSet F) :
    ∃ t : UnitAddCircle, (t = ((1 / 2 : ℝ) : UnitAddCircle) ∨ t = ((1 / 3 : ℝ) : UnitAddCircle) ∨
        t = ((2 / 3 : ℝ) : UnitAddCircle)) ∧
      Filter.Tendsto (fun n : ℕ => θ (inv5 F ^ (2 * n) * b)) Filter.atTop (nhds t) := by
  sorry

theorem exists_torsion_mem_fieldBandSet (F : Subfield ℝ) (h : (fieldBandSet F (band 3)).Nonempty) :
    ∃ τ ∈ fieldBandSet F (band 3), τ ∈ torsionBy (unitRing F) 6 := by
  obtain ⟨θ, hθ⟩ := h
  -- the limit along `25⁻ⁿ` exists at every element: at unit vectors by `tendsto_layer`, and limits add
  have hconv : ∀ x : unitRing F, ∃ t : UnitAddCircle,
      Filter.Tendsto (fun n : ℕ => θ (inv5 F ^ (2 * n) * x)) Filter.atTop (nhds t) := by
    refine unitRing_induction
      (p := fun x => ∃ t : UnitAddCircle, Filter.Tendsto (fun n : ℕ => θ (inv5 F ^ (2 * n) * x)) Filter.atTop (nhds t))
      ?_ ?_ ?_
    · refine ⟨0, ?_⟩
      simp only [mul_zero, map_zero]
      exact tendsto_const_nhds
    · rintro x y ⟨s, hs⟩ ⟨t, ht⟩
      refine ⟨s + t, ?_⟩
      simp only [mul_add, map_add]
      exact hs.add ht
    · intro u hu
      obtain ⟨t, -, ht⟩ := tendsto_layer hθ hu
      exact ⟨t, ht⟩
  choose τ hτ using hconv
  -- the limit is additive
  have hadd : ∀ x y, τ (x + y) = τ x + τ y := by
    intro x y
    refine tendsto_nhds_unique (hτ (x + y)) ?_
    simp only [mul_add, map_add]
    exact (hτ x).add (hτ y)
  -- at a unit vector it is `1/2`, `1/3` or `2/3`
  have hval : ∀ u ∈ unitSet F, τ u = ((1 / 2 : ℝ) : UnitAddCircle) ∨ τ u = ((1 / 3 : ℝ) : UnitAddCircle) ∨
      τ u = ((2 / 3 : ℝ) : UnitAddCircle) := by
    intro u hu
    obtain ⟨t, ht, htend⟩ := tendsto_layer hθ hu
    rw [tendsto_nhds_unique (hτ u) htend]
    exact ht
  refine ⟨AddMonoidHom.mk' τ hadd, fun u hu => ?_, ?_⟩
  · show τ u ∈ band 3
    rcases hval u hu with h | h | h
    · exact ⟨1 / 2, ⟨by norm_num, by norm_num⟩, h.symm⟩
    · exact ⟨1 / 3, ⟨by norm_num, by norm_num⟩, h.symm⟩
    · exact ⟨2 / 3, ⟨by norm_num, by norm_num⟩, h.symm⟩
  · rw [mem_torsionBy]
    ext x
    show 6 • τ x = 0
    refine unitRing_induction (p := fun x => 6 • τ x = 0) ?_ ?_ ?_ x
    · rw [show τ 0 = 0 from (AddMonoidHom.mk' τ hadd).map_zero, smul_zero]
    · intro x y hx hy
      rw [hadd, smul_add, hx, hy, add_zero]
    · intro u hu
      rcases hval u hu with h | h | h <;> rw [h, ← AddCircle.coe_nsmul, AddCircle.coe_eq_zero_iff]
      · exact ⟨3, by norm_num⟩
      · exact ⟨2, by norm_num⟩
      · exact ⟨4, by norm_num⟩

end HadwigerNelson.TorsionExtraction
