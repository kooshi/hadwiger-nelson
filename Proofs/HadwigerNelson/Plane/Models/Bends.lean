import Proofs.HadwigerNelson.Plane.Models.Paint

/-!
# Models of the bends: a ring arc of the cusp fragment, and a plane map with a radius-2 contact interval (FS131-KM1, skeleton)

`plans/FS131-models-kernel-plan.md` § 5.

* **`bend_toward`, `bend_away_whole`** (`Plane/ValidMap/UnitArc`): the arc of `ω(i)` over `[−π/2 + 1/10, −π/2 + 2/5]` in `cuspFrag`, inner
  colour `0`, outer colour `1`. Its centre `i` is outside the closure of the domain `B(0, 1/2)`, so it carries no colour, and the
  radius-2 arc is `1/2` from the domain: both bends' hypotheses hold (`cuspFrag_bend_away`, `cuspFrag_bend_toward`).
* **`awayModel : ArcMap 8`** (FS131-KA1's plan § 5; the inhabitant of wave 5's `bend_away_part`): the brick map with the colour `7` on the
  part of the brick `(0, 4/5) × (0, 3/5)` inside `B(P, 1)` and on the part of the brick `(4/5, 8/5) × (0, 3/5)` outside `B̄(P, 2)`,
  `P = −3/5 + (3/10) i`. A unit arc of `ω(P)` with inner colour `7`, absent at `P`, whose radius-2 contacts are an interval strictly inside
  its angles.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## The cusp fragment's ring arc -/

/-- The sine of an angle of the cusp arc: for `θ + π/2 ∈ [1/10, 2/5]`, `−1 < sin θ ≤ −23/25`. -/
theorem cuspArc_sin {θ : ℝ} (h1 : -(π / 2) + 1 / 10 ≤ θ) (h2 : θ ≤ -(π / 2) + 2 / 5) :
    -1 < Real.sin θ ∧ Real.sin θ ≤ -23 / 25 := by
  have hπ := Real.pi_pos
  set t := θ + π / 2 with ht
  have ht1 : 1 / 10 ≤ t := by rw [ht]; linarith
  have ht2 : t ≤ 2 / 5 := by rw [ht]; linarith
  have hs : Real.sin θ = -Real.cos t := by rw [ht, Real.cos_add_pi_div_two, neg_neg]
  have hc : Real.cos θ = Real.sin t := by rw [ht, Real.sin_add_pi_div_two]
  have hpos : 0 < Real.sin t := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith [Real.pi_gt_three])
  have hcos : 1 - t ^ 2 / 2 ≤ Real.cos t := Real.one_sub_sq_div_two_le_cos
  have hsq := Real.sin_sq_add_cos_sq t
  constructor
  · rw [hs]; nlinarith
  · rw [hs]; nlinarith

/-- A point of the cusp arc in coordinates. -/
theorem cuspArc_pt (θ : ℝ) : ringPt I θ = ⟨Real.cos θ, 1 + Real.sin θ⟩ := by
  rw [ringPt, e_eq]
  apply Complex.ext <;> simp [Complex.cos_ofReal_re, Complex.sin_ofReal_re]

/-- A point of the cusp arc is in the fragment's domain and outside the closed unit disc about `−i`. -/
theorem cuspArc_mem {θ : ℝ} (h1 : -(π / 2) + 1 / 10 ≤ θ) (h2 : θ ≤ -(π / 2) + 2 / 5) :
    ‖ringPt I θ‖ < 1 / 2 ∧ 1 < ‖ringPt I θ + I‖ := by
  obtain ⟨hs1, hs2⟩ := cuspArc_sin h1 h2
  have hsq := Real.sin_sq_add_cos_sq θ
  have e1 : ‖ringPt I θ‖ ^ 2 = 2 + 2 * Real.sin θ := by
    rw [cuspArc_pt, ← Complex.normSq_eq_norm_sq, Complex.normSq_apply]; nlinarith
  have e2 : ‖ringPt I θ + I‖ ^ 2 = 5 + 4 * Real.sin θ := by
    rw [cuspArc_pt, ← Complex.normSq_eq_norm_sq, Complex.normSq_apply]; simp; nlinarith
  constructor
  · nlinarith [norm_nonneg (ringPt I θ)]
  · nlinarith [norm_nonneg (ringPt I θ + I)]

/-- **A ring arc of the cusp fragment**: the arc of `ω(i)` over `[−π/2 + 1/10, −π/2 + 2/5]`, inner colour `0`, outer colour `1`. -/
theorem cuspFrag_isRingArc : ArcMap.cuspFrag.IsRingArc I (-(π / 2) + 1 / 10) (-(π / 2) + 2 / 5) 0 1 := by
  classical
  set O : Set ℂ := ball 0 (1 / 2) ∩ {w | 1 < ‖w + I‖} with hOdef
  have hO : IsOpen O := isOpen_ball.inter (isOpen_lt continuous_const (by fun_prop))
  -- in `O` the interior points are the points off `ω(i)`, coloured by the side of `ω(i)`
  have hint : ∀ w ∈ O, ‖w - I‖ ≠ 1 → w ∈ ArcMap.cuspFrag.interiorPts := fun w hw h =>
    ArcMap.cuspFrag_mem_interiorPts.mpr ⟨mem_ball_zero_iff.mp hw.1, h, (ne_of_gt hw.2)⟩
  have hcol0 : ∀ w, ‖w - I‖ < 1 → ArcMap.cuspFrag.col w = 0 := fun w h => by
    show ArcMap.cuspCol w = 0
    simp only [ArcMap.cuspCol, not_lt.mpr h.le, false_and, if_false]
  have hcol1 : ∀ w ∈ O, 1 < ‖w - I‖ → ArcMap.cuspFrag.col w = 1 := fun w hw h => by
    show ArcMap.cuspCol w = 1
    have h2 : 1 < ‖w + I‖ := hw.2
    simp only [ArcMap.cuspCol, h, h2, and_self, if_true]
  refine ⟨by linarith, fun z hz => ?_, fun θ hθ => ?_⟩
  · obtain ⟨θ, hθ, rfl⟩ := hz
    refine ⟨mem_ball_zero_iff.mpr (cuspArc_mem hθ.1 hθ.2).1, mem_iUnion₂.mpr ⟨.circ I 1 0 (2 * π), Or.inl rfl, ?_⟩⟩
    rw [ArcMap.carrier_circ_full]; exact ringPt_mem_sphere I θ
  set z := ringPt I θ with hz
  have hzO : z ∈ O := ⟨mem_ball_zero_iff.mpr (cuspArc_mem hθ.1.le hθ.2.le).1, (cuspArc_mem hθ.1.le hθ.2.le).2⟩
  have hzI : dist z I = 1 := dist_ringPt I θ
  constructor
  · ext c
    simp only [ArcMap.innerColours, mem_setOf_eq, mem_singleton_iff]
    constructor
    · intro h
      obtain ⟨w, -, hw, hwb⟩ := mem_closure_iff.mp h O hO hzO
      rw [mem_ball, dist_eq_norm] at hwb
      rw [← hw.2, hcol0 w hwb]
    · rintro rfl
      have hzU : z ∈ closure (O ∩ ball I 1) :=
        hO.inter_closure ⟨hzO, by rw [closure_ball I one_ne_zero, mem_closedBall, hzI]⟩
      refine closure_mono (fun w hw => ?_) hzU
      have hwb : ‖w - I‖ < 1 := by have := hw.2; rwa [mem_ball, dist_eq_norm] at this
      exact ⟨⟨hint w hw.1 hwb.ne, hcol0 w hwb⟩, hw.2⟩
  · ext c
    simp only [ArcMap.outerColours, mem_setOf_eq, mem_singleton_iff]
    constructor
    · intro h
      obtain ⟨w, hwO, hw, hwb⟩ := mem_closure_iff.mp h O hO hzO
      rw [mem_closedBall, dist_eq_norm, not_le] at hwb
      rw [← hw.2, hcol1 w hwO hwb]
    · rintro rfl
      have hzU : z ∈ closure (O ∩ (closedBall I 1)ᶜ) :=
        hO.inter_closure ⟨hzO, by
          rw [closure_compl, interior_closedBall I one_ne_zero, mem_compl_iff, mem_ball, hzI]; exact lt_irrefl 1⟩
      refine closure_mono (fun w hw => ?_) hzU
      have hwb : 1 < ‖w - I‖ := by have := hw.2; rwa [mem_compl_iff, mem_closedBall, dist_eq_norm, not_le] at this
      exact ⟨⟨hint w hw.1 hwb.ne', hcol1 w hw.1 hwb⟩, hw.2⟩

/-- The classes of the cusp fragment lie, with their closures, in the closed disc of radius `1/2`. -/
theorem cuspFrag_closure_region_subset (j : Fin 2) : closure (ArcMap.cuspFrag.region j) ⊆ closedBall 0 (1 / 2) :=
  closure_minimal (fun _ hw => ball_subset_closedBall (ArcMap.cuspFrag.interiorPts_subset_dom hw.1)) isClosed_closedBall

/-- The centre `i` carries no colour of the cusp fragment: it is `1/2` from the domain. -/
theorem cuspFrag_coloursAt_I : ArcMap.cuspFrag.coloursAt I = ∅ := by
  ext j
  simp only [ArcMap.coloursAt, mem_setOf_eq, mem_empty_iff_false, iff_false]
  intro h
  have := cuspFrag_closure_region_subset j h
  rw [mem_closedBall, dist_zero_right, Complex.norm_I] at this
  norm_num at this

/-- The radius-2 arc about `i` over the ring arc's angles misses the closure of the inner colour's class. -/
theorem cuspFrag_radiusTwo_disjoint :
    Disjoint (ArcMap.radiusTwoArc I (-(π / 2) + 1 / 10) (-(π / 2) + 2 / 5)) (closure (ArcMap.cuspFrag.region 0)) := by
  rw [disjoint_left]
  rintro _ ⟨θ, -, rfl⟩ h
  have h2 := cuspFrag_closure_region_subset 0 h
  rw [mem_closedBall, dist_zero_right] at h2
  have h3 : ‖(2 : ℂ) * e θ‖ = 2 := by rw [norm_mul, norm_e]; simp
  have h4 := norm_sub_norm_le ((2 : ℂ) * e θ) (-I)
  rw [norm_neg, Complex.norm_I, h3, sub_neg_eq_add, add_comm] at h4
  linarith

/-- **The model of `bend_away_whole`**: the bend applied to the cusp fragment's ring arc. -/
theorem cuspFrag_bend_away : ∃ F' : ArcMap 2, F'.Valid ∧
    ∀ θ ∈ Ioo (-(π / 2) + 1 / 10) (-(π / 2) + 2 / 5), ¬ F'.OnRingArc I (ringPt I θ) := by
  obtain ⟨F', h1, -, -, h2, -⟩ := ArcMap.bend_away_whole ArcMap.cuspFrag_valid cuspFrag_isRingArc
    (by simp [cuspFrag_coloursAt_I]) cuspFrag_radiusTwo_disjoint one_pos
  exact ⟨F', h1, h2⟩

/-- **The model of `bend_toward`**: the bend applied to the same arc (the outer colour is not carried at the centre either). -/
theorem cuspFrag_bend_toward : ∃ F' : ArcMap 2, F'.Valid ∧
    ∀ θ ∈ Ioo (-(π / 2) + 1 / 10) (-(π / 2) + 2 / 5), ¬ F'.OnRingArc I (ringPt I θ) := by
  obtain ⟨F', h1, -, -, h2, -⟩ := ArcMap.bend_toward ArcMap.cuspFrag_valid cuspFrag_isRingArc
    (by simp [cuspFrag_coloursAt_I]) one_pos
  exact ⟨F', h1, h2⟩

/-! ## The outward bend's plane map -/

/-- The centre of `awayModel`'s unit arc. -/
noncomputable def awayP : ℂ := -3 / 5 + 3 / 10 * I

/-- The painted set of `awayModel`: the brick `(0, 4/5) × (0, 3/5)` inside `B(P, 1)` and the brick `(4/5, 8/5) × (0, 3/5)` outside
`B̄(P, 2)`. -/
noncomputable def awayW : Set ℂ :=
  ({z | 0 < z.re ∧ z.re < 4 / 5 ∧ 0 < z.im ∧ z.im < 3 / 5} ∩ ball awayP 1) ∪
    ({z | 4 / 5 < z.re ∧ z.re < 8 / 5 ∧ 0 < z.im ∧ z.im < 3 / 5} \ closedBall awayP 2)

/-- The new arcs of `awayModel`: the arcs of the circles of radii `1` and `2` about `P` across their bricks, wall to wall. -/
noncomputable def awayArcs : Set Arc :=
  {Arc.circ awayP 1 (-(Real.arcsin (3 / 10))) (Real.arcsin (3 / 10)),
    Arc.circ awayP 2 (-(Real.arcsin (3 / 20))) (Real.arcsin (3 / 20))}

theorem awayArcs_nondegenerate : ∀ a ∈ awayArcs, a.Nondegenerate := by
  sorry

theorem awayArcs_finite : awayArcs.Finite := (finite_singleton _).insert _

theorem frontier_awayW_subset : frontier awayW ⊆ ⋃ a ∈ (brickBase 8 (by norm_num)).arcs ∪ awayArcs, a.carrier := by
  sorry

/-- **The outward bend's plane map** (FS131-KA1 § 5): the brick map in eight colours with `7` painted on `awayW`. -/
noncomputable def awayModel : ArcMap 8 :=
  (brickBase 8 (by norm_num)).paint awayW awayArcs awayArcs_nondegenerate awayArcs_finite frontier_awayW_subset (fun _ => 7)
    (fun _ _ _ => Filter.Eventually.of_forall fun _ => rfl)

/-- **The hypotheses of `bend_away_part`, at once**: `awayModel` is a valid map of the plane; the arc of `ω(P)` over
`[−arcsin(3/10), arcsin(3/10)]` is a ring arc with inner colour `7` and outer colour `0`; `7` is not carried at `P`; and near each interior
point of the arc `Γ` lies on `ω(P)`. -/
theorem awayModel_hyps : awayModel.Valid ∧ awayModel.IsPlaneMap ∧
    awayModel.IsRingArc awayP (-(Real.arcsin (3 / 10))) (Real.arcsin (3 / 10)) 7 0 ∧ (7 : Fin 8) ∉ awayModel.coloursAt awayP ∧
    ∀ θ ∈ Ioo (-(Real.arcsin (3 / 10))) (Real.arcsin (3 / 10)), ∃ r > 0, awayModel.Γ ∩ ball (ringPt awayP θ) r ⊆ sphere awayP 1 := by
  sorry

/-- **What `awayModel` exercises**: the radius-2 contacts of the arc's inner colour are the interval `[−arcsin(3/20), arcsin(3/20)]`,
strictly inside the arc's angles — two gaps and a contact piece. -/
theorem awayModel_r2Contacts : awayModel.r2Contacts awayP (-(Real.arcsin (3 / 10))) (Real.arcsin (3 / 10)) 7 =
    Icc (-(Real.arcsin (3 / 20))) (Real.arcsin (3 / 20)) := by
  sorry

end HadwigerNelson.Plane
