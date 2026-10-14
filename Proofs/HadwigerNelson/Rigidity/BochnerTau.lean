import Proofs.HadwigerNelson.Rigidity.ContinuityGroup
import Proofs.HadwigerNelson.Rigidity.Herglotz

/-!
# Bochner's theorem for the topology `τ′_∅` (FS-131, job FS131-KR1; module M2b; skeleton)

**Read aloud, against the informal claim.** `bochnerOn_tauPrime : BochnerOn (tauPrime F)`: a finite measure on the dual of
`R = ℤ[U_F]` whose Fourier transform is continuous for the profinite-plus-archimedean topology is carried by the continuous
characters, which are `T + A` (`contChars_tauPrime`). It is J45 N2's `⟸` at `S = ∅` (`plans/FS84-SI-D-derivation.md`
ll. 128–130), the hypothesis `SpectralInputs.spectral_carried_iff` takes. The printed source of the step is Bochner's
theorem on a locally compact abelian group (`[Rudin1962]` 1.4.3, not held); this module proves it with no Bochner theorem on
`ℝ^m` and no profinite completion (`plans/FS131-KR1-chain-map.md` § 2.1, M2b).

**Route.** (1) `archimedean_support`: a measure whose transform is continuous for `archTop` is carried by `A` — restrict to
the lattices `5^{−k}c₀𝓞_L ⊆ R`, lift from their dual tori to `V*` through a box fundamental domain, bound the mass far out by
a one-variable Dirichlet-kernel inequality (tightness, uniform in `k`), take a limit by Prokhorov
(`isCompact_closure_of_isTightMeasureSet`), and compare the limit's characteristic function with the transform on the dense
subgroup `ℤ[1/5]c₀𝓞_L`; uniqueness (`measure_eq_of_fourier`) concludes. (2) `finite_quotient_nsmul` (J28V-7, `[LevitzMott1972]`
Thm 2.3): `R ⧸ N·R` is finite. (3) The profinite part: twisted Riemann sums over `R ⧸ N′·R` split `φ` into `Σ_{t ∈ T} ψ_t` with
each `t̄·ψ_t` positive-definite and archimedean-continuous; (1) carries each piece by `t·A`.

**Models.** `F = ⊥`; the point mass at the trivial character has constant transform, continuous for every topology, and is
carried by `TA F` (`one_mem_TA`).
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory SpectralChain SpectralInputs NumberField

noncomputable section

variable (F : Subfield ℝ)

/-- **J28V-7**: `N·R` has finite index in `R = ℤ[U_F]` for every `N ≥ 1` (`R` is torsion-free of rank `[L : ℚ]`). -/
theorem finite_quotient_nsmul [NumberField F] (N : ℕ) (hN : N ≠ 0) :
    Finite (unitRing F ⧸ (nsmulAddMonoidHom (α := unitRing F) N).range) := by
  sorry

/-- **Bochner in support form for the archimedean topology**: a finite measure on `R̂` whose transform is continuous for
`archTop F` is carried by the archimedean characters. -/
theorem archimedean_support [NumberField F] (ρ : Measure (Dual F)) [IsFiniteMeasure ρ]
    (h : @Continuous (unitRing F) ℂ (archTop F) _ fun y => ∫ χ, (χ y : ℂ) ∂ρ) : ρ (archChars (unitRing F))ᶜ = 0 := by
  sorry

/-- **The twisted parts** (the profinite step; the hard leaf of M2b): a finite measure on `R̂` with `τ′_∅`-continuous transform
`φ` has `φ = Σ_{t ∈ T} ψ_t` pointwise, with each `t̄·ψ_t` positive-definite and continuous for `archTop`, and the masses
`ψ_t 0` summable. `ψ_t(y) = lim_{N′} |R ⧸ N′R|⁻¹ Σ_c t̄(x_c) φ(y + x_c)` over arch-small representatives `x_c`. -/
theorem exists_twisted_parts [NumberField F] (σ : Measure (Dual F)) [IsFiniteMeasure σ]
    (h : @Continuous (unitRing F) ℂ (tauPrime F) _ fun y => ∫ χ, (χ y : ℂ) ∂σ) :
    ∃ ψ : torsionChars (unitRing F) → unitRing F → ℂ,
      (∀ t, PosDef fun y => (starRingEnd ℂ) ((t : Dual F) y : ℂ) * ψ t y) ∧
      (∀ t, @Continuous (unitRing F) ℂ (archTop F) _ fun y => (starRingEnd ℂ) ((t : Dual F) y : ℂ) * ψ t y) ∧
      Summable (fun t => (ψ t 0).re) ∧ ∀ y, HasSum (fun t => ψ t y) (∫ χ, (χ y : ℂ) ∂σ) := by
  sorry

/-- **Bochner's theorem for `τ′_∅`** (J45 N2's `⟸` at `S = ∅`): each `t̄·ψ_t` of `exists_twisted_parts` is the transform of a
measure `ρ_t` (`bochnerHerglotz_of_countable`), carried by `A` (`archimedean_support`); `Σ_t (t ·)_* ρ_t` has transform `φ`
and is carried by `T·A`; uniqueness (`measure_eq_of_fourier`) identifies it with `σ`. -/
theorem bochnerOn_tauPrime [NumberField F] : BochnerOn (tauPrime F) := by
  sorry

end

end HadwigerNelson.Rigidity
