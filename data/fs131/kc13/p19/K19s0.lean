import Cert19
open HadwigerNelson.FibreCert
set_option profiler true in
theorem ok19_0 : segCheck cert19 0 = true := by decide +kernel
