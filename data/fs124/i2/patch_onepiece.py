#!/usr/bin/env python3
"""FS124-I2 — writes the proofs of Plane/OnePiece into a copy of the skeleton file (a working tool, not a check):
each `sorry` body is replaced by its proof, found by the head of its declaration; helpers are inserted before a named
anchor. Refuses if a head or an anchor is missing, or if another declaration starts between a head and its `sorry`.
Usage: patch_onepiece.py <skeleton OnePiece.lean> <output>"""
import pathlib, sys
src, dst = sys.argv[1], sys.argv[2]
s = pathlib.Path(src).read_text()

def rep(head, body, old="  sorry\n"):
    global s
    i = s.index(head)
    j = s.index(old, i)
    mid = s[i + 10:j]
    assert "\ntheorem " not in mid and "\nexample" not in mid and "\ndef " not in mid, head
    s = s[:j] + body + s[j + len(old):]

def before(anchor, text):
    global s
    assert s.count(anchor) == 1, anchor
    s = s.replace(anchor, text + anchor)

rep("theorem unitShadow_mono", "  exact fun z ⟨y, hy, hd⟩ => ⟨y, h hy, hd⟩\n")
rep("theorem mem_unitShadow_iff_exists_e", """  constructor
  · rintro ⟨y, hy, hd⟩
    obtain ⟨θ, -, hθ⟩ := exists_angle_of_norm_eq_one (z := y - z) (by rw [← dist_eq_norm, dist_comm]; exact hd)
    exact ⟨θ, by rw [← hθ, add_sub_cancel]; exact hy⟩
  · rintro ⟨θ, hθ⟩
    exact ⟨z + e θ, hθ, by rw [dist_eq_norm, sub_add_cancel_left, norm_neg, norm_e]⟩
""")
rep("theorem eq_empty_of_isOpen_of_ae", """  by_contra hne
  have hnull : volume W = 0 := by
    rw [measure_eq_zero_iff_ae_notMem]
    filter_upwards [h₁, h₂] with z hz₁ hz₂ hzW using hz₂ hzW (hz₁ hzW)
  exact (hW.measure_pos volume (nonempty_iff_ne_empty.mpr hne)).ne' hnull
""")
rep("theorem not_innerAt_iff", "  simp only [InnerAt, not_subset, mem_closedBall, not_le]\n")
rep("theorem not_outerAt_iff", "  simp only [OuterAt, not_disjoint_iff, mem_ball]\n")
rep("theorem crossingAt_iff", "  rw [CrossingAt, not_innerAt_iff, not_outerAt_iff, and_comm]\n")
rep("theorem OnSide.subset_region", """  cases σ
  · have h' : P ⊆ closedBall w 1 := h
    exact (hP.subset_interior_iff.mpr h').trans (interior_closedBall w one_ne_zero).subset
  · have h' : Disjoint P (ball w 1) := h
    have h2 := hP.subset_interior_iff.mpr h'.subset_compl_right
    rwa [interior_compl, closure_ball w one_ne_zero] at h2
""")
rep("theorem onSide_of_subset_region", """  cases σ
  · exact h.trans ball_subset_closedBall
  · exact Set.disjoint_left.mpr fun y hy hb => h hy (ball_subset_closedBall hb)
""")
rep("theorem not_innerAt_and_outerAt", """  rintro ⟨hi, ho⟩
  obtain ⟨y, hy, hd⟩ := exists_dist_ne_of_isOpen hP hne w 1
  exact hd (le_antisymm (hi hy) (not_lt.mp fun hlt => Set.disjoint_left.mp ho hy hlt))
""")
rep("theorem innerAt_or_outerAt_or_crossingAt", """  by_cases hi : InnerAt P w
  · exact Or.inl hi
  · by_cases ho : OuterAt P w
    · exact Or.inr (Or.inl ho)
    · exact Or.inr (Or.inr ⟨hi, ho⟩)
""")
rep("theorem InnerAt.closure_inter_closure_subset", """  rintro y ⟨hyP, hyQ⟩
  have h1 : y ∈ closedBall w 1 := closure_minimal hP isClosed_closedBall hyP
  have h2 : y ∈ (ball w 1)ᶜ := closure_minimal hQ.subset_compl_right isOpen_ball.isClosed_compl hyQ
  exact mem_sphere.mpr (le_antisymm (mem_closedBall.mp h1) (not_lt.mp h2))
""")
rep("theorem IsPieceAt.nonempty", "  exact closure_nonempty_iff.mp ⟨x, h.mem_closure⟩\n")
rep("theorem IsPieceAt.isConnected", "  exact ⟨h.nonempty, h.isPreconnected⟩\n")
rep("theorem IsPieceAt.disjoint", """  refine Set.disjoint_iff_inter_eq_empty.mpr
    (eq_empty_of_isOpen_of_ae (c := c) (hP.isOpen.inter hQ.isOpen) (i := i) ?_ ?_)
  · filter_upwards [hP.ae_label] with z hz hzm using hz hzm.1
  · filter_upwards [hQ.ae_label] with z hz hzm
    rw [hz hzm.2]
    exact hij.symm
""")
rep("theorem IsPieceAt.inter_eq_empty", """  refine eq_empty_of_isOpen_of_ae (c := c) (hP.isOpen.inter hV) (i := i) ?_ ?_
  · filter_upwards [hP.ae_label] with z hz hzm using hz hzm.1
  · filter_upwards [h] with z hz hzm using hz hzm.2
""")
rep("theorem IsPieceAt.ae_unitShadow_ne", "  exact hc.ae_unitShadow_ne hP.isOpen hP.subset hP.ae_label\n")
rep("theorem IsPieceAt.ae_ne_of_crossingAt", """  obtain ⟨η₁, hη₁, h1⟩ := hP.ae_ne_region hU hc hw (σ := .inside) hcr.1
  obtain ⟨η₂, hη₂, h2⟩ := hP.ae_ne_region hU hc hw (σ := .outside) hcr.2
  -- almost every point is off the unit circle about `x`, hence on one of its two sides
  have hoff : ∀ᵐ z : ℂ, z ∉ sphere x 1 := measure_eq_zero_iff_ae_notMem.mp (Measure.addHaar_sphere volume x 1)
  refine ⟨min η₁ η₂, lt_min hη₁ hη₂, ?_⟩
  filter_upwards [h1, h2, hoff] with z hz1 hz2 hz3 hzb
  rcases CircleSide.mem_region_or_of_dist_ne (z := z) (w := x) hz3 with h | h
  · exact hz1 (ball_subset_ball (min_le_left _ _) hzb) h
  · exact hz2 (ball_subset_ball (min_le_right _ _) hzb) h
""")
rep("theorem IsPieceAt.innerAt_self", """  by_contra hni
  obtain ⟨η, hη, h⟩ := hP.ae_ne_region hU hc hx (σ := .inside) hni
  have hV : IsOpen (ball x η ∩ CircleSide.inside.region x) := isOpen_ball.inter (CircleSide.isOpen_region _ _)
  have hem := hP.inter_eq_empty hV (by filter_upwards [h] with z hz hzm using hz hzm.1 hzm.2)
  obtain ⟨y, hyV, hyP⟩ := mem_closure_iff.mp hP.mem_closure _ hV
    ⟨mem_ball_self hη, CircleSide.mem_region_inside.mpr (by rw [dist_self]; exact one_pos)⟩
  have hy : y ∈ P ∩ (ball x η ∩ CircleSide.inside.region x) := ⟨hyP, hyV⟩
  rw [hem] at hy
  exact hy
""")
rep("theorem piece_type", """  have hP : IsPieceAt U c x P i := ⟨hPo, hPc.isPreconnected, hPU, hx, hi⟩
  refine ⟨fun h => ?_, fun h => ?_⟩
  · obtain ⟨η, hη, hη'⟩ := hP.ae_ne_region hU hc.aeProperOn hw (σ := .outside)
      (onSide_outside.not.mpr (not_outerAt_iff.mpr h))
    exact ⟨η, hη, by filter_upwards [hη'] with z hz hzb hzx using hz hzb (CircleSide.mem_region_outside.mpr hzx)⟩
  · obtain ⟨η, hη, hη'⟩ := hP.ae_ne_region hU hc.aeProperOn hw (σ := .inside)
      (onSide_inside.not.mpr (not_innerAt_iff.mpr h))
    exact ⟨η, hη, by filter_upwards [hη'] with z hz hzb hzx using hz hzb (CircleSide.mem_region_inside.mpr hzx)⟩
""")
rep("theorem AeProperOn.ae_ne_of_ae_region", """  -- the disc tangent to `S(q)` at `z` on the side `σ`, inside `ball z ρ`: a piece of label `a` at `z`
  obtain ⟨D, hDo, hDc, hzD, hDsub⟩ :=
    exists_convex_subset_region (q := q) (z := z) (by rw [dist_comm]; exact hqz) σ hρ
  have hD : IsPieceAt U c z D a := ⟨hDo, hDc.isPreconnected, fun y hy => hball (hDsub hy).1, hzD, by
    filter_upwards [ha] with w hw hwD using hw (hDsub hwD).1 (hDsub hwD).2⟩
  -- it is not on the closed side `σ.flip` of that circle: its points are strictly on the side `σ`
  obtain ⟨y, hy⟩ := hD.nonempty
  have hns : ¬ OnSide σ.flip D q := not_onSide_iff.mpr ⟨y, hy, by rw [CircleSide.flip_flip]; exact (hDsub hy).2⟩
  exact hD.ae_ne_region hU hc hq hns
""")
rep("theorem centre_half", """  refine ⟨fun h => ?_, fun h => ?_⟩
  · obtain ⟨η, hη, hη'⟩ := hc.aeProperOn.ae_ne_of_ae_region hU hq hqz hρ hball (σ := .inside) (a := a)
      (by filter_upwards [h] with w hw hwb hwq using hw hwb (CircleSide.mem_region_inside.mp hwq))
    exact ⟨η, hη, by filter_upwards [hη'] with p hp hpb hpz using hp hpb (CircleSide.mem_region_outside.mpr hpz)⟩
  · obtain ⟨η, hη, hη'⟩ := hc.aeProperOn.ae_ne_of_ae_region hU hq hqz hρ hball (σ := .outside) (a := a)
      (by filter_upwards [h] with w hw hwb hwq using hw hwb (CircleSide.mem_region_outside.mp hwq))
    exact ⟨η, hη, by filter_upwards [hη'] with p hp hpb hpz using hp hpb (CircleSide.mem_region_inside.mpr hpz)⟩
""")
rep("theorem IsTightWith.mem", "  exact h.ball_subset (mem_ball_self h.pos)\n")
rep("theorem IsTightWith.mono", """  refine ⟨h.dist_eq, h.ne, hρ', (ball_subset_ball hle).trans h.ball_subset, ?_, ?_⟩
  · filter_upwards [h.ae_inside] with w hw hwb using hw (ball_subset_ball hle hwb)
  · filter_upwards [h.ae_outside] with w hw hwb using hw (ball_subset_ball hle hwb)
""")
rep("theorem isOpen_innerCollar", "  exact isOpen_ball.inter isOpen_ball\n")
rep("theorem isOpen_outerCollar", "  exact isOpen_ball.sdiff isClosed_closedBall\n")
rep("theorem IsTightWith.ae_innerCollar", "  filter_upwards [h.ae_inside] with w hw hwc using hw hwc.1 (mem_ball.mp hwc.2)\n")
rep("theorem IsTightWith.ae_outerCollar", """  filter_upwards [h.ae_outside] with w hw hwc using hw hwc.1 (not_le.mp fun hle => hwc.2 (mem_closedBall.mpr hle))
""")
rep("theorem isTight_of_ae_of_isOpen", """  obtain ⟨ρ, hρ, hsub⟩ := Metric.isOpen_iff.mp hV z hzV
  refine ⟨ρ, hqz, hab, hρ, hsub.trans hVU, ?_, ?_⟩
  · filter_upwards [hin] with w hw hwb using hw (hsub hwb)
  · filter_upwards [hout] with w hw hwb using hw (hsub hwb)
""")
rep("theorem IsTight.ae_ne_centre", """  obtain ⟨ρ, h⟩ := ht
  obtain ⟨η₁, hη₁, h1⟩ := hc.ae_ne_of_ae_region hU hq h.dist_eq h.pos h.ball_subset (σ := .inside) (a := a)
    (by filter_upwards [h.ae_inside] with w hw hwb hwq using hw hwb (CircleSide.mem_region_inside.mp hwq))
  obtain ⟨η₂, hη₂, h2⟩ := hc.ae_ne_of_ae_region hU hq h.dist_eq h.pos h.ball_subset (σ := .outside) (a := b)
    (by filter_upwards [h.ae_outside] with w hw hwb hwq using hw hwb (CircleSide.mem_region_outside.mp hwq))
  refine ⟨min η₁ η₂, lt_min hη₁ hη₂, ?_, ?_⟩
  · filter_upwards [h1] with w hw hwb hwz
    exact hw (ball_subset_ball (min_le_left _ _) hwb) (CircleSide.mem_region_outside.mpr hwz)
  · filter_upwards [h2] with w hw hwb hwz
    exact hw (ball_subset_ball (min_le_right _ _) hwb) (CircleSide.mem_region_inside.mpr hwz)
""")
rep("theorem tight_centre", "  exact ht.ae_ne_centre hU hc.aeProperOn hq\n")
rep("theorem IsTight.ae_ne_straddle", """  obtain ⟨ρ, h⟩ := ht
  have hcross : CrossAt p q z :=
    ⟨by rw [dist_comm]; exact hpz, by rw [dist_comm]; exact h.dist_eq, hpq, fun he => hanti (by linear_combination he)⟩
  -- the unit circle about `p` meets both collars
  obtain ⟨y₁, hy₁p, hy₁z, hy₁q⟩ := hcross.exists_mem_sphere_region .inside h.pos
  obtain ⟨y₂, hy₂p, hy₂z, hy₂q⟩ := hcross.exists_mem_sphere_region .outside h.pos
  have hin : p ∈ U ∩ unitShadow (innerCollar q z ρ) :=
    ⟨hp, y₁, ⟨hy₁z, CircleSide.mem_region_inside.mp hy₁q⟩, by rw [dist_comm]; exact hy₁p⟩
  have hout : p ∈ U ∩ unitShadow (outerCollar q z ρ) :=
    ⟨hp, y₂, ⟨hy₂z, fun hle => (CircleSide.mem_region_outside.mp hy₂q).not_ge (mem_closedBall.mp hle)⟩, by
      rw [dist_comm]; exact hy₂p⟩
  -- so a disc about `p` lies in the shadow of each, inside `U`
  obtain ⟨η, hη, hsub⟩ := Metric.isOpen_iff.mp
    ((hU.inter (isOpen_unitShadow (isOpen_innerCollar q z ρ))).inter
      (hU.inter (isOpen_unitShadow (isOpen_outerCollar q z ρ)))) p ⟨hin, hout⟩
  refine ⟨η, hη, ?_⟩
  filter_upwards [hc.ae_unitShadow_ne (isOpen_innerCollar q z ρ) (fun y hy => h.ball_subset hy.1) h.ae_innerCollar,
    hc.ae_unitShadow_ne (isOpen_outerCollar q z ρ) (fun y hy => h.ball_subset hy.1) h.ae_outerCollar] with w hw1 hw2 hwb
  exact ⟨hw1 (hsub hwb).1, hw2 (hsub hwb).2⟩
""")
rep("theorem tight_straddle", "  exact ht.ae_ne_straddle hU hc.aeProperOn hp hpz hpq hanti\n")
rep("theorem isOpen_tightModelDom", "  exact (isOpen_ball.union isOpen_ball).union isOpen_ball\n")
rep("theorem measurable_tightModel", """  refine Measurable.ite ?_ (Measurable.ite ?_ measurable_const measurable_const) measurable_const
  · exact (isOpen_lt (continuous_id.dist continuous_const) continuous_const).measurableSet
  · exact (isOpen_lt continuous_norm continuous_const).measurableSet
""")
rep("theorem isWeakColouringOn_tightModel", """  refine ⟨measurable_tightModel, aeProperOn_of_proper ?_⟩
  -- two points of one disc of radius `1/10` are not at distance `1`
  have hsame : ∀ c₀ x y : ℂ, x ∈ ball c₀ (1 / 10) → y ∈ ball c₀ (1 / 10) → dist x y ≠ 1 := by
    intro c₀ x y hx hy h
    have := dist_triangle_right x y c₀
    rw [mem_ball] at hx hy
    linarith
  -- nor are a point of the disc about `0` and a point of the disc about `1 + i`
  have hdiff : ∀ x y : ℂ, x ∈ ball (0 : ℂ) (1 / 10) → y ∈ ball (1 + I : ℂ) (1 / 10) → dist x y ≠ 1 := by
    intro x y hx hy h
    have h1 := dist_triangle4 (0 : ℂ) x y (1 + I)
    rw [mem_ball] at hx hy
    rw [dist_comm] at hx
    have h2 := tightModel_far
    rw [dist_comm] at h2
    linarith
  rintro x ((hx | hx) | hx) y ((hy | hy) | hy) hxy
  · exact absurd hxy (hsame _ _ _ hx hy)
  · rw [tightModel_eq_two_of_mem (Or.inl hx)]
    exact (tightModel_ne_two_of_mem hy).symm
  · exact absurd hxy (hdiff _ _ hx hy)
  · rw [tightModel_eq_two_of_mem (Or.inl hy)]
    exact tightModel_ne_two_of_mem hx
  · exact absurd hxy (hsame _ _ _ hx hy)
  · rw [tightModel_eq_two_of_mem (Or.inr hy)]
    exact tightModel_ne_two_of_mem hx
  · exact absurd (by rw [dist_comm]; exact hxy) (hdiff _ _ hy hx)
  · rw [tightModel_eq_two_of_mem (Or.inr hx)]
    exact (tightModel_ne_two_of_mem hy).symm
  · exact absurd hxy (hsame _ _ _ hx hy)
""")
rep("theorem isTight_tightModel", """  refine ⟨1 / 10, by simp, by decide, by norm_num, fun y hy => Or.inl (Or.inr hy),
    Filter.Eventually.of_forall fun w hwb hwq => ?_, Filter.Eventually.of_forall fun w hwb hwq => ?_⟩
  · have h1 : dist w 1 < 1 / 2 := lt_trans (mem_ball.mp hwb) (by norm_num)
    have h2 : ‖w‖ < 1 := by rwa [dist_zero_right] at hwq
    rw [tightModel, if_pos h1, if_pos h2]
  · have h1 : dist w 1 < 1 / 2 := lt_trans (mem_ball.mp hwb) (by norm_num)
    have h2 : ¬ ‖w‖ < 1 := by rw [dist_zero_right] at hwq; exact not_lt.mpr hwq.le
    rw [tightModel, if_pos h1, if_neg h2]
""")
rep("example : ∀ᵐ z, z ∈ tightModelDom ∩ unitShadow (ball (0 : ℂ) (1 / 10)) → tightModel z ≠ 2", """  exact (shadow_open isOpen_tightModelDom isWeakColouringOn_tightModel isOpen_ball
    (fun y hy => Or.inl (Or.inl hy)) (i := 2)
    (Filter.Eventually.of_forall fun z hz => tightModel_eq_two_of_mem (Or.inl hz))).2
""")
rep("example : ∃ η > 0, ∀ᵐ w, w ∈ ball (1 + I : ℂ) η → tightModel w ≠ 0 ∧ tightModel w ≠ 1", """  refine tight_straddle isOpen_tightModelDom isWeakColouringOn_tightModel isTight_tightModel (p := 1 + I)
    (Or.inr (mem_ball_self (by norm_num))) ?_ (fun h => ?_) (fun h => ?_)
  · rw [dist_eq_norm, add_sub_cancel_left, Complex.norm_I]
  · simpa using congrArg Complex.re h
  · simpa using congrArg Complex.im h
""")
rep("example : InnerAt (ball (0 : ℂ) (1 / 2)) 0 ∧ ¬ OuterAt (ball (0 : ℂ) (1 / 2)) 0 ∧", """  have hin : InnerAt (ball (0 : ℂ) (1 / 2)) 0 := (ball_subset_ball (by norm_num)).trans ball_subset_closedBall
  exact ⟨hin, not_outerAt_iff.mpr ⟨0, mem_ball_self (by norm_num), by simp⟩, fun h => h.1 hin⟩
""")
rep("example : CrossingAt (ball (1 : ℂ) (1 / 2)) 0", """  refine crossingAt_iff.mpr ⟨⟨3 / 4, ?_, ?_⟩, ⟨5 / 4, ?_, ?_⟩⟩
  · rw [mem_ball, dist_eq_norm, show (3 / 4 : ℂ) - 1 = -(1 / 4) by norm_num, norm_neg]; norm_num
  · rw [dist_zero_right]; norm_num
  · rw [mem_ball, dist_eq_norm, show (5 / 4 : ℂ) - 1 = 1 / 4 by norm_num]; norm_num
  · rw [dist_zero_right]; norm_num
""")
before("/-- The model's set is open. -/", '''/-- Off the disc of radius `1/2` about `1` the model's label is `2`. -/
theorem tightModel_of_not_lt {z : ℂ} (h : ¬ dist z 1 < 1 / 2) : tightModel z = 2 := by
  rw [tightModel, if_neg h]

/-- In the disc of radius `1/2` about `1` the model's label is `0` or `1`: not `2`. -/
theorem tightModel_ne_two_of_lt {z : ℂ} (h : dist z 1 < 1 / 2) : tightModel z ≠ 2 := by
  rw [tightModel, if_pos h]
  split_ifs <;> decide

/-- The centres `0` and `1 + i` of two of the model's discs are more than `6/5` apart. -/
theorem tightModel_far : 6 / 5 < dist (1 + I : ℂ) 0 := by
  have h2 : ‖(1 : ℂ) + I‖ ^ 2 = 2 := by
    rw [sq_norm_eq]
    simp
    norm_num
  rw [dist_zero_right]
  by_contra hle
  have h3 := norm_nonneg ((1 : ℂ) + I)
  nlinarith [not_lt.mp hle]

/-- On the discs about `0` and `1 + i` the model's label is `2`. -/
theorem tightModel_eq_two_of_mem {z : ℂ} (h : z ∈ ball (0 : ℂ) (1 / 10) ∪ ball (1 + I : ℂ) (1 / 10)) :
    tightModel z = 2 := by
  refine tightModel_of_not_lt (not_lt.mpr ?_)
  rcases h with h | h
  · have h1 := dist_triangle (0 : ℂ) z 1
    rw [mem_ball, dist_comm] at h
    rw [dist_zero_left, norm_one] at h1
    linarith
  · have h1 := dist_triangle (1 + I : ℂ) z 1
    have h2 : dist (1 + I : ℂ) 1 = 1 := by rw [dist_eq_norm, add_sub_cancel_left, Complex.norm_I]
    rw [mem_ball, dist_comm] at h
    linarith

/-- On the disc about `1` the model's label is not `2`. -/
theorem tightModel_ne_two_of_mem {z : ℂ} (h : z ∈ ball (1 : ℂ) (1 / 10)) : tightModel z ≠ 2 :=
  tightModel_ne_two_of_lt (lt_trans (mem_ball.mp h) (by norm_num))

''')
before("/-- **Adversary** for the definition of a tight pair:", """/-- The model, read through C124-TYPE (an example added by the implementer: the docstring of `piece_type` names this
inhabitant). The inner collar of the tight pair `(0, 1)` is a connected open subset of the model's set, of label `0`,
with `1` in its closure and the point `19/20` strictly inside the unit circle about `0`; so near `0` the label `0` is
almost nowhere outside the unit circle about `1`. -/
example : ∃ η > 0, ∀ᵐ z, z ∈ ball (0 : ℂ) η → 1 < dist z 1 → tightModel z ≠ 0 := by
  have hc0 : dist (19 / 20 : ℂ) 0 = 19 / 20 := by rw [dist_zero_right]; norm_num
  have hc1 : dist (19 / 20 : ℂ) 1 = 1 / 20 := by
    rw [dist_eq_norm, show (19 / 20 : ℂ) - 1 = -(1 / 20) by norm_num, norm_neg]; norm_num
  -- the disc tangent to the unit circle about `0` at `1`, inside the collar
  have hsub : ball (19 / 20 : ℂ) (1 / 20) ⊆ innerCollar 0 1 (1 / 10) := by
    intro y hy
    rw [mem_ball] at hy
    have h1 := dist_triangle y (19 / 20) 1
    have h0 := dist_triangle y (19 / 20) 0
    exact ⟨by rw [mem_ball]; linarith, by rw [mem_ball]; linarith⟩
  have hmem : (19 / 20 : ℂ) ∈ innerCollar 0 1 (1 / 10) := hsub (mem_ball_self (by norm_num))
  have hx : (1 : ℂ) ∈ closure (innerCollar 0 1 (1 / 10)) := by
    refine closure_mono hsub ?_
    rw [closure_ball _ (by norm_num), mem_closedBall, dist_comm, hc1]
  have hlabel : ∀ᵐ z, z ∈ innerCollar 0 1 (1 / 10) → tightModel z = 0 :=
    Filter.Eventually.of_forall fun z hz => by
      have h2 : ‖z‖ < 1 := by have := hz.2; rwa [mem_ball, dist_zero_right] at this
      rw [tightModel, if_pos (lt_trans (mem_ball.mp hz.1) (by norm_num)), if_pos h2]
  exact (piece_type isOpen_tightModelDom isWeakColouringOn_tightModel (isOpen_innerCollar 0 1 (1 / 10))
    ⟨⟨_, hmem⟩, ((convex_ball _ _).inter (convex_ball _ _)).isPreconnected⟩ (fun y hy => Or.inl (Or.inr hy.1))
    hlabel hx (Or.inl (Or.inl (mem_ball_self (by norm_num))))).1 ⟨19 / 20, hmem, by rw [hc0]; norm_num⟩

/-- The model, read through C124-CENTRE-HALF, both clauses (an example added by the implementer: the docstring of
`centre_half` names this inhabitant): `q = 0`, `z = 1`, `ρ = 1/10`, with `a = 0` for the inner collar and `a = 1` for
the outer one. -/
example : (∃ η > 0, ∀ᵐ p, p ∈ ball (0 : ℂ) η → 1 < dist p 1 → tightModel p ≠ 0) ∧
    ∃ η > 0, ∀ᵐ p, p ∈ ball (0 : ℂ) η → dist p 1 < 1 → tightModel p ≠ 1 := by
  have h := centre_half isOpen_tightModelDom isWeakColouringOn_tightModel (q := 0) (z := 1)
    (Or.inl (Or.inl (mem_ball_self (by norm_num)))) (by simp) (ρ := 1 / 10) (by norm_num)
    (fun y hy => Or.inl (Or.inr hy))
  refine ⟨(h 0).1 (Filter.Eventually.of_forall fun w hwb hwq => ?_),
    (h 1).2 (Filter.Eventually.of_forall fun w hwb hwq => ?_)⟩
  · have h2 : ‖w‖ < 1 := by rwa [dist_zero_right] at hwq
    rw [tightModel, if_pos (lt_trans (mem_ball.mp hwb) (by norm_num)), if_pos h2]
  · have h2 : ¬ ‖w‖ < 1 := by rw [dist_zero_right] at hwq; exact not_lt.mpr hwq.le
    rw [tightModel, if_pos (lt_trans (mem_ball.mp hwb) (by norm_num)), if_neg h2]

""")
pathlib.Path(dst).write_text(s)
print("written", dst, "sorry left:", s.count("sorry"))
