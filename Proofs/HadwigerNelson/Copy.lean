import Proofs.HadwigerNelson.Quadrature
import Proofs.HadwigerNelson.FieldWall
import Proofs.HadwigerNelson.DistanceGraph

/-! # The copy construction — the spindle rotation and its self-chord law

M52's kernel piece (`plans/M52-copy-lock-objects.md` §8, reshaped in §Bʹ/§Bʺ): the geometry of
"duplicate the object and rotate the copy", stated once for every pair distance.

* `spindleRot d` is THE rotation whose angle `θ` satisfies `sin (θ/2) = 1/(2d)` — the rotation that
  moves a point at distance `d` from the centre by exactly one unit — written by its cosine and sine
  (`cos θ = 1 − 1/(2d²)`, `sin θ = √(4d² − 1)/(2d²)`). Kooshi's derived-angle table
  (`plans/STANDING-QUESTIONS.md` Q8) is this one term: at `d = √3` it is the Moser twist, at `d = 2`
  it is de Grey's `ρ₁₅`, at `d = 5` the Exoo–Ismailescu pair's own spindle with real part `49/50`.
* `rotAbout c ρ` is rotation about `c` by a unit complex `ρ`, kept as a plain affine map with
  unit-ness a per-use hypothesis (the repository's convention for `moserTwist` and `rho15`;
  Mathlib's `Circle`/`rotation` is the neighbour and costs every consumer a coercion).
* The **self-chord law** `dist z (rotAbout c ρ z) = ‖1 − ρ‖ · dist z c` needs no hypothesis at all,
  and for the `d`-spindle `‖1 − spindleRot d‖ = 1/d`, so a copy point sits at unit distance from
  its original exactly on the radius-`d` circle about the centre (`self_chord_iff`) — the measured
  shell of self-chords about vertex 206 in the copy-lock objects.
* The **copy union** is not a new graph: it is the unit-distance graph of the plane pulled back
  along the two-sided drawing `Sum.elim q (rotAbout c ρ ∘ q)`, so every unit pair — both sides'
  edges and every cross chord — is an edge by definition, and the construction's content is two
  containments (`G` embeds on each side) and the self-chord characterization.

The hypothesis `1/2 ≤ d` is exact: below it the radicand `4d² − 1` is negative, `Real.sqrt` returns
`0`, and `spindleRot (1/4)` has `normSq = 49` (the red example). All on the standard three axioms;
the 5-chromaticity of any particular union is a certificate, not a lemma here (M52 D6). -/

namespace HadwigerNelson
namespace Copy

open Complex

/-- Rotation of the plane about `c` by the complex number `ρ` (an isometry when `‖ρ‖ = 1`). -/
noncomputable def rotAbout (c ρ z : ℂ) : ℂ := c + ρ * (z - c)

-- NAMING, against the literature (2026-09-09, FS-23; a `--` comment, so no dependent rebuilds).
-- The Polymath16 wiki and Heule index this rotation by the SQUARED distance, not the distance:
-- their `ω_t = θ_t = exp (i · arccos (1 − 1/(2t)))` is our `spindleRot (√t)`.  So their `ω₃` is the
-- Moser twist `spindleRot √3`, their `ω₄` is `spindleRot 2 = rho15`, and their `ω_{64/9}` — the
-- rotation `(119 + 3i√247)/128` that spindles the monochromatic `8/3` pair — is `spindleRot (8/3)`.
-- State the convention whenever quoting a value across the boundary.
/-- The spindle rotation for a pair distance `d`: `sin (θ/2) = 1/(2d)`, written as
`(cos θ, sin θ) = (1 − 1/(2d²), √(4d² − 1)/(2d²))`. -/
noncomputable def spindleRot (d : ℝ) : ℂ :=
  ⟨1 - 1 / (2 * d ^ 2), Real.sqrt (4 * d ^ 2 - 1) / (2 * d ^ 2)⟩

/-! ## §1 The instances (spec examples that fail on drift) -/

/-- `d = 2` is de Grey's detune `ρ₁₅ = (7 + i√15)/8`. -/
theorem spindleRot_two : spindleRot 2 = Quadrature.rho15 := by
  apply Complex.ext <;> simp only [spindleRot, Quadrature.rho15] <;> norm_num

/-- `d = √3` is the Moser twist `(5 + i√11)/6`. -/
theorem spindleRot_sqrt3 : spindleRot (Real.sqrt 3) = FieldWall.moserTwist := by
  have h3 : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  apply Complex.ext <;> simp only [spindleRot, FieldWall.moserTwist, h3] <;> norm_num

/-- The Exoo–Ismailescu forced pair sits at distance 5; its spindle has real part `49/50`
(and `4·25 − 1 = 99 = 9·11`: the angle lives in `ℚ(√11)`, the seed's own field). -/
example : (spindleRot 5).re = 49 / 50 := by norm_num [spindleRot]

example : (spindleRot 5).im ^ 2 = 99 / 2500 := by
  simp only [spindleRot]
  rw [div_pow, Real.sq_sqrt (by norm_num)]
  norm_num

/-! ## §2 Unit-ness and the length of `1 − ρ` -/

/-- For a unit complex, `‖1 − ρ‖² = 2 − 2 Re ρ` — the chord length of the rotation angle. -/
theorem normSq_one_sub {ρ : ℂ} (h : normSq ρ = 1) : normSq (1 - ρ) = 2 - 2 * ρ.re := by
  rw [normSq_apply] at h ⊢
  simp only [sub_re, sub_im, one_re, one_im, zero_sub, neg_mul]
  linear_combination h

/-- The spindle rotation is a unit complex — exactly when the radicand is nonnegative. -/
theorem normSq_spindleRot {d : ℝ} (hd : 1 / 2 ≤ d) : normSq (spindleRot d) = 1 := by
  have hd0 : d ≠ 0 := by intro h; rw [h] at hd; norm_num at hd
  have hr : 0 ≤ 4 * d ^ 2 - 1 := by nlinarith
  simp only [normSq_mk, spindleRot]
  rw [div_mul_div_comm, Real.mul_self_sqrt hr]
  field_simp
  ring

/-- **The red control for the hypothesis**: at `d = 1/4` the radicand is `−3/4`, `Real.sqrt` gives
`0`, and the "rotation" has squared modulus `49`. `1/2 ≤ d` is not decoration. -/
example : normSq (spindleRot (1 / 4)) = 49 := by
  have h : Real.sqrt (4 * (1 / 4 : ℝ) ^ 2 - 1) = 0 := Real.sqrt_eq_zero'.mpr (by norm_num)
  simp only [normSq_mk, spindleRot, h]
  norm_num

/-- `‖1 − spindleRot d‖² = 1/d²`: the self-chord factor squared. -/
theorem normSq_one_sub_spindleRot {d : ℝ} (hd : 1 / 2 ≤ d) :
    normSq (1 - spindleRot d) = 1 / d ^ 2 := by
  have hd0 : d ≠ 0 := by intro h; rw [h] at hd; norm_num at hd
  rw [normSq_one_sub (normSq_spindleRot hd)]
  show 2 - 2 * (1 - 1 / (2 * d ^ 2)) = 1 / d ^ 2
  field_simp
  ring

/-- From a squared modulus to a modulus, for a nonnegative root. -/
theorem norm_of_normSq {ρ : ℂ} {r : ℝ} (h : normSq ρ = r ^ 2) (hr : 0 ≤ r) : ‖ρ‖ = r := by
  have h2 : ‖ρ‖ ^ 2 = r ^ 2 := by rw [← Complex.normSq_eq_norm_sq]; exact h
  exact (pow_left_inj₀ (norm_nonneg _) hr two_ne_zero).mp h2

theorem norm_one_sub_spindleRot {d : ℝ} (hd : 1 / 2 ≤ d) : ‖1 - spindleRot d‖ = 1 / d :=
  norm_of_normSq (by rw [normSq_one_sub_spindleRot hd]; ring)
    (div_nonneg zero_le_one (by linarith))

/-! ## §3 The rotation's metric geometry -/

/-- **The self-chord law**, hypothesis-free: `z − rotAbout c ρ z = (1 − ρ)(z − c)`. -/
theorem dist_self_rotAbout (c ρ z : ℂ) : dist z (rotAbout c ρ z) = ‖1 - ρ‖ * dist z c := by
  rw [Complex.dist_eq, Complex.dist_eq, ← norm_mul]
  congr 1
  simp only [rotAbout]
  ring

/-- A rotation by a unit complex preserves distances. -/
theorem dist_rotAbout {ρ : ℂ} (hρ : normSq ρ = 1) (c z w : ℂ) :
    dist (rotAbout c ρ z) (rotAbout c ρ w) = dist z w := by
  have h1 : ‖ρ‖ = 1 := norm_of_normSq (by rw [hρ]; ring) zero_le_one
  rw [Complex.dist_eq, Complex.dist_eq,
    show rotAbout c ρ z - rotAbout c ρ w = ρ * (z - w) by simp only [rotAbout]; ring,
    norm_mul, h1, one_mul]

/-- **The red control for unit-ness**: `ρ = 2` doubles distances. -/
example : dist (rotAbout 0 2 1) (rotAbout 0 2 0) = 2 := by
  norm_num [rotAbout, Complex.dist_eq]

theorem isometry_rotAbout {ρ : ℂ} (hρ : normSq ρ = 1) (c : ℂ) : Isometry (rotAbout c ρ) :=
  Isometry.of_dist_eq (dist_rotAbout hρ c)

/-- **Self-chords lie exactly on the radius-`d` circle**: a copy point is at unit distance from its
original iff the original is at distance `d` from the centre. -/
theorem self_chord_iff {d : ℝ} (hd : 1 / 2 ≤ d) (c z : ℂ) :
    dist z (rotAbout c (spindleRot d) z) = 1 ↔ dist z c = d := by
  have hd0 : d ≠ 0 := by intro h; rw [h] at hd; norm_num at hd
  rw [dist_self_rotAbout, norm_one_sub_spindleRot hd]
  constructor
  · intro h
    field_simp at h
    linarith
  · intro h
    rw [h]
    field_simp

/-! ## §4 The copy union as a pulled-back unit-distance graph -/

/-- The two-sided drawing: the original on the left, its rotated copy on the right. -/
noncomputable def copyDrawing {ι : Type*} (q : ι → ℂ) (c ρ : ℂ) : ι ⊕ ι → ℂ :=
  Sum.elim q (rotAbout c ρ ∘ q)

/-- The copy union: every pair of drawn points at unit distance is an edge — both sides' edges
and every cross chord. Not a new definition, a `comap`. -/
noncomputable def copyUnion {ι : Type*} (q : ι → ℂ) (c ρ : ℂ) : SimpleGraph (ι ⊕ ι) :=
  (unitDistance ℂ).comap (copyDrawing q c ρ)

/-- The original embeds on the left whenever `q` draws it with unit edges. -/
theorem le_copyUnion_comap_inl {ι : Type*} {G : SimpleGraph ι} {q : ι → ℂ}
    (hq : ∀ u v, G.Adj u v → dist (q u) (q v) = 1) (c ρ : ℂ) :
    G ≤ (copyUnion q c ρ).comap Sum.inl := by
  intro u v huv
  simp only [SimpleGraph.comap_adj, copyUnion, copyDrawing, Sum.elim_inl, unitDistance_adj]
  exact hq u v huv

/-- The original embeds on the right too, because the rotation is an isometry. -/
theorem le_copyUnion_comap_inr {ι : Type*} {G : SimpleGraph ι} {q : ι → ℂ}
    (hq : ∀ u v, G.Adj u v → dist (q u) (q v) = 1) {ρ : ℂ} (hρ : normSq ρ = 1) (c : ℂ) :
    G ≤ (copyUnion q c ρ).comap Sum.inr := by
  intro u v huv
  simp only [SimpleGraph.comap_adj, copyUnion, copyDrawing, Sum.elim_inr, Function.comp_apply,
    unitDistance_adj, dist_rotAbout hρ]
  exact hq u v huv

/-- **The self-chord adjacency**: a point and its own copy are adjacent in the union exactly when
the point lies on the radius-`d` circle about the centre. -/
theorem copyUnion_adj_inl_inr {ι : Type*} (q : ι → ℂ) {d : ℝ} (hd : 1 / 2 ≤ d) (c : ℂ) (z : ι) :
    (copyUnion q c (spindleRot d)).Adj (Sum.inl z) (Sum.inr z) ↔ dist (q z) c = d := by
  simp only [copyUnion, SimpleGraph.comap_adj, copyDrawing, Sum.elim_inl, Sum.elim_inr,
    Function.comp_apply, unitDistance_adj]
  exact self_chord_iff hd c (q z)

/-- The drawing is a homomorphism into the plane's unit-distance graph, by definition of `comap`. -/
noncomputable def copyUnionHom {ι : Type*} (q : ι → ℂ) (c ρ : ℂ) : copyUnion q c ρ →g unitDistance ℂ where
  toFun := copyDrawing q c ρ
  map_rel' := fun h => h

/-- The union is drawn in the plane, so its chromatic number bounds the plane's from below. -/
theorem chromaticNumber_copyUnion_le {ι : Type*} (q : ι → ℂ) (c ρ : ℂ) :
    (copyUnion q c ρ).chromaticNumber ≤ (unitDistance ℂ).chromaticNumber :=
  SimpleGraph.chromaticNumber_mono_of_hom (copyUnionHom q c ρ)

end Copy
end HadwigerNelson
