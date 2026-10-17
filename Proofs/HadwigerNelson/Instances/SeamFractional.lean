import Proofs.HadwigerNelson.Collapse.Density.Upper
import Proofs.HadwigerNelson.Arith.QuadraticPrime
import Proofs.HadwigerNelson.SquareClass

/-!
# The fractional chromatic number of the plane over `ℚ(√3, √11)` is 4 (FS-131, FS131-KFS1; skeleton)

**The question** (`[CranstonRabern2015]`, concluding section): *"What is the fractional chromatic number of
ℚ(√3,√11) × ℚ(√3,√11)?"*

**Read aloud, against the informal claim** (`CLOSED-QUESTIONS.md` § 1.6; `plans/FS56-field-blowup.md` B3). With `K = ℚ(√3, √11)`
(`seamField`) and `K²` the unit-distance graph on the points with both coordinates in `K` (`seamPlane`):
* `fractionalChromaticNumber_seamPlane` — `χ_f(K²) = 4`;
* `finIndepRatio_seamPlane` — the finitary independence ratio is `1/4`: every finite unit-distance graph over `K` has an
  independent set of a quarter of its vertices, and no fraction above `1/4` works for all of them;
* `iSup_fractionalChromaticNumber_seamPlane` — the finite subgraphs' fractional chromatic numbers have supremum 4.

**The route** (FS131-KFS1 § 2.2, route B-I). Upper: Theorem B, `four_colorable_of_seam_field` (`[Fischer1994]`'s value). Lower:
an invariant random independent set of `Cay(R, U)` with density at least `α₁(K²)` (`Collapse.exists_indepLaw`, the
amenability step, on the standard three) has density at most `1/4` by `[MatolcsiEtAl2025]`'s 27-point certificate
(`IndepLaw.density_le_quarter_seamField`, its Theorem 3 checked by the kernel). No blow-up and no measure rigidity.

**What it rests on** (planned): the standard three axioms.

**Not claimed:** `χ_f` at any other field; that the value is new (prior art: FS131-PAS2's to find; the Moser ring's instance
of the geometric bound is `[Ducz2026]` Thm 3.1).
-/

namespace HadwigerNelson.Instances.SeamFractional

open SimpleGraph Collapse SpectralChain
open scoped ENNReal

/-- `ℚ(√3, √11)` is a number field: a subfield of `fieldOfRadicands {3, 11}`. -/
theorem numberField_seamField : NumberField seamField := by
  let f : seamField →+* SquareClass.fieldOfRadicands {3, 11} :=
    { toFun := fun x => ⟨x, SquareClass.seamField_le_fieldOfRadicands x.2⟩
      map_one' := rfl, map_mul' := fun _ _ => rfl, map_zero' := rfl, map_add' := fun _ _ => rfl }
  have hf : Function.Injective f := fun _ _ h =>
    Subtype.ext (congrArg (fun z : SquareClass.fieldOfRadicands {3, 11} => (z : ℝ)) h)
  exact { to_finiteDimensional := Module.Finite.of_injective f.toRatAlgHom.toLinearMap hf }

instance : NumberField seamField := numberField_seamField

/-- **`[MatolcsiEtAl2025]` Thm 3, read against an invariant random independent set**: every `R ⋊ U`-invariant random
independent set of `Cay(R, U)` over `ℚ(√3, √11)` has density at most `1/4`. The certificate (level 12, 28,496 weighted sets,
11,640 congruence classes; `data/fs56/g27/cert-g27-mrvz.json`) weighs every independent set of `G27` at most 1 and its
singletons `4`; invariance makes `P(Y ⊆ I)` constant on each congruence class. -/
theorem IndepLaw.density_le_quarter_seamField (μ : IndepLaw seamField) : μ.density ≤ 4⁻¹ := by
  sorry

/-- The finitary independence ratio is at most `1/4` (the lower half of `χ_f ≥ 4`). -/
theorem finIndepRatio_seamPlane_le : ((unitDistance ℂ).induce seamPlane).finIndepRatio ≤ 4⁻¹ := by
  obtain ⟨μ, hμ⟩ := exists_indepLaw (F := seamField)
  rw [← planeOver_seamField]
  exact (finIndepRatio_planeOver_le_cayR.trans hμ).trans (IndepLaw.density_le_quarter_seamField μ)

/-- **The fractional chromatic number of the plane over `ℚ(√3, √11)` is 4** (`[CranstonRabern2015]`'s question). The upper
bound is `[Fischer1994]`'s value, Theorem B (`four_colorable_of_seam_field`); the lower is `[MatolcsiEtAl2025]` Thm 3's
certificate for `G27` read against an invariant random independent set (`IndepLaw.density_le_quarter_seamField`). -/
theorem fractionalChromaticNumber_seamPlane :
    ((unitDistance ℂ).induce seamPlane).fractionalChromaticNumber = 4 := by
  refine le_antisymm ?_ ?_
  · simpa using (four_colorable_of_seam_field.fractionalColorable).fractionalChromaticNumber_le one_pos
  · have h4 : (4 : ℝ≥0∞) ≤ ((unitDistance ℂ).induce seamPlane).finIndepRatio⁻¹ := by
      rw [ENNReal.le_inv_iff_le_inv]
      exact finIndepRatio_seamPlane_le
    exact h4.trans ((inv_finIndepRatio_le_iSup_fractionalChromaticNumber _).trans
      (iSup_le fun S => OneClass.fractionalChromaticNumber_induce_le _ _))

/-- **`α₁(ℚ(√3, √11)²) = 1/4`.** -/
theorem finIndepRatio_seamPlane : ((unitDistance ℂ).induce seamPlane).finIndepRatio = 4⁻¹ := by
  refine le_antisymm finIndepRatio_seamPlane_le ?_
  have h := (inv_finIndepRatio_le_iSup_fractionalChromaticNumber ((unitDistance ℂ).induce seamPlane)).trans
    ((iSup_le fun S => OneClass.fractionalChromaticNumber_induce_le _ _).trans fractionalChromaticNumber_seamPlane.le)
  rwa [ENNReal.inv_le_iff_inv_le] at h

/-- **The finite subgraphs**: `sup_S χ_f(K²[S]) = 4`. -/
theorem iSup_fractionalChromaticNumber_seamPlane :
    ⨆ S : Finset seamPlane, (((unitDistance ℂ).induce seamPlane).induce (S : Set seamPlane)).fractionalChromaticNumber
      = 4 := by
  refine le_antisymm ((iSup_le fun S => OneClass.fractionalChromaticNumber_induce_le _ _).trans
    fractionalChromaticNumber_seamPlane.le) ?_
  have h4 : (4 : ℝ≥0∞) ≤ ((unitDistance ℂ).induce seamPlane).finIndepRatio⁻¹ := by
    rw [ENNReal.le_inv_iff_le_inv]
    exact finIndepRatio_seamPlane_le
  exact h4.trans (inv_finIndepRatio_le_iSup_fractionalChromaticNumber _)

end HadwigerNelson.Instances.SeamFractional
