import Proofs.HadwigerNelson.Arith.FibreCert11Global

/-!
# FS-66's certificate at `p = 11`: positive definiteness (FS131-IKC3)

One declaration, by kernel reduction: each of the 22 blocks passes `psdCheck`. The import of the previous module only
orders the build.
-/

namespace HadwigerNelson.FibreCert

/-- Every block of the `p = 11` certificate passes the PSD check. -/
theorem cert11_psd : psdAll cert11 = true := by decide +kernel

end HadwigerNelson.FibreCert
