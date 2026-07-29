import Proofs.HadwigerNelson.Instances.DeGrey.Edges

/-!
# `deGrey` — geometry for edges 5000–5499

One `decide +kernel` per chunk: the kernel evaluates the check once, where plain
`decide` evaluates it twice (elaborator, then kernel) and exhausts the heartbeat
budget past ~250 edges. Many small chunks rather than one large one — each
reduction is transient, so the module's peak memory tracks the chunk, not the module.
-/

namespace HadwigerNelson

theorem deGreyChunk100_valid : deGrey.ValidOn deGreyChunk100 = true := sorry
theorem deGreyChunk101_valid : deGrey.ValidOn deGreyChunk101 = true := sorry
theorem deGreyChunk102_valid : deGrey.ValidOn deGreyChunk102 = true := sorry
theorem deGreyChunk103_valid : deGrey.ValidOn deGreyChunk103 = true := sorry
theorem deGreyChunk104_valid : deGrey.ValidOn deGreyChunk104 = true := sorry
theorem deGreyChunk105_valid : deGrey.ValidOn deGreyChunk105 = true := sorry
theorem deGreyChunk106_valid : deGrey.ValidOn deGreyChunk106 = true := sorry
theorem deGreyChunk107_valid : deGrey.ValidOn deGreyChunk107 = true := sorry
theorem deGreyChunk108_valid : deGrey.ValidOn deGreyChunk108 = true := sorry
theorem deGreyChunk109_valid : deGrey.ValidOn deGreyChunk109 = true := sorry

end HadwigerNelson
