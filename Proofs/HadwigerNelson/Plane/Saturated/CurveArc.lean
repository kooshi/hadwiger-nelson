import Proofs.HadwigerNelson.Plane.Saturated.Curve
import Proofs.HadwigerNelson.Plane.Saturated.Fan

/-!
# Unit-speed curves: reparametrization, the chord on any interval, the polar graph (FS-131 wave 6, FS131-I6D)

Helpers for `Plane/Saturated/FanBridge`'s existence half (`plans/FS131-I6D-implementation.md`), with no colouring and
no measure:

* `IsUnitCurve.affine` — a unit-speed curve run from another origin, forward or backward, is one;
  `IsUnitCurve.sin_abs_le_dist`, `IsUnitCurve.dist_le` — the chord bound and its converse between any two parameters
  (so a curve of length at most `π/2` is injective, with a Lipschitz inverse).
* `angleCurve y θ` — the curve `y + ∫₀ˢ e ∘ θ` with a given 1-Lipschitz tangent angle; a unit-speed curve on an
  interval is the restriction of one (`IsUnitCurve.eqOn_angleCurve`).
* `eq_affine_of_sin_bounds` — a map of an interval that distorts distances by at most a sine is `±s + c`;
  `IsUnitCurve.reparam` — a unit-speed curve inside the image of another is the other, up to `±s + c`.
* `IsUnitCurve.exists_polar_angle` — **FS131-E8-BETA**'s curve part (the proof of `IsUnitCurve.exists_polarGraph`).

Inhabitant of every hypothesis `IsUnitCurve γ ψ I` here: `isUnitCurve_segment` (`Plane/Saturated/Curve`).
-/

namespace HadwigerNelson.Plane

open Complex Set Filter Topology Metric

namespace IsUnitCurve

variable {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {I : Set ℝ}

/-- A unit-speed curve is continuous. -/
theorem continuousOn (h : IsUnitCurve γ ψ I) : ContinuousOn γ I :=
  fun s hs => (h.hasDeriv s hs).continuousWithinAt

/-- The tangent angle is 1-Lipschitz, in absolute values. -/
theorem abs_angle_sub_le (h : IsUnitCurve γ ψ I) {s u : ℝ} (hs : s ∈ I) (hu : u ∈ I) : |ψ s - ψ u| ≤ |s - u| := by
  have := h.lip.dist_le_mul _ hs _ hu
  simpa [Real.dist_eq] using this

/-- **A unit-speed curve run from another origin, forward (`ε = 1`, `κ = 0`) or backward (`ε = -1`, `κ = ±π`).** -/
theorem affine (h : IsUnitCurve γ ψ I) {ε : ℝ} (hε : ε = 1 ∨ ε = -1) (a κ : ℝ) (hκ : e κ = (ε : ℂ)) :
    IsUnitCurve (fun s => γ (ε * s + a)) (fun s => ψ (ε * s + a) + κ) {s | ε * s + a ∈ I} := by
  refine ⟨fun s hs => ?_, LipschitzOnWith.of_dist_le_mul fun s hs u hu => ?_⟩
  · have h1 := h.hasDeriv (ε * s + a) hs
    have h2 : HasDerivWithinAt (fun s : ℝ => ε * s + a) ε {s | ε * s + a ∈ I} s := by
      simpa using ((hasDerivWithinAt_id s {s | ε * s + a ∈ I}).const_mul ε).add_const a
    have h3 := h1.scomp s h2 (fun x hx => hx)
    have h4 : ε • e (ψ (ε * s + a)) = e (ψ (ε * s + a) + κ) := by
      rw [e_add, hκ, Complex.real_smul, mul_comm]
    rw [← h4]
    exact h3
  · have h1 := h.abs_angle_sub_le hs hu
    have e2 : |ε * s + a - (ε * u + a)| = |s - u| := by
      rcases hε with rfl | rfl
      · congr 1; ring
      · rw [show (-1 : ℝ) * s + a - (-1 * u + a) = -(s - u) by ring, abs_neg]
    rw [NNReal.coe_one, one_mul, Real.dist_eq, Real.dist_eq,
      show ψ (ε * s + a) + κ - (ψ (ε * u + a) + κ) = ψ (ε * s + a) - ψ (ε * u + a) by ring, ← e2]
    exact h1

/-- **The chord bound between any two parameters** at most `π/2` apart. -/
theorem sin_le_dist (h : IsUnitCurve γ ψ I) (hI : I.OrdConnected) {u s : ℝ} (hu : u ∈ I) (hs : s ∈ I)
    (hus : u ≤ s) (hlen : s - u ≤ Real.pi / 2) : Real.sin (s - u) ≤ dist (γ s) (γ u) := by
  have h' := (h.affine (Or.inl rfl) u 0 (by simp [e])).mono (J := Icc 0 (s - u))
    (fun t ht => hI.out hu hs ⟨by linarith [ht.1], by linarith [ht.2]⟩)
  have hc := h'.chord (sub_nonneg.2 hus) hlen
  have hre := Complex.re_le_norm
    ((γ (1 * (s - u) + u) - γ (1 * 0 + u)) * (starRingEnd ℂ) (e (ψ (1 * 0 + u) + 0)))
  rw [norm_mul, RCLike.norm_conj, norm_e, mul_one] at hre
  have e1 : (1 : ℝ) * (s - u) + u = s := by ring
  have e2 : (1 : ℝ) * 0 + u = u := by ring
  rw [e1, e2] at hre hc
  rw [dist_eq_norm]
  exact hc.trans hre

/-- The chord bound, symmetric form. -/
theorem sin_abs_le_dist (h : IsUnitCurve γ ψ I) (hI : I.OrdConnected) {u s : ℝ} (hu : u ∈ I) (hs : s ∈ I)
    (hlen : |s - u| ≤ Real.pi / 2) : Real.sin |s - u| ≤ dist (γ s) (γ u) := by
  rcases le_total u s with hus | hsu
  · rw [abs_of_nonneg (sub_nonneg.2 hus)] at hlen ⊢
    exact h.sin_le_dist hI hu hs hus hlen
  · rw [abs_sub_comm, abs_of_nonneg (sub_nonneg.2 hsu)] at hlen ⊢
    rw [dist_comm]
    exact h.sin_le_dist hI hs hu hsu hlen

/-- A unit-speed curve is 1-Lipschitz. -/
theorem dist_le (h : IsUnitCurve γ ψ I) (hI : I.OrdConnected) {u s : ℝ} (hu : u ∈ I) (hs : s ∈ I) :
    dist (γ s) (γ u) ≤ |s - u| := by
  have := Convex.norm_image_sub_le_of_norm_hasDerivWithin_le (f := γ) (f' := fun x => e (ψ x)) (s := I) (C := 1)
    h.hasDeriv (fun x _ => (norm_e _).le) hI.convex hu hs
  simpa [dist_eq_norm, Real.norm_eq_abs] using this

/-- A unit-speed curve whose parameters are at most `π/2` apart is injective. -/
theorem injOn_of_abs_le (h : IsUnitCurve γ ψ I) (hI : I.OrdConnected)
    (hlen : ∀ s ∈ I, ∀ u ∈ I, |s - u| ≤ Real.pi / 2) : InjOn γ I := by
  intro s hs u hu hsu
  have h1 := h.sin_abs_le_dist hI hu hs (hlen s hs u hu)
  rw [hsu, dist_self] at h1
  by_contra hne
  have hpos : 0 < |s - u| := abs_pos.2 (sub_ne_zero.2 hne)
  have := Real.sin_pos_of_pos_of_lt_pi hpos (by linarith [hlen s hs u hu, Real.pi_pos])
  linarith

/-- **A unit-speed curve in a set of diameter below `1` has parameters less than `π/2` apart.** -/
theorem abs_sub_lt_of_dist_lt_one (h : IsUnitCurve γ ψ I) (hI : I.OrdConnected)
    (hd : ∀ s ∈ I, ∀ u ∈ I, dist (γ s) (γ u) < 1) {s u : ℝ} (hs : s ∈ I) (hu : u ∈ I) :
    |s - u| < Real.pi / 2 := by
  have key : ∀ {s u : ℝ}, s ∈ I → u ∈ I → u ≤ s → s - u < Real.pi / 2 := by
    intro s u hs hu hus
    by_contra hge
    rw [not_lt] at hge
    have hm : u + Real.pi / 2 ∈ I := hI.out hu hs ⟨by linarith [Real.pi_pos], by linarith⟩
    have h1 := h.sin_le_dist hI hu hm (by linarith [Real.pi_pos]) (by linarith)
    rw [show u + Real.pi / 2 - u = Real.pi / 2 by ring, Real.sin_pi_div_two] at h1
    exact absurd (hd _ hm _ hu) (not_lt.2 h1)
  rcases le_total u s with hus | hsu
  · rw [abs_of_nonneg (sub_nonneg.2 hus)]; exact key hs hu hus
  · rw [abs_sub_comm, abs_of_nonneg (sub_nonneg.2 hsu)]; exact key hu hs hsu

end IsUnitCurve

/-! ## The curve with a given tangent angle -/

/-- The curve from `y` whose tangent angle is `θ`: `y + ∫₀ˢ e (θ u) du`. -/
noncomputable def angleCurve (y : ℂ) (θ : ℝ → ℝ) (s : ℝ) : ℂ := y + ∫ u in (0 : ℝ)..s, e (θ u)

/-- Spec: the curve starts at `y`. -/
@[simp] theorem angleCurve_zero (y : ℂ) (θ : ℝ → ℝ) : angleCurve y θ 0 = y := by simp [angleCurve]

/-- The derivative of `angleCurve y θ` is `e ∘ θ`. -/
theorem hasDerivAt_angleCurve (y : ℂ) {θ : ℝ → ℝ} (hθ : LipschitzWith 1 θ) (s : ℝ) :
    HasDerivAt (angleCurve y θ) (e (θ s)) s := by
  have hc : Continuous fun u => e (θ u) := continuous_e.comp hθ.continuous
  exact (intervalIntegral.integral_hasDerivAt_right (hc.intervalIntegrable _ _)
    (hc.stronglyMeasurableAtFilter _ _) hc.continuousAt).const_add y

/-- **The curve with a 1-Lipschitz tangent angle is a unit-speed curve of curvature at most 1**, on every set. -/
theorem isUnitCurve_angleCurve (y : ℂ) {θ : ℝ → ℝ} (hθ : LipschitzWith 1 θ) (I : Set ℝ) :
    IsUnitCurve (angleCurve y θ) θ I :=
  ⟨fun s _ => (hasDerivAt_angleCurve y hθ s).hasDerivWithinAt, hθ.lipschitzOnWith⟩

/-- **A unit-speed curve on an open interval through `0` is determined by its tangent angle.** -/
theorem IsUnitCurve.eqOn_angleCurve {γ : ℝ → ℂ} {ψ θ : ℝ → ℝ} {a b : ℝ} (h : IsUnitCurve γ ψ (Ioo a b))
    (hθ : LipschitzWith 1 θ) (heq : EqOn ψ θ (Ioo a b)) (h0 : (0 : ℝ) ∈ Ioo a b) :
    EqOn γ (angleCurve (γ 0) θ) (Ioo a b) := by
  have hd : ∀ s ∈ Ioo a b, HasDerivAt γ (e (ψ s)) s := fun s hs =>
    (h.hasDeriv s hs).hasDerivAt (Ioo_mem_nhds hs.1 hs.2)
  refine isOpen_Ioo.eqOn_of_deriv_eq isPreconnected_Ioo
    (fun s hs => (hd s hs).differentiableAt.differentiableWithinAt)
    (fun s _ => (hasDerivAt_angleCurve _ hθ s).differentiableAt.differentiableWithinAt) (fun s hs => ?_) h0
    (angleCurve_zero _ _).symm
  rw [(hd s hs).deriv, (hasDerivAt_angleCurve _ hθ s).deriv, heq hs]

/-! ## A map that distorts distances by at most a sine is `±s + c` -/

/-- The increasing case: `f s = f a + (s − a)`. -/
theorem eq_add_of_sin_bounds {f : ℝ → ℝ} {a b : ℝ} (hmono : StrictMonoOn f (Icc a b)) (hc : ContinuousOn f (Icc a b))
    (h1 : ∀ s ∈ Icc a b, ∀ u ∈ Icc a b, Real.sin |s - u| ≤ |f s - f u|)
    (h2 : ∀ s ∈ Icc a b, ∀ u ∈ Icc a b, Real.sin |f s - f u| ≤ |s - u|)
    (h3 : ∀ s ∈ Icc a b, ∀ u ∈ Icc a b, |f s - f u| ≤ Real.pi / 2) : ∀ s ∈ Icc a b, f s = f a + (s - a) := by
  have hconst := constant_of_has_deriv_right_zero (f := fun s => f s - s) (hc.sub continuousOn_id) (fun x hx => ?_)
  · intro s hs
    have : f s - s = f a - a := hconst s hs
    linarith
  have hf1 : HasDerivWithinAt f 1 (Ici x) x := by
    rw [hasDerivWithinAt_iff_isLittleO]
    refine Asymptotics.IsBigO.trans_isLittleO (Asymptotics.IsBigO.of_bound 1 ?_)
      ((Asymptotics.isLittleO_pow_sub_sub x (by norm_num : 1 < 3)).mono nhdsWithin_le_nhds)
    have hm : x < min b (x + 1 / 2) := lt_min hx.2 (by linarith)
    filter_upwards [Icc_mem_nhdsGE hm] with x' hx'
    have hx'b : x' ∈ Icc a b := ⟨hx.1.trans hx'.1, hx'.2.trans (min_le_left _ _)⟩
    have hxb : x ∈ Icc a b := ⟨hx.1, hx.2.le⟩
    have hδ0 : 0 ≤ x' - x := sub_nonneg.2 hx'.1
    have hδ1 : x' - x ≤ 1 / 2 := by have := hx'.2.trans (min_le_right _ _); linarith
    have hd0 : 0 ≤ f x' - f x := sub_nonneg.2 (hmono.monotoneOn hxb hx'b hx'.1)
    have a1 := h1 x' hx'b x hxb
    have a2 := h2 x' hx'b x hxb
    have a3 := h3 x' hx'b x hxb
    rw [abs_of_nonneg hδ0, abs_of_nonneg hd0] at a1 a2
    rw [abs_of_nonneg hd0] at a3
    set δ := x' - x with hδ
    set d := f x' - f x with hd
    have hπ := Real.pi_pos
    have hπ2 := Real.pi_lt_d2
    have b1 : δ - δ ^ 3 / 6 ≤ Real.sin δ := by
      rcases hδ0.eq_or_lt with h0 | h0
      · rw [← h0]; simp
      · exact (Real.sin_gt_sub_cube h0).le
    have b2 : d - d ^ 3 / 6 ≤ Real.sin d := by
      rcases hd0.eq_or_lt with h0 | h0
      · rw [← h0]; simp
      · exact (Real.sin_gt_sub_cube h0).le
    have b3 : d ≤ 1.6 * δ := by
      have := Real.mul_le_sin hd0 a3
      have h4 : 2 / Real.pi * d ≤ δ := this.trans a2
      have h5 : d = Real.pi / 2 * (2 / Real.pi * d) := by field_simp
      rw [h5]
      calc Real.pi / 2 * (2 / Real.pi * d) ≤ Real.pi / 2 * δ := by gcongr
        _ ≤ 1.6 * δ := by nlinarith
    have b4 : d ^ 3 ≤ (1.6 * δ) ^ 3 := pow_le_pow_left₀ hd0 b3 3
    have b5 : 0 ≤ δ ^ 3 := pow_nonneg hδ0 3
    rw [smul_eq_mul, mul_one, one_mul, Real.norm_eq_abs (d - δ), Real.norm_eq_abs (‖δ‖ ^ 3), Real.norm_eq_abs δ,
      abs_of_nonneg hδ0, abs_of_nonneg b5, abs_le]
    constructor <;> nlinarith
  have h := hf1.sub (hasDerivWithinAt_id x (Ici x))
  rw [sub_self] at h
  exact h

/-- **A map of an interval of length at most `π/2` with `sin |Δs| ≤ |Δf|` and `sin |Δf| ≤ |Δs|` is `±s + c`.** -/
theorem eq_affine_of_sin_bounds {f : ℝ → ℝ} {a b : ℝ} (hab : a ≤ b) (hlen : b - a ≤ Real.pi / 2)
    (h1 : ∀ s ∈ Icc a b, ∀ u ∈ Icc a b, Real.sin |s - u| ≤ |f s - f u|)
    (h2 : ∀ s ∈ Icc a b, ∀ u ∈ Icc a b, Real.sin |f s - f u| ≤ |s - u|)
    (h3 : ∀ s ∈ Icc a b, ∀ u ∈ Icc a b, |f s - f u| ≤ Real.pi / 2) :
    ∃ ε c : ℝ, (ε = 1 ∨ ε = -1) ∧ ∀ s ∈ Icc a b, f s = ε * s + c := by
  have hπ := Real.pi_pos
  have hc : ContinuousOn f (Icc a b) := by
    refine (LipschitzOnWith.of_dist_le_mul (K := ⟨Real.pi / 2, by positivity⟩) fun s hs u hu => ?_).continuousOn
    rw [Real.dist_eq, Real.dist_eq]
    show |f s - f u| ≤ Real.pi / 2 * |s - u|
    have h4 := (Real.mul_le_sin (abs_nonneg _) (h3 s hs u hu)).trans (h2 s hs u hu)
    have h5 : |f s - f u| = Real.pi / 2 * (2 / Real.pi * |f s - f u|) := by field_simp
    rw [h5]
    gcongr
  have hinj : InjOn f (Icc a b) := by
    intro s hs u hu hsu
    have h4 := h1 s hs u hu
    rw [hsu, sub_self, abs_zero] at h4
    by_contra hne
    have hpos : 0 < |s - u| := abs_pos.2 (sub_ne_zero.2 hne)
    have hle : |s - u| ≤ b - a := by rw [abs_le]; constructor <;> linarith [hs.1, hs.2, hu.1, hu.2]
    have := Real.sin_pos_of_pos_of_lt_pi hpos (by linarith)
    linarith
  rcases hc.strictMonoOn_of_injOn_Icc' hab hinj with hm | ha
  · refine ⟨1, f a - a, Or.inl rfl, fun s hs => ?_⟩
    rw [eq_add_of_sin_bounds hm hc h1 h2 h3 s hs]; ring
  · refine ⟨-1, f a + a, Or.inr rfl, fun s hs => ?_⟩
    have h1' : ∀ s ∈ Icc a b, ∀ u ∈ Icc a b, Real.sin |s - u| ≤ |(-f s) - (-f u)| := fun s hs u hu => by
      rw [neg_sub_neg, abs_sub_comm (f u)]; exact h1 s hs u hu
    have h2' : ∀ s ∈ Icc a b, ∀ u ∈ Icc a b, Real.sin |(-f s) - (-f u)| ≤ |s - u| := fun s hs u hu => by
      rw [neg_sub_neg, abs_sub_comm (f u)]; exact h2 s hs u hu
    have h3' : ∀ s ∈ Icc a b, ∀ u ∈ Icc a b, |(-f s) - (-f u)| ≤ Real.pi / 2 := fun s hs u hu => by
      rw [neg_sub_neg, abs_sub_comm (f u)]; exact h3 s hs u hu
    have : -f s = -f a + (s - a) := eq_add_of_sin_bounds (f := fun s => -f s) ha.neg hc.neg h1' h2' h3' s hs
    linarith

/-- **A unit-speed curve inside the image of another is the other, up to `±s + c`** (both of length at most
`π/2`). -/
theorem IsUnitCurve.reparam {χ : ℝ → ℂ} {ψχ : ℝ → ℝ} {I : Set ℝ} (hχ : IsUnitCurve χ ψχ I) (hI : I.OrdConnected)
    (hIlen : ∀ s ∈ I, ∀ u ∈ I, |s - u| ≤ Real.pi / 2) {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {a b : ℝ} (hab : a ≤ b)
    (hlen : b - a ≤ Real.pi / 2) (hγ : IsUnitCurve γ ψ (Icc a b)) (hsub : γ '' Icc a b ⊆ χ '' I) :
    ∃ ε c : ℝ, (ε = 1 ∨ ε = -1) ∧ ∀ s ∈ Icc a b, ε * s + c ∈ I ∧ γ s = χ (ε * s + c) := by
  have hex : ∀ s : ℝ, ∃ t : ℝ, s ∈ Icc a b → t ∈ I ∧ χ t = γ s := fun s => by
    by_cases hs : s ∈ Icc a b
    · obtain ⟨t, ht, hts⟩ := hsub (mem_image_of_mem γ hs)
      exact ⟨t, fun _ => ⟨ht, hts⟩⟩
    · exact ⟨0, fun h => absurd h hs⟩
  choose τ hτ using hex
  have hJlen : ∀ s ∈ Icc a b, ∀ u ∈ Icc a b, |s - u| ≤ Real.pi / 2 := fun s hs u hu => by
    have : |s - u| ≤ b - a := by rw [abs_le]; constructor <;> linarith [hs.1, hs.2, hu.1, hu.2]
    linarith
  obtain ⟨ε, c, hε, hf⟩ := eq_affine_of_sin_bounds (f := τ) hab hlen
    (fun s hs u hu => by
      have h4 := hγ.sin_abs_le_dist ordConnected_Icc hu hs (hJlen s hs u hu)
      rw [← (hτ s hs).2, ← (hτ u hu).2] at h4
      exact h4.trans (hχ.dist_le hI (hτ u hu).1 (hτ s hs).1))
    (fun s hs u hu => by
      have h4 := hχ.sin_abs_le_dist hI (hτ u hu).1 (hτ s hs).1 (hIlen _ (hτ s hs).1 _ (hτ u hu).1)
      rw [(hτ s hs).2, (hτ u hu).2] at h4
      exact h4.trans (hγ.dist_le ordConnected_Icc hu hs))
    (fun s hs u hu => hIlen _ (hτ s hs).1 _ (hτ u hu).1)
  exact ⟨ε, c, hε, fun s hs => by rw [← hf s hs]; exact ⟨(hτ s hs).1, (hτ s hs).2.symm⟩⟩

/-! ## The polar graph of a curve about its start -/

/-- **FS131-E8-BETA**, the curve's part: a unit-speed curve of curvature at most `1` and length `L ≤ π/2` is, off
its start, a polar graph about its start out to the distance of its far end, with a continuous angle that tends to
the initial tangent angle. (The proof of `IsUnitCurve.exists_polarGraph`, `Plane/Saturated/FanBridge`.) -/
theorem IsUnitCurve.exists_polar_angle {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {L : ℝ} (h : IsUnitCurve γ ψ (Icc 0 L))
    (hL : 0 < L) (hLπ : L ≤ Real.pi / 2) :
    ∃ φ : ℝ → ℝ, ContinuousOn φ (Ioo 0 (dist (γ L) (γ 0))) ∧ Tendsto φ (𝓝[>] 0) (𝓝 (ψ 0)) ∧
      γ '' Ioo 0 L = polarGraph (γ 0) (dist (γ L) (γ 0)) φ := by
  set D : ℝ → ℝ := fun s => dist (γ s) (γ 0) with hD
  have hmono : StrictMonoOn D (Icc 0 L) := h.strictMonoOn_dist hLπ
  have hγc : ContinuousOn γ (Icc 0 L) := h.continuousOn
  have hDc : ContinuousOn D (Icc 0 L) := continuous_dist.comp_continuousOn (hγc.prodMk continuousOn_const)
  have hD0 : D 0 = 0 := dist_self _
  have h0L : (0 : ℝ) ∈ Icc 0 L := ⟨le_rfl, hL.le⟩
  have hLL : L ∈ Icc 0 L := ⟨hL.le, le_rfl⟩
  have hDL : 0 < D L := by rw [← hD0]; exact hmono h0L hLL hL
  have himg : D '' Icc 0 L = Icc 0 (D L) := by
    apply subset_antisymm
    · rintro _ ⟨s, hs, rfl⟩
      exact ⟨dist_nonneg, hmono.monotoneOn hs hLL hs.2⟩
    · have := intermediate_value_Icc hL.le hDc
      rwa [hD0] at this
  -- the inverse of the distance, continuous on the line
  let iso : Icc (0 : ℝ) L ≃o Icc (0 : ℝ) (D L) := (hmono.orderIso D _).trans (OrderIso.setCongr _ _ himg)
  have hiso : ∀ x : Icc (0 : ℝ) L, (iso x : ℝ) = D x := fun x => rfl
  set σ : ℝ → ℝ := fun t => (iso.symm (projIcc 0 (D L) hDL.le t) : ℝ) with hσ
  have hσc : Continuous σ := continuous_subtype_val.comp (iso.symm.continuous.comp continuous_projIcc)
  have hσmem : ∀ t, σ t ∈ Icc 0 L := fun t => (iso.symm _).2
  have hDσ : ∀ t ∈ Icc 0 (D L), D (σ t) = t := by
    intro t ht
    have h1 : (iso (iso.symm (projIcc 0 (D L) hDL.le t)) : ℝ) = t := by
      rw [OrderIso.apply_symm_apply, projIcc_of_mem _ ht]
    rwa [hiso] at h1
  have hσD : ∀ s ∈ Icc 0 L, σ (D s) = s := by
    intro s hs
    have hmem : D s ∈ Icc 0 (D L) := himg ▸ mem_image_of_mem D hs
    have h1 : projIcc 0 (D L) hDL.le (D s) = iso ⟨s, hs⟩ := by
      rw [projIcc_of_mem _ hmem]; exact Subtype.ext (hiso ⟨s, hs⟩).symm
    show (iso.symm (projIcc 0 (D L) hDL.le (D s)) : ℝ) = s
    rw [h1, OrderIso.symm_apply_apply]
  have hσIoc : ∀ t ∈ Ioo 0 (D L), σ t ∈ Ioo 0 L := by
    intro t ht
    have h1 := hDσ t ⟨ht.1.le, ht.2.le⟩
    refine ⟨lt_of_le_of_ne (hσmem t).1 fun h0 => ?_, lt_of_le_of_ne (hσmem t).2 fun h0 => ?_⟩
    · rw [← h0, hD0] at h1; exact ht.1.ne h1
    · rw [h0] at h1; exact ht.2.ne h1.symm
  -- the angle along the curve
  set w : ℝ → ℂ := fun s => (γ s - γ 0) * (starRingEnd ℂ) (e (ψ 0)) with hw
  set θ : ℝ → ℝ := fun s => ψ 0 + Complex.arg (w s) with hθ
  have hwc : ContinuousOn w (Icc 0 L) := (hγc.sub continuousOn_const).mul continuousOn_const
  have hre : ∀ s ∈ Ioc 0 L, 0 < (w s).re := by
    intro s hs
    have h1 := (h.mono (Icc_subset_Icc_right hs.2)).chord hs.1.le (hs.2.trans hLπ)
    exact lt_of_lt_of_le (Real.sin_pos_of_pos_of_lt_pi hs.1 (by linarith [hs.2, Real.pi_pos])) h1
  have hpolar : ∀ s, γ s = polarPt (γ 0) (D s) (θ s) := by
    intro s
    have hn : ‖w s‖ = D s := by
      rw [hw, hD]; simp only [norm_mul, RCLike.norm_conj, norm_e, mul_one, dist_eq_norm]
    have h1 : ((D s : ℝ) : ℂ) * e (Complex.arg (w s)) = w s := by
      rw [← hn]; exact Complex.norm_mul_exp_arg_mul_I (w s)
    have h2 := e_mul_conj_e (ψ 0)
    show γ s = γ 0 + ((D s : ℝ) : ℂ) * e (ψ 0 + Complex.arg (w s))
    rw [e_add, mul_left_comm, h1]
    show γ s = γ 0 + e (ψ 0) * ((γ s - γ 0) * (starRingEnd ℂ) (e (ψ 0)))
    linear_combination (-(γ s - γ 0)) * h2
  have hθc : ContinuousOn θ (Ioc 0 L) := by
    intro s hs
    have h1 : ContinuousAt Complex.arg (w s) := Complex.continuousAt_arg (Or.inl (hre s hs))
    exact continuousWithinAt_const.add
      (h1.comp_continuousWithinAt ((hwc s (Ioc_subset_Icc_self hs)).mono Ioc_subset_Icc_self))
  refine ⟨fun t => θ (σ t), ?_, ?_, ?_⟩
  · exact hθc.comp hσc.continuousOn fun t ht => Ioo_subset_Ioc_self (hσIoc t ht)
  · -- the limit direction
    have hσ0 : σ 0 = 0 := by have := hσD 0 h0L; rwa [hD0] at this
    have hσt : Tendsto σ (𝓝[>] 0) (𝓝[Ioc 0 L] 0) := by
      refine tendsto_nhdsWithin_iff.2 ⟨?_, ?_⟩
      · have := (hσc.tendsto 0).mono_left (nhdsWithin_le_nhds (s := Ioi 0))
        rwa [hσ0] at this
      · filter_upwards [Ioo_mem_nhdsGT hDL] with t ht
        exact Ioo_subset_Ioc_self (hσIoc t ht)
    have hq : Tendsto (fun s : ℝ => ((s⁻¹ : ℝ) : ℂ) * w s) (𝓝[Ioc 0 L] 0) (𝓝 1) := by
      have h1 : Tendsto (fun s : ℝ => ((s⁻¹ : ℝ) : ℂ) * w s - 1) (𝓝[Ioc 0 L] 0) (𝓝 0) := by
        refine squeeze_zero_norm' (a := fun s : ℝ => s / 2) ?_ ?_
        · filter_upwards [self_mem_nhdsWithin] with s hs
          have hs0 : (s : ℂ) ≠ 0 := Complex.ofReal_ne_zero.2 hs.1.ne'
          have h2 := h.norm_sub_le (Ioc_subset_Icc_self hs)
          have h3 := e_mul_conj_e (ψ 0)
          have h4 : ((s⁻¹ : ℝ) : ℂ) * w s - 1 =
              ((s⁻¹ : ℝ) : ℂ) * ((γ s - γ 0 - (s : ℂ) * e (ψ 0)) * (starRingEnd ℂ) (e (ψ 0))) := by
            show ((s⁻¹ : ℝ) : ℂ) * ((γ s - γ 0) * (starRingEnd ℂ) (e (ψ 0))) - 1 = _
            rw [Complex.ofReal_inv]
            have h5 : (s : ℂ)⁻¹ * (s : ℂ) = 1 := inv_mul_cancel₀ hs0
            linear_combination (e (ψ 0) * (starRingEnd ℂ) (e (ψ 0))) * h5 + h3
          rw [h4, norm_mul, norm_mul, RCLike.norm_conj, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs,
            abs_of_pos (inv_pos.2 hs.1)]
          calc s⁻¹ * ‖γ s - γ 0 - (s : ℂ) * e (ψ 0)‖ ≤ s⁻¹ * (s ^ 2 / 2) := by
                gcongr; exact (inv_pos.2 hs.1).le
            _ = s / 2 := by field_simp
        · have : Tendsto (fun s : ℝ => s / 2) (𝓝 0) (𝓝 (0 / 2)) := (continuous_id.div_const 2).tendsto 0
          rw [zero_div] at this
          exact this.mono_left nhdsWithin_le_nhds
      have := h1.add_const 1
      simpa using this
    have harg : Tendsto (fun s : ℝ => Complex.arg (w s)) (𝓝[Ioc 0 L] 0) (𝓝 0) := by
      have h1 : Tendsto (fun s : ℝ => Complex.arg (((s⁻¹ : ℝ) : ℂ) * w s)) (𝓝[Ioc 0 L] 0) (𝓝 (Complex.arg 1)) :=
        ((Complex.continuousAt_arg Complex.one_mem_slitPlane).tendsto).comp hq
      rw [Complex.arg_one] at h1
      refine h1.congr' ?_
      filter_upwards [self_mem_nhdsWithin] with s hs
      exact Complex.arg_real_mul _ (inv_pos.2 hs.1)
    have hθt : Tendsto θ (𝓝[Ioc 0 L] 0) (𝓝 (ψ 0)) := by
      have := (tendsto_const_nhds (x := ψ 0)).add harg
      rwa [add_zero] at this
    exact hθt.comp hσt
  · ext p
    constructor
    · rintro ⟨s, hs, rfl⟩
      have hsI := Ioo_subset_Icc_self hs
      refine ⟨D s, ⟨?_, hmono hsI hLL hs.2⟩, ?_⟩
      · rw [← hD0]; exact hmono h0L hsI hs.1
      · show γ s = polarPt (γ 0) (D s) (θ (σ (D s)))
        rw [hσD s hsI]; exact hpolar s
    · rintro ⟨t, ht, rfl⟩
      refine ⟨σ t, hσIoc t ht, ?_⟩
      have h1 := hpolar (σ t)
      rwa [hDσ t ⟨ht.1.le, ht.2.le⟩] at h1

end HadwigerNelson.Plane
