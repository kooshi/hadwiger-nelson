import Proofs

/-!
# Axiom audit — the trust receipt

The de Bruijn criterion made a standing check: everything shipped reduces to what the kernel
verified plus what we explicitly chose to trust. One `#print axioms` line per public theorem on the
milestone's surface; the gate reads this output and fails on a leftover `sorryAx` or an unaudited
custom axiom.

Run it:  `lake env lean scripts/Axioms.lean`

**M01 — the statement. M02 — exact geometry.** Expected on every line: exactly `propext`,
`Classical.choice`, `Quot.sound`. No `sorryAx`, and nothing native.

`moserSpindle_valid` is the one to watch: it is discharged by `decide`, so it is the first
declaration in this development whose truth rests on kernel *reduction* rather than on a written
proof.

**What a native purchase looks like here — grep for this, not for `Lean.ofReduceBool`.** At
toolchain v4.32.0 `native_decide` mints a per-declaration axiom and `Lean.ofReduceBool` does not
appear at all:

```
'foo' depends on axioms: [propext, Classical.choice, Quot.sound, foo._native.native_decide.ax_1_1]
```

so the audit is `grep 'native_decide\.ax'` over this file's output. Measured 2026-07-27; an audit
written against the old name would pass a purchase in silence.
-/

open HadwigerNelson

-- The reduction and its API.
#print axioms lt_chromaticNumber_iff_not_colorable
#print axioms add_one_le_chromaticNumber_iff_not_colorable
#print axioms lt_chromaticNumber_unitDistance
#print axioms add_one_le_chromaticNumber_unitDistance
#print axioms chromaticNumber_unitDistance_congr
#print axioms add_one_le_chromaticNumber_unitDistance_edgeList

-- The model of the hypotheses, and the headline.
#print axioms trianglePoints_dist
#print axioms not_colorable_two_top_fin_three
#print axioms edgeGraph_triangleEdges_eq_top
#print axioms three_le_chromaticNumber_unitDistance_complex
#print axioms three_le_chromaticNumber_unitDistance_complex'
#print axioms three_le_chromaticNumber_plane

-- M02: the exact-arithmetic tower and the certificate bridge.
#print axioms Q4.eval
#print axioms eval_distSq
#print axioms dist_toPlane_eq_one
#print axioms UDCert.validOn_iff
#print axioms UDCert.valid_of_chunks
#print axioms UDCert.valid_sound
#print axioms UDCert.add_one_le_chromaticNumber_of_valid

-- The kernel-decided instance: the spindle's geometry.
#print axioms moserSpindleChunk0_valid
#print axioms moserSpindle_valid
