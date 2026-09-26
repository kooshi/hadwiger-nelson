import Proofs.HadwigerNelson.ThetaPlane
import Proofs.HadwigerNelson.Instances.SqrtOneSixSeven.Cert

/-!
# `χ(ℚ(√167)²) ≥ 4` in the kernel, with no finite graph (FS-75's minimal instance, job J52K)

`LEDGER.md` row 79, FS73-T41: the 36 unit vectors `{1, v, z}·U_R` of the plane over `ℚ(√167)` (18 ± pairs;
`v = (83 + i√167)/84`, the type-M rotation `n = 42`) carry no winding, by the 1,050-leaf relation-branching certificate
`Sqrt167.cert` (`Instances/SqrtOneSixSeven/Cert.lean`). So no colouring of `ℕ → ℤ` is proper along them
(`ThreeColour.nonempty_winding` against `ThetaCert.Cert.isEmpty_winding`), and the plane over `ℚ(√167)` — which holds
their image under `ThetaPlane.iota 167 420` — has no proper three-colouring.

No finite unit-distance graph is built and no `θ` of `Θ₃` appears: the certificate is checked against the integer winding
a colouring carries. Standard three axioms, no native purchase. The upper side, `χ ≤ 5`, and the conjecture's prediction
`χ(ℚ(√167)²) ≥ 6` are not touched here.

## Main results

* `Sqrt167.cert_units`, `Sqrt167.cert_check` — the certificate's units are unit vectors, and it passes, by `decide +kernel`;
* `four_le_chromaticNumber_planeOver_sqrt167` — the headline;
* `four_le_chromaticNumber_planeOver_of_sqrt167_mem` — the same over every real field holding `√167`.
-/

namespace HadwigerNelson
namespace Sqrt167

/-- Every listed unit is a unit vector of `ℚ(√167)²` with denominator 420. -/
theorem cert_units : cert.units.all (ThetaPlane.unitOk 167 420) = true := by decide +kernel

/-- The certificate passes: its 19 relations are relations of the units, and its 1,050 leaves refute their paths. -/
theorem cert_check : cert.check = true := by decide +kernel

end Sqrt167

/-- **`χ(ℚ(√167)²) ≥ 4`** (row 79 in the kernel): the 36 unit vectors `{1, v, z}·U_R` carry no winding, so the plane
over `ℚ(√167)` has no proper three-colouring. No finite graph is built; standard three axioms, no native purchase. -/
theorem four_le_chromaticNumber_planeOver_sqrt167 :
    4 ≤ ((unitDistance ℂ).induce (planeOver (SquareClass.fieldOfRadicands {167}))).chromaticNumber :=
  ThetaPlane.four_le_chromaticNumber_of_cert (by norm_num) Sqrt167.cert Sqrt167.cert_units Sqrt167.cert_check
    (SquareClass.sqrt_mem_fieldOfRadicands rfl)

/-- The same bound over every real field holding `√167`. -/
theorem four_le_chromaticNumber_planeOver_of_sqrt167_mem {F : Subfield ℝ} (hF : Real.sqrt 167 ∈ F) :
    4 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  exact ThetaPlane.four_le_chromaticNumber_of_cert (by norm_num) Sqrt167.cert Sqrt167.cert_units Sqrt167.cert_check
    (by exact_mod_cast hF)

end HadwigerNelson
