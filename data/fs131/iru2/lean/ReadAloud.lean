import Proofs.HadwigerNelson.Instances.UnitRingModels
/-!
FS131-IRU2 (a copy of FS131-IRU1's read-aloud, its run line changed) — the head statements of the ring of unit vectors as the kernel stores them (`#check @`), with their axioms
(`#print axioms`), and the models the modules name, for the read-aloud against `LEDGER.md` row 100, the roadmap's typed form
and the asking lane's C8 (`plans/FS131-IRU1-ring.md`). Imports only `Instances/UnitRingModels`, whose closure holds the five
modules. Run from the worktree's root: `lake env lean data/fs131/iru2/lean/ReadAloud.lean > data/fs131/iru2/readaloud.txt`, on the merged build.
-/

open HadwigerNelson HadwigerNelson.Rigidity

set_option pp.fullNames true

-- the head statements
#check @unitRing_eq_stableIntegers
#print axioms unitRing_eq_stableIntegers
#check @exists_two_pow_mul_mem_unitRing
#print axioms exists_two_pow_mul_mem_unitRing
#check @exists_eq_add_mul_of_mem_stableIntegers
#print axioms exists_eq_add_mul_of_mem_stableIntegers
#check @resPi_surjective
#print axioms resPi_surjective
#check @closure_normOne_eq_top
#print axioms closure_normOne_eq_top
#check @exists_isUsablePrime
#print axioms exists_isUsablePrime
#check @nonempty_stablePrime
#print axioms nonempty_stablePrime
#check @localBound_lt_top
#print axioms localBound_lt_top
#check @reachable_iff_sub_mem_unitRingOver
#print axioms reachable_iff_sub_mem_unitRingOver
#check @connected_or_infinite_planeOver
#print axioms connected_or_infinite_planeOver
#check @connected_planeOver_iff_isEmpty_stablePrime
#print axioms connected_planeOver_iff_isEmpty_stablePrime
#check @infinite_connectedComponent_planeOver
#print axioms infinite_connectedComponent_planeOver
#check @not_connected_planeOver
#print axioms not_connected_planeOver
-- the ruled drop
#check @not_isRamified_of_odd_mem
#print axioms not_isRamified_of_odd_mem
-- the models
#check @exists_model_galoisField
#print axioms exists_model_galoisField
#check @UnitRingModels.noRamifiedStableDyadic_sqrt47
#print axioms UnitRingModels.noRamifiedStableDyadic_sqrt47
#check @UnitRingModels.unitRing_eq_stableIntegers_sqrt47
#print axioms UnitRingModels.unitRing_eq_stableIntegers_sqrt47
#check @UnitRingModels.stableIntegers_sqrt47_ne_top
#print axioms UnitRingModels.stableIntegers_sqrt47_ne_top
#check @UnitRingModels.exists_stablePrime_three_not_isRamified
#print axioms UnitRingModels.exists_stablePrime_three_not_isRamified
-- the definitions the statements use, unfolded one step
#print NoRamifiedStableDyadic
#print IsRamified
#print IsDyadic
#print stableIntegers
#print HadwigerNelson.UnitRing.unitRing
#print HadwigerNelson.UnitRing.unitRingOver
#print HadwigerNelson.SpectralChain.StablePrime
#print HadwigerNelson.SpectralChain.localBound
#print HadwigerNelson.Arith.IsUsablePrime
