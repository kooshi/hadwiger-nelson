import Proofs.HadwigerNelson.Plane.ClosePair

namespace HadwigerNelson.Plane

/-- **The first inequality of the unit-square witness** (the pair of labels `0`, `0` and, turned by a quarter, the
pair `3`, `3`): a point `(a, b)` near `1`, inside the unit circle about `0` and outside the unit circle about `1 + i`,
and a point `(r, s)` near `0`, inside the unit circle about `1` and not above the real axis, are less than `1` apart.
Below the axis (`b ≤ 0`) the two ordinates have one sign and the larger one bounds their difference; in the sliver
`0 < b`, being outside the circle about `1 + i` gives `b < (1 − a)²`. -/
theorem split_inner_lt {a b r s : ℝ} (ha : 3 / 4 < a) (hb : |b| < 1 / 4) (hab : a ^ 2 + b ^ 2 < 1)
    (hout : 1 < (a - 1) ^ 2 + (b - 1) ^ 2) (hr : |r| < 1 / 4) (hs : s ≤ 0) (hs' : |s| < 1 / 4)
    (hrs : (r - 1) ^ 2 + s ^ 2 < 1) : (r - a) ^ 2 + (s - b) ^ 2 < 1 := by
  obtain ⟨hb1, hb2⟩ := abs_lt.mp hb
  obtain ⟨hr1, hr2⟩ := abs_lt.mp hr
  obtain ⟨hs1, -⟩ := abs_lt.mp hs'
  have hr0 : 0 < r := by nlinarith [sq_nonneg r, sq_nonneg s]
  have ha1 : a < 1 := by nlinarith [sq_nonneg b]
  have hs2 : s ^ 2 < 2 * r - r ^ 2 := by nlinarith
  rcases le_or_gt b 0 with hb0 | hb0
  · rcases le_total s b with hsb | hsb
    · -- `s ≤ b ≤ 0`: the difference of the ordinates is at most `|s|`
      nlinarith [mul_nonneg (neg_nonneg.mpr hb0) (show 0 ≤ b - 2 * s by linarith),
        mul_pos (sub_pos.mpr ha1) (show 0 < 1 + a - 2 * r by linarith)]
    · -- `b ≤ s ≤ 0`: the difference of the ordinates is at most `|b|`
      nlinarith [mul_nonneg (neg_nonneg.mpr hs) (show 0 ≤ s - 2 * b by linarith),
        mul_pos hr0 (show 0 < 2 * a - r by linarith)]
  · -- the sliver above the axis
    have h4 : b < (1 - a) ^ 2 := by nlinarith [mul_pos hb0 (sub_pos.mpr hb2)]
    have h2 : -(2 * s * b) ≤ b / 2 := by nlinarith [mul_nonneg hb0.le (show 0 ≤ 1 / 4 + s by linarith)]
    have h3 : b ^ 2 ≤ b / 4 := by nlinarith [mul_nonneg hb0.le (sub_nonneg.mpr hb2.le)]
    nlinarith [mul_pos (sub_pos.mpr ha1) (show 0 < 2 - 7 / 4 * (1 - a) - 2 * r by linarith)]

end HadwigerNelson.Plane
