import Proofs.HadwigerNelson.Rigidity.CountResidue
namespace HadwigerNelson.Rigidity.Counting
open SpectralChain NumberField
variable {F : Subfield ℝ} [NumberField F]
set_option maxHeartbeats 400000 in
theorem probe1 (K : ℕ) (r : unitRing F) (P : StablePrime F) (hPk : P ∈ level F K) :
    (levR F K r : ∀ P : level F K, 𝓞 (fieldI F) ⧸ P.1.P ^ K) ⟨P, hPk⟩ = resR P K r := by
  rfl
theorem probe2 (K : ℕ) (P : StablePrime F) (hPk : P ∈ level F K) :
    ((0 : Lev F K) : ∀ P : level F K, 𝓞 (fieldI F) ⧸ P.1.P ^ K) ⟨P, hPk⟩ = 0 := by
  rfl
end HadwigerNelson.Rigidity.Counting
