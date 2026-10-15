import Proofs.HadwigerNelson.Rigidity.Herglotz
import Proofs.HadwigerNelson.Plane.OneClass.InvariantLaw

/-!
# The invariant measure on a closed invariant set of colourings (FS-131, job FS131-KR1; module M3)

**Read aloud, against the informal claim.** For a subfield `F ⊆ ℝ` whose unit-vector ring `R = ℤ[U_F]` is countable, every
nonempty closed measurable set `K` of colourings `R → Fin 4`, stable under the shifts `c ↦ c(· + y)` and the rotations
`c ↦ c(u ·)`, carries a probability measure invariant under both: `invariantMeasureOnClosed_of_countable :
InvariantMeasureOnClosed F`, the library's `Prop` (`SpectralChain` l. 345), the headline's `hL1`. The printed route is
Markov–Kakutani twice (`[Kakutani1938]`, not held); this module reads no fixed-point theorem.

**The route (`plans/FS131-KR1-chain-map.md` § 2.2).** (1) `exists_shiftInvariant_on`: average the push-forwards of a point
mass at `c ∈ K` under the shifts with the almost-invariant probability weights `(w n)²` of `exists_almostInvariant_weights`;
a weak limit point on the compact metrizable space `unitRing F → Fin 4` is shift-invariant and, `K` being closed, carried by
`K`. (2) `exists_rotInvariant_of_shiftInvariant`: the same averaging over the countable abelian group of unit vectors acting
by rotations; `shift_y ∘ rot_u = rot_u ∘ shift_{u y}` keeps every average shift-invariant, and the limit is invariant under
both.

**Models.** `F = ⊥` (the rationals): `R` is countable, `K = X₄(⊥)` is nonempty (the plane over `ℚ` is two-colourable) and
closed, measurable and invariant (`SpectralChain.isClosed_X4`, `measurableSet_X4`, `shift_mem_X4`, `rot_mem_X4`).
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory SpectralChain

noncomputable section

-- The proofs follow FS133-IB1's route and read its helpers in `Plane/OneClass/InvariantLaw` (public since the chain's
-- landing, FS131-LCH1): a Cesàro limit fixes one continuous map inside a closed class of probabilities, and compactness
-- of the class fixes a commuting family; no almost-invariant weights are read.

section Average

open scoped ENNReal

variable {X : Type*} [MeasurableSpace X]

/-- A null set stays null under a uniform average. -/
private theorem avgMeasure_eq_zero {ι : Type*} (s : Finset ι) {μ : ι → Measure X} {A : Set X}
    (h : ∀ i ∈ s, μ i A = 0) : OneClass.avgMeasure s μ A = 0 := by
  rw [OneClass.avgMeasure_apply, Finset.sum_eq_zero h, mul_zero]

/-- A uniform average of measures that one map fixes is fixed by it. -/
private theorem avgMeasure_map_eq {ι : Type*} (s : Finset ι) {μ : ι → Measure X} {g : X → X} (hg : Measurable g)
    (h : ∀ i ∈ s, (μ i).map g = μ i) : (OneClass.avgMeasure s μ).map g = OneClass.avgMeasure s μ := by
  rw [OneClass.avgMeasure_map _ _ hg]
  unfold OneClass.avgMeasure
  congr 1
  exact Finset.sum_congr rfl h

end Average

section Weak

open Filter Topology

variable {X : Type*} [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X] [HasOuterApproxClosed X]

variable [CompactSpace X] [T2Space X]

end Weak

variable (F : Subfield ℝ)

/-! ### Private helpers: the shifts and the rotations of colourings -/

/-- The shift `c ↦ c(· + y)`. -/
private theorem continuous_shiftCol (y : unitRing F) :
    Continuous fun (c : unitRing F → Fin 4) (x : unitRing F) => c (x + y) :=
  continuous_pi fun x => continuous_apply (x + y)

/-- The rotation `c ↦ c(u ·)`. -/
private theorem continuous_rotCol (u : unitVectors F) :
    Continuous fun (c : unitRing F → Fin 4) (x : unitRing F) => c (uvRing u * x) :=
  continuous_pi fun x => continuous_apply (uvRing u * x)

/-- A map keeping `K` sends no measure carried by `K` off it. -/
private theorem map_compl_eq_zero {K : Set (unitRing F → Fin 4)} (hmeas : MeasurableSet K)
    {g : (unitRing F → Fin 4) → unitRing F → Fin 4} (hg : Measurable g) (hgK : ∀ c ∈ K, g c ∈ K)
    {μ : Measure (unitRing F → Fin 4)} (hμ : μ Kᶜ = 0) : (μ.map g) Kᶜ = 0 := by
  rw [Measure.map_apply hg hmeas.compl]
  exact measure_mono_null (fun c hc hcK => hc (hgK c hcK)) hμ

/-- **Step 1: a shift-invariant probability measure on `K`.** -/
theorem exists_shiftInvariant_on [Countable (unitRing F)] (K : Set (unitRing F → Fin 4)) (hne : K.Nonempty)
    (hcl : IsClosed K) (hmeas : MeasurableSet K) (hshift : ∀ y : unitRing F, ∀ c ∈ K, (fun x => c (x + y)) ∈ K) :
    ∃ μ : Measure (unitRing F → Fin 4), IsProbabilityMeasure μ ∧ μ Kᶜ = 0 ∧
      ∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ := by
  obtain ⟨c₀, hc₀⟩ := hne
  suffices h : ∃ Q : ProbabilityMeasure (unitRing F → Fin 4), (Q : Measure (unitRing F → Fin 4)) Kᶜ = 0 ∧
      ∀ y : unitRing F, (Q : Measure (unitRing F → Fin 4)).map (fun c x => c (x + y)) = Q by
    obtain ⟨Q, h1, h2⟩ := h
    exact ⟨Q, inferInstance, h1, h2⟩
  refine OneClass.exists_common_fixed (p := fun μ : Measure (unitRing F → Fin 4) => μ Kᶜ = 0)
    (g := fun (y : unitRing F) (c : unitRing F → Fin 4) (x : unitRing F) => c (x + y)) ?_
    ⟨⟨Measure.dirac c₀, inferInstance⟩, ?_⟩ (continuous_shiftCol F) ?_ ?_ ?_
  · -- the class is closed
    refine OneClass.isClosed_setOf_of_tendsto (p := fun μ : Measure (unitRing F → Fin 4) => μ Kᶜ = 0)
      fun L hL Q hQ h => ?_
    haveI := hL
    exact OneClass.measure_compl_eq_zero_of_tendsto hQ hcl h
  · -- the point mass at `c₀ ∈ K`
    show (Measure.dirac c₀) Kᶜ = 0
    rw [Measure.dirac_apply' _ hmeas.compl, Set.indicator_of_notMem (Set.notMem_compl_iff.2 hc₀)]
  · -- the shifts commute
    intro y z
    funext c x
    show c (x + y + z) = c (x + z + y)
    rw [add_right_comm]
  · -- the shifts keep the class
    intro y μ _ hμ
    exact map_compl_eq_zero F hmeas (continuous_shiftCol F y).measurable (hshift y) hμ
  · -- so do the averages
    intro s _ μ hμ
    exact avgMeasure_eq_zero s fun k hk => (hμ k hk).2

/-- **Step 2: rotation averages of a shift-invariant measure on `K`.** -/
theorem exists_rotInvariant_of_shiftInvariant [Countable (unitRing F)] (K : Set (unitRing F → Fin 4))
    (hcl : IsClosed K) (hmeas : MeasurableSet K)
    (hrot : ∀ u : unitVectors F, ∀ c ∈ K, (fun x => c (uvRing u * x)) ∈ K)
    (μ₀ : Measure (unitRing F → Fin 4)) (h₀ : IsProbabilityMeasure μ₀) (hK₀ : μ₀ Kᶜ = 0)
    (hs₀ : ∀ y : unitRing F, μ₀.map (fun c x => c (x + y)) = μ₀) :
    ∃ μ : Measure (unitRing F → Fin 4), IsProbabilityMeasure μ ∧ μ Kᶜ = 0 ∧
      (∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ) ∧
      ∀ u : unitVectors F, μ.map (fun c x => c (uvRing u * x)) = μ := by
  suffices h : ∃ Q : ProbabilityMeasure (unitRing F → Fin 4),
      ((Q : Measure (unitRing F → Fin 4)) Kᶜ = 0 ∧
        ∀ y : unitRing F, (Q : Measure (unitRing F → Fin 4)).map (fun c x => c (x + y)) = Q) ∧
      ∀ u : unitVectors F, (Q : Measure (unitRing F → Fin 4)).map (fun c x => c (uvRing u * x)) = Q by
    obtain ⟨Q, ⟨h1, h2⟩, h3⟩ := h
    exact ⟨Q, inferInstance, h1, h2, h3⟩
  -- `shift_y ∘ rot_u = rot_u ∘ shift_{u y}`
  have hsr : ∀ (y : unitRing F) (u : unitVectors F),
      ((fun (c : unitRing F → Fin 4) (x : unitRing F) => c (x + y)) ∘
        fun (c : unitRing F → Fin 4) (x : unitRing F) => c (uvRing u * x)) =
      (fun (c : unitRing F → Fin 4) (x : unitRing F) => c (uvRing u * x)) ∘
        fun (c : unitRing F → Fin 4) (x : unitRing F) => c (x + uvRing u * y) := by
    intro y u
    funext c x
    show c (uvRing u * (x + y)) = c (uvRing u * x + uvRing u * y)
    rw [mul_add]
  refine OneClass.exists_common_fixed
    (p := fun μ : Measure (unitRing F → Fin 4) => μ Kᶜ = 0 ∧
      ∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ)
    (g := fun (u : unitVectors F) (c : unitRing F → Fin 4) (x : unitRing F) => c (uvRing u * x)) ?_
    ⟨⟨μ₀, h₀⟩, hK₀, hs₀⟩ (continuous_rotCol F) ?_ ?_ ?_
  · -- the class is closed
    refine OneClass.isClosed_setOf_of_tendsto (p := fun μ : Measure (unitRing F → Fin 4) => μ Kᶜ = 0 ∧
      ∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ) fun L hL Q hQ h => ?_
    haveI := hL
    exact ⟨OneClass.measure_compl_eq_zero_of_tendsto hQ hcl (h.mono fun P hP => hP.1), fun y =>
      OneClass.map_eq_of_tendsto_of_eventually hQ (continuous_shiftCol F y) (h.mono fun P hP => hP.2 y)⟩
  · -- the rotations commute
    intro u v
    funext c x
    show c (uvRing v * (uvRing u * x)) = c (uvRing u * (uvRing v * x))
    rw [mul_left_comm]
  · -- the rotations keep the class
    intro u μ _ hμ
    refine ⟨map_compl_eq_zero F hmeas (continuous_rotCol F u).measurable (hrot u) hμ.1, fun y => ?_⟩
    rw [Measure.map_map (continuous_shiftCol F y).measurable (continuous_rotCol F u).measurable, hsr y u,
      ← Measure.map_map (continuous_rotCol F u).measurable (continuous_shiftCol F _).measurable, hμ.2]
  · -- so do the averages
    intro s _ μ hμ
    exact ⟨avgMeasure_eq_zero s fun k hk => (hμ k hk).2.1, fun y =>
      avgMeasure_map_eq s (continuous_shiftCol F y).measurable fun k hk => (hμ k hk).2.2 y⟩

/-- **The invariant measure on a closed invariant set** (`[Kakutani1938]`'s conclusion, by averaging), for every subfield
whose unit-vector ring is countable — every number field (`SpectralChain.countable_unitRing`). -/
theorem invariantMeasureOnClosed_of_countable [Countable (unitRing F)] : InvariantMeasureOnClosed F := by
  intro K hne hcl hmeas hshift hrot
  obtain ⟨μ₀, h₀, hK₀, hs₀⟩ := exists_shiftInvariant_on F K hne hcl hmeas hshift
  exact exists_rotInvariant_of_shiftInvariant F K hcl hmeas hrot μ₀ h₀ hK₀ hs₀

end

end HadwigerNelson.Rigidity
