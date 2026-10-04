import Proofs.HadwigerNelson.Plane.LocalMap

/-!
# The local structure of an arc map at a point: finitely many tiles, the germ dichotomy, interval cones

Wave 3's supporting lemmas (`plans/FS131-w3-kernel-plan.md` § "For stage 3" and stage 3; inventory ruling 27: wave 3 takes
these forward from wave 4's foundation). Pure topology of `ArcMap`: no validity, no colour count.

* **Angular intervals.** `angleIcc a b` and `angleIoo a b` are the closed and open intervals `[a, b]`, `(a, b)` of angles,
  repeated with period `2π` — the rows' cones "`[θ₂ − 90°, θ₁ + 90°]`" read on the circle. Empty when `b < a` (resp.
  `b ≤ a`); the whole line when `b − a ≥ 2π`.
* **The disc of radius above 1.** `covers_one_iff`: a fragment covers `B̄(p, 1)` exactly when it covers a closed disc of
  radius above `1` about `p` (the domain is open and the disc compact) — so every row's "on a closed disc of radius above
  1 about `p`" is stated as `F.Covers p 1`.
* **Arcs against a unit circle.** `Arc.finite_inter_sphere_or_eq_circ`: a nondegenerate arc meets `ω(p)` in finitely many
  points or is an arc of `ω(p)` itself; `finite_ringΓ_off_ringArc`: on a covered ring, the points of `Γ` that lie on no arc
  of `Γ` on `ω(p)` are finitely many.
* **Interior points are dense** (`dense_interiorPts`): `Γ` is a locally finite union of arcs, so it has empty interior;
  every point of the domain carries a colour (`exists_mem_coloursAt`).
* **Finitely many tiles near a point** (`finite_tiles_near`, the wave's hardest leaf) and its consequences: the colours at
  a point are the colours of the tiles whose closure holds it (`mem_coloursAt_iff_exists_tileOf`), the cone of a colour
  class is the union of its tiles' cones (`coneAt_region_eq_biUnion`), every direction lies in some colour's cone
  (`exists_mem_coneAt_region`).
* **The germ dichotomy** (`germ_dichotomy`): at a ring point in the domain, a germ lies in one colour class, or on an arc of
  `Γ` on `ω(p)` with constant sides.
* **Interval cones in a simple map** (`Simple.coneAt_eq_angleIcc`): each tile's cone at a point of its closure is one closed
  angular interval.

Every leaf is `sorry` until wave 3's implementer lands it (`plans/FS131-w3-kernel-plan.md` § the leaf plans).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## Angular intervals -/

/-- The closed angular interval `[a, b]`, repeated with period `2π`. -/
def angleIcc (a b : ℝ) : Set ℝ := ⋃ m : ℤ, Icc (a + 2 * π * m) (b + 2 * π * m)

/-- The open angular interval `(a, b)`, repeated with period `2π`. -/
def angleIoo (a b : ℝ) : Set ℝ := ⋃ m : ℤ, Ioo (a + 2 * π * m) (b + 2 * π * m)

/-- `[a, b]` lies in its angular interval. -/
theorem Icc_subset_angleIcc (a b : ℝ) : Icc a b ⊆ angleIcc a b := fun x hx =>
  mem_iUnion.mpr ⟨0, by simpa using hx⟩

/-- `(a, b)` lies in its angular interval. -/
theorem Ioo_subset_angleIoo (a b : ℝ) : Ioo a b ⊆ angleIoo a b := fun x hx =>
  mem_iUnion.mpr ⟨0, by simpa using hx⟩

/-- Spec example: `2π + π/2` lies in the angular interval `[0, π]`. -/
example : 2 * π + π / 2 ∈ angleIcc 0 π := by
  refine mem_iUnion.mpr ⟨1, ?_⟩
  constructor <;> push_cast <;> linarith [Real.pi_pos]

/-- **Adversary**: `−π/2` does not lie in the angular interval `(0, π)`. -/
example : -(π / 2) ∉ angleIoo 0 π := by
  intro h
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp h
  have hπ := Real.pi_pos
  rcases lt_or_ge m 0 with hm | hm
  · have : (m : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_iff.mpr hm
    nlinarith
  · have : (0 : ℝ) ≤ m := by exact_mod_cast hm
    nlinarith

/-! ## Arcs against a unit circle -/

/-- A nondegenerate arc meets the unit circle `ω(p)` in finitely many points, unless it is an arc of `ω(p)` itself (a
line or a different circle meets `ω(p)` in at most two points). -/
theorem Arc.finite_inter_sphere_or_eq_circ (a : Arc) (ha : a.Nondegenerate) (p : ℂ) :
    (a.carrier ∩ sphere p 1).Finite ∨ ∃ θ₀ θ₁, a = .circ p 1 θ₀ θ₁ := by
  sorry

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-! ## The disc of radius above 1 -/

/-- A fragment covers `B̄(p, 1)` exactly when it covers a closed disc of radius above `1` about `p`: the domain is open and
the disc compact. Every row's "on a closed disc of radius above 1 about `p`" is stated as `F.Covers p 1`. -/
theorem covers_one_iff (p : ℂ) : F.Covers p 1 ↔ ∃ R, 1 < R ∧ F.Covers p R := by
  sorry

/-! ## The points of `Γ` on a ring that lie on no arc of `Γ` on it -/

/-- On a covered ring, the points of `Γ` that lie on no arc of `Γ` on `ω(p)` are finitely many: the ring is compact, each
of its points has a neighbourhood meeting finitely many arcs, and each arc not on `ω(p)` meets `ω(p)` in finitely many
points (`Arc.finite_inter_sphere_or_eq_circ`). -/
theorem finite_ringΓ_off_ringArc {p : ℂ} (hp : F.Covers p 1) :
    ((F.Γ ∩ sphere p 1) \ {x | F.OnRingArc p x}).Finite := by
  sorry

/-! ## Interior points are dense -/

/-- `Γ` has empty interior: every point of the domain is a limit of interior points. -/
theorem dense_interiorPts : F.dom ⊆ closure F.interiorPts := by
  sorry

/-- Every point of the domain carries a colour. -/
theorem exists_mem_coloursAt {x : ℂ} (hx : x ∈ F.dom) : ∃ c, c ∈ F.coloursAt x := by
  sorry

/-! ## Finitely many tiles near a point -/

/-- **Finitely many tiles meet a small disc about any point of the domain**: near `x` only the arcs through `x` remain,
each with at most two branches at `x`; for small `r` the branches are disjoint off `x` and cut `B(x, r)` into at most as
many curvilinear sectors as there are branches, each connected. -/
theorem finite_tiles_near {x : ℂ} (hx : x ∈ F.dom) :
    ∃ r > 0, {T | F.IsTile T ∧ (T ∩ ball x r).Nonempty}.Finite := by
  sorry

/-- The colours at a point of the domain are the colours of the tiles whose closure holds it (the rows' `P_cl`, read
tile by tile). -/
theorem mem_coloursAt_iff_exists_tileOf {x : ℂ} (hx : x ∈ F.dom) {c : Fin k} :
    c ∈ F.coloursAt x ↔ ∃ T, F.TileOf c T ∧ x ∈ closure T := by
  sorry

/-- At a point of the domain, the cone of a colour class is the union of the cones of its tiles whose closure holds the
point: "the cone of a tile of colour `c`" and "the cone of the class of `c`" agree. -/
theorem coneAt_region_eq_biUnion {x : ℂ} (hx : x ∈ F.dom) (c : Fin k) :
    coneAt (F.region c) x = ⋃ T ∈ {T | F.TileOf c T ∧ x ∈ closure T}, coneAt T x := by
  sorry

/-- At a point of the domain every direction lies in the cone of some colour (pigeonhole over the finitely many colours,
on interior points near the ray). -/
theorem exists_mem_coneAt_region {x : ℂ} (hx : x ∈ F.dom) (β : ℝ) : ∃ c, β ∈ coneAt (F.region c) x := by
  sorry

/-! ## The germ dichotomy -/

/-- **The germ dichotomy**: at a ring point `r(θ)` of the domain, the germ of `ω(p)` on either side lies in one colour
class, or on an arc of `Γ` on `ω(p)` with constant sides (the strip beside a short germ avoids every other arc, which
meets `ω(p)` in finitely many points). -/
theorem germ_dichotomy {p : ℂ} {θ : ℝ} (hθ : ringPt p θ ∈ F.dom) (s : Side) :
    (∃ c, GermIn p θ s (F.region c)) ∨
      ∃ θ₁ θ₂ c c', F.IsRingArc p θ₁ θ₂ c c' ∧ GermIn p θ s (ringArc p θ₁ θ₂) := by
  sorry

/-! ## Interval cones in a simple map -/

section Simple

variable {F}

/-- **In a simple map each tile's cone at a point of its closure is one closed angular interval** (possibly a single
direction, a cusp, or every direction): near the point the tile's boundary is a Jordan curve with exactly two branches,
each a segment or a circular arc, and the tile is the sector between them. -/
theorem Simple.coneAt_eq_angleIcc (hS : F.Simple) {T : Set ℂ} (hT : F.IsTile T) {x : ℂ} (hxd : x ∈ F.dom)
    (hx : x ∈ closure T) :
    ∃ β₁ β₂, β₁ ≤ β₂ ∧ β₂ ≤ β₁ + 2 * π ∧ coneAt T x = angleIcc β₁ β₂ := by
  sorry

end Simple

end ArcMap

end HadwigerNelson.Plane
