import Proofs.HadwigerNelson.Rigidity.Pieces
import Mathlib.Topology.Algebra.Group.ClosedSubgroup
import Mathlib.Topology.Algebra.ClopenNhdofOne
import Mathlib.Algebra.Category.Grp.Injective
import Mathlib.Analysis.Fourier.FiniteAbelian.Orthogonality

-- FS131-KPD1 probe 1: the route's Mathlib names at the pin, and the instances the Haar route needs on a closed subgroup
-- of the dual under the scoped pointwise topology.

open MeasureTheory HadwigerNelson HadwigerNelson.Rigidity Topology

#check @MeasureTheory.ext_of_forall_mem_subalgebra_integral_eq_of_polish
#check @MeasureTheory.Measure.haarMeasure
#check @MeasureTheory.integral_mul_left_eq_self
#check @MeasureTheory.Measure.IsOpenPosMeasure.open_pos
#check @ClosedSubgroup
#check @IsTopologicalGroup.exist_openSubgroup_sub_clopen_nhds_of_one
#check @Subgroup.quotient_finite_of_isOpen'
#check @Module.Baer.of_divisible
#check @Module.Baer.extension_property_addMonoidHom
#check @AddCircle.injective_toCircle
#check @AddCircle.homeomorphCircle
#check @connectedSpace_iff_clopen
#check @AddChar.instFintype
#check @AddSubgroup.toSubgroup'
#check @Int.subgroup_cyclic
#check @PontryaginDual
#check @Subtype.borelSpace
#check @Measure.map_apply
#check @HadwigerNelson.Rigidity.exists_apply_ne_one
#check @HadwigerNelson.Rigidity.measure_eq_of_fourier
#check @HadwigerNelson.Rigidity.isHaarFourier_iff
#check @HadwigerNelson.Rigidity.continuous_evalChar
#check @CharacterModule.dual_surjective_of_injective
#check @Module.free_of_finite_type_torsion_free'

section
variable (G : Type) [AddCommGroup G] [Countable G]

-- the ambient instances (scoped)
example : CompactSpace (AddChar G Circle) := inferInstance
example : IsTopologicalGroup (AddChar G Circle) := inferInstance
example : BorelSpace (AddChar G Circle) := inferInstance
example : PolishSpace (AddChar G Circle) := inferInstance

variable (Y : Subgroup (AddChar G Circle)) [CompactSpace Y]
example (Z : Subgroup (AddChar G Circle)) (hZ : IsClosed (Z : Set (AddChar G Circle))) : CompactSpace Z :=
  isCompact_iff_compactSpace.mp hZ.isCompact
example : IsTopologicalGroup Y := inferInstance
example : T2Space Y := inferInstance
example : BorelSpace Y := inferInstance
example : LocallyCompactSpace Y := inferInstance

noncomputable def probeHaar : Measure Y := Measure.haarMeasure ⊤
example : IsProbabilityMeasure (probeHaar G Y) := by
  unfold probeHaar
  exact ⟨by simpa using Measure.haarMeasure_self (G := Y) (K₀ := ⊤)⟩
example : (probeHaar G Y).IsHaarMeasure := by unfold probeHaar; infer_instance
example : (probeHaar G Y).IsOpenPosMeasure := by unfold probeHaar; infer_instance
example : (probeHaar G Y).IsMulLeftInvariant := by unfold probeHaar; infer_instance
example : Measurable (Subtype.val : Y → AddChar G Circle) := measurable_subtype_coe
example : Continuous (Subtype.val : Y → AddChar G Circle) := continuous_subtype_val

-- the pontryagin dual of the dual elaborates
noncomputable example : CommGroup (PontryaginDual (AddChar G Circle)) := inferInstance
example (g : G) : Continuous fun χ : AddChar G Circle => χ g :=
  Continuous.subtype_mk (continuous_evalChar G g) _

-- the quotient of G by an additive subgroup carries characters (DualGroup's separation applies)
example (N : AddSubgroup G) {r : G ⧸ N} (hr : r ≠ 0) : ∃ ψ : AddChar (G ⧸ N) Circle, ψ r ≠ 1 :=
  exists_apply_ne_one hr
end

-- the consumer's types (Pieces): PieceDual M unfolds to Additive (AddChar M Circle)
section
variable (M : Type) [AddCommGroup M] [Countable M]
noncomputable example (Y : AddSubgroup (PieceDual M)) : Subgroup (AddChar M Circle) := AddSubgroup.toSubgroup' Y
example (Y : AddSubgroup (PieceDual M)) (hY : IsClosed (Y : Set (PieceDual M))) :
    IsClosed ((AddSubgroup.toSubgroup' Y : Subgroup (AddChar M Circle)) : Set (AddChar M Circle)) := hY
example : PontryaginDual (Multiplicative (PieceDual M)) = PontryaginDual (Multiplicative (Additive (AddChar M Circle))) := rfl
example : ConnectedSpace (AddChar M Circle) → ConnectedSpace (PieceDual M) := fun h => h
end

-- invariance integral on the subgroup's Haar
example (G : Type) [AddCommGroup G] [Countable G] (Y : Subgroup (AddChar G Circle)) [CompactSpace Y] (g : G) (y₀ : Y) :
    ∫ y, ((y₀ * y : Y) : AddChar G Circle) g * (1 : ℂ) ∂(Measure.haarMeasure ⊤ : Measure Y) =
      ∫ y, ((y : Y) : AddChar G Circle) g * (1 : ℂ) ∂(Measure.haarMeasure ⊤ : Measure Y) :=
  integral_mul_left_eq_self (fun y : Y => ((y : Y) : AddChar G Circle) g * (1 : ℂ)) y₀
