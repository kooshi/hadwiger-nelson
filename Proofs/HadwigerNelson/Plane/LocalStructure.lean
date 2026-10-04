import Proofs.HadwigerNelson.Plane.LocalMap
import Proofs.HadwigerNelson.Plane.Chord
import Mathlib.LinearAlgebra.Complex.FiniteDimensional
import Mathlib.Geometry.Euclidean.Basic

/-!
# The local structure of an arc map at a point: finitely many tiles, the germ dichotomy, interval cones

Wave 3's supporting lemmas (`plans/FS131-w3-kernel-plan.md` § "For stage 3" and stage 3; inventory ruling 27: wave 3 takes
these forward from wave 4's foundation). Pure topology of `ArcMap`: no validity, no colour count.

* **Angular intervals.** `angleIcc a b` and `angleIoo a b` are the closed and open intervals `[a, b]`, `(a, b)` of angles,
  repeated with period `2π` — the rows' cones "`[θ₂ − 90°, θ₁ + 90°]`" read on the circle. Empty when `b < a` (resp.
  `b ≤ a`); the whole line when `b − a ≥ 2π`.
* **The disc of radius above 1.** `covers_one_iff`: a fragment covers `B̄(p, 1)` exactly when it covers a closed disc of
  radius above `1` about `p` (the domain is open and the disc compact) — so every row's "on a closed disc of radius above
  1 about `p`" is stated as `F.Covers p 1`.
* **Arcs against a unit circle.** `Arc.finite_inter_sphere_or_eq_circ`: a nondegenerate arc meets `ω(p)` in finitely many
  points or is an arc of `ω(p)` itself; `finite_ringΓ_off_ringArc`: on a covered ring, the points of `Γ` that lie on no arc
  of `Γ` on `ω(p)` are finitely many.
* **Interior points are dense** (`dense_interiorPts`): `Γ` is a locally finite union of arcs, so it has empty interior;
  every point of the domain carries a colour (`exists_mem_coloursAt`).
* **Finitely many tiles near a point** (`finite_tiles_near`, the wave's hardest leaf) and its consequences: the colours at
  a point are the colours of the tiles whose closure holds it (`mem_coloursAt_iff_exists_tileOf`), the cone of a colour
  class is the union of its tiles' cones (`coneAt_region_eq_biUnion`), every direction lies in some colour's cone
  (`exists_mem_coneAt_region`).
* **The germ dichotomy** (`germ_dichotomy`): at a ring point in the domain, a germ lies in one colour class, or on an arc of
  `Γ` on `ω(p)` with constant sides.
* **Interval cones in a simple map** (`Simple.coneAt_eq_angleIcc`): each tile's cone at a point of its closure is one closed
  angular interval.

Every leaf is `sorry` until wave 3's implementer lands it (`plans/FS131-w3-kernel-plan.md` § the leaf plans).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## Angular intervals -/

/-- Normalising is `2/‖u‖`-Lipschitz at `u`: `‖w/‖w‖ − u/‖u‖‖ ≤ 2‖w − u‖/‖u‖`. -/
theorem norm_div_norm_sub_le {u w : ℂ} (hu : u ≠ 0) (hw : w ≠ 0) :
    ‖w / (‖w‖ : ℂ) - u / (‖u‖ : ℂ)‖ ≤ 2 * ‖w - u‖ / ‖u‖ := by
  set a := ‖u‖ with ha
  set b := ‖w‖ with hb
  have ha0 : 0 < a := norm_pos_iff.mpr hu
  have hb0 : 0 < b := norm_pos_iff.mpr hw
  have hac : (a : ℂ) ≠ 0 := by exact_mod_cast ha0.ne'
  have hbc : (b : ℂ) ≠ 0 := by exact_mod_cast hb0.ne'
  have key : w / (b : ℂ) - u / (a : ℂ) = (w - u) / (a : ℂ) + w * (((a - b) / (a * b) : ℝ) : ℂ) := by
    push_cast; field_simp; ring
  rw [key]
  refine (norm_add_le _ _).trans ?_
  have h1 : ‖(w - u) / (a : ℂ)‖ = ‖w - u‖ / a := by
    rw [norm_div, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ha0]
  have h2 : ‖w * (((a - b) / (a * b) : ℝ) : ℂ)‖ = |a - b| / a := by
    rw [norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_div, abs_of_pos (mul_pos ha0 hb0), ← hb]
    field_simp
  have h3 : |a - b| ≤ ‖w - u‖ := by
    rw [abs_sub_comm]; exact abs_norm_sub_norm_le w u
  rw [h1, h2]
  have : |a - b| / a ≤ ‖w - u‖ / a := div_le_div_of_nonneg_right h3 ha0.le
  have e : 2 * ‖w - u‖ / a = ‖w - u‖ / a + ‖w - u‖ / a := by ring
  rw [e]; linarith

/-- The closed angular interval `[a, b]`, repeated with period `2π`. -/
def angleIcc (a b : ℝ) : Set ℝ := ⋃ m : ℤ, Icc (a + 2 * π * m) (b + 2 * π * m)

/-- The open angular interval `(a, b)`, repeated with period `2π`. -/
def angleIoo (a b : ℝ) : Set ℝ := ⋃ m : ℤ, Ioo (a + 2 * π * m) (b + 2 * π * m)

/-- `[a, b]` lies in its angular interval. -/
theorem Icc_subset_angleIcc (a b : ℝ) : Icc a b ⊆ angleIcc a b := fun x hx =>
  mem_iUnion.mpr ⟨0, by simpa using hx⟩

/-- `(a, b)` lies in its angular interval. -/
theorem Ioo_subset_angleIoo (a b : ℝ) : Ioo a b ⊆ angleIoo a b := fun x hx =>
  mem_iUnion.mpr ⟨0, by simpa using hx⟩

/-- Spec example: `2π + π/2` lies in the angular interval `[0, π]`. -/
example : 2 * π + π / 2 ∈ angleIcc 0 π := by
  refine mem_iUnion.mpr ⟨1, ?_⟩
  constructor <;> push_cast <;> linarith [Real.pi_pos]

/-- **Adversary**: `−π/2` does not lie in the angular interval `(0, π)`. -/
example : -(π / 2) ∉ angleIoo 0 π := by
  intro h
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp h
  have hπ := Real.pi_pos
  rcases lt_or_ge m 0 with hm | hm
  · have : (m : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_iff.mpr hm
    nlinarith
  · have : (0 : ℝ) ≤ m := by exact_mod_cast hm
    nlinarith

/-! ## Arcs against a unit circle -/

/-- A nondegenerate arc meets the unit circle `ω(p)` in finitely many points, unless it is an arc of `ω(p)` itself (a
line or a different circle meets `ω(p)` in at most two points). -/
theorem Arc.finite_inter_sphere_or_eq_circ (a : Arc) (ha : a.Nondegenerate) (p : ℂ) :
    (a.carrier ∩ sphere p 1).Finite ∨ ∃ θ₀ θ₁, a = .circ p 1 θ₀ θ₁ := by
  cases a with
  | seg a b =>
    left
    have hab : b - a ≠ 0 := sub_ne_zero.mpr (Ne.symm ha)
    set A : ℝ := ‖b - a‖ ^ 2
    set B : ℝ := 2 * ((a - p) * (starRingEnd ℂ) (b - a)).re
    set C : ℝ := ‖a - p‖ ^ 2 - 1
    have hA : A ≠ 0 := by positivity
    let q : Polynomial ℝ := Polynomial.C A * Polynomial.X ^ 2 + Polynomial.C B * Polynomial.X + Polynomial.C C
    have hq : q ≠ 0 := by
      intro h
      have := congrArg (fun r => Polynomial.coeff r 2) h
      simp [q, Polynomial.coeff_X_pow] at this
      exact hA this
    refine ((Polynomial.finite_setOf_isRoot hq).image (fun t : ℝ => a + (t : ℂ) * (b - a))).subset ?_
    rintro z ⟨hz, hzs⟩
    rw [Arc.carrier, segment_eq_image'] at hz
    obtain ⟨t, -, rfl⟩ := hz
    refine ⟨t, ?_, by simp [Complex.real_smul]⟩
    simp only [mem_sphere, dist_eq_norm] at hzs
    have h2 : ‖a + (t : ℂ) * (b - a) - p‖ ^ 2 = 1 := by
      simp only [Complex.real_smul] at hzs
      rw [hzs]; norm_num
    have h3 : ‖a - p + (t : ℂ) * (b - a)‖ ^ 2 = A * t ^ 2 + B * t + (C + 1) := by
      rw [Complex.sq_norm, Complex.normSq_apply]
      simp only [A, B, C, Complex.sq_norm, Complex.normSq_apply, Complex.add_re, Complex.add_im,
        Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, Complex.sub_re,
        Complex.sub_im, Complex.conj_re, Complex.conj_im]
      ring
    have h4 : a - p + (t : ℂ) * (b - a) = a + (t : ℂ) * (b - a) - p := by ring
    rw [h4, h2] at h3
    simp only [q, Set.mem_setOf_eq, Polynomial.IsRoot, Polynomial.eval_add, Polynomial.eval_mul,
      Polynomial.eval_C, Polynomial.eval_pow, Polynomial.eval_X]
    linarith
  | circ c ρ θ₀ θ₁ =>
    by_cases hcp : c = p
    · subst hcp
      by_cases hρ : ρ = 1
      · right; subst hρ; exact ⟨θ₀, θ₁, rfl⟩
      · left
        have : (Arc.circ c ρ θ₀ θ₁).carrier ∩ sphere c 1 = ∅ := by
          refine eq_empty_of_forall_notMem ?_
          rintro z ⟨⟨θ, -, rfl⟩, hz⟩
          simp only [mem_sphere, dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one,
            Complex.norm_real] at hz
          have hρ0 : 0 < ρ := ha.1
          rw [Real.norm_eq_abs, abs_of_pos hρ0] at hz
          exact hρ hz
        rw [this]; exact finite_empty
    · left
      have hsub : (Arc.circ c ρ θ₀ θ₁).carrier ∩ sphere p 1 ⊆ sphere c ρ ∩ sphere p 1 := by
        rintro z ⟨⟨θ, -, rfl⟩, hz⟩
        refine ⟨?_, hz⟩
        have hρ0 : 0 < ρ := ha.1
        simp [norm_e, abs_of_pos hρ0]
      refine Set.Finite.subset ?_ hsub
      by_cases hsub1 : (sphere c ρ ∩ sphere p 1 : Set ℂ).Subsingleton
      · exact hsub1.finite
      · obtain ⟨x, hx, y, hy, hxy⟩ := Set.not_subsingleton_iff.mp hsub1
        refine (Set.toFinite {x, y}).subset ?_
        intro z hz
        have := EuclideanGeometry.eq_of_dist_eq_of_dist_eq_of_finrank_eq_two
          (V := ℂ) (P := ℂ) Complex.finrank_real_complex hcp hxy hx.1 hy.1 hz.1 hx.2 hy.2 hz.2
        simpa using this

/-- A segment is a Lebesgue-null set of the plane (it lies in a proper affine subspace). -/
theorem volume_segment_eq_zero (a b : ℂ) : MeasureTheory.volume (segment ℝ a b) = 0 := by
  let s : AffineSubspace ℝ ℂ := AffineSubspace.mk' a (Submodule.span ℝ {b - a})
  have hsub : segment ℝ a b ⊆ (s : Set ℂ) := by
    rintro z ⟨u, v, hu, hv, huv, rfl⟩
    rw [SetLike.mem_coe, AffineSubspace.mem_mk']
    refine Submodule.mem_span_singleton.mpr ⟨v, ?_⟩
    have : u = 1 - v := by linarith
    subst this
    simp only [vsub_eq_sub, Complex.real_smul]
    push_cast; ring
  refine MeasureTheory.measure_mono_null hsub (MeasureTheory.Measure.addHaar_affineSubspace _ _ ?_)
  intro h
  have h1 : s.direction = ⊤ := by rw [h]; exact AffineSubspace.direction_top _ _ _
  rw [AffineSubspace.direction_mk'] at h1
  have h2 := finrank_span_le_card (R := ℝ) ({b - a} : Set ℂ)
  rw [h1, finrank_top, Complex.finrank_real_complex] at h2
  simp at h2

/-- The points of an arc form a Lebesgue-null set. -/
theorem Arc.volume_carrier (a : Arc) : MeasureTheory.volume a.carrier = 0 := by
  cases a with
  | seg a b => exact volume_segment_eq_zero a b
  | circ c ρ θ₀ θ₁ =>
    refine MeasureTheory.measure_mono_null (t := sphere c |ρ|) ?_
      (MeasureTheory.Measure.addHaar_sphere _ _ _)
    rintro _ ⟨θ, -, rfl⟩
    simp [norm_e]

/-- The carrier of the arc `circ p 1 θ₀ θ₁` is the closed sub-arc `r([θ₀, θ₁])` of `ω(p)`. -/
theorem carrier_circ_unit (p : ℂ) (θ₀ θ₁ : ℝ) : (Arc.circ p 1 θ₀ θ₁).carrier = ringArc p θ₀ θ₁ := by
  simp [Arc.carrier, ringArc, ringPt]

/-- `a` is an arc of the unit circle `ω(p)`. -/
def Arc.OnRing (p : ℂ) (a : Arc) : Prop := ∃ θ₀ θ₁, a = .circ p 1 θ₀ θ₁

/-- An arc on `ω(p)` has its carrier on `ω(p)`. -/
theorem Arc.OnRing.carrier_subset_sphere {p : ℂ} {a : Arc} (h : a.OnRing p) : a.carrier ⊆ sphere p 1 := by
  obtain ⟨θ₀, θ₁, rfl⟩ := h
  rw [carrier_circ_unit]
  rintro _ ⟨θ, -, rfl⟩
  exact ringPt_mem_sphere p θ

/-- The polar point `p + ρ e(ψ)`. -/
noncomputable def polarPt (p : ℂ) (ρ ψ : ℝ) : ℂ := p + (ρ : ℂ) * e ψ

/-- The polar map is continuous. -/
theorem continuous_polarPt (p : ℂ) : Continuous (fun q : ℝ × ℝ => polarPt p q.1 q.2) := by
  unfold polarPt e; fun_prop

/-- The distance from the centre of a polar point is `|ρ|`. -/
theorem norm_polarPt_sub (p : ℂ) (ρ ψ : ℝ) : ‖polarPt p ρ ψ - p‖ = |ρ| := by
  simp [polarPt]

/-- A polar point at radius within `ε` of `1` and angle within `κ` of `φ` is within `ε + κ` of `r(φ)`. -/
theorem dist_polarPt_ringPt_le (p : ℂ) (ρ ψ φ : ℝ) :
    dist (polarPt p ρ ψ) (ringPt p φ) ≤ |ρ - 1| + |ψ - φ| := by
  have h1 : polarPt p ρ ψ - ringPt p φ = ((ρ - 1 : ℝ) : ℂ) * e ψ + (e ψ - e φ) := by
    simp only [polarPt, ringPt]; push_cast; ring
  rw [dist_eq_norm, h1]
  refine (norm_add_le _ _).trans ?_
  rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs]
  linarith [norm_e_sub_e_le ψ φ]

/-- `|‖z − p‖ − 1| ≤ dist z r(φ)`. -/
theorem abs_norm_sub_one_le (p z : ℂ) (φ : ℝ) : |‖z - p‖ - 1| ≤ dist z (ringPt p φ) := by
  have := abs_norm_sub_norm_le (z - p) (e φ)
  rw [norm_e, show z - p - e φ = z - ringPt p φ by simp only [ringPt]; ring] at this
  exact this.trans (dist_eq_norm _ _).symm.le

/-- **Polar neighbourhoods**: every point `z` near `r(φ)` is `p + ρ e(ψ)` with `ρ = ‖z − p‖` near `1` and `ψ` in a given open
interval about `φ`. -/
theorem polar_nbhd (p : ℂ) {φ α β : ℝ} (h : φ ∈ Ioo α β) :
    ∃ ν > 0, ∀ z : ℂ, dist z (ringPt p φ) < ν →
      |‖z - p‖ - 1| < ν ∧ ∃ ψ ∈ Ioo α β, z = polarPt p ‖z - p‖ ψ := by
  have hc : ContinuousAt Complex.arg (1 : ℂ) :=
    Complex.continuousAt_arg (by simp [Complex.mem_slitPlane_iff])
  obtain ⟨ν', hν', harg⟩ := Metric.continuousAt_iff.mp hc (min (φ - α) (β - φ))
    (lt_min (by linarith [h.1]) (by linarith [h.2]))
  refine ⟨ν', hν', fun z hz => ⟨?_, ?_⟩⟩
  · exact lt_of_le_of_lt (abs_norm_sub_one_le p z φ) hz
  · set w : ℂ := (z - p) * (starRingEnd ℂ) (e φ) with hw
    have hconj : e φ * (starRingEnd ℂ) (e φ) = 1 := e_mul_conj_e φ
    have hdw : dist w 1 < ν' := by
      have : w - 1 = (z - ringPt p φ) * (starRingEnd ℂ) (e φ) := by
        rw [hw]; simp only [ringPt]
        linear_combination hconj
      rw [dist_eq_norm, this, norm_mul, Complex.norm_conj, norm_e, mul_one, ← dist_eq_norm]
      exact hz
    have ha := harg hdw
    rw [Complex.arg_one, Real.dist_eq, sub_zero] at ha
    have hlt := lt_of_lt_of_le ha (min_le_left _ _)
    have hlt' := lt_of_lt_of_le ha (min_le_right _ _)
    rw [abs_lt] at hlt hlt'
    refine ⟨φ + Complex.arg w, ⟨by linarith [hlt.1], by linarith [hlt'.2]⟩, ?_⟩
    have hwn : ‖w‖ = ‖z - p‖ := by rw [hw, norm_mul, Complex.norm_conj, norm_e, mul_one]
    have h3 := Complex.norm_mul_exp_arg_mul_I w
    have h4 : z - p = w * e φ := by rw [hw, mul_assoc, mul_comm (starRingEnd ℂ (e φ)), hconj, mul_one]
    unfold polarPt
    rw [← hwn, e_add, show ((‖w‖ : ℝ) : ℂ) * (e φ * e (Complex.arg w)) = ((‖w‖ : ℂ) * e (Complex.arg w)) * e φ by ring]
    have h5 : ((‖w‖ : ℝ) : ℂ) * e (Complex.arg w) = w := by rw [e]; exact h3
    rw [h5, ← h4]; ring

/-- `e a = e b` exactly when `a − b` is an integer multiple of `2π`. -/
theorem e_eq_e_iff {a b : ℝ} : e a = e b ↔ ∃ n : ℤ, a = b + n * (2 * π) := by
  rw [e, e, Complex.exp_eq_exp_iff_exists_int]
  constructor
  · rintro ⟨n, hn⟩
    refine ⟨n, ?_⟩
    have := congrArg Complex.im hn
    simpa using this
  · rintro ⟨n, hn⟩
    exact ⟨n, by rw [hn]; push_cast; ring⟩

/-- Every angle is congruent mod `2π` to one in `[θ₀, θ₀ + 2π]`. -/
theorem exists_mem_Icc_e_eq (θ₀ x : ℝ) : ∃ ψ ∈ Icc θ₀ (θ₀ + 2 * π), e ψ = e x := by
  have hπ := Real.pi_pos
  refine ⟨x - ⌊(x - θ₀) / (2 * π)⌋ * (2 * π), ⟨?_, ?_⟩, e_eq_e_iff.mpr ⟨-⌊(x - θ₀) / (2 * π)⌋, by push_cast; ring⟩⟩
  · have := Int.floor_le ((x - θ₀) / (2 * π))
    rw [le_div_iff₀ (by positivity)] at this
    linarith
  · have := Int.lt_floor_add_one ((x - θ₀) / (2 * π))
    rw [div_lt_iff₀ (by positivity)] at this
    linarith

/-- `e t ≠ 1` for `0 < |t| < 2π`. -/
theorem e_ne_one {t : ℝ} (h0 : t ≠ 0) (h1 : |t| < 2 * π) : e t ≠ 1 := by
  intro h
  have h' : e t = e 0 := by rw [h]; simp [e]
  obtain ⟨n, hn⟩ := e_eq_e_iff.mp h'
  have hπ := Real.pi_pos
  rw [zero_add] at hn
  rcases lt_trichotomy n 0 with hn0 | hn0 | hn0
  · have : (n : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_iff.mpr hn0
    have : t ≤ -(2 * π) := by rw [hn]; nlinarith
    rw [abs_of_neg (by linarith)] at h1; linarith
  · subst hn0; simp at hn; exact h0 hn
  · have : (1 : ℝ) ≤ n := by exact_mod_cast hn0
    have : 2 * π ≤ t := by rw [hn]; nlinarith
    rw [abs_of_pos (by linarith)] at h1; linarith

/-- A ring point `t ≥ 0` along a side of `r(θ)` is within `t` of it. -/
theorem dist_ringPt_side_le (p : ℂ) (θ : ℝ) (s : Side) {t : ℝ} (ht : 0 ≤ t) :
    dist (ringPt p (θ + s.sign * t)) (ringPt p θ) ≤ t := by
  have h1 := norm_e_sub_e_le (θ + s.sign * t) θ
  have hs : |s.sign| = 1 := by cases s <;> simp [Side.sign]
  rw [dist_eq_norm]
  simp only [ringPt, add_sub_add_left_eq_sub]
  calc _ ≤ |θ + s.sign * t - θ| := h1
    _ = t := by rw [add_sub_cancel_left, abs_mul, hs, one_mul, abs_of_nonneg ht]

/-- A point of the germ of `ω(p)` of length `δ` is within `δ` of the base point. -/
theorem dist_lt_of_mem_germ {p : ℂ} {θ : ℝ} {s : Side} {δ : ℝ} {x : ℂ} (h : x ∈ germ p θ s δ) :
    dist x (ringPt p θ) < δ := by
  obtain ⟨t, ⟨ht0, htδ⟩, rfl⟩ := h
  have h1 := norm_e_sub_e_le (θ + s.sign * t) θ
  have hs : |s.sign| = 1 := by cases s <;> simp [Side.sign]
  rw [dist_eq_norm]
  simp only [ringPt, add_sub_add_left_eq_sub]
  calc _ ≤ |θ + s.sign * t - θ| := h1
    _ = t := by rw [add_sub_cancel_left, abs_mul, hs, one_mul, abs_of_pos ht0]
    _ < δ := htδ

/-- The base point of a germ of length below `2π` is not on it. -/
theorem ringPt_notMem_germ {p : ℂ} {θ : ℝ} {s : Side} {δ : ℝ} (hδ : δ ≤ 2 * π) : ringPt p θ ∉ germ p θ s δ := by
  rintro ⟨t, ⟨ht0, htδ⟩, h⟩
  have hs : |s.sign| = 1 := by cases s <;> simp [Side.sign]
  have h1 : e (s.sign * t) = 1 := by
    have h2 : e (θ + s.sign * t) = e θ := by simpa [ringPt] using h
    rw [e_add] at h2
    have hne : e θ ≠ 0 := fun h0 => by simpa [h0] using norm_e θ
    exact mul_left_cancel₀ hne (by rw [h2, mul_one])
  exact e_ne_one (by cases s <;> simp [Side.sign] <;> exact ht0.ne')
    (by rw [abs_mul, hs, one_mul, abs_of_pos ht0]; linarith) h1

/-- The germ is preconnected. -/
theorem isPreconnected_germ (p : ℂ) (θ : ℝ) (s : Side) (δ : ℝ) : IsPreconnected (germ p θ s δ) :=
  isPreconnected_Ioo.image _ (by unfold ringPt e; fun_prop)

/-- The angles of the closed (open) sub-arc of the germ's side of `θ` of length `δ` are `θ + sign · u` for `u ∈ [0, δ]`
(`(0, δ)`). -/
theorem sideInterval (θ δ : ℝ) (hδ : 0 < δ) (s : Side) :
    θ < θ + δ ∧ (s = .ccw → ∀ φ, (φ ∈ Icc θ (θ + δ) ↔ ∃ u ∈ Icc 0 δ, φ = θ + s.sign * u)) ∧
      (s = .cw → ∀ φ, (φ ∈ Icc (θ - δ) θ ↔ ∃ u ∈ Icc 0 δ, φ = θ + s.sign * u)) := by
  refine ⟨by linarith, ?_, ?_⟩
  · rintro rfl φ
    simp only [Side.sign, one_mul]
    constructor
    · intro h; exact ⟨φ - θ, ⟨by linarith [h.1], by linarith [h.2]⟩, by ring⟩
    · rintro ⟨u, hu, rfl⟩; exact ⟨by linarith [hu.1], by linarith [hu.2]⟩
  · rintro rfl φ
    simp only [Side.sign]
    constructor
    · intro h; exact ⟨θ - φ, ⟨by linarith [h.2], by linarith [h.1]⟩, by ring⟩
    · rintro ⟨u, hu, rfl⟩; exact ⟨by linarith [hu.2], by linarith [hu.1]⟩

/-- **A germ that an arc of `ω(p)` meets arbitrarily close to its base point lies in it** (for short germs): `r(θ)` lies on
the arc `r([θ₀, θ₁])` and every germ of length `δ` meets it. -/
theorem exists_germ_subset_ringArc {p : ℂ} {θ θ₀ θ₁ : ℝ} (hlt : θ₀ < θ₁) (hle : θ₁ ≤ θ₀ + 2 * π) (s : Side)
    (hy : ringPt p θ ∈ ringArc p θ₀ θ₁) (hhit : ∀ δ > 0, (germ p θ s δ ∩ ringArc p θ₀ θ₁).Nonempty)
    {δ₀ : ℝ} (hδ₀ : 0 < δ₀) : ∃ δ' > 0, δ' ≤ δ₀ ∧ germ p θ s δ' ⊆ ringArc p θ₀ θ₁ := by
  have hπ := Real.pi_pos
  have hs : |s.sign| = 1 := by cases s <;> simp [Side.sign]
  by_cases hfull : θ₁ = θ₀ + 2 * π
  · refine ⟨δ₀, hδ₀, le_rfl, ?_⟩
    rintro _ ⟨t, -, rfl⟩
    obtain ⟨ψ, hψ, hψe⟩ := exists_mem_Icc_e_eq θ₀ (θ + s.sign * t)
    exact ⟨ψ, ⟨hψ.1, by rw [hfull]; exact hψ.2⟩, by simp [ringPt, hψe]⟩
  · have hg : 0 < 2 * π - (θ₁ - θ₀) := by
      have : θ₁ < θ₀ + 2 * π := lt_of_le_of_ne hle hfull
      linarith
    set δ' := min δ₀ ((2 * π - (θ₁ - θ₀)) / 2) with hδ'
    have hδ'0 : 0 < δ' := lt_min hδ₀ (by linarith)
    obtain ⟨z, ⟨t, ⟨ht0, htδ⟩, rfl⟩, ψ, hψ, hψz⟩ := hhit δ' hδ'0
    obtain ⟨φ₀, hφ₀, hφ₀e⟩ := hy
    have heθ : e θ = e φ₀ := by simpa [ringPt] using hφ₀e.symm
    have h1 : e ψ = e (φ₀ + s.sign * t) := by
      have h2 : e ψ = e (θ + s.sign * t) := by simpa [ringPt] using hψz
      rw [h2, e_add, e_add, heθ]
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp h1
    have htδ' : t < (2 * π - (θ₁ - θ₀)) / 2 := lt_of_lt_of_le htδ (min_le_right _ _)
    have hst : |s.sign * t| = t := by rw [abs_mul, hs, one_mul, abs_of_pos ht0]
    have hst' := abs_le.mp hst.le
    have hn0 : n = 0 := by
      by_contra hne
      rcases lt_or_gt_of_ne hne with hneg | hpos
      · have : (n : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_iff.mpr hneg
        nlinarith [hψ.1, hφ₀.2]
      · have : (1 : ℝ) ≤ n := by exact_mod_cast hpos
        nlinarith [hψ.2, hφ₀.1]
    subst hn0
    simp only [Int.cast_zero, zero_mul, add_zero] at hn
    have hψ' : φ₀ + s.sign * t ∈ Icc θ₀ θ₁ := hn ▸ hψ
    refine ⟨t, ht0, lt_of_lt_of_le htδ (min_le_left _ _) |>.le, ?_⟩
    rintro _ ⟨u, ⟨hu0, hut⟩, rfl⟩
    have hconv : φ₀ + s.sign * u ∈ Icc θ₀ θ₁ := by
      have hl : u / t ∈ Icc (0 : ℝ) 1 := ⟨by positivity, by rw [div_le_one ht0]; exact hut.le⟩
      have : φ₀ + s.sign * u = (1 - u / t) * φ₀ + (u / t) * (φ₀ + s.sign * t) := by field_simp; ring
      rw [this]
      exact (convex_Icc θ₀ θ₁) hφ₀ hψ' (by linarith [hl.2]) hl.1 (by ring)
    refine ⟨φ₀ + s.sign * u, hconv, ?_⟩
    simp only [ringPt]
    rw [e_add, e_add, heθ]

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-! ## The disc of radius above 1 -/

/-- A fragment covers `B̄(p, 1)` exactly when it covers a closed disc of radius above `1` about `p`: the domain is open and
the disc compact. Every row's "on a closed disc of radius above 1 about `p`" is stated as `F.Covers p 1`. -/
theorem covers_one_iff (p : ℂ) : F.Covers p 1 ↔ ∃ R, 1 < R ∧ F.Covers p R := by
  constructor
  · intro h
    obtain ⟨δ, hδ, hsub⟩ := isCompact_closedBall p (1 : ℝ) |>.exists_cthickening_subset_open F.isOpen_dom h
    refine ⟨δ + 1, by linarith, ?_⟩
    have := cthickening_closedBall (E := ℂ) hδ.le zero_le_one p
    rw [this] at hsub
    exact hsub
  · rintro ⟨R, hR, h⟩
    exact (closedBall_subset_closedBall hR.le).trans h

/-! ## The points of `Γ` on a ring that lie on no arc of `Γ` on it -/

/-- On a covered ring, the points of `Γ` that lie on no arc of `Γ` on `ω(p)` are finitely many: the ring is compact, each
of its points has a neighbourhood meeting finitely many arcs, and each arc not on `ω(p)` meets `ω(p)` in finitely many
points (`Arc.finite_inter_sphere_or_eq_circ`). -/
theorem finite_ringΓ_off_ringArc {p : ℂ} (hp : F.Covers p 1) :
    ((F.Γ ∩ sphere p 1) \ {x | F.OnRingArc p x}).Finite := by
  have hK : sphere p 1 ⊆ F.dom := sphere_subset_closedBall.trans hp
  choose! t ht hfin using F.locallyFinite
  obtain ⟨S, hSK, hcov⟩ := (isCompact_sphere p 1).elim_nhds_subcover t fun x hx => ht x (hK hx)
  have h𝒜 : {a | a ∈ F.arcs ∧ (a.carrier ∩ sphere p 1).Nonempty}.Finite := by
    refine (S.finite_toSet.biUnion fun x hx => hfin x (hK (hSK x hx))).subset ?_
    rintro a ⟨ha, y, hya, hyK⟩
    obtain ⟨x, hxS, hyx⟩ := mem_iUnion₂.mp (hcov hyK)
    exact mem_iUnion₂.mpr ⟨x, hxS, ha, y, hya, hyx⟩
  have hsub : (F.Γ ∩ sphere p 1) \ {x | F.OnRingArc p x} ⊆
      ⋃ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ sphere p 1).Nonempty},
        (a.carrier ∩ sphere p 1) \ {x | F.OnRingArc p x} := by
    rintro x ⟨⟨⟨hxd, hxΓ⟩, hxK⟩, hxn⟩
    obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp hxΓ
    exact mem_iUnion₂.mpr ⟨a, ⟨ha, x, hxa, hxK⟩, ⟨hxa, hxK⟩, hxn⟩
  refine (h𝒜.biUnion fun a ha => ?_).subset hsub
  rcases Arc.finite_inter_sphere_or_eq_circ a (F.nondegenerate a ha.1) p with h | ⟨θ₀, θ₁, rfl⟩
  · exact h.subset sdiff_subset
  · refine (finite_empty).subset ?_
    rintro x ⟨⟨hxa, hxK⟩, hxn⟩
    apply hxn
    have hnd := F.nondegenerate _ ha.1
    have hcar : (Arc.circ p 1 θ₀ θ₁).carrier = ringArc p θ₀ θ₁ := by
      simp [Arc.carrier, ringArc, ringPt]
    refine ⟨θ₀, θ₁, hnd.2.1, ?_, ?_⟩
    · rw [← hcar]; exact hxa
    · rw [← hcar]
      intro z hz
      refine ⟨hK ?_, mem_iUnion₂.mpr ⟨_, ha.1, hz⟩⟩
      obtain ⟨θ, -, rfl⟩ := hz
      simp


/-! ## Interior points are dense -/

/-- `Γ` has empty interior: every point of the domain is a limit of interior points. -/
theorem dense_interiorPts : F.dom ⊆ closure F.interiorPts := by
  intro x hx
  rw [Metric.mem_closure_iff]
  intro ε hε
  obtain ⟨t, ht, hfin⟩ := F.locallyFinite x hx
  obtain ⟨r, hr, hrsub⟩ := Metric.mem_nhds_iff.mp (inter_mem ht (F.isOpen_dom.mem_nhds hx))
  set r' := min r ε
  have hr' : 0 < r' := lt_min hr hε
  set N : Set ℂ := ⋃ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ t).Nonempty}, a.carrier
  have hN : MeasureTheory.volume N = 0 :=
    (MeasureTheory.measure_biUnion_null_iff hfin.countable).mpr fun a _ => a.volume_carrier
  have hpos : 0 < MeasureTheory.volume (ball x r') := Metric.measure_ball_pos _ _ hr'
  have hnot : ¬ ball x r' ⊆ N := fun h =>
    absurd (MeasureTheory.measure_mono_null h hN) hpos.ne'
  obtain ⟨y, hy, hyN⟩ := not_subset.mp hnot
  have hyr : y ∈ ball x r := ball_subset_ball (min_le_left _ _) hy
  refine ⟨y, ⟨(hrsub hyr).2, fun hΓ => hyN ?_⟩, ?_⟩
  · obtain ⟨a, ha, hya⟩ := mem_iUnion₂.mp hΓ
    exact mem_iUnion₂.mpr ⟨a, ⟨ha, y, hya, (hrsub hyr).1⟩, hya⟩
  · rw [dist_comm]
    exact lt_of_lt_of_le (mem_ball.mp hy) (min_le_right _ _)

/-- Every point of the domain carries a colour. -/
theorem exists_mem_coloursAt {x : ℂ} (hx : x ∈ F.dom) : ∃ c, c ∈ F.coloursAt x := by
  have hx' := F.dense_interiorPts hx
  have : F.interiorPts = ⋃ c, F.region c := by
    ext y
    simp only [mem_iUnion, region, mem_inter_iff, mem_preimage, mem_singleton_iff]
    exact ⟨fun h => ⟨F.col y, h, rfl⟩, fun ⟨_, h, _⟩ => h⟩
  rw [this, closure_iUnion_of_finite] at hx'
  obtain ⟨c, hc⟩ := mem_iUnion.mp hx'
  exact ⟨c, hc⟩

/-! ## A ray from a point of the domain into the interior points -/

/-- A line meets a circle in finitely many points: `{s | ‖x + s w − c‖ = ρ}` is finite when `w ≠ 0`. -/
theorem finite_ray_inter_sphere (x c w : ℂ) (ρ : ℝ) (hw : w ≠ 0) :
    {s : ℝ | ‖x + (s : ℂ) * w - c‖ = ρ}.Finite := by
  set A : ℝ := ‖w‖ ^ 2
  set B : ℝ := 2 * ((x - c) * (starRingEnd ℂ) w).re
  set C : ℝ := ‖x - c‖ ^ 2 - ρ ^ 2
  have hA : A ≠ 0 := by positivity
  let q : Polynomial ℝ := Polynomial.C A * Polynomial.X ^ 2 + Polynomial.C B * Polynomial.X + Polynomial.C C
  have hq : q ≠ 0 := by
    intro h
    have := congrArg (fun r => Polynomial.coeff r 2) h
    simp [q, Polynomial.coeff_X_pow] at this
    exact hA this
  refine (Polynomial.finite_setOf_isRoot hq).subset ?_
  intro t ht
  simp only [mem_setOf_eq] at ht
  have h3 : ‖x - c + (t : ℂ) * w‖ ^ 2 = A * t ^ 2 + B * t + (C + ρ ^ 2) := by
    rw [Complex.sq_norm, Complex.normSq_apply]
    simp only [A, B, C, Complex.sq_norm, Complex.normSq_apply, Complex.add_re, Complex.add_im,
      Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, Complex.sub_re,
      Complex.sub_im, Complex.conj_re, Complex.conj_im]
    ring
  have h4 : x - c + (t : ℂ) * w = x + (t : ℂ) * w - c := by ring
  rw [h4, ht] at h3
  simp only [q, Set.mem_setOf_eq, Polynomial.IsRoot, Polynomial.eval_add, Polynomial.eval_mul,
    Polynomial.eval_C, Polynomial.eval_pow, Polynomial.eval_X]
  linarith

/-- A ray `x + s w` with `w` not parallel to the segment `[u, v]` meets it in at most one point. -/
theorem subsingleton_ray_inter_segment (x u v w : ℂ) (hd : v - u ≠ 0)
    (hpar : (w * (starRingEnd ℂ) (v - u)).im ≠ 0) :
    {s : ℝ | x + (s : ℂ) * w ∈ segment ℝ u v}.Subsingleton := by
  intro s₁ h₁ s₂ h₂
  obtain ⟨a₁, b₁, -, hb₁, hab₁, e₁⟩ := h₁
  obtain ⟨a₂, b₂, -, hb₂, hab₂, e₂⟩ := h₂
  by_contra hne
  have key : ((s₁ - s₂ : ℝ) : ℂ) * w = ((b₁ - b₂ : ℝ) : ℂ) * (v - u) := by
    have ha₁ : a₁ = 1 - b₁ := by linarith
    have ha₂ : a₂ = 1 - b₂ := by linarith
    subst ha₁ ha₂
    simp only [Complex.real_smul] at e₁ e₂
    push_cast at e₁ e₂ ⊢
    linear_combination e₂ - e₁
  apply hpar
  have : w = (((b₁ - b₂) / (s₁ - s₂) : ℝ) : ℂ) * (v - u) := by
    have hs : ((s₁ - s₂ : ℝ) : ℂ) ≠ 0 := by
      exact_mod_cast sub_ne_zero.mpr hne
    apply mul_left_cancel₀ hs
    rw [key]
    push_cast
    have hs' : ((s₁ : ℂ) - s₂) ≠ 0 := by simpa using hs
    field_simp
  rw [this, mul_assoc, Complex.mul_conj, ← Complex.ofReal_mul]
  exact Complex.ofReal_im _

/-- **A ray from a point of the domain** (child of engine 2): there are a direction `w ≠ 0` and `ε > 0` with
`x + s w` an interior point for all `0 < s < ε`. -/
theorem exists_ray_in_interiorPts {x : ℂ} (hx : x ∈ F.dom) :
    ∃ w : ℂ, w ≠ 0 ∧ ∃ ε > 0, ∀ s ∈ Ioo (0 : ℝ) ε, x + (s : ℂ) * w ∈ F.interiorPts := by
  classical
  obtain ⟨t, ht, hfin⟩ := F.locallyFinite x hx
  set 𝒜 := {a | a ∈ F.arcs ∧ (a.carrier ∩ t).Nonempty}
  obtain ⟨r, hr, hrsub⟩ := Metric.mem_nhds_iff.mp (inter_mem ht (F.isOpen_dom.mem_nhds hx))
  -- the bad slopes
  let slope : Arc → ℝ := fun a => match a with
    | .seg u v => (v - u).im / (v - u).re
    | .circ .. => 0
  have hbad : (slope '' 𝒜).Finite := hfin.image _
  obtain ⟨lam, hlam⟩ := hbad.infinite_compl.nonempty
  set w : ℂ := 1 + (lam : ℂ) * I with hw
  have hw0 : w ≠ 0 := by
    intro h; have := congrArg Complex.re h; simp [hw] at this
  have hfinS : {s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier}.Finite := by
    have : {s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier} ⊆ ⋃ a ∈ 𝒜, {s : ℝ | x + (s : ℂ) * w ∈ a.carrier} := by
      intro s hs
      obtain ⟨a, ha, hsa⟩ := mem_iUnion₂.mp hs
      exact mem_iUnion₂.mpr ⟨a, ha, hsa⟩
    refine (hfin.biUnion fun a ha => ?_).subset this
    have hnd := F.nondegenerate a ha.1
    cases a with
    | seg u v =>
      have hd : v - u ≠ 0 := sub_ne_zero.mpr (Ne.symm hnd)
      refine (subsingleton_ray_inter_segment x u v w hd ?_).finite
      intro him
      apply hlam
      refine ⟨Arc.seg u v, ha, ?_⟩
      show (v - u).im / (v - u).re = lam
      have hre : (v - u).re ≠ 0 := by
        intro h0
        have : (w * (starRingEnd ℂ) (v - u)).im = lam * (v - u).re - (v - u).im := by
          simp [hw, Complex.mul_im]; ring
        rw [this, h0] at him
        have him' : (v - u).im = 0 := by linarith
        exact hd (Complex.ext h0 him')
      have : (w * (starRingEnd ℂ) (v - u)).im = lam * (v - u).re - (v - u).im := by
        simp [hw, Complex.mul_im]; ring
      rw [this] at him
      field_simp
      linarith
    | circ c ρ θ₀ θ₁ =>
      refine (finite_ray_inter_sphere x c w |ρ| hw0).subset ?_
      rintro s ⟨θ, -, hθ⟩
      simp only [mem_setOf_eq]
      rw [← hθ]
      simp [norm_e]
  obtain ⟨ε₁, hε₁, hε₁S⟩ : ∃ ε > 0, ∀ s ∈ {s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier}, ε ≤ |s| ∨ s = 0 ∨ True := by
    exact ⟨1, one_pos, fun _ _ => Or.inr (Or.inr trivial)⟩
  -- a positive lower bound for the bad parameters
  have hclosed := hfinS.isClosed
  have hopen : IsOpen {s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier}ᶜ := hclosed.isOpen_compl
  -- remove s = 0, which may be bad: use the finite set restricted to positive parameters
  have hfinPos : ({s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier} ∩ Ioi 0).Finite := hfinS.subset inter_subset_left
  have hcl2 := hfinPos.isClosed
  have h0 : (0 : ℝ) ∈ ({s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier} ∩ Ioi 0)ᶜ := by
    intro h; exact (lt_irrefl (0 : ℝ)) h.2
  obtain ⟨ε₂, hε₂, hball⟩ := Metric.isOpen_iff.mp hcl2.isOpen_compl 0 h0
  refine ⟨w, hw0, min ε₂ (r / ‖w‖), lt_min hε₂ (div_pos hr (norm_pos_iff.mpr hw0)), ?_⟩
  intro s hs
  have hs0 : 0 < s := hs.1
  have hsε : s < ε₂ := lt_of_lt_of_le hs.2 (min_le_left _ _)
  have hsr : s * ‖w‖ < r := by
    have := lt_of_lt_of_le hs.2 (min_le_right _ _)
    rwa [lt_div_iff₀ (norm_pos_iff.mpr hw0)] at this
  have hmem : x + (s : ℂ) * w ∈ ball x r := by
    rw [mem_ball, dist_eq_norm]
    simpa [norm_mul, abs_of_pos hs0] using hsr
  have hnb : x + (s : ℂ) * w ∉ ⋃ a ∈ 𝒜, a.carrier := by
    intro h
    have : s ∈ ({s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier} ∩ Ioi 0) := ⟨h, hs0⟩
    have hsb : s ∈ ball (0 : ℝ) ε₂ := by
      rw [mem_ball, Real.dist_eq, sub_zero, abs_of_pos hs0]; exact hsε
    exact hball hsb this
  refine ⟨(hrsub hmem).2, fun hΓ => hnb ?_⟩
  obtain ⟨a, ha, hya⟩ := mem_iUnion₂.mp hΓ
  exact mem_iUnion₂.mpr ⟨a, ⟨ha, _, hya, (hrsub hmem).1⟩, hya⟩

/-- **Engine 2.** Every point of the domain lies in the closure of some tile: a ray from it into the interior points
is connected, so lies in one tile. -/
theorem mem_closure_tile {x : ℂ} (hx : x ∈ F.dom) : ∃ T, F.IsTile T ∧ x ∈ closure T := by
  obtain ⟨w, hw, ε, hε, hray⟩ := F.exists_ray_in_interiorPts hx
  set y := x + ((ε / 2 : ℝ) : ℂ) * w
  have hy : y ∈ F.interiorPts := hray _ ⟨by positivity, by linarith⟩
  refine ⟨connectedComponentIn F.interiorPts y, ⟨y, hy, rfl⟩, ?_⟩
  have hpre : IsPreconnected ((fun s : ℝ => x + (s : ℂ) * w) '' Ioo 0 ε) :=
    (isPreconnected_Ioo).image _ (by fun_prop)
  have hsub : (fun s : ℝ => x + (s : ℂ) * w) '' Ioo 0 ε ⊆ connectedComponentIn F.interiorPts y :=
    hpre.subset_connectedComponentIn ⟨ε / 2, ⟨by positivity, by linarith⟩, rfl⟩
      (by rintro _ ⟨s, hs, rfl⟩; exact hray s hs)
  refine closure_mono hsub ?_
  have hcont : Continuous fun s : ℝ => x + (s : ℂ) * w := by fun_prop
  have h0x := map_mem_closure hcont (by rw [closure_Ioo hε.ne]; exact ⟨le_rfl, hε.le⟩ : (0 : ℝ) ∈ closure (Ioo 0 ε))
    (mapsTo_image (fun s : ℝ => x + (s : ℂ) * w) (Ioo 0 ε))
  simpa using h0x

/-! ## Finitely many tiles near a point -/

/-- **Finitely many tiles meet a small disc about any point of the domain**: near `x` only the arcs through `x` remain,
each with at most two branches at `x`; for small `r` the branches are disjoint off `x` and cut `B(x, r)` into at most as
many curvilinear sectors as there are branches, each connected. -/
theorem finite_tiles_near {x : ℂ} (hx : x ∈ F.dom) :
    ∃ r > 0, {T | F.IsTile T ∧ (T ∩ ball x r).Nonempty}.Finite := by
  sorry

/-- The colours at a point of the domain are the colours of the tiles whose closure holds it (the rows' `P_cl`, read
tile by tile). -/
theorem mem_coloursAt_iff_exists_tileOf {x : ℂ} (hx : x ∈ F.dom) {c : Fin k} :
    c ∈ F.coloursAt x ↔ ∃ T, F.TileOf c T ∧ x ∈ closure T := by
  sorry

/-- At a point of the domain, the cone of a colour class is the union of the cones of its tiles whose closure holds the
point: "the cone of a tile of colour `c`" and "the cone of the class of `c`" agree. -/
theorem coneAt_region_eq_biUnion {x : ℂ} (hx : x ∈ F.dom) (c : Fin k) :
    coneAt (F.region c) x = ⋃ T ∈ {T | F.TileOf c T ∧ x ∈ closure T}, coneAt T x := by
  sorry

/-- At a point of the domain every direction lies in the cone of some colour (pigeonhole over the finitely many colours,
on interior points near the ray). -/
theorem exists_mem_coneAt_region {x : ℂ} (hx : x ∈ F.dom) (β : ℝ) : ∃ c, β ∈ coneAt (F.region c) x := by
  classical
  obtain ⟨r, hr, hrsub⟩ := Metric.isOpen_iff.mp F.isOpen_dom x hx
  obtain ⟨N₀, hN₀⟩ := exists_nat_gt (2 / r)
  set N : ℕ := N₀ + 2 with hNdef
  have hN : 2 / r < N := lt_of_lt_of_le hN₀ (by rw [hNdef]; push_cast; linarith)
  have hN2 : (2 : ℝ) ≤ N := by rw [hNdef]; push_cast; linarith [(Nat.cast_nonneg N₀ : (0 : ℝ) ≤ N₀)]
  have hmge : ∀ n : ℕ, (N : ℝ) ≤ ((n + N : ℕ) : ℝ) := fun n => by
    push_cast; linarith [(Nat.cast_nonneg n : (0 : ℝ) ≤ n)]
  have hex : ∀ n : ℕ, ∃ z : ℂ, z ∈ F.interiorPts ∧
      dist z (x + e β / ((n + N : ℕ) : ℂ)) < 1 / ((n + N : ℕ) : ℝ) ^ 2 := by
    intro n
    have hm0 : (0 : ℝ) < ((n + N : ℕ) : ℝ) := lt_of_lt_of_le (by linarith) (hmge n)
    have hmem : x + e β / ((n + N : ℕ) : ℂ) ∈ ball x r := by
      rw [mem_ball, dist_eq_norm, add_sub_cancel_left, norm_div, norm_e, Complex.norm_natCast]
      rw [div_lt_iff₀ hm0]
      have h2 : 2 / r < N := hN
      rw [div_lt_iff₀ hr] at h2
      nlinarith [hmge n]
    have hd := F.dense_interiorPts (hrsub hmem)
    obtain ⟨z, hz, hzd⟩ := Metric.mem_closure_iff.mp hd (1 / ((n + N : ℕ) : ℝ) ^ 2) (by positivity)
    exact ⟨z, hz, by rw [dist_comm]; exact hzd⟩
  choose z hzI hzd using hex
  obtain ⟨c, hc⟩ : ∃ c : Fin k, {n : ℕ | F.col (z n) = c}.Infinite := by
    by_contra hcon
    push Not at hcon
    have hfin : (Set.univ : Set ℕ).Finite := by
      have : (Set.univ : Set ℕ) = ⋃ c : Fin k, {n : ℕ | F.col (z n) = c} := by
        ext n; simp
      rw [this]
      exact Set.finite_iUnion fun c => hcon c
    exact Set.infinite_univ hfin
  refine ⟨c, fun ε hε => ?_⟩
  obtain ⟨M, hM⟩ : ∃ M : ℕ, 8 / ε < M := exists_nat_gt _
  obtain ⟨n, hn, hnM⟩ := hc.exists_gt M
  have hmM : (M : ℝ) < ((n + N : ℕ) : ℝ) := by
    have : M < n + N := by omega
    exact_mod_cast this
  set m : ℕ := n + N with hm
  have hm0 : (2 : ℝ) ≤ m := (hN2.trans (hmge n))
  have hmpos : (0 : ℝ) < m := by linarith
  have hmε : 8 < ε * m := by
    have : 8 / ε < m := hM.trans hmM
    rwa [div_lt_iff₀ hε, mul_comm] at this
  set u : ℂ := e β / (m : ℂ) with hu
  have hun : ‖u‖ = 1 / m := by rw [hu, norm_div, norm_e, Complex.norm_natCast]
  have hu0 : u ≠ 0 := by
    intro h; rw [h, norm_zero] at hun; have : (0:ℝ) < 1 / m := by positivity
    linarith
  have hwu : ‖z n - x - u‖ < 1 / (m : ℝ) ^ 2 := by
    have := hzd n
    rw [dist_eq_norm, show z n - (x + u) = z n - x - u by ring] at this
    exact this
  have hwu' : 1 / (m : ℝ) ^ 2 ≤ 1 / (2 * m) := by
    rw [div_le_div_iff₀ (by positivity) (by positivity)]; nlinarith
  have hwn : 1 / (2 * (m : ℝ)) ≤ ‖z n - x‖ := by
    have h2 := norm_sub_norm_le u (z n - x)
    rw [norm_sub_rev u (z n - x), hun] at h2
    have : 1 / (m : ℝ) = 2 * (1 / (2 * m)) := by field_simp
    linarith
  have hw0 : z n - x ≠ 0 := by
    intro h; rw [h, norm_zero] at hwn
    have : (0 : ℝ) < 1 / (2 * (m : ℝ)) := by positivity
    linarith
  refine ⟨z n, ⟨hzI n, hn⟩, sub_ne_zero.mp hw0 |> fun h => h, ?_, ?_⟩
  · rw [dist_eq_norm]
    have h1 : ‖z n - x‖ ≤ ‖u‖ + ‖z n - x - u‖ := by
      have := norm_add_le u (z n - x - u)
      rw [show u + (z n - x - u) = z n - x by ring] at this; exact this
    rw [hun] at h1
    have : 1 / (m : ℝ) + 1 / (m : ℝ) ^ 2 ≤ 2 / m := by
      rw [show 2 / (m : ℝ) = 1 / m + 1 / m by ring]
      have : 1 / (m : ℝ) ^ 2 ≤ 1 / m := by
        rw [div_le_div_iff₀ (by positivity) (by positivity)]; nlinarith
      linarith
    have h2 : 2 / (m : ℝ) < ε := by
      rw [div_lt_iff₀ hmpos]; nlinarith
    linarith
  · have hdir := norm_div_norm_sub_le hu0 hw0
    have hub : u / (‖u‖ : ℂ) = e β := by
      rw [hun, hu]
      have : ((1 / (m : ℝ) : ℝ) : ℂ) = 1 / (m : ℂ) := by push_cast; rfl
      rw [this]
      have hmc : (m : ℂ) ≠ 0 := by exact_mod_cast hmpos.ne'
      field_simp
    rw [hub] at hdir
    refine lt_of_le_of_lt hdir ?_
    rw [hun, div_lt_iff₀ (by positivity)]
    have : 2 * ‖z n - x - u‖ < 2 * (1 / (m : ℝ) ^ 2) := by linarith
    have h3 : 2 * (1 / (m : ℝ) ^ 2) = ε * (1 / m) * (2 / (ε * m)) := by field_simp
    have h4 : 2 / (ε * (m : ℝ)) < 1 := by rw [div_lt_one (by positivity)]; linarith
    calc 2 * ‖z n - x - u‖ < 2 * (1 / (m : ℝ) ^ 2) := this
      _ = ε * (1 / m) * (2 / (ε * m)) := h3
      _ ≤ ε * (1 / m) := by
        have : 0 ≤ ε * (1 / (m : ℝ)) := by positivity
        nlinarith

/-! ## The germ dichotomy -/

/-- Near a point of the domain, a ball in the domain meets only finitely many arcs. -/
theorem exists_ball_finite {y : ℂ} (hy : y ∈ F.dom) :
    ∃ ε > 0, ball y ε ⊆ F.dom ∧ {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ε).Nonempty}.Finite := by
  obtain ⟨t, ht, hfin⟩ := F.locallyFinite y hy
  obtain ⟨ε, hε, hsub⟩ := Metric.mem_nhds_iff.mp (inter_mem ht (F.isOpen_dom.mem_nhds hy))
  refine ⟨ε, hε, fun z hz => (hsub hz).2, hfin.subset ?_⟩
  rintro a ⟨ha, z, hza, hz⟩
  exact ⟨ha, z, hza, (hsub hz).1⟩

/-- Inside a ball meeting finitely many arcs, the points of the unit circle on the arcs that are not arcs of it are
finitely many. -/
theorem finite_nonring_inter_sphere (p : ℂ) {y : ℂ} {ε : ℝ}
    (hfin : {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ε).Nonempty}.Finite) :
    (⋃ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ε).Nonempty ∧ ¬ a.OnRing p}, a.carrier ∩ sphere p 1).Finite := by
  refine (hfin.subset ?_ : {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ε).Nonempty ∧ ¬ a.OnRing p}.Finite).biUnion ?_
  · rintro a ⟨ha, hne, -⟩; exact ⟨ha, hne⟩
  · rintro a ⟨ha, -, hring⟩
    rcases Arc.finite_inter_sphere_or_eq_circ a (F.nondegenerate a ha) p with h | ⟨θ₀, θ₁, rfl⟩
    · exact h
    · exact absurd ⟨θ₀, θ₁, rfl⟩ hring

/-- A point of a ball meeting finitely many arcs that lies on no arc other than arcs of `ω(p)` has a neighbourhood meeting
only arcs of `ω(p)`. -/
theorem exists_ball_onRing (p : ℂ) {y : ℂ} {ε : ℝ}
    (hfin : {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ε).Nonempty}.Finite) {x : ℂ} (hx : x ∈ ball y ε)
    (hxn : ∀ a ∈ F.arcs, ¬ a.OnRing p → x ∉ a.carrier) :
    ∃ r0 > 0, ball x r0 ⊆ ball y ε ∧ ∀ a ∈ F.arcs, (a.carrier ∩ ball x r0).Nonempty → a.OnRing p := by
  set bad : Set ℂ := ⋃ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ε).Nonempty ∧ ¬ a.OnRing p}, a.carrier with hbad
  have hbfin : {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ε).Nonempty ∧ ¬ a.OnRing p}.Finite :=
    hfin.subset fun a ⟨ha, hne, _⟩ => ⟨ha, hne⟩
  have hcl : IsClosed bad := hbfin.isClosed_biUnion fun a ha => a.isClosed_carrier
  have hxb : x ∉ bad := by
    intro h
    obtain ⟨a, ⟨ha, -, hr⟩, hxa⟩ := mem_iUnion₂.mp h
    exact hxn a ha hr hxa
  obtain ⟨r0, hr0, hsub⟩ := Metric.isOpen_iff.mp (isOpen_ball.inter hcl.isOpen_compl) x ⟨hx, hxb⟩
  refine ⟨r0, hr0, fun z hz => (hsub hz).1, fun a ha hne => ?_⟩
  obtain ⟨z, hza, hz⟩ := hne
  by_contra hr
  exact (hsub hz).2 (mem_iUnion₂.mpr ⟨a, ⟨ha, ⟨z, hza, (hsub hz).1⟩, hr⟩, hza⟩)


/-- **The sides of a ring point**: if a ball about `r(φ)` lies in the domain and meets only arcs of `ω(p)`, then for angles in a
neighbourhood of `φ` the colours just inside and just outside the ring are each one colour, the same for all of them. -/
theorem exists_sides_nbhd (p : ℂ) {φ r0 : ℝ} (hr0 : 0 < r0) (hdom : ball (ringPt p φ) r0 ⊆ F.dom)
    (hring : ∀ a ∈ F.arcs, (a.carrier ∩ ball (ringPt p φ) r0).Nonempty → a.OnRing p) :
    ∃ κ > 0, ∃ c c' : Fin k, ∀ φ' ∈ Ioo (φ - κ) (φ + κ),
      F.innerColours p (ringPt p φ') = {c} ∧ F.outerColours p (ringPt p φ') = {c'} := by
  set κ : ℝ := min (r0 / 4) (1 / 2) with hκ
  have hκ0 : 0 < κ := lt_min (by positivity) (by norm_num)
  have hκ1 : κ ≤ r0 / 4 := min_le_left _ _
  have hκ2 : κ ≤ 1 / 2 := min_le_right _ _
  -- polar points near `r(φ)` off the ring are interior points
  have hint : ∀ ρ ψ : ℝ, |ρ - 1| < κ → ρ ≠ 1 → |ψ - φ| < κ → polarPt p ρ ψ ∈ F.interiorPts := by
    intro ρ ψ hρ hρ1 hψ
    have hball : polarPt p ρ ψ ∈ ball (ringPt p φ) r0 := by
      rw [mem_ball]
      linarith [dist_polarPt_ringPt_le p ρ ψ φ]
    refine ⟨hdom hball, fun hz => ?_⟩
    obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp hz
    have hr := hring a ha ⟨_, hza, hball⟩
    have hs := hr.carrier_subset_sphere hza
    rw [mem_sphere, dist_eq_norm, norm_polarPt_sub, abs_of_pos (by linarith [(abs_lt.mp hρ).1, hκ2])] at hs
    exact hρ1 hs
  -- one colour on each side box
  have hbox : ∀ J : Set ℝ, IsPreconnected J → J ⊆ {ρ | |ρ - 1| < κ ∧ ρ ≠ 1} → J.Nonempty →
      ∃ c, ∀ ρ ∈ J, ∀ ψ ∈ Ioo (φ - κ) (φ + κ), polarPt p ρ ψ ∈ F.region c := by
    intro J hJ hJs ⟨ρ0, hρ0⟩
    have hconn : IsPreconnected ((fun q : ℝ × ℝ => polarPt p q.1 q.2) '' (J ×ˢ Ioo (φ - κ) (φ + κ))) :=
      (hJ.prod isPreconnected_Ioo).image _ (continuous_polarPt p).continuousOn
    have hsub : ((fun q : ℝ × ℝ => polarPt p q.1 q.2) '' (J ×ˢ Ioo (φ - κ) (φ + κ))) ⊆ F.interiorPts := by
      rintro _ ⟨⟨ρ, ψ⟩, ⟨hρ, hψ⟩, rfl⟩
      exact hint ρ ψ (hJs hρ).1 (hJs hρ).2 (by rw [abs_lt]; constructor <;> linarith [hψ.1, hψ.2])
    refine ⟨F.col (polarPt p ρ0 φ), fun ρ hρ ψ hψ => ⟨hsub ⟨(ρ, ψ), ⟨hρ, hψ⟩, rfl⟩, ?_⟩⟩
    exact hconn.constant (F.continuousOn_col.mono hsub) ⟨(ρ, ψ), ⟨hρ, hψ⟩, rfl⟩
      ⟨(ρ0, φ), ⟨hρ0, ⟨by linarith, by linarith⟩⟩, rfl⟩
  obtain ⟨c, hc⟩ := hbox (Ioo (1 - κ) 1) isPreconnected_Ioo
    (fun ρ hρ => ⟨by rw [abs_lt]; constructor <;> linarith [hρ.1, hρ.2], hρ.2.ne⟩)
    ⟨1 - κ / 2, by constructor <;> linarith⟩
  obtain ⟨c', hc'⟩ := hbox (Ioo 1 (1 + κ)) isPreconnected_Ioo
    (fun ρ hρ => ⟨by rw [abs_lt]; constructor <;> linarith [hρ.1, hρ.2], hρ.1.ne'⟩)
    ⟨1 + κ / 2, by constructor <;> linarith⟩
  refine ⟨κ, hκ0, c, c', fun φ' hφ' => ⟨?_, ?_⟩⟩
  · -- inside
    ext c''
    simp only [mem_singleton_iff]
    constructor
    · intro hmem
      obtain ⟨ν, hν, hnu⟩ := polar_nbhd p hφ'
      have hmem' : ringPt p φ' ∈ closure (F.region c'' ∩ ball p 1) := hmem
      obtain ⟨z, ⟨hzr, hzb⟩, hzd⟩ := Metric.mem_closure_iff.mp hmem' (min ν κ) (lt_min hν hκ0)
      rw [dist_comm] at hzd
      obtain ⟨hρ, ψ, hψ, hz⟩ := hnu z (lt_of_lt_of_le hzd (min_le_left _ _))
      have hzn : ‖z - p‖ < 1 := by simpa [dist_eq_norm] using hzb
      have hρκ : ‖z - p‖ ∈ Ioo (1 - κ) 1 := by
        refine ⟨?_, hzn⟩
        have : dist z (ringPt p φ') < κ := lt_of_lt_of_le hzd (min_le_right _ _)
        have h2 := abs_norm_sub_one_le p z φ'
        linarith [(abs_le.mp h2).1]
      have hψ' : ψ ∈ Ioo (φ - κ) (φ + κ) := ⟨by linarith [hψ.1, hφ'.1], by linarith [hψ.2, hφ'.2]⟩
      have := (hc _ hρκ ψ hψ').2
      rw [← hz] at this
      exact hzr.2.symm.trans this
    · intro hcc
      rw [hcc]
      show ringPt p φ' ∈ closure (F.region c ∩ ball p 1)
      rw [mem_closure_iff_nhds]
      intro U hU
      obtain ⟨ε', hε', hεU⟩ := Metric.mem_nhds_iff.mp hU
      set ρ := 1 - min κ ε' / 2 with hρ
      have hmk : 0 < min κ ε' := lt_min hκ0 hε'
      have hρ1 : ρ ∈ Ioo (1 - κ) 1 :=
        ⟨by linarith [min_le_left κ ε'], by linarith⟩
      refine ⟨polarPt p ρ φ', hεU ?_, ?_, ?_⟩
      · rw [mem_ball]
        have := dist_polarPt_ringPt_le p ρ φ' φ'
        rw [sub_self, abs_zero, add_zero] at this
        refine lt_of_le_of_lt this ?_
        rw [abs_of_neg (by linarith)]
        linarith [min_le_right κ ε']
      · exact hc _ hρ1 φ' hφ'
      · rw [mem_ball, dist_eq_norm, norm_polarPt_sub, abs_of_pos (by linarith [hρ1.1, hκ0])]
        exact hρ1.2
  · -- outside
    ext c''
    simp only [mem_singleton_iff]
    constructor
    · intro hmem
      obtain ⟨ν, hν, hnu⟩ := polar_nbhd p hφ'
      have hmem' : ringPt p φ' ∈ closure (F.region c'' \ closedBall p 1) := hmem
      obtain ⟨z, ⟨hzr, hzb⟩, hzd⟩ := Metric.mem_closure_iff.mp hmem' (min ν κ) (lt_min hν hκ0)
      rw [dist_comm] at hzd
      obtain ⟨hρ, ψ, hψ, hz⟩ := hnu z (lt_of_lt_of_le hzd (min_le_left _ _))
      have hzn : 1 < ‖z - p‖ := by simpa [dist_eq_norm] using hzb
      have hρκ : ‖z - p‖ ∈ Ioo 1 (1 + κ) := by
        refine ⟨hzn, ?_⟩
        have : dist z (ringPt p φ') < κ := lt_of_lt_of_le hzd (min_le_right _ _)
        have h2 := abs_norm_sub_one_le p z φ'
        linarith [(abs_le.mp h2).2]
      have hψ' : ψ ∈ Ioo (φ - κ) (φ + κ) := ⟨by linarith [hψ.1, hφ'.1], by linarith [hψ.2, hφ'.2]⟩
      have := (hc' _ hρκ ψ hψ').2
      rw [← hz] at this
      exact hzr.2.symm.trans this
    · intro hcc
      rw [hcc]
      show ringPt p φ' ∈ closure (F.region c' \ closedBall p 1)
      rw [mem_closure_iff_nhds]
      intro U hU
      obtain ⟨ε', hε', hεU⟩ := Metric.mem_nhds_iff.mp hU
      set ρ := 1 + min κ ε' / 2 with hρ
      have hmk : 0 < min κ ε' := lt_min hκ0 hε'
      have hρ1 : ρ ∈ Ioo 1 (1 + κ) :=
        ⟨by linarith, by linarith [min_le_left κ ε']⟩
      refine ⟨polarPt p ρ φ', hεU ?_, ?_, ?_⟩
      · rw [mem_ball]
        have := dist_polarPt_ringPt_le p ρ φ' φ'
        rw [sub_self, abs_zero, add_zero] at this
        refine lt_of_le_of_lt this ?_
        rw [abs_of_pos (by linarith)]
        linarith [min_le_right κ ε']
      · exact hc' _ hρ1 φ' hφ'
      · rw [mem_closedBall, dist_eq_norm, norm_polarPt_sub, abs_of_pos (by linarith [hρ1.1])]
        linarith [hρ1.1]

/-- **Constancy of the sides**: if the sides of the ring are locally constant along a preconnected set of angles, they are
constant on it. -/
theorem sides_const (p : ℂ) {I : Set ℝ} (hI : IsPreconnected I) (hne : I.Nonempty)
    (hloc : ∀ φ ∈ I, ∃ κ > 0, ∃ c c' : Fin k, ∀ φ' ∈ Ioo (φ - κ) (φ + κ),
      F.innerColours p (ringPt p φ') = {c} ∧ F.outerColours p (ringPt p φ') = {c'}) :
    ∃ c c' : Fin k, ∀ φ ∈ I, F.innerColours p (ringPt p φ) = {c} ∧ F.outerColours p (ringPt p φ) = {c'} := by
  classical
  obtain ⟨φ₀, hφ₀⟩ := hne
  obtain ⟨κ₀, -, c₀, c₀', -⟩ := hloc φ₀ hφ₀
  haveI : Nonempty (Fin k × Fin k) := ⟨(c₀, c₀')⟩
  let P : ℝ → Fin k × Fin k → Prop := fun φ cc =>
    F.innerColours p (ringPt p φ) = {cc.1} ∧ F.outerColours p (ringPt p φ) = {cc.2}
  have huniq : ∀ φ cc dd, P φ cc → P φ dd → cc = dd := by
    intro φ cc dd h1 h2
    exact Prod.ext (Set.singleton_eq_singleton_iff.mp (h1.1.symm.trans h2.1))
      (Set.singleton_eq_singleton_iff.mp (h1.2.symm.trans h2.2))
  let f : ℝ → Fin k × Fin k := fun φ => Classical.epsilon (P φ)
  have hf : ∀ φ cc, P φ cc → f φ = cc := fun φ cc h =>
    huniq φ _ _ (Classical.epsilon_spec (p := P φ) ⟨cc, h⟩) h
  have hcont : ContinuousOn f I := by
    intro φ hφ
    obtain ⟨κ, hκ, c, c', h⟩ := hloc φ hφ
    refine ContinuousAt.continuousWithinAt ?_
    have hev : ∀ᶠ φ' in 𝓝 φ, f φ' = (c, c') := by
      filter_upwards [Ioo_mem_nhds (show φ - κ < φ by linarith) (show φ < φ + κ by linarith)] with φ' hφ'
      exact hf φ' (c, c') (h φ' hφ')
    have hφ : f φ = (c, c') := hf φ (c, c') (h φ ⟨by linarith, by linarith⟩)
    exact continuousAt_const.congr (hev.mono fun φ' h' => hφ.trans h'.symm)
  refine ⟨(f φ₀).1, (f φ₀).2, fun φ hφ => ?_⟩
  have hfφ : f φ = f φ₀ := hI.constant hcont hφ hφ₀
  obtain ⟨κ, hκ, c, c', h⟩ := hloc φ hφ
  have hP : P φ (c, c') := h φ ⟨by linarith, by linarith⟩
  have : (c, c') = f φ₀ := (hf φ _ hP).symm.trans hfφ
  rw [← this]
  exact hP

/-- **The germ dichotomy**: at a ring point `r(θ)` of the domain, the germ of `ω(p)` on either side lies in one colour
class, or on an arc of `Γ` on `ω(p)` with constant sides (the strip beside a short germ avoids every other arc, which
meets `ω(p)` in finitely many points). -/
theorem germ_dichotomy {p : ℂ} {θ : ℝ} (hθ : ringPt p θ ∈ F.dom) (s : Side) :
    (∃ c, GermIn p θ s (F.region c)) ∨
      ∃ θ₁ θ₂ c c', F.IsRingArc p θ₁ θ₂ c c' ∧ GermIn p θ s (ringArc p θ₁ θ₂) := by
  classical
  have hπ := Real.pi_pos
  obtain ⟨ε, hε, hdomε, hfin⟩ := F.exists_ball_finite hθ
  set y := ringPt p θ with hy
  have hNfin := F.finite_nonring_inter_sphere p hfin
  set N := ⋃ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ε).Nonempty ∧ ¬ a.OnRing p}, a.carrier ∩ sphere p 1 with hN
  -- short germs avoid the finite set of crossings
  have hgermN : ∀ᶠ δ in 𝓝[>] (0 : ℝ), ∀ n ∈ N, n ∉ germ p θ s δ := by
    refine (Filter.eventually_all_finite hNfin).2 fun n _ => ?_
    by_cases hny : n = y
    · filter_upwards [Ioo_mem_nhdsGT (show (0 : ℝ) < 2 * π by positivity)] with δ hδ
      rw [hny]; exact ringPt_notMem_germ hδ.2.le
    · have hd : 0 < dist n y := dist_pos.mpr hny
      filter_upwards [Ioo_mem_nhdsGT hd] with δ hδ hmem
      have h2 : dist n y < δ := dist_lt_of_mem_germ hmem
      linarith [hδ.2]
  have hsmall : ∀ᶠ δ in 𝓝[>] (0 : ℝ), δ < ε / 2 := by
    filter_upwards [Ioo_mem_nhdsGT (show (0 : ℝ) < ε / 2 by positivity)] with δ h using h.2
  have hpos : ∀ᶠ δ in 𝓝[>] (0 : ℝ), 0 < δ := self_mem_nhdsWithin
  -- a germ short enough lies in interior points unless an arc of `ω(p)` meets it
  have hgerm_int : ∀ δ, 0 < δ → δ < ε / 2 → (∀ n ∈ N, n ∉ germ p θ s δ) →
      (∀ a ∈ F.arcs, a.OnRing p → (a.carrier ∩ ball y ε).Nonempty → Disjoint (germ p θ s δ) a.carrier) →
      germ p θ s δ ⊆ F.interiorPts := by
    intro δ hδ hδε hN' hA z hz
    have hzb : z ∈ ball y ε := by
      rw [mem_ball]; linarith [dist_lt_of_mem_germ hz]
    refine ⟨hdomε hzb, fun hzΓ => ?_⟩
    obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp hzΓ
    by_cases hr : a.OnRing p
    · exact Set.disjoint_left.mp (hA a ha hr ⟨z, hza, hzb⟩) hz hza
    · have hzs : z ∈ sphere p 1 := by
        obtain ⟨t, -, rfl⟩ := hz
        exact ringPt_mem_sphere _ _
      exact hN' z (mem_iUnion₂.mpr ⟨a, ⟨ha, ⟨z, hza, hzb⟩, hr⟩, hza, hzs⟩) hz
  -- the arcs of `ω(p)` near `y`
  set 𝒜₁ := {a | a ∈ F.arcs ∧ (a.carrier ∩ ball y ε).Nonempty ∧ a.OnRing p} with h𝒜₁
  have h𝒜₁fin : 𝒜₁.Finite := hfin.subset fun a ⟨ha, hne, _⟩ => ⟨ha, hne⟩
  by_cases hA : ∀ᶠ δ in 𝓝[>] (0 : ℝ), ∀ a ∈ 𝒜₁, Disjoint (germ p θ s δ) a.carrier
  · -- the germ lies in one colour class
    left
    obtain ⟨δ, ⟨⟨⟨hδA, hδN⟩, hδs⟩, hδp⟩⟩ := ((((hA.and hgermN).and hsmall).and hpos)).exists
    have hint := hgerm_int δ hδp hδs hδN (fun a ha hr hne => hδA a ⟨ha, hne, hr⟩)
    set z0 := ringPt p (θ + s.sign * (δ / 2)) with hz0
    have hz0g : z0 ∈ germ p θ s δ := ⟨δ / 2, ⟨by linarith, by linarith⟩, rfl⟩
    exact ⟨F.col z0, δ, hδp, fun z hz => ⟨hint hz,
      (isPreconnected_germ p θ s δ).constant (F.continuousOn_col.mono hint) hz hz0g⟩⟩
  · -- an arc of `ω(p)` meets every short germ
    right
    have hex : ∃ a ∈ 𝒜₁, ∀ δ > 0, (germ p θ s δ ∩ a.carrier).Nonempty := by
      by_contra hcon
      push Not at hcon
      apply hA
      refine (Filter.eventually_all_finite h𝒜₁fin).2 fun a ha => ?_
      obtain ⟨δa, hδa, hemp⟩ := hcon a ha
      filter_upwards [Ioo_mem_nhdsGT hδa] with δ hδ
      refine Set.disjoint_left.mpr fun z hz hza => ?_
      have : z ∈ germ p θ s δa ∩ a.carrier := ⟨germ_mono hδ.2.le hz, hza⟩
      rw [hemp] at this
      exact this
    obtain ⟨a, ⟨haF, hane, hring⟩, hhit⟩ := hex
    obtain ⟨θ₀, θ₁, rfl⟩ := hring
    obtain ⟨-, hlt, hle⟩ := F.nondegenerate _ haF
    rw [carrier_circ_unit] at hhit
    have hclosed : IsClosed (ringArc p θ₀ θ₁) := by
      rw [← carrier_circ_unit]; exact Arc.isClosed_carrier _
    have hymem : y ∈ ringArc p θ₀ θ₁ := by
      refine hclosed.closure_subset_iff.mpr subset_rfl ?_
      rw [Metric.mem_closure_iff]
      intro ε' hε'
      obtain ⟨z, hzg, hza⟩ := hhit ε' hε'
      exact ⟨z, hza, by rw [dist_comm]; exact dist_lt_of_mem_germ hzg⟩
    obtain ⟨δ₁, ⟨⟨hδN, hδs⟩, hδp⟩⟩ := (((hgermN.and hsmall).and hpos)).exists
    obtain ⟨δ', hδ'0, hδ'le, hsub⟩ := exists_germ_subset_ringArc hlt hle s hymem hhit hδp
    have hN' : ∀ n ∈ N, n ∉ germ p θ s δ' := fun n hn h => hδN n hn (germ_mono hδ'le h)
    have hδ'ε : δ' < ε / 2 := lt_of_le_of_lt hδ'le hδs
    obtain ⟨θ₁', θ₂', hlt', hIcc, hIoo⟩ : ∃ θ₁' θ₂' : ℝ, θ₁' < θ₂' ∧
        (∀ φ, φ ∈ Icc θ₁' θ₂' ↔ ∃ u ∈ Icc 0 δ', φ = θ + s.sign * u) ∧
        (∀ φ, φ ∈ Ioo θ₁' θ₂' ↔ ∃ u ∈ Ioo 0 δ', φ = θ + s.sign * u) := by
      cases s
      · refine ⟨θ - δ', θ, by linarith, fun φ => ?_, fun φ => ?_⟩
        · simp only [Side.sign]
          constructor
          · intro h; exact ⟨θ - φ, ⟨by linarith [h.2], by linarith [h.1]⟩, by ring⟩
          · rintro ⟨u, hu, rfl⟩; exact ⟨by linarith [hu.2], by linarith [hu.1]⟩
        · simp only [Side.sign]
          constructor
          · intro h; exact ⟨θ - φ, ⟨by linarith [h.2], by linarith [h.1]⟩, by ring⟩
          · rintro ⟨u, hu, rfl⟩; exact ⟨by linarith [hu.2], by linarith [hu.1]⟩
      · refine ⟨θ, θ + δ', by linarith, fun φ => ?_, fun φ => ?_⟩
        · simp only [Side.sign]
          constructor
          · intro h; exact ⟨φ - θ, ⟨by linarith [h.1], by linarith [h.2]⟩, by ring⟩
          · rintro ⟨u, hu, rfl⟩; exact ⟨by linarith [hu.1], by linarith [hu.2]⟩
        · simp only [Side.sign]
          constructor
          · intro h; exact ⟨φ - θ, ⟨by linarith [h.1], by linarith [h.2]⟩, by ring⟩
          · rintro ⟨u, hu, rfl⟩; exact ⟨by linarith [hu.1], by linarith [hu.2]⟩
    have hGermIn : GermIn p θ s (ringArc p θ₁' θ₂') :=
      ⟨δ', hδ'0, fun z ⟨t, ht, hz⟩ => ⟨θ + s.sign * t, (hIcc _).2 ⟨t, ⟨ht.1.le, ht.2.le⟩, rfl⟩, hz⟩⟩
    have hΓ : ringArc p θ₁' θ₂' ⊆ F.Γ := by
      rintro _ ⟨φ, hφ, rfl⟩
      obtain ⟨u, hu, rfl⟩ := (hIcc φ).1 hφ
      have hball : ringPt p (θ + s.sign * u) ∈ ball y ε := by
        rw [mem_ball]
        have h2 : dist (ringPt p (θ + s.sign * u)) y ≤ u := dist_ringPt_side_le p θ s hu.1
        linarith [hu.2]
      refine ⟨hdomε hball, mem_iUnion₂.mpr ⟨Arc.circ p 1 θ₀ θ₁, haF, ?_⟩⟩
      rw [carrier_circ_unit]
      have hcl : ringPt p (θ + s.sign * u) ∈ closure (germ p θ s δ') := by
        have hc : Continuous fun t : ℝ => ringPt p (θ + s.sign * t) := by unfold ringPt e; fun_prop
        have hu' : u ∈ closure (Ioo (0 : ℝ) δ') := by rw [closure_Ioo hδ'0.ne]; exact hu
        exact map_mem_closure (f := fun t : ℝ => ringPt p (θ + s.sign * t)) hc hu' (mapsTo_image _ _)
      exact hclosed.closure_subset_iff.mpr hsub hcl
    have hloc : ∀ φ ∈ Ioo θ₁' θ₂', ∃ κ > 0, ∃ c c' : Fin k, ∀ φ' ∈ Ioo (φ - κ) (φ + κ),
        F.innerColours p (ringPt p φ') = {c} ∧ F.outerColours p (ringPt p φ') = {c'} := by
      intro φ hφ
      obtain ⟨u, hu, rfl⟩ := (hIoo φ).1 hφ
      have hzg : ringPt p (θ + s.sign * u) ∈ germ p θ s δ' := ⟨u, hu, rfl⟩
      have hzb : ringPt p (θ + s.sign * u) ∈ ball y ε := by
        rw [mem_ball]
        have h2 : dist (ringPt p (θ + s.sign * u)) y < δ' := dist_lt_of_mem_germ hzg
        linarith
      have hxn : ∀ a' ∈ F.arcs, ¬ a'.OnRing p → ringPt p (θ + s.sign * u) ∉ a'.carrier := by
        intro a' ha' hr hza
        exact hN' _ (mem_iUnion₂.mpr ⟨a', ⟨ha', ⟨_, hza, hzb⟩, hr⟩, hza, ringPt_mem_sphere _ _⟩) hzg
      obtain ⟨r0, hr0, hrb, hring'⟩ := F.exists_ball_onRing p hfin hzb hxn
      exact F.exists_sides_nbhd p hr0 (hrb.trans hdomε) hring'
    obtain ⟨c, c', hcc⟩ := F.sides_const p isPreconnected_Ioo
      ⟨(θ₁' + θ₂') / 2, by constructor <;> linarith⟩ hloc
    exact ⟨θ₁', θ₂', c, c', ⟨hlt', hΓ, fun φ hφ => hcc φ hφ⟩, hGermIn⟩


/-! ## Interval cones in a simple map -/

section Simple

variable {F}

/-- **In a simple map each tile's cone at a point of its closure is one closed angular interval** (possibly a single
direction, a cusp, or every direction): near the point the tile's boundary is a Jordan curve with exactly two branches,
each a segment or a circular arc, and the tile is the sector between them. -/
theorem Simple.coneAt_eq_angleIcc (hS : F.Simple) {T : Set ℂ} (hT : F.IsTile T) {x : ℂ} (hxd : x ∈ F.dom)
    (hx : x ∈ closure T) :
    ∃ β₁ β₂, β₁ ≤ β₂ ∧ β₂ ≤ β₁ + 2 * π ∧ coneAt T x = angleIcc β₁ β₂ := by
  sorry

end Simple

end ArcMap

end HadwigerNelson.Plane
