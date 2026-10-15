import Proofs.HadwigerNelson.Rigidity.PositiveEntropy
import Mathlib.MeasureTheory.Constructions.Polish.Basic

/-! FS131-KN7, stage 2: the repair R1 proposed for `positive_entropy_rigidity`, typed and tested in a scratch namespace
(nothing here is in the library, and the axiom below is a scratch copy under another name, never imported by a module).

R1 states clause (4) over the page's σ-algebra on `X/G_j` — its Borel σ-algebra, `borel (X ⧸ G j)` — in place of
Mathlib's quotient σ-algebra. Three checks:
* `entropy_borel_le_quotient`: for every `X`, the entropy for the Borel σ-algebra of the quotient is at most the entropy
  for the quotient σ-algebra (so R1 is implied by the current statement: the repair can only weaken it);
* `current_clause_four_implies_r1`: the current clause (4) gives R1's, for every `X`;
* `positive_entropy_rigidity_of_polishSpace`: from R1, the current statement word for word, for Polish `X`
  (Mathlib's `QuotientAddGroup.borelSpace`: there the two σ-algebras are one). -/

namespace HadwigerNelson.Rigidity.KN7Scratch

open MeasureTheory

open scoped ENNReal

/-- **R1** (scratch copy): `positive_entropy_rigidity` with clause (4) over `borel (X ⧸ G j)`. -/
axiom positive_entropy_rigidity_r1 {X : Type*} [AddCommGroup X] [TopologicalSpace X] [MeasurableSpace X]
    [BorelSpace X]
    (hX : IsSolenoid X) {d : ℕ} (hd : 2 ≤ d) (α : ZdAction d X)
    (hα : α.NoVirtuallyCyclicFactors) (μ : Measure X) (hμ : IsProbabilityMeasure μ) (herg : α.IsErgodicOn ⊤ μ) :
    ∃ (Λ : AddSubgroup (Fin d → ℤ)) (J : ℕ) (ν : Fin J → Measure X) (G : Fin J → AddSubgroup X),
      Λ.FiniteIndex ∧ 0 < J ∧ μ = (J : ℝ≥0∞)⁻¹ • ∑ j, ν j ∧ (∀ i j, i ≠ j → ν i ⟂ₘ ν j) ∧
      ∀ j, IsProbabilityMeasure (ν j) ∧ α.IsErgodicOn Λ (ν j) ∧
        (IsClosed (G j : Set X) ∧ α.InvariantOn Λ (G j) ∧
          ∀ g ∈ G j, ∀ B : Set X, MeasurableSet B → ν j ((fun x => x + g) ⁻¹' B) = ν j B) ∧
        (∀ n : Fin d → ℤ, ∃ k, (ν j).map (α n) = ν k ∧ (G j).map (α n) = G k) ∧
        ∀ n ∈ Λ, ∀ h : G j ≤ (G j).comap (α n),
          @ksEntropy (X ⧸ G j) (borel (X ⧸ G j))
            (@Measure.map X (X ⧸ G j) _ (borel (X ⧸ G j)) (QuotientAddGroup.mk' (G j)) (ν j))
            (QuotientAddGroup.map (G j) (G j) (α n) h) = 0

/-- A coarser σ-algebra on the factor carries at most the entropy of the pushed measure, when the factor map is
measurable for the finer one and the map on the factor for the coarser. -/
theorem ksEntropy_map_mono {X Y : Type*} [mX : MeasurableSpace X] {mB mQ : MeasurableSpace Y} (hle : mB ≤ mQ)
    (ν : Measure X) {π : X → Y} (hπQ : @Measurable X Y mX mQ π) {S : Y → Y} (hS : @Measurable Y Y mB mB S) :
    @ksEntropy Y mB (@Measure.map X Y mX mB π ν) S ≤ @ksEntropy Y mQ (@Measure.map X Y mX mQ π ν) S := by
  have hπB : @Measurable X Y mX mB π := hπQ.mono le_rfl hle
  refine iSup_mono fun k => iSup_mono fun P => iSup_mono' fun hP => ⟨hP.mono hle le_rfl, le_of_eq ?_⟩
  unfold partitionEntropy blockEntropy
  refine iInf_congr fun n => ?_
  have hcell : ∀ w : Fin (n + 1) → Fin k, (@Measure.map X Y mX mB π ν).real (nameCell S P (n + 1) w) =
      (@Measure.map X Y mX mQ π ν).real (nameCell S P (n + 1) w) := by
    intro w
    have hc : MeasurableSet[mB] (nameCell S P (n + 1) w) := @measurableSet_nameCell Y mB k S hS P hP (n + 1) w
    simp only [Measure.real, Measure.map_apply hπB hc, Measure.map_apply hπQ (hle _ hc)]
  simp only [hcell]

/-- The entropy for the Borel σ-algebra of `X ⧸ G` is at most the entropy for Mathlib's quotient σ-algebra. -/
theorem entropy_borel_le_quotient {X : Type*} [AddCommGroup X] [TopologicalSpace X] [IsTopologicalAddGroup X]
    [MeasurableSpace X] [BorelSpace X] (G : AddSubgroup X) (ν : Measure X) {f : X →+ X} (hf : Continuous f)
    (h : G ≤ G.comap f) :
    @ksEntropy (X ⧸ G) (borel (X ⧸ G))
        (@Measure.map X (X ⧸ G) _ (borel (X ⧸ G)) (QuotientAddGroup.mk' G) ν) (QuotientAddGroup.map G G f h) ≤
      ksEntropy (ν.map (QuotientAddGroup.mk' G)) (QuotientAddGroup.map G G f h) := by
  have hle : borel (X ⧸ G) ≤ QuotientAddGroup.measurableSpace G := by
    have h0 : @Measurable X (X ⧸ G) _ (borel (X ⧸ G)) (QuotientAddGroup.mk' G) :=
      (QuotientAddGroup.continuous_mk (N := G)).borel_measurable.mono OpensMeasurableSpace.borel_le le_rfl
    exact MeasurableSpace.comap_le_iff_le_map.mp h0.comap_le
  have hcS : Continuous (QuotientAddGroup.map G G f h) :=
    (QuotientAddGroup.isQuotientMap_mk G).continuous_iff.mpr (QuotientAddGroup.continuous_mk.comp hf)
  have hS : @Measurable (X ⧸ G) (X ⧸ G) (borel _) (borel _) (QuotientAddGroup.map G G f h) :=
    hcS.borel_measurable
  exact ksEntropy_map_mono hle ν (measurable_quotient_mk'' (s := QuotientAddGroup.leftRel G)) hS

/-- The current clause (4) gives R1's clause (4), for every `X`: R1 asks no more of the page. -/
theorem current_clause_four_implies_r1 {X : Type*} [AddCommGroup X] [TopologicalSpace X] [IsTopologicalAddGroup X]
    [MeasurableSpace X] [BorelSpace X] (G : AddSubgroup X) (ν : Measure X) {f : X →+ X} (hf : Continuous f)
    (h : G ≤ G.comap f) (h4 : ksEntropy (ν.map (QuotientAddGroup.mk' G)) (QuotientAddGroup.map G G f h) = 0) :
    @ksEntropy (X ⧸ G) (borel (X ⧸ G))
        (@Measure.map X (X ⧸ G) _ (borel (X ⧸ G)) (QuotientAddGroup.mk' G) ν) (QuotientAddGroup.map G G f h) = 0 :=
  le_antisymm ((entropy_borel_le_quotient G ν hf h).trans h4.le) bot_le

/-- **From R1, the current statement word for word, for Polish `X`**: the two σ-algebras on `X ⧸ G j` are one there
(`QuotientAddGroup.borelSpace`, Lusin–Souslin). -/
theorem positive_entropy_rigidity_of_polishSpace {X : Type*} [AddCommGroup X] [TopologicalSpace X] [MeasurableSpace X]
    [BorelSpace X] [PolishSpace X]
    (hX : IsSolenoid X) {d : ℕ} (hd : 2 ≤ d) (α : ZdAction d X)
    (hα : α.NoVirtuallyCyclicFactors) (μ : Measure X) (hμ : IsProbabilityMeasure μ) (herg : α.IsErgodicOn ⊤ μ) :
    ∃ (Λ : AddSubgroup (Fin d → ℤ)) (J : ℕ) (ν : Fin J → Measure X) (G : Fin J → AddSubgroup X),
      Λ.FiniteIndex ∧ 0 < J ∧ μ = (J : ℝ≥0∞)⁻¹ • ∑ j, ν j ∧ (∀ i j, i ≠ j → ν i ⟂ₘ ν j) ∧
      ∀ j, IsProbabilityMeasure (ν j) ∧ α.IsErgodicOn Λ (ν j) ∧
        (IsClosed (G j : Set X) ∧ α.InvariantOn Λ (G j) ∧
          ∀ g ∈ G j, ∀ B : Set X, MeasurableSet B → ν j ((fun x => x + g) ⁻¹' B) = ν j B) ∧
        (∀ n : Fin d → ℤ, ∃ k, (ν j).map (α n) = ν k ∧ (G j).map (α n) = G k) ∧
        ∀ n ∈ Λ, ∀ h : G j ≤ (G j).comap (α n),
          ksEntropy ((ν j).map (QuotientAddGroup.mk' (G j))) (QuotientAddGroup.map (G j) (G j) (α n) h) = 0 := by
  haveI := hX.isTopologicalAddGroup
  obtain ⟨Λ, J, ν, G, hΛ, hJ, hμeq, hsing, hj⟩ := positive_entropy_rigidity_r1 hX hd α hα μ hμ herg
  refine ⟨Λ, J, ν, G, hΛ, hJ, hμeq, hsing, fun j => ?_⟩
  obtain ⟨h1, h2, ⟨hcl, hinv, htr⟩, h3, h4⟩ := hj j
  refine ⟨h1, h2, ⟨hcl, hinv, htr⟩, h3, fun n hn h => ?_⟩
  haveI : IsClosed ((G j : AddSubgroup X) : Set X) := hcl
  have e : QuotientAddGroup.measurableSpace (G j) = borel (X ⧸ G j) := BorelSpace.measurable_eq
  rw [e]
  exact h4 n hn h

-- The degenerate model is Polish: the derived form has an inhabitant of its hypotheses.
example : PolishSpace Unit := inferInstance

#print axioms ksEntropy_map_mono
#print axioms entropy_borel_le_quotient
#print axioms current_clause_four_implies_r1
#print axioms positive_entropy_rigidity_of_polishSpace

end HadwigerNelson.Rigidity.KN7Scratch
