import Proofs.HadwigerNelson.Plane.SixRing.Chart

/-!
# Tips, confinement and the three axes (FS-132, C132-M-ORBIT steps M4, M5, M6) — SKELETON

Geometry and a finite count. A label `i` *tips* a point `y` of the ring when `y` is in the closure of the part of
its essential support inside the open unit disc about `p` (`IsTip`). The four points `q j` carry the cycle's
exclusions: the essential supports of `a j` and `a (j + 1)` miss the straddle region of `{p, q j}`, so `q j` and
`q (j − 1)` are the two points of the label `a j`.

No measure, no palette, and nothing of the colouring but its supports: `c` is any function and `a` any map from
`Fin 4` (injectivity and the count of six are spent in the assembly, `Plane/SixRing/Orbit`). Whole plane.
`plans/FS132-kernel-plan.md` stage 5 has the plan per leaf.
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
  sorry

/-- **M4, the sign** ("`|q − y_k|² ≤ 1` gives `|q|² ≤ 2 q·e(ψ_k)`, so `q·e(ψ_k) > 0`"): if moreover `y` is on the
unit circle about `p` and `q ≠ p`, then `q − p` has a positive inner product with `y − p`. -/
theorem IsTip.inner_pos {k : ℕ} {c : ℂ → Fin k} {p y q : ℂ} {i : Fin k} (hy : dist y p = 1) (ht : IsTip c p y i)
    (hq : q ≠ p) (hd : Disjoint (spatialSupport c i) (Straddle {p, q})) : 0 < ⟪q - p, y - p⟫ := by
  sorry

/-- **M5, antipodes** ("a set of a label of `Tip(k)` is no set of a label of `Tip(k + 3)` … `τ(k + 3) = τ(k) + 2`"):
labels of the cycle tipping two antipodal points of the ring are opposite in the cycle. (The two points of `a j`
are on the side of `y`, those of `a j'` on the other side; the four indices `j − 1, j, j' − 1, j'` are then
distinct.) -/
theorem tip_antipodal {k : ℕ} {c : ℂ → Fin k} {p : ℂ} {a : Fin 4 → Fin k} {q : Fin 4 → ℂ} (hq : ∀ j, q j ≠ p)
    (hl : ∀ j, Disjoint (spatialSupport c (a j)) (Straddle {p, q j}))
    (hr : ∀ j, Disjoint (spatialSupport c (a (j + 1))) (Straddle {p, q j}))
    {y y' : ℂ} (hy : dist y p = 1) (hy' : y' - p = -(y - p)) {j j' : Fin 4}
    (h : IsTip c p y (a j)) (h' : IsTip c p y' (a j')) : j' = j + 2 := by
  sorry

/-- **M5, one tip at each hub** ("Hence `Tip(k) = {a_{τ(k)}}` is one label"), in index form: if `τ n` indexes a tip
at every hub of the orbit, any index tipping the hub `y_n` is `τ n`. -/
theorem tip_unique {k : ℕ} {c : ℂ → Fin k} {p : ℂ} {a : Fin 4 → Fin k} {q : Fin 4 → ℂ} (hq : ∀ j, q j ≠ p)
    (hl : ∀ j, Disjoint (spatialSupport c (a j)) (Straddle {p, q j}))
    (hr : ∀ j, Disjoint (spatialSupport c (a (j + 1))) (Straddle {p, q j}))
    (ψ : ℝ) (τ : ℤ → Fin 4) (hτ : ∀ n, IsTip c p (hub p ψ n) (a (τ n))) {n : ℤ} {j : Fin 4}
    (h : IsTip c p (hub p ψ n) (a j)) : j = τ n := by
  sorry

/-- **M6, the count** (the derivation's three cases; its control `three-axes`: 64 patterns): for tip indices
`t 0, t 1, t 2` at three consecutive hubs and real numbers `σ j n` — the inner product of the `j`-th point with the
`n`-th axis — positive when `j` is one of the two points of the tip `t n`, negative for the other two, and with
`σ j 1 = σ j 0 + σ j 2`, two adjacent hubs among the first four have the same tip (`t 0 + 2` is the tip at the
fourth). Finite. -/
theorem adjacent_of_signs (t : Fin 3 → Fin 4) (σ : Fin 4 → Fin 3 → ℝ)
    (hpos : ∀ n j, j = t n ∨ j + 1 = t n → 0 < σ j n)
    (hneg : ∀ n j, j = t n + 1 ∨ j = t n + 2 → σ j n < 0)
    (hax : ∀ j, σ j 1 = σ j 0 + σ j 2) : t 0 = t 1 ∨ t 1 = t 2 ∨ t 2 = t 0 + 2 := by
  sorry

/-- **M6** ("Then `τ(k) = τ(k + 1)` for some `k` modulo 6"): if `τ n` indexes a tip at every hub of the orbit, two
adjacent hubs have the same tip. -/
theorem exists_adjacent_tips {k : ℕ} {c : ℂ → Fin k} {p : ℂ} {a : Fin 4 → Fin k} {q : Fin 4 → ℂ}
    (hq : ∀ j, q j ≠ p) (hl : ∀ j, Disjoint (spatialSupport c (a j)) (Straddle {p, q j}))
    (hr : ∀ j, Disjoint (spatialSupport c (a (j + 1))) (Straddle {p, q j}))
    (ψ : ℝ) (τ : ℤ → Fin 4) (hτ : ∀ n, IsTip c p (hub p ψ n) (a (τ n))) : ∃ n : ℤ, τ n = τ (n + 1) := by
  sorry

/-- **"Six is spent"** (M2: "a label that is neither `X` nor `Y` is one of four"): with six labels, four of them
`a 0, …, a 3` distinct and different from the two labels `X ≠ Y`, every label other than `X`, `Y` is one of the
four. -/
theorem exists_cycle_label {a : Fin 4 → Fin 6} (ha : Function.Injective a) {X Y : Fin 6} (hXY : X ≠ Y)
    (hX : ∀ j, a j ≠ X) (hY : ∀ j, a j ≠ Y) {i : Fin 6} (hiX : i ≠ X) (hiY : i ≠ Y) : ∃ j, a j = i := by
  sorry

end HadwigerNelson.SixRing
