import Proofs.HadwigerNelson.Arith.FibreCert19
import Proofs.HadwigerNelson.Arith.FibreCertFast
-- FS131-IKC4 probe (not a library module): one declaration, measured under the slot with /usr/bin/time -v.
namespace HadwigerNelson.FibreCert
set_option maxHeartbeats 0
theorem probe : ktEq (((ktable cert19).drop 5).take 5) cert19_kt1 = true := by decide +kernel
end HadwigerNelson.FibreCert
