import T4Exp.Probe
import T4Exp.S7.B
/-! FS131-T4 scenario S7: A is by `native_decide`, B clean. Written by `tools/fs131_t4_experiment.py`. -/
namespace T4.S7
open T4
theorem dup : 2 + 2 = 4 := by native_decide
end T4.S7
#t4probe T4.S7.dup
#t4locals
