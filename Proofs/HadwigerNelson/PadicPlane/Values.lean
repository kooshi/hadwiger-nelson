import Proofs.HadwigerNelson.PadicPlane.Measure
import Proofs.HadwigerNelson.PadicPlane.Upper
import Proofs.HadwigerNelson.PadicPlane.Tower
import Proofs.HadwigerNelson.Instances.PlaneFreedom
import Proofs.HadwigerNelson.Instances.FinitePlane11
import Proofs.HadwigerNelson.Instances.LocalGlobal19
import Proofs.HadwigerNelson.CayleyCertificate
import Proofs.HadwigerNelson.PlaneRotation
import Proofs.HadwigerNelson.Arith.FibreCert7Bound
import Mathlib.NumberTheory.LSeries.PrimesInAP

/-!
# The p-adic Hadwiger–Nelson problem: the Borel chromatic number of `ℚ_p²` is unbounded in `p`, its values at 3, 7, 11 and 19, and bounds at 23 (FS131-KPA1, proved by FS131-IQP1 and FS131-IQP3)

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
  `5 ≤ χ_Bor(ℚ₂₃²) ≤ 8` — lower halves from FS-66's fibre-share certificates (`TowerRatio p (U/p²)`; at 23 the bound
  by characters at the circle's exact cosine sums, `CircleCos.circleCos_ge`, FS-66's certificate there not yet in the
  kernel), upper halves from the finite planes' colourings
  (`PadicPlane/Upper`, `[Madore2015]` Prop. 3.2 with the values of `[Moorhouse2010]` Table 6.1).
* Row 75's level clauses, now kernel theorems: no level `UD(ℤ/7^k, 2)` is three-colourable, none at 11 or 19 is
  four-colourable (`unitQuadrance_zmod_seven_pow_not_colorable_three`, … — named as
  `Instances/ZMod121Four`'s `unitQuadrance_zmod121_not_colorable_four` is).

**The one new step**, the posers' objection asks the statement to show: the bound holds at **every level of the residue
tower at once** (`TowerRatio`, `PadicPlane/Tower`): FS-66's fibre argument above level one (Lemma P), and its fibre-share
inequality for the certificates. **Not claimed:** the plain chromatic number `χ(ℚ_p²)`, which these theorems neither bound
from below nor compute; any value at 23 beyond `[5, 8]`.

**Prior art.** The question is the posers'; they prove `χ_Bor = O(p²)`. The upper halves' construction is Madore's. The
lower bound and the values: prior art not found in print (`plans/FS66-derivation.md` FS66-T7's search). This module's
route needs no `[BardestaniMallahiKarai2017]` Theorem 2.5.

**Models.** The hypothesis of `le_borelChromaticNumber_of_charSum` is inhabited at `κ = 2√p` (`charSum_unitCircle_ge_weil`),
and at `p = 23` at `κ = 7.9606872` (`CircleCos.circleCos_ge`, read through the private `charSum_unitCircle_ge_of_circleCos`).
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
  have hp2 : p ≠ 2 := by omega
  have hp0 : (0 : ℝ) ≤ p := Nat.cast_nonneg p
  have hκ0 : κ ≠ 0 := by linarith
  have hden : (p : ℝ) + 1 + κ ≠ 0 := by linarith
  have hpos : 0 < κ / ((p : ℝ) + 1 + κ) := div_pos (by linarith) (by linarith)
  have e : 1 / (κ / ((p : ℝ) + 1 + κ)) = 1 + ((p : ℝ) + 1) / κ := by
    field_simp
    ring
  have h' := le_borelChromaticNumber_of_towerRatio p hp2 (towerRatio_of_charSum p hp hκ h) hpos
  rwa [e] at h'

/-- **The cosine sums bound the character sums** (the plane's form of `Rigidity/ClassRatio`'s private
`charBound_one_of_circleCos`): a character `ψ ≠ 1` of `(ℤ/Q)²` is `v ↦ ζ^{αv₁ + βv₂}` with `ζ = e^{2πi/Q}` and
`(α, β) ≠ 0`, so the real part of its sum over the circle is the cosine sum `CircleCos.circleCos_ge` bounds. -/
private theorem charSum_unitCircle_ge_of_circleCos (Q : ℕ) [Fact Q.Prime] {κ : ℝ}
    (hcos : ∀ α β : ℕ, α < Q → β < Q → (α ≠ 0 ∨ β ≠ 0) →
      -(κ * ((Q : ℝ) + 1)) ≤ ∑ v ∈ Finset.univ.filter (fun v : ZMod Q × ZMod Q => v.1 ^ 2 + v.2 ^ 2 = 1),
        Real.cos (2 * Real.pi * (((α * v.1.val + β * v.2.val) % Q : ℕ) : ℝ) / Q))
    (ψ : AddChar (ZMod Q × ZMod Q) ℂ) (hψ : ψ ≠ 1) :
    -(κ * ((Q : ℝ) + 1)) ≤ (∑ s ∈ FibreCertSound.unitCircle Q, ψ s).re := by
  have hp : Q.Prime := Fact.out
  have hpow : ∀ v : ZMod Q × ZMod Q, ψ v ^ Q = 1 := fun v => by
    have h0 : Q • v = 0 := by ext <;> simp
    rw [← AddChar.map_nsmul_eq_pow, h0, AddChar.map_zero_eq_one]
  have hζ := Complex.isPrimitiveRoot_exp Q hp.ne_zero
  obtain ⟨α, hα, hαz⟩ := hζ.eq_pow_of_pow_eq_one (hpow (1, 0))
  obtain ⟨β, hβ, hβz⟩ := hζ.eq_pow_of_pow_eq_one (hpow (0, 1))
  set ζ := Complex.exp (2 * Real.pi * Complex.I / Q) with hζdef
  have hdec : ∀ v : ZMod Q × ZMod Q,
      v.1.val • ((1 : ZMod Q), (0 : ZMod Q)) + v.2.val • ((0 : ZMod Q), (1 : ZMod Q)) = v := by
    intro v
    ext <;> simp
  have hψx : ∀ v, ψ v = ζ ^ ((α * v.1.val + β * v.2.val) % Q) := by
    intro v
    have e2 : ζ ^ ((α * v.1.val + β * v.2.val) % Q) = ζ ^ (α * v.1.val + β * v.2.val) := by
      conv_rhs => rw [← Nat.div_add_mod (α * v.1.val + β * v.2.val) Q]
      rw [pow_add, pow_mul, hζ.pow_eq_one, one_pow, one_mul]
    rw [e2, pow_add, pow_mul, pow_mul, hαz, hβz, ← AddChar.map_nsmul_eq_pow, ← AddChar.map_nsmul_eq_pow,
      ← AddChar.map_add_eq_mul, hdec v]
  have hαβ : α ≠ 0 ∨ β ≠ 0 := by
    by_contra h
    push Not at h
    apply hψ
    refine DFunLike.ext _ _ fun v => ?_
    rw [hψx, h.1, h.2, zero_mul, zero_mul, add_zero, Nat.zero_mod, pow_zero, AddChar.one_apply]
  have hre : ∀ m : ℕ, (ζ ^ m).re = Real.cos (2 * Real.pi * (m : ℝ) / Q) := by
    intro m
    rw [hζdef, ← Complex.exp_nat_mul]
    have : (m : ℂ) * (2 * Real.pi * Complex.I / Q) = ((2 * Real.pi * (m : ℝ) / Q : ℝ) : ℂ) * Complex.I := by
      push_cast; ring
    rw [this, Complex.exp_ofReal_mul_I_re]
  have hsum : (∑ s ∈ FibreCertSound.unitCircle Q, ψ s).re = ∑ v ∈ Finset.univ.filter
      (fun v : ZMod Q × ZMod Q => v.1 ^ 2 + v.2 ^ 2 = 1),
      Real.cos (2 * Real.pi * (((α * v.1.val + β * v.2.val) % Q : ℕ) : ℝ) / Q) := by
    rw [Complex.re_sum]
    exact Finset.sum_congr rfl fun v _ => by rw [hψx, hre]
  rw [hsum]
  exact hcos α β hα hβ hαβ

/-- **Every Borel colouring of the anisotropic p-adic plane uses at least `1 + (p + 1)/(2√p)` colours** (FS66-T7): for
every prime `p ≡ 3 (mod 4)`, a proper colouring of `padicPlane p` with `k` colours whose colour classes are Borel sets has
`1 + (p + 1)/(2√p) ≤ k`. The form a reader cites; `le_borelChromaticNumber_padicPlane` is the same in `ℕ∞`. -/
theorem one_add_div_le_of_borelColoring (p : ℕ) [Fact p.Prime] (hp : p % 4 = 3) {k : ℕ}
    (c : (padicPlane p).Coloring (Fin k)) (hc : ∀ i, MeasurableSet[borel (ℚ_[p] × ℚ_[p])] (⇑c ⁻¹' {i})) :
    1 + ((p : ℝ) + 1) / (2 * Real.sqrt p) ≤ k := by
  have hp2 : p ≠ 2 := by omega
  have h := one_le_mul_of_borelColoring p hp2 (towerRatio_weil p hp) c hc
  have hs1 : (1 : ℝ) ≤ Real.sqrt p := by
    rw [show (1 : ℝ) = Real.sqrt 1 from Real.sqrt_one.symm]
    exact Real.sqrt_le_sqrt (by exact_mod_cast (Fact.out : p.Prime).one_lt.le)
  have hp0 : (0 : ℝ) ≤ p := Nat.cast_nonneg p
  have hs : 0 < 2 * Real.sqrt p := by linarith
  have hden : 0 < (p : ℝ) + 1 + 2 * Real.sqrt p := by linarith
  rw [mul_div_assoc', le_div_iff₀ hden] at h
  have e : 1 + ((p : ℝ) + 1) / (2 * Real.sqrt p) = ((p : ℝ) + 1 + 2 * Real.sqrt p) / (2 * Real.sqrt p) := by
    field_simp
    ring
  rw [e, div_le_iff₀ hs]
  linarith

/-- **The Borel chromatic number of the anisotropic p-adic plane** (FS66-T7): for every prime `p ≡ 3 (mod 4)`,
`χ_Bor(ℚ_p²) ≥ 1 + (p + 1)/(2√p)`, as the least integer above it. -/
theorem le_borelChromaticNumber_padicPlane (p : ℕ) [Fact p.Prime] (hp : p % 4 = 3) :
    ((⌈1 + ((p : ℝ) + 1) / (2 * Real.sqrt p)⌉₊ : ℕ) : ℕ∞) ≤ borelChromaticNumber (padicPlane p) := by
  have hs1 : (1 : ℝ) ≤ Real.sqrt p := by
    rw [show (1 : ℝ) = Real.sqrt 1 from Real.sqrt_one.symm]
    exact Real.sqrt_le_sqrt (by exact_mod_cast (Fact.out : p.Prime).one_lt.le)
  exact le_borelChromaticNumber_of_charSum p hp (by linarith) (charSum_unitCircle_ge_weil p hp)

/-- **`[BardestaniMallahiKarai2017]` Question 1 (the p-adic Hadwiger–Nelson problem), answered no**: no constant `B`
bounds the Borel chromatic number of the p-adic plane as `p` ranges over the primes `p ≡ 3 (mod 4)`. Stated in the shape
of the question. -/
theorem not_exists_bound_borelChromaticNumber_padicPlane :
    ¬ ∃ B : ℕ, ∀ (p : ℕ) [Fact p.Prime], p % 4 = 3 → borelChromaticNumber (padicPlane p) ≤ B := by
  rintro ⟨B, hB⟩
  -- Dirichlet: a prime `p ≡ 3 (mod 4)` above `4(B + 1)²`
  have hu : IsUnit (3 : ZMod 4) := ⟨⟨3, 3, by decide, by decide⟩, rfl⟩
  obtain ⟨p, hpn, hpr, hp3⟩ := Nat.forall_exists_prime_gt_and_eq_mod hu (4 * (B + 1) ^ 2)
  haveI : Fact p.Prime := ⟨hpr⟩
  have hp4 : p % 4 = 3 := by
    have h := congrArg ZMod.val hp3
    rwa [ZMod.val_natCast] at h
  have h1 := (le_borelChromaticNumber_padicPlane p hp4).trans (hB p hp4)
  have h2 : ⌈1 + ((p : ℝ) + 1) / (2 * Real.sqrt p)⌉₊ ≤ B := by exact_mod_cast h1
  have h3 := Nat.ceil_le.1 h2
  -- but `1 + (p + 1)/(2√p) > √p/2 > B + 1`
  have hB0 : (0 : ℝ) ≤ B := Nat.cast_nonneg B
  have hs : 2 * ((B : ℝ) + 1) < Real.sqrt p := by
    rw [Real.lt_sqrt (by positivity)]
    have h' : ((4 * (B + 1) ^ 2 : ℕ) : ℝ) < p := by exact_mod_cast hpn
    push_cast at h'
    nlinarith
  have hs0 : 0 < Real.sqrt p := by linarith
  have hsq : Real.sqrt p * Real.sqrt p = (p : ℝ) := Real.mul_self_sqrt (Nat.cast_nonneg p)
  have h4 : Real.sqrt p / 2 ≤ ((p : ℝ) + 1) / (2 * Real.sqrt p) := by
    rw [div_le_div_iff₀ (by norm_num) (by positivity)]
    nlinarith
  linarith

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
    CertLink.FibreShareBound 7 ((14015224526962403621588626098460 : ℝ) / 1000000000000000000000000000000) :=
  fun φ h0 h1 hq => FibreCertSound.sum_le_seven φ h0 h1 hq

/-! ## Row 75's level clauses -/

/-- No level `UD(ℤ/7^k, 2)` is three-colourable (`3·U/49 < 1`). -/
theorem unitQuadrance_zmod_seven_pow_not_colorable_three (k : ℕ) (hk : 1 ≤ k) :
    ¬ (unitQuadrance (ZMod (7 ^ k))).Colorable 3 :=
  not_colorable_of_towerRatio (towerRatio_of_fibreShareBound 7 (by norm_num) fibreShareBound_seven) (by norm_num) k hk

/-- No level `UD(ℤ/11^k, 2)` is four-colourable (`4·U/121 < 1`). -/
theorem unitQuadrance_zmod_eleven_pow_not_colorable_four (k : ℕ) (hk : 1 ≤ k) :
    ¬ (unitQuadrance (ZMod (11 ^ k))).Colorable 4 :=
  not_colorable_of_towerRatio (towerRatio_of_fibreShareBound 11 (by norm_num) CertLink.fibreShareBound_eleven)
    (by norm_num) k hk

/-- No level `UD(ℤ/19^k, 2)` is four-colourable (`4·U/361 < 1`, the kernel's `p = 19` certificate). -/
theorem unitQuadrance_zmod_nineteen_pow_not_colorable_four (k : ℕ) (hk : 1 ≤ k) :
    ¬ (unitQuadrance (ZMod (19 ^ k))).Colorable 4 := by
  obtain ⟨U, hU, hb⟩ := CertLink.exists_fibreShareBound_nineteen
  refine not_colorable_of_towerRatio (towerRatio_of_fibreShareBound 19 (by norm_num) hb) ?_ k hk
  norm_num
  linarith

/-! ## The values -/

/-- **`χ_Bor(ℚ₃²) = 3`**: the bound gives `⌈1 + 4/(2√3)⌉ = 3`, and `UD(𝔽₃, 2)` is three-colourable. -/
theorem borelChromaticNumber_padicPlane_three : borelChromaticNumber (padicPlane 3) = 3 := by
  refine le_antisymm (borelChromaticNumber_le_of_colorable 3 (by norm_num) finitePlane3_colorable_three) ?_
  refine le_trans ?_ (le_borelChromaticNumber_padicPlane 3 (by norm_num))
  have hs : Real.sqrt 3 < 2 := by rw [Real.sqrt_lt' (by norm_num)]; norm_num
  have hs0 : 0 < Real.sqrt 3 := Real.sqrt_pos.2 (by norm_num)
  have hx : ((2 : ℕ) : ℝ) < 1 + (((3 : ℕ) : ℝ) + 1) / (2 * Real.sqrt ((3 : ℕ) : ℝ)) := by
    have h : (1 : ℝ) < 4 / (2 * Real.sqrt 3) := by rw [lt_div_iff₀ (by positivity)]; linarith
    norm_num
    linarith
  exact_mod_cast Nat.lt_ceil.2 hx

/-- **`χ_Bor(ℚ₇²) = 4`**: FS-66's certificate at 7 (`⌈49/U⌉ = 4`), and `UD(𝔽₇, 2)` is four-colourable. -/
theorem borelChromaticNumber_padicPlane_seven : borelChromaticNumber (padicPlane 7) = 4 := by
  refine le_antisymm (borelChromaticNumber_le_of_colorable 7 (by norm_num) finitePlane7_colorable_four) ?_
  refine le_trans ?_ (le_borelChromaticNumber_of_towerRatio 7 (by norm_num)
    (towerRatio_of_fibreShareBound 7 (by norm_num) fibreShareBound_seven) (by positivity))
  have hx : ((3 : ℕ) : ℝ) < 1 / ((14015224526962403621588626098460 : ℝ) / 1000000000000000000000000000000 /
      ((7 : ℕ) : ℝ) ^ 2) := by norm_num
  exact_mod_cast Nat.lt_ceil.2 hx

/-- **`χ_Bor(ℚ₁₁²) = 5`**: FS-66's certificate at 11 (`⌈121/U⌉ = 5`), and `UD(𝔽₁₁, 2)` is five-colourable. -/
theorem borelChromaticNumber_padicPlane_eleven : borelChromaticNumber (padicPlane 11) = 5 := by
  refine le_antisymm (borelChromaticNumber_le_of_colorable 11 (by norm_num) finitePlane11_colorable_five) ?_
  refine le_trans ?_ (le_borelChromaticNumber_of_towerRatio 11 (by norm_num)
    (towerRatio_of_fibreShareBound 11 (by norm_num) CertLink.fibreShareBound_eleven) (by positivity))
  have hx : ((4 : ℕ) : ℝ) < 1 / ((28204320001863099628721379861820 : ℝ) / 1000000000000000000000000000000 /
      ((11 : ℕ) : ℝ) ^ 2) := by norm_num
  exact_mod_cast Nat.lt_ceil.2 hx

/-- **`χ_Bor(ℚ₁₉²) = 5`**: the kernel's certificate at 19 (`U < 361/4`), and `UD(𝔽₁₉, 2)` is five-colourable. -/
theorem borelChromaticNumber_padicPlane_nineteen : borelChromaticNumber (padicPlane 19) = 5 := by
  refine le_antisymm (borelChromaticNumber_le_of_colorable 19 (by norm_num) finitePlane19_colorable_five) ?_
  obtain ⟨U, hU, hb⟩ := CertLink.exists_fibreShareBound_nineteen
  -- the ratio raised to at least `1/8`, so that it is positive, still below `1/4`
  have hc := (towerRatio_of_fibreShareBound 19 (by norm_num) hb).mono (le_max_left (U / ((19 : ℕ) : ℝ) ^ 2) (1 / 8))
  have hpos : 0 < max (U / ((19 : ℕ) : ℝ) ^ 2) (1 / 8) := lt_max_of_lt_right (by norm_num)
  have hlt : max (U / ((19 : ℕ) : ℝ) ^ 2) (1 / 8) < 1 / 4 := max_lt (by norm_num; linarith) (by norm_num)
  have hle := le_borelChromaticNumber_of_towerRatio 19 (by norm_num) hc hpos
  have hx : ((4 : ℕ) : ℝ) < 1 / max (U / ((19 : ℕ) : ℝ) ^ 2) (1 / 8) := by
    rw [lt_div_iff₀ hpos]
    push_cast
    linarith
  have hceil := Nat.lt_ceil.2 hx
  refine le_trans ?_ hle
  exact_mod_cast hceil

/-- **`χ_Bor(ℚ₂₃²) ≥ 5`**: the bound by characters (`le_borelChromaticNumber_of_charSum`) at the exact cosine sums of the
circle of `𝔽₂₃²` (`CircleCos.circleCos_ge`, kernel-checked: every non-trivial character sums over the 24 points to real
part at least `−κ`, `κ = 7.9606872 < 8`), so `⌈1 + 24/κ⌉ = ⌈4.0148…⌉ = 5`; Weil's `κ = 2√23` gives only `⌈3.50…⌉ = 4`.
FS-66's certificate at 23 (`⌈529/U⌉ = 6`) is not in the kernel: its reduced form is search request 26. -/
theorem five_le_borelChromaticNumber_padicPlane_twentyThree : 5 ≤ borelChromaticNumber (padicPlane 23) := by
  obtain ⟨κ, hκ3, hκQ, hcos⟩ := CircleCos.circleCos_ge (Q := 23) (Or.inl rfl)
  have hch := charSum_unitCircle_ge_of_circleCos 23 hcos
  have h24 : ((23 : ℕ) : ℝ) + 1 = 24 := by norm_num
  rw [h24] at hκQ hch
  have hκ0 : 0 < κ := lt_of_lt_of_le (by norm_num) hκQ
  have hκ2 : 2 ≤ κ * 24 := by
    have := (div_le_iff₀ (by norm_num : (0 : ℝ) < 24)).1 hκQ
    linarith
  refine le_trans ?_ (le_borelChromaticNumber_of_charSum 23 (by norm_num) hκ2 hch)
  have hx : ((4 : ℕ) : ℝ) < 1 + (((23 : ℕ) : ℝ) + 1) / (κ * 24) := by
    rw [h24, mul_comm, ← div_div, div_self (by norm_num : (24 : ℝ) ≠ 0)]
    have : (3 : ℝ) < 1 / κ := by rw [lt_div_iff₀ hκ0]; linarith
    push_cast
    linarith
  exact_mod_cast Nat.lt_ceil.2 hx

/-- **`χ_Bor(ℚ₂₃²) ≤ 8`**: `UD(𝔽₂₃, 2)` is eight-colourable. -/
theorem borelChromaticNumber_padicPlane_twentyThree_le_eight : borelChromaticNumber (padicPlane 23) ≤ 8 :=
  borelChromaticNumber_le_of_colorable 23 (by norm_num) CayleyCert.colorable_finitePlane23_eight

end HadwigerNelson.PadicPlane
