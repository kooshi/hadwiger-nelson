import Proofs.HadwigerNelson.Additive
import Proofs.HadwigerNelson.UnitQuadrance
import Mathlib.RingTheory.Valuation.ValuationSubring

/-!
# The residue colouring, in general — Theorem A

**Skeleton.** Statements only; every leaf is `sorry`.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ## §1 Coset representatives and the residue map -/

section Residue

variable {M G : Type*} [AddCommGroup M] [AddCommGroup G] {A : AddSubgroup M}

private theorem mk_surjective (A : AddSubgroup M) :
    Function.Surjective ⇑(QuotientAddGroup.mk' A) := sorry

/-- A chosen representative of each coset of `A`. -/
noncomputable def cosetRep (A : AddSubgroup M) (x : M) : M :=
  Function.surjInv (mk_surjective A) (QuotientAddGroup.mk' A x)

theorem sub_cosetRep_mem (A : AddSubgroup M) (x : M) : x - cosetRep A x ∈ A := sorry

theorem cosetRep_eq_of_sub_mem {x y : M} (h : x - y ∈ A) : cosetRep A x = cosetRep A y := sorry

/-- The residue map. -/
noncomputable def residue (ψ : A →+ G) (x : M) : G :=
  ψ ⟨x - cosetRep A x, sub_cosetRep_mem A x⟩

theorem residue_sub (ψ : A →+ G) {x y : M} (h : x - y ∈ A) :
    residue ψ x - residue ψ y = ψ ⟨x - y, h⟩ := sorry

theorem residue_ne (ψ : A →+ G) {x y : M} (h : x - y ∈ A) (hne : ψ ⟨x - y, h⟩ ≠ 0) :
    residue ψ x ≠ residue ψ y := sorry

end Residue

/-! ## §2 The colouring -/

section Colouring

variable {V M G : Type*} [AddCommGroup M] [AddCommGroup G] {A : AddSubgroup M}

theorem colorable_of_residue [Fintype G] (Γ : SimpleGraph V) (f : V → M) (ψ : A →+ G)
    (h : ∀ ⦃v w⦄, Γ.Adj v w → ∃ a : A, (a : M) = f v - f w ∧ ψ a ≠ 0) :
    Γ.Colorable (Fintype.card G) := sorry

/-- `additiveColoring` is the case `A = ⊤`. -/
theorem colorable_of_additive [Fintype G] {Γ : SimpleGraph M} (φ : M →+ G)
    (h : ∀ a b, Γ.Adj a b → φ (a - b) ≠ 0) : Γ.Colorable (Fintype.card G) := sorry

end Colouring

/-! ## §3 Norm one -/

section NormOne

variable {L : Type*} [CommRing L]

/-- The norm-one set of `σ`. -/
def normOne (σ : L →+* L) : Set L := {u | u * σ u = 1}

theorem mem_normOne {σ : L →+* L} {u : L} : u ∈ normOne σ ↔ u * σ u = 1 := Iff.rfl

theorem isUnit_of_mem_normOne {A : Subring L} {σ : L →+* L} (hσ : ∀ z ∈ A, σ z ∈ A) {u : L}
    (hu : u ∈ A) (h : u ∈ normOne σ) : IsUnit (⟨u, hu⟩ : A) := sorry

theorem apply_ne_zero_of_mem_normOne {A : Subring L} {σ : L →+* L} (hσ : ∀ z ∈ A, σ z ∈ A)
    {G : Type*} [CommRing G] [Nontrivial G] (ψ : A →+* G) {u : L} (hu : u ∈ A)
    (h : u ∈ normOne σ) : ψ ⟨u, hu⟩ ≠ 0 := sorry

/-- A σ-stable subring in which every factorization of `1` has a factor is integrally closed for
norm-one elements. -/
theorem mem_of_mem_normOne {A : Subring L} {σ : L →+* L}
    (hA : ∀ z w : L, z * w = 1 → z ∈ A ∨ w ∈ A) (hσ : ∀ z ∈ A, σ z ∈ A)
    (hσσ : ∀ z : L, σ (σ z) = z) {u : L} (h : u ∈ normOne σ) : u ∈ A := sorry

variable {V : Type*}

/-- **The general residue colouring.** -/
theorem colorable_of_normOne {A : Subring L} {σ : L →+* L} (hσ : ∀ z ∈ A, σ z ∈ A)
    {G : Type*} [CommRing G] [Nontrivial G] [Fintype G] (ψ : A →+* G)
    (Γ : SimpleGraph V) (f : V → L)
    (hmem : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ A)
    (hnorm : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ normOne σ) :
    Γ.Colorable (Fintype.card G) := sorry

end NormOne

section Valuation

variable {L : Type*} [Field L] {V : Type*}

theorem ValuationSubring.mem_of_mem_normOne (A : ValuationSubring L) {σ : L →+* L}
    (hσ : ∀ z ∈ A, σ z ∈ A) (hσσ : ∀ z : L, σ (σ z) = z) {u : L} (h : u ∈ normOne σ) : u ∈ A :=
  sorry

/-- **Theorem A, valuation form.** -/
theorem colorable_of_valuationSubring (A : ValuationSubring L) {σ : L →+* L}
    (hσ : ∀ z ∈ A, σ z ∈ A) (hσσ : ∀ z : L, σ (σ z) = z)
    {G : Type*} [CommRing G] [Nontrivial G] [Fintype G] (ψ : A →+* G)
    (Γ : SimpleGraph V) (f : V → L)
    (hnorm : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ normOne σ) :
    Γ.Colorable (Fintype.card G) := sorry

end Valuation

/-! ## §4 The plane -/

section Plane

open Complex

variable {V : Type*}

theorem sub_mem_normOne_conj_iff {z w : ℂ} :
    z - w ∈ normOne (starRingEnd ℂ) ↔ dist z w = 1 := sorry

/-- **Theorem A in the plane, for a drawing.** -/
theorem colorable_unitDistance_of_residue {A : Subring ℂ}
    (hσ : ∀ z ∈ A, (starRingEnd ℂ) z ∈ A)
    {G : Type*} [CommRing G] [Nontrivial G] [Fintype G] (ψ : A →+* G)
    {Γ : SimpleGraph V} (f : V → ℂ) (hf : ∀ ⦃v w⦄, Γ.Adj v w → dist (f v) (f w) = 1)
    (hmem : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ A) :
    Γ.Colorable (Fintype.card G) := sorry

/-- **Theorem A in the plane, for a set of points.** -/
theorem colorable_unitDistance_induce_of_residue {A : Subring ℂ}
    (hσ : ∀ z ∈ A, (starRingEnd ℂ) z ∈ A)
    {G : Type*} [CommRing G] [Nontrivial G] [Fintype G] (ψ : A →+* G) {S : Set ℂ}
    (hS : ∀ z ∈ S, ∀ w ∈ S, dist z w = 1 → z - w ∈ A) :
    ((unitDistance ℂ).induce S).Colorable (Fintype.card G) := sorry

end Plane

/-! ## §5 The unit-quadrance graph -/

section Quadrance

variable {R G : Type*} [CommRing R] [AddCommGroup G]

theorem colorable_unitQuadrance_of_residue [Fintype G] {A : AddSubgroup (R × R)} (ψ : A →+ G)
    (h : ∀ v : R × R, v.1 ^ 2 + v.2 ^ 2 = 1 → ∃ a : A, (a : R × R) = v ∧ ψ a ≠ 0) :
    (unitQuadrance R).Colorable (Fintype.card G) := sorry

end Quadrance

/-! ## §6 Spec -/

section Spec

/-- The graph on `ℤ` joining integers two apart. -/
def twoStep : SimpleGraph ℤ := SimpleGraph.fromRel fun a b => a - b = 2

/-- `2ℤ`, as a subgroup. -/
def twoZ : AddSubgroup ℤ := AddSubgroup.zmultiples 2

/-- Halving, on `2ℤ`. -/
noncomputable def halfMod : twoZ →+ ZMod 2 := sorry

example : twoStep.Colorable 2 := sorry

/-- The planted red: the residue hypothesis is load-bearing. -/
example : ¬ (⊤ : SimpleGraph (Fin 3)).Colorable 2 := sorry

end Spec

end HadwigerNelson
