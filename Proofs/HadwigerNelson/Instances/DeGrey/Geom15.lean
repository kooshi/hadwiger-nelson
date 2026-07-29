import Proofs.HadwigerNelson.Instances.DeGrey.Edges

/-!
# `deGrey` — geometry for edges 7500–7876

One `decide +kernel` per chunk: the kernel evaluates the check once, where plain
`decide` evaluates it twice (elaborator, then kernel) and exhausts the heartbeat
budget past ~250 edges. Many small chunks rather than one large one — each
reduction is transient, so the module's peak memory tracks the chunk, not the module.
-/

namespace HadwigerNelson

theorem deGreyChunk150_valid : deGrey.ValidOn deGreyChunk150 = true := sorry
theorem deGreyChunk151_valid : deGrey.ValidOn deGreyChunk151 = true := sorry
theorem deGreyChunk152_valid : deGrey.ValidOn deGreyChunk152 = true := sorry
theorem deGreyChunk153_valid : deGrey.ValidOn deGreyChunk153 = true := sorry
theorem deGreyChunk154_valid : deGrey.ValidOn deGreyChunk154 = true := sorry
theorem deGreyChunk155_valid : deGrey.ValidOn deGreyChunk155 = true := sorry
theorem deGreyChunk156_valid : deGrey.ValidOn deGreyChunk156 = true := sorry
theorem deGreyChunk157_valid : deGrey.ValidOn deGreyChunk157 = true := sorry

end HadwigerNelson
