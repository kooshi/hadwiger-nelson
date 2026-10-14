import Proofs.HadwigerNelson.Arith.FibreCert19
import Proofs.HadwigerNelson.Arith.FibreCertFast
-- FS131-IKC4 planted control (not a library module): one corrupted entry in one new part; the kernel must prove the
-- check returns false. Its unplanted twin is the library theorem named below.
namespace HadwigerNelson.FibreCert
/-- Add 1 to the positive part of the first orbit row of the first bucket. -/
def bumpB (B : List (List ORow)) : List (List ORow) :=
  match B with
  | ((a0, a1, P, N) :: r) :: t => ((a0, a1, Nat.add P 1, N) :: r) :: t
  | B => B
-- twin: cert19_seg0 (Arith/FibreCert19Seg0). The heartbeat limit is lifted: with the default, elaboration stopped at 73 s.
set_option maxHeartbeats 0
theorem plant : segCheckZ { cert19 with unum := Nat.sub cert19.unum 1 } 0 = false := by decide +kernel
end HadwigerNelson.FibreCert
