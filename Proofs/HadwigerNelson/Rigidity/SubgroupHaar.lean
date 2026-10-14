import Proofs.HadwigerNelson.Rigidity.Annihilator

/-!
# The Haar measure of a compact subgroup of the dual, and its Fourier coefficients (FS-131, job FS131-KPD1; skeleton)

**Read aloud, against the informal claim.** For a countable abelian group `G` and a compact subgroup `Y` of `Ĝ = AddChar G
Circle` (pointwise topology, `Rigidity/DualGroup`), `subgroupHaar Y` is Haar measure of `Y` (Mathlib's `haarMeasure ⊤`, a
probability) carried into `Ĝ` by the inclusion. Its Fourier coefficients are the indicator of the annihilator:

* `∫ χ(g) d(subgroupHaar Y) = 1` for `g ∈ Y^⊥` (the integrand is `1` on `Y`; `integral_subgroupHaar_of_mem`);
* `= 0` for `g ∉ Y^⊥`: some `y₀ ∈ Y` has `y₀(g) ≠ 1`, and left invariance on `Y` gives `I = y₀(g) · I`
  (`integral_subgroupHaar_of_not_mem`) — the computation `Rigidity.isHaarFourier_dualHaar` makes at `Y = Ĝ`.

It lives on `Y` (`subgroupHaar_compl`: the complement is null) and charges every open set meeting `Y` (`subgroupHaar_pos`:
Haar measure is positive on non-empty open sets of `Y`). These four facts are all Pontryagin duality reads of it
(`Rigidity/Duality`).

**Compactness is an instance argument**, `[CompactSpace Y]`, with `Y : Subgroup (AddChar G Circle)`: a closed `Y` gives it by
`isCompact_iff_compactSpace.mp hY.isCompact`. Mathlib's `ClosedSubgroup` is not used: at the pin `IsTopologicalGroup ↥Y` is not
synthesized for `Y : ClosedSubgroup _` (`data/fs131/kpd1/probes/Names.lean`, first run).

**Models.** `Y = ⊥`, the trivial subgroup (finite, so compact): `subgroupHaar ⊥` is the point mass at the trivial character
(`subgroupHaar_bot`, the spec theorem, which fails if `subgroupHaar` drifts off a probability or off `Y`).
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory Topology

noncomputable section

variable {G : Type*} [AddCommGroup G] [Countable G]

/-- **The Haar probability of a compact subgroup `Y` of the dual, carried into the dual.** -/
def subgroupHaar (Y : Subgroup (AddChar G Circle)) [CompactSpace Y] : Measure (AddChar G Circle) :=
  (Measure.haarMeasure ⊤ : Measure Y).map Subtype.val

variable (Y : Subgroup (AddChar G Circle)) [CompactSpace Y]

instance isProbabilityMeasure_subgroupHaar : IsProbabilityMeasure (subgroupHaar Y) := by
  sorry

/-- **It lives on `Y`.** -/
theorem subgroupHaar_compl : subgroupHaar Y (Y : Set (AddChar G Circle))ᶜ = 0 := by
  sorry

/-- **It charges every open set that meets `Y`**: Haar measure on `Y` is positive on non-empty open sets. -/
theorem subgroupHaar_pos {U : Set (AddChar G Circle)} (hU : IsOpen U) (hne : (U ∩ Y).Nonempty) :
    0 < subgroupHaar Y U := by
  sorry

variable {Y}

/-- **The coefficient at a point of `Y^⊥` is `1`.** -/
theorem integral_subgroupHaar_of_mem {g : G} (hg : g ∈ dualCoannihilator Y) :
    ∫ χ, (χ g : ℂ) ∂(subgroupHaar Y) = 1 := by
  sorry

/-- **The coefficient off `Y^⊥` is `0`**: left invariance on `Y` against a `y₀ ∈ Y` with `y₀ g ≠ 1`. -/
theorem integral_subgroupHaar_of_not_mem {g : G} (hg : g ∉ dualCoannihilator Y) :
    ∫ χ, (χ g : ℂ) ∂(subgroupHaar Y) = 0 := by
  sorry

/-- **Two compact subgroups with one annihilator have one Fourier transform** — the step Pontryagin duality reads. -/
theorem integral_subgroupHaar_eq {Y Z : Subgroup (AddChar G Circle)} [CompactSpace Y] [CompactSpace Z]
    (h : dualCoannihilator Y = dualCoannihilator Z) (g : G) :
    ∫ χ, (χ g : ℂ) ∂(subgroupHaar Y) = ∫ χ, (χ g : ℂ) ∂(subgroupHaar Z) := by
  by_cases hg : g ∈ dualCoannihilator Y
  · rw [integral_subgroupHaar_of_mem hg, integral_subgroupHaar_of_mem (h ▸ hg)]
  · rw [integral_subgroupHaar_of_not_mem hg, integral_subgroupHaar_of_not_mem (h ▸ hg)]

variable (G)

/-- Spec: **the Haar measure of the trivial subgroup is the point mass at the trivial character.** -/
theorem subgroupHaar_bot : subgroupHaar (⊥ : Subgroup (AddChar G Circle)) = Measure.dirac 1 := by
  sorry

end

end HadwigerNelson.Rigidity
