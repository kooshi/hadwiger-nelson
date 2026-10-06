import Proofs.HadwigerNelson.Plane.ValidMap.Limit

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- A non-degenerate arc is its own sub-arc over its whole parameter interval. -/
theorem Arc.exists_params_eq_Icc {a : Arc} (ha : a.Nondegenerate) :
    ∃ lo hi : ℝ, lo < hi ∧ a.params = Icc lo hi ∧ a.sub lo hi = a := by
  cases a with
  | seg p q => exact ⟨0, 1, zero_lt_one, rfl, by simp [Arc.sub]⟩
  | circ c R θ₀ θ₁ => exact ⟨θ₀, θ₁, ha.2.1, rfl, rfl⟩

/-- The order-connected component of a point of a closed interval in it is the interval. -/
theorem ordConnectedComponent_Icc {lo hi u : ℝ} (hu : u ∈ Icc lo hi) : (Icc lo hi).ordConnectedComponent u = Icc lo hi := by
  ext y
  rw [mem_ordConnectedComponent]
  exact ⟨fun h => h right_mem_uIcc, fun hy => ordConnected_Icc.uIcc_subset hu hy⟩

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## Cleaning a step: the clean map with the colour kept on the essential set -/

open scoped Classical in
variable (F) in
/-- **The clean map with `F`'s colour kept off the new interior** (`ArcMap.clean` with the colour function changed only where the
clean map reads it): `F`'s domain, the clean arcs, the clean colour at the points of one colour and `F.col` elsewhere. `ArcMap.clean`
sets the colour function to `cleanCol` everywhere, so on an arc far from a step it need not agree with the map before the step —
and `LocalStep` (through `AgreesOff`) compares the colour functions at every point off the support, the points of arcs included.
This variant is the cleaned step (`LocalStep.cleanKeep`). -/
noncomputable def cleanKeep : ArcMap k where
  dom := F.dom
  isOpen_dom := F.isOpen_dom
  arcs := F.cleanArcs
  nondegenerate := fun _ hb => cleanArcs_nondegenerate hb
  locallyFinite := fun _ hx => cleanArcs_locallyFinite hx
  col := fun z => if z ∈ F.dom \ F.essSet then F.cleanCol z else F.col z
  locallyConstant := by
    intro x hx hxn
    have hxE : x ∉ F.essSet := fun h => hxn (essSet_subset_cleanArcs h)
    have hmem : ∀ᶠ y in 𝓝 x, y ∈ F.dom \ F.essSet := isOpen_dom_diff_essSet.mem_nhds ⟨hx, hxE⟩
    filter_upwards [F.clean.locallyConstant x hx hxn, hmem] with y hy hyd
    rw [if_pos hyd, if_pos (show x ∈ F.dom \ F.essSet from ⟨hx, hxE⟩)]
    exact hy

/-- The kept-colour clean map has the clean map's `Γ`. -/
theorem cleanKeep_Γ : F.cleanKeep.Γ = F.essSet := clean_Γ

/-- The kept-colour clean map has the clean map's interior points. -/
theorem cleanKeep_interiorPts : F.cleanKeep.interiorPts = F.dom \ F.essSet := clean_interiorPts

/-- At its interior points the kept-colour clean map has the clean colour. -/
theorem cleanKeep_col {z : ℂ} (hz : z ∈ F.dom \ F.essSet) : F.cleanKeep.col z = F.cleanCol z := by
  classical
  show (if z ∈ F.dom \ F.essSet then F.cleanCol z else F.col z) = _
  rw [if_pos hz]

/-- Off its interior points the kept-colour clean map keeps `F`'s colour function. -/
theorem cleanKeep_col_of_not_mem {z : ℂ} (hz : z ∉ F.dom \ F.essSet) : F.cleanKeep.col z = F.col z := by
  classical
  show (if z ∈ F.dom \ F.essSet then F.cleanCol z else F.col z) = _
  rw [if_neg hz]

/-- The kept-colour clean map has the clean map's colour classes. -/
theorem cleanKeep_region (j : Fin k) : F.cleanKeep.region j = F.clean.region j := by
  ext z
  show z ∈ F.cleanKeep.interiorPts ∧ F.cleanKeep.col z ∈ ({j} : Set (Fin k)) ↔
    z ∈ F.clean.interiorPts ∧ F.clean.col z ∈ ({j} : Set (Fin k))
  rw [cleanKeep_interiorPts, clean_interiorPts]
  refine and_congr_right fun hz => ?_
  rw [cleanKeep_col hz]
  rfl

/-- **The kept-colour clean map keeps the colours at every point.** -/
theorem coloursAt_cleanKeep (x : ℂ) : F.cleanKeep.coloursAt x = F.coloursAt x := by
  have h : F.cleanKeep.coloursAt x = F.clean.coloursAt x := by
    ext j
    show x ∈ closure (F.cleanKeep.region j) ↔ x ∈ closure (F.clean.region j)
    rw [cleanKeep_region]
  rw [h, coloursAt_clean]

/-- The kept-colour clean map of a valid map is valid. -/
theorem cleanKeep_valid (hF : F.Valid) : F.cleanKeep.Valid := by
  intro x hx y hy hxy
  rw [cleanKeep_interiorPts] at hx hy
  rw [cleanKeep_col hx, cleanKeep_col hy]
  exact clean_valid hF x (clean_interiorPts ▸ hx) y (clean_interiorPts ▸ hy) hxy

/-- The kept-colour clean map is clean. -/
theorem cleanKeep_isClean : F.cleanKeep.IsClean := by
  intro x hx
  rw [cleanKeep_Γ] at hx
  rw [coloursAt_cleanKeep]
  exact hx.2

/-- The kept-colour clean map is a modification. -/
theorem cleanKeep_isModification : F.IsModification F.cleanKeep :=
  ⟨rfl, fun _ _ ⟨θ₁, θ₂, h12, hx, hsub⟩ => ⟨θ₁, θ₂, h12, hx, hsub.trans (cleanKeep_Γ.symm ▸ essSet_subset_Γ)⟩,
    fun x _ => (coloursAt_cleanKeep x).subset⟩

/-- **Off the closed support of a step from a clean map, every parameter of an arc of the old map is essential in the new one**
(its point, where it lies in the domain, carries its two old colours). -/
theorem essParams_eq_params_of_disjoint {F' : ArcMap k} {U : Set ℂ} (hc : F.IsClean) (hU : IsClosed U)
    (h : F'.AgreesOff F U) {a : Arc} (ha : a ∈ F.arcs) (hd : Disjoint a.carrier U) : F'.essParams a = a.params := by
  refine Subset.antisymm (fun t ht => ht.1) fun t ht => ⟨ht, ?_⟩
  have hta : a.pt t ∈ a.carrier := by rw [a.carrier_eq_image]; exact ⟨t, ht, rfl⟩
  have htU : a.pt t ∉ U := fun hU' => Set.disjoint_left.mp hd hta hU'
  by_cases htd : a.pt t ∈ F'.dom
  · refine Or.inr ⟨htd, ?_⟩
    have hΓ : a.pt t ∈ F.Γ := ⟨h.1 ▸ htd, mem_biUnion ha hta⟩
    rw [coloursAt_eq_of_agreesOn (W := Uᶜ) (by rwa [compl_compl]) hU.isOpen_compl htU]
    exact hc _ hΓ
  · exact Or.inl htd

/-- **Cleaning a step.** A local step from a clean map, on a closed support, is still a local step after the new map is cleaned
with its colour kept (`cleanKeep`): off the support the new interior is the old one (the old map is clean), with its colours; an
old arc missing the support stays whole (each of its points keeps its two colours); a clean arc is a piece of an arc of the step. -/
theorem LocalStep.cleanKeep {F' : ArcMap k} {U : Set ℂ} (hc : F.IsClean) (hU : IsClosed U) (h : LocalStep F F' U) :
    LocalStep F F'.cleanKeep U where
  agreesOff := by
    refine ⟨h.agreesOff.1, fun z hz => ?_⟩
    have hcol : F'.coloursAt z = F.coloursAt z :=
      coloursAt_eq_of_agreesOn (W := Uᶜ) (by rw [compl_compl]; exact h.agreesOff) hU.isOpen_compl hz
    have hiff : z ∈ F.interiorPts ↔ z ∈ F'.dom \ F'.essSet := by
      constructor
      · intro hzI
        refine ⟨h.agreesOff.1 ▸ hzI.1, fun hE => ?_⟩
        have h2 := hE.2
        rw [hcol, coloursAt_eq_singleton_of_interior hzI, ncard_singleton] at h2
        omega
      · rintro ⟨hzd, hzE⟩
        have hzd' : z ∈ F.dom := h.agreesOff.1 ▸ hzd
        by_contra hzI
        exact hzE ⟨hzd, hcol ▸ hc z ((mem_Γ_iff F).mpr ⟨hzd', hzI⟩)⟩
    rw [cleanKeep_interiorPts]
    refine ⟨hiff, ?_⟩
    by_cases hzm : z ∈ F'.dom \ F'.essSet
    · rw [cleanKeep_col hzm]
      exact (cleanCol_eq (hcol.trans (coloursAt_eq_singleton_of_interior (hiff.mpr hzm)))).symm
    · rw [cleanKeep_col_of_not_mem hzm]
      exact (h.agreesOff.2 z hz).2
  keep := by
    intro a ha hd
    obtain ⟨lo, hi, hlt, hpar, hsub⟩ := Arc.exists_params_eq_Icc (F.nondegenerate a ha)
    have hess := essParams_eq_params_of_disjoint hc hU h.agreesOff ha hd
    have hlo : lo ∈ Icc lo hi := ⟨le_rfl, hlt.le⟩
    refine ⟨a, h.keep a ha hd, lo, by rw [hess, hpar]; exact hlo, ?_, ?_⟩ <;>
      rw [hess, hpar, ordConnectedComponent_Icc hlo, csInf_Icc hlt.le, csSup_Icc hlt.le]
    · exact hlt
    · exact hsub.symm
  new := by
    rintro b ⟨a', ha', u, hu, hlt, rfl⟩ hbF
    have hsub : (a'.sub (sInf ((F'.essParams a').ordConnectedComponent u))
        (sSup ((F'.essParams a').ordConnectedComponent u))).carrier ⊆ a'.carrier := by
      rw [a'.carrier_sub hlt.le, a'.carrier_eq_image, ← essComp_eq_Icc a' hu]
      exact image_mono fun t ht => (ordConnectedComponent_subset ht).1
    by_cases haF : a' ∈ F.arcs
    · by_cases hd : Disjoint a'.carrier U
      · exfalso
        obtain ⟨lo, hi, hlt', hpar, hsub'⟩ := Arc.exists_params_eq_Icc (F.nondegenerate a' haF)
        have hess := essParams_eq_params_of_disjoint hc hU h.agreesOff haF hd
        have hu' : u ∈ Icc lo hi := by rw [← hpar, ← hess]; exact hu
        apply hbF
        rw [hess, hpar, ordConnectedComponent_Icc hu', csInf_Icc hlt'.le, csSup_Icc hlt'.le, hsub']
        exact haF
      · exact Or.inr ⟨a', haF, Set.not_disjoint_iff_nonempty_inter.mp hd, hsub⟩
    · rcases h.new a' ha' haF with hU' | ⟨a, ha, hne, hsub'⟩
      · exact Or.inl (hsub.trans hU')
      · exact Or.inr ⟨a, ha, hne, hsub.trans hsub'⟩

/-- **A cleaned step exists**: a local step from a clean map to a valid map, on a closed support, has a clean valid form that is
still a local step on that support, with the same colours at every point and no new point of `Γ` (the witness: `cleanKeep`). -/
theorem LocalStep.exists_clean {F' : ArcMap k} {U : Set ℂ} (hc : F.IsClean) (hU : IsClosed U) (hF' : F'.Valid)
    (h : LocalStep F F' U) :
    ∃ F'' : ArcMap k, F''.IsClean ∧ F''.Valid ∧ LocalStep F F'' U ∧ F'.IsModification F'' ∧
      (∀ x, F''.coloursAt x = F'.coloursAt x) ∧ F''.Γ ⊆ F'.Γ :=
  ⟨F'.cleanKeep, cleanKeep_isClean, cleanKeep_valid hF', h.cleanKeep hc hU, cleanKeep_isModification, coloursAt_cleanKeep,
    cleanKeep_Γ.symm ▸ essSet_subset_Γ⟩

end ArcMap

end HadwigerNelson.Plane
