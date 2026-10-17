import Proofs.HadwigerNelson.RationalFour.Forbid
/-!
FS131-IRF1 (after FS131-IRU2's read-aloud) — the head statements of rational four-space as the kernel stores them (`#check @`),
with their axioms (`#print axioms`), and the models the modules name, for the read-aloud against `CLOSED-QUESTIONS.md` § 3's
`ℚ⁴` entry and `[Johnson2006]` p. 212's question (`plans/FS131-IRF1-four-space.md`). Imports only `RationalFour/Forbid`, whose
closure holds the four modules. Run from the worktree's root: `lake env lean data/fs131/irf1/lean/ReadAloud.lean >
data/fs131/irf1/readaloud.txt`, on the gated build.
-/

open HadwigerNelson HadwigerNelson.RationalFour

set_option pp.fullNames true

#check @forall_coloring_eq_iff
#print axioms forall_coloring_eq_iff
#check @forall_coloring_ne_iff
#print axioms forall_coloring_ne_iff
#check @exists_coloring_eq_and_ne_iff
#print axioms exists_coloring_eq_and_ne_iff
#check @coloring_eq_of_one_le_padicValRat
#print axioms coloring_eq_of_one_le_padicValRat
#check @coloring_ne_of_padicValRat_eq_zero
#print axioms coloring_ne_of_padicValRat_eq_zero
#check @exists_coloring_forbidding_iff
#print axioms exists_coloring_forbidding_iff
#check @exists_coloring_forbidding_iff_padicValRat
#print axioms exists_coloring_forbidding_iff_padicValRat
#check @coloring_forbids_of_odd
#print axioms coloring_forbids_of_odd
#check @exists_equiv_coloring_add_eq_residue
#print axioms exists_equiv_coloring_add_eq_residue
#check @coloring_eq_of_forall_tetra
#print axioms coloring_eq_of_forall_tetra
#check @coloring_eq_of_eqOn_isOpen
#print axioms coloring_eq_of_eqOn_isOpen
#check @nonempty_iso_unitDistance
#print axioms nonempty_iso_unitDistance
#check @forall_quatColoring_eq_iff
#print axioms forall_quatColoring_eq_iff
#check @forall_quatColoring_ne_iff
#print axioms forall_quatColoring_ne_iff
#check @exists_quatColoring_eq_and_ne_iff
#print axioms exists_quatColoring_eq_and_ne_iff
#check @coloring_eq_of_sqDist_two
#print axioms coloring_eq_of_sqDist_two
#check @mem_comp_iff
#print axioms mem_comp_iff
#check @zero_le_val_iff
#print axioms zero_le_val_iff
#check @mem_pr_iff
#print axioms mem_pr_iff
#check @existsUnique_tetra_sub_mem_pr
#print axioms existsUnique_tetra_sub_mem_pr
#check @nonempty_coloring
#print axioms nonempty_coloring
#check @nonempty_ratFourGraph_coloring
#print axioms nonempty_ratFourGraph_coloring

-- the definitions the statements read
#print sqDist4
#print ratFourGraph
#print sqDist
#print quatGraph
#print toQuat
#print ratPoints
#print val
#print unitSphere
#print comp
#print pr
#print tetra
#print hur
#print hur'
#print residue
#print residueCol
