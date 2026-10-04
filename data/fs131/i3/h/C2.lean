import Proofs.HadwigerNelson.Plane.SixFragment

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- Rotation by `60° k` carries the arcs of `sixFrag` into themselves. -/
theorem mem_arcs_rot (k : ℤ) {x : ℂ} (h : x ∈ ⋃ a ∈ sixArcs, a.carrier) :
    e (k * (π / 3)) * x ∈ ⋃ a ∈ sixArcs, a.carrier := by
  obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp h
  rcases ha with ((⟨j, rfl⟩ | ha) | ⟨j, rfl⟩) | ⟨j, rfl⟩
  · obtain ⟨u, v, hu, hv, huv, rfl⟩ := hxa
    have hv1 : v ≤ 1 := by linarith
    have := mem_arcs_radial hv hv1 (((j : ℕ) : ℤ) + k)
    convert this using 1
    simp only [smul_zero, zero_add, Complex.real_smul]
    rw [mul_left_comm, ← e_add]; congr 2; push_cast; ring
  · rw [mem_singleton_iff] at ha
    subst ha
    obtain ⟨θ, -, rfl⟩ := hxa
    exact mem_arcs_of_norm_eq_one (by simp)
  · obtain ⟨θ, hθ, rfl⟩ := hxa
    have := mem_arcs_side₁ (((j : ℕ) : ℤ) + k) (ψ := θ + k * (π / 3))
      ⟨by push_cast; linarith [hθ.1], by push_cast; linarith [hθ.2]⟩
    convert this using 1
    show e (k * (π / 3)) * (_ + ((1 : ℝ) : ℂ) * e θ) = _
    rw [Complex.ofReal_one, one_mul, mul_add, ← e_add, ← e_add]
    congr 2 <;> push_cast <;> ring
  · obtain ⟨θ, hθ, rfl⟩ := hxa
    have := mem_arcs_side₂ (((j : ℕ) : ℤ) + k) (ψ := θ + k * (π / 3))
      ⟨by push_cast; linarith [hθ.1], by push_cast; linarith [hθ.2]⟩
    convert this using 1
    show e (k * (π / 3)) * (_ + ((1 : ℝ) : ℂ) * e θ) = _
    rw [Complex.ofReal_one, one_mul, mul_add, ← e_add, ← e_add]
    congr 2 <;> push_cast <;> ring

/-- Rotation by `60° k` preserves the interior points of `sixFrag`. -/
theorem rot_mem_interiorPts (k : ℤ) {x : ℂ} (hx : x ∈ sixFrag.interiorPts) :
    e (k * (π / 3)) * x ∈ sixFrag.interiorPts := by
  obtain ⟨hxd, hxΓ⟩ := hx
  refine ⟨?_, fun h => hxΓ ?_⟩
  · show _ ∈ ball (0 : ℂ) (3 / 2)
    have : x ∈ ball (0 : ℂ) (3 / 2) := hxd
    rw [mem_ball_zero_iff] at this ⊢
    rwa [norm_mul, norm_e, one_mul]
  · have := mem_arcs_rot (-k) h
    rwa [← mul_assoc, ← e_add, show ((-k : ℤ) : ℝ) * (π / 3) + k * (π / 3) = 0 by push_cast; ring, e_zero,
      one_mul] at this

/-- The sector `S_0` of colour `0`: the open unit disc between the angles `0°` and `60°`. -/
private def sixS (z : ℂ) : Prop := ‖z‖ < 1 ∧ 0 < Complex.arg z ∧ Complex.arg z < π / 3

/-- The lens `Q_4` of colour `0`, cut at `3/2`: outside the unit circle, within `1` of `e(−150°)` and of `e(−90°)`
(its angles lie in `(−150°, −90°)`). -/
private def sixQ (z : ℂ) : Prop :=
  1 < ‖z‖ ∧ ‖z‖ < 3 / 2 ∧ -(5 * π / 6) < Complex.arg z ∧ Complex.arg z < -(π / 2) ∧
    dist z (e (-(5 * π / 6))) < 1 ∧ dist z (e (-(π / 2))) < 1

/-- The gap tile `G_2` of colour `0`, cut at `3/2`: outside the unit circle, angles in `(120°, 180°)`, farther than `1`
from `e(90°)` and from `e(−150°)`. -/
private def sixG (z : ℂ) : Prop :=
  1 < ‖z‖ ∧ ‖z‖ < 3 / 2 ∧ 2 * π / 3 < Complex.arg z ∧ Complex.arg z < π ∧
    1 < dist z (e (π / 2)) ∧ 1 < dist z (e (-(5 * π / 6)))

/-- GG: the gap tile (rotated to the positive axis) lies in the open disc of radius `1/2` about `7/5`. -/
theorem sixPair_gg (u v s : ℝ) (hs : s ^ 2 = 3) (h1 : 1 < u ^ 2 + v ^ 2) (h2 : u ^ 2 + v ^ 2 < 9 / 4)
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
theorem sixPair_ss (r t C : ℝ) (hr0 : 0 < r) (hr1 : r < 1) (ht0 : 0 < t) (ht1 : t < 1) (hC : 1 / 2 < C) :
    r ^ 2 + t ^ 2 - 2 * r * t * C < 1 := by
  rcases le_total r t with h | h
  · nlinarith [mul_pos hr0 ht0, mul_nonneg hr0.le (sub_nonneg.mpr h)]
  · nlinarith [mul_pos hr0 ht0, mul_nonneg ht0.le (sub_nonneg.mpr h)]

/-- G's first coordinate: a gap point is left of `−√3/2`. -/
theorem sixPair_gRe (p q s : ℝ) (hs : s ^ 2 = 3) (hs0 : 0 < s) (h1 : 1 < p ^ 2 + q ^ 2) (h2 : p ^ 2 + q ^ 2 < 9 / 4)
    (ha : 2 * q < p ^ 2 + q ^ 2) (hc : 0 < q) (hd : s * p + q < 0) : p < -(s / 2) := by
  have hp : p < 0 := by nlinarith
  have hp2 : 3 / 4 < p ^ 2 := by
    rcases le_or_gt (1 / 2) q with hq | hq
    · nlinarith
    · nlinarith
  nlinarith

/-- QG: a lens-`4` point and a gap point are more than `1` apart (in coordinates). -/
theorem sixPair_qg (X Y p q s : ℝ) (hs : s ^ 2 = 3) (hs0 : 0 < s)
    (hx1 : 1 < X ^ 2 + Y ^ 2) (hxd : X ^ 2 + (Y + 1) ^ 2 < 1)
    (h1 : 1 < p ^ 2 + q ^ 2) (h2 : p ^ 2 + q ^ 2 < 9 / 4) (ha : 1 < p ^ 2 + (q - 1) ^ 2)
    (hb : 1 < (p + s / 2) ^ 2 + (q + 1 / 2) ^ 2) (hc : 0 < q) (hd : s * p + q < 0) :
    1 < (X - p) ^ 2 + (Y - q) ^ 2 := by
  have ha' : 2 * q < p ^ 2 + q ^ 2 := by linarith [show p ^ 2 + (q - 1) ^ 2 = p ^ 2 + q ^ 2 - 2 * q + 1 by ring]
  have hpre := sixPair_gRe p q s hs hs0 h1 h2 ha' hc hd
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

/-- A point of the closed lens about `0°` outside the open unit disc is within `1` of `√3`. -/
theorem sixPair_qf (X Y s : ℝ) (hs : s ^ 2 = 3) (hs0 : 0 < s)
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
theorem sixPair_qq (X Y U V s : ℝ) (hs : s ^ 2 = 3) (hs0 : 0 < s)
    (hz1 : 1 ≤ X ^ 2 + Y ^ 2) (hzc : X ^ 2 + Y ^ 2 ≤ s * X - Y) (hzd : X ^ 2 + Y ^ 2 ≤ s * X + Y)
    (hw1 : 1 ≤ U ^ 2 + V ^ 2) (hwc : U ^ 2 + V ^ 2 ≤ s * U - V) (hwd : U ^ 2 + V ^ 2 ≤ s * U + V) :
    (X - U) ^ 2 + (Y - V) ^ 2 ≤ 1 := by
  have pzc : (X - s / 2) ^ 2 + (Y + 1 / 2) ^ 2 ≤ 1 := by
    have : (X - s / 2) ^ 2 + (Y + 1 / 2) ^ 2 = X ^ 2 + Y ^ 2 - s * X + Y + 1 := by linear_combination (1 / 4) * hs
    linarith
  have pzd : (X - s / 2) ^ 2 + (Y - 1 / 2) ^ 2 ≤ 1 := by
    have : (X - s / 2) ^ 2 + (Y - 1 / 2) ^ 2 = X ^ 2 + Y ^ 2 - s * X - Y + 1 := by linear_combination (1 / 4) * hs
    linarith
  have pzf := sixPair_qf X Y s hs hs0 hz1 hzc hzd
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

/-- SG: a sector point and a gap point are more than `1` apart (in coordinates). Beyond the ray `150°` the inner product
is negative; before it, the projection on `e(150°)` exceeds `1`. -/
theorem sixPair_sg (a b p q s : ℝ) (hs : s ^ 2 = 3) (hs0 : 0 < s) (hb0 : 0 < b) (hb : b < s * a)
    (hy1 : 1 < p ^ 2 + q ^ 2) (hq : 0 < q) (hd : s * p + q < 0) (hfar : 1 < p ^ 2 + (q - 1) ^ 2) :
    1 < (a - p) ^ 2 + (b - q) ^ 2 := by
  have ha0 : 0 < a := by nlinarith only [hb0, hb, hs0]
  rcases le_or_gt (p + s * q) 0 with hv | hv
  · have hin : a * p + b * q < 0 := by
      nlinarith only [mul_le_mul_of_nonneg_left hv ha0.le, mul_pos hq (sub_pos.mpr hb), hs]
    nlinarith only [hin, hy1, sq_nonneg a, sq_nonneg b]
  · set u := (-(s * p) + q) / 2 with hu
    set v := (p + s * q) / 2 with hv'
    have huv : u ^ 2 + v ^ 2 = p ^ 2 + q ^ 2 := by rw [hu, hv']; linear_combination (p ^ 2 / 4 + q ^ 2 / 4) * hs
    have h2q : u + s * v = 2 * q := by rw [hu, hv']; linear_combination (q / 2) * hs
    have hus : s * v < u := by
      have : u - s * v = -(s * p) - q := by rw [hu, hv']; linear_combination (-(q / 2)) * hs
      linarith
    have hv0 : 0 < v := by rw [hv']; linarith
    have hfar' : u + s * v < u ^ 2 + v ^ 2 := by
      rw [huv, h2q]; nlinarith only [hfar]
    have hu1 : 1 < u := by
      by_contra hc
      push Not at hc
      have hu0 : 0 < u := by nlinarith only [hus, hv0, hs0]
      have hvs : s < v := by nlinarith only [hfar', hc, hu0, hv0]
      nlinarith only [hus, mul_lt_mul_of_pos_left hvs hs0, hs, hc]
    have hproj : 1 < (-(s * (p - a)) + (q - b)) / 2 := by
      have : (-(s * (p - a)) + (q - b)) / 2 = u + (s * a - b) / 2 := by rw [hu]; ring
      rw [this]; linarith
    have hcs : ((-(s * (p - a)) + (q - b)) / 2) ^ 2 ≤ (a - p) ^ 2 + (b - q) ^ 2 := by
      nlinarith only [sq_nonneg ((p - a) / 2 + s * (q - b) / 2), hs]
    nlinarith only [hcs, hproj]

/-- SQ: a sector point (first quadrant) and a lens-`4` point (third quadrant, outside the unit circle) are more than `1`
apart. -/
theorem sixPair_sq (a b p q : ℝ) (ha : 0 < a) (hb : 0 < b) (hp : p < 0) (hq : q < 0) (hy1 : 1 < p ^ 2 + q ^ 2) :
    1 < (a - p) ^ 2 + (b - q) ^ 2 := by
  nlinarith only [mul_pos ha (neg_pos.mpr hp), mul_pos hb (neg_pos.mpr hq), hy1, sq_nonneg a, sq_nonneg b]

/-- GG in the plane's coordinates: a gap point is within `1/2` of `(7/5) e(150°)`. -/
theorem sixPair_gg' (p q s : ℝ) (hs : s ^ 2 = 3) (h1 : 1 < p ^ 2 + q ^ 2) (h2 : p ^ 2 + q ^ 2 < 9 / 4)
    (ha : 1 < p ^ 2 + (q - 1) ^ 2) (hb : 1 < (p + s / 2) ^ 2 + (q + 1 / 2) ^ 2) (hc : 0 < q) (hd : s * p + q < 0) :
    (p + 7 * s / 10) ^ 2 + (q - 7 / 10) ^ 2 < 1 / 4 := by
  have huv : ((-(s * p) + q) / 2) ^ 2 + ((p + s * q) / 2) ^ 2 = p ^ 2 + q ^ 2 := by
    linear_combination (p ^ 2 / 4 + q ^ 2 / 4) * hs
  have h2q : (-(s * p) + q) / 2 + s * ((p + s * q) / 2) = 2 * q := by linear_combination (q / 2) * hs
  have h2q' : (-(s * p) + q) / 2 - s * ((p + s * q) / 2) = -(s * p) - q := by linear_combination (-(q / 2)) * hs
  have key := sixPair_gg ((-(s * p) + q) / 2) ((p + s * q) / 2) s hs (by rw [huv]; exact h1) (by rw [huv]; exact h2)
    (by rw [huv, h2q]; nlinarith only [ha]) (by
      rw [huv, h2q']
      have : (p + s / 2) ^ 2 + (q + 1 / 2) ^ 2 = p ^ 2 + q ^ 2 + s * p + q + 1 := by
        linear_combination (1 / 4) * hs
      linarith) (by linarith) (by linarith)
  have : (p + 7 * s / 10) ^ 2 + (q - 7 / 10) ^ 2 = ((-(s * p) + q) / 2 - 7 / 5) ^ 2 + ((p + s * q) / 2) ^ 2 := by
    linear_combination (-(p ^ 2 / 4) - q ^ 2 / 4 + 49 / 100) * hs
  rw [this]; exact key

/-- The distance from `x ≠ 0` to `e(α)` is below `1` exactly when `‖x‖ < 2 cos(arg x − α)`. -/
theorem dist_lt_one_iff_arg {x : ℂ} (hx : x ≠ 0) (α : ℝ) :
    dist x (e α) < 1 ↔ ‖x‖ < 2 * Real.cos (Complex.arg x - α) := by
  conv_lhs => rw [eq_norm_mul_e_arg (x := x)]
  exact dist_polar_lt_one_iff (norm_pos_iff.mpr hx) _ _

/-- The distance from `x ≠ 0` to `e(α)` exceeds `1` exactly when `2 cos(arg x − α) < ‖x‖`. -/
theorem one_lt_dist_iff_arg {x : ℂ} (hx : x ≠ 0) (α : ℝ) :
    1 < dist x (e α) ↔ 2 * Real.cos (Complex.arg x - α) < ‖x‖ := by
  have h1 := dist_lt_one_iff_arg hx α
  have h2 : dist x (e α) = 1 ↔ ‖x‖ = 2 * Real.cos (Complex.arg x - α) := by
    conv_lhs => rw [eq_norm_mul_e_arg (x := x)]
    exact dist_polar_eq_one_iff (norm_pos_iff.mpr hx) _ _
  constructor
  · intro h
    rcases lt_trichotomy (2 * Real.cos (Complex.arg x - α)) ‖x‖ with h3 | h3 | h3
    · exact h3
    · linarith [h2.mpr h3.symm]
    · linarith [h1.mpr h3]
  · intro h
    rcases lt_trichotomy (dist x (e α)) 1 with h3 | h3 | h3
    · linarith [h1.mp h3]
    · linarith [h2.mp h3]
    · exact h3

/-- `⌊arg x / 60°⌋` lies in `[−3, 3]`. -/
theorem floor_arg_bounds (x : ℂ) : -3 ≤ ⌊Complex.arg x / (π / 3)⌋ ∧ ⌊Complex.arg x / (π / 3)⌋ ≤ 3 := by
  have hπ := Real.pi_pos
  have h1 : -3 < Complex.arg x / (π / 3) := by
    rw [lt_div_iff₀ (by positivity)]; linarith [Complex.neg_pi_lt_arg x]
  have h2 : Complex.arg x / (π / 3) ≤ 3 := by
    rw [div_le_iff₀ (by positivity)]; linarith [Complex.arg_le_pi x]
  constructor
  · have := Int.lt_floor_add_one (Complex.arg x / (π / 3))
    have : (-4 : ℝ) < ⌊Complex.arg x / (π / 3)⌋ := by linarith
    have : (-4 : ℤ) < ⌊Complex.arg x / (π / 3)⌋ := by exact_mod_cast this
    omega
  · have := Int.floor_le (Complex.arg x / (π / 3))
    have : (⌊Complex.arg x / (π / 3)⌋ : ℝ) ≤ 3 := by linarith
    exact_mod_cast this

/-- **The colour-`0` interior points** of `sixFrag` lie in `S_0`, `Q_4` or `G_2`. -/
theorem sixCol_zero_cases {x : ℂ} (hx : x ∈ sixFrag.interiorPts) (hc : sixCol x = 0) :
    sixS x ∨ sixQ x ∨ sixG x := by
  have hπ := Real.pi_pos
  obtain ⟨hxd, hxΓ⟩ := hx
  have hx32 : ‖x‖ < 3 / 2 := by
    have : x ∈ ball (0 : ℂ) (3 / 2) := hxd
    simpa using this
  have hxΓ' : x ∉ ⋃ a ∈ sixArcs, a.carrier := hxΓ
  have hx0 : x ≠ 0 := by
    rintro rfl
    exact hxΓ' (by simpa using mem_arcs_radial (le_refl (0 : ℝ)) zero_le_one 0)
  have hn1 : ‖x‖ ≠ 1 := fun h => hxΓ' (mem_arcs_of_norm_eq_one h)
  have hxe := eq_norm_mul_e_arg (x := x)
  have hp3 : 0 < π / 3 := by positivity
  obtain ⟨hf1, hf2⟩ := floor_arg_bounds x
  rcases lt_or_gt_of_ne hn1 with hlt | hgt
  · left
    have hsec : ((⌊Complex.arg x / (π / 3)⌋ : ℤ) : ZMod 6) = 0 := by
      have := hc; simp only [sixCol, hlt, if_true, sixSector] at this; exact this
    have h6 := (ZMod.intCast_zmod_eq_zero_iff_dvd _ 6).mp hsec
    have hn0 : ⌊Complex.arg x / (π / 3)⌋ = 0 := by push_cast at h6; omega
    rw [Int.floor_eq_zero_iff] at hn0
    obtain ⟨h0, h1⟩ := hn0
    rw [le_div_iff₀ hp3, zero_mul] at h0
    rw [div_lt_iff₀ hp3, one_mul] at h1
    refine ⟨hlt, lt_of_le_of_ne h0 fun h => hxΓ' ?_, h1⟩
    rw [hxe, ← h]
    simpa using mem_arcs_radial (norm_nonneg x) hlt.le 0
  · right
    have hn : ¬ ‖x‖ < 1 := not_lt.mpr hgt.le
    by_cases hL : InSixLens (sixRound x) x
    · left
      have hc' : (((sixRound x : ℤ) : ZMod 6) + 2 : ZMod 6) = 0 := by
        have := hc; simp only [sixCol, hn, if_false, hL, if_true] at this; exact this
      have h6 : (6 : ℤ) ∣ sixRound x + 2 := by
        have := (ZMod.intCast_zmod_eq_zero_iff_dvd (sixRound x + 2) 6).mp (by push_cast; exact hc')
        exact_mod_cast this
      have hr1 : -3 ≤ sixRound x ∧ sixRound x ≤ 3 := by
        unfold sixRound
        rw [round_eq]
        have h1 : -3 < Complex.arg x / (π / 3) := by
          rw [lt_div_iff₀ hp3]; linarith [Complex.neg_pi_lt_arg x]
        have h2 : Complex.arg x / (π / 3) ≤ 3 := by
          rw [div_le_iff₀ hp3]; linarith [Complex.arg_le_pi x]
        constructor
        · have := Int.lt_floor_add_one (Complex.arg x / (π / 3) + 1 / 2)
          have : (-4 : ℝ) < ⌊Complex.arg x / (π / 3) + 1 / 2⌋ := by linarith
          have : (-4 : ℤ) < ⌊Complex.arg x / (π / 3) + 1 / 2⌋ := by exact_mod_cast this
          omega
        · have := Int.floor_le (Complex.arg x / (π / 3) + 1 / 2)
          have : (⌊Complex.arg x / (π / 3) + 1 / 2⌋ : ℝ) < 4 := by linarith
          have : ⌊Complex.arg x / (π / 3) + 1 / 2⌋ < (4 : ℤ) := by exact_mod_cast this
          omega
      have hm : sixRound x = -2 := by omega
      have hL2 := hL
      rw [hm] at hL2
      obtain ⟨l1, l2⟩ := hL2
      have e1 : ((-2 : ℤ) : ℝ) * (π / 3) - π / 6 = -(5 * π / 6) := by push_cast; ring
      have e2 : ((-2 : ℤ) : ℝ) * (π / 3) + π / 6 = -(π / 2) := by push_cast; ring
      rw [e1] at l1
      rw [e2] at l2
      have hfl : ⌊Complex.arg x / (π / 3) + 1 / 2⌋ = -2 := by rw [← round_eq]; exact hm
      rw [Int.floor_eq_iff] at hfl
      push_cast at hfl
      obtain ⟨g1, g2⟩ := hfl
      have a1 : -(5 * π / 6) ≤ Complex.arg x := by
        have : -(5 / 2 : ℝ) ≤ Complex.arg x / (π / 3) := by linarith
        rw [le_div_iff₀ hp3] at this; linarith
      have a2 : Complex.arg x < -(π / 2) := by
        have : Complex.arg x / (π / 3) < -(3 / 2 : ℝ) := by linarith
        rw [div_lt_iff₀ hp3] at this; linarith
      refine ⟨hgt, hx32, lt_of_le_of_ne a1 fun h => ?_, a2, l1, l2⟩
      have := (dist_lt_one_iff_arg hx0 _).mp l2
      rw [← h, show -(5 * π / 6) - -(π / 2) = -(π / 3) by ring, Real.cos_neg, Real.cos_pi_div_three] at this
      linarith
    · right
      have hc' : ((⌊Complex.arg x / (π / 3)⌋ : ℤ) : ZMod 6) + 4 = 0 := by
        have := hc; simp only [sixCol, hn, if_false, hL, sixSector] at this; exact this
      have h6 : (6 : ℤ) ∣ ⌊Complex.arg x / (π / 3)⌋ + 4 := by
        have := (ZMod.intCast_zmod_eq_zero_iff_dvd (⌊Complex.arg x / (π / 3)⌋ + 4) 6).mp (by push_cast; exact hc')
        exact_mod_cast this
      have hn2 : ⌊Complex.arg x / (π / 3)⌋ = 2 := by omega
      rw [Int.floor_eq_iff] at hn2
      push_cast at hn2
      obtain ⟨g1, g2⟩ := hn2
      rw [le_div_iff₀ hp3] at g1
      rw [div_lt_iff₀ hp3] at g2
      replace g1 : 2 * π / 3 ≤ Complex.arg x := by linarith
      replace g2 : Complex.arg x < π := by linarith
      have hs3 : (3 / 2 : ℝ) < Real.sqrt 3 := by
        rw [Real.lt_sqrt (by norm_num)]; norm_num
      have hnl : ∀ m : ℤ, InSixLens m x → False := by
        intro m hm
        have h1 := sixCol_of_lens hgt.le hm
        rw [hc] at h1
        obtain ⟨j, hj⟩ := inSixLens_reduce m
        -- the lens index is `4` mod 6
        have hm6 : (6 : ℤ) ∣ m + 2 := by
          have := (ZMod.intCast_zmod_eq_zero_iff_dvd (m + 2) 6).mp (by push_cast; exact h1.symm)
          exact_mod_cast this
        -- but the angle of `x` is in `[120°, 180°)`
        obtain ⟨k, hk⟩ := sixRound_of_lens hgt.le hm
        have hrd : sixRound x = 2 ∨ sixRound x = 3 := by
          unfold sixRound; rw [round_eq]
          have q1 : (5 / 2 : ℝ) ≤ Complex.arg x / (π / 3) + 1 / 2 := by
            have : (2 : ℝ) ≤ Complex.arg x / (π / 3) := by rw [le_div_iff₀ hp3]; linarith
            linarith
          have q2 : Complex.arg x / (π / 3) + 1 / 2 < 7 / 2 := by
            have : Complex.arg x / (π / 3) < 3 := by rw [div_lt_iff₀ hp3]; linarith
            linarith
          have r1 := Int.floor_le (Complex.arg x / (π / 3) + 1 / 2)
          have r2 := Int.lt_floor_add_one (Complex.arg x / (π / 3) + 1 / 2)
          have r1' : (⌊Complex.arg x / (π / 3) + 1 / 2⌋ : ℝ) < 4 := by linarith
          have r2' : (1 : ℝ) < ⌊Complex.arg x / (π / 3) + 1 / 2⌋ := by linarith
          have r1'' : ⌊Complex.arg x / (π / 3) + 1 / 2⌋ < (4 : ℤ) := by exact_mod_cast r1'
          have r2'' : (1 : ℤ) < ⌊Complex.arg x / (π / 3) + 1 / 2⌋ := by exact_mod_cast r2'
          omega
        omega
      have hd56 : dist x (e (5 * π / 6)) < 1 := by
        rw [dist_lt_one_iff_arg hx0]
        have hc56 : Real.sqrt 3 / 2 ≤ Real.cos (Complex.arg x - 5 * π / 6) := by
          rw [← Real.cos_pi_div_six, ← Real.cos_abs (Complex.arg x - 5 * π / 6)]
          apply Real.cos_le_cos_of_nonneg_of_le_pi (abs_nonneg _) (by linarith)
          rw [abs_le]; constructor <;> linarith
        linarith
      have hn2' := exists_one_lt_dist_of_not_lens hgt.le hxΓ' 2 (fun h => hnl 2 h)
      have hn3' := exists_one_lt_dist_of_not_lens hgt.le hxΓ' 3 (fun h => hnl 3 h)
      have e21 : ((2 : ℤ) : ℝ) * (π / 3) - π / 6 = π / 2 := by push_cast; ring
      have e22 : ((2 : ℤ) : ℝ) * (π / 3) + π / 6 = 5 * π / 6 := by push_cast; ring
      have e31 : ((3 : ℤ) : ℝ) * (π / 3) - π / 6 = 5 * π / 6 := by push_cast; ring
      have e32 : e (((3 : ℤ) : ℝ) * (π / 3) + π / 6) = e (-(5 * π / 6)) := by
        rw [← e_add_two_pi (-(5 * π / 6))]; congr 1; push_cast; ring
      rw [e21, e22] at hn2'
      rw [e31, e32] at hn3'
      refine ⟨hgt, hx32, lt_of_le_of_ne g1 fun h => hnl 2 ?_, g2, ?_, ?_⟩
      · refine ⟨?_, ?_⟩
        · rw [dist_lt_one_iff_arg hx0, ← h,
            show 2 * π / 3 - (((2 : ℤ) : ℝ) * (π / 3) - π / 6) = π / 6 by push_cast; ring, Real.cos_pi_div_six]
          linarith
        · rw [dist_lt_one_iff_arg hx0, ← h,
            show 2 * π / 3 - (((2 : ℤ) : ℝ) * (π / 3) + π / 6) = -(π / 6) by push_cast; ring, Real.cos_neg,
            Real.cos_pi_div_six]
          linarith
      · rcases hn2' with h | h
        · exact h
        · linarith
      · rcases hn3' with h | h
        · linarith
        · exact h


/-! ### Coordinates of the pieces -/

/-- The squared distance in coordinates. -/
theorem dist_sq_re_im (z w : ℂ) : dist z w ^ 2 = (z.re - w.re) ^ 2 + (z.im - w.im) ^ 2 := by
  rw [Complex.dist_eq, Complex.sq_norm, Complex.normSq_apply]
  simp only [Complex.sub_re, Complex.sub_im]
  ring

/-- The squared norm in coordinates. -/
theorem sq_norm_re_im (z : ℂ) : ‖z‖ ^ 2 = z.re ^ 2 + z.im ^ 2 := by
  rw [Complex.sq_norm, Complex.normSq_apply]; ring

/-- `e θ` in coordinates. -/
theorem e_re_im (θ : ℝ) : (e θ).re = Real.cos θ ∧ (e θ).im = Real.sin θ := by
  rw [e_eq]
  simp only [Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.I_re, Complex.ofReal_im, Complex.I_im,
    Complex.add_im, Complex.mul_im]
  constructor <;> ring

/-- `cos 150° = −√3/2`. -/
theorem cos_five_pi_div_six : Real.cos (5 * π / 6) = -(Real.sqrt 3 / 2) := by
  rw [show 5 * π / 6 = π - π / 6 by ring, Real.cos_pi_sub, Real.cos_pi_div_six]

/-- `sin 150° = 1/2`. -/
theorem sin_five_pi_div_six : Real.sin (5 * π / 6) = 1 / 2 := by
  rw [show 5 * π / 6 = π - π / 6 by ring, Real.sin_pi_sub, Real.sin_pi_div_six]

/-- The squared distance to `e(−150°)` in coordinates. -/
theorem dist_e_neg_five_pi_div_six_sq (z : ℂ) :
    dist z (e (-(5 * π / 6))) ^ 2 = (z.re + Real.sqrt 3 / 2) ^ 2 + (z.im + 1 / 2) ^ 2 := by
  rw [dist_sq_re_im, (e_re_im _).1, (e_re_im _).2, Real.cos_neg, Real.sin_neg, cos_five_pi_div_six,
    sin_five_pi_div_six]
  ring

/-- The squared distance to `e(−90°)` in coordinates. -/
theorem dist_e_neg_pi_div_two_sq (z : ℂ) : dist z (e (-(π / 2))) ^ 2 = z.re ^ 2 + (z.im + 1) ^ 2 := by
  rw [dist_sq_re_im, (e_re_im _).1, (e_re_im _).2, Real.cos_neg, Real.sin_neg, Real.cos_pi_div_two,
    Real.sin_pi_div_two]
  ring

/-- The squared distance to `e(90°)` in coordinates. -/
theorem dist_e_pi_div_two_sq (z : ℂ) : dist z (e (π / 2)) ^ 2 = z.re ^ 2 + (z.im - 1) ^ 2 := by
  rw [dist_sq_re_im, (e_re_im _).1, (e_re_im _).2, Real.cos_pi_div_two, Real.sin_pi_div_two]
  ring

/-- `S_0` in coordinates: the open first sextant. -/
private theorem sixS_coords {x : ℂ} (h : sixS x) : 0 < x.re ∧ 0 < x.im ∧ x.im < Real.sqrt 3 * x.re := by
  have hπ := Real.pi_pos
  obtain ⟨-, h1, h2⟩ := h
  have hx0 : x ≠ 0 := by rintro rfl; simp at h1
  have hr : 0 < ‖x‖ := norm_pos_iff.mpr hx0
  have hre := Complex.norm_mul_cos_arg x
  have him := Complex.norm_mul_sin_arg x
  have hc : 0 < Real.cos (Complex.arg x) := Real.cos_pos_of_mem_Ioo ⟨by linarith, by linarith⟩
  have hs : 0 < Real.sin (Complex.arg x) := Real.sin_pos_of_pos_of_lt_pi h1 (by linarith)
  have hd : 0 < Real.sin (π / 3 - Complex.arg x) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
  rw [Real.sin_sub, Real.sin_pi_div_three, Real.cos_pi_div_three] at hd
  refine ⟨by rw [← hre]; positivity, by rw [← him]; positivity, ?_⟩
  rw [← hre, ← him]
  nlinarith only [mul_pos hr hd]

/-- `Q_4` in coordinates: the open third quadrant. -/
private theorem sixQ_coords {y : ℂ} (h : sixQ y) : y.re < 0 ∧ y.im < 0 := by
  have hπ := Real.pi_pos
  obtain ⟨h1, -, h3, h4, -, -⟩ := h
  have hr : 0 < ‖y‖ := by linarith
  have hc : Real.cos (Complex.arg y) < 0 := by
    rw [← Real.cos_neg]; exact Real.cos_neg_of_pi_div_two_lt_of_lt (by linarith) (by linarith)
  have hs : Real.sin (Complex.arg y) < 0 := Real.sin_neg_of_neg_of_neg_pi_lt (by linarith) (by linarith)
  rw [← Complex.norm_mul_cos_arg y, ← Complex.norm_mul_sin_arg y]
  exact ⟨mul_neg_of_pos_of_neg hr hc, mul_neg_of_pos_of_neg hr hs⟩

/-- `G_2` in coordinates: the open sextant between `120°` and `180°`. -/
private theorem sixG_coords {y : ℂ} (h : sixG y) : 0 < y.im ∧ Real.sqrt 3 * y.re + y.im < 0 := by
  have hπ := Real.pi_pos
  obtain ⟨h1, -, h3, h4, -, -⟩ := h
  have hr : 0 < ‖y‖ := by linarith
  have hs : 0 < Real.sin (Complex.arg y) := Real.sin_pos_of_pos_of_lt_pi (by linarith) h4
  have hd : Real.sin (Complex.arg y + π / 3) < 0 := by
    have := Real.sin_neg_of_neg_of_neg_pi_lt (x := Complex.arg y + π / 3 - 2 * π) (by linarith) (by linarith)
    rwa [Real.sin_sub_two_pi] at this
  rw [Real.sin_add, Real.sin_pi_div_three, Real.cos_pi_div_three] at hd
  rw [← Complex.norm_mul_cos_arg y, ← Complex.norm_mul_sin_arg y]
  refine ⟨mul_pos hr hs, ?_⟩
  nlinarith only [mul_pos hr (neg_pos.mpr hd)]


/-! ### The six pair bounds of colour `0` -/

/-- From a squared distance above `1` to a distance above `1`. -/
theorem one_lt_dist_of_sq {z w : ℂ} (h : 1 < dist z w ^ 2) : 1 < dist z w := by
  nlinarith [dist_nonneg (x := z) (y := w)]

/-- The squared distance in polar coordinates. -/
theorem dist_sq_polar (x y : ℂ) :
    dist x y ^ 2 = ‖x‖ ^ 2 + ‖y‖ ^ 2 - 2 * ‖x‖ * ‖y‖ * Real.cos (Complex.arg x - Complex.arg y) := by
  rw [dist_sq_re_im, ← Complex.norm_mul_cos_arg x, ← Complex.norm_mul_sin_arg x, ← Complex.norm_mul_cos_arg y,
    ← Complex.norm_mul_sin_arg y, Real.cos_sub]
  nlinarith [Real.sin_sq_add_cos_sq (Complex.arg x), Real.sin_sq_add_cos_sq (Complex.arg y)]

/-- SS: `S_0` has diameter below `1`. -/
private theorem sixS_sixS {x y : ℂ} (hx : sixS x) (hy : sixS y) : dist x y < 1 := by
  have hπ := Real.pi_pos
  obtain ⟨hx1, hx2, hx3⟩ := hx
  obtain ⟨hy1, hy2, hy3⟩ := hy
  have hx0 : x ≠ 0 := by rintro rfl; simp at hx2
  have hy0 : y ≠ 0 := by rintro rfl; simp at hy2
  have hC : 1 / 2 < Real.cos (Complex.arg x - Complex.arg y) := by
    rw [← Real.cos_pi_div_three, ← Real.cos_abs (Complex.arg x - Complex.arg y)]
    apply Real.cos_lt_cos_of_nonneg_of_le_pi (abs_nonneg _) (by linarith)
    rw [abs_lt]; constructor <;> linarith
  have key := sixPair_ss ‖x‖ ‖y‖ _ (norm_pos_iff.mpr hx0) hx1 (norm_pos_iff.mpr hy0) hy1 hC
  rw [← dist_sq_polar] at key
  nlinarith [dist_nonneg (x := x) (y := y)]

/-- SQ: `S_0` and `Q_4` are more than `1` apart. -/
private theorem sixS_sixQ {x y : ℂ} (hx : sixS x) (hy : sixQ y) : 1 < dist x y := by
  obtain ⟨a1, a2, -⟩ := sixS_coords hx
  obtain ⟨b1, b2⟩ := sixQ_coords hy
  have hy1 : 1 < y.re ^ 2 + y.im ^ 2 := by rw [← sq_norm_re_im]; nlinarith [hy.1]
  apply one_lt_dist_of_sq
  rw [dist_sq_re_im]
  exact sixPair_sq _ _ _ _ a1 a2 b1 b2 hy1

/-- SG: `S_0` and `G_2` are more than `1` apart. -/
private theorem sixS_sixG {x y : ℂ} (hx : sixS x) (hy : sixG y) : 1 < dist x y := by
  have hs : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have hs0 : 0 < Real.sqrt 3 := by positivity
  obtain ⟨-, a2, a3⟩ := sixS_coords hx
  obtain ⟨b1, b2⟩ := sixG_coords hy
  have hy1 : 1 < y.re ^ 2 + y.im ^ 2 := by rw [← sq_norm_re_im]; nlinarith [hy.1]
  have hfar : 1 < y.re ^ 2 + (y.im - 1) ^ 2 := by
    rw [← dist_e_pi_div_two_sq]; nlinarith [hy.2.2.2.2.1, dist_nonneg (x := y) (y := e (π / 2))]
  apply one_lt_dist_of_sq
  rw [dist_sq_re_im]
  exact sixPair_sg _ _ _ _ _ hs hs0 a2 a3 hy1 b1 b2 hfar

/-- QG: `Q_4` and `G_2` are more than `1` apart. -/
private theorem sixQ_sixG {x y : ℂ} (hx : sixQ x) (hy : sixG y) : 1 < dist x y := by
  have hs : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have hs0 : 0 < Real.sqrt 3 := by positivity
  obtain ⟨b1, b2⟩ := sixG_coords hy
  have hx1 : 1 < x.re ^ 2 + x.im ^ 2 := by rw [← sq_norm_re_im]; nlinarith [hx.1]
  have hxd : x.re ^ 2 + (x.im + 1) ^ 2 < 1 := by
    rw [← dist_e_neg_pi_div_two_sq]; nlinarith [hx.2.2.2.2.2, dist_nonneg (x := x) (y := e (-(π / 2)))]
  have hy1 : 1 < y.re ^ 2 + y.im ^ 2 := by rw [← sq_norm_re_im]; nlinarith [hy.1]
  have hy2 : y.re ^ 2 + y.im ^ 2 < 9 / 4 := by rw [← sq_norm_re_im]; nlinarith [hy.2.1, norm_nonneg y]
  have hfar : 1 < y.re ^ 2 + (y.im - 1) ^ 2 := by
    rw [← dist_e_pi_div_two_sq]; nlinarith [hy.2.2.2.2.1, dist_nonneg (x := y) (y := e (π / 2))]
  have hfar' : 1 < (y.re + Real.sqrt 3 / 2) ^ 2 + (y.im + 1 / 2) ^ 2 := by
    rw [← dist_e_neg_five_pi_div_six_sq]
    nlinarith [hy.2.2.2.2.2, dist_nonneg (x := y) (y := e (-(5 * π / 6)))]
  apply one_lt_dist_of_sq
  rw [dist_sq_re_im]
  exact sixPair_qg _ _ _ _ _ hs hs0 hx1 hxd hy1 hy2 hfar hfar' b1 b2

/-- The centre `(7/5) e(150°)` of a disc of radius `1/2` holding `G_2`. -/
private noncomputable def gCentre : ℂ := ⟨-(7 * Real.sqrt 3 / 10), 7 / 10⟩

/-- GG: `G_2` lies in the open disc of radius `1/2` about `(7/5) e(150°)`. -/
private theorem sixG_near {y : ℂ} (hy : sixG y) : dist y gCentre < 1 / 2 := by
  have hs : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  obtain ⟨b1, b2⟩ := sixG_coords hy
  have hy1 : 1 < y.re ^ 2 + y.im ^ 2 := by rw [← sq_norm_re_im]; nlinarith [hy.1]
  have hy2 : y.re ^ 2 + y.im ^ 2 < 9 / 4 := by rw [← sq_norm_re_im]; nlinarith [hy.2.1, norm_nonneg y]
  have hfar : 1 < y.re ^ 2 + (y.im - 1) ^ 2 := by
    rw [← dist_e_pi_div_two_sq]; nlinarith [hy.2.2.2.2.1, dist_nonneg (x := y) (y := e (π / 2))]
  have hfar' : 1 < (y.re + Real.sqrt 3 / 2) ^ 2 + (y.im + 1 / 2) ^ 2 := by
    rw [← dist_e_neg_five_pi_div_six_sq]
    nlinarith [hy.2.2.2.2.2, dist_nonneg (x := y) (y := e (-(5 * π / 6)))]
  have key := sixPair_gg' _ _ _ hs hy1 hy2 hfar hfar' b1 b2
  have hd : dist y gCentre ^ 2 < (1 / 2) ^ 2 := by
    rw [dist_sq_re_im]
    simp only [gCentre]
    nlinarith only [key]
  nlinarith [dist_nonneg (x := y) (y := gCentre)]

/-- GG: `G_2` has diameter below `1`. -/
private theorem sixG_sixG {x y : ℂ} (hx : sixG x) (hy : sixG y) : dist x y < 1 := by
  have h1 := sixG_near hx
  have h2 := sixG_near hy
  calc dist x y ≤ dist x gCentre + dist gCentre y := dist_triangle _ _ _
    _ < 1 / 2 + 1 / 2 := by rw [dist_comm gCentre y]; linarith
    _ = 1 := by norm_num

/-- In an open set of diameter at most `1`, no two points are exactly `1` apart: push one point away from the other. -/
theorem dist_ne_one_of_isOpen {P : Set ℂ} (hP : IsOpen P) (h : ∀ x ∈ P, ∀ y ∈ P, dist x y ≤ 1) {x y : ℂ}
    (hx : x ∈ P) (hy : y ∈ P) : dist x y ≠ 1 := by
  intro h1
  have hc : Continuous fun t : ℝ => y + (t : ℂ) * (y - x) := by fun_prop
  have hmem : (fun t : ℝ => y + (t : ℂ) * (y - x)) ⁻¹' P ∈ 𝓝 (0 : ℝ) :=
    hc.continuousAt.preimage_mem_nhds (by simpa using hP.mem_nhds hy)
  obtain ⟨ε, hε, hball⟩ := Metric.mem_nhds_iff.mp hmem
  have ht : ε / 2 ∈ ball (0 : ℝ) ε := by
    rw [mem_ball_zero_iff, Real.norm_eq_abs, abs_of_pos (by linarith)]; linarith
  have hP' := h x hx _ (hball ht)
  have : dist x (y + ((ε / 2 : ℝ) : ℂ) * (y - x)) = 1 + ε / 2 := by
    rw [dist_comm, Complex.dist_eq, show y + ((ε / 2 : ℝ) : ℂ) * (y - x) - x = ((1 + ε / 2 : ℝ) : ℂ) * (y - x) by
      push_cast; ring, norm_mul, Complex.norm_real, Real.norm_of_nonneg (by linarith), ← Complex.dist_eq,
      dist_comm, h1, mul_one]
  linarith

/-- The lens `Q_0` outside the unit circle, open. -/
private def lensQ0 : Set ℂ := {z | 1 < ‖z‖ ∧ dist z (e (-(π / 6))) < 1 ∧ dist z (e (π / 6)) < 1}

/-- QQ in the frame of `Q_0`: two of its points are at most `1` apart. -/
private theorem lensQ0_diam {z w : ℂ} (hz : z ∈ lensQ0) (hw : w ∈ lensQ0) : dist z w ≤ 1 := by
  have hs : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have hs0 : 0 < Real.sqrt 3 := by positivity
  have hd : ∀ u : ℂ, u ∈ lensQ0 → 1 ≤ u.re ^ 2 + u.im ^ 2 ∧
      u.re ^ 2 + u.im ^ 2 ≤ Real.sqrt 3 * u.re - u.im ∧ u.re ^ 2 + u.im ^ 2 ≤ Real.sqrt 3 * u.re + u.im := by
    intro u ⟨h1, h2, h3⟩
    have e1 : dist u (e (-(π / 6))) ^ 2 = u.re ^ 2 + u.im ^ 2 - Real.sqrt 3 * u.re + u.im + 1 := by
      rw [dist_sq_re_im, (e_re_im _).1, (e_re_im _).2, Real.cos_neg, Real.sin_neg, Real.cos_pi_div_six,
        Real.sin_pi_div_six]
      linear_combination (1 / 4) * hs
    have e2 : dist u (e (π / 6)) ^ 2 = u.re ^ 2 + u.im ^ 2 - Real.sqrt 3 * u.re - u.im + 1 := by
      rw [dist_sq_re_im, (e_re_im _).1, (e_re_im _).2, Real.cos_pi_div_six, Real.sin_pi_div_six]
      linear_combination (1 / 4) * hs
    refine ⟨by rw [← sq_norm_re_im]; nlinarith, ?_, ?_⟩
    · nlinarith [dist_nonneg (x := u) (y := e (-(π / 6)))]
    · nlinarith [dist_nonneg (x := u) (y := e (π / 6))]
  obtain ⟨z1, z2, z3⟩ := hd z hz
  obtain ⟨w1, w2, w3⟩ := hd w hw
  have key := sixPair_qq _ _ _ _ _ hs hs0 z1 z2 z3 w1 w2 w3
  rw [← dist_sq_re_im] at key
  nlinarith [dist_nonneg (x := z) (y := w)]

/-- QQ: no two points of `Q_4` are exactly `1` apart (rotate by `120°` to `Q_0`). -/
private theorem sixQ_sixQ {x y : ℂ} (hx : sixQ x) (hy : sixQ y) : dist x y ≠ 1 := by
  have hopen : IsOpen lensQ0 :=
    (isOpen_lt continuous_const continuous_norm).inter
      ((isOpen_lt (continuous_id.dist continuous_const) continuous_const).inter
        (isOpen_lt (continuous_id.dist continuous_const) continuous_const))
  have hrot : ∀ u : ℂ, sixQ u → u * e (2 * π / 3) ∈ lensQ0 := by
    rintro u ⟨h1, -, -, -, h5, h6⟩
    refine ⟨by rwa [norm_mul, norm_e, mul_one], ?_, ?_⟩
    · rw [show e (-(π / 6)) = e (-(5 * π / 6)) * e (2 * π / 3) by rw [← e_add]; congr 1; ring, dist_rot]
      exact h5
    · rw [show e (π / 6) = e (-(π / 2)) * e (2 * π / 3) by rw [← e_add]; congr 1; ring, dist_rot]
      exact h6
  have := dist_ne_one_of_isOpen hopen (fun z hz w hw => lensQ0_diam hz hw) (hrot x hx) (hrot y hy)
  rwa [dist_rot] at this

/-- **Colour `0` is valid**: no two interior points of colour `0` are exactly `1` apart. -/
private theorem valid_zero {x y : ℂ} (hx : x ∈ sixFrag.interiorPts) (hy : y ∈ sixFrag.interiorPts)
    (hcx : sixCol x = 0) (hcy : sixCol y = 0) : dist x y ≠ 1 := by
  rcases sixCol_zero_cases hx hcx with h1 | h1 | h1 <;> rcases sixCol_zero_cases hy hcy with h2 | h2 | h2
  · exact (sixS_sixS h1 h2).ne
  · exact (sixS_sixQ h1 h2).ne'
  · exact (sixS_sixG h1 h2).ne'
  · rw [dist_comm]; exact (sixS_sixQ h2 h1).ne'
  · exact sixQ_sixQ h1 h2
  · exact (sixQ_sixG h1 h2).ne'
  · rw [dist_comm]; exact (sixS_sixG h2 h1).ne'
  · rw [dist_comm]; exact (sixQ_sixG h2 h1).ne'
  · exact (sixG_sixG h1 h2).ne

/-- The rotation taking colour `c` to colour `0`. -/
theorem sixCol_rot_to_zero (c : Fin 6) :
    ((show ZMod 6 from c) + (((-((c : ℕ) : ℤ)) : ℤ) : ZMod 6) : ZMod 6) = 0 := by
  revert c; decide

/-- **FS116-Y2-SIXFRAG**, validity (test copy). -/
theorem sixFrag_valid' : sixFrag.Valid := by
  intro x hx y hy hd hc
  have h0 : (0 : ℂ) ∈ ⋃ a ∈ sixArcs, a.carrier := by
    simpa using mem_arcs_radial (le_refl (0 : ℝ)) zero_le_one 0
  have hx0 : x ≠ 0 := by rintro rfl; exact hx.2 h0
  have hy0 : y ≠ 0 := by rintro rfl; exact hy.2 h0
  set k : ℤ := -(((sixCol x : Fin 6) : ℕ) : ℤ) with hk
  have hcx : sixCol (e (k * (π / 3)) * x) = 0 := by
    rw [sixCol_rot k hx0]; exact sixCol_rot_to_zero (sixCol x)
  have hcy : sixCol (e (k * (π / 3)) * y) = 0 := by
    have hc' : sixCol y = sixCol x := hc.symm
    rw [sixCol_rot k hy0, hc']; exact sixCol_rot_to_zero (sixCol x)
  apply valid_zero (rot_mem_interiorPts k hx) (rot_mem_interiorPts k hy) hcx hcy
  rw [dist_rot_left, norm_e, one_mul]; exact hd

end HadwigerNelson.Plane
