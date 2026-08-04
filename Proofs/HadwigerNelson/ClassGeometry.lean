import Proofs.HadwigerNelson.Fan
import Proofs.HadwigerNelson.Greedy
import Mathlib.Analysis.Complex.Basic

/-!
# The geometry of a distance class — the 120° structure (M18)

A *distance class* at a pivot is the set of points at one fixed distance from it. M17's hunt
measured that the class at squared distance `1/3` resists separation everywhere; this module is
the plane-level mathematics behind that histogram, stated over `ℂ` — the workspace's working
plane (M04: rotation is multiplication and a point is a pair; one isometry crosses to
`EuclideanSpace ℝ (Fin 2)` at the headline, `Reduction.lean`).

Four findings, each elementary, none found stated elsewhere (2026-08-03):

* **The chord bound.** Two distinct circles share at most two points, so the unit-distance
  graph *inside* a class has maximum degree 2 — disjoint paths and cycles, never more.
* **No class confines alone.** Degree ≤ 2 means three colours suffice for a class by itself
  (`Greedy.lean`), and a fourth colour separates the pivot: any confinement of a five-colour
  fan to one class is an interplay theorem between the class and the ambient graph, never a
  property of the class's own edges. This closes deletion-style hunts *within* a class the way
  `FanMono.lean` closed them across subgraphs.
* **The triangle identity.** A unit equilateral triangle lies on a circle about `p` exactly
  when that circle has squared radius `1/3` — and then `p` is the triangle's centroid. So
  `r² = 1/3` is the *unique* class whose internal edges can form triangles; empirically
  (classstat census, de Grey's graph and the ℤ/3 closure, 2026-08-03) it is the unique class
  with odd cycles at all, and the census's violation reporter watches that stay true. (At
  plane level, odd cycles of length ≥ 5 exist at other radii — unit pentagons at
  `r² = (5±√5)/10` — but their rotations need square roots the coordinate field
  `ℚ(√3,√5,√7,√11)` cannot express; see the plan's pentagon correction.)
* **The 120° closure.** Rotation by `ω = e^{2πi/3}` about `p` displaces every point by `√3`
  times its radius, so it moves the `1/3`-class by exactly one unit, and its orbits there are
  unit equilateral triangles — the ℤ/3 closure M17 verified computationally, as exact algebra.

## Which one to reach for

| you have | you want | use |
|---|---|---|
| three points on two distinct circles | two of them equal | `eq_or_eq_or_eq_of_dist_eq` |
| a unit triangle | its circumradius² | `dist_sq_centroid_unit_triangle` |
| a point equidistant from a unit triangle | it is the centroid | `eq_centroid_of_dist_eq` |
| a class radius | whether it can hold a unit triangle | `exists_unit_triangle_iff` |
| a `1/3`-class point | its rainbow triangle | `rot3_unit_triangle` |
| a class-only graph | no fan at the pivot | `not_fan_classOnlyGraph` |
| edges inside `Q`, a `c`-colouring, `c < k` | no fan | `not_fan_of_colorable_of_edges_within` |

Everything here is real/complex algebra with `linear_combination` certificates; no axioms
beyond the standard three, no `Decidable` instances on ℝ, no kernel-scale data.
-/

namespace HadwigerNelson

open Complex

/-! ## The engine: plane dot and cross products, privately

Every geometric fact below reduces to polynomial identities in real components. `dot` and
`cross` name the two bilinear forms those identities factor through; the four private lemmas
are the whole linear algebra of the plane this module needs. -/

/-- Real dot product of two complex numbers read as plane vectors. -/
private def dot (u v : ℂ) : ℝ := u.re * v.re + u.im * v.im

/-- Signed cross product (twice the signed triangle area). -/
private def cross (u v : ℂ) : ℝ := u.re * v.im - u.im * v.re

private theorem dist_sq_eq_normSq (a b : ℂ) : dist a b ^ 2 = normSq (a - b) := by
  rw [Complex.dist_eq, Complex.sq_norm]

private theorem normSq_eq_of_dist_eq {a b p : ℂ} (h : dist a p = dist b p) :
    normSq (a - p) = normSq (b - p) := by
  rw [← dist_sq_eq_normSq, ← dist_sq_eq_normSq, h]

/-- Equal distance to `p` is bisector orthogonality — the polarization identity. -/
private theorem dot_eq_zero_of_normSq_eq {a b p : ℂ}
    (h : normSq (a - p) = normSq (b - p)) : dot (a - b) (a + b - p - p) = 0 := by
  simp only [dot, normSq_apply, sub_re, sub_im, add_re, add_im] at h ⊢
  linear_combination h

/-- Two vectors orthogonal to one nonzero vector are parallel. -/
private theorem cross_eq_zero_of_dot_eq_zero {u v w : ℂ} (hu : dot u w = 0)
    (hv : dot v w = 0) (hw : w ≠ 0) : cross u v = 0 := by
  have hw' : w.re ≠ 0 ∨ w.im ≠ 0 := by
    by_contra hcon
    push Not at hcon
    exact hw (Complex.ext hcon.1 hcon.2)
  rcases hw' with h | h
  · have hcert : cross u v * w.re = v.im * dot u w - u.im * dot v w := by
      simp only [cross, dot]; ring
    have h0 : cross u v * w.re = 0 := by rw [hcert, hu, hv]; ring
    exact (mul_eq_zero.mp h0).resolve_right h
  · have hcert : cross u v * w.im = u.re * dot v w - v.re * dot u w := by
      simp only [cross, dot]; ring
    have h0 : cross u v * w.im = 0 := by rw [hcert, hu, hv]; ring
    exact (mul_eq_zero.mp h0).resolve_right h

/-- A vector orthogonal to two non-parallel vectors is zero — Cramer's rule. -/
private theorem eq_zero_of_dot_eq_zero {d e w : ℂ} (hd : dot d w = 0) (he : dot e w = 0)
    (hde : cross d e ≠ 0) : w = 0 := by
  have hre : w.re * cross d e = e.im * dot d w - d.im * dot e w := by
    simp only [cross, dot]; ring
  have him : w.im * cross d e = d.re * dot e w - e.re * dot d w := by
    simp only [cross, dot]; ring
  rw [hd, he] at hre him
  simp only [mul_zero, sub_zero, mul_eq_zero] at hre him
  exact Complex.ext (hre.resolve_right hde) (him.resolve_right hde)

/-- Parallel to a nonzero vector means a real multiple of it. -/
private theorem eq_real_smul_of_cross_eq_zero {d e : ℂ} (h : cross d e = 0) (hd : d ≠ 0) :
    ∃ μ : ℝ, e = (μ : ℂ) * d := by
  have h' := h
  simp only [cross] at h'
  have hnd : d.re * d.re + d.im * d.im ≠ 0 := by
    have := fun h0 => hd (normSq_eq_zero.mp h0)
    rwa [normSq_apply] at this
  refine ⟨(e.re * d.re + e.im * d.im) / (d.re * d.re + d.im * d.im), Complex.ext ?_ ?_⟩
  · simp only [mul_re, ofReal_re, ofReal_im, zero_mul, sub_zero]
    rw [div_mul_eq_mul_div, eq_div_iff hnd]
    linear_combination (-d.im : ℝ) * h'
  · simp only [mul_im, ofReal_re, ofReal_im, zero_mul, add_zero]
    rw [div_mul_eq_mul_div, eq_div_iff hnd]
    linear_combination (d.re : ℝ) * h'

/-! ## The chord bound -/

/-- **Two distinct circles meet in at most two points**: three points equidistant from `p` and
simultaneously equidistant from a different point `q` cannot be pairwise distinct. This is the
whole reason a distance class's internal unit-distance graph has maximum degree 2. -/
theorem eq_or_eq_or_eq_of_dist_eq {p q a b c : ℂ} (hpq : p ≠ q)
    (hab : dist a p = dist b p) (hbc : dist b p = dist c p)
    (hab' : dist a q = dist b q) (hbc' : dist b q = dist c q) :
    a = b ∨ b = c ∨ a = c := by
  by_cases h1 : a = b
  · exact Or.inl h1
  by_cases h2 : b = c
  · exact Or.inr (Or.inl h2)
  refine Or.inr (Or.inr ?_)
  have hd : a - b ≠ 0 := sub_ne_zero.mpr h1
  have he : b - c ≠ 0 := sub_ne_zero.mpr h2
  have hw : q - p ≠ 0 := sub_ne_zero.mpr (Ne.symm hpq)
  -- the bisector orthogonalities at both centres, and their differences: both chord
  -- directions are orthogonal to the line of centres
  have hdp := dot_eq_zero_of_normSq_eq (normSq_eq_of_dist_eq hab)
  have hdq := dot_eq_zero_of_normSq_eq (normSq_eq_of_dist_eq hab')
  have hep := dot_eq_zero_of_normSq_eq (normSq_eq_of_dist_eq hbc)
  have heq' := dot_eq_zero_of_normSq_eq (normSq_eq_of_dist_eq hbc')
  have hdw : dot (a - b) (q - p) = 0 := by
    have h1' := hdp; have h2' := hdq
    simp only [dot, sub_re, sub_im, add_re, add_im] at h1' h2' ⊢
    linear_combination (1 / 2 : ℝ) * h1' - (1 / 2 : ℝ) * h2'
  have hew : dot (b - c) (q - p) = 0 := by
    have h1' := hep; have h2' := heq'
    simp only [dot, sub_re, sub_im, add_re, add_im] at h1' h2' ⊢
    linear_combination (1 / 2 : ℝ) * h1' - (1 / 2 : ℝ) * h2'
  obtain ⟨μ, hμ⟩ := eq_real_smul_of_cross_eq_zero
    (cross_eq_zero_of_dot_eq_zero hdw hew hw) hd
  -- the radius constraint at `p` prices both chords: the parallel coefficient must be −1
  have hbre : b.re - c.re = μ * (a.re - b.re) := by
    have := congrArg Complex.re hμ
    simpa [sub_re, mul_re, ofReal_re, ofReal_im] using this
  have hbim : b.im - c.im = μ * (a.im - b.im) := by
    have := congrArg Complex.im hμ
    simpa [sub_im, mul_im, ofReal_re, ofReal_im] using this
  have hA : dot (a - b) (b - p) = -(normSq (a - b)) / 2 := by
    have h' := hdp
    simp only [dot, normSq_apply, sub_re, sub_im, add_re, add_im] at h' ⊢
    linear_combination (1 / 2 : ℝ) * h'
  have hB : dot (b - c) (b - p) = normSq (b - c) / 2 := by
    have h' := hep
    simp only [dot, normSq_apply, sub_re, sub_im, add_re, add_im] at h' ⊢
    linear_combination (1 / 2 : ℝ) * h'
  have hBA : dot (b - c) (b - p) = μ * dot (a - b) (b - p) := by
    simp only [dot, sub_re, sub_im]
    linear_combination (b.re - p.re) * hbre + (b.im - p.im) * hbim
  have hE : normSq (b - c) = μ ^ 2 * normSq (a - b) := by
    simp only [normSq_apply, sub_re, sub_im]
    linear_combination (b.re - c.re + μ * (a.re - b.re)) * hbre +
      (b.im - c.im + μ * (a.im - b.im)) * hbim
  have hnd : normSq (a - b) ≠ 0 := fun h0 => hd (normSq_eq_zero.mp h0)
  -- the pricing: μ² X = |e|² = 2·dot e (b−p) = 2μ·dot d (b−p) = −μ X, so μ(μ+1)X = 0
  have hμval : μ * (μ + 1) * normSq (a - b) = 0 := by
    linear_combination (-1 : ℝ) * hE - 2 * hB + 2 * hBA + 2 * μ * hA
  rcases mul_eq_zero.mp hμval with hmul | h0
  · rcases mul_eq_zero.mp hmul with h0 | h0
    · exact absurd (by simpa [h0] using hμ) he
    · have hμ1 : μ = -1 := by linarith
      have hac : a - c = 0 := by
        have h' : a - c = (a - b) + (b - c) := by ring
        rw [h', hμ, hμ1]
        push_cast
        ring
      exact sub_eq_zero.mp hac
  · exact absurd h0 hnd

/-! ## The 120° rotation and its closure -/

/-- The primitive cube root of unity `e^{2πi/3}`, written in coordinates so every identity
about it is a `linear_combination` certificate away. -/
noncomputable def omega3 : ℂ := ⟨-(1 / 2), Real.sqrt 3 / 2⟩

/-- Rotation by 120° about `p` — the map whose orbits close the `1/3`-class into unit
triangles. This is exactly the spindle rotation `tools/field.py` computes at `r² = 1/3`
(`A = -1, B = √3, D = 2`, i.e. `cos = -1/2, sin = √3/2`), so the Lean statement and the
instrument move points by the same rotation. -/
noncomputable def rot3 (p z : ℂ) : ℂ := p + omega3 * (z - p)

example : omega3.re = -(1 / 2) := rfl
example : omega3.im = Real.sqrt 3 / 2 := rfl

private theorem sq_sqrt_three : Real.sqrt 3 * Real.sqrt 3 = 3 :=
  Real.mul_self_sqrt (by norm_num)

theorem omega3_cube : omega3 ^ 3 = 1 := by
  apply Complex.ext
  · simp only [pow_succ, pow_zero, one_mul, omega3, mul_re, mul_im, Complex.one_re]
    linear_combination (3 / 8 : ℝ) * sq_sqrt_three
  · simp only [pow_succ, pow_zero, one_mul, omega3, mul_re, mul_im, Complex.one_im]
    linear_combination (-(Real.sqrt 3) / 8) * sq_sqrt_three

theorem omega3_ne_one : omega3 ≠ 1 := by
  intro h
  have him := congrArg Complex.im h
  simp only [omega3, Complex.one_im] at him
  have : Real.sqrt 3 = 0 := by linarith
  have h3 : (0 : ℝ) < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)
  linarith

theorem normSq_omega3 : normSq omega3 = 1 := by
  simp only [normSq_apply, omega3]
  nlinarith [sq_sqrt_three]

/-- `|ω − 1|² = 3` — the factor that turns squared radius `1/3` into displacement exactly 1. -/
theorem normSq_omega3_sub_one : normSq (omega3 - 1) = 3 := by
  simp only [normSq_apply, omega3, sub_re, sub_im, Complex.one_re, Complex.one_im]
  nlinarith [sq_sqrt_three]

private theorem norm_omega3 : ‖omega3‖ = 1 := by
  rw [Complex.norm_def, normSq_omega3, Real.sqrt_one]

private theorem norm_omega3_sub_one : ‖omega3 - 1‖ = Real.sqrt 3 := by
  rw [Complex.norm_def, normSq_omega3_sub_one]

/-- Three rotations return every point: the closure is a ℤ/3 orbit. -/
theorem rot3_rot3_rot3 (p z : ℂ) : rot3 p (rot3 p (rot3 p z)) = z := by
  simp only [rot3]
  linear_combination (z - p) * omega3_cube

/-- `rot3 p` is an isometry. -/
theorem dist_rot3 (p z w : ℂ) : dist (rot3 p z) (rot3 p w) = dist z w := by
  have h : rot3 p z - rot3 p w = omega3 * (z - w) := by simp only [rot3]; ring
  rw [Complex.dist_eq, h, norm_mul, norm_omega3, one_mul, ← Complex.dist_eq]

/-- `rot3 p` fixes distances to the pivot: it maps every distance class at `p` to itself. -/
theorem dist_rot3_pivot (p z : ℂ) : dist (rot3 p z) p = dist z p := by
  have h : rot3 p z - p = omega3 * (z - p) := by simp only [rot3]; ring
  rw [Complex.dist_eq, h, norm_mul, norm_omega3, one_mul, ← Complex.dist_eq]

/-- **The 120° identity, unconditionally**: rotation by 120° about `p` displaces every point
of the plane by exactly `√3` times its distance from `p` — `|ω − 1| = √3`. The class at
squared radius `1/3` is the fixed point of this scaling against the unit: `√3 · √(1/3) = 1`. -/
theorem dist_rot3_self (p z : ℂ) : dist (rot3 p z) z = Real.sqrt 3 * dist z p := by
  have h : rot3 p z - z = (omega3 - 1) * (z - p) := by simp only [rot3]; ring
  rw [Complex.dist_eq, h, norm_mul, norm_omega3_sub_one, ← Complex.dist_eq]

/-- The `1/3` instance of `dist_rot3_self`: on the 120° class, the rotation moves every
point exactly one unit — the spindle identity the ℤ/3 closure is built from. -/
theorem dist_rot3_self_eq_one {p z : ℂ} (h : dist z p ^ 2 = 1 / 3) :
    dist (rot3 p z) z = 1 := by
  have hz : dist z p = Real.sqrt (1 / 3) := by
    rw [← h]
    exact (Real.sqrt_sq dist_nonneg).symm
  rw [dist_rot3_self, hz, ← Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 3)]
  norm_num

/-- **The closure is rainbow fuel**: the ℤ/3 orbit of any `1/3`-class point is a unit
equilateral triangle, so any proper colouring paints it with three distinct colours. -/
theorem rot3_unit_triangle {p z : ℂ} (h : dist z p ^ 2 = 1 / 3) :
    dist z (rot3 p z) = 1 ∧ dist (rot3 p z) (rot3 p (rot3 p z)) = 1 ∧
      dist (rot3 p (rot3 p z)) z = 1 := by
  refine ⟨by rw [dist_comm]; exact dist_rot3_self_eq_one h, ?_, ?_⟩
  · rw [dist_rot3, dist_comm]
    exact dist_rot3_self_eq_one h
  · set w := rot3 p (rot3 p z) with hw
    have hzw : z = rot3 p w := (rot3_rot3_rot3 p z).symm
    have hwp : dist w p ^ 2 = 1 / 3 := by
      rw [hw, dist_rot3_pivot, dist_rot3_pivot]
      exact h
    rw [hzw, dist_comm]
    exact dist_rot3_self_eq_one hwp

/-! ## The triangle identity: unit triangles live at squared radius 1/3 only -/

/-- The centroid of a unit equilateral triangle is at squared distance `1/3` from each
vertex — the circumradius of the unit triangle, squared. -/
theorem dist_sq_centroid_unit_triangle {a b c : ℂ}
    (hab : dist a b = 1) (hbc : dist b c = 1) (hac : dist a c = 1) :
    dist ((a + b + c) / 3) a ^ 2 = 1 / 3 := by
  have hab' : normSq (a - b) = 1 := by rw [← dist_sq_eq_normSq, hab]; norm_num
  have hbc' : normSq (b - c) = 1 := by rw [← dist_sq_eq_normSq, hbc]; norm_num
  have hac' : normSq (a - c) = 1 := by rw [← dist_sq_eq_normSq, hac]; norm_num
  rw [dist_sq_eq_normSq, show (a + b + c) / 3 - a = (b + c - a - a) / 3 from by ring,
    Complex.normSq_div, show normSq 3 = 9 from by norm_num [Complex.normSq_apply],
    show normSq (b + c - a - a) = 3 from by
      simp only [normSq_apply, sub_re, sub_im, add_re, add_im] at hab' hbc' hac' ⊢
      linear_combination 2 * hab' + 2 * hac' - hbc']
  norm_num

/-- A point equidistant from the three vertices of a unit equilateral triangle is its
centroid — the perpendicular bisectors of a nondegenerate triangle meet once. -/
theorem eq_centroid_of_dist_eq {a b c p : ℂ}
    (hab : dist a b = 1) (hbc : dist b c = 1) (hac : dist a c = 1)
    (hpa : dist p a = dist p b) (hpb : dist p b = dist p c) :
    p = (a + b + c) / 3 := by
  have hab' : normSq (a - b) = 1 := by rw [← dist_sq_eq_normSq, hab]; norm_num
  have hbc' : normSq (b - c) = 1 := by rw [← dist_sq_eq_normSq, hbc]; norm_num
  have hac' : normSq (a - c) = 1 := by rw [← dist_sq_eq_normSq, hac]; norm_num
  -- `p` sits on both perpendicular bisectors; so does the centroid; Cramer closes the gap
  have hpab : dot (a - b) (a + b - p - p) = 0 :=
    dot_eq_zero_of_normSq_eq (normSq_eq_of_dist_eq
      (by rw [dist_comm a p, dist_comm b p]; exact hpa))
  have hpbc : dot (b - c) (b + c - p - p) = 0 :=
    dot_eq_zero_of_normSq_eq (normSq_eq_of_dist_eq
      (by rw [dist_comm b p, dist_comm c p]; exact hpb))
  -- the chord directions are not parallel: Lagrange gives cross² = 3/4
  have hlagrange : cross (a - b) (b - c) ^ 2 + dot (a - b) (b - c) ^ 2 =
      normSq (a - b) * normSq (b - c) := by
    simp only [cross, dot, normSq_apply, sub_re, sub_im]; ring
  have hdot : dot (a - b) (b - c) = -(1 / 2) := by
    have h1 := hab'; have h2 := hbc'; have h3 := hac'
    simp only [dot, normSq_apply, sub_re, sub_im] at h1 h2 h3 ⊢
    linear_combination (1 / 2 : ℝ) * h3 - (1 / 2 : ℝ) * h1 - (1 / 2 : ℝ) * h2
  have hcross : cross (a - b) (b - c) ≠ 0 := by
    intro h0
    rw [h0, hdot, hab', hbc'] at hlagrange
    norm_num at hlagrange
  -- three times `p − centroid` is orthogonal to both chord directions — the `3p` form keeps
  -- every certificate division-free
  have hda : dot (a - b) (p + p + p - (a + b + c)) = 0 := by
    have h0 := hpab; have h1 := hab'; have h2 := hbc'; have h3 := hac'
    simp only [dot, normSq_apply, sub_re, sub_im, add_re, add_im] at h0 h1 h2 h3 ⊢
    linear_combination (-(3 : ℝ) / 2) * h0 + (1 / 2 : ℝ) * h3 - (1 / 2 : ℝ) * h2
  have hdb : dot (b - c) (p + p + p - (a + b + c)) = 0 := by
    have h0 := hpbc; have h1 := hab'; have h2 := hbc'; have h3 := hac'
    simp only [dot, normSq_apply, sub_re, sub_im, add_re, add_im] at h0 h1 h2 h3 ⊢
    linear_combination (-(3 : ℝ) / 2) * h0 + (1 / 2 : ℝ) * h1 - (1 / 2 : ℝ) * h3
  have h30 := eq_zero_of_dot_eq_zero hda hdb hcross
  rw [eq_div_iff (by norm_num : (3 : ℂ) ≠ 0)]
  linear_combination h30

/-- **The triangle identity.** A distance class carries a unit equilateral triangle exactly
when its squared radius is `1/3`. Forward: the equidistant point is the centroid, and the
centroid sits at squared distance `1/3`. Backward: the 120° orbit builds the triangle. -/
theorem exists_unit_triangle_iff {p : ℂ} {s : ℝ} :
    (∃ a b c : ℂ, dist a b = 1 ∧ dist b c = 1 ∧ dist a c = 1 ∧
      dist a p ^ 2 = s ∧ dist b p ^ 2 = s ∧ dist c p ^ 2 = s) ↔ s = 1 / 3 := by
  constructor
  · rintro ⟨a, b, c, hab, hbc, hac, hsa, hsb, hsc⟩
    have hd : ∀ {x y : ℂ}, dist x p ^ 2 = s → dist y p ^ 2 = s → dist p x = dist p y := by
      intro x y hx hy
      rw [dist_comm p x, dist_comm p y]
      have : dist x p ^ 2 = dist y p ^ 2 := hx.trans hy.symm
      calc dist x p = Real.sqrt (dist x p ^ 2) := (Real.sqrt_sq dist_nonneg).symm
        _ = Real.sqrt (dist y p ^ 2) := by rw [this]
        _ = dist y p := Real.sqrt_sq dist_nonneg
    have hcent := eq_centroid_of_dist_eq hab hbc hac (hd hsa hsb) (hd hsb hsc)
    rw [← hsa, hcent, dist_comm]
    exact dist_sq_centroid_unit_triangle hab hbc hac
  · rintro rfl
    -- the witness triangle is the ℤ/3 orbit of a point at radius √(1/3)
    have hz : dist (p + ((Real.sqrt (1 / 3) : ℝ) : ℂ)) p ^ 2 = 1 / 3 := by
      rw [Complex.dist_eq, add_sub_cancel_left, Complex.norm_real,
        Real.norm_of_nonneg (Real.sqrt_nonneg _), Real.sq_sqrt (by norm_num)]
    obtain ⟨h1, h2, h3⟩ := rot3_unit_triangle hz
    set z := p + ((Real.sqrt (1 / 3) : ℝ) : ℂ)
    refine ⟨z, rot3 p z, rot3 p (rot3 p z), h1, h2, by rw [dist_comm]; exact h3,
      hz, ?_, ?_⟩
    · rw [dist_rot3_pivot]; exact hz
    · rw [dist_rot3_pivot, dist_rot3_pivot]; exact hz

/-! ## No class confines alone -/

/-- The *class-only graph*: unit edges both of whose ends belong to the listed class `Q`.
Everything the class contributes to a fan on its own, and nothing the ambient graph adds. It
is the *maximal* graph of class-internal edges, so `Fan.mono` hands its `¬ Fan` down to every
subgraph for free. -/
def classOnlyGraph {n : ℕ} (f : Fin n → ℂ) (Q : List (Fin n)) : SimpleGraph (Fin n) where
  Adj v w := v ≠ w ∧ dist (f v) (f w) = 1 ∧ v ∈ Q ∧ w ∈ Q
  symm := ⟨fun _ _ h => ⟨h.1.symm, by rw [dist_comm]; exact h.2.1, h.2.2.2, h.2.2.1⟩⟩
  loopless := ⟨fun _ h => h.1 rfl⟩

/-- The abstract half of "no class confines alone", in its true generality: a graph whose
edges all live inside `Q` and whose `Q`-part is `c`-colourable cannot fan a pivot `p ∉ Q`
once even one colour more is available — `c` colours for `Q`, the spare for everything else.
The milestone's "4 colours suffice against a class" is the instance `c = 3` handed by the
chord bound plus greedy colouring: 3 + 1, named. No finiteness, no decidability. -/
theorem not_fan_of_colorable_of_edges_within {V : Type*}
    {G : SimpleGraph V} {p : V} {Q : List V} {c k : ℕ}
    (hp : p ∉ Q) (hQ : ∀ ⦃x y⦄, G.Adj x y → x ∈ Q ∧ y ∈ Q)
    (hc : G.Colorable c) (hck : c < k) :
    ¬ Fan G k p Q := by
  intro hfan
  obtain ⟨C₀⟩ := hc
  classical
  let φ : V → Fin k := fun v => if v ∈ Q then Fin.castLE hck.le (C₀ v) else ⟨c, hck⟩
  have hvalid : ∀ {v w : V}, G.Adj v w → φ v ≠ φ w := by
    intro v w hadj
    obtain ⟨hv, hw⟩ := hQ hadj
    simp only [φ, if_pos hv, if_pos hw]
    exact fun heq => C₀.valid hadj (Fin.castLE_injective _ heq)
  obtain ⟨q, hq, hpq⟩ := hfan (SimpleGraph.Coloring.mk φ hvalid)
  change φ p = φ q at hpq
  simp only [φ, if_neg hp, if_pos hq] at hpq
  have hval := congrArg Fin.val hpq
  simp only [Fin.val_castLE] at hval
  exact absurd hval.symm (Nat.ne_of_lt (C₀ q).isLt)

private theorem dist_eq_of_sq_eq {x y p : ℂ} (h : dist x p ^ 2 = dist y p ^ 2) :
    dist x p = dist y p := by
  calc dist x p = Real.sqrt (dist x p ^ 2) := (Real.sqrt_sq dist_nonneg).symm
    _ = Real.sqrt (dist y p ^ 2) := by rw [h]
    _ = dist y p := Real.sqrt_sq dist_nonneg

/-- The geometric half: in a class-only graph over points on a genuine class (`s ≠ 0`, all of
`Q` at squared distance `s` from a centre `x`), every degree is at most 2 — the chord bound,
worn by a graph. Injectivity mirrors the instrument's duplicate-point guard: two vertices
naming one plane point would count one geometric neighbour twice. -/
theorem degree_classOnlyGraph_le_two {n : ℕ} {f : Fin n → ℂ} (hf : Function.Injective f)
    {x : ℂ} {s : ℝ} (hs : s ≠ 0) {Q : List (Fin n)}
    (hQ : ∀ q ∈ Q, dist (f q) x ^ 2 = s)
    [DecidableRel (classOnlyGraph f Q).Adj] (v : Fin n) :
    (classOnlyGraph f Q).degree v ≤ 2 := by
  by_contra hdeg
  push Not at hdeg
  obtain ⟨n₁, hm₁, n₂, hm₂, n₃, hm₃, h12, h13, h23⟩ := Finset.two_lt_card.mp hdeg
  rw [SimpleGraph.mem_neighborFinset] at hm₁ hm₂ hm₃
  obtain ⟨hv1, hd1, hvQ, h1Q⟩ := hm₁
  obtain ⟨hv2, hd2, -, h2Q⟩ := hm₂
  obtain ⟨hv3, hd3, -, h3Q⟩ := hm₃
  -- the centre and the vertex's point are distinct, since the class misses radius 0
  have hxv : x ≠ f v := by
    intro hx
    have := hQ v hvQ
    rw [← hx, dist_self] at this
    exact hs (by simpa using this.symm)
  -- three points on the class circle and on the unit circle about `f v`
  have h2eq : ∀ {a b : Fin n}, a ∈ Q → b ∈ Q → dist (f a) x = dist (f b) x :=
    fun ha hb => dist_eq_of_sq_eq ((hQ _ ha).trans (hQ _ hb).symm)
  rcases eq_or_eq_or_eq_of_dist_eq hxv (h2eq h1Q h2Q) (h2eq h2Q h3Q)
    (by rw [dist_comm (f n₁), dist_comm (f n₂), hd1, hd2])
    (by rw [dist_comm (f n₂), dist_comm (f n₃), hd2, hd3]) with h | h | h
  · exact h12 (hf h)
  · exact h23 (hf h)
  · exact h13 (hf h)

/-- **No distance class can confine a fan by itself.** For any finite point set, any pivot,
any class radius (`s ≠ 0`), and any `k ≥ 4`: the class's own unit edges never force the
pivot's colour into the class. Confinement — if it is achievable at all — is a property of
the interplay between class and ambient graph. The hunt may therefore skip every candidate
move that only enriches a class internally. -/
theorem not_fan_classOnlyGraph {n : ℕ} {f : Fin n → ℂ} (hf : Function.Injective f)
    {p : Fin n} {s : ℝ} (hs : s ≠ 0) {Q : List (Fin n)}
    (hQ : ∀ q ∈ Q, dist (f q) (f p) ^ 2 = s) {k : ℕ} (hk : 4 ≤ k) :
    ¬ Fan (classOnlyGraph f Q) k p Q := by
  classical
  have hp : p ∉ Q := by
    intro hpQ
    have := hQ p hpQ
    rw [dist_self] at this
    exact hs (by simpa using this.symm)
  letI : DecidableRel (classOnlyGraph f Q).Adj := Classical.decRel _
  refine not_fan_of_colorable_of_edges_within (c := 3) hp
    (fun x y hadj => ⟨hadj.2.2.1, hadj.2.2.2⟩) ?_ (by omega)
  exact (classOnlyGraph f Q).colorable_of_degree_lt fun v =>
    Nat.lt_succ_of_le (degree_classOnlyGraph_le_two hf hs hQ v)

/-! ## Specification

Geometry over ℝ cannot `#eval`, so the census (`tools/classstat.py`: 2.6M class keys across
de Grey's graph and the ℤ/3 closure, three predictions, violations loud and nonzero-exit) is
this module's space-level control; the examples here pin the definitional surface and keep
the two adversarial members the hypotheses exclude. -/

/-- The triangle hypotheses have a model: the ℤ/3 orbit at radius `√(1/3)` about `0`. -/
example : ∃ a b c : ℂ, dist a b = 1 ∧ dist b c = 1 ∧ dist a c = 1 ∧
    dist a 0 ^ 2 = 1 / 3 ∧ dist b 0 ^ 2 = 1 / 3 ∧ dist c 0 ^ 2 = 1 / 3 :=
  exists_unit_triangle_iff.mpr rfl

/-- And the identity refuses every other radius: no unit triangle on the unit circle — the
hexagon class `r² = 1` carries 6-cycles and, provably, never a triangle (the census's
empirical reading of the same fact: 8,520 in-class edges there, zero triangles). -/
example : ¬ ∃ a b c : ℂ, dist a b = 1 ∧ dist b c = 1 ∧ dist a c = 1 ∧
    dist a 0 ^ 2 = 1 ∧ dist b 0 ^ 2 = 1 ∧ dist c 0 ^ 2 = 1 :=
  fun h => by simpa using exists_unit_triangle_iff.mp h

/-- The class-only graph's adjacency, pinned on a two-point instance. -/
example : (classOnlyGraph ![0, 1] [0, 1]).Adj 0 1 :=
  ⟨by decide, by simp [Complex.dist_eq], by decide, by decide⟩

/-- Membership is load-bearing: the same two points with `1` dropped from the class are not
adjacent. -/
example : ¬ (classOnlyGraph ![0, 1] [0]).Adj 0 1 := fun h => by simpa using h.2.2.2

/-- Why `hs : s ≠ 0` is load-bearing in `not_fan_classOnlyGraph`: at radius 0 the pivot joins
its own class and the fan is trivially true — the adversarial member the hypothesis
excludes, kept as a negative test. -/
example (f : Fin 1 → ℂ) : Fan (classOnlyGraph f [0]) 5 0 [0] :=
  fun _ => ⟨0, List.mem_singleton_self 0, rfl⟩

end HadwigerNelson
