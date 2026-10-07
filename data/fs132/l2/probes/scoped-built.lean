import Proofs.HadwigerNelson.Outside.OAI158Palette
/-!
FS132-L2 probe, on the built module: the three instances `Outside/OAI158Palette` declares on Mathlib's types are found
under `open HadwigerNelson.Outside.OAI158` and inside that namespace, and not found outside it.  Each `#synth` outside
the namespace must FAIL (the run's error lines are the positive signal: three of them, at lines the checker names);
each inside must succeed.  Iteration file, never a library module.
-/
open MeasureTheory
variable (E : Type) [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E] [TopologicalSpace.SeparableSpace E]

-- outside the namespace: three failures expected
#synth CompactSpace (HadwigerNelson.Outside.OAI158.WeakBall.Space E)                       -- OUTSIDE-1
#synth TopologicalSpace.MetrizableSpace (HadwigerNelson.Outside.OAI158.WeakBall.Space E)   -- OUTSIDE-2
#synth Fact ((2 : ENNReal) ≠ ⊤)                                                            -- OUTSIDE-3

section opened
open HadwigerNelson.Outside.OAI158
#synth CompactSpace (WeakBall.Space E)                                                     -- OPEN-1
#synth TopologicalSpace.MetrizableSpace (WeakBall.Space E)                                 -- OPEN-2
#synth Fact ((2 : ENNReal) ≠ ⊤)                                                            -- OPEN-3
end opened

namespace HadwigerNelson.Outside.OAI158
#synth CompactSpace (WeakBall.Space E)                                                     -- INSIDE-1
#synth TopologicalSpace.MetrizableSpace (WeakBall.Space E)                                 -- INSIDE-2
#synth Fact ((2 : ENNReal) ≠ ⊤)                                                            -- INSIDE-3
end HadwigerNelson.Outside.OAI158

namespace HadwigerNelson.SixRing
open Outside.OAI158
#synth CompactSpace (WeakBall.Space E)                                                     -- SIXRING-1
end HadwigerNelson.SixRing
