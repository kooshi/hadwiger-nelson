import Proofs.HadwigerNelson.Plane.ValidMap.Chain
import Proofs.HadwigerNelson.Plane.Tiles

/-!
# The limit of a locally finite sequence of local steps (FS131-KL1)

Wave 5's limit infrastructure (`plans/FS131-limit-kernel-plan.md` § 2), for FS112-N2-RED and FS112-N2-TERM (`exists_red`,
`exists_terminal`): infinitely many local moves, each changing the map only on a compact set, the sets locally finite, have a
limit that agrees with every late enough stage near each compact part of the domain, so validity, the domain, "no unit arc created",
the colours at a point and every move's availability pass to it.

* **A local step** (`LocalStep F F' U`): `F'` agrees with `F` off `U` (`AgreesOff`), keeps every arc of `F` that misses `U` *as the
  same object*, and every new arc lies in `U` or inside an arc of `F` that meets `U`. Arcs are tracked because the limit's arcs are
  the arcs present from some stage on (`limitArcs`); a step that renamed far arcs (replaced an arc by a copy of it) would break that,
  and `keep` forbids it. The moves are surgeries (`trimArcs` plus new arcs in the disc), which have exactly this shape.
* **A locally finite sequence** (`LocalSeq`): steps `F n → F (n + 1)` on compact sets `U n` forming a locally finite family.
* **Its limit** (`LocalSeq.limit`): arcs eventually present, the colour at `z` read at the first stage after the last step whose set
  holds `z`. The pivot is `LocalSeq.frozen`: a compact part of the domain is met by finitely many supports, through every stage.
* **Locality** (`AgreesOff` on the complement of an open set `W`): two valid maps agreeing on `W` have the same colours, sectors,
  horns, contacts, cones, clearness, ring arcs and (Q)/(R2) arcs at the points whose closed ball of radius `3` lies in `W`
  (`coloursAt_eq_of_agreesOn`, `mergeAvailable_iff_of_agreesOn`, …). Validity enters through the tiles: in a valid map a tile of a
  colour carried at `v` never meets `ω(v)`, so in- and out-type are read near the contact.
* **Clean maps** (`IsClean`): every point of `Γ` carries two colours. A clean map's sites (`IsSite`: a repeated colour or a horn, the
  only points where a move can be available) are isolated; `exists_clean` removes the one-coloured parts of `Γ` from any valid map.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ}

/-- **Finitely many arcs meet a compact part of the domain** (local finiteness, by compactness). -/
theorem finite_arcs_inter_compact (F : ArcMap k) {K : Set ℂ} (hK : IsCompact K) (hKd : K ⊆ F.dom) :
    {a | a ∈ F.arcs ∧ (a.carrier ∩ K).Nonempty}.Finite := by
  refine hK.induction_on (p := fun s => {a | a ∈ F.arcs ∧ (a.carrier ∩ s).Nonempty}.Finite) ?_ ?_ ?_ ?_
  · simp
  · intro s t hst ht
    exact ht.subset fun a ⟨ha, hne⟩ => ⟨ha, hne.mono (inter_subset_inter_right _ hst)⟩
  · intro s t hs ht
    refine (hs.union ht).subset fun a ⟨ha, hne⟩ => ?_
    rw [inter_union_distrib_left] at hne
    rcases union_nonempty.mp hne with h | h
    · exact Or.inl ⟨ha, h⟩
    · exact Or.inr ⟨ha, h⟩
  · intro x hx
    obtain ⟨t, ht, hfin⟩ := F.locallyFinite x (hKd hx)
    exact ⟨t, mem_nhdsWithin_of_mem_nhds ht, hfin⟩

/-- A point of the domain lies on `Γ` exactly when it is not interior. -/
theorem mem_Γ_iff (F : ArcMap k) {z : ℂ} : z ∈ F.Γ ↔ z ∈ F.dom ∧ z ∉ F.interiorPts := by
  simp only [Γ, interiorPts, mem_inter_iff, Set.mem_sdiff, not_and, not_not]
  exact ⟨fun ⟨h1, h2⟩ => ⟨h1, fun _ => h2⟩, fun ⟨h1, h2⟩ => ⟨h1, h2 h1⟩⟩

/-- `AgreesOff` is symmetric. -/
theorem AgreesOff.symm {M F : ArcMap k} {U : Set ℂ} (h : M.AgreesOff F U) : F.AgreesOff M U :=
  ⟨h.1.symm, fun z hz => ⟨(h.2 z hz).1.symm, (h.2 z hz).2.symm⟩⟩

/-- Closure membership at a point of an open set `W` reads the set only on `W`. -/
theorem mem_closure_iff_of_inter_eq {A B W : Set ℂ} (hW : IsOpen W) {x : ℂ} (hx : x ∈ W) (h : A ∩ W = B ∩ W) :
    x ∈ closure A ↔ x ∈ closure B := by
  have key : ∀ {A : Set ℂ}, x ∈ closure A ↔ x ∈ closure (A ∩ W) := fun {A} =>
    ⟨fun hA => by have := hW.inter_closure ⟨hx, hA⟩; rwa [inter_comm] at this,
      fun h' => closure_mono inter_subset_left h'⟩
  rw [key, h, ← key]

/-! ## Locality: two maps agreeing on an open set -/

section Locality

variable {M F : ArcMap k} {W : Set ℂ}

/-- Two maps agreeing on `W` have the same colour classes on `W`. -/
theorem region_inter_eq_of_agreesOn (h : M.AgreesOff F Wᶜ) (j : Fin k) : M.region j ∩ W = F.region j ∩ W := by
  ext z
  simp only [region, mem_inter_iff, mem_preimage, mem_singleton_iff]
  constructor
  · rintro ⟨⟨hzi, hzc⟩, hzW⟩
    obtain ⟨h1, h2⟩ := h.2 z fun hc => hc hzW
    exact ⟨⟨h1.mpr hzi, h2.trans hzc⟩, hzW⟩
  · rintro ⟨⟨hzi, hzc⟩, hzW⟩
    obtain ⟨h1, h2⟩ := h.2 z fun hc => hc hzW
    exact ⟨⟨h1.mp hzi, h2.symm.trans hzc⟩, hzW⟩

/-- **The colours at a point are read near it.** -/
theorem coloursAt_eq_of_agreesOn (h : M.AgreesOff F Wᶜ) (hW : IsOpen W) {x : ℂ} (hx : x ∈ W) :
    M.coloursAt x = F.coloursAt x := by
  ext j
  exact mem_closure_iff_of_inter_eq hW hx (region_inter_eq_of_agreesOn h j)

/-- **Ring arcs are read near them** (`Γ` on a compact arc inside `W`). -/
theorem onRingArc_iff_of_agreesOn (h : M.AgreesOff F Wᶜ) (hW : IsOpen W) {p x : ℂ} {θ₁ θ₂ : ℝ}
    (hsub : ringArc p θ₁ θ₂ ⊆ W) : ringArc p θ₁ θ₂ ⊆ M.Γ ↔ ringArc p θ₁ θ₂ ⊆ F.Γ := by
  -- `W`'s openness and the point `x` are not needed: `Γ` is read pointwise
  have _ := hW; have _ := x
  constructor <;> intro hΓ z hz <;> have hz' := hΓ hz <;> rw [mem_Γ_iff] at hz' ⊢
  · exact ⟨h.1 ▸ hz'.1, fun hzI => hz'.2 ((h.2 z fun hc => hc (hsub hz)).1.mp hzI)⟩
  · exact ⟨h.1.symm ▸ hz'.1, fun hzI => hz'.2 ((h.2 z fun hc => hc (hsub hz)).1.mpr hzI)⟩

/-- Two maps agreeing on `W` have the same interior points in each subset of `W`. -/
theorem interiorPts_inter_eq_of_agreesOn (h : M.AgreesOff F Wᶜ) {U : Set ℂ} (hU : U ⊆ W) :
    M.interiorPts ∩ U = F.interiorPts ∩ U := by
  ext z
  constructor
  · rintro ⟨hz, hzU⟩; exact ⟨(h.2 z fun hc => hc (hU hzU)).1.mpr hz, hzU⟩
  · rintro ⟨hz, hzU⟩; exact ⟨(h.2 z fun hc => hc (hU hzU)).1.mp hz, hzU⟩

/-- Closure membership in a colour class cut by any set, at a point of the open set `W`, is read on `W`. -/
theorem mem_closure_region_inter_iff (h : M.AgreesOff F Wᶜ) (hW : IsOpen W) {x : ℂ} (hx : x ∈ W) (j : Fin k)
    (A : Set ℂ) : x ∈ closure (M.region j ∩ A) ↔ x ∈ closure (F.region j ∩ A) := by
  refine mem_closure_iff_of_inter_eq hW hx ?_
  rw [inter_right_comm, region_inter_eq_of_agreesOn h, inter_right_comm]

/-- **Sectors are read in their ball.** -/
theorem isSector_iff_of_agreesOn (h : M.AgreesOff F Wᶜ) {v : ℂ} {r : ℝ} (hr : ball v r ⊆ W) {S : Set ℂ} :
    M.IsSector v r S ↔ F.IsSector v r S := by
  unfold IsSector
  rw [interiorPts_inter_eq_of_agreesOn h hr]

/-- A sector lies in its ball. -/
theorem IsSector.subset_ball {G : ArcMap k} {v : ℂ} {r : ℝ} {S : Set ℂ} (hS : G.IsSector v r S) : S ⊆ ball v r := by
  obtain ⟨x, -, rfl, -⟩ := hS
  exact (connectedComponentIn_subset _ _).trans inter_subset_right

/-- **The sectors of one colour are read in their ball.** -/
theorem sectorsOf_eq_of_agreesOn (h : M.AgreesOff F Wᶜ) {v : ℂ} {r : ℝ} (hr : ball v r ⊆ W) (c : Fin k) :
    M.sectorsOf v r c = F.sectorsOf v r c := by
  ext S
  simp only [sectorsOf, mem_setOf_eq]
  constructor
  · rintro ⟨hS, hc⟩
    refine ⟨(isSector_iff_of_agreesOn h hr).mp hS, fun z hz => ?_⟩
    have := hc hz
    simp only [mem_preimage, mem_singleton_iff] at this ⊢
    rw [← this]; exact (h.2 z fun hc' => hc' (hr (hS.subset_ball hz))).2
  · rintro ⟨hS, hc⟩
    refine ⟨(isSector_iff_of_agreesOn h hr).mpr hS, fun z hz => ?_⟩
    have := hc hz
    simp only [mem_preimage, mem_singleton_iff] at this ⊢
    rw [← this]; exact (h.2 z fun hc' => hc' (hr (hS.subset_ball hz))).2.symm

/-- Small radii: eventually in `𝓝[>] 0`, the ball of radius `r` about `v` lies in `W` (given `B̄(v, 3) ⊆ W`). -/
theorem eventually_ball_subset {v : ℂ} (hv : closedBall v 3 ⊆ W) : ∀ᶠ r in 𝓝[>] (0 : ℝ), ball v r ⊆ W ∧ r < 1 := by
  filter_upwards [Ioo_mem_nhdsGT (show (0 : ℝ) < 1 by norm_num)] with r hr
  exact ⟨(ball_subset_closedBall.trans (closedBall_subset_closedBall (by linarith [hr.2]))).trans hv, hr.2⟩

/-- **`s_c(v)` is read near `v`.** -/
theorem hasSectors_iff_of_agreesOn (h : M.AgreesOff F Wᶜ) {v : ℂ} (hv : closedBall v 3 ⊆ W) (c : Fin k) (n : ℕ) :
    M.HasSectors v c n ↔ F.HasSectors v c n := by
  refine eventually_congr ?_
  filter_upwards [eventually_ball_subset hv] with r hr
  rw [sectorsOf_eq_of_agreesOn h hr.1]

/-- **A repeated colour is read near `v`.** -/
theorem hasRepeatedColour_iff_of_agreesOn (h : M.AgreesOff F Wᶜ) {v : ℂ} (hv : closedBall v 3 ⊆ W) :
    M.HasRepeatedColour v ↔ F.HasRepeatedColour v := by
  refine exists_congr fun c => eventually_congr ?_
  filter_upwards [eventually_ball_subset hv] with r hr
  rw [sectorsOf_eq_of_agreesOn h hr.1]

/-- A horn set lies in its ball. -/
theorem hornSet_subset_ball (v : ℂ) (α κ₁ κ₂ r : ℝ) : hornSet v α κ₁ κ₂ r ⊆ ball v r := fun _ hz => hz.1

/-- **Horns are read near `v`.** -/
theorem isHorn_iff_of_agreesOn (h : M.AgreesOff F Wᶜ) {v : ℂ} (hv : closedBall v 3 ⊆ W) (α κ₁ κ₂ : ℝ) (c : Fin k) :
    M.IsHorn v α κ₁ κ₂ c ↔ F.IsHorn v α κ₁ κ₂ c := by
  refine and_congr_right fun _ => eventually_congr ?_
  filter_upwards [eventually_ball_subset hv] with r hr
  refine and_congr (isSector_iff_of_agreesOn h hr.1) ⟨fun hc z hz => ?_, fun hc z hz => ?_⟩
  · have := hc hz
    simp only [mem_preimage, mem_singleton_iff] at this ⊢
    rw [← this]; exact (h.2 z fun hc' => hc' (hr.1 (hornSet_subset_ball _ _ _ _ _ hz))).2
  · have := hc hz
    simp only [mem_preimage, mem_singleton_iff] at this ⊢
    rw [← this]; exact (h.2 z fun hc' => hc' (hr.1 (hornSet_subset_ball _ _ _ _ _ hz))).2.symm

/-- A set inside `W` lies in one map's colour class exactly when in the other's. -/
theorem subset_region_iff_of_agreesOn (h : M.AgreesOff F Wᶜ) {A : Set ℂ} (hA : A ⊆ W) (j : Fin k) :
    A ⊆ M.region j ↔ A ⊆ F.region j := by
  constructor <;> intro hsub z hz
  · have : z ∈ M.region j ∩ W := ⟨hsub hz, hA hz⟩
    rw [region_inter_eq_of_agreesOn h] at this; exact this.1
  · have : z ∈ F.region j ∩ W := ⟨hsub hz, hA hz⟩
    rw [← region_inter_eq_of_agreesOn h] at this; exact this.1

/-- **Flanks are read near `v`.** -/
theorem isFlankAbove_iff_of_agreesOn (h : M.AgreesOff F Wᶜ) {v : ℂ} (hv : closedBall v 3 ⊆ W) (α κ₂ : ℝ) (g : Fin k) :
    M.IsFlankAbove v α κ₂ g ↔ F.IsFlankAbove v α κ₂ g := by
  refine exists_congr fun κ' => and_congr_right fun _ => eventually_congr ?_
  filter_upwards [eventually_ball_subset hv] with r hr
  exact subset_region_iff_of_agreesOn h ((hornSet_subset_ball _ _ _ _ _).trans hr.1) g

theorem isFlankBelow_iff_of_agreesOn (h : M.AgreesOff F Wᶜ) {v : ℂ} (hv : closedBall v 3 ⊆ W) (α κ₁ : ℝ) (g : Fin k) :
    M.IsFlankBelow v α κ₁ g ↔ F.IsFlankBelow v α κ₁ g := by
  refine exists_congr fun κ' => and_congr_right fun _ => eventually_congr ?_
  filter_upwards [eventually_ball_subset hv] with r hr
  exact subset_region_iff_of_agreesOn h ((hornSet_subset_ball _ _ _ _ _).trans hr.1) g

/-- **Clearness at a point of `B(v, 1)` is read in `B̄(v, 2)`.** -/
theorem isClear_iff_of_agreesOn (h : M.AgreesOff F Wᶜ) {v z : ℂ} (hv : closedBall v 3 ⊆ W) (hz : z ∈ ball v 1)
    (g : Fin k) : M.IsClear g z ↔ F.IsClear g z := by
  have hW : ∀ y, dist z y = 1 → y ∈ W := fun y hy => hv (by
    rw [mem_closedBall]; rw [mem_ball] at hz
    linarith [dist_triangle y z v, dist_comm y z])
  constructor <;> intro hc y hy hyz
  · have : y ∈ F.region g ∩ W := ⟨hy, hW y hyz⟩
    rw [← region_inter_eq_of_agreesOn h] at this; exact hc y this.1 hyz
  · have : y ∈ M.region g ∩ W := ⟨hy, hW y hyz⟩
    rw [region_inter_eq_of_agreesOn h] at this; exact hc y this.1 hyz

/-- **Tiles near `W`'s core are shared** (validity: a tile lies in the unit disc about each point of its closure). -/
theorem isTile_of_agreesOn (hM : M.Valid) (hF : F.Valid) (h : M.AgreesOff F Wᶜ) {T : Set ℂ} (hT : M.IsTile T) {x : ℂ}
    (hx : x ∈ closure T) (hxW : ball x 1 ⊆ W) : F.IsTile T := by
  have hTW : T ⊆ W := (hT.subset_ball hM hx).trans hxW
  have hTF : T ⊆ F.interiorPts := fun z hz => by
    have : z ∈ M.interiorPts ∩ W := ⟨hT.subset_interiorPts hz, hTW hz⟩
    rw [interiorPts_inter_eq_of_agreesOn h subset_rfl] at this; exact this.1
  obtain ⟨y, hy⟩ := hT.nonempty
  have hTy : T = connectedComponentIn M.interiorPts y := by
    obtain ⟨y', -, hTeq⟩ := hT
    rw [hTeq] at hy ⊢; exact connectedComponentIn_eq hy
  have hT' : F.IsTile (connectedComponentIn F.interiorPts y) := ⟨y, hTF hy, rfl⟩
  have h1 : T ⊆ connectedComponentIn F.interiorPts y := hT.isPreconnected.subset_connectedComponentIn hy hTF
  have h2 : connectedComponentIn F.interiorPts y ⊆ T := by
    have hsubW : connectedComponentIn F.interiorPts y ⊆ W := (hT'.subset_ball hF (closure_mono h1 hx)).trans hxW
    have hsubM : connectedComponentIn F.interiorPts y ⊆ M.interiorPts := fun z hz => by
      have : z ∈ F.interiorPts ∩ W := ⟨hT'.subset_interiorPts hz, hsubW hz⟩
      rw [← interiorPts_inter_eq_of_agreesOn h subset_rfl] at this; exact this.1
    rw [hTy]
    exact isPreconnected_connectedComponentIn.subset_connectedComponentIn (mem_connectedComponentIn (hTF hy)) hsubM
  rw [Subset.antisymm h1 h2]; exact hT'

/-- **Tiles of one colour near `W`'s core are shared.** -/
theorem tileOf_iff_of_agreesOn (hM : M.Valid) (hF : F.Valid) (h : M.AgreesOff F Wᶜ) {T : Set ℂ} {x : ℂ}
    (hx : x ∈ closure T) (hxW : ball x 1 ⊆ W) (c : Fin k) : M.TileOf c T ↔ F.TileOf c T := by
  have key : ∀ {G G' : ArcMap k}, G.Valid → G'.Valid → G.AgreesOff G' Wᶜ → G.TileOf c T → G'.TileOf c T := by
    intro G G' hG hG' hGG' ⟨hT, hc⟩
    refine ⟨isTile_of_agreesOn hG hG' hGG' hT hx hxW, fun z hz => ?_⟩
    have := hc hz
    simp only [mem_preimage, mem_singleton_iff] at this ⊢
    rw [← this]
    exact (hGG'.2 z fun hc' => hc' (hxW (hT.subset_ball hG hx hz))).2
  exact ⟨key hM hF h, key hF hM h.symm⟩

/-- **In- and out-type at a contact are read in `B(v, 2)`** (valid maps). -/
theorem inType_iff_of_agreesOn (hM : M.Valid) (hF : F.Valid) (h : M.AgreesOff F Wᶜ) {v w : ℂ}
    (hv : closedBall v 3 ⊆ W) (hw : dist w v = 1) (c : Fin k) :
    (M.InType v c w ↔ F.InType v c w) ∧ (M.OutType v c w ↔ F.OutType v c w) := by
  have hwW : ball w 1 ⊆ W := fun y hy => hv (by
    rw [mem_closedBall]; rw [mem_ball] at hy; linarith [dist_triangle y w v])
  refine ⟨⟨fun hin T hT hwT => hin T ((tileOf_iff_of_agreesOn hM hF h hwT hwW c).mpr hT) hwT,
    fun hin T hT hwT => hin T ((tileOf_iff_of_agreesOn hM hF h hwT hwW c).mp hT) hwT⟩,
    ⟨fun hout T hT hwT => hout T ((tileOf_iff_of_agreesOn hM hF h hwT hwW c).mpr hT) hwT,
    fun hout T hT hwT => hout T ((tileOf_iff_of_agreesOn hM hF h hwT hwW c).mp hT) hwT⟩⟩

/-- **The allowed cone is read in `B̄(v, 3)`** (valid maps). -/
theorem allowedCone_eq_of_agreesOn (hM : M.Valid) (hF : F.Valid) (h : M.AgreesOff F Wᶜ) (hW : IsOpen W) {v : ℂ}
    (hv : closedBall v 3 ⊆ W) (c : Fin k) : M.allowedCone v c = F.allowedCone v c := by
  have hvW : v ∈ W := hv (mem_closedBall_self (by norm_num))
  have hcont : ∀ w, M.IsContact v c w ↔ F.IsContact v c w := by
    intro w
    unfold IsContact
    refine and_congr (by rw [coloursAt_eq_of_agreesOn h hW hvW]) (and_congr_right fun hw => ?_)
    have hwW : w ∈ W := hv (by rw [mem_closedBall, hw]; norm_num)
    exact mem_closure_iff_of_inter_eq hW hwW (region_inter_eq_of_agreesOn h c)
  ext d
  simp only [allowedCone, mem_setOf_eq]
  refine forall_congr' fun w => ?_
  rw [hcont w]
  refine imp_congr_right fun hw => ?_
  obtain ⟨hin, hout⟩ := inType_iff_of_agreesOn hM hF h hv hw.2.1 c
  rw [hin, hout]

/-- **MERGE's availability is read in `B̄(v, 3)`** (valid maps: in- and out-type through the tile dichotomy at a carried colour). -/
theorem mergeAvailable_iff_of_agreesOn (hM : M.Valid) (hF : F.Valid) (h : M.AgreesOff F Wᶜ) (hW : IsOpen W) {v : ℂ}
    (hv : closedBall v 3 ⊆ W) : M.MergeAvailable v ↔ F.MergeAvailable v := by
  unfold MergeAvailable
  refine exists_congr fun c => exists_congr fun n => and_congr_right fun _ => ?_
  rw [hasSectors_iff_of_agreesOn h hv c n, allowedCone_eq_of_agreesOn hM hF h hW hv c]

/-- **MERGE-RAY's availability is read near `v`** (horns only). -/
theorem rayAvailable_iff_of_agreesOn (h : M.AgreesOff F Wᶜ) (hW : IsOpen W) {v : ℂ} (hv : closedBall v 3 ⊆ W) :
    M.RayAvailable v ↔ F.RayAvailable v := by
  have _ := hW
  unfold RayAvailable
  simp only [isHorn_iff_of_agreesOn h hv]

/-- **SHAVE's availability is read in `B̄(v, 3)`** (horns, flanks, and clearness on unit circles about points near `v`). -/
theorem shaveAvailable_iff_of_agreesOn (h : M.AgreesOff F Wᶜ) (hW : IsOpen W) {v : ℂ} (hv : closedBall v 3 ⊆ W) :
    M.ShaveAvailable v ↔ F.ShaveAvailable v := by
  have _ := hW
  unfold ShaveAvailable
  simp only [isHorn_iff_of_agreesOn h hv, isFlankAbove_iff_of_agreesOn h hv, isFlankBelow_iff_of_agreesOn h hv]
  refine exists_congr fun c => exists_congr fun g => exists_congr fun hh => exists_congr fun α =>
    exists_congr fun κ₁ => exists_congr fun κ₂ => exists_congr fun σ => and_congr_right fun _ =>
    and_congr_right fun _ => and_congr_right fun _ => and_congr_right fun _ => and_congr_right fun _ =>
    eventually_congr ?_
  filter_upwards [eventually_ball_subset hv] with r hr
  refine forall₂_congr fun z hz => ?_
  have hz1 : z ∈ ball v 1 := ball_subset_ball hr.2.le (hornSet_subset_ball _ _ _ _ _ hz)
  rw [isClear_iff_of_agreesOn h hv hz1, isClear_iff_of_agreesOn h hv hz1]

/-- **Ring arcs with their sides are read near the ring** (`B̄(p, 3) ⊆ W`). -/
theorem isRingArc_iff_of_agreesOn (h : M.AgreesOff F Wᶜ) (hW : IsOpen W) {p : ℂ} (hp : closedBall p 3 ⊆ W)
    (θ₁ θ₂ : ℝ) (c c' : Fin k) : M.IsRingArc p θ₁ θ₂ c c' ↔ F.IsRingArc p θ₁ θ₂ c c' := by
  have hpt : ∀ θ, ringPt p θ ∈ W := fun θ => hp (by rw [mem_closedBall, dist_ringPt]; norm_num)
  have hring : ringArc p θ₁ θ₂ ⊆ W := by
    rintro _ ⟨θ, -, rfl⟩; exact hpt θ
  unfold IsRingArc
  rw [onRingArc_iff_of_agreesOn h hW (x := p) hring]
  refine and_congr_right fun _ => and_congr_right fun _ => forall₂_congr fun θ _ => ?_
  have hin : M.innerColours p (ringPt p θ) = F.innerColours p (ringPt p θ) := by
    ext j; exact mem_closure_region_inter_iff h hW (hpt θ) j _
  have hout : M.outerColours p (ringPt p θ) = F.outerColours p (ringPt p θ) := by
    ext j; simp only [outerColours, mem_setOf_eq, Set.sdiff_eq]; exact mem_closure_region_inter_iff h hW (hpt θ) j _
  rw [hin, hout]

/-- **(Q) arcs are read near the ring.** -/
theorem isQArc_iff_of_agreesOn (h : M.AgreesOff F Wᶜ) (hW : IsOpen W) {p : ℂ} (hp : closedBall p 3 ⊆ W)
    (θ₁ θ₂ : ℝ) : M.IsQArc p θ₁ θ₂ ↔ F.IsQArc p θ₁ θ₂ := by
  have hpW : p ∈ W := hp (mem_closedBall_self (by norm_num))
  unfold IsQArc
  simp only [isRingArc_iff_of_agreesOn h hW hp, coloursAt_eq_of_agreesOn h hW hpW]

/-- **(R2) arcs are read in `B̄(p, 3)`** (the radius-2 witness at distance `2`). -/
theorem isR2Arc_iff_of_agreesOn (h : M.AgreesOff F Wᶜ) (hW : IsOpen W) {p : ℂ} (hp : closedBall p 3 ⊆ W)
    (θ₁ θ₂ : ℝ) : M.IsR2Arc p θ₁ θ₂ ↔ F.IsR2Arc p θ₁ θ₂ := by
  have hpW : p ∈ W := hp (mem_closedBall_self (by norm_num))
  have h2 : radiusTwoArc p θ₁ θ₂ ⊆ W := by
    rintro _ ⟨θ, -, rfl⟩
    refine hp ?_
    rw [mem_closedBall, dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e]; norm_num
  unfold IsR2Arc
  simp only [isRingArc_iff_of_agreesOn h hW hp, coloursAt_eq_of_agreesOn h hW hpW]
  refine exists₂_congr fun c c' => and_congr_right fun _ => and_congr_right fun _ => and_congr_right fun _ => ?_
  constructor <;> intro hsub z hz
  · exact (mem_closure_iff_of_inter_eq hW (h2 hz) (region_inter_eq_of_agreesOn h c)).mp (hsub hz)
  · exact (mem_closure_iff_of_inter_eq hW (h2 hz) (region_inter_eq_of_agreesOn h c)).mpr (hsub hz)

/-- **The ring arcs about `P` and their (Q)/(R2) kinds are read in `B̄(P, 3)`** (sides, colours at `P`, the radius-2 witness). -/
theorem qrAt_iff_of_agreesOn (h : M.AgreesOff F Wᶜ) (hW : IsOpen W) {P : ℂ} (hP : closedBall P 3 ⊆ W) :
    (∀ θ₁ θ₂ c c', M.IsRingArc P θ₁ θ₂ c c' → M.IsQArc P θ₁ θ₂ ∨ M.IsR2Arc P θ₁ θ₂) ↔
      (∀ θ₁ θ₂ c c', F.IsRingArc P θ₁ θ₂ c c' → F.IsQArc P θ₁ θ₂ ∨ F.IsR2Arc P θ₁ θ₂) := by
  simp only [isRingArc_iff_of_agreesOn h hW hP, isQArc_iff_of_agreesOn h hW hP, isR2Arc_iff_of_agreesOn h hW hP]

end Locality

/-! ## Local steps -/

/-- **A local step on `U`**: `F'` agrees with `F` off `U`, keeps every arc of `F` that misses `U` (as the same arc), and each of its
new arcs lies in `U` or inside an arc of `F` meeting `U` (a piece of an arc the step cut). -/
structure LocalStep (F F' : ArcMap k) (U : Set ℂ) : Prop where
  /-- The same domain; off `U`, the same interior points and colours. -/
  agreesOff : F'.AgreesOff F U
  /-- An arc missing `U` is kept. -/
  keep : ∀ a ∈ F.arcs, Disjoint a.carrier U → a ∈ F'.arcs
  /-- A new arc lies in `U`, or inside an arc of `F` that meets `U`. -/
  new : ∀ b ∈ F'.arcs, b ∉ F.arcs → b.carrier ⊆ U ∨ ∃ a ∈ F.arcs, (a.carrier ∩ U).Nonempty ∧ b.carrier ⊆ a.carrier

/-- The idle step (the procedure's step once nothing is left to do), on any set. -/
theorem LocalStep.refl (F : ArcMap k) (U : Set ℂ) : LocalStep F F U :=
  ⟨⟨rfl, fun _ _ => ⟨Iff.rfl, rfl⟩⟩, fun _ h _ => h, fun _ h h' => absurd h h'⟩

/-- A step on a smaller set is a step on a larger one. -/
theorem LocalStep.mono {F F' : ArcMap k} {U V : Set ℂ} (h : LocalStep F F' U) (hUV : U ⊆ V) : LocalStep F F' V where
  agreesOff := ⟨h.agreesOff.1, fun z hz => h.agreesOff.2 z fun hzU => hz (hUV hzU)⟩
  keep := fun a ha hd => h.keep a ha (hd.mono_right hUV)
  new := fun b hb hb' => (h.new b hb hb').imp (fun hsub => hsub.trans hUV)
    fun ⟨a, ha, hne, hsub⟩ => ⟨a, ha, hne.mono (inter_subset_inter_right _ hUV), hsub⟩

/-- **A locally finite sequence of local steps**: the maps `F n`, the compact supports `U n` forming a locally finite family, and
each `F (n + 1)` a local step from `F n` on `U n`. -/
structure LocalSeq (k : ℕ) where
  /-- The stages. -/
  F : ℕ → ArcMap k
  /-- The support of the step after stage `n`. -/
  U : ℕ → Set ℂ
  /-- Each step is local on its support. -/
  step : ∀ n, LocalStep (F n) (F (n + 1)) (U n)
  /-- The supports are compact. -/
  isCompact : ∀ n, IsCompact (U n)
  /-- The supports form a locally finite family. -/
  locallyFinite : LocallyFinite U

namespace LocalSeq

variable (S : LocalSeq k)

/-- The constant sequence (every step idle, on the empty set): the inhabitant of `LocalSeq`, every clause exercised. -/
def const (F : ArcMap k) : LocalSeq k where
  F := fun _ => F
  U := fun _ => ∅
  step := fun _ => LocalStep.refl F ∅
  isCompact := fun _ => isCompact_empty
  locallyFinite := fun _ => ⟨univ, univ_mem, by simp⟩

/-- Every stage has the initial domain. -/
theorem dom_eq (n : ℕ) : (S.F n).dom = (S.F 0).dom := by
  induction n with
  | zero => rfl
  | succ n ih => exact (S.step n).agreesOff.1.symm.trans ih

/-- Each point lies in finitely many supports: from some stage on, in none. -/
theorem exists_stab (z : ℂ) : ∃ N, ∀ n ≥ N, z ∉ S.U n := by
  obtain ⟨M, hM⟩ := (S.locallyFinite.point_finite z).bddAbove
  exact ⟨M + 1, fun n hn hz => absurd (hM hz) (by omega)⟩

/-- The stage after which no support holds `z`. -/
noncomputable def stab (z : ℂ) : ℕ := Classical.choose (S.exists_stab z)

theorem not_mem_U_of_stab_le {z : ℂ} {n : ℕ} (hn : S.stab z ≤ n) : z ∉ S.U n :=
  Classical.choose_spec (S.exists_stab z) n hn

/-- **Where a stage's arcs come from**: every arc of `F n` lies in an arc of `F 0` or in an earlier support. -/
theorem arc_origin : ∀ n, ∀ b ∈ (S.F n).arcs,
    (∃ a ∈ (S.F 0).arcs, b.carrier ⊆ a.carrier) ∨ ∃ m < n, b.carrier ⊆ S.U m := by
  intro n
  induction n with
  | zero => intro b hb; exact Or.inl ⟨b, hb, subset_rfl⟩
  | succ n ih =>
    intro b hb
    by_cases hbn : b ∈ (S.F n).arcs
    · exact (ih b hbn).imp id fun ⟨m, hm, h⟩ => ⟨m, by omega, h⟩
    · rcases (S.step n).new b hb hbn with h | ⟨a, ha, -, hba⟩
      · exact Or.inr ⟨n, by omega, h⟩
      · exact (ih a ha).imp (fun ⟨a₀, ha₀, h⟩ => ⟨a₀, ha₀, hba.trans h⟩) fun ⟨m, hm, h⟩ => ⟨m, by omega, hba.trans h⟩

/-- **The pivot: a compact part of the domain freezes.** Every arc of a stage lies in an arc of `F 0` or in an earlier support, so
the arcs that ever meet `K` lie in a compact set, which finitely many supports meet; after them the arcs meeting `K`, and the
interior points and colours on `K`, are those of one stage. -/
theorem frozen {K : Set ℂ} (hK : IsCompact K) (hKd : K ⊆ (S.F 0).dom) :
    ∃ N, ∀ n ≥ N, {a | a ∈ (S.F n).arcs ∧ (a.carrier ∩ K).Nonempty} = {a | a ∈ (S.F N).arcs ∧ (a.carrier ∩ K).Nonempty} ∧
      ∀ z ∈ K, (z ∈ (S.F n).interiorPts ↔ z ∈ (S.F N).interiorPts) ∧ (S.F n).col z = (S.F N).col z := by
  -- the arcs of `F 0` and the supports meeting `K`: finitely many, inside one compact `K'`
  set A := {a | a ∈ (S.F 0).arcs ∧ (a.carrier ∩ K).Nonempty} with hA
  set I := {m | (S.U m ∩ K).Nonempty} with hI
  have hAf : A.Finite := (S.F 0).finite_arcs_inter_compact hK hKd
  have hIf : I.Finite := S.locallyFinite.finite_nonempty_inter_compact hK
  set K' := (⋃ a ∈ A, a.carrier) ∪ ⋃ m ∈ I, S.U m with hK'
  have hK'c : IsCompact K' :=
    (hAf.isCompact_biUnion fun a _ => a.isCompact_carrier).union (hIf.isCompact_biUnion fun m _ => S.isCompact m)
  obtain ⟨N, hN⟩ := (S.locallyFinite.finite_nonempty_inter_compact hK'c).bddAbove
  -- an arc of any stage meeting `K` lies in `K'`
  have hsub : ∀ n, ∀ b ∈ (S.F n).arcs, (b.carrier ∩ K).Nonempty → b.carrier ⊆ K' := by
    intro n b hb hne
    rcases S.arc_origin n b hb with ⟨a, ha, hba⟩ | ⟨m, -, hbm⟩
    · refine hba.trans (subset_union_of_subset_left ?_ _)
      exact subset_biUnion_of_mem (u := fun a : Arc => a.carrier) (show a ∈ A from
        ⟨ha, hne.mono (inter_subset_inter_left _ hba)⟩)
    · refine hbm.trans (subset_union_of_subset_right ?_ _)
      exact subset_biUnion_of_mem (u := S.U) (show m ∈ I from hne.mono (inter_subset_inter_left _ hbm))
  -- past `N` the supports miss `K'`, hence `K`
  have hmiss : ∀ n, N < n → Disjoint (S.U n) K' := fun n hn =>
    disjoint_iff_inter_eq_empty.mpr (not_nonempty_iff_eq_empty.mp fun h => absurd (hN h) (by omega))
  have hmissK : ∀ n, N < n → Disjoint (S.U n) K := by
    intro n hn
    refine disjoint_left.mpr fun z hzU hzK => ?_
    have hzK' : z ∈ K' := subset_union_of_subset_right (subset_biUnion_of_mem (u := S.U) (show n ∈ I from
      ⟨z, hzU, hzK⟩)) _ hzU
    exact disjoint_left.mp (hmiss n hn) hzU hzK'
  -- one step past `N` changes nothing on `K`
  have hstep : ∀ n, N < n → {a | a ∈ (S.F (n + 1)).arcs ∧ (a.carrier ∩ K).Nonempty} =
      {a | a ∈ (S.F n).arcs ∧ (a.carrier ∩ K).Nonempty} ∧
      ∀ z ∈ K, (z ∈ (S.F (n + 1)).interiorPts ↔ z ∈ (S.F n).interiorPts) ∧ (S.F (n + 1)).col z = (S.F n).col z := by
    intro n hn
    refine ⟨?_, fun z hz => ?_⟩
    swap
    · obtain ⟨h1, h2⟩ := (S.step n).agreesOff.2 z fun hzU => disjoint_left.mp (hmissK n hn) hzU hz
      exact ⟨h1.symm, h2.symm⟩
    ext b
    constructor
    · rintro ⟨hb, hne⟩
      by_cases hbn : b ∈ (S.F n).arcs
      · exact ⟨hbn, hne⟩
      · exfalso
        rcases (S.step n).new b hb hbn with hbU | ⟨a, ha, haU, hba⟩
        · obtain ⟨z, hzb, hzK⟩ := hne
          exact disjoint_left.mp (hmissK n hn) (hbU hzb) hzK
        · have haK' := hsub n a ha (hne.mono (inter_subset_inter_left _ hba))
          obtain ⟨z, hza, hzU⟩ := haU
          exact disjoint_left.mp (hmiss n hn) hzU (haK' hza)
    · rintro ⟨hb, hne⟩
      exact ⟨(S.step n).keep b hb ((hmiss n hn).symm.mono_left (hsub n b hb hne)), hne⟩
  refine ⟨N + 1, fun n hn => ?_⟩
  induction n, hn using Nat.le_induction with
  | base => exact ⟨rfl, fun z _ => ⟨Iff.rfl, rfl⟩⟩
  | succ n hn ih =>
    obtain ⟨h1, h2⟩ := hstep n (by omega)
    exact ⟨h1.trans ih.1, fun z hz => ⟨((h2 z hz).1).trans (ih.2 z hz).1, ((h2 z hz).2).trans (ih.2 z hz).2⟩⟩

/-- The limit's arcs: those present at every late enough stage. -/
def limitArcs : Set Arc := {a | ∀ᶠ n in atTop, a ∈ (S.F n).arcs}

/-- The limit's colour: read at `z`'s stable stage. -/
noncomputable def limitCol (z : ℂ) : Fin k := (S.F (S.stab z)).col z

theorem limitArcs_nondegenerate : ∀ a ∈ S.limitArcs, a.Nondegenerate := by
  intro a ha
  obtain ⟨N, hN⟩ := eventually_atTop.mp ha
  exact (S.F N).nondegenerate a (hN N le_rfl)

/-- Past a stage after which no support holds `z`, the stages agree at `z`. -/
theorem agree_of_not_mem {z : ℂ} {N : ℕ} (hz : ∀ n ≥ N, z ∉ S.U n) {n : ℕ} (hn : N ≤ n) :
    (z ∈ (S.F n).interiorPts ↔ z ∈ (S.F N).interiorPts) ∧ (S.F n).col z = (S.F N).col z := by
  induction n, hn using Nat.le_induction with
  | base => exact ⟨Iff.rfl, rfl⟩
  | succ n hn ih =>
    obtain ⟨h1, h2⟩ := (S.step n).agreesOff.2 z (hz n hn)
    exact ⟨h1.symm.trans ih.1, h2.symm.trans ih.2⟩

/-- The limit's colour is every late stage's. -/
theorem col_eq_limitCol {z : ℂ} {n : ℕ} (hn : S.stab z ≤ n) : (S.F n).col z = S.limitCol z :=
  (S.agree_of_not_mem (fun _ hm => S.not_mem_U_of_stab_le hm) hn).2

/-- Late supports miss a compact set. -/
theorem exists_disjoint_of_isCompact {t : Set ℂ} (ht : IsCompact t) : ∃ N, ∀ n ≥ N, Disjoint (S.U n) t := by
  obtain ⟨M, hM⟩ := (S.locallyFinite.finite_nonempty_inter_compact ht).bddAbove
  exact ⟨M + 1, fun n hn => disjoint_iff_inter_eq_empty.mpr
    (not_nonempty_iff_eq_empty.mp fun h => absurd (hM h) (by omega))⟩

/-- **The limit's arcs meeting a compact part of the domain are a late stage's.** -/
theorem limitArcs_inter_eq {K : Set ℂ} (hK : IsCompact K) (hKd : K ⊆ (S.F 0).dom) :
    ∃ N, ∀ n ≥ N, {a | a ∈ S.limitArcs ∧ (a.carrier ∩ K).Nonempty} =
      {a | a ∈ (S.F n).arcs ∧ (a.carrier ∩ K).Nonempty} := by
  obtain ⟨N, hN⟩ := S.frozen hK hKd
  refine ⟨N, fun n hn => ?_⟩
  rw [(hN n hn).1]
  ext a
  constructor
  · rintro ⟨ha, hne⟩
    obtain ⟨M, hM⟩ := eventually_atTop.mp ha
    have : a ∈ {a | a ∈ (S.F (max M N)).arcs ∧ (a.carrier ∩ K).Nonempty} := ⟨hM _ (le_max_left _ _), hne⟩
    rwa [(hN _ (le_max_right _ _)).1] at this
  · rintro ⟨ha, hne⟩
    refine ⟨eventually_atTop.mpr ⟨N, fun m hm => ?_⟩, hne⟩
    have : a ∈ {a | a ∈ (S.F m).arcs ∧ (a.carrier ∩ K).Nonempty} := by rw [(hN m hm).1]; exact ⟨ha, hne⟩
    exact this.1

/-- **A point is eventually interior to the limit exactly when it is interior to the stage** (`frozen` at `{z}`). -/
theorem eventually_mem_limitInterior_iff (z : ℂ) :
    ∀ᶠ n in atTop, (z ∈ (S.F 0).dom \ ⋃ a ∈ S.limitArcs, a.carrier ↔ z ∈ (S.F n).interiorPts) := by
  by_cases hz : z ∈ (S.F 0).dom
  · obtain ⟨N, hN⟩ := S.limitArcs_inter_eq isCompact_singleton (singleton_subset_iff.mpr hz)
    refine eventually_atTop.mpr ⟨N, fun n hn => ?_⟩
    have key : (z ∈ ⋃ a ∈ S.limitArcs, a.carrier) ↔ z ∈ ⋃ a ∈ (S.F n).arcs, a.carrier := by
      simp only [mem_iUnion₂, exists_prop]
      have h := hN n hn
      constructor
      · rintro ⟨a, ha, hza⟩
        have : a ∈ {a | a ∈ S.limitArcs ∧ (a.carrier ∩ {z}).Nonempty} := ⟨ha, z, hza, rfl⟩
        rw [h] at this
        exact ⟨a, this.1, hza⟩
      · rintro ⟨a, ha, hza⟩
        have : a ∈ {a | a ∈ (S.F n).arcs ∧ (a.carrier ∩ {z}).Nonempty} := ⟨ha, z, hza, rfl⟩
        rw [← h] at this
        exact ⟨a, this.1, hza⟩
    show z ∈ (S.F 0).dom \ _ ↔ z ∈ (S.F n).dom \ _
    rw [S.dom_eq n, Set.mem_sdiff, Set.mem_sdiff, key]
  · refine Eventually.of_forall fun n => iff_of_false (fun h => hz h.1) fun h => hz ?_
    rw [← S.dom_eq n]; exact h.1

/-- **The limit agrees with every stage past the supports meeting `t`, on `t`** (the interior points as the limit will have them). -/
theorem agreesOn_of_disjoint {t : Set ℂ} {N : ℕ} (ht : ∀ n ≥ N, Disjoint (S.U n) t) {n : ℕ} (hn : N ≤ n) {z : ℂ}
    (hz : z ∈ t) :
    (z ∈ (S.F 0).dom \ ⋃ a ∈ S.limitArcs, a.carrier ↔ z ∈ (S.F n).interiorPts) ∧ S.limitCol z = (S.F n).col z := by
  have hzU : ∀ m ≥ N, z ∉ S.U m := fun m hm hzm => disjoint_left.mp (ht m hm) hzm hz
  obtain ⟨M, hM⟩ := eventually_atTop.mp (S.eventually_mem_limitInterior_iff z)
  have hm1 : N ≤ max (max M N) (max n (S.stab z)) := le_max_of_le_left (le_max_right _ _)
  have hm2 : M ≤ max (max M N) (max n (S.stab z)) := le_max_of_le_left (le_max_left _ _)
  have hm4 : S.stab z ≤ max (max M N) (max n (S.stab z)) := le_max_of_le_right (le_max_right _ _)
  obtain ⟨hmI, hmC⟩ := S.agree_of_not_mem hzU hm1
  obtain ⟨hnI, hnC⟩ := S.agree_of_not_mem hzU hn
  refine ⟨(hM _ hm2).trans (hmI.trans hnI.symm), ?_⟩
  rw [← S.col_eq_limitCol hm4, hmC, hnC]

/-- The limit's arcs are locally finite on the domain (`frozen` on a closed ball, and the frozen stage's local finiteness). -/
theorem limitArcs_locallyFinite :
    ∀ x ∈ (S.F 0).dom, ∃ t ∈ 𝓝 x, {a | a ∈ S.limitArcs ∧ (a.carrier ∩ t).Nonempty}.Finite := by
  intro x hx
  obtain ⟨r, hr, hrsub⟩ := Metric.isOpen_iff.mp (S.F 0).isOpen_dom x hx
  have hK : closedBall x (r / 2) ⊆ (S.F 0).dom := (closedBall_subset_ball (by linarith)).trans hrsub
  obtain ⟨N, hN⟩ := S.limitArcs_inter_eq (isCompact_closedBall x (r / 2)) hK
  refine ⟨closedBall x (r / 2), closedBall_mem_nhds x (by linarith), ?_⟩
  rw [hN N le_rfl]
  exact (S.F N).finite_arcs_inter_compact (isCompact_closedBall x _) (by rw [S.dom_eq N]; exact hK)

/-- The limit's colour is locally constant off its arcs (near `x` it is the frozen stage's). -/
theorem limitCol_locallyConstant :
    ∀ x ∈ (S.F 0).dom, x ∉ ⋃ a ∈ S.limitArcs, a.carrier → ∀ᶠ y in 𝓝 x, S.limitCol y = S.limitCol x := by
  intro x hx hxa
  obtain ⟨N, hN⟩ := S.exists_disjoint_of_isCompact (isCompact_closedBall x 1)
  have hx1 : x ∈ closedBall x 1 := mem_closedBall_self zero_le_one
  have hxI : x ∈ (S.F N).interiorPts := (S.agreesOn_of_disjoint hN le_rfl hx1).1.mp ⟨hx, hxa⟩
  filter_upwards [(S.F N).locallyConstant x hxI.1 hxI.2, closedBall_mem_nhds x one_pos] with y hy hyb
  rw [(S.agreesOn_of_disjoint hN le_rfl hyb).2, (S.agreesOn_of_disjoint hN le_rfl hx1).2, hy]

/-- **The limit map.** -/
noncomputable def limit : ArcMap k where
  dom := (S.F 0).dom
  isOpen_dom := (S.F 0).isOpen_dom
  arcs := S.limitArcs
  nondegenerate := S.limitArcs_nondegenerate
  locallyFinite := S.limitArcs_locallyFinite
  col := S.limitCol
  locallyConstant := S.limitCol_locallyConstant

@[simp] theorem limit_dom : S.limit.dom = (S.F 0).dom := rfl

/-- **The limit agrees with every late stage near a compact part of the domain**: some open `W ⊇ K` on which, from some stage on,
the limit and the stage have the same interior points and colours. -/
theorem eventually_agreesOn {K : Set ℂ} (hK : IsCompact K) (hKd : K ⊆ (S.F 0).dom) :
    ∃ W, IsOpen W ∧ K ⊆ W ∧ ∀ᶠ n in atTop, S.limit.AgreesOff (S.F n) Wᶜ := by
  -- `K ⊆ dom` is not needed: the late supports miss a compact neighbourhood of `K`, wherever it lies
  have _ := hKd
  obtain ⟨N, hN⟩ := S.exists_disjoint_of_isCompact (hK.cthickening (r := 1))
  refine ⟨thickening 1 K, isOpen_thickening, self_subset_thickening one_pos K, eventually_atTop.mpr ⟨N, fun n hn =>
    ⟨S.dom_eq n, fun z hz => ?_⟩⟩⟩
  have hzW : z ∈ thickening 1 K := by simpa using hz
  obtain ⟨h1, h2⟩ := S.agreesOn_of_disjoint hN hn (thickening_subset_cthickening 1 K hzW)
  exact ⟨h1.symm, h2.symm⟩

/-- **The limit agrees with a late stage near every point**: the late supports miss `B̄(x, 1)`. -/
theorem exists_agreesOn_ball (x : ℂ) : ∃ N, ∀ n ≥ N, S.limit.AgreesOff (S.F n) (ball x 1)ᶜ := by
  obtain ⟨N, hN⟩ := S.exists_disjoint_of_isCompact (isCompact_closedBall x 1)
  refine ⟨N, fun n hn => ⟨S.dom_eq n, fun z hz => ?_⟩⟩
  have hzW : z ∈ ball x 1 := by simpa using hz
  obtain ⟨h1, h2⟩ := S.agreesOn_of_disjoint hN hn (ball_subset_closedBall hzW)
  exact ⟨h1.symm, h2.symm⟩

/-- The limit of plane maps is a plane map. -/
theorem limit_isPlaneMap (h : (S.F 0).IsPlaneMap) : S.limit.IsPlaneMap := h

/-- **Validity passes to the limit**: a unit pair of the limit lies in a compact set where the limit is a valid stage. -/
theorem limit_valid (h : ∀ n, (S.F n).Valid) : S.limit.Valid := by
  intro x hx y hy hxy
  obtain ⟨N, hN⟩ := eventually_atTop.mp
    ((S.eventually_mem_limitInterior_iff x).and (S.eventually_mem_limitInterior_iff y))
  have hn1 : N ≤ max N (max (S.stab x) (S.stab y)) := le_max_left _ _
  have hn2 : S.stab x ≤ max N (max (S.stab x) (S.stab y)) := le_max_of_le_right (le_max_left _ _)
  have hn3 : S.stab y ≤ max N (max (S.stab x) (S.stab y)) := le_max_of_le_right (le_max_right _ _)
  have hx' := (hN _ hn1).1.mp hx
  have hy' := (hN _ hn1).2.mp hy
  show S.limitCol x ≠ S.limitCol y
  rw [← S.col_eq_limitCol hn2, ← S.col_eq_limitCol hn3]
  exact h _ x hx' y hy' hxy

/-- **`IsModification` passes to the limit**: a ring arc of the limit is compact, so a ring arc of a late stage; a point's colours
are a late stage's. -/
theorem limit_isModification (h : ∀ n, (S.F 0).IsModification (S.F n)) : (S.F 0).IsModification S.limit := by
  refine ⟨rfl, ?_, fun x hx => ?_⟩
  · rintro p x ⟨θ₁, θ₂, h12, hx, hsub⟩
    have hc : IsCompact (ringArc p θ₁ θ₂) := isCompact_Icc.image (by unfold ringPt e; fun_prop)
    obtain ⟨N, hN⟩ := S.exists_disjoint_of_isCompact hc
    refine (h N).ringArcsWithin p x ⟨θ₁, θ₂, h12, hx, fun z hz => ?_⟩
    have hzΓ := hsub hz
    rw [mem_Γ_iff] at hzΓ ⊢
    refine ⟨by rw [S.dom_eq N]; exact hzΓ.1, fun hzI => hzΓ.2 ?_⟩
    exact (S.agreesOn_of_disjoint hN le_rfl hz).1.mpr hzI
  · obtain ⟨N, hN⟩ := S.exists_agreesOn_ball x
    have heq := coloursAt_eq_of_agreesOn (hN N le_rfl) isOpen_ball (mem_ball_self one_pos)
    rw [heq] at hx ⊢
    exact (h N).coloursAt_subset x hx

end LocalSeq

/-! ## The limit is terminal when every late stage is terminal near every point -/

namespace LocalSeq

variable (S : LocalSeq k)

/-- **Terminality passes to the limit** if at each point, from some stage on, no move is available there and every ring arc about it
is (Q) or (R2) — the procedure's fairness, read pointwise. -/
theorem limit_isTerminalMap (hP : (S.F 0).IsPlaneMap) (hval : ∀ n, (S.F n).Valid)
    (hev : ∀ v, ∀ᶠ n in atTop, ¬ (S.F n).MergeAvailable v ∧ ¬ (S.F n).RayAvailable v ∧ ¬ (S.F n).ShaveAvailable v ∧
      ∀ θ₁ θ₂ c c', (S.F n).IsRingArc v θ₁ θ₂ c c' → (S.F n).IsQArc v θ₁ θ₂ ∨ (S.F n).IsR2Arc v θ₁ θ₂) :
    S.limit.IsTerminalMap := by
  have hlv := S.limit_valid hval
  have hK : ∀ v, closedBall v 3 ⊆ (S.F 0).dom := fun v => by rw [hP]; exact subset_univ _
  refine ⟨hlv, hP, fun v _ => ?_, fun P θ₁ θ₂ c c' hA => ?_⟩
  · obtain ⟨W, hWo, hKW, hag⟩ := S.eventually_agreesOn (isCompact_closedBall v 3) (hK v)
    obtain ⟨n, hn1, hm, hr, hs, -⟩ := (hag.and (hev v)).exists
    exact ⟨fun h => hm ((mergeAvailable_iff_of_agreesOn hlv (hval n) hn1 hWo hKW).mp h),
      fun h => hr ((rayAvailable_iff_of_agreesOn hn1 hWo hKW).mp h),
      fun h => hs ((shaveAvailable_iff_of_agreesOn hn1 hWo hKW).mp h)⟩
  · obtain ⟨W, hWo, hKW, hag⟩ := S.eventually_agreesOn (isCompact_closedBall P 3) (hK P)
    obtain ⟨n, hn1, -, -, -, hq⟩ := (hag.and (hev P)).exists
    exact (qrAt_iff_of_agreesOn hn1 hWo hKW).mpr hq θ₁ θ₂ c c' hA

end LocalSeq

/-! ## Clean maps and their sites -/

variable (F : ArcMap k)

/-- **A clean map**: every point of `Γ` carries at least two colours (no part of an arc has one colour on both sides). -/
def IsClean : Prop := ∀ x ∈ F.Γ, 2 ≤ (F.coloursAt x).ncard

/-- **A site**: a point of the domain with a repeated colour or a horn — the only points where MERGE, MERGE-RAY or SHAVE can be
available (`not_available_of_not_isSite`). -/
def IsSite (x : ℂ) : Prop := x ∈ F.dom ∧ (F.HasRepeatedColour x ∨ ∃ α κ₁ κ₂ c, F.IsHorn x α κ₁ κ₂ c)

variable {F}

/-- Off the sites no move is available (MERGE needs two sectors of one colour; MERGE-RAY and SHAVE need a horn). -/
theorem not_available_of_not_isSite {x : ℂ} (hx : x ∈ F.dom) (hs : ¬ F.IsSite x) :
    ¬ F.MergeAvailable x ∧ ¬ F.RayAvailable x ∧ ¬ F.ShaveAvailable x := by
  refine ⟨fun ⟨c, n, hn, hsec, _⟩ => hs ⟨hx, Or.inl ⟨c, hsec.mono fun r hr => ?_⟩⟩,
    fun ⟨c, α, κ₁, κ₂, _, _, _, h1, _⟩ => hs ⟨hx, Or.inr ⟨α, κ₁, κ₂, c, h1⟩⟩,
    fun ⟨c, _, _, α, κ₁, κ₂, _, h1, _⟩ => hs ⟨hx, Or.inr ⟨α, κ₁, κ₂, c, h1⟩⟩⟩
  rw [hr]; exact_mod_cast hn

/-- **A clean map's sites are isolated** (in a sector chart every point of the punctured ball is interior or on one branch with two
colours across it: one sector each side, no horn). -/
theorem IsClean.eventually_not_isSite (hc : F.IsClean) {x : ℂ} (hx : x ∈ F.dom) : ∀ᶠ y in 𝓝[≠] x, ¬ F.IsSite y := by
  sorry

/-- **Cleaning**: every valid map has a clean valid modification with the same colours at every point — the one-coloured parts of
`Γ` dropped (each arc replaced by its maximal sub-arcs of points of two or more colours), their points given the one colour around
them. -/
theorem exists_clean (hF : F.Valid) :
    ∃ F' : ArcMap k, F'.IsClean ∧ F'.Valid ∧ F.IsModification F' ∧ (∀ x, F'.coloursAt x = F.coloursAt x) ∧
      F'.Γ ⊆ F.Γ := by
  sorry

end ArcMap

/-! ### Spec examples -/

section Spec

open ArcMap

/-- The constant sequence's limit is its map's domain (a spec example for `LocalSeq.limit`). -/
example (F : ArcMap 2) : (LocalSeq.const F).limit.dom = F.dom := rfl

/-- Every stage of the constant sequence is its map (a spec example for `LocalSeq`). -/
example (F : ArcMap 2) : (LocalSeq.const F).F 5 = F := rfl

/-- The constant sequence's limit has no more arcs than its map (a spec example for `LocalSeq.limitArcs`). -/
example (F : ArcMap 2) : (LocalSeq.const F).limitArcs ⊆ F.arcs := fun _ ha => by
  obtain ⟨N, hN⟩ := eventually_atTop.mp ha
  exact hN N le_rfl

/-- The one-colour plane is clean: it has no arcs (a spec example for `IsClean`). -/
example (j : Fin 2) : (ArcMap.const univ isOpen_univ j).IsClean := by
  intro x hx
  simp [ArcMap.Γ, ArcMap.const] at hx

end Spec

end HadwigerNelson.Plane
