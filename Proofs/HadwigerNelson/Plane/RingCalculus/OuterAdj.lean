import Proofs.HadwigerNelson.Plane.RingCalculus.SoleTip
import Proofs.HadwigerNelson.Plane.RingCalculus.SemiHub

/-!
# No colour is the only outer colour at two adjacent change points (FS129-SR3-OUTERADJ, carrying FS116-V6-ADJ)

Job FS131-I8D (`plans/FS131-I8D-implementation.md`, Stage 4), for `ArcMap.outerAdj` (`Plane/RingCalculus/Empty`): the mirror,
on the outer side, of `not_sole_tip_of_adjacent_changePoints` (`Plane/RingCalculus/SoleTip`), with the two lens arcs run
outward to the mirror apex `p' = y + y' − p` (`plans/FS129-SR3-audit.md` § 3.1, in region-level form).

`not_sole_outer_of_adjacent_changePoints`: in a valid non-Siamese map, at a vertex `p` of at least four colours with at most
two colours absent, let `y = r(ψ)` and `y' = r(ψ + 60°)` be change points of the ring whose far outer germs — just
counter-clockwise of `v = r(ψ − 60°)`, just clockwise of `u' = r(ψ + 120°)` — lie on no (Q) arc. Then no colour is the only
outer colour at `y` and at `y'`. **It reads `k ≤ ncard + 2`, never six** (a generalization of the row, which is `k = 6`).

* `Valid.dist_le_one_of_near_germ_closure` — FS116-N1-GERM-R pointwise, the near side, for a germ in the *closure* of a
  class (the form a germ off (Q) arcs gives: `qcol_ccw`, `qcol_cw`).
* `exists_ball_subset_closure_of_sole_outer` — beside a sole outer colour `c` at `y`: near `y`, outside `B̄(p, 1)`, outside
  `B̄(y', 1)` (where the ring colour `X` cannot go) **and outside `B̄(v, 1)`** (where `X'` cannot go), every point is in the
  closure of the class of `c`. The third disc is needed: between the directions `−90°` and `−30°` at `y` a point is outside
  the first two discs and inside `B(v, 1)`, and the tile of `X'` may be there (the plan's § 9.4 A1 omits it).
* `one_lt_norm_e_add_e_sub_e` — the arc of `ω(y')` leaving `y` away from `p` is outside `B̄(v, 1)`, and its mirror.
* So the arc of `ω(y')` from `y` away from `p` lies in the closure of the class of `c`, and so does the arc of `ω(y)` from
  `y'` away from `p`; FS129-SR1-TWOCIRC (`twoCirc_cmp_one`, at the mirror apex) puts points of the two arcs nearer than
  `1`, so one tile of colour `c` holds `y` and `y'` (the non-Siamese engine, three times). But the outer tile at `y`
  approaches `y` along `ψ` (`ringGerm_outward`), so it leaves `B̄(y', 1)`, which no tile holding `y'` does.

**Inhabitants.** The lemma is a refutation; its hypotheses short of the shared colour are not known to be jointly
satisfiable (no held fragment has two change points `60°` apart: FS-124's (Q)-ring question), as for the sole-tip lemma.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- The squared length of `e(a) + e(b) − e(c)`. -/
theorem norm_e_add_e_sub_e_sq (a b c : ℝ) :
    ‖e a + e b - e c‖ ^ 2 = 3 + 2 * Real.cos (a - b) - 2 * Real.cos (a - c) - 2 * Real.cos (b - c) := by
  rw [Complex.sq_norm, Complex.normSq_apply]
  simp only [e_eq, Complex.add_re, Complex.sub_re, Complex.add_im, Complex.sub_im, Complex.ofReal_re, Complex.ofReal_im,
    Complex.mul_re, Complex.mul_im, Complex.I_re, Complex.I_im, mul_zero, mul_one, sub_zero, add_zero, zero_add]
  rw [Real.cos_sub, Real.cos_sub, Real.cos_sub]
  linear_combination Real.sin_sq_add_cos_sq a + Real.sin_sq_add_cos_sq b + Real.sin_sq_add_cos_sq c

/-- **The outward lens arc leaves the third disc**: three unit vectors at mutual angles `120° − t`, `120°`, `t`
(`0 < t < 180°`) have `|e(a) + e(b) − e(c)| > 1`. -/
theorem one_lt_norm_e_add_e_sub_e {a b c t : ℝ} (ht0 : 0 < t) (htπ : t < π)
    (hab : Real.cos (a - b) = Real.cos (2 * π / 3 - t)) (hac : Real.cos (a - c) = Real.cos (2 * π / 3))
    (hbc : Real.cos (b - c) = Real.cos t) : 1 < ‖e a + e b - e c‖ := by
  have hsq := norm_e_add_e_sub_e_sq a b c
  have h23 : Real.cos (2 * π / 3) = -(1 / 2) := by
    rw [show 2 * π / 3 = π - π / 3 by ring, Real.cos_pi_sub, Real.cos_pi_div_three]
  have hS : 0 < Real.sin (2 * π / 3) :=
    Real.sin_pos_of_pos_of_lt_pi (by positivity) (by linarith [Real.pi_pos])
  rw [hab, hac, hbc, Real.cos_sub, h23] at hsq
  have hst : 0 < Real.sin t := Real.sin_pos_of_pos_of_lt_pi ht0 htπ
  have hct := Real.cos_le_one t
  have hlt : (1 : ℝ) < ‖e a + e b - e c‖ ^ 2 := by
    rw [hsq]; nlinarith [mul_pos hS hst]
  by_contra hle
  push Not at hle
  nlinarith [norm_nonneg (e a + e b - e c)]

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **FS116-N1-GERM-R, pointwise, the near side, for a germ in the closure of a class**: if the germ of `ω(p)` on side `s`
of `r(φ)` lies in the closure of the class of `c` and its points are nearer than `1` to `y`, then near `y` every closure
point of the class is within `1` of `r(φ)`. (`Valid.dist_le_one_of_near_germ`, `Plane/RingCalculus/SoleTip`, is its case
of a germ in the class.) -/
theorem Valid.dist_le_one_of_near_germ_closure (hF : F.Valid) {p : ℂ} {φ : ℝ} {s : Side} {c : Fin k}
    (hg : GermIn p φ s (closure (F.region c))) {y : ℂ}
    (hnear : ∃ δ₀ > 0, ∀ t ∈ Ioo 0 δ₀, dist y (ringPt p (φ + s.sign * t)) < 1) :
    ∃ ε > 0, ∀ z ∈ closure (F.region c), dist z y < ε → dist z (ringPt p φ) ≤ 1 := by
  obtain ⟨δ, hδ, hgS⟩ := hg
  obtain ⟨δ₀, hδ₀, hn⟩ := hnear
  have ht₁0 : 0 < min δ δ₀ / 2 := by
    have := lt_min hδ hδ₀
    linarith
  have ht₁δ : min δ δ₀ / 2 < δ := by
    have := min_le_left δ δ₀
    linarith
  have ht₁δ₀ : min δ δ₀ / 2 < δ₀ := by
    have := min_le_right δ δ₀
    linarith
  have hg₁ := hn (min δ δ₀ / 2) ⟨ht₁0, ht₁δ₀⟩
  refine ⟨1 - dist y (ringPt p (φ + s.sign * (min δ δ₀ / 2))), by linarith, fun z hz hzy => ?_⟩
  by_contra hlt
  push Not at hlt
  have hS : IsPreconnected ((fun t => ringPt p (φ + s.sign * t)) '' Icc 0 (min δ δ₀ / 2)) :=
    isPreconnected_Icc.image _ (by unfold ringPt; exact (continuous_const.add (continuous_e.comp (by fun_prop))).continuousOn)
  have hsub := germ_Icc_subset_closure hδ hgS ht₁δ
  rw [closure_closure] at hsub
  refine hF.false_of_crossing hz hS hsub
    (u := ringPt p (φ + s.sign * (min δ δ₀ / 2))) (v := ringPt p φ) ⟨_, ⟨ht₁0.le, le_rfl⟩, rfl⟩
    ⟨0, ⟨le_rfl, ht₁0.le⟩, by simp⟩ ?_ hlt
  have := dist_triangle z y (ringPt p (φ + s.sign * (min δ δ₀ / 2)))
  linarith

/-- A germ in a colour class lies on no (Q) arc: the class misses `Γ`. -/
theorem not_germOnQ_of_germIn_region {p : ℂ} {θ : ℝ} {s : Side} {c : Fin k} (h : GermIn p θ s (F.region c)) :
    ¬ F.GermOnQ p θ s := by
  rintro ⟨θ₁, θ₂, ⟨c₁, c₂, hA, -⟩, hg⟩
  obtain ⟨z, ⟨⟨hzI, -⟩, hzA⟩, -⟩ := GermIn.exists_mem_sphere (h.inter hg)
  exact hzI.2 (hA.2.1 hzA).2

/-- **Beside a sole outer colour.** Let `c` be the only outer colour at `y`, the colours absent at `p` be `X`, `X'`, and
near `y` let the class of `X` stay within `1` of `y'` and the class of `X'` within `1` of `v`. Then near `y` every point
outside `B̄(p, 1)`, `B̄(v, 1)` and `B̄(y', 1)` is in the closure of the class of `c` (and the ball lies in the domain): its colour is not `X`, not `X'`, so a
colour of `p`, on a tile with `y` in its closure (`exists_ball_tileAt`) that is no tile of `p` (a tile of `p` lies in
`B(p, 1)`) — an outer tile at `y`. -/
theorem exists_ball_subset_closure_of_sole_outer (hF : F.Valid) {p y y' v : ℂ} (hyd : y ∈ F.dom) {c X X' : Fin k}
    (hcompl : (F.coloursAt p)ᶜ = {X, X'}) (hO : F.outerTileColours p y = {c})
    (hX : ∃ ε > 0, ∀ z ∈ closure (F.region X), dist z y < ε → dist z y' ≤ 1)
    (hX' : ∃ ε > 0, ∀ z ∈ closure (F.region X'), dist z y < ε → dist z v ≤ 1) :
    ∃ ρ > 0, ball y ρ ⊆ F.dom ∧
      ((ball y ρ \ closedBall p 1) \ closedBall v 1) \ closedBall y' 1 ⊆ closure (F.region c) := by
  obtain ⟨ρ₁, hρ₁, hdom, hnr⟩ := exists_ball_tileAt hyd
  obtain ⟨ε, hε, hεX⟩ := hX
  obtain ⟨ε', hε', hεX'⟩ := hX'
  refine ⟨min ρ₁ (min ε ε'), lt_min hρ₁ (lt_min hε hε'), (ball_subset_ball (min_le_left _ _)).trans hdom, ?_⟩
  have hUo : IsOpen (((ball y (min ρ₁ (min ε ε')) \ closedBall p 1) \ closedBall v 1) \ closedBall y' 1) :=
    ((isOpen_ball.sdiff isClosed_closedBall).sdiff isClosed_closedBall).sdiff isClosed_closedBall
  have hcol : (((ball y (min ρ₁ (min ε ε')) \ closedBall p 1) \ closedBall v 1) \ closedBall y' 1) ∩ F.interiorPts ⊆
      F.region c := by
    rintro w ⟨⟨⟨⟨hwy, hwp⟩, hwv⟩, hwy'⟩, hwI⟩
    have hwy₁ : w ∈ ball y ρ₁ := ball_subset_ball (min_le_left _ _) hwy
    have hwε : dist w y < ε := lt_of_lt_of_le (mem_ball.mp hwy) ((min_le_right _ _).trans (min_le_left _ _))
    have hwε' : dist w y < ε' := lt_of_lt_of_le (mem_ball.mp hwy) ((min_le_right _ _).trans (min_le_right _ _))
    have hwc : w ∈ F.region (F.col w) := ⟨hwI, rfl⟩
    refine ⟨hwI, ?_⟩
    show F.col w = c
    have hcp : F.col w ∈ F.coloursAt p := by
      by_contra hc
      have hmem : F.col w ∈ ({X, X'} : Set (Fin k)) := hcompl ▸ hc
      rcases hmem with h | h
      · exact hwy' (mem_closedBall.mpr (hεX w (subset_closure (h ▸ hwc)) hwε))
      · exact hwv (mem_closedBall.mpr (hεX' w (subset_closure (h ▸ hwc)) hwε'))
    have hS : F.IsTile (connectedComponentIn F.interiorPts w) := ⟨w, hwI, rfl⟩
    have hwS : w ∈ connectedComponentIn F.interiorPts w := mem_connectedComponentIn hwI
    have hyS : y ∈ closure (connectedComponentIn F.interiorPts w) := hnr _ hS ⟨w, hwS, hwy₁⟩
    have hpS : p ∉ closure (connectedComponentIn F.interiorPts w) := fun hpS =>
      hwp (ball_subset_closedBall (hS.subset_ball hF hpS hwS))
    have hout : F.col w ∈ F.outerTileColours p y := ⟨hcp, _, hS.tileOf hwS, hyS, hpS⟩
    rw [hO] at hout
    exact hout
  intro w hw
  have hwd : w ∈ F.dom := hdom (ball_subset_ball (min_le_left _ _) hw.1.1.1)
  exact closure_mono hcol (hUo.inter_closure ⟨hw, F.dense_interiorPts hwd⟩)

/-- **No colour is the only outer colour at two adjacent change points** (FS129-SR3-OUTERADJ at the class its argument
reads: at most two colours absent at `p`, any `k`; no simplicity). See the module docstring for the argument. -/
theorem not_sole_outer_of_adjacent_changePoints (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' Y Y' : Fin k}
    (hy : F.IsChangePoint p ψ X X') (hy' : F.IsChangePoint p (ψ + π / 3) Y Y')
    (hv : ¬ F.GermOnQ p (ψ - π / 3) .ccw) (hu : ¬ F.GermOnQ p (ψ + 2 * π / 3) .cw) (c : Fin k) :
    ¬ (F.outerTileColours p (ringPt p ψ) = {c} ∧ F.outerTileColours p (ringPt p (ψ + π / 3)) = {c}) := by
  rintro ⟨hO, hO'⟩
  have hπ := Real.pi_pos
  have hyd : ringPt p ψ ∈ F.dom := hp (mem_closedBall.mpr (dist_ringPt p ψ).le)
  have hy'd : ringPt p (ψ + π / 3) ∈ F.dom := hp (mem_closedBall.mpr (dist_ringPt p _).le)
  have hcX : (F.coloursAt p)ᶜ = {X, X'} := (germS_absent hF hp h4 hk hy).2
  have hcY : (F.coloursAt p)ᶜ = {Y, Y'} := (germS_absent hF hp h4 hk hy').2
  -- the ring's colours at `y'` are those at `y`, swapped
  have hY : Y = X' := by
    have hmem : Y ∈ ({X, X'} : Set (Fin k)) := by rw [← hcX, hcY]; exact mem_insert _ _
    rcases hmem with h | h
    · exact absurd ⟨hy.2.2.1.mono subset_closure, (h ▸ hy'.2.2.1).mono subset_closure⟩
        (not_germIn_closure_rotate hF p ψ .ccw X)
    · exact h
  have hY' : Y' = X := by
    have hmem : Y' ∈ ({X, X'} : Set (Fin k)) := by rw [← hcX, hcY]; exact mem_insert_of_mem _ rfl
    rcases hmem with h | h
    · exact h
    · exact absurd (hY.trans h.symm) hy'.2.1
  rw [hY, hY'] at hy'
  -- near `y`: the class of `X` stays within `1` of `y'`, the class of `X'` within `1` of `v`
  have hnX : ∃ ε > 0, ∀ z ∈ closure (F.region X), dist z (ringPt p ψ) < ε → dist z (ringPt p (ψ + π / 3)) ≤ 1 :=
    hF.dist_le_one_of_near_germ hy'.2.2.2 ⟨1, one_pos, fun t ht => by
      have := (dist_ringPt_shift_cmp p ψ (-t) (by rw [abs_neg, abs_of_pos ht.1]; exact ht.2.le)).1 (by linarith [ht.1])
      rwa [show ψ + π / 3 + -t = ψ + π / 3 + Side.cw.sign * t by simp [Side.sign]] at this⟩
  have hnX' : ∃ ε > 0, ∀ z ∈ closure (F.region X'), dist z (ringPt p ψ) < ε → dist z (ringPt p (ψ - π / 3)) ≤ 1 :=
    hF.dist_le_one_of_near_germ_closure (qcol_ccw hF hp h4 hk hy (Or.inr rfl) hv) ⟨1, one_pos, fun t ht => by
      have := (dist_ringPt_shift_cmp p (ψ - π / 3 + t) (-t) (by rw [abs_neg, abs_of_pos ht.1]; exact ht.2.le)).1
        (by linarith [ht.1])
      rw [show ψ - π / 3 + t + π / 3 + -t = ψ by ring, dist_comm] at this
      rwa [show ψ - π / 3 + Side.ccw.sign * t = ψ - π / 3 + t by simp [Side.sign]]⟩
  -- near `y'`: the class of `X` stays within `1` of `y`, the class of `X'` within `1` of `u' = r(ψ + 120°)`
  have hmX : ∃ ε > 0, ∀ z ∈ closure (F.region X), dist z (ringPt p (ψ + π / 3)) < ε → dist z (ringPt p ψ) ≤ 1 :=
    hF.dist_le_one_of_near_germ hy.2.2.1 ⟨1, one_pos, fun t ht => by
      have := (dist_ringPt_shift_cmp p (ψ + t) (-t) (by rw [abs_neg, abs_of_pos ht.1]; exact ht.2.le)).1
        (by linarith [ht.1])
      rw [show ψ + t + π / 3 + -t = ψ + π / 3 by ring, dist_comm] at this
      rwa [show ψ + t = ψ + Side.ccw.sign * t by simp [Side.sign]] at this⟩
  have hu' : ¬ F.GermOnQ p (ψ + π / 3 + π / 3) .cw := by
    rwa [show ψ + π / 3 + π / 3 = ψ + 2 * π / 3 by ring]
  have hmX' : ∃ ε > 0, ∀ z ∈ closure (F.region X'), dist z (ringPt p (ψ + π / 3)) < ε →
      dist z (ringPt p (ψ + π / 3 + π / 3)) ≤ 1 :=
    hF.dist_le_one_of_near_germ_closure (qcol_cw hF hp h4 hk hy' (Or.inl rfl) hu') ⟨1, one_pos, fun t ht => by
      have := (dist_ringPt_shift_cmp p (ψ + π / 3) (-t) (by rw [abs_neg, abs_of_pos ht.1]; exact ht.2.le)).1
        (by linarith [ht.1])
      rwa [show ψ + π / 3 + π / 3 + -t = ψ + π / 3 + π / 3 + Side.cw.sign * t by simp [Side.sign]] at this⟩
  obtain ⟨ρ, hρ, hdρ, hU⟩ := exists_ball_subset_closure_of_sole_outer hF hyd hcX hO hnX hnX'
  obtain ⟨ρ', hρ', hdρ', hU'⟩ := exists_ball_subset_closure_of_sole_outer hF hy'd hcX hO' hmX hmX'
  -- the two outer tiles: one tile of colour `c` at each point
  have hcO : c ∈ F.outerTileColours p (ringPt p ψ) := by rw [hO]; rfl
  have hcO' : c ∈ F.outerTileColours p (ringPt p (ψ + π / 3)) := by rw [hO']; rfl
  obtain ⟨hcp, O, hOt, hyO, -⟩ := hcO
  obtain ⟨-, O', hOt', hy'O', -⟩ := hcO'
  -- the outer tile at `y` approaches `y` along `ψ`, so it leaves `B̄(y', 1)`
  have hfree : F.OuterPairFree p ψ := ⟨not_germOnQ_of_germIn_region hy'.2.2.2, hv⟩
  obtain ⟨T, ⟨hTt, hyT, hpT, d, hdp, hTd⟩, hψT⟩ := ringGerm_outward hF hp h4 hk hy hfree ψ
    ⟨by linarith, by linarith⟩
  have hdc : d = c := by
    have hd : d ∈ F.outerTileColours p (ringPt p ψ) := ⟨hdp, T, ⟨hTt, hTd⟩, hyT, hpT⟩
    rw [hO] at hd
    exact hd
  rw [hdc] at hTd
  have hTO : T = O := hN.tile_eq_of_mem_closure hF ⟨hTt, hTd⟩ hOt hyT hyO
  obtain ⟨z, hzT, hzy'⟩ := exists_not_mem_closedBall_of_coneAt (p := ringPt p ψ) (ψ := ψ + 2 * π / 3) hψT (by
    rw [show ψ - (ψ + 2 * π / 3) = -(π - π / 3) by ring, Real.cos_neg, Real.cos_pi_sub, Real.cos_pi_div_three]
    norm_num)
  rw [ringPt_ringPt_two_thirds] at hzy'
  -- the arcs: `t`, `s` small
  have ht0 : 0 < min ρ (1 / 2) / 2 := by
    have := lt_min hρ (by norm_num : (0 : ℝ) < 1 / 2)
    linarith
  have htρ : min ρ (1 / 2) / 2 < ρ := by
    have := min_le_left ρ (1 / 2)
    linarith
  have ht4 : min ρ (1 / 2) / 2 ≤ 1 / 4 := by
    have := min_le_right ρ (1 / 2)
    linarith
  have hs0 : 0 < min ρ' (1 / 2) / 2 := by
    have := lt_min hρ' (by norm_num : (0 : ℝ) < 1 / 2)
    linarith
  have hsρ : min ρ' (1 / 2) / 2 < ρ' := by
    have := min_le_left ρ' (1 / 2)
    linarith
  have hs4 : min ρ' (1 / 2) / 2 ≤ 1 / 4 := by
    have := min_le_right ρ' (1 / 2)
    linarith
  generalize min ρ (1 / 2) / 2 = t at ht0 htρ ht4
  generalize min ρ' (1 / 2) / 2 = s at hs0 hsρ hs4
  -- `b`: on `ω(y')`, from `y` away from `p`
  have hby : dist (ringPt (ringPt p (ψ + π / 3)) (ψ - π / 3 + t)) (ringPt p ψ) ≤ t := by
    have := dist_ringPt_germ_le (ringPt p (ψ + π / 3)) (ψ - π / 3) .ccw ht0.le
    rw [ringPt_ringPt_third_sub, dist_comm] at this
    rwa [show ψ - π / 3 + Side.ccw.sign * t = ψ - π / 3 + t by simp [Side.sign]] at this
  have hbp : 1 < dist (ringPt (ringPt p (ψ + π / 3)) (ψ - π / 3 + t)) p := by
    have := (dist_ringPt_shift_cmp (ringPt p (ψ + π / 3)) (ψ - 2 * π / 3) t
      (by rw [abs_of_pos ht0]; linarith)).2 ht0
    rw [ringPt_ringPt_third_sub_two, dist_comm] at this
    rwa [show ψ - 2 * π / 3 + π / 3 + t = ψ - π / 3 + t by ring] at this
  have hbv : 1 < dist (ringPt (ringPt p (ψ + π / 3)) (ψ - π / 3 + t)) (ringPt p (ψ - π / 3)) := by
    have h := one_lt_norm_e_add_e_sub_e (a := ψ + π / 3) (b := ψ - π / 3 + t) (c := ψ - π / 3) ht0
      (by linarith [Real.pi_gt_three]) (by congr 1; ring) (by congr 1; ring) (by congr 1; ring)
    rw [dist_eq_norm]
    simp only [ringPt]
    rwa [show p + e (ψ + π / 3) + e (ψ - π / 3 + t) - (p + e (ψ - π / 3)) =
      e (ψ + π / 3) + e (ψ - π / 3 + t) - e (ψ - π / 3) by ring]
  have hbcl : ringPt (ringPt p (ψ + π / 3)) (ψ - π / 3 + t) ∈ closure (F.region c) :=
    closure_minimal hU isClosed_closure (mem_closure_diff_closedBall
      ((isOpen_ball.sdiff isClosed_closedBall).sdiff isClosed_closedBall)
      ⟨⟨mem_ball.mpr (lt_of_le_of_lt hby htρ), fun h => absurd (mem_closedBall.mp h) (not_le.mpr hbp)⟩,
        fun h => absurd (mem_closedBall.mp h) (not_le.mpr hbv)⟩ (dist_ringPt _ _))
  -- `a`: on `ω(y)`, from `y'` away from `p`
  have hay : dist (ringPt (ringPt p ψ) (ψ + 2 * π / 3 - s)) (ringPt p (ψ + π / 3)) ≤ s := by
    have := dist_ringPt_germ_le (ringPt p ψ) (ψ + 2 * π / 3) .cw hs0.le
    rw [ringPt_ringPt_two_thirds, dist_comm] at this
    rwa [show ψ + 2 * π / 3 + Side.cw.sign * s = ψ + 2 * π / 3 - s by simp [Side.sign]; ring] at this
  have hap : 1 < dist (ringPt (ringPt p ψ) (ψ + 2 * π / 3 - s)) p := by
    have := (dist_ringPt_shift_cmp (ringPt p ψ) (ψ + 2 * π / 3 - s) s (by rw [abs_of_pos hs0]; linarith)).2 hs0
    rwa [show ψ + 2 * π / 3 - s + π / 3 + s = ψ + π by ring, ringPt_ringPt_add_pi] at this
  have hau : 1 < dist (ringPt (ringPt p ψ) (ψ + 2 * π / 3 - s)) (ringPt p (ψ + π / 3 + π / 3)) := by
    have h := one_lt_norm_e_add_e_sub_e (a := ψ) (b := ψ + 2 * π / 3 - s) (c := ψ + π / 3 + π / 3) hs0
      (by linarith [Real.pi_gt_three])
      (by rw [show ψ - (ψ + 2 * π / 3 - s) = -(2 * π / 3 - s) by ring, Real.cos_neg])
      (by rw [show ψ - (ψ + π / 3 + π / 3) = -(2 * π / 3) by ring, Real.cos_neg])
      (by rw [show ψ + 2 * π / 3 - s - (ψ + π / 3 + π / 3) = -s by ring, Real.cos_neg])
    rw [dist_eq_norm]
    simp only [ringPt]
    rwa [show p + e ψ + e (ψ + 2 * π / 3 - s) - (p + e (ψ + π / 3 + π / 3)) =
      e ψ + e (ψ + 2 * π / 3 - s) - e (ψ + π / 3 + π / 3) by ring]
  have hacl : ringPt (ringPt p ψ) (ψ + 2 * π / 3 - s) ∈ closure (F.region c) :=
    closure_minimal hU' isClosed_closure (mem_closure_diff_closedBall
      ((isOpen_ball.sdiff isClosed_closedBall).sdiff isClosed_closedBall)
      ⟨⟨mem_ball.mpr (lt_of_le_of_lt hay hsρ), fun h => absurd (mem_closedBall.mp h) (not_le.mpr hap)⟩,
        fun h => absurd (mem_closedBall.mp h) (not_le.mpr hau)⟩ (dist_ringPt _ _))
  -- the two arcs' points are nearer than `1` (TWOCIRC at the mirror apex)
  have hab : dist (ringPt (ringPt p ψ) (ψ + 2 * π / 3 - s)) (ringPt (ringPt p (ψ + π / 3)) (ψ - π / 3 + t)) < 1 := by
    have h01 : dist (ringPt p ψ) (ringPt p (ψ + π / 3)) = 1 := by
      have := dist_ringPt_third p ψ 1 (Or.inl rfl)
      rwa [one_mul] at this
    have h := (twoCirc_cmp_one h01 (σ := -1) (Or.inr rfl) hs0 (by linarith [Real.pi_gt_three]) ht0
      (by linarith [Real.pi_gt_three])).1 (by linarith [Real.pi_gt_three])
    have e1 : ringPt p ψ + (ringPt p (ψ + π / 3) - ringPt p ψ) * e (-1 * s) =
        ringPt (ringPt p ψ) (ψ + 2 * π / 3 - s) := by
      have h3 := ringPt_ringPt_two_thirds p ψ
      simp only [ringPt] at h3 ⊢
      rw [show ψ + 2 * π / 3 - s = (ψ + 2 * π / 3) + -1 * s by ring, e_add (ψ + 2 * π / 3) (-1 * s)]
      linear_combination (- e (-1 * s)) * h3
    have e2 : ringPt p (ψ + π / 3) + (ringPt p ψ - ringPt p (ψ + π / 3)) * e (-(-1 * t)) =
        ringPt (ringPt p (ψ + π / 3)) (ψ - π / 3 + t) := by
      have h3 := ringPt_ringPt_third_sub p ψ
      simp only [ringPt] at h3 ⊢
      rw [show ψ - π / 3 + t = (ψ - π / 3) + -(-1 * t) by ring, e_add (ψ - π / 3) (-(-1 * t))]
      linear_combination (- e (-(-1 * t))) * h3
    rwa [e1, e2] at h
  -- one tile of colour `c` holds both arcs' points; it is the outer tile at `y` and the outer tile at `y'`
  obtain ⟨Sm, hSm, hbS⟩ := (F.mem_coloursAt_iff_exists_tileOf (hdρ (mem_ball.mpr (lt_of_le_of_lt hby htρ)))).mp hbcl
  obtain ⟨Sp, hSp, haS⟩ := (F.mem_coloursAt_iff_exists_tileOf (hdρ' (mem_ball.mpr (lt_of_le_of_lt hay hsρ)))).mp hacl
  have hSS : Sp = Sm := hN.tile_eq_of_dist_lt hF hSp hSm haS hbS hab
  have hSO : Sm = O := hN.tile_eq_of_dist_lt hF hSm hOt hbS hyO (lt_of_le_of_lt hby (by linarith))
  have hSO' : Sp = O' := hN.tile_eq_of_dist_lt hF hSp hOt' haS hy'O' (lt_of_le_of_lt hay (by linarith))
  -- so the outer tile at `y` holds `y'`, and lies in `B(y', 1)`
  have hzO' : z ∈ O' := by rw [← hSO', hSS, hSO, ← hTO]; exact hzT
  exact hzy' (ball_subset_closedBall (hOt'.1.subset_ball hF hy'O' hzO'))

end ArcMap

end HadwigerNelson.Plane
