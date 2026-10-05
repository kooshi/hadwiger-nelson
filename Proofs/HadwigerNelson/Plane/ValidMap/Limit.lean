import Proofs.HadwigerNelson.Plane.ValidMap.Chain
import Proofs.HadwigerNelson.Plane.Tiles
import Proofs.HadwigerNelson.Plane.ValidMap.Sectors
import Proofs.HadwigerNelson.Plane.ValidMap.Contact

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

/-- **An arc's full curve does not depend on which of its points it is seen from.** -/
theorem _root_.HadwigerNelson.Plane.Arc.curve_eq_of_mem {a : Arc} {x y : ℂ} (hx : x ∈ a.carrier) (hy : y ∈ a.carrier) :
    a.curve x = a.curve y := by
  cases a with
  | seg u v =>
    have key : ∀ w ∈ segment ℝ u v, ((w - u) * (starRingEnd ℂ) (I * (v - u))).re = 0 := by
      intro w hw
      rw [segment_eq_image'] at hw
      obtain ⟨t, -, rfl⟩ := hw
      rw [add_sub_cancel_left, map_mul, Complex.conj_I, real_smul, mul_comm (-I), ← mul_assoc, mul_assoc (t : ℂ),
        Complex.mul_conj, ← Complex.ofReal_mul]
      simp
    ext z
    simp only [Arc.curve, Arc.curveData, curveAt, mem_setOf_eq, zero_mul]
    have h1 : ((z - x) * (starRingEnd ℂ) (I * (v - u))).re =
        ((z - u) * (starRingEnd ℂ) (I * (v - u))).re - ((x - u) * (starRingEnd ℂ) (I * (v - u))).re := by
      rw [← Complex.sub_re, ← sub_mul]; ring_nf
    have h2 : ((z - y) * (starRingEnd ℂ) (I * (v - u))).re =
        ((z - u) * (starRingEnd ℂ) (I * (v - u))).re - ((y - u) * (starRingEnd ℂ) (I * (v - u))).re := by
      rw [← Complex.sub_re, ← sub_mul]; ring_nf
    rw [h1, h2, key x hx, key y hy]
  | circ c ρ θ₀ θ₁ =>
    have key : ∀ w ∈ (Arc.circ c ρ θ₀ θ₁).carrier, ∀ z,
        (1 * Complex.normSq (z - w) = 2 * ((z - w) * (starRingEnd ℂ) (c - w)).re ↔ Complex.normSq (z - c) = ρ ^ 2) := by
      intro w hw z
      obtain ⟨θ, -, rfl⟩ := hw
      have hn : Complex.normSq (c - (c + ρ * e θ)) = ρ ^ 2 := by
        rw [sub_add_cancel_left, Complex.normSq_neg, Complex.normSq_mul, Complex.normSq_ofReal, Complex.normSq_eq_norm_sq,
          norm_e]; ring
      have hsub : Complex.normSq (z - c) = Complex.normSq (z - (c + ρ * e θ)) + Complex.normSq (c - (c + ρ * e θ)) -
          2 * ((z - (c + ρ * e θ)) * (starRingEnd ℂ) (c - (c + ρ * e θ))).re := by
        rw [← Complex.normSq_sub]; ring_nf
      rw [hsub, hn]; constructor <;> intro h <;> linarith
    ext z
    simp only [Arc.curve, Arc.curveData, curveAt, mem_setOf_eq]
    rw [key x hx z, key y hy z]

/-- A horn's cone at its base point has empty interior (it approaches along its axis only). -/
theorem interior_coneAt_hornSet_eq_empty (v : ℂ) (α κ₁ κ₂ r : ℝ) : interior (coneAt (hornSet v α κ₁ κ₂ r) v) = ∅ := by
  refine eq_empty_iff_forall_notMem.mpr fun t ht => ?_
  obtain ⟨U, hU, hUo, htU⟩ := mem_interior.mp ht
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp hUo t htU
  have h1 := e_eq_of_mem_coneAt_hornSet (hU htU)
  have h2 := e_eq_of_mem_coneAt_hornSet (hU (hball (show t + min ε 1 / 2 ∈ ball t ε by
    rw [mem_ball, Real.dist_eq, add_sub_cancel_left, abs_of_pos (by positivity)]
    linarith [min_le_left ε 1])))
  obtain ⟨m, hm⟩ := e_eq_e_iff.mp (h2.trans h1.symm)
  have hπ := Real.pi_pos
  have hm0 : min ε 1 / 2 = 2 * π * m := by linarith
  have hpos : 0 < min ε 1 / 2 := by positivity
  have hsmall : min ε 1 / 2 < 2 * π := by linarith [min_le_right ε 1, Real.two_le_pi]
  rcases lt_trichotomy m 0 with h | h | h
  · have : (m : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_iff.mpr h
    nlinarith
  · rw [h] at hm0; push_cast at hm0; linarith
  · have : (1 : ℝ) ≤ m := by exact_mod_cast h
    nlinarith

/-- **The germs at a point of `Γ` near a point `x` with a good radius lie on one curve**: at `y ∈ B(x, ρ₀)`, `y ≠ x`, on an arc
`a₀`, every germ of a chart at `y` is, at each small distance, one of the two germs of `a₀`'s curve. -/
theorem germ_eq_curveGerm_of_goodAt {F : ArcMap k} {x : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt x ρ₀) {y : ℂ} (hy : y ∈ ball x ρ₀) (hyx : y ≠ x)
    {a₀ : Arc} (ha₀ : a₀ ∈ F.arcs) (hya₀ : y ∈ a₀.carrier) {r₀ : ℝ} {n : ℕ} {G : BranchGerms n}
    (hC : F.IsSectorChart G y r₀) :
    ∃ ρ > 0, ∀ i, ∀ s ∈ Ioo 0 ρ, ∃ σ : ℝ, (σ = 1 ∨ σ = -1) ∧ branchPt y (G.β i) (G.κ i) s =
      branchPt y (curveGerm (a₀.curveData y).1 (a₀.curveData y).2 σ).1
        (curveGerm (a₀.curveData y).1 (a₀.curveData y).2 σ).2 s := by
  have hyd : y ∈ F.dom := hG.subdom hy
  obtain ⟨ρy, hGy⟩ := F.exists_goodAt hyd
  have hb := Arc.curveData_ne (F.nondegenerate a₀ ha₀) hya₀
  have hbn : 0 < ‖(a₀.curveData y).2‖ := norm_pos_iff.mpr hb
  have hκ : 0 ≤ (a₀.curveData y).1 ∧ (a₀.curveData y).1 ≤ 1 := by
    rcases Arc.curveData_kappa y a₀ with h | h <;> rw [h] <;> norm_num
  have hdx : 0 < dist y x := dist_pos.mpr hyx
  have hdρ : 0 < ρ₀ - dist y x := by rw [mem_ball] at hy; linarith
  set ρ := min (min r₀ ρy) (min (ρ₀ - dist y x) ‖(a₀.curveData y).2‖) with hρ
  have hρ0 : 0 < ρ := lt_min (lt_min hC.pos hGy.pos) (lt_min hdρ hbn)
  have hxa₀ : x ∈ a₀.carrier := hG.through a₀ ha₀ ⟨y, hya₀, hy⟩
  -- `Γ` near `y` lies on `a₀`'s curve
  have hΓ : ∀ z ∈ F.Γ, z ∈ ball y ρ → z ∈ a₀.curve y := by
    intro z hz hzb
    obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp hz.2
    have hzy : z ∈ ball y ρy := ball_subset_ball ((min_le_left _ _).trans (min_le_right _ _)) hzb
    have hzx : z ∈ ball x ρ₀ := by
      rw [mem_ball] at hzb ⊢
      have h1 : ρ ≤ ρ₀ - dist y x := (min_le_right _ _).trans (min_le_left _ _)
      linarith [dist_triangle z y x]
    have hya : y ∈ a.carrier := hGy.through a ha ⟨z, hza, hzy⟩
    have hxa : x ∈ a.carrier := hG.through a ha ⟨z, hza, hzx⟩
    have heq := hG.uniq a ha a₀ ha₀ ⟨z, hza, hzx⟩ ⟨y, hya₀, hy⟩ y hy hyx (Arc.carrier_subset_curve hxa hya)
      (Arc.carrier_subset_curve hxa₀ hya₀)
    rw [← Arc.curve_eq_of_mem hxa₀ hya₀, ← heq]
    exact Arc.carrier_subset_curve hxa hza
  refine ⟨ρ, hρ0, fun i s hs => ?_⟩
  have hsr₀ : s < r₀ := hs.2.trans_le ((min_le_left _ _).trans (min_le_left _ _))
  have hq : branchPt y (G.β i) (G.κ i) s ∈ (F.Γ ∩ ball y r₀) \ {y} := by
    rw [hC.branches]; exact mem_iUnion.mpr ⟨i, s, ⟨hs.1, hsr₀⟩, rfl⟩
  have hnorm := norm_branchPt_sub y (G.β i) (G.κ i) hs.1.le
  have hqb : branchPt y (G.β i) (G.κ i) s ∈ ball y ρ := by rw [mem_ball, dist_eq_norm, hnorm]; exact hs.2
  have hqc := hΓ _ hq.1.1 hqb
  have hsb : s < ‖(a₀.curveData y).2‖ := hs.2.trans_le ((min_le_right _ _).trans (min_le_right _ _))
  obtain ⟨σ, hσ, hqσ⟩ := exists_eq_branchPt_curveGerm hκ.1 hb hqc hq.2 (by
    rw [hnorm]; nlinarith [hκ.2, hs.1])
  rw [hnorm] at hqσ
  exact ⟨σ, hσ, hqσ⟩

/-! ## Clean maps and their sites -/

variable (F : ArcMap k)

/-- **A clean map**: every point of `Γ` carries at least two colours (no part of an arc has one colour on both sides). -/
def IsClean : Prop := ∀ x ∈ F.Γ, 2 ≤ (F.coloursAt x).ncard

/-- **A site**: a point of the domain with a repeated colour or a horn — the only points where MERGE, MERGE-RAY or SHAVE can be
available (`not_available_of_not_isSite`). -/
def IsSite (x : ℂ) : Prop := x ∈ F.dom ∧ (F.HasRepeatedColour x ∨ ∃ α κ₁ κ₂ c, F.IsHorn x α κ₁ κ₂ c)

variable {F}

/-- **Near a point with a good radius, a point of a clean map other than it is no site**: off `Γ` its one sector is the ball;
on `Γ` its germs are the two of the one curve through it (`germ_eq_curveGerm_of_goodAt`), in opposite directions, so it has
two sectors, of two colours (clean), neither a horn. -/
theorem not_isSite_of_goodAt {F : ArcMap k} (hc : F.IsClean) {x : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt x ρ₀) {y : ℂ}
    (hy : y ∈ ball x ρ₀) (hyx : y ≠ x) : ¬ F.IsSite y := by
  have hyd : y ∈ F.dom := hG.subdom hy
  obtain ⟨r₀, n, G, hC, hdisj⟩ := localSectors_disj F hyd
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  suffices key : ∀ r ∈ Ioc 0 r₀, (∀ S, F.IsSector y r S → (interior (coneAt S y)).Nonempty) ∧
      ∀ c, (F.sectorsOf y r c).encard ≤ 1 by
    rintro ⟨-, ⟨c, hrep⟩ | ⟨α, κ₁, κ₂, c, -, hH⟩⟩
    · obtain ⟨r, h2, hr⟩ := (hrep.and (Ioc_mem_nhdsGT hC.pos)).exists
      have := h2.trans ((key r hr).2 c)
      norm_num at this
    · obtain ⟨r, ⟨hS, -⟩, hr⟩ := (hH.and (Ioc_mem_nhdsGT hC.pos)).exists
      have := (key r hr).1 _ hS
      rw [interior_coneAt_hornSet_eq_empty] at this
      exact not_nonempty_empty this
  intro r hr
  rcases Nat.eq_zero_or_pos n with hn | hn
  · -- off `Γ`: the one sector is the ball
    refine ⟨fun S hS => ?_, fun c => ?_⟩
    · rw [(hC.isSector_iff_of_zero hn hr).mp hS, coneAt_ball_self y hr.1, interior_univ]; exact univ_nonempty
    · exact (encard_le_encard (show F.sectorsOf y r c ⊆ {ball y r} from fun S hS =>
        (hC.isSector_iff_of_zero hn hr).mp hS.1)).trans (by rw [encard_singleton])
  -- on `Γ`
  have hyΓ : y ∈ F.Γ := hC.mem_Γ.mpr hn
  obtain ⟨a₀, ha₀, hya₀⟩ := mem_iUnion₂.mp hyΓ.2
  obtain ⟨ρ, hρ, hgerm⟩ := germ_eq_curveGerm_of_goodAt hG hy hyx ha₀ hya₀ hC
  have hinj : ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 (min ρ r₀),
      branchPt y (G.β i) (G.κ i) s ≠ branchPt y (G.β j) (G.κ j) s := by
    intro i j hij s hs heq
    apply hdisj i j hij s ⟨hs.1, hs.2.trans_le (min_le_right _ _)⟩
    rw [branchPt_eq, branchPt_eq] at heq
    have hs0 : (s : ℂ) ≠ 0 := by exact_mod_cast hs.1.ne'
    exact mul_left_cancel₀ hs0 (add_left_cancel heq)
  have hgerm' : ∀ i, ∀ s ∈ Ioo 0 (min ρ r₀), ∃ σ : ℝ, (σ = 1 ∨ σ = -1) ∧ branchPt y (G.β i) (G.κ i) s =
      branchPt y (curveGerm (a₀.curveData y).1 (a₀.curveData y).2 σ).1
        (curveGerm (a₀.curveData y).1 (a₀.curveData y).2 σ).2 s :=
    fun i s hs => hgerm i s ⟨hs.1, hs.2.trans_le (min_le_left _ _)⟩
  have hmin : 0 < min ρ r₀ := lt_min hρ hC.pos
  -- at most two germs
  have hn2 : n ≤ 2 := by
    by_contra h3
    push Not at h3
    have hs₀ : min ρ r₀ / 2 ∈ Ioo 0 (min ρ r₀) := ⟨by positivity, by linarith⟩
    choose σ hσ hσeq using fun i : Fin n => hgerm' i _ hs₀
    have key3 : ∀ a b c : ℝ, (a = 1 ∨ a = -1) → (b = 1 ∨ b = -1) → (c = 1 ∨ c = -1) → a = b ∨ a = c ∨ b = c := by
      intro a b c ha hb hc
      rcases ha with rfl | rfl <;> rcases hb with rfl | rfl <;> rcases hc with rfl | rfl <;> norm_num
    have hpair : ∀ i j : Fin n, i ≠ j → σ i ≠ σ j := fun i j hij heq =>
      hinj i j hij _ hs₀ (by rw [hσeq i, hσeq j, heq])
    rcases key3 _ _ _ (hσ ⟨0, by omega⟩) (hσ ⟨1, by omega⟩) (hσ ⟨2, by omega⟩) with h | h | h
    · exact hpair _ _ (by simp [Fin.ext_iff]) h
    · exact hpair _ _ (by simp [Fin.ext_iff]) h
    · exact hpair _ _ (by simp [Fin.ext_iff]) h
  -- at least two (clean)
  have hn2' : n = 2 := by
    have h1 := hc y hyΓ
    have h2 := hC.ncard_coloursAt_le
    rcases le_total n 1 with h | h
    · rw [max_eq_right h] at h2; omega
    · rw [max_eq_left h] at h2; omega
  subst hn2'
  -- the two germs leave `y` in different directions
  set b := (a₀.curveData y).2 with hbdef
  have hdir : e (G.β 0) ≠ e (G.β 1) := by
    intro hβ
    have hf : Tendsto (fun s => ‖e (germDir (G.β 0) (G.κ 0) s) - e (germDir (G.β 1) (G.κ 1) s)‖) (𝓝 0) (𝓝 0) := by
      have hcont : Continuous (fun s => ‖e (germDir (G.β 0) (G.κ 0) s) - e (germDir (G.β 1) (G.κ 1) s)‖) := by
        unfold germDir e; fun_prop
      have := hcont.tendsto 0
      simpa [germDir_zero, hβ] using this
    set g₁ := curveGerm (a₀.curveData y).1 b 1 with hg₁
    set g₂ := curveGerm (a₀.curveData y).1 b (-1) with hg₂
    have e1 : e g₁.1 = e (arg b - π / 2) := by
      have := e_toIcoMod_add (arg b - 1 * (π / 2)) 0
      rw [add_zero, add_zero] at this
      rw [hg₁, curveGerm]; dsimp only; rw [this, one_mul]
    have e2 : e g₂.1 = - e (arg b - π / 2) := by
      have := e_toIcoMod_add (arg b - -1 * (π / 2)) 0
      rw [add_zero, add_zero] at this
      rw [hg₂, curveGerm]; dsimp only
      rw [this, show arg b - -1 * (π / 2) = (arg b - π / 2) + π by ring, e_add_pi]
    have hh : Tendsto (fun s => ‖e (germDir g₁.1 g₁.2 s) - e (germDir g₂.1 g₂.2 s)‖) (𝓝 0) (𝓝 2) := by
      have hcont : Continuous (fun s => ‖e (germDir g₁.1 g₁.2 s) - e (germDir g₂.1 g₂.2 s)‖) := by
        unfold germDir e; fun_prop
      have := hcont.tendsto 0
      simp only [germDir_zero] at this
      rwa [e1, e2, sub_neg_eq_add, ← two_mul, norm_mul, norm_e, mul_one, Complex.norm_two] at this
    have hev : ∀ᶠ s in 𝓝[>] (0 : ℝ), ‖e (germDir (G.β 0) (G.κ 0) s) - e (germDir (G.β 1) (G.κ 1) s)‖ < 1 ∧
        1 < ‖e (germDir g₁.1 g₁.2 s) - e (germDir g₂.1 g₂.2 s)‖ ∧ s < min ρ r₀ :=
      nhdsWithin_le_nhds ((hf.eventually (gt_mem_nhds one_pos)).and
        ((hh.eventually (lt_mem_nhds one_lt_two)).and (gt_mem_nhds hmin)))
    obtain ⟨s, ⟨hfs, hhs, hsρ⟩, hs0⟩ := (hev.and self_mem_nhdsWithin).exists
    have hs0 : (0 : ℝ) < s := hs0
    have hs : s ∈ Ioo 0 (min ρ r₀) := ⟨hs0, hsρ⟩
    obtain ⟨σ0, hσ0, h0⟩ := hgerm' 0 s hs
    obtain ⟨σ1, hσ1, h1⟩ := hgerm' 1 s hs
    have hne : σ0 ≠ σ1 := fun h => hinj 0 1 (by decide) s hs (by rw [h0, h1, h])
    have hnorm : ∀ β κ β' κ', ‖branchPt y β κ s - branchPt y β' κ' s‖ =
        s * ‖e (germDir β κ s) - e (germDir β' κ' s)‖ := by
      intro β κ β' κ'
      rw [branchPt_eq, branchPt_eq, show y + (s : ℂ) * e (germDir β κ s) - (y + (s : ℂ) * e (germDir β' κ' s)) =
        (s : ℂ) * (e (germDir β κ s) - e (germDir β' κ' s)) by ring, norm_mul, Complex.norm_real,
        Real.norm_of_nonneg hs0.le]
    have key : ‖branchPt y (G.β 0) (G.κ 0) s - branchPt y (G.β 1) (G.κ 1) s‖ =
        ‖branchPt y g₁.1 g₁.2 s - branchPt y g₂.1 g₂.2 s‖ := by
      rw [h0, h1]
      rcases hσ0 with rfl | rfl <;> rcases hσ1 with rfl | rfl
      · exact absurd rfl hne
      · rfl
      · rw [norm_sub_rev]
      · exact absurd rfl hne
    rw [hnorm, hnorm] at key
    have := mul_left_cancel₀ hs0.ne' key
    linarith
  -- each sector's cone is a proper arc of directions
  have hnext : ∀ i : Fin 2, e (G.nextβ i) = e (G.β (BranchGerms.next i)) := fun i => by
    have := G.e_nextDir i 0
    simpa [BranchGerms.nextDir, BranchGerms.dir, germDir_zero] using this
  have hlt : ∀ i : Fin 2, G.β i < G.nextβ i := by
    intro i
    rcases hC.sorted.2 i with h | ⟨h, -⟩
    · exact h
    · exfalso
      have := hnext i
      rw [← h] at this
      fin_cases i
      · exact hdir this
      · exact hdir this.symm
  -- the two sectors' colours
  choose p hp using fun i => hC.sector_nonempty hr₀ i
  have hcolconst : ∀ i, ∀ z ∈ G.sector y r₀ i, F.col z = F.col (p i) := fun i z hz =>
    (hC.isPreconnected r₀ hr₀ i).constant (F.continuousOn_col.mono (hC.sector_subset_interiorPts hn hr₀ i)) hz (hp i)
  have hcols : F.col (p 0) ≠ F.col (p 1) := by
    intro heq
    have hsub : F.coloursAt y ⊆ {F.col (p 0)} := by
      intro j hj
      obtain ⟨z, hz, hzd⟩ := Metric.mem_closure_iff.mp hj r₀ hC.pos
      have hz' : z ∈ ⋃ i, G.sector y r₀ i := by
        rw [← hC.cover r₀ hr₀ hn]; exact ⟨by rw [mem_ball, dist_comm]; exact hzd, hz.1⟩
      obtain ⟨i, hi⟩ := mem_iUnion.mp hz'
      rw [mem_singleton_iff, ← hz.2, hcolconst i z hi]
      fin_cases i
      · rfl
      · exact heq.symm
    have := ncard_le_ncard hsub (finite_singleton _)
    rw [ncard_singleton] at this
    have := hc y hyΓ
    omega
  refine ⟨fun S hS => ?_, fun c => ?_⟩
  · obtain ⟨i, rfl⟩ := (hC.isSector_iff hn hr).mp hS
    rw [hC.cone r hr i]
    exact ⟨(G.β i + G.nextβ i) / 2, mem_interior.mpr ⟨Ioo (G.β i) (G.nextβ i),
      Ioo_subset_Icc_self.trans (Icc_subset_angleIcc _ _), isOpen_Ioo, ⟨by linarith [hlt i], by linarith [hlt i]⟩⟩⟩
  · have hcolr : ∀ i, ∀ S, S = G.sector y r i → S ⊆ F.col ⁻¹' {c} → F.col (p i) = c := by
      rintro i S rfl hS
      obtain ⟨z, hz⟩ := hC.sector_nonempty hr i
      rw [← hcolconst i z (G.sector_mono hr.2 i hz)]
      exact hS hz
    refine encard_le_one_iff.mpr fun S S' hS hS' => ?_
    obtain ⟨i, rfl⟩ := (hC.isSector_iff hn hr).mp hS.1
    obtain ⟨j, rfl⟩ := (hC.isSector_iff hn hr).mp hS'.1
    have hi := hcolr i _ rfl hS.2
    have hj := hcolr j _ rfl hS'.2
    by_cases hij : i = j
    · rw [hij]
    · exfalso
      fin_cases i <;> fin_cases j
      · exact hij rfl
      · exact hcols (hi.trans hj.symm)
      · exact hcols (hj.trans hi.symm)
      · exact hij rfl

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
  obtain ⟨ρ₀, hG⟩ := F.exists_goodAt hx
  filter_upwards [nhdsWithin_le_nhds (ball_mem_nhds x hG.pos), self_mem_nhdsWithin] with y hy hyx
  exact not_isSite_of_goodAt hc hG hy hyx

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
