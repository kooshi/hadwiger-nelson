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

`moserSpindle_valid` is the one to watch in the clean section: it is discharged by `decide`, so it
is the first declaration in this development whose truth rests on kernel *reduction* rather than on
a written proof — and it stays inside the standard axiom set.
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
#print axioms moserSpindleChunk0_valid
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
