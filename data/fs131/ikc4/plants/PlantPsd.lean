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
-- twin: cert19_psd1 (Arith/FibreCert19Psd0)
/-- Double `M[0][0]` of a PSD witness (digit 1 of row 0 holds `M[0][0] + Cm`). -/
def bumpM (b : Blk) : Blk :=
  { b with mrows := match b.mrows with
    | r0 :: rs => Nat.add r0 (Nat.shiftLeft (Nat.sub (digit r0 b.wB 1) (Nat.add (Nat.shiftLeft 1 (Nat.sub b.wm 1)) 1)) b.wB) :: rs
    | [] => [] }
theorem plant : psdCheck (bumpM cert19_b1) = false := by decide +kernel
end HadwigerNelson.FibreCert
