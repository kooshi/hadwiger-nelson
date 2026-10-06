import Proofs.HadwigerNelson.Plane.RingCalculus.SemiHub
import Proofs.HadwigerNelson.Plane.RingCalculus.StarChart
import Proofs.HadwigerNelson.Plane.RingCalculus.SoleTip

/-!
# The ring calculus: what a semi-hub places (FS116-N3-SEMI, FS116-N3-CROSS, FS116-RING-TRANSFER-QC)

Wave 8's second planning pass (`plans/FS131-w8-kernel-plan.md`, Stages 6–10; job FS131-K8b), over the words and lemmas of
`Plane/RingCalculus/SemiHub` (whose header has the table of the nine rows, what is wider than they are, and the
inhabitants). Arguments: `plans/FS116-N3-proof.md` §§ 2.4, 3.1, 3.3; `plans/FS116-V5-verification.md` §§ 3.2, 3.4.

| row | declarations | state |
|---|---|---|
| FS116-N3-SEMI | `semiHub_places`, from `semiHub_places_O`, `semiHub_places_T` over `semiHub_edge`, `disjoint_ball_of_far_witness`, `mem_closure_of_coneAt_toward` | proved (job FS131-I8D) |
| FS116-N3-CROSS | `crossed_no_tip`, `crossed_tip_zeroAngle`, `crossed_outer`, `crossed_four`, `crossed_changePoint`, `crossed_semiHub`, over `crossed_star_data`, `crossed_coloursAt`, `crossed_not_germOnQ_inside` | proved (job FS131-I8D) |
| FS116-RING-TRANSFER-QC | `transferQC` | proved from `semiHub_places` |

**Proved over the statements of `Plane/RingCalculus/SemiHub`** (job FS131-I8C's leaves, in a tree of its own until the wave's
join): no declaration of this module holds a `sorry`, and each rests on that module's leaves it cites.

**The class** (ruled on job FS131-I8D's finding): `semiHub_places`, `transferQC`, `crossed_four`, `crossed_changePoint` and
`crossed_semiHub` read a vertex `p` of *exactly* four colours (`(F.coloursAt p).ncard = 4`). At a change point two colours are
absent at `p` (`germS_absent`), so "at least four colours, at most two absent" is four colours only at `k = 6`.

**What is wider than the rows** (each reported as a generalization): `crossed_semiHub` reads neither the freedom of the
outer pair of `y` (`ho`) nor *simple* at `y` — it holds at a closed change point too; `GermIn.tangent_mem_coneAt` (a germ
approaches its ring point along the tangent) and `IsRingArc.inner_ne_outer` are class-free.

**Inhabitants** (no Lean term; `data/fs116/n3/semi.out`): the strip's `P₀` at `P₂` — a crossed full semi-hub of kind O with
four colours — meets the hypotheses of every `crossed_*` leaf and of `semiHub_places`, and lands in its first alternative;
the bowtie's centre at `top` (parallel, four colours) meets `semiHub_places`' hypotheses likewise. No held fragment has a
three-colour semi-hub: `semiHub_places`' second alternative has no held model, and whether the third occurs is open
(SEMI-PAR3, FS-124).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## A germ approaches its ring point along the tangent -/

/-- The chord of the unit circle between the angles `m − x` and `m + x`. -/
theorem e_add_sub_e_sub (m x : ℝ) : e (m + x) - e (m - x) = ((2 * Real.sin x : ℝ) : ℂ) * (e m * I) := by
  rw [e_add, sub_eq_add_neg m x, e_add, e_eq x, e_neg x]
  push_cast
  ring

/-- **A germ approaches its ring point along the tangent**: if the germ of `ω(p)` on side `s` of `r(θ)` lies in `S`,
then `S` approaches `r(θ)` along `θ + 90°` (counter-clockwise) or `θ − 90°` (clockwise). -/
theorem GermIn.tangent_mem_coneAt {p : ℂ} {θ : ℝ} {s : Side} {S : Set ℂ} (h : GermIn p θ s S) :
    θ + s.sign * (π / 2) ∈ coneAt S (ringPt p θ) := by
  obtain ⟨δ, hδ, hS⟩ := h
  intro ε hε
  obtain ⟨t, ht0, htδ, htε, ht1⟩ : ∃ t : ℝ, 0 < t ∧ t < δ ∧ t < ε ∧ t ≤ 1 :=
    ⟨min (δ / 2) (min (ε / 2) 1), lt_min (by linarith) (lt_min (by linarith) one_pos),
      lt_of_le_of_lt (min_le_left _ _) (by linarith),
      lt_of_le_of_lt ((min_le_right _ _).trans (min_le_left _ _)) (by linarith),
      (min_le_right _ _).trans (min_le_right _ _)⟩
  have hsin : 0 < Real.sin (t / 2) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith [Real.pi_gt_three])
  have hchord : ringPt p (θ + s.sign * t) - ringPt p θ =
      ((2 * Real.sin (t / 2) : ℝ) : ℂ) * e (θ + s.sign * (π / 2 + t / 2)) := by
    cases s
    · have h1 := e_add_sub_e_sub (θ - t / 2) (-(t / 2))
      rw [show θ - t / 2 + -(t / 2) = θ + -1 * t by ring, show θ - t / 2 - -(t / 2) = θ by ring, Real.sin_neg] at h1
      have h2 : e (θ + -1 * (π / 2 + t / 2)) = e (θ - t / 2) * -I := by
        rw [show θ + -1 * (π / 2 + t / 2) = (θ - t / 2) + -(π / 2) by ring, e_add, e_neg, Real.cos_pi_div_two,
          Real.sin_pi_div_two]
        push_cast
        ring
      simp only [ringPt, Side.sign]
      rw [h2, show p + e (θ + -1 * t) - (p + e θ) = e (θ + -1 * t) - e θ by ring, h1]
      push_cast
      ring
    · have h1 := e_add_sub_e_sub (θ + t / 2) (t / 2)
      rw [show θ + t / 2 + t / 2 = θ + 1 * t by ring, show θ + t / 2 - t / 2 = θ by ring] at h1
      have h2 : e (θ + 1 * (π / 2 + t / 2)) = e (θ + t / 2) * I := by
        rw [show θ + 1 * (π / 2 + t / 2) = (θ + t / 2) + π / 2 by ring, e_add, e_pi_div_two]
      simp only [ringPt, Side.sign]
      rw [h2, show p + e (θ + 1 * t) - (p + e θ) = e (θ + 1 * t) - e θ by ring, h1]
  have hnorm : ‖ringPt p (θ + s.sign * t) - ringPt p θ‖ = 2 * Real.sin (t / 2) := by
    rw [hchord, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg (by linarith)]
  refine ⟨ringPt p (θ + s.sign * t), hS ⟨t, ⟨ht0, htδ⟩, rfl⟩, fun heq => ?_, ?_, ?_⟩
  · rw [heq, sub_self, norm_zero] at hnorm
    linarith
  · rw [dist_comm]
    exact lt_of_le_of_lt (ArcMap.dist_ringPt_germ_le p θ s ht0.le) htε
  · rw [hnorm, hchord, mul_div_cancel_left₀ _ (by
      rw [Ne, Complex.ofReal_eq_zero]; linarith)]
    refine lt_of_le_of_lt (norm_e_sub_e_le _ _) ?_
    rw [show θ + s.sign * (π / 2 + t / 2) - (θ + s.sign * (π / 2)) = s.sign * (t / 2) by ring, abs_mul,
      abs_of_pos (by linarith : (0 : ℝ) < t / 2)]
    have : |s.sign| = 1 := by cases s <;> simp [Side.sign]
    rw [this]
    linarith

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS116-N3-SEMI -/

/-- On `ω(y)`, `y = r(ψ)`, the point at angle `ψ + 240°` is `v = r(ψ − 60°)`. -/
theorem ringPt_ringPt_four_thirds (p : ℂ) (ψ : ℝ) : ringPt (ringPt p ψ) (ψ + π + π / 3) = ringPt p (ψ - π / 3) := by
  have h := ringPt_sub_ringPt_plus_third p (ψ - π / 3)
  rw [sub_add_cancel] at h
  have h2 : e (ψ + π + π / 3) = e (ψ - π / 3 - π / 3) := by
    rw [show ψ + π + π / 3 = ψ - π / 3 - π / 3 + 2 * π by ring, e_add_two_pi]
  simp only [ringPt] at h ⊢
  rw [h2]
  linear_combination -h

/-- The two side colours of an arc of `Γ` on `ω(p)` differ when the inner one is carried at `p` (FS112-U1: the two
classes' cones at `p` are disjoint, and the cone of a carried colour is not empty). -/
theorem IsRingArc.inner_ne_outer (hF : F.Valid) {p : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc p θ₁ θ₂ c c')
    (hc : c ∈ F.coloursAt p) : c ≠ c' := by
  rintro rfl
  exact absurd (F.coneAt_region_nonempty hc)
    (Set.not_nonempty_iff_eq_empty.mpr (disjoint_self.mp (hA.disjoint_coneAt hF)))

/-- A set of four elements holding four distinct named elements is those four. -/
theorem eq_of_ncard_eq_four {α : Type*} {P : Set α} (h4 : P.ncard = 4) {a a' b b' : α} (ha : a ∈ P) (ha' : a' ∈ P)
    (hb : b ∈ P) (hb' : b' ∈ P) (haa' : a ≠ a') (hbb' : b ≠ b') (hab : Disjoint ({a, a'} : Set α) {b, b'}) :
    P = {a, a', b, b'} := by
  have hfin : P.Finite := Set.finite_of_ncard_ne_zero (by omega)
  have hab1 : a ∉ ({b, b'} : Set α) := Set.disjoint_left.mp hab (Or.inl rfl)
  have hab2 : a' ∉ ({b, b'} : Set α) := Set.disjoint_left.mp hab (Or.inr rfl)
  have hcard : ({a, a', b, b'} : Set α).ncard = 4 := by
    rw [Set.ncard_insert_of_notMem (by
        rintro (h | h)
        · exact haa' h
        · exact hab1 h),
      Set.ncard_insert_of_notMem hab2, Set.ncard_pair hbb']
  exact (Set.eq_of_subset_of_ncard_le (by
    rintro x (rfl | rfl | rfl | rfl) <;> assumption) (by omega) hfin).symm

/-- A finite set of at most three elements holding three distinct named elements is those three. -/
theorem eq_triple_of_ncard_le_three {α : Type*} {S : Set α} (hfin : S.Finite) (h3 : S.ncard ≤ 3) {x x' c : α}
    (hx : x ∈ S) (hx' : x' ∈ S) (hc : c ∈ S) (hxx' : x ≠ x') (hcx : c ≠ x) (hcx' : c ≠ x') :
    S = {x, x', c} ∧ S.ncard = 3 := by
  have hcard : ({x, x', c} : Set α).ncard = 3 := by
    rw [Set.ncard_insert_of_notMem (by
        rintro (h | h)
        · exact hxx' h
        · exact hcx h.symm),
      Set.ncard_pair fun h => hcx' h.symm]
  have heq : ({x, x', c} : Set α) = S := Set.eq_of_subset_of_ncard_le (by
    rintro z (rfl | rfl | rfl) <;> assumption) (by omega) hfin
  exact ⟨heq.symm, by rw [← heq, hcard]⟩

/-- **A tile is far from a point its colour reaches by another tile**: let `C` be a tile of colour `o` with `y` in its
closure, `w` a point carrying `o`, and `x` a closure point of the class of `o` nearer than `1` to `w` and more than `1`
from `y`. Then the tile of colour `o` at `w` is not `C` (it would hold `x`, by the non-Siamese engine, more than `1` from
`y`), so `C` is far from it and misses `B(w, 1)`. -/
theorem disjoint_ball_of_far_witness (hF : F.Valid) (hN : F.NonSiamese) {o : Fin k} {C : Set ℂ} (hC : F.TileOf o C)
    {y w x : ℂ} (hyC : y ∈ closure C) (hwd : w ∈ F.dom) (hw : o ∈ F.coloursAt w) (hxd : x ∈ F.dom)
    (hx : x ∈ closure (F.region o)) (hxw : dist x w < 1) (hxy : 1 < dist x y) : Disjoint C (ball w 1) := by
  obtain ⟨Tw, hTw, hwT⟩ := (F.mem_coloursAt_iff_exists_tileOf hwd).mp hw
  rcases unitNear_or_unitFar hF hC hTw with h | h
  · exfalso
    have hCT : C = Tw := hN.eq_of_unitNear hC hTw h
    have hxC : x ∈ closure C := mem_closure_tile_of_near hF hN hC hxd hx (hCT ▸ hwT) hxw
    linarith [hC.1.dist_le_one_of_mem_closure hF x hxC y hyC]
  · exact Set.disjoint_left.mpr fun z hz hzb =>
      absurd (UnitFar.one_le_dist_of_mem_closure h (subset_closure hz) hwT) (not_le.mpr (mem_ball.mp hzb))

/-- **A tile reaches a point carrying its colour when it approaches toward it**: a tile `τ` of colour `t` approaching `y`
along a direction within `90°` of `γ` has points in `B(y + e(γ), 1)`, so it is not far from the tile of colour `t` at
`w = y + e(γ)`: it is that tile, and `w` is in its closure. -/
theorem mem_closure_of_coneAt_toward (hF : F.Valid) (hN : F.NonSiamese) {t : Fin k} {τ : Set ℂ} (hτ : F.TileOf t τ)
    {y : ℂ} {β γ : ℝ} (hβ : β ∈ coneAt τ y) (hcos : 0 < Real.cos (β - γ)) (hwd : ringPt y γ ∈ F.dom)
    (hw : t ∈ F.coloursAt (ringPt y γ)) : ringPt y γ ∈ closure τ := by
  obtain ⟨Tw, hTw, hwT⟩ := (F.mem_coloursAt_iff_exists_tileOf hwd).mp hw
  rcases unitNear_or_unitFar hF hτ hTw with h | h
  · exact hN.eq_of_unitNear hτ hTw h ▸ hwT
  · exfalso
    obtain ⟨z, hzτ, hzb⟩ := inter_ball_nonempty_of_coneAt hβ hcos
    exact absurd (UnitFar.one_le_dist_of_mem_closure h (subset_closure hzτ) hwT) (not_le.mpr (mem_ball.mp hzb))

/-- **FS116-N3-CONE (c), composed** (`plans/FS116-N3-proof.md` § 2.1 (c)): at a point `y` of at most three colours, two
distinct tiles of `y`, one inside `B̄(w, 1)` and one missing `B(w, 1)`, whose colours are both carried at `w`, share an edge
at `y` (any two of three tiles are consecutive: `exists_initialPiece_of_ncard_le_three`) which is an arc of `ω(w)`
(`isRingArc_of_edge`) of kind both, and `w` carries at least four colours (`four_le_of_bothKind`). -/
theorem semiHub_edge (hF : F.Valid) (hN : F.NonSiamese) {y w : ℂ} (hyd : y ∈ F.dom) (hwd : w ∈ F.dom)
    (hSy : F.SimpleOn {y}) (hSw : F.SimpleOn {w}) (h3 : (F.coloursAt y).ncard ≤ 3) {T₁ T₂ : Set ℂ} {c₁ c₂ : Fin k}
    (hT₁ : F.TileOf c₁ T₁) (hT₂ : F.TileOf c₂ T₂) (hy₁ : y ∈ closure T₁) (hy₂ : y ∈ closure T₂) (hne : T₁ ≠ T₂)
    (h₁ : T₁ ⊆ closedBall w 1) (h₂ : Disjoint T₂ (ball w 1)) (hc₁ : c₁ ∈ F.coloursAt w) (hc₂ : c₂ ∈ F.coloursAt w) :
    (∃ θ₁ θ₂, F.BothKind w θ₁ θ₂ ∧ y ∈ ringArc w θ₁ θ₂) ∧ 4 ≤ (F.coloursAt w).ncard := by
  obtain ⟨α, hα, δ, B, hB, hBT⟩ :=
    exists_initialPiece_of_ncard_le_three hF hN hyd hSy h3 ⟨hT₁.1, hy₁⟩ ⟨hT₂.1, hy₂⟩ hne
  obtain ⟨θ₁, θ₂, hA, hyA⟩ := isRingArc_of_edge hyd hT₁ hT₂ hne h₁ h₂ hα hB hBT
  exact ⟨⟨θ₁, θ₂, ⟨c₁, c₂, hA, hc₁, hc₂⟩, hyA⟩, four_le_of_bothKind hF hN hwd hSw ⟨c₁, c₂, hA, hc₁, hc₂⟩⟩

/-- **FS116-N3-SEMI, kind O** (`plans/FS116-N3-proof.md` § 2.4, in the region-level form of
`plans/FS131-w8-kernel-plan.md` § 9.3: no direction is tracked at `y`). `y` carries the ring's colours `X`, `X'` and an
outer colour `o`; with three colours and no more its tiles are `R`, `R'` and one outer tile `C`. If `v⁻` (resp. `u⁺`) lies
on no (Q) arc, `R` and `R'` lie on opposite sides of `ω(v)` (resp. `ω(u)`) and both colours are carried there. If both lie
on (Q) arcs and `o` is a side colour of the arc at `u` (at `v`), `C` misses `B(u, 1)` (`B(v, 1)`), `R` (`R'`) lies inside,
and both colours are carried there. Otherwise the two arcs' pairs are not disjoint (the four colours of `p` would be
theirs), so they are swapped (`germPair_dicho`), and `o`'s tile of `p` is the star's `t_back`, `t_front` being barred by
`star_outer_cone`. -/
theorem semiHub_places_O (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1) {ψ : ℝ}
    (hS : F.SimpleOn {p, ringPt p ψ, ringPt p (ψ + π / 3), ringPt p (ψ - π / 3)}) (h4 : (F.coloursAt p).ncard = 4)
    (hk : k ≤ (F.coloursAt p).ncard + 2) (hy : F.IsSemiHub p ψ .O) :
    4 ≤ (F.coloursAt (ringPt p ψ)).ncard ∨
      ((F.coloursAt (ringPt p ψ)).ncard = 3 ∧ ∃ w, (w = ringPt p (ψ + π / 3) ∨ w = ringPt p (ψ - π / 3)) ∧
        (∃ θ₁ θ₂, F.BothKind w θ₁ θ₂ ∧ ringPt p ψ ∈ ringArc w θ₁ θ₂) ∧ 4 ≤ (F.coloursAt w).ncard) ∨
      ((F.coloursAt (ringPt p ψ)).ncard = 3 ∧ F.IsFullSemiHub p ψ .O ∧
        ∃ a a', F.GermOnQWith p (ψ + π / 3) (SemiKind.qSide .O) a a' ∧
          F.GermOnQWith p (ψ - π / 3) (SemiKind.qSide .O).flip a' a ∧
          ∃ c T, F.TileOf c T ∧ p ∈ closure T ∧ F.coloursAt (ringPt p ψ) = (F.coloursAt p)ᶜ ∪ {c} ∧
            ((.O : SemiKind) = .O → angleIcc (ψ + 5 * π / 6) (ψ + 7 * π / 6) ⊆ coneAt T p) ∧
            ((.O : SemiKind) = .T → angleIcc (ψ - π / 6) (ψ + π / 6) ⊆ coneAt T p)) := by
  obtain ⟨⟨X, X', hch⟩, ho, -⟩ := hy
  have hπ := Real.pi_pos
  have hpd : p ∈ F.dom := hp (mem_closedBall_self zero_le_one)
  have hyd : ringPt p ψ ∈ F.dom := hp (mem_closedBall.mpr (dist_ringPt p ψ).le)
  have hud : ringPt p (ψ + π / 3) ∈ F.dom := hp (mem_closedBall.mpr (dist_ringPt p _).le)
  have hvd : ringPt p (ψ - π / 3) ∈ F.dom := hp (mem_closedBall.mpr (dist_ringPt p _).le)
  have hSp : F.SimpleOn {p} := hS.mono (by simp)
  have hSy : F.SimpleOn {ringPt p ψ} := hS.mono (by simp)
  have hSu : F.SimpleOn {ringPt p (ψ + π / 3)} := hS.mono (by simp)
  have hSv : F.SimpleOn {ringPt p (ψ - π / 3)} := hS.mono (by simp)
  by_cases h4y : 4 ≤ (F.coloursAt (ringPt p ψ)).ncard
  · exact Or.inl h4y
  have h3y : (F.coloursAt (ringPt p ψ)).ncard ≤ 3 := by omega
  have hcompl := (germS_absent hF hp h4.ge hk hch).2
  have hXp : X ∉ F.coloursAt p := by
    have h : X ∈ (F.coloursAt p)ᶜ := by rw [hcompl]; exact Or.inl rfl
    exact h
  have hX'p : X' ∉ F.coloursAt p := by
    have h : X' ∈ (F.coloursAt p)ᶜ := by rw [hcompl]; exact Or.inr rfl
    exact h
  -- the two ring tiles of `y`
  have hXy : X ∈ F.coloursAt (ringPt p ψ) := hch.2.2.1.ringPt_mem_closure
  have hX'y : X' ∈ F.coloursAt (ringPt p ψ) := hch.2.2.2.ringPt_mem_closure
  obtain ⟨R, hR, hyR⟩ := (F.mem_coloursAt_iff_exists_tileOf hyd).mp hXy
  obtain ⟨R', hR', hyR'⟩ := (F.mem_coloursAt_iff_exists_tileOf hyd).mp hX'y
  have hcol : ∀ {c₁ c₂ : Fin k} {S : Set ℂ}, F.TileOf c₁ S → F.TileOf c₂ S → c₁ = c₂ := fun h h' => by
    obtain ⟨z, hz⟩ := h.1.nonempty
    exact (h.2 hz).symm.trans (h'.2 hz)
  have hRR' : R ≠ R' := fun h => hch.2.1 (hcol hR (h ▸ hR'))
  -- the outer tile of `y`
  obtain ⟨o, hop, C, hC, hyC, hpC⟩ := star_outer_nonempty hF hp h4.ge hk hch ho
  have hoX : o ≠ X := fun h => hXp (h ▸ hop)
  have hoX' : o ≠ X' := fun h => hX'p (h ▸ hop)
  obtain ⟨hCy, h3⟩ := eq_triple_of_ncard_le_three (Set.toFinite _) h3y hXy hX'y (mem_coloursAt_of_tileOf hC hyC)
    hch.2.1 hoX hoX'
  have hRC : R ≠ C := fun h => hoX (hcol hC (h ▸ hR))
  have hR'C : R' ≠ C := fun h => hoX' (hcol hC (h ▸ hR'))
  by_cases hvm : F.GermOnQ p (ψ - π / 3) .cw
  swap
  · -- `v⁻` off (Q): `R'` inside `B̄(v, 1)`, `R` outside `B(v, 1)`
    obtain ⟨hvR', hR'v⟩ := ringTile_vPlus hF hN hp h4.ge hk hch ho.2 hR' hyR'
    have hRv := ringTile_vMinus hF hN hp h4.ge hk hch hvm hR hyR
    have hXv : X ∈ F.coloursAt (ringPt p (ψ - π / 3)) := by
      have := (qcol_cw hF hp h4.ge hk hch (Or.inr rfl) hvm).ringPt_mem_closure
      rwa [closure_closure] at this
    obtain ⟨hboth, h4w⟩ := semiHub_edge hF hN hyd hvd hSy hSv h3y hR' hR hyR' hyR (Ne.symm hRR') hR'v hRv
      (mem_coloursAt_of_tileOf hR' hvR') hXv
    exact Or.inr (Or.inl ⟨h3, _, Or.inr rfl, hboth, h4w⟩)
  by_cases hup : F.GermOnQ p (ψ + π / 3) .ccw
  swap
  · -- `u⁺` off (Q): `R` inside `B̄(u, 1)`, `R'` outside `B(u, 1)`
    obtain ⟨huR, hRu⟩ := ringTile_uMinus hF hN hp h4.ge hk hch ho.1 hR hyR
    have hR'u := ringTile_uPlus hF hN hp h4.ge hk hch hup hR' hyR'
    have hX'u : X' ∈ F.coloursAt (ringPt p (ψ + π / 3)) := by
      have := (qcol_ccw hF hp h4.ge hk hch (Or.inl rfl) hup).ringPt_mem_closure
      rwa [closure_closure] at this
    obtain ⟨hboth, h4w⟩ := semiHub_edge hF hN hyd hud hSy hSu h3y hR hR' hyR hyR' hRR' hRu hR'u
      (mem_coloursAt_of_tileOf hR huR) hX'u
    exact Or.inr (Or.inl ⟨h3, _, Or.inl rfl, hboth, h4w⟩)
  -- full: both germs of the tip pair on (Q) arcs
  obtain ⟨θ₁, θ₂, ⟨a, a', hA₀, ha, ha', h4a⟩, hga⟩ := hup
  obtain ⟨θ₃, θ₄, ⟨b, b', hB₀, hb, hb', h4b⟩, hgb⟩ := hvm
  have hu : F.GermOnQWith p (ψ + π / 3) .ccw a a' := ⟨θ₁, θ₂, hA₀, ha, ha', h4a, hga⟩
  have hv : F.GermOnQWith p (ψ - π / 3) .cw b b' := ⟨θ₃, θ₄, hB₀, hb, hb', h4b, hgb⟩
  obtain ⟨ℓ, hℓ, hA⟩ := hu.exists_isRingArc_ccw
  obtain ⟨m, hm, hB⟩ := hv.exists_isRingArc_cw
  by_cases hoa : o = a ∨ o = a'
  · -- `o` is a side colour of the arc at `u`: `C` misses `B(u, 1)`, `R` lies in `B̄(u, 1)`
    obtain ⟨huR, hRu⟩ := ringTile_uMinus hF hN hp h4.ge hk hch ho.1 hR hyR
    have ht0 : 0 < min ℓ (1 / 2) := lt_min hℓ (by norm_num)
    have ht1 : min ℓ (1 / 2) ≤ 1 / 2 := min_le_right _ _
    have hcl : ringArc p (ψ + π / 3) (ψ + π / 3 + ℓ) ⊆ closure (F.region o) := by
      rcases hoa with rfl | rfl
      · exact hA.ringArc_subset_closure.1
      · exact hA.ringArc_subset_closure.2
    have hou : o ∈ F.coloursAt (ringPt p (ψ + π / 3)) := hcl ⟨_, left_mem_Icc.mpr (by linarith), rfl⟩
    have hxcl : ringPt p (ψ + π / 3 + min ℓ (1 / 2)) ∈ closure (F.region o) :=
      hcl ⟨_, ⟨by linarith, by linarith [min_le_left ℓ (1 / 2)]⟩, rfl⟩
    have hxu : dist (ringPt p (ψ + π / 3 + min ℓ (1 / 2))) (ringPt p (ψ + π / 3)) < 1 := by
      have := dist_ringPt_germ_le p (ψ + π / 3) .ccw ht0.le
      rw [show ψ + π / 3 + Side.ccw.sign * min ℓ (1 / 2) = ψ + π / 3 + min ℓ (1 / 2) by simp [Side.sign],
        dist_comm] at this
      linarith
    have hxy : 1 < dist (ringPt p (ψ + π / 3 + min ℓ (1 / 2))) (ringPt p ψ) := by
      have := (dist_ringPt_shift_cmp p ψ (min ℓ (1 / 2)) (by rw [abs_of_pos ht0]; linarith)).2 ht0
      rwa [dist_comm] at this
    have hCu := disjoint_ball_of_far_witness hF hN hC hyC hud hou
      (hp (mem_closedBall.mpr (dist_ringPt p _).le)) hxcl hxu hxy
    obtain ⟨hboth, h4w⟩ := semiHub_edge hF hN hyd hud hSy hSu h3y hR hC hyR hyC hRC hRu hCu
      (mem_coloursAt_of_tileOf hR huR) hou
    exact Or.inr (Or.inl ⟨h3, _, Or.inl rfl, hboth, h4w⟩)
  by_cases hob : o = b ∨ o = b'
  · -- `o` is a side colour of the arc at `v`: `C` misses `B(v, 1)`, `R'` lies in `B̄(v, 1)`
    obtain ⟨hvR', hR'v⟩ := ringTile_vPlus hF hN hp h4.ge hk hch ho.2 hR' hyR'
    have ht0 : 0 < min m (1 / 2) := lt_min hm (by norm_num)
    have ht1 : min m (1 / 2) ≤ 1 / 2 := min_le_right _ _
    have hcl : ringArc p (ψ - π / 3 - m) (ψ - π / 3) ⊆ closure (F.region o) := by
      rcases hob with rfl | rfl
      · exact hB.ringArc_subset_closure.1
      · exact hB.ringArc_subset_closure.2
    have hov : o ∈ F.coloursAt (ringPt p (ψ - π / 3)) := hcl ⟨_, right_mem_Icc.mpr (by linarith), rfl⟩
    have hxcl : ringPt p (ψ - π / 3 - min m (1 / 2)) ∈ closure (F.region o) :=
      hcl ⟨_, ⟨by linarith [min_le_left m (1 / 2)], by linarith⟩, rfl⟩
    have hxv : dist (ringPt p (ψ - π / 3 - min m (1 / 2))) (ringPt p (ψ - π / 3)) < 1 := by
      have := dist_ringPt_germ_le p (ψ - π / 3) .cw ht0.le
      rw [show ψ - π / 3 + Side.cw.sign * min m (1 / 2) = ψ - π / 3 - min m (1 / 2) by simp [Side.sign]; ring,
        dist_comm] at this
      linarith
    have hxy : 1 < dist (ringPt p (ψ - π / 3 - min m (1 / 2))) (ringPt p ψ) := by
      have := (dist_ringPt_shift_cmp p (ψ - π / 3 - min m (1 / 2)) (min m (1 / 2))
        (by rw [abs_of_pos ht0]; linarith)).2 ht0
      rwa [show ψ - π / 3 - min m (1 / 2) + π / 3 + min m (1 / 2) = ψ by ring] at this
    have hCv := disjoint_ball_of_far_witness hF hN hC hyC hvd hov
      (hp (mem_closedBall.mpr (dist_ringPt p _).le)) hxcl hxv hxy
    obtain ⟨hboth, h4w⟩ := semiHub_edge hF hN hyd hvd hSy hSv h3y hR' hC hyR' hyC hR'C hR'v hCv
      (mem_coloursAt_of_tileOf hR' hvR') hov
    exact Or.inr (Or.inl ⟨h3, _, Or.inr rfl, hboth, h4w⟩)
  -- `o` is in neither pair: the pairs are not disjoint, so they are swapped
  rcases germPair_dicho hF hN hpd hSp h4 .ccw hu hv with ⟨h1, h2⟩ | hdisj
  swap
  · exfalso
    have hP := eq_of_ncard_eq_four h4 ha ha' hb hb' (hA.inner_ne_outer hF ha) (hB.inner_ne_outer hF hb) hdisj
    rw [hP] at hop
    rcases hop with h | h | h | h
    exacts [hoa (Or.inl h), hoa (Or.inr h), hob (Or.inl h), hob (Or.inr h)]
  have hv' : F.GermOnQWith p (ψ - π / 3) .cw a' a := by rw [h1, h2]; exact hv
  have hB' : F.IsRingArc p (ψ - π / 3 - m) (ψ - π / 3) a' a := by rw [h1, h2]; exact hB
  obtain ⟨ta, tback, ta', tfront, e₁, e₂, e₃, e₄, hta, hta', hst, h1e, h2e, h3e, h4e⟩ :=
    fullSemiHub_star_parallel hF hN hpd hSp h4 hA hB' ha ha'
  obtain ⟨To, hTo, hpTo⟩ := (F.mem_coloursAt_iff_exists_tileOf hpd).mp hop
  have hcone := star_outer_cone hF hN ⟨hop, C, hC, hyC, hpC⟩ hTo hpTo
  have hfull : F.IsFullSemiHub p ψ .O := ⟨⟨X, X', hch⟩, ho, hv.germOnQ, hu.germOnQ⟩
  have hCy' : F.coloursAt (ringPt p ψ) = (F.coloursAt p)ᶜ ∪ {o} := by
    rw [hCy, hcompl]
    ext d
    simp only [mem_insert_iff, mem_singleton_iff, mem_union]
    tauto
  rcases (hst.tileAt To).mp ⟨hTo.1, hpTo⟩ with rfl | rfl | rfl | rfl
  · exact absurd (Or.inl (hcol hTo hta)) hoa
  · exact Or.inr (Or.inr ⟨h3, hfull, a, a', hu, hv', o, _, hTo, hpTo, hCy',
      fun _ => hst.angleIcc_subset_cone₂ h2e h3e, fun h => absurd h (by decide)⟩)
  · exact absurd (Or.inr (hcol hTo hta')) hoa
  · -- `t_front` approaches `p` along `ψ`, which `star_outer_cone` bars to an outer colour's tile
    exfalso
    have hmem : ψ + 2 * π ∈ coneAt To p := by
      rw [hst.cone₄]; exact Icc_subset_angleIcc _ _ ⟨by linarith, by linarith⟩
    have hψ := hcone (mem_coneAt_add_two_pi.mp hmem)
    refine sub_notMem_angleIcc (a := ψ + π / 2) (b := ψ + 3 * π / 2) (u := π / 2) (by linarith) (by linarith) ?_
    rwa [add_sub_cancel_right]

/-- **FS116-N3-SEMI, kind T** (`plans/FS116-N3-proof.md` § 2.4, region-level form). `y` carries `X`, `X'` and the colour
`t` of a tip `τ` — the tile of `p` that approaches `y` along the direction to `p` (`ringGerm_inward`); with three colours
its tiles are `R`, `R'`, `τ`. If `u⁻` (resp. `v⁺`) lies on no (Q) arc, `R` and `R'` lie on opposite sides of `ω(u)`
(`ω(v)`). If both lie on (Q) arcs and `t` is a side colour of the arc at `u` (at `v`), `τ` holds `u` (`v`) — it approaches
`y` toward it, so it is not far from the tile of its colour there — and `R'` (`R`) misses the open disc. Otherwise the
pairs are swapped, and `τ` is the star's `t_front`, `t_back` approaching `p` along `ψ + 180°`, where no tip does. -/
theorem semiHub_places_T (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1) {ψ : ℝ}
    (hS : F.SimpleOn {p, ringPt p ψ, ringPt p (ψ + π / 3), ringPt p (ψ - π / 3)}) (h4 : (F.coloursAt p).ncard = 4)
    (hk : k ≤ (F.coloursAt p).ncard + 2) (hy : F.IsSemiHub p ψ .T) :
    4 ≤ (F.coloursAt (ringPt p ψ)).ncard ∨
      ((F.coloursAt (ringPt p ψ)).ncard = 3 ∧ ∃ w, (w = ringPt p (ψ + π / 3) ∨ w = ringPt p (ψ - π / 3)) ∧
        (∃ θ₁ θ₂, F.BothKind w θ₁ θ₂ ∧ ringPt p ψ ∈ ringArc w θ₁ θ₂) ∧ 4 ≤ (F.coloursAt w).ncard) ∨
      ((F.coloursAt (ringPt p ψ)).ncard = 3 ∧ F.IsFullSemiHub p ψ .T ∧
        ∃ a a', F.GermOnQWith p (ψ + π / 3) (SemiKind.qSide .T) a a' ∧
          F.GermOnQWith p (ψ - π / 3) (SemiKind.qSide .T).flip a' a ∧
          ∃ c T, F.TileOf c T ∧ p ∈ closure T ∧ F.coloursAt (ringPt p ψ) = (F.coloursAt p)ᶜ ∪ {c} ∧
            ((.T : SemiKind) = .O → angleIcc (ψ + 5 * π / 6) (ψ + 7 * π / 6) ⊆ coneAt T p) ∧
            ((.T : SemiKind) = .T → angleIcc (ψ - π / 6) (ψ + π / 6) ⊆ coneAt T p)) := by
  obtain ⟨⟨X, X', hch⟩, ht, -⟩ := hy
  have hπ := Real.pi_pos
  have hpd : p ∈ F.dom := hp (mem_closedBall_self zero_le_one)
  have hyd : ringPt p ψ ∈ F.dom := hp (mem_closedBall.mpr (dist_ringPt p ψ).le)
  have hud : ringPt p (ψ + π / 3) ∈ F.dom := hp (mem_closedBall.mpr (dist_ringPt p _).le)
  have hvd : ringPt p (ψ - π / 3) ∈ F.dom := hp (mem_closedBall.mpr (dist_ringPt p _).le)
  have hSp : F.SimpleOn {p} := hS.mono (by simp)
  have hSy : F.SimpleOn {ringPt p ψ} := hS.mono (by simp)
  have hSu : F.SimpleOn {ringPt p (ψ + π / 3)} := hS.mono (by simp)
  have hSv : F.SimpleOn {ringPt p (ψ - π / 3)} := hS.mono (by simp)
  by_cases h4y : 4 ≤ (F.coloursAt (ringPt p ψ)).ncard
  · exact Or.inl h4y
  have h3y : (F.coloursAt (ringPt p ψ)).ncard ≤ 3 := by omega
  have hcompl := (germS_absent hF hp h4.ge hk hch).2
  have hXp : X ∉ F.coloursAt p := by
    have h : X ∈ (F.coloursAt p)ᶜ := by rw [hcompl]; exact Or.inl rfl
    exact h
  have hX'p : X' ∉ F.coloursAt p := by
    have h : X' ∈ (F.coloursAt p)ᶜ := by rw [hcompl]; exact Or.inr rfl
    exact h
  -- the two ring tiles of `y`
  have hXy : X ∈ F.coloursAt (ringPt p ψ) := hch.2.2.1.ringPt_mem_closure
  have hX'y : X' ∈ F.coloursAt (ringPt p ψ) := hch.2.2.2.ringPt_mem_closure
  obtain ⟨R, hR, hyR⟩ := (F.mem_coloursAt_iff_exists_tileOf hyd).mp hXy
  obtain ⟨R', hR', hyR'⟩ := (F.mem_coloursAt_iff_exists_tileOf hyd).mp hX'y
  have hcol : ∀ {c₁ c₂ : Fin k} {S : Set ℂ}, F.TileOf c₁ S → F.TileOf c₂ S → c₁ = c₂ := fun h h' => by
    obtain ⟨z, hz⟩ := h.1.nonempty
    exact (h.2 hz).symm.trans (h'.2 hz)
  have hRR' : R ≠ R' := fun h => hch.2.1 (hcol hR (h ▸ hR'))
  -- the tip of `y`: the tile of `p` approaching `y` along the direction to `p`
  obtain ⟨τ, hτtip, hτcone⟩ := ringGerm_inward hF hN hp h4.ge hk hch ht (ψ + π) ⟨by linarith, by linarith⟩
  obtain ⟨z₀, hz₀⟩ := hτtip.1.nonempty
  have hτ : F.TileOf (F.col z₀) τ := hτtip.1.tileOf hz₀
  generalize F.col z₀ = t at hτ
  have htp : t ∈ F.coloursAt p := mem_coloursAt_of_tileOf hτ hτtip.2.1
  have htX : t ≠ X := fun h => hXp (h ▸ htp)
  have htX' : t ≠ X' := fun h => hX'p (h ▸ htp)
  obtain ⟨hCy, h3⟩ := eq_triple_of_ncard_le_three (Set.toFinite _) h3y hXy hX'y
    (mem_coloursAt_of_tileOf hτ hτtip.2.2) hch.2.1 htX htX'
  have hτR : τ ≠ R := fun h => htX (hcol hτ (h ▸ hR))
  have hτR' : τ ≠ R' := fun h => htX' (hcol hτ (h ▸ hR'))
  by_cases hum : F.GermOnQ p (ψ + π / 3) .cw
  swap
  · -- `u⁻` off (Q): `R` inside `B̄(u, 1)`, `R'` outside `B(u, 1)`
    obtain ⟨huR, hRu⟩ := ringTile_uMinus hF hN hp h4.ge hk hch hum hR hyR
    have hR'u := ringTile_uPlus hF hN hp h4.ge hk hch ht.2 hR' hyR'
    have hX'u : X' ∈ F.coloursAt (ringPt p (ψ + π / 3)) := by
      have := (qcol_ccw hF hp h4.ge hk hch (Or.inl rfl) ht.2).ringPt_mem_closure
      rwa [closure_closure] at this
    obtain ⟨hboth, h4w⟩ := semiHub_edge hF hN hyd hud hSy hSu h3y hR hR' hyR hyR' hRR' hRu hR'u
      (mem_coloursAt_of_tileOf hR huR) hX'u
    exact Or.inr (Or.inl ⟨h3, _, Or.inl rfl, hboth, h4w⟩)
  by_cases hvp : F.GermOnQ p (ψ - π / 3) .ccw
  swap
  · -- `v⁺` off (Q): `R'` inside `B̄(v, 1)`, `R` outside `B(v, 1)`
    obtain ⟨hvR', hR'v⟩ := ringTile_vPlus hF hN hp h4.ge hk hch hvp hR' hyR'
    have hRv := ringTile_vMinus hF hN hp h4.ge hk hch ht.1 hR hyR
    have hXv : X ∈ F.coloursAt (ringPt p (ψ - π / 3)) := by
      have := (qcol_cw hF hp h4.ge hk hch (Or.inr rfl) ht.1).ringPt_mem_closure
      rwa [closure_closure] at this
    obtain ⟨hboth, h4w⟩ := semiHub_edge hF hN hyd hvd hSy hSv h3y hR' hR hyR' hyR (Ne.symm hRR') hR'v hRv
      (mem_coloursAt_of_tileOf hR' hvR') hXv
    exact Or.inr (Or.inl ⟨h3, _, Or.inr rfl, hboth, h4w⟩)
  -- full: both germs of the outer pair on (Q) arcs
  obtain ⟨θ₁, θ₂, ⟨a, a', hA₀, ha, ha', h4a⟩, hga⟩ := hum
  obtain ⟨θ₃, θ₄, ⟨b, b', hB₀, hb, hb', h4b⟩, hgb⟩ := hvp
  have hu : F.GermOnQWith p (ψ + π / 3) .cw a a' := ⟨θ₁, θ₂, hA₀, ha, ha', h4a, hga⟩
  have hv : F.GermOnQWith p (ψ - π / 3) .ccw b b' := ⟨θ₃, θ₄, hB₀, hb, hb', h4b, hgb⟩
  obtain ⟨ℓ, hℓ, hA⟩ := hu.exists_isRingArc_cw
  obtain ⟨m, hm, hB⟩ := hv.exists_isRingArc_ccw
  by_cases hta : t = a ∨ t = a'
  · -- `t` is a side colour of the arc at `u`: `τ` holds `u`, `R'` misses `B(u, 1)`
    have htu : t ∈ F.coloursAt (ringPt p (ψ + π / 3)) := by
      have hmem : ringPt p (ψ + π / 3) ∈ ringArc p (ψ + π / 3 - ℓ) (ψ + π / 3) :=
        ⟨_, right_mem_Icc.mpr (by linarith), rfl⟩
      rcases hta with rfl | rfl
      · exact hA.ringArc_subset_closure.1 hmem
      · exact hA.ringArc_subset_closure.2 hmem
    have huτ : ringPt p (ψ + π / 3) ∈ closure τ := by
      have h := mem_closure_of_coneAt_toward hF hN hτ hτcone (γ := ψ + 2 * π / 3)
        (by rw [show ψ + π - (ψ + 2 * π / 3) = π / 3 by ring, Real.cos_pi_div_three]; norm_num)
        (by rw [ringPt_ringPt_two_thirds]; exact hud) (by rw [ringPt_ringPt_two_thirds]; exact htu)
      rwa [ringPt_ringPt_two_thirds] at h
    have hR'u := ringTile_uPlus hF hN hp h4.ge hk hch ht.2 hR' hyR'
    have hX'u : X' ∈ F.coloursAt (ringPt p (ψ + π / 3)) := by
      have := (qcol_ccw hF hp h4.ge hk hch (Or.inl rfl) ht.2).ringPt_mem_closure
      rwa [closure_closure] at this
    obtain ⟨hboth, h4w⟩ := semiHub_edge hF hN hyd hud hSy hSu h3y hτ hR' hτtip.2.2 hyR' hτR'
      ((hτ.1.subset_ball hF huτ).trans ball_subset_closedBall) hR'u htu hX'u
    exact Or.inr (Or.inl ⟨h3, _, Or.inl rfl, hboth, h4w⟩)
  by_cases htb : t = b ∨ t = b'
  · -- `t` is a side colour of the arc at `v`: `τ` holds `v`, `R` misses `B(v, 1)`
    have htv : t ∈ F.coloursAt (ringPt p (ψ - π / 3)) := by
      have hmem : ringPt p (ψ - π / 3) ∈ ringArc p (ψ - π / 3) (ψ - π / 3 + m) :=
        ⟨_, left_mem_Icc.mpr (by linarith), rfl⟩
      rcases htb with rfl | rfl
      · exact hB.ringArc_subset_closure.1 hmem
      · exact hB.ringArc_subset_closure.2 hmem
    have hvτ : ringPt p (ψ - π / 3) ∈ closure τ := by
      have h := mem_closure_of_coneAt_toward hF hN hτ hτcone (γ := ψ + π + π / 3)
        (by rw [show ψ + π - (ψ + π + π / 3) = -(π / 3) by ring, Real.cos_neg, Real.cos_pi_div_three]; norm_num)
        (by rw [ringPt_ringPt_four_thirds]; exact hvd) (by rw [ringPt_ringPt_four_thirds]; exact htv)
      rwa [ringPt_ringPt_four_thirds] at h
    have hRv := ringTile_vMinus hF hN hp h4.ge hk hch ht.1 hR hyR
    have hXv : X ∈ F.coloursAt (ringPt p (ψ - π / 3)) := by
      have := (qcol_cw hF hp h4.ge hk hch (Or.inr rfl) ht.1).ringPt_mem_closure
      rwa [closure_closure] at this
    obtain ⟨hboth, h4w⟩ := semiHub_edge hF hN hyd hvd hSy hSv h3y hτ hR hτtip.2.2 hyR hτR
      ((hτ.1.subset_ball hF hvτ).trans ball_subset_closedBall) hRv htv hXv
    exact Or.inr (Or.inl ⟨h3, _, Or.inr rfl, hboth, h4w⟩)
  -- `t` is in neither pair: the pairs are not disjoint, so they are swapped
  rcases germPair_dicho hF hN hpd hSp h4 .cw hu hv with ⟨h1, h2⟩ | hdisj
  swap
  · exfalso
    have hP := eq_of_ncard_eq_four h4 ha ha' hb hb' (hA.inner_ne_outer hF ha) (hB.inner_ne_outer hF hb) hdisj
    rw [hP] at htp
    rcases htp with h | h | h | h
    exacts [hta (Or.inl h), hta (Or.inr h), htb (Or.inl h), htb (Or.inr h)]
  have hv' : F.GermOnQWith p (ψ - π / 3) .ccw a' a := by rw [h1, h2]; exact hv
  have hB' : F.IsRingArc p (ψ - π / 3) (ψ - π / 3 + m) a' a := by rw [h1, h2]; exact hB
  obtain ⟨ta, tback, ta', tfront, e₁, e₂, e₃, e₄, hta', hta'', hst, h1e, h2e, h3e, h4e⟩ :=
    fullSemiHub_star_parallel_T hF hN hpd hSp h4 hA hB' ha ha'
  have hcos : ∀ β ∈ coneAt τ p, 0 ≤ Real.cos (β - ψ) := fun β hβ =>
    cos_nonneg_of_mem_coneAt (y := p) (γ := ψ)
      ((hτtip.1.subset_ball hF hτtip.2.2).trans ball_subset_closedBall) hβ
  have hfull : F.IsFullSemiHub p ψ .T := ⟨⟨X, X', hch⟩, ht, hu.germOnQ, hv.germOnQ⟩
  have hCy' : F.coloursAt (ringPt p ψ) = (F.coloursAt p)ᶜ ∪ {t} := by
    rw [hCy, hcompl]
    ext d
    simp only [mem_insert_iff, mem_singleton_iff, mem_union]
    tauto
  have hsh := angleIcc_add_int_mul (ψ - π / 6) (ψ + π / 6) 1
  simp only [Int.cast_one, mul_one] at hsh
  rcases (hst.tileAt τ).mp hτtip.tileAt.1 with rfl | rfl | rfl | rfl
  · exact absurd (Or.inl (hcol hτ hta')) hta
  · -- `t_back` approaches `p` along `ψ + 180°`, where no tip does
    exfalso
    have hmem : ψ + π ∈ coneAt τ p := by
      rw [hst.cone₂]; exact Icc_subset_angleIcc _ _ ⟨by linarith, by linarith⟩
    have := hcos _ hmem
    rw [add_sub_cancel_left, Real.cos_pi] at this
    linarith
  · exact absurd (Or.inr (hcol hτ hta'')) hta
  · refine Or.inr (Or.inr ⟨h3, hfull, a, a', hu, hv', t, _, hτ, hτtip.2.1, hCy', fun h => absurd h (by decide),
      fun _ => ?_⟩)
    rw [← hsh]
    exact hst.angleIcc_subset_cone₄ (by linarith) (by linarith)

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
  cases kind
  · exact semiHub_places_O hF hN hp hS h4 hk hy
  · exact semiHub_places_T hF hN hp hS h4 hk hy

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
  have hπ := Real.pi_pos
  have hp1 : F.Covers p 1 := (closedBall_subset_closedBall one_le_two).trans hp
  have hpd : p ∈ F.dom := hp1 (mem_closedBall_self zero_le_one)
  have hpy : ringPt (ringPt p ψ) (ψ + π) = p := ringPt_ringPt_add_pi p ψ
  obtain ⟨-, hAy⟩ := crossed_four hF hN hp1 hS h4 hk hy hu hv hab hy4
  obtain ⟨ℓ, m, hℓ, hm, -, -, -, ta, tb', ta', tb, e₁, e₂, e₃, e₄, hta, -, -, htb, hst, he₁, he₂, -, he₄⟩ :=
    crossed_star_data hF hN hpd hS h4 hu hv hab
  have hpa : p ∈ closure ta := ((hst.tileAt ta).mpr (Or.inl rfl)).2
  have hpb : p ∈ closure tb := ((hst.tileAt tb).mpr (Or.inr (Or.inr (Or.inr rfl)))).2
  -- each germ of `ω(y)` at `p` lies in a tile of `p` of colour `a` or `b`, which approaches `p` along the germ's tangent
  have key : ∀ s : Side, ∃ c T, (c = a ∨ c = b) ∧ F.TileOf c T ∧ p ∈ closure T ∧
      GermIn (ringPt p ψ) (ψ + π) s (F.region c) ∧ ψ + π + s.sign * (π / 2) ∈ coneAt T p := by
    intro s
    rcases F.germ_dichotomy (p := ringPt p ψ) (θ := ψ + π) (by rw [hpy]; exact hpd) s with
      ⟨c, hc⟩ | ⟨θ₁, θ₂, c, c', hArc, hg⟩
    · obtain ⟨T, hT, hcl, hgT⟩ := exists_tileOf_of_germIn hc
      have hcy : c ∉ F.coloursAt (ringPt p ψ) := by
        obtain ⟨z, hz, hzs⟩ := GermIn.exists_mem_sphere hc
        exact not_mem_coloursAt_of_mem_sphere hF hzs hz
      have hcab : c ∈ ({a, b} : Set (Fin k)) := by rw [← hAy]; exact hcy
      have hcone := hgT.tangent_mem_coneAt
      rw [hpy] at hcone hcl
      exact ⟨c, T, hcab, hT, hcl, hc, hcone⟩
    · have hmem := mem_ringArc_of_germIn hg
      rw [hpy] at hmem
      exact absurd ⟨θ₁, θ₂, hArc.1, hmem, hArc.2.1⟩ hna
  refine ⟨?_, fun h => ?_, ?_, ?_⟩
  · -- `p` carries four colours, so it is no interior point
    rw [hpy]
    by_contra hΓ
    have hI := F.mem_interiorPts_of_notMem_Γ hpd hΓ
    have hsub : F.coloursAt p ⊆ {F.col p} := fun c hc => (F.col_eq_of_mem_closure_region hI hc).symm
    have := Set.ncard_le_ncard hsub (Set.toFinite _)
    rw [Set.ncard_singleton, h4] at this
    omega
  · exact Set.disjoint_left.mp hab (show a ∈ ({a, a'} : Set (Fin k)) from Or.inl rfl) (Or.inl h.symm)
  · -- just counter-clockwise of `p` the ring of `y` leaves along `ψ + 270°`, which is outside the cone of `t_a`
    obtain ⟨c, T, hc, hT, hpT, hg, hcone⟩ := key .ccw
    rcases hc with rfl | rfl
    · exfalso
      rw [hN.tile_eq_of_mem_closure hF hT hta hpT hpa, hst.cone₁] at hcone
      simp only [Side.sign, one_mul] at hcone
      refine add_notMem_angleIcc (a := e₁) (b := e₂) (u := ψ + π + π / 2 - e₂) (by linarith [he₂.2])
        (by linarith [he₁.1]) ?_
      rwa [add_sub_cancel]
    · exact hg
  · -- just clockwise it leaves along `ψ + 90°`, which is outside the cone of `t_b`
    obtain ⟨c, T, hc, hT, hpT, hg, hcone⟩ := key .cw
    rcases hc with rfl | rfl
    · exact hg
    · exfalso
      rw [hN.tile_eq_of_mem_closure hF hT htb hpT hpb, hst.cone₄] at hcone
      simp only [Side.sign] at hcone
      refine sub_notMem_angleIcc (a := e₄) (b := e₁ + 2 * π) (u := e₄ - (ψ + π + -1 * (π / 2)))
        (by linarith [he₄.1]) (by linarith [he₁.2]) ?_
      rwa [sub_sub_cancel]

/-- **FS116-N3-CROSS**, the step of the last clause (`plans/FS116-N3-proof.md` § 3.1 step 5; the step the blind second mind
left open, `plans/FS116-V5-verification.md` ll. 650–660): at a crossed full semi-hub `y = r(ψ)` of four colours, no germ of
`ω(y)` that runs inside `B(p, 1)` from a point `r(ω)` of `ω(p)` within `60°` of `y` lies on a (Q) arc of the ring of `y`.

The side colours of such an arc are carried at `y` and, along the germ, inside `B(p, 1)`. Neither is `a'` or `b'`: the tile
of `p` of that colour would hold `r(ω)` (the non-Siamese engine), so approach `p` only within `90°` of `ω`, and it
approaches along the star's edge `e₃`, more than `90°` away. So the sides are the ring's colours `X`, `X'`, and their cones
at `y` are disjoint (FS112-U1 at `y`: `IsRingArc.disjoint_coneAt`). But every direction at `y` into `B(p, 1)` lies in one
of the two cones — a tile of `y` of colour `a'` or `b'` there would be a tile of `p`, a tip, and `y` has none
(`crossed_no_tip`) — both cones are closed, and the ring's own germs at `y` put `ψ + 90°` in the one and `ψ + 270°` in the
other: a connected interval covered by two disjoint closed sets that both meet it. -/
theorem crossed_not_germOnQ_inside (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 2) (hS : F.SimpleOn {p})
    (h4 : (F.coloursAt p).ncard = 4) (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k}
    (hy : F.IsChangePoint p ψ X X') {a a' b b' : Fin k} (hu : F.GermOnQWith p (ψ + π / 3) .ccw a a')
    (hv : F.GermOnQWith p (ψ - π / 3) .cw b b') (hab : Disjoint ({a, a'} : Set (Fin k)) {b, b'})
    (hy4 : (F.coloursAt (ringPt p ψ)).ncard = 4) {φ ω : ℝ} {s : Side} (hω : ω ∈ Icc (ψ - π / 3) (ψ + π / 3))
    (hpt : ringPt (ringPt p ψ) φ = ringPt p ω)
    (hin : ∃ δ₀ > 0, ∀ t ∈ Ioo 0 δ₀, dist (ringPt (ringPt p ψ) (φ + s.sign * t)) p < 1) :
    ¬ F.GermOnQ (ringPt p ψ) φ s := by
  rintro ⟨θ₁, θ₂, ⟨c, c', hArc, hc, hc', -⟩, hg⟩
  have hπ := Real.pi_pos
  have hp1 : F.Covers p 1 := (closedBall_subset_closedBall one_le_two).trans hp
  have hpd : p ∈ F.dom := hp1 (mem_closedBall_self zero_le_one)
  have hyd : ringPt p ψ ∈ F.dom := hp1 (mem_closedBall.mpr (dist_ringPt p ψ).le)
  obtain ⟨hOy, -⟩ := crossed_four hF hN hp1 hS h4 hk hy hu hv hab hy4
  obtain ⟨ℓ, m, hℓ, hm, -, -, -, ta, tb', ta', tb, e₁, e₂, e₃, e₄, -, htb', hta', -, hst, -, -, he₃, -⟩ :=
    crossed_star_data hF hN hpd hS h4 hu hv hab
  have hpa' : p ∈ closure ta' := ((hst.tileAt ta').mpr (Or.inr (Or.inr (Or.inl rfl)))).2
  have hpb' : p ∈ closure tb' := ((hst.tileAt tb').mpr (Or.inr (Or.inl rfl))).2
  have h3a' : e₃ ∈ coneAt ta' p := by rw [hst.cone₃]; exact Icc_subset_angleIcc _ _ ⟨le_rfl, hst.le₃₄⟩
  have h3b' : e₃ ∈ coneAt tb' p := by rw [hst.cone₂]; exact Icc_subset_angleIcc _ _ ⟨hst.le₂₃, le_rfl⟩
  have hnotip := crossed_no_tip hF hN hpd hS h4 hu hv hab
  -- the colours of `y`: the ring's two and `a'`, `b'`
  have hCy : F.coloursAt (ringPt p ψ) = {X, X'} ∪ {a', b'} := by
    have hT : F.tipColours p (ringPt p ψ) = ∅ := by
      ext d
      simp only [mem_empty_iff_false, iff_false]
      rintro ⟨T, -, hT⟩
      exact hnotip T hT
    rw [star_coloursAt hF hp1 h4.ge hk hy, hT, empty_union, hOy, (germS_absent hF hp1 h4.ge hk hy).2]
  -- a colour `d ∈ {a', b'}` is not carried along the germ: its tile of `p` would hold `r(ω)`
  have hside : ∀ d : Fin k, ∀ td : Set ℂ, F.TileOf d td → p ∈ closure td → e₃ ∈ coneAt td p →
      ¬ GermIn (ringPt p ψ) φ s (closure (F.region d)) := by
    rintro d td htd hptd h3 ⟨δ, hδ, hsub⟩
    obtain ⟨δ₀, hδ₀, hdist⟩ := hin
    have hgerm : GermIn (ringPt p ψ) φ s (closure td) := by
      refine ⟨min δ δ₀, lt_min hδ hδ₀, ?_⟩
      rintro _ ⟨t, ⟨ht0, ht1⟩, rfl⟩
      have hlt := hdist t ⟨ht0, lt_of_lt_of_le ht1 (min_le_right _ _)⟩
      exact mem_closure_tile_of_near hF hN htd (hp1 (mem_closedBall.mpr hlt.le))
        (hsub ⟨t, ⟨ht0, lt_of_lt_of_le ht1 (min_le_left _ _)⟩, rfl⟩) hptd hlt
    have hcl := hgerm.ringPt_mem_closure
    rw [closure_closure, hpt] at hcl
    have hcos := cos_nonneg_of_mem_coneAt (y := p) (γ := ω)
      ((htd.1.subset_ball hF hcl).trans ball_subset_closedBall) h3
    have hneg : Real.cos (e₃ - ω) < 0 :=
      Real.cos_neg_of_pi_div_two_lt_of_lt (by linarith [he₃.1, hω.2]) (by linarith [he₃.2, hω.1])
    linarith
  obtain ⟨hgc, hgc'⟩ := hArc.germIn_closure hg
  have hXX : ∀ d : Fin k, d ∈ F.coloursAt (ringPt p ψ) → GermIn (ringPt p ψ) φ s (closure (F.region d)) →
      d = X ∨ d = X' := by
    intro d hd hgd
    rw [hCy] at hd
    rcases hd with hd | rfl | rfl
    · exact hd
    · exact absurd hgd (hside _ ta' hta' hpa' h3a')
    · exact absurd hgd (hside _ tb' htb' hpb' h3b')
  -- so the two sides are the ring's colours, and their cones at `y` are disjoint
  have hdisj := hArc.disjoint_coneAt hF
  have hXdisj : Disjoint (coneAt (F.region X) (ringPt p ψ)) (coneAt (F.region X') (ringPt p ψ)) := by
    rcases hXX c hc hgc with rfl | rfl <;> rcases hXX c' hc' hgc' with rfl | rfl
    · exact absurd (F.coneAt_region_nonempty hc) (Set.not_nonempty_iff_eq_empty.mpr (disjoint_self.mp hdisj))
    · exact hdisj
    · exact hdisj.symm
    · exact absurd (F.coneAt_region_nonempty hc) (Set.not_nonempty_iff_eq_empty.mpr (disjoint_self.mp hdisj))
  -- every direction at `y` into `B(p, 1)` lies in one of the two cones
  have hcover : Icc (ψ + π / 2) (ψ + 3 * π / 2) ⊆
      coneAt (F.region X) (ringPt p ψ) ∪ coneAt (F.region X') (ringPt p ψ) := by
    rw [← closure_Ioo (by linarith : ψ + π / 2 ≠ ψ + 3 * π / 2)]
    refine closure_minimal (fun β hβ => ?_) ((isClosed_coneAt _ _).union (isClosed_coneAt _ _))
    obtain ⟨d, hd⟩ := F.exists_mem_coneAt_region hyd β
    have hdy : d ∈ F.coloursAt (ringPt p ψ) := mem_closure_of_mem_coneAt hd
    have hcos : Real.cos (β - ψ) < 0 :=
      Real.cos_neg_of_pi_div_two_lt_of_lt (by linarith [hβ.1]) (by linarith [hβ.2])
    have htip : ∀ td : Set ℂ, F.TileOf d td → p ∈ closure td → False := by
      intro td htd hptd
      rw [F.coneAt_region_eq_biUnion hyd d] at hd
      obtain ⟨T, ⟨hT, hyT⟩, hβT⟩ := mem_iUnion₂.mp hd
      obtain ⟨z, hzT, hzp⟩ := inter_ball_nonempty_of_inward_cone hβT hcos
      have hTT : T = td := hN.tile_eq_of_dist_lt hF hT htd (subset_closure hzT) hptd (mem_ball.mp hzp)
      exact hnotip T ⟨hT.1, hTT ▸ hptd, hyT⟩
    rw [hCy] at hdy
    rcases hdy with (rfl | rfl) | rfl | rfl
    · exact Or.inl hd
    · exact Or.inr hd
    · exact (htip ta' hta' hpa').elim
    · exact (htip tb' htb' hpb').elim
  -- the ring's own germs at `y`: `ψ + 90°` in the cone of `X`, `ψ + 270°` in the cone of `X'`
  have hl : ψ + π / 2 ∈ coneAt (F.region X) (ringPt p ψ) := by
    have := hy.2.2.1.tangent_mem_coneAt
    simpa [Side.sign] using this
  have hr : ψ + 3 * π / 2 ∈ coneAt (F.region X') (ringPt p ψ) := by
    have := hy.2.2.2.tangent_mem_coneAt
    rw [← mem_coneAt_add_two_pi] at this
    rwa [show ψ + Side.cw.sign * (π / 2) + 2 * π = ψ + 3 * π / 2 by simp [Side.sign]; ring] at this
  obtain ⟨β, -, hβ⟩ := isPreconnected_closed_iff.mp isPreconnected_Icc _ _ (isClosed_coneAt _ _) (isClosed_coneAt _ _)
    hcover ⟨ψ + π / 2, left_mem_Icc.mpr (by linarith), hl⟩ ⟨ψ + 3 * π / 2, right_mem_Icc.mpr (by linarith), hr⟩
  exact Set.disjoint_left.mp hXdisj hβ.1 hβ.2

/-- **FS116-N3-CROSS**, reciprocity, the last clause: under the same hypotheses, with the outer pair of `y` free and the
map simple at `p` and at `y`, `p` is a semi-hub of kind O of the ring of `y`.

**Grade of the row's argument at this clause: one mind and a checking reading** — the blind second mind's verdict was a gap
here, "an arc of `ω(y)` through `v` (or `u`) inside `B(p, 1)` with `X̄` on `y`'s side and `X` beyond … is not excluded"
(`plans/FS116-V5-verification.md` ll. 650–660), closed after reading by FS112-U1 at `y`. **In the kernel the step closes**
(`crossed_not_germOnQ_inside`): the two side classes of such an arc have disjoint cones at `y`, and the directions at `y`
into `B(p, 1)` are a connected interval covered by those two closed cones, each met at an end. The proof reads neither `ho`
nor *simple* at `y` (both kept as filed).

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
  -- the freedom of the outer pair of `y` is not read (nor is *simple* at `y`); the hypotheses stay as filed
  have _ := ho
  have hπ := Real.pi_pos
  have hSp : F.SimpleOn {p} := hS.mono (by simp)
  have hp1 : F.Covers p 1 := (closedBall_subset_closedBall one_le_two).trans hp
  have hpd : p ∈ F.dom := hp1 (mem_closedBall_self zero_le_one)
  have hcy : F.Covers (ringPt p ψ) 1 := fun z hz => hp (mem_closedBall.mpr (by
    have := dist_triangle z (ringPt p ψ) p
    rw [dist_ringPt] at this
    linarith [mem_closedBall.mp hz]))
  have hpy : ringPt (ringPt p ψ) (ψ + π) = p := ringPt_ringPt_add_pi p ψ
  have hch := crossed_changePoint hF hN hp hSp h4 hk hy hu hv hab hy4 hna
  refine ⟨⟨b, a, hch⟩, ⟨?_, ?_⟩, fun ht => ?_⟩
  · -- the germ of `ω(y)` from `v = r(ψ − 60°)` toward `p`
    refine crossed_not_germOnQ_inside hF hN hp hSp h4 hk hy hu hv hab hy4 (ω := ψ - π / 3)
      ⟨le_rfl, by linarith⟩ ?_ ⟨1, one_pos, fun t ht => ?_⟩
    · have h := ringPt_sub_ringPt_plus_third p (ψ - π / 3)
      rw [sub_add_cancel] at h
      have h2 : e (ψ + π + π / 3) = e (ψ - π / 3 - π / 3) := by
        rw [show ψ + π + π / 3 = ψ - π / 3 - π / 3 + 2 * π by ring, e_add_two_pi]
      simp only [ringPt] at h ⊢
      rw [h2]
      linear_combination -h
    · have h := (dist_ringPt_shift_cmp (ringPt p ψ) (ψ + π) (-t) (by rw [abs_neg, abs_of_pos ht.1]; exact ht.2.le)).1
        (by linarith [ht.1])
      rw [hpy, dist_comm] at h
      rwa [show ψ + π + π / 3 + Side.cw.sign * t = ψ + π + π / 3 + -t by simp [Side.sign]]
  · -- the germ of `ω(y)` from `u = r(ψ + 60°)` toward `p`
    refine crossed_not_germOnQ_inside hF hN hp hSp h4 hk hy hu hv hab hy4 (ω := ψ + π / 3)
      ⟨by linarith, le_rfl⟩ ?_ ⟨1, one_pos, fun t ht => ?_⟩
    · rw [show ψ + π - π / 3 = ψ + 2 * π / 3 by ring]
      exact ringPt_ringPt_two_thirds p ψ
    · have h := (dist_ringPt_shift_cmp (ringPt p ψ) (ψ + π - π / 3 + t) (-t)
        (by rw [abs_neg, abs_of_pos ht.1]; exact ht.2.le)).1 (by linarith [ht.1])
      rw [show ψ + π - π / 3 + t + π / 3 + -t = ψ + π by ring, hpy] at h
      rwa [show ψ + π - π / 3 + Side.ccw.sign * t = ψ + π - π / 3 + t by simp [Side.sign]]
  · -- a free tip pair of `y` at `p` would give a tile of `y` holding `p`: a tip, and there is none
    obtain ⟨T, hT, -⟩ := ringGerm_inward hF hN hcy hy4.ge (by rw [hy4, ← h4]; exact hk) hch ht (ψ + π + π)
      ⟨by linarith, by linarith⟩
    rw [hpy] at hT
    exact crossed_no_tip hF hN hpd hSp h4 hu hv hab T (isTip_comm.mp hT)

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
