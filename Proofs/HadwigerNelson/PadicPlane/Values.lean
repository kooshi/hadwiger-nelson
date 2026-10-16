import Proofs.HadwigerNelson.PadicPlane.Measure
import Proofs.HadwigerNelson.PadicPlane.Upper
import Proofs.HadwigerNelson.PadicPlane.Tower
import Proofs.HadwigerNelson.Instances.PlaneFreedom
import Proofs.HadwigerNelson.Instances.FinitePlane11
import Proofs.HadwigerNelson.Instances.LocalGlobal19
import Proofs.HadwigerNelson.CayleyCertificate
import Proofs.HadwigerNelson.PlaneRotation
import Mathlib.NumberTheory.LSeries.PrimesInAP

/-!
# The p-adic Hadwiger–Nelson problem: the Borel chromatic number of `ℚ_p²` is unbounded in `p`, and its values at 3, 7, 11, 19 and 23 (FS131-KPA1, skeleton)

**Read aloud, against `[BardestaniMallahiKarai2017]` Question 1 (p. 2): "Is it true that there exists a universal constant
`B` (independent of `p`) such that `χ_Bor(QG_{𝒬_p}) ≤ B` holds as `p` ranges over all primes of the form `4k + 3`?"** The
graph is `padicPlane p` (`x ~ y` iff `(x₁ − y₁)² + (x₂ − y₂)² = 1`), the number `borelChromaticNumber`: every colour
class a Borel set (`PadicPlane/Basic`). **The answer is no.**

* `le_borelChromaticNumber_of_charSum` — **Hoffman's bound of the finite plane carries to the Borel p-adic plane**: if every
  non-trivial character of `(ℤ/p)²` sums over the circle to real part at least `−κ`, `κ ≥ 2`, then
  `χ_Bor(ℚ_p²) ≥ ⌈1 + (p + 1)/κ⌉`. At `κ = −λ_min(UD(𝔽_p, 2))` (when that is at least `2`) the right side is the ratio bound
  of `UD(𝔽_p, 2)` itself.
* `one_add_div_le_of_borelColoring`, `le_borelChromaticNumber_padicPlane` — **FS66-T7**: `χ_Bor(ℚ_p²) ≥ 1 + (p + 1)/(2√p)` for every prime `p ≡ 3 (mod 4)`
  (Weil's bound, the declared import `StandingFive.kloosterman_bound`, gives `κ = 2√p`).
* `not_exists_bound_borelChromaticNumber_padicPlane` — **Question 1 answered no**: no `B` bounds `χ_Bor(ℚ_p²)` over the primes `p ≡ 3 (mod 4)`
  (`1 + (p + 1)/(2√p) > √p/2`, and Dirichlet's theorem in Mathlib gives such primes as large as one likes).
* The values: `χ_Bor(ℚ₃²) = 3` (the bound alone), `χ_Bor(ℚ₇²) = 4`, `χ_Bor(ℚ₁₁²) = 5`, `χ_Bor(ℚ₁₉²) = 5`, and
  `6 ≤ χ_Bor(ℚ₂₃²) ≤ 8` — lower halves from FS-66's fibre-share certificates (`TowerRatio p (U/p²)`), upper halves from the
  finite planes' colourings (`PadicPlane/Upper`, `[Madore2015]` Prop. 3.2 with the values of `[Moorhouse2010]` Table 6.1).
* Row 75's level clauses, now kernel theorems: no level `UD(ℤ/7^k, 2)` is three-colourable, none at 11 or 19 is
  four-colourable, none at 23 five-colourable (`unitQuadrance_zmod_seven_pow_not_colorable_three`, … — named as
  `Instances/ZMod121Four`'s `unitQuadrance_zmod121_not_colorable_four` is).

**The one new step**, the posers' objection asks the statement to show: the bound holds at **every level of the residue
tower at once** (`TowerRatio`, `PadicPlane/Tower`): FS-66's fibre argument above level one (Lemma P), and its fibre-share
inequality for the certificates. **Not claimed:** the plain chromatic number `χ(ℚ_p²)`, which these theorems neither bound
from below nor compute; any value at 23 beyond `[6, 8]`.

**Prior art.** The question is the posers'; they prove `χ_Bor = O(p²)`. The upper halves' construction is Madore's. The
lower bound and the values: prior art not found in print (`plans/FS66-derivation.md` FS66-T7's search). This module's
route needs no `[BardestaniMallahiKarai2017]` Theorem 2.5.

**Models.** The hypothesis of `le_borelChromaticNumber_of_charSum` is inhabited at `κ = 2√p` (`charSum_unitCircle_ge_weil`).
Every value theorem is closed. `Fact` instances for the primes 3, 7, 11, 19 and 23 are local to this file.
-/

namespace HadwigerNelson.PadicPlane

open SimpleGraph MeasureTheory

/-! ## The bound -/

/-- **Hoffman's bound of `UD(𝔽_p, 2)` carries to the Borel p-adic plane**: at `p ≡ 3 (mod 4)`, a lower bound `−κ`, `κ ≥ 2`,
on the real parts of the non-trivial character sums over the circle of `(ℤ/p)²` gives
`χ_Bor(ℚ_p²) ≥ ⌈1 + (p + 1)/κ⌉`. -/
theorem le_borelChromaticNumber_of_charSum (p : ℕ) [Fact p.Prime] (hp : p % 4 = 3) {κ : ℝ} (hκ : 2 ≤ κ)
    (h : ∀ ψ : AddChar (ZMod p × ZMod p) ℂ, ψ ≠ 1 → -κ ≤ (∑ s ∈ FibreCertSound.unitCircle p, ψ s).re) :
    ((⌈1 + ((p : ℝ) + 1) / κ⌉₊ : ℕ) : ℕ∞) ≤ borelChromaticNumber (padicPlane p) := by
  sorry

/-- **Every Borel colouring of the anisotropic p-adic plane uses at least `1 + (p + 1)/(2√p)` colours** (FS66-T7): for
every prime `p ≡ 3 (mod 4)`, a proper colouring of `padicPlane p` with `k` colours whose colour classes are Borel sets has
`1 + (p + 1)/(2√p) ≤ k`. The form a reader cites; `le_borelChromaticNumber_padicPlane` is the same in `ℕ∞`. -/
theorem one_add_div_le_of_borelColoring (p : ℕ) [Fact p.Prime] (hp : p % 4 = 3) {k : ℕ}
    (c : (padicPlane p).Coloring (Fin k)) (hc : ∀ i, MeasurableSet[borel (ℚ_[p] × ℚ_[p])] (⇑c ⁻¹' {i})) :
    1 + ((p : ℝ) + 1) / (2 * Real.sqrt p) ≤ k := by
  sorry

/-- **The Borel chromatic number of the anisotropic p-adic plane** (FS66-T7): for every prime `p ≡ 3 (mod 4)`,
`χ_Bor(ℚ_p²) ≥ 1 + (p + 1)/(2√p)`, as the least integer above it. -/
theorem le_borelChromaticNumber_padicPlane (p : ℕ) [Fact p.Prime] (hp : p % 4 = 3) :
    ((⌈1 + ((p : ℝ) + 1) / (2 * Real.sqrt p)⌉₊ : ℕ) : ℕ∞) ≤ borelChromaticNumber (padicPlane p) := by
  sorry

/-- **`[BardestaniMallahiKarai2017]` Question 1 (the p-adic Hadwiger–Nelson problem), answered no**: no constant `B`
bounds the Borel chromatic number of the p-adic plane as `p` ranges over the primes `p ≡ 3 (mod 4)`. Stated in the shape
of the question. -/
theorem not_exists_bound_borelChromaticNumber_padicPlane :
    ¬ ∃ B : ℕ, ∀ (p : ℕ) [Fact p.Prime], p % 4 = 3 → borelChromaticNumber (padicPlane p) ≤ B := by
  sorry

/-! ## The certificates -/

local instance factPrimeThree : Fact (Nat.Prime 3) := ⟨by norm_num⟩
local instance factPrimeSeven : Fact (Nat.Prime 7) := ⟨by norm_num⟩
local instance factPrimeEleven : Fact (Nat.Prime 11) := ⟨by norm_num⟩
local instance factPrimeNineteen : Fact (Nat.Prime 19) := ⟨by norm_num⟩
local instance factPrimeTwentyThree : Fact (Nat.Prime 23) := ⟨by norm_num⟩

/-- **FS-66's fibre-share bound at `p = 7`** (`data/fs66/b1/cert-p7.json`, `U = 14.0152…`): every `φ : (ℤ/7)² → [0, 1]`
with `q(φ) ≥ 0` has `Σφ ≤ U`. To be proved from the certificate checked by the kernel (`Arith/FibreCert7`,
`FibreCertSound.sum_le_of_certOK`; the plan's leaf C7). -/
theorem fibreShareBound_seven :
    CertLink.FibreShareBound 7 ((14015224526962403621588626098460 : ℝ) / 1000000000000000000000000000000) := by
  sorry

/-- **FS-66's fibre-share bound at `p = 23`** (`data/fs66/b1/cert-p23.json`, `U = 97.9846…`). To be proved from a
certificate checked by the kernel (the plan's leaf C23: FS-66's file, or a reduced one with `U < 529/5`). -/
theorem fibreShareBound_twentyThree :
    CertLink.FibreShareBound 23 ((9798463752088652446789757724702574 : ℝ) / 100000000000000000000000000000000) := by
  sorry

/-! ## Row 75's level clauses -/

/-- No level `UD(ℤ/7^k, 2)` is three-colourable (`3·U/49 < 1`). -/
theorem unitQuadrance_zmod_seven_pow_not_colorable_three (k : ℕ) (hk : 1 ≤ k) :
    ¬ (unitQuadrance (ZMod (7 ^ k))).Colorable 3 := by
  sorry

/-- No level `UD(ℤ/11^k, 2)` is four-colourable (`4·U/121 < 1`). -/
theorem unitQuadrance_zmod_eleven_pow_not_colorable_four (k : ℕ) (hk : 1 ≤ k) :
    ¬ (unitQuadrance (ZMod (11 ^ k))).Colorable 4 := by
  sorry

/-- No level `UD(ℤ/19^k, 2)` is four-colourable (`4·U/361 < 1`, the kernel's `p = 19` certificate). -/
theorem unitQuadrance_zmod_nineteen_pow_not_colorable_four (k : ℕ) (hk : 1 ≤ k) :
    ¬ (unitQuadrance (ZMod (19 ^ k))).Colorable 4 := by
  sorry

/-- No level `UD(ℤ/23^k, 2)` is five-colourable (`5·U/529 < 1`). -/
theorem unitQuadrance_zmod_twentyThree_pow_not_colorable_five (k : ℕ) (hk : 1 ≤ k) :
    ¬ (unitQuadrance (ZMod (23 ^ k))).Colorable 5 := by
  sorry

/-! ## The values -/

/-- **`χ_Bor(ℚ₃²) = 3`**: the bound gives `⌈1 + 4/(2√3)⌉ = 3`, and `UD(𝔽₃, 2)` is three-colourable. -/
theorem borelChromaticNumber_padicPlane_three : borelChromaticNumber (padicPlane 3) = 3 := by
  sorry

/-- **`χ_Bor(ℚ₇²) = 4`**: FS-66's certificate at 7 (`⌈49/U⌉ = 4`), and `UD(𝔽₇, 2)` is four-colourable. -/
theorem borelChromaticNumber_padicPlane_seven : borelChromaticNumber (padicPlane 7) = 4 := by
  sorry

/-- **`χ_Bor(ℚ₁₁²) = 5`**: FS-66's certificate at 11 (`⌈121/U⌉ = 5`), and `UD(𝔽₁₁, 2)` is five-colourable. -/
theorem borelChromaticNumber_padicPlane_eleven : borelChromaticNumber (padicPlane 11) = 5 := by
  sorry

/-- **`χ_Bor(ℚ₁₉²) = 5`**: the kernel's certificate at 19 (`U < 361/4`), and `UD(𝔽₁₉, 2)` is five-colourable. -/
theorem borelChromaticNumber_padicPlane_nineteen : borelChromaticNumber (padicPlane 19) = 5 := by
  sorry

/-- **`χ_Bor(ℚ₂₃²) ≥ 6`**: FS-66's certificate at 23 (`⌈529/U⌉ = 6`). -/
theorem six_le_borelChromaticNumber_padicPlane_twentyThree : 6 ≤ borelChromaticNumber (padicPlane 23) := by
  sorry

/-- **`χ_Bor(ℚ₂₃²) ≤ 8`**: `UD(𝔽₂₃, 2)` is eight-colourable. -/
theorem borelChromaticNumber_padicPlane_twentyThree_le_eight : borelChromaticNumber (padicPlane 23) ≤ 8 :=
  borelChromaticNumber_le_of_colorable 23 (by norm_num) CayleyCert.colorable_finitePlane23_eight

end HadwigerNelson.PadicPlane
