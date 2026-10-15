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
-- twin: cert19_globalP (Arith/FibreCert19Global); the last orbit row is corrupted
/-- Add 1 to the negative part of the last orbit row of the last bucket. -/
def bumpBLast (B : List (List ORow)) : List (List ORow) :=
  B.modify (B.length - 1) fun b => b.modify (b.length - 1) fun o => (o.1, o.2.1, o.2.2.1, Nat.add o.2.2.2 1)
theorem plant : globalOKP cert19 ((bumpBLast cert19_p1s8).flatten, true, cert19_p1b8) = false := by decide +kernel
end HadwigerNelson.FibreCert
