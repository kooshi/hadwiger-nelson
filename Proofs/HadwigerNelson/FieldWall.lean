import Proofs.HadwigerNelson.TwoCircle

/-!
# The field wall: the Moser twist is a word in the seam group

The observation that redirected the programme at the M26→M30 jump (2026-08-09): the rotation
that closes the Moser spindle — the twist `ρ` with `cos ρ = 5/6`, `sin ρ = √11/6`, which turns
two rhombi into a 4-forcer — satisfies `ρ · σ² = −1` for the seam `σ = (√3 + i√33)/6`, i.e.

    ρ = ζ₆³ · σ⁻²  —  **inside** ⟨ζ₆, σ⟩.

So the classical 4-forcers are native to the seam group whose countable closures M24–M26 proved
exactly 4-chromatic, while the known 5-forcers (de Grey 1581, Heule 553/510) need √5 and √7,
which the seam field does not contain: the 5-wall is a field wall. This module is the
kernel-checked citation for that thesis (script-verified first in `tools/anatomy.py
--self-test`, 16-vector exact arithmetic; M30's anatomy measured the full direction group of
the 1581 to be ⟨ζ₁₂, σ, √ρ₁₅, √ρ₆₃⟩ — tools-side, uncertified).
-/

namespace HadwigerNelson
namespace FieldWall

open Complex TwoCircle

/-- The Moser spindle's twist rotation: `cos = 5/6`, `sin = √11/6` — the spindle rotation over
the rhombus diagonal `√3` (radicand `4·3 − 1 = 11`), the move that places two rhombi so their
far corners land a unit apart. -/
noncomputable def moserTwist : ℂ := ⟨5 / 6, Real.sqrt 11 / 6⟩

private theorem sq_sqrt3 : Real.sqrt 3 * Real.sqrt 3 = 3 := Real.mul_self_sqrt (by norm_num)
private theorem sq_sqrt11 : Real.sqrt 11 * Real.sqrt 11 = 11 := Real.mul_self_sqrt (by norm_num)
private theorem sq_sqrt33 : Real.sqrt 33 * Real.sqrt 33 = 33 := Real.mul_self_sqrt (by norm_num)

/-- `√3·√33 = 3√11` — the product identity the seam square runs on. -/
private theorem sqrt3_mul_sqrt33 : Real.sqrt 3 * Real.sqrt 33 = 3 * Real.sqrt 11 := by
  rw [← Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 3),
      show (3 : ℝ) * 33 = 9 * 11 by norm_num,
      Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 9),
      show (9 : ℝ) = 3 ^ 2 by norm_num, Real.sqrt_sq (by norm_num : (0 : ℝ) ≤ 3)]

/-- The twist is a rotation: `|ρ|² = 1`. -/
theorem normSq_moserTwist : normSq moserTwist = 1 := by
  simp only [normSq_apply, moserTwist]
  nlinarith [sq_sqrt11]

/-- **The field-wall identity**: `ρ · σ² = −1`, so the Moser twist is `ζ₆³ · σ⁻²` — a word in
the seam group. The twist that forces the 4th colour never leaves ⟨ζ₆, σ⟩; the 5th needed a
bigger field. -/
theorem moserTwist_mul_seam_sq : moserTwist * seam ^ 2 = -1 := by
  apply Complex.ext
  · simp only [moserTwist, seam, pow_two, Complex.mul_re, Complex.mul_im, Complex.neg_re,
      Complex.one_re]
    linear_combination (5 / 216 : ℝ) * sq_sqrt3 - (5 / 216 : ℝ) * sq_sqrt33 -
      Real.sqrt 11 / 108 * sqrt3_mul_sqrt33 - (1 / 36 : ℝ) * sq_sqrt11
  · simp only [moserTwist, seam, pow_two, Complex.mul_re, Complex.mul_im, Complex.neg_im,
      Complex.one_im]
    linear_combination (5 / 108 : ℝ) * sqrt3_mul_sqrt33 + Real.sqrt 11 / 216 * sq_sqrt3 -
      Real.sqrt 11 / 216 * sq_sqrt33

private theorem zeta6_cube : zeta6 ^ 3 = -1 := by
  apply Complex.ext
  · simp only [zeta6, pow_succ, pow_zero, one_mul, Complex.mul_re, Complex.mul_im,
      Complex.neg_re, Complex.one_re]
    linear_combination -(3 / 8 : ℝ) * sq_sqrt3
  · simp only [zeta6, pow_succ, pow_zero, one_mul, Complex.mul_re, Complex.mul_im,
      Complex.neg_im, Complex.one_im]
    linear_combination -(Real.sqrt 3 / 8) * sq_sqrt3

/-- The thesis in quotient form: `ρ = ζ₆³ · σ⁻²`. -/
theorem moserTwist_eq_zeta6_cube_mul_seam_inv_sq : moserTwist = zeta6 ^ 3 * seam⁻¹ ^ 2 := by
  rw [zeta6_cube]
  field_simp [seam_ne_zero]
  linear_combination moserTwist_mul_seam_sq

end FieldWall
end HadwigerNelson
