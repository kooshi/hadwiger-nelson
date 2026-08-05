import Proofs.HadwigerNelson.TwoCircle
import Proofs.HadwigerNelson.ClassGeometry

/-! # The 120° compulsion and the one-pivot cap

M20's sharpening of the two-circle barrier, in two theorems.

**The 120° compulsion** (`no_mono_outer_triple`): in every proper 3-colouring of the two
circles about `p`, an outer 120°-triple `{z, rot3 p z, rot3² p z}` is never monochromatic —
although its three points are pairwise *non-adjacent* (chord √3). The witness is the
seam-image unit triangle: `seamImage p z = p + σ·(z − p)` with `σ = seam/√3 = ⟨1/6, √11/6⟩`
lies on the inner circle, its `rot3`-orbit is a unit triangle (M18 `rot3_unit_triangle`),
hence rainbow — yet each member is unit-adjacent to one point of the triple, so a
monochromatic triple would starve the rainbow of its colour. The first colour compulsion
in this project that acts through no edge.

**The one-pivot cap** (`concentric_not_colorable_three` + `concentric_colorable_four`, headline
`chromaticNumber_concentric`): adjoin the centre and the system is *exactly* 4-chromatic.
The centre eats one colour, five consecutive outer points then alternate through two
colours, the 120°-triple among them goes monochromatic, and the compulsion kills it —
nine points suffice (`p`, five consecutive outer points, one inner triangle). Conversely
M19's 3-colouring of the circles plus a fresh colour at `p` gives 4. Corollary, and the
sharpest form of the local barrier: **coverage 4 at five colours cannot arise within one
pivot's two-circle system — a fifth colour needs structure spanning more than one
pivot.** This theorem explains the flat `minCov = 3` histograms of M17–M19.

Found in M20 §0 (the compulsion, via the strip automaton's mono-column obstruction) and
independently in composed 16-point form by a reviewer instance whose note Kooshi relayed;
the compression to nine points is the compulsion lemma doing its work.

The compulsion is stated over an arbitrary vertex set `D` containing the two circles:
a colouring of a larger induced graph restricts to any subset, so quantifying over the
superset bakes the monotonicity in and no restriction machinery exists in this module.
-/

namespace HadwigerNelson
namespace Compulsion

open Complex

/-! ## The seam ratio, rationalized -/

/-- `σ = seam/√3 = ⟨1/6, √11/6⟩`: the ratio carrying an outer point's displacement to its
seam-image on the inner circle. Defined with explicit components (the `/√3` is folded in:
`√33/√3 = √11`) so every norm fact below is component arithmetic. -/
noncomputable def seamRatio : ℂ := ⟨1 / 6, Real.sqrt 11 / 6⟩

private theorem sq_sqrt11 : Real.sqrt 11 * Real.sqrt 11 = 11 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sq_sqrt3' : Real.sqrt 3 * Real.sqrt 3 = 3 :=
  Real.mul_self_sqrt (by norm_num)

theorem normSq_seamRatio : normSq seamRatio = 1 / 3 := by
  simp only [normSq_apply, seamRatio]
  linear_combination (1 / 36 : ℝ) * sq_sqrt11

theorem normSq_one_sub_seamRatio : normSq (1 - seamRatio) = 1 := by
  simp only [normSq_apply, Complex.sub_re, Complex.sub_im, Complex.one_re,
    Complex.one_im, seamRatio]
  linear_combination (1 / 36 : ℝ) * sq_sqrt11

/-- The tie to M19: `σ·√3 = seam` — the seam-image is the cross-chord rotation. -/
theorem seamRatio_mul_sqrt3 : seamRatio * (Real.sqrt 3 : ℂ) = TwoCircle.seam := by
  have h33 : Real.sqrt 33 = Real.sqrt 3 * Real.sqrt 11 := by
    rw [← Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 3)]
    norm_num
  apply Complex.ext
  · simp only [Complex.mul_re, seamRatio, TwoCircle.seam, Complex.ofReal_re,
      Complex.ofReal_im]
    ring
  · simp only [Complex.mul_im, seamRatio, TwoCircle.seam, Complex.ofReal_re,
      Complex.ofReal_im, h33]
    ring

/-! ## The seam image and its geometry -/

/-- The seam-image of `z` about `p`: the inner-circle point unit-adjacent to `z` whose
`rot3`-orbit witnesses the compulsion. -/
noncomputable def seamImage (p z : ℂ) : ℂ := p + seamRatio * (z - p)

private theorem normSq_sub_one {z p : ℂ} (hz : dist z p = 1) : normSq (z - p) = 1 := by
  have hn : ‖z - p‖ = 1 := by rw [← Complex.dist_eq]; exact hz
  rw [← Complex.sq_norm, hn]
  norm_num

/-- The inner radius squared, in the form `rot3_unit_triangle` consumes. -/
theorem dist_seamImage_sq {p z : ℂ} (hz : dist z p = 1) :
    dist (seamImage p z) p ^ 2 = 1 / 3 := by
  have h1 : seamImage p z - p = seamRatio * (z - p) := by
    simp only [seamImage]; ring
  rw [Complex.dist_eq, h1, Complex.sq_norm, Complex.normSq_mul, normSq_seamRatio,
    normSq_sub_one hz]
  ring

/-- The seam-image of an outer point lies on the inner circle. -/
theorem dist_seamImage_pivot {p z : ℂ} (hz : dist z p = 1) :
    dist (seamImage p z) p = Real.sqrt 3 / 3 := by
  have h2 : (Real.sqrt 3 / 3) ^ 2 = 1 / 3 := by
    rw [div_pow, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 3)]
    norm_num
  calc dist (seamImage p z) p
      = Real.sqrt (dist (seamImage p z) p ^ 2) := (Real.sqrt_sq dist_nonneg).symm
    _ = Real.sqrt ((Real.sqrt 3 / 3) ^ 2) := by rw [dist_seamImage_sq hz, h2]
    _ = Real.sqrt 3 / 3 := Real.sqrt_sq (by positivity)

/-- An outer point is unit-adjacent to its seam-image. -/
theorem dist_self_seamImage {p z : ℂ} (hz : dist z p = 1) :
    dist z (seamImage p z) = 1 := by
  have h1 : z - seamImage p z = (1 - seamRatio) * (z - p) := by
    simp only [seamImage]; ring
  have h2 : dist z (seamImage p z) ^ 2 = 1 := by
    rw [Complex.dist_eq, h1, Complex.sq_norm, Complex.normSq_mul,
      normSq_one_sub_seamRatio, normSq_sub_one hz]
    ring
  calc dist z (seamImage p z)
      = Real.sqrt (dist z (seamImage p z) ^ 2) := (Real.sqrt_sq dist_nonneg).symm
    _ = Real.sqrt 1 := by rw [h2]
    _ = 1 := Real.sqrt_one

/-- `rot3` preserves every sphere about its pivot. -/
theorem rot3_mem_sphere {p z : ℂ} {r : ℝ} (h : z ∈ Metric.sphere p r) :
    rot3 p z ∈ Metric.sphere p r := by
  simp only [Metric.mem_sphere] at h ⊢
  rw [dist_rot3_pivot]
  exact h

/-! ## The compulsion -/

/-- **The 120° compulsion.** In any proper 3-colouring of any point set containing the
two circles about `p`, the outer 120°-triple of `z` — pairwise at chord √3, an
independent set — never wears one colour. The seam-image unit triangle is rainbow and
each member refuses its partner's colour. Stated over a superset `D` so it applies
directly inside larger systems (`insert p _` below) with no restriction machinery. -/
theorem no_mono_outer_triple {D : Set ℂ} (p : ℂ)
    (hD : Metric.sphere p 1 ∪ Metric.sphere p (Real.sqrt 3 / 3) ⊆ D)
    (C : ((unitDistance ℂ).induce D).Coloring (Fin 3))
    {z : ℂ} (hz : z ∈ Metric.sphere p 1) :
    ¬ (C ⟨rot3 p z, hD (Or.inl (rot3_mem_sphere hz))⟩ = C ⟨z, hD (Or.inl hz)⟩ ∧
       C ⟨rot3 p (rot3 p z), hD (Or.inl (rot3_mem_sphere (rot3_mem_sphere hz)))⟩
         = C ⟨z, hD (Or.inl hz)⟩) := by
  rintro ⟨h1, h2⟩
  have hzp : dist z p = 1 := hz
  -- the witness triangle: the rot3-orbit of the seam-image, a unit triangle
  obtain ⟨e01, e12, e20⟩ := rot3_unit_triangle (dist_seamImage_sq hzp)
  have hyS : seamImage p z ∈ Metric.sphere p (Real.sqrt 3 / 3) :=
    dist_seamImage_pivot hzp
  have m0 : seamImage p z ∈ D := hD (Or.inr hyS)
  have m1 : rot3 p (seamImage p z) ∈ D := hD (Or.inr (rot3_mem_sphere hyS))
  have m2 : rot3 p (rot3 p (seamImage p z)) ∈ D :=
    hD (Or.inr (rot3_mem_sphere (rot3_mem_sphere hyS)))
  -- rainbow: the triangle's three colours are pairwise distinct
  have d01 : C ⟨seamImage p z, m0⟩ ≠ C ⟨rot3 p (seamImage p z), m1⟩ :=
    C.valid (unitDistance_adj.mpr e01)
  have d12 : C ⟨rot3 p (seamImage p z), m1⟩
      ≠ C ⟨rot3 p (rot3 p (seamImage p z)), m2⟩ :=
    C.valid (unitDistance_adj.mpr e12)
  have d20 : C ⟨rot3 p (rot3 p (seamImage p z)), m2⟩ ≠ C ⟨seamImage p z, m0⟩ :=
    C.valid (unitDistance_adj.mpr e20)
  -- each triangle member refuses its outer partner's colour
  have q0 : C ⟨z, hD (Or.inl hz)⟩ ≠ C ⟨seamImage p z, m0⟩ :=
    C.valid (unitDistance_adj.mpr (dist_self_seamImage hzp))
  have q1 : C ⟨rot3 p z, hD (Or.inl (rot3_mem_sphere hz))⟩
      ≠ C ⟨rot3 p (seamImage p z), m1⟩ :=
    C.valid ((unitDistance_adj (V := ℂ)).mpr
      (by show dist (rot3 p z) (rot3 p (seamImage p z)) = 1
          rw [dist_rot3]; exact dist_self_seamImage hzp))
  have q2 : C ⟨rot3 p (rot3 p z), hD (Or.inl (rot3_mem_sphere (rot3_mem_sphere hz)))⟩
      ≠ C ⟨rot3 p (rot3 p (seamImage p z)), m2⟩ :=
    C.valid ((unitDistance_adj (V := ℂ)).mpr
      (by show dist (rot3 p (rot3 p z)) (rot3 p (rot3 p (seamImage p z))) = 1
          rw [dist_rot3, dist_rot3]; exact dist_self_seamImage hzp))
  -- pigeonhole: three pairwise-distinct values of Fin 3 hit every value
  have pigeon : ∀ c0 c1 c2 v : Fin 3, c0 ≠ c1 → c1 ≠ c2 → c2 ≠ c0 →
      v = c0 ∨ v = c1 ∨ v = c2 := by decide
  rcases pigeon _ _ _ (C ⟨z, hD (Or.inl hz)⟩) d01 d12 d20 with h | h | h
  · exact q0 h
  · exact q1 (h1.trans h)
  · exact q2 (h2.trans h)

/-! ## The one-pivot cap -/

/-- The 60° step on the outer circle: the hexagon generator. -/
noncomputable def hexStep (p z : ℂ) : ℂ := p + TwoCircle.zeta6 * (z - p)

theorem hexStep_mem_sphere {p z : ℂ} (h : z ∈ Metric.sphere p 1) :
    hexStep p z ∈ Metric.sphere p 1 := by
  simp only [Metric.mem_sphere] at h ⊢
  have h1 : hexStep p z - p = TwoCircle.zeta6 * (z - p) := by
    simp only [hexStep]; ring
  rw [Complex.dist_eq, h1, norm_mul, TwoCircle.norm_zeta6, one_mul,
    ← Complex.dist_eq]
  exact h

private theorem normSq_one_sub_zeta6 : normSq (1 - TwoCircle.zeta6) = 1 := by
  simp only [normSq_apply, Complex.sub_re, Complex.sub_im, Complex.one_re,
    Complex.one_im, TwoCircle.zeta6]
  linear_combination (1 / 4 : ℝ) * sq_sqrt3'

/-- Consecutive hexagon points are unit-adjacent (the 60° chord). -/
theorem dist_self_hexStep {p z : ℂ} (hz : dist z p = 1) :
    dist z (hexStep p z) = 1 := by
  have h1 : z - hexStep p z = (1 - TwoCircle.zeta6) * (z - p) := by
    simp only [hexStep]; ring
  have h2 : dist z (hexStep p z) ^ 2 = 1 := by
    rw [Complex.dist_eq, h1, Complex.sq_norm, Complex.normSq_mul,
      normSq_one_sub_zeta6, normSq_sub_one hz]
    ring
  calc dist z (hexStep p z)
      = Real.sqrt (dist z (hexStep p z) ^ 2) := (Real.sqrt_sq dist_nonneg).symm
    _ = Real.sqrt 1 := by rw [h2]
    _ = 1 := Real.sqrt_one

private theorem zeta6_mul_zeta6 : TwoCircle.zeta6 * TwoCircle.zeta6 = omega3 := by
  apply Complex.ext
  · simp only [Complex.mul_re, TwoCircle.zeta6, omega3]
    linear_combination (-(1 : ℝ) / 4) * sq_sqrt3'
  · simp only [Complex.mul_im, TwoCircle.zeta6, omega3]
    ring

/-- Two 60° steps are one 120° rotation: `hexStep² = rot3`. -/
theorem hexStep_hexStep (p z : ℂ) : hexStep p (hexStep p z) = rot3 p z := by
  simp only [hexStep, rot3]
  rw [← zeta6_mul_zeta6]
  ring

/-- **The cap, lower half.** Adjoin the centre and three colours no longer suffice: the
centre pigeonholes the outer circle to two colours, five consecutive outer points then
alternate, the 120°-triple among them goes monochromatic, and the compulsion kills it.
Nine points carry the argument. -/
theorem concentric_not_colorable_three (p : ℂ) :
    ¬ ((unitDistance ℂ).induce
        (insert p (Metric.sphere p 1 ∪ Metric.sphere p (Real.sqrt 3 / 3)))).Colorable 3 := by
  rintro ⟨C⟩
  -- the nine points: p, five consecutive outer points w0..w4, and (inside the
  -- compulsion) the seam-image triangle of w0
  have hw0 : (p + 1) ∈ Metric.sphere p 1 := by
    simp
  have hw1 : hexStep p (p + 1) ∈ Metric.sphere p 1 := hexStep_mem_sphere hw0
  have hw2 : rot3 p (p + 1) ∈ Metric.sphere p 1 := rot3_mem_sphere hw0
  have hw3 : hexStep p (rot3 p (p + 1)) ∈ Metric.sphere p 1 := hexStep_mem_sphere hw2
  have hw4 : rot3 p (rot3 p (p + 1)) ∈ Metric.sphere p 1 := rot3_mem_sphere hw2
  set S : Set ℂ := Metric.sphere p 1 ∪ Metric.sphere p (Real.sqrt 3 / 3) with hSdef
  have hins : S ⊆ insert p S := Set.subset_insert p S
  have mp : p ∈ insert p S := Set.mem_insert p S
  have m0 : (p + 1) ∈ insert p S := hins (Or.inl hw0)
  have m1 : hexStep p (p + 1) ∈ insert p S := hins (Or.inl hw1)
  have m2 : rot3 p (p + 1) ∈ insert p S := hins (Or.inl hw2)
  have m3 : hexStep p (rot3 p (p + 1)) ∈ insert p S := hins (Or.inl hw3)
  have m4 : rot3 p (rot3 p (p + 1)) ∈ insert p S := hins (Or.inl hw4)
  -- every outer point refuses the centre's colour
  have adjp : ∀ (w : ℂ) (hw : w ∈ Metric.sphere p 1) (m : w ∈ insert p S),
      C ⟨w, m⟩ ≠ C ⟨p, mp⟩ := fun w hw m =>
    C.valid ((unitDistance_adj (V := ℂ)).mpr
      (by show dist w p = 1; exact hw))
  have a0 := adjp _ hw0 m0
  have a1 := adjp _ hw1 m1
  have a2 := adjp _ hw2 m2
  have a3 := adjp _ hw3 m3
  have a4 := adjp _ hw4 m4
  -- consecutive 60° chords
  have b0 : C ⟨p + 1, m0⟩ ≠ C ⟨hexStep p (p + 1), m1⟩ :=
    C.valid ((unitDistance_adj (V := ℂ)).mpr (dist_self_hexStep hw0))
  have b1 : C ⟨hexStep p (p + 1), m1⟩ ≠ C ⟨rot3 p (p + 1), m2⟩ :=
    C.valid ((unitDistance_adj (V := ℂ)).mpr
      (by show dist (hexStep p (p + 1)) (rot3 p (p + 1)) = 1
          rw [← hexStep_hexStep]
          exact dist_self_hexStep hw1))
  have b2 : C ⟨rot3 p (p + 1), m2⟩ ≠ C ⟨hexStep p (rot3 p (p + 1)), m3⟩ :=
    C.valid ((unitDistance_adj (V := ℂ)).mpr (dist_self_hexStep hw2))
  have b3 : C ⟨hexStep p (rot3 p (p + 1)), m3⟩ ≠ C ⟨rot3 p (rot3 p (p + 1)), m4⟩ :=
    C.valid ((unitDistance_adj (V := ℂ)).mpr
      (by show dist (hexStep p (rot3 p (p + 1))) (rot3 p (rot3 p (p + 1))) = 1
          rw [← hexStep_hexStep p (rot3 p (p + 1))]
          exact dist_self_hexStep hw3))
  -- the alternation: with the centre's colour excluded, two steps return
  have step : ∀ cp c0 c1 c2 : Fin 3, c0 ≠ cp → c1 ≠ cp → c2 ≠ cp →
      c1 ≠ c0 → c2 ≠ c1 → c2 = c0 := by decide
  have e02 : C ⟨rot3 p (p + 1), m2⟩ = C ⟨p + 1, m0⟩ :=
    step _ _ _ _ a0 a1 a2 b0.symm b1.symm
  have e24 : C ⟨rot3 p (rot3 p (p + 1)), m4⟩ = C ⟨rot3 p (p + 1), m2⟩ :=
    step _ _ _ _ a2 a3 a4 b2.symm b3.symm
  -- the 120°-triple {w0, w2, w4} is monochromatic: the compulsion refuses
  exact no_mono_outer_triple (D := insert p S) p hins C hw0 ⟨e02, e24.trans e02⟩

/-- **The cap, upper half.** Four colours always suffice: M19's 3-colouring of the
circles, plus a fresh colour on the centre alone. -/
theorem concentric_colorable_four (p : ℂ) :
    ((unitDistance ℂ).induce
        (insert p (Metric.sphere p 1 ∪ Metric.sphere p (Real.sqrt 3 / 3)))).Colorable 4 := by
  obtain ⟨C3⟩ := TwoCircle.colorable_three_induce p
  classical
  refine ⟨SimpleGraph.Coloring.mk
    (fun v => if h : (v : ℂ) = p then (3 : Fin 4)
      else (C3 ⟨v, (Set.mem_insert_iff.mp v.2).resolve_left h⟩).castSucc) ?_⟩
  intro a b hab
  have hd : dist (a : ℂ) (b : ℂ) = 1 := unitDistance_adj.mp hab
  have hne : (a : ℂ) ≠ (b : ℂ) := by
    intro h
    rw [h] at hd
    simp at hd
  by_cases ha : (a : ℂ) = p <;> by_cases hb : (b : ℂ) = p
  · exact absurd (ha.trans hb.symm) hne
  · simp only [dif_pos ha, dif_neg hb]
    intro h
    exact absurd h.symm (Fin.ne_of_lt (Fin.castSucc_lt_last _))
  · simp only [dif_neg ha, dif_pos hb]
    exact Fin.ne_of_lt (Fin.castSucc_lt_last _)
  · simp only [dif_neg ha, dif_neg hb]
    intro h
    exact C3.valid ((unitDistance_adj (V := ℂ)).mpr hd)
      (Fin.castSucc_injective _ h)

/-- **The one-pivot cap, headline form**: the centre plus its two circles — the whole
uncountable system — has chromatic number exactly four. Read against Mathlib's
`chromaticNumber`; the two `Colorable` halves above carry the content. -/
theorem chromaticNumber_concentric (p : ℂ) :
    ((unitDistance ℂ).induce
        (insert p (Metric.sphere p 1 ∪ Metric.sphere p (Real.sqrt 3 / 3)))).chromaticNumber
      = 4 := by
  apply le_antisymm
  · exact (concentric_colorable_four p).chromaticNumber_le
  · by_contra h
    have h3 : ((unitDistance ℂ).induce
        (insert p (Metric.sphere p 1 ∪ Metric.sphere p (Real.sqrt 3 / 3)))).chromaticNumber
        ≤ 3 := by
      have := lt_of_not_ge h
      exact Order.le_of_lt_add_one (by exact_mod_cast this)
    exact concentric_not_colorable_three p
      (SimpleGraph.chromaticNumber_le_iff_colorable.mp h3)

end Compulsion
end HadwigerNelson
