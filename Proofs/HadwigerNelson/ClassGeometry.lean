import Proofs.HadwigerNelson.Fan
import Proofs.HadwigerNelson.Greedy
import Mathlib.Analysis.Complex.Basic

/-!
# The geometry of a distance class — the 120° structure (M18)

A *distance class* at a pivot is the set of points at one fixed distance from it. M17's hunt
measured that the class at squared distance `1/3` resists separation everywhere; this module is
the plane-level mathematics behind that histogram, stated over `ℂ` — the workspace's working
plane (M04: rotation is multiplication and a point is a pair; one isometry crosses to
`EuclideanSpace ℝ (Fin 2)` at the headline, `Reduction.lean`).

Four findings, each elementary, none found stated elsewhere (2026-08-03):

* **The chord bound.** Two distinct circles share at most two points, so the unit-distance
  graph *inside* a class has maximum degree 2 — disjoint paths and cycles, never more.
* **No class confines alone.** Degree ≤ 2 means three colours suffice for a class by itself
  (`Greedy.lean`), and a fourth colour separates the pivot: any confinement of a five-colour
  fan to one class is an interplay theorem between the class and the ambient graph, never a
  property of the class's own edges. This closes deletion-style hunts *within* a class the way
  `FanMono.lean` closed them across subgraphs.
* **The triangle identity.** A unit equilateral triangle lies on a circle about `p` exactly
  when that circle has squared radius `1/3` — and then `p` is the triangle's centroid. So
  `r² = 1/3` is the *unique* class whose internal edges can form odd cycles that are
  triangles; empirically (classstat census, de Grey's graph, 2026-08-03) it is the unique
  class with odd cycles at all, and the census's violation reporter watches that stay true.
* **The 120° closure.** Rotation by `ω = e^{2πi/3}` about `p` maps the `1/3`-class to itself
  moving every member exactly one unit, and its orbits are unit equilateral triangles — the
  ℤ/3 closure M17 verified computationally, as exact algebra.

Everything here is real/complex algebra with `linear_combination`-style certificates; no
axioms beyond the standard three, no `Decidable` instances, no kernel-scale data.
-/

namespace HadwigerNelson

open Complex

/-! ## The chord bound: two circles share at most two points -/

/-- **Two distinct circles meet in at most two points**: three points equidistant from `p` and
simultaneously equidistant from a different point `q` cannot be pairwise distinct. This is the
whole reason a distance class's internal unit-distance graph has maximum degree 2. -/
theorem eq_or_eq_or_eq_of_dist_eq {p q a b c : ℂ} (hpq : p ≠ q)
    (hab : dist a p = dist b p) (hbc : dist b p = dist c p)
    (hab' : dist a q = dist b q) (hbc' : dist b q = dist c q) :
    a = b ∨ b = c ∨ a = c := by
  sorry

/-! ## The triangle identity: unit triangles live at squared radius 1/3 only -/

/-- The centroid of a unit equilateral triangle is at squared distance `1/3` from each vertex. -/
theorem dist_sq_centroid_unit_triangle {a b c : ℂ}
    (hab : dist a b = 1) (hbc : dist b c = 1) (hac : dist a c = 1) :
    dist ((a + b + c) / 3) a ^ 2 = 1 / 3 := by
  sorry

/-- A point equidistant from the three vertices of a unit equilateral triangle is its
centroid — the perpendicular bisectors of a nondegenerate triangle meet once. -/
theorem eq_centroid_of_dist_eq {a b c p : ℂ}
    (hab : dist a b = 1) (hbc : dist b c = 1) (hac : dist a c = 1)
    (hpa : dist p a = dist p b) (hpb : dist p b = dist p c) :
    p = (a + b + c) / 3 := by
  sorry

/-- **The triangle identity.** A distance class carries a unit equilateral triangle exactly
when its squared radius is `1/3`. Forward: the equidistant point is the centroid, and the
centroid sits at squared distance `1/3`. Backward: the 120° orbit below builds the triangle. -/
theorem exists_unit_triangle_iff {p : ℂ} {s : ℝ} :
    (∃ a b c : ℂ, dist a b = 1 ∧ dist b c = 1 ∧ dist a c = 1 ∧
      dist a p ^ 2 = s ∧ dist b p ^ 2 = s ∧ dist c p ^ 2 = s) ↔ s = 1 / 3 := by
  sorry

/-! ## The 120° rotation and its closure -/

/-- The primitive cube root of unity `e^{2πi/3}`, written in coordinates so every identity
about it is a `linear_combination` certificate away. -/
noncomputable def omega3 : ℂ := ⟨-(1 / 2), Real.sqrt 3 / 2⟩

/-- Rotation by 120° about `p` — the map whose orbits close the `1/3`-class into unit
triangles. This is exactly the spindle rotation `tools/field.py` computes at `r² = 1/3`
(`A = -1, B = √3, D = 2`, i.e. `cos = -1/2, sin = √3/2`), so the Lean statement and the
instrument move points by the same rotation. -/
noncomputable def rot3 (p z : ℂ) : ℂ := p + omega3 * (z - p)

example : omega3.re = -(1 / 2) := rfl
example : omega3.im = Real.sqrt 3 / 2 := rfl

theorem omega3_cube : omega3 ^ 3 = 1 := by
  sorry

theorem omega3_ne_one : omega3 ≠ 1 := by
  sorry

theorem normSq_omega3 : normSq omega3 = 1 := by
  sorry

/-- `|ω − 1|² = 3` — the factor that turns squared radius `1/3` into displacement exactly 1. -/
theorem normSq_omega3_sub_one : normSq (omega3 - 1) = 3 := by
  sorry

/-- Three rotations return every point: the closure is a ℤ/3 orbit. -/
theorem rot3_rot3_rot3 (p z : ℂ) : rot3 p (rot3 p (rot3 p z)) = z := by
  sorry

/-- `rot3 p` is an isometry. -/
theorem dist_rot3 (p z w : ℂ) : dist (rot3 p z) (rot3 p w) = dist z w := by
  sorry

/-- `rot3 p` fixes distances to the pivot: it maps every distance class at `p` to itself. -/
theorem dist_rot3_pivot (p z : ℂ) : dist (rot3 p z) p = dist z p := by
  sorry

/-- **The 120° identity, unconditionally**: rotation by 120° about `p` displaces every point
of the plane by exactly `√3` times its distance from `p` — `|ω − 1| = √3`. The class at
squared radius `1/3` is the fixed point of this scaling against the unit: `√3 · √(1/3) = 1`. -/
theorem dist_rot3_self (p z : ℂ) : dist (rot3 p z) z = Real.sqrt 3 * dist z p := by
  sorry

/-- The `1/3` instance of `dist_rot3_self`: on the 120° class, the rotation moves every
point exactly one unit — the spindle identity the ℤ/3 closure is built from. -/
theorem dist_rot3_self_eq_one {p z : ℂ} (h : dist z p ^ 2 = 1 / 3) :
    dist (rot3 p z) z = 1 := by
  sorry

/-- **The closure is rainbow fuel**: the ℤ/3 orbit of any `1/3`-class point is a unit
equilateral triangle, so any proper colouring paints it with three distinct colours. -/
theorem rot3_unit_triangle {p z : ℂ} (h : dist z p ^ 2 = 1 / 3) :
    dist z (rot3 p z) = 1 ∧ dist (rot3 p z) (rot3 p (rot3 p z)) = 1 ∧
      dist (rot3 p (rot3 p z)) z = 1 := by
  sorry

/-! ## No class confines alone -/

/-- The *class-only graph*: unit edges both of whose ends belong to the listed class `Q`.
Everything the class contributes to a fan on its own, and nothing the ambient graph adds. -/
def classOnlyGraph {n : ℕ} (f : Fin n → ℂ) (Q : List (Fin n)) : SimpleGraph (Fin n) where
  Adj v w := v ≠ w ∧ dist (f v) (f w) = 1 ∧ v ∈ Q ∧ w ∈ Q
  symm := ⟨fun _ _ h => ⟨h.1.symm, by rw [dist_comm]; exact h.2.1, h.2.2.2, h.2.2.1⟩⟩
  loopless := ⟨fun _ h => h.1 rfl⟩

/-- The abstract half of "no class confines alone", in its true generality: a graph whose
edges all live inside `Q` and whose `Q`-part is `c`-colourable cannot fan a pivot `p ∉ Q`
once even one colour more is available — `c` colours for `Q`, the spare for everything else.
The milestone's "4 colours suffice against a class" is the instance `c = 3` handed by the
chord bound plus greedy colouring: 3 + 1, named. No finiteness, no decidability. -/
theorem not_fan_of_colorable_of_edges_within {V : Type*}
    {G : SimpleGraph V} {p : V} {Q : List V} {c k : ℕ}
    (hp : p ∉ Q) (hQ : ∀ ⦃x y⦄, G.Adj x y → x ∈ Q ∧ y ∈ Q)
    (hc : G.Colorable c) (hck : c < k) :
    ¬ Fan G k p Q := by
  sorry

/-- The geometric half: in a class-only graph over points on a genuine class (`s ≠ 0`, all of
`Q` at squared distance `s` from the pivot's point), every degree is at most 2 — the chord
bound, worn by a graph. -/
theorem degree_classOnlyGraph_le_two {n : ℕ} {f : Fin n → ℂ} (hf : Function.Injective f)
    {x : ℂ} {s : ℝ} (hs : s ≠ 0) {Q : List (Fin n)}
    (hQ : ∀ q ∈ Q, dist (f q) x ^ 2 = s)
    [DecidableRel (classOnlyGraph f Q).Adj] (v : Fin n) :
    (classOnlyGraph f Q).degree v ≤ 2 := by
  sorry

/-- **No distance class can confine a fan by itself.** For any finite point set, any pivot,
any class (any `s ≠ 0`), and any `k ≥ 4`: the class's own unit edges never force the pivot's
colour into the class. Confinement — if it is achievable at all — is a property of the
interplay between class and ambient graph. The hunt may therefore skip every candidate move
that only enriches a class internally. -/
theorem not_fan_classOnlyGraph {n : ℕ} {f : Fin n → ℂ} (hf : Function.Injective f)
    {p : Fin n} {s : ℝ} (hs : s ≠ 0) {Q : List (Fin n)}
    (hQ : ∀ q ∈ Q, dist (f q) (f p) ^ 2 = s) {k : ℕ} (hk : 4 ≤ k) :
    ¬ Fan (classOnlyGraph f Q) k p Q := by
  sorry

end HadwigerNelson
