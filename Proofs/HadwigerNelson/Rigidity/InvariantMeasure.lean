import Proofs.HadwigerNelson.Rigidity.Herglotz

/-!
# The invariant measure on a closed invariant set of colourings (FS-131, job FS131-KR1; module M3; skeleton)

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

variable (F : Subfield ℝ)

/-- **Step 1: a shift-invariant probability measure on `K`.** -/
theorem exists_shiftInvariant_on [Countable (unitRing F)] (K : Set (unitRing F → Fin 4)) (hne : K.Nonempty)
    (hcl : IsClosed K) (hmeas : MeasurableSet K) (hshift : ∀ y : unitRing F, ∀ c ∈ K, (fun x => c (x + y)) ∈ K) :
    ∃ μ : Measure (unitRing F → Fin 4), IsProbabilityMeasure μ ∧ μ Kᶜ = 0 ∧
      ∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ := by
  sorry

/-- **Step 2: rotation averages of a shift-invariant measure on `K`.** -/
theorem exists_rotInvariant_of_shiftInvariant [Countable (unitRing F)] (K : Set (unitRing F → Fin 4))
    (hcl : IsClosed K) (hmeas : MeasurableSet K)
    (hrot : ∀ u : unitVectors F, ∀ c ∈ K, (fun x => c (uvRing u * x)) ∈ K)
    (μ₀ : Measure (unitRing F → Fin 4)) (h₀ : IsProbabilityMeasure μ₀) (hK₀ : μ₀ Kᶜ = 0)
    (hs₀ : ∀ y : unitRing F, μ₀.map (fun c x => c (x + y)) = μ₀) :
    ∃ μ : Measure (unitRing F → Fin 4), IsProbabilityMeasure μ ∧ μ Kᶜ = 0 ∧
      (∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ) ∧
      ∀ u : unitVectors F, μ.map (fun c x => c (uvRing u * x)) = μ := by
  sorry

/-- **The invariant measure on a closed invariant set** (`[Kakutani1938]`'s conclusion, by averaging), for every subfield
whose unit-vector ring is countable — every number field (`SpectralChain.countable_unitRing`). -/
theorem invariantMeasureOnClosed_of_countable [Countable (unitRing F)] : InvariantMeasureOnClosed F := by
  intro K hne hcl hmeas hshift hrot
  obtain ⟨μ₀, h₀, hK₀, hs₀⟩ := exists_shiftInvariant_on F K hne hcl hmeas hshift
  exact exists_rotInvariant_of_shiftInvariant F K hcl hmeas hrot μ₀ h₀ hK₀ hs₀

end

end HadwigerNelson.Rigidity
