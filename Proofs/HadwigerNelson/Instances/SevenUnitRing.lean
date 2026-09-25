import Proofs.HadwigerNelson.UnitRing
import Proofs.HadwigerNelson.Instances.SevenConditional

/-!
# The 2-adic wall is broken over `K(√7)`, in the kernel (FS-47 D5)

Over `K(√7) = ℚ(√3, √7, √11)`, `w = (−3 + i√7)/4` is a unit vector with trace `w + w̄ = −3/2`, so
`1/2 = w + w̄ + 2` lies in the unit-vector ring, and `3/8 = 3·(1/2)³` with it (`CLAUDE.md` G55). By prime inversion in
valuation form (`UnitRing.inv_natCast_mem_unitRingOver_iff`) **no conjugation-stable valuation subring of `K(√7)(i)` has 2 in
its maximal ideal** (`wall_broken_seven`) — the wall broken, as a kernel fact about places. That this is the statement "every
prime of `K(√7)` above 2 splits in `K(√7)(i)`" is row 57's gap, not proved here.

The chain theorem in ring form then re-derives `χ(K(√7)²) ≥ 5` from `G4` with no explicit multipliers (the `example` at the
end): the eight unit vectors of `SevenConditional.five_le_chromaticNumber_planeOver_seven_of_G4` are one representation of
`3/8 ∈ ℤ[U]`, and any other would do.
-/

namespace HadwigerNelson
namespace SevenUnitRing

open SimpleGraph Chain SquareClass UnitRing SevenConditional

theorem w_mem_unitRingOver : w ∈ unitRingOver F7 := unit_mem_unitRingOver w_mem norm_w

theorem conj_w_mem_unitRingOver : starRingEnd ℂ w ∈ unitRingOver F7 :=
  unit_mem_unitRingOver conj_w_mem (by rw [Complex.norm_conj]; exact norm_w)

/-- `1/2 = w + w̄ + 2`: the trace of `w` is `−3/2`. -/
theorem inv_two_eq : (2 : ℂ)⁻¹ = w + starRingEnd ℂ w + 2 := by
  rw [conj_w]
  ring

/-- **`1/2 ∈ ℤ[U]` over `K(√7)`** — the 2-adic wall is broken there (G35, G55). -/
theorem inv_two_mem_unitRingOver_seven : (2 : ℂ)⁻¹ ∈ unitRingOver F7 := by
  rw [inv_two_eq]
  exact add_mem (add_mem w_mem_unitRingOver conj_w_mem_unitRingOver) (by exact_mod_cast natCast_mem (unitRingOver F7) 2)

/-- **`3/8 ∈ ℤ[U]` over `K(√7)`** — the number the eight-copy chain closes on (T9). -/
theorem three_div_eight_mem_unitRingOver_seven : (3 / 8 : ℂ) ∈ unitRingOver F7 := by
  have h : (3 / 8 : ℂ) = 3 * (2 : ℂ)⁻¹ ^ 3 := by norm_num
  rw [h]
  exact mul_mem (by exact_mod_cast natCast_mem (unitRingOver F7) 3) (pow_mem inv_two_mem_unitRingOver_seven 3)

/-- **The wall is broken over `K(√7)`, valuation form**: no conjugation-stable valuation subring of `K(√7)(i)` has 2 in its
maximal ideal. The reading "every prime above 2 splits in `K(√7)(i)`" is row 57's gap. -/
theorem wall_broken_seven :
    ∀ B : ValuationSubring (planeOverSubfield F7), (∀ z ∈ B, conjOn (conj_mem_planeOverSubfield F7) z ∈ B) →
      (2 : planeOverSubfield F7) ∉ B.nonunits := by
  have h := (inv_natCast_mem_unitRingOver_iff F7 (n := 2) two_ne_zero).mp
    (by exact_mod_cast inv_two_mem_unitRingOver_seven)
  simpa using h

/-! ## Spec -/

-- The ring-form chain theorem consumes `3/8 ∈ ℤ[U]` directly: `χ(K(√7)²) ≥ 5` from `G4`, with no multipliers named.
example (h : G4) : 5 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {3, 7, 11}))).chromaticNumber := by
  obtain ⟨n, E, q, a, b, hq, hqF, hδ, hf⟩ := h
  have hinv : (q b - q a)⁻¹ ∈ unitRingOver F7 := by
    rw [hδ]
    convert three_div_eight_mem_unitRingOver_seven using 1
    norm_num
  have hne : q b ≠ q a := fun h0 => by rw [h0, sub_self] at hδ; norm_num at hδ
  simpa using add_one_le_chromaticNumber_planeOver_of_inv_mem_unitRingOver (F := F7) q hq
    (fun z => planeOver_seam_subset (hqF z)) hf hne hinv

end SevenUnitRing
end HadwigerNelson
