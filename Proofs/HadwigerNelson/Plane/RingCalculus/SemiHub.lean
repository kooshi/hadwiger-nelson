import Proofs.HadwigerNelson.Plane.RingCalculus.Star
import Proofs.HadwigerNelson.Plane.RingCalculus.StarChart
import Proofs.HadwigerNelson.Plane.ValidMap.HexRing
import Proofs.HadwigerNelson.Plane.Woodall.Basic

/-!
# The ring calculus: semi-hubs — the words, the germs' colours, the cone lemmas at the rhombus, the pinned stars

Wave 8's second planning pass (`plans/FS131-w8-kernel-plan.md`, Stages 6–10; job FS131-K8b): the nine semi-hub rows, stated
at the classes their arguments read (`plans/FS116-N3-proof.md` §§ 2–3, `plans/FS116-V5-verification.md` § 3). This module
holds the definitions and six of the rows; FS116-N3-SEMI, FS116-N3-CROSS and FS116-RING-TRANSFER-QC are in
`Plane/RingCalculus/SemiHubPlaces`, which imports it (two files, so that two implementers share none).

**The three words the rows use and the foundation did not define.**
* *An edge of `p` between two tiles, leaving along `δ`* (`IsEdgeDir p T T' δ`): two distinct tiles of `p` both approach `p`
  along `δ`. First order only: the tiles are adjacent there, or separated by cusp tiles of that one direction. "No edge of
  `p` leaves along `δ`" is FS116-N2-ANTI's "`δ` in the interior of the cone".
* *The tiles of `p`, counter-clockwise* (`IsStar4 p t₁ t₂ t₃ t₄ e₁ e₂ e₃ e₄`): the four tiles of `p`, pairwise distinct,
  their cones at `p` the consecutive closed intervals `[e₁, e₂]`, `[e₂, e₃]`, `[e₃, e₄]`, `[e₄, e₁ + 360°]` — `e_i` is the
  direction of the edge at which `t_i` begins. "The edge `t|t'` lies in a window `[α, β]`" is `e ∈ Icc α β` for the star's
  edge between them. A vertex of four colours of a valid non-Siamese map simple at it has a star (`exists_isStar4`).
* *A cone of zero angle* (`ZeroAngleAt S y`): `S` approaches `y` along at most one direction.

**The two germ pairs, uniformly.** The reflection in the line `p y` exchanges `u = r(ψ + 60°)` with `v = r(ψ − 60°)` and
clockwise with counter-clockwise, and each germ pair is one of its orbits: the pair *on side `s`* is the germ on side `s`
of `u` with the germ on side `s.flip` of `v` — the tip pair `{u⁺, v⁻}` for `s = ccw`, the outer pair `{u⁻, v⁺}` for
`s = cw`. `SemiKind.qSide` is the side of the pair a semi-hub of that kind has on (Q) arcs (`O ↦ ccw`, `T ↦ cw`), and
`isSemiHub_iff_qSide`, `isFullSemiHub_iff_qSide` are the bridges to the foundation's four clauses.

| row | declarations | state |
|---|---|---|
| FS116-V5-OUT2 | **a citation**: `star_outer_cone` (`…/Star`) at `ψ = θ`, any point `p`, valid and non-Siamese only | proved there |
| FS116-V5-QCOL | four colours: `germS_absent` (`Plane/RingGerm`); `qcol_cw`, `qcol_ccw`; `qcol_inner_tile`, `ringArc_dist_le_one`; `IsTile.not_mem_closure_of_not_subset_ball`; `qcol_not_one_arc`; `GermOnQWith.exists_isRingArc_ccw`, `…_cw` | `qcol_cw`, `qcol_ccw` proved; `ringArc_dist_le_one` from `qcol_inner_tile`; the rest stated |
| FS116-N3-PAIR | `germPair_inner_ne`, `germPair_swap` | `germPair_swap` proved from `germPair_inner_ne`, stated |
| FS116-V5-DICHO | `germPair_dicho` | stated |
| FS116-N3-CONE | (a) `ringTile_uMinus`, `ringTile_vMinus`, `ringTile_vPlus`, `ringTile_uPlus`; (b) `IsRingArc.germIn_closure`, `germOnQ_bar_uPlus`, `…_vMinus`, `…_uMinus`, `…_vPlus`; (c) `closure_inter_subset_sphere`, `isRingArc_of_edge`, `four_le_of_bothKind` | (b)'s four and `closure_inter_subset_sphere` proved; the rest stated |
| FS116-N3-STAR2 | `exists_isStar4`, `ringArc_star`, `fullSemiHub_star_crossed`, `fullSemiHub_star_parallel`, `fullSemiHub_star_parallel_T` | stated |
| FS116-N3-SEMI | `semiHub_places` (`…/SemiHubPlaces`) | stated |
| FS116-N3-CROSS | `crossed_no_tip`, `crossed_tip_zeroAngle`, `crossed_outer`, `crossed_four`, `crossed_changePoint`, `crossed_semiHub` (`…/SemiHubPlaces`) | `crossed_tip_zeroAngle` proved from `crossed_no_tip`; the rest stated |
| FS116-RING-TRANSFER-QC | `transferQC` (`…/SemiHubPlaces`; its first clause; the others are the rows above, cited in its docstring) | proved from `semiHub_places` |

**What is wider than the rows** (each reported as a generalization).
* FS116-V5-OUT2 reads valid and non-Siamese only (`star_outer_cone`): no change point, no count of colours, no *simple*.
* FS116-V5-QCOL's "a germ off (Q) arcs carries an absent colour" reads no non-Siamese hypothesis (`qcol_cw`, `qcol_ccw`).
* FS116-N3-PAIR reads two germs on (Q) arcs on opposite sides of `u` and `v`: no change point, no *simple*, any `k`.
* FS116-V5-DICHO and FS116-N3-STAR2 read a vertex of exactly four colours, simple at it, and the two arcs: no change point,
  no semi-hub, any `k`; DICHO holds at a closed change point too (a longer arc only narrows the windows).
* FS116-N3-CROSS's first clause is true vacuously: no tile of `p` has `y` in its closure (`crossed_no_tip`), so its
  hypothesis "every tile at `y` a cone of positive angle" is idle (`plans/FS116-V5-verification.md` § 3.4 step 2).
* **No row here rests on wave 7's FS114-N7-QOPP in the kernel.** What the arguments read of it is FS112-U1's two cone
  windows, landed in wave 3 with Siamese pairs allowed (`ringArc_cone_inner`, `ringArc_cone_outer`, `Plane/RingGerm`), the
  identification of the inner tile (`qcol_inner_tile`, the non-Siamese engine), and the cyclic position of the two tiles
  among four, which is `ringArc_star` here. So the three rows are theorems, not implications from a named hypothesis.

**Inhabitants.** A change point of a vertex of four colours with two absent: FS114-Y2-BOWTIE's centre and FS112-CAL-STRIP's
`P₀` (wave 7's line; no Lean term yet), as for `…/Star`'s rows. Semi-hubs: the strip's `P₀` at `P₂` (crossed full semi-hub
of kind O, four colours: the models of `crossed_*`, `fullSemiHub_star_crossed`, `semiHub_places`' first alternative) and the
bowtie's centre at `top` (parallel full semi-hub of kind O, four colours: `fullSemiHub_star_parallel`, `germPair_swap`) —
`data/fs116/n3/semi.out`, held by hand and by an exact tool, no Lean term. `semiHub_places`' second and third alternatives
have no held model (no held fragment has a three-colour semi-hub; the third is SEMI-PAR3's open configuration), and
`fullSemiHub_star_parallel_T` has none (no held semi-hub of kind T). The definitions' spec examples are at the end; a Lean
star needs a map with four tiles at a point whose cones are computed (`quadRing` at `0` is the candidate): owed.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## The three words -/

/-- **A cone of zero angle**: `S` approaches `y` along at most one direction (a cusp, or not at all). -/
def ZeroAngleAt (S : Set ℂ) (y : ℂ) : Prop := ∃ β, coneAt S y ⊆ angleIcc β β

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- **An edge of `p` between the tiles `T` and `T'` leaves `p` along `δ`** (first order): two distinct tiles of `p` both
approach `p` along `δ`. -/
def IsEdgeDir (p : ℂ) (T T' : Set ℂ) (δ : ℝ) : Prop :=
  F.TileAt p T ∧ F.TileAt p T' ∧ T ≠ T' ∧ δ ∈ coneAt T p ∧ δ ∈ coneAt T' p

/-- **The tiles of `p`, counter-clockwise**: `t₁, t₂, t₃, t₄` are the tiles of `p`, pairwise distinct, and their cones at
`p` are the consecutive closed intervals of directions `[e₁, e₂]`, `[e₂, e₃]`, `[e₃, e₄]`, `[e₄, e₁ + 360°]`: `t_i` begins
at the edge direction `e_i`. (The directions are real angles; a star is determined up to rotating the four labels and
adding one multiple of `360°` to the four directions.) -/
structure IsStar4 (p : ℂ) (t₁ t₂ t₃ t₄ : Set ℂ) (e₁ e₂ e₃ e₄ : ℝ) : Prop where
  /-- These four are the tiles of `p`. -/
  tileAt : ∀ T, F.TileAt p T ↔ T = t₁ ∨ T = t₂ ∨ T = t₃ ∨ T = t₄
  /-- They are pairwise distinct. -/
  ne : t₁ ≠ t₂ ∧ t₁ ≠ t₃ ∧ t₁ ≠ t₄ ∧ t₂ ≠ t₃ ∧ t₂ ≠ t₄ ∧ t₃ ≠ t₄
  /-- The edge directions increase counter-clockwise … -/
  le₁₂ : e₁ ≤ e₂
  /-- … -/
  le₂₃ : e₂ ≤ e₃
  /-- … -/
  le₃₄ : e₃ ≤ e₄
  /-- … and close up after one turn. -/
  le₄₁ : e₄ ≤ e₁ + 2 * π
  /-- The cone of `t₁` at `p`. -/
  cone₁ : coneAt t₁ p = angleIcc e₁ e₂
  /-- The cone of `t₂` at `p`. -/
  cone₂ : coneAt t₂ p = angleIcc e₂ e₃
  /-- The cone of `t₃` at `p`. -/
  cone₃ : coneAt t₃ p = angleIcc e₃ e₄
  /-- The cone of `t₄` at `p`. -/
  cone₄ : coneAt t₄ p = angleIcc e₄ (e₁ + 2 * π)

/-- The side of the germ pair a semi-hub of the given kind has on (Q) arcs: counter-clockwise (the tip pair `{u⁺, v⁻}`)
for kind `O`, clockwise (the outer pair `{u⁻, v⁺}`) for kind `T`. -/
def SemiKind.qSide : SemiKind → Side
  | .O => .ccw
  | .T => .cw

variable {F}

/-! ### First consequences of the definitions -/

/-- An edge direction is symmetric in its two tiles. -/
theorem IsEdgeDir.symm {p : ℂ} {T T' : Set ℂ} {δ : ℝ} (h : F.IsEdgeDir p T T' δ) : F.IsEdgeDir p T' T δ :=
  ⟨h.2.1, h.1, h.2.2.1.symm, h.2.2.2.2, h.2.2.2.1⟩

/-- In a star, `t₂` begins where `t₁` ends: `e₂` is an edge direction of `p` between `t₁` and `t₂`. -/
theorem IsStar4.isEdgeDir₁₂ {p : ℂ} {t₁ t₂ t₃ t₄ : Set ℂ} {e₁ e₂ e₃ e₄ : ℝ}
    (h : F.IsStar4 p t₁ t₂ t₃ t₄ e₁ e₂ e₃ e₄) : F.IsEdgeDir p t₁ t₂ e₂ :=
  ⟨(h.tileAt t₁).mpr (Or.inl rfl), (h.tileAt t₂).mpr (Or.inr (Or.inl rfl)), h.ne.1,
    h.cone₁ ▸ Icc_subset_angleIcc _ _ ⟨h.le₁₂, le_rfl⟩, h.cone₂ ▸ Icc_subset_angleIcc _ _ ⟨le_rfl, h.le₂₃⟩⟩

/-- In a star, `e₃` is an edge direction between `t₂` and `t₃`. -/
theorem IsStar4.isEdgeDir₂₃ {p : ℂ} {t₁ t₂ t₃ t₄ : Set ℂ} {e₁ e₂ e₃ e₄ : ℝ}
    (h : F.IsStar4 p t₁ t₂ t₃ t₄ e₁ e₂ e₃ e₄) : F.IsEdgeDir p t₂ t₃ e₃ :=
  ⟨(h.tileAt t₂).mpr (Or.inr (Or.inl rfl)), (h.tileAt t₃).mpr (Or.inr (Or.inr (Or.inl rfl))), h.ne.2.2.2.1,
    h.cone₂ ▸ Icc_subset_angleIcc _ _ ⟨h.le₂₃, le_rfl⟩, h.cone₃ ▸ Icc_subset_angleIcc _ _ ⟨le_rfl, h.le₃₄⟩⟩

/-- In a star, `e₄` is an edge direction between `t₃` and `t₄`. -/
theorem IsStar4.isEdgeDir₃₄ {p : ℂ} {t₁ t₂ t₃ t₄ : Set ℂ} {e₁ e₂ e₃ e₄ : ℝ}
    (h : F.IsStar4 p t₁ t₂ t₃ t₄ e₁ e₂ e₃ e₄) : F.IsEdgeDir p t₃ t₄ e₄ :=
  ⟨(h.tileAt t₃).mpr (Or.inr (Or.inr (Or.inl rfl))), (h.tileAt t₄).mpr (Or.inr (Or.inr (Or.inr rfl))), h.ne.2.2.2.2.2,
    h.cone₃ ▸ Icc_subset_angleIcc _ _ ⟨h.le₃₄, le_rfl⟩, h.cone₄ ▸ Icc_subset_angleIcc _ _ ⟨le_rfl, h.le₄₁⟩⟩

/-- In a star, a window inside the cone of `t₂`: `[e₂, e₃]` holds every interval between an upper bound of `e₂` and a
lower bound of `e₃` (the form FS116-N3-STAR2's "the other two tiles' cones contain …" takes). -/
theorem IsStar4.angleIcc_subset_cone₂ {p : ℂ} {t₁ t₂ t₃ t₄ : Set ℂ} {e₁ e₂ e₃ e₄ : ℝ}
    (h : F.IsStar4 p t₁ t₂ t₃ t₄ e₁ e₂ e₃ e₄) {a b : ℝ} (ha : e₂ ≤ a) (hb : b ≤ e₃) :
    angleIcc a b ⊆ coneAt t₂ p :=
  h.cone₂ ▸ angleIcc_subset_angleIcc ha hb

/-- In a star, a window inside the cone of `t₄`. -/
theorem IsStar4.angleIcc_subset_cone₄ {p : ℂ} {t₁ t₂ t₃ t₄ : Set ℂ} {e₁ e₂ e₃ e₄ : ℝ}
    (h : F.IsStar4 p t₁ t₂ t₃ t₄ e₁ e₂ e₃ e₄) {a b : ℝ} (ha : e₄ ≤ a) (hb : b ≤ e₁ + 2 * π) :
    angleIcc a b ⊆ coneAt t₄ p :=
  h.cone₄ ▸ angleIcc_subset_angleIcc ha hb

/-- A semi-hub in the pair's own words: a change point whose pair on side `kind.qSide.flip` is free and whose pair on side
`kind.qSide` is not. -/
theorem isSemiHub_iff_qSide {p : ℂ} {ψ : ℝ} {kind : SemiKind} :
    F.IsSemiHub p ψ kind ↔ (∃ X X', F.IsChangePoint p ψ X X') ∧
      (¬ F.GermOnQ p (ψ + π / 3) kind.qSide.flip ∧ ¬ F.GermOnQ p (ψ - π / 3) kind.qSide) ∧
      ¬ (¬ F.GermOnQ p (ψ + π / 3) kind.qSide ∧ ¬ F.GermOnQ p (ψ - π / 3) kind.qSide.flip) := by
  cases kind
  · exact ⟨fun ⟨h1, h2, h3⟩ => ⟨h1, h2, fun h => h3 ⟨h.2, h.1⟩⟩, fun ⟨h1, h2, h3⟩ => ⟨h1, h2, fun h => h3 ⟨h.2, h.1⟩⟩⟩
  · exact ⟨fun ⟨h1, h2, h3⟩ => ⟨h1, ⟨h2.2, h2.1⟩, h3⟩, fun ⟨h1, h2, h3⟩ => ⟨h1, ⟨h2.2, h2.1⟩, h3⟩⟩

/-- A full semi-hub in the pair's own words: the pair on side `kind.qSide.flip` is free, and both germs of the pair on side
`kind.qSide` lie on (Q) arcs. -/
theorem isFullSemiHub_iff_qSide {p : ℂ} {ψ : ℝ} {kind : SemiKind} :
    F.IsFullSemiHub p ψ kind ↔ (∃ X X', F.IsChangePoint p ψ X X') ∧
      (¬ F.GermOnQ p (ψ + π / 3) kind.qSide.flip ∧ ¬ F.GermOnQ p (ψ - π / 3) kind.qSide) ∧
      F.GermOnQ p (ψ + π / 3) kind.qSide ∧ F.GermOnQ p (ψ - π / 3) kind.qSide.flip := by
  cases kind
  · exact ⟨fun ⟨h1, h2, h3, h4⟩ => ⟨h1, h2, h4, h3⟩, fun ⟨h1, h2, h3, h4⟩ => ⟨h1, h2, h4, h3⟩⟩
  · exact ⟨fun ⟨h1, h2, h3, h4⟩ => ⟨h1, ⟨h2.2, h2.1⟩, h3, h4⟩, fun ⟨h1, h2, h3, h4⟩ => ⟨h1, ⟨h2.2, h2.1⟩, h3, h4⟩⟩

/-! ## FS116-V5-QCOL -/

/-- **FS116-V5-QCOL**, "a germ that lies on no (Q) arc carries an absent colour — `X` at `u⁻` and `v⁻`" (Siamese pairs
allowed): at a change point `y = r(ψ)` of the ring of a vertex `p` of at least four colours with at most two absent, the
germ just clockwise of `u = r(ψ + 60°)` or of `v = r(ψ − 60°)`, if it lies on no (Q) arc, lies in the closure of the class
of `X`, the ring's colour just counter-clockwise of `y` (so `u`, resp. `v`, is in that closure: `GermIn.ringPt_mem_closure`).
"Carries": the ring's colour there if the germ is off `Γ`, else a side colour of the arc of `Γ` it lies on.
(Inhabitants: the module docstring.) -/
theorem qcol_cw (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k} (hy : F.IsChangePoint p ψ X X') {θ : ℝ}
    (hθ : θ = ψ + π / 3 ∨ θ = ψ - π / 3) (hQ : ¬ F.GermOnQ p θ .cw) : GermIn p θ .cw (closure (F.region X)) := by
  have hc : (F.coloursAt p)ᶜ = {X', X} := by rw [(germS_absent hF hp h4 hk hy).2, Set.pair_comm]
  have hno : ¬ GermIn p θ .cw (closure (F.region X')) := by
    rcases hθ with rfl | rfl
    · exact fun h => not_germIn_closure_rotate hF p ψ .cw X' ⟨hy.2.2.2.mono subset_closure, h⟩
    · intro h
      refine not_germIn_closure_rotate hF p (ψ - π / 3) .cw X' ⟨h, ?_⟩
      rw [sub_add_cancel]
      exact hy.2.2.2.mono subset_closure
  exact (germ_absent_class hF hp h4 hy.2.1.symm hc .cw hQ hno).1

/-- **FS116-V5-QCOL**, "… and `X̄` at `u⁺` and `v⁺`" (Siamese pairs allowed): the germ just counter-clockwise of `u` or of
`v`, if it lies on no (Q) arc, lies in the closure of the class of `X'`, the ring's colour just clockwise of `y`. -/
theorem qcol_ccw (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k} (hy : F.IsChangePoint p ψ X X') {θ : ℝ}
    (hθ : θ = ψ + π / 3 ∨ θ = ψ - π / 3) (hQ : ¬ F.GermOnQ p θ .ccw) : GermIn p θ .ccw (closure (F.region X')) := by
  have hc : (F.coloursAt p)ᶜ = {X, X'} := (germS_absent hF hp h4 hk hy).2
  have hno : ¬ GermIn p θ .ccw (closure (F.region X)) := by
    rcases hθ with rfl | rfl
    · exact fun h => not_germIn_closure_rotate hF p ψ .ccw X ⟨hy.2.2.1.mono subset_closure, h⟩
    · intro h
      refine not_germIn_closure_rotate hF p (ψ - π / 3) .ccw X ⟨h, ?_⟩
      rw [sub_add_cancel]
      exact hy.2.2.1.mono subset_closure
  exact (germ_absent_class hF hp h4 hy.2.1 hc .ccw hQ hno).1

/-- **FS116-V5-QCOL**, "an arc of `ω(p)` whose inner tile is `p`'s tile of the inner colour": in a valid non-Siamese map,
the tile of `p` of the inner colour of an arc of `Γ` on `ω(p)` holds the whole arc in its closure (points of the inner side
are nearer than `1` to `p`). Any point `p`, any `k`. (This is the first clause of wave 7's `qArc_inner`, FS114-N7-QOPP (i),
stated there with `sorry` on a branch this one does not hold: one declaration at the join.) -/
theorem qcol_inner_tile (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hA : F.IsRingArc p θ₁ θ₂ c c') {T : Set ℂ} (hT : F.TileOf c T) (hpT : p ∈ closure T) :
    ringArc p θ₁ θ₂ ⊆ closure T := by
  have hsub : F.region c ∩ ball p 1 ⊆ closure T := fun z hz =>
    mem_closure_tile_of_near hF hN hT (F.interiorPts_subset_dom hz.1.1) (subset_closure hz.1) hpT (mem_ball.mp hz.2)
  have hcont : Continuous fun θ : ℝ => ringPt p θ := by unfold ringPt e; fun_prop
  have h1 : ringPt p '' Icc θ₁ θ₂ ⊆ closure (ringPt p '' Ioo θ₁ θ₂) := by
    rw [← closure_Ioo hA.1.ne]
    exact image_closure_subset_closure_image hcont
  refine h1.trans (closure_minimal ?_ isClosed_closure)
  rintro _ ⟨φ, hφ, rfl⟩
  have : c ∈ F.innerColours p (ringPt p φ) := by rw [(hA.2.2 φ hφ).1]; rfl
  exact closure_minimal hsub isClosed_closure this

/-- **FS116-V5-QCOL**, "… and whose outer tile is not a tile of `p`", at the class it reads (any valid map, any tile): a
tile with a point outside `B(p, 1)` is no tile of `p`. -/
theorem IsTile.not_mem_closure_of_not_subset_ball (hF : F.Valid) {T : Set ℂ} (hT : F.IsTile T) {p : ℂ}
    (h : ¬ T ⊆ ball p 1) : p ∉ closure T :=
  fun hp => h (hT.subset_ball hF hp)

/-- **A germ on a ring arc, on either side, is a sub-arc with the same sides**: if the germ on side `s` of `r(θ)` lies on
an arc of `Γ` on `ω(p)` with sides `a`, `a'`, then for some `ℓ > 0` the points `r(φ)` with `φ` on side `s` of `θ` and
`|φ − θ| ≤ ℓ` lie in `Γ` (the end `φ = θ` included) and, for `0 < |φ − θ| < ℓ`, carry `a` alone inside and `a'` alone
outside. (The angles modulo `2π` are wave 3's `exists_germ_interior`; no map hypothesis is read. Helper of the two sub-arc
lemmas below; job FS131-I8C.) -/
theorem IsRingArc.exists_sub_of_germIn {p : ℂ} {θ₁ θ₂ : ℝ} {a a' : Fin k} (hA : F.IsRingArc p θ₁ θ₂ a a') {θ : ℝ}
    {s : Side} (hg : GermIn p θ s (ringArc p θ₁ θ₂)) :
    ∃ ℓ > 0, (∀ φ, |φ - θ| ≤ ℓ → 0 ≤ s.sign * (φ - θ) → ringPt p φ ∈ F.Γ) ∧
      ∀ φ, |φ - θ| < ℓ → 0 < s.sign * (φ - θ) →
        F.innerColours p (ringPt p φ) = {a} ∧ F.outerColours p (ringPt p φ) = {a'} := by
  have hσ : s.sign = 1 ∨ s.sign = -1 := by cases s <;> simp [Side.sign]
  obtain ⟨δ, hδ, hint⟩ := exists_germ_interior hg
  have hbase := mem_ringArc_of_germIn hg
  have key : ∀ φ, |φ - θ| < δ → 0 < s.sign * (φ - θ) → ∃ ψ ∈ Ioo θ₁ θ₂, ringPt p ψ = ringPt p φ := by
    intro φ h1 h2
    have ht : s.sign * (φ - θ) ∈ Ioo (0 : ℝ) δ := by
      refine ⟨h2, ?_⟩
      rcases hσ with h | h <;> rw [h] <;> have := abs_lt.mp h1 <;> linarith
    obtain ⟨ψ, hψ, hψe⟩ := hint _ ht
    refine ⟨ψ, hψ, ?_⟩
    have : θ + s.sign * (s.sign * (φ - θ)) = φ := by
      rcases hσ with h | h <;> rw [h] <;> ring
    rw [this] at hψe
    simp only [ringPt, hψe]
  refine ⟨δ / 2, by linarith, fun φ h1 h2 => ?_, fun φ h1 h2 => ?_⟩
  · rcases h2.eq_or_lt with h0 | h0
    · have : φ = θ := by
        rcases hσ with h | h <;> rw [h] at h0 <;> linarith
      rw [this]; exact hA.2.1 hbase
    · obtain ⟨ψ, hψ, hψe⟩ := key φ (by linarith) h0
      rw [← hψe]; exact hA.2.1 ⟨ψ, Ioo_subset_Icc_self hψ, rfl⟩
  · obtain ⟨ψ, hψ, hψe⟩ := key φ (by linarith) h2
    rw [← hψe]; exact hA.2.2 ψ hψ

/-- **A germ on a ring arc, counter-clockwise, is a ring arc starting at its point**: if the germ just counter-clockwise of
`r(θ)` lies on a (Q) arc of inner colour `a` and outer colour `a'`, then for some `ℓ > 0` the arc `r([θ, θ + ℓ])` is an arc
of `Γ` on `ω(p)` with those side colours. (FS116-V5-QCOL's "a (Q) arc holding `u⁺` and not `u⁻` ends at `u`", in the form
the rows consume: the sub-arc from `u`; no map hypothesis is read.) -/
theorem GermOnQWith.exists_isRingArc_ccw {p : ℂ} {θ : ℝ} {a a' : Fin k} (h : F.GermOnQWith p θ .ccw a a') :
    ∃ ℓ > 0, F.IsRingArc p θ (θ + ℓ) a a' := by
  obtain ⟨θ₁, θ₂, hA, -, -, -, hg⟩ := h
  obtain ⟨ℓ, hℓ, hΓ, hside⟩ := hA.exists_sub_of_germIn hg
  refine ⟨ℓ / 2, by linarith, by linarith, ?_, fun φ hφ => hside φ ?_ ?_⟩
  · rintro _ ⟨φ, hφ, rfl⟩
    refine hΓ φ ?_ ?_
    · rw [abs_of_nonneg (by linarith [hφ.1])]; linarith [hφ.2]
    · simp only [Side.sign, one_mul]; linarith [hφ.1]
  · rw [abs_of_pos (by linarith [hφ.1])]; linarith [hφ.2]
  · simp only [Side.sign, one_mul]; linarith [hφ.1]

/-- **A germ on a ring arc, clockwise, is a ring arc ending at its point.** -/
theorem GermOnQWith.exists_isRingArc_cw {p : ℂ} {θ : ℝ} {a a' : Fin k} (h : F.GermOnQWith p θ .cw a a') :
    ∃ ℓ > 0, F.IsRingArc p (θ - ℓ) θ a a' := by
  obtain ⟨θ₁, θ₂, hA, -, -, -, hg⟩ := h
  obtain ⟨ℓ, hℓ, hΓ, hside⟩ := hA.exists_sub_of_germIn hg
  refine ⟨ℓ / 2, by linarith, by linarith, ?_, fun φ hφ => hside φ ?_ ?_⟩
  · rintro _ ⟨φ, hφ, rfl⟩
    refine hΓ φ ?_ ?_
    · rw [abs_of_nonpos (by linarith [hφ.2])]; linarith [hφ.1]
    · simp only [Side.sign]; linarith [hφ.2]
  · rw [abs_of_neg (by linarith [hφ.2])]; linarith [hφ.1]
  · simp only [Side.sign]; linarith [hφ.2]

/-- **The two germs of one pair hold points more than `1` apart**: for the germ on side `s` of `u = r(ψ + 60°)` and the
germ on side `s.flip` of `v = r(ψ − 60°)`, of any positive lengths, some point of the first and some point of the second are
more than `1` apart (their angular distance is `120° ± 2t`). No map. (Helper of `qcol_not_one_arc` and
`germPair_inner_ne`; job FS131-I8C.) -/
theorem exists_far_of_germPair (p : ℂ) (ψ : ℝ) (s : Side) {δ δ' : ℝ} (hδ : 0 < δ) (hδ' : 0 < δ') :
    ∃ x ∈ germ p (ψ + π / 3) s δ, ∃ y ∈ germ p (ψ - π / 3) s.flip δ', 1 < dist x y := by
  have hπ := Real.pi_gt_three
  have hπ4 := Real.pi_lt_four
  set t : ℝ := min (min δ δ') (1 / 2) / 2 with ht
  have ht0 : 0 < t := by rw [ht]; exact half_pos (lt_min (lt_min hδ hδ') (by norm_num))
  have htδ : t < δ := by
    have := (min_le_left (min δ δ') (1 / 2)).trans (min_le_left δ δ'); rw [ht]; linarith
  have htδ' : t < δ' := by
    have := (min_le_left (min δ δ') (1 / 2)).trans (min_le_right δ δ'); rw [ht]; linarith
  have ht4 : t ≤ 1 / 4 := by
    have := min_le_right (min δ δ') (1 / 2); rw [ht]; linarith
  refine ⟨_, ⟨t, ⟨ht0, htδ⟩, rfl⟩, _, ⟨t, ⟨ht0, htδ'⟩, rfl⟩, ?_⟩
  have hσ : s.sign = 1 ∨ s.sign = -1 := by cases s <;> simp [Side.sign]
  have hdiff : ψ + π / 3 + s.sign * t - (ψ - π / 3 + s.flip.sign * t) = 2 * π / 3 + 2 * s.sign * t := by
    rw [Side.sign_flip]; ring
  have habs : |ψ + π / 3 + s.sign * t - (ψ - π / 3 + s.flip.sign * t)| = 2 * π / 3 + 2 * s.sign * t := by
    rw [hdiff]; rcases hσ with h | h <;> rw [h] <;> exact abs_of_pos (by linarith)
  have hle : |ψ + π / 3 + s.sign * t - (ψ - π / 3 + s.flip.sign * t)| ≤ π := by
    rw [habs]; rcases hσ with h | h <;> rw [h] <;> linarith
  refine (dist_ringPt_ringPt_cmp_one p hle).2.2.mpr ?_
  rw [habs]; rcases hσ with h | h <;> rw [h] <;> linarith

/-- **No arc of `Γ` on `ω(p)` whose inner colour is carried at `p` holds two points more than `1` apart** (valid,
non-Siamese): the whole arc lies in the closure of one tile of `p` (`qcol_inner_tile`). So such an arc is at most `60°`
long. -/
theorem ringArc_dist_le_one (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hA : F.IsRingArc p θ₁ θ₂ c c') (hc : c ∈ F.coloursAt p) {x y : ℂ} (hx : x ∈ ringArc p θ₁ θ₂)
    (hy : y ∈ ringArc p θ₁ θ₂) : dist x y ≤ 1 := by
  obtain ⟨T, hT, hpT⟩ := (F.mem_coloursAt_iff_exists_tileOf hpd).mp hc
  have h := qcol_inner_tile hF hN hA hT hpT
  exact hT.1.dist_le_one_of_mem_closure hF x (h hx) y (h hy)

/-- **FS116-V5-QCOL**, "the two germs of one pair never lie on one (Q) arc" (at the class it reads: no change point): in a
valid non-Siamese map, no (Q) arc of `ω(p)` holds the germ on side `s` of `u = r(ψ + 60°)` and the germ on side `s.flip` of
`v = r(ψ − 60°)` — points of the two germs are more than `1` apart, and the arc lies in the closure of one tile of `p`
(`ringArc_dist_le_one`). (The row's other branch, "it would contain `y`", is not needed.) -/
theorem qcol_not_one_arc (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) {ψ : ℝ} (s : Side) {θ₁ θ₂ : ℝ}
    (hQ : F.IsQArc p θ₁ θ₂) (hu : GermIn p (ψ + π / 3) s (ringArc p θ₁ θ₂))
    (hv : GermIn p (ψ - π / 3) s.flip (ringArc p θ₁ θ₂)) : False := by
  obtain ⟨c, c', hA, hc, -, -⟩ := hQ
  obtain ⟨δ, hδ, hsub⟩ := hu
  obtain ⟨δ', hδ', hsub'⟩ := hv
  obtain ⟨x, hx, y, hy, hxy⟩ := exists_far_of_germPair p ψ s hδ hδ'
  exact absurd (ringArc_dist_le_one hF hN hpd hA hc (hsub hx) (hsub' hy)) (not_le.mpr hxy)

/-! ## FS116-N3-PAIR and FS116-V5-DICHO -/

/-- **FS116-N3-PAIR**, the step (at the class it reads: no change point, no *simple*, any `k`): in a valid non-Siamese map,
if the germ on side `s` of `u = r(ψ + 60°)` and the germ on side `s.flip` of `v = r(ψ − 60°)` — the two germs of one pair —
lie on (Q) arcs, the two arcs' inner colours differ: one tile of `p` would hold points of both germs, more than `1` apart. -/
theorem germPair_inner_ne (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) {ψ : ℝ} (s : Side)
    {a a' b b' : Fin k} (hu : F.GermOnQWith p (ψ + π / 3) s a a') (hv : F.GermOnQWith p (ψ - π / 3) s.flip b b') :
    a ≠ b := by
  rintro rfl
  obtain ⟨θ₁, θ₂, hA, ha, -, -, δ, hδ, hsub⟩ := hu
  obtain ⟨φ₁, φ₂, hB, -, -, -, δ', hδ', hsub'⟩ := hv
  obtain ⟨T, hT, hpT⟩ := (F.mem_coloursAt_iff_exists_tileOf hpd).mp ha
  obtain ⟨x, hx, y, hy, hxy⟩ := exists_far_of_germPair p ψ s hδ hδ'
  exact absurd (hT.1.dist_le_one_of_mem_closure hF x (qcol_inner_tile hF hN hA hT hpT (hsub hx)) y
    (qcol_inner_tile hF hN hB hT hpT (hsub' hy))) (not_le.mpr hxy)

/-- **FS116-N3-PAIR**: if both germs of one pair lie on (Q) arcs and the two arcs have the same pair of colours, the inner
colour of each is the outer colour of the other. (Model: FS114-Y2-BOWTIE's centre at `top`, arcs `3 | 1` and `1 | 3`; no
Lean term.) -/
theorem germPair_swap (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) {ψ : ℝ} (s : Side)
    {a a' b b' : Fin k} (hu : F.GermOnQWith p (ψ + π / 3) s a a') (hv : F.GermOnQWith p (ψ - π / 3) s.flip b b')
    (hpair : ({a, a'} : Set (Fin k)) = {b, b'}) : a = b' ∧ a' = b := by
  have hne := germPair_inner_ne hF hN hpd s hu hv
  have ha : a ∈ ({b, b'} : Set (Fin k)) := hpair ▸ mem_insert a _
  have hb : b ∈ ({a, a'} : Set (Fin k)) := hpair ▸ mem_insert b _
  rcases ha with h | h
  · exact absurd h hne
  · rcases hb with h' | h'
    · exact absurd h'.symm hne
    · exact ⟨h, h'.symm⟩

/-- **FS116-V5-DICHO** (at the class its argument reads: a vertex of exactly four colours, simple at it; no change point,
any `k`): if both germs of one pair lie on (Q) arcs, the two arcs' colour pairs are equal — and then swapped,
`germPair_swap` — or disjoint. (A pair sharing exactly one colour puts a tile of `p` in two of FS112-U1's windows that do
not meet.) Models: the strip's `P₀` at `P₂` (disjoint), the bowtie's centre at `top` (equal); no Lean term. -/
theorem germPair_dicho (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})
    (h4 : (F.coloursAt p).ncard = 4) {ψ : ℝ} (s : Side) {a a' b b' : Fin k}
    (hu : F.GermOnQWith p (ψ + π / 3) s a a') (hv : F.GermOnQWith p (ψ - π / 3) s.flip b b') :
    (a = b' ∧ a' = b) ∨ Disjoint ({a, a'} : Set (Fin k)) {b, b'} := by
  sorry

/-! ## FS116-N3-CONE: the cone lemmas at the unit rhombus `p, u, y, v` -/

/-- **A germ in the closure of a class, near a tile of that colour, lies in the tile's closure** (valid, non-Siamese): if
the germ on side `s` of `r(θ)` lies in the closure of the class of `c`, and its points are nearer than `1` to a closure
point `w` of a tile `R` of colour `c`, the germ lies in `closure R`. -/
theorem germIn_closure_tile_of_near (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1) {c : Fin k}
    {R : Set ℂ} (hR : F.TileOf c R) {θ : ℝ} {s : Side} (hg : GermIn p θ s (closure (F.region c))) {w : ℂ}
    (hw : w ∈ closure R) {δ₀ : ℝ} (hδ₀ : 0 < δ₀)
    (hnear : ∀ t ∈ Ioo (0 : ℝ) δ₀, dist (ringPt p (θ + s.sign * t)) w < 1) : GermIn p θ s (closure R) := by
  obtain ⟨δ, hδ, hsub⟩ := hg
  refine ⟨min δ δ₀, lt_min hδ hδ₀, ?_⟩
  rintro _ ⟨t, ht, rfl⟩
  exact mem_closure_tile_of_near hF hN hR (hp (mem_closedBall.mpr (dist_ringPt p _).le))
    (hsub ⟨t, ⟨ht.1, lt_of_lt_of_le ht.2 (min_le_left _ _)⟩, rfl⟩) hw
    (hnear t ⟨ht.1, lt_of_lt_of_le ht.2 (min_le_right _ _)⟩)

/-- **A germ in the closure of a class, far from a tile of that colour, keeps the tile out of its point's unit disc** (valid,
non-Siamese): if the germ on side `s` of `r(θ)` lies in the closure of the class of `c`, and its points are farther than `1`
from a closure point `w` of a tile `R` of colour `c`, then `R` misses `B(r(θ), 1)` — the germ's points lie in closures of
other tiles of colour `c`, each far from `R`. -/
theorem disjoint_ball_of_far_germ (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1) {c : Fin k}
    {R : Set ℂ} (hR : F.TileOf c R) {θ : ℝ} {s : Side} (hg : GermIn p θ s (closure (F.region c))) {w : ℂ}
    (hw : w ∈ closure R) {δ₀ : ℝ} (hδ₀ : 0 < δ₀)
    (hfar : ∀ t ∈ Ioo (0 : ℝ) δ₀, 1 < dist (ringPt p (θ + s.sign * t)) w) : Disjoint R (ball (ringPt p θ) 1) := by
  obtain ⟨δ, hδ, hsub⟩ := hg
  rw [Set.disjoint_left]
  intro r hr hrb
  have hd : dist r (ringPt p θ) < 1 := mem_ball.mp hrb
  set t : ℝ := min (min δ δ₀) (1 - dist r (ringPt p θ)) / 2 with ht
  have ht0 : 0 < t := by rw [ht]; exact half_pos (lt_min (lt_min hδ hδ₀) (by linarith))
  have htδ : t < δ := by
    have := (min_le_left (min δ δ₀) (1 - dist r (ringPt p θ))).trans (min_le_left δ δ₀); rw [ht]; linarith
  have htδ₀ : t < δ₀ := by
    have := (min_le_left (min δ δ₀) (1 - dist r (ringPt p θ))).trans (min_le_right δ δ₀); rw [ht]; linarith
  have htη : t < 1 - dist r (ringPt p θ) := by
    have := min_le_right (min δ δ₀) (1 - dist r (ringPt p θ)); rw [ht]; linarith
  have hzd : ringPt p (θ + s.sign * t) ∈ F.dom := hp (mem_closedBall.mpr (dist_ringPt p _).le)
  obtain ⟨T, hT, hzT⟩ := (F.mem_coloursAt_iff_exists_tileOf hzd).mp (hsub ⟨t, ⟨ht0, htδ⟩, rfl⟩)
  have hzw := hfar t ⟨ht0, htδ₀⟩
  rcases unitNear_or_unitFar hF hT hR with hn | hf
  · have hTR : T = R := hN.eq_of_unitNear hT hR hn
    rw [hTR] at hzT
    exact absurd (hR.1.dist_le_one_of_mem_closure hF _ hzT _ hw) (not_le.mpr hzw)
  · have h1 := UnitFar.one_le_dist_of_mem_closure hf hzT (subset_closure hr)
    have h2 := dist_ringPt_germ_le p θ s ht0.le
    have h3 := dist_triangle (ringPt p (θ + s.sign * t)) (ringPt p θ) r
    rw [dist_comm (ringPt p (θ + s.sign * t)) (ringPt p θ), dist_comm (ringPt p θ) r] at h3
    linarith

/-- **FS116-N3-CONE (a)**, `u⁻`: at a change point `y = r(ψ)` of the ring of a vertex `p` of at least four colours with at
most two absent, in a valid non-Siamese map, if the germ just clockwise of `u = r(ψ + 60°)` lies on no (Q) arc, the tile `R`
of the ring's counter-clockwise colour `X` at `y` has `u` in its closure, so lies in `B̄(u, 1)`. No *simple*. -/
theorem ringTile_uMinus (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k}
    (hy : F.IsChangePoint p ψ X X') (hQ : ¬ F.GermOnQ p (ψ + π / 3) .cw) {R : Set ℂ} (hR : F.TileOf X R)
    (hyR : ringPt p ψ ∈ closure R) : ringPt p (ψ + π / 3) ∈ closure R ∧ R ⊆ closedBall (ringPt p (ψ + π / 3)) 1 := by
  have hπ := Real.pi_gt_three
  have hg := germIn_closure_tile_of_near hF hN hp hR (qcol_cw hF hp h4 hk hy (Or.inl rfl) hQ) hyR one_pos
    fun t ht => by
      have habs : |ψ + π / 3 + Side.cw.sign * t - ψ| = π / 3 - t := by
        rw [show ψ + π / 3 + Side.cw.sign * t - ψ = π / 3 - t by simp only [Side.sign]; ring]
        exact abs_of_pos (by linarith [ht.2])
      exact (dist_ringPt_ringPt_cmp_one p (by rw [habs]; linarith [ht.1])).2.1.mpr (by rw [habs]; linarith [ht.1])
  have hu : ringPt p (ψ + π / 3) ∈ closure R := closure_closure (s := R) ▸ hg.ringPt_mem_closure
  exact ⟨hu, (hR.1.subset_ball hF hu).trans ball_subset_closedBall⟩

/-- **FS116-N3-CONE (a)**, `v⁻`: if the germ just clockwise of `v = r(ψ − 60°)` lies on no (Q) arc, `R` misses `B(v, 1)`
(another tile of colour `X` holds `v`, and the two are far apart). -/
theorem ringTile_vMinus (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k}
    (hy : F.IsChangePoint p ψ X X') (hQ : ¬ F.GermOnQ p (ψ - π / 3) .cw) {R : Set ℂ} (hR : F.TileOf X R)
    (hyR : ringPt p ψ ∈ closure R) : Disjoint R (ball (ringPt p (ψ - π / 3)) 1) := by
  have hπ := Real.pi_gt_three
  refine disjoint_ball_of_far_germ hF hN hp hR (qcol_cw hF hp h4 hk hy (Or.inr rfl) hQ) hyR one_pos fun t ht => ?_
  have habs : |ψ - π / 3 + Side.cw.sign * t - ψ| = π / 3 + t := by
    rw [show ψ - π / 3 + Side.cw.sign * t - ψ = -(π / 3 + t) by simp only [Side.sign]; ring, abs_neg]
    exact abs_of_pos (by linarith [ht.1])
  exact (dist_ringPt_ringPt_cmp_one p (by rw [habs]; linarith [ht.2])).2.2.mpr (by rw [habs]; linarith [ht.1])

/-- **FS116-N3-CONE (a)**, `v⁺`: if the germ just counter-clockwise of `v` lies on no (Q) arc, the tile `R'` of the ring's
clockwise colour `X'` at `y` has `v` in its closure, so lies in `B̄(v, 1)`. -/
theorem ringTile_vPlus (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k}
    (hy : F.IsChangePoint p ψ X X') (hQ : ¬ F.GermOnQ p (ψ - π / 3) .ccw) {R' : Set ℂ} (hR' : F.TileOf X' R')
    (hyR' : ringPt p ψ ∈ closure R') :
    ringPt p (ψ - π / 3) ∈ closure R' ∧ R' ⊆ closedBall (ringPt p (ψ - π / 3)) 1 := by
  have hπ := Real.pi_gt_three
  have hg := germIn_closure_tile_of_near hF hN hp hR' (qcol_ccw hF hp h4 hk hy (Or.inr rfl) hQ) hyR' one_pos
    fun t ht => by
      have habs : |ψ - π / 3 + Side.ccw.sign * t - ψ| = π / 3 - t := by
        rw [show ψ - π / 3 + Side.ccw.sign * t - ψ = -(π / 3 - t) by simp only [Side.sign]; ring, abs_neg]
        exact abs_of_pos (by linarith [ht.2])
      exact (dist_ringPt_ringPt_cmp_one p (by rw [habs]; linarith [ht.1])).2.1.mpr (by rw [habs]; linarith [ht.1])
  have hv : ringPt p (ψ - π / 3) ∈ closure R' := closure_closure (s := R') ▸ hg.ringPt_mem_closure
  exact ⟨hv, (hR'.1.subset_ball hF hv).trans ball_subset_closedBall⟩

/-- **FS116-N3-CONE (a)**, `u⁺`: if the germ just counter-clockwise of `u` lies on no (Q) arc, `R'` misses `B(u, 1)`. -/
theorem ringTile_uPlus (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k}
    (hy : F.IsChangePoint p ψ X X') (hQ : ¬ F.GermOnQ p (ψ + π / 3) .ccw) {R' : Set ℂ} (hR' : F.TileOf X' R')
    (hyR' : ringPt p ψ ∈ closure R') : Disjoint R' (ball (ringPt p (ψ + π / 3)) 1) := by
  have hπ := Real.pi_gt_three
  refine disjoint_ball_of_far_germ hF hN hp hR' (qcol_ccw hF hp h4 hk hy (Or.inl rfl) hQ) hyR' one_pos fun t ht => ?_
  have habs : |ψ + π / 3 + Side.ccw.sign * t - ψ| = π / 3 + t := by
    rw [show ψ + π / 3 + Side.ccw.sign * t - ψ = π / 3 + t by simp only [Side.sign]; ring]
    exact abs_of_pos (by linarith [ht.1])
  exact (dist_ringPt_ringPt_cmp_one p (by rw [habs]; linarith [ht.2])).2.2.mpr (by rw [habs]; linarith [ht.1])

/-- **A germ on a ring arc lies in the closures of the arc's two side classes** (any map: the bridge from a germ on an
arc of `Γ` on `ω(p)` to FS116-N1-GERM-R's hypothesis). -/
theorem IsRingArc.germIn_closure {p : ℂ} {θ₁ θ₂ : ℝ} {a a' : Fin k} (hA : F.IsRingArc p θ₁ θ₂ a a') {θ : ℝ} {s : Side}
    (hg : GermIn p θ s (ringArc p θ₁ θ₂)) :
    GermIn p θ s (closure (F.region a)) ∧ GermIn p θ s (closure (F.region a')) :=
  ⟨hg.mono hA.ringArc_subset_closure.1, hg.mono hA.ringArc_subset_closure.2⟩

/-- A germ on a (Q) arc with named colours lies in the closures of the two colours' classes. -/
theorem GermOnQWith.germIn_closure {p : ℂ} {θ : ℝ} {s : Side} {a a' : Fin k} (h : F.GermOnQWith p θ s a a') :
    GermIn p θ s (closure (F.region a)) ∧ GermIn p θ s (closure (F.region a')) := by
  obtain ⟨θ₁, θ₂, hA, -, -, -, hg⟩ := h
  exact hA.germIn_closure hg

/-- **FS116-N3-CONE (b)**, `u⁺` (any valid map, any ring point `r(ψ)`, any `k`): a germ just counter-clockwise of
`u = r(ψ + 60°)` on a (Q) arc bars both colours of that arc from the open half-circle `(ψ + 30°, ψ + 210°)` of directions
at `y = r(ψ)` (FS116-N1-GERM-R, `germR_uPlus`, at the arc's two side classes). -/
theorem germOnQ_bar_uPlus (hF : F.Valid) {p : ℂ} {ψ : ℝ} {a a' : Fin k} (h : F.GermOnQWith p (ψ + π / 3) .ccw a a') :
    ∀ β ∈ Ioo (ψ + π / 6) (ψ + 7 * π / 6),
      β ∉ coneAt (F.region a) (ringPt p ψ) ∧ β ∉ coneAt (F.region a') (ringPt p ψ) :=
  fun β hβ => ⟨germR_uPlus hF h.germIn_closure.1 β hβ, germR_uPlus hF h.germIn_closure.2 β hβ⟩

/-- **FS116-N3-CONE (b)**, `v⁻`: the half-circle `(ψ + 150°, ψ + 330°)`. -/
theorem germOnQ_bar_vMinus (hF : F.Valid) {p : ℂ} {ψ : ℝ} {a a' : Fin k} (h : F.GermOnQWith p (ψ - π / 3) .cw a a') :
    ∀ β ∈ Ioo (ψ + 5 * π / 6) (ψ + 11 * π / 6),
      β ∉ coneAt (F.region a) (ringPt p ψ) ∧ β ∉ coneAt (F.region a') (ringPt p ψ) :=
  fun β hβ => ⟨germR_vMinus hF h.germIn_closure.1 β hβ, germR_vMinus hF h.germIn_closure.2 β hβ⟩

/-- **FS116-N3-CONE (b)**, `u⁻`: the half-circle `(ψ − 150°, ψ + 30°)`. -/
theorem germOnQ_bar_uMinus (hF : F.Valid) {p : ℂ} {ψ : ℝ} {a a' : Fin k} (h : F.GermOnQWith p (ψ + π / 3) .cw a a') :
    ∀ β ∈ Ioo (ψ - 5 * π / 6) (ψ + π / 6),
      β ∉ coneAt (F.region a) (ringPt p ψ) ∧ β ∉ coneAt (F.region a') (ringPt p ψ) :=
  fun β hβ => ⟨germR_uMinus hF h.germIn_closure.1 β hβ, germR_uMinus hF h.germIn_closure.2 β hβ⟩

/-- **FS116-N3-CONE (b)**, `v⁺`: the half-circle `(ψ − 30°, ψ + 150°)`. -/
theorem germOnQ_bar_vPlus (hF : F.Valid) {p : ℂ} {ψ : ℝ} {a a' : Fin k} (h : F.GermOnQWith p (ψ - π / 3) .ccw a a') :
    ∀ β ∈ Ioo (ψ - π / 6) (ψ + 5 * π / 6),
      β ∉ coneAt (F.region a) (ringPt p ψ) ∧ β ∉ coneAt (F.region a') (ringPt p ψ) :=
  fun β hβ => ⟨germR_vPlus hF h.germIn_closure.1 β hβ, germR_vPlus hF h.germIn_closure.2 β hβ⟩

/-- **FS116-N3-CONE (c)**, the set step (no map): a set inside `B̄(w, 1)` and a set missing `B(w, 1)` have common closure
points only on `ω(w)`. -/
theorem closure_inter_subset_sphere {T₁ T₂ : Set ℂ} {w : ℂ} (h₁ : T₁ ⊆ closedBall w 1) (h₂ : Disjoint T₂ (ball w 1)) :
    closure T₁ ∩ closure T₂ ⊆ sphere w 1 := by
  rintro z ⟨hz₁, hz₂⟩
  have hle : dist z w ≤ 1 := mem_closedBall.mp (closure_minimal h₁ isClosed_closedBall hz₁)
  have hge : 1 ≤ dist z w := by
    have hsub : T₂ ⊆ (ball w 1)ᶜ := fun x hx hxb => Set.disjoint_left.mp h₂ hx hxb
    have := closure_minimal hsub isOpen_ball.isClosed_compl hz₂
    exact not_lt.mp fun hlt => this (mem_ball.mpr hlt)
  exact mem_sphere.mpr (le_antisymm hle hge)

/-- **FS116-N3-CONE (c)**, "an edge at `y` between a tile inside `B̄(w, 1)` and a tile outside `B(w, 1)` is an arc of
`ω(w)`": if an initial piece `B` of an arc of the map leaving `y` lies in the closures of two distinct tiles `T₁ ⊆ B̄(w, 1)`
and `T₂` missing `B(w, 1)`, of colours `c₁`, `c₂`, then `y` is the end of an arc of `Γ` on `ω(w)` with inner colour `c₁` and
outer colour `c₂`. Any map (validity is not read). -/
theorem isRingArc_of_edge {y w : ℂ} (hyd : y ∈ F.dom) {T₁ T₂ : Set ℂ} {c₁ c₂ : Fin k} (hT₁ : F.TileOf c₁ T₁)
    (hT₂ : F.TileOf c₂ T₂) (hne : T₁ ≠ T₂) (h₁ : T₁ ⊆ closedBall w 1) (h₂ : Disjoint T₂ (ball w 1)) {α : Arc}
    (hα : α ∈ F.arcs) {δ : ℝ} {B : Set ℂ} (hB : α.InitialPiece y δ B) (hBT : B ⊆ closure T₁ ∩ closure T₂) :
    ∃ θ₁ θ₂, F.IsRingArc w θ₁ θ₂ c₁ c₂ ∧ y ∈ ringArc w θ₁ θ₂ := by
  sorry

/-- **FS116-N3-CONE (c)**, "whose centre `w`, if it carries both side colours, is a vertex of at least four colours":
FS112-N3-NOBOTH (`noBoth`) in a valid non-Siamese map simple at `w`, where no colour is repeated at `w` (one tile per
colour, one sector per tile). -/
theorem four_le_of_bothKind (hF : F.Valid) (hN : F.NonSiamese) {w : ℂ} (hw : w ∈ F.dom) (hS : F.SimpleOn {w})
    {θ₁ θ₂ : ℝ} (hA : F.BothKind w θ₁ θ₂) : 4 ≤ (F.coloursAt w).ncard := by
  sorry

/-! ## FS116-N3-STAR2: the pinned stars -/

/-- **The star of a four-colour vertex**: in a valid non-Siamese map simple at a point `p` of the domain carrying exactly
four colours, the tiles of `p` are four, with cones four consecutive closed intervals. -/
theorem exists_isStar4 (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})
    (h4 : (F.coloursAt p).ncard = 4) :
    ∃ t₁ t₂ t₃ t₄ e₁ e₂ e₃ e₄, F.IsStar4 p t₁ t₂ t₃ t₄ e₁ e₂ e₃ e₄ := by
  sorry

/-- **A (Q) arc joins opposite tiles** (FS114-N7-QOPP's windows as `plans/FS116-N3-proof.md` § 2's preamble states them, at
a vertex of exactly four colours simple at it): for an arc of `Γ` on `ω(p)` from `u` to `v` whose inner colour `c` and outer
colour `c'` are both carried at `p`, the star of `p` can be written with the tile of `c` first and the tile of `c'` third,
the first inside FS112-U1's facing window `[v − 90°, u + 90°]` and the third inside the window `[v + 90°, u + 270°]` facing
away. So the second tile's cone contains `[u + 90°, v + 90°]` and the fourth's `[u + 270°, v + 270°]`
(`IsStar4.angleIcc_subset_cone₂`, `…_cone₄`). -/
theorem ringArc_star (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})
    (h4 : (F.coloursAt p).ncard = 4) {u v : ℝ} {c c' : Fin k} (hA : F.IsRingArc p u v c c')
    (hc : c ∈ F.coloursAt p) (hc' : c' ∈ F.coloursAt p) :
    ∃ t₁ t₂ t₃ t₄ e₁ e₂ e₃ e₄, F.IsStar4 p t₁ t₂ t₃ t₄ e₁ e₂ e₃ e₄ ∧ F.TileOf c t₁ ∧ F.TileOf c' t₃ ∧
      v - π / 2 ≤ e₁ ∧ e₂ ≤ u + π / 2 ∧ v + π / 2 ≤ e₃ ∧ e₄ ≤ u + 3 * π / 2 := by
  sorry

/-- **FS116-N3-STAR2**, crossed (at the class its argument reads: no change point, any `k`): in a valid non-Siamese map
simple at a point `p` carrying exactly four colours, let `A = r([ψ + 60°, ψ + 60° + ℓ])` be an arc of `Γ` on `ω(p)` of inner
colour `a` and outer colour `a'`, and `B = r([ψ − 60° − m, ψ − 60°])` one of inner colour `b` and outer colour `b'`, the four
colours carried at `p` and `{a, a'}`, `{b, b'}` disjoint. Then `ℓ + m ≤ 60°` and the tiles of `p` are, counter-clockwise,
`t_a, t_b', t_a', t_b` (the row's `t_b, t_a, t_b', t_a'`, read from `t_a`), with edges `t_b|t_a` in
`[ψ + ℓ − 30°, ψ + 30° − m]`, `t_a|t_b'` in `[ψ + 30°, ψ + 150°]`, `t_b'|t_a'` in `[ψ + 150° + ℓ, ψ + 210° − m]` and
`t_a'|t_b` in `[ψ + 210°, ψ + 330°]`.

The row's "full semi-hub of kind O with (Q) arcs `A`, `B`" gives these hypotheses: the arcs by
`GermOnQWith.exists_isRingArc_ccw`, `…_cw`, four colours by `germS_absent`. Model: the strip's `P₀` (`ℓ = m = 15.52°`, edges
at `0°, 90°, 180°, 270°`); no Lean term. -/
theorem fullSemiHub_star_crossed (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})
    (h4 : (F.coloursAt p).ncard = 4) {ψ ℓ m : ℝ} {a a' b b' : Fin k}
    (hA : F.IsRingArc p (ψ + π / 3) (ψ + π / 3 + ℓ) a a') (hB : F.IsRingArc p (ψ - π / 3 - m) (ψ - π / 3) b b')
    (ha : a ∈ F.coloursAt p) (ha' : a' ∈ F.coloursAt p) (hb : b ∈ F.coloursAt p) (hb' : b' ∈ F.coloursAt p)
    (hab : Disjoint ({a, a'} : Set (Fin k)) {b, b'}) :
    ℓ + m ≤ π / 3 ∧ ∃ ta tb' ta' tb e₁ e₂ e₃ e₄, F.TileOf a ta ∧ F.TileOf b' tb' ∧ F.TileOf a' ta' ∧ F.TileOf b tb ∧
      F.IsStar4 p ta tb' ta' tb e₁ e₂ e₃ e₄ ∧ e₁ ∈ Icc (ψ + ℓ - π / 6) (ψ + π / 6 - m) ∧
      e₂ ∈ Icc (ψ + π / 6) (ψ + 5 * π / 6) ∧ e₃ ∈ Icc (ψ + 5 * π / 6 + ℓ) (ψ + 7 * π / 6 - m) ∧
      e₄ ∈ Icc (ψ + 7 * π / 6) (ψ + 11 * π / 6) := by
  sorry

/-- **FS116-N3-STAR2**, parallel (kind O): with `A = r([ψ + 60°, ψ + 60° + ℓ])` of inner colour `a` and outer `a'` and
`B = r([ψ − 60° − m, ψ − 60°])` of inner colour `a'` and outer `a`, the star of `p` is `t_a, t_back, t_a', t_front` with
`t_a ⊂ [ψ + 30°, ψ + 150°]` and `t_a' ⊂ [ψ + 210°, ψ + 330°]`; so `t_back`'s cone contains `[ψ + 150°, ψ + 210°]` and
`t_front`'s `[ψ − 30°, ψ + 30°]` (`IsStar4.angleIcc_subset_cone₂`, `…_cone₄`). Model: FS114-Y2-BOWTIE's centre
(`ℓ = m = 60°`, the windows met with equality); no Lean term. -/
theorem fullSemiHub_star_parallel (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})
    (h4 : (F.coloursAt p).ncard = 4) {ψ ℓ m : ℝ} {a a' : Fin k}
    (hA : F.IsRingArc p (ψ + π / 3) (ψ + π / 3 + ℓ) a a') (hB : F.IsRingArc p (ψ - π / 3 - m) (ψ - π / 3) a' a)
    (ha : a ∈ F.coloursAt p) (ha' : a' ∈ F.coloursAt p) :
    ∃ ta tback ta' tfront e₁ e₂ e₃ e₄, F.TileOf a ta ∧ F.TileOf a' ta' ∧ F.IsStar4 p ta tback ta' tfront e₁ e₂ e₃ e₄ ∧
      ψ + π / 6 ≤ e₁ ∧ e₂ ≤ ψ + 5 * π / 6 ∧ ψ + 7 * π / 6 ≤ e₃ ∧ e₄ ≤ ψ + 11 * π / 6 := by
  sorry

/-- **The parallel star of kind T** (`plans/FS116-N3-proof.md` § 2.3's third line, which FS116-N3-SEMI reads; not a row):
with `A⁻ = r([ψ + 60° − ℓ, ψ + 60°])` of inner colour `a` and outer `a'` and `B⁺ = r([ψ − 60°, ψ − 60° + m])` of inner
colour `a'` and outer `a`, the star of `p` is `t_a, t_back, t_a', t_front` with `t_a ⊂ [ψ + 30° + m, ψ + 150° − ℓ]` and
`t_a' ⊂ [ψ + 210° + m, ψ + 330° − ℓ]`. No held model (no held semi-hub of kind T). -/
theorem fullSemiHub_star_parallel_T (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})
    (h4 : (F.coloursAt p).ncard = 4) {ψ ℓ m : ℝ} {a a' : Fin k}
    (hA : F.IsRingArc p (ψ + π / 3 - ℓ) (ψ + π / 3) a a') (hB : F.IsRingArc p (ψ - π / 3) (ψ - π / 3 + m) a' a)
    (ha : a ∈ F.coloursAt p) (ha' : a' ∈ F.coloursAt p) :
    ∃ ta tback ta' tfront e₁ e₂ e₃ e₄, F.TileOf a ta ∧ F.TileOf a' ta' ∧ F.IsStar4 p ta tback ta' tfront e₁ e₂ e₃ e₄ ∧
      ψ + π / 6 + m ≤ e₁ ∧ e₂ ≤ ψ + 5 * π / 6 - ℓ ∧ ψ + 7 * π / 6 + m ≤ e₃ ∧ e₄ ≤ ψ + 11 * π / 6 - ℓ := by
  sorry

end ArcMap

/-! ## Spec examples -/

/-- The empty set approaches no point: its cone has zero angle. -/
example (y : ℂ) : ZeroAngleAt (∅ : Set ℂ) y :=
  ⟨0, fun β hβ => by
    obtain ⟨z, hz, -⟩ := hβ 1 one_pos
    exact absurd hz (Set.notMem_empty z)⟩

/-- **Adversary**: an open set approaches each of its points along every direction — no zero angle. -/
example : ¬ ZeroAngleAt (ball (0 : ℂ) 1) 0 := by
  rintro ⟨β, h⟩
  have h1 : β + 1 ∈ angleIcc β β := h (mem_coneAt_of_mem_isOpen isOpen_ball (mem_ball_self one_pos) (β + 1))
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp h1
  have hπ := Real.pi_gt_three
  have e1 : (1 : ℝ) = 2 * π * m := by linarith
  have hm0 : (0 : ℝ) < m := by
    by_contra hneg
    have := mul_nonpos_of_nonneg_of_nonpos (by positivity : (0 : ℝ) ≤ 2 * π) (not_lt.mp hneg)
    linarith
  have hm1' : (1 : ℝ) ≤ m := by exact_mod_cast (Int.cast_pos.mp hm0 : (0 : ℤ) < m)
  nlinarith

/-- **Adversary**: no tile makes an edge with itself — the clause "two distinct tiles" is read. -/
example {k : ℕ} (F : ArcMap k) (p : ℂ) (T : Set ℂ) (δ : ℝ) : ¬ F.IsEdgeDir p T T δ :=
  fun h => h.2.2.1 rfl

/-- An edge direction lies in both cones, so a tile whose cone misses `δ` makes no edge along `δ`. -/
example {k : ℕ} (F : ArcMap k) (p : ℂ) (T T' : Set ℂ) (δ : ℝ) (h : δ ∉ coneAt T p) : ¬ F.IsEdgeDir p T T' δ :=
  fun he => h he.2.2.2.1

/-- In a star every tile of `p` is one of the four, and each star edge is an edge direction of `p`: the fields say what
"the tiles of `p`, counter-clockwise" should. -/
example {k : ℕ} (F : ArcMap k) (p : ℂ) (t₁ t₂ t₃ t₄ : Set ℂ) (e₁ e₂ e₃ e₄ : ℝ)
    (h : F.IsStar4 p t₁ t₂ t₃ t₄ e₁ e₂ e₃ e₄) :
    F.IsEdgeDir p t₁ t₂ e₂ ∧ F.IsEdgeDir p t₂ t₃ e₃ ∧ F.IsEdgeDir p t₃ t₄ e₄ ∧ F.TileAt p t₁ :=
  ⟨h.isEdgeDir₁₂, h.isEdgeDir₂₃, h.isEdgeDir₃₄, (h.tileAt t₁).mpr (Or.inl rfl)⟩

/-- **Adversary**: a point carrying a tile outside the four has no star with those four — the clause "these are the tiles
of `p`" is read. -/
example {k : ℕ} (F : ArcMap k) (p : ℂ) (t₁ t₂ t₃ t₄ T : Set ℂ) (e₁ e₂ e₃ e₄ : ℝ) (hT : F.TileAt p T)
    (h₁ : T ≠ t₁) (h₂ : T ≠ t₂) (h₃ : T ≠ t₃) (h₄ : T ≠ t₄) : ¬ F.IsStar4 p t₁ t₂ t₃ t₄ e₁ e₂ e₃ e₄ :=
  fun h => by
    rcases (h.tileAt T).mp hT with h | h | h | h
    exacts [h₁ h, h₂ h, h₃ h, h₄ h]

/-- The side of the pair on (Q) arcs: the tip pair for kind O, the outer pair for kind T. -/
example : ArcMap.SemiKind.O.qSide = .ccw ∧ ArcMap.SemiKind.T.qSide = .cw := ⟨rfl, rfl⟩

/-- `halfPlane2`'s hub `r(0)` is a semi-hub of neither kind, read through the pair's own words (`isSemiHub_iff_qSide`):
no germ of its ring lies on a (Q) arc, so the clause "the other pair is not free" fails. -/
example (kind : ArcMap.SemiKind) :
    ¬ ((∃ X X', halfPlane2.IsChangePoint 0 0 X X') ∧
      (¬ halfPlane2.GermOnQ 0 (0 + π / 3) kind.qSide.flip ∧ ¬ halfPlane2.GermOnQ 0 (0 - π / 3) kind.qSide) ∧
      ¬ (¬ halfPlane2.GermOnQ 0 (0 + π / 3) kind.qSide ∧ ¬ halfPlane2.GermOnQ 0 (0 - π / 3) kind.qSide.flip)) :=
  fun h => (halfPlane2_gammaFreeRing.qFreeRing.isHub halfPlane2_isChangePoint).not_isSemiHub kind
    (ArcMap.isSemiHub_iff_qSide.mpr h)

/-! ### The class of the shared lemmas, inhabited: `halfDisc` at `0` -/

/-- `halfDisc` is valid: its domain has diameter below `1`. -/
theorem halfDisc_valid : halfDisc.Valid := by
  intro x hx y hy hxy
  have hx' := (halfDisc_mem_interiorPts.mp hx).1
  have hy' := (halfDisc_mem_interiorPts.mp hy).1
  have := dist_triangle x 0 y
  rw [dist_comm 0 y, dist_zero_right, dist_zero_right] at this
  linarith

/-- `halfDisc` has no Siamese pair: its two tiles have different colours. (The unnamed example of `Plane/ArcMap`, named.) -/
theorem halfDisc_nonSiamese : halfDisc.NonSiamese := by
  rintro T T' ⟨⟨x, hx, rfl⟩, ⟨y, hy, rfl⟩, hne, hcol, -⟩
  have hxy := hcol x (mem_connectedComponentIn hx) y (mem_connectedComponentIn hy)
  have hx0 := (halfDisc_mem_interiorPts.mp hx).2
  have hy0 := (halfDisc_mem_interiorPts.mp hy).2
  simp only [halfDisc] at hxy
  rcases lt_or_gt_of_ne hx0 with hxn | hxp <;> rcases lt_or_gt_of_ne hy0 with hyn | hyp
  · exact hne (by rw [halfDisc_component_lower hx hxn, halfDisc_component_lower hy hyn])
  · simp [not_lt.mpr hxn.le, hyp] at hxy
  · simp [hxp, not_lt.mpr hyn.le] at hxy
  · exact hne (by rw [halfDisc_component_upper hx hxp, halfDisc_component_upper hy hyp])

/-- The origin of `halfDisc` carries exactly two colours. -/
theorem halfDisc_ncard_coloursAt_zero : (halfDisc.coloursAt 0).ncard = 2 := by
  have hmem : ∀ (s : ℝ) (j : Fin 2), (s = 1 ∨ s = -1) → (∀ t : ℝ, 0 < s * t → halfDisc.col ((t : ℂ) * I) = j) →
      j ∈ halfDisc.coloursAt 0 := by
    intro s j hs hcol
    simp only [ArcMap.coloursAt, mem_setOf_eq, Metric.mem_closure_iff]
    intro ε hε
    have hm : 0 < min (ε / 2) (1 / 6) := lt_min (half_pos hε) (by norm_num)
    have habs : |s * min (ε / 2) (1 / 6)| = min (ε / 2) (1 / 6) := by
      rcases hs with rfl | rfl
      · rw [one_mul, abs_of_pos hm]
      · rw [neg_one_mul, abs_neg, abs_of_pos hm]
    have hpos : 0 < s * (s * min (ε / 2) (1 / 6)) := by
      rcases hs with rfl | rfl <;> linarith
    refine ⟨((s * min (ε / 2) (1 / 6) : ℝ) : ℂ) * I, ⟨halfDisc_I_mul_mem ?_ ?_, hcol _ hpos⟩, ?_⟩
    · intro h0; rw [h0, mul_zero] at hpos; exact lt_irrefl _ hpos
    · rw [habs]; exact lt_of_le_of_lt (min_le_right _ _) (by norm_num)
    · rw [dist_comm, dist_zero_right, Complex.norm_mul, Complex.norm_I, mul_one, Complex.norm_real, Real.norm_eq_abs,
        habs]
      exact lt_of_le_of_lt (min_le_left _ _) (by linarith)
  have h1 : (1 : Fin 2) ∈ halfDisc.coloursAt 0 := hmem 1 1 (Or.inl rfl) fun t ht => by
    simp only [halfDisc, mul_im, ofReal_re, I_im, mul_one, ofReal_im, I_re, mul_zero, add_zero]
    rw [if_pos (by linarith)]
  have h0 : (0 : Fin 2) ∈ halfDisc.coloursAt 0 := hmem (-1) 0 (Or.inr rfl) fun t ht => by
    simp only [halfDisc, mul_im, ofReal_re, I_im, mul_one, ofReal_im, I_re, mul_zero, add_zero]
    rw [if_neg (by linarith)]
  have huniv : halfDisc.coloursAt 0 = univ := by
    ext j; simp only [mem_univ, iff_true]; fin_cases j
    · exact h0
    · exact h1
  rw [huniv, Set.ncard_univ, Nat.card_eq_fintype_card, Fintype.card_fin]

/-- **The class of the shared lemmas is inhabited** (owed by the join job, inventory item 586 (b)): `halfDisc` is valid,
has no Siamese pair, is simple at `0`, a point of its domain carrying two colours — so `ncard_tileAt_eq` counts two tiles
at `0`, `exists_sectorChart_tileAt` gives a chart with two germs whose sectors are those tiles, and
`exists_initialPiece_of_ncard_le_three` gives the two tiles an initial piece of an arc of the map in both closures. -/
example : halfDisc.Valid ∧ halfDisc.NonSiamese ∧ (0 : ℂ) ∈ halfDisc.dom ∧ halfDisc.SimpleOn {0} ∧
    {T | halfDisc.TileAt 0 T}.ncard = 2 ∧
    (∃ r₀, ∃ G : BranchGerms 2, halfDisc.IsSectorChart G 0 r₀ ∧ ∃ τ : Fin 2 → Set ℂ, Function.Injective τ ∧
      (∀ T, halfDisc.TileAt 0 T ↔ ∃ i, τ i = T) ∧ ∀ i, coneAt (τ i) 0 = angleIcc (G.β i) (G.nextβ i)) ∧
    ∃ T₁ T₂, halfDisc.TileAt 0 T₁ ∧ halfDisc.TileAt 0 T₂ ∧ T₁ ≠ T₂ ∧
      ∃ α ∈ halfDisc.arcs, ∃ δ B, α.InitialPiece 0 δ B ∧ B ⊆ closure T₁ ∩ closure T₂ := by
  have h0 : (0 : ℂ) ∈ halfDisc.dom := mem_ball_self (by norm_num)
  have hS := halfDisc_simpleOn {(0 : ℂ)}
  have hcount : {T | halfDisc.TileAt 0 T}.ncard = 2 :=
    (ArcMap.ncard_tileAt_eq halfDisc_valid halfDisc_nonSiamese h0).trans halfDisc_ncard_coloursAt_zero
  obtain ⟨r₀, G, hC, -, τ, hinj, htile, -, hcone⟩ :=
    ArcMap.exists_sectorChart_tileAt halfDisc_valid halfDisc_nonSiamese h0 hS halfDisc_ncard_coloursAt_zero le_rfl
  obtain ⟨T₁, T₂, hne, hpair⟩ := Set.ncard_eq_two.mp hcount
  have hT₁ : halfDisc.TileAt 0 T₁ := by
    have : T₁ ∈ {T | halfDisc.TileAt 0 T} := by rw [hpair]; exact mem_insert _ _
    exact this
  have hT₂ : halfDisc.TileAt 0 T₂ := by
    have : T₂ ∈ {T | halfDisc.TileAt 0 T} := by rw [hpair]; exact mem_insert_of_mem _ rfl
    exact this
  exact ⟨halfDisc_valid, halfDisc_nonSiamese, h0, hS, hcount, ⟨r₀, G, hC, τ, hinj, htile, hcone⟩, T₁, T₂, hT₁, hT₂, hne,
    ArcMap.exists_initialPiece_of_ncard_le_three halfDisc_valid halfDisc_nonSiamese h0 hS
      (by rw [halfDisc_ncard_coloursAt_zero]; norm_num) hT₁ hT₂ hne⟩

end HadwigerNelson.Plane
