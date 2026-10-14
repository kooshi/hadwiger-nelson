import Cert3
open HadwigerNelson.FibreCert
theorem psd3 : psdCheck (cert3.blocksq.headD default) = true := by decide +kernel
