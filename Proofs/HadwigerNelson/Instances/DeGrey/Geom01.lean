import Proofs.HadwigerNelson.Instances.DeGrey.Edges

/-!
# `deGrey` — geometry for edges 500–999

One `decide +kernel` per chunk: the kernel evaluates the check once, where plain
`decide` evaluates it twice (elaborator, then kernel) and exhausts the heartbeat
budget past ~250 edges. Many small chunks rather than one large one — each
reduction is transient, so the module's peak memory tracks the chunk, not the module.
-/

namespace HadwigerNelson

theorem deGreyChunk010_valid : deGrey.ValidOn deGreyChunk010 = true := sorry
theorem deGreyChunk011_valid : deGrey.ValidOn deGreyChunk011 = true := sorry
theorem deGreyChunk012_valid : deGrey.ValidOn deGreyChunk012 = true := sorry
theorem deGreyChunk013_valid : deGrey.ValidOn deGreyChunk013 = true := sorry
theorem deGreyChunk014_valid : deGrey.ValidOn deGreyChunk014 = true := sorry
theorem deGreyChunk015_valid : deGrey.ValidOn deGreyChunk015 = true := sorry
theorem deGreyChunk016_valid : deGrey.ValidOn deGreyChunk016 = true := sorry
theorem deGreyChunk017_valid : deGrey.ValidOn deGreyChunk017 = true := sorry
theorem deGreyChunk018_valid : deGrey.ValidOn deGreyChunk018 = true := sorry
theorem deGreyChunk019_valid : deGrey.ValidOn deGreyChunk019 = true := sorry

end HadwigerNelson
