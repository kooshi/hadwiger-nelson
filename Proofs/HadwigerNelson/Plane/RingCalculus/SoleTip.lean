import Proofs.HadwigerNelson.Plane.RingCalculus.Star
import Proofs.HadwigerNelson.Plane.RingCalculus.TilesAt

/-!
# No tile is the only tip at two adjacent change points (FS116-V6-HUG, FS129-MR1-DOUBLETIP)

Job FS131-I8A (`plans/FS131-I8A-implementation.md`, Stage 3), for `ArcMap.v6_hug` and `ArcMap.doubleTip`
(`Plane/RingCalculus/Empty`).

`not_sole_tip_of_adjacent_changePoints`: in a valid non-Siamese map, at a vertex `p` of at least four colours with at most
two colours absent, no tile is the only tip at two change points `r(ψ)`, `r(ψ + 60°)` of the ring of `p`. **It reads no
Γ-free ring, no simplicity and nothing about the germs at `r(ψ − 60°)`, `r(ψ + 120°)`** — the three hypotheses the rows
FS116-V6-HUG (Γ-free) and FS129-MR1-DOUBLETIP (*simple*, two far germs off (Q) arcs) carry; a generalization, reported
(inventory, FS131-I8A).

The route is not FS116-V6's edge argument (no cones, no initial pieces of arcs, none of wave 3's flank lemmas):

* `Valid.dist_le_one_of_near_germ` — FS116-N1-GERM-R in pointwise form, the near side: where a germ of `ω(p)` at `r(φ)`
  lies in a colour class and is nearer than `1` to `y`, the class stays within `1` of `r(φ)` near `y` (the crossing lemma).
* `exists_ball_subset_closure_region_of_sole_tip` — beside a sole tip `T` at `y` that also has `y'` in its closure, the
  part of `B(p, 1)` outside `B̄(y', 1)` near `y` is one ring colour: a tile there of a colour of `p` is a tile of `p`
  (non-Siamese) and of `y` (`exists_ball_tileAt`), so it is `T`, which lies in `B(y', 1)`.
* So the arc of `ω(y')` from `y` toward `p`, and the arc of `ω(y)` from `y'` toward `p`, lie in the closures of tiles of one
  ring colour; FS129-SR1-TWOCIRC (`twoCirc_cmp_one`) puts points of the two arcs nearer than `1`, so the two tiles are one
  (non-Siamese); that tile holds the ring just clockwise of `y` and just counter-clockwise of `y'` — points more than `1`
  apart, against a tile's diameter.

**Inhabitants.** The lemma is a refutation. Its hypotheses short of the uniqueness of the tip — a valid non-Siamese map, a
vertex of four colours with two absent, two change points `60°` apart, one tile of `p` holding both — are not known to be
jointly satisfiable: no held fragment has two adjacent change points (`Plane/RingCalculus/Empty`'s header; the (Q)-ring
question of FS-124), and no Lean model of the class exists. The pointwise lemmas are class-free.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- A point of an open set on a unit circle is a limit of points of the set outside the closed disc. -/
theorem mem_closure_diff_closedBall {W : Set ℂ} (hW : IsOpen W) {c z : ℂ} (hzW : z ∈ W) (hz : dist z c = 1) :
    z ∈ closure (W \ closedBall c 1) := by
  rw [Metric.mem_closure_iff]
  intro ε hε
  obtain ⟨r, hr, hrW⟩ := Metric.isOpen_iff.mp hW z hzW
  have hη : 0 < min (r / 2) (ε / 2) := lt_min (by linarith) (by linarith)
  have hzc : ‖z - c‖ = 1 := by rw [← dist_eq_norm]; exact hz
  have hd : dist (z + ((min (r / 2) (ε / 2) : ℝ) : ℂ) * (z - c)) z = min (r / 2) (ε / 2) := by
    rw [dist_eq_norm, add_sub_cancel_left, norm_mul, hzc, mul_one, Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos hη]
  refine ⟨z + ((min (r / 2) (ε / 2) : ℝ) : ℂ) * (z - c), ⟨hrW ?_, ?_⟩, ?_⟩
  · rw [mem_ball, hd]; exact lt_of_le_of_lt (min_le_left _ _) (by linarith)
  · rw [mem_closedBall, not_le, dist_eq_norm,
      show z + ((min (r / 2) (ε / 2) : ℝ) : ℂ) * (z - c) - c = ((1 + min (r / 2) (ε / 2) : ℝ) : ℂ) * (z - c) by
        push_cast; ring, norm_mul, hzc, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by linarith)]
    linarith
  · rw [dist_comm, hd]; exact lt_of_le_of_lt (min_le_right _ _) (by linarith)

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- The closed initial arc of a germ lies in the closure of any set the germ lies in. -/
theorem germ_Icc_subset_closure {p : ℂ} {φ : ℝ} {s : Side} {S : Set ℂ} {δ : ℝ} (hδ : 0 < δ) (hS : germ p φ s δ ⊆ S)
    {t₁ : ℝ} (ht₁δ : t₁ < δ) : (fun t => ringPt p (φ + s.sign * t)) '' Icc 0 t₁ ⊆ closure S := by
  rintro _ ⟨t, ⟨ht0, ht1⟩, rfl⟩
  rcases ht0.eq_or_lt with rfl | hpos
  · have := closure_mono hS (ringPt_mem_closure_germ p φ s hδ)
    simpa using this
  · exact subset_closure (hS ⟨t, ⟨hpos, lt_of_le_of_lt ht1 ht₁δ⟩, rfl⟩)

/-- **FS116-N1-GERM-R, pointwise, the near side**: if the germ of `ω(p)` on side `s` of `r(φ)` lies in the class of `c`
and its points are nearer than `1` to `y`, then near `y` every closure point of the class is within `1` of `r(φ)`. -/
theorem Valid.dist_le_one_of_near_germ (hF : F.Valid) {p : ℂ} {φ : ℝ} {s : Side} {c : Fin k}
    (hg : GermIn p φ s (F.region c)) {y : ℂ}
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
  refine hF.false_of_crossing hz hS (germ_Icc_subset_closure hδ hgS ht₁δ)
    (u := ringPt p (φ + s.sign * (min δ δ₀ / 2))) (v := ringPt p φ) ⟨_, ⟨ht₁0.le, le_rfl⟩, rfl⟩
    ⟨0, ⟨le_rfl, ht₁0.le⟩, by simp⟩ ?_ hlt
  have := dist_triangle z y (ringPt p (φ + s.sign * (min δ δ₀ / 2)))
  linarith

/-- **The region beside a sole tip is one colour.** Let `T` be the only tip at `y` and let `y'` be in its closure too. If
the colours absent at `p` are `Y`, `Y'` and near `y` the class of `Y'` stays within `1` of `y'`, then near `y` every point
of `B(p, 1)` outside `B̄(y', 1)` is in the closure of the class of `Y`: a tile there of a colour of `p` would be a tile of
`p` (non-Siamese), so a tip at `y`, so `T` — which lies in `B(y', 1)`. -/
theorem exists_ball_subset_closure_region_of_sole_tip (hF : F.Valid) (hN : F.NonSiamese) {p y y' : ℂ} (hpd : p ∈ F.dom)
    (hyd : y ∈ F.dom) {T : Set ℂ} (hT : F.IsTip p y' T) (h1 : ∀ S, F.IsTip p y S → S = T) {Y Y' : Fin k}
    (hcompl : (F.coloursAt p)ᶜ = {Y, Y'})
    (hnear : ∃ ε > 0, ∀ z ∈ closure (F.region Y'), dist z y < ε → dist z y' ≤ 1) :
    ∃ ρ > 0, (ball y ρ ∩ ball p 1) \ closedBall y' 1 ⊆ closure (F.region Y) := by
  obtain ⟨ρ₁, hρ₁, hdom, hnr⟩ := exists_ball_tileAt hyd
  obtain ⟨ε, hε, hεY⟩ := hnear
  refine ⟨min ρ₁ ε, lt_min hρ₁ hε, ?_⟩
  have hUo : IsOpen ((ball y (min ρ₁ ε) ∩ ball p 1) \ closedBall y' 1) :=
    (isOpen_ball.inter isOpen_ball).sdiff isClosed_closedBall
  have hcol : ((ball y (min ρ₁ ε) ∩ ball p 1) \ closedBall y' 1) ∩ F.interiorPts ⊆ F.region Y := by
    rintro w ⟨⟨⟨hwy, hwp⟩, hwy'⟩, hwI⟩
    have hwy₁ : w ∈ ball y ρ₁ := ball_subset_ball (min_le_left _ _) hwy
    have hwyε : dist w y < ε := lt_of_lt_of_le (mem_ball.mp hwy) (min_le_right _ _)
    have hwc : w ∈ F.region (F.col w) := ⟨hwI, rfl⟩
    refine ⟨hwI, ?_⟩
    show F.col w = Y
    by_cases hc : F.col w ∈ F.coloursAt p
    · exfalso
      obtain ⟨Tc, hTc, hpTc⟩ := (F.mem_coloursAt_iff_exists_tileOf hpd).mp hc
      have hS : F.IsTile (connectedComponentIn F.interiorPts w) := ⟨w, hwI, rfl⟩
      have hwS : w ∈ connectedComponentIn F.interiorPts w := mem_connectedComponentIn hwI
      have hST : connectedComponentIn F.interiorPts w = Tc :=
        hN.tile_eq_of_dist_lt hF (hS.tileOf hwS) hTc (subset_closure hwS) hpTc (mem_ball.mp hwp)
      have hyS : y ∈ closure (connectedComponentIn F.interiorPts w) := hnr _ hS ⟨w, hwS, hwy₁⟩
      have hpS : p ∈ closure (connectedComponentIn F.interiorPts w) := by rw [hST]; exact hpTc
      have hwT : w ∈ T := h1 _ ⟨hS, hpS, hyS⟩ ▸ hwS
      exact hwy' (ball_subset_closedBall (hT.1.subset_ball hF hT.2.2 hwT))
    · have hmem : F.col w ∈ ({Y, Y'} : Set (Fin k)) := hcompl ▸ hc
      rcases hmem with h | h
      · exact h
      · exfalso
        have hwc' : w ∈ F.region Y' := by rw [← show F.col w = Y' from h]; exact hwc
        exact hwy' (mem_closedBall.mpr (hεY w (subset_closure hwc') hwyε))
  intro w hw
  have hwd : w ∈ F.dom := hdom (ball_subset_ball (min_le_left _ _) hw.1.1)
  exact closure_mono hcol (hUo.inter_closure ⟨hw, F.dense_interiorPts hwd⟩)

/-- On `ω(y')`, `y' = r(ψ + 60°)`, the point at angle `ψ − 60°` is `y = r(ψ)`. -/
theorem ringPt_ringPt_third_sub (p : ℂ) (ψ : ℝ) : ringPt (ringPt p (ψ + π / 3)) (ψ - π / 3) = ringPt p ψ := by
  have h := ringPt_sub_ringPt_plus_third p ψ
  simp only [ringPt] at h ⊢
  linear_combination -h

/-- On `ω(y')`, `y' = r(ψ + 60°)`, the point at angle `ψ − 120°` is `p`. -/
theorem ringPt_ringPt_third_sub_two (p : ℂ) (ψ : ℝ) : ringPt (ringPt p (ψ + π / 3)) (ψ - 2 * π / 3) = p := by
  have h : e (ψ + π / 3) = - e (ψ - 2 * π / 3) := by
    rw [show ψ + π / 3 = (ψ - 2 * π / 3) + π by ring, e_add_pi]
  simp only [ringPt, h]
  ring

/-- On `ω(y)`, `y = r(ψ)`, the point at angle `ψ + 120°` is `y' = r(ψ + 60°)`. -/
theorem ringPt_ringPt_two_thirds (p : ℂ) (ψ : ℝ) : ringPt (ringPt p ψ) (ψ + 2 * π / 3) = ringPt p (ψ + π / 3) := by
  have h := ringPt_sub_ringPt_plus_third p ψ
  have h2 : e (ψ + 2 * π / 3) = - e (ψ - π / 3) := by
    rw [show ψ + 2 * π / 3 = (ψ - π / 3) + π by ring, e_add_pi]
  simp only [ringPt, h2] at h ⊢
  linear_combination h

/-- **No tile is the only tip at two adjacent change points** (FS116-V6-HUG and FS129-MR1-DOUBLETIP at the class the
argument reads: valid, non-Siamese, a vertex of at least four colours with at most two colours absent; no simplicity,
no condition on the far germs, no Γ-free ring). Let `y = r(ψ)` and `y' = r(ψ + 60°)` be change points of the ring of `p`
and `T` the only tip at each. Near `y`, the part of `B(p, 1)` outside `B̄(y', 1)` is in the closure of the class of the
ring's colour `X'` (`exists_ball_subset_closure_region_of_sole_tip`), so the arc of `ω(y')` from `y` toward `p` is in the
closure of an `X'`-tile; likewise the arc of `ω(y)` from `y'` toward `p`. The two arcs have points nearer than `1`
(FS129-SR1-TWOCIRC), so the two tiles are one (non-Siamese); it holds the ring just clockwise of `y` and just
counter-clockwise of `y'`, whose points are more than `1` apart — against the diameter of a tile. -/
theorem not_sole_tip_of_adjacent_changePoints (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' Y Y' : Fin k}
    (hy : F.IsChangePoint p ψ X X') (hy' : F.IsChangePoint p (ψ + π / 3) Y Y') {T : Set ℂ}
    (hT : F.IsTip p (ringPt p ψ) T) (hT' : F.IsTip p (ringPt p (ψ + π / 3)) T)
    (h1 : ∀ S, F.IsTip p (ringPt p ψ) S → S = T) (h2 : ∀ S, F.IsTip p (ringPt p (ψ + π / 3)) S → S = T) :
    False := by
  have hπ := Real.pi_pos
  have hpd : p ∈ F.dom := hp (mem_closedBall_self zero_le_one)
  have hyd : ringPt p ψ ∈ F.dom := hp (mem_closedBall.mpr (dist_ringPt p ψ).le)
  have hy'd : ringPt p (ψ + π / 3) ∈ F.dom := hp (mem_closedBall.mpr (dist_ringPt p _).le)
  have hcX : (F.coloursAt p)ᶜ = {X, X'} := (germS_absent hF hp h4 hk hy).2
  have hcY : (F.coloursAt p)ᶜ = {Y, Y'} := (germS_absent hF hp h4 hk hy').2
  -- the ring's colours at `y'` are those at `y`, swapped
  have hYX' : X' = Y := by
    have hmem : Y ∈ ({X, X'} : Set (Fin k)) := by rw [← hcX, hcY]; exact mem_insert _ _
    rcases hmem with h | h
    · exact absurd ⟨hy.2.2.1.mono subset_closure, (h ▸ hy'.2.2.1).mono subset_closure⟩
        (not_germIn_closure_rotate hF p ψ .ccw X)
    · exact h.symm
  subst hYX'
  -- near `y`: the class of `Y'` stays within `1` of `y'`
  have hnY : ∃ ε > 0, ∀ z ∈ closure (F.region Y'), dist z (ringPt p ψ) < ε → dist z (ringPt p (ψ + π / 3)) ≤ 1 :=
    hF.dist_le_one_of_near_germ hy'.2.2.2 ⟨1, one_pos, fun t ht => by
      have := (dist_ringPt_shift_cmp p ψ (-t) (by rw [abs_neg, abs_of_pos ht.1]; exact ht.2.le)).1 (by linarith [ht.1])
      rwa [show ψ + π / 3 + -t = ψ + π / 3 + Side.cw.sign * t by simp [Side.sign]] at this⟩
  -- near `y'`: the class of `X` stays within `1` of `y`
  have hnX : ∃ ε > 0, ∀ z ∈ closure (F.region X), dist z (ringPt p (ψ + π / 3)) < ε → dist z (ringPt p ψ) ≤ 1 :=
    hF.dist_le_one_of_near_germ hy.2.2.1 ⟨1, one_pos, fun t ht => by
      have := (dist_ringPt_shift_cmp p (ψ + t) (-t) (by rw [abs_neg, abs_of_pos ht.1]; exact ht.2.le)).1
        (by linarith [ht.1])
      rw [show ψ + t + π / 3 + -t = ψ + π / 3 by ring, dist_comm] at this
      rwa [show ψ + t = ψ + Side.ccw.sign * t by simp [Side.sign]] at this⟩
  obtain ⟨ρ, hρ, hU⟩ := exists_ball_subset_closure_region_of_sole_tip hF hN hpd hyd hT' h1 hcY hnY
  obtain ⟨ρ', hρ', hU'⟩ := exists_ball_subset_closure_region_of_sole_tip hF hN hpd hy'd hT h2
    (by rw [hcX, Set.pair_comm]) hnX
  -- the two arcs
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
  -- `b`: on `ω(y')`, from `y` toward `p`
  have hby : dist (ringPt (ringPt p (ψ + π / 3)) (ψ - π / 3 - t)) (ringPt p ψ) ≤ t := by
    have := dist_ringPt_germ_le (ringPt p (ψ + π / 3)) (ψ - π / 3) .cw ht0.le
    rw [ringPt_ringPt_third_sub, dist_comm] at this
    rwa [show ψ - π / 3 + Side.cw.sign * t = ψ - π / 3 - t by simp [Side.sign]; ring] at this
  have hbp : dist (ringPt (ringPt p (ψ + π / 3)) (ψ - π / 3 - t)) p < 1 := by
    have := (dist_ringPt_shift_cmp (ringPt p (ψ + π / 3)) (ψ - 2 * π / 3) (-t)
      (by rw [abs_neg, abs_of_pos ht0]; linarith)).1 (by linarith)
    rw [ringPt_ringPt_third_sub_two, dist_comm] at this
    rwa [show ψ - 2 * π / 3 + π / 3 + -t = ψ - π / 3 - t by ring] at this
  have hbcl : ringPt (ringPt p (ψ + π / 3)) (ψ - π / 3 - t) ∈ closure (F.region X') :=
    closure_minimal hU isClosed_closure (mem_closure_diff_closedBall (isOpen_ball.inter isOpen_ball)
      ⟨mem_ball.mpr (lt_of_le_of_lt hby htρ), mem_ball.mpr hbp⟩ (dist_ringPt _ _))
  -- `a`: on `ω(y)`, from `y'` toward `p`
  have hay : dist (ringPt (ringPt p ψ) (ψ + 2 * π / 3 + s)) (ringPt p (ψ + π / 3)) ≤ s := by
    have := dist_ringPt_germ_le (ringPt p ψ) (ψ + 2 * π / 3) .ccw hs0.le
    rw [ringPt_ringPt_two_thirds, dist_comm] at this
    rwa [show ψ + 2 * π / 3 + Side.ccw.sign * s = ψ + 2 * π / 3 + s by simp [Side.sign]] at this
  have hap : dist (ringPt (ringPt p ψ) (ψ + 2 * π / 3 + s)) p < 1 := by
    have := (dist_ringPt_shift_cmp (ringPt p ψ) (ψ + 2 * π / 3 + s) (-s)
      (by rw [abs_neg, abs_of_pos hs0]; linarith)).1 (by linarith)
    rwa [show ψ + 2 * π / 3 + s + π / 3 + -s = ψ + π by ring, ringPt_ringPt_add_pi] at this
  have hacl : ringPt (ringPt p ψ) (ψ + 2 * π / 3 + s) ∈ closure (F.region X') :=
    closure_minimal hU' isClosed_closure (mem_closure_diff_closedBall (isOpen_ball.inter isOpen_ball)
      ⟨mem_ball.mpr (lt_of_le_of_lt hay hsρ), mem_ball.mpr hap⟩ (dist_ringPt _ _))
  -- the two arcs' points are nearer than `1` (TWOCIRC)
  have hab : dist (ringPt (ringPt p ψ) (ψ + 2 * π / 3 + s)) (ringPt (ringPt p (ψ + π / 3)) (ψ - π / 3 - t)) < 1 := by
    have h01 : dist (ringPt p ψ) (ringPt p (ψ + π / 3)) = 1 := by
      have := dist_ringPt_third p ψ 1 (Or.inl rfl)
      rwa [one_mul] at this
    have h := (twoCirc_cmp_one h01 (σ := 1) (Or.inl rfl) hs0 (by linarith [Real.pi_gt_three]) ht0
      (by linarith [Real.pi_gt_three])).1 (by linarith [Real.pi_gt_three])
    have e1 : ringPt p ψ + (ringPt p (ψ + π / 3) - ringPt p ψ) * e (1 * s) =
        ringPt (ringPt p ψ) (ψ + 2 * π / 3 + s) := by
      have h3 := ringPt_ringPt_two_thirds p ψ
      simp only [ringPt] at h3 ⊢
      rw [one_mul, e_add (ψ + 2 * π / 3) s]
      linear_combination (- e s) * h3
    have e2 : ringPt p (ψ + π / 3) + (ringPt p ψ - ringPt p (ψ + π / 3)) * e (-(1 * t)) =
        ringPt (ringPt p (ψ + π / 3)) (ψ - π / 3 - t) := by
      have h3 := ringPt_ringPt_third_sub p ψ
      simp only [ringPt] at h3 ⊢
      rw [one_mul, show ψ - π / 3 - t = (ψ - π / 3) + -t by ring, e_add (ψ - π / 3) (-t)]
      linear_combination (- e (-t)) * h3
    rwa [e1, e2] at h
  -- the tiles
  have hbd : ringPt (ringPt p (ψ + π / 3)) (ψ - π / 3 - t) ∈ F.dom := hp (mem_closedBall.mpr hbp.le)
  have had : ringPt (ringPt p ψ) (ψ + 2 * π / 3 + s) ∈ F.dom := hp (mem_closedBall.mpr hap.le)
  obtain ⟨Sm, hSm, hbS⟩ := (F.mem_coloursAt_iff_exists_tileOf hbd).mp hbcl
  obtain ⟨Sp, hSp, haS⟩ := (F.mem_coloursAt_iff_exists_tileOf had).mp hacl
  have hSS : Sp = Sm := hN.tile_eq_of_dist_lt hF hSp hSm haS hbS hab
  subst hSS
  -- the ring just clockwise of `y` and just counter-clockwise of `y'` lies in that tile
  obtain ⟨δ, hδ, hg⟩ := hy.2.2.2
  obtain ⟨δ', hδ', hg'⟩ := hy'.2.2.1
  have hτ0 : 0 < min δ (1 / 2) / 2 := by
    have := lt_min hδ (by norm_num : (0 : ℝ) < 1 / 2)
    linarith
  have hτδ : min δ (1 / 2) / 2 < δ := by
    have := min_le_left δ (1 / 2)
    linarith
  have hτ4 : min δ (1 / 2) / 2 ≤ 1 / 4 := by
    have := min_le_right δ (1 / 2)
    linarith
  have hτ'0 : 0 < min δ' (1 / 2) / 2 := by
    have := lt_min hδ' (by norm_num : (0 : ℝ) < 1 / 2)
    linarith
  have hτ'δ : min δ' (1 / 2) / 2 < δ' := by
    have := min_le_left δ' (1 / 2)
    linarith
  have hτ'4 : min δ' (1 / 2) / 2 ≤ 1 / 4 := by
    have := min_le_right δ' (1 / 2)
    linarith
  generalize min δ (1 / 2) / 2 = τ at hτ0 hτδ hτ4
  generalize min δ' (1 / 2) / 2 = τ' at hτ'0 hτ'δ hτ'4
  have hgm : ringPt p (ψ + Side.cw.sign * τ) ∈ F.region X' := hg ⟨τ, ⟨hτ0, hτδ⟩, rfl⟩
  have hgp : ringPt p (ψ + π / 3 + Side.ccw.sign * τ') ∈ F.region X' := hg' ⟨τ', ⟨hτ'0, hτ'δ⟩, rfl⟩
  have key : ∀ g : ℂ, g ∈ F.region X' → (∃ z ∈ closure Sp, dist g z < 1) → g ∈ Sp := by
    rintro g hgX ⟨z, hz, hgz⟩
    have hS : F.IsTile (connectedComponentIn F.interiorPts g) := ⟨g, hgX.1, rfl⟩
    have hgS : g ∈ connectedComponentIn F.interiorPts g := mem_connectedComponentIn hgX.1
    have hSX : F.TileOf X' (connectedComponentIn F.interiorPts g) := by
      have := hS.tileOf hgS
      rwa [show F.col g = X' from hgX.2] at this
    exact hN.tile_eq_of_dist_lt hF hSX hSp (subset_closure hgS) hz hgz ▸ hgS
  have hgmS : ringPt p (ψ + Side.cw.sign * τ) ∈ Sp := key _ hgm ⟨_, hbS, by
    have h1' := dist_ringPt_germ_le p ψ .cw hτ0.le
    have h2' := dist_triangle (ringPt p (ψ + Side.cw.sign * τ)) (ringPt p ψ)
      (ringPt (ringPt p (ψ + π / 3)) (ψ - π / 3 - t))
    rw [dist_comm] at h1'
    rw [dist_comm (ringPt p ψ)] at h2'
    linarith⟩
  have hgpS : ringPt p (ψ + π / 3 + Side.ccw.sign * τ') ∈ Sp := key _ hgp ⟨_, haS, by
    have h1' := dist_ringPt_germ_le p (ψ + π / 3) .ccw hτ'0.le
    have h2' := dist_triangle (ringPt p (ψ + π / 3 + Side.ccw.sign * τ')) (ringPt p (ψ + π / 3))
      (ringPt (ringPt p ψ) (ψ + 2 * π / 3 + s))
    rw [dist_comm] at h1'
    rw [dist_comm (ringPt p (ψ + π / 3))] at h2'
    linarith⟩
  have hlt := hSp.1.dist_lt_one hF _ hgmS _ hgpS
  have hgt := (dist_ringPt_shift_cmp p (ψ + Side.cw.sign * τ) (τ + τ')
    (by rw [abs_of_pos (by linarith)]; linarith)).2 (by linarith)
  rw [show ψ + Side.cw.sign * τ + π / 3 + (τ + τ') = ψ + π / 3 + Side.ccw.sign * τ' by simp [Side.sign]; ring] at hgt
  linarith

end ArcMap

end HadwigerNelson.Plane
