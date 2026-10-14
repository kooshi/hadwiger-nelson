import Proofs.HadwigerNelson.Plane.OneAvoidingDensity
import Proofs.HadwigerNelson.Plane.DensityPoints
import Proofs.HadwigerNelson.Plane.UnitAvoiding
import Proofs.HadwigerNelson.Plane.Slack

/-!
# `m₁` in a window, and the neighbourhood ratio of the unit-distance graph (FS-131, job FS131-K12A; module M12, block P)

**Read aloud, against the derivation** (J28D § 3.2 C4, "Lemma X′" and C14.1-e; `plans/FS86-R88-D-derivation.md`). The count
reads the plane's measurable independence ratio `m₁ = Plane.mOne` in two finite forms, both about one square window
`squareWin a s = [a.re, a.re + s) × [a.im, a.im + s)` and both for sets whose unit pairs are null (`UnitPairsNull`: the essential,
measure-zero form of "1-avoiding"):

* `volume_inter_sq_le` — **`m₁` in a window**: `|A ∩ squareWin a s| ≤ m₁ · (s + 2)²`. Route, every step in the kernel: the
  density points of `A` form a measurable 1-avoiding set equal to `A` almost everywhere (`Plane.measurableSet_densitySet`,
  `Plane.dist_ne_one_of_mem_densitySet`); its trace on the window, periodised at `s + 2` (`Plane.periodize`,
  `Plane.bandFree_periodize`, `Plane.measurableSet_periodize` of `Plane/Slack`), is 1-avoiding with upper density
  `|trace| / (s + 2)²` (`Plane.upperDensity_periodize`), which `m₁` bounds (`Plane.mOne_eq_iSup_bandFree`: `m₁` over
  Lebesgue-measurable sets with no pair at distance `1`).
* `exists_periodic_near_mOne` — **a periodic 1-avoiding set of density near `m₁`**: the supremum defining `m₁`, a dense
  window (`Plane.exists_squareWin_dense`), periodised.
* `exists_nrWindow` — **the neighbourhood ratio** (C14.1-e), with one scale for every set (`NRWindow ε s₀`):
  `|Z ∩ squareWin a s| ≤ m₁ |N_e[Z] ∩ squareWin a s| + ε s²` for `s ≥ s₀`, where `N_e[Z] = Z ∪ {x : the unit circle about x meets Z in
  positive length}` (`essNbhd`). Route: for a near-optimal periodic `J` and `t` in its cell, `((J + t) \ N_e[Z]) ∪ Z` has
  null unit pairs (`unitPairsNull_diff_essNbhd_union`), so the window bound applies to it; averaging over `t` gives
  `|Z ∩ Q| + δ_J |Q \ N_e[Z]| ≤ m₁ (s + 2)²`.

Nothing here reads `[AmbrusEtAl2023]`: `m₁` is the library's supremum (`Plane/OneClass/Defs`, read here through
`Plane.mOne_eq_iSup_bandFree` since the chain's landing, FS131-LCH1), and the count applies `Plane.mOne_lt_quarter` to
it. All three are the derivation's window lemmas restated for one plane — the count's
archimedean factor is one copy of `UD(ℝ²)` at every number field (module `Rigidity/CountTorus`, the slice `Δ = ℚ(i) ⊗ ℝ`).

**Models.** The empty set and the open disc of radius `1/3` have null unit pairs (`Plane.unitPairsNull_of_dist_lt_one`);
`essNbhd ∅ = ∅`.
-/

namespace HadwigerNelson.Plane

open MeasureTheory Filter Metric Set Complex

noncomputable section

-- FS131-ICL1: the proofs. `exists_nrWindow` averages one dense window over the translates that meet the window
-- `squareWin a s` (`lintegral_volume_translate_inter`), where the plan averaged a periodic set over its cell: the window
-- is chosen after `s`, of side `ℓ ≥ 12 s / ε`, so no periodicity and no cell lemma is read.

/-- **The essential closed neighbourhood** `N_e[Z]`: `Z` together with the points whose unit circle meets `Z` in positive
length (`Plane.phi Z x ≠ 0`). -/
def essNbhd (Z : Set ℂ) : Set ℂ := Z ∪ {x | phi Z x ≠ 0}

theorem measurableSet_essNbhd {Z : Set ℂ} (hZ : MeasurableSet Z) : MeasurableSet (essNbhd Z) :=
  hZ.union ((measurable_phi hZ) (measurableSet_singleton 0)).compl

/-- **Regularisation**: the density points of a measurable set with null unit pairs form a 1-avoiding set equal to it almost
everywhere. -/
theorem densitySet_bandFree {A : Set ℂ} (hA : MeasurableSet A) (h : UnitPairsNull A) :
    BandFree (densitySet A) 0 ∧ densitySet A =ᵐ[volume] A := by
  refine ⟨fun x hx y hy => ?_, (ae_eq_densitySet hA).symm⟩
  have h1 : dist x y ≠ 1 :=
    dist_ne_one_of_mem_densitySet hA h hy (upperDensityAt_pos_of_mem_densitySet hx)
  rcases lt_or_gt_of_ne h1 with h2 | h2
  · left; linarith
  · right; linarith

/-- **`m₁` in a window.** -/
theorem volume_inter_sq_le {A : Set ℂ} (hA : MeasurableSet A) (h : UnitPairsNull A) (a : ℂ) {s : ℝ} (hs : 0 < s) :
    volume (A ∩ squareWin a s) ≤ mOne * ENNReal.ofReal ((s + 2) ^ 2) := by
  obtain ⟨hbf, hae⟩ := densitySet_bandFree hA h
  set T := densitySet A ∩ squareWin a s with hT
  have hTm : MeasurableSet T := (measurableSet_densitySet hA).inter (measurableSet_squareWin a s)
  have hTw : T ⊆ squareWin a s := inter_subset_right
  have hTbf : BandFree T 0 := fun x hx y hy => hbf x hx.1 y hy.1
  have hP : BandFree (periodize T (s + 2)) 0 := bandFree_periodize hTw (by norm_num) hTbf
  have hPm : MeasurableSet (periodize T (s + 2)) := measurableSet_periodize hTm (s + 2)
  have hle : upperDensity (periodize T (s + 2)) ≤ mOne := by
    rw [mOne_eq_iSup_bandFree]
    exact le_iSup₂ (f := fun (B : Set ℂ) (_ : NullMeasurableSet B volume ∧ BandFree B 0) => upperDensity B)
      (periodize T (s + 2)) ⟨hPm.nullMeasurableSet, hP⟩
  rw [upperDensity_periodize hTm hs hTw] at hle
  have hne0 : ENNReal.ofReal ((s + 2) ^ 2) ≠ 0 := by
    rw [ne_eq, ENNReal.ofReal_eq_zero, not_le]; positivity
  calc volume (A ∩ squareWin a s) = volume T := measure_congr (hae.symm.inter EventuallyEq.rfl)
    _ ≤ mOne * ENNReal.ofReal ((s + 2) ^ 2) := (ENNReal.div_le_iff hne0 ENNReal.ofReal_ne_top).mp hle

/-- `m₁` is finite. -/
private theorem mOne_ne_top : mOne ≠ ⊤ :=
  ne_top_of_le_ne_top ENNReal.one_ne_top mOne_le_one

/-- `m₁ ≤ 1`, read in `ℝ`. -/
private theorem mOne_toReal_le_one : mOne.toReal ≤ 1 :=
  calc mOne.toReal ≤ (1 : ENNReal).toReal :=
        ENNReal.toReal_mono ENNReal.one_ne_top mOne_le_one
    _ = 1 := ENNReal.toReal_one

/-- **A dense window of every positive integer side**: a measurable 1-avoiding set inside `squareWin 0 ℓ` of measure at
least `(m₁ − δ) ℓ²` (the supremum defining `m₁`, a measurable part of a near-optimal set, `Plane.exists_squareWin_dense`,
translated to the origin). -/
private theorem exists_dense_window {δ : ℝ} (hδ : 0 < δ) (ℓ : ℕ) (hℓ : 0 < ℓ) :
    ∃ T : Set ℂ, MeasurableSet T ∧ BandFree T 0 ∧ T ⊆ squareWin 0 ℓ ∧
      (mOne.toReal - δ) * (ℓ : ℝ) ^ 2 ≤ volume.real T := by
  by_cases hm : mOne.toReal ≤ δ
  · refine ⟨∅, MeasurableSet.empty, fun x hx => absurd hx (notMem_empty x), empty_subset _, ?_⟩
    rw [measureReal_empty]
    exact mul_nonpos_of_nonpos_of_nonneg (by linarith) (sq_nonneg _)
  push Not at hm
  set d := mOne.toReal - δ with hd
  have hd0 : 0 < d := by linarith
  have hdlt : ENNReal.ofReal d < mOne := by
    rw [← ENNReal.ofReal_toReal mOne_ne_top]
    exact (ENNReal.ofReal_lt_ofReal_iff (by linarith)).mpr (by linarith)
  rw [mOne_eq_iSup_bandFree] at hdlt
  obtain ⟨A, hA⟩ := lt_iSup_iff.mp hdlt
  obtain ⟨⟨hAm, hAbf⟩, hAd⟩ := lt_iSup_iff.mp hA
  obtain ⟨B, hBA, hBm, hBae⟩ := hAm.exists_measurable_subset_ae_eq
  have hBd : ENNReal.ofReal d < upperDensity B := by
    have : upperDensity B = upperDensity A := by
      unfold upperDensity
      congr 1
      funext R
      rw [measure_congr (hBae.inter EventuallyEq.rfl)]
    rwa [this]
  obtain ⟨p, q, hpq⟩ := exists_squareWin_dense hBm hBd ℓ hℓ
  set z : ℂ := ((ℓ * p : ℝ) : ℂ) + ((ℓ * q : ℝ) : ℂ) * I with hz
  set W := B ∩ squareWin z ℓ with hW
  have hWm : MeasurableSet W := hBm.inter (measurableSet_squareWin _ _)
  refine ⟨(· + z) ⁻¹' W, (measurable_add_const z) hWm, fun x hx y hy => ?_, fun x hx => ?_, ?_⟩
  · have := hAbf _ (hBA hx.1) _ (hBA hy.1)
    rwa [dist_add_right] at this
  · have h1 := hx.2
    simp only [squareWin, mem_setOf_eq, Complex.add_re, Complex.add_im, Complex.zero_re,
      Complex.zero_im, zero_add] at h1 ⊢
    refine ⟨by linarith, by linarith, by linarith, by linarith⟩
  · have hvol : volume ((· + z) ⁻¹' W) = volume W := measure_preimage_add_right volume z W
    have hfin : volume W ≠ ⊤ := by
      refine ne_top_of_le_ne_top ?_ (measure_mono inter_subset_right)
      rw [volume_squareWin _ (by positivity)]; exact ENNReal.ofReal_ne_top
    rw [measureReal_def, hvol]
    have : ENNReal.ofReal (d * (ℓ : ℝ) ^ 2) ≤ volume W := hpq
    exact (ENNReal.ofReal_le_iff_le_toReal hfin).mp this

/-- The arithmetic of `exists_periodic_near_mOne`: a window of side `ℓ ≥ 16/ε + 1` filled to `m − ε/2` fills its
period cell `ℓ + 2` to `m − ε`. -/
private theorem arith_periodic {m ε ℓ X v : ℝ} (hm1 : m ≤ 1) (hε : 0 < ε) (hℓ : 16 / ε + 1 ≤ ℓ)
    (hv : (m - ε / 2) * ℓ ^ 2 ≤ v) (hvX : v ≤ X) (hX : 0 ≤ X) : (m - ε) * (ℓ + 2) ^ 2 ≤ X := by
  have h16 : 16 / ε ≤ ℓ - 1 := by linarith
  have h16' : 16 ≤ (ℓ - 1) * ε := (div_le_iff₀ hε).mp h16
  have hℓ1 : 1 ≤ ℓ := by have : 0 ≤ 16 / ε := by positivity
                         linarith
  by_cases hme : m - ε ≤ 0
  · exact le_trans (mul_nonpos_of_nonpos_of_nonneg hme (sq_nonneg _)) hX
  push Not at hme
  have h1 : (m - ε) * (4 * ℓ + 4) ≤ 4 * ℓ + 4 :=
    mul_le_of_le_one_left (by linarith) (by linarith)
  have h2 : 8 * ℓ ≤ ε / 2 * ℓ * ℓ := by
    have : 8 ≤ ε / 2 * ℓ := by nlinarith
    nlinarith
  nlinarith

/-- **A periodic 1-avoiding set of density within `ε` of `m₁`**, its period at least `L₀`. -/
theorem exists_periodic_near_mOne {ε : ℝ} (hε : 0 < ε) :
    ∃ L : ℝ, 0 < L ∧ ∃ J : Set ℂ, MeasurableSet J ∧ BandFree J 0 ∧ IsPeriodicSet L J ∧
      mOne.toReal - ε ≤ volume.real (J ∩ squareWin 0 L) / L ^ 2 := by
  obtain ⟨ℓ, hℓ⟩ : ∃ ℓ : ℕ, 16 / ε + 1 ≤ ℓ := ⟨⌈16 / ε + 1⌉₊, Nat.le_ceil _⟩
  have hℓ1 : (1 : ℝ) ≤ ℓ := by have : 0 ≤ 16 / ε := by positivity
                               linarith
  have hℓpos : 0 < ℓ := by exact_mod_cast (show (0 : ℝ) < ℓ by linarith)
  obtain ⟨T, hTm, hTbf, hTw, hTv⟩ := exists_dense_window (half_pos hε) ℓ hℓpos
  have hL : (0 : ℝ) < ℓ + 2 := by linarith
  refine ⟨ℓ + 2, hL, periodize T (ℓ + 2), measurableSet_periodize hTm _,
    bandFree_periodize hTw (by norm_num) hTbf, isPeriodicSet_periodize T _, ?_⟩
  have hsub : T ⊆ periodize T (ℓ + 2) ∩ squareWin 0 (ℓ + 2) := by
    intro x hx
    refine ⟨⟨0, 0, by simpa using hx⟩, ?_⟩
    have := hTw hx
    simp only [squareWin, mem_setOf_eq, Complex.zero_re, Complex.zero_im, zero_add] at this ⊢
    exact ⟨this.1, by linarith [this.2.1], this.2.2.1, by linarith [this.2.2.2]⟩
  have hfin : volume (periodize T (ℓ + 2) ∩ squareWin 0 (ℓ + 2)) ≠ ⊤ := by
    refine ne_top_of_le_ne_top ?_ (measure_mono inter_subset_right)
    rw [volume_squareWin _ hL.le]; exact ENNReal.ofReal_ne_top
  have hmono : volume.real T ≤ volume.real (periodize T (ℓ + 2) ∩ squareWin 0 (ℓ + 2)) :=
    measureReal_mono hsub hfin
  rw [le_div_iff₀ (by positivity)]
  exact arith_periodic mOne_toReal_le_one hε hℓ hTv hmono measureReal_nonneg

/-- **C14.1-e's union**: a 1-avoiding set with the essential neighbourhood of a set with null unit pairs removed, together
with that set, has null unit pairs. -/
theorem unitPairsNull_diff_essNbhd_union {J Z : Set ℂ} (hJ : MeasurableSet J) (hJ1 : BandFree J 0)
    (hZ : MeasurableSet Z) (hZ1 : UnitPairsNull Z) : UnitPairsNull ((J \ essNbhd Z) ∪ Z) := by
  set D := J \ essNbhd Z with hD
  have hDm : MeasurableSet D := hJ.diff (measurableSet_essNbhd hZ)
  -- pairs inside `J`: none
  have hJJ : pairSet D D = ∅ := by
    ext q
    simp only [pairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
    intro h1 h2
    have hd : dist q.1 (q.1 + e q.2) = 1 := by
      rw [dist_comm, dist_eq_norm, add_sub_cancel_left]
      simp [e, Complex.norm_exp_ofReal_mul_I]
    rcases hJ1 _ h1.1 _ h2.1 with h | h <;> linarith
  -- from `D` into `Z`: the slices are null off the essential neighbourhood
  have hDZ : (volume.prod arcLength) (pairSet D Z) = 0 := by
    rw [pairSet_measure_eq_lintegral hDm hZ]
    refine (setLIntegral_congr_fun hDm (fun p hp => ?_)).trans (lintegral_zero)
    have : p ∉ essNbhd Z := hp.2
    simp only [essNbhd, mem_union, mem_setOf_eq, not_or, not_not] at this
    exact this.2
  -- from `Z` into `D`: the swap
  have hZD : (volume.prod arcLength) (pairSet Z D) = 0 := by
    rw [pairSet_null_iff_ae_slice hZ hDm]
    have h1 := (pairSet_null_iff_ae_slice hDm hZ).mp hDZ
    have h2 := ae_arcLength_shift_pi (fun θ => volume {x : ℂ | x ∈ D ∧ x + e θ ∈ Z})
      (fun θ => by simp [e_add_two_pi]) h1
    filter_upwards [h2] with θ hθ
    rw [volume_slice_swap]
    exact hθ
  -- assemble
  have hsub : unitPairSet (D ∪ Z) ⊆ pairSet D D ∪ pairSet Z Z ∪ pairSet D Z ∪ pairSet Z D := by
    intro q hq
    simp only [unitPairSet, pairSet, mem_setOf_eq, mem_union] at hq ⊢
    tauto
  refine measure_mono_null hsub ?_
  rw [hJJ, empty_union]
  exact measure_union_null (measure_union_null hZ1 hDZ) hZD

/-- **The neighbourhood ratio of the unit-distance graph, in a window, at scale `s₀` and slack `ε`** (C14.1-e) — uniform
in the set, as the count reads it (one `s₀` for the lonely sets of every row at every level). -/
def NRWindow (ε s₀ : ℝ) : Prop :=
  ∀ Z : Set ℂ, MeasurableSet Z → UnitPairsNull Z → ∀ (a : ℂ) (s : ℝ), s₀ ≤ s →
    volume.real (Z ∩ squareWin a s) ≤ mOne.toReal * volume.real (essNbhd Z ∩ squareWin a s) + ε * s ^ 2

/-- **Averaging a set over its translates** (Tonelli on `ℂ × ℂ`): when every translate `T + t` that meets `E` has `t ∈ D`,
the translates `T + t`, `t ∈ D`, meet `E` in total measure `|T| |E|`. -/
private theorem lintegral_volume_translate_inter {T E D : Set ℂ} (hT : MeasurableSet T) (hE : MeasurableSet E)
    (hsub : ∀ x ∈ E, ∀ t, x - t ∈ T → t ∈ D) :
    ∫⁻ t in D, volume ((fun x => x - t) ⁻¹' T ∩ E) = volume T * volume E := by
  set S : Set (ℂ × ℂ) := {p | p.2 - p.1 ∈ T ∧ p.2 ∈ E} with hS
  have hSm : MeasurableSet S := ((measurable_snd.sub measurable_fst) hT).inter (measurable_snd hE)
  have h1 : ((volume.restrict D).prod volume) S = ∫⁻ t in D, volume ((fun x => x - t) ⁻¹' T ∩ E) := by
    rw [Measure.prod_apply hSm]
    rfl
  have h3 : ∀ x, (volume.restrict D) ((fun t => (t, x)) ⁻¹' S) = E.indicator (fun _ => volume T) x := by
    intro x
    by_cases hx : x ∈ E
    · rw [indicator_of_mem hx]
      have hpre : (fun t => (t, x)) ⁻¹' S = (fun t => x - t) ⁻¹' T := by
        ext t; simp [hS, hx]
      have hmeas : MeasurableSet ((fun t => x - t) ⁻¹' T) := (measurable_const_sub x) hT
      rw [hpre, Measure.restrict_apply hmeas,
        inter_eq_left.mpr (show (fun t => x - t) ⁻¹' T ⊆ D from fun t ht => hsub x hx t ht)]
      exact (Measure.measurePreserving_sub_left volume x).measure_preimage hT.nullMeasurableSet
    · rw [indicator_of_notMem hx]
      have hpre : (fun t => (t, x)) ⁻¹' S = ∅ := by
        ext t; simp [hS, hx]
      rw [hpre, measure_empty]
  rw [← h1, Measure.prod_apply_symm hSm]
  simp_rw [h3]
  rw [lintegral_indicator_const hE, mul_comm]

/-- The arithmetic of `exists_nrWindow`: the averaged window inequality `X·(s + ℓ)² + v_T·(s² − Y) ≤ m (s + 2)² (s + ℓ)²`,
with `v_T ≥ (m − ε/4) ℓ²`, `ℓ ≥ s`, `ℓ ≥ 12 s/ε` and `s ≥ 16/ε`, gives `X ≤ m Y + ε s²`. -/
private theorem arith_nrWindow {m ε s ℓ X Y vT : ℝ} (hm1 : m ≤ 1) (hε : 0 < ε) (hs1 : 1 ≤ s)
    (hs16 : 16 / ε ≤ s) (hℓs : s ≤ ℓ) (hℓε : 12 * s / ε ≤ ℓ) (hYs : Y ≤ s ^ 2)
    (hvT : (m - ε / 4) * ℓ ^ 2 ≤ vT) (hvT0 : 0 ≤ vT)
    (hY0 : 0 ≤ Y) (h : X * (s + ℓ) ^ 2 + vT * (s ^ 2 - Y) ≤ m * (s + 2) ^ 2 * (s + ℓ) ^ 2) :
    X ≤ m * Y + ε * s ^ 2 := by
  have hs0 : 0 < s := by linarith
  have hℓ0 : 0 < ℓ := by linarith
  have hA : 0 < (s + ℓ) ^ 2 := by positivity
  -- the translates' average fill is at least `m − ε/2`
  have hc : (m - ε / 2) * (s + ℓ) ^ 2 ≤ vT := by
    by_cases hme : m - ε / 2 ≤ 0
    · exact le_trans (mul_nonpos_of_nonpos_of_nonneg hme hA.le) hvT0
    push Not at hme
    have h12 : 12 * s ≤ ε * ℓ := by
      have := (div_le_iff₀ hε).mp hℓε; linarith
    have hsl : 0 ≤ 2 * s * ℓ + s ^ 2 := by positivity
    have h1 : (m - ε / 2) * (2 * s * ℓ + s ^ 2) ≤ 2 * s * ℓ + s ^ 2 :=
      mul_le_of_le_one_left hsl (by linarith)
    have h2 : s * s ≤ s * ℓ := mul_le_mul_of_nonneg_left hℓs (by linarith)
    have h3 : 12 * s * ℓ ≤ ε * ℓ * ℓ := mul_le_mul_of_nonneg_right h12 (by linarith)
    nlinarith
  have h2 : (m - ε / 2) * (s + ℓ) ^ 2 * (s ^ 2 - Y) ≤ vT * (s ^ 2 - Y) :=
    mul_le_mul_of_nonneg_right hc (sub_nonneg.2 hYs)
  have h3 : X * (s + ℓ) ^ 2 ≤ (m * (s + 2) ^ 2 - (m - ε / 2) * (s ^ 2 - Y)) * (s + ℓ) ^ 2 := by
    nlinarith
  have h4 : X ≤ m * (s + 2) ^ 2 - (m - ε / 2) * (s ^ 2 - Y) := le_of_mul_le_mul_right h3 hA
  have h5 : m * (4 * s + 4) ≤ 4 * s + 4 := mul_le_of_le_one_left (by linarith) hm1
  have h16 : 16 ≤ s * ε := (div_le_iff₀ hε).mp hs16
  have h6 : 16 * s ≤ s * ε * s := mul_le_mul_of_nonneg_right h16 (by linarith)
  have hεY : 0 ≤ ε * Y := mul_nonneg hε.le hY0
  linarith

/-- **The neighbourhood ratio holds at every slack, from some scale on.** Route: a near-optimal periodic `J`
(`exists_periodic_near_mOne`); for `t` in its cell, `((J + t) \ N_e[Z]) ∪ Z` has null unit pairs
(`unitPairsNull_diff_essNbhd_union`), so `volume_inter_sq_le` bounds it; average over `t`. -/
theorem exists_nrWindow {ε : ℝ} (hε : 0 < ε) : ∃ s₀ : ℝ, 0 < s₀ ∧ NRWindow ε s₀ := by
  refine ⟨max 1 (16 / ε), lt_max_of_lt_left one_pos, ?_⟩
  intro Z hZ hZ1 a s hs
  have hs1 : 1 ≤ s := le_trans (le_max_left _ _) hs
  have hs16 : 16 / ε ≤ s := le_trans (le_max_right _ _) hs
  have hs0 : 0 < s := by linarith
  set W := squareWin a s with hW
  set N := essNbhd Z with hN
  set E := W \ N with hE
  have hWm : MeasurableSet W := measurableSet_squareWin a s
  have hNm : MeasurableSet N := measurableSet_essNbhd hZ
  have hEm : MeasurableSet E := hWm.diff hNm
  -- the dense window, of side `ℓ ≥ s` and `ℓ ≥ 12 s / ε`
  set ℓ : ℕ := ⌈s⌉₊ + ⌈12 * s / ε⌉₊ + 1 with hℓdef
  have hℓs : s ≤ ℓ := by
    have := Nat.le_ceil s
    have h0 : (0 : ℝ) ≤ ⌈12 * s / ε⌉₊ := Nat.cast_nonneg _
    simp only [hℓdef, Nat.cast_add, Nat.cast_one]; linarith
  have hℓε : 12 * s / ε ≤ ℓ := by
    have := Nat.le_ceil (12 * s / ε)
    have h0 : (0 : ℝ) ≤ ⌈s⌉₊ := Nat.cast_nonneg _
    simp only [hℓdef, Nat.cast_add, Nat.cast_one]; linarith
  have hℓpos : 0 < ℓ := by simp only [hℓdef]; omega
  obtain ⟨T, hTm, hTbf, hTw, hTv⟩ := exists_dense_window (by positivity : 0 < ε / 4) ℓ hℓpos
  set D := squareWin (a - (((ℓ : ℝ) : ℂ) + ((ℓ : ℝ) : ℂ) * I)) (s + ℓ) with hD
  -- every translate is a test set for `m₁` in the window
  have hstep : ∀ t : ℂ, volume (Z ∩ W) + volume ((fun x => x - t) ⁻¹' T ∩ E) ≤
      mOne * ENNReal.ofReal ((s + 2) ^ 2) := by
    intro t
    set J := (fun x => x - t) ⁻¹' T with hJ
    have hJm : MeasurableSet J := (measurable_sub_const t) hTm
    have hJbf : BandFree J 0 := fun x hx y hy => by
      have := hTbf _ hx _ hy
      rwa [dist_sub_right] at this
    have hMm : MeasurableSet ((J \ essNbhd Z) ∪ Z) := (hJm.diff hNm).union hZ
    have hb := volume_inter_sq_le hMm (unitPairsNull_diff_essNbhd_union hJm hJbf hZ hZ1) a hs0
    refine le_trans ?_ hb
    have hdisj : Disjoint (Z ∩ W) (J ∩ E) := by
      rw [Set.disjoint_left]
      rintro x ⟨hxZ, -⟩ ⟨-, -, hxN⟩
      exact hxN (Or.inl hxZ)
    rw [← measure_union hdisj (hJm.inter hEm)]
    apply measure_mono
    rintro x (⟨hxZ, hxW⟩ | ⟨hxJ, hxW, hxN⟩)
    · exact ⟨Or.inr hxZ, hxW⟩
    · exact ⟨Or.inl ⟨hxJ, hxN⟩, hxW⟩
  -- the translates meeting the window have `t ∈ D`
  have hsub : ∀ x ∈ E, ∀ t, x - t ∈ T → t ∈ D := by
    intro x hx t ht
    have h1 := hx.1
    have h2 := hTw ht
    simp only [hW, hD, squareWin, mem_setOf_eq, Complex.sub_re, Complex.sub_im, Complex.add_re,
      Complex.add_im, Complex.ofReal_re, Complex.ofReal_im, Complex.mul_re, Complex.mul_im, Complex.I_re,
      Complex.I_im, Complex.zero_re, Complex.zero_im, zero_add, mul_zero, mul_one, sub_zero, add_zero] at h1 h2 ⊢
    refine ⟨by linarith, by linarith, by linarith, by linarith⟩
  -- average over `t ∈ D`
  have hint : ∫⁻ t in D, (volume (Z ∩ W) + volume ((fun x => x - t) ⁻¹' T ∩ E)) ≤
      ∫⁻ _t in D, mOne * ENNReal.ofReal ((s + 2) ^ 2) := lintegral_mono hstep
  rw [lintegral_add_left measurable_const, lintegral_const, lintegral_const,
    lintegral_volume_translate_inter hTm hEm hsub, Measure.restrict_apply_univ,
    volume_squareWin _ (by positivity)] at hint
  -- to `ℝ`
  have hWfin : volume W ≠ ⊤ := by rw [volume_squareWin _ hs0.le]; exact ENNReal.ofReal_ne_top
  have hZW : volume (Z ∩ W) ≠ ⊤ := ne_top_of_le_ne_top hWfin (measure_mono inter_subset_right)
  have hEf : volume E ≠ ⊤ := ne_top_of_le_ne_top hWfin (measure_mono sdiff_subset)
  have hTf : volume T ≠ ⊤ := by
    refine ne_top_of_le_ne_top ?_ (measure_mono hTw)
    rw [volume_squareWin _ (by positivity)]; exact ENNReal.ofReal_ne_top
  have hreal := (ENNReal.toReal_le_toReal (by finiteness) (by
    exact ENNReal.mul_ne_top (ENNReal.mul_ne_top mOne_ne_top ENNReal.ofReal_ne_top) ENNReal.ofReal_ne_top)).mpr hint
  rw [ENNReal.toReal_add (ENNReal.mul_ne_top hZW ENNReal.ofReal_ne_top) (ENNReal.mul_ne_top hTf hEf),
    ENNReal.toReal_mul, ENNReal.toReal_mul, ENNReal.toReal_mul, ENNReal.toReal_mul,
    ENNReal.toReal_ofReal (by positivity), ENNReal.toReal_ofReal (by positivity)] at hreal
  -- `|E| = s² − |N ∩ W|`
  have hsplit := measureReal_inter_add_sdiff (μ := volume) (s := W) hNm hWfin
  have hWr : volume.real W = s ^ 2 := by
    rw [measureReal_def, volume_squareWin _ hs0.le, ENNReal.toReal_ofReal (by positivity)]
  have hNW : volume.real (N ∩ W) = volume.real (W ∩ N) := by rw [inter_comm]
  have hEr : (volume E).toReal = s ^ 2 - volume.real (N ∩ W) := by
    rw [← measureReal_def, hNW]; linarith
  have hYs : volume.real (N ∩ W) ≤ s ^ 2 := by
    rw [← hWr]; exact measureReal_mono inter_subset_right hWfin
  rw [hEr, ← measureReal_def, ← measureReal_def] at hreal
  exact arith_nrWindow mOne_toReal_le_one hε hs1 hs16 hℓs hℓε hYs hTv
    measureReal_nonneg measureReal_nonneg hreal

/-! ## Spec examples -/

/-- The essential neighbourhood of the empty set is empty. -/
example : essNbhd ∅ = ∅ := by
  ext x
  simp [essNbhd, phi]

end

end HadwigerNelson.Plane
