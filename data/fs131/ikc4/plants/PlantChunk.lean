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
-- twin: cert19_p1c0 (Arith/FibreCert19C0)
theorem plant : p1CoreEq ((((repPairs cert19.reps.length).drop 0).take 2081).foldl
    (p1stepF cert19 cert19_kt (cert19.blocks1.map (kmax cert19)))
    (p1AtF cert19 (bucket16 (cert19.orbits.map fun o => (o.1, o.2, 0, 0))) true 0 0))
    (bumpB cert19_p1s1) cert19_p1b1 = false := by decide +kernel
end HadwigerNelson.FibreCert
