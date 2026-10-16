import Proofs.HadwigerNelson.Rigidity.AdmissiblePrime
import Proofs.HadwigerNelson.Arith.PlaceHom
import Proofs.HadwigerNelson.Arith.UpperHalf
import Mathlib.RingTheory.Polynomial.ScaleRoots

/-!
# Every real number field has a usable prime, and `F(i)` a stable prime (FS-131, job FS131-KRU1; skeleton)

Plan: `plans/FS131-KRU1-ring-plan.md` § 3 (module 3), § 2.4 (route E). Inventory item 1040's ruling: the elementary route,
no outside theorem.

**Read aloud, against the informal claim.** `F ⊆ ℝ` is a real number field. A *usable prime* (`Arith.IsUsablePrime`) is a
maximal ideal of `𝓞 F` whose residue field has `q ≡ 3 (mod 4)` elements; a *stable prime* of `F(i)` is a maximal ideal of
`𝓞 (F(i))` fixed by conjugation.

* `exists_isUsablePrime` — **every real number field has usable primes of degree one, above primes outside any finite
  set**: for every `M ≠ 0` a prime `q ∤ M`, `q ≡ 3 (mod 4)`, and a maximal ideal `𝔭 ∋ q` of `𝓞 F` with `q` residues.
* `nonempty_stablePrime` — **`F(i)` has a stable prime**; so `L(F) < ⊤` (`localBound_lt_top`).

**Route (no Chebotarev, no outside theorem).** Let `f` be the minimal polynomial of an integral primitive element `θ` of
`F`. As `F ⊆ ℝ`, `θ` is a real simple root of `f`, so `f < 0` on an open interval beside it (`exists_Ioo_aeval_neg`). Put
`D = 4·M′` (`M′` collects `M`, the conductor's exponent and the discriminant) and pick `x/k` in that interval with
`k = Dᵉ`, `x ≡ 1 (mod D)` (`exists_one_add_mul_div_pow_mem_Ioo`). Then `N = −kⁿ f(x/k)` is a positive integer with
`N ≡ −xⁿ ≡ −1 (mod D)` (`f` monic, `D ∣ k`), so `N` has a prime factor `q ≡ 3 (mod 4)` (`exists_prime_mod_four_eq_three_dvd`)
prime to `D`, hence to `M` and to `k`, and `f` has the root `x/k` modulo `q` (`exists_dvd_eval_of_dvd_scaleRoots_eval`).
Kummer–Dedekind at `q` (`Rigidity/AdmissiblePrime`'s `nonempty_residueHom`) gives `𝓞 F → ℤ/q`, whose kernel is the usable
prime. Above it, a stable prime: unit vectors are integral at a usable prime (`Arith.placeHom_base`), so `1/q ∉ ℤ[U]`, and
row 105's prime inversion (`UpperHalf.inv_natCast_mem_unitRingOver_iff_forall_stablePrime`) puts `q` in a stable prime.

**Not claimed:** a density of such primes; that the stable prime above `𝔭` is unique or inert (it is: FS131-ICS1's
`UpperHalf.exists_stablePrime_card_eq_sq`, which this module does not need); anything at a field that is not real (the step
that fails without a real embedding is the sign change: `f = x² + 1` has roots only modulo `2` and `p ≡ 1 (mod 4)`).

**Models.** Every hypothesis is `NumberField F` or arithmetic on `ℕ`, `ℤ` and `ℝ`; `F = ℚ` (`UpperHalf.numberField_bot`)
inhabits it, with `q = 3`.
-/

namespace HadwigerNelson.Rigidity

open Polynomial NumberField SpectralChain Arith

/-- **A natural number `≡ 3 (mod 4)` has a prime factor `≡ 3 (mod 4)`** (a product of numbers `≡ 1 (mod 4)` is
`≡ 1 (mod 4)`; strong induction). -/
theorem exists_prime_mod_four_eq_three_dvd {N : ℕ} (hN : N % 4 = 3) : ∃ q : ℕ, q.Prime ∧ q % 4 = 3 ∧ q ∣ N := by
  sorry

/-- **An integer polynomial is negative on an open interval beside a simple real root**: `f = (X − θ)·g` over `ℝ` with
`g(θ) = f′(θ) ≠ 0`, and `g` keeps its sign near `θ`. -/
theorem exists_Ioo_aeval_neg (f : ℤ[X]) {θ : ℝ} (hθ : aeval θ f = 0) (hθ' : aeval θ (derivative f) ≠ 0) :
    ∃ a b : ℝ, a < b ∧ ∀ y ∈ Set.Ioo a b, aeval y f < 0 := by
  sorry

/-- **Fractions `x/Dᵉ` with `x ≡ 1 (mod D)` and `e ≥ 1` are dense**: every open interval holds one (`D^{1−e} < b − a`, then
`t = ⌊(a·Dᵉ − 1)/D⌋ + 1`). -/
theorem exists_one_add_mul_div_pow_mem_Ioo {D : ℕ} (hD : 2 ≤ D) {a b : ℝ} (hab : a < b) :
    ∃ (e : ℕ) (t : ℤ), 1 ≤ e ∧ a < ((1 + D * t : ℤ) : ℝ) / (D : ℝ) ^ e ∧ ((1 + D * t : ℤ) : ℝ) / (D : ℝ) ^ e < b := by
  sorry

/-- **The homogeneous value**: `(f.scaleRoots k)(x) = kⁿ·f(x/k)` in `ℝ`, `n = deg f`, for `k ≠ 0`
(`Polynomial.scaleRoots_eval₂_mul`). -/
theorem scaleRoots_eval_eq (f : ℤ[X]) (x : ℤ) {k : ℤ} (hk : k ≠ 0) :
    (((f.scaleRoots k).eval x : ℤ) : ℝ) = (k : ℝ) ^ f.natDegree * aeval ((x : ℝ) / k) f := by
  sorry

/-- **For monic `f`, the homogeneous value is `xⁿ` modulo `k`**: every other coefficient of `f.scaleRoots k` carries a
positive power of `k` (`Polynomial.coeff_scaleRoots`). -/
theorem dvd_scaleRoots_eval_sub_pow {f : ℤ[X]} (hf : f.Monic) (x k : ℤ) :
    k ∣ (f.scaleRoots k).eval x - x ^ f.natDegree := by
  sorry

/-- **A prime dividing the homogeneous value and not `k` gives a root modulo it**: in `ℤ/q`, `k` is a unit and
`kⁿ·f(x·k⁻¹) = (f.scaleRoots k)(x) = 0`. -/
theorem exists_dvd_eval_of_dvd_scaleRoots_eval (f : ℤ[X]) {q : ℕ} (hq : q.Prime) {x k : ℤ} (hk : ¬ (q : ℤ) ∣ k)
    (hdvd : (q : ℤ) ∣ (f.scaleRoots k).eval x) : ∃ t : ℤ, (q : ℤ) ∣ f.eval t := by
  sorry

/-- **Schur with a sign**: a monic integer polynomial with a simple real root has a root modulo a prime `q ≡ 3 (mod 4)` that
does not divide a given `M ≠ 0`. -/
theorem exists_prime_three_mod_four_dvd_eval (f : ℤ[X]) (hf : f.Monic) {θ : ℝ} (hθ : aeval θ f = 0)
    (hθ' : aeval θ (derivative f) ≠ 0) (M : ℕ) (hM : M ≠ 0) :
    ∃ q : ℕ, q.Prime ∧ q % 4 = 3 ∧ ¬ q ∣ M ∧ ∃ t : ℤ, (q : ℤ) ∣ f.eval t := by
  sorry

variable (F : Subfield ℝ) [NumberField F]

/-- **Every real number field has usable primes of degree one outside any finite set of rational primes**: for `M ≠ 0`
there are a prime `q ∤ M` and a usable prime `𝔭 ∋ q` of `F` with `q` residues. -/
theorem exists_isUsablePrime (M : ℕ) (hM : M ≠ 0) :
    ∃ (q : ℕ) (𝔭 : Ideal (𝓞 F)), q.Prime ∧ ¬ q ∣ M ∧ IsUsablePrime 𝔭 ∧ (q : 𝓞 F) ∈ 𝔭 ∧
      Nat.card (𝓞 F ⧸ 𝔭) = q := by
  sorry

variable {F} in
/-- **A stable prime above a usable prime's characteristic**: unit vectors are integral at a usable prime
(`Arith.placeHom_base`), so `1/q ∉ ℤ[U]`, and row 105's prime inversion puts `q` in a stable prime. -/
theorem exists_stablePrime_natCast_mem {𝔭 : Ideal (𝓞 F)} (h𝔭 : IsUsablePrime 𝔭) {q : ℕ} (hq0 : q ≠ 0)
    (hq : (q : 𝓞 F) ∈ 𝔭) : ∃ P : StablePrime F, (q : 𝓞 (fieldI F)) ∈ P.P := by
  sorry

/-- **`F(i)` has a stable prime, at every real number field** (no Chebotarev: `exists_isUsablePrime`). -/
theorem nonempty_stablePrime : Nonempty (StablePrime F) := by
  sorry

/-- **`L(F)` is finite at every real number field**: a stable prime exists and its level-one target is a finite graph. -/
theorem localBound_lt_top : localBound F < ⊤ := by
  sorry

end HadwigerNelson.Rigidity
