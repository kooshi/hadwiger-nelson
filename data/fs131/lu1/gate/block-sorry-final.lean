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
# The plane is not five-colourable, and a proper colouring gives a measurable one: two outside theorems, imported (FS-132)

**The two outside theorems of this module** are `[OAIMath2026]` family 158 — a Lean development published at
github.com/openai/math, read here at its commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a` — and each is an `axiom`
**in the release's own form, over the release's own definitions, copied**:

* `no_proper_five_coloring` (H): no map `ℂ → Fin 5` gives different colours to every two points at distance `1`;
* `proper_to_borel_weak` (T): a proper `k`-colouring of `ℂ`, for any `k`, gives a Borel `k`-colouring proper at almost
  every unit pair — the transfer of colourability to measurable colourings.

Everything else in this file is kernel-checked: the passage from the release's definitions to this library's
(`properColoring_iff_colorable`, `weakColoring_iff_unitPairsNull`), and the forms this library cites —
`six_le_chromaticNumber_plane`, `chromaticNumber_plane_six_or_seven`, `colorable_iff_nonempty_aeColouring`,
`chiM0_le_chromaticNumber_plane`, `chromaticNumber_plane_eq_chiM0`, `six_le_chiM0`.

**Why axioms, and what was checked.** The release proves both at Lean v4.34.1 on Mathlib's tag `v4.34.1`, in 70
modules; this library is at v4.32.0, and holding the proofs here is a port. The release was audited on this machine
(`plans/EXT-OAI1-audit.md`): its 70 modules compile from its source, both theorems rest on `[propext,
Classical.choice, Quot.sound]` there (a planted `sorry` reaches the headline), the headline's stored statement is
the release's challenge statement, and the modules replay through `leanchecker`. **The read-back** is
`plans/FS132-I1-implementation.md` (stages 1 and 2): the eight declarations below — the six copied and the two
statements — are, as the kernel stores them at this pin, the release's eight as the kernel stores them at the
release's pin, term for term (`tools/fs132_i1_readback.py`, on `data/fs132/i1/readback/`). What no check here
reaches is Mathlib itself between the two tags, below the constants the statements name; what stands in for it is
the two equivalences above, which say in this library's own vocabulary what the two axioms assert at this pin, and
nine characterisations of the copied definitions that elaborate, as one text, at both pins (`SemanticBody.lean.inc`
there).

**Licence.** The release is published under the Apache License, Version 2.0, and the declarations copied from it
below are used under that licence: a byte-identical copy of its `LICENSE` file is beside this module,
`Proofs/HadwigerNelson/Outside/OAIMath2026-LICENSE.txt`.

**Read aloud.** H: colour every point of the plane with one of five colours; then some two points exactly one unit
apart have the same colour. T: suppose `k` colours can be given to the points of the plane so that no two points one
unit apart share a colour — with no regularity asked of the colouring. Then there is a Borel-measurable colouring
with the same `k` colours for which the pairs (a point, a direction) whose two ends — the point, and the point moved
one unit in that direction — share a colour form a set of measure zero.

**What the axioms do not say.** H says nothing at six colours. T does not say its measurable colouring is proper at
every unit pair, nor that it is close to the given one; it holds for every `k` and is empty of content where no
proper `k`-colouring exists (`k ≤ 5`, by H). The release's rigidity theorem and its measurable five-colour theorem
are not imported: no statement here cites them.

**Models** (`LEAN.md` § Assumptions, item 3). H has no hypothesis; its sentence at four colours is this library's own
theorem and at seven it is false (the two `example`s under H). T's hypothesis is inhabited at `k = 7`
(`exists_properColoring_seven`, row 33's upper end), and there its conclusion is a theorem with no axiom
(`proper_to_borel_weak_model`).
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

/-! ## The two outside theorems, in the release's form -/

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

/-- **IMPORTED: a proper colouring of the plane gives a Borel colouring proper at almost every unit pair** —
`[OAIMath2026]` (as above), family 158, `lean/OAI/Geometry/PlaneColoring/BorelTransfer.lean` **lines 436–437**, the
lemma `OAI.EuclideanFiveColor.proper_to_borel_weak`; its manuscript's theorem "Transfer of colorability", forward
direction. For every number of colours `k`; `[NeZero k]` is the release's binder (a colouring of the non-empty plane
has a colour, so it carries no content).

Proved there on `[propext, Classical.choice, Quot.sound]` at Lean v4.34.1 (audit: `plans/EXT-OAI1-audit.md` stage 4).
Read back against the release's stored statement, term for term, in `plans/FS132-I1-implementation.md` stages 1–2.
A model of its hypothesis, where its conclusion is a theorem with no axiom, is `proper_to_borel_weak_model` below
(`k = 7`). Declared in `ARCHITECTURE.md` § Trust. -/
axiom proper_to_borel_weak {k : ℕ} [NeZero k] {c : ℂ → Fin k} (hc : ProperColoring k c) :
    ∃ d : ℂ → Fin k, Measurable d ∧ WeakColoring k d

/-! ## The copied definitions in this library's vocabulary (no axiom below this line until `not_colorable_five`) -/

/-- A proper colouring in the release's sense is a colouring of this library's `unitDistance ℂ`, and conversely. -/
theorem properColoring_iff_colorable {k : ℕ} :
    (∃ c : ℂ → Fin k, ProperColoring k c) ↔ (unitDistance ℂ).Colorable k :=
  ⟨fun ⟨c, hc⟩ => ⟨SimpleGraph.Coloring.mk c fun {x y} hxy =>
      hc x y (by rw [← dist_eq_norm]; exact unitDistance_adj.mp hxy)⟩,
   fun ⟨C⟩ => ⟨C, fun x y hxy => C.valid (unitDistance_adj.mpr (by rw [dist_eq_norm, hxy]))⟩⟩

/-- The release's unit vector at the angle `θ` is this library's `Plane.e θ`. -/
theorem direction_coe (θ : ℝ) : direction (θ : Angles) = Plane.e θ := by
  sorry

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

/-- **T in this library's words**: if the plane has a proper `k`-colouring, it has a measurable `k`-colouring proper
at almost every unit pair. Rests on the standard three axioms and `proper_to_borel_weak`. Inhabitant of the
hypothesis: `k = 7`, by `exists_properColoring_seven` through `properColoring_iff_colorable`. -/
theorem nonempty_aeColouring_of_colorable {k : ℕ} (h : (unitDistance ℂ).Colorable k) :
    Nonempty (Plane.AeColouring k) := by
  obtain ⟨c, hc⟩ := properColoring_iff_colorable.mpr h
  haveI : NeZero k := ⟨fun h0 => by subst h0; exact (c 0).elim0⟩
  obtain ⟨d, hd, hw⟩ := proper_to_borel_weak hc
  exact nonempty_aeColouring_of_weak hd hw

/-- **The transfer, colour by colour**: the plane has a proper `k`-colouring exactly when it has a measurable
`k`-colouring proper at almost every unit pair. The direction from a proper colouring is `proper_to_borel_weak`; the
other is this library's N-EASY (`Plane.chromaticNumber_plane_le_chiM0`), which needs no import. -/
theorem colorable_iff_nonempty_aeColouring {k : ℕ} :
    (unitDistance ℂ).Colorable k ↔ Nonempty (Plane.AeColouring k) :=
  ⟨nonempty_aeColouring_of_colorable, fun ⟨a⟩ => SimpleGraph.chromaticNumber_le_iff_colorable.mp
    (Plane.chromaticNumber_plane_le_chiM0.trans (Plane.chiM0_le a))⟩

/-- **`χ_m⁰(ℝ²) ≤ χ(ℝ²)`** — the half of row 130's collapse this project held only given measure rigidity. Rests on
the standard three axioms and `proper_to_borel_weak`. -/
theorem chiM0_le_chromaticNumber_plane : Plane.chiM0 ≤ (unitDistance ℂ).chromaticNumber := by
  rw [SimpleGraph.chromaticNumber]
  refine le_iInf₂ fun k hk => ?_
  obtain ⟨a⟩ := nonempty_aeColouring_of_colorable hk
  exact Plane.chiM0_le a

/-- **Row 130's collapse, with no measure rigidity: `χ(ℝ²) = χ_m⁰(ℝ²)`.** One half is `proper_to_borel_weak`, the
other this library's N-EASY. On branch `fs131-w9` the proposition `Plane.Row130Collapse` is this equality by
definition, assumed there by the theorems of `Plane/Reduction`; at that wave's join this theorem proves it, and
each of those theorems then holds on this import in its place. -/
theorem chromaticNumber_plane_eq_chiM0 : (unitDistance ℂ).chromaticNumber = Plane.chiM0 :=
  le_antisymm Plane.chromaticNumber_plane_le_chiM0 chiM0_le_chromaticNumber_plane

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

/-- **The third item, run**: the transfer applied to this library's seven-colouring of the plane gives a Borel
seven-colouring proper at almost every unit pair. -/
example : ∃ d : ℂ → Fin 7, Measurable d ∧ WeakColoring 7 d := by
  obtain ⟨c, hc⟩ := exists_properColoring_seven
  exact proper_to_borel_weak hc

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

/-- **The one question, for the plane's chromatic number itself: `χ(ℝ²) ≥ 7 ⟺ lim_{ε → 0} µ₆(ε) < 1`.** Row 131's
criterion — `Plane.seven_le_chiM0_iff`, FS106-EQ at six classes, this library's own theorem on the standard three
axioms — rewritten by `chromaticNumber_plane_eq_chiM0`. Rests on the standard three axioms and `proper_to_borel_weak`
alone: `no_proper_five_coloring` is not used. It has no hypothesis, so no model is asked (FS132-L1).

**Read aloud**, against the front page's sentence (`CLAUDE.md` § The aim, item 5: "`χ(ℝ²) = χ_m⁰(ℝ²)` …, and
`χ_m⁰(ℝ²) ≥ 7` iff six classes, each free of monochromatic pairs at distances in `[1−ε, 1+ε]`, cannot cover the plane
up to holes of density tending to 0 as `ε → 0`"): *the plane needs at least seven colours exactly when there is a
`δ > 0` such that, for every `ε > 0`, any six disjoint measurable sets, each with only a null set of pairs of its own
points at a distance in `[1 − ε, 1 + ε]`, leave uncovered a part of the plane of lower density at least `δ`.* Term by
term:

* `(unitDistance ℂ).chromaticNumber` is the plane's chromatic number in row 33's sense:
  `chromaticNumber_plane_eq_complex` equates it with `(unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber`, the
  number `chromaticNumber_plane_interval` bounds by `5` and `7`. With that upper end, `7 ≤ χ` is `χ = 7`; with the
  lower end of `chromaticNumber_plane_six_or_seven` (which rests on the other import), its negation is `χ = 6`.
* `Plane.mu 6 ε` is the best six-class cover at slack `ε`: the supremum, over families of six measurable, pairwise
  disjoint sets each `Plane.BandNull` at `ε`, of the upper density of their union (`Plane.upperDensity`: the `limsup`
  of the covered fraction of the disc of radius `R` about `0`, as `R → ∞`). `⨆ ε > 0, Plane.mu 6 ε` is its limit as
  `ε → 0⁺`: a narrower band is a weaker condition (`Plane.antitone_mu`), so the supremum over `ε > 0` is the limit
  from the right at `0`, and `Plane.tendsto_mu` names that limit `Plane.muZero 6`.
* `< 1`: the limit is at most `1` (`Plane.mu_le_one`), and it is `1` exactly when the uncovered part can be made of
  density as small as one likes by taking `ε` small (the form of `Plane.chiM0_le_iff_periodic`: for every `δ > 0`
  some `ε > 0` and some family at `ε` cover upper density at least `1 − δ`). So `< 1` says that the holes keep a
  density bounded below, by one bound for every `ε > 0` and every family: the covered fraction of the discs about
  `0` has `limsup` at most `1 − δ`, so the uncovered fraction has `liminf` at least `δ`.

**Where the statement and the sentence differ in wording, and why that is no gap.** The sentence says each class is
*free* of monochromatic pairs in the band; `Plane.mu` asks that such pairs be *null* (`Plane.BandNull`), the weaker
condition (`Plane.bandNull_of_bandFree`) and so the larger supremum (`Plane.muPer_le_muTile`, `Plane.muTile_le_mu`).
The limit is the same under the strict reading and under the strictest — periodic families of half-open grid squares
with no such pair at all: `Plane.tendsto_muTile` and `Plane.tendsto_muPer` have the same limit `Plane.muZero 6`, and
`Plane.chiM0_le_iff_periodic` states the criterion in that form at every number of classes. The plane of the statement
is `ℂ`, as in every `Plane` module. -/
theorem seven_le_chromaticNumber_plane_iff :
    7 ≤ (unitDistance ℂ).chromaticNumber ↔ (⨆ ε > (0 : ℝ), Plane.mu 6 ε) < 1 := by
  rw [chromaticNumber_plane_eq_chiM0]; exact Plane.seven_le_chiM0_iff

end HadwigerNelson.Outside.OAI158

set_option pp.fullNames true
#print axioms HadwigerNelson.Outside.OAI158.not_colorable_five
#print axioms HadwigerNelson.Outside.OAI158.six_le_chromaticNumber_plane
#print axioms HadwigerNelson.Outside.OAI158.chromaticNumber_plane_six_or_seven
#print axioms HadwigerNelson.Outside.OAI158.six_le_chiM0
#print axioms HadwigerNelson.Outside.OAI158.chiM0_six_or_seven
#print axioms HadwigerNelson.Outside.OAI158.nonempty_aeColouring_of_colorable
#print axioms HadwigerNelson.Outside.OAI158.colorable_iff_nonempty_aeColouring
#print axioms HadwigerNelson.Outside.OAI158.chiM0_le_chromaticNumber_plane
#print axioms HadwigerNelson.Outside.OAI158.chromaticNumber_plane_eq_chiM0
#print axioms HadwigerNelson.Outside.OAI158.seven_le_chromaticNumber_plane_iff
#print axioms HadwigerNelson.Outside.OAI158.properColoring_iff_colorable
#print axioms HadwigerNelson.Outside.OAI158.direction_coe
#print axioms HadwigerNelson.Outside.OAI158.map_coe_arcLength
#print axioms HadwigerNelson.Outside.OAI158.map_prodMap_coe
#print axioms HadwigerNelson.Outside.OAI158.weakColoring_iff_unitPairsNull
#print axioms HadwigerNelson.Outside.OAI158.nonempty_aeColouring_of_weak
#print axioms HadwigerNelson.Outside.OAI158.weakColoring_of_aeColouring
#print axioms HadwigerNelson.Outside.OAI158.exists_weakColoring_iff_nonempty_aeColouring
#print axioms HadwigerNelson.Outside.OAI158.exists_properColoring_seven
#print axioms HadwigerNelson.Outside.OAI158.proper_to_borel_weak_model
#print axioms HadwigerNelson.Outside.OAI158.anglePeriodPositive
#print axioms HadwigerNelson.Outside.OAI158.angularMeasure.instIsProbabilityMeasure
