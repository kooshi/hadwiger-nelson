import Proofs.HadwigerNelson.Plane.RingCalculus.Basic
import Mathlib.Analysis.Normed.Module.Connected

/-!
# The tiles of a point: finitely many, alone near the point, each crossing every small circle

Job FS131-I8A (`plans/FS131-I8A-implementation.md`, Stage 2), for `exists_ne_mem_closure_inter_of_split`
(`Plane/RingCalculus/Empty`): FS116-V6-COUNT's last step without sectors. Any arc map, any point `p` of its domain; no
validity, no colours.

* `finite_tileAt`: `p` has finitely many tiles.
* `exists_ball_tileAt`: within some radius of `p` every tile is a tile of `p`.
* `TileAt.inter_sphere_nonempty`: a tile of `p` meets every circle about `p` of radius below a good radius (it is
  connected, has points near `p`, and does not fit in the disc).
* `sphere_subset_iUnion_closure_tileAt`: a small circle about `p` lies in the union of the closures of the tiles of `p`.
* `isPreconnected_sphere_complex`: a circle in the plane is connected.
* `exists_fin_tileAt`: in a valid non-Siamese map the tiles of a point of at most `n` colours are listed by `Fin n`
  (for the counts of FS116-V6-HUBS and FS116-V6-COUNT, which read four tiles).

Spec example: the split lemma these serve is applied to `halfPlane2` at its change point `r(0)` in
`Plane/RingCalculus/Empty` (both groups of tiles inhabited); `exists_fin_tileAt`'s hypotheses are read on a valid
non-Siamese map only in `emptyNS`'s class, whose Lean model is owed (`Empty`'s header).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- A circle in the plane is connected. -/
theorem isPreconnected_sphere_complex (p : ℂ) (r : ℝ) : IsPreconnected (sphere p r) :=
  isPreconnected_sphere (by rw [Complex.rank_real_complex]; norm_num) p r

/-- A non-empty finite set of at most `n` elements is the range of a function on `Fin n`. -/
theorem exists_fin_surj_of_card_le {β : Type*} (s : Finset β) (hne : s.Nonempty) {n : ℕ} (hn : s.card ≤ n) :
    ∃ f : Fin n → β, (∀ i, f i ∈ s) ∧ ∀ x ∈ s, ∃ i, f i = x := by
  obtain ⟨x₀, hx₀⟩ := hne
  refine ⟨fun i => if h : i.val < s.card then (s.equivFin.symm ⟨i.val, h⟩ : β) else x₀, fun i => ?_, fun x hx => ?_⟩
  · dsimp only
    split_ifs with h
    · exact (s.equivFin.symm ⟨i.val, h⟩).2
    · exact hx₀
  · refine ⟨⟨(s.equivFin ⟨x, hx⟩).val, lt_of_lt_of_le (s.equivFin ⟨x, hx⟩).2 hn⟩, ?_⟩
    dsimp only
    rw [dif_pos (s.equivFin ⟨x, hx⟩).2]
    simp

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **A point of the domain has finitely many tiles.** -/
theorem finite_tileAt {p : ℂ} (hp : p ∈ F.dom) : {T | F.TileAt p T}.Finite := by
  obtain ⟨r, hr, hfin⟩ := F.finite_tiles_near hp
  refine hfin.subset fun T hT => ⟨hT.1, ?_⟩
  obtain ⟨w, hwb, hwT⟩ := mem_closure_iff_nhds.mp hT.2 _ (ball_mem_nhds p hr)
  exact ⟨w, hwT, hwb⟩

/-- **Near `p` every tile is a tile of `p`**: some ball about `p` lies in the domain, and a tile meeting it has `p` in
its closure. -/
theorem exists_ball_tileAt {p : ℂ} (hp : p ∈ F.dom) :
    ∃ ρ > 0, ball p ρ ⊆ F.dom ∧ ∀ T, F.IsTile T → (T ∩ ball p ρ).Nonempty → p ∈ closure T := by
  obtain ⟨r, hr, hfin⟩ := F.finite_tiles_near hp
  set 𝒮 : Set (Set ℂ) := {T | (F.IsTile T ∧ (T ∩ ball p r).Nonempty) ∧ p ∉ closure T} with h𝒮def
  have h𝒮 : 𝒮.Finite := hfin.subset fun T hT => hT.1
  have hopen : IsOpen (⋂ T ∈ 𝒮, (closure T)ᶜ) := h𝒮.isOpen_biInter fun T _ => isClosed_closure.isOpen_compl
  have hpU : p ∈ ⋂ T ∈ 𝒮, (closure T)ᶜ := mem_iInter₂.mpr fun T hT => hT.2
  obtain ⟨ρ₁, hρ₁, hsub⟩ := Metric.isOpen_iff.mp (hopen.inter (isOpen_ball.inter F.isOpen_dom)) p
    ⟨hpU, mem_ball_self hr, hp⟩
  refine ⟨ρ₁, hρ₁, fun z hz => (hsub hz).2.2, ?_⟩
  rintro T hT ⟨z, hzT, hzb⟩
  by_contra hpT
  have hTS : T ∈ 𝒮 := ⟨⟨hT, z, hzT, (hsub hzb).2.1⟩, hpT⟩
  exact mem_iInter₂.mp (hsub hzb).1 T hTS (subset_closure hzT)

/-- **A tile of `p` meets every small circle about `p`**: below a good radius the tile does not fit in the disc, it has
points near `p`, and it is connected. -/
theorem TileAt.inter_sphere_nonempty {p : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt p ρ₀) {T : Set ℂ} (hT : F.TileAt p T) {ρ : ℝ}
    (hρ0 : 0 < ρ) (hρ : ρ < ρ₀) : (T ∩ sphere p ρ).Nonempty := by
  obtain ⟨z₂, hz₂T, hz₂⟩ := not_subset.mp fun hsub => hG.not_tile_subset_ball hT.1 hρ hsub
  obtain ⟨z₁, hz₁b, hz₁T⟩ := mem_closure_iff_nhds.mp hT.2 _ (ball_mem_nhds p hρ0)
  have hcont : ContinuousOn (fun z : ℂ => dist z p) T := (continuous_id.dist continuous_const).continuousOn
  obtain ⟨z, hzT, hz⟩ := hT.1.isPreconnected.intermediate_value hz₁T hz₂T hcont
    ⟨(mem_ball.mp hz₁b).le, not_lt.mp fun h => hz₂ (mem_ball.mpr h)⟩
  exact ⟨z, hzT, mem_sphere.mpr hz⟩

/-- **A small circle about `p` lies in the closures of the tiles of `p`.** -/
theorem sphere_subset_iUnion_closure_tileAt {p : ℂ} {ρ₁ : ℝ} (hdom : ball p ρ₁ ⊆ F.dom)
    (hnear : ∀ T, F.IsTile T → (T ∩ ball p ρ₁).Nonempty → p ∈ closure T) {ρ : ℝ} (hρ : ρ < ρ₁) :
    sphere p ρ ⊆ ⋃ T ∈ {T | F.TileAt p T}, closure T := by
  intro z hz
  have hzb : z ∈ ball p ρ₁ := mem_ball.mpr (by rw [mem_sphere.mp hz]; exact hρ)
  obtain ⟨T, hT, hzT⟩ := F.mem_closure_tile (hdom hzb)
  obtain ⟨w, hwb, hwT⟩ := mem_closure_iff_nhds.mp hzT _ (isOpen_ball.mem_nhds hzb)
  exact mem_iUnion₂.mpr ⟨T, ⟨hT, hnear T hT ⟨w, hwT, hwb⟩⟩, hzT⟩

/-- **The tiles of a point, enumerated**: in a valid non-Siamese map a point of the domain carrying at most `n` colours
has its tiles listed by `Fin n` — one tile per colour (`NonSiamese.tile_eq_of_mem_closure`); the list may repeat. -/
theorem exists_fin_tileAt (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) {n : ℕ}
    (hn : (F.coloursAt p).ncard ≤ n) :
    ∃ tile : Fin n → Set ℂ, (∀ i, F.TileAt p (tile i)) ∧ ∀ T, F.TileAt p T → ∃ i, tile i = T := by
  have hfin : (F.coloursAt p).Finite := Set.toFinite _
  have hne : hfin.toFinset.Nonempty := by
    obtain ⟨c, hc⟩ := F.exists_mem_coloursAt hpd
    exact ⟨c, hfin.mem_toFinset.mpr hc⟩
  have hcard : hfin.toFinset.card ≤ n := by rw [← Set.ncard_eq_toFinset_card _ hfin]; exact hn
  obtain ⟨col, hcol, hsurj⟩ := exists_fin_surj_of_card_le hfin.toFinset hne hcard
  have hex : ∀ i, ∃ T, F.TileOf (col i) T ∧ p ∈ closure T := fun i =>
    (F.mem_coloursAt_iff_exists_tileOf hpd).mp (hfin.mem_toFinset.mp (hcol i))
  choose tile htile using hex
  refine ⟨tile, fun i => ⟨(htile i).1.1, (htile i).2⟩, fun T hT => ?_⟩
  obtain ⟨z, hz⟩ := hT.1.nonempty
  have hTc : F.TileOf (F.col z) T := hT.1.tileOf hz
  obtain ⟨i, hi⟩ := hsurj (F.col z) (hfin.mem_toFinset.mpr (mem_coloursAt_of_tileOf hTc hT.2))
  refine hN.tile_eq_of_mem_closure hF ?_ hTc (htile i).2 hT.2 |> fun h => ⟨i, h⟩
  rw [← hi]
  exact (htile i).1

end ArcMap

end HadwigerNelson.Plane
