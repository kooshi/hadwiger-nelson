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
  haveI : IsProbabilityMeasure (Measure.haarMeasure ⊤ : Measure Y) :=
    ⟨by simpa using Measure.haarMeasure_self (G := Y) (K₀ := ⊤)⟩
  exact Measure.isProbabilityMeasure_map measurable_subtype_coe.aemeasurable

/-- **It lives on `Y`.** -/
theorem subgroupHaar_compl : subgroupHaar Y (Y : Set (AddChar G Circle))ᶜ = 0 := by
  have hc : IsClosed (Y : Set (AddChar G Circle)) := by
    have h := isCompact_range (continuous_subtype_val (p := fun x => x ∈ Y))
    rw [Subtype.range_coe] at h
    exact h.isClosed
  unfold subgroupHaar
  rw [Measure.map_apply measurable_subtype_coe hc.measurableSet.compl]
  have : (Subtype.val ⁻¹' (Y : Set (AddChar G Circle))ᶜ : Set Y) = ∅ := by
    ext y
    simp
  rw [this, measure_empty]

/-- **It charges every open set that meets `Y`**: Haar measure on `Y` is positive on non-empty open sets. -/
theorem subgroupHaar_pos {U : Set (AddChar G Circle)} (hU : IsOpen U) (hne : (U ∩ Y).Nonempty) :
    0 < subgroupHaar Y U := by
  unfold subgroupHaar
  rw [Measure.map_apply measurable_subtype_coe hU.measurableSet]
  obtain ⟨χ, hχU, hχY⟩ := hne
  exact (hU.preimage continuous_subtype_val).measure_pos (Measure.haarMeasure ⊤) ⟨⟨χ, hχY⟩, hχU⟩

variable {Y}

/-- **The coefficient at a point of `Y^⊥` is `1`.** -/
theorem integral_subgroupHaar_of_mem {g : G} (hg : g ∈ dualCoannihilator Y) :
    ∫ χ, (χ g : ℂ) ∂(subgroupHaar Y) = 1 := by
  haveI : IsProbabilityMeasure (Measure.haarMeasure ⊤ : Measure Y) :=
    ⟨by simpa using Measure.haarMeasure_self (G := Y) (K₀ := ⊤)⟩
  unfold subgroupHaar
  rw [integral_map measurable_subtype_coe.aemeasurable (continuous_evalChar G g).aestronglyMeasurable]
  have h1 : ∀ y : Y, ((y : AddChar G Circle) g : ℂ) = 1 := fun y => by rw [hg y y.2, Circle.coe_one]
  simp only [h1, integral_const, probReal_univ, one_smul]

/-- **The coefficient off `Y^⊥` is `0`**: left invariance on `Y` against a `y₀ ∈ Y` with `y₀ g ≠ 1`. -/
theorem integral_subgroupHaar_of_not_mem {g : G} (hg : g ∉ dualCoannihilator Y) :
    ∫ χ, (χ g : ℂ) ∂(subgroupHaar Y) = 0 := by
  obtain ⟨χ₀, hχ₀Y, hχ₀⟩ : ∃ χ₀ ∈ Y, χ₀ g ≠ 1 := by
    simpa only [mem_dualCoannihilator, not_forall, exists_prop] using hg
  unfold subgroupHaar
  rw [integral_map measurable_subtype_coe.aemeasurable (continuous_evalChar G g).aestronglyMeasurable]
  set I := ∫ y : Y, ((y : AddChar G Circle) g : ℂ) ∂(Measure.haarMeasure ⊤ : Measure Y) with hI
  have hinv := integral_mul_left_eq_self (μ := (Measure.haarMeasure ⊤ : Measure Y))
    (fun y : Y => ((y : AddChar G Circle) g : ℂ)) ⟨χ₀, hχ₀Y⟩
  have hmul : ∀ y : Y, (((⟨χ₀, hχ₀Y⟩ * y : Y) : AddChar G Circle) g : ℂ) =
      (χ₀ g : ℂ) * ((y : AddChar G Circle) g : ℂ) := fun y => by
    rw [Subgroup.coe_mul, AddChar.mul_apply, Circle.coe_mul]
  simp only [hmul, integral_const_mul] at hinv
  have hne : (χ₀ g : ℂ) ≠ 1 := fun h => hχ₀ (Circle.ext (by rw [h, Circle.coe_one]))
  have h0 : ((χ₀ g : ℂ) - 1) * I = 0 := by rw [sub_mul, hinv, one_mul, sub_self]
  exact (mul_eq_zero.mp h0).resolve_left (sub_ne_zero.mpr hne)

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
  haveI : IsProbabilityMeasure (Measure.haarMeasure ⊤ : Measure (⊥ : Subgroup (AddChar G Circle))) :=
    ⟨by simpa using Measure.haarMeasure_self (G := (⊥ : Subgroup (AddChar G Circle))) (K₀ := ⊤)⟩
  ext s hs
  rw [subgroupHaar, Measure.map_apply measurable_subtype_coe hs, Measure.dirac_apply' _ hs]
  have hval : ∀ y : (⊥ : Subgroup (AddChar G Circle)), (y : AddChar G Circle) = 1 := fun y =>
    Subgroup.mem_bot.mp y.2
  by_cases h1 : (1 : AddChar G Circle) ∈ s
  · have hpre : (Subtype.val ⁻¹' s : Set (⊥ : Subgroup (AddChar G Circle))) = Set.univ :=
      Set.eq_univ_of_forall fun y => by
        rw [Set.mem_preimage, hval y]
        exact h1
    rw [hpre, measure_univ, Set.indicator_of_mem h1, Pi.one_apply]
  · have hpre : (Subtype.val ⁻¹' s : Set (⊥ : Subgroup (AddChar G Circle))) = ∅ :=
      Set.eq_empty_of_forall_notMem fun y => by
        rw [Set.mem_preimage, hval y]
        exact h1
    rw [hpre, measure_empty, Set.indicator_of_notMem h1]

end

end HadwigerNelson.Rigidity
