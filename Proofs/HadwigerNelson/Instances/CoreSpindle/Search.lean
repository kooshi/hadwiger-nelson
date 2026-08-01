import Proofs.HadwigerNelson.Instances.CoreSpindle.Weights
import Proofs.HadwigerNelson.Instances.CoreSpindle.Cert

/-!
# The weight bound, decided

The four obligations the certificate owes, and nothing else. They are here rather than beside the
headline because the last of them is minutes of kernel time and everything a human reads should be
editable for less than that.

* `coreSpindle_slots` — the emitted search plan really is this graph and these weights.
* `coreSpindle_cover` — the emitted order reaches every vertex.
* `coreSpindle_rem` — the prune's budget covers all the weight the order carries.
* `coreSpindle_noHeavy` — **no independent set weighs more than 72**, over 390,625 search nodes.
* `coreSpindle_weight_sum` — the weights sum to 260.

Each is one `decide`. Together with `noHeavy_sound` they give the graph's fractional lower bound;
`Bound.lean` carries it out to the plane.
-/

namespace HadwigerNelson

open SimpleGraph
open scoped ENNReal

set_option maxRecDepth 1000000

/-- The emitted search plan is this graph and these weights, read in the emitted order. A
transcription error anywhere in `Weights.lean` is a `false` here. -/
theorem coreSpindle_slots :
    coreSpindleSlots = mkSlots coreSpindle.edges coreSpindleWeights coreSpindleOrder := by
  decide +kernel

/-- The order reaches every vertex. A vertex the search is never offered is one it never takes,
which is the one way a wrong order could make the answer wrong. -/
theorem coreSpindle_cover : ∀ v : Fin 63, v ∈ coreSpindleOrder := by decide +kernel

/-- `260` is at least all the weight the order carries — the prune's budget. An over-estimate here
would only slow the search; an under-estimate is what this rules out. -/
theorem coreSpindle_rem : (coreSpindleOrder.map coreSpindleWeights).sum ≤ 260 := by decide +kernel

set_option maxHeartbeats 4000000 in
set_option linter.unreachableTactic false in
set_option linter.unusedTactic false in
/-- **No independent set of these 63 points weighs more than 72.**

Kernel-decided over 390,625 search nodes — against the `10⁹`-odd independent sets the graph has,
which is what the prune in `noHeavy` buys. This is the claim no human can check by inspection. -/
theorem coreSpindle_noHeavy : noHeavy 72 coreSpindleSlots 0 0 260 = true := by
  first
    | decide +kernel
    | fail "coreSpindle: some independent set weighs more than the bound stated above, so these
weights prove nothing. To see one — substituting that bound for the 72 below if it changed — in any
file importing Proofs:
  #eval HadwigerNelson.findHeavy coreSpindle.edges coreSpindleWeights 72 coreSpindleOrder 0 [] 0 260"

/-- The weights sum to 260. Stated so the headline's arithmetic is one rewrite. -/
theorem coreSpindle_weight_sum : ∑ v, coreSpindleWeights v = 260 := by decide +kernel

end HadwigerNelson
