import Proofs.HadwigerNelson.Instances.DeGrey.Edges

/-!
# `deGrey` — geometry for edges 4000–4499

One `decide +kernel` per chunk: the kernel evaluates the check once, where plain
`decide` evaluates it twice (elaborator, then kernel) and exhausts the heartbeat
budget past ~250 edges. Many small chunks rather than one large one — each
reduction is transient, so the module's peak memory tracks the chunk, not the module.
-/

namespace HadwigerNelson

theorem deGreyChunk080_valid : deGrey.ValidOn deGreyChunk080 = true := sorry
theorem deGreyChunk081_valid : deGrey.ValidOn deGreyChunk081 = true := sorry
theorem deGreyChunk082_valid : deGrey.ValidOn deGreyChunk082 = true := sorry
theorem deGreyChunk083_valid : deGrey.ValidOn deGreyChunk083 = true := sorry
theorem deGreyChunk084_valid : deGrey.ValidOn deGreyChunk084 = true := sorry
theorem deGreyChunk085_valid : deGrey.ValidOn deGreyChunk085 = true := sorry
theorem deGreyChunk086_valid : deGrey.ValidOn deGreyChunk086 = true := sorry
theorem deGreyChunk087_valid : deGrey.ValidOn deGreyChunk087 = true := sorry
theorem deGreyChunk088_valid : deGrey.ValidOn deGreyChunk088 = true := sorry
theorem deGreyChunk089_valid : deGrey.ValidOn deGreyChunk089 = true := sorry

end HadwigerNelson
