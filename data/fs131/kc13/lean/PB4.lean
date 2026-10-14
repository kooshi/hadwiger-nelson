import Cert11
open HadwigerNelson.FibreCert
def bk (k : Nat) : Blk := cert11.blocks1.getD k ⟨[],0,0,0,[],[],0,0,0,[]⟩
def revA (b : Blk) : Nat := (b.mrows.map (revRow b.wB b.m)).foldl Nat.add 0
def revA2 (b : Blk) : Nat := (b.mrows.take 32 |>.map (revRow b.wB b.m)).foldl Nat.add 0
#eval (revA (bk 1) % 1000003, revA (bk 2) % 1000003, revA2 (bk 1) % 1000003)
theorem t : revA2 (bk 1) % 1000003 = 583598 := by decide +kernel
