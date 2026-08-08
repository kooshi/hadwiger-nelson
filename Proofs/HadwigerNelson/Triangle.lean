import Proofs.HadwigerNelson.Glue

/-! # The pivot triangle and the metapivot system (M23 skeleton)

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
  parallelogram, and the seam hexagon — the certified cyclic constraint loop that
  requires all three pivots (census B: no two-pivot seam relation exists at ≤ 6).
-/

namespace HadwigerNelson
namespace Triangle

open Complex TwoCircle Compulsion Coupled

/-! ## The anchor -/

/-- The centroid of the anchored pivot triangle {0, 1, ζ₆} — the metapivot: the
first triple glue point, and the centre of the fourth two-circle system. Equal to
`Coupled.innerGlueRatio` as a point (the ii-gluing ratio IS the centroid at the
(0,1) anchor — spec example below). -/
noncomputable def centroid : ℂ := ⟨1 / 2, Real.sqrt 3 / 6⟩

/-- The one rotation operator: rotate `z` about `p` by the unit (or ratio) `u`.
`hexStep p = rotAbout ζ₆ p`, `seamImage p = rotAbout seamRatio p`,
`rot3 p = rotAbout ω₃ p` — the three existing operators are instances (spec
examples below); inverses are `rotAbout (conj u) p` for unit `u`. -/
noncomputable def rotAbout (u p z : ℂ) : ℂ := p + u * (z - p)

/-- The three pivot pair distances. -/
theorem dist_pivot_01 : dist (0 : ℂ) 1 = 1 := by sorry

theorem dist_pivot_02 : dist (0 : ℂ) zeta6 = 1 := by sorry

theorem dist_pivot_12 : dist (1 : ℂ) zeta6 = 1 := by sorry

/-- The centroid is at inner radius from every pivot — the triple glue point,
distance side. -/
theorem dist_centroid_0 : dist (0 : ℂ) centroid = Real.sqrt 3 / 3 := by sorry

theorem dist_centroid_1 : dist (1 : ℂ) centroid = Real.sqrt 3 / 3 := by sorry

theorem dist_centroid_2 : dist zeta6 centroid = Real.sqrt 3 / 3 := by sorry

/-! ## The self-gluing cycle: the hex step permutes the pivots -/

theorem hexStep_cycle_01 : hexStep 0 1 = zeta6 := by sorry

theorem hexStep_cycle_12 : hexStep 1 zeta6 = 0 := by sorry

theorem hexStep_cycle_20 : hexStep zeta6 0 = 1 := by sorry

/-- Outer meets outer at the THIRD pivot (and its mirror, the reflected apex):
the triangle is self-glued. -/
theorem outer_inter_outer_eq_third :
    Metric.sphere (0 : ℂ) 1 ∩ Metric.sphere (1 : ℂ) 1
      = {zeta6, reflAcross 0 1 zeta6} := by sorry

/-! ## The centroid as the triple glue point -/

/-- The (+)-branch inner∩inner glue point of the pair (0,1) is the centroid. -/
theorem centroid_glue_01 : (0 : ℂ) + innerGlueRatio * ((1 : ℂ) - 0) = centroid := by
  sorry

/-- The (+)-branch inner∩inner glue point of the pair (1,ζ₆) is the centroid. -/
theorem centroid_glue_12 : (1 : ℂ) + innerGlueRatio * (zeta6 - 1) = centroid := by
  sorry

/-- The (+)-branch inner∩inner glue point of the pair (ζ₆,0) is the centroid. -/
theorem centroid_glue_20 : zeta6 + innerGlueRatio * ((0 : ℂ) - zeta6) = centroid := by
  sorry

/-! ## The metapivot couplings create no new points (except outer∩outer)

Census A (exact): the three couplings below are the complete pivot–metapivot
incidence structure apart from the six √33-family outer∩outer points, which stay
generic `Glue.sphere_inter_sphere` instances (no consumer yet — not minted). -/

/-- A pivot's outer circle meets the metapivot's inner circle exactly at the OTHER
TWO PIVOTS. -/
theorem outer_inter_metaInner :
    Metric.sphere (0 : ℂ) 1 ∩ Metric.sphere centroid (Real.sqrt 3 / 3)
      = {1, zeta6} := by sorry

/-- A pivot's inner circle meets the metapivot's outer circle exactly at the two
120°-partners of the centroid about that pivot. -/
theorem inner_inter_metaOuter :
    Metric.sphere (0 : ℂ) (Real.sqrt 3 / 3) ∩ Metric.sphere centroid 1
      = {rot3 0 centroid, rot3 0 (rot3 0 centroid)} := by sorry

/-- A pivot's inner circle meets the metapivot's inner circle exactly at the two
MIRROR CENTROIDS — the centroid's reflections across the two triangle edges at
that pivot (census A's correction: these gluings adjoin nothing new). -/
theorem inner_inter_metaInner :
    Metric.sphere (0 : ℂ) (Real.sqrt 3 / 3) ∩ Metric.sphere centroid (Real.sqrt 3 / 3)
      = {reflAcross 0 1 centroid, reflAcross 0 zeta6 centroid} := by sorry

/-! ## The ten-point sharing theorem -/

/-- **Two unit-separated systems share exactly ten points**: the two pivots and
the eight glue points (the four certified gluing classifications as one set
count). General in the unit pair. -/
theorem system_inter_system {p q : ℂ} (h : dist p q = 1) :
    system p ∩ system q
      = {p, q, hexStep p q, reflAcross p q (hexStep p q),
         seamImage q p, reflAcross p q (seamImage q p),
         seamImage p q, reflAcross p q (seamImage p q),
         p + innerGlueRatio * (q - p),
         reflAcross p q (p + innerGlueRatio * (q - p))} := by sorry

/-- The ten shared points are pairwise distinct at the anchor: the count is
exactly ten. -/
theorem ncard_system_inter_system :
    (system (0 : ℂ) ∩ system 1).ncard = 10 := by sorry

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
    dist x y = 1 ↔ (y = x + (q - p) ∨ x = q ∨ y = p) := by sorry

/-- **Inner–inner Möbius classification** (at the (0,1) anchor): a unit chord
between the two inner circles is a translate pair or lies on the graph of the
Möbius map `x = y/(3y − 2)`. Rational over the base field — the ii foreign web
adjoins NOTHING. -/
theorem unit_chord_inner_inner {x y : ℂ}
    (hx : x ∈ Metric.sphere (0 : ℂ) (Real.sqrt 3 / 3))
    (hy : y ∈ Metric.sphere (1 : ℂ) (Real.sqrt 3 / 3)) :
    dist x y = 1 ↔ (y = x + 1 ∨ x * (3 * y - 2) = y) := by sorry

/-- A generic outer point's unit-partners on the partner's outer circle are
exactly its translate and the far pivot — the corollary that names the two
always-lattice partners of every outer probe (M22's measured 2-of-4, now exact). -/
theorem outer_partner_pair {p q x : ℂ} (h : dist p q = 1)
    (hx : x ∈ Metric.sphere p 1) (hxq : x ≠ q) :
    Metric.sphere q 1 ∩ Metric.sphere x 1 = {x + (q - p), p} := by sorry

/-! ## The loop identities

The census (subplan §0.3-B): minimal hex relations at length 4 (parallelograms),
minimal seam relations at length 6 — the seam hexagon, which uses all three
pivots; no two-pivot seam relation exists at length ≤ 6. Geometric closure with
nonzero σ-content is impossible (`zpow` backbone below). -/

/-- The little identity powering the hex words: `1 − ζ₆ = conj ζ₆`. -/
theorem one_sub_zeta6 : (1 : ℂ) - zeta6 = (starRingEnd ℂ) zeta6 := by sorry

/-- The matching translation is a two-pivot hex word: rotating about the top
pivot IS rotating about the origin then translating by the base. -/
theorem hexStep_matching (z : ℂ) : hexStep zeta6 z = hexStep 0 z + 1 := by sorry

/-- The metapivot's triangle operator is generated by two pivot hex steps:
`R₀ ∘ R₁ = rot3 about the centroid` (the 120° rotation the strip's ℤ/3 closure
uses, now a word in the triangle's own operators). -/
theorem hexStep_hexStep_eq_rot3_centroid (z : ℂ) :
    hexStep 0 (hexStep 1 z) = rot3 centroid z := by sorry

/-- The triple word is the point-flip through the 0–ζ₆ edge midpoint:
`R₀ ∘ R₁ ∘ R₂ = (ζ₆ − ·)`. -/
theorem hexStep_triple_flip (z : ℂ) :
    hexStep 0 (hexStep 1 (hexStep zeta6 z)) = zeta6 - z := by sorry

/-- **The hex parallelogram** — the minimal closed hex loop (length 4, census B):
`R₁ ∘ R₂⁻¹ ∘ R₁⁻¹ ∘ R₀ = id`. Hex-commensurability lets translations from
different pivot pairs cancel pairwise. -/
theorem hex_parallelogram (z : ℂ) :
    rotAbout zeta6 1 (rotAbout ((starRingEnd ℂ) zeta6) zeta6
      (rotAbout ((starRingEnd ℂ) zeta6) 1 (rotAbout zeta6 0 z))) = z := by sorry

/-- **The seam hexagon** — the minimal closed seam loop (length 6, census B):
`S₂⁻¹ ∘ S₁ ∘ S₀⁻¹ ∘ S₂ ∘ S₁⁻¹ ∘ S₀ = id`, visiting all three pivots. The
certified cyclic constraint flow A→B→C→A: it exists at the triangle and cannot
exist at the pair (no two-pivot seam relation at length ≤ 6 — census; the pair's
two-letter translations never cancel). -/
theorem seam_hexagon (z : ℂ) :
    rotAbout ((starRingEnd ℂ) seam) zeta6 (rotAbout seam 1
      (rotAbout ((starRingEnd ℂ) seam) 0 (rotAbout seam zeta6
        (rotAbout ((starRingEnd ℂ) seam) 1 (rotAbout seam 0 z))))) = z := by sorry

/-- The algebraic backbone of every closure question: a hex–seam word's linear
part is trivial exactly when the hex content is a full turn and the seam content
is zero. (The census's B1: closed words have σ-exponent exactly 0 — the seam's
infinite order, in `zpow` form.) -/
theorem zeta6_zpow_mul_seam_zpow_eq_one_iff (a b : ℤ) :
    zeta6 ^ a * seam ^ b = 1 ↔ (6 ∣ a ∧ b = 0) := by sorry

/-! ## Specification -/

/-- The centroid IS the ii-gluing ratio at the (0,1) anchor. -/
example : centroid = innerGlueRatio := rfl

/-- The name means what it says: the centroid is the vertex average. -/
example : centroid = (0 + 1 + zeta6) / 3 := by sorry

/-- The three operators are `rotAbout` instances. -/
example (p z : ℂ) : rotAbout TwoCircle.zeta6 p z = hexStep p z := rfl

example (p z : ℂ) : rotAbout seamRatio p z = seamImage p z := rfl

example (p z : ℂ) : rotAbout omega3 p z = rot3 p z := rfl

/-- The oo mirror at the anchor is plain conjugation (the axis is real). -/
example : reflAcross 0 1 zeta6 = (starRingEnd ℂ) zeta6 := by sorry

/-- The ten-point set is inhabited: the third pivot is a shared point of the
anchored pair. -/
example : zeta6 ∈ system (0 : ℂ) ∩ system 1 := by sorry

/-- Adversarial member: `−1` lies on the first system's outer circle but shares
nothing with the second system (distance 2 from its pivot). -/
example : (-1 : ℂ) ∉ system (0 : ℂ) ∩ system 1 := by sorry

/-- The matching branch of the oo classification, concretely: the third pivot's
translate is a unit chord. -/
example : dist zeta6 (zeta6 + 1) = 1 := by sorry

/-- The Möbius branch of the ii classification is inhabited off the matching:
the collinear pair `(√3/3, 1 + √3/3)` satisfies `x(3y−2) = y` and is a unit
chord. -/
example :
    (⟨Real.sqrt 3 / 3, 0⟩ : ℂ) * (3 * ⟨1 + Real.sqrt 3 / 3, 0⟩ - 2)
      = (⟨1 + Real.sqrt 3 / 3, 0⟩ : ℂ) := by sorry

/-- The backbone's teeth: one seam step composed with one hex step is NOT
closure. -/
example : zeta6 * seam ≠ 1 := by sorry

end Triangle
end HadwigerNelson
