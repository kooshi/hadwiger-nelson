import Proofs.HadwigerNelson.Plane.AeColouring
import Proofs.HadwigerNelson.Plane.Chord
import Mathlib.LinearAlgebra.Complex.FiniteDimensional
import Mathlib.MeasureTheory.Measure.Real

/-!
# Density points of a set with null unit pairs (FS-131 wave 1)

Rows: **FS111-V0-ID1** (I-D1), **FS129-SR2-HULLSET** (carrying FS111-C-HULL), **FS111-M-HULL2**, **FS111-M2-INT**.
Plan: `plans/FS131-kernel-plan.md` § 6. Every statement here is about one measurable set `A` with null unit pairs,
as FS-129's audit restated them (HULLSET's `uses only:` — "reads only that A's own unit pairs are null").

The engine is I-D1: a point of density `1` and a point of positive upper density are never exactly `1` apart.
Everything else is I-D1 plus the continuity of `dist x ·` on a connected set.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

/-- A unit complex number is `e θ₀` for some `θ₀ ∈ [0, 2π)`. -/
theorem exists_angle_of_norm_eq_one {z : ℂ} (hz : ‖z‖ = 1) : ∃ θ₀ ∈ Ico 0 (2 * Real.pi), z = e θ₀ := by
  have h := Complex.norm_mul_exp_arg_mul_I z
  rw [hz] at h
  have hz' : z = e z.arg := by
    calc z = ((1 : ℝ) : ℂ) * cexp (↑z.arg * I) := h.symm
      _ = e z.arg := by simp [e]
  have hlo := Complex.neg_pi_lt_arg z
  have hhi := Complex.arg_le_pi z
  rcases le_or_gt 0 z.arg with h0 | h0
  · exact ⟨z.arg, ⟨h0, by linarith [Real.pi_pos]⟩, hz'⟩
  · refine ⟨z.arg + 2 * Real.pi, ⟨by linarith, by linarith⟩, ?_⟩
    rw [e_add_two_pi]; exact hz'

/-- A length-`r` half-open interval of angles inside `[0, 2π)` lies within `r` of any `θ₀ ∈ [0, 2π)` (`r ≤ π`). -/
theorem exists_interval_near {θ₀ r : ℝ} (hθ₀ : θ₀ ∈ Ico 0 (2 * Real.pi)) (hr : 0 < r) (hrπ : r ≤ Real.pi) :
    ∃ a : ℝ, Ico a (a + r) ⊆ Ico 0 (2 * Real.pi) ∧ ∀ θ ∈ Ico a (a + r), |θ - θ₀| ≤ r := by
  rcases le_or_gt θ₀ Real.pi with h | h
  · refine ⟨θ₀, fun θ hθ => ⟨by linarith [hθ.1, hθ₀.1], by linarith [hθ.2]⟩, fun θ hθ => ?_⟩
    rw [abs_le]; constructor <;> linarith [hθ.1, hθ.2]
  · refine ⟨θ₀ - r, fun θ hθ => ⟨by linarith [hθ.1], by linarith [hθ.2, hθ₀.2]⟩, fun θ hθ => ?_⟩
    rw [abs_le]; constructor <;> linarith [hθ.1, hθ.2]

/-- In an interval of directions of positive length inside `[0, 2π)` some direction has a null slice of unit pairs. -/
theorem exists_mem_slice_null {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {I : Set ℝ}
    (hI : MeasurableSet I) (hIsub : I ⊆ Ico 0 (2 * Real.pi)) (hpos : 0 < volume I) :
    ∃ θ ∈ I, volume {x : ℂ | x ∈ A ∧ x + e θ ∈ A} = 0 := by
  by_contra hcon
  push Not at hcon
  have h := (unitPairsNull_iff_ae_slice hA).mp hnull
  have hz := ae_iff.mp h
  have hsub : I ⊆ {θ | ¬ volume {x : ℂ | x ∈ A ∧ x + e θ ∈ A} = 0} := fun θ hθ => hcon θ hθ
  have : arcLength I = 0 := measure_mono_null hsub hz
  rw [arcLength, Measure.restrict_apply hI, inter_eq_left.mpr hIsub] at this
  exact hpos.ne' this

/-- The heart of I-D1: with a null slice at direction `θ` near `θ₀`, the mass of `A` in the ball about `x` is at most the mass of the complement of `A` in the doubled ball about `y = x + e θ₀`. -/
theorem measure_inter_closedBall_le {A : Set ℂ} {x y : ℂ} {r θ θ₀ : ℝ} (hy : y = x + e θ₀)
    (hθ : ‖e θ - e θ₀‖ ≤ r) (hslice : volume {z : ℂ | z ∈ A ∧ z + e θ ∈ A} = 0) :
    volume (A ∩ closedBall x r) ≤ volume (closedBall y (2 * r) \ A) := by
  have hsub : A ∩ closedBall x r ⊆
      {z : ℂ | z ∈ A ∧ z + e θ ∈ A} ∪ (fun z => z + e θ) ⁻¹' (closedBall y (2 * r) \ A) := by
    rintro z ⟨hzA, hz⟩
    by_cases h : z + e θ ∈ A
    · exact Or.inl ⟨hzA, h⟩
    · refine Or.inr ⟨?_, h⟩
      rw [mem_closedBall, dist_eq_norm] at hz ⊢
      have : z + e θ - y = (z - x) + (e θ - e θ₀) := by rw [hy]; ring
      rw [this]
      calc ‖(z - x) + (e θ - e θ₀)‖ ≤ ‖z - x‖ + ‖e θ - e θ₀‖ := norm_add_le _ _
        _ ≤ 2 * r := by linarith
  calc volume (A ∩ closedBall x r) ≤ volume ({z : ℂ | z ∈ A ∧ z + e θ ∈ A} ∪
        (fun z => z + e θ) ⁻¹' (closedBall y (2 * r) \ A)) := measure_mono hsub
    _ ≤ volume {z : ℂ | z ∈ A ∧ z + e θ ∈ A} + volume ((fun z => z + e θ) ⁻¹' (closedBall y (2 * r) \ A)) :=
        measure_union_le _ _
    _ = volume (closedBall y (2 * r) \ A) := by rw [hslice, zero_add, measure_preimage_add_right]

/-- The area of a closed ball in `ℂ`, as `r² ·` (area of the unit ball). -/
theorem volume_real_closedBall (z : ℂ) {r : ℝ} (hr : 0 ≤ r) :
    volume.real (closedBall z r) = r ^ 2 * volume.real (closedBall (0 : ℂ) 1) := by
  rw [Measure.addHaar_real_closedBall' volume z hr, Complex.finrank_real_complex]

/-- The unit ball has positive finite area. -/
theorem volume_real_closedBall_one_pos : 0 < volume.real (closedBall (0 : ℂ) 1) :=
  ENNReal.toReal_pos (measure_closedBall_pos volume 0 one_pos).ne' measure_closedBall_lt_top.ne

/-- A preconnected set never at distance `1` from `x` lies entirely inside or entirely outside the unit sphere. -/
theorem preconnected_dist_lt_or_gt {S : Set ℂ} (hS : IsPreconnected S) {x : ℂ}
    (h : ∀ s ∈ S, dist x s ≠ 1) : (∀ s ∈ S, dist x s < 1) ∨ (∀ s ∈ S, 1 < dist x s) := by
  by_contra hcon
  push Not at hcon
  obtain ⟨⟨s₁, hs₁, h1⟩, ⟨s₂, hs₂, h2⟩⟩ := hcon
  have hgt : 1 < dist x s₁ := lt_of_le_of_ne h1 (h s₁ hs₁).symm
  have hlt : dist x s₂ < 1 := lt_of_le_of_ne h2 (h s₂ hs₂)
  have himg : IsPreconnected ((fun y => dist x y) '' S) :=
    hS.image _ (continuous_const.dist continuous_id).continuousOn
  have hone : (1 : ℝ) ∈ (fun y => dist x y) '' S :=
    himg.Icc_subset ⟨s₂, hs₂, rfl⟩ ⟨s₁, hs₁, rfl⟩ ⟨hlt.le, hgt.le⟩
  obtain ⟨y, hy, hy1⟩ := hone
  exact h y hy hy1

/-- **I-D1, set form** (FS111-V0-ID1's argument; G92's widened form): for a measurable `A` with null unit pairs, a
density point `y` of `A` and a point `x` of positive upper density are not at distance `1`. -/
theorem dist_ne_one_of_mem_densitySet {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A)
    {x y : ℂ} (hy : y ∈ densitySet A) (hx : 0 < upperDensityAt A x) : dist x y ≠ 1 := by
  intro h1
  obtain ⟨θ₀, hθ₀, hyx⟩ := exists_angle_of_norm_eq_one (z := y - x)
    (by rw [← dist_eq_norm, dist_comm]; exact h1)
  have hy' : y = x + e θ₀ := by rw [← hyx]; ring
  obtain ⟨δ, -, hδ1, hδ2⟩ := ENNReal.lt_iff_exists_real_btwn.mp hx
  have hδpos : 0 < δ := ENNReal.ofReal_pos.mp hδ1
  have hfreq : ∃ᶠ r in 𝓝[>] (0 : ℝ), ENNReal.ofReal δ < densityRatio A x r :=
    frequently_lt_of_lt_limsup (by isBoundedDefault) hδ2
  have h2 : Tendsto (fun r : ℝ => 2 * r) (𝓝[>] 0) (𝓝[>] 0) :=
    tendsto_nhdsWithin_of_tendsto_nhds_of_eventually_within _
      (((continuous_const.mul continuous_id).tendsto' 0 0 (by simp)).mono_left nhdsWithin_le_nhds)
      (eventually_mem_nhdsWithin.mono fun r hr => by simp only [mem_Ioi] at hr ⊢; linarith)
  have hyT : Tendsto (fun r : ℝ => (densityRatio A y (2 * r)).toReal) (𝓝[>] 0) (𝓝 1) := by
    have := (ENNReal.tendsto_toReal ENNReal.one_ne_top).comp (hy.comp h2)
    simpa [Function.comp_def] using this
  have hev : ∀ᶠ r in 𝓝[>] (0 : ℝ), 1 - δ / 8 < (densityRatio A y (2 * r)).toReal :=
    (tendsto_order.1 hyT).1 _ (by linarith)
  have hev2 : ∀ᶠ r in 𝓝[>] (0 : ℝ), r ∈ Ioc 0 Real.pi := Ioc_mem_nhdsGT Real.pi_pos
  obtain ⟨r, hr1, hr2, hr3⟩ := (hfreq.and_eventually (hev.and hev2)).exists
  obtain ⟨a, hIsub, hIlip⟩ := exists_interval_near hθ₀ hr3.1 hr3.2
  obtain ⟨θ, hθI, hslice⟩ := exists_mem_slice_null hA hnull (I := Ico a (a + r)) measurableSet_Ico hIsub
    (by simp [Real.volume_Ico, hr3.1])
  have hnorm : ‖e θ - e θ₀‖ ≤ r := (norm_e_sub_e_le θ θ₀).trans (hIlip θ hθI)
  have hmain := measure_inter_closedBall_le hy' hnorm hslice
  -- real bookkeeping
  have hc := volume_real_closedBall_one_pos
  set c := volume.real (closedBall (0 : ℂ) 1) with hcdef
  have hr0 : 0 < r := hr3.1
  have hVx : volume.real (closedBall x r) = r ^ 2 * c := volume_real_closedBall x hr0.le
  have hVy : volume.real (closedBall y (2 * r)) = (2 * r) ^ 2 * c :=
    volume_real_closedBall y (by linarith)
  have hV0 : volume (closedBall x r) ≠ 0 := (measure_closedBall_pos volume x hr0).ne'
  have hVt : volume (closedBall x r) ≠ ⊤ := measure_closedBall_lt_top.ne
  -- x side
  have hxs : ENNReal.ofReal δ * volume (closedBall x r) < volume (A ∩ closedBall x r) :=
    (ENNReal.lt_div_iff_mul_lt (Or.inl hV0) (Or.inl hVt)).mp hr1
  have hAx : volume (A ∩ closedBall x r) ≠ ⊤ :=
    (lt_of_le_of_lt (measure_mono inter_subset_right) measure_closedBall_lt_top).ne
  have hxs' : δ * (r ^ 2 * c) < (volume (A ∩ closedBall x r)).toReal := by
    have := ENNReal.toReal_strict_mono hAx hxs
    have hVx' : (volume (closedBall x r)).toReal = r ^ 2 * c := hVx
    rwa [ENNReal.toReal_mul, ENNReal.toReal_ofReal hδpos.le, hVx'] at this
  -- y side
  have hb : 0 < (2 * r) ^ 2 * c := by positivity
  have hr2' : 1 - δ / 8 < (volume (A ∩ closedBall y (2 * r))).toReal / ((2 * r) ^ 2 * c) := by
    rw [densityRatio, ENNReal.toReal_div] at hr2
    rwa [← hVy]
  rw [lt_div_iff₀ hb] at hr2'
  have hsum := measureReal_inter_add_sdiff (μ := volume) (s := closedBall y (2 * r)) hA measure_closedBall_lt_top.ne
  rw [inter_comm] at hsum
  have hdd : (volume (closedBall y (2 * r) \ A)).toReal ≤ (volume (closedBall y (2 * r))).toReal := by
    exact ENNReal.toReal_mono measure_closedBall_lt_top.ne (measure_mono sdiff_subset)
  have hmain' : (volume (A ∩ closedBall x r)).toReal ≤ (volume (closedBall y (2 * r) \ A)).toReal :=
    ENNReal.toReal_mono (lt_of_le_of_lt (measure_mono sdiff_subset) measure_closedBall_lt_top).ne hmain
  have hsum' : (volume (A ∩ closedBall y (2 * r))).toReal + (volume (closedBall y (2 * r) \ A)).toReal
      = (2 * r) ^ 2 * c := by
    rw [← hVy]; exact hsum
  have ht : 0 < r ^ 2 * c := by positivity
  nlinarith

/-- **FS111-V0-ID1** (I-D1): in every measurable colouring proper at almost every unit pair, if `y ∈ S̃_j` and
`d̄_j(x) > 0` then `|x − y| ≠ 1`. -/
theorem AeColouring.dist_ne_one {k : ℕ} (c : AeColouring k) (j : Fin k) {x y : ℂ}
    (hy : y ∈ densitySet (c.col ⁻¹' {j})) (hx : 0 < upperDensityAt (c.col ⁻¹' {j}) x) : dist x y ≠ 1 := by
  exact dist_ne_one_of_mem_densitySet (c.measurable (measurableSet_singleton j)) (c.unitPairsNull j) hy hx

/-- A density point has positive upper density (it has upper density `1`). -/
theorem upperDensityAt_pos_of_mem_densitySet {A : Set ℂ} {x : ℂ} (hx : x ∈ densitySet A) :
    0 < upperDensityAt A x := by
  have : upperDensityAt A x = 1 := hx.limsup_eq
  rw [this]; exact one_pos

/-- **FS129-SR2-HULLSET**, first clause (with FS111-C-HULL merged into it): for a measurable `A` with null unit pairs,
every preconnected `C ⊆ Ã` and every `x` with `d̄_A(x) > 0`, either every point of `C` is within distance below `1`
of `x` or every point of `C` is farther than `1`. (The row says path-connected; the argument reads only
preconnectedness — a generalization, reported.) -/
theorem hullset {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {C : Set ℂ}
    (hC : IsPreconnected C) (hCA : C ⊆ densitySet A) {x : ℂ} (hx : 0 < upperDensityAt A x) :
    (∀ c ∈ C, dist x c < 1) ∨ (∀ c ∈ C, 1 < dist x c) := by
  exact preconnected_dist_lt_or_gt hC fun c hc => dist_ne_one_of_mem_densitySet hA hnull (hCA hc) hx

/-- **FS129-SR2-HULLSET**, second clause: when `C` is moreover compact, the bound is uniform — `sup_{c ∈ C} |x − c| < 1`
or `dist(x, C) > 1`, written with explicit bounds so that an empty `C` reads no junk value. -/
theorem hullset_of_isCompact {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {C : Set ℂ}
    (hC : IsPreconnected C) (hCc : IsCompact C) (hCA : C ⊆ densitySet A) {x : ℂ}
    (hx : 0 < upperDensityAt A x) :
    (∃ r < 1, ∀ c ∈ C, dist x c ≤ r) ∨ (∃ r > 1, ∀ c ∈ C, r ≤ dist x c) := by
  rcases C.eq_empty_or_nonempty with rfl | hne
  · exact Or.inl ⟨0, one_pos, by simp⟩
  have hcont : ContinuousOn (fun c => dist x c) C := (continuous_const.dist continuous_id).continuousOn
  rcases hullset hA hnull hC hCA hx with h | h
  · obtain ⟨m, hm, hmax⟩ := hCc.exists_isMaxOn hne hcont
    exact Or.inl ⟨dist x m, h m hm, fun c hc => hmax hc⟩
  · obtain ⟨m, hm, hmin⟩ := hCc.exists_isMinOn hne hcont
    exact Or.inr ⟨dist x m, h m hm, fun c hc => hmin hc⟩

/-- **FS111-M-HULL2**: two preconnected pieces of one class — `P` of points of positive upper density, `Q` of density
points — have all cross distances below `1` or all above `1`. (The row says "path-connected pieces of one class"; its
`uses only:` reads C-HULL at each point of one piece and path-connectedness of the other.) -/
theorem hull2 {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {P Q : Set ℂ}
    (hP : IsPreconnected P) (hQ : IsPreconnected Q) (hPA : P ⊆ {x | 0 < upperDensityAt A x})
    (hQA : Q ⊆ densitySet A) :
    (∀ p ∈ P, ∀ q ∈ Q, dist p q < 1) ∨ (∀ p ∈ P, ∀ q ∈ Q, 1 < dist p q) := by
  rcases Q.eq_empty_or_nonempty with rfl | ⟨q₀, hq₀⟩
  · exact Or.inl (by simp)
  have hPq : (∀ p ∈ P, dist q₀ p < 1) ∨ (∀ p ∈ P, 1 < dist q₀ p) :=
    preconnected_dist_lt_or_gt hP fun p hp => by
      rw [dist_comm]; exact dist_ne_one_of_mem_densitySet hA hnull (hQA hq₀) (hPA hp)
  rcases hPq with h | h
  · left
    intro p hp q hq
    rcases hullset hA hnull hQ hQA (hPA hp) with h' | h'
    · exact h' q hq
    · exact absurd (h' q₀ hq₀) (by rw [dist_comm]; exact not_lt.mpr (h p hp).le)
  · right
    intro p hp q hq
    rcases hullset hA hnull hQ hQA (hPA hp) with h' | h'
    · exact absurd (h' q₀ hq₀) (by rw [dist_comm]; exact not_lt.mpr (h p hp).le)
    · exact h' q hq

/-- **FS111-M2-INT**: for a measurable `A` with null unit pairs, no point of the interior of its density set is at
distance exactly `1` from a point of the closure of its density set. -/
theorem dist_ne_one_of_mem_interior_densitySet {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A)
    {x y : ℂ} (hx : x ∈ interior (densitySet A)) (hy : y ∈ closure (densitySet A)) : dist x y ≠ 1 := by
  intro h1
  obtain ⟨ε₀, hε₀, hball⟩ := Metric.isOpen_iff.mp isOpen_interior x hx
  set ε := min ε₀ 1 with hε
  have hε0 : 0 < ε := lt_min hε₀ one_pos
  have hεle : ε ≤ 1 := min_le_right _ _
  have hball' : ball x ε ⊆ densitySet A := fun z hz =>
    interior_subset (hball (lt_of_lt_of_le (mem_ball.mp hz) (min_le_left _ _)))
  obtain ⟨y', hy'A, hyy'⟩ := Metric.mem_closure_iff.mp hy (ε / 2) (by positivity)
  have hd1 : |dist x y' - 1| < ε / 2 := by
    have a := dist_triangle x y y'
    have b := dist_triangle x y' y
    rw [dist_comm y' y] at b
    rw [h1] at a b
    rw [abs_lt]; constructor <;> linarith
  have hne : x - y' ≠ 0 := by
    intro h0
    rw [sub_eq_zero] at h0
    rw [h0, dist_self] at hd1
    simp at hd1
    linarith
  have hnorm : ‖x - y'‖ = dist x y' := (dist_eq_norm x y').symm
  have hpos : 0 < ‖x - y'‖ := norm_pos_iff.mpr hne
  set x' : ℂ := y' + (x - y') / (‖x - y'‖ : ℂ) with hx'
  have hxy' : dist x' y' = 1 := by
    rw [dist_eq_norm, hx', add_sub_cancel_left, norm_div, Complex.norm_real, norm_norm,
      div_self hpos.ne']
  have hxx' : dist x' x < ε := by
    have : x' - x = (x - y') * (((1 / ‖x - y'‖ : ℝ) : ℂ) - 1) := by
      rw [hx']
      have : (‖x - y'‖ : ℂ) ≠ 0 := by exact_mod_cast hpos.ne'
      push_cast
      field_simp
      ring
    rw [dist_eq_norm, this, norm_mul]
    have h2 : ‖(((1 / ‖x - y'‖ : ℝ) : ℂ) - 1)‖ = |1 / ‖x - y'‖ - 1| := by
      rw [← Complex.ofReal_one, ← Complex.ofReal_sub, Complex.norm_real, Real.norm_eq_abs]
    rw [h2]
    have : ‖x - y'‖ * |1 / ‖x - y'‖ - 1| = |1 - ‖x - y'‖| := by
      rw [← abs_of_pos hpos, ← abs_mul, abs_of_pos hpos, mul_sub, mul_one_div_cancel hpos.ne', mul_one]
    rw [this, abs_sub_comm, hnorm]
    linarith
  have hx'A : x' ∈ densitySet A := hball' (by rwa [mem_ball])
  exact dist_ne_one_of_mem_densitySet hA hnull hy'A (upperDensityAt_pos_of_mem_densitySet hx'A) hxy'

end HadwigerNelson.Plane
