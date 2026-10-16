import Proofs.HadwigerNelson.PadicPlane.Basic
import Proofs.HadwigerNelson.Rigidity.ClassRatio
import Proofs.HadwigerNelson.Instances.UpperHalfValues

/-!
# The residue tower at `p` is the stable prime of `ℚ(i)` above `p`: the tower ratio from Weil and from certificates (FS131-KPA1, skeleton)

**Read aloud.** At `p ≡ 3 (mod 4)` the prime `p` stays prime in `ℚ(i)`: there is a stable prime `P` of `ℚ(i)` (the library's
`StablePrime ⊥`) holding `p`, not holding `2`, with `p²` residues (`exists_stablePrime_above`). Its level-`k` residue target
`levelTarget P k` is `UD(ℤ/p^k, 2)`: `(a, b) ↦ a + b·i` embeds `(ℤ/p^k)²` into `𝓞 ⧸ P^k`, injectively and reflecting
adjacency (`exists_levelEmbedding`; the residue ring has characteristic `p^k` because `p^{k−1} ∉ P^k`, by the absolute norm).
So every all-levels bound the library holds at stable primes is a tower ratio at `p` (`towerRatio_of_ratioAtMost`):

* `towerRatio_of_charSum` — **the bound at every level, from level one** (FS-66's L1 with Hoffman's ratio bound): if every
  non-trivial character of `(ℤ/p)²` sums over the circle to real part at least `−κ`, `κ ≥ 2`, then
  `TowerRatio p (κ/(p + 1 + κ))`. Lemma P at the stable prime (`ratioAtMost_of_charSum_levelOne`) carries level one up.
* `charSum_unitCircle_ge_weil`, `towerRatio_weil` — Weil's bound at level one (the declared import
  `StandingFive.kloosterman_bound`): `κ = 2√p`, so `TowerRatio p (2√p/(p + 1 + 2√p))`.
* `towerRatio_of_fibreShareBound` — FS-66's L2 and L6 (`CertLink.card_le_of_fibreShareBound`): a bound `Σφ ≤ U` on FS-66's
  region gives `TowerRatio p (U/p²)`.

`ratioAtMost_of_charSum_levelOne` is stated here, over the library's public vocabulary, as what `Rigidity/ClassRatio`'s
private `charBound_of_charBound_oneT` and `ratioAtMost_of_charBound` give; the visibility edit is drafted in
`plans/FS131-KPA1-padic-plan.md` and is not made on this branch (the coordinator's ruling, inventory item 997).

**Models.** `exists_stablePrime_above` is inhabited at `p = 3` (and every `p ≡ 3 (mod 4)`). The hypothesis of
`towerRatio_of_charSum` holds at `κ = 2√p` (`charSum_unitCircle_ge_weil`) and at `κ = p + 1` (every character sum over
`p + 1` points); that of `towerRatio_of_fibreShareBound` at `p = 11` (`CertLink.fibreShareBound_eleven`), `p = 19`
(`FibreCertSound.sum_le_nineteen`) and `p = 3` (`FibreCertSound.sum_le_of_certOK` at `cert3`).
-/

namespace HadwigerNelson.PadicPlane

open SpectralChain NumberField SimpleGraph

/-! ## Lemma P with Hoffman's ratio bound, at any stable prime -/

/-- **Lemma P with Hoffman's ratio bound**: at a stable prime not above `2` with `|𝓞 ⧸ P| = Q²`, a lower bound `−κ`,
`κ ≥ 2`, on the real parts of the non-trivial character sums over the norm-one residues at level one gives the all-levels
ratio `κ/(Q + 1 + κ)`. (`Rigidity/ClassRatio`'s private `charBound_of_charBound_oneT` at `κ/(Q + 1)` and
`ratioAtMost_of_charBound`; or from the public `CertLink.HenselCount`, `CertLink.NewCharBound` (Lemma P's two theorems,
`Rigidity.henselCount_of_two_notMem`, `newCharBound_of_two_notMem`), the descent `FibreShare.exists_eq_compAddMonoidHom`
and `RatioBound.card_mul_le_of_indep` at each level.) -/
theorem ratioAtMost_of_charSum_levelOne {F : Subfield ℝ} [NumberField F] (P : StablePrime F)
    (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ} (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) {κ : ℝ} (hκ : 2 ≤ κ)
    (h1 : ∀ (hfin : (CertLink.normOneSet P 1).Finite) (ψ : AddChar (𝓞 (fieldI F) ⧸ P.P ^ 1) ℂ), ψ ≠ 1 →
      -κ ≤ (∑ s ∈ hfin.toFinset, ψ s).re) :
    Rigidity.RatioAtMost P (κ / ((Q : ℝ) + 1 + κ)) := by
  sorry

/-! ## The stable prime of `ℚ(i)` above `p` -/

variable (p : ℕ) [Fact p.Prime]

/-- **`p` stays prime in `ℚ(i)`** at `p ≡ 3 (mod 4)`: a stable prime of `ℚ(i)` holding `p`, not holding `2`, with `p²`
residues. (A maximal ideal over `(p)`; `|𝓞 ⧸ P|` divides `absNorm (p) = p²` and is not `p`, since `𝔽_p` holds no square root
of `−1`; two distinct conjugate primes over `p` would have norm `p⁴` dividing `p²`.) -/
theorem exists_stablePrime_above (hp : p % 4 = 3) :
    ∃ P : StablePrime (⊥ : Subfield ℝ), ((p : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∈ P.P ∧
      (2 : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∉ P.P ∧ Nat.card (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P) = p ^ 2 := by
  sorry

/-- **`UD(ℤ/p^k, 2)` inside the level-`k` target**: `(a, b) ↦ a + b·i` is an injective additive map
`(ℤ/p^k)² → 𝓞 ⧸ P^k` that reflects adjacency into `levelTarget P k`. -/
theorem exists_levelEmbedding (P : StablePrime (⊥ : Subfield ℝ))
    (hpP : ((p : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∈ P.P) (h2 : (2 : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∉ P.P)
    (hQ : Nat.card (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P) = p ^ 2) (k : ℕ) (hk : 1 ≤ k) :
    ∃ f : ZMod (p ^ k) × ZMod (p ^ k) →+ 𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P ^ k, Function.Injective f ∧
      ∀ u v, (levelTarget P k).Adj (f u) (f v) → (unitQuadrance (ZMod (p ^ k))).Adj u v := by
  sorry

/-- **An all-levels ratio at the stable prime above `p` is a tower ratio at `p`.** -/
theorem towerRatio_of_ratioAtMost (P : StablePrime (⊥ : Subfield ℝ))
    (hpP : ((p : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∈ P.P) (h2 : (2 : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∉ P.P)
    (hQ : Nat.card (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P) = p ^ 2) {c : ℝ} (h : Rigidity.RatioAtMost P c) :
    TowerRatio p c := by
  sorry

/-! ## The tower ratio from level one -/

/-- **Level one in coordinates** (K3, `CertLink.exists_addEquiv_zmod`): a lower bound on the character sums over the circle
of `(ℤ/p)²` is the same bound over the norm-one residues of the stable prime above `p`. -/
theorem charSum_levelOne_of_unitCircle (P : StablePrime (⊥ : Subfield ℝ))
    (hpP : ((p : ℕ) : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∈ P.P) (h2 : (2 : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∉ P.P)
    (hQ : Nat.card (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P) = p ^ 2) {κ : ℝ}
    (h : ∀ ψ : AddChar (ZMod p × ZMod p) ℂ, ψ ≠ 1 → -κ ≤ (∑ s ∈ FibreCertSound.unitCircle p, ψ s).re)
    (hfin : (CertLink.normOneSet P 1).Finite) (ψ : AddChar (𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P.P ^ 1) ℂ) (hψ : ψ ≠ 1) :
    -κ ≤ (∑ s ∈ hfin.toFinset, ψ s).re := by
  sorry

/-- **The bound at every level, from level one**: if every non-trivial character of `(ℤ/p)²` sums over the circle
`a² + b² = 1` to real part at least `−κ`, with `κ ≥ 2`, then every level of the tower holds at most `κ/(p + 1 + κ)`. With
`κ = −λ_min(UD(𝔽_p, 2))` this is Hoffman's ratio bound of the finite plane, carried to every level. -/
theorem towerRatio_of_charSum (hp : p % 4 = 3) {κ : ℝ} (hκ : 2 ≤ κ)
    (h : ∀ ψ : AddChar (ZMod p × ZMod p) ℂ, ψ ≠ 1 → -κ ≤ (∑ s ∈ FibreCertSound.unitCircle p, ψ s).re) :
    TowerRatio p (κ / ((p : ℝ) + 1 + κ)) := by
  obtain ⟨P, hpP, h2, hQ⟩ := exists_stablePrime_above p hp
  exact towerRatio_of_ratioAtMost p P hpP h2 hQ
    (ratioAtMost_of_charSum_levelOne P h2 hQ hκ (charSum_levelOne_of_unitCircle p P hpP h2 hQ h))

/-- **Weil's bound on the circle of `(ℤ/p)²`** (the declared import `StandingFive.kloosterman_bound`, through
`StandingFive.normOne_charSum_ge` on the residue field of the stable prime above `p`, carried by K3): every non-trivial
character sums over the `p + 1` points of the circle to real part at least `−2√p`. -/
theorem charSum_unitCircle_ge_weil (hp : p % 4 = 3) (ψ : AddChar (ZMod p × ZMod p) ℂ) (hψ : ψ ≠ 1) :
    -(2 * Real.sqrt p) ≤ (∑ s ∈ FibreCertSound.unitCircle p, ψ s).re := by
  sorry

/-- **T7's tower ratio**: at `p ≡ 3 (mod 4)` every independent set of every level `UD(ℤ/p^k, 2)` holds at most the fraction
`2√p/(p + 1 + 2√p)` of its points. -/
theorem towerRatio_weil (hp : p % 4 = 3) :
    TowerRatio p (2 * Real.sqrt p / ((p : ℝ) + 1 + 2 * Real.sqrt p)) :=
  towerRatio_of_charSum p hp (by
    have h1 : (1 : ℝ) ≤ Real.sqrt p := by
      rw [show (1 : ℝ) = Real.sqrt 1 from Real.sqrt_one.symm]
      exact Real.sqrt_le_sqrt (by exact_mod_cast (Fact.out : p.Prime).one_lt.le)
    linarith) (charSum_unitCircle_ge_weil p hp)

/-! ## The tower ratio from a certificate -/

/-- **FS-66's L2 and L6 at `ℚ_p`**: a bound `Σφ ≤ U` on FS-66's region `{φ : (ℤ/p)² → [0, 1], q(φ) ≥ 0}` gives the tower
ratio `U/p²`. -/
theorem towerRatio_of_fibreShareBound (hp : p % 4 = 3) {U : ℝ} (hU : CertLink.FibreShareBound p U) :
    TowerRatio p (U / (p : ℝ) ^ 2) := by
  sorry

end HadwigerNelson.PadicPlane
