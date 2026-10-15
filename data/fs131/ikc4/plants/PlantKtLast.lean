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
-- twin: cert19_kt7_ok (Arith/FibreCert19Kt3); the corrupted entry is the last the check compares
/-- Add one to the negative part of the last block of the last map. -/
def bumpLast (l : List ((Nat × Nat × Nat) × List (Nat × Nat))) : List ((Nat × Nat × Nat) × List (Nat × Nat)) :=
  l.modify (l.length - 1) fun e => (e.1, e.2.modify (e.2.length - 1) fun x => (x.1, Nat.add x.2 1))
theorem plant : ktEq (((ktable cert19).drop (5 * 7)).take 5) (bumpLast cert19_kt7) = false := by decide +kernel
end HadwigerNelson.FibreCert
