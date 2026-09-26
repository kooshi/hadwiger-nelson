import Proofs.HadwigerNelson.ThetaCert
import Proofs.HadwigerNelson.SquareClass
import Proofs.HadwigerNelson.Chain
import Proofs.HadwigerNelson.UnitDistance
import Mathlib.Data.List.GetD

/-!
# A relation-branching certificate's lattice in the plane over a real field (FS-75, job J52K)

A certificate's units are integer vectors `(a, b, c, e)`, read as the points `((a + b√d)/D, (c + e√d)/D)` of the plane
over any real field `F` holding `√d` (`ThetaPlane.iota`, additive, not required to be injective). When each listed
vector satisfies the two integer identities `a² + d·b² + c² + d·e² = D²` and `ab + ce = 0` (`unitOk`, a `Bool`), each is a
unit vector, so a proper three-colouring of the plane over `F` pulls back to a colouring of `ℕ → ℤ` proper along the
units — which a passing certificate refuses (`ThetaCert.Cert.not_properAlong`).

## Main result

* `ThetaPlane.four_le_chromaticNumber_of_cert` — a passing certificate whose units are unit vectors of `ℚ(√d)²` with
  denominator `D` proves `χ(F²) ≥ 4` for every real field `F` holding `√d`. No finite graph is built.
-/

namespace HadwigerNelson
namespace ThetaPlane

open SimpleGraph ThreeColour ThetaCert

/-- `(a, b, c, e) ↦ ((a + b√d)/D, (c + e√d)/D)`, read off the first four coordinates; additive, and not required to
be injective. -/
noncomputable def iota (d D : ℕ) : (ℕ → ℤ) →+ ℂ where
  toFun v := ⟨((v 0 : ℝ) + v 1 * Real.sqrt d) / D, ((v 2 : ℝ) + v 3 * Real.sqrt d) / D⟩
  map_zero' := by apply Complex.ext <;> simp
  map_add' v w := by apply Complex.ext <;> simp <;> ring

theorem iota_re (d D : ℕ) (v : ℕ → ℤ) : (iota d D v).re = ((v 0 : ℝ) + v 1 * Real.sqrt d) / D := rfl

theorem iota_im (d D : ℕ) (v : ℕ → ℤ) : (iota d D v).im = ((v 2 : ℝ) + v 3 * Real.sqrt d) / D := rfl

theorem iota_mem {d D : ℕ} {F : Subfield ℝ} (hF : Real.sqrt d ∈ F) (v : ℕ → ℤ) : iota d D v ∈ planeOver F := by
  have key : ∀ x y : ℤ, ((x : ℝ) + y * Real.sqrt d) / D ∈ F := fun x y =>
    div_mem (add_mem (intCast_mem _ _) (mul_mem (intCast_mem _ _) hF)) (natCast_mem _ _)
  exact mem_planeOver.mpr ⟨key _ _, key _ _⟩

/-- The unit test on one listed vector, as a `Bool`: `a² + d·b² + c² + d·e² = D²` and `ab + ce = 0`. -/
def unitOk (d D : ℕ) (u : List ℤ) : Bool :=
  u.getD 0 0 ^ 2 + d * u.getD 1 0 ^ 2 + u.getD 2 0 ^ 2 + d * u.getD 3 0 ^ 2 == (D : ℤ) ^ 2 &&
    u.getD 0 0 * u.getD 1 0 + u.getD 2 0 * u.getD 3 0 == 0

example : unitOk 167 420 [-332, -3, 249, -4] = true ∧ unitOk 167 420 [-332, -3, 249, 4] = false := by decide

/-- The two integer identities make a unit vector. -/
theorem norm_iota {d D : ℕ} (hD : D ≠ 0) {v : ℕ → ℤ}
    (h1 : v 0 ^ 2 + d * v 1 ^ 2 + v 2 ^ 2 + d * v 3 ^ 2 = (D : ℤ) ^ 2) (h2 : v 0 * v 1 + v 2 * v 3 = 0) :
    ‖iota d D v‖ = 1 := by
  apply Chain.norm_eq_one_of_sq
  have hs : Real.sqrt d * Real.sqrt d = d := Real.mul_self_sqrt (Nat.cast_nonneg d)
  have hD' : (D : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hD
  have h1' : (v 0 : ℝ) ^ 2 + d * (v 1 : ℝ) ^ 2 + (v 2 : ℝ) ^ 2 + d * (v 3 : ℝ) ^ 2 = (D : ℝ) ^ 2 := by exact_mod_cast h1
  have h2' : (v 0 : ℝ) * v 1 + v 2 * v 3 = 0 := by exact_mod_cast h2
  rw [iota_re, iota_im]
  field_simp
  linear_combination h1' + 2 * Real.sqrt d * h2' + ((v 1 : ℝ) ^ 2 + (v 3 : ℝ) ^ 2) * hs

/-- A three-colouring of the plane over `F ∋ √d` pulls back to a colouring proper along the certificate's units. -/
theorem properAlong_of_colorable {d D : ℕ} (hD : D ≠ 0) {F : Subfield ℝ} (hF : Real.sqrt d ∈ F) (c : Cert)
    (hu : c.units.all (unitOk d D) = true) (h : ((unitDistance ℂ).induce (planeOver F)).Colorable 3) :
    ∃ col : (ℕ → ℤ) → ZMod 3, ProperAlong c.gen col := by
  obtain ⟨C⟩ := h
  refine ⟨fun v => (C ⟨iota d D v, iota_mem hF v⟩ : ZMod 3), fun a j => ?_⟩
  have hunit : unitOk d D (c.units.getD j []) = true := by
    rw [List.getD_eq_getElem _ _ j.isLt]
    exact List.all_eq_true.mp hu _ (List.getElem_mem _)
  simp only [unitOk, Bool.and_eq_true, beq_iff_eq] at hunit
  have hnorm : ‖iota d D (c.gen j)‖ = 1 := norm_iota hD hunit.1 hunit.2
  have hadj : ((unitDistance ℂ).induce (planeOver F)).Adj ⟨iota d D (a + c.gen j), iota_mem hF _⟩
      ⟨iota d D a, iota_mem hF _⟩ := by
    simp only [comap_adj, Function.Embedding.coe_subtype, unitDistance_adj, map_add, dist_eq_norm,
      add_sub_cancel_left, hnorm]
  exact fun h => C.valid hadj h

/-- **The consumer.** A passing certificate whose units are unit vectors of `ℚ(√d)²` with denominator `D` proves
`χ(F²) ≥ 4` for every real field `F` holding `√d`. One line per field: FS-60's quadratic witnesses, ℚ(√47)'s tree
(if it is in this format), the 60-vector control. -/
theorem four_le_chromaticNumber_of_cert {d D : ℕ} (hD : D ≠ 0) (c : Cert) (hu : c.units.all (unitOk d D) = true)
    (hc : c.check = true) {F : Subfield ℝ} (hF : Real.sqrt d ∈ F) :
    4 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  have key : ¬ ((unitDistance ℂ).induce (planeOver F)).Colorable 3 := fun h => by
    obtain ⟨col, hcol⟩ := properAlong_of_colorable hD hF c hu h
    exact c.not_properAlong hc col hcol
  simpa using add_one_le_chromaticNumber_iff_not_colorable.mpr key

end ThetaPlane
end HadwigerNelson
