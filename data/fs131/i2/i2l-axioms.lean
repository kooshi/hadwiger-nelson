import Proofs
-- FS131-I2l: axioms of this phase's theorems, printed from the built library (not scripts/axioms.sh, which fails on sorry)
set_option pp.fullNames true

-- the seven R7 leaves
#print axioms HadwigerNelson.Plane.r7Up_unitPair
#print axioms HadwigerNelson.Plane.r7Up_sep
#print axioms HadwigerNelson.Plane.r7Down_dist_ne_one
#print axioms HadwigerNelson.Plane.r7_boundary_lattice
#print axioms HadwigerNelson.Plane.r7_boundary_offLattice
#print axioms HadwigerNelson.Plane.r7_phi_pos_up
#print axioms HadwigerNelson.Plane.r7_phi_pos_down
-- the R7 rows they close
#print axioms HadwigerNelson.Plane.r7_unitPair_mem_sphere
#print axioms HadwigerNelson.Plane.r7_aeColouring
#print axioms HadwigerNelson.Plane.r7_boundary
#print axioms HadwigerNelson.Plane.r7Cls_saturated
#print axioms HadwigerNelson.Plane.exists_r7
#print axioms HadwigerNelson.Plane.r7Cls_isMaximalCover
-- the children (new)
#print axioms HadwigerNelson.Plane.triQ_nonneg
#print axioms HadwigerNelson.Plane.triQ_le_add
#print axioms HadwigerNelson.Plane.tri_eq
#print axioms HadwigerNelson.Plane.dist_add_mul
#print axioms HadwigerNelson.Plane.triCoord_spec
#print axioms HadwigerNelson.Plane.dist_eq_triQ
#print axioms HadwigerNelson.Plane.triCoord_tri
#print axioms HadwigerNelson.Plane.dist_tri
#print axioms HadwigerNelson.Plane.reuleaux_aux
#print axioms HadwigerNelson.Plane.reuleaux_unitPair
#print axioms HadwigerNelson.Plane.dist_eq_one_of_three
#print axioms HadwigerNelson.Plane.triCoord_combo
#print axioms HadwigerNelson.Plane.triCoord_mem_downTri
#print axioms HadwigerNelson.Plane.sqrt_triQ_add_le
#print axioms HadwigerNelson.Plane.triQ_neg
#print axioms HadwigerNelson.Plane.r7Down_coords
#print axioms HadwigerNelson.Plane.continuous_triCoord
#print axioms HadwigerNelson.Plane.r7ColTri_of_cell
#print axioms HadwigerNelson.Plane.mem_essSupport_of_isOpen
#print axioms HadwigerNelson.Plane.sqrt_three_sq_lt
#print axioms HadwigerNelson.Plane.isOpen_r7UpOpen
#print axioms HadwigerNelson.Plane.isOpen_r7DownOpen
#print axioms HadwigerNelson.Plane.r7UpOpen_subset
#print axioms HadwigerNelson.Plane.r7DownOpen_subset
#print axioms HadwigerNelson.Plane.mem_closure_r7UpOpen
#print axioms HadwigerNelson.Plane.mem_closure_r7DownOpen
#print axioms HadwigerNelson.Plane.mem_essSupport_of_mem_closure
#print axioms HadwigerNelson.Plane.r7Up_vertex_mem_essSupport
#print axioms HadwigerNelson.Plane.r7Down_cusp_mem_essSupport
#print axioms HadwigerNelson.Plane.r7_down_mem_essSupport
#print axioms HadwigerNelson.Plane.not_mem_essClosure_of_eventually
#print axioms HadwigerNelson.Plane.triQ_tangent
#print axioms HadwigerNelson.Plane.r7_local
#print axioms HadwigerNelson.Plane.r7_far_vertex
#print axioms HadwigerNelson.Plane.phi_pos_of_mem_open
#print axioms HadwigerNelson.Plane.phi_pos_of_star
#print axioms HadwigerNelson.Plane.r7UpOpen_star
#print axioms HadwigerNelson.Plane.triQ_star
#print axioms HadwigerNelson.Plane.r7DownOpen_star
#print axioms HadwigerNelson.Plane.triQ_downTri_le
#print axioms HadwigerNelson.Plane.dist_tri_ne_one
#print axioms HadwigerNelson.Plane.one_le_dist_of_two
#print axioms HadwigerNelson.Plane.dist_tri_two
#print axioms HadwigerNelson.Plane.phi_pos_up_witness
#print axioms HadwigerNelson.Plane.phi_pos_down_witness
-- negative controls: still waiting on HC/IRREG leaves, must print sorryAx
#print axioms HadwigerNelson.Plane.hc_isRegularMUA
#print axioms HadwigerNelson.Plane.hc_irreg
#print axioms HadwigerNelson.Plane.hc_band_components
