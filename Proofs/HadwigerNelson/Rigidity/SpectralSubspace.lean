import Proofs.HadwigerNelson.Rigidity.Herglotz
import Mathlib.MeasureTheory.Function.ContinuousMapDense
import Mathlib.MeasureTheory.Function.ConditionalExpectation.Basic
import Mathlib.Topology.ContinuousMap.StoneWeierstrass

/-!
# Spectral measures of Koopman vectors, the cyclic-subspace step, and `Π = E[· | 𝒜]` in spectral form (FS-131, job FS131-KM11; module M11a; skeleton)

**Read aloud, against the informal claim.** Let a countable abelian group `R` act on a measure space `(Ω, μ)` by
measure-preserving maps `T y` (`T (x + y) = T x ∘ T y`), with Koopman operators `V_y f = f ∘ T y` on the real space
`L²(μ)`. This module holds the spectral facts J45's Lemmas N2 and SI-1 read (`plans/FS84-SI-D-derivation.md` ll. 126–148),
each **at the class its argument reads**:

* every `f ∈ L²(μ)` has a spectral measure, `∫ χ(y) dσ_f = ⟨f, V_y f⟩` (`exists_isSpectralMeasureOf`: Herglotz–Bochner on
  the countable `R`, `bochnerHerglotz_of_countable`), unique (`IsSpectralMeasureOf.unique`, Fourier uniqueness);
* **orthogonal pieces add** (`IsSpectralMeasureOf.add_of_orthogonal`): for `h` a `l`-continuous vector and `r` orthogonal to
  every one, `σ_{h + r} = σ_h + σ_r` (the cross terms of SI-1 vanish);
* **the cyclic-subspace step** (`spectral_null_of_orthogonal`; FS131-KR1's step (d), "the step no record states as a
  lemma"): if `f` is orthogonal to every `l`-continuous vector, its spectral measure gives measure `0` to every measurable set
  of characters that tend to `1` along `l` (`l` countably generated). **No Bochner theorem is read**;
* **N2's last clause in spectral form** (`isSpectralMeasureOf_condExpL2`): for a group topology `t` with countably generated
  neighbourhoods at `0`, Bochner's theorem for `t` and measurable continuous characters, the spectral measure of `E[f | 𝒜_t]`
  is `σ_f` restricted to the `t`-continuous characters, and that of `f − E[f | 𝒜_t]` is `σ_f` restricted to the rest — the
  spectral projection `Π(E_S)` is `E[· | 𝒜_S]` (J45 N2, l. 127).

**Route of the cyclic-subspace step** (FS131-KM11 § 2; the derivation's sketch in `plans/FS131-KR1-chain-map.md` § 2.4 (d)
is replaced): trigonometric polynomials `P_a(χ) = Σ_y a_y χ(y)` are dense in `L²(σ)` (`exists_trigPoly_tendsto`:
Stone–Weierstrass on the compact dual, then `ContinuousMap.toLp_denseRange`); the real Koopman sums
`u_a = Σ_y Re(a_y) V_y f` satisfy `‖u_a‖² + ‖u_{−ia}‖² = ∫ |P_a|² dσ` (`norm_sq_koopmanSum_re_add_im`: `σ`'s coefficients
are real), so `u_{a_n}` is Cauchy when `P_{a_n} → 1_A` in `L²(σ)`; its limit `w` has `⟨w, f⟩ = σ(A)` and
`‖V_z w − w‖² ≤ ∫_A |χ(z) − 1|² dσ → 0` along `l` (dominated convergence), so `w` is `l`-continuous and `σ(A) = ⟨w, f⟩ = 0`.

**Models.** The trivial action `T y = id` with `f = 0` and `σ = 0` meets every hypothesis of every statement here (degenerate:
`contVec` is everything there, `contVec_id`); the non-degenerate model of `spectral_null_of_orthogonal` — `ℤ` acting on the
two-point space by flips, `l = ⊤`, `f = 1_{0} − 1/2`, `A = {1}`, `σ = ½ δ_{(−1)^n}` — is `spectral_null_model`, a
statement of this module. The model of `isSpectralMeasureOf_condExpL2` at the topology the chain reads is
`Rigidity.TraceSplit`'s use at `tauPrime F`.
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory SpectralChain SpectralInputs Filter Topology

noncomputable section

section Defs

variable {R : Type*} [AddCommGroup R] {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}

/-- **A trigonometric polynomial** on the characters of `R`: `P_a(χ) = Σ_y a_y χ(y)`. -/
def trigPoly (a : R →₀ ℂ) (χ : AddChar R Circle) : ℂ :=
  Finsupp.linearCombination ℂ (fun y : R => ((χ y : Circle) : ℂ)) a

/-- **A real Koopman sum**: `b ↦ Σ_y b_y V_y f`, linear in the coefficients `b`. -/
def koopmanSum (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) (f : Lp ℝ 2 μ) :
    (R →₀ ℝ) →ₗ[ℝ] Lp ℝ 2 μ :=
  Finsupp.linearCombination ℝ fun y => Lp.compMeasurePreserving (T y) (hT y) f

end Defs

section Spectral

variable {R : Type*} [AddCommGroup R] {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}

/-- **The complex Gram identity in a real inner product space**: for vectors `v_x` and complex weights `z_x`,
`Σ_{x,y} z_x z̄_y ⟨v_y, v_x⟩ = ‖Σ Re z_x v_x‖² + ‖Σ Im z_x v_x‖²` (the Gram matrix is real and symmetric, so the imaginary
part cancels). The one finite-sum identity under `posDef_koopman` and `norm_sq_koopmanSum_re_add_im`. -/
theorem gram_sum_eq {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] {ι : Type*} (v : ι → E) (s : Finset ι)
    (z : ι → ℂ) :
    ∑ x ∈ s, ∑ y ∈ s, z x * star (z y) * ((inner ℝ (v y) (v x) : ℝ) : ℂ) =
      ((‖∑ x ∈ s, (z x).re • v x‖ ^ 2 + ‖∑ x ∈ s, (z x).im • v x‖ ^ 2 : ℝ) : ℂ) := by
  have hsq : ∀ c : ι → ℝ, ‖∑ x ∈ s, c x • v x‖ ^ 2 = ∑ x ∈ s, ∑ y ∈ s, c x * c y * inner ℝ (v y) (v x) := by
    intro c
    rw [← real_inner_self_eq_norm_sq, sum_inner]
    refine Finset.sum_congr rfl fun x _ => ?_
    rw [inner_sum]
    refine Finset.sum_congr rfl fun y _ => ?_
    rw [real_inner_smul_left, real_inner_smul_right, real_inner_comm (v y)]
    ring
  apply Complex.ext
  · rw [Complex.ofReal_re, hsq, hsq, ← Finset.sum_add_distrib, Complex.re_sum]
    refine Finset.sum_congr rfl fun x _ => ?_
    rw [Complex.re_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun y _ => ?_
    simp only [Complex.mul_re, Complex.star_def, Complex.conj_re, Complex.conj_im, Complex.ofReal_re,
      Complex.ofReal_im, Complex.mul_im]
    ring
  · rw [Complex.ofReal_im, Complex.im_sum]
    have h : ∀ x y, (z x * star (z y) * ((inner ℝ (v y) (v x) : ℝ) : ℂ)).im =
        ((z x).im * (z y).re - (z x).re * (z y).im) * inner ℝ (v y) (v x) := by
      intro x y
      simp only [Complex.mul_re, Complex.star_def, Complex.conj_re, Complex.conj_im, Complex.ofReal_re,
        Complex.ofReal_im, Complex.mul_im]
      ring
    simp only [Complex.im_sum, h, sub_mul, Finset.sum_sub_distrib]
    rw [sub_eq_zero, Finset.sum_comm]
    refine Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => ?_
    rw [real_inner_comm]
    ring

omit [AddCommGroup R] in
/-- Each `V_y` preserves the inner product (it is a linear isometry of `L²(μ)`). -/
private theorem inner_comp_comp_same (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) (y : R)
    (g f : Lp ℝ 2 μ) :
    inner ℝ (Lp.compMeasurePreserving (T y) (hT y) g) (Lp.compMeasurePreserving (T y) (hT y) f) = inner ℝ g f :=
  (Lp.compMeasurePreservingₗᵢ ℝ (T y) (hT y)).inner_map_map g f

/-- The Gram matrix of the Koopman vectors is the correlation: `⟨V_y f, V_x f⟩ = ⟨f, V_{x − y} f⟩`. -/
private theorem inner_comp_comp (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (hadd : ∀ x y, T (x + y) = T x ∘ T y) (f : Lp ℝ 2 μ) (x y : R) :
    inner ℝ (Lp.compMeasurePreserving (T y) (hT y) f) (Lp.compMeasurePreserving (T x) (hT x) f) =
      inner ℝ f (Lp.compMeasurePreserving (T (x - y)) (hT (x - y)) f) := by
  have e : Lp.compMeasurePreserving (T x) (hT x) f =
      Lp.compMeasurePreserving (T y) (hT y) (Lp.compMeasurePreserving (T (x - y)) (hT (x - y)) f) := by
    rw [← compMeasurePreserving_add hadd (x - y) y f]
    exact compMeasurePreserving_congr (congrArg T (sub_add_cancel x y).symm) _ _ f
  rw [e, inner_comp_comp_same]

/-- **The Koopman correlation is positive definite**: `Σ_{x,y} z_x z̄_y ⟨f, V_{x−y} f⟩ = ‖Σ Re z_x V_x f‖² + ‖Σ Im z_x V_x
f‖²` (the Gram matrix `⟨V_x f, V_y f⟩` is real and symmetric). -/
theorem posDef_koopman (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (hadd : ∀ x y, T (x + y) = T x ∘ T y) (f : Lp ℝ 2 μ) :
    PosDef fun y => ((∫ ω, f ω * Lp.compMeasurePreserving (T y) (hT y) f ω ∂μ : ℝ) : ℂ) := by
  intro s z
  have key : ∑ x ∈ s, ∑ y ∈ s, z x * star (z y) *
      ((∫ ω, f ω * Lp.compMeasurePreserving (T (x - y)) (hT (x - y)) f ω ∂μ : ℝ) : ℂ) =
      ((‖∑ x ∈ s, (z x).re • Lp.compMeasurePreserving (T x) (hT x) f‖ ^ 2 +
        ‖∑ x ∈ s, (z x).im • Lp.compMeasurePreserving (T x) (hT x) f‖ ^ 2 : ℝ) : ℂ) := by
    rw [← gram_sum_eq (fun x => Lp.compMeasurePreserving (T x) (hT x) f) s z]
    refine Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => ?_
    rw [integral_mul_comp_eq_inner, inner_comp_comp T hT hadd f x y]
  simp only []
  rw [key, Complex.ofReal_im, Complex.ofReal_re]
  exact ⟨rfl, by positivity⟩

/-- **Every vector of `L²(μ)` has a spectral measure**, for an action of a countable group (`bochnerHerglotz_of_countable`
at `posDef_koopman`). -/
theorem exists_isSpectralMeasureOf [Countable R] (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (hadd : ∀ x y, T (x + y) = T x ∘ T y) (f : Lp ℝ 2 μ) :
    ∃ σ : Measure (AddChar R Circle), IsSpectralMeasureOf T hT f σ := by
  obtain ⟨σ, hfin, hσ, -⟩ := bochnerHerglotz_of_countable R _ (posDef_koopman T hT hadd f)
  exact ⟨σ, hfin, hσ⟩

/-- **The spectral measure is unique** (Fourier uniqueness on the dual of a countable group). -/
theorem IsSpectralMeasureOf.unique [Countable R] {T : R → Ω → Ω} {hT : ∀ y, MeasurePreserving (T y) μ μ}
    {f : Lp ℝ 2 μ} {σ σ' : Measure (AddChar R Circle)} (h : IsSpectralMeasureOf T hT f σ)
    (h' : IsSpectralMeasureOf T hT f σ') : σ = σ' := by
  haveI := h.1
  haveI := h'.1
  exact measure_eq_of_fourier fun y => (h.2 y).trans (h'.2 y).symm

/-- **The `l`-continuous vectors are stable under every `V_y`** (the maps commute): `‖V_z V_y h − V_y h‖ = ‖V_z h − h‖`. -/
theorem comp_mem_contVec (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (hadd : ∀ x y, T (x + y) = T x ∘ T y) (l : Filter R) {h : Lp ℝ 2 μ} (hh : h ∈ contVec T hT l) (y : R) :
    Lp.compMeasurePreserving (T y) (hT y) h ∈ contVec T hT l := by
  have e : ∀ z, Lp.compMeasurePreserving (T z) (hT z) (Lp.compMeasurePreserving (T y) (hT y) h) -
      Lp.compMeasurePreserving (T y) (hT y) h =
      Lp.compMeasurePreserving (T y) (hT y) (Lp.compMeasurePreserving (T z) (hT z) h - h) := by
    intro z
    rw [map_sub, ← compMeasurePreserving_add hadd y z, ← compMeasurePreserving_add hadd z y,
      compMeasurePreserving_congr (congrArg T (add_comm y z)) _ (hT (z + y)) h]
  show Tendsto (fun z => ‖Lp.compMeasurePreserving (T z) (hT z) (Lp.compMeasurePreserving (T y) (hT y) h) -
    Lp.compMeasurePreserving (T y) (hT y) h‖) l (𝓝 0)
  simp only [e, Lp.norm_compMeasurePreserving]
  exact hh

/-- **`V_y` moves across the inner product as `V_{−y}`**: `⟨g, V_y f⟩ = ⟨V_{−y} g, f⟩`. -/
theorem inner_comp_eq_inner_comp_neg (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (hadd : ∀ x y, T (x + y) = T x ∘ T y) (g f : Lp ℝ 2 μ) (y : R) :
    inner ℝ g (Lp.compMeasurePreserving (T y) (hT y) f) =
      inner ℝ (Lp.compMeasurePreserving (T (-y)) (hT (-y)) g) f := by
  rw [← inner_comp_comp_same T hT (-y) g, ← compMeasurePreserving_add hadd y (-y) f,
    compMeasurePreserving_congr (congrArg T (add_neg_cancel y)) _ (hT 0) f, compMeasurePreserving_zero hadd f]

/-- **Orthogonal pieces add** (SI-1's cross terms): for `h` an `l`-continuous vector and `r` orthogonal to every
`l`-continuous vector, `σ_{h + r} = σ_h + σ_r`. -/
theorem IsSpectralMeasureOf.add_of_orthogonal (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (hadd : ∀ x y, T (x + y) = T x ∘ T y) (l : Filter R) {h r : Lp ℝ 2 μ} (hh : h ∈ contVec T hT l)
    (hr : ∀ g ∈ contVec T hT l, inner ℝ r g = 0) {σh σr : Measure (AddChar R Circle)}
    (hσh : IsSpectralMeasureOf T hT h σh) (hσr : IsSpectralMeasureOf T hT r σr) :
    IsSpectralMeasureOf T hT (h + r) (σh + σr) := by
  haveI := hσh.1
  haveI := hσr.1
  refine ⟨inferInstance, fun y => ?_⟩
  rw [integral_add_measure (integrable_evalChar σh y) (integrable_evalChar σr y), hσh.2 y, hσr.2 y,
    integral_mul_comp_eq_inner, integral_mul_comp_eq_inner, integral_mul_comp_eq_inner, map_add, inner_add_left,
    inner_add_right, inner_add_right]
  have h1 : inner ℝ r (Lp.compMeasurePreserving (T y) (hT y) h) = 0 := hr _ (comp_mem_contVec T hT hadd l hh y)
  have h2 : inner ℝ h (Lp.compMeasurePreserving (T y) (hT y) r) = 0 := by
    rw [inner_comp_eq_inner_comp_neg T hT hadd, real_inner_comm]
    exact hr _ (comp_mem_contVec T hT hadd l hh (-y))
  rw [h1, h2]
  push_cast
  ring

/-! ### The cyclic-subspace step -/

variable (R) in
/-- The evaluations, as continuous functions on the compact dual. -/
private def evC (y : R) : C(AddChar R Circle, ℂ) := ⟨fun χ => ((χ y : Circle) : ℂ), continuous_evalChar R y⟩

private theorem evC_add (y z : R) : evC R (y + z) = evC R y * evC R z := by
  ext χ
  simp [evC, AddChar.map_add_eq_mul]

private theorem evC_zero : evC R 0 = 1 := by
  ext χ
  simp [evC]

private theorem star_evC (y : R) : star (evC R y) = evC R (-y) := by
  ext χ
  simp only [evC, ContinuousMap.star_apply, ContinuousMap.coe_mk, AddChar.map_neg_eq_inv, Circle.coe_inv_eq_conj]
  rfl

variable (R) in
/-- The span of the evaluations, a star subalgebra of `C(R̂, ℂ)`. -/
private def trigAlg : StarSubalgebra ℂ C(AddChar R Circle, ℂ) where
  carrier := Submodule.span ℂ (Set.range (evC R))
  mul_mem' {a b} ha hb := by
    induction ha using Submodule.span_induction with
    | mem x hx =>
      induction hb using Submodule.span_induction with
      | mem y hy =>
        obtain ⟨r, rfl⟩ := hx
        obtain ⟨s, rfl⟩ := hy
        rw [← evC_add]
        exact Submodule.subset_span ⟨r + s, rfl⟩
      | zero => rw [mul_zero]; exact Submodule.zero_mem _
      | add y z _ _ hy hz => rw [mul_add]; exact Submodule.add_mem _ hy hz
      | smul c y _ hy => rw [mul_smul_comm]; exact Submodule.smul_mem _ c hy
    | zero => rw [zero_mul]; exact Submodule.zero_mem _
    | add x y _ _ hx hy => rw [add_mul]; exact Submodule.add_mem _ hx hy
    | smul c x _ hx => rw [smul_mul_assoc]; exact Submodule.smul_mem _ c hx
  one_mem' := by
    rw [← evC_zero]
    exact Submodule.subset_span ⟨0, rfl⟩
  add_mem' := Submodule.add_mem _
  zero_mem' := Submodule.zero_mem _
  algebraMap_mem' c := by
    rw [Algebra.algebraMap_eq_smul_one, ← evC_zero]
    exact Submodule.smul_mem _ c (Submodule.subset_span ⟨0, rfl⟩)
  star_mem' {a} ha := by
    induction ha using Submodule.span_induction with
    | mem x hx =>
      obtain ⟨r, rfl⟩ := hx
      rw [star_evC]
      exact Submodule.subset_span ⟨-r, rfl⟩
    | zero => rw [star_zero]; exact Submodule.zero_mem _
    | add x y _ _ hx hy => rw [star_add]; exact Submodule.add_mem _ hx hy
    | smul c x _ hx => rw [star_smul]; exact Submodule.smul_mem _ _ hx

private theorem trigAlg_separatesPoints : (trigAlg R).SeparatesPoints := by
  intro χ χ' hne
  have hr : ∃ r : R, χ r ≠ χ' r := by
    by_contra hall
    push Not at hall
    exact hne (AddChar.ext _ _ hall)
  obtain ⟨r, hr⟩ := hr
  exact ⟨evC R r, ⟨evC R r, Submodule.subset_span ⟨r, rfl⟩, rfl⟩, fun h => hr (Circle.ext h)⟩

/-- A trigonometric polynomial as a continuous function. -/
private def trigC (a : R →₀ ℂ) : C(AddChar R Circle, ℂ) := Finsupp.linearCombination ℂ (evC R) a

private theorem trigC_apply (a : R →₀ ℂ) (χ : AddChar R Circle) : trigC a χ = trigPoly a χ := by
  simp only [trigC, trigPoly, Finsupp.linearCombination_apply, Finsupp.sum, ContinuousMap.coe_sum, Finset.sum_apply,
    ContinuousMap.coe_smul, Pi.smul_apply, smul_eq_mul, evC, ContinuousMap.coe_mk]

/-- Uniform approximation by trigonometric polynomials (Stone–Weierstrass). -/
private theorem exists_trigC_near [Countable R] (g : C(AddChar R Circle, ℂ)) {ε : ℝ} (hε : 0 < ε) :
    ∃ a : R →₀ ℂ, ‖trigC a - g‖ < ε := by
  have htop := ContinuousMap.starSubalgebra_topologicalClosure_eq_top_of_separatesPoints (trigAlg R)
    trigAlg_separatesPoints
  have hg : g ∈ (trigAlg R).topologicalClosure := by rw [htop]; trivial
  obtain ⟨p, hp, hdist⟩ := Metric.mem_closure_iff.mp hg ε hε
  obtain ⟨a, rfl⟩ := Finsupp.mem_span_range_iff_exists_finsupp.mp
    (show p ∈ Submodule.span ℂ (Set.range (evC R)) from hp)
  refine ⟨a, ?_⟩
  rw [← dist_eq_norm, dist_comm]
  exact hdist

/-- `‖F‖² = ∫ ‖F‖²` in `L²`. -/
private theorem integral_norm_sq_eq {X : Type*} [MeasurableSpace X] {ν : Measure X} (F : Lp ℂ 2 ν) :
    ∫ x, ‖(F : X → ℂ) x‖ ^ 2 ∂ν = ‖F‖ ^ 2 := by
  rw [norm_sq_eq_re_inner (𝕜 := ℂ), MeasureTheory.L2.inner_def]
  have h : ∀ x, (inner ℂ ((F : X → ℂ) x) ((F : X → ℂ) x) : ℂ) = ((‖(F : X → ℂ) x‖ ^ 2 : ℝ) : ℂ) := fun x => by
    rw [inner_self_eq_norm_sq_to_K]; push_cast; rfl
  simp_rw [h]
  rw [integral_complex_ofReal]
  simp


private theorem trigPoly_sub (a b : R →₀ ℂ) (χ : AddChar R Circle) : trigPoly (a - b) χ = trigPoly a χ - trigPoly b χ := by
  simp [trigPoly, map_sub]

private theorem trigPoly_eq_sum (a : R →₀ ℂ) (χ : AddChar R Circle) :
    trigPoly a χ = ∑ y ∈ a.support, a y * ((χ y : Circle) : ℂ) := by
  simp [trigPoly, Finsupp.linearCombination_apply, Finsupp.sum]

private theorem measurable_trigPoly (a : R →₀ ℂ) : Measurable (trigPoly a) := by
  have h : trigPoly a = fun χ => ∑ y ∈ a.support, a y * ((χ y : Circle) : ℂ) := funext (trigPoly_eq_sum a)
  rw [h]
  exact Finset.measurable_sum _ fun y _ => measurable_const.mul (measurable_evalChar y)

private theorem norm_trigPoly_le (a : R →₀ ℂ) (χ : AddChar R Circle) : ‖trigPoly a χ‖ ≤ ∑ y ∈ a.support, ‖a y‖ := by
  rw [trigPoly_eq_sum]
  refine (norm_sum_le _ _).trans (Finset.sum_le_sum fun y _ => ?_)
  rw [norm_mul, Circle.norm_coe, mul_one]

/-- The error `‖P_a − 1_A‖²` is integrable. -/
private theorem integrable_err (σ : Measure (AddChar R Circle)) [IsFiniteMeasure σ] {A : Set (AddChar R Circle)}
    (hA : MeasurableSet A) (a : R →₀ ℂ) :
    Integrable (fun χ => ‖trigPoly a χ - A.indicator 1 χ‖ ^ 2) σ := by
  refine Integrable.of_bound (C := (∑ y ∈ a.support, ‖a y‖ + 1) ^ 2) ?_ ?_
  · exact (((measurable_trigPoly a).sub (measurable_const.indicator hA)).norm.pow_const 2).aestronglyMeasurable
  · refine Filter.Eventually.of_forall fun χ => ?_
    rw [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg _)]
    have h1 : ‖A.indicator (1 : AddChar R Circle → ℂ) χ‖ ≤ 1 := by
      by_cases h : χ ∈ A <;> simp [h]
    have h2 : ‖trigPoly a χ - A.indicator 1 χ‖ ≤ ∑ y ∈ a.support, ‖a y‖ + 1 :=
      (norm_sub_le _ _).trans (add_le_add (norm_trigPoly_le a χ) h1)
    exact pow_le_pow_left₀ (norm_nonneg _) h2 2

/-- `∫ ‖P_a − 1_A‖ → 0` when `∫ ‖P_a − 1_A‖² → 0` (`‖g‖ ≤ δ + ‖g‖²/δ`). -/
private theorem tendsto_integral_norm_of_sq (σ : Measure (AddChar R Circle)) [IsFiniteMeasure σ] (g : ℕ → AddChar R Circle → ℂ)
    (hg : ∀ n, Measurable (g n)) (hint : ∀ n, Integrable (fun χ => ‖g n χ‖ ^ 2) σ)
    (h : Tendsto (fun n => ∫ χ, ‖g n χ‖ ^ 2 ∂σ) atTop (𝓝 0)) :
    Tendsto (fun n => ∫ χ, ‖g n χ‖ ∂σ) atTop (𝓝 0) := by
  set C := σ.real Set.univ + 1 with hC
  have hCpos : 0 < C := by positivity
  rw [Metric.tendsto_atTop]
  intro η hη
  set δ := η / (2 * C) with hδ
  have hδpos : 0 < δ := by positivity
  obtain ⟨N, hN⟩ := Metric.tendsto_atTop.mp h (δ * η / 2) (by positivity)
  refine ⟨N, fun n hn => ?_⟩
  have hsq := hN n hn
  rw [Real.dist_eq, sub_zero, abs_of_nonneg (integral_nonneg fun _ => sq_nonneg _)] at hsq
  have hpt : ∀ χ, ‖g n χ‖ ≤ δ + ‖g n χ‖ ^ 2 / δ := by
    intro χ
    rcases le_or_gt ‖g n χ‖ δ with h1 | h1
    · have : 0 ≤ ‖g n χ‖ ^ 2 / δ := by positivity
      linarith
    · have : ‖g n χ‖ ≤ ‖g n χ‖ ^ 2 / δ := by
        rw [le_div_iff₀ hδpos, sq]
        exact mul_le_mul_of_nonneg_left h1.le (norm_nonneg _)
      have : 0 ≤ δ := hδpos.le
      linarith
  have hintb : Integrable (fun χ => δ + ‖g n χ‖ ^ 2 / δ) σ := (integrable_const δ).add ((hint n).div_const δ)
  have hle : ∫ χ, ‖g n χ‖ ∂σ ≤ δ * σ.real Set.univ + (∫ χ, ‖g n χ‖ ^ 2 ∂σ) / δ := by
    have hint1 : Integrable (fun χ => ‖g n χ‖) σ :=
      Integrable.mono' hintb (hg n).norm.aestronglyMeasurable
        (Filter.Eventually.of_forall fun χ => by rw [Real.norm_eq_abs, abs_norm]; exact hpt χ)
    calc ∫ χ, ‖g n χ‖ ∂σ ≤ ∫ χ, (δ + ‖g n χ‖ ^ 2 / δ) ∂σ := integral_mono hint1 hintb hpt
      _ = δ * σ.real Set.univ + (∫ χ, ‖g n χ‖ ^ 2 ∂σ) / δ := by
        rw [integral_add (integrable_const δ) ((hint n).div_const δ), integral_const, integral_div, smul_eq_mul,
          mul_comm]
  rw [Real.dist_eq, sub_zero, abs_of_nonneg (integral_nonneg fun _ => norm_nonneg _)]
  have h1 : δ * σ.real Set.univ < η / 2 := by
    rw [hδ]
    have : σ.real Set.univ < C := by linarith
    calc η / (2 * C) * σ.real Set.univ < η / (2 * C) * C := mul_lt_mul_of_pos_left this (by positivity)
      _ = η / 2 := by field_simp
  have h2 : (∫ χ, ‖g n χ‖ ^ 2 ∂σ) / δ < η / 2 := by
    rw [div_lt_iff₀ hδpos]
    linarith
  linarith

private theorem trigPoly_mapDomain_add (b : R →₀ ℂ) (z : R) (χ : AddChar R Circle) :
    trigPoly (b.mapDomain (· + z)) χ = ((χ z : Circle) : ℂ) * trigPoly b χ := by
  unfold trigPoly
  rw [Finsupp.linearCombination_mapDomain, Finsupp.linearCombination_apply, Finsupp.linearCombination_apply,
    Finsupp.sum, Finsupp.sum, Finset.mul_sum]
  refine Finset.sum_congr rfl fun y _ => ?_
  simp only [Function.comp_apply, AddChar.map_add_eq_mul, Circle.coe_mul, smul_eq_mul]
  ring

omit [AddCommGroup R] in
/-- A Koopman sum of `a`'s coefficients mapped by `g` (`g 0 = 0`), as a sum over the support of `a`. -/
private theorem koopmanSum_mapRange (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) (f : Lp ℝ 2 μ)
    (a : R →₀ ℂ) (g : ℂ → ℝ) (hg : g 0 = 0) :
    koopmanSum T hT f (a.mapRange g hg) = ∑ y ∈ a.support, g (a y) • Lp.compMeasurePreserving (T y) (hT y) f := by
  rw [koopmanSum, Finsupp.linearCombination_apply_of_mem_supported ℝ (s := a.support)
    ((Finsupp.mem_supported ℝ _).2 (by exact_mod_cast Finsupp.support_mapRange))]
  simp only [Finsupp.mapRange_apply]

/-- **Trigonometric polynomials are dense in `L²(σ)`**, for a finite measure on the dual of a countable group: every
measurable set's indicator is an `L²(σ)`-limit of them. Stone–Weierstrass on the compact dual (the evaluations span a star
subalgebra of `C(R̂, ℂ)` separating points) and the density of continuous functions in `L²` of a finite Borel measure. -/
theorem exists_trigPoly_tendsto [Countable R] (σ : Measure (AddChar R Circle)) [IsFiniteMeasure σ]
    {A : Set (AddChar R Circle)} (hA : MeasurableSet A) :
    ∃ a : ℕ → (R →₀ ℂ), Tendsto (fun n => ∫ χ, ‖trigPoly (a n) χ - A.indicator 1 χ‖ ^ 2 ∂σ) atTop (𝓝 0) := by
  haveI : σ.WeaklyRegular := Measure.WeaklyRegular.of_pseudoMetrizableSpace_of_isFiniteMeasure σ
  haveI : Fact ((1 : ENNReal) ≤ 2) := ⟨by norm_num⟩
  set I : Lp ℂ 2 σ := indicatorConstLp 2 hA (measure_ne_top σ A) (1 : ℂ) with hI
  set L := (ContinuousMap.toLp (E := ℂ) 2 σ ℂ : C(AddChar R Circle, ℂ) →L[ℂ] Lp ℂ 2 σ) with hL
  have hdense : DenseRange L := ContinuousMap.toLp_denseRange ℂ σ ℂ (by norm_num)
  have hstep : ∀ n : ℕ, ∃ a : R →₀ ℂ, dist (L (trigC a)) I < 2 / (n + 1) := by
    intro n
    have hε : (0 : ℝ) < 1 / (n + 1) := by positivity
    obtain ⟨g, hg⟩ := hdense.exists_dist_lt I hε
    obtain ⟨a, ha⟩ := exists_trigC_near g (ε := 1 / (n + 1) / (‖L‖ + 1)) (by positivity)
    refine ⟨a, ?_⟩
    have h1 : dist (L (trigC a)) (L g) ≤ ‖L‖ * ‖trigC a - g‖ := by
      rw [dist_eq_norm, ← map_sub]
      exact L.le_opNorm _
    have h2 : ‖L‖ * ‖trigC a - g‖ ≤ 1 / (n + 1) := by
      have := mul_le_mul_of_nonneg_left ha.le (norm_nonneg L)
      refine this.trans ?_
      rw [mul_div_assoc']
      rw [div_le_iff₀ (by positivity)]
      nlinarith [norm_nonneg L, hε]
    calc dist (L (trigC a)) I ≤ dist (L (trigC a)) (L g) + dist (L g) I := dist_triangle _ _ _
      _ < 1 / (n + 1) + 1 / (n + 1) := by rw [dist_comm] at hg; linarith
      _ = 2 / (n + 1) := by ring
  choose a ha using hstep
  refine ⟨a, ?_⟩
  have hint : ∀ n, ∫ χ, ‖trigPoly (a n) χ - A.indicator 1 χ‖ ^ 2 ∂σ = dist (L (trigC (a n))) I ^ 2 := by
    intro n
    rw [dist_eq_norm, ← integral_norm_sq_eq]
    refine integral_congr_ae ?_
    filter_upwards [Lp.coeFn_sub (L (trigC (a n))) I, ContinuousMap.coeFn_toLp (E := ℂ) (p := 2) σ (𝕜 := ℂ) (trigC (a n)),
      indicatorConstLp_coeFn (p := 2) (hs := hA) (hμs := measure_ne_top σ A) (c := (1 : ℂ))] with χ h1 h2 h3
    rw [h1, Pi.sub_apply, h2, h3, trigC_apply]
    rfl
  simp_rw [hint]
  have hlim : Tendsto (fun n : ℕ => (2 / ((n : ℝ) + 1)) ^ 2) atTop (𝓝 0) := by
    have h := (tendsto_const_div_atTop_nhds_zero_nat (2 : ℝ)).comp (tendsto_add_atTop_nat 1)
    have h' : Tendsto (fun n : ℕ => 2 / ((n : ℝ) + 1)) atTop (𝓝 0) := by
      refine h.congr fun n => ?_
      simp
    simpa using h'.pow 2
  refine squeeze_zero (fun n => sq_nonneg _) (fun n => ?_) hlim
  exact pow_le_pow_left₀ dist_nonneg (ha n).le 2

/-- **The Koopman isometry, in real and imaginary parts**: `‖Σ Re(a_y) V_y f‖² + ‖Σ Im(a_y) V_y f‖² = ∫ |P_a|² dσ_f`. -/
theorem norm_sq_koopmanSum_re_add_im (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (hadd : ∀ x y, T (x + y) = T x ∘ T y) {f : Lp ℝ 2 μ} {σ : Measure (AddChar R Circle)}
    (hσ : IsSpectralMeasureOf T hT f σ) (a : R →₀ ℂ) :
    ‖koopmanSum T hT f (a.mapRange Complex.re Complex.zero_re)‖ ^ 2 +
        ‖koopmanSum T hT f (a.mapRange Complex.im Complex.zero_im)‖ ^ 2 =
      ∫ χ, ‖trigPoly a χ‖ ^ 2 ∂σ := by
  haveI := hσ.1
  rw [koopmanSum_mapRange, koopmanSum_mapRange]
  apply Complex.ofReal_injective
  rw [← gram_sum_eq (fun x => Lp.compMeasurePreserving (T x) (hT x) f) a.support a, ← integral_complex_ofReal]
  have hpt : ∀ χ : AddChar R Circle, ((‖trigPoly a χ‖ ^ 2 : ℝ) : ℂ) =
      ∑ x ∈ a.support, ∑ y ∈ a.support, a x * star (a y) * ((χ (x - y) : Circle) : ℂ) := by
    intro χ
    rw [← Complex.normSq_eq_norm_sq, ← Complex.mul_conj, trigPoly_eq_sum, map_sum, Finset.sum_mul_sum]
    refine Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => ?_
    rw [coe_char_sub, map_mul, Complex.star_def]
    ring
  simp_rw [hpt]
  rw [integral_finsetSum _ fun x _ => integrable_finsetSum _ fun y _ => (integrable_evalChar σ (x - y)).const_mul _]
  refine Finset.sum_congr rfl fun x _ => ?_
  rw [integral_finsetSum _ fun y _ => (integrable_evalChar σ (x - y)).const_mul _]
  refine Finset.sum_congr rfl fun y _ => ?_
  rw [integral_const_mul, hσ.2, integral_mul_comp_eq_inner, inner_comp_comp T hT hadd f x y]

/-- **The real Koopman sum against `f`**: `⟨Σ Re(a_y) V_y f, f⟩ = Re ∫ P_a dσ_f`. -/
theorem inner_koopmanSum_re (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) {f : Lp ℝ 2 μ}
    {σ : Measure (AddChar R Circle)} (hσ : IsSpectralMeasureOf T hT f σ) (a : R →₀ ℂ) :
    inner ℝ (koopmanSum T hT f (a.mapRange Complex.re Complex.zero_re)) f = (∫ χ, trigPoly a χ ∂σ).re := by
  haveI := hσ.1
  rw [koopmanSum_mapRange, sum_inner]
  have hint : ∫ χ, trigPoly a χ ∂σ = ∑ y ∈ a.support, a y * ∫ χ, (χ y : ℂ) ∂σ := by
    simp_rw [trigPoly_eq_sum]
    rw [integral_finsetSum _ fun y _ => (integrable_evalChar σ y).const_mul _]
    simp_rw [integral_const_mul]
  rw [hint, Complex.re_sum]
  refine Finset.sum_congr rfl fun y _ => ?_
  rw [real_inner_smul_left, hσ.2 y, integral_mul_comp_eq_inner,
    real_inner_comm f (Lp.compMeasurePreserving (T y) (hT y) f), Complex.mul_re, Complex.ofReal_re,
    Complex.ofReal_im, mul_zero, sub_zero]

/-- **`V_z` on a Koopman sum shifts its coefficients**: `V_z (Σ b_y V_y f) = Σ b_y V_{y + z} f`. -/
theorem comp_koopmanSum (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (hadd : ∀ x y, T (x + y) = T x ∘ T y) (f : Lp ℝ 2 μ) (b : R →₀ ℝ) (z : R) :
    Lp.compMeasurePreserving (T z) (hT z) (koopmanSum T hT f b) = koopmanSum T hT f (b.mapDomain (· + z)) := by
  simp only [koopmanSum]
  rw [Finsupp.linearCombination_mapDomain]
  have e1 : Lp.compMeasurePreserving (T z) (hT z)
      (Finsupp.linearCombination ℝ (fun y => Lp.compMeasurePreserving (T y) (hT y) f) b) =
      Lp.compMeasurePreservingₗ ℝ (T z) (hT z)
        (Finsupp.linearCombination ℝ (fun y => Lp.compMeasurePreserving (T y) (hT y) f) b) := rfl
  have e2 : (⇑(Lp.compMeasurePreservingₗ ℝ (T z) (hT z)) ∘ fun y => Lp.compMeasurePreserving (T y) (hT y) f) =
      (fun y => Lp.compMeasurePreserving (T y) (hT y) f) ∘ (· + z) := by
    funext y
    simp only [Function.comp_apply]
    rw [compMeasurePreserving_add hadd y z]
    rfl
  rw [e1, Finsupp.apply_linearCombination, e2]

/-- **The spectral vector of a set** (the cyclic-subspace construction, `w = 1_A(V) f`): for a measurable set `A` of
characters there is a vector `w` with `⟨w, f⟩ = σ_f(A)` and `‖V_z w − w‖² ≤ 2 ∫_A |χ(z) − 1|² dσ_f` for every `z` — the
`L²`-limit of the real Koopman sums `Σ Re(a_y) V_y f` along trigonometric polynomials `P_a → 1_A` in `L²(σ_f)`
(`exists_trigPoly_tendsto`; Cauchy by `norm_sq_koopmanSum_re_add_im`; the pairing by `inner_koopmanSum_re`; the bound by
`comp_koopmanSum` and `|(χ(z) − 1)P| ≤ |(χ(z) − 1)1_A| + 2|P − 1_A|`). Reads no orthogonality and no filter. -/
theorem exists_spectral_vector [Countable R] (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (hadd : ∀ x y, T (x + y) = T x ∘ T y) {f : Lp ℝ 2 μ} {σ : Measure (AddChar R Circle)}
    (hσ : IsSpectralMeasureOf T hT f σ) {A : Set (AddChar R Circle)} (hA : MeasurableSet A) :
    ∃ w : Lp ℝ 2 μ, inner ℝ w f = σ.real A ∧
      ∀ z : R, ‖Lp.compMeasurePreserving (T z) (hT z) w - w‖ ^ 2 ≤
        2 * ∫ χ in A, ‖((χ z : Circle) : ℂ) - 1‖ ^ 2 ∂σ := by
  haveI := hσ.1
  obtain ⟨a, ha⟩ := exists_trigPoly_tendsto σ hA
  let re : (R →₀ ℂ) → (R →₀ ℝ) := fun b => b.mapRange Complex.re Complex.zero_re
  have hre_sub : ∀ b c, re (b - c) = re b - re c := fun b c => by ext; simp [re]
  set ε : ℕ → ℝ := fun n => ∫ χ, ‖trigPoly (a n) χ - A.indicator 1 χ‖ ^ 2 ∂σ with hε
  set u : ℕ → Lp ℝ 2 μ := fun n => koopmanSum T hT f (re (a n)) with hu
  -- the Koopman sums are Cauchy: `‖u n − u m‖² ≤ 2 ε n + 2 ε m`
  have hdiff : ∀ n m, ‖u n - u m‖ ^ 2 ≤ 2 * ε n + 2 * ε m := by
    intro n m
    have hiso := norm_sq_koopmanSum_re_add_im T hT hadd hσ (a n - a m)
    have h1 : ‖u n - u m‖ ^ 2 ≤ ∫ χ, ‖trigPoly (a n - a m) χ‖ ^ 2 ∂σ := by
      rw [← hiso]
      have : u n - u m = koopmanSum T hT f ((a n - a m).mapRange Complex.re Complex.zero_re) := by
        simp only [hu, ← map_sub]
        rw [← hre_sub]
      rw [this]
      exact le_add_of_nonneg_right (sq_nonneg _)
    refine h1.trans ?_
    have hpt : ∀ χ, ‖trigPoly (a n - a m) χ‖ ^ 2 ≤
        2 * ‖trigPoly (a n) χ - A.indicator 1 χ‖ ^ 2 + 2 * ‖trigPoly (a m) χ - A.indicator 1 χ‖ ^ 2 := by
      intro χ
      have e : trigPoly (a n - a m) χ = (trigPoly (a n) χ - A.indicator 1 χ) - (trigPoly (a m) χ - A.indicator 1 χ) := by
        rw [trigPoly_sub]; ring
      rw [e]
      have := norm_sub_le (trigPoly (a n) χ - A.indicator 1 χ) (trigPoly (a m) χ - A.indicator 1 χ)
      have hsq := pow_le_pow_left₀ (norm_nonneg _) this 2
      nlinarith [hsq, sq_nonneg (‖trigPoly (a n) χ - A.indicator 1 χ‖ - ‖trigPoly (a m) χ - A.indicator 1 χ‖)]
    have hintd : Integrable (fun χ => ‖trigPoly (a n - a m) χ‖ ^ 2) σ := by
      have := integrable_err σ MeasurableSet.empty (a n - a m)
      simpa using this
    calc ∫ χ, ‖trigPoly (a n - a m) χ‖ ^ 2 ∂σ
        ≤ ∫ χ, (2 * ‖trigPoly (a n) χ - A.indicator 1 χ‖ ^ 2 + 2 * ‖trigPoly (a m) χ - A.indicator 1 χ‖ ^ 2) ∂σ :=
          integral_mono hintd (((integrable_err σ hA (a n)).const_mul 2).add
            ((integrable_err σ hA (a m)).const_mul 2)) hpt
      _ = 2 * ε n + 2 * ε m := by
          rw [integral_add ((integrable_err σ hA (a n)).const_mul 2) ((integrable_err σ hA (a m)).const_mul 2),
            integral_const_mul, integral_const_mul]
  have hcauchy : CauchySeq u := by
    rw [Metric.cauchySeq_iff]
    intro η hη
    obtain ⟨N, hN⟩ := Metric.tendsto_atTop.mp ha (η ^ 2 / 4) (by positivity)
    refine ⟨N, fun m hm n hn => ?_⟩
    have e1 := hN m hm
    have e2 := hN n hn
    rw [Real.dist_eq, sub_zero, abs_of_nonneg (integral_nonneg fun _ => sq_nonneg _)] at e1 e2
    have hsq : dist (u m) (u n) ^ 2 < η ^ 2 := by
      rw [dist_eq_norm]
      calc ‖u m - u n‖ ^ 2 ≤ 2 * ε m + 2 * ε n := hdiff m n
        _ < η ^ 2 := by simp only [hε]; linarith
    exact lt_of_pow_lt_pow_left₀ 2 hη.le hsq
  obtain ⟨w, hw⟩ := cauchySeq_tendsto_of_complete hcauchy
  refine ⟨w, ?_, fun z => ?_⟩
  · -- `⟨w, f⟩ = lim ⟨u n, f⟩ = lim Re ∫ P_n = σ(A)`
    have h1 : Tendsto (fun n => inner ℝ (u n) f) atTop (𝓝 (inner ℝ w f)) := hw.inner tendsto_const_nhds
    have hL1 := tendsto_integral_norm_of_sq σ (fun n χ => trigPoly (a n) χ - A.indicator 1 χ)
      (fun n => (measurable_trigPoly (a n)).sub (measurable_const.indicator hA)) (fun n => integrable_err σ hA (a n)) ha
    have h2 : Tendsto (fun n => inner ℝ (u n) f) atTop (𝓝 (σ.real A)) := by
      rw [Metric.tendsto_atTop]
      intro η hη
      obtain ⟨N, hN⟩ := Metric.tendsto_atTop.mp hL1 η hη
      refine ⟨N, fun n hn => ?_⟩
      have hb := hN n hn
      rw [Real.dist_eq, sub_zero, abs_of_nonneg (integral_nonneg fun _ => norm_nonneg _)] at hb
      rw [inner_koopmanSum_re T hT hσ (a n)]
      have hindA : ∫ χ, A.indicator (1 : AddChar R Circle → ℂ) χ ∂σ = (σ.real A : ℂ) := by
        rw [integral_indicator hA]
        simp
      have hTint : Integrable (trigPoly (a n)) σ := by
        refine Integrable.of_bound (C := ∑ y ∈ (a n).support, ‖a n y‖) (measurable_trigPoly (a n)).aestronglyMeasurable
          (Filter.Eventually.of_forall fun χ => norm_trigPoly_le (a n) χ)
      have hIint : Integrable (A.indicator (1 : AddChar R Circle → ℂ)) σ :=
        (integrable_const (1 : ℂ)).indicator hA
      have e : (∫ χ, trigPoly (a n) χ ∂σ).re - σ.real A = (∫ χ, (trigPoly (a n) χ - A.indicator 1 χ) ∂σ).re := by
        rw [integral_sub hTint hIint, hindA, Complex.sub_re, Complex.ofReal_re]
      rw [Real.dist_eq, e]
      exact lt_of_le_of_lt ((Complex.abs_re_le_norm _).trans (norm_integral_le_integral_norm _)) hb
    exact tendsto_nhds_unique h1 h2
  · -- `‖V_z w − w‖² = lim ‖V_z u n − u n‖² ≤ lim (2 ∫_A |χ z − 1|² + 8 ε n)`
    set V : Lp ℝ 2 μ → Lp ℝ 2 μ := fun g => Lp.compMeasurePreserving (T z) (hT z) g with hV
    have hVc : Continuous V := (Lp.isometry_compMeasurePreserving (hT z)).continuous
    have hlimL : Tendsto (fun n => ‖V (u n) - u n‖ ^ 2) atTop (𝓝 (‖V w - w‖ ^ 2)) :=
      (((hVc.tendsto w).comp hw).sub hw).norm.pow 2
    set c : AddChar R Circle → ℂ := fun χ => ((χ z : Circle) : ℂ) - 1 with hc
    have hcb : ∀ χ, ‖c χ‖ ≤ 2 := fun χ => (norm_sub_le _ _).trans (by simp; norm_num)
    have hcm : Measurable c := (measurable_evalChar z).sub measurable_const
    set J := ∫ χ in A, ‖((χ z : Circle) : ℂ) - 1‖ ^ 2 ∂σ with hJ
    have hbound : ∀ n, ‖V (u n) - u n‖ ^ 2 ≤ 2 * J + 8 * ε n := by
      intro n
      have hshift : V (u n) - u n =
          koopmanSum T hT f (((a n).mapDomain (· + z) - a n).mapRange Complex.re Complex.zero_re) := by
        simp only [hu, hV]
        rw [comp_koopmanSum T hT hadd, ← map_sub]
        congr 1
        rw [show ((a n).mapDomain (· + z) - a n).mapRange Complex.re Complex.zero_re =
            re ((a n).mapDomain (· + z)) - re (a n) from hre_sub _ _]
        simp only [re]
        rw [Finsupp.mapDomain_mapRange _ _ _ _ (fun x y => Complex.add_re x y)]
      have hiso := norm_sq_koopmanSum_re_add_im T hT hadd hσ ((a n).mapDomain (· + z) - a n)
      have h1 : ‖V (u n) - u n‖ ^ 2 ≤ ∫ χ, ‖c χ * trigPoly (a n) χ‖ ^ 2 ∂σ := by
        rw [hshift]
        calc _ ≤ ‖koopmanSum T hT f (((a n).mapDomain (· + z) - a n).mapRange Complex.re Complex.zero_re)‖ ^ 2 +
              ‖koopmanSum T hT f (((a n).mapDomain (· + z) - a n).mapRange Complex.im Complex.zero_im)‖ ^ 2 :=
            le_add_of_nonneg_right (sq_nonneg _)
          _ = _ := by
            rw [hiso]
            refine integral_congr_ae (Filter.Eventually.of_forall fun χ => ?_)
            simp only [trigPoly_sub, trigPoly_mapDomain_add, hc]
            ring_nf
      have hpt : ∀ χ, ‖c χ * trigPoly (a n) χ‖ ^ 2 ≤
          2 * A.indicator (fun χ => ‖((χ z : Circle) : ℂ) - 1‖ ^ 2) χ +
            8 * ‖trigPoly (a n) χ - A.indicator 1 χ‖ ^ 2 := by
        intro χ
        have e : c χ * trigPoly (a n) χ = c χ * A.indicator 1 χ + c χ * (trigPoly (a n) χ - A.indicator 1 χ) := by
          ring
        have hind : ‖c χ * A.indicator 1 χ‖ ^ 2 = A.indicator (fun χ => ‖((χ z : Circle) : ℂ) - 1‖ ^ 2) χ := by
          by_cases h : χ ∈ A <;> simp [h, hc]
        have h2 : ‖c χ * (trigPoly (a n) χ - A.indicator 1 χ)‖ ≤ 2 * ‖trigPoly (a n) χ - A.indicator 1 χ‖ := by
          rw [norm_mul]
          exact mul_le_mul_of_nonneg_right (hcb χ) (norm_nonneg _)
        have h3 := norm_add_le (c χ * A.indicator 1 χ) (c χ * (trigPoly (a n) χ - A.indicator 1 χ))
        rw [e, ← hind]
        have hsq := pow_le_pow_left₀ (norm_nonneg _) h3 2
        nlinarith [hsq, sq_nonneg (‖c χ * A.indicator 1 χ‖ - ‖c χ * (trigPoly (a n) χ - A.indicator 1 χ)‖),
          norm_nonneg (c χ * (trigPoly (a n) χ - A.indicator 1 χ)), norm_nonneg (trigPoly (a n) χ - A.indicator 1 χ)]
      have hintI : Integrable (A.indicator fun χ => ‖((χ z : Circle) : ℂ) - 1‖ ^ 2) σ := by
        refine (Integrable.of_bound (C := 4) ((hcm.norm.pow_const 2).aestronglyMeasurable)
          (Filter.Eventually.of_forall fun χ => ?_)).indicator hA
        rw [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg _)]
        nlinarith [hcb χ, norm_nonneg (c χ)]
      have hintL : Integrable (fun χ => ‖c χ * trigPoly (a n) χ‖ ^ 2) σ := by
        refine Integrable.of_bound (C := (2 * ∑ y ∈ (a n).support, ‖a n y‖) ^ 2)
          (((hcm.mul (measurable_trigPoly (a n))).norm.pow_const 2).aestronglyMeasurable)
          (Filter.Eventually.of_forall fun χ => ?_)
        rw [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg _), norm_mul]
        exact pow_le_pow_left₀ (by positivity)
          (mul_le_mul (hcb χ) (norm_trigPoly_le (a n) χ) (norm_nonneg _) (by norm_num)) 2
      calc ‖V (u n) - u n‖ ^ 2 ≤ ∫ χ, ‖c χ * trigPoly (a n) χ‖ ^ 2 ∂σ := h1
        _ ≤ ∫ χ, (2 * A.indicator (fun χ => ‖((χ z : Circle) : ℂ) - 1‖ ^ 2) χ +
              8 * ‖trigPoly (a n) χ - A.indicator 1 χ‖ ^ 2) ∂σ :=
            integral_mono hintL ((hintI.const_mul 2).add ((integrable_err σ hA (a n)).const_mul 8)) hpt
        _ = 2 * J + 8 * ε n := by
            rw [integral_add (hintI.const_mul 2) ((integrable_err σ hA (a n)).const_mul 8), integral_const_mul,
              integral_const_mul, integral_indicator hA]
    have hlimR : Tendsto (fun n => 2 * J + 8 * ε n) atTop (𝓝 (2 * J)) := by
      simpa using (ha.const_mul 8).const_add (2 * J)
    exact le_of_tendsto_of_tendsto' hlimL hlimR hbound

/-- **The cyclic-subspace step** (FS131-KR1's step (d)): a vector orthogonal to every `l`-continuous vector has a spectral
measure that gives measure `0` to every measurable set `A` of characters tending to `1` along `l`, for `l` countably
generated. The spectral vector `w` of `A` (`exists_spectral_vector`) is `l`-continuous (its bound tends to `0` along `l` by
dominated convergence, each `χ ∈ A` tending to `1`), so `σ(A) = ⟨w, f⟩ = 0`. -/
theorem spectral_null_of_orthogonal [Countable R] (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (hadd : ∀ x y, T (x + y) = T x ∘ T y) (l : Filter R) [l.IsCountablyGenerated] {A : Set (AddChar R Circle)}
    (hA : MeasurableSet A) (hAl : ∀ χ ∈ A, Tendsto (fun y => ((χ y : Circle) : ℂ)) l (𝓝 1))
    {f : Lp ℝ 2 μ} {σ : Measure (AddChar R Circle)} (hσ : IsSpectralMeasureOf T hT f σ)
    (horth : ∀ g ∈ contVec T hT l, inner ℝ f g = 0) : σ A = 0 := by
  haveI := hσ.1
  obtain ⟨w, hwf, hw⟩ := exists_spectral_vector T hT hadd hσ hA
  have hJ : Tendsto (fun z => ∫ χ in A, ‖((χ z : Circle) : ℂ) - 1‖ ^ 2 ∂σ) l (𝓝 0) := by
    have h := tendsto_integral_filter_of_dominated_convergence (μ := σ.restrict A) (l := l)
      (F := fun z χ => ‖((χ z : Circle) : ℂ) - 1‖ ^ 2) (f := fun _ => (0 : ℝ)) (fun _ => (4 : ℝ))
      (Eventually.of_forall fun z =>
        (((measurable_evalChar z).sub measurable_const).norm.pow_const 2).aestronglyMeasurable)
      (Eventually.of_forall fun z => Eventually.of_forall fun χ => ?_) (integrable_const 4) ?_
    · simpa using h
    · have h1 : ‖((χ z : Circle) : ℂ) - 1‖ ≤ 2 := (norm_sub_le _ _).trans (by simp; norm_num)
      rw [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg _)]
      nlinarith [norm_nonneg (((χ z : Circle) : ℂ) - 1)]
    · rw [ae_restrict_iff' hA]
      refine Eventually.of_forall fun χ hχ => ?_
      have h1 := (((hAl χ hχ).sub_const 1).norm).pow 2
      simpa using h1
  have hwc : w ∈ contVec T hT l := by
    show Tendsto (fun z => ‖Lp.compMeasurePreserving (T z) (hT z) w - w‖) l (𝓝 0)
    have h2 : Tendsto (fun z => Real.sqrt (2 * ∫ χ in A, ‖((χ z : Circle) : ℂ) - 1‖ ^ 2 ∂σ)) l (𝓝 0) := by
      have h2J : Tendsto (fun z => 2 * ∫ χ in A, ‖((χ z : Circle) : ℂ) - 1‖ ^ 2 ∂σ) l (𝓝 0) := by
        simpa using hJ.const_mul 2
      have := (Real.continuous_sqrt.tendsto 0).comp h2J
      simpa [Function.comp_def] using this
    refine squeeze_zero (fun _ => norm_nonneg _) (fun z => ?_) h2
    exact (Real.le_sqrt (norm_nonneg _) ((sq_nonneg _).trans (hw z))).2 (hw z)
  have h0 := horth w hwc
  rw [real_inner_comm, hwf] at h0
  exact (measureReal_eq_zero_iff (measure_ne_top σ A)).mp h0

/-- **The cyclic-subspace step at a topology**: orthogonal to the `t`-continuous vectors, the spectral measure is null on the
`t`-continuous characters (each tends to `1` at `0`). -/
theorem spectral_contChars_null_of_orthogonal [Countable R] (t : TopologicalSpace R)
    (hcount : (@nhds R t 0).IsCountablyGenerated) (hmeas : MeasurableSet (contChars t)) (T : R → Ω → Ω)
    (hT : ∀ y, MeasurePreserving (T y) μ μ) (hadd : ∀ x y, T (x + y) = T x ∘ T y) {f : Lp ℝ 2 μ}
    {σ : Measure (AddChar R Circle)} (hσ : IsSpectralMeasureOf T hT f σ)
    (horth : ∀ g ∈ contVec T hT (@nhds R t 0), inner ℝ f g = 0) : σ (contChars t) = 0 := by
  letI := t
  haveI := hcount
  refine spectral_null_of_orthogonal T hT hadd _ hmeas (fun χ hχ => ?_) hσ horth
  have hc : Continuous fun y => χ y := hχ
  have h := (continuous_subtype_val.tendsto (χ 0)).comp (hc.tendsto 0)
  rw [AddChar.map_zero_eq_one] at h
  simpa [Function.comp_def] using h

/-! ### `Π = E[· | 𝒜]`, in spectral form -/

/-- **J45 N2's last clause, in spectral form**: for a group topology `t` on `R` with countably generated neighbourhoods of
`0`, Bochner's theorem for `t` and measurable continuous characters, and an action of `R` on a probability space, the
spectral measure of `E[f | 𝒜_t]` is `σ_f` on the `t`-continuous characters and that of `f − E[f | 𝒜_t]` is `σ_f` off them.
`E[f | 𝒜_t]` is continuous (`condExpL2_mem_contVec`), so its spectral measure lives on `contChars t` (`spectral_carried_iff`,
over `BochnerOn t`); the residual is orthogonal to the continuous vectors (`inner_sub_condExpL2_eq_zero`), so its spectral
measure is null there (`spectral_contChars_null_of_orthogonal`); the two add to `σ_f` (`IsSpectralMeasureOf.add_of_orthogonal`,
uniqueness). -/
theorem isSpectralMeasureOf_condExpL2 [Countable R] (t : TopologicalSpace R) (ht : @IsTopologicalAddGroup R t _)
    (hcount : (@nhds R t 0).IsCountablyGenerated) (hB : BochnerOn t) (hmeas : MeasurableSet (contChars t))
    [IsProbabilityMeasure μ] (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (hadd : ∀ x y, T (x + y) = T x ∘ T y) {f : Lp ℝ 2 μ} {σ : Measure (AddChar R Circle)}
    (hσ : IsSpectralMeasureOf T hT f σ) :
    IsSpectralMeasureOf T hT (condExpL2 ℝ ℝ (factorSigma_le T hT (@nhds R t 0)) f : Lp ℝ 2 μ)
        (σ.restrict (contChars t)) ∧
      IsSpectralMeasureOf T hT (f - (condExpL2 ℝ ℝ (factorSigma_le T hT (@nhds R t 0)) f : Lp ℝ 2 μ))
        (σ.restrict (contChars t)ᶜ) := by
  haveI := hσ.1
  set h := (condExpL2 ℝ ℝ (factorSigma_le T hT (@nhds R t 0)) f : Lp ℝ 2 μ) with hh_def
  obtain ⟨σh, hσh⟩ := exists_isSpectralMeasureOf T hT hadd h
  obtain ⟨σr, hσr⟩ := exists_isSpectralMeasureOf T hT hadd (f - h)
  have hh : h ∈ contVec T hT (@nhds R t 0) := condExpL2_mem_contVec T hT _ f
  have hr : ∀ g ∈ contVec T hT (@nhds R t 0), inner ℝ (f - h) g = 0 := fun g hg =>
    inner_sub_condExpL2_eq_zero T hT _ f hg
  have hsum := IsSpectralMeasureOf.add_of_orthogonal T hT hadd _ hh hr hσh hσr
  rw [add_sub_cancel] at hsum
  have heq : σ = σh + σr := IsSpectralMeasureOf.unique hσ hsum
  have h1 : σh (contChars t)ᶜ = 0 := (spectral_carried_iff t ht hcount hB T hT hadd hσh).mpr hh
  have h2 : σr (contChars t) = 0 := spectral_contChars_null_of_orthogonal t hcount hmeas T hT hadd hσr hr
  have e1 : σ.restrict (contChars t) = σh := by
    rw [heq, Measure.restrict_add, Measure.restrict_eq_zero.mpr h2, add_zero]
    exact Measure.restrict_eq_self_of_ae_mem (ae_iff.mpr h1)
  have e2 : σ.restrict (contChars t)ᶜ = σr := by
    rw [heq, Measure.restrict_add, Measure.restrict_eq_zero.mpr h1, zero_add]
    exact Measure.restrict_eq_self_of_ae_mem (ae_iff.mpr (by simpa using h2))
  rw [e1, e2]
  exact ⟨hσh, hσr⟩

end Spectral

/-! ## Models -/

/-- **A non-degenerate model of the cyclic-subspace step's hypotheses**: `ℤ` acting on `Fin 2` with the counting measure
by `n ↦ (· + n)`, the filter `⊤` (so `contVec` is the invariant vectors, the constants), `f = 1_{0} − ½` (orthogonal to
the constants, `⟨f, V_n f⟩ = (−1)ⁿ/2`), `A = {1}` (the characters tending to `1` along `⊤` are the trivial one only), and
`σ = ½ δ_{χ₋}` with `χ₋(n) = (−1)ⁿ`: every hypothesis holds at once, and `σ(A) = 0` because `χ₋ ≠ 1`. -/
theorem spectral_null_model :
    ∃ (T : ℤ → Fin 2 → Fin 2) (hT : ∀ y, MeasurePreserving (T y) (Measure.count : Measure (Fin 2))
        (Measure.count : Measure (Fin 2)))
      (f : Lp ℝ 2 (Measure.count : Measure (Fin 2))) (σ : Measure (AddChar ℤ Circle)),
      (∀ x y, T (x + y) = T x ∘ T y) ∧ IsSpectralMeasureOf T hT f σ ∧ σ ≠ 0 ∧
        (∀ g ∈ contVec T hT ⊤, inner ℝ f g = 0) ∧
        ∀ χ ∈ ({1} : Set (AddChar ℤ Circle)), Tendsto (fun y => ((χ y : Circle) : ℂ)) ⊤ (𝓝 1) := by
  let T : ℤ → Fin 2 → Fin 2 := fun y i => i + y • (1 : Fin 2)
  have hadd : ∀ x y, T (x + y) = T x ∘ T y := by
    intro x y
    funext i
    simp only [T, Function.comp_apply, add_zsmul]
    abel
  have hmeas : ∀ y, Measurable (T y) := fun y => measurable_of_countable _
  have hT : ∀ y : ℤ, MeasurePreserving (T y) (Measure.count : Measure (Fin 2)) Measure.count := by
    intro y
    refine ⟨hmeas y, ?_⟩
    ext s hs
    rw [Measure.map_apply (hmeas y) hs]
    have e : T y ⁻¹' s = (fun i => i - y • (1 : Fin 2)) '' s := by
      ext i
      simp only [Set.mem_preimage, Set.mem_image, T]
      constructor
      · intro hi
        exact ⟨i + y • (1 : Fin 2), hi, add_sub_cancel_right _ _⟩
      · rintro ⟨j, hj, rfl⟩
        simpa using hj
    rw [e, Measure.count_injective_image sub_left_injective s]
  let f0 : Fin 2 → ℝ := fun i => if i = 0 then 1 / 2 else -1 / 2
  have hf0 : MemLp f0 2 (Measure.count : Measure (Fin 2)) := MemLp.of_discrete
  let f : Lp ℝ 2 (Measure.count : Measure (Fin 2)) := hf0.toLp f0
  have hfe : ∀ i, f i = f0 i := Measure.ae_count_iff.mp (MemLp.coeFn_toLp hf0)
  obtain ⟨σ, hσ⟩ := exists_isSpectralMeasureOf T hT hadd f
  refine ⟨T, hT, f, σ, hadd, hσ, ?_, ?_, ?_⟩
  · intro h0
    have h := hσ.2 0
    rw [h0, integral_zero_measure, integral_mul_comp_eq_inner, compMeasurePreserving_zero hadd f] at h
    have hff : inner ℝ f f = 0 := by exact_mod_cast h.symm
    have hf : f = 0 := inner_self_eq_zero.mp hff
    have h1 := hfe 0
    rw [hf] at h1
    have h00 : (0 : Lp ℝ 2 (Measure.count : Measure (Fin 2))) 0 = 0 :=
      Measure.ae_count_iff.mp (Lp.coeFn_zero ℝ 2 _) 0
    rw [h00] at h1
    norm_num [f0] at h1
  · intro g hg
    have hg' : Tendsto (fun y => ‖Lp.compMeasurePreserving (T y) (hT y) g - g‖) ⊤ (𝓝 0) := hg
    have hg1 : Lp.compMeasurePreserving (T 1) (hT 1) g = g := by
      by_contra hne
      have hpos : 0 < ‖Lp.compMeasurePreserving (T 1) (hT 1) g - g‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hne)
      have h := Filter.eventually_top.mp (hg'.eventually (gt_mem_nhds hpos)) 1
      exact lt_irrefl _ h
    have hge : ∀ i, g (T 1 i) = g i := by
      have h1 := Lp.coeFn_compMeasurePreserving g (hT 1)
      rw [hg1] at h1
      intro i
      exact (Measure.ae_count_iff.mp h1 i).symm
    have e : T 1 0 = 1 := by simp [T]
    have h01 := hge 0
    rw [e] at h01
    rw [L2.inner_def, integral_count, Fin.sum_univ_two, hfe, hfe, h01]
    have h10 : (1 : Fin 2) ≠ 0 := by decide
    simp [f0, h10]
    ring
  · intro χ hχ
    rw [Set.mem_singleton_iff] at hχ
    subst hχ
    simp only [AddChar.one_apply, Circle.coe_one]
    exact tendsto_const_nhds

-- `trigPoly` would drift if a coefficient or an evaluation moved: `P_{δ_y}(χ) = χ(y)`.
example (χ : AddChar ℤ Circle) (y : ℤ) : trigPoly (Finsupp.single y 1) χ = ((χ y : Circle) : ℂ) := by
  simp [trigPoly]

-- `koopmanSum` at a single coefficient is one Koopman operator.
example {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} (T : ℤ → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (f : Lp ℝ 2 μ) (y : ℤ) : koopmanSum T hT f (Finsupp.single y 1) = Lp.compMeasurePreserving (T y) (hT y) f := by
  simp [koopmanSum]

end

end HadwigerNelson.Rigidity
