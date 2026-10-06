import Proofs.HadwigerNelson.Plane.Saturated.Basic

/-!
FS131-K6 — a DESIGN, not a library module: the two forms of REG-J′ and the bridge between them, for the second
planning pass and for the deriver's job (plans/FS131-w6-kernel-plan.md § 6). Checked with `lake env lean` only.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

namespace AeColouring

/-- The **interface arcs meeting `z`**: the connected components of `𝓘` with `z` in their closure. -/
def arcsAt (c : AeColouring k) (z : ℂ) : Set (Set ℂ) :=
  {A | (∃ y ∈ c.interfaceSet, A = connectedComponentIn c.interfaceSet y) ∧ z ∈ closure A}

/-- **REG-J′, the frozen words** (`data/fs111/claims.md` § 6; `data/fs121/claims.md` § 0): `Σ` is locally finite, and
each point of `Σ` meets finitely many interface arcs. -/
def RegJLiteral (c : AeColouring k) : Prop :=
  (∀ x : ℂ, ∃ r > 0, (c.singularSet ∩ ball x r).Finite) ∧ ∀ z ∈ c.singularSet, (c.arcsAt z).Finite

/-- A **fan** at `z` (`data/fs121/claims.md`, the close's note to § 0): a disc `B(z, r)` whose only possible point of
`Σ` is `z`, in which the essential boundary off `z` is `n` branches, branch `i` the polar graph
`{z + t e(φ i t) : 0 < t < r}` with limit direction `dir i`, in counter-clockwise order; the region counter-clockwise of
branch `i` is almost everywhere of the colour `col i`. -/
structure Fan (c : AeColouring k) (z : ℂ) where
  /-- The radius of the disc. -/
  r : ℝ
  r_pos : 0 < r
  /-- The number of branches. -/
  n : ℕ
  /-- The angle of branch `i` at distance `t` from `z`. -/
  φ : Fin n → ℝ → ℝ
  /-- The limit direction of branch `i` at `z` (its end tangent). -/
  dir : Fin n → ℝ
  /-- The colour of the region counter-clockwise of branch `i`. -/
  col : Fin n → Fin k
  cont : ∀ i, ContinuousOn (φ i) (Ioo 0 r)
  tendsto : ∀ i, Tendsto (φ i) (𝓝[>] 0) (𝓝 (dir i))
  mono : ∀ t ∈ Ioo 0 r, StrictMono fun i => φ i t
  wrap : ∀ t ∈ Ioo 0 r, ∀ i j, φ i t < φ j t + 2 * Real.pi
  singular : c.singularSet ∩ ball z r ⊆ {z}
  bdry : c.essBdry ∩ (ball z r \ {z}) = ⋃ i, {w | ∃ t ∈ Ioo 0 r, w = z + (t : ℂ) * e (φ i t)}
  region : ∀ i : Fin n, {w | ∃ t ∈ Ioo 0 r, ∃ θ, φ i t < θ ∧
      θ < (if h : (i : ℕ) + 1 < n then φ ⟨i + 1, h⟩ t else φ ⟨0, i.pos⟩ t + 2 * Real.pi) ∧
      w = z + (t : ℂ) * e θ} ≤ᵐ[volume] c.cls (col i)

/-- The limit direction of the branch after `i`, counter-clockwise (the first branch's, a turn on, after the last). -/
noncomputable def Fan.nextDir {c : AeColouring k} {z : ℂ} (F : c.Fan z) (i : Fin F.n) : ℝ :=
  if h : (i : ℕ) + 1 < F.n then F.dir ⟨i + 1, h⟩ else F.dir ⟨0, i.pos⟩ + 2 * Real.pi

/-- The colour `j` **occupies a sector of positive angle** at `z`: a region of colour `j` between branches of
different limit directions. -/
def Fan.HasSector {c : AeColouring k} {z : ℂ} (F : c.Fan z) (j : Fin k) : Prop :=
  ∃ i, F.col i = j ∧ F.dir i < F.nextDir i

/-- The colour `j` occupies a **zero-angle region** (a horn) at `z`. -/
def Fan.HasHorn {c : AeColouring k} {z : ℂ} (F : c.Fan z) (j : Fin k) : Prop :=
  ∃ i, F.col i = j ∧ F.dir i = F.nextDir i

/-- **REG-J′, the fan form with end tangents** (the hypothesis wave 6's rows take). -/
def RegJFan (c : AeColouring k) : Prop :=
  (∀ x : ℂ, ∃ r > 0, (c.singularSet ∩ ball x r).Finite) ∧ ∀ z ∈ c.singularSet, Nonempty (c.Fan z)

/-- **The bridge, a question for a deriver** (not a backlog row; no hand proof found): do the frozen words and
saturation give the fan with end tangents? -/
def RegJBridge (k : ℕ) : Prop :=
  ∀ c : AeColouring k, Saturated c.cls → c.RegJLiteral → c.RegJFan

/-- FS121-DB1-L3 as the second pass would state it over a fan (a sketch of the row's shape). -/
def DB1L3Statement (k : ℕ) : Prop :=
  ∀ (c : AeColouring k), Saturated c.cls → ∀ (z : ℂ) (F : c.Fan z) (i i' : Fin F.n),
    F.dir i < F.nextDir i → F.dir i' < F.nextDir i' → F.col i = F.col i' → i = i'

end AeColouring

end HadwigerNelson.Plane
