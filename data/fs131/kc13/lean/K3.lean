import Cert3
open HadwigerNelson.FibreCert
#eval segCheck cert3 0
set_option profiler true in
theorem ok3 : segCheck cert3 0 = true := by decide +kernel
