import Proofs.HadwigerNelson.ResidueColouring
import Proofs.HadwigerNelson.FieldWall4
import Mathlib.NumberTheory.Zsqrtd.GaussianInt
import Mathlib.LinearAlgebra.Dual.Lemmas
import Mathlib.Combinatorics.SimpleGraph.CycleGraph
import Mathlib.Algebra.CharP.Reduced
import Mathlib.Algebra.Field.ZMod
import Mathlib.Algebra.Algebra.ZMod

/-!
# Two colours from a residue that conjugation does not move

FS-36 (`plans/FS36-multiquadratic-decomposition.md`): Theorem A's two-colour case, in Theorem A's three forms (ring,
valuation subring, plane), with the colouring exposed as data.

## Three hypotheses on how conjugation `σ` meets a residue map `ψ`, each buying more

* **None** — Theorem A (`ResidueColouring.lean`): as many colours as the residue ring has elements.
* **`ψ (σ z) = 0 → ψ z = 0`** — the prime is fixed by conjugation: the valuation law (`ResidueColouring.lean` §4).
* **`ψ (σ z) = ψ z`** — conjugation lies in the **inertia group** of the prime. Then a unit vector `u` has
  `ψ u · ψ u = ψ u · ψ (σ u) = 1` (`map_mul_self_eq_one_of_mem_normOne_of_conj_eq`); in a reduced ring of
  characteristic two that root of `1` is `1` itself (`map_eq_one_of_mem_normOne_of_conj_eq`). An additive
  functional `k →+ ZMod 2` that does not vanish at `1` is then nonzero on every unit step, and colouring by it is
  proper (`normOneColoringTwo`): **two colours**.

The functional is additive and not multiplicative, and that is the content. Over `ℚ(√5)` the residue field at 2 is
`𝔽₄`, which has no ring homomorphism to `𝔽₂`, so Theorem A with `G = ZMod 2` cannot reach it.

The hypothesis covers Woodall's `ℚ²`, the "if" half of `[Fischer1990]` Theorem 8, `[Moorhouse2010]` Theorem 7.1
(odd-degree fields, through the trace) and `[Madore2015]` Proposition 3.9 (`ℚ(√2)²`).

## What is not proved here

That a real multiquadratic field whose square classes avoid `[−1]` and `[3]` 2-adically supplies such a valuation
subring — the gap of `plans/A1-theorem-A-kernel.md` §R2, stubbed as FS-37. The plane form below is Theorem A's
two-colour case; its field-level reading is a hand theorem (`plans/FIELD-WALL-THEOREM.md` §10.2).

## Using this file

* **To bound a chromatic number:** `colorable_two_unitDistance_induce_of_valuationSubring` (a subfield of `ℂ`),
  `colorable_two_of_valuationSubring_of_conj_eq` (any field), or `colorable_two_of_normOne_of_conj_eq` (a subring,
  with integrality supplied by hand).
* **To evaluate the colouring** — which pairs share a colour — use `normOneColoringTwo` with a chosen functional
  `l`. Its `@[simp]` lemma `normOneColoringTwo_apply` reads a colour as `l` of a coset residue.
* **At `k = ZMod 2`**, this module's imports supply `IsReduced` and `CharP`.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ## §1 Characteristic two -/

/-- In a reduced ring of characteristic two, `1` is the only square root of `1`. -/
private theorem eq_one_of_mul_self_eq_one_of_charTwo {k : Type*} [CommRing k] [IsReduced k] [CharP k 2]
    {x : k} (h : x * x = 1) : x = 1 :=
  frobenius_inj k 2 (by rw [frobenius_def, frobenius_def, one_pow, sq, h])

/-- **A ring of characteristic two has an additive functional to `ZMod 2` that does not vanish at `1`** — by
extending `1` to a basis over `ZMod 2`, so it uses choice. -/
theorem exists_addMonoidHom_zmod_two_apply_one_ne_zero (k : Type*) [Ring k] [CharP k 2] :
    ∃ l : k →+ ZMod 2, l 1 ≠ 0 := by
  letI := ZMod.algebra k 2
  haveI : Nontrivial k := CharP.nontrivial_of_char_ne_one (v := 2) (by norm_num)
  obtain ⟨φ, hφ⟩ := not_forall.mp
    (mt (Module.forall_dual_apply_eq_zero_iff (ZMod 2) (1 : k)).mp one_ne_zero)
  exact ⟨φ.toAddMonoidHom, hφ⟩

/-! ## §2 Unit vectors under a conjugation-trivial residue, and the ring form -/

section NormOne

variable {L : Type*} [CommRing L] {A : Subring L} {σ : L →+* L}

/-- **A conjugation-trivial residue sends every norm-one element to a square root of `1`.** No hypothesis on the
residue ring. -/
theorem map_mul_self_eq_one_of_mem_normOne_of_conj_eq {k : Type*} [CommRing k]
    (hσ : ∀ z ∈ A, σ z ∈ A) (ψ : A →+* k) (hψσ : ∀ z : A, ψ (σ.restrict A A hσ z) = ψ z)
    {u : L} (hu : u ∈ A) (h : u ∈ normOne σ) : ψ ⟨u, hu⟩ * ψ ⟨u, hu⟩ = 1 :=
  calc ψ ⟨u, hu⟩ * ψ ⟨u, hu⟩ = ψ ⟨u, hu⟩ * ψ (σ.restrict A A hσ ⟨u, hu⟩) := by rw [hψσ]
    _ = ψ (⟨u, hu⟩ * σ.restrict A A hσ ⟨u, hu⟩) := (map_mul ψ _ _).symm
    _ = ψ 1 := congrArg ψ (Subtype.ext h)
    _ = 1 := map_one ψ

/-- **In a reduced ring of characteristic two, to `1` itself.** -/
theorem map_eq_one_of_mem_normOne_of_conj_eq {k : Type*} [CommRing k] [IsReduced k] [CharP k 2]
    (hσ : ∀ z ∈ A, σ z ∈ A) (ψ : A →+* k) (hψσ : ∀ z : A, ψ (σ.restrict A A hσ z) = ψ z)
    {u : L} (hu : u ∈ A) (h : u ∈ normOne σ) : ψ ⟨u, hu⟩ = 1 :=
  eq_one_of_mul_self_eq_one_of_charTwo (map_mul_self_eq_one_of_mem_normOne_of_conj_eq hσ ψ hψσ hu h)

/-- **The two-colouring, as data**: colour a point by `l` of its coset residue. It is proper when conjugation fixes
every residue and `l` does not vanish at `1`. Use it when you must evaluate the colouring; for the bound alone,
`colorable_two_of_normOne_of_conj_eq` chooses `l` for you. -/
noncomputable def normOneColoringTwo {k : Type*} [CommRing k] [IsReduced k] [CharP k 2]
    (hσ : ∀ z ∈ A, σ z ∈ A) (ψ : A →+* k) (hψσ : ∀ z : A, ψ (σ.restrict A A hσ z) = ψ z)
    (l : k →+ ZMod 2) (hl : l 1 ≠ 0) {V : Type*} (Γ : SimpleGraph V) (f : V → L)
    (hmem : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ A)
    (hnorm : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ normOne σ) : Γ.Coloring (ZMod 2) :=
  SimpleGraph.Coloring.mk
    (fun v => cosetResidue (A := A.toAddSubgroup) (l.comp ψ.toAddMonoidHom) (f v))
    (fun {v w} hvw hc => by
      have h0 := (cosetResidue_eq_iff (A := A.toAddSubgroup) (l.comp ψ.toAddMonoidHom) (hmem hvw)).mp hc
      rw [cosetResidue_apply_of_mem _ (hmem hvw)] at h0
      change l (ψ ⟨f v - f w, hmem hvw⟩) = 0 at h0
      rw [map_eq_one_of_mem_normOne_of_conj_eq hσ ψ hψσ (hmem hvw) (hnorm hvw)] at h0
      exact hl h0)

/-- A point's colour under `normOneColoringTwo` is `l` of its coset residue. -/
@[simp] theorem normOneColoringTwo_apply {k : Type*} [CommRing k] [IsReduced k] [CharP k 2]
    (hσ : ∀ z ∈ A, σ z ∈ A) (ψ : A →+* k) (hψσ : ∀ z : A, ψ (σ.restrict A A hσ z) = ψ z)
    (l : k →+ ZMod 2) (hl : l 1 ≠ 0) {V : Type*} (Γ : SimpleGraph V) (f : V → L)
    (hmem : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ A)
    (hnorm : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ normOne σ) (v : V) :
    normOneColoringTwo hσ ψ hψσ l hl Γ f hmem hnorm v
      = cosetResidue (A := A.toAddSubgroup) (l.comp ψ.toAddMonoidHom) (f v) := rfl

/-- **Two colours, over a ring.** -/
theorem colorable_two_of_normOne_of_conj_eq {k : Type*} [CommRing k] [IsReduced k] [CharP k 2]
    (hσ : ∀ z ∈ A, σ z ∈ A) (ψ : A →+* k) (hψσ : ∀ z : A, ψ (σ.restrict A A hσ z) = ψ z)
    {V : Type*} (Γ : SimpleGraph V) (f : V → L)
    (hmem : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ A)
    (hnorm : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ normOne σ) :
    Γ.Colorable 2 := by
  obtain ⟨l, hl⟩ := exists_addMonoidHom_zmod_two_apply_one_ne_zero k
  simpa using (normOneColoringTwo hσ ψ hψσ l hl Γ f hmem hnorm).colorable

end NormOne

/-! ## §3 The valuation form and the plane -/

/-- **Two colours, valuation form**: integrality is free. -/
theorem colorable_two_of_valuationSubring_of_conj_eq {L : Type*} [Field L] (A : ValuationSubring L)
    {σ : L →+* L} (hσ : ∀ z ∈ A, σ z ∈ A) (hσσ : ∀ z : L, σ (σ z) = z)
    {k : Type*} [CommRing k] [IsReduced k] [CharP k 2] (ψ : A.toSubring →+* k)
    (hψσ : ∀ z : A.toSubring, ψ (σ.restrict A.toSubring A.toSubring hσ z) = ψ z)
    {V : Type*} (Γ : SimpleGraph V) (f : V → L)
    (hnorm : ∀ ⦃v w⦄, Γ.Adj v w → f v - f w ∈ normOne σ) :
    Γ.Colorable 2 :=
  colorable_two_of_normOne_of_conj_eq (A := A.toSubring) hσ ψ hψσ Γ f
    (fun _ _ hvw => normOne_subset_valuationSubring A hσ hσσ (hnorm hvw)) hnorm

/-- **Theorem A, two-colour case, in the write-up's shape**: a conjugation-stable subfield of `ℂ`, a
conjugation-stable valuation subring of it, and a residue map into a reduced ring of characteristic two that
conjugation does not move. Every unit-distance graph drawn in the subfield is 2-colourable. **Not proved here:**
that a real multiquadratic field passing the two-colour test supplies such a subring (FS-37). -/
theorem colorable_two_unitDistance_induce_of_valuationSubring {L : Subfield ℂ}
    (hL : ∀ z ∈ L, (starRingEnd ℂ) z ∈ L) (A : ValuationSubring L) (hσ : ∀ z ∈ A, conjOn hL z ∈ A)
    {k : Type*} [CommRing k] [IsReduced k] [CharP k 2] (ψ : A.toSubring →+* k)
    (hψσ : ∀ z : A.toSubring, ψ ((conjOn hL).restrict A.toSubring A.toSubring hσ z) = ψ z)
    {S : Set ℂ} (hS : S ⊆ (L : Set ℂ)) :
    ((unitDistance ℂ).induce S).Colorable 2 := by
  refine colorable_two_of_valuationSubring_of_conj_eq A hσ (conjOn_conjOn hL) ψ hψσ _
    (fun v : S => (⟨(v : ℂ), hS v.2⟩ : L)) fun v w hvw => ?_
  have hd : dist (v : ℂ) (w : ℂ) = 1 := hvw
  have hone : (v : ℂ) - (w : ℂ) ∈ normOne (starRingEnd ℂ) := sub_mem_normOne_conj_iff.mpr hd
  show _ * conjOn hL _ = 1
  refine Subtype.ext ?_
  simpa [mem_normOne, map_sub] using hone

/-! ## §4 Spec — a model with a nontrivial conjugation, and the two reds

The valuation and plane forms take a `ValuationSubring` binder. Their genuine inhabitant is Woodall's `ℚ(i)` at
`1 + i`, which only FS-37's machinery could construct. Over `L = ℂ` their hypotheses cannot be met, since the plane
contains triangles. The ring form carries the kernel model below. -/

section Spec

/-- The residue map of the Gaussian integers at `1 + i`: `a + bi ↦ a + b (mod 2)`. -/
def gaussResidue : GaussianInt →+* ZMod 2 := Zsqrtd.lift ⟨1, by decide⟩

/-- The 4-cycle `0 → 1 → 1 + i → i → 0`, drawn in the Gaussian integers. -/
def gaussSquare : Fin 4 → GaussianInt := ![0, 1, ⟨1, 1⟩, ⟨0, 1⟩]

/-- **The model of the ring form's hypotheses**, as a named inhabitant: `ℤ[i]` with its conjugation (nontrivial)
and the residue mod `1 + i` (which conjugation does not move) instantiate the theorem on the square drawn there. -/
theorem colorable_two_cycleGraph_four_of_gaussResidue : (SimpleGraph.cycleGraph 4).Colorable 2 :=
  colorable_two_of_normOne_of_conj_eq (A := (⊤ : Subring GaussianInt)) (σ := starRingEnd GaussianInt)
    (fun _ _ => Subring.mem_top _) (gaussResidue.comp (⊤ : Subring GaussianInt).subtype)
    (fun z => by
      obtain ⟨⟨a, b⟩, _⟩ := z
      show gaussResidue (star (⟨a, b⟩ : GaussianInt)) = gaussResidue ⟨a, b⟩
      simp [gaussResidue, Zsqrtd.lift, Zsqrtd.star_mk])
    _ gaussSquare (fun _ _ _ => Subring.mem_top _)
    (by intro v w; simp only [mem_normOne]; revert v w; decide)

/-- **Red: `hψσ` is load-bearing.** In `𝔽₄` with Frobenius as the conjugation, `Ω` has norm one and is not `1` —
Theorem B's residue field, where conjugation induces Frobenius and four colours are needed. -/
example : ∃ u : FieldWall4.F4, u * FieldWall4.F4.sq u = 1 ∧ u ≠ 1 := ⟨FieldWall4.F4.om, by decide, by decide⟩

/-- **Red: characteristic two is load-bearing.** In `ZMod 3`, `2 · 2 = 1` and `2 ≠ 1`. -/
example : ∃ u : ZMod 3, u * u = 1 ∧ u ≠ 1 := ⟨2, by decide, by decide⟩

end Spec

end HadwigerNelson
