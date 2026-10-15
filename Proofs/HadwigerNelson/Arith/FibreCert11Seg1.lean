import Proofs.HadwigerNelson.Arith.FibreCert11Seg0

/-!
# FS-66's certificate at `p = 11`: identity segment 1 of 8 (FS131-IKC3)

One declaration, by kernel reduction: the ops whose slot lies in leaves 8–15 balance, and every op's slot
is owned by a segment below 8. The import of the previous module only orders the build (one segment compiled at a time).
-/

namespace HadwigerNelson.FibreCert

/-- Segment 1 of the `p = 11` identity passes. -/
theorem cert11_seg1 : segCheck cert11 1 = true := by decide +kernel

end HadwigerNelson.FibreCert
