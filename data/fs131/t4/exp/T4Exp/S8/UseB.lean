import T4Exp.S8.B
/-! FS131-T4 scenario S8: one type up to bound-variable names. Written by `tools/fs131_t4_experiment.py`. -/
namespace T4.S8
open T4
theorem useB : ∀ k : Nat, k + 0 = k := dup
end T4.S8
