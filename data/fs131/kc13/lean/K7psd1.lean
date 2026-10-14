import Cert7
open HadwigerNelson.FibreCert
theorem psd7 : psdCheck (cert7.blocks1.headD (cert7.blocksq.headD ⟨[],0,0,0,[],[],0,0,0,[]⟩)) = true := by decide +kernel
