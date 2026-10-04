import Proofs.HadwigerNelson.Plane.Basic
import Mathlib.MeasureTheory.Constructions.Pi
import Mathlib.Probability.Notation

/-!
# CP colourings and `χ_CP(ℝ²)` (FS-131 wave 2's foundation)

D-CP (`data/fs106/claims.md` § 0, FS-103's D-CP (b), verbatim): "**CP `k`-colouring** of a Cayley graph `Cay(G, T)` …: a
random map `c : G → [k]` (a family of random variables on one probability space) whose law is invariant under every
translation of `G`, with `P(c(x) ≠ c(y)) → 0` as `y → x`, and `P(c(x) = c(x + w)) = 0` for every `x ∈ G` and `w ∈ T`."
Here `G = ℝ² = ℂ` and `T` the unit circle.

**The representation is the law, on the canonical space** `ℂ → Fin k` with its product σ-algebra: a random map is
determined, for every statement above, by its law, so a CP colouring *is* a probability measure on colourings,
invariant under the shifts `f ↦ f(· + x)`. No sample space is quantified over (no universe enters `χ_CP`), and a
"stationary random colouring, continuous in probability and proper almost surely on every unit pair"
(FS129-OA1-NOPERLAW's object) is exactly this structure.

**Inhabitant.** `IsEmpty (CPColouring 0)` and the adversary `IsEmpty (CPColouring 1)` below; a CP colouring with
finitely many colours is a theorem — `Plane/Stationary`'s `sq9CP` (the half-square nine-colouring under a uniformly
random translation of its period torus) supplies one at `k = 9`.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology

variable {k : ℕ}

/-- The shift of a colouring: `(shiftCol x f) y = f (y + x)`. -/
def shiftCol (x : ℂ) (f : ℂ → Fin k) : ℂ → Fin k := fun y => f (y + x)

/-- The rotation of a colouring by the angle `θ`: `(rotCol θ f) y = f (e θ * y)`. -/
noncomputable def rotCol (θ : ℝ) (f : ℂ → Fin k) : ℂ → Fin k := fun y => f (e θ * y)

theorem measurable_shiftCol (x : ℂ) : Measurable (shiftCol (k := k) x) :=
  measurable_pi_lambda _ fun y => measurable_pi_apply (y + x)

theorem measurable_rotCol (θ : ℝ) : Measurable (rotCol (k := k) θ) :=
  measurable_pi_lambda _ fun y => measurable_pi_apply (e θ * y)

/-- A **CP `k`-colouring** of the plane, as its law on `ℂ → Fin k`. -/
structure CPColouring (k : ℕ) where
  /-- The law of the random colouring. -/
  law : Measure (ℂ → Fin k)
  /-- It is a probability measure. -/
  isProbabilityMeasure : IsProbabilityMeasure law
  /-- Stationarity: the law is invariant under every translation. -/
  map_shift : ∀ x : ℂ, law.map (shiftCol x) = law
  /-- Continuity in probability: `P(c(x) ≠ c(y)) → 0` as `y → x`. -/
  tendsto_ne : ∀ x : ℂ, Tendsto (fun y => law {f | f x ≠ f y}) (𝓝 x) (𝓝 0)
  /-- Properness on every unit pair: `P(c(x) = c(x + w)) = 0` for every `x` and every unit `w`. -/
  proper : ∀ x w : ℂ, ‖w‖ = 1 → law {f | f x = f (x + w)} = 0

attribute [instance] CPColouring.isProbabilityMeasure

/-- The law is invariant under every rotation about the origin. -/
def CPColouring.RotationInvariant (c : CPColouring k) : Prop := ∀ θ : ℝ, c.law.map (rotCol θ) = c.law

/-- `χ_CP(ℝ²)`: the least `k` admitting a CP `k`-colouring (`⊤` if none). -/
noncomputable def chiCP : ℕ∞ := ⨅ (k : ℕ) (_ : Nonempty (CPColouring k)), (k : ℕ∞)

theorem chiCP_le (c : CPColouring k) : chiCP ≤ k := iInf₂_le k ⟨c⟩

/-- No CP colouring with no colours: there is no colouring at all, so no probability measure on colourings. -/
instance : IsEmpty (CPColouring 0) := ⟨fun c => by
  haveI : IsEmpty (ℂ → Fin 0) := ⟨fun f => (f 0).elim0⟩
  have h := c.isProbabilityMeasure.measure_univ
  rw [Measure.eq_zero_of_isEmpty c.law] at h
  simp at h⟩

/-- **Adversary**: one colour is never proper — `P(c(0) = c(1)) = 1`. -/
instance : IsEmpty (CPColouring 1) := ⟨fun c => by
  have h := c.proper 0 1 (by simp)
  have huniv : {f : ℂ → Fin 1 | f 0 = f (0 + 1)} = univ := by
    ext f; simp only [mem_setOf_eq, mem_univ, iff_true]; exact Subsingleton.elim _ _
  rw [huniv, measure_univ] at h
  exact one_ne_zero h⟩

/-- Spec example: `χ_CP(ℝ²) ≥ 2`, from the two emptiness facts alone. -/
example : 2 ≤ chiCP := by
  refine le_iInf₂ fun k ⟨c⟩ => ?_
  match k, c with
  | 0, c => exact (IsEmpty.false c).elim
  | 1, c => exact (IsEmpty.false c).elim
  | k + 2, _ => exact_mod_cast Nat.le_add_left 2 k

/-- Spec example: shifting by `x` then reading at `y` reads the original at `y + x`. -/
example (f : ℂ → Fin k) (x y : ℂ) : shiftCol x f y = f (y + x) := rfl

end HadwigerNelson.Plane
