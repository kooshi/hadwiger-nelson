import Bad11U
open HadwigerNelson.FibreCert
#eval (segCheck cert11 0, segCheck cert11 1)
theorem t : segCheck cert11 0 = false := by decide +kernel
