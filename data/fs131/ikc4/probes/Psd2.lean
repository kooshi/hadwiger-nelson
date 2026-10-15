import Proofs.HadwigerNelson.Arith.FibreCert19
-- FS131-IKC4 probe: two PSD declarations in one file, default options (is memory freed between declarations? do default heartbeats suffice?).
namespace HadwigerNelson.FibreCert
theorem probe1 : psdCheck cert19_b1 = true := by decide +kernel
theorem probe2 : psdCheck cert19_b2 = true := by decide +kernel
end HadwigerNelson.FibreCert
