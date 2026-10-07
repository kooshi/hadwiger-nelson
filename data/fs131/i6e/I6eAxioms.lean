import Proofs.HadwigerNelson.Plane.Saturated.FanBridge
/-! FS131-I6E: the axioms of each declaration this job proved, read from the build's oleans
(`lake env lean data/fs131/i6e/I6eAxioms.lean`). The first print is the **control**: a leaf that is still `sorry` on
this branch must show `sorryAx`, so the reader is seen to report the failure it guards against. -/
open HadwigerNelson.Plane
set_option pp.fullNames true
#eval IO.println "=== CONTROL (must show sorryAx) ==="
#print axioms HadwigerNelson.Plane.AeColouring.gamma
#eval IO.println "=== the two leaves that read no saturation, and their children (expected: the standard three) ==="
#print axioms HadwigerNelson.Plane.AeColouring.Fan.two_le_n
#print axioms HadwigerNelson.Plane.AeColouring.Fan.col_ne
#print axioms HadwigerNelson.Plane.AeColouring.Fan.col_ne_aux
#print axioms HadwigerNelson.Plane.fanAngle
#print axioms HadwigerNelson.Plane.polarPt_dist_fanAngle
#print axioms HadwigerNelson.Plane.fanAngle_polarPt
#print axioms HadwigerNelson.Plane.continuousAt_fanAngle
#print axioms HadwigerNelson.Plane.image_polarPt_mem_nhds
#print axioms HadwigerNelson.Plane.isOpen_setOf_polar_lt
#print axioms HadwigerNelson.Plane.polarRegion_eq_image
#print axioms HadwigerNelson.Plane.polarRegion_isOpen
#print axioms HadwigerNelson.Plane.polarRegion_isPreconnected
#print axioms HadwigerNelson.Plane.polarPt_add_two_pi
#print axioms HadwigerNelson.Plane.polarRegion_mono
#print axioms HadwigerNelson.Plane.mem_closure_polarRegion
#print axioms HadwigerNelson.Plane.volume_essBoundary
#print axioms HadwigerNelson.Plane.AeColouring.volume_essBdry
#print axioms HadwigerNelson.Plane.isConnected_ball_diff_singleton
#print axioms HadwigerNelson.Plane.AeColouring.Fan.continuousOn_cyclicNext
#print axioms HadwigerNelson.Plane.AeColouring.Fan.isOpen_cell
#print axioms HadwigerNelson.Plane.AeColouring.Fan.isPreconnected_polarRegion_of_le
#print axioms HadwigerNelson.Plane.AeColouring.Fan.isPreconnected_cell
#print axioms HadwigerNelson.Plane.AeColouring.Fan.cell_subset_densitySet
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_ray_subset_cell
#print axioms HadwigerNelson.Plane.AeColouring.Fan.mem_closure_polarRegion_of_le
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_lower_of_pred
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_isOpen_subset_cells
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_isOpen_ae_two_colours
#eval IO.println "=== children of the two branch leaves that read no open leaf (expected: the standard three) ==="
#print axioms HadwigerNelson.Plane.IsUnitCurve.reverse
#print axioms HadwigerNelson.Plane.dist_sq_polarPt_add
#print axioms HadwigerNelson.Plane.re_e_mul_conj_I_mul_e
#print axioms HadwigerNelson.Plane.re_e_mul_conj_e_eq_cos
#print axioms HadwigerNelson.Plane.dist_sq_polarPt_add_I
#print axioms HadwigerNelson.Plane.dist_sq_polarPt_sub_I
#print axioms HadwigerNelson.Plane.eq_I_mul_or_eq_neg_of_re_eq_zero
#print axioms HadwigerNelson.Plane.dist_sq_polarPt_polarPt_add_I
#print axioms HadwigerNelson.Plane.eventually_dist_polarPt_lt_one
#print axioms HadwigerNelson.Plane.AeColouring.eq_or_eq_of_mem_essClosure
#print axioms HadwigerNelson.Plane.AeColouring.Fan.eq_add_or_eq_sub_of_dist_eq_one
#eval IO.println "=== children of sector_alone that read no open leaf (expected: the standard three) ==="
#print axioms HadwigerNelson.Plane.false_of_inside_of_outside
#print axioms HadwigerNelson.Plane.in_in_or_out_out
#print axioms HadwigerNelson.Plane.add_ofReal_one_mul
#print axioms HadwigerNelson.Plane.add_ofReal_neg_one_mul
#print axioms HadwigerNelson.Plane.dist_sq_polarPt_add_sign
#print axioms HadwigerNelson.Plane.two_mul_sin_le_of_one_le_dist
#print axioms HadwigerNelson.Plane.le_two_mul_sin_of_dist_le_one
#print axioms HadwigerNelson.Plane.eventually_sin_add_mul_gt
#print axioms HadwigerNelson.Plane.horn_of_sin_constraints
#print axioms HadwigerNelson.Plane.AeColouring.Fan.dir_mono
#print axioms HadwigerNelson.Plane.AeColouring.Fan.dir_le_dir_add_two_pi
#print axioms HadwigerNelson.Plane.AeColouring.Fan.nextDir_le_dir
#print axioms HadwigerNelson.Plane.AeColouring.Fan.nextDir_le_dir_add_two_pi
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_pred_branch
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_succ_branch
#print axioms HadwigerNelson.Plane.AeColouring.Fan.sector_side
#print axioms HadwigerNelson.Plane.AeColouring.Fan.sector_side_next
#print axioms HadwigerNelson.Plane.AeColouring.Fan.sector_side_dir
#eval IO.println "=== WIRED over open leaves of other lines (expected: sorryAx until fs131-w6f and Pinch land) ==="
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_unitCurve_branch
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_twoColourNhd_branch
#print axioms HadwigerNelson.Plane.AeColouring.Fan.dist_eq_one_of_common_contact
#print axioms HadwigerNelson.Plane.AeColouring.Fan.contacts_of_no_common
#print axioms HadwigerNelson.Plane.AeColouring.Fan.branch_outside_discs
#print axioms HadwigerNelson.Plane.AeColouring.Fan.branch_contacts
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_contact_nextDir
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_contact_dir
#print axioms HadwigerNelson.Plane.AeColouring.Fan.sector_constraints
#print axioms HadwigerNelson.Plane.AeColouring.Fan.horn_false
#print axioms HadwigerNelson.Plane.AeColouring.Fan.false_of_horn_next
#print axioms HadwigerNelson.Plane.AeColouring.Fan.false_of_horn_dir
#print axioms HadwigerNelson.Plane.AeColouring.Fan.sector_alone
#print axioms HadwigerNelson.Plane.AeColouring.Fan.sector_unique
