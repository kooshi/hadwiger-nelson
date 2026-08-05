import Proofs.HadwigerNelson.TwoCircle
import Proofs.HadwigerNelson.ClassGeometry

/-! # The 120° compulsion and the one-pivot cap

M20's sharpening of the two-circle barrier, in two theorems.

**The 120° compulsion** (`no_mono_outer_triple`): in every proper 3-colouring of the two
circles about `p`, an outer 120°-triple `{z, rot3 p z, rot3² p z}` is never monochromatic —
although its three points are pairwise *non-adjacent* (chord √3). The witness is the
seam-image unit triangle: `seamImage p z = p + σ·(z − p)` with `σ = seam/√3 = ⟨1/6, √11/6⟩`
lies on the inner circle, its `rot3`-orbit is a unit triangle (M18 `rot3_unit_triangle`),
hence rainbow — yet each member is unit-adjacent to one point of the triple, so a
monochromatic triple would starve the rainbow of its colour. The first colour compulsion
in this project that acts through no edge.

**The one-pivot cap** (`not_colorable_three` + `colorable_four`): adjoin the centre and
the system is *exactly* 4-chromatic. The centre eats one colour, any outer hexagon is
then 2-coloured and alternates, its even triple goes monochromatic, and the compulsion
kills it — ten points suffice (`p`, one hexagon, one inner triangle). Conversely M19's
3-colouring of the circles plus a fresh colour at `p` gives 4. Corollary, and the
sharpest form of the local barrier: **coverage 4 at five colours cannot arise within one
pivot's two-circle system — a fifth colour needs structure spanning more than one
pivot.** This theorem explains the flat `minCov = 3` histograms of M17–M19.

Found in M20 §0 (the compulsion, via the strip automaton's mono-column obstruction) and
independently in composed 16-point form by a reviewer instance whose note Kooshi relayed;
the compression to ten points is the compulsion lemma doing its work.
-/

namespace HadwigerNelson
namespace Compulsion

open Complex

/-! ## The seam ratio, rationalized -/

/-- `σ = seam/√3 = ⟨1/6, √11/6⟩`: the ratio carrying an outer point's displacement to its
seam-image on the inner circle. Defined with explicit components (the `/√3` is folded in:
`√33/√3 = √11`) so every norm fact below is component arithmetic. -/
noncomputable def seamRatio : ℂ := ⟨1 / 6, Real.sqrt 11 / 6⟩

theorem normSq_seamRatio : normSq seamRatio = 1 / 3 := sorry

theorem normSq_one_sub_seamRatio : normSq (1 - seamRatio) = 1 := sorry

/-- The tie to M19: `σ·√3 = seam` — the seam-image is the cross-chord rotation. -/
theorem seamRatio_mul_sqrt3 : seamRatio * (Real.sqrt 3 : ℂ) = TwoCircle.seam := sorry

/-! ## The seam image and its geometry -/

/-- The seam-image of `z` about `p`: the inner-circle point unit-adjacent to `z` whose
`rot3`-orbit witnesses the compulsion. -/
noncomputable def seamImage (p z : ℂ) : ℂ := p + seamRatio * (z - p)

/-- The seam-image of an outer point lies on the inner circle. -/
theorem dist_seamImage_pivot {p z : ℂ} (hz : dist z p = 1) :
    dist (seamImage p z) p = Real.sqrt 3 / 3 := sorry

/-- The inner radius squared, in the form `rot3_unit_triangle` consumes. -/
theorem dist_seamImage_sq {p z : ℂ} (hz : dist z p = 1) :
    dist (seamImage p z) p ^ 2 = 1 / 3 := sorry

/-- An outer point is unit-adjacent to its seam-image. -/
theorem dist_self_seamImage {p z : ℂ} (hz : dist z p = 1) :
    dist z (seamImage p z) = 1 := sorry

/-- `rot3` preserves every sphere about its pivot. -/
theorem rot3_mem_sphere {p z : ℂ} {r : ℝ} (h : z ∈ Metric.sphere p r) :
    rot3 p z ∈ Metric.sphere p r := sorry

/-! ## Restriction along a subset -/

/-- A colouring of a larger induced subgraph restricts to any subset — the bridge that
lets the compulsion (stated on the two circles) fire inside the `insert p` system. -/
noncomputable def restrictColoring {V : Type*} [MetricSpace V] {T D : Set V} (h : D ⊆ T)
    {κ : Type*} (C : ((unitDistance V).induce T).Coloring κ) :
    ((unitDistance V).induce D).Coloring κ := sorry

theorem restrictColoring_apply {V : Type*} [MetricSpace V] {T D : Set V} (h : D ⊆ T)
    {κ : Type*} (C : ((unitDistance V).induce T).Coloring κ) (a : D) :
    restrictColoring h C a = C ⟨a.1, h a.2⟩ := sorry

/-! ## The compulsion -/

/-- **The 120° compulsion.** In any proper 3-colouring of the two circles about `p`, the
outer 120°-triple of `z` — pairwise at chord √3, an independent set — never wears one
colour. The seam-image unit triangle is rainbow and each member refuses its partner's
colour. -/
theorem no_mono_outer_triple (p : ℂ)
    (C : ((unitDistance ℂ).induce
      (Metric.sphere p 1 ∪ Metric.sphere p (Real.sqrt 3 / 3))).Coloring (Fin 3))
    {z : ℂ} (hz : z ∈ Metric.sphere p 1) :
    ¬ (C ⟨rot3 p z, Or.inl (rot3_mem_sphere hz)⟩ = C ⟨z, Or.inl hz⟩ ∧
       C ⟨rot3 p (rot3 p z), Or.inl (rot3_mem_sphere (rot3_mem_sphere hz))⟩
         = C ⟨z, Or.inl hz⟩) := sorry

/-! ## The one-pivot cap -/

/-- The 60° step on the outer circle: the hexagon generator. -/
noncomputable def hexStep (p z : ℂ) : ℂ := p + TwoCircle.zeta6 * (z - p)

theorem hexStep_mem_sphere {p z : ℂ} (h : z ∈ Metric.sphere p 1) :
    hexStep p z ∈ Metric.sphere p 1 := sorry

/-- Consecutive hexagon points are unit-adjacent (the 60° chord). -/
theorem dist_self_hexStep {p z : ℂ} (hz : dist z p = 1) :
    dist z (hexStep p z) = 1 := sorry

/-- Two 60° steps are one 120° rotation: `hexStep² = rot3`. -/
theorem hexStep_hexStep (p z : ℂ) : hexStep p (hexStep p z) = rot3 p z := sorry

/-- **The cap, lower half.** Adjoin the centre and three colours no longer suffice: the
centre pigeonholes the outer circle to two colours, any hexagon then alternates, its even
triple goes monochromatic, and the compulsion kills it. Ten points carry the argument. -/
theorem not_colorable_three (p : ℂ) :
    ¬ ((unitDistance ℂ).induce
        (insert p (Metric.sphere p 1 ∪ Metric.sphere p (Real.sqrt 3 / 3)))).Colorable 3 :=
  sorry

/-- **The cap, upper half.** Four colours always suffice: M19's 3-colouring of the
circles, plus a fresh colour on the centre alone. -/
theorem colorable_four (p : ℂ) :
    ((unitDistance ℂ).induce
        (insert p (Metric.sphere p 1 ∪ Metric.sphere p (Real.sqrt 3 / 3)))).Colorable 4 :=
  sorry

end Compulsion
end HadwigerNelson
