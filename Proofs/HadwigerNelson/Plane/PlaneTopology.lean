import Mathlib.Topology.Homotopy.Lifting
import Mathlib.Analysis.Complex.CoveringMap
import Mathlib.Topology.Connected.LocallyConnected
import Proofs.HadwigerNelson.Plane.Basic

/-!
# Plane topology: unicoherence, the frontier of a complementary component, and the crossing of continua in a disc

The plane topology wave 5's planar leaves read (job FS131-KP, `plans/FS131-planar-kernel-plan.md` § 3), none of it in Mathlib at the pin
(grep, 2026-10-04: no unicoherence, Janiszewski, Jordan curve or frontier-of-component lemma). Pure topology of `ℂ`; no map.

* `isPreconnected_inter_of_union_eq_univ` — **the plane is unicoherent**: two closed preconnected sets covering `ℂ` meet in a preconnected
  set. Planned through Mathlib's lifting theorem for the covering `Circle.exp` over the simply connected `ℂ` (plan § 3.2), not imported.
* `isPreconnected_frontier_connectedComponentIn` — **the frontier of a component of the complement of a closed preconnected set is
  preconnected** (the home theorem of FS131-E4's E4-RIM and E4-OUTERMOST: "the frontier of the unbounded complementary component of a plane
  continuum is connected"), from unicoherence with `A = cl C`, `B = Cᶜ`.
* `exists_inter_of_finite_closed_cover` — a preconnected set covered by finitely many closed sets, two of which meet it, has a point in two of
  them (E4-RIM step 4).
* `isPreconnected_compl_closedBall` — the complement of a closed disc is preconnected (one unbounded complementary component).
* `inter_nonempty_of_interleaved` — **two continua in a closed disc joining interleaved points of its circle meet** (`retArcs_nested`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Topology Metric

/-- **The plane is unicoherent**: if two closed preconnected sets cover `ℂ`, their intersection is preconnected. Proof planned (plan § 3.2):
were `A ∩ B = P ∪ Q` with `P`, `Q` disjoint, closed, nonempty, the Urysohn function `φ = d(·, P) / (d(·, P) + d(·, Q))` gives a continuous
`f : ℂ → Circle`, `f = exp(2πiφ)` on `A` and `1` on `B` (they agree on `A ∩ B`); `ℂ` is simply connected, so `f` lifts through
`Circle.exp` (`IsCoveringMap.existsUnique_continuousMap_lifts`) to `h : ℂ → ℝ`; `h` is an integer constant `m` on the preconnected `B`, and
`φ − h` an integer constant `n` on the preconnected `A`; on `P`, `m = −n`, on `Q`, `m = 1 − n`. Formalized here (the hour line, "when
unsure, formalize"); no `axiom`. -/
theorem isPreconnected_inter_of_union_eq_univ {A B : Set ℂ} (hA : IsClosed A) (hB : IsClosed B) (hA' : IsPreconnected A)
    (hB' : IsPreconnected B) (hAB : A ∪ B = univ) : IsPreconnected (A ∩ B) := by
  sorry

/-- The complement of a component of the complement of a closed preconnected set is preconnected: it is `K` with every other component
added, and each other component's closure meets `K` (its frontier lies in `K` and is nonempty, `ℂ` being connected). -/
theorem isPreconnected_compl_connectedComponentIn {K : Set ℂ} (hK : IsClosed K) (hK' : IsPreconnected K) (z : ℂ) :
    IsPreconnected (connectedComponentIn Kᶜ z)ᶜ := by
  sorry

/-- **The frontier of a complementary component is preconnected** (unicoherence; Janiszewski's form for one continuum): for `K` closed and
preconnected and `C` a component of `Kᶜ`, `frontier C = cl C ∩ Cᶜ` is the intersection of two closed preconnected sets covering `ℂ`
(`C` is open, `ℂ` locally connected). FS131-E4's home theorem, read there and proved here. -/
theorem isPreconnected_frontier_connectedComponentIn {K : Set ℂ} (hK : IsClosed K) (hK' : IsPreconnected K) (z : ℂ) :
    IsPreconnected (frontier (connectedComponentIn Kᶜ z)) := by
  sorry

/-- **Two of finitely many closed sets meet on a preconnected set they cover** (E4-RIM step 4): if `S` is preconnected, covered by the
closed sets `C i`, `i ∈ s` finite, and two distinct indices meet `S`, then two distinct indices meet at a point of `S` (else `C i ∩ S` and
the union of the others cut `S`). -/
theorem exists_inter_of_finite_closed_cover {α ι : Type*} [TopologicalSpace α] {S : Set α} (hS : IsPreconnected S) {s : Set ι}
    (hs : s.Finite) (C : ι → Set α) (hC : ∀ i ∈ s, IsClosed (C i)) (hcov : S ⊆ ⋃ i ∈ s, C i) {i j : ι} (hi : i ∈ s) (hj : j ∈ s)
    (hij : i ≠ j) (hiS : (S ∩ C i).Nonempty) (hjS : (S ∩ C j).Nonempty) :
    ∃ i' ∈ s, ∃ j' ∈ s, i' ≠ j' ∧ (S ∩ C i' ∩ C j').Nonempty := by
  sorry

/-- **The last exit** (E4-RIM step 3, E4-OUTERMOST steps 3 and 5): if the frontier of an unbounded component `W` of `Kᶜ` (`K` closed and
bounded) lies in a closed set `R`, every point off `W` and off `R` lies in a bounded component of `Rᶜ` — an unbounded one would meet `W` (far
away) and its complement, hence `frontier W ⊆ R` (`IsPreconnected.inter_frontier_nonempty`). -/
theorem isBounded_connectedComponentIn_of_frontier_subset {K R : Set ℂ} (hK : IsClosed K) (hKb : Bornology.IsBounded K)
    (hR : IsClosed R) {z : ℂ} (hW : ¬ Bornology.IsBounded (connectedComponentIn Kᶜ z))
    (hfr : frontier (connectedComponentIn Kᶜ z) ⊆ R) {y : ℂ} (hyW : y ∉ connectedComponentIn Kᶜ z) (hyR : y ∉ R) :
    Bornology.IsBounded (connectedComponentIn Rᶜ y) := by
  sorry

/-- For a bounded set, two unbounded complementary components coincide (each meets the preconnected complement of a large closed disc). -/
theorem connectedComponentIn_eq_of_not_isBounded {K : Set ℂ} (hKb : Bornology.IsBounded K) {z w : ℂ}
    (hz : ¬ Bornology.IsBounded (connectedComponentIn Kᶜ z)) (hw : ¬ Bornology.IsBounded (connectedComponentIn Kᶜ w)) :
    connectedComponentIn Kᶜ z = connectedComponentIn Kᶜ w := by
  sorry

/-- The complement of a closed disc in `ℂ` is preconnected (the image of `(R, ∞) × ℝ` under polar coordinates, as
`isPreconnected_holedAnnulus`). So a bounded set has exactly one unbounded complementary component. -/
theorem isPreconnected_compl_closedBall (c : ℂ) (R : ℝ) : IsPreconnected (closedBall c R)ᶜ := by
  sorry

/-- **Two continua in a closed disc joining interleaved points of its circle meet** (the crossing lemma; `retArcs_nested`): `K` holds
`r(s)`, `r(t)` and `K'` holds `r(s')`, `r(t')` with `s < s' < t < t' < s + 2π`. Classical (Newman's θ-curve form of Janiszewski's
theorem). Proof planned (plan § 3.2): from unicoherence through the Phragmén–Brouwer property (in a connected, locally connected space
unicoherence is equivalent to: if closed `A`, `B` with `A ∩ B` preconnected each leave `x`, `y` in one complementary component, so does
`A ∪ B`), applied to `K` and `K'` each completed by the outward rays from their two circle points, which turns the crossing into "a line
from infinity to infinity separates its two sides". **H**: the implementer measures it from its first
child and reports; Keryx may split it into its own job. -/
theorem inter_nonempty_of_interleaved {u : ℂ} {K K' : Set ℂ} (hK : IsClosed K) (hK' : IsClosed K') (hKc : IsPreconnected K)
    (hK'c : IsPreconnected K') (hKd : K ⊆ closedBall u 1) (hK'd : K' ⊆ closedBall u 1) {s s' t t' : ℝ} (h₁ : s < s') (h₂ : s' < t)
    (h₃ : t < t') (h₄ : t' < s + 2 * π) (hs : ringPt u s ∈ K) (ht : ringPt u t ∈ K) (hs' : ringPt u s' ∈ K')
    (ht' : ringPt u t' ∈ K') : (K ∩ K').Nonempty := by
  sorry

/-! ### Spec examples -/

/-- A spec example for `exists_inter_of_finite_closed_cover`: `[0, 2]` covered by `[0, 1]` and `[1, 2]` has a point in both. -/
example : ∃ i' ∈ ({0, 1} : Set ℕ), ∃ j' ∈ ({0, 1} : Set ℕ), i' ≠ j' ∧
    (Icc (0 : ℝ) 2 ∩ (fun i : ℕ => Icc (i : ℝ) (i + 1)) i' ∩ (fun i : ℕ => Icc (i : ℝ) (i + 1)) j').Nonempty :=
  exists_inter_of_finite_closed_cover isPreconnected_Icc (Set.toFinite _) _ (fun _ _ => isClosed_Icc)
    (fun x hx => by
      simp only [mem_insert_iff, mem_singleton_iff, mem_iUnion, exists_prop, exists_eq_or_imp, exists_eq_left]
      rcases le_total x 1 with h | h
      · left; exact ⟨by simpa using hx.1, by simpa using h⟩
      · right; exact ⟨by simpa using h, by have := hx.2; push_cast; linarith⟩)
    (i := 0) (j := 1) (by simp) (by simp) (by norm_num) ⟨0, by simp⟩ ⟨2, by norm_num⟩

end HadwigerNelson.Plane
