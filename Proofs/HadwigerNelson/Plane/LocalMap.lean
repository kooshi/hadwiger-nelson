import Proofs.HadwigerNelson.Plane.ArcMap
import Proofs.HadwigerNelson.Plane.UnitPairs

/-!
# The local geometry of an arc map: tiles' colours, cones, germs, ring arcs, (Q), change points, hubs

Wave 3's foundation (`plans/FS131-w3-kernel-plan.md` § 2), the vocabulary of `data/fs116/claims.md` §§ 0, 10, 13 made
formal over `ArcMap` (`Plane/ArcMap`). Every definition is point-set and extrinsic: a predicate on one map, never a
new type, so a Siamese-allowed lemma and a class statement read the same objects (G86).

**The reading of "a tile of colour `c`"** (the one modeling decision every row inherits). Where a row speaks of the
closure, the cone or a germ of "a tile of colour `c`", the formal object is the colour class `F.region c` (the
interior points of colour `c`), exactly as the foundation's `coloursAt` already reads `P_cl` ("the colours of tiles
whose closure contains `x`") as the colours whose region has `x` in its closure. The two readings agree because the
arcs are locally finite: finitely many tiles meet a small disc about any point of the domain
(`ArcMap.finite_tiles_near`, `Plane/LocalStructure`). The colour class is the intrinsic object — N-E1, the engine of
every ring row, is a statement about one colour class with no unit pairs — and tiles appear only where a row
distinguishes tiles of one colour (near and far tiles, Siamese pairs, the whole-tile restriction, the flank lemma).

* **Cones.** `coneAt S y` is the set of angles `β` along which `S` approaches `y`: limits of the directions
  `(z − y)/|z − y|`, `z ∈ S`, `z → y` (`plans/FS116-N1-proof.md` § 4.1: "a tile *approaches `y` along `β`* when it has
  points `y + h_n`, `h_n → 0`, `h_n/|h_n| → u(β)`"). A closed, `2π`-periodic set of reals.
* **Germs.** `germ p θ s δ` is the arc of `ω(p)` of length `δ` just clockwise (`s = cw`) or just counter-clockwise
  (`s = ccw`) of `r(θ)`, open at both ends; `GermIn p θ s S` says some such arc lies in `S` ("for small `δ`"). The
  rows' `u±`, `v±` at a ring point `y = r(ψ)` are the germs at `ψ ± π/3`.
* **Arcs of `Γ` on `ω(p)`.** `IsRingArc p θ₁ θ₂ c c'`: the closed sub-arc `r([θ₁, θ₂])` of `ω(p)`, of positive
  length, lies in `Γ`, and at every interior point its inner side (toward `p`) carries the colour `c` alone and its
  outer side `c'` alone — the "arc with constant sides" whose inner and outer colours FS112's (Q) and (R2) name.
  `OnRingArc p x`: `x` lies on some sub-arc of `ω(p)` of positive length inside `Γ`.
* **(Q).** `IsQArc p θ₁ θ₂`: a ring arc both of whose side colours are carried at `p`, which carries at least four
  colours (FS112's header: "an arc whose centre carries both side colours and at least four colours").
  `GermOnQ`: a germ lies on a (Q) arc; `OnQArc`: a point lies on a closed (Q) arc.
* **Change points and hubs.** `IsChangePoint p ψ X X'`: `r(ψ) ∈ Γ` and the ring off `Γ` on both sides (reading L),
  colour `X` just counter-clockwise and `X' ≠ X` (the rows' `X̄`) just clockwise. `IsHub p ψ`: a change point whose four germs at
  `ψ ± π/3` lie on no (Q) arc.
* **Density at a point.** `essColours w` is `P(w)`, the essential multicolour (`data/fs111/claims.md` § 0, D-NF);
  `SaturatedAt w`: each colour of `P(w)` has a point of its support at distance exactly `1` from `w`.
* **Restriction.** `F.restrict U` keeps the arcs and the colour on a smaller open set; `F.wholeRestrict p ρ` is
  FS129-OR1-WHOLE's `F_ρ`, the map of `V ∩ int ⋃ {cl T : T a tile meeting B(p, ρ)}`.
* **Initial pieces.** `Arc.InitialPiece α y δ B`: `B` is an initial piece of the arc `α` leaving `y` in the direction
  `δ` (FS116-Y4-FLANK's "t's edge leaving `y` in the direction `ψ + 210°`").

Spec examples and inhabitants: `Plane/LocalMapExamples`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## Arcs are compact -/

/-- The points of an arc form a compact set. -/
theorem Arc.isCompact_carrier : ∀ a : Arc, IsCompact a.carrier
  | .seg a b => by
      rw [Arc.carrier, segment_eq_image]
      exact isCompact_Icc.image (by fun_prop)
  | .circ c ρ θ₀ θ₁ => isCompact_Icc.image (by unfold e; fun_prop)

/-- The points of an arc form a closed set. -/
theorem Arc.isClosed_carrier (a : Arc) : IsClosed a.carrier := a.isCompact_carrier.isClosed

/-! ## Two sets near or far at the unit distance -/

/-- `A ~ B`: every point of `A` is at distance below `1` from every point of `B`. -/
def UnitNear (A B : Set ℂ) : Prop := ∀ a ∈ A, ∀ b ∈ B, dist a b < 1

/-- `A ⊥ B`: every point of `A` is at distance above `1` from every point of `B`. -/
def UnitFar (A B : Set ℂ) : Prop := ∀ a ∈ A, ∀ b ∈ B, 1 < dist a b

/-! ## Cones: the directions along which a set approaches a point -/

/-- The cone of `S` at `y`: the angles `β` along which `S` approaches `y`, i.e. the limits of the unit directions
`(z − y)/|z − y|` over points `z ∈ S`, `z ≠ y`, tending to `y`. -/
def coneAt (S : Set ℂ) (y : ℂ) : Set ℝ :=
  {β | ∀ ε > 0, ∃ z ∈ S, z ≠ y ∧ dist z y < ε ∧ ‖(z - y) / (‖z - y‖ : ℂ) - e β‖ < ε}

/-- The cone grows with the set. -/
theorem coneAt_mono {S T : Set ℂ} (h : S ⊆ T) (y : ℂ) : coneAt S y ⊆ coneAt T y := by
  intro β hβ ε hε
  obtain ⟨z, hz, hne, hd, hdir⟩ := hβ ε hε
  exact ⟨z, h hz, hne, hd, hdir⟩

/-- The cone is `2π`-periodic. -/
theorem mem_coneAt_add_two_pi {S : Set ℂ} {y : ℂ} {β : ℝ} : β + 2 * π ∈ coneAt S y ↔ β ∈ coneAt S y := by
  simp only [coneAt, mem_setOf_eq, e_add_two_pi]

/-- A set approaches only points of its closure. -/
theorem mem_closure_of_mem_coneAt {S : Set ℂ} {y : ℂ} {β : ℝ} (h : β ∈ coneAt S y) : y ∈ closure S := by
  rw [Metric.mem_closure_iff]
  intro ε hε
  obtain ⟨z, hz, -, hd, -⟩ := h ε hε
  exact ⟨z, hz, by rw [dist_comm]; exact hd⟩

/-! ## Germs of a ring -/

/-- The side of a ring point: just clockwise (angles below) or just counter-clockwise (angles above). -/
inductive Side where
  /-- Just clockwise: the angles `θ − t`, `t > 0` small. -/
  | cw
  /-- Just counter-clockwise: the angles `θ + t`, `t > 0` small. -/
  | ccw
  deriving DecidableEq

/-- `−1` for clockwise, `+1` for counter-clockwise. -/
def Side.sign : Side → ℝ
  | .cw => -1
  | .ccw => 1

/-- The germ of `ω(p)` of length `δ` on side `s` of `r(θ)`: the open arc `{r(θ + s t) : 0 < t < δ}`. -/
noncomputable def germ (p : ℂ) (θ : ℝ) (s : Side) (δ : ℝ) : Set ℂ :=
  (fun t => ringPt p (θ + s.sign * t)) '' Ioo 0 δ

/-- The germ of `ω(p)` on side `s` of `r(θ)` lies in `S`: some germ of positive length does. -/
def GermIn (p : ℂ) (θ : ℝ) (s : Side) (S : Set ℂ) : Prop := ∃ δ > 0, germ p θ s δ ⊆ S

/-- A shorter germ lies inside a longer one. -/
theorem germ_mono {p : ℂ} {θ : ℝ} {s : Side} {δ δ' : ℝ} (h : δ ≤ δ') : germ p θ s δ ⊆ germ p θ s δ' :=
  image_mono (Ioo_subset_Ioo_right h)

/-- `GermIn` is monotone in the set. -/
theorem GermIn.mono {p : ℂ} {θ : ℝ} {s : Side} {S T : Set ℂ} (h : GermIn p θ s S) (hST : S ⊆ T) :
    GermIn p θ s T := by
  obtain ⟨δ, hδ, hS⟩ := h
  exact ⟨δ, hδ, hS.trans hST⟩

/-- Two germ conditions hold together on the shorter germ. -/
theorem GermIn.inter {p : ℂ} {θ : ℝ} {s : Side} {S T : Set ℂ} (hS : GermIn p θ s S) (hT : GermIn p θ s T) :
    GermIn p θ s (S ∩ T) := by
  obtain ⟨δ, hδ, h1⟩ := hS
  obtain ⟨δ', hδ', h2⟩ := hT
  exact ⟨min δ δ', lt_min hδ hδ', subset_inter ((germ_mono (min_le_left _ _)).trans h1)
    ((germ_mono (min_le_right _ _)).trans h2)⟩

/-- The closed sub-arc `r([θ₁, θ₂])` of `ω(p)`. -/
noncomputable def ringArc (p : ℂ) (θ₁ θ₂ : ℝ) : Set ℂ := ringPt p '' Icc θ₁ θ₂

/-! ## Initial pieces of an arc -/

/-- `B` is an initial piece of the arc `α` leaving the point `y` in the direction `δ`: for a segment, a subsegment
`[y, y + ε e(δ)]`; for a circular arc of positive radius, the points `c + ρ e(φ + σ t)`, `0 ≤ t ≤ ε`, from
`y = c + ρ e(φ)`, turning in the sense `σ = ±1` whose initial direction is `e(δ) = e(φ + σ π/2)`. -/
def Arc.InitialPiece : Arc → ℂ → ℝ → Set ℂ → Prop
  | .seg a b, y, δ, B => ∃ ε : ℝ, 0 < ε ∧ B = segment ℝ y (y + (ε : ℂ) * e δ) ∧ B ⊆ segment ℝ a b
  | .circ c ρ θ₀ θ₁, y, δ, B => 0 < ρ ∧ ∃ φ ε σ : ℝ, (σ = 1 ∨ σ = -1) ∧ 0 < ε ∧ y = c + ρ * e φ ∧
      e δ = e (φ + σ * (π / 2)) ∧ B = (fun t : ℝ => c + ρ * e (φ + σ * t)) '' Icc 0 ε ∧
      (fun t : ℝ => φ + σ * t) '' Icc 0 ε ⊆ Icc θ₀ θ₁

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-! ## The interior points are open; tiles are open, connected and monochromatic -/

/-- The interior points of the domain form an open set: the finitely many arcs near an interior point are closed and
miss it. -/
theorem isOpen_interiorPts : IsOpen F.interiorPts := by
  rw [isOpen_iff_mem_nhds]
  rintro x ⟨hxd, hxΓ⟩
  obtain ⟨t, ht, hfin⟩ := F.locallyFinite x hxd
  have hcl : IsClosed (⋃ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ t).Nonempty}, a.carrier) :=
    hfin.isClosed_biUnion fun a _ => a.isClosed_carrier
  have hxn : x ∉ ⋃ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ t).Nonempty}, a.carrier := by
    intro h
    apply hxΓ
    obtain ⟨a, ⟨ha, -⟩, hxa⟩ := mem_iUnion₂.mp h
    exact mem_iUnion₂.mpr ⟨a, ha, hxa⟩
  filter_upwards [ht, hcl.isOpen_compl.mem_nhds hxn, F.isOpen_dom.mem_nhds hxd] with y hyt hyc hyd
  refine ⟨hyd, fun hy => ?_⟩
  obtain ⟨a, ha, hya⟩ := mem_iUnion₂.mp hy
  exact hyc (mem_iUnion₂.mpr ⟨a, ⟨ha, y, hya, hyt⟩, hya⟩)

/-- The interior points lie in the domain. -/
theorem interiorPts_subset_dom : F.interiorPts ⊆ F.dom := sdiff_subset

/-- The colour is continuous on the interior points (the colours carry the discrete topology). -/
theorem continuousOn_col : ContinuousOn F.col F.interiorPts := by
  intro x hx
  refine ContinuousAt.continuousWithinAt ?_
  have h := F.locallyConstant x hx.1 hx.2
  exact continuousAt_const.congr (h.mono fun y hy => hy.symm)

/-- A colour class is open. -/
theorem isOpen_region (j : Fin k) : IsOpen (F.region j) :=
  F.continuousOn_col.isOpen_inter_preimage F.isOpen_interiorPts (isOpen_discrete {j})

/-- A colour class lies in the interior points. -/
theorem region_subset_interiorPts (j : Fin k) : F.region j ⊆ F.interiorPts := inter_subset_left

section TileLemmas

variable {F}

/-- A tile lies in the interior points. -/
theorem IsTile.subset_interiorPts {T : Set ℂ} (h : F.IsTile T) : T ⊆ F.interiorPts := by
  obtain ⟨x, -, rfl⟩ := h
  exact connectedComponentIn_subset _ _

/-- A tile is open. -/
theorem IsTile.isOpen {T : Set ℂ} (h : F.IsTile T) : IsOpen T := by
  obtain ⟨x, -, rfl⟩ := h
  exact F.isOpen_interiorPts.connectedComponentIn

/-- A tile is connected. -/
theorem IsTile.isPreconnected {T : Set ℂ} (h : F.IsTile T) : IsPreconnected T := by
  obtain ⟨x, -, rfl⟩ := h
  exact isPreconnected_connectedComponentIn

/-- A tile is non-empty. -/
theorem IsTile.nonempty {T : Set ℂ} (h : F.IsTile T) : T.Nonempty := by
  obtain ⟨x, hx, rfl⟩ := h
  exact ⟨x, mem_connectedComponentIn hx⟩

/-- A tile has one colour. -/
theorem IsTile.col_eq {T : Set ℂ} (h : F.IsTile T) {x y : ℂ} (hx : x ∈ T) (hy : y ∈ T) :
    F.col x = F.col y :=
  h.isPreconnected.constant (F.continuousOn_col.mono h.subset_interiorPts) hx hy

end TileLemmas

/-- A **tile of colour `c`**. -/
def TileOf (c : Fin k) (T : Set ℂ) : Prop := F.IsTile T ∧ T ⊆ F.col ⁻¹' {c}

section TileOfLemmas

variable {F}

/-- A tile is a tile of the colour of any of its points. -/
theorem IsTile.tileOf {T : Set ℂ} (h : F.IsTile T) {x : ℂ} (hx : x ∈ T) : F.TileOf (F.col x) T :=
  ⟨h, fun y hy => (h.col_eq hy hx : F.col y = F.col x)⟩

/-- A tile of colour `c` lies in the colour class of `c`. -/
theorem TileOf.subset_region {c : Fin k} {T : Set ℂ} (h : F.TileOf c T) : T ⊆ F.region c :=
  fun _ hx => ⟨h.1.subset_interiorPts hx, h.2 hx⟩

/-- A point in the closure of a tile of colour `c` carries `c`. -/
theorem mem_coloursAt_of_tileOf {c : Fin k} {T : Set ℂ} (h : F.TileOf c T) {x : ℂ} (hx : x ∈ closure T) :
    c ∈ F.coloursAt x :=
  closure_mono h.subset_region hx

end TileOfLemmas

/-! ## Arcs of `Γ` on a ring, their sides, (Q) -/

/-- `x` lies on an arc of `Γ` on `ω(p)`: some sub-arc of `ω(p)` of positive length through `x` lies in `Γ`. -/
def OnRingArc (p x : ℂ) : Prop := ∃ θ₁ θ₂, θ₁ < θ₂ ∧ x ∈ ringArc p θ₁ θ₂ ∧ ringArc p θ₁ θ₂ ⊆ F.Γ

/-- The colours on the inner side of `ω(p)` at `x`: those whose class has `x` in the closure of its part inside
`B(p, 1)`. -/
def innerColours (p x : ℂ) : Set (Fin k) := {c | x ∈ closure (F.region c ∩ ball p 1)}

/-- The colours on the outer side of `ω(p)` at `x`: those whose class has `x` in the closure of its part outside
`B̄(p, 1)`. -/
def outerColours (p x : ℂ) : Set (Fin k) := {c | x ∈ closure (F.region c \ closedBall p 1)}

/-- **An arc of `Γ` on `ω(p)` with constant sides**: the closed sub-arc `r([θ₁, θ₂])`, of positive length, lies in
`Γ`, and at each of its interior points the inner side carries the colour `c` alone and the outer side `c'` alone
(`c` is the arc's *inner colour*, `c'` its *outer colour*). -/
def IsRingArc (p : ℂ) (θ₁ θ₂ : ℝ) (c c' : Fin k) : Prop :=
  θ₁ < θ₂ ∧ ringArc p θ₁ θ₂ ⊆ F.Γ ∧
    ∀ θ ∈ Ioo θ₁ θ₂, F.innerColours p (ringPt p θ) = {c} ∧ F.outerColours p (ringPt p θ) = {c'}

/-- **A (Q) arc** of `ω(p)`: an arc of `Γ` on `ω(p)` with constant sides whose two side colours are carried at `p`,
which carries at least four colours. -/
def IsQArc (p : ℂ) (θ₁ θ₂ : ℝ) : Prop :=
  ∃ c c', F.IsRingArc p θ₁ θ₂ c c' ∧ c ∈ F.coloursAt p ∧ c' ∈ F.coloursAt p ∧ 4 ≤ (F.coloursAt p).ncard

/-- The germ of `ω(p)` on side `s` of `r(θ)` lies on a (Q) arc. -/
def GermOnQ (p : ℂ) (θ : ℝ) (s : Side) : Prop := ∃ θ₁ θ₂, F.IsQArc p θ₁ θ₂ ∧ GermIn p θ s (ringArc p θ₁ θ₂)

/-- `x` lies on a closed (Q) arc of `ω(p)`. -/
def OnQArc (p x : ℂ) : Prop := ∃ θ₁ θ₂, F.IsQArc p θ₁ θ₂ ∧ x ∈ ringArc p θ₁ θ₂

/-! ## Change points and hubs -/

/-- **A change point** `y = r(ψ)` of the ring of `p`: a point of `Γ ∩ ω(p)` with the ring off `Γ` on both sides
(reading L), of colour `X` just counter-clockwise and of another colour `X'` (the rows' `X̄`) just clockwise. -/
def IsChangePoint (p : ℂ) (ψ : ℝ) (X X' : Fin k) : Prop :=
  ringPt p ψ ∈ F.Γ ∧ X ≠ X' ∧ GermIn p ψ .ccw (F.region X) ∧ GermIn p ψ .cw (F.region X')

/-- **A hub** `r(ψ)` of the ring of `p` (FS116-N2's word): a change point whose four germs `u⁻, u⁺, v⁻, v⁺` at
`ψ + π/3` and `ψ − π/3` lie on no (Q) arc. -/
def IsHub (p : ℂ) (ψ : ℝ) : Prop :=
  (∃ X X', F.IsChangePoint p ψ X X') ∧ ∀ s, ¬ F.GermOnQ p (ψ + π / 3) s ∧ ¬ F.GermOnQ p (ψ - π / 3) s

/-! ## Density at a point: the essential multicolour and saturation -/

/-- `P(w)`, the **essential multicolour** at `w`: the colours whose class has positive upper density at `w`. -/
def essColours (w : ℂ) : Set (Fin k) := {j | 0 < upperDensityAt (F.region j) w}

/-- `w` is an **essential boundary point**: its essential multicolour has at least two colours. -/
def IsEssBoundary (w : ℂ) : Prop := 2 ≤ (F.essColours w).ncard

/-- The map is **saturated at `w`**: each colour of `P(w)` has a point of its essential support at distance exactly
`1` from `w`. -/
def SaturatedAt (w : ℂ) : Prop := ∀ j ∈ F.essColours w, ∃ x ∈ essSupport (F.region j), dist x w = 1

/-! ## Restriction to a smaller open set; the whole-tile restriction `F_ρ` -/

/-- The map restricted to an open subset `U` of its domain: the same arcs and the same colour. -/
def restrict (U : Set ℂ) (hU : IsOpen U) (hUd : U ⊆ F.dom) : ArcMap k where
  dom := U
  isOpen_dom := hU
  arcs := F.arcs
  nondegenerate := F.nondegenerate
  locallyFinite := fun x hx => F.locallyFinite x (hUd hx)
  col := F.col
  locallyConstant := fun x hx hΓ => F.locallyConstant x (hUd hx) hΓ

/-- The open set of FS129-OR1-WHOLE: `V ∩ int ⋃ {cl T : T a tile of F meeting B(p, ρ)}`. -/
def wholeDom (p : ℂ) (ρ : ℝ) : Set ℂ :=
  F.dom ∩ interior (⋃₀ {S | ∃ T, F.IsTile T ∧ (T ∩ ball p ρ).Nonempty ∧ S = closure T})

/-- **`F_ρ`** (FS129-OR1-WHOLE): the map of `V ∩ int ⋃ {cl T : T meets B(p, ρ)}` with `F`'s arcs and colours. -/
def wholeRestrict (p : ℂ) (ρ : ℝ) : ArcMap k :=
  F.restrict (F.wholeDom p ρ) (F.isOpen_dom.inter isOpen_interior) inter_subset_left

end ArcMap

end HadwigerNelson.Plane
