import Proofs.HadwigerNelson.Plane.RingCalculus.Basic

/-!
# The ring calculus: the germ lemma in tile form, the star at a change point, reciprocity, antipodal hubs

Wave 8's first module (`plans/FS131-w8-kernel-plan.md`, Stages 2–4; job FS131-K8). What the ring of a vertex `p` passes to a
change point `y = r(ψ)` it places: which tiles of `p` reach `y` (the tips), which colours of `p` come to `y` on other
tiles (the outer tiles), and where each sits in the star of `p`. Each row is stated at the class its argument reads
(G92); where the row is `k = 6` and the argument reads the number of colours absent at `p`, the statement is at every `k`
with that count, as in `Plane/RingGerm`. "On a closed disc of radius above 1 about `p`" is `F.Covers p 1`
(`ArcMap.covers_one_iff`).

| row | declarations | state |
|---|---|---|
| FS116-RING-GERM | first clause: `germS_absent` (`Plane/RingGerm`); (i) `ringGerm_inward`; (ii) `ringGerm_outward`; (iii) `germS_four` (`Plane/RingGerm`) | proved |
| FS116-N2-STAR | `star_coloursAt`, `star_absent`, `IsTip.coneAt_subset` (`…/Basic`), `star_outer_cone`, `star_flank`, `star_flank_interior`, `star_tip_nonempty`, `star_outer_nonempty` | proved |
| FS116-N2-RECIP | `ringPt_ringPt_add_pi`, `exists_tileOf_of_germIn`, `star_recip` | proved (job FS131-I8A) |
| FS116-N2-ANTI | `mem_coneAt_add_int_mul_two_pi`, `false_of_antipodal_gaps`, `star_anti_ne`, `star_anti_count`, `star_anti` | proved (job FS131-I8B), with the two hypotheses of inventory item 568: no other tile of `p` approaches along `ψ ± 90°` |

**What is wider than the rows** (each reported as a generalization):
* RING-GERM (ii) and STAR's outer clause need no non-Siamese hypothesis in tile form: the tile approaching `y` from outside
  `B̄(p, 1)` is no tile of `p` because a tile of `p` lies in `B(p, 1)`.
* STAR's flank clause (`star_flank`) holds for any tile of any valid map, at any point `p` and any `ψ`: a tile approaching
  `p` along one direction within `90°` of `ψ` and one direction beyond `90°` has a point at distance exactly `1` from
  `r(ψ)` (it is connected), so its colour is absent at `r(ψ)`. No change point, no count of colours, and "in the interior
  of its cone" weakened to "a direction on either side" — which also covers a tile bounded at `p` by a cusp.
* RECIP reads a change point `y` of four colours, never that `y` is a hub, and never the non-Siamese hypothesis.
* ANTI reads *simple* only at the tiles of `p`: `F.SimpleOn {p}`.

**Inhabitants.** The class of these rows — a valid map with a vertex of at least four colours, at most two colours absent,
and a change point on its ring — has no Lean inhabitant yet: the held ones are FS114-Y2-BOWTIE's centre (wave 7) and
FS114-Y-DIAL's strip (as `Plane/RingGerm`'s header says for wave 3's rows of the same class). A hub needs more: no held
fragment has one (`plans/FS116-N2-proof.md` § 2.4), and on a Γ-free ring none exists (FS129-SR3-EMPTY-NS,
`Plane/RingCalculus/Empty`); so `star_tip_nonempty` and `star_outer_nonempty` are each met by held fragments (the bowtie's
top has a tip and an outer tile), while RECIP's and ANTI's hypotheses have no held model and their satisfiability is open
(the hub question of FS-124; an object meeting the local hypotheses but one is the strip's `P₀`, which fails ANTI's
interiority of the flank directions).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS116-RING-GERM, in tile form -/

/-- **FS116-RING-GERM (i)**: at a change point `y = r(ψ)` of the ring of a vertex `p` of at least four colours with at
most two colours absent, in a valid non-Siamese map, if the tip pair `{v⁻, u⁺}` lies on no (Q) arc, every direction at `y`
in the open `60°` cone about the direction to `p` lies in the cone of a tip at `y` — a tile of `p`.
(Inhabitants: the module docstring.) -/
theorem ringGerm_inward (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k}
    (hy : F.IsChangePoint p ψ X X') (ht : F.TipPairFree p ψ) :
    ∀ β ∈ Ioo (ψ + 5 * π / 6) (ψ + 7 * π / 6), ∃ T, F.IsTip p (ringPt p ψ) T ∧ β ∈ coneAt T (ringPt p ψ) := by
  intro β hβ
  have hyd : ringPt p ψ ∈ F.dom := hp (mem_closedBall.mpr (dist_ringPt p ψ).le)
  have hpd : p ∈ F.dom := hp (mem_closedBall_self zero_le_one)
  obtain ⟨c, hcp, hβc, -⟩ := germS_inward hF hp h4 hk hy ht.1 ht.2 β hβ
  rw [F.coneAt_region_eq_biUnion hyd c] at hβc
  obtain ⟨T, ⟨hT, hyT⟩, hβT⟩ := mem_iUnion₂.mp hβc
  obtain ⟨Tc, hTc, hpTc⟩ := (F.mem_coloursAt_iff_exists_tileOf hpd).mp hcp
  have hcos : Real.cos (β - ψ) < 0 :=
    Real.cos_neg_of_pi_div_two_lt_of_lt (by linarith [hβ.1, Real.pi_pos]) (by linarith [hβ.2, Real.pi_pos])
  obtain ⟨z, hzT, hzp⟩ := inter_ball_nonempty_of_inward_cone hβT hcos
  have hTT : T = Tc := hN.tile_eq_of_dist_lt hF hT hTc (subset_closure hzT) hpTc (mem_ball.mp hzp)
  exact ⟨T, ⟨hT.1, hTT ▸ hpTc, hyT⟩, hβT⟩

/-- **FS116-RING-GERM (ii)** (no non-Siamese hypothesis): if the outer pair `{u⁻, v⁺}` lies on no (Q) arc, every direction
at `y` in the open `60°` cone about the direction away from `p` lies in the cone of an outer tile at `y` — a tile of a
colour of `p` that is not a tile of `p`. (Inhabitants: the module docstring.) -/
theorem ringGerm_outward (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k} (hy : F.IsChangePoint p ψ X X')
    (ho : F.OuterPairFree p ψ) :
    ∀ β ∈ Ioo (ψ - π / 6) (ψ + π / 6), ∃ T, F.IsOuterTileAt p (ringPt p ψ) T ∧ β ∈ coneAt T (ringPt p ψ) := by
  intro β hβ
  have hyd : ringPt p ψ ∈ F.dom := hp (mem_closedBall.mpr (dist_ringPt p ψ).le)
  obtain ⟨c, hcp, hβc, hmiss⟩ := germS_outward hF hp h4 hk hy ho.1 ho.2 β hβ
  have hβc' : β ∈ coneAt (F.region c) (ringPt p ψ) := coneAt_mono sdiff_subset _ hβc
  rw [F.coneAt_region_eq_biUnion hyd c] at hβc'
  obtain ⟨T, ⟨hT, hyT⟩, hβT⟩ := mem_iUnion₂.mp hβc'
  refine ⟨T, ⟨hT.1, hyT, fun hpT => ?_, c, hcp, hT.2⟩, hβT⟩
  obtain ⟨z, hz⟩ := hT.1.nonempty
  exact Set.disjoint_left.mp (hmiss T hT hpT) hz (hT.1.subset_ball hF hyT hz)

/-! ## FS116-N2-STAR -/

/-- **FS116-N2-STAR**, the colours at a change point: `C(y) = A(p) ∪ T_y ∪ O_y` (the union is disjoint:
`tipColours_subset`, `outerTileColours_subset`, and in the non-Siamese class `disjoint_tipColours_outerTileColours`).
(Inhabitants: the module docstring.) -/
theorem star_coloursAt (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k} (hy : F.IsChangePoint p ψ X X') :
    F.coloursAt (ringPt p ψ) =
      (F.coloursAt p)ᶜ ∪ (F.tipColours p (ringPt p ψ) ∪ F.outerTileColours p (ringPt p ψ)) := by
  have hyd : ringPt p ψ ∈ F.dom := hp (mem_closedBall.mpr (dist_ringPt p ψ).le)
  have habs : (F.coloursAt p)ᶜ ⊆ F.coloursAt (ringPt p ψ) := by
    rw [(germS_absent hF hp h4 hk hy).2]
    rintro c (rfl | rfl)
    · exact hy.2.2.1.ringPt_mem_closure
    · exact hy.2.2.2.ringPt_mem_closure
  rw [← coloursAt_inter_eq p hyd]
  ext c
  constructor
  · intro hc
    by_cases hcp : c ∈ F.coloursAt p
    · exact Or.inr ⟨hcp, hc⟩
    · exact Or.inl hcp
  · rintro (hc | hc)
    · exact habs hc
    · exact hc.2

/-- **FS116-N2-STAR**, the colours absent at a change point: `A(y) = P ∖ (T_y ∪ O_y)`. -/
theorem star_absent (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k} (hy : F.IsChangePoint p ψ X X') :
    (F.coloursAt (ringPt p ψ))ᶜ =
      F.coloursAt p \ (F.tipColours p (ringPt p ψ) ∪ F.outerTileColours p (ringPt p ψ)) := by
  rw [star_coloursAt hF hp h4 hk hy, compl_union, compl_compl]
  rfl

/-- **FS116-N2-STAR**, the outer colours' tiles: in a valid non-Siamese map, the tile of `p` of the colour of an outer tile
at `y = r(ψ)` has its cone at `p` in `[ψ + 90°, ψ + 270°]` (it is far from the outer tile, so it misses `B(y, 1)`). Any
point `p` and any `ψ`. -/
theorem star_outer_cone (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} {ψ : ℝ} {c : Fin k}
    (hc : c ∈ F.outerTileColours p (ringPt p ψ)) {T : Set ℂ} (hT : F.TileOf c T) (hpT : p ∈ closure T) :
    coneAt T p ⊆ angleIcc (ψ + π / 2) (ψ + 3 * π / 2) := by
  obtain ⟨-, T', hT', hyT', hpT'⟩ := hc
  refine coneAt_subset_of_disjoint_ball (Set.disjoint_left.mpr fun z hzT hzb => ?_)
  rcases unitNear_or_unitFar hF hT hT' with h | h
  · exact hpT' (hN.eq_of_unitNear hT hT' h ▸ hpT)
  · exact absurd (UnitFar.one_le_dist_of_mem_closure h (subset_closure hzT) hyT') (not_le.mpr (mem_ball.mp hzb))

/-- **FS116-N2-STAR**, the flank clause at the class it reads (any valid map, any point `p`, any `ψ`; Siamese pairs
allowed): a tile of colour `c` approaching `p` along a direction within `90°` of `ψ` and along a direction more than `90°`
from `ψ` has a point at distance exactly `1` from `r(ψ)`, so `c` is absent at `r(ψ)`. -/
theorem star_flank (hF : F.Valid) {p : ℂ} {ψ : ℝ} {c : Fin k} {T : Set ℂ} (hT : F.TileOf c T) {β₁ β₂ : ℝ}
    (h₁ : β₁ ∈ coneAt T p) (h₂ : β₂ ∈ coneAt T p) (hc₁ : 0 < Real.cos (β₁ - ψ)) (hc₂ : Real.cos (β₂ - ψ) < 0) :
    c ∉ F.coloursAt (ringPt p ψ) := by
  intro hcy
  obtain ⟨z₁, hz₁T, hz₁⟩ := inter_ball_nonempty_of_coneAt h₁ hc₁
  obtain ⟨z₂, hz₂T, hz₂⟩ := exists_not_mem_closedBall_of_coneAt h₂ hc₂
  have hcont : ContinuousOn (fun z : ℂ => dist z (ringPt p ψ)) T := (continuous_id.dist continuous_const).continuousOn
  have h1 : (1 : ℝ) ∈ (fun z : ℂ => dist z (ringPt p ψ)) '' T :=
    hT.1.isPreconnected.intermediate_value hz₁T hz₂T hcont
      ⟨(mem_ball.mp hz₁).le, (not_le.mp (fun h => hz₂ (mem_closedBall.mpr h))).le⟩
  obtain ⟨z, hzT, hz⟩ := h1
  exact ne1_region hF hcy (hT.subset_region hzT) hz

/-- **FS116-N2-STAR**, the flank clause as filed: a tile whose cone at `p` holds `ψ + 90°` or `ψ − 90°` in its interior has
its colour absent at `y = r(ψ)`. -/
theorem star_flank_interior (hF : F.Valid) {p : ℂ} {ψ : ℝ} {c : Fin k} {T : Set ℂ} (hT : F.TileOf c T)
    (h : ψ + π / 2 ∈ interior (coneAt T p) ∨ ψ - π / 2 ∈ interior (coneAt T p)) :
    c ∉ F.coloursAt (ringPt p ψ) := by
  have key : ∀ γ : ℝ, (γ = π / 2 ∨ γ = -(π / 2)) → ψ + γ ∈ interior (coneAt T p) →
      c ∉ F.coloursAt (ringPt p ψ) := by
    intro γ hγ hint
    obtain ⟨ε, hε, hball⟩ := Metric.mem_nhds_iff.mp (mem_interior_iff_mem_nhds.mp hint)
    set η := min (ε / 2) (π / 4) with hη
    have hη0 : 0 < η := lt_min (by linarith) (by linarith [Real.pi_pos])
    have hηε : η < ε := lt_of_le_of_lt (min_le_left _ _) (by linarith)
    have hηπ : η < π := lt_of_le_of_lt (min_le_right _ _) (by linarith [Real.pi_pos])
    have hs : 0 < Real.sin η := Real.sin_pos_of_pos_of_lt_pi hη0 hηπ
    have hm : ψ + γ - η ∈ coneAt T p := hball (by
      rw [mem_ball, Real.dist_eq, show ψ + γ - η - (ψ + γ) = -η by ring, abs_neg, abs_of_pos hη0]; exact hηε)
    have hpl : ψ + γ + η ∈ coneAt T p := hball (by
      rw [mem_ball, Real.dist_eq, show ψ + γ + η - (ψ + γ) = η by ring, abs_of_pos hη0]; exact hηε)
    rcases hγ with rfl | rfl
    · refine star_flank hF hT hm hpl ?_ ?_
      · rw [show ψ + π / 2 - η - ψ = π / 2 - η by ring, Real.cos_pi_div_two_sub]; exact hs
      · rw [show ψ + π / 2 + η - ψ = η + π / 2 by ring, Real.cos_add_pi_div_two]; linarith
    · refine star_flank hF hT hpl hm ?_ ?_
      · rw [show ψ + -(π / 2) + η - ψ = η - π / 2 by ring, Real.cos_sub_pi_div_two]; exact hs
      · rw [show ψ + -(π / 2) - η - ψ = -(η + π / 2) by ring, Real.cos_neg, Real.cos_add_pi_div_two]; linarith
  rcases h with h | h
  · exact key (π / 2) (Or.inl rfl) h
  · exact key (-(π / 2)) (Or.inr rfl) (by rwa [← sub_eq_add_neg])

/-- **FS116-N2-STAR**, the tips exist: when the tip pair lies on no (Q) arc, `T_y` is non-empty. -/
theorem star_tip_nonempty (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k}
    (hy : F.IsChangePoint p ψ X X') (ht : F.TipPairFree p ψ) : (F.tipColours p (ringPt p ψ)).Nonempty := by
  obtain ⟨T, hT, -⟩ := ringGerm_inward hF hN hp h4 hk hy ht (ψ + π)
    ⟨by linarith [Real.pi_pos], by linarith [Real.pi_pos]⟩
  obtain ⟨z, hz⟩ := hT.1.nonempty
  exact ⟨F.col z, T, hT.1.tileOf hz, hT⟩

/-- **FS116-N2-STAR**, the outer tiles exist: when the outer pair lies on no (Q) arc, `O_y` is non-empty. -/
theorem star_outer_nonempty (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k} (hy : F.IsChangePoint p ψ X X')
    (ho : F.OuterPairFree p ψ) : (F.outerTileColours p (ringPt p ψ)).Nonempty := by
  obtain ⟨T, ⟨hT, hyT, hpT, c, hcp, hTc⟩, -⟩ := ringGerm_outward hF hp h4 hk hy ho ψ
    ⟨by linarith [Real.pi_pos], by linarith [Real.pi_pos]⟩
  exact ⟨c, hcp, T, ⟨hT, hTc⟩, hyT, hpT⟩

/-! ## FS116-N2-RECIP -/

/-- On `ω(y)`, `y = r(ψ)`, the point at angle `ψ + 180°` is `p`. -/
theorem ringPt_ringPt_add_pi (p : ℂ) (ψ : ℝ) : ringPt (ringPt p ψ) (ψ + π) = p := by
  simp only [ringPt, e_add_pi]; ring

/-- **A germ in a colour class lies in one tile of that colour**, which has the ring point in its closure (a germ is
connected and misses `Γ`). -/
theorem exists_tileOf_of_germIn {p : ℂ} {θ : ℝ} {s : Side} {c : Fin k} (h : GermIn p θ s (F.region c)) :
    ∃ T, F.TileOf c T ∧ ringPt p θ ∈ closure T ∧ GermIn p θ s T := by
  obtain ⟨δ, hδ, hsub⟩ := h
  have hg : ringPt p (θ + s.sign * (δ / 2)) ∈ germ p θ s δ := ⟨δ / 2, ⟨by linarith, by linarith⟩, rfl⟩
  have hgI : ringPt p (θ + s.sign * (δ / 2)) ∈ F.interiorPts := (hsub hg).1
  have hT : F.IsTile (connectedComponentIn F.interiorPts (ringPt p (θ + s.sign * (δ / 2)))) := ⟨_, hgI, rfl⟩
  have hgT := mem_connectedComponentIn hgI
  have hsubT : germ p θ s δ ⊆ connectedComponentIn F.interiorPts (ringPt p (θ + s.sign * (δ / 2))) :=
    hT.subset_of_preconnected (isPreconnected_germ p θ s δ) (hsub.trans (F.region_subset_interiorPts c)) hg hgT
  refine ⟨_, ?_, closure_mono hsubT (ringPt_mem_closure_germ p θ s hδ), δ, hδ, hsubT⟩
  have := hT.tileOf hgT
  rwa [show F.col (ringPt p (θ + s.sign * (δ / 2))) = c from (hsub hg).2] at this

/-- **FS116-N2-RECIP** (at the class its argument reads: `y` a change point, the non-Siamese hypothesis idle): in a valid
six-coloured fragment on a closed disc of radius above 2 about a vertex `p` of four colours, let `y = r(ψ)` be a change
point of the ring of `p` with four colours and no more. If `p` lies on no arc of `Γ` on `ω(y)` and the four germs of `ω(y)`
at its points `60°` on either side of `p` (the points `r(ψ ± 60°)` of `p`'s ring) lie on no (Q) arc of `y`'s ring, then `p`
is a change point of `y`'s ring, its two sides lying in tiles of `p` whose colours are the two colours absent at `y`.

The hypotheses' satisfiability is open at six colours (no held fragment has a change point of four colours meeting them:
`plans/FS116-N2-proof.md` § 2.4, the hub question of FS-124); the strip's `P₀` at its change point `P₂` meets the local
hypotheses but `hq` (its germs there lie on (Q) arcs). -/
theorem star_recip {F : ArcMap 6} (hF : F.Valid) {p : ℂ} (hp : F.Covers p 2) (h4 : (F.coloursAt p).ncard = 4) {ψ : ℝ}
    {X X' : Fin 6} (hy : F.IsChangePoint p ψ X X') (hy4 : (F.coloursAt (ringPt p ψ)).ncard = 4)
    (hna : ¬ F.OnRingArc (ringPt p ψ) p)
    (hq : ∀ s, ¬ F.GermOnQ (ringPt p ψ) (ψ + π + π / 3) s ∧ ¬ F.GermOnQ (ringPt p ψ) (ψ + π - π / 3) s) :
    ∃ Y Y', F.IsChangePoint (ringPt p ψ) (ψ + π) Y Y' ∧ (F.coloursAt (ringPt p ψ))ᶜ = {Y, Y'} ∧
      (∃ T, F.TileOf Y T ∧ p ∈ closure T ∧ GermIn (ringPt p ψ) (ψ + π) .ccw T) ∧
      ∃ T, F.TileOf Y' T ∧ p ∈ closure T ∧ GermIn (ringPt p ψ) (ψ + π) .cw T := by
  have hp1 : F.Covers p 1 := (closedBall_subset_closedBall one_le_two).trans hp
  have hcy : F.Covers (ringPt p ψ) 1 := fun z hz => hp (mem_closedBall.mpr (by
    have := dist_triangle z (ringPt p ψ) p
    rw [dist_ringPt] at this
    linarith [mem_closedBall.mp hz]))
  have hpy : ringPt (ringPt p ψ) (ψ + π) = p := ringPt_ringPt_add_pi p ψ
  -- the colours absent at `y` are colours of `p`
  have habs : (F.coloursAt (ringPt p ψ))ᶜ ⊆ F.coloursAt p := by
    rw [star_absent hF hp1 h4.ge (by omega) hy]
    exact sdiff_subset
  -- `p` is a change point of the ring of `y`: otherwise FS129-SR2-TOUCHW at `y` makes an absent colour of `y` absent at `p`
  have hch : ∃ Y Y', F.IsChangePoint (ringPt p ψ) (ψ + π) Y Y' := by
    by_contra hnc
    push Not at hnc
    obtain ⟨Z, Z', -, hcZ, -, -, -, hZ'⟩ := touchW hF hcy hy4.ge (by omega) hnc (by rwa [hpy]) hq
    rw [hpy] at hZ'
    exact hZ' (habs (by rw [hcZ]; exact mem_insert_of_mem _ rfl))
  obtain ⟨Y, Y', hYY'⟩ := hch
  refine ⟨Y, Y', hYY', (germS_absent hF hcy hy4.ge (by omega) hYY').2, ?_, ?_⟩
  · obtain ⟨T, hT, hcl, hg⟩ := exists_tileOf_of_germIn hYY'.2.2.1
    exact ⟨T, hT, hpy ▸ hcl, hg⟩
  · obtain ⟨T, hT, hcl, hg⟩ := exists_tileOf_of_germIn hYY'.2.2.2
    exact ⟨T, hT, hpy ▸ hcl, hg⟩

/-! ## FS116-N2-ANTI -/

/-- The cone is periodic under every whole turn. -/
theorem mem_coneAt_add_int_mul_two_pi {S : Set ℂ} {y : ℂ} {β : ℝ} (m : ℤ) :
    β + 2 * π * m ∈ coneAt S y ↔ β ∈ coneAt S y := by
  simp only [coneAt, mem_setOf_eq, e_add_int_mul]

/-- **FS116-N2-ANTI, the interval step**: an interval of directions `[b₁, b₂]` (at most a whole turn) holding `ψ + 90°`
and `ψ − 90°` cannot leave room, off its open part, both for a direction strictly inside the half-circle about `ψ` and
for one strictly inside the opposite half-circle. -/
theorem false_of_antipodal_gaps {ψ b₁ b₂ g h : ℝ} (hpl : ψ + π / 2 ∈ angleIcc b₁ b₂)
    (hmi : ψ - π / 2 ∈ angleIcc b₁ b₂) (hg : g ∈ Ioo (ψ - π / 2) (ψ - π / 2 + π)) (hg' : g ∉ angleIoo b₁ b₂)
    (hh : h ∈ Ioo (ψ + π / 2) (ψ + π / 2 + π)) (hh' : h ∉ angleIoo b₁ b₂) : False := by
  have hπ := Real.pi_pos
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp hpl
  obtain ⟨j, hj1, hj2⟩ := mem_iUnion.mp hmi
  have hh2 : b₂ + 2 * π * m ≤ h := by
    by_contra hc
    push Not at hc
    exact hh' (mem_iUnion.mpr ⟨m, by linarith [hh.1], hc⟩)
  have hg2 : g ≤ b₁ + 2 * π * m := by
    by_contra hc
    push Not at hc
    exact hg' (mem_iUnion.mpr ⟨m, hc, by linarith [hg.2]⟩)
  have hjm : (j : ℝ) < m := by
    by_contra hc
    push Not at hc
    have := mul_le_mul_of_nonneg_left hc hπ.le
    linarith [hg.1]
  have hjm' : (j : ℝ) + 1 ≤ m := by exact_mod_cast Int.add_one_le_iff.mpr (by exact_mod_cast hjm)
  have := mul_le_mul_of_nonneg_left hjm' hπ.le
  linarith [hh.2]

/-- **FS116-N2-ANTI, `t⁺ ≠ t⁻`**: at a hub `y = r(ψ)` of a vertex `p` simple for the map, no single tile `t` of `p` whose
colour is absent at `y` approaches `p` along both `ψ + 90°` and `ψ − 90°` when no other tile of `p` approaches along
either: a tip of `y` and the tile of `p` of an outer colour of `y` are other tiles of `p`, with directions strictly
inside the two half-circles, off the open part of the cone of `t`. -/
theorem star_anti_ne (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1) (hS : F.SimpleOn {p})
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} (hy : F.IsHub p ψ) {t : Set ℂ}
    {c : Fin k} (ht : F.TileOf c t) (hpt : p ∈ closure t) (hc : c ∉ F.coloursAt (ringPt p ψ))
    (hpl : ψ + π / 2 ∈ coneAt t p) (hmi : ψ - π / 2 ∈ coneAt t p)
    (hp'' : ∀ T, F.TileAt p T → T ≠ t → ψ + π / 2 ∉ coneAt T p)
    (hm'' : ∀ T, F.TileAt p T → T ≠ t → ψ - π / 2 ∉ coneAt T p) : False := by
  have hπ := Real.pi_pos
  have hpd : p ∈ F.dom := hp (mem_closedBall_self zero_le_one)
  obtain ⟨⟨X, X', hch⟩, htf, hof⟩ := isHub_iff.mp hy
  obtain ⟨b₁, b₂, -, -, hcone, hsep⟩ := hS.coneAt_eq_angleIcc_sep ht.1 hpd rfl hpt
  rw [hcone] at hpl hmi
  have key : ∀ T, F.TileAt p T → T ≠ t → ∀ lo, coneAt T p ⊆ angleIcc lo (lo + π) → lo ∉ coneAt T p →
      lo + π ∉ coneAt T p → ∃ g ∈ Ioo lo (lo + π), g ∉ angleIoo b₁ b₂ := by
    intro T hT hTt lo hsub hlo hhi
    obtain ⟨β₁, β₂, hβ, -, hTc⟩ := hS.coneAt_eq_angleIcc hT.1 rfl hT.2
    have hβ₁ : β₁ ∈ coneAt T p := by
      rw [hTc]; exact Icc_subset_angleIcc _ _ ⟨le_rfl, hβ⟩
    obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp (hsub hβ₁)
    have hg : β₁ - 2 * π * m ∈ coneAt T p := by
      have := (mem_coneAt_add_int_mul_two_pi (S := T) (y := p) (β := β₁) (-m)).mpr hβ₁
      rwa [show β₁ + 2 * π * ((-m : ℤ) : ℝ) = β₁ - 2 * π * m by push_cast; ring] at this
    refine ⟨β₁ - 2 * π * m, ⟨lt_of_le_of_ne (by linarith) fun h => hlo (by rw [h]; exact hg),
      lt_of_le_of_ne (by linarith) fun h => hhi (by rw [← h]; exact hg)⟩, fun hmem => ?_⟩
    exact Set.disjoint_left.mp (hsep T hT.1 hTt hT.2) hg hmem
  have hcol : ∀ {c' : Fin k} {T : Set ℂ}, F.TileOf c' T → c' ∈ F.coloursAt (ringPt p ψ) → T ≠ t := by
    rintro c' T hT hc' rfl
    obtain ⟨z, hz⟩ := hT.1.nonempty
    have h1 : F.col z = c' := hT.2 hz
    have h2 : F.col z = c := ht.2 hz
    exact hc (by rw [← h2, h1]; exact hc')
  -- a tip of `y`
  obtain ⟨a, Sa, hSa, hSt⟩ := star_tip_nonempty hF hN hp h4 hk hch htf
  have hSne : Sa ≠ t := hcol hSa (tipColours_subset p _ ⟨Sa, hSa, hSt⟩).2
  obtain ⟨g, hg, hg'⟩ := key Sa hSt.tileAt.1 hSne (ψ - π / 2)
    (by rw [show ψ - π / 2 + π = ψ + π / 2 by ring]; exact hSt.coneAt_subset hF)
    (hm'' Sa hSt.tileAt.1 hSne) (by rw [show ψ - π / 2 + π = ψ + π / 2 by ring]; exact hp'' Sa hSt.tileAt.1 hSne)
  -- the tile of `p` of an outer colour of `y`
  obtain ⟨c', hc'⟩ := star_outer_nonempty hF hp h4 hk hch hof
  obtain ⟨Q, hQ, hpQ⟩ := (F.mem_coloursAt_iff_exists_tileOf hpd).mp hc'.1
  have hQne : Q ≠ t := hcol hQ (outerTileColours_subset p _ hc').2
  obtain ⟨h, hh, hh'⟩ := key Q ⟨hQ.1, hpQ⟩ hQne (ψ + π / 2)
    (by rw [show ψ + π / 2 + π = ψ + 3 * π / 2 by ring]; exact star_outer_cone hF hN hc' hQ hpQ)
    (hp'' Q ⟨hQ.1, hpQ⟩ hQne) (by
      rw [show ψ + π / 2 + π = ψ - π / 2 + 2 * π by ring, mem_coneAt_add_two_pi]
      exact hm'' Q ⟨hQ.1, hpQ⟩ hQne)
  exact false_of_antipodal_gaps hpl hmi hg hg' hh hh'

/-- **FS116-N2-ANTI, the count at one hub**: at a hub `y = r(ψ)` of a vertex `p` of four colours in a valid non-Siamese
six-coloured map, if two distinct colours of `p` are absent at `y`, they are the colours absent at `y`, `y` carries four
colours, and `T_y`, `O_y` are single colours — the other two colours of `p`. -/
theorem star_anti_count {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : (F.coloursAt p).ncard = 4) {ψ : ℝ} (hy : F.IsHub p ψ) {cp cm : Fin 6} (hne : cp ≠ cm)
    (hcp : cp ∉ F.coloursAt (ringPt p ψ)) (hcm : cm ∉ F.coloursAt (ringPt p ψ)) :
    (F.coloursAt (ringPt p ψ))ᶜ = {cp, cm} ∧ (F.coloursAt (ringPt p ψ)).ncard = 4 ∧
      ∃ a b, a ≠ b ∧ F.tipColours p (ringPt p ψ) = {a} ∧ F.outerTileColours p (ringPt p ψ) = {b} ∧
        F.coloursAt p \ {cp, cm} = {a, b} := by
  obtain ⟨⟨X, X', hch⟩, htf, hof⟩ := isHub_iff.mp hy
  have h4' : 4 ≤ (F.coloursAt p).ncard := h4.ge
  have hk : 6 ≤ (F.coloursAt p).ncard + 2 := by omega
  have hT := star_tip_nonempty hF hN hp h4' hk hch htf
  have hO := star_outer_nonempty hF hp h4' hk hch hof
  have habs := star_absent hF hp h4' hk hch
  have hdisj := disjoint_tipColours_outerTileColours hN hF p (ringPt p ψ)
  have hsub : F.tipColours p (ringPt p ψ) ∪ F.outerTileColours p (ringPt p ψ) ⊆ F.coloursAt p :=
    union_subset (fun c hc => (tipColours_subset p _ hc).1) fun c hc => (outerTileColours_subset p _ hc).1
  have hA2 : ({cp, cm} : Set (Fin 6)) ⊆ (F.coloursAt (ringPt p ψ))ᶜ := by
    rintro c (rfl | rfl)
    · exact hcp
    · exact hcm
  have hsum := Set.ncard_sdiff_add_ncard_of_subset hsub (Set.toFinite _)
  rw [← habs, h4, Set.ncard_union_eq hdisj] at hsum
  have hT1 := (Set.ncard_pos (Set.toFinite _)).mpr hT
  have hO1 := (Set.ncard_pos (Set.toFinite _)).mpr hO
  have hA := Set.ncard_le_ncard hA2 (Set.toFinite _)
  rw [Set.ncard_pair hne] at hA
  have hAeq : (F.coloursAt (ringPt p ψ))ᶜ = {cp, cm} :=
    (Set.eq_of_subset_of_ncard_le hA2 (by rw [Set.ncard_pair hne]; omega) (Set.toFinite _)).symm
  obtain ⟨a, ha⟩ := Set.ncard_eq_one.mp (show (F.tipColours p (ringPt p ψ)).ncard = 1 by omega)
  obtain ⟨b, hb⟩ := Set.ncard_eq_one.mp (show (F.outerTileColours p (ringPt p ψ)).ncard = 1 by omega)
  have hcard := Set.ncard_add_ncard_compl (F.coloursAt (ringPt p ψ))
  rw [Nat.card_eq_fintype_card, Fintype.card_fin] at hcard
  refine ⟨hAeq, by omega, a, b, fun hab => ?_, ha, hb, ?_⟩
  · exact Set.disjoint_left.mp hdisj (by rw [ha]; rfl) (by rw [hb, hab]; rfl)
  · rw [← hAeq, habs, Set.sdiff_sdiff_cancel_left hsub, ha, hb]; rfl

/-- **FS116-N2-ANTI** (simple read at the tiles of `p` only): in a valid non-Siamese six-coloured fragment on a closed
disc of radius above 1 about a vertex `p` of four colours whose tiles are Jordan domains, let `y = r(ψ)` and
`y* = r(ψ + 180°)` be hubs of `p`, and let `ψ + 90°` and `ψ − 90°` lie in the interiors of the cones at `p` of tiles `t⁺`
(of colour `c⁺`) and `t⁻` (of colour `c⁻`), no other tile of `p` approaching `p` along `ψ + 90°` or along `ψ − 90°`.
Then `t⁺ ≠ t⁻`, `A(y) = A(y*) = {c⁺, c⁻}`, `T_y = O_(y*)` and `O_y = T_(y*)`, each a single colour, and `y` and `y*` have
four colours and no more.

**The excluded case** (`hp''`, `hm''`; inventory item 568): the row's *not claimed* line is "anything when an edge of p
leaves at ψ + 90° or ψ − 90°" (`plans/FS116-derivation.md` l. 719), and "in the interior of the cone", read as the
interior of a set of directions, admits such an edge when one tile's cone is every direction: then `t⁺ = t⁻` with the
other three tiles of `p` cusps along `ψ + 90°` or `ψ − 90°`, a configuration neither excluded nor constructed (open:
"can a tile of a four-colour vertex have every direction in its cone, with two antipodal hubs?"). The two hypotheses say
that no edge of `p` leaves along either direction (no `IsEdgeDir p t⁺ T (ψ + 90°)`, in `…/SemiHub`'s word); where the cone
of `t⁺` is a proper interval they follow from `hp'` (`SimpleOn.coneAt_eq_angleIcc_sep`). The proof reads `hp'`, `hm` as
interiors only for the two colours' absence at `y` and `y*` (`star_flank_interior`); `t⁺ ≠ t⁻` reads membership and the
two new hypotheses (`star_anti_ne`).

VACUITY: the hypotheses' satisfiability is open (two antipodal hubs: no held fragment has a hub, and on a Γ-free ring
FS129-SR3-EMPTY-NS shows there is none); the strip's `P₀` meets every hypothesis but the interiority of the flank
directions and (Q)-freeness of the germs, and fails the conclusion (`plans/FS116-N2-proof.md` § 2.4). -/
theorem star_anti {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (hS : F.SimpleOn {p}) (h4 : (F.coloursAt p).ncard = 4) {ψ : ℝ} (hy : F.IsHub p ψ) (hy' : F.IsHub p (ψ + π))
    {tp tm : Set ℂ} {cp cm : Fin 6} (htp : F.TileOf cp tp) (htm : F.TileOf cm tm) (hptp : p ∈ closure tp)
    (hptm : p ∈ closure tm) (hp' : ψ + π / 2 ∈ interior (coneAt tp p)) (hm : ψ - π / 2 ∈ interior (coneAt tm p))
    (hp'' : ∀ T, F.TileAt p T → T ≠ tp → ψ + π / 2 ∉ coneAt T p)
    (hm'' : ∀ T, F.TileAt p T → T ≠ tm → ψ - π / 2 ∉ coneAt T p) :
    tp ≠ tm ∧ (F.coloursAt (ringPt p ψ))ᶜ = {cp, cm} ∧ (F.coloursAt (ringPt p (ψ + π)))ᶜ = {cp, cm} ∧
      (∃ c, F.tipColours p (ringPt p ψ) = {c} ∧ F.outerTileColours p (ringPt p (ψ + π)) = {c}) ∧
      (∃ c, F.outerTileColours p (ringPt p ψ) = {c} ∧ F.tipColours p (ringPt p (ψ + π)) = {c}) ∧
      (F.coloursAt (ringPt p ψ)).ncard = 4 ∧ (F.coloursAt (ringPt p (ψ + π))).ncard = 4 := by
  have h4' : 4 ≤ (F.coloursAt p).ncard := h4.ge
  have hk : 6 ≤ (F.coloursAt p).ncard + 2 := by omega
  have hcpy : cp ∉ F.coloursAt (ringPt p ψ) := star_flank_interior hF htp (Or.inl hp')
  have hcmy : cm ∉ F.coloursAt (ringPt p ψ) := star_flank_interior hF htm (Or.inr hm)
  have hring : ringPt p (ψ - π) = ringPt p (ψ + π) := by
    simp only [ringPt]; rw [show ψ + π = ψ - π + 2 * π by ring, e_add_two_pi]
  have hcpy' : cp ∉ F.coloursAt (ringPt p (ψ + π)) :=
    star_flank_interior hF htp (Or.inr (by rwa [show ψ + π - π / 2 = ψ + π / 2 by ring]))
  have hcmy' : cm ∉ F.coloursAt (ringPt p (ψ + π)) := by
    rw [← hring]
    exact star_flank_interior hF htm (Or.inl (by rwa [show ψ - π + π / 2 = ψ - π / 2 by ring]))
  have hne : tp ≠ tm := by
    rintro rfl
    exact star_anti_ne hF hN hp hS h4' hk hy htp hptp hcpy (interior_subset hp') (interior_subset hm) hp'' hm''
  have hcne : cp ≠ cm := by
    rintro rfl
    exact hne (hN.tile_eq_of_mem_closure hF htp htm hptp hptm)
  obtain ⟨hA, hn4, a, b, -, hT, hO, hrest⟩ := star_anti_count hF hN hp h4 hy hcne hcpy hcmy
  obtain ⟨hA', hn4', a', b', hab', hT', hO', hrest'⟩ := star_anti_count hF hN hp h4 hy' hcne hcpy' hcmy'
  -- the tips of `y` and of `y*` have different colours: one tile of `p` would hold both, `2` apart
  have haa : a ≠ a' := by
    rintro rfl
    obtain ⟨Sa, hSa, hSt⟩ : a ∈ F.tipColours p (ringPt p ψ) := by rw [hT]; rfl
    obtain ⟨Sa', hSa', hSt'⟩ : a ∈ F.tipColours p (ringPt p (ψ + π)) := by rw [hT']; rfl
    have hSS : Sa = Sa' := hN.tile_eq_of_mem_closure hF hSa hSa' hSt.2.1 hSt'.2.1
    subst hSS
    have hd := hSt.1.dist_le_one_of_mem_closure hF _ hSt.2.2 _ hSt'.2.2
    have h2 : dist (ringPt p ψ) (ringPt p (ψ + π)) = 2 := by
      simp only [ringPt, e_add_pi, dist_eq_norm]
      rw [show p + e ψ - (p + -e ψ) = 2 * e ψ by ring, norm_mul, norm_e]; norm_num
    linarith
  have ha'b : a' = b := by
    have h : a' ∈ ({a, b} : Set (Fin 6)) := by rw [← hrest, hrest']; exact Set.mem_insert _ _
    rcases h with h | h
    · exact absurd h.symm haa
    · exact h
  have hb'a : b' = a := by
    have h : b' ∈ ({a, b} : Set (Fin 6)) := by rw [← hrest, hrest']; exact Set.mem_insert_of_mem _ rfl
    rcases h with h | h
    · exact h
    · exact absurd (ha'b.trans h.symm) hab'
  exact ⟨hne, hA, hA', ⟨a, hT, by rw [hO', hb'a]⟩, ⟨b, hO, by rw [hT', ha'b]⟩, hn4, hn4'⟩

end ArcMap

end HadwigerNelson.Plane
