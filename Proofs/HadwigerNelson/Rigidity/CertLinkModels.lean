import Proofs.HadwigerNelson.Rigidity.CertLink
import Proofs.HadwigerNelson.Arith.ThreeFourColours
import Proofs.HadwigerNelson.Rigidity.ClassRatio

/-!
# Models for the certificate link's stable-prime hypotheses (FS131-IKL1)

**Read aloud.** `exists_stablePrime_sqrt_three`: at `F = ℚ(√3)` there is a stable prime `P` of `F(i)` not above `2` with
`|𝓞 ⧸ P| = 3²` — the stable-prime hypotheses of `CertLink.exists_addEquiv_zmod` and `CertLink.card_le_of_fibreShareBound`
at once, at the prime `q = 3`. `exists_addEquiv_zmod_sqrt_three`: K3 read there — `𝓞 ⧸ P ≅ (ℤ/3)²` additively, the
norm-one set onto the unit circle.

Both rest on Weil's bound (`StandingFive.kloosterman_bound`), through `ThreeFourColours.exists_maximal_card_nine_sqrt_three`
(a maximal ideal of `ℤ[U_F]` with nine elements, from `χ(ℚ(√3)²) = 3`). The other two hypotheses of
`card_le_of_fibreShareBound`, `HenselCount P 3` and `NewCharBound P 3`, hold at every stable prime not above `2` by
`Rigidity/ClassRatio`'s Lemma P, where they are discharged; with them and FS-66's `p = 3` certificate
(`FibreCertSound.sum_le_of_certOK cert3`) every hypothesis of that theorem holds at this `P`.
-/

namespace HadwigerNelson.CertLink

open SpectralChain NumberField SquareClass

/-- **A stable prime of residue size `3²` not above `2`**, at `F = ℚ(√3)`: the model of the stable-prime hypotheses of
`exists_addEquiv_zmod` and `card_le_of_fibreShareBound` (at `q = 3`). -/
theorem exists_stablePrime_sqrt_three :
    ∃ P : StablePrime (fieldOfRadicands {3}), (2 : 𝓞 (fieldI (fieldOfRadicands {3}))) ∉ P.P ∧
      Nat.card (𝓞 (fieldI (fieldOfRadicands {3})) ⧸ P.P) = 3 ^ 2 := by
  obtain ⟨𝔪, h𝔪, h9⟩ := ThreeFourColours.exists_maximal_card_nine_sqrt_three
  obtain ⟨P, hP⟩ := ThreeFourColours.exists_stablePrime_card_nine h𝔪 h9
  have hP9 : Nat.card (𝓞 (fieldI (fieldOfRadicands {3})) ⧸ P.P) = 9 := by simpa using hP
  refine ⟨P, fun h2 => ?_, by rw [hP9]; norm_num⟩
  haveI := P.isMaximal
  letI : Field (𝓞 (fieldI (fieldOfRadicands {3})) ⧸ P.P) := Ideal.Quotient.field P.P
  haveI : Finite (𝓞 (fieldI (fieldOfRadicands {3})) ⧸ P.P) :=
    Ideal.finiteQuotientOfFreeOfNeBot _ P.heightOne.ne_bot
  have h2' : (2 : 𝓞 (fieldI (fieldOfRadicands {3})) ⧸ P.P) = 0 := by
    rw [← map_ofNat (Ideal.Quotient.mk P.P) 2]
    exact Ideal.Quotient.eq_zero_iff_mem.2 h2
  have h9' : (9 : 𝓞 (fieldI (fieldOfRadicands {3})) ⧸ P.P) = 0 := by
    have h : Nat.card (𝓞 (fieldI (fieldOfRadicands {3})) ⧸ P.P) • (1 : 𝓞 (fieldI (fieldOfRadicands {3})) ⧸ P.P) = 0 :=
      card_nsmul_eq_zero'
    rw [hP9, nsmul_eq_mul, mul_one] at h
    exact_mod_cast h
  exact one_ne_zero (by linear_combination h9' - 4 * h2' : (1 : 𝓞 (fieldI (fieldOfRadicands {3})) ⧸ P.P) = 0)

/-- **K3 at the model**: at the stable prime of `exists_stablePrime_sqrt_three`, `𝓞 ⧸ P ≅ (ℤ/3)²` additively, carrying the
norm-one set onto the unit circle `{a² + b² = 1}` (`exists_addEquiv_zmod` at `q = 3`). -/
theorem exists_addEquiv_zmod_sqrt_three :
    ∃ P : StablePrime (fieldOfRadicands {3}), ∃ e : (𝓞 (fieldI (fieldOfRadicands {3})) ⧸ P.P ^ 1) ≃+ (ZMod 3 × ZMod 3),
      ∀ x, x ∈ normOneSet P 1 ↔ (e x).1 ^ 2 + (e x).2 ^ 2 = 1 := by
  obtain ⟨P, h2, hQ⟩ := exists_stablePrime_sqrt_three
  exact ⟨P, exists_addEquiv_zmod P h2 (by norm_num) hQ⟩

/-- **FS-66's fibre-share bound at `p = 3`** (`FibreCertSound.sum_le_of_certOK cert3 cert3_ok`): the model of
`FibreShareBound`'s clause at `q = 3`. -/
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

end HadwigerNelson.CertLink
