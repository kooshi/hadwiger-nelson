import Proofs.HadwigerNelson.Collapse.Density.Upper
import Proofs.HadwigerNelson.Plane.TriangularPacking
import Proofs.HadwigerNelson.Instances.Seven

/-!
# The density form of the collapse (FS-131, job FS131-KFR1; module D3, skeleton)

**Read aloud, against the informal claim** (`LEDGER.md` row 129's field clause, "given MR(F) … the finitary independence
ratio is `α₁(F²) = α_loc(F)`"; FS103-F-FRAC, -B-AMEN, -F-TJ, -F-ROUND, -F-TF; the asking lane's corollary; inventory item
1005's two owed items).

* `finIndepRatio_planeOver_eq_localRatio` — **the head statement**: at every real number field,
  `α₁(F²) = max(m₁(ℝ²), ⨆_P r_P)`. Wider than row 129: no MR hypothesis (`Rigidity.mrPlus`), no `R = O′`, not only totally
  real fields. `finIndepRatio_planeOver_eq_iSup_density` (B-AMEN): it is also the best density of an invariant random
  independent set.
* `fractionalChromaticNumber_planeOver_eq` — **the fractional local–global principle**: `χ_f(F²) = 1/α_loc(F)`.
* `finIndepRatio_planeOver_eq_mOne_of_thick`, `fractionalChromaticNumber_planeOver_eq_plane_of_thick` — **the fractional
  collapse**: at every real number field uniformly `c`-thick with `c < 1/5` (the collapse's hypothesis),
  `α₁(F²) = m₁(ℝ²)` and `χ_f(F²) = χ_f(ℝ²)`; at `ℚ(√635087)` and de Grey's field with no hypothesis.
* TJ's first clause `IndepLaw.density_le_notThick`; ROUND `inv_le_localRatio_of_colorable` and `inv_localRatio_lt_five`.
* TF `exists_triangleFree_ratio_lt`; the corollary `exists_finite_triangleFree_six_chromatic`.
* Item 1005: the splits `six_le_chromaticNumber_planeOver_sqrt635087`, `chromaticNumber_planeOver_sqrt635087_le_seven`, and
  the model at `k = 7`, `exists_model_seven` (the field `F7` of the radicand `d₇`, `data/fs131/kfr1/d7_crt.py`).

**What it rests on** (planned): the head statement and B-AMEN on `Rigidity.positive_entropy_rigidity`; the instances also on
`StandingFive.kloosterman_bound`; the six-chromatic corollary also on `Outside.OAI158.no_proper_five_coloring`; the lower
half, ROUND's bounds and the triangle-freeness on the standard three.

**Not claimed:** any value of `m₁(ℝ²)` or of `χ_f(ℝ²)`; anything at six colours beyond the corollary's `6`; that the
fractional forms are new (prior art: not searched by this job).

**Models.** `[NumberField F]` is the head statement's only hypothesis. The thick form's hypotheses hold at `ℚ(√635087)`
(`Collapse.thick_sqrt635087`) and fail at `ℚ`, whose `α₁(ℚ²) = 1/2 > m₁` (the ramified prime above `2`).
-/

namespace HadwigerNelson.Collapse

open SpectralChain NumberField MeasureTheory SimpleGraph Rigidity Plane
open scoped ENNReal

noncomputable section

variable {F : Subfield ℝ}

/-! ## The head statement -/

/-- **The density form of the collapse** (row 129's field clause, FS103-F-FRAC): at every real number field, the finitary
independence ratio of `F²` is `α_loc(F) = max(m₁(ℝ²), ⨆_P r_P)`. -/
theorem finIndepRatio_planeOver_eq_localRatio [NumberField F] :
    ((unitDistance ℂ).induce (planeOver F)).finIndepRatio = localRatio F := by
  sorry

/-- **B-AMEN**: `α₁(F²)` is the best density of an `R ⋊ U`-invariant random independent set of `Cay(R, U)`. -/
theorem finIndepRatio_planeOver_eq_iSup_density [NumberField F] :
    ((unitDistance ℂ).induce (planeOver F)).finIndepRatio = ⨆ μ : IndepLaw F, μ.density := by
  sorry

/-! ## The fractional chromatic number -/

/-- **A Cayley target's fractional bound**: a translation-invariant graph on a finite abelian group with a nonempty
independent set `s` has `χ_f ≤ |A|/|s|` (each vertex takes the translates of `s` through it). -/
theorem fractionalChromaticNumber_le_card_div {A : Type*} [AddCommGroup A] [Finite A] {H : SimpleGraph A}
    (hH : ∀ a x y : A, H.Adj (x + a) (y + a) ↔ H.Adj x y) (s : Finset A) (hs : H.IsIndepSet (s : Set A))
    (hs0 : s.Nonempty) : H.fractionalChromaticNumber ≤ (Nat.card A : ℝ≥0∞) / s.card := by
  sorry

/-- **The fractional local–global principle**: `χ_f(F²) = 1/α_loc(F)` — `≥` from `α₁(F²) = α_loc`
(`inv_finIndepRatio_le_iSup_fractionalChromaticNumber`), `≤` from the plane (`OneClass.fractionalChromaticNumber_plane`) and
every residue target (`fractionalChromaticNumber_mono_of_hom`). -/
theorem fractionalChromaticNumber_planeOver_eq [NumberField F] :
    ((unitDistance ℂ).induce (planeOver F)).fractionalChromaticNumber = (localRatio F)⁻¹ := by
  sorry

/-! ## The fractional collapse -/

/-- Under uniform thickness below `1/5`, every `r_P ≤ c/(1 + c) < 1/6 < m₁(ℝ²)`, so `α_loc(F) = m₁(ℝ²)`. -/
theorem localRatio_eq_mOne_of_thick [NumberField F] {c : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c) (hc : c < 1 / 5) :
    localRatio F = mOne := by
  sorry

/-- **The fractional collapse, density form**: at every real number field uniformly `c`-thick with `c < 1/5`,
`α₁(F²) = m₁(ℝ²)`. -/
theorem finIndepRatio_planeOver_eq_mOne_of_thick [NumberField F] {c : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c)
    (hc : c < 1 / 5) : ((unitDistance ℂ).induce (planeOver F)).finIndepRatio = mOne := by
  sorry

/-- The same as `α₁(F²) = α₁(ℝ²)` (`OneClass.finIndepRatio_plane_eq_mOne`). -/
theorem finIndepRatio_planeOver_eq_plane_of_thick [NumberField F] {c : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c)
    (hc : c < 1 / 5) :
    ((unitDistance ℂ).induce (planeOver F)).finIndepRatio = (unitDistance ℂ).finIndepRatio := by
  sorry

/-- **The fractional collapse**: at every real number field uniformly `c`-thick with `c < 1/5`, `χ_f(F²) = χ_f(ℝ²)` — beside
`chromaticNumber_planeOver_eq_plane_of_thick`'s `χ(F²) = χ(ℝ²)`. -/
theorem fractionalChromaticNumber_planeOver_eq_plane_of_thick [NumberField F] {c : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c)
    (hc : c < 1 / 5) :
    ((unitDistance ℂ).induce (planeOver F)).fractionalChromaticNumber = (unitDistance ℂ).fractionalChromaticNumber := by
  sorry

/-- **`α₁(ℚ(√635087)²) = m₁(ℝ²)`**, with no hypothesis. -/
theorem finIndepRatio_planeOver_sqrt635087 :
    ((unitDistance ℂ).induce (planeOver F635087)).finIndepRatio = mOne := by
  sorry

/-- **`χ_f(ℚ(√635087)²) = χ_f(ℝ²)`**, with no hypothesis. -/
theorem fractionalChromaticNumber_planeOver_sqrt635087 :
    ((unitDistance ℂ).induce (planeOver F635087)).fractionalChromaticNumber =
      (unitDistance ℂ).fractionalChromaticNumber := by
  sorry

/-- **`α₁(ℚ(√3, √5, √7, √11)²) = m₁(ℝ²)`** (de Grey's field). -/
theorem finIndepRatio_planeOver_deGrey : ((unitDistance ℂ).induce (planeOver FdG)).finIndepRatio = mOne := by
  sorry

/-- **`χ_f(ℚ(√3, √5, √7, √11)²) = χ_f(ℝ²)`**. -/
theorem fractionalChromaticNumber_planeOver_deGrey :
    ((unitDistance ℂ).induce (planeOver FdG)).fractionalChromaticNumber =
      (unitDistance ℂ).fractionalChromaticNumber := by
  sorry

/-! ## TJ and ROUND -/

/-- **TJ, first clause** (MR proved, so case (B) is empty): an invariant random independent set of density `δ ∈ (0, 1/2)`
has `δ ≤ max(m₁, sup r_P)` over the stable primes `P` that are `c`-thick for no `c < δ/(1 − δ)` (`N_δ`): the thick ones have
`r_P < δ`, and `r_P → 0` (Weil), so they cannot reach `δ`. -/
theorem IndepLaw.density_le_notThick [NumberField F] (μ : IndepLaw F) {δ : ℝ} (hδ0 : 0 < δ) (hδ : δ < 1 / 2)
    (hμ : μ.density = ENNReal.ofReal δ) :
    μ.density ≤ max mOne (⨆ (P : StablePrime F) (_ : ∀ c : ℝ, c < δ / (1 - δ) → ¬ ThickAt P c), stableRatio P) := by
  sorry

/-- **ROUND** (FS103-F-ROUND): a `k`-colouring of `F²` has `1/k ≤ α_loc(F)` — the one place the colour count enters. -/
theorem inv_le_localRatio_of_colorable [NumberField F] {k : ℕ}
    (h : ((unitDistance ℂ).induce (planeOver F)).Colorable k) : (k : ℝ≥0∞)⁻¹ ≤ localRatio F := by
  sorry

/-- **The density route never gives six**: `1/α_loc(F) < 5` at every real number field (`m₁ > 1/5`, the triangular
packing). -/
theorem inv_localRatio_lt_five (F : Subfield ℝ) : (localRatio F)⁻¹ < 5 := by
  sorry

/-! ## TF and the triangle-free six-chromatic graph -/

/-- A unit triangle in `F²` puts `√3` in `F` (`v/u = e^{±iπ/3}` has imaginary part `±√3/2`). -/
theorem cliqueFree_three_planeOver_of_sqrt_three_notMem (F : Subfield ℝ) (h : Real.sqrt 3 ∉ F) :
    ((unitDistance ℂ).induce (planeOver F)).CliqueFree 3 := by
  sorry

/-- **`√3 ∉ ℚ(√635087)`**: `635087 ≡ 1 (mod 17)`, so `ℚ(√635087)` maps to `ℚ₁₇` (`QuadraticPrime.nonempty_ringHom_padic`),
and `3` is not a square modulo `17`. -/
theorem sqrt_three_notMem_F635087 : Real.sqrt 3 ∉ F635087 := by
  sorry

/-- **TF**: for every `ε > 0` a finite triangle-free unit-distance graph — a finite set of `ℚ(√635087)²` — whose
independence ratio is below `m₁(ℝ²) + ε`. -/
theorem exists_triangleFree_ratio_lt {ε : ℝ≥0∞} (hε : 0 < ε) :
    ∃ S : Finset ℂ, S.Nonempty ∧ ((unitDistance ℂ).induce (S : Set ℂ)).CliqueFree 3 ∧
      (((unitDistance ℂ).induce (S : Set ℂ)).indepNum : ℝ≥0∞) < (mOne + ε) * S.card := by
  sorry

/-- **Item 1005 (1), first split**: `6 ≤ χ(ℚ(√635087)²)`. -/
theorem six_le_chromaticNumber_planeOver_sqrt635087 :
    6 ≤ ((unitDistance ℂ).induce (planeOver F635087)).chromaticNumber :=
  chromaticNumber_planeOver_sqrt635087_six_or_seven.1

/-- **Item 1005 (1), second split**: `χ(ℚ(√635087)²) ≤ 7`. -/
theorem chromaticNumber_planeOver_sqrt635087_le_seven :
    ((unitDistance ℂ).induce (planeOver F635087)).chromaticNumber ≤ 7 :=
  chromaticNumber_planeOver_sqrt635087_six_or_seven.2

/-- **A finite triangle-free six-chromatic unit-distance graph**: compactness (de Bruijn–Erdős) on `6 ≤ χ(ℚ(√635087)²)`
gives a finite subset with no five-colouring; a minimal one is six-chromatic; it is triangle-free with the field. -/
theorem exists_finite_triangleFree_six_chromatic :
    ∃ S : Finset ℂ, ((unitDistance ℂ).induce (S : Set ℂ)).CliqueFree 3 ∧
      ((unitDistance ℂ).induce (S : Set ℂ)).chromaticNumber = 6 := by
  sorry

/-! ## Item 1005 (2): the model at `k = 7` -/

/-- **`d₇`**: `≡ 7 (mod 8)` and a quadratic non-residue modulo each of the eighteen primes `p ≡ 3 (mod 4)` below `142`, by
the Chinese remainder theorem (`data/fs131/kfr1/d7_crt.py`: the formula and its check). -/
def d7 : ℕ := 1033204869123838804565816643023

/-- `ℚ(√d₇)`. -/
noncomputable abbrev F7 : Subfield ℝ := SquareClass.fieldOfRadicands {d7}

/-- Every stable prime of `ℚ(√d₇, i)` lies above a prime `p ≡ 3 (mod 4)` with `p ≥ 142`, none above `2`. -/
theorem stablePrime_F7 (P : StablePrime F7) :
    (2 : 𝓞 (fieldI F7)) ∉ P.P ∧ ∃ Q : ℕ, 142 ≤ Q ∧ Nat.card (𝓞 (fieldI F7) ⧸ P.P) = Q ^ 2 := by
  sorry

/-- `2√142/143 < 1/6` (`142 · 144 < 143²`). -/
theorem weil_142_lt_sixth : 2 * Real.sqrt ((142 : ℕ) : ℝ) / (((142 : ℕ) : ℝ) + 1) < 1 / 6 := by
  sorry

/-- **The model at `k = 7`**: `ℚ(√d₇)` with the plane's seven-colouring inhabits the joint hypotheses of
`chromaticNumber_plane_le_of_thick` (and of `exists_aeColouring_of_slice` through `exists_slice_of_colorable`). -/
theorem exists_model_seven : ∃ c : ℝ, Thick F7 c ∧ 0 ≤ c ∧ c * ((7 : ℕ) - 1 : ℝ) < 1 ∧
    ((unitDistance ℂ).induce (planeOver F7)).Colorable 7 := by
  sorry

end

end HadwigerNelson.Collapse
