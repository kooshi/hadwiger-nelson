import Proofs.HadwigerNelson.Rigidity.Pieces
import Proofs.HadwigerNelson.Rigidity.HaarMultiple
import Proofs.HadwigerNelson.Rigidity.ChainAtTA
import Mathlib.Probability.Kernel.Condexp
import Mathlib.MeasureTheory.MeasurableSpace.Invariants
import Proofs.HadwigerNelson.Outside.OAI015ErgodicDecomposition

/-!
# The entropy split by the largest Haar multiple (FS-131, job FS131-KN8; module M7b; skeleton)

**Read aloud, against the informal claim** (`plans/FS131-EN2-derivation.md` § 5.2, EN2-PE2-MAX: "For every real number field
`F` and every `U`-invariant finite positive measure `τ` on `R̂`, the set of reals `c ≥ 0` with `c·m ≤ τ` has a largest element
`a`, and `τ − a·m` is a positive `U`-invariant measure with `h_{τ − a·m}(u) = 0` for every `u ∈ U`"), at the strength the
chain reads (`Rigidity.EntropySplit`: entropy zero at **one** non-torsion rotation, FS131-KN7). The deriver's three steps:

1. **The largest Haar multiple** `a = maxMultiple τ m` (`Rigidity/HaarMultiple`, M7a); the remainder `τ − a·m` is
   rotation invariant (`rotInv_sub_maxMultiple`) and carries no positive multiple of `m`.
2. **The Haar set of the kernel is null** (`measure_haarSet_eq_zero`): for a probability `ν` invariant under an admissible
   `Γ` with no positive Haar multiple below it, and `κ` the conditional-expectation kernel of `ν` on the `Γ`-invariant
   σ-algebra, the set of `x` at which every Fourier coefficient off `0` of `κ x` vanishes is `ν`-null — over Fourier
   uniqueness (`Rigidity.measure_eq_of_fourier`) and the defining property of conditional expectation on that set.
3. **Entropy zero** (`ksEntropy_eq_zero_of_not_smul_le`): almost every `κ x` is `Γ`-ergodic (the release's decomposition,
   `condExpKernel_ergodicDecomposition`) and not Haar (step 2), so Lemma Γ gives it entropy zero at every rotation in `Γ`, and
   the mixture lemma (`Rigidity.ksEntropy_bind_eq_zero`) gives `ν` entropy zero there.

Then **the split** (`entropySplit_of_admissiblePair`): `τ = a·m + b·ρ` with `ρ` the normalised remainder (or the point mass
at the trivial character when the remainder is `0`, `Rigidity.ksEntropy_dirac`), the rotation the first generator of the
pair (`AdmissiblePair.u_nonTorsion`). With `Rigidity.exists_admissiblePair` it is the chain's leaf `Rigidity.entropySplit`,
which moved from `Rigidity/ChainAtTA` (upstream of this module) to `Rigidity/ZeroEntropyClosed` at the chain's join and is
proved there as `entropySplit_of_admissiblePair (exists_admissiblePair (F := F)).some` (FS131-IJN1).

**The release's decomposition enters as a leaf under a name of its own** (`LEAN.md` § Searching: no lemma under one name in
two modules): `condExpKernel_ergodicDecomposition` is `PrimeDegreePackets.action_ergodic_decomposition`
(`[OAIMath2026]`, `PrimePackets/ErgodicDecomposition.lean` ll. 127–134) with the release's `actionInvariantSigma` unfolded
to its body (`KernelEntropy.lean` l. 279, here `invariantSigma`), proved by the port (lane P2, FS131-IP23).

**Models.** Step 2's and step 3's hypotheses — a `Γ`-invariant probability carrying no positive multiple of Haar measure —
are met by the point mass at the trivial character (`not_smul_dualHaar_le_dirac_one`), given an admissible pair
(`Rigidity.exists_admissiblePair`). The split's hypotheses (a finite rotation-invariant measure) are met by `dualHaar` and by
the point mass.
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory ProbabilityTheory SpectralChain SpectralInputs

open scoped ENNReal

noncomputable section

/-- **The σ-algebra of the sets fixed by every `g • ·`** — the release's `actionInvariantSigma` (`[OAIMath2026]`,
`PrimePackets/KernelEntropy.lean` l. 278), its body word for word. -/
@[reducible] def invariantSigma (H Y : Type*) [Group H] [MulAction H Y] [MeasurableSpace Y] : MeasurableSpace Y :=
  ⨅ g : H, MeasurableSpace.invariants (fun y : Y => g • y)

theorem invariantSigma_le (H Y : Type*) [Group H] [MulAction H Y] [mY : MeasurableSpace Y] : invariantSigma H Y ≤ mY :=
  (iInf_le _ (1 : H)).trans (MeasurableSpace.invariants_le _)

/-- **T1, the ergodic decomposition in canonical form** (FS100-X02D l. 171; `[OAIMath2026]`'s
`PrimeDegreePackets.action_ergodic_decomposition`, `PrimePackets/ErgodicDecomposition.lean` ll. 127–134, with
`actionInvariantSigma` unfolded): for a countable group acting on a standard Borel space and an invariant probability `μ`,
the conditional-expectation kernel of `μ` on the invariant σ-algebra integrates to `μ`, and almost every value is ergodic.
**Proved by the port** (lane P2, FS131-IP23): the release's theorem, `Outside.OAI015.action_ergodic_decomposition`,
is its proof, `actionInvariantSigma` being `invariantSigma` by its body. -/
theorem condExpKernel_ergodicDecomposition {H Y : Type*} [Group H] [Countable H] [MulAction H Y] [MeasurableSpace Y]
    [StandardBorelSpace Y] [Nonempty Y] (μ : Measure Y) [IsProbabilityMeasure μ]
    (hp : ∀ g : H, MeasurePreserving (fun y : Y => g • y) μ μ) :
    condExpKernel μ (invariantSigma H Y) ∘ₘ μ.trim (invariantSigma_le H Y) = μ ∧
      ∀ᵐ x ∂μ.trim (invariantSigma_le H Y), ErgodicSMul H Y (condExpKernel μ (invariantSigma H Y) x) :=
  -- the release's `actionInvariantSigma H Y` is `invariantSigma H Y` by its body, so the two statements are one term up
  -- to unfolding it
  Outside.OAI015.action_ergodic_decomposition μ hp

variable {F : Subfield ℝ}

/-- **Step 1's invariance** (EN2-PE2-MAX step 1: "`U`-invariant because `τ` and `m` are"): the remainder after the largest
Haar multiple is rotation invariant — `Rigidity.map_sub_maxMultiple` at each rotation as a measurable equivalence
(`MeasurableEquiv.smul g`), with `IsHaarFourier.rotInv`. -/
theorem rotInv_sub_maxMultiple [NumberField F] (τ : Measure (Dual F)) [IsFiniteMeasure τ] (hτ : RotInv F τ)
    {m : Measure (Dual F)} (hm : IsHaarFourier m) : RotInv F (τ - maxMultiple τ m • m) := by
  haveI := hm.1
  exact rotInv_iff.2 fun g => map_sub_maxMultiple τ m (MeasurableEquiv.smul g) (rotInv_iff.1 hτ g)
    (rotInv_iff.1 hm.rotInv g)

/-- **The Haar set of a family of measures** (a kernel, read as a function): the points at which every Fourier coefficient
off `0` vanishes. -/
def haarSet (κ : Dual F → Measure (Dual F)) : Set (Dual F) :=
  {x | ∀ r : unitRing F, r ≠ 0 → ∫ χ, (χ r : ℂ) ∂(κ x) = 0}

/-- (i) of step 2: the Haar set of the conditional-expectation kernel is measurable for the invariant σ-algebra (a
countable intersection of zero sets of `x ↦ ∫ χ(r) dκ x`, each measurable for the kernel's source σ-algebra). -/
private theorem measurableSet_haarSet [NumberField F] (H : Type*) [Group H] [MulAction H (Dual F)]
    (ν : Measure (Dual F)) [IsProbabilityMeasure ν] :
    MeasurableSet[invariantSigma H (Dual F)] (haarSet ⇑(condExpKernel ν (invariantSigma H (Dual F)))) := by
  have hset : haarSet ⇑(condExpKernel ν (invariantSigma H (Dual F))) =
      ⋂ r : unitRing F, {x | r ≠ 0 → ∫ χ, (χ r : ℂ) ∂(condExpKernel ν (invariantSigma H (Dual F)) x) = 0} := by
    ext x
    simp only [haarSet, Set.mem_setOf_eq, Set.mem_iInter]
  rw [hset]
  refine MeasurableSet.iInter fun r => ?_
  by_cases hr : r = 0
  · simp only [hr, ne_eq, not_true_eq_false, false_implies, Set.setOf_true, MeasurableSet.univ]
  · simp only [ne_eq, hr, not_false_eq_true, true_implies]
    have hmeas := (measurable_evalChar (G := unitRing F) r).stronglyMeasurable.integral_condExpKernel
      (μ := ν) (m := invariantSigma H (Dual F))
    exact measurableSet_eq_fun hmeas.measurable measurable_const

/-- **Step 2: the Haar set of the kernel is null** (EN2-PE2-MAX step 2), for the conditional-expectation kernel on the
invariant σ-algebra of **any** group action on `Dual F` — the argument reads neither the invariance of `ν` nor which action
it is (FS131-KN8's obligation pass; step 3 takes the rotations by `Γ`). `A := haarSet κ` is measurable for the invariant
σ-algebra (`R` is countable; `κ` is measurable for it); `ν|_A` has coefficient `ν(A)` at `0` and, by the defining property of
conditional expectation on `A`, `0` off it; by Fourier uniqueness `ν|_A = ν(A)·m`, so `ν(A)·m ≤ ν`, and `ν(A) = 0`. -/
theorem measure_haarSet_eq_zero [NumberField F] (H : Type*) [Group H] [MulAction H (Dual F)] (ν : Measure (Dual F))
    [IsProbabilityMeasure ν] {m : Measure (Dual F)} (hm : IsHaarFourier m) (hnone : ∀ c : ℝ≥0∞, c ≠ 0 → ¬ c • m ≤ ν) :
    ν (haarSet ⇑(condExpKernel ν (invariantSigma H (Dual F)))) = 0 := by
  haveI := hm.1
  have hmI := invariantSigma_le H (Dual F)
  set A := haarSet ⇑(condExpKernel ν (invariantSigma H (Dual F))) with hAdef
  have hA : MeasurableSet[invariantSigma H (Dual F)] A := measurableSet_haarSet H ν
  have hA' : MeasurableSet A := hmI _ hA
  have hint : ∀ r : unitRing F, Integrable (fun χ : Dual F => (χ r : ℂ)) ν := fun r =>
    Integrable.of_bound (measurable_evalChar r).aestronglyMeasurable 1
      (Filter.Eventually.of_forall fun χ => by rw [Circle.norm_coe])
  -- (ii) the coefficients of `ν` on `A` vanish off `0`
  have hzero : ∀ r : unitRing F, r ≠ 0 → ∫ χ in A, (χ r : ℂ) ∂ν = 0 := by
    intro r hr
    rw [← setIntegral_condExp hmI (hint r) hA]
    rw [setIntegral_congr_ae hA' ((condExp_ae_eq_integral_condExpKernel hmI (hint r)).mono fun x hx _ => hx)]
    exact setIntegral_eq_zero_of_forall_eq_zero fun x hx => hx r hr
  -- (iii) so `ν` restricted to `A` is `ν(A)` times Haar measure (Fourier uniqueness)
  haveI : IsFiniteMeasure (ν A • m) :=
    ⟨by rw [Measure.smul_apply, smul_eq_mul]; exact ENNReal.mul_lt_top (measure_lt_top _ _) (measure_lt_top _ _)⟩
  have hfour : ν.restrict A = ν A • m := by
    refine measure_eq_of_fourier fun r => ?_
    by_cases hr : r = 0
    · subst hr
      simp [AddChar.map_zero_eq_one, Measure.real]
    · rw [hzero r hr, integral_smul_measure, hm.2 r hr, smul_zero]
  -- (iv) and no positive multiple of Haar measure is below `ν`
  by_contra hA0
  exact hnone (ν A) hA0 (hfour ▸ Measure.restrict_le_self)

/-- **Step 3: entropy zero** (EN2-PE2-MAX step 3): a probability invariant under an admissible `Γ` and carrying no
positive Haar multiple has entropy zero at every rotation in `Γ`. Over `condExpKernel_ergodicDecomposition` at `H = Γ`,
step 2, Lemma Γ (`isHaarFourier_or_ksEntropy_eq_zero`) at almost every `κ x`, and the mixture lemma. -/
theorem ksEntropy_eq_zero_of_not_smul_le [NumberField F] (p : AdmissiblePair F) (ν : Measure (Dual F))
    [IsProbabilityMeasure ν] (hinv : ∀ g : p.subgroup, MeasurePreserving (fun χ : Dual F => g • χ) ν ν)
    {m : Measure (Dual F)} (hm : IsHaarFourier m) (hnone : ∀ c : ℝ≥0∞, c ≠ 0 → ¬ c • m ≤ ν) :
    ∀ g ∈ p.subgroup, ksEntropy ν (rot (toUnitVector g)) = 0 := by
  intro g hg
  haveI := hm.1
  have hmI := invariantSigma_le p.subgroup (Dual F)
  obtain ⟨hbind, herg⟩ := condExpKernel_ergodicDecomposition (H := p.subgroup) ν hinv
  have hA := measurableSet_haarSet p.subgroup ν
  have htrim : ν.trim hmI (haarSet ⇑(condExpKernel ν (invariantSigma p.subgroup (Dual F)))) = 0 := by
    rw [trim_measurableSet_eq hmI hA]
    exact measure_haarSet_eq_zero p.subgroup ν hm hnone
  haveI : IsProbabilityMeasure (ν.trim hmI) :=
    ⟨by rw [trim_measurableSet_eq hmI MeasurableSet.univ, measure_univ]⟩
  rw [← hbind]
  refine @ksEntropy_bind_eq_zero _ (Dual F) (invariantSigma p.subgroup (Dual F)) _ (ν.trim hmI) _
    (condExpKernel ν (invariantSigma p.subgroup (Dual F))) _ (rot (toUnitVector g)) (measurable_rot _) ?_ ?_
  · filter_upwards [herg] with x hx
    exact measurePreserving_smul (⟨g, hg⟩ : p.subgroup) _
  · filter_upwards [herg, measure_eq_zero_iff_ae_notMem.1 htrim] with x hx hxA
    rcases isHaarFourier_or_ksEntropy_eq_zero p _ hx with h1 | h1
    · exact absurd (fun r hr => h1.2 r hr) hxA
    · exact h1 g hg

/-- **The split, from one admissible pair** (EN2-PE2-MAX at the chain's strength; FS131-KN7 § 6.3 (d)): `a := maxMultiple τ m`
for `m := dualHaar`; if the remainder is `0`, `b = 0` and `ρ` the point mass at the trivial character; otherwise `b` its mass
and `ρ` the normalised remainder, which carries no positive Haar multiple (a multiple `c` below `ρ` is `b·c` below the
remainder, `Rigidity.not_smul_le_sub_maxMultiple`) and is `Γ`-invariant (it is rotation invariant), so step 3 gives entropy
zero at the rotation by the pair's first generator, which is not a root of unity. -/
theorem entropySplit_of_admissiblePair [NumberField F] (p : AdmissiblePair F) : EntropySplit F := by
  intro τ hfin hτ
  have hm : IsHaarFourier (dualHaar (unitRing F)) := isHaarFourier_dualHaar (unitRing F)
  haveI := hm.1
  set m := dualHaar (unitRing F) with hmdef
  set a := maxMultiple τ m with ha
  set τ' := τ - a • m with hτ'def
  have hτ' : RotInv F τ' := rotInv_sub_maxMultiple τ hτ hm
  have hsplit : τ = a • m + τ' := by
    rw [add_comm]
    exact (sub_maxMultiple_add τ m).symm
  have hu := p.u_nonTorsion
  have hmem : p.u ∈ p.subgroup := (p.mem_subgroup).2 ⟨![1, 0], by
    show p.u ^ ((![(1 : ℤ), 0] : Fin 2 → ℤ) 0) * p.w ^ ((![(1 : ℤ), 0] : Fin 2 → ℤ) 1) = p.u
    simp⟩
  by_cases h0 : τ' = 0
  · refine ⟨a, 0, m, Measure.dirac 1, hm, inferInstance, fun u => ?_,
      ⟨toUnitVector p.u, hu, ksEntropy_dirac (measurable_rot _) 1⟩, ?_⟩
    · rw [Measure.map_dirac' (measurable_rot u)]
      congr 1
    · rw [zero_smul, add_zero, ← add_zero (a • m), hsplit, h0]
  · haveI : IsFiniteMeasure τ' := isFiniteMeasure_of_le τ Measure.sub_le
    set b := τ' Set.univ with hb
    have hb0 : b ≠ 0 := by rwa [hb, Ne, Measure.measure_univ_eq_zero]
    have hbt : b ≠ ⊤ := measure_ne_top _ _
    set ρ := b⁻¹ • τ' with hρ
    haveI : IsProbabilityMeasure ρ :=
      ⟨by rw [hρ, Measure.smul_apply, smul_eq_mul, ← hb, ENNReal.inv_mul_cancel hb0 hbt]⟩
    have hρrot : RotInv F ρ := fun u => by rw [hρ, Measure.map_smul, hτ' u]
    have hbρ : b • ρ = τ' := by rw [hρ, smul_smul, ENNReal.mul_inv_cancel hb0 hbt, one_smul]
    have hnone : ∀ c : ℝ≥0∞, c ≠ 0 → ¬ c • m ≤ ρ := by
      intro c hc hle
      refine not_smul_le_sub_maxMultiple τ m (mul_ne_zero hb0 hc) ?_
      rw [← hτ'def, ← hbρ, mul_smul]
      exact Measure.le_iff.2 fun s hs => by
        have h1 := Measure.le_iff.1 hle s hs
        simp only [Measure.smul_apply, smul_eq_mul] at h1 ⊢
        gcongr
    have hinv : ∀ g : p.subgroup, MeasurePreserving (fun χ : Dual F => g • χ) ρ ρ := fun g =>
      ⟨measurable_rot (toUnitVector (g : unitCircle F)), rotInv_iff.1 hρrot g⟩
    refine ⟨a, b, m, ρ, hm, inferInstance, hρrot,
      ⟨toUnitVector p.u, hu, ksEntropy_eq_zero_of_not_smul_le p ρ hinv hm hnone p.u hmem⟩, ?_⟩
    rw [hbρ]
    exact hsplit

/-- **The model of steps 2 and 3**: the point mass at the trivial character carries no positive multiple of Haar measure
(Haar gives the complement of the point mass `1`, since a non-trivial character exists; the point mass gives it `0`). -/
theorem not_smul_dualHaar_le_dirac_one [NumberField F] :
    ∀ c : ℝ≥0∞, c ≠ 0 → ¬ c • dualHaar (unitRing F) ≤ Measure.dirac (1 : Dual F) := by
  intro c hc hle
  have hm : IsHaarFourier (dualHaar (unitRing F)) := isHaarFourier_dualHaar (unitRing F)
  have hs : MeasurableSet ({1}ᶜ : Set (Dual F)) := (measurableSet_singleton 1).compl
  have h1 := Measure.le_iff.1 hle _ hs
  rw [Measure.smul_apply, smul_eq_mul, Measure.dirac_apply' _ hs,
    Set.indicator_of_notMem (by simp : (1 : Dual F) ∉ ({1}ᶜ : Set (Dual F)))] at h1
  have hnull : dualHaar (unitRing F) ({1}ᶜ : Set (Dual F)) = 0 := by
    rcases mul_eq_zero.1 (nonpos_iff_eq_zero.1 h1) with h | h
    · exact absurd h hc
    · exact h
  -- then the coefficient at `1 ≠ 0` would be `1`
  have hae : ∀ᵐ χ ∂(dualHaar (unitRing F)), χ ∈ ({1} : Set (Dual F)) := by
    have := measure_eq_zero_iff_ae_notMem.1 hnull
    filter_upwards [this] with χ hχ
    simpa using hχ
  have hcoef : ∫ χ, (χ (1 : unitRing F) : ℂ) ∂(dualHaar (unitRing F)) = 1 := by
    have hae' : (fun χ : Dual F => (χ (1 : unitRing F) : ℂ)) =ᵐ[dualHaar (unitRing F)] fun _ => (1 : ℂ) :=
      hae.mono fun χ hχ => by
        rw [Set.mem_singleton_iff.1 hχ]
        simp
    rw [integral_congr_ae hae']
    simp
  rw [hm.2 1 one_ne_zero] at hcoef
  exact zero_ne_one hcoef

end

end HadwigerNelson.Rigidity
