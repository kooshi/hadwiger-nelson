import Proofs.HadwigerNelson.Plane.OneClass.Pair
/-!
FS133-IPQ1 — the models of the hypotheses, checked by the elaborator (a scratch file, not the library).

* The public statements: the brick seven-colouring (`exists_admissible_colourPattern_seven`) meets every hypothesis of
  `exists_admissibleOn_of_ae` and of `exists_measurable_admissibleAe` at once, at the colouring pattern
  (`isAlgPattern_colourPattern`), and both conclusions are then reached from it.
* The private helpers of `Pair` (not visible here): their hypotheses written out and met by one object each —
  `exists_slice_ne_zero`, `prod_pairs_ne_zero` at `A = B = univ`, `x = 0`, `y = 1`, `r = 1`;
  `isPlaneSystem_lab` at the point mass of a constant labelling.
-/
open MeasureTheory Filter Set
open HadwigerNelson HadwigerNelson.OneClass HadwigerNelson.Plane HadwigerNelson.Outside.OAI158
  HadwigerNelson.Outside.OAI158.Spectral

/-- `exists_admissibleOn_of_ae`'s hypotheses, all at once, at the brick colouring; and its conclusion. -/
example : ∃ ℓ : ℂ → Fin 7, AdmissibleOn (colourPattern (Fin 7)) univ ℓ := by
  obtain ⟨ℓ, hm, -, hae⟩ := exists_admissible_colourPattern_seven
  exact exists_admissibleOn_of_ae (isAlgPattern_colourPattern _).pos
    (fun a => (hm (measurableSet_singleton a)).nullMeasurableSet) hae

/-- `exists_measurable_admissibleAe`'s hypotheses at the brick colouring restricted to the algebraic plane. -/
example : ∃ ℓ' : ℂ → Fin 7, (∀ a, MeasurableSet (ℓ' ⁻¹' {a})) ∧ AdmissibleAe (colourPattern (Fin 7)) ℓ' := by
  obtain ⟨ℓ, -, hadm, -⟩ := exists_admissible_colourPattern_seven
  exact exists_measurable_admissibleAe (isAlgPattern_colourPattern _) (hadm.mono (subset_univ _))

/-- `exists_slice_ne_zero`'s and `prod_pairs_ne_zero`'s hypotheses at `A = B = univ`, `x = 0`, `y = 1`, `r = 1`. -/
example : NullMeasurableSet (univ : Set ℂ) volume ∧ HasDensityOneAt volume (univ : Set ℂ) 0 ∧
    HasDensityOneAt volume (univ : Set ℂ) 1 ∧ (0 : ℝ) < 1 ∧ dist (0 : ℂ) 1 = 1 :=
  ⟨MeasurableSet.univ.nullMeasurableSet, hasDensityOneAt_univ 0, hasDensityOneAt_univ 1, one_pos, by simp⟩

/-- `isPlaneSystem_lab`'s hypotheses at the point mass of a constant labelling (`Λ = Fin 2`, the full σ-algebra). -/
example : letI : MeasurableSpace (Fin 2) := ⊤
    IsProbabilityMeasure (Measure.dirac (fun _ : E => (0 : Fin 2))) ∧
      (∀ z, (Measure.dirac (fun _ : E => (0 : Fin 2))).map (shiftLab z) = Measure.dirac (fun _ : E => (0 : Fin 2))) ∧
      ∀ u, (Measure.dirac (fun _ : E => (0 : Fin 2))).map (turnLab u) = Measure.dirac (fun _ : E => (0 : Fin 2)) := by
  letI : MeasurableSpace (Fin 2) := ⊤
  refine ⟨inferInstance, fun z => ?_, fun u => ?_⟩
  · have hm : Measurable (shiftLab z : (E → Fin 2) → E → Fin 2) := measurable_pi_lambda _ fun _ => measurable_pi_apply _
    rw [Measure.map_dirac' hm]
    rfl
  · have hm : Measurable (turnLab u : (E → Fin 2) → E → Fin 2) := measurable_pi_lambda _ fun _ => measurable_pi_apply _
    rw [Measure.map_dirac' hm]
    rfl
