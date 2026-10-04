import Proofs.HadwigerNelson.Plane.ValidMap.Basic

/-!
# Stuck chains: the curvature inequalities (FS110-N4-FIN, FS112-N2-RAY)

Wave 4's skeleton (`plans/FS131-w4-kernel-plan.md` § 3). Along a stuck chain `P_k = v + kn` the horn of `P_k` has lower and
upper upward curvatures `λ_k < υ_k` in `(−1, 1)`, and the shadows of the neighbouring horns give `λ_k ≤ f(λ_{k+1})` and
`f̃(υ_{k−1}) ≤ υ_k` (`curvDown`, `curvUp`). **FS110-N4-FIN**: no bi-infinite sequence satisfies them. **FS112-N2-RAY** (ruling
R9, its mathematics only): the one-sided chain `λ_k = −1/(k+1)`, `υ_k = 0` satisfies every inequality with every shadow tight,
so FIN's contradiction does not reach a chain with an end; its lower arcs are the pencil of circles of radius `k + 1` about
`P_{−1}`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set

/-- `1/f̃(υ) = 1/υ − 1`: the upward map shortens the reciprocal curvature by one (the engine of FIN's upward half). -/
theorem inv_curvUp {u : ℝ} (hu0 : u ≠ 0) : 1 / curvUp u = 1 / u - 1 := by
  unfold curvUp
  rw [one_div_div]
  field_simp

/-- `1/f(λ) = 1/λ + 1`: the downward map lengthens the reciprocal curvature by one (the engine of FIN's downward half). -/
theorem inv_curvDown {l : ℝ} (hl0 : l ≠ 0) (hl1 : 1 + l ≠ 0) : 1 / curvDown l = 1 / l + 1 := by
  unfold curvDown
  rw [one_div_div]
  field_simp

/-- **FIN, upward half**: under FIN's inequalities every `υ_k` is `≤ 0` — a positive `υ_m` would give `1/υ_{m+j} ≤ 1/υ_m − j`
(`inv_curvUp`) and `υ_{m+j} > 0`, impossible for `j > 1/υ_m`. -/
theorem n4_fin_u_nonpos (l u : ℤ → ℝ)
    (h : ∀ k, -1 < l k ∧ l k < u k ∧ u k < 1 ∧ l k ≤ curvDown (l (k + 1)) ∧ curvUp (u (k - 1)) ≤ u k) (m : ℤ) :
    u m ≤ 0 := by
  by_contra hpos
  rw [not_le] at hpos
  have key : ∀ j : ℕ, 0 < u (m + j) ∧ 1 / u (m + j) ≤ 1 / u m - j := by
    intro j
    induction j with
    | zero => simp [hpos]
    | succ j ih =>
      obtain ⟨ih0, ih1⟩ := ih
      have hlt : u (m + j) < 1 := (h _).2.2.1
      have hstep : curvUp (u (m + j)) ≤ u (m + ((j + 1 : ℕ) : ℤ)) := by
        have := (h (m + ((j + 1 : ℕ) : ℤ))).2.2.2.2
        have e : m + ((j + 1 : ℕ) : ℤ) - 1 = m + j := by push_cast; ring
        rwa [e] at this
      have hpos' : 0 < curvUp (u (m + j)) := by
        unfold curvUp; exact div_pos ih0 (by linarith)
      refine ⟨lt_of_lt_of_le hpos' hstep, ?_⟩
      have h2 : 1 / u (m + ((j + 1 : ℕ) : ℤ)) ≤ 1 / curvUp (u (m + j)) :=
        one_div_le_one_div_of_le hpos' hstep
      rw [inv_curvUp ih0.ne'] at h2
      have e2 : ((j + 1 : ℕ) : ℝ) = j + 1 := by push_cast; ring
      rw [e2]
      linarith
  obtain ⟨j, hj⟩ := exists_nat_gt (1 / u m)
  obtain ⟨k0, k1⟩ := key j
  have : 0 < 1 / u (m + j) := one_div_pos.mpr k0
  linarith

/-- **FS110-N4-FIN**: no bi-infinite sequence `−1 < λ_k < υ_k < 1` with `λ_k ≤ f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`. -/
theorem n4_fin : ¬ ∃ l u : ℤ → ℝ, ∀ k, -1 < l k ∧ l k < u k ∧ u k < 1 ∧ l k ≤ curvDown (l (k + 1)) ∧
    curvUp (u (k - 1)) ≤ u k := by
  rintro ⟨l, u, h⟩
  have hneg : ∀ k, l k < 0 := fun k => lt_of_lt_of_le (h k).2.1 (n4_fin_u_nonpos l u h k)
  have key : ∀ j : ℕ, 1 / l 0 + j ≤ 1 / l (0 - j) := by
    intro j
    induction j with
    | zero => simp
    | succ j ih =>
      have hk := h (0 - ((j + 1 : ℕ) : ℤ))
      have e : 0 - ((j + 1 : ℕ) : ℤ) + 1 = 0 - j := by push_cast; ring
      have hstep : l (0 - ((j + 1 : ℕ) : ℤ)) ≤ curvDown (l (0 - j)) := by
        have := hk.2.2.2.1
        rwa [e] at this
      have hl1 : 1 + l (0 - (j : ℤ)) ≠ 0 := by have := (h (0 - (j : ℤ))).1; linarith
      have hfneg : curvDown (l (0 - (j : ℤ))) < 0 := by
        unfold curvDown
        exact div_neg_of_neg_of_pos (hneg _) (by linarith [(h (0 - (j : ℤ))).1])
      have h2 : 1 / curvDown (l (0 - (j : ℤ))) ≤ 1 / l (0 - ((j + 1 : ℕ) : ℤ)) :=
        one_div_le_one_div_of_neg_of_le hfneg hstep
      rw [inv_curvDown (hneg _).ne hl1] at h2
      have e2 : ((j + 1 : ℕ) : ℝ) = j + 1 := by push_cast; ring
      rw [e2]
      linarith
  obtain ⟨j, hj⟩ := exists_nat_gt (-(1 / l 0))
  have h1 := key j
  have : 1 / l (0 - (j : ℤ)) < 0 := one_div_neg.mpr (hneg _)
  linarith

/-- `f̃` inverts `f` on `(−1, ∞)` (FS110-N4-SHADOW's bookkeeping: the centre stays put, the radius changes by `1`). -/
theorem curvUp_curvDown {l : ℝ} (hl : -1 < l) : curvUp (curvDown l) = l := by
  have h1 : 1 + l ≠ 0 := by linarith
  unfold curvUp curvDown
  have h2 : 1 - l / (1 + l) = 1 / (1 + l) := by field_simp; ring
  rw [h2]
  field_simp

/-- The one-sided chain of FS112-N2-RAY: `λ_k = −1/(k + 1)`. -/
noncomputable def rayLower (k : ℕ) : ℝ := -1 / ((k : ℝ) + 1)

/-- Every `λ_k = −1/(k+1)` is negative. -/
theorem rayLower_neg (k : ℕ) : rayLower k < 0 := by
  unfold rayLower
  exact div_neg_of_neg_of_pos (by norm_num) (by positivity)

/-- Every lower shadow of the one-sided chain is tight: `λ_k = f(λ_{k+1})`. -/
theorem rayLower_eq_curvDown (k : ℕ) : rayLower k = curvDown (rayLower (k + 1)) := by
  unfold rayLower curvDown
  push_cast
  have h1 : (k : ℝ) + 1 ≠ 0 := by positivity
  have h2 : (k : ℝ) + 1 + 1 ≠ 0 := by positivity
  have h3 : 1 + -1 / ((k : ℝ) + 1 + 1) = (k + 1) / (k + 1 + 1) := by field_simp; ring
  rw [h3]
  field_simp

/-- **FS112-N2-RAY**, the chain: `λ_0 = −1` (the end's horn bound), `−1 < λ_k < υ_k = 0 < 1` past the end, every lower
shadow tight (`λ_k = f(λ_{k+1})`) and every upper inequality met (`f̃(υ_{k−1}) ≤ υ_k`). -/
theorem ray_chain :
    rayLower 0 = -1 ∧ (∀ k, 1 ≤ k → -1 < rayLower k ∧ rayLower k < 0) ∧
      (∀ k, rayLower k = curvDown (rayLower (k + 1))) ∧ curvUp (0 : ℝ) = 0 := by
  refine ⟨by simp [rayLower], fun k hk => ⟨?_, rayLower_neg k⟩, rayLower_eq_curvDown, by simp [curvUp]⟩
  have hk' : (1 : ℝ) ≤ k := by exact_mod_cast hk
  unfold rayLower
  rw [neg_div, neg_lt_neg_iff, div_lt_one (by positivity)]
  linarith

/-- **FS112-N2-RAY**, FIN's argument stops at an end: a one-sided sequence satisfies FIN's inequalities wherever both indices
are in range, with `−1 < λ_k` past its end — so no contradiction follows without the bi-infinite hypothesis. -/
theorem exists_oneSided_chain : ∃ l u : ℕ → ℝ, (∀ k, -1 < l (k + 1)) ∧ (∀ k, l k < u k ∧ u k < 1) ∧
    (∀ k, l k ≤ curvDown (l (k + 1))) ∧ ∀ k, curvUp (u k) ≤ u (k + 1) := by
  obtain ⟨-, h1, h2, h3⟩ := ray_chain
  refine ⟨rayLower, fun _ => 0, fun k => (h1 (k + 1) (by omega)).1, fun k => ⟨rayLower_neg k, one_pos⟩,
    fun k => (h2 k).le, fun k => by simp [h3]⟩

/-- **FS112-N2-RAY**, the pencil: in the frame at `P_k = v + kn` (`n = e(α + π/2)`), the arc of upward curvature
`λ_k = −1/(k + 1)` tangent to `e α` is the circle of radius `k + 1` about `P_{−1} = v − n`. -/
theorem rayLower_pencil (v : ℂ) (α : ℝ) (k : ℕ) (z : ℂ) :
    tanHeight (rayLower k) (frameX (v + (k : ℂ) * e (α + π / 2)) α z)
        (frameY (v + (k : ℂ) * e (α + π / 2)) α z) = 0 ↔ dist z (v - e (α + π / 2)) = (k : ℝ) + 1 := by
  have hk : (0 : ℝ) < (k : ℝ) + 1 := by positivity
  have hsq := sq_dist_normalPt (v + (k : ℂ) * e (α + π / 2)) α (-((k : ℝ) + 1)) z
  have hpt : v + (k : ℂ) * e (α + π / 2) + ((-((k : ℝ) + 1) : ℝ) : ℂ) * e (α + π / 2) = v - e (α + π / 2) := by
    push_cast; ring
  rw [hpt, ← dist_eq_norm] at hsq
  have hκ : rayLower k ≠ 0 := (rayLower_neg k).ne
  have hinv : 1 / rayLower k = -((k : ℝ) + 1) := by unfold rayLower; field_simp
  rw [tanHeight_eq_of_ne_zero hκ, hinv]
  have hfac : -(rayLower k / 2) ≠ 0 := by have := rayLower_neg k; intro h0; linarith
  rw [mul_eq_zero, or_iff_right hfac]
  have hd := dist_nonneg (x := z) (y := v - e (α + π / 2))
  constructor
  · intro h
    have : dist z (v - e (α + π / 2)) ^ 2 = ((k : ℝ) + 1) ^ 2 := by rw [hsq]; nlinarith [h]
    exact (pow_left_inj₀ hd hk.le (by norm_num)).mp this
  · intro h
    have : dist z (v - e (α + π / 2)) ^ 2 = ((k : ℝ) + 1) ^ 2 := by rw [h]
    rw [hsq] at this
    nlinarith [this]

end HadwigerNelson.Plane
