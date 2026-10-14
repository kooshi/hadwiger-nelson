import Proofs.HadwigerNelson.Rigidity.SpectralSubspace
import Proofs.HadwigerNelson.Rigidity.BochnerTau
import Proofs.HadwigerNelson.Arith.FactorAction

/-!
# SI-1 and SI-3 at `T + A`: the trace measure of an invariant colouring off `T + A` (FS-131, job FS131-KM11; module M11b; skeleton)

**Read aloud, against the informal claim.** For a real number field `F`, an invariant random proper four-colouring `μ` of
`Cay(R, U)` (`R = ℤ[U_F]`) and a trace spectral measure `σ` of it, J45's Lemma SI-3 at `S = ∅`
(`plans/FS84-SI-D-derivation.md` ll. 153–157) reads

  `∫_{R̂ ∖ (T + A)} Re χ(u) dσ = −(4/3) Σ_j E[p_j(0) p_j(u)]` for every `u ∈ U` (`setIntegral_compl_TA_re`),

where `p_j(x) = P(c(x) = j | 𝒜)` is the conditional law of the colour at `x` given the factor `𝒜` of the `τ′_∅`-continuous
vectors (`colourFactor`; `SpectralInputs.condLaw`). Each `E[p_j(0) p_j(u)]` is `≥ 0`, so the integral is `≤ 0`; and it is
the same at every unit vector (`setIntegral_compl_TA_rot`, remark (ii): `σ` and `T + A` are rotation-invariant).

**Route (FS131-KM11 § 1.4, finding 1: colour indicators, not tetrahedral coordinates).** With `e_j = 1{c(0) = j}` and
`tetra i j = (4/3)[i = j] − 1/3`, `Σ_j e_j = 1` gives `corr(y) = (4/3) Σ_j ⟨e_j, V_y e_j⟩ − 1/3`, so by Fourier uniqueness
`3σ + δ₁ = 4 Σ_j σ_{e_j}` (`trace_decomp`, for any equivariant random colouring `κ` on any probability space with a shift
action — `SpectralInputs`' `factorColouring` uses it again in `Rigidity/APlus`). Split each `e_j = Πe_j + (e_j − Πe_j)` with
`Π = E[· | 𝒜]` (`isSpectralMeasureOf_condExpL2` at `t = τ′_∅`: `σ_{e_j}` on `T + A` is `σ_{Πe_j}`, off it `σ_{e_j − Πe_j}`).
Off `T + A`, `3σ = 4 Σ_j σ_{e_j − Πe_j}` (`1 ∈ T + A`), whose coefficient at `u` is `⟨e_j, V_u e_j⟩ − ⟨Πe_j, V_u Πe_j⟩`; the
first is `μ(c(0) = j = c(u)) = 0` (`inner_colourInd_comp_unit`: the colouring is proper) and the second is
`E[p_j(0) p_j(u)]` (`integral_colourCond_mul_comp`: `Πe_j = p_j(0)` and `p_j(0) ∘ shift_u = p_j(u)`,
`condLaw_comp_colourShift`).

**Reads** M10 (`contChars_tauPrime`, `isTopologicalAddGroup_tauPrime`, `isCountablyGenerated_nhds_tauPrime`), M2b
(`bochnerOn_tauPrime`), M2a and M4 (`bochnerHerglotz_of_countable`, `measure_eq_of_fourier`), and module M11a
(`Rigidity/SpectralSubspace`).

**Models.** Every statement is about every real number field and every invariant colouring with a trace measure; such a
pair exists at `F = ℚ` (`Rigidity.APlus.aplus_model`, over M3), whose plane is two-colourable.
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory SpectralChain SpectralInputs Filter Topology NumberField

noncomputable section

variable {F : Subfield ℝ}

/-! ### The shift action on colourings -/

/-- **The shift of a colouring** by `y ∈ R`: `c ↦ c(· + y)`, the map `InvariantColouring.shift_inv` is about. -/
def colourShift (y : unitRing F) (c : unitRing F → Fin 4) : unitRing F → Fin 4 := fun x => c (x + y)

theorem measurable_colourShift (y : unitRing F) : Measurable (colourShift y) :=
  measurable_pi_lambda _ fun _ => measurable_pi_apply _

/-- The shifts are an action of `R`: `shift_{x + y} = shift_x ∘ shift_y`. -/
theorem colourShift_add (x y : unitRing F) : colourShift (x + y) = colourShift x ∘ colourShift y := by
  funext c z
  simp only [colourShift, Function.comp_apply, add_assoc]

theorem colourShift_zero : colourShift (0 : unitRing F) = id := by
  funext c z
  simp only [colourShift, add_zero, id_eq]

/- The law of an invariant colouring is a probability measure: the structure's own field `isProb`, made a scoped instance
(namespace `HadwigerNelson.Rigidity`) rather than restated, so that no second declaration of it can exist. -/
attribute [scoped instance] InvariantColouring.isProb

/-- Each shift preserves the law of an invariant colouring. -/
theorem _root_.HadwigerNelson.SpectralChain.InvariantColouring.measurePreserving_shift (μ : InvariantColouring F) (y : unitRing F) :
    MeasurePreserving (colourShift y) μ.μ μ.μ :=
  ⟨measurable_colourShift y, μ.shift_inv y⟩

/-- **`𝒜`, the factor of the `τ′_∅`-continuous vectors** of an invariant colouring: J45's `𝒜_∅`, the σ-algebra of the events
whose indicators move continuously under the shifts for the profinite-plus-archimedean topology (`SpectralInputs.factorSigma`
along `𝓝 0` for `tauPrime F`). -/
abbrev colourFactor [NumberField F] (μ : InvariantColouring F) : MeasurableSpace (unitRing F → Fin 4) :=
  factorSigma (colourShift (F := F)) μ.measurePreserving_shift (@nhds _ (tauPrime F) 0)

/-! ### The colour indicators and the trace measure -/

/-- **The colour indicator** `e_j = 1{κ₀ = j}` of a random colour `κ₀` (the colour at `0` of a random colouring), in
`L²(μ)`: the indicator of a fibre. -/
def colourInd {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω) [IsFiniteMeasure μ] (κ₀ : Ω → Fin 4)
    (hκ₀ : Measurable κ₀) (j : Fin 4) : Lp ℝ 2 μ :=
  indicatorConstLp 2 (hκ₀ (measurableSet_singleton j)) (measure_ne_top μ _) 1

/-- The tetrahedral form against the diagonal: `3 ⟨e_i, e_k⟩ + 1 = 4 [i = k]`. -/
theorem three_mul_tetra_add_one (i k : Fin 4) : 3 * tetra i k + 1 = if i = k then 4 else 0 := by
  unfold tetra
  split_ifs <;> norm_num

/-- **A colour indicator's Koopman correlation** is the probability of one colour at `0` and at `y`:
`⟨e_j, V_y e_j⟩ = μ(κ(0) = j, κ(y) = j)`, for a random colouring moved equivariantly at `0`. -/
theorem integral_colourInd_mul_comp {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω) [IsProbabilityMeasure μ]
    (T : unitRing F → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) (κ : Ω → unitRing F → Fin 4)
    (hκ : ∀ x, Measurable fun ω => κ ω x) (hequiv : ∀ y, ∀ᵐ ω ∂μ, κ (T y ω) 0 = κ ω y) (y : unitRing F) (j : Fin 4) :
    ∫ ω, colourInd μ (fun ω => κ ω 0) (hκ 0) j ω *
        Lp.compMeasurePreserving (T y) (hT y) (colourInd μ (fun ω => κ ω 0) (hκ 0) j) ω ∂μ =
      μ.real {ω | κ ω 0 = j ∧ κ ω y = j} := by
  have h1 : (colourInd μ (fun ω => κ ω 0) (hκ 0) j : Ω → ℝ) =ᵐ[μ]
      ((fun ω => κ ω 0) ⁻¹' ({j} : Set (Fin 4))).indicator fun _ => (1 : ℝ) :=
    indicatorConstLp_coeFn
  have h2 := Lp.coeFn_compMeasurePreserving (colourInd μ (fun ω => κ ω 0) (hκ 0) j) (hT y)
  have h3 := h1.comp_tendsto (hT y).quasiMeasurePreserving.tendsto_ae
  have hmeas : MeasurableSet {ω | κ ω 0 = j ∧ κ ω y = j} :=
    ((hκ 0) (measurableSet_singleton j)).inter ((hκ y) (measurableSet_singleton j))
  rw [← integral_indicator_one hmeas]
  refine integral_congr_ae ?_
  filter_upwards [h1, h2, h3, hequiv y] with ω e1 e2 e3 e4
  rw [e2, e3, e1]
  simp only [Function.comp_apply, Set.indicator_apply, Set.mem_setOf_eq, Pi.one_apply]
  by_cases ha : κ ω 0 = j <;> by_cases hb : κ ω y = j <;> simp [ha, hb, e4]

/-- `3 tetra(a, b) + 1 = 4 Σ_j [a = j ∧ b = j]`, pointwise. -/
private theorem three_mul_tetra_add_one_eq_sum (a b : Fin 4) :
    3 * tetra a b + 1 = 4 * ∑ j : Fin 4, if a = j ∧ b = j then (1 : ℝ) else 0 := by
  rw [three_mul_tetra_add_one]
  fin_cases a <;> fin_cases b <;> simp [Fin.sum_univ_four]

/-- `n • ν` is finite when `ν` is. -/
private theorem isFiniteMeasure_nsmul {X : Type*} [MeasurableSpace X] (n : ℕ) (ν : Measure X) [IsFiniteMeasure ν] :
    IsFiniteMeasure (n • ν) :=
  ⟨by rw [Measure.smul_apply, nsmul_eq_mul]; exact ENNReal.mul_lt_top (ENNReal.natCast_lt_top n) (measure_lt_top _ _)⟩

/-- The integral against `n • ν` is `n` times the integral against `ν`. -/
private theorem integral_nsmul_measure {X : Type*} [MeasurableSpace X] (ν : Measure X) (n : ℕ) (g : X → ℂ) :
    ∫ x, g x ∂(n • ν) = n * ∫ x, g x ∂ν := by
  rw [← Nat.cast_smul_eq_nsmul ENNReal n ν, integral_smul_measure, ENNReal.toReal_natCast, Complex.real_smul,
    Complex.ofReal_natCast]

/-- **The trace measure in colour indicators** (finding 1): for a random colouring `κ` on a probability space with an
action `T` of `R` that moves it equivariantly at `0` (`κ (T y ω) 0 = κ ω y` almost surely), a trace spectral measure `σ` of
its law and spectral measures `σ_j` of its colour indicators satisfy `3σ + δ₁ = 4 Σ_j σ_j`. Coefficient by coefficient:
`3 corr(y) + 1 = 4 Σ_j μ(κ(0) = j = κ(y))` (`tetra i j = (4/3)[i = j] − 1/3`); then Fourier uniqueness. -/
theorem trace_decomp [NumberField F] {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω) [IsProbabilityMeasure μ]
    (T : unitRing F → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) (κ : Ω → unitRing F → Fin 4)
    (hκ : ∀ x, Measurable fun ω => κ ω x) (hequiv : ∀ y, ∀ᵐ ω ∂μ, κ (T y ω) 0 = κ ω y)
    {σ : Measure (Dual F)} (hσ : IsTraceSpectral F (μ.map κ) σ) {σc : Fin 4 → Measure (Dual F)}
    (hσc : ∀ j, IsSpectralMeasureOf T hT (colourInd μ (fun ω => κ ω 0) (hκ 0) j) (σc j)) :
    3 • σ + Measure.dirac 1 = 4 • ∑ j, σc j := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  haveI := hσ.1
  haveI : ∀ j, IsFiniteMeasure (σc j) := fun j => (hσc j).1
  have hκm : Measurable κ := measurable_pi_lambda _ hκ
  have hcoef : ∀ y, 3 * corr F (μ.map κ) y + 1 = 4 * ∑ j, μ.real {ω | κ ω 0 = j ∧ κ ω y = j} := by
    intro y
    have hm : Measurable fun c : unitRing F → Fin 4 => tetra (c 0) (c y) :=
      Measurable.comp (g := fun p : Fin 4 × Fin 4 => tetra p.1 p.2) (f := fun c : unitRing F → Fin 4 => (c 0, c y))
        (measurable_of_countable _) ((measurable_pi_apply 0).prodMk (measurable_pi_apply y))
    have hmeas : ∀ j, MeasurableSet {ω | κ ω 0 = j ∧ κ ω y = j} := fun j =>
      ((hκ 0) (measurableSet_singleton j)).inter ((hκ y) (measurableSet_singleton j))
    have hint : Integrable (fun ω => tetra (κ ω 0) (κ ω y)) μ := by
      refine Integrable.of_bound (C := 1) (hm.comp hκm).aestronglyMeasurable (Eventually.of_forall fun ω => ?_)
      unfold tetra
      split_ifs <;> norm_num
    rw [corr, integral_map hκm.aemeasurable hm.aestronglyMeasurable]
    calc 3 * ∫ ω, tetra (κ ω 0) (κ ω y) ∂μ + 1 = ∫ ω, (3 * tetra (κ ω 0) (κ ω y) + 1) ∂μ := by
          rw [integral_add (hint.const_mul 3) (integrable_const 1), integral_const_mul, integral_const]
          simp
      _ = ∫ ω, 4 * ∑ j, {ω | κ ω 0 = j ∧ κ ω y = j}.indicator 1 ω ∂μ := by
          refine integral_congr_ae (Eventually.of_forall fun ω => ?_)
          simp only [three_mul_tetra_add_one_eq_sum, Set.indicator_apply, Set.mem_setOf_eq, Pi.one_apply]
      _ = 4 * ∑ j, μ.real {ω | κ ω 0 = j ∧ κ ω y = j} := by
          rw [integral_const_mul, integral_finsetSum]
          · exact congrArg _ (Finset.sum_congr rfl fun j _ => integral_indicator_one (hmeas j))
          · exact fun j _ => (integrable_const (1 : ℝ)).indicator (hmeas j)
  haveI hfin3 : IsFiniteMeasure (3 • σ) := isFiniteMeasure_nsmul 3 σ
  haveI : IsFiniteMeasure (∑ j, σc j) :=
    ⟨by rw [Measure.finsetSum_apply]; exact ENNReal.sum_lt_top.2 fun j _ => measure_lt_top _ _⟩
  haveI hfin4 : IsFiniteMeasure (4 • ∑ j, σc j) := isFiniteMeasure_nsmul 4 _
  refine measure_eq_of_fourier fun y => ?_
  have hev : StronglyMeasurable fun χ : Dual F => ((χ y : Circle) : ℂ) := (measurable_evalChar y).stronglyMeasurable
  rw [integral_add_measure (integrable_evalChar _ y) (integrable_evalChar _ y), integral_nsmul_measure,
    integral_nsmul_measure, integral_dirac' _ _ hev, integral_finsetSum_measure fun j _ => integrable_evalChar _ y,
    hσ.2 y]
  simp only [AddChar.one_apply, Circle.coe_one]
  have hj : ∀ j, ∫ χ, ((χ y : Circle) : ℂ) ∂(σc j) = ((μ.real {ω | κ ω 0 = j ∧ κ ω y = j} : ℝ) : ℂ) := fun j => by
    rw [(hσc j).2 y, integral_colourInd_mul_comp μ T hT κ hκ hequiv y j]
  rw [Finset.sum_congr rfl fun j _ => hj j]
  have h := congrArg (fun r : ℝ => (r : ℂ)) (hcoef y)
  push_cast at h
  exact h

/-! ### The conditional laws -/

/-- **The conditional laws move with the shifts**: `p_j(x) ∘ shift_y = p_j(x + y)` almost surely (`𝒜` is shift-invariant,
`comap_factorSigma_eq_of_action`; `condExp_comp_measurePreserving`). -/
theorem condLaw_comp_colourShift [NumberField F] (μ : InvariantColouring F) (x y : unitRing F) (j : Fin 4) :
    condLaw (colourFactor μ) μ.μ (fun c => c) x j ∘ colourShift y =ᵐ[μ.μ]
      condLaw (colourFactor μ) μ.μ (fun c => c) (x + y) j := by
  have hS𝒜 : (colourFactor μ).comap (colourShift y) = colourFactor μ :=
    comap_factorSigma_eq_of_action colourShift μ.measurePreserving_shift colourShift_add colourShift_zero _ y
  have h := condExp_comp_measurePreserving (colourFactor μ) μ.μ (factorSigma_le _ _ _) (μ.measurePreserving_shift y)
    hS𝒜 (integrable_colourIndicator μ.μ (fun c => c) (fun x => measurable_pi_apply x) x j)
  have e : (Set.indicator {ω' : unitRing F → Fin 4 | ω' x = j} fun _ => (1 : ℝ)) ∘ colourShift y =
      Set.indicator {ω' | ω' (x + y) = j} fun _ => (1 : ℝ) := by
    funext ω
    by_cases hω : ω (x + y) = j <;> simp [colourShift, Set.indicator, hω]
  rw [e] at h
  exact h

/-- `E[p_j(x) p_j(y)] ≥ 0`: conditional laws are nonnegative. -/
theorem integral_condLaw_mul_nonneg [NumberField F] (μ : InvariantColouring F) (x y : unitRing F) (j : Fin 4) :
    0 ≤ ∫ c, condLaw (colourFactor μ) μ.μ (fun c => c) x j c * condLaw (colourFactor μ) μ.μ (fun c => c) y j c ∂μ.μ := by
  refine integral_nonneg_of_ae ?_
  filter_upwards [condLaw_nonneg (colourFactor μ) μ.μ (fun c => c) x j,
    condLaw_nonneg (colourFactor μ) μ.μ (fun c => c) y j] with c h1 h2
  exact mul_nonneg h1 h2

/-- **A proper colouring repeats no colour across a unit vector**: `⟨e_j, V_u e_j⟩ = μ(c(0) = j = c(u)) = 0` (`μ` is carried
by `X₄(F)`). -/
theorem inner_colourInd_comp_unit (μ : InvariantColouring F) (u : unitVectors F) (j : Fin 4) :
    ∫ c, colourInd μ.μ (fun c => c 0) (measurable_pi_apply 0) j c *
        Lp.compMeasurePreserving (colourShift (uvRing u)) (μ.measurePreserving_shift (uvRing u))
          (colourInd μ.μ (fun c => c 0) (measurable_pi_apply 0) j) c ∂μ.μ = 0 := by
  have hequiv : ∀ y, ∀ᵐ c ∂μ.μ, (fun c => c) (colourShift y c) 0 = (fun c : unitRing F → Fin 4 => c) c y :=
    fun y => Eventually.of_forall fun c => by simp [colourShift]
  refine (integral_colourInd_mul_comp μ.μ colourShift μ.measurePreserving_shift (fun c => c)
    (fun x => measurable_pi_apply x) hequiv (uvRing u) j).trans ?_
  have hsub : {c : unitRing F → Fin 4 | c 0 = j ∧ c (uvRing u) = j} ⊆ (X4 F)ᶜ := by
    rintro c ⟨h0, hu⟩ hX
    exact hX 0 (uvRing u) (by simp [uvRing]) (h0.trans hu.symm)
  rw [measureReal_def, measure_mono_null hsub μ.carried, ENNReal.toReal_zero]

/-- **`Πe_j`**, the continuous part of a colour indicator: `E[e_j | 𝒜]` in `L²(μ)`, the vector whose function is the
conditional law `p_j(0)` (`colourCond_ae_eq_condLaw`). -/
def colourCond [NumberField F] (μ : InvariantColouring F) (j : Fin 4) : Lp ℝ 2 μ.μ :=
  condExpL2 ℝ ℝ (factorSigma_le _ μ.measurePreserving_shift (@nhds _ (tauPrime F) 0))
    (colourInd μ.μ (fun c => c 0) (measurable_pi_apply 0) j)

/-- `Πe_j = p_j(0)` almost everywhere (`MemLp.condExpL2_ae_eq_condExp`). -/
theorem colourCond_ae_eq_condLaw [NumberField F] (μ : InvariantColouring F) (j : Fin 4) :
    (colourCond μ j : (unitRing F → Fin 4) → ℝ) =ᵐ[μ.μ] condLaw (colourFactor μ) μ.μ (fun c => c) 0 j :=
  MemLp.condExpL2_ae_eq_condExp (𝕜 := ℝ) (factorSigma_le _ μ.measurePreserving_shift _)
    (memLp_indicator_const 2 ((measurable_pi_apply 0) (measurableSet_singleton j)) (1 : ℝ) (Or.inr (measure_ne_top _ _)))

/-- **The continuous part of a colour indicator is its conditional law**: `⟨Πe_j, V_y Πe_j⟩ = E[p_j(0) p_j(y)]`
(`colourCond_ae_eq_condLaw`, `condLaw_comp_colourShift`). -/
theorem integral_colourCond_mul_comp [NumberField F] (μ : InvariantColouring F) (y : unitRing F) (j : Fin 4) :
    ∫ c, colourCond μ j c * Lp.compMeasurePreserving (colourShift y) (μ.measurePreserving_shift y) (colourCond μ j) c ∂μ.μ =
      ∫ c, condLaw (colourFactor μ) μ.μ (fun c => c) 0 j c * condLaw (colourFactor μ) μ.μ (fun c => c) y j c ∂μ.μ := by
  have h5 := colourCond_ae_eq_condLaw μ j
  have h2 := Lp.coeFn_compMeasurePreserving (colourCond μ j) (μ.measurePreserving_shift y)
  have h3 := h5.comp_tendsto (μ.measurePreserving_shift y).quasiMeasurePreserving.tendsto_ae
  have h4 := condLaw_comp_colourShift μ 0 y j
  rw [zero_add] at h4
  refine integral_congr_ae ?_
  filter_upwards [h5, h2, h3, h4] with c e5 e2 e3 e4
  rw [e2, e3, e5, e4]

/-! ### SI-3 and remark (ii) -/

/-- **J45 Lemma SI-3 at `S = ∅`** (`plans/FS84-SI-D-derivation.md` ll. 153–157): for an invariant colouring `μ`, a trace
spectral measure `σ` of it and a unit vector `u`, `∫_{R̂ ∖ (T + A)} Re χ(u) dσ = −(4/3) Σ_j E[p_j(0) p_j(u)]`. -/
theorem setIntegral_compl_TA_re [NumberField F] (μ : InvariantColouring F) {σ : Measure (Dual F)}
    (hσ : IsTraceSpectral F μ.μ σ) (u : unitVectors F) :
    ∫ χ in (TA F)ᶜ, (χ (uvRing u) : ℂ).re ∂σ =
      -(4 / 3) * ∑ j : Fin 4, ∫ c, condLaw (colourFactor μ) μ.μ (fun c => c) 0 j c *
        condLaw (colourFactor μ) μ.μ (fun c => c) (uvRing u) j c ∂μ.μ := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  haveI := hσ.1
  have hex : ∀ j : Fin 4, ∃ σj : Measure (Dual F), IsSpectralMeasureOf colourShift μ.measurePreserving_shift
      (colourInd μ.μ (fun c => c 0) (measurable_pi_apply 0) j) σj := fun j =>
    exists_isSpectralMeasureOf colourShift μ.measurePreserving_shift colourShift_add _
  choose σc hσc using hex
  haveI : ∀ j, IsFiniteMeasure (σc j) := fun j => (hσc j).1
  have hequiv : ∀ y, ∀ᵐ c ∂μ.μ, (fun c => c) (colourShift y c) 0 = (fun c : unitRing F → Fin 4 => c) c y :=
    fun y => Eventually.of_forall fun c => by simp [colourShift]
  have hσ' : IsTraceSpectral F (μ.μ.map fun c => c) σ := by
    rw [Measure.map_id']
    exact hσ
  have H := trace_decomp μ.μ colourShift μ.measurePreserving_shift (fun c => c) (fun x => measurable_pi_apply x)
    hequiv hσ' hσc
  have hA : MeasurableSet (TA F) := measurableSet_TA F
  have hτ : MeasurableSet (contChars (tauPrime F)) := by
    rw [contChars_tauPrime]
    exact hA
  -- `3σ = 4 Σ_j σ_j` off `T + A` (`1 ∈ T + A`)
  have H' : 3 • σ.restrict (TA F)ᶜ = 4 • ∑ j, (σc j).restrict (TA F)ᶜ := by
    have h := congrArg (fun ν : Measure (Dual F) => ν.restrict (TA F)ᶜ) H
    simp only [Measure.restrict_add, Measure.restrict_smul] at h
    have hd : (Measure.dirac (1 : Dual F)).restrict (TA F)ᶜ = 0 := by
      rw [Measure.restrict_eq_zero, Measure.dirac_apply' _ hA.compl,
        Set.indicator_of_notMem (by simpa using one_mem_TA F)]
    have hsum : (∑ j, σc j).restrict (TA F)ᶜ = ∑ j, (σc j).restrict (TA F)ᶜ := by
      rw [← Measure.restrictₗ_apply, map_sum]
      simp only [Measure.restrictₗ_apply]
    rw [hd, add_zero, hsum] at h
    exact h
  have hI : ∫ χ, ((χ (uvRing u) : Circle) : ℂ) ∂(3 • σ.restrict (TA F)ᶜ) =
      ∫ χ, ((χ (uvRing u) : Circle) : ℂ) ∂(4 • ∑ j, (σc j).restrict (TA F)ᶜ) := by
    rw [H']
  rw [integral_nsmul_measure, integral_nsmul_measure,
    integral_finsetSum_measure fun j _ => integrable_evalChar _ (uvRing u)] at hI
  -- each `∫_{(T+A)ᶜ} χ(u) dσ_j` is `⟨e_j, V_u e_j⟩ − ⟨Πe_j, V_u Πe_j⟩ = −E[p_j(0) p_j(u)]`
  have hj : ∀ j, ∫ χ in (TA F)ᶜ, ((χ (uvRing u) : Circle) : ℂ) ∂(σc j) =
      -((∫ c, condLaw (colourFactor μ) μ.μ (fun c => c) 0 j c *
        condLaw (colourFactor μ) μ.μ (fun c => c) (uvRing u) j c ∂μ.μ : ℝ) : ℂ) := by
    intro j
    have hsplit := integral_add_compl hA (integrable_evalChar (σc j) (uvRing u))
    have htot : ∫ χ, ((χ (uvRing u) : Circle) : ℂ) ∂(σc j) = 0 := by
      rw [(hσc j).2 (uvRing u), inner_colourInd_comp_unit μ u j, Complex.ofReal_zero]
    have hpart := (isSpectralMeasureOf_condExpL2 (tauPrime F) (isTopologicalAddGroup_tauPrime F)
      (isCountablyGenerated_nhds_tauPrime F) (bochnerOn_tauPrime F) hτ colourShift μ.measurePreserving_shift
      colourShift_add (hσc j)).1
    rw [contChars_tauPrime] at hpart
    have hTA : ∫ χ in TA F, ((χ (uvRing u) : Circle) : ℂ) ∂(σc j) =
        ((∫ c, condLaw (colourFactor μ) μ.μ (fun c => c) 0 j c *
          condLaw (colourFactor μ) μ.μ (fun c => c) (uvRing u) j c ∂μ.μ : ℝ) : ℂ) := by
      rw [hpart.2 (uvRing u)]
      exact congrArg _ (integral_colourCond_mul_comp μ (uvRing u) j)
    rw [htot, hTA] at hsplit
    linear_combination hsplit
  rw [Finset.sum_congr rfl fun j _ => hj j, Finset.sum_neg_distrib] at hI
  have hX : ∫ χ in (TA F)ᶜ, ((χ (uvRing u) : Circle) : ℂ) ∂σ =
      (((-(4 / 3) * ∑ j : Fin 4, ∫ c, condLaw (colourFactor μ) μ.μ (fun c => c) 0 j c *
        condLaw (colourFactor μ) μ.μ (fun c => c) (uvRing u) j c ∂μ.μ) : ℝ) : ℂ) := by
    push_cast
    linear_combination hI / 3
  have hre := integral_re (𝕜 := ℂ) (integrable_evalChar (σ.restrict (TA F)ᶜ) (uvRing u))
  simp only [RCLike.re_to_complex] at hre
  rw [hre, hX, Complex.ofReal_re]

/-- **SI-3's inequality**: the mean of `Re χ(u)` off `T + A` is `≤ 0`. -/
theorem setIntegral_compl_TA_re_nonpos [NumberField F] (μ : InvariantColouring F) {σ : Measure (Dual F)}
    (hσ : IsTraceSpectral F μ.μ σ) (u : unitVectors F) : ∫ χ in (TA F)ᶜ, (χ (uvRing u) : ℂ).re ∂σ ≤ 0 := by
  rw [setIntegral_compl_TA_re μ hσ u]
  have h : 0 ≤ ∑ j : Fin 4, ∫ c, condLaw (colourFactor μ) μ.μ (fun c => c) 0 j c *
      condLaw (colourFactor μ) μ.μ (fun c => c) (uvRing u) j c ∂μ.μ :=
    Finset.sum_nonneg fun j _ => integral_condLaw_mul_nonneg μ 0 (uvRing u) j
  linarith

/-- **J45 A⁺, remark (ii)** (ll. 249–250): the mean of `Re χ(u)` off `T + A` is the same at every unit vector — `σ` is
rotation-invariant (`rotInv_of_isTraceSpectral`, over `bochnerHerglotz_of_countable`) and so is `T + A`
(`rot_preimage_TA`), and `(u·χ)(1) = χ(u)`. -/
theorem setIntegral_compl_TA_rot [NumberField F] (μ : InvariantColouring F) {σ : Measure (Dual F)}
    (hσ : IsTraceSpectral F μ.μ σ) (u : unitVectors F) :
    ∫ χ in (TA F)ᶜ, (χ (uvRing u) : ℂ).re ∂σ = ∫ χ in (TA F)ᶜ, (χ 1 : ℂ).re ∂σ := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  have hrot : σ.map (rot u) = σ := rotInv_of_isTraceSpectral (bochnerHerglotz_of_countable _) μ hσ u
  have hA : MeasurableSet (TA F)ᶜ := (measurableSet_TA F).compl
  have hm : Measurable fun χ : Dual F => (χ 1 : ℂ).re := Complex.measurable_re.comp (measurable_evalChar 1)
  conv_rhs => rw [← hrot]
  rw [setIntegral_map hA hm.aestronglyMeasurable (measurable_rot u).aemeasurable, Set.preimage_compl,
    rot_preimage_TA]
  simp only [rot_apply, mul_one]

end

end HadwigerNelson.Rigidity
