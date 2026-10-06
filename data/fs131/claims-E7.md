# FS131-E7 — the claim list: a model or a contradiction for four hypothesis sets, and one question beside them

*Fixed by Keryx, 2026-10-06, before the job launches. Statements and definitions copied by script from `main` at `8d686f0b` (`n3_end_four_colours` from
branch `fs131-w5c`'s tree); no grade, no prior, no route. A later change is a dated line at the foot.*

## The statements

### a4six

```lean
/-- **FS112-A4SIX** (C-UA-BUDGET, branch 1), at the class its argument reads: a point `v` of a valid map at which exactly two colours
are absent (a four-colour vertex, at six colours), with no covering pair `(v, y)` on its unit circle, has on that circle arcs of `Γ`
of total length at least `60°`, or at least six, one inside each of six consecutive open `60°` windows. -/
theorem a4six (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {a b : Fin k} (hab : a ≠ b)
    (habs : (F.coloursAt v)ᶜ = {a, b}) (hno : ∀ y ∈ sphere v 1, ¬ F.IsCoveringPair v y) :
    ENNReal.ofReal (π / 3) ≤ arcLength {θ | F.OnRingArc v (ringPt v θ)} ∨
      ∃ x : ℝ, ∀ j : Fin 6, ∃ θ₁ θ₂, x + (j : ℕ) * (π / 3) < θ₁ ∧ θ₁ < θ₂ ∧ θ₂ < x + ((j : ℕ) + 1) * (π / 3) ∧
        ringArc v θ₁ θ₂ ⊆ F.Γ := by
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean` l. 6081*

### straddlers_third

```lean
/-- **The straddlers of `ω(y_{k+1})` at `y_k`** (child of NB4P; `plans/FS112-N-proof.md` § 2.1 W1 (ii), (1) and (3), with NB-4's half-plane
step): let `y_k = r(θ)` and `y_{k+1} = r(θ + 60°)` on `ω(v)`, both absent colours `X`, `X'` carried at `y_{k+1}`, and `y_k` on no arc of `Γ`
on `ω(y_{k+1})`. Then the germ of `ω(y_{k+1})` at `y_k` inside `B(v, 1)` lies in one colour `i`, the one outside `B̄(v, 1)` in one colour
`o ≠ i`; both are colours of `v` carried at `y_k` and not at `y_{k+1}`; and `v`'s class of `i` approaches `v` only along directions facing
`y_k`, that of `o` only along directions facing away. -/
theorem straddlers_third (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {θ : ℝ} {X X' : Fin k}
    (hcompl : (F.coloursAt v)ᶜ = {X, X'})
    (hX : X ∈ F.coloursAt (ringPt v (θ + π / 3))) (hX' : X' ∈ F.coloursAt (ringPt v (θ + π / 3)))
    (hna : ¬ F.OnRingArc (ringPt v (θ + π / 3)) (ringPt v θ)) :
    ∃ i o, i ≠ o ∧ i ∈ F.coloursAt v ∧ o ∈ F.coloursAt v ∧
      i ∉ F.coloursAt (ringPt v (θ + π / 3)) ∧ o ∉ F.coloursAt (ringPt v (θ + π / 3)) ∧
      i ∈ F.coloursAt (ringPt v θ) ∧ o ∈ F.coloursAt (ringPt v θ) ∧
      (∀ β ∈ coneAt (F.region i) v, 0 ≤ Real.cos (β - θ)) ∧ (∀ β ∈ coneAt (F.region o) v, Real.cos (β - θ) ≤ 0) := by
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean` l. 6203*

### nb4p

```lean
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
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/UnitArc.lean` l. 6317*

### flank_ne_of_doublyShadowed

```lean
/-- **A doubly shadowed horn has two different flank colours** (N4-STUCK (i)'s `g_± ≠ h_±`, by N4-FLANK's mechanism — FS131-IC4's
route): were the flanks one colour, the `g`-shadow reaching the horn would come from a `g`-sector at `S′` tangent to `+a`, whose
shadow also covers the lower flank near `v`, of that same colour, against validity. -/
theorem flank_ne_of_doublyShadowed (hF : F.Valid) (h5 : F.Condition5) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ}
    {g h : Fin k} (h1 : -1 < κ₁) (h12 : κ₁ < κ₂) (h2 : κ₂ < 1) (hg : F.IsFlankAbove v α κ₂ g)
    (hh : F.IsFlankBelow v α κ₁ h) (hD : F.DoublyShadowed v α κ₁ κ₂ g h) : g ≠ h := by
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` l. 1996*

### n3_end_four_colours (one of the family Q5 is about; on `fs131-w5c`, not yet on `main`)

```lean
/-- **NB3-END items 3–4** (`plans/FS112-NB3-verification.md` l. 238–241; NB3's, one mind, not re-derived by E5): in `n3_end_of_not_inType`'s
setting `S′ = v − n` carries at least four colours. Proved by a shorter route than NB3's items 3–4 (FS131-I5k): `S′` has a repeated colour
(`flank_two_sectors_at_S`) and the map is terminal, so `S′` is stuck (`isStuck_of_hasRepeatedColour`); with at most three colours it would be
a chain vertex, where every colour, `c` among them, approaches along both directions of one axis (`chainVertex_antipodal`), while U1 keeps
`c`'s cone at `S′` free of antipodal pairs (`not_antipodal_coneAt_S_of_horn`). NB3's colours `y ≠ z` beside `g`'s `+a` horn and its SHAVE
step are not needed. A step inside a refutation-shaped row: no model expected. -/
theorem n3_end_four_colours (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {v : ℂ} {α κ₂ : ℝ} {c : Fin k}
    (hst : F.IsStuck v) (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) κ₂ c)
    (hno : ∀ g, F.IsFlankAbove v α κ₂ g → ¬ (F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2)))) :
    4 ≤ (F.coloursAt (v - e (α + π / 2))).ncard := by
```
*source: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean` l. 1767*

## The definitions they use

```lean
/-- **Valid**: no two interior points of one colour at distance exactly `1`. -/
def Valid : Prop := ∀ x ∈ F.interiorPts, ∀ y ∈ F.interiorPts, dist x y = 1 → F.col x ≠ F.col y
```
*source: `Proofs/HadwigerNelson/Plane/ArcMap.lean` l. 109*

```lean
/-- `P_cl(x)`: the colours whose region has `x` in its closure. -/
def coloursAt (x : ℂ) : Set (Fin k) := {j | x ∈ closure (F.region j)}
```
*source: `Proofs/HadwigerNelson/Plane/ArcMap.lean` l. 106*

```lean
/-- The map is a fragment on the closed disc `B̄(p, R)`: its domain contains the disc. -/
def Covers (p : ℂ) (R : ℝ) : Prop := closedBall p R ⊆ F.dom
```
*source: `Proofs/HadwigerNelson/Plane/ArcMap.lean` l. 112*

```lean
/-- The map is a map of the whole plane. -/
def IsPlaneMap : Prop := F.dom = univ
```
*source: `Proofs/HadwigerNelson/Plane/ArcMap.lean` l. 115*

```lean
/-- The point `r(θ)` of the ring `ω(p)`. -/
noncomputable def ringPt (p : ℂ) (θ : ℝ) : ℂ := p + e θ
```
*source: `Proofs/HadwigerNelson/Plane/Basic.lean` l. 46*

```lean
/-- The closed sub-arc `r([θ₁, θ₂])` of `ω(p)`. -/
noncomputable def ringArc (p : ℂ) (θ₁ θ₂ : ℝ) : Set ℂ := ringPt p '' Icc θ₁ θ₂
```
*source: `Proofs/HadwigerNelson/Plane/LocalMap.lean` l. 135*

```lean
/-- The cone of `S` at `y`: the angles `β` along which `S` approaches `y`, i.e. the limits of the unit directions
`(z − y)/|z − y|` over points `z ∈ S`, `z ≠ y`, tending to `y`. -/
def coneAt (S : Set ℂ) (y : ℂ) : Set ℝ :=
  {β | ∀ ε > 0, ∃ z ∈ S, z ≠ y ∧ dist z y < ε ∧ ‖(z - y) / (‖z - y‖ : ℂ) - e β‖ < ε}
```
*source: `Proofs/HadwigerNelson/Plane/LocalMap.lean` l. 74*

```lean
/-- `x` lies on an arc of `Γ` on `ω(p)`: some sub-arc of `ω(p)` of positive length through `x` lies in `Γ`. -/
def OnRingArc (p x : ℂ) : Prop := ∃ θ₁ θ₂, θ₁ < θ₂ ∧ x ∈ ringArc p θ₁ θ₂ ∧ ringArc p θ₁ θ₂ ⊆ F.Γ
```
*source: `Proofs/HadwigerNelson/Plane/LocalMap.lean` l. 245*

```lean
/-- **An arc of `Γ` on `ω(p)` with constant sides**: the closed sub-arc `r([θ₁, θ₂])`, of positive length, lies in
`Γ`, and at each of its interior points the inner side carries the colour `c` alone and the outer side `c'` alone
(`c` is the arc's *inner colour*, `c'` its *outer colour*). -/
def IsRingArc (p : ℂ) (θ₁ θ₂ : ℝ) (c c' : Fin k) : Prop :=
  θ₁ < θ₂ ∧ ringArc p θ₁ θ₂ ⊆ F.Γ ∧
    ∀ θ ∈ Ioo θ₁ θ₂, F.innerColours p (ringPt p θ) = {c} ∧ F.outerColours p (ringPt p θ) = {c'}
```
*source: `Proofs/HadwigerNelson/Plane/LocalMap.lean` l. 258*

```lean
/-- **A change point** `y = r(ψ)` of the ring of `p`: a point of `Γ ∩ ω(p)` with the ring off `Γ` on both sides
(reading L), of colour `X` just counter-clockwise and of another colour `X'` (the rows' `X̄`) just clockwise. -/
def IsChangePoint (p : ℂ) (ψ : ℝ) (X X' : Fin k) : Prop :=
  ringPt p ψ ∈ F.Γ ∧ X ≠ X' ∧ GermIn p ψ .ccw (F.region X) ∧ GermIn p ψ .cw (F.region X')
```
*source: `Proofs/HadwigerNelson/Plane/LocalMap.lean` l. 277*

```lean
/-- **The horn** at `v` along `e α` between the arcs of upward curvatures `κ₁` (below) and `κ₂` (above), within `B(v, r)`:
`{z ∈ B(v, r) : (z − v)·a > 0, above the arc κ₁, below the arc κ₂}` — the rows' `{κ₁x²/2 < y < κ₂x²/2, x > 0}`, exactly. -/
def hornSet (v : ℂ) (α κ₁ κ₂ r : ℝ) : Set ℂ :=
  {z | dist z v < r ∧ 0 < frameX v α z ∧ TanAbove v α κ₁ z ∧ TanBelow v α κ₂ z}
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` l. 59*

```lean
/-- **The shadow** of `T`: the points whose unit circle meets `T` (`Sh(T)` of FS-110 N4-2; for a connected open `T` it is
`{z : dist(z, T) < 1 < sup_{p ∈ T} |z − p|}`). A valid map's tile never meets the shadow of a tile of its own colour. -/
def shadow (T : Set ℂ) : Set ℂ := {z | ∃ y ∈ T, dist z y = 1}
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` l. 76*

```lean
/-- `z` is **clear** for the colour `c`: at distance `≠ 1` from every point of `c`'s class (so `z` may be recoloured `c`). -/
def IsClear (c : Fin k) (z : ℂ) : Prop := ∀ y ∈ F.region c, dist z y ≠ 1
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` l. 83*

```lean
/-- **`s_c(v) = n`**: for every small radius, the colour `c` has exactly `n` sectors at `v`. -/
def HasSectors (v : ℂ) (c : Fin k) (n : ℕ) : Prop := ∀ᶠ r in 𝓝[>] (0 : ℝ), (F.sectorsOf v r c).encard = n
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` l. 96*

```lean
/-- **A `c`-horn** at `v` along `e α` with bounding curvatures `κ₁ < κ₂`: for every small `r` the horn set is a sector of the
map, of colour `c`. -/
def IsHorn (v : ℂ) (α κ₁ κ₂ : ℝ) (c : Fin k) : Prop :=
  κ₁ < κ₂ ∧ ∀ᶠ r in 𝓝[>] (0 : ℝ), F.IsSector v r (hornSet v α κ₁ κ₂ r) ∧ hornSet v α κ₁ κ₂ r ⊆ F.col ⁻¹' {c}
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` l. 109*

```lean
/-- The colour `g` lies directly above the horn's upper arc (curvature `κ₂`) near `v`: the **upper flank**. -/
def IsFlankAbove (v : ℂ) (α κ₂ : ℝ) (g : Fin k) : Prop :=
  ∃ κ', κ₂ < κ' ∧ ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ₂ κ' r ⊆ F.region g
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` l. 113*

```lean
/-- The colour `h` lies directly below the horn's lower arc (curvature `κ₁`) near `v`: the **lower flank**. -/
def IsFlankBelow (v : ℂ) (α κ₁ : ℝ) (h : Fin k) : Prop :=
  ∃ κ', κ' < κ₁ ∧ ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ' κ₁ r ⊆ F.region h
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` l. 117*

```lean
/-- **MERGE is available at `v`** (FS110-W-MERGE's hypothesis): some colour with at least two sectors at `v` has an allowed
cone with non-empty interior. -/
def MergeAvailable (v : ℂ) : Prop :=
  ∃ c n, 2 ≤ n ∧ F.HasSectors v c n ∧ (interior (F.allowedCone v c)).Nonempty
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` l. 143*

```lean
/-- **MERGE-RAY is available at `v`** (FS110-N4-SHAVE's N4-RAY): one colour has two horns along one ray. -/
def RayAvailable (v : ℂ) : Prop :=
  ∃ c α κ₁ κ₂ κ₃ κ₄, κ₂ < κ₃ ∧ F.IsHorn v α κ₁ κ₂ c ∧ F.IsHorn v α κ₃ κ₄ c
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` l. 147*

```lean
/-- **SHAVE is available at `v`** (FS110-N4-SHAVE): some horn, with flank colours `g` above and `h` below, splits along an arc
tangent to its axis, of a curvature `σ` between its bounding curvatures, into a lower part clear for `h` and an upper part
clear for `g` — so its tip may be recoloured by its two flanks. -/
def ShaveAvailable (v : ℂ) : Prop :=
  ∃ c g h α κ₁ κ₂ σ, F.IsHorn v α κ₁ κ₂ c ∧ F.IsFlankAbove v α κ₂ g ∧ F.IsFlankBelow v α κ₁ h ∧ κ₁ ≤ σ ∧ σ ≤ κ₂ ∧
    ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₁ κ₂ r,
      (TanAbove v α σ z → F.IsClear g z) ∧ (¬ TanAbove v α σ z → F.IsClear h z)
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` l. 153*

```lean
/-- **A doubly shadowed horn** (FS110-N4-SHAVE, `σ_h < σ_g`): a band of the horn between two tangent arcs lies, near `v`, in
the shadow of both flank colours' classes. -/
def DoublyShadowed (v : ℂ) (α κ₁ κ₂ : ℝ) (g h : Fin k) : Prop :=
  ∃ s₁ s₂, κ₁ ≤ s₁ ∧ s₁ < s₂ ∧ s₂ ≤ κ₂ ∧
    ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α s₁ s₂ r ⊆ shadow (F.region g) ∩ shadow (F.region h)
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` l. 160*

```lean
/-- **Terminal on `U`**: no MERGE, MERGE-RAY or SHAVE is available at any point of `U` (a fragment's local form; FS112-BOWTIE
is terminal on a neighbourhood of its three named points). -/
def TerminalOn (U : Set ℂ) : Prop := ∀ v ∈ U, ¬ F.MergeAvailable v ∧ ¬ F.RayAvailable v ∧ ¬ F.ShaveAvailable v
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` l. 166*

```lean
/-- **A terminal map** (FS110-N4-PROP): no MERGE, MERGE-RAY or SHAVE is available at any point. -/
def Terminal : Prop := F.TerminalOn univ
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` l. 169*

```lean
/-- **A stuck vertex** (FS110-N4-STUCK's hypothesis): no move is available at `v`, and some colour has at least two sectors
there. -/
def IsStuck (v : ℂ) : Prop :=
  ¬ F.MergeAvailable v ∧ ¬ F.RayAvailable v ∧ ¬ F.ShaveAvailable v ∧ ∃ c n, 2 ≤ n ∧ F.HasSectors v c n
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` l. 173*

```lean
/-- **Condition 5** (`[SokolovVoronov2025]`: "any boundary intersects with a circle of unit radius at a finite set of
points"), read on the arcs inside the domain. -/
def Condition5 : Prop := ∀ a ∈ F.arcs, ∀ p, (a.carrier ∩ F.dom ∩ sphere p 1).Finite
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` l. 205*

```lean
/-- **A covering pair** `(u, y)` (FS-110's claim list § 0 as corrected at its close, § 9 item 1: the union sense): the colours
carried at `u` and at `y` together are all the colours. Disjointness is not part of it. -/
def IsCoveringPair (u y : ℂ) : Prop := F.coloursAt u ∪ F.coloursAt y = univ
```
*source: `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` l. 233*

## The questions

**Q1 — `a4six`.** Is there a `k`, an `F : ArcMap k`, a point `v` and colours `a`, `b` satisfying `hF`, `hv`, `hab`, `habs` and `hno` at once? Answer with such an object exhibited exactly, each of the five checked on it; or with a derivation that the five are contradictory; or with the step where neither is reached.

**Q2 — `straddlers_third`.** Is there a `k`, an `F : ArcMap k`, a point `v`, an angle `θ` and colours `X`, `X'` satisfying `hF`, `hv`, `hcompl`, `hX`, `hX'` and `hna` at once? Answer in the same three forms.

**Q3 — `nb4p`.** The theorem concludes `False` from `hF`, `hv`, `h4`, `hy`, `hring` and `hnb`. Is there a `G : ArcMap 6` with `v`, `ψ`, `X`, `X'` satisfying the first four at once; one satisfying the first four with `hring`; and one satisfying the first four with `hnb`? Answer each in the same three forms.

**Q4 — `flank_ne_of_doublyShadowed`.** Is there a `k`, an `F : ArcMap k`, a point `v`, reals `α`, `κ₁`, `κ₂` and colours `g`, `h` satisfying `hF`, `h5`, `hv`, `h1`, `h12`, `h2`, `hg`, `hh` and `hD` at once? Answer in the same three forms.

**Q5 — a stuck vertex in a terminal map of the plane.** Is there a `k ≥ 7`, an `F : ArcMap k` and a point `v` with `F.Valid`, `F.IsPlaneMap`, `F.Terminal` and `F.IsStuck v`? Answer with such a map exhibited exactly, with a derivation that none exists, or with the step where neither is reached.

*Not claimed*: anything at six colours on a map of the plane (an object there is a valid six-map of the plane, the open problem); the truth of the five theorems (each is kernel-checked, or, for `n3_end_four_colours`, proved on its branch); any other theorem of FS131-QA4's lists.
