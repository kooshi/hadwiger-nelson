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
#print axioms add_one_le_chromaticNumber_unitDistance_edgeList

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

`deGrey_not_colorable_four` is the claim no human can check by inspection — it quantifies over `4^1581`
assignments — so it is the one where a native-evaluation axiom would matter most. It is clean. -/

#print axioms edgeGraph_adj_mono
#print axioms valid_comp_of_injective
#print axioms exists_perm_apply_eq
#print axioms not_pinned
#print axioms runSegment_sound
#print axioms justified_of_segment
#print axioms unsat_of_segment
#print axioms exists_normalized
#print axioms eq_of_pinned_unsat
#print axioms not_colorable_of_forcing
#print axioms deGrey_halfA_subset
#print axioms deGrey_halfB_subset
#print axioms deGrey_adj_cross
#print axioms halfA_unsat
#print axioms halfB_unsat
#print axioms deGrey_not_colorable_four
#print axioms chromaticNumber_plane_ge_five

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
