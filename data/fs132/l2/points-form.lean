import Proofs.HadwigerNelson.Plane.SixRing.Orbit
/-!
FS132-L2 — three terms for the reading aloud, checked and not argued (iteration file, never a library module; run by
`lake env lean` after the build):

1. the ring form over four POINTS (the row's wording, C132-WIT-EXCL) is the instance `K j = {p, q j}` of the library's
   `not_ae_outside` (C132-M-EXCL, over four compact sets);
2. the hypotheses on the labels have a model (`a = (0, 1, 2, 3)`, `X = 4`, `Y = 5`);
3. `FourCycleStraddle` is satisfied, as its docstring says in words, by the constant colouring `X` with any four
   two-point sets through `p` — a measurable colouring that is not weak.
-/
open MeasureTheory

namespace HadwigerNelson.SixRing

open Outside.OAI158

/-- C132-WIT-EXCL at the whole plane, from `not_ae_outside`. -/
theorem l2_not_ae_outside_points {c : ℂ → Fin 6} (hc : Measurable c) (hw : WeakColoring 6 c) {p : ℂ}
    {a : Fin 4 → Fin 6} (ha : Function.Injective a) {X Y : Fin 6} (hXY : X ≠ Y)
    (hX : ∀ j, a j ≠ X) (hY : ∀ j, a j ≠ Y) {q : Fin 4 → ℂ} (hq : ∀ j, q j ≠ p)
    (hl : ∀ j, Disjoint (spatialSupport c (a j)) (Straddle {p, q j}))
    (hr : ∀ j, Disjoint (spatialSupport c (a (j + 1))) (Straddle {p, q j})) :
    ¬ ∀ᵐ t ∂angularMeasure, X ∈ palette c hc p t ∨ Y ∈ palette c hc p t :=
  not_ae_outside hc hw ha hXY hX hY (K := fun j => {p, q j})
    ⟨fun _ => (Set.toFinite _).isCompact, fun _ => Set.mem_insert _ _,
     fun j => ⟨q j, Set.mem_insert_of_mem _ rfl, hq j⟩, hl, hr⟩

#print axioms l2_not_ae_outside_points

/-- The labels: four in a cycle and the two others. -/
theorem l2_labels_model : ∃ (a : Fin 4 → Fin 6) (X Y : Fin 6),
    Function.Injective a ∧ X ≠ Y ∧ (∀ j, a j ≠ X) ∧ (∀ j, a j ≠ Y) :=
  ⟨![0, 1, 2, 3], 4, 5, by decide, by decide, by decide, by decide⟩

/-- The four-set hypothesis, at the constant colouring `4` (the label `X` of the model above): every class of a cycle
label is empty, so its essential support is. -/
theorem l2_fourCycleStraddle_model (p : ℂ) :
    FourCycleStraddle (fun _ : ℂ => (4 : Fin 6)) p ![0, 1, 2, 3] (fun _ => {p, p + 1}) := by
  have hempty : ∀ i : Fin 6, i ≠ 4 → spatialSupport (fun _ : ℂ => (4 : Fin 6)) i = ∅ := by
    intro i hi
    have : {z : ℂ | (4 : Fin 6) = i} = ∅ := by
      ext z; simp [eq_comm, hi]
    simp [spatialSupport, this]
  refine ⟨fun _ => (Set.toFinite _).isCompact, fun _ => Set.mem_insert _ _,
    fun _ => ⟨p + 1, Set.mem_insert_of_mem _ rfl, by simp⟩, fun j => ?_, fun j => ?_⟩
  · rw [hempty _ (by fin_cases j <;> decide)]; exact Set.empty_disjoint _
  · rw [hempty _ (by fin_cases j <;> decide)]; exact Set.empty_disjoint _

#print axioms l2_fourCycleStraddle_model

end HadwigerNelson.SixRing
