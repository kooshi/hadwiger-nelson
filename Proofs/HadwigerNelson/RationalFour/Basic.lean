import Mathlib.Algebra.Quaternion
import Mathlib.NumberTheory.Padics.PadicVal.Basic
import Mathlib.Combinatorics.SimpleGraph.Coloring.Vertex
import Mathlib.Analysis.InnerProductSpace.PiL2
import Proofs.HadwigerNelson.UnitDistance

/-!
# Rational four-space: the unit-distance graph, read through the quaternions (FS-131, FS131-KFS1, FS131-IRF1)

`ℚ⁴` with its Euclidean distance is the rational quaternions `ℍ[ℚ]` with `|x − y|² = normSq (x − y)`: the coordinates are
`re, imI, imJ, imK`, and `Quaternion.normSq_def'` is the sum of their squares. Multiplication is what the proofs use: `normSq`
is multiplicative, so `x ↦ q x` is a similarity of ratio `√(normSq q)` and `x ↦ x u` with `normSq u = 1` an isometry.

* `sqDist x y` — the squared distance, a rational.
* `quatGraph` — the unit-distance graph on `ℍ[ℚ]`, the working graph.
* `ratFourGraph` — the unit-distance graph on `Fin 4 → ℚ` (the sum of the squared coordinate differences is 1), the graph the
  head statements are stated on; `quatIso` carries one to the other.
* `ratPoints`, `nonempty_iso_unitDistance` — `ratFourGraph` is the library's `unitDistance` graph of Euclidean four-space
  induced on the points with rational coordinates (the read-back anchor).
* `val z = v₂(normSq z)` — the 2-adic valuation of a squared length (`padicValRat 2 0 = 0`: every statement about `val` of a
  difference that can vanish carries `x ≠ y` or reads `0` apart).

**Not claimed here:** anything about colourings; that is `RationalFour/Compulsion` and `RationalFour/Forbid`.
-/

namespace HadwigerNelson.RationalFour

open Quaternion

/-! ## The squared distance and the graphs -/

/-- **The squared Euclidean distance** of two points of `ℚ⁴`, read as rational quaternions. -/
def sqDist (x y : ℍ[ℚ]) : ℚ := normSq (x - y)

theorem sqDist_comm (x y : ℍ[ℚ]) : sqDist x y = sqDist y x := by
  rw [sqDist, sqDist, ← neg_sub, normSq_neg]

theorem sqDist_self (x : ℍ[ℚ]) : sqDist x x = 0 := by
  simp [sqDist]

/-- **The unit-distance graph on `ℚ⁴`**, as the rational quaternions: `x ∼ y` iff `|x − y|² = 1`. -/
def quatGraph : SimpleGraph ℍ[ℚ] where
  Adj x y := sqDist x y = 1
  symm := ⟨fun x y h => by rwa [sqDist_comm]⟩
  loopless := ⟨fun x h => by rw [sqDist_self] at h; exact zero_ne_one h⟩

theorem quatGraph_adj {x y : ℍ[ℚ]} : quatGraph.Adj x y ↔ sqDist x y = 1 := Iff.rfl

/-- **The squared Euclidean distance on `ℚ⁴`**, coordinatewise. -/
def sqDist4 (x y : Fin 4 → ℚ) : ℚ := ∑ i, (x i - y i) ^ 2

theorem sqDist4_comm (x y : Fin 4 → ℚ) : sqDist4 x y = sqDist4 y x := by
  simp only [sqDist4]
  exact Finset.sum_congr rfl fun i _ => by ring

/-- **The unit-distance graph on `ℚ⁴`**: `x ∼ y` iff `Σᵢ (xᵢ − yᵢ)² = 1`. -/
def ratFourGraph : SimpleGraph (Fin 4 → ℚ) where
  Adj x y := sqDist4 x y = 1
  symm := ⟨fun x y h => by rwa [sqDist4_comm]⟩
  loopless := ⟨fun x h => by simp [sqDist4] at h⟩

theorem ratFourGraph_adj {x y : Fin 4 → ℚ} : ratFourGraph.Adj x y ↔ sqDist4 x y = 1 := Iff.rfl

/-- The coordinates of a rational quaternion, `(re, imI, imJ, imK)`. -/
def toQuat : (Fin 4 → ℚ) ≃ ℍ[ℚ] := (QuaternionAlgebra.equivTuple (-1 : ℚ) 0 (-1)).symm

/-- The two squared distances agree. -/
theorem sqDist_toQuat (x y : Fin 4 → ℚ) : sqDist (toQuat x) (toQuat y) = sqDist4 x y := by
  rw [sqDist, normSq_def', sqDist4, Fin.sum_univ_four]
  rfl

/-- **The coordinate graph is the quaternion graph.** -/
def quatIso : ratFourGraph ≃g quatGraph where
  toEquiv := toQuat
  map_rel_iff' := by
    intro x y
    show sqDist (toQuat x) (toQuat y) = 1 ↔ sqDist4 x y = 1
    rw [sqDist_toQuat]

/-- **The points of Euclidean four-space with rational coordinates.** -/
def ratPoints : Set (EuclideanSpace ℝ (Fin 4)) := {p | ∀ i, ∃ q : ℚ, (q : ℝ) = p.ofLp i}

/-- **`ratFourGraph` is the unit-distance graph of Euclidean four-space on its rational points** — the library's
`unitDistance` (adjacency `dist x y = 1`) induced on `ratPoints`. -/
theorem nonempty_iso_unitDistance :
    Nonempty (ratFourGraph ≃g (unitDistance (EuclideanSpace ℝ (Fin 4))).induce ratPoints) := by
  classical
  let f : (Fin 4 → ℚ) → ratPoints := fun x => ⟨WithLp.toLp 2 (fun i => (x i : ℝ)), fun i => ⟨x i, rfl⟩⟩
  have hf : Function.Bijective f := by
    constructor
    · intro x y h
      funext i
      have := congrArg (fun p : ratPoints => p.1.ofLp i) h
      simpa [f] using this
    · intro p
      refine ⟨fun i => (p.2 i).choose, ?_⟩
      apply Subtype.ext
      ext i
      exact (p.2 i).choose_spec
  refine ⟨⟨Equiv.ofBijective f hf, ?_⟩⟩
  intro x y
  simp only [Equiv.ofBijective_apply, SimpleGraph.induce_adj, unitDistance_adj, ratFourGraph_adj]
  rw [EuclideanSpace.dist_eq, Real.sqrt_eq_one]
  simp only [f, Real.dist_eq, sq_abs, sqDist4]
  rw [← Rat.cast_inj (α := ℝ)]
  push_cast
  rfl

/-! ## The 2-adic valuation of a squared length -/

/-- **`w(z) = v₂(|z|²)`**, the 2-adic valuation of the squared length (`0` at `z = 0`, Mathlib's convention). -/
def val (z : ℍ[ℚ]) : ℤ := padicValRat 2 (normSq z)

/-- **The rational unit vectors**, `|u|² = 1`. -/
def unitSphere : Set ℍ[ℚ] := {u | normSq u = 1}

/-! ## Spec -/

/-- The quaternion `1 + i`, of squared length 2. -/
def onePlusI : ℍ[ℚ] := ⟨1, 1, 0, 0⟩

example : normSq onePlusI = 2 := by
  rw [normSq_def']
  norm_num [onePlusI]

example : sqDist ⟨1, 0, 0, 0⟩ ⟨0, 1, 0, 0⟩ = 2 := by
  rw [sqDist, normSq_def']
  norm_num

example : quatGraph.Adj 0 ⟨1 / 2, 1 / 2, 1 / 2, 1 / 2⟩ := by
  rw [quatGraph_adj, sqDist, normSq_def']
  norm_num

example : ratFourGraph.Adj 0 ![3 / 5, 4 / 5, 0, 0] := by
  rw [ratFourGraph_adj, sqDist4, Fin.sum_univ_four]
  simp
  norm_num

example : val ⟨1, 1, 0, 0⟩ = 1 := by
  rw [val, normSq_def']
  norm_num
  exact padicValRat.self (p := 2) (by norm_num)

example : val ⟨1 / 3, 0, 0, 0⟩ = 0 := by
  rw [val, normSq_def']
  norm_num
  rw [one_div, padicValRat.inv, neg_eq_zero]
  have : ((9 : ℕ) : ℚ) = 9 := by norm_num
  rw [← this, padicValRat.of_nat, padicValNat.eq_zero_of_not_dvd (by norm_num)]
  rfl

end HadwigerNelson.RationalFour
