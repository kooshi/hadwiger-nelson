import Proofs.HadwigerNelson.Arith.FibreCert11Seg7

/-!
# FS-66's certificate at `p = 11`: the shape (FS131-IKC3)

One declaration, by kernel reduction: phase 1's transporters and its bound, its orbit rows equal to the certificate's
literals, the q-part's transporters, the blocks' sizes and the weight indices (`globalOK`). The import of the previous
module only orders the build.
-/

namespace HadwigerNelson.FibreCert

/-- The shape of the `p = 11` certificate passes. -/
theorem cert11_global : globalOK cert11 = true := by decide +kernel

end HadwigerNelson.FibreCert
