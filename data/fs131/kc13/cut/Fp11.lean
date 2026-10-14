import Cert11
open HadwigerNelson.FibreCert
def hk : Nat := (ktable cert11).foldl (fun a e => Nat.add a (e.2.foldl (fun b x => Nat.add b (Nat.add x.1 x.2)) 0)) 0
def hp : Nat := (OT.toList (phase1 cert11).1).foldl (fun a r => Nat.add a (Nat.add r.2.2.1 r.2.2.2)) 0
#eval (hk % 1000007, hp % 1000007, segCheck cert11 77)
