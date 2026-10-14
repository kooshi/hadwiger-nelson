import Cert7
open HadwigerNelson.FibreCert
set_option profiler true in
theorem ok7 : segCheck cert7 0 = true := by decide +kernel
