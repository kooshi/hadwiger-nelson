import Mathlib.RingTheory.LaurentSeries

/-!
# J15 stage 1, route (i): the residue hom at `t = 0` through Laurent series and `PowerSeries.constantCoeff`

Sub-leaf 1: an element of the `X`-adic valuation subring of `RatFunc F` (Mathlib's `polynomialValuationX`) is a power series
in `F⸨X⸩`. Sub-leaf 2: the composite `B →+* F⟦X⟧ →+* F`.
-/

set_option autoImplicit false

namespace J15PriceI

open Polynomial PowerSeries LaurentSeries
open scoped LaurentSeries

variable (F : Type*) [Field F]

/-- Mathlib's `X`-adic valuation subring of `RatFunc F`. -/
noncomputable abbrev B : ValuationSubring (RatFunc F) := (RatFunc.polynomialValuationX F).valuationSubring

/-- **Sub-leaf 1.** An `X`-integral rational function is a power series in `F⸨X⸩`. -/
theorem coe_mem_powerSeries (f : RatFunc F) (hf : f ∈ B F) :
    (f : F⸨X⸩) ∈ powerSeries_as_subring F := by
  rw [Valuation.mem_valuationSubring_iff, RatFunc.valuation_eq_LaurentSeries_valuation] at hf
  have hc : ∀ n : ℤ, n < 0 → (f : F⸨X⸩).coeff n = 0 :=
    (valuation_le_iff_coeff_lt_eq_zero F (D := 0) (f := (f : F⸨X⸩))).mp (by
      rw [LaurentSeries.valuation_def]; simpa using hf)
  refine ⟨PowerSeries.mk fun n => (f : F⸨X⸩).coeff n, trivial, ?_⟩
  ext n
  rcases lt_or_ge n 0 with hn | hn
  · rw [hc n hn, HahnSeries.ofPowerSeries_apply]
    sorry
  · obtain ⟨m, rfl⟩ := Int.eq_ofNat_of_zero_le hn
    rw [coeff_coe_powerSeries]
    simp

/-- **Sub-leaf 2.** The residue hom, `B →+* F⟦X⟧ →+* F`. -/
noncomputable def residue : B F →+* F :=
  (PowerSeries.constantCoeff).comp <| (powerSeriesEquivSubring F).symm.toRingHom.comp <|
    ((algebraMap (RatFunc F) F⸨X⸩).comp (B F).toSubring.subtype).codRestrict _
      fun f => coe_mem_powerSeries F f f.2

end J15PriceI
