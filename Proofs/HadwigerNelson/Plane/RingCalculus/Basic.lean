import Proofs.HadwigerNelson.Plane.RingGerm
import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc
import Proofs.HadwigerNelson.Plane.SimpleOn
import Proofs.HadwigerNelson.Plane.LocalMapExamples

/-!
# The ring calculus, foundation: tiles of a point, tips and outer tiles, the two germ pairs, semi-hubs, Γ-free rings

Wave 8's foundation (`plans/FS131-w8-kernel-plan.md`, Stage 3; job FS131-K8): the words of `data/fs116/claims.md` § 13's
notation paragraph and its l. 203 made formal over `ArcMap`, beside wave 3's ring vocabulary (`Plane/LocalMap`: germs, ring
arcs, (Q), change points, hubs). Every definition is a predicate on one map, never a new type (G86).

* **Tiles of a point.** `TileAt p T`: "a tile of `p`", a tile whose closure holds `p`.
* **Tips and outer tiles** (at a ring point `y` of `p`). `IsTip p y T`: "a tile of `p` whose closure holds `y`".
  `IsOuterTileAt p y T`: "a tile of a colour of `p` that is not a tile of `p`", with `y` in its closure. `tipColours p y` and
  `outerTileColours p y` are the rows' `T_y` and `O_y`. (`outerTileColours` is not `Plane/LocalMap`'s `outerColours p x`,
  the colours on the outer *side* of `ω(p)` at `x`.)
* **The two germ pairs** at a ring point `r(ψ)`: the *tip pair* `{v⁻, u⁺}` and the *outer pair* `{u⁻, v⁺}` — the pairs
  FS116-RING-GERM (i) and (ii) read. `TipPairFree p ψ`, `OuterPairFree p ψ`: neither germ of the pair lies on a (Q) arc.
* **Semi-hubs.** A change point is a *hub* when both pairs are free (`isHub_iff`: wave 3's `IsHub`), a *semi-hub* when
  exactly one is — *of kind O* when the free pair is the outer pair, *of kind T* when it is the tip pair
  (`IsSemiHub p ψ kind`) — and *closed* when neither is (`IsClosedChangePoint`). A semi-hub is *full* when both germs of
  its other pair lie on (Q) arcs (`IsFullSemiHub`). `GermOnQWith p θ s a a'` names the colours of the (Q) arc a germ lies on
  (inner `a`, outer `a'`); a full semi-hub is *crossed* when its two (Q) arcs' colour pairs are disjoint and *parallel* when
  they are equal, which the rows' statements say with these colours directly.
* **Ring classes.** `GammaFreeRing p`: "a ring is Γ-free when no arc of `Γ` lies on it". `QFreeRing p`: the ring carries no
  (Q) arc. A Γ-free ring is (Q)-free (`GammaFreeRing.qFreeRing`), and on a (Q)-free ring every change point is a hub
  (`QFreeRing.isHub`).

**The non-Siamese engine.** In a valid non-Siamese map two tiles of one colour with closure points nearer than `1` are one
tile (`NonSiamese.tile_eq_of_dist_lt`; "one tile per colour at a point" is its case of a common closure point,
`NonSiamese.tile_eq_of_mem_closure`). Every tile identification of the wave's rows is this lemma.

**The colours at a ring point, sorted.** `coloursAt p ∩ coloursAt y = tipColours p y ∪ outerTileColours p y` at a point `y`
of the domain (`coloursAt_inter_eq`), the union disjoint in a valid non-Siamese map
(`disjoint_tipColours_outerTileColours`): FS116-N2-STAR's `C(y) = A(p) ⊔ T_y ⊔ O_y` with its first summand removed.

**Spec examples and inhabitants** (at the end): `halfPlane2` (`Plane/LocalMapExamples`) has a Γ-free ring about `0` with a
hub at `r(0)`; `quadRing`'s ring about `0` is neither Γ-free nor (Q)-free. Neither map is valid — these definitions do not read validity — so they are spec carriers and no model of a row's
class; the models of the classes are named in `Plane/RingCalculus/Star` and `…/Empty`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-! ## Tiles of a point, tips, outer tiles -/

/-- **A tile of `p`**: a tile whose closure holds `p`. -/
def TileAt (p : ℂ) (T : Set ℂ) : Prop := F.IsTile T ∧ p ∈ closure T

/-- **A tip** at `y` (a ring point of `p`): a tile of `p` whose closure holds `y`. -/
def IsTip (p y : ℂ) (T : Set ℂ) : Prop := F.IsTile T ∧ p ∈ closure T ∧ y ∈ closure T

/-- **An outer tile** at `y`: a tile with `y` in its closure, of a colour of `p`, that is not a tile of `p`. -/
def IsOuterTileAt (p y : ℂ) (T : Set ℂ) : Prop :=
  F.IsTile T ∧ y ∈ closure T ∧ p ∉ closure T ∧ ∃ c ∈ F.coloursAt p, T ⊆ F.col ⁻¹' {c}

/-- `T_y`: the colours of the tips at `y`. -/
def tipColours (p y : ℂ) : Set (Fin k) := {c | ∃ T, F.TileOf c T ∧ F.IsTip p y T}

/-- `O_y`: the colours of the outer tiles at `y`. -/
def outerTileColours (p y : ℂ) : Set (Fin k) :=
  {c | c ∈ F.coloursAt p ∧ ∃ T, F.TileOf c T ∧ y ∈ closure T ∧ p ∉ closure T}

/-! ## The two germ pairs, semi-hubs -/

/-- **The tip pair** `{v⁻, u⁺}` at `r(ψ)` lies on no (Q) arc: the germ just clockwise of `r(ψ − 60°)` and the germ just
counter-clockwise of `r(ψ + 60°)`. -/
def TipPairFree (p : ℂ) (ψ : ℝ) : Prop := ¬ F.GermOnQ p (ψ - π / 3) .cw ∧ ¬ F.GermOnQ p (ψ + π / 3) .ccw

/-- **The outer pair** `{u⁻, v⁺}` at `r(ψ)` lies on no (Q) arc: the germ just clockwise of `r(ψ + 60°)` and the germ just
counter-clockwise of `r(ψ − 60°)`. -/
def OuterPairFree (p : ℂ) (ψ : ℝ) : Prop := ¬ F.GermOnQ p (ψ + π / 3) .cw ∧ ¬ F.GermOnQ p (ψ - π / 3) .ccw

/-- The kind of a semi-hub: `O` when its free pair is the outer pair, `T` when it is the tip pair. -/
inductive SemiKind where
  /-- The outer pair `{u⁻, v⁺}` is free; the tip pair is not. -/
  | O
  /-- The tip pair `{v⁻, u⁺}` is free; the outer pair is not. -/
  | T
  deriving DecidableEq

/-- **A semi-hub** `r(ψ)` of the ring of `p`, of the given kind: a change point exactly one of whose two germ pairs lies on
no (Q) arc. -/
def IsSemiHub (p : ℂ) (ψ : ℝ) : SemiKind → Prop
  | .O => (∃ X X', F.IsChangePoint p ψ X X') ∧ F.OuterPairFree p ψ ∧ ¬ F.TipPairFree p ψ
  | .T => (∃ X X', F.IsChangePoint p ψ X X') ∧ F.TipPairFree p ψ ∧ ¬ F.OuterPairFree p ψ

/-- **A full semi-hub**: a semi-hub both germs of whose other pair lie on (Q) arcs. -/
def IsFullSemiHub (p : ℂ) (ψ : ℝ) : SemiKind → Prop
  | .O => (∃ X X', F.IsChangePoint p ψ X X') ∧ F.OuterPairFree p ψ ∧
      F.GermOnQ p (ψ - π / 3) .cw ∧ F.GermOnQ p (ψ + π / 3) .ccw
  | .T => (∃ X X', F.IsChangePoint p ψ X X') ∧ F.TipPairFree p ψ ∧
      F.GermOnQ p (ψ + π / 3) .cw ∧ F.GermOnQ p (ψ - π / 3) .ccw

/-- **A closed change point**: neither germ pair is free. -/
def IsClosedChangePoint (p : ℂ) (ψ : ℝ) : Prop :=
  (∃ X X', F.IsChangePoint p ψ X X') ∧ ¬ F.TipPairFree p ψ ∧ ¬ F.OuterPairFree p ψ

/-- The germ of `ω(p)` on side `s` of `r(θ)` lies on a (Q) arc of inner colour `a` and outer colour `a'`: an arc of `Γ` on
`ω(p)` with sides `a`, `a'`, both carried at `p`, which carries at least four colours. (The (Q) clauses are on the named
colours themselves, so no second pair of colours hides inside `IsQArc`.) -/
def GermOnQWith (p : ℂ) (θ : ℝ) (s : Side) (a a' : Fin k) : Prop :=
  ∃ θ₁ θ₂, F.IsRingArc p θ₁ θ₂ a a' ∧ a ∈ F.coloursAt p ∧ a' ∈ F.coloursAt p ∧ 4 ≤ (F.coloursAt p).ncard ∧
    GermIn p θ s (ringArc p θ₁ θ₂)

/-! ## Ring classes -/

/-- **A Γ-free ring**: no arc of `Γ` lies on `ω(p)`. -/
def GammaFreeRing (p : ℂ) : Prop := ∀ x, ¬ F.OnRingArc p x

/-- **A (Q)-free ring**: `ω(p)` carries no (Q) arc. -/
def QFreeRing (p : ℂ) : Prop := ∀ θ₁ θ₂, ¬ F.IsQArc p θ₁ θ₂

variable {F}

/-! ## First consequences -/

/-- A tip is a tile of `p` and a tile of `y`. -/
theorem IsTip.tileAt {p y : ℂ} {T : Set ℂ} (h : F.IsTip p y T) : F.TileAt p T ∧ F.TileAt y T :=
  ⟨⟨h.1, h.2.1⟩, ⟨h.1, h.2.2⟩⟩

/-- **A tip is symmetric in its two points**: a tip at `y` of `p` is a tip at `p` of `y` (FS116-N2-RECIP and FS116-N3-CROSS
read `p` as a point of the ring of `y`). -/
theorem isTip_comm {p y : ℂ} {T : Set ℂ} : F.IsTip p y T ↔ F.IsTip y p T :=
  ⟨fun h => ⟨h.1, h.2.2, h.2.1⟩, fun h => ⟨h.1, h.2.2, h.2.1⟩⟩

/-- The tips' colours are symmetric in the two points. -/
theorem tipColours_comm (p y : ℂ) : F.tipColours p y = F.tipColours y p := by
  ext c
  exact ⟨fun ⟨T, hT, h⟩ => ⟨T, hT, isTip_comm.mp h⟩, fun ⟨T, hT, h⟩ => ⟨T, hT, isTip_comm.mp h⟩⟩

/-- `O_y` is the set of colours of the outer tiles at `y`: the definition by colours and the definition by tiles agree. -/
theorem mem_outerTileColours_iff {p y : ℂ} {c : Fin k} :
    c ∈ F.outerTileColours p y ↔ ∃ T, F.TileOf c T ∧ F.IsOuterTileAt p y T := by
  constructor
  · rintro ⟨hc, T, hT, hy, hp⟩
    exact ⟨T, hT, hT.1, hy, hp, c, hc, hT.2⟩
  · rintro ⟨T, hT, -, hy, hp, c', hc', hTc'⟩
    obtain ⟨z, hz⟩ := hT.1.nonempty
    have h1 : F.col z = c := hT.2 hz
    have h2 : F.col z = c' := hTc' hz
    have hcc : c = c' := by rw [← h1, h2]
    exact ⟨hcc ▸ hc', T, hT, hy, hp⟩

/-- An outer tile is no tip. -/
theorem IsOuterTileAt.not_isTip {p y : ℂ} {T : Set ℂ} (h : F.IsOuterTileAt p y T) : ¬ F.IsTip p y T :=
  fun ht => h.2.2.1 ht.2.1

/-- A tip colour is carried at `p` and at `y`. -/
theorem tipColours_subset (p y : ℂ) : F.tipColours p y ⊆ F.coloursAt p ∩ F.coloursAt y := by
  rintro c ⟨T, hT, -, hp, hy⟩
  exact ⟨mem_coloursAt_of_tileOf hT hp, mem_coloursAt_of_tileOf hT hy⟩

/-- An outer tile's colour is carried at `p` and at `y`. -/
theorem outerTileColours_subset (p y : ℂ) : F.outerTileColours p y ⊆ F.coloursAt p ∩ F.coloursAt y := by
  rintro c ⟨hc, T, hT, hy, -⟩
  exact ⟨hc, mem_coloursAt_of_tileOf hT hy⟩

/-- **The colours `p` and `y` share are the tips' and the outer tiles'** (at a point `y` of the domain). -/
theorem coloursAt_inter_eq (p : ℂ) {y : ℂ} (hy : y ∈ F.dom) :
    F.coloursAt p ∩ F.coloursAt y = F.tipColours p y ∪ F.outerTileColours p y := by
  apply Subset.antisymm
  · rintro c ⟨hcp, hcy⟩
    obtain ⟨T, hT, hyT⟩ := (F.mem_coloursAt_iff_exists_tileOf hy).mp hcy
    by_cases hpT : p ∈ closure T
    · exact Or.inl ⟨T, hT, hT.1, hpT, hyT⟩
    · exact Or.inr ⟨hcp, T, hT, hyT, hpT⟩
  · exact union_subset (tipColours_subset p y) (outerTileColours_subset p y)

/-- **The non-Siamese engine**: in a valid non-Siamese map, two tiles of one colour with closure points nearer than `1`
are one tile. -/
theorem NonSiamese.tile_eq_of_dist_lt (hN : F.NonSiamese) (hF : F.Valid) {c : Fin k} {A B : Set ℂ}
    (hA : F.TileOf c A) (hB : F.TileOf c B) {z z' : ℂ} (hz : z ∈ closure A) (hz' : z' ∈ closure B)
    (h : dist z z' < 1) : A = B :=
  hN.eq_of_unitNear hA hB (unitNear_of_mem_closure hF hA hB hz hz' h)

/-- **One tile per colour at a point**, in a valid non-Siamese map. -/
theorem NonSiamese.tile_eq_of_mem_closure (hN : F.NonSiamese) (hF : F.Valid) {c : Fin k} {A B : Set ℂ}
    (hA : F.TileOf c A) (hB : F.TileOf c B) {z : ℂ} (hzA : z ∈ closure A) (hzB : z ∈ closure B) : A = B :=
  hN.tile_eq_of_dist_lt hF hA hB hzA hzB (by rw [dist_self]; exact one_pos)

/-- In a valid non-Siamese map no colour is both a tip's and an outer tile's at `y`. -/
theorem disjoint_tipColours_outerTileColours (hN : F.NonSiamese) (hF : F.Valid) (p y : ℂ) :
    Disjoint (F.tipColours p y) (F.outerTileColours p y) := by
  rw [Set.disjoint_left]
  rintro c ⟨T, hT, -, hpT, hyT⟩ ⟨-, T', hT', hyT', hpT'⟩
  exact hpT' (hN.tile_eq_of_mem_closure hF hT hT' hyT hyT' ▸ hpT)

/-- A tile of `p` lies in the open unit disc about `p`. -/
theorem TileAt.subset_ball (hF : F.Valid) {p : ℂ} {T : Set ℂ} (h : F.TileAt p T) : T ⊆ ball p 1 :=
  h.1.subset_ball hF h.2

/-- **A set inside `B̄(r(ψ), 1)` approaches `p` only along directions within `90°` of `ψ`.** -/
theorem coneAt_subset_of_subset_closedBall {S : Set ℂ} {p : ℂ} {ψ : ℝ} (hS : S ⊆ closedBall (ringPt p ψ) 1) :
    coneAt S p ⊆ angleIcc (ψ - π / 2) (ψ + π / 2) := fun _ hβ =>
  mem_angleIcc_of_cos_nonneg_single (cos_nonneg_of_mem_coneAt (y := p) (γ := ψ) hS hβ)

/-- **The tangent cone of the complement of a unit disc at a boundary point**, in the form this module reads
(`cos_nonpos_of_mem_coneAt` of `Plane/ValidMap/UnitArc`, its hypothesis as a disjointness): a set missing `B(y + e γ, 1)`
approaches `y` only along directions `β` with `cos(β − γ) ≤ 0`. -/
theorem cos_nonpos_of_coneAt_of_disjoint {S : Set ℂ} {y : ℂ} {γ : ℝ} (hS : Disjoint S (ball (y + e γ) 1)) {β : ℝ}
    (hβ : β ∈ coneAt S y) : Real.cos (β - γ) ≤ 0 :=
  cos_nonpos_of_mem_coneAt (fun _ hz => not_lt.mp fun hlt => Set.disjoint_left.mp hS hz (mem_ball.mpr hlt)) hβ

/-- **A set missing `B(r(ψ), 1)` approaches `p` only along directions at least `90°` from `ψ`.** -/
theorem coneAt_subset_of_disjoint_ball {S : Set ℂ} {p : ℂ} {ψ : ℝ} (hS : Disjoint S (ball (ringPt p ψ) 1)) :
    coneAt S p ⊆ angleIcc (ψ + π / 2) (ψ + 3 * π / 2) := by
  intro β hβ
  have h := cos_nonpos_of_coneAt_of_disjoint (y := p) (γ := ψ) hS hβ
  have h' : 0 ≤ Real.cos (β - (ψ + π)) := by
    rw [show β - (ψ + π) = (β - ψ) - π by ring, Real.cos_sub_pi]; linarith
  have h2 := mem_angleIcc_of_cos_nonneg_single h'
  rwa [show ψ + π - π / 2 = ψ + π / 2 by ring, show ψ + π + π / 2 = ψ + 3 * π / 2 by ring] at h2

/-- **A set approaching `p` along a direction within `90°` of `ψ` has points in `B(r(ψ), 1)`.** -/
theorem inter_ball_nonempty_of_coneAt {S : Set ℂ} {p : ℂ} {ψ β : ℝ} (hβ : β ∈ coneAt S p)
    (hcos : 0 < Real.cos (β - ψ)) : (S ∩ ball (ringPt p ψ) 1).Nonempty := by
  by_contra hne
  have hd : Disjoint S (ball (p + e ψ) 1) :=
    Set.disjoint_iff_inter_eq_empty.mpr (Set.not_nonempty_iff_eq_empty.mp hne)
  linarith [cos_nonpos_of_coneAt_of_disjoint hd hβ]

/-- **A set approaching `p` along a direction more than `90°` from `ψ` has points outside `B̄(r(ψ), 1)`.** -/
theorem exists_not_mem_closedBall_of_coneAt {S : Set ℂ} {p : ℂ} {ψ β : ℝ} (hβ : β ∈ coneAt S p)
    (hcos : Real.cos (β - ψ) < 0) : ∃ z ∈ S, z ∉ closedBall (ringPt p ψ) 1 := by
  by_contra hne
  push Not at hne
  have hs : S ⊆ closedBall (p + e ψ) 1 := hne
  linarith [cos_nonneg_of_mem_coneAt hs hβ]

/-- **A set approaching `r(ψ)` along a direction pointing to the side of `p` has points in `B(p, 1)`.** -/
theorem inter_ball_nonempty_of_inward_cone {S : Set ℂ} {p : ℂ} {ψ β : ℝ} (hβ : β ∈ coneAt S (ringPt p ψ))
    (hcos : Real.cos (β - ψ) < 0) : (S ∩ ball p 1).Nonempty := by
  have hp : ringPt (ringPt p ψ) (ψ + π) = p := by
    simp only [ringPt, e_add_pi]; ring
  have h := inter_ball_nonempty_of_coneAt (p := ringPt p ψ) (ψ := ψ + π) hβ (by
    rw [show β - (ψ + π) = (β - ψ) - π by ring, Real.cos_sub_pi]; linarith)
  rwa [hp] at h

/-- **A tip's cone at `p`** lies in `[ψ − 90°, ψ + 90°]` (FS116-N2-STAR's second clause, in any valid map). -/
theorem IsTip.coneAt_subset (hF : F.Valid) {p : ℂ} {ψ : ℝ} {T : Set ℂ} (h : F.IsTip p (ringPt p ψ) T) :
    coneAt T p ⊆ angleIcc (ψ - π / 2) (ψ + π / 2) :=
  coneAt_subset_of_subset_closedBall ((h.1.subset_ball hF h.2.2).trans ball_subset_closedBall)

/-- The two pairs are the four germs: a change point is a hub exactly when both pairs are free. -/
theorem isHub_iff {p : ℂ} {ψ : ℝ} :
    F.IsHub p ψ ↔ (∃ X X', F.IsChangePoint p ψ X X') ∧ F.TipPairFree p ψ ∧ F.OuterPairFree p ψ := by
  constructor
  · rintro ⟨hc, h⟩
    exact ⟨hc, ⟨(h .cw).2, (h .ccw).1⟩, ⟨(h .cw).1, (h .ccw).2⟩⟩
  · rintro ⟨hc, ht, ho⟩
    refine ⟨hc, fun s => ?_⟩
    cases s
    · exact ⟨ho.1, ht.1⟩
    · exact ⟨ht.2, ho.2⟩

/-- A hub is no semi-hub. -/
theorem IsHub.not_isSemiHub {p : ℂ} {ψ : ℝ} (h : F.IsHub p ψ) (kind : SemiKind) : ¬ F.IsSemiHub p ψ kind := by
  obtain ⟨-, ht, ho⟩ := isHub_iff.mp h
  cases kind
  · exact fun hs => hs.2.2 ht
  · exact fun hs => hs.2.2 ho

/-- A full semi-hub is a semi-hub. -/
theorem IsFullSemiHub.isSemiHub {p : ℂ} {ψ : ℝ} {kind : SemiKind} (h : F.IsFullSemiHub p ψ kind) :
    F.IsSemiHub p ψ kind := by
  cases kind
  · exact ⟨h.1, h.2.1, fun ht => ht.1 h.2.2.1⟩
  · exact ⟨h.1, h.2.1, fun ho => ho.1 h.2.2.1⟩

/-- A germ on a (Q) arc with named colours lies on a (Q) arc. -/
theorem GermOnQWith.germOnQ {p : ℂ} {θ : ℝ} {s : Side} {a a' : Fin k} (h : F.GermOnQWith p θ s a a') :
    F.GermOnQ p θ s := by
  obtain ⟨θ₁, θ₂, hra, ha, ha', h4, hg⟩ := h
  exact ⟨θ₁, θ₂, ⟨a, a', hra, ha, ha', h4⟩, hg⟩

/-- A Γ-free ring carries no arc of `Γ` with constant sides. -/
theorem GammaFreeRing.not_isRingArc {p : ℂ} (h : F.GammaFreeRing p) (θ₁ θ₂ : ℝ) (c c' : Fin k) :
    ¬ F.IsRingArc p θ₁ θ₂ c c' := by
  rintro ⟨hlt, hsub, -⟩
  exact h (ringPt p θ₁) ⟨θ₁, θ₂, hlt, ⟨θ₁, left_mem_Icc.mpr hlt.le, rfl⟩, hsub⟩

/-- A Γ-free ring is (Q)-free. -/
theorem GammaFreeRing.qFreeRing {p : ℂ} (h : F.GammaFreeRing p) : F.QFreeRing p := by
  rintro θ₁ θ₂ ⟨c, c', hra, -⟩
  exact h.not_isRingArc θ₁ θ₂ c c' hra

/-- On a (Q)-free ring no germ lies on a (Q) arc. -/
theorem QFreeRing.not_germOnQ {p : ℂ} (h : F.QFreeRing p) (θ : ℝ) (s : Side) : ¬ F.GermOnQ p θ s := by
  rintro ⟨θ₁, θ₂, hq, -⟩
  exact h θ₁ θ₂ hq

/-- **On a (Q)-free ring every change point is a hub.** -/
theorem QFreeRing.isHub {p : ℂ} (h : F.QFreeRing p) {ψ : ℝ} {X X' : Fin k} (hy : F.IsChangePoint p ψ X X') :
    F.IsHub p ψ :=
  ⟨⟨X, X', hy⟩, fun s => ⟨h.not_germOnQ _ s, h.not_germOnQ _ s⟩⟩

end ArcMap

/-- A germ accumulates at its ring point: if the germ on side `s` of `r(θ)` lies in `S`, then `r(θ) ∈ cl S`. -/
theorem GermIn.ringPt_mem_closure {p : ℂ} {θ : ℝ} {s : Side} {S : Set ℂ} (h : GermIn p θ s S) :
    ringPt p θ ∈ closure S := by
  obtain ⟨δ, hδ, hS⟩ := h
  rw [Metric.mem_closure_iff]
  intro ε hε
  have ht0 : 0 < min (δ / 2) (ε / 2) := lt_min (by linarith) (by linarith)
  refine ⟨ringPt p (θ + s.sign * min (δ / 2) (ε / 2)),
    hS ⟨min (δ / 2) (ε / 2), ⟨ht0, lt_of_le_of_lt (min_le_left _ _) (by linarith)⟩, rfl⟩, ?_⟩
  exact lt_of_le_of_lt (ArcMap.dist_ringPt_germ_le p θ s ht0.le) (lt_of_le_of_lt (min_le_right _ _) (by linarith))

/-! ## Spec examples -/

/-- **Inhabitant**: `halfPlane2`'s ring about `0` is Γ-free. -/
theorem halfPlane2_gammaFreeRing : halfPlane2.GammaFreeRing 0 := by
  rintro x ⟨θ₁, θ₂, hlt, -, hsub⟩
  obtain ⟨θ, hθ, hs⟩ := exists_sin_ne_zero_of_lt hlt
  apply hs
  have := halfPlane2_im_eq_zero_of_mem_Γ (hsub ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩)
  simpa [ringPt, e_eq, Complex.sin_ofReal_re, Complex.cos_ofReal_re] using this

/-- On `halfPlane2`'s ring the change point `r(0)` is a hub, by the class lemma, and so a semi-hub of neither kind. -/
example (kind : ArcMap.SemiKind) : ¬ halfPlane2.IsSemiHub 0 0 kind :=
  (halfPlane2_gammaFreeRing.qFreeRing.isHub halfPlane2_isChangePoint).not_isSemiHub kind

/-- Both germ pairs are free at `halfPlane2`'s hub. -/
example : halfPlane2.TipPairFree 0 0 ∧ halfPlane2.OuterPairFree 0 0 :=
  (ArcMap.isHub_iff.mp (halfPlane2_gammaFreeRing.qFreeRing.isHub halfPlane2_isChangePoint)).2

/-- **Adversary**: `quadRing`'s ring about `0` carries a (Q) arc, so it is not (Q)-free and not Γ-free. -/
example : ¬ quadRing.QFreeRing 0 ∧ ¬ quadRing.GammaFreeRing 0 :=
  ⟨fun h => h 0 (π / 2) quadRing_isQArc, fun h => h.qFreeRing 0 (π / 2) quadRing_isQArc⟩

/-- **Adversary**: a germ of `quadRing`'s ring lies on a (Q) arc with its colours named — inner `0`, outer `2`. -/
example : quadRing.GermOnQWith 0 (π / 4) .ccw 0 2 := by
  refine ⟨0, π / 2, quadRing_isRingArc, by simp [quadRing_coloursAt_zero], by simp [quadRing_coloursAt_zero],
    by rw [quadRing_coloursAt_zero, ncard_univ, Nat.card_eq_fintype_card, Fintype.card_fin], π / 4, by positivity, ?_⟩
  rintro _ ⟨t, ⟨ht0, ht1⟩, rfl⟩
  exact ⟨π / 4 + Side.ccw.sign * t, ⟨by simp [Side.sign]; linarith [Real.pi_pos], by
    simp [Side.sign]; linarith⟩, rfl⟩

/-- A tip is a tile of both points, and no outer tile is a tip: the two sorts of tile at `y` are exclusive by definition. -/
example {k : ℕ} (F : ArcMap k) (p y : ℂ) (T : Set ℂ) (h : F.IsTip p y T) : ¬ F.IsOuterTileAt p y T :=
  fun ho => ho.not_isTip h

/-- A colour absent at `p` is neither a tip's nor an outer tile's. -/
example {k : ℕ} (F : ArcMap k) (p y : ℂ) (c : Fin k) (hc : c ∉ F.coloursAt p) :
    c ∉ F.tipColours p y ∪ F.outerTileColours p y :=
  fun h => hc (h.elim (fun h => (ArcMap.tipColours_subset p y h).1) fun h => h.1)

/-- On the diagonal the definitions say what they should: every tile of `p` is a tip at `p`, so `T_p = C(p)`. -/
example {k : ℕ} (F : ArcMap k) {p : ℂ} (hp : p ∈ F.dom) : F.tipColours p p = F.coloursAt p := by
  ext c
  constructor
  · exact fun h => (ArcMap.tipColours_subset p p h).1
  · intro hc
    obtain ⟨T, hT, hpT⟩ := (F.mem_coloursAt_iff_exists_tileOf hp).mp hc
    exact ⟨T, hT, hT.1, hpT, hpT⟩

/-- **Adversary**: on the diagonal there is no outer tile — the clause "not a tile of `p`" is read. -/
example {k : ℕ} (F : ArcMap k) (p : ℂ) : F.outerTileColours p p = ∅ := by
  ext c
  simp only [mem_empty_iff_false, iff_false]
  rintro ⟨-, T, -, h, h'⟩
  exact h' h

end HadwigerNelson.Plane
