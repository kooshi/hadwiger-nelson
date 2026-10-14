import Proofs.HadwigerNelson.Arith.FibreCert19
import Proofs.HadwigerNelson.Arith.FibreCertFast
-- FS131-IKC4 probe (not a library module): one declaration, measured under the slot with /usr/bin/time -v.
namespace HadwigerNelson.FibreCert
set_option maxHeartbeats 0
theorem probe1 : (ktable cert19).length = 40 := by decide +kernel
theorem probe2 : cert19.nseg = 4 := rfl
end HadwigerNelson.FibreCert
