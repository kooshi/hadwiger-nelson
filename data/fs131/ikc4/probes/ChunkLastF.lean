import Proofs.HadwigerNelson.Arith.FibreCert19
import Proofs.HadwigerNelson.Arith.FibreCertFast
-- FS131-IKC4 probe (not a library module): the cost of one chunk of phase 1 (p1stepZ, the K table as literals).
namespace HadwigerNelson.FibreCert
set_option maxHeartbeats 0
theorem probe : (fun (s : P1St) => s.2.1 && Nat.blt s.2.2.1 (Nat.shiftLeft 1 cert19.w) && s.1.all (fun bk => bk.all fun o => Nat.blt o.2.2.1 (Nat.shiftLeft 1 46000) && Nat.blt o.2.2.2 (Nat.shiftLeft 1 46000))) (((repPairs 182).drop 14571).foldl (p1stepF cert19 cert19_kt (cert19.blocks1.map (kmax cert19))) (p1AtF cert19 (bucket16 (cert19.orbits.map (fun o => (o.1, o.2, 0, 0)))) true 0 14571)) = true := by decide +kernel
end HadwigerNelson.FibreCert
