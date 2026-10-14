import Proofs.HadwigerNelson.Plane.DensityBound.Pattern
import Proofs.HadwigerNelson.Plane.OneAvoidingDensity

/-!
# Proposition 1 in finite-window form, and the composition proving `OneAvoidingDensityBound` (FS-131, FS131-KDB1; skeleton)

Any dual certificate `C` (valid) with a `w₀` and `µ < 1` such that `ϕ(t) ≥ 1 − µ` for all `t ≥ 0` bounds the upper density
of every Lebesgue-measurable 1-avoiding planar set by `C.bound / (1 − µ)`, at every centre. With `[AmbrusEtAl2023]`'s
certificate (`X₂₃`, `g23.csv`; the instance module `Plane/DensityBound/X23`, a lane of its own) this is Theorem 1.
Plan: `plans/FS131-KDB1-density-bound.md` § 3.
-/

namespace HadwigerNelson.DensityBound

open Real MeasureTheory Set Metric Filter
open scoped ENNReal

namespace DualCert

variable {n : ℕ} (C : DualCert n)

/-- **One window**: `(1 − µ) vol E ≤ bound · vol B(x₀, R + D)` for a bounded Borel 1-avoiding `E ⊆ B(x₀, R)`. -/
theorem window_le (hC : C.Valid) {w0 mu : ℝ} (hW : ∀ t : ℝ, 0 ≤ t → 1 - mu ≤ C.phi w0 t) {E : Set ℂ}
    (hE : MeasurableSet E) (h1 : ∀ a ∈ E, ∀ b ∈ E, dist a b ≠ 1) {x₀ : ℂ} {R D : ℝ} (hER : E ⊆ ball x₀ R)
    (hD : ∀ i, ‖C.X i‖ ≤ D) :
    (1 - mu) * (volume E).toReal ≤ C.bound * (volume (ball x₀ (R + D))).toReal := by
  have hb : Bornology.IsBounded E := isBounded_ball.subset hER
  have hlist : ∀ f : Fin n × Fin n × ℝ → ℝ, (C.w2.map f).sum = ∑ k : Fin C.w2.length, f C.w2[k] := by
    intro f
    conv_lhs => rw [← List.ofFn_getElem (xs := C.w2)]
    rw [List.map_ofFn, List.sum_ofFn]
    rfl
  -- the index type: `none` (`w₀` at radius `1`), `some none` (`Σw₁ − (1 − µ)` at radius `0`), `some (some k)` (`w₂`)
  let c : Option (Option (Fin C.w2.length)) → ℝ := fun o => match o with
    | none => w0
    | some none => ∑ i, C.w1 i - (1 - mu)
    | some (some k) => C.w2[k].2.2
  let r : Option (Option (Fin C.w2.length)) → ℝ := fun o => match o with
    | none => 1
    | some none => 0
    | some (some k) => ‖C.X C.w2[k].1 - C.X C.w2[k].2.1‖
  have hsum : ∀ f : ℝ → ℝ, ∑ o, c o * f (r o) =
      w0 * f 1 + (∑ i, C.w1 i - (1 - mu)) * f 0 +
        (C.w2.map fun e => e.2.2 * f ‖C.X e.1 - C.X e.2.1‖).sum := by
    intro f
    rw [Fintype.sum_option, Fintype.sum_option, hlist]
    simp only [c, r]
    ring
  have hW' : ∀ t : ℝ, 0 ≤ t → 0 ≤ ∑ o ∈ Finset.univ, c o * J0 (t * r o) := by
    intro t ht
    have h := hsum (fun x => J0 (t * x))
    simp only [mul_one, mul_zero, J0_zero] at h
    rw [h]
    have := hW t ht
    simp only [phi, hlist] at this
    rw [hlist]
    linarith
  have key := sum_circleAvg_autocorr_nonneg hE hb Finset.univ c r hW'
  rw [hsum (fun x => Real.circleAverage (autocorr E) 0 x), circleAvg_autocorr_one h1,
    circleAvg_autocorr_zero] at key
  have hwb := C.window_bound hC hE h1 hER hD
  nlinarith [key, hwb]

/-- **Proposition 1, finite-window form**, on the library's plane `ℂ`, at every centre. -/
theorem limsup_le (hC : C.Valid) {w0 mu : ℝ} (hmu : mu < 1) (hW : ∀ t : ℝ, 0 ≤ t → 1 - mu ≤ C.phi w0 t)
    {A : Set ℂ} (hA : NullMeasurableSet A volume) (h1 : ∀ a ∈ A, ∀ b ∈ A, dist a b ≠ 1) (x₀ : ℂ) :
    limsup (fun R : ℝ => volume (A ∩ ball x₀ R) / volume (ball x₀ R)) atTop ≤
      ENNReal.ofReal (C.bound / (1 - mu)) := by
  obtain ⟨A', hA'A, hA'm, hA'ae⟩ := hA.exists_measurable_subset_ae_eq
  set D : ℝ := ∑ i, ‖C.X i‖ with hD_def
  have hD : ∀ i, ‖C.X i‖ ≤ D := fun i =>
    Finset.single_le_sum (f := fun j => ‖C.X j‖) (fun j _ => norm_nonneg _) (Finset.mem_univ i)
  have hD0 : 0 ≤ D := Finset.sum_nonneg fun j _ => norm_nonneg _
  set β : ℝ := C.bound / (1 - mu) with hβ_def
  have hmu' : 0 < 1 - mu := by linarith
  have hball : ∀ r : ℝ, 0 ≤ r → volume (ball x₀ r) = ENNReal.ofReal (π * r ^ 2) := by
    intro r hr
    rw [Complex.volume_ball, ← ENNReal.ofReal_pow hr, ENNReal.ofReal_mul (by positivity), mul_comm]
    congr 1
    rw [← ENNReal.ofReal_coe_nnreal, NNReal.coe_real_pi]
  have hmain : ∀ R : ℝ, 0 < R →
      volume (A ∩ ball x₀ R) / volume (ball x₀ R) ≤ ENNReal.ofReal (β * ((R + D) / R) ^ 2) := by
    intro R hR
    have hEm : MeasurableSet (A' ∩ ball x₀ R) := hA'm.inter measurableSet_ball
    have hE1 : ∀ a ∈ A' ∩ ball x₀ R, ∀ b ∈ A' ∩ ball x₀ R, dist a b ≠ 1 :=
      fun a ha b hb => h1 a (hA'A ha.1) b (hA'A hb.1)
    have hwin := window_le C hC hW hEm hE1 inter_subset_right hD
    have hvol : volume (A ∩ ball x₀ R) = volume (A' ∩ ball x₀ R) :=
      measure_congr (ae_eq_set_inter hA'ae.symm (Filter.EventuallyEq.refl _ _))
    have hEfin : volume (A' ∩ ball x₀ R) ≠ ∞ :=
      measure_ne_top_of_subset inter_subset_right measure_ball_lt_top.ne
    rw [hball _ (by linarith), ENNReal.toReal_ofReal (by positivity)] at hwin
    rw [hvol, ← ENNReal.ofReal_toReal hEfin, hball R hR.le, ← ENNReal.ofReal_div_of_pos (by positivity)]
    apply ENNReal.ofReal_le_ofReal
    set e := (volume (A' ∩ ball x₀ R)).toReal
    have he : e ≤ β * (π * (R + D) ^ 2) := by
      rw [hβ_def, div_mul_eq_mul_div, le_div_iff₀ hmu']
      nlinarith [hwin]
    rw [div_le_iff₀ (by positivity)]
    calc e ≤ β * (π * (R + D) ^ 2) := he
      _ = β * ((R + D) / R) ^ 2 * (π * R ^ 2) := by field_simp
  have hlim : Tendsto (fun R : ℝ => ENNReal.ofReal (β * ((R + D) / R) ^ 2)) atTop (nhds (ENNReal.ofReal β)) := by
    apply ENNReal.tendsto_ofReal
    have h1' : Tendsto (fun R : ℝ => 1 + D * R⁻¹) atTop (nhds (1 + D * 0)) :=
      tendsto_const_nhds.add (tendsto_inv_atTop_zero.const_mul D)
    rw [mul_zero, add_zero] at h1'
    have h2 : Tendsto (fun R : ℝ => (R + D) / R) atTop (nhds 1) := by
      refine h1'.congr' ?_
      filter_upwards [eventually_gt_atTop 0] with R hR
      field_simp
    have h3 := (h2.pow 2).const_mul β
    rwa [one_pow, mul_one] at h3
  calc limsup (fun R : ℝ => volume (A ∩ ball x₀ R) / volume (ball x₀ R)) atTop
      ≤ limsup (fun R : ℝ => ENNReal.ofReal (β * ((R + D) / R) ^ 2)) atTop := by
        have hev : (fun R : ℝ => volume (A ∩ ball x₀ R) / volume (ball x₀ R)) ≤ᶠ[atTop]
            fun R : ℝ => ENNReal.ofReal (β * ((R + D) / R) ^ 2) := by
          filter_upwards [eventually_gt_atTop 0] with R hR using hmain R hR
        exact limsup_le_limsup hev
    _ = ENNReal.ofReal β := hlim.limsup_eq

/-- **The composition**: a valid certificate with `C.bound / (1 − µ) ≤ 0.2470` proves `Plane.OneAvoidingDensityBound`
(the paper's form on `EuclideanSpace ℝ (Fin 2)`, through the volume-preserving isometry with `ℂ`). -/
theorem oneAvoidingDensityBound_of (hC : C.Valid) {w0 mu : ℝ} (hmu : mu < 1)
    (hW : ∀ t : ℝ, 0 ≤ t → 1 - mu ≤ C.phi w0 t) (hβ : C.bound / (1 - mu) ≤ 0.2470) :
    Plane.OneAvoidingDensityBound := by
  intro A hA h1 x
  set e : ℂ ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin 2) := Complex.orthonormalBasisOneI.repr
  have hmp : MeasurePreserving e volume volume := e.measurePreserving
  have hemb : MeasurableEmbedding e := e.toHomeomorph.measurableEmbedding
  have hA' : NullMeasurableSet (e ⁻¹' A) volume := hA.preimage hmp.quasiMeasurePreserving
  have h1' : ∀ a ∈ e ⁻¹' A, ∀ b ∈ e ⁻¹' A, dist a b ≠ 1 := fun a ha b hb => by
    have := h1 (e a) ha (e b) hb
    rwa [LinearIsometryEquiv.dist_map] at this
  have hfun : (fun R : ℝ => volume (A ∩ ball x R) / volume (ball x R)) =
      fun R => volume (e ⁻¹' A ∩ ball (e.symm x) R) / volume (ball (e.symm x) R) := by
    funext R
    rw [← e.preimage_ball x R, ← preimage_inter, hmp.measure_preimage_emb hemb, hmp.measure_preimage_emb hemb]
  rw [hfun]
  exact (limsup_le C hC hmu hW hA' h1' (e.symm x)).trans (ENNReal.ofReal_le_ofReal hβ)

end DualCert

/-- **A model of `DualCert.limsup_le`'s hypotheses, all at once**: `trivialCert` (valid, `trivialCert_valid`) with `w₀ = 0`,
`µ = 0`, where `ϕ ≡ 1 ≥ 1 − 0`; with `A` the open disc of radius `1/2` (measurable, 1-avoiding:
`Plane.oneAvoidingDensityBound_model` on the other plane) the conclusion is the true bound `limsup ≤ 1`. -/
example : ∀ t : ℝ, 0 ≤ t → 1 - 0 ≤ trivialCert.phi 0 t := by
  intro t _
  simp [DualCert.phi, trivialCert]

end HadwigerNelson.DensityBound

open Lean Elab Command in
#eval show CommandElabM Unit from do
  let ci ← getConstInfo `HadwigerNelson.DensityBound.DualCert.window_le
  IO.println s!"CTL TYPE {ci.type.hash}"
