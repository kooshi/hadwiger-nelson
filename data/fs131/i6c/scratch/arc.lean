import Proofs.HadwigerNelson.Plane.Saturated.Pinch
namespace HadwigerNelson.Plane
open Complex Set MeasureTheory Filter Topology Metric
#check @Continuous.integral_hasStrictDerivAt
#check @strictMono_of_deriv_pos
#check @monotone_of_deriv_nonneg
#check @Continuous.surjective
#check @StrictMono.orderIsoOfSurjective
#check @HasDerivAt.of_local_left_inverse
#check @OrderIso.image_Ioo
#check @tendsto_atTop_mono'
#check @tendsto_atBot_mono'

/-- **The arclength reparametrization** (FS131-I6C; Mathlib has none): for a continuous speed `σ ≥ 1` on `[−h, h]`,
the inverse `V` of the arclength `u ↦ ∫₀^u σ` is defined on a symmetric interval `(−ℓ, ℓ)`, maps it increasingly onto
an interval `(a, b)` about `0` inside `[−h, h]`, and has derivative `1/σ (V s)`. (The integrand is `σ` clamped to
`[−h, h]`, so the arclength is an order isomorphism of the line and its inverse is continuous for free.) -/
theorem exists_arclength_inverse {σ : ℝ → ℝ} {h : ℝ} (hh : 0 < h) (hσc : ContinuousOn σ (Icc (-h) h))
    (hσ1 : ∀ u ∈ Icc (-h) h, 1 ≤ σ u) :
    ∃ (ℓ : ℝ) (V : ℝ → ℝ) (a b : ℝ), 0 < ℓ ∧ -h ≤ a ∧ a < 0 ∧ 0 < b ∧ b ≤ h ∧ V 0 = 0 ∧
      StrictMonoOn V (Ioo (-ℓ) ℓ) ∧ V '' Ioo (-ℓ) ℓ = Ioo a b ∧ ∀ s ∈ Ioo (-ℓ) ℓ, HasDerivAt V (σ (V s))⁻¹ s := by
  have hclamp : ∀ u : ℝ, max (-h) (min h u) ∈ Icc (-h) h := fun u =>
    ⟨le_max_left _ _, max_le (by linarith) (min_le_left _ _)⟩
  set σ' : ℝ → ℝ := fun u => σ (max (-h) (min h u)) with hσ'
  have hc : Continuous σ' := hσc.comp_continuous (by fun_prop) hclamp
  have h1 : ∀ u, 1 ≤ σ' u := fun u => hσ1 _ (hclamp u)
  have heq : ∀ u ∈ Icc (-h) h, σ' u = σ u := fun u hu => by
    simp only [hσ', min_eq_right hu.2, max_eq_right hu.1]
  set S : ℝ → ℝ := fun u => ∫ t in (0 : ℝ)..u, σ' t with hS
  have hSd : ∀ u, HasDerivAt S (σ' u) u := fun u => (hc.integral_hasStrictDerivAt 0 u).hasDerivAt
  have hS0 : S 0 = 0 := by simp [hS]
  have hmono : StrictMono S := strictMono_of_deriv_pos fun u => by
    rw [(hSd u).deriv]; linarith [h1 u]
  have hDd : ∀ u, HasDerivAt (fun u => S u - u) (σ' u - 1) u := fun u => (hSd u).sub (hasDerivAt_id' u)
  have hD : Monotone fun u => S u - u :=
    monotone_of_deriv_nonneg (fun u => (hDd u).differentiableAt) fun u => by
      rw [(hDd u).deriv]; linarith [h1 u]
  have hge : ∀ u, 0 ≤ u → u ≤ S u := fun u hu => by
    have h2 : S 0 - 0 ≤ S u - u := hD hu
    linarith
  have hle : ∀ u, u ≤ 0 → S u ≤ u := fun u hu => by
    have h2 : S u - u ≤ S 0 - 0 := hD hu
    linarith
  have hsurj : Function.Surjective S :=
    (continuous_iff_continuousAt.2 fun u => (hSd u).continuousAt).surjective
      (tendsto_atTop_mono' atTop ((eventually_ge_atTop 0).mono fun u hu => hge u hu) tendsto_id)
      (tendsto_atBot_mono' atBot ((eventually_le_atBot 0).mono fun u hu => hle u hu) tendsto_id)
  set E : ℝ ≃o ℝ := hmono.orderIsoOfSurjective S hsurj with hE
  have hES : ∀ u, E u = S u := fun u => rfl
  have hV0 : E.symm 0 = 0 := E.symm_apply_eq.2 hS0.symm
  set ℓ : ℝ := min (S h) (-S (-h)) with hℓ
  have hℓ0 : 0 < ℓ := lt_min (lt_of_lt_of_le hh (hge h hh.le)) (by linarith [hle (-h) (by linarith)])
  have ha : -h ≤ E.symm (-ℓ) := by
    rw [← E.symm_apply_apply (-h)]
    exact E.symm.monotone (by rw [hES]; linarith [min_le_right (S h) (-S (-h))])
  have hb : E.symm ℓ ≤ h := by
    rw [← E.symm_apply_apply h]
    exact E.symm.monotone (by rw [hES]; exact min_le_left _ _)
  refine ⟨ℓ, E.symm, E.symm (-ℓ), E.symm ℓ, hℓ0, ha, ?_, ?_, hb, hV0, E.symm.strictMono.strictMonoOn _,
    E.symm.image_Ioo _ _, fun s hs => ?_⟩
  · rw [← hV0]; exact E.symm.strictMono (by linarith)
  · rw [← hV0]; exact E.symm.strictMono hℓ0
  · have hmem : E.symm s ∈ Icc (-h) h :=
      ⟨ha.trans (E.symm.monotone hs.1.le), (E.symm.monotone hs.2.le).trans hb⟩
    rw [← heq _ hmem]
    exact HasDerivAt.of_local_left_inverse E.symm.continuous.continuousAt (hSd (E.symm s))
      (by linarith [h1 (E.symm s)]) (Eventually.of_forall fun t => E.apply_symm_apply t)

end HadwigerNelson.Plane
