import Proofs.HadwigerNelson.Plane.OneClass.SectionDensity
import Proofs.HadwigerNelson.Plane.OneClass.Field
import Proofs.HadwigerNelson.Plane.OneClass.InvariantLaw
import Proofs.HadwigerNelson.Plane.DensityPoints
import Proofs.HadwigerNelson.Plane.Slack
import Proofs.HadwigerNelson.Instances.Seven
import Mathlib.Analysis.Subadditive

/-!
# The finitary independence ratio of the plane is its measurable density (FS-133)

The derivation's entries C133-ALG, C133-EASY, C133-ONE (first line) and C133-FN (`plans/FS133-E1-derivation.md`,
stage 5):

* `exists_measurable_indep_of_field` — from a field to a set (the density step and the density points): a jointly
  measurable `[0, 1]`-valued field over the plane with mean at least `δ` at every point, whose values at two points
  one unit apart have almost surely zero product, has a sample whose density points are a Borel set with no two
  points at distance one and upper density at least `δ`;
* `IsInvariantLaw.measure_origin_le_mOne` — **C133-ALG**: an invariant random independent set of the unit-distance
  graph of the algebraic plane has density at most `m₁(ℝ²)`;
* `mOne_le_finIndepRatio` — C133-EASY, the averaging bound;
* `finIndepRatio_plane_eq_mOne`, `finIndepRatio_algPlane_eq_mOne` — **C133-ONE, first line**:
  `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`;
* `tendsto_minIndepNum_div` — **C133-FN**: `f(n) / n → m₁(ℝ²)`.

The two headlines and C133-ALG rest on the declared outside theorem `Outside.OAI158.Spectral.residual_fourier`
(through `exists_field`). Not claimed: any value of `m₁(ℝ²)`; anything at a number field's plane; that the release
states any of this (its manuscript does not); that the result is new (`[Davies2026]` proves the same sentence in
dimension four and up).
-/

open MeasureTheory Filter Set
open scoped ENNReal Topology

namespace HadwigerNelson.OneClass

open HadwigerNelson.Plane HadwigerNelson.Outside.OAI158 HadwigerNelson.Outside.OAI158.Spectral SimpleGraph

/-- **From a field to a set** (the derivation's C133-DENS as posed, with the density points of C133-DP). On any
probability space: a jointly measurable `H : ℂ × Ω → [0, 1]` with `∫ H (x, ·) ≥ δ` at every `x` and
`H (x, ·) H (x + w, ·) = 0` almost surely at every `x` and unit `w` gives a Borel set of the plane with no two
points at distance one and upper density at least `δ`. No outside theorem. The hypotheses hold trivially for
`H = 0`, `δ ≤ 0`; with `δ > 0` they hold for the field `exists_field` gives at an invariant random independent set
of positive density (the consumer, `IsInvariantLaw.measure_origin_le_mOne`). -/
theorem exists_measurable_indep_of_field {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω) [IsProbabilityMeasure P]
    {H : ℂ × Ω → ℝ} (hH : Measurable H) (h01 : ∀ p, 0 ≤ H p ∧ H p ≤ 1) {δ : ℝ}
    (hmean : ∀ x, δ ≤ ∫ ω, H (x, ω) ∂P)
    (hunit : ∀ x w : ℂ, ‖w‖ = 1 → ∀ᵐ ω ∂P, H (x, ω) * H (x + w, ω) = 0) :
    ∃ A : Set ℂ, MeasurableSet A ∧ (unitDistance ℂ).IsIndepSet A ∧ ENNReal.ofReal δ ≤ upperDensity A := by
  -- the support of the sample at `ω`
  set W : Ω → Set ℂ := fun ω => {x | 0 < H (x, ω)} with hWdef
  have hWm : ∀ ω, MeasurableSet (W ω) := fun ω =>
    measurableSet_lt measurable_const (hH.comp (measurable_id.prodMk measurable_const))
  -- (i) almost every sample's support has null unit pairs (Tonelli: each pair is a null event)
  have hnull : ∀ᵐ ω ∂P, UnitPairsNull (W ω) := by
    set B : Set (Ω × (ℂ × ℝ)) := {p | 0 < H (p.2.1, p.1) ∧ 0 < H (p.2.1 + e p.2.2, p.1)} with hB
    have hBm : MeasurableSet B := by
      refine (measurableSet_lt (f := fun _ : Ω × (ℂ × ℝ) => (0 : ℝ)) measurable_const ?_).inter
        (measurableSet_lt (f := fun _ : Ω × (ℂ × ℝ) => (0 : ℝ)) measurable_const ?_)
      · exact hH.comp ((measurable_fst.comp measurable_snd).prodMk measurable_fst)
      · exact hH.comp (((measurable_fst.comp measurable_snd).add
          (continuous_e.measurable.comp (measurable_snd.comp measurable_snd))).prodMk measurable_fst)
    have h0 : (P.prod ((volume : Measure ℂ).prod arcLength)) B = 0 := by
      rw [Measure.prod_apply_symm hBm]
      refine (lintegral_congr fun q => ?_).trans lintegral_zero
      refine measure_mono_null (fun ω hω => ?_) (ae_iff.1 (hunit q.1 (e q.2) (norm_e q.2)))
      exact (mul_pos hω.1 hω.2).ne'
    filter_upwards [Measure.measure_ae_null_of_prod_null h0] with ω hω
    exact hω
  -- (ii) the density step: some sample with null unit pairs has upper density at least `δ` along the discs
  have hS : P {ω | UnitPairsNull (W ω)}ᶜ = 0 := by
    rw [compl_setOf]
    exact ae_iff.1 hnull
  obtain ⟨-, -, -, hex⟩ := sectionDensity_setOf_pos (volume : Measure ℂ) P hH (fun p => (h01 p).2)
    (Eventually.of_forall hmean) (Xn := fun n : ℕ => Metric.ball (0 : ℂ) ((n : ℝ) + 1)) (fun _ => measurableSet_ball)
    (fun n => volume_ball_ne_zero (by positivity)) (fun _ => measure_ball_lt_top.ne)
  obtain ⟨ω, hωS, hωd⟩ := hex _ hS
  -- (iii) the density along the discs of integer radius is at most the upper density
  have hsec : sectionDensity (volume : Measure ℂ) (fun n : ℕ => Metric.ball (0 : ℂ) ((n : ℝ) + 1)) {p | 0 < H p} ω ≤
      upperDensity (W ω) := by
    have ht : Tendsto (fun n : ℕ => (n : ℝ) + 1) atTop atTop :=
      tendsto_atTop_add_const_right _ 1 tendsto_natCast_atTop_atTop
    have he : (fun n : ℕ => volume (Metric.ball (0 : ℂ) ((n : ℝ) + 1) ∩ {x | (x, ω) ∈ {p : ℂ × Ω | 0 < H p}}) /
        volume (Metric.ball (0 : ℂ) ((n : ℝ) + 1))) =
        (fun R : ℝ => volume (W ω ∩ Metric.ball 0 R) / volume (Metric.ball (0 : ℂ) R)) ∘ fun n : ℕ => (n : ℝ) + 1 := by
      funext n
      simp only [Function.comp, inter_comm]
      rfl
    unfold sectionDensity upperDensity
    rw [he, Filter.limsup_comp]
    exact limsup_le_limsup_of_le ht
  -- (iv) the density points of the support: Borel, the same upper density, and no two at distance one
  refine ⟨densitySet (W ω), measurableSet_densitySet (hWm ω), ?_, ?_⟩
  · exact isIndepSet_unitDistance_iff.2 fun x hx y hy =>
      dist_ne_one_of_mem_densitySet (hWm ω) hωS hy (upperDensityAt_pos_of_mem_densitySet hx)
  · rw [← upperDensity_congr_ae (ae_eq_densitySet (hWm ω))]
    exact hωd.trans hsec

/-- **C133-ALG.** Every invariant random independent set of the unit-distance graph of the algebraic plane has
density at most `m₁(ℝ²)`. Rests on the declared outside theorem `Spectral.residual_fourier`. Its hypothesis is
inhabited with positive density: `exists_isInvariantLaw_unitDistance`. -/
theorem IsInvariantLaw.measure_origin_le_mOne {P : Measure (E → Bool)} (h : IsInvariantLaw (unitDistance E) P) :
    P {I | I 0 = true} ≤ mOne := by
  classical
  haveI := h.prob
  have hT : MeasurableSet {I : E → Bool | I 0 = true} :=
    show MeasurableSet ((fun I : E → Bool => I 0) ⁻¹' {true}) from
      measurable_pi_apply (0 : E) (measurableSet_singleton true)
  -- the indicator of the origin, fixed by every rotation
  set f : Unit → (E → Bool) → ℝ := fun _ => {I : E → Bool | I 0 = true}.indicator 1 with hf
  have hfm : ∀ i, Measurable (f i) := fun _ => measurable_one.indicator hT
  have hf01 : ∀ i I, 0 ≤ f i I ∧ f i I ≤ 1 := by
    intro i I
    by_cases hI : I 0 = true
    · simp [hf, indicator_of_mem (show I ∈ {I : E → Bool | I 0 = true} from hI)]
    · simp [hf, indicator_of_notMem (show I ∉ {I : E → Bool | I 0 = true} from hI)]
  have hffix : ∀ i u I, f i (turnLab u I) = f i I := by
    intro i u I
    have hmem : turnLab u I ∈ {I : E → Bool | I 0 = true} ↔ I ∈ {I : E → Bool | I 0 = true} := by
      show I (kCoeff u * 0) = true ↔ I 0 = true
      rw [mul_zero]
    simp only [hf, indicator_apply, hmem, Pi.one_apply]
  obtain ⟨H, hHm, hH01, hmean, -, hzero⟩ := exists_field h.isPlaneSystem f hfm hf01 hffix
  -- the origin and the point `1` are one unit apart, so never both in the random independent set
  have hd01 : dist (0 : E) 1 = 1 := by
    rw [Subtype.dist_eq, dist_eq_norm]
    simp
  have hprem : ∀ᵐ I ∂P, f () I * f () (shiftLab 1 I) = 0 := by
    filter_upwards [h.indep] with I hI
    by_cases h0 : I 0 = true
    · have h1 : ¬ I 1 = true := fun h1 => (isIndepSet_unitDistance_iff.1 hI) 0 h0 1 h1 hd01
      have hn : shiftLab 1 I ∉ {I : E → Bool | I 0 = true} := by
        show ¬ I (0 + 1) = true
        rwa [zero_add]
      simp [hf, indicator_of_notMem hn]
    · simp [hf, indicator_of_notMem (show I ∉ {I : E → Bool | I 0 = true} from h0)]
  have hnorm : ‖((1 : E) : ℂ)‖ = 1 := by simp
  have hc := hzero () () 1 one_ne_zero hprem
  have hmean' : ∀ x, (P {I | I 0 = true}).toReal ≤ ∫ ω, H () (x, ω) ∂P := by
    intro x
    rw [hmean () x]
    simp only [hf]
    rw [integral_indicator_one hT, measureReal_def]
  obtain ⟨A, hAm, hAi, hAd⟩ := exists_measurable_indep_of_field P (hHm ()) (hH01 ()) hmean'
    fun x w hw => hc x w (hw.trans hnorm.symm)
  calc P {I | I 0 = true} = ENNReal.ofReal (P {I | I 0 = true}).toReal :=
        (ENNReal.ofReal_toReal (measure_ne_top _ _)).symm
    _ ≤ upperDensity A := hAd
    _ ≤ mOne := upperDensity_le_mOne hAm hAi

/-- If the mass of `A` in `B(0, R − r)` is at most `c` times the area of `B(0, R)` for every `R > r`, the upper density
of `A` is at most `c` (the ratio of the two discs tends to `1`). -/
private theorem upperDensity_le_of_forall_ball {A : Set ℂ} {c : ℝ≥0∞} (hc : c ≠ ⊤) {r : ℝ} (hr : 0 ≤ r)
    (h : ∀ R : ℝ, r < R → volume (A ∩ Metric.ball 0 (R - r)) ≤ c * volume (Metric.ball (0 : ℂ) R)) : upperDensity A ≤ c := by
  have hle : ∀ᶠ R : ℝ in atTop,
      volume (A ∩ Metric.ball 0 R) / volume (Metric.ball (0 : ℂ) R) ≤ c * ENNReal.ofReal (((R + r) / R) ^ 2) := by
    filter_upwards [eventually_gt_atTop 0] with R hR
    have h1 := h (R + r) (by linarith)
    rw [add_sub_cancel_right] at h1
    have hne : volume (Metric.ball (0 : ℂ) R) ≠ 0 := volume_ball_ne_zero hR
    have hfin : volume (Metric.ball (0 : ℂ) R) ≠ ⊤ := measure_ball_lt_top.ne
    rw [ENNReal.div_le_iff hne hfin, ← volume_ball_div_volume_ball (by linarith) hR, mul_assoc,
      ENNReal.div_mul_cancel hne hfin]
    exact h1
  have ht : Tendsto (fun R : ℝ => c * ENNReal.ofReal (((R + r) / R) ^ 2)) atTop (𝓝 (c * 1)) :=
    ENNReal.Tendsto.const_mul (tendsto_sq_add_div r) (Or.inr hc)
  rw [mul_one] at ht
  calc upperDensity A ≤ limsup (fun R : ℝ => c * ENNReal.ofReal (((R + r) / R) ^ 2)) atTop :=
        limsup_le_limsup hle
    _ = c := ht.limsup_eq

/-- **C133-EASY**: `m₁(ℝ²) ≤ α(G) / |G|` for every finite point set `G` of the plane — a measurable set with no two
points at distance one, translated at random, meets `G` in an independent set. -/
theorem mOne_le_finIndepRatio : mOne ≤ (unitDistance ℂ).finIndepRatio := by
  classical
  rw [mOne_le_iff]
  intro A hA hind
  refine le_of_forall_lt fun c hc => ?_
  obtain ⟨c', hcc', hc'⟩ := exists_between hc
  have hc'top : c' ≠ ⊤ := ne_top_of_lt (hc'.trans_le (upperDensity_le_one A))
  refine hcc'.trans_le ((SimpleGraph.le_finIndepRatio_iff _).2 fun S hS => ?_)
  -- some translate of `A` meets `S` in at least `c' |S|` points
  obtain ⟨r, hr0, hr⟩ : ∃ r : ℝ, 0 ≤ r ∧ ∀ g ∈ S, ‖g‖ ≤ r :=
    ⟨∑ g ∈ S, ‖g‖, Finset.sum_nonneg fun _ _ => norm_nonneg _,
      fun g hg => Finset.single_le_sum (f := fun g => ‖g‖) (fun _ _ => norm_nonneg _) hg⟩
  obtain ⟨t, ht⟩ : ∃ t : ℂ, c' * S.card ≤ ((S.filter fun g => g + t ∈ A).card : ℝ≥0∞) := by
    by_contra hcon
    push Not at hcon
    have hcard0 : (S.card : ℝ≥0∞) ≠ 0 := by simpa using hS.ne_empty
    have hcardt : (S.card : ℝ≥0∞) ≠ ⊤ := ENNReal.natCast_ne_top _
    refine absurd (upperDensity_le_of_forall_ball hc'top hr0 fun R hR => ?_) (not_le.2 hc')
    -- integrate the count over `t ∈ B(0, R)`
    have hcount : ∀ t : ℂ, ((S.filter fun g => g + t ∈ A).card : ℝ≥0∞) =
        ∑ g ∈ S, ((fun t => g + t) ⁻¹' A).indicator 1 t := by
      intro t
      rw [Finset.card_filter, Nat.cast_sum]
      refine Finset.sum_congr rfl fun g _ => ?_
      by_cases hg : g + t ∈ A
      · rw [if_pos hg, indicator_of_mem (show t ∈ (fun t => g + t) ⁻¹' A from hg)]; simp
      · rw [if_neg hg, indicator_of_notMem (show t ∉ (fun t => g + t) ⁻¹' A from hg)]; simp
    have hpre : ∀ g, MeasurableSet ((fun t => g + t) ⁻¹' A) := fun g => measurable_const_add g hA
    have hint : ∫⁻ t in Metric.ball (0 : ℂ) R, ((S.filter fun g => g + t ∈ A).card : ℝ≥0∞) =
        ∑ g ∈ S, volume ((fun t => g + t) ⁻¹' A ∩ Metric.ball 0 R) := by
      simp_rw [hcount]
      rw [lintegral_finsetSum _ fun g _ => measurable_one.indicator (hpre g)]
      refine Finset.sum_congr rfl fun g _ => ?_
      rw [lintegral_indicator_one (hpre g), Measure.restrict_apply (hpre g)]
    have hlow : ∀ g ∈ S, volume (A ∩ Metric.ball 0 (R - r)) ≤ volume ((fun t => g + t) ⁻¹' A ∩ Metric.ball 0 R) := by
      intro g hg
      rw [← measure_preimage_add (μ := (volume : Measure ℂ)) g (A ∩ Metric.ball 0 (R - r))]
      refine measure_mono fun t ht => ⟨ht.1, ?_⟩
      have h1 : ‖g + t‖ < R - r := by simpa using ht.2
      have h2 := hr g hg
      rw [Metric.mem_ball, dist_zero_right]
      calc ‖t‖ = ‖(g + t) - g‖ := by rw [add_sub_cancel_left]
        _ ≤ ‖g + t‖ + ‖g‖ := norm_sub_le _ _
        _ < R := by linarith
    have hup : ∫⁻ t in Metric.ball (0 : ℂ) R, ((S.filter fun g => g + t ∈ A).card : ℝ≥0∞) ≤
        c' * S.card * volume (Metric.ball (0 : ℂ) R) := by
      calc ∫⁻ t in Metric.ball (0 : ℂ) R, ((S.filter fun g => g + t ∈ A).card : ℝ≥0∞)
          ≤ ∫⁻ _ in Metric.ball (0 : ℂ) R, c' * S.card := lintegral_mono fun t => (hcon t).le
        _ = c' * S.card * volume (Metric.ball (0 : ℂ) R) := by
          rw [lintegral_const, Measure.restrict_apply_univ]
    have hsum : (S.card : ℝ≥0∞) * volume (A ∩ Metric.ball 0 (R - r)) ≤ c' * S.card * volume (Metric.ball (0 : ℂ) R) := by
      calc (S.card : ℝ≥0∞) * volume (A ∩ Metric.ball 0 (R - r)) = ∑ _g ∈ S, volume (A ∩ Metric.ball 0 (R - r)) := by
            rw [Finset.sum_const, nsmul_eq_mul]
        _ ≤ ∑ g ∈ S, volume ((fun t => g + t) ⁻¹' A ∩ Metric.ball 0 R) := Finset.sum_le_sum hlow
        _ = _ := hint.symm
        _ ≤ _ := hup
    rw [mul_comm c', mul_assoc] at hsum
    exact (ENNReal.mul_le_mul_iff_right hcard0 hcardt).1 hsum
  refine ⟨S.filter fun g => g + t ∈ A, Finset.filter_subset _ _, ?_, ht⟩
  refine isIndepSet_unitDistance_iff.2 fun x hx y hy hxy => ?_
  have hx' := (Finset.mem_filter.1 (Finset.mem_coe.1 hx)).2
  have hy' := (Finset.mem_filter.1 (Finset.mem_coe.1 hy)).2
  exact (isIndepSet_unitDistance_iff.1 hind) _ hx' _ hy' (by rw [dist_add_right]; exact hxy)

/-- `α₁(𝒜²) ≤ m₁(ℝ²)`: the law of best density, bounded by C133-ALG. -/
theorem finIndepRatio_algPlane_le_mOne : (unitDistance E).finIndepRatio ≤ mOne := by
  obtain ⟨P, hP, hval⟩ := exists_isInvariantLaw_unitDistance
  rw [← hval]
  exact hP.measure_origin_le_mOne

/-- **C133-ONE, first line, the plane**: `α₁(ℝ²) = m₁(ℝ²)` — the infimum of `α(G) / |G|` over the finite point
sets of the plane is the supremum of the upper densities of its measurable sets with no two points at distance
one. Rests on the declared outside theorem `Spectral.residual_fourier`. -/
theorem finIndepRatio_plane_eq_mOne : (unitDistance ℂ).finIndepRatio = mOne :=
  le_antisymm ((finIndepRatio_le_of_embedding algPlaneEmbedding).trans finIndepRatio_algPlane_le_mOne)
    mOne_le_finIndepRatio

/-- **C133-ONE, first line, the algebraic plane**: `α₁(𝒜²) = m₁(ℝ²)`. Rests on the declared outside theorem
`Spectral.residual_fourier`. -/
theorem finIndepRatio_algPlane_eq_mOne : (unitDistance E).finIndepRatio = mOne :=
  le_antisymm finIndepRatio_algPlane_le_mOne
    (mOne_le_finIndepRatio.trans (finIndepRatio_le_of_embedding algPlaneEmbedding))

/-- Neither side is trivial: `1 / 7 ≤ m₁(ℝ²)`, from the seven-colouring of the plane and the equality. -/
theorem one_seventh_le_mOne : (7 : ℝ≥0∞)⁻¹ ≤ mOne := by
  rw [← finIndepRatio_plane_eq_mOne]
  have h := (unitDistance ℂ).inv_le_finIndepRatio_of_colorable plane_colorable_seven
  exact_mod_cast h

/-- `f(n) / n → α₁(ℝ²)`: Fekete's lemma for the subadditive `f`, whose ratios have infimum the finitary
independence ratio. No outside theorem. -/
theorem tendsto_minIndepNum_div_finIndepRatio :
    Tendsto (fun n : ℕ => (minIndepNum n : ℝ≥0∞) / n) atTop (𝓝 (unitDistance ℂ).finIndepRatio) := by
  classical
  set G := unitDistance ℂ with hG
  -- `f(n)` is attained, and bounds every set of `n` points from below
  have hne : ∀ n, Nonempty {S : Finset ℂ // S.card = n} := fun n =>
    ⟨⟨(Finset.range n).image fun k : ℕ => (k : ℂ), by
      rw [Finset.card_image_of_injective _ fun a b h => by exact_mod_cast h, Finset.card_range]⟩⟩
  have hatt : ∀ n, ∃ S : Finset ℂ, S.card = n ∧ (G.induce (S : Set ℂ)).indepNum = minIndepNum n := by
    intro n
    obtain ⟨⟨S, hS⟩, hSv⟩ := Nat.sInf_mem (Set.range_nonempty (h := hne n)
      fun S : {S : Finset ℂ // S.card = n} => (G.induce (S.1 : Set ℂ)).indepNum)
    exact ⟨S, hS, hSv⟩
  have hle : ∀ S : Finset ℂ, minIndepNum S.card ≤ (G.induce (S : Set ℂ)).indepNum := fun S =>
    ciInf_le (OrderBot.bddBelow _) (⟨S, rfl⟩ : {T : Finset ℂ // T.card = S.card})
  -- independence number of a translate, and of a union
  have htrans : ∀ (S : Finset ℂ) (t : ℂ),
      (G.induce ((S.image fun x => x + t : Finset ℂ) : Set ℂ)).indepNum ≤ (G.induce (S : Set ℂ)).indepNum := by
    intro S t
    obtain ⟨J, hJS, hJ, hJc⟩ := G.exists_indep_card_eq_indepNum (S.image fun x => x + t)
    have hsub : J.image (fun x => x - t) ⊆ S := by
      intro y hy
      obtain ⟨x, hx, rfl⟩ := Finset.mem_image.1 hy
      obtain ⟨z, hz, rfl⟩ := Finset.mem_image.1 (hJS hx)
      simpa using hz
    have hind : G.IsIndepSet ((J.image fun x => x - t : Finset ℂ) : Set ℂ) := by
      refine isIndepSet_unitDistance_iff.2 fun a ha b hb hab => ?_
      obtain ⟨x, hx, rfl⟩ := Finset.mem_image.1 (Finset.mem_coe.1 ha)
      obtain ⟨y, hy, rfl⟩ := Finset.mem_image.1 (Finset.mem_coe.1 hb)
      exact (isIndepSet_unitDistance_iff.1 hJ) x hx y hy (by rwa [dist_sub_right] at hab)
    rw [← hJc, ← Finset.card_image_of_injective J (sub_left_injective (b := t))]
    exact G.card_le_indepNum_induce S hsub hind
  have hunion : ∀ S₁ S₂ : Finset ℂ, (G.induce ((S₁ ∪ S₂ : Finset ℂ) : Set ℂ)).indepNum ≤
      (G.induce (S₁ : Set ℂ)).indepNum + (G.induce (S₂ : Set ℂ)).indepNum := by
    intro S₁ S₂
    obtain ⟨J, hJS, hJ, hJc⟩ := G.exists_indep_card_eq_indepNum (S₁ ∪ S₂)
    have h1 := G.card_le_indepNum_induce S₁ (Finset.inter_subset_right (s₁ := J))
      (hJ.mono (Finset.coe_subset.2 Finset.inter_subset_left))
    have h2 := G.card_le_indepNum_induce S₂ (Finset.inter_subset_right (s₁ := J))
      (hJ.mono (Finset.coe_subset.2 Finset.inter_subset_left))
    have h3 : J.card ≤ (J ∩ S₁).card + (J ∩ S₂).card := by
      calc J.card = (J ∩ (S₁ ∪ S₂)).card := by rw [Finset.inter_eq_left.2 hJS]
        _ = ((J ∩ S₁) ∪ (J ∩ S₂)).card := by rw [Finset.inter_union_distrib_left]
        _ ≤ _ := Finset.card_union_le _ _
    omega
  -- subadditivity: a set for `a`, and a disjoint translate of a set for `b`
  set u : ℕ → ℝ := fun n => (minIndepNum n : ℝ) with hu
  have hsub : Subadditive u := by
    intro a b
    obtain ⟨S₁, hS₁, hv₁⟩ := hatt a
    obtain ⟨S₂, hS₂, hv₂⟩ := hatt b
    obtain ⟨t, ht⟩ := Infinite.exists_notMem_finset ((S₁ ×ˢ S₂).image fun p => p.1 - p.2)
    have hdisj : Disjoint S₁ (S₂.image fun x => x + t) := by
      rw [Finset.disjoint_left]
      intro x hx hx'
      obtain ⟨y, hy, rfl⟩ := Finset.mem_image.1 hx'
      exact ht (Finset.mem_image.2 ⟨(y + t, y), Finset.mem_product.2 ⟨hx, hy⟩, by ring⟩)
    have hcard : (S₁ ∪ S₂.image fun x => x + t).card = a + b := by
      rw [Finset.card_union_of_disjoint hdisj, Finset.card_image_of_injective _ (add_left_injective t), hS₁, hS₂]
    have := (hle (S₁ ∪ S₂.image fun x => x + t)).trans (hunion _ _)
    rw [hcard] at this
    have h2 := htrans S₂ t
    simp only [hu]
    exact_mod_cast (this.trans (Nat.add_le_add_left h2 _)).trans_eq (by rw [hv₁, hv₂])
  have hbdd : BddBelow (range fun n => u n / n) :=
    ⟨0, by rintro _ ⟨n, rfl⟩; exact div_nonneg (Nat.cast_nonneg _) (Nat.cast_nonneg _)⟩
  have hlim := hsub.tendsto_lim hbdd
  have hconv : ∀ n : ℕ, 0 < n → ENNReal.ofReal (u n / n) = (minIndepNum n : ℝ≥0∞) / n := by
    intro n hn
    rw [ENNReal.ofReal_div_of_pos (by exact_mod_cast hn), ENNReal.ofReal_natCast, ENNReal.ofReal_natCast]
  -- the limit is the finitary ratio
  have hval : ENNReal.ofReal hsub.lim = G.finIndepRatio := by
    refine le_antisymm ?_ ?_
    · rw [SimpleGraph.finIndepRatio]
      refine le_iInf₂ fun S hS => ?_
      have hpos : 0 < S.card := hS.card_pos
      calc ENNReal.ofReal hsub.lim ≤ ENNReal.ofReal (u S.card / S.card) :=
            ENNReal.ofReal_le_ofReal (hsub.lim_le_div hbdd hpos.ne')
        _ = (minIndepNum S.card : ℝ≥0∞) / S.card := hconv _ hpos
        _ ≤ ((G.induce (S : Set ℂ)).indepNum : ℝ≥0∞) / S.card :=
            ENNReal.div_le_div_right (by exact_mod_cast hle S) _
    · refine ge_of_tendsto (ENNReal.tendsto_ofReal hlim) ?_
      filter_upwards [eventually_gt_atTop 0] with n hn
      obtain ⟨S, hS, hSv⟩ := hatt n
      have hSne : S.Nonempty := Finset.card_pos.1 (hS ▸ hn)
      rw [hconv n hn, ← hSv, ← hS]
      exact iInf₂_le (f := fun (S : Finset ℂ) (_ : S.Nonempty) =>
        ((G.induce (S : Set ℂ)).indepNum : ℝ≥0∞) / S.card) S hSne
  rw [← hval]
  refine (ENNReal.tendsto_ofReal hlim).congr' ?_
  filter_upwards [eventually_gt_atTop 0] with n hn
  exact hconv n hn

/-- **C133-FN**: `f(n) / n → m₁(ℝ²)`, where `f(n)` is the least independence number of the unit-distance graph on
`n` points of the plane (`[DuczVarga2026]` Conjecture 1, first clause). Rests on the declared outside theorem
`Spectral.residual_fourier`. -/
theorem tendsto_minIndepNum_div : Tendsto (fun n : ℕ => (minIndepNum n : ℝ≥0∞) / n) atTop (𝓝 mOne) :=
  finIndepRatio_plane_eq_mOne ▸ tendsto_minIndepNum_div_finIndepRatio

end HadwigerNelson.OneClass
