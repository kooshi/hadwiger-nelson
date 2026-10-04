import Proofs.HadwigerNelson.Plane.LocalStructure

/-!
# The sector structure at a point of an arc map (`localSectors`)

FS-131 wave 3's engine 3 in the plan's branch form (`plans/FS131-w3-kernel-plan.md` § 6.1 item 3; inventory item 136): at a
point `v` of the domain, for small radii, the arcs are finitely many **branch germs** — each a tangent direction `β` and a
signed curvature `κ` (`0` for a segment, `±1/ρ` for a circle of radius `ρ`, positive when the centre lies to the left of
the direction of travel) — and the interior points near `v` are the open **sectors** between angularly consecutive germs.

The point at distance `s` from `v` on the germ `(β, κ)` is `v + s e(β + arcsin(κ s / 2))` (`branchPt`): the chord of length `s`
from the tangency point of a circle of curvature `κ` makes the angle `arcsin(κ s / 2)` with the tangent.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- The point at distance `s` from `v` on the branch germ with tangent direction `β` and signed curvature `κ`. -/
noncomputable def branchPt (v : ℂ) (β κ s : ℝ) : ℂ := v + (s : ℂ) * e (β + Real.arcsin (κ * s / 2))

/-- The open sector between the germs `(β₁, κ₁)` and `(β₂, κ₂)`, out to radius `r`: the points `v + s e(φ)`, `0 < s < r`,
with `φ` strictly between the two germs' directions at distance `s`. -/
def sectorBetween (v : ℂ) (β₁ κ₁ β₂ κ₂ r : ℝ) : Set ℂ :=
  {z | ∃ s ∈ Ioo 0 r, ∃ φ ∈ Ioo (β₁ + Real.arcsin (κ₁ * s / 2)) (β₂ + Real.arcsin (κ₂ * s / 2)),
    z = v + (s : ℂ) * e φ}

/-- `n` branch germs, read counter-clockwise. -/
structure BranchGerms (n : ℕ) where
  /-- The tangent directions. -/
  β : Fin n → ℝ
  /-- The signed curvatures (`0` for a segment). -/
  κ : Fin n → ℝ

namespace BranchGerms

variable {n : ℕ} (G : BranchGerms n)

/-- The direction of the germ after `i` (the first one, one turn on, after the last). -/
noncomputable def nextβ (i : Fin n) : ℝ :=
  if h : i.val + 1 < n then G.β ⟨i.val + 1, h⟩ else G.β ⟨0, by omega⟩ + 2 * π

/-- The curvature of the germ after `i`. -/
noncomputable def nextκ (i : Fin n) : ℝ :=
  if h : i.val + 1 < n then G.κ ⟨i.val + 1, h⟩ else G.κ ⟨0, by omega⟩

/-- The `i`-th sector out to radius `r`: between germ `i` and the next. -/
def sector (v : ℂ) (r : ℝ) (i : Fin n) : Set ℂ := sectorBetween v (G.β i) (G.κ i) (G.nextβ i) (G.nextκ i) r

/-- The germs are sorted: strictly increasing in `(β, κ)` lexicographically, within one turn of the first. -/
def Sorted : Prop :=
  (∀ i j : Fin n, i < j → G.β i < G.β j ∨ (G.β i = G.β j ∧ G.κ i < G.κ j)) ∧
    ∀ i : Fin n, G.β i < G.nextβ i ∨ (G.β i = G.nextβ i ∧ G.κ i < G.nextκ i)

end BranchGerms

variable {k : ℕ} (F : ArcMap k)

namespace ArcMap

/-- **The sector chart of `F` at `v` out to `r₀`** given by the germs `G`: the arcs in the punctured ball are the germs'
branches, and for every `r ≤ r₀` the interior points of the ball are the sectors between consecutive germs (the whole ball
when there is no germ) — open, connected, disjoint, each with the cone of its two germs' directions. -/
structure IsSectorChart {n : ℕ} (G : BranchGerms n) (v : ℂ) (r₀ : ℝ) : Prop where
  /-- The radius is positive. -/
  pos : 0 < r₀
  /-- The ball lies in the domain. -/
  subdom : ball v r₀ ⊆ F.dom
  /-- The germs are sorted counter-clockwise. -/
  sorted : G.Sorted
  /-- Each branch is a graph over the radius. -/
  curv : ∀ i, |G.κ i| * r₀ < 2
  /-- `v` lies on the arcs exactly when there is a germ. -/
  mem_Γ : v ∈ F.Γ ↔ 0 < n
  /-- The arcs in the punctured ball are the branches. -/
  branches : (F.Γ ∩ ball v r₀) \ {v} = ⋃ i, branchPt v (G.β i) (G.κ i) '' Ioo 0 r₀
  /-- With no germ, the ball is interior. -/
  empty : n = 0 → ball v r₀ ⊆ F.interiorPts
  /-- The interior points of a smaller ball are the sectors. -/
  cover : ∀ r ∈ Ioc 0 r₀, 0 < n → ball v r ∩ F.interiorPts = ⋃ i, G.sector v r i
  /-- Each sector is open. -/
  isOpen : ∀ r ∈ Ioc 0 r₀, ∀ i, IsOpen (G.sector v r i)
  /-- Each sector is connected. -/
  isPreconnected : ∀ r ∈ Ioc 0 r₀, ∀ i, IsPreconnected (G.sector v r i)
  /-- Distinct sectors are disjoint. -/
  disjoint : ∀ r ∈ Ioc 0 r₀, ∀ i j, i ≠ j → Disjoint (G.sector v r i) (G.sector v r j)
  /-- Each sector's cone at `v` is the interval of its two germs' directions. -/
  cone : ∀ r ∈ Ioc 0 r₀, ∀ i, coneAt (G.sector v r i) v = angleIcc (G.β i) (G.nextβ i)

end ArcMap

/-- **`localSectors`**: every point of the domain has a sector chart. -/
theorem localSectors {v : ℂ} (hv : v ∈ F.dom) : ∃ r₀, ∃ n, ∃ G : BranchGerms n, F.IsSectorChart G v r₀ := by
  sorry

end HadwigerNelson.Plane
