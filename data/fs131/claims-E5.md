# FS131-E5 — the claim list: two steps the kernel could not take (fixed 2026-10-05 by Keryx)

*Every source below is copied by script from the address its heading names; nothing here is paraphrased. The questions are at the end.*

## Sources

### `n3_end` — branch `fs131-w5` at `a804de21`, `Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean`

```lean
/-- **FS112-N3-END** (NB3's corrected form): in a terminal valid map of the plane, let `v` be stuck with exactly three colours, its
two-sector colour `c` having a horn along `e α` whose lower arc has curvature `−1` (an arc of `ω(v − n)`). Then either `v − n` carries
at least four colours and a repeated colour and `v − 2n` is the centre of a both-kind unit arc, or the upper flank colour `g` is
in-type at `v + n` and both horns' upper arcs lie on `ω(v + n)` (`κ₂ = 1`; for the horn along `−a` its lower arc in its own frame).
The row's "and the chain is the single vertex" needs wave 5's stuck-chain vocabulary and is not stated here (§ 8 of the plan). -/
theorem n3_end (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {v : ℂ} {α κ₂ : ℝ} {c : Fin k} (hst : F.IsStuck v)
    (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) κ₂ c) :
    (4 ≤ (F.coloursAt (v - e (α + π / 2))).ncard ∧ F.HasRepeatedColour (v - e (α + π / 2)) ∧
        ∃ θ₁ θ₂, F.BothKind (v - 2 * e (α + π / 2)) θ₁ θ₂) ∨
      ∃ g, F.IsFlankAbove v α κ₂ g ∧ F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2)) ∧ κ₂ = 1 ∧
        ∀ κ₃ κ₄, F.IsHorn v (α + π) κ₃ κ₄ c → κ₃ = -1 := by
```

### `n3_end_of_not_inType` — the same file and commit

```lean
/-- **FS112-N3-END, its first case** (a child of `n3_end`, FS131-I5d): with no in-type upper-flank tile at `N`, the first disjunct — four colours and
a repeated colour at `S′ = v − n`, a both-kind unit arc centred at `v − 2n`. NB3-END items 2–5 (`plans/FS112-NB3-verification.md` l. 232–243) with
item 2's premise read as "no in-type `g`-tile at `N`" (FS131-I4m's reading, inventory items 288–289: NB3 leaves the case `κ₂ = 1`, `g ∉ P_cl(N)` to its
item 1, whose conclusion is not this statement): the `g`-shadow on both horns then comes from out-type `g`-tiles at `S′` tangent to `±a` (`srcG_of_shadow`
gives "in-type at `N` or out-type at `S′`"), two sectors of `g` at `S′`; `S′` terminal makes them horns; the colours `y ≠ z` beside the `+a` horn
(SHAVE otherwise); an in-type `y`-tile at `v − 2n` Siamese to the lower flank. The open part of `n3_end`. A step inside a refutation-shaped row: no
model expected. -/
theorem n3_end_of_not_inType (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {v : ℂ} {α κ₂ : ℝ} {c : Fin k}
    (hst : F.IsStuck v) (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) κ₂ c)
    (hno : ∀ g, F.IsFlankAbove v α κ₂ g → ¬ (F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2)))) :
    4 ≤ (F.coloursAt (v - e (α + π / 2))).ncard ∧ F.HasRepeatedColour (v - e (α + π / 2)) ∧
      ∃ θ₁ θ₂, F.BothKind (v - 2 * e (α + π / 2)) θ₁ θ₂ := by
```

### NB3-END items 1–5 — `plans/FS112-NB3-verification.md` l. 225–243

1. If an upper bound of `H_±` is `+1`, that arc lies on `ω(P_1)` with the horn colour `c` outside, and a stuck `P_1` would need `c` to fill its `+n` side
   against N112-U1 (N112-END's argument): the chain is `{P_0}`, doubly bounded. Otherwise both upper bounds are `< 1`.
2. No SHAVE at `v`: each horn needs a `g`-shadow. With upper bound `< 1` no in-type `g`-tile at `N` exists (the flank is not in `B̄(N, 1)`), other
   contacts are cleared (N3-CLEAR), and a `g`-tile at `S′` not tangent to `±a` shadows only `B(S′, 1)`, which `H_+` avoids. So `g` has tiles at `S′`
   tangent to `+a` and to `−a`, out-type relative to `v`. `c ∈ P_cl(S′)` (N3-DEG at `v`), its sectors in `α`'s away cone (U1), below: the two `g`-tiles are
   **two sectors** of `g` at `S′`.
3. Terminal at `S′`: no MERGE, so `int D_g(S′) = ∅` and (N3-DEG) `g`'s sectors are horns along `±a` with out-type contacts at `v` and `P_{−2}`.
4. The sector just below `g`'s `+a` horn lies in `α`'s side cone `(−ℓ, 0)`: colour `y ∉ {c, h}` (U1), `≠ g`. The sector just above it: `z ≠ g`, `≠ c`
   (away cone). **`z ≠ y`:** else both flanks are `y`; `y ∉ P_cl(v)`; a `y`-tile at `P_{−2}` would be Siamese to the lower flank (points at distance `< 1`
   from `P_{−2}` — or, for a horn flank, `≤ 1` only if its upper arc has curvature `−1`) and outer to the upper flank (points at distance `> 1`) — N-E2
   twice, so none exists unless a flank is a horn above curvature `−1`, where it is outer to both and its shadow, downward closed, would cover the lower
   flank. So the horn is `y`-clear and SHAVE applies: against terminal. **`P_{−1}` carries `c, g, y, z`, `g` twice.**
5. No SHAVE of that horn with `z ≠ y` needs a `y`-shadow on it; `y ∉ P_cl(v)`, an out-type `y` at `P_{−2}` shadows a downward-closed set meeting the lower
   flank, so the shadow is an in-type `y`-tile at `P_{−2}`, Siamese to the lower flank — possible only when the horn's lower arc is an arc of `ω(P_{−2})`
   (else the flank has points at distance `> 1` and `< 1` from `P_{−2}`). That arc has `s_in = y`, `s_out = g`, both in `P_cl(P_{−2})` (`g` out-type by 3):
   **a both-kind unit arc centred at `P_{−2}`** (so `P_{−2}` has `≥ 4` colours or a repeat, NB3-NOBOTH).

### 1.5 Summary of stage 1


### `bend_away` (repaired, unproved) — branch `fs131-w4ba` at `71cca146`, `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean`

```lean
/-- **FS112-N2-BENDS**, the away bend with the tangent bend (N2-AWAY and N2-TAN; FS112-BEND's away case is its special case): if the
inner colour is not carried at the centre and the radius-2 arc `R₂(ᾱ)` lies in the domain, the arc bends away from `P` everywhere but
along the arcs of R2 contact — for every `ε > 0` there is a valid map agreeing with `F` off the `ε`-neighbourhood of the closed arc and
creating no unit arc, in which an interior point of the arc still on an arc of `Γ` on `ω(P)` lies in a non-degenerate interval of `C₂(ᾱ)`
("isolated R2 contacts are cleared by a tangent bend, and only R2 along an arc blocks"), no colour but the inner one gains points, and
the inner one only outside `B(P, 1)` near the arc. The domain hypothesis is inventory items 290–291's repair: off the domain the inner
class's closure may meet `R₂(ᾱ)` in an infinite nowhere-dense set of angles, and then no local modification removes the arc
(the counterexample: `plans/FS131-I4-implementation.md`, Stage 41); with `R₂(ᾱ)` in the domain, `C₂(ᾱ)` is locally a finite union of
points and closed intervals. -/
theorem bend_away (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hin : c ∉ F.coloursAt P) (hdom : radiusTwoArc P θ₁ θ₂ ⊆ F.dom) {ε : ℝ} (hε : 0 < ε) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (thickening ε (ringArc P θ₁ θ₂)) ∧ F'.RingArcsWithin F ∧
      (∀ θ ∈ Ioo θ₁ θ₂, F'.OnRingArc P (ringPt P θ) →
        ∃ a b, a < b ∧ θ ∈ Icc a b ∧ Icc a b ⊆ F.r2Contacts P θ₁ θ₂ c) ∧
      (∀ j, j ≠ c → F'.region j ⊆ F.region j) ∧
      F'.region c ⊆ F.region c ∪ (thickening ε (ringArc P θ₁ θ₂) \ ball P 1) := by
```

with

```lean
def r2Contacts (P : ℂ) (θ₁ θ₂ : ℝ) (c : Fin k) : Set ℝ := {θ ∈ Icc θ₁ θ₂ | P + 2 * e θ ∈ closure (F.region c)}
```

### The two findings — `plans/FS131-close-inventory.md` items 305 (the GAP at NB3-END item 2) and 296 (`bend_away`'s route and its end case), read there in full

## The questions

**Q1 — NB3-END item 2.** In `n3_end_of_not_inType`'s setting, does "the two `g`-tiles are two sectors of `g` at `S′`" hold — in particular in item 305's configuration (one `g`-sector at `S′` with cone `[α+π, α+2π]`, `c` carried at `S′` only by a `c`-horn along `−a` on the `+n` side of it, possible only when `κ₄ < 1`)? Answer with a derivation of the step (I5e's leading-order repair, made exact with the closure property it names, or another), or that configuration exhibited exactly, or a repaired statement of `n3_end_of_not_inType` and `n3_end` with what changes in FS112-N3-END and in row 135.

**Q2 — `bend_away`'s end case.** In `bend_away`'s setting, at the arc's end `q_A`, where `ω(A)` (curvature 1) bounds the uncovered region beyond the arc's end (item 296's fourth piece), does the tangent bend go through? Answer with a derivation of the end case, or a configuration exhibited exactly, or a repaired statement of `bend_away`, with what changes in FS112-N2-BENDS (N2-TAN) and in row 135.
