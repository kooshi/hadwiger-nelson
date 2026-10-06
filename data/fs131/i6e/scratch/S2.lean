import Proofs.HadwigerNelson.Plane.Saturated.FanBridge

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

--BEGIN-ROOT
/-! ### The branch as a unit-speed curve from `z` (FS131-I6E; over `gamma` and `IsUnitCurve.exists_polarGraph`) -/

/-- A unit-speed curve run backwards is a unit-speed curve: the tangent angle turns by `π`. -/
theorem IsUnitCurve.reverse {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {L : ℝ} (h : IsUnitCurve γ ψ (Icc 0 L)) :
    IsUnitCurve (fun s => γ (L - s)) (fun s => ψ (L - s) + Real.pi) (Icc 0 L) := by
  have hm : MapsTo (fun s : ℝ => L - s) (Icc 0 L) (Icc 0 L) :=
    fun s hs => ⟨by linarith [hs.2], by linarith [hs.1]⟩
  refine ⟨fun s hs => ?_, ?_⟩
  · have h1 : HasDerivWithinAt (fun s : ℝ => L - s) (-1) (Icc 0 L) s := by
      simpa using ((hasDerivAt_id s).const_sub L).hasDerivWithinAt
    have h2 : HasDerivWithinAt (fun s => γ (L - s)) ((-1 : ℝ) • e (ψ (L - s))) (Icc 0 L) s :=
      (h.hasDeriv (L - s) (hm hs)).scomp s h1 hm
    rw [e_add_pi, ← neg_one_smul ℝ (e (ψ (L - s)))]
    exact h2
  · refine LipschitzOnWith.of_dist_le_mul fun s hs u hu => ?_
    have := h.abs_sub_le (hm hs) (hm hu)
    rw [Real.dist_eq, Real.dist_eq, NNReal.coe_one, one_mul]
    calc |ψ (L - s) + Real.pi - (ψ (L - u) + Real.pi)| = |ψ (L - s) - ψ (L - u)| := by ring_nf
      _ ≤ |L - s - (L - u)| := this
      _ = |s - u| := by rw [show L - s - (L - u) = -(s - u) by ring, abs_neg]

/-- The squared distance from a polar point about `z` to `z + u`. -/
theorem dist_sq_polarPt_add (z : ℂ) (t θ : ℝ) (u : ℂ) :
    dist (polarPt z t θ) (z + u) ^ 2 = t ^ 2 + ‖u‖ ^ 2 - 2 * t * (e θ * (starRingEnd ℂ) u).re := by
  have h1 : ((t : ℂ) * e θ * (starRingEnd ℂ) u).re = t * (e θ * (starRingEnd ℂ) u).re := by
    rw [mul_assoc, Complex.re_ofReal_mul]
  rw [dist_eq_norm, polarPt, add_sub_add_left_eq_sub, ← Complex.normSq_eq_norm_sq, Complex.normSq_sub,
    Complex.normSq_mul, Complex.normSq_ofReal, Complex.normSq_eq_norm_sq (e θ), norm_e, Complex.normSq_eq_norm_sq u, h1]
  ring

/-- The component of `e θ` along `i e(δ)` is `sin (θ − δ)`. -/
theorem re_e_mul_conj_I_mul_e (θ δ : ℝ) : (e θ * (starRingEnd ℂ) (I * e δ)).re = Real.sin (θ - δ) := by
  simp only [map_mul, Complex.conj_I, Complex.mul_re, Complex.mul_im, Complex.neg_re, Complex.I_re, Complex.neg_im,
    Complex.I_im, Complex.conj_re, Complex.conj_im, re_e, im_e, Real.sin_sub]
  ring

/-- The component of `e a` along `e b` is `cos (a − b)`. -/
theorem re_e_mul_conj_e_eq_cos (a b : ℝ) : (e a * (starRingEnd ℂ) (e b)).re = Real.cos (a - b) := by
  simp only [Complex.mul_re, Complex.conj_re, Complex.conj_im, re_e, im_e, Real.cos_sub]
  ring

/-- The squared distance from the polar point `z + t e(θ)` to the centre `z + i e(δ)`. -/
theorem dist_sq_polarPt_add_I (z : ℂ) (t θ δ : ℝ) :
    dist (polarPt z t θ) (z + I * e δ) ^ 2 = 1 + t ^ 2 - 2 * t * Real.sin (θ - δ) := by
  rw [dist_sq_polarPt_add, re_e_mul_conj_I_mul_e, norm_mul, Complex.norm_I, norm_e]; ring

/-- The squared distance from the polar point `z + t e(θ)` to the centre `z − i e(δ)`. -/
theorem dist_sq_polarPt_sub_I (z : ℂ) (t θ δ : ℝ) :
    dist (polarPt z t θ) (z - I * e δ) ^ 2 = 1 + t ^ 2 + 2 * t * Real.sin (θ - δ) := by
  rw [sub_eq_add_neg, dist_sq_polarPt_add, map_neg, mul_neg, Complex.neg_re, re_e_mul_conj_I_mul_e, norm_neg, norm_mul,
    Complex.norm_I, norm_e]; ring
/-- Two unit vectors with `ν ⊥ T`: `ν = ± i T`. -/
theorem eq_I_mul_or_eq_neg_of_re_eq_zero {ν T : ℂ} (hν : ‖ν‖ = 1) (hT : ‖T‖ = 1)
    (h : (ν * (starRingEnd ℂ) T).re = 0) : ν = I * T ∨ ν = -(I * T) := by
  set v : ℂ := ν * (starRingEnd ℂ) T with hv
  have hTT : (starRingEnd ℂ) T * T = 1 := by
    rw [mul_comm, Complex.mul_conj, Complex.normSq_eq_norm_sq, hT]; norm_num
  have hνv : ν = v * T := by rw [hv, mul_assoc, hTT, mul_one]
  have hn : ‖v‖ = 1 := by rw [hv, norm_mul, RingHomIsometric.norm_map, hν, hT, mul_one]
  have him : v.im * v.im = 1 := by
    have h1 : Complex.normSq v = 1 := by rw [Complex.normSq_eq_norm_sq, hn]; norm_num
    rw [Complex.normSq_apply, h] at h1
    linarith
  rcases mul_self_eq_one_iff.1 him with h1 | h1
  · left; rw [hνv]; congr 1; exact Complex.ext (by simp [h]) (by simp [h1])
  · right; rw [hνv, ← neg_mul]; congr 1; exact Complex.ext (by simp [h]) (by simp [h1])

/-- The squared distance from `z + t e(φ₀ + η)` to the centre of the unit disc touching at `z + t e(φ₀)` with normal
`i e(ψ)`. -/
theorem dist_sq_polarPt_polarPt_add_I (z : ℂ) (t φ₀ η ψ : ℝ) :
    dist (polarPt z t (φ₀ + η)) (polarPt z t φ₀ + I * e ψ) ^ 2 =
      1 + 2 * t ^ 2 * (1 - Real.cos η) - 2 * t * (Real.sin (φ₀ - ψ + η) - Real.sin (φ₀ - ψ)) := by
  have h0 : polarPt z t φ₀ + I * e ψ = z + ((t : ℂ) * e φ₀ + I * e ψ) := by rw [polarPt]; ring
  have h1 : ‖(t : ℂ) * e φ₀ + I * e ψ‖ ^ 2 = 1 + t ^ 2 + 2 * t * Real.sin (φ₀ - ψ) := by
    have := dist_sq_polarPt_sub_I 0 t φ₀ ψ
    rw [dist_eq_norm, polarPt, zero_add, zero_sub, sub_neg_eq_add] at this
    exact this
  have h2 : (e (φ₀ + η) * (starRingEnd ℂ) ((t : ℂ) * e φ₀ + I * e ψ)).re =
      t * Real.cos η + Real.sin (φ₀ + η - ψ) := by
    rw [map_add, mul_add, Complex.add_re, re_e_mul_conj_I_mul_e, map_mul, Complex.conj_ofReal, mul_left_comm,
      Complex.re_ofReal_mul, re_e_mul_conj_e_eq_cos, add_sub_cancel_left]
  rw [h0, dist_sq_polarPt_add, h1, h2, show φ₀ - ψ + η = φ₀ + η - ψ by ring]
  ring

/-- If the direction `e(φ₀)` has a positive component along `e(ψ)`, a small turn counter-clockwise from
`z + t e(φ₀)` about `z` enters the open unit disc touching there with normal `i e(ψ)`. -/
theorem eventually_dist_polarPt_lt_one (z : ℂ) {t : ℝ} (ht : 0 < t) {φ₀ ψ : ℝ} (hcos : 0 < Real.cos (φ₀ - ψ)) :
    ∀ᶠ η in 𝓝[>] (0 : ℝ), dist (polarPt z t (φ₀ + η)) (polarPt z t φ₀ + I * e ψ) < 1 := by
  have hc : ContinuousAt (fun η : ℝ => Real.cos (φ₀ - ψ + η / 2) - t * Real.sin (η / 2)) 0 := by fun_prop
  have h0 : 0 < (fun η : ℝ => Real.cos (φ₀ - ψ + η / 2) - t * Real.sin (η / 2)) 0 := by simpa using hcos
  have e1 : ∀ᶠ η in 𝓝[>] (0 : ℝ), 0 < Real.cos (φ₀ - ψ + η / 2) - t * Real.sin (η / 2) :=
    nhdsWithin_le_nhds (hc.eventually (lt_mem_nhds h0))
  filter_upwards [e1, Ioo_mem_nhdsGT Real.pi_pos] with η h1 hη
  have hs : 0 < Real.sin (η / 2) :=
    Real.sin_pos_of_pos_of_lt_pi (by linarith [hη.1]) (by linarith [hη.2, Real.pi_pos])
  have hsq := dist_sq_polarPt_polarPt_add_I z t φ₀ η ψ
  have hss : Real.sin (φ₀ - ψ + η) - Real.sin (φ₀ - ψ) = 2 * Real.sin (η / 2) * Real.cos (φ₀ - ψ + η / 2) := by
    rw [Real.sin_sub_sin]; ring_nf
  have hcc : 1 - Real.cos η = 2 * Real.sin (η / 2) ^ 2 := by
    have := Real.cos_two_mul_eq_one_sub (η / 2)
    rw [show 2 * (η / 2) = η by ring] at this; linarith
  rw [hss, hcc] at hsq
  by_contra hge
  rw [not_lt] at hge
  nlinarith [mul_pos ht hs, mul_pos (mul_pos ht hs) h1]

/-- A class with positive upper density at a point of an open set that is almost everywhere of two classes is one of
the two. -/
theorem AeColouring.eq_or_eq_of_mem_essClosure (c : AeColouring k) {O : Set ℂ} (hO : IsOpen O) {a b a' : Fin k}
    (hae : (O : Set ℂ) ≤ᵐ[volume] (c.cls a ∪ c.cls b : Set ℂ)) {x : ℂ} (hx : x ∈ O)
    (hx' : x ∈ essClosure (c.cls a')) : a' = a ∨ a' = b := by
  by_contra hne
  rw [not_or] at hne
  obtain ⟨r, hr, hsub⟩ := Metric.isOpen_iff.1 hO x hx
  have h0 : ∀ s, 0 < s → s ≤ r / 2 → volume (c.cls a' ∩ closedBall x s) = 0 := fun s _ hs => by
    rw [ae_le_set] at hae
    refine measure_mono_null ?_ hae
    rintro w ⟨hwa', hw⟩
    refine ⟨hsub (closedBall_subset_ball (by linarith) hw), ?_⟩
    rintro (hwa | hwb)
    · exact hne.1 ((show c.col w = a' from hwa').symm.trans hwa)
    · exact hne.2 ((show c.col w = a' from hwa').symm.trans hwb)
  exact (ne_of_gt hx') (upperDensityAt_eq_zero_of_null (half_pos hr) h0)
--END-ROOT

namespace AeColouring

variable {c : AeColouring k} {z : ℂ}

namespace Fan

variable (F : c.Fan z)

--BEGIN-FAN
/-- **A branch of a fan, under saturation in the punctured disc, is a unit-speed curve of curvature at most `1` from
`z`** (FS131-E8-GAMMA and -BETA for the branch; the deriver's § 6.5: through `gamma` and
`IsUnitCurve.exists_polarGraph`, not `beta`, which drops the tangent): within distance `min F.r (1/2)` of `z` branch
`i` is `γ '' (0, L)` for a curve `γ` of length `L ≤ π/2` with `γ 0 = z`, whose initial tangent is the branch's limit
direction. -/
theorem exists_unitCurve_branch (hsat : SaturatedOn c.cls (ball z F.r \ {z})) (i : Fin F.n) :
    ∃ (L : ℝ) (γ : ℝ → ℂ) (ψ : ℝ → ℝ), 0 < L ∧ L ≤ Real.pi / 2 ∧ IsUnitCurve γ ψ (Icc 0 L) ∧ γ 0 = z ∧
      e (ψ 0) = e (F.dir i) ∧ γ '' Ioo 0 L = polarGraph z (min F.r (1 / 2)) (F.φ i) := by
  set R : ℝ := min F.r (1 / 2) with hRdef
  have hR0 : 0 < R := lt_min F.r_pos (by norm_num)
  have hRr : R ≤ F.r := min_le_left _ _
  have hiso : c.IsolatedAt z R :=
    ⟨hR0, min_le_right _ _, fun w hw => F.singular ⟨hw.1, ball_subset_ball hRr hw.2⟩,
      hsat.mono (sdiff_subset_sdiff_left (ball_subset_ball hRr))⟩
  set B : Set ℂ := polarGraph z R (F.φ i) with hB
  have hBsub : B ⊆ c.essBdry ∩ (ball z R \ {z}) := by
    intro w hw
    refine ⟨?_, polarGraph_subset z R _ hw⟩
    obtain ⟨t, ht, rfl⟩ := hw
    exact (F.branch_subset i ⟨t, ⟨ht.1, lt_of_lt_of_le ht.2 hRr⟩, rfl⟩).1
  have hBpre : IsPreconnected B := by
    have him : B = (fun t => polarPt z t (F.φ i t)) '' Ioo 0 R := by
      ext w; constructor
      · rintro ⟨t, ht, rfl⟩; exact ⟨t, ht, rfl⟩
      · rintro ⟨t, ht, rfl⟩; exact ⟨t, ht, rfl⟩
    rw [him]
    refine isPreconnected_Ioo.image _ ?_
    have h1 : ContinuousOn (fun t : ℝ => (t, F.φ i t)) (Ioo 0 R) :=
      continuousOn_id.prodMk ((F.cont i).mono (Ioo_subset_Ioo_right hRr))
    exact (continuous_polarPt z).comp_continuousOn h1
  have hy0 : polarPt z (R / 2) (F.φ i (R / 2)) ∈ B := ⟨R / 2, ⟨half_pos hR0, half_lt_self hR0⟩, rfl⟩
  obtain ⟨L, γ, ψ, hL0, hLπ, hcurve, -, hK, -, -⟩ := gamma hiso (hBsub hy0)
  have hBK : B ⊆ γ '' Ioo 0 L := by
    rw [← hK]; exact hBpre.subset_connectedComponentIn hy0 hBsub
  have hKsub : γ '' Ioo 0 L ⊆ c.essBdry ∩ (ball z R \ {z}) := by
    rw [← hK]; exact connectedComponentIn_subset _ _
  -- `z` is an end of the curve
  have hzB : z ∈ closure B := by
    rw [Metric.mem_closure_iff]
    intro ε hε
    have ht : min ε R / 2 ∈ Ioo 0 R :=
      ⟨half_pos (lt_min hε hR0), by have := min_le_right ε R; linarith [lt_min hε hR0]⟩
    refine ⟨_, ⟨_, ht, rfl⟩, ?_⟩
    rw [dist_comm, dist_polarPt z ht.1.le]
    have := min_le_left ε R; linarith [lt_min hε hR0]
  have hzI : z ∈ γ '' Icc 0 L :=
    closure_minimal (hBK.trans (image_mono Ioo_subset_Icc_self))
      (isCompact_Icc.image_of_continuousOn fun s hs => (hcurve.hasDeriv s hs).continuousWithinAt).isClosed hzB
  obtain ⟨s₀, hs₀, hs₀z⟩ := hzI
  have hends : s₀ = 0 ∨ s₀ = L := by
    by_contra hne
    rw [not_or] at hne
    have hmem : s₀ ∈ Ioo 0 L := ⟨lt_of_le_of_ne hs₀.1 (Ne.symm hne.1), lt_of_le_of_ne hs₀.2 hne.2⟩
    exact (hKsub ⟨s₀, hmem, hs₀z⟩).2.2 rfl
  -- run the curve from `z`
  obtain ⟨γ', ψ', hcurve', hγ'0, hK'⟩ : ∃ (γ' : ℝ → ℂ) (ψ' : ℝ → ℝ),
      IsUnitCurve γ' ψ' (Icc 0 L) ∧ γ' 0 = z ∧ γ' '' Ioo 0 L = γ '' Ioo 0 L := by
    rcases hends with h0 | hL
    · exact ⟨γ, ψ, hcurve, by rw [← h0, hs₀z], rfl⟩
    · refine ⟨fun s => γ (L - s), fun s => ψ (L - s) + Real.pi, hcurve.reverse, ?_, ?_⟩
      · simp only [sub_zero]; rw [← hL, hs₀z]
      · ext w; constructor
        · rintro ⟨s, hs, rfl⟩; exact ⟨L - s, ⟨by linarith [hs.2], by linarith [hs.1]⟩, rfl⟩
        · rintro ⟨s, hs, rfl⟩; exact ⟨L - s, ⟨by linarith [hs.2], by linarith [hs.1]⟩, by simp⟩
  obtain ⟨φ', -, hφ't, hpg⟩ := hcurve'.exists_polarGraph hL0 hLπ
  rw [hγ'0, hK'] at hpg
  -- on `(0, R)` the two polar angles give the same direction
  have hsame : ∀ t ∈ Ioo 0 R, e (F.φ i t) = e (φ' t) := by
    intro t ht
    have hmem : polarPt z t (F.φ i t) ∈ γ '' Ioo 0 L := hBK ⟨t, ht, rfl⟩
    rw [hpg] at hmem
    obtain ⟨t', ht', heq⟩ := hmem
    have hd : t = t' := by
      have := congrArg (fun w => dist w z) heq
      simpa only [dist_polarPt z ht.1.le, dist_polarPt z ht'.1.le] using this
    subst hd
    rw [polarPt, polarPt, add_right_inj] at heq
    exact mul_left_cancel₀ (Complex.ofReal_ne_zero.2 ht.1.ne') heq
  refine ⟨L, γ', ψ', hL0, hLπ, hcurve', hγ'0, ?_, ?_⟩
  · have h1 : Tendsto (fun t => e (F.φ i t)) (𝓝[>] 0) (𝓝 (e (F.dir i))) :=
      (continuous_e.tendsto _).comp (F.tendsto i)
    have h2 : Tendsto (fun t => e (φ' t)) (𝓝[>] 0) (𝓝 (e (ψ' 0))) := (continuous_e.tendsto _).comp hφ't
    have h3 : (fun t => e (F.φ i t)) =ᶠ[𝓝[>] 0] fun t => e (φ' t) := by
      filter_upwards [Ioo_mem_nhdsGT hR0] with t ht using hsame t ht
    exact (tendsto_nhds_unique (h1.congr' h3) h2).symm
  · rw [hK']
    refine Subset.antisymm ?_ hBK
    intro w hw
    have hball := (hKsub hw).2.1
    rw [hpg] at hw
    obtain ⟨t', ht', rfl⟩ := hw
    rw [mem_ball, dist_polarPt z ht'.1.le] at hball
    have ht : t' ∈ Ioo 0 R := ⟨ht'.1, hball⟩
    refine ⟨t', ht, ?_⟩
    rw [polarPt, polarPt, hsame t' ht]
/-! ### The contacts at a branch (FS131-I6E; FS131-E8 § 6.1) -/

/-- At a point of branch `i` some ball centred there is a two-colour neighbourhood with the colours of the two cells
beside the branch (FS131-E8 § 6.1: "its two-colour ball has the colours `a`, `b`"). No saturation. -/
theorem exists_twoColourNhd_branch {i j : Fin F.n} (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n))
    {t : ℝ} (ht : t ∈ Ioo 0 F.r) :
    ∃ ρ, TwoColourNhd c.cls (ball (polarPt z t (F.φ i t)) ρ) (F.col j) (F.col i) := by
  have hxb : polarPt z t (F.φ i t) ∈ F.branch i := ⟨t, ht, rfl⟩
  obtain ⟨ρ, a', b', h⟩ := exists_twoColourNhd_of_mem_interfaceSet (F.branch_subset_interfaceSet i hxb)
  have hxN : polarPt z t (F.φ i t) ∈ ball (polarPt z t (F.φ i t)) ρ := mem_ball_self h.radius_pos
  obtain ⟨hxa, hxb'⟩ := h.mem_essBoundary c.measurableSet_cls hxN (F.branch_subset i hxb).1
  obtain ⟨O, hO, hxO, hae⟩ := F.exists_isOpen_ae_two_colours hij ht
  have ha := c.eq_or_eq_of_mem_essClosure hO hae hxO hxa.1
  have hb := c.eq_or_eq_of_mem_essClosure hO hae hxO hxb'.1
  have hne := h.ne
  rcases ha with rfl | rfl <;> rcases hb with rfl | rfl
  · exact absurd rfl hne
  · exact ⟨ρ, h⟩
  · exact ⟨ρ, h.symm⟩
  · exact absurd rfl hne

/-- **A common contact propagates along a branch** (FS131-E8 § 6.1, Case A): if one point of branch `i` is at
distance `1` from a point `y` in the supports of both colours beside the branch, every point of the branch is —
FS111-M-PINCH's split type at each such point (a common contact excludes the tangent type), FS111-M-C11 (iii) in its
two-colour ball, and the connectedness of `(0, F.r)`. No saturation and no bound `1/2` is read. -/
theorem dist_eq_one_of_common_contact {i j : Fin F.n}
    (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n)) {y : ℂ}
    (hya : y ∈ essSupport (c.cls (F.col j))) (hyb : y ∈ essSupport (c.cls (F.col i))) {t₀ : ℝ}
    (ht₀ : t₀ ∈ Ioo 0 F.r) (h0 : dist (polarPt z t₀ (F.φ i t₀)) y = 1) :
    ∀ t ∈ Ioo 0 F.r, dist (polarPt z t (F.φ i t)) y = 1 := by
  have hpc : ContinuousOn (fun t => polarPt z t (F.φ i t)) (Ioo 0 F.r) :=
    (continuous_polarPt z).comp_continuousOn (continuousOn_id.prodMk (F.cont i))
  have hf : ContinuousOn (fun t => dist (polarPt z t (F.φ i t)) y) (Ioo 0 F.r) :=
    fun t ht => (hpc t ht).dist continuousWithinAt_const
  have hopen : ∀ t₁ ∈ Ioo 0 F.r, dist (polarPt z t₁ (F.φ i t₁)) y = 1 →
      ∀ᶠ t in 𝓝 t₁, dist (polarPt z t (F.φ i t)) y = 1 := by
    intro t₁ ht₁ h1
    obtain ⟨ρ, h⟩ := F.exists_twoColourNhd_branch hij ht₁
    have hxN : polarPt z t₁ (F.φ i t₁) ∈ ball (polarPt z t₁ (F.φ i t₁)) ρ := mem_ball_self h.radius_pos
    have hsph : essBoundary (c.cls (F.col j)) ∩ ball (polarPt z t₁ (F.φ i t₁)) ρ =
        sphere y 1 ∩ ball (polarPt z t₁ (F.φ i t₁)) ρ := by
      rcases pinch (c.measurableSet_cls _) (c.unitPairsNull _) (c.measurableSet_cls _) (c.unitPairsNull _) h.two
        hxN hya h1 hyb h1 with ⟨-, hs | hs⟩ | ⟨hanti, -⟩
      · exact (c11_split isOpen_ball hs).1
      · exact (c11_split isOpen_ball hs).2
      · exfalso
        have h2 : y - polarPt z t₁ (F.φ i t₁) = 0 := by linear_combination (1 / 2 : ℂ) * hanti
        rw [sub_eq_zero] at h2
        rw [h2, dist_self] at h1
        exact zero_ne_one h1
    have hI : Ioo 0 F.r ∈ 𝓝 t₁ := Ioo_mem_nhds ht₁.1 ht₁.2
    filter_upwards [(hpc.continuousAt hI) (isOpen_ball.mem_nhds hxN), hI] with t htN ht
    have hb := (F.branch_subset i ⟨t, ht, rfl⟩).1
    have h2 : polarPt z t (F.φ i t) ∈ sphere y 1 ∩ ball (polarPt z t₁ (F.φ i t₁)) ρ :=
      hsph ▸ ⟨(h.mem_essBoundary c.measurableSet_cls htN hb).1, htN⟩
    exact mem_sphere.1 h2.1
  have hsub : Ioo 0 F.r ⊆ Ioo 0 F.r ∩ {t | ∀ᶠ t' in 𝓝 t, dist (polarPt z t' (F.φ i t')) y = 1} := by
    refine isPreconnected_Ioo.subset_left_of_subset_union
      (v := Ioo 0 F.r ∩ (fun t => dist (polarPt z t (F.φ i t)) y) ⁻¹' {1}ᶜ)
      (isOpen_Ioo.inter isOpen_setOf_eventually_nhds) (hf.isOpen_inter_preimage isOpen_Ioo isOpen_compl_singleton)
      ?_ ?_ ⟨t₀, ht₀, ht₀, hopen t₀ ht₀ h0⟩
    · rw [Set.disjoint_left]
      rintro t ⟨-, hev⟩ ⟨-, hne⟩
      exact hne (show ∀ᶠ t' in 𝓝 t, dist (polarPt z t' (F.φ i t')) y = 1 from hev).self_of_nhds
    · intro t ht
      by_cases h1 : dist (polarPt z t (F.φ i t)) y = 1
      · exact Or.inl ⟨ht, hopen t ht h1⟩
      · exact Or.inr ⟨ht, h1⟩
  exact fun t ht => (show ∀ᶠ t' in 𝓝 t, dist (polarPt z t' (F.φ i t')) y = 1 from (hsub ht).2).self_of_nhds

/-- **A branch on a unit circle has its centre on the normal at `z`**: if the points of branch `i` near `z` are at
distance `1` from `y`, then `y = z ± i e(dir i)` (FS131-E8 § 6.1: "the branch's limit direction is the circle's
tangent at `z`"). -/
theorem eq_add_or_eq_sub_of_dist_eq_one (i : Fin F.n) {y : ℂ} {ρ : ℝ} (hρ : 0 < ρ)
    (h : ∀ t ∈ Ioo 0 ρ, dist (polarPt z t (F.φ i t)) y = 1) :
    y = z + I * e (F.dir i) ∨ y = z - I * e (F.dir i) := by
  have hlim : Tendsto (fun t => polarPt z t (F.φ i t)) (𝓝[>] 0) (𝓝 z) := by
    rw [tendsto_iff_dist_tendsto_zero]
    have h1 : Tendsto (fun t : ℝ => t) (𝓝[>] 0) (𝓝 0) := tendsto_nhdsWithin_of_tendsto_nhds tendsto_id
    refine h1.congr' ?_
    filter_upwards [self_mem_nhdsWithin] with t ht
    exact (dist_polarPt z (le_of_lt ht) _).symm
  have hzy : dist z y = 1 := by
    refine tendsto_nhds_unique (hlim.dist tendsto_const_nhds) (tendsto_const_nhds.congr' ?_)
    filter_upwards [Ioo_mem_nhdsGT hρ] with t ht using (h t ht).symm
  set u : ℂ := y - z with hu
  have hun : ‖u‖ = 1 := by rw [hu, ← dist_eq_norm, dist_comm]; exact hzy
  have hy : y = z + u := by rw [hu]; ring
  have key : ∀ t ∈ Ioo 0 ρ, (e (F.φ i t) * (starRingEnd ℂ) u).re = t / 2 := by
    intro t ht
    have h1 := dist_sq_polarPt_add z t (F.φ i t) u
    rw [← hy, h t ht, hun] at h1
    have h2 : t * (2 * (e (F.φ i t) * (starRingEnd ℂ) u).re - t) = 0 := by linear_combination h1
    rcases mul_eq_zero.1 h2 with h3 | h3
    · exact absurd h3 ht.1.ne'
    · linarith
  have hre : (e (F.dir i) * (starRingEnd ℂ) u).re = 0 := by
    have h1 : Tendsto (fun t => (e (F.φ i t) * (starRingEnd ℂ) u).re) (𝓝[>] 0)
        (𝓝 ((e (F.dir i) * (starRingEnd ℂ) u).re)) :=
      (Complex.continuous_re.tendsto _).comp (((continuous_e.tendsto _).comp (F.tendsto i)).mul_const _)
    have h2 : Tendsto (fun t : ℝ => t / 2) (𝓝[>] 0) (𝓝 0) := by
      have h3 : Tendsto (fun t : ℝ => t / 2) (𝓝 0) (𝓝 (0 / 2)) := tendsto_id.div_const 2
      rw [zero_div] at h3
      exact tendsto_nhdsWithin_of_tendsto_nhds h3
    refine tendsto_nhds_unique h1 (h2.congr' ?_)
    filter_upwards [Ioo_mem_nhdsGT hρ] with t ht using (key t ht).symm
  have hre' : (u * (starRingEnd ℂ) (e (F.dir i))).re = 0 := by
    rw [← Complex.conj_re, map_mul, Complex.conj_conj, mul_comm]; exact hre
  rcases eq_I_mul_or_eq_neg_of_re_eq_zero hun (norm_e _) hre' with h1 | h1
  · left; rw [hy, h1]
  · right; rw [hy, h1, sub_eq_add_neg]

/-- **The contacts at a point of a branch with no common contact** (FS131-E8 § 6.1, Case B, at one point): on the
branch's curve `γ` from `z`, if no branch point has a common contact of the two colours, the point `γ s` is of
tangent type with normal `i e(ψ s)` into the counter-clockwise cell — `γ s + i e(ψ s)` is in the support of the
clockwise colour and `γ s − i e(ψ s)` in that of the counter-clockwise one. The normal is perpendicular to the tangent
because the curve stays outside the open unit disc about the contact (Fermat); its sign because the tangent has a
positive radial component (`IsUnitCurve.sin_le_inner`), so a small turn counter-clockwise about `z` enters the disc
about `γ s + i e(ψ s)`, and that point is in the counter-clockwise cell. -/
theorem contacts_of_no_common (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {i j : Fin F.n}
    (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n)) {L : ℝ} {γ : ℝ → ℂ} {ψ : ℝ → ℝ}
    (hLπ : L ≤ Real.pi / 2) (hcurve : IsUnitCurve γ ψ (Icc 0 L)) (hγ0 : γ 0 = z)
    (hK : γ '' Ioo 0 L = polarGraph z (min F.r (1 / 2)) (F.φ i))
    (hno : ∀ t ∈ Ioo 0 (min F.r (1 / 2)), ∀ y ∈ essSupport (c.cls (F.col j)),
      y ∈ essSupport (c.cls (F.col i)) → dist (polarPt z t (F.φ i t)) y ≠ 1) {s : ℝ} (hs : s ∈ Ioo 0 L) :
    γ s + I * e (ψ s) ∈ essSupport (c.cls (F.col j)) ∧ γ s - I * e (ψ s) ∈ essSupport (c.cls (F.col i)) := by
  have hRr : min F.r (1 / 2) ≤ F.r := min_le_left _ _
  obtain ⟨t, ht, hxt⟩ : ∃ t ∈ Ioo 0 (min F.r (1 / 2)), γ s = polarPt z t (F.φ i t) := by
    have h1 : γ s ∈ polarGraph z (min F.r (1 / 2)) (F.φ i) := by rw [← hK]; exact mem_image_of_mem γ hs
    exact h1
  have htr : t ∈ Ioo 0 F.r := ⟨ht.1, lt_of_lt_of_le ht.2 hRr⟩
  obtain ⟨ρ, h⟩ := F.exists_twoColourNhd_branch hij htr
  rw [← hxt] at h
  have hxbr : γ s ∈ F.branch i := by rw [hxt]; exact ⟨t, htr, rfl⟩
  have hxN : γ s ∈ ball (γ s) ρ := mem_ball_self h.radius_pos
  obtain ⟨hxa, hxb⟩ := h.mem_essBoundary c.measurableSet_cls hxN (F.branch_subset i hxbr).1
  have hxU := (F.branch_subset i hxbr).2
  obtain ⟨ya, hya, hda⟩ := hsat (F.col j) (γ s) ⟨hxa, hxU⟩
  obtain ⟨yb, hyb, hdb⟩ := hsat (F.col i) (γ s) ⟨hxb, hxU⟩
  rw [← essSupport_eq_closure_densitySet] at hya hyb
  rcases pinch (c.measurableSet_cls _) (c.unitPairsNull _) (c.measurableSet_cls _) (c.unitPairsNull _) h.two hxN
    hya hda hyb hdb with ⟨heq, -⟩ | ⟨-, ⟨hν, hdB, hdA⟩, hsa, hsb⟩
  · rw [← heq] at hyb
    rw [hxt] at hda
    exact absurd hda (hno t ht ya hya hyb)
  · set ν : ℂ := ya - γ s with hνdef
    have hperp : (ν * (starRingEnd ℂ) (e (ψ s))).re = 0 := by
      have hsI : Icc 0 L ∈ 𝓝 s := Icc_mem_nhds hs.1 hs.2
      have hd := (hcurve.hasDerivWithinAt_norm_sq (γ s + ν) (Ioo_subset_Icc_self hs)).hasDerivAt hsI
      have hcont : ContinuousAt γ s := (hcurve.hasDeriv s (Ioo_subset_Icc_self hs)).continuousWithinAt.continuousAt hsI
      have hl : ‖γ s - (γ s + ν)‖ = 1 := by rw [sub_add_cancel_left, norm_neg, hν]
      have hmin : IsLocalMin (fun u => ‖γ u - (γ s + ν)‖ ^ 2) s := by
        show ∀ᶠ u in 𝓝 s, ‖γ s - (γ s + ν)‖ ^ 2 ≤ ‖γ u - (γ s + ν)‖ ^ 2
        filter_upwards [hcont (isOpen_ball.mem_nhds hxN), Ioo_mem_nhds hs.1 hs.2] with u huN hu
        have hub : γ u ∈ c.essBdry := by
          have h1 : γ u ∈ polarGraph z (min F.r (1 / 2)) (F.φ i) := by rw [← hK]; exact mem_image_of_mem γ hu
          obtain ⟨t', ht', hut⟩ := h1
          rw [hut]
          exact (F.branch_subset i ⟨t', ⟨ht'.1, lt_of_lt_of_le ht'.2 hRr⟩, rfl⟩).1
        have hout : γ u ∉ ball (γ s + ν) 1 := fun hin =>
          c.notMem_essBdry_of_mem_densitySet
            (subset_densitySet_of_isOpen_ae_subset (isOpen_ball.inter isOpen_ball) hdB ⟨hin, huN⟩) hub
        rw [mem_ball, not_lt, dist_eq_norm] at hout
        rw [hl]
        nlinarith [norm_nonneg (γ u - (γ s + ν))]
      have h0 := hmin.hasDerivAt_eq_zero hd
      rw [sub_add_cancel_left, neg_mul, Complex.neg_re] at h0
      linarith
    rcases eq_I_mul_or_eq_neg_of_re_eq_zero hν (norm_e _) hperp with hpos | hneg
    · rw [← hpos]
      exact ⟨hsa, hsb⟩
    · exfalso
      have hcos : 0 < Real.cos (F.φ i t - ψ s) := by
        have h1 := hcurve.sin_le_inner hLπ (Ioo_subset_Icc_self hs)
        rw [hγ0, hxt, polarPt, add_sub_cancel_left, mul_assoc, Complex.re_ofReal_mul, re_e_mul_conj_e_eq_cos] at h1
        have h2 : 0 < Real.sin s := Real.sin_pos_of_pos_of_lt_pi hs.1 (by linarith [hs.2, Real.pi_pos])
        by_contra hle
        rw [not_lt] at hle
        nlinarith [mul_nonneg ht.1.le (neg_nonneg.2 hle)]
      have e1 := eventually_dist_polarPt_lt_one z ht.1 hcos
      have hc : Continuous (fun η : ℝ => polarPt z t (F.φ i t + η)) :=
        (continuous_polarPt z).comp (continuous_const.prodMk (continuous_const.add continuous_id))
      have e2 : ∀ᶠ η in 𝓝[>] (0 : ℝ), polarPt z t (F.φ i t + η) ∈ ball (γ s) ρ := by
        refine nhdsWithin_le_nhds (hc.continuousAt (isOpen_ball.mem_nhds ?_))
        show polarPt z t (F.φ i t + 0) ∈ ball (γ s) ρ
        rw [add_zero, ← hxt]; exact hxN
      have e3 : ∀ᶠ η in 𝓝[>] (0 : ℝ), η ∈ Ioo 0 (cyclicNext F.φ i t - F.φ i t) :=
        Ioo_mem_nhdsGT (sub_pos.2 (F.φ_lt_cyclicNext i htr))
      obtain ⟨η, ⟨h1, h2⟩, h3⟩ := ((e1.and e2).and e3).exists
      have hcell : polarPt z t (F.φ i t + η) ∈ F.cell i :=
        ⟨t, htr, _, ⟨by linarith [h3.1], by linarith [h3.2]⟩, rfl⟩
      have hdisc : polarPt z t (F.φ i t + η) ∈ ball (γ s - ν) 1 := by
        rw [mem_ball, hneg, sub_neg_eq_add, hxt]; exact h1
      exact h.two.false_of_mem_inter isOpen_ball (F.isOpen_cell i) hdA
        (Filter.EventuallyLE.trans (Eventually.of_forall inter_subset_left) (F.region i)) h2 hdisc hcell
--END-FAN

theorem branch_outside_discs' (hsat : SaturatedOn c.cls (ball z F.r \ {z})) (i : Fin F.n) {t : ℝ}
    (ht : t ∈ Ioo 0 (min F.r (1 / 2))) :
    1 ≤ dist (polarPt z t (F.φ i t)) (z + I * e (F.dir i)) ∧
      1 ≤ dist (polarPt z t (F.φ i t)) (z - I * e (F.dir i)) := by
--BEGIN-OUT
  obtain ⟨L, γ, ψ, -, hLπ, hcurve, hγ0, hdir, hK⟩ := F.exists_unitCurve_branch hsat i
  have hmem : polarPt z t (F.φ i t) ∈ γ '' Ioo 0 L := by rw [hK]; exact ⟨t, ht, rfl⟩
  obtain ⟨s, hs, hsx⟩ := hmem
  have h := hcurve.one_le_dist hLπ (Ioo_subset_Icc_self hs)
  rwa [hsx, hγ0, hdir] at h
--END-OUT

theorem branch_contacts' (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {i j : Fin F.n}
    (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n)) :
    (∃ y, (y = z + I * e (F.dir i) ∨ y = z - I * e (F.dir i)) ∧ y ∈ essSupport (c.cls (F.col j)) ∧
        y ∈ essSupport (c.cls (F.col i)) ∧ ∀ t ∈ Ioo 0 (min F.r (1 / 2)), dist (polarPt z t (F.φ i t)) y = 1) ∨
      (z + I * e (F.dir i) ∈ essSupport (c.cls (F.col j)) ∧ z - I * e (F.dir i) ∈ essSupport (c.cls (F.col i))) := by
--BEGIN-CONTACTS
  have hR0 : 0 < min F.r (1 / 2) := lt_min F.r_pos (by norm_num)
  have hRr : min F.r (1 / 2) ≤ F.r := min_le_left _ _
  by_cases hcommon : ∃ t ∈ Ioo 0 (min F.r (1 / 2)), ∃ y ∈ essSupport (c.cls (F.col j)),
      y ∈ essSupport (c.cls (F.col i)) ∧ dist (polarPt z t (F.φ i t)) y = 1
  · -- a common contact: the branch is an arc of the unit circle about it
    obtain ⟨t₀, ht₀, y, hya, hyb, hd⟩ := hcommon
    have hall := F.dist_eq_one_of_common_contact hij hya hyb ⟨ht₀.1, lt_of_lt_of_le ht₀.2 hRr⟩ hd
    have hall' : ∀ t ∈ Ioo 0 (min F.r (1 / 2)), dist (polarPt z t (F.φ i t)) y = 1 :=
      fun t ht => hall t ⟨ht.1, lt_of_lt_of_le ht.2 hRr⟩
    exact Or.inl ⟨y, F.eq_add_or_eq_sub_of_dist_eq_one i hR0 hall', hya, hyb, hall'⟩
  · -- none: every point of the branch's curve is of tangent type, and the contacts converge
    right
    have hno : ∀ t ∈ Ioo 0 (min F.r (1 / 2)), ∀ y ∈ essSupport (c.cls (F.col j)),
        y ∈ essSupport (c.cls (F.col i)) → dist (polarPt z t (F.φ i t)) y ≠ 1 :=
      fun t ht y hya hyb hd => hcommon ⟨t, ht, y, hya, hyb, hd⟩
    obtain ⟨L, γ, ψ, hL0, hLπ, hcurve, hγ0, hdir, hK⟩ := F.exists_unitCurve_branch hsat i
    have hpt := fun s hs => F.contacts_of_no_common hsat hij hLπ hcurve hγ0 hK hno (s := s) hs
    haveI hne : (𝓝[Ioo 0 L] (0 : ℝ)).NeBot := by
      rw [← mem_closure_iff_nhdsWithin_neBot, closure_Ioo hL0.ne]; exact left_mem_Icc.2 hL0.le
    have hsub : 𝓝[Ioo 0 L] (0 : ℝ) ≤ 𝓝[Icc 0 L] 0 := nhdsWithin_mono _ Ioo_subset_Icc_self
    have h0 : (0 : ℝ) ∈ Icc 0 L := left_mem_Icc.2 hL0.le
    have hγt : Tendsto γ (𝓝[Ioo 0 L] 0) (𝓝 z) := by
      have h1 := (hcurve.hasDeriv 0 h0).continuousWithinAt.tendsto.mono_left hsub
      rwa [hγ0] at h1
    have hψt : Tendsto (fun s => e (ψ s)) (𝓝[Ioo 0 L] 0) (𝓝 (e (F.dir i))) := by
      have h1 := ((continuous_e.tendsto _).comp (hcurve.lip.continuousOn 0 h0).tendsto).mono_left hsub
      rw [← hdir]; exact h1
    have hmem : ∀ᶠ s in 𝓝[Ioo 0 L] (0 : ℝ), s ∈ Ioo 0 L := self_mem_nhdsWithin
    exact ⟨(isClosed_essSupport _).mem_of_tendsto (hγt.add (hψt.const_mul I)) (hmem.mono fun s hs => (hpt s hs).1),
      (isClosed_essSupport _).mem_of_tendsto (hγt.sub (hψt.const_mul I)) (hmem.mono fun s hs => (hpt s hs).2)⟩
--END-CONTACTS

end Fan

end AeColouring

end HadwigerNelson.Plane
