import Proofs.HadwigerNelson.Plane.DensityBound.Theorem

/-!
# `m₁(ℝ²) ≤ 0.2470` and `m₁(ℝ²) < 1/4`, with no hypothesis (FS-131, job FS131-LCH1)

`Plane.mOne` is `m₁(ℝ²)` (`Plane/OneClass/Defs`): the supremum of the upper densities of the measurable sets of the
plane with no two points at distance one. `Plane/OneAvoidingDensity` bounds it given `[AmbrusEtAl2023]` Theorem 1 as
printed (`Plane.OneAvoidingDensityBound`), and `Plane/DensityBound/Theorem` proves that theorem from the paper's
certificate, checked by the kernel with no `native_decide` (`Plane.oneAvoidingDensityBound`). This module applies the
second to the first, so the two bounds stand with no hypothesis. They live here and not beside the conditional forms,
because `Plane/DensityBound/` imports `Plane/OneAvoidingDensity` (the coordinator's ruling at FS131-LCH1).

The bound `0.2470` is `[AmbrusEtAl2023]`'s; with `OneClass.one_seventh_le_mOne` (`Plane/OneClass/Algebraic`) the library
holds `1/7 ≤ m₁(ℝ²) ≤ 0.2470` on one constant.
-/

namespace HadwigerNelson.Plane

/-- **`m₁(ℝ²) ≤ 0.2470`** (`[AmbrusEtAl2023]` Theorem 1): `mOne_le_of_oneAvoidingDensityBound` at the library's
proof of the paper's theorem. -/
theorem mOne_le_0_2470 : mOne ≤ ENNReal.ofReal 0.2470 :=
  mOne_le_of_oneAvoidingDensityBound oneAvoidingDensityBound

/-- **`m₁(ℝ²) < 1/4`**: `mOne_lt_quarter` at the library's proof of `[AmbrusEtAl2023]` Theorem 1 — the form the
five-colour chain's count reads. -/
theorem mOne_lt_one_quarter : mOne < ENNReal.ofReal (1 / 4) :=
  mOne_lt_quarter oneAvoidingDensityBound

end HadwigerNelson.Plane
