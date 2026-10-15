import Proofs.HadwigerNelson.Rigidity.ClassRatio
import Proofs.HadwigerNelson.Arith.FibreCert11Bound
/-! FS131-IKL1 readback: the statements the link reads and closes, printed from the compiled library. -/
open HadwigerNelson HadwigerNelson.Rigidity SpectralChain NumberField
set_option pp.fullNames true
namespace HadwigerNelson.Rigidity
open private ratioAtMost_cert from Proofs.HadwigerNelson.Rigidity.ClassRatio
#check @ratioAtMost_cert
#print axioms ratioAtMost_cert
end HadwigerNelson.Rigidity
#print HadwigerNelson.Rigidity.RatioAtMost
#print HadwigerNelson.SpectralChain.levelTarget
#check @HadwigerNelson.FibreCertSound.sum_le_eleven
#print axioms HadwigerNelson.FibreCertSound.sum_le_eleven
#check @HadwigerNelson.FibreCertSound.card_le_eleven
#print axioms HadwigerNelson.FibreCertSound.card_le_eleven
#print HadwigerNelson.FibreCertSound.qform
#print HadwigerNelson.FibreCertSound.unitCircle
#print HadwigerNelson.FibreCertSound.V
#check @HadwigerNelson.Rigidity.ratioAtMost_of_five_le_chromaticNumber
#print axioms HadwigerNelson.Rigidity.ratioAtMost_of_five_le_chromaticNumber
#check @HadwigerNelson.Rigidity.ratioAtMost_of_two_notMem
