import Proofs.HadwigerNelson.Instances.DeGrey.Edges

/-!
# `deGrey` — geometry for edges 3000–3499

One `decide +kernel` per chunk: the kernel evaluates the check once, where plain
`decide` evaluates it twice (elaborator, then kernel) and exhausts the heartbeat
budget past ~250 edges. Many small chunks rather than one large one — each
reduction is transient, so the module's peak memory tracks the chunk, not the module.
-/

namespace HadwigerNelson

theorem deGreyChunk060_valid : deGrey.ValidOn deGreyChunk060 = true := sorry
theorem deGreyChunk061_valid : deGrey.ValidOn deGreyChunk061 = true := sorry
theorem deGreyChunk062_valid : deGrey.ValidOn deGreyChunk062 = true := sorry
theorem deGreyChunk063_valid : deGrey.ValidOn deGreyChunk063 = true := sorry
theorem deGreyChunk064_valid : deGrey.ValidOn deGreyChunk064 = true := sorry
theorem deGreyChunk065_valid : deGrey.ValidOn deGreyChunk065 = true := sorry
theorem deGreyChunk066_valid : deGrey.ValidOn deGreyChunk066 = true := sorry
theorem deGreyChunk067_valid : deGrey.ValidOn deGreyChunk067 = true := sorry
theorem deGreyChunk068_valid : deGrey.ValidOn deGreyChunk068 = true := sorry
theorem deGreyChunk069_valid : deGrey.ValidOn deGreyChunk069 = true := sorry

end HadwigerNelson
