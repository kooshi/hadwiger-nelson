import Proofs.HadwigerNelson.Plane.ValidMap.Dense
import Proofs.HadwigerNelson.Plane.RingBand

/-!
# Row 134's base with unit arcs: the walk's leaves

The skeleton of `row134BaseUA`'s proof (job FS131-KB, `plans/FS131-w5base-kernel-plan.md`): FS112-N3-BASE's walk (`plans/FS112-N-proof.md`
stage N3-3; NB3 § 1.4 steps 1–12), which is `[SokolovVoronov2025]` Lemma 4's pigeonhole as FS110-CB D1–D6, FS110-CD Lemmas H, E, R and
Theorem D2, and FS110-CE's R1–R4 and Antipodal Lemma repaired it, with each use of Condition 5 replaced by a walked step. Everything is read
in the base's context `BaseCtx F u`: a valid six-coloured fragment covering `B̄(u, 2)`, `u` cubic trichromatic, `BaseHyp u` (H),
`NoInertNear u` and `UnenclosedC u` (FS131-E4's repair (b), inventory item 227) — the hypotheses of `Row134BaseUA`, which the walk refutes. So no statement here has a model (each is a step of a proof by
contradiction, refuted by `row134BaseUA`); the carrier `BaseCtx` is OUT of the vacuity scan.

The leaves, in the walk's order:
* **A — the pseudo-colouring of `ω(p)`** at a cubic trichromatic `p ∈ B̄(u, 1)`: nonempty, at most two colours, finitely many
  non-singleton points (`pseudo_nonempty`, `pseudo_ncard_le_two`, `pseudo_finite`), and the bridge to wave 3's `CircleColouring` with no swap
  point (`exists_pseudoCircle`; (i) is `pair_i`, the no-swap clause is `pair_ii` with `noBoth`).
* **B — circle-abstract**: the circle-only reduction (`reduce`, FS110-CD Lemma R step 5) and the selection (`select`: Lemma 5, BV-C6,
  Prop. 18 — BASE-V's BV-L5, BV-C6, BV-P18).
* **C — the planar core**: the returning arcs are removable and nest (`retArc_removable`, `retArcs_finite`, `retArcs_nested`), a
  non-returning change point has an endpoint (`exists_endpoint`: Prop. 19(b) with R1–R4 and Lemma E), and the eleventh point
  (`exists_eleventh`, proved from `BaseCtx.unenclosed` by FS131-E4's E4-RIM; KB's plan § 2.3 found it a GAP without that hypothesis: the
  sources obtain it after hole-filling, which can destroy `u`).
* **D — the refuters and distances**: `endpoint_dist_ge` (the `a`-side tiles), `vin_antipodal`, `eleventh_antipodal` (Theorem D2 / the
  Antipodal Lemma), `cor3_base` (FS112-N3-COR3 under H), `l3_base` (Lemma 3 in pseudo-colour form: the circles may carry in- and
  out-contact unit arcs, so wave 5's `bv_l3` with `RingProper` does not apply — plan § 2.2), `hex_base` (Prop. 17 through `p17_ua`).
* **E — the count**: `eleventh_type` (the complement of the eleventh point's type is an endpoint type).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ}

/-! ## The base's context -/

/-- **The base's context at `u`** (`Row134BaseUA`'s hypotheses, bundled): a valid six-coloured fragment covering `B̄(u, 2)`, `u` cubic
trichromatic, no point of `F(M) ∪ R(M)` in `B̄(u, 2)`, no inert unit arc centred within `1` of `u`, no tile of a colour of `u` enclosing a
tile at `u`. Refuted by `row134BaseUA`; every theorem of this file is a step of that refutation (no model expected). -/
structure BaseCtx (F : ArcMap 6) (u : ℂ) : Prop where
  /-- The fragment is valid. -/
  valid : F.Valid
  /-- It covers `B̄(u, 2)`. -/
  covers : F.Covers u 2
  /-- `u` is cubic trichromatic. -/
  cubic : F.IsCubicTrichromatic u
  /-- H: no point of `F(M) ∪ R(M)` in `B̄(u, 2)`. -/
  hyp : F.BaseHyp u
  /-- No inert unit arc centred within `1` of `u`. -/
  noInert : F.NoInertNear u
  /-- No tile of a colour of `u` encloses a tile at `u`. -/
  unenclosed : F.UnenclosedC u

/-- A point is **V-in** relative to `u` (FS110-CD § 2.3): a point of `ω(u)` some tile of whose colours carried at `u` meets `B(u, 1)`. -/
def VIn (F : ArcMap k) (u p : ℂ) : Prop :=
  dist p u = 1 ∧ ∃ i ∈ F.coloursAt u, ∃ T, F.TileOf i T ∧ p ∈ closure T ∧ (T ∩ ball u 1).Nonempty

/-- **An endpoint** for the change pair `{a, c}` at `x` (FS110-CD Lemma E, over the tiles, path-free): a three-colour point `p` in the
closures of the `a`-tile and the `c`-tile at `x`, inside `B(u, 1)` or V-in on `ω(u)`. -/
def IsEndpoint (F : ArcMap k) (u x : ℂ) (a c : Fin k) (p : ℂ) : Prop :=
  (F.coloursAt p).ncard = 3 ∧ (p ∈ ball u 1 ∨ F.VIn u p) ∧
    ∃ T₁ T₂, F.TileOf a T₁ ∧ F.TileOf c T₂ ∧ x ∈ closure T₁ ∧ x ∈ closure T₂ ∧ p ∈ closure T₁ ∧ p ∈ closure T₂

/-- **A returning pair** of `ω(u)` (FS110-CD Lemma R, `plans/FS110-CD-verification.md` § 2.4, l. 200: "a returning pair joined by `β` (an `a|c`
boundary path in the closed disc)"): two distinct change points `r(s)`, `r(t)` of the pseudo-colouring of `ω(u)`, `s < t < s + 60°`, switching
between the same two colours `a`, `c` (with `c` just inside `[s, t]` at both ends and `a` just outside), joined by an `a|c` boundary in the
closed disc — a connected set `K` holding both ends inside the closures of one `a`-tile and one `c`-tile and inside `B̄(u, 1)` (CD's `β`, read
as a continuum rather than a path). The clause `K` is FS131-I5's repair (inventory items 231–232): without it a single `a|c` boundary crossing
`ω(u)` at `0°`, `20°`, `40°` makes `[0°, 20°]` and `[20°, 40°]` both returning, abutting at `r(20°)`, and nesting (`retArcs_nested`) fails. -/
def IsRetArc (F : ArcMap k) (u : ℂ) (s t : ℝ) : Prop :=
  s < t ∧ t < s + π / 3 ∧ ∃ a c, a ≠ c ∧ F.GermPseudo u s .cw a ∧ F.GermPseudo u s .ccw c ∧ F.GermPseudo u t .cw c ∧
    F.GermPseudo u t .ccw a ∧ ∃ T₁ T₂, F.TileOf a T₁ ∧ F.TileOf c T₂ ∧
      ∃ K, IsConnected K ∧ ringPt u s ∈ K ∧ ringPt u t ∈ K ∧ K ⊆ closure T₁ ∩ closure T₂ ∩ closedBall u 1

end ArcMap

namespace CircleColouring

variable (C : CircleColouring)

/-- **A removable arc** of a circle colouring (FS110-CD Lemma R steps 2–3, circle-abstract): `[s, t]` of length under `60°`, both ends change
points with `c` just inside and `a ≠ c` just outside, and every partner `x ± 60°` of an inner point, off the change set, of the third colour. -/
def Removable (s t : ℝ) : Prop :=
  s < t ∧ t < s + π / 3 ∧ s ∈ C.S ∧ t ∈ C.S ∧ ∃ a c, a ≠ c ∧ C.LeftVal s a ∧ C.RightVal s c ∧ C.LeftVal t c ∧ C.RightVal t a ∧
    ∀ x ∈ Ioo s t, ∀ y, (y = x + π / 3 ∨ y = x - π / 3) → y ∉ C.S → C.c y ≠ a ∧ C.c y ≠ c

/-- The point `x` is a change point with the pair `{v, w}` (in either order). -/
def ChangeWith (x : ℝ) (v w : ZMod 3) : Prop :=
  x ∈ C.S ∧ ((C.LeftVal x v ∧ C.RightVal x w) ∨ (C.LeftVal x w ∧ C.RightVal x v))

/-- **The rotating hexagon** of a circle colouring: six change points at exact `60°` spacing, `b j` just before the `j`-th and `b (j + 1)` just
after (BV-C6's `n = 6` case; Prop. 17's configuration). -/
def IsHex (ψ : ℝ) (b : ZMod 3 → ZMod 3) : Prop :=
  Function.Injective b ∧ ∀ j : ℕ, j < 6 → C.LeftVal (ψ + j * (π / 3)) (b j) ∧ C.RightVal (ψ + j * (π / 3)) (b (j + 1))

/-- **The circle-only reduction** (FS110-CD Lemma R steps 4–5; CE's R3): recolouring each maximal arc of a finite, pairwise nested-or-disjoint
family of removable arcs by its outer colour leaves a circle colouring with no swap point, whose change points are change points of the
original outside the arcs' closed spans, with the same one-sided colours. Circle-abstract. -/
theorem reduce (hns : ∀ x, ¬ C.IsSwap x) (𝓙 : Set (ℝ × ℝ)) (hfin : 𝓙.Finite) (hrem : ∀ q ∈ 𝓙, C.Removable q.1 q.2)
    (hnest : ∀ q ∈ 𝓙, ∀ q' ∈ 𝓙, Disjoint (e '' Icc q.1 q.2) (e '' Icc q'.1 q'.2) ∨ e '' Icc q.1 q.2 ⊆ e '' Icc q'.1 q'.2 ∨
      e '' Icc q'.1 q'.2 ⊆ e '' Icc q.1 q.2) :
    ∃ C' : CircleColouring, (∀ x, ¬ C'.IsSwap x) ∧
      ∀ x ∈ C'.S, x ∈ C.S ∧ (∀ q ∈ 𝓙, e x ∉ e '' Icc q.1 q.2) ∧ ∀ v, (C'.LeftVal x v ↔ C.LeftVal x v) ∧ (C'.RightVal x v ↔ C.RightVal x v) := by
  sorry

/-- **The selection** (`[SokolovVoronov2025]` Lemma 5, BV-C6 and Prop. 18, as BASE-V § 1a.2–1a.3 and FS110-CD § 2.5 derived them): a circle
colouring with no swap point is the rotating hexagon, or for each pair of colours it has three change points with that pair, pairwise more than
`60°` apart (chords longer than `1`). Circle-abstract; Lemma 5's recolouring keeps each kept point's pair, so the points are the colouring's own. -/
theorem select (hns : ∀ x, ¬ C.IsSwap x) :
    (∃ ψ b, C.IsHex ψ b) ∨
      ∀ v w : ZMod 3, v ≠ w → ∃ x : Fin 3 → ℝ, (∀ i, C.ChangeWith (x i) v w) ∧ ∀ i j, i ≠ j → 1 < ‖e (x i) - e (x j)‖ := by
  sorry

end CircleColouring

namespace ArcMap

variable {F : ArcMap 6} {u : ℂ}

/-! ## A — the pseudo-colouring of `ω(p)` at a cubic trichromatic `p ∈ B̄(u, 1)` -/

/-- Under H a point of `B̄(u, 2)` with three colours is cubic trichromatic (no repeated colour: one sector per colour; K5b's child
`isCubicTrichromatic_of_three_of_noRep` with `BaseHyp`). -/
theorem BaseCtx.cubic_of_three (B : F.BaseCtx u) {x : ℂ} (hx : x ∈ closedBall u 2) (h3 : (F.coloursAt x).ncard = 3) :
    F.IsCubicTrichromatic x :=
  isCubicTrichromatic_of_three_of_noRep (B.covers hx) h3 fun hr =>
    Set.disjoint_left.mp B.hyp hx (Or.inr ⟨B.covers hx, hr⟩)

/-- **`c′ ≠ ∅`** on `ω(p)` (FS112-N3-3, "the pseudo-colouring"; NB3 step 3): a point of `ω(p)` with no colour outside `P_cl(p)` puts `ω(p)`
in `Γ` on both sides with both sides' colours in `P_cl(p)` — a both-kind arc centred at `p`, against `noBoth` and H. -/
theorem BaseCtx.pseudo_nonempty (B : F.BaseCtx u) {p : ℂ} (hp : p ∈ closedBall u 1) (hp3 : F.IsCubicTrichromatic p) {x : ℂ}
    (hx : dist x p = 1) : (F.pseudoColours p x).Nonempty := by
  sorry

/-- **`|c′| ≤ 2`** on `ω(p)` (FS112-N3-3; NB3 step 5): three pseudo-colours make `x` cubic trichromatic and complementary to `p` at distance
`1`; `cor3` then puts four colours at the rhombus corners, inside `B̄(u, 2)`, against H. -/
theorem BaseCtx.pseudo_ncard_le_two (B : F.BaseCtx u) {p : ℂ} (hp : p ∈ closedBall u 1) (hp3 : F.IsCubicTrichromatic p) {x : ℂ}
    (hx : dist x p = 1) : (F.pseudoColours p x).ncard ≤ 2 := by
  sorry

/-- **Finitely many non-singleton points** on `ω(p)` (FS112-N3-3; NB3 step 4): local finiteness on the compact `ω(p)`; an arc of `Γ` not on
`ω(p)` meets it in at most two points; an arc on `ω(p)` is in- or out-contact (a single pseudo-colour along its interior), never inert
(`NoInertNear`, `p ∈ B̄(u, 1)`) nor both-kind (`noBoth`, H). -/
theorem BaseCtx.pseudo_finite (B : F.BaseCtx u) {p : ℂ} (hp : p ∈ closedBall u 1) (hp3 : F.IsCubicTrichromatic p) :
    {θ | θ ∈ Ico 0 (2 * π) ∧ (F.pseudoColours p (ringPt p θ)).ncard ≠ 1}.Finite := by
  sorry

/-- **The bridge**: the pseudo-colouring of `ω(p)`, through an injection `g` of `ℤ/3` onto the colours absent at `p`, is a wave-3
`CircleColouring` whose one-sided values are the germs' pseudo-colours, whose change set holds only genuine changes, and which has no swap
point. (i) is `pair_i` (`u₁ = u₂ = p`); no swap is `pair_ii` at `x`, `σx` (FS112-N3-II) with `noBoth`, H and `pseudo_ncard_le_two` (or
`bv_nd1`); finiteness is `pseudo_finite`; local constancy at singletons is the closedness of `{z : a ∈ P_cl(z)}`. -/
theorem BaseCtx.exists_pseudoCircle (B : F.BaseCtx u) {p : ℂ} (hp : p ∈ closedBall u 1) (hp3 : F.IsCubicTrichromatic p) :
    ∃ (C : CircleColouring) (g : ZMod 3 → Fin 6), Function.Injective g ∧ (∀ v, g v ∉ F.coloursAt p) ∧
      (∀ θ v, C.LeftVal θ v ↔ F.GermPseudo p θ .cw (g v)) ∧ (∀ θ v, C.RightVal θ v ↔ F.GermPseudo p θ .ccw (g v)) ∧
      (∀ θ ∈ C.S, ¬ ∃ v, C.LeftVal θ v ∧ C.RightVal θ v) ∧ ∀ x, ¬ C.IsSwap x := by
  sorry

/-! ## C — the planar core (Prop. 19(b), the reduction's arcs, the eleventh point) -/

/-- **The (P) sweep**: in a valid map, a colour whose tile holds a point at distance exactly `1` from `y` is not carried at `y` (a point of its
class near `y`, translated, would sit in the tile at distance `1`). Any `k`. -/
theorem not_mem_coloursAt_of_tile_dist {k : ℕ} {F : ArcMap k} (hF : F.Valid) {a : Fin k} {T : Set ℂ} (hT : F.TileOf a T) {t y : ℂ}
    (ht : t ∈ T) (h1 : dist t y = 1) : a ∉ F.coloursAt y := by
  intro hay
  obtain ⟨δ, hδ, hδT⟩ := Metric.isOpen_iff.mp hT.1.isOpen t ht
  obtain ⟨y', hy', hy'd⟩ := Metric.mem_closure_iff.mp hay δ hδ
  have hmem : t + (y' - y) ∈ T := hδT (by rw [mem_ball, dist_eq_norm, add_sub_cancel_left, ← dist_eq_norm, dist_comm]; exact hy'd)
  refine hF _ (hT.1.subset_interiorPts hmem) y' hy'.1 ?_ (by rw [hT.2 hmem, hy'.2])
  rw [dist_eq_norm, show t + (y' - y) - y' = t - y by ring, ← dist_eq_norm, h1]

/-- A tile whose closure holds points inside and outside `B̄(y, 1)` holds a point at distance exactly `1` from `y`. -/
theorem IsTile.exists_dist_eq_one {k : ℕ} {F : ArcMap k} {T : Set ℂ} (hT : F.IsTile T) {x₁ x₂ y : ℂ} (h₁ : x₁ ∈ closure T)
    (h₂ : x₂ ∈ closure T) (hd₁ : dist x₁ y < 1) (hd₂ : 1 < dist x₂ y) : ∃ t ∈ T, dist t y = 1 := by
  obtain ⟨t₁, ht₁, ht₁d⟩ := Metric.mem_closure_iff.mp h₁ (1 - dist x₁ y) (by linarith)
  obtain ⟨t₂, ht₂, ht₂d⟩ := Metric.mem_closure_iff.mp h₂ (dist x₂ y - 1) (by linarith)
  have e₁ : dist t₁ y < 1 := by have := dist_triangle t₁ x₁ y; rw [dist_comm] at ht₁d; linarith
  have e₂ : 1 < dist t₂ y := by have := dist_triangle x₂ t₂ y; linarith
  have hpre : IsPreconnected ((fun z => dist z y) '' T) := hT.isPreconnected.image _ (continuous_id.dist continuous_const).continuousOn
  obtain ⟨t, ht, h1⟩ := hpre.Icc_subset ⟨t₁, ht₁, rfl⟩ ⟨t₂, ht₂, rfl⟩ ⟨e₁.le, e₂.le⟩
  exact ⟨t, ht, h1⟩

/-- A germ has one pseudo-colour. -/
theorem germPseudo_unique {k : ℕ} {F : ArcMap k} {u : ℂ} {θ : ℝ} {s : Side} {a a' : Fin k} (h : F.GermPseudo u θ s a)
    (h' : F.GermPseudo u θ s a') : a = a' := by
  obtain ⟨δ, hδ, hsub⟩ := h
  obtain ⟨δ', hδ', hsub'⟩ := h'
  have hm : ringPt u (θ + s.sign * (min δ δ' / 2)) ∈ germ u θ s (min δ δ') :=
    ⟨min δ δ' / 2, ⟨by positivity, by linarith [lt_min hδ hδ']⟩, rfl⟩
  have h1 := hsub (germ_mono (min_le_left _ _) hm)
  have h2 := hsub' (germ_mono (min_le_right _ _) hm)
  simp only [mem_setOf_eq] at h1 h2
  rw [h1] at h2
  exact Set.singleton_injective h2

/-- **The returning arcs are removable** (FS110-CD Lemma R step 3): for `x` inside a returning arc and `y = r(x ± 60°)`, `ω(y)` crosses `ω(u)`
only at `x` within the arc, so it separates its ends; the `a`-tile and the `c`-tile, connected with both ends in their closures (through `K`),
meet `ω(y)`, so neither colour is at `y` (the (P) sweep) and `c′(y)` is the third colour. The colour pattern at the ends is in `IsRetArc`. -/
theorem BaseCtx.retArc_partner (B : F.BaseCtx u) {s t : ℝ} (hR : F.IsRetArc u s t) {x : ℝ} (hx : x ∈ Ioo s t) {a c : Fin 6}
    (ha : F.GermPseudo u s .cw a) (hc : F.GermPseudo u s .ccw c) (y : ℝ) (hy : y = x + π / 3 ∨ y = x - π / 3) :
    a ∉ F.pseudoColours u (ringPt u y) ∧ c ∉ F.pseudoColours u (ringPt u y) := by
  obtain ⟨hst, hst', a', c', -, ha', hc', -, -, T₁, T₂, hT₁, hT₂, K, -, hsK, htK, hKsub⟩ := hR
  obtain rfl := germPseudo_unique ha' ha
  obtain rfl := germPseudo_unique hc' hc
  obtain ⟨hx1, hx2⟩ := hx
  -- `r(s)` and `r(t)` on opposite sides of `ω(r(y))`
  have hfar : ∃ x₁ x₂, (x₁ = ringPt u s ∨ x₁ = ringPt u t) ∧ (x₂ = ringPt u s ∨ x₂ = ringPt u t) ∧
      dist x₁ (ringPt u y) < 1 ∧ 1 < dist x₂ (ringPt u y) := by
    rcases hy with rfl | rfl
    · refine ⟨_, _, Or.inr rfl, Or.inl rfl, ?_, ?_⟩
      · refine ((dist_ringPt_ringPt_cmp_one u ?_).2.1).mpr ?_ <;> rw [abs_of_neg (by linarith)] <;> linarith [Real.pi_pos]
      · refine ((dist_ringPt_ringPt_cmp_one u ?_).2.2).mpr ?_ <;> rw [abs_of_neg (by linarith)] <;> linarith [Real.pi_pos]
    · refine ⟨_, _, Or.inl rfl, Or.inr rfl, ?_, ?_⟩
      · refine ((dist_ringPt_ringPt_cmp_one u ?_).2.1).mpr ?_ <;> rw [abs_of_pos (by linarith)] <;> linarith [Real.pi_pos]
      · refine ((dist_ringPt_ringPt_cmp_one u ?_).2.2).mpr ?_ <;> rw [abs_of_pos (by linarith)] <;> linarith [Real.pi_pos]
  obtain ⟨x₁, x₂, hx₁, hx₂, hd₁, hd₂⟩ := hfar
  have hcl : ∀ {z}, (z = ringPt u s ∨ z = ringPt u t) → z ∈ closure T₁ ∧ z ∈ closure T₂ := by
    rintro z (rfl | rfl)
    · exact (hKsub hsK).1
    · exact (hKsub htK).1
  obtain ⟨t₁, ht₁, ht₁d⟩ := hT₁.1.exists_dist_eq_one (hcl hx₁).1 (hcl hx₂).1 hd₁ hd₂
  obtain ⟨t₂, ht₂, ht₂d⟩ := hT₂.1.exists_dist_eq_one (hcl hx₁).2 (hcl hx₂).2 hd₁ hd₂
  exact ⟨fun h => not_mem_coloursAt_of_tile_dist B.valid hT₁ ht₁ ht₁d h.1,
    fun h => not_mem_coloursAt_of_tile_dist B.valid hT₂ ht₂ ht₂d h.1⟩

/-- **Finitely many returning arcs** (FS110-CD Lemma R): their ends are change points of the pseudo-colouring, finitely many per period. -/
theorem BaseCtx.retArcs_finite (B : F.BaseCtx u) :
    {q : ℝ × ℝ | q.1 ∈ Ico 0 (2 * π) ∧ F.IsRetArc u q.1 q.2}.Finite := by
  sorry

/-- **The returning arcs nest or are disjoint** (FS110-CB D5 item 1, "paths do not cross; their arcs nest or are disjoint"; FS110-CD Lemma R
step 4) — **planar core**: interleaved ends would make the `a`-tile of one pair cross the boundary of the other's tiles away from a
four-colour point, and abutting ends would need two inner `a|c` germs at one point of `ω(u)` (each point there has at most three colours, one
sector each, under H, and an `a|c` germ along `ω(u)` is an inert arc, excluded by `NoInertNear`) — the joining continua `K` of `IsRetArc` carry
this. Planned over the finite boundary graph of the disc (plan § 4, leaf C3). -/
theorem BaseCtx.retArcs_nested (B : F.BaseCtx u) {s t s' t' : ℝ} (h : F.IsRetArc u s t) (h' : F.IsRetArc u s' t') :
    Disjoint (ringArc u s t) (ringArc u s' t') ∨ ringArc u s t ⊆ ringArc u s' t' ∨ ringArc u s' t' ⊆ ringArc u s t := by
  sorry

/-- **A non-returning change point has an endpoint** (`[SokolovVoronov2025]` Prop. 19(b) as FS110-CD Lemma E and FS110-CE R1–R4 repaired it,
path-free in its conclusion) — **planar core**: a change point `r(θ)` of the pseudo-colouring of `ω(u)` with pair `{a, c}`, outside every returning
arc (CD's sense: `IsRetArc` carries the joining `a|c` continuum in the closed disc, inventory item 232), has an
endpoint: the `a|c` boundary from it, continued through spikes, ends at a three-colour point of `B(u, 1)` or at a V-in vertex of `ω(u)`, in the
closures of the two tiles at `r(θ)`. Planned over the finite boundary graph (the handshake lemma, plan § 4, leaf C4). -/
theorem BaseCtx.exists_endpoint (B : F.BaseCtx u) {θ : ℝ} {a c : Fin 6} (hac : a ≠ c) (ha : F.GermPseudo u θ .cw a)
    (hc : F.GermPseudo u θ .ccw c ∨ (F.GermPseudo u θ .cw c ∧ F.GermPseudo u θ .ccw a))
    (hout : ∀ s t, F.IsRetArc u s t → ringPt u θ ∉ ringArc u s t) :
    ∃ p, F.IsEndpoint u (ringPt u θ) a c p := by
  sorry

/-- **The eleventh point** (`[SokolovVoronov2025]` p. 28, "on the boundary of the union of three regions … whose vertex is `u`, there is at
least one more trichromatic point"; FS110-CD § 2.6; FS112-N3-3) — proved from `B.unenclosed` (FS131-E4 E4-RIM, `plans/FS131-E4-derivation.md`
§ Argument for E4-RIM: the outer frontier of `u`'s `P_cl(u)`-component is connected and borders two of its tiles, since a lone bordering tile would
enclose `u`'s other tiles). Every printed source obtains it after hole-filling, which in the local base can destroy `u` (KB's plan § 2.3); the
hypothesis `UnenclosedC u` replaces that step. A three-colour point of `B̄(u, 1)` carrying exactly two colours of `u`, whose tiles of those
colours lie in `B(u, 1)`. -/
theorem BaseCtx.exists_eleventh (B : F.BaseCtx u) :
    ∃ q ∈ closedBall u 1, (F.coloursAt q).ncard = 3 ∧ (F.coloursAt q ∩ F.coloursAt u).ncard = 2 ∧
      ∀ j ∈ F.coloursAt q ∩ F.coloursAt u, ∀ T, F.TileOf j T → q ∈ closure T → T ⊆ ball u 1 := by
  sorry

/-! ## D — the refuters and the distances -/

/-- **Endpoints of one pair are at least `1` apart** (FS110-CB D5 item 6; FS110-CD § 2.8 item 1): two points `x₁`, `x₂` more than `1` apart
in the closures of `a`-tiles `T₁`, `T₂` (distinct, since a tile has diameter below `1`, and then all cross distances exceed `1` by validity and
connectedness), so points `p₁`, `p₂` of those closures are at least `1` apart. Any `k`, no base context. -/
theorem endpoint_dist_ge {k : ℕ} {F : ArcMap k} (hF : F.Valid) {a : Fin k} {T₁ T₂ : Set ℂ} (h₁ : F.TileOf a T₁) (h₂ : F.TileOf a T₂)
    {x₁ x₂ p₁ p₂ : ℂ} (hx₁ : x₁ ∈ closure T₁) (hx₂ : x₂ ∈ closure T₂) (hp₁ : p₁ ∈ closure T₁) (hp₂ : p₂ ∈ closure T₂)
    (hx : 1 < dist x₁ x₂) : 1 ≤ dist p₁ p₂ := by
  -- no pair of the two tiles is at distance `1` (one colour, validity)
  have hne : ∀ s ∈ T₁, ∀ t ∈ T₂, dist s t ≠ 1 := fun s hs t ht h1 =>
    hF s (h₁.1.subset_interiorPts hs) t (h₂.1.subset_interiorPts ht) h1 (by rw [h₁.2 hs, h₂.2 ht])
  -- a pair near `(x₁, x₂)` is farther than `1`
  set δ := (dist x₁ x₂ - 1) / 2 with hδ
  have hδ0 : 0 < δ := by rw [hδ]; linarith
  obtain ⟨s₀, hs₀, hs₀d⟩ := Metric.mem_closure_iff.mp hx₁ δ hδ0
  obtain ⟨t₀, ht₀, ht₀d⟩ := Metric.mem_closure_iff.mp hx₂ δ hδ0
  have hfar : 1 < dist s₀ t₀ := by
    have := dist_triangle4 x₁ s₀ t₀ x₂
    rw [dist_comm t₀ x₂] at this
    linarith
  -- so every pair is farther than `1` (the distances over the connected `T₁ × T₂` form an interval missing `1`)
  have hpre : IsPreconnected ((fun q : ℂ × ℂ => dist q.1 q.2) '' (T₁ ×ˢ T₂)) :=
    (h₁.1.isPreconnected.prod h₂.1.isPreconnected).image _ (continuous_fst.dist continuous_snd).continuousOn
  have hall : ∀ q ∈ T₁ ×ˢ T₂, 1 ≤ dist q.1 q.2 := by
    rintro ⟨s, t⟩ ⟨hs, ht⟩
    by_contra hlt
    push Not at hlt
    obtain ⟨q, hq, hq1⟩ := hpre.Icc_subset ⟨(s, t), ⟨hs, ht⟩, rfl⟩ ⟨(s₀, t₀), ⟨hs₀, ht₀⟩, rfl⟩ ⟨hlt.le, hfar.le⟩
    exact hne q.1 hq.1 q.2 hq.2 hq1
  -- and on the closures
  have hcl : closure (T₁ ×ˢ T₂) ⊆ {q : ℂ × ℂ | 1 ≤ dist q.1 q.2} :=
    closure_minimal hall (isClosed_le continuous_const (continuous_fst.dist continuous_snd))
  rw [closure_prod_eq] at hcl
  exact hcl (show (p₁, p₂) ∈ closure T₁ ×ˢ closure T₂ from ⟨hp₁, hp₂⟩)

/-- **A point of a colour's class within `1` of a tile of that colour stays within `1` of all of it** (Lemma H's distance step, FS110-CD § 2.3):
in a valid map, if `s` lies in the class of `i` and within distance `1` of a point of an `i`-tile `T`, then every point of the closure of `T` is
within distance `1` of `s` (the distances from `s` over the connected `T` form an interval that misses `1`). Any `k`, no base context. -/
theorem dist_le_one_of_mem_region {k : ℕ} {F : ArcMap k} (hF : F.Valid) {i : Fin k} {T : Set ℂ} (hT : F.TileOf i T) {s t₀ : ℂ}
    (hs : s ∈ F.region i) (ht₀ : t₀ ∈ T) (hst : dist s t₀ < 1) {q : ℂ} (hq : q ∈ closure T) : dist s q ≤ 1 := by
  have hne : ∀ t ∈ T, dist s t ≠ 1 := fun t ht h1 =>
    hF s hs.1 t (hT.1.subset_interiorPts ht) h1 (by rw [hs.2, hT.2 ht])
  have hpre : IsPreconnected ((fun t : ℂ => dist s t) '' T) :=
    hT.1.isPreconnected.image _ (continuous_const.dist continuous_id).continuousOn
  have hall : ∀ t ∈ T, dist s t ≤ 1 := by
    intro t ht
    by_contra hlt
    push Not at hlt
    obtain ⟨y, hy, hy1⟩ := hpre.Icc_subset ⟨t₀, ht₀, rfl⟩ ⟨t, ht, rfl⟩ ⟨hst.le, hlt.le⟩
    exact hne y hy hy1
  exact closure_minimal hall (isClosed_le (continuous_const.dist continuous_id) continuous_const) hq

/-- Real arithmetic for `eq_of_dist_le_one_antipodal`: two antipodal unit vectors `a`, `b` and a vector `w` within `1` of both: `w = 0`
(`b = −a`, and the parallelogram law gives `2|w|² + 2 ≤ 2`). -/
theorem antipodal_aux {a1 a2 b1 b2 w1 w2 : ℝ} (h1 : a1 ^ 2 + a2 ^ 2 = 1) (h2 : b1 ^ 2 + b2 ^ 2 = 1)
    (h3 : (a1 - b1) ^ 2 + (a2 - b2) ^ 2 = 4) (h4 : (w1 - a1) ^ 2 + (w2 - a2) ^ 2 ≤ 1) (h5 : (w1 - b1) ^ 2 + (w2 - b2) ^ 2 ≤ 1) :
    w1 = 0 ∧ w2 = 0 := by
  have hs : (a1 + b1) ^ 2 + (a2 + b2) ^ 2 = 0 := by linear_combination 2 * h1 + 2 * h2 - h3
  have hb1 : a1 + b1 = 0 := by nlinarith [sq_nonneg (a1 + b1), sq_nonneg (a2 + b2)]
  have hb2 : a2 + b2 = 0 := by nlinarith [sq_nonneg (a1 + b1), sq_nonneg (a2 + b2)]
  have hb1' : b1 = -a1 := by linarith
  have hb2' : b2 = -a2 := by linarith
  subst hb1' hb2'
  have hw : w1 ^ 2 + w2 ^ 2 ≤ 0 := by nlinarith
  exact ⟨by nlinarith [sq_nonneg w1, sq_nonneg w2], by nlinarith [sq_nonneg w1, sq_nonneg w2]⟩

/-- The closed unit discs about two antipodal points of `ω(u)` meet only at `u`. -/
theorem eq_of_dist_le_one_antipodal {u p p' s : ℂ} (hp : dist p u = 1) (hp' : dist p' u = 1) (h2 : dist p p' = 2)
    (hs : dist s p ≤ 1) (hs' : dist s p' ≤ 1) : s = u := by
  have sq : ∀ z w : ℂ, dist z w ^ 2 = (z.re - w.re) ^ 2 + (z.im - w.im) ^ 2 := fun z w => by
    rw [Complex.dist_eq_re_im, Real.sq_sqrt (by positivity)]
  have e1 := sq p u; rw [hp, one_pow] at e1
  have e2 := sq p' u; rw [hp', one_pow] at e2
  have e3 := sq p p'; rw [h2] at e3
  have e4 : dist s p ^ 2 ≤ 1 := by nlinarith [dist_nonneg (x := s) (y := p)]
  have e5 : dist s p' ^ 2 ≤ 1 := by nlinarith [dist_nonneg (x := s) (y := p')]
  rw [sq] at e4 e5
  obtain ⟨w1, w2⟩ := antipodal_aux (a1 := p.re - u.re) (a2 := p.im - u.im) (b1 := p'.re - u.re) (b2 := p'.im - u.im)
    (w1 := s.re - u.re) (w2 := s.im - u.im) e1.symm e2.symm
    (by rw [show (2 : ℝ) ^ 2 = 4 by norm_num] at e3; linear_combination -e3)
    (by linear_combination e4) (by linear_combination e5)
  exact Complex.ext (by linarith) (by linarith)

/-- An open set containing a point `u` of `ℂ`, or meeting every ball about it, holds a point other than `u` near `u`: a point of the class of
a colour carried at `u`, distinct from `u`, within any `ε > 0`. -/
theorem exists_mem_region_ne {k : ℕ} {F : ArcMap k} {u : ℂ} {i : Fin k} (hi : i ∈ F.coloursAt u) {ε : ℝ} (hε : 0 < ε) :
    ∃ s ∈ F.region i, s ≠ u ∧ dist s u < ε := by
  obtain ⟨s₀, hs₀, hs₀d⟩ := Metric.mem_closure_iff.mp hi ε hε
  have hopen : IsOpen (F.region i ∩ ball u ε) := (F.isOpen_region i).inter isOpen_ball
  have hs₀' : s₀ ∈ F.region i ∩ ball u ε := ⟨hs₀, by rw [mem_ball, dist_comm]; exact hs₀d⟩
  obtain ⟨δ, hδ, hδs⟩ := Metric.isOpen_iff.mp hopen s₀ hs₀'
  by_cases hsu : s₀ = u
  · subst hsu
    have hm : s₀ + ((δ / 2 : ℝ) : ℂ) ∈ ball s₀ δ := by
      rw [mem_ball, dist_eq_norm, add_sub_cancel_left, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by positivity)]
      linarith
    refine ⟨_, (hδs hm).1, fun h => ?_, (hδs hm).2⟩
    have : ((δ / 2 : ℝ) : ℂ) = 0 := by linear_combination h
    have : (δ / 2 : ℝ) = 0 := by exact_mod_cast this
    linarith
  · exact ⟨s₀, hs₀, hsu, hs₀'.2⟩

/-- **A tile of each colour carried at a point** of the domain has the point in its closure (through the sector chart: a point of the class
near the base lies in a sector, which lies in a tile). -/
theorem exists_tileOf_of_mem_coloursAt {k : ℕ} {F : ArcMap k} {q : ℂ} (hq : q ∈ F.dom) {j : Fin k} (hj : j ∈ F.coloursAt q) :
    ∃ T, F.TileOf j T ∧ q ∈ closure T := by
  obtain ⟨r, hr, hrpos⟩ := ((exists_sector_of_mem hq).and self_mem_nhdsWithin).exists
  obtain ⟨p, hp, hpd⟩ := Metric.mem_closure_iff.mp hj r hrpos
  obtain ⟨S, hS, hpS⟩ := hr p ⟨hp.1, by rw [mem_ball, dist_comm]; exact hpd⟩
  have hSj : S ∈ F.sectorsOf q r j :=
    ⟨hS, fun z hz => ((hS.subset_region hpS hz).2 : F.col z = F.col p).trans hp.2⟩
  obtain ⟨X, hX, -, hqX⟩ := sector_subset_tile hSj
  exact ⟨X, hX, hqX⟩

/-- Squared distances in coordinates. -/
theorem dist_sq_re_im (z w : ℂ) : dist z w ^ 2 = (z.re - w.re) ^ 2 + (z.im - w.im) ^ 2 := by
  rw [Complex.dist_eq_re_im, Real.sq_sqrt (by positivity)]

/-- Real arithmetic: two antipodal unit vectors `a`, `b` (`|a − b| = 2`) satisfy `b = −a`. -/
theorem antipodal_neg {a1 a2 b1 b2 : ℝ} (h1 : a1 ^ 2 + a2 ^ 2 = 1) (h2 : b1 ^ 2 + b2 ^ 2 = 1)
    (h3 : (a1 - b1) ^ 2 + (a2 - b2) ^ 2 = 4) : b1 = -a1 ∧ b2 = -a2 := by
  have hs : (a1 + b1) ^ 2 + (a2 + b2) ^ 2 = 0 := by linear_combination 2 * h1 + 2 * h2 - h3
  have hb1 : a1 + b1 = 0 := by nlinarith [sq_nonneg (a1 + b1), sq_nonneg (a2 + b2)]
  have hb2 : a2 + b2 = 0 := by nlinarith [sq_nonneg (a1 + b1), sq_nonneg (a2 + b2)]
  exact ⟨by linarith, by linarith⟩

/-- **The cusp between two tangent unit discs**: for antipodal `q`, `p` on `ω(u)` and any `ε > 0`, some point within `ε` of `u` is farther than `1`
from both (`u + (ε/2) i (q − u)`, at distance `√(1 + ε²/4)` from each). -/
theorem exists_near_far_antipodal {u q p : ℂ} (hq : dist q u = 1) (hp : dist p u = 1) (h2 : dist q p = 2) {ε : ℝ} (hε : 0 < ε) :
    ∃ z₀ : ℂ, dist z₀ u < ε ∧ 1 < dist z₀ q ∧ 1 < dist z₀ p := by
  have e1 := dist_sq_re_im q u; rw [hq, one_pow] at e1
  have e2 := dist_sq_re_im p u; rw [hp, one_pow] at e2
  have e3 := dist_sq_re_im q p; rw [h2] at e3
  obtain ⟨hb1, hb2⟩ := antipodal_neg (a1 := q.re - u.re) (a2 := q.im - u.im) (b1 := p.re - u.re) (b2 := p.im - u.im)
    e1.symm e2.symm (by linear_combination -e3)
  have hpre : p.re = u.re - (q.re - u.re) := by linarith
  have hpim : p.im = u.im - (q.im - u.im) := by linarith
  refine ⟨⟨u.re - ε / 2 * (q.im - u.im), u.im + ε / 2 * (q.re - u.re)⟩, ?_, ?_, ?_⟩
  · have h : dist (⟨u.re - ε / 2 * (q.im - u.im), u.im + ε / 2 * (q.re - u.re)⟩ : ℂ) u ^ 2 = (ε / 2) ^ 2 := by
      rw [dist_sq_re_im]
      show (u.re - ε / 2 * (q.im - u.im) - u.re) ^ 2 + (u.im + ε / 2 * (q.re - u.re) - u.im) ^ 2 = (ε / 2) ^ 2
      linear_combination (ε / 2) ^ 2 * e1.symm
    nlinarith [dist_nonneg (x := (⟨u.re - ε / 2 * (q.im - u.im), u.im + ε / 2 * (q.re - u.re)⟩ : ℂ)) (y := u)]
  · have h : dist (⟨u.re - ε / 2 * (q.im - u.im), u.im + ε / 2 * (q.re - u.re)⟩ : ℂ) q ^ 2 = 1 + (ε / 2) ^ 2 := by
      rw [dist_sq_re_im]
      show (u.re - ε / 2 * (q.im - u.im) - q.re) ^ 2 + (u.im + ε / 2 * (q.re - u.re) - q.im) ^ 2 = 1 + (ε / 2) ^ 2
      linear_combination (1 + (ε / 2) ^ 2) * e1.symm
    nlinarith [dist_nonneg (x := (⟨u.re - ε / 2 * (q.im - u.im), u.im + ε / 2 * (q.re - u.re)⟩ : ℂ)) (y := q)]
  · have h : dist (⟨u.re - ε / 2 * (q.im - u.im), u.im + ε / 2 * (q.re - u.re)⟩ : ℂ) p ^ 2 = 1 + (ε / 2) ^ 2 := by
      rw [dist_sq_re_im]
      show (u.re - ε / 2 * (q.im - u.im) - p.re) ^ 2 + (u.im + ε / 2 * (q.re - u.re) - p.im) ^ 2 = 1 + (ε / 2) ^ 2
      rw [hpre, hpim]
      linear_combination (1 + (ε / 2) ^ 2) * e1.symm
    nlinarith [dist_nonneg (x := (⟨u.re - ε / 2 * (q.im - u.im), u.im + ε / 2 * (q.re - u.re)⟩ : ℂ)) (y := p)]

/-- **No two V-in points of one colour of `u` are antipodal** (FS110-CD Theorem D2 (i); FS110-CE's Antipodal Lemma): their tiles of that
colour lie in `B̄(p, 1) ∩ B̄(p′, 1) = {u}` (Lemma H(b)), against openness. -/
theorem BaseCtx.vin_antipodal (B : F.BaseCtx u) {p p' : ℂ} {i : Fin 6} (hi : i ∈ F.coloursAt u)
    (hp : dist p u = 1) (hp' : dist p' u = 1) (hpi : ∃ T, F.TileOf i T ∧ p ∈ closure T ∧ (T ∩ ball u 1).Nonempty)
    (hpi' : ∃ T, F.TileOf i T ∧ p' ∈ closure T ∧ (T ∩ ball u 1).Nonempty) : dist p p' ≠ 2 := by
  intro h2
  obtain ⟨T, hT, hpT, t₀, ht₀T, ht₀u⟩ := hpi
  obtain ⟨T', hT', hpT', t₀', ht₀T', ht₀u'⟩ := hpi'
  rw [mem_ball] at ht₀u ht₀u'
  have hε : 0 < min (1 - dist t₀ u) (1 - dist t₀' u) := lt_min (by linarith) (by linarith)
  obtain ⟨s, hs, hsu, hsd⟩ := exists_mem_region_ne hi hε
  have h1 : dist s t₀ < 1 := by
    have := dist_triangle s u t₀; rw [dist_comm u t₀] at this
    linarith [min_le_left (1 - dist t₀ u) (1 - dist t₀' u)]
  have h1' : dist s t₀' < 1 := by
    have := dist_triangle s u t₀'; rw [dist_comm u t₀'] at this
    linarith [min_le_right (1 - dist t₀ u) (1 - dist t₀' u)]
  exact hsu (eq_of_dist_le_one_antipodal hp hp' h2 (dist_le_one_of_mem_region B.valid hT hs ht₀T h1 hpT)
    (dist_le_one_of_mem_region B.valid hT' hs ht₀T' h1' hpT'))

/-- **The eleventh point is not antipodal to a complementary V-in endpoint** (FS110-CD Theorem D2 (ii)): the cusps `u + t·e⊥` between the two
tangent discs meet none of `u`'s three tiles, against the sector picture at `u`. -/
theorem BaseCtx.eleventh_antipodal (B : F.BaseCtx u) {q p : ℂ} (hq : dist q u = 1)
    (hqT : ∀ j ∈ F.coloursAt q ∩ F.coloursAt u, ∀ T, F.TileOf j T → q ∈ closure T → T ⊆ ball u 1)
    (hq2 : (F.coloursAt q ∩ F.coloursAt u).ncard = 2) (hp : F.VIn u p) (hdis : Disjoint (F.coloursAt q) (F.coloursAt p)) :
    dist q p ≠ 2 := by
  intro h2
  obtain ⟨hpu, i, hiu, T, hT, hpT, t₀, ht₀T, ht₀u⟩ := hp
  rw [mem_ball] at ht₀u
  have hdom : ∀ {z : ℂ}, dist z u ≤ 2 → z ∈ F.dom := fun hz => B.covers (by rw [mem_closedBall]; exact hz)
  -- `i` is `u`'s colour off `q`, and every colour of `u` is `i` or one of `q`'s
  have hip : i ∈ F.coloursAt p :=
    closure_mono (show T ⊆ F.region i from fun z hz => ⟨hT.1.subset_interiorPts hz, hT.2 hz⟩) hpT
  have hiq : i ∉ F.coloursAt q := fun h => Set.disjoint_left.mp hdis h hip
  have hdiff : (F.coloursAt u \ F.coloursAt q).ncard = 1 := by
    have := Set.ncard_inter_add_ncard_sdiff_eq_ncard (F.coloursAt u) (F.coloursAt q) (Set.toFinite _)
    rw [Set.inter_comm, hq2, B.cubic.2] at this
    omega
  have hcol : ∀ c ∈ F.coloursAt u, c = i ∨ c ∈ F.coloursAt q ∩ F.coloursAt u := by
    intro c hc
    by_cases hcq : c ∈ F.coloursAt q
    · exact Or.inr ⟨hcq, hc⟩
    · left
      obtain ⟨a, ha⟩ := Set.ncard_eq_one.mp hdiff
      have h1 : c ∈ F.coloursAt u \ F.coloursAt q := ⟨hc, hcq⟩
      have h2 : i ∈ F.coloursAt u \ F.coloursAt q := ⟨hiu, hiq⟩
      rw [ha] at h1 h2
      exact h1.trans h2.symm
  -- the two colours shared with `q`, each with a tile at `q` inside `B(u, 1)`
  obtain ⟨j₁, j₂, hj12, hJ⟩ := Set.ncard_eq_two.mp hq2
  have hqdom : q ∈ F.dom := hdom (by rw [hq]; norm_num)
  have htile : ∀ j ∈ F.coloursAt q ∩ F.coloursAt u, ∃ T', F.TileOf j T' ∧ q ∈ closure T' ∧ ∃ t ∈ T', dist t u < 1 := by
    intro j hj
    obtain ⟨T', hT', hqT'⟩ := exists_tileOf_of_mem_coloursAt hqdom hj.1
    obtain ⟨t, ht⟩ := hT'.1.nonempty
    exact ⟨T', hT', hqT', t, ht, mem_ball.mp (hqT j hj T' hT' hqT' ht)⟩
  obtain ⟨T₁, hT₁, hqT₁, t₁, ht₁, ht₁u⟩ := htile j₁ (by rw [hJ]; simp)
  obtain ⟨T₂, hT₂, hqT₂, t₂, ht₂, ht₂u⟩ := htile j₂ (by rw [hJ]; simp)
  -- a radius inside which every interior point carries a colour of `u`, and all three tiles reach
  obtain ⟨r₀, hr₀, hr₀pos⟩ := ((eventually_col_mem_coloursAt u).and self_mem_nhdsWithin).exists
  have hr₀pos' : 0 < r₀ := hr₀pos
  set ε := min (min (1 - dist t₀ u) (1 - dist t₁ u)) (min (1 - dist t₂ u) r₀) with hεdef
  have hε : 0 < ε := lt_min (lt_min (by linarith) (by linarith)) (lt_min (by linarith) hr₀pos')
  have hε0 : ε ≤ 1 - dist t₀ u := (min_le_left _ _).trans (min_le_left _ _)
  have hε1 : ε ≤ 1 - dist t₁ u := (min_le_left _ _).trans (min_le_right _ _)
  have hε2 : ε ≤ 1 - dist t₂ u := (min_le_right _ _).trans (min_le_left _ _)
  have hεr : ε ≤ r₀ := (min_le_right _ _).trans (min_le_right _ _)
  have hε1' : ε ≤ 1 := hε0.trans (by linarith [dist_nonneg (x := t₀) (y := u)])
  obtain ⟨z₀, hz₀u, hz₀q, hz₀p⟩ := exists_near_far_antipodal hq hpu h2 hε
  -- an interior point of the map near `z₀` with the same three properties
  have hU : IsOpen {z : ℂ | dist z u < ε ∧ 1 < dist z q ∧ 1 < dist z p} :=
    (isOpen_lt (continuous_id.dist continuous_const) continuous_const).inter
      ((isOpen_lt continuous_const (continuous_id.dist continuous_const)).inter
        (isOpen_lt continuous_const (continuous_id.dist continuous_const)))
  have hz₀dom : z₀ ∈ F.dom := hdom (by linarith)
  obtain ⟨z, ⟨hzu, hzq, hzp⟩, hzI⟩ := mem_closure_iff.mp (F.dense_interiorPts hz₀dom) _ hU ⟨hz₀u, hz₀q, hz₀p⟩
  have hzc : F.col z ∈ F.coloursAt u := hr₀ z ⟨hzI, mem_ball.mpr (hzu.trans_le hεr)⟩
  have hzr : z ∈ F.region (F.col z) := ⟨hzI, rfl⟩
  have hnear : ∀ t, dist t u < 1 → dist t u + ε ≤ 1 → dist z t < 1 := fun t _ ht => by
    have := dist_triangle z u t; rw [dist_comm u t] at this; linarith
  rcases hcol _ hzc with hci | hcq
  · rw [hci] at hzr
    have := dist_le_one_of_mem_region B.valid hT hzr ht₀T (hnear t₀ ht₀u (by linarith)) hpT
    linarith
  · rw [hJ] at hcq
    rcases hcq with hc1 | hc1
    · rw [hc1] at hzr
      have := dist_le_one_of_mem_region B.valid hT₁ hzr ht₁ (hnear t₁ ht₁u (by linarith)) hqT₁
      linarith
    · rw [mem_singleton_iff] at hc1
      rw [hc1] at hzr
      have := dist_le_one_of_mem_region B.valid hT₂ hzr ht₂ (hnear t₂ ht₂u (by linarith)) hqT₂
      linarith

/-- **Corollary 3 under H** (FS112-N3-COR3): two cubic trichromatic points of `B̄(u, 1)` with disjoint colours are at least `2` apart —
`cor3` would put a four-colour point within `1` of one of them, inside `B̄(u, 2)`. -/
theorem BaseCtx.cor3_base (B : F.BaseCtx u) {p p' : ℂ} (hp : p ∈ closedBall u 1) (hp' : p' ∈ closedBall u 1)
    (h : F.IsCubicTrichromatic p) (h' : F.IsCubicTrichromatic p') (hdis : Disjoint (F.coloursAt p) (F.coloursAt p')) :
    2 ≤ dist p p' := by
  by_contra hlt
  push Not at hlt
  have hcov : ∀ {q : ℂ}, q ∈ closedBall u 1 → F.Covers q 1 := fun {q} hq z hz =>
    B.covers (show z ∈ closedBall u 2 by rw [mem_closedBall] at hq hz ⊢; linarith [dist_triangle z q u])
  obtain ⟨qp, qm, -, hq⟩ := cor3 B.valid h h' (hcov hp) (hcov hp') hdis hlt
  obtain ⟨hqp, -, h4, -⟩ := hq qp (by simp)
  have hqu : qp ∈ closedBall u 2 := by
    rw [mem_closedBall] at hp ⊢; linarith [dist_triangle qp p u]
  have hdom : qp ∈ F.dom := B.covers hqu
  exact Set.disjoint_left.mp B.hyp hqu (Or.inl ⟨hdom, h4⟩)

/-- **Lemma 3 in pseudo-colour form** (`[SokolovVoronov2025]` Lemma 3; BASE-V's BV-L3 route — the unit-distance linkage and the band lemma —
on the two pseudo-colourings): two cubic trichromatic points of `B̄(u, 1)` with one multicolour are not at distance in `(1, 2)`. Their circles may
carry in- and out-contact unit arcs (plan § 2.2), so `bv_l3`'s `RingProper` is not available; the inputs are `exists_pseudoCircle` at both,
(i) across the circles from `pair_i`, the double event from `pair_ii` (or `bv_nd`), and `linkage_dot_ne_zero`. -/
theorem BaseCtx.l3_base (B : F.BaseCtx u) {u₁ u₂ : ℂ} (h₁ : u₁ ∈ closedBall u 1) (h₂ : u₂ ∈ closedBall u 1)
    (c₁ : F.IsCubicTrichromatic u₁) (c₂ : F.IsCubicTrichromatic u₂) (hsame : F.coloursAt u₁ = F.coloursAt u₂)
    (ht : 1 < dist u₁ u₂) (ht' : dist u₁ u₂ < 2) : False := by
  sorry

/-- **The hexagon is excluded** (Prop. 17 with unit arcs): a rotating hexagon of the (reduced) pseudo-colouring of `ω(u)` is a `HexRing` of the
map — its six points keep their germs — so `p17_ua` (or `bv_hex`) refutes it. -/
theorem BaseCtx.hex_base (B : F.BaseCtx u) {C : CircleColouring} {g : ZMod 3 → Fin 6} (hg : Function.Injective g)
    (hL : ∀ θ v, C.LeftVal θ v → F.GermPseudo u θ .cw (g v)) (hR : ∀ θ v, C.RightVal θ v → F.GermPseudo u θ .ccw (g v))
    {ψ : ℝ} {b : ZMod 3 → ZMod 3} (hhex : C.IsHex ψ b) : False := by
  sorry

/-! ## E — the count -/

/-- **The eleventh point's type** (Lemma 4's `10 + 1`): if for each pair of absent colours the three endpoints' colours of `u` are distinct
(else two endpoints share a multicolour), the complement of a type with exactly two colours of `u` is an endpoint's type. Finite combinatorics
on `Fin 6`. -/
theorem eleventh_type {U Q : Finset (Fin 6)} (hU : U.card = 3) (hQ : Q.card = 3) (hQU : (Q ∩ U).card = 2)
    (t : Finset (Fin 6) → Fin 3 → Fin 6) (ht : ∀ P, P ⊆ Uᶜ → P.card = 2 → Function.Injective (t P) ∧ ∀ i, t P i ∈ U) :
    ∃ P, P ⊆ Uᶜ ∧ P.card = 2 ∧ ∃ i, Qᶜ = insert (t P i) P := by
  -- `P` is the two absent colours outside `Q`; `t P` is onto `U`, so it hits the colour of `U` outside `Q`
  set P := Qᶜ ∩ Uᶜ with hP
  have hPU : P ⊆ Uᶜ := Finset.inter_subset_right
  have hunion : (Q ∪ U).card = 4 := by
    have := Finset.card_union_add_card_inter Q U
    omega
  have hPc : P.card = 2 := by
    have h1 : P = (Q ∪ U)ᶜ := by rw [hP, Finset.compl_union]
    rw [h1, Finset.card_compl, hunion]; rfl
  obtain ⟨hinj, hmem⟩ := ht P hPU hPc
  have hUQ : (U \ Q).card = 1 := by
    have := Finset.card_sdiff_add_card_inter U Q
    rw [Finset.inter_comm] at this
    omega
  obtain ⟨w, hw⟩ := Finset.card_eq_one.mp hUQ
  have hwU : w ∈ U := (Finset.mem_sdiff.mp (hw ▸ Finset.mem_singleton_self w)).1
  have hwQ : w ∉ Q := (Finset.mem_sdiff.mp (hw ▸ Finset.mem_singleton_self w)).2
  have himg : Finset.univ.image (t P) = U := by
    apply Finset.eq_of_subset_of_card_le
    · intro x hx
      obtain ⟨i, -, rfl⟩ := Finset.mem_image.mp hx
      exact hmem i
    · rw [Finset.card_image_of_injective _ hinj, hU]; rfl
  obtain ⟨i, -, hi⟩ := Finset.mem_image.mp (himg ▸ hwU)
  refine ⟨P, hPU, hPc, i, ?_⟩
  rw [hi]
  ext x
  simp only [Finset.mem_compl, Finset.mem_insert, hP, Finset.mem_inter]
  constructor
  · intro hxQ
    by_cases hxU : x ∈ U
    · left
      have : x ∈ U \ Q := Finset.mem_sdiff.mpr ⟨hxU, hxQ⟩
      rw [hw] at this
      exact Finset.mem_singleton.mp this
    · right; exact ⟨hxQ, hxU⟩
  · rintro (rfl | ⟨hxQ, -⟩)
    · exact hwQ
    · exact hxQ

end ArcMap

end HadwigerNelson.Plane
