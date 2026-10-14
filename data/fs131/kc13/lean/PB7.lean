import Cert11
open HadwigerNelson.FibreCert
def bk (k : Nat) : Blk := cert11.blocks1.getD k ⟨[],0,0,0,[],[],0,0,0,[]⟩
def revRow2 (wB m x : Nat) : Nat :=
  (List.range m).foldl (fun a k => Nat.add a (Nat.shiftLeft (digit x wB k) (Nat.mul wB (Nat.sub (Nat.sub m 1) k)))) 0
def revB (b : Blk) : Nat := (b.mrows.map (revRow2 b.wB b.m)).foldl Nat.add 0
#eval revB (bk 1) % 1000003
