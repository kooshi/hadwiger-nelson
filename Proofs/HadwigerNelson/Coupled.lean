import Proofs.HadwigerNelson.Compulsion

/-! # Coupled circle systems: the unit-distance pivot pair (M21 skeleton)

M20's one-pivot cap proved a 5th colour needs structure spanning at least two pivots;
this module studies the smallest such structure. Two pivots at distance exactly 1, each
carrying its two circles (radius `1` and `1/√3` — M20's cap object, here named `system`):
each pivot lies ON the partner's outer circle, so the systems interlock through the
strip's own operators — the eight circle-intersection points are `hexStep` images
(outer∩outer), `seamImage`s (outer∩inner), and one new half-sector direction
`iiRatio = ζ₁₂/√3` (inner∩inner). The gluing classification below is the pair's
analogue of M19's three chord lemmas.

The headline (the χ of the pair system: the two-pivot cap `= 4`, or a continuum `≥ 5`
witness) is set by the §0-D measurement — see `plans/M21-coupled-circle-systems.md` §2.4.

SKELETON: every proof is `sorry`; the statements are the specification under review.
-/

namespace HadwigerNelson
namespace Coupled

open Complex Compulsion

/-! ## The objects -/

/-- One pivot's whole system: the centre and its two circles — M20's cap object, named.
`chromaticNumber_concentric` says its induced unit-distance graph is exactly 4-chromatic. -/
noncomputable def system (p : ℂ) : Set ℂ :=
  insert p (Metric.sphere p 1 ∪ Metric.sphere p (Real.sqrt 3 / 3))

/-- The coupled system of two pivots. At `dist p q = 1` this is the milestone's object. -/
noncomputable def pairSystem (p q : ℂ) : Set ℂ := system p ∪ system q

/-- The conjugate sixth root `⟨1/2, −√3/2⟩` — `hexStep`'s other branch. -/
noncomputable def zeta6Conj : ℂ := ⟨1 / 2, -(Real.sqrt 3 / 2)⟩

/-- The conjugate hex step: the other unit chord from `z` along the circle about `p`. -/
noncomputable def hexStepConj (p z : ℂ) : ℂ := p + zeta6Conj * (z - p)

/-- The conjugate seam ratio `⟨1/6, −√11/6⟩` — `seamImage`'s other branch. -/
noncomputable def seamRatioConj : ℂ := ⟨1 / 6, -(Real.sqrt 11 / 6)⟩

/-- The conjugate seam image: the other unit chord from an outer point to the inner circle. -/
noncomputable def seamImageConj (p z : ℂ) : ℂ := p + seamRatioConj * (z - p)

/-- The half-sector ratio `ζ₁₂/√3 = ⟨1/2, √3/6⟩`: direction of the inner∩inner gluing
points — the one intersection direction the strip operators do not already name. -/
noncomputable def iiRatio : ℂ := ⟨1 / 2, Real.sqrt 3 / 6⟩

/-- The conjugate half-sector ratio `⟨1/2, −√3/6⟩`. -/
noncomputable def iiRatioConj : ℂ := ⟨1 / 2, -(Real.sqrt 3 / 6)⟩

/-! ## The interlock: each system's operators land on the partner -/

/-- The pair premise as membership: at distance 1 the partner pivot is an outer point. -/
theorem pivot_mem_outer {p q : ℂ} (h : dist p q = 1) : q ∈ Metric.sphere p 1 := by
  sorry

/-- The seam of one system lands on the other: `seamImage p q` sits on `p`'s inner circle
AND on `q`'s outer circle. The interlock that makes the pair rigid. -/
theorem seamImage_interlock {p q : ℂ} (h : dist p q = 1) :
    seamImage p q ∈ Metric.sphere p (Real.sqrt 3 / 3) ∩ Metric.sphere q 1 := by
  sorry

/-! ## The gluing classification: the four circle-pair intersections, explicitly -/

/-- Outer meets outer in exactly the two hex steps of the partner pivot. -/
theorem outer_inter_outer {p q : ℂ} (h : dist p q = 1) :
    Metric.sphere p 1 ∩ Metric.sphere q 1 = {hexStep p q, hexStepConj p q} := by
  sorry

/-- `p`'s outer meets `q`'s inner in exactly the two seam images of `p` about `q`. -/
theorem outer_inter_inner {p q : ℂ} (h : dist p q = 1) :
    Metric.sphere p 1 ∩ Metric.sphere q (Real.sqrt 3 / 3)
      = {seamImage q p, seamImageConj q p} := by
  sorry

/-- Inner meets inner in exactly the two half-sector points. -/
theorem inner_inter_inner {p q : ℂ} (h : dist p q = 1) :
    Metric.sphere p (Real.sqrt 3 / 3) ∩ Metric.sphere q (Real.sqrt 3 / 3)
      = {p + iiRatio * (q - p), p + iiRatioConj * (q - p)} := by
  sorry

/-! ## The lower bound -/

/-- Four colours are already forced inside either half (M20's cap), so the pair needs
at least four — no distance hypothesis required. -/
theorem four_le_chromaticNumber_pairSystem (p q : ℂ) :
    4 ≤ ((unitDistance ℂ).induce (pairSystem p q)).chromaticNumber := by
  sorry

/-! ## The headline question, carried open

§0 left the χ of the pair system measured-but-open: every sampled finite sub-lattice is
4-colourable (no cheap ≥ 5 witness), yet NO pair of M19 sector colourings is proper on
the pair under any rotation, reflection, or palette injection (no known ≤ 4
construction). Neither branch is committed as a statement; each carries a reopening
gate in the subplan (§2.4). The candidate second theorem — the mesh barrier — enters
here only if the domain-modeling pass finds it a clean finite statement. -/

end Coupled
end HadwigerNelson
