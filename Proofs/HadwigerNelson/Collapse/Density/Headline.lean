import Proofs.HadwigerNelson.Collapse.Density.Upper
import Proofs.HadwigerNelson.Plane.TriangularPacking
import Proofs.HadwigerNelson.Instances.Seven

/-!
# The density form of the collapse (FS-131, jobs FS131-KFR1 and FS131-IFR1; module D3)

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
* TJ's second clause `le_volume_selection` (the coordinator's ruling, inventory item 1021): the mixing selection per class keeps
  only density `(δ − ϑ)/(1 − ϑ)`.
* Item 1005's splits `six_le_chromaticNumber_planeOver_sqrt635087`, `chromaticNumber_planeOver_sqrt635087_le_seven` and the
  model at `k = 7`, `exists_model_seven` (the field `F7` of the radicand `d₇`, `data/fs131/kfr1/d7_crt.py`), are in
  `Collapse/Headline`, beside `chromaticNumber_planeOver_sqrt635087_six_or_seven` (the coordinator's ruling, item 1021).

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
  obtain ⟨μ, hμ⟩ := exists_indepLaw (F := F)
  exact le_antisymm ((finIndepRatio_planeOver_le_cayR.trans hμ).trans μ.density_le_localRatio)
    localRatio_le_finIndepRatio

/-- **B-AMEN**: `α₁(F²)` is the best density of an `R ⋊ U`-invariant random independent set of `Cay(R, U)`. -/
theorem finIndepRatio_planeOver_eq_iSup_density [NumberField F] :
    ((unitDistance ℂ).induce (planeOver F)).finIndepRatio = ⨆ μ : IndepLaw F, μ.density := by
  obtain ⟨μ, hμ⟩ := exists_indepLaw (F := F)
  refine le_antisymm ((finIndepRatio_planeOver_le_cayR.trans hμ).trans
    (le_iSup (fun μ : IndepLaw F => μ.density) μ)) ?_
  exact iSup_le fun μ => μ.density_le_localRatio.trans localRatio_le_finIndepRatio

/-! ## The fractional chromatic number -/

/-- **A Cayley target's fractional bound**: a translation-invariant graph on a finite abelian group with a nonempty
independent set `s` has `χ_f ≤ |A|/|s|` (each vertex takes the translates of `s` through it). -/
theorem fractionalChromaticNumber_le_card_div {A : Type*} [AddCommGroup A] [Finite A] {H : SimpleGraph A}
    (hH : ∀ a x y : A, H.Adj (x + a) (y + a) ↔ H.Adj x y) (s : Finset A) (hs : H.IsIndepSet (s : Set A))
    (hs0 : s.Nonempty) : H.fractionalChromaticNumber ≤ (Nat.card A : ℝ≥0∞) / s.card := by
  classical
  letI : Fintype A := Fintype.ofFinite A
  set e : A ↪ Fin (Nat.card A) := (Finite.equivFin A).toEmbedding
  -- each vertex takes the translates `s + a` through it, numbered by `a`
  have hcol : H.FractionalColorable s.card (Nat.card A) := by
    refine ⟨fun x => (Finset.univ.filter fun a : A => x - a ∈ s).map e, fun x => ?_, fun x y hxy => ?_⟩
    · rw [Finset.card_map]
      refine le_of_eq (Finset.card_nbij' (fun b => x - b) (fun a => x - a) ?_ ?_ ?_ ?_)
      · intro b hb
        simpa using hb
      · intro a ha
        simpa using (Finset.mem_filter.1 ha).2
      · intro b _
        simp
      · intro a _
        simp
    · rw [Finset.disjoint_left]
      intro j hjx hjy
      obtain ⟨a, ha, rfl⟩ := Finset.mem_map.1 hjx
      obtain ⟨a', ha', hea⟩ := Finset.mem_map.1 hjy
      obtain rfl : a' = a := e.injective hea
      have hx := (Finset.mem_filter.1 ha).2
      have hy := (Finset.mem_filter.1 ha').2
      have hadj : H.Adj (x - a') (y - a') := by
        rw [sub_eq_add_neg, sub_eq_add_neg, hH]
        exact hxy
      exact hs hx hy (H.ne_of_adj hadj) hadj
  exact hcol.fractionalChromaticNumber_le (Finset.card_pos.2 hs0)

/-- **The fractional local–global principle**: `χ_f(F²) = 1/α_loc(F)` — `≥` from `α₁(F²) = α_loc`
(`inv_finIndepRatio_le_iSup_fractionalChromaticNumber`), `≤` from the plane (`OneClass.fractionalChromaticNumber_plane`) and
every residue target (`fractionalChromaticNumber_mono_of_hom`). -/
theorem fractionalChromaticNumber_planeOver_eq [NumberField F] :
    ((unitDistance ℂ).induce (planeOver F)).fractionalChromaticNumber = (localRatio F)⁻¹ := by
  refine le_antisymm ?_ ?_
  · rw [ENNReal.le_inv_iff_le_inv, localRatio_le_iff]
    refine ⟨?_, fun P => ?_⟩
    · rw [ENNReal.le_inv_iff_le_inv, ← OneClass.fractionalChromaticNumber_plane]
      exact OneClass.fractionalChromaticNumber_induce_le _ _
    · refine iSup₂_le fun m hm => iSup₂_le fun s hs => ?_
      rcases s.eq_empty_or_nonempty with rfl | hs0
      · simp
      · haveI : Finite (𝓞 (fieldI F) ⧸ P.P ^ m) :=
          Ideal.finiteQuotientOfFreeOfNeBot _ (pow_ne_zero m P.heightOne.ne_bot)
        obtain ⟨φ, -⟩ := UpperHalf.exists_hom_levelTarget P hm
        have h1 := (fractionalChromaticNumber_mono_of_hom φ).trans
          (fractionalChromaticNumber_le_card_div (levelTarget_adj_add P m) s hs hs0)
        have hs0' : (s.card : ℝ≥0∞) ≠ 0 := by simpa using hs0.ne_empty
        have hinv : ((s.card : ℝ≥0∞) / (Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m) : ℝ≥0∞))⁻¹ =
            (Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m) : ℝ≥0∞) / s.card :=
          ENNReal.inv_div (Or.inr (ENNReal.natCast_ne_top _)) (Or.inr hs0')
        rw [ENNReal.le_inv_iff_le_inv, hinv]
        exact h1
  · rw [← finIndepRatio_planeOver_eq_localRatio]
    exact (inv_finIndepRatio_le_iSup_fractionalChromaticNumber _).trans
      (iSup_le fun S => OneClass.fractionalChromaticNumber_induce_le _ _)

/-! ## The fractional collapse -/

/-- Under uniform thickness below `1/5`, every `r_P ≤ c/(1 + c) < 1/6 < m₁(ℝ²)`, so `α_loc(F) = m₁(ℝ²)`. -/
theorem localRatio_eq_mOne_of_thick [NumberField F] {c : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c) (hc : c < 1 / 5) :
    localRatio F = mOne := by
  refine le_antisymm (localRatio_le_iff.2 ⟨le_rfl, fun P => ?_⟩) mOne_le_localRatio
  refine (stableRatio_le_of_thickAt hc0 (hT P)).trans (le_trans ?_ sixth_lt_mOne.le)
  rw [show (6 : ℝ≥0∞)⁻¹ = ENNReal.ofReal 6⁻¹ by rw [ENNReal.ofReal_inv_of_pos (by norm_num)]; norm_num]
  refine ENNReal.ofReal_le_ofReal ?_
  rw [div_le_iff₀ (by linarith)]
  linarith

/-- **The fractional collapse, density form**: at every real number field uniformly `c`-thick with `c < 1/5`,
`α₁(F²) = m₁(ℝ²)`. -/
theorem finIndepRatio_planeOver_eq_mOne_of_thick [NumberField F] {c : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c)
    (hc : c < 1 / 5) : ((unitDistance ℂ).induce (planeOver F)).finIndepRatio = mOne :=
  finIndepRatio_planeOver_eq_localRatio.trans (localRatio_eq_mOne_of_thick hT hc0 hc)

/-- The same as `α₁(F²) = α₁(ℝ²)` (`OneClass.finIndepRatio_plane_eq_mOne`). -/
theorem finIndepRatio_planeOver_eq_plane_of_thick [NumberField F] {c : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c)
    (hc : c < 1 / 5) :
    ((unitDistance ℂ).induce (planeOver F)).finIndepRatio = (unitDistance ℂ).finIndepRatio :=
  (finIndepRatio_planeOver_eq_mOne_of_thick hT hc0 hc).trans OneClass.finIndepRatio_plane_eq_mOne.symm

/-- **The fractional collapse**: at every real number field uniformly `c`-thick with `c < 1/5`, `χ_f(F²) = χ_f(ℝ²)` — beside
`chromaticNumber_planeOver_eq_plane_of_thick`'s `χ(F²) = χ(ℝ²)`. -/
theorem fractionalChromaticNumber_planeOver_eq_plane_of_thick [NumberField F] {c : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c)
    (hc : c < 1 / 5) :
    ((unitDistance ℂ).induce (planeOver F)).fractionalChromaticNumber = (unitDistance ℂ).fractionalChromaticNumber := by
  rw [fractionalChromaticNumber_planeOver_eq, localRatio_eq_mOne_of_thick hT hc0 hc,
    OneClass.fractionalChromaticNumber_plane]

/-- **`α₁(ℚ(√635087)²) = m₁(ℝ²)`**, with no hypothesis. -/
theorem finIndepRatio_planeOver_sqrt635087 :
    ((unitDistance ℂ).induce (planeOver F635087)).finIndepRatio = mOne :=
  finIndepRatio_planeOver_eq_mOne_of_thick thick_sqrt635087 (by positivity) weil_103_lt_fifth

/-- **`χ_f(ℚ(√635087)²) = χ_f(ℝ²)`**, with no hypothesis. -/
theorem fractionalChromaticNumber_planeOver_sqrt635087 :
    ((unitDistance ℂ).induce (planeOver F635087)).fractionalChromaticNumber =
      (unitDistance ℂ).fractionalChromaticNumber :=
  fractionalChromaticNumber_planeOver_eq_plane_of_thick thick_sqrt635087 (by positivity) weil_103_lt_fifth

/-- **`α₁(ℚ(√3, √5, √7, √11)²) = m₁(ℝ²)`** (de Grey's field). -/
theorem finIndepRatio_planeOver_deGrey : ((unitDistance ℂ).induce (planeOver FdG)).finIndepRatio = mOne :=
  finIndepRatio_planeOver_eq_mOne_of_thick thick_deGrey (by positivity) weil_131_lt_fifth

/-- **`χ_f(ℚ(√3, √5, √7, √11)²) = χ_f(ℝ²)`**. -/
theorem fractionalChromaticNumber_planeOver_deGrey :
    ((unitDistance ℂ).induce (planeOver FdG)).fractionalChromaticNumber =
      (unitDistance ℂ).fractionalChromaticNumber :=
  fractionalChromaticNumber_planeOver_eq_plane_of_thick thick_deGrey (by positivity) weil_131_lt_fifth

/-! ## TJ and ROUND -/

-- FS131-IFR1: **`r_P → 0` (Weil)**: every stable prime of absolute norm above some `N` has all-levels ratio at most `ε`
-- (`Collapse.thick_of_forall_thickAt`'s choice of a residue size, then `thickAt_weil`).
private theorem eventually_stableRatio_le [NumberField F] {ε : ℝ} (hε : 0 < ε) :
    ∃ N : ℕ, ∀ P : StablePrime F, N < Ideal.absNorm P.P → stableRatio P ≤ ENNReal.ofReal ε := by
  -- a residue size past which Weil's constant is below `ε`
  obtain ⟨B, hB1, hBc⟩ : ∃ B : ℕ, 1 ≤ B ∧ 2 * Real.sqrt B / ((B : ℝ) + 1) < ε := by
    refine ⟨⌈4 / ε ^ 2⌉₊ + 1, by omega, ?_⟩
    set B : ℕ := ⌈4 / ε ^ 2⌉₊ + 1
    have hB : 4 / ε ^ 2 < B := by
      have := Nat.le_ceil (4 / ε ^ 2)
      push_cast [B]
      linarith
    have hB4 : 4 < ε ^ 2 * B := by
      rw [div_lt_iff₀ (by positivity)] at hB
      linarith
    have hs0 := Real.sqrt_nonneg (B : ℝ)
    have hss := Real.sq_sqrt (show (0 : ℝ) ≤ B by positivity)
    have hcs : 2 < ε * Real.sqrt B := by
      by_contra hle
      push Not at hle
      have h0 : 0 ≤ ε * Real.sqrt B := by positivity
      have h1 : (ε * Real.sqrt B) ^ 2 ≤ 4 := by nlinarith
      have h2 : (ε * Real.sqrt B) ^ 2 = ε ^ 2 * B := by rw [mul_pow, hss]
      linarith
    rw [div_lt_iff₀ (by positivity)]
    nlinarith
  refine ⟨max (Ideal.absNorm (Ideal.span {(2 : 𝓞 (fieldI F))})) (B ^ 2), fun P hPN => ?_⟩
  have h2 : (2 : 𝓞 (fieldI F)) ∉ P.P := by
    intro h2
    have hle : Ideal.span {(2 : 𝓞 (fieldI F))} ≤ P.P := (Ideal.span_singleton_le_iff_mem _).2 h2
    have hd := Ideal.absNorm_dvd_absNorm_of_le hle
    have hne : Ideal.absNorm (Ideal.span {(2 : 𝓞 (fieldI F))}) ≠ 0 := by
      rw [Ne, Ideal.absNorm_eq_zero_iff, Ideal.span_singleton_eq_bot]
      exact two_ne_zero
    exact absurd hPN (not_lt.2 ((Nat.le_of_dvd (Nat.pos_of_ne_zero hne) hd).trans (le_max_left _ _)))
  obtain ⟨p, n, -, -, -, -, hQ, -⟩ := Rigidity.stablePrime_card_of_two_notMem P h2
  have hBQ : B ≤ p ^ n := by
    by_contra hlt
    push Not at hlt
    have hn : Ideal.absNorm P.P = (p ^ n) ^ 2 := by rw [← hQ, Ideal.absNorm_apply, Submodule.cardQuot_apply]
    rw [hn] at hPN
    exact absurd hPN (not_lt.2 ((Nat.pow_le_pow_left hlt.le 2).trans (le_max_right _ _)))
  have hQ1 : 1 ≤ p ^ n := hB1.trans hBQ
  have hκ0 : 0 ≤ 2 * Real.sqrt ((p ^ n : ℕ) : ℝ) / (((p ^ n : ℕ) : ℝ) + 1) := by positivity
  refine (stableRatio_le_of_thickAt hκ0 (thickAt_weil P h2 hQ hQ1)).trans (ENNReal.ofReal_le_ofReal ?_)
  calc 2 * Real.sqrt ((p ^ n : ℕ) : ℝ) / (((p ^ n : ℕ) : ℝ) + 1) /
        (1 + 2 * Real.sqrt ((p ^ n : ℕ) : ℝ) / (((p ^ n : ℕ) : ℝ) + 1))
      ≤ 2 * Real.sqrt ((p ^ n : ℕ) : ℝ) / (((p ^ n : ℕ) : ℝ) + 1) := div_le_self hκ0 (by linarith)
    _ ≤ 2 * Real.sqrt B / ((B : ℝ) + 1) := weil_const_anti hB1 hBQ
    _ ≤ ε := hBc.le

-- FS131-IFR1: **if every `r_P < δ`, then `⨆_P r_P < δ`** — all but finitely many are below `δ/2` (`r_P → 0`).
private theorem iSup_stableRatio_lt [NumberField F] {δ : ℝ} (hδ0 : 0 < δ)
    (h : ∀ P : StablePrime F, stableRatio P < ENNReal.ofReal δ) :
    (⨆ P : StablePrime F, stableRatio P) < ENNReal.ofReal δ := by
  obtain ⟨N, hN⟩ := eventually_stableRatio_le (F := F) (half_pos hδ0)
  have hfin : (Counting.level F N).sup stableRatio < ENNReal.ofReal δ :=
    (Finset.sup_lt_iff (ENNReal.ofReal_pos.2 hδ0)).2 fun P _ => h P
  refine lt_of_le_of_lt (iSup_le fun P => ?_)
    (max_lt hfin ((ENNReal.ofReal_lt_ofReal_iff hδ0).2 (half_lt_self hδ0)))
  by_cases hP : Ideal.absNorm P.P ≤ N
  · exact le_max_of_le_left (Finset.le_sup (f := stableRatio) ((Counting.mem_level F).2 hP))
  · exact le_max_of_le_right (hN P (not_le.1 hP))

/-- **TJ, first clause** (MR proved, so case (B) is empty): an invariant random independent set of density `δ ∈ (0, 1/2)`
has `δ ≤ max(m₁, sup r_P)` over the stable primes `P` that are `c`-thick for no `c < δ/(1 − δ)` (`N_δ`): the thick ones have
`r_P < δ`, and `r_P → 0` (Weil), so they cannot reach `δ`. -/
theorem IndepLaw.density_le_notThick [NumberField F] (μ : IndepLaw F) {δ : ℝ} (hδ0 : 0 < δ) (hδ : δ < 1 / 2)
    (hμ : μ.density = ENNReal.ofReal δ) :
    μ.density ≤ max mOne (⨆ (P : StablePrime F) (_ : ∀ c : ℝ, c < δ / (1 - δ) → ¬ ThickAt P c), stableRatio P) := by
  by_contra hlt
  push Not at hlt
  rw [hμ] at hlt
  have hm : mOne < ENNReal.ofReal δ := lt_of_le_of_lt (le_max_left _ _) hlt
  have hA : (⨆ (P : StablePrime F) (_ : ∀ c : ℝ, c < δ / (1 - δ) → ¬ ThickAt P c), stableRatio P) <
      ENNReal.ofReal δ := lt_of_le_of_lt (le_max_right _ _) hlt
  have h1δ : 0 < 1 - δ := by linarith
  -- every stable prime has `r_P < δ`: in `N_δ` by the hypothesis, outside it by Hoffman
  have hall : ∀ P : StablePrime F, stableRatio P < ENNReal.ofReal δ := by
    intro P
    by_cases hN : ∀ c : ℝ, c < δ / (1 - δ) → ¬ ThickAt P c
    · exact lt_of_le_of_lt (le_iSup₂_of_le (f := fun (P : StablePrime F)
        (_ : ∀ c : ℝ, c < δ / (1 - δ) → ¬ ThickAt P c) => stableRatio P) P hN le_rfl) hA
    · push Not at hN
      obtain ⟨c, hc, hT⟩ := hN
      set c' := max c 0 with hc'
      have hc'0 : 0 ≤ c' := le_max_right _ _
      have hc'δ : c' < δ / (1 - δ) := max_lt hc (by positivity)
      have hT' : ThickAt P c' := hT.mono (le_max_left _ _)
      refine lt_of_le_of_lt (stableRatio_le_of_thickAt hc'0 hT') ((ENNReal.ofReal_lt_ofReal_iff hδ0).2 ?_)
      have h2 := (lt_div_iff₀ h1δ).1 hc'δ
      rw [div_lt_iff₀ (by linarith)]
      linarith
  have hsup := iSup_stableRatio_lt hδ0 hall
  have hle := μ.density_le_localRatio
  rw [hμ, localRatio] at hle
  exact absurd hle (not_le.2 (max_lt hm hsup))

/-- **TJ, second clause** (FS103-F-TJ: "as a construction the mixing selection per class keeps only density
`≥ (δ − ϑ)/(1 − ϑ)`, `ϑ = λ*/(1 + λ*)`"; the coordinator's ruling, inventory item 1021). The mixing selection reads one class
on the slice `ℂ × K`: it keeps the points `z` whose fibre `W_z = {x : (z, x) ∈ W}` has Haar mass above a threshold `ϑ` —
at `ϑ` above `λ*/(1 + λ*)` two heavy fibres one unit edge apart cannot carry null edges (`not_both_ge_of_mixing`, read by
`Collapse/Selection` with `k` classes). One class keeps only what Markov's bound gives: if `W` holds at least `δ` of the
window `Q × K`, the selected points fill at least `(δ − ϑ)/(1 − ϑ)` of `Q` (with `k` classes nothing is lost, every fibre being
heavy in some class; that is the count). -/
theorem le_volume_selection [NumberField F] {W : Set (ℂ × Counting.K F)} (hW : MeasurableSet W) {Q : Set ℂ}
    (hQ : MeasurableSet Q) (hQfin : volume Q ≠ ⊤) {δ ϑ : ℝ} (hϑ0 : 0 ≤ ϑ) (hϑ1 : ϑ < 1)
    (hδ : ENNReal.ofReal δ * volume Q ≤ (volume.prod (Counting.haarK F)) (W ∩ Q ×ˢ Set.univ)) :
    ENNReal.ofReal ((δ - ϑ) / (1 - ϑ)) * volume Q ≤
      volume (Q ∩ {z | ϑ < (Counting.haarK F (Prod.mk z ⁻¹' W)).toReal}) := by
  set M : ℂ → ℝ≥0∞ := fun z => Counting.haarK F (Prod.mk z ⁻¹' W) with hMdef
  have hM : Measurable M := measurable_measure_prodMk_left hW
  have hM1 : ∀ z, M z ≤ 1 := fun z => prob_le_one
  set H := Q ∩ {z | ϑ < (M z).toReal} with hH
  have hHm : MeasurableSet H := hQ.inter (measurableSet_lt measurable_const hM.ennreal_toReal)
  have hHQ : H ⊆ Q := Set.inter_subset_left
  -- the window's mass is the integral of the fibre masses over `Q`
  have hint : (volume.prod (Counting.haarK F)) (W ∩ Q ×ˢ Set.univ) = ∫⁻ z in Q, M z := by
    rw [Measure.prod_apply (hW.inter (hQ.prod MeasurableSet.univ)), ← lintegral_indicator hQ]
    refine lintegral_congr fun z => ?_
    by_cases hz : z ∈ Q
    · rw [Set.indicator_of_mem hz]
      congr 1
      ext x
      simp [hz]
    · rw [Set.indicator_of_notMem hz]
      have e : Prod.mk z ⁻¹' (W ∩ Q ×ˢ Set.univ) = ∅ := by
        ext x
        simp [hz]
      rw [e, measure_empty]
  -- pointwise on `Q`: `M ≤ ϑ + (1 − ϑ)·1_H`
  have hpt : ∀ z ∈ Q, M z ≤ ENNReal.ofReal ϑ + ENNReal.ofReal (1 - ϑ) * H.indicator 1 z := by
    intro z hz
    by_cases hzH : z ∈ H
    · rw [Set.indicator_of_mem hzH, Pi.one_apply, mul_one, ← ENNReal.ofReal_add hϑ0 (by linarith)]
      simpa using hM1 z
    · rw [Set.indicator_of_notMem hzH, mul_zero, add_zero]
      have hle : (M z).toReal ≤ ϑ := by
        by_contra h
        exact hzH ⟨hz, not_le.1 h⟩
      rw [← ENNReal.ofReal_toReal (ne_top_of_le_ne_top ENNReal.one_ne_top (hM1 z))]
      exact ENNReal.ofReal_le_ofReal hle
  have hbound : ∫⁻ z in Q, M z ≤ ENNReal.ofReal ϑ * volume Q + ENNReal.ofReal (1 - ϑ) * volume H := by
    calc ∫⁻ z in Q, M z ≤ ∫⁻ z in Q, (ENNReal.ofReal ϑ + ENNReal.ofReal (1 - ϑ) * H.indicator 1 z) :=
          setLIntegral_mono' hQ hpt
      _ = ENNReal.ofReal ϑ * volume Q + ENNReal.ofReal (1 - ϑ) * volume H := by
        rw [lintegral_add_left measurable_const, setLIntegral_const,
          lintegral_const_mul _ (measurable_one.indicator hHm), lintegral_indicator_one hHm,
          Measure.restrict_apply hHm, Set.inter_eq_left.2 hHQ]
  have hle := hδ.trans (hint ▸ hbound)
  -- below the threshold there is nothing to prove; above it, read the inequality in `ℝ`
  rcases le_or_gt δ ϑ with hδϑ | hδϑ
  · rw [ENNReal.ofReal_of_nonpos (div_nonpos_of_nonpos_of_nonneg (by linarith) (by linarith)), zero_mul]
    exact zero_le
  have hHfin : volume H ≠ ⊤ := ne_top_of_le_ne_top hQfin (measure_mono hHQ)
  have hδ0 : 0 ≤ δ := by linarith
  have hr := (ENNReal.toReal_le_toReal (by finiteness) (by finiteness)).2 hle
  rw [ENNReal.toReal_mul, ENNReal.toReal_add (by finiteness) (by finiteness), ENNReal.toReal_mul,
    ENNReal.toReal_mul, ENNReal.toReal_ofReal hδ0, ENNReal.toReal_ofReal hϑ0,
    ENNReal.toReal_ofReal (by linarith)] at hr
  rw [← ENNReal.ofReal_toReal hQfin, ← ENNReal.ofReal_toReal hHfin,
    ← ENNReal.ofReal_mul (div_nonneg (by linarith) (by linarith))]
  refine ENNReal.ofReal_le_ofReal ?_
  rw [div_mul_eq_mul_div, div_le_iff₀ (by linarith)]
  linarith

/-- **ROUND** (FS103-F-ROUND): a `k`-colouring of `F²` has `1/k ≤ α_loc(F)` — the one place the colour count enters. -/
theorem inv_le_localRatio_of_colorable [NumberField F] {k : ℕ}
    (h : ((unitDistance ℂ).induce (planeOver F)).Colorable k) : (k : ℝ≥0∞)⁻¹ ≤ localRatio F := by
  rw [← finIndepRatio_planeOver_eq_localRatio]
  exact inv_le_finIndepRatio_of_colorable _ h

/-- **The density route never gives six**: `1/α_loc(F) < 5` at every real number field (`m₁ > 1/5`, the triangular
packing). -/
theorem inv_localRatio_lt_five (F : Subfield ℝ) : (localRatio F)⁻¹ < 5 :=
  lt_of_le_of_lt (ENNReal.inv_le_inv.2 mOne_le_localRatio) (ENNReal.inv_lt_iff_inv_lt.2 Plane.fifth_lt_mOne)

/-! ## TF and the triangle-free six-chromatic graph -/

/-- A unit triangle in `F²` puts `√3` in `F` (`v/u = e^{±iπ/3}` has imaginary part `±√3/2`). -/
theorem cliqueFree_three_planeOver_of_sqrt_three_notMem (F : Subfield ℝ) (h : Real.sqrt 3 ∉ F) :
    ((unitDistance ℂ).induce (planeOver F)).CliqueFree 3 := by
  intro t ht
  obtain ⟨x, y, z, hxy, hxz, hyz, -⟩ := SimpleGraph.is3Clique_iff.1 ht
  -- a unit edge in coordinates
  have hd : ∀ p q : planeOver F, ((unitDistance ℂ).induce (planeOver F)).Adj p q →
      ((q : ℂ).re - (p : ℂ).re) ^ 2 + ((q : ℂ).im - (p : ℂ).im) ^ 2 = 1 := by
    intro p q hpq
    have h1 : dist (p : ℂ) (q : ℂ) = 1 := hpq
    have h2 : ‖(q : ℂ) - p‖ ^ 2 = 1 := by rw [← Complex.dist_eq, _root_.dist_comm, h1]; norm_num
    rw [Complex.sq_norm, Complex.normSq_apply, Complex.sub_re, Complex.sub_im] at h2
    linear_combination h2
  set a := (y : ℂ).re - (x : ℂ).re
  set b := (y : ℂ).im - (x : ℂ).im
  set c := (z : ℂ).re - (x : ℂ).re
  set d := (z : ℂ).im - (x : ℂ).im
  have h1 : a ^ 2 + b ^ 2 = 1 := hd x y hxy
  have h2 : c ^ 2 + d ^ 2 = 1 := hd x z hxz
  have h3 : (c - a) ^ 2 + (d - b) ^ 2 = 1 := by
    have := hd y z hyz
    linear_combination this
  have hs : a * c + b * d = 1 / 2 := by linear_combination (h1 + h2 - h3) / 2
  have ht2 : (2 * (b * c - a * d)) ^ 2 = 3 := by
    linear_combination 4 * (c ^ 2 + d ^ 2) * h1 + 4 * h2 - 4 * (a * c + b * d + 1 / 2) * hs
  have hmem : 2 * (b * c - a * d) ∈ F := by
    have ha : a ∈ F := F.sub_mem y.2.1 x.2.1
    have hb : b ∈ F := F.sub_mem y.2.2 x.2.2
    have hc : c ∈ F := F.sub_mem z.2.1 x.2.1
    have hd' : d ∈ F := F.sub_mem z.2.2 x.2.2
    have h2F : (2 : ℝ) ∈ F := by simp
    exact F.mul_mem h2F (F.sub_mem (F.mul_mem hb hc) (F.mul_mem ha hd'))
  apply h
  rw [← ht2, Real.sqrt_sq_eq_abs]
  rcases abs_choice (2 * (b * c - a * d)) with he | he <;> rw [he]
  · exact hmem
  · exact F.neg_mem hmem

/-- **`√3 ∉ ℚ(√635087)`**: `635087 ≡ 1 (mod 17)`, so `ℚ(√635087)` maps to `ℚ₁₇` (`QuadraticPrime.nonempty_ringHom_padic`),
and `3` is not a square modulo `17`. -/
theorem sqrt_three_notMem_F635087 : Real.sqrt 3 ∉ F635087 := by
  intro h3
  have h0 : ((635087 : ℕ) : ZMod 17) ≠ 0 := by decide
  have h1 : IsSquare ((635087 : ℕ) : ZMod 17) := by decide
  have hn3 : ¬ IsSquare (3 : ZMod 17) := by decide
  haveI : Fact (Nat.Prime 17) := ⟨by norm_num⟩
  obtain ⟨ι⟩ := QuadraticPrime.nonempty_ringHom_padic {635087} (p := 17) (by norm_num) (by
    intro d hd
    rw [Set.mem_singleton_iff] at hd
    subst hd
    exact ⟨h0, h1⟩)
  -- `ι(√3)² = 3` in `ℚ₁₇`
  set s : F635087 := ⟨Real.sqrt 3, h3⟩
  have hs : s * s = 3 := by
    apply Subtype.ext
    rw [Subfield.coe_mul]
    show Real.sqrt 3 * Real.sqrt 3 = ((3 : F635087) : ℝ)
    rw [Real.mul_self_sqrt (by norm_num)]
    exact (map_ofNat F635087.subtype 3).symm
  have hι : ι s ^ 2 = 3 := by rw [sq, ← map_mul, hs, map_ofNat]
  -- so `ι(√3)` is a `17`-adic integer
  have hnorm : ‖ι s‖ ≤ 1 := by
    have h1 : ‖ι s‖ ^ 2 ≤ 1 := by
      rw [← norm_pow, hι]
      exact_mod_cast Padic.norm_int_le_one (p := 17) 3
    nlinarith [norm_nonneg (ι s)]
  set z : ℤ_[17] := ⟨ι s, hnorm⟩
  have hz : z ^ 2 = 3 := by
    apply PadicInt.ext
    rw [PadicInt.coe_pow]
    exact_mod_cast hι
  -- and `3` is a square modulo `17`, which it is not
  have hsq : IsSquare (3 : ZMod 17) := ⟨PadicInt.toZMod z, by rw [← sq, ← map_pow, hz, map_ofNat]⟩
  exact hn3 hsq

/-- **TF**: for every `ε > 0` a finite triangle-free unit-distance graph — a finite set of `ℚ(√635087)²` — whose
independence ratio is below `m₁(ℝ²) + ε`. -/
theorem exists_triangleFree_ratio_lt {ε : ℝ≥0∞} (hε : 0 < ε) :
    ∃ S : Finset ℂ, S.Nonempty ∧ ((unitDistance ℂ).induce (S : Set ℂ)).CliqueFree 3 ∧
      (((unitDistance ℂ).induce (S : Set ℂ)).indepNum : ℝ≥0∞) < (mOne + ε) * S.card := by
  classical
  have hlt : ((unitDistance ℂ).induce (planeOver F635087)).finIndepRatio < mOne + ε := by
    rw [finIndepRatio_planeOver_sqrt635087]
    exact ENNReal.lt_add_right (ne_top_of_le_ne_top ENNReal.one_ne_top mOne_le_one) hε.ne'
  have hnot := not_le.2 hlt
  rw [SimpleGraph.le_finIndepRatio_iff] at hnot
  push Not at hnot
  obtain ⟨S, hSne, hS⟩ := hnot
  set e : planeOver F635087 ↪ ℂ := Function.Embedding.subtype _
  refine ⟨S.map e, hSne.map, ?_, ?_⟩
  · -- triangle-free: the induced graph embeds into `ℚ(√635087)²`
    have hcf := cliqueFree_three_planeOver_of_sqrt_three_notMem F635087 sqrt_three_notMem_F635087
    have hmem : ∀ v : ((S.map e : Finset ℂ) : Set ℂ), (v : ℂ) ∈ planeOver F635087 := by
      rintro ⟨v, hv⟩
      obtain ⟨w, -, rfl⟩ := Finset.mem_map.1 (Finset.mem_coe.1 hv)
      exact w.2
    let f : (unitDistance ℂ).induce ((S.map e : Finset ℂ) : Set ℂ) ↪g (unitDistance ℂ).induce (planeOver F635087) :=
      { toFun := fun v => ⟨v, hmem v⟩
        inj' := fun v w h => Subtype.ext (congrArg (fun u : planeOver F635087 => (u : ℂ)) h)
        map_rel_iff' := Iff.rfl }
    exact hcf.comap ⟨f.toCopy⟩
  · -- the independence number: a largest independent set pulls back to `S`
    obtain ⟨J, hJS, hJ, hJc⟩ := SimpleGraph.exists_indep_card_eq_indepNum (unitDistance ℂ) (S.map e)
    set J₀ := S.filter fun x => e x ∈ J with hJ₀
    have hJ₀map : J₀.map e = J := by
      ext y
      simp only [hJ₀, Finset.mem_map, Finset.mem_filter]
      constructor
      · rintro ⟨x, ⟨-, hx⟩, rfl⟩
        exact hx
      · intro hy
        obtain ⟨x, hx, rfl⟩ := Finset.mem_map.1 (hJS hy)
        exact ⟨x, ⟨hx, hy⟩, rfl⟩
    have hJ₀i : ((unitDistance ℂ).induce (planeOver F635087)).IsIndepSet (J₀ : Set (planeOver F635087)) := by
      intro x hx y hy hxy hadj
      exact hJ (Finset.mem_filter.1 hx).2 (Finset.mem_filter.1 hy).2 (fun h => hxy (e.injective h)) hadj
    have hcard := hS J₀ (Finset.filter_subset _ _) hJ₀i
    rw [← hJc, ← hJ₀map, Finset.card_map, Finset.card_map]
    exact hcard

/-- **A finite triangle-free six-chromatic unit-distance graph**: compactness (de Bruijn–Erdős) on `6 ≤ χ(ℚ(√635087)²)`
gives a finite subset with no five-colouring; a minimal one is six-chromatic; it is triangle-free with the field. -/
theorem exists_finite_triangleFree_six_chromatic :
    ∃ S : Finset ℂ, ((unitDistance ℂ).induce (S : Set ℂ)).CliqueFree 3 ∧
      ((unitDistance ℂ).induce (S : Set ℂ)).chromaticNumber = 6 := by
  classical
  -- `ℚ(√635087)²` is not five-colourable
  have hG5 : ¬ ((unitDistance ℂ).induce (planeOver F635087)).Colorable 5 := fun h =>
    absurd (six_le_chromaticNumber_planeOver_sqrt635087.trans h.chromaticNumber_le) (by norm_num)
  -- compactness (de Bruijn–Erdős): some finite part of it is not five-colourable
  obtain ⟨S₀, hS₀sub, hS₀⟩ : ∃ S₀ : Finset ℂ, (S₀ : Set ℂ) ⊆ planeOver F635087 ∧
      ¬ ((unitDistance ℂ).induce (S₀ : Set ℂ)).Colorable 5 := by
    by_contra hall
    push Not at hall
    refine hG5 (nonempty_hom_of_forall_finite_subgraph_hom fun G' hfin =>
      Nonempty.some (α := G'.coe.Coloring (Fin 5)) ?_)
    set T : Finset ℂ := hfin.toFinset.map (Function.Embedding.subtype _) with hT
    have hTsub : (T : Set ℂ) ⊆ planeOver F635087 := by
      intro z hz
      obtain ⟨w, -, rfl⟩ := Finset.mem_map.1 (Finset.mem_coe.1 hz)
      exact w.2
    obtain ⟨C⟩ := hall T hTsub
    exact ⟨C.comp ⟨fun v => ⟨(v.1 : ℂ), Finset.mem_coe.2 (Finset.mem_map_of_mem _ (hfin.mem_toFinset.2 v.2))⟩,
      fun {x y} h => G'.adj_sub h⟩⟩
  -- a smallest such part
  obtain ⟨S, hSmem, hSmin⟩ := Finset.exists_min_image
    (S₀.powerset.filter fun S : Finset ℂ => ¬ ((unitDistance ℂ).induce (S : Set ℂ)).Colorable 5) Finset.card
    ⟨S₀, Finset.mem_filter.2 ⟨Finset.mem_powerset_self S₀, hS₀⟩⟩
  obtain ⟨hSS₀, hS5⟩ := Finset.mem_filter.1 hSmem
  have hSsub : (S : Set ℂ) ⊆ planeOver F635087 :=
    (Finset.coe_subset.2 (Finset.mem_powerset.1 hSS₀)).trans hS₀sub
  refine ⟨S, ?_, ?_⟩
  · -- triangle-free with the field
    have hcf := cliqueFree_three_planeOver_of_sqrt_three_notMem F635087 sqrt_three_notMem_F635087
    let f : (unitDistance ℂ).induce (S : Set ℂ) ↪g (unitDistance ℂ).induce (planeOver F635087) :=
      { toFun := fun v => ⟨v, hSsub v.2⟩
        inj' := fun v w h => Subtype.ext (congrArg (fun u : planeOver F635087 => (u : ℂ)) h)
        map_rel_iff' := Iff.rfl }
    exact hcf.comap ⟨f.toCopy⟩
  · -- six colours suffice: drop a vertex, five-colour the rest, give it the sixth
    rcases S.eq_empty_or_nonempty with rfl | ⟨v, hv⟩
    · exact absurd ⟨Coloring.mk (fun w => (Finset.notMem_empty _ (Finset.mem_coe.1 w.2)).elim)
        fun {w} _ _ => (Finset.notMem_empty _ (Finset.mem_coe.1 w.2)).elim⟩ hS5
    have hC5 : ((unitDistance ℂ).induce ((S.erase v : Finset ℂ) : Set ℂ)).Colorable 5 := by
      by_contra hcon
      have := hSmin (S.erase v) (Finset.mem_filter.2
        ⟨Finset.mem_powerset.2 ((Finset.erase_subset v S).trans (Finset.mem_powerset.1 hSS₀)), hcon⟩)
      exact absurd this (not_le.2 (Finset.card_erase_lt_of_mem hv))
    obtain ⟨C⟩ := hC5
    have h6 : ((unitDistance ℂ).induce (S : Set ℂ)).Colorable 6 := by
      refine ⟨Coloring.mk (fun w => if h : (w : ℂ) = v then Fin.last 5 else
        Fin.castSucc (C ⟨w, Finset.mem_coe.2 (Finset.mem_erase.2 ⟨h, Finset.mem_coe.1 w.2⟩)⟩)) ?_⟩
      intro x y hxy
      have hne : (x : ℂ) ≠ y := fun h => ((unitDistance ℂ).induce (S : Set ℂ)).ne_of_adj hxy (Subtype.ext h)
      by_cases hx : (x : ℂ) = v <;> by_cases hy : (y : ℂ) = v
      · exact absurd (hx.trans hy.symm) hne
      · simp only [hx, hy, dite_true, dite_false]
        exact (Fin.castSucc_lt_last _).ne'
      · simp only [hx, hy, dite_true, dite_false]
        exact (Fin.castSucc_lt_last _).ne
      · simp only [hx, hy, dite_false, ne_eq, Fin.castSucc_inj]
        exact C.valid hxy
    rw [show (6 : ℕ∞) = (5 : ℕ) + 1 from rfl, chromaticNumber_eq_iff_colorable_not_colorable]
    exact ⟨h6, hS5⟩

end

end HadwigerNelson.Collapse
