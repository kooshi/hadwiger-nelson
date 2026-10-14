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
which stays in `Rigidity/ChainAtTA` (upstream of this module) until the landing moves it here or replaces its `sorry` by
`entropySplit_of_admissiblePair _ (exists_admissiblePair _).some`.

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
  sorry

/-- **The Haar set of a family of measures** (a kernel, read as a function): the points at which every Fourier coefficient
off `0` vanishes. -/
def haarSet (κ : Dual F → Measure (Dual F)) : Set (Dual F) :=
  {x | ∀ r : unitRing F, r ≠ 0 → ∫ χ, (χ r : ℂ) ∂(κ x) = 0}

/-- **Step 2: the Haar set of the kernel is null** (EN2-PE2-MAX step 2), for the conditional-expectation kernel on the
invariant σ-algebra of **any** group action on `Dual F` — the argument reads neither the invariance of `ν` nor which action
it is (FS131-KN8's obligation pass; step 3 takes the rotations by `Γ`). `A := haarSet κ` is measurable for the invariant
σ-algebra (`R` is countable; `κ` is measurable for it); `ν|_A` has coefficient `ν(A)` at `0` and, by the defining property of
conditional expectation on `A`, `0` off it; by Fourier uniqueness `ν|_A = ν(A)·m`, so `ν(A)·m ≤ ν`, and `ν(A) = 0`. -/
theorem measure_haarSet_eq_zero [NumberField F] (H : Type*) [Group H] [MulAction H (Dual F)] (ν : Measure (Dual F))
    [IsProbabilityMeasure ν] {m : Measure (Dual F)} (hm : IsHaarFourier m) (hnone : ∀ c : ℝ≥0∞, c ≠ 0 → ¬ c • m ≤ ν) :
    ν (haarSet ⇑(condExpKernel ν (invariantSigma H (Dual F)))) = 0 := by
  sorry

/-- **Step 3: entropy zero** (EN2-PE2-MAX step 3): a probability invariant under an admissible `Γ` and carrying no
positive Haar multiple has entropy zero at every rotation in `Γ`. Over `condExpKernel_ergodicDecomposition` at `H = Γ`,
step 2, Lemma Γ (`isHaarFourier_or_ksEntropy_eq_zero`) at almost every `κ x`, and the mixture lemma. -/
theorem ksEntropy_eq_zero_of_not_smul_le [NumberField F] (p : AdmissiblePair F) (ν : Measure (Dual F))
    [IsProbabilityMeasure ν] (hinv : ∀ g : p.subgroup, MeasurePreserving (fun χ : Dual F => g • χ) ν ν)
    {m : Measure (Dual F)} (hm : IsHaarFourier m) (hnone : ∀ c : ℝ≥0∞, c ≠ 0 → ¬ c • m ≤ ν) :
    ∀ g ∈ p.subgroup, ksEntropy ν (rot (toUnitVector g)) = 0 := by
  sorry

/-- **The split, from one admissible pair** (EN2-PE2-MAX at the chain's strength; FS131-KN7 § 6.3 (d)): `a := maxMultiple τ m`
for `m := dualHaar`; if the remainder is `0`, `b = 0` and `ρ` the point mass at the trivial character; otherwise `b` its mass
and `ρ` the normalised remainder, which carries no positive Haar multiple (a multiple `c` below `ρ` is `b·c` below the
remainder, `Rigidity.not_smul_le_sub_maxMultiple`) and is `Γ`-invariant (it is rotation invariant), so step 3 gives entropy
zero at the rotation by the pair's first generator, which is not a root of unity. -/
theorem entropySplit_of_admissiblePair [NumberField F] (p : AdmissiblePair F) : EntropySplit F := by
  sorry

/-- **The model of steps 2 and 3**: the point mass at the trivial character carries no positive multiple of Haar measure
(Haar gives the complement of the point mass `1`, since a non-trivial character exists; the point mass gives it `0`). -/
theorem not_smul_dualHaar_le_dirac_one [NumberField F] :
    ∀ c : ℝ≥0∞, c ≠ 0 → ¬ c • dualHaar (unitRing F) ≤ Measure.dirac (1 : Dual F) := by
  sorry

end

end HadwigerNelson.Rigidity
