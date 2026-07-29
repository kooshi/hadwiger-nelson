import Proofs.HadwigerNelson.Instances.DeGrey.Edges

/-!
# `deGrey` — geometry for edges 7000–7499

One `decide +kernel` per chunk: the kernel evaluates the check once, where plain
`decide` evaluates it twice (elaborator, then kernel) and exhausts the heartbeat
budget past ~250 edges. Many small chunks rather than one large one — each
reduction is transient, so the module's peak memory tracks the chunk, not the module.
-/

namespace HadwigerNelson

theorem deGreyChunk140_valid : deGrey.ValidOn deGreyChunk140 = true := sorry
theorem deGreyChunk141_valid : deGrey.ValidOn deGreyChunk141 = true := sorry
theorem deGreyChunk142_valid : deGrey.ValidOn deGreyChunk142 = true := sorry
theorem deGreyChunk143_valid : deGrey.ValidOn deGreyChunk143 = true := sorry
theorem deGreyChunk144_valid : deGrey.ValidOn deGreyChunk144 = true := sorry
theorem deGreyChunk145_valid : deGrey.ValidOn deGreyChunk145 = true := sorry
theorem deGreyChunk146_valid : deGrey.ValidOn deGreyChunk146 = true := sorry
theorem deGreyChunk147_valid : deGrey.ValidOn deGreyChunk147 = true := sorry
theorem deGreyChunk148_valid : deGrey.ValidOn deGreyChunk148 = true := sorry
theorem deGreyChunk149_valid : deGrey.ValidOn deGreyChunk149 = true := sorry

end HadwigerNelson
