import Proofs.HadwigerNelson.Coupled

/-! # The general gluing classification (M22)

M21 classified the four circle-pair intersections of the unit-distance pivot pair —
axis length 1, radii drawn from {1, 1/√3}. Two consumers immediately demand the general
statement: the **partner construction** (M22 thread 1: the unit-partners of a lattice
point `x` on a circle `(c, r)` are `sphere x 1 ∩ sphere c r`, an intersection whose
axis `dist x c` is generically neither 1 nor even rational), and the **metapivot
system** (M23 horizon: the centroid couples to its pivots at axis 1/√3). This module
states the classification once, for any two distinct centres and any two nonnegative
radii: when the annulus condition holds, the intersection is exactly a named point and
its mirror across the axis; outside it, the intersection is empty.

The named point's frame components are division-free — `⟨A, √(r₁²d² − A²)⟩` with one
frame-inverting division `/conj(q−p)` — and the `√`'s argument is the gluing
discriminant, the square root the partner construction adjoins. That the formula IS
the field-growth meter is the point: the tools-side closure (`tools/couple.py
--partner`) cites this statement as the definition of the move, so the construction is
stated, not merely computed.

The mirror operator is ratio conjugation — M21's mirror identity elevated to the
definition; at unit axis it collapses to `Coupled.reflAcross` (the bridge lemma). The
module also hosts the nine-step near-cycle (§2.3): the first certified near-relation,
kept by the domain pass because both its halves are exact field arithmetic.

Relation to Mathlib: the *uniqueness* half exists there —
`EuclideanGeometry.eq_of_mem_sphere_of_mem_sphere_of_finrank_eq_two` (two spheres in a
plane meet in at most two points) — but not the constructive half: where the points
are, and when there are two rather than one or none. This module is the constructive
complement. (Citation surfaced by the `opus-larp` branch's parallel M22 pass.)
-/

namespace HadwigerNelson
namespace Glue

open Complex Compulsion

/-! ## The operators -/

/-- Reflection across the line through `p` and `q`, any `p ≠ q`: **conjugate the axis
ratio** — `z ↦ p + (q−p)·conj((z−p)/(q−p))`. M21's mirror identity
(`reflAcross` conjugates the ratio — the obligation-pass lemma `reflAcross_ratio`)
elevated to the definition; at unit axis it collapses to `Coupled.reflAcross`
(`reflAxis_eq_reflAcross`). Total: at `p = q` the ratio is junk `0` and the map
degenerates to `const p`; every theorem carries `p ≠ q`. -/
noncomputable def reflAxis (p q z : ℂ) : ℂ :=
  p + (q - p) * (starRingEnd ℂ) ((z - p) / (q - p))

/-- The (+)-branch intersection of `sphere p r₁` and `sphere q r₂`, explicit and
division-once. In the frame `v = (x−p)·conj(q−p)` the point is the DIVISION-FREE pair
`⟨A, √(r₁²d² − A²)⟩` with `d² = normSq (q−p)`, `A = (d² + r₁² − r₂²)/2` (two pinned
norms fix `v.re = A` exactly — no denominator); the single division is the frame's
inverse, `·/conj(q−p)` (legitimate because `(q−p)·conj(q−p) = d²`). The `√`'s argument
is the **gluing discriminant** — nonnegative exactly on the annulus condition, and the
square root the partner construction adjoins: the formula IS the field-growth meter.
Total: outside the annulus the `√` clamps to 0 and the point simply fails membership
(the intersection is then empty — `sphere_inter_sphere_eq_empty_*`); at tangency the
point equals its mirror and the classification's pair degenerates to a singleton. -/
noncomputable def gluePoint (p q : ℂ) (r₁ r₂ : ℝ) : ℂ :=
  p + (⟨(normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2,
        Real.sqrt (r₁ ^ 2 * normSq (q - p)
          - ((normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2) ^ 2)⟩ : ℂ)
      / (starRingEnd ℂ) (q - p)

/-! ## Private children (the obligation pass's decomposition)

The √-product engines first: every component identity below is a `linear_combination`
over these six lines, and the two decimal bounds carry the annulus checks and the
near-cycle's final inequality. -/

private theorem sq_sqrt3 : Real.sqrt 3 * Real.sqrt 3 = 3 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sq_sqrt11 : Real.sqrt 11 * Real.sqrt 11 = 11 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sq_sqrt33 : Real.sqrt 33 * Real.sqrt 33 = 33 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sqrt3_mul_sqrt11 : Real.sqrt 3 * Real.sqrt 11 = Real.sqrt 33 := by
  rw [← Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 3)]
  norm_num

private theorem sqrt3_mul_sqrt33 : Real.sqrt 3 * Real.sqrt 33 = 3 * Real.sqrt 11 := by
  rw [← sqrt3_mul_sqrt11, ← mul_assoc, sq_sqrt3]

private theorem sqrt11_mul_sqrt33 : Real.sqrt 11 * Real.sqrt 33 = 11 * Real.sqrt 3 := by
  rw [← sqrt3_mul_sqrt11,
    show Real.sqrt 11 * (Real.sqrt 3 * Real.sqrt 11)
      = Real.sqrt 11 * Real.sqrt 11 * Real.sqrt 3 by ring, sq_sqrt11]

private theorem sqrt3_gt : 1.7320508 < Real.sqrt 3 :=
  (Real.lt_sqrt (by norm_num)).mpr (by norm_num)

private theorem sqrt3_lt : Real.sqrt 3 < 1.7320509 :=
  (Real.sqrt_lt' (by norm_num)).mpr (by norm_num)

private theorem sqrt11_gt : 3.3166247 < Real.sqrt 11 :=
  (Real.lt_sqrt (by norm_num)).mpr (by norm_num)

/-- Conjugation on explicit components (Coupled's private `conj_mk`, re-minted). -/
private theorem conj_mk (a b : ℝ) : (starRingEnd ℂ) (⟨a, b⟩ : ℂ) = ⟨a, -b⟩ := by
  refine Complex.ext ?_ ?_ <;> simp

/-- The axis engine: `normSq (q − p) = (dist p q)²` — converts every annulus
hypothesis (about `dist`) into frame arithmetic (about `normSq`). -/
private theorem normSq_eq_dist_sq (p q : ℂ) : normSq (q - p) = dist p q ^ 2 := by
  rw [dist_comm, Complex.dist_eq, Complex.sq_norm]

/-- The annulus pair forces both radii nonnegative — the reason the classification
does not assume them. (`0 ≤ D` is itself derivable from the pair, so it is not
assumed either: the implementation deleted the dead hypothesis.) -/
private theorem nonneg_of_annulus {r₁ r₂ D : ℝ}
    (hlo : |r₁ - r₂| ≤ D) (hhi : D ≤ r₁ + r₂) : 0 ≤ r₁ ∧ 0 ≤ r₂ := by
  obtain ⟨h1, h2⟩ := abs_le.mp hlo
  constructor <;> linarith

/-- The gluing discriminant is nonnegative on the annulus: Heron's factorization
`4·disc = (r₁+r₂−D)(r₂+D−r₁)(D+r₁−r₂)(D+r₁+r₂)`, all four factors nonnegative. -/
private theorem disc_nonneg {r₁ r₂ D : ℝ}
    (hlo : |r₁ - r₂| ≤ D) (hhi : D ≤ r₁ + r₂) :
    0 ≤ r₁ ^ 2 * D ^ 2 - ((D ^ 2 + r₁ ^ 2 - r₂ ^ 2) / 2) ^ 2 := by
  have hD : 0 ≤ D := le_trans (abs_nonneg _) hlo
  obtain ⟨hr₁, hr₂⟩ := nonneg_of_annulus hlo hhi
  obtain ⟨h1, h2⟩ := abs_le.mp hlo
  nlinarith [mul_nonneg (mul_nonneg (mul_nonneg
    (show (0 : ℝ) ≤ r₁ + r₂ - D by linarith)
    (show (0 : ℝ) ≤ r₂ + D - r₁ by linarith))
    (show (0 : ℝ) ≤ D + r₁ - r₂ by linarith))
    (show (0 : ℝ) ≤ D + r₁ + r₂ by linarith)]

/-- Sphere membership as a `normSq` identity — the door between metric statements and
frame arithmetic, one lemma for every membership in the module. -/
private theorem mem_sphere_iff_normSq {c x : ℂ} {r : ℝ} (hr : 0 ≤ r) :
    x ∈ Metric.sphere c r ↔ normSq (x - c) = r ^ 2 := by
  rw [Metric.mem_sphere, normSq_eq_dist_sq c x, dist_comm c x]
  constructor
  · intro h
    rw [h]
  · intro h
    calc dist x c = Real.sqrt (dist x c ^ 2) := (Real.sqrt_sq dist_nonneg).symm
      _ = Real.sqrt (r ^ 2) := by rw [h]
      _ = r := Real.sqrt_sq hr

/-- The mirror conjugates the frame: `reflAxis` on `p + w/conj(q−p)` conjugates `w`.
The general-axis face of M21's `reflAcross_ratio`; every mirror branch is this line. -/
private theorem reflAxis_apply_frame {p q : ℂ} (h : p ≠ q) (w : ℂ) :
    reflAxis p q (p + w / (starRingEnd ℂ) (q - p))
      = p + (starRingEnd ℂ) w / (starRingEnd ℂ) (q - p) := by
  have hqp : q - p ≠ 0 := sub_ne_zero.mpr (Ne.symm h)
  have hc : (starRingEnd ℂ) (q - p) ≠ 0 := by
    simpa only [ne_eq, map_eq_zero] using hqp
  simp only [reflAxis, add_sub_cancel_left, map_div₀, Complex.conj_conj]
  field_simp

/-! ## The reflection package, general axis -/

/-- The reflection fixes the first pivot. -/
theorem reflAxis_pivot_left (p q : ℂ) : reflAxis p q p = p := by
  simp [reflAxis]

/-- The reflection fixes the second pivot (any distinct pair — the M21 unit premise
was the normalization, not the mechanism). -/
theorem reflAxis_pivot_right {p q : ℂ} (h : p ≠ q) : reflAxis p q q = q := by
  have hqp : q - p ≠ 0 := sub_ne_zero.mpr (Ne.symm h)
  simp [reflAxis, div_self hqp]

/-- The reflection is an involution. -/
theorem reflAxis_reflAxis {p q : ℂ} (h : p ≠ q) (z : ℂ) :
    reflAxis p q (reflAxis p q z) = z := by
  have hqp : q - p ≠ 0 := sub_ne_zero.mpr (Ne.symm h)
  have hc : (starRingEnd ℂ) (q - p) ≠ 0 := by
    simpa only [ne_eq, map_eq_zero] using hqp
  simp only [reflAxis, add_sub_cancel_left, map_div₀, map_mul, Complex.conj_conj]
  field_simp
  ring

/-- The reflection is an isometry. -/
theorem dist_reflAxis {p q : ℂ} (h : p ≠ q) (z w : ℂ) :
    dist (reflAxis p q z) (reflAxis p q w) = dist z w := by
  have hqp : q - p ≠ 0 := sub_ne_zero.mpr (Ne.symm h)
  have hn : ‖q - p‖ ≠ 0 := norm_ne_zero_iff.mpr hqp
  have hkey : reflAxis p q z - reflAxis p q w
      = (q - p) * (starRingEnd ℂ) ((z - w) / (q - p)) := by
    have hdivsub : (z - p) / (q - p) - (w - p) / (q - p) = (z - w) / (q - p) := by
      rw [div_sub_div_same]
      congr 1
      ring
    calc reflAxis p q z - reflAxis p q w
        = (q - p) * ((starRingEnd ℂ) ((z - p) / (q - p))
            - (starRingEnd ℂ) ((w - p) / (q - p))) := by
          simp only [reflAxis]
          ring
      _ = (q - p) * (starRingEnd ℂ) ((z - w) / (q - p)) := by
          rw [← map_sub, hdivsub]
  rw [Complex.dist_eq, Complex.dist_eq, hkey, norm_mul, RCLike.norm_conj, norm_div]
  field_simp

/-- Mirrors stay on every circle about `p`. -/
theorem reflAxis_mem_sphere_left {p q z : ℂ} (h : p ≠ q) {r : ℝ}
    (hz : z ∈ Metric.sphere p r) : reflAxis p q z ∈ Metric.sphere p r := by
  simp only [Metric.mem_sphere] at hz ⊢
  calc dist (reflAxis p q z) p
      = dist (reflAxis p q z) (reflAxis p q p) := by rw [reflAxis_pivot_left]
    _ = dist z p := dist_reflAxis h z p
    _ = r := hz

/-- Mirrors stay on every circle about `q`. -/
theorem reflAxis_mem_sphere_right {p q z : ℂ} (h : p ≠ q) {r : ℝ}
    (hz : z ∈ Metric.sphere q r) : reflAxis p q z ∈ Metric.sphere q r := by
  simp only [Metric.mem_sphere] at hz ⊢
  calc dist (reflAxis p q z) q
      = dist (reflAxis p q z) (reflAxis p q q) := by rw [reflAxis_pivot_right h]
    _ = dist z q := dist_reflAxis h z q
    _ = r := hz

/-- At unit axis the general mirror is M21's: the bridge to `Coupled.reflAcross`. -/
theorem reflAxis_eq_reflAcross {p q : ℂ} (h : dist p q = 1) :
    reflAxis p q = Coupled.reflAcross p q := by
  have hone : (q - p) * (starRingEnd ℂ) (q - p) = 1 := by
    rw [Complex.mul_conj, normSq_eq_dist_sq, h]
    norm_num
  have hqp : q - p ≠ 0 := by
    intro h0
    rw [h0, zero_mul] at hone
    exact zero_ne_one hone
  have hc : (starRingEnd ℂ) (q - p) ≠ 0 := by
    simpa only [ne_eq, map_eq_zero] using hqp
  funext z
  simp only [reflAxis, Coupled.reflAcross, map_div₀]
  field_simp
  linear_combination -((q - p) * (starRingEnd ℂ) (z - p)) * hone

/-! ## The classification -/

/-- **The general gluing classification.** Two distinct centres, radii satisfying the
annulus condition: the intersection is exactly the glue point and its mirror. Subsumes
M21's four unit-axis gluings; instantiates at every partner adjunction (`x`, `c`, `1`,
`r`) and at the metapivot couplings (axis 1/√3). Tangency (equality in either bound)
is the case `gluePoint = its mirror`; the two-element notation collapses and the
statement stands — as does the zero-radius degeneracy (`r₁ = 0`, `d = r₂`: both
points collapse onto `p`). Radius nonnegativity is NOT assumed: it is derivable from
the annulus pair (`|r₁ − r₂| ≤ d ≤ r₁ + r₂` forces both radii ≥ 0 — the obligation
pass re-derives it internally), so the hypotheses are exactly the three that bind:
distinct centres and the two annulus bounds. -/
theorem sphere_inter_sphere {p q : ℂ} (hpq : p ≠ q) {r₁ r₂ : ℝ}
    (hlo : |r₁ - r₂| ≤ dist p q) (hhi : dist p q ≤ r₁ + r₂) :
    Metric.sphere p r₁ ∩ Metric.sphere q r₂
      = {gluePoint p q r₁ r₂, reflAxis p q (gluePoint p q r₁ r₂)} := by
  obtain ⟨hr₁, hr₂⟩ := nonneg_of_annulus hlo hhi
  have hqp : q - p ≠ 0 := sub_ne_zero.mpr (Ne.symm hpq)
  have hc : (starRingEnd ℂ) (q - p) ≠ 0 := by
    simpa only [ne_eq, map_eq_zero] using hqp
  have hN : (0 : ℝ) < normSq (q - p) := normSq_pos.mpr hqp
  have hdisc : 0 ≤ r₁ ^ 2 * normSq (q - p)
      - ((normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2) ^ 2 := by
    have h := disc_nonneg hlo hhi
    rw [← normSq_eq_dist_sq] at h
    exact h
  have hgp_def : gluePoint p q r₁ r₂
      = p + (⟨(normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2,
          Real.sqrt (r₁ ^ 2 * normSq (q - p)
            - ((normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2) ^ 2)⟩ : ℂ)
        / (starRingEnd ℂ) (q - p) := rfl
  -- the glue point is on both spheres (the ⊇ direction's content, minted first)
  have hg1 : gluePoint p q r₁ r₂ ∈ Metric.sphere p r₁ := by
    rw [mem_sphere_iff_normSq hr₁, hgp_def, add_sub_cancel_left, normSq_div, normSq_conj,
      normSq_mk, Real.mul_self_sqrt hdisc]
    field_simp
    ring
  have hg2 : gluePoint p q r₁ r₂ ∈ Metric.sphere q r₂ := by
    rw [mem_sphere_iff_normSq hr₂]
    have hdiff : gluePoint p q r₁ r₂ - q
        = ((⟨(normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2,
            Real.sqrt (r₁ ^ 2 * normSq (q - p)
              - ((normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2) ^ 2)⟩ : ℂ)
            - (normSq (q - p) : ℂ)) / (starRingEnd ℂ) (q - p) := by
      rw [hgp_def]
      field_simp
      linear_combination -(Complex.mul_conj (q - p))
    rw [hdiff,
      show ((⟨(normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2,
          Real.sqrt (r₁ ^ 2 * normSq (q - p)
            - ((normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2) ^ 2)⟩ : ℂ)
          - (normSq (q - p) : ℂ))
        = (⟨(normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2 - normSq (q - p),
            Real.sqrt (r₁ ^ 2 * normSq (q - p)
              - ((normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2) ^ 2)⟩ : ℂ) from by
        refine Complex.ext ?_ ?_ <;> simp,
      normSq_div, normSq_conj, normSq_mk, Real.mul_self_sqrt hdisc]
    field_simp
    ring
  apply Set.Subset.antisymm
  · -- ⊆ : the frame `v = (x−p)·conj(q−p)` has both norms pinned; two roots
    intro x hx
    rw [Set.mem_inter_iff, mem_sphere_iff_normSq hr₁, mem_sphere_iff_normSq hr₂] at hx
    obtain ⟨hx1, hx2⟩ := hx
    have hv1 : normSq ((x - p) * (starRingEnd ℂ) (q - p)) = r₁ ^ 2 * normSq (q - p) := by
      rw [normSq_mul, normSq_conj, hx1]
    have hvsub : (x - p) * (starRingEnd ℂ) (q - p) - (normSq (q - p) : ℂ)
        = (x - q) * (starRingEnd ℂ) (q - p) := by
      rw [← Complex.mul_conj]
      ring
    have hv2 : normSq ((x - p) * (starRingEnd ℂ) (q - p) - (normSq (q - p) : ℂ))
        = r₂ ^ 2 * normSq (q - p) := by
      rw [hvsub, normSq_mul, normSq_conj, hx2]
    have e1 : ((x - p) * (starRingEnd ℂ) (q - p)).re * ((x - p) * (starRingEnd ℂ) (q - p)).re
        + ((x - p) * (starRingEnd ℂ) (q - p)).im * ((x - p) * (starRingEnd ℂ) (q - p)).im
        = r₁ ^ 2 * normSq (q - p) := by
      rw [← normSq_apply]
      exact hv1
    have e2 : (((x - p) * (starRingEnd ℂ) (q - p)).re - normSq (q - p))
          * (((x - p) * (starRingEnd ℂ) (q - p)).re - normSq (q - p))
        + ((x - p) * (starRingEnd ℂ) (q - p)).im * ((x - p) * (starRingEnd ℂ) (q - p)).im
        = r₂ ^ 2 * normSq (q - p) := by
      have h := hv2
      rw [normSq_apply, Complex.sub_re, Complex.sub_im, Complex.ofReal_re,
        Complex.ofReal_im, sub_zero] at h
      exact h
    have hre : ((x - p) * (starRingEnd ℂ) (q - p)).re
        = (normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2 := by
      have h2 : ((x - p) * (starRingEnd ℂ) (q - p)).re * (2 * normSq (q - p))
          = ((normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2) * (2 * normSq (q - p)) := by
        linear_combination e1 - e2
      exact mul_right_cancel₀ (by linarith : (0 : ℝ) < 2 * normSq (q - p)).ne' h2
    have him2 : ((x - p) * (starRingEnd ℂ) (q - p)).im
          * ((x - p) * (starRingEnd ℂ) (q - p)).im
        = Real.sqrt (r₁ ^ 2 * normSq (q - p)
            - ((normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2) ^ 2)
          * Real.sqrt (r₁ ^ 2 * normSq (q - p)
            - ((normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2) ^ 2) := by
      rw [Real.mul_self_sqrt hdisc]
      linear_combination e1 - (((x - p) * (starRingEnd ℂ) (q - p)).re
        + (normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2) * hre
    have hxv : x = p + ((x - p) * (starRingEnd ℂ) (q - p)) / (starRingEnd ℂ) (q - p) := by
      rw [mul_div_cancel_right₀ _ hc]
      ring
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff]
    rcases mul_self_eq_mul_self_iff.mp him2 with hb | hb
    · left
      rw [hxv, hgp_def]
      congr 2
      exact Complex.ext hre hb
    · right
      rw [hxv,
        show reflAxis p q (gluePoint p q r₁ r₂)
          = p + (starRingEnd ℂ) (⟨(normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2,
              Real.sqrt (r₁ ^ 2 * normSq (q - p)
                - ((normSq (q - p) + r₁ ^ 2 - r₂ ^ 2) / 2) ^ 2)⟩ : ℂ)
            / (starRingEnd ℂ) (q - p) from reflAxis_apply_frame hpq _,
        conj_mk]
      congr 2
      exact Complex.ext hre hb
  · -- ⊇ : both named points are on both spheres
    intro x hx
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hx
    rcases hx with rfl | rfl
    · exact ⟨hg1, hg2⟩
    · exact ⟨reflAxis_mem_sphere_left hpq hg1, reflAxis_mem_sphere_right hpq hg2⟩

/-- Empty outside the annulus, far side: the circles are too separated to meet. -/
theorem sphere_inter_sphere_eq_empty_of_far {p q : ℂ} {r₁ r₂ : ℝ}
    (hhi : r₁ + r₂ < dist p q) :
    Metric.sphere p r₁ ∩ Metric.sphere q r₂ = ∅ := by
  ext x
  simp only [Set.mem_inter_iff, Metric.mem_sphere, Set.mem_empty_iff_false, iff_false,
    not_and]
  intro h1 h2
  have ht := dist_triangle p x q
  rw [dist_comm p x, h1, h2] at ht
  linarith

/-- Empty outside the annulus, nested side: one circle strictly inside the other. -/
theorem sphere_inter_sphere_eq_empty_of_nested {p q : ℂ} {r₁ r₂ : ℝ}
    (hlo : dist p q < |r₁ - r₂|) :
    Metric.sphere p r₁ ∩ Metric.sphere q r₂ = ∅ := by
  ext x
  simp only [Set.mem_inter_iff, Metric.mem_sphere, Set.mem_empty_iff_false, iff_false,
    not_and]
  intro h1 h2
  have ht := abs_dist_sub_le p q x
  rw [dist_comm p x, dist_comm q x, h1, h2] at ht
  linarith

/-! ## Specification

Non-vacuity at a NON-unit axis (the whole point of the generalization), the bridge to
the M21 case, the far empty case, and the adversarial member refuted through the
classification's right-hand side. -/

/-- At the unit case the glue point is the hex step: the M21 outer∩outer
classification is this module's `(1, 1)` instance at the canonical pair. -/
example : gluePoint 0 1 1 1 = hexStep 0 1 := by
  have hsq : Real.sqrt (3 / 4) = Real.sqrt 3 / 2 := by
    rw [show (3 : ℝ) / 4 = (Real.sqrt 3 / 2) ^ 2 by
      rw [div_pow, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 3)]; norm_num]
    exact Real.sqrt_sq (by positivity)
  simp only [gluePoint, hexStep, TwoCircle.zeta6, sub_zero, map_one, div_one, zero_add,
    mul_one]
  refine Complex.ext ?_ ?_
  · norm_num
  · rw [show (1 : ℝ) ^ 2 - ((1 + 1 ^ 2 - 1 ^ 2) / 2) ^ 2 = 3 / 4 by norm_num]
    simpa using hsq

/-- The metapivot instance (axis 1/√3 — a genuinely non-unit axis): the centroid
`⟨1/2, √3/6⟩` of the unit triangle {0, 1, ζ₆} has its outer circle meet `0`'s inner
circle in exactly the centroid's 120°-partners about `0`. The concrete model of the
classification's hypotheses beyond M21's reach. -/
example : rot3 0 (⟨1 / 2, Real.sqrt 3 / 6⟩ : ℂ)
    ∈ Metric.sphere (⟨1 / 2, Real.sqrt 3 / 6⟩ : ℂ) 1
      ∩ Metric.sphere (0 : ℂ) (Real.sqrt 3 / 3) := by
  have hrot : rot3 0 (⟨1 / 2, Real.sqrt 3 / 6⟩ : ℂ)
      = (⟨-(1 / 2), Real.sqrt 3 / 6⟩ : ℂ) := by
    refine Complex.ext ?_ ?_
    · simp only [rot3, omega3, zero_add, sub_zero, mul_re]
      linear_combination (-(1 : ℝ) / 12) * sq_sqrt3
    · simp only [rot3, omega3, zero_add, sub_zero, mul_im]
      ring
  constructor
  · rw [mem_sphere_iff_normSq (by norm_num : (0 : ℝ) ≤ 1), hrot]
    simp only [normSq_apply, Complex.sub_re, Complex.sub_im]
    norm_num
  · rw [mem_sphere_iff_normSq (by positivity : (0 : ℝ) ≤ Real.sqrt 3 / 3), hrot]
    simp only [normSq_apply, sub_zero]
    rw [div_pow, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 3)]
    linear_combination (1 / 36 : ℝ) * sq_sqrt3

/-- The far empty case is inhabited: unit circles about `0` and `3` miss. -/
example : Metric.sphere (0 : ℂ) 1 ∩ Metric.sphere (3 : ℂ) 1 = ∅ := by
  apply sphere_inter_sphere_eq_empty_of_far
  have h : dist (0 : ℂ) 3 = 3 := by
    rw [Complex.dist_eq, show (0 : ℂ) - 3 = -3 by ring, norm_neg]
    simp
  rw [h]
  norm_num

/-- The classification's teeth (adversarial member): the centroid's antipode
`−⟨1/2, √3/6⟩` lies ON `0`'s inner circle, yet NOT in the metapivot intersection —
its distance to the centroid is `2/√3`, not `1`. Refuted through the classification's
right-hand side: the two named points really are the only ones, and the antipode
differs from the glue point in its real part and from the mirror in its imaginary
part. -/
example : (⟨-(1 / 2), -(Real.sqrt 3 / 6)⟩ : ℂ)
    ∉ Metric.sphere (⟨1 / 2, Real.sqrt 3 / 6⟩ : ℂ) 1
      ∩ Metric.sphere (0 : ℂ) (Real.sqrt 3 / 3) := by
  have h3lb := sqrt3_gt
  have h3ub := sqrt3_lt
  have hne : (⟨1 / 2, Real.sqrt 3 / 6⟩ : ℂ) ≠ 0 := by
    intro h0
    have h1 : (1 : ℝ) / 2 = 0 := congrArg Complex.re h0
    norm_num at h1
  have hc0 : (starRingEnd ℂ) ((0 : ℂ) - ⟨1 / 2, Real.sqrt 3 / 6⟩) ≠ 0 := by
    simpa using sub_ne_zero.mpr (Ne.symm hne)
  have hdist : dist (⟨1 / 2, Real.sqrt 3 / 6⟩ : ℂ) 0 = Real.sqrt 3 / 3 := by
    rw [Complex.dist_eq, Complex.norm_def,
      show normSq ((⟨1 / 2, Real.sqrt 3 / 6⟩ : ℂ) - 0) = (Real.sqrt 3 / 3) ^ 2 from by
        simp only [sub_zero, normSq_mk, div_pow,
          Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 3)]
        linear_combination (1 / 36 : ℝ) * sq_sqrt3]
    exact Real.sqrt_sq (by positivity)
  have hlo : |(1 : ℝ) - Real.sqrt 3 / 3| ≤ dist (⟨1 / 2, Real.sqrt 3 / 6⟩ : ℂ) 0 := by
    rw [hdist, abs_of_nonneg (by linarith : (0 : ℝ) ≤ 1 - Real.sqrt 3 / 3)]
    linarith
  have hhi : dist (⟨1 / 2, Real.sqrt 3 / 6⟩ : ℂ) 0 ≤ 1 + Real.sqrt 3 / 3 := by
    rw [hdist]
    linarith [Real.sqrt_nonneg 3]
  have hN : normSq ((0 : ℂ) - ⟨1 / 2, Real.sqrt 3 / 6⟩) = 1 / 3 := by
    simp only [zero_sub, normSq_neg, normSq_mk]
    linear_combination (1 / 36 : ℝ) * sq_sqrt3
  have hA : (normSq ((0 : ℂ) - ⟨1 / 2, Real.sqrt 3 / 6⟩) + 1 ^ 2
      - (Real.sqrt 3 / 3) ^ 2) / 2 = 1 / 2 := by
    rw [hN, div_pow, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 3)]
    norm_num
  have hB : Real.sqrt (1 ^ 2 * normSq ((0 : ℂ) - ⟨1 / 2, Real.sqrt 3 / 6⟩)
      - ((normSq ((0 : ℂ) - ⟨1 / 2, Real.sqrt 3 / 6⟩) + 1 ^ 2
          - (Real.sqrt 3 / 3) ^ 2) / 2) ^ 2)
      = Real.sqrt 3 / 6 := by
    rw [hA, hN,
      show (1 : ℝ) ^ 2 * (1 / 3) - (1 / 2) ^ 2 = (Real.sqrt 3 / 6) ^ 2 by
        rw [show ((Real.sqrt 3 / 6 : ℝ)) ^ 2 = Real.sqrt 3 * Real.sqrt 3 / 36 by ring,
          sq_sqrt3]
        norm_num]
    exact Real.sqrt_sq (by positivity)
  have hmk : (⟨(normSq ((0 : ℂ) - ⟨1 / 2, Real.sqrt 3 / 6⟩) + 1 ^ 2
      - (Real.sqrt 3 / 3) ^ 2) / 2,
      Real.sqrt (1 ^ 2 * normSq ((0 : ℂ) - ⟨1 / 2, Real.sqrt 3 / 6⟩)
        - ((normSq ((0 : ℂ) - ⟨1 / 2, Real.sqrt 3 / 6⟩) + 1 ^ 2
            - (Real.sqrt 3 / 3) ^ 2) / 2) ^ 2)⟩ : ℂ)
      = (⟨1 / 2, Real.sqrt 3 / 6⟩ : ℂ) := Complex.ext hA hB
  have hgp : gluePoint (⟨1 / 2, Real.sqrt 3 / 6⟩ : ℂ) 0 1 (Real.sqrt 3 / 3)
      = (⟨0, -(Real.sqrt 3 / 3)⟩ : ℂ) := by
    simp only [gluePoint]
    rw [hmk,
      show (⟨1 / 2, Real.sqrt 3 / 6⟩ : ℂ)
          / (starRingEnd ℂ) ((0 : ℂ) - ⟨1 / 2, Real.sqrt 3 / 6⟩)
        = (⟨0, -(Real.sqrt 3 / 3)⟩ : ℂ) - ⟨1 / 2, Real.sqrt 3 / 6⟩ from by
      rw [div_eq_iff hc0]
      refine Complex.ext ?_ ?_
      · simp only [mul_re, Complex.sub_re, Complex.sub_im, conj_re, conj_im,
          Complex.zero_re, Complex.zero_im]
        linear_combination (-(1 : ℝ) / 12) * sq_sqrt3
      · simp only [mul_im, Complex.sub_re, Complex.sub_im, conj_re, conj_im,
          Complex.zero_re, Complex.zero_im]
        ring]
    ring
  have hmir : reflAxis (⟨1 / 2, Real.sqrt 3 / 6⟩ : ℂ) 0
      (gluePoint (⟨1 / 2, Real.sqrt 3 / 6⟩ : ℂ) 0 1 (Real.sqrt 3 / 3))
      = (⟨-(1 / 2), Real.sqrt 3 / 6⟩ : ℂ) := by
    rw [hgp]
    simp only [reflAxis, map_div₀]
    rw [show (starRingEnd ℂ) ((⟨0, -(Real.sqrt 3 / 3)⟩ : ℂ) - ⟨1 / 2, Real.sqrt 3 / 6⟩)
        / (starRingEnd ℂ) ((0 : ℂ) - ⟨1 / 2, Real.sqrt 3 / 6⟩)
        = (⟨3 / 2, -(Real.sqrt 3 / 2)⟩ : ℂ) from by
      rw [div_eq_iff hc0]
      refine Complex.ext ?_ ?_
      · simp only [mul_re, Complex.sub_re, Complex.sub_im, conj_re, conj_im,
          Complex.zero_re, Complex.zero_im]
        linear_combination (-(1 : ℝ) / 12) * sq_sqrt3
      · simp only [mul_im, Complex.sub_re, Complex.sub_im, conj_re, conj_im,
          Complex.zero_re, Complex.zero_im]
        ring]
    refine Complex.ext ?_ ?_
    · simp only [Complex.add_re, mul_re, Complex.sub_re, Complex.sub_im,
        Complex.zero_re, Complex.zero_im]
      linear_combination (-(1 : ℝ) / 12) * sq_sqrt3
    · simp only [Complex.add_im, mul_im, Complex.sub_re, Complex.sub_im,
        Complex.zero_re, Complex.zero_im]
      ring
  rw [sphere_inter_sphere hne hlo hhi]
  intro hmem
  simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hmem
  rcases hmem with h | h
  · rw [hgp] at h
    have h1 : -(1 / 2 : ℝ) = 0 := congrArg Complex.re h
    norm_num at h1
  · rw [hmir] at h
    have h1 : -(Real.sqrt 3 / 6) = Real.sqrt 3 / 6 := congrArg Complex.im h
    linarith

/-! ## The nine-step near-cycle (§2.3, kept by the domain pass)

Nine seam steps miss one hex step by chord < 1/50 — and do NOT close. Both facts are
exact field arithmetic (no transcendence): since `|ζ₆·σ⁹| = 1`, the chord bound
reduces to `re (ζ₆·σ⁹) > 1 − 1/5000`, a rational inequality against √3, √11 bounds;
the nonvanishing reduces through sixth powers to `σ⁵⁴ ≠ 1`, M19's `seam_pow_ne_one`.
The first certified near-relation: the aiming lemma of the exactness thread. -/

/-- The near-cycle does not close: `ζ₆·σ⁹ ≠ 1` (else `σ⁵⁴ = 1`, against the seam's
infinite order). The `0 <` half of the near-miss. -/
theorem zeta6_mul_seam_pow_nine_ne_one : TwoCircle.zeta6 * TwoCircle.seam ^ 9 ≠ 1 := by
  intro h
  have h6 : (TwoCircle.zeta6 * TwoCircle.seam ^ 9) ^ 6 = 1 := by
    rw [h]
    norm_num
  rw [mul_pow, TwoCircle.zeta6_pow_six, one_mul, ← pow_mul] at h6
  exact TwoCircle.seam_pow_ne_one (9 * 6) (by norm_num) h6

/-- **The nine-step near-cycle**: `normSq (ζ₆·σ⁹ − 1) < 1/2500` — nine seam steps
return to within chord 1/50 of one hex step. Exact arithmetic in ℚ(√3,√11);
numerically the miss is 1.008°, chord ≈ 0.0176. The power route carries the
`normSq = 1` invariant as a checked stepping stone at each stage (the subplan's
hand-computation hazard, made structural): each component literal below is forced by
`linear_combination` over the √-product engines, and `hre_id` re-checks unit modulus
before the final bound. -/
theorem normSq_zeta6_mul_seam_pow_nine_sub_one_lt :
    normSq (TwoCircle.zeta6 * TwoCircle.seam ^ 9 - 1) < 1 / 2500 := by
  have hs2 : TwoCircle.seam ^ 2 = (⟨-(5 / 6), Real.sqrt 11 / 6⟩ : ℂ) := by
    refine Complex.ext ?_ ?_
    · simp only [pow_two, TwoCircle.seam, mul_re]
      linear_combination (1 / 36 : ℝ) * sq_sqrt3 - (1 / 36 : ℝ) * sq_sqrt33
    · simp only [pow_two, TwoCircle.seam, mul_im]
      linear_combination (1 / 18 : ℝ) * sqrt3_mul_sqrt33
  have hs3 : TwoCircle.seam ^ 3
      = (⟨-(4 * Real.sqrt 3 / 9), -(Real.sqrt 33 / 9)⟩ : ℂ) := by
    rw [pow_succ, hs2]
    refine Complex.ext ?_ ?_
    · simp only [TwoCircle.seam, mul_re]
      linear_combination (-(1 : ℝ) / 36) * sqrt11_mul_sqrt33
    · simp only [TwoCircle.seam, mul_im]
      linear_combination (1 / 36 : ℝ) * sqrt3_mul_sqrt11
  have hs6 : TwoCircle.seam ^ 6 = (⟨5 / 27, 8 * Real.sqrt 11 / 27⟩ : ℂ) := by
    rw [show TwoCircle.seam ^ 6 = (TwoCircle.seam ^ 3) ^ 2 by ring, hs3, sq]
    refine Complex.ext ?_ ?_
    · simp only [mul_re]
      linear_combination (16 / 81 : ℝ) * sq_sqrt3 - (1 / 81 : ℝ) * sq_sqrt33
    · simp only [mul_im]
      linear_combination (8 / 81 : ℝ) * sqrt3_mul_sqrt33
  have hs9 : TwoCircle.seam ^ 9
      = (⟨68 * Real.sqrt 3 / 243, -(37 * Real.sqrt 33 / 243)⟩ : ℂ) := by
    rw [show TwoCircle.seam ^ 9 = TwoCircle.seam ^ 6 * TwoCircle.seam ^ 3 by ring,
      hs6, hs3]
    refine Complex.ext ?_ ?_
    · simp only [mul_re]
      linear_combination (8 / 243 : ℝ) * sqrt11_mul_sqrt33
    · simp only [mul_im]
      linear_combination (-(32 : ℝ) / 243) * sqrt3_mul_sqrt11
  have hw : TwoCircle.zeta6 * TwoCircle.seam ^ 9
      = (⟨34 * Real.sqrt 3 / 243 + 37 * Real.sqrt 11 / 162,
          34 / 81 - 37 * Real.sqrt 33 / 486⟩ : ℂ) := by
    rw [hs9]
    refine Complex.ext ?_ ?_
    · simp only [TwoCircle.zeta6, mul_re]
      linear_combination (37 / 486 : ℝ) * sqrt3_mul_sqrt33
    · simp only [TwoCircle.zeta6, mul_im]
      linear_combination (34 / 243 : ℝ) * sq_sqrt3
  have hre_id : (34 * Real.sqrt 3 / 243 + 37 * Real.sqrt 11 / 162) ^ 2
      + (34 / 81 - 37 * Real.sqrt 33 / 486) ^ 2 = 1 := by
    linear_combination (1156 / 59049 : ℝ) * sq_sqrt3 + (1369 / 26244 : ℝ) * sq_sqrt11
      + (1369 / 236196 : ℝ) * sq_sqrt33 + (1258 / 19683 : ℝ) * sqrt3_mul_sqrt11
  have hchord : normSq (TwoCircle.zeta6 * TwoCircle.seam ^ 9 - 1)
      = 2 - 2 * (34 * Real.sqrt 3 / 243 + 37 * Real.sqrt 11 / 162) := by
    rw [hw]
    simp only [normSq_apply, Complex.sub_re, Complex.sub_im, Complex.one_re,
      Complex.one_im]
    linear_combination hre_id
  rw [hchord]
  have h3 := sqrt3_gt
  have h11 := sqrt11_gt
  linarith

end Glue
end HadwigerNelson
