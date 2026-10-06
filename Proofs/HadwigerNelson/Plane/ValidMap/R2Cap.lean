import Proofs.HadwigerNelson.Plane.ValidMap.BendCollar
import Proofs.HadwigerNelson.Plane.ValidMap.BendAway

/-!
# The radius-2 circle over a constant-sided unit arc: the crescent, the dichotomy, the subdivision (FS131-KA1's skeleton)

What the away bend reads of the inner colour's class near the radius-2 arc `R₂(ᾱ)` over a constant-sided unit arc of a valid map
(`plans/FS131-bendaway-kernel-plan.md` § 3, lane C):

* `exists_r2_crescent_free` — the radius-2 form of `exists_end_free`: near a point of the domain on the radius-2 circle, the arcs of
  `Γ` in the crescent between the circles of radius `2(1 − τ)` and `2(1 + τ)` tangent there lie on the radius-2 circle.
* `r2_side_dichotomy` — on each side of a radius-2 point over the arc, the contacts are **all or none**, and in the "none" case the
  class stays off a disc of radius `ρ₀ > 2` tangent to the radius-2 circle at the point (FS131-E5 § 4.2's premise).
* `exists_r2Subdiv` — so `[θ₁, θ₂]` has a finite subdivision into contact pieces and gaps, when `R₂(ᾱ)` lies in the domain. **This is
  where a plane map is needed** (inventory items 290–291).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **Near a radius-2 point, the arcs of `Γ` in the crescent hugging the radius-2 circle lie on it** (the radius-2 form of
`exists_end_free`, at any point `P + 2 e(θ_E)` of the domain and either side `σ`). Route: `exists_end_free`'s proof with the frame at
`P + 2 e(θ_E)`: `branch_transversal` applies as it stands (`R' = 2(1 − τ) > 1/2`, `R'' = 2(1 + τ) > 1`); `branch_tangent` applies to
the halved variables `(X/2, Y/2, s/2, 2κ)`, which turn the radius-2 crescent into the unit one. **Open — `sorry`** (child C1).
Inhabitant of the hypotheses: any point of a plane map. -/
theorem exists_r2_crescent_free (F : ArcMap k) {P : ℂ} {θE σ : ℝ} (hE : P + 2 * e θE ∈ F.dom) (hσ : σ = 1 ∨ σ = -1) :
    ∃ ρ > 0, ∃ τ₀ > 0, ∀ τ, 0 < τ → τ < τ₀ → ∀ z ∈ F.Γ, dist z (P + 2 * e θE) < ρ → ∀ X Y : ℝ,
      z - (P + 2 * e θE) = ((Y : ℂ) + (X : ℂ) * I) * e θE → 0 ≤ σ * X → 0 ≤ 2 * (2 * (1 - τ)) * Y + (X ^ 2 + Y ^ 2) →
        2 * (2 * (1 + τ)) * Y + (X ^ 2 + Y ^ 2) ≤ 0 → dist z P = 2 := by
  sorry

/-- **All or none**: over a constant-sided unit arc of a valid map, at a radius-2 point `w₀ = P + 2 e(θ₀)` of the domain and on a
side `σ` on which the arc continues (`θ₀ + σ δ₀ ∈ [θ₁, θ₂]`), either every nearby radius-2 point on that side is a contact of the
inner colour's class, or none is and the class's points near `w₀` on that side that are not inside the radius-2 circle lie off the disc
of radius `ρ₀ > 2` tangent to it at `w₀` from `P`'s side (centre `P + (2 − ρ₀) e(θ₀)`). Route: the open crescent between the
radius-2 circle and the circle of radius `2(1 + τ)` on that side is free of `Γ` (`exists_r2_crescent_free`), connected and in the
domain, so of one colour `j`; a radius-2 point `w` next to `w₀` on that side has a neighbourhood whose part outside the radius-2 circle
is in the crescent and whose part inside or on it misses the class (inside by `ne1_region` against the inner side of the arc near
`r(θ)`, an interior point of the arc; on the circle because the class is open), so `w` is a contact iff `j = c`. **Open — `sorry`** (child C2). Inhabitant of the
hypotheses: owed with the away bend's model (plan § 5). -/
theorem r2_side_dichotomy (hF : F.Valid) {P : ℂ} {θ₁ θ₂ θ₀ σ δ₀ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hσ : σ = 1 ∨ σ = -1) (hθ₀ : θ₀ ∈ Icc θ₁ θ₂) (hδ₀ : 0 < δ₀) (hside : θ₀ + σ * δ₀ ∈ Icc θ₁ θ₂)
    (hw : P + 2 * e θ₀ ∈ F.dom) :
    ∃ δ > 0, ∃ η > 0, ∃ ρ₀ > 2,
      (∀ t ∈ Ioo 0 δ, P + 2 * e (θ₀ + σ * t) ∈ closure (F.region c)) ∨
      ((∀ t ∈ Ioo 0 δ, P + 2 * e (θ₀ + σ * t) ∉ closure (F.region c)) ∧
        ∀ y ∈ F.region c, dist y (P + 2 * e θ₀) < η → 0 < σ * ((y - P) * starRingEnd ℂ (e θ₀)).im → 2 ≤ dist y P →
          ρ₀ ≤ dist y (P + ((2 - ρ₀ : ℝ) : ℂ) * e θ₀)) := by
  sorry

/-- **The radius-2 contacts over a constant-sided unit arc have a finite subdivision** when `R₂(ᾱ)` lies in the domain: by
`r2_side_dichotomy` each angle of `[θ₁, θ₂]` has, on each side, a one-sided neighbourhood wholly in the contacts or wholly off them;
`R2Subdiv.of_local` joins the pieces (near `x` an interval `(u, v)` is one piece if `x ∉ (u, v)` and two joined at `x` otherwise). **Open — `sorry`** (child C3). Inhabitant of the hypotheses: owed with the away bend's model. -/
theorem exists_r2Subdiv (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hdom : radiusTwoArc P θ₁ θ₂ ⊆ F.dom) : R2Subdiv {θ | P + 2 * e θ ∈ closure (F.region c)} θ₁ θ₂ := by
  sorry

end ArcMap

end HadwigerNelson.Plane
