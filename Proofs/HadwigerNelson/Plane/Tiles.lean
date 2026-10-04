import Proofs.HadwigerNelson.Plane.LocalStructure
import Proofs.HadwigerNelson.Plane.Diameter

/-!
# Tiles of one colour at the unit distance: N-E1, near and far, meeting tiles, clusters, the whole-tile restriction

Wave 3's tile rows (`plans/FS131-w3-kernel-plan.md`, stage 3), over `ArcMap` (`Plane/ArcMap`, `Plane/LocalMap`), every
one Siamese-allowed and at any number of colours `k`:

* **FS116-V5-NE1** — `ne1_region` (class form: a point of the closure of a colour class is at distance `≠ 1` from every
  point of the class) and its "in particular" for a tile `T` and a point `x` of its closure: `T ⊆ B(x, 1)`,
  `cl T ⊆ B̄(x, 1)`, every two points of `T` nearer than `1`;
* **FS116-V4-DICHOTOMY** — two tiles of one colour are near (`UnitNear`) or far (`UnitFar`); a tile is near itself and its
  closure has every two points within `1`; closure points below `1` make them near, above `1` far; in a non-Siamese map
  near tiles are equal;
* **FS116-V4-MEET** — two tiles of one colour with a common closure point are near the same tiles of that colour;
* **FS116-S1-CLUSTER** — a finite family of tiles of one colour whose closures have connected union, one point of it below
  `1` from the closure of a tile `U` of that colour, has every point within `1` of `cl U`;
* **FS129-OR1-WHOLE** — the whole-tile restriction `F_ρ` (`ArcMap.wholeRestrict`): valid, covering every smaller disc, its
  tiles exactly the tiles of `F` meeting `B(p, ρ)`, non-Siamese and simple inherited; and for `ρ ≤ √3`, no tile of `F_ρ` of
  colour `c` has `p + 2u` in its closure when `p + u` is a closure point of the inner part of a tile of colour `c`.

"A tile of colour `c`" in a hypothesis about closures is read as the colour class `F.region c` (`Plane/LocalMap`'s reading),
which is weaker as a hypothesis, so the formal theorem is the stronger.

**Inhabitants.** Every theorem here takes a valid `ArcMap`: `sixFrag_valid` (`Plane/SixFragment`) is one, as is any
one-colour map of a disc of radius below `1/2`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS116-V5-NE1 -/

/-- A valid map's colour classes have no unit pairs at all, so in particular null unit pairs. -/
theorem Valid.unitPairsNull_region (hF : F.Valid) (c : Fin k) : UnitPairsNull (F.region c) := by
  have : unitPairSet (F.region c) = ∅ := by
    ext ⟨x, θ⟩
    simp only [unitPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
    intro hx hy
    refine hF x hx.1 _ hy.1 ?_ (hx.2.trans hy.2.symm)
    simp [dist_eq_norm]
  rw [UnitPairsNull, this, MeasureTheory.measure_empty]

/-- **FS116-V5-NE1**, first clause (**N-E1**, class form): in a valid map, a point `x` of the closure of the class of `c` is
at distance `≠ 1` from every point `z` of the class (FS129-SR2-CLOSURE at the open class, per SR2 item 9). -/
theorem ne1_region (hF : F.Valid) {c : Fin k} {x z : ℂ} (hx : x ∈ closure (F.region c)) (hz : z ∈ F.region c) :
    dist z x ≠ 1 :=
  dist_ne_one_of_mem_of_mem_closure (F.isOpen_region c) (hF.unitPairsNull_region c) hz hx

/-- **The crossing engine** (child; every "N-E1 against a curve" step of the ring rows): in a valid map, for `z` in the
class of `c` and any preconnected `S` inside the closure of the class, every point of `S` is nearer than `1` to `z`, or
every point is farther. -/
theorem Valid.dist_lt_or_gt_of_isPreconnected (hF : F.Valid) {c : Fin k} {z : ℂ} (hz : z ∈ F.region c)
    {S : Set ℂ} (hS : IsPreconnected S) (hSc : S ⊆ closure (F.region c)) :
    (∀ s ∈ S, dist z s < 1) ∨ (∀ s ∈ S, 1 < dist z s) :=
  preconnected_dist_lt_or_gt hS fun _ hs => ne1_region hF (hSc hs) hz

/-- **FS116-V5-NE1**, "in particular" (i): every tile lies in the open unit disc about each point of its closure. -/
theorem IsTile.subset_ball (hF : F.Valid) {T : Set ℂ} (hT : F.IsTile T) {x : ℂ} (hx : x ∈ closure T) :
    T ⊆ ball x 1 := by
  obtain ⟨y, hy⟩ := hT.nonempty
  have hTc : T ⊆ F.region (F.col y) := fun s hs =>
    ⟨hT.subset_interiorPts hs, hT.col_eq hs hy⟩
  have hxc : x ∈ closure (F.region (F.col y)) := closure_mono hTc hx
  have hne : ∀ s ∈ T, dist x s ≠ 1 := fun s hs => by
    rw [dist_comm]; exact ne1_region hF hxc (hTc hs)
  rcases preconnected_dist_lt_or_gt hT.isPreconnected hne with h | h
  · intro s hs
    rw [mem_ball, dist_comm]; exact h s hs
  · exfalso
    obtain ⟨s, hs, hsd⟩ := Metric.mem_closure_iff.mp hx 1 one_pos
    have := h s hs
    linarith

/-- **FS116-V5-NE1**, "in particular" (ii): the closure of a tile lies in the closed unit disc about each point of it. -/
theorem IsTile.closure_subset_closedBall (hF : F.Valid) {T : Set ℂ} (hT : F.IsTile T) {x : ℂ}
    (hx : x ∈ closure T) : closure T ⊆ closedBall x 1 :=
  closure_minimal ((hT.subset_ball hF hx).trans ball_subset_closedBall) isClosed_closedBall

/-- **FS116-V5-NE1**, "in particular" (iii): every two points of a tile are nearer than `1` (the row's "diameter at most
1", pointwise and strict; FS106-DIAM (i) for the connectedness step, per SR2 item 9). -/
theorem IsTile.dist_lt_one (hF : F.Valid) {T : Set ℂ} (hT : F.IsTile T) :
    ∀ a ∈ T, ∀ b ∈ T, dist a b < 1 := fun a ha b hb => by
  have := hT.subset_ball hF (subset_closure ha) hb
  rwa [mem_ball, dist_comm] at this

/-! ## FS116-V4-DICHOTOMY -/

/-- **FS116-V4-DICHOTOMY**, first clause: two tiles of one colour (equal allowed) are near or far (FS111-M-HULL2's case
for two open tiles, per SR2 item 10). -/
theorem unitNear_or_unitFar (hF : F.Valid) {c : Fin k} {A B : Set ℂ} (hA : F.TileOf c A) (hB : F.TileOf c B) :
    UnitNear A B ∨ UnitFar A B := by
  obtain ⟨a₀, ha₀⟩ := hA.1.nonempty
  obtain ⟨b₀, hb₀⟩ := hB.1.nonempty
  have hAc : ∀ a ∈ A, a ∈ F.region c := fun a ha => hA.subset_region ha
  have hBc : ∀ b ∈ B, b ∈ F.region c := fun b hb => hB.subset_region hb
  rcases hF.dist_lt_or_gt_of_isPreconnected (hBc b₀ hb₀) hA.1.isPreconnected
      (fun a ha => subset_closure (hAc a ha)) with h | h
  · left
    intro a ha b hb
    rcases hF.dist_lt_or_gt_of_isPreconnected (hAc a ha) hB.1.isPreconnected
        (fun b hb => subset_closure (hBc b hb)) with h' | h'
    · exact h' b hb
    · have := h' b₀ hb₀
      have := h a ha
      rw [dist_comm] at this
      linarith
  · right
    intro a ha b hb
    rcases hF.dist_lt_or_gt_of_isPreconnected (hAc a ha) hB.1.isPreconnected
        (fun b hb => subset_closure (hBc b hb)) with h' | h'
    · have := h' b₀ hb₀
      have := h a ha
      rw [dist_comm] at this
      linarith
    · exact h' b hb

/-- **FS116-V4-DICHOTOMY**, "`A ~ A`" (FS106-DIAM (i), per SR2 item 9). -/
theorem IsTile.unitNear_self (hF : F.Valid) {A : Set ℂ} (hA : F.IsTile A) : UnitNear A A :=
  hA.dist_lt_one hF

/-- **FS116-V4-DICHOTOMY**, "so the closure of a tile has diameter at most 1" (pointwise). -/
theorem IsTile.dist_le_one_of_mem_closure (hF : F.Valid) {A : Set ℂ} (hA : F.IsTile A) :
    ∀ a ∈ closure A, ∀ b ∈ closure A, dist a b ≤ 1 := by
  have : closure A ×ˢ closure A ⊆ {q : ℂ × ℂ | dist q.1 q.2 ≤ 1} := by
    rw [← closure_prod_eq]
    exact closure_minimal (fun q hq => (hA.dist_lt_one hF _ hq.1 _ hq.2).le)
      (isClosed_le (continuous_fst.dist continuous_snd) continuous_const)
  exact fun a ha b hb => this (Set.mk_mem_prod ha hb)

/-- Near sets have closure points within `1`. -/
theorem UnitNear.dist_le_of_mem_closure {A B : Set ℂ} (h : UnitNear A B) {z z' : ℂ} (hz : z ∈ closure A)
    (hz' : z' ∈ closure B) : dist z z' ≤ 1 := by
  have : closure A ×ˢ closure B ⊆ {q : ℂ × ℂ | dist q.1 q.2 ≤ 1} := by
    rw [← closure_prod_eq]
    exact closure_minimal (fun q hq => (h _ hq.1 _ hq.2).le)
      (isClosed_le (continuous_fst.dist continuous_snd) continuous_const)
  exact this (Set.mk_mem_prod hz hz')

/-- Far sets have closure points at least `1` apart. -/
theorem UnitFar.one_le_dist_of_mem_closure {A B : Set ℂ} (h : UnitFar A B) {z z' : ℂ} (hz : z ∈ closure A)
    (hz' : z' ∈ closure B) : 1 ≤ dist z z' := by
  have : closure A ×ˢ closure B ⊆ {q : ℂ × ℂ | 1 ≤ dist q.1 q.2} := by
    rw [← closure_prod_eq]
    exact closure_minimal (fun q hq => (h _ hq.1 _ hq.2).le)
      (isClosed_le continuous_const (continuous_fst.dist continuous_snd))
  exact this (Set.mk_mem_prod hz hz')

/-- **FS116-V4-DICHOTOMY**: closure points of two tiles of one colour at distance below `1` make the tiles near. -/
theorem unitNear_of_mem_closure (hF : F.Valid) {c : Fin k} {A B : Set ℂ} (hA : F.TileOf c A) (hB : F.TileOf c B)
    {z z' : ℂ} (hz : z ∈ closure A) (hz' : z' ∈ closure B) (h : dist z z' < 1) : UnitNear A B := by
  rcases unitNear_or_unitFar hF hA hB with hn | hf
  · exact hn
  · exact absurd (UnitFar.one_le_dist_of_mem_closure hf hz hz') (not_le.mpr h)

/-- **FS116-V4-DICHOTOMY**: closure points of two tiles of one colour at distance above `1` make the tiles far. -/
theorem unitFar_of_mem_closure (hF : F.Valid) {c : Fin k} {A B : Set ℂ} (hA : F.TileOf c A) (hB : F.TileOf c B)
    {z z' : ℂ} (hz : z ∈ closure A) (hz' : z' ∈ closure B) (h : 1 < dist z z') : UnitFar A B := by
  rcases unitNear_or_unitFar hF hA hB with hn | hf
  · exact absurd (UnitNear.dist_le_of_mem_closure hn hz hz') (not_le.mpr h)
  · exact hf

/-- **FS116-V4-DICHOTOMY**, last clause: in a non-Siamese map near tiles of one colour are equal (validity is not read). -/
theorem NonSiamese.eq_of_unitNear (hN : F.NonSiamese) {c : Fin k} {A B : Set ℂ} (hA : F.TileOf c A)
    (hB : F.TileOf c B) (h : UnitNear A B) : A = B := by
  by_contra hne
  exact hN A B ⟨hA.1, hB.1, hne, fun x hx y hy => (hA.2 hx).trans (hB.2 hy).symm, h⟩

/-! ## FS116-V4-MEET -/

/-- **FS116-V4-MEET**: if tiles `A`, `B` of one colour have a common closure point, every tile `T` of that colour is near
`A` exactly when it is near `B`. -/
theorem unitNear_iff_of_mem_closure_inter (hF : F.Valid) {c : Fin k} {A B T : Set ℂ} (hA : F.TileOf c A)
    (hB : F.TileOf c B) {z : ℂ} (hzA : z ∈ closure A) (hzB : z ∈ closure B) (hT : F.TileOf c T) :
    UnitNear T A ↔ UnitNear T B := by
  have key : ∀ {A B : Set ℂ}, F.TileOf c A → F.TileOf c B → z ∈ closure A → z ∈ closure B →
      UnitNear T A → UnitNear T B := by
    intro A B hA hB hzA hzB hn
    have hzc : z ∈ closure (F.region c) := closure_mono hB.subset_region hzB
    have hlt : ∀ t ∈ T, dist t z < 1 := fun t ht =>
      lt_of_le_of_ne (UnitNear.dist_le_of_mem_closure hn (subset_closure ht) hzA)
        (ne1_region hF hzc (hT.subset_region ht))
    obtain ⟨t₀, ht₀⟩ := hT.1.nonempty
    exact unitNear_of_mem_closure hF hT hB (subset_closure ht₀) hzB (hlt t₀ ht₀)
  exact ⟨key hA hB hzA hzB, key hB hA hzB hzA⟩

/-! ## FS116-S1-CLUSTER -/

/-- **FS116-S1-CLUSTER**: let `𝒯` be a finite family of tiles of colour `c` whose closures have connected union, and `U` a
tile of colour `c`; if some point of the union is nearer than `1` to some point of `cl U`, every point of the union is
within `1` of every point of `cl U`. -/
theorem cluster (hF : F.Valid) {c : Fin k} {𝒯 : Set (Set ℂ)} (hfin : 𝒯.Finite) (h𝒯 : ∀ T ∈ 𝒯, F.TileOf c T)
    (hconn : IsPreconnected (⋃ T ∈ 𝒯, closure T)) {U : Set ℂ} (hU : F.TileOf c U)
    (hnear : ∃ x ∈ ⋃ T ∈ 𝒯, closure T, ∃ y ∈ closure U, dist x y < 1) :
    ∀ x ∈ ⋃ T ∈ 𝒯, closure T, ∀ y ∈ closure U, dist x y ≤ 1 := by
  classical
  obtain ⟨x₀, hx₀, y₀, hy₀, hd₀⟩ := hnear
  obtain ⟨u₀, hu₀⟩ := hU.1.nonempty
  set u : Set ℂ := ⋃ T ∈ {T ∈ 𝒯 | UnitNear T U}, closure T with hu
  set v : Set ℂ := ⋃ T ∈ {T ∈ 𝒯 | UnitFar T U}, closure T with hv
  have hfu : {T ∈ 𝒯 | UnitNear T U}.Finite := hfin.subset fun T hT => hT.1
  have hfv : {T ∈ 𝒯 | UnitFar T U}.Finite := hfin.subset fun T hT => hT.1
  have huc : IsClosed u := hfu.isClosed_biUnion fun T _ => isClosed_closure
  have hvc : IsClosed v := hfv.isClosed_biUnion fun T _ => isClosed_closure
  have hcov : (⋃ T ∈ 𝒯, closure T) ⊆ u ∪ v := by
    intro x hx
    obtain ⟨T, hT, hxT⟩ := mem_iUnion₂.mp hx
    rcases unitNear_or_unitFar hF (h𝒯 T hT) hU with hn | hf
    · exact Or.inl (mem_iUnion₂.mpr ⟨T, ⟨hT, hn⟩, hxT⟩)
    · exact Or.inr (mem_iUnion₂.mpr ⟨T, ⟨hT, hf⟩, hxT⟩)
  have hx₀u : x₀ ∈ u := by
    obtain ⟨T, hT, hxT⟩ := mem_iUnion₂.mp hx₀
    rcases unitNear_or_unitFar hF (h𝒯 T hT) hU with hn | hf
    · exact mem_iUnion₂.mpr ⟨T, ⟨hT, hn⟩, hxT⟩
    · exact absurd (UnitFar.one_le_dist_of_mem_closure hf hxT hy₀) (not_le.mpr hd₀)
  intro x hx y hy
  by_contra hxy
  push Not at hxy
  have hxv : x ∈ v := by
    obtain ⟨T, hT, hxT⟩ := mem_iUnion₂.mp hx
    rcases unitNear_or_unitFar hF (h𝒯 T hT) hU with hn | hf
    · exact absurd (UnitNear.dist_le_of_mem_closure hn hxT hy) (not_le.mpr hxy)
    · exact mem_iUnion₂.mpr ⟨T, ⟨hT, hf⟩, hxT⟩
  obtain ⟨z, hz, hzu, hzv⟩ := isPreconnected_closed_iff.mp hconn u v huc hvc hcov ⟨x₀, hx₀, hx₀u⟩ ⟨x, hx, hxv⟩
  obtain ⟨T₁, ⟨-, hT₁⟩, hzT₁⟩ := mem_iUnion₂.mp hzu
  obtain ⟨T₂, ⟨-, hT₂⟩, hzT₂⟩ := mem_iUnion₂.mp hzv
  have h1 := UnitNear.dist_le_of_mem_closure hT₁ hzT₁ (subset_closure hu₀)
  have h2 := UnitFar.one_le_dist_of_mem_closure hT₂ hzT₂ (subset_closure hu₀)
  have hzc : z ∈ closure (F.region c) := by
    obtain ⟨T, hT, hzT⟩ := mem_iUnion₂.mp hz
    exact closure_mono (h𝒯 T hT).subset_region hzT
  exact ne1_region hF hzc (hU.subset_region hu₀) (by rw [dist_comm]; exact le_antisymm h1 h2)

/-! ## FS129-OR1-WHOLE: the whole-tile restriction -/

/-- **FS129-OR1-WHOLE**, validity: `F_ρ` is valid when `F` is. -/
theorem Valid.wholeRestrict (hF : F.Valid) (p : ℂ) (ρ : ℝ) : (F.wholeRestrict p ρ).Valid := by
  intro x hx y hy hxy
  have hx' : x ∈ F.interiorPts := ⟨(F.wholeRestrict p ρ).interiorPts_subset_dom hx |>.1, hx.2⟩
  have hy' : y ∈ F.interiorPts := ⟨(F.wholeRestrict p ρ).interiorPts_subset_dom hy |>.1, hy.2⟩
  exact hF x hx' y hy' hxy

/-- The interior points of `F_ρ`: those of `F` inside the interior of the union of the closures of the tiles meeting
`B(p, ρ)`. -/
theorem wholeRestrict_interiorPts (p : ℂ) (ρ : ℝ) :
    (F.wholeRestrict p ρ).interiorPts =
      F.interiorPts ∩ interior (⋃₀ {S | ∃ T, F.IsTile T ∧ (T ∩ ball p ρ).Nonempty ∧ S = closure T}) := by
  ext x
  simp only [interiorPts, wholeRestrict, restrict, wholeDom, Set.mem_sdiff, mem_inter_iff]
  tauto

/-- **FS129-OR1-WHOLE**, the disc: if `F` covers `B̄(p, r)` and `ρ ≤ r`, then `F_ρ` covers `B̄(p, ρ')` for every `ρ' < ρ`
(finitely many tiles meet a small disc about each point, `finite_tiles_near`). -/
theorem wholeRestrict_covers {p : ℂ} {r ρ ρ' : ℝ} (hr : F.Covers p r) (hρ : ρ ≤ r) (hρ' : ρ' < ρ) :
    (F.wholeRestrict p ρ).Covers p ρ' := by
  intro y hy
  have hyb : y ∈ ball p ρ := by
    rw [mem_ball]; exact lt_of_le_of_lt (mem_closedBall.mp hy) hρ'
  have hball : ball p ρ ⊆ ⋃₀ {S | ∃ T, F.IsTile T ∧ (T ∩ ball p ρ).Nonempty ∧ S = closure T} := by
    intro z hz
    obtain ⟨T, hT, hzT⟩ := F.mem_closure_tile
      (hr ((ball_subset_closedBall.trans (closedBall_subset_closedBall hρ)) hz))
    refine ⟨closure T, ⟨T, hT, ?_, rfl⟩, hzT⟩
    obtain ⟨w, hw, hwT⟩ := mem_closure_iff.mp hzT (ball p ρ) isOpen_ball hz
    exact ⟨w, hwT, hw⟩
  exact ⟨hr (closedBall_subset_closedBall (hρ'.le.trans hρ) hy),
    interior_maximal hball isOpen_ball hyb⟩

/-- **FS129-OR1-WHOLE**, the tiles: the tiles of `F_ρ` are exactly the tiles of `F` meeting `B(p, ρ)` (the same sets, so
the same closures and the same colours). -/
theorem isTile_wholeRestrict_iff {p : ℂ} {ρ : ℝ} {T : Set ℂ} :
    (F.wholeRestrict p ρ).IsTile T ↔ F.IsTile T ∧ (T ∩ ball p ρ).Nonempty := by
  set U := ⋃₀ {S | ∃ T, F.IsTile T ∧ (T ∩ ball p ρ).Nonempty ∧ S = closure T} with hU
  have hint := wholeRestrict_interiorPts (F := F) p ρ
  rw [← hU] at hint
  have hcol : (F.wholeRestrict p ρ).arcs = F.arcs := rfl
  constructor
  · rintro ⟨x, hx, rfl⟩
    rw [hint] at hx
    obtain ⟨hxI, hxU⟩ := hx
    obtain ⟨S, ⟨T'', hT'', hmeet, rfl⟩, hxT''⟩ := interior_subset hxU
    -- the tile of `F` through `x` is `T''`
    have hxTile : F.IsTile (connectedComponentIn F.interiorPts x) := ⟨x, hxI, rfl⟩
    obtain ⟨w, hw, hwT⟩ := mem_closure_iff.mp hxT'' _ hxTile.isOpen (mem_connectedComponentIn hxI)
    have hT''eq : connectedComponentIn F.interiorPts x = T'' := by
      obtain ⟨y'', hy'', rfl⟩ := hT''
      have hw2 : w ∈ connectedComponentIn F.interiorPts y'' := hwT
      rw [connectedComponentIn_eq hw, ← connectedComponentIn_eq hw2]
    have hsubU : connectedComponentIn F.interiorPts x ⊆ interior U := by
      rw [hT''eq]
      refine interior_maximal ?_ (hT''.isOpen)
      exact fun z hz => ⟨closure T'', ⟨T'', hT'', hmeet, rfl⟩, subset_closure hz⟩
    have hsubW : connectedComponentIn F.interiorPts x ⊆ (F.wholeRestrict p ρ).interiorPts := by
      rw [hint]
      exact fun z hz => ⟨connectedComponentIn_subset _ _ hz, hsubU hz⟩
    have heq : connectedComponentIn (F.wholeRestrict p ρ).interiorPts x =
        connectedComponentIn F.interiorPts x := by
      refine Subset.antisymm ?_ ?_
      · exact connectedComponentIn_mono x (by rw [hint]; exact inter_subset_left)
      · exact isPreconnected_connectedComponentIn.subset_connectedComponentIn
          (mem_connectedComponentIn hxI) hsubW
    rw [heq]
    exact ⟨hxTile, by rw [hT''eq]; exact hmeet⟩
  · rintro ⟨hT, hmeet⟩
    obtain ⟨x, hxT⟩ := hT.nonempty
    have hxI : x ∈ F.interiorPts := hT.subset_interiorPts hxT
    have hTeq : T = connectedComponentIn F.interiorPts x := by
      obtain ⟨y, hy, rfl⟩ := hT
      exact connectedComponentIn_eq hxT
    have hsubU : T ⊆ interior U :=
      interior_maximal (fun z hz => ⟨closure T, ⟨T, hT, hmeet, rfl⟩, subset_closure hz⟩) hT.isOpen
    have hsubW : T ⊆ (F.wholeRestrict p ρ).interiorPts := by
      rw [hint]; exact fun z hz => ⟨hT.subset_interiorPts hz, hsubU hz⟩
    refine ⟨x, hsubW hxT, ?_⟩
    refine Subset.antisymm ?_ ?_
    · exact hT.isPreconnected.subset_connectedComponentIn hxT hsubW
    · rw [hTeq]
      exact connectedComponentIn_mono x (by rw [hint]; exact inter_subset_left)

/-- **FS129-OR1-WHOLE**, the tiles at `p`: for `ρ > 0`, a tile of `F` with `p` in its closure is a tile of `F_ρ` (and
conversely, by `isTile_wholeRestrict_iff`). -/
theorem isTile_wholeRestrict_of_mem_closure {p : ℂ} {ρ : ℝ} (hρ : 0 < ρ) {T : Set ℂ} (hT : F.IsTile T)
    (hp : p ∈ closure T) : (F.wholeRestrict p ρ).IsTile T := by
  refine isTile_wholeRestrict_iff.mpr ⟨hT, ?_⟩
  obtain ⟨w, hw, hwT⟩ := mem_closure_iff.mp hp (ball p ρ) isOpen_ball (mem_ball_self hρ)
  exact ⟨w, hwT, hw⟩

/-- **FS129-OR1-WHOLE**: `F_ρ` is non-Siamese if `F` is. -/
theorem NonSiamese.wholeRestrict (hN : F.NonSiamese) (p : ℂ) (ρ : ℝ) : (F.wholeRestrict p ρ).NonSiamese := by
  rintro T T' ⟨hT, hT', hne, hcol, hd⟩
  exact hN T T' ⟨(isTile_wholeRestrict_iff.mp hT).1, (isTile_wholeRestrict_iff.mp hT').1, hne, hcol, hd⟩

/-- **FS129-OR1-WHOLE**: `F_ρ` is simple if `F` is (closures read in the plane, as the row reads them). -/
theorem Simple.wholeRestrict (hS : F.Simple) (p : ℂ) (ρ : ℝ) : (F.wholeRestrict p ρ).Simple :=
  ⟨fun T hT => hS.1 T (isTile_wholeRestrict_iff.mp hT).1, fun T T' hT hT' hne =>
    hS.2 T T' (isTile_wholeRestrict_iff.mp hT).1 (isTile_wholeRestrict_iff.mp hT').1 hne⟩

/-- **FS129-OR1-WHOLE**, the `R₂` clause, at the class its argument reads (pointwise in the arc, and with no use of the
arc lying in `Γ`): for `ρ ≤ √3`, if `p + e θ` is a closure point of the part inside `B(p, 1)` of a tile `T` of colour `c`
of `F`, no tile of `F_ρ` of colour `c` has `p + 2 e θ` in its closure. (A tile of `F_ρ` of colour `c` lies in
`B(p + 2e θ, 1)` and meets `B(p, √3)`, so by the parallelogram identity it comes within `1` of `p + e θ`, hence of `T`:
`T` and it are near, while the points of `T ∩ B(p, 1)` are more than `1` from `p + 2e θ`.) -/
theorem not_mem_closure_wholeRestrict_of_inner {p : ℂ} {ρ : ℝ} (hF : F.Valid) (hρ : ρ ≤ √3) {c : Fin k}
    {T : Set ℂ} (hT : F.TileOf c T) {θ : ℝ} (hθ : ringPt p θ ∈ closure (T ∩ ball p 1)) {T' : Set ℂ}
    (hT' : (F.wholeRestrict p ρ).TileOf c T') : p + 2 * e θ ∉ closure T' := by
  intro hq
  obtain ⟨hT'F, hmeet⟩ := isTile_wholeRestrict_iff.mp hT'.1
  have hT'c : F.TileOf c T' := ⟨hT'F, hT'.2⟩
  obtain ⟨w, hwT', hwb⟩ := hmeet
  have hwq : dist w (p + 2 * e θ) < 1 := by
    have := hT'F.subset_ball hF hq hwT'
    rwa [mem_ball] at this
  have hwp : ‖w - p‖ < √3 := lt_of_lt_of_le (by simpa [dist_eq_norm] using hwb) hρ
  have hy : dist (ringPt p θ) w < 1 := by
    have hpar := parallelogram_law_with_norm ℝ (w - p - e θ) (e θ)
    have h1 : w - p - e θ + e θ = w - p := by ring
    have h2 : w - p - e θ - e θ = w - (p + 2 * e θ) := by ring
    rw [h1, h2, norm_e] at hpar
    have h3 : ‖w - (p + 2 * e θ)‖ < 1 := by simpa [dist_eq_norm] using hwq
    have h4 : ‖w - p‖ ^ 2 < 3 := by
      have : ‖w - p‖ ^ 2 < √3 ^ 2 := by gcongr
      rwa [Real.sq_sqrt (by norm_num)] at this
    have h5 : ‖w - (p + 2 * e θ)‖ ^ 2 < 1 := by nlinarith [norm_nonneg (w - (p + 2 * e θ))]
    have h6 : ‖w - p - e θ‖ ^ 2 < 1 := by nlinarith
    have h7 : ‖w - p - e θ‖ < 1 := by
      by_contra hge; push Not at hge; nlinarith [norm_nonneg (w - p - e θ)]
    rw [dist_comm, dist_eq_norm]
    simpa [ringPt, sub_sub] using h7
  have hyT : ringPt p θ ∈ closure T := closure_mono inter_subset_left hθ
  have hnear := unitNear_of_mem_closure hF hT hT'c hyT (subset_closure hwT') hy
  obtain ⟨t, htT, htb⟩ : (T ∩ ball p 1).Nonempty := by
    by_contra hne
    rw [not_nonempty_iff_eq_empty] at hne
    rw [hne, closure_empty] at hθ
    exact hθ
  have h1 := UnitNear.dist_le_of_mem_closure hnear (subset_closure htT) hq
  have h2 : 1 < dist t (p + 2 * e θ) := by
    have htp : ‖t - p‖ < 1 := by simpa [dist_eq_norm] using htb
    have : ‖(p + 2 * e θ) - p‖ = 2 := by simp
    have htri : ‖(p + 2 * e θ) - p‖ ≤ ‖(p + 2 * e θ) - t‖ + ‖t - p‖ := by
      calc _ = ‖((p + 2 * e θ) - t) + (t - p)‖ := by ring_nf
        _ ≤ _ := norm_add_le _ _
    rw [dist_comm, dist_eq_norm]
    linarith
  linarith

/-- **FS129-OR1-WHOLE**, the `R₂` clause in the row's form: for `ρ ≤ √3` and an arc `r([θ₁, θ₂])` of `ω(p)` of positive
length whose inner side is one tile `T`, of colour `c` (every interior angle has the points `p + (1 − η) e θ`, `η > 0`
small, in `T`), no tile of `F_ρ` of colour `c` has a point of `R₂(ᾱ) = {p + 2u : p + u ∈ ᾱ}` in its closure. -/
theorem not_mem_closure_wholeRestrict_R₂ {p : ℂ} {ρ : ℝ} (hF : F.Valid) (hρ : ρ ≤ √3) {c : Fin k} {T : Set ℂ}
    (hT : F.TileOf c T) {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂)
    (hinner : ∀ θ ∈ Ioo θ₁ θ₂, ∃ δ > 0, ∀ η ∈ Ioo 0 δ, p + ((1 - η : ℝ) : ℂ) * e θ ∈ T) {T' : Set ℂ}
    (hT' : (F.wholeRestrict p ρ).TileOf c T') : ∀ θ ∈ Icc θ₁ θ₂, p + 2 * e θ ∉ closure T' := by
  have hcl : IsClosed {θ : ℝ | ringPt p θ ∈ closure (T ∩ ball p 1)} :=
    isClosed_closure.preimage (by unfold ringPt e; fun_prop)
  have hIoo : Ioo θ₁ θ₂ ⊆ {θ : ℝ | ringPt p θ ∈ closure (T ∩ ball p 1)} := by
    intro θ hθ
    obtain ⟨δ, hδ, hη⟩ := hinner θ hθ
    rw [mem_setOf_eq, Metric.mem_closure_iff]
    intro ε hε
    set η := min (min (δ / 2) (ε / 2)) (1 / 2) with hηdef
    have hη0 : 0 < η := lt_min (lt_min (half_pos hδ) (half_pos hε)) (by norm_num)
    have hηδ : η < δ := lt_of_le_of_lt ((min_le_left _ _).trans (min_le_left _ _)) (by linarith)
    have hηε : η < ε := lt_of_le_of_lt ((min_le_left _ _).trans (min_le_right _ _)) (by linarith)
    have hη1 : η ≤ 1 / 2 := min_le_right _ _
    refine ⟨p + ((1 - η : ℝ) : ℂ) * e θ, ⟨hη _ ⟨hη0, hηδ⟩, ?_⟩, ?_⟩
    · rw [mem_ball, dist_eq_norm]
      simp only [add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs]
      rw [abs_of_pos (by linarith)]; linarith
    · rw [dist_eq_norm]
      have : ringPt p θ - (p + ((1 - η : ℝ) : ℂ) * e θ) = (η : ℂ) * e θ := by
        simp only [ringPt]; push_cast; ring
      rw [this, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hη0]
      exact hηε
  intro θ hθ
  have hmem : θ ∈ {θ : ℝ | ringPt p θ ∈ closure (T ∩ ball p 1)} := by
    have : closure (Ioo θ₁ θ₂) ⊆ {θ : ℝ | ringPt p θ ∈ closure (T ∩ ball p 1)} :=
      closure_minimal hIoo hcl
    rw [closure_Ioo h12.ne] at this
    exact this hθ
  exact not_mem_closure_wholeRestrict_of_inner hF hρ hT hmem hT'

end ArcMap

end HadwigerNelson.Plane
