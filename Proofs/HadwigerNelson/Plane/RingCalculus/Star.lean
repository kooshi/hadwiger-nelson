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
| FS116-N2-RECIP | `ringPt_ringPt_add_pi`, `star_recip` | stated; `star_recip` open |
| FS116-N2-ANTI | `star_anti` | stated, open |

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
  sorry

/-! ## FS116-N2-ANTI -/

/-- **FS116-N2-ANTI** (simple read at the tiles of `p` only): in a valid non-Siamese six-coloured fragment on a closed
disc of radius above 1 about a vertex `p` of four colours whose tiles are Jordan domains, let `y = r(ψ)` and
`y* = r(ψ + 180°)` be hubs of `p`, and let `ψ + 90°` and `ψ − 90°` lie in the interiors of the cones at `p` of tiles `t⁺`
(of colour `c⁺`) and `t⁻` (of colour `c⁻`). Then `t⁺ ≠ t⁻`, `A(y) = A(y*) = {c⁺, c⁻}`, `T_y = O_(y*)` and `O_y = T_(y*)`,
each a single colour, and `y` and `y*` have four colours and no more.

VACUITY: the hypotheses' satisfiability is open (two antipodal hubs: no held fragment has a hub, and on a Γ-free ring
FS129-SR3-EMPTY-NS shows there is none); the strip's `P₀` meets every hypothesis but the interiority of the flank
directions and (Q)-freeness of the germs, and fails the conclusion (`plans/FS116-N2-proof.md` § 2.4). -/
theorem star_anti {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (hS : F.SimpleOn {p}) (h4 : (F.coloursAt p).ncard = 4) {ψ : ℝ} (hy : F.IsHub p ψ) (hy' : F.IsHub p (ψ + π))
    {tp tm : Set ℂ} {cp cm : Fin 6} (htp : F.TileOf cp tp) (htm : F.TileOf cm tm) (hptp : p ∈ closure tp)
    (hptm : p ∈ closure tm) (hp' : ψ + π / 2 ∈ interior (coneAt tp p)) (hm : ψ - π / 2 ∈ interior (coneAt tm p)) :
    tp ≠ tm ∧ (F.coloursAt (ringPt p ψ))ᶜ = {cp, cm} ∧ (F.coloursAt (ringPt p (ψ + π)))ᶜ = {cp, cm} ∧
      (∃ c, F.tipColours p (ringPt p ψ) = {c} ∧ F.outerTileColours p (ringPt p (ψ + π)) = {c}) ∧
      (∃ c, F.outerTileColours p (ringPt p ψ) = {c} ∧ F.tipColours p (ringPt p (ψ + π)) = {c}) ∧
      (F.coloursAt (ringPt p ψ)).ncard = 4 ∧ (F.coloursAt (ringPt p (ψ + π))).ncard = 4 := by
  sorry

end ArcMap

end HadwigerNelson.Plane
