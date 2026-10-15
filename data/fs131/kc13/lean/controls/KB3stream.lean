import Bad3stream
open HadwigerNelson.FibreCert
theorem t : (segCheck cert3 0 && psdAll cert3) = true := by decide +kernel
