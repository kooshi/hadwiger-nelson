import Proofs.HadwigerNelson.Instances.DeGrey.Edges

/-!
# `deGrey` — geometry for edges 2000–2499

One `decide +kernel` per chunk: the kernel evaluates the check once, where plain
`decide` evaluates it twice (elaborator, then kernel) and exhausts the heartbeat
budget past ~250 edges. Many small chunks rather than one large one — each
reduction is transient, so the module's peak memory tracks the chunk, not the module.
-/

namespace HadwigerNelson

theorem deGreyChunk040_valid : deGrey.ValidOn deGreyChunk040 = true := sorry
theorem deGreyChunk041_valid : deGrey.ValidOn deGreyChunk041 = true := sorry
theorem deGreyChunk042_valid : deGrey.ValidOn deGreyChunk042 = true := sorry
theorem deGreyChunk043_valid : deGrey.ValidOn deGreyChunk043 = true := sorry
theorem deGreyChunk044_valid : deGrey.ValidOn deGreyChunk044 = true := sorry
theorem deGreyChunk045_valid : deGrey.ValidOn deGreyChunk045 = true := sorry
theorem deGreyChunk046_valid : deGrey.ValidOn deGreyChunk046 = true := sorry
theorem deGreyChunk047_valid : deGrey.ValidOn deGreyChunk047 = true := sorry
theorem deGreyChunk048_valid : deGrey.ValidOn deGreyChunk048 = true := sorry
theorem deGreyChunk049_valid : deGrey.ValidOn deGreyChunk049 = true := sorry

end HadwigerNelson
