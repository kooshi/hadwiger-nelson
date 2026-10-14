#!/usr/bin/env python3
"""FS133-K1 stage 6: the edits the three modeling passes asked for, applied once after the first build.
Renames (two names that misread), one reading lemma for `mOne`, two statements for lane D's step F1, docstrings."""
import pathlib
R = pathlib.Path(__file__).resolve().parents[3] / "Proofs/HadwigerNelson/Plane/OneClass"
def sub(name, pairs):
    p = R / name; t = p.read_text()
    for a, b in pairs:
        assert a in t, (name, a[:60])
        t = t.replace(a, b)
    p.write_text(t)
if "sectionDensity_pos_set" in (R / "SectionDensity.lean").read_text():
    sub("SectionDensity.lean", [("sectionDensity_pos_set", "sectionDensity_setOf_pos")])
if "mOne_le_iff" not in (R / "Defs.lean").read_text(): sub("Defs.lean", [
 ("/-- `m₁ ≤ 1`. -/", """/-- **What an upper bound on `m₁` means**: a bound on the upper density of every Borel set with no two points at
distance one. With `upperDensity_le_mOne`, the whole reasoning surface of `mOne`. -/
theorem mOne_le_iff {r : ℝ≥0∞} :
    mOne ≤ r ↔ ∀ A : Set ℂ, MeasurableSet A → (unitDistance ℂ).IsIndepSet A → upperDensity A ≤ r := by
  simp only [mOne, iSup_le_iff]

/-- `m₁ ≤ 1`. -/"""),
 ("/-- A translation-invariant random independent set of a graph `G` on the algebraic plane: a probability on\n`E → Bool` carried by the indicators of independent sets and invariant under every translation. -/",
  "/-- A translation-invariant random independent set of a graph `G` on the algebraic plane: a probability on\n`E → Bool` carried by the indicators of independent sets and invariant under every translation. Its *density* is\n`P {I | I 0 = true}`. A consumer opens with `haveI := h.prob`. -/"),
])
sub("InvariantLaw.lean", [
 ("IsShiftInvariantLaw.measure_zero_le", "IsShiftInvariantLaw.measure_origin_le"),
 ("open scoped Classical in\n/-- **A Følner sequence**", """/-- The algebraic plane is countable (the release's `E_countable`; a theorem, not an instance: `E` is Mathlib's
type). -/
theorem countable_algPlane : Countable E := by
  sorry

open scoped Classical in
/-- **A Følner sequence**"""),
 ("/-- **C133-INV-CLASS.** For a set `S`", """/-- **An invariant probability on a closed invariant set of labellings** (C133-PAIR's step F1): a nonempty closed
set of labellings that the translations and the rotations preserve carries a probability invariant under both. -/
theorem exists_invariant_of_closed {C : Set (E → Λ)} (hC : IsClosed C) (hne : C.Nonempty)
    (hshift : ∀ z, MapsTo (shiftLab z) C C) (hturn : ∀ u, MapsTo (turnLab u) C C) :
    ∃ P : Measure (E → Λ), IsProbabilityMeasure P ∧ P Cᶜ = 0 ∧ (∀ z, P.map (shiftLab z) = P) ∧
      ∀ u, P.map (turnLab u) = P := by
  obtain ⟨ℓ₀, hℓ₀⟩ := hne
  haveI := countable_algPlane
  obtain ⟨F, hF, hFz⟩ := exists_foelner_finset E
  obtain ⟨P₀, hP₀, h0, hinv, -⟩ :=
    exists_shiftInvariant_of_foelner hF hFz hC hshift (fun _ => ℓ₀) (fun _ => hℓ₀)
  obtain ⟨P, hP, hPC, hs, ht, -⟩ := exists_turnInvariant hC hshift hturn h0 hinv
  exact ⟨P, hP, hPC, hs, ht⟩

/-- **C133-INV-CLASS.** For a set `S`"""),
])
sub("Algebraic.lean", [
 ("IsInvariantLaw.measure_zero_le_mOne", "IsInvariantLaw.measure_origin_le_mOne"),
 ("hP.measure_zero_le_mOne", "hP.measure_origin_le_mOne"),
 ("points at distance one and upper density at least `δ`. -/\ntheorem exists_measurable_indep_of_field",
  "points at distance one and upper density at least `δ`. No outside theorem. The hypotheses hold trivially for\n`H = 0`, `δ ≤ 0`; with `δ > 0` they hold for the field `exists_field` gives at an invariant random independent set\nof positive density (the consumer, `IsInvariantLaw.measure_origin_le_mOne`). -/\ntheorem exists_measurable_indep_of_field"),
 ("/-- `f(n) / n` is bounded below by, and has infimum, the finitary independence ratio; `f` is subadditive. The\nthree facts Fekete's lemma takes. -/",
  "/-- `f(n) / n → α₁(ℝ²)`: Fekete's lemma for the subadditive `f`, whose ratios have infimum the finitary\nindependence ratio. No outside theorem. -/"),
])
sub("Field.lean", [("`IsInvariantLaw.measure_zero_le_mOne`", "`IsInvariantLaw.measure_origin_le_mOne`")])
print("applied")
