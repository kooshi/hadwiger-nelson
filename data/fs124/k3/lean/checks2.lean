import Proofs.HadwigerNelson.Plane.ValidMap.MapTopology
import Mathlib.Topology.UnitInterval
import Mathlib.Data.Fin.Tuple.Sort
open Set Topology
-- does the order-connectedness of an interval of `unitInterval` come by instance?
example (s t : unitInterval) : IsPreconnected (Icc s t) := isPreconnected_Icc
example (s t : unitInterval) : IsCompact (Icc s t) := isCompact_Icc
example : ∀ i j : Fin 3, i ≠ j → ∃ k, k ≠ i ∧ k ≠ j := by decide
example : ∀ a b c : Fin 3, a ≠ b → b ≠ c → c ≠ a → ∀ j, j = a ∨ j = b ∨ j = c := by decide
#check @Tuple.monotone_sort
#check @Equiv.ofBijective
#check @convex_halfSpace_re_le
#check @IsOpen.inter_closure
#check @isClosed_iUnion_of_finite
#check @HadwigerNelson.Plane.e_add_two_pi
