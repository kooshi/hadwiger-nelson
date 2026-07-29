import Proofs.HadwigerNelson.Instances.DeGrey.Edges

/-!
# `deGrey` — geometry for edges 2500–2999

One `decide +kernel` per chunk: the kernel evaluates the check once, where plain
`decide` evaluates it twice (elaborator, then kernel) and exhausts the heartbeat
budget past ~250 edges. Many small chunks rather than one large one — each
reduction is transient, so the module's peak memory tracks the chunk, not the module.
-/

namespace HadwigerNelson

theorem deGreyChunk050_valid : deGrey.ValidOn deGreyChunk050 = true := sorry
theorem deGreyChunk051_valid : deGrey.ValidOn deGreyChunk051 = true := sorry
theorem deGreyChunk052_valid : deGrey.ValidOn deGreyChunk052 = true := sorry
theorem deGreyChunk053_valid : deGrey.ValidOn deGreyChunk053 = true := sorry
theorem deGreyChunk054_valid : deGrey.ValidOn deGreyChunk054 = true := sorry
theorem deGreyChunk055_valid : deGrey.ValidOn deGreyChunk055 = true := sorry
theorem deGreyChunk056_valid : deGrey.ValidOn deGreyChunk056 = true := sorry
theorem deGreyChunk057_valid : deGrey.ValidOn deGreyChunk057 = true := sorry
theorem deGreyChunk058_valid : deGrey.ValidOn deGreyChunk058 = true := sorry
theorem deGreyChunk059_valid : deGrey.ValidOn deGreyChunk059 = true := sorry

end HadwigerNelson
