import Cert11
open HadwigerNelson.FibreCert
set_option profiler true in
theorem psd11 : psdAll cert11 = true := by decide +kernel
