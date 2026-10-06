import T4Exp.Probe
import T4Exp.S7.A
import T4Exp.S7.B
/-! FS131-T4 scenario S7: A is by `native_decide`, B clean. Written by `tools/fs131_t4_experiment.py`. -/
#t4probe T4.S7.dup
namespace T4.S7
open T4
theorem down : 2 + 2 = 4 := dup
end T4.S7
#print axioms T4.S7.down
