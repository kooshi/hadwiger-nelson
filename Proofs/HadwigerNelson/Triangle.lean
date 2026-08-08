import Proofs.HadwigerNelson.Glue

/-! # The pivot triangle and the metapivot system (M23)

Three pivots pairwise at distance 1, anchored at `0`, `1`, `ζ₆` — the first
configuration whose coupling directions (`1`, `ζ₆`, `ζ₃`) are hex-commensurate, so
exact closed constraint loops exist that the pair provably lacks (the seam hexagon
below; the M23 loop census measured its minimality). The centroid
`m = (0 + 1 + ζ₆)/3 = ⟨1/2, √3/6⟩` is the first triple glue point — on all three
pivot inner circles at once — and is itself the centre of the fourth two-circle
system (the metapivot). Full object: 8 circles, 4 centres, 34 pairwise-intersection
points, all inside ℚ(√3, √11, √33) (census A, exact).

The load-bearing discoveries this module certifies (subplan §2b, census-checked):

* **The triangle is self-glued**: the hex step permutes the pivots cyclically, so
  each pivot IS the (+)-branch outer∩outer glue point of the other two; and the
  metapivot couplings create NO new points except at outer∩outer — outer(pᵢ) ∩
  inner(m) is the other two pivots, inner(pᵢ) ∩ outer(m) is the two 120°-partners,
  inner(pᵢ) ∩ inner(m) is the two mirror centroids.
* **The chord classifications**: between unit-separated systems, outer–outer unit
  chords are RIGID (translate ∨ hub — the perfect matching is complete), and
  inner–inner unit chords are matching ∨ a Möbius graph (`x(3y−2) = y` at the
  anchor) — both pure algebra. Field growth (√disc adjunction) is localized to the
  mixed-radius chords, which are iterated `Glue.sphere_inter_sphere` instances.
* **The ten-point sharing theorem**: two unit-separated systems share exactly the
  two pivots and the eight glue points.
* **The loop identities**: one rotation operator `rotAbout`; the matching
  translation, the rot3-about-centroid word, the triple flip, the minimal hex
  parallelogram, and the hexagon `rot_hexagon` — which the implementation revealed
  to be pivot- AND rotation-generic (any unit rotation, any three points; only
  `s·conj s = 1` is used). The seam instance is the certified cyclic constraint
  loop; the census adds what the identity alone cannot: it is MINIMAL (length 6)
  and no two-pivot seam relation exists at that scale.
-/

namespace HadwigerNelson
namespace Triangle

open Complex TwoCircle Compulsion Coupled Glue

/-! ## The anchor -/

/-- The centroid of the anchored pivot triangle {0, 1, ζ₆} — the metapivot: the
first triple glue point, and the centre of the fourth two-circle system. Equal to
`Coupled.innerGlueRatio` as a point (the ii-gluing ratio IS the centroid at the
(0,1) anchor — spec example below). -/
noncomputable def centroid : ℂ := ⟨1 / 2, Real.sqrt 3 / 6⟩

/-- The one rotation operator: rotate `z` about `p` by the unit (or ratio) `u`.
`hexStep p = rotAbout ζ₆ p`, `seamImage p = rotAbout seamRatio p`,
`rot3 p = rotAbout ω₃ p` — the three existing operators are instances (the named
`rfl` bridges below); inverses are `rotAbout (conj u) p` for unit `u`. -/
noncomputable def rotAbout (u p z : ℂ) : ℂ := p + u * (z - p)

/-! ## Private engines

The √-arithmetic children and the three shared proof engines (obligation pass):
the ζ₆ minimal polynomial, the pair-pinning lemma, and the two chord keys. -/

private theorem sq_sqrt3 : Real.sqrt 3 * Real.sqrt 3 = 3 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sq_sqrt11 : Real.sqrt 11 * Real.sqrt 11 = 11 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sq_sqrt33 : Real.sqrt 33 * Real.sqrt 33 = 33 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sqrt3_mul_sqrt11 : Real.sqrt 3 * Real.sqrt 11 = Real.sqrt 33 := by
  rw [← Real.sqrt_mul (by norm_num)]; norm_num

private theorem sqrt3_mul_sqrt33 : Real.sqrt 3 * Real.sqrt 33 = 3 * Real.sqrt 11 := by
  rw [show (33 : ℝ) = 3 * 11 by norm_num, Real.sqrt_mul (by norm_num),
    ← mul_assoc, sq_sqrt3]

/-- The cubic engine: with `sq_sqrt3` it linearizes every ≤-cubic √3 component
goal for `nlinarith` (products of three √3-bearing literals appear in the
centroid arithmetic). -/
private theorem cube_sqrt3 :
    Real.sqrt 3 * (Real.sqrt 3 * Real.sqrt 3) = 3 * Real.sqrt 3 := by
  rw [sq_sqrt3]; ring

private theorem sqrt11_mul_sqrt33 : Real.sqrt 11 * Real.sqrt 33 = 11 * Real.sqrt 3 := by
  rw [show (33 : ℝ) = 11 * 3 by norm_num, Real.sqrt_mul (by norm_num),
    ← mul_assoc, sq_sqrt11]

private theorem sqrt3_pos : (0 : ℝ) < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)

private theorem sqrt11_pos : (0 : ℝ) < Real.sqrt 11 := Real.sqrt_pos.mpr (by norm_num)

private theorem inner_radius_sq : (Real.sqrt 3 / 3) ^ 2 = 1 / 3 := by
  rw [div_pow, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 3)]; norm_num

private theorem sqrt3_third_nonneg : (0 : ℝ) ≤ Real.sqrt 3 / 3 := by positivity

/-- Metric facts route through one door: distance as a `normSq` identity. -/
private theorem dist_eq_iff {a b : ℂ} {r : ℝ} (hr : 0 ≤ r) :
    dist a b = r ↔ normSq (a - b) = r ^ 2 := by
  rw [Complex.dist_eq, Complex.norm_def]
  constructor
  · intro h; rw [← h, Real.sq_sqrt (normSq_nonneg _)]
  · intro h; rw [h, Real.sqrt_sq hr]

private theorem mul_conj_of_dist_one {a b : ℂ} (h : dist a b = 1) :
    (a - b) * (starRingEnd ℂ) (a - b) = 1 := by
  rw [Complex.mul_conj, (dist_eq_iff (by norm_num)).mp h]
  norm_num

private theorem one_ne_inner : (1 : ℝ) ≠ Real.sqrt 3 / 3 := by
  intro h
  nlinarith [sq_sqrt3]

private theorem ne_of_re {a b : ℂ} (h : a.re ≠ b.re) : a ≠ b :=
  fun e => h (congrArg Complex.re e)

private theorem ne_of_im {a b : ℂ} (h : a.im ≠ b.im) : a ≠ b :=
  fun e => h (congrArg Complex.im e)

private theorem mk_ne_mk_of_re {a b c d : ℝ} (h : a ≠ c) :
    (⟨a, b⟩ : ℂ) ≠ ⟨c, d⟩ :=
  fun e => h (congrArg Complex.re e)

private theorem mk_ne_mk_of_im {a b c d : ℝ} (h : b ≠ d) :
    (⟨a, b⟩ : ℂ) ≠ ⟨c, d⟩ :=
  fun e => h (congrArg Complex.im e)

private theorem conj_mk (a b : ℝ) : (starRingEnd ℂ) (⟨a, b⟩ : ℂ) = ⟨a, -b⟩ := by
  apply Complex.ext <;> simp

/-- Engine 1: the ζ₆ minimal polynomial — the single algebraic root of the hex
layer (every hex loop identity is a `linear_combination` over it). -/
private theorem zeta6_minpoly : zeta6 ^ 2 - zeta6 + 1 = 0 := by
  apply Complex.ext <;>
    simp [zeta6, pow_two, Complex.mul_re, Complex.mul_im] <;>
    nlinarith [sq_sqrt3]

private theorem zeta6_sq_eq_omega3 : zeta6 ^ 2 = omega3 := by
  apply Complex.ext <;>
    simp [zeta6, omega3, pow_two, Complex.mul_re, Complex.mul_im] <;>
    nlinarith [sq_sqrt3]

private theorem centroid_mul_one_sub : centroid * (1 - zeta6 ^ 2) = 1 := by
  apply Complex.ext <;>
    simp [zeta6, centroid, pow_two, Complex.mul_re, Complex.mul_im] <;>
    nlinarith [sq_sqrt3, cube_sqrt3]

private theorem zeta6_mul_conj : zeta6 * (starRingEnd ℂ) zeta6 = 1 := by
  rw [Complex.mul_conj, ← Complex.sq_norm, norm_zeta6]
  norm_num

private theorem seam_mul_conj : seam * (starRingEnd ℂ) seam = 1 := by
  rw [Complex.mul_conj, ← Complex.sq_norm, norm_seam]
  norm_num

/-- Engine 2: the pair-pinning lemma — a listed pair containing two distinct
known members IS that pair. Turns every metapivot coupling into memberships plus
one distinctness, never touching the glue point's √-formula. -/
private theorem pair_eq_of_mem {α : Type*} {a b x y : α} (hx : x ∈ ({a, b} : Set α))
    (hy : y ∈ ({a, b} : Set α)) (hxy : x ≠ y) : ({a, b} : Set α) = {x, y} := by
  simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hx hy
  rcases hx with rfl | rfl <;> rcases hy with rfl | rfl
  · exact absurd rfl hxy
  · rfl
  · exact Set.pair_comm y x
  · exact absurd rfl hxy

/-- Engine 3a (the oo chord key): on units, the chord condition factors —
`|u + v − 1| = 1 ⟺ (u+v)(u−1)(v−1) = 0`. Pure algebra; sympy-verified identity. -/
private theorem unit_chord_units {u v : ℂ} (hu : u * (starRingEnd ℂ) u = 1)
    (hv : v * (starRingEnd ℂ) v = 1) :
    normSq (u + v - 1) = 1 ↔ (u + v) * (u - 1) * (v - 1) = 0 := by
  have hu0 : u ≠ 0 := fun h => by simp [h] at hu
  have hv0 : v ≠ 0 := fun h => by simp [h] at hv
  have hconj : (starRingEnd ℂ) (u + v - 1)
      = (starRingEnd ℂ) u + (starRingEnd ℂ) v - 1 := by
    simp
  have hcast : normSq (u + v - 1) = 1 ↔
      (u + v - 1) * ((starRingEnd ℂ) u + (starRingEnd ℂ) v - 1) = 1 := by
    rw [← hconj, Complex.mul_conj]
    constructor
    · intro h; rw [h]; norm_num
    · intro h; exact_mod_cast h
  rw [hcast]
  constructor
  · intro hK
    linear_combination (-(u * v)) * hK + (v * (u + v - 1)) * hu + (u * (u + v - 1)) * hv
  · intro hfac
    have hmul : u * v * ((u + v - 1) * ((starRingEnd ℂ) u + (starRingEnd ℂ) v - 1) - 1)
        = 0 := by
      linear_combination (-1 : ℂ) * hfac + (v * (u + v - 1)) * hu + (u * (u + v - 1)) * hv
    rcases mul_eq_zero.mp hmul with h | h
    · exact absurd h (mul_ne_zero hu0 hv0)
    · exact sub_eq_zero.mp h

/-! ## The anchor facts -/

/-- The three pivot pair distances. -/
theorem dist_pivot_01 : dist (0 : ℂ) 1 = 1 := by
  rw [dist_eq_iff (by norm_num)]
  simp [normSq_apply]

theorem dist_pivot_02 : dist (0 : ℂ) zeta6 = 1 := by
  rw [dist_eq_iff (by norm_num)]
  simp [normSq_apply, zeta6]
  nlinarith [sq_sqrt3]

theorem dist_pivot_12 : dist (1 : ℂ) zeta6 = 1 := by
  rw [dist_eq_iff (by norm_num)]
  simp [normSq_apply, zeta6]
  nlinarith [sq_sqrt3]

/-- The centroid is at inner radius from every pivot — the triple glue point,
distance side. -/
theorem dist_centroid_0 : dist (0 : ℂ) centroid = Real.sqrt 3 / 3 := by
  rw [dist_eq_iff sqrt3_third_nonneg, inner_radius_sq]
  simp [normSq_apply, centroid]
  nlinarith [sq_sqrt3]

theorem dist_centroid_1 : dist (1 : ℂ) centroid = Real.sqrt 3 / 3 := by
  rw [dist_eq_iff sqrt3_third_nonneg, inner_radius_sq]
  simp [normSq_apply, centroid]
  nlinarith [sq_sqrt3]

theorem dist_centroid_2 : dist zeta6 centroid = Real.sqrt 3 / 3 := by
  rw [dist_eq_iff sqrt3_third_nonneg, inner_radius_sq]
  simp [normSq_apply, centroid, zeta6]
  nlinarith [sq_sqrt3]

/-! ## The self-gluing cycle: the hex step permutes the pivots -/

theorem hexStep_cycle_01 : hexStep 0 1 = zeta6 := by
  simp [hexStep]

theorem hexStep_cycle_12 : hexStep 1 zeta6 = 0 := by
  simp only [hexStep]
  linear_combination zeta6_minpoly

theorem hexStep_cycle_20 : hexStep zeta6 0 = 1 := by
  simp only [hexStep]
  linear_combination (-1 : ℂ) * zeta6_minpoly

/-- Outer meets outer at the THIRD pivot (and its mirror, the reflected apex):
the triangle is self-glued. -/
theorem outer_inter_outer_eq_third :
    Metric.sphere (0 : ℂ) 1 ∩ Metric.sphere (1 : ℂ) 1
      = {zeta6, reflAcross 0 1 zeta6} := by
  rw [Coupled.outer_inter_outer dist_pivot_01, hexStep_cycle_01]

/-! ## The centroid as the triple glue point -/

/-- The (+)-branch inner∩inner glue point of the pair (0,1) is the centroid. -/
theorem centroid_glue_01 : (0 : ℂ) + innerGlueRatio * ((1 : ℂ) - 0) = centroid := by
  simp [innerGlueRatio, centroid]

/-- The (+)-branch inner∩inner glue point of the pair (1,ζ₆) is the centroid. -/
theorem centroid_glue_12 : (1 : ℂ) + innerGlueRatio * (zeta6 - 1) = centroid := by
  apply Complex.ext <;>
    simp [innerGlueRatio, centroid, zeta6, Complex.mul_re, Complex.mul_im] <;>
    nlinarith [sq_sqrt3]

/-- The (+)-branch inner∩inner glue point of the pair (ζ₆,0) is the centroid. -/
theorem centroid_glue_20 : zeta6 + innerGlueRatio * ((0 : ℂ) - zeta6) = centroid := by
  apply Complex.ext <;>
    simp [innerGlueRatio, centroid, zeta6, Complex.mul_re, Complex.mul_im] <;>
    nlinarith [sq_sqrt3]

/-! ## The metapivot couplings create no new points (except outer∩outer)

Census A (exact): the three couplings below are the complete pivot–metapivot
incidence structure apart from the six √33-family outer∩outer points, which stay
generic `Glue.sphere_inter_sphere` instances (no consumer yet — not minted). -/

private theorem zero_ne_centroid : (0 : ℂ) ≠ centroid :=
  ne_of_re (by norm_num [centroid])

private theorem annulus_lo_oi : |1 - Real.sqrt 3 / 3| ≤ dist (0 : ℂ) centroid := by
  rw [dist_centroid_0, abs_of_nonneg (by nlinarith [sq_sqrt3, Real.sqrt_nonneg 3])]
  nlinarith [sq_sqrt3, Real.sqrt_nonneg 3]

private theorem annulus_hi_oi : dist (0 : ℂ) centroid ≤ 1 + Real.sqrt 3 / 3 := by
  rw [dist_centroid_0]; linarith

/-- A pivot's outer circle meets the metapivot's inner circle exactly at the OTHER
TWO PIVOTS. -/
theorem outer_inter_metaInner :
    Metric.sphere (0 : ℂ) 1 ∩ Metric.sphere centroid (Real.sqrt 3 / 3)
      = {1, zeta6} := by
  have hglue := Glue.sphere_inter_sphere zero_ne_centroid annulus_lo_oi annulus_hi_oi
  have h1 : (1 : ℂ) ∈ Metric.sphere (0 : ℂ) 1 ∩ Metric.sphere centroid (Real.sqrt 3 / 3) :=
    ⟨Metric.mem_sphere.mpr (by rw [dist_comm]; exact dist_pivot_01),
     Metric.mem_sphere.mpr dist_centroid_1⟩
  have h2 : zeta6 ∈ Metric.sphere (0 : ℂ) 1 ∩ Metric.sphere centroid (Real.sqrt 3 / 3) :=
    ⟨Metric.mem_sphere.mpr (by rw [dist_comm]; exact dist_pivot_02),
     Metric.mem_sphere.mpr dist_centroid_2⟩
  rw [hglue] at h1 h2 ⊢
  exact pair_eq_of_mem h1 h2 (ne_of_re (by norm_num [zeta6]))

private theorem rot3_centroid_lit : rot3 0 centroid = ⟨-(1 / 2), Real.sqrt 3 / 6⟩ := by
  apply Complex.ext <;>
    simp [rot3, omega3, centroid, Complex.mul_re, Complex.mul_im] <;>
    nlinarith [sq_sqrt3]

private theorem rot3_sq_centroid_lit :
    rot3 0 (rot3 0 centroid) = ⟨0, -(Real.sqrt 3 / 3)⟩ := by
  rw [rot3_centroid_lit]
  apply Complex.ext <;>
    simp [rot3, omega3, Complex.mul_re, Complex.mul_im] <;>
    nlinarith [sq_sqrt3]

private theorem annulus_lo_io :
    |Real.sqrt 3 / 3 - 1| ≤ dist (0 : ℂ) centroid := by
  rw [abs_sub_comm]; exact annulus_lo_oi

/-- A pivot's inner circle meets the metapivot's outer circle exactly at the two
120°-partners of the centroid about that pivot. -/
theorem inner_inter_metaOuter :
    Metric.sphere (0 : ℂ) (Real.sqrt 3 / 3) ∩ Metric.sphere centroid 1
      = {rot3 0 centroid, rot3 0 (rot3 0 centroid)} := by
  have hglue := Glue.sphere_inter_sphere zero_ne_centroid annulus_lo_io
    (by rw [dist_centroid_0]; linarith [sqrt3_third_nonneg])
  have hc0 : centroid ∈ Metric.sphere (0 : ℂ) (Real.sqrt 3 / 3) :=
    Metric.mem_sphere.mpr (by rw [dist_comm]; exact dist_centroid_0)
  have htri := rot3_unit_triangle
    (p := 0) (z := centroid)
    (by rw [dist_comm, dist_centroid_0, inner_radius_sq])
  have h1 : rot3 0 centroid ∈
      Metric.sphere (0 : ℂ) (Real.sqrt 3 / 3) ∩ Metric.sphere centroid 1 :=
    ⟨rot3_mem_sphere hc0, Metric.mem_sphere.mpr (by rw [dist_comm]; exact htri.1)⟩
  have h2 : rot3 0 (rot3 0 centroid) ∈
      Metric.sphere (0 : ℂ) (Real.sqrt 3 / 3) ∩ Metric.sphere centroid 1 :=
    ⟨rot3_mem_sphere (rot3_mem_sphere hc0), Metric.mem_sphere.mpr htri.2.2⟩
  rw [hglue] at h1 h2 ⊢
  refine pair_eq_of_mem h1 h2 ?_
  rw [rot3_sq_centroid_lit, rot3_centroid_lit]
  exact ne_of_re (by norm_num)

private theorem reflAcross_01_apply (z : ℂ) :
    reflAcross 0 1 z = (starRingEnd ℂ) z := by
  simp [Coupled.reflAcross]

private theorem reflAcross_01_centroid_lit :
    reflAcross 0 1 centroid = ⟨1 / 2, -(Real.sqrt 3 / 6)⟩ := by
  rw [reflAcross_01_apply, centroid, conj_mk]

private theorem reflAcross_02_centroid_lit :
    reflAcross 0 zeta6 centroid = ⟨0, Real.sqrt 3 / 3⟩ := by
  apply Complex.ext <;>
    simp [Coupled.reflAcross, zeta6, centroid, conj_mk, pow_two,
      Complex.mul_re, Complex.mul_im] <;>
    nlinarith [sq_sqrt3, cube_sqrt3]

private theorem annulus_lo_ii :
    |Real.sqrt 3 / 3 - Real.sqrt 3 / 3| ≤ dist (0 : ℂ) centroid := by
  rw [sub_self, abs_zero, dist_centroid_0]; exact sqrt3_third_nonneg

/-- A pivot's inner circle meets the metapivot's inner circle exactly at the two
MIRROR CENTROIDS — the centroid's reflections across the two triangle edges at
that pivot (census A's correction: these gluings adjoin nothing new). -/
theorem inner_inter_metaInner :
    Metric.sphere (0 : ℂ) (Real.sqrt 3 / 3) ∩ Metric.sphere centroid (Real.sqrt 3 / 3)
      = {reflAcross 0 1 centroid, reflAcross 0 zeta6 centroid} := by
  have hglue := Glue.sphere_inter_sphere zero_ne_centroid annulus_lo_ii
    (by rw [dist_centroid_0]; linarith [sqrt3_third_nonneg])
  have hc0 : centroid ∈ Metric.sphere (0 : ℂ) (Real.sqrt 3 / 3) :=
    Metric.mem_sphere.mpr (by rw [dist_comm]; exact dist_centroid_0)
  have hm1 : reflAcross 0 1 centroid ∈
      Metric.sphere (0 : ℂ) (Real.sqrt 3 / 3) ∩ Metric.sphere centroid (Real.sqrt 3 / 3) := by
    refine ⟨Coupled.reflAcross_mem_sphere_left dist_pivot_01 hc0,
      Metric.mem_sphere.mpr ?_⟩
    rw [reflAcross_01_centroid_lit, dist_eq_iff sqrt3_third_nonneg, inner_radius_sq]
    simp [normSq_apply, centroid]
    nlinarith [sq_sqrt3]
  have hm2 : reflAcross 0 zeta6 centroid ∈
      Metric.sphere (0 : ℂ) (Real.sqrt 3 / 3) ∩ Metric.sphere centroid (Real.sqrt 3 / 3) := by
    refine ⟨Coupled.reflAcross_mem_sphere_left dist_pivot_02 hc0,
      Metric.mem_sphere.mpr ?_⟩
    rw [reflAcross_02_centroid_lit, dist_eq_iff sqrt3_third_nonneg, inner_radius_sq]
    simp [normSq_apply, centroid]
    nlinarith [sq_sqrt3]
  rw [hglue] at hm1 hm2 ⊢
  refine pair_eq_of_mem hm1 hm2 ?_
  rw [reflAcross_01_centroid_lit, reflAcross_02_centroid_lit]
  exact ne_of_re (by norm_num)

/-! ## The ten-point sharing theorem -/

private theorem ne_of_dist_one {p q : ℂ} (h : dist p q = 1) : p ≠ q := fun e => by
  rw [e, dist_self] at h
  norm_num at h

/-- **Two unit-separated systems share exactly ten points**: the two pivots and
the eight glue points (the four certified gluing classifications as one set
count). General in the unit pair. -/
theorem system_inter_system {p q : ℂ} (h : dist p q = 1) :
    system p ∩ system q
      = {p, q, hexStep p q, reflAcross p q (hexStep p q),
         seamImage q p, reflAcross p q (seamImage q p),
         seamImage p q, reflAcross p q (seamImage p q),
         p + innerGlueRatio * (q - p),
         reflAcross p q (p + innerGlueRatio * (q - p))} := by
  have hoo := Coupled.outer_inter_outer h
  have hoi := Coupled.outer_inter_inner h
  have hio := Coupled.inner_inter_outer h
  have hii := Coupled.inner_inter_inner h
  ext x
  simp only [Coupled.system, Set.mem_inter_iff, Set.mem_insert_iff, Set.mem_union,
    Set.mem_singleton_iff]
  constructor
  · rintro ⟨h1 | h1 | h1, h2 | h2 | h2⟩
    · exact Or.inl h1
    · exact Or.inl h1
    · exact Or.inl h1
    · exact Or.inr (Or.inl h2)
    · have hx : x ∈ Metric.sphere p 1 ∩ Metric.sphere q 1 := ⟨h1, h2⟩
      rw [hoo] at hx
      simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hx
      rcases hx with h3 | h3
      · exact Or.inr (Or.inr (Or.inl h3))
      · exact Or.inr (Or.inr (Or.inr (Or.inl h3)))
    · have hx : x ∈ Metric.sphere p 1 ∩ Metric.sphere q (Real.sqrt 3 / 3) := ⟨h1, h2⟩
      rw [hoi] at hx
      simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hx
      rcases hx with h3 | h3
      · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inl h3))))
      · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl h3)))))
    · subst h2
      have hd : dist x p = Real.sqrt 3 / 3 := Metric.mem_sphere.mp h1
      rw [dist_comm] at hd
      exact absurd (h.symm.trans hd) one_ne_inner
    · have hx : x ∈ Metric.sphere p (Real.sqrt 3 / 3) ∩ Metric.sphere q 1 := ⟨h1, h2⟩
      rw [hio] at hx
      simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hx
      rcases hx with h3 | h3
      · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl h3))))))
      · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl h3)))))))
    · have hx : x ∈ Metric.sphere p (Real.sqrt 3 / 3) ∩ Metric.sphere q (Real.sqrt 3 / 3) :=
        ⟨h1, h2⟩
      rw [hii] at hx
      simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hx
      rcases hx with h3 | h3
      · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl h3))))))))
      · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr h3))))))))
  · have hoom : hexStep p q ∈ Metric.sphere p 1 ∩ Metric.sphere q 1 := by
      rw [hoo]; exact Set.mem_insert _ _
    have hoom' : reflAcross p q (hexStep p q) ∈ Metric.sphere p 1 ∩ Metric.sphere q 1 := by
      rw [hoo]; exact Set.mem_insert_of_mem _ rfl
    have hoim : seamImage q p ∈ Metric.sphere p 1 ∩ Metric.sphere q (Real.sqrt 3 / 3) := by
      rw [hoi]; exact Set.mem_insert _ _
    have hoim' : reflAcross p q (seamImage q p)
        ∈ Metric.sphere p 1 ∩ Metric.sphere q (Real.sqrt 3 / 3) := by
      rw [hoi]; exact Set.mem_insert_of_mem _ rfl
    have hiom : seamImage p q ∈ Metric.sphere p (Real.sqrt 3 / 3) ∩ Metric.sphere q 1 := by
      rw [hio]; exact Set.mem_insert _ _
    have hiom' : reflAcross p q (seamImage p q)
        ∈ Metric.sphere p (Real.sqrt 3 / 3) ∩ Metric.sphere q 1 := by
      rw [hio]; exact Set.mem_insert_of_mem _ rfl
    have hiim : p + innerGlueRatio * (q - p)
        ∈ Metric.sphere p (Real.sqrt 3 / 3) ∩ Metric.sphere q (Real.sqrt 3 / 3) := by
      rw [hii]; exact Set.mem_insert _ _
    have hiim' : reflAcross p q (p + innerGlueRatio * (q - p))
        ∈ Metric.sphere p (Real.sqrt 3 / 3) ∩ Metric.sphere q (Real.sqrt 3 / 3) := by
      rw [hii]; exact Set.mem_insert_of_mem _ rfl
    rintro (rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl)
    · exact ⟨Or.inl rfl, Or.inr (Or.inl (Metric.mem_sphere.mpr h))⟩
    · exact ⟨Or.inr (Or.inl (Metric.mem_sphere.mpr (by rw [dist_comm]; exact h))),
        Or.inl rfl⟩
    · exact ⟨Or.inr (Or.inl hoom.1), Or.inr (Or.inl hoom.2)⟩
    · exact ⟨Or.inr (Or.inl hoom'.1), Or.inr (Or.inl hoom'.2)⟩
    · exact ⟨Or.inr (Or.inl hoim.1), Or.inr (Or.inr hoim.2)⟩
    · exact ⟨Or.inr (Or.inl hoim'.1), Or.inr (Or.inr hoim'.2)⟩
    · exact ⟨Or.inr (Or.inr hiom.1), Or.inr (Or.inl hiom.2)⟩
    · exact ⟨Or.inr (Or.inr hiom'.1), Or.inr (Or.inl hiom'.2)⟩
    · exact ⟨Or.inr (Or.inr hiim.1), Or.inr (Or.inr hiim.2)⟩
    · exact ⟨Or.inr (Or.inr hiim'.1), Or.inr (Or.inr hiim'.2)⟩

/-- The ten shared points are pairwise distinct at the anchor: the count is
exactly ten. -/
theorem ncard_system_inter_system :
    (system (0 : ℂ) ∩ system 1).ncard = 10 := by
  rw [system_inter_system dist_pivot_01]
  have e3 : hexStep 0 1 = (⟨1 / 2, Real.sqrt 3 / 2⟩ : ℂ) := hexStep_cycle_01
  have e4 : reflAcross 0 1 (hexStep 0 1) = (⟨1 / 2, -(Real.sqrt 3 / 2)⟩ : ℂ) := by
    rw [reflAcross_01_apply, e3, conj_mk]
  have e5 : seamImage (1 : ℂ) 0 = (⟨5 / 6, -(Real.sqrt 11 / 6)⟩ : ℂ) := by
    apply Complex.ext <;> simp [seamImage, seamRatio]
    norm_num
  have e6 : reflAcross 0 1 (seamImage (1 : ℂ) 0) = (⟨5 / 6, Real.sqrt 11 / 6⟩ : ℂ) := by
    rw [reflAcross_01_apply, e5, conj_mk]; norm_num
  have e7 : seamImage (0 : ℂ) 1 = (⟨1 / 6, Real.sqrt 11 / 6⟩ : ℂ) := by
    apply Complex.ext <;> simp [seamImage, seamRatio]
  have e8 : reflAcross 0 1 (seamImage (0 : ℂ) 1) = (⟨1 / 6, -(Real.sqrt 11 / 6)⟩ : ℂ) := by
    rw [reflAcross_01_apply, e7, conj_mk]
  have e9 : (0 : ℂ) + innerGlueRatio * ((1 : ℂ) - 0) = (⟨1 / 2, Real.sqrt 3 / 6⟩ : ℂ) :=
    centroid_glue_01
  have e10 : reflAcross 0 1 ((0 : ℂ) + innerGlueRatio * ((1 : ℂ) - 0))
      = (⟨1 / 2, -(Real.sqrt 3 / 6)⟩ : ℂ) := by
    rw [reflAcross_01_apply, e9, conj_mk]
  rw [e4, e3, e6, e5, e8, e7, e10, e9]
  have z01 : (0 : ℂ) = (⟨0, 0⟩ : ℂ) := rfl
  have z02 : (1 : ℂ) = (⟨1, 0⟩ : ℂ) := rfl
  rw [z01, z02]
  have n0 : (⟨0, 0⟩ : ℂ) ∉ ({⟨1, 0⟩, ⟨1 / 2, Real.sqrt 3 / 2⟩,
      ⟨1 / 2, -(Real.sqrt 3 / 2)⟩, ⟨5 / 6, -(Real.sqrt 11 / 6)⟩,
      ⟨5 / 6, Real.sqrt 11 / 6⟩, ⟨1 / 6, Real.sqrt 11 / 6⟩,
      ⟨1 / 6, -(Real.sqrt 11 / 6)⟩, ⟨1 / 2, Real.sqrt 3 / 6⟩,
      ⟨1 / 2, -(Real.sqrt 3 / 6)⟩} : Set ℂ) := by
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff]
    push Not
    exact ⟨mk_ne_mk_of_re (by norm_num), mk_ne_mk_of_re (by norm_num),
      mk_ne_mk_of_re (by norm_num), mk_ne_mk_of_re (by norm_num),
      mk_ne_mk_of_re (by norm_num), mk_ne_mk_of_re (by norm_num),
      mk_ne_mk_of_re (by norm_num), mk_ne_mk_of_re (by norm_num),
      mk_ne_mk_of_re (by norm_num)⟩
  have n1 : (⟨1, 0⟩ : ℂ) ∉ ({⟨1 / 2, Real.sqrt 3 / 2⟩,
      ⟨1 / 2, -(Real.sqrt 3 / 2)⟩, ⟨5 / 6, -(Real.sqrt 11 / 6)⟩,
      ⟨5 / 6, Real.sqrt 11 / 6⟩, ⟨1 / 6, Real.sqrt 11 / 6⟩,
      ⟨1 / 6, -(Real.sqrt 11 / 6)⟩, ⟨1 / 2, Real.sqrt 3 / 6⟩,
      ⟨1 / 2, -(Real.sqrt 3 / 6)⟩} : Set ℂ) := by
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff]
    push Not
    exact ⟨mk_ne_mk_of_re (by norm_num), mk_ne_mk_of_re (by norm_num),
      mk_ne_mk_of_re (by norm_num), mk_ne_mk_of_re (by norm_num),
      mk_ne_mk_of_re (by norm_num), mk_ne_mk_of_re (by norm_num),
      mk_ne_mk_of_re (by norm_num), mk_ne_mk_of_re (by norm_num)⟩
  have n2 : (⟨1 / 2, Real.sqrt 3 / 2⟩ : ℂ) ∉ ({⟨1 / 2, -(Real.sqrt 3 / 2)⟩,
      ⟨5 / 6, -(Real.sqrt 11 / 6)⟩, ⟨5 / 6, Real.sqrt 11 / 6⟩,
      ⟨1 / 6, Real.sqrt 11 / 6⟩, ⟨1 / 6, -(Real.sqrt 11 / 6)⟩,
      ⟨1 / 2, Real.sqrt 3 / 6⟩, ⟨1 / 2, -(Real.sqrt 3 / 6)⟩} : Set ℂ) := by
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff]
    push Not
    exact ⟨mk_ne_mk_of_im (by intro h; linarith [sqrt3_pos]),
      mk_ne_mk_of_re (by norm_num), mk_ne_mk_of_re (by norm_num),
      mk_ne_mk_of_re (by norm_num), mk_ne_mk_of_re (by norm_num),
      mk_ne_mk_of_im (by intro h; linarith [sqrt3_pos]),
      mk_ne_mk_of_im (by intro h; linarith [sqrt3_pos])⟩
  have n3 : (⟨1 / 2, -(Real.sqrt 3 / 2)⟩ : ℂ) ∉ ({⟨5 / 6, -(Real.sqrt 11 / 6)⟩,
      ⟨5 / 6, Real.sqrt 11 / 6⟩, ⟨1 / 6, Real.sqrt 11 / 6⟩,
      ⟨1 / 6, -(Real.sqrt 11 / 6)⟩, ⟨1 / 2, Real.sqrt 3 / 6⟩,
      ⟨1 / 2, -(Real.sqrt 3 / 6)⟩} : Set ℂ) := by
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff]
    push Not
    exact ⟨mk_ne_mk_of_re (by norm_num), mk_ne_mk_of_re (by norm_num),
      mk_ne_mk_of_re (by norm_num), mk_ne_mk_of_re (by norm_num),
      mk_ne_mk_of_im (by intro h; linarith [sqrt3_pos]),
      mk_ne_mk_of_im (by intro h; linarith [sqrt3_pos])⟩
  have n4 : (⟨5 / 6, -(Real.sqrt 11 / 6)⟩ : ℂ) ∉ ({⟨5 / 6, Real.sqrt 11 / 6⟩,
      ⟨1 / 6, Real.sqrt 11 / 6⟩, ⟨1 / 6, -(Real.sqrt 11 / 6)⟩,
      ⟨1 / 2, Real.sqrt 3 / 6⟩, ⟨1 / 2, -(Real.sqrt 3 / 6)⟩} : Set ℂ) := by
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff]
    push Not
    exact ⟨mk_ne_mk_of_im (by intro h; linarith [sqrt11_pos]),
      mk_ne_mk_of_re (by norm_num), mk_ne_mk_of_re (by norm_num),
      mk_ne_mk_of_re (by norm_num), mk_ne_mk_of_re (by norm_num)⟩
  have n5 : (⟨5 / 6, Real.sqrt 11 / 6⟩ : ℂ) ∉ ({⟨1 / 6, Real.sqrt 11 / 6⟩,
      ⟨1 / 6, -(Real.sqrt 11 / 6)⟩, ⟨1 / 2, Real.sqrt 3 / 6⟩,
      ⟨1 / 2, -(Real.sqrt 3 / 6)⟩} : Set ℂ) := by
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff]
    push Not
    exact ⟨mk_ne_mk_of_re (by norm_num), mk_ne_mk_of_re (by norm_num),
      mk_ne_mk_of_re (by norm_num), mk_ne_mk_of_re (by norm_num)⟩
  have n6 : (⟨1 / 6, Real.sqrt 11 / 6⟩ : ℂ) ∉ ({⟨1 / 6, -(Real.sqrt 11 / 6)⟩,
      ⟨1 / 2, Real.sqrt 3 / 6⟩, ⟨1 / 2, -(Real.sqrt 3 / 6)⟩} : Set ℂ) := by
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff]
    push Not
    exact ⟨mk_ne_mk_of_im (by intro h; linarith [sqrt11_pos]),
      mk_ne_mk_of_re (by norm_num), mk_ne_mk_of_re (by norm_num)⟩
  have n7 : (⟨1 / 6, -(Real.sqrt 11 / 6)⟩ : ℂ) ∉ ({⟨1 / 2, Real.sqrt 3 / 6⟩,
      ⟨1 / 2, -(Real.sqrt 3 / 6)⟩} : Set ℂ) := by
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff]
    push Not
    exact ⟨mk_ne_mk_of_re (by norm_num), mk_ne_mk_of_re (by norm_num)⟩
  have n8 : (⟨1 / 2, Real.sqrt 3 / 6⟩ : ℂ) ∉ ({⟨1 / 2, -(Real.sqrt 3 / 6)⟩} : Set ℂ) := by
    simp only [Set.mem_singleton_iff]
    exact mk_ne_mk_of_im (by intro h; linarith [sqrt3_pos])
  rw [Set.ncard_insert_of_notMem n0 (Set.toFinite _),
    Set.ncard_insert_of_notMem n1 (Set.toFinite _),
    Set.ncard_insert_of_notMem n2 (Set.toFinite _),
    Set.ncard_insert_of_notMem n3 (Set.toFinite _),
    Set.ncard_insert_of_notMem n4 (Set.toFinite _),
    Set.ncard_insert_of_notMem n5 (Set.toFinite _),
    Set.ncard_insert_of_notMem n6 (Set.toFinite _),
    Set.ncard_insert_of_notMem n7 (Set.toFinite _),
    Set.ncard_insert_of_notMem n8 (Set.toFinite _),
    Set.ncard_singleton]

/-! ## The translation coupling: the perfect matching as a kernel object -/

/-- Translation carries every circle of one centre onto the partner's — with NO
distance hypothesis (pure translation invariance; the domain pass generalized the
planned unit-pair version). -/
theorem mem_sphere_translate {p q z : ℂ} {r : ℝ} :
    z ∈ Metric.sphere p r ↔ z + (q - p) ∈ Metric.sphere q r := by
  have key : dist (z + (q - p)) q = dist z p := by
    rw [Complex.dist_eq, Complex.dist_eq, show z + (q - p) - q = z - p by ring]
  rw [Metric.mem_sphere, Metric.mem_sphere, key]

/-- At a unit pair, every point is unit-distance from its own translate: the
perfect matching, per vertex. -/
theorem dist_translate {p q : ℂ} (h : dist p q = 1) (z : ℂ) :
    dist z (z + (q - p)) = 1 := by
  rw [Complex.dist_eq, show z - (z + (q - p)) = -(q - p) by ring, norm_neg,
    ← Complex.dist_eq, dist_comm]
  exact h

/-! ## The chord classifications: the cross-web between unit-separated systems

The outer–outer and inner–inner unit-chord relations FACTOR (census C3, sympy-
verified; kernel proofs below) — the foreign web's field growth is localized to
the mixed-radius chords, which are `Glue.sphere_inter_sphere` instances. -/

/-- **Outer–outer rigidity**: a unit chord between the outer circles of two
unit-separated pivots is a translate pair or passes through a pivot. The
unit-translation perfect matching is COMPLETE — for the full uncountable circles.
(In the unit frame: `|u + v − 1| = 1` factors as `(u+v)(u−1)(v−1) = 0`.) -/
theorem unit_chord_outer_outer {p q x y : ℂ} (h : dist p q = 1)
    (hx : x ∈ Metric.sphere p 1) (hy : y ∈ Metric.sphere q 1) :
    dist x y = 1 ↔ (y = x + (q - p) ∨ x = q ∨ y = p) := by
  have hqp : dist q p = 1 := by rw [dist_comm]; exact h
  have hc : (q - p) * (starRingEnd ℂ) (q - p) = 1 := mul_conj_of_dist_one hqp
  have hxp : (x - p) * (starRingEnd ℂ) (x - p) = 1 :=
    mul_conj_of_dist_one (Metric.mem_sphere.mp hx)
  have hyq : (q - y) * (starRingEnd ℂ) (q - y) = 1 := by
    have := mul_conj_of_dist_one (Metric.mem_sphere.mp hy)
    have hneg : q - y = -(y - q) := by ring
    rw [hneg, map_neg, neg_mul_neg]
    exact this
  set u := (x - p) * (starRingEnd ℂ) (q - p) with hu_def
  set v := (q - y) * (starRingEnd ℂ) (q - p) with hv_def
  have hcc0 : (starRingEnd ℂ) (q - p) ≠ 0 := fun h0 => by simp [h0] at hc
  have hu : u * (starRingEnd ℂ) u = 1 := by
    rw [hu_def, map_mul, Complex.conj_conj]
    linear_combination ((q - p) * (starRingEnd ℂ) (q - p)) * hxp + hc
  have hv : v * (starRingEnd ℂ) v = 1 := by
    rw [hv_def, map_mul, Complex.conj_conj]
    linear_combination ((q - p) * (starRingEnd ℂ) (q - p)) * hyq + hc
  have hframe : x - y = (q - p) * (u + v - 1) := by
    rw [hu_def, hv_def]
    linear_combination (-(x - p + q - y)) * hc
  have hnqp : normSq (q - p) = 1 := by
    have := hc
    rw [Complex.mul_conj] at this
    exact_mod_cast this
  have hnorm : normSq (x - y) = normSq (u + v - 1) := by
    rw [hframe, normSq_mul, hnqp, one_mul]
  have e1 : u + v = 0 ↔ y = x + (q - p) := by
    have huv : u + v = (x - p + q - y) * (starRingEnd ℂ) (q - p) := by
      rw [hu_def, hv_def]; ring
    rw [huv, mul_eq_zero, or_iff_left hcc0]
    constructor
    · intro h0; linear_combination -h0
    · intro h0; linear_combination -h0
  have e2 : u - 1 = 0 ↔ x = q := by
    have hu1 : u - 1 = (x - q) * (starRingEnd ℂ) (q - p) := by
      rw [hu_def]; linear_combination hc
    rw [hu1, mul_eq_zero, or_iff_left hcc0, sub_eq_zero]
  have e3 : v - 1 = 0 ↔ y = p := by
    have hv1 : v - 1 = (p - y) * (starRingEnd ℂ) (q - p) := by
      rw [hv_def]; linear_combination hc
    rw [hv1, mul_eq_zero, or_iff_left hcc0]
    constructor
    · intro h0; linear_combination -h0
    · intro h0; linear_combination -h0
  rw [dist_eq_iff (by norm_num : (0 : ℝ) ≤ 1), one_pow, hnorm,
    unit_chord_units hu hv, mul_eq_zero, mul_eq_zero, or_assoc, e2, e3]
  constructor
  · rintro (h0 | h0 | h0)
    · exact Or.inl (e1.mp h0)
    · exact Or.inr (Or.inl h0)
    · exact Or.inr (Or.inr h0)
  · rintro (h0 | h0 | h0)
    · exact Or.inl (e1.mpr h0)
    · exact Or.inr (Or.inl h0)
    · exact Or.inr (Or.inr h0)

/-- **Inner–inner Möbius classification** (at the (0,1) anchor): a unit chord
between the two inner circles is a translate pair or lies on the graph of the
Möbius map `x = y/(3y − 2)`. Rational over the base field — the ii foreign web
adjoins NOTHING. (The anchor form has RATIONAL coefficients: the radius
irrationality cancels, which is why the anchored statement is the right one.) -/
theorem unit_chord_inner_inner {x y : ℂ}
    (hx : x ∈ Metric.sphere (0 : ℂ) (Real.sqrt 3 / 3))
    (hy : y ∈ Metric.sphere (1 : ℂ) (Real.sqrt 3 / 3)) :
    dist x y = 1 ↔ (y = x + 1 ∨ x * (3 * y - 2) = y) := by
  have hx' : x * (starRingEnd ℂ) x = 1 / 3 := by
    have h1 : normSq (x - 0) = (Real.sqrt 3 / 3) ^ 2 :=
      (dist_eq_iff sqrt3_third_nonneg).mp (Metric.mem_sphere.mp hx)
    rw [sub_zero, inner_radius_sq] at h1
    rw [Complex.mul_conj, h1]
    norm_num
  have hy' : (y - 1) * ((starRingEnd ℂ) y - 1) = 1 / 3 := by
    have h1 : normSq (y - 1) = (Real.sqrt 3 / 3) ^ 2 :=
      (dist_eq_iff sqrt3_third_nonneg).mp (Metric.mem_sphere.mp hy)
    rw [inner_radius_sq] at h1
    have := Complex.mul_conj (y - 1)
    rw [h1, map_sub, map_one] at this
    rw [this]
    norm_num
  have hx0 : x ≠ 0 := fun h0 => by rw [h0] at hx'; simp at hx'
  have hy1 : (1 : ℂ) - y ≠ 0 := by
    intro h0
    have hy1' : y = 1 := by linear_combination -h0
    rw [hy1'] at hy'
    simp at hy'
  have hmulne : (3 : ℂ) * x * (1 - y) ≠ 0 :=
    mul_ne_zero (mul_ne_zero (by norm_num) hx0) hy1
  constructor
  · intro hd
    have hK : (x - y) * ((starRingEnd ℂ) x - (starRingEnd ℂ) y) = 1 := by
      have h1 : normSq (x - y) = 1 := by
        have := (dist_eq_iff (by norm_num : (0 : ℝ) ≤ 1)).mp hd
        rwa [one_pow] at this
      have := Complex.mul_conj (x - y)
      rw [h1, map_sub] at this
      simpa using this
    have hz : (y - x - 1) * (x * (3 * y - 2) - y) = 0 := by
      linear_combination (-3 * x * (1 - y)) * hK + (-3 * (x - y) * (y - 1)) * hx'
        + (3 * x * (x - y)) * hy'
    rcases mul_eq_zero.mp hz with h0 | h0
    · exact Or.inl (by linear_combination h0)
    · exact Or.inr (sub_eq_zero.mp h0)
  · intro hbr
    have hz : (y - x - 1) * (x * (3 * y - 2) - y) = 0 := by
      rcases hbr with h0 | h0
      · apply mul_eq_zero_of_left; rw [h0]; ring
      · apply mul_eq_zero_of_right; rw [sub_eq_zero]; exact h0
    have hcancel : (3 : ℂ) * x * (1 - y)
        * ((x - y) * ((starRingEnd ℂ) x - (starRingEnd ℂ) y) - 1) = 0 := by
      linear_combination (-1 : ℂ) * hz + (-3 * (x - y) * (y - 1)) * hx'
        + (3 * x * (x - y)) * hy'
    rcases mul_eq_zero.mp hcancel with h0 | h0
    · exact absurd h0 hmulne
    · have hK : (x - y) * ((starRingEnd ℂ) x - (starRingEnd ℂ) y) = 1 :=
        sub_eq_zero.mp h0
      rw [dist_eq_iff (by norm_num : (0 : ℝ) ≤ 1), one_pow]
      have := Complex.mul_conj (x - y)
      rw [map_sub] at this
      rw [hK] at this
      exact_mod_cast this.symm

/-- A generic outer point's unit-partners on the partner's outer circle are
exactly its translate and the far pivot — the corollary that names the two
always-lattice partners of every outer probe (M22's measured 2-of-4, now exact). -/
theorem outer_partner_pair {p q x : ℂ} (h : dist p q = 1)
    (hx : x ∈ Metric.sphere p 1) (hxq : x ≠ q) :
    Metric.sphere q 1 ∩ Metric.sphere x 1 = {x + (q - p), p} := by
  ext z
  simp only [Set.mem_inter_iff, Set.mem_insert_iff, Set.mem_singleton_iff]
  constructor
  · rintro ⟨hz1, hz2⟩
    have hd : dist x z = 1 := by rw [dist_comm]; exact Metric.mem_sphere.mp hz2
    rcases (unit_chord_outer_outer h hx hz1).mp hd with h0 | h0 | h0
    · exact Or.inl h0
    · exact absurd h0 hxq
    · exact Or.inr h0
  · rintro (rfl | rfl)
    · exact ⟨mem_sphere_translate.mp hx,
        Metric.mem_sphere.mpr (by rw [dist_comm]; exact dist_translate h x)⟩
    · exact ⟨Metric.mem_sphere.mpr h,
        Metric.mem_sphere.mpr (by rw [dist_comm]; exact Metric.mem_sphere.mp hx)⟩

/-! ## The loop identities

The census (subplan §0.3-B): minimal hex relations at length 4 (parallelograms),
minimal seam relations at length 6 — the seam hexagon, which uses all three
pivots; no two-pivot seam relation exists at length ≤ 6. Geometric closure with
nonzero σ-content is impossible (`zpow` backbone below). -/

/-- The little identity powering the hex words: `1 − ζ₆ = conj ζ₆`. -/
theorem one_sub_zeta6 : (1 : ℂ) - zeta6 = (starRingEnd ℂ) zeta6 := by
  apply Complex.ext <;> simp [zeta6]
  norm_num

/-- The matching translation is a two-pivot hex word: rotating about the top
pivot IS rotating about the origin then translating by the base. -/
theorem hexStep_matching (z : ℂ) : hexStep zeta6 z = hexStep 0 z + 1 := by
  simp only [hexStep]
  linear_combination (-1 : ℂ) * zeta6_minpoly

/-- The metapivot's triangle operator is generated by two pivot hex steps:
`R₀ ∘ R₁ = rot3 about the centroid` (the 120° rotation the strip's ℤ/3 closure
uses, now a word in the triangle's own operators). -/
theorem hexStep_hexStep_eq_rot3_centroid (z : ℂ) :
    hexStep 0 (hexStep 1 z) = rot3 centroid z := by
  simp only [hexStep, rot3]
  rw [← zeta6_sq_eq_omega3]
  linear_combination (-1 : ℂ) * centroid_mul_one_sub + (-1 : ℂ) * zeta6_minpoly

/-- The triple word is the point-flip through the 0–ζ₆ edge midpoint:
`R₀ ∘ R₁ ∘ R₂ = (ζ₆ − ·)`. -/
theorem hexStep_triple_flip (z : ℂ) :
    hexStep 0 (hexStep 1 (hexStep zeta6 z)) = zeta6 - z := by
  simp only [hexStep]
  linear_combination (-zeta6 ^ 2 + zeta6 * z + z) * zeta6_minpoly

/-- **The hex parallelogram** — the minimal closed hex loop (length 4, census B):
`R₁ ∘ R₂⁻¹ ∘ R₁⁻¹ ∘ R₀ = id`. Hex-commensurability lets translations from
different pivot pairs cancel pairwise (this one genuinely needs `conj ζ₆ = 1 − ζ₆`
AND the minimal polynomial — unlike the hexagon below, it is hex-SPECIFIC). -/
theorem hex_parallelogram (z : ℂ) :
    rotAbout zeta6 1 (rotAbout ((starRingEnd ℂ) zeta6) zeta6
      (rotAbout ((starRingEnd ℂ) zeta6) 1 (rotAbout zeta6 0 z))) = z := by
  simp only [rotAbout]
  have hconj : (starRingEnd ℂ) zeta6 = 1 - zeta6 := one_sub_zeta6.symm
  linear_combination ((starRingEnd ℂ) zeta6 * zeta6 * z - (starRingEnd ℂ) zeta6
      - zeta6 + z + 1) * zeta6_mul_conj + (-1 : ℂ) * hconj + zeta6_minpoly

/-- **The rotation hexagon** — the alternating three-point loop closes for EVERY
unit rotation about EVERY three points: `S₂⁻¹ S₁ S₀⁻¹ S₂ S₁⁻¹ S₀ = id` needs only
`s·conj s = 1` (implementation discovery: sympy reduction leaves zero remainder
with generic pivots AND generic rotation). What is triangle- and seam-specific is
what the census adds: at the seam this loop is MINIMAL (length 6) and no
two-pivot seam relation exists at that scale — with two pivots the pattern
degenerates to a free cancellation. -/
theorem rot_hexagon {s : ℂ} (hs : normSq s = 1) (p₀ p₁ p₂ z : ℂ) :
    rotAbout ((starRingEnd ℂ) s) p₂ (rotAbout s p₁ (rotAbout ((starRingEnd ℂ) s) p₀
      (rotAbout s p₂ (rotAbout ((starRingEnd ℂ) s) p₁ (rotAbout s p₀ z))))) = z := by
  have hs' : s * (starRingEnd ℂ) s = 1 := by
    rw [Complex.mul_conj, hs, Complex.ofReal_one]
  simp only [rotAbout]
  linear_combination (-((starRingEnd ℂ) s ^ 2 * p₀ * s ^ 2)
      + (starRingEnd ℂ) s ^ 2 * p₀ * s - (starRingEnd ℂ) s ^ 2 * p₁ * s
      + (starRingEnd ℂ) s ^ 2 * s ^ 2 * z - (starRingEnd ℂ) s * p₀ * s
      + (starRingEnd ℂ) s * p₁ * s - (starRingEnd ℂ) s * p₁
      - (starRingEnd ℂ) s * p₂ * s + (starRingEnd ℂ) s * p₂
      + (starRingEnd ℂ) s * s * z - p₂ + z) * hs'

/-- **The seam hexagon** — the rotation hexagon at the triangle's own operator:
the certified cyclic constraint flow A→B→C→A. -/
theorem seam_hexagon (z : ℂ) :
    rotAbout ((starRingEnd ℂ) seam) zeta6 (rotAbout seam 1
      (rotAbout ((starRingEnd ℂ) seam) 0 (rotAbout seam zeta6
        (rotAbout ((starRingEnd ℂ) seam) 1 (rotAbout seam 0 z))))) = z :=
  rot_hexagon (by rw [← Complex.sq_norm, norm_seam]; norm_num) 0 1 zeta6 z

/-- The algebraic backbone of every closure question: a hex–seam word's linear
part is trivial exactly when the hex content is a full turn and the seam content
is zero. (The census's B1: closed words have σ-exponent exactly 0 — the seam's
infinite order, in `zpow` form.) -/
theorem zeta6_zpow_mul_seam_zpow_eq_one_iff (a b : ℤ) :
    zeta6 ^ a * seam ^ b = 1 ↔ (6 ∣ a ∧ b = 0) := by
  constructor
  · intro h
    have h6 : (zeta6 ^ a) ^ (6 : ℕ) * (seam ^ b) ^ (6 : ℕ) = 1 := by
      rw [← mul_pow, h, one_pow]
    rw [← zpow_natCast (zeta6 ^ a) 6, ← zpow_natCast (seam ^ b) 6,
      ← zpow_mul, ← zpow_mul] at h6
    have hz : zeta6 ^ (a * (6 : ℕ) : ℤ) = 1 :=
      zeta6_zpow_eq_one_iff.mpr ⟨a, by push_cast; ring⟩
    rw [hz, one_mul] at h6
    have hb : b * (6 : ℕ) = (0 : ℤ) := seam_zpow_eq_one_iff.mp h6
    have hb0 : b = 0 := by omega
    subst hb0
    rw [zpow_zero, mul_one] at h
    exact ⟨zeta6_zpow_eq_one_iff.mp h, rfl⟩
  · rintro ⟨⟨k, rfl⟩, rfl⟩
    rw [zpow_zero, mul_one]
    exact zeta6_zpow_eq_one_iff.mpr ⟨k, rfl⟩

/-! ## Specification -/

/-- The centroid IS the ii-gluing ratio at the (0,1) anchor. -/
example : centroid = innerGlueRatio := rfl

/-- The name means what it says: the centroid is the vertex average. -/
example : centroid = (0 + 1 + zeta6) / 3 := by
  rw [eq_div_iff (by norm_num : (3 : ℂ) ≠ 0)]
  apply Complex.ext <;> simp [centroid, zeta6] <;> ring

/-- The hex step is a `rotAbout` instance — the named bridge (experience pass:
an anonymous pin guards drift but hands the consumer no handle to rewrite
across; these three are `rfl`, so the guard is identical). -/
theorem rotAbout_zeta6 (p z : ℂ) : rotAbout TwoCircle.zeta6 p z = hexStep p z := rfl

/-- The seam image is a `rotAbout` instance (non-unit ratio: the outer→inner
contraction). -/
theorem rotAbout_seamRatio (p z : ℂ) : rotAbout seamRatio p z = seamImage p z := rfl

/-- The ℤ/3 closure rotation is a `rotAbout` instance. -/
theorem rotAbout_omega3 (p z : ℂ) : rotAbout omega3 p z = rot3 p z := rfl

/-- The oo mirror at the anchor is plain conjugation (the axis is real). -/
example : reflAcross 0 1 zeta6 = (starRingEnd ℂ) zeta6 :=
  reflAcross_01_apply zeta6

/-- The ten-point set is inhabited: the third pivot is a shared point of the
anchored pair. -/
example : zeta6 ∈ system (0 : ℂ) ∩ system 1 := by
  rw [system_inter_system dist_pivot_01]
  exact Or.inr (Or.inr (Or.inl hexStep_cycle_01.symm))

/-- Adversarial member: `−1` lies on the first system's outer circle but shares
nothing with the second system (distance 2 from its pivot). -/
example : (-1 : ℂ) ∉ system (0 : ℂ) ∩ system 1 := by
  rintro ⟨-, h2⟩
  have hd : dist (-1 : ℂ) 1 = 2 := by
    rw [dist_eq_iff (by norm_num : (0 : ℝ) ≤ 2)]
    simp [normSq_apply]
    norm_num
  simp only [Coupled.system, Set.mem_insert_iff, Set.mem_union,
    Metric.mem_sphere] at h2
  rcases h2 with h0 | h0 | h0
  · exact ne_of_re (by norm_num) h0
  · rw [hd] at h0; norm_num at h0
  · rw [hd] at h0; nlinarith [sq_sqrt3]

/-- The matching branch of the oo classification, concretely: the third pivot's
translate is a unit chord. -/
example : dist zeta6 (zeta6 + 1) = 1 := by
  have h := dist_translate dist_pivot_01 zeta6
  simp only [sub_zero] at h
  exact h

/-- The Möbius branch of the ii classification is inhabited OFF the matching
(the branches overlap exactly at the two collinear pairs `3x² = 1`, so a
collinear witness would discriminate nothing — domain-pass audit): the
down-centroid to the top of the partner's inner circle is a genuine
Möbius-only unit chord. -/
example :
    (⟨1 / 2, -(Real.sqrt 3 / 6)⟩ : ℂ) * (3 * ⟨1, Real.sqrt 3 / 3⟩ - 2)
      = (⟨1, Real.sqrt 3 / 3⟩ : ℂ) := by
  apply Complex.ext <;>
    simp [Complex.mul_re, Complex.mul_im] <;>
    nlinarith [sq_sqrt3]

/-- …and it is NOT a matching chord. -/
example :
    (⟨1 / 2, -(Real.sqrt 3 / 6)⟩ : ℂ) + 1 ≠ (⟨1, Real.sqrt 3 / 3⟩ : ℂ) := by
  apply ne_of_im
  simp
  nlinarith [sqrt3_pos]

/-- The backbone's teeth: one seam step composed with one hex step is NOT
closure. -/
example : zeta6 * seam ≠ 1 := fun h => by
  have := (zeta6_zpow_mul_seam_zpow_eq_one_iff 1 1).mp (by simpa using h)
  omega

/-- The hexagon's negative control (the census's perturbed word, kernel side):
flip the final inverse step to a forward step and the loop no longer closes —
evaluated at the origin. -/
example :
    rotAbout seam zeta6 (rotAbout seam 1
      (rotAbout ((starRingEnd ℂ) seam) 0 (rotAbout seam zeta6
        (rotAbout ((starRingEnd ℂ) seam) 1 (rotAbout seam 0 0))))) ≠ 0 := by
  have h1 : rotAbout seam 0 (0 : ℂ) = 0 := by simp [rotAbout]
  have h2 : rotAbout ((starRingEnd ℂ) seam) 1 (0 : ℂ)
      = ⟨1 - Real.sqrt 3 / 6, Real.sqrt 33 / 6⟩ := by
    apply Complex.ext <;> simp [rotAbout, seam, conj_mk]
    ring
  have h3 : rotAbout seam zeta6 (⟨1 - Real.sqrt 3 / 6, Real.sqrt 33 / 6⟩ : ℂ)
      = ⟨-(1 / 2) + Real.sqrt 3 / 12 + Real.sqrt 11 / 4,
         -(1 / 4) + Real.sqrt 33 / 12 + Real.sqrt 3 / 2⟩ := by
    apply Complex.ext <;>
      simp [rotAbout, seam, zeta6, Complex.mul_re, Complex.mul_im] <;>
      nlinarith [sq_sqrt3, sq_sqrt11, sq_sqrt33, sqrt3_mul_sqrt11,
        sqrt3_mul_sqrt33, sqrt11_mul_sqrt33]
  have h4 : rotAbout ((starRingEnd ℂ) seam) 0
      (⟨-(1 / 2) + Real.sqrt 3 / 12 + Real.sqrt 11 / 4,
        -(1 / 4) + Real.sqrt 33 / 12 + Real.sqrt 3 / 2⟩ : ℂ)
      = ⟨1 / 2 - Real.sqrt 3 / 12 + Real.sqrt 11 / 4,
         1 / 4 + Real.sqrt 33 / 12 - Real.sqrt 3 / 2⟩ := by
    apply Complex.ext <;>
      simp [rotAbout, seam, conj_mk, Complex.mul_re, Complex.mul_im] <;>
      nlinarith [sq_sqrt3, sq_sqrt11, sq_sqrt33, sqrt3_mul_sqrt11,
        sqrt3_mul_sqrt33, sqrt11_mul_sqrt33]
  have h5 : rotAbout seam 1
      (⟨1 / 2 - Real.sqrt 3 / 12 + Real.sqrt 11 / 4,
        1 / 4 + Real.sqrt 33 / 12 - Real.sqrt 3 / 2⟩ : ℂ)
      = ⟨1 / 2 - Real.sqrt 3 / 12 + Real.sqrt 11 / 4,
         -(1 / 4) - Real.sqrt 33 / 12 + Real.sqrt 3 / 2⟩ := by
    apply Complex.ext <;>
      simp [rotAbout, seam, Complex.mul_re, Complex.mul_im] <;>
      nlinarith [sq_sqrt3, sq_sqrt11, sq_sqrt33, sqrt3_mul_sqrt11,
        sqrt3_mul_sqrt33, sqrt11_mul_sqrt33]
  have h6 : rotAbout seam zeta6
      (⟨1 / 2 - Real.sqrt 3 / 12 + Real.sqrt 11 / 4,
        -(1 / 4) - Real.sqrt 33 / 12 + Real.sqrt 3 / 2⟩ : ℂ)
      = ⟨11 / 12 + Real.sqrt 33 / 12, 11 * Real.sqrt 3 / 12 - Real.sqrt 11 / 12⟩ := by
    apply Complex.ext <;>
      simp [rotAbout, seam, zeta6, Complex.mul_re, Complex.mul_im] <;>
      nlinarith [sq_sqrt3, sq_sqrt11, sq_sqrt33, sqrt3_mul_sqrt11,
        sqrt3_mul_sqrt33, sqrt11_mul_sqrt33]
  rw [h1, h2, h3, h4, h5, h6]
  refine ne_of_re ?_
  simp
  positivity

end Triangle
end HadwigerNelson
