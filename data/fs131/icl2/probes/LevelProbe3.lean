import Proofs.HadwigerNelson.Rigidity.CountResidue
namespace HadwigerNelson.Rigidity.Counting
open SpectralChain NumberField
variable (F : Subfield ℝ) [NumberField F]
theorem probeB (Φ : Finset (StablePrime F)) :
    ∃ B : ℕ, ∀ P ∈ Φ, Ideal.absNorm P.P ≤ B := by
  have hgen : ∀ (s : Finset (StablePrime F)) (f : StablePrime F → ℕ), ∃ B : ℕ, ∀ P ∈ s, f P ≤ B :=
    fun s f => ⟨s.sup f, fun P hP => Finset.le_sup hP⟩
  exact hgen Φ fun P => Ideal.absNorm P.P
end HadwigerNelson.Rigidity.Counting
