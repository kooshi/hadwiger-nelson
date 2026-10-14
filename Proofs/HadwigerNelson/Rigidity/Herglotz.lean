import Proofs.HadwigerNelson.Rigidity.DualGroup

/-!
# Herglotz–Bochner on a countable discrete abelian group, existence half (FS-131, job FS131-KR1; module M2a; skeleton)

**Read aloud, against the informal claim.** Every positive-definite `C : G → ℂ` on a countable abelian group `G` is the
Fourier–Stieltjes transform of a finite positive measure on the dual `Ĝ = AddChar G Circle`, and that measure is unique:
`bochnerHerglotz_of_countable : BochnerHerglotz G` — the library's `Prop` (`SpectralChain.BochnerHerglotz`), whose taker at
`G = unitRing F` is the headline's `hBH`. The printed theorem is `[Rudin1962]` 1.4.3 with 1.3.6 (not held, not read); this
module follows neither: **uniqueness** is `DualGroup.measure_eq_of_fourier` (no Herglotz–Bochner, inventory item 757), and
**existence** is a Fejér construction made here.

**The route (`plans/FS131-KR1-chain-map.md` § 2.1).** (i) `exists_almostInvariant_weights`: finitely supported weights
`w n ≥ 0` with `Σ (w n)² = 1` and `⟨w n, τ_z (w n)⟩ → 1` for every `z` — convolutions of uniform weights on the progressions
`{0, gⱼ, …, (M − 1)gⱼ}`, `j ≤ k`, normalised in `ℓ²`; no structure theorem for finitely generated groups is read.
(ii) `exists_fejer_measures`: the densities `p(χ) = Σ_{x,y} w(x)w(y)C(x − y)χ̄(x − y)`, non-negative because `C` is
positive-definite, times `dualHaar G`, are finite measures of mass `C 0` whose coefficients tend to `C`. (iii)
`exists_fourier_eq_of_tendsto`: on the compact dual, a sequence of measures of bounded mass whose coefficients converge has a
limit point with those coefficients (Prokhorov on a compact space, `isCompact_setOf_finiteMeasure_le_of_compactSpace`).

**Models.** `G` countable is the only hypothesis; `G = ℤ` and the trivial group are its members, and `C = 1` (the
transform of the point mass at the trivial character) is a positive-definite function on each.
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory Filter Topology SpectralChain SpectralInputs

noncomputable section

variable (G : Type*) [AddCommGroup G]

/-- **Almost-invariant weights in `ℓ²`** on a countable abelian group: finitely supported, non-negative, of norm one, with
`⟨w n, τ_z (w n)⟩ = Σ_x w n x · w n (x + z) → 1` for every `z`. Read by M2a (here, with `w`) and M3
(`Rigidity/InvariantMeasure`, with the probability weights `(w n)²`: `Σ_x |w(x)² − w(x + z)²| ≤ 2‖w − τ_z w‖₂`). -/
theorem exists_almostInvariant_weights [Countable G] :
    ∃ w : ℕ → G →₀ ℝ, (∀ n x, 0 ≤ w n x) ∧ (∀ n, ∑ x ∈ (w n).support, w n x ^ 2 = 1) ∧
      ∀ z : G, Tendsto (fun n => ∑ x ∈ (w n).support, w n x * w n (x + z)) atTop (𝓝 1) := by
  sorry

/-- **Fejér measures**: a positive-definite `C` on a countable `G` is the limit, coefficient by coefficient, of finite
measures on `Ĝ` of mass `(C 0).re` (each a non-negative density times `dualHaar G`). -/
theorem exists_fejer_measures [Countable G] (C : G → ℂ) (hC : PosDef C) :
    ∃ σ : ℕ → Measure (AddChar G Circle), (∀ n, IsFiniteMeasure (σ n)) ∧
      (∀ n, σ n Set.univ = ENNReal.ofReal (C 0).re) ∧
      ∀ y : G, Tendsto (fun n => ∫ χ, (χ y : ℂ) ∂(σ n)) atTop (𝓝 (C y)) := by
  sorry

/-- **A limit point keeps the limits of the coefficients**: on the compact dual of a countable group, finite measures of
mass at most `M < ∞` whose coefficients converge to `C` have a finite limit point with coefficients `C`. -/
theorem exists_fourier_eq_of_tendsto [Countable G] (σ : ℕ → Measure (AddChar G Circle))
    (hfin : ∀ n, IsFiniteMeasure (σ n)) (M : ENNReal) (hM : ∀ n, σ n Set.univ ≤ M) (hMtop : M ≠ ⊤) (C : G → ℂ)
    (hC : ∀ y : G, Tendsto (fun n => ∫ χ, (χ y : ℂ) ∂(σ n)) atTop (𝓝 (C y))) :
    ∃ σ' : Measure (AddChar G Circle), IsFiniteMeasure σ' ∧ ∀ y : G, ∫ χ, (χ y : ℂ) ∂σ' = C y := by
  sorry

/-- **Herglotz–Bochner on a countable discrete abelian group, with uniqueness** (`[Rudin1962]` 1.4.3 and 1.3.6, by another
route): existence from the Fejér measures and a limit point; uniqueness from `measure_eq_of_fourier`. -/
theorem bochnerHerglotz_of_countable [Countable G] : BochnerHerglotz G := by
  intro C hC
  obtain ⟨σ, hfin, hmass, hlim⟩ := exists_fejer_measures G C hC
  obtain ⟨σ', hσ', hF⟩ := exists_fourier_eq_of_tendsto G σ hfin _ (fun n => (hmass n).le) ENNReal.ofReal_ne_top C hlim
  refine ⟨σ', hσ', hF, fun σ'' h'' hF'' => ?_⟩
  haveI := hσ'
  haveI := h''
  exact measure_eq_of_fourier fun r => (hF'' r).trans (hF r).symm

end

end HadwigerNelson.Rigidity
