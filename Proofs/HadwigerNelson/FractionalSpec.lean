import Proofs.HadwigerNelson.Fractional

/-!
# The fractional chromatic number, validated on the graph that discriminates it

A definition that had quietly become the *ordinary* chromatic number would satisfy every theorem in
`Fractional.lean` — they are all inequalities, and `χ` satisfies them too. What separates the two is
a graph whose fractional chromatic number is **not an integer**, and the smallest one is the
5-cycle: `χ_f(C₅) = 5/2`, against `χ(C₅) = 3`.

Both directions are proved here, because only the pair is discriminating:

* `≥ 5/2` — five vertices, no independent set larger than two.
* `≤ 5/2` — the explicit 2-fold 5-colouring `i ↦ {i, i+2}`, which also exhibits a model of
  `FractionalColorable` and so shows nothing above is vacuous.

This module is downstream of everything and imported by nothing, so it may be rewritten freely.
-/

namespace HadwigerNelson.FractionalSpec

open SimpleGraph Finset
open scoped ENNReal

/-- The 5-cycle. -/
def C5 : SimpleGraph (Fin 5) where
  Adj i j := i ≠ j ∧ (j = i + 1 ∨ i = j + 1)
  symm := ⟨fun _ _ h => ⟨h.1.symm, h.2.symm⟩⟩
  loopless := ⟨fun _ h => h.1 rfl⟩

instance : DecidableRel C5.Adj := fun i j => inferInstanceAs (Decidable (i ≠ j ∧ _))

-- Ten adjacent pairs counted with direction — the cycle, not something else.
#guard ((List.finRange 5).flatMap fun i => (List.finRange 5).filter (C5.Adj i ·)).length == 10

/-- **No independent set of the 5-cycle has three vertices.** Checked over all 32 subsets. -/
theorem C5_indep_le_two : ∀ I : Finset (Fin 5), C5.IsIndepSet (I : Set (Fin 5)) → I.card ≤ 2 := by
  decide

/-- The negative control on the line above: the bound `2` is **attained**, so a certificate stated
at `1` would be false. Without this, `C5_indep_le_two` could be a fact about a bound too slack to
say anything. -/
theorem C5_indep_not_le_one :
    ¬ ∀ I : Finset (Fin 5), C5.IsIndepSet (I : Set (Fin 5)) → I.card ≤ 1 := by decide

/-- **`χ_f(C₅) ≥ 5/2`.** -/
theorem le_C5_fractional : ((5 : ℕ) : ℝ≥0∞) / ((2 : ℕ) : ℝ≥0∞) ≤ C5.fractionalChromaticNumber := by
  simpa using le_fractionalChromaticNumber_of_indepNum (a := 2) (by norm_num) C5_indep_le_two

/-- **`χ_f(C₅) ≤ 5/2`**, by the 2-fold 5-colouring `i ↦ {i, i+2}`. This is also the concrete model
of `FractionalColorable`: without it every lower bound above would be about an empty domain. -/
theorem C5_fractional_le : C5.fractionalChromaticNumber ≤ ((5 : ℕ) : ℝ≥0∞) / ((2 : ℕ) : ℝ≥0∞) :=
  FractionalColorable.fractionalChromaticNumber_le (by norm_num)
    ⟨fun i => {i, i + 2}, by decide, by decide⟩

/-- **`χ_f(C₅) = 5/2`** — a value that is not an integer, which is what tells this invariant apart
from the ordinary chromatic number. -/
theorem C5_fractional : C5.fractionalChromaticNumber = ((5 : ℕ) : ℝ≥0∞) / ((2 : ℕ) : ℝ≥0∞) :=
  le_antisymm C5_fractional_le le_C5_fractional

/-- And the 5-cycle really does need three colours, so `χ_f < χ` here. -/
theorem C5_not_colorable_two : ¬ C5.Colorable 2 :=
  not_colorable_of_lt_fractionalChromaticNumber (by
    rw [C5_fractional]
    rw [ENNReal.lt_div_iff_mul_lt (Or.inl (by norm_num)) (Or.inl (by norm_num))]
    norm_num)

end HadwigerNelson.FractionalSpec
