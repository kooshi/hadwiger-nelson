import Proofs.HadwigerNelson.Plane.Suprema

/-!
# Fills, maximal covers, shadows, Grundy colourings (FS-131 wave 2)

Rows: **FS111-C-FILL**, **FS111-M-SATC**, **FS111-M2-COV**, **FS111-M2-FIX**, **FS111-M-COVER-SC** (its second clause in
the corrected curvature form, ruling: `plans/FS131-close-inventory.md` items 18–19), **FS121-D3-GRUNDY**.
Plan: `plans/FS131-w2-kernel-plan.md` § 4. Every class is a set in a family `Fin k → Set ℂ` (`Plane/Cover`).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

open scoped Classical in
/-- The fill move: the constant colour `j` on the open disc `B(x, ρ)`, the colouring `c` elsewhere. -/
noncomputable def AeColouring.fillCol (c : AeColouring k) (x : ℂ) (ρ : ℝ) (j : Fin k) : ℂ → Fin k :=
  fun y => if y ∈ ball x ρ then j else c.col y

/-- **FS111-C-FILL**: if `x` is `j`-free with `|S̃_j ∩ A_η(x)| = 0`, the fill move on `B(x, η/2)` with colour `j` keeps the
colouring a.e.-proper with `k` colours. -/
theorem AeColouring.exists_fill (c : AeColouring k) {j : Fin k} {x : ℂ} {η : ℝ} (hx : x ∈ essClosure (c.cls j))
    (hη : 0 < η) (hfree : volume (densitySet (c.cls j) ∩ unitAnnulus x η) = 0) :
    ∃ c' : AeColouring k, c'.col = c.fillCol x (η / 2) j := by
  sorry

/-- **FS111-M-SATC**, first clause: every a.e.-proper `k`-colouring lies below a maximal admissible cover. -/
theorem AeColouring.exists_isMaximalCover (c : AeColouring k) : ∃ C, IsMaximalCover C ∧ AeLE c.cls C := by
  sorry

/-- **FS111-M-SATC**, second clause: every maximal cover's supports satisfy `ℝ² = int F_j ∪ (F_j + S¹)`. -/
theorem IsMaximalCover.interior_union_unitShadow {C : Fin k → Set ℂ} (hC : IsMaximalCover C) (j : Fin k) :
    interior (essSupport (C j)) ∪ unitShadow (essSupport (C j)) = univ := by
  sorry

/-- **FS111-M-SATC**, third clause: a selection is an a.e.-proper `k`-colouring — from any admissible family (the row
says "from a maximal cover"; the argument reads only that each class has null unit pairs: a generalization). -/
theorem IsAdmissible.exists_aeColouring {C : Fin k → Set ℂ} (hC : IsAdmissible C) {f : ℂ → Fin k}
    (hf : IsSelection C f) : ∃ c : AeColouring k, c.col = f := by
  sorry

/-- **FS111-M2-COV**: a `k`-tuple of measurable sets is a maximal admissible cover iff each coordinate is a MUA set and
their union has full measure. -/
theorem isMaximalCover_iff {C : Fin k → Set ℂ} (hC : ∀ j, MeasurableSet (C j)) :
    IsMaximalCover C ↔ (∀ j, IsMUA (C j)) ∧ ∀ᵐ x ∂volume, ∃ j, x ∈ C j := by
  sorry

/-- **FS111-M2-FIX**, the shadow identity: a regular MUA set `A` has `int F = ℝ² ∖ (F + S¹)`, `F = supp A`. -/
theorem IsRegularMUA.interior_eq_compl_unitShadow {A : Set ℂ} (hA : IsRegularMUA A) :
    interior (essSupport A) = (unitShadow (essSupport A))ᶜ := by
  sorry

/-- **FS111-M2-FIX**, its readings: every unit circle centred in `F` misses `int F`, and every component of `int F` lies
inside or outside each such circle. -/
theorem IsRegularMUA.component_side {A : Set ℂ} (hA : IsRegularMUA A) {y : ℂ} (hy : y ∈ essSupport A) :
    (∀ z ∈ interior (essSupport A), dist z y ≠ 1) ∧
      ∀ z ∈ interior (essSupport A), ∀ z' ∈ connectedComponentIn (interior (essSupport A)) z,
        (dist z y < 1 ↔ dist z' y < 1) := by
  sorry

/-- **FS111-M-COVER-SC**, first clause: in a maximal cover, at every boundary point `x` of `F_a`, each adjacent
preconnected piece `P` of `F̃_a` lies in an enclosing unit disc or outside an exterior one, the disc's circle through
`x`. (The row says path-connected; preconnected is wider.) -/
theorem IsMaximalCover.enclosing_or_exterior {C : Fin k → Set ℂ} (hC : IsMaximalCover C) (a : Fin k) {x : ℂ}
    (hx : x ∈ frontier (essSupport (C a))) {P : Set ℂ} (hP : IsPreconnected P) (hPa : P ⊆ densitySet (C a))
    (hxP : x ∈ closure P) :
    ∃ y, dist x y = 1 ∧ ((∀ p ∈ P, dist p y ≤ 1) ∨ (∀ p ∈ P, 1 ≤ dist p y)) := by
  sorry

/-- The class lies below the graph of `u` over `J` in the frame `(z₀, θ)`, locally: the points
`z₀ + e θ · (s + t i)` with `s ∈ J` and `u s − δ < t ≤ u s` are in `supp A`, and those with `u s < t < u s + δ` are not. -/
def IsLowerGraphOf (A : Set ℂ) (z₀ : ℂ) (θ : ℝ) (J : Set ℝ) (u : ℝ → ℝ) (δ : ℝ) : Prop :=
  0 < δ ∧ ∀ s ∈ J, ∀ t : ℝ, (u s - δ < t → t ≤ u s → z₀ + e θ * (s + t * I) ∈ essSupport A) ∧
    (u s < t → t < u s + δ → z₀ + e θ * (s + t * I) ∉ essSupport A)

/-- Curvature at most `1` from above, in the viscosity sense: at every `s₀ ∈ J`, every `C²` function `φ` touching `u` from
above at `s₀` has `φ''(s₀) ≤ (1 + φ'(s₀)²)^{3/2}`. -/
def CurvatureLeOne (u : ℝ → ℝ) (J : Set ℝ) : Prop :=
  ∀ s₀ ∈ J, ∀ φ : ℝ → ℝ, ContDiff ℝ 2 φ → φ s₀ = u s₀ → (∀ᶠ s in 𝓝 s₀, u s ≤ φ s) →
    deriv (deriv φ) s₀ ≤ (1 + deriv φ s₀ ^ 2) ^ ((3 : ℝ) / 2)

/-- **FS111-M-COVER-SC**, second clause, **corrected** (the row's "semiconcave with constant 1" is false at R7's cusped
down triangles; ruling `plans/FS131-close-inventory.md` items 18–19): where `∂F_a` is locally the graph of a continuous
`u` with `F_a` below it, `u` has curvature at most `1` in the viscosity sense. -/
theorem IsMaximalCover.curvatureLeOne {C : Fin k → Set ℂ} (hC : IsMaximalCover C) (a : Fin k) {z₀ : ℂ} {θ δ : ℝ}
    {J : Set ℝ} (hJ : IsOpen J) {u : ℝ → ℝ} (hu : ContinuousOn u J) (hgraph : IsLowerGraphOf (C a) z₀ θ J u δ) :
    CurvatureLeOne u J := by
  sorry

/-- Semiconcavity with constant `K` on `J`: `u(s + h) + u(s − h) − 2u(s) ≤ K h²` whenever `s ± h ∈ J`. -/
def SemiconcaveWith (K : ℝ) (u : ℝ → ℝ) (J : Set ℝ) : Prop :=
  ∀ s h, s ∈ J → s + h ∈ J → s - h ∈ J → u (s + h) + u (s - h) - 2 * u s ≤ K * h ^ 2

/-- **FS111-M-COVER-SC**, the named corollary (ruling items 18–19): on an interval where `u` is moreover `L`-Lipschitz, `u`
is semiconcave with constant `(1 + L²)^{3/2}`. -/
theorem IsMaximalCover.semiconcaveWith {C : Fin k → Set ℂ} (hC : IsMaximalCover C) (a : Fin k) {z₀ : ℂ} {θ δ : ℝ}
    {α β : ℝ} {u : ℝ → ℝ} (hu : ContinuousOn u (Ioo α β)) (hgraph : IsLowerGraphOf (C a) z₀ θ (Ioo α β) u δ)
    {L : NNReal} (hL : LipschitzOnWith L u (Ioo α β)) :
    SemiconcaveWith ((1 + (L : ℝ) ^ 2) ^ ((3 : ℝ) / 2)) u (Ioo α β) := by
  sorry

/-- **FS121-D3-GRUNDY**: every a.e.-proper `k`-colouring can be modified, keeping it a.e.-proper with `k` colours and never
raising a point's colour index, into a measurable Grundy colouring `(A_1, …, A_k)`: `A_1` is a MUA set (the case `m = 0`
below), each `A_m` contains `S_m` minus the earlier classes and is maximal among measurable sets with null unit pairs inside
their complement, every point of `supp A_m` is at distance exactly `1` from `supp A_i` for every `i < m`, and at every
essential boundary point every colour of `P(x)` other than the largest is bound (a contact) at `x`. -/
theorem AeColouring.exists_grundy (c : AeColouring k) :
    ∃ c' : AeColouring k, (∀ x, c'.col x ≤ c.col x) ∧
      (∀ m : Fin k, c.cls m \ (⋃ i < m, c'.cls i) ⊆ c'.cls m ∧ c'.cls m ⊆ (⋃ i < m, c'.cls i)ᶜ ∧
        ∀ B : Set ℂ, MeasurableSet B → UnitPairsNull B → B ⊆ (⋃ i < m, c'.cls i)ᶜ → c'.cls m ≤ᵐ[volume] B →
          B ≤ᵐ[volume] c'.cls m) ∧
      (∀ m i : Fin k, i < m → essSupport (c'.cls m) ⊆ unitShadow (essSupport (c'.cls i))) ∧
      (∀ x j, x ∈ essBoundary (c'.cls j) → ∀ j' ∈ essMulticolour c'.cls x, j < j' → IsContactFor (c'.cls j) x) := by
  sorry

end HadwigerNelson.Plane
