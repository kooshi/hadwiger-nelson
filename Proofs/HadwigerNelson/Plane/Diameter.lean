import Proofs.HadwigerNelson.Plane.Closure

/-!
# Connected sets and chains with no unit pair (FS-131 wave 1)

Rows: **FS106-DIAM** (clauses (i) and (ii); clause (iii) is FS129-SR2-CLOSURE) and **FS106-TS-C**.
Plan: `plans/FS131-kernel-plan.md` § 6.

Diameters are stated pointwise (`∀ x y, dist x y < 1`), never through `Metric.diam`, which is `0` on unbounded sets.
The argument gives the strict bound pointwise, stronger than the rows' "diameter ≤ 1" (a generalization, reported):
`dist x ·` maps a preconnected set to an interval of `ℝ` that contains `0` and misses `1`.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

/-- The engine: on a preconnected set `S` holding one point `s₀` nearer than `1` to `x`, if no point of `S` is at
distance exactly `1` from `x`, every point of `S` is nearer than `1` to `x` (`x` need not lie in `S`). -/
theorem dist_lt_one_of_isPreconnected {S : Set ℂ} (hS : IsPreconnected S) {x s₀ : ℂ} (hs₀ : s₀ ∈ S)
    (h0 : dist x s₀ < 1) (h : ∀ s ∈ S, dist x s ≠ 1) : ∀ s ∈ S, dist x s < 1 := by
  sorry

/-- **FS106-DIAM (i)**: a connected set with no two points at distance `1` has every two points nearer than `1`
(the row's "diameter ≤ 1", pointwise and strict). -/
theorem dist_lt_one_of_forall_dist_ne_one {S : Set ℂ} (hS : IsPreconnected S)
    (h : ∀ x ∈ S, ∀ y ∈ S, dist x y ≠ 1) : ∀ x ∈ S, ∀ y ∈ S, dist x y < 1 := by
  sorry

/-- **FS106-TS-C**: a chain `U 0, …, U n` of connected open regions of one colour of an almost-everywhere-proper map
(their union has null unit pairs) whose closures meet in sequence has every two points nearer than `1`. -/
theorem dist_lt_one_of_chain {n : ℕ} (U : Fin (n + 1) → Set ℂ) (hopen : ∀ i, IsOpen (U i))
    (hconn : ∀ i, IsPreconnected (U i)) (hnull : UnitPairsNull (⋃ i, U i))
    (hmeet : ∀ i : Fin n, (closure (U i.castSucc) ∩ closure (U i.succ)).Nonempty) :
    ∀ x ∈ ⋃ i, U i, ∀ y ∈ ⋃ i, U i, dist x y < 1 := by
  sorry

/-- **FS106-DIAM (ii)**: two connected open regions of one colour of an almost-everywhere-proper map whose closures
meet have every two points of their union nearer than `1`. -/
theorem dist_lt_one_of_closure_inter_nonempty {U V : Set ℂ} (hU : IsOpen U) (hV : IsOpen V)
    (hUc : IsPreconnected U) (hVc : IsPreconnected V) (hnull : UnitPairsNull (U ∪ V))
    (hmeet : (closure U ∩ closure V).Nonempty) : ∀ x ∈ U ∪ V, ∀ y ∈ U ∪ V, dist x y < 1 := by
  sorry

end HadwigerNelson.Plane
