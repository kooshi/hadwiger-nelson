import T4Exp.Base
/-! FS131-T4 scenario S8: one type up to bound-variable names. Written by `tools/fs131_t4_experiment.py`. -/
namespace T4.S8
open T4
theorem markB : ∀ m : Nat, m + 0 = m := fun _ => rfl
theorem dup (m : Nat) : m + 0 = m := markB m
end T4.S8
