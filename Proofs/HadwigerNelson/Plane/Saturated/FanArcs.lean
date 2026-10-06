import Proofs.HadwigerNelson.Plane.Saturated.LocalGraph
import Proofs.HadwigerNelson.Plane.Saturated.ArcContinuation

/-!
# The essential boundary in a punctured disc with no singular point: its components (FS-131 wave 6, FS131-I6D)

The proofs of FS131-E8-GAMMA, -BETA, -ALPHA (`plans/FS131-E8-derivation.md` §§ 3.2–3.4), with the fields of
`AeColouring.IsolatedAt` (`Plane/Saturated/FanBridge`) as hypotheses; `gamma`, `beta`, `alpha` there are these:

* `AeColouring.hasArcChart`, `AeColouring.arcSetting_of_isolated` — FS131-E8-LOCAL's chart makes the essential
  boundary in the punctured disc a set that is locally one curve (`ArcSetting`).
* `AeColouring.exists_arc_of_isolated` — **FS131-E8-GAMMA**.
* `AeColouring.exists_polarGraph_of_isolated` — **FS131-E8-BETA**.
* `AeColouring.finite_components_of_isolated` — **FS131-E8-ALPHA**.

Inhabitant of the hypotheses `hR`, `hR2`, `hS`, `hsat` together: `sq9` at the grid vertex with `R = 1/4`
(`sq9_isolatedAt`, `Plane/Saturated/FanBridge`: `sq9_singular_near_vertex`, `sq9_tight_saturated`).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

/-- A point of a closed disc outside the punctured open disc is the centre or a point of the circle. -/
theorem eq_or_mem_sphere_of_notMem {z p : ℂ} {R : ℝ} (hcl : p ∈ closedBall z R) (hp : p ∉ ball z R \ {z}) :
    p = z ∨ p ∈ sphere z R := by
  by_cases hpz : p = z
  · exact Or.inl hpz
  · right
    rw [mem_sphere]
    rw [mem_closedBall] at hcl
    by_contra hne
    exact hp ⟨mem_ball.2 (lt_of_le_of_ne hcl hne), hpz⟩

/-- In a set that is locally one curve, each point has an open neighbourhood whose part of the set lies in the
point's component. -/
theorem ArcSetting.exists_open_subset_component {E U : Set ℂ} (S : ArcSetting E U) {q : ℂ} (hq : q ∈ E) :
    ∃ Q : Set ℂ, IsOpen Q ∧ q ∈ Q ∧ E ∩ Q ⊆ connectedComponentIn E q := by
  obtain ⟨Q, χ, ψχ, h, hQo, hqQ, hh0, hχ, hχ0, hEQ⟩ := S.chart q hq
  refine ⟨Q, hQo, hqQ, ?_⟩
  rw [hEQ]
  refine (isPreconnected_Ioo.image χ hχ.continuousOn).subset_connectedComponentIn
    ⟨0, ⟨by linarith, hh0⟩, hχ0⟩ ?_
  rw [← hEQ]
  exact inter_subset_left

namespace AeColouring

variable (c : AeColouring k)

/-- **FS131-E8-LOCAL's chart, for the family's essential boundary**: in an open set `U` with no singular point,
saturated, the essential boundary of the colouring is near each of its points one unit-speed curve of curvature at
most `1`. -/
theorem hasArcChart {U : Set ℂ} (hU : IsOpen U) (hS : Disjoint U c.singularSet) (hsat : SaturatedOn c.cls U)
    {y : ℂ} (hy : y ∈ c.essBdry ∩ U) : HasArcChart (c.essBdry ∩ U) y := by
  obtain ⟨ρ, a, b, Q, γ, ψ, h, hT, hQU, hC⟩ := c.local_graph hU hS hsat hy
  refine ⟨Q, γ, ψ, h, hC.isOpen, hC.mem, hC.pos, hC.curve, hC.zero, ?_⟩
  rw [← hC.bdry]
  ext x
  constructor
  · rintro ⟨⟨hxb, -⟩, hxQ⟩
    exact ⟨(hT.mem_essBoundary (fun j => c.measurableSet_cls j) (hC.subset hxQ) hxb).1, hxQ⟩
  · rintro ⟨hxa, hxQ⟩
    exact ⟨⟨mem_iUnion.2 ⟨a, hxa⟩, hQU hxQ⟩, hxQ⟩

variable {c} {z : ℂ} {R : ℝ}

/-- **The setting of FS131-E8 §§ 3.2–3.4 is an `ArcSetting`**: the essential boundary in a punctured disc of radius
at most `1/2` whose only possible singular point is the centre, saturated there. -/
theorem arcSetting_of_isolated (hR2 : R ≤ 1 / 2) (hS : c.singularSet ∩ ball z R ⊆ {z})
    (hsat : SaturatedOn c.cls (ball z R \ {z})) :
    ArcSetting (c.essBdry ∩ (ball z R \ {z})) (ball z R \ {z}) := by
  have hUo : IsOpen (ball z R \ {z}) := isOpen_ball.sdiff isClosed_singleton
  have hdisj : Disjoint (ball z R \ {z}) c.singularSet := by
    rw [Set.disjoint_left]
    rintro x ⟨hxb, hxz⟩ hxS
    exact hxz (hS ⟨hxS, hxb⟩)
  refine ⟨hUo, ?_, inter_subset_right, ?_, fun p hp => c.hasArcChart hUo hdisj hsat hp⟩
  · rintro p ⟨hp, -⟩ q ⟨hq, -⟩
    rw [mem_ball] at hp hq
    have := dist_triangle_right p q z
    linarith
  · rintro x ⟨hxcl, hxU⟩
    refine ⟨?_, hxU⟩
    rcases c.closure_essBdry_subset (closure_mono inter_subset_left hxcl) with hx | hx
    · exact hx
    · exact absurd (cuspSet_subset_singularSet _ hx) (Set.disjoint_left.1 hdisj hxU)

/-- **FS131-E8-GAMMA** (the proof of `AeColouring.gamma`): the component of the essential boundary in the punctured
disc through `y` is the image of `(0, L)` under an injective unit-speed curve of curvature at most `1` on `[0, L]`,
`0 < L ≤ π/2`, each end at the centre or on the circle. -/
theorem exists_arc_of_isolated (hR2 : R ≤ 1 / 2) (hS : c.singularSet ∩ ball z R ⊆ {z})
    (hsat : SaturatedOn c.cls (ball z R \ {z})) {y : ℂ} (hy : y ∈ c.essBdry ∩ (ball z R \ {z})) :
    ∃ (L : ℝ) (γ : ℝ → ℂ) (ψ : ℝ → ℝ), 0 < L ∧ L ≤ Real.pi / 2 ∧ IsUnitCurve γ ψ (Icc 0 L) ∧ InjOn γ (Icc 0 L) ∧
      connectedComponentIn (c.essBdry ∩ (ball z R \ {z})) y = γ '' Ioo 0 L ∧
      (γ 0 = z ∨ γ 0 ∈ sphere z R) ∧ (γ L = z ∨ γ L ∈ sphere z R) := by
  have S := arcSetting_of_isolated hR2 hS hsat
  obtain ⟨A, B, Γ, Ψ, hA, hB, hlen, hΓ, -, hK, hendA, hendB⟩ := S.exists_component_arc hy
  have hΓc : Continuous Γ := continuousOn_univ.1 hΓ.continuousOn
  have hAB : A < B := hA.trans hB
  have hcurve : IsUnitCurve (fun s => Γ (1 * s + A)) (fun s => Ψ (1 * s + A) + 0) (Icc 0 (B - A)) :=
    (hΓ.affine (Or.inl rfl) A 0 (by simp [e])).mono fun s _ => mem_univ _
  have himg : (fun s => Γ (1 * s + A)) '' Ioo 0 (B - A) = Γ '' Ioo A B := by
    ext p
    constructor
    · rintro ⟨s, hs, rfl⟩
      exact ⟨1 * s + A, ⟨by linarith [hs.1], by linarith [hs.2]⟩, rfl⟩
    · rintro ⟨t, ht, rfl⟩
      exact ⟨t - A, ⟨by linarith [ht.1], by linarith [ht.2]⟩, by simp⟩
  have hVsub : Γ '' Ioo A B ⊆ ball z R := by
    rw [← hK]
    exact (connectedComponentIn_subset _ _).trans fun x hx => hx.2.1
  have hcl : ∀ t ∈ Icc A B, Γ t ∈ closedBall z R := fun t ht => by
    have ht' : t ∈ closure (Ioo A B) := by rw [closure_Ioo hAB.ne]; exact ht
    exact closure_ball_subset_closedBall (closure_mono hVsub (mem_closure_image hΓc.continuousAt ht'))
  refine ⟨B - A, _, _, by linarith, hlen, hcurve, ?_, by rw [hK, himg], ?_, ?_⟩
  · refine hcurve.injOn_of_abs_le ordConnected_Icc fun s hs u hu => ?_
    have : |s - u| ≤ B - A := by rw [abs_le]; constructor <;> linarith [hs.1, hs.2, hu.1, hu.2]
    linarith
  · show Γ (1 * 0 + A) = z ∨ Γ (1 * 0 + A) ∈ sphere z R
    rw [show (1 : ℝ) * 0 + A = A by ring]
    exact eq_or_mem_sphere_of_notMem (hcl A (left_mem_Icc.2 hAB.le)) hendA
  · show Γ (1 * (B - A) + A) = z ∨ Γ (1 * (B - A) + A) ∈ sphere z R
    rw [show (1 : ℝ) * (B - A) + A = B by ring]
    exact eq_or_mem_sphere_of_notMem (hcl B (right_mem_Icc.2 hAB.le)) hendB

/-- A curve from the centre to the circle is a polar graph over `(0, R)`. -/
theorem polarGraph_of_curve_from_center {L : ℝ} {γ : ℝ → ℂ} {ψ : ℝ → ℝ} (hL : 0 < L) (hLπ : L ≤ Real.pi / 2)
    (hγ : IsUnitCurve γ ψ (Icc 0 L)) (hinj : InjOn γ (Icc 0 L)) (h0 : γ 0 = z)
    (hend : γ L = z ∨ γ L ∈ sphere z R) :
    ∃ (φ : ℝ → ℝ) (d : ℝ), ContinuousOn φ (Ioo 0 R) ∧ Tendsto φ (𝓝[>] 0) (𝓝 d) ∧
      γ '' Ioo 0 L = polarGraph z R φ := by
  have hne : γ L ≠ z := fun h => hL.ne (hinj ⟨le_rfl, hL.le⟩ ⟨hL.le, le_rfl⟩ (h0.trans h.symm))
  have hd : dist (γ L) (γ 0) = R := by
    rw [h0]; exact mem_sphere.1 (hend.resolve_left hne)
  obtain ⟨φ, hφc, hφt, hφg⟩ := hγ.exists_polar_angle hL hLπ
  rw [hd, h0] at hφg
  rw [hd] at hφc
  exact ⟨φ, ψ 0, hφc, hφt, hφg⟩

/-- **FS131-E8-BETA** (the proof of `AeColouring.beta`): a component with the centre in its closure is a polar graph
over `(0, R)` with a continuous angle that has a limit at `0`. -/
theorem exists_polarGraph_of_isolated (hR2 : R ≤ 1 / 2) (hS : c.singularSet ∩ ball z R ⊆ {z})
    (hsat : SaturatedOn c.cls (ball z R \ {z})) {y : ℂ} (hy : y ∈ c.essBdry ∩ (ball z R \ {z}))
    (hz : z ∈ closure (connectedComponentIn (c.essBdry ∩ (ball z R \ {z})) y)) :
    ∃ (φ : ℝ → ℝ) (d : ℝ), ContinuousOn φ (Ioo 0 R) ∧ Tendsto φ (𝓝[>] 0) (𝓝 d) ∧
      connectedComponentIn (c.essBdry ∩ (ball z R \ {z})) y = polarGraph z R φ := by
  obtain ⟨L, γ, ψ, hL, hLπ, hγ, hinj, hK, h0, hLend⟩ := exists_arc_of_isolated hR2 hS hsat hy
  have hzK : z ∉ connectedComponentIn (c.essBdry ∩ (ball z R \ {z})) y := fun h =>
    (connectedComponentIn_subset _ _ h).2.2 rfl
  rw [hK] at hz hzK ⊢
  have hclosed : IsClosed (γ '' Icc 0 L) := (isCompact_Icc.image_of_continuousOn hγ.continuousOn).isClosed
  obtain ⟨s, hs, hsz⟩ := closure_minimal (image_mono Ioo_subset_Icc_self) hclosed hz
  have hs' : s = 0 ∨ s = L := by
    by_contra hne
    rw [not_or] at hne
    exact hzK ⟨s, ⟨lt_of_le_of_ne hs.1 (Ne.symm hne.1), lt_of_le_of_ne hs.2 hne.2⟩, hsz⟩
  rcases hs' with rfl | rfl
  · exact polarGraph_of_curve_from_center hL hLπ hγ hinj hsz hLend
  · -- the curve run backward starts at the centre
    have hπ : e Real.pi = ((-1 : ℝ) : ℂ) := by rw [e_eq]; simp
    have hrev : IsUnitCurve (fun u => γ (-1 * u + s)) (fun u => ψ (-1 * u + s) + Real.pi) (Icc 0 s) :=
      (hγ.affine (Or.inr rfl) s Real.pi hπ).mono fun u hu => ⟨by linarith [hu.2], by linarith [hu.1]⟩
    have hinj' : InjOn (fun u => γ (-1 * u + s)) (Icc 0 s) := fun u hu v hv huv => by
      have := hinj (x₁ := -1 * u + s) (x₂ := -1 * v + s) ⟨by linarith [hu.2], by linarith [hu.1]⟩
        ⟨by linarith [hv.2], by linarith [hv.1]⟩ huv
      linarith
    have himg : (fun u => γ (-1 * u + s)) '' Ioo 0 s = γ '' Ioo 0 s := by
      ext p
      constructor
      · rintro ⟨u, hu, rfl⟩
        exact ⟨-1 * u + s, ⟨by linarith [hu.2], by linarith [hu.1]⟩, rfl⟩
      · rintro ⟨t, ht, rfl⟩
        exact ⟨s - t, ⟨by linarith [ht.2], by linarith [ht.1]⟩, by
          show γ (-1 * (s - t) + s) = γ t
          rw [show -1 * (s - t) + s = t by ring]⟩
    rw [← himg]
    refine polarGraph_of_curve_from_center hL hLπ hrev hinj' ?_ ?_
    · show γ (-1 * 0 + s) = z
      rw [show (-1 : ℝ) * 0 + s = s by ring]; exact hsz
    · show γ (-1 * s + s) = z ∨ γ (-1 * s + s) ∈ sphere z R
      rw [show (-1 : ℝ) * s + s = 0 by ring]; exact h0

/-- **FS131-E8-ALPHA** (the proof of `AeColouring.alpha`): finitely many components of the essential boundary in the
punctured disc meet the closed disc of radius `R/2`, and in a smaller disc every essential boundary point other than
the centre lies on a component with the centre in its closure. -/
theorem finite_components_of_isolated (hR : 0 < R) (hR2 : R ≤ 1 / 2) (hS : c.singularSet ∩ ball z R ⊆ {z})
    (hsat : SaturatedOn c.cls (ball z R \ {z})) :
    {K : Set ℂ | ∃ y ∈ c.essBdry ∩ (ball z R \ {z}),
        K = connectedComponentIn (c.essBdry ∩ (ball z R \ {z})) y ∧ (K ∩ closedBall z (R / 2)).Nonempty}.Finite ∧
      ∃ r, 0 < r ∧ r ≤ R / 2 ∧ ∀ w ∈ c.essBdry ∩ (ball z r \ {z}),
        z ∈ closure (connectedComponentIn (c.essBdry ∩ (ball z R \ {z})) w) := by
  have S := arcSetting_of_isolated hR2 hS hsat
  set E : Set ℂ := c.essBdry ∩ (ball z R \ {z}) with hE
  -- (a) a component that meets the closed half disc meets the circle of radius `R/2`
  have hcross : ∀ y ∈ E, (connectedComponentIn E y ∩ closedBall z (R / 2)).Nonempty →
      ∃ q ∈ connectedComponentIn E y, q ∈ sphere z (R / 2) := by
    rintro y hy ⟨p, hpK, hpb⟩
    obtain ⟨L, γ, ψ, hL, hLπ, hγ, hinj, hK, h0, hLend⟩ := exists_arc_of_isolated hR2 hS hsat hy
    rw [hK] at hpK ⊢
    obtain ⟨s₁, hs₁, rfl⟩ := hpK
    rw [mem_closedBall] at hpb
    have hfc : ContinuousOn (fun s => dist (γ s) z) (Icc 0 L) :=
      continuous_dist.comp_continuousOn (hγ.continuousOn.prodMk continuousOn_const)
    have hne : γ 0 ≠ γ L := fun h => hL.ne (hinj ⟨le_rfl, hL.le⟩ ⟨hL.le, le_rfl⟩ h)
    have hend : γ L ∈ sphere z R ∨ γ 0 ∈ sphere z R := by
      rcases hLend with h1 | h1
      · rcases h0 with h2 | h2
        · exact absurd (h2.trans h1.symm) hne
        · exact Or.inr h2
      · exact Or.inl h1
    rcases hend with h1 | h1
    · rw [mem_sphere] at h1
      obtain ⟨s, hs, hsv⟩ := intermediate_value_Icc hs₁.2.le (hfc.mono (Icc_subset_Icc hs₁.1.le le_rfl))
        (show R / 2 ∈ Icc (dist (γ s₁) z) (dist (γ L) z) from ⟨hpb, by rw [h1]; linarith⟩)
      have hsv : dist (γ s) z = R / 2 := hsv
      have hsL : s ≠ L := fun h => by rw [h, h1] at hsv; linarith
      exact ⟨γ s, ⟨s, ⟨hs₁.1.trans_le hs.1, lt_of_le_of_ne hs.2 hsL⟩, rfl⟩, mem_sphere.2 hsv⟩
    · rw [mem_sphere] at h1
      obtain ⟨s, hs, hsv⟩ := intermediate_value_Icc' hs₁.1.le (hfc.mono (Icc_subset_Icc le_rfl hs₁.2.le))
        (show R / 2 ∈ Icc (dist (γ s₁) z) (dist (γ 0) z) from ⟨hpb, by rw [h1]; linarith⟩)
      have hsv : dist (γ s) z = R / 2 := hsv
      have hs0 : s ≠ 0 := fun h => by rw [h, h1] at hsv; linarith
      exact ⟨γ s, ⟨s, ⟨lt_of_le_of_ne hs.1 (Ne.symm hs0), hs.2.trans_lt hs₁.2⟩, rfl⟩, mem_sphere.2 hsv⟩
  -- (b) the essential boundary on that circle is compact
  have hsphU : sphere z (R / 2) ⊆ ball z R \ {z} := fun x hx => by
    rw [mem_sphere] at hx
    refine ⟨mem_ball.2 (by linarith), fun h => ?_⟩
    rw [mem_singleton_iff.1 h, dist_self] at hx
    linarith
  have hCclosed : IsClosed (E ∩ sphere z (R / 2)) := by
    refine isClosed_of_closure_subset fun x hx => ?_
    have hxs : x ∈ sphere z (R / 2) := closure_minimal inter_subset_right isClosed_sphere hx
    exact ⟨S.closed ⟨closure_mono inter_subset_left hx, hsphU hxs⟩, hxs⟩
  have hCcompact : IsCompact (E ∩ sphere z (R / 2)) :=
    Metric.isCompact_of_isClosed_isBounded hCclosed (isBounded_sphere.subset inter_subset_right)
  -- (c), (d) finitely many charts cover it, each in one component
  have hloc : ∀ q ∈ E, ∃ Q : Set ℂ, IsOpen Q ∧ q ∈ Q ∧ E ∩ Q ⊆ connectedComponentIn E q := fun q hq =>
    S.exists_open_subset_component hq
  choose! Q hQo hQmem hQsub using hloc
  obtain ⟨t, htC, htcover⟩ := hCcompact.elim_nhds_subcover Q fun q hq => (hQo q hq.1).mem_nhds (hQmem q hq.1)
  have hfam : ∀ y ∈ E, (connectedComponentIn E y ∩ closedBall z (R / 2)).Nonempty →
      ∃ x ∈ t, connectedComponentIn E y = connectedComponentIn E x := by
    intro y hy hmeet
    obtain ⟨q, hqK, hqs⟩ := hcross y hy hmeet
    have hqE : q ∈ E := connectedComponentIn_subset _ _ hqK
    obtain ⟨x, hxt, hqx⟩ := mem_iUnion₂.1 (htcover ⟨hqE, hqs⟩)
    have h1 := hQsub x (htC x hxt).1 ⟨hqE, hqx⟩
    exact ⟨x, hxt, (connectedComponentIn_eq hqK).trans (connectedComponentIn_eq h1).symm⟩
  have hfin : {K : Set ℂ | ∃ y ∈ E, K = connectedComponentIn E y ∧ (K ∩ closedBall z (R / 2)).Nonempty}.Finite := by
    refine (t.finite_toSet.image fun x => connectedComponentIn E x).subset ?_
    rintro K ⟨y, hy, rfl, hmeet⟩
    obtain ⟨x, hxt, hyx⟩ := hfam y hy hmeet
    exact ⟨x, hxt, hyx.symm⟩
  refine ⟨hfin, ?_⟩
  -- (e) the components that miss the centre stay away from it
  set T : Set ℂ := ⋃ x ∈ {x ∈ (t : Set ℂ) | z ∉ closure (connectedComponentIn E x)},
    closure (connectedComponentIn E x) with hT
  have hTclosed : IsClosed T :=
    (t.finite_toSet.subset fun x hx => hx.1).isClosed_biUnion fun x _ => isClosed_closure
  have hzT : z ∉ T := fun h => by
    obtain ⟨x, hx, hzx⟩ := mem_iUnion₂.1 h
    exact hx.2 hzx
  obtain ⟨ε, hε, hεT⟩ := Metric.isOpen_iff.1 hTclosed.isOpen_compl z hzT
  refine ⟨min ε (R / 2), lt_min hε (by linarith), min_le_right _ _, ?_⟩
  rintro w ⟨hwb, hwball, hwz⟩
  rw [mem_ball] at hwball
  have hwR : dist w z < R / 2 := lt_of_lt_of_le hwball (min_le_right _ _)
  have hwE : w ∈ E := ⟨hwb, mem_ball.2 (by linarith), hwz⟩
  have hwK : w ∈ connectedComponentIn E w := mem_connectedComponentIn hwE
  obtain ⟨x, hxt, hwx⟩ := hfam w hwE ⟨w, hwK, mem_closedBall.2 hwR.le⟩
  by_contra hzw
  rw [hwx] at hzw hwK
  exact hεT (mem_ball.2 (lt_of_lt_of_le hwball (min_le_left _ _)))
    (mem_iUnion₂.2 ⟨x, ⟨hxt, hzw⟩, subset_closure hwK⟩)

end AeColouring

end HadwigerNelson.Plane
