import Proofs.HadwigerNelson.Collapse.Density.Defs

/-!
# The density form of the collapse: the upper half, one class at a time (FS-131, job FS131-KFR1; module D2, skeleton)

**Read aloud, against the informal claim** (FS103-F-FRAC, steps 1–7 and 9, `plans/FS103-F-fractional-shadow.md` § 2.3;
FS103-B § 2.1 D1–D8): "every `R ⋊ U`-invariant random independent set `I` of `Cay(R, U)` has `P(0 ∈ I) ≤ ρ(F)`", here
with MR proved (`Rigidity.mrPlus`, read through `Collapse.not_isSPWitness`) and at every real number field.

* **The Følner step** (FRAC 1, B-AMEN): `exists_indepLaw` — a law of density at least `α₁(Cay(R, U))`; and the averaging
  bound `IndepLaw.density_le_finIndepRatio`, the other way.
* **The dichotomy, one class** (FRAC 2–5): the indicator's spectral measure (`IsIndicatorSpectral`), SI-3 at `T + A`
  (`setIntegral_compl_TA_re_one`), MR⁺ (`integral_condOne_mul_eq_zero`), and the support set `{x : P(x ∈ I | 𝒜) > 0}`
  (`exists_indepLaw_TA`: a denser law with spectrum on `T + A`).
* **The extension and the slice, one class** (FRAC 6): `exists_extension_one`, `exists_slice_set`.
* **The count, one class** (FRAC 7): `exists_window_bound`, over the held descent (`Counting.volume_colour_le`,
  `tendsto_bad` at the indicator of the set, `PlaneZhang.sum_volume_inter_sq_le`, `FiniteZhang.ratioLe_pi`).
* `IndepLaw.density_le_localRatio` — **the per-law bound**, `P(0 ∈ I) ≤ α_loc(F)`.

**Route.** Each statement is the one-class namesake of a held colouring statement (`Collapse/Dichotomy`, `Collapse/Slice`,
`Rigidity/CountDescent`); the colouring's sums over colours drop out, and properness is replaced by the one event
`c x = true ∧ c (x + u) = true`. Plan per leaf: `plans/FS131-KFR1-density-plan.md` § 3.3.

**Models.** `IndepLaw F` at density `0` (`nonempty_indepLaw`) satisfies every hypothesis here; a law of positive density with
spectrum on `T + A` is the residue law over `ℚ` (the random translate of the residue two-colouring's class `{b = 1}` at the
ramified prime above `2`, `Rigidity.exists_invariantColouring_rat`'s bit): torsion spectrum, density `1/2`.
-/

namespace HadwigerNelson.Collapse

open SpectralChain SpectralInputs MeasureTheory NumberField Rigidity Rigidity.Counting Filter Topology Plane
open scoped ENNReal

noncomputable section

variable {F : Subfield ℝ}

variable (F) in
/-- **`Cay(R, U)`**: the unit-distance graph on `R = ℤ[U_F]`. -/
def cayR : SimpleGraph (unitRing F) := SimpleGraph.fromRel fun x y => (y : ℂ) - x ∈ unitVectors F

example (x y : unitRing F) : (cayR F).Adj x y ↔ x ≠ y ∧ ((y : ℂ) - x ∈ unitVectors F ∨ (x : ℂ) - y ∈ unitVectors F) :=
  Iff.rfl

/-- **The shift of an indicator** by `y ∈ R`: `c ↦ c(· + y)`. -/
def indShift (y : unitRing F) (c : unitRing F → Bool) : unitRing F → Bool := fun x => c (x + y)

theorem IndepLaw.measurePreserving_shift (μ : IndepLaw F) (y : unitRing F) :
    MeasurePreserving (indShift y) μ.μ μ.μ := by
  sorry

/-! ## Følner and averaging -/

/-- `Cay(R, U)` is an induced subgraph of `F²`, so `α₁(F²) ≤ α₁(Cay(R, U))` (`finIndepRatio_le_of_embedding`). -/
theorem finIndepRatio_planeOver_le_cayR :
    ((unitDistance ℂ).induce (planeOver F)).finIndepRatio ≤ (cayR F).finIndepRatio := by
  sorry

/-- **The Følner step** (FRAC 1; FS-133's C133-INV-CLASS on `R`): some invariant random independent set of `Cay(R, U)` has
density at least `α₁(Cay(R, U))`. -/
theorem exists_indepLaw [NumberField F] : ∃ μ : IndepLaw F, (cayR F).finIndepRatio ≤ μ.density := by
  sorry

/-- **The averaging bound** (B-AMEN's `α₁ ≥ α_inv`): a translation-invariant random independent set has density at most
`α₁(Cay(R, U))` (`OneClass.IsShiftInvariantLaw.measure_origin_le` on `R`). -/
theorem IndepLaw.density_le_finIndepRatio [NumberField F] (μ : IndepLaw F) : μ.density ≤ (cayR F).finIndepRatio := by
  sorry

/-! ## The dichotomy, one class -/

/-- **The indicator's spectral measure**: `∫ χ(y) dσ = P(0 ∈ I, y ∈ I)` for every `y ∈ R`. -/
def IsIndicatorSpectral (μ : Measure (unitRing F → Bool)) (σ : Measure (Dual F)) : Prop :=
  IsFiniteMeasure σ ∧ ∀ y : unitRing F, ∫ χ, (χ y : ℂ) ∂σ = ((μ.real {c | c 0 = true ∧ c y = true} : ℝ) : ℂ)

/-- Herglotz–Bochner on the countable `R` (`Rigidity.exists_isSpectralMeasureOf` for the indicator). -/
theorem exists_isIndicatorSpectral [NumberField F] (μ : IndepLaw F) :
    ∃ σ : Measure (Dual F), IsIndicatorSpectral μ.μ σ := by
  sorry

/-- It is rotation-invariant (FRAC 2): the law is (`Rigidity.measure_eq_of_fourier`). -/
theorem IsIndicatorSpectral.rotInv [NumberField F] (μ : IndepLaw F) {σ : Measure (Dual F)}
    (hσ : IsIndicatorSpectral μ.μ σ) : RotInv F σ := by
  sorry

/-- At a unit vector its coefficient is `0`: the set is independent. -/
theorem IsIndicatorSpectral.integral_unit (μ : IndepLaw F) {σ : Measure (Dual F)} (hσ : IsIndicatorSpectral μ.μ σ)
    (u : unitVectors F) : ∫ χ, (χ (uvRing u) : ℂ) ∂σ = 0 := by
  sorry

/-- **`𝒜`, the factor of the `τ′_∅`-continuous vectors** of an invariant random independent set (`Collapse.factorK`'s
one-class namesake). -/
abbrev factorOne [NumberField F] (μ : IndepLaw F) : MeasurableSpace (unitRing F → Bool) :=
  haveI := μ.isProb
  factorSigma (indShift (F := F)) μ.measurePreserving_shift (@nhds _ (tauPrime F) 0)

/-- **The conditional law at `x`**: `p(x) = P(x ∈ I | 𝒜)`. -/
def condOne [NumberField F] (μ : IndepLaw F) (x : unitRing F) : (unitRing F → Bool) → ℝ :=
  condExp (factorOne μ) μ.μ (Set.indicator {c : unitRing F → Bool | c x = true} fun _ => (1 : ℝ))

/-- **SI-3 at `T + A`, one class** (FRAC 3, D3): `∫_{R̂∖(T+A)} Re χ(u) dσ = −E[p(0) p(u)]`. -/
theorem setIntegral_compl_TA_re_one [NumberField F] (μ : IndepLaw F) {σ : Measure (Dual F)}
    (hσ : IsIndicatorSpectral μ.μ σ) (u : unitVectors F) :
    ∫ χ in (TA F)ᶜ, (χ (uvRing u) : ℂ).re ∂σ = -∫ c, condOne μ 0 c * condOne μ (uvRing u) c ∂μ.μ := by
  sorry

/-- **MR⁺, one class** (FRAC 4, D4): `E[p(0) p(u)] = 0` at every unit vector — otherwise `σ|_{(T+A)ᶜ}` is an SP witness
(`Collapse.not_isSPWitness`, on `Rigidity.mrPlus`). -/
theorem integral_condOne_mul_eq_zero [NumberField F] (μ : IndepLaw F) (u : unitVectors F) :
    ∫ c, condOne μ 0 c * condOne μ (uvRing u) c ∂μ.μ = 0 := by
  sorry

/-- **The support set** (FRAC 5, D5): `J = {x : p(x) > 0}` is an invariant random independent set containing `I`, with its
spectrum on `T + A`. -/
theorem exists_indepLaw_TA [NumberField F] (μ : IndepLaw F) :
    ∃ μ' : IndepLaw F, μ.density ≤ μ'.density ∧
      ∀ σ : Measure (Dual F), IsIndicatorSpectral μ'.μ σ → σ (TA F)ᶜ = 0 := by
  sorry

/-! ## The extension and the slice, one class -/

/-- **Continuity in probability** (FRAC 6, C1): with spectrum on `T + A`, `P(c(0) ≠ c(y)) → 0` as `ιG y → 0`
(`P(c 0 ≠ c y) = 2(σ(R̂) − Re ∫ χ(y) dσ)`). -/
theorem tendsto_measure_ne_one [NumberField F] (μ : IndepLaw F) {σ : Measure (Dual F)}
    (hσ : IsIndicatorSpectral μ.μ σ) (hTA : σ (TA F)ᶜ = 0) :
    Tendsto (fun y => μ.μ {c | c 0 ≠ c y}) (comap (ιG F) (𝓝 0)) (𝓝 0) := by
  sorry

/-- **The extension, one class** (FRAC 6, C2–C3; `Collapse.exists_extension_k` with the edge event `true ∧ true`): a jointly
measurable random set of the completion, of the law's density at every point, almost surely not holding both ends of any
edge `(g, g + t)`, `t` in the closure of the unit vectors. -/
theorem exists_extension_one [NumberField F] (μ : IndepLaw F) {σ : Measure (Dual F)} (hσ : IsIndicatorSpectral μ.μ σ)
    (hTA : σ (TA F)ᶜ = 0) :
    ∃ f : (unitRing F → Bool) → G F → Bool, Measurable (Function.uncurry f) ∧
      (∀ g, μ.μ {c | f c g = true} = μ.density) ∧
      ∀ g t, t ∈ closure (ιG F '' unitVectorsR F) → μ.μ {c | f c g = true ∧ f c (g + t) = true} = 0 := by
  sorry

/-- **The slice, one class, with its density**: in any window, some sample gives a measurable set of `ℂ × K` with null
edges holding at least the law's density of the window (Tonelli over the sample for both). -/
theorem exists_slice_set [NumberField F] (μ : IndepLaw F)
    (hTA : ∀ σ : Measure (Dual F), IsIndicatorSpectral μ.μ σ → σ (TA F)ᶜ = 0) (a : ℂ) {s : ℝ} (hs : 0 < s) :
    ∃ W : Set (ℂ × K F), MeasurableSet W ∧ SetEdgeNull F W ∧
      μ.density * ENNReal.ofReal (s ^ 2) ≤ (volume.prod (haarK F)) (W ∩ squareWin a s ×ˢ Set.univ) := by
  sorry

/-! ## The count, one class -/

open Classical in
/-- A set of the slice read as a colouring by `Fin 4` (colour `1` on the set): the held descent's input. -/
def setCol [NumberField F] (W : Set (ℂ × K F)) : ℂ × K F → Fin 4 := fun p => if p ∈ W then 1 else 0

/-- **Every level has ratio at most `c`**, with no ramified stable prime in place of `TCA F`
(`Counting.ratioLe_levR_range` through `Collapse.image_levR_unitVectors_of_unramified`). -/
theorem ratioLe_levR_range_of_unramified [NumberField F] (hun : ∀ P : StablePrime F, ¬ IsRamified P) {c : ℝ}
    (hc0 : 0 ≤ c) (hc : ∀ P : StablePrime F, RatioAtMost P c) {k : ℕ} (hk : 1 ≤ k) :
    RatioLe {d : (levR F k).range.toAddSubgroup | (d : Lev F k) ∈ normOneLev F k} c := by
  sorry

/-- **The level rows of a set with null edges have null edges** (`Counting.rowsEdgeNull_levelRows`, reading one colour). -/
theorem rowsEdgeNull_levelRows_set [NumberField F] (hun : ∀ P : StablePrime F, ¬ IsRamified P) {W : Set (ℂ × K F)}
    (hW : MeasurableSet W) (h : SetEdgeNull F W) (k : ℕ) :
    RowsEdgeNull {d : (levR F k).range.toAddSubgroup | (d : Lev F k) ∈ normOneLev F k} (levelRows (setCol W) 1 k) := by
  sorry

/-- **The count, one class** (FRAC 7; `Counting.false_of_slice` without the four colours): for every `ε > 0` some window
`squareWin 0 s₀` in which every measurable set of `ℂ × K` with null edges holds at most `(max(m₁, c) + 2ε)s₀²`. -/
theorem exists_window_bound [NumberField F] (hun : ∀ P : StablePrime F, ¬ IsRamified P) {c : ℝ} (hc0 : 0 ≤ c)
    (hcP : ∀ P : StablePrime F, RatioAtMost P c) {ε : ℝ} (hε : 0 < ε) :
    ∃ s₀ : ℝ, 0 < s₀ ∧ ∀ W : Set (ℂ × K F), MeasurableSet W → SetEdgeNull F W →
      (volume.prod (haarK F)) (W ∩ squareWin 0 s₀ ×ˢ Set.univ) ≤
        ENNReal.ofReal ((max mOne.toReal c + 2 * ε) * s₀ ^ 2) := by
  sorry

/-! ## The per-law bound -/

/-- With no ramified stable prime and a uniform ratio bound `c`: every invariant random independent set has density at most
`max(m₁, c)`. -/
theorem IndepLaw.density_le_max_of_unramified [NumberField F] (hun : ∀ P : StablePrime F, ¬ IsRamified P) {c : ℝ}
    (hc0 : 0 ≤ c) (hcP : ∀ P : StablePrime F, RatioAtMost P c) (μ : IndepLaw F) :
    μ.density ≤ max mOne (ENNReal.ofReal c) := by
  sorry

/-- **The per-law bound** (FRAC's first sentence, with MR proved): every invariant random independent set of `Cay(R, U)`
has density at most `α_loc(F)`. At a ramified stable prime `α_loc ≥ 1/2` and the density is at most `α₁(Cay(R, U)) ≤ 1/2`;
otherwise `c = (⨆_P r_P).toReal` and the line above. -/
theorem IndepLaw.density_le_localRatio [NumberField F] (μ : IndepLaw F) : μ.density ≤ localRatio F := by
  sorry

end

end HadwigerNelson.Collapse
