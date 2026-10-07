import OAI.Geometry.PlaneColoring.Five
open OAI.EuclideanFiveColor
-- FS132-I1: what the copied definitions MEAN, in statements that name nothing of the release's or of this library's but
-- the six copied definitions. This text is elaborated twice, unchanged: at the release's pin over the release's
-- constants, and at this pin over the module's. Each `example` is a characterisation; a proof may try two lemma names.
open MeasureTheory
section
/-- (1) The norm in `ProperColoring` is the Euclidean modulus. -/
example (z : ℂ) : ‖z‖ = Real.sqrt (z.re ^ 2 + z.im ^ 2) := Complex.norm_eq_sqrt_sq_add_sq z
/-- (2) `ProperColoring`, with no norm and no complex number: real coordinates and a polynomial identity. -/
example {k : ℕ} {c : ℂ → Fin k} : ProperColoring k c ↔
    ∀ x y : ℂ, (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 = 1 → c x ≠ c y := by
  have h : ∀ x y : ℂ, ‖x - y‖ = 1 ↔ (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 = 1 := by
    intro x y
    rw [Complex.norm_eq_sqrt_sq_add_sq, Real.sqrt_eq_one, Complex.sub_re, Complex.sub_im]
  exact ⟨fun hp x y hxy => hp x y ((h x y).mpr hxy), fun hp x y hxy => hp x y ((h x y).mp hxy)⟩
/-- (3) `volume` on `ℂ` is Lebesgue measure of `ℝ × ℝ`, carried by `z ↦ (re z, im z)`. -/
example : MeasurePreserving Complex.measurableEquivRealProd (volume : Measure ℂ) (volume : Measure (ℝ × ℝ)) :=
  Complex.volume_preserving_equiv_real_prod
/-- (4) The circle of angles is `ℝ` modulo `2π`. -/
example : ((2 * Real.pi : ℝ) : Angles) = 0 := AddCircle.coe_period _
/-- (5) The angular measure is Lebesgue measure of one period, carried to the circle and divided by `2π`. -/
example : Measure.map (fun θ : ℝ => (θ : Angles)) (volume.restrict (Set.Ioc 0 (2 * Real.pi))) =
    ENNReal.ofReal (2 * Real.pi) • angularMeasure := by
  have h := (AddCircle.measurePreserving_mk (2 * Real.pi) 0).map_eq
  rw [zero_add] at h
  rw [angularMeasure, ← AddCircle.volume_eq_smul_haarAddCircle]
  exact h
/-- (6) The direction at the angle `θ` is `exp (θ i) = cos θ + i sin θ`. -/
example (θ : ℝ) : direction (θ : Angles) = Complex.exp (θ * Complex.I) := by
  have h : 2 * Real.pi / (2 * Real.pi) * θ = θ := by
    rw [div_self (by positivity), one_mul]
  rw [direction, AddCircle.toCircle_apply_mk, h, Circle.coe_exp]
/-- (7) A map into `Fin k` is measurable exactly when each colour class is a measurable set. -/
example {k : ℕ} (c : ℂ → Fin k) : Measurable c ↔ ∀ j, MeasurableSet (c ⁻¹' {j}) :=
  ⟨fun h j => h (measurableSet_singleton j), fun h => measurable_to_countable' h⟩
/-- (8) The weak condition's second clause says the set of pairs (a point, an angle) with one colour at both ends is
null for the product measure. -/
example {k : ℕ} (c : ℂ → Fin k) (hc : AEMeasurable c (volume : Measure ℂ)) : WeakColoring k c ↔
    ((volume : Measure ℂ).prod angularMeasure) {p | c p.1 = c (p.1 + direction p.2)} = 0 := by
  rw [WeakColoring, ae_iff]
  simp only [ne_eq, not_not]
  exact ⟨fun h => h.2, fun h => ⟨hc, h⟩⟩
/-- (9) The product measure of a rectangle is the product of the measures. -/
example (s : Set ℂ) (t : Set Angles) :
    ((volume : Measure ℂ).prod angularMeasure) (s ×ˢ t) = volume s * angularMeasure t :=
  Measure.prod_prod s t
end
