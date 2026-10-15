import Proofs.HadwigerNelson.Rigidity.ContinuityGroup
import Proofs.HadwigerNelson.Rigidity.Herglotz
import Mathlib.Analysis.Fourier.FiniteAbelian.PontryaginDuality
import Mathlib.Algebra.Order.Chebyshev
open MeasureTheory Filter Topology
namespace HadwigerNelson.Rigidity
open SpectralChain SpectralInputs NumberField
#check @integral_finsetSum
#check @mul_meas_ge_le_integral_of_nonneg
#check @Complex.exp_ofReal_mul_I_re
#check @Complex.norm_exp_ofReal_mul_I
#check @Complex.exp_nat_mul
#check @pi_norm_le_iff_of_nonneg
#check @BoundedContinuousFunction.ofNormedAddCommGroup
#check @ENNReal.tendsto_nhds_zero
#check @isProbabilityMeasure_map
#check @integral_smul_measure
#check @Rat.mul_den_eq_num
#check @Finset.dvd_prod_of_mem
#check @UpperHalf.mem_localRing
#check @mem_stableIntegers
#check @Module.Basis.repr_self
#check @Module.Basis.sum_repr
#check @UnitRing.coe_mem_unitRingOver_iff
#check @measurableSet_lt
#check @Complex.measurable_arg
#check @Ultrafilter.coe_map
#check @tendsto_nhds_unique
#check @MeasureTheory.measureReal_mono
example (ι : Type) [Fintype ι] : ProperSpace (ι → ℝ) := inferInstance
variable (F : Subfield ℝ) [NumberField F]
example : T2Space (Dual F) := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  infer_instance
example : BorelSpace (Dual F) := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  infer_instance
example (r : unitRing F) : archHom F r = NumberField.mixedEmbedding (fieldI F) ((toFieldI F) r) := rfl
end HadwigerNelson.Rigidity
