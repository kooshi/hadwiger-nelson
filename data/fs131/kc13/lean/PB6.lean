import Cert11
open HadwigerNelson.FibreCert
def bk (k : Nat) : Blk := cert11.blocks1.getD k ⟨[],0,0,0,[],[],0,0,0,[]⟩
def rev1 (b : Blk) (k : Nat) : Nat := revRow b.wB b.m (b.mrows.getD k 0)
def idA (b : Blk) : Nat := (b.mrows.map id).foldl Nat.add 0
#eval (rev1 (bk 1) 62 % 1000, rev1 (bk 1) 40 % 1000, idA (bk 1) % 1000003)
theorem t : idA (bk 1) % 1000003 = 329555 := by decide +kernel
