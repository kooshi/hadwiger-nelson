import Proofs.HadwigerNelson.Rigidity.CountResidue
namespace HadwigerNelson.Rigidity.Counting
open SpectralChain NumberField
variable (F : Subfield ℝ) [NumberField F]
theorem probeA {N : ℕ} (hN : N ≠ 0) :
    ∃ k : ℕ, ∀ r : unitRing F, levR F k r = 0 → ∃ y : unitRing F, r = N • y := by
  obtain ⟨Φ, m, hΦ⟩ := exists_mem_nsmul_of_resR_eq_zero (F := F) hN
  have key : ∀ K, m ≤ K → (∀ P ∈ Φ, Ideal.absNorm P.P ≤ K) →
      ∀ r : unitRing F, levR F K r = 0 → ∃ y : unitRing F, r = N • y := by
    sorry
  exact ⟨_, key _ (le_max_left _ _) fun P hP =>
    le_trans (Finset.le_sup (f := fun P => Ideal.absNorm P.P) hP) (le_max_right m _)⟩
theorem probeB {N : ℕ} (hN : N ≠ 0) (Φ : Finset (StablePrime F)) (m : ℕ) (hΦ : ∀ r : unitRing F, (∀ P ∈ Φ, resR P m r = 0) → ∃ y : unitRing F, r = N • y) : ∀ K, m ≤ K → (∀ P ∈ Φ, Ideal.absNorm P.P ≤ K) →
      ∀ r : unitRing F, levR F K r = 0 → ∃ y : unitRing F, r = N • y := by
    intro K hmK hΦK r hr
    refine hΦ r fun P hP => resR_eq_zero_of_le P hmK ?_
    have hPk : P ∈ level F K := (mem_level F).2 (hΦK P hP)
    sorry
end HadwigerNelson.Rigidity.Counting
