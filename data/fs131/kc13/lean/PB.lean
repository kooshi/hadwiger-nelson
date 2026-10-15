import Cert11
open HadwigerNelson.FibreCert
def bk (k : Nat) : Blk := cert11.blocks1.getD k ⟨[],0,0,0,[],[],0,0,0,[]⟩
def ones (b : Blk) : Nat := (List.range b.m).foldl (fun a k => Nat.add a (Nat.shiftLeft 1 (Nat.mul b.wB k))) 0
def sigH (b : Blk) : Nat := (b.mrows.map fun f => digit (Nat.mul f (ones b)) b.wB (b.m - 1)).foldl Nat.add 0
def revH (b : Blk) : Nat := (b.mrows.map (revRow b.wB b.m)).foldl Nat.xor 0
#eval ((bk 1).wr, (bk 1).wm, (bk 1).wB, (bk 1).sb, (bk 0).wr, (bk 0).wm, (bk 0).wB, (bk 1).per, (bk 1).rest.length)
#eval (sigH (bk 1) % 1000003, revH (bk 1) % 1000003)
#eval (revH (bk 0) % 1000003)
def rev1 (b : Blk) (k : Nat) : Nat := revRow b.wB b.m (b.mrows.getD k 0)
#eval ((List.range 63).map fun k => (rev1 (bk 1) k % 1000)).take 5
