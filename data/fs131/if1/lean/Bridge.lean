import Proofs.HadwigerNelson.Plane.Cover
import Mathlib.MeasureTheory.Measure.Lebesgue.Complex

/-! FS131-IF1, stage 2: the general theorem's conclusion at `E = ℂ`, `μ = volume` is the axiom's statement, by unfolding
(`densitySet`, `densityRatio`); and the instances the general theorem asks of `ℂ` resolve from `FalconerReduction`'s imports. -/

open Set MeasureTheory Filter Topology Metric HadwigerNelson.Plane

example : (volume : Measure ℂ).IsAddHaarMeasure := inferInstance
example : FiniteDimensional ℝ ℂ := inferInstance
example : BorelSpace ℂ := inferInstance
example : Module.finrank ℝ ℂ = 2 := Complex.finrank_real_complex

example
    (H : ∀ {S : Set ℂ}, NullMeasurableSet S volume → volume S ≠ 0 → volume Sᶜ ≠ 0 →
      ∃ x : ℂ, ¬ Tendsto (fun r => volume (S ∩ closedBall x r) / volume (closedBall x r)) (𝓝[>] 0) (𝓝 1) ∧
        ¬ Tendsto (fun r => volume (Sᶜ ∩ closedBall x r) / volume (closedBall x r)) (𝓝[>] 0) (𝓝 1))
    {S : Set ℂ} (hS : MeasurableSet S) (h1 : volume S ≠ 0) (h2 : volume Sᶜ ≠ 0) :
    ∃ x : ℂ, x ∉ densitySet S ∧ x ∉ densitySet Sᶜ :=
  H hS.nullMeasurableSet h1 h2
