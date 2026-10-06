import T4Exp.Probe
import T4Exp.S8.A
/-! FS131-T4 scenario S8: one type up to bound-variable names. Written by `tools/fs131_t4_experiment.py`. -/
#t4probe T4.S8.dup
namespace T4.S8
open T4
theorem down : ∀ k : Nat, k + 0 = k := dup
end T4.S8
#print axioms T4.S8.down
