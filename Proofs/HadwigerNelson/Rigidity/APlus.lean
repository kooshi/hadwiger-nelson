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
  have hn : @nhds (unitRing F) (tauPrime F) 0 = @nhds _ (profTop F) 0 ⊓ @nhds _ (archTop F) 0 :=
    nhds_inf (t₁ := profTop F) (t₂ := archTop F)
  rw [hn]
  refine tendsto_inf.2 ⟨tendsto_inf_left ?_, tendsto_inf_right ?_⟩
  · -- profinite: `r · (N + 1)R ⊆ (N + 1)R`
    have hp : @nhds _ (profTop F) (0 : unitRing F) = ⨅ N : ℕ, @nhds _ (TopologicalSpace.induced
        (QuotientAddGroup.mk' (nsmulAddMonoidHom (α := unitRing F) (N + 1)).range) ⊥) 0 := nhds_iInf
    refine Tendsto.mono_right (tendsto_iInf.2 fun N => ?_) hp.ge
    rw [@nhds_induced _ _ ⊥, @nhds_discrete _ ⊥ (discreteTopology_bot _), tendsto_comap_iff, tendsto_pure]
    filter_upwards [mem_nhds_profTop F N 0] with y hy
    obtain ⟨z, hz⟩ := hy
    have hy' : y = -((N + 1) • z) := eq_neg_of_add_eq_zero_left hz.symm
    simp only [Function.comp_apply]
    rw [map_zero, QuotientAddGroup.mk'_apply, QuotientAddGroup.eq_zero_iff]
    refine ⟨-(r * z), ?_⟩
    rw [nsmulAddMonoidHom_apply, hy', smul_neg, mul_neg, mul_smul_comm]
  · -- archimedean: `archTop` is induced by the mixed embedding, which is multiplicative
    let f : unitRing F → NumberField.mixedEmbedding.mixedSpace (fieldI F) := fun r =>
      NumberField.mixedEmbedding (fieldI F) ⟨(r : ℂ), UnitRing.unitRingOver_le_planeOverSubring F r.2⟩
    have hmul : ∀ y : unitRing F, f (r * y) = f r * f y := by
      intro y
      show NumberField.mixedEmbedding (fieldI F) ⟨((r * y : unitRing F) : ℂ), _⟩ =
        NumberField.mixedEmbedding (fieldI F) ⟨(r : ℂ), _⟩ * NumberField.mixedEmbedding (fieldI F) ⟨(y : ℂ), _⟩
      rw [← map_mul]
      rfl
    have h0 : f 0 = 0 := by
      show NumberField.mixedEmbedding (fieldI F) ⟨((0 : unitRing F) : ℂ), _⟩ = 0
      rw [← map_zero (NumberField.mixedEmbedding (fieldI F))]
      rfl
    have ha : archTop F = TopologicalSpace.induced f inferInstance := rfl
    have hc : Tendsto (fun v => f r * v) (nhds 0) (nhds 0) := by
      have := (continuous_const_mul (f r)).tendsto (0 : NumberField.mixedEmbedding.mixedSpace (fieldI F))
      rwa [mul_zero] at this
    have hcomap : Tendsto f (Filter.comap f (nhds 0)) (nhds 0) := tendsto_comap
    rw [ha, nhds_induced, h0, tendsto_comap_iff]
    exact Tendsto.congr (fun y => (hmul y).symm) (hc.comp hcomap)

/-- The conjugate of a unit vector, as a unit vector. -/
private def conjUV (u : unitVectors F) : unitVectors F :=
  ⟨starRingEnd ℂ u, UnitRing.conj_mem_planeOver u.2.1, by rw [Complex.norm_conj]; exact u.2.2⟩

/-- `u (ū y) = y`: `u ū = |u|² = 1`. -/
private theorem uvRing_mul_conjUV (u : unitVectors F) (y : unitRing F) : uvRing u * (uvRing (conjUV u) * y) = y := by
  have h1 : (u : ℂ) * starRingEnd ℂ u = 1 := by
    rw [Complex.mul_conj', u.2.2]
    simp
  apply Subtype.ext
  change (u : ℂ) * (starRingEnd ℂ u * y) = y
  rw [← mul_assoc, h1, one_mul]

/-- The rotated preimage of an event of `𝒜` is an event of `𝒜`: `shift_y ⁻¹ (rot_u ⁻¹ A) = rot_u ⁻¹ (shift_{ū y} ⁻¹ A)`,
`rot_u` preserves the law, and `y ↦ ū y` is continuous at `0` (`tendsto_mul_nhds_tauPrime`). -/
private theorem colourRot_preimage_mem [NumberField F] (μ : InvariantColouring F) (u : unitVectors F)
    {A : Set (unitRing F → Fin 4)} (hA : MeasurableSet[colourFactor μ] A) :
    MeasurableSet[colourFactor μ] (colourRot u ⁻¹' A) := by
  rw [measurableSet_factorSigma_iff] at hA ⊢
  obtain ⟨hAm, h⟩ := (mem_factorSets_iff colourShift μ.measurePreserving_shift _).mp hA
  refine (mem_factorSets_iff colourShift μ.measurePreserving_shift _).mpr ⟨hAm.preimage (measurable_colourRot u), ?_⟩
  have key : ∀ y, μ.μ (symmDiff (colourShift y ⁻¹' (colourRot u ⁻¹' A)) (colourRot u ⁻¹' A)) =
      μ.μ (symmDiff (colourShift (uvRing (conjUV u) * y) ⁻¹' A) A) := by
    intro y
    have e1 : colourShift y ⁻¹' (colourRot u ⁻¹' A) =
        colourRot u ⁻¹' (colourShift (uvRing (conjUV u) * y) ⁻¹' A) := by
      have e : ∀ c, colourRot u (colourShift y c) = colourShift (uvRing (conjUV u) * y) (colourRot u c) := by
        intro c
        funext x
        simp only [colourRot, colourShift]
        rw [mul_add, uvRing_mul_conjUV]
      ext c
      simp only [Set.mem_preimage, e]
    rw [e1, ← Set.preimage_symmDiff, (μ.measurePreserving_rot u).measure_preimage
      ((hAm.preimage (measurable_colourShift _)).symmDiff hAm).nullMeasurableSet]
  simp only [key]
  exact h.comp (tendsto_mul_nhds_tauPrime (uvRing (conjUV u)))

/-- **`𝒜` is rotation-invariant**: `shift_y ∘ rot_u = rot_u ∘ shift_{uy}`, so an event whose indicator is `τ′_∅`-continuous
under the shifts has a rotated preimage that is too (`tendsto_mul_nhds_tauPrime`); the rotation by `ū` is the inverse. -/
theorem comap_colourRot_colourFactor [NumberField F] (μ : InvariantColouring F) (u : unitVectors F) :
    (colourFactor μ).comap (colourRot u) = colourFactor μ := by
  apply le_antisymm
  · intro s hs
    obtain ⟨A, hA, rfl⟩ := MeasurableSpace.measurableSet_comap.mp hs
    exact colourRot_preimage_mem μ u hA
  · intro B hB
    refine MeasurableSpace.measurableSet_comap.mpr ⟨colourRot (conjUV u) ⁻¹' B, colourRot_preimage_mem μ (conjUV u) hB, ?_⟩
    have e : ∀ c, colourRot (conjUV u) (colourRot u c) = c := by
      intro c
      funext x
      simp only [colourRot]
      rw [uvRing_mul_conjUV]
    ext c
    simp only [Set.mem_preimage, e]

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
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  have hcomm : ∀ x y : unitRing F, colourShift x ∘ colourShift y = colourShift y ∘ colourShift x := by
    intro x y
    rw [← colourShift_add, ← colourShift_add, add_comm]
  have hinv : colourShift (-y) ∘ colourShift y = id := by
    rw [← colourShift_add, neg_add_cancel, colourShift_zero]
  have h := si4_equivariant_factorSigma (μ := μ.μ) colourShift μ.measurePreserving_shift hcomm
    (@nhds _ (tauPrime F) 0) (fun c => c) (fun x => measurable_pi_apply x) hinv (fun v => v + y) (fun ω v => rfl)
  filter_upwards [h] with c hc
  funext x
  show minSel (condSupport (colourFactor μ) μ.μ (fun c => c) (colourShift y c) x) =
    minSel (condSupport (colourFactor μ) μ.μ (fun c => c) c (x + y))
  rw [hc x]

/-- **`c′` is rotation-equivariant** almost surely (`si4_equivariant` with `comap_colourRot_colourFactor`, `π x = u x`). -/
theorem factorColouring_rot_ae [NumberField F] (μ : InvariantColouring F) (u : unitVectors F) :
    ∀ᵐ c ∂μ.μ, factorColouring μ (colourRot u c) = colourRot u (factorColouring μ c) := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  have h := si4_equivariant (colourFactor μ) μ.μ (factorSigma_le _ _ _) (fun c => c) (fun x => measurable_pi_apply x)
    (μ.measurePreserving_rot u) (comap_colourRot_colourFactor μ u) (fun x => uvRing u * x) (fun ω x => rfl)
  filter_upwards [h] with c hc
  funext x
  show minSel (condSupport (colourFactor μ) μ.μ (fun c => c) (colourRot u c) x) =
    minSel (condSupport (colourFactor μ) μ.μ (fun c => c) c (uvRing u * x))
  rw [hc x]

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
  let u : unitVectors F := ⟨(y : ℂ) - x, hxy⟩
  have hu : uvRing u = y - x := Subtype.ext (by simp [uvRing, u])
  have h0 := h u j
  rw [hu] at h0
  have e1 := condLaw_comp_colourShift μ 0 x j
  have e2 := condLaw_comp_colourShift μ (y - x) x j
  rw [zero_add] at e1
  rw [sub_add_cancel] at e2
  have hS := μ.measurePreserving_shift x
  have hm : ∀ z, Measurable (condLaw (colourFactor μ) μ.μ (fun c => c) z j) := fun z =>
    (measurable_condLaw (colourFactor μ) μ.μ (fun c => c) z j).mono (factorSigma_le _ _ _) le_rfl
  have hg : Measurable fun c => condLaw (colourFactor μ) μ.μ (fun c => c) 0 j c *
      condLaw (colourFactor μ) μ.μ (fun c => c) (y - x) j c := (hm 0).mul (hm (y - x))
  have hmap := integral_map (μ := μ.μ) hS.measurable.aemeasurable hg.aestronglyMeasurable
  rw [hS.map_eq] at hmap
  rw [← h0, hmap]
  refine integral_congr_ae ?_
  filter_upwards [e1, e2] with c h1 h2
  rw [← h1, ← h2]
  rfl

/-- **`c′` is a proper four-colouring** almost surely, given equality at the unit vectors (`SpectralInputs.si4`). -/
theorem factorColouring_mem_X4 [NumberField F] (μ : InvariantColouring F) (h : EqualAtUnits μ) :
    ∀ᵐ c ∂μ.μ, factorColouring μ c ∈ X4 F := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  have h4 := si4 (V := unitRing F) (colourFactor μ) μ.μ (factorSigma_le _ _ _) (fun c => c)
    (fun x => measurable_pi_apply x) (fun x y => (y : ℂ) - x ∈ unitVectors F)
    (fun x y hxy j => integral_condLaw_mul_eq_zero_of_adj μ h hxy j) minSel (fun s hs => minSel_mem hs)
  filter_upwards [h4.2.1] with c hc
  exact fun x y hxy => hc x y hxy

theorem factorLaw_isProb [NumberField F] (μ : InvariantColouring F) :
    IsProbabilityMeasure (μ.μ.map (factorColouring μ)) :=
  Measure.isProbabilityMeasure_map (measurable_factorColouring μ).aemeasurable

theorem factorLaw_carried [NumberField F] (μ : InvariantColouring F) (h : EqualAtUnits μ) :
    μ.μ.map (factorColouring μ) (X4 F)ᶜ = 0 := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  rw [Measure.map_apply (measurable_factorColouring μ) measurableSet_X4.compl]
  refine measure_eq_zero_iff_ae_notMem.mpr ?_
  filter_upwards [factorColouring_mem_X4 μ h] with c hc
  simpa using hc

theorem factorLaw_shift_inv [NumberField F] (μ : InvariantColouring F) (y : unitRing F) :
    (μ.μ.map (factorColouring μ)).map (fun c x => c (x + y)) = μ.μ.map (factorColouring μ) := by
  have hae : (fun (c : unitRing F → Fin 4) x => c (x + y)) ∘ factorColouring μ =ᵐ[μ.μ]
      factorColouring μ ∘ colourShift y := by
    filter_upwards [factorColouring_shift_ae μ y] with c hc
    exact hc.symm
  rw [Measure.map_map (g := fun (c : unitRing F → Fin 4) x => c (x + y)) (measurable_colourShift y)
    (measurable_factorColouring μ), Measure.map_congr hae,
    ← Measure.map_map (measurable_factorColouring μ) (measurable_colourShift y)]
  exact congrArg (Measure.map (factorColouring μ)) (μ.shift_inv y)

theorem factorLaw_rot_inv [NumberField F] (μ : InvariantColouring F) (u : unitVectors F) :
    (μ.μ.map (factorColouring μ)).map (fun c x => c (uvRing u * x)) = μ.μ.map (factorColouring μ) := by
  have hae : (fun (c : unitRing F → Fin 4) x => c (uvRing u * x)) ∘ factorColouring μ =ᵐ[μ.μ]
      factorColouring μ ∘ colourRot u := by
    filter_upwards [factorColouring_rot_ae μ u] with c hc
    exact hc.symm
  rw [Measure.map_map (g := fun (c : unitRing F → Fin 4) x => c (uvRing u * x)) (measurable_colourRot u)
    (measurable_factorColouring μ), Measure.map_congr hae,
    ← Measure.map_map (measurable_factorColouring μ) (measurable_colourRot u)]
  exact congrArg (Measure.map (factorColouring μ)) (μ.rot_inv u)

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
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  have hκ : ∀ x, Measurable fun c => factorColouring μ c x := fun x =>
    (measurable_factorColouring_apply μ x).mono (factorSigma_le _ _ _) le_rfl
  have hequiv : ∀ y, ∀ᵐ c ∂μ.μ, factorColouring μ (colourShift y c) 0 = factorColouring μ c y := by
    intro y
    filter_upwards [factorColouring_shift_ae μ y] with c hc
    rw [hc]
    simp [colourShift]
  have hex : ∀ j : Fin 4, ∃ σj : Measure (Dual F), IsSpectralMeasureOf colourShift μ.measurePreserving_shift
      (colourInd μ.μ (fun c => factorColouring μ c 0) (hκ 0) j) σj := fun j =>
    exists_isSpectralMeasureOf colourShift μ.measurePreserving_shift colourShift_add _
  choose σc hσc using hex
  have H := trace_decomp μ.μ colourShift μ.measurePreserving_shift (factorColouring μ) hκ hequiv hσ' hσc
  -- each `e″_j = 1{c′(0) = j}` is `𝒜`-measurable, so continuous, so its spectral measure is null off `T + A`
  have hnull : ∀ j, σc j (TA F)ᶜ = 0 := by
    intro j
    have hmem : colourInd μ.μ (fun c => factorColouring μ c 0) (hκ 0) j ∈
        contVec colourShift μ.measurePreserving_shift (@nhds _ (tauPrime F) 0) := by
      rw [contVec_eq_lpMeas]
      exact mem_lpMeas_indicatorConstLp (factorSigma_le _ _ _)
        ((measurable_factorColouring_apply μ 0) (measurableSet_singleton j)) (measure_ne_top _ _)
    have h := (spectral_carried_iff (tauPrime F) (isTopologicalAddGroup_tauPrime F)
      (isCountablyGenerated_nhds_tauPrime F) (bochnerOn_tauPrime F) colourShift μ.measurePreserving_shift
      colourShift_add (hσc j)).mpr hmem
    rwa [contChars_tauPrime] at h
  have hA : MeasurableSet (TA F)ᶜ := (measurableSet_TA F).compl
  have h := congrArg (fun ν : Measure (Dual F) => ν (TA F)ᶜ) H
  simp only [Measure.add_apply, Measure.smul_apply, Measure.finsetSum_apply, hnull, Finset.sum_const_zero,
    smul_zero] at h
  rw [Measure.dirac_apply' _ hA, Set.indicator_of_notMem (by simpa using one_mem_TA F), add_zero, nsmul_eq_mul,
    mul_eq_zero] at h
  exact h.resolve_left (by norm_num)

/-! ### A⁺ -/

/-- **Equality at the unit vectors from equality at `1`**: if the mean of `Re χ(1)` off `T + A` is not negative, it is `0`
at every unit vector (remark (ii)), so every `E[p_j(0) p_j(u)]`, being `≥ 0` with sum `0`, is `0` (SI-3). -/
theorem equalAtUnits_of_not_neg [NumberField F] (μ : InvariantColouring F) {σ : Measure (Dual F)}
    (hσ : IsTraceSpectral F μ.μ σ) (h : ¬ ∫ χ in (TA F)ᶜ, (χ 1 : ℂ).re ∂σ < 0) : EqualAtUnits μ := by
  intro u j
  have h1 : 0 ≤ ∫ χ in (TA F)ᶜ, (χ 1 : ℂ).re ∂σ := not_lt.mp h
  have h0 : ∫ χ in (TA F)ᶜ, (χ (uvRing u) : ℂ).re ∂σ = 0 :=
    le_antisymm (setIntegral_compl_TA_re_nonpos μ hσ u) (by rw [setIntegral_compl_TA_rot μ hσ u]; exact h1)
  rw [setIntegral_compl_TA_re μ hσ u] at h0
  have hsum : ∑ k : Fin 4, ∫ c, condLaw (colourFactor μ) μ.μ (fun c => c) 0 k c *
      condLaw (colourFactor μ) μ.μ (fun c => c) (uvRing u) k c ∂μ.μ = 0 := by
    linarith
  exact (Finset.sum_eq_zero_iff_of_nonneg fun k _ => integral_condLaw_mul_nonneg μ 0 (uvRing u) k).mp hsum j
    (Finset.mem_univ j)

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
theorem numberField_bot : NumberField (⊥ : Subfield ℝ) :=
  UpperHalf.numberField_bot

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
