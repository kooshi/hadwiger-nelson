/-- FS131-KPA1 probe: the shape and phase 1 at p = 7. -/
theorem cert7_global : globalOK cert7 = true := by decide +kernel
/-- FS131-KPA1 probe: the one identity segment at p = 7. -/
theorem cert7_seg0 : segCheck cert7 0 = true := by decide +kernel
/-- FS131-KPA1 probe: positive definiteness at p = 7. -/
theorem cert7_psd : psdAll cert7 = true := by decide +kernel
