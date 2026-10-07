import Proofs.HadwigerNelson.Plane.ClosePair

namespace HadwigerNelson.Plane

/-- **The second inequality of the unit-square witness** (the pair of labels `1`, `1` and, turned by a quarter, the
pair `4`, `4`): a point `(a, b)` near `1`, outside the unit circles about `0` and about `1 − i`, and a point `(r, s)`
near `0`, outside the unit circle about `1` and not above the real axis, are more than `1` apart. On or above the axis
(`0 ≤ b`) the product of the ordinates has the right sign, and the abscissae are absorbed by one of the two circles; in
the sliver `b < 0`, being outside the circle about `1 − i` gives `−b < (a − 1)²` and `1 < a`. -/
theorem split_outer_gt {a b r s : ℝ} (ha : |a - 1| < 1 / 4) (hb : |b| < 1 / 4) (hab : 1 < a ^ 2 + b ^ 2)
    (hout : 1 < (a - 1) ^ 2 + (b + 1) ^ 2) (hr : |r| < 1 / 4) (hs : s ≤ 0) (hs' : |s| < 1 / 4)
    (hrs : 1 < (r - 1) ^ 2 + s ^ 2) : 1 < (r - a) ^ 2 + (s - b) ^ 2 := by
  obtain ⟨ha1, ha2⟩ := abs_lt.mp ha
  obtain ⟨hb1, hb2⟩ := abs_lt.mp hb
  obtain ⟨hr1, hr2⟩ := abs_lt.mp hr
  obtain ⟨hs1, -⟩ := abs_lt.mp hs'
  rcases le_or_gt 0 b with hb0 | hb0
  · have hbs : 0 ≤ b * -s := mul_nonneg hb0 (neg_nonneg.mpr hs)
    rcases le_or_gt r 0 with hr0 | hr0
    · have h1 : 0 ≤ a * -r := mul_nonneg (by linarith) (neg_nonneg.mpr hr0)
      linarith only [h1, hbs, hab, sq_nonneg r, sq_nonneg s]
    · rcases le_or_gt a 1 with hu | hu
      · have h1 : 0 ≤ r * (1 - a) := mul_nonneg hr0.le (sub_nonneg.mpr hu)
        linarith only [h1, hbs, hab, hrs]
      · have h1 : 0 < (a - 1) * (a + 1 - 2 * r) := mul_pos (sub_pos.mpr hu) (by linarith)
        linarith only [h1, hbs, hrs, sq_nonneg b]
  · -- the sliver below the axis
    have h5 : 0 < -b * (1 + b) := mul_pos (neg_pos.mpr hb0) (by linarith)
    have h4 : -b < (a - 1) ^ 2 := by linarith only [hout, h5]
    have h3 : 0 ≤ -b * (1 / 4 + b) := mul_nonneg (neg_nonneg.mpr hb0.le) (by linarith)
    have hu : 1 < a := by
      by_contra hcon
      have h6 : 0 ≤ (1 - a) * (5 / 4 * a + 3 / 4) := mul_nonneg (sub_nonneg.mpr (not_lt.mp hcon)) (by linarith)
      linarith only [hab, h3, h4, h6]
    have h2 : 0 ≤ -b * (1 / 4 + s) := mul_nonneg (neg_nonneg.mpr hb0.le) (by linarith)
    have h7 : 0 < (a - 1) * (a / 2 + 3 / 2 - 2 * r) := mul_pos (sub_pos.mpr hu) (by linarith)
    linarith only [h7, hrs, h2, h4, sq_nonneg b]

end HadwigerNelson.Plane
