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
  intro s hs
  by_contra hge
  have hgt : 1 < dist x s := lt_of_le_of_ne (not_lt.mp hge) (h s hs).symm
  have himg : IsPreconnected ((fun y => dist x y) '' S) :=
    hS.image _ (continuous_const.dist continuous_id).continuousOn
  have hone : (1 : ℝ) ∈ (fun y => dist x y) '' S :=
    himg.Icc_subset ⟨s₀, hs₀, rfl⟩ ⟨s, hs, rfl⟩ ⟨h0.le, hgt.le⟩
  obtain ⟨y, hy, hy1⟩ := hone
  exact h y hy hy1

/-- **FS106-DIAM (i)**: a connected set with no two points at distance `1` has every two points nearer than `1`
(the row's "diameter ≤ 1", pointwise and strict). -/
theorem dist_lt_one_of_forall_dist_ne_one {S : Set ℂ} (hS : IsPreconnected S)
    (h : ∀ x ∈ S, ∀ y ∈ S, dist x y ≠ 1) : ∀ x ∈ S, ∀ y ∈ S, dist x y < 1 := by
  intro x hx y hy
  exact dist_lt_one_of_isPreconnected hS hx (by simp) (h x hx) y hy

/-- One link of a chain: if `V` lies within `1` of `x` and `V'`'s closure meets `V`'s, so does `V'`. -/
theorem chain_step {W V V' : Set ℂ} (hW : IsOpen W) (hnull : UnitPairsNull W) (hV : V ⊆ W)
    (hV' : V' ⊆ W) (hV'c : IsPreconnected V') {x : ℂ} (hx : x ∈ W) (hnear : ∀ s ∈ V, dist x s < 1)
    (hmeet : (closure V ∩ closure V').Nonempty) : ∀ s ∈ V', dist x s < 1 := by
  obtain ⟨z, hzV, hzV'⟩ := hmeet
  have hz_le : dist x z ≤ 1 := by
    have : closure V ⊆ closedBall x 1 :=
      closure_minimal (fun s hs => by rw [mem_closedBall, dist_comm]; exact (hnear s hs).le)
        isClosed_closedBall
    have := this hzV
    rwa [mem_closedBall, dist_comm] at this
  have hz_ne : dist x z ≠ 1 := dist_ne_one_of_mem_of_mem_closure hW hnull hx (closure_mono hV hzV)
  have hz_lt : dist x z < 1 := lt_of_le_of_ne hz_le hz_ne
  have hconn : IsPreconnected (insert z V') :=
    hV'c.subset_closure (subset_insert _ _) (insert_subset hzV' subset_closure)
  have key := dist_lt_one_of_isPreconnected hconn (mem_insert z V') hz_lt (by
    intro s hs
    rcases hs with rfl | hs
    · exact hz_ne
    · exact dist_ne_one_of_mem_of_mem_closure hW hnull hx (subset_closure (hV' hs)))
  exact fun s hs => key s (mem_insert_of_mem _ hs)

/-- **FS106-TS-C**: a chain `U 0, …, U n` of connected open regions of one colour of an almost-everywhere-proper map
(their union has null unit pairs) whose closures meet in sequence has every two points nearer than `1`. -/
theorem dist_lt_one_of_chain {n : ℕ} (U : Fin (n + 1) → Set ℂ) (hopen : ∀ i, IsOpen (U i))
    (hconn : ∀ i, IsPreconnected (U i)) (hnull : UnitPairsNull (⋃ i, U i))
    (hmeet : ∀ i : Fin n, (closure (U i.castSucc) ∩ closure (U i.succ)).Nonempty) :
    ∀ x ∈ ⋃ i, U i, ∀ y ∈ ⋃ i, U i, dist x y < 1 := by
  have hW : IsOpen (⋃ i, U i) := isOpen_iUnion hopen
  have hsub : ∀ i, U i ⊆ ⋃ i, U i := fun i => subset_iUnion U i
  intro x hx y hy
  obtain ⟨j₀, hj₀⟩ := mem_iUnion.mp hx
  obtain ⟨i, hi⟩ := mem_iUnion.mp hy
  have base : ∀ s ∈ U j₀, dist x s < 1 :=
    dist_lt_one_of_isPreconnected (hconn j₀) hj₀ (by simp) (fun s hs =>
      dist_ne_one_of_mem_of_mem_closure hW hnull hx (subset_closure (hsub j₀ hs)))
  have step : ∀ (a b : Fin (n + 1)), (closure (U a) ∩ closure (U b)).Nonempty →
      (∀ s ∈ U a, dist x s < 1) → ∀ s ∈ U b, dist x s < 1 := fun a b hab ha =>
    chain_step hW hnull (hsub a) (hsub b) (hconn b) hx ha hab
  have link : ∀ (m : ℕ) (hm : m < n), (closure (U ⟨m, by omega⟩) ∩ closure (U ⟨m + 1, by omega⟩)).Nonempty :=
    fun m hm => hmeet ⟨m, hm⟩
  have up : ∀ m : ℕ, ∀ hm : m < n + 1, j₀.val ≤ m → ∀ s ∈ U ⟨m, hm⟩, dist x s < 1 := by
    intro m hm hle
    induction m, hle using Nat.le_induction with
    | base => exact base
    | succ m hle ih =>
      exact step _ _ (link m (by omega)) (ih (by omega))
  have down : ∀ d m : ℕ, ∀ hm : m < n + 1, m + d = j₀.val → ∀ s ∈ U ⟨m, hm⟩, dist x s < 1 := by
    intro d
    induction d with
    | zero =>
      intro m hm h
      have : (⟨m, hm⟩ : Fin (n + 1)) = j₀ := Fin.ext (by simpa using h)
      rw [this]; exact base
    | succ d ih =>
      intro m hm h
      have hmn : m < n := by have := j₀.isLt; omega
      refine step _ _ ?_ (ih (m + 1) (by omega) (by omega))
      rw [inter_comm]; exact link m hmn
  rcases le_total j₀.val i.val with h | h
  · exact up i.val i.isLt h y hi
  · exact down (j₀.val - i.val) i.val i.isLt (by omega) y hi

/-- **FS106-DIAM (ii)**: two connected open regions of one colour of an almost-everywhere-proper map whose closures
meet have every two points of their union nearer than `1`. -/
theorem dist_lt_one_of_closure_inter_nonempty {U V : Set ℂ} (hU : IsOpen U) (hV : IsOpen V)
    (hUc : IsPreconnected U) (hVc : IsPreconnected V) (hnull : UnitPairsNull (U ∪ V))
    (hmeet : (closure U ∩ closure V).Nonempty) : ∀ x ∈ U ∪ V, ∀ y ∈ U ∪ V, dist x y < 1 := by
  have hun : (⋃ i, (![U, V] : Fin 2 → Set ℂ) i) = U ∪ V := by
    ext x; simp [Fin.exists_fin_two]
  have h := dist_lt_one_of_chain (n := 1) ![U, V]
    (fun i => by fin_cases i <;> simpa) (fun i => by fin_cases i <;> simpa)
    (by rw [hun]; exact hnull)
    (fun i => by fin_cases i; simpa using hmeet)
  rw [hun] at h
  exact h

end HadwigerNelson.Plane
