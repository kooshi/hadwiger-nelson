import T4Exp.Probe
import T4Exp.S8.B
/-! FS131-T4 scenario S8: one type up to bound-variable names. Written by `tools/fs131_t4_experiment.py`. -/
namespace T4.S8
open T4
theorem markA : ∀ n : Nat, n + 0 = n := fun _ => rfl
theorem dup (n : Nat) : n + 0 = n := markA n
end T4.S8
#t4probe T4.S8.dup
#t4locals
