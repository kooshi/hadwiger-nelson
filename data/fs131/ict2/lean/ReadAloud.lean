import Proofs.HadwigerNelson.CayleyThree.Density
/-!
FS131-ICT2 — the head statements of the three-colour landing as the kernel stores them (`#check @`), with their axioms
(`#print axioms`), and the inhabitants the module docstrings name for each structure hypothesis, for the read-aloud
against `LEDGER.md` row 79 (`plans/FS131-ICT2-three-colour.md`). Imports only `CayleyThree/Density` (its closure is the
three modules' own). Run from the worktree's root: `lake env lean data/fs131/ict2/lean/ReadAloud.lean > data/fs131/ict2/read-aloud.txt`.
-/

open HadwigerNelson HadwigerNelson.CayleyThree

-- the head statements (FS131-ICT1's record, "Theorems this phase proved")
#check @colorable_three_iff_bandSet_nonempty
#print axioms colorable_three_iff_bandSet_nonempty
#check @exists_torsion_mem_bandSet
#print axioms exists_torsion_mem_bandSet
#check @finiteIndex_ker_of_nsmul_eq_zero
#print axioms finiteIndex_ker_of_nsmul_eq_zero
#check @colorable_three_iff_exists_isPeriodic
#print axioms colorable_three_iff_exists_isPeriodic
#check @colorable_three_rat
#print axioms colorable_three_rat
#check @not_isPeriodic_rat
#print axioms not_isPeriodic_rat
#check @colorable_three_iff_of_fg_torsionFree
#print axioms colorable_three_iff_of_fg_torsionFree
#check @exists_affine_of_forall_three_nsmul
#print axioms exists_affine_of_forall_three_nsmul
#check @exists_isPeriodic_eqOn
#print axioms exists_isPeriodic_eqOn
#check @coloring_mem_closure_isPeriodic
#print axioms coloring_mem_closure_isPeriodic
#check @periodicForcedSubgroup_three_eq_forcedSubgroup
#print axioms periodicForcedSubgroup_three_eq_forcedSubgroup
#check @inheritanceQuestion_three
#print axioms inheritanceQuestion_three
#check @forcedSubgroup_finiteIndex_iff_finite
#print axioms forcedSubgroup_finiteIndex_iff_finite
#check @exists_isPeriodic_eqOn_of_fg_torsionFree
#print axioms exists_isPeriodic_eqOn_of_fg_torsionFree
#check @mcshane_model
#print axioms mcshane_model

-- the definitions the head statements read (upstream: `Kempe`, `Arith/ThreeColourCharacter`, `ThreeColour`)
#print HadwigerNelson.IsPeriodic
#print HadwigerNelson.ThreeColourCharacter.bandSet
#print HadwigerNelson.ThreeColourCharacter.band
#print HadwigerNelson.periodicForcedSubgroup
#print HadwigerNelson.forcedSubgroup
#print HadwigerNelson.InheritanceQuestion

-- the inhabitants named for each structure hypothesis
#check @HadwigerNelson.ThreeColour.properAlong_one_two
#check @HadwigerNelson.ThreeColour.nonempty_winding_one_two
#check @isTight_one_two
#check @coloringOneTwo
#print axioms isTight_one_two
#print axioms coloringOneTwo
