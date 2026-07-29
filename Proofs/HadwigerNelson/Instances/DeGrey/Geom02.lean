import Proofs.HadwigerNelson.Instances.DeGrey.Edges

/-!
# `deGrey` — geometry for edges 1000–1499

One `decide +kernel` per chunk: the kernel evaluates the check once, where plain
`decide` evaluates it twice (elaborator, then kernel) and exhausts the heartbeat
budget past ~250 edges. Many small chunks rather than one large one — each
reduction is transient, so the module's peak memory tracks the chunk, not the module.
-/

namespace HadwigerNelson

theorem deGreyChunk020_valid : deGrey.ValidOn deGreyChunk020 = true := sorry
theorem deGreyChunk021_valid : deGrey.ValidOn deGreyChunk021 = true := sorry
theorem deGreyChunk022_valid : deGrey.ValidOn deGreyChunk022 = true := sorry
theorem deGreyChunk023_valid : deGrey.ValidOn deGreyChunk023 = true := sorry
theorem deGreyChunk024_valid : deGrey.ValidOn deGreyChunk024 = true := sorry
theorem deGreyChunk025_valid : deGrey.ValidOn deGreyChunk025 = true := sorry
theorem deGreyChunk026_valid : deGrey.ValidOn deGreyChunk026 = true := sorry
theorem deGreyChunk027_valid : deGrey.ValidOn deGreyChunk027 = true := sorry
theorem deGreyChunk028_valid : deGrey.ValidOn deGreyChunk028 = true := sorry
theorem deGreyChunk029_valid : deGrey.ValidOn deGreyChunk029 = true := sorry

end HadwigerNelson
