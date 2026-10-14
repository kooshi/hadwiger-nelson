import Bad3rowlam
open HadwigerNelson.FibreCert
theorem t : (segCheck cert3 0 && psdAll cert3) = false := by decide +kernel
