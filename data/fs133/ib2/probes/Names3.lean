import Proofs.HadwigerNelson.Plane.OneClass.Defs
open MeasureTheory Filter Set
open scoped ENNReal Topology
open HadwigerNelson.Outside.OAI158.Spectral
#check @Fin.pos
#check @Fin.size_pos
#check @SimpleGraph.Coloring.valid
#check @ae_eq_set_inter
#check @MeasurableSet.nullMeasurableSet
#check @Set.Pairwise.mono
#check @ciInf_const
#check @Finset.card_eq_one
#check @Filter.eventually_pure
#check @Finset.mul_sum
#check @Polynomial.coeff_eq_zero_of_natDegree_lt
#check @Function.Injective.countable
#check @Set.Countable.to_subtype
#check @Set.Countable.mono
#check @Finset.coe_sort_coe
example (S : Finset ℂ) : Fintype.card ↥(S : Set ℂ) = S.card := by simp
example (S : Finset ℂ) : Fintype ↥(S : Set ℂ) := inferInstance
example (a b : E) : dist a b = dist (a : ℂ) (b : ℂ) := rfl
example (a b : E) : dist a b = dist (a : ℂ) (b : ℂ) := Subtype.dist_eq a b
