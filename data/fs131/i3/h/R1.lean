import Mathlib

open Real

/-- GG: the gap tile (rotated to the positive axis) lies in the open disc of radius `1/2` about `7/5`. -/
theorem gg_aux (u v s : ℝ) (hs : s ^ 2 = 3) (h1 : 1 < u ^ 2 + v ^ 2) (h2 : u ^ 2 + v ^ 2 < 9 / 4)
    (ha : u + s * v < u ^ 2 + v ^ 2) (hb : u - s * v < u ^ 2 + v ^ 2) (hc : s * v < u) (hd : -(s * v) < u) :
    (u - 7 / 5) ^ 2 + v ^ 2 < 1 / 4 := by
  set R := u ^ 2 + v ^ 2 with hR
  have hu0 : 0 < u := by linarith
  have h3v : 3 * v ^ 2 < u ^ 2 := by nlinarith [mul_pos (sub_pos.mpr hc) (by linarith : (0:ℝ) < u + s * v)]
  have hq : 0 < 4 * u ^ 2 - 2 * R * u + R ^ 2 - 3 * R := by
    have := mul_pos (sub_pos.mpr ha) (sub_pos.mpr hb)
    nlinarith
  have huR : R / 4 < u := by nlinarith
  by_contra hcon
  push Not at hcon
  have hL : u ≤ (R + 171 / 100) / (14 / 5) := by nlinarith
  set L := (R + 171 / 100) / (14 / 5) with hLdef
  have hqL : 4 * L ^ 2 - 2 * R * L + R ^ 2 - 3 * R < 0 := by
    rw [hLdef]; nlinarith [mul_pos (sub_pos.mpr h1) (sub_pos.mpr h2)]
  have hLR : R / 4 < L := by rw [hLdef]; nlinarith
  nlinarith [mul_nonneg (sub_nonneg.mpr hL) (by linarith : (0:ℝ) ≤ 4 * u + 4 * L - 2 * R)]

/-- SS: two points of the open unit `60°` sector are less than `1` apart. -/
theorem ss_aux (r t C : ℝ) (hr0 : 0 < r) (hr1 : r < 1) (ht0 : 0 < t) (ht1 : t < 1) (hC : 1 / 2 < C) :
    r ^ 2 + t ^ 2 - 2 * r * t * C < 1 := by
  rcases le_total r t with h | h
  · nlinarith [mul_pos hr0 ht0, mul_nonneg hr0.le (sub_nonneg.mpr h)]
  · nlinarith [mul_pos hr0 ht0, mul_nonneg ht0.le (sub_nonneg.mpr h)]

/-- G's first coordinate: a gap point is left of `−√3/2`. -/
theorem g_re_aux (p q s : ℝ) (hs : s ^ 2 = 3) (hs0 : 0 < s) (h1 : 1 < p ^ 2 + q ^ 2) (h2 : p ^ 2 + q ^ 2 < 9 / 4)
    (ha : 2 * q < p ^ 2 + q ^ 2) (hc : 0 < q) (hd : s * p + q < 0) : p < -(s / 2) := by
  have hp : p < 0 := by nlinarith
  have hp2 : 3 / 4 < p ^ 2 := by
    rcases le_or_gt (1 / 2) q with hq | hq
    · nlinarith
    · nlinarith
  nlinarith

/-- QG: a lens-`4` point and a gap point are more than `1` apart (in coordinates). -/
theorem qg_aux (X Y p q s : ℝ) (hs : s ^ 2 = 3) (hs0 : 0 < s)
    (hx1 : 1 < X ^ 2 + Y ^ 2) (hxc : (X + s / 2) ^ 2 + (Y + 1 / 2) ^ 2 < 1) (hxd : X ^ 2 + (Y + 1) ^ 2 < 1)
    (h1 : 1 < p ^ 2 + q ^ 2) (h2 : p ^ 2 + q ^ 2 < 9 / 4) (ha : 1 < p ^ 2 + (q - 1) ^ 2)
    (hb : 1 < (p + s / 2) ^ 2 + (q + 1 / 2) ^ 2) (hc : 0 < q) (hd : s * p + q < 0) :
    1 < (X - p) ^ 2 + (Y - q) ^ 2 := by
  have ha' : 2 * q < p ^ 2 + q ^ 2 := by linarith [show p ^ 2 + (q - 1) ^ 2 = p ^ 2 + q ^ 2 - 2 * q + 1 by ring]
  have hpre := g_re_aux p q s hs hs0 h1 h2 ha' hc hd
  have ex : (X + s / 2) ^ 2 + (Y + 1 / 2) ^ 2 = X ^ 2 + Y ^ 2 + s * X + Y + 1 := by linear_combination (1 / 4) * hs
  have exd : X ^ 2 + (Y + 1) ^ 2 = X ^ 2 + Y ^ 2 + 2 * Y + 1 := by ring
  -- w = x - c, u = y - c with c = e(-150°)
  have hB : 0 ≤ s * (X + s / 2) - (Y + 1 / 2) := by
    have : s * (X + s / 2) - (Y + 1 / 2) = s * X - Y + 1 := by linear_combination (1 / 2) * hs
    rw [this]
    have h0 : 0 ≤ (X + s / 2) ^ 2 + (Y + 1 / 2) ^ 2 := by positivity
    linarith
  have hA : Y + 1 / 2 ≤ 0 := by linarith
  have hC : p + s / 2 ≤ 0 := by linarith
  have hD : 0 ≤ s * (q + 1 / 2) + (p + s / 2) := by
    have hs32 : 3 / 2 < s := by nlinarith only [hs, hs0]
    have hp32 : -(3 / 2) < p := by nlinarith only [h2, sq_nonneg q]
    nlinarith only [mul_pos hs0 hc, hs32, hp32]
  have hinner : s * ((X + s / 2) * (p + s / 2) + (Y + 1 / 2) * (q + 1 / 2)) ≤ 0 := by
    nlinarith only [mul_nonneg (neg_nonneg.mpr hA) hD, mul_nonneg hB (neg_nonneg.mpr hC), hs]
  have hinner' : (X + s / 2) * (p + s / 2) + (Y + 1 / 2) * (q + 1 / 2) ≤ 0 := by
    by_contra hcon; push Not at hcon; nlinarith only [mul_pos hs0 hcon, hinner]
  have : (X - p) ^ 2 + (Y - q) ^ 2 = ((X + s / 2) - (p + s / 2)) ^ 2 + ((Y + 1 / 2) - (q + 1 / 2)) ^ 2 := by ring
  rw [this]
  nlinarith only [hinner', hb, sq_nonneg (X + s / 2), sq_nonneg (Y + 1 / 2)]
