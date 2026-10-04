import Proofs.HadwigerNelson.Plane.ValidMap.Basic
import Proofs.HadwigerNelson.Plane.RingGerm

/-!
# The unit-arc calculus (FS-112), first rows

Wave 4's skeleton (`plans/FS131-w4-kernel-plan.md` §§ 3, 12). A unit arc `α ⊂ ω(P)` with constant sides is wave 3's
`F.IsRingArc P θ₁ θ₂ c c'` (inner colour `c`, outer `c'`, `θ₁ < θ₂`); "valid map" is `F.Valid` for any `F : ArcMap k` (only FS112-NB4P
reads six colours). The frame at a horn's vertex `v` is the foundation's: `a = e α`, `n = e (α + π/2)`, `N = v + n`, `S′ = v − n`.

* **FS112-LOCK** (`lock`); **FS112-N3-NOBOTH** (`noBoth`); **FS112-U1**, its shadow clause (`u1_shadow`; the first three clauses are
  wave 3's FS116-V5-U1).
* **FS114-L60-LE**: L60-LE (`l60_le`), L60-EQ (`l60_eq_inner`, `l60_eq_outer`, `l60_eq_corners`, `l60_eq_third`), L60-REAL (`l60Frag`,
  `l60_real`).
* **FS112-N2-BENDS** with FS112-BEND merged: N2-SIGN (`n2_sign`), N2-ENV (`n2_env_toward`, `n2_env_away`, `n2_env_near`,
  `n2_env_near_away`), the bends (`bend_toward`, `bend_away`, `bend_away_whole`).
* **FS112-ISO** (`isoFrag`, `iso`); **FS112-FLANK** (`inType_shadows_horn`, `flank_siamese_of_inType`; its third clause, the bowtie's
  witness, is `flank_incomplete_bowtie` in `Plane/ValidMap/BaseSteps`); **FS112-N2-FLANK-Q** (`flankQ_upper`, `flankQ_lower`,
  `flankQ_both`).
* **FS112-A4SIX** (`a4six`); **FS112-NB4P** (`nb4p`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- `framePt` has the `x` coordinate it is built from. -/
theorem frameX_framePt (v : ℂ) (α x y : ℝ) : frameX v α (framePt v α x y) = x := by
  have hce := conj_e_mul_e α
  unfold frameX framePt
  have : (v + ((x : ℂ) + (y : ℂ) * I) * e α - v) * starRingEnd ℂ (e α) = (x : ℂ) + (y : ℂ) * I := by
    calc _ = ((x : ℂ) + (y : ℂ) * I) * (e α * starRingEnd ℂ (e α)) := by ring
      _ = _ := by rw [hce, mul_one]
  rw [this]; simp

/-- `framePt` has the `y` coordinate it is built from. -/
theorem frameY_framePt (v : ℂ) (α x y : ℝ) : frameY v α (framePt v α x y) = y := by
  have hce := conj_e_mul_e α
  unfold frameY framePt
  have : (v + ((x : ℂ) + (y : ℂ) * I) * e α - v) * starRingEnd ℂ (e α) = (x : ℂ) + (y : ℂ) * I := by
    calc _ = ((x : ℂ) + (y : ℂ) * I) * (e α * starRingEnd ℂ (e α)) := by ring
      _ = _ := by rw [hce, mul_one]
  rw [this]; simp

/-- The height of the parabola point `(t, s t²/2)` above the arc of curvature `κ`. -/
theorem tanHeight_hornPt (κ s t : ℝ) : tanHeight κ t (s * t ^ 2 / 2) = (t ^ 2 / 2) * (s - κ - κ * s ^ 2 * t ^ 2 / 4) := by
  unfold tanHeight; ring

/-- Above a lower curvature `κ < s`, for small `t`: the sign of `tanHeight_hornPt`. -/
theorem eventually_hornPt_pos {κ s : ℝ} (h : κ < s) : ∀ᶠ t in 𝓝[>] (0 : ℝ), 0 < s - κ - κ * s ^ 2 * t ^ 2 / 4 := by
  have hc : Continuous fun t : ℝ => s - κ - κ * s ^ 2 * t ^ 2 / 4 := by fun_prop
  have := hc.tendsto 0
  simp only [ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, mul_zero, zero_div, sub_zero] at this
  exact nhdsWithin_le_nhds (this.eventually (lt_mem_nhds (by linarith)))

/-- Below a higher curvature `s < κ`, for small `t`. -/
theorem eventually_hornPt_neg {κ s : ℝ} (h : s < κ) : ∀ᶠ t in 𝓝[>] (0 : ℝ), s - κ - κ * s ^ 2 * t ^ 2 / 4 < 0 := by
  have hc : Continuous fun t : ℝ => s - κ - κ * s ^ 2 * t ^ 2 / 4 := by fun_prop
  have := hc.tendsto 0
  simp only [ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, mul_zero, zero_div, sub_zero] at this
  exact nhdsWithin_le_nhds (this.eventually (gt_mem_nhds (by linarith)))

/-- **A point of a horn at a prescribed height**: for `κ₁ < s < κ₂` there are horn points arbitrarily near the vertex on the
parabola `y = s x²/2`, which lie above every arc of curvature `m < s` and below every arc of curvature `m > s`. -/
theorem exists_mem_hornSet_aboveBelow (v : ℂ) (α : ℝ) {κ₁ κ₂ s m r : ℝ} (hr : 0 < r) (h1 : κ₁ < s) (h2 : s < κ₂)
    (hm : m ≠ s) :
    ∃ z ∈ hornSet v α κ₁ κ₂ r, (m < s → TanAbove v α m z) ∧ (s < m → TanBelow v α m z) := by
  have hc : Continuous fun t : ℝ => framePt v α t (s * t ^ 2 / 2) := by unfold framePt; fun_prop
  have hdist : ∀ᶠ t in 𝓝 (0 : ℝ), dist (framePt v α t (s * t ^ 2 / 2)) v < r := by
    have := hc.tendsto 0
    have h0 : framePt v α 0 (s * 0 ^ 2 / 2) = v := by simp [framePt]
    rw [h0] at this
    exact (Metric.tendsto_nhds.mp this) r hr
  have e1 := eventually_hornPt_pos h1
  have e2 := eventually_hornPt_neg h2
  have e3 : ∀ᶠ t in 𝓝[>] (0 : ℝ), (m < s → 0 < s - m - m * s ^ 2 * t ^ 2 / 4) ∧ (s < m → s - m - m * s ^ 2 * t ^ 2 / 4 < 0) := by
    rcases lt_or_gt_of_ne hm with hlt | hgt
    · filter_upwards [eventually_hornPt_pos hlt] with t ht
      exact ⟨fun _ => ht, fun h => absurd h (not_lt.mpr hlt.le)⟩
    · filter_upwards [eventually_hornPt_neg hgt] with t ht
      exact ⟨fun h => absurd h (not_lt.mpr hgt.le), fun _ => ht⟩
  have hall : ∀ᶠ t in 𝓝[>] (0 : ℝ), 0 < s - κ₁ - κ₁ * s ^ 2 * t ^ 2 / 4 ∧ s - κ₂ - κ₂ * s ^ 2 * t ^ 2 / 4 < 0 ∧
      ((m < s → 0 < s - m - m * s ^ 2 * t ^ 2 / 4) ∧ (s < m → s - m - m * s ^ 2 * t ^ 2 / 4 < 0)) ∧ t ∈ Ioi (0 : ℝ) ∧
      dist (framePt v α t (s * t ^ 2 / 2)) v < r := by
    filter_upwards [e1, e2, e3, eventually_mem_nhdsWithin, hdist.filter_mono nhdsWithin_le_nhds] with t a b c d e
    exact ⟨a, b, c, d, e⟩
  obtain ⟨t, ht1, ht2, ht3, ht0, hd⟩ := hall.exists
  have ht0' : 0 < t := ht0
  have hX : frameX v α (framePt v α t (s * t ^ 2 / 2)) = t := frameX_framePt v α _ _
  have hY : frameY v α (framePt v α t (s * t ^ 2 / 2)) = s * t ^ 2 / 2 := frameY_framePt v α _ _
  have hpos : 0 < t ^ 2 / 2 := by positivity
  refine ⟨framePt v α t (s * t ^ 2 / 2), ⟨hd, by rw [hX]; exact ht0', ?_, ?_⟩, ?_, ?_⟩
  · unfold TanAbove; rw [hX, hY, tanHeight_hornPt]; exact mul_pos hpos ht1
  · unfold TanBelow; rw [hX, hY, tanHeight_hornPt]; exact mul_neg_of_pos_of_neg hpos ht2
  · intro h; unfold TanAbove; rw [hX, hY, tanHeight_hornPt]; exact mul_pos hpos (ht3.1 h)
  · intro h; unfold TanBelow; rw [hX, hY, tanHeight_hornPt]; exact mul_neg_of_pos_of_neg hpos (ht3.2 h)

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **FS112-LOCK**: for `w = r(θ)` interior to a unit arc of `ω(P)`, a tile of the outer colour touches `ω(w)` only at `P`; a
tile of the inner colour only at `P` or at `P + 2e(θ)`, and a tile of the inner colour touching at `P + 2e(θ)` lies outside
`B(P, 2)`. (Class form for the touching sets: no point of either class's closure on `ω(w)` elsewhere.) -/
theorem lock (hF : F.Valid) {P : ℂ} {θ₁ θ₂ θ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c') (hθ : θ ∈ Ioo θ₁ θ₂) :
    closure (F.region c') ∩ sphere (ringPt P θ) 1 ⊆ {P} ∧
      closure (F.region c) ∩ sphere (ringPt P θ) 1 ⊆ {P, P + 2 * e θ} ∧
      ∀ T, F.TileOf c T → P + 2 * e θ ∈ closure T → Disjoint T (ball P 2) := by
  sorry

/-- **FS112-N2-BENDS**, its lemma N2-SIGN: every interior point of a side colour's class is within `< 1` of every interior
point of the arc, or farther than `1` from every one. -/
theorem n2_sign (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' d : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c') (hd : d = c ∨ d = c')
    {z : ℂ} (hz : z ∈ F.region d) :
    (∀ θ ∈ Ioo θ₁ θ₂, dist z (ringPt P θ) < 1) ∨ ∀ θ ∈ Ioo θ₁ θ₂, 1 < dist z (ringPt P θ) := by
  have hmem : ∀ θ ∈ Ioo θ₁ θ₂, ringPt P θ ∈ closure (F.region d) := by
    intro θ hθ
    obtain ⟨hin, hout⟩ := hA.2.2 θ hθ
    rcases hd with rfl | rfl
    · have : d ∈ F.innerColours P (ringPt P θ) := by rw [hin]; rfl
      exact closure_mono inter_subset_left this
    · have : d ∈ F.outerColours P (ringPt P θ) := by rw [hout]; rfl
      exact closure_mono sdiff_subset this
  have hne : ∀ θ ∈ Ioo θ₁ θ₂, dist z (ringPt P θ) ≠ 1 := fun θ hθ => ne1_region hF (hmem θ hθ) hz
  have hcont : Continuous fun θ : ℝ => dist z (ringPt P θ) := by
    unfold ringPt e; fun_prop
  by_cases h : ∀ θ ∈ Ioo θ₁ θ₂, dist z (ringPt P θ) < 1
  · exact Or.inl h
  · right
    push Not at h
    obtain ⟨a, ha, ha1⟩ := h
    have ha' : 1 < dist z (ringPt P a) := lt_of_le_of_ne ha1 (Ne.symm (hne a ha))
    intro b hb
    by_contra hb1
    rw [not_lt] at hb1
    have hb' : dist z (ringPt P b) < 1 := lt_of_le_of_ne hb1 (hne b hb)
    obtain ⟨c, hc, hc1⟩ := (isPreconnected_Ioo (a := θ₁) (b := θ₂)).intermediate_value hb ha hcont.continuousOn
      ⟨hb'.le, ha'.le⟩
    exact hne c hc hc1

/-- **FS114-L60-LE**, its first clause: a unit arc with constant sides has angular length at most `60°` (its ends lie in the
closure of the outer colour's tiles along it, a chain of diameter at most `1`). -/
theorem l60_le (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c') : θ₂ - θ₁ ≤ π / 3 := by
  sorry

/-- **FS112-N3-NOBOTH**: the centre of a both-kind unit arc, a point of the domain, carries at least four colours or a repeated
colour. (`P ∈ F.dom` is the hypothesis FS116-V5-U1's last clauses need, wave 3's finding.) -/
theorem noBoth (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} (hP : P ∈ F.dom) (hA : F.BothKind P θ₁ θ₂) :
    4 ≤ (F.coloursAt P).ncard ∨ F.HasRepeatedColour P := by
  sorry

/-! ## FS112-U1, its shadow clause -/

/-- **FS112-U1**, the shadow clause (its first three clauses are wave 3's `ringArc_cone_inner`, `ringArc_cone_outer`,
`ringArc_sideCone_inner`, `ringArc_sideCone_outer` — FS116-V5-U1's, by SR1-6.2 item 4): the outer side's first-order shadow near
`P` contains the open facing cone `(θ₁ − 90°, θ₂ + 90°)` of width `π + ℓ`. For every direction `β` of it and every `ε > 0`, the points
`P + t e(β)`, `t > 0` small, are at distance exactly `1` from a point of the outer colour's class outside `B̄(P, 1)` within `ε` of the arc
(so from the outer tile beside the arc, for `ε` small). No validity is read. -/
theorem u1_shadow {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c') {β : ℝ}
    (hβ : β ∈ Ioo (θ₁ - π / 2) (θ₂ + π / 2)) {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ t : ℝ in 𝓝[>] 0,
      P + (t : ℂ) * e β ∈ shadow ((F.region c' ∩ thickening ε (ringArc P θ₁ θ₂)) \ closedBall P 1) := by
  sorry

/-! ## FS114-L60-LE: the equality case and its fragment -/

/-- `Reul(X, Y, Z)`: the intersection of the closed unit discs about `X`, `Y`, `Z` (a Reuleaux triangle of width `1` when the three
points are pairwise `1` apart). -/
def reul (X Y Z : ℂ) : Set ℂ := closedBall X 1 ∩ closedBall Y 1 ∩ closedBall Z 1

/-- **FS114-L60-LE**, L60-EQ, the inner side: at `ℓ = 60°` every tile of the inner colour touching the open arc from inside lies in
`Reul(P, A, B)` (`A`, `B` the arc's ends). -/
theorem l60_eq_inner (hF : F.Valid) {P : ℂ} {θ₁ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ (θ₁ + π / 3) c c')
    {T : Set ℂ} (hT : F.TileOf c T) (htouch : ∃ θ ∈ Ioo θ₁ (θ₁ + π / 3), ringPt P θ ∈ closure (T ∩ ball P 1)) :
    T ⊆ reul P (ringPt P θ₁) (ringPt P (θ₁ + π / 3)) := by
  sorry

/-- **FS114-L60-LE**, L60-EQ, the outer side: at `ℓ = 60°` every tile of the outer colour touching the open arc from outside lies in
the Reuleaux cap `Reul(A, B, C) ∖ B̄(P, 1)`, `C = A + B − P`. -/
theorem l60_eq_outer (hF : F.Valid) {P : ℂ} {θ₁ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ (θ₁ + π / 3) c c')
    {T : Set ℂ} (hT : F.TileOf c' T) (htouch : ∃ θ ∈ Ioo θ₁ (θ₁ + π / 3), ringPt P θ ∈ closure (T \ closedBall P 1)) :
    T ⊆ reul (ringPt P θ₁) (ringPt P (θ₁ + π / 3)) (ringPt P θ₁ + ringPt P (θ₁ + π / 3) - P) \ closedBall P 1 := by
  sorry

/-- **FS114-L60-LE**, L60-EQ at the ends: such inner tiles approach the end `A = r(θ₁)` only within the corner cone
`[θ₁ + 90°, θ₁ + 210°]` (120°) and outer ones within `[θ₁ + 30°, θ₁ + 90°]` (60°) — together the closed half-plane facing the other end;
at `B = r(θ₁ + 60°)` the mirror cones `[θ₁ + 210°, θ₁ + 330°]` and `[θ₁ − 30°, θ₁ + 30°]`. -/
theorem l60_eq_corners (hF : F.Valid) {P : ℂ} {θ₁ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ (θ₁ + π / 3) c c') :
    (∀ T, F.TileOf c T → (∃ θ ∈ Ioo θ₁ (θ₁ + π / 3), ringPt P θ ∈ closure (T ∩ ball P 1)) →
      coneAt T (ringPt P θ₁) ⊆ angleIcc (θ₁ + π / 2) (θ₁ + 7 * π / 6) ∧
        coneAt T (ringPt P (θ₁ + π / 3)) ⊆ angleIcc (θ₁ + 7 * π / 6) (θ₁ + 11 * π / 6)) ∧
    ∀ T, F.TileOf c' T → (∃ θ ∈ Ioo θ₁ (θ₁ + π / 3), ringPt P θ ∈ closure (T \ closedBall P 1)) →
      coneAt T (ringPt P θ₁) ⊆ angleIcc (θ₁ + π / 6) (θ₁ + π / 2) ∧
        coneAt T (ringPt P (θ₁ + π / 3)) ⊆ angleIcc (θ₁ - π / 6) (θ₁ + π / 6) := by
  sorry

/-- **FS114-L60-LE**, L60-EQ, "each end is a vertex carrying a third tile": at each end some tile approaches from the open half-plane
facing away from the other end (so it is neither an inner nor an outer tile of the arc, by `l60_eq_corners`). -/
theorem l60_eq_third (hF : F.Valid) {P : ℂ} {θ₁ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ (θ₁ + π / 3) c c') :
    (∃ T, F.IsTile T ∧ ∃ β ∈ coneAt T (ringPt P θ₁), dot (e β) (ringPt P (θ₁ + π / 3) - ringPt P θ₁) < 0) ∧
      ∃ T, F.IsTile T ∧ ∃ β ∈ coneAt T (ringPt P (θ₁ + π / 3)), dot (e β) (ringPt P θ₁ - ringPt P (θ₁ + π / 3)) < 0 := by
  sorry

/-- The lens of the 60° arc `r([0, 60°])` of `ω(0)`: `L = B̄(1, 1) ∩ B̄(e 60°, 1)` (`plans/FS114-L60-audit.md` § 1.3). -/
noncomputable def l60Lens : Set ℂ := closedBall 1 1 ∩ closedBall (e (π / 3)) 1

/-- L60-REAL's domain: the interior of the lens together with the closed discs of radius `1/4` about the ends. -/
noncomputable def l60Dom : Set ℂ := interior (l60Lens ∪ closedBall 1 (1 / 4) ∪ closedBall (e (π / 3)) (1 / 4))

/-- L60-REAL's arcs: the arc itself, the lens's two sides (arcs of `ω(1)` and `ω(e 60°)` from `0` through the other end to
`C = 1 + e 60°`), and the two circles of radius `1/4` about the ends. -/
noncomputable def l60Arcs : Set Arc :=
  {.circ 0 1 0 (π / 3), .circ 1 1 (π / 3) π, .circ (e (π / 3)) 1 (4 * π / 3) (2 * π), .circ 1 (1 / 4) 0 (2 * π),
    .circ (e (π / 3)) (1 / 4) 0 (2 * π)}

/-- L60-REAL's colours (`plans/FS114-L60-audit.md` § 1.3 (iii), colours less one, renumbered): `0` on the lens inside `ω(0)`
(`Reul(0, A, B)`), `1` on the lens outside (the Reuleaux cap), `2` on the disc about `A = 1` off the lens, `3` on the disc about
`B = e 60°` off the lens. -/
noncomputable def l60Col (z : ℂ) : Fin 4 := by
  classical
  exact if z ∈ l60Lens then (if ‖z‖ < 1 then 0 else 1) else if dist z 1 < 1 / 4 then 2 else 3

/-- L60-REAL's domain is open. -/
theorem isOpen_l60Dom : IsOpen l60Dom := isOpen_interior

/-- L60-REAL's arcs are non-degenerate. -/
theorem l60Arcs_nondegenerate : ∀ a ∈ l60Arcs, a.Nondegenerate := by
  intro a ha
  simp only [l60Arcs, mem_insert_iff, mem_singleton_iff] at ha
  have hπ := pi_pos
  rcases ha with rfl | rfl | rfl | rfl | rfl <;> refine ⟨by norm_num, by linarith, by linarith⟩

/-- L60-REAL's colouring is locally constant off its arcs. -/
theorem l60Col_locallyConstant : ∀ x ∈ l60Dom, x ∉ ⋃ a ∈ l60Arcs, a.carrier → ∀ᶠ y in 𝓝 x, l60Col y = l60Col x := by
  sorry

/-- **The fragment of L60-REAL**, by formula: four colours on a neighbourhood of the closed 60° arc `r([0, 60°])` of `ω(0)`. -/
noncomputable def l60Frag : ArcMap 4 where
  dom := l60Dom
  isOpen_dom := isOpen_l60Dom
  arcs := l60Arcs
  nondegenerate := l60Arcs_nondegenerate
  locallyFinite := fun _ _ => ⟨univ, univ_mem, (((((finite_singleton _).insert _).insert _).insert _).insert _).subset fun _ ha => ha.1⟩
  col := l60Col
  locallyConstant := l60Col_locallyConstant

/-- **FS114-L60-LE**, L60-REAL: equality is realised by a valid fragment by formula on a neighbourhood of the closed arc — the arc
`r([0, 60°])` of `ω(0)` is an arc of `Γ` with constant sides (inner colour `0`, outer `1`) of `l60Frag`, which is valid and whose
domain holds a neighbourhood of the closed arc. -/
theorem l60_real : l60Frag.Valid ∧ l60Frag.IsRingArc 0 0 (π / 3) 0 1 ∧
    ∃ δ > 0, thickening δ (ringArc 0 0 (π / 3)) ⊆ l60Frag.dom := by
  sorry

/-! ## FS112-N2-BENDS: N2-ENV and the whole-arc bends (FS112-BEND merged) -/

/-- **FS112-N2-BENDS**, N2-ENV toward: for a closed arc `ᾱ = r([θ₁, θ₂])` of `ω(P)` with `0 < ℓ ≤ 60°` and every `r > 0` there is a
lens profile `ψ > 0` such that, for every toward lens point `z = P + (1 − s) e(φ)` with `φ` interior and `0 < s ≤ ψ·Δ(φ)` (`Δ` the angular
distance to the nearer end), the part of `B̄(z, 1)` not within `< 1` of some point of `ᾱ` lies in `B(P, r)`. -/
theorem n2_env_toward (P : ℂ) {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) {r : ℝ} (hr : 0 < r) :
    ∃ ψ > 0, ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ * min (φ - θ₁) (θ₂ - φ) →
      closedBall (P + (1 - s) * e φ) 1 \ ⋃ θ ∈ Icc θ₁ θ₂, ball (ringPt P θ) 1 ⊆ ball P r := by
  sorry

/-- **FS112-N2-BENDS**, N2-ENV away: the same for an away lens point `z = P + (1 + s) e(φ)`, the uncovered part lying within `r` of
the radius-2 arc `R₂(ᾱ)`. -/
theorem n2_env_away (P : ℂ) {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) {r : ℝ} (hr : 0 < r) :
    ∃ ψ > 0, ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ * min (φ - θ₁) (θ₂ - φ) →
      closedBall (P + (1 + s) * e φ) 1 \ ⋃ θ ∈ Icc θ₁ θ₂, ball (ringPt P θ) 1 ⊆ thickening r (radiusTwoArc P θ₁ θ₂) := by
  sorry

/-- **FS112-N2-BENDS**, N2-ENV's near clause, toward: for a small enough profile, every point of the lens `B̄(A, 1) ∩ B̄(B, 1)` of the
arc's ends is within `< 1` of every toward lens point. -/
theorem n2_env_near (P : ℂ) {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) :
    ∃ ψ > 0, ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ * min (φ - θ₁) (θ₂ - φ) →
      ∀ p ∈ closedBall (ringPt P θ₁) 1 ∩ closedBall (ringPt P θ₂) 1, dist p (P + (1 - s) * e φ) < 1 := by
  sorry

/-- **FS112-N2-BENDS**, N2-ENV's near clause, away: the same for the away lens off `B(P, r)`. -/
theorem n2_env_near_away (P : ℂ) {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) (hℓ : θ₂ - θ₁ ≤ π / 3) {r : ℝ} (hr : 0 < r) :
    ∃ ψ > 0, ∀ φ ∈ Ioo θ₁ θ₂, ∀ s, 0 < s → s ≤ ψ * min (φ - θ₁) (θ₂ - φ) →
      ∀ p ∈ (closedBall (ringPt P θ₁) 1 ∩ closedBall (ringPt P θ₂) 1) \ ball P r, dist p (P + (1 + s) * e φ) < 1 := by
  sorry

/-- `C₂(ᾱ)` (FS112-N2-TAN): the angles of the closed arc whose radius-2 point lies in the closure of the colour `c`'s class. -/
def r2Contacts (P : ℂ) (θ₁ θ₂ : ℝ) (c : Fin k) : Set ℝ := {θ ∈ Icc θ₁ θ₂ | P + 2 * e θ ∈ closure (F.region c)}

/-- **FS112-N2-BENDS**, the toward bend (N2-TOWARD; FS112-BEND's toward case, off the end vertices, is its special case): if the outer
colour is not carried at the centre, the whole arc, end vertices included, bends toward `P` — for every `ε > 0` there is a valid map
agreeing with `F` off the `ε`-neighbourhood of the closed arc and creating no unit arc, in which no interior point of the arc lies on an
arc of `Γ` on `ω(P)`, no colour but the outer one gains points, and the outer one only inside `B̄(P, 1)` near the arc. -/
theorem bend_toward (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hout : c' ∉ F.coloursAt P) {ε : ℝ} (hε : 0 < ε) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (thickening ε (ringArc P θ₁ θ₂)) ∧ F'.RingArcsWithin F ∧
      (∀ θ ∈ Ioo θ₁ θ₂, ¬ F'.OnRingArc P (ringPt P θ)) ∧ (∀ j, j ≠ c' → F'.region j ⊆ F.region j) ∧
      F'.region c' ⊆ F.region c' ∪ (thickening ε (ringArc P θ₁ θ₂) ∩ closedBall P 1) := by
  sorry

/-- **FS112-N2-BENDS**, the away bend with the tangent bend (N2-AWAY and N2-TAN; FS112-BEND's away case is its special case): if the
inner colour is not carried at the centre, the arc bends away from `P` everywhere but along the arcs of R2 contact — for every
`ε > 0` there is a valid map agreeing with `F` off the `ε`-neighbourhood of the closed arc and creating no unit arc, in which an
interior point of the arc still on an arc of `Γ` on `ω(P)` lies in a non-degenerate interval of `C₂(ᾱ)` ("isolated R2 contacts are cleared
by a tangent bend, and only R2 along an arc blocks"), no colour but the inner one gains points, and the inner one only outside
`B(P, 1)` near the arc. -/
theorem bend_away (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hin : c ∉ F.coloursAt P) {ε : ℝ} (hε : 0 < ε) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (thickening ε (ringArc P θ₁ θ₂)) ∧ F'.RingArcsWithin F ∧
      (∀ θ ∈ Ioo θ₁ θ₂, F'.OnRingArc P (ringPt P θ) →
        ∃ a b, a < b ∧ θ ∈ Icc a b ∧ Icc a b ⊆ F.r2Contacts P θ₁ θ₂ c) ∧
      (∀ j, j ≠ c → F'.region j ⊆ F.region j) ∧
      F'.region c ⊆ F.region c ∪ (thickening ε (ringArc P θ₁ θ₂) \ ball P 1) := by
  sorry

/-- **FS112-N2-BENDS**, the away bend as the row states it (N2-AWAY): if the inner colour is not carried at the centre and no point of
the radius-2 arc `R₂(ᾱ)` lies in the closure of its class, the whole arc bends away — no interior point of it is left on an arc of
`Γ` on `ω(P)`. -/
theorem bend_away_whole (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hin : c ∉ F.coloursAt P) (hR2 : Disjoint (radiusTwoArc P θ₁ θ₂) (closure (F.region c))) {ε : ℝ} (hε : 0 < ε) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (thickening ε (ringArc P θ₁ θ₂)) ∧ F'.RingArcsWithin F ∧
      (∀ θ ∈ Ioo θ₁ θ₂, ¬ F'.OnRingArc P (ringPt P θ)) ∧ (∀ j, j ≠ c → F'.region j ⊆ F.region j) ∧
      F'.region c ⊆ F.region c ∪ (thickening ε (ringArc P θ₁ θ₂) \ ball P 1) := by
  sorry

/-! ## FS112-ISO: an isolated R2 contact, and what it blocks -/

/-- FS112-ISO's inner-colour tile: the open sector at `q₀ = 2` (`= P + 2e(0)` for `P = 0`) of half-angle `60°` about the direction
`e(0)`, within `1/4` of `q₀` — outside `B̄(0, 2)`, with `q₀` its corner. -/
noncomputable def isoY : Set ℂ := {z | ‖z - 2‖ < 1 / 4 ∧ |(z - 2).im| < √3 * (z - 2).re}

/-- FS112-ISO's domain: a disc about the arc's middle point `1` and the sector `isoY`. -/
theorem isOpen_isoDom : IsOpen (ball (1 : ℂ) (1 / 4) ∪ isoY) := by
  refine isOpen_ball.union ?_
  have h1 : IsOpen {z : ℂ | ‖z - 2‖ < 1 / 4} := isOpen_lt (by fun_prop) continuous_const
  have h2 : IsOpen {z : ℂ | |(z - 2).im| < √3 * (z - 2).re} := isOpen_lt (by fun_prop) (by fun_prop)
  exact h1.inter h2

/-- FS112-ISO's colouring is locally constant off its arc. -/
theorem isoCol_locallyConstant : ∀ x ∈ ball (1 : ℂ) (1 / 4) ∪ isoY, x ∉ ⋃ a ∈ ({Arc.circ 0 1 (-(π / 6)) (π / 6)} : Set Arc),
    a.carrier → ∀ᶠ y in 𝓝 x, (by classical exact if ‖y‖ < 1 ∨ y ∈ isoY then (0 : Fin 2) else 1) =
      (by classical exact if ‖x‖ < 1 ∨ x ∈ isoY then (0 : Fin 2) else 1) := by
  sorry

/-- **The fragment of FS112-ISO**, by formula (`plans/FS112-NB-verification.md` § 2.3 #4): about the arc of `ω(0)` near `1`, colour `0`
inside and `1` outside; and the sector `isoY` at `q₀ = 2`, colour `0` (the inner colour). -/
noncomputable def isoFrag : ArcMap 2 where
  dom := ball 1 (1 / 4) ∪ isoY
  isOpen_dom := isOpen_isoDom
  arcs := {Arc.circ 0 1 (-(π / 6)) (π / 6)}
  nondegenerate := by
    intro a ha
    rw [mem_singleton_iff] at ha
    subst ha
    exact ⟨one_pos, by linarith [pi_pos], by linarith [pi_pos]⟩
  locallyFinite := fun _ _ => ⟨univ, univ_mem, (finite_singleton _).subset fun a ha => ha.1⟩
  col := fun y => by classical exact if ‖y‖ < 1 ∨ y ∈ isoY then 0 else 1
  locallyConstant := isoCol_locallyConstant

/-- **FS112-ISO**: isolated inner-colour contacts at `P + 2e(θ₀)` exist locally, and block a first-order away-bend. In `isoFrag`
(valid), the arc `r([−1/8, 1/8])` of `ω(0)` has constant sides (inner `0`, outer `1`) and its inner colour is not carried at the
centre (the away bend's precondition); the inner colour's tile `isoY` lies outside `B̄(0, 2)` but for its corner `2 = 0 + 2e(0)`,
which is the only radius-2 contact (`C₂ = {0}`); and every radial point `1 + s` beyond the arc's middle, `s > 0` small, is at distance
exactly `1` from the inner colour's class — so no lens of the away bend containing those points can take the inner colour. -/
theorem iso : isoFrag.Valid ∧ isoFrag.IsRingArc 0 (-(1 / 8)) (1 / 8) 0 1 ∧ (0 : Fin 2) ∉ isoFrag.coloursAt 0 ∧
    isoFrag.TileOf 0 isoY ∧ Disjoint isoY (closedBall 0 2) ∧ (2 : ℂ) ∈ closure isoY ∧
    isoFrag.r2Contacts 0 (-(1 / 8)) (1 / 8) 0 = {0} ∧
    ∀ᶠ s : ℝ in 𝓝[>] 0, ¬ isoFrag.IsClear 0 (0 + (1 + (s : ℂ)) * e 0) := by
  sorry

/-! ## FS112-FLANK: N4-FLANK at a horn bound `±1` -/

/-- **FS112-FLANK**, the band: a connected set inside `B(v, 1)` with `N` in its closure (an in-type tile at `N`) shadows every point of
a horn at `v` whose upper bound has curvature at most `1`, near `v` — at `κ₂ = 1` this is the band of the horn N4-FLANK's list of
shadows omits. No map is read. -/
theorem inType_shadows_horn (v : ℂ) {α κ₁ κ₂ : ℝ} (hκ₂ : κ₂ ≤ 1) {X : Set ℂ} (hX : IsPreconnected X)
    (hXv : X ⊆ ball v 1) (hN : v + e (α + π / 2) ∈ closure X) :
    ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ₁ κ₂ r ⊆ shadow X := by
  obtain ⟨p₀, hp₀⟩ := closure_nonempty_iff.mp ⟨_, hN⟩
  have hp₀v : dist p₀ v < 1 := hXv hp₀
  filter_upwards [Ioo_mem_nhdsGT (show 0 < 1 - dist p₀ v by linarith)] with r hr z hz
  obtain ⟨hzd, -, -, hzB⟩ := hz
  -- below `ω(N)`'s arc: farther than `1` from `N`
  have hzN : 1 < dist z (v + e (α + π / 2)) := by
    refine (tanBelow_one_iff v α z).mp ?_
    unfold TanBelow at hzB ⊢
    unfold tanHeight at hzB ⊢
    nlinarith [sq_nonneg (frameX v α z), sq_nonneg (frameY v α z)]
  have hzp₀ : dist z p₀ < 1 := by
    calc dist z p₀ ≤ dist z v + dist v p₀ := dist_triangle _ _ _
      _ < r + dist p₀ v := by rw [dist_comm v p₀]; linarith
      _ < 1 := by linarith [hr.2]
  obtain ⟨y₁, hy₁, hy₁d⟩ := Metric.mem_closure_iff.mp hN (dist z (v + e (α + π / 2)) - 1) (by linarith)
  have hzy₁ : 1 < dist z y₁ := by
    have := dist_triangle z y₁ (v + e (α + π / 2))
    rw [dist_comm y₁ _] at this
    linarith [hy₁d, dist_comm (v + e (α + π / 2)) y₁]
  have hcont : ContinuousOn (fun y => dist z y) X := by fun_prop
  obtain ⟨y, hy, hyd⟩ := hX.intermediate_value hp₀ hy₁ hcont (show (1 : ℝ) ∈ Icc (dist z p₀) (dist z y₁) from ⟨hzp₀.le, hzy₁.le⟩)
  exact ⟨y, hy, hyd⟩

/-- **FS112-FLANK**, Siamese: when a horn's upper arc lies on `ω(N)` (`κ₂ = 1`) its upper flank lies inside `B(N, 1)`, so a tile of the
flank colour inside `B(v, 1)` with `N` in its closure (in-type at `N`) is Siamese with the flank — within `< 1` of every flank point
near `v`. -/
theorem flank_siamese_of_inType (hF : F.Valid) {v : ℂ} {α κ' : ℝ} (hκ' : 1 < κ') {g : Fin k}
    (hfl : ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α 1 κ' r ⊆ F.region g) {X : Set ℂ} (hX : F.TileOf g X)
    (hXv : X ⊆ ball v 1) (hN : v + e (α + π / 2) ∈ closure X) :
    ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α 1 κ' r, ∀ x ∈ X, dist x z < 1 := by
  have _ := hκ'
  have _ := hXv
  filter_upwards [hfl] with r hr z hz x hx
  have hzg : z ∈ F.region g := hr hz
  have hzN : dist z (v + e (α + π / 2)) < 1 := (tanAbove_one_iff v α z).mp hz.2.2.1
  have hT : F.IsTile (connectedComponentIn F.interiorPts z) := ⟨z, hzg.1, rfl⟩
  have hzT : z ∈ connectedComponentIn F.interiorPts z := mem_connectedComponentIn hzg.1
  have hTg : F.TileOf g (connectedComponentIn F.interiorPts z) := by
    have := hT.tileOf hzT
    rwa [show F.col z = g from hzg.2] at this
  rcases unitNear_or_unitFar hF hTg hX with hnear | hfar
  · rw [dist_comm]; exact hnear z hzT x hx
  · exfalso
    obtain ⟨y, hy, hyd⟩ := Metric.mem_closure_iff.mp hN (1 - dist z (v + e (α + π / 2))) (by linarith)
    have h1 := hfar z hzT y hy
    have := dist_triangle z (v + e (α + π / 2)) y
    linarith

/-! ## FS112-N2-FLANK-Q: horn bounds `±1` sit on (Q) or (R2) arcs -/

/-- **FS112-N2-FLANK-Q**, the upper bound `κ₂ = 1`. Let `c` have a horn at `v` along `e α` whose upper arc lies on `ω(N)`, with flank
colour `g` above it and an out-type `c`-contact at `N` (N3-DEG's, where `int D_c(v) = ∅`), and suppose every arc of `Γ` on `ω(N)` with
constant sides is (Q) or (R2) — **N2-RED's conclusion at `N` (FS112-N2-TERM's clause 1, a wave-5 row), a named hypothesis**. Then the
horn's upper arc is an arc of `Γ` on `ω(N)` from `v` (inner colour `g`, outer `c`), and either it is (Q) and a `g`-tile inside `B(v, 1)`
has `N` in its closure (FLANK's in-type exception), or it is (R2): `g` is not carried at `N`, the radius-2 point `S′` lies in the closure
of `g`'s class, every `g`-tile at `S′` is out-type, and `g`'s class shadows the whole horn near `v` (`σ_g = κ₂`, by `f̃(1/2) = 1`). -/
theorem flankQ_upper (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ : ℝ} {c g : Fin k}
    (hH : F.IsHorn v α κ₁ 1 c) (hg : F.IsFlankAbove v α 1 g)
    (hcN : F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2)))
    (hQR : ∀ θ₁ θ₂ d d', F.IsRingArc (v + e (α + π / 2)) θ₁ θ₂ d d' →
      F.IsQArc (v + e (α + π / 2)) θ₁ θ₂ ∨ F.IsR2Arc (v + e (α + π / 2)) θ₁ θ₂) :
    ∃ θ₂, α - π / 2 < θ₂ ∧ F.IsRingArc (v + e (α + π / 2)) (α - π / 2) θ₂ g c ∧
      ((F.IsQArc (v + e (α + π / 2)) (α - π / 2) θ₂ ∧
          ∃ T, F.TileOf g T ∧ T ⊆ ball v 1 ∧ v + e (α + π / 2) ∈ closure T) ∨
        (F.IsR2Arc (v + e (α + π / 2)) (α - π / 2) θ₂ ∧ g ∉ F.coloursAt (v + e (α + π / 2)) ∧
          v - e (α + π / 2) ∈ closure (F.region g) ∧ F.OutType v g (v - e (α + π / 2)) ∧
          ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ₁ 1 r ⊆ shadow (F.region g))) := by
  sorry

/-- **FS112-N2-FLANK-Q**, the lower bound `κ₁ = −1`, the mirror: the horn's lower arc on `ω(S′)` with flank colour `h` below, an out-type
`c`-contact at `S′`, and every arc of `Γ` on `ω(S′)` with constant sides (Q) or (R2) (the same named hypothesis at `S′`): the lower arc is
an arc of `Γ` on `ω(S′)` ending at `v` (inner colour `h`, outer `c`), and either it is (Q) with an `h`-tile inside `B(v, 1)` touching
`S′`, or it is (R2) with `N` in the closure of `h`'s class, every `h`-tile at `N` out-type, and `h` shadowing the whole horn near `v`
(`f(−1/2) = −1`). -/
theorem flankQ_lower (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₂ : ℝ} {c h : Fin k}
    (hH : F.IsHorn v α (-1) κ₂ c) (hh : F.IsFlankBelow v α (-1) h)
    (hcS : F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2)))
    (hQR : ∀ θ₁ θ₂ d d', F.IsRingArc (v - e (α + π / 2)) θ₁ θ₂ d d' →
      F.IsQArc (v - e (α + π / 2)) θ₁ θ₂ ∨ F.IsR2Arc (v - e (α + π / 2)) θ₁ θ₂) :
    ∃ θ₁, θ₁ < α + π / 2 ∧ F.IsRingArc (v - e (α + π / 2)) θ₁ (α + π / 2) h c ∧
      ((F.IsQArc (v - e (α + π / 2)) θ₁ (α + π / 2) ∧
          ∃ T, F.TileOf h T ∧ T ⊆ ball v 1 ∧ v - e (α + π / 2) ∈ closure T) ∨
        (F.IsR2Arc (v - e (α + π / 2)) θ₁ (α + π / 2) ∧ h ∉ F.coloursAt (v - e (α + π / 2)) ∧
          v + e (α + π / 2) ∈ closure (F.region h) ∧ F.OutType v h (v + e (α + π / 2)) ∧
          ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α (-1) κ₂ r ⊆ shadow (F.region h))) := by
  sorry

/-- **FS112-N2-FLANK-Q**, "then both horns' upper arcs form one arc of `ω(N)` through `v`": if `c` has horns along `±a` at `v`, the one
along `+a` bounded above by `ω(N)`, one tile `T_g` of a colour `g` lies directly on the `+n` side of both horns, a `g`-tile inside
`B(v, 1)` has `N` in its closure (FLANK's exception) and a `c`-tile at `N` is out-type, then the `−a` horn's arc on the `+n` side lies on
`ω(N)` too: its bound there is `−1` in its own frame (where `n` is reversed). -/
theorem flankQ_both (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₃ κ₄ κ' κ'' : ℝ} {c g : Fin k}
    (hH : F.IsHorn v α κ₁ 1 c) (hH' : F.IsHorn v (α + π) κ₃ κ₄ c)
    (hcN : F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2)))
    {Tg : Set ℂ} (hTg : F.TileOf g Tg) (hκ' : 1 < κ') (hκ'' : κ'' < κ₃)
    (hab : ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α 1 κ' r ⊆ Tg)
    (hbe : ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v (α + π) κ'' κ₃ r ⊆ Tg)
    {X : Set ℂ} (hX : F.TileOf g X) (hXv : X ⊆ ball v 1) (hXN : v + e (α + π / 2) ∈ closure X) :
    κ₃ = -1 := by
  have _ := hH
  have _ := hXv
  have hvdom : v ∈ F.dom := hv (mem_closedBall_self zero_le_one)
  have hNdom : v + e (α + π / 2) ∈ F.dom := hv (by rw [mem_closedBall, dist_eq_norm]; simp)
  have hepi : e (α + π + π / 2) = -e (α + π / 2) := by
    rw [show α + π + π / 2 = (α + π / 2) + π by ring, e_add_pi]
  have hconvA : ∀ z, TanAbove v (α + π) (-1) z ↔ 1 < dist z (v + e (α + π / 2)) := by
    intro z; rw [tanAbove_neg_one_iff, hepi, sub_neg_eq_add]
  have hconvB : ∀ z, TanBelow v (α + π) (-1) z ↔ dist z (v + e (α + π / 2)) < 1 := by
    intro z; rw [tanBelow_neg_one_iff, hepi, sub_neg_eq_add]
  -- Step 1: the tile `T_g` lies in `B̄(N, 1)` (Siamese with `X`)
  obtain ⟨r₀, hr₀sub, hr₀pos⟩ := (hab.and eventually_mem_nhdsWithin).exists
  have hr₀ : 0 < r₀ := hr₀pos
  obtain ⟨z₀, hz₀, -, -⟩ := exists_mem_hornSet_aboveBelow v α (κ₁ := 1) (κ₂ := κ') (s := (1 + κ') / 2) (m := 1) hr₀
    (by linarith) (by linarith) (by intro h; linarith)
  have hz₀T : z₀ ∈ Tg := hr₀sub hz₀
  have hz₀N : dist z₀ (v + e (α + π / 2)) < 1 := (tanAbove_one_iff v α z₀).mp hz₀.2.2.1
  have hnear : UnitNear Tg X := by
    rcases unitNear_or_unitFar hF hTg hX with h | h
    · exact h
    · exfalso
      obtain ⟨y, hy, hyd⟩ := Metric.mem_closure_iff.mp hXN (1 - dist z₀ (v + e (α + π / 2))) (by linarith)
      have h1 := h z₀ hz₀T y hy
      have := dist_triangle z₀ (v + e (α + π / 2)) y
      linarith
  have hTgN : ∀ t ∈ Tg, dist t (v + e (α + π / 2)) ≤ 1 := by
    intro t ht
    have hsub : closure X ⊆ closedBall t 1 := by
      refine closure_minimal (fun x hx => ?_) isClosed_closedBall
      rw [mem_closedBall, dist_comm]; exact (hnear t ht x hx).le
    have := mem_closedBall.mp (hsub hXN)
    rwa [dist_comm] at this
  apply le_antisymm
  · -- κ₃ ≤ -1: the flank horn lies in `T_g ⊆ B̄(N, 1)`
    by_contra hlt
    rw [not_le] at hlt
    obtain ⟨r, hrsub, hrpos⟩ := (hbe.and eventually_mem_nhdsWithin).exists
    obtain ⟨z, hz, hzA, -⟩ := exists_mem_hornSet_aboveBelow v (α + π) (κ₁ := κ'') (κ₂ := κ₃)
      (s := (max κ'' (-1) + κ₃) / 2) (m := -1) hrpos
      (by have := le_max_left κ'' (-1); linarith [max_lt hκ'' hlt]) (by linarith [max_lt hκ'' hlt])
      (by intro h; linarith [le_max_right κ'' (-1), max_lt hκ'' hlt])
    have hzA' := hzA (by linarith [le_max_right κ'' (-1), max_lt hκ'' hlt])
    have := hTgN z (hrsub hz)
    have h2 := (hconvA z).mp hzA'
    linarith
  · -- κ₃ ≥ -1: the `c`-horn lies outside `B(N, 1)` (N-E2 against the out-type `c`-tile at `N`)
    by_contra hlt
    rw [not_le] at hlt
    obtain ⟨r, ⟨hsec, hcol⟩, hrpos⟩ := (hH'.2.and eventually_mem_nhdsWithin).exists
    obtain ⟨z, hz, -, hzB⟩ := exists_mem_hornSet_aboveBelow v (α + π) (κ₁ := κ₃) (κ₂ := κ₄)
      (s := (κ₃ + min κ₄ (-1)) / 2) (m := -1) hrpos
      (by linarith [lt_min hH'.1 hlt]) (by linarith [min_le_left κ₄ (-1), lt_min hH'.1 hlt])
      (by intro h; linarith [min_le_right κ₄ (-1), lt_min hH'.1 hlt])
    have hzB' := hzB (by linarith [min_le_right κ₄ (-1), lt_min hH'.1 hlt])
    have hzN : dist z (v + e (α + π / 2)) < 1 := (hconvB z).mp hzB'
    obtain ⟨x, hx, hSeq, hvcl⟩ := hsec
    have hSpre : IsPreconnected (hornSet v (α + π) κ₃ κ₄ r) := by
      rw [hSeq]; exact isPreconnected_connectedComponentIn
    have hSsub : hornSet v (α + π) κ₃ κ₄ r ⊆ F.interiorPts := by
      rw [hSeq]; exact (connectedComponentIn_subset _ _).trans inter_subset_left
    have hTz : F.IsTile (connectedComponentIn F.interiorPts z) := ⟨z, hSsub hz, rfl⟩
    have hzT : z ∈ connectedComponentIn F.interiorPts z := mem_connectedComponentIn (hSsub hz)
    have hTzc : F.TileOf c (connectedComponentIn F.interiorPts z) := by
      have := hTz.tileOf hzT
      rwa [show F.col z = c from hcol hz] at this
    have hST : hornSet v (α + π) κ₃ κ₄ r ⊆ connectedComponentIn F.interiorPts z :=
      hSpre.subset_connectedComponentIn hz hSsub
    have hvT : v ∈ closure (connectedComponentIn F.interiorPts z) := closure_mono hST hvcl
    obtain ⟨TN, hTN, hNT⟩ := (F.mem_coloursAt_iff_exists_tileOf hNdom).mp hcN.1.2.2
    have hout := hcN.2 TN hTN hNT
    have hnear' : UnitNear (connectedComponentIn F.interiorPts z) TN :=
      unitNear_of_mem_closure hF hTzc hTN (subset_closure hzT) hNT hzN
    obtain ⟨b, hb⟩ := hTN.1.nonempty
    have hsub : closure (connectedComponentIn F.interiorPts z) ⊆ closedBall b 1 := by
      refine closure_minimal (fun a ha => ?_) isClosed_closedBall
      rw [mem_closedBall]; exact (hnear' a ha b hb).le
    have hvb : b ∈ closedBall v 1 := by
      have := mem_closedBall.mp (hsub hvT)
      rw [mem_closedBall, dist_comm]; exact this
    exact disjoint_left.mp hout hb hvb

/-! ## FS112-A4SIX and FS112-NB4P: four-colour vertices and their rings -/

/-- **FS112-A4SIX** (C-UA-BUDGET, branch 1), at the class its argument reads: a point `v` of a valid map at which exactly two colours
are absent (a four-colour vertex, at six colours), with no covering pair `(v, y)` on its unit circle, has on that circle arcs of `Γ`
of total length at least `60°`, or at least six, one inside each of six consecutive open `60°` windows. -/
theorem a4six (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {a b : Fin k} (hab : a ≠ b)
    (habs : (F.coloursAt v)ᶜ = {a, b}) (hno : ∀ y ∈ sphere v 1, ¬ F.IsCoveringPair v y) :
    ENNReal.ofReal (π / 3) ≤ arcLength {θ | F.OnRingArc v (ringPt v θ)} ∨
      ∃ x : ℝ, ∀ j : Fin 6, ∃ θ₁ θ₂, x + (j : ℕ) * (π / 3) < θ₁ ∧ θ₁ < θ₂ ∧ θ₂ < x + ((j : ℕ) + 1) * (π / 3) ∧
        ringArc v θ₁ θ₂ ⊆ F.Γ := by
  sorry

/-- **FS112-NB4P** (NB-4 corrected): at a point `v` of exactly four colours of a valid six-coloured map, let `y₀ = r(ψ)` be a change
point of its ring (a covering pair with `v`, automatically) and `y_j = r(ψ + j·60°)` its `σ_v`-orbit. If no orbit point lies on an arc
of `Γ` on `ω(v)` (closed arcs, so ends included), and no arc of `Γ` on `ω(y_{j±1})` has `y_j` on it, contradiction. The bound on the
colours at `y_j` is not needed (not a hypothesis). -/
theorem nb4p {G : ArcMap 6} (hF : G.Valid) {v : ℂ} (hv : G.Covers v 1) (h4 : (G.coloursAt v).ncard = 4) {ψ : ℝ}
    {X X' : Fin 6} (hy : G.IsChangePoint v ψ X X')
    (hring : ∀ j : ℕ, j < 6 → ¬ G.OnRingArc v (ringPt v (ψ + j * (π / 3))))
    (hnb : ∀ j : ℕ, j < 6 →
      ¬ G.OnRingArc (ringPt v (ψ + ((j : ℝ) + 1) * (π / 3))) (ringPt v (ψ + j * (π / 3))) ∧
        ¬ G.OnRingArc (ringPt v (ψ + ((j : ℝ) - 1) * (π / 3))) (ringPt v (ψ + j * (π / 3)))) :
    False := by
  sorry

end ArcMap

end HadwigerNelson.Plane
