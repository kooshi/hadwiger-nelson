import Proofs.HadwigerNelson.Plane.OneClass.Field
import Proofs.HadwigerNelson.Plane.OneClass.InvariantLaw
import Proofs.HadwigerNelson.Plane.LebesgueNumber

/-!
# Labellings with forbidden label pairs at algebraic distances: the plane, the algebraic plane, and measurable ones (FS-133)

The derivation's entry C133-PAIR (`plans/FS133-E1-derivation.md`, stage 6). A *pattern* `N` says, for each distance
`r`, which ordered pairs of labels are forbidden at two points `r` apart (`N r a b`); it is the entry's family of
sets `N_r`, with `N r` empty off the countable set `R`. Symmetry of `N r` is not asked: `AdmissibleOn` reads both
orders of every pair of points.

* `AdmissibleOn N X ℓ` — no two points of `X` carry a forbidden pair;
* `AdmissibleAe N ℓ` — for each `r`, almost no `(x, u)` in `ℂ × S¹` has a forbidden pair at `x`, `x + r u`;
* `IsAlgPattern N` — countably many distances carry a forbidden pair, each positive and algebraic;
* `exists_measurable_admissibleAe` — forward: from the algebraic plane to a Borel labelling admissible almost
  everywhere (rests on the declared outside theorem `Spectral.residual_fourier`);
* `exists_admissibleOn_of_ae` — converse: from a Lebesgue-measurable labelling admissible almost everywhere to one
  admissible at every pair (density points and compactness; no outside theorem);
* `exists_admissibleOn_univ_iff_ae`, `exists_admissibleOn_univ_iff_algPlane` — **C133-PAIR**.

Not claimed (the entry's line): any constraint on three or more points; any distance that is not algebraic;
infinitely many labels; a measurable labelling admissible at every pair.
-/

open MeasureTheory Filter Set
open scoped ENNReal Topology

namespace HadwigerNelson.OneClass

open HadwigerNelson.Plane HadwigerNelson.Outside.OAI158 HadwigerNelson.Outside.OAI158.Spectral

variable {Λ : Type*}

/-- A labelling is admissible on `X` for the pattern `N`: no two points of `X` at a distance `r` carry a pair of
labels that `N r` forbids. -/
def AdmissibleOn (N : ℝ → Λ → Λ → Prop) (X : Set ℂ) (ℓ : ℂ → Λ) : Prop :=
  ∀ x ∈ X, ∀ y ∈ X, ¬ N (dist x y) (ℓ x) (ℓ y)

/-- A labelling is admissible almost everywhere: for each distance `r`, almost no `(x, θ)` has a forbidden pair at
`x` and `x + r e^{iθ}` (Lebesgue measure on the plane, arc length on the circle). -/
def AdmissibleAe (N : ℝ → Λ → Λ → Prop) (ℓ : ℂ → Λ) : Prop :=
  ∀ r : ℝ, ∀ᵐ p ∂(volume : Measure ℂ).prod arcLength, ¬ N r (ℓ p.1) (ℓ (p.1 + r * e p.2))

/-- The entry's hypotheses on a pattern: countably many distances carry a forbidden pair, and each of them is a
positive real algebraic number. -/
structure IsAlgPattern (N : ℝ → Λ → Λ → Prop) : Prop where
  /-- countably many constrained distances -/
  countable : {r | ∃ a b, N r a b}.Countable
  /-- each positive -/
  pos : ∀ r a b, N r a b → 0 < r
  /-- each algebraic -/
  alg : ∀ r a b, N r a b → IsAlgebraic ℚ r

/-- The pattern of proper colourings: equal labels are forbidden at distance one. -/
def colourPattern (Λ : Type*) : ℝ → Λ → Λ → Prop := fun r a b => r = 1 ∧ a = b

/-- Drift check: admissible for the colouring pattern is proper. -/
theorem admissibleOn_colourPattern_iff {X : Set ℂ} {ℓ : ℂ → Λ} :
    AdmissibleOn (colourPattern Λ) X ℓ ↔ ∀ x ∈ X, ∀ y ∈ X, dist x y = 1 → ℓ x ≠ ℓ y := by
  sorry

/-- A model of `IsAlgPattern`: the colouring pattern. -/
theorem isAlgPattern_colourPattern (Λ : Type*) : IsAlgPattern (colourPattern Λ) := by
  sorry

/-- A model of all three notions at once: the plane has a Borel seven-labelling admissible for the colouring
pattern at every pair, hence on the algebraic plane and almost everywhere. -/
theorem exists_admissible_colourPattern_seven :
    ∃ ℓ : ℂ → Fin 7, Measurable ℓ ∧ AdmissibleOn (colourPattern (Fin 7)) univ ℓ ∧
      AdmissibleAe (colourPattern (Fin 7)) ℓ := by
  sorry

/-- Admissibility passes to a subset. -/
theorem AdmissibleOn.mono {N : ℝ → Λ → Λ → Prop} {X Y : Set ℂ} {ℓ : ℂ → Λ} (h : AdmissibleOn N Y ℓ)
    (hXY : X ⊆ Y) : AdmissibleOn N X ℓ :=
  fun x hx y hy => h x (hXY hx) y (hXY hy)

/-- **C133-PAIR, forward** (steps F1–F6): a labelling admissible on the algebraic plane gives a labelling of the
plane with Borel fibres that is admissible almost everywhere. Rests on the declared outside theorem
`Spectral.residual_fourier`. -/
theorem exists_measurable_admissibleAe [Finite Λ] {N : ℝ → Λ → Λ → Prop} (hN : IsAlgPattern N) {ℓ : ℂ → Λ}
    (h : AdmissibleOn N (E : Set ℂ) ℓ) :
    ∃ ℓ' : ℂ → Λ, (∀ a, MeasurableSet (ℓ' ⁻¹' {a})) ∧ AdmissibleAe N ℓ' := by
  sorry

/-- **C133-PAIR, converse** (step (B)): a labelling with Lebesgue-measurable fibres that is admissible almost
everywhere gives a labelling admissible at every pair of points of the plane. The distances need not be
algebraic. -/
theorem exists_admissibleOn_of_ae [Finite Λ] {N : ℝ → Λ → Λ → Prop} (hcount : {r | ∃ a b, N r a b}.Countable)
    (hpos : ∀ r a b, N r a b → 0 < r) {ℓ' : ℂ → Λ} (hm : ∀ a, NullMeasurableSet (ℓ' ⁻¹' {a}) volume)
    (h : AdmissibleAe N ℓ') : ∃ ℓ : ℂ → Λ, AdmissibleOn N univ ℓ := by
  sorry

/-- **C133-PAIR, first clause**: an admissible labelling of the plane exists if and only if a Lebesgue-measurable
labelling admissible almost everywhere exists. The direction from left to right rests on the declared outside
theorem `Spectral.residual_fourier`. -/
theorem exists_admissibleOn_univ_iff_ae [Finite Λ] {N : ℝ → Λ → Λ → Prop} (hN : IsAlgPattern N) :
    (∃ ℓ : ℂ → Λ, AdmissibleOn N univ ℓ) ↔
      ∃ ℓ : ℂ → Λ, (∀ a, NullMeasurableSet (ℓ ⁻¹' {a}) volume) ∧ AdmissibleAe N ℓ := by
  constructor
  · rintro ⟨ℓ, hℓ⟩
    obtain ⟨ℓ', hm, hae⟩ := exists_measurable_admissibleAe hN (hℓ.mono (subset_univ _))
    exact ⟨ℓ', fun a => (hm a).nullMeasurableSet, hae⟩
  · rintro ⟨ℓ, hm, hae⟩
    exact exists_admissibleOn_of_ae hN.countable hN.pos hm hae

/-- **C133-PAIR, second clause**: an admissible labelling of the plane exists if and only if one of the algebraic
plane exists. The direction from right to left rests on the declared outside theorem
`Spectral.residual_fourier`. -/
theorem exists_admissibleOn_univ_iff_algPlane [Finite Λ] {N : ℝ → Λ → Λ → Prop} (hN : IsAlgPattern N) :
    (∃ ℓ : ℂ → Λ, AdmissibleOn N univ ℓ) ↔ ∃ ℓ : ℂ → Λ, AdmissibleOn N (E : Set ℂ) ℓ := by
  constructor
  · rintro ⟨ℓ, hℓ⟩
    exact ⟨ℓ, hℓ.mono (subset_univ _)⟩
  · rintro ⟨ℓ, hℓ⟩
    obtain ⟨ℓ', hm, hae⟩ := exists_measurable_admissibleAe hN hℓ
    exact exists_admissibleOn_of_ae hN.countable hN.pos (fun a => (hm a).nullMeasurableSet) hae

end HadwigerNelson.OneClass
