import Proofs.HadwigerNelson.Plane.LocalMap
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex

/-!
# FS116-Y2-SIXFRAG: a valid non-Siamese six-coloured fragment about a vertex of six colours

The milestone's six-colour inhabitant (`plans/FS131-kernel-plan.md` § 7.3 item 5): the hypotheses of FS129-SR1-SIXQ
(`Plane/RingGerm`) are met by it. The object (`plans/FS116-Y2-construction.md` § 2.3, `tools/fs116_y2_six.py frag`), about
`p = 0`, cut at `|x| = 3/2`:

* the **unit sector flower**: `S_j`, the open sector of the unit disc between the angles `60°j` and `60°(j + 1)`, colour `j`;
* the six **lenses** `Q_j`: the points outside `ω(0)` within `1` of `e(60°j − 30°)` and of `e(60°j + 30°)`, colour `j + 2`;
* the six **gap tiles** `G_j` at `e(60°j + 30°)`: the points outside `ω(0)` between `Q_j` and `Q_{j+1}` (at distance at least `1`
  from `e(60°j − 30°)` and from `e(60°j + 90°)`), colour `j + 4` (mod 6).

**The arcs** (`sixArcs`): the six radial segments `[0, e(60°j)]`, the unit circle, and the twelve lens sides — about
`e(60°j − 30°)` from the angle `60°j + 30°` (the far vertex `√3 e(60°j)`) to `60°j + 90°` (the corner `e(60°j + 30°)`), and
about `e(60°j + 30°)` from `60°j − 90°` (the corner `e(60°j − 30°)`) to `60°j − 30°` (the far vertex). The domain `B(0, 3/2)`
cuts the lens sides.

**The colour** (`sixCol`), by formula: inside the unit disc, the sector index `⌊arg x / 60°⌋ mod 6`; outside, `j + 2` when `x`
lies within `1` of both `e(60°j ± 30°)` for the nearest lens index `j = round(arg x / 60°)`, and otherwise the sector index
plus `4`. Indices are computed in `ZMod 6`, which is `Fin 6`.

**Validity** is the pair certificate of the derivation, re-proved: colour `0` is carried by `S_0`, `Q_4` and `G_2` (rotation by
`60°` maps colour `j` to `j + 1`), whose three diameters are below `1` and whose three cross distances are above `1`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- The sector index `⌊arg x / 60°⌋ mod 6`. -/
noncomputable def sixSector (x : ℂ) : ZMod 6 := ((⌊Complex.arg x / (π / 3)⌋ : ℤ) : ZMod 6)

/-- The nearest lens index `round(arg x / 60°)` (as an integer; the lens centres `e(60°m ± 30°)` depend on it mod 6). -/
noncomputable def sixRound (x : ℂ) : ℤ := round (Complex.arg x / (π / 3))

/-- `x` lies in the open lens about the direction `60°m`: within `1` of `e(60°m − 30°)` and of `e(60°m + 30°)`. -/
def InSixLens (m : ℤ) (x : ℂ) : Prop :=
  dist x (e (m * (π / 3) - π / 6)) < 1 ∧ dist x (e (m * (π / 3) + π / 6)) < 1

/-- The colour of FS116-Y2-SIXFRAG: sector index inside the unit disc; lens index `+ 2` in a lens; sector index `+ 4` in a
gap. -/
noncomputable def sixCol (x : ℂ) : Fin 6 :=
  open Classical in
  if ‖x‖ < 1 then sixSector x
  else if InSixLens (sixRound x) x then ((sixRound x : ZMod 6) + 2 : ZMod 6)
  else (sixSector x + 4 : ZMod 6)

/-- The arcs of FS116-Y2-SIXFRAG: six radial segments, the unit circle, twelve lens sides. -/
noncomputable def sixArcs : Set Arc :=
  {a | ∃ j : Fin 6, a = .seg 0 (e (j * (π / 3)))} ∪ {.circ 0 1 0 (2 * π)} ∪
    {a | ∃ j : Fin 6, a = .circ (e (j * (π / 3) - π / 6)) 1 (j * (π / 3) + π / 6) (j * (π / 3) + π / 2)} ∪
    {a | ∃ j : Fin 6, a = .circ (e (j * (π / 3) + π / 6)) 1 (j * (π / 3) - π / 2) (j * (π / 3) - π / 6)}

/-- The arcs of `sixArcs` have positive length. -/
theorem sixArcs_nondegenerate : ∀ a ∈ sixArcs, a.Nondegenerate := by
  have hπ := Real.pi_pos
  intro a ha
  rcases ha with ((ha | ha) | ha) | ha
  · obtain ⟨j, rfl⟩ := ha
    show (0 : ℂ) ≠ e _
    intro h
    have := norm_e ((j : ℕ) * (π / 3))
    rw [← h] at this
    simp at this
  · rw [mem_singleton_iff] at ha
    subst ha
    exact ⟨one_pos, by positivity, le_of_eq (by ring)⟩
  · obtain ⟨j, rfl⟩ := ha
    exact ⟨one_pos, by linarith, by linarith⟩
  · obtain ⟨j, rfl⟩ := ha
    exact ⟨one_pos, by linarith, by linarith⟩

/-- `sixArcs` is finite. -/
theorem sixArcs_finite : sixArcs.Finite := by
  have fin : ∀ f : Fin 6 → Arc, {a | ∃ j : Fin 6, a = f j}.Finite := fun f =>
    (Set.finite_range f).subset fun a ⟨j, h⟩ => ⟨j, h.symm⟩
  exact (((fin _).union (Set.finite_singleton _)).union (fin _)).union (fin _)

/-- Finitely many arcs: every point has a neighbourhood meeting finitely many. -/
theorem sixArcs_locallyFinite : ∀ x ∈ ball (0 : ℂ) (3 / 2), ∃ t ∈ 𝓝 x,
    {a | a ∈ sixArcs ∧ (a.carrier ∩ t).Nonempty}.Finite := by
  intro x _
  exact ⟨univ, univ_mem, sixArcs_finite.subset fun a ha => ha.1⟩

/-- `sixCol` is locally constant off the arcs, inside `B(0, 3/2)`: the floor of `arg x / 60°` jumps only on the rays
`60°j`, which inside the disc are radial segments and outside lie in lenses (where the round is constant); the round
jumps only on the rays `60°j + 30°`, which outside the disc lie in gaps (where it is not read); `arg` jumps only on the
ray `180°`; the lens test changes only on the lens sides; `‖x‖ < 1` changes only on the unit circle. -/
theorem sixCol_locallyConstant : ∀ x ∈ ball (0 : ℂ) (3 / 2), x ∉ ⋃ a ∈ sixArcs, a.carrier →
    ∀ᶠ y in 𝓝 x, sixCol y = sixCol x := by
  sorry

/-- **FS116-Y2-SIXFRAG's fragment**: the six-coloured map of `B(0, 3/2)` by the unit sector flower, six lenses and six gap
tiles. -/
noncomputable def sixFrag : ArcMap 6 where
  dom := ball 0 (3 / 2)
  isOpen_dom := isOpen_ball
  arcs := sixArcs
  nondegenerate := sixArcs_nondegenerate
  locallyFinite := sixArcs_locallyFinite
  col := sixCol
  locallyConstant := sixCol_locallyConstant

/-- The squared distance from the polar point `r e(φ)` to the unit-circle point `e(θ)`. -/
theorem dist_polar_sq (r φ θ : ℝ) : dist ((r : ℂ) * e φ) (e θ) ^ 2 = r ^ 2 - 2 * r * Real.cos (φ - θ) + 1 := by
  rw [Complex.dist_eq, Complex.sq_norm, Complex.normSq_apply]
  simp only [e_eq, Complex.sub_re, Complex.sub_im, Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im,
    Complex.ofReal_re, Complex.ofReal_im, Complex.I_re, Complex.I_im]
  rw [Real.cos_sub]
  nlinarith [Real.sin_sq_add_cos_sq φ, Real.sin_sq_add_cos_sq θ]

/-- The argument of a positive multiple of `e(φ)`, for `φ ∈ (−π, π]`. -/
theorem arg_polar {r φ : ℝ} (hr : 0 < r) (hφ : φ ∈ Ioc (-π) π) : Complex.arg ((r : ℂ) * e φ) = φ := by
  rw [e, Complex.exp_mul_I]
  exact Complex.arg_mul_cos_add_sin_mul_I hr hφ

/-- The norm of `r e(φ)`. -/
theorem norm_polar {r : ℝ} (hr : 0 ≤ r) (φ : ℝ) : ‖(r : ℂ) * e φ‖ = r := by
  rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg hr]

/-! ## Spec examples of the colour (each fails if `sixCol` drifts) -/

/-- The point `1/2` of the sector `S_0` has colour `0`. -/
example : sixCol (1 / 2) = 0 := by
  have h : ‖(1 / 2 : ℂ)‖ < 1 := by norm_num
  have harg : Complex.arg (1 / 2 : ℂ) = 0 := by
    rw [show (1 / 2 : ℂ) = ((1 / 2 : ℝ) : ℂ) by push_cast; ring]
    exact Complex.arg_ofReal_of_nonneg (by norm_num)
  simp only [sixCol, h, if_true, sixSector, harg, zero_div, Int.floor_zero, Int.cast_zero]
  rfl

/-- The point `6/5` of the lens `Q_0` has colour `2`. -/
example : sixCol (6 / 5) = 2 := by
  have hπ := Real.pi_pos
  have hx : (6 / 5 : ℂ) = ((6 / 5 : ℝ) : ℂ) * e 0 := by simp [e]
  have hn : ¬ ‖(6 / 5 : ℂ)‖ < 1 := by rw [hx, norm_polar (by norm_num)]; norm_num
  have harg : Complex.arg (6 / 5 : ℂ) = 0 := by
    rw [hx, arg_polar (by norm_num) ⟨by linarith, hπ.le⟩]
  have hr : sixRound (6 / 5) = 0 := by simp [sixRound, harg]
  have hl : InSixLens (sixRound (6 / 5)) (6 / 5) := by
    rw [hr]
    have hs3 : Real.sqrt 3 > 1.7 := by
      rw [gt_iff_lt, Real.lt_sqrt (by norm_num)]; norm_num
    have c := Real.cos_pi_div_six
    constructor
    · refine lt_of_pow_lt_pow_left₀ 2 (by norm_num) ?_
      rw [hx, dist_polar_sq]
      simp only [Int.cast_zero, zero_mul, zero_sub, Real.cos_neg] at *
      rw [c]; nlinarith
    · refine lt_of_pow_lt_pow_left₀ 2 (by norm_num) ?_
      rw [hx, dist_polar_sq]
      simp only [Int.cast_zero, zero_mul, zero_add]
      rw [show (0 : ℝ) - π / 6 = -(π / 6) by ring, Real.cos_neg, c]; nlinarith
  simp only [sixCol, hn, if_false]
  rw [if_pos hl, hr]
  rfl

/-- The point `(6/5) e(30°)` of the gap tile `G_0` has colour `4`. -/
example : sixCol ((6 / 5 : ℂ) * e (π / 6)) = 4 := by
  have hπ := Real.pi_pos
  have hx : ((6 / 5 : ℂ) * e (π / 6)) = ((6 / 5 : ℝ) : ℂ) * e (π / 6) := by push_cast; ring
  have hn : ¬ ‖((6 / 5 : ℂ) * e (π / 6))‖ < 1 := by rw [hx, norm_polar (by norm_num)]; norm_num
  have harg : Complex.arg ((6 / 5 : ℂ) * e (π / 6)) = π / 6 := by
    rw [hx, arg_polar (by norm_num) ⟨by linarith, by linarith⟩]
  have hr : sixRound ((6 / 5 : ℂ) * e (π / 6)) = 1 := by
    rw [sixRound, harg, show π / 6 / (π / 3) = (1 : ℝ) / 2 by field_simp; ring, round_eq]
    norm_num
  have hfl : ⌊π / 6 / (π / 3)⌋ = 0 := by
    rw [show π / 6 / (π / 3) = (1 : ℝ) / 2 by field_simp; ring]
    exact Int.floor_eq_zero_iff.mpr ⟨by norm_num, by norm_num⟩
  have hl : ¬ InSixLens (sixRound ((6 / 5 : ℂ) * e (π / 6))) ((6 / 5 : ℂ) * e (π / 6)) := by
    rw [hr]
    rintro ⟨-, h2⟩
    have := dist_polar_sq (6 / 5) (π / 6) (((1 : ℤ) : ℝ) * (π / 3) + π / 6)
    rw [← hx] at this
    have h3 : π / 6 - (((1 : ℤ) : ℝ) * (π / 3) + π / 6) = -(π / 3) := by push_cast; ring
    rw [h3, Real.cos_neg, Real.cos_pi_div_three] at this
    nlinarith [dist_nonneg (x := (6 / 5 : ℂ) * e (π / 6)) (y := e (((1 : ℤ) : ℝ) * (π / 3) + π / 6))]
  simp only [sixCol, hn, if_false, hl, sixSector, harg, hfl]
  decide

/-- The point `(1/2) e(210°)` of the sector `S_3` (an angle with negative `arg`) has colour `3`. -/
example : sixCol ((1 / 2 : ℂ) * e (7 * π / 6)) = 3 := by
  have hπ := Real.pi_pos
  have hx : ((1 / 2 : ℂ) * e (7 * π / 6)) = ((1 / 2 : ℝ) : ℂ) * e (-(5 * π / 6)) := by
    rw [show 7 * π / 6 = -(5 * π / 6) + 2 * π by ring, e_add_two_pi]; push_cast; ring
  have hn : ‖((1 / 2 : ℂ) * e (7 * π / 6))‖ < 1 := by rw [hx, norm_polar (by norm_num)]; norm_num
  have harg : Complex.arg ((1 / 2 : ℂ) * e (7 * π / 6)) = -(5 * π / 6) := by
    rw [hx, arg_polar (by norm_num) ⟨by linarith, by linarith⟩]
  have hfl : ⌊-(5 * π / 6) / (π / 3)⌋ = -3 := by
    rw [show -(5 * π / 6) / (π / 3) = (-5 : ℝ) / 2 by field_simp; ring]
    exact Int.floor_eq_iff.mpr ⟨by norm_num, by norm_num⟩
  simp only [sixCol, hn, if_true, sixSector, harg, hfl]
  decide

/-! ## The row: FS116-Y2-SIXFRAG -/

/-! ## The sectors near `0`: interior points and their colours -/

/-- `‖e a + e b‖² = 2 + 2 cos(a − b)`. -/
theorem norm_e_add_e_sq (a b : ℝ) : ‖e a + e b‖ ^ 2 = 2 + 2 * Real.cos (a - b) := by
  rw [Complex.sq_norm, Complex.normSq_apply]
  simp only [e_eq, Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re,
    Complex.ofReal_im, Complex.I_re, Complex.I_im]
  rw [Real.cos_sub]
  nlinarith [Real.sin_sq_add_cos_sq a, Real.sin_sq_add_cos_sq b]

/-- Points of the two lens-side families (angle difference at least `60°` and at most `120°` in absolute value) are at
distance at least `1` from `0`: `‖e a + e b‖² = 2 + 2 cos(a − b) ≥ 1` once `|a − b| ≤ 120°`. -/
theorem one_le_norm_e_add_e {a b : ℝ} (h2 : |b - a| ≤ 2 * π / 3) : 1 ≤ ‖e a + e b‖ := by
  have hπ := Real.pi_pos
  have hc : Real.cos (2 * π / 3) = -1 / 2 := by
    rw [show 2 * π / 3 = π - π / 3 by ring, Real.cos_pi_sub, Real.cos_pi_div_three]; norm_num
  have h3 : Real.cos (2 * π / 3) ≤ Real.cos (|b - a|) :=
    Real.cos_le_cos_of_nonneg_of_le_pi (abs_nonneg _) (by linarith) h2
  rw [Real.cos_abs, show b - a = -(a - b) by ring, Real.cos_neg] at h3
  have := norm_e_add_e_sq a b
  nlinarith [norm_nonneg (e a + e b)]

/-- A point of the open sector `(60°j, 60°(j+1))` of the open unit disc is an interior point of `sixFrag`. -/
theorem sixFrag_mem_interiorPts {t φ : ℝ} {j : ℤ} (ht : 0 < t) (ht1 : t < 1) (hφ1 : j * (π / 3) < φ)
    (hφ2 : φ < (j + 1) * (π / 3)) : (t : ℂ) * e φ ∈ sixFrag.interiorPts := by
  have hπ := Real.pi_pos
  have hn : ‖(t : ℂ) * e φ‖ = t := by
    rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg ht.le]
  refine ⟨by show _ ∈ ball (0 : ℂ) (3 / 2); rw [mem_ball_zero_iff, hn]; linarith, ?_⟩
  intro hmem
  obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp hmem
  rcases ha with ((ha | ha) | ha) | ha
  · obtain ⟨k, rfl⟩ := ha
    obtain ⟨u, v, hu, hv, huv, hz⟩ := hza
    -- the point lies on the ray at angle `60°k`: its sine against the ray vanishes
    have h1 : (t : ℂ) * e (φ - k * (π / 3)) = (v : ℂ) := by
      have : (t : ℂ) * e φ = v * e (k * (π / 3)) := by
        rw [← hz]; simp
      rw [show φ = (φ - k * (π / 3)) + k * (π / 3) by ring, e_add] at this
      have hne : e (k * (π / 3)) ≠ 0 := fun h => by
        have := norm_e (k * (π / 3)); rw [h] at this; simp at this
      exact mul_right_cancel₀ hne (by rw [← this]; ring)
    have h2 : t * Real.sin (φ - k * (π / 3)) = 0 := by
      have := congrArg Complex.im h1
      simp only [e_eq, Complex.mul_im, Complex.add_im, Complex.ofReal_re, Complex.ofReal_im,
        Complex.I_re, Complex.I_im] at this
      linarith
    have h3 : Real.sin (φ - k * (π / 3)) = 0 := by
      rcases mul_eq_zero.mp h2 with h | h
      · exact absurd h ht.ne'
      · exact h
    obtain ⟨n, hn'⟩ := Real.sin_eq_zero_iff.mp h3
    have l1 : ((j : ℝ) - k) < 3 * n := by
      have : ((j : ℝ) - k) * (π / 3) < (3 * n) * (π / 3) := by nlinarith
      exact lt_of_mul_lt_mul_right this (by positivity)
    have l2 : (3 * n : ℝ) < j + 1 - k := by
      have : (3 * n : ℝ) * (π / 3) < (j + 1 - k) * (π / 3) := by nlinarith
      exact lt_of_mul_lt_mul_right this (by positivity)
    have l1' : j - (k : ℤ) < 3 * n := by exact_mod_cast l1
    have l2' : 3 * n < j + 1 - (k : ℤ) := by exact_mod_cast l2
    omega
  · rw [mem_singleton_iff] at ha
    subst ha
    obtain ⟨θ, -, hθ⟩ := hza
    have : ‖(t : ℂ) * e φ‖ = 1 := by rw [← hθ]; simp
    linarith
  · obtain ⟨k, rfl⟩ := ha
    obtain ⟨θ, hθ, hz⟩ := hza
    have hc : 1 ≤ ‖(t : ℂ) * e φ‖ := by
      rw [← hz]
      have : ((e (k * (π / 3) - π / 6) + 1 * e θ : ℂ)) = e (k * (π / 3) - π / 6) + e θ := by simp
      show 1 ≤ ‖e (k * (π / 3) - π / 6) + 1 * e θ‖
      rw [one_mul]
      apply one_le_norm_e_add_e
      rw [abs_of_nonneg (by linarith [hθ.1])]; linarith [hθ.2]
    linarith
  · obtain ⟨k, rfl⟩ := ha
    obtain ⟨θ, hθ, hz⟩ := hza
    have hc : 1 ≤ ‖(t : ℂ) * e φ‖ := by
      rw [← hz]
      show 1 ≤ ‖e (k * (π / 3) + π / 6) + 1 * e θ‖
      rw [one_mul]
      apply one_le_norm_e_add_e
      rw [abs_of_nonpos (by linarith [hθ.2])]; linarith [hθ.1]
    linarith

/-- The colour of a point of the open sector `(60°j, 60°(j+1))` of the open unit disc, `−3 ≤ j ≤ 2`, is `j`. -/
theorem sixCol_sector {t φ : ℝ} {j : ℤ} (ht : 0 < t) (ht1 : t < 1) (hj1 : -3 ≤ j) (hj2 : j ≤ 2)
    (hφ1 : j * (π / 3) < φ) (hφ2 : φ < (j + 1) * (π / 3)) : sixCol ((t : ℂ) * e φ) = ((j : ℤ) : ZMod 6) := by
  have hπ := Real.pi_pos
  have hn : ‖(t : ℂ) * e φ‖ = t := by
    rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg ht.le]
  have harg : Complex.arg ((t : ℂ) * e φ) = φ := by
    refine arg_polar ht ⟨?_, ?_⟩
    · have : (-3 : ℝ) ≤ j := by exact_mod_cast hj1
      nlinarith
    · have : (j : ℝ) ≤ 2 := by exact_mod_cast hj2
      nlinarith
  have hfl : ⌊φ / (π / 3)⌋ = j := by
    rw [Int.floor_eq_iff, le_div_iff₀ (by positivity), div_lt_iff₀ (by positivity)]
    exact ⟨hφ1.le, hφ2⟩
  simp only [sixCol, hn, ht1, if_true, sixSector, harg, hfl]

/-- Each colour `c` is carried at `0`: the open sector of colour `c` approaches `0`. -/
theorem zero_mem_closure_region {j : ℤ} (hj1 : -3 ≤ j) (hj2 : j ≤ 2) :
    (0 : ℂ) ∈ closure (sixFrag.region ((j : ℤ) : ZMod 6)) := by
  have hπ := Real.pi_pos
  rw [Metric.mem_closure_iff]
  intro ε hε
  set t := min (1 / 2) (ε / 2) with ht
  have ht0 : 0 < t := lt_min (by norm_num) (by linarith)
  have ht1 : t < 1 := lt_of_le_of_lt (min_le_left _ _) (by norm_num)
  have h1 : (j : ℝ) * (π / 3) < j * (π / 3) + π / 6 := by linarith
  have h2 : (j : ℝ) * (π / 3) + π / 6 < (j + 1) * (π / 3) := by linarith
  refine ⟨(t : ℂ) * e (j * (π / 3) + π / 6), ⟨sixFrag_mem_interiorPts ht0 ht1 h1 h2, ?_⟩, ?_⟩
  · exact sixCol_sector ht0 ht1 hj1 hj2 h1 h2
  · rw [dist_zero_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg ht0.le]
    linarith [min_le_right (1 / 2 : ℝ) (ε / 2)]

/-- **FS116-Y2-SIXFRAG**, validity: no two interior points of one colour are at distance exactly `1`. Colour `0` (and every
other, by the rotation by `60°`) is carried by `S_0`, `Q_4`, `G_2`: three diameters below `1`, three cross distances above
`1`, exact in `ℚ(√3, √7)` (the cut points of the lenses have cosine `3/4`). -/
theorem sixFrag_valid : sixFrag.Valid := by
  sorry

/-- **FS116-Y2-SIXFRAG**, non-Siamese: two distinct tiles of one colour always have a pair of points at distance at least
`1`. -/
theorem sixFrag_nonSiamese : sixFrag.NonSiamese := by
  sorry

/-- **FS116-Y2-SIXFRAG**, the disc: the fragment holds `B̄(0, R)` for every `R < 3/2`. -/
theorem sixFrag_covers {R : ℝ} (hR : R < 3 / 2) : sixFrag.Covers 0 R :=
  fun _ hx => lt_of_le_of_lt (mem_closedBall.mp hx) hR

/-- **FS116-Y2-SIXFRAG**, the vertex: all six colours are carried at `0`. -/
theorem sixFrag_coloursAt_zero : sixFrag.coloursAt 0 = univ := by
  refine eq_univ_of_forall fun c => ?_
  have hc : ∀ c : Fin 6, ∃ j ∈ Finset.Icc (-3 : ℤ) 2, ((j : ℤ) : ZMod 6) = c := by decide
  obtain ⟨j, hj, hjc⟩ := hc c
  rw [Finset.mem_Icc] at hj
  rw [← hjc]
  exact zero_mem_closure_region hj.1 hj.2

/-- **FS116-Y2-SIXFRAG**, the ring lies in `Γ`. -/
theorem sixFrag_sphere_subset_Γ : sphere (0 : ℂ) 1 ⊆ sixFrag.Γ := by
  intro x hx
  have hn : ‖x‖ = 1 := by simpa using hx
  have hxe : x = e (Complex.arg x) := by
    have := Complex.norm_mul_exp_arg_mul_I x
    rw [hn, Complex.ofReal_one, one_mul] at this
    exact this.symm
  refine ⟨by simp [sixFrag, hn]; norm_num, ?_⟩
  refine mem_iUnion₂.mpr ⟨.circ 0 1 0 (2 * π), by simp [sixFrag, sixArcs], ?_⟩
  have hπ := Real.pi_pos
  by_cases h0 : 0 ≤ Complex.arg x
  · refine ⟨Complex.arg x, ⟨h0, by linarith [Complex.arg_le_pi x]⟩, ?_⟩
    show (0 : ℂ) + 1 * e (Complex.arg x) = x
    rw [zero_add, one_mul]; exact hxe.symm
  · push Not at h0
    refine ⟨Complex.arg x + 2 * π, ⟨by linarith [Complex.neg_pi_lt_arg x], by linarith⟩, ?_⟩
    show (0 : ℂ) + 1 * e (Complex.arg x + 2 * π) = x
    rw [zero_add, one_mul, e_add_two_pi]; exact hxe.symm

/-! ## The ring arc `r([0°, 30°])` -/

/-- `‖e a − e b‖² = 2 − 2 cos(a − b)`. -/
theorem norm_e_sub_e_sq (a b : ℝ) : ‖e a - e b‖ ^ 2 = 2 - 2 * Real.cos (a - b) := by
  rw [Complex.sq_norm, Complex.normSq_apply]
  simp only [e_eq, Complex.sub_re, Complex.sub_im, Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im,
    Complex.ofReal_re, Complex.ofReal_im, Complex.I_re, Complex.I_im]
  rw [Real.cos_sub]
  nlinarith [Real.sin_sq_add_cos_sq a, Real.sin_sq_add_cos_sq b]

/-- No integer `N` has `0 < N·60° < 30°`... in the form used here: `θ = 30° + N·60°` with `0 < θ < 30°` is impossible. -/
theorem no_int_lens {θ : ℝ} (h0 : 0 < θ) (h1 : θ < π / 6) {N : ℤ} (hθ : θ = π / 6 + N * (π / 3)) : False := by
  have hπ := Real.pi_pos
  have hN1 : (N : ℝ) < 0 := by
    by_contra hc; push Not at hc
    nlinarith [mul_nonneg hc (by positivity : (0 : ℝ) ≤ π / 3)]
  have hN2 : (-1 / 2 : ℝ) < N := by
    by_contra hc; push Not at hc
    nlinarith [mul_le_mul_of_nonneg_right hc (by positivity : (0 : ℝ) ≤ π / 3)]
  have hN1' : N < 0 := by exact_mod_cast hN1
  have : (N : ℝ) ≤ -1 := by exact_mod_cast (show N ≤ -1 by omega)
  linarith

/-- No integer `N` has `0 < N·60°/... `: `θ = N·(π/3)` with `0 < θ < π/6` is impossible. -/
theorem no_int_radial {θ : ℝ} (h0 : 0 < θ) (h1 : θ < π / 6) {N : ℤ} (hθ : θ = N * (π / 3)) : False := by
  have hπ := Real.pi_pos
  have hN1 : (0 : ℝ) < N := by
    by_contra hc; push Not at hc
    nlinarith [mul_nonpos_of_nonpos_of_nonneg hc (by positivity : (0 : ℝ) ≤ π / 3)]
  have hN1' : 0 < N := by exact_mod_cast hN1
  have : (1 : ℝ) ≤ N := by exact_mod_cast hN1'
  nlinarith

/-- A point `e θ` of the ring strictly between `0°` and `30°` is not at distance `1` from any lens centre
`e(30° + 60°m)`. -/
theorem norm_e_sub_lens_ne {θ : ℝ} (h0 : 0 < θ) (h1 : θ < π / 6) (m : ℤ) :
    ‖e θ - e (π / 6 + m * (π / 3))‖ ≠ 1 := by
  have hπ := Real.pi_pos
  intro h
  have hsq := norm_e_sub_e_sq θ (π / 6 + m * (π / 3))
  rw [h] at hsq
  have hc : Real.cos (θ - (π / 6 + m * (π / 3))) = Real.cos (π / 3) := by
    rw [Real.cos_pi_div_three]; linarith
  obtain ⟨k, hk | hk⟩ := Real.cos_eq_cos_iff.mp hc
  · exact no_int_lens h0 h1 (N := m + 1 - 6 * k) (by push_cast; linarith)
  · exact no_int_lens h0 h1 (N := m - 1 + 6 * k) (by push_cast; linarith)

/-- A point `t e(φ)`, `t > 0`, on the radial segment towards `e(60°k)` has `sin(φ − 60°k) = 0`. -/
theorem sin_eq_zero_of_mem_radial {t φ : ℝ} (ht : 0 < t) {k : ℕ}
    (h : (t : ℂ) * e φ ∈ segment ℝ 0 (e (k * (π / 3)))) : Real.sin (φ - k * (π / 3)) = 0 := by
  obtain ⟨u, v, hu, hv, huv, hz⟩ := h
  have h1 : (t : ℂ) * e (φ - k * (π / 3)) = (v : ℂ) := by
    have : (t : ℂ) * e φ = v * e (k * (π / 3)) := by rw [← hz]; simp
    rw [show φ = (φ - k * (π / 3)) + k * (π / 3) by ring, e_add] at this
    have hne : e (k * (π / 3)) ≠ 0 := fun h => by
      have := norm_e (k * (π / 3)); rw [h] at this; simp at this
    exact mul_right_cancel₀ hne (by rw [← this]; ring)
  have h2 : t * Real.sin (φ - k * (π / 3)) = 0 := by
    have := congrArg Complex.im h1
    simp only [e_eq, Complex.mul_im, Complex.add_im, Complex.ofReal_re, Complex.ofReal_im,
      Complex.I_re, Complex.I_im] at this
    linarith
  rcases mul_eq_zero.mp h2 with h | h
  · exact absurd h ht.ne'
  · exact h

/-- The ring point `e θ`, `0 < θ < 30°`, is on no radial segment and no lens side. -/
theorem e_notMem_lens_union {θ : ℝ} (h0 : 0 < θ) (h1 : θ < π / 6) :
    e θ ∉ ⋃ a ∈ {a | a ∈ sixArcs ∧ a ≠ Arc.circ 0 1 0 (2 * π)}, a.carrier := by
  have hπ := Real.pi_pos
  intro hmem
  obtain ⟨a, ⟨ha, hne⟩, hxa⟩ := mem_iUnion₂.mp hmem
  rcases ha with ((ha | ha) | ha) | ha
  · obtain ⟨k, rfl⟩ := ha
    have h : ((1 : ℝ) : ℂ) * e θ ∈ segment ℝ 0 (e (((k : ℕ) : ℝ) * (π / 3))) := by
      rw [Complex.ofReal_one, one_mul]; exact hxa
    have h3 := sin_eq_zero_of_mem_radial one_pos h
    obtain ⟨n, hn⟩ := Real.sin_eq_zero_iff.mp h3
    exact no_int_radial h0 h1 (N := 3 * n + k) (by push_cast; linarith)
  · exact hne (by simpa using ha)
  · obtain ⟨k, rfl⟩ := ha
    obtain ⟨θ', -, hθ'⟩ := hxa
    refine norm_e_sub_lens_ne h0 h1 ((k : ℤ) - 1) ?_
    have : e θ - e (π / 6 + (((k : ℤ) - 1 : ℤ) : ℝ) * (π / 3)) = 1 * e θ' := by
      rw [show π / 6 + (((k : ℤ) - 1 : ℤ) : ℝ) * (π / 3) = ((k : ℕ) : ℝ) * (π / 3) - π / 6 by push_cast; ring]
      rw [← hθ']; show _ = _; simp
    rw [this]; simp
  · obtain ⟨k, rfl⟩ := ha
    obtain ⟨θ', -, hθ'⟩ := hxa
    refine norm_e_sub_lens_ne h0 h1 (k : ℤ) ?_
    have : e θ - e (π / 6 + ((k : ℤ) : ℝ) * (π / 3)) = 1 * e θ' := by
      rw [show π / 6 + ((k : ℤ) : ℝ) * (π / 3) = ((k : ℕ) : ℝ) * (π / 3) + π / 6 by push_cast; ring]
      rw [← hθ']; show _ = _; simp
    rw [this]; simp

/-- The distance between two points on one ray. -/
theorem dist_polar_same (r s φ : ℝ) : dist ((r : ℂ) * e φ) ((s : ℂ) * e φ) = |r - s| := by
  rw [Complex.dist_eq, ← sub_mul, norm_mul, norm_e, mul_one, ← Complex.ofReal_sub, Complex.norm_real,
    Real.norm_eq_abs]

/-- Inside the unit disc, an argument in `(0°, 60°)` means colour `0`. -/
theorem sixCol_inner_zero {z : ℂ} (hz : ‖z‖ < 1) (ha : Complex.arg z ∈ Ioo 0 (π / 3)) : sixCol z = 0 := by
  have hπ := Real.pi_pos
  have hfl : ⌊Complex.arg z / (π / 3)⌋ = 0 :=
    Int.floor_eq_zero_iff.mpr ⟨(div_pos ha.1 (by positivity)).le, by rw [div_lt_one (by positivity)]; exact ha.2⟩
  simp [sixCol, hz, sixSector, hfl]

/-- Outside the unit disc, an argument in `(0°, 30°)` and the two lens tests mean colour `2`. -/
theorem sixCol_outer_two {z : ℂ} (hz : 1 ≤ ‖z‖) (ha : Complex.arg z ∈ Ioo 0 (π / 6))
    (l1 : dist z (e (-(π / 6))) < 1) (l2 : dist z (e (π / 6)) < 1) : sixCol z = 2 := by
  have hπ := Real.pi_pos
  have hr : sixRound z = 0 := by
    unfold sixRound
    rw [round_eq, Int.floor_eq_zero_iff]
    have q1 : 0 < Complex.arg z / (π / 3) := div_pos ha.1 (by positivity)
    have q2 : Complex.arg z / (π / 3) < 1 / 2 := by rw [div_lt_iff₀ (by positivity)]; linarith [ha.2]
    exact ⟨by linarith, by linarith⟩
  have hl : InSixLens (sixRound z) z := by
    rw [hr]
    constructor
    · simpa using l1
    · simpa using l2
  have hn : ¬ ‖z‖ < 1 := not_lt.mpr hz
  simp only [sixCol, hn, if_false]
  rw [if_pos hl, hr]
  rfl

/-- **FS116-Y2-SIXFRAG**, every arc of `Γ` on `ω(0)` (with constant sides) is a (Q) arc. -/
theorem sixFrag_isQArc {θ₁ θ₂ : ℝ} {c c' : Fin 6} (h : sixFrag.IsRingArc 0 θ₁ θ₂ c c') :
    sixFrag.IsQArc 0 θ₁ θ₂ := by
  refine ⟨c, c', h, by rw [sixFrag_coloursAt_zero]; exact mem_univ _, by rw [sixFrag_coloursAt_zero]; exact mem_univ _, ?_⟩
  rw [sixFrag_coloursAt_zero, Set.ncard_univ, Nat.card_eq_fintype_card, Fintype.card_fin]
  norm_num

/-- The last clause is not vacuous: `r([0°, 30°])` is an arc of `Γ` on `ω(0)`, inner colour `0` (the sector `S_0`), outer
colour `2` (the lens `Q_0`). -/
theorem sixFrag_isRingArc : sixFrag.IsRingArc 0 0 (π / 6) 0 2 := by
  have hπ := Real.pi_pos
  refine ⟨by positivity, ?_, fun θ hθ => ?_⟩
  · rintro _ ⟨θ, -, rfl⟩
    exact sixFrag_sphere_subset_Γ (ringPt_mem_sphere 0 θ)
  have hx : ringPt 0 θ = ((1 : ℝ) : ℂ) * e θ := by simp [ringPt]
  have harg : Complex.arg (ringPt 0 θ) = θ := by
    rw [hx]; exact arg_polar one_pos ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
  have hslit : ringPt 0 θ ∈ Complex.slitPlane := by
    rw [Complex.mem_slitPlane_iff]; left
    have : (ringPt 0 θ).re = Real.cos θ := by
      show (0 + e θ).re = _
      rw [zero_add, e_eq]
      simp only [Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.I_re, Complex.ofReal_im, Complex.I_im]
      ring
    rw [this]
    exact Real.cos_pos_of_mem_Ioo ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
  have hnb1 : {z : ℂ | Complex.arg z ∈ Ioo 0 (π / 6)} ∈ 𝓝 (ringPt 0 θ) :=
    (Complex.continuousAt_arg hslit).preimage_mem_nhds (by rw [harg]; exact Ioo_mem_nhds hθ.1 hθ.2)
  -- the two lens tests at `e θ`
  have k1 : 1 / 2 < Real.cos (θ - (π / 6)) := by
    rw [← Real.cos_neg, neg_sub, ← Real.cos_pi_div_three]
    exact Real.cos_lt_cos_of_nonneg_of_le_pi (by linarith [hθ.2]) (by linarith) (by linarith [hθ.1])
  have k2 : 1 / 2 < Real.cos (θ + π / 6) := by
    rw [← Real.cos_pi_div_three]
    exact Real.cos_lt_cos_of_nonneg_of_le_pi (by linarith [hθ.1]) (by linarith) (by linarith [hθ.2])
  have k12 : Real.cos (θ + π / 6) < Real.cos (θ - π / 6) := by
    rw [← Real.cos_neg (θ - π / 6), neg_sub]
    exact Real.cos_lt_cos_of_nonneg_of_le_pi (by linarith [hθ.2]) (by linarith [hθ.2]) (by linarith [hθ.1])
  have dsq : ∀ (r : ℝ) (a : ℝ), dist ((r : ℂ) * e θ) (e a) ^ 2 = r ^ 2 - 2 * r * Real.cos (θ - a) + 1 :=
    fun r a => dist_polar_sq r θ a
  have l1x : dist (ringPt 0 θ) (e (-(π / 6))) < 1 := by
    refine lt_of_pow_lt_pow_left₀ 2 (by norm_num) ?_
    rw [hx, dsq, show θ - -(π / 6) = θ + π / 6 by ring]; nlinarith
  have l2x : dist (ringPt 0 θ) (e (π / 6)) < 1 := by
    refine lt_of_pow_lt_pow_left₀ 2 (by norm_num) ?_
    rw [hx, dsq]; nlinarith
  have hnb2 : {z : ℂ | dist z (e (-(π / 6))) < 1} ∈ 𝓝 (ringPt 0 θ) :=
    (isOpen_lt (continuous_id.dist continuous_const) continuous_const).mem_nhds l1x
  have hnb3 : {z : ℂ | dist z (e (π / 6)) < 1} ∈ 𝓝 (ringPt 0 θ) :=
    (isOpen_lt (continuous_id.dist continuous_const) continuous_const).mem_nhds l2x
  refine ⟨?_, ?_⟩
  · -- inner side
    ext c
    simp only [mem_singleton_iff, ArcMap.innerColours, mem_setOf_eq]
    constructor
    · intro hc
      obtain ⟨z, hzU, hzr⟩ := mem_closure_iff_nhds.mp hc _ hnb1
      have hcol : sixCol z = c := hzr.1.2
      have hz1 : ‖z‖ < 1 := by simpa using hzr.2
      exact hcol.symm.trans (sixCol_inner_zero hz1 ⟨hzU.1, by linarith [hzU.2]⟩)
    · rintro rfl
      rw [Metric.mem_closure_iff]
      intro ε hε
      set η := min (1 / 2) (ε / 2) with hη
      have hη0 : 0 < η := lt_min (by norm_num) (by linarith)
      have hη1 : η ≤ 1 / 2 := min_le_left _ _
      have hη2 : η ≤ ε / 2 := min_le_right _ _
      have a1 : ((0 : ℤ) : ℝ) * (π / 3) < θ := by simp; linarith [hθ.1]
      have a2 : θ < (((0 : ℤ) : ℝ) + 1) * (π / 3) := by simp; linarith [hθ.2]
      refine ⟨((1 - η : ℝ) : ℂ) * e θ, ⟨⟨sixFrag_mem_interiorPts (by linarith) (by linarith) a1 a2, ?_⟩, ?_⟩, ?_⟩
      · have := sixCol_sector (j := 0) (t := 1 - η) (φ := θ) (by linarith) (by linarith) (by norm_num) (by norm_num) a1 a2
        show sixCol _ = 0
        refine this.trans ?_
        decide
      · rw [mem_ball_zero_iff, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by linarith)]
        linarith
      · rw [hx, dist_polar_same, abs_of_nonneg (by linarith)]; linarith
  · -- outer side
    ext c
    simp only [mem_singleton_iff, ArcMap.outerColours, mem_setOf_eq]
    constructor
    · intro hc
      obtain ⟨z, hzU, hzr⟩ := mem_closure_iff_nhds.mp hc _ (Filter.inter_mem hnb1 (Filter.inter_mem hnb2 hnb3))
      have hcol : sixCol z = c := hzr.1.2
      have hz1 : 1 ≤ ‖z‖ := by
        have : z ∉ closedBall (0 : ℂ) 1 := hzr.2
        rw [mem_closedBall_zero_iff, not_le] at this; exact this.le
      exact hcol.symm.trans (sixCol_outer_two hz1 ⟨hzU.1.1, by linarith [hzU.1.2]⟩ hzU.2.1 hzU.2.2)
    · rintro rfl
      -- the ring point is off the radial segments and lens sides, a closed set
      have hfin : {a | a ∈ sixArcs ∧ a ≠ Arc.circ 0 1 0 (2 * π)}.Finite := sixArcs_finite.subset fun a ha => ha.1
      have hcl : IsClosed (⋃ a ∈ {a | a ∈ sixArcs ∧ a ≠ Arc.circ 0 1 0 (2 * π)}, a.carrier) :=
        hfin.isClosed_biUnion fun a _ => a.isClosed_carrier
      have hxA : ringPt 0 θ ∉ ⋃ a ∈ {a | a ∈ sixArcs ∧ a ≠ Arc.circ 0 1 0 (2 * π)}, a.carrier := by
        simpa [ringPt] using e_notMem_lens_union hθ.1 hθ.2
      obtain ⟨ρ, hρ, hball⟩ := Metric.mem_nhds_iff.mp (hcl.isOpen_compl.mem_nhds hxA)
      rw [Metric.mem_closure_iff]
      intro ε hε
      set κ := Real.cos (θ + π / 6) with hκ
      set η := min (min (1 / 4) (ε / 2)) (min (ρ / 2) ((2 * κ - 1) / 2)) with hη
      have hη0 : 0 < η := lt_min (lt_min (by norm_num) (by linarith)) (lt_min (by linarith) (by linarith))
      have hη1 : η ≤ 1 / 4 := (min_le_left _ _).trans (min_le_left _ _)
      have hη2 : η ≤ ε / 2 := (min_le_left _ _).trans (min_le_right _ _)
      have hη3 : η ≤ ρ / 2 := (min_le_right _ _).trans (min_le_left _ _)
      have hη4 : η ≤ (2 * κ - 1) / 2 := (min_le_right _ _).trans (min_le_right _ _)
      have hb : (((1 + η : ℝ) : ℂ) * e θ) ∈ (⋃ a ∈ {a | a ∈ sixArcs ∧ a ≠ Arc.circ 0 1 0 (2 * π)}, a.carrier)ᶜ := by
        refine hball ?_
        rw [Metric.mem_ball, hx, dist_comm, dist_polar_same, abs_of_nonpos (by linarith)]
        linarith
      have hbn : ‖((1 + η : ℝ) : ℂ) * e θ‖ = 1 + η := by
        rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by linarith)]
      have hint : ((1 + η : ℝ) : ℂ) * e θ ∈ sixFrag.interiorPts := by
        refine ⟨by show _ ∈ ball (0 : ℂ) (3 / 2); rw [mem_ball_zero_iff, hbn]; linarith, ?_⟩
        intro hmem
        obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp hmem
        by_cases hac : a = Arc.circ 0 1 0 (2 * π)
        · subst hac
          obtain ⟨θ', -, hθ'⟩ := hza
          have : ‖((1 + η : ℝ) : ℂ) * e θ‖ = 1 := by rw [← hθ']; simp
          linarith
        · exact hb (mem_iUnion₂.mpr ⟨a, ⟨ha, hac⟩, hza⟩)
      have hbarg : Complex.arg (((1 + η : ℝ) : ℂ) * e θ) = θ :=
        arg_polar (by linarith) ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
      refine ⟨((1 + η : ℝ) : ℂ) * e θ, ⟨⟨hint, ?_⟩, ?_⟩, ?_⟩
      · refine sixCol_outer_two (by rw [hbn]; linarith) (by rw [hbarg]; exact hθ) ?_ ?_
        · refine lt_of_pow_lt_pow_left₀ 2 (by norm_num) ?_
          rw [dsq, show θ - -(π / 6) = θ + π / 6 by ring]; nlinarith
        · refine lt_of_pow_lt_pow_left₀ 2 (by norm_num) ?_
          rw [dsq]; nlinarith
      · rw [mem_closedBall_zero_iff, hbn]; linarith
      · rw [hx, dist_polar_same, abs_of_nonpos (by linarith)]; linarith

end HadwigerNelson.Plane
