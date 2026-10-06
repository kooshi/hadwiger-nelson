import Proofs.HadwigerNelson.Plane.Chord

/-!
# Unit-speed curves of curvature at most 1 (FS-131 wave 6; the curve notion of FS131-E8's bridge)

One curve notion for the bridge's rows and for the ladder (`plans/FS131-w6-kernel-plan.md` § 11): a map `γ : ℝ → ℂ`
on an interval `I` with `γ' = e ∘ ψ`, the **tangent angle** `ψ` being 1-Lipschitz — unit speed, and curvature at most
`1` in the only form the arguments read (`|ψ s − ψ u| ≤ |s − u|`; no second derivative). Mathlib has no home for it.

* `IsUnitCurve γ ψ I`; inhabitant `isUnitCurve_segment`.
* The three inequalities of `plans/FS131-E8-derivation.md` §§ 3.2–3.3 and the comparison with the tangent unit discs:
  `IsUnitCurve.chord` (C1), `IsUnitCurve.sin_le_inner` (C2), `IsUnitCurve.norm_sub_le` (the `s²/2` bound),
  `IsUnitCurve.one_le_dist` (the lens: the curve stays outside the two open unit discs tangent to it at its start).
* `norm_sub_le_of_discs` (**proved**): unit normals at two points whose opposite unit discs do not overlap differ by
  at most the distance of the points — the normal of a two-sided unit-disc condition is 1-Lipschitz, with the sharp
  constant and no second derivative; `lipschitzOnWith_of_chord` turns the chordal bound into the angle's.

No measure and no colouring is read in this module.
-/

namespace HadwigerNelson.Plane

open Complex Set Filter Topology Metric

/-- A **unit-speed curve of curvature at most 1** on `I`: `γ` has derivative `e (ψ s)` at every `s ∈ I`, and the
tangent angle `ψ` is 1-Lipschitz on `I`. -/
structure IsUnitCurve (γ : ℝ → ℂ) (ψ : ℝ → ℝ) (I : Set ℝ) : Prop where
  /-- The unit tangent at `s` is `e (ψ s)`. -/
  hasDeriv : ∀ s ∈ I, HasDerivWithinAt γ (e (ψ s)) I s
  /-- The tangent angle is 1-Lipschitz in arclength. -/
  lip : LipschitzOnWith 1 ψ I

/-- **Inhabitant**: the segment `s ↦ s`, of tangent angle `0`. -/
theorem isUnitCurve_segment (I : Set ℝ) : IsUnitCurve (fun s : ℝ => (s : ℂ)) (fun _ => 0) I :=
  ⟨fun s _ => by simpa [e] using (hasDerivWithinAt_id s I).ofReal_comp,
    ((LipschitzWith.const (0 : ℝ)).weaken zero_le_one).lipschitzOnWith⟩

/-- A unit-speed curve restricted to a smaller set. -/
theorem IsUnitCurve.mono {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {I J : Set ℝ} (h : IsUnitCurve γ ψ I) (hJ : J ⊆ I) :
    IsUnitCurve γ ψ J :=
  ⟨fun s hs => (h.hasDeriv s (hJ hs)).mono hJ, h.lip.mono hJ⟩

/-- **The chord bound** (FS131-E8 § 3.2 (1), control `e8-chord` C1): along its initial tangent a curve of length
`ℓ ≤ π/2` advances at least `sin ℓ`. -/
theorem IsUnitCurve.chord {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {ℓ : ℝ} (h : IsUnitCurve γ ψ (Icc 0 ℓ)) (hℓ0 : 0 ≤ ℓ)
    (hℓ : ℓ ≤ Real.pi / 2) : Real.sin ℓ ≤ ((γ ℓ - γ 0) * (starRingEnd ℂ) (e (ψ 0))).re := by
  sorry

/-- **The distance from the start increases** (FS131-E8 § 3.3, control `e8-chord` C2): for `s ≤ π/2` the chord from
the start makes with the tangent at `s` an inner product at least `sin s` — so `|γ s − γ 0|²` has derivative at least
`2 sin s`. -/
theorem IsUnitCurve.sin_le_inner {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {ℓ : ℝ} (h : IsUnitCurve γ ψ (Icc 0 ℓ))
    (hℓ : ℓ ≤ Real.pi / 2) {s : ℝ} (hs : s ∈ Icc 0 ℓ) :
    Real.sin s ≤ ((γ s - γ 0) * (starRingEnd ℂ) (e (ψ s))).re := by
  sorry

/-- The distance from the start is strictly increasing along a curve of length at most `π/2`. -/
theorem IsUnitCurve.strictMonoOn_dist {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {ℓ : ℝ} (h : IsUnitCurve γ ψ (Icc 0 ℓ))
    (hℓ : ℓ ≤ Real.pi / 2) : StrictMonoOn (fun s => dist (γ s) (γ 0)) (Icc 0 ℓ) := by
  sorry

/-- The curve leaves its initial tangent line at most quadratically (FS131-E8 § 3.3). -/
theorem IsUnitCurve.norm_sub_le {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {ℓ : ℝ} (h : IsUnitCurve γ ψ (Icc 0 ℓ)) {s : ℝ}
    (hs : s ∈ Icc 0 ℓ) : ‖γ s - γ 0 - (s : ℂ) * e (ψ 0)‖ ≤ s ^ 2 / 2 := by
  sorry

/-- **The lens bound**: a curve of length at most `π/2` stays outside the two open unit discs tangent to it at its
start (the comparison FS121-V2-SECTOR makes with a unit circle; the planner's three lines from `sin_le_inner`, for the
deriver's check: `(d/ds)(|γ s − γ 0 ∓ i e(ψ 0)|²) = 2⟨γ s − γ 0, T s⟩ ∓ 2 sin (ψ s − ψ 0) ≥ 2 sin s − 2 sin s`). -/
theorem IsUnitCurve.one_le_dist {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {ℓ : ℝ} (h : IsUnitCurve γ ψ (Icc 0 ℓ))
    (hℓ : ℓ ≤ Real.pi / 2) {s : ℝ} (hs : s ∈ Icc 0 ℓ) :
    1 ≤ dist (γ s) (γ 0 + I * e (ψ 0)) ∧ 1 ≤ dist (γ s) (γ 0 - I * e (ψ 0)) := by
  sorry

/-- **The normal of a two-sided unit-disc condition is 1-Lipschitz**, sharp, by the parallelogram law: if the unit
disc about `x + νx` does not overlap the one about `y − νy`, nor the one about `x − νx` the one about `y + νy`, then
`‖νx − νy‖ ≤ ‖x − y‖`. (It replaces "curvature at most 1 where `g″` exists, and `ψ` absolutely continuous" in
FS131-E8 § 3.1 (4): no second derivative is taken.) -/
theorem norm_sub_le_of_discs {x y νx νy : ℂ} (hx : ‖νx‖ = 1) (hy : ‖νy‖ = 1)
    (h1 : 2 ≤ ‖(x + νx) - (y - νy)‖) (h2 : 2 ≤ ‖(x - νx) - (y + νy)‖) : ‖νx - νy‖ ≤ ‖x - y‖ := by
  have p1 := parallelogram_law_with_norm ℝ (x - y) (νx + νy)
  have p2 := parallelogram_law_with_norm ℝ νx νy
  have e1 : (x + νx) - (y - νy) = (x - y) + (νx + νy) := by ring
  have e2 : (x - νx) - (y + νy) = (x - y) - (νx + νy) := by ring
  rw [e1] at h1
  rw [e2] at h2
  rw [hx, hy] at p2
  have n1 := norm_nonneg (x - y + (νx + νy))
  have n2 := norm_nonneg (x - y - (νx + νy))
  have n3 := norm_nonneg (νx - νy)
  have n4 := norm_nonneg (x - y)
  by_contra hlt
  rw [not_le] at hlt
  nlinarith

/-- A continuous angle whose unit vectors are 1-Lipschitz in the chord is 1-Lipschitz (subdivide: `2 arcsin (d/2n)`
summed over `n` pieces tends to `d`). -/
theorem lipschitzOnWith_of_chord {ψ : ℝ → ℝ} {I : Set ℝ} (hI : I.OrdConnected) (hc : ContinuousOn ψ I)
    (h : ∀ s ∈ I, ∀ u ∈ I, ‖e (ψ s) - e (ψ u)‖ ≤ |s - u|) : LipschitzOnWith 1 ψ I := by
  sorry

end HadwigerNelson.Plane
