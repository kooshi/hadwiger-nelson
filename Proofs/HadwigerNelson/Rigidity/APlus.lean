import Proofs.HadwigerNelson.Rigidity.TraceSplit
import Proofs.HadwigerNelson.Rigidity.ChainAtTA
import Proofs.HadwigerNelson.Rigidity.InvariantMeasure
import Proofs.HadwigerNelson.Instances.UpperHalfValues

/-!
# A⁺ at `S = ∅`: the chain's hypothesis `(chainInterface F).APlusOfR88`, proved (FS-131, job FS131-KM11; module M11c; skeleton)

**Read aloud, against the informal claim.** `aPlusOfR88 : (chainInterface F).APlusOfR88` for every real number field `F`:
if no invariant random proper four-colouring of `Cay(ℤ[U_F], U_F)` has a trace spectral measure null off `T + A`
(R88-TCA at `S = ∅`), then for every invariant colouring `μ` and every trace spectral measure `σ` of it,
`∫_{R̂ ∖ (T + A)} Re χ(1) dσ < 0` — J45's Lemma A⁺ with remark (ii) (`plans/FS84-SI-D-derivation.md` ll. 240–250), at
`S = ∅` (FS131-EN1, EN1-APLUS).

**Route.** By SI-3 and remark (ii) (`Rigidity/TraceSplit`) the integral is `−(4/3) Σ_j E[p_j(0) p_j(u)] ≤ 0` and the same at
every unit vector `u`. If it is not `< 0`, then `E[p_j(0) p_j(u)] = 0` for every `u` and `j` (`EqualAtUnits`), so by shift
invariance the conditional supports are disjoint across every edge (`integral_condLaw_mul_eq_zero_of_adj`), and SI-4
(`SpectralInputs.si4`) makes the least-colour selection `c′ = min ∘ M` (`factorColouring`) a proper colouring almost
surely, `𝒜`-measurable, and — `𝒜` being shift- and rotation-invariant (`comap_colourRot_colourFactor`, over
`tendsto_mul_nhds_tauPrime`) — equivariant under both. Its law is an invariant colouring (`factorLaw`) whose trace
measure is null off `T + A` (`factorLaw_trace_null`: `3σ′ + δ₁ = 4Σ_j σ_{e″_j}` with `e″_j = 1{c′(0) = j}` `𝒜`-measurable,
so each `σ_{e″_j}` is carried by `T + A`); R88-TCA refuses it.

**Models.** `aplus_model`: at `F = ℚ` (`numberField_bot`) an invariant colouring with a trace spectral measure exists —
the two-colouring of `ℚ²` at the ramified prime above 2 (`UpperHalf.exists_stablePrime_rat`), the invariant measure of
module M3 (`invariantMeasureOnClosed_of_countable`) and Herglotz–Bochner. So the binders of `APlus0` are inhabited at `ℚ`;
there R88-TCA itself fails (the colouring's spectrum is torsion), and `aPlusOfR88` is the implication at every field. At
`ℚ(√47)` R88-TCA is the count's conclusion (module M12), and `APlus0` is consumed by `five_le_chromaticNumber_of_mrPlus`.
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory SpectralChain SpectralInputs Filter Topology NumberField

noncomputable section

variable {F : Subfield ℝ}

/-! ### Rotations of colourings, and the factor -/

/-- **The rotation of a colouring** by a unit vector: `c ↦ c(u ·)`, the map `InvariantColouring.rot_inv` is about. -/
def colourRot (u : unitVectors F) (c : unitRing F → Fin 4) : unitRing F → Fin 4 := fun x => c (uvRing u * x)

theorem measurable_colourRot (u : unitVectors F) : Measurable (colourRot u) :=
  measurable_pi_lambda _ fun _ => measurable_pi_apply _

theorem _root_.HadwigerNelson.SpectralChain.InvariantColouring.measurePreserving_rot (μ : InvariantColouring F) (u : unitVectors F) :
    MeasurePreserving (colourRot u) μ.μ μ.μ :=
  ⟨measurable_colourRot u, μ.rot_inv u⟩

/-- **Multiplication by an element of `R` is continuous at `0` for `τ′_∅`**: it maps `(N + 1)·R` into itself, and on the
mixed space it is multiplication by the image of `r`, a continuous linear map. -/
theorem tendsto_mul_nhds_tauPrime [NumberField F] (r : unitRing F) :
    Tendsto (fun y => r * y) (@nhds _ (tauPrime F) 0) (@nhds _ (tauPrime F) 0) := by
  sorry

/-- **`𝒜` is rotation-invariant**: `shift_y ∘ rot_u = rot_u ∘ shift_{uy}`, so an event whose indicator is `τ′_∅`-continuous
under the shifts has a rotated preimage that is too (`tendsto_mul_nhds_tauPrime`); the rotation by `ū` is the inverse. -/
theorem comap_colourRot_colourFactor [NumberField F] (μ : InvariantColouring F) (u : unitVectors F) :
    (colourFactor μ).comap (colourRot u) = colourFactor μ := by
  sorry

/-! ### SI-4: the factor colouring -/

/-- The least element of a set of colours, `0` for the empty set: a choice function on the nonempty ones. -/
def minSel (s : Finset (Fin 4)) : Fin 4 := if h : s.Nonempty then s.min' h else 0

theorem minSel_mem {s : Finset (Fin 4)} (h : s.Nonempty) : minSel s ∈ s := by
  rw [minSel, dif_pos h]
  exact Finset.min'_mem s h

/-- **SI-4's selection** `c′ = min ∘ M`: at each vertex, the least colour of its conditional support given `𝒜`. -/
def factorColouring [NumberField F] (μ : InvariantColouring F) (c : unitRing F → Fin 4) : unitRing F → Fin 4 :=
  fun x => minSel (condSupport (colourFactor μ) μ.μ (fun c => c) c x)

/-- Each colour of `c′` is `𝒜`-measurable (`SpectralInputs.measurable_selection`). -/
theorem measurable_factorColouring_apply [NumberField F] (μ : InvariantColouring F) (x : unitRing F) :
    Measurable[colourFactor μ] fun c => factorColouring μ c x :=
  measurable_selection (colourFactor μ) μ.μ (fun c => c) minSel x

theorem measurable_factorColouring [NumberField F] (μ : InvariantColouring F) : Measurable (factorColouring μ) :=
  measurable_pi_lambda _ fun x =>
    (measurable_factorColouring_apply μ x).mono (factorSigma_le _ μ.measurePreserving_shift _) le_rfl

/-- **`c′` is shift-equivariant** almost surely (`si4_equivariant_factorSigma`, `π x = x + y`). -/
theorem factorColouring_shift_ae [NumberField F] (μ : InvariantColouring F) (y : unitRing F) :
    ∀ᵐ c ∂μ.μ, factorColouring μ (colourShift y c) = colourShift y (factorColouring μ c) := by
  sorry

/-- **`c′` is rotation-equivariant** almost surely (`si4_equivariant` with `comap_colourRot_colourFactor`, `π x = u x`). -/
theorem factorColouring_rot_ae [NumberField F] (μ : InvariantColouring F) (u : unitVectors F) :
    ∀ᵐ c ∂μ.μ, factorColouring μ (colourRot u c) = colourRot u (factorColouring μ c) := by
  sorry

/-- **Equality in SI-3 at every unit vector**: `E[p_j(0) p_j(u)] = 0` for every `u ∈ U` and every colour `j` — by SI-3, the
mean of `Re χ(u)` off `T + A` is `0` at every `u`. MODEL (described, not a declaration): over `ℚ`, the law of
`x ↦ φ(x) + ξ`, `φ : R → 𝔽₂` the residue map at the ramified prime above 2 and `ξ` a fair bit, is `𝒜`-measurable (its
spectrum is torsion), so `p_j(x) = 1{c(x) = j}` and every product vanishes across an edge. At a field where R88-TCA holds
it is refuted for every `μ` (`aPlusOfR88` through `equalAtUnits_of_not_neg`): it is a step inside a proof by contradiction. -/
def EqualAtUnits [NumberField F] (μ : InvariantColouring F) : Prop :=
  ∀ (u : unitVectors F) (j : Fin 4),
    ∫ c, condLaw (colourFactor μ) μ.μ (fun c => c) 0 j c * condLaw (colourFactor μ) μ.μ (fun c => c) (uvRing u) j c ∂μ.μ = 0

/-- **Disjoint supports across every edge**: from equality at the unit vectors, `E[p_j(x) p_j(y)] = 0` whenever `y − x` is
a unit vector (shift invariance, `condLaw_comp_colourShift`). -/
theorem integral_condLaw_mul_eq_zero_of_adj [NumberField F] (μ : InvariantColouring F) (h : EqualAtUnits μ)
    {x y : unitRing F} (hxy : (y : ℂ) - x ∈ unitVectors F) (j : Fin 4) :
    ∫ c, condLaw (colourFactor μ) μ.μ (fun c => c) x j c * condLaw (colourFactor μ) μ.μ (fun c => c) y j c ∂μ.μ = 0 := by
  sorry

/-- **`c′` is a proper four-colouring** almost surely, given equality at the unit vectors (`SpectralInputs.si4`). -/
theorem factorColouring_mem_X4 [NumberField F] (μ : InvariantColouring F) (h : EqualAtUnits μ) :
    ∀ᵐ c ∂μ.μ, factorColouring μ c ∈ X4 F := by
  sorry

theorem factorLaw_isProb [NumberField F] (μ : InvariantColouring F) :
    IsProbabilityMeasure (μ.μ.map (factorColouring μ)) :=
  Measure.isProbabilityMeasure_map (measurable_factorColouring μ).aemeasurable

theorem factorLaw_carried [NumberField F] (μ : InvariantColouring F) (h : EqualAtUnits μ) :
    μ.μ.map (factorColouring μ) (X4 F)ᶜ = 0 := by
  sorry

theorem factorLaw_shift_inv [NumberField F] (μ : InvariantColouring F) (y : unitRing F) :
    (μ.μ.map (factorColouring μ)).map (fun c x => c (x + y)) = μ.μ.map (factorColouring μ) := by
  sorry

theorem factorLaw_rot_inv [NumberField F] (μ : InvariantColouring F) (u : unitVectors F) :
    (μ.μ.map (factorColouring μ)).map (fun c x => c (uvRing u * x)) = μ.μ.map (factorColouring μ) := by
  sorry

/-- **The law of the factor colouring**, an invariant colouring when SI-3 is an equality at every unit vector. -/
def factorLaw [NumberField F] (μ : InvariantColouring F) (h : EqualAtUnits μ) : InvariantColouring F where
  μ := μ.μ.map (factorColouring μ)
  isProb := factorLaw_isProb μ
  carried := factorLaw_carried μ h
  shift_inv := factorLaw_shift_inv μ
  rot_inv := factorLaw_rot_inv μ

/-- **The factor colouring's trace measure is null off `T + A`** (A⁺'s proof, ll. 244–247): `3σ′ + δ₁ = 4 Σ_j σ_{e″_j}`
(`trace_decomp` at `κ = c′`), each `e″_j = 1{c′(0) = j}` is `𝒜`-measurable, so `τ′_∅`-continuous (`contVec_eq_lpMeas`), so
its spectral measure is carried by `contChars (tauPrime F) = T + A` (`spectral_carried_iff` over `bochnerOn_tauPrime`).
Stated for the law of `c′` whatever `μ`: neither properness of `c′` nor SI-3's equality is read. -/
theorem factorLaw_trace_null [NumberField F] (μ : InvariantColouring F) {σ' : Measure (Dual F)}
    (hσ' : IsTraceSpectral F (μ.μ.map (factorColouring μ)) σ') : σ' (TA F)ᶜ = 0 := by
  sorry

/-! ### A⁺ -/

/-- **Equality at the unit vectors from equality at `1`**: if the mean of `Re χ(1)` off `T + A` is not negative, it is `0`
at every unit vector (remark (ii)), so every `E[p_j(0) p_j(u)]`, being `≥ 0` with sum `0`, is `0` (SI-3). -/
theorem equalAtUnits_of_not_neg [NumberField F] (μ : InvariantColouring F) {σ : Measure (Dual F)}
    (hσ : IsTraceSpectral F μ.μ σ) (h : ¬ ∫ χ in (TA F)ᶜ, (χ 1 : ℂ).re ∂σ < 0) : EqualAtUnits μ := by
  sorry

/-- **A⁺ at `S = ∅` from R88-TCA** (J45 Lemma A⁺ with remark (ii); FS131-EN1, EN1-APLUS), the chain's hypothesis `hAP`
discharged for every real number field: given R88-TCA, every invariant colouring's every trace spectral measure has
`∫_{R̂ ∖ (T + A)} Re χ(1) dσ < 0`. -/
theorem aPlusOfR88 (F : Subfield ℝ) [NumberField F] : (chainInterface F).APlusOfR88 := by
  intro hR μ σ hσ
  show ∫ χ in (TA F)ᶜ, (χ 1 : ℂ).re ∂σ < 0
  by_contra hneg
  have hEq := equalAtUnits_of_not_neg μ hσ hneg
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  obtain ⟨σ', hfin, hσ', -⟩ := bochnerHerglotz_of_countable (unitRing F) _ (posDef_corr (factorLaw μ hEq))
  exact hR (factorLaw μ hEq) σ' ⟨hfin, hσ'⟩ (factorLaw_trace_null μ ⟨hfin, hσ'⟩)

/-! ## Models -/

/-- `ℚ`, the least subfield of `ℝ`, is a number field. -/
theorem numberField_bot : NumberField (⊥ : Subfield ℝ) := by
  sorry

/-- **An invariant colouring exists over `ℚ`**: `ℚ²` is two-colourable (the ramified stable prime above 2,
`UpperHalf.exists_stablePrime_rat`, `UpperHalf.colorable_two_planeOver_of_ramified`), so `X₄(ℚ)` is nonempty, and the
invariant measure on it is module M3's (`invariantMeasureOnClosed_of_countable`). -/
theorem nonempty_invariantColouring_bot : Nonempty (InvariantColouring (⊥ : Subfield ℝ)) := by
  haveI := numberField_bot
  haveI : Countable (⊥ : Subfield ℝ) := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := (⊥ : Subfield ℝ))
  haveI : Countable (unitRing (⊥ : Subfield ℝ)) := countable_unitRing
  obtain ⟨P, -, hram⟩ := UpperHalf.exists_stablePrime_rat
  exact exists_invariantColouring (invariantMeasureOnClosed_of_countable ⊥)
    (x4_nonempty_of_colorable ((UpperHalf.colorable_two_planeOver_of_ramified P hram).mono (by norm_num)))

/-- **The model of SI-3's and A⁺'s binders**: over `ℚ` an invariant colouring and a trace spectral measure of it exist. -/
theorem aplus_model : ∃ (μ : InvariantColouring (⊥ : Subfield ℝ)) (σ : Measure (Dual (⊥ : Subfield ℝ))),
    IsTraceSpectral (⊥ : Subfield ℝ) μ.μ σ := by
  haveI := numberField_bot
  haveI : Countable (⊥ : Subfield ℝ) := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := (⊥ : Subfield ℝ))
  haveI : Countable (unitRing (⊥ : Subfield ℝ)) := countable_unitRing
  obtain ⟨μ⟩ := nonempty_invariantColouring_bot
  obtain ⟨σ, hfin, hσ, -⟩ := bochnerHerglotz_of_countable (unitRing (⊥ : Subfield ℝ)) _ (posDef_corr μ)
  exact ⟨μ, σ, hfin, hσ⟩

-- `minSel` would drift if it stopped choosing the least colour.
example : minSel {2, 3} = 2 := by decide

end

end HadwigerNelson.Rigidity
