import Proofs.HadwigerNelson.Plane.Suprema
import Proofs.HadwigerNelson.Plane.OneClass.Defs
import Mathlib.Analysis.InnerProductSpace.PiL2

/-!
# `m₁(ℝ²) < 1/4`: the density of planar sets avoiding unit distances, as a named outside hypothesis (FS-131, job FS131-KR1; module M12's input; skeleton)

**Read aloud, against the paper.** `OneAvoidingDensityBound` is `[AmbrusEtAl2023]` Theorem 1 (arXiv:2207.14179 v3, p. 4) in
the paper's own form: "Any Lebesgue measurable, 1-avoiding planar set has upper density at most 0.2470", with the paper's
definitions (p. 2): a set is *1-avoiding* when it is independent in the unit distance graph, and its *upper density* is
`δ(A) = lim sup_{R→∞} λ₂(A ∩ B₂(x, R)) / λ₂(B₂(x, R))` "where `x ∈ ℝ^d` is fixed", the paper adding that it "is known to be
independent of the choice of `x`" — so the statement is made for every centre `x`. Lebesgue measurable is
`NullMeasurableSet A volume`; the plane is `EuclideanSpace ℝ (Fin 2)` with its Lebesgue measure; `B₂(x, R)` is the open ball
(an open and a closed ball differ by a null sphere, so the limsup is the same). **An external theorem, computer-assisted, a
named hypothesis of the library standing for it — not declared as an axiom** (the coordinator's ruling of 2026-10-14: an
axiom is Kooshi's decision; FS131-KR1 drafts its four items in `plans/FS131-KR1-chain-map.md`).

**The library's form.** `mOne` is `m₁(ℝ²)` on the library's plane `ℂ` (eq. (1) of the paper: the supremum of the upper
densities of measurable 1-avoiding sets), defined once, in `Plane/OneClass/Defs` (over Borel sets); `mOne_eq_iSup_bandFree`
states it over Lebesgue-measurable sets with `Plane.upperDensity` (balls centred at `0`) and `BandFree A 0` (no pair at
distance exactly `1`), the form this module first defined it by (the coordinator's ruling at FS131-LDB1, when the two
lines met). `upperDensity_le_of_oneAvoidingDensityBound` carries the paper's form to `ℂ` through the isometry
`Complex.orthonormalBasisOneI.repr`, which preserves volume; `mOne_lt_quarter` is what the count (module M12) reads.

**Model of the hypotheses** (`LEAN.md` § Assumptions, item 3): `oneAvoidingDensityBound_model` — the open ball of radius
`1/2` is measurable and 1-avoiding (any two of its points are less than `1` apart).
-/

namespace HadwigerNelson.Plane

open MeasureTheory Filter Metric

/-- **`[AmbrusEtAl2023]` Theorem 1, as printed** (arXiv:2207.14179 v3, p. 4; definitions p. 2 and eq. (1)): every Lebesgue
measurable, 1-avoiding planar set has upper density at most `0.2470`, at every centre. External: a named hypothesis standing
for an outside theorem, not proved in the library. -/
def OneAvoidingDensityBound : Prop :=
  ∀ A : Set (EuclideanSpace ℝ (Fin 2)), NullMeasurableSet A volume → (∀ a ∈ A, ∀ b ∈ A, dist a b ≠ 1) →
    ∀ x : EuclideanSpace ℝ (Fin 2),
      limsup (fun R : ℝ => volume (A ∩ ball x R) / volume (ball x R)) atTop ≤ ENNReal.ofReal 0.2470

/-- **`m₁(ℝ²)` over Lebesgue-measurable sets**: `mOne` (`Plane/OneClass/Defs`, a supremum over Borel sets) is the supremum
of the upper densities of the Lebesgue-measurable sets with no pair at distance `1` — by `mOne_eq_iSup_nullMeasurableSet`,
and `isIndepSet_unitDistance_iff` for `BandFree A 0`. -/
theorem mOne_eq_iSup_bandFree :
    mOne = ⨆ (A : Set ℂ) (_ : NullMeasurableSet A volume ∧ BandFree A 0), upperDensity A := by
  rw [mOne_eq_iSup_nullMeasurableSet]
  refine iSup_congr fun A => ?_
  rw [iSup_and]
  refine iSup_congr fun _ => ?_
  have h : (unitDistance ℂ).IsIndepSet A ↔ BandFree A 0 := by
    rw [isIndepSet_unitDistance_iff]
    simp only [BandFree, sub_zero, add_zero]
    exact forall₂_congr fun x _ => forall₂_congr fun y _ => ne_iff_lt_or_gt
  exact iSup_congr_Prop h fun _ => rfl

/-- **A model of the hypotheses** of `OneAvoidingDensityBound`: the open ball of radius `1/2` about `0`. -/
theorem oneAvoidingDensityBound_model :
    NullMeasurableSet (ball (0 : EuclideanSpace ℝ (Fin 2)) (1 / 2)) volume ∧
      ∀ a ∈ ball (0 : EuclideanSpace ℝ (Fin 2)) (1 / 2), ∀ b ∈ ball (0 : EuclideanSpace ℝ (Fin 2)) (1 / 2),
        dist a b ≠ 1 := by
  refine ⟨measurableSet_ball.nullMeasurableSet, fun a ha b hb => ?_⟩
  rw [mem_ball] at ha hb
  have h := dist_triangle_right a b 0
  exact ne_of_lt (by linarith)

/-- **The bound on the library's plane**: from the paper's form through the volume-preserving isometry `ℂ ≅ ℝ²`. -/
theorem upperDensity_le_of_oneAvoidingDensityBound (h : OneAvoidingDensityBound) {A : Set ℂ}
    (hA : NullMeasurableSet A volume) (h1 : BandFree A 0) : upperDensity A ≤ ENNReal.ofReal 0.2470 := by
  set e : ℂ ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin 2) := Complex.orthonormalBasisOneI.repr
  have hmp : MeasurePreserving e.symm volume volume := e.symm.measurePreserving
  have hemb : MeasurableEmbedding e.symm := e.symm.toHomeomorph.measurableEmbedding
  have hA₂ : NullMeasurableSet (e.symm ⁻¹' A) volume := hA.preimage hmp.quasiMeasurePreserving
  have h1₂ : ∀ a ∈ e.symm ⁻¹' A, ∀ b ∈ e.symm ⁻¹' A, dist a b ≠ 1 := by
    intro a ha b hb
    have h := h1 _ ha _ hb
    rw [LinearIsometryEquiv.dist_map] at h
    rcases h with h | h
    · exact ne_of_lt (by linarith)
    · exact ne_of_gt (by linarith)
  have hfun : (fun R : ℝ => volume (A ∩ ball 0 R) / volume (ball (0 : ℂ) R)) =
      fun R => volume (e.symm ⁻¹' A ∩ ball 0 R) / volume (ball (0 : EuclideanSpace ℝ (Fin 2)) R) := by
    funext R
    have hb : e.symm ⁻¹' ball (0 : ℂ) R = ball 0 R := by
      rw [e.symm.preimage_ball, LinearIsometryEquiv.symm_symm, map_zero]
    rw [← hb, ← Set.preimage_inter, hmp.measure_preimage_emb hemb, hmp.measure_preimage_emb hemb]
  rw [upperDensity, hfun]
  exact h _ hA₂ h1₂ 0

/-- `m₁(ℝ²) ≤ 0.2470`, given the outside theorem. -/
theorem mOne_le_of_oneAvoidingDensityBound (h : OneAvoidingDensityBound) : mOne ≤ ENNReal.ofReal 0.2470 :=
  mOne_eq_iSup_bandFree ▸ iSup₂_le fun _ hA => upperDensity_le_of_oneAvoidingDensityBound h hA.1 hA.2

/-- **`m₁(ℝ²) < 1/4`**, given the outside theorem — the form the count reads. -/
theorem mOne_lt_quarter (h : OneAvoidingDensityBound) : mOne < ENNReal.ofReal (1 / 4) :=
  (mOne_le_of_oneAvoidingDensityBound h).trans_lt ((ENNReal.ofReal_lt_ofReal_iff (by norm_num)).mpr (by norm_num))

end HadwigerNelson.Plane
