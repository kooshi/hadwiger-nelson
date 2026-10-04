import Proofs.HadwigerNelson.Plane.Cover
import Proofs.HadwigerNelson.Arith.FalconerFan
import Proofs.HadwigerNelson.UnitDistance
import Mathlib.NumberTheory.Real.Irrational
import Mathlib.MeasureTheory.Function.Jacobian
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.Calculus.InverseFunctionTheorem.ContDiff
import Mathlib.MeasureTheory.Measure.Lebesgue.Complex
import Mathlib.Dynamics.Ergodic.AddCircleAdd
import Mathlib.Dynamics.Ergodic.Function

/-!
# Falconer's reduction: a Falconer fan with an irrational angle gives `χ_m(ℝ²) ≥ k + 1` (FS-131 wave 2)

Row: **FS129-SA1-FALC-RED** (FS129-OA1-FALC-RED's statement from FS129-SA1-FALC-RED's argument, SA1 item 6). Plan:
`plans/FS131-w2-kernel-plan.md` §§ 3–4. `[Falconer1981]` Lemma 1 is **formalized**, not imported, in the measurable form
the argument reads (`falconer_lemma1`), through the two-circle lemma (`twoCircle_preimage_null`), which the Rajchman step
of `Plane/Slack` also uses. Lemmas 2–4 are the argument's children (the implementer's).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric HadwigerNelson HadwigerNelson.Arith

/-- `χ_m(ℝ²)` (Falconer's, everywhere-proper): the least `k` with a measurable `k`-colouring proper at every unit pair. -/
noncomputable def chiM : ℕ∞ :=
  ⨅ (k : ℕ) (_ : ∃ f : ℂ → Fin k, Measurable f ∧ ∀ x y, dist x y = 1 → f x ≠ f y), (k : ℕ∞)

/-- Spec: `sq9` bounds `χ_m(ℝ²)` by `9`. -/
example : chiM ≤ 9 := iInf₂_le 9 ⟨sq9Col, measurable_sq9Col, fun _ _ h => sq9Col_ne_of_dist_eq_one h⟩

/-- `θ ↦ e θ` has derivative `e θ · i`. -/
theorem hasDerivAt_e (θ : ℝ) : HasDerivAt e (e θ * I) θ := by
  have h : HasDerivAt (fun θ : ℝ => (θ : ℂ) * I) (1 * I) θ := (Complex.ofRealCLM.hasDerivAt).mul_const I
  have := h.cexp
  show HasDerivAt (fun x : ℝ => cexp (x * I)) (e θ * I) θ
  convert this using 1
  simp [e]

/-- `e` is smooth. -/
theorem contDiff_e : ContDiff ℝ 1 e := by
  unfold e
  exact (Complex.contDiff_exp.comp (Complex.ofRealCLM.contDiff.mul contDiff_const))

/-- The two-circle map on `ℂ ≅ ℝ²`. -/
noncomputable def twoCircleMap (z₀ : ℂ) (r₁ r₂ : ℝ) (w : ℂ) : ℂ := z₀ + r₁ * e w.re + r₂ * e w.im

/-- The two-circle map is `C¹`. -/
theorem contDiff_twoCircleMap (z₀ : ℂ) (r₁ r₂ : ℝ) : ContDiff ℝ 1 (twoCircleMap z₀ r₁ r₂) := by
  unfold twoCircleMap
  have h1 : ContDiff ℝ 1 fun w : ℂ => e w.re := contDiff_e.comp Complex.reCLM.contDiff
  have h2 : ContDiff ℝ 1 fun w : ℂ => e w.im := contDiff_e.comp Complex.imCLM.contDiff
  exact (contDiff_const.add (contDiff_const.mul h1)).add (contDiff_const.mul h2)

/-- Its derivative at `w`. -/
noncomputable def twoCircleDeriv (r₁ r₂ : ℝ) (w : ℂ) : ℂ →L[ℝ] ℂ :=
  (Complex.reCLM.smulRight ((r₁ : ℂ) * (e w.re * I))) + (Complex.imCLM.smulRight ((r₂ : ℂ) * (e w.im * I)))

/-- Its Fréchet derivative. -/
theorem hasFDerivAt_twoCircleMap (z₀ : ℂ) (r₁ r₂ : ℝ) (w : ℂ) :
    HasFDerivAt (twoCircleMap z₀ r₁ r₂) (twoCircleDeriv r₁ r₂ w) w := by
  have h1 : HasFDerivAt (fun w : ℂ => e w.re) (Complex.reCLM.smulRight (e w.re * I)) w :=
    ((hasDerivAt_e w.re).hasFDerivAt).comp w Complex.reCLM.hasFDerivAt
  have h2 : HasFDerivAt (fun w : ℂ => e w.im) (Complex.imCLM.smulRight (e w.im * I)) w :=
    ((hasDerivAt_e w.im).hasFDerivAt).comp w Complex.imCLM.hasFDerivAt
  have := ((h1.const_smul r₁).const_add z₀).add (h2.const_smul r₂)
  have hf : twoCircleMap z₀ r₁ r₂ = (fun x : ℂ => z₀ + r₁ • e x.re) + fun y : ℂ => r₂ • e y.im := by
    funext x; simp [twoCircleMap, Complex.real_smul, add_assoc]
  rw [hf]
  refine HasFDerivAt.congr_fderiv this ?_
  ext h
  simp [twoCircleDeriv, Complex.real_smul]
  ring

/-- Where `sin (w.im - w.re) ≠ 0` the derivative is invertible. -/
theorem twoCircleDeriv_injective {r₁ r₂ : ℝ} (h₁ : 0 < r₁) (h₂ : 0 < r₂) {w : ℂ}
    (hw : Real.sin (w.im - w.re) ≠ 0) : Function.Injective (twoCircleDeriv r₁ r₂ w) := by
  rw [injective_iff_map_eq_zero]
  intro h hh
  simp only [twoCircleDeriv, add_apply, ContinuousLinearMap.smulRight_apply, Complex.reCLM_apply,
    Complex.imCLM_apply, Complex.real_smul, e_eq] at hh
  have hre := congrArg Complex.re hh
  have him := congrArg Complex.im hh
  simp [Complex.sin_ofReal_re, Complex.cos_ofReal_re] at hre him
  set s := w.re; set φ := w.im
  have key1 : h.re * r₁ * Real.sin (φ - s) = 0 := by
    rw [Real.sin_sub]; linear_combination (Real.sin φ) * him + (Real.cos φ) * hre
  have key2 : h.im * r₂ * Real.sin (φ - s) = 0 := by
    rw [Real.sin_sub]; linear_combination (-(Real.cos s)) * hre + (-(Real.sin s)) * him
  have a1 : h.re = 0 := by
    have := mul_eq_zero.1 key1
    rcases this with h' | h'
    · rcases mul_eq_zero.1 h' with h'' | h''
      · exact h''
      · exact absurd h'' h₁.ne'
    · exact absurd h' hw
  have a2 : h.im = 0 := by
    have := mul_eq_zero.1 key2
    rcases this with h' | h'
    · rcases mul_eq_zero.1 h' with h'' | h''
      · exact h''
      · exact absurd h'' h₂.ne'
    · exact absurd h' hw
  exact Complex.ext a1 a2
/-- A `C¹` self-map of `ℂ` whose derivative is invertible on an open set `U` pulls null sets back to null sets inside `U`. -/
theorem preimage_inter_null_of_invertible_deriv {F : ℂ → ℂ} (hF : ContDiff ℝ 1 F) {U : Set ℂ} (hU : IsOpen U)
    (hD : ∀ w ∈ U, ∃ f' : ℂ ≃L[ℝ] ℂ, HasFDerivAt F (f' : ℂ →L[ℝ] ℂ) w) {N : Set ℂ} (hN : volume N = 0) :
    volume (F ⁻¹' N ∩ U) = 0 := by
  choose! D hD using hD
  let φ : U → OpenPartialHomeomorph ℂ ℂ := fun w =>
    (hF.contDiffAt (x := w.1)).toOpenPartialHomeomorph F (hD w.1 w.2) (by norm_num)
  let V : U → Set ℂ := fun w => (φ w).source ∩ U
  have hVo : ∀ w, IsOpen (V w) := fun w => (φ w).open_source.inter hU
  obtain ⟨T, hT, hTU⟩ := TopologicalSpace.isOpen_iUnion_countable V hVo
  have hcov : F ⁻¹' N ∩ U ⊆ ⋃ w ∈ T, (φ w).symm '' (N ∩ (φ w).target ∩ (φ w).symm ⁻¹' U) := by
    rintro z ⟨hzN, hzU⟩
    have hz : z ∈ ⋃ w, V w := mem_iUnion.2 ⟨⟨z, hzU⟩, (hF.contDiffAt (x := z)).mem_toOpenPartialHomeomorph_source (hD z hzU) (by norm_num), hzU⟩
    rw [← hTU] at hz
    obtain ⟨w, hwT, hzw, -⟩ := mem_iUnion₂.1 hz
    refine mem_iUnion₂.2 ⟨w, hwT, ?_⟩
    have hzs : z ∈ (φ w).source := hzw
    have hFz : F z = (φ w) z := rfl
    refine ⟨F z, ⟨⟨hzN, ?_⟩, ?_⟩, ?_⟩
    · rw [hFz]; exact (φ w).map_source hzs
    · show (φ w).symm (F z) ∈ U
      rw [hFz, (φ w).left_inv hzs]; exact hzU
    · rw [hFz, (φ w).left_inv hzs]
  refine measure_mono_null hcov (measure_biUnion_null_iff hT |>.2 fun w _ => ?_)
  refine addHaar_image_eq_zero_of_differentiableOn_of_addHaar_eq_zero volume ?_ ?_
  · intro a ha
    have hsym : (φ w).symm a ∈ U := ha.2
    have hat : a ∈ (φ w).target := ha.1.2
    refine DifferentiableAt.differentiableWithinAt ?_
    have hc : ContDiffAt ℝ 1 (φ w).symm a := by
      refine (φ w).contDiffAt_symm hat (f₀' := D ((φ w).symm a)) ?_ (hF.contDiffAt (x := (φ w).symm a))
      exact hD _ hsym
    exact hc.differentiableAt (by norm_num)
  · exact measure_mono_null (fun a ha => ha.1.1) hN

/-- The lines `φ = s + nπ` are null. -/
theorem volume_sinZero_null : volume {w : ℂ | Real.sin (w.im - w.re) = 0} = 0 := by
  have hm : MeasurableSet {q : ℝ × ℝ | Real.sin (q.2 - q.1) = 0} :=
    (isClosed_eq (Real.continuous_sin.comp (continuous_snd.sub continuous_fst)) continuous_const).measurableSet
  have hq : volume {q : ℝ × ℝ | Real.sin (q.2 - q.1) = 0} = 0 := by
    rw [Measure.volume_eq_prod, Measure.measure_prod_null hm]
    refine Eventually.of_forall fun s => ?_
    have : Prod.mk s ⁻¹' {q : ℝ × ℝ | Real.sin (q.2 - q.1) = 0} = (fun n : ℤ => s + n * Real.pi) '' univ := by
      ext φ
      simp only [mem_preimage, mem_setOf_eq, Real.sin_eq_zero_iff, mem_image, mem_univ, true_and]
      constructor
      · rintro ⟨n, hn⟩; exact ⟨n, by linarith⟩
      · rintro ⟨n, rfl⟩; exact ⟨n, by ring⟩
    show volume (Prod.mk s ⁻¹' _) = 0
    rw [this]
    exact (countable_univ.image _).measure_zero _
  have := Complex.volume_preserving_equiv_real_prod.measure_preimage_equiv {q : ℝ × ℝ | Real.sin (q.2 - q.1) = 0}
  rw [← hq, ← this]
  rfl


/-- **The two-circle lemma**: for `r₁, r₂ > 0`, `(s, φ) ↦ z₀ + r₁ e s + r₂ e φ` pulls null sets back to null sets. -/
theorem twoCircle_preimage_null (z₀ : ℂ) {r₁ r₂ : ℝ} (h₁ : 0 < r₁) (h₂ : 0 < r₂) {N : Set ℂ} (hN : volume N = 0) :
    (volume : Measure (ℝ × ℝ)) ((fun q : ℝ × ℝ => z₀ + r₁ * e q.1 + r₂ * e q.2) ⁻¹' N) = 0 := by
  set U : Set ℂ := {w | Real.sin (w.im - w.re) ≠ 0} with hUdef
  have hU : IsOpen U := isOpen_ne_fun (Real.continuous_sin.comp (Complex.continuous_im.sub Complex.continuous_re)) continuous_const
  have hD : ∀ w ∈ U, ∃ f' : ℂ ≃L[ℝ] ℂ, HasFDerivAt (twoCircleMap z₀ r₁ r₂) (f' : ℂ →L[ℝ] ℂ) w := by
    intro w hw
    let L : ℂ ≃ₗ[ℝ] ℂ := LinearEquiv.ofInjectiveEndo (twoCircleDeriv r₁ r₂ w).toLinearMap
      (twoCircleDeriv_injective h₁ h₂ hw)
    refine ⟨L.toContinuousLinearEquiv, ?_⟩
    have : ((L.toContinuousLinearEquiv : ℂ ≃L[ℝ] ℂ) : ℂ →L[ℝ] ℂ) = twoCircleDeriv r₁ r₂ w := by
      ext h; simp [L, LinearEquiv.ofInjectiveEndo]
    rw [this]; exact hasFDerivAt_twoCircleMap z₀ r₁ r₂ w
  have h1 := preimage_inter_null_of_invertible_deriv (contDiff_twoCircleMap z₀ r₁ r₂) hU hD hN
  have h2 : volume (twoCircleMap z₀ r₁ r₂ ⁻¹' N ∩ Uᶜ) = 0 :=
    measure_mono_null (fun w hw => by simpa [hUdef] using hw.2) volume_sinZero_null
  have h3 : volume (twoCircleMap z₀ r₁ r₂ ⁻¹' N) = 0 := by
    refine measure_mono_null (fun w hw => ?_) (measure_union_null h1 h2)
    by_cases hwU : w ∈ U
    · exact Or.inl ⟨hw, hwU⟩
    · exact Or.inr ⟨hw, hwU⟩
  have := Complex.volume_preserving_equiv_real_prod.symm.measure_preimage_equiv (twoCircleMap z₀ r₁ r₂ ⁻¹' N)
  have e1 : (fun q : ℝ × ℝ => z₀ + r₁ * e q.1 + r₂ * e q.2) ⁻¹' N =
      Complex.measurableEquivRealProd.symm ⁻¹' (twoCircleMap z₀ r₁ r₂ ⁻¹' N) := rfl
  rw [e1, this, h3]

/-- The doubly-rotated slice: for a measurable null `E`, almost every `θ` has a null set of `φ` with
`p₀ + e θ d₀ + e φ d₁ ∈ E` (nonzero `d₀, d₁`). -/
theorem slice_slice_null {E : Set ℂ} (hEm : MeasurableSet E) (hE0 : volume E = 0) (p₀ : ℂ) {d₀ d₁ : ℂ}
    (h₀ : d₀ ≠ 0) (h₁ : d₁ ≠ 0) :
    volume {θ : ℝ | volume {φ : ℝ | p₀ + e θ * d₀ + e φ * d₁ ∈ E} ≠ 0} = 0 := by
  set r₀ := ‖d₀‖
  set r₁ := ‖d₁‖
  have hr₀ : 0 < r₀ := norm_pos_iff.2 h₀
  have hr₁ : 0 < r₁ := norm_pos_iff.2 h₁
  set a₀ := Complex.arg d₀
  set a₁ := Complex.arg d₁
  set G : ℝ × ℝ → ℂ := fun q => p₀ + r₀ * e q.1 + r₁ * e q.2 with hG
  have hGm : Measurable G := by
    have : Continuous G := by
      refine (continuous_const.add (continuous_const.mul (continuous_e.comp continuous_fst))).add
        (continuous_const.mul (continuous_e.comp continuous_snd))
      
    exact this.measurable
  have hpre : (volume : Measure (ℝ × ℝ)) (G ⁻¹' E) = 0 := twoCircle_preimage_null p₀ hr₀ hr₁ hE0
  set S : Set (ℝ × ℝ) := {q | p₀ + e q.1 * d₀ + e q.2 * d₁ ∈ E} with hS
  have hSeq : S = (Prod.map (· + a₀) (· + a₁)) ⁻¹' (G ⁻¹' E) := by
    ext q
    simp only [hS, hG, mem_setOf_eq, mem_preimage, Prod.map_fst, Prod.map_snd, e_add]
    have h0 := eq_norm_mul_e_arg d₀
    have h1 := eq_norm_mul_e_arg d₁
    have : p₀ + e q.1 * d₀ + e q.2 * d₁ = p₀ + (r₀ : ℂ) * (e q.1 * e a₀) + (r₁ : ℂ) * (e q.2 * e a₁) := by
      conv_lhs => rw [h0, h1]
      ring
    rw [this]
  have hmp : MeasurePreserving (Prod.map (· + a₀) (· + a₁)) (volume : Measure (ℝ × ℝ)) volume := by
    rw [Measure.volume_eq_prod]
    exact (measurePreserving_add_right volume a₀).prod (measurePreserving_add_right volume a₁)
  have hSnull : (volume : Measure (ℝ × ℝ)) S = 0 := by
    rw [hSeq, hmp.measure_preimage (hGm hEm).nullMeasurableSet]; exact hpre
  have hSm : MeasurableSet S := by
    have : Continuous fun q : ℝ × ℝ => p₀ + e q.1 * d₀ + e q.2 * d₁ :=
      (continuous_const.add ((continuous_e.comp continuous_fst).mul continuous_const)).add
        ((continuous_e.comp continuous_snd).mul continuous_const)
    exact this.measurable hEm
  rw [Measure.volume_eq_prod, Measure.measure_prod_null hSm] at hSnull
  have := hSnull
  rw [Filter.EventuallyEq, ae_iff] at this
  exact this

/-- **`[Falconer1981]` Lemma 1, measurable form** (formalized; the paper's statement is for every null `E`, its proof is
not printed): for a nonempty measurable null `E`, a countable configuration `C` and `x ∈ C`, some translation `p` puts
`p x ∈ E` with almost every rotation `ρ` of `p(C)` about `p x` meeting `E` only at `p x`. -/
theorem falconer_lemma1 {E : Set ℂ} (hEm : MeasurableSet E) (hE : E.Nonempty) (hE0 : volume E = 0) {C : Set ℂ}
    (hC : C.Countable) {x : ℂ} (hx : x ∈ C) :
    ∃ v : ℂ, x + v ∈ E ∧ ∀ᵐ θ ∂arcLength, ∀ y ∈ C, x + v + e θ * (y - x) ∈ E → y = x := by
  have _ := hx
  by_contra hcon
  push Not at hcon
  -- every `p ∈ E` has a witness `y ≠ x` whose rotation circle meets `E` in positive arc
  have hbad : ∀ p ∈ E, ∃ y ∈ C, y ≠ x ∧ arcLength {θ | p + e θ * (y - x) ∈ E} ≠ 0 := by
    intro p hp
    have h := hcon (p - x) (by simpa using hp)
    by_contra hno
    push Not at hno
    refine h ?_
    have hall : ∀ y ∈ C, ∀ᵐ θ ∂arcLength, ¬ (y ≠ x ∧ p + e θ * (y - x) ∈ E) := by
      intro y hy
      by_cases hyx : y = x
      · exact Eventually.of_forall fun θ h => h.1 hyx
      · have := hno y hy hyx
        filter_upwards [measure_eq_zero_iff_ae_notMem.1 this] with θ hθ h
        exact hθ h.2
    have hall' := (MeasureTheory.ae_ball_iff hC (μ := arcLength) (p := fun θ y _ => ¬ (y ≠ x ∧ p + e θ * (y - x) ∈ E))).2 hall
    filter_upwards [hall'] with θ hθ ⟨y, hy, hyE, hyx⟩
    refine hθ y hy ⟨hyx, ?_⟩
    simpa using hyE
  obtain ⟨p₀, hp₀⟩ := hE
  obtain ⟨y₀, hy₀, hy₀x, hpos⟩ := hbad p₀ hp₀
  set A₁ : Set ℝ := {θ | p₀ + e θ * (y₀ - x) ∈ E} with hA₁
  -- the second-level bad sets
  have hcover : A₁ ⊆ ⋃ y ∈ {y ∈ C | y ≠ x}, {θ : ℝ | volume {φ : ℝ | p₀ + e θ * (y₀ - x) + e φ * (y - x) ∈ E} ≠ 0} := by
    intro θ hθ
    obtain ⟨y, hy, hyx, hyp⟩ := hbad _ hθ
    refine mem_iUnion₂.2 ⟨y, ⟨hy, hyx⟩, ?_⟩
    intro hz
    apply hyp
    exact nonpos_iff_eq_zero.1 ((Measure.le_iff'.1 Measure.restrict_le_self _).trans hz.le)
  have hnull : volume A₁ = 0 := by
    refine measure_mono_null hcover ((measure_biUnion_null_iff (hC.mono fun y hy => hy.1)).2 fun y hy => ?_)
    exact slice_slice_null hEm hE0 p₀ (sub_ne_zero.2 hy₀x.symm.symm) (sub_ne_zero.2 hy.2)
  exact hpos (nonpos_iff_eq_zero.1 ((Measure.le_iff'.1 Measure.restrict_le_self _).trans hnull.le))

/-! ## FS131-K2c: Lemmas 2–4 and the assembly (each `sorry`ed but the import; plan `plans/FS131-w2-kernel-plan.md` § 12)

FS129-MA1 § 2.2's order: disjointify the cover; `E` (the points that are density points of no class) is null, measurable
and — by `[Falconer1981]` Lemma 2 (i), imported below — nonempty; `falconer_lemma1` places the apex at a point of `E` with
almost every rotation sending every other vertex into some class's density set; two classes are present at the apex (D2);
the density-set colouring of `H − a` is proper and avoids those two classes on `N(a)` (Lemma 3,
`essClosure_dist_ne_one_of_mem_densitySet`); the fan puts the tip's circle a.e. in the two density sets; Lemma 4 (an
irrational rotation) refutes that. -/

/-- **`[Falconer1981]` Lemma 2 (i), p. 185 — imported** (`LEAN.md` § Assumptions; a declared purchase,
`ARCHITECTURE.md` § Trust): a measurable `S ⊆ ℝ²` with `v(S) > 0` and `v(ℝ² ∖ S) > 0` has a nonempty metrical boundary — a
point where the density of `S` fails to exist or exists with a value other than `0` or `1`. Here: a point that is neither a
density point of `S` nor of `Sᶜ` (for measurable `S` the density of `Sᶜ` is `1` minus that of `S`). The paper's proof is
Croft's (its ref. [1], Lemma 4, unheld); equivalently, the density topology on `ℝ²` is connected. Read-back and model:
`plans/FS131-w2-kernel-plan.md` § 12; the model is `upperHalfPlane_falconer_hyp` below. To be formalized before
publication (a separate planner-and-implementer job). -/
axiom falconer_lemma2_nonempty {S : Set ℂ} (hS : MeasurableSet S) (h1 : volume S ≠ 0) (h2 : volume Sᶜ ≠ 0) :
    ∃ x : ℂ, x ∉ densitySet S ∧ x ∉ densitySet Sᶜ

/-- **Model of the import's hypotheses** (`LEAN.md` § Assumptions, item 3): the open upper half-plane is measurable, and it
and its complement have positive (indeed infinite) measure. -/
theorem upperHalfPlane_falconer_hyp :
    MeasurableSet {z : ℂ | 0 < z.im} ∧ volume {z : ℂ | 0 < z.im} ≠ 0 ∧ volume {z : ℂ | 0 < z.im}ᶜ ≠ 0 := by
  have ho : IsOpen {z : ℂ | 0 < z.im} := isOpen_lt continuous_const Complex.continuous_im
  refine ⟨ho.measurableSet, ?_, ?_⟩
  · refine (ho.measure_pos volume ⟨I, ?_⟩).ne'
    simp
  · refine (measure_pos_of_superset (s := ball (-2 * I : ℂ) 1) ?_ ?_ |>.ne')
    · intro z hz
      have := abs_im_le_norm (z - (-2 * I))
      have h1 : ‖z - (-2 * I)‖ < 1 := by simpa [dist_eq_norm] using hz
      simp only [mem_compl_iff, mem_setOf_eq, not_lt]
      have h2 : |(z - (-2 * I)).im| < 1 := lt_of_le_of_lt this h1
      have h3 := (abs_lt.1 h2).2
      simp at h3
      linarith
    · exact (measure_ball_pos volume _ one_pos).ne'

/-- Two density points of a measurable class with no unit pair are not at distance `1` (Lemma 3's core,
`essClosure_dist_ne_one_of_mem_densitySet`, since a density point has positive upper density; a set with no unit pair has
null unit pairs). -/
theorem densitySet_dist_ne_one {S : Set ℂ} (hS : MeasurableSet S) (hno : ∀ x ∈ S, ∀ y ∈ S, dist x y ≠ 1)
    {x y : ℂ} (hx : x ∈ densitySet S) (hy : y ∈ densitySet S) : dist x y ≠ 1 := by
  have hnull : UnitPairsNull S := by
    have : unitPairSet S = ∅ := by
      ext ⟨z, θ⟩
      simp only [unitPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
      intro h1 h2
      refine hno _ h1 _ h2 ?_
      rw [dist_eq_norm, sub_add_cancel_left, norm_neg, norm_e]
    rw [UnitPairsNull, this, measure_empty]
  have hx' : x ∈ essClosure S := by
    have : upperDensityAt S x = 1 := hx.limsup_eq
    show 0 < upperDensityAt S x
    rw [this]; exact one_pos
  exact essClosure_dist_ne_one_of_mem_densitySet hS hnull hx' hy

/-- The density ratio is at most `1`. -/
theorem densityRatio_le_one (A : Set ℂ) (x : ℂ) {r : ℝ} (hr : 0 < r) : densityRatio A x r ≤ 1 := by
  have hB : volume (closedBall x r) ≠ 0 := (measure_closedBall_pos volume x hr).ne'
  have hB' : volume (closedBall x r) ≠ ⊤ := measure_closedBall_lt_top.ne
  rw [densityRatio]
  exact (ENNReal.div_le_div_right (measure_mono inter_subset_right) _).trans (ENNReal.div_self hB hB').le

/-- Density sets are monotone. -/
theorem densitySet_mono {A B : Set ℂ} (h : A ⊆ B) : densitySet A ⊆ densitySet B := by
  intro x hx
  refine tendsto_of_tendsto_of_tendsto_of_le_of_le' hx tendsto_const_nhds ?_ ?_
  · filter_upwards [self_mem_nhdsWithin] with r hr
    exact ENNReal.div_le_div_right (measure_mono (inter_subset_inter_left _ h)) _
  · filter_upwards [self_mem_nhdsWithin] with r hr
    exact densityRatio_le_one B x hr

/-- A conull measurable set contains a unit pair. -/
theorem exists_unit_pair_of_conull {S : Set ℂ} (h0 : volume Sᶜ = 0) :
    ∃ x ∈ S, ∃ y ∈ S, dist x y = 1 := by
  have h1 : volume ((fun x : ℂ => x + 1) ⁻¹' Sᶜ) = 0 := by rw [measure_preimage_add_right]; exact h0
  have : (Sᶜ ∪ (fun x : ℂ => x + 1) ⁻¹' Sᶜ) ≠ univ := by
    intro h
    have : volume (univ : Set ℂ) = 0 := by rw [← h]; exact measure_union_null h0 h1
    exact (by simp : volume (univ : Set ℂ) ≠ 0) this
  obtain ⟨x, hx⟩ : ∃ x, x ∉ Sᶜ ∪ (fun x : ℂ => x + 1) ⁻¹' Sᶜ := by
    by_contra h; push Not at h; exact this (eq_univ_of_forall h)
  simp only [mem_union, mem_compl_iff, mem_preimage, not_or, not_not] at hx
  exact ⟨x, hx.1, x + 1, hx.2, by simp⟩

/-- **`E` is nonempty** for a disjoint measurable cover none of whose classes holds a unit pair (`falconer_lemma2_nonempty`
on a class of positive measure and positive co-measure; if none exists one class is co-null and holds a unit pair). -/
theorem exists_mem_falconerE {k : ℕ} {S : Fin k → Set ℂ} (hS : ∀ j, MeasurableSet (S j))
    (hd : Pairwise (Function.onFun Disjoint S)) (hcov : ⋃ j, S j = univ) (hno : ∀ j, ∀ x ∈ S j, ∀ y ∈ S j, dist x y ≠ 1) :
    ∃ x : ℂ, ∀ j, x ∉ densitySet (S j) := by
  obtain ⟨j, hj⟩ : ∃ j, volume (S j) ≠ 0 := by
    by_contra h; push Not at h
    have : volume (univ : Set ℂ) = 0 := by
      rw [← hcov]; exact measure_iUnion_null h
    exact (by simp : volume (univ : Set ℂ) ≠ 0) this
  have hj' : volume (S j)ᶜ ≠ 0 := by
    intro h0
    obtain ⟨x, hx, y, hy, hxy⟩ := exists_unit_pair_of_conull h0
    exact hno j x hx y hy hxy
  obtain ⟨x, hx1, hx2⟩ := falconer_lemma2_nonempty (hS j) hj hj'
  refine ⟨x, fun i hi => ?_⟩
  by_cases hij : i = j
  · subst hij; exact hx1 hi
  · exact hx2 (densitySet_mono (fun z hz hzj => (Set.disjoint_left.1 (hd hij) hz) hzj) hi)

/-- In a finite disjoint measurable cover the density ratios of the classes at a point sum to `1`. -/
theorem sum_densityRatio_eq_one {k : ℕ} {C : Fin k → Set ℂ} (hm : ∀ j, MeasurableSet (C j))
    (hd : Pairwise (Function.onFun Disjoint C)) (hcov : ⋃ j, C j = univ) (x : ℂ) {r : ℝ} (hr : 0 < r) :
    ∑ b, densityRatio (C b) x r = 1 := by
  have hB : volume (closedBall x r) ≠ 0 := (measure_closedBall_pos volume x hr).ne'
  have hB' : volume (closedBall x r) ≠ ⊤ := measure_closedBall_lt_top.ne
  simp only [densityRatio, div_eq_mul_inv, ← Finset.sum_mul]
  have : ∑ b, volume (C b ∩ closedBall x r) = volume (closedBall x r) := by
    have h := measure_iUnion (μ := volume) (f := fun b => C b ∩ closedBall x r)
      (fun i j hij => (hd hij).mono inter_subset_left inter_subset_left)
      (fun b => (hm b).inter measurableSet_closedBall)
    rw [tsum_fintype, ← iUnion_inter, hcov, univ_inter] at h
    exact h.symm
  rw [this, ENNReal.mul_inv_cancel hB hB']

/-- Some class of a finite disjoint measurable cover has positive upper density at every point. -/
theorem exists_mem_essClosure_of_cover {k : ℕ} {C : Fin k → Set ℂ} (hm : ∀ j, MeasurableSet (C j))
    (hd : Pairwise (Function.onFun Disjoint C)) (hcov : ⋃ j, C j = univ) (x : ℂ) :
    ∃ b, x ∈ essClosure (C b) := by
  by_contra hcon
  push Not at hcon
  have hS : Tendsto (fun r => ∑ b, densityRatio (C b) x r) (𝓝[>] 0) (𝓝 0) := by
    have := tendsto_finsetSum Finset.univ (fun b _ => tendsto_densityRatio_of_notMem_essClosure (hcon b))
    simpa using this
  have h1 : Tendsto (fun r => ∑ b, densityRatio (C b) x r) (𝓝[>] 0) (𝓝 1) :=
    tendsto_const_nhds.congr' (by
      filter_upwards [self_mem_nhdsWithin] with r hr
      exact (sum_densityRatio_eq_one hm hd hcov x hr).symm)
  have := tendsto_nhds_unique hS h1
  exact zero_ne_one this

/-- **D2**: at a point of `E`, two classes of a disjoint measurable cover have positive upper density
(`exists_ne_mem_essClosure` twice, from the class with positive upper density). -/
theorem two_classes_of_mem_falconerE {k : ℕ} {S : Fin k → Set ℂ} (hS : ∀ j, MeasurableSet (S j))
    (hd : Pairwise (Function.onFun Disjoint S)) (hcov : ⋃ j, S j = univ) {x : ℂ} (hx : ∀ j, x ∉ densitySet (S j)) :
    ∃ i j, i ≠ j ∧ x ∈ essClosure (S i) ∧ x ∈ essClosure (S j) := by
  obtain ⟨i, hi⟩ := exists_mem_essClosure_of_cover hS hd hcov x
  obtain ⟨j, hji, hj⟩ := exists_ne_mem_essClosure hS hd hcov (a := i) (x := x) ⟨hi, hx i⟩
  exact ⟨i, j, hji.symm, hi, hj⟩

/-- Points at distance `1` on the circle of radius `r > 1/2` are `β = 2 arcsin(1/(2r))` apart in angle. -/
theorem dist_circle_rotate {c : ℂ} {r : ℝ} (hr : 1 / 2 < r) (θ : ℝ) :
    dist (c + r * e θ) (c + r * e (θ + 2 * Real.arcsin (1 / (2 * r)))) = 1 := by
  have hr0 : 0 < r := by linarith
  set x := 1 / (2 * r) with hx
  have hx0 : 0 < x := by positivity
  have hx1 : x ≤ 1 := by rw [hx, div_le_one (by positivity)]; linarith
  set β := 2 * Real.arcsin x with hβ
  have hcos : Real.cos β = 1 - 2 * x ^ 2 := by
    rw [hβ, Real.cos_two_mul, Real.cos_sq', Real.sin_arcsin (by linarith) hx1]; ring
  have hsq := norm_sq_e_sub θ 1 (θ + β)
  rw [Complex.ofReal_one, one_mul] at hsq
  have hc : Real.cos (θ - (θ + β)) = 1 - 2 * x ^ 2 := by
    rw [show θ - (θ + β) = -β by ring, Real.cos_neg, hcos]
  rw [hc] at hsq
  have hn : ‖e θ - e (θ + β)‖ = 2 * x := by
    have h2 : ‖e θ - e (θ + β)‖ ^ 2 = (2 * x) ^ 2 := by rw [hsq]; ring
    exact (pow_left_inj₀ (norm_nonneg _) (by positivity) (by norm_num : (2:ℕ) ≠ 0)).mp h2
  rw [dist_eq_norm, show c + (r : ℂ) * e θ - (c + (r : ℂ) * e (θ + β)) = (r : ℂ) * (e θ - e (θ + β)) by ring,
    norm_mul, hn, Complex.norm_real, Real.norm_of_nonneg hr0.le, hx]
  field_simp

/-- **The irrational rotation** (`AddCircle.ergodic_add_left`): no measurable `A ⊆ ℝ` of angles, `2π`-periodic, has
`A + β` a.e. equal to its complement when `β/π` is irrational (`A + 2β =ᵐ A` forces `A` null or co-null). -/
theorem not_rotate_ae_eq_compl {A : Set ℝ} (hA : MeasurableSet A) (hper : ∀ θ, θ + 2 * Real.pi ∈ A ↔ θ ∈ A) {β : ℝ}
    (hβ : Irrational (β / Real.pi)) (h : ∀ᵐ θ ∂arcLength, (θ + β ∈ A ↔ θ ∉ A)) : False := by
  haveI : Fact (0 < 2 * Real.pi) := ⟨by positivity⟩
  set T := 2 * Real.pi with hT
  -- the indicator, as a periodic function
  set P : ℝ → ℝ := A.indicator 1 with hP
  have hPper : Function.Periodic P T := by
    intro θ
    by_cases hθ : θ ∈ A
    · simp [hP, hθ, (hper θ).2 hθ]
    · have : θ + T ∉ A := fun h' => hθ ((hper θ).1 h')
      simp [hP, hθ, this]
  set g : AddCircle T → ℝ := fun t => P (AddCircle.equivIoc T 0 t).1 with hg
  have hgm : Measurable g :=
    (measurable_const.indicator hA).comp (measurable_subtype_coe.comp (AddCircle.measurableEquivIoc T 0).measurable)
  have hgcoe : ∀ a : ℝ, g (a : AddCircle T) = P a := by
    intro a
    have : (AddCircle.equivIoc T 0 (a : AddCircle T)).1 = toIocMod (by positivity : (0 : ℝ) < T) 0 a := rfl
    rw [hg]; dsimp only
    rw [this, toIocMod]
    exact hPper.sub_zsmul_eq _
  set b : AddCircle T := (β : AddCircle T) with hb
  have hmp := AddCircle.measurePreserving_mk T 0
  have h' : ∀ᵐ θ ∂(volume.restrict (Ioc 0 (0 + T))), (θ + β ∈ A ↔ θ ∉ A) := by
    have e1 : (volume : Measure ℝ).restrict (Ico 0 T) = volume.restrict (Ioc 0 (0 + T)) := by
      rw [zero_add]; exact Measure.restrict_congr_set Ico_ae_eq_Ioc
    have : arcLength = volume.restrict (Ioc 0 (0 + T)) := by rw [arcLength, ← e1]
    rwa [this] at h
  have hset : MeasurableSet {t : AddCircle T | g (t + b) = 1 - g t} :=
    measurableSet_eq_fun (hgm.comp (measurable_add_const b)) (measurable_const.sub hgm)
  have S1 : ∀ᵐ t ∂(volume : Measure (AddCircle T)), g (t + b) = 1 - g t := by
    rw [← hmp.map_eq]
    refine (ae_map_iff hmp.measurable.aemeasurable hset).mpr ?_
    filter_upwards [h'] with θ hQ
    have e1 : ((θ : AddCircle T) + b) = ((θ + β : ℝ) : AddCircle T) := by rw [hb]; rfl
    show g ((θ : AddCircle T) + b) = 1 - g θ
    rw [e1, hgcoe, hgcoe]
    by_cases hθ : θ ∈ A
    · have : θ + β ∉ A := fun h2 => (hQ.1 h2) hθ
      simp [hP, hθ, this]
    · have : θ + β ∈ A := hQ.2 hθ
      simp [hP, hθ, this]
  have hord : addOrderOf (b + b) = 0 := by
    have hbb : b + b = ((2 * β : ℝ) : AddCircle T) := by rw [hb, show (2 * β) = β + β by ring, AddCircle.coe_add]
    have hirr2 : Irrational ((2 * β) / T) := by
      have : (2 * β) / T = β / Real.pi := by rw [hT]; field_simp
      rw [this]; exact hβ
    rw [hbb]
    exact AddCircle.denseRange_zsmul_iff.mp (AddCircle.denseRange_zsmul_coe_iff.mpr hirr2)
  have herg : Ergodic (· + (b + b)) (volume : Measure (AddCircle T)) := AddCircle.ergodic_add_right.mpr hord
  have S1' : ∀ᵐ t ∂(volume : Measure (AddCircle T)), g (t + b + b) = 1 - g (t + b) :=
    (measurePreserving_add_right (volume : Measure (AddCircle T)) b).quasiMeasurePreserving.ae
      (p := fun t => g (t + b) = 1 - g t) S1
  have hinv : (g ∘ (· + (b + b))) =ᵐ[volume] g := by
    filter_upwards [S1, S1'] with t h1 h2
    simp only [Function.comp, ← add_assoc]
    rw [h2, h1]; ring
  obtain ⟨c, hc⟩ := herg.ae_eq_const_of_ae_eq_comp₀ hgm.nullMeasurable hinv
  have hc' : ∀ᵐ t ∂(volume : Measure (AddCircle T)), g (t + b) = c :=
    (measurePreserving_add_right (volume : Measure (AddCircle T)) b).quasiMeasurePreserving.ae
      (p := fun t => g t = c) hc
  have h01 : ∀ t, g t = 0 ∨ g t = 1 := by
    intro t; simp only [hg, hP]; by_cases hx : (AddCircle.equivIoc T 0 t).1 ∈ A <;> simp [hx]
  obtain ⟨t, h1, h2, h3⟩ := (hc.and (hc'.and S1)).exists
  simp only [Function.const_apply] at h1 h2
  rcases h01 t with h | h <;> rw [h] at h1 <;> subst h1 <;> rw [h2] at h3 <;> norm_num [h] at h3

/-- **A periodic property holds almost everywhere on the circle after any shift** (`2π`-periodic `Q`; `arcLength`
is Lebesgue measure on `[0, 2π)`, and translates of `[0, 2π)` by `2πℤ` cover `ℝ`). -/
theorem ae_arcLength_shift {Q : ℝ → Prop} (hQ : ∀ θ, Q (θ + 2 * Real.pi) ↔ Q θ) (h : ∀ᵐ θ ∂arcLength, Q θ) (β : ℝ) :
    ∀ᵐ θ ∂arcLength, Q (θ + β) := by
  set T := 2 * Real.pi with hT
  have hT0 : 0 < T := by positivity
  have hZ : ∀ (k : ℤ) θ, Q (θ + k * T) ↔ Q θ := by
    intro k θ
    have hp : Function.Periodic (fun θ => Q θ) T := fun θ => propext (hQ θ)
    exact (propext_iff.mp (hp.int_mul k θ)).symm.trans Iff.rfl |>.symm
  have h1 : volume {θ : ℝ | θ ∈ Ico 0 T ∧ ¬ Q θ} = 0 := by
    rw [arcLength, ae_restrict_iff' measurableSet_Ico] at h
    simpa [ae_iff, hT, and_assoc] using h
  have h2 : volume {θ : ℝ | ¬ Q θ} = 0 := by
    refine measure_mono_null (t := ⋃ k : ℤ, (fun θ : ℝ => θ + k * T) ⁻¹' {θ : ℝ | θ ∈ Ico 0 T ∧ ¬ Q θ}) ?_ ?_
    · intro θ hθ
      refine mem_iUnion.2 ⟨-⌊θ / T⌋, ?_⟩
      simp only [mem_preimage, mem_setOf_eq]
      have hfl := Int.floor_le (θ / T)
      have hfl2 := Int.lt_floor_add_one (θ / T)
      refine ⟨⟨?_, ?_⟩, ?_⟩
      · push_cast
        have : (⌊θ / T⌋ : ℝ) * T ≤ θ := by rwa [le_div_iff₀ hT0] at hfl
        linarith
      · push_cast
        have : θ < ((⌊θ / T⌋ : ℝ) + 1) * T := by rwa [div_lt_iff₀ hT0] at hfl2
        linarith
      · rwa [hZ]
    · refine measure_iUnion_null fun k => ?_
      rw [measure_preimage_add_right]; exact h1
  have h3 : volume {θ : ℝ | ¬ Q (θ + β)} = 0 := by
    have := measure_preimage_add_right (volume : Measure ℝ) β {θ : ℝ | ¬ Q θ}
    rw [h2] at this
    exact this
  have : arcLength ≪ volume := Measure.restrict_le_self.absolutelyContinuous
  exact this (by simpa [ae_iff] using h3) |> fun h => by simpa [ae_iff] using h

/-- Density sets of disjoint measurable sets are disjoint. -/
theorem densitySet_disjoint {S₁ S₂ : Set ℂ} (h₁ : MeasurableSet S₁) (hd : Disjoint S₁ S₂) {x : ℂ}
    (hx : x ∈ densitySet S₁) : x ∉ densitySet S₂ := fun h2 =>
  densitySet_disjoint_compl h₁ hx (densitySet_mono (fun _ hz hz1 => Set.disjoint_left.1 hd hz1 hz) h2)

/-- **`[Falconer1981]` Lemma 4, measurable form**: if almost every point of the circle of radius `r > 1/2` about `c` lies in
the density set of one of two disjoint measurable classes with no unit pair, and `arcsin(1/(2r))/π` is irrational, then
`False` (`dist_circle_rotate`, `densitySet_dist_ne_one`, `not_rotate_ae_eq_compl`). -/
theorem falconer_lemma4 {S₁ S₂ : Set ℂ} (h₁ : MeasurableSet S₁) (h₂ : MeasurableSet S₂) (hd : Disjoint S₁ S₂)
    (hno₁ : ∀ x ∈ S₁, ∀ y ∈ S₁, dist x y ≠ 1) (hno₂ : ∀ x ∈ S₂, ∀ y ∈ S₂, dist x y ≠ 1) {c : ℂ} {r : ℝ}
    (hr : 1 / 2 < r) (hirr : Irrational (Real.arcsin (1 / (2 * r)) / Real.pi))
    (hae : ∀ᵐ θ ∂arcLength, c + r * e θ ∈ densitySet S₁ ∪ densitySet S₂) : False := by
  set β := 2 * Real.arcsin (1 / (2 * r)) with hβ
  set D₁ := densitySet S₁
  set D₂ := densitySet S₂
  set A : Set ℝ := {θ | c + r * e θ ∈ D₁} with hA
  have hcont : Continuous fun θ : ℝ => c + (r : ℂ) * e θ := continuous_const.add (continuous_const.mul continuous_e)
  have hAm : MeasurableSet A := hcont.measurable (measurableSet_densitySet h₁)
  have hper : ∀ θ, θ + 2 * Real.pi ∈ A ↔ θ ∈ A := by
    intro θ; simp only [hA, mem_setOf_eq, e_add_two_pi]
  have hirr2 : Irrational (β / Real.pi) := by
    have : β / Real.pi = 2 * (Real.arcsin (1 / (2 * r)) / Real.pi) := by rw [hβ]; ring
    rw [this]; exact hirr.ratCast_mul (q := 2) (by norm_num) |> fun h => by simpa using h
  have hQ : ∀ θ, (c + r * e (θ + 2 * Real.pi) ∈ D₁ ∪ D₂) ↔ (c + r * e θ ∈ D₁ ∪ D₂) := by
    intro θ; simp only [e_add_two_pi]
  have hae2 := ae_arcLength_shift hQ hae β
  refine not_rotate_ae_eq_compl hAm hper hirr2 ?_
  filter_upwards [hae, hae2] with θ h1 h2
  have hdist := dist_circle_rotate (c := c) hr θ
  simp only [hA, mem_setOf_eq]
  rcases h1 with h1 | h1
  · -- the point is in `D₁`; the rotated point must be in `D₂`
    have h2' : c + r * e (θ + β) ∈ D₂ := by
      rcases h2 with h2 | h2
      · exact absurd hdist (densitySet_dist_ne_one h₁ hno₁ h1 h2)
      · exact h2
    exact ⟨fun h => absurd h (densitySet_disjoint h₂ hd.symm h2'), fun h => absurd h1 h⟩
  · have h1' : c + r * e θ ∉ D₁ := densitySet_disjoint h₂ hd.symm h1
    have h2' : c + r * e (θ + β) ∈ D₁ := by
      rcases h2 with h2 | h2
      · exact h2
      · exact absurd hdist (densitySet_dist_ne_one h₂ hno₂ h1 h2)
    exact ⟨fun _ => h1', fun _ => h2'⟩

/-- A set with no unit pair has null unit pairs. -/
theorem unitPairsNull_of_no_unit_pair {S : Set ℂ} (hno : ∀ x ∈ S, ∀ y ∈ S, dist x y ≠ 1) : UnitPairsNull S := by
  have : unitPairSet S = ∅ := by
    ext ⟨z, θ⟩
    simp only [unitPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
    intro h1 h2
    refine hno _ h1 _ h2 ?_
    rw [dist_eq_norm, sub_add_cancel_left, norm_neg, norm_e]
  rw [UnitPairsNull, this, measure_empty]

/-- A rotation about a point is an isometry: `dist (p + e θ * y) (p + e θ * z) = dist y z`. -/
theorem dist_rot (p : ℂ) (θ : ℝ) (y z : ℂ) : dist (p + e θ * y) (p + e θ * z) = dist y z := by
  rw [dist_eq_norm, dist_eq_norm, show p + e θ * y - (p + e θ * z) = e θ * (y - z) by ring, norm_mul, norm_e, one_mul]

/-- **The placement and the fan** (MA1 § 2.2): for a disjoint measurable cover with no monochromatic unit pair, a Falconer
fan places its tip's circle about the apex almost everywhere in two density sets. -/
theorem fan_tip_ae_mem {k : ℕ} (V : Finset ℂ) {a t : ℂ} (ha : a ∈ V) (ht : t ∈ V)
    (hfan : FalconerFan ((unitDistance ℂ).induce (V : Set ℂ)) k ⟨a, ha⟩ ⟨t, ht⟩) {S : Fin k → Set ℂ}
    (hS : ∀ j, MeasurableSet (S j)) (hd : Pairwise (Function.onFun Disjoint S)) (hcov : ⋃ j, S j = univ)
    (hno : ∀ j, ∀ x ∈ S j, ∀ y ∈ S j, dist x y ≠ 1) :
    ∃ (c : ℂ) (i j : Fin k), i ≠ j ∧
      ∀ᵐ θ ∂arcLength, c + (dist t a : ℝ) * e θ ∈ densitySet (S i) ∪ densitySet (S j) := by
  classical
  set E : Set ℂ := {x | ∀ j, x ∉ densitySet (S j)} with hE
  have hEm : MeasurableSet E := by
    have : E = ⋂ j, (densitySet (S j))ᶜ := by ext; simp [hE]
    rw [this]; exact MeasurableSet.iInter fun j => (measurableSet_densitySet (hS j)).compl
  have hE0 : volume E = 0 := by
    refine measure_mono_null (t := ⋃ j, S j \ densitySet (S j)) ?_
      (measure_iUnion_null fun j => volume_diff_densitySet (hS j))
    intro x hx
    have : x ∈ ⋃ j, S j := hcov ▸ mem_univ x
    obtain ⟨j, hj⟩ := mem_iUnion.1 this
    exact mem_iUnion.2 ⟨j, hj, hx j⟩
  have hEne : E.Nonempty := exists_mem_falconerE hS hd hcov hno
  obtain ⟨v, hvE, hθ⟩ := falconer_lemma1 hEm hEne hE0 (C := (V : Set ℂ)) V.countable_toSet ha
  obtain ⟨i, j, hij, hi, hj⟩ := two_classes_of_mem_falconerE hS hd hcov (x := a + v) hvE
  obtain ⟨hat, hnadj, hF⟩ := hfan
  have hta : t ≠ a := fun h => hat (Subtype.ext h.symm)
  set r := dist t a with hr
  set α := Complex.arg (t - a) with hα
  have hQ : ∀ θ, (a + v + (r : ℂ) * e (θ + 2 * Real.pi) ∈ densitySet (S i) ∪ densitySet (S j)) ↔
      (a + v + (r : ℂ) * e θ ∈ densitySet (S i) ∪ densitySet (S j)) := by
    intro θ; simp only [e_add_two_pi]
  refine ⟨a + v, i, j, hij, ?_⟩
  -- the property after rotating by `θ`, then shifting back by `α`
  have key : ∀ᵐ θ ∂arcLength, a + v + (r : ℂ) * e (θ + α) ∈ densitySet (S i) ∪ densitySet (S j) := by
    filter_upwards [hθ] with θ hθ'
    set q : ℂ → ℂ := fun y => a + v + e θ * (y - a) with hq
    have hex : ∀ w : ↥{w : ↥(V : Set ℂ) | w ≠ ⟨a, ha⟩}, ∃ l, q w.1.1 ∈ densitySet (S l) := by
      intro w
      have hne : w.1.1 ≠ a := fun h => w.2 (Subtype.ext h)
      by_contra hcon
      push Not at hcon
      exact hne (hθ' w.1.1 w.1.2 hcon)
    choose f hf using hex
    have hrot : ∀ y z : ℂ, dist (q y) (q z) = dist y z := fun y z => by
      simp only [hq]
      rw [show a + v + e θ * (y - a) = (a + v) + e θ * (y - a) from rfl]
      rw [dist_rot (a + v) θ (y - a) (z - a), dist_eq_norm, dist_eq_norm]; congr 1; ring
    let C' : ((unitDistance ℂ).induce (V : Set ℂ)).induce {w : ↥(V : Set ℂ) | w ≠ ⟨a, ha⟩} |>.Coloring (Fin k) :=
      SimpleGraph.Coloring.mk f (by
        intro u w huw hfe
        have h1 : dist u.1.1 w.1.1 = 1 := unitDistance_adj.1 huw
        have h2 := hf u
        have h3 := hf w
        rw [hfe] at h2
        exact densitySet_dist_ne_one (hS _) (hno _) h2 h3 (by rw [hrot]; exact h1))
    have hav : ∀ w (hw : w ≠ (⟨a, ha⟩ : ↥(V : Set ℂ))), ((unitDistance ℂ).induce (V : Set ℂ)).Adj ⟨a, ha⟩ w →
        C' ⟨w, hw⟩ ≠ i ∧ C' ⟨w, hw⟩ ≠ j := by
      intro w hw hadj
      have h1 : dist a w.1 = 1 := unitDistance_adj.1 hadj
      have h2 := hf ⟨w, hw⟩
      have hpq : dist (a + v) (q w.1) = 1 := by
        have := hrot a w.1
        have hq0 : q a = a + v := by simp [hq]
        rw [hq0] at this; rw [this]; exact h1
      constructor
      · intro hc
        change f ⟨w, hw⟩ = i at hc
        rw [hc] at h2
        exact essClosure_dist_ne_one_of_mem_densitySet (hS i) (unitPairsNull_of_no_unit_pair (hno i)) hi h2 hpq
      · intro hc
        change f ⟨w, hw⟩ = j at hc
        rw [hc] at h2
        exact essClosure_dist_ne_one_of_mem_densitySet (hS j) (unitPairsNull_of_no_unit_pair (hno j)) hj h2 hpq
    have hta' : (⟨t, ht⟩ : ↥(V : Set ℂ)) ≠ ⟨a, ha⟩ := fun h => hta (congrArg Subtype.val h)
    have hres := hF C' i j hij hav hta'
    have hft := hf ⟨⟨t, ht⟩, hta'⟩
    have hqt : q t = a + v + (r : ℂ) * e (θ + α) := by
      have h0 := eq_norm_mul_e_arg (t - a)
      have hrn : (r : ℂ) = ‖t - a‖ := by rw [hr, dist_eq_norm]
      simp only [hq]
      rw [e_add, ← mul_assoc, hrn, mul_comm (‖t - a‖ : ℂ) (e θ), mul_assoc, ← h0]
    rw [← hqt]
    rcases hres with h | h
    · exact Or.inl (h ▸ hft)
    · exact Or.inr (h ▸ hft)
  have h2 := ae_arcLength_shift (Q := fun θ => a + v + (r : ℂ) * e (θ + α) ∈ densitySet (S i) ∪ densitySet (S j))
    (by intro θ; simp only [show θ + 2 * Real.pi + α = (θ + α) + 2 * Real.pi by ring, e_add_two_pi]) key (-α)
  filter_upwards [h2] with θ h
  simpa using h

/-- **FS129-SA1-FALC-RED**: if a finite unit-distance graph `H ⊂ ℝ²` has a Falconer fan at `k` colours with apex `a` and
tip `t`, `|t − a| = r > 1/2` and `arcsin(1/(2r))/π` irrational, then every cover of the plane by `k` measurable sets has
two points at distance `1` inside one of the sets. -/
theorem falconer_reduction {k : ℕ} (V : Finset ℂ) {a t : ℂ} (ha : a ∈ V) (ht : t ∈ V)
    (hfan : FalconerFan ((unitDistance ℂ).induce (V : Set ℂ)) k ⟨a, ha⟩ ⟨t, ht⟩) (hr : 1 / 2 < dist t a)
    (hirr : Irrational (Real.arcsin (1 / (2 * dist t a)) / Real.pi)) (S : Fin k → Set ℂ)
    (hS : ∀ j, MeasurableSet (S j)) (hcov : ⋃ j, S j = univ) :
    ∃ j, ∃ x ∈ S j, ∃ y ∈ S j, dist x y = 1 := by
  by_contra hcon
  push Not at hcon
  set S' : Fin k → Set ℂ := fun j => S j \ ⋃ i ∈ {i : Fin k | i < j}, S i with hS'
  have hS'm : ∀ j, MeasurableSet (S' j) := fun j =>
    (hS j).diff (MeasurableSet.biUnion (Set.to_countable _) fun i _ => hS i)
  have hS'sub : ∀ j, S' j ⊆ S j := fun j => Set.sdiff_subset
  have hd' : Pairwise (Function.onFun Disjoint S') := by
    intro i j hij
    rcases lt_or_gt_of_ne hij with h | h
    · refine Set.disjoint_left.2 fun x hxi hxj => hxj.2 (mem_iUnion₂.2 ⟨i, h, hS'sub i hxi⟩)
    · refine Set.disjoint_left.2 fun x hxi hxj => hxi.2 (mem_iUnion₂.2 ⟨j, h, hS'sub j hxj⟩)
  have hcov' : ⋃ j, S' j = univ := by
    refine eq_univ_of_forall fun x => ?_
    have : x ∈ ⋃ j, S j := hcov ▸ mem_univ x
    obtain ⟨j, hj⟩ := mem_iUnion.1 this
    obtain ⟨j₀, hj₀, hmin⟩ := WellFounded.has_min wellFounded_lt {j : Fin k | x ∈ S j} ⟨j, hj⟩
    refine mem_iUnion.2 ⟨j₀, hj₀, fun hx => ?_⟩
    obtain ⟨i, hi, hxi⟩ := mem_iUnion₂.1 hx
    exact hmin i hxi hi
  have hno' : ∀ j, ∀ x ∈ S' j, ∀ y ∈ S' j, dist x y ≠ 1 := fun j x hx y hy =>
    hcon j x (hS'sub j hx) y (hS'sub j hy)
  obtain ⟨c, i, j, hij, hae⟩ := fan_tip_ae_mem V ha ht hfan hS'm hd' hcov' hno'
  exact falconer_lemma4 (hS'm i) (hS'm j) (hd' hij) (hno' i) (hno' j) hr hirr hae

/-- **FS129-SA1-FALC-RED**, its conclusion for Falconer's chromatic number: `χ_m(ℝ²) ≥ k + 1`. -/
theorem le_chiM_of_falconerFan {k : ℕ} (V : Finset ℂ) {a t : ℂ} (ha : a ∈ V) (ht : t ∈ V)
    (hfan : FalconerFan ((unitDistance ℂ).induce (V : Set ℂ)) k ⟨a, ha⟩ ⟨t, ht⟩) (hr : 1 / 2 < dist t a)
    (hirr : Irrational (Real.arcsin (1 / (2 * dist t a)) / Real.pi)) : ((k + 1 : ℕ) : ℕ∞) ≤ chiM := by
  refine le_iInf₂ fun k' ⟨f, hfm, hfp⟩ => ?_
  by_contra hlt
  have hk : k' ≤ k := by
    have : (k' : ℕ∞) < ((k + 1 : ℕ) : ℕ∞) := not_le.1 hlt
    have := Nat.lt_succ_iff.1 (by exact_mod_cast this)
    exact this
  classical
  let S : Fin k → Set ℂ := fun j => if h : (j : ℕ) < k' then f ⁻¹' {⟨j, h⟩} else ∅
  have hSm : ∀ j, MeasurableSet (S j) := fun j => by
    by_cases h : (j : ℕ) < k'
    · simp only [S, dif_pos h]; exact hfm (measurableSet_singleton _)
    · simp only [S, dif_neg h]; exact MeasurableSet.empty
  have hcov : ⋃ j, S j = univ := by
    refine eq_univ_of_forall fun z => mem_iUnion.2 ⟨⟨(f z : ℕ), lt_of_lt_of_le (f z).isLt hk⟩, ?_⟩
    simp only [S, dif_pos (f z).isLt]
    simp
  obtain ⟨j, x, hx, y, hy, hxy⟩ := falconer_reduction V ha ht hfan hr hirr S hSm hcov
  by_cases h : (j : ℕ) < k'
  · simp only [S, dif_pos h, mem_preimage, mem_singleton_iff] at hx hy
    exact hfp x y hxy (hx.trans hy.symm)
  · simp [S, dif_neg h] at hx

end HadwigerNelson.Plane
