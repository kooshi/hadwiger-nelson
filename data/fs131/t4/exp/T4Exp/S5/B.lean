import T4Exp.Base
/-! FS131-T4 scenario S5: (v) the types differ. Written by `tools/fs131_t4_experiment.py`. -/
namespace T4.S5
open T4
theorem markB : 2 + 2 = 4 ∧ True := ⟨rfl, trivial⟩
theorem dup : 2 + 2 = 4 ∧ True := markB
end T4.S5
