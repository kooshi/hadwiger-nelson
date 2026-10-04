import Proofs.HadwigerNelson.Plane.ValidMap.Dense
import Proofs.HadwigerNelson.Plane.RingBand

/-!
# Row 134's base with unit arcs: the walk's leaves

The skeleton of `row134BaseUA`'s proof (job FS131-KB, `plans/FS131-w5base-kernel-plan.md`): FS112-N3-BASE's walk (`plans/FS112-N-proof.md`
stage N3-3; NB3 § 1.4 steps 1–12), which is `[SokolovVoronov2025]` Lemma 4's pigeonhole as FS110-CB D1–D6, FS110-CD Lemmas H, E, R and
Theorem D2, and FS110-CE's R1–R4 and Antipodal Lemma repaired it, with each use of Condition 5 replaced by a walked step. Everything is read
in the base's context `BaseCtx F u`: a valid six-coloured fragment covering `B̄(u, 2)`, `u` cubic trichromatic, `BaseHyp u` (H) and
`NoInertNear u` — the hypotheses of `Row134BaseUA`, which the walk refutes. So no statement here has a model (each is a step of a proof by
contradiction, refuted by `row134BaseUA`); the carrier `BaseCtx` is OUT of the vacuity scan.

The leaves, in the walk's order:
* **A — the pseudo-colouring of `ω(p)`** at a cubic trichromatic `p ∈ B̄(u, 1)`: nonempty, at most two colours, finitely many
  non-singleton points (`pseudo_nonempty`, `pseudo_ncard_le_two`, `pseudo_finite`), and the bridge to wave 3's `CircleColouring` with no swap
  point (`exists_pseudoCircle`; (i) is `pair_i`, the no-swap clause is `pair_ii` with `noBoth`).
* **B — circle-abstract**: the circle-only reduction (`reduce`, FS110-CD Lemma R step 5) and the selection (`select`: Lemma 5, BV-C6,
  Prop. 18 — BASE-V's BV-L5, BV-C6, BV-P18).
* **C — the planar core**: the returning arcs are removable and nest (`retArc_removable`, `retArcs_finite`, `retArcs_nested`), a
  non-returning change point has an endpoint (`exists_endpoint`: Prop. 19(b) with R1–R4 and Lemma E), and the eleventh point
  (`exists_eleventh` — **a GAP in the walk as written**, plan § 2.3: the sources obtain it after hole-filling, which can destroy `u`).
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
trichromatic, no point of `F(M) ∪ R(M)` in `B̄(u, 2)`, no inert unit arc centred within `1` of `u`. Refuted by `row134BaseUA`; every theorem
of this file is a step of that refutation (no model expected). -/
structure BaseCtx (F : ArcMap 6) (u : ℂ) : Prop where
  valid : F.Valid
  covers : F.Covers u 2
  cubic : F.IsCubicTrichromatic u
  hyp : F.BaseHyp u
  noInert : F.NoInertNear u

/-- A point is **V-in** relative to `u` (FS110-CD § 2.3): a point of `ω(u)` some tile of whose colours carried at `u` meets `B(u, 1)`. -/
def VIn (F : ArcMap k) (u p : ℂ) : Prop :=
  dist p u = 1 ∧ ∃ i ∈ F.coloursAt u, ∃ T, F.TileOf i T ∧ p ∈ closure T ∧ (T ∩ ball u 1).Nonempty

/-- **An endpoint** for the change pair `{a, c}` at `x` (FS110-CD Lemma E, over the tiles, path-free): a three-colour point `p` in the
closures of the `a`-tile and the `c`-tile at `x`, inside `B(u, 1)` or V-in on `ω(u)`. -/
def IsEndpoint (F : ArcMap k) (u x : ℂ) (a c : Fin k) (p : ℂ) : Prop :=
  (F.coloursAt p).ncard = 3 ∧ (p ∈ ball u 1 ∨ F.VIn u p) ∧
    ∃ T₁ T₂, F.TileOf a T₁ ∧ F.TileOf c T₂ ∧ x ∈ closure T₁ ∧ x ∈ closure T₂ ∧ p ∈ closure T₁ ∧ p ∈ closure T₂

/-- **A returning pair** of `ω(u)` (FS110-CD Lemma R, path-free): two distinct change points `r(s)`, `r(t)` of the pseudo-colouring of
`ω(u)`, `s < t < s + 60°`, switching between the same two colours `a`, `c` (with `c` just inside `[s, t]` at both ends and `a` just
outside), whose `a`-tiles coincide and whose `c`-tiles coincide. -/
def IsRetArc (F : ArcMap k) (u : ℂ) (s t : ℝ) : Prop :=
  s < t ∧ t < s + π / 3 ∧ ∃ a c, a ≠ c ∧ F.GermPseudo u s .cw a ∧ F.GermPseudo u s .ccw c ∧ F.GermPseudo u t .cw c ∧
    F.GermPseudo u t .ccw a ∧ ∃ T₁ T₂, F.TileOf a T₁ ∧ F.TileOf c T₂ ∧ ringPt u s ∈ closure T₁ ∧ ringPt u t ∈ closure T₁ ∧
      ringPt u s ∈ closure T₂ ∧ ringPt u t ∈ closure T₂

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
    F.IsCubicTrichromatic x := by
  sorry

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

/-- **The returning arcs are removable** (FS110-CD Lemma R step 3, path-free): for `x` inside a returning arc and `y = r(x ± 60°)`, `ω(y)`
crosses `ω(u)` only at `x` within the arc, so it separates its ends; the `a`-tile and the `c`-tile, connected with both ends in their closures,
meet `ω(y)`, so neither colour is at `y` (the (P) sweep) and `c′(y)` is the third colour. The colour pattern at the ends is in `IsRetArc`. -/
theorem BaseCtx.retArc_partner (B : F.BaseCtx u) {s t : ℝ} (hR : F.IsRetArc u s t) {x : ℝ} (hx : x ∈ Ioo s t) {a c : Fin 6}
    (ha : F.GermPseudo u s .cw a) (hc : F.GermPseudo u s .ccw c) (y : ℝ) (hy : y = x + π / 3 ∨ y = x - π / 3) :
    a ∉ F.pseudoColours u (ringPt u y) ∧ c ∉ F.pseudoColours u (ringPt u y) := by
  sorry

/-- **Finitely many returning arcs** (FS110-CD Lemma R): their ends are change points of the pseudo-colouring, finitely many per period. -/
theorem BaseCtx.retArcs_finite (B : F.BaseCtx u) :
    {q : ℝ × ℝ | q.1 ∈ Ico 0 (2 * π) ∧ F.IsRetArc u q.1 q.2}.Finite := by
  sorry

/-- **The returning arcs nest or are disjoint** (FS110-CB D5 item 1, "paths do not cross; their arcs nest or are disjoint"; FS110-CD Lemma R
step 4) — **planar core**: interleaved ends would make the `a`-tile of one pair cross the boundary of the other's tiles away from a
four-colour point. Planned over the finite boundary graph of the disc (plan § 4, leaf C3). -/
theorem BaseCtx.retArcs_nested (B : F.BaseCtx u) {s t s' t' : ℝ} (h : F.IsRetArc u s t) (h' : F.IsRetArc u s' t') :
    Disjoint (ringArc u s t) (ringArc u s' t') ∨ ringArc u s t ⊆ ringArc u s' t' ∨ ringArc u s' t' ⊆ ringArc u s t := by
  sorry

/-- **A non-returning change point has an endpoint** (`[SokolovVoronov2025]` Prop. 19(b) as FS110-CD Lemma E and FS110-CE R1–R4 repaired it,
path-free) — **planar core**: a change point `r(θ)` of the pseudo-colouring of `ω(u)` with pair `{a, c}`, outside every returning arc, has an
endpoint: the `a|c` boundary from it, continued through spikes, ends at a three-colour point of `B(u, 1)` or at a V-in vertex of `ω(u)`, in the
closures of the two tiles at `r(θ)`. Planned over the finite boundary graph (the handshake lemma, plan § 4, leaf C4). -/
theorem BaseCtx.exists_endpoint (B : F.BaseCtx u) {θ : ℝ} {a c : Fin 6} (hac : a ≠ c) (ha : F.GermPseudo u θ .cw a)
    (hc : F.GermPseudo u θ .ccw c ∨ (F.GermPseudo u θ .cw c ∧ F.GermPseudo u θ .ccw a))
    (hout : ∀ s t, F.IsRetArc u s t → ringPt u θ ∉ ringArc u s t) :
    ∃ p, F.IsEndpoint u (ringPt u θ) a c p := by
  sorry

/-- **The eleventh point** (`[SokolovVoronov2025]` p. 28, "on the boundary of the union of three regions … whose vertex is `u`, there is at
least one more trichromatic point"; FS110-CD § 2.6; FS112-N3-3) — **GAP as the walk stands** (plan § 2.3, sent to Keryx): every source obtains it
on the outer rim of `u`'s `P_cl(u)`-component after hole-filling, which in the local base can destroy `u` (a tile of a colour of `u` enclosing
`u` inside `B(u, 1)`). A three-colour point of `B̄(u, 1)` carrying exactly two colours of `u`, whose tiles of those colours lie in `B(u, 1)`. -/
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
  sorry

/-- **No two V-in points of one colour of `u` are antipodal** (FS110-CD Theorem D2 (i); FS110-CE's Antipodal Lemma): their tiles of that
colour lie in `B̄(p, 1) ∩ B̄(p′, 1) = {u}` (Lemma H(b)), against openness. -/
theorem BaseCtx.vin_antipodal (B : F.BaseCtx u) {p p' : ℂ} {i : Fin 6} (hi : i ∈ F.coloursAt u)
    (hp : dist p u = 1) (hp' : dist p' u = 1) (hpi : ∃ T, F.TileOf i T ∧ p ∈ closure T ∧ (T ∩ ball u 1).Nonempty)
    (hpi' : ∃ T, F.TileOf i T ∧ p' ∈ closure T ∧ (T ∩ ball u 1).Nonempty) : dist p p' ≠ 2 := by
  sorry

/-- **The eleventh point is not antipodal to a complementary V-in endpoint** (FS110-CD Theorem D2 (ii)): the cusps `u + t·e⊥` between the two
tangent discs meet none of `u`'s three tiles, against the sector picture at `u`. -/
theorem BaseCtx.eleventh_antipodal (B : F.BaseCtx u) {q p : ℂ} (hq : dist q u = 1)
    (hqT : ∀ j ∈ F.coloursAt q ∩ F.coloursAt u, ∀ T, F.TileOf j T → q ∈ closure T → T ⊆ ball u 1)
    (hq2 : (F.coloursAt q ∩ F.coloursAt u).ncard = 2) (hp : F.VIn u p) (hdis : Disjoint (F.coloursAt q) (F.coloursAt p)) :
    dist q p ≠ 2 := by
  sorry

/-- **Corollary 3 under H** (FS112-N3-COR3): two cubic trichromatic points of `B̄(u, 1)` with disjoint colours are at least `2` apart —
`cor3` would put a four-colour point within `1` of one of them, inside `B̄(u, 2)`. -/
theorem BaseCtx.cor3_base (B : F.BaseCtx u) {p p' : ℂ} (hp : p ∈ closedBall u 1) (hp' : p' ∈ closedBall u 1)
    (h : F.IsCubicTrichromatic p) (h' : F.IsCubicTrichromatic p') (hdis : Disjoint (F.coloursAt p) (F.coloursAt p')) :
    2 ≤ dist p p' := by
  sorry

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
  sorry

end ArcMap

end HadwigerNelson.Plane
