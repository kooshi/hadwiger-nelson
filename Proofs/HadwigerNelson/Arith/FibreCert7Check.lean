import Proofs.HadwigerNelson.Arith.FibreCert7

/-!
# FS-66's certificate at `p = 7`: the kernel's three checks (FS131-IQP1)

Three declarations, by kernel reduction, as FS131-KPA1 measured them (`data/fs131/kpa1/cert7/check.log`: 48.8 s wall,
2.89 GB): the shape and phase 1 (`cert7_global`), the one identity segment (`cert7_seg0`), and positive definiteness of
the 14 blocks (`cert7_psd`). No `native_decide`.
-/

namespace HadwigerNelson.FibreCert

/-- The shape and phase 1 of the `p = 7` certificate pass. -/
theorem cert7_global : globalOK cert7 = true := by decide +kernel

/-- The one identity segment of the `p = 7` certificate passes. -/
theorem cert7_seg0 : segCheck cert7 0 = true := by decide +kernel

/-- Every block of the `p = 7` certificate passes the PSD check. -/
theorem cert7_psd : psdAll cert7 = true := by decide +kernel

end HadwigerNelson.FibreCert
