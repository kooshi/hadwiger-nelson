import Cert11
open HadwigerNelson.FibreCert
theorem psdb : psdCheck (cert11.blocks1.getD 1 ⟨[],0,0,0,[],[],0,0,0,[]⟩) = true := by decide +kernel
