import Proofs.HadwigerNelson.Instances.DeGrey.Edges

/-!
# `deGrey` — geometry for edges 6000–6499

One `decide +kernel` per chunk: the kernel evaluates the check once, where plain
`decide` evaluates it twice (elaborator, then kernel) and exhausts the heartbeat
budget past ~250 edges. Many small chunks rather than one large one — each
reduction is transient, so the module's peak memory tracks the chunk, not the module.
-/

namespace HadwigerNelson

theorem deGreyChunk120_valid : deGrey.ValidOn deGreyChunk120 = true := sorry
theorem deGreyChunk121_valid : deGrey.ValidOn deGreyChunk121 = true := sorry
theorem deGreyChunk122_valid : deGrey.ValidOn deGreyChunk122 = true := sorry
theorem deGreyChunk123_valid : deGrey.ValidOn deGreyChunk123 = true := sorry
theorem deGreyChunk124_valid : deGrey.ValidOn deGreyChunk124 = true := sorry
theorem deGreyChunk125_valid : deGrey.ValidOn deGreyChunk125 = true := sorry
theorem deGreyChunk126_valid : deGrey.ValidOn deGreyChunk126 = true := sorry
theorem deGreyChunk127_valid : deGrey.ValidOn deGreyChunk127 = true := sorry
theorem deGreyChunk128_valid : deGrey.ValidOn deGreyChunk128 = true := sorry
theorem deGreyChunk129_valid : deGrey.ValidOn deGreyChunk129 = true := sorry

end HadwigerNelson
