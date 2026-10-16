import Proofs.HadwigerNelson.Rigidity.UsablePrime
import Proofs.HadwigerNelson.Rigidity.RingScope
import Mathlib.Combinatorics.SimpleGraph.Connectivity.Connected

/-!
# The components of the plane over a real number field (FS-131, job FS131-KRU1; skeleton)

Plan: `plans/FS131-KRU1-ring-plan.md` § 3 (module 4). The asking lane's C8 (`plans/POROS-2026-10-13-number-field-findings.md`
§ 3.3): "in every case the unit-distance graph on `F²` has infinitely many components".

**Read aloud, against the informal claim.** The graph is `(unitDistance ℂ).induce (planeOver F)`: the points of `ℂ` with both
coordinates in `F`, two of them adjacent at distance exactly `1` — `F²` with its unit-distance graph, as in every `χ(F²)` of
the library. `ConnectedComponent` is Mathlib's.

* `reachable_iff_sub_mem_unitRingOver` — **the component lemma** (`[Fischer1990b]` §§ 2–3, "stated in passing"): two points are
  joined by a path exactly when their difference lies in `ℤ[U] = UnitRing.unitRingOver F`, the additive group the unit
  vectors generate. Every subfield `F ⊆ ℝ`.
* `connected_or_infinite` — **the dichotomy, every subfield `F ⊆ ℝ`**: the plane is connected or has infinitely many
  components (`F²` is a `ℚ`-vector space, and a subgroup of finite index `d` holds `d·F² = F²`).
* `connected_iff_isEmpty_stablePrime` — over a real number field the plane is connected exactly when `F(i)` has no stable
  prime (no stable prime: `O′ = F(i)` and `c·O′ ⊆ ℤ[U]`; a stable prime `P`: `ℤ[U] ⊆ 𝓞_P ≠ F(i)`).
* `infinite_connectedComponent_planeOver` — **C8: at every real number field the plane has infinitely many components**,
  from `Rigidity.nonempty_stablePrime` (`Rigidity/UsablePrime`, no outside theorem).

**Not claimed:** anything about the components' shape beyond being cosets of `ℤ[U]`; anything at a subfield of `ℝ` that is not
a number field beyond the dichotomy (`ℝ` itself is connected).

**Models.** The hypotheses are `NumberField F` or none; `F = ℚ` (`UpperHalf.numberField_bot`) inhabits them.
-/

namespace HadwigerNelson.Rigidity

open SimpleGraph SpectralChain NumberField

variable {F : Subfield ℝ}

/-- **A walk along a sum of unit vectors** (the component lemma's `⟸`, its base point generalized): from any `y ∈ F²`, the
partial sums `y + u₀ + ⋯ + u_j` of unit vectors of `F²` are a path of unit steps. -/
theorem reachable_add_sum {m : ℕ} (u : Fin m → ℂ) (hu : ∀ j, ‖u j‖ = 1) (hF : ∀ j, u j ∈ planeOver F)
    (y : planeOver F) (hy : (y : ℂ) + ∑ j, u j ∈ planeOver F) :
    ((unitDistance ℂ).induce (planeOver F)).Reachable y ⟨(y : ℂ) + ∑ j, u j, hy⟩ := by
  sorry

/-- **The component lemma**: two points of `F²` are joined by a path of unit steps exactly when their difference is a
finite sum of unit vectors. -/
theorem reachable_iff_sub_mem_unitRingOver (x y : planeOver F) :
    ((unitDistance ℂ).induce (planeOver F)).Reachable x y ↔ (x : ℂ) - y ∈ UnitRing.unitRingOver F := by
  sorry

/-- **Connected exactly when every point of `F²` is a finite sum of unit vectors.** -/
theorem connected_iff_planeOver_subset :
    ((unitDistance ℂ).induce (planeOver F)).Connected ↔ planeOver F ⊆ UnitRing.unitRingOver F := by
  sorry

/-- **A point outside `ℤ[U]` gives infinitely many components**: were there finitely many, `d` of them, the classes of
`z/d` modulo `ℤ[U]` would have order dividing `d`, so `z = d·(z/d) ∈ ℤ[U]`. -/
theorem infinite_connectedComponent_of_not_mem {z : ℂ} (hz : z ∈ planeOver F) (hzR : z ∉ UnitRing.unitRingOver F) :
    Infinite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent := by
  sorry

/-- **The dichotomy**, every subfield of `ℝ`: the plane over `F` is connected or has infinitely many components. -/
theorem connected_or_infinite (F : Subfield ℝ) :
    ((unitDistance ℂ).induce (planeOver F)).Connected ∨
      Infinite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent := by
  sorry

/-- **A stable prime gives infinitely many components**: `ℤ[U] ⊆ 𝓞_P ≠ F(i)` (`UpperHalf.localRing_ne_top`). -/
theorem infinite_connectedComponent_of_stablePrime [NumberField F] (P : StablePrime F) :
    Infinite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent := by
  sorry

/-- **Connected exactly when `F(i)` has no stable prime** (with no stable prime, `O′ = F(i)` and `c·O′ ⊆ ℤ[U]`,
`Rigidity.exists_mul_stableIntegers_le`, give `ℤ[U] = F(i)`). -/
theorem connected_iff_isEmpty_stablePrime [NumberField F] :
    ((unitDistance ℂ).induce (planeOver F)).Connected ↔ IsEmpty (StablePrime F) := by
  sorry

variable (F) in
/-- **The plane over every real number field has infinitely many components** (C8). -/
theorem infinite_connectedComponent_planeOver [NumberField F] :
    Infinite ((unitDistance ℂ).induce (planeOver F)).ConnectedComponent := by
  sorry

variable (F) in
/-- **The plane over a real number field is never connected.** -/
theorem not_connected_planeOver [NumberField F] : ¬ ((unitDistance ℂ).induce (planeOver F)).Connected := by
  sorry

end HadwigerNelson.Rigidity
