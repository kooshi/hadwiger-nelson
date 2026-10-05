import Proofs.HadwigerNelson.Plane.ValidMap.Surgery

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- **The height of the tangent arc of curvature `κ` above the abscissa `X`** (the smaller root of `tanHeight κ X y = 0`):
`κ X² / (1 + √(1 − κ² X²))`. -/
noncomputable def hgt (κ X : ℝ) : ℝ := κ * X ^ 2 / (1 + Real.sqrt (1 - κ ^ 2 * X ^ 2))

/-- The point `(X, hgt κ X)` lies on the tangent arc of curvature `κ`. -/
theorem tanHeight_hgt {κ X : ℝ} (h : κ ^ 2 * X ^ 2 ≤ 1) : tanHeight κ X (hgt κ X) = 0 := by
  set S := Real.sqrt (1 - κ ^ 2 * X ^ 2) with hS
  have hS0 : 0 ≤ S := Real.sqrt_nonneg _
  have hS2 : S ^ 2 = 1 - κ ^ 2 * X ^ 2 := Real.sq_sqrt (by linarith)
  have hd : 0 < 1 + S := by linarith
  unfold hgt tanHeight
  rw [← hS]
  field_simp
  linear_combination (-(κ * X ^ 2)) * hS2

/-- The tangent arc's height is at most `|κ| X²`. -/
theorem abs_hgt_le (κ X : ℝ) : |hgt κ X| ≤ |κ| * X ^ 2 := by
  unfold hgt
  have hd : 1 ≤ 1 + Real.sqrt (1 - κ ^ 2 * X ^ 2) := by linarith [Real.sqrt_nonneg (1 - κ ^ 2 * X ^ 2)]
  rw [abs_div, abs_mul, abs_of_nonneg (sq_nonneg X), abs_of_pos (by linarith : (0 : ℝ) < 1 + Real.sqrt _)]
  exact div_le_self (by positivity) hd

/-- **Above or below the tangent arc, on the vertical line**: near the origin, the sign of `tanHeight κ X Y` is the sign of
`Y − hgt κ X`. -/
theorem sign_sub_hgt {κ X Y σ : ℝ} (h : κ ^ 2 * X ^ 2 ≤ 1) (hY : |κ| * (|Y| + |hgt κ X|) ≤ 1)
    (hσ : 0 ≤ σ * tanHeight κ X Y) : 0 ≤ σ * (Y - hgt κ X) := by
  have h0 := tanHeight_hgt h
  set g := hgt κ X
  have hfac : tanHeight κ X Y = (Y - g) * (1 - κ * (Y + g) / 2) := by
    have : tanHeight κ X Y = tanHeight κ X Y - tanHeight κ X g := by rw [h0, sub_zero]
    rw [this]; unfold tanHeight; ring
  have hpos : 1 / 2 ≤ 1 - κ * (Y + g) / 2 := by
    have : |κ * (Y + g)| ≤ 1 := by
      rw [abs_mul]
      calc |κ| * |Y + g| ≤ |κ| * (|Y| + |g|) := mul_le_mul_of_nonneg_left (abs_add_le _ _) (abs_nonneg _)
        _ ≤ 1 := hY
    linarith [(abs_le.mp this).2]
  rw [hfac] at hσ
  have : 0 ≤ (σ * (Y - g)) * (1 - κ * (Y + g) / 2) := by linarith
  exact nonneg_of_mul_nonneg_left this (by linarith)

end HadwigerNelson.Plane
