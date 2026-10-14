import Proofs.HadwigerNelson.Instances.Interval
import Proofs.HadwigerNelson.Plane.YesLimit
import Proofs.HadwigerNelson.Plane.CoverExamples
import Mathlib.Analysis.Fourier.AddCircle
-- Not for a lemma. With this module imported, `volume : Measure ℂ` in `WeakColoring` below elaborates with the
-- instance `Complex.instFiniteDimensionalReal`, as it does at the release's pin under `import Mathlib`; without it
-- the instance found is `FiniteDimensional.rclike_to_real` — another proof of the same proposition, so the same
-- measure, but then the stored term is not the release's term symbol for symbol (FS132-I1, stages 1 and 2:
-- `tools/fs132_i1_readback.py`).
import Mathlib.LinearAlgebra.Complex.FiniteDimensional

/-!
# The plane is not five-colourable: an outside theorem, imported (FS-132); the transfer, a theorem of the port (FS-131)

**The outside theorem of this module** is `[OAIMath2026]` family 158 — a Lean development published at
github.com/openai/math, read here at its commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a` — an `axiom` **in the
release's own form, over the release's own definitions, copied**:

* `no_proper_five_coloring` (H): no map `ℂ → Fin 5` gives different colours to every two points at distance `1`.

**The transfer** `proper_to_borel_weak` (T) — a proper `k`-colouring of `ℂ`, for any `k`, gives a Borel `k`-colouring
proper at almost every unit pair — was declared here as a second axiom, over the same copied definitions. It is now the
release's own theorem, its proof ported (`Outside/OAI158BorelTransfer`, under the same name, over these definitions;
FS-131, the port of `plans/FS131-KO1-port-plan.md`) and kernel-checked in this library on the standard three axioms.
The port imports `Outside/OAI158Palette`, which imports this module, so T stands downstream of it: the theorems that use
T — `nonempty_aeColouring_of_colorable`, `colorable_iff_nonempty_aeColouring`, `chiM0_le_chromaticNumber_plane`,
`chromaticNumber_plane_eq_chiM0`, `seven_le_chromaticNumber_plane_iff`, and the `example` that applies it — are in
`Outside/OAI158Collapse`, moved there unchanged (FS131-IPD1).

Everything else in this file is kernel-checked: the passage from the release's definitions to this library's
(`properColoring_iff_colorable`, `weakColoring_iff_unitPairsNull`), and the forms of H this library cites —
`six_le_chromaticNumber_plane`, `chromaticNumber_plane_six_or_seven`, `six_le_chiM0`, `chiM0_six_or_seven`.

**Why an axiom, and what was checked.** The release proves H at Lean v4.34.1 on Mathlib's tag `v4.34.1`, in 70
modules; this library is at v4.32.0, and its five-colour arm is not ported (`plans/FS131-KO1-port-plan.md` § 2.4). The
release was audited on this machine (`plans/EXT-OAI1-audit.md`): its 70 modules compile from its source, H rests on
`[propext, Classical.choice, Quot.sound]` there (a planted `sorry` reaches the headline), the headline's stored
statement is the release's challenge statement, and the modules replay through `leanchecker`. **The read-back** is
`plans/FS132-I1-implementation.md` (stages 1 and 2): the six copied declarations below and the statement of H — and
of T while it was declared here — are, as the kernel stores them at this pin, the release's as the kernel stores them
at the release's pin, term for term (`tools/fs132_i1_readback.py`, on `data/fs132/i1/readback/`); T as the port's
theorem is read back against the release by the port's own read-back (FS131-LP1: IDENTICAL). What no check here reaches is Mathlib itself between
the two tags, below the constants H's statement names; what stands in for it is the equivalences above, which say in
this library's own vocabulary what the axiom asserts at this pin, and nine characterisations of the copied definitions
that elaborate, as one text, at both pins (`SemanticBody.lean.inc` there).

**Licence.** The release is published under the Apache License, Version 2.0, and the declarations copied from it
below are used under that licence: a byte-identical copy of its `LICENSE` file is beside this module,
`Proofs/HadwigerNelson/Outside/OAIMath2026-LICENSE.txt`.

**Read aloud.** H: colour every point of the plane with one of five colours; then some two points exactly one unit
apart have the same colour.

**What the axiom does not say.** H says nothing at six colours. The release's rigidity theorem and its measurable
five-colour theorem are not imported: no statement here cites them.

**Models** (`LEAN.md` § Assumptions, item 3). H has no hypothesis; its sentence at four colours is this library's own
theorem and at seven it is false (the two `example`s under H). T's hypothesis is inhabited at `k = 7`
(`exists_properColoring_seven`, row 33's upper end), and there its conclusion is this library's own theorem, with no
use of T (`proper_to_borel_weak_model`) — the model an import asked for, kept as T's model now that T is ported.
-/

open MeasureTheory

namespace HadwigerNelson.Outside.OAI158

/-! ## The release's definitions, copied (`lean/OAI/Geometry/PlaneColoring/Coloring.lean`, lines 7–8, 15–19, 27–29) -/

/-- `[OAIMath2026]` `Coloring.lean:7–8`, `OAI.EuclideanFiveColor.ProperColoring`: a `k`-colouring of `ℂ` giving different
colours to every two points at distance `1`. -/
def ProperColoring (k : ℕ) (c : ℂ → Fin k) : Prop :=
  ∀ x y : ℂ, ‖x - y‖ = 1 → c x ≠ c y

/-- `[OAIMath2026]` `Coloring.lean:15`, `OAI.EuclideanFiveColor.anglePeriodPositive` (there a global instance; here
scoped, since an unscoped instance is permanent). -/
scoped instance anglePeriodPositive : Fact (0 < 2*Real.pi) := ⟨by positivity⟩

/-- `[OAIMath2026]` `Coloring.lean:16`, `OAI.EuclideanFiveColor.Angles`: the circle of angles, `ℝ` modulo `2π`. -/
abbrev Angles := AddCircle (2*Real.pi)

/-- `[OAIMath2026]` `Coloring.lean:17`, `OAI.EuclideanFiveColor.angularMeasure`: normalized Haar measure on the circle
of angles. -/
noncomputable def angularMeasure : Measure Angles := AddCircle.haarAddCircle

/-- `[OAIMath2026]` `Coloring.lean:18`, `OAI.EuclideanFiveColor.direction`: the unit vector at an angle. -/
noncomputable def direction (t : Angles) : ℂ := AddCircle.toCircle t

/-- `[OAIMath2026]` `Coloring.lean:19` (there anonymous): the angular measure has total mass `1`. -/
instance angularMeasure.instIsProbabilityMeasure : IsProbabilityMeasure angularMeasure :=
  inferInstanceAs (IsProbabilityMeasure (AddCircle.haarAddCircle (T := 2*Real.pi)))

/-- `[OAIMath2026]` `Coloring.lean:27–29`, `OAI.EuclideanFiveColor.WeakColoring` — there "Exactly the manuscript weak
measurable condition, using normalized Haar angular measure. A function is understood up to a plane-null set; no
regularity is imposed on a proper coloring." For a measurable colouring it says every colour class has null unit pairs
(`weakColoring_iff_unitPairsNull`). -/
def WeakColoring (k : ℕ) (c : ℂ → Fin k) : Prop :=
  AEMeasurable c (volume : Measure ℂ) ∧ ∀ᵐ p ∂(volume : Measure ℂ).prod angularMeasure,
    c p.1 ≠ c (p.1+direction p.2)

/-! ## The outside theorem, in the release's form -/

/-- **IMPORTED: the plane is not five-colourable** — `[OAIMath2026]` (OpenAI, *Mathematics manuscript collection*,
github.com/openai/math, commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a`), family 158,
`lean/OAI/Geometry/PlaneColoring/Five.lean` **line 124**, the theorem `OAI.EuclideanFiveColor.no_proper_five_coloring`
("No unrestricted five-coloring separates all unit-distance pairs in the Euclidean plane."); its manuscript's Theorem 1.

Proved there on `[propext, Classical.choice, Quot.sound]` at Lean v4.34.1 (audit: `plans/EXT-OAI1-audit.md` stage 4).
Read back against the release's stored statement, term for term, in `plans/FS132-I1-implementation.md` stages 1–2.
The statement has no hypothesis, so no model is asked; `ProperColoring` is inhabited at seven
(`exists_properColoring_seven`), and the two `example`s below read this sentence at four colours and at seven.
Declared in `ARCHITECTURE.md` § Trust. -/
axiom no_proper_five_coloring : ¬ ∃ c : ℂ → Fin 5, ProperColoring 5 c

/-! ## The copied definitions in this library's vocabulary (no axiom below this line until `not_colorable_five`) -/

/-- A proper colouring in the release's sense is a colouring of this library's `unitDistance ℂ`, and conversely. -/
theorem properColoring_iff_colorable {k : ℕ} :
    (∃ c : ℂ → Fin k, ProperColoring k c) ↔ (unitDistance ℂ).Colorable k :=
  ⟨fun ⟨c, hc⟩ => ⟨SimpleGraph.Coloring.mk c fun {x y} hxy =>
      hc x y (by rw [← dist_eq_norm]; exact unitDistance_adj.mp hxy)⟩,
   fun ⟨C⟩ => ⟨C, fun x y hxy => C.valid (unitDistance_adj.mpr (by rw [dist_eq_norm, hxy]))⟩⟩

/-- The release's unit vector at the angle `θ` is this library's `Plane.e θ`. -/
theorem direction_coe (θ : ℝ) : direction (θ : Angles) = Plane.e θ := by
  have h : 2 * Real.pi / (2 * Real.pi) * θ = θ := by
    rw [div_self (by positivity), one_mul]
  rw [direction, AddCircle.toCircle_apply_mk, h, Circle.coe_exp, Plane.e]

/-- This library's arc-length (Lebesgue measure on `[0, 2π)`), carried to the circle of angles, is `2π` times the
release's angular measure. -/
theorem map_coe_arcLength :
    Measure.map (fun θ : ℝ => (θ : Angles)) Plane.arcLength = ENNReal.ofReal (2 * Real.pi) • angularMeasure := by
  have h := (AddCircle.measurePreserving_mk (2 * Real.pi) 0).map_eq
  rw [zero_add] at h
  rw [Plane.arcLength, Measure.restrict_congr_set Ico_ae_eq_Ioc, angularMeasure,
    ← AddCircle.volume_eq_smul_haarAddCircle]
  exact h

/-- The same for the product with the plane: `volume ⊗ arcLength`, carried along `(x, θ) ↦ (x, θ mod 2π)`, is `2π`
times `volume ⊗ angularMeasure`. -/
theorem map_prodMap_coe :
    Measure.map (Prod.map id fun θ : ℝ => (θ : Angles)) ((volume : Measure ℂ).prod Plane.arcLength) =
      ENNReal.ofReal (2 * Real.pi) • (volume : Measure ℂ).prod angularMeasure := by
  rw [← Measure.map_prod_map volume Plane.arcLength measurable_id AddCircle.measurable_mk', Measure.map_id,
    map_coe_arcLength, Measure.prod_smul_right]

/-- **The release's weak colourings are this library's colourings proper at almost every unit pair**: a measurable
`d : ℂ → Fin k` is a `WeakColoring` exactly when each of its colour classes has null unit pairs. The pairs
`(x, θ) ∈ ℂ × ℝ` with `d x = d (x + e θ)` are the preimage, along `θ ↦ θ mod 2π`, of the release's bad set, and that
map carries `volume ⊗ arcLength` to `2π` times `volume ⊗ angularMeasure`. -/
theorem weakColoring_iff_unitPairsNull {k : ℕ} {d : ℂ → Fin k} (hd : Measurable d) :
    WeakColoring k d ↔ ∀ j, Plane.UnitPairsNull (d ⁻¹' {j}) := by
  set B : Set (ℂ × Angles) := {p | d p.1 = d (p.1 + direction p.2)} with hB
  have hdir : Measurable direction := (continuous_subtype_val.comp AddCircle.continuous_toCircle).measurable
  have hBm : MeasurableSet B :=
    measurableSet_eq_fun (hd.comp measurable_fst) (hd.comp (measurable_fst.add (hdir.comp measurable_snd)))
  have hφ : Measurable (Prod.map (id : ℂ → ℂ) fun θ : ℝ => (θ : Angles)) :=
    measurable_id.prodMap AddCircle.measurable_mk'
  have hpre : (Prod.map (id : ℂ → ℂ) fun θ : ℝ => (θ : Angles)) ⁻¹' B = ⋃ j, Plane.unitPairSet (d ⁻¹' {j}) := by
    ext ⟨x, θ⟩
    simp only [hB, Set.mem_preimage, Prod.map_apply, id_eq, Set.mem_setOf_eq, direction_coe, Set.mem_iUnion,
      Plane.unitPairSet, Set.mem_singleton_iff]
    exact ⟨fun h => ⟨d x, rfl, h.symm⟩, fun ⟨j, h1, h2⟩ => h1.trans h2.symm⟩
  have hmass : (volume.prod Plane.arcLength) (⋃ j, Plane.unitPairSet (d ⁻¹' {j})) =
      ENNReal.ofReal (2 * Real.pi) * ((volume : Measure ℂ).prod angularMeasure) B := by
    rw [← hpre, ← Measure.map_apply hφ hBm, map_prodMap_coe, Measure.smul_apply, smul_eq_mul]
  have hc0 : ENNReal.ofReal (2 * Real.pi) ≠ 0 := by
    rw [Ne, ENNReal.ofReal_eq_zero, not_le]; positivity
  have hweak : WeakColoring k d ↔ ((volume : Measure ℂ).prod angularMeasure) B = 0 := by
    rw [WeakColoring, ae_iff]
    simp only [ne_eq, not_not]
    exact ⟨fun h => h.2, fun h => ⟨hd.aemeasurable, h⟩⟩
  rw [hweak]
  simp only [Plane.UnitPairsNull]
  rw [← measure_iUnion_null_iff, hmass, mul_eq_zero]
  exact ⟨fun h => Or.inr h, fun h => h.resolve_left hc0⟩

/-- **The measure bridge**: a measurable weak colouring in the release's sense is an `AeColouring` of this library.
Inhabitant of the hypotheses: `proper_to_borel_weak_model` (`k = 7`, no axiom). -/
theorem nonempty_aeColouring_of_weak {k : ℕ} {d : ℂ → Fin k} (hd : Measurable d) (hw : WeakColoring k d) :
    Nonempty (Plane.AeColouring k) :=
  ⟨⟨d, hd, (weakColoring_iff_unitPairsNull hd).mp hw⟩⟩

/-- Conversely, every `AeColouring` of this library is a weak colouring in the release's sense. -/
theorem weakColoring_of_aeColouring {k : ℕ} (a : Plane.AeColouring k) : WeakColoring k a.col :=
  (weakColoring_iff_unitPairsNull a.measurable).mpr a.unitPairsNull

/-- The release's Borel weak `k`-colourings and this library's `AeColouring k` are the same objects. -/
theorem exists_weakColoring_iff_nonempty_aeColouring {k : ℕ} :
    (∃ d : ℂ → Fin k, Measurable d ∧ WeakColoring k d) ↔ Nonempty (Plane.AeColouring k) :=
  ⟨fun ⟨_, hd, hw⟩ => nonempty_aeColouring_of_weak hd hw,
   fun ⟨a⟩ => ⟨a.col, a.measurable, weakColoring_of_aeColouring a⟩⟩

/-! ## Models of the hypotheses (`LEAN.md` § Assumptions, item 3), with no axiom -/

/-- **Model of T's hypothesis**: a proper seven-colouring of the plane exists (row 33's upper end). -/
theorem exists_properColoring_seven : ∃ c : ℂ → Fin 7, ProperColoring 7 c := by
  rw [properColoring_iff_colorable, ← SimpleGraph.chromaticNumber_le_iff_colorable,
    ← chromaticNumber_plane_eq_complex]
  exact chromaticNumber_plane_interval.2

/-- **A model of T's hypothesis, where its conclusion is a theorem with no axiom**: at `k = 7` a proper colouring
exists, and so does a measurable weak colouring — this library's `Plane.r7_aeColouring`. -/
theorem proper_to_borel_weak_model :
    (∃ c : ℂ → Fin 7, ProperColoring 7 c) ∧ ∃ d : ℂ → Fin 7, Measurable d ∧ WeakColoring 7 d := by
  obtain ⟨a, -⟩ := Plane.r7_aeColouring
  exact ⟨exists_properColoring_seven, a.col, a.measurable, weakColoring_of_aeColouring a⟩

/-- H's sentence at four colours is this library's own theorem (row 33's lower end): the import moves it to five. -/
example : ¬ ∃ c : ℂ → Fin 4, ProperColoring 4 c := fun h =>
  (properColoring_iff_colorable.mp h).elim fun C => isEmpty_coloring_plane_four.false C

/-- **Adversary**: H's sentence at seven colours is false. -/
example : ¬ ¬ ∃ c : ℂ → Fin 7, ProperColoring 7 c := fun h => h exists_properColoring_seven

/-- **Adversary**: no weak colouring with one colour (`IsEmpty (Plane.AeColouring 1)`). -/
example : ¬ ∃ d : ℂ → Fin 1, Measurable d ∧ WeakColoring 1 d := fun h =>
  (exists_weakColoring_iff_nonempty_aeColouring.mp h).elim fun a => IsEmpty.false a

/-! ## The forms this library cites -/

/-- **H in this library's words**: the unit-distance graph of the plane has no five-colouring. Rests on the standard
three axioms and `no_proper_five_coloring`. -/
theorem not_colorable_five : ¬ (unitDistance ℂ).Colorable 5 := fun h =>
  no_proper_five_coloring (properColoring_iff_colorable.mpr h)

/-- **`6 ≤ χ(ℝ²)`**, in row 33's form. Rests on the standard three axioms and `no_proper_five_coloring`. -/
theorem six_le_chromaticNumber_plane : 6 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber := by
  rw [chromaticNumber_plane_eq_complex]
  have h6 := (add_one_le_chromaticNumber_iff_not_colorable (G := unitDistance ℂ) (n := 5)).mpr not_colorable_five
  exact_mod_cast h6

/-- **`6 ≤ χ(ℝ²) ≤ 7`**: row 33's interval with its lower end moved from five to six. The upper end is this library's
own theorem; the lower end rests on `no_proper_five_coloring`. `chromaticNumber_plane_interval`, `5 ≤ χ(ℝ²) ≤ 7`,
remains the statement this library proves with no import. -/
theorem chromaticNumber_plane_six_or_seven :
    6 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber ∧
      (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber ≤ 7 :=
  ⟨six_le_chromaticNumber_plane, chromaticNumber_plane_interval.2⟩

/-- **`6 ≤ χ_m⁰(ℝ²)`**: a measurable colouring of the plane proper at almost every unit pair needs six colours
(FS-104's question). From `no_proper_five_coloring` and N-EASY alone — the transfer is not used. -/
theorem six_le_chiM0 : 6 ≤ Plane.chiM0 := by
  have h := six_le_chromaticNumber_plane
  rw [chromaticNumber_plane_eq_complex] at h
  exact h.trans Plane.chromaticNumber_plane_le_chiM0

/-- **`6 ≤ χ_m⁰(ℝ²) ≤ 7`**: the lower end as `six_le_chiM0`; the upper end is this library's own
(`Plane.r7_aeColouring`), with no import. -/
theorem chiM0_six_or_seven : 6 ≤ Plane.chiM0 ∧ Plane.chiM0 ≤ 7 := by
  obtain ⟨a, -⟩ := Plane.r7_aeColouring
  exact ⟨six_le_chiM0, Plane.chiM0_le a⟩

/-! ## Spec examples (each fails if its definition drifts) -/

/-- A proper colouring separates `0` and `1`. -/
example {k : ℕ} {c : ℂ → Fin k} (h : ProperColoring k c) : c 0 ≠ c 1 := h 0 1 (by simp)

/-- The circle of angles has period `2π`. -/
example : ((2 * Real.pi : ℝ) : Angles) = 0 := AddCircle.coe_period _

/-- The angular measure of the whole circle is `1`, not `2π`. -/
example : angularMeasure Set.univ = 1 := measure_univ

/-- The direction at the angle `π / 2` is `i`: angles are in radians and counter-clockwise. -/
example : direction ((Real.pi / 2 : ℝ) : Angles) = Complex.I := by
  rw [direction_coe, Plane.e_eq, Real.cos_pi_div_two, Real.sin_pi_div_two]; simp

end HadwigerNelson.Outside.OAI158
