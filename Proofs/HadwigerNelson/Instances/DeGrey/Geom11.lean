import Proofs.HadwigerNelson.Instances.DeGrey.Edges

/-!
# `deGrey` — geometry for edges 5500–5999

One `decide +kernel` per chunk: the kernel evaluates the check once, where plain
`decide` evaluates it twice (elaborator, then kernel) and exhausts the heartbeat
budget past ~250 edges. Many small chunks rather than one large one — each
reduction is transient, so the module's peak memory tracks the chunk, not the module.
-/

namespace HadwigerNelson

theorem deGreyChunk110_valid : deGrey.ValidOn deGreyChunk110 = true := sorry
theorem deGreyChunk111_valid : deGrey.ValidOn deGreyChunk111 = true := sorry
theorem deGreyChunk112_valid : deGrey.ValidOn deGreyChunk112 = true := sorry
theorem deGreyChunk113_valid : deGrey.ValidOn deGreyChunk113 = true := sorry
theorem deGreyChunk114_valid : deGrey.ValidOn deGreyChunk114 = true := sorry
theorem deGreyChunk115_valid : deGrey.ValidOn deGreyChunk115 = true := sorry
theorem deGreyChunk116_valid : deGrey.ValidOn deGreyChunk116 = true := sorry
theorem deGreyChunk117_valid : deGrey.ValidOn deGreyChunk117 = true := sorry
theorem deGreyChunk118_valid : deGrey.ValidOn deGreyChunk118 = true := sorry
theorem deGreyChunk119_valid : deGrey.ValidOn deGreyChunk119 = true := sorry

end HadwigerNelson
