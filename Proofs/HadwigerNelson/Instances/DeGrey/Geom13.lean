import Proofs.HadwigerNelson.Instances.DeGrey.Edges

/-!
# `deGrey` — geometry for edges 6500–6999

One `decide +kernel` per chunk: the kernel evaluates the check once, where plain
`decide` evaluates it twice (elaborator, then kernel) and exhausts the heartbeat
budget past ~250 edges. Many small chunks rather than one large one — each
reduction is transient, so the module's peak memory tracks the chunk, not the module.
-/

namespace HadwigerNelson

theorem deGreyChunk130_valid : deGrey.ValidOn deGreyChunk130 = true := sorry
theorem deGreyChunk131_valid : deGrey.ValidOn deGreyChunk131 = true := sorry
theorem deGreyChunk132_valid : deGrey.ValidOn deGreyChunk132 = true := sorry
theorem deGreyChunk133_valid : deGrey.ValidOn deGreyChunk133 = true := sorry
theorem deGreyChunk134_valid : deGrey.ValidOn deGreyChunk134 = true := sorry
theorem deGreyChunk135_valid : deGrey.ValidOn deGreyChunk135 = true := sorry
theorem deGreyChunk136_valid : deGrey.ValidOn deGreyChunk136 = true := sorry
theorem deGreyChunk137_valid : deGrey.ValidOn deGreyChunk137 = true := sorry
theorem deGreyChunk138_valid : deGrey.ValidOn deGreyChunk138 = true := sorry
theorem deGreyChunk139_valid : deGrey.ValidOn deGreyChunk139 = true := sorry

end HadwigerNelson
