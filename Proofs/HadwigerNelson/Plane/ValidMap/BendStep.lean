import Proofs.HadwigerNelson.Plane.ValidMap.Limit
import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc
import Proofs.HadwigerNelson.Plane.ValidMap.BendCollar
import Proofs.HadwigerNelson.Plane.ValidMap.OpenMove

/-!
# The bends in the form the arc step reads (FS131-IA1)

`exists_arcStep` (`Plane/ValidMap/Procedure`) bends a maximal bad unit arc and reads, of the bent map: a local step near the arc, no
site created, no rise of degree or horn count at a treatment point, and at every other treatment point no rise of the bad count —
**question (5)**: a bend never cuts another arc's (R2) witness. This module holds what does not depend on `Procedure`
(`plans/FS131-arcstep-implementation.md`):

* **Question (5)**, for every bend given by a homeomorphism that fixes `Γ` off the open arc (`isR2Arc_of_fixed`): in a valid map an
  (R2) witness arc lies in `Γ` wherever it lies in the domain (`radiusTwoArc_inter_dom_subset_Γ` — a witness point interior to its
  class would be at distance `1` from the arc's inner collar), so it cannot run through an interior point of the bent arc, near which
  `Γ` is `ω(P)` alone (`radiusTwoArc_disjoint_openArc`), and every one of its points is fixed.
* **The collar bend's step forms** (`bend_toward_collar`'s construction, `CollarFit`): the hypothesis `hfree` from cleanness
  (`IsRingArc.free_of_isClean`), the bent map clean (`CollarFit.map_isClean`), (R2) arcs kept (`CollarFit.map_isR2Arc`), degrees at the
  points of the closed arc and off the collar (`CollarFit.map_degree_le`).
* **Two open children**, stated for a planner: the horn clause for the collar bend (`CollarFit.map_hornCount_le`) and the away bend with
  the tangent bend in collar form (`bend_away_part`, FS112-N2-AWAY and N2-TAN).
* A recorded **no-go** for the arc step's withdrawn degree clause (`Γ_eq_of_degree_clause`).

**Models.** `Valid` with a constant-sided ring arc: `l60Frag` (`l60Frag_valid`, `l60Frag_isRingArc`; the spec example below).
`CollarFit`: `collarModel` (`BendCollar`). **No Lean model is named here** for an (R2) witness — a ring arc of a valid map with
`radiusTwoArc Q a b ⊆ closure (F.region d)`, the hypothesis of `radiusTwoArc_inter_dom_subset_Γ`, `radiusTwoArc_disjoint_openArc`,
`isR2Arc_of_fixed` and `CollarFit.map_isR2Arc` — nor for a clean map carrying a ring arc (`IsRingArc.free_of_isClean`,
`CollarFit.map_isClean`): open gate items, owed with the arc step's model (inventory ruling 427 (d), F3).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## A no-go for the withdrawn degree clause -/

/-- **No-go for a withdrawn clause** (not a claim about a live theorem): `exists_arcStep` once asked of its bent map `F'` that
`∀ x m, F.HasDegree x m → F'.HasDegree x m` (inventory items of 2026-10-06, FS131-IA1's D1). Between two clean maps on one domain
that clause forces `Γ` to be unchanged — a point of `Γ` has degree at least `2` (two colours), an interior point degree `1` — so no
bend satisfies it. The clause now reads the degrees at the treatment points only. Inhabitant of the hypotheses: `F' = F`. -/
theorem Γ_eq_of_degree_clause {F' : ArcMap k} (hc : F.IsClean) (hc' : F'.IsClean) (hdom : F'.dom = F.dom)
    (h : ∀ x m, F.HasDegree x m → F'.HasDegree x m) : F'.Γ = F.Γ := by
  ext x
  constructor
  · intro hx
    by_contra hxF
    have hxd : x ∈ F.dom := hdom ▸ hx.1
    have hint : x ∈ F.interiorPts := ⟨hxd, fun hx' => hxF ⟨hxd, hx'⟩⟩
    have h1 : F'.HasDegree x 1 := h x 1 ((hasDegree_iff_of_mem_interiorPts hint 1).mpr rfl)
    obtain ⟨n, hn, hdeg⟩ := exists_hasDegree_of_mem_dom hx.1
    have := hc' x hx
    have := hdeg.unique h1
    omega
  · intro hx
    by_contra hxF'
    have hxd : x ∈ F'.dom := hdom ▸ hx.1
    have hint : x ∈ F'.interiorPts := ⟨hxd, fun hx' => hxF' ⟨hxd, hx'⟩⟩
    obtain ⟨n, hn, hdeg⟩ := exists_hasDegree_of_mem_dom hx.1
    have h1 : n = 1 := (hasDegree_iff_of_mem_interiorPts hint n).mp (h x n hdeg)
    have := hc x hx
    omega

/-! ## Question (5): an (R2) witness arc lies in `Γ`, and off the open part of any free unit arc -/

/-- **No radius-2 point over a constant-sided unit arc lies in the inner colour's class**: for an interior angle the ring point is in
the class's closure at distance exactly `1`; an end angle follows, the class being open. (Validity alone; no witness is assumed.) -/
theorem r2_notMem_region (hF : F.Valid) {Q : ℂ} {a b : ℝ} {d d' : Fin k} (hA : F.IsRingArc Q a b d d') {β : ℝ}
    (hβ : β ∈ Icc a b) : Q + 2 * e β ∉ F.region d := by
  have hint : ∀ β' ∈ Ioo a b, Q + 2 * e β' ∉ F.region d := by
    intro β' hβ' hw
    have hx : ringPt Q β' ∈ closure (F.region d) := by
      have : d ∈ F.innerColours Q (ringPt Q β') := by rw [(hA.2.2 β' hβ').1]; rfl
      exact closure_mono inter_subset_left this
    refine ne1_region hF hx hw ?_
    have := dist_polar_ringPt Q 2 β'
    rw [Complex.ofReal_ofNat] at this
    rw [this]; norm_num
  intro hw
  have hcont : Continuous fun t : ℝ => Q + 2 * e t := continuous_const.add (continuous_const.mul continuous_e)
  have hmem : ∀ᶠ t in 𝓝 β, Q + 2 * e t ∈ F.region d := hcont.continuousAt.eventually ((F.isOpen_region d).mem_nhds hw)
  have hne : (𝓝[Ioo a b] β).NeBot := by
    rw [← mem_closure_iff_nhdsWithin_neBot, closure_Ioo hA.1.ne]; exact hβ
  haveI := hne
  have hev : ∀ᶠ t in 𝓝[Ioo a b] β, Q + 2 * e t ∈ F.region d ∧ t ∈ Ioo a b :=
    (hmem.filter_mono nhdsWithin_le_nhds).and self_mem_nhdsWithin
  obtain ⟨t, ht, htI⟩ := hev.exists
  exact hint t htI ht

/-- **An (R2) witness arc lies in `Γ` wherever it lies in the domain**: a witness point is in the closure of the inner colour's class
and not in the class (`r2_notMem_region`), so it is no interior point. -/
theorem radiusTwoArc_inter_dom_subset_Γ (hF : F.Valid) {Q : ℂ} {a b : ℝ} {d d' : Fin k} (hA : F.IsRingArc Q a b d d')
    (hw : radiusTwoArc Q a b ⊆ closure (F.region d)) : radiusTwoArc Q a b ∩ F.dom ⊆ F.Γ := by
  rintro w ⟨⟨β, hβ, rfl⟩, hwd⟩
  by_contra hΓ
  have hint : Q + 2 * e β ∈ F.interiorPts := ⟨hwd, fun h => hΓ ⟨hwd, h⟩⟩
  have hcol : d ∈ F.coloursAt (Q + 2 * e β) := hw ⟨β, hβ, rfl⟩
  rw [coloursAt_eq_singleton_of_interior hint, mem_singleton_iff] at hcol
  exact r2_notMem_region hF hA hβ ⟨hint, hcol.symm⟩

/-- **An (R2) witness arc misses the open part of a free unit arc**: near an interior point of an arc of `ω(P)` with `Γ` free there,
`Γ` lies on `ω(P)`, which the radius-2 circle about `Q` meets in finitely many points — but a witness arc through the point would put
a whole sub-arc of itself into `Γ` there. -/
theorem radiusTwoArc_disjoint_openArc (hF : F.Valid) {P Q : ℂ} {θ₁ θ₂ a b : ℝ} {d d' : Fin k}
    (hA : F.IsRingArc Q a b d d') (hw : radiusTwoArc Q a b ⊆ closure (F.region d))
    (hfree : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1) :
    Disjoint (radiusTwoArc Q a b ∩ F.dom) (ringPt P '' Ioo θ₁ θ₂) := by
  rw [Set.disjoint_left]
  rintro w ⟨⟨β, hβ, rfl⟩, hwd⟩ ⟨θ, hθ, hwθ⟩
  obtain ⟨r, hr, hfr⟩ := hfree θ hθ
  have hℓ := l60_le hF hA
  have hπ := Real.pi_pos
  have hcont : Continuous fun t : ℝ => Q + 2 * e t := continuous_const.add (continuous_const.mul continuous_e)
  have hO : IsOpen ((fun t : ℝ => Q + 2 * e t) ⁻¹' (ball (ringPt P θ) r ∩ F.dom)) :=
    (isOpen_ball.inter F.isOpen_dom).preimage hcont
  have hβO : β ∈ (fun t : ℝ => Q + 2 * e t) ⁻¹' (ball (ringPt P θ) r ∩ F.dom) :=
    ⟨by show Q + 2 * e β ∈ ball (ringPt P θ) r; rw [hwθ]; exact mem_ball_self hr, hwd⟩
  obtain ⟨η, hη, hball⟩ := Metric.isOpen_iff.mp hO β hβO
  have hlt : max a (β - η) < min b (β + η) := by
    rw [max_lt_iff, lt_min_iff, lt_min_iff]
    exact ⟨⟨hA.1, by linarith [hβ.1]⟩, ⟨by linarith [hβ.2], by linarith⟩⟩
  have hJ : (Ioo (max a (β - η)) (min b (β + η))).Infinite := Ioo_infinite hlt
  have hmemI : ∀ t ∈ Ioo (max a (β - η)) (min b (β + η)), t ∈ Icc a b := fun t ht =>
    ⟨(le_max_left _ _).trans ht.1.le, ht.2.le.trans (min_le_left _ _)⟩
  have hsub : (fun t : ℝ => Q + 2 * e t) '' Ioo (max a (β - η)) (min b (β + η)) ⊆
      (Arc.circ Q 2 a b).carrier ∩ sphere P 1 := by
    rintro _ ⟨t, ht, rfl⟩
    have hta := hmemI t ht
    have htη : t ∈ ball β η := by
      rw [Real.ball_eq_Ioo]
      exact ⟨(le_max_right _ _).trans_lt ht.1, ht.2.trans_le (min_le_right _ _)⟩
    obtain ⟨htb, htd⟩ := hball htη
    have htΓ : Q + 2 * e t ∈ F.Γ := radiusTwoArc_inter_dom_subset_Γ hF hA hw ⟨⟨t, hta, rfl⟩, htd⟩
    refine ⟨⟨t, hta, ?_⟩, hfr ⟨htΓ, htb⟩⟩
    show Q + ((2 : ℝ) : ℂ) * e t = Q + 2 * e t
    rw [Complex.ofReal_ofNat]
  have hfin : ((Arc.circ Q 2 a b).carrier ∩ sphere P 1).Finite := by
    rcases (Arc.circ Q 2 a b).finite_inter_sphere_or_eq_circ ⟨by norm_num, hA.1, by linarith⟩ P with h | ⟨θ₀, θ₁', h⟩
    · exact h
    · simp only [Arc.circ.injEq] at h
      norm_num at h
  have hinj : InjOn (fun t : ℝ => Q + 2 * e t) (Ioo (max a (β - η)) (min b (β + η))) := by
    intro s hs t ht hst
    have he : e s = e t := by
      have h2 : (2 : ℂ) * e s = 2 * e t := add_left_cancel hst
      exact mul_left_cancel₀ two_ne_zero h2
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp he
    have hs' := hmemI s hs
    have ht' := hmemI t ht
    have hn0 : n = 0 := by
      by_contra hne
      rcases lt_or_gt_of_ne hne with hneg | hpos
      · have : (n : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_of_lt hneg
        nlinarith [hs'.1, hs'.2, ht'.1, ht'.2]
      · have : (1 : ℝ) ≤ n := by exact_mod_cast hpos
        nlinarith [hs'.1, hs'.2, ht'.1, ht'.2]
    rw [hn0] at hn
    simpa using hn
  exact (hJ.image hinj) (hfin.subset hsub)

/-- **Question (5)** (FS131-KL1's, `exists_arcStep`'s last clause), for any bend given by a homeomorphism: let `h` be the identity off
a set `K ⊆ dom`, fix every point of `Γ` off the open arc `r((θ₁, θ₂))` of `ω(P)`, and carry the colours at each point to the bent map
`M`; let `Γ` be free near the open arc. Then an (R2) arc of `F` about any `Q` whose ring arc survives in `M`, with the colours at `Q`
unchanged, is an (R2) arc of `M`: its witness arc lies in `Γ` on `K` and off the open arc, so `h` fixes each witness point.
The bend's hypotheses (`hK` to `hring`) are met by the collar bend (`CollarFit.map_isR2Arc`); for `hR`, an (R2) arc of a valid map, no
Lean model is named (the module header). -/
theorem isR2Arc_of_fixed {M : ArcMap k} {h : ℂ ≃ₜ ℂ} {K : Set ℂ} {P Q : ℂ} {θ₁ θ₂ a b : ℝ} (hF : F.Valid)
    (hK : K ⊆ F.dom) (hfix : ∀ z ∉ K, h z = z) (hfixΓ : ∀ z ∈ F.Γ, z ∉ ringPt P '' Ioo θ₁ θ₂ → h z = z)
    (hcol : ∀ z, M.coloursAt (h z) = F.coloursAt z)
    (hfree : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1)
    (hring : ∀ d d', F.IsRingArc Q a b d d' → M.IsRingArc Q a b d d')
    (hcolQ : M.coloursAt Q = F.coloursAt Q) (hR : F.IsR2Arc Q a b) : M.IsR2Arc Q a b := by
  obtain ⟨d, d', hA, hd', hd, hw⟩ := hR
  refine ⟨d, d', hring d d' hA, by rw [hcolQ]; exact hd', by rw [hcolQ]; exact hd, fun w hwR => ?_⟩
  have hfixw : h w = w := by
    by_cases hwK : w ∈ K
    · have hwΓ := radiusTwoArc_inter_dom_subset_Γ hF hA hw ⟨hwR, hK hwK⟩
      exact hfixΓ w hwΓ fun hwO =>
        Set.disjoint_left.mp (radiusTwoArc_disjoint_openArc hF hA hw hfree) ⟨hwR, hK hwK⟩ hwO
    · exact hfix w hwK
  have hmem : d ∈ M.coloursAt (h w) := by rw [hcol]; exact hw hwR
  rw [hfixw] at hmem
  exact hmem

/-! ## The collar bend's hypothesis from cleanness -/

/-- **In a clean map `Γ` is free near each interior point of a constant-sided unit arc** (`bend_toward_collar`'s `hfree`): near the
point only the inner colour lies inside `ω(P)` and only the outer colour outside, so a point of `Γ` off `ω(P)` there would carry one
colour. -/
theorem IsRingArc.free_of_isClean (hc : F.IsClean) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c') :
    ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1 := by
  intro θ hθ
  obtain ⟨hin, hout⟩ := hA.2.2 θ hθ
  have hcl1 : IsClosed (⋃ j ∈ {j : Fin k | j ≠ c}, closure (F.region j ∩ ball P 1)) :=
    (Set.toFinite _).isClosed_biUnion fun j _ => isClosed_closure
  have hcl2 : IsClosed (⋃ j ∈ {j : Fin k | j ≠ c'}, closure (F.region j \ closedBall P 1)) :=
    (Set.toFinite _).isClosed_biUnion fun j _ => isClosed_closure
  have hx1 : ringPt P θ ∉ ⋃ j ∈ {j : Fin k | j ≠ c}, closure (F.region j ∩ ball P 1) := by
    intro h
    obtain ⟨j, hj, hxj⟩ := mem_iUnion₂.mp h
    have : j ∈ F.innerColours P (ringPt P θ) := hxj
    rw [hin] at this
    exact hj this
  have hx2 : ringPt P θ ∉ ⋃ j ∈ {j : Fin k | j ≠ c'}, closure (F.region j \ closedBall P 1) := by
    intro h
    obtain ⟨j, hj, hxj⟩ := mem_iUnion₂.mp h
    have : j ∈ F.outerColours P (ringPt P θ) := hxj
    rw [hout] at this
    exact hj this
  obtain ⟨r, hr, hball⟩ := Metric.isOpen_iff.mp (hcl1.isOpen_compl.inter hcl2.isOpen_compl) _ ⟨hx1, hx2⟩
  refine ⟨r, hr, fun y ⟨hyΓ, hyb⟩ => ?_⟩
  obtain ⟨hy1, hy2⟩ := hball hyb
  have h2 := hc y hyΓ
  rw [mem_sphere]
  by_contra hne
  rcases lt_or_gt_of_ne hne with hlt | hgt
  · obtain ⟨j, hj, hjc⟩ := Set.exists_ne_of_one_lt_ncard (by omega : 1 < (F.coloursAt y).ncard) c
    refine hy1 (mem_iUnion₂.mpr ⟨j, hjc, ?_⟩)
    have := isOpen_ball.inter_closure (t := F.region j) ⟨mem_ball.mpr hlt, hj⟩
    rwa [inter_comm] at this
  · obtain ⟨j, hj, hjc⟩ := Set.exists_ne_of_one_lt_ncard (by omega : 1 < (F.coloursAt y).ncard) c'
    refine hy2 (mem_iUnion₂.mpr ⟨j, hjc, ?_⟩)
    have hopen : IsOpen (closedBall P 1)ᶜ := isClosed_closedBall.isOpen_compl
    have := hopen.inter_closure (t := F.region j) ⟨fun h' => absurd (mem_closedBall.mp h') (not_le.mpr hgt), hj⟩
    rwa [inter_comm, ← Set.sdiff_eq] at this

/-! ## The collar bend's step forms -/

section Collar

variable {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} {ε R' R R'' : ℝ}

/-- **The bent map of a clean map is clean**: its `Γ` is the image of `F`'s and the colours at a point are carried. -/
theorem CollarFit.map_isClean (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') (hc : F.IsClean) : hfit.map.IsClean := by
  intro x hx
  have hΓ : hfit.map.Γ = hfit.homeo '' F.Γ := by rw [CollarFit.map, pushforward_Γ]
  rw [hΓ] at hx
  obtain ⟨z, hz, rfl⟩ := hx
  have hcol : hfit.map.coloursAt (hfit.homeo z) = F.coloursAt z := pushforward_coloursAt z
  rw [hcol]
  exact hc z hz

/-- **Question (5) for the collar bend**: an (R2) arc of `F` about `Q` whose open arc misses the bent open arc, with the colours at
`Q` unchanged, is an (R2) arc of the bent map (`isR2Arc_of_fixed`, `CollarFit.map_R2`). -/
theorem CollarFit.map_isR2Arc (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {Q : ℂ} {a b : ℝ}
    (hdisj : Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂)) (hcolQ : hfit.map.coloursAt Q = F.coloursAt Q)
    (hR : F.IsR2Arc Q a b) : hfit.map.IsR2Arc Q a b :=
  isR2Arc_of_fixed hF hfit.sub_dom (fun _ hz => (hfit.homeo_eq_self hz).1) (fun _ hz hzO => hfit.homeo_fix_Γ hz hzO)
    (fun z => pushforward_coloursAt z) hfit.free_open (fun _ _ hA => hfit.map_R2 hF hA hdisj) hcolQ hR

/-- **Degrees do not rise at a point off the collar or on the closed arc** (the repaired degree clause of `exists_arcStep`, where
it is read: a treatment point of the support lies on the closed arc once `ε` is small). Off the collar and at the two ends the
degree is kept; on the open arc it falls from `2` to `1`. -/
theorem CollarFit.map_degree_le (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {x : ℂ}
    (hx : x ∉ collarK P θ₁ θ₂ R' R'' ∨ x ∈ ringArc P θ₁ θ₂) {m : ℕ} (hm : F.HasDegree x m) :
    ∃ m' ≤ m, hfit.map.HasDegree x m' := by
  rcases hx with hx | ⟨θ, hθ, rfl⟩
  · refine ⟨m, le_rfl, ?_⟩
    have := (hfit.map_hasDegree hF x m).mpr hm
    rwa [(hfit.homeo_eq_self hx).1] at this
  · by_cases hθO : θ ∈ Ioo θ₁ θ₂
    · have hm2 : m = 2 := ((hfit.degree_openArc hθO).1 m).mp hm
      have hL : ringPt P θ ∈ lensSet P θ₁ θ₂ R :=
        ⟨θ, hθO, 1, ⟨(hfit.pushProfiles.inside θ hθO).2.2.1, le_rfl⟩, by simp [ringPt]⟩
      exact ⟨1, by omega, (hasDegree_iff_of_mem_interiorPts (hfit.map_lens hL).1 1).mpr rfl⟩
    · have hend : ringPt P θ = ringPt P θ₁ ∨ ringPt P θ = ringPt P θ₂ := by
        rcases eq_or_lt_of_le hθ.1 with h1 | h1
        · exact Or.inl (by rw [h1])
        · rcases eq_or_lt_of_le hθ.2 with h2 | h2
          · exact Or.inr (by rw [h2])
          · exact absurd ⟨h1, h2⟩ hθO
      exact ⟨m, le_rfl, ((hfit.map_degree_end hF hend).1 m).mpr hm⟩

/-- **The horn clause for the collar bend** (`exists_arcStep`'s clause of inventory item 385 (a), FS131-E6's): no point's horn count
rises. **Open — `sorry`, stated for a planner or the assembly** (FS131-IA1; hand grade, one mind). Route, by the place of `x`: off the
collar the maps agree near `x` (`hasHornCount_iff_of_agreesOff`'s argument); in the lens and on the open arc `x` is interior in the
bent map, on the lens boundary it has two germs of different directions (a circle of radius `R`, or the two circles crossing at
`collarMid`) — horn count `0` (`Near.hasHornCount_chart`); at an end the chart is `F`'s with the arc's germ's curvature `1` replaced by
`1/R` (`CollarFit.map_degree_end`'s chart surgery), the collar's crescent holds no other germ of that direction (`CollarFit.free`), so
the indices with `β i = nextβ i` are the same and the count is kept. No inhabitant note is owed beyond `collarModel` (`CollarFit`'s). -/
theorem CollarFit.map_hornCount_le (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {x : ℂ} {j : ℕ}
    (hj : F.HasHornCount x j) : ∃ j' ≤ j, hfit.map.HasHornCount x j' := by
  sorry

end Collar

/-! ## The away bend, in the form the arc step reads (open) -/

/-- **The away bend with the tangent bend, in collar form** (FS112-N2-AWAY and N2-TAN; wave 4's `bend_away`, `sorry` on `fs131-w4ba`,
is its statement without the homeomorphism). **Open — `sorry`: the statement `exists_arcStep`'s out-only case reads, written for a
planner** (FS131-IA1, `plans/FS131-arcstep-implementation.md` Stage 3). On a valid plane map, for a constant-sided unit arc
`α = r([θ₁, θ₂])` of `ω(P)` whose inner colour `c` is not carried at `P` and near whose interior points `Γ` is `ω(P)` alone: for every
`ε > 0` a valid map `M`, the image of `F` under a homeomorphism `h` supported in a compact collar `K` within `ε` of `α` that meets `Γ`
only on `α`, a local step on `K`; `h` fixes `Γ` off the open arc and carries interior points with their colours, the colours at each
point, degrees, repeated colours and horn counts; no unit arc is created, the constant-sided unit arcs of `M` are `F`'s with the same
sides, and `F`'s whose open arc misses `α°` survive; each interior point of `α` is fixed or becomes an interior point of colour `c`;
and an interior point of `α` still on a unit arc of `M` about `P` lies in a non-degenerate interval of radius-2 contacts of `c`
(`r2Contacts`) — so what is left of `α` is (R2). Intended construction: on each of the finitely many gaps of `[θ₁, θ₂] \ C₂` the
outward radial push across a collar in the outer tile (`pushHomeo`), its lens bounded by circles tangent to `ω(P)` at the gap's ends
(at a contact end the lens must lie between `ω(P)` and the unit circle about the contact, FS112-ISO), clear for `c` by N2-ENV away
(`away_clear`). Model of the hypotheses: none in Lean on this branch; `isoFrag` (FS112-ISO, `fs131-w4ba`) is the hand model with one
isolated contact, a fragment — on a plane map the hypotheses' inhabitant at one arc with a partial witness is owed with the proof. -/
theorem bend_away_part (hF : F.Valid) (hP : F.IsPlaneMap) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hA : F.IsRingArc P θ₁ θ₂ c c') (hin : c ∉ F.coloursAt P)
    (hfree : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1) {ε : ℝ} (hε : 0 < ε) :
    ∃ (M : ArcMap k) (h : ℂ ≃ₜ ℂ) (K : Set ℂ), M.Valid ∧ IsCompact K ∧ K ⊆ thickening ε (ringArc P θ₁ θ₂) ∧
      F.Γ ∩ K ⊆ ringArc P θ₁ θ₂ ∧ LocalStep F M K ∧
      (∀ z ∉ K, h z = z) ∧ (∀ z ∈ K, h z ∈ K) ∧
      (∀ z ∈ F.Γ, z ∉ ringPt P '' Ioo θ₁ θ₂ → h z = z) ∧
      (∀ z, (h z ∈ M.interiorPts ↔ z ∈ F.interiorPts) ∧ (z ∈ F.interiorPts → M.col (h z) = F.col z)) ∧
      (∀ z, M.coloursAt (h z) = F.coloursAt z) ∧
      (∀ z n, M.HasDegree (h z) n ↔ F.HasDegree z n) ∧
      (∀ z, M.HasRepeatedColour (h z) ↔ F.HasRepeatedColour z) ∧
      (∀ z j, M.HasHornCount (h z) j ↔ F.HasHornCount z j) ∧
      M.RingArcsWithin F ∧
      (∀ Q a b d d', M.IsRingArc Q a b d d' → F.IsRingArc Q a b d d') ∧
      (∀ Q a b d d', F.IsRingArc Q a b d d' → Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) →
        M.IsRingArc Q a b d d') ∧
      (∀ θ ∈ Ioo θ₁ θ₂, h (ringPt P θ) = ringPt P θ ∨ ringPt P θ ∈ M.region c) ∧
      (∀ θ ∈ Ioo θ₁ θ₂, M.OnRingArc P (ringPt P θ) →
        ∃ a b, a < b ∧ θ ∈ Icc a b ∧ Icc a b ⊆ F.r2Contacts P θ₁ θ₂ c) := by
  sorry

/-! ## Spec examples -/

/-- The no-go's hypotheses are inhabited by the idle pair, and its conclusion is then trivial: the lemma says something only about a
pair of maps whose `Γ` differ — there the degree clause must fail. -/
example (hc : F.IsClean) : F.Γ = F.Γ := Γ_eq_of_degree_clause hc hc rfl fun _ _ h => h

/-- `r2_notMem_region` at a model: on `l60Frag` (valid, with the ring arc `r([0, π/3])` of `ω(0)`, sides `0` and `1`) no radius-2
point over the arc lies in the class of the inner colour `0`. -/
example {β : ℝ} (hβ : β ∈ Icc 0 (π / 3)) : (0 : ℂ) + 2 * e β ∉ l60Frag.region 0 :=
  r2_notMem_region l60Frag_valid l60Frag_isRingArc hβ

end ArcMap

end HadwigerNelson.Plane
