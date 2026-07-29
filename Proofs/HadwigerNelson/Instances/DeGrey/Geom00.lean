import Proofs.HadwigerNelson.Instances.DeGrey.Edges

/-!
# `deGrey` — geometry for edges 0–499

One `decide +kernel` per chunk: the kernel evaluates the check once, where plain
`decide` evaluates it twice (elaborator, then kernel) and exhausts the heartbeat
budget past ~250 edges. Many small chunks rather than one large one — each
reduction is transient, so the module's peak memory tracks the chunk, not the module.
-/

namespace HadwigerNelson

theorem deGreyChunk000_valid : deGrey.ValidOn deGreyChunk000 = true := sorry
theorem deGreyChunk001_valid : deGrey.ValidOn deGreyChunk001 = true := sorry
theorem deGreyChunk002_valid : deGrey.ValidOn deGreyChunk002 = true := sorry
theorem deGreyChunk003_valid : deGrey.ValidOn deGreyChunk003 = true := sorry
theorem deGreyChunk004_valid : deGrey.ValidOn deGreyChunk004 = true := sorry
theorem deGreyChunk005_valid : deGrey.ValidOn deGreyChunk005 = true := sorry
theorem deGreyChunk006_valid : deGrey.ValidOn deGreyChunk006 = true := sorry
theorem deGreyChunk007_valid : deGrey.ValidOn deGreyChunk007 = true := sorry
theorem deGreyChunk008_valid : deGrey.ValidOn deGreyChunk008 = true := sorry
theorem deGreyChunk009_valid : deGrey.ValidOn deGreyChunk009 = true := sorry

end HadwigerNelson
