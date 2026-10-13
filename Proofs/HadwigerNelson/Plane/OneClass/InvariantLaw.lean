import Proofs.HadwigerNelson.Plane.OneClass.Defs
import Mathlib.MeasureTheory.Constructions.BorelSpace.Basic
import Mathlib.Topology.Algebra.InfiniteSum.Basic

/-!
# An invariant random independent set of the best density (FS-133)

The derivation's entry C133-INV-CLASS (`plans/FS133-E1-derivation.md`, stage 4), on `E → Bool`:

* `IsShiftInvariantLaw.measure_origin_le` — its step (1): a translation-invariant random independent set of **any**
  graph on the algebraic plane has density at most the graph's finitary independence ratio;
* `exists_foelner_finset` — a countable rational vector space has a Følner sequence of finite sets;
* `exists_shiftInvariant_of_foelner` — its step (2), for labellings: a limit of Følner averages of translates;
* `exists_turnInvariant` — its step (3), for labellings: a common fixed point of the rotations, in place of the
  Markov–Kakutani theorem;
* `exists_isInvariantLaw` — the entry: for a connection set `S` invariant under the algebraic rotations, an
  invariant random independent set of the Cayley graph of `S` whose density **is** the ratio.

The Cayley graph is Mathlib's `SimpleGraph.circulantGraph S`, which symmetrises `S` and drops `0`: the entry's
"`S ⊆ E ∖ {0}` symmetric" is not a hypothesis here. The two middle statements are about labellings in any finite
set, because C133-PAIR's step F1 uses them again.
-/

open MeasureTheory Filter Set
open scoped ENNReal Topology

namespace HadwigerNelson.OneClass

open HadwigerNelson.Outside.OAI158 HadwigerNelson.Outside.OAI158.Spectral SimpleGraph

/-- **C133-INV-CLASS, the upper bound** (step (1); any graph on the algebraic plane, translations only). -/
theorem IsShiftInvariantLaw.measure_origin_le {G : SimpleGraph E} {P : Measure (E → Bool)}
    (h : IsShiftInvariantLaw G P) : P {I | I 0 = true} ≤ G.finIndepRatio := by
  sorry

/-- The algebraic plane is countable (the release's `E_countable`; a theorem, not an instance: `E` is Mathlib's
type). -/
theorem countable_algPlane : Countable E := by
  sorry

/-- **A Følner sequence**: a countable rational vector space has finite nonempty sets `F n` such that, for every
`z`, the proportion of `F n` that `z` translates out of `F n` tends to `0`. -/
theorem exists_foelner_finset (A : Type*) [AddCommGroup A] [Module ℚ A] [Countable A] :
    ∃ F : ℕ → Finset A, (∀ n, (F n).Nonempty) ∧ ∀ z : A,
      Tendsto (fun n => ({a | a ∈ F n ∧ a + z ∉ F n}.ncard : ℝ) / (F n).card) atTop (𝓝 0) := by
  sorry

variable {Λ : Type*} [Finite Λ] [TopologicalSpace Λ] [DiscreteTopology Λ] [MeasurableSpace Λ]
  [MeasurableSingletonClass Λ]

/-- **Følner averages of translates have an invariant limit** (step (2)). For a closed set `C` of labellings that
the translations preserve, labellings `ℓ n ∈ C` and a Følner sequence `F`: some translation-invariant probability
carried by `C` gives each label `a`, at the origin, at least any proportion `c` that `ℓ n` gives `a` on every
`F n`. -/
theorem exists_shiftInvariant_of_foelner {F : ℕ → Finset E} (hF : ∀ n, (F n).Nonempty)
    (hFz : ∀ z : E, Tendsto (fun n => ({a | a ∈ F n ∧ a + z ∉ F n}.ncard : ℝ) / (F n).card) atTop (𝓝 0))
    {C : Set (E → Λ)} (hC : IsClosed C) (hshift : ∀ z, MapsTo (shiftLab z) C C) (ℓ : ℕ → E → Λ)
    (hℓ : ∀ n, ℓ n ∈ C) :
    ∃ P : Measure (E → Λ), IsProbabilityMeasure P ∧ P Cᶜ = 0 ∧ (∀ z, P.map (shiftLab z) = P) ∧
      ∀ (a : Λ) (c : ℝ), (∀ n, c * (F n).card ≤ {r | r ∈ F n ∧ ℓ n r = a}.ncard) →
        ENNReal.ofReal c ≤ P {ℓ' | ℓ' 0 = a} := by
  sorry

/-- **The rotations have a common fixed point** (step (3), with no Markov–Kakutani theorem: the rotations are
countably many commuting continuous maps, and a Cesàro limit fixes one at a time). From a translation-invariant
probability carried by a closed set `C` that translations and rotations preserve: one invariant under both, carried
by `C`, with the same law of the label at the origin. -/
theorem exists_turnInvariant {C : Set (E → Λ)} (hC : IsClosed C) (hshift : ∀ z, MapsTo (shiftLab z) C C)
    (hturn : ∀ u, MapsTo (turnLab u) C C) {P₀ : Measure (E → Λ)} [IsProbabilityMeasure P₀] (h0 : P₀ Cᶜ = 0)
    (hinv : ∀ z, P₀.map (shiftLab z) = P₀) :
    ∃ P : Measure (E → Λ), IsProbabilityMeasure P ∧ P Cᶜ = 0 ∧ (∀ z, P.map (shiftLab z) = P) ∧
      (∀ u, P.map (turnLab u) = P) ∧ ∀ a, P {ℓ | ℓ 0 = a} = P₀ {ℓ | ℓ 0 = a} := by
  sorry

/-- **An invariant probability on a closed invariant set of labellings** (C133-PAIR's step F1): a nonempty closed
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

/-- **C133-INV-CLASS.** For a set `S` of the algebraic plane invariant under the algebraic rotations, some
invariant random independent set of the Cayley graph of `S` has density equal to the graph's finitary independence
ratio. (With `IsShiftInvariantLaw.measure_origin_le`: no translation-invariant one has more.) -/
theorem exists_isInvariantLaw (S : Set E) (hS : ∀ u : K, ∀ s ∈ S, kCoeff u * s ∈ S) :
    ∃ P : Measure (E → Bool), IsInvariantLaw (circulantGraph S) P ∧
      P {I | I 0 = true} = (circulantGraph S).finIndepRatio := by
  sorry

/-- A rotation preserves the modulus of a point of the algebraic plane. -/
theorem norm_kCoeff_mul (u : K) (z : E) : ‖((kCoeff u * z : E) : ℂ)‖ = ‖(z : ℂ)‖ := by
  sorry

/-- The unit-distance graph of the algebraic plane is the Cayley graph of its unit circle. -/
theorem unitDistance_algPlane_eq_circulantGraph :
    unitDistance E = circulantGraph {z : E | ‖(z : ℂ)‖ = 1} := by
  sorry

/-- **C133-INV, as posed, with equality**: the unit-distance graph of the algebraic plane has an invariant random
independent set whose density is its finitary independence ratio. -/
theorem exists_isInvariantLaw_unitDistance :
    ∃ P : Measure (E → Bool), IsInvariantLaw (unitDistance E) P ∧
      P {I | I 0 = true} = (unitDistance E).finIndepRatio := by
  rw [unitDistance_algPlane_eq_circulantGraph]
  exact exists_isInvariantLaw _ fun u s hs => (norm_kCoeff_mul u s).trans hs

end HadwigerNelson.OneClass
