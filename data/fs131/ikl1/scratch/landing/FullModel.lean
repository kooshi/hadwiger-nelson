import Proofs.HadwigerNelson.Rigidity.ClassRatio
import Proofs.HadwigerNelson.Rigidity.CertLinkModels
/-! FS131-IKL1 — the landing's draft of the full model of `CertLink.card_le_of_fibreShareBound`, checked against the farm's
scratch `ClassRatio` (wcm4's, with the two discharge lemmas): at the stable prime of `exists_stablePrime_sqrt_three`, every
hypothesis holds at once — the stable-prime clauses, `HenselCount`, `NewCharBound` (ClassRatio's Lemma P) and
`FibreShareBound 3` (FS-66's `p = 3` certificate, `FibreCertSound.sum_le_of_certOK cert3 cert3_ok`). -/
namespace HadwigerNelson.CertLink
open SpectralChain NumberField SquareClass

theorem fibreShareBound_three :
    FibreShareBound 3 ((FibreCert.cert3.unum : ℝ) / FibreCert.cert3.scale) :=
  fun φ h0 h1 hq => by
    haveI : NeZero FibreCert.cert3.p := ⟨by decide⟩
    exact FibreCertSound.sum_le_of_certOK FibreCert.cert3 FibreCert.cert3_ok φ h0 h1 hq

/-- **The full model of `card_le_of_fibreShareBound`** (at `q = 3`, `F = ℚ(√3)`). -/
theorem card_le_of_fibreShareBound_model :
    ∃ P : StablePrime (fieldOfRadicands {3}), (2 : 𝓞 (fieldI (fieldOfRadicands {3}))) ∉ P.P ∧
      Nat.card (𝓞 (fieldI (fieldOfRadicands {3})) ⧸ P.P) = 3 ^ 2 ∧ HenselCount P 3 ∧ NewCharBound P 3 ∧
      FibreShareBound 3 ((FibreCert.cert3.unum : ℝ) / FibreCert.cert3.scale) := by
  obtain ⟨P, h2, hQ⟩ := exists_stablePrime_sqrt_three
  exact ⟨P, h2, hQ, Rigidity.henselCount_of_two_notMem P h2 hQ, Rigidity.newCharBound_of_two_notMem P h2 hQ,
    fibreShareBound_three⟩

#print axioms card_le_of_fibreShareBound_model
end HadwigerNelson.CertLink
