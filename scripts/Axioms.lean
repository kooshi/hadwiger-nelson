import Proofs

/-!
# Axiom audit — the trust receipt

The de Bruijn criterion made a standing check: everything shipped reduces to what the kernel
verified plus what we explicitly chose to trust. One `#print axioms` line per public theorem on the
milestone's surface.

Run it through the gate script, which reads the banners below and fails on a purchase in the wrong
section:

```
./scripts/axioms.sh
```

or by hand with `lake env lean scripts/Axioms.lean`.

## The two sections, and why the banners are printed rather than commented

A native purchase shows up as **one long name in the middle of a wall of text** — at v4.32.0
`native_decide` mints a per-declaration axiom, `foo._native.native_decide.ax_1_1`, and
`Lean.ofReduceBool` never appears at all. Eyeballing that difference across twenty lines is exactly
the check that silently stops being run. So the file prints machine-readable banners, the audit
splits on them, and the rule is mechanical:

* **CLEAN** — every line must be exactly `propext`, `Classical.choice`, `Quot.sound`. Any
  `native_decide`, `ofReduceBool` or `sorryAx` here fails the gate.
* **PURCHASED** — these carry a native-evaluation axiom *by design*. Each corresponds to a
  declaration whose docstring opens with "**Trust purchase: native evaluation.**"
  (`grep -rn "Trust purchase" Proofs/` is the source-side ledger), and to an entry in
  `ARCHITECTURE.md` § 5. `sorryAx` still fails here.

`moserSpindle_valid` and `deGrey_valid` are the ones to watch in the clean section: both rest on
kernel *reduction* rather than on a written proof, and both stay inside the standard axiom set.
`deGrey_valid` is 7877 exact identities decided in 158 chunks — the geometry half of `χ(ℝ²) ≥ 5`,
bought with no native evaluation at all.
-/

open HadwigerNelson

#eval IO.println "=== CLEAN ==="

/-! ## M01 — the reduction and its API -/

#print axioms lt_chromaticNumber_iff_not_colorable
#print axioms add_one_le_chromaticNumber_iff_not_colorable
#print axioms lt_chromaticNumber_unitDistance
#print axioms add_one_le_chromaticNumber_unitDistance
#print axioms chromaticNumber_unitDistance_congr

-- M44, the limit lemma: approximate drawings in a compact region force the exact bound.
#print axioms exists_unitDistance_drawing_of_approx
#print axioms add_one_le_chromaticNumber_unitDistance_of_approx
#print axioms add_one_le_chromaticNumber_unitDistance_of_bounded_family
#print axioms seven_le_chromaticNumber_plane_of_bounded_family
#print axioms three_le_chromaticNumber_complex_of_exact_triangle
#print axioms three_le_chromaticNumber_complex_of_shrinking_triangles
#print axioms collapsed_drawing_satisfies_one_tolerance
#print axioms collapsed_drawing_fails_below_one
#print axioms add_one_le_chromaticNumber_unitDistance_edgeList

-- M45, the arity of a colour compulsion: a partial colouring that does not extend, and how few
-- vertices one needs. `compels_two_eq`/`compels_two_ne` are the statement that arity two IS the
-- repository's existing `Separated`/`Forces`; `arityFloor_le_of_degree` is the theorem that four
-- flat pair campaigns were asking below a bound that was always available.
#print axioms samePattern_two
#print axioms Realizes.congr
#print axioms realizes_iff_extends
#print axioms realizes_iff_exists
#print axioms compels_two_eq
#print axioms compels_two_ne
#print axioms Separated.compels
#print axioms Forces.compels
#print axioms arityFloor_le_of_compels
#print axioms le_arityFloor_iff
#print axioms arityFloor_eq_zero_iff
#print axioms two_le_arityFloor
#print axioms compels_of_fan
#print axioms compels_rainbow_of_neighbors
#print axioms arityFloor_le_of_degree
#print axioms AritySpec.p5cols_proper
#print axioms AritySpec.p5_no_pair_compulsion
#print axioms AritySpec.p5_compels_rainbow
#print axioms AritySpec.p5_arityFloor
#print axioms AritySpec.tri_arityFloor
#print axioms AritySpec.k4_arityFloor_zero

-- M48 — how a compulsion travels between graphs, and the six-colour programme's exact requirement.
-- `arityFloor_le_of_embedding` is the LADDER theorem (growing a graph can only LOWER its floor —
-- the bigger graph is on the left), which is what makes a closure-ladder measurement mean anything.
-- `Separated.comap` is the missing dual of `Forcer.Forces.comap`, and `Separated.plane` transports
-- a finite gadget's virtual edge to the whole plane. `not_colorable_five_of_forced_pairs` is the
-- correction this milestone makes to its own record: `hexShell_plane5` is DISJUNCTIVE, so
-- chi(R^2) >= 6 needs a virtual edge at sqrt3 AND one at distance 2, never one at either.
#print axioms Realizes.comap
#print axioms PartialColoring.map
#print axioms Compels.map
#print axioms arityFloor_le_of_embedding
#print axioms Separated.comap
#print axioms exists_isometry_map_pair
#print axioms forced_pair_of_forced
#print axioms Separated.plane
#print axioms not_colorable_five_of_forced_pairs
#print axioms six_le_chromaticNumber_plane_of_forced_pairs

-- M49 — the distance graph of a set of forbidden distances, homogeneity made relation-generic
-- over it, and the spindle as a theorem: `not_colorable_of_forced_equal` (forced-equal at any
-- d >= 1/2 refutes k-colourability, homogeneity ∘ a d–d–1 triangle), the gadget→Forces bridge, and
-- ONE DEFECT SUFFICES (`add_one_le_chromaticNumber_unitDistance_of_one_defect`: a (k+1)-chromatic
-- plane graph with a single non-unit edge already bounds chi(R^2)). The spec re-proves the Moser
-- bound through the abstract lemma from the rhombus alone.
#print axioms unitDistance_eq_distanceGraph_singleton
#print axioms chromaticNumber_unitDistance_le_distanceGraph
#print axioms add_one_le_chromaticNumber_distanceGraph_edgeList
#print axioms exists_mono_pair_of_not_colorable_two_distance
#print axioms not_colorable_unitDistance_of_forced_distinct
#print axioms UDCert.pairsAt_sound_sq
#print axioms UDCert.adj_dist_mem
#print axioms transport_pair
#print axioms Separated.planeIn
#print axioms Forces.planeIn
#print axioms exists_dist_eq_and_dist_eq_one
#print axioms not_exists_dist_eq_and_dist_eq_one_of_lt_half
#print axioms not_colorable_of_forced_equal
#print axioms add_one_le_chromaticNumber_of_forced_equal
#print axioms forces_of_gadget
#print axioms forces_of_not_colorable_append_single
#print axioms add_one_le_chromaticNumber_unitDistance_of_forces
#print axioms add_one_le_chromaticNumber_unitDistance_of_one_defect
#print axioms rhombus_forces_of_gadget
#print axioms four_le_chromaticNumber_plane_of_rhombus
#print axioms four_le_chromaticNumber_plane_of_rhombus_defect
#print axioms seven_le_chromaticNumber_hexShell_distances
-- M50: the partner lattice's depth-one completeness (PartnerLattice.lean)
#print axioms HadwigerNelson.Glue.eq_gluePoint_of_unit_pair
#print axioms HadwigerNelson.Glue.finite_two_unit_neighbors
-- M51: the spare-colour lemma, both polarities + contrapositives (SpareColour.lean)
#print axioms HadwigerNelson.not_forces_of_colorable
#print axioms HadwigerNelson.not_separated_of_colorable
#print axioms HadwigerNelson.Forces.not_colorable
#print axioms HadwigerNelson.Separated.not_colorable
-- M51: the entropy floor K4 — a k-colourable graph has ≥ 2^⌈n/k⌉ (k+1)-colourings (EntropyFloor.lean)
#print axioms HadwigerNelson.two_pow_le_card_coloring
#print axioms HadwigerNelson.spareColorings_eq_last_iff
#print axioms HadwigerNelson.not_colorable_of_card_coloring_lt


/-! ## M01 — the model of the hypotheses, and χ ≥ 3 -/

#print axioms trianglePoints_dist
#print axioms not_colorable_two_top_fin_three
#print axioms edgeGraph_triangleEdges_eq_top
#print axioms three_le_chromaticNumber_unitDistance_complex
#print axioms three_le_chromaticNumber_unitDistance_complex'
#print axioms three_le_chromaticNumber_plane

/-! ## M02 — the exact-arithmetic tower and the certificate bridge -/

#print axioms Q4.eval
#print axioms eval_distSq
#print axioms dist_toPlane_eq_one
#print axioms UDCert.validOn_iff
#print axioms UDCert.valid_of_chunks
#print axioms UDCert.valid_sound
#print axioms UDCert.add_one_le_chromaticNumber_of_valid
#print axioms moserSpindle_valid

/-! ## M03 — the SAT bridge

None of these evaluates a certificate; they are theorems *about* `Unsat` hypotheses, so they are
clean regardless of how the hypothesis was obtained. -/

#print axioms exists_sat_coloringCNF
#print axioms not_colorable_of_unsat
#print axioms cubeOf_mem_allCubes
#print axioms exists_sat_coloringCNF_cube
#print axioms not_colorable_of_cubes
#print axioms colorable_iff_exists
#print axioms not_colorable_edgeGraph_iff
#print axioms unsat_of_check
#print axioms chromaticNumber_plane_eq_complex
#print axioms UDCert.add_one_le_chromaticNumber_plane_of_valid
#print axioms UDCert.add_one_le_chromaticNumber_plane_of_unsat
#print axioms UDCert.add_one_le_chromaticNumber_plane_of_cubes

/-! ## M03 — the spindle's brute-force route, and the headline -/

#print axioms moserSpindle_not_colorable_three
#print axioms moserSpindle_colorable_four
#print axioms exists_sat_coloringCNF_four
#print axioms moserSpindleCubes_eq
#print axioms four_le_chromaticNumber_plane

/-! ## M04 — de Grey's 1581 vertices, certified

`deGrey_valid` is the milestone: 7877 edges, each an exact identity in `ℚ(√3,√5,√7,√11)`, decided
by kernel reduction in 158 chunks. Nothing here is native — the whole geometry half of `χ(ℝ²) ≥ 5`
stays inside the standard axiom set, and `deGrey_bound_of_not_colorable` shows what a fifth colour
would still cost: one hypothesis, no geometry. -/

#print axioms UDCert.validOn_flatten
#print axioms UDCert.badEdges_eq_nil_iff
#print axioms deGrey_valid
#print axioms deGrey_unit_distances
#print axioms deGrey_bound_of_not_colorable

/-! ## M05 — the kernel-runnable refutation checker

The point of the milestone is that these are in the **clean** section. `maskCheck_sound` is the only
route from a checked certificate to unsatisfiability, and both of its hypotheses are closed `Bool`s
the kernel decides — so a refutation costs no axiom beyond the standard three, where M03's route
below buys one per declaration. -/

#print axioms LitSet.any_ofClause_iff
#print axioms LitSet.entails_zero_iff_unsat
#print axioms propagate_conflict_sound
#print axioms propagate_prop_sound
#print axioms justified_of_agreesWithCNF
#print axioms rup_sound
#print axioms runActions_sound
#print axioms runStream_sound
#print axioms maskCheck_sound

/-! ## M06 — χ(ℝ²) ≥ 5

**The milestone, and the project's headline.** `chromaticNumber_plane_ge_five` must appear in the
*clean* section: the whole point of M05 was that a refutation of de Grey's graph costs no axiom beyond
the standard three, and this is where that is either true or not.

`deGreyRot_not_colorable_four` is the claim no human can check by inspection — it quantifies over `4^1581`
assignments — so it is the one where a native-evaluation axiom would matter most. It is clean. -/

#print axioms edgeGraph_adj_mono
#print axioms valid_comp_of_injective
#print axioms exists_perm_apply_eq
#print axioms not_pinned
#print axioms runSegment_sound
#print axioms justified_of_segment
#print axioms unsat_of_segment
#print axioms deGrey_halfA_subset
#print axioms deGreyRot_valid
#print axioms deGrey_rotation
#print axioms deGrey_adj_cross
#print axioms halfA_unsat
#print axioms deGreyRot_not_colorable_four
#print axioms chromaticNumber_plane_ge_five

/-! ## M09 — the gadget algebra, and de Grey's second copy derived

The milestone's whole claim is that half B's certificate was redundant. `deGrey_rotation` above is
what replaced it, and it must be clean: it is 791 exact identities the kernel decides, and a native
purchase there would move the construction's central fact out of the kernel's reach.

`Motion.distSq_eq` and `UDCert.validOn_map_of_motion` carry the geometry of every placed copy; the
`Gadget` combinators carry the colouring properties. Both are the instrument M11 runs on. -/

#print axioms exists_perm_comp_eq
#print axioms not_colorable_of_gadget
#print axioms Gadget.ofUnsat
#print axioms Gadget.transport
#print axioms Gadget.edge
#print axioms Motion.distSq_eq
#print axioms UDCert.validOn_of_subset
#print axioms UDCert.validOn_map_of_motion
#print axioms deGreyPhiNat_inj
#print axioms deGreyMotion_maps
#print axioms deGreyRot_validOn_rotated

/-! ## M10 — the fractional chromatic number, and `χ_f(ℝ²) ≥ 65/18`

The fractional bound is a *lower* bound on an infimum, so it says something only because it
quantifies over every fractional colouring — and `C5_fractional` is what shows the definition is not
secretly the ordinary chromatic number, by pinning a value that is not an integer.

`coreSpindle_noHeavy` is this milestone's uninspectable claim: no independent set of 63 points
weighs more than 72, over `10⁹`-odd sets. It must be clean, and so must
`four_le_chromaticNumber_plane_fractional`, which re-derives M03's rung from the fractional bound
alone. -/

#print axioms SimpleGraph.le_fractionalChromaticNumber_iff
#print axioms SimpleGraph.FractionalColorable.fractionalChromaticNumber_le
#print axioms SimpleGraph.fractionalChromaticNumber_mono_of_hom
#print axioms SimpleGraph.le_fractionalChromaticNumber_of_weights
#print axioms SimpleGraph.le_fractionalChromaticNumber_of_indepNum
#print axioms SimpleGraph.not_colorable_of_lt_fractionalChromaticNumber
#print axioms HadwigerNelson.FractionalSpec.C5_fractional
#print axioms HadwigerNelson.nbrMask_and_two_pow_eq_zero
#print axioms HadwigerNelson.noHeavy_sound
#print axioms HadwigerNelson.le_fractionalChromaticNumber_unitDistance_edgeList
#print axioms HadwigerNelson.coreSpindle_valid
#print axioms HadwigerNelson.coreSpindle_slots
#print axioms HadwigerNelson.coreSpindle_noHeavy
#print axioms HadwigerNelson.coreSpindle_unit_distances
#print axioms HadwigerNelson.findHeavy_isNone
#print axioms HadwigerNelson.fractionalChromaticNumber_plane_ge
#print axioms HadwigerNelson.four_le_chromaticNumber_plane_fractional

/-! ## M07 — two smaller witnesses, on the same infrastructure

The same theorem from two graphs that share no vertex, no edge and no certificate with de Grey's, so
that a fault in the encoding or the checker would have to be one that certifies three unrelated
graphs. Both go through `not_colorable_of_gadget` — one refutation and the pinned triangle's own
three edges, composed. -/

#print axioms halfA_table_refuses_halfB_cnf
#print axioms deGrey_forcing_alone_admits
#print axioms heule510_valid
#print axioms heule510_unit_distances
#print axioms heule510_unsat
#print axioms heule510_not_colorable_four
#print axioms chromaticNumber_plane_ge_five_510
#print axioms heule553_valid
#print axioms heule553_unit_distances
#print axioms heule553_unsat
#print axioms heule553_not_colorable_four
#print axioms chromaticNumber_plane_ge_five_553

/-! ## M11 — the search instrument

Two rewrites and one new module, and the audit is where their reach is stated.

`exists_mem_canonPatterns` is what makes the terminal check exhaustive while enumerating a fraction
of the colourings: every colouring of the ports matches a listed one. If it were unsound, every
`not_colorable_of_gadget` above it would be too — which is the whole of `Gadget`'s conclusion, on
all three witnesses.

`Motion.distSq_image` and `UDCert.validOn_map_of_scaling` are the pair that make a placed copy free.
They are checked here because a copy placed by them is asserted *nowhere else*: there is no
per-vertex identity to inspect, which is exactly what makes them worth auditing.

`Gadget.ofExhaustion` produces a gadget with no solver and no certificate anywhere, so it is the one
producer whose trust is entirely the kernel's. -/

#print axioms exists_mem_canonPatterns
#print axioms samePattern_iff
#print axioms Gadget.ofExhaustion
#print axioms rhombusGadget
#print axioms Motion.maps_iff
#print axioms Motion.distSq_image
#print axioms Motion.distSq_rescale
#print axioms Motion.maps_trans
#print axioms UDCert.validOn_map_of_scaling

/-! ## M12 — many placed copies, and the first five-colour question

`Assembly` is the layer that makes a candidate built as an orbit cheap: every copy's coordinates are
*derived* from the base and a motion rather than emitted, so there is no per-vertex identity to
inspect and nothing to audit but these theorems. `validOn_copiedEdges` is the one that certifies a
copy's whole edge list without reducing a single distance, and `adj_embed` is its combinatorial twin —
together they are why a placed copy is free in both halves rather than only the cheap one.

`mycielski47_colorable_six` is the control that keeps the five-colour claim honest: an *existence*
statement, the opposite direction from everything else in this project, so a refutation that was
silently about the wrong colour count cannot pass unnoticed.

`mycielski47_not_colorable_five` is the headline: the first statement in this project about
*five*-colourings, resting on a kernel-checked certificate of 387,065 propagation steps. It is
audited here rather than trusted, and its axiom list is the whole claim — a native purchase would
show up in it, and none does. -/

#print axioms Assembly.distSq_place
#print axioms Assembly.verts_embed
#print axioms Assembly.validOn_copiedEdges
#print axioms Assembly.valid_of_cross
#print axioms Assembly.adj_embed
#print axioms Mycielski.pinned_unsat
#print axioms mycielski47_not_colorable_five
#print axioms mycielski47_colorable_six

/-! ## M13 — a forced pair, and the spindle that closes it

The argument both known rungs of this problem share, stated once for any graph and any number of
colours. `not_colorable_of_spindled_forcer` is the whole of it: a configuration whose every
`k`-colouring paints `p` and `q` alike, placed twice sharing `p` with the images of `q` adjacent, has
no `k`-colouring. `not_colorable_spindleEdges` is the form a search's output arrives in, where the
assembled graph is *constructed* rather than given, so neither placement has to be searched for.

Two producers audited beside them, because a property with one producer is a property one bug wide:
`Forces.of_edges` exhausts the colourings and `Forces.of_gadget` reads a certificate through the
gadget algebra. `moserSpindle_not_colorable_three_spindled` is the payoff at spec scale — rung A's
witness re-derived by deciding a four-vertex rhombus and placing it twice, rather than deciding all
seven vertices. It is a *fourth* independent route to a theorem this project already had three of,
which is exactly the kind of redundancy that catches a wrong statement. -/

#print axioms Forces.comap
#print axioms Forces.mono
#print axioms Forces.map
#print axioms not_colorable_of_spindled_forcer
#print axioms Forces.of_edges
#print axioms Forces.of_gadget
#print axioms Forces.of_unsat
#print axioms edgeHom
#print axioms not_colorable_spindleEdges
#print axioms rhombus_forces
#print axioms moserSpindle_not_colorable_three_spindled
#print axioms spindleFromRhombi_not_colorable_three

/-! ## M14 — fans, the disjunctive forcer

`Forces` is the width-one case of `Fan`, so these are the statements a search above rung B lands on
before it has narrowed to a forced pair. Nothing here evaluates anything natively. -/

#print axioms Fan
#print axioms Separated
#print axioms Separated.of_adj
#print axioms not_colorable_of_fan
#print axioms not_colorable_of_fan_nil
#print axioms fan_singleton_iff
#print axioms Fan.narrow
#print axioms Fan.widen
#print axioms Fan.mono
#print axioms Fan.comap
#print axioms Fan.map
#print axioms not_colorable_of_spindled_fan
#print axioms fanEdges
#print axioms Fan.of_not_colorable
#print axioms Fan.of_unsat
#print axioms fan_iff_not_colorable
#print axioms Fan.of_edges

/-! ## M15 — a fan is one removable vertex, and the certified negative

The correspondence, its fan-facing corollaries, the packed certificate, and the two witnesses whose
every vertex is now proved necessary. The last two are the milestone's headline: no five-colour fan
sits anywhere in either graph, so the route that produced χ ≥ 5 has nothing here to start from. -/

#print axioms exists_isolating_of_colorable_delete
#print axioms colorable_delete_of_exists_isolating
#print axioms colorable_delete_iff_exists_isolating
#print axioms not_fan_of_colorable_delete
#print axioms not_forces_of_colorable_delete
#print axioms not_fan_of_vertex_critical
#print axioms fan_univ_of_not_colorable_delete
#print axioms fan_univ_iff
#print axioms delete_edgeGraph
#print axioms unpackColor
#print axioms properOffPivot
#print axioms criticalFrom
#print axioms criticalFrom_append
#print axioms criticalFrom_append_of
#print axioms everyVertexCritical
#print axioms colorable_delete_of_packed
#print axioms forall_colorable_delete_of_packed
#print axioms no_fan_of_packed
#print axioms heule510_criticality
#print axioms heule510_vertex_critical
#print axioms heule510_no_five_fan
#print axioms heule553_criticality
#print axioms heule553_vertex_critical
#print axioms heule553_no_five_fan

/-! ## M16 — no fan in de Grey's graph is narrow, certified against real distances

The interval instrument (exact `Q4` values compared as reals, from decidable generator bounds),
the narrow-fan certificate checker with its soundness bridge, and the four headline negatives —
one per pivot that carries a five-colour fan at all. The closing move needs a fan confined to one
real distance; these say the only four known fans offer it nothing. -/

#print axioms Ival.mem_ofInt
#print axioms Ival.Mem.scaleUp
#print axioms Ival.Mem.add
#print axioms Ival.Mem.mul
#print axioms mem_sqrt
#print axioms Adjoin.approx
#print axioms Adjoin.mem_approx
#print axioms Q4.approx
#print axioms Q4.mem_approx
#print axioms sepIvals
#print axioms sepChain
#print axioms eval_lt_of_hi_lt_lo
#print axioms pairwise_lt_of_sepChain
#print axioms pairwise_ne_of_sepChain
#print axioms index_eq_of_eval_eq
#print axioms unpackNat
#print axioms unpackZ
#print axioms unpackQ4
#print axioms properColouring
#print axioms exists_coloring_of_proper
#print axioms NarrowCert.checkVertex
#print axioms NarrowCert.check
#print axioms NarrowCert.eval_distSq_eq_of_dist_eq
#print axioms NarrowCert.sound
#print axioms NarrowCert.vertexFault_none_iff
#print axioms NarrowCert.firstFault_none_iff_check
#print axioms deGreyNarrow630_check
#print axioms deGrey_no_narrow_fan_630
#print axioms deGreyNarrow633_check
#print axioms deGrey_no_narrow_fan_633
#print axioms deGreyNarrow1420_check
#print axioms deGrey_no_narrow_fan_1420
#print axioms deGreyNarrow1423_check
#print axioms deGrey_no_narrow_fan_1423

/-! ## M17 — deletion never creates a fan

The pruning corollaries the hunt's growth-only design rests on: list inclusion lifts to the graph
order, a fan lifts with it, and — contrapositively — a separating colouring restricts to every
sub-candidate. -/

#print axioms edgeGraph_mono
#print axioms Fan.of_subset
#print axioms not_fan_of_subset

/-! ## M18 — the 120° class

The plane-level structure behind the resisting histogram: the chord bound, the triangle
identity, the 120° closure, "no class confines alone" (with its greedy-colouring engine), and
the coverage⟺fan reduction that turns confinement into a measurable gradient. -/

#print axioms SimpleGraph.colorable_of_degree_lt
#print axioms eq_or_eq_or_eq_of_dist_eq
#print axioms dist_sq_centroid_unit_triangle
#print axioms eq_centroid_of_dist_eq
#print axioms exists_unit_triangle_iff
#print axioms omega3_cube
#print axioms rot3_rot3_rot3
#print axioms dist_rot3_self
#print axioms rot3_unit_triangle
#print axioms not_fan_of_colorable_of_edges_within
#print axioms degree_classOnlyGraph_le_two
#print axioms not_fan_classOnlyGraph
#print axioms Fan.of_coverage
#print axioms fan_iff_coverage
#print axioms three_le_card_of_triangle_mem

/-! ## M19 — the two-circle theorem, the coverage ratchet, the balanced witness

The local ceiling (every unit-distance graph on a 120°-pivot's two circles is 3-colourable,
via the seam rotation's infinite order), the monotonicity that makes minCov a ratchet, and
the kernel-checked balanced 5-colouring of de Grey's graph (the density-obstruction
negative). The witness facts are `decide +kernel` — no native evaluation anywhere. -/

#print axioms TwoCircle.seam_pow_ne_one
#print axioms TwoCircle.zeta6_zpow_eq_one_iff
#print axioms TwoCircle.ratio_of_unit_chord
#print axioms TwoCircle.ratio_of_sqrt3_chord
#print axioms TwoCircle.ratio_of_cross_chord
#print axioms TwoCircle.label_unique
#print axioms TwoCircle.colorable_three_induce
#print axioms TwoCircle.colorable_three_comap
#print axioms CoverAtLeast.anti
#print axioms CoverAtLeast.mono_subset
#print axioms CoverAtLeast.mono_edges
#print axioms fan_iff_coverAtLeast
#print axioms CoverAtLeast.of_triangle_mem
#print axioms balancedColorRaw_lt
#print axioms balancedColorRaw_proper
#print axioms balancedColoring_counts
#print axioms deGrey_balanced

/-! ## M20 — the 120° compulsion, the one-pivot cap, the strip automaton

The first independent-set compulsion (an outer 120°-triple is never monochromatic under
three colours — the seam-image unit triangle refuses), the exact chromatic number of one
pivot's whole system ({p} ∪ both circles = 4), and the tube's colouring theory with the
window-extension theorem. All finite parts are `decide +kernel` against literal tables —
no native evaluation anywhere. -/

#print axioms Compulsion.no_mono_outer_triple
#print axioms Compulsion.concentric_not_colorable_three
#print axioms Compulsion.concentric_colorable_four
#print axioms Compulsion.chromaticNumber_concentric
#print axioms Compulsion.seamRatio_mul_sqrt3
#print axioms Strip.hexTable_complete
#print axioms Strip.rainTable_complete
#print axioms Strip.nonMonoB_of_avoids_rain
#print axioms Strip.mono_avoids_no_rainbow
#print axioms Strip.avoid_card
#print axioms Strip.twostep_card
#print axioms Strip.window_extends

/-! ## M21 — coupled circle systems: the unit-distance pivot pair

The reflection package (`reflAcross`, the pair's one symmetry — an involutive isometry
fixing both pivots), the interlock, the four gluing classifications (each circle-pair
intersection is exactly {a point, its mirror}, witnessed by the strip's own operators),
and the superset-quantified lower bound (any set containing one pivot's system needs
four colours). Pure geometry over ℂ — no tables, no native evaluation. -/

#print axioms Coupled.reflAcross_pivot_left
#print axioms Coupled.reflAcross_pivot_right
#print axioms Coupled.reflAcross_swap
#print axioms Coupled.reflAcross_reflAcross
#print axioms Coupled.dist_reflAcross
#print axioms Coupled.reflAcross_mem_sphere_left
#print axioms Coupled.reflAcross_mem_sphere_right
#print axioms Coupled.seamImage_interlock
#print axioms Coupled.outer_inter_outer
#print axioms Coupled.outer_inter_inner
#print axioms Coupled.inner_inter_outer
#print axioms Coupled.inner_inter_inner
#print axioms Coupled.four_le_chromaticNumber_of_system_subset
#print axioms Coupled.four_le_chromaticNumber_pairSystem

/-! ## M22 — the general gluing classification

`reflAxis` (the mirror across an arbitrary axis — ratio conjugation, collapsing to
M21's `reflAcross` at unit axis), the general classification (two distinct centres
under the annulus condition meet in exactly the glue point and its mirror; empty
outside), and the nine-step near-cycle (`ζ₆·σ⁹` is within chord 1/50 of 1 and is
not 1 — the first certified near-relation). Pure geometry over ℂ — no tables, no
native evaluation. -/

#print axioms Glue.reflAxis_pivot_left
#print axioms Glue.reflAxis_pivot_right
#print axioms Glue.reflAxis_reflAxis
#print axioms Glue.dist_reflAxis
#print axioms Glue.reflAxis_mem_sphere_left
#print axioms Glue.reflAxis_mem_sphere_right
#print axioms Glue.reflAxis_eq_reflAcross
#print axioms Glue.sphere_inter_sphere
#print axioms Glue.sphere_inter_sphere_eq_empty_of_far
#print axioms Glue.sphere_inter_sphere_eq_empty_of_nested
#print axioms Glue.zeta6_mul_seam_pow_nine_ne_one
#print axioms Glue.normSq_zeta6_mul_seam_pow_nine_sub_one_lt

/-! ## M23 — the pivot triangle and the metapivot system

The self-gluing cycle, the centroid as triple glue point, the three no-new-points
metapivot couplings, the ten-point sharing theorem with its count, the chord
classifications (outer–outer rigidity, inner–inner Möbius), the translation
coupling, the loop identities (hex parallelogram; the rotation hexagon — generic
in the rotation AND the three points — with its seam instance), and the zpow
closure backbone. Pure geometry over ℂ. -/

#print axioms Triangle.dist_pivot_01
#print axioms Triangle.dist_pivot_02
#print axioms Triangle.dist_pivot_12
#print axioms Triangle.dist_centroid_0
#print axioms Triangle.dist_centroid_1
#print axioms Triangle.dist_centroid_2
#print axioms Triangle.hexStep_cycle_01
#print axioms Triangle.hexStep_cycle_12
#print axioms Triangle.hexStep_cycle_20
#print axioms Triangle.outer_inter_outer_eq_third
#print axioms Triangle.centroid_glue_01
#print axioms Triangle.centroid_glue_12
#print axioms Triangle.centroid_glue_20
#print axioms Triangle.outer_inter_metaInner
#print axioms Triangle.inner_inter_metaOuter
#print axioms Triangle.inner_inter_metaInner
#print axioms Triangle.system_inter_system
#print axioms Triangle.ncard_system_inter_system
#print axioms Triangle.unit_chord_outer_outer
#print axioms Triangle.unit_chord_inner_inner
#print axioms Triangle.outer_partner_pair
#print axioms Triangle.mem_sphere_translate
#print axioms Triangle.dist_translate
#print axioms Triangle.one_sub_zeta6
#print axioms Triangle.hexStep_matching
#print axioms Triangle.hexStep_hexStep_eq_rot3_centroid
#print axioms Triangle.hexStep_triple_flip
#print axioms Triangle.hex_parallelogram
#print axioms Triangle.rot_hexagon
#print axioms Triangle.seam_hexagon
#print axioms Triangle.zeta6_zpow_mul_seam_zpow_eq_one_iff
#print axioms Triangle.rotAbout_zeta6
#print axioms Triangle.rotAbout_seamRatio
#print axioms Triangle.rotAbout_omega3

/-! ## M24 — the matched ladder pair: completeness theorems and the unconditional χ = 4

The countable two-pivot ladder with every chord family fixed by theorems rather than a
census window. The completeness core runs in `ℤ[ζ₆, π]`, `π = √3·σ`: parity separation
on `√3 ∉ ℚ(ζ₆, π)`, coordinate congruences modulo three, and the `piCoeff` recurrence.
The headline is `Ladder.chromaticNumber_ladderPair`. -/

#print axioms Ladder.word_eq_one_iff
#print axioms Ladder.word_inj
#print axioms Ladder.cross_dist
#print axioms Ladder.intra_dist
#print axioms Ladder.oo_complete
#print axioms Ladder.ii_chord_iff
#print axioms Ladder.oi_chord_iff
#print axioms Ladder.intra_outer_complete
#print axioms Ladder.intra_inner_complete
#print axioms Ladder.intra_seam_complete
#print axioms Ladder.outerPt_inj
#print axioms Ladder.innerPt_inj
#print axioms Ladder.outer_ne_inner
#print axioms Ladder.fusion_oo
#print axioms Ladder.fusion_oi
#print axioms Ladder.fusion_io
#print axioms Ladder.fusion_ii
#print axioms Ladder.sqrt_indep
#print axioms Ladder.piC_pow_coeff
#print axioms Ladder.piCoeff_norm
#print axioms Ladder.sqrt3_pow_mul_word
#print axioms Ladder.eq_zero_of_add_sqrt3_mul
#print axioms Ladder.inRing_coords_zero
#print axioms Ladder.normBranch_cleared
#print axioms Ladder.normBranch_parity
#print axioms Ladder.normBranch_even
#print axioms Ladder.normBranch_odd_large
#print axioms Ladder.normBranch_odd_one
#print axioms Ladder.normBranch_odd_mixed
#print axioms Ladder.normBranch_cleared_neg
#print axioms Ladder.normBranch_parity_neg
#print axioms Ladder.normBranch_even_neg
#print axioms Ladder.normBranch_odd_neg
#print axioms Ladder.ii_norm_complete
#print axioms Ladder.ii_norm_bound
#print axioms Ladder.oi_complete
#print axioms Ladder.ladderColor_valid
#print axioms Ladder.colorable_four_ladder
#print axioms Ladder.witness_not_colorable_three
#print axioms Ladder.not_colorable_three_ladder
#print axioms Ladder.chromaticNumber_ladderPair

/-! ## M25 — the four-ladder object (the pivot triangle's ladders plus the metapivot's own)

The headline is `MetaLadder.chromaticNumber_fourLadder`. -/

#print axioms MetaLadder.sqrt3_mul_zeta12
#print axioms MetaLadder.meta_axis_dirs
#print axioms MetaLadder.metaInner_hub
#print axioms MetaLadder.outerPt_hexRot
#print axioms MetaLadder.outerPt_affine
#print axioms MetaLadder.web_transport_rot
#print axioms MetaLadder.web_transport_rot_meta
#print axioms MetaLadder.ladderSet_subset_fourLadder
#print axioms MetaLadder.bridge_oo
#print axioms MetaLadder.bridge_oi
#print axioms MetaLadder.bridge_io
#print axioms MetaLadder.bridge_ii
#print axioms MetaLadder.fusion_bridge_oo
#print axioms MetaLadder.fusion_bridge_oi
#print axioms MetaLadder.fusion_bridge_io
#print axioms MetaLadder.fusion_bridge_ii
#print axioms MetaLadder.hexTrace_coords
#print axioms MetaLadder.meta_oo_complete
#print axioms MetaLadder.meta_oi_complete
#print axioms MetaLadder.meta_io_complete
#print axioms MetaLadder.meta_ii_complete
#print axioms MetaLadder.meta_fusion_oo
#print axioms MetaLadder.meta_fusion_oi
#print axioms MetaLadder.meta_fusion_io
#print axioms MetaLadder.meta_fusion_ii
#print axioms MetaLadder.metaColor_valid
#print axioms MetaLadder.colorable_four_fourLadder
#print axioms MetaLadder.not_colorable_three_fourLadder
#print axioms MetaLadder.chromaticNumber_fourLadder

/-! ## M26 — the hexagram (six pivots about the metapivot, every ladder, all unit chords)

The headline is `Hexagram.chromaticNumber_hexagram`. -/

#print axioms Hexagram.hexPivot_eq
#print axioms Hexagram.dist_hexPivot
#print axioms Hexagram.fourLadder_subset_hexagram
#print axioms Hexagram.rot6_hexPivot
#print axioms Hexagram.hex_master
#print axioms Hexagram.bridge_adj
#print axioms Hexagram.bridge_opp
#print axioms Hexagram.adj_oo_empty
#print axioms Hexagram.adj_oi_complete
#print axioms Hexagram.adj_io_complete
#print axioms Hexagram.adj_ii_complete
#print axioms Hexagram.adj_fusion_oo
#print axioms Hexagram.adj_fusion_oi
#print axioms Hexagram.adj_fusion_io
#print axioms Hexagram.adj_fusion_ii
#print axioms Hexagram.opp_oo_complete
#print axioms Hexagram.opp_oi_empty
#print axioms Hexagram.opp_io_empty
#print axioms Hexagram.opp_ii_empty
#print axioms Hexagram.opp_fusion_oo
#print axioms Hexagram.opp_fusion_oi
#print axioms Hexagram.opp_fusion_io
#print axioms Hexagram.opp_fusion_ii
#print axioms Hexagram.hexMeta_oo_complete
#print axioms Hexagram.hexMeta_oi_complete
#print axioms Hexagram.hexMeta_io_complete
#print axioms Hexagram.hexMeta_ii_complete
#print axioms Hexagram.hexMeta_fusion_oo
#print axioms Hexagram.hexMeta_fusion_oi
#print axioms Hexagram.hexMeta_fusion_io
#print axioms Hexagram.hexMeta_fusion_ii
#print axioms Hexagram.unit_oo_complete
#print axioms Hexagram.hexColTab_equivariant
#print axioms Hexagram.hexMetaColTab_equivariant
#print axioms Hexagram.hexColor_valid
#print axioms Hexagram.colorable_four_hexagram
#print axioms Hexagram.not_colorable_three_hexagram
#print axioms Hexagram.chromaticNumber_hexagram

/-! ## M30 — the field wall

The kernel-checked citation for the field-jump thesis: the Moser spindle's twist rotation is a
word in the seam group (`ρ·σ² = −1`, i.e. `ρ = ζ₆³σ⁻²`), so the classical 4-forcers are native
to ⟨ζ₆, σ⟩ while the 5-forcers need √5 and √7. -/

#print axioms FieldWall.normSq_moserTwist
#print axioms FieldWall.moserTwist_mul_seam_sq
#print axioms FieldWall.moserTwist_eq_zeta6_cube_mul_seam_inv_sq

/-! ## M32 — the quadrature kill (the 2-adic engine's first theorems)

The block-split arithmetic one field up: `sqrt5_indep` by mod-5 descent (one ZMod-5 kernel
decide + strong induction), the `sqrt15_split` workhorse, the flat eight-term independence,
the geometric quadrature law (M31's G12, ρ₁₅ instance), and the distance-2 pair's tangency
anchor. -/

#print axioms Quadrature.sqrt5_indep
#print axioms Quadrature.sqrt15_split
#print axioms Quadrature.sqrt_indep₈
#print axioms Quadrature.normSq_rho15
#print axioms Quadrature.quadrature_rho15
#print axioms Quadrature.pair_tangency

/-! ## M34 — Act One as kernel theorems

The pigeonhole bridge (class avoidance = colourability of the augmented graph), the
criticality factorization A1 (unconditional), and the two pigeonhole carriers: the
nine-point √3-pair core (two transmuter forcings composed, no search) and the 122-point
distance-2 core (an LRAT certificate on the augmented list, replayed by the kernel), each
with its plane-level corollary — no proper 4-colouring of the plane avoids monochromatic
pairs at distance √3, nor at distance 2. -/

#print axioms mono_pair_of_not_colorable_append
#print axioms not_colorable_iff_covers
#print axioms UDCert.pairsAt_sound
#print axioms core9_pigeonhole
#print axioms core9_plane
#print axioms core9_pairs_complete
#print axioms core122_unsat
#print axioms core122_pigeonhole
#print axioms core122_plane
#print axioms core122_pairs_complete

-- M35: the clique face of the bridge and the hexagonal-shell pigeonhole
#print axioms mono_pair_of_clique
#print axioms hexShell_pigeonhole
#print axioms hexShell_plane5
#print axioms hexShell_plane6
#print axioms hexShell_p3_complete
#print axioms hexShell_p4_complete

-- M35: the brick certificate machinery and the first certified upper bound
#print axioms Brick.sound
#print axioms Brick.colorable
#print axioms Brick.avoids
#print axioms Brick.colorQ_eq
#print axioms plane_colorable_nine
#print axioms nine_avoids_sqrt_three_halves

-- M36: the boundary-tight sharpening and the classical upper bound
#print axioms Brick.check_pos
#print axioms Brick.sq_lt_of_abs_lt
#print axioms Brick.lt_sq_of_abs_lt
#print axioms Brick.le_sq_of_abs_lt
#print axioms plane_colorable_seven
#print axioms chromaticNumber_plane_le_seven
#print axioms chromaticNumber_plane_interval

-- M37: the coset bound
#print axioms Coset.seven_le_hexQi
#print axioms Coset.shell_rainbow
#print axioms Coset.seven_values
#print axioms Coset.seven_le_card
#print axioms Coset.exists_proper_coset_colouring
#print axioms Coset.coset_chromatic_eq_seven
-- M38: the coarse-cell bound, with no homomorphism hypothesis
#print axioms Coset.exists_unit_pair
#print axioms Coset.seven_labels_of_cell_constant
#print axioms Coset.seven_le_card_of_cell_constant
#print axioms Coset.cell_chromatic_eq_seven
#print axioms Coset.eight_le_card_of_cell_constant
#print axioms Coset.seven_le_card_fine
-- M42: the gap atlas, kernel side — the windows, the coset impossibility, the 23-core
#print axioms Coset.seven_le_card_shell4
#print axioms Coset.twelve_le_card_of_cell_constant
#print axioms Coset.exists_kernel_vector
#print axioms Coset.no_coset_seven_on_gap
#print axioms core23_unsat
#print axioms core23_not_colorable_six
#print axioms core23_colorable_seven
#print axioms Coset.seven_le_card_gap

#eval IO.println "=== PURCHASED ==="

/-! ## M03 — the certificate routes

Each of these evaluates `LRAT.check` by `native_decide`, which is the only thing that can evaluate
it (see `Sat/Lrat.lean`). The bound they reach is the same one `four_le_chromaticNumber_plane`
reaches above without them — which is the point of proving it twice. -/

#print axioms moserSpindle_cnf_unsat
#print axioms moserSpindle_not_colorable_three_lrat
#print axioms moserSpindleCubes_unsat
#print axioms moserSpindle_not_colorable_three_cubes
#print axioms four_le_chromaticNumber_plane_certified

