import Proofs.HadwigerNelson.Collapse.Colouring
import Proofs.HadwigerNelson.Rigidity.ZeroEntropyClosed

/-!
# The dichotomy at `T + A`, closed by MR⁺: an invariant `k`-colouring with its spectrum on `T + A` (FS-131, job FS131-KCL1; module C3)

**Read aloud, against the informal claim** (V1-L1–L3, `plans/FS103-V1-verification.md` ll. 101–124; V2 Step 2, ll. 116–122; the
one use of MR in `LEDGER.md` row 128's derivation, `plans/FS131-KCL1-collapse-plan.md` § 2.1). For an invariant random proper
`k`-colouring `μ` of `Cay(R, U)`:

* **the colour spectral measure** `σ` (`IsColourSpectral`): `∫ χ(y) dσ = P(c(0) = c(y))` — the sum over the colours `j` of
  the spectral measures of the indicators `1{c(0) = j}`. It is finite, of mass `1`, rotation-invariant
  (`IsColourSpectral.rotInv`), and `∫ χ(u) dσ = 0` at every unit vector (`IsColourSpectral.integral_unit`: the colouring is
  proper). It replaces the derivation's simplex measure; the constants `k/(k − 1)` never appear.
* **SI-3 at `T + A`** (`setIntegral_compl_TA_re_k`): `∫_{R̂∖(T+A)} Re χ(u) dσ = −Σ_j E[p_j(0) p_j(u)]` with
  `p_j(x) = P(c(x) = j | 𝒜)` and `𝒜` the factor of the `τ′_∅`-continuous vectors; each term is `≥ 0`, and the left side does
  not depend on `u` (`setIntegral_compl_TA_rot_k`).
* **the SP witness** (`IsSPWitness`, D-SP at a set `E`) and **its exclusion by MR⁺** (`not_isSPWitness_of_mrPlus`, proved:
  stage 2 of the record), at every real number field (`not_isSPWitness`, on `Rigidity.mrPlus`).
* **the factor colouring** (`exists_factorLawK`, SI-4 with `APlus`'s factor): if `Σ_j E[p_j(0) p_j(u)] = 0` at every `u`, the
  least colour of the conditional support is an invariant proper `k`-colouring whose colour spectral measures are carried by
  `T + A`.
* **`exists_invColouring_TA`**: so every invariant `k`-colouring has a sibling with its spectrum on `T + A` — case (B) of the
  load-bearing step is empty.

**Route** (record § 3.1, L1–L3). The four-colour proofs (`Rigidity/TraceSplit`, `Rigidity/APlus`, SI-4 in
`Arith/SpectralInputs`) at `Fin k`, on the colour spectral measure; `Rigidity.isSpectralMeasureOf_condExpL2` at `tauPrime F`,
`contChars_tauPrime`, `bochnerOn_tauPrime` are read as they are.

**Models.** `InvColouring ⊥ 2` is inhabited (`Collapse.nonempty_invColouring_bot`), and every `InvColouring` has a colour
spectral measure (`exists_isColourSpectral`). `IsSPWitness F E τ` is empty at every `E ⊇ T + A` over a number field: that is
the theorem (`not_isSPWitness`); `not_isSPWitness_of_mrPlus` reads `MRPlus F`, whose models are `Rigidity/ChainAtTA`'s.
`EqualAtUnitsK` holds at the model over `ℚ` with its residue two-colouring, whose spectrum is torsion, so in `T + A`.
-/

namespace HadwigerNelson.Collapse

open SpectralChain SpectralInputs MeasureTheory NumberField Rigidity Filter Topology

noncomputable section

/-! ## The SP witness and MR⁺ (stage 2) -/

section Witness

variable (F : Subfield ℝ)

/-- **D-SP** (`plans/FS100-BC-verification.md` § 1.2, as `data/fs103/claims.md` § 0 quotes it): "a finite positive
`U`-invariant Borel measure `τ` on `R̂` with `τ(E) = 0` and `∫ Re χ(1) dτ < 0`" — at a set `E` of characters. -/
def IsSPWitness (E : Set (Dual F)) (τ : Measure (Dual F)) : Prop :=
  IsFiniteMeasure τ ∧ RotInv F τ ∧ τ E = 0 ∧ ∫ χ, ((χ 1 : Circle) : ℂ).re ∂τ < 0

variable {F}

/-- **MR⁺ excludes every SP witness at every `E ⊇ T + A`** — the one use of MR in row 128's derivation (V1 l. 176). -/
theorem not_isSPWitness_of_mrPlus (h : MRPlus F) {E : Set (Dual F)} (hE : TA F ⊆ E) (τ : Measure (Dual F)) :
    ¬ IsSPWitness F E τ := by
  rintro ⟨hfin, hrot, hτE, hneg⟩
  have hTA : τ (TA F) = 0 := measure_mono_null hE hτE
  have h1 : ∫ χ, ((χ 1 : Circle) : ℂ) ∂τ = 0 := h τ hfin hrot hTA 1 one_ne_zero
  have hint : Integrable (fun χ : Dual F => ((χ 1 : Circle) : ℂ)) τ :=
    Integrable.of_bound (measurable_evalChar (1 : unitRing F)).aestronglyMeasurable 1
      (Filter.Eventually.of_forall fun χ => by rw [Circle.norm_coe])
  have hre : ∫ χ, ((χ 1 : Circle) : ℂ).re ∂τ = 0 := by
    have h2 := integral_re (𝕜 := ℂ) hint
    simp only [RCLike.re_to_complex] at h2
    rw [h2, h1, Complex.zero_re]
  rw [hre] at hneg
  exact lt_irrefl 0 hneg

/-- **No SP witness at any `E ⊇ T + A`, over every real number field** — on `Rigidity.mrPlus`, so on
`[EinsiedlerLindenstrauss2022]` Thm 1.3 (`Rigidity.positive_entropy_rigidity`). -/
theorem not_isSPWitness [NumberField F] {E : Set (Dual F)} (hE : TA F ⊆ E) (τ : Measure (Dual F)) :
    ¬ IsSPWitness F E τ :=
  not_isSPWitness_of_mrPlus (mrPlus F) hE τ

end Witness

/-! ## The colour spectral measure -/

variable {F : Subfield ℝ} {k : ℕ}

/-- **The shift of a `k`-colouring** by `y ∈ R`: `c ↦ c(· + y)`. -/
def colourShiftK (y : unitRing F) (c : unitRing F → Fin k) : unitRing F → Fin k := fun x => c (x + y)

theorem measurable_colourShiftK (y : unitRing F) : Measurable (colourShiftK (k := k) y) :=
  measurable_pi_lambda _ fun _ => measurable_pi_apply _

/-- The shifts are an action of `R`. -/
theorem colourShiftK_add (x y : unitRing F) :
    colourShiftK (k := k) (x + y) = colourShiftK x ∘ colourShiftK y := by
  funext c z
  simp only [colourShiftK, Function.comp_apply, add_assoc]

attribute [local instance] InvColouring.isProb

/-- Each shift preserves the law of an invariant colouring. -/
theorem InvColouring.measurePreserving_shift (μ : InvColouring F k) (y : unitRing F) :
    MeasurePreserving (colourShiftK y) μ.μ μ.μ :=
  ⟨measurable_colourShiftK y, μ.shift_inv y⟩

/-- **`𝒜`, the factor of the `τ′_∅`-continuous vectors** of an invariant `k`-colouring (the four-colour
`Rigidity.colourFactor` at `Fin k`). -/
abbrev factorK [NumberField F] (μ : InvColouring F k) : MeasurableSpace (unitRing F → Fin k) :=
  haveI := μ.isProb
  factorSigma (colourShiftK (F := F) (k := k)) μ.measurePreserving_shift (@nhds _ (tauPrime F) 0)

/-- **The conditional law of the colour at `x`**: `p_j(x) = P(c(x) = j | 𝒜)` (SpectralInputs' `condLaw` at `Fin k`). -/
def condLawK {Ω V : Type*} (𝒜 : MeasurableSpace Ω) [MeasurableSpace Ω] (μ : Measure Ω) (c : Ω → V → Fin k) (x : V)
    (j : Fin k) : Ω → ℝ :=
  μ[(Set.indicator {ω' | c ω' x = j} fun _ => (1 : ℝ)) | 𝒜]

/-- **The colour spectral measure** of a random colouring: `∫ χ(y) dσ = P(c(0) = c(y))` for every `y ∈ R` — the sum over the
colours of the spectral measures of the indicators `1{c(0) = j}`. -/
def IsColourSpectral (μ : Measure (unitRing F → Fin k)) (σ : Measure (Dual F)) : Prop :=
  IsFiniteMeasure σ ∧ ∀ y : unitRing F, ∫ χ, (χ y : ℂ) ∂σ = ((μ.real {c | c 0 = c y} : ℝ) : ℂ)


/-! ### Colour indicators and the colour spectral measure (FS131-ICO1's helpers) -/

-- FS131-ICO1: **the colour indicator** `e_j = 1{κ₀ = j}` in `L²(μ)` (`Rigidity.colourInd` at `Fin k`).
private def colourIndK {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω) [IsFiniteMeasure μ] (κ₀ : Ω → Fin k)
    (hκ₀ : Measurable κ₀) (j : Fin k) : Lp ℝ 2 μ :=
  indicatorConstLp 2 (hκ₀ (measurableSet_singleton j)) (measure_ne_top μ _) 1

-- FS131-ICO1: **a colour indicator's Koopman correlation**: `⟨e_j, V_y e_j⟩ = μ(κ(0) = j, κ(y) = j)`
-- (`Rigidity.integral_colourInd_mul_comp` at `Fin k`).
private theorem integral_colourIndK_mul_comp {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω) [IsProbabilityMeasure μ]
    (T : unitRing F → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) (κ : Ω → unitRing F → Fin k)
    (hκ : ∀ x, Measurable fun ω => κ ω x) (hequiv : ∀ y, ∀ᵐ ω ∂μ, κ (T y ω) 0 = κ ω y) (y : unitRing F) (j : Fin k) :
    ∫ ω, colourIndK μ (fun ω => κ ω 0) (hκ 0) j ω *
        Lp.compMeasurePreserving (T y) (hT y) (colourIndK μ (fun ω => κ ω 0) (hκ 0) j) ω ∂μ =
      μ.real {ω | κ ω 0 = j ∧ κ ω y = j} := by
  have h1 : (colourIndK μ (fun ω => κ ω 0) (hκ 0) j : Ω → ℝ) =ᵐ[μ]
      ((fun ω => κ ω 0) ⁻¹' ({j} : Set (Fin k))).indicator fun _ => (1 : ℝ) :=
    indicatorConstLp_coeFn
  have h2 := Lp.coeFn_compMeasurePreserving (colourIndK μ (fun ω => κ ω 0) (hκ 0) j) (hT y)
  have h3 := h1.comp_tendsto (hT y).quasiMeasurePreserving.tendsto_ae
  have hmeas : MeasurableSet {ω | κ ω 0 = j ∧ κ ω y = j} :=
    ((hκ 0) (measurableSet_singleton j)).inter ((hκ y) (measurableSet_singleton j))
  rw [← integral_indicator_one hmeas]
  refine integral_congr_ae ?_
  filter_upwards [h1, h2, h3, hequiv y] with ω e1 e2 e3 e4
  rw [e2, e3, e1]
  simp only [Function.comp_apply, Set.indicator_apply, Set.mem_setOf_eq, Pi.one_apply]
  by_cases ha : κ ω 0 = j <;> by_cases hb : κ ω y = j <;> simp [ha, hb, e4]

-- FS131-ICO1: `P(κ(0) = κ(y)) = Σ_j P(κ(0) = j = κ(y))`.
private theorem measureReal_eq_sum_colours {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω) [IsFiniteMeasure μ]
    (κ : Ω → unitRing F → Fin k) (hκ : ∀ x, Measurable fun ω => κ ω x) (y : unitRing F) :
    μ.real {ω | κ ω 0 = κ ω y} = ∑ j : Fin k, μ.real {ω | κ ω 0 = j ∧ κ ω y = j} := by
  have hU : {ω | κ ω 0 = κ ω y} = ⋃ j ∈ (Finset.univ : Finset (Fin k)), {ω | κ ω 0 = j ∧ κ ω y = j} := by
    ext ω
    simp only [Set.mem_setOf_eq, Set.mem_iUnion, Finset.mem_univ, true_and, exists_prop]
    exact ⟨fun h => ⟨κ ω 0, rfl, h.symm⟩, fun ⟨j, h0, hy⟩ => h0.trans hy.symm⟩
  have hdisj : Set.PairwiseDisjoint (↑(Finset.univ : Finset (Fin k)))
      fun j => {ω | κ ω 0 = j ∧ κ ω y = j} :=
    fun j _ j' _ hne => Set.disjoint_left.2 fun ω h1 h2 => hne (h1.1.symm.trans h2.1)
  rw [hU, measureReal_def, measure_biUnion_finset hdisj fun j _ =>
    ((hκ 0) (measurableSet_singleton j)).inter ((hκ y) (measurableSet_singleton j)),
    ENNReal.toReal_sum fun j _ => measure_ne_top _ _]
  rfl

-- FS131-ICO1: **the colour spectral measure is the sum of the colours' spectral measures** (Fourier uniqueness): for a
-- random colouring `κ` moved equivariantly at `0` by an action `T`, a finite measure with coefficients
-- `P(κ(0) = κ(y))` is `Σ_j σ_{e_j}`.
private theorem colour_decomp [NumberField F] {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω) [IsProbabilityMeasure μ]
    (T : unitRing F → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) (κ : Ω → unitRing F → Fin k)
    (hκ : ∀ x, Measurable fun ω => κ ω x) (hequiv : ∀ y, ∀ᵐ ω ∂μ, κ (T y ω) 0 = κ ω y)
    {σ : Measure (Dual F)} [IsFiniteMeasure σ]
    (hσ : ∀ y, ∫ χ, (χ y : ℂ) ∂σ = ((μ.real {ω | κ ω 0 = κ ω y} : ℝ) : ℂ))
    {σc : Fin k → Measure (Dual F)}
    (hσc : ∀ j, IsSpectralMeasureOf T hT (colourIndK μ (fun ω => κ ω 0) (hκ 0) j) (σc j)) :
    σ = ∑ j, σc j := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  haveI : ∀ j, IsFiniteMeasure (σc j) := fun j => (hσc j).1
  haveI : IsFiniteMeasure (∑ j, σc j) :=
    ⟨by rw [Measure.finsetSum_apply]; exact ENNReal.sum_lt_top.2 fun j _ => measure_lt_top _ _⟩
  refine measure_eq_of_fourier fun y => ?_
  rw [hσ y, integral_finsetSum_measure fun j _ => integrable_evalChar _ y, measureReal_eq_sum_colours μ κ hκ y]
  push_cast
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [(hσc j).2 y, integral_colourIndK_mul_comp μ T hT κ hκ hequiv y j]

-- FS131-ICO1: the shifts of `R → Fin k` move the identity colouring equivariantly at `0`.
private theorem shift_equiv_id (y : unitRing F) (c : unitRing F → Fin k) :
    (fun c : unitRing F → Fin k => c) (colourShiftK y c) 0 = c y := by
  simp [colourShiftK]

/-- **Every invariant colouring has a colour spectral measure** (Herglotz–Bochner on the countable `R`, per colour:
`Rigidity.exists_isSpectralMeasureOf` for each indicator, summed). -/
theorem exists_isColourSpectral [NumberField F] (μ : InvColouring F k) : ∃ σ : Measure (Dual F), IsColourSpectral μ.μ σ := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  have hex : ∀ j : Fin k, ∃ σj : Measure (Dual F), IsSpectralMeasureOf colourShiftK μ.measurePreserving_shift
      (colourIndK μ.μ (fun c => c 0) (measurable_pi_apply 0) j) σj := fun j =>
    exists_isSpectralMeasureOf colourShiftK μ.measurePreserving_shift colourShiftK_add _
  choose σc hσc using hex
  haveI : ∀ j, IsFiniteMeasure (σc j) := fun j => (hσc j).1
  refine ⟨∑ j, σc j, ⟨by rw [Measure.finsetSum_apply]; exact ENNReal.sum_lt_top.2 fun j _ => measure_lt_top _ _⟩,
    fun y => ?_⟩
  rw [integral_finsetSum_measure fun j _ => integrable_evalChar _ y,
    measureReal_eq_sum_colours μ.μ (fun c => c) (fun x => measurable_pi_apply x) y]
  push_cast
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [(hσc j).2 y, integral_colourIndK_mul_comp μ.μ colourShiftK μ.measurePreserving_shift (fun c => c)
    (fun x => measurable_pi_apply x) (fun y => Eventually.of_forall fun c => shift_equiv_id y c) y j]

/-- **It is rotation-invariant** (node L3 at `k` colours): the law is, so `P(c(0) = c(uy)) = P(c(0) = c(y))`, and Fourier
uniqueness (`Rigidity.measure_eq_of_fourier`). -/
theorem IsColourSpectral.rotInv [NumberField F] (μ : InvColouring F k) {σ : Measure (Dual F)}
    (hσ : IsColourSpectral μ.μ σ) : RotInv F σ := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  haveI := hσ.1
  intro u
  have hρ : Measurable (fun (c : unitRing F → Fin k) (x : unitRing F) => c (uvRing u * x)) :=
    measurable_pi_lambda _ fun x => measurable_pi_apply _
  have hcoef : ∀ y, μ.μ.real {c : unitRing F → Fin k | c 0 = c (uvRing u * y)} = μ.μ.real {c | c 0 = c y} := by
    intro y
    have hmeas : MeasurableSet {c : unitRing F → Fin k | c 0 = c y} :=
      measurableSet_eq_fun (measurable_pi_apply 0) (measurable_pi_apply y)
    have e : {c : unitRing F → Fin k | c 0 = c (uvRing u * y)} =
        (fun (c : unitRing F → Fin k) (x : unitRing F) => c (uvRing u * x)) ⁻¹' {c | c 0 = c y} := by
      ext c
      simp only [Set.mem_setOf_eq, Set.mem_preimage, mul_zero]
    rw [e, measureReal_def, measureReal_def, ← Measure.map_apply hρ hmeas, μ.rot_inv u]
  haveI : IsFiniteMeasure (σ.map (rot u)) := Measure.isFiniteMeasure_map σ (rot u)
  refine measure_eq_of_fourier fun y => ?_
  rw [integral_map (measurable_rot u).aemeasurable (measurable_evalChar y).aestronglyMeasurable]
  show ∫ χ, (χ (uvRing u * y) : ℂ) ∂σ = _
  rw [hσ.2, hσ.2, hcoef]

/-- **At a unit vector its coefficient is `0`**: the colouring is proper, `P(c(0) = c(u)) = 0`. -/
theorem IsColourSpectral.integral_unit (μ : InvColouring F k) {σ : Measure (Dual F)} (hσ : IsColourSpectral μ.μ σ)
    (u : unitVectors F) : ∫ χ, (χ (uvRing u) : ℂ) ∂σ = 0 := by
  rw [hσ.2]
  have hsub : {c : unitRing F → Fin k | c 0 = c (uvRing u)} ⊆ (Xk F k)ᶜ := fun c hc hX =>
    hX 0 (uvRing u) (by simp [uvRing]) hc
  rw [measureReal_def, measure_mono_null hsub μ.carried, ENNReal.toReal_zero, Complex.ofReal_zero]

/-- The restriction of a rotation-invariant measure to the complement of `T + A` is rotation-invariant (`T + A` is). -/
theorem rotInv_restrict_compl_TA [NumberField F] {σ : Measure (Dual F)} (hσ : RotInv F σ) :
    RotInv F (σ.restrict (TA F)ᶜ) := by
  intro u
  have hpre : rot u ⁻¹' (TA F)ᶜ = (TA F)ᶜ := by rw [Set.preimage_compl, rot_preimage_TA F u]
  conv_lhs => rw [← hpre]
  rw [← Measure.restrict_map (measurable_rot u) (measurableSet_TA F).compl, hσ u]

/-! ### SI-4 at `k` colours (FS131-ICO1's helpers: `SpectralInputs`' selection block at `Fin k`) -/

section SelectionK

variable {Ω V : Type*}

-- FS131-ICO1: the conditional support `M(x) = {j : P(c(x) = j | 𝒜) > 0}`.
private def condSupportK (𝒜 : MeasurableSpace Ω) [MeasurableSpace Ω] (μ : Measure Ω) (c : Ω → V → Fin k) (ω : Ω)
    (x : V) : Finset (Fin k) :=
  Finset.univ.filter fun j => 0 < condLawK 𝒜 μ c x j ω

variable (𝒜 : MeasurableSpace Ω) [m0 : MeasurableSpace Ω] (μ : Measure Ω) (c : Ω → V → Fin k)

private theorem mem_condSupportK {ω : Ω} {x : V} {j : Fin k} :
    j ∈ condSupportK 𝒜 μ c ω x ↔ 0 < condLawK 𝒜 μ c x j ω := by
  simp [condSupportK]

private theorem measurable_condLawK (x : V) (j : Fin k) : Measurable[𝒜] (condLawK 𝒜 μ c x j) :=
  (stronglyMeasurable_condExp (m := 𝒜) (μ := μ) (f := Set.indicator {ω' | c ω' x = j} fun _ => (1 : ℝ))).measurable

private theorem measurableSet_condSupportK_eq (x : V) (s : Finset (Fin k)) :
    MeasurableSet[𝒜] {ω | condSupportK 𝒜 μ c ω x = s} := by
  have h : {ω | condSupportK 𝒜 μ c ω x = s} = ⋂ j : Fin k, {ω | 0 < condLawK 𝒜 μ c x j ω ↔ j ∈ s} := by
    ext ω
    simp only [Set.mem_setOf_eq, Set.mem_iInter, Finset.ext_iff, mem_condSupportK]
  rw [h]
  refine MeasurableSet.iInter fun j => ?_
  have hpos : MeasurableSet[𝒜] {ω | 0 < condLawK 𝒜 μ c x j ω} := measurable_condLawK 𝒜 μ c x j measurableSet_Ioi
  by_cases hj : j ∈ s
  · simpa only [hj, iff_true] using hpos
  · simp only [hj, iff_false]
    exact hpos.compl

private theorem measurable_selectionK (f : Finset (Fin k) → Fin k) (x : V) :
    Measurable[𝒜] fun ω => f (condSupportK 𝒜 μ c ω x) := by
  refine @measurable_to_countable' (Fin k) Ω _ _ 𝒜 _ fun i => ?_
  have h : (fun ω => f (condSupportK 𝒜 μ c ω x)) ⁻¹' {i} =
      ⋃ s : Finset (Fin k), ⋃ (_ : f s = i), {ω | condSupportK 𝒜 μ c ω x = s} := by
    ext ω
    simp
  rw [h]
  exact MeasurableSet.iUnion fun s => MeasurableSet.iUnion fun _ => measurableSet_condSupportK_eq 𝒜 μ c x s

private theorem condLawK_nonneg (x : V) (j : Fin k) : 0 ≤ᵐ[μ] condLawK 𝒜 μ c x j :=
  condExp_nonneg (Filter.Eventually.of_forall fun ω => Set.indicator_nonneg (fun _ _ => zero_le_one) ω)

variable [IsProbabilityMeasure μ] (h𝒜 : 𝒜 ≤ m0) (hc : ∀ x, Measurable fun ω => c ω x)
include h𝒜 hc

omit h𝒜 in
private theorem integrable_colourIndicatorK (x : V) (j : Fin k) :
    Integrable (Set.indicator {ω' | c ω' x = j} fun _ => (1 : ℝ)) μ :=
  (integrable_const (1 : ℝ)).indicator (hc x (measurableSet_singleton j))

private theorem measure_condLawK_nonpos_inter (x : V) (j : Fin k) :
    μ ({ω | condLawK 𝒜 μ c x j ω ≤ 0} ∩ {ω | c ω x = j}) = 0 := by
  have hA : MeasurableSet {ω | c ω x = j} := hc x (measurableSet_singleton j)
  have hs : MeasurableSet[𝒜] {ω | condLawK 𝒜 μ c x j ω ≤ 0} := measurable_condLawK 𝒜 μ c x j measurableSet_Iic
  have h1 : ∫ ω in {ω | condLawK 𝒜 μ c x j ω ≤ 0}, (Set.indicator {ω' | c ω' x = j} fun _ => (1 : ℝ)) ω ∂μ =
      μ.real ({ω | condLawK 𝒜 μ c x j ω ≤ 0} ∩ {ω | c ω x = j}) := by
    rw [setIntegral_indicator hA, setIntegral_const, smul_eq_mul, mul_one]
  have h2 : μ.real ({ω | condLawK 𝒜 μ c x j ω ≤ 0} ∩ {ω | c ω x = j}) ≤ 0 := by
    rw [← h1, ← setIntegral_condExp h𝒜 (integrable_colourIndicatorK μ c hc x j) hs]
    exact setIntegral_nonpos (h𝒜 _ hs) fun ω hω => hω
  have h3 := le_antisymm h2 measureReal_nonneg
  rwa [measureReal_def, ENNReal.toReal_eq_zero_iff, or_iff_left (measure_ne_top μ _)] at h3

private theorem ae_mem_condSupportK [Countable V] : ∀ᵐ ω ∂μ, ∀ x, c ω x ∈ condSupportK 𝒜 μ c ω x := by
  have h : ∀ᵐ ω ∂μ, ∀ x, ∀ j, ω ∉ {ω | condLawK 𝒜 μ c x j ω ≤ 0} ∩ {ω | c ω x = j} :=
    ae_all_iff.mpr fun x => ae_all_iff.mpr fun j =>
      measure_eq_zero_iff_ae_notMem.mp (measure_condLawK_nonpos_inter 𝒜 μ c h𝒜 hc x j)
  filter_upwards [h] with ω hω x
  rw [mem_condSupportK]
  by_contra hneg
  exact hω x (c ω x) ⟨not_lt.mp hneg, rfl⟩

private theorem condLawK_le_one (x : V) (j : Fin k) : ∀ᵐ ω ∂μ, condLawK 𝒜 μ c x j ω ≤ 1 := by
  have h := condExp_mono (m := 𝒜) (integrable_colourIndicatorK μ c hc x j) (integrable_const (1 : ℝ))
    (Filter.Eventually.of_forall fun ω => Set.indicator_le_self' (fun _ _ => zero_le_one) ω)
  rw [condExp_const h𝒜] at h
  exact h

private theorem ae_condLawK_mul_eq_zero {x y : V} {j : Fin k}
    (h : ∫ ω, condLawK 𝒜 μ c x j ω * condLawK 𝒜 μ c y j ω ∂μ = 0) :
    ∀ᵐ ω ∂μ, condLawK 𝒜 μ c x j ω * condLawK 𝒜 μ c y j ω = 0 := by
  have hnn : 0 ≤ᵐ[μ] fun ω => condLawK 𝒜 μ c x j ω * condLawK 𝒜 μ c y j ω := by
    filter_upwards [condLawK_nonneg 𝒜 μ c x j, condLawK_nonneg 𝒜 μ c y j] with ω h1 h2
    exact mul_nonneg h1 h2
  have hint : Integrable (fun ω => condLawK 𝒜 μ c x j ω * condLawK 𝒜 μ c y j ω) μ := by
    refine Integrable.mono' (integrable_condExp (m := 𝒜) (μ := μ)
      (f := Set.indicator {ω' | c ω' y = j} fun _ => (1 : ℝ))).norm
      ((integrable_condExp (m := 𝒜)).aestronglyMeasurable.mul (integrable_condExp (m := 𝒜)).aestronglyMeasurable) ?_
    filter_upwards [condLawK_nonneg 𝒜 μ c x j, condLawK_le_one 𝒜 μ c h𝒜 hc x j] with ω h1 h2
    rw [norm_mul]
    refine mul_le_of_le_one_left (norm_nonneg _) ?_
    rw [Real.norm_eq_abs, abs_le]
    exact ⟨by have : (0 : ℝ) ≤ condLawK 𝒜 μ c x j ω := h1; linarith, h2⟩
  exact (integral_eq_zero_iff_of_nonneg_ae hnn hint).mp h

omit h𝒜 hc in
-- FS131-ICO1: **SI-4 at `k` colours** (`SpectralInputs.si4` at `Fin k`): orthogonal conditional laws across `adj` make
-- every selection from the supports `𝒜`-measurable and almost surely proper.
private theorem si4K [Countable V] (h𝒜 : 𝒜 ≤ m0) (hc : ∀ x, Measurable fun ω => c ω x)
    (adj : V → V → Prop)
    (hdisj : ∀ x y, adj x y → ∀ j : Fin k, ∫ ω, condLawK 𝒜 μ c x j ω * condLawK 𝒜 μ c y j ω ∂μ = 0)
    (f : Finset (Fin k) → Fin k) (hf : ∀ s : Finset (Fin k), s.Nonempty → f s ∈ s) :
    ∀ᵐ ω ∂μ, ∀ x y, adj x y → f (condSupportK 𝒜 μ c ω x) ≠ f (condSupportK 𝒜 μ c ω y) := by
  have hmem := ae_mem_condSupportK 𝒜 μ c h𝒜 hc
  have hprod : ∀ᵐ ω ∂μ, ∀ x y, adj x y → ∀ j, condLawK 𝒜 μ c x j ω * condLawK 𝒜 μ c y j ω = 0 := by
    refine ae_all_iff.mpr fun x => ae_all_iff.mpr fun y => ?_
    by_cases hxy : adj x y
    · have h : ∀ᵐ ω ∂μ, ∀ j, condLawK 𝒜 μ c x j ω * condLawK 𝒜 μ c y j ω = 0 :=
        ae_all_iff.mpr fun j => ae_condLawK_mul_eq_zero 𝒜 μ c h𝒜 hc (hdisj x y hxy j)
      filter_upwards [h] with ω hω _ using hω
    · exact Filter.Eventually.of_forall fun ω h => absurd h hxy
  filter_upwards [hprod, hmem] with ω h1 h2 x y hxy heq
  have hx := (mem_condSupportK 𝒜 μ c).mp (hf _ ⟨c ω x, h2 x⟩)
  have hy := (mem_condSupportK 𝒜 μ c).mp (hf _ ⟨c ω y, h2 y⟩)
  rw [← heq] at hy
  exact (mul_pos hx hy).ne' (h1 x y hxy _)

omit h𝒜 hc in
-- FS131-ICO1: **SI-4's equivariance clause at `k` colours** (`SpectralInputs.si4_equivariant` at `Fin k`).
private theorem si4_equivariantK [Countable V] (h𝒜 : 𝒜 ≤ m0)
    (hc : ∀ x, Measurable fun ω => c ω x) {S : Ω → Ω} (hS : MeasurePreserving S μ μ) (hS𝒜 : 𝒜.comap S = 𝒜)
    (π : V → V) (hπ : ∀ ω x, c (S ω) x = c ω (π x)) :
    ∀ᵐ ω ∂μ, ∀ x, condSupportK 𝒜 μ c (S ω) x = condSupportK 𝒜 μ c ω (π x) := by
  have h : ∀ᵐ ω ∂μ, ∀ x, ∀ j, condLawK 𝒜 μ c x j (S ω) = condLawK 𝒜 μ c (π x) j ω := by
    refine ae_all_iff.mpr fun x => ae_all_iff.mpr fun j => ?_
    have h1 := condExp_comp_measurePreserving 𝒜 μ h𝒜 hS hS𝒜 (integrable_colourIndicatorK μ c hc x j)
    have h2 : (Set.indicator {ω' | c ω' x = j} fun _ => (1 : ℝ)) ∘ S =
        Set.indicator {ω' | c ω' (π x) = j} fun _ => (1 : ℝ) := by
      funext ω
      simp only [Function.comp_apply, Set.indicator_apply, Set.mem_setOf_eq, hπ]
    rw [h2] at h1
    exact h1
  filter_upwards [h] with ω hω x
  ext j
  rw [mem_condSupportK, mem_condSupportK, hω x j]

end SelectionK

/-! ### The conditional laws of an invariant colouring (FS131-ICO1's helpers: `Rigidity/TraceSplit` at `Fin k`) -/

-- FS131-ICO1: the shifts form an action fixing `0`.
private theorem colourShiftK_zero : colourShiftK (F := F) (k := k) 0 = id := by
  funext c x
  simp [colourShiftK]

-- FS131-ICO1: **the conditional laws move with the shifts**: `p_j(x) ∘ shift_y = p_j(x + y)` almost surely.
private theorem condLawK_comp_colourShiftK [NumberField F] (μ : InvColouring F k) (x y : unitRing F) (j : Fin k) :
    condLawK (factorK μ) μ.μ (fun c => c) x j ∘ colourShiftK y =ᵐ[μ.μ]
      condLawK (factorK μ) μ.μ (fun c => c) (x + y) j := by
  have hS𝒜 : (factorK μ).comap (colourShiftK y) = factorK μ :=
    comap_factorSigma_eq_of_action colourShiftK μ.measurePreserving_shift colourShiftK_add colourShiftK_zero _ y
  have h := condExp_comp_measurePreserving (factorK μ) μ.μ (factorSigma_le _ _ _) (μ.measurePreserving_shift y)
    hS𝒜 (integrable_colourIndicatorK μ.μ (fun c => c) (fun x => measurable_pi_apply x) x j)
  have e : (Set.indicator {ω' : unitRing F → Fin k | ω' x = j} fun _ => (1 : ℝ)) ∘ colourShiftK y =
      Set.indicator {ω' | ω' (x + y) = j} fun _ => (1 : ℝ) := by
    funext ω
    by_cases hω : ω (x + y) = j <;> simp [colourShiftK, Set.indicator, hω]
  rw [e] at h
  exact h

-- FS131-ICO1: **a proper colouring repeats no colour across a unit vector**: `⟨e_j, V_u e_j⟩ = 0`.
private theorem inner_colourIndK_comp_unit (μ : InvColouring F k) (u : unitVectors F) (j : Fin k) :
    ∫ c, colourIndK μ.μ (fun c => c 0) (measurable_pi_apply 0) j c *
        Lp.compMeasurePreserving (colourShiftK (uvRing u)) (μ.measurePreserving_shift (uvRing u))
          (colourIndK μ.μ (fun c => c 0) (measurable_pi_apply 0) j) c ∂μ.μ = 0 := by
  refine (integral_colourIndK_mul_comp μ.μ colourShiftK μ.measurePreserving_shift (fun c => c)
    (fun x => measurable_pi_apply x) (fun y => Eventually.of_forall fun c => shift_equiv_id y c) (uvRing u) j).trans ?_
  have hsub : {c : unitRing F → Fin k | c 0 = j ∧ c (uvRing u) = j} ⊆ (Xk F k)ᶜ := by
    rintro c ⟨h0, hu⟩ hX
    exact hX 0 (uvRing u) (by simp [uvRing]) (h0.trans hu.symm)
  rw [measureReal_def, measure_mono_null hsub μ.carried, ENNReal.toReal_zero]

-- FS131-ICO1: **`Πe_j`**, the continuous part of a colour indicator.
private def colourCondK [NumberField F] (μ : InvColouring F k) (j : Fin k) : Lp ℝ 2 μ.μ :=
  condExpL2 ℝ ℝ (factorSigma_le _ μ.measurePreserving_shift (@nhds _ (tauPrime F) 0))
    (colourIndK μ.μ (fun c => c 0) (measurable_pi_apply 0) j)

private theorem colourCondK_ae_eq_condLawK [NumberField F] (μ : InvColouring F k) (j : Fin k) :
    (colourCondK μ j : (unitRing F → Fin k) → ℝ) =ᵐ[μ.μ] condLawK (factorK μ) μ.μ (fun c => c) 0 j :=
  MemLp.condExpL2_ae_eq_condExp (𝕜 := ℝ) (factorSigma_le _ μ.measurePreserving_shift _)
    (memLp_indicator_const 2 ((measurable_pi_apply 0) (measurableSet_singleton j)) (1 : ℝ) (Or.inr (measure_ne_top _ _)))

-- FS131-ICO1: `⟨Πe_j, V_y Πe_j⟩ = E[p_j(0) p_j(y)]`.
private theorem integral_colourCondK_mul_comp [NumberField F] (μ : InvColouring F k) (y : unitRing F) (j : Fin k) :
    ∫ c, colourCondK μ j c * Lp.compMeasurePreserving (colourShiftK y) (μ.measurePreserving_shift y)
        (colourCondK μ j) c ∂μ.μ =
      ∫ c, condLawK (factorK μ) μ.μ (fun c => c) 0 j c * condLawK (factorK μ) μ.μ (fun c => c) y j c ∂μ.μ := by
  have h5 := colourCondK_ae_eq_condLawK μ j
  have h2 := Lp.coeFn_compMeasurePreserving (colourCondK μ j) (μ.measurePreserving_shift y)
  have h3 := h5.comp_tendsto (μ.measurePreserving_shift y).quasiMeasurePreserving.tendsto_ae
  have h4 := condLawK_comp_colourShiftK μ 0 y j
  rw [zero_add] at h4
  refine integral_congr_ae ?_
  filter_upwards [h5, h2, h3, h4] with c e5 e2 e3 e4
  rw [e2, e3, e5, e4]

/-! ## SI-3 at `T + A`, and the factor colouring -/

/-- **SI-3 at `T + A`, at `k` colours** (the four-colour `Rigidity.setIntegral_compl_TA_re` on the colour spectral measure):
`∫_{R̂∖(T+A)} Re χ(u) dσ = −Σ_j E[p_j(0) p_j(u)]`. Route: `σ = Σ_j σ_{e_j}`, and off `T + A` each `σ_{e_j}` is the spectral
measure of `e_j − E[e_j | 𝒜]` (`Rigidity.isSpectralMeasureOf_condExpL2` at `tauPrime F`, whose continuous characters are
`T + A`); its coefficient at `u` is `⟨e_j, V_u e_j⟩ − ⟨Πe_j, V_u Πe_j⟩ = 0 − E[p_j(0) p_j(u)]`. -/
theorem setIntegral_compl_TA_re_k [NumberField F] (μ : InvColouring F k) {σ : Measure (Dual F)}
    (hσ : IsColourSpectral μ.μ σ) (u : unitVectors F) :
    ∫ χ in (TA F)ᶜ, (χ (uvRing u) : ℂ).re ∂σ =
      -∑ j : Fin k, ∫ c, condLawK (factorK μ) μ.μ (fun c => c) 0 j c *
        condLawK (factorK μ) μ.μ (fun c => c) (uvRing u) j c ∂μ.μ := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  haveI := hσ.1
  have hex : ∀ j : Fin k, ∃ σj : Measure (Dual F), IsSpectralMeasureOf colourShiftK μ.measurePreserving_shift
      (colourIndK μ.μ (fun c => c 0) (measurable_pi_apply 0) j) σj := fun j =>
    exists_isSpectralMeasureOf colourShiftK μ.measurePreserving_shift colourShiftK_add _
  choose σc hσc using hex
  haveI : ∀ j, IsFiniteMeasure (σc j) := fun j => (hσc j).1
  -- `σ = Σ_j σ_{e_j}`
  have H : σ = ∑ j, σc j := colour_decomp μ.μ colourShiftK μ.measurePreserving_shift (fun c => c)
    (fun x => measurable_pi_apply x) (fun y => Eventually.of_forall fun c => shift_equiv_id y c) hσ.2 hσc
  have hA : MeasurableSet (TA F) := measurableSet_TA F
  have hτ : MeasurableSet (contChars (tauPrime F)) := by
    rw [contChars_tauPrime]
    exact hA
  have hsum : σ.restrict (TA F)ᶜ = ∑ j, (σc j).restrict (TA F)ᶜ := by
    rw [H, ← Measure.restrictₗ_apply, map_sum]
    simp only [Measure.restrictₗ_apply]
  -- each `∫_{(T+A)ᶜ} χ(u) dσ_j` is `⟨e_j, V_u e_j⟩ − ⟨Πe_j, V_u Πe_j⟩ = −E[p_j(0) p_j(u)]`
  have hj : ∀ j, ∫ χ in (TA F)ᶜ, ((χ (uvRing u) : Circle) : ℂ) ∂(σc j) =
      -((∫ c, condLawK (factorK μ) μ.μ (fun c => c) 0 j c *
        condLawK (factorK μ) μ.μ (fun c => c) (uvRing u) j c ∂μ.μ : ℝ) : ℂ) := by
    intro j
    have hsplit := integral_add_compl hA (integrable_evalChar (σc j) (uvRing u))
    have htot : ∫ χ, ((χ (uvRing u) : Circle) : ℂ) ∂(σc j) = 0 := by
      rw [(hσc j).2 (uvRing u), inner_colourIndK_comp_unit μ u j, Complex.ofReal_zero]
    have hpart := (isSpectralMeasureOf_condExpL2 (tauPrime F) (isTopologicalAddGroup_tauPrime F)
      (isCountablyGenerated_nhds_tauPrime F) (bochnerOn_tauPrime F) hτ colourShiftK μ.measurePreserving_shift
      colourShiftK_add (hσc j)).1
    rw [contChars_tauPrime] at hpart
    have hTA : ∫ χ in TA F, ((χ (uvRing u) : Circle) : ℂ) ∂(σc j) =
        ((∫ c, condLawK (factorK μ) μ.μ (fun c => c) 0 j c *
          condLawK (factorK μ) μ.μ (fun c => c) (uvRing u) j c ∂μ.μ : ℝ) : ℂ) := by
      rw [hpart.2 (uvRing u)]
      exact congrArg _ (integral_colourCondK_mul_comp μ (uvRing u) j)
    rw [htot, hTA] at hsplit
    linear_combination hsplit
  have hX : ∫ χ in (TA F)ᶜ, ((χ (uvRing u) : Circle) : ℂ) ∂σ =
      (((-∑ j : Fin k, ∫ c, condLawK (factorK μ) μ.μ (fun c => c) 0 j c *
        condLawK (factorK μ) μ.μ (fun c => c) (uvRing u) j c ∂μ.μ) : ℝ) : ℂ) := by
    rw [hsum, integral_finsetSum_measure fun j _ => integrable_evalChar _ (uvRing u),
      Finset.sum_congr rfl fun j _ => hj j]
    push_cast
    rw [Finset.sum_neg_distrib]
  have hre := integral_re (𝕜 := ℂ) (integrable_evalChar (σ.restrict (TA F)ᶜ) (uvRing u))
  simp only [RCLike.re_to_complex] at hre
  rw [hre, hX, Complex.ofReal_re]

/-- Each term of SI-3 is non-negative (`E[p_j(0) p_j(y)] ≥ 0`: the conditional laws are). -/
theorem integral_condLawK_mul_nonneg [NumberField F] (μ : InvColouring F k) (x y : unitRing F) (j : Fin k) :
    0 ≤ ∫ c, condLawK (factorK μ) μ.μ (fun c => c) x j c * condLawK (factorK μ) μ.μ (fun c => c) y j c ∂μ.μ := by
  refine integral_nonneg_of_ae ?_
  filter_upwards [condLawK_nonneg (factorK μ) μ.μ (fun c => c) x j,
    condLawK_nonneg (factorK μ) μ.μ (fun c => c) y j] with c h1 h2
  exact mul_nonneg h1 h2

/-- **Remark (ii)**: the integral off `T + A` is the same at every unit vector (`σ` and `T + A` are rotation-invariant). -/
theorem setIntegral_compl_TA_rot_k [NumberField F] (μ : InvColouring F k) {σ : Measure (Dual F)}
    (hσ : IsColourSpectral μ.μ σ) (u : unitVectors F) :
    ∫ χ in (TA F)ᶜ, (χ (uvRing u) : ℂ).re ∂σ = ∫ χ in (TA F)ᶜ, (χ 1 : ℂ).re ∂σ := by
  have hrot : σ.map (rot u) = σ := hσ.rotInv μ u
  have hA : MeasurableSet (TA F)ᶜ := (measurableSet_TA F).compl
  have hm : Measurable fun χ : Dual F => (χ 1 : ℂ).re := Complex.measurable_re.comp (measurable_evalChar 1)
  conv_rhs => rw [← hrot]
  rw [setIntegral_map hA hm.aestronglyMeasurable (measurable_rot u).aemeasurable, Set.preimage_compl,
    rot_preimage_TA]
  simp only [rot_apply, mul_one]

/-- **The conditional laws are orthogonal across every unit vector** — the hypothesis of the factor colouring. -/
def EqualAtUnitsK [NumberField F] (μ : InvColouring F k) : Prop :=
  ∀ (u : unitVectors F) (j : Fin k), ∫ c, condLawK (factorK μ) μ.μ (fun c => c) 0 j c *
    condLawK (factorK μ) μ.μ (fun c => c) (uvRing u) j c ∂μ.μ = 0

/-- **If the integral off `T + A` is not negative, the conditional laws are orthogonal across every edge** (SI-3, remark (ii)
and the non-negative terms; the four-colour `Rigidity.equalAtUnits_of_not_neg`). -/
theorem equalAtUnitsK_of_not_neg [NumberField F] (μ : InvColouring F k) {σ : Measure (Dual F)}
    (hσ : IsColourSpectral μ.μ σ) (h : ¬ ∫ χ in (TA F)ᶜ, (χ 1 : ℂ).re ∂σ < 0) : EqualAtUnitsK μ := by
  intro u j
  have h1 : 0 ≤ ∫ χ in (TA F)ᶜ, (χ 1 : ℂ).re ∂σ := not_lt.mp h
  have hnn : 0 ≤ ∑ i : Fin k, ∫ c, condLawK (factorK μ) μ.μ (fun c => c) 0 i c *
      condLawK (factorK μ) μ.μ (fun c => c) (uvRing u) i c ∂μ.μ :=
    Finset.sum_nonneg fun i _ => integral_condLawK_mul_nonneg μ 0 (uvRing u) i
  have h0 : ∫ χ in (TA F)ᶜ, (χ (uvRing u) : ℂ).re ∂σ = 0 := by
    refine le_antisymm ?_ (by rw [setIntegral_compl_TA_rot_k μ hσ u]; exact h1)
    rw [setIntegral_compl_TA_re_k μ hσ u]
    linarith
  rw [setIntegral_compl_TA_re_k μ hσ u] at h0
  have hsum : ∑ i : Fin k, ∫ c, condLawK (factorK μ) μ.μ (fun c => c) 0 i c *
      condLawK (factorK μ) μ.μ (fun c => c) (uvRing u) i c ∂μ.μ = 0 := by
    linarith
  exact (Finset.sum_eq_zero_iff_of_nonneg fun i _ => integral_condLawK_mul_nonneg μ 0 (uvRing u) i).mp hsum j
    (Finset.mem_univ j)

/-! ### The factor colouring at `k` colours (FS131-ICO1's helpers: `Rigidity/APlus` at `Fin k`) -/

-- FS131-ICO1: **the rotation of a `k`-colouring** by a unit vector: `c ↦ c(u ·)`.
private def colourRotK (u : unitVectors F) (c : unitRing F → Fin k) : unitRing F → Fin k := fun x => c (uvRing u * x)

private theorem measurable_colourRotK (u : unitVectors F) : Measurable (colourRotK (k := k) u) :=
  measurable_pi_lambda _ fun _ => measurable_pi_apply _

private theorem InvColouring.measurePreserving_rotK (μ : InvColouring F k) (u : unitVectors F) :
    MeasurePreserving (colourRotK u) μ.μ μ.μ :=
  ⟨measurable_colourRotK u, μ.rot_inv u⟩

-- FS131-ICO1: the conjugate of a unit vector, as a unit vector (`Rigidity/APlus`'s private `conjUV`).
private def conjUVK (u : unitVectors F) : unitVectors F :=
  ⟨starRingEnd ℂ u, UnitRing.conj_mem_planeOver u.2.1, by rw [Complex.norm_conj]; exact u.2.2⟩

private theorem uvRing_mul_conjUVK (u : unitVectors F) (y : unitRing F) : uvRing u * (uvRing (conjUVK u) * y) = y := by
  have h1 : (u : ℂ) * starRingEnd ℂ u = 1 := by
    rw [Complex.mul_conj', u.2.2]
    simp
  apply Subtype.ext
  change (u : ℂ) * (starRingEnd ℂ u * y) = y
  rw [← mul_assoc, h1, one_mul]

-- FS131-ICO1: the rotated preimage of an event of `𝒜` is an event of `𝒜`.
private theorem colourRotK_preimage_mem [NumberField F] (μ : InvColouring F k) (u : unitVectors F)
    {A : Set (unitRing F → Fin k)} (hA : MeasurableSet[factorK μ] A) :
    MeasurableSet[factorK μ] (colourRotK u ⁻¹' A) := by
  rw [measurableSet_factorSigma_iff] at hA ⊢
  obtain ⟨hAm, h⟩ := (mem_factorSets_iff colourShiftK μ.measurePreserving_shift _).mp hA
  refine (mem_factorSets_iff colourShiftK μ.measurePreserving_shift _).mpr ⟨hAm.preimage (measurable_colourRotK u), ?_⟩
  have key : ∀ y, μ.μ (symmDiff (colourShiftK y ⁻¹' (colourRotK u ⁻¹' A)) (colourRotK u ⁻¹' A)) =
      μ.μ (symmDiff (colourShiftK (uvRing (conjUVK u) * y) ⁻¹' A) A) := by
    intro y
    have e1 : colourShiftK y ⁻¹' (colourRotK u ⁻¹' A) =
        colourRotK u ⁻¹' (colourShiftK (uvRing (conjUVK u) * y) ⁻¹' A) := by
      have e : ∀ c : unitRing F → Fin k,
          colourRotK u (colourShiftK y c) = colourShiftK (uvRing (conjUVK u) * y) (colourRotK u c) := by
        intro c
        funext x
        simp only [colourRotK, colourShiftK]
        rw [mul_add, uvRing_mul_conjUVK]
      ext c
      simp only [Set.mem_preimage, e]
    rw [e1, ← Set.preimage_symmDiff, (μ.measurePreserving_rotK u).measure_preimage
      ((hAm.preimage (measurable_colourShiftK _)).symmDiff hAm).nullMeasurableSet]
  simp only [key]
  exact h.comp (tendsto_mul_nhds_tauPrime (uvRing (conjUVK u)))

-- FS131-ICO1: **`𝒜` is rotation-invariant** (`Rigidity.comap_colourRot_colourFactor` at `Fin k`).
private theorem comap_colourRotK_factorK [NumberField F] (μ : InvColouring F k) (u : unitVectors F) :
    (factorK μ).comap (colourRotK u) = factorK μ := by
  apply le_antisymm
  · intro s hs
    obtain ⟨A, hA, rfl⟩ := MeasurableSpace.measurableSet_comap.mp hs
    exact colourRotK_preimage_mem μ u hA
  · intro B hB
    refine MeasurableSpace.measurableSet_comap.mpr ⟨colourRotK (conjUVK u) ⁻¹' B,
      colourRotK_preimage_mem μ (conjUVK u) hB, ?_⟩
    have e : ∀ c : unitRing F → Fin k, colourRotK (conjUVK u) (colourRotK u c) = c := by
      intro c
      funext x
      simp only [colourRotK]
      rw [uvRing_mul_conjUVK]
    ext c
    simp only [Set.mem_preimage, e]

-- FS131-ICO1: the least element of a set of colours, `0` for the empty set.
private def minSelK [NeZero k] (s : Finset (Fin k)) : Fin k := if h : s.Nonempty then s.min' h else 0

private theorem minSelK_mem [NeZero k] {s : Finset (Fin k)} (h : s.Nonempty) : minSelK s ∈ s := by
  rw [minSelK, dif_pos h]
  exact Finset.min'_mem s h

-- FS131-ICO1: **SI-4's selection** `c′ = min ∘ M` at `k` colours.
private def factorColouringK [NumberField F] [NeZero k] (μ : InvColouring F k) (c : unitRing F → Fin k) :
    unitRing F → Fin k :=
  fun x => minSelK (condSupportK (factorK μ) μ.μ (fun c => c) c x)

private theorem measurable_factorColouringK_apply [NumberField F] [NeZero k] (μ : InvColouring F k) (x : unitRing F) :
    Measurable[factorK μ] fun c => factorColouringK μ c x :=
  measurable_selectionK (factorK μ) μ.μ (fun c => c) minSelK x

private theorem measurable_factorColouringK [NumberField F] [NeZero k] (μ : InvColouring F k) :
    Measurable (factorColouringK μ) :=
  measurable_pi_lambda _ fun x =>
    (measurable_factorColouringK_apply μ x).mono (factorSigma_le _ μ.measurePreserving_shift _) le_rfl

private theorem factorColouringK_shift_ae [NumberField F] [NeZero k] (μ : InvColouring F k) (y : unitRing F) :
    ∀ᵐ c ∂μ.μ, factorColouringK μ (colourShiftK y c) = colourShiftK y (factorColouringK μ c) := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  have hS𝒜 : (factorK μ).comap (colourShiftK y) = factorK μ :=
    comap_factorSigma_eq_of_action colourShiftK μ.measurePreserving_shift colourShiftK_add colourShiftK_zero _ y
  have h := si4_equivariantK (factorK μ) μ.μ (fun c => c) (factorSigma_le _ _ _) (fun x => measurable_pi_apply x)
    (μ.measurePreserving_shift y) hS𝒜 (fun x => x + y) (fun ω x => rfl)
  filter_upwards [h] with c hc
  funext x
  show minSelK (condSupportK (factorK μ) μ.μ (fun c => c) (colourShiftK y c) x) =
    minSelK (condSupportK (factorK μ) μ.μ (fun c => c) c (x + y))
  rw [hc x]

private theorem factorColouringK_rot_ae [NumberField F] [NeZero k] (μ : InvColouring F k) (u : unitVectors F) :
    ∀ᵐ c ∂μ.μ, factorColouringK μ (colourRotK u c) = colourRotK u (factorColouringK μ c) := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  have h := si4_equivariantK (factorK μ) μ.μ (fun c => c) (factorSigma_le _ _ _) (fun x => measurable_pi_apply x)
    (μ.measurePreserving_rotK u) (comap_colourRotK_factorK μ u) (fun x => uvRing u * x) (fun ω x => rfl)
  filter_upwards [h] with c hc
  funext x
  show minSelK (condSupportK (factorK μ) μ.μ (fun c => c) (colourRotK u c) x) =
    minSelK (condSupportK (factorK μ) μ.μ (fun c => c) c (uvRing u * x))
  rw [hc x]

-- FS131-ICO1: **disjoint supports across every edge**, from equality at the unit vectors (shift invariance).
private theorem integral_condLawK_mul_eq_zero_of_adj [NumberField F] (μ : InvColouring F k) (h : EqualAtUnitsK μ)
    {x y : unitRing F} (hxy : (y : ℂ) - x ∈ unitVectors F) (j : Fin k) :
    ∫ c, condLawK (factorK μ) μ.μ (fun c => c) x j c * condLawK (factorK μ) μ.μ (fun c => c) y j c ∂μ.μ = 0 := by
  let u : unitVectors F := ⟨(y : ℂ) - x, hxy⟩
  have hu : uvRing u = y - x := Subtype.ext (by simp [uvRing, u])
  have h0 := h u j
  rw [hu] at h0
  have e1 := condLawK_comp_colourShiftK μ 0 x j
  have e2 := condLawK_comp_colourShiftK μ (y - x) x j
  rw [zero_add] at e1
  rw [sub_add_cancel] at e2
  have hS := μ.measurePreserving_shift x
  have hm : ∀ z, Measurable (condLawK (factorK μ) μ.μ (fun c => c) z j) := fun z =>
    (measurable_condLawK (factorK μ) μ.μ (fun c => c) z j).mono (factorSigma_le _ _ _) le_rfl
  have hg : Measurable fun c => condLawK (factorK μ) μ.μ (fun c => c) 0 j c *
      condLawK (factorK μ) μ.μ (fun c => c) (y - x) j c := (hm 0).mul (hm (y - x))
  have hmap := integral_map (μ := μ.μ) hS.measurable.aemeasurable hg.aestronglyMeasurable
  rw [hS.map_eq] at hmap
  rw [← h0, hmap]
  refine integral_congr_ae ?_
  filter_upwards [e1, e2] with c h1 h2
  rw [← h1, ← h2]
  rfl

-- FS131-ICO1: **the law of the factor colouring** is an invariant colouring, when SI-3 is an equality at every unit vector.
private def factorLawK [NumberField F] [NeZero k] (μ : InvColouring F k) (h : EqualAtUnitsK μ) : InvColouring F k where
  μ := μ.μ.map (factorColouringK μ)
  isProb := Measure.isProbabilityMeasure_map (measurable_factorColouringK μ).aemeasurable
  carried := by
    haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
    haveI : Countable (unitRing F) := countable_unitRing
    rw [Measure.map_apply (measurable_factorColouringK μ) measurableSet_Xk.compl]
    refine measure_eq_zero_iff_ae_notMem.mpr ?_
    have h4 := si4K (V := unitRing F) (factorK μ) μ.μ (fun c => c) (factorSigma_le _ _ _)
      (fun x => measurable_pi_apply x) (fun x y => (y : ℂ) - x ∈ unitVectors F)
      (fun x y hxy j => integral_condLawK_mul_eq_zero_of_adj μ h hxy j) minSelK (fun s hs => minSelK_mem hs)
    filter_upwards [h4] with c hc hcX
    exact hcX fun x y hxy => hc x y hxy
  shift_inv y := by
    have hae : (fun (c : unitRing F → Fin k) x => c (x + y)) ∘ factorColouringK μ =ᵐ[μ.μ]
        factorColouringK μ ∘ colourShiftK y := by
      filter_upwards [factorColouringK_shift_ae μ y] with c hc
      exact hc.symm
    rw [Measure.map_map (g := fun (c : unitRing F → Fin k) x => c (x + y)) (measurable_colourShiftK y)
      (measurable_factorColouringK μ), Measure.map_congr hae,
      ← Measure.map_map (measurable_factorColouringK μ) (measurable_colourShiftK y)]
    exact congrArg (Measure.map (factorColouringK μ)) (μ.shift_inv y)
  rot_inv u := by
    have hae : (fun (c : unitRing F → Fin k) x => c (uvRing u * x)) ∘ factorColouringK μ =ᵐ[μ.μ]
        factorColouringK μ ∘ colourRotK u := by
      filter_upwards [factorColouringK_rot_ae μ u] with c hc
      exact hc.symm
    rw [Measure.map_map (g := fun (c : unitRing F → Fin k) x => c (uvRing u * x)) (measurable_colourRotK u)
      (measurable_factorColouringK μ), Measure.map_congr hae,
      ← Measure.map_map (measurable_factorColouringK μ) (measurable_colourRotK u)]
    exact congrArg (Measure.map (factorColouringK μ)) (μ.rot_inv u)

-- FS131-ICO1: **the factor colouring's colour spectral measures are carried by `T + A`**: `σ′ = Σ_j σ_{e″_j}`
-- (`colour_decomp` at `κ = c′`), each `e″_j = 1{c′(0) = j}` is `𝒜`-measurable, so `τ′_∅`-continuous, so its spectral
-- measure is carried by `contChars (tauPrime F) = T + A`.
private theorem factorLawK_spectral_null [NumberField F] [NeZero k] (μ : InvColouring F k) {σ' : Measure (Dual F)}
    (hσ' : IsColourSpectral (μ.μ.map (factorColouringK μ)) σ') : σ' (TA F)ᶜ = 0 := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  haveI := hσ'.1
  have hκ : ∀ x, Measurable fun c => factorColouringK μ c x := fun x =>
    (measurable_factorColouringK_apply μ x).mono (factorSigma_le _ _ _) le_rfl
  have hequiv : ∀ y, ∀ᵐ c ∂μ.μ, factorColouringK μ (colourShiftK y c) 0 = factorColouringK μ c y := by
    intro y
    filter_upwards [factorColouringK_shift_ae μ y] with c hc
    rw [hc]
    simp [colourShiftK]
  have hex : ∀ j : Fin k, ∃ σj : Measure (Dual F), IsSpectralMeasureOf colourShiftK μ.measurePreserving_shift
      (colourIndK μ.μ (fun c => factorColouringK μ c 0) (hκ 0) j) σj := fun j =>
    exists_isSpectralMeasureOf colourShiftK μ.measurePreserving_shift colourShiftK_add _
  choose σc hσc using hex
  have hcoef : ∀ y, ∫ χ, (χ y : ℂ) ∂σ' =
      ((μ.μ.real {c | factorColouringK μ c 0 = factorColouringK μ c y} : ℝ) : ℂ) := by
    intro y
    rw [hσ'.2 y, measureReal_def, measureReal_def, Measure.map_apply (measurable_factorColouringK μ)
      (measurableSet_eq_fun (measurable_pi_apply 0) (measurable_pi_apply y))]
    rfl
  have H := colour_decomp μ.μ colourShiftK μ.measurePreserving_shift (factorColouringK μ) hκ hequiv hcoef hσc
  have hnull : ∀ j, σc j (TA F)ᶜ = 0 := by
    intro j
    have hmem : colourIndK μ.μ (fun c => factorColouringK μ c 0) (hκ 0) j ∈
        contVec colourShiftK μ.measurePreserving_shift (@nhds _ (tauPrime F) 0) := by
      rw [contVec_eq_lpMeas]
      exact mem_lpMeas_indicatorConstLp (factorSigma_le _ _ _)
        ((measurable_factorColouringK_apply μ 0) (measurableSet_singleton j)) (measure_ne_top _ _)
    have h := (spectral_carried_iff (tauPrime F) (isTopologicalAddGroup_tauPrime F)
      (isCountablyGenerated_nhds_tauPrime F) (bochnerOn_tauPrime F) colourShiftK μ.measurePreserving_shift
      colourShiftK_add (hσc j)).mpr hmem
    rwa [contChars_tauPrime] at h
  rw [H, Measure.finsetSum_apply]
  exact Finset.sum_eq_zero fun j _ => hnull j

/-- **The factor colouring** (SI-4 and `APlus`'s factor at `Fin k`): when the conditional laws are orthogonal across every
edge, the least colour of the conditional support, `c′ = min ∘ M`, is `𝒜`-measurable, almost surely proper and equivariant;
its law is an invariant colouring, and its colour spectral measures are carried by `T + A` (each `1{c′(0) = j}` is
`𝒜`-measurable, so its spectral measure is, `Rigidity.spectral_carried_iff`). -/
theorem exists_factorLawK [NumberField F] (μ : InvColouring F k) (h : EqualAtUnitsK μ) :
    ∃ μ' : InvColouring F k, ∀ σ' : Measure (Dual F), IsColourSpectral μ'.μ σ' → σ' (TA F)ᶜ = 0 := by
  -- at `k = 0` there is no colouring of the non-empty `R`, so no probability on them
  rcases Nat.eq_zero_or_pos k with hk | hk
  · subst hk
    exfalso
    have hempty : (Set.univ : Set (unitRing F → Fin 0)) = ∅ :=
      Set.eq_empty_of_forall_notMem fun c _ => (c 0).elim0
    have h1 := μ.isProb.measure_univ
    rw [hempty, measure_empty] at h1
    exact zero_ne_one h1
  haveI : NeZero k := ⟨hk.ne'⟩
  exact ⟨factorLawK μ h, fun σ' hσ' => factorLawK_spectral_null μ hσ'⟩

/-- **Case (B) is empty: an invariant `k`-colouring has a sibling with its spectrum on `T + A`** — over every real number
field. If `∫_{R̂∖(T+A)} Re χ(1) dσ < 0`, then `σ|_{R̂∖(T+A)}` is an SP witness at `E = T + A` (finite, rotation-invariant,
`(T + A)`-null by construction — no R-U), which MR⁺ excludes; otherwise the factor colouring. -/
theorem exists_invColouring_TA [NumberField F] (μ : InvColouring F k) :
    ∃ μ' : InvColouring F k, ∀ σ' : Measure (Dual F), IsColourSpectral μ'.μ σ' → σ' (TA F)ᶜ = 0 := by
  obtain ⟨σ, hσ⟩ := exists_isColourSpectral μ
  haveI := hσ.1
  by_cases hneg : ∫ χ in (TA F)ᶜ, (χ 1 : ℂ).re ∂σ < 0
  · exfalso
    refine not_isSPWitness (F := F) subset_rfl (σ.restrict (TA F)ᶜ) ⟨inferInstance, rotInv_restrict_compl_TA
      (hσ.rotInv μ), ?_, hneg⟩
    rw [Measure.restrict_apply (measurableSet_TA F), Set.inter_compl_self, measure_empty]
  · exact exists_factorLawK μ (equalAtUnitsK_of_not_neg μ hσ hneg)

/-! ## Spec -/

-- the shift moves the colouring by `+ y` at every point.
example (y x : unitRing F) (c : unitRing F → Fin k) : colourShiftK y c x = c (x + y) := rfl

-- the witness's four clauses, in D-SP's order.
example (E : Set (Dual F)) (τ : MeasureTheory.Measure (Dual F)) :
    IsSPWitness F E τ ↔ IsFiniteMeasure τ ∧ RotInv F τ ∧ τ E = 0 ∧ ∫ χ, ((χ 1 : Circle) : ℂ).re ∂τ < 0 := Iff.rfl

end

end HadwigerNelson.Collapse
