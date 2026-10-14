import Proofs.HadwigerNelson.Arith.WeilKloosterman

/-!
# CLS: a local bound of at least five gives T-C(A) at `S = ∅`; the uniform tail (FS-131, job FS131-KR1; module M13; skeleton)

**Read aloud, against the informal claim.** `RatioAtMost P c` says that at the stable prime `P` every independent set of
every level's residue target `levelTarget P m` (`m ≥ 1`) holds at most the fraction `c` of `𝓞 ⧸ P^m`; T-C(A) at `S = ∅`,
the library's `SpectralChain.TCA`, is "every stable prime has some `c < 1/4`" (`tca_iff`, by `Iff.rfl`). Then:

* `ratioAtMost_of_five_le_chromaticNumber` — **a stable prime whose level-one target needs five colours has an all-levels
  ratio below `1/4`** (FS100-CLS, -DLP, -G27; X26B-L1; EN1-UQ4): the residue sizes the hypothesis leaves are odd inert
  `q ∉ {3, 7}` and dyadic inert `Q ≥ 64` (a stable prime ramified in `F(i)/F` is dyadic and its level-one target is
  two-colourable, `colorable_two_levelTarget_one_of_isRamified`); Lemma P carries level one to every level; level one by Weil
  for `q ≥ 37` (the declared import `kloosterman_bound`), exact spectra at 23, 27, 31 and 64, `Floor128` at 128, the
  fourth-moment count EN1-UQ4 for `Q ≥ 256`, and FS-66's fibre-share bound with its certificates at 11 and 19.
* `tca_of_five_le_localBound` — **CLS**, the headline's `hCLS`: composed here from the per-prime statement.
* `exists_uniform_tail` — **one constant for all but finitely many stable primes**: every stable prime of absolute norm
  above some `B` has all-levels ratio at most one `c < 1/4` (Weil and Lemma P; R88-J28V-3's tail). And `tca_uniform`: T-C(A)
  with **one** constant for every stable prime — the form the count reads (module M12: the product of the stable factors has
  ratio `sup_P c_P`, which `TCA F` alone does not bound below `1/4`). Placed here, upstream of both M12 and M13, by the
  coordinator's ruling of 2026-10-14 on FS131-KR1's notice.

**Models.** `5 ≤ localBound F` holds at `ℚ(√47)` (module M15, `plans/FS131-KR1-chain-map.md` § 2.7) and at the standing
field (`StandingFive.le_localBound`, at seven); it fails at `ℚ`, whose prime `(1 + i)` is ramified. `RatioAtMost P 1` holds
at every `P` (an independent set is a subset), and `RatioAtMost P c` fails for `c < 1/2` at a ramified stable prime.
-/

namespace HadwigerNelson.Rigidity

open SpectralChain NumberField

noncomputable section

variable {F : Subfield ℝ}

/-- **The all-levels ratio at a stable prime is at most `c`.** -/
def RatioAtMost (P : StablePrime F) (c : ℝ) : Prop :=
  ∀ m : ℕ, 1 ≤ m → ∀ s : Finset (𝓞 (fieldI F) ⧸ P.P ^ m),
    (levelTarget P m).IsIndepSet (s : Set _) → (s.card : ℝ) ≤ c * Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m)

variable (F) in
/-- T-C(A) at `S = ∅`, read through `RatioAtMost`. -/
theorem tca_iff : TCA F ↔ ∀ P : StablePrime F, ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c := Iff.rfl

/-- **Per prime**: five colours at level one give an all-levels ratio below `1/4`. -/
theorem ratioAtMost_of_five_le_chromaticNumber [NumberField F] (P : StablePrime F)
    (h : 5 ≤ (levelTarget P 1).chromaticNumber) : ∃ c : ℝ, c < 1 / 4 ∧ RatioAtMost P c := by
  sorry

variable (F) in
/-- **CLS** (FS100-CLS): `L(F) ≥ 5` gives T-C(A) at `S = ∅`. -/
theorem tca_of_five_le_localBound [NumberField F] (h : 5 ≤ localBound F) : TCA F := fun P =>
  ratioAtMost_of_five_le_chromaticNumber P (h.trans (iInf_le _ P))

variable (F) in
/-- **The uniform tail**: one `c < 1/4` bounds the all-levels ratio at every stable prime of absolute norm above `B`. -/
theorem exists_uniform_tail [NumberField F] :
    ∃ c : ℝ, c < 1 / 4 ∧ ∃ B : ℕ, ∀ P : StablePrime F, B < Ideal.absNorm P.P → RatioAtMost P c := by
  sorry

variable (F) in
/-- **T-C(A) with one constant** — the form the count reads: the tail's constant and the finitely many primes below `B`
(`Ideal.finite_setOf_absNorm_le`). -/
theorem tca_uniform [NumberField F] (h : TCA F) : ∃ c : ℝ, c < 1 / 4 ∧ ∀ P : StablePrime F, RatioAtMost P c := by
  sorry

end

end HadwigerNelson.Rigidity
