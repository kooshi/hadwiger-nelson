import Proofs.HadwigerNelson.Plane.Chord

/-!
# Unit-speed curves of curvature at most 1 (FS-131 wave 6; the curve notion of FS131-E8's bridge)

One curve notion for the bridge's rows and for the ladder (`plans/FS131-w6-kernel-plan.md` § 11): a map `γ : ℝ → ℂ`
on an interval `I` with `γ' = e ∘ ψ`, the **tangent angle** `ψ` being 1-Lipschitz — unit speed, and curvature at most
`1` in the only form the arguments read (`|ψ s − ψ u| ≤ |s − u|`; no second derivative). Mathlib has no home for it.

* `IsUnitCurve γ ψ I`; inhabitant `isUnitCurve_segment`.
* The three inequalities of `plans/FS131-E8-derivation.md` §§ 3.2–3.3 and the comparison with the tangent unit discs:
  `IsUnitCurve.chord` (C1), `IsUnitCurve.sin_le_inner` (C2), `IsUnitCurve.norm_sub_le` (the `s²/2` bound),
  `IsUnitCurve.one_le_dist` (the lens: the curve stays outside the two open unit discs tangent to it at its start).
* `norm_sub_le_of_discs` (**proved**): unit normals at two points whose opposite unit discs do not overlap differ by
  at most the distance of the points — the normal of a two-sided unit-disc condition is 1-Lipschitz, with the sharp
  constant and no second derivative; `lipschitzOnWith_of_chord` turns the chordal bound into the angle's.
* `IsUnitCurve.sin_add_sin_le`: the one inequality `chord` and `sin_le_inner` are cases of, for length at most `π`.
  `isUnitCurve_circle`: the unit circle, where the three are equalities.

**No integral is taken**: each inequality is the monotonicity of one real function whose derivative has a sign.

No measure and no colouring is read in this module.
-/

namespace HadwigerNelson.Plane

open Complex Set Filter Topology Metric

/-- A **unit-speed curve of curvature at most 1** on `I`: `γ` has derivative `e (ψ s)` at every `s ∈ I`, and the
tangent angle `ψ` is 1-Lipschitz on `I`. -/
structure IsUnitCurve (γ : ℝ → ℂ) (ψ : ℝ → ℝ) (I : Set ℝ) : Prop where
  /-- The unit tangent at `s` is `e (ψ s)`. -/
  hasDeriv : ∀ s ∈ I, HasDerivWithinAt γ (e (ψ s)) I s
  /-- The tangent angle is 1-Lipschitz in arclength. -/
  lip : LipschitzOnWith 1 ψ I

/-- **Inhabitant**: the segment `s ↦ s`, of tangent angle `0`. -/
theorem isUnitCurve_segment (I : Set ℝ) : IsUnitCurve (fun s : ℝ => (s : ℂ)) (fun _ => 0) I :=
  ⟨fun s _ => by simpa [e] using (hasDerivWithinAt_id s I).ofReal_comp,
    ((LipschitzWith.const (0 : ℝ)).weaken zero_le_one).lipschitzOnWith⟩

/-- A unit-speed curve restricted to a smaller set. -/
theorem IsUnitCurve.mono {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {I J : Set ℝ} (h : IsUnitCurve γ ψ I) (hJ : J ⊆ I) :
    IsUnitCurve γ ψ J :=
  ⟨fun s hs => (h.hasDeriv s (hJ hs)).mono hJ, h.lip.mono hJ⟩

/-! ## The derivatives the inequalities read (FS131-I6C)

Each inequality below is the monotonicity of one real function on `[0, ℓ]` whose derivative has a sign: no integral is
taken, and the derivative is read on the open interval only. -/

/-- The component of `γ − p` along a fixed vector `c`, differentiated along the curve. -/
theorem IsUnitCurve.hasDerivWithinAt_re_mul {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {J : Set ℝ} (h : IsUnitCurve γ ψ J) (p c : ℂ)
    {u : ℝ} (hu : u ∈ J) : HasDerivWithinAt (fun u => ((γ u - p) * c).re) ((e (ψ u) * c).re) J u :=
  Complex.reCLM.hasFDerivAt.comp_hasDerivWithinAt u (((h.hasDeriv u hu).sub_const p).mul_const c)

/-- The squared distance to a fixed point `p`, differentiated along the curve: twice the inner product of `γ u − p`
with the tangent. -/
theorem IsUnitCurve.hasDerivWithinAt_norm_sq {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {J : Set ℝ} (h : IsUnitCurve γ ψ J) (p : ℂ)
    {u : ℝ} (hu : u ∈ J) :
    HasDerivWithinAt (fun u => ‖γ u - p‖ ^ 2) (2 * ((γ u - p) * (starRingEnd ℂ) (e (ψ u))).re) J u := by
  have h0 := (h.hasDeriv u hu).sub_const p
  have h1 : HasDerivWithinAt (fun u => (γ u - p).re) (e (ψ u)).re J u :=
    Complex.reCLM.hasFDerivAt.comp_hasDerivWithinAt u h0
  have h2 : HasDerivWithinAt (fun u => (γ u - p).im) (e (ψ u)).im J u :=
    Complex.imCLM.hasFDerivAt.comp_hasDerivWithinAt u h0
  have hfun : (fun u => ‖γ u - p‖ ^ 2) = fun u => (γ u - p).re ^ 2 + (γ u - p).im ^ 2 :=
    funext fun u => sq_norm_eq _
  rw [hfun]
  refine ((h1.pow 2).add (h2.pow 2)).congr_deriv ?_
  simp only [Complex.mul_re, Complex.conj_re, Complex.conj_im]
  norm_num
  ring

/-- The tangent angle moves at most as far as the parameter. -/
theorem IsUnitCurve.abs_sub_le {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {J : Set ℝ} (h : IsUnitCurve γ ψ J) {u v : ℝ} (hu : u ∈ J)
    (hv : v ∈ J) : |ψ u - ψ v| ≤ |u - v| := by
  have := h.lip.dist_le_mul u hu v hv
  simpa [Real.dist_eq] using this

/-- **One inequality for the chord bound and for the growth of the distance** (FS131-E8 §§ 3.2 (1), 3.3): along the
tangent at any parameter `u₀`, a curve of length `ℓ ≤ π` advances from its start to `s` by at least
`sin (s − u₀) + sin u₀` — the integral of `cos (u − u₀)` over `[0, s]`. At `u₀ = 0` it is `IsUnitCurve.chord`, at
`u₀ = s` it is `IsUnitCurve.sin_le_inner`. -/
theorem IsUnitCurve.sin_add_sin_le {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {ℓ : ℝ} (h : IsUnitCurve γ ψ (Icc 0 ℓ))
    (hℓ : ℓ ≤ Real.pi) {u₀ s : ℝ} (hu₀ : u₀ ∈ Icc 0 ℓ) (hs : s ∈ Icc 0 ℓ) :
    Real.sin (s - u₀) + Real.sin u₀ ≤ ((γ s - γ 0) * (starRingEnd ℂ) (e (ψ u₀))).re := by
  have hderiv : ∀ u ∈ Icc 0 ℓ, HasDerivWithinAt
      (fun u => ((γ u - γ 0) * (starRingEnd ℂ) (e (ψ u₀))).re - Real.sin (u - u₀))
      ((e (ψ u) * (starRingEnd ℂ) (e (ψ u₀))).re - Real.cos (u - u₀)) (Icc 0 ℓ) u := by
    intro u hu
    have h1 := h.hasDerivWithinAt_re_mul (γ 0) ((starRingEnd ℂ) (e (ψ u₀))) hu
    have h2 : HasDerivAt (fun u => Real.sin (u - u₀)) (Real.cos (u - u₀)) u := by
      simpa using ((hasDerivAt_id u).sub_const u₀).sin
    exact h1.sub h2.hasDerivWithinAt
  have hmono : MonotoneOn (fun u => ((γ u - γ 0) * (starRingEnd ℂ) (e (ψ u₀))).re - Real.sin (u - u₀))
      (Icc 0 ℓ) := by
    refine monotoneOn_of_hasDerivWithinAt_nonneg
      (f' := fun u => (e (ψ u) * (starRingEnd ℂ) (e (ψ u₀))).re - Real.cos (u - u₀)) (convex_Icc 0 ℓ)
      (fun u hu => (hderiv u hu).continuousWithinAt) (fun u hu => ?_) (fun u hu => ?_)
    · exact (hderiv u (interior_subset hu)).mono interior_subset
    · have hu' : u ∈ Icc 0 ℓ := interior_subset hu
      rw [conj_e, ← e_add, re_e, ← sub_eq_add_neg, sub_nonneg, ← Real.cos_abs (u - u₀),
        ← Real.cos_abs (ψ u - ψ u₀)]
      refine Real.cos_le_cos_of_nonneg_of_le_pi (abs_nonneg _) ?_ (h.abs_sub_le hu' hu₀)
      rw [abs_sub_le_iff]
      constructor <;> linarith [hu'.1, hu'.2, hu₀.1, hu₀.2]
  have := hmono (left_mem_Icc.2 (hs.1.trans hs.2)) hs hs.1
  simp only [sub_self, zero_mul, Complex.zero_re, zero_sub, Real.sin_neg, sub_neg_eq_add] at this
  linarith

/-- **The chord bound** (FS131-E8 § 3.2 (1), control `e8-chord` C1): along its initial tangent a curve of length
`ℓ ≤ π/2` advances at least `sin ℓ`. -/
theorem IsUnitCurve.chord {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {ℓ : ℝ} (h : IsUnitCurve γ ψ (Icc 0 ℓ)) (hℓ0 : 0 ≤ ℓ)
    (hℓ : ℓ ≤ Real.pi / 2) : Real.sin ℓ ≤ ((γ ℓ - γ 0) * (starRingEnd ℂ) (e (ψ 0))).re := by
  have := h.sin_add_sin_le (by linarith [Real.pi_pos]) (left_mem_Icc.2 hℓ0) (right_mem_Icc.2 hℓ0)
  simpa using this

/-- **The distance from the start increases** (FS131-E8 § 3.3, control `e8-chord` C2): for `s ≤ π/2` the chord from
the start makes with the tangent at `s` an inner product at least `sin s` — so `|γ s − γ 0|²` has derivative at least
`2 sin s`. -/
theorem IsUnitCurve.sin_le_inner {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {ℓ : ℝ} (h : IsUnitCurve γ ψ (Icc 0 ℓ))
    (hℓ : ℓ ≤ Real.pi / 2) {s : ℝ} (hs : s ∈ Icc 0 ℓ) :
    Real.sin s ≤ ((γ s - γ 0) * (starRingEnd ℂ) (e (ψ s))).re := by
  have := h.sin_add_sin_le (by linarith [Real.pi_pos]) hs hs
  simpa using this

/-- The distance from the start is strictly increasing along a curve of length at most `π/2`. -/
theorem IsUnitCurve.strictMonoOn_dist {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {ℓ : ℝ} (h : IsUnitCurve γ ψ (Icc 0 ℓ))
    (hℓ : ℓ ≤ Real.pi / 2) : StrictMonoOn (fun s => dist (γ s) (γ 0)) (Icc 0 ℓ) := by
  have hsq : StrictMonoOn (fun s => ‖γ s - γ 0‖ ^ 2) (Icc 0 ℓ) := by
    refine strictMonoOn_of_hasDerivWithinAt_pos (convex_Icc 0 ℓ)
      (fun u hu => (h.hasDerivWithinAt_norm_sq (γ 0) hu).continuousWithinAt)
      (fun u hu => (h.hasDerivWithinAt_norm_sq (γ 0) (interior_subset hu)).mono interior_subset) (fun u hu => ?_)
    have hu' : u ∈ Ioo 0 ℓ := by rwa [interior_Icc] at hu
    have h1 := h.sin_le_inner hℓ (Ioo_subset_Icc_self hu')
    have h2 : 0 < Real.sin u := Real.sin_pos_of_pos_of_lt_pi hu'.1 (by linarith [hu'.2, Real.pi_pos])
    linarith
  intro a ha b hb hab
  have := hsq ha hb hab
  simp only [dist_eq_norm]
  exact lt_of_pow_lt_pow_left₀ 2 (norm_nonneg _) this

/-- The curve leaves its initial tangent line at most quadratically (FS131-E8 § 3.3). -/
theorem IsUnitCurve.norm_sub_le {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {ℓ : ℝ} (h : IsUnitCurve γ ψ (Icc 0 ℓ)) {s : ℝ}
    (hs : s ∈ Icc 0 ℓ) : ‖γ s - γ 0 - (s : ℂ) * e (ψ 0)‖ ≤ s ^ 2 / 2 := by
  have hz : (0 : ℝ) ∈ Icc 0 ℓ := left_mem_Icc.2 (hs.1.trans hs.2)
  have hsub : Icc 0 s ⊆ Icc 0 ℓ := Icc_subset_Icc le_rfl hs.2
  have hlin : ∀ x : ℝ, HasDerivAt (fun u : ℝ => (u : ℂ) * e (ψ 0)) (e (ψ 0)) x := fun x => by
    simpa using (hasDerivAt_id x).ofReal_comp.mul_const (e (ψ 0))
  have hd : ∀ x ∈ Icc 0 ℓ, HasDerivWithinAt (fun u => γ u - γ 0 - (u : ℂ) * e (ψ 0)) (e (ψ x) - e (ψ 0))
      (Icc 0 ℓ) x := fun x hx => ((h.hasDeriv x hx).sub_const (γ 0)).sub (hlin x).hasDerivWithinAt
  have key := image_norm_le_of_norm_deriv_right_le_deriv_boundary
    (f := fun u => γ u - γ 0 - (u : ℂ) * e (ψ 0)) (f' := fun u => e (ψ u) - e (ψ 0)) (a := 0) (b := s)
    (B := fun u => u ^ 2 / 2) (B' := fun u => u)
    (fun x hx => ((hd x (hsub hx)).continuousWithinAt).mono hsub)
    (fun x hx => (hd x (hsub (Ico_subset_Icc_self hx))).mono_of_mem_nhdsWithin
      (mem_of_superset (Icc_mem_nhdsGE (hx.2.trans_le hs.2)) (Icc_subset_Icc hx.1 le_rfl)))
    (by simp)
    (fun x => by
      exact ((hasDerivAt_pow 2 x).div_const 2).congr_deriv (by norm_num))
    (fun x hx => by
      have h1 := norm_e_sub_e_le (ψ x) (ψ 0)
      have h2 := h.abs_sub_le (hsub (Ico_subset_Icc_self hx)) hz
      rw [sub_zero, abs_of_nonneg hx.1] at h2
      exact h1.trans h2)
  exact key (right_mem_Icc.2 hs.1)

/-- The lens bound for one of the two discs, `σ = ±1`: `‖γ s − γ 0 − σ i e(ψ 0)‖²` is non-decreasing from `1`. -/
theorem IsUnitCurve.one_le_dist_of_sign {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {ℓ : ℝ} (h : IsUnitCurve γ ψ (Icc 0 ℓ))
    (hℓ : ℓ ≤ Real.pi / 2) {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) {s : ℝ} (hs : s ∈ Icc 0 ℓ) :
    1 ≤ dist (γ s) (γ 0 + (σ : ℂ) * (I * e (ψ 0))) := by
  have hz : (0 : ℝ) ∈ Icc 0 ℓ := left_mem_Icc.2 (hs.1.trans hs.2)
  have hmono : MonotoneOn (fun u => ‖γ u - (γ 0 + (σ : ℂ) * (I * e (ψ 0)))‖ ^ 2) (Icc 0 ℓ) := by
    refine monotoneOn_of_hasDerivWithinAt_nonneg (convex_Icc 0 ℓ)
      (fun u hu => (h.hasDerivWithinAt_norm_sq _ hu).continuousWithinAt)
      (fun u hu => (h.hasDerivWithinAt_norm_sq _ (interior_subset hu)).mono interior_subset) (fun u hu => ?_)
    have hu' : u ∈ Icc 0 ℓ := interior_subset hu
    have h1 := h.sin_le_inner hℓ hu'
    have h2 := h.abs_sub_le hu' hz
    rw [sub_zero, abs_of_nonneg hu'.1, abs_le] at h2
    have h3 : Real.sin (ψ u - ψ 0) ≤ Real.sin u :=
      Real.sin_le_sin_of_le_of_le_pi_div_two (by linarith [hu'.2, h2.1]) (by linarith [hu'.2]) h2.2
    have h4 : -Real.sin u ≤ Real.sin (ψ u - ψ 0) := by
      rw [← Real.sin_neg]
      exact Real.sin_le_sin_of_le_of_le_pi_div_two (by linarith [hu'.2]) (by linarith [hu'.2, h2.2]) h2.1
    have h5 : ((σ : ℂ) * (I * e (ψ 0)) * (starRingEnd ℂ) (e (ψ u))).re = σ * Real.sin (ψ u - ψ 0) := by
      rw [mul_assoc, mul_assoc, conj_e, ← e_add, Complex.re_ofReal_mul, Complex.I_mul_re, im_e,
        show ψ 0 + -ψ u = -(ψ u - ψ 0) by ring, Real.sin_neg, neg_neg]
    have h6 : ((γ u - (γ 0 + (σ : ℂ) * (I * e (ψ 0)))) * (starRingEnd ℂ) (e (ψ u))).re =
        ((γ u - γ 0) * (starRingEnd ℂ) (e (ψ u))).re - σ * Real.sin (ψ u - ψ 0) := by
      rw [← h5, ← Complex.sub_re]; ring_nf
    rw [h6]
    rcases hσ with rfl | rfl <;> linarith
  have h0 := hmono hz hs hs.1
  have h1 : ‖γ 0 - (γ 0 + (σ : ℂ) * (I * e (ψ 0)))‖ ^ 2 = 1 := by
    rw [sub_add_cancel_left, norm_neg, norm_mul, norm_mul, Complex.norm_I, norm_e, Complex.norm_real,
      Real.norm_eq_abs]
    rcases hσ with rfl | rfl <;> simp
  simp only [h1] at h0
  rw [dist_eq_norm]
  by_contra hlt
  rw [not_le] at hlt
  nlinarith [norm_nonneg (γ s - (γ 0 + (σ : ℂ) * (I * e (ψ 0))))]

/-- **The lens bound**: a curve of length at most `π/2` stays outside the two open unit discs tangent to it at its
start (the comparison FS121-V2-SECTOR makes with a unit circle; the planner's three lines from `sin_le_inner`, for the
deriver's check: `(d/ds)(|γ s − γ 0 ∓ i e(ψ 0)|²) = 2⟨γ s − γ 0, T s⟩ ∓ 2 sin (ψ s − ψ 0) ≥ 2 sin s − 2 sin s`). -/
theorem IsUnitCurve.one_le_dist {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {ℓ : ℝ} (h : IsUnitCurve γ ψ (Icc 0 ℓ))
    (hℓ : ℓ ≤ Real.pi / 2) {s : ℝ} (hs : s ∈ Icc 0 ℓ) :
    1 ≤ dist (γ s) (γ 0 + I * e (ψ 0)) ∧ 1 ≤ dist (γ s) (γ 0 - I * e (ψ 0)) := by
  have h1 := h.one_le_dist_of_sign hℓ (Or.inl rfl) hs
  have h2 := h.one_le_dist_of_sign hℓ (Or.inr rfl) hs
  refine ⟨by simpa using h1, ?_⟩
  rw [sub_eq_add_neg]
  simpa using h2

/-! ## Sharpness: the unit circle -/

/-- **The unit circle** `s ↦ e s`, of tangent angle `s + π/2`, is a unit-speed curve of curvature `1`: the curve on
which `chord`, `sin_le_inner` and the first half of `one_le_dist` are equalities. -/
theorem isUnitCurve_circle (J : Set ℝ) : IsUnitCurve e (fun s => s + Real.pi / 2) J := by
  refine ⟨fun s _ => ?_, ?_⟩
  · have h0 : HasDerivAt (fun θ : ℝ => (θ : ℂ) * I) (1 * I) s := (Complex.ofRealCLM.hasDerivAt).mul_const I
    have h1 : HasDerivAt (fun x : ℝ => cexp (x * I)) (e s * I) s := by
      refine h0.cexp.congr_deriv ?_
      simp [e]
    rw [e_add, e_pi_div_two]
    exact h1.hasDerivWithinAt
  · rw [lipschitzOnWith_iff_dist_le_mul]
    intro x _ y _
    simp [Real.dist_eq]

/-- Sharpness of `IsUnitCurve.chord` and `IsUnitCurve.sin_le_inner`: on the unit circle the advance along the tangent
at the start, and the inner product of the chord with the tangent at `s`, are both exactly `sin s`. -/
example (s : ℝ) : ((e s - e 0) * (starRingEnd ℂ) (e (0 + Real.pi / 2))).re = Real.sin s ∧
    ((e s - e 0) * (starRingEnd ℂ) (e (s + Real.pi / 2))).re = Real.sin s := by
  have h1 : (e s - e 0) * (starRingEnd ℂ) (e (0 + Real.pi / 2)) = (e s - 1) * -I := by
    rw [zero_add, e_pi_div_two, Complex.conj_I, e_eq 0]; simp
  have h2 : (e s - e 0) * (starRingEnd ℂ) (e (s + Real.pi / 2)) = (1 - e (-s)) * -I := by
    rw [e_add, e_pi_div_two, map_mul, Complex.conj_I, conj_e, e_eq 0]
    have h3 : e s * e (-s) = 1 := by rw [← e_add, add_neg_cancel, e_eq 0]; simp
    simp only [Real.cos_zero, Complex.ofReal_one, Real.sin_zero, Complex.ofReal_zero, zero_mul, add_zero]
    linear_combination (-I) * h3
  rw [h1, h2]
  constructor
  · simp [im_e]
  · simp [im_e]

/-- Sharpness of `IsUnitCurve.one_le_dist`: the unit circle stays at distance exactly `1` from the centre of one of
its two tangent discs at the start (`γ 0 + i e(ψ 0) = 0`). -/
example (s : ℝ) : dist (e s) (e 0 + I * e (0 + Real.pi / 2)) = 1 := by
  rw [zero_add, e_pi_div_two, e_eq 0]
  simp [dist_eq_norm]

/-- **The normal of a two-sided unit-disc condition is 1-Lipschitz**, sharp, by the parallelogram law: if the unit
disc about `x + νx` does not overlap the one about `y − νy`, nor the one about `x − νx` the one about `y + νy`, then
`‖νx − νy‖ ≤ ‖x − y‖`. (It replaces "curvature at most 1 where `g″` exists, and `ψ` absolutely continuous" in
FS131-E8 § 3.1 (4): no second derivative is taken.) -/
theorem norm_sub_le_of_discs {x y νx νy : ℂ} (hx : ‖νx‖ = 1) (hy : ‖νy‖ = 1)
    (h1 : 2 ≤ ‖(x + νx) - (y - νy)‖) (h2 : 2 ≤ ‖(x - νx) - (y + νy)‖) : ‖νx - νy‖ ≤ ‖x - y‖ := by
  have p1 := parallelogram_law_with_norm ℝ (x - y) (νx + νy)
  have p2 := parallelogram_law_with_norm ℝ νx νy
  have e1 : (x + νx) - (y - νy) = (x - y) + (νx + νy) := by ring
  have e2 : (x - νx) - (y + νy) = (x - y) - (νx + νy) := by ring
  rw [e1] at h1
  rw [e2] at h2
  rw [hx, hy] at p2
  have n1 := norm_nonneg (x - y + (νx + νy))
  have n2 := norm_nonneg (x - y - (νx + νy))
  have n3 := norm_nonneg (νx - νy)
  have n4 := norm_nonneg (x - y)
  by_contra hlt
  rw [not_le] at hlt
  nlinarith

/-- The chord of two unit vectors is at least `2 sin` of half the angle between them. -/
theorem two_sin_le_norm_e_sub_e (θ θ₀ : ℝ) : 2 * Real.sin ((θ - θ₀) / 2) ≤ ‖e θ - e θ₀‖ := by
  have h := ringPt_sub_ringPt 0 θ₀ θ
  simp only [ringPt, zero_add] at h
  rw [h, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs]
  exact le_abs_self _

/-- A small positive angle `θ` whose chord is at most `d` is below `r d`, for `r > 1` and `θ ≤ (r − 1)/r`
(`sin t > t − t³/6`). -/
theorem lt_mul_of_two_sin_le {θ d r : ℝ} (hθ0 : 0 < θ) (hr : 1 < r) (hθr : θ * r ≤ r - 1)
    (hd : 2 * Real.sin (θ / 2) ≤ d) : θ < r * d := by
  have h1 := Real.sin_gt_sub_cube (half_pos hθ0)
  have h2 : θ - θ ^ 3 / 24 < d := by nlinarith
  have hθ1 : θ ≤ 1 := by nlinarith
  have h3 : θ ^ 2 * r ≤ r - 1 := by nlinarith
  nlinarith [mul_pos hθ0 (sub_pos.2 hr)]

/-- One half of `lipschitzOnWith_of_chord`: the angle grows at most as fast as the parameter. The right slopes of `ψ`
are eventually below every `r > 1` (the chord controls a small angle up to the factor `r`), and Mathlib's comparison
for a continuous function with such slopes gives the bound — no subdivision and no limit of `n · 2 arcsin (d/2n)`. -/
theorem le_add_of_chord {ψ : ℝ → ℝ} {J : Set ℝ} (hJ : J.OrdConnected) (hc : ContinuousOn ψ J)
    (h : ∀ s ∈ J, ∀ u ∈ J, ‖e (ψ s) - e (ψ u)‖ ≤ |s - u|) {u s : ℝ} (hu : u ∈ J) (hs : s ∈ J) (hus : u ≤ s) :
    ψ s ≤ ψ u + (s - u) := by
  have hsub : Icc u s ⊆ J := hJ.out hu hs
  refine image_le_of_liminf_slope_right_le_deriv_boundary (f := ψ) (a := u) (b := s)
    (B := fun x => ψ u + (x - u)) (B' := fun _ => 1) (hc.mono hsub) (by simp)
    (by fun_prop) (fun x _ => ?_) (fun x hx r hr => ?_) (right_mem_Icc.2 hus)
  · simpa using (((hasDerivAt_id x).sub_const u).const_add (ψ u)).hasDerivWithinAt
  · have hxJ : x ∈ J := hsub (Ico_subset_Icc_self hx)
    have hη : 0 < (r - 1) / r := div_pos (sub_pos.2 hr) (by linarith)
    have hcont : Tendsto ψ (𝓝[>] x) (𝓝 (ψ x)) := by
      rw [← nhdsWithin_Ioc_eq_nhdsGT hx.2]
      exact (hc x hxJ).mono fun z hz => hsub ⟨hx.1.trans hz.1.le, hz.2⟩
    refine Eventually.frequently ?_
    filter_upwards [Ioc_mem_nhdsGT hx.2, Metric.tendsto_nhds.1 hcont _ hη] with z hz hzη
    have hzJ : z ∈ J := hsub ⟨hx.1.trans hz.1.le, hz.2⟩
    have hd : 0 < z - x := sub_pos.2 hz.1
    rw [slope_def_field, div_lt_iff₀ hd]
    have hch := h z hzJ x hxJ
    rw [abs_of_pos hd] at hch
    rcases le_or_gt (ψ z - ψ x) 0 with hle | hpos
    · exact lt_of_le_of_lt hle (mul_pos (by linarith) hd)
    · rw [Real.dist_eq, abs_of_pos hpos, lt_div_iff₀ (by linarith : (0 : ℝ) < r)] at hzη
      exact lt_mul_of_two_sin_le hpos hr hzη.le ((two_sin_le_norm_e_sub_e _ _).trans hch)

/-- A continuous angle whose unit vectors are 1-Lipschitz in the chord is 1-Lipschitz (`le_add_of_chord` for `ψ` and
for `−ψ`: the right slopes are eventually below every `r > 1`). -/
theorem lipschitzOnWith_of_chord {ψ : ℝ → ℝ} {I : Set ℝ} (hI : I.OrdConnected) (hc : ContinuousOn ψ I)
    (h : ∀ s ∈ I, ∀ u ∈ I, ‖e (ψ s) - e (ψ u)‖ ≤ |s - u|) : LipschitzOnWith 1 ψ I := by
  have hneg : ∀ s ∈ I, ∀ u ∈ I, ‖e (-ψ s) - e (-ψ u)‖ ≤ |s - u| := fun s hs u hu => by
    rw [← conj_e, ← conj_e, ← map_sub, RCLike.norm_conj]
    exact h s hs u hu
  have key : ∀ u ∈ I, ∀ s ∈ I, u ≤ s → |ψ u - ψ s| ≤ |u - s| := fun u hu s hs hus => by
    have h1 := le_add_of_chord hI hc h hu hs hus
    have h2 := le_add_of_chord (ψ := fun t => -ψ t) hI hc.neg hneg hu hs hus
    rw [abs_le, abs_of_nonpos (sub_nonpos.2 hus)]
    constructor <;> linarith
  rw [lipschitzOnWith_iff_dist_le_mul]
  intro x hx y hy
  rw [Real.dist_eq, Real.dist_eq, NNReal.coe_one, one_mul]
  rcases le_total x y with hxy | hxy
  · exact key x hx y hy hxy
  · rw [abs_sub_comm (ψ x), abs_sub_comm x]
    exact key y hy x hx hxy

end HadwigerNelson.Plane
