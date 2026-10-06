import Proofs.HadwigerNelson.Plane.RingCalculus.SemiHub

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

Models: the strip's `P₀` at `P₂` and the bowtie's centre at `top` meet the hypotheses and the first alternative
(`data/fs116/n3/semi.out`; no Lean term). No held fragment has a three-colour semi-hub: the second alternative has no held
model, and whether the third occurs is open (SEMI-PAR3, FS-124). -/
theorem semiHub_places (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1) {ψ : ℝ}
    (hS : F.SimpleOn {p, ringPt p ψ, ringPt p (ψ + π / 3), ringPt p (ψ - π / 3)}) (h4 : 4 ≤ (F.coloursAt p).ncard)
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
  sorry

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
  sorry

/-- **FS116-N3-CROSS**, four colours: at a change point `y = r(ψ)` with the tip pair on (Q) arcs of disjoint colour pairs
`a | a'` (at `u⁺`) and `b | b'` (at `v⁻`), if `y` carries four colours and no more, its outer colours are `a'` and `b'` and
the colours absent at `y` are `a` and `b`. (The row's "every tile at `y` a cone of positive angle" is idle; so is the
freedom of the outer pair.) Model: the strip's `P₀` at `P₂` (`a = P`, `a' = O`, `b = M`, `b' = B`). -/
theorem crossed_four (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1) (hS : F.SimpleOn {p})
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k}
    (hy : F.IsChangePoint p ψ X X') {a a' b b' : Fin k} (hu : F.GermOnQWith p (ψ + π / 3) .ccw a a')
    (hv : F.GermOnQWith p (ψ - π / 3) .cw b b') (hab : Disjoint ({a, a'} : Set (Fin k)) {b, b'})
    (hy4 : (F.coloursAt (ringPt p ψ)).ncard = 4) :
    F.outerTileColours p (ringPt p ψ) = {a', b'} ∧ (F.coloursAt (ringPt p ψ))ᶜ = {a, b} := by
  sorry

/-- **FS116-N3-CROSS**, reciprocity, the change point: on a closed disc of radius above 2 about `p`, at a crossed full
semi-hub `y = r(ψ)` of kind O carrying four colours and no more, unless an edge of `p` runs along `ω(y)` at `p`
(`F.OnRingArc y p`), `p` is a change point of the ring of `y`, that ring being `b` just counter-clockwise of `p` and `a`
just clockwise. Model: the strip's `P₀` at `P₂` (`P₂`'s ring is `M` just counter-clockwise of `P₀` and `P` just clockwise). -/
theorem crossed_changePoint (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 2) (hS : F.SimpleOn {p})
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k}
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
last and reports the step if it does not close. Model: the strip's `P₀` at `P₂`, where `P₀` is a crossed full semi-hub of
kind O of `P₂`'s ring. -/
theorem crossed_semiHub (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 2) {ψ : ℝ}
    (hS : F.SimpleOn {p, ringPt p ψ}) (h4 : 4 ≤ (F.coloursAt p).ncard) (hk : k ≤ (F.coloursAt p).ncard + 2)
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
`crossed_semiHub`. (The row's "radius above 2" is read by the last two only.) -/
theorem transferQC (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1) {ψ : ℝ}
    (hS : F.SimpleOn {p, ringPt p ψ, ringPt p (ψ + π / 3), ringPt p (ψ - π / 3)}) (h4 : 4 ≤ (F.coloursAt p).ncard)
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
