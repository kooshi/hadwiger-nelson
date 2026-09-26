import Proofs.HadwigerNelson.SpectralChain
import Proofs.HadwigerNelson.Instances.SqrtFortySeven

/-!
# X11K skeleton, after X11K3's gate: the leaves of SP-Cor's chain and what depends on them

The sorry-free part of the chain is in `Proofs/HadwigerNelson/SpectralChain.lean` and the upper bound `χ(ℚ(√47)²) ≤ 5` in
`Proofs/HadwigerNelson/Instances/SqrtFortySeven.lean`. This file holds the leaves (`exists_invariantColouring`, L1;
`posDef_corr`, L2's input) and the compositions over them, in the final namespace so their names survive gating.
-/

namespace HadwigerNelson.SpectralChain

open SimpleGraph MeasureTheory

noncomputable section Chain

variable {F : Subfield ℝ}
/-- **Node L1** (formalizable; Markov–Kakutani twice): `X₄(F) ≠ ∅` gives an invariant random colouring. -/
theorem exists_invariantColouring (h : (X4 F).Nonempty) : Nonempty (InvariantColouring F) := by
  sorry

/-- The tetrahedron's `±1` coordinates: vertex `i` is column `i` of `(1,1,−1,−1; 1,−1,1,−1; 1,−1,−1,1)`. -/
def tetW (k : Fin 3) (i : Fin 4) : ℝ := ![![1, 1, -1, -1], ![1, -1, 1, -1], ![1, -1, -1, 1]] k i

/-- **The tetrahedral Gram identity**: `⟨e_i, e_j⟩ = (1/3) Σ_k w_k(i) w_k(j)`. -/
theorem tetra_eq (i j : Fin 4) : tetra i j = 1 / 3 * ∑ k : Fin 3, tetW k i * tetW k j := by
  fin_cases i <;> fin_cases j <;> simp [tetra, tetW, Fin.sum_univ_three] <;> norm_num

theorem tetra_comm (i j : Fin 4) : tetra i j = tetra j i := by
  rw [tetra_eq, tetra_eq]
  simp only [mul_comm (tetW _ i)]

theorem abs_tetra_le (i j : Fin 4) : ‖tetra i j‖ ≤ 1 := by
  unfold tetra
  split_ifs <;> norm_num

/-- **Shift invariance of the correlation**: `C(x − y) = E_μ⟨g(x), g(y)⟩`. -/
theorem corr_sub (μ : InvariantColouring F) (x y : unitRing F) :
    corr F μ.μ (x - y) = ∫ c, tetra (c x) (c y) ∂μ.μ := by
  have hφ : Measurable (fun (c : unitRing F → Fin 4) (t : unitRing F) => c (t + y)) :=
    measurable_pi_lambda _ fun t => measurable_pi_apply _
  have hm : Measurable (fun c : unitRing F → Fin 4 => tetra (c 0) (c (x - y))) :=
    (measurable_of_countable (fun p : Fin 4 × Fin 4 => tetra p.1 p.2)).comp
      (f := fun c : unitRing F → Fin 4 => (c 0, c (x - y))) ((measurable_pi_apply 0).prodMk (measurable_pi_apply (x - y)))
  calc corr F μ.μ (x - y) = ∫ c, tetra (c 0) (c (x - y)) ∂(μ.μ.map (fun c t => c (t + y))) := by
        rw [μ.shift_inv y]; rfl
    _ = ∫ c, tetra (c (0 + y)) (c (x - y + y)) ∂μ.μ := integral_map hφ.aemeasurable hm.aestronglyMeasurable
    _ = ∫ c, tetra (c x) (c y) ∂μ.μ := by
        congr 1; funext c; rw [zero_add, sub_add_cancel, tetra_comm]

/-- **Node L2's input**: the correlation of an invariant random colouring is positive definite. -/
theorem posDef_corr (μ : InvariantColouring F) : PosDef (fun y => (corr F μ.μ y : ℂ)) := by
  intro s z
  haveI := μ.isProb
  have hmeas : ∀ x y : unitRing F, Measurable (fun c : unitRing F → Fin 4 => tetra (c x) (c y)) := fun x y =>
    (measurable_of_countable (fun p : Fin 4 × Fin 4 => tetra p.1 p.2)).comp
      (f := fun c : unitRing F → Fin 4 => (c x, c y)) ((measurable_pi_apply x).prodMk (measurable_pi_apply y))
  have hint : ∀ x y : unitRing F, Integrable (fun c : unitRing F → Fin 4 => z x * star (z y) * (tetra (c x) (c y) : ℂ)) μ.μ :=
    fun x y => ((Integrable.mono' (integrable_const (1 : ℝ)) (hmeas x y).aestronglyMeasurable
      (ae_of_all _ fun c => abs_tetra_le _ _)).ofReal).const_mul _
  -- the Gram identity, pointwise: `Σ_x Σ_y z_x z̄_y ⟨e_{c x}, e_{c y}⟩ = (1/3) Σ_k |Σ_x z_x w_k(c x)|²`
  set G : (unitRing F → Fin 4) → ℝ := fun c => ∑ k : Fin 3, 1 / 3 * Complex.normSq (∑ x ∈ s, z x * (tetW k (c x) : ℂ))
    with hG
  have hpt : ∀ c : unitRing F → Fin 4,
      ∑ x ∈ s, ∑ y ∈ s, z x * star (z y) * (tetra (c x) (c y) : ℂ) = (G c : ℂ) := by
    intro c
    have e1 : ∀ x y, z x * star (z y) * (tetra (c x) (c y) : ℂ) =
        ∑ k : Fin 3, (1 / 3 : ℂ) * ((z x * (tetW k (c x) : ℂ)) * star (z y * (tetW k (c y) : ℂ))) := by
      intro x y
      rw [tetra_eq]
      push_cast
      rw [Finset.mul_sum, Finset.mul_sum]
      refine Finset.sum_congr rfl fun k _ => ?_
      simp only [star_mul', Complex.star_def, Complex.conj_ofReal]
      ring
    have e2 : (G c : ℂ) = ∑ k : Fin 3, ∑ x ∈ s, ∑ y ∈ s,
        (1 / 3 : ℂ) * ((z x * (tetW k (c x) : ℂ)) * star (z y * (tetW k (c y) : ℂ))) := by
      rw [hG]
      push_cast
      refine Finset.sum_congr rfl fun k _ => ?_
      rw [← Complex.mul_conj, ← Complex.star_def, star_sum, Finset.sum_mul_sum, Finset.mul_sum]
      refine Finset.sum_congr rfl fun x _ => ?_
      rw [Finset.mul_sum]
    rw [e2]
    conv_rhs => rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun x _ => ?_
    conv_rhs => rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun y _ => e1 x y
  -- move the sums inside the integral
  have key : ∑ x ∈ s, ∑ y ∈ s, z x * star (z y) * (corr F μ.μ (x - y) : ℂ) = ((∫ c, G c ∂μ.μ : ℝ) : ℂ) := by
    have h1 : ∀ x y, z x * star (z y) * (corr F μ.μ (x - y) : ℂ) =
        ∫ c, z x * star (z y) * (tetra (c x) (c y) : ℂ) ∂μ.μ := by
      intro x y
      rw [corr_sub, integral_const_mul, integral_complex_ofReal]
    have h2 : ∀ x, ∑ y ∈ s, ∫ c, z x * star (z y) * (tetra (c x) (c y) : ℂ) ∂μ.μ =
        ∫ c, ∑ y ∈ s, z x * star (z y) * (tetra (c x) (c y) : ℂ) ∂μ.μ :=
      fun x => (integral_finsetSum s fun y _ => hint x y).symm
    simp only [h1, h2]
    rw [← integral_finsetSum s fun x _ => integrable_finsetSum s fun y _ => hint x y, ← integral_complex_ofReal]
    exact integral_congr_ae (ae_of_all _ hpt)
  have hG0 : 0 ≤ ∫ c, G c ∂μ.μ :=
    integral_nonneg fun c => Finset.sum_nonneg fun k _ => mul_nonneg (by norm_num) (Complex.normSq_nonneg _)
  rw [key]
  exact ⟨Complex.ofReal_im _, by rw [Complex.ofReal_re]; exact hG0⟩

/-- **Node L3**: the trace spectral measure is rotation-invariant (`C(uy) = C(y)`, and uniqueness). -/
theorem rotInv_of_isTraceSpectral (hBH : BochnerHerglotz (unitRing F)) (μ : InvariantColouring F) {σ : Measure (Dual F)}
    (hσ : IsTraceSpectral F μ.μ σ) : RotInv F σ := by
  intro u
  obtain ⟨σ₀, -, -, huniq⟩ := hBH _ (posDef_corr μ)
  have hρ : Measurable (fun (c : unitRing F → Fin 4) (x : unitRing F) => c (uvRing u * x)) :=
    measurable_pi_lambda _ fun x => measurable_pi_apply _
  have hcorr : ∀ y, corr F μ.μ (uvRing u * y) = corr F μ.μ y := by
    intro y
    have hm : Measurable (fun c : unitRing F → Fin 4 => tetra (c 0) (c y)) :=
      (measurable_of_countable (fun p : Fin 4 × Fin 4 => tetra p.1 p.2)).comp
        (f := fun c : unitRing F → Fin 4 => (c 0, c y)) ((measurable_pi_apply 0).prodMk (measurable_pi_apply y))
    calc corr F μ.μ (uvRing u * y)
        = ∫ c, (fun c' : unitRing F → Fin 4 => tetra (c' 0) (c' y)) (fun x => c (uvRing u * x)) ∂μ.μ := by
          unfold corr; congr 1; funext c; simp only [mul_zero]
      _ = ∫ c', tetra (c' 0) (c' y) ∂(μ.μ.map (fun c x => c (uvRing u * x))) :=
          (integral_map hρ.aemeasurable hm.aestronglyMeasurable).symm
      _ = corr F μ.μ y := by rw [μ.rot_inv u]; rfl
  have hmap : ∀ y, ∫ χ, (χ y : ℂ) ∂(σ.map (rot u)) = (corr F μ.μ y : ℂ) := by
    intro y
    rw [integral_map (measurable_rot u).aemeasurable (measurable_eval y).aestronglyMeasurable]
    show ∫ χ, (χ (uvRing u * y) : ℂ) ∂σ = _
    rw [hσ.2, hcorr]
  haveI := hσ.1
  rw [huniq _ inferInstance hmap, huniq σ hσ.1 hσ.2]

/-- **Node L6, SP-Cor** (`plans/FS84-SI-D-derivation.md` §4.2): given Herglotz–Bochner, R-U, A⁺ at `S = ∅` and MR, the
plane over `F` has no proper four-colouring of `Cay(R, U)`. -/
theorem Interface.x4_eq_empty (I : Interface F) (hBH : BochnerHerglotz (unitRing F)) (hRU : I.RU) (hA : I.APlus0)
    (hMR : I.MR) : X4 F = ∅ := by
  by_contra hne
  obtain ⟨μ⟩ := exists_invariantColouring (Set.nonempty_iff_ne_empty.mpr hne)
  obtain ⟨σ, hσfin, hσ, -⟩ := hBH _ (posDef_corr μ)
  have hTS : IsTraceSpectral F μ.μ σ := ⟨hσfin, hσ⟩
  have hrot := rotInv_of_isTraceSpectral hBH μ hTS
  -- the evaluation `χ ↦ χ 1` is measurable, and bounded by `1`
  have hev := measurable_eval (F := F) 1
  have hint : ∀ ν : Measure (Dual F), IsFiniteMeasure ν → Integrable (fun χ : Dual F => (χ 1 : ℂ)) ν := by
    intro ν _
    refine Integrable.of_bound hev.aestronglyMeasurable 1 (Filter.Eventually.of_forall fun χ => ?_)
    simp
  -- `τ := σ|_{Eᶜ}`: rotation-invariant, finite, `E`-null
  have hmrot := measurable_rot (F := F)
  have hτrot : RotInv F (σ.restrict I.Eᶜ) := by
    intro u
    have hpre : rot u ⁻¹' I.Eᶜ = I.Eᶜ := by rw [Set.preimage_compl, I.rot_preimage_E u]
    conv_lhs => rw [← hpre]
    rw [← Measure.restrict_map (hmrot u) I.measurableSet_E.compl, hrot u]
  have hτE : (σ.restrict I.Eᶜ) I.E = 0 := by
    rw [Measure.restrict_apply I.measurableSet_E, Set.inter_compl_self, measure_empty]
  have hMRτ := hMR _ inferInstance hτrot hτE 1 one_ne_zero
  -- A⁺ and R-U: `∫_{TAᶜ} = ∫_{Eᶜ} + ∫_{E∖TA}`, the second over a null set
  have hAμ := hA μ σ hTS
  have hnull : σ (I.E \ I.TA) = 0 := hRU σ hσfin hrot
  have hsplit : I.TAᶜ = I.Eᶜ ∪ (I.E \ I.TA) := by
    ext χ
    simp only [Set.mem_compl_iff, Set.mem_union, Set.mem_sdiff]
    constructor
    · intro h
      by_cases h1 : χ ∈ I.E
      · exact Or.inr ⟨h1, h⟩
      · exact Or.inl h1
    · rintro (h | ⟨-, h⟩)
      · exact fun h' => h (I.TA_subset_E h')
      · exact h
  have hre : ∫ χ in I.Eᶜ, (χ 1 : ℂ).re ∂σ = 0 := by
    have h := integral_re (𝕜 := ℂ) (hint (σ.restrict I.Eᶜ) inferInstance)
    simp only [RCLike.re_to_complex] at h
    rw [h, hMRτ, Complex.zero_re]
  have hint' : Integrable (fun χ : Dual F => (χ 1 : ℂ).re) σ := by
    simpa only [RCLike.re_to_complex] using (hint σ hσfin).re
  rw [hsplit, setIntegral_union (disjoint_compl_left.mono_right Set.sdiff_subset)
    (I.measurableSet_E.diff I.measurableSet_TA) hint'.integrableOn hint'.integrableOn,
    hre, setIntegral_measure_zero _ hnull, add_zero] at hAμ
  exact lt_irrefl 0 hAμ

/-- **The lower half**: `χ(F²) ≥ 5` from the chain. -/
theorem Interface.five_le_chromaticNumber (I : Interface F) (hBH : BochnerHerglotz (unitRing F)) (hRU : I.RU)
    (hA : I.APlus0) (hPE : I.PE2) (hEF : I.EFPlus) :
    5 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  have h := (add_one_le_chromaticNumber_iff_not_colorable
    (G := (unitDistance ℂ).induce (planeOver F)) (n := 4)).mpr fun hc => by
    have hne := x4_nonempty_of_colorable hc
    rw [I.x4_eq_empty hBH hRU hA (I.mr_of_pe2_efPlus hPE hEF)] at hne
    exact Set.not_nonempty_empty hne
  exact_mod_cast h

end Chain

/-- **`χ(ℚ(√47)²) = 5`, conditional on the named hypotheses** (X11K): Herglotz–Bochner on `ℤ[U]`, and an interface
`(E, T + A, h)` satisfying R-U, A⁺ at `S = ∅`, PE-2 and EF_F⁺. The upper half is `Instances/SqrtFortySeven`. -/
theorem chromaticNumber_planeOver_sqrt47_eq_five (hBH : BochnerHerglotz (unitRing SqrtFortySeven.F47))
    (I : Interface SqrtFortySeven.F47) (hRU : I.RU) (hA : I.APlus0) (hPE : I.PE2) (hEF : I.EFPlus) :
    ((unitDistance ℂ).induce (planeOver SqrtFortySeven.F47)).chromaticNumber = 5 :=
  le_antisymm SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five (I.five_le_chromaticNumber hBH hRU hA hPE hEF)

section Every

variable {F : Subfield ℝ}

/-- **THE HEADLINE (X11K2's re-aim, Kooshi's "every real" target): every real number field**, the complex-place step behind its
own hypothesis (X23D-COR, X23V §2.4, X29C's ruling):
`χ(F²) ≥ min(L(F), 5)` given
- `hTR` — **the count for totally real `F`** (X23D-TCA; X23V §2.3);
- `hCX` — **the count for `F` with a complex place** (Lemma X23V-CX; ruled by X29C: edge-removal monotonicity, formalizable, and
  `m₁` external);
- `hAP` — A⁺ from R88-TCA (J45, field-free); `hRU` — R-U (J45, every real number field);
- `hMR` — in the class, **MR(F)** as PE-2 and EF_F⁺ (scope: row 100's exception, which `TCA F` excludes — a ramified stable dyadic
  place has ratio `1/2`);
- `hCLS` — **CLS**'s `⟸`: `L(F) ≥ 5 ⟹ TCA F` (X23D-CLS, X23V §2.2); `hRow99` — **row 99** at `L ≤ 4`; `hBH` — Herglotz–Bochner. -/
theorem min_localBound_five_le_chromaticNumber [NumberField F] (hBH : BochnerHerglotz (unitRing F))
    (I : Interface F) (hTR : NumberField.IsTotallyReal F → I.Count) (hCX : ¬ NumberField.IsTotallyReal F → I.Count)
    (hAP : I.APlusOfR88) (hRU : I.RU) (hMR : TCA F → I.PE2 ∧ I.EFPlus) (hCLS : 5 ≤ localBound F → TCA F)
    (hRow99 : localBound F ≤ 4 → localBound F ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber) :
    min (localBound F) 5 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  by_cases h5 : 5 ≤ localBound F
  · have hT := hCLS h5
    have hC : I.Count := by
      by_cases hr : NumberField.IsTotallyReal F
      · exact hTR hr
      · exact hCX hr
    obtain ⟨hPE, hEF⟩ := hMR hT
    exact min_le_of_right_le (I.five_le_chromaticNumber hBH hRU (hAP (hC hT)) hPE hEF)
  · have h4 : localBound F ≤ 4 := Order.le_of_lt_succ (not_le.mp h5)
    exact min_le_of_left_le (hRow99 h4)

/-- **The staging form: every totally real number field.** `χ(F²) ≥ min(L(F), 5)`, given the count (X23D-TCA),
A⁺ from R88-TCA and R-U (J45), MR(F) in the class (PE-2 over EL2021 Thm 1.2; EF_F⁺), CLS, row 99 at `L ≤ 4` and
Herglotz–Bochner. The complex-place hypothesis of `..._of_complexStep` is discharged vacuously by `IsTotallyReal`. -/
theorem min_localBound_five_le_chromaticNumber_of_totallyReal [NumberField F] [NumberField.IsTotallyReal F]
    (hBH : BochnerHerglotz (unitRing F)) (I : Interface F) (hCount : I.Count) (hAP : I.APlusOfR88) (hRU : I.RU)
    (hMR : TCA F → I.PE2 ∧ I.EFPlus) (hCLS : 5 ≤ localBound F → TCA F)
    (hRow99 : localBound F ≤ 4 → localBound F ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber) :
    min (localBound F) 5 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber :=
  min_localBound_five_le_chromaticNumber hBH I (fun _ => hCount)
    (fun h => (h inferInstance).elim) hAP hRU hMR hCLS hRow99

/-- **`χ(F²) = L(F)` for `L(F) ≤ 5`, every totally real number field**, given the headline's inputs and the upper half
`χ(F²) ≤ L(F)` (row 52 at ring level; the field step is row 57's gap), named `hUpper`. -/
theorem chromaticNumber_eq_localBound [NumberField F] [NumberField.IsTotallyReal F]
    (hBH : BochnerHerglotz (unitRing F)) (I : Interface F) (hCount : I.Count) (hAP : I.APlusOfR88) (hRU : I.RU)
    (hMR : TCA F → I.PE2 ∧ I.EFPlus) (hCLS : 5 ≤ localBound F → TCA F)
    (hRow99 : localBound F ≤ 4 → localBound F ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber)
    (hUpper : ((unitDistance ℂ).induce (planeOver F)).chromaticNumber ≤ localBound F) (hL : localBound F ≤ 5) :
    ((unitDistance ℂ).induce (planeOver F)).chromaticNumber = localBound F :=
  le_antisymm hUpper (by
    have := min_localBound_five_le_chromaticNumber_of_totallyReal hBH I hCount hAP hRU hMR hCLS hRow99
    rwa [min_eq_left hL] at this)

end Every

end HadwigerNelson.SpectralChain
