import Cert11
open HadwigerNelson.FibreCert
set_option profiler true in
theorem ok11_0 : segCheck cert11 0 = true := by decide +kernel
