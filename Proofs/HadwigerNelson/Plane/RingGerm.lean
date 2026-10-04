import Proofs.HadwigerNelson.Plane.Tiles
import Proofs.HadwigerNelson.Plane.Chord
import Proofs.HadwigerNelson.Plane.SixFragment

/-!
# The ring of a point: twist, the closed set `D`, germs and cones, change points, (Q)-free and five- and six-colour rings,
# touch points, the echo, unit arcs' cones, the flank

Wave 3's ring rows (`plans/FS131-w3-kernel-plan.md`, stage 3), Siamese pairs allowed throughout. Each is stated at the class
its argument reads (inventory items 26–27): where a hypothesis of the row is idle it is dropped, and where the argument reads
the number of colours absent at `p` rather than the number of colours, the theorem is stated at every `k` with that count (the
row is the instance `k = 6`). The rows' "on a closed disc of radius above 1 about `p`" is `F.Covers p 1`
(`ArcMap.covers_one_iff`), and "a vertex of at least four colours" is `4 ≤ (F.coloursAt p).ncard`.

| row | declarations |
|---|---|
| FS116-V4-TWIST | `not_germIn_closure_rotate`, `not_mem_coloursAt_of_mem_sphere` |
| FS116-N1-TWIST-D | `ringD`, `isClosed_ringD`, `finite_ringD_off_ringArc`, `ringD_subset_Γ` |
| FS116-N1-GERM-R | `germR_vMinus`, `germR_vPlus`, `germR_uMinus`, `germR_uPlus` |
| FS116-N1-GERM-S | `germS_absent`, `germS_inward`, `germS_outward`, `germS_four` |
| FS116-RING-Q-PRIME-S (carrying FS116-RING-Q-PRIME) | `ringQPrimeS` |
| FS116-N1-QFREE4 | `qfree4` |
| FS116-N2-FIVERING (carrying FS112-SIX's and FS116-RING-TRANSFER-C's five-colour clauses) | `fiveRing_no_changePoint`, `fiveRing_finite_off_Q`, `fiveRing_length`, `fiveRing_no_hub` |
| FS129-SR1-SIXQ (carrying FS112-SIX's six-colour clause) | `sixQ_sphere_subset_Γ`, `sixQ_sides`, `sixQ_isQArc`; inhabitant `sixQ_inhabited` |
| FS129-SR2-TOUCHW (carrying FS116-N1-TOUCH) | `touchW` |
| FS116-N1-ECHO | `echo_unique`, `echo_of_mem_closure`, `echo` |
| FS116-V5-U1 | `ringArc_cone_inner`, `ringArc_cone_outer`, `ringArc_sideCone_inner`, `ringArc_sideCone_outer`, `ringArc_sideCone_other`, `four_of_bothKind`, `four_of_bothKind_simple` |
| FS116-Y4-FLANK | `flank_cone`, `flank_edge_exists`, `flank_initialPieces`, `flank` |

**Inhabitants.** Six colours at a vertex: `sixFrag` (`Plane/SixFragment`), the inhabitant of SIXQ (`sixQ_inhabited`). A
vertex of four colours with a change point (GERM-S, RING-Q-PRIME-S, TOUCHW, QFREE4's class): FS114-Y2-BOWTIE (wave 7) and
FS114-Y-DIAL's strip; none in this wave. A five-colour vertex (FIVERING): none known, and none claimed to exist (its
not-claimed line).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS116-V4-TWIST -/

/-- **FS116-V4-TWIST**, first clause (class form; the covering hypothesis is idle): no colour class has in its closure both
a germ `g` of `ω(p)` and its rotation `σg` by `60°` about `p` (σ⁻¹`g` is the same statement at `θ − π/3`). -/
theorem not_germIn_closure_rotate (hF : F.Valid) (p : ℂ) (θ : ℝ) (s : Side) (c : Fin k) :
    ¬ (GermIn p θ s (closure (F.region c)) ∧ GermIn p (θ + π / 3) s (closure (F.region c))) := by
  sorry

/-- **FS116-V4-TWIST**, second clause ("when `p` is a vertex" is idle): a point of `ω(p)` inside a tile of colour `c` has `c`
absent at `p`. -/
theorem not_mem_coloursAt_of_mem_sphere (hF : F.Valid) {p z : ℂ} (hz : z ∈ sphere p 1) {c : Fin k}
    (hzc : z ∈ F.region c) : c ∉ F.coloursAt p := by
  sorry

/-! ## FS116-N1-TWIST-D -/

/-- The set `D` of FS116-N1-TWIST-D: the points of `ω(p)` in the closure of a tile of one of `p`'s colours (class form; equal
to the tile form on a covered ring, `mem_coloursAt_iff_exists_tileOf`). -/
def ringD (F : ArcMap k) (p : ℂ) : Set ℂ := {x | x ∈ sphere p 1 ∧ ∃ c ∈ F.coloursAt p, x ∈ closure (F.region c)}

/-- **FS116-N1-TWIST-D**, `D` is closed. -/
theorem isClosed_ringD (p : ℂ) : IsClosed (F.ringD p) := by
  sorry

/-- **FS116-N1-TWIST-D** ("vertex" idle; any point `p`): `D` lies in `Γ`. -/
theorem ringD_subset_Γ (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) : F.ringD p ⊆ F.Γ := by
  sorry

/-- **FS116-N1-TWIST-D**: `D` lies in the union of the arcs of `Γ` on `ω(p)` and finitely many points. -/
theorem finite_ringD_off_ringArc (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) :
    (F.ringD p \ {x | F.OnRingArc p x}).Finite := by
  sorry

/-! ## FS116-N1-GERM-R (any valid map: the covering hypothesis is idle) -/

/-- **FS116-N1-GERM-R**, `v⁻`: if the germ just clockwise of `r(ψ − 60°)` lies in the closure of the class of `c`, the class
approaches `y = r(ψ)` along no direction `β` with `β − ψ ∈ (150°, 330°)`. -/
theorem germR_vMinus (hF : F.Valid) {p : ℂ} {ψ : ℝ} {c : Fin k}
    (h : GermIn p (ψ - π / 3) .cw (closure (F.region c))) :
    ∀ β ∈ Ioo (ψ + 5 * π / 6) (ψ + 11 * π / 6), β ∉ coneAt (F.region c) (ringPt p ψ) := by
  sorry

/-- **FS116-N1-GERM-R**, `v⁺`: the germ just counter-clockwise of `r(ψ − 60°)`; the interval `(−30°, 150°)`. -/
theorem germR_vPlus (hF : F.Valid) {p : ℂ} {ψ : ℝ} {c : Fin k}
    (h : GermIn p (ψ - π / 3) .ccw (closure (F.region c))) :
    ∀ β ∈ Ioo (ψ - π / 6) (ψ + 5 * π / 6), β ∉ coneAt (F.region c) (ringPt p ψ) := by
  sorry

/-- **FS116-N1-GERM-R**, `u⁻`: the germ just clockwise of `r(ψ + 60°)`; the interval `(−150°, 30°)`. -/
theorem germR_uMinus (hF : F.Valid) {p : ℂ} {ψ : ℝ} {c : Fin k}
    (h : GermIn p (ψ + π / 3) .cw (closure (F.region c))) :
    ∀ β ∈ Ioo (ψ - 5 * π / 6) (ψ + π / 6), β ∉ coneAt (F.region c) (ringPt p ψ) := by
  sorry

/-- **FS116-N1-GERM-R**, `u⁺`: the germ just counter-clockwise of `r(ψ + 60°)`; the interval `(30°, 210°)`. -/
theorem germR_uPlus (hF : F.Valid) {p : ℂ} {ψ : ℝ} {c : Fin k}
    (h : GermIn p (ψ + π / 3) .ccw (closure (F.region c))) :
    ∀ β ∈ Ioo (ψ + π / 6) (ψ + 7 * π / 6), β ∉ coneAt (F.region c) (ringPt p ψ) := by
  sorry

/-! ## FS116-N1-GERM-S (at every `k` with at most two colours absent at `p`; the row is `k = 6`) -/

/-- **FS116-N1-GERM-S**, the count: at a change point `y = r(ψ)` of the ring of a vertex `p` of at least four colours with at
most two colours absent, exactly two are absent — `X` (the ring's colour just counter-clockwise of `y`) and `X'` (`X̄`, just
clockwise). At `k = 6`: "`p` has four colours and no more, `X` and `X̄` are the colours absent at `p`". -/
theorem germS_absent (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k} (hy : F.IsChangePoint p ψ X X') :
    (F.coloursAt p).ncard + 2 = k ∧ (F.coloursAt p)ᶜ = {X, X'} := by
  sorry

/-- **FS116-N1-GERM-S** (i): if neither `v⁻` nor `u⁺` lies on a (Q) arc, every direction at `y` in the open `60°` cone about
the direction to `p` lies in the cone of a colour `c` of `p` every tile of `p` of which colour lies in `B̄(y, 1)`. -/
theorem germS_inward (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k} (hy : F.IsChangePoint p ψ X X')
    (hv : ¬ F.GermOnQ p (ψ - π / 3) .cw) (hu : ¬ F.GermOnQ p (ψ + π / 3) .ccw) :
    ∀ β ∈ Ioo (ψ + 5 * π / 6) (ψ + 7 * π / 6), ∃ c ∈ F.coloursAt p,
      β ∈ coneAt (F.region c) (ringPt p ψ) ∧
        ∀ A, F.TileOf c A → p ∈ closure A → A ⊆ closedBall (ringPt p ψ) 1 := by
  sorry

/-- **FS116-N1-GERM-S** (ii): if neither `u⁻` nor `v⁺` lies on a (Q) arc, every direction at `y` in the open `60°` cone about
the direction away from `p` lies in the cone of a tile, not a tile of `p`, of a colour `c` of `p` every tile of `p` of which
colour misses `B(y, 1)`. "A tile, not a tile of `p`" is the part of the class outside `B̄(p, 1)`, which no tile of `p` meets
(`IsTile.subset_ball`); in this window of directions the two readings have the same cone. -/
theorem germS_outward (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k} (hy : F.IsChangePoint p ψ X X')
    (hu : ¬ F.GermOnQ p (ψ + π / 3) .cw) (hv : ¬ F.GermOnQ p (ψ - π / 3) .ccw) :
    ∀ β ∈ Ioo (ψ - π / 6) (ψ + π / 6), ∃ c ∈ F.coloursAt p,
      β ∈ coneAt (F.region c \ closedBall p 1) (ringPt p ψ) ∧
        ∀ A, F.TileOf c A → p ∈ closure A → Disjoint A (ball (ringPt p ψ) 1) := by
  sorry

/-- **FS116-N1-GERM-S** (iii): if none of the four germs at `ψ ± 60°` lies on a (Q) arc, `y` is a vertex of at least four
colours. -/
theorem germS_four (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k} (hy : F.IsChangePoint p ψ X X')
    (hq : ∀ s, ¬ F.GermOnQ p (ψ + π / 3) s ∧ ¬ F.GermOnQ p (ψ - π / 3) s) :
    4 ≤ (F.coloursAt (ringPt p ψ)).ncard := by
  sorry

/-! ## FS116-RING-Q-PRIME-S -/

/-- **FS116-RING-Q-PRIME-S** (carrying FS116-RING-Q-PRIME; at every `k` with at most two colours absent): a change point of
the ring of a vertex of at least four colours whose points at `±60°` lie on no closed (Q) arc is a vertex of at least four
colours. -/
theorem ringQPrimeS (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k} (hy : F.IsChangePoint p ψ X X')
    (hu : ¬ F.OnQArc p (ringPt p (ψ + π / 3))) (hv : ¬ F.OnQArc p (ringPt p (ψ - π / 3))) :
    4 ≤ (F.coloursAt (ringPt p ψ)).ncard := by
  sorry

/-! ## FS116-N1-QFREE4 (at every `k`) -/

/-- **FS116-N1-QFREE4** (at every `k`: the argument reads that at least two colours are absent): at a vertex of at least four
colours whose ring carries no (Q) arc, at least two colours are absent. At `k = 6`: "`p` has four colours and no more". -/
theorem qfree4 (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hq : ∀ θ₁ θ₂, ¬ F.IsQArc p θ₁ θ₂) : (F.coloursAt p).ncard + 2 ≤ k := by
  sorry

/-! ## FS116-N2-FIVERING (at every `k` with exactly one colour absent; the row is `k = 6`) -/

/-- **FS116-N2-FIVERING**, first clause (and FS116-RING-TRANSFER-C's "a ring of five colours has no change point"): the ring
of a vertex of at least four colours with exactly one colour absent has no change point. -/
theorem fiveRing_no_changePoint (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : (F.coloursAt p).ncard + 1 = k) (ψ : ℝ) (X X' : Fin k) : ¬ F.IsChangePoint p ψ X X' := by
  sorry

/-- **FS116-N2-FIVERING**: for every `θ` outside a finite set, `r(θ)` or `r(θ + 60°)` lies on a (Q) arc. -/
theorem fiveRing_finite_off_Q (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : (F.coloursAt p).ncard + 1 = k) :
    {θ | θ ∈ Ico 0 (2 * π) ∧ ¬ F.OnQArc p (ringPt p θ) ∧ ¬ F.OnQArc p (ringPt p (θ + π / 3))}.Finite := by
  sorry

/-- **FS116-N2-FIVERING** (and FS112-SIX's five-colour clause): the (Q) arcs of the ring have total length at least `180°`
(arc-length of the set of angles in `[0, 2π)` whose ring point lies on a closed (Q) arc). -/
theorem fiveRing_length (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : (F.coloursAt p).ncard + 1 = k) : ENNReal.ofReal π ≤ arcLength {θ | F.OnQArc p (ringPt p θ)} := by
  sorry

/-- **FS116-N2-FIVERING**, last clause (and FS116-RING-TRANSFER-C's "places no vertex through RING-GERM"): `p` has no hub. -/
theorem fiveRing_no_hub (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : (F.coloursAt p).ncard + 1 = k) (ψ : ℝ) : ¬ F.IsHub p ψ := by
  sorry

/-! ## FS129-SR1-SIXQ -/

/-- **FS129-SR1-SIXQ** (carrying FS112-SIX's "its whole unit circle lies in `Γ`"): at a point carrying all `k` colours, on a
covered ring, `ω(p)` lies in `Γ`. -/
theorem sixQ_sphere_subset_Γ (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (hall : F.coloursAt p = univ) :
    sphere p 1 ⊆ F.Γ := by
  sorry

/-- **FS129-SR1-SIXQ**: both side colours of every arc of `Γ` on `ω(p)` are carried at `p`. -/
theorem sixQ_sides {p : ℂ} (hall : F.coloursAt p = univ) {θ₁ θ₂ : ℝ} {c c' : Fin k} (_hA : F.IsRingArc p θ₁ θ₂ c c') :
    c ∈ F.coloursAt p ∧ c' ∈ F.coloursAt p := by
  rw [hall]; exact ⟨mem_univ _, mem_univ _⟩

/-- **FS129-SR1-SIXQ**, the (Q) clause (at every `k ≥ 4`; the row is `k = 6`, "every arc of kind both" of FS112-SIX): when
`p` carries all colours, every arc of `Γ` on `ω(p)` is a (Q) arc. -/
theorem sixQ_isQArc (hk : 4 ≤ k) {p : ℂ} (hall : F.coloursAt p = univ) {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (h : F.IsRingArc p θ₁ θ₂ c c') : F.IsQArc p θ₁ θ₂ := by
  sorry

/-- SIXQ's hypotheses are inhabited by FS116-Y2-SIXFRAG: a valid six-coloured fragment covering `B̄(0, 1)` with all six
colours at `0`, and an arc of `Γ` on `ω(0)`. -/
theorem sixQ_inhabited : sixFrag.Valid ∧ sixFrag.Covers 0 1 ∧ sixFrag.coloursAt 0 = univ ∧
    sixFrag.IsRingArc 0 0 (π / 6) 0 2 :=
  ⟨sixFrag_valid, sixFrag_covers (by norm_num), sixFrag_coloursAt_zero, sixFrag_isRingArc⟩

/-! ## FS129-SR2-TOUCHW (at every `k` with exactly two colours absent; the row is `k = 6`) -/

/-- **FS129-SR2-TOUCHW** (carrying FS116-N1-TOUCH, its idle hypothesis "w in the closure of a tile of one of `p`'s colours"
dropped): at a vertex of at least four colours with exactly two colours absent, let `w = r(ψ)` be no change point, on no arc
of `Γ` on `ω(p)`, with none of the four germs at `ψ ± 60°` on a (Q) arc. Then the ring just clockwise and just
counter-clockwise of `w` lies in one colour `X` absent at `p`; each of the four germs lies in the closure of the class of the
other absent colour `X'` (`X̄`) and has no point in the closure of the class of `X`; and `X'` is not carried at `w`. -/
theorem touchW (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1) (h4 : 4 ≤ (F.coloursAt p).ncard)
    (hk : (F.coloursAt p).ncard + 2 = k) {ψ : ℝ} (hnc : ∀ X X', ¬ F.IsChangePoint p ψ X X')
    (hna : ¬ F.OnRingArc p (ringPt p ψ))
    (hq : ∀ s, ¬ F.GermOnQ p (ψ + π / 3) s ∧ ¬ F.GermOnQ p (ψ - π / 3) s) :
    ∃ X X', X ≠ X' ∧ (F.coloursAt p)ᶜ = {X, X'} ∧
      GermIn p ψ .cw (F.region X) ∧ GermIn p ψ .ccw (F.region X) ∧
      (∀ θ ∈ ({ψ + π / 3, ψ - π / 3} : Set ℝ), ∀ s,
        GermIn p θ s (closure (F.region X')) ∧ GermIn p θ s (closure (F.region X))ᶜ) ∧
      X' ∉ F.coloursAt (ringPt p ψ) := by
  sorry

/-! ## FS116-N1-ECHO (any valid map; the radius-2 hypothesis is idle) -/

/-- **FS116-N1-ECHO**, the engine: if the ring just clockwise and just counter-clockwise of `w = r(ψ)` lies in the class of a
colour `X` absent at `p`, the only point of the closure of the class of `X` at distance `1` from `w` is `2w − p`. -/
theorem echo_unique (hF : F.Valid) {p : ℂ} {ψ : ℝ} {X : Fin k} (hcw : GermIn p ψ .cw (F.region X))
    (hccw : GermIn p ψ .ccw (F.region X)) (hX : X ∉ F.coloursAt p) {x : ℂ} (hx : x ∈ closure (F.region X))
    (h1 : dist x (ringPt p ψ) = 1) : x = 2 * ringPt p ψ - p := by
  sorry

/-- **FS116-N1-ECHO** at the class its argument reads: some point of the closure of the class of `X` at distance `1` from `w`
puts `2w − p` in that closure. -/
theorem echo_of_mem_closure (hF : F.Valid) {p : ℂ} {ψ : ℝ} {X : Fin k} (hcw : GermIn p ψ .cw (F.region X))
    (hccw : GermIn p ψ .ccw (F.region X)) (hX : X ∉ F.coloursAt p)
    (hpt : ∃ x ∈ closure (F.region X), dist x (ringPt p ψ) = 1) : X ∈ F.coloursAt (2 * ringPt p ψ - p) := by
  sorry

/-- **FS116-N1-ECHO**, the row's form (reading (B)): if `w` is an essential boundary point at which the map is saturated and
`X` is in `w`'s essential multicolour, `2w − p` lies in the closure of the class of `X`. -/
theorem echo (hF : F.Valid) {p : ℂ} {ψ : ℝ} {X : Fin k} (hcw : GermIn p ψ .cw (F.region X))
    (hccw : GermIn p ψ .ccw (F.region X)) (hX : X ∉ F.coloursAt p) (hess : F.IsEssBoundary (ringPt p ψ))
    (hsat : F.SaturatedAt (ringPt p ψ)) (hXw : X ∈ F.essColours (ringPt p ψ)) :
    X ∈ F.coloursAt (2 * ringPt p ψ - p) := by
  sorry

/-! ## FS116-V5-U1 (any valid map) -/

/-- **FS116-V5-U1**, inner side: if `A = r([θ₁, θ₂])` (about `z`) is an arc of `Γ` on `ω(z)` with inner colour `c`, the class
of `c` approaches `z` only within the closed cone `[θ₂ − 90°, θ₁ + 90°]` facing `A`. -/
theorem ringArc_cone_inner (hF : F.Valid) {z : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc z θ₁ θ₂ c c') :
    coneAt (F.region c) z ⊆ angleIcc (θ₂ - π / 2) (θ₁ + π / 2) := by
  sorry

/-- **FS116-V5-U1**, outer side: the class of the outer colour `c'` approaches `z` only within the closed cone
`[θ₂ + 90°, θ₁ + 270°]` facing away from `A`. -/
theorem ringArc_cone_outer (hF : F.Valid) {z : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc z θ₁ θ₂ c c') :
    coneAt (F.region c') z ⊆ angleIcc (θ₂ + π / 2) (θ₁ + 3 * π / 2) := by
  sorry

/-- **FS116-V5-U1**: the open side cone `(θ₁ − 90°, θ₂ − 90°)` holds neither side colour. -/
theorem ringArc_sideCone_inner (hF : F.Valid) {z : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc z θ₁ θ₂ c c') :
    Disjoint (coneAt (F.region c) z ∪ coneAt (F.region c') z) (angleIoo (θ₁ - π / 2) (θ₂ - π / 2)) := by
  sorry

/-- **FS116-V5-U1**: the open side cone `(θ₁ + 90°, θ₂ + 90°)` holds neither side colour. -/
theorem ringArc_sideCone_outer (hF : F.Valid) {z : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc z θ₁ θ₂ c c') :
    Disjoint (coneAt (F.region c) z ∪ coneAt (F.region c') z) (angleIoo (θ₁ + π / 2) (θ₂ + π / 2)) := by
  sorry

/-- **FS116-V5-U1**, "the side cones hold two further colours": at a point `z` of the domain, every direction of either open
side cone lies in the cone of a colour other than `c` and `c'`. (`z ∈ F.dom` is a hypothesis the row leaves implicit: off
the domain a side cone may hold no colour at all — plan § 3.3.) -/
theorem ringArc_sideCone_other (hF : F.Valid) {z : ℂ} (hz : z ∈ F.dom) {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hA : F.IsRingArc z θ₁ θ₂ c c') {β : ℝ}
    (hβ : β ∈ angleIoo (θ₁ - π / 2) (θ₂ - π / 2) ∪ angleIoo (θ₁ + π / 2) (θ₂ + π / 2)) :
    ∃ d, d ≠ c ∧ d ≠ c' ∧ β ∈ coneAt (F.region d) z := by
  sorry

/-- **FS116-V5-U1**, the four-colour clause at the class it reads: if `z` (in the domain) carries both side colours of an arc
of `Γ` on `ω(z)` (the arc is both-kind), each colour has at most one tile with `z` in its closure, and each such tile's cone
at `z` is one closed angular interval, then `z` carries at least four colours. -/
theorem four_of_bothKind (hF : F.Valid) {z : ℂ} (hz : z ∈ F.dom) {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hA : F.IsRingArc z θ₁ θ₂ c c') (hc : c ∈ F.coloursAt z) (hc' : c' ∈ F.coloursAt z)
    (hone : ∀ d T T', F.TileOf d T → F.TileOf d T' → z ∈ closure T → z ∈ closure T' → T = T')
    (hint : ∀ T, F.IsTile T → z ∈ closure T → ∃ β₁ β₂, β₁ ≤ β₂ ∧ β₂ ≤ β₁ + 2 * π ∧ coneAt T z = angleIcc β₁ β₂) :
    4 ≤ (F.coloursAt z).ncard := by
  sorry

/-- **FS116-V5-U1**, the row's four-colour clause: in a non-Siamese simple map, a point `z` of the domain carrying both side
colours of an arc of `Γ` on `ω(z)` carries at least four colours. -/
theorem four_of_bothKind_simple (hF : F.Valid) (hN : F.NonSiamese) (hS : F.Simple) {z : ℂ} (hz : z ∈ F.dom)
    {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc z θ₁ θ₂ c c') (hc : c ∈ F.coloursAt z)
    (hc' : c' ∈ F.coloursAt z) : 4 ≤ (F.coloursAt z).ncard := by
  sorry

/-! ## FS116-Y4-FLANK (any valid map; the covering hypothesis is idle) -/

/-- **FS116-Y4-FLANK**, the cones: let `t` be a tile with `y = r(ψ)` and `y' = r(ψ + 60°)` in its closure, its cone at `y`
containing `(ψ + 150°, ψ + 210°)` and its cone at `y'` containing `(ψ + 210°, ψ + 270°)`; then its cone at `y` lies in
`[ψ + 30°, ψ + 210°]` and holds `ψ + 210°` (it ends there), and its cone at `y'` lies in `[ψ + 210°, ψ + 390°]` and holds
`ψ + 210°` (it begins there). -/
theorem flank_cone (hF : F.Valid) {t : Set ℂ} (ht : F.IsTile t) {p : ℂ} {ψ : ℝ} (hy : ringPt p ψ ∈ closure t)
    (hy' : ringPt p (ψ + π / 3) ∈ closure t) (hcy : Ioo (ψ + 5 * π / 6) (ψ + 7 * π / 6) ⊆ coneAt t (ringPt p ψ))
    (hcy' : Ioo (ψ + 7 * π / 6) (ψ + 3 * π / 2) ⊆ coneAt t (ringPt p (ψ + π / 3))) :
    coneAt t (ringPt p ψ) ⊆ angleIcc (ψ + π / 6) (ψ + 7 * π / 6) ∧ ψ + 7 * π / 6 ∈ coneAt t (ringPt p ψ) ∧
      coneAt t (ringPt p (ψ + π / 3)) ⊆ angleIcc (ψ + 7 * π / 6) (ψ + 13 * π / 6) ∧
      ψ + 7 * π / 6 ∈ coneAt t (ringPt p (ψ + π / 3)) := by
  sorry

/-- **FS116-Y4-FLANK**, the edges exist: at `y` (in the domain) under the cone hypotheses, `t`'s edge leaving `y` in the
direction `ψ + 210°` is an initial piece of an arc of the map lying in `cl t`; likewise at `y'`. -/
theorem flank_edge_exists (hF : F.Valid) {t : Set ℂ} (ht : F.IsTile t) {p : ℂ} {ψ : ℝ}
    (hyd : ringPt p ψ ∈ F.dom) (hy'd : ringPt p (ψ + π / 3) ∈ F.dom) (hy : ringPt p ψ ∈ closure t)
    (hy' : ringPt p (ψ + π / 3) ∈ closure t) (hcy : Ioo (ψ + 5 * π / 6) (ψ + 7 * π / 6) ⊆ coneAt t (ringPt p ψ))
    (hcy' : Ioo (ψ + 7 * π / 6) (ψ + 3 * π / 2) ⊆ coneAt t (ringPt p (ψ + π / 3))) :
    (∃ α ∈ F.arcs, ∃ B, α.InitialPiece (ringPt p ψ) (ψ + 7 * π / 6) B ∧ B ⊆ closure t) ∧
      ∃ α' ∈ F.arcs, ∃ B', α'.InitialPiece (ringPt p (ψ + π / 3)) (ψ + 7 * π / 6) B' ∧ B' ⊆ closure t := by
  sorry

/-- **FS116-Y4-FLANK**, the geometry (TWOCIRC in place of its identity step, SR1 item 1): two initial pieces of arcs leaving
`y` and `y'` (with `y' − y = e(ψ + 120°)`) in the direction `ψ + 210°`, the first inside `B̄(y', 1)` and the second inside
`B̄(y, 1)`, have points nearer than `1`. (Staying in the disc forces each to curve toward the other centre with radius at most
`1`: a segment, or an arc curving away, leaves the disc.) -/
theorem flank_initialPieces {y y' : ℂ} {ψ : ℝ} (hyy' : y' - y = e (ψ + 2 * π / 3)) {α α' : Arc} {B B' : Set ℂ}
    (hB : α.InitialPiece y (ψ + 7 * π / 6) B) (hB' : α'.InitialPiece y' (ψ + 7 * π / 6) B')
    (hBd : B ⊆ closedBall y' 1) (hB'd : B' ⊆ closedBall y 1) : ∃ z ∈ B, ∃ z' ∈ B', dist z z' < 1 := by
  sorry

/-- **FS116-Y4-FLANK**, the row's last clause (for any sets `a`, `b` whose closures hold the two edges: the row's tiles
bordering `t` along them, or `t` itself): some point of `cl a` and some point of `cl b` are nearer than `1`. -/
theorem flank (hF : F.Valid) {t : Set ℂ} (ht : F.IsTile t) {p : ℂ} {ψ : ℝ} (hy : ringPt p ψ ∈ closure t)
    (hy' : ringPt p (ψ + π / 3) ∈ closure t) {α α' : Arc} {B B' : Set ℂ}
    (hB : α.InitialPiece (ringPt p ψ) (ψ + 7 * π / 6) B) (hB' : α'.InitialPiece (ringPt p (ψ + π / 3)) (ψ + 7 * π / 6) B')
    (hBt : B ⊆ closure t) (hB't : B' ⊆ closure t) {a b : Set ℂ} (ha : B ⊆ closure a) (hb : B' ⊆ closure b) :
    ∃ z ∈ closure a, ∃ z' ∈ closure b, dist z z' < 1 := by
  sorry

end ArcMap

end HadwigerNelson.Plane
