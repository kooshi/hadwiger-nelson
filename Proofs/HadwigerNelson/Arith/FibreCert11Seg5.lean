import Proofs.HadwigerNelson.Arith.FibreCert11Seg4

/-!
# FS-66's certificate at `p = 11`: identity segment 5 of 8 (FS131-IKC3)

One declaration, by kernel reduction: the ops whose slot lies in leaves 40–47 balance, and every op's slot
is owned by a segment below 8. The import of the previous module only orders the build (one segment compiled at a time).
-/

namespace HadwigerNelson.FibreCert

/-- Segment 5 of the `p = 11` identity passes. -/
theorem cert11_seg5 : segCheck cert11 5 = true := by decide +kernel

end HadwigerNelson.FibreCert
