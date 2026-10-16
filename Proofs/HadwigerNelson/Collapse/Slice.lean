import Proofs.HadwigerNelson.Collapse.Dichotomy
import Proofs.HadwigerNelson.Rigidity.CountExtension

/-!
# Spectrum on `T + A` gives a measurable `k`-colouring of the slice `Δ × K` (FS-131, job FS131-KCL1; module C4)

**Read aloud, against the informal claim** (V1-L4, L5, L8, `plans/FS103-V1-verification.md` ll. 125–142; V2 L1 (b), L2, L-WA,
L4). An invariant random proper `k`-colouring of `Cay(R, U)` whose colour spectral measure is carried by `T + A` is continuous
in probability for the completion's topology (`tendsto_measure_ne_k`), so it extends to a jointly measurable random colouring
of the completion `G = (L ⊗ ℝ) × K` whose edges `(g, g + t)`, `t` in the closure of the unit vectors, are almost surely
bichromatic (`exists_extension_k`); a sample, read on the plane `Δ ⊂ L ⊗ ℝ` (`Rigidity.Counting.Delta`), is a measurable
colouring of `ℂ × K` with null monochromatic edges `(z, x) ~ (z + e^{iθ}, x + ιK u)` at every unit vector `u`
(`exists_slice_k`). This is the four-colour `Rigidity/CountExtension` at `Fin k`.

**What the slice replaces.** The derivation's strong approximation (V1-L4) is the completion's definition (the closure of
`R`, `Rigidity.Counting.Kgrp`); its weak approximation and diagonal merge (V1-L8; V2 L-WA, L4) are the one plane `Δ` and
`Rigidity.Counting.mem_closure_ιG`, at every number field, totally real or not; its measurable version (Doob–Cohn; V2-MV) is
`exists_extension`'s Borel–Cantelli route.

**`exists_slice_of_colorable`** composes the line so far: a proper `k`-colouring of `F²` gives such a slice colouring, over
every real number field — on `Rigidity.mrPlus` (the dichotomy) and nothing else beyond the standard three axioms.

**Models.** Over `ℚ` at `k = 2`: the residue colouring at the ramified prime above `2`, randomly translated, is an invariant
colouring with torsion spectrum, so in `T + A` (the four-colour module's model, `Rigidity/CountExtension`).
-/

namespace HadwigerNelson.Collapse

open SpectralChain SpectralInputs MeasureTheory NumberField Rigidity Rigidity.Counting Filter Topology Plane

noncomputable section

variable {F : Subfield ℝ} [NumberField F] {k : ℕ}

/-- **The disagreement is the colour spectral measure's defect**: `P(c(0) ≠ c(y)) = 1 − Re ∫ χ(y) dσ` (the four-colour
`measure_ne_eq`, here with no tetrahedral constant: `σ(R̂) = P(c(0) = c(0)) = 1`). -/
theorem measure_ne_eq_k (μ : InvColouring F k) {σ : Measure (Dual F)} (hσ : IsColourSpectral μ.μ σ) (y : unitRing F) :
    (μ.μ {c | c 0 ≠ c y}).toReal = 1 - (∫ χ, (χ y : ℂ) ∂σ).re := by
  sorry

/-- **C1, continuity in probability** at `k` colours: with spectrum on `T + A`, `P(c(0) ≠ c(y)) → 0` as `ιG y → 0`. -/
theorem tendsto_measure_ne_k (μ : InvColouring F k) {σ : Measure (Dual F)} (hσ : IsColourSpectral μ.μ σ)
    (hTA : σ (TA F)ᶜ = 0) : Tendsto (fun y => μ.μ {c | c 0 ≠ c y}) (comap (ιG F) (𝓝 0)) (𝓝 0) := by
  sorry

/-- **C2–C3 at `k` colours**: a jointly measurable random colouring of the completion, almost surely bichromatic on every
edge `(g, g + t)` with `t` in the closure of the unit vectors (the four-colour `Rigidity.Counting.exists_extension`). -/
theorem exists_extension_k (μ : InvColouring F k) {σ : Measure (Dual F)} (hσ : IsColourSpectral μ.μ σ)
    (hTA : σ (TA F)ᶜ = 0) :
    ∃ f : (unitRing F → Fin k) → G F → Fin k, Measurable (Function.uncurry f) ∧
      ∀ g t, t ∈ closure (ιG F '' unitVectorsR F) → μ.μ {c | f c g = f c (g + t)} = 0 := by
  sorry

variable (F) in
/-- **The monochromatic edges of a slice `k`-colouring are null at every unit vector**: the edges
`(z, x) ~ (z + e^{iθ}, x + ιK u)` of `UD(ℝ²) ⊗ Cay(K, U)` (the four-colour `Rigidity.Counting.SliceEdgeNull` at `Fin k`). -/
def SliceEdgeNullK (φ : ℂ × K F → Fin k) : Prop :=
  ∀ u ∈ unitVectorsR F, ((volume.prod (haarK F)).prod arcLength) {p | φ p.1 = φ (p.1.1 + e p.2, p.1.2 + ιK F u)} = 0

/-- **The slice `Δ × K` at `k` colours**: some sample gives a measurable `k`-colouring of `ℂ × K` whose monochromatic edges
are null at every unit vector (Tonelli over the sample; `R` is countable). -/
theorem exists_slice_k (μ : InvColouring F k) {σ : Measure (Dual F)} (hσ : IsColourSpectral μ.μ σ)
    (hTA : σ (TA F)ᶜ = 0) : ∃ φ : ℂ × K F → Fin k, Measurable φ ∧ SliceEdgeNullK F φ := by
  sorry

/-- **A proper `k`-colouring of `F²` gives a slice colouring** — L0, the dichotomy closed by MR⁺, and the extension. -/
theorem exists_slice_of_colorable (h : ((unitDistance ℂ).induce (planeOver F)).Colorable k) :
    ∃ φ : ℂ × K F → Fin k, Measurable φ ∧ SliceEdgeNullK F φ := by
  obtain ⟨μ⟩ := nonempty_invColouring_of_colorable h
  obtain ⟨μ', hμ'⟩ := exists_invColouring_TA μ
  obtain ⟨σ', hσ'⟩ := exists_isColourSpectral μ'
  exact exists_slice_k μ' hσ' (hμ' σ' hσ')

end

end HadwigerNelson.Collapse
