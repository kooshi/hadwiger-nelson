import Proofs.HadwigerNelson.Arith.SpectralInputs

/-!
# SI-4's equivariance clause at the factor σ-algebra (FS-131 wave 10, second planning pass; J45-SI-4, J45-N2)

**Read aloud, against the informal claim.** `SpectralInputs.si4_equivariant` asks a measure-preserving map `S` with
`S⁻¹𝒜 = 𝒜`, an equality. J45's `𝒜_S` is the factor of a filter, `factorSigma T hT l`, and
`measurableSet_preimage_factorSigma` gives only `(T x)⁻¹𝒜 ⊆ 𝒜`. The other inclusion is **not** a consequence of the maps
commuting and preserving `μ` (FS131-I10A's finding 3; for the one-sided shift on fair bits and `𝒜 = σ(ω₁, ω₂, …)` the
conditional expectation does not commute with the shift): it holds **when `T x` has a left inverse in the family** — an
action by bijections, which the shift of a random colouring by a group is.

* `comap_factorSigma_eq`: `(T x)⁻¹𝒜_l = 𝒜_l` when the maps commute and `T x' ∘ T x = id` for some `x'`.
* `comap_factorSigma_eq_of_action`: the same for an action of an additive group (`T (x + y) = T x ∘ T y`, `T 0 = id`).
* `si4_equivariant_factorSigma`: J45-SI-4's "equivariant" at `𝒜 = 𝒜_l` — almost surely the conditional supports given
  the factor move with the action, `M(T_x ω)(v) = M(ω)(π v)` for every vertex `v`.

**Inhabitant.** The identity family (`T y = id`) satisfies every hypothesis; the spec example below runs it.
-/

namespace HadwigerNelson.SpectralInputs

open MeasureTheory

variable {R Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}

/-- **The factor σ-algebra is invariant, with equality, under a map of the family that has a left inverse in the family.**
`measurableSet_preimage_factorSigma` is `⊆`; a left inverse `T x'` of `T x` gives `A = (T x)⁻¹((T x')⁻¹ A)`. -/
theorem comap_factorSigma_eq [IsProbabilityMeasure μ] (T : R → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ)
    (hcomm : ∀ x y, T x ∘ T y = T y ∘ T x) (l : Filter R) {x x' : R} (hinv : T x' ∘ T x = id) :
    (factorSigma T hT l).comap (T x) = factorSigma T hT l := by
  refine le_antisymm ?_ ?_
  · intro A hA
    obtain ⟨B, hB, rfl⟩ := MeasurableSpace.measurableSet_comap.mp hA
    exact measurableSet_preimage_factorSigma T hT hcomm l x hB
  · intro A hA
    refine MeasurableSpace.measurableSet_comap.mpr
      ⟨T x' ⁻¹' A, measurableSet_preimage_factorSigma T hT hcomm l x' hA, ?_⟩
    rw [← Set.preimage_comp, hinv, Set.preimage_id]

/-- The same for an action of an additive commutative group: `T (x + y) = T x ∘ T y` and `T 0 = id`. -/
theorem comap_factorSigma_eq_of_action [AddCommGroup R] [IsProbabilityMeasure μ] (T : R → Ω → Ω)
    (hT : ∀ y, MeasurePreserving (T y) μ μ) (hadd : ∀ x y, T (x + y) = T x ∘ T y) (h0 : T 0 = id) (l : Filter R)
    (x : R) : (factorSigma T hT l).comap (T x) = factorSigma T hT l :=
  comap_factorSigma_eq T hT (fun x y => by rw [← hadd, ← hadd, add_comm]) l
    (x' := -x) (by rw [← hadd, neg_add_cancel, h0])

/-- **J45-SI-4's equivariance clause at the factor σ-algebra**: for a commuting family of measure-preserving maps, a map
`T x` of the family with a left inverse in the family, and a random colouring that `T x` moves by a map `π` of the vertices,
almost surely `M(T_x ω)(v) = M(ω)(π v)` for every `v`, where `M` is the conditional support given `𝒜_l`. -/
theorem si4_equivariant_factorSigma {V : Type*} [Countable V] [IsProbabilityMeasure μ] (T : R → Ω → Ω)
    (hT : ∀ y, MeasurePreserving (T y) μ μ) (hcomm : ∀ x y, T x ∘ T y = T y ∘ T x) (l : Filter R)
    (c : Ω → V → Fin 4) (hc : ∀ v, Measurable fun ω => c ω v) {x x' : R} (hinv : T x' ∘ T x = id) (π : V → V)
    (hπ : ∀ ω v, c (T x ω) v = c ω (π v)) :
    ∀ᵐ ω ∂μ, ∀ v, condSupport (factorSigma T hT l) μ c (T x ω) v = condSupport (factorSigma T hT l) μ c ω (π v) :=
  si4_equivariant (factorSigma T hT l) μ (factorSigma_le T hT l) c hc (hT x) (comap_factorSigma_eq T hT hcomm l hinv) π hπ

/-! ## Spec -/

-- the identity family is a model of every hypothesis of `si4_equivariant_factorSigma`.
example {V : Type*} [Countable V] [IsProbabilityMeasure μ] (l : Filter R) (c : Ω → V → Fin 4)
    (hc : ∀ v, Measurable fun ω => c ω v) (x : R) :
    ∀ᵐ ω ∂μ, ∀ v, condSupport (factorSigma (μ := μ) (fun _ : R => id) (fun _ => MeasurePreserving.id μ) l) μ c ω v =
      condSupport (factorSigma (μ := μ) (fun _ : R => id) (fun _ => MeasurePreserving.id μ) l) μ c ω v :=
  si4_equivariant_factorSigma (fun _ : R => id) (fun _ => MeasurePreserving.id μ) (fun _ _ => rfl) l c hc
    (x := x) (x' := x) rfl id fun _ _ => rfl

-- `comap_factorSigma_eq` at the identity family: the comap along `id` is the σ-algebra itself.
example [IsProbabilityMeasure μ] (l : Filter R) (x : R) :
    (factorSigma (μ := μ) (fun _ : R => id) (fun _ => MeasurePreserving.id μ) l).comap id =
      factorSigma (μ := μ) (fun _ : R => id) (fun _ => MeasurePreserving.id μ) l :=
  comap_factorSigma_eq (fun _ : R => id) (fun _ => MeasurePreserving.id μ) (fun _ _ => rfl) l (x := x) (x' := x) rfl

end HadwigerNelson.SpectralInputs
