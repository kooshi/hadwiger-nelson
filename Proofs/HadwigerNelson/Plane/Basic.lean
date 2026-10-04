import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.SpecialFunctions.Complex.Circle
import Mathlib.MeasureTheory.Measure.Lebesgue.Complex

/-!
# The plane of the regularity wall: directions, unit circles, ring points, arc-length

The foundation every FS-131 module states its rows over (`plans/FS131-kernel-plan.md` § 5). The plane
is `ℂ`, as everywhere in this library (`Reduction.chromaticNumber_plane_eq_complex`): the metric, the
Lebesgue measure `volume` (through `Complex.measureSpace`) and the rotations are `ℂ`'s own.

* `e θ` is the unit vector at angle `θ` (radians), `exp (θ i)`. Angles are real numbers, not
  `Real.Angle`: the rows reason with intervals of angles (cones `[θ₁, θ₂]`, "the arc just clockwise
  of `r(ψ)`"), which `ℝ` orders and `Real.Angle` does not; periodicity is the lemma `e_add_two_pi`.
* `ringPt p θ = p + e θ` is the point `r(θ)` of the ring `ω(p)` (the unit circle about `p`, which is
  `Metric.sphere p 1`); "60° apart" is `θ + π / 3`.
* `arcLength` is arc-length on the unit circle, parametrized by the angle on `[0, 2π)`. Every
  "`Leb ⊗ σ`-null" statement of the rows is a statement about `volume.prod arcLength`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set MeasureTheory

/-- The unit vector at angle `θ`: `e θ = exp (θ i) = cos θ + i sin θ`. -/
noncomputable def e (θ : ℝ) : ℂ := Complex.exp (θ * I)

/-- `e θ` has norm `1`. -/
@[simp] theorem norm_e (θ : ℝ) : ‖e θ‖ = 1 := Complex.norm_exp_ofReal_mul_I θ

/-- `e` in coordinates. -/
theorem e_eq (θ : ℝ) : e θ = (Real.cos θ : ℂ) + (Real.sin θ : ℂ) * I := by
  rw [e, Complex.exp_mul_I, ← Complex.ofReal_cos, ← Complex.ofReal_sin]

/-- `e` turns sums into products: rotation by `α` is multiplication by `e α`. -/
theorem e_add (α β : ℝ) : e (α + β) = e α * e β := by
  rw [e, e, e, ← Complex.exp_add]; congr 1; push_cast; ring

/-- `e` has period `2π`. -/
theorem e_add_two_pi (θ : ℝ) : e (θ + 2 * π) = e θ := by
  have h : e (2 * π) = 1 := by
    rw [e, show ((2 * π : ℝ) : ℂ) * I = 2 * π * I by push_cast; ring, Complex.exp_two_pi_mul_I]
  rw [e_add, h, mul_one]

/-- The point `r(θ)` of the ring `ω(p)`. -/
noncomputable def ringPt (p : ℂ) (θ : ℝ) : ℂ := p + e θ

/-- Ring points lie on the unit circle about their centre. -/
@[simp] theorem dist_ringPt (p : ℂ) (θ : ℝ) : dist (ringPt p θ) p = 1 := by
  simp [ringPt, dist_eq_norm]

/-- Ring points lie on `ω(p) = Metric.sphere p 1`. -/
theorem ringPt_mem_sphere (p : ℂ) (θ : ℝ) : ringPt p θ ∈ Metric.sphere p 1 := dist_ringPt p θ

/-- Arc-length on the unit circle, in the angle parametrization: Lebesgue measure on `[0, 2π)`. -/
noncomputable def arcLength : Measure ℝ := volume.restrict (Ico 0 (2 * π))

/-- Arc-length is a finite measure (total mass `2π`), so products with it are well behaved. -/
instance : IsFiniteMeasure arcLength :=
  ⟨by simp [arcLength, Real.volume_Ico, ENNReal.mul_lt_top]⟩

/-! ## Spec examples (each fails if its definition drifts) -/

/-- `e 0 = 1`. -/
example : e 0 = 1 := by simp [e]

/-- Two ring points `60°` apart are at distance exactly `1` — the fact the whole ring calculus runs on
(FS116-V4-CHORD is its general form). -/
example (p : ℂ) : dist (ringPt p (π / 3)) (ringPt p 0) = 1 := by
  have h1 : e (π / 3) = (1 / 2 : ℂ) + ((√3 / 2 : ℝ) : ℂ) * I := by
    rw [e_eq, Real.cos_pi_div_three, Real.sin_pi_div_three]; push_cast; ring
  have h0 : e 0 = 1 := by simp [e]
  rw [ringPt, ringPt, dist_eq_norm, add_sub_add_left_eq_sub, h1, h0]
  have : (1 / 2 : ℂ) + ((√3 / 2 : ℝ) : ℂ) * I - 1 = ⟨-1 / 2, √3 / 2⟩ := by
    apply Complex.ext <;> norm_num
  rw [this, Complex.norm_eq_sqrt_sq_add_sq]
  have h3 : (√3 / 2) ^ 2 = 3 / 4 := by rw [div_pow, Real.sq_sqrt (by norm_num)]; norm_num
  rw [h3]; norm_num

/-- Arc-length gives the whole circle `2π`. -/
example : arcLength univ = ENNReal.ofReal (2 * π) := by
  simp [arcLength, Real.volume_Ico]

end HadwigerNelson.Plane
