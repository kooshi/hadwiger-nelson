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
-- twin: cert19_kt1_ok (Arith/FibreCert19Kt0)
/-- Move slot 5 of map 5, block 0, by one in the literal. -/
def bumpKt (l : List ((Nat × Nat × Nat) × List (Nat × Nat))) : List ((Nat × Nat × Nat) × List (Nat × Nat)) :=
  match l with
  | (g, (P, N) :: rs) :: t => (g, (Nat.add P (Nat.shiftLeft 1 (Nat.mul cert19.w 5)), N) :: rs) :: t
  | l => l
theorem plant : ktEq (((ktable cert19).drop (5 * 1)).take 5) (bumpKt cert19_kt1) = false := by decide +kernel
end HadwigerNelson.FibreCert
