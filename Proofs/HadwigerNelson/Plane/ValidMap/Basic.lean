import Proofs.HadwigerNelson.Plane.LocalStructure

/-!
# Valid maps at a point: frames, horns, sectors, contacts, shadows, and the local moves

Wave 4's foundation (`plans/FS131-w4-kernel-plan.md` § 2), over wave 3's `Plane/LocalMap` and `Plane/LocalStructure`. The
vocabulary of FS-110's N3–N4 rounds (`plans/FS110-N-proof.md` § Continuation — FS110-N3, N4) and of FS-112's unit-arc calculus
(`data/fs112/claims.md` § 0), made point-set:

* **The frame at `v`** along the direction `e α`: `frameX`, `frameY` are the coordinates along `a = e α` and `n = i a`; the rows'
  `N = v + n`, `S′ = v − n`, `P_k = v + kn` are `v + k * n` with `n = e (α + π / 2)`.
* **Upward curvature.** The circle (or line) through `v` tangent to `a` with upward curvature `κ` is `tanHeight κ = 0`, and
  "above it" is `tanHeight κ > 0` (exact, not second order: every boundary arc is a circle or a line). The unit circles `ω(N)`
  and `ω(S′)` are the curvatures `1` and `−1` (`tanHeight_one_fromFrame`).
* **A horn** along `e α` between the arcs of curvatures `κ₁ < κ₂` is `hornSet v α κ₁ κ₂ r`; `IsHorn` says it is, for all small
  `r`, a sector of the map of one colour. A cusp horn has the single direction `α` as its cone.
* **Sectors** (`IsSector`): the components of the interior points in `B(v, r)` whose closure holds `v`; `HasSectors v c n` and
  `HasDegree v n` count them **for all small `r`** (as `encard`, so infinitely many is never counted as `0`). A cusp horn is one
  sector; "a repeated colour" is a colour with at least two sectors; "cubic trichromatic" is degree 3 with three colours.
* **Contacts** (`IsContact`, `InType`, `OutType`) of a colour `c ∈ P_cl(v)` on `ω(v)`, the **allowed cone** `allowedCone v c`
  (the rows' `D_c(v) = ⋂_in {d·e_w ≥ 0} ∩ ⋂_out {d·e_w ≤ 0}`, as a set of vectors), **clear** points (`IsClear`) and the
  **shadow** `shadow T = {z : ω(z) ∩ T ≠ ∅}`.
* **The moves' preconditions** (`MergeAvailable`, `RayAvailable`, `ShaveAvailable`), **terminal** maps and **stuck** vertices
  (N4-STUCK's hypothesis), and the doubly shadowed horn.
* **Unit arcs' contact kinds** (FS-112): in, out, both, inert, and (R2), over wave 3's `IsRingArc`.
* **Condition 5** (`[SokolovVoronov2025]`, read on an arc map) and the complexity class **`𝓜_K`** (`InMK`).

Every definition has a spec example below, and the structures the rows take have inhabitants (`ArcMap.const`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## The frame at a point and upward curvature -/

/-- The coordinate of `z` along `a = e α` in the frame at `v`: `(z − v)·a`. -/
noncomputable def frameX (v : ℂ) (α : ℝ) (z : ℂ) : ℝ := ((z - v) * starRingEnd ℂ (e α)).re

/-- The coordinate of `z` along `n = i·e α` in the frame at `v`: `(z − v)·n`. -/
noncomputable def frameY (v : ℂ) (α : ℝ) (z : ℂ) : ℝ := ((z - v) * starRingEnd ℂ (e α)).im

/-- The point with frame coordinates `(x, y)`: `v + (x + y i) e α`. -/
noncomputable def fromFrame (v : ℂ) (α x y : ℝ) : ℂ := v + ((x : ℂ) + (y : ℂ) * I) * e α

/-- The height of `(x, y)` above the circle through the origin tangent to the `x`-axis with upward curvature `κ` (the line
`y = 0` when `κ = 0`): `y − κ (x² + y²)/2`. The circle is its zero set; its centre side, near the origin, is the positive side
when `κ > 0`. -/
noncomputable def tanHeight (κ x y : ℝ) : ℝ := y - κ * (x ^ 2 + y ^ 2) / 2

/-- `z` lies strictly above (on the `+n` side of) the arc through `v` tangent to `e α` with upward curvature `κ`. -/
def TanAbove (v : ℂ) (α κ : ℝ) (z : ℂ) : Prop := 0 < tanHeight κ (frameX v α z) (frameY v α z)

/-- `z` lies strictly below the arc through `v` tangent to `e α` with upward curvature `κ`. -/
def TanBelow (v : ℂ) (α κ : ℝ) (z : ℂ) : Prop := tanHeight κ (frameX v α z) (frameY v α z) < 0

/-- **The horn** at `v` along `e α` between the arcs of upward curvatures `κ₁` (below) and `κ₂` (above), within `B(v, r)`:
`{z ∈ B(v, r) : (z − v)·a > 0, above the arc κ₁, below the arc κ₂}` — the rows' `{κ₁x²/2 < y < κ₂x²/2, x > 0}`, exactly. -/
def hornSet (v : ℂ) (α κ₁ κ₂ r : ℝ) : Set ℂ :=
  {z | dist z v < r ∧ 0 < frameX v α z ∧ TanAbove v α κ₁ z ∧ TanBelow v α κ₂ z}

/-- FS-110's curvature map going down the normal line (N4-SHADOW): an arc at `P_{k+1}` of upward curvature `λ` shadows at
`P_k` along the concentric circle of curvature `f(λ) = λ/(1 + λ)`. -/
noncomputable def curvDown (l : ℝ) : ℝ := l / (1 + l)

/-- FS-110's curvature map going up the normal line: `f̃(υ) = υ/(1 − υ)`, the inverse of `curvDown`. -/
noncomputable def curvUp (u : ℝ) : ℝ := u / (1 - u)

/-! ## The shadow of a set, and clear points -/

/-- The real dot product of two plane vectors, `d·u = Re(d ū)`. -/
noncomputable def dot (d u : ℂ) : ℝ := (d * starRingEnd ℂ u).re

/-- **The shadow** of `T`: the points whose unit circle meets `T` (`Sh(T)` of FS-110 N4-2; for a connected open `T` it is
`{z : dist(z, T) < 1 < sup_{p ∈ T} |z − p|}`). A valid map's tile never meets the shadow of a tile of its own colour. -/
def shadow (T : Set ℂ) : Set ℂ := {z | ∃ y ∈ T, dist z y = 1}

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- `z` is **clear** for the colour `c`: at distance `≠ 1` from every point of `c`'s class (so `z` may be recoloured `c`). -/
def IsClear (c : Fin k) (z : ℂ) : Prop := ∀ y ∈ F.region c, dist z y ≠ 1

/-! ## Sectors and degree -/

/-- **A sector** of the map at `v`, at radius `r`: a connected component of the interior points in `B(v, r)` whose closure
holds `v` (FS-110's "`c`-sector at `v`"; a cusp horn is one). -/
def IsSector (v : ℂ) (r : ℝ) (S : Set ℂ) : Prop :=
  ∃ x ∈ F.interiorPts ∩ ball v r, S = connectedComponentIn (F.interiorPts ∩ ball v r) x ∧ v ∈ closure S

/-- The sectors of colour `c` at `v`, at radius `r`. -/
def sectorsOf (v : ℂ) (r : ℝ) (c : Fin k) : Set (Set ℂ) := {S | F.IsSector v r S ∧ S ⊆ F.col ⁻¹' {c}}

/-- **`s_c(v) = n`**: for every small radius, the colour `c` has exactly `n` sectors at `v`. -/
def HasSectors (v : ℂ) (c : Fin k) (n : ℕ) : Prop := ∀ᶠ r in 𝓝[>] (0 : ℝ), (F.sectorsOf v r c).encard = n

/-- **The degree of `v` is `n`**: for every small radius, `v` has exactly `n` sectors. -/
def HasDegree (v : ℂ) (n : ℕ) : Prop := ∀ᶠ r in 𝓝[>] (0 : ℝ), {S | F.IsSector v r S}.encard = n

/-- **`v` carries a repeated colour**: some colour has at least two sectors at `v`, for every small radius. -/
def HasRepeatedColour (v : ℂ) : Prop := ∃ c, ∀ᶠ r in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf v r c).encard

/-- **A cubic trichromatic vertex**: degree `3` and three colours (so one sector per colour). -/
def IsCubicTrichromatic (v : ℂ) : Prop := F.HasDegree v 3 ∧ (F.coloursAt v).ncard = 3

/-- **A `c`-horn** at `v` along `e α` with bounding curvatures `κ₁ < κ₂`: for every small `r` the horn set is a sector of the
map, of colour `c`. -/
def IsHorn (v : ℂ) (α κ₁ κ₂ : ℝ) (c : Fin k) : Prop :=
  κ₁ < κ₂ ∧ ∀ᶠ r in 𝓝[>] (0 : ℝ), F.IsSector v r (hornSet v α κ₁ κ₂ r) ∧ hornSet v α κ₁ κ₂ r ⊆ F.col ⁻¹' {c}

/-- The colour `g` lies directly above the horn's upper arc (curvature `κ₂`) near `v`: the **upper flank**. -/
def IsFlankAbove (v : ℂ) (α κ₂ : ℝ) (g : Fin k) : Prop :=
  ∃ κ', κ₂ < κ' ∧ ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ₂ κ' r ⊆ F.region g

/-- The colour `h` lies directly below the horn's lower arc (curvature `κ₁`) near `v`: the **lower flank**. -/
def IsFlankBelow (v : ℂ) (α κ₁ : ℝ) (h : Fin k) : Prop :=
  ∃ κ', κ' < κ₁ ∧ ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α κ' κ₁ r ⊆ F.region h

/-! ## Contacts of a colour on a unit circle, and the allowed cone -/

/-- `w ∈ ω(v)` is **a contact of `c` at `v`**: `c` is carried at `v` and `w` lies in the closure of `c`'s class
(FS110-N3-CONF's `w ∈ cl(C_c°) ∩ ω(v)`). -/
def IsContact (v : ℂ) (c : Fin k) (w : ℂ) : Prop :=
  c ∈ F.coloursAt v ∧ dist w v = 1 ∧ w ∈ closure (F.region c)

/-- The contact `w` is **in-type**: every tile of colour `c` whose closure holds `w` lies in `B(v, 1)`. -/
def InType (v : ℂ) (c : Fin k) (w : ℂ) : Prop := ∀ T, F.TileOf c T → w ∈ closure T → T ⊆ ball v 1

/-- The contact `w` is **out-type**: every tile of colour `c` whose closure holds `w` misses `B̄(v, 1)`. -/
def OutType (v : ℂ) (c : Fin k) (w : ℂ) : Prop :=
  ∀ T, F.TileOf c T → w ∈ closure T → Disjoint T (closedBall v 1)

/-- **The allowed cone `D_c(v)`** (FS110-N3-CONF): the vectors `d` with `d·(w − v) ≥ 0` at every in-type contact `w` and
`d·(w − v) ≤ 0` at every out-type contact. A direction `β` is allowed when `e β` lies in it; `interior` is taken in `ℂ`. -/
def allowedCone (v : ℂ) (c : Fin k) : Set ℂ :=
  {d | ∀ w, F.IsContact v c w → (F.InType v c w → 0 ≤ dot d (w - v)) ∧ (F.OutType v c w → dot d (w - v) ≤ 0)}

/-! ## The local moves' preconditions, terminal maps, stuck vertices -/

/-- **MERGE is available at `v`** (FS110-W-MERGE's hypothesis): some colour with at least two sectors at `v` has an allowed
cone with non-empty interior. -/
def MergeAvailable (v : ℂ) : Prop :=
  ∃ c n, 2 ≤ n ∧ F.HasSectors v c n ∧ (interior (F.allowedCone v c)).Nonempty

/-- **MERGE-RAY is available at `v`** (FS110-N4-SHAVE's N4-RAY): one colour has two horns along one ray. -/
def RayAvailable (v : ℂ) : Prop :=
  ∃ c α κ₁ κ₂ κ₃ κ₄, κ₂ < κ₃ ∧ F.IsHorn v α κ₁ κ₂ c ∧ F.IsHorn v α κ₃ κ₄ c

/-- **SHAVE is available at `v`** (FS110-N4-SHAVE): some horn, with flank colours `g` above and `h` below, splits along an arc
tangent to its axis, of a curvature `σ` between its bounding curvatures, into a lower part clear for `h` and an upper part
clear for `g` — so its tip may be recoloured by its two flanks. -/
def ShaveAvailable (v : ℂ) : Prop :=
  ∃ c g h α κ₁ κ₂ σ, F.IsHorn v α κ₁ κ₂ c ∧ F.IsFlankAbove v α κ₂ g ∧ F.IsFlankBelow v α κ₁ h ∧ κ₁ ≤ σ ∧ σ ≤ κ₂ ∧
    ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₁ κ₂ r,
      (TanAbove v α σ z → F.IsClear g z) ∧ (¬ TanAbove v α σ z → F.IsClear h z)

/-- **A doubly shadowed horn** (FS110-N4-SHAVE, `σ_h < σ_g`): a band of the horn between two tangent arcs lies, near `v`, in
the shadow of both flank colours' classes. -/
def DoublyShadowed (v : ℂ) (α κ₁ κ₂ : ℝ) (g h : Fin k) : Prop :=
  ∃ s₁ s₂, κ₁ ≤ s₁ ∧ s₁ < s₂ ∧ s₂ ≤ κ₂ ∧
    ∀ᶠ r in 𝓝[>] (0 : ℝ), hornSet v α s₁ s₂ r ⊆ shadow (F.region g) ∩ shadow (F.region h)

/-- **Terminal on `U`**: no MERGE, MERGE-RAY or SHAVE is available at any point of `U` (a fragment's local form; FS112-BOWTIE
is terminal on a neighbourhood of its three named points). -/
def TerminalOn (U : Set ℂ) : Prop := ∀ v ∈ U, ¬ F.MergeAvailable v ∧ ¬ F.RayAvailable v ∧ ¬ F.ShaveAvailable v

/-- **A terminal map** (FS110-N4-PROP): no MERGE, MERGE-RAY or SHAVE is available at any point. -/
def Terminal : Prop := F.TerminalOn univ

/-- **A stuck vertex** (FS110-N4-STUCK's hypothesis): no move is available at `v`, and some colour has at least two sectors
there. -/
def IsStuck (v : ℂ) : Prop :=
  ¬ F.MergeAvailable v ∧ ¬ F.RayAvailable v ∧ ¬ F.ShaveAvailable v ∧ ∃ c n, 2 ≤ n ∧ F.HasSectors v c n

/-! ## Unit arcs: their contact kinds (FS-112) -/

/-- **An in-contact** (FS-112): an arc of `Γ` on `ω(p)` with constant sides whose inner colour is carried at its centre. -/
def InContact (p : ℂ) (θ₁ θ₂ : ℝ) : Prop := ∃ c c', F.IsRingArc p θ₁ θ₂ c c' ∧ c ∈ F.coloursAt p

/-- **An out-contact**: the outer colour is carried at the centre. -/
def OutContact (p : ℂ) (θ₁ θ₂ : ℝ) : Prop := ∃ c c', F.IsRingArc p θ₁ θ₂ c c' ∧ c' ∈ F.coloursAt p

/-- **A both-kind arc**: both side colours are carried at the centre. -/
def BothKind (p : ℂ) (θ₁ θ₂ : ℝ) : Prop :=
  ∃ c c', F.IsRingArc p θ₁ θ₂ c c' ∧ c ∈ F.coloursAt p ∧ c' ∈ F.coloursAt p

/-- **An inert arc**: neither side colour is carried at the centre. -/
def Inert (p : ℂ) (θ₁ θ₂ : ℝ) : Prop :=
  ∃ c c', F.IsRingArc p θ₁ θ₂ c c' ∧ c ∉ F.coloursAt p ∧ c' ∉ F.coloursAt p

/-- `R₂(ᾱ)`: the arc of the circle of radius `2` about `p` over the angles of `ᾱ = r([θ₁, θ₂])`. -/
noncomputable def radiusTwoArc (p : ℂ) (θ₁ θ₂ : ℝ) : Set ℂ := (fun θ => p + 2 * e θ) '' Icc θ₁ θ₂

/-- **An (R2) arc** (FS-112's header): its centre carries the outer side colour and not the inner, and the inner colour's
class has the whole radius-2 arc `R₂(ᾱ)` in its closure. -/
def IsR2Arc (p : ℂ) (θ₁ θ₂ : ℝ) : Prop :=
  ∃ c c', F.IsRingArc p θ₁ θ₂ c c' ∧ c' ∈ F.coloursAt p ∧ c ∉ F.coloursAt p ∧
    radiusTwoArc p θ₁ θ₂ ⊆ closure (F.region c)

/-! ## Condition 5 and the complexity class -/

/-- **Condition 5** (`[SokolovVoronov2025]`: "any boundary intersects with a circle of unit radius at a finite set of
points"), read on the arcs inside the domain. -/
def Condition5 : Prop := ∀ a ∈ F.arcs, ∀ p, (a.carrier ∩ F.dom ∩ sphere p 1).Finite

/-- **Condition 6** (`[SokolovVoronov2025]`: "There are no trichromatic vertices of degree greater than 3"), read on an arc map: a
point carrying exactly three colours has degree at most `3` (its degree is its number of sectors, `HasDegree`). FS106-TS-T's last
clause (`Plane/SVMap`). -/
def Condition6 : Prop := ∀ x n, (F.coloursAt x).ncard = 3 → F.HasDegree x n → n ≤ 3

/-- **`𝓜_K`** (FS-107, without periodicity, as for the limit object): circular arcs of radius at least `1/K`, and at most `K`
arcs meeting the domain inside any unit disc. -/
def InMK (K : ℕ) : Prop :=
  (∀ a ∈ F.arcs, ∀ c ρ θ₀ θ₁, a = .circ c ρ θ₀ θ₁ → 1 / (K : ℝ) ≤ ρ) ∧
    ∀ x, {a | a ∈ F.arcs ∧ (a.carrier ∩ F.dom ∩ ball x 1).Nonempty}.encard ≤ K

/-! ## Local modifications: agreement off a set, and no new unit arc -/

/-- **`F'` agrees with `F` off `U`**: the same domain, and outside `U` the same interior points with the same colours. Every
local move of the wave (W-MERGE, MERGE-RAY, SHAVE, the whole-arc bends) produces a map agreeing with the old one off a small
set; off the closure of that set the two maps have the same regions, tiles and colours at every point. -/
def AgreesOff (F' : ArcMap k) (U : Set ℂ) : Prop :=
  F'.dom = F.dom ∧ ∀ z ∉ U, (z ∈ F'.interiorPts ↔ z ∈ F.interiorPts) ∧ F'.col z = F.col z

/-- **`F` creates no unit arc over `G`**: every point of an arc of `Γ` on a unit circle `ω(p)` in `F` lies on such an arc of
`G` with the same centre (FS112-WALK's reading of "Condition 5 kept": "no unit arc created"). Presentation-free: it reads
`Γ`, never `F.arcs`, as wave 3's `OnRingArc` does; with `G.Condition5` it gives `F.Condition5` back. -/
def RingArcsWithin (G : ArcMap k) : Prop := ∀ p x, F.OnRingArc p x → G.OnRingArc p x

/-- **A covering pair** `(u, y)` (FS-110's claim list § 0 as corrected at its close, § 9 item 1: the union sense): the colours
carried at `u` and at `y` together are all the colours. Disjointness is not part of it. -/
def IsCoveringPair (u y : ℂ) : Prop := F.coloursAt u ∪ F.coloursAt y = univ

end ArcMap

/-! ## Engines 1–2: validity transfer, and no new unit arc from a `Γ` inclusion -/

namespace ArcMap

variable {k : ℕ} {F F' : ArcMap k}

/-- **The validity transfer** (wave 4's engine 1): a map agreeing with a valid map off `U`, each of whose interior points in
`U` is clear in the old map for its new colour, with no unit pair of one colour among its interior points in `U`, is valid.
Every local move's validity is then its clearness. -/
theorem Valid.of_agreesOff (hF : F.Valid) {U : Set ℂ} (hA : F'.AgreesOff F U)
    (hclear : ∀ z ∈ U ∩ F'.interiorPts, F.IsClear (F'.col z) z)
    (hUU : ∀ z ∈ U ∩ F'.interiorPts, ∀ y ∈ U ∩ F'.interiorPts, dist z y = 1 → F'.col z ≠ F'.col y) :
    F'.Valid := by
  intro x hx y hy hxy
  by_cases hxU : x ∈ U <;> by_cases hyU : y ∈ U
  · exact hUU x ⟨hxU, hx⟩ y ⟨hyU, hy⟩ hxy
  · obtain ⟨hyi, hyc⟩ := hA.2 y hyU
    have hy' : y ∈ F.interiorPts := hyi.mpr hy
    intro hcol
    refine hclear x ⟨hxU, hx⟩ y ⟨hy', ?_⟩ hxy
    show F.col y = F'.col x
    rw [hyc, hcol]
  · obtain ⟨hxi, hxc⟩ := hA.2 x hxU
    have hx' : x ∈ F.interiorPts := hxi.mpr hx
    intro hcol
    refine hclear y ⟨hyU, hy⟩ x ⟨hx', ?_⟩ (by rw [dist_comm]; exact hxy)
    show F.col x = F'.col y
    rw [hxc, hcol]
  · obtain ⟨hxi, hxc⟩ := hA.2 x hxU
    obtain ⟨hyi, hyc⟩ := hA.2 y hyU
    have := hF x (hxi.mpr hx) y (hyi.mpr hy) hxy
    rwa [hxc, hyc] at this

/-- A point of a closed sub-arc of positive length of `ω(p)` is a limit of the sub-arc's points off any finite set. -/
theorem mem_closure_ringArc_diff_finite {p : ℂ} {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) {C : Set ℂ} (hC : C.Finite) {y : ℂ}
    (hy : y ∈ ringArc p θ₁ θ₂) : y ∈ closure (ringArc p θ₁ θ₂ \ C) := by
  obtain ⟨θ, hθ, rfl⟩ := hy
  rw [Metric.mem_closure_iff]
  intro ε hε
  have hπ := Real.pi_pos
  set η := min ε π with hη
  have hη0 : 0 < η := lt_min hε hπ
  -- an open interval of angles inside `[θ₁, θ₂]` within `η` of `θ`
  obtain ⟨a, b, hab, hJ⟩ : ∃ a b, a < b ∧ Ioo a b ⊆ Icc θ₁ θ₂ ∩ Ioo (θ - η) (θ + η) := by
    rcases lt_or_eq_of_le hθ.2 with h | h
    · refine ⟨θ, min θ₂ (θ + η), lt_min h (by linarith), fun t ht => ⟨⟨by linarith [hθ.1, ht.1], ?_⟩, by linarith [ht.1], ?_⟩⟩
      · linarith [ht.2, min_le_left θ₂ (θ + η)]
      · linarith [ht.2, min_le_right θ₂ (θ + η)]
    · refine ⟨max θ₁ (θ - η), θ, max_lt (by linarith) (by linarith), fun t ht => ⟨⟨?_, by linarith [ht.2]⟩, ?_, by linarith [ht.2]⟩⟩
      · linarith [ht.1, le_max_left θ₁ (θ - η)]
      · linarith [ht.1, le_max_right θ₁ (θ - η)]
  have hinj : InjOn (ringPt p) (Ioo a b) := by
    intro s hs s' hs' hss
    have hss' : spherePt p 1 s = spherePt p 1 s' := by simpa [spherePt, ringPt] using hss
    have hJs := hJ hs; have hJs' := hJ hs'
    exact injOn_spherePt p one_pos (θ - η) ⟨hJs.2.1, by linarith [hJs.2.2, min_le_right ε π]⟩
      ⟨hJs'.2.1, by linarith [hJs'.2.2, min_le_right ε π]⟩ hss'
  have hinf : (ringPt p '' Ioo a b).Infinite := (Ioo_infinite hab).image hinj
  obtain ⟨_, ⟨t, ht, rfl⟩, htC⟩ := (hinf.sdiff hC).nonempty
  refine ⟨ringPt p t, ⟨⟨t, (hJ ht).1, rfl⟩, htC⟩, ?_⟩
  rw [dist_eq_norm, ringPt, ringPt, show p + e θ - (p + e t) = e θ - e t by ring]
  calc ‖e θ - e t‖ ≤ |θ - t| := norm_e_sub_e_le θ t
    _ < η := by rw [abs_lt]; constructor <;> linarith [(hJ ht).2.1, (hJ ht).2.2]
    _ ≤ ε := min_le_left _ _

/-- The closed sub-arc `r([θ₁, θ₂])` lies in `Γ` once it lies in the domain and, off a finite set, in `Γ` (`Γ` is closed in the
domain: near each point finitely many closed arcs). -/
theorem ringArc_subset_Γ_of_finite {p : ℂ} {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) (hdom : ringArc p θ₁ θ₂ ⊆ F.dom) {C : Set ℂ}
    (hC : C.Finite) (hsub : ringArc p θ₁ θ₂ \ C ⊆ F.Γ) : ringArc p θ₁ θ₂ ⊆ F.Γ := by
  intro y hy
  have hyd := hdom hy
  refine ⟨hyd, ?_⟩
  obtain ⟨t, ht, hfin⟩ := F.locallyFinite y hyd
  set D := ⋃ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ t).Nonempty}, a.carrier with hD
  have hDc : IsClosed D := hfin.isClosed_biUnion fun a _ => a.isClosed_carrier
  have hyD : y ∈ D := by
    have hcl := mem_closure_ringArc_diff_finite h12 hC hy
    rw [← hDc.closure_eq]
    rw [Metric.mem_closure_iff] at hcl ⊢
    obtain ⟨r, hr, hrt⟩ := Metric.mem_nhds_iff.mp ht
    intro ε hε
    obtain ⟨z, hz, hzd⟩ := hcl (min ε r) (lt_min hε hr)
    have hzt : z ∈ t := hrt (by rw [mem_ball, dist_comm]; exact lt_of_lt_of_le hzd (min_le_right _ _))
    obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp (hsub hz).2
    exact ⟨z, mem_iUnion₂.mpr ⟨a, ⟨ha, z, hza, hzt⟩, hza⟩, lt_of_lt_of_le hzd (min_le_left _ _)⟩
  obtain ⟨a, ha, hya⟩ := mem_iUnion₂.mp hyD
  exact mem_iUnion₂.mpr ⟨a, ha.1, hya⟩

/-- **No new unit arc from a `Γ` inclusion** (wave 4's engine 2, `plans/FS131-w4-kernel-plan.md` § 13.1): a map `F'` on the same
domain whose `Γ` lies in `F.Γ` together with the carriers of a family `A'` of non-degenerate arcs, locally finite on the domain, none
of them a unit arc, creates no unit arc over `F`: every sub-arc of positive length of a unit circle in `F'.Γ` lies in `F.Γ`. (A
sub-arc meets the finitely many nearby `A'`-carriers in finitely many points, `Arc.finite_inter_sphere_or_eq_circ`; off them it lies
in `F.Γ`, which is closed in the domain.) Consumers: the six moves. -/
theorem ringArcsWithin_of_Γ_subset (hdom : F'.dom = F.dom) {A' : Set Arc} (hnd : ∀ a ∈ A', a.Nondegenerate)
    (hlf : ∀ x ∈ F.dom, ∃ t ∈ 𝓝 x, {a | a ∈ A' ∧ (a.carrier ∩ t).Nonempty}.Finite) (hunit : ∀ a ∈ A', ¬ a.IsUnitArc)
    (hΓ : F'.Γ ⊆ F.Γ ∪ ⋃ a ∈ A', a.carrier) : F'.RingArcsWithin F := by
  rintro p x ⟨θ₁, θ₂, h12, hx, hsub⟩
  refine ⟨θ₁, θ₂, h12, hx, ?_⟩
  have hdomF : ringArc p θ₁ θ₂ ⊆ F.dom := fun y hy => hdom ▸ (hsub hy).1
  -- finitely many arcs of `A'` meet the compact sub-arc
  choose! t ht hfin using hlf
  have hK : IsCompact (ringArc p θ₁ θ₂) := isCompact_Icc.image (by unfold ringPt e; fun_prop)
  obtain ⟨S, hSK, hcov⟩ := hK.elim_nhds_subcover t fun y hy => ht y (hdomF hy)
  have h𝒜 : {a | a ∈ A' ∧ (a.carrier ∩ ringArc p θ₁ θ₂).Nonempty}.Finite := by
    refine (S.finite_toSet.biUnion fun y hy => hfin y (hdomF (hSK y hy))).subset ?_
    rintro a ⟨ha, z, hza, hzK⟩
    obtain ⟨y, hyS, hzy⟩ := mem_iUnion₂.mp (hcov hzK)
    exact mem_iUnion₂.mpr ⟨y, hyS, ha, z, hza, hzy⟩
  set C := ⋃ a ∈ {a | a ∈ A' ∧ (a.carrier ∩ ringArc p θ₁ θ₂).Nonempty}, a.carrier ∩ sphere p 1 with hCdef
  have hC : C.Finite := by
    refine h𝒜.biUnion fun a ha => ?_
    rcases Arc.finite_inter_sphere_or_eq_circ a (hnd a ha.1) p with h | ⟨θa, θb, rfl⟩
    · exact h
    · exact absurd rfl (hunit _ ha.1)
  refine ringArc_subset_Γ_of_finite h12 hdomF hC fun y ⟨hy, hyC⟩ => ?_
  rcases hΓ (hsub hy) with h | h
  · exact h
  · exfalso
    obtain ⟨a, ha, hya⟩ := mem_iUnion₂.mp h
    have hysph : y ∈ sphere p 1 := by obtain ⟨θ, -, rfl⟩ := hy; exact ringPt_mem_sphere p θ
    exact hyC (mem_iUnion₂.mpr ⟨a, ⟨ha, y, hya, hy⟩, hya, hysph⟩)

end ArcMap

/-! ## The frame algebra (wave 4's engine 4): a point against `N`, `S′` and the circles of the pencil -/

/-- The unit normal at `v` along `e α` is `i · e α`. -/
theorem e_add_pi_div_two (α : ℝ) : e (α + π / 2) = I * e α := by
  rw [e_add, mul_comm]
  congr 1
  rw [e_eq]; simp

/-- The frame's two coordinates are the plane's norm: `x² + y² = ‖z − v‖²`. -/
theorem frame_normSq (v : ℂ) (α : ℝ) (z : ℂ) :
    frameX v α z ^ 2 + frameY v α z ^ 2 = ‖z - v‖ ^ 2 := by
  unfold frameX frameY
  have h := Complex.sq_norm ((z - v) * starRingEnd ℂ (e α))
  rw [Complex.normSq_apply, norm_mul, RCLike.norm_conj, norm_e, mul_one] at h
  nlinarith [h]

/-- The distance to the point `v + c n` of the normal line, in frame coordinates: `x² + (y − c)²`. -/
theorem sq_dist_normalPt (v : ℂ) (α c : ℝ) (z : ℂ) :
    ‖z - (v + (c : ℂ) * e (α + π / 2))‖ ^ 2 = frameX v α z ^ 2 + (frameY v α z - c) ^ 2 := by
  have hce : (e α) * starRingEnd ℂ (e α) = 1 := by
    rw [Complex.mul_conj, Complex.normSq_eq_norm_sq]; simp
  have h : z - (v + (c : ℂ) * e (α + π / 2)) = ((z - v) * starRingEnd ℂ (e α) - (c * I)) * e α := by
    rw [e_add_pi_div_two]
    calc z - (v + (c : ℂ) * (I * e α)) = (z - v) - c * I * e α := by ring
      _ = ((z - v) * (e α * starRingEnd ℂ (e α)) - c * I * e α) := by rw [hce]; ring
      _ = _ := by ring
  have h1 : ‖z - (v + (c : ℂ) * e (α + π / 2))‖ = ‖(z - v) * starRingEnd ℂ (e α) - (c * I)‖ := by
    rw [h, norm_mul, norm_e, mul_one]
  rw [h1, Complex.sq_norm, Complex.normSq_apply]
  unfold frameX frameY
  simp
  ring

/-- `dist z N` squared, `N = v + n`: `x² + (y − 1)²`. -/
theorem sq_dist_N (v : ℂ) (α : ℝ) (z : ℂ) :
    dist z (v + e (α + π / 2)) ^ 2 = frameX v α z ^ 2 + (frameY v α z - 1) ^ 2 := by
  have := sq_dist_normalPt v α 1 z
  rw [dist_eq_norm]
  simpa using this

/-- `dist z S′` squared, `S′ = v − n`: `x² + (y + 1)²`. -/
theorem sq_dist_S (v : ℂ) (α : ℝ) (z : ℂ) :
    dist z (v - e (α + π / 2)) ^ 2 = frameX v α z ^ 2 + (frameY v α z + 1) ^ 2 := by
  have := sq_dist_normalPt v α (-1) z
  rw [dist_eq_norm]
  have h2 : v + ((-1 : ℝ) : ℂ) * e (α + π / 2) = v - e (α + π / 2) := by push_cast; ring
  rw [h2] at this
  rw [this]; ring

theorem lt_iff_sq_lt_sq' {d r : ℝ} (hd : 0 ≤ d) (hr : 0 ≤ r) : d < r ↔ d ^ 2 < r ^ 2 :=
  (pow_lt_pow_iff_left₀ hd hr (by norm_num)).symm

/-- **Above `ω(N)`'s arc** (curvature `1`): `z` is inside the unit disc about `N`. -/
theorem tanAbove_one_iff (v : ℂ) (α : ℝ) (z : ℂ) : TanAbove v α 1 z ↔ dist z (v + e (α + π / 2)) < 1 := by
  have h := sq_dist_N v α z
  rw [lt_iff_sq_lt_sq' dist_nonneg zero_le_one, h]
  unfold TanAbove tanHeight
  constructor <;> intro h <;> nlinarith [h]

/-- **Below `ω(N)`'s arc**: `z` is outside the unit disc about `N`. -/
theorem tanBelow_one_iff (v : ℂ) (α : ℝ) (z : ℂ) : TanBelow v α 1 z ↔ 1 < dist z (v + e (α + π / 2)) := by
  have h := sq_dist_N v α z
  rw [lt_iff_sq_lt_sq' zero_le_one dist_nonneg, h]
  unfold TanBelow tanHeight
  constructor <;> intro h <;> nlinarith [h]

/-- **Above `ω(S′)`'s arc** (curvature `−1`): `z` is outside the unit disc about `S′`. -/
theorem tanAbove_neg_one_iff (v : ℂ) (α : ℝ) (z : ℂ) :
    TanAbove v α (-1) z ↔ 1 < dist z (v - e (α + π / 2)) := by
  have h := sq_dist_S v α z
  rw [lt_iff_sq_lt_sq' zero_le_one dist_nonneg, h]
  unfold TanAbove tanHeight
  constructor <;> intro h <;> nlinarith [h]

/-- **Below `ω(S′)`'s arc**: `z` is inside the unit disc about `S′`. -/
theorem tanBelow_neg_one_iff (v : ℂ) (α : ℝ) (z : ℂ) :
    TanBelow v α (-1) z ↔ dist z (v - e (α + π / 2)) < 1 := by
  have h := sq_dist_S v α z
  rw [lt_iff_sq_lt_sq' dist_nonneg zero_le_one, h]
  unfold TanBelow tanHeight
  constructor <;> intro h <;> nlinarith [h]

/-- The height above the arc of curvature `κ ≠ 0` is a multiple of the power of the point against its circle. -/
theorem tanHeight_eq_of_ne_zero {κ : ℝ} (hκ : κ ≠ 0) (x y : ℝ) :
    tanHeight κ x y = -(κ / 2) * (x ^ 2 + (y - 1 / κ) ^ 2 - (1 / κ) ^ 2) := by
  unfold tanHeight
  field_simp
  ring

/-- For `κ > 0`, above the arc of curvature `κ` is inside the circle of radius `1/κ` about `v + n/κ` (the `κ = 1` case is
`tanAbove_one_iff`). -/
theorem tanAbove_iff_of_pos (v : ℂ) (α : ℝ) {κ : ℝ} (hκ : 0 < κ) (z : ℂ) :
    TanAbove v α κ z ↔ dist z (v + ((1 / κ : ℝ) : ℂ) * e (α + π / 2)) < 1 / κ := by
  have h := sq_dist_normalPt v α (1 / κ) z
  rw [lt_iff_sq_lt_sq' dist_nonneg (by positivity), dist_eq_norm, h]
  unfold TanAbove
  rw [tanHeight_eq_of_ne_zero hκ.ne']
  have : 0 < κ / 2 := by positivity
  constructor <;> intro h <;> nlinarith [h]

/-- For `κ > 0`, below the arc of curvature `κ` is outside the circle of radius `1/κ` about `v + n/κ`. -/
theorem tanBelow_iff_of_pos (v : ℂ) (α : ℝ) {κ : ℝ} (hκ : 0 < κ) (z : ℂ) :
    TanBelow v α κ z ↔ 1 / κ < dist z (v + ((1 / κ : ℝ) : ℂ) * e (α + π / 2)) := by
  have h := sq_dist_normalPt v α (1 / κ) z
  rw [lt_iff_sq_lt_sq' (by positivity) dist_nonneg, dist_eq_norm, h]
  unfold TanBelow
  rw [tanHeight_eq_of_ne_zero hκ.ne']
  have : 0 < κ / 2 := by positivity
  constructor <;> intro h <;> nlinarith [h]

/-- `e α · conj (e α) = 1`. -/
theorem conj_e_mul_e (α : ℝ) : (e α) * starRingEnd ℂ (e α) = 1 := by
  rw [Complex.mul_conj, Complex.normSq_eq_norm_sq]; simp

/-- Frame coordinates are additive: `frameX z − frameX w` is the real part of `(z − w) ē`. -/
theorem frameX_sub (v : ℂ) (α : ℝ) (z w : ℂ) :
    frameX v α z - frameX v α w = ((z - w) * starRingEnd ℂ (e α)).re := by
  unfold frameX; rw [← Complex.sub_re]; congr 1; ring

/-- `frameY z − frameY w` is the imaginary part of `(z − w) ē`. -/
theorem frameY_sub (v : ℂ) (α : ℝ) (z w : ℂ) :
    frameY v α z - frameY v α w = ((z - w) * starRingEnd ℂ (e α)).im := by
  unfold frameY; rw [← Complex.sub_im]; congr 1; ring

/-- **The frame is an isometry**: `dist z w² = Δx² + Δy²` in the frame at any `v`. -/
theorem sq_dist_frame (v : ℂ) (α : ℝ) (z w : ℂ) :
    dist z w ^ 2 = (frameX v α z - frameX v α w) ^ 2 + (frameY v α z - frameY v α w) ^ 2 := by
  rw [frameX_sub, frameY_sub, dist_eq_norm]
  have h := Complex.sq_norm ((z - w) * starRingEnd ℂ (e α))
  rw [Complex.normSq_apply, norm_mul, RCLike.norm_conj, norm_e, mul_one] at h
  nlinarith [h]

/-- Moving along the normal `n` changes only the `y` coordinate: `x` is kept. -/
theorem frameX_add_normal (v : ℂ) (α t : ℝ) (z : ℂ) :
    frameX v α (z + (t : ℂ) * e (α + π / 2)) = frameX v α z := by
  unfold frameX
  have : (z + (t : ℂ) * e (α + π / 2) - v) * starRingEnd ℂ (e α) =
      (z - v) * starRingEnd ℂ (e α) + t * I := by
    rw [e_add_pi_div_two]
    have := conj_e_mul_e α
    calc _ = (z - v) * starRingEnd ℂ (e α) + t * I * (e α * starRingEnd ℂ (e α)) := by ring
      _ = _ := by rw [this]; ring
  rw [this]; simp

/-- Moving by `t n` adds `t` to the `y` coordinate. -/
theorem frameY_add_normal (v : ℂ) (α t : ℝ) (z : ℂ) :
    frameY v α (z + (t : ℂ) * e (α + π / 2)) = frameY v α z + t := by
  unfold frameY
  have : (z + (t : ℂ) * e (α + π / 2) - v) * starRingEnd ℂ (e α) =
      (z - v) * starRingEnd ℂ (e α) + t * I := by
    rw [e_add_pi_div_two]
    have := conj_e_mul_e α
    calc _ = (z - v) * starRingEnd ℂ (e α) + t * I * (e α * starRingEnd ℂ (e α)) := by ring
      _ = _ := by rw [this]; ring
  rw [this]; simp

/-- `v` has frame coordinates `(0, 0)`. -/
theorem frameX_self (v : ℂ) (α : ℝ) : frameX v α v = 0 := by simp [frameX]
/-- `v` has frame coordinates `(0, 0)`. -/
theorem frameY_self (v : ℂ) (α : ℝ) : frameY v α v = 0 := by simp [frameY]

/-- `N = v + n` has frame coordinates `(0, 1)`. -/
theorem frameX_N (v : ℂ) (α : ℝ) : frameX v α (v + e (α + π / 2)) = 0 := by
  have := frameX_add_normal v α 1 v; simp at this; rw [this, frameX_self]
/-- `N = v + n` has frame coordinates `(0, 1)`. -/
theorem frameY_N (v : ℂ) (α : ℝ) : frameY v α (v + e (α + π / 2)) = 1 := by
  have := frameY_add_normal v α 1 v; simp at this; rw [this, frameY_self]; ring
/-- `S′ = v − n` has frame coordinates `(0, −1)`. -/
theorem frameX_S (v : ℂ) (α : ℝ) : frameX v α (v - e (α + π / 2)) = 0 := by
  have := frameX_add_normal v α (-1) v; simp at this; rw [sub_eq_add_neg, this, frameX_self]
/-- `S′ = v − n` has frame coordinates `(0, −1)`. -/
theorem frameY_S (v : ℂ) (α : ℝ) : frameY v α (v - e (α + π / 2)) = -1 := by
  have := frameY_add_normal v α (-1) v; simp at this; rw [sub_eq_add_neg, this, frameY_self]; ring

/-- For `κ < 0`, above the arc of curvature `κ` is outside the circle of radius `−1/κ` about `v + n/κ`. -/
theorem tanAbove_iff_of_neg (v : ℂ) (α : ℝ) {κ : ℝ} (hκ : κ < 0) (z : ℂ) :
    TanAbove v α κ z ↔ -(1 / κ) < dist z (v + ((1 / κ : ℝ) : ℂ) * e (α + π / 2)) := by
  have h := sq_dist_normalPt v α (1 / κ) z
  have hc : 0 < -(1 / κ) := by have : 1 / κ < 0 := by rw [one_div]; exact inv_lt_zero.mpr hκ
                               linarith
  rw [lt_iff_sq_lt_sq' hc.le dist_nonneg, dist_eq_norm, h]
  unfold TanAbove
  rw [tanHeight_eq_of_ne_zero hκ.ne]
  have : 0 < -(κ / 2) := by linarith
  constructor <;> intro h <;> nlinarith [h]

/-- For `κ < 0`, below the arc of curvature `κ` is inside the circle of radius `−1/κ` about `v + n/κ`. -/
theorem tanBelow_iff_of_neg (v : ℂ) (α : ℝ) {κ : ℝ} (hκ : κ < 0) (z : ℂ) :
    TanBelow v α κ z ↔ dist z (v + ((1 / κ : ℝ) : ℂ) * e (α + π / 2)) < -(1 / κ) := by
  have h := sq_dist_normalPt v α (1 / κ) z
  have hc : 0 < -(1 / κ) := by have : 1 / κ < 0 := by rw [one_div]; exact inv_lt_zero.mpr hκ
                               linarith
  rw [lt_iff_sq_lt_sq' dist_nonneg hc.le, dist_eq_norm, h]
  unfold TanBelow
  rw [tanHeight_eq_of_ne_zero hκ.ne]
  have : 0 < -(κ / 2) := by linarith
  constructor <;> intro h <;> nlinarith [h]

/-- `1/f̃(υ) = 1/υ − 1`: the upward map shortens the reciprocal curvature by one (the engine of FIN's upward half). -/
theorem inv_curvUp {u : ℝ} (hu0 : u ≠ 0) : 1 / curvUp u = 1 / u - 1 := by
  unfold curvUp
  rw [one_div_div]
  field_simp

/-- `1/f(λ) = 1/λ + 1`: the downward map lengthens the reciprocal curvature by one (the engine of FIN's downward half). -/
theorem inv_curvDown {l : ℝ} (hl0 : l ≠ 0) (hl1 : 1 + l ≠ 0) : 1 / curvDown l = 1 / l + 1 := by
  unfold curvDown
  rw [one_div_div]
  field_simp

/-- The `x` coordinate is the same in the frames at `v` and at `N = v + n`. -/
theorem frameX_base_N (v : ℂ) (α : ℝ) (y : ℂ) : frameX (v + e (α + π / 2)) α y = frameX v α y := by
  have := frameX_sub v α y (v + e (α + π / 2))
  rw [frameX_N] at this
  unfold frameX at this ⊢
  linarith [this]

/-- The `y` coordinate in the frame at `N` is `y − 1`. -/
theorem frameY_base_N (v : ℂ) (α : ℝ) (y : ℂ) : frameY (v + e (α + π / 2)) α y = frameY v α y - 1 := by
  have := frameY_sub v α y (v + e (α + π / 2))
  rw [frameY_N] at this
  unfold frameY at this ⊢
  linarith [this]

/-- The `x` coordinate is the same in the frames at `v` and at `S′ = v − n`. -/
theorem frameX_base_S (v : ℂ) (α : ℝ) (y : ℂ) : frameX (v - e (α + π / 2)) α y = frameX v α y := by
  have := frameX_sub v α y (v - e (α + π / 2))
  rw [frameX_S] at this
  unfold frameX at this ⊢
  linarith [this]

/-- The `y` coordinate in the frame at `S′` is `y + 1`. -/
theorem frameY_base_S (v : ℂ) (α : ℝ) (y : ℂ) : frameY (v - e (α + π / 2)) α y = frameY v α y + 1 := by
  have := frameY_sub v α y (v - e (α + π / 2))
  rw [frameY_S] at this
  unfold frameY at this ⊢
  linarith [this]

/-- Points of the normal line have `x = 0`. -/
theorem frameX_normalPt (v : ℂ) (α c : ℝ) : frameX v α (v + (c : ℂ) * e (α + π / 2)) = 0 := by
  have := frameX_add_normal v α c v
  rw [frameX_self] at this
  rw [this]

/-- `1/f(μ) = 1 + 1/μ`: the concentric circle through `v` has radius `1 + 1/μ` where the arc at `N` has radius `1/μ`. -/
theorem inv_curvDown_eq {μ : ℝ} (h0 : μ ≠ 0) (_h1 : 1 + μ ≠ 0) : 1 / curvDown μ = 1 + 1 / μ := by
  unfold curvDown; field_simp; ring

/-- Spec: the frame algebra at `α = 0`, `v = 0`: `2i` (frame `(0, 2)`) lies on `ω(N)`'s arc, so it is not above it, and `i/2`
is. -/
example : ¬ TanAbove 0 0 1 (2 * I) ∧ TanAbove 0 0 1 (I / 2) := by
  rw [tanAbove_one_iff, tanAbove_one_iff]
  simp [e_eq]
  constructor
  · norm_num [Complex.dist_eq, Complex.norm_def, Complex.normSq_apply]
  · have h4 : Real.sqrt 4 = 2 := by
      rw [show (4 : ℝ) = 2 ^ 2 by norm_num]; exact Real.sqrt_sq (by norm_num)
    norm_num [Complex.dist_eq, Complex.norm_def, Complex.normSq_apply, h4]

/-! ## Spec examples (each fails if its definition drifts) -/

/-- `frameX` reads the coordinate along `e α`: at `α = 0` it is the real part of `z − v`. -/
example : frameX 0 0 3 = 3 := by simp [frameX, e]

/-- `frameY` reads the coordinate along `n`: at `α = 0` it is the imaginary part of `z − v`. -/
example : frameY 0 0 I = 1 := by simp [frameY, e]

/-- `ω(N)` is the arc of upward curvature `1`: the point `v + 2n` (frame `(0, 2)`) lies on it. -/
example : tanHeight 1 0 2 = 0 := by norm_num [tanHeight]

/-- `ω(S′)` is the arc of upward curvature `−1`: `v − 2n` lies on it, and `v + n` lies above it. -/
example : tanHeight (-1) 0 (-2) = 0 ∧ 0 < tanHeight (-1) 0 1 := by norm_num [tanHeight]

/-- A point of the horn between the curvatures `−1` and `1` along `e 0` at the origin. -/
example : (1 / 4 : ℂ) ∈ hornSet 0 0 (-1) 1 1 := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · rw [dist_zero_right]; norm_num
  · simp [frameX, e]
  · simp [TanAbove, tanHeight, frameX, frameY, e]; norm_num
  · simp [TanBelow, tanHeight, frameX, frameY, e]

/-- **Adversary**: the horn is open at its lower arc — `1/4` (on the axis, the arc of curvature `0`) is not in the horn
between `0` and `1`. -/
example : (1 / 4 : ℂ) ∉ hornSet 0 0 0 1 1 := by
  rintro ⟨-, -, h, -⟩
  simp [TanAbove, tanHeight, frameX, frameY, e] at h

/-- `curvDown` and `curvUp` are inverse at `1/2`: `f(1) = 1/2` and `f̃(1/2) = 1`. -/
example : curvDown 1 = 1 / 2 ∧ curvUp (1 / 2) = 1 := by norm_num [curvDown, curvUp]

/-- The shadow of a point is its unit circle: `1 ∈ shadow {0}`, **adversary** `1/2 ∉ shadow {0}`. -/
example : (1 : ℂ) ∈ shadow {0} ∧ (1 / 2 : ℂ) ∉ shadow {0} := by
  refine ⟨⟨0, rfl, by simp⟩, ?_⟩
  rintro ⟨y, rfl, hy⟩
  rw [dist_zero_right] at hy
  norm_num at hy

namespace ArcMap

/-- The one-colour disc `B(0, 1)` has the single sector `B(0, 1/2)` at `0` at radius `1/2` (an inhabitant of `IsSector`). -/
theorem const_isSector_ball (j : Fin 2) :
    (ArcMap.const (ball (0 : ℂ) 1) isOpen_ball j).IsSector 0 (1 / 2) (ball 0 (1 / 2)) := by
  have hI : (ArcMap.const (ball (0 : ℂ) 1) isOpen_ball j).interiorPts ∩ ball 0 (1 / 2) = ball 0 (1 / 2) := by
    rw [const_interiorPts]
    exact inter_eq_right.mpr (ball_subset_ball (by norm_num))
  refine ⟨0, by rw [hI]; exact mem_ball_self (by norm_num), ?_, ?_⟩
  · rw [hI]
    exact ((convex_ball (0 : ℂ) (1 / 2)).isPreconnected.connectedComponentIn (mem_ball_self (by norm_num))).symm
  · exact subset_closure (mem_ball_self (by norm_num))

/-- **Adversary**: a set whose closure misses `v` is no sector at `v` — `B(1/2, 1/8)` is no sector of the one-colour disc at
`0`. -/
theorem const_not_isSector_far (j : Fin 2) :
    ¬ (ArcMap.const (ball (0 : ℂ) 1) isOpen_ball j).IsSector 0 1 (ball (1 / 2) (1 / 8)) := by
  rintro ⟨-, -, -, h⟩
  rw [closure_ball _ (by norm_num), mem_closedBall, dist_comm, dist_zero_right] at h
  norm_num at h

/-- The one-colour map of the plane satisfies Condition 5 and lies in `𝓜_0` (no arcs). -/
example (j : Fin 2) :
    (ArcMap.const univ isOpen_univ j).Condition5 ∧ (ArcMap.const univ isOpen_univ j).InMK 0 := by
  refine ⟨fun a ha => by simp [const] at ha, fun a ha => by simp [const] at ha, fun x => ?_⟩
  simp [const]

/-- The one-colour plane satisfies Condition 6: no point carries three colours. -/
example (j : Fin 2) : (ArcMap.const univ isOpen_univ j).Condition6 := by
  intro x n h3 _
  have hsub : (ArcMap.const univ isOpen_univ j).coloursAt x ⊆ {j} := by
    intro c hc
    rw [mem_singleton_iff]
    by_contra hne
    have hreg : (ArcMap.const univ isOpen_univ j).region c = ∅ := by
      ext z
      simp [region, const, interiorPts, Ne.symm hne]
    have hc' : x ∈ closure ((ArcMap.const univ isOpen_univ j).region c) := hc
    rw [hreg, closure_empty] at hc'
    exact hc'
  have := Set.ncard_le_ncard hsub (Set.finite_singleton j)
  rw [Set.ncard_singleton] at this
  omega

/-- `IsContact` reads the carried colour and the closure of its class on `ω(v)`: on the one-colour plane, `1` is a contact
of the one colour at `0` (validity is not part of the definition). -/
example (j : Fin 2) : (ArcMap.const univ isOpen_univ j).IsContact 0 j 1 := by
  have hreg : (ArcMap.const univ isOpen_univ j).region j = univ := by
    ext z; simp [region, const, interiorPts]
  refine ⟨?_, by simp, ?_⟩
  · show (0 : ℂ) ∈ closure ((ArcMap.const univ isOpen_univ j).region j)
    rw [hreg, closure_univ]; trivial
  · rw [hreg, closure_univ]; trivial

/-- `AgreesOff` is reflexive: a map agrees with itself off any set. -/
example (j : Fin 2) (U : Set ℂ) :
    (ArcMap.const univ isOpen_univ j).AgreesOff (ArcMap.const univ isOpen_univ j) U :=
  ⟨rfl, fun _ _ => ⟨Iff.rfl, rfl⟩⟩

/-- **Adversary**: the one-colour planes of the two colours of `Fin 2` do not agree off `∅` (their colours differ at `0`). -/
example : ¬ (ArcMap.const univ isOpen_univ (1 : Fin 2)).AgreesOff (ArcMap.const univ isOpen_univ (0 : Fin 2)) ∅ := by
  rintro ⟨-, h⟩
  have := (h 0 (notMem_empty 0)).2
  simp [const] at this

/-- A map with one unit arc: the plane, one colour, the upper half of `ω(0)` as its only arc. -/
noncomputable def unitArcPlane : ArcMap 1 where
  dom := univ
  isOpen_dom := isOpen_univ
  arcs := {Arc.circ 0 1 0 π}
  nondegenerate := by
    intro a ha
    rw [mem_singleton_iff] at ha
    subst ha
    exact ⟨one_pos, pi_pos, by linarith [pi_pos]⟩
  locallyFinite := fun _ _ => ⟨univ, univ_mem, (finite_singleton _).subset fun a ha => ha.1⟩
  col := fun _ => 0
  locallyConstant := fun _ _ _ => Filter.Eventually.of_forall fun _ => rfl

/-- `RingArcsWithin` is reflexive, and **adversary**: the arc of `unitArcPlane` is a unit arc the arc-free plane does not have,
so `unitArcPlane` does not create its unit arcs within the one-colour plane. -/
example : unitArcPlane.RingArcsWithin unitArcPlane ∧
    ¬ unitArcPlane.RingArcsWithin (ArcMap.const univ isOpen_univ 0) := by
  refine ⟨fun _ _ h => h, fun h => ?_⟩
  have hon : unitArcPlane.OnRingArc 0 (ringPt 0 0) := by
    refine ⟨0, π, pi_pos, ⟨0, ⟨le_rfl, pi_pos.le⟩, rfl⟩, ?_⟩
    rintro _ ⟨θ, hθ, rfl⟩
    refine ⟨mem_univ _, mem_biUnion (mem_singleton _) ⟨θ, hθ, ?_⟩⟩
    simp [ringPt]
  obtain ⟨θ₁, θ₂, hlt, -, hsub⟩ := h 0 _ hon
  have hm : ringPt 0 θ₁ ∈ ringArc 0 θ₁ θ₂ := ⟨θ₁, ⟨le_rfl, hlt.le⟩, rfl⟩
  have := hsub hm
  simp [Γ, const] at this

/-- A map with one segment: the plane, one colour, the segment `[0, 1]` as its only arc. -/
noncomputable def segPlane : ArcMap 1 where
  dom := univ
  isOpen_dom := isOpen_univ
  arcs := {Arc.seg 0 1}
  nondegenerate := by
    intro a ha
    rw [mem_singleton_iff] at ha
    subst ha
    exact zero_ne_one
  locallyFinite := fun _ _ => ⟨univ, univ_mem, (finite_singleton _).subset fun a ha => ha.1⟩
  col := fun _ => 0
  locallyConstant := fun _ _ _ => Filter.Eventually.of_forall fun _ => rfl

/-- **Engine 2 at work**: the segment of `segPlane` is not a unit arc, so `segPlane` creates no unit arc over the arc-free plane
(`ringArcsWithin_of_Γ_subset` with `A' = {[0, 1]}`); `unitArcPlane` above is the adversary, whose arc is a unit arc. -/
example : segPlane.RingArcsWithin (ArcMap.const univ isOpen_univ 0) := by
  refine ringArcsWithin_of_Γ_subset rfl (A' := {Arc.seg 0 1}) (fun a ha => segPlane.nondegenerate a ha)
    (fun _ _ => ⟨univ, univ_mem, (finite_singleton _).subset fun a ha => ha.1⟩)
    (fun a ha => by rw [mem_singleton_iff] at ha; subst ha; exact not_false) ?_
  intro z hz
  exact Or.inr hz.2

/-- On the one-colour plane with one colour, every pair is a covering pair; with two colours (`Fin 2`), none is. -/
example : (ArcMap.const univ isOpen_univ (0 : Fin 1)).IsCoveringPair 0 1 := by
  have hreg : (ArcMap.const univ isOpen_univ (0 : Fin 1)).region 0 = univ := by
    ext z; simp [region, const, interiorPts]
  ext j
  fin_cases j
  simp only [mem_union, mem_univ, iff_true]
  left
  show (0 : ℂ) ∈ closure ((ArcMap.const univ isOpen_univ (0 : Fin 1)).region 0)
  rw [hreg, closure_univ]; trivial

/-- **Adversary**: on the one-colour plane with two colours (`Fin 2`) no pair is a covering pair (the other colour is carried
nowhere). -/
example (x y : ℂ) : ¬ (ArcMap.const univ isOpen_univ (0 : Fin 2)).IsCoveringPair x y := by
  intro h
  have h1 : (1 : Fin 2) ∈ (ArcMap.const univ isOpen_univ (0 : Fin 2)).coloursAt x ∪
      (ArcMap.const univ isOpen_univ (0 : Fin 2)).coloursAt y := by
    rw [h]; trivial
  have hreg : (ArcMap.const univ isOpen_univ (0 : Fin 2)).region 1 = ∅ := by
    ext z; simp [region, const, interiorPts]
  rcases h1 with h1 | h1 <;>
  · have h1' : _ ∈ closure ((ArcMap.const univ isOpen_univ (0 : Fin 2)).region 1) := h1
    rw [hreg, closure_empty] at h1'
    exact h1'

end ArcMap

end HadwigerNelson.Plane
