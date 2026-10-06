import Proofs.HadwigerNelson.Plane.RingCalculus.Star
import Mathlib.Data.ZMod.Basic

/-!
# The ring calculus: the Γ-free class is empty (FS116-V6's route), adjacent hubs

Wave 8's third module (`plans/FS131-w8-kernel-plan.md`, Stages 2 and 4; job FS131-K8).

**FS129-SR3-EMPTY-NS** (`emptyNS`, carrying FS116-Y4-EMPTY and FS116-Y4-OBST): no valid non-Siamese six-coloured fragment
on a closed disc of radius above 1 about a vertex `p` of at least four colours has a ring carrying no arc of `Γ`. Its
proof is FS116-V6's route (`plans/FS116-V6-verification.md` § 2.2), which never reads *simple*:

| step | declaration | class it is stated at | state |
|---|---|---|---|
| V6-RING (two colours absent, four tiles) | `qfree4`, `germS_absent` (`Plane/RingGerm`); `NonSiamese.tile_eq_of_mem_closure` (`…/Basic`) | landed | proved |
| V6-GERM, V6-TIP (every change point has a tip) | `germR_*` (`Plane/RingGerm`); `star_tip_nonempty` (`…/Star`) | landed; any change point with a free tip pair | proved |
| FS116-V6-HUBS (`m = 1`) | `v6_hubs` | the Γ-free class | open |
| FS116-V6-HUBS (a tile tips at most two, consecutive) | `IsTile.dist_le_one_of_mem_closure` (`Plane/Tiles`), `ringPt_sixth_dist_le_one` | any valid map; pure trigonometry | open (the trigonometry) |
| FS116-V6-ANTI | `v6_anti` | any valid map, any two antipodal ring points | proved |
| FS116-V6-HUG | `v6_hug` | the Γ-free class | open |
| FS116-V6-COUNT, the count | `v6_count` | finite combinatorics, no map | open |
| FS116-V6-COUNT, the last step | `exists_ne_mem_closure_inter_of_split` | any map, any point of the domain | open |
| the composition | `emptyNS` | the Γ-free class | open |

**The last step is not the row's.** FS116-V6-COUNT ends on the cyclic order of four sectors at `p` (*simple*), and
FS129-SR3 reads it on sectors without simplicity. Here it is a connectedness statement with no sectors and no cyclic
order: the closures of the tiles of `p` cover a small circle about `p`; if those tiles are split into two non-empty
groups, the two groups' closures are closed sets covering the connected circle, so a tile of one group and a tile of the
other share a closure point other than `p` (`exists_ne_mem_closure_inter_of_split`) — against `v6_anti`, by which a tipper
of `y_k` and a tipper of `y_(k+3)` share no closure point but `p`.

**Vacuity.** `v6_hubs` and `v6_hug` are stated over the Γ-free class, which `emptyNS` proves empty: each is a step of that
proof and carries the gate's line in its docstring, and beside `emptyNS` stands a refutation of each one's exact hypotheses
(`v6_hubs_vacuous`, `v6_hug_vacuous`), so the marker is a kernel fact whatever the scan reads. `v6_anti`, `ringPt_sixth_dist_le_one`, `v6_count` and
`exists_ne_mem_closure_inter_of_split` are stated at the classes their arguments read, none of them empty: `v6_count` has
72 configurations meeting its hypotheses (`tools/fs131_k8_count.py`, exact, with a fault that fires).

**Inhabitant of `emptyNS`'s hypotheses at a parameter the refutation leaves alive**: FS111-W-SQ9's lattice vertex at
`k = 9` — valid, non-Siamese, four colours at the vertex, its ring carrying twelve points of `Γ` and no arc
(`plans/FS116-V6-verification.md` § 2.2, control `v6-sq9`); five colours are absent there, where the refutation needs at
most two. As a Lean term it is owed (`sq9 : ArcMap 9`, wave 6's debt, inventory item 486).

**FS129-SR3-OUTERADJ** (`outerAdj`, carrying FS116-V6-ADJ) and **FS129-MR1-DOUBLETIP** (`doubleTip`) are stated for the
wider ring classes they serve, with adjacent change points whose far germs lie off (Q) arcs; their hypotheses'
satisfiability is the open (Q)-ring question of FS-124 (no held fragment has two adjacent change points of this kind).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS116-V6-ANTI, class-free -/

/-- **FS116-V6-ANTI** (any valid map; any two antipodal points of `ω(p)`): a tile with `y = r(ψ)` in its closure and a
tile with `y* = r(ψ + 180°)` in its closure have no common closure point but `p` — their closures lie in
`B̄(y, 1) ∩ B̄(y*, 1) = {p}`. So a tile tipping `y_k` and a tile tipping `y_(k+3)` share no edge at `p`. -/
theorem v6_anti (hF : F.Valid) {p : ℂ} {ψ : ℝ} {T T' : Set ℂ} (hT : F.IsTile T) (hT' : F.IsTile T')
    (hy : ringPt p ψ ∈ closure T) (hy' : ringPt p (ψ + π) ∈ closure T') : closure T ∩ closure T' ⊆ {p} := by
  rintro z ⟨hz, hz'⟩
  have h1 := mem_closedBall.mp (hT.closure_subset_closedBall hF hy hz)
  have h2 := mem_closedBall.mp (hT'.closure_subset_closedBall hF hy' hz')
  rw [dist_eq_norm] at h1 h2
  have e1 : z - ringPt p ψ = (z - p) - e ψ := by simp only [ringPt]; ring
  have e2 : z - ringPt p (ψ + π) = (z - p) + e ψ := by simp only [ringPt, e_add_pi]; ring
  rw [e1] at h1
  rw [e2] at h2
  have h4 : (e ψ).re ^ 2 + (e ψ).im ^ 2 = 1 := by rw [re_e, im_e]; exact Real.cos_sq_add_sin_sq ψ
  have hpl : ‖(z - p) - e ψ‖ ^ 2 + ‖(z - p) + e ψ‖ ^ 2 = 2 * ‖z - p‖ ^ 2 + 2 := by
    simp only [Complex.sq_norm, Complex.normSq_apply, Complex.sub_re, Complex.sub_im, Complex.add_re,
      Complex.add_im]
    linear_combination 2 * h4
  have a1 : ‖(z - p) - e ψ‖ ^ 2 ≤ 1 := by nlinarith [norm_nonneg ((z - p) - e ψ)]
  have a2 : ‖(z - p) + e ψ‖ ^ 2 ≤ 1 := by nlinarith [norm_nonneg ((z - p) + e ψ)]
  have hw0 : ‖z - p‖ ≤ 0 := by nlinarith [norm_nonneg (z - p)]
  exact mem_singleton_iff.mpr (sub_eq_zero.mp (norm_le_zero_iff.mp hw0))

/-! ## FS116-V6-HUBS -/

/-- Two points of `ω(p)` a multiple of `60°` apart are within distance `1` only when the multiple is `0` or `±1` modulo
`6` (the others are `√3` or `2` apart). With `IsTile.dist_le_one_of_mem_closure`: a tile tips at most two of the points
`r(ψ₀ + 60°k)`, and two only if consecutive (FS116-V6-HUBS, second clause; any valid map). -/
theorem ringPt_sixth_dist_le_one {p : ℂ} {ψ₀ : ℝ} {n m : ℤ}
    (h : dist (ringPt p (ψ₀ + n * (π / 3))) (ringPt p (ψ₀ + m * (π / 3))) ≤ 1) :
    ((n - m : ℤ) : ZMod 6) = 0 ∨ ((n - m : ℤ) : ZMod 6) = 1 ∨ ((n - m : ℤ) : ZMod 6) = -1 := by
  sorry

/-- **FS116-V6-HUBS**, `m = 1` (without *simple*): in a valid non-Siamese six-coloured fragment on a closed disc of radius
above 1 about a vertex `p` of at least four colours whose ring carries no arc of `Γ`, the change points of the ring are
the six points `r(ψ₀ + 60°k)`.

VACUITY DECLARED: the class is empty (`emptyNS`, FS129-SR3-EMPTY-NS); this is a step of that refutation and is consumed
nowhere else. -/
theorem v6_hubs {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hΓ : F.GammaFreeRing p) :
    ∃ ψ₀ : ℝ, ∀ ψ : ℝ, (∃ X X', F.IsChangePoint p ψ X X') ↔ ∃ n : ℤ, ψ = ψ₀ + n * (π / 3) := by
  sorry

/-! ## FS116-V6-HUG -/

/-- **FS116-V6-HUG** (without *simple*, with its own colour step V6-GERM): in the Γ-free class, no tile of `p` tips two
adjacent change points `y = r(ψ)` and `y' = r(ψ + 60°)` while being the only tip at each.

VACUITY DECLARED: the class is empty (`emptyNS`, FS129-SR3-EMPTY-NS); this is a step of that refutation. Outside the
Γ-free class the statement to use is `doubleTip`. -/
theorem v6_hug {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hΓ : F.GammaFreeRing p) {ψ : ℝ} {X X' Y Y' : Fin 6}
    (hy : F.IsChangePoint p ψ X X') (hy' : F.IsChangePoint p (ψ + π / 3) Y Y') {T : Set ℂ}
    (hT : F.IsTip p (ringPt p ψ) T) (hT' : F.IsTip p (ringPt p (ψ + π / 3)) T)
    (h1 : ∀ S, F.IsTip p (ringPt p ψ) S → S = T) (h2 : ∀ S, F.IsTip p (ringPt p (ψ + π / 3)) S → S = T) :
    False := by
  sorry

/-! ## FS116-V6-COUNT -/

/-- **FS116-V6-COUNT**, the count, as finite combinatorics: four tiles, six hubs in cyclic order; every hub has a tip; a
tile tips only hubs that are equal or consecutive; no tile tips two consecutive hubs while being the only tip at each.
Then two antipodal hubs `a`, `a + 3` have exactly two tips each, every tile tips one of them and not the other, and every
tile tips exactly two hubs (`M = 4`, `s = 2`).

Not vacuous: 72 configurations meet the hypotheses, and all satisfy the conclusion (`tools/fs131_k8_count.py`). -/
theorem v6_count (tip : Fin 4 → ZMod 6 → Prop) (hcover : ∀ a, ∃ i, tip i a)
    (hcons : ∀ i a b, tip i a → tip i b → b = a ∨ b = a + 1 ∨ b = a - 1)
    (hhug : ∀ i a, tip i a → tip i (a + 1) → (∃ j, j ≠ i ∧ tip j a) ∨ ∃ j, j ≠ i ∧ tip j (a + 1)) :
    ∃ a : ZMod 6, (∀ i, tip i a ∨ tip i (a + 3)) ∧ (∀ i, ¬ (tip i a ∧ tip i (a + 3))) ∧
      (∃ i j, i ≠ j ∧ ∀ l, tip l a ↔ l = i ∨ l = j) ∧ (∃ i j, i ≠ j ∧ ∀ l, tip l (a + 3) ↔ l = i ∨ l = j) ∧
      ∀ i, ∃ b, tip i b ∧ tip i (b + 1) := by
  sorry

/-- **FS116-V6-COUNT**, the last step, without sectors: at a point `p` of the domain, if the tiles of `p` are split into
two non-empty groups, some tile of one group and some tile of the other have a common closure point other than `p` (the
groups' closures are closed sets covering a small circle about `p`, which is connected). -/
theorem exists_ne_mem_closure_inter_of_split {p : ℂ} (hp : p ∈ F.dom) {A B : Set (Set ℂ)}
    (hAB : ∀ T, F.TileAt p T → T ∈ A ∨ T ∈ B) (hA : ∃ T ∈ A, F.TileAt p T) (hB : ∃ T ∈ B, F.TileAt p T) :
    ∃ T ∈ A, ∃ T' ∈ B, F.TileAt p T ∧ F.TileAt p T' ∧ ∃ z, z ≠ p ∧ z ∈ closure T ∩ closure T' := by
  sorry

/-! ## FS129-SR3-EMPTY-NS -/

/-- **FS129-SR3-EMPTY-NS** (carrying FS116-Y4-EMPTY and FS116-Y4-OBST): no valid non-Siamese six-coloured fragment on a
closed disc of radius above 1 about a vertex `p` of at least four colours has a ring carrying no arc of `Γ`.

A refutation. Its hypotheses hold together at nine colours on FS111-W-SQ9's lattice vertex (module docstring), where five
colours are absent; the Lean term `sq9 : ArcMap 9` is owed. -/
theorem emptyNS {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hΓ : F.GammaFreeRing p) : False := by
  sorry

/-! ## The vacuity markers, as kernel facts (ruling, inventory item 518) -/

/-- **The marker on `v6_hubs` is a fact**: its exact hypotheses are refuted — they are `emptyNS`'s. -/
theorem v6_hubs_vacuous {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hΓ : F.GammaFreeRing p) : False :=
  emptyNS hF hN hp h4 hΓ

/-- **The marker on `v6_hug` is a fact**: its exact hypotheses are refuted by the emptiness theorem alone, whatever the
change points and the tile (`v6_hug` reaches the same `False` by its own argument, which `emptyNS` consumes). -/
theorem v6_hug_vacuous {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hΓ : F.GammaFreeRing p) {ψ : ℝ} {X X' Y Y' : Fin 6}
    (_hy : F.IsChangePoint p ψ X X') (_hy' : F.IsChangePoint p (ψ + π / 3) Y Y') {T : Set ℂ}
    (_hT : F.IsTip p (ringPt p ψ) T) (_hT' : F.IsTip p (ringPt p (ψ + π / 3)) T)
    (_h1 : ∀ S, F.IsTip p (ringPt p ψ) S → S = T) (_h2 : ∀ S, F.IsTip p (ringPt p (ψ + π / 3)) S → S = T) :
    False :=
  emptyNS hF hN hp h4 hΓ

/-! ## FS129-SR3-OUTERADJ and FS129-MR1-DOUBLETIP: adjacent change points -/

/-- **FS129-SR3-OUTERADJ** (carrying FS116-V6-ADJ): in a valid non-Siamese six-coloured fragment on a closed disc of radius
above 1 about a vertex `p` of at least four colours, let `y = r(ψ)` and `y' = r(ψ + 60°)` be change points of the ring such
that neither the germ just counter-clockwise of `r(ψ − 60°)` nor the germ just clockwise of `r(ψ + 120°)` lies on a (Q)
arc. Then no colour is at once the only outer colour at `y` and the only outer colour at `y'` ("the only colour carried
at `y` by a tile that is not a tile of `p`" is read as `O_y = {c}`: the ring's own two colours are carried there by tiles
that are not tiles of `p`, and are not colours of `p`).

The hypotheses' satisfiability is open (two adjacent change points with free outer pairs: FS-124's (Q)-ring question; on a
Γ-free ring there is none, `emptyNS`). -/
theorem outerAdj {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) {ψ : ℝ} {X X' Y Y' : Fin 6} (hy : F.IsChangePoint p ψ X X')
    (hy' : F.IsChangePoint p (ψ + π / 3) Y Y') (hv : ¬ F.GermOnQ p (ψ - π / 3) .ccw)
    (hu : ¬ F.GermOnQ p (ψ + 2 * π / 3) .cw) (c : Fin 6) :
    ¬ (F.outerTileColours p (ringPt p ψ) = {c} ∧ F.outerTileColours p (ringPt p (ψ + π / 3)) = {c}) := by
  sorry

/-- **FS129-MR1-DOUBLETIP**: in a valid non-Siamese six-coloured fragment, simple on `B̄(p, 1)`, on a closed disc of radius
above 1 about a vertex `p` of at least four colours, let `y = r(ψ)` and `y' = r(ψ + 60°)` be change points of the ring
such that neither the germ just clockwise of `r(ψ − 60°)` nor the germ just counter-clockwise of `r(ψ + 120°)` lies on a
(Q) arc. Then no tile of `p` is at once the only tip at `y` and the only tip at `y'`.

The hypotheses' satisfiability is open (FS-124's (Q)-ring question; on a Γ-free ring there is none, `emptyNS`). -/
theorem doubleTip {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (hS : F.SimpleOn (closedBall p 1)) (h4 : 4 ≤ (F.coloursAt p).ncard) {ψ : ℝ} {X X' Y Y' : Fin 6}
    (hy : F.IsChangePoint p ψ X X') (hy' : F.IsChangePoint p (ψ + π / 3) Y Y')
    (hv : ¬ F.GermOnQ p (ψ - π / 3) .cw) (hu : ¬ F.GermOnQ p (ψ + 2 * π / 3) .ccw) {T : Set ℂ}
    (hT : F.IsTip p (ringPt p ψ) T) (hT' : F.IsTip p (ringPt p (ψ + π / 3)) T)
    (h1 : ∀ S, F.IsTip p (ringPt p ψ) S → S = T) (h2 : ∀ S, F.IsTip p (ringPt p (ψ + π / 3)) S → S = T) :
    False := by
  sorry

end ArcMap

end HadwigerNelson.Plane
