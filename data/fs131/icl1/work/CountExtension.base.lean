import Proofs.HadwigerNelson.Rigidity.CountCompletion
import Proofs.HadwigerNelson.Plane.UnitPairs

/-!
# The count's extension: spectrum on `T + A` gives a measurable colouring of the completion, proper almost everywhere (FS-131, job FS131-K12A; module M12, block E; skeleton)

**Read aloud, against the derivation** (R88-TC-ext = J28V-1; J28D § 3.2 C1–C3). For an invariant random proper
four-colouring `μ` of `Cay(R, U)` whose trace spectral measure `σ` is carried by `T + A`:

* `measure_ne_eq` — `P(c(0) ≠ c(y)) = 3(1 − C(y))/4` (the tetrahedral reading of the correlation).
* `comap_ιG_le_nhds_tauPrime` — **the completion's topology on `R` is finer than `τ′_∅`**: a neighbourhood of `0` in `τ′_∅`
  contains the trace of a neighbourhood of `0` in `G_∅` (Lemma C (d), `exists_mem_nsmul_of_resR_eq_zero`, for the
  profinite part; the same embedding for the archimedean one).
* `tendsto_measure_ne` — **C1, continuity in probability**: `P(c(0) ≠ c(y)) → 0` as `ιG y → 0` — dominated convergence, every
  character of `T + A` being `τ′_∅`-continuous (`Rigidity.TA_subset_contChars`, module M10). No Bochner.
* `exists_extension` — **C2–C3 without Doob–Cohn**: a jointly measurable random colouring `f c g` of `G_∅` with
  `P(f c g = f c (g + t)) = 0` for every `g` and every `t` in the closure of `U`. Route: measurable approximants
  `π_n g ∈ R` (`ιG (π_n g)` in the `n`-th neighbourhood of `g`, the first in an enumeration of `R`, `measurable_find`) along
  neighbourhoods on which `P(c(0) ≠ c(y)) ≤ 2^{−n}`; the increments are summable, so by Borel–Cantelli
  (`measure_limsup_atTop_eq_zero`) `c(π_n g)` is almost surely eventually constant, and `f` is its eventual value. For an
  edge `t`: pick `u ∈ U` with `ιG u` within the `n`-th neighbourhood of `t`; `P(c(a) = c(b)) ≤ P(c(a) = c(a + u)) +
  P(c(0) ≠ c(b − a − u)) ≤ 0 + 2^{−n}`.
* `exists_slice` — **the slice `Δ × K`**: some sample gives a measurable `φ : ℂ × K → Fin 4` whose monochromatic edges
  `(z, x) ~ (z + e^{iθ}, x + ιK u)` are null for every unit vector `u` (Tonelli over the sample; `R` is countable).

**Models.** None of these statements assumes `TCA F`, and their hypotheses hold at `F = ℚ`: there `R/(1 + i)R = 𝔽₂`, every
unit vector is `≡ 1` modulo `(1 + i)`, so the residue two-colouring `c(x) = x mod (1 + i)`, shifted by a uniform element of
`𝔽₂`, is an `InvariantColouring` whose trace spectral measure sits on the two characters through `𝔽₂` — torsion, so in
`T + A`. (`TCA ℚ` fails at the ramified prime `(1 + i)`, ratio `1/2`; the count's contradiction is
`Counting.false_of_slice`, which reads `TCA F`.) The kernel model is owed by the implementer of this module.
-/

namespace HadwigerNelson.Rigidity.Counting

open SpectralChain NumberField MeasureTheory Filter Topology Plane

noncomputable section

variable {F : Subfield ℝ} [NumberField F]

theorem measure_ne_eq (μ : InvariantColouring F) (y : unitRing F) :
    (μ.μ {c | c 0 ≠ c y}).toReal = 3 / 4 * (1 - corr F μ.μ y) := by
  sorry

variable (F) in
theorem comap_ιG_le_nhds_tauPrime : comap (ιG F) (𝓝 0) ≤ @nhds (unitRing F) (tauPrime F) 0 := by
  sorry

/-- **C1**: spectrum on `T + A` is continuity in probability along the completion. -/
theorem tendsto_measure_ne (μ : InvariantColouring F) {σ : Measure (Dual F)} (hσ : IsTraceSpectral F μ.μ σ)
    (hTA : σ (TA F)ᶜ = 0) : Tendsto (fun y => μ.μ {c | c 0 ≠ c y}) (comap (ιG F) (𝓝 0)) (𝓝 0) := by
  sorry

/-- **C2–C3**: a jointly measurable random colouring of the completion, almost surely proper at each edge of the closure of
`U`. -/
theorem exists_extension (μ : InvariantColouring F) {σ : Measure (Dual F)} (hσ : IsTraceSpectral F μ.μ σ)
    (hTA : σ (TA F)ᶜ = 0) :
    ∃ f : (unitRing F → Fin 4) → G F → Fin 4, Measurable (Function.uncurry f) ∧
      ∀ g t, t ∈ closure (ιG F '' unitVectorsR F) → μ.μ {c | f c g = f c (g + t)} = 0 := by
  sorry

/-- **The monochromatic edges of a slice colouring are null at every unit vector**: the edges
`(z, x) ~ (z + e^{iθ}, x + ιK u)` of `UD(ℝ²) ⊗ Cay(K, U)`. -/
def SliceEdgeNull (φ : ℂ × K F → Fin 4) : Prop :=
  ∀ u ∈ unitVectorsR F, ((volume.prod (haarK F)).prod arcLength) {p | φ p.1 = φ (p.1.1 + e p.2, p.1.2 + ιK F u)} = 0

/-- **The slice `Δ × K`**: a measurable four-colouring of `ℂ × K` whose monochromatic edges are null at every unit vector. -/
theorem exists_slice (μ : InvariantColouring F) {σ : Measure (Dual F)} (hσ : IsTraceSpectral F μ.μ σ)
    (hTA : σ (TA F)ᶜ = 0) : ∃ φ : ℂ × K F → Fin 4, Measurable φ ∧ SliceEdgeNull φ := by
  sorry

end

end HadwigerNelson.Rigidity.Counting
