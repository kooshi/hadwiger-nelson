import Proofs.HadwigerNelson.Plane.RingCalculus.SemiHub
import Proofs.HadwigerNelson.Plane.RingCalculus.StarChart

/-!
# The ring calculus: what a semi-hub places (FS116-N3-SEMI, FS116-N3-CROSS, FS116-RING-TRANSFER-QC)

Wave 8's second planning pass (`plans/FS131-w8-kernel-plan.md`, Stages 6–10; job FS131-K8b), over the words and lemmas of
`Plane/RingCalculus/SemiHub` (whose header has the table of the nine rows, what is wider than they are, and the
inhabitants). Arguments: `plans/FS116-N3-proof.md` §§ 2.4, 3.1, 3.3; `plans/FS116-V5-verification.md` §§ 3.2, 3.4.

| row | declarations | state |
|---|---|---|
| FS116-N3-SEMI | `semiHub_places` | stated |
| FS116-N3-CROSS | `crossed_no_tip`, `crossed_tip_zeroAngle`, `crossed_outer`, `crossed_four`, `crossed_changePoint`, `crossed_semiHub` | `crossed_tip_zeroAngle` proved from `crossed_no_tip`; the rest stated |
| FS116-RING-TRANSFER-QC | `transferQC` | proved from `semiHub_places` |

**Inhabitants** (no Lean term; `data/fs116/n3/semi.out`): the strip's `P₀` at `P₂` — a crossed full semi-hub of kind O with
four colours — meets the hypotheses of every `crossed_*` leaf and of `semiHub_places`, and lands in its first alternative;
the bowtie's centre at `top` (parallel, four colours) meets `semiHub_places`' hypotheses likewise. No held fragment has a
three-colour semi-hub: `semiHub_places`' second alternative has no held model, and whether the third occurs is open
(SEMI-PAR3, FS-124).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS116-N3-SEMI -/

/-- **FS116-N3-SEMI**: in a valid non-Siamese map on a closed disc of radius above 1 about a vertex `p` of at least four
colours with at most two absent, simple at `p`, `y = r(ψ)`, `u = r(ψ + 60°)` and `v = r(ψ − 60°)`, let `y` be a semi-hub of
the ring of `p`. Then
* `y` carries at least four colours; or
* `y` carries exactly three, and is the end of an arc of `Γ` on the unit circle about `w = u` or `w = v` both of whose side
  colours are carried at `w`, which then carries at least four colours; or
* `y` carries exactly three and is a full parallel semi-hub — the pair on side `kind.qSide` on (Q) arcs with swapped
  colours `a | a'` at `u` and `a' | a` at `v` — its colours being the two absent at `p` and the colour of a tile `T` of `p`
  whose cone at `p` contains `[ψ + 150°, ψ + 210°]` (kind `O`: the tile of `p` away from `y`) or `[ψ − 30°, ψ + 30°]`
  (kind `T`: the tile toward `y`). ("Holds `ψ + 180°`, resp. `ψ`, in its interior" is stated in this stronger form, which
  is what the argument gives and which no cusp can spoil.)

**The class** (`h4`; ruled on FS131-I8D's finding): `p` carries *exactly* four colours. At a change point two colours are
absent at `p` (`germS_absent`: `ncard + 2 = k`), so "at least four colours with at most two absent" is four colours only at
`k = 6`; the argument reads the four tiles of `p`, and at `k ≥ 7` a fifth tile is placed by none of its windows. With `hk`
the class is `k ≤ 6`: the row's six-coloured fragments.

Models: the strip's `P₀` at `P₂` and the bowtie's centre at `top` meet the hypotheses and the first alternative
(`data/fs116/n3/semi.out`; no Lean term). No held fragment has a three-colour semi-hub: the second alternative has no held
model, and whether the third occurs is open (SEMI-PAR3, FS-124). -/
theorem semiHub_places (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1) {ψ : ℝ}
    (hS : F.SimpleOn {p, ringPt p ψ, ringPt p (ψ + π / 3), ringPt p (ψ - π / 3)}) (h4 : (F.coloursAt p).ncard = 4)
    (hk : k ≤ (F.coloursAt p).ncard + 2) {kind : SemiKind} (hy : F.IsSemiHub p ψ kind) :
    4 ≤ (F.coloursAt (ringPt p ψ)).ncard ∨
      ((F.coloursAt (ringPt p ψ)).ncard = 3 ∧ ∃ w, (w = ringPt p (ψ + π / 3) ∨ w = ringPt p (ψ - π / 3)) ∧
        (∃ θ₁ θ₂, F.BothKind w θ₁ θ₂ ∧ ringPt p ψ ∈ ringArc w θ₁ θ₂) ∧ 4 ≤ (F.coloursAt w).ncard) ∨
      ((F.coloursAt (ringPt p ψ)).ncard = 3 ∧ F.IsFullSemiHub p ψ kind ∧
        ∃ a a', F.GermOnQWith p (ψ + π / 3) kind.qSide a a' ∧ F.GermOnQWith p (ψ - π / 3) kind.qSide.flip a' a ∧
          ∃ c T, F.TileOf c T ∧ p ∈ closure T ∧ F.coloursAt (ringPt p ψ) = (F.coloursAt p)ᶜ ∪ {c} ∧
            (kind = .O → angleIcc (ψ + 5 * π / 6) (ψ + 7 * π / 6) ⊆ coneAt T p) ∧
            (kind = .T → angleIcc (ψ - π / 6) (ψ + π / 6) ⊆ coneAt T p)) := by
  sorry

/-! ## FS116-N3-CROSS: a crossed full semi-hub of kind O -/

/-- **The crossed star, in the form the `crossed_*` leaves read** (`GermOnQWith.exists_isRingArc_ccw`, `…_cw` and
`fullSemiHub_star_crossed` composed): the two sub-arcs `A = r([ψ + 60°, ψ + 60° + ℓ])`, `B = r([ψ − 60° − m, ψ − 60°])`
and the star `t_a, t_b', t_a', t_b` with its four windows. -/
theorem crossed_star_data (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})
    (h4 : (F.coloursAt p).ncard = 4) {ψ : ℝ} {a a' b b' : Fin k} (hu : F.GermOnQWith p (ψ + π / 3) .ccw a a')
    (hv : F.GermOnQWith p (ψ - π / 3) .cw b b') (hab : Disjoint ({a, a'} : Set (Fin k)) {b, b'}) :
    ∃ ℓ m : ℝ, 0 < ℓ ∧ 0 < m ∧ ℓ + m ≤ π / 3 ∧ F.IsRingArc p (ψ + π / 3) (ψ + π / 3 + ℓ) a a' ∧
      F.IsRingArc p (ψ - π / 3 - m) (ψ - π / 3) b b' ∧
      ∃ ta tb' ta' tb e₁ e₂ e₃ e₄, F.TileOf a ta ∧ F.TileOf b' tb' ∧ F.TileOf a' ta' ∧ F.TileOf b tb ∧
        F.IsStar4 p ta tb' ta' tb e₁ e₂ e₃ e₄ ∧ e₁ ∈ Icc (ψ + ℓ - π / 6) (ψ + π / 6 - m) ∧
        e₂ ∈ Icc (ψ + π / 6) (ψ + 5 * π / 6) ∧ e₃ ∈ Icc (ψ + 5 * π / 6 + ℓ) (ψ + 7 * π / 6 - m) ∧
        e₄ ∈ Icc (ψ + 7 * π / 6) (ψ + 11 * π / 6) := by
  obtain ⟨ℓ, hℓ, hA⟩ := hu.exists_isRingArc_ccw
  obtain ⟨m, hm, hB⟩ := hv.exists_isRingArc_cw
  obtain ⟨-, -, -, ha, ha', -, -⟩ := hu
  obtain ⟨-, -, -, hb, hb', -, -⟩ := hv
  obtain ⟨hlm, rest⟩ := fullSemiHub_star_crossed hF hN hpd hS h4 hA hB ha ha' hb hb' hab
  exact ⟨ℓ, m, hℓ, hm, hlm, hA, hB, rest⟩

/-- **FS116-N3-CROSS**, the first clause at its truth (no change point is read): in a valid non-Siamese map simple at a
point `p` carrying exactly four colours, if the germ just counter-clockwise of `u = r(ψ + 60°)` lies on a (Q) arc of colours
`a | a'`, the germ just clockwise of `v = r(ψ − 60°)` on one of colours `b | b'`, and the two pairs are disjoint, then **no
tile of `p` has `y = r(ψ)` in its closure**: `t_a` and `t_b` hold points of their arcs beyond `u` and `v`, more than `1`
from `y`, and `t_a'`, `t_b'` approach `p` along directions more than `90°` from `ψ`
(`plans/FS116-V5-verification.md` § 3.4 step 2). Model: the strip's `P₀` at `P₂` (tips: none). -/
theorem crossed_no_tip (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})
    (h4 : (F.coloursAt p).ncard = 4) {ψ : ℝ} {a a' b b' : Fin k} (hu : F.GermOnQWith p (ψ + π / 3) .ccw a a')
    (hv : F.GermOnQWith p (ψ - π / 3) .cw b b') (hab : Disjoint ({a, a'} : Set (Fin k)) {b, b'}) (T : Set ℂ) :
    ¬ F.IsTip p (ringPt p ψ) T := by
  rintro ⟨hTt, hpT, hyT⟩
  have hπ := Real.pi_pos
  obtain ⟨ℓ, m, hℓ, hm, hlm, hA, hB, ta, tb', ta', tb, e₁, e₂, e₃, e₄, hta, htb', hta', htb, hst, -, -, he₃, -⟩ :=
    crossed_star_data hF hN hpd hS h4 hu hv hab
  -- a tip lies in `B̄(y, 1)`: it approaches `p` only along directions within `90°` of `ψ`, and `e₃` is not one
  have hcos : ∀ β ∈ coneAt T p, 0 ≤ Real.cos (β - ψ) := fun β hβ =>
    cos_nonneg_of_mem_coneAt (y := p) (γ := ψ) ((hTt.subset_ball hF hyT).trans ball_subset_closedBall) hβ
  have he₃neg : Real.cos (e₃ - ψ) < 0 :=
    Real.cos_neg_of_pi_div_two_lt_of_lt (by linarith [he₃.1]) (by linarith [he₃.2])
  rcases (hst.tileAt T).mp ⟨hTt, hpT⟩ with rfl | rfl | rfl | rfl
  · -- `t_a` holds points of its arc beyond `u`, more than `1` from `y`
    have hmem : ringPt p (ψ + π / 3 + min ℓ 1) ∈ closure T :=
      qcol_inner_tile hF hN hA hta hpT
        ⟨ψ + π / 3 + min ℓ 1, ⟨by linarith [lt_min hℓ one_pos], by linarith [min_le_left ℓ 1]⟩, rfl⟩
    have hd := hTt.dist_le_one_of_mem_closure hF _ hyT _ hmem
    have hgt := (dist_ringPt_shift_cmp p ψ (min ℓ 1)
      (by rw [abs_of_pos (lt_min hℓ one_pos)]; exact min_le_right _ _)).2 (lt_min hℓ one_pos)
    linarith
  · have h3 : e₃ ∈ coneAt T p := by rw [hst.cone₂]; exact Icc_subset_angleIcc _ _ ⟨hst.le₂₃, le_rfl⟩
    linarith [hcos e₃ h3]
  · have h3 : e₃ ∈ coneAt T p := by rw [hst.cone₃]; exact Icc_subset_angleIcc _ _ ⟨le_rfl, hst.le₃₄⟩
    linarith [hcos e₃ h3]
  · -- `t_b` holds points of its arc beyond `v`, more than `1` from `y`
    have hmem : ringPt p (ψ - π / 3 - min m 1) ∈ closure T :=
      qcol_inner_tile hF hN hB htb hpT
        ⟨ψ - π / 3 - min m 1, ⟨by linarith [min_le_left m 1], by linarith [lt_min hm one_pos]⟩, rfl⟩
    have hd := hTt.dist_le_one_of_mem_closure hF _ hmem _ hyT
    have hgt := (dist_ringPt_shift_cmp p (ψ - π / 3 - min m 1) (min m 1)
      (by rw [abs_of_pos (lt_min hm one_pos)]; exact min_le_right _ _)).2 (lt_min hm one_pos)
    rw [show ψ - π / 3 - min m 1 + π / 3 + min m 1 = ψ by ring] at hgt
    linarith

/-- **FS116-N3-CROSS**, the first clause as filed, "every tile of `p` at `y` has a cone at `y` of zero angle": true
vacuously, there being no such tile (`crossed_no_tip`). -/
theorem crossed_tip_zeroAngle (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})
    (h4 : (F.coloursAt p).ncard = 4) {ψ : ℝ} {a a' b b' : Fin k} (hu : F.GermOnQWith p (ψ + π / 3) .ccw a a')
    (hv : F.GermOnQWith p (ψ - π / 3) .cw b b') (hab : Disjoint ({a, a'} : Set (Fin k)) {b, b'}) {T : Set ℂ}
    (hT : F.IsTip p (ringPt p ψ) T) : ZeroAngleAt T (ringPt p ψ) :=
  absurd hT (crossed_no_tip hF hN hpd hS h4 hu hv hab T)

/-- **FS116-N3-CROSS**, "the outer colours at `y` lie in `{a', b'}`" (no change point is read): the tiles of `p` of colours
`a` and `b` approach `p` along directions within `90°` of `ψ`, which `star_outer_cone` forbids to an outer colour's tile. -/
theorem crossed_outer (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})
    (h4 : (F.coloursAt p).ncard = 4) {ψ : ℝ} {a a' b b' : Fin k} (hu : F.GermOnQWith p (ψ + π / 3) .ccw a a')
    (hv : F.GermOnQWith p (ψ - π / 3) .cw b b') (hab : Disjoint ({a, a'} : Set (Fin k)) {b, b'}) :
    F.outerTileColours p (ringPt p ψ) ⊆ {a', b'} := by
  intro c hc
  have hπ := Real.pi_pos
  obtain ⟨ℓ, m, hℓ, hm, -, -, -, ta, tb', ta', tb, e₁, e₂, e₃, e₄, hta, htb', hta', htb, hst, he₁, -, -, -⟩ :=
    crossed_star_data hF hN hpd hS h4 hu hv hab
  obtain ⟨Tc, hTc, hpTc⟩ := (F.mem_coloursAt_iff_exists_tileOf hpd).mp hc.1
  -- the tile of `p` of an outer colour approaches `p` only along `[ψ + 90°, ψ + 270°]`, and `e₁` is within `30°` of `ψ`
  have hcone := star_outer_cone hF hN hc hTc hpTc
  have hno : e₁ ∉ angleIcc (ψ + π / 2) (ψ + 3 * π / 2) := by
    have := sub_notMem_angleIcc (a := ψ + π / 2) (b := ψ + 3 * π / 2) (u := ψ + π / 2 - e₁)
      (by linarith [he₁.2]) (by linarith [he₁.1])
    rwa [sub_sub_cancel] at this
  -- a tile has one colour
  have hcol : ∀ {c₁ c₂ : Fin k} {S : Set ℂ}, F.TileOf c₁ S → F.TileOf c₂ S → c₁ = c₂ := fun h h' => by
    obtain ⟨z, hz⟩ := h.1.nonempty
    exact (h.2 hz).symm.trans (h'.2 hz)
  rcases (hst.tileAt Tc).mp ⟨hTc.1, hpTc⟩ with rfl | rfl | rfl | rfl
  · exact absurd (hcone (by rw [hst.cone₁]; exact Icc_subset_angleIcc _ _ ⟨le_rfl, hst.le₁₂⟩)) hno
  · exact Or.inr (hcol hTc htb')
  · exact Or.inl (hcol hTc hta')
  · have h1 : e₁ + 2 * π ∈ coneAt Tc p := by rw [hst.cone₄]; exact Icc_subset_angleIcc _ _ ⟨hst.le₄₁, le_rfl⟩
    exact absurd (hcone (mem_coneAt_add_two_pi.mp h1)) hno

/-- **The four colours of a crossed vertex**: under `crossed_no_tip`'s hypotheses the colours of `p` are `a, a', b, b'`,
and each arc's two side colours differ (the star's first and third tiles, and its second and fourth, are distinct tiles of
`p`, and `p` has one tile of each colour). -/
theorem crossed_coloursAt (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})
    (h4 : (F.coloursAt p).ncard = 4) {ψ : ℝ} {a a' b b' : Fin k} (hu : F.GermOnQWith p (ψ + π / 3) .ccw a a')
    (hv : F.GermOnQWith p (ψ - π / 3) .cw b b') (hab : Disjoint ({a, a'} : Set (Fin k)) {b, b'}) :
    F.coloursAt p = {a, a', b, b'} ∧ a ≠ a' ∧ b ≠ b' := by
  obtain ⟨ℓ, m, -, -, -, -, -, ta, tb', ta', tb, e₁, e₂, e₃, e₄, hta, htb', hta', htb, hst, -, -, -, -⟩ :=
    crossed_star_data hF hN hpd hS h4 hu hv hab
  have hpa : p ∈ closure ta := ((hst.tileAt ta).mpr (Or.inl rfl)).2
  have hpb' : p ∈ closure tb' := ((hst.tileAt tb').mpr (Or.inr (Or.inl rfl))).2
  have hpa' : p ∈ closure ta' := ((hst.tileAt ta').mpr (Or.inr (Or.inr (Or.inl rfl)))).2
  have hpb : p ∈ closure tb := ((hst.tileAt tb).mpr (Or.inr (Or.inr (Or.inr rfl)))).2
  refine ⟨Subset.antisymm (fun c hc => ?_) ?_, ?_, ?_⟩
  · obtain ⟨Tc, hTc, hpTc⟩ := (F.mem_coloursAt_iff_exists_tileOf hpd).mp hc
    have hcol : ∀ {c₂ : Fin k}, F.TileOf c₂ Tc → c = c₂ := fun h' => by
      obtain ⟨z, hz⟩ := hTc.1.nonempty
      exact (hTc.2 hz).symm.trans (h'.2 hz)
    rcases (hst.tileAt Tc).mp ⟨hTc.1, hpTc⟩ with rfl | rfl | rfl | rfl
    · exact Or.inl (hcol hta)
    · exact Or.inr (Or.inr (Or.inr (hcol htb')))
    · exact Or.inr (Or.inl (hcol hta'))
    · exact Or.inr (Or.inr (Or.inl (hcol htb)))
  · rintro c (rfl | rfl | rfl | rfl)
    exacts [mem_coloursAt_of_tileOf hta hpa, mem_coloursAt_of_tileOf hta' hpa', mem_coloursAt_of_tileOf htb hpb,
      mem_coloursAt_of_tileOf htb' hpb']
  · rintro rfl
    exact hst.ne.2.1 (hN.tile_eq_of_mem_closure hF hta hta' hpa hpa')
  · rintro rfl
    exact hst.ne.2.2.2.2.1 (hN.tile_eq_of_mem_closure hF htb' htb hpb' hpb)

/-- **FS116-N3-CROSS**, four colours: at a change point `y = r(ψ)` with the tip pair on (Q) arcs of disjoint colour pairs
`a | a'` (at `u⁺`) and `b | b'` (at `v⁻`), if `y` carries four colours and no more, its outer colours are `a'` and `b'` and
the colours absent at `y` are `a` and `b`. (The row's "every tile at `y` a cone of positive angle" is idle; so is the
freedom of the outer pair.) `y` has no tip (`crossed_no_tip`), so by FS116-N2-STAR its colours are the two absent at `p`
and its outer colours, which lie in `{a', b'}` (`crossed_outer`): four colours need both.

**The class** (`h4`; ruled on FS131-I8D's finding): `p` carries *exactly* four colours. At a change point two colours are
absent at `p` (`germS_absent`: `ncard + 2 = k`), so "at least four colours with at most two absent" is four colours only at
`k = 6`; the argument reads the four tiles of `p`, and at `k ≥ 7` a fifth tile is placed by none of its windows. With `hk`
the class is `k ≤ 6`: the row's six-coloured fragments. Here the conclusion itself forces `k = 6`: the complement of a
four-colour set is a pair only then. Model: the strip's `P₀` at `P₂` (`a = P`, `a' = O`, `b = M`, `b' = B`). -/
theorem crossed_four (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1) (hS : F.SimpleOn {p})
    (h4 : (F.coloursAt p).ncard = 4) (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k}
    (hy : F.IsChangePoint p ψ X X') {a a' b b' : Fin k} (hu : F.GermOnQWith p (ψ + π / 3) .ccw a a')
    (hv : F.GermOnQWith p (ψ - π / 3) .cw b b') (hab : Disjoint ({a, a'} : Set (Fin k)) {b, b'})
    (hy4 : (F.coloursAt (ringPt p ψ)).ncard = 4) :
    F.outerTileColours p (ringPt p ψ) = {a', b'} ∧ (F.coloursAt (ringPt p ψ))ᶜ = {a, b} := by
  have hpd : p ∈ F.dom := hp (mem_closedBall_self zero_le_one)
  have hcompl := (germS_absent hF hp h4.ge hk hy).2
  -- `y` has no tip, so its colours are the two absent at `p` and its outer colours (FS116-N2-STAR)
  have hC := star_coloursAt hF hp h4.ge hk hy
  have hT : F.tipColours p (ringPt p ψ) = ∅ := by
    ext c
    simp only [mem_empty_iff_false, iff_false]
    rintro ⟨T, -, hT⟩
    exact crossed_no_tip hF hN hpd hS h4 hu hv hab T hT
  have hO := crossed_outer hF hN hpd hS h4 hu hv hab
  obtain ⟨hP, haa', hbb'⟩ := crossed_coloursAt hF hN hpd hS h4 hu hv hab
  rw [hT, empty_union, hcompl] at hC
  have h1 : (F.coloursAt (ringPt p ψ)).ncard ≤
      ({X, X'} : Set (Fin k)).ncard + (F.outerTileColours p (ringPt p ψ)).ncard := by
    rw [hC]; exact Set.ncard_union_le _ _
  have h2 : ({X, X'} : Set (Fin k)).ncard = 2 := Set.ncard_pair hy.2.1
  have h3 : ({a', b'} : Set (Fin k)).ncard ≤ 2 := by
    have := Set.ncard_insert_le a' ({b'} : Set (Fin k))
    rwa [Set.ncard_singleton] at this
  have hOeq : F.outerTileColours p (ringPt p ψ) = {a', b'} :=
    Set.eq_of_subset_of_ncard_le hO (by omega) (Set.toFinite _)
  refine ⟨hOeq, ?_⟩
  have hab' : a ≠ b' := fun h =>
    Set.disjoint_left.mp hab (show a ∈ ({a, a'} : Set (Fin k)) from Or.inl rfl) (Or.inr h)
  have ha'b : a' ≠ b := fun h =>
    Set.disjoint_left.mp hab (show a' ∈ ({a, a'} : Set (Fin k)) from Or.inr rfl) (Or.inl h)
  rw [star_absent hF hp h4.ge hk hy, hT, empty_union, hOeq, hP]
  ext c
  constructor
  · rintro ⟨hc | hc | hc | hc, hn⟩
    · exact Or.inl hc
    · exact absurd (Or.inl hc) hn
    · exact Or.inr hc
    · exact absurd (Or.inr hc) hn
  · rintro (rfl | rfl)
    · exact ⟨Or.inl rfl, fun h => h.elim haa' hab'⟩
    · exact ⟨Or.inr (Or.inr (Or.inl rfl)), fun h => h.elim (fun h => ha'b h.symm) hbb'⟩

/-- **FS116-N3-CROSS**, reciprocity, the change point: on a closed disc of radius above 2 about `p`, at a crossed full
semi-hub `y = r(ψ)` of kind O carrying four colours and no more, unless an edge of `p` runs along `ω(y)` at `p`
(`F.OnRingArc y p`), `p` is a change point of the ring of `y`, that ring being `b` just counter-clockwise of `p` and `a`
just clockwise.

**The class** (`h4`; ruled on FS131-I8D's finding): `p` carries *exactly* four colours. At a change point two colours are
absent at `p` (`germS_absent`: `ncard + 2 = k`), so "at least four colours with at most two absent" is four colours only at
`k = 6`; the argument reads the four tiles of `p`, and at `k ≥ 7` a fifth tile is placed by none of its windows. With `hk`
the class is `k ≤ 6`: the row's six-coloured fragments. Model: the strip's `P₀` at `P₂` (`P₂`'s ring is `M` just
counter-clockwise of `P₀` and `P` just clockwise). -/
theorem crossed_changePoint (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 2) (hS : F.SimpleOn {p})
    (h4 : (F.coloursAt p).ncard = 4) (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k}
    (hy : F.IsChangePoint p ψ X X') {a a' b b' : Fin k} (hu : F.GermOnQWith p (ψ + π / 3) .ccw a a')
    (hv : F.GermOnQWith p (ψ - π / 3) .cw b b') (hab : Disjoint ({a, a'} : Set (Fin k)) {b, b'})
    (hy4 : (F.coloursAt (ringPt p ψ)).ncard = 4) (hna : ¬ F.OnRingArc (ringPt p ψ) p) :
    F.IsChangePoint (ringPt p ψ) (ψ + π) b a := by
  sorry

/-- **FS116-N3-CROSS**, reciprocity, the last clause: under the same hypotheses, with the outer pair of `y` free and the
map simple at `p` and at `y`, `p` is a semi-hub of kind O of the ring of `y`.

**Grade of the row's argument at this clause: one mind and a checking reading** — the blind second mind's verdict was a gap
here, "an arc of `ω(y)` through `v` (or `u`) inside `B(p, 1)` with `X̄` on `y`'s side and `X` beyond … is not excluded"
(`plans/FS116-V5-verification.md` ll. 650–660), closed after reading by FS112-U1 at `y`. The implementer proves this leaf
last and reports the step if it does not close.

**The class** (`h4`; ruled on FS131-I8D's finding): `p` carries *exactly* four colours. At a change point two colours are
absent at `p` (`germS_absent`: `ncard + 2 = k`), so "at least four colours with at most two absent" is four colours only at
`k = 6`; the argument reads the four tiles of `p`, and at `k ≥ 7` a fifth tile is placed by none of its windows. With `hk`
the class is `k ≤ 6`: the row's six-coloured fragments. Model: the strip's `P₀` at `P₂`, where `P₀` is a crossed full
semi-hub of kind O of `P₂`'s ring. -/
theorem crossed_semiHub (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 2) {ψ : ℝ}
    (hS : F.SimpleOn {p, ringPt p ψ}) (h4 : (F.coloursAt p).ncard = 4) (hk : k ≤ (F.coloursAt p).ncard + 2)
    {X X' : Fin k} (hy : F.IsChangePoint p ψ X X') (ho : F.OuterPairFree p ψ) {a a' b b' : Fin k}
    (hu : F.GermOnQWith p (ψ + π / 3) .ccw a a') (hv : F.GermOnQWith p (ψ - π / 3) .cw b b')
    (hab : Disjoint ({a, a'} : Set (Fin k)) {b, b'}) (hy4 : (F.coloursAt (ringPt p ψ)).ncard = 4)
    (hna : ¬ F.OnRingArc (ringPt p ψ) p) : F.IsSemiHub (ringPt p ψ) (ψ + π) .O := by
  sorry

/-! ## FS116-RING-TRANSFER-QC -/

/-- **FS116-RING-TRANSFER-QC**, its first clause: at a semi-hub `y = r(ψ)` of the ring of `p`, a vertex of at least four
colours lies at `y`, at `r(ψ + 60°)` or at `r(ψ − 60°)`, unless `y` is a full parallel semi-hub of exactly three colours.
The row's other clauses are the rows above, each at the class its argument reads, and are not restated: the swapped inner
colours are `germPair_swap`; the four edges' windows `fullSemiHub_star_crossed`; the crossed semi-hub's tips, outer
colours, missing pair and reciprocity `crossed_no_tip`, `crossed_outer`, `crossed_four`, `crossed_changePoint`,
`crossed_semiHub`. (The row's "radius above 2" is read by the last two only.)

**The class** (`h4`; ruled on FS131-I8D's finding): `p` carries *exactly* four colours. At a change point two colours are
absent at `p` (`germS_absent`: `ncard + 2 = k`), so "at least four colours with at most two absent" is four colours only at
`k = 6`; the argument reads the four tiles of `p`, and at `k ≥ 7` a fifth tile is placed by none of its windows. With `hk`
the class is `k ≤ 6`: the row's six-coloured fragments. -/
theorem transferQC (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1) {ψ : ℝ}
    (hS : F.SimpleOn {p, ringPt p ψ, ringPt p (ψ + π / 3), ringPt p (ψ - π / 3)}) (h4 : (F.coloursAt p).ncard = 4)
    (hk : k ≤ (F.coloursAt p).ncard + 2) {kind : SemiKind} (hy : F.IsSemiHub p ψ kind) :
    4 ≤ (F.coloursAt (ringPt p ψ)).ncard ∨ 4 ≤ (F.coloursAt (ringPt p (ψ + π / 3))).ncard ∨
      4 ≤ (F.coloursAt (ringPt p (ψ - π / 3))).ncard ∨
      ((F.coloursAt (ringPt p ψ)).ncard = 3 ∧ F.IsFullSemiHub p ψ kind ∧
        ∃ a a', F.GermOnQWith p (ψ + π / 3) kind.qSide a a' ∧ F.GermOnQWith p (ψ - π / 3) kind.qSide.flip a' a) := by
  rcases semiHub_places hF hN hp hS h4 hk hy with h | ⟨-, w, hw, -, h⟩ | ⟨h3, hfull, a, a', hu, hv, -⟩
  · exact Or.inl h
  · rcases hw with rfl | rfl
    · exact Or.inr (Or.inl h)
    · exact Or.inr (Or.inr (Or.inl h))
  · exact Or.inr (Or.inr (Or.inr ⟨h3, hfull, a, a', hu, hv⟩))

end ArcMap

end HadwigerNelson.Plane
