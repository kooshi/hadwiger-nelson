import Cert11
open HadwigerNelson.FibreCert
set_option profiler true in
theorem ok11_1 : segCheck cert11 1 = true := by decide +kernel
