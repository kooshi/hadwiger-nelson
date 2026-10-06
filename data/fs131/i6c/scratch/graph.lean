import Proofs.HadwigerNelson.Plane.Saturated.Pinch
import Proofs.HadwigerNelson.Plane.Saturated.Curve
namespace HadwigerNelson.Plane
open Complex Set MeasureTheory Filter Topology Metric

/-- A function within `K (u − u₀)²` of the line of slope `c` through `(u₀, g u₀)`, near `u₀`, has derivative `c`
there. -/
theorem hasDerivAt_of_sq_bound {g : ℝ → ℝ} {u₀ c K ε : ℝ} (hε : 0 < ε)
    (hb : ∀ u, |u - u₀| < ε → |g u - g u₀ - c * (u - u₀)| ≤ K * (u - u₀) ^ 2) : HasDerivAt g c u₀ := by
  rw [hasDerivAt_iff_isLittleO_nhds_zero, Asymptotics.isLittleO_iff]
  intro c' hc'
  have hK : 0 < |K| + 1 := by positivity
  have hδ : 0 < min ε (c' / (|K| + 1)) := lt_min hε (div_pos hc' hK)
  filter_upwards [Metric.ball_mem_nhds (0 : ℝ) hδ] with t ht
  rw [mem_ball, dist_zero_right, Real.norm_eq_abs, lt_min_iff] at ht
  have h1 := hb (u₀ + t) (by rw [add_sub_cancel_left]; exact ht.1)
  rw [add_sub_cancel_left] at h1
  have h2 : |t| * (|K| + 1) < c' := (lt_div_iff₀ hK).1 ht.2
  rw [Real.norm_eq_abs, Real.norm_eq_abs, smul_eq_mul, mul_comm t c]
  have h3 : K * t ^ 2 ≤ |K| * (|t| * |t|) := by
    rw [← pow_two, sq_abs]
    exact mul_le_mul_of_nonneg_right (le_abs_self K) (sq_nonneg _)
  nlinarith [abs_nonneg t, abs_nonneg K, mul_nonneg (abs_nonneg t) (abs_nonneg K)]

/-- The two-disc inequality in graph coordinates gives a Lipschitz bound. -/
theorem abs_le_of_two_disc_bound {a b n₁ n₂ : ℝ} (hn₁ : |n₁| ≤ 1) (hn₂ : 1 / 2 ≤ n₂) (ha : |a| ≤ 1)
    (hb : |b| ≤ 1 / 2) (h : |n₁ * a + n₂ * b| ≤ (a ^ 2 + b ^ 2) / 2) : |b| ≤ 6 * |a| := by
  have h1 : n₂ * |b| ≤ |n₁| * |a| + (a ^ 2 + b ^ 2) / 2 := by
    have := abs_sub_abs_le_abs_sub (n₂ * b) (-(n₁ * a))
    rw [sub_neg_eq_add, add_comm, abs_mul, abs_neg, abs_mul, abs_of_pos (by linarith : (0 : ℝ) < n₂)] at this
    linarith
  have h2 : a ^ 2 = |a| * |a| := by rw [← pow_two, sq_abs]
  have h3 : b ^ 2 = |b| * |b| := by rw [← pow_two, sq_abs]
  nlinarith [abs_nonneg a, abs_nonneg b, abs_nonneg n₁, mul_nonneg (abs_nonneg a) (abs_nonneg n₁)]

/-- The two-disc inequality in graph coordinates gives the derivative of the graph: `g′ = −n₁/n₂`. -/
theorem hasDerivAt_of_two_disc_bound {g : ℝ → ℝ} {u₀ n₁ n₂ ε : ℝ} (hε : 0 < ε) (hn₁ : |n₁| ≤ 1)
    (hn₂ : 1 / 2 ≤ n₂) (hg : ∀ u, |u - u₀| < ε → |g u - g u₀| ≤ 1 / 2)
    (hb : ∀ u, |u - u₀| < ε →
      |n₁ * (u - u₀) + n₂ * (g u - g u₀)| ≤ ((u - u₀) ^ 2 + (g u - g u₀) ^ 2) / 2) :
    HasDerivAt g (-n₁ / n₂) u₀ := by
  have hn₂0 : 0 < n₂ := by linarith
  refine hasDerivAt_of_sq_bound (K := 37) (lt_min hε one_pos) fun u hu => ?_
  rw [lt_min_iff] at hu
  have hL := abs_le_of_two_disc_bound hn₁ hn₂ hu.2.le (hg u hu.1) (hb u hu.1)
  have h1 := hb u hu.1
  have h2 : g u - g u₀ - -n₁ / n₂ * (u - u₀) = (n₁ * (u - u₀) + n₂ * (g u - g u₀)) / n₂ := by
    field_simp; ring
  rw [h2, abs_div, abs_of_pos hn₂0, div_le_iff₀ hn₂0]
  have h3 : (g u - g u₀) ^ 2 ≤ 36 * (u - u₀) ^ 2 := by
    rw [← sq_abs (g u - g u₀), ← sq_abs (u - u₀)]
    nlinarith [abs_nonneg (g u - g u₀), abs_nonneg (u - u₀)]
  nlinarith [sq_nonneg (u - u₀)]

/-- **The arclength reparametrization** (FS131-I6C; Mathlib has none): for a continuous speed `σ ≥ 1` on `[−h, h]`,
the inverse `V` of the arclength `u ↦ ∫₀^u σ` is defined on a symmetric interval `(−ℓ, ℓ)`, maps it increasingly onto
an interval `(a, b)` about `0` inside `[−h, h]`, and has derivative `1/σ (V s)`. (The integrand is `σ` clamped to
`[−h, h]`, so the arclength is an order isomorphism of the line and its inverse is continuous for free.) -/
theorem exists_arclength_inverse {σ : ℝ → ℝ} {h : ℝ} (hh : 0 < h) (hσc : ContinuousOn σ (Icc (-h) h))
    (hσ1 : ∀ u ∈ Icc (-h) h, 1 ≤ σ u) :
    ∃ (ℓ : ℝ) (V : ℝ → ℝ) (a b : ℝ), 0 < ℓ ∧ -h ≤ a ∧ a < 0 ∧ 0 < b ∧ b ≤ h ∧ V 0 = 0 ∧
      StrictMonoOn V (Ioo (-ℓ) ℓ) ∧ V '' Ioo (-ℓ) ℓ = Ioo a b ∧ ∀ s ∈ Ioo (-ℓ) ℓ, HasDerivAt V (σ (V s))⁻¹ s := by
  have hclamp : ∀ u : ℝ, max (-h) (min h u) ∈ Icc (-h) h := fun u =>
    ⟨le_max_left _ _, max_le (by linarith) (min_le_left _ _)⟩
  set σ' : ℝ → ℝ := fun u => σ (max (-h) (min h u)) with hσ'
  have hc : Continuous σ' := hσc.comp_continuous (by fun_prop) hclamp
  have h1 : ∀ u, 1 ≤ σ' u := fun u => hσ1 _ (hclamp u)
  have heq : ∀ u ∈ Icc (-h) h, σ' u = σ u := fun u hu => by
    simp only [hσ', min_eq_right hu.2, max_eq_right hu.1]
  set S : ℝ → ℝ := fun u => ∫ t in (0 : ℝ)..u, σ' t with hS
  have hSd : ∀ u, HasDerivAt S (σ' u) u := fun u => (hc.integral_hasStrictDerivAt 0 u).hasDerivAt
  have hS0 : S 0 = 0 := by simp [hS]
  have hmono : StrictMono S := strictMono_of_deriv_pos fun u => by
    rw [(hSd u).deriv]; linarith [h1 u]
  have hDd : ∀ u, HasDerivAt (fun u => S u - u) (σ' u - 1) u := fun u => (hSd u).sub (hasDerivAt_id' u)
  have hD : Monotone fun u => S u - u :=
    monotone_of_deriv_nonneg (fun u => (hDd u).differentiableAt) fun u => by
      rw [(hDd u).deriv]; linarith [h1 u]
  have hge : ∀ u, 0 ≤ u → u ≤ S u := fun u hu => by
    have h2 : S 0 - 0 ≤ S u - u := hD hu
    linarith
  have hle : ∀ u, u ≤ 0 → S u ≤ u := fun u hu => by
    have h2 : S u - u ≤ S 0 - 0 := hD hu
    linarith
  have hsurj : Function.Surjective S :=
    (continuous_iff_continuousAt.2 fun u => (hSd u).continuousAt).surjective
      (tendsto_atTop_mono' atTop ((eventually_ge_atTop 0).mono fun u hu => hge u hu) tendsto_id)
      (tendsto_atBot_mono' atBot ((eventually_le_atBot 0).mono fun u hu => hle u hu) tendsto_id)
  set E : ℝ ≃o ℝ := hmono.orderIsoOfSurjective S hsurj with hE
  have hES : ∀ u, E u = S u := fun u => rfl
  have hV0 : E.symm 0 = 0 := E.symm_apply_eq.2 hS0.symm
  set ℓ : ℝ := min (S h) (-S (-h)) with hℓ
  have hℓ0 : 0 < ℓ := lt_min (lt_of_lt_of_le hh (hge h hh.le)) (by linarith [hle (-h) (by linarith)])
  have ha : -h ≤ E.symm (-ℓ) := by
    rw [← E.symm_apply_apply (-h)]
    exact E.symm.monotone (by rw [hES]; linarith [min_le_right (S h) (-S (-h))])
  have hb : E.symm ℓ ≤ h := by
    rw [← E.symm_apply_apply h]
    exact E.symm.monotone (by rw [hES]; exact min_le_left _ _)
  refine ⟨ℓ, E.symm, E.symm (-ℓ), E.symm ℓ, hℓ0, ha, ?_, ?_, hb, hV0, E.symm.strictMono.strictMonoOn _,
    E.symm.image_Ioo _ _, fun s hs => ?_⟩
  · rw [← hV0]; exact E.symm.strictMono (by linarith)
  · rw [← hV0]; exact E.symm.strictMono hℓ0
  · have hmem : E.symm s ∈ Icc (-h) h :=
      ⟨ha.trans (E.symm.monotone hs.1.le), (E.symm.monotone hs.2.le).trans hb⟩
    rw [← heq _ hmem]
    exact HasDerivAt.of_local_left_inverse E.symm.continuous.continuousAt (hSd (E.symm s))
      (by linarith [h1 (E.symm s)]) (Eventually.of_forall fun t => E.apply_symm_apply t)


/-- The two-disc condition in coordinates: a point `d` outside the open unit discs about `±n` (a unit vector) has
`|⟨d, n⟩| ≤ ‖d‖²/2`. -/
theorem abs_inner_le_of_one_le {d n : ℂ} (hn : ‖n‖ = 1) (h1 : 1 ≤ ‖d - n‖) (h2 : 1 ≤ ‖d + n‖) :
    |d.re * n.re + d.im * n.im| ≤ (d.re ^ 2 + d.im ^ 2) / 2 := by
  have a := one_le_pow₀ (n := 2) h1
  have b := one_le_pow₀ (n := 2) h2
  have c : n.re ^ 2 + n.im ^ 2 = 1 := by rw [← sq_norm_eq, hn, one_pow]
  rw [sq_norm_eq, Complex.sub_re, Complex.sub_im] at a
  rw [sq_norm_eq, Complex.add_re, Complex.add_im] at b
  rw [abs_le]
  constructor <;> nlinarith

/-- A unit vector within `r` of `i` has imaginary part at least `1 − r²/2`. -/
theorem im_ge_of_norm_sub_I_le {n : ℂ} {r : ℝ} (hn : ‖n‖ = 1) (h : ‖n - I‖ ≤ r) : 1 - r ^ 2 / 2 ≤ n.im := by
  have c : n.re ^ 2 + n.im ^ 2 = 1 := by rw [← sq_norm_eq, hn, one_pow]
  have h2 : ‖n - I‖ ^ 2 ≤ r ^ 2 := pow_le_pow_left₀ (norm_nonneg _) h 2
  rw [sq_norm_eq, Complex.sub_re, Complex.sub_im, Complex.I_re, Complex.I_im] at h2
  nlinarith

/-- For a unit vector `N` with non-negative imaginary part, `e (−arcsin (re N)) = im N − (re N) i`: the tangent whose
normal is `N`. -/
theorem e_neg_arcsin_re {N : ℂ} (hN : ‖N‖ = 1) (him : 0 ≤ N.im) :
    e (-Real.arcsin N.re) = (N.im : ℂ) - (N.re : ℂ) * I := by
  have c : N.re ^ 2 + N.im ^ 2 = 1 := by rw [← sq_norm_eq, hN, one_pow]
  have h1 : -1 ≤ N.re := by nlinarith [sq_nonneg N.im]
  have h2 : N.re ≤ 1 := by nlinarith [sq_nonneg N.im]
  have h3 : 1 - N.re ^ 2 = N.im ^ 2 := by linarith
  rw [e_neg, Real.cos_arcsin, Real.sin_arcsin h1 h2, h3, Real.sqrt_sq him]

/-- **The graph theorem** (FS131-E8 § 3.1 (4), in graph coordinates; no measure, no colouring). Let `Zf` be a set with
a field `n` of unit normals at its points near `0`, such that near `0`: each point of `Zf` is outside the two open unit
discs about `z ± n z` at every other point `z` (§ 3.1 (3)(b)); `n` is 1-Lipschitz on `Zf` (the erratum's bound);
`0 ∈ Zf` with `n 0 = i`; and every vertical segment over `|u| < h` meets `Zf` at height at most `h`. Then `Zf`, in a
rectangle `(a, b) × (−h, h)`, is the image of an injective unit-speed curve `ζ` on `(−ℓ, ℓ)` with `ζ 0 = 0`, whose
tangent angle `φ` is 1-Lipschitz and whose normal `i e(φ s)` is `n (ζ s)`; and it is the graph of a continuous
`g`, `|g| < h/2`, over `(a, b)`. (Uniqueness on vertical segments, `|g u| ≤ u²`, `g′ = −n₁/n₂`,
`exists_arclength_inverse`, `lipschitzOnWith_of_chord`.) -/
theorem exists_unit_curve_of_two_discs {Zf : Set ℂ} {n : ℂ → ℂ} {h : ℝ} (hh : 0 < h) (hh1 : h ≤ 1 / 16)
    (hn : ∀ z ∈ Zf, ‖z‖ < 2 * h → ‖n z‖ = 1)
    (hb : ∀ z ∈ Zf, ∀ z' ∈ Zf, ‖z‖ < 2 * h → ‖z'‖ < 2 * h → 1 ≤ ‖z' - (z + n z)‖ ∧ 1 ≤ ‖z' - (z - n z)‖)
    (hc : ∀ z ∈ Zf, ∀ z' ∈ Zf, ‖z‖ < 2 * h → ‖z'‖ < 2 * h → ‖n z - n z'‖ ≤ ‖z - z'‖)
    (h0 : (0 : ℂ) ∈ Zf) (hn0 : n 0 = I)
    (hex : ∀ u : ℝ, |u| < h → ∃ v : ℝ, |v| ≤ h ∧ (u : ℂ) + v * I ∈ Zf) :
    ∃ (ℓ a b : ℝ) (ζ : ℝ → ℂ) (φ g : ℝ → ℝ), 0 < ℓ ∧ -h < a ∧ a < 0 ∧ 0 < b ∧ b < h ∧ ζ 0 = 0 ∧
      (∀ s ∈ Ioo (-ℓ) ℓ, HasDerivAt ζ (e (φ s)) s ∧ I * e (φ s) = n (ζ s)) ∧
      LipschitzOnWith 1 φ (Ioo (-ℓ) ℓ) ∧ InjOn ζ (Ioo (-ℓ) ℓ) ∧
      ζ '' Ioo (-ℓ) ℓ = Zf ∩ (Ioo a b ×ℂ Ioo (-h) h) ∧
      ContinuousOn g (Ioo a b) ∧ (∀ u ∈ Ioo a b, |g u| < h / 2) ∧
      ∀ z ∈ Ioo a b ×ℂ Ioo (-h) h, z ∈ Zf ↔ z.im = g z.re := by
  have hre : ∀ u v : ℝ, ((u : ℂ) + v * I).re = u := fun u v => by simp
  have him : ∀ u v : ℝ, ((u : ℂ) + v * I).im = v := fun u v => by simp
  have hnorm : ∀ z : ℂ, |z.re| < h → |z.im| ≤ h → ‖z‖ < 2 * h := fun z hu hv =>
    lt_of_le_of_lt (Complex.norm_le_abs_re_add_abs_im z) (by linarith)
  have hsmall : ∀ u v : ℝ, |u| < h → |v| ≤ h → ‖(u : ℂ) + v * I‖ < 2 * h := fun u v hu hv =>
    hnorm _ (by rwa [hre]) (by rwa [him])
  have h00 : ‖(0 : ℂ)‖ < 2 * h := by rw [norm_zero]; linarith
  -- the normal near `0`
  have himn : ∀ z ∈ Zf, ‖z‖ < 2 * h → 1 / 2 ≤ (n z).im ∧ |(n z).re| ≤ 1 ∧ (n z).im ≤ 1 := by
    intro z hz hzs
    have h1 := hc z hz 0 h0 hzs h00
    rw [hn0, sub_zero] at h1
    have h2 := im_ge_of_norm_sub_I_le (hn z hz hzs) h1
    have h3 := Complex.abs_re_le_norm (n z)
    have h4 := Complex.im_le_norm (n z)
    rw [hn z hz hzs] at h3 h4
    refine ⟨?_, h3, h4⟩
    nlinarith [norm_nonneg z]
  -- § 3.1 (3)(b) in coordinates
  have hA : ∀ z ∈ Zf, ∀ z' ∈ Zf, ‖z‖ < 2 * h → ‖z'‖ < 2 * h →
      |(n z).re * (z'.re - z.re) + (n z).im * (z'.im - z.im)| ≤
        ((z'.re - z.re) ^ 2 + (z'.im - z.im) ^ 2) / 2 := by
    intro z hz z' hz' hzs hzs'
    obtain ⟨h1, h2⟩ := hb z hz z' hz' hzs hzs'
    have e1 : z' - (z + n z) = z' - z - n z := by ring
    have e2 : z' - (z - n z) = z' - z + n z := by ring
    rw [e1] at h1
    rw [e2] at h2
    have h3 := abs_inner_le_of_one_le (hn z hz hzs) h1 h2
    simp only [Complex.sub_re, Complex.sub_im] at h3
    rwa [mul_comm (z'.re - z.re), mul_comm (z'.im - z.im)] at h3
  -- uniqueness on vertical segments
  have huniq : ∀ z ∈ Zf, ∀ z' ∈ Zf, z.re = z'.re → |z.re| < h → |z.im| ≤ h → |z'.im| ≤ h → z.im = z'.im := by
    intro z hz z' hz' hre' hu hv hv'
    have hzs := hnorm z hu hv
    have hzs' := hnorm z' (hre' ▸ hu) hv'
    have key := hA z hz z' hz' hzs hzs'
    rw [hre', sub_self, mul_zero, zero_add, abs_mul, abs_of_pos (by linarith [(himn z hz hzs).1] : 0 < (n z).im)]
      at key
    have him' := (himn z hz hzs).1
    by_contra hne
    have hpos : 0 < |z'.im - z.im| := abs_pos.2 (sub_ne_zero.2 (Ne.symm hne))
    have hd : |z'.im - z.im| ≤ 2 * h := by
      rw [abs_le] at hv hv' ⊢
      constructor <;> linarith
    have hsq : (z'.im - z.im) ^ 2 = |z'.im - z.im| * |z'.im - z.im| := by rw [← pow_two, sq_abs]
    nlinarith
  -- the graph function
  have hex' : ∀ u : ℝ, ∃ v : ℝ, |u| < h → |v| ≤ h ∧ (u : ℂ) + v * I ∈ Zf := fun u => by
    by_cases hu : |u| < h
    · obtain ⟨v, hv⟩ := hex u hu
      exact ⟨v, fun _ => hv⟩
    · exact ⟨0, fun h' => absurd h' hu⟩
  choose g hg using hex'
  have hG2 : ∀ z ∈ Zf, |z.re| < h → |z.im| ≤ h → z.im = g z.re := by
    intro z hz hu hv
    have := huniq z hz _ (hg z.re hu).2 (by rw [hre]) hu hv (by rw [him]; exact (hg z.re hu).1)
    rwa [him] at this
  have hG3 : ∀ u, |u| < h → |g u| ≤ u ^ 2 := by
    intro u hu
    have key := hA 0 h0 _ (hg u hu).2 h00 (hsmall u (g u) hu (hg u hu).1)
    rw [hn0] at key
    simp only [hre, him, Complex.zero_re, Complex.zero_im, sub_zero, Complex.I_re, Complex.I_im, zero_mul, one_mul,
      zero_add] at key
    have h1 := (hg u hu).1
    have hsq : g u ^ 2 = |g u| * |g u| := by rw [← pow_two, sq_abs]
    nlinarith [abs_nonneg (g u)]
  have hgh : ∀ u, |u| < h → |g u| < h / 2 := fun u hu => by
    have h1 := hG3 u hu
    have h2 : u ^ 2 = |u| * |u| := by rw [← pow_two, sq_abs]
    nlinarith [abs_nonneg u]
  have hlt : ∀ u u₀ : ℝ, |u₀| < h → |u - u₀| < h - |u₀| → |u| < h := fun u u₀ _ hu => by
    have := abs_sub_abs_le_abs_sub u u₀
    linarith
  have hgg : ∀ u u', |u| < h → |u'| < h → |g u' - g u| ≤ 1 / 2 := fun u u' hu hu' => by
    have h1 := hgh u hu
    have h2 := hgh u' hu'
    rw [abs_lt] at h1 h2
    rw [abs_le]
    constructor <;> linarith
  have hgd : ∀ u₀, |u₀| < h → HasDerivAt g (-(n ((u₀ : ℂ) + g u₀ * I)).re / (n ((u₀ : ℂ) + g u₀ * I)).im) u₀ := by
    intro u₀ hu₀
    have hz₀ := (hg u₀ hu₀).2
    have hs₀ := hsmall u₀ (g u₀) hu₀ (hg u₀ hu₀).1
    obtain ⟨i1, i2, -⟩ := himn _ hz₀ hs₀
    refine hasDerivAt_of_two_disc_bound (sub_pos.2 hu₀) i2 i1 (fun u hu => hgg u₀ u hu₀ (hlt u u₀ hu₀ hu))
      (fun u hu => ?_)
    have hu' := hlt u u₀ hu₀ hu
    have key := hA _ hz₀ _ (hg u hu').2 hs₀ (hsmall u (g u) hu' (hg u hu').1)
    simpa only [hre, him] using key
  have hglip : ∀ u u', |u| < h → |u'| < h → |g u' - g u| ≤ 6 * |u' - u| := by
    intro u u' hu hu'
    have hs := hsmall u (g u) hu (hg u hu).1
    obtain ⟨i1, i2, -⟩ := himn _ (hg u hu).2 hs
    have key := hA _ (hg u hu).2 _ (hg u' hu').2 hs (hsmall u' (g u') hu' (hg u' hu').1)
    simp only [hre, him] at key
    refine abs_le_of_two_disc_bound i2 i1 ?_ (hgg u u' hu hu') key
    rw [abs_lt] at hu hu'
    rw [abs_le]
    constructor <;> linarith
  have hNlip : ∀ u u', |u| < h → |u'| < h →
      ‖n ((u : ℂ) + g u * I) - n ((u' : ℂ) + g u' * I)‖ ≤ 7 * |u - u'| := by
    intro u u' hu hu'
    have h1 := hc _ (hg u hu).2 _ (hg u' hu').2 (hsmall u (g u) hu (hg u hu).1)
      (hsmall u' (g u') hu' (hg u' hu').1)
    have e1 : (u : ℂ) + g u * I - ((u' : ℂ) + g u' * I) = ((u - u' : ℝ) : ℂ) + ((g u - g u' : ℝ) : ℂ) * I := by
      push_cast; ring
    have h2 := Complex.norm_le_abs_re_add_abs_im ((u : ℂ) + g u * I - ((u' : ℂ) + g u' * I))
    rw [e1, hre, him] at h2
    rw [e1] at h1
    have h3 := hglip u' u hu' hu
    linarith
  have hNc : ContinuousOn (fun u : ℝ => n ((u : ℂ) + g u * I)) (Ioo (-h) h) :=
    LipschitzOnWith.continuousOn (K := 7) (LipschitzOnWith.of_dist_le_mul fun u hu u' hu' => by
      simpa [dist_eq_norm, Real.dist_eq] using hNlip u u' (abs_lt.2 hu) (abs_lt.2 hu'))
  -- the arclength parameter
  have hmem : ∀ u ∈ Icc (-(h / 2)) (h / 2), |u| < h := fun u hu => by
    rw [abs_lt]; constructor <;> linarith [hu.1, hu.2]
  have hσc : ContinuousOn (fun u : ℝ => ((n ((u : ℂ) + g u * I)).im)⁻¹) (Icc (-(h / 2)) (h / 2)) := by
    refine ContinuousOn.inv₀ ((Complex.continuous_im.comp_continuousOn hNc).mono fun u hu => abs_lt.1 (hmem u hu))
      fun u hu => ?_
    have := (himn _ (hg u (hmem u hu)).2 (hsmall u (g u) (hmem u hu) (hg u (hmem u hu)).1)).1
    exact ne_of_gt (by linarith)
  have hσ1 : ∀ u ∈ Icc (-(h / 2)) (h / 2), 1 ≤ ((n ((u : ℂ) + g u * I)).im)⁻¹ := fun u hu => by
    obtain ⟨i1, -, i3⟩ := himn _ (hg u (hmem u hu)).2 (hsmall u (g u) (hmem u hu) (hg u (hmem u hu)).1)
    exact (one_le_inv₀ (by linarith)).2 i3
  obtain ⟨ℓ, V, a, b, hℓ, ha, ha0, hb0, hbh, hV0, hVmono, hVimg, hVd⟩ :=
    exists_arclength_inverse (half_pos hh) hσc hσ1
  have hVab : ∀ s ∈ Ioo (-ℓ) ℓ, V s ∈ Ioo a b := fun s hs => hVimg ▸ mem_image_of_mem V hs
  have habh : ∀ u ∈ Ioo a b, |u| < h := fun u hu => by
    rw [abs_lt]; constructor <;> linarith [hu.1, hu.2]
  have hVh : ∀ s ∈ Ioo (-ℓ) ℓ, |V s| < h := fun s hs => habh _ (hVab s hs)
  have hζZ : ∀ s ∈ Ioo (-ℓ) ℓ, (V s : ℂ) + g (V s) * I ∈ Zf ∧ ‖(V s : ℂ) + g (V s) * I‖ < 2 * h := fun s hs =>
    ⟨(hg _ (hVh s hs)).2, hsmall _ _ (hVh s hs) (hg _ (hVh s hs)).1⟩
  have hg0 : g 0 = 0 := by
    have := hG3 0 (by rw [abs_zero]; exact hh)
    rw [zero_pow two_ne_zero] at this
    exact abs_eq_zero.1 (le_antisymm this (abs_nonneg _))
  -- the tangent and its angle
  have hIe : ∀ s ∈ Ioo (-ℓ) ℓ,
      I * e (-Real.arcsin (n ((V s : ℂ) + g (V s) * I)).re) = n ((V s : ℂ) + g (V s) * I) := by
    intro s hs
    obtain ⟨hz, hzs⟩ := hζZ s hs
    rw [e_neg_arcsin_re (hn _ hz hzs) (by linarith [(himn _ hz hzs).1])]
    apply Complex.ext <;> simp
  have hζd : ∀ s ∈ Ioo (-ℓ) ℓ, HasDerivAt (fun s => (V s : ℂ) + g (V s) * I)
      (e (-Real.arcsin (n ((V s : ℂ) + g (V s) * I)).re)) s := by
    intro s hs
    obtain ⟨hz, hzs⟩ := hζZ s hs
    obtain ⟨i1, -, -⟩ := himn _ hz hzs
    have hV := hVd s hs
    rw [inv_inv] at hV
    have hgV := (hgd (V s) (hVh s hs)).comp s hV
    have hd := hV.ofReal_comp.add (hgV.ofReal_comp.mul_const I)
    refine hd.congr_deriv ?_
    have hr : -(n ((V s : ℂ) + g (V s) * I)).re / (n ((V s : ℂ) + g (V s) * I)).im *
        (n ((V s : ℂ) + g (V s) * I)).im = -(n ((V s : ℂ) + g (V s) * I)).re :=
      div_mul_cancel₀ _ (ne_of_gt (by linarith))
    rw [e_neg_arcsin_re (hn _ hz hzs) (by linarith), hr]
    push_cast
    ring
  have hζlip : ∀ s ∈ Ioo (-ℓ) ℓ, ∀ s' ∈ Ioo (-ℓ) ℓ,
      ‖((V s : ℂ) + g (V s) * I) - ((V s' : ℂ) + g (V s') * I)‖ ≤ |s - s'| := by
    intro s hs s' hs'
    have := Convex.norm_image_sub_le_of_norm_hasDerivWithin_le (f := fun s => (V s : ℂ) + g (V s) * I)
      (fun x hx => (hζd x hx).hasDerivWithinAt) (fun x _ => (norm_e _).le) (convex_Ioo (-ℓ) ℓ) hs' hs
    simpa [Real.norm_eq_abs] using this
  have hVc : ContinuousOn V (Ioo (-ℓ) ℓ) := fun s hs => (hVd s hs).continuousAt.continuousWithinAt
  have hφc : ContinuousOn (fun s => -Real.arcsin (n ((V s : ℂ) + g (V s) * I)).re) (Ioo (-ℓ) ℓ) := by
    have h1 : ContinuousOn (fun s => n ((V s : ℂ) + g (V s) * I)) (Ioo (-ℓ) ℓ) :=
      hNc.comp hVc fun s hs => abs_lt.1 (hVh s hs)
    exact (Real.continuous_arcsin.comp_continuousOn (Complex.continuous_re.comp_continuousOn h1)).neg
  have hφlip : LipschitzOnWith 1 (fun s => -Real.arcsin (n ((V s : ℂ) + g (V s) * I)).re) (Ioo (-ℓ) ℓ) :=
    lipschitzOnWith_of_chord ordConnected_Ioo hφc fun s hs s' hs' => by
      have e1 : ∀ p q : ℂ, ‖p - q‖ = ‖I * p - I * q‖ := fun p q => by
        rw [← mul_sub, norm_mul, Complex.norm_I, one_mul]
      rw [e1, hIe s hs, hIe s' hs']
      exact (hc _ (hζZ s hs).1 _ (hζZ s' hs').1 (hζZ s hs).2 (hζZ s' hs').2).trans (hζlip s hs s' hs')
  refine ⟨ℓ, a, b, fun s => (V s : ℂ) + g (V s) * I, fun s => -Real.arcsin (n ((V s : ℂ) + g (V s) * I)).re, g,
    hℓ, by linarith, ha0, hb0, by linarith, ?_, fun s hs => ⟨hζd s hs, hIe s hs⟩, hφlip, ?_, ?_, ?_,
    fun u hu => hgh u (habh u hu), ?_⟩
  · simp [hV0, hg0]
  · intro s hs s' hs' heq
    have h1 := congrArg Complex.re heq
    simp only [hre] at h1
    exact hVmono.injOn hs hs' h1
  · ext z
    constructor
    · rintro ⟨s, hs, rfl⟩
      refine ⟨(hζZ s hs).1, ?_⟩
      rw [Complex.mem_reProdIm, hre, him]
      have h1 := hgh _ (hVh s hs)
      rw [abs_lt] at h1
      exact ⟨hVab s hs, by linarith, by linarith⟩
    · rintro ⟨hz, hzbox⟩
      rw [Complex.mem_reProdIm] at hzbox
      have hu := habh _ hzbox.1
      obtain ⟨s, hs, hVs⟩ : z.re ∈ V '' Ioo (-ℓ) ℓ := hVimg ▸ hzbox.1
      refine ⟨s, hs, ?_⟩
      apply Complex.ext
      · rw [hre, hVs]
      · rw [him, hVs, hG2 z hz hu (abs_lt.2 hzbox.2).le]
  · exact fun u hu => (hgd u (habh u hu)).continuousAt.continuousWithinAt
  · intro z hzbox
    rw [Complex.mem_reProdIm] at hzbox
    have hu := habh _ hzbox.1
    refine ⟨fun hz => hG2 z hz hu (abs_lt.2 hzbox.2).le, fun hzg => ?_⟩
    have h1 := (hg z.re hu).2
    rwa [← hzg, Complex.re_add_im] at h1

end HadwigerNelson.Plane
