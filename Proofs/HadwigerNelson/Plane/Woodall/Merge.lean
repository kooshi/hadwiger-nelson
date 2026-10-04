import Proofs.HadwigerNelson.Plane.Woodall.NoFourFive

/-!
# Woodall's step 3, localized: finitely many merges on a ball (FS131-E3's E3-W, E3-NICE, E3-BALL)

FS131-W3's skeleton (`plans/FS131-W-kernel-plan.md` § 14) for `exists_woodallMerged`, the modification Woodall's chain reads
(`plans/FS131-E3-derivation.md` §§ 3.2–3.4): every valid arc map of the plane has a valid arc map of the plane, Condition 5 kept, in which
every point of `closedBall 0 R` of three or more colours is `NiceAt`.

* **Recolouring** (`ArcMap.recolour`): a set `W` whose frontier lies on finitely many new arcs is given one colour; nothing else moves. Its
  validity is a statement about `W` alone (`recolour_valid`), its Condition 5 one about the new arcs (`recolour_condition5`), and off
  `closure W` and the new arcs the regions are unchanged (`recolour_region_diff`).
* **E3-W** (`clear_wedge`): two open ray segments in the closure of an open set `S` with null unit pairs, less than `π` apart, clear the wedge
  between them of `S`'s unit distance up to radius `r₁ cos(α/2)/2` (the sagitta). E3's hypothesis "`ω(v)` misses `S`" is not needed: the
  segments put `v` in `closure S`, and wave 1's `dist_ne_one_of_mem_of_mem_closure` gives it.
* **The merge at a wedge** (`wedgeMerge`, `wedgeMerge_valid`, `wedgeMerge_condition5`, `wedgeMerge_region_diff`): the recolouring of the open
  annular sector `annSector v 0 ρ d₁ d₂` with `c`, bounded by two segments and an arc of radius `ρ`.
* **Locality** (`coloursAt_congr`, `niceAt_congr`): the colours at a point and `NiceAt` depend only on the regions near it.
* **The local data at a point** (`DirColourAt`): finitely many exceptional directions, off which a thin open cone lies in one colour class.
  Wave 3's wedge lemma (`GoodAt.exists_wedge`) gives it at every point of the domain (`exists_dirColourAt`); the `NiceAt` picture is built from
  it (`niceAt_of_dirColourAt`); in a good ball only the centre carries three colours (`GoodAt.ncard_coloursAt_le_two`), so three-colour points
  are finite on compact sets (`finite_three_le_coloursAt`).
* **E3-NICE** (`exists_merge_at`): merging at one point until it, and every new point of three colours near it, is `NiceAt` — the local data
  updated by each merge (`dirColourAt_wedgeMerge`), the crossings `NiceAt` (`wedgeMerge_niceAt`).
* **E3-BALL** (`exists_woodallMerged`): finitely many such merges on `closedBall 0 R`.

No statement here reads `localSectors` (FS131-I3i): wave 3's landed `GoodAt` engine gives every local fact the merge needs (§ 14.3).

**Inhabitants.** `recolour`, `wedgeMerge` and `DirColourAt` are defined for any arc map; the theorems over a valid map of the plane with any
number of colours are inhabited by `sevenBrickMap` (`sevenBrickMap_valid`, `sevenBrickMap_isPlaneMap`, `Plane/SVMap`); `DirColourAt` has its spec
example on the one-colour plane below; `clear_wedge` is region-only (any open set with null unit pairs and two such segments: E3's model, a
two-sector colour class of diameter below `1`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- `φ` is off the finitely many directions `D`, mod `2π`. -/
def OffDirs (D : Finset ℝ) (φ : ℝ) : Prop := ∀ δ ∈ D, ∀ m : ℤ, φ ≠ δ + 2 * π * m

/-- **E3-W, Woodall's criterion with a radius** (`plans/FS131-E3-derivation.md` § 3.2; `[Woodall1973]` p. 197, step 3, asserts it without a
radius: "each unit circle through Q, except for those through P, passes through X or Y"): if the open segments from `v` in the directions
`d₁ < d₂ < d₁ + π`, of length `r₁ < cos(α/2)/2` (`α = d₂ − d₁`), lie in the closure of an open set `S` with null unit pairs, then no point of the
open wedge between them within `r₁ cos(α/2)/2` of `v` is at distance `1` from a point of `S`. -/
theorem clear_wedge {S : Set ℂ} (hS : IsOpen S) (hnull : UnitPairsNull S) {v : ℂ} {d₁ d₂ r₁ : ℝ} (hd : d₁ < d₂)
    (hπ : d₂ - d₁ < π) (hr₁ : 0 < r₁) (hr₁c : r₁ < Real.cos ((d₂ - d₁) / 2) / 2)
    (hseg : ∀ s ∈ Ioo 0 r₁, v + (s : ℂ) * e d₁ ∈ closure S ∧ v + (s : ℂ) * e d₂ ∈ closure S) :
    ∀ z ∈ annSector v 0 (r₁ * Real.cos ((d₂ - d₁) / 2) / 2) d₁ d₂, ∀ y ∈ S, dist z y ≠ 1 := by
  sorry

/-- A point at radius `s ≥ 0` along a direction lies at distance `s`. -/
theorem norm_real_mul_e {s : ℝ} (hs : 0 ≤ s) (θ : ℝ) : ‖(s : ℂ) * e θ‖ = s := by
  rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg hs]

/-- An annular sector of non-negative inner radius lies in the ball of its outer radius. -/
theorem annSector_subset_ball (u : ℂ) {r₁ : ℝ} (hr : 0 ≤ r₁) (r₂ θ₁ θ₂ : ℝ) : annSector u r₁ r₂ θ₁ θ₂ ⊆ ball u r₂ := by
  rintro _ ⟨⟨s, θ⟩, ⟨hs, -⟩, rfl⟩
  rw [mem_ball, dist_eq_norm, add_sub_cancel_left, norm_real_mul_e (hr.trans hs.1.le)]
  exact hs.2

/-- Annular sectors grow with the outer radius. -/
theorem annSector_mono_r₂ (u : ℂ) {r₁ r₂ r₂' θ₁ θ₂ : ℝ} (h : r₂ ≤ r₂') : annSector u r₁ r₂ θ₁ θ₂ ⊆ annSector u r₁ r₂' θ₁ θ₂ := by
  rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
  exact ⟨(s, θ), ⟨⟨hs.1, hs.2.trans_le h⟩, hθ⟩, rfl⟩

/-- A point `u + s e(d)`, `0 ≤ s ≤ ρ`, lies on the segment from `u` to `u + ρ e(d)`. -/
theorem mem_segment_ray {u : ℂ} {ρ s : ℝ} (hρ : 0 < ρ) (hs0 : 0 ≤ s) (hsρ : s ≤ ρ) (d : ℝ) :
    u + (s : ℂ) * e d ∈ segment ℝ u (u + (ρ : ℂ) * e d) := by
  refine ⟨1 - s / ρ, s / ρ, by rw [sub_nonneg, div_le_one hρ]; exact hsρ, div_nonneg hs0 hρ.le, by ring, ?_⟩
  simp only [Complex.real_smul]
  have : (ρ : ℂ) ≠ 0 := by exact_mod_cast hρ.ne'
  push_cast
  field_simp
  ring

/-- The closure of an annular sector lies in the image of its closed radii and closed angles (a compact set). -/
theorem closure_annSector_subset (u : ℂ) {r₁ r₂ θ₁ θ₂ : ℝ} (hr : r₁ ≤ r₂) (hθ : θ₁ ≤ θ₂) :
    closure (annSector u r₁ r₂ θ₁ θ₂) ⊆ (fun q : ℝ × ℝ => u + (q.1 : ℂ) * e q.2) '' (Icc r₁ r₂ ×ˢ Icc θ₁ θ₂) := by
  have _ := hr
  have _ := hθ
  have hf : Continuous fun q : ℝ × ℝ => u + (q.1 : ℂ) * e q.2 := by have := continuous_e; fun_prop
  refine closure_minimal ?_ ((isCompact_Icc.prod isCompact_Icc).image hf).isClosed
  rintro _ ⟨q, ⟨h1, h2⟩, rfl⟩
  exact ⟨q, ⟨Ioo_subset_Icc_self h1, Ioo_subset_Icc_self h2⟩, rfl⟩

/-- The boundary of the open annular sector `annSector v 0 ρ d₁ d₂`: its two edges and its outer arc. -/
noncomputable def wedgeArcs (v : ℂ) (ρ d₁ d₂ : ℝ) : Set Arc :=
  {Arc.seg v (v + (ρ : ℂ) * e d₁), Arc.seg v (v + (ρ : ℂ) * e d₂), Arc.circ v ρ d₁ d₂}

/-- The wedge's arcs have positive length. -/
theorem wedgeArcs_nondegenerate {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π) :
    ∀ a ∈ wedgeArcs v ρ d₁ d₂, a.Nondegenerate := by
  have hseg : ∀ d : ℝ, v ≠ v + (ρ : ℂ) * e d := fun d h => by
    have : (ρ : ℂ) * e d = 0 := by linear_combination -h
    rcases mul_eq_zero.mp this with h1 | h1
    · exact hρ.ne' (by exact_mod_cast h1)
    · exact e_ne_zero _ h1
  intro a ha
  simp only [wedgeArcs, mem_insert_iff, mem_singleton_iff] at ha
  rcases ha with rfl | rfl | rfl
  · exact hseg d₁
  · exact hseg d₂
  · exact ⟨hρ, hd, hd2⟩

/-- The frontier of the open annular sector lies on its two edges and its outer arc. -/
theorem frontier_annSector_subset {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π) :
    frontier (annSector v 0 ρ d₁ d₂) ⊆ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier := by
  have _ := hd2
  intro z hz
  rw [(isOpen_annSector v le_rfl ρ d₁ d₂).frontier_eq] at hz
  obtain ⟨hzc, hzW⟩ := hz
  obtain ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩ := closure_annSector_subset v hρ.le hd.le hzc
  simp only at hs hθ hzW ⊢
  by_cases h0 : s = 0
  · subst h0
    refine mem_iUnion₂.mpr ⟨_, Or.inl rfl, ?_⟩
    simp only [Complex.ofReal_zero, zero_mul, add_zero]
    exact left_mem_segment ℝ _ _
  by_cases hρs : s = ρ
  · subst hρs
    exact mem_iUnion₂.mpr ⟨_, Or.inr (Or.inr rfl), ⟨θ, hθ, rfl⟩⟩
  by_cases h1 : θ = d₁
  · subst h1
    exact mem_iUnion₂.mpr ⟨_, Or.inl rfl, mem_segment_ray hρ hs.1 hs.2 _⟩
  by_cases h2 : θ = d₂
  · subst h2
    exact mem_iUnion₂.mpr ⟨_, Or.inr (Or.inl rfl), mem_segment_ray hρ hs.1 hs.2 _⟩
  exact absurd ⟨(s, θ), ⟨⟨lt_of_le_of_ne hs.1 (Ne.symm h0), lt_of_le_of_ne hs.2 hρs⟩,
    ⟨lt_of_le_of_ne hθ.1 (Ne.symm h1), lt_of_le_of_ne hθ.2 h2⟩⟩, rfl⟩ hzW

namespace ArcMap

variable {k : ℕ}

/-! ## Recolouring a set bounded by new arcs -/

/-- **Recolouring** `W` with the colour `c`: the arcs of `F` and the finitely many arcs `B`, which carry the frontier of `W`; the colour `c` on
`W` and `F`'s colour elsewhere. The colour is locally constant off the arcs because a point off `frontier W` lies in the interior of `W` or of
its complement. -/
noncomputable def recolour (F : ArcMap k) (W : Set ℂ) (B : Set Arc) (hB : ∀ a ∈ B, a.Nondegenerate) (hBf : B.Finite)
    (hW : frontier W ⊆ ⋃ a ∈ B, a.carrier) (c : Fin k) : ArcMap k where
  dom := F.dom
  isOpen_dom := F.isOpen_dom
  arcs := F.arcs ∪ B
  nondegenerate := fun a ha => ha.elim (F.nondegenerate a) (hB a)
  locallyFinite := fun x hx => by
    obtain ⟨t, ht, hfin⟩ := F.locallyFinite x hx
    refine ⟨t, ht, (hfin.union hBf).subset ?_⟩
    rintro a ⟨ha | ha, hne⟩
    · exact Or.inl ⟨ha, hne⟩
    · exact Or.inr ha
  col := by classical exact fun z => if z ∈ W then c else F.col z
  locallyConstant := by
    classical
    intro x hx hxΓ
    have hxF : x ∉ ⋃ a ∈ F.arcs, a.carrier := fun h => hxΓ (by
      obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp h
      exact mem_iUnion₂.mpr ⟨a, Or.inl ha, hxa⟩)
    have hxW : x ∉ frontier W := fun h => hxΓ (by
      obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp (hW h)
      exact mem_iUnion₂.mpr ⟨a, Or.inr ha, hxa⟩)
    by_cases hx' : x ∈ W
    · have hint : x ∈ interior W := by
        by_contra hni
        exact hxW ⟨subset_closure hx', hni⟩
      filter_upwards [mem_interior_iff_mem_nhds.mp hint] with y hy
      simp [hy, hx']
    · have hcl : x ∉ closure W := fun h => hxW ⟨h, fun hi => hx' (interior_subset hi)⟩
      filter_upwards [isClosed_closure.isOpen_compl.mem_nhds hcl, F.locallyConstant x hx hxF] with y hy hyc
      have hyW : y ∉ W := fun h => hy (subset_closure h)
      simp [hyW, hx', hyc]

variable {F : ArcMap k} {W : Set ℂ} {B : Set Arc} {hB : ∀ a ∈ B, a.Nondegenerate} {hBf : B.Finite}
  {hW : frontier W ⊆ ⋃ a ∈ B, a.carrier} {c : Fin k}

/-- Recolouring keeps the domain, so a map of the plane stays one. -/
theorem recolour_isPlaneMap (hP : F.IsPlaneMap) : (F.recolour W B hB hBf hW c).IsPlaneMap := hP

/-- The interior points of the recoloured map are interior points of `F` (the arcs only grow). -/
theorem interiorPts_recolour_subset : (F.recolour W B hB hBf hW c).interiorPts ⊆ F.interiorPts := by
  rintro x ⟨hx, hxΓ⟩
  exact ⟨hx, fun h => hxΓ (by
    obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp h
    exact mem_iUnion₂.mpr ⟨a, Or.inl ha, hxa⟩)⟩

/-- **Validity of a recolouring** is a statement about `W`: no unit pair inside `W`, and none between `W` and `F`'s class of `c`. -/
theorem recolour_valid (hF : F.Valid) (hWW : ∀ x ∈ W, ∀ y ∈ W, dist x y ≠ 1)
    (hWc : ∀ x ∈ W, ∀ y ∈ F.region c, dist x y ≠ 1) : (F.recolour W B hB hBf hW c).Valid := by
  classical
  intro x hx y hy hxy
  have hx' := interiorPts_recolour_subset hx
  have hy' := interiorPts_recolour_subset hy
  change (if x ∈ W then c else F.col x) ≠ (if y ∈ W then c else F.col y)
  split_ifs with h1 h2 h2
  · exact absurd hxy (hWW x h1 y h2)
  · intro hc
    exact hWc x h1 y ⟨hy', hc.symm⟩ hxy
  · intro hc
    exact hWc y h2 x ⟨hx', hc⟩ (by rw [dist_comm]; exact hxy)
  · exact hF x hx' y hy' hxy

/-- **Condition 5 is kept** when no new arc meets a unit circle in infinitely many points. -/
theorem recolour_condition5 (h5 : F.Condition5) (hB5 : ∀ a ∈ B, ∀ p, (a.carrier ∩ sphere p 1).Finite) :
    (F.recolour W B hB hBf hW c).Condition5 := by
  rintro a (ha | ha) p
  · exact h5 a ha p
  · exact (hB5 a ha p).subset fun z hz => ⟨hz.1.1, hz.2⟩

/-- **Off `closure W` and the new arcs, the regions are unchanged.** -/
theorem recolour_region_diff (j : Fin k) :
    (F.recolour W B hB hBf hW c).region j \ (closure W ∪ ⋃ a ∈ B, a.carrier) =
      F.region j \ (closure W ∪ ⋃ a ∈ B, a.carrier) := by
  classical
  ext z
  simp only [Set.mem_sdiff, mem_union, not_or]
  constructor
  · rintro ⟨⟨⟨hzd, hzΓ⟩, hcol⟩, hcl, hB'⟩
    have hzW : z ∉ W := fun h => hcl (subset_closure h)
    refine ⟨⟨⟨hzd, fun h => hzΓ ?_⟩, ?_⟩, hcl, hB'⟩
    · obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
      exact mem_iUnion₂.mpr ⟨a, Or.inl ha, hza⟩
    · have : (if z ∈ W then c else F.col z) = j := hcol
      rw [if_neg hzW] at this
      exact this
  · rintro ⟨⟨⟨hzd, hzΓ⟩, hcol⟩, hcl, hB'⟩
    have hzW : z ∉ W := fun h => hcl (subset_closure h)
    refine ⟨⟨⟨hzd, fun h => ?_⟩, ?_⟩, hcl, hB'⟩
    · obtain ⟨a, ha | ha, hza⟩ := mem_iUnion₂.mp h
      · exact hzΓ (mem_iUnion₂.mpr ⟨a, ha, hza⟩)
      · exact hB' (mem_iUnion₂.mpr ⟨a, ha, hza⟩)
    · show (if z ∈ W then c else F.col z) = j
      rw [if_neg hzW]
      exact hcol

/-! ## The merge at a wedge -/

/-- **The merge at a wedge** (E3-NICE's single merge): `F` recoloured with `c` on the open annular sector of radius `ρ` between the directions
`d₁ < d₂ ≤ d₁ + 2π`, its two edges and its outer arc added to the arcs. -/
noncomputable def wedgeMerge (F : ArcMap k) (v : ℂ) {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π)
    (c : Fin k) : ArcMap k :=
  F.recolour (annSector v 0 ρ d₁ d₂) (wedgeArcs v ρ d₁ d₂) (wedgeArcs_nondegenerate hρ hd hd2)
    (((finite_singleton _).insert _).insert _) (frontier_annSector_subset hρ hd hd2) c

/-- **The merge at a wedge is valid** (E3-W): the two edges in the closure of `F`'s class of `c`, less than `π` apart, and the radius within
E3-W's bound. -/
theorem wedgeMerge_valid (hF : F.Valid) {v : ℂ} {ρ d₁ d₂ r₁ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hπ : d₂ - d₁ < π) (hr₁ : 0 < r₁)
    (hr₁c : r₁ < Real.cos ((d₂ - d₁) / 2) / 2) (hρr : ρ ≤ r₁ * Real.cos ((d₂ - d₁) / 2) / 2)
    (hseg : ∀ s ∈ Ioo 0 r₁, v + (s : ℂ) * e d₁ ∈ closure (F.region c) ∧ v + (s : ℂ) * e d₂ ∈ closure (F.region c)) :
    (F.wedgeMerge v hρ hd (by linarith [Real.pi_pos]) c).Valid := by
  have hcos : Real.cos ((d₂ - d₁) / 2) ≤ 1 := Real.cos_le_one _
  have hcos0 : 0 < Real.cos ((d₂ - d₁) / 2) := Real.cos_pos_of_mem_Ioo ⟨by linarith [Real.pi_pos], by linarith⟩
  have hρ4 : ρ < 1 / 4 := by nlinarith
  refine recolour_valid hF (fun x hx y hy hxy => ?_) (fun x hx y hy => ?_)
  · have h1 := annSector_subset_ball v le_rfl ρ d₁ d₂ hx
    have h2 := annSector_subset_ball v le_rfl ρ d₁ d₂ hy
    rw [mem_ball] at h1 h2
    have := dist_triangle_right x y v
    linarith
  · exact clear_wedge (F.isOpen_region c) (hF.unitPairsNull_region c) hd hπ hr₁ hr₁c hseg x
      (annSector_mono_r₂ v hρr hx) y hy

/-- **The merge at a wedge keeps Condition 5**: its new arcs are two segments and an arc of radius `ρ < 1`. -/
theorem wedgeMerge_condition5 (h5 : F.Condition5) {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hρ1 : ρ < 1) (hd : d₁ < d₂)
    (hd2 : d₂ ≤ d₁ + 2 * π) : (F.wedgeMerge v hρ hd hd2 c).Condition5 := by
  refine recolour_condition5 h5 fun a ha p => ?_
  rcases Arc.finite_inter_sphere_or_eq_circ a (wedgeArcs_nondegenerate hρ hd hd2 a ha) p with h | ⟨θ₀, θ₁, rfl⟩
  · exact h
  · exfalso
    simp only [wedgeArcs, mem_insert_iff, mem_singleton_iff] at ha
    rcases ha with h | h | h
    · exact Arc.noConfusion h
    · exact Arc.noConfusion h
    · injection h with _ h1
      linarith

/-- **The merge at a wedge changes nothing off `closedBall v ρ`.** -/
theorem wedgeMerge_region_diff {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π) (j : Fin k) :
    (F.wedgeMerge v hρ hd hd2 c).region j \ closedBall v ρ = F.region j \ closedBall v ρ := by
  have hX : closure (annSector v 0 ρ d₁ d₂) ∪ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier ⊆ closedBall v ρ := by
    refine union_subset (closure_minimal ((annSector_subset_ball v le_rfl ρ d₁ d₂).trans ball_subset_closedBall)
      isClosed_closedBall) (iUnion₂_subset fun a ha => ?_)
    have hend : ∀ d : ℝ, v + (ρ : ℂ) * e d ∈ closedBall v ρ := fun d => by
      rw [mem_closedBall, dist_eq_norm, add_sub_cancel_left, norm_real_mul_e hρ.le]
    simp only [wedgeArcs, mem_insert_iff, mem_singleton_iff] at ha
    rcases ha with rfl | rfl | rfl
    · exact (convex_closedBall v ρ).segment_subset (mem_closedBall_self hρ.le) (hend d₁)
    · exact (convex_closedBall v ρ).segment_subset (mem_closedBall_self hρ.le) (hend d₂)
    · rintro _ ⟨θ, -, rfl⟩; exact hend θ
  have key := recolour_region_diff (F := F) (W := annSector v 0 ρ d₁ d₂) (B := wedgeArcs v ρ d₁ d₂)
    (hB := wedgeArcs_nondegenerate hρ hd hd2) (hBf := ((finite_singleton _).insert _).insert _)
    (hW := frontier_annSector_subset hρ hd hd2) (c := c) j
  have e1 : ∀ A : Set ℂ, A \ closedBall v ρ =
      (A \ (closure (annSector v 0 ρ d₁ d₂) ∪ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier)) \ closedBall v ρ := fun A => by
    ext z
    simp only [Set.mem_sdiff]
    exact ⟨fun h => ⟨⟨h.1, fun h' => h.2 (hX h')⟩, h.2⟩, fun h => ⟨h.1.1, h.2⟩⟩
  rw [e1, e1 (F.region j)]
  exact congrArg (· \ closedBall v ρ) key

/-! ## Locality -/

/-- **The colours at a point depend only on the regions near it.** -/
theorem coloursAt_congr {F F' : ArcMap k} {w : ℂ} {U : Set ℂ} (hU : U ∈ 𝓝 w)
    (h : ∀ j, F.region j ∩ U = F'.region j ∩ U) : F.coloursAt w = F'.coloursAt w := by
  have key : ∀ S : Set ℂ, w ∈ closure S ↔ w ∈ closure (S ∩ U) := fun S => by
    refine ⟨fun hS => ?_, fun hS => closure_mono inter_subset_left hS⟩
    rw [mem_closure_iff_nhds] at hS ⊢
    intro t ht
    obtain ⟨y, hy1, hy2⟩ := hS (t ∩ U) (inter_mem ht hU)
    exact ⟨y, hy1.1, hy2, hy1.2⟩
  ext j
  simp only [coloursAt, mem_setOf_eq]
  rw [key, h j, ← key]

/-- **`NiceAt` depends only on the regions near the point** (and on its being in the domain): pictures read cones, and cones are local. -/
theorem niceAt_congr {F F' : ArcMap k} {w : ℂ} {U : Set ℂ} (hU : U ∈ 𝓝 w) (hdom : w ∈ F.dom ↔ w ∈ F'.dom)
    (h : ∀ j, F.region j ∩ U = F'.region j ∩ U) : F.NiceAt w ↔ F'.NiceAt w := by
  obtain ⟨r, hr, hrU⟩ := Metric.mem_nhds_iff.mp hU
  have key : ∀ S : Set ℂ, coneAt S w = coneAt (S ∩ U) w := fun S =>
    Subset.antisymm (fun β hβ => coneAt_mono (inter_subset_inter_right S hrU) w (coneAt_inter_ball hr hβ))
      (coneAt_mono inter_subset_left w)
  have hcone : ∀ j, coneAt (F.region j) w = coneAt (F'.region j) w := fun j => by rw [key, h j, ← key]
  have hS : ∀ n d c, F.SectorsAt w n d c ↔ F'.SectorsAt w n d c := fun n d c => by
    simp only [SectorsAt, hcone, hdom]
  simp only [NiceAt, hS]

/-! ## The local data at a point -/

/-- **The local data at `v`**: off the finitely many directions `D` (mod `2π`), a thin open cone about each direction `φ` lies in the colour
class `σ φ`. With `D` the tangent directions at `v` of the arcs through `v`, wave 3's wedge lemma gives it at every point of the domain
(`exists_dirColourAt`). `D` may hold invisible directions (an arc between two sides of one colour); the colour classes' cones off `D` are read
from `σ` alone. -/
def DirColourAt (F : ArcMap k) (v : ℂ) (D : Finset ℝ) (σ : ℝ → Fin k) : Prop :=
  ∀ φ : ℝ, OffDirs D φ → ∃ r > 0, annSector v 0 r (φ - r) (φ + r) ⊆ F.region (σ φ)

/-- Spec example: the one-colour plane has the local data `D = ∅`, `σ = 0` at every point. -/
example (v : ℂ) : (ArcMap.const univ isOpen_univ (0 : Fin 1)).DirColourAt v ∅ fun _ => 0 :=
  fun _ _ => ⟨1, one_pos, fun _ _ => ⟨by simp, rfl⟩⟩

/-- **The local data exists at every point of the domain** — from `exists_goodAt` and `GoodAt.exists_wedge` (wave 3, landed); no
`localSectors`. -/
theorem exists_dirColourAt {v : ℂ} (hv : v ∈ F.dom) : ∃ (D : Finset ℝ) (σ : ℝ → Fin k), F.DirColourAt v D σ := by
  sorry

/-- **In a good ball only the centre carries three colours**: every other point lies on at most one full curve of arcs
(`GoodAt.exists_local_curve`), which it has two sides of. -/
theorem GoodAt.ncard_coloursAt_le_two {x : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt x ρ₀) {z : ℂ} (hz : z ∈ ball x ρ₀) (hzx : z ≠ x) :
    (F.coloursAt z).ncard ≤ 2 := by
  sorry

/-- **Points of three or more colours are finite on a compact subset of the domain** (finitely many good balls cover it, each holding at
most its centre). -/
theorem finite_three_le_coloursAt {K : Set ℂ} (hK : IsCompact K) (hKd : K ⊆ F.dom) :
    {v ∈ K | 3 ≤ (F.coloursAt v).ncard}.Finite := by
  sorry

/-- **The `NiceAt` picture from the local data** (E3-NICE's last paragraph): if every colour's directions off `D` form one arc of the circle
(`hrun`) and no colour's cone meets a direction of `D` strictly inside another colour's arc (`hpoke`), a point of three or more colours is
`NiceAt` — the arcs, in order, are the positive sectors, and at each change of colour the other colours whose cones hold that direction are
horns, each once. -/
theorem niceAt_of_dirColourAt {v : ℂ} (hv : v ∈ F.dom) {D : Finset ℝ} {σ : ℝ → Fin k} (hD : F.DirColourAt v D σ)
    (hrun : ∀ φ₁ φ₂ : ℝ, OffDirs D φ₁ → OffDirs D φ₂ → φ₁ < φ₂ → φ₂ < φ₁ + 2 * π → σ φ₁ = σ φ₂ →
      (∀ φ ∈ Ioo φ₁ φ₂, OffDirs D φ → σ φ = σ φ₁) ∨ (∀ φ ∈ Ioo φ₂ (φ₁ + 2 * π), OffDirs D φ → σ φ = σ φ₁))
    (hpoke : ∀ δ ∈ D, ∀ j c : Fin k, δ ∈ coneAt (F.region j) v →
      (∃ t > 0, ∀ φ ∈ Ioo (δ - t) (δ + t), OffDirs D φ → σ φ = c) → j = c)
    (h3 : 3 ≤ (F.coloursAt v).ncard) : F.NiceAt v := by
  sorry

/-- **The local data after a merge at a wedge**: off `D` and the two edge directions, a direction strictly inside the wedge now carries `c`,
and every other one keeps its colour (for a small enough cone the wedge either contains it or misses it and the new arcs). -/
theorem dirColourAt_wedgeMerge {v : ℂ} {D : Finset ℝ} {σ : ℝ → Fin k} (hD : F.DirColourAt v D σ) {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ)
    (hd : d₁ < d₂) (hd2 : d₂ < d₁ + 2 * π) :
    (F.wedgeMerge v hρ hd hd2.le c).DirColourAt v (insert d₁ (insert d₂ D))
      (fun φ => by classical exact if φ ∈ angleIoo d₁ d₂ then c else σ φ) := by
  sorry

/-- **The points a merge at a wedge creates are `NiceAt`** (E3-NICE's crossings): inside a good ball of `F` at `v`, with the two edges in
`F`'s class of `c` a little beyond the radius `ρ`, every point of `closedBall v ρ` other than `v` that carries three or more colours after the
merge is `NiceAt` — it is a transversal crossing of the outer arc with a branch through `v`, `c` on the inner half and two other colours outside
(a three-sector picture); every other such point carries at most two colours. -/
theorem wedgeMerge_niceAt {v : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt v ρ₀) {ρ d₁ d₂ r₁ : ℝ} (hρ : 0 < ρ) (hρ₀ : ρ < ρ₀) (hd : d₁ < d₂)
    (hπ : d₂ - d₁ < π) (hρr : ρ < r₁)
    (hc : ∀ s ∈ Ioo 0 r₁, v + (s : ℂ) * e d₁ ∈ F.region c ∧ v + (s : ℂ) * e d₂ ∈ F.region c)
    {w : ℂ} (hw : w ∈ closedBall v ρ) (hwv : w ≠ v)
    (h3 : 3 ≤ ((F.wedgeMerge v hρ hd (by linarith [Real.pi_pos]) c).coloursAt w).ncard) :
    (F.wedgeMerge v hρ hd (by linarith [Real.pi_pos]) c).NiceAt w := by
  sorry

/-! ## E3-NICE and E3-BALL -/

/-- **E3-NICE, the merge at one point** (`plans/FS131-E3-derivation.md` § 3.3): for every `ε > 0` there are `ρ ∈ (0, ε)` and a valid map of the
plane, Condition 5 kept, equal to `F` off `closedBall v ρ`, in which every point of `closedBall v ρ` of three or more colours is `NiceAt` —
finitely many merges at wedges (`wedgeMerge`) of decreasing radii, each across a gap of angle `< π` between two arcs of one colour, or across a
colour poking into another's arc, until the local data at `v` satisfies `niceAt_of_dirColourAt`; the new points of three colours are crossings
of the merges' outer arcs with branches, `NiceAt` by the same lemma. -/
theorem exists_merge_at (hF : F.Valid) (hP : F.IsPlaneMap) (v : ℂ) {ε : ℝ} (hε : 0 < ε) :
    ∃ ρ ∈ Ioo 0 ε, ∃ F' : ArcMap k, F'.Valid ∧ F'.IsPlaneMap ∧ (F.Condition5 → F'.Condition5) ∧
      (∀ j, F'.region j \ closedBall v ρ = F.region j \ closedBall v ρ) ∧ F'.WoodallMerged (closedBall v ρ) := by
  sorry

/-- **Woodall's step 3, localized** (FS131-E3's E3-BALL, `plans/FS131-E3-derivation.md` § 3.4; `[Woodall1973]` p. 197 for the merge): every
valid map of the plane has a valid map of the plane, Condition 5 kept, in which every point of `closedBall 0 R` of three or more colours is
`NiceAt` — the points of three colours in the ball are finite (`finite_three_le_coloursAt`), and one merge (`exists_merge_at`), within less
than their distance to the others, removes one bad point and adds none (`coloursAt_congr`, `niceAt_congr` off the merged ball). Not claimed:
Woodall's horn-only conclusion, at every point (a GAP past Condition 5, inventory item 161 (b)). -/
theorem exists_woodallMerged (hF : F.Valid) (hP : F.IsPlaneMap) (R : ℝ) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.IsPlaneMap ∧ F'.WoodallMerged (closedBall 0 R) ∧ (F.Condition5 → F'.Condition5) := by
  classical
  -- the bad points of a map: points of the ball of three or more colours that are not `NiceAt`
  let bad : ArcMap k → Set ℂ := fun G => {w | w ∈ closedBall 0 R ∧ 3 ≤ (G.coloursAt w).ncard ∧ ¬ G.NiceAt w}
  suffices key : ∀ (n : ℕ) (S : Finset ℂ), S.card = n → ∀ G : ArcMap k, G.Valid → G.IsPlaneMap → bad G ⊆ ↑S →
      ∃ F' : ArcMap k, F'.Valid ∧ F'.IsPlaneMap ∧ F'.WoodallMerged (closedBall 0 R) ∧ (G.Condition5 → F'.Condition5) by
    have hfin := finite_three_le_coloursAt (F := F) (isCompact_closedBall (0 : ℂ) R) (by rw [hP]; exact subset_univ _)
    exact key _ hfin.toFinset rfl F hF hP fun w hw => hfin.mem_toFinset.mpr ⟨hw.1, hw.2.1⟩
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
  intro S hS G hG hGP hbad
  by_cases hne : (bad G).Nonempty
  · obtain ⟨v, hv⟩ := hne
    have hvS : v ∈ S := hbad hv
    obtain ⟨ρ, hρ, G₁, hG₁, hG₁P, h5, hdiff, hM⟩ := exists_merge_at hG hGP v one_pos
    have hsub : bad G₁ ⊆ ↑(S.erase v) := by
      rintro w ⟨hwR, hw3, hwn⟩
      by_cases hwv : w ∈ closedBall v ρ
      · exact absurd (hM w hwv hw3) hwn
      · have hU : (closedBall v ρ)ᶜ ∈ 𝓝 w := isClosed_closedBall.isOpen_compl.mem_nhds hwv
        have hreg : ∀ j, G₁.region j ∩ (closedBall v ρ)ᶜ = G.region j ∩ (closedBall v ρ)ᶜ := fun j => by
          simpa [Set.sdiff_eq] using hdiff j
        have hcol := coloursAt_congr hU hreg
        have hnice := niceAt_congr hU (by rw [hG₁P, hGP]) hreg
        have hwG : w ∈ bad G := ⟨hwR, hcol ▸ hw3, fun h => hwn (hnice.mpr h)⟩
        refine Finset.mem_coe.mpr (Finset.mem_erase.mpr ⟨?_, hbad hwG⟩)
        rintro rfl
        exact hwv (mem_closedBall_self hρ.1.le)
    have hlt : (S.erase v).card < n := by
      rw [← hS]; exact Finset.card_erase_lt_of_mem hvS
    obtain ⟨F', hF', hF'P, hF'M, hF'5⟩ := ih _ hlt (S.erase v) rfl G₁ hG₁ hG₁P hsub
    exact ⟨F', hF', hF'P, hF'M, fun h => hF'5 (h5 h)⟩
  · refine ⟨G, hG, hGP, fun w hw h3 => ?_, id⟩
    by_contra hn
    exact hne ⟨w, hw, h3, hn⟩

end ArcMap

end HadwigerNelson.Plane
