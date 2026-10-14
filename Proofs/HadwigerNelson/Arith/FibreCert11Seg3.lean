import Proofs.HadwigerNelson.Arith.FibreCert11Seg2

/-!
# FS-66's certificate at `p = 11`: identity segment 3 of 8 (FS131-IKC3)

One declaration, by kernel reduction: the ops whose slot lies in leaves 24–31 balance, and every op's slot
is owned by a segment below 8. The import of the previous module only orders the build (one segment compiled at a time).
-/

namespace HadwigerNelson.FibreCert

/-- Segment 3 of the `p = 11` identity passes. -/
theorem cert11_seg3 : segCheck cert11 3 = true := by decide +kernel

end HadwigerNelson.FibreCert
