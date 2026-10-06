import T4Exp.Base
/-! FS131-T4 scenario S7: A is by `native_decide`, B clean. Written by `tools/fs131_t4_experiment.py`. -/
namespace T4.S7
open T4
theorem markB : 2 + 2 = 4 := rfl
theorem dup : 2 + 2 = 4 := markB
end T4.S7
