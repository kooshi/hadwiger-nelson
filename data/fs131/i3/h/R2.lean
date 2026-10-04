import Mathlib

open Real

/-- A point of the closed lens about `0°` outside the open unit disc is within `1` of `√3`. -/
theorem qf_aux (X Y s : ℝ) (hs : s ^ 2 = 3) (hs0 : 0 < s)
    (hz1 : 1 ≤ X ^ 2 + Y ^ 2) (hzc : X ^ 2 + Y ^ 2 ≤ s * X - Y) (hzd : X ^ 2 + Y ^ 2 ≤ s * X + Y) :
    (X - s) ^ 2 + Y ^ 2 ≤ 1 := by
  have hY : Y ^ 2 ≤ 1 / 4 := by
    have e1 : (X - s / 2) ^ 2 + (Y + 1 / 2) ^ 2 = X ^ 2 + Y ^ 2 - s * X + Y + 1 := by linear_combination (1 / 4) * hs
    have e2 : (X - s / 2) ^ 2 + (Y - 1 / 2) ^ 2 = X ^ 2 + Y ^ 2 - s * X - Y + 1 := by linear_combination (1 / 4) * hs
    nlinarith only [e1, e2, hzc, hzd, sq_nonneg (X - s / 2)]
  have hX0 : 0 < X := by nlinarith only [hz1, hzc, hzd, hs0]
  have hR3 : X ^ 2 + Y ^ 2 ≤ 3 := by nlinarith only [hzc, hzd, hs, hs0, hX0, sq_nonneg Y, sq_nonneg (X - s)]
  have h12 : (X ^ 2 + Y ^ 2 + 2) ^ 2 ≤ (2 * s * X) ^ 2 := by
    have : (2 * s * X) ^ 2 = 12 * X ^ 2 := by linear_combination (4 * X ^ 2) * hs
    rw [this]; nlinarith only [hY, hz1, hR3]
  have h2 : X ^ 2 + Y ^ 2 + 2 ≤ 2 * s * X := by
    nlinarith only [h12, mul_pos hs0 hX0]
  have : (X - s) ^ 2 + Y ^ 2 = X ^ 2 + Y ^ 2 - 2 * s * X + 3 := by linear_combination hs
  rw [this]; linarith

/-- **QQ**: two points of the closed lens about `0°` outside the open unit disc (a Reuleaux triangle on `e(∓30°)`, `√3`)
are at most `1` apart. Cases on the position of the second point: the triangle on the three vertices (convexity of the
squared distance), or the circular segment beyond the chord through `e(30°)` and `√3` (centred `e(−30°)`), or the one
beyond the chord through `e(−30°)` and `√3` (centred `e(30°)`). -/
theorem qq_aux (X Y U V s : ℝ) (hs : s ^ 2 = 3) (hs0 : 0 < s)
    (hz1 : 1 ≤ X ^ 2 + Y ^ 2) (hzc : X ^ 2 + Y ^ 2 ≤ s * X - Y) (hzd : X ^ 2 + Y ^ 2 ≤ s * X + Y)
    (hw1 : 1 ≤ U ^ 2 + V ^ 2) (hwc : U ^ 2 + V ^ 2 ≤ s * U - V) (hwd : U ^ 2 + V ^ 2 ≤ s * U + V) :
    (X - U) ^ 2 + (Y - V) ^ 2 ≤ 1 := by
  have pzc : (X - s / 2) ^ 2 + (Y + 1 / 2) ^ 2 ≤ 1 := by
    have : (X - s / 2) ^ 2 + (Y + 1 / 2) ^ 2 = X ^ 2 + Y ^ 2 - s * X + Y + 1 := by linear_combination (1 / 4) * hs
    linarith
  have pzd : (X - s / 2) ^ 2 + (Y - 1 / 2) ^ 2 ≤ 1 := by
    have : (X - s / 2) ^ 2 + (Y - 1 / 2) ^ 2 = X ^ 2 + Y ^ 2 - s * X - Y + 1 := by linear_combination (1 / 4) * hs
    linarith
  have pzf := qf_aux X Y s hs hs0 hz1 hzc hzd
  have pwc : (U - s / 2) ^ 2 + (V + 1 / 2) ^ 2 ≤ 1 := by
    have : (U - s / 2) ^ 2 + (V + 1 / 2) ^ 2 = U ^ 2 + V ^ 2 - s * U + V + 1 := by linear_combination (1 / 4) * hs
    linarith
  have pwd : (U - s / 2) ^ 2 + (V - 1 / 2) ^ 2 ≤ 1 := by
    have : (U - s / 2) ^ 2 + (V - 1 / 2) ^ 2 = U ^ 2 + V ^ 2 - s * U - V + 1 := by linear_combination (1 / 4) * hs
    linarith
  have hV : V ^ 2 ≤ 1 / 4 := by nlinarith only [pwc, pwd, sq_nonneg (U - s / 2)]
  have hU0 : 0 < U := by nlinarith only [hw1, hwc, hwd, hs0]
  have hμ : 0 ≤ 2 * s * U / 3 - 1 := by
    have h34 : 3 / 4 ≤ U ^ 2 := by linarith
    have hU2 : s / 2 ≤ U := by nlinarith only [h34, hU0, hs, hs0]
    nlinarith only [hU2, hs, hs0]
  have hUs : U ≤ s := by nlinarith only [pwc, pwd, sq_nonneg (V + 1 / 2), hs, hs0]
  set μ := 2 * s * U / 3 - 1 with hμdef
  by_cases hl : 0 ≤ V + 1 - s * U / 3
  · set l₀ := V + 1 - s * U / 3 with hldef
    by_cases hT : l₀ + μ ≤ 1
    · -- the triangle
      have hα : 0 ≤ 1 - l₀ - μ := by linarith
      have key : (X - U) ^ 2 + (Y - V) ^ 2 = (1 - l₀ - μ) * ((X - s / 2) ^ 2 + (Y + 1 / 2) ^ 2) +
          l₀ * ((X - s / 2) ^ 2 + (Y - 1 / 2) ^ 2) + μ * ((X - s) ^ 2 + Y ^ 2) -
          ((1 - l₀ - μ) * l₀ + l₀ * μ + μ * (1 - l₀ - μ)) := by
        rw [hldef, hμdef]; linear_combination (-(2 * U ^ 2 - 4 * U * X + 3 * U * s - 3) / 6) * hs
      rw [key]
      nlinarith only [mul_le_mul_of_nonneg_left pzc hα, mul_le_mul_of_nonneg_left pzd hl,
        mul_le_mul_of_nonneg_left pzf hμ, mul_nonneg hα hl, mul_nonneg hl hμ, mul_nonneg hμ hα]
    · -- the segment beyond the chord `e(30°) √3`, centred `e(−30°)`
      push Not at hT
      have key : (X - U) ^ 2 + (Y - V) ^ 2 = (1 - l₀ - μ) * ((X - s / 2) ^ 2 + (Y + 1 / 2) ^ 2) -
          l₀ * (1 - ((X - s / 2) ^ 2 + (Y - 1 / 2) ^ 2)) - μ * (1 - ((X - s) ^ 2 + Y ^ 2)) +
          ((U - s / 2) ^ 2 + (V + 1 / 2) ^ 2) := by
        rw [hldef, hμdef]; linear_combination (-(-8 * U * X + 6 * U * s - 3) / 12) * hs
      rw [key]
      nlinarith only [mul_nonneg (by linarith : (0 : ℝ) ≤ l₀ + μ - 1)
          (by positivity : (0 : ℝ) ≤ (X - s / 2) ^ 2 + (Y + 1 / 2) ^ 2),
        mul_nonneg hl (by linarith : (0 : ℝ) ≤ 1 - ((X - s / 2) ^ 2 + (Y - 1 / 2) ^ 2)),
        mul_nonneg hμ (by linarith : (0 : ℝ) ≤ 1 - ((X - s) ^ 2 + Y ^ 2)), pwc]
  · -- the segment beyond the chord `e(−30°) √3`, centred `e(30°)`
    push Not at hl
    have hl' : 0 ≤ 1 - V - s * U / 3 := by nlinarith only [hl, mul_le_mul_of_nonneg_left hUs hs0.le, hs]
    have key : (X - U) ^ 2 + (Y - V) ^ 2 = (1 - (1 - V - s * U / 3) - μ) * ((X - s / 2) ^ 2 + (Y - 1 / 2) ^ 2) -
        (1 - V - s * U / 3) * (1 - ((X - s / 2) ^ 2 + (Y + 1 / 2) ^ 2)) - μ * (1 - ((X - s) ^ 2 + Y ^ 2)) +
        ((U - s / 2) ^ 2 + (V - 1 / 2) ^ 2) := by
      rw [hμdef]; linear_combination (-(-8 * U * X + 6 * U * s - 3) / 12) * hs
    rw [key]
    nlinarith only [mul_nonneg (by linarith : (0 : ℝ) ≤ (1 - V - s * U / 3) + μ - 1)
        (by positivity : (0 : ℝ) ≤ (X - s / 2) ^ 2 + (Y - 1 / 2) ^ 2),
      mul_nonneg hl' (by linarith : (0 : ℝ) ≤ 1 - ((X - s / 2) ^ 2 + (Y + 1 / 2) ^ 2)),
      mul_nonneg hμ (by linarith : (0 : ℝ) ≤ 1 - ((X - s) ^ 2 + Y ^ 2)), pwd]
