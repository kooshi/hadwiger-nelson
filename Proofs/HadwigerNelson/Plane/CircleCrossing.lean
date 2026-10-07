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
  exact Iff.rfl

/-- Outside: at distance above `1`. -/
@[simp] theorem mem_region_outside {z w : ℂ} : z ∈ outside.region w ↔ 1 < dist z w := by
  simp only [CircleSide.region, mem_compl_iff, mem_closedBall, not_le]

/-- A side is the set where `dist z w − 1` has the side's sign. -/
theorem mem_region_iff {σ : CircleSide} {z w : ℂ} : z ∈ σ.region w ↔ 0 < σ.sign * (dist z w - 1) := by
  cases σ
  · rw [mem_region_inside]
    simp only [CircleSide.sign]
    constructor <;> intro h <;> linarith
  · rw [mem_region_outside]
    simp only [CircleSide.sign]
    constructor <;> intro h <;> linarith

/-- Each side is open. -/
theorem isOpen_region (σ : CircleSide) (w : ℂ) : IsOpen (σ.region w) := by
  cases σ
  · exact isOpen_ball
  · exact isClosed_closedBall.isOpen_compl

/-- The sides read the distance only: `y` is on the side `σ` of the circle about `z` exactly when `z` is on the side `σ`
of the circle about `y`. -/
theorem mem_region_comm {σ : CircleSide} {y z : ℂ} : y ∈ σ.region z ↔ z ∈ σ.region y := by
  cases σ <;> simp [CircleSide.region, dist_comm]

/-- The two sides are disjoint. -/
theorem disjoint_region_flip (σ : CircleSide) (w : ℂ) : Disjoint (σ.region w) (σ.flip.region w) := by
  cases σ
  · exact Set.disjoint_left.mpr fun z hz hz' => (mem_region_outside.mp hz').not_gt (mem_region_inside.mp hz)
  · exact Set.disjoint_left.mpr fun z hz hz' => (mem_region_outside.mp hz).not_gt (mem_region_inside.mp hz')

/-- A point off the circle is on one of the two sides. -/
theorem mem_region_or_of_dist_ne {z w : ℂ} (h : dist z w ≠ 1) : z ∈ inside.region w ∨ z ∈ outside.region w := by
  rcases lt_or_gt_of_ne h with h | h
  · exact Or.inl (mem_region_inside.mpr h)
  · exact Or.inr (mem_region_outside.mpr h)

/-- The other side of the inside is the outside. -/
@[simp] theorem flip_inside : inside.flip = outside := rfl

/-- The other side of the outside is the inside. -/
@[simp] theorem flip_outside : outside.flip = inside := rfl

/-- Flipping twice. -/
@[simp] theorem flip_flip (σ : CircleSide) : σ.flip.flip = σ := by
  cases σ <;> rfl

/-- The open unit disc about the antipode `2 z − q` of `q` through a point `z` of its circle lies outside the unit
circle about `q`. -/
theorem ball_antipode_subset_outside {q z : ℂ} (hq : dist z q = 1) : ball (2 * z - q) 1 ⊆ outside.region q := by
  intro y hy
  rw [mem_region_outside]
  have h2 : dist (2 * z - q) q = 2 := by
    rw [dist_eq_norm, show 2 * z - q - q = 2 * (z - q) by ring, norm_mul, ← dist_eq_norm, hq, Complex.norm_ofNat,
      mul_one]
  have h3 := dist_triangle (2 * z - q) y q
  rw [mem_ball, dist_comm] at hy
  linarith

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
  exact ⟨h.right, h.left, h.ne.symm, by rw [add_comm]; exact h.ne_antipode⟩

/-- The circle about `p` also crosses, at `z`, the circle about the antipode of `q`. -/
theorem CrossAt.antipode {p q z : ℂ} (h : CrossAt p q z) : CrossAt p (2 * z - q) z := by
  refine ⟨h.left, ?_, fun hp => h.ne_antipode (by rw [hp]; ring), fun hp => h.ne (by linear_combination hp)⟩
  rw [dist_eq_norm, show z - (2 * z - q) = -(z - q) by ring, norm_neg, ← dist_eq_norm]
  exact h.right

/-- **A close pair**: two different points less than `2` apart, and a point at distance `1` from both. -/
theorem crossAt_of_dist_lt_two {x y w : ℂ} (hne : x ≠ y) (hlt : dist x y < 2) (hwx : dist w x = 1)
    (hwy : dist w y = 1) : CrossAt x y w := by
  refine ⟨hwx, hwy, hne, fun h => ?_⟩
  have h2 : dist x y = 2 := by
    rw [dist_eq_norm, show x - y = 2 * (x - w) by linear_combination -h, norm_mul, ← dist_eq_norm, dist_comm x w,
      hwx, Complex.norm_ofNat, mul_one]
  linarith

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
  exact abs_real_inner_lt_one (by rw [← dist_eq_norm]; exact h.left) (by rw [← dist_eq_norm]; exact h.right)
    (fun he => h.ne (by linear_combination -he)) (fun he => h.ne_antipode (by linear_combination -he))

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

/-- A side's sign is `1` or `−1`. -/
theorem CircleSide.sign_eq (σ : CircleSide) : σ.sign = 1 ∨ σ.sign = -1 := by
  cases σ
  · exact Or.inr rfl
  · exact Or.inl rfl

/-- A side's sign has absolute value `1`. -/
theorem CircleSide.abs_sign (σ : CircleSide) : |σ.sign| = 1 := by
  rcases σ.sign_eq with h | h <;> rw [h] <;> norm_num

/-- The sign of `N − 1` from the quadrant identity (`norm_sq_quadrant`): for `N ≥ 0`, `|r| < 1`, `0 < ε < 1` and signs
`s`, `t`, if `N² − 1 = 2 ε (1 + s t r) (s + ε)` then `N − 1` has the sign `s`. A real-variable statement carrying only
its own hypotheses. -/
theorem quadrant_sign_pos {N r ε s t : ℝ} (hN : 0 ≤ N) (hr1 : -1 < r) (hr2 : r < 1) (h0 : 0 < ε) (h1 : ε < 1)
    (hs : s = 1 ∨ s = -1) (ht : t = 1 ∨ t = -1) (key : N ^ 2 - 1 = 2 * ε * (1 + s * t * r) * (s + ε)) :
    0 < s * (N - 1) := by
  have hstr : 0 < 1 + s * t * r := by
    rcases hs with rfl | rfl <;> rcases ht with rfl | rfl <;> linarith
  rcases hs with rfl | rfl
  · have hpos : 0 < 2 * ε * (1 + 1 * t * r) * (1 + ε) := by positivity
    have hN1 : 1 < N := (one_lt_sq_iff₀ hN).mp (by linarith)
    linarith
  · have hneg : 0 < 2 * ε * (1 + -1 * t * r) * (1 - ε) := mul_pos (by positivity) (by linarith)
    have hN1 : N < 1 := (sq_lt_one_iff₀ hN).mp (by linarith)
    linarith

/-- The point `z + ε (σ (z − p) + τ (z − q))`: for `0 < ε < 1` it is on the side `σ` of the unit circle about `p` and
on the side `τ` of the unit circle about `q`. -/
noncomputable def quadPt (p q z : ℂ) (σ τ : CircleSide) (ε : ℝ) : ℂ :=
  z + ε • (σ.sign • (z - p) + τ.sign • (z - q))

/-- The quadrant point is on the chosen side of the first circle. -/
theorem CrossAt.quadPt_mem_region_left {p q z : ℂ} (h : CrossAt p q z) (σ τ : CircleSide) {ε : ℝ} (h0 : 0 < ε)
    (h1 : ε < 1) : quadPt p q z σ τ ε ∈ σ.region p := by
  have hr := abs_lt.mp h.abs_inner_lt_one
  have hu : ‖z - p‖ = 1 := by rw [← dist_eq_norm]; exact h.left
  have hv : ‖z - q‖ = 1 := by rw [← dist_eq_norm]; exact h.right
  have hd : dist (quadPt p q z σ τ ε) p = ‖(z - p) + ε • (σ.sign • (z - p) + τ.sign • (z - q))‖ := by
    rw [dist_eq_norm, quadPt, add_sub_right_comm]
  rw [CircleSide.mem_region_iff, hd]
  exact quadrant_sign_pos (norm_nonneg _) hr.1 hr.2 h0 h1 σ.sign_eq τ.sign_eq
    (norm_sq_quadrant hu hv σ.sign_eq τ.sign_eq ε)

/-- The quadrant point is on the chosen side of the second circle. -/
theorem CrossAt.quadPt_mem_region_right {p q z : ℂ} (h : CrossAt p q z) (σ τ : CircleSide) {ε : ℝ} (h0 : 0 < ε)
    (h1 : ε < 1) : quadPt p q z σ τ ε ∈ τ.region q := by
  have he : quadPt p q z σ τ ε = quadPt q p z τ σ ε := by
    rw [quadPt, quadPt, add_comm (σ.sign • (z - p))]
  rw [he]
  exact h.symm.quadPt_mem_region_left τ σ h0 h1

/-- The quadrant point is within `2 ε` of `z`. -/
theorem dist_quadPt_le {p q z : ℂ} (hp : dist z p = 1) (hq : dist z q = 1) (σ τ : CircleSide) {ε : ℝ}
    (h0 : 0 ≤ ε) : dist (quadPt p q z σ τ ε) z ≤ 2 * ε := by
  have h2 : ‖σ.sign • (z - p) + τ.sign • (z - q)‖ ≤ 2 := by
    calc ‖σ.sign • (z - p) + τ.sign • (z - q)‖ ≤ ‖σ.sign • (z - p)‖ + ‖τ.sign • (z - q)‖ := norm_add_le _ _
      _ = 2 := by
        rw [norm_smul, norm_smul, Real.norm_eq_abs, Real.norm_eq_abs, σ.abs_sign, τ.abs_sign, ← dist_eq_norm,
          ← dist_eq_norm, hp, hq]
        norm_num
  rw [dist_eq_norm, quadPt, add_sub_cancel_left, norm_smul, Real.norm_eq_abs, abs_of_nonneg h0, mul_comm]
  exact mul_le_mul_of_nonneg_right h2 h0

/-- **Each of the four regions meets every disc about the crossing point.** -/
theorem CrossAt.exists_mem_quadrant {p q z : ℂ} (h : CrossAt p q z) (σ τ : CircleSide) {ρ : ℝ} (hρ : 0 < ρ) :
    ∃ y ∈ ball z ρ, y ∈ σ.region p ∧ y ∈ τ.region q := by
  have hε0 : 0 < min (ρ / 4) (1 / 2) := lt_min (by positivity) (by norm_num)
  have hε1 : min (ρ / 4) (1 / 2) < 1 := lt_of_le_of_lt (min_le_right _ _) (by norm_num)
  refine ⟨quadPt p q z σ τ (min (ρ / 4) (1 / 2)), ?_, h.quadPt_mem_region_left σ τ hε0 hε1,
    h.quadPt_mem_region_right σ τ hε0 hε1⟩
  have h1 := dist_quadPt_le h.left h.right σ τ hε0.le
  have h2 : min (ρ / 4) (1 / 2) ≤ ρ / 4 := min_le_left _ _
  rw [mem_ball]
  linarith

/-- **Each of the four regions has positive measure in every disc about the crossing point.** -/
theorem CrossAt.volume_quadrant_pos {p q z : ℂ} (h : CrossAt p q z) (σ τ : CircleSide) {ρ : ℝ} (hρ : 0 < ρ) :
    0 < volume (ball z ρ ∩ σ.region p ∩ τ.region q) := by
  obtain ⟨y, hy, hyp, hyq⟩ := h.exists_mem_quadrant σ τ hρ
  exact ((isOpen_ball.inter (σ.isOpen_region p)).inter (τ.isOpen_region q)).measure_pos volume ⟨y, ⟨hy, hyp⟩, hyq⟩

/-- The circle about `p` passes, near `z`, through the inside of the circle about `q`: an intermediate value of the
distance to `p` on the convex set `ball z ρ ∩ ball q 1`, between the quadrant point inside both circles and the
quadrant point outside the first and inside the second. -/
theorem CrossAt.exists_mem_sphere_inside {p q z : ℂ} (h : CrossAt p q z) {ρ : ℝ} (hρ : 0 < ρ) :
    ∃ y ∈ sphere p 1, y ∈ ball z ρ ∧ y ∈ CircleSide.inside.region q := by
  obtain ⟨a, haz, hap, haq⟩ := h.exists_mem_quadrant .inside .inside hρ
  obtain ⟨b, hbz, hbp, hbq⟩ := h.exists_mem_quadrant .outside .inside hρ
  have hconv : IsPreconnected (ball z ρ ∩ ball q 1) := ((convex_ball z ρ).inter (convex_ball q 1)).isPreconnected
  have hcont : ContinuousOn (fun y : ℂ => dist y p) (ball z ρ ∩ ball q 1) :=
    (continuous_id.dist continuous_const).continuousOn
  obtain ⟨y, hy, hyp⟩ := hconv.intermediate_value (a := a) (b := b) ⟨haz, haq⟩ ⟨hbz, hbq⟩ hcont
    ⟨(CircleSide.mem_region_inside.mp hap).le, (CircleSide.mem_region_outside.mp hbp).le⟩
  exact ⟨y, hyp, hy.1, hy.2⟩

/-- **The circle about `p` passes, near `z`, through each side of the circle about `q`.** -/
theorem CrossAt.exists_mem_sphere_region {p q z : ℂ} (h : CrossAt p q z) (τ : CircleSide) {ρ : ℝ} (hρ : 0 < ρ) :
    ∃ y ∈ sphere p 1, y ∈ ball z ρ ∧ y ∈ τ.region q := by
  cases τ
  · exact h.exists_mem_sphere_inside hρ
  · obtain ⟨y, hyp, hyz, hyq⟩ := h.antipode.exists_mem_sphere_inside hρ
    exact ⟨y, hyp, hyz, CircleSide.ball_antipode_subset_outside h.right hyq⟩

/-! ## Two circles through a point; tangent discs -/

/-- **Two different unit circles through `x` meet near `x` at `x` only.** -/
theorem exists_ball_inter_spheres_subset {w w' x : ℂ} (hne : w ≠ w') (hx : dist x w = 1) (hx' : dist x w' = 1) :
    ∃ η > 0, sphere w 1 ∩ sphere w' 1 ∩ ball x η ⊆ {x} := by
  have hfin : Module.finrank ℝ ℂ = 2 := by rw [Module.finrank_eq_card_basis Complex.basisOneI, Fintype.card_fin]
  have h2w : dist (w + w' - x) w = 1 := by
    rw [dist_eq_norm, show w + w' - x - w = -(x - w') by ring, norm_neg, ← dist_eq_norm]; exact hx'
  have h2w' : dist (w + w' - x) w' = 1 := by
    rw [dist_eq_norm, show w + w' - x - w' = -(x - w) by ring, norm_neg, ← dist_eq_norm]; exact hx
  by_cases hp : x = w + w' - x
  · -- the circles are tangent at `x`: the parallelogram law about the midpoint `x` of the centres
    refine ⟨1, one_pos, ?_⟩
    rintro t ⟨⟨ht, ht'⟩, -⟩
    rw [mem_sphere, dist_eq_norm] at ht ht'
    have hpar := parallelogram_law_with_norm ℝ (t - x) (x - w)
    rw [show t - x + (x - w) = t - w by ring, show t - x - (x - w) = t - w' by linear_combination -hp, ht, ht',
      ← dist_eq_norm x w, hx] at hpar
    have h0 : ‖t - x‖ ^ 2 = 0 := by linarith
    rw [mem_singleton_iff, ← sub_eq_zero, ← norm_eq_zero]
    exact pow_eq_zero_iff (two_ne_zero) |>.mp h0
  · -- the circles meet at `x` and at `w + w' − x` only
    refine ⟨dist x (w + w' - x), dist_pos.mpr hp, ?_⟩
    rintro t ⟨⟨ht, ht'⟩, htb⟩
    rcases EuclideanGeometry.eq_of_dist_eq_of_dist_eq_of_finrank_eq_two (V := ℂ) (P := ℂ) hfin hne hp hx h2w ht hx'
      h2w' ht' with h | h
    · exact h
    · rw [h, mem_ball, dist_comm] at htb
      exact absurd htb (lt_irrefl _)

/-- **The tangent disc**: for a point `z` of the unit circle about `q`, a side `σ` and `ρ > 0`, there is an open
convex set inside `ball z ρ`, on the side `σ` of the circle, with `z` in its closure. -/
theorem exists_convex_subset_region {q z : ℂ} (hqz : dist z q = 1) (σ : CircleSide) {ρ : ℝ} (hρ : 0 < ρ) :
    ∃ D : Set ℂ, IsOpen D ∧ Convex ℝ D ∧ z ∈ closure D ∧ D ⊆ ball z ρ ∩ σ.region q := by
  have hr : 0 < min ρ 1 / 2 := by positivity
  have hr1 : min ρ 1 / 2 ≤ 1 / 2 := by have := min_le_right ρ 1; linarith
  have hrρ : min ρ 1 / 2 ≤ ρ / 2 := by have := min_le_left ρ 1; linarith
  have hn : ‖z - q‖ = 1 := by rw [← dist_eq_norm]; exact hqz
  set r := min ρ 1 / 2 with hrdef
  set c := z + (σ.sign * r) • (z - q) with hcdef
  have hcz : dist c z = r := by
    rw [dist_eq_norm, hcdef, add_sub_cancel_left, norm_smul, hn, mul_one, Real.norm_eq_abs, abs_mul, σ.abs_sign,
      one_mul, abs_of_pos hr]
  have hcq : dist c q = 1 + σ.sign * r := by
    rw [dist_eq_norm, hcdef, show z + (σ.sign * r) • (z - q) - q = (1 + σ.sign * r) • (z - q) by
      rw [add_smul, one_smul]; abel, norm_smul, hn, mul_one, Real.norm_eq_abs]
    refine abs_of_nonneg ?_
    rcases σ.sign_eq with hs | hs <;> rw [hs] <;> linarith
  refine ⟨ball c r, isOpen_ball, convex_ball c r, ?_, fun y hy => ⟨?_, ?_⟩⟩
  · rw [closure_ball c hr.ne', mem_closedBall, dist_comm, hcz]
  · rw [mem_ball] at hy ⊢
    have := dist_triangle y c z
    linarith
  · rw [mem_ball] at hy
    cases σ
    · rw [CircleSide.mem_region_inside]
      have h1 := dist_triangle y c q
      simp only [CircleSide.sign] at hcq
      linarith
    · rw [CircleSide.mem_region_outside]
      have h1 := dist_triangle c y q
      rw [dist_comm c y] at h1
      simp only [CircleSide.sign] at hcq
      linarith

/-- A non-empty open set lies on no circle. -/
theorem exists_dist_ne_of_isOpen {P : Set ℂ} (hP : IsOpen P) (hne : P.Nonempty) (w : ℂ) (r : ℝ) :
    ∃ y ∈ P, dist y w ≠ r := by
  by_contra hcon
  push Not at hcon
  have hsub : P ⊆ sphere w r := fun y hy => hcon y hy
  exact (hP.measure_pos volume hne).ne' (measure_mono_null hsub (Measure.addHaar_sphere volume w r))

/-! ## Spec examples -/

/-- **Inhabitant** of `CrossAt`: the unit circles about `0` and `1 + i` cross at `1`. -/
theorem crossAt_zero_one_add_I : CrossAt (0 : ℂ) (1 + I) 1 := by
  refine ⟨by simp, ?_, fun h => ?_, fun h => ?_⟩
  · rw [dist_eq_norm, show (1 : ℂ) - (1 + I) = -I by ring, norm_neg, Complex.norm_I]
  · simpa using congrArg Complex.re h
  · simpa using congrArg Complex.im h

/-- **Adversary**: a circle does not cross itself, and two circles tangent from outside do not cross. -/
example : ¬ CrossAt (0 : ℂ) 0 1 ∧ ¬ CrossAt (0 : ℂ) 2 1 :=
  ⟨fun h => h.ne rfl, fun h => h.ne_antipode (by norm_num)⟩

/-- The sides: `0` is inside the unit circle about `1/2`, and `2` is outside it. -/
example : (0 : ℂ) ∈ CircleSide.inside.region (1 / 2) ∧ (2 : ℂ) ∈ CircleSide.outside.region (1 / 2) := by
  refine ⟨CircleSide.mem_region_inside.mpr ?_, CircleSide.mem_region_outside.mpr ?_⟩
  · rw [dist_eq_norm, zero_sub, norm_neg]; norm_num
  · rw [dist_eq_norm, show (2 : ℂ) - 1 / 2 = 3 / 2 by norm_num]; norm_num

/-- The quadrant point at the model crossing, outside the first circle and inside the second, at `ε = 1/2`:
`1 + (1/2) (1 − (−i)) = 3/2 + i/2`. -/
example : quadPt (0 : ℂ) (1 + I) 1 .outside .inside (1 / 2) = 3 / 2 + I / 2 := by
  simp only [quadPt, CircleSide.sign]
  apply Complex.ext
  · simp
    norm_num
  · simp

end HadwigerNelson.Plane
