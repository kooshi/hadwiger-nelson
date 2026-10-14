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
  sorry

/-- **The Koopman correlation is positive definite**: `Σ_{x,y} z_x z̄_y ⟨f, V_{x−y} f⟩ = ‖Σ Re z_x V_x f‖² + ‖Σ Im z_x V_x
f‖²` (the Gram matrix `⟨V_x f, V_y f⟩` is real and symmetric). -/
theorem posDef_koopman (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (hadd : ∀ x y, T (x + y) = T x ∘ T y) (f : Lp ℝ 2 μ) :
    PosDef fun y => ((∫ ω, f ω * Lp.compMeasurePreserving (T y) (hT y) f ω ∂μ : ℝ) : ℂ) := by
  sorry

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
  sorry

/-- **`V_y` moves across the inner product as `V_{−y}`**: `⟨g, V_y f⟩ = ⟨V_{−y} g, f⟩`. -/
theorem inner_comp_eq_inner_comp_neg (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (hadd : ∀ x y, T (x + y) = T x ∘ T y) (g f : Lp ℝ 2 μ) (y : R) :
    inner ℝ g (Lp.compMeasurePreserving (T y) (hT y) f) =
      inner ℝ (Lp.compMeasurePreserving (T (-y)) (hT (-y)) g) f := by
  sorry

/-- **Orthogonal pieces add** (SI-1's cross terms): for `h` an `l`-continuous vector and `r` orthogonal to every
`l`-continuous vector, `σ_{h + r} = σ_h + σ_r`. -/
theorem IsSpectralMeasureOf.add_of_orthogonal (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (hadd : ∀ x y, T (x + y) = T x ∘ T y) (l : Filter R) {h r : Lp ℝ 2 μ} (hh : h ∈ contVec T hT l)
    (hr : ∀ g ∈ contVec T hT l, inner ℝ r g = 0) {σh σr : Measure (AddChar R Circle)}
    (hσh : IsSpectralMeasureOf T hT h σh) (hσr : IsSpectralMeasureOf T hT r σr) :
    IsSpectralMeasureOf T hT (h + r) (σh + σr) := by
  sorry

/-! ### The cyclic-subspace step -/

/-- **Trigonometric polynomials are dense in `L²(σ)`**, for a finite measure on the dual of a countable group: every
measurable set's indicator is an `L²(σ)`-limit of them. Stone–Weierstrass on the compact dual (the evaluations span a star
subalgebra of `C(R̂, ℂ)` separating points) and the density of continuous functions in `L²` of a finite Borel measure. -/
theorem exists_trigPoly_tendsto [Countable R] (σ : Measure (AddChar R Circle)) [IsFiniteMeasure σ]
    {A : Set (AddChar R Circle)} (hA : MeasurableSet A) :
    ∃ a : ℕ → (R →₀ ℂ), Tendsto (fun n => ∫ χ, ‖trigPoly (a n) χ - A.indicator 1 χ‖ ^ 2 ∂σ) atTop (𝓝 0) := by
  sorry

/-- **The Koopman isometry, in real and imaginary parts**: `‖Σ Re(a_y) V_y f‖² + ‖Σ Im(a_y) V_y f‖² = ∫ |P_a|² dσ_f`. -/
theorem norm_sq_koopmanSum_re_add_im (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (hadd : ∀ x y, T (x + y) = T x ∘ T y) {f : Lp ℝ 2 μ} {σ : Measure (AddChar R Circle)}
    (hσ : IsSpectralMeasureOf T hT f σ) (a : R →₀ ℂ) :
    ‖koopmanSum T hT f (a.mapRange Complex.re Complex.zero_re)‖ ^ 2 +
        ‖koopmanSum T hT f (a.mapRange Complex.im Complex.zero_im)‖ ^ 2 =
      ∫ χ, ‖trigPoly a χ‖ ^ 2 ∂σ := by
  sorry

/-- **The real Koopman sum against `f`**: `⟨Σ Re(a_y) V_y f, f⟩ = Re ∫ P_a dσ_f`. -/
theorem inner_koopmanSum_re (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) {f : Lp ℝ 2 μ}
    {σ : Measure (AddChar R Circle)} (hσ : IsSpectralMeasureOf T hT f σ) (a : R →₀ ℂ) :
    inner ℝ (koopmanSum T hT f (a.mapRange Complex.re Complex.zero_re)) f = (∫ χ, trigPoly a χ ∂σ).re := by
  sorry

/-- **`V_z` on a Koopman sum shifts its coefficients**: `V_z (Σ b_y V_y f) = Σ b_y V_{y + z} f`. -/
theorem comp_koopmanSum (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (hadd : ∀ x y, T (x + y) = T x ∘ T y) (f : Lp ℝ 2 μ) (b : R →₀ ℝ) (z : R) :
    Lp.compMeasurePreserving (T z) (hT z) (koopmanSum T hT f b) = koopmanSum T hT f (b.mapDomain (· + z)) := by
  sorry

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
  sorry

/-- **The cyclic-subspace step** (FS131-KR1's step (d)): a vector orthogonal to every `l`-continuous vector has a spectral
measure that gives measure `0` to every measurable set `A` of characters tending to `1` along `l`, for `l` countably
generated. The spectral vector `w` of `A` (`exists_spectral_vector`) is `l`-continuous (its bound tends to `0` along `l` by
dominated convergence, each `χ ∈ A` tending to `1`), so `σ(A) = ⟨w, f⟩ = 0`. -/
theorem spectral_null_of_orthogonal [Countable R] (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (hadd : ∀ x y, T (x + y) = T x ∘ T y) (l : Filter R) [l.IsCountablyGenerated] {A : Set (AddChar R Circle)}
    (hA : MeasurableSet A) (hAl : ∀ χ ∈ A, Tendsto (fun y => ((χ y : Circle) : ℂ)) l (𝓝 1))
    {f : Lp ℝ 2 μ} {σ : Measure (AddChar R Circle)} (hσ : IsSpectralMeasureOf T hT f σ)
    (horth : ∀ g ∈ contVec T hT l, inner ℝ f g = 0) : σ A = 0 := by
  sorry

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
  sorry

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
  sorry

-- `trigPoly` would drift if a coefficient or an evaluation moved: `P_{δ_y}(χ) = χ(y)`.
example (χ : AddChar ℤ Circle) (y : ℤ) : trigPoly (Finsupp.single y 1) χ = ((χ y : Circle) : ℂ) := by
  simp [trigPoly]

-- `koopmanSum` at a single coefficient is one Koopman operator.
example {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} (T : ℤ → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (f : Lp ℝ 2 μ) (y : ℤ) : koopmanSum T hT f (Finsupp.single y 1) = Lp.compMeasurePreserving (T y) (hT y) f := by
  simp [koopmanSum]

end

end HadwigerNelson.Rigidity
