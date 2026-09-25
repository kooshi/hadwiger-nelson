import Proofs.HadwigerNelson.ResidueColouring
import Mathlib.RingTheory.Valuation.LocalSubring

/-!
# K3 option B skeleton (J04 → J16): prime inversion in valuation form, FS-47 D2–D3

GPT Astra's Theorem 1.2 (`plans/ASTRA-2026-09-14-derivation.md` T2), prior art `[Fischer1990b]` Thms 1, 3–5, with the
number-field translation left as row 57's named gap: here a "stable prime" is a **σ-stable valuation subring**. The "if"
is Chevalley's domination (`Ideal.image_subset_nonunits_valuationSubring`, Stacks 00IA); the "only if" is
`normOne_subset_valuationSubring`. No number-field plumbing.
-/

set_option autoImplicit false

namespace HadwigerNelson
namespace PrimeInversion

variable {L : Type*} [Field L]

/-- The unit-vector ring `ℤ[U]`: the subring the norm-one elements generate (M56's `Σ₀`, Fischer's lattice). -/
def unitRing (σ : L →+* L) : Subring L := Subring.closure (normOne σ)

/-! ## Leaf 1 (priced by J04): holding every norm-one element is the same as σ-stability -/

theorem normOne_subset_iff_stable (σ : L →+* L) (hσσ : ∀ z : L, σ (σ z) = z) (B : ValuationSubring L) :
    normOne σ ⊆ (B : Set L) ↔ ∀ z ∈ B, σ z ∈ B := by
  refine ⟨fun h z hz => ?_, fun h => normOne_subset_valuationSubring B h hσσ⟩
  rcases eq_or_ne z 0 with rfl | hz0
  · simp
  · have hn : σ z / z ∈ normOne σ := by
      rw [mem_normOne, map_div₀, hσσ]
      have : σ z ≠ 0 := fun h0 => hz0 (by simpa [hσσ] using congrArg σ h0)
      field_simp
    have : σ z = σ z / z * z := by field_simp
    rw [this]
    exact B.mul_mem _ _ (h hn) hz

/-! ## Leaf 2 (priced by J04): an element of `R` is invertible in `R` iff in every valuation subring above `R` -/

theorem inv_mem_iff_forall_valuationSubring (R : Subring L) {x : L} (hx : x ∈ R) (hx0 : x ≠ 0) :
    x⁻¹ ∈ R ↔ ∀ B : ValuationSubring L, R ≤ B.toSubring → x⁻¹ ∈ B := by
  refine ⟨fun h B hB => hB h, fun h => ?_⟩
  by_contra hinv
  let I : Ideal R := Ideal.span {⟨x, hx⟩}
  have hI : I ≠ ⊤ := by
    intro htop
    obtain ⟨r, hr⟩ := Ideal.mem_span_singleton'.mp ((Ideal.eq_top_iff_one I).mp htop)
    have hr' : (r : L) * x = 1 := by simpa using congrArg Subtype.val hr
    exact hinv (by rw [inv_eq_of_mul_eq_one_left hr'] ; exact r.2)
  obtain ⟨B, hRB, hsub⟩ := Ideal.image_subset_nonunits_valuationSubring I hI
  have hxB : x ∈ B.nonunits := hsub ⟨⟨x, hx⟩, Ideal.mem_span_singleton_self _, rfl⟩
  rw [ValuationSubring.mem_nonunits_iff_or] at hxB
  rcases hxB with h0 | hnot
  · exact hx0 h0
  · exact hnot (h B hRB)

/-! ## Prime inversion, valuation form (J16) -/

/-- **Prime inversion** (valuation form): `1/n ∈ ℤ[U]` iff `n` is a unit in every σ-stable valuation subring. The
number-field reading — σ-stable valuation subrings with `n` in the maximal ideal are the conjugation-stable primes of
`𝓞_{F(i)}` above `n` — is row 57's gap (FS-37). -/
theorem inv_natCast_mem_unitRing_iff [CharZero L] (σ : L →+* L) (hσσ : ∀ z : L, σ (σ z) = z) {n : ℕ} (hn : n ≠ 0) :
    (n : L)⁻¹ ∈ unitRing σ ↔ ∀ B : ValuationSubring L, (∀ z ∈ B, σ z ∈ B) → (n : L)⁻¹ ∈ B := by
  sorry

/-- The spec example over `ℂ` with complex conjugation: `1/5 = (3+4i)/5 + (3−4i)/5 − 1` lies in `ℤ[U]`. -/
theorem inv_five_mem_unitRing_conj : (5 : ℂ)⁻¹ ∈ unitRing (starRingEnd ℂ) := by
  sorry

end PrimeInversion
end HadwigerNelson
