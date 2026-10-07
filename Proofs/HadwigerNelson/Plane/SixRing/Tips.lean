import Proofs.HadwigerNelson.Plane.SixRing.Chart

/-!
# Tips, confinement and the three axes (FS-132, C132-M-ORBIT steps M4, M5, M6)

Geometry and a finite count. A label `i` *tips* a point `y` of the ring when `y` is in the closure of the part of
its essential support inside the open unit disc about `p` (`IsTip`). The four points `q j` carry the cycle's
exclusions: the essential supports of `a j` and `a (j + 1)` miss the straddle region of `{p, q j}`, so `q j` and
`q (j − 1)` are the two points of the label `a j`.

No measure, no palette, and nothing of the colouring but its supports: `c` is any function and `a` any map from
`Fin 4` (injectivity and the count of six are spent in the assembly, `Plane/SixRing/Orbit`). Whole plane.
`plans/FS132-kernel-plan.md` stage 5 has the plan per leaf.

Every leaf is proved (job FS132-I4, under Amendment 2 of its brief); no `sorry`. The count of M6 is the finite
statement `adjacent_of_signs_aux` (64 tip patterns, checked by `decide`): a pattern with no two adjacent tips equal
has a point that is on the positive side of the first and third axes and on the negative side of the second.
-/

open scoped RealInnerProductSpace

namespace HadwigerNelson.SixRing

open Outside.OAI158

/-- **M4, confinement** ("`K ⊂ B̄(z_n, 1)` … and in the limit `K ⊂ B̄(y_k, 1)`"), for the two-point set `{p, q}`: if
the label `i` tips `y` and its essential support misses the straddle region of `{p, q}`, then `q` is within `1` of
`y`. From `subset_closedBall_of_dist_lt` at points of the support inside the open unit disc about `p`, and a
limit. -/
theorem IsTip.dist_le_one {k : ℕ} {c : ℂ → Fin k} {p y q : ℂ} {i : Fin k} (ht : IsTip c p y i)
    (hd : Disjoint (spatialSupport c i) (Straddle {p, q})) : dist q y ≤ 1 := by
  have hsub : spatialSupport c i ∩ Metric.ball p 1 ⊆ Metric.closedBall q 1 := by
    rintro z ⟨hz, hzp⟩
    rw [Metric.mem_closedBall]
    by_contra hlt
    exact Set.disjoint_left.mp hd hz
      ⟨p, Set.mem_insert _ _, q, Set.mem_insert_of_mem _ rfl, Metric.mem_ball.mp hzp, not_le.mp hlt⟩
  have h := closure_minimal hsub Metric.isClosed_closedBall ht
  rwa [Metric.mem_closedBall, dist_comm] at h

/-- **M4, the sign** ("`|q − y_k|² ≤ 1` gives `|q|² ≤ 2 q·e(ψ_k)`, so `q·e(ψ_k) > 0`"): if moreover `y` is on the
unit circle about `p` and `q ≠ p`, then `q − p` has a positive inner product with `y − p`. -/
theorem IsTip.inner_pos {k : ℕ} {c : ℂ → Fin k} {p y q : ℂ} {i : Fin k} (hy : dist y p = 1) (ht : IsTip c p y i)
    (hq : q ≠ p) (hd : Disjoint (spatialSupport c i) (Straddle {p, q})) : 0 < ⟪q - p, y - p⟫ := by
  have h1 := ht.dist_le_one hd
  have h2 : ‖(q - p) - (y - p)‖ ≤ 1 := by rwa [sub_sub_sub_cancel_right, ← dist_eq_norm]
  have h3 := norm_sub_sq_real (q - p) (y - p)
  have h4 : ‖y - p‖ = 1 := by rwa [← dist_eq_norm]
  have h5 : 0 < ‖q - p‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hq)
  have h6 : ‖(q - p) - (y - p)‖ ^ 2 ≤ 1 := pow_le_one₀ (norm_nonneg _) h2
  have h7 : 0 < ‖q - p‖ ^ 2 := by positivity
  rw [h3, h4] at h6
  linarith

/-- **M5, antipodes** ("a set of a label of `Tip(k)` is no set of a label of `Tip(k + 3)` … `τ(k + 3) = τ(k) + 2`"):
labels of the cycle tipping two antipodal points of the ring are opposite in the cycle. (The two points of `a j`
are on the side of `y`, those of `a j'` on the other side; the four indices `j − 1, j, j' − 1, j'` are then
distinct.) -/
theorem tip_antipodal {k : ℕ} {c : ℂ → Fin k} {p : ℂ} {a : Fin 4 → Fin k} {q : Fin 4 → ℂ} (hq : ∀ j, q j ≠ p)
    (hl : ∀ j, Disjoint (spatialSupport c (a j)) (Straddle {p, q j}))
    (hr : ∀ j, Disjoint (spatialSupport c (a (j + 1))) (Straddle {p, q j}))
    {y y' : ℂ} (hy : dist y p = 1) (hy' : y' - p = -(y - p)) {j j' : Fin 4}
    (h : IsTip c p y (a j)) (h' : IsTip c p y' (a j')) : j' = j + 2 := by
  have hy1 : dist y' p = 1 := by rw [dist_eq_norm, hy', norm_neg, ← dist_eq_norm, hy]
  -- the second point of a label: `q (m − 1)`, by `hr` at `m − 1`
  have hr' : ∀ m : Fin 4, Disjoint (spatialSupport c (a m)) (Straddle {p, q (m - 1)}) := fun m => by
    have h1 := hr (m - 1)
    rwa [sub_add_cancel] at h1
  -- the two points of `a j` are on the side of `y`, those of `a j'` on the other
  have p1 : 0 < ⟪q j - p, y - p⟫ := h.inner_pos hy (hq j) (hl j)
  have p2 : 0 < ⟪q (j - 1) - p, y - p⟫ := h.inner_pos hy (hq _) (hr' j)
  have n1 : ⟪q j' - p, y - p⟫ < 0 := by
    have h1 := h'.inner_pos hy1 (hq j') (hl j')
    rw [hy', inner_neg_right] at h1
    linarith
  have n2 : ⟪q (j' - 1) - p, y - p⟫ < 0 := by
    have h1 := h'.inner_pos hy1 (hq _) (hr' j')
    rw [hy', inner_neg_right] at h1
    linarith
  have key : ∀ j j' : Fin 4, j' ≠ j → j' ≠ j - 1 → j' - 1 ≠ j → j' = j + 2 := by decide
  refine key j j' (fun e => ?_) (fun e => ?_) (fun e => ?_)
  · rw [e] at n1
    linarith
  · rw [e] at n1
    linarith
  · rw [e] at n2
    linarith

/-- **M5, one tip at each hub** ("Hence `Tip(k) = {a_{τ(k)}}` is one label"), in index form: if `τ n` indexes a tip
at every hub of the orbit, any index tipping the hub `y_n` is `τ n`. -/
theorem tip_unique {k : ℕ} {c : ℂ → Fin k} {p : ℂ} {a : Fin 4 → Fin k} {q : Fin 4 → ℂ} (hq : ∀ j, q j ≠ p)
    (hl : ∀ j, Disjoint (spatialSupport c (a j)) (Straddle {p, q j}))
    (hr : ∀ j, Disjoint (spatialSupport c (a (j + 1))) (Straddle {p, q j}))
    (ψ : ℝ) (τ : ℤ → Fin 4) (hτ : ∀ n, IsTip c p (hub p ψ n) (a (τ n))) {n : ℤ} {j : Fin 4}
    (h : IsTip c p (hub p ψ n) (a j)) : j = τ n := by
  have h1 := tip_antipodal hq hl hr (dist_hub p ψ n) (hub_add_three p ψ n) h (hτ (n + 3))
  have h2 := tip_antipodal hq hl hr (dist_hub p ψ n) (hub_add_three p ψ n) (hτ n) (hτ (n + 3))
  exact add_right_cancel (h1.symm.trans h2)

/-- **M6, the count, as a finite statement** (the derivation's control `three-axes`): of the 64 patterns of tips
`t₀, t₁, t₂` at three consecutive hubs, each either has two adjacent tips equal (`t₂ = t₀ + 2` says the third hub and
the fourth have one tip), or has a point `j` that is one of the two points of the tip at the first hub and at the
third, and one of the two points opposite the tip at the second. -/
theorem adjacent_of_signs_aux : ∀ t₀ t₁ t₂ : Fin 4, t₀ = t₁ ∨ t₁ = t₂ ∨ t₂ = t₀ + 2 ∨
    ∃ j : Fin 4, (j = t₀ ∨ j + 1 = t₀) ∧ (j = t₂ ∨ j + 1 = t₂) ∧ (j = t₁ + 1 ∨ j = t₁ + 2) := by
  decide

/-- **M6, the count** (the derivation's three cases; its control `three-axes`: 64 patterns): for tip indices
`t 0, t 1, t 2` at three consecutive hubs and real numbers `σ j n` — the inner product of the `j`-th point with the
`n`-th axis — positive when `j` is one of the two points of the tip `t n`, negative for the other two, and with
`σ j 1 = σ j 0 + σ j 2`, two adjacent hubs among the first four have the same tip (`t 0 + 2` is the tip at the
fourth). Finite. -/
theorem adjacent_of_signs (t : Fin 3 → Fin 4) (σ : Fin 4 → Fin 3 → ℝ)
    (hpos : ∀ n j, j = t n ∨ j + 1 = t n → 0 < σ j n)
    (hneg : ∀ n j, j = t n + 1 ∨ j = t n + 2 → σ j n < 0)
    (hax : ∀ j, σ j 1 = σ j 0 + σ j 2) : t 0 = t 1 ∨ t 1 = t 2 ∨ t 2 = t 0 + 2 := by
  rcases adjacent_of_signs_aux (t 0) (t 1) (t 2) with h | h | h | ⟨j, h0, h2, h1⟩
  · exact Or.inl h
  · exact Or.inr (Or.inl h)
  · exact Or.inr (Or.inr h)
  · have s0 := hpos 0 j h0
    have s2 := hpos 2 j h2
    have s1 := hneg 1 j h1
    have := hax j
    linarith

/-- **M6** ("Then `τ(k) = τ(k + 1)` for some `k` modulo 6"): if `τ n` indexes a tip at every hub of the orbit, two
adjacent hubs have the same tip. -/
theorem exists_adjacent_tips {k : ℕ} {c : ℂ → Fin k} {p : ℂ} {a : Fin 4 → Fin k} {q : Fin 4 → ℂ}
    (hq : ∀ j, q j ≠ p) (hl : ∀ j, Disjoint (spatialSupport c (a j)) (Straddle {p, q j}))
    (hr : ∀ j, Disjoint (spatialSupport c (a (j + 1))) (Straddle {p, q j}))
    (ψ : ℝ) (τ : ℤ → Fin 4) (hτ : ∀ n, IsTip c p (hub p ψ n) (a (τ n))) : ∃ n : ℤ, τ n = τ (n + 1) := by
  -- the two points of the tip at a hub are on its side
  have A : ∀ (m : ℤ) (j : Fin 4), j = τ m ∨ j + 1 = τ m → 0 < ⟪q j - p, hub p ψ m - p⟫ := by
    intro m j hj
    rcases hj with rfl | hj
    · exact (hτ m).inner_pos (dist_hub p ψ m) (hq _) (hl _)
    · have h1 := hr j
      rw [hj] at h1
      exact (hτ m).inner_pos (dist_hub p ψ m) (hq j) h1
  -- the antipodal hub is tipped by the opposite label, whose two points are on the other side
  have hanti : ∀ m : ℤ, τ (m + 3) = τ m + 2 := fun m =>
    tip_antipodal hq hl hr (dist_hub p ψ m) (hub_add_three p ψ m) (hτ m) (hτ (m + 3))
  have B : ∀ (m : ℤ) (j : Fin 4), j = τ m + 1 ∨ j = τ m + 2 → ⟪q j - p, hub p ψ m - p⟫ < 0 := by
    intro m j hj
    have h3 : 0 < ⟪q j - p, hub p ψ (m + 3) - p⟫ := by
      apply A (m + 3) j
      rw [hanti m]
      have h11 : ∀ x : Fin 4, x + 1 + 1 = x + 2 := by decide
      rcases hj with rfl | rfl
      · exact Or.inr (h11 _)
      · exact Or.inl rfl
    rw [hub_add_three, inner_neg_right] at h3
    linarith
  -- the three axes
  have hax : ∀ j : Fin 4, ⟪q j - p, hub p ψ 1 - p⟫ = ⟪q j - p, hub p ψ 0 - p⟫ + ⟪q j - p, hub p ψ 2 - p⟫ := by
    intro j
    have h := hub_axes p ψ 0
    rw [zero_add, zero_add] at h
    rw [h, inner_add_right]
  have key := adjacent_of_signs (fun n : Fin 3 => τ ((n : ℕ) : ℤ))
    (fun j n => ⟪q j - p, hub p ψ ((n : ℕ) : ℤ) - p⟫) (fun n j => A _ j) (fun n j => B _ j) hax
  have e1 : τ ((1 : ℤ) + 1) = τ 2 := rfl
  have e3 : τ ((2 : ℤ) + 1) = τ ((0 : ℤ) + 3) := rfl
  rcases key with h | h | h
  · exact ⟨0, h⟩
  · exact ⟨1, h.trans e1.symm⟩
  · exact ⟨2, h.trans ((hanti 0).symm.trans e3.symm)⟩

/-- **"Six is spent"** (M2: "a label that is neither `X` nor `Y` is one of four"): with six labels, four of them
`a 0, …, a 3` distinct and different from the two labels `X ≠ Y`, every label other than `X`, `Y` is one of the
four. -/
theorem exists_cycle_label {a : Fin 4 → Fin 6} (ha : Function.Injective a) {X Y : Fin 6} (hXY : X ≠ Y)
    (hX : ∀ j, a j ≠ X) (hY : ∀ j, a j ≠ Y) {i : Fin 6} (hiX : i ≠ X) (hiY : i ≠ Y) : ∃ j, a j = i := by
  by_contra hno
  have hno' : ∀ j, a j ≠ i := fun j hj => hno ⟨j, hj⟩
  -- the four labels would lie among the three that are left
  have hsub : Finset.univ.image a ⊆ Finset.univ \ {X, Y, i} := by
    intro z hz
    obtain ⟨j, -, rfl⟩ := Finset.mem_image.mp hz
    simp only [Finset.mem_sdiff, Finset.mem_univ, true_and, Finset.mem_insert, Finset.mem_singleton, not_or]
    exact ⟨hX j, hY j, hno' j⟩
  have h1 : (Finset.univ.image a).card = 4 := by
    rw [Finset.card_image_of_injective _ ha, Finset.card_univ, Fintype.card_fin]
  have h3 : ({X, Y, i} : Finset (Fin 6)).card = 3 := by
    rw [Finset.card_insert_of_notMem (by simp [hXY, hiX.symm]), Finset.card_insert_of_notMem (by simp [hiY.symm]),
      Finset.card_singleton]
  have h2 : (Finset.univ \ ({X, Y, i} : Finset (Fin 6))).card = 6 - 3 := by
    rw [Finset.card_sdiff_of_subset (Finset.subset_univ _), Finset.card_univ, Fintype.card_fin, h3]
  have := Finset.card_le_card hsub
  omega

end HadwigerNelson.SixRing
