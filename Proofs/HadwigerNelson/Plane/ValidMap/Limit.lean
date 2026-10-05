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

end ArcMap

/-! ## Cleaning (FS131-IL2): an arc's parametrisation -/

namespace Arc

/-- The parametrisation of an arc: the segment's affine parameter, or the circle's angle (`main`'s `Surgery` `Arc.pt`, suffixed
`L` on this branch until the merge with `main`). -/
noncomputable def ptL : Arc → ℝ → ℂ
  | seg p q, t => p + (t : ℂ) * (q - p)
  | circ c R _ _, θ => c + (R : ℂ) * e θ

/-- The parameter interval of an arc (`main`'s `Arc.params`). -/
def paramsL : Arc → Set ℝ
  | seg _ _ => Icc 0 1
  | circ _ _ θ₀ θ₁ => Icc θ₀ θ₁

/-- The sub-arc over the parameters `[t₀, t₁]` (`main`'s `Arc.sub`). -/
noncomputable def subL : Arc → ℝ → ℝ → Arc
  | seg p q, t₀, t₁ => seg (p + (t₀ : ℂ) * (q - p)) (p + (t₁ : ℂ) * (q - p))
  | circ c R _ _, t₀, t₁ => circ c R t₀ t₁

/-- The parametrisation is continuous. -/
theorem continuous_ptL (a : Arc) : Continuous a.ptL := by
  cases a with
  | seg p q => exact continuous_const.add (Complex.continuous_ofReal.mul continuous_const)
  | circ c R θ₀ θ₁ => exact continuous_const.add (continuous_const.mul continuous_e)

/-- An arc is the image of its parameter interval. -/
theorem carrier_eq_imageL (a : Arc) : a.carrier = a.ptL '' a.paramsL := by
  cases a with
  | seg p q =>
    show segment ℝ p q = _
    rw [segment_eq_image']
    simp only [paramsL, ptL, Complex.real_smul]
  | circ c R θ₀ θ₁ => rfl

/-- A sub-arc is the image of its parameters. -/
theorem carrier_subL (a : Arc) {t₀ t₁ : ℝ} (h : t₀ ≤ t₁) : (a.subL t₀ t₁).carrier = a.ptL '' Icc t₀ t₁ := by
  cases a with
  | seg p q =>
    show segment ℝ _ _ = _
    rw [segment_eq_image']
    ext z
    simp only [mem_image, mem_Icc, ptL, Complex.real_smul]
    constructor
    · rintro ⟨u, ⟨hu0, hu1⟩, rfl⟩
      refine ⟨t₀ + u * (t₁ - t₀), ⟨by nlinarith, by nlinarith⟩, ?_⟩
      push_cast; ring
    · rintro ⟨t, ⟨ht0, ht1⟩, rfl⟩
      rcases eq_or_lt_of_le h with heq | hlt
      · subst heq
        have : t = t₀ := le_antisymm ht1 ht0
        subst this
        exact ⟨0, ⟨le_rfl, zero_le_one⟩, by push_cast; ring⟩
      · refine ⟨(t - t₀) / (t₁ - t₀), ⟨div_nonneg (by linarith) (by linarith), (div_le_one (by linarith)).mpr (by linarith)⟩, ?_⟩
        have hne : ((t₁ : ℂ) - t₀) ≠ 0 := by
          rw [← Complex.ofReal_sub]; exact_mod_cast (sub_pos.mpr hlt).ne'
        push_cast
        field_simp
        ring
  | circ c R θ₀ θ₁ => rfl

/-- A sub-arc over a non-trivial sub-interval of a non-degenerate arc's parameters is non-degenerate. -/
theorem nondegenerate_subL {a : Arc} (ha : a.Nondegenerate) {t₀ t₁ : ℝ} (hlt : t₀ < t₁) (hsub : Icc t₀ t₁ ⊆ a.paramsL) :
    (a.subL t₀ t₁).Nondegenerate := by
  cases a with
  | seg p q =>
    show p + (t₀ : ℂ) * (q - p) ≠ p + (t₁ : ℂ) * (q - p)
    intro h
    have hqp : q - p ≠ 0 := sub_ne_zero.mpr (Ne.symm ha)
    have : ((t₀ : ℂ) - t₁) * (q - p) = 0 := by linear_combination h
    rcases mul_eq_zero.mp this with h' | h'
    · have : (t₀ : ℝ) = t₁ := by exact_mod_cast sub_eq_zero.mp h'
      linarith
    · exact hqp h'
  | circ c R θ₀ θ₁ =>
    obtain ⟨hR, -, h2⟩ := ha
    have h0 := (hsub ⟨le_rfl, hlt.le⟩).1
    have h1 := (hsub ⟨hlt.le, le_rfl⟩).2
    exact ⟨hR, hlt, by linarith⟩

/-- The parameter interval is compact. -/
theorem isCompact_paramsL (a : Arc) : IsCompact a.paramsL := by
  cases a <;> exact isCompact_Icc

/-- The parameter interval is an interval. -/
theorem ordConnected_paramsL (a : Arc) : a.paramsL.OrdConnected := by
  cases a <;> exact ordConnected_Icc

/-- **Finitely many parameters of a non-degenerate arc map to one point** (a segment is injective; a circular arc of at most
one turn meets each point at most at its two ends). -/
theorem finite_ptL_eq {a : Arc} (ha : a.Nondegenerate) (x : ℂ) : {t | t ∈ a.paramsL ∧ a.ptL t = x}.Finite := by
  cases a with
  | seg p q =>
    have hqp : q - p ≠ 0 := sub_ne_zero.mpr (Ne.symm ha)
    refine Set.Subsingleton.finite fun t ht t' ht' => ?_
    have h : (t : ℂ) * (q - p) = t' * (q - p) := by
      have := ht.2.trans ht'.2.symm
      simp only [ptL] at this
      linear_combination this
    exact_mod_cast mul_right_cancel₀ hqp h
  | circ c R θ₀ θ₁ =>
    obtain ⟨hR, -, h2⟩ := ha
    by_cases hne : ∃ t₀, t₀ ∈ Icc θ₀ θ₁ ∧ c + (R : ℂ) * e t₀ = x
    · obtain ⟨t₀, ht₀, hx⟩ := hne
      refine (Set.toFinite ({t₀ - 2 * π, t₀, t₀ + 2 * π} : Set ℝ)).subset fun t ht => ?_
      have hR' : (R : ℂ) ≠ 0 := by exact_mod_cast hR.ne'
      have heq : e t = e t₀ := by
        have := ht.2.trans hx.symm
        simp only [ptL] at this
        exact mul_left_cancel₀ hR' (add_left_cancel this)
      obtain ⟨m, hm⟩ := e_eq_e_iff.mp heq
      have ht' : t ∈ Icc θ₀ θ₁ := ht.1
      have hπ := Real.pi_pos
      have hb1 : (m : ℝ) * (2 * π) ≤ 2 * π := by linarith [ht'.1, ht'.2, ht₀.1, ht₀.2]
      have hb2 : -(2 * π) ≤ (m : ℝ) * (2 * π) := by linarith [ht'.1, ht'.2, ht₀.1, ht₀.2]
      have hm1 : (m : ℝ) ≤ 1 := by nlinarith
      have hm2 : (-1 : ℝ) ≤ m := by nlinarith
      have hm1' : m ≤ 1 := by exact_mod_cast hm1
      have hm2' : -1 ≤ m := by exact_mod_cast hm2
      have hm' : m = -1 ∨ m = 0 ∨ m = 1 := by omega
      have key : t = t₀ - 2 * π ∨ t = t₀ ∨ t = t₀ + 2 * π := by
        rcases hm' with rfl | rfl | rfl
        · left; rw [hm]; push_cast; ring
        · right; left; rw [hm]; push_cast; ring
        · right; right; rw [hm]; push_cast; ring
      simp only [mem_insert_iff, mem_singleton_iff]
      exact key
    · exact (Set.finite_empty).subset fun t ht => hne ⟨t, ht.1, ht.2⟩

end Arc

/-! ## Cleaning: components of a closed set of parameters -/

/-- The maximal interval of a closed set of reals through one of its points is closed. -/
theorem isClosed_ordConnectedComponent {A : Set ℝ} (hA : IsClosed A) (u : ℝ) : IsClosed (A.ordConnectedComponent u) := by
  refine isClosed_of_closure_subset fun y hy => ?_
  rw [mem_ordConnectedComponent]
  intro z hz
  rcases eq_or_ne z y with rfl | hzy
  · exact hA.closure_subset (closure_mono ordConnectedComponent_subset hy)
  rw [mem_uIcc] at hz
  rcases lt_or_gt_of_ne hzy with hlt | hlt
  · obtain ⟨w, hw1, hw2⟩ := mem_closure_iff_nhds.mp hy (Ioi z) (Ioi_mem_nhds hlt)
    apply mem_ordConnectedComponent.mp hw2
    rw [mem_uIcc]
    rcases hz with ⟨h1, -⟩ | ⟨h1, -⟩
    · exact Or.inl ⟨h1, (show z < w from hw1).le⟩
    · linarith
  · obtain ⟨w, hw1, hw2⟩ := mem_closure_iff_nhds.mp hy (Iio z) (Iio_mem_nhds hlt)
    apply mem_ordConnectedComponent.mp hw2
    rw [mem_uIcc]
    rcases hz with ⟨-, h2⟩ | ⟨-, h2⟩
    · linarith
    · exact Or.inr ⟨(show w < z from hw1).le, h2⟩

/-- The maximal interval of a closed bounded set of reals through one of its points is the closed interval between its
infimum and supremum. -/
theorem ordConnectedComponent_eq_Icc {A : Set ℝ} (hA : IsClosed A) (hb : Bornology.IsBounded A) {u : ℝ} (hu : u ∈ A) :
    A.ordConnectedComponent u = Icc (sInf (A.ordConnectedComponent u)) (sSup (A.ordConnectedComponent u)) := by
  set C := A.ordConnectedComponent u with hCdef
  have hC : IsClosed C := isClosed_ordConnectedComponent hA u
  have hne : C.Nonempty := ⟨u, self_mem_ordConnectedComponent.mpr hu⟩
  have hbC : Bornology.IsBounded C := hb.subset ordConnectedComponent_subset
  have h1 := hC.csInf_mem hne hbC.bddBelow
  have h2 := hC.csSup_mem hne hbC.bddAbove
  refine Subset.antisymm (fun t ht => ⟨csInf_le hbC.bddBelow ht, le_csSup hbC.bddAbove ht⟩) ?_
  exact (inferInstance : OrdConnected C).out h1 h2

/-- **Finitely many components near a point** (the general-topology step of `cleanArcs_locallyFinite`): a closed set `A` of
parameters of a continuous path `f` on a compact interval `I`, whose membership is locally constant wherever `f` is near `x` but
not at it, and with finitely many parameters at `x`: near `x` only finitely many components of `A` are met, and every parameter
of `A` near `x` reaches a parameter at `x` through `A`. -/
theorem eventually_finite_components {f : ℝ → ℂ} (hf : Continuous f) {I A : Set ℝ} (hIc : IsCompact I) (hIo : I.OrdConnected)
    (hA : A ⊆ I) {x : ℂ} {ρ : ℝ} (hρ : 0 < ρ) (hP : {t | t ∈ I ∧ f t = x}.Finite)
    (hloc : ∀ t ∈ I, f t ∈ ball x ρ → f t ≠ x → ∀ᶠ t' in 𝓝 t, t' ∈ I → (t' ∈ A ↔ t ∈ A)) :
    ∀ᶠ ε in 𝓝[>] (0 : ℝ), ((fun w => A.ordConnectedComponent w) '' (A ∩ f ⁻¹' ball x ε)).Finite ∧
      ∀ t ∈ A, f t ∈ ball x ε → f t ≠ x → ∃ u ∈ I, f u = x ∧ u ≠ t ∧ ∀ t' ∈ uIcc u t, t' ≠ u → t' ∈ A := by
  set P := {t | t ∈ I ∧ f t = x} with hPdef
  -- `η`: within `η` of a parameter at `x` the path stays in `B(x, ρ)`, and no other parameter at `x` is that close
  have hη : ∀ᶠ η in 𝓝[>] (0 : ℝ), ∀ u ∈ P, (∀ t, |t - u| < η → f t ∈ ball x ρ) ∧ ∀ u' ∈ P, u' ≠ u → η ≤ |u' - u| := by
    rw [eventually_all_finite hP]
    intro u hu
    refine Eventually.and ?_ ?_
    · have hfu : f u ∈ ball x ρ := by rw [hu.2]; exact mem_ball_self hρ
      obtain ⟨δ, hδ, hball⟩ := Metric.eventually_nhds_iff.mp (hf.continuousAt.eventually (isOpen_ball.mem_nhds hfu))
      filter_upwards [Ioo_mem_nhdsGT hδ] with η hη t ht
      exact hball (by rw [Real.dist_eq]; linarith [hη.2])
    · rw [eventually_all_finite hP]
      intro u' _
      by_cases h : u' = u
      · exact Eventually.of_forall fun _ hne => absurd h hne
      · have : 0 < |u' - u| := abs_pos.mpr (sub_ne_zero.mpr h)
        filter_upwards [Ioo_mem_nhdsGT this] with η hη _
        exact hη.2.le
  obtain ⟨η, hηP, hη0⟩ := (hη.and self_mem_nhdsWithin).exists
  have hη0 : (0 : ℝ) < η := hη0
  -- membership in `A` is constant along a preconnected set of parameters near `x` but off it
  have hconst : ∀ J ⊆ I, IsPreconnected J → (∀ t ∈ J, f t ∈ ball x ρ ∧ f t ≠ x) →
      ∀ t ∈ J, ∀ t' ∈ J, (t ∈ A ↔ t' ∈ A) := by
    intro J hJI hJ hJf t ht t' ht'
    classical
    have hc : ContinuousOn (fun s => decide (s ∈ A)) J := by
      intro s hs
      have hl := hloc s (hJI hs) (hJf s hs).1 (hJf s hs).2
      rw [ContinuousWithinAt, nhds_discrete, tendsto_pure]
      filter_upwards [nhdsWithin_le_nhds hl, self_mem_nhdsWithin] with s' h1 h2
      rw [decide_eq_decide]
      exact h1 (hJI h2)
    exact decide_eq_decide.mp (hJ.constant hc ht ht')
  -- the two sides of a parameter at `x`
  set Jp : ℝ → Set ℝ := fun u => I ∩ Ioo u (u + η) with hJp
  set Jm : ℝ → Set ℝ := fun u => I ∩ Ioo (u - η) u with hJm
  have hside : ∀ u ∈ P, ∀ t ∈ I, 0 < |t - u| → |t - u| < η → f t ∈ ball x ρ ∧ f t ≠ x := by
    intro u hu t ht h0 h1
    refine ⟨(hηP u hu).1 t h1, fun hft => ?_⟩
    have := (hηP u hu).2 t ⟨ht, hft⟩ (fun h => by rw [h, sub_self, abs_zero] at h0; exact lt_irrefl _ h0)
    linarith
  have hJp_const : ∀ u ∈ P, ∀ t ∈ Jp u, ∀ t' ∈ Jp u, (t ∈ A ↔ t' ∈ A) := by
    intro u hu
    refine hconst (Jp u) inter_subset_left (hIo.inter ordConnected_Ioo).isPreconnected fun t ht => ?_
    refine hside u hu t ht.1 ?_ ?_
    · rw [abs_of_pos (by linarith [ht.2.1])]; linarith [ht.2.1]
    · rw [abs_of_pos (by linarith [ht.2.1])]; linarith [ht.2.2]
  have hJm_const : ∀ u ∈ P, ∀ t ∈ Jm u, ∀ t' ∈ Jm u, (t ∈ A ↔ t' ∈ A) := by
    intro u hu
    refine hconst (Jm u) inter_subset_left (hIo.inter ordConnected_Ioo).isPreconnected fun t ht => ?_
    refine hside u hu t ht.1 ?_ ?_
    · rw [abs_of_neg (by linarith [ht.2.2])]; linarith [ht.2.2]
    · rw [abs_of_neg (by linarith [ht.2.2])]; linarith [ht.2.1]
  -- `ε`: off the `η`-neighbourhoods of the parameters at `x`, the path stays `ε` away from `x`
  set K := I \ ⋃ u ∈ P, Ioo (u - η) (u + η) with hK
  have hKc : IsCompact (f '' K) :=
    (hIc.diff (isOpen_biUnion fun _ _ => isOpen_Ioo)).image hf
  have hxK : x ∉ f '' K := by
    rintro ⟨t, ⟨htI, htU⟩, hft⟩
    exact htU (mem_iUnion₂.mpr ⟨t, ⟨htI, hft⟩, ⟨by linarith, by linarith⟩⟩)
  obtain ⟨ε₀, hε₀, hball⟩ := Metric.isOpen_iff.mp hKc.isClosed.isOpen_compl x hxK
  have hnear : ∀ t ∈ I, f t ∈ ball x ε₀ → ∃ u ∈ P, t ∈ Ioo (u - η) (u + η) := by
    intro t ht hft
    by_contra h
    push Not at h
    exact hball hft ⟨t, ⟨ht, fun hU => by
      obtain ⟨u, hu, htu⟩ := mem_iUnion₂.mp hU
      exact h u hu htu⟩, rfl⟩
  -- the components met near `x`
  have hfin : ((fun w => A.ordConnectedComponent w) '' (A ∩ f ⁻¹' ball x ε₀)).Finite := by
    have hsub1 : ∀ J : Set ℝ, J.OrdConnected → (∀ t ∈ J, ∀ t' ∈ J, (t ∈ A ↔ t' ∈ A)) →
        ((fun w => A.ordConnectedComponent w) '' (A ∩ J)).Subsingleton := by
      rintro J hJ hJc _ ⟨w, ⟨hwA, hwJ⟩, rfl⟩ _ ⟨w', ⟨hw'A, hw'J⟩, rfl⟩
      refine ordConnectedComponent_eq fun s hs => ?_
      exact (hJc w hwJ s (hJ.uIcc_subset hwJ hw'J hs)).mp hwA
    refine ((hP.biUnion fun u hu => ((Set.finite_singleton (A.ordConnectedComponent u)).union
      ((hsub1 (Jp u) (hIo.inter ordConnected_Ioo) (hJp_const u hu)).finite)).union
      ((hsub1 (Jm u) (hIo.inter ordConnected_Ioo) (hJm_const u hu)).finite))).subset ?_
    rintro _ ⟨w, ⟨hwA, hwb⟩, rfl⟩
    obtain ⟨u, hu, hwu⟩ := hnear w (hA hwA) hwb
    refine mem_iUnion₂.mpr ⟨u, hu, ?_⟩
    rcases lt_trichotomy w u with h | rfl | h
    · exact Or.inr ⟨w, ⟨hwA, hA hwA, hwu.1, h⟩, rfl⟩
    · exact Or.inl (Or.inl rfl)
    · exact Or.inl (Or.inr ⟨w, ⟨hwA, hA hwA, h, hwu.2⟩, rfl⟩)
  have hreach : ∀ t ∈ A, f t ∈ ball x ε₀ → f t ≠ x → ∃ u ∈ I, f u = x ∧ u ≠ t ∧ ∀ t' ∈ uIcc u t, t' ≠ u → t' ∈ A := by
    intro t htA hft hfx
    obtain ⟨u, hu, htu⟩ := hnear t (hA htA) hft
    have hut : u ≠ t := fun h => hfx (h ▸ hu.2)
    refine ⟨u, hu.1, hu.2, hut, fun t' ht' ht'u => ?_⟩
    have ht'I : t' ∈ I := hIo.uIcc_subset hu.1 (hA htA) ht'
    rw [mem_uIcc] at ht'
    rcases lt_or_gt_of_ne hut with h | h
    · have hp : t ∈ Jp u := ⟨hA htA, h, htu.2⟩
      have hp' : t' ∈ Jp u := by
        refine ⟨ht'I, lt_of_le_of_ne ?_ (Ne.symm ht'u), ?_⟩ <;> rcases ht' with ⟨h1, h2⟩ | ⟨h1, h2⟩ <;> linarith [htu.2]
      exact (hJp_const u hu t hp t' hp').mp htA
    · have hp : t ∈ Jm u := ⟨hA htA, htu.1, h⟩
      have hp' : t' ∈ Jm u := by
        refine ⟨ht'I, ?_, lt_of_le_of_ne ?_ ht'u⟩ <;> rcases ht' with ⟨h1, h2⟩ | ⟨h1, h2⟩ <;> linarith [htu.1]
      exact (hJm_const u hu t hp t' hp').mp htA
  filter_upwards [Ioo_mem_nhdsGT hε₀] with ε hε
  have hsub : ball x ε ⊆ ball x ε₀ := ball_subset_ball hε.2.le
  refine ⟨hfin.subset (image_mono (inter_subset_inter_right _ (preimage_mono hsub))), fun t htA hft hfx => ?_⟩
  exact hreach t htA (hsub hft) hfx

/-- The punctured disc is preconnected (the image of `(0, ε) × ℝ` in polar coordinates). -/
theorem isPreconnected_ball_diff_singleton (x : ℂ) (ε : ℝ) : IsPreconnected (ball x ε \ {x}) := by
  have h : ball x ε \ {x} = (fun p : ℝ × ℝ => x + (p.1 : ℂ) * e p.2) '' (Ioo 0 ε ×ˢ univ) := by
    ext z
    constructor
    · rintro ⟨hz, hzx⟩
      have hzx' : z - x ≠ 0 := sub_ne_zero.mpr hzx
      refine ⟨(‖z - x‖, arg (z - x)), ⟨⟨norm_pos_iff.mpr hzx', ?_⟩, mem_univ _⟩, ?_⟩
      · rw [mem_ball, dist_eq_norm] at hz; exact hz
      · have := eq_polar_arg (z - x)
        simp only
        linear_combination -this
    · rintro ⟨⟨s, φ⟩, ⟨hs, -⟩, rfl⟩
      refine ⟨?_, ?_⟩
      · rw [mem_ball, dist_eq_norm, add_sub_cancel_left, norm_mul_e hs.1.le]; exact hs.2
      · intro h
        have h' := congrArg (fun z => ‖z - x‖) h
        simp only [add_sub_cancel_left, sub_self, norm_zero, norm_mul_e hs.1.le] at h'
        linarith [hs.1]
  rw [h]
  refine (isPreconnected_Ioo.prod isPreconnected_univ).image _ (Continuous.continuousOn ?_)
  exact continuous_const.add ((Complex.continuous_ofReal.comp continuous_fst).mul (continuous_e.comp continuous_snd))

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## Cleaning: colours near a point -/

/-- **Every point of the domain carries a colour** (the interior points are dense). -/
theorem coloursAt_nonempty {x : ℂ} (hx : x ∈ F.dom) : (F.coloursAt x).Nonempty := by
  have h := F.dense_interiorPts hx
  have hU : F.interiorPts = ⋃ j, F.region j := by
    ext z
    simp only [mem_iUnion, region, mem_inter_iff, mem_preimage, mem_singleton_iff]
    exact ⟨fun hz => ⟨F.col z, hz, rfl⟩, fun ⟨_, hz, _⟩ => hz⟩
  rw [hU, closure_iUnion_of_finite] at h
  obtain ⟨j, hj⟩ := mem_iUnion.mp h
  exact ⟨j, hj⟩

/-- **The colours near a point are among its colours.** -/
theorem eventually_coloursAt_subset (x : ℂ) : ∀ᶠ y in 𝓝 x, F.coloursAt y ⊆ F.coloursAt x := by
  have h : ∀ j : Fin k, ∀ᶠ y in 𝓝 x, j ∉ F.coloursAt x → j ∉ F.coloursAt y := by
    intro j
    by_cases hj : j ∈ F.coloursAt x
    · exact Eventually.of_forall fun _ h => absurd hj h
    · filter_upwards [isClosed_closure.isOpen_compl.mem_nhds hj] with y hy _ hyj
      exact hy hyj
  filter_upwards [eventually_all.mpr h] with y hy j hj
  by_contra hx
  exact hy j hx hj

/-- An interior point carries exactly its own colour. -/
theorem coloursAt_eq_singleton_of_interior {x : ℂ} (hx : x ∈ F.interiorPts) : F.coloursAt x = {F.col x} := by
  refine Subset.antisymm (fun j hj => ?_) (singleton_subset_iff.mpr (subset_closure ⟨hx, rfl⟩))
  have hev : ∀ᶠ y in 𝓝 x, F.col y = F.col x := F.locallyConstant x hx.1 hx.2
  obtain ⟨y, hyx, hyj⟩ := ((mem_closure_iff_frequently.mp hj).and_eventually hev).exists
  rw [mem_singleton_iff, ← hyj]
  exact hyx.2.symm

variable (F) in
/-- **The essential set**: the points of the domain carrying at least two colours (they lie on `Γ`: `essSet_subset_Γ`). -/
def essSet : Set ℂ := {x | x ∈ F.dom ∧ 2 ≤ (F.coloursAt x).ncard}

/-- The essential set lies on `Γ` (an interior point carries one colour). -/
theorem essSet_subset_Γ : F.essSet ⊆ F.Γ := by
  rintro x ⟨hxd, h2⟩
  rw [mem_Γ_iff]
  refine ⟨hxd, fun hxI => ?_⟩
  rw [coloursAt_eq_singleton_of_interior hxI, ncard_singleton] at h2
  omega

/-- A point of the domain off the essential set carries exactly one colour. -/
theorem exists_coloursAt_eq_singleton {x : ℂ} (hxd : x ∈ F.dom) (hx : x ∉ F.essSet) : ∃ j, F.coloursAt x = {j} := by
  have h1 : (F.coloursAt x).ncard ≤ 1 := by
    by_contra h
    exact hx ⟨hxd, by omega⟩
  have h0 : 0 < (F.coloursAt x).ncard := (ncard_pos (toFinite _)).mpr (coloursAt_nonempty hxd)
  exact ncard_eq_one.mp (by omega)

/-- Near a point of one colour, every point of the domain carries that colour alone. -/
theorem eventually_coloursAt_eq_singleton {x : ℂ} (hxd : x ∈ F.dom) {j : Fin k} (hj : F.coloursAt x = {j}) :
    ∀ᶠ y in 𝓝 x, y ∈ F.dom ∧ F.coloursAt y = {j} := by
  filter_upwards [F.isOpen_dom.mem_nhds hxd, eventually_coloursAt_subset x] with y hyd hy
  refine ⟨hyd, ?_⟩
  rw [hj] at hy
  exact (subset_singleton_iff_eq.mp hy).resolve_left (coloursAt_nonempty hyd).ne_empty

/-- The domain off the essential set is open. -/
theorem isOpen_dom_diff_essSet : IsOpen (F.dom \ F.essSet) := by
  rw [isOpen_iff_mem_nhds]
  rintro x ⟨hxd, hx⟩
  obtain ⟨j, hj⟩ := exists_coloursAt_eq_singleton hxd hx
  filter_upwards [eventually_coloursAt_eq_singleton hxd hj] with y ⟨hyd, hy⟩
  refine ⟨hyd, fun ⟨_, h2⟩ => ?_⟩
  rw [hy, ncard_singleton] at h2
  omega

/-- **An isolated point of the domain's essential set is not essential**: if no other point of a disc about `x` is essential,
the one colour of the punctured disc (connected) is the only colour at `x`. -/
theorem notMem_essSet_of_isolated {x : ℂ} {ε : ℝ} (hε : 0 < ε) (hball : ball x ε ⊆ F.dom)
    (hiso : ∀ z ∈ ball x ε, z ≠ x → z ∉ F.essSet) : x ∉ F.essSet := by
  rintro ⟨hxd, h2⟩
  by_cases hxI : x ∈ F.interiorPts
  · rw [coloursAt_eq_singleton_of_interior hxI, ncard_singleton] at h2; omega
  have hsing : ∀ z ∈ ball x ε \ {x}, ∃ j, F.coloursAt z = {j} := fun z hz =>
    exists_coloursAt_eq_singleton (hball hz.1) (hiso z hz.1 hz.2)
  haveI : Nonempty (Fin k) := ⟨F.col x⟩
  choose! g hg using hsing
  have hopen : IsOpen (ball x ε \ {x}) := isOpen_ball.sdiff isClosed_singleton
  have hgc : ContinuousOn g (ball x ε \ {x}) := by
    intro z hz
    rw [ContinuousWithinAt, nhds_discrete, tendsto_pure]
    filter_upwards [nhdsWithin_le_nhds (eventually_coloursAt_subset z), self_mem_nhdsWithin] with w hwz hw
    rw [hg w hw, hg z hz] at hwz
    exact singleton_subset_singleton.mp hwz
  have hz₀ : x + ((ε / 2 : ℝ) : ℂ) ∈ ball x ε \ {x} := by
    refine ⟨?_, ?_⟩
    · rw [mem_ball, dist_eq_norm, add_sub_cancel_left, Complex.norm_real, Real.norm_of_nonneg (by positivity)]; linarith
    · intro h
      have h' : x + ((ε / 2 : ℝ) : ℂ) = x := h
      have : ((ε / 2 : ℝ) : ℂ) = 0 := by linear_combination h'
      have : ε / 2 = 0 := by exact_mod_cast this
      linarith
  have hsub : F.coloursAt x ⊆ {g (x + ((ε / 2 : ℝ) : ℂ))} := by
    intro i hi
    obtain ⟨w, hw, hwx⟩ := Metric.mem_closure_iff.mp hi ε hε
    have hwb : w ∈ ball x ε := by rw [mem_ball, dist_comm]; exact hwx
    have hwne : w ≠ x := fun h => hxI (h ▸ hw.1)
    have hi' : i ∈ F.coloursAt w := by
      rw [coloursAt_eq_singleton_of_interior hw.1]; exact mem_singleton_iff.mpr (show F.col w = i from hw.2).symm
    rw [hg w ⟨hwb, hwne⟩, (isPreconnected_ball_diff_singleton x ε).constant hgc ⟨hwb, hwne⟩ hz₀] at hi'
    exact hi'
  have := ncard_le_ncard hsub (toFinite _)
  rw [ncard_singleton] at this
  omega

/-! ## Cleaning: the essential status is locally constant on `Γ` near a point, off it -/

/-- **Branch points are closure points of the sectors they bound** (FS131 wave 4's `BranchGerms.branchPt_mem_closure_sector`,
`MapTopology`, on `fs131-w5`; re-proved here): at a distance where the germs are strictly ordered, the point of germ `i` lies in
the closure of sector `i`, and the point of the germ after `i` in the closure of sector `i` too. -/
theorem branchPt_mem_closure_sector_pair {n : ℕ} (G : BranchGerms n) {ρ : ℝ}
    (hord : ∀ s ∈ Ioo 0 ρ, ∀ i, G.dir i s < G.nextDir i s) (v : ℂ) (i : Fin n) {s : ℝ} (hs : s ∈ Ioo 0 ρ) :
    branchPt v (G.β i) (G.κ i) s ∈ closure (G.sector v ρ i) ∧
      branchPt v (G.β (BranchGerms.next i)) (G.κ (BranchGerms.next i)) s ∈ closure (G.sector v ρ i) := by
  have hgap := hord s hs i
  have hmem : ∀ φ ∈ Ioo (G.dir i s) (G.nextDir i s), v + (s : ℂ) * e φ ∈ G.sector v ρ i :=
    fun φ hφ => ⟨s, hs, φ, hφ, rfl⟩
  have hcont : Continuous fun φ : ℝ => v + (s : ℂ) * e φ := continuous_const.add (continuous_const.mul continuous_e)
  constructor
  · refine mem_closure_of_tendsto ((hcont.tendsto (G.dir i s)).mono_left
      (nhdsWithin_le_nhds (s := Ioi (G.dir i s)))) ?_
    filter_upwards [Ioo_mem_nhdsGT hgap] with φ hφ
    exact hmem φ hφ
  · have hpt : branchPt v (G.β (BranchGerms.next i)) (G.κ (BranchGerms.next i)) s = v + (s : ℂ) * e (G.nextDir i s) := by
      rw [branchPt_eq, BranchGerms.e_nextDir]; rfl
    rw [hpt]
    refine mem_closure_of_tendsto ((hcont.tendsto (G.nextDir i s)).mono_left
      (nhdsWithin_le_nhds (s := Iio (G.nextDir i s)))) ?_
    filter_upwards [Ioo_mem_nhdsLT hgap] with φ hφ
    exact hmem φ hφ

/-- **In a good ball about `x`, a chart at another point of `Γ` has at most two germs** (they are the two germs of the one curve
through it: `germ_eq_curveGerm_of_goodAt`; the argument of `not_isSite_of_goodAt`). -/
theorem germs_le_two_of_goodAt {x : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt x ρ₀) {y : ℂ} (hy : y ∈ ball x ρ₀) (hyx : y ≠ x)
    (hyΓ : y ∈ F.Γ) {r₀ : ℝ} {n : ℕ} {G : BranchGerms n} (hC : F.IsSectorChart G y r₀)
    (hdisj : ∀ i j, i ≠ j → ∀ s ∈ Ioo 0 r₀, e (G.dir i s) ≠ e (G.dir j s)) : n ≤ 2 := by
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

/-- **In a good ball about `x`, the essential status is locally constant on `Γ` off `x`**: at `y ≠ x` the chart has one germ
(an end of `Γ`: one sector, one colour) or two (the two sides of the one curve, every point of `Γ` near `y` in the closure of
both sectors). -/
theorem eventually_essSet_iff_of_goodAt {x : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt x ρ₀) {y : ℂ} (hy : y ∈ ball x ρ₀) (hyx : y ≠ x)
    (hyΓ : y ∈ F.Γ) : ∀ᶠ z in 𝓝 y, z ∈ F.Γ → (z ∈ F.essSet ↔ y ∈ F.essSet) := by
  have hyd : y ∈ F.dom := hG.subdom hy
  obtain ⟨r₀, n, G, hC, hdisj⟩ := localSectors_disj F hyd
  have hn2 := germs_le_two_of_goodAt hG hy hyx hyΓ hC hdisj
  have hn1 : 0 < n := hC.mem_Γ.mp hyΓ
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  have hord := G.dir_lt_nextDir hC.sorted hC.curv hdisj
  choose p hp using fun i => hC.sector_nonempty hr₀ i
  set c : Fin n → Fin k := fun i => F.col (p i) with hcdef
  have hcolconst : ∀ i, ∀ z ∈ G.sector y r₀ i, F.col z = c i := fun i z hz =>
    (hC.isPreconnected r₀ hr₀ i).constant (F.continuousOn_col.mono (hC.sector_subset_interiorPts hn1 hr₀ i)) hz (hp i)
  -- every colour in the chart ball is a sector's colour
  have hsub : ∀ z ∈ ball y r₀, F.coloursAt z ⊆ range c := by
    intro z hz j hj
    have hε : 0 < r₀ - dist z y := by rw [mem_ball] at hz; linarith
    obtain ⟨w, hw, hwz⟩ := Metric.mem_closure_iff.mp hj _ hε
    have hwb : w ∈ ball y r₀ := by
      rw [mem_ball] at hz ⊢; linarith [dist_triangle w z y, dist_comm z w]
    have hw' : w ∈ ⋃ i, G.sector y r₀ i := by rw [← hC.cover r₀ hr₀ hn1]; exact ⟨hwb, hw.1⟩
    obtain ⟨i, hi⟩ := mem_iUnion.mp hw'
    exact ⟨i, (hcolconst i w hi).symm.trans hw.2⟩
  -- each sector's closure carries its colour
  have hclos : ∀ i, ∀ z ∈ closure (G.sector y r₀ i), c i ∈ F.coloursAt z := fun i z hz =>
    closure_mono (fun w hw => (⟨hC.sector_subset_interiorPts hn1 hr₀ i hw, hcolconst i w hw⟩ : w ∈ F.region (c i))) hz
  by_cases hcc : ∀ i j, c i = c j
  · -- one colour around `y`: nothing near `y` is essential
    have hone : ∀ z ∈ ball y r₀, z ∉ F.essSet := by
      intro z hz ⟨_, h2⟩
      have hs : F.coloursAt z ⊆ {c ⟨0, hn1⟩} := fun j hj => by
        obtain ⟨i, rfl⟩ := hsub z hz hj
        exact hcc i _
      have := ncard_le_ncard hs (toFinite _)
      rw [ncard_singleton] at this
      omega
    filter_upwards [ball_mem_nhds y hC.pos] with z hz _
    exact iff_of_false (hone z hz) (hone y (mem_ball_self hC.pos))
  · -- two colours: two germs, every point of `Γ` near `y` in the closure of both sectors
    push Not at hcc
    obtain ⟨i₀, j₀, hij⟩ := hcc
    have hn : n = 2 := by
      have : i₀ ≠ j₀ := fun h => hij (h ▸ rfl)
      have : 2 ≤ n := by
        by_contra h
        push Not at h
        exact this (Fin.ext (by omega))
      omega
    subst hn
    have hrange : 2 ≤ (range c).ncard := by
      have : ({c i₀, c j₀} : Set (Fin k)) ⊆ range c := by
        rintro _ (rfl | rfl)
        · exact ⟨i₀, rfl⟩
        · exact ⟨j₀, rfl⟩
      have h2 := ncard_le_ncard this (toFinite _)
      rwa [ncard_pair hij] at h2
    have hall : ∀ z ∈ F.Γ ∩ ball y r₀, range c ⊆ F.coloursAt z := by
      rintro z ⟨hzΓ, hzb⟩ _ ⟨i, rfl⟩
      by_cases hzy : z = y
      · subst hzy; exact hclos i z (hC.mem_closure_sector hr₀ i)
      have hz' : z ∈ (F.Γ ∩ ball y r₀) \ {y} := ⟨⟨hzΓ, hzb⟩, hzy⟩
      rw [hC.branches] at hz'
      obtain ⟨l, s, hs, rfl⟩ := mem_iUnion.mp hz'
      have hnn : ∀ m : Fin 2, BranchGerms.next (BranchGerms.next m) = m := by
        intro m; fin_cases m <;> rfl
      have h1 := (branchPt_mem_closure_sector_pair G hord y l hs).1
      have h2 := (branchPt_mem_closure_sector_pair G hord y (BranchGerms.next l) hs).2
      rw [hnn l] at h2
      have hcases : i = l ∨ i = BranchGerms.next l := by
        fin_cases i <;> fin_cases l <;> simp [BranchGerms.next]
      rcases hcases with rfl | rfl
      · exact hclos _ _ h1
      · exact hclos _ _ h2
    have hyE : y ∈ F.essSet := ⟨hyd, hrange.trans (ncard_le_ncard (hall y ⟨hyΓ, mem_ball_self hC.pos⟩) (toFinite _))⟩
    filter_upwards [ball_mem_nhds y hC.pos] with z hz hzΓ
    exact iff_of_true ⟨hzΓ.1, hrange.trans (ncard_le_ncard (hall z ⟨hzΓ, hz⟩) (toFinite _))⟩ hyE

/-! ## Cleaning: the clean arcs -/

variable (F) in
/-- The parameters of the arc `a` at which its point is off the domain or essential. -/
def essParams (a : Arc) : Set ℝ := {t | t ∈ a.paramsL ∧ (a.ptL t ∉ F.dom ∨ a.ptL t ∈ F.essSet)}

/-- The essential parameters of an arc form a closed set. -/
theorem isClosed_essParams (a : Arc) : IsClosed (F.essParams a) := by
  have h : F.essParams a = a.paramsL ∩ (a.ptL ⁻¹' (F.dom \ F.essSet))ᶜ := by
    ext t
    simp only [essParams, mem_setOf_eq, mem_inter_iff, mem_compl_iff, mem_preimage, Set.mem_sdiff, not_and, not_not]
    constructor
    · rintro ⟨ht, h | h⟩
      · exact ⟨ht, fun hd => absurd hd h⟩
      · exact ⟨ht, fun _ => h⟩
    · rintro ⟨ht, h⟩
      by_cases hd : a.ptL t ∈ F.dom
      · exact ⟨ht, Or.inr (h hd)⟩
      · exact ⟨ht, Or.inl hd⟩
  rw [h]
  exact a.isCompact_paramsL.isClosed.inter (isOpen_dom_diff_essSet.preimage a.continuous_ptL).isClosed_compl

/-- The component of an essential parameter is the closed interval between its ends. -/
theorem essComp_eq_Icc (a : Arc) {u : ℝ} (hu : u ∈ F.essParams a) :
    (F.essParams a).ordConnectedComponent u = Icc (sInf ((F.essParams a).ordConnectedComponent u))
      (sSup ((F.essParams a).ordConnectedComponent u)) :=
  ordConnectedComponent_eq_Icc (isClosed_essParams a) (a.isCompact_paramsL.isBounded.subset fun _ h => h.1) hu

variable (F) in
/-- **The clean map's arcs**: the sub-arcs of `F`'s arcs over the non-trivial maximal intervals of essential parameters. -/
def cleanArcs : Set Arc :=
  {b | ∃ a ∈ F.arcs, ∃ u ∈ F.essParams a,
    sInf ((F.essParams a).ordConnectedComponent u) < sSup ((F.essParams a).ordConnectedComponent u) ∧
      b = a.subL (sInf ((F.essParams a).ordConnectedComponent u)) (sSup ((F.essParams a).ordConnectedComponent u))}

/-- The clean arcs are non-degenerate. -/
theorem cleanArcs_nondegenerate {b : Arc} (hb : b ∈ F.cleanArcs) : b.Nondegenerate := by
  obtain ⟨a, ha, u, hu, hlt, rfl⟩ := hb
  refine Arc.nondegenerate_subL (F.nondegenerate a ha) hlt ?_
  rw [← essComp_eq_Icc a hu]
  exact fun t ht => (ordConnectedComponent_subset ht).1

/-- **Essential membership is locally constant along an arc near a point of a good ball, off its centre.** -/
theorem essParams_eventually_iff {x : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt x ρ₀) {a : Arc} (ha : a ∈ F.arcs) {t : ℝ}
    (ht : t ∈ a.paramsL) (h1 : a.ptL t ∈ ball x ρ₀) (h2 : a.ptL t ≠ x) :
    ∀ᶠ t' in 𝓝 t, t' ∈ a.paramsL → (t' ∈ F.essParams a ↔ t ∈ F.essParams a) := by
  have hmem : ∀ s ∈ a.paramsL, a.ptL s ∈ ⋃ b ∈ F.arcs, b.carrier := fun s hs =>
    mem_iUnion₂.mpr ⟨a, ha, by rw [a.carrier_eq_imageL]; exact ⟨s, hs, rfl⟩⟩
  have hyΓ : a.ptL t ∈ F.Γ := ⟨hG.subdom h1, hmem t ht⟩
  have hev := a.continuous_ptL.continuousAt.eventually (eventually_essSet_iff_of_goodAt hG h1 h2 hyΓ)
  have hev2 := a.continuous_ptL.continuousAt.eventually (isOpen_ball.mem_nhds h1)
  filter_upwards [hev, hev2] with t' h h' ht'
  have hd' : a.ptL t' ∈ F.dom := hG.subdom h'
  have hd : a.ptL t ∈ F.dom := hG.subdom h1
  have key := h ⟨hd', hmem t' ht'⟩
  simp only [essParams, mem_setOf_eq]
  constructor
  · rintro ⟨-, hh | hh⟩
    · exact absurd hd' hh
    · exact ⟨ht, Or.inr (key.mp hh)⟩
  · rintro ⟨-, hh | hh⟩
    · exact absurd hd hh
    · exact ⟨ht', Or.inr (key.mpr hh)⟩

/-- Near a point of the domain, uniformly over the finitely many arcs of a good ball: finitely many essential components are
met, and every essential parameter near the point reaches a parameter at the point through essential parameters. -/
theorem eventually_clean_near {x : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt x ρ₀) :
    ∀ᶠ ε in 𝓝[>] (0 : ℝ), ∀ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ ball x ρ₀).Nonempty},
      ((fun w => (F.essParams a).ordConnectedComponent w) '' (F.essParams a ∩ a.ptL ⁻¹' ball x ε)).Finite ∧
      ∀ t ∈ F.essParams a, a.ptL t ∈ ball x ε → a.ptL t ≠ x →
        ∃ u ∈ a.paramsL, a.ptL u = x ∧ u ≠ t ∧ ∀ t' ∈ uIcc u t, t' ≠ u → t' ∈ F.essParams a := by
  rw [eventually_all_finite hG.fin]
  rintro a ⟨ha, -⟩
  exact eventually_finite_components a.continuous_ptL a.isCompact_paramsL a.ordConnected_paramsL (fun _ h => h.1) hG.pos
    (Arc.finite_ptL_eq (F.nondegenerate a ha) x) fun t ht h1 h2 => essParams_eventually_iff hG ha ht h1 h2

/-- **The clean arcs are locally finite in the domain.** -/
theorem cleanArcs_locallyFinite {x : ℂ} (hx : x ∈ F.dom) :
    ∃ t ∈ 𝓝 x, {b | b ∈ F.cleanArcs ∧ (b.carrier ∩ t).Nonempty}.Finite := by
  obtain ⟨ρ₀, hG⟩ := F.exists_goodAt hx
  obtain ⟨ε, hε, hε0⟩ := ((eventually_clean_near hG).and (Ioo_mem_nhdsGT hG.pos)).exists
  refine ⟨ball x ε, ball_mem_nhds x hε0.1, ?_⟩
  refine (hG.fin.biUnion fun a ha => ((hε a ha).1.image fun C => a.subL (sInf C) (sSup C))).subset ?_
  rintro b ⟨⟨a, ha, u, huA, hlt, rfl⟩, z, hzb, hzt⟩
  have hCI := essComp_eq_Icc a huA
  rw [a.carrier_subL hlt.le, ← hCI] at hzb
  obtain ⟨w, hwC, rfl⟩ := hzb
  have hwA : w ∈ F.essParams a := ordConnectedComponent_subset hwC
  have hza : a.ptL w ∈ a.carrier := by rw [a.carrier_eq_imageL]; exact ⟨w, hwA.1, rfl⟩
  refine mem_iUnion₂.mpr ⟨a, ⟨ha, _, hza, ball_subset_ball hε0.2.le hzt⟩, ?_⟩
  exact ⟨(F.essParams a).ordConnectedComponent u, ⟨w, ⟨hwA, hzt⟩,
    (ordConnectedComponent_eq (mem_ordConnectedComponent.mp hwC)).symm⟩, rfl⟩

/-- **The clean arcs cover the essential set** (an essential point on no clean arc would be isolated in the essential set:
every essential point of `Γ` near it lies on an arc through it, joined to it through essential parameters). -/
theorem essSet_subset_cleanArcs : F.essSet ⊆ ⋃ b ∈ F.cleanArcs, b.carrier := by
  intro x hx
  by_contra hno
  obtain ⟨ρ₀, hG⟩ := F.exists_goodAt hx.1
  obtain ⟨ε, hε, hε0⟩ := ((eventually_clean_near hG).and (Ioo_mem_nhdsGT hG.pos)).exists
  refine notMem_essSet_of_isolated hε0.1 ((ball_subset_ball hε0.2.le).trans hG.subdom) ?_ hx
  intro z hz hzx hzE
  obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp (essSet_subset_Γ hzE).2
  have ha𝒜 : a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ ball x ρ₀).Nonempty} :=
    ⟨ha, z, hza, ball_subset_ball hε0.2.le hz⟩
  rw [a.carrier_eq_imageL] at hza
  obtain ⟨t, ht, rfl⟩ := hza
  have htA : t ∈ F.essParams a := ⟨ht, Or.inr hzE⟩
  obtain ⟨u, huI, hux, hut, hall⟩ := (hε a ha𝒜).2 t htA hz hzx
  have huA : u ∈ F.essParams a := ⟨huI, Or.inr (hux ▸ hx)⟩
  have hsub : uIcc u t ⊆ F.essParams a := fun t' ht' => by
    by_cases h : t' = u
    · exact h ▸ huA
    · exact hall t' ht' h
  have htC : t ∈ (F.essParams a).ordConnectedComponent u := mem_ordConnectedComponent.mpr hsub
  have huC : u ∈ (F.essParams a).ordConnectedComponent u := self_mem_ordConnectedComponent.mpr huA
  have hCI := essComp_eq_Icc a huA
  rw [hCI] at htC huC
  have hlt : sInf ((F.essParams a).ordConnectedComponent u) < sSup ((F.essParams a).ordConnectedComponent u) := by
    rcases lt_or_gt_of_ne hut with h | h
    · linarith [huC.1, htC.2]
    · linarith [htC.1, huC.2]
  apply hno
  refine mem_iUnion₂.mpr ⟨_, ⟨a, ha, u, huA, hlt, rfl⟩, ?_⟩
  rw [a.carrier_subL hlt.le]
  exact ⟨u, huC, hux⟩

/-- **The clean arcs inside the domain are exactly the essential set.** -/
theorem dom_inter_cleanArcs : F.dom ∩ ⋃ b ∈ F.cleanArcs, b.carrier = F.essSet := by
  refine Subset.antisymm ?_ fun x hx => ⟨hx.1, essSet_subset_cleanArcs hx⟩
  rintro z ⟨hzd, hz⟩
  obtain ⟨b, ⟨a, ha, u, huA, hlt, rfl⟩, hzb⟩ := mem_iUnion₂.mp hz
  rw [a.carrier_subL hlt.le, ← essComp_eq_Icc a huA] at hzb
  obtain ⟨w, hwC, rfl⟩ := hzb
  rcases (ordConnectedComponent_subset hwC).2 with h | h
  · exact absurd hzd h
  · exact h

/-! ## Cleaning: the clean map -/

variable (F) in
/-- The colour of the clean map: the colour at a point carrying exactly one (its own colour at an interior point). -/
noncomputable def cleanCol (x : ℂ) : Fin k := by
  classical
  exact if h : (F.coloursAt x).Nonempty then h.some else F.col x

/-- At a point of one colour, the clean colour is that colour. -/
theorem cleanCol_eq {x : ℂ} {j : Fin k} (h : F.coloursAt x = {j}) : F.cleanCol x = j := by
  have hne : (F.coloursAt x).Nonempty := h ▸ singleton_nonempty j
  unfold cleanCol
  rw [dif_pos hne]
  have hm : hne.some ∈ F.coloursAt x := hne.some_mem
  have hm' : hne.some ∈ ({j} : Set (Fin k)) := h ▸ hm
  exact hm'

variable (F) in
/-- **The clean map** (`exists_clean`): `F`'s domain, the clean arcs, the clean colour. -/
noncomputable def clean : ArcMap k where
  dom := F.dom
  isOpen_dom := F.isOpen_dom
  arcs := F.cleanArcs
  nondegenerate := fun _ hb => cleanArcs_nondegenerate hb
  locallyFinite := fun _ hx => cleanArcs_locallyFinite hx
  col := F.cleanCol
  locallyConstant := by
    intro x hx hxn
    have hxE : x ∉ F.essSet := fun h => hxn (essSet_subset_cleanArcs h)
    obtain ⟨j, hj⟩ := exists_coloursAt_eq_singleton hx hxE
    filter_upwards [eventually_coloursAt_eq_singleton hx hj] with y ⟨_, hy⟩
    rw [cleanCol_eq hy, cleanCol_eq hj]

/-- The clean map's `Γ` is the essential set. -/
theorem clean_Γ : F.clean.Γ = F.essSet := dom_inter_cleanArcs (F := F)

/-- The clean map's interior points are the domain off the essential set. -/
theorem clean_interiorPts : F.clean.interiorPts = F.dom \ F.essSet := by
  ext z
  constructor
  · rintro ⟨hzd, hz⟩
    exact ⟨hzd, fun h => hz (essSet_subset_cleanArcs h)⟩
  · rintro ⟨hzd, hz⟩
    exact ⟨hzd, fun h => hz (dom_inter_cleanArcs ▸ (⟨hzd, h⟩ : z ∈ F.dom ∩ ⋃ b ∈ F.cleanArcs, b.carrier))⟩

/-- `F`'s colour classes lie in the clean map's. -/
theorem region_subset_clean_region (j : Fin k) : F.region j ⊆ F.clean.region j := by
  rintro z ⟨hzI, hzj⟩
  refine ⟨?_, ?_⟩
  · rw [clean_interiorPts]
    refine ⟨hzI.1, fun h => ?_⟩
    have := essSet_subset_Γ h
    rw [mem_Γ_iff] at this
    exact this.2 hzI
  · show F.cleanCol z ∈ ({j} : Set (Fin k))
    rw [cleanCol_eq (coloursAt_eq_singleton_of_interior hzI)]
    exact hzj

/-- The clean map's colour classes lie in the closures of `F`'s. -/
theorem clean_region_subset_closure (j : Fin k) : F.clean.region j ⊆ closure (F.region j) := by
  rintro z ⟨hzI, hzj⟩
  rw [clean_interiorPts] at hzI
  obtain ⟨j', hj'⟩ := exists_coloursAt_eq_singleton hzI.1 hzI.2
  have h1 : F.cleanCol z = j' := cleanCol_eq hj'
  have h2 : F.cleanCol z = j := hzj
  show j ∈ F.coloursAt z
  rw [hj', ← h1, h2]
  rfl

/-- **Cleaning keeps the colours at every point.** -/
theorem coloursAt_clean (x : ℂ) : F.clean.coloursAt x = F.coloursAt x := by
  ext j
  show x ∈ closure (F.clean.region j) ↔ x ∈ closure (F.region j)
  exact ⟨fun h => closure_minimal (clean_region_subset_closure j) isClosed_closure h,
    fun h => closure_mono (region_subset_clean_region j) h⟩

/-- **The clean map is valid**: two points of one clean colour at distance `1`, moved together onto an interior point of `F`,
give a point of `F`'s class at distance `1` from a point of its closure (`ne1_region`). -/
theorem clean_valid (hF : F.Valid) : F.clean.Valid := by
  intro x hx y hy hxy hcol
  rw [clean_interiorPts] at hx hy
  obtain ⟨j, hj⟩ := exists_coloursAt_eq_singleton hx.1 hx.2
  obtain ⟨j', hj'⟩ := exists_coloursAt_eq_singleton hy.1 hy.2
  have hjj : j = j' := (cleanCol_eq hj).symm.trans (hcol.trans (cleanCol_eq hj'))
  subst hjj
  obtain ⟨δ, hδ, hδx⟩ := Metric.eventually_nhds_iff.mp (eventually_coloursAt_eq_singleton hx.1 hj)
  obtain ⟨δ', hδ', hδy⟩ := Metric.eventually_nhds_iff.mp (eventually_coloursAt_eq_singleton hy.1 hj')
  obtain ⟨z, hzI, hzx⟩ := Metric.mem_closure_iff.mp (F.dense_interiorPts hx.1) (min δ δ') (lt_min hδ hδ')
  have hzj : F.col z = j := by
    have := (hδx (show dist z x < δ by rw [dist_comm]; exact hzx.trans_le (min_le_left _ _))).2
    rw [coloursAt_eq_singleton_of_interior hzI] at this
    exact singleton_injective this
  have hy' : F.coloursAt (y + (z - x)) = {j} := by
    refine (hδy ?_).2
    rw [dist_eq_norm, add_sub_cancel_left, ← dist_eq_norm, dist_comm]
    exact hzx.trans_le (min_le_right _ _)
  have hycl : y + (z - x) ∈ closure (F.region j) := by
    show j ∈ F.coloursAt (y + (z - x))
    rw [hy']; rfl
  apply ne1_region hF hycl ⟨hzI, hzj⟩
  rw [dist_eq_norm, show z - (y + (z - x)) = x - y by ring, ← dist_eq_norm]
  exact hxy

/-- The clean map is clean. -/
theorem clean_isClean : F.clean.IsClean := by
  intro x hx
  rw [clean_Γ] at hx
  rw [coloursAt_clean]
  exact hx.2

/-- **Cleaning**: every valid map has a clean valid modification with the same colours at every point — the one-coloured parts of
`Γ` dropped (each arc replaced by its maximal sub-arcs of points of two or more colours), their points given the one colour around
them. -/
theorem exists_clean (hF : F.Valid) :
    ∃ F' : ArcMap k, F'.IsClean ∧ F'.Valid ∧ F.IsModification F' ∧ (∀ x, F'.coloursAt x = F.coloursAt x) ∧
      F'.Γ ⊆ F.Γ := by
  refine ⟨F.clean, clean_isClean, clean_valid hF, ⟨rfl, fun p x ⟨θ₁, θ₂, h12, hx, hsub⟩ => ⟨θ₁, θ₂, h12, hx, ?_⟩,
    fun x _ => (coloursAt_clean x).subset⟩, coloursAt_clean, ?_⟩
  · exact hsub.trans (clean_Γ.symm ▸ essSet_subset_Γ)
  · rw [clean_Γ]; exact essSet_subset_Γ

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

/-- The parametrisation of a segment is affine (a spec example for `Arc.ptL`). -/
example : (Arc.seg 0 2).ptL (1 / 2) = 1 := by norm_num [Arc.ptL]

/-- A circular arc's parameters are its angles (a spec example for `Arc.paramsL`). -/
example : (Arc.circ 0 1 0 π).paramsL = Icc 0 π := rfl

/-- A sub-arc of a circular arc keeps its circle (a spec example for `Arc.subL`). -/
example : (Arc.circ 0 1 0 π).subL 1 2 = Arc.circ 0 1 1 2 := rfl

/-- A sub-arc of a segment is the segment between the two parameters' points (a spec example for `Arc.subL`). -/
example : (Arc.seg 0 2).subL 0 (1 / 2) = Arc.seg 0 1 := by norm_num [Arc.subL]

/-- **`halfDiscMono` has no essential point**: its segment carries colour `0` on both sides (a spec example for `essSet`). -/
theorem halfDiscMono_essSet : halfDiscMono.essSet = ∅ := by
  rw [eq_empty_iff_forall_notMem]
  rintro x ⟨-, h2⟩
  have hsub : halfDiscMono.coloursAt x ⊆ {0} := by
    intro j hj
    obtain ⟨z, hz, -⟩ := Metric.mem_closure_iff.mp hj 1 one_pos
    have h : halfDiscMono.col z = j := hz.2
    rw [mem_singleton_iff, ← h]
    rfl
  have := ncard_le_ncard hsub (toFinite _)
  rw [ncard_singleton] at this
  omega

/-- **Cleaning drops a one-coloured arc**: the clean map of `halfDiscMono` has no `Γ` (a spec example for `cleanArcs` and
`clean`). -/
example : halfDiscMono.clean.Γ = ∅ := by
  rw [clean_Γ, halfDiscMono_essSet]

/-- The essential parameters of `halfDiscMono`'s segment: its start lies off the domain, so it is one; its midpoint `0` lies in the
domain with one colour, so it is not (a spec example for `essParams`). -/
example : (0 : ℝ) ∈ halfDiscMono.essParams (Arc.seg (-1 / 2) (1 / 2)) ∧
    (1 / 2 : ℝ) ∉ halfDiscMono.essParams (Arc.seg (-1 / 2) (1 / 2)) := by
  refine ⟨⟨⟨le_rfl, zero_le_one⟩, Or.inl ?_⟩, ?_⟩
  · show (-1 / 2 : ℂ) + ((0 : ℝ) : ℂ) * (1 / 2 - -1 / 2) ∉ ball 0 (1 / 3)
    rw [mem_ball_zero_iff]
    norm_num
  · rintro ⟨-, h | h⟩
    · apply h
      show (-1 / 2 : ℂ) + ((1 / 2 : ℝ) : ℂ) * (1 / 2 - -1 / 2) ∈ ball 0 (1 / 3)
      rw [mem_ball_zero_iff]
      norm_num
    · rw [halfDiscMono_essSet] at h
      exact h

/-- **Adversary**: cleaning keeps a two-coloured arc — the origin, on `halfDisc`'s segment between its two colours, stays on the
clean map's `Γ` (a spec example for `essSet` and `clean`). -/
example : (0 : ℂ) ∈ halfDisc.clean.Γ := by
  have key : ∀ s : ℝ, (s = 1 ∨ s = -1) → ∀ ε > 0, ∃ t : ℝ, t ≠ 0 ∧ |t| < 1 / 3 ∧ |t| < ε ∧
      (0 < s * t) := by
    intro s hs ε hε
    refine ⟨s * min (ε / 2) (1 / 6), ?_, ?_, ?_, ?_⟩
    · rcases hs with rfl | rfl <;> positivity
    · rcases hs with rfl | rfl <;>
      · simp only [one_mul, neg_one_mul, abs_neg]
        rw [abs_of_pos (by positivity)]
        exact lt_of_le_of_lt (min_le_right _ _) (by norm_num)
    · rcases hs with rfl | rfl <;>
      · simp only [one_mul, neg_one_mul, abs_neg]
        rw [abs_of_pos (by positivity)]
        exact lt_of_le_of_lt (min_le_left _ _) (by linarith)
    · rcases hs with rfl | rfl <;> nlinarith [lt_min (half_pos hε) (by norm_num : (0 : ℝ) < 1 / 6)]
  have hall : halfDisc.coloursAt 0 = univ := by
    ext j
    simp only [ArcMap.coloursAt, mem_setOf_eq, mem_univ, iff_true, Metric.mem_closure_iff]
    intro ε hε
    have hs : ((if j = 1 then 1 else -1 : ℝ) = 1 ∨ (if j = 1 then 1 else -1 : ℝ) = -1) := by
      split_ifs <;> simp
    obtain ⟨t, ht0, ht1, htε, hst⟩ := key _ hs ε hε
    refine ⟨(t : ℂ) * I, ⟨halfDisc_I_mul_mem ht0 ht1, ?_⟩, ?_⟩
    · simp only [mem_preimage, mem_singleton_iff, halfDisc, mul_im, ofReal_re, I_im, mul_one,
        ofReal_im, I_re, mul_zero, add_zero]
      fin_cases j
      · simp at hst; simp [not_lt.mpr (by linarith : t ≤ 0)]
      · simp at hst; simp [hst]
    · simpa [Complex.norm_mul, Complex.norm_I, Complex.norm_real] using htε
  rw [clean_Γ]
  refine ⟨mem_ball_self (by norm_num), ?_⟩
  rw [hall, ncard_univ, Nat.card_eq_fintype_card, Fintype.card_fin]

/-- The clean colour of an interior point is its colour (a spec example for `cleanCol`). -/
example : halfDisc.cleanCol (((1 / 6 : ℝ) : ℂ) * I) = 1 := by
  have hI := halfDisc_I_mul_mem (t := 1 / 6) (by norm_num) (by rw [abs_of_pos (by norm_num)]; norm_num)
  rw [cleanCol_eq (coloursAt_eq_singleton_of_interior hI)]
  simp [halfDisc]

end Spec

end HadwigerNelson.Plane
