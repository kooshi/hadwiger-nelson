import Proofs.HadwigerNelson.Instances.DeGrey.Edges

/-!
# `deGrey` — geometry for edges 1500–1999

One `decide +kernel` per chunk: the kernel evaluates the check once, where plain
`decide` evaluates it twice (elaborator, then kernel) and exhausts the heartbeat
budget past ~250 edges. Many small chunks rather than one large one — each
reduction is transient, so the module's peak memory tracks the chunk, not the module.
-/

namespace HadwigerNelson

theorem deGreyChunk030_valid : deGrey.ValidOn deGreyChunk030 = true := sorry
theorem deGreyChunk031_valid : deGrey.ValidOn deGreyChunk031 = true := sorry
theorem deGreyChunk032_valid : deGrey.ValidOn deGreyChunk032 = true := sorry
theorem deGreyChunk033_valid : deGrey.ValidOn deGreyChunk033 = true := sorry
theorem deGreyChunk034_valid : deGrey.ValidOn deGreyChunk034 = true := sorry
theorem deGreyChunk035_valid : deGrey.ValidOn deGreyChunk035 = true := sorry
theorem deGreyChunk036_valid : deGrey.ValidOn deGreyChunk036 = true := sorry
theorem deGreyChunk037_valid : deGrey.ValidOn deGreyChunk037 = true := sorry
theorem deGreyChunk038_valid : deGrey.ValidOn deGreyChunk038 = true := sorry
theorem deGreyChunk039_valid : deGrey.ValidOn deGreyChunk039 = true := sorry

end HadwigerNelson
