import Proofs.HadwigerNelson.Plane.SixRing.Chart
import Proofs.HadwigerNelson.Plane.SixRing.Shift
import Proofs.HadwigerNelson.Plane.SixRing.NullSets
import Proofs.HadwigerNelson.Outside.OAI158PaletteDensity
import Proofs.HadwigerNelson.Outside.OAI158AngularBoundary

/-!
# Null sets through the chart (FS-132, C132-M-ORBIT steps M2, M5, M7, M8)

The derivation's "`Z` is a diffeomorphism … So null sets and sets of positive measure correspond", in the one
direction the argument uses: **the preimage of a null set is null**. Three maps:

* the chart `(α, d) ↦ chart p α d`, from the plane of parameters to the plane (`chart_quasiMeasurePreserving`);
* a shear `(α, d, d') ↦ (α + f(d, d'), d')` (`shear_quasiMeasurePreserving`) — Tonelli and translation invariance;
* the unit-pair chart `(α, d, d') ↦ (z, the direction from z to its partner)`, as the statement it is used for:
  a weak colouring separates almost every such pair (`unitPair_chart_ae`, the derivation's "Properness and `Φ`
  give").

and the consequence of a label not tipping a hub (`ae_ne_of_not_isTip`, inside M5). For a colouring of the whole
plane; any number of labels. `plans/FS132-kernel-plan.md` stage 5 has the plan per leaf.

**Every statement here is proved from the statements it cites** (job FS132-I4); this module has no `sorry` of its
own. It cites leaves of `Chart` (`chart_eq_angularSum`, `continuous_chart`, `chart_hub`, `dist_chart_lt_one`,
`dist_chart_centre`) and of `Shift` (`dist_chart_chart_shift`, `measurable_shift`) by their statements. The chart is
the release's `angularSum` after a measure-preserving linear change (`chartAngles_quasiMeasurePreserving`), so
`chart_quasiMeasurePreserving` is the release's `angularSum_quasiMeasurePreserving`; the unit-pair statement is
Fubini twice with the derivation's remark that "for fixed `z` the point `z′` moves along the unit circle about `z`
with `|z′| = 2cos(π/3 + d′/2)` strictly decreasing in `d′`" (`ringRadius_sub_ge`, `volume_partner_direction_eq_zero`).
-/

open MeasureTheory

namespace HadwigerNelson.SixRing

open Outside.OAI158 Real

/-- The pair of ring directions of a chart point, `(α, d) ↦ (α, α − 2π/3 − d)` read on the circle of angles, pulls
null sets of pairs of directions back to null sets of the parameter plane: a measure-preserving linear change of the
plane followed by the release's `anglePair_quasiMeasurePreserving`. -/
theorem chartAngles_quasiMeasurePreserving :
    Measure.QuasiMeasurePreserving
      (fun x : ℝ × ℝ => ((x.1 : Angles), ((x.1 - 2 * π / 3 - x.2 : ℝ) : Angles)))
      volume (angularMeasure.prod angularMeasure) := by
  have hL : MeasurePreserving (fun x : ℝ × ℝ => (x.1, x.1 - 2 * π / 3 - x.2))
      ((volume : Measure ℝ).prod (volume : Measure ℝ)) ((volume : Measure ℝ).prod volume) :=
    (MeasurePreserving.id volume).skew_product (g := fun a d => a - 2 * π / 3 - d)
      ((measurable_fst.sub measurable_const).sub measurable_snd)
      (ae_of_all _ fun a => (Measure.measurePreserving_sub_left volume (a - 2 * π / 3)).map_eq)
  exact anglePair_quasiMeasurePreserving.comp hL.quasiMeasurePreserving

/-- **M2, "`Z` is a diffeomorphism … onto an annulus"**, as much as is used: the chart pulls null sets of the plane
back to null sets of the parameter plane. (The release's `circleSum_quasiMeasurePreserving`, `CircleMaps.lean:509`,
after the measure-preserving linear change `(α, d) ↦ (α, α − 2π/3 − d)`.) -/
theorem chart_quasiMeasurePreserving (p : ℂ) :
    Measure.QuasiMeasurePreserving (fun x : ℝ × ℝ => chart p x.1 x.2) volume volume := by
  have h := (angularSum_quasiMeasurePreserving p one_ne_zero).comp chartAngles_quasiMeasurePreserving
  have e : (fun x : ℝ × ℝ => chart p x.1 x.2) =
      angularSum p 1 ∘ fun x : ℝ × ℝ => ((x.1 : Angles), ((x.1 - 2 * π / 3 - x.2 : ℝ) : Angles)) := by
    funext x
    exact chart_eq_angularSum p x.1 x.2
  rw [e]
  exact h

/-- A shear of the first coordinate by a measurable function of the other two, followed by forgetting the middle
coordinate, pulls null sets back to null sets. -/
theorem shear_quasiMeasurePreserving {f : ℝ × ℝ → ℝ} (hf : Measurable f) :
    Measure.QuasiMeasurePreserving (fun y : ℝ × ℝ × ℝ => (y.1 + f y.2, y.2.2)) volume volume :=
  quasiMeasurePreserving_triple_snd.comp (shear_measurePreserving hf).quasiMeasurePreserving

/-- **M5, "for an inner `a ∉ Tip(k)` there is `κ` with `A_a` null in `B(0, 1) ∩ N_k(κ)`"**, in the chart: if the
label `i` does not tip the hub `y_n`, then for some `κ > 0` almost no `(α, d)` with `|α − ψ_{n+1}| < κ` and
`0 < d < κ` has colour `i` at `chart p α d`. Any measurable colouring (weakness is not used). -/
theorem ae_ne_of_not_isTip {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) {p : ℂ} {ψ : ℝ} {n : ℤ} {i : Fin k}
    (h : ¬ IsTip c p (hub p ψ n) i) :
    ∃ κ : ℝ, 0 < κ ∧ ∀ᵐ x : ℝ × ℝ, |x.1 - (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3))| < κ → 0 < x.2 → x.2 < κ →
      c (chart p x.1 x.2) ≠ i := by
  -- a ball about the hub misses the support inside the disc
  obtain ⟨r, hr, hball⟩ : ∃ r : ℝ, 0 < r ∧
      ∀ z ∈ spatialSupport c i ∩ Metric.ball p 1, r ≤ dist (hub p ψ n) z := by
    rw [IsTip, Metric.mem_closure_iff] at h
    push Not at h
    exact h
  -- the chart is continuous at the centre of the box, where it is the hub
  have hcont : ContinuousAt (fun x : ℝ × ℝ => chart p x.1 x.2) (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3), 0) :=
    (continuous_chart p).continuousAt
  obtain ⟨δ, hδ, hδ'⟩ := Metric.continuousAt_iff.mp hcont r hr
  refine ⟨min δ (π / 3), lt_min hδ (by positivity), ?_⟩
  filter_upwards [(chart_quasiMeasurePreserving p).ae (mem_spatialSupport_ae c hc i)] with x hx h1 h2 h3 hci
  have hd : dist x (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3), (0 : ℝ)) < δ := by
    rw [Prod.dist_eq, max_lt_iff, Real.dist_eq, Real.dist_eq, sub_zero, abs_of_pos h2]
    exact ⟨h1.trans_le (min_le_left _ _), h3.trans_le (min_le_left _ _)⟩
  have hnear : dist (chart p x.1 x.2) (hub p ψ n) < r := by
    have h4 := hδ' hd
    rwa [chart_hub] at h4
  have hmem : chart p x.1 x.2 ∈ spatialSupport c i ∩ Metric.ball p 1 :=
    ⟨hx hci, Metric.mem_ball.mpr (dist_chart_lt_one h2 (h3.le.trans (min_le_right _ _)) p x.1)⟩
  exact absurd (hball _ hmem) (not_le.mpr (by rwa [dist_comm]))

/-- **M7, "`|z′| = 2cos(π/3 + d′/2)` strictly decreasing in `d′`"**, with a rate: on `[0, 1/4]` the ring radius
falls by at least a quarter of the increase of its argument. -/
theorem ringRadius_sub_ge {a b : ℝ} (ha : 0 ≤ a) (hab : a ≤ b) (hb : b ≤ 1 / 4) :
    (b - a) / 4 ≤ ringRadius a - ringRadius b := by
  have hpi := Real.pi_gt_three
  have hpi4 := Real.pi_le_four
  have hcos : cos (π / 3 + a / 2) - cos (π / 3 + b / 2) =
      2 * sin (π / 3 + (a + b) / 4) * sin ((b - a) / 4) := by
    rw [Real.cos_sub_cos]
    have e1 : (π / 3 + a / 2 + (π / 3 + b / 2)) / 2 = π / 3 + (a + b) / 4 := by ring
    have e2 : (π / 3 + a / 2 - (π / 3 + b / 2)) / 2 = -((b - a) / 4) := by ring
    rw [e1, e2, Real.sin_neg]
    ring
  -- the first sine is at least `1/2`, the second at least half its argument
  have hs1 : 1 / 2 ≤ sin (π / 3 + (a + b) / 4) := by
    rw [← Real.sin_pi_div_six]
    exact Real.sin_le_sin_of_le_of_le_pi_div_two (by linarith) (by linarith) (by linarith)
  have hs2 : (b - a) / 4 / 2 ≤ sin ((b - a) / 4) := by
    have h1 := Real.mul_le_sin (x := (b - a) / 4) (by linarith) (by linarith)
    have h2 : (1 : ℝ) / 2 ≤ 2 / π := by
      rw [le_div_iff₀ Real.pi_pos]
      linarith
    have h3 : 0 ≤ (b - a) / 4 := by linarith
    nlinarith
  have h0 : 0 ≤ (b - a) / 4 := by linarith
  have hs2' : 0 ≤ sin ((b - a) / 4) := le_trans (by linarith) hs2
  have hprod : (b - a) / 4 / 4 ≤ sin (π / 3 + (a + b) / 4) * sin ((b - a) / 4) := by
    nlinarith
  have hr : ringRadius a - ringRadius b = 2 * (cos (π / 3 + a / 2) - cos (π / 3 + b / 2)) := by
    simp only [ringRadius]
    ring
  rw [hr, hcos]
  linarith

/-- On `[0, 1/4]` the ring radius is positive. -/
theorem ringRadius_pos {d : ℝ} (h0 : 0 ≤ d) (h1 : d ≤ 1 / 4) : 0 < ringRadius d := by
  have hpi := Real.pi_gt_three
  have hc : 0 < cos (π / 3 + d / 2) :=
    Real.cos_pos_of_mem_Ioo ⟨by linarith, by linarith⟩
  simp only [ringRadius]
  linarith

/-- **M7, "for fixed `z` the point `z′` moves along the unit circle about `z` with `|z′|` … strictly decreasing in
`d′`"**, as much as is used: for fixed `(α, d)` and a null set `N` of directions, almost no `d' ∈ (0, 1/4)` has its
partner point `Z(α + ε + d' + π/3, d')` at a direction of `N` from `Z(α, d)`. The partner's distance from `p` is
`ringRadius d'`, so the partner moves at least a quarter as fast as `d'` (`ringRadius_sub_ge`); an expanding map
onto an arc of the unit circle pulls null sets of directions back to null sets. -/
theorem volume_partner_direction_eq_zero (p : ℂ) (α d : ℝ) {N : Set Angles} (hN : angularMeasure N = 0) :
    volume {d' : ℝ | d' ∈ Set.Ioo (0 : ℝ) (1 / 4) ∧ ∃ t ∈ N,
      chart p (α + shift d d' + d' + π / 3) d' = chart p α d + direction t} = 0 := by
  -- the partner, as a function of `d'`, does not contract distances by more than `4`
  have hanti : AntilipschitzWith 4 ((Set.Ioo (0 : ℝ) (1 / 4)).restrict
      fun d' : ℝ => chart p (α + shift d d' + d' + π / 3) d') := by
    refine AntilipschitzWith.of_le_mul_dist fun x y => ?_
    have hx := x.2
    have hy := y.2
    have hrad : ∀ u : ℝ, u ∈ Set.Ioo (0 : ℝ) (1 / 4) →
        dist (chart p (α + shift d u + u + π / 3) u) p = ringRadius u := fun u hu => by
      rw [dist_chart_centre, abs_of_pos (ringRadius_pos hu.1.le hu.2.le)]
    have h1 := abs_dist_sub_le (chart p (α + shift d x + x + π / 3) x) (chart p (α + shift d y + y + π / 3) y) p
    rw [hrad x hx, hrad y hy] at h1
    have h2 : |(x : ℝ) - y| / 4 ≤ |ringRadius x - ringRadius y| := by
      rcases le_total (x : ℝ) y with hxy | hxy
      · have h3 := ringRadius_sub_ge hx.1.le hxy hy.2.le
        rw [abs_of_nonpos (by linarith), abs_of_nonneg (by linarith)]
        linarith
      · have h3 := ringRadius_sub_ge hy.1.le hxy hx.2.le
        rw [abs_of_nonneg (by linarith), abs_of_nonpos (by linarith)]
        linarith
    have h4 : dist x y = |(x : ℝ) - y| := by rw [Subtype.dist_eq, Real.dist_eq]
    rw [h4]
    simp only [Set.restrict_apply]
    have h5 : ((4 : NNReal) : ℝ) = 4 := by norm_num
    rw [h5]
    linarith
  -- the points of the unit circle about the chart point at the directions of `N`
  have hA : μH[1] ((fun θ : ℝ => chart p α d + Plane.e θ) '' (((↑) : ℝ → Angles) ⁻¹' N)) = 0 :=
    hausdorffMeasure_add_e_image_eq_zero _ (angleMk_quasiMeasurePreserving.preimage_null hN)
  have hle := volume_preimage_inter_le_hausdorff hanti
    ((fun θ : ℝ => chart p α d + Plane.e θ) '' (((↑) : ℝ → Angles) ⁻¹' N))
  rw [hA, mul_zero] at hle
  refine measure_mono_null ?_ (nonpos_iff_eq_zero.mp hle)
  rintro d' ⟨hd', t, ht, heq⟩
  obtain ⟨θ, rfl⟩ := QuotientAddGroup.mk_surjective t
  refine ⟨⟨θ, ht, ?_⟩, hd'⟩
  show chart p α d + Plane.e θ = chart p (α + shift d d' + d' + π / 3) d'
  rw [heq, direction_coe]

/-- **M7–M8, "Properness and `Φ` give"**: for a weak colouring of the plane, almost every `(α, d, d')` with
`0 < d, d' < 1/4` has different colours at the two chart points `Z(α, d)` and `Z(α + ε + d' + π/3, d')`,
`ε = shift d d'`, which are at distance `1` (`dist_chart_chart_shift`). Any number of labels. Where the hypothesis
holds: `proper_to_borel_weak_model` (`k = 7`). -/
theorem unitPair_chart_ae {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) (hw : WeakColoring k c) (p : ℂ) :
    ∀ᵐ y : ℝ × ℝ × ℝ, 0 < y.2.1 → y.2.1 < 1 / 4 → 0 < y.2.2 → y.2.2 < 1 / 4 →
      c (chart p y.1 y.2.1) ≠ c (chart p (y.1 + shift y.2.1 y.2.2 + y.2.2 + π / 3) y.2.2) := by
  -- the pairs `(z, t)` of a point and a direction with one colour at `z` and at `z + e(t)`: a null set
  have hB0 : ((volume : Measure ℂ).prod angularMeasure) {q : ℂ × Angles | c q.1 = c (q.1 + direction q.2)} = 0 := by
    have h := hw.2
    rw [ae_iff] at h
    simpa only [ne_eq, not_not] using h
  -- so almost every point has a null set of bad directions; and so almost every chart point
  have hsec : ∀ᵐ x : ℝ × ℝ, angularMeasure
      (Prod.mk (chart p x.1 x.2) ⁻¹' {q : ℂ × Angles | c q.1 = c (q.1 + direction q.2)}) = 0 :=
    (chart_quasiMeasurePreserving p).ae (Measure.measure_ae_null_of_prod_null hB0)
  have hsec' : ∀ᵐ α : ℝ, ∀ᵐ d : ℝ, angularMeasure
      (Prod.mk (chart p α d) ⁻¹' {q : ℂ × Angles | c q.1 = c (q.1 + direction q.2)}) = 0 :=
    Measure.ae_ae_of_ae_prod hsec
  -- the statement is about a measurable set of triples
  have hf : Measurable fun y : ℝ × ℝ × ℝ => chart p y.1 y.2.1 :=
    (continuous_chart p).measurable.comp (measurable_fst.prodMk (measurable_fst.comp measurable_snd))
  have hg : Measurable fun y : ℝ × ℝ × ℝ => chart p (y.1 + shift y.2.1 y.2.2 + y.2.2 + π / 3) y.2.2 :=
    (continuous_chart p).measurable.comp
      ((((measurable_fst.add (measurable_shift.comp measurable_snd)).add
        (measurable_snd.comp measurable_snd)).add_const _).prodMk (measurable_snd.comp measurable_snd))
  have hd1 : Measurable fun y : ℝ × ℝ × ℝ => y.2.1 := measurable_fst.comp measurable_snd
  have hd2 : Measurable fun y : ℝ × ℝ × ℝ => y.2.2 := measurable_snd.comp measurable_snd
  have hmeas : MeasurableSet {y : ℝ × ℝ × ℝ | 0 < y.2.1 → y.2.1 < 1 / 4 → 0 < y.2.2 → y.2.2 < 1 / 4 →
      c (chart p y.1 y.2.1) ≠ c (chart p (y.1 + shift y.2.1 y.2.2 + y.2.2 + π / 3) y.2.2)} :=
    (measurableSet_lt measurable_const hd1).imp ((measurableSet_lt hd1 measurable_const).imp
      ((measurableSet_lt measurable_const hd2).imp ((measurableSet_lt hd2 measurable_const).imp
        (measurableSet_eq_fun (hc.comp hf) (hc.comp hg)).compl)))
  -- Fubini: for almost every `(α, d)`, almost every `d'`
  rw [Measure.volume_eq_prod, Measure.ae_prod_iff_ae_ae hmeas]
  filter_upwards [hsec'] with α hα
  refine (Measure.ae_prod_iff_ae_ae (μ := (volume : Measure ℝ)) (ν := (volume : Measure ℝ))
    (p := fun w : ℝ × ℝ => 0 < w.1 → w.1 < 1 / 4 → 0 < w.2 → w.2 < 1 / 4 →
      c (chart p α w.1) ≠ c (chart p (α + shift w.1 w.2 + w.2 + π / 3) w.2))
    (measurable_prodMk_left hmeas)).mpr ?_
  filter_upwards [hα] with d hd
  rw [ae_iff]
  refine measure_mono_null ?_ (volume_partner_direction_eq_zero p α d hd)
  intro d' hd'
  simp only [Set.mem_setOf_eq, Classical.not_imp, not_not] at hd'
  obtain ⟨h1, h2, h3, h4, hcol⟩ := hd'
  refine ⟨⟨h3, h4⟩, ?_⟩
  -- the direction from the chart point to its partner
  have hdist := dist_chart_chart_shift p α h1.le h2.le h3.le h4.le
  have hnorm : ‖chart p (α + shift d d' + d' + π / 3) d' - chart p α d‖ = 1 := by
    rw [← dist_eq_norm, dist_comm]
    exact hdist
  have hdir : direction ((Complex.arg (chart p (α + shift d d' + d' + π / 3) d' - chart p α d) : ℝ) : Angles) =
      chart p (α + shift d d' + d' + π / 3) d' - chart p α d := by
    have h5 := Complex.norm_mul_exp_arg_mul_I (chart p (α + shift d d' + d' + π / 3) d' - chart p α d)
    rw [hnorm, Complex.ofReal_one, one_mul] at h5
    rw [direction_coe, Plane.e]
    exact h5
  refine ⟨_, ?_, (by rw [hdir]; ring : chart p (α + shift d d' + d' + π / 3) d' = chart p α d + direction _)⟩
  show c (chart p α d) = c (chart p α d + direction _)
  rw [hdir, add_sub_cancel]
  exact hcol

end HadwigerNelson.SixRing
