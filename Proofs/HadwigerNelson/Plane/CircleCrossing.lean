import Proofs.HadwigerNelson.Plane.Basic
import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.Analysis.Convex.Topology
import Mathlib.Geometry.Euclidean.Basic

/-!
# Two unit circles crossing at a point: the four regions, and the arcs through them (FS-124, second module)

Pure plane geometry under `data/fs124/claims-K2.md` (plan: `plans/FS124-kernel-plan-2.md`): no colouring, no measure
but for one positivity statement.

* `CircleSide` — the two open sides of a unit circle: `inside.region w = ball w 1`, `outside.region w =
  (closedBall w 1)ᶜ`. Every statement of the module that says "inside `S(w)`" or "outside `S(w)`" is a statement about
  one of these two sets, and the proofs are uniform in the side.
* `CrossAt p q z` — the unit circles about `p` and `q` both pass through `z` and cross there: `p ≠ q` (not the same
  circle) and `p + q ≠ 2 z` (not tangent from outside). A close pair `x`, `y` (`x ≠ y`, `dist x y < 2`) with a common
  unit point `w` is one (`crossAt_of_dist_lt_two`).
* `quadPt p q z σ τ ε = z + ε (± (z − p) ± (z − q))` — the explicit point in the region `σ.region p ∩ τ.region q`,
  for every `0 < ε < 1` (`CrossAt.quadPt_mem_region_left`, `_right`); the one computation is `norm_sq_quadrant`:
  `‖u + ε (s u + t v)‖² − 1 = 2 ε (1 + s t ⟪u, v⟫) (s + ε)` for unit `u`, `v` and signs `s`, `t`.
* `CrossAt.exists_mem_quadrant`, `CrossAt.volume_quadrant_pos` — each of the four regions meets every disc about `z`,
  in positive measure.
* `CrossAt.exists_mem_sphere_region` — the unit circle about `p` has points near `z` on each side of the unit circle
  about `q` (an intermediate value on a convex set between two quadrant points; the outside from the inside at the
  antipode `2 z − q`).
* `exists_ball_inter_spheres_subset` — two distinct unit circles through `x` meet near `x` at `x` only.
* `exists_convex_subset_region` — a disc inside a given side of `S(q)`, inside a given disc about a point `z` of
  `S(q)`, with `z` in its closure (the disc tangent to `S(q)` at `z`).

**Inhabitant** of `CrossAt`: `crossAt_zero_one_add_I` — the unit circles about `0` and `1 + i` cross at `1`.
-/

namespace HadwigerNelson.Plane

open Complex Set Metric MeasureTheory

/-! ## The two sides of a unit circle -/

/-- A side of a unit circle: its open inside or its open outside. -/
inductive CircleSide where
  /-- The open unit disc. -/
  | inside
  /-- The complement of the closed unit disc. -/
  | outside
  deriving DecidableEq

namespace CircleSide

/-- `−1` for the inside, `+1` for the outside: the sign of `dist z w − 1` on that side. -/
def sign : CircleSide → ℝ
  | inside => -1
  | outside => 1

/-- The other side. -/
def flip : CircleSide → CircleSide
  | inside => outside
  | outside => inside

/-- The side `σ` of the unit circle about `w`, as an open set. -/
def region (σ : CircleSide) (w : ℂ) : Set ℂ :=
  match σ with
  | inside => ball w 1
  | outside => (closedBall w 1)ᶜ

/-- Inside: at distance below `1`. -/
@[simp] theorem mem_region_inside {z w : ℂ} : z ∈ inside.region w ↔ dist z w < 1 := by
  sorry

/-- Outside: at distance above `1`. -/
@[simp] theorem mem_region_outside {z w : ℂ} : z ∈ outside.region w ↔ 1 < dist z w := by
  sorry

/-- A side is the set where `dist z w − 1` has the side's sign. -/
theorem mem_region_iff {σ : CircleSide} {z w : ℂ} : z ∈ σ.region w ↔ 0 < σ.sign * (dist z w - 1) := by
  sorry

/-- Each side is open. -/
theorem isOpen_region (σ : CircleSide) (w : ℂ) : IsOpen (σ.region w) := by
  sorry

/-- The sides read the distance only: `y` is on the side `σ` of the circle about `z` exactly when `z` is on the side `σ`
of the circle about `y`. -/
theorem mem_region_comm {σ : CircleSide} {y z : ℂ} : y ∈ σ.region z ↔ z ∈ σ.region y := by
  sorry

/-- The two sides are disjoint. -/
theorem disjoint_region_flip (σ : CircleSide) (w : ℂ) : Disjoint (σ.region w) (σ.flip.region w) := by
  sorry

/-- A point off the circle is on one of the two sides. -/
theorem mem_region_or_of_dist_ne {z w : ℂ} (h : dist z w ≠ 1) : z ∈ inside.region w ∨ z ∈ outside.region w := by
  sorry

/-- The other side of the inside is the outside. -/
@[simp] theorem flip_inside : inside.flip = outside := rfl

/-- The other side of the outside is the inside. -/
@[simp] theorem flip_outside : outside.flip = inside := rfl

/-- Flipping twice. -/
@[simp] theorem flip_flip (σ : CircleSide) : σ.flip.flip = σ := by
  sorry

/-- The open unit disc about the antipode `2 z − q` of `q` through a point `z` of its circle lies outside the unit
circle about `q`. -/
theorem ball_antipode_subset_outside {q z : ℂ} (hq : dist z q = 1) : ball (2 * z - q) 1 ⊆ outside.region q := by
  sorry

end CircleSide

/-! ## Two unit circles crossing at a point -/

/-- The unit circles about `p` and `q` **cross at `z`**: both pass through `z`, they are not the same circle and they
are not tangent there (`q` is not the antipode `2 z − p` of `p`). -/
structure CrossAt (p q z : ℂ) : Prop where
  /-- `z` is on the unit circle about `p`. -/
  left : dist z p = 1
  /-- `z` is on the unit circle about `q`. -/
  right : dist z q = 1
  /-- The circles are different. -/
  ne : p ≠ q
  /-- The circles are not tangent at `z`. -/
  ne_antipode : p + q ≠ 2 * z

/-- Crossing is symmetric in the two circles. -/
theorem CrossAt.symm {p q z : ℂ} (h : CrossAt p q z) : CrossAt q p z := by
  sorry

/-- The circle about `p` also crosses, at `z`, the circle about the antipode of `q`. -/
theorem CrossAt.antipode {p q z : ℂ} (h : CrossAt p q z) : CrossAt p (2 * z - q) z := by
  sorry

/-- **A close pair**: two different points less than `2` apart, and a point at distance `1` from both. -/
theorem crossAt_of_dist_lt_two {x y w : ℂ} (hne : x ≠ y) (hlt : dist x y < 2) (hwx : dist w x = 1)
    (hwy : dist w y = 1) : CrossAt x y w := by
  sorry

/-- Two different unit vectors that are not opposite have inner product strictly between `−1` and `1`. -/
theorem abs_real_inner_lt_one {u v : ℂ} (hu : ‖u‖ = 1) (hv : ‖v‖ = 1) (h₁ : u ≠ v) (h₂ : u ≠ -v) :
    |inner ℝ u v| < 1 := by
  have hle : |inner ℝ u v| ≤ 1 := by
    have := abs_real_inner_le_norm u v
    rwa [hu, hv, one_mul] at this
  rcases hle.lt_or_eq with h | h
  · exact h
  · exfalso
    rcases abs_eq (zero_le_one' ℝ) |>.mp h with h | h
    · exact h₁ ((inner_eq_one_iff_of_norm_eq_one hu hv).mp h)
    · exact h₂ ((inner_eq_neg_one_iff_of_norm_eq_one hu hv).mp h)

/-- At a crossing the two radii `z − p`, `z − q` have inner product strictly between `−1` and `1`. -/
theorem CrossAt.abs_inner_lt_one {p q z : ℂ} (h : CrossAt p q z) : |inner ℝ (z - p) (z - q)| < 1 := by
  sorry

/-- **The one computation**: for unit vectors `u`, `v` and signs `s`, `t`,
`‖u + ε (s u + t v)‖² − 1 = 2 ε (1 + s t ⟪u, v⟫) (s + ε)`. -/
theorem norm_sq_quadrant {u v : ℂ} (hu : ‖u‖ = 1) (hv : ‖v‖ = 1) {s t : ℝ} (hs : s = 1 ∨ s = -1)
    (ht : t = 1 ∨ t = -1) (ε : ℝ) :
    ‖u + ε • (s • u + t • v)‖ ^ 2 - 1 = 2 * ε * (1 + s * t * inner ℝ u v) * (s + ε) := by
  have hs2 : s ^ 2 = 1 := by rcases hs with rfl | rfl <;> norm_num
  have ht2 : t ^ 2 = 1 := by rcases ht with rfl | rfl <;> norm_num
  have hd : ‖s • u + t • v‖ ^ 2 = 2 + 2 * s * t * inner ℝ u v := by
    rw [norm_add_sq_real, norm_smul, norm_smul, hu, hv, inner_smul_left, inner_smul_right]
    simp only [Real.norm_eq_abs, mul_one, sq_abs, RCLike.conj_to_real]
    linear_combination hs2 + ht2
  have hi : inner ℝ u (ε • (s • u + t • v)) = ε * (s + t * inner ℝ u v) := by
    rw [inner_smul_right, inner_add_right, inner_smul_right, inner_smul_right, real_inner_self_eq_norm_sq, hu]
    ring
  rw [norm_add_sq_real, norm_smul, mul_pow, hd, hi, hu, Real.norm_eq_abs, sq_abs]
  linear_combination (-(2 * ε * t * inner ℝ u v)) * hs2

/-- The point `z + ε (σ (z − p) + τ (z − q))`: for `0 < ε < 1` it is on the side `σ` of the unit circle about `p` and
on the side `τ` of the unit circle about `q`. -/
noncomputable def quadPt (p q z : ℂ) (σ τ : CircleSide) (ε : ℝ) : ℂ :=
  z + ε • (σ.sign • (z - p) + τ.sign • (z - q))

/-- The quadrant point is on the chosen side of the first circle. -/
theorem CrossAt.quadPt_mem_region_left {p q z : ℂ} (h : CrossAt p q z) (σ τ : CircleSide) {ε : ℝ} (h0 : 0 < ε)
    (h1 : ε < 1) : quadPt p q z σ τ ε ∈ σ.region p := by
  sorry

/-- The quadrant point is on the chosen side of the second circle. -/
theorem CrossAt.quadPt_mem_region_right {p q z : ℂ} (h : CrossAt p q z) (σ τ : CircleSide) {ε : ℝ} (h0 : 0 < ε)
    (h1 : ε < 1) : quadPt p q z σ τ ε ∈ τ.region q := by
  sorry

/-- The quadrant point is within `2 ε` of `z`. -/
theorem dist_quadPt_le {p q z : ℂ} (hp : dist z p = 1) (hq : dist z q = 1) (σ τ : CircleSide) {ε : ℝ}
    (h0 : 0 ≤ ε) : dist (quadPt p q z σ τ ε) z ≤ 2 * ε := by
  sorry

/-- **Each of the four regions meets every disc about the crossing point.** -/
theorem CrossAt.exists_mem_quadrant {p q z : ℂ} (h : CrossAt p q z) (σ τ : CircleSide) {ρ : ℝ} (hρ : 0 < ρ) :
    ∃ y ∈ ball z ρ, y ∈ σ.region p ∧ y ∈ τ.region q := by
  sorry

/-- **Each of the four regions has positive measure in every disc about the crossing point.** -/
theorem CrossAt.volume_quadrant_pos {p q z : ℂ} (h : CrossAt p q z) (σ τ : CircleSide) {ρ : ℝ} (hρ : 0 < ρ) :
    0 < volume (ball z ρ ∩ σ.region p ∩ τ.region q) := by
  sorry

/-- **The circle about `p` passes, near `z`, through each side of the circle about `q`.** -/
theorem CrossAt.exists_mem_sphere_region {p q z : ℂ} (h : CrossAt p q z) (τ : CircleSide) {ρ : ℝ} (hρ : 0 < ρ) :
    ∃ y ∈ sphere p 1, y ∈ ball z ρ ∧ y ∈ τ.region q := by
  sorry

/-! ## Two circles through a point; tangent discs -/

/-- **Two different unit circles through `x` meet near `x` at `x` only.** -/
theorem exists_ball_inter_spheres_subset {w w' x : ℂ} (hne : w ≠ w') (hx : dist x w = 1) (hx' : dist x w' = 1) :
    ∃ η > 0, sphere w 1 ∩ sphere w' 1 ∩ ball x η ⊆ {x} := by
  sorry

/-- **The tangent disc**: for a point `z` of the unit circle about `q`, a side `σ` and `ρ > 0`, there is an open
convex set inside `ball z ρ`, on the side `σ` of the circle, with `z` in its closure. -/
theorem exists_convex_subset_region {q z : ℂ} (hqz : dist z q = 1) (σ : CircleSide) {ρ : ℝ} (hρ : 0 < ρ) :
    ∃ D : Set ℂ, IsOpen D ∧ Convex ℝ D ∧ z ∈ closure D ∧ D ⊆ ball z ρ ∩ σ.region q := by
  sorry

/-- A non-empty open set lies on no circle. -/
theorem exists_dist_ne_of_isOpen {P : Set ℂ} (hP : IsOpen P) (hne : P.Nonempty) (w : ℂ) (r : ℝ) :
    ∃ y ∈ P, dist y w ≠ r := by
  sorry

/-! ## Spec examples -/

/-- **Inhabitant** of `CrossAt`: the unit circles about `0` and `1 + i` cross at `1`. -/
theorem crossAt_zero_one_add_I : CrossAt (0 : ℂ) (1 + I) 1 := by
  sorry

/-- **Adversary**: a circle does not cross itself, and two circles tangent from outside do not cross. -/
example : ¬ CrossAt (0 : ℂ) 0 1 ∧ ¬ CrossAt (0 : ℂ) 2 1 :=
  ⟨fun h => h.ne rfl, fun h => h.ne_antipode (by norm_num)⟩

/-- The sides: `0` is inside the unit circle about `1/2`, and `2` is outside it. -/
example : (0 : ℂ) ∈ CircleSide.inside.region (1 / 2) ∧ (2 : ℂ) ∈ CircleSide.outside.region (1 / 2) := by
  sorry

/-- The quadrant point at the model crossing, outside the first circle and inside the second, at `ε = 1/2`:
`1 + (1/2) (1 − (−i)) = 3/2 + i/2`. -/
example : quadPt (0 : ℂ) (1 + I) 1 .outside .inside (1 / 2) = 3 / 2 + I / 2 := by
  sorry

end HadwigerNelson.Plane
