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
theorem InvariantColouring.measurePreserving_shift (μ : InvariantColouring F) (y : unitRing F) :
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
  sorry

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
  sorry

/-! ### The conditional laws -/

/-- **The conditional laws move with the shifts**: `p_j(x) ∘ shift_y = p_j(x + y)` almost surely (`𝒜` is shift-invariant,
`comap_factorSigma_eq_of_action`; `condExp_comp_measurePreserving`). -/
theorem condLaw_comp_colourShift [NumberField F] (μ : InvariantColouring F) (x y : unitRing F) (j : Fin 4) :
    condLaw (colourFactor μ) μ.μ (fun c => c) x j ∘ colourShift y =ᵐ[μ.μ]
      condLaw (colourFactor μ) μ.μ (fun c => c) (x + y) j := by
  sorry

/-- `E[p_j(x) p_j(y)] ≥ 0`: conditional laws are nonnegative. -/
theorem integral_condLaw_mul_nonneg [NumberField F] (μ : InvariantColouring F) (x y : unitRing F) (j : Fin 4) :
    0 ≤ ∫ c, condLaw (colourFactor μ) μ.μ (fun c => c) x j c * condLaw (colourFactor μ) μ.μ (fun c => c) y j c ∂μ.μ := by
  refine integral_nonneg_of_ae ?_
  filter_upwards [condLaw_nonneg (colourFactor μ) μ.μ (fun c => c) x j,
    condLaw_nonneg (colourFactor μ) μ.μ (fun c => c) y j] with c h1 h2
  exact mul_nonneg h1 h2

/-- **A proper colouring repeats no colour across a unit vector**: `⟨e_j, V_u e_j⟩ = μ(c(0) = j = c(u)) = 0` (`μ` is carried
by `X₄(F)`). -/
theorem inner_colourInd_comp_unit [NumberField F] (μ : InvariantColouring F) (u : unitVectors F) (j : Fin 4) :
    ∫ c, colourInd μ.μ (fun c => c 0) (measurable_pi_apply 0) j c *
        Lp.compMeasurePreserving (colourShift (uvRing u)) (μ.measurePreserving_shift (uvRing u))
          (colourInd μ.μ (fun c => c 0) (measurable_pi_apply 0) j) c ∂μ.μ = 0 := by
  sorry

/-- **`Πe_j`**, the continuous part of a colour indicator: `E[e_j | 𝒜]` in `L²(μ)`, the vector whose function is the
conditional law `p_j(0)` (`colourCond_ae_eq_condLaw`). -/
def colourCond [NumberField F] (μ : InvariantColouring F) (j : Fin 4) : Lp ℝ 2 μ.μ :=
  condExpL2 ℝ ℝ (factorSigma_le _ μ.measurePreserving_shift (@nhds _ (tauPrime F) 0))
    (colourInd μ.μ (fun c => c 0) (measurable_pi_apply 0) j)

/-- `Πe_j = p_j(0)` almost everywhere (`MemLp.condExpL2_ae_eq_condExp`). -/
theorem colourCond_ae_eq_condLaw [NumberField F] (μ : InvariantColouring F) (j : Fin 4) :
    (colourCond μ j : unitRing F → Fin 4 → ℝ) =ᵐ[μ.μ] condLaw (colourFactor μ) μ.μ (fun c => c) 0 j := by
  sorry

/-- **The continuous part of a colour indicator is its conditional law**: `⟨Πe_j, V_y Πe_j⟩ = E[p_j(0) p_j(y)]`
(`colourCond_ae_eq_condLaw`, `condLaw_comp_colourShift`). -/
theorem integral_colourCond_mul_comp [NumberField F] (μ : InvariantColouring F) (y : unitRing F) (j : Fin 4) :
    ∫ c, colourCond μ j c * Lp.compMeasurePreserving (colourShift y) (μ.measurePreserving_shift y) (colourCond μ j) c ∂μ.μ =
      ∫ c, condLaw (colourFactor μ) μ.μ (fun c => c) 0 j c * condLaw (colourFactor μ) μ.μ (fun c => c) y j c ∂μ.μ := by
  sorry

/-! ### SI-3 and remark (ii) -/

/-- **J45 Lemma SI-3 at `S = ∅`** (`plans/FS84-SI-D-derivation.md` ll. 153–157): for an invariant colouring `μ`, a trace
spectral measure `σ` of it and a unit vector `u`, `∫_{R̂ ∖ (T + A)} Re χ(u) dσ = −(4/3) Σ_j E[p_j(0) p_j(u)]`. -/
theorem setIntegral_compl_TA_re [NumberField F] (μ : InvariantColouring F) {σ : Measure (Dual F)}
    (hσ : IsTraceSpectral F μ.μ σ) (u : unitVectors F) :
    ∫ χ in (TA F)ᶜ, (χ (uvRing u) : ℂ).re ∂σ =
      -(4 / 3) * ∑ j : Fin 4, ∫ c, condLaw (colourFactor μ) μ.μ (fun c => c) 0 j c *
        condLaw (colourFactor μ) μ.μ (fun c => c) (uvRing u) j c ∂μ.μ := by
  sorry

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
  sorry

end

end HadwigerNelson.Rigidity
