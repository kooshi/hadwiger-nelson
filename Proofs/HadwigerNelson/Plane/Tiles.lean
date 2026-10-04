import Proofs.HadwigerNelson.Plane.LocalStructure
import Proofs.HadwigerNelson.Plane.Diameter

/-!
# Tiles of one colour at the unit distance: N-E1, near and far, meeting tiles, clusters, the whole-tile restriction

Wave 3's tile rows (`plans/FS131-w3-kernel-plan.md`, stage 3), over `ArcMap` (`Plane/ArcMap`, `Plane/LocalMap`), every
one Siamese-allowed and at any number of colours `k`:

* **FS116-V5-NE1** — `ne1_region` (class form: a point of the closure of a colour class is at distance `≠ 1` from every
  point of the class) and its "in particular" for a tile `T` and a point `x` of its closure: `T ⊆ B(x, 1)`,
  `cl T ⊆ B̄(x, 1)`, every two points of `T` nearer than `1`;
* **FS116-V4-DICHOTOMY** — two tiles of one colour are near (`UnitNear`) or far (`UnitFar`); a tile is near itself and its
  closure has every two points within `1`; closure points below `1` make them near, above `1` far; in a non-Siamese map
  near tiles are equal;
* **FS116-V4-MEET** — two tiles of one colour with a common closure point are near the same tiles of that colour;
* **FS116-S1-CLUSTER** — a finite family of tiles of one colour whose closures have connected union, one point of it below
  `1` from the closure of a tile `U` of that colour, has every point within `1` of `cl U`;
* **FS129-OR1-WHOLE** — the whole-tile restriction `F_ρ` (`ArcMap.wholeRestrict`): valid, covering every smaller disc, its
  tiles exactly the tiles of `F` meeting `B(p, ρ)`, non-Siamese and simple inherited; and for `ρ ≤ √3`, no tile of `F_ρ` of
  colour `c` has `p + 2u` in its closure when `p + u` is a closure point of the inner part of a tile of colour `c`.

"A tile of colour `c`" in a hypothesis about closures is read as the colour class `F.region c` (`Plane/LocalMap`'s reading),
which is weaker as a hypothesis, so the formal theorem is the stronger.

**Inhabitants.** Every theorem here takes a valid `ArcMap`: `sixFrag_valid` (`Plane/SixFragment`) is one, as is any
one-colour map of a disc of radius below `1/2`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS116-V5-NE1 -/

/-- A valid map's colour classes have no unit pairs at all, so in particular null unit pairs. -/
theorem Valid.unitPairsNull_region (hF : F.Valid) (c : Fin k) : UnitPairsNull (F.region c) := by
  sorry

/-- **FS116-V5-NE1**, first clause (**N-E1**, class form): in a valid map, a point `x` of the closure of the class of `c` is
at distance `≠ 1` from every point `z` of the class (FS129-SR2-CLOSURE at the open class, per SR2 item 9). -/
theorem ne1_region (hF : F.Valid) {c : Fin k} {x z : ℂ} (hx : x ∈ closure (F.region c)) (hz : z ∈ F.region c) :
    dist z x ≠ 1 := by
  sorry

/-- **FS116-V5-NE1**, "in particular" (i): every tile lies in the open unit disc about each point of its closure. -/
theorem IsTile.subset_ball (hF : F.Valid) {T : Set ℂ} (hT : F.IsTile T) {x : ℂ} (hx : x ∈ closure T) :
    T ⊆ ball x 1 := by
  sorry

/-- **FS116-V5-NE1**, "in particular" (ii): the closure of a tile lies in the closed unit disc about each point of it. -/
theorem IsTile.closure_subset_closedBall (hF : F.Valid) {T : Set ℂ} (hT : F.IsTile T) {x : ℂ}
    (hx : x ∈ closure T) : closure T ⊆ closedBall x 1 := by
  sorry

/-- **FS116-V5-NE1**, "in particular" (iii): every two points of a tile are nearer than `1` (the row's "diameter at most
1", pointwise and strict; FS106-DIAM (i) for the connectedness step, per SR2 item 9). -/
theorem IsTile.dist_lt_one (hF : F.Valid) {T : Set ℂ} (hT : F.IsTile T) :
    ∀ a ∈ T, ∀ b ∈ T, dist a b < 1 := by
  sorry

/-! ## FS116-V4-DICHOTOMY -/

/-- **FS116-V4-DICHOTOMY**, first clause: two tiles of one colour (equal allowed) are near or far (FS111-M-HULL2's case
for two open tiles, per SR2 item 10). -/
theorem unitNear_or_unitFar (hF : F.Valid) {c : Fin k} {A B : Set ℂ} (hA : F.TileOf c A) (hB : F.TileOf c B) :
    UnitNear A B ∨ UnitFar A B := by
  sorry

/-- **FS116-V4-DICHOTOMY**, "`A ~ A`" (FS106-DIAM (i), per SR2 item 9). -/
theorem IsTile.unitNear_self (hF : F.Valid) {A : Set ℂ} (hA : F.IsTile A) : UnitNear A A :=
  hA.dist_lt_one hF

/-- **FS116-V4-DICHOTOMY**, "so the closure of a tile has diameter at most 1" (pointwise). -/
theorem IsTile.dist_le_one_of_mem_closure (hF : F.Valid) {A : Set ℂ} (hA : F.IsTile A) :
    ∀ a ∈ closure A, ∀ b ∈ closure A, dist a b ≤ 1 := by
  sorry

/-- **FS116-V4-DICHOTOMY**: closure points of two tiles of one colour at distance below `1` make the tiles near. -/
theorem unitNear_of_mem_closure (hF : F.Valid) {c : Fin k} {A B : Set ℂ} (hA : F.TileOf c A) (hB : F.TileOf c B)
    {z z' : ℂ} (hz : z ∈ closure A) (hz' : z' ∈ closure B) (h : dist z z' < 1) : UnitNear A B := by
  sorry

/-- **FS116-V4-DICHOTOMY**: closure points of two tiles of one colour at distance above `1` make the tiles far. -/
theorem unitFar_of_mem_closure (hF : F.Valid) {c : Fin k} {A B : Set ℂ} (hA : F.TileOf c A) (hB : F.TileOf c B)
    {z z' : ℂ} (hz : z ∈ closure A) (hz' : z' ∈ closure B) (h : 1 < dist z z') : UnitFar A B := by
  sorry

/-- **FS116-V4-DICHOTOMY**, last clause: in a non-Siamese map near tiles of one colour are equal (validity is not read). -/
theorem NonSiamese.eq_of_unitNear (hN : F.NonSiamese) {c : Fin k} {A B : Set ℂ} (hA : F.TileOf c A)
    (hB : F.TileOf c B) (h : UnitNear A B) : A = B := by
  sorry

/-! ## FS116-V4-MEET -/

/-- **FS116-V4-MEET**: if tiles `A`, `B` of one colour have a common closure point, every tile `T` of that colour is near
`A` exactly when it is near `B`. -/
theorem unitNear_iff_of_mem_closure_inter (hF : F.Valid) {c : Fin k} {A B T : Set ℂ} (hA : F.TileOf c A)
    (hB : F.TileOf c B) {z : ℂ} (hzA : z ∈ closure A) (hzB : z ∈ closure B) (hT : F.TileOf c T) :
    UnitNear T A ↔ UnitNear T B := by
  sorry

/-! ## FS116-S1-CLUSTER -/

/-- **FS116-S1-CLUSTER**: let `𝒯` be a finite family of tiles of colour `c` whose closures have connected union, and `U` a
tile of colour `c`; if some point of the union is nearer than `1` to some point of `cl U`, every point of the union is
within `1` of every point of `cl U`. -/
theorem cluster (hF : F.Valid) {c : Fin k} {𝒯 : Set (Set ℂ)} (hfin : 𝒯.Finite) (h𝒯 : ∀ T ∈ 𝒯, F.TileOf c T)
    (hconn : IsPreconnected (⋃ T ∈ 𝒯, closure T)) {U : Set ℂ} (hU : F.TileOf c U)
    (hnear : ∃ x ∈ ⋃ T ∈ 𝒯, closure T, ∃ y ∈ closure U, dist x y < 1) :
    ∀ x ∈ ⋃ T ∈ 𝒯, closure T, ∀ y ∈ closure U, dist x y ≤ 1 := by
  sorry

/-! ## FS129-OR1-WHOLE: the whole-tile restriction -/

/-- **FS129-OR1-WHOLE**, validity: `F_ρ` is valid when `F` is. -/
theorem Valid.wholeRestrict (hF : F.Valid) (p : ℂ) (ρ : ℝ) : (F.wholeRestrict p ρ).Valid := by
  sorry

/-- **FS129-OR1-WHOLE**, the disc: if `F` covers `B̄(p, r)` and `ρ ≤ r`, then `F_ρ` covers `B̄(p, ρ')` for every `ρ' < ρ`
(finitely many tiles meet a small disc about each point, `finite_tiles_near`). -/
theorem wholeRestrict_covers {p : ℂ} {r ρ ρ' : ℝ} (hr : F.Covers p r) (hρ : ρ ≤ r) (hρ' : ρ' < ρ) :
    (F.wholeRestrict p ρ).Covers p ρ' := by
  sorry

/-- **FS129-OR1-WHOLE**, the tiles: the tiles of `F_ρ` are exactly the tiles of `F` meeting `B(p, ρ)` (the same sets, so
the same closures and the same colours). -/
theorem isTile_wholeRestrict_iff {p : ℂ} {ρ : ℝ} {T : Set ℂ} :
    (F.wholeRestrict p ρ).IsTile T ↔ F.IsTile T ∧ (T ∩ ball p ρ).Nonempty := by
  sorry

/-- **FS129-OR1-WHOLE**, the tiles at `p`: for `ρ > 0`, a tile of `F` with `p` in its closure is a tile of `F_ρ` (and
conversely, by `isTile_wholeRestrict_iff`). -/
theorem isTile_wholeRestrict_of_mem_closure {p : ℂ} {ρ : ℝ} (hρ : 0 < ρ) {T : Set ℂ} (hT : F.IsTile T)
    (hp : p ∈ closure T) : (F.wholeRestrict p ρ).IsTile T := by
  sorry

/-- **FS129-OR1-WHOLE**: `F_ρ` is non-Siamese if `F` is. -/
theorem NonSiamese.wholeRestrict (hN : F.NonSiamese) (p : ℂ) (ρ : ℝ) : (F.wholeRestrict p ρ).NonSiamese := by
  sorry

/-- **FS129-OR1-WHOLE**: `F_ρ` is simple if `F` is (closures read in the plane, as the row reads them). -/
theorem Simple.wholeRestrict (hS : F.Simple) (p : ℂ) (ρ : ℝ) : (F.wholeRestrict p ρ).Simple := by
  sorry

/-- **FS129-OR1-WHOLE**, the `R₂` clause, at the class its argument reads (pointwise in the arc, and with no use of the
arc lying in `Γ`): for `ρ ≤ √3`, if `p + e θ` is a closure point of the part inside `B(p, 1)` of a tile `T` of colour `c`
of `F`, no tile of `F_ρ` of colour `c` has `p + 2 e θ` in its closure. (A tile of `F_ρ` of colour `c` lies in
`B(p + 2e θ, 1)` and meets `B(p, √3)`, so by the parallelogram identity it comes within `1` of `p + e θ`, hence of `T`:
`T` and it are near, while the points of `T ∩ B(p, 1)` are more than `1` from `p + 2e θ`.) -/
theorem not_mem_closure_wholeRestrict_of_inner {p : ℂ} {ρ : ℝ} (hF : F.Valid) (hρ : ρ ≤ √3) {c : Fin k}
    {T : Set ℂ} (hT : F.TileOf c T) {θ : ℝ} (hθ : ringPt p θ ∈ closure (T ∩ ball p 1)) {T' : Set ℂ}
    (hT' : (F.wholeRestrict p ρ).TileOf c T') : p + 2 * e θ ∉ closure T' := by
  sorry

/-- **FS129-OR1-WHOLE**, the `R₂` clause in the row's form: for `ρ ≤ √3` and an arc `r([θ₁, θ₂])` of `ω(p)` of positive
length whose inner side is one tile `T`, of colour `c` (every interior angle has the points `p + (1 − η) e θ`, `η > 0`
small, in `T`), no tile of `F_ρ` of colour `c` has a point of `R₂(ᾱ) = {p + 2u : p + u ∈ ᾱ}` in its closure. -/
theorem not_mem_closure_wholeRestrict_R₂ {p : ℂ} {ρ : ℝ} (hF : F.Valid) (hρ : ρ ≤ √3) {c : Fin k} {T : Set ℂ}
    (hT : F.TileOf c T) {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂)
    (hinner : ∀ θ ∈ Ioo θ₁ θ₂, ∃ δ > 0, ∀ η ∈ Ioo 0 δ, p + ((1 - η : ℝ) : ℂ) * e θ ∈ T) {T' : Set ℂ}
    (hT' : (F.wholeRestrict p ρ).TileOf c T') : ∀ θ ∈ Icc θ₁ θ₂, p + 2 * e θ ∉ closure T' := by
  sorry

end ArcMap

end HadwigerNelson.Plane
