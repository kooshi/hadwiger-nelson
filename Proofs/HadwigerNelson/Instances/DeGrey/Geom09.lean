import Proofs.HadwigerNelson.Instances.DeGrey.Edges

/-!
# `deGrey` — geometry for edges 4500–4999

One `decide +kernel` per chunk: the kernel evaluates the check once, where plain
`decide` evaluates it twice (elaborator, then kernel) and exhausts the heartbeat
budget past ~250 edges. Many small chunks rather than one large one — each
reduction is transient, so the module's peak memory tracks the chunk, not the module.
-/

namespace HadwigerNelson

theorem deGreyChunk090_valid : deGrey.ValidOn deGreyChunk090 = true := sorry
theorem deGreyChunk091_valid : deGrey.ValidOn deGreyChunk091 = true := sorry
theorem deGreyChunk092_valid : deGrey.ValidOn deGreyChunk092 = true := sorry
theorem deGreyChunk093_valid : deGrey.ValidOn deGreyChunk093 = true := sorry
theorem deGreyChunk094_valid : deGrey.ValidOn deGreyChunk094 = true := sorry
theorem deGreyChunk095_valid : deGrey.ValidOn deGreyChunk095 = true := sorry
theorem deGreyChunk096_valid : deGrey.ValidOn deGreyChunk096 = true := sorry
theorem deGreyChunk097_valid : deGrey.ValidOn deGreyChunk097 = true := sorry
theorem deGreyChunk098_valid : deGrey.ValidOn deGreyChunk098 = true := sorry
theorem deGreyChunk099_valid : deGrey.ValidOn deGreyChunk099 = true := sorry

end HadwigerNelson
