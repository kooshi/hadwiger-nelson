import T4Exp.Probe
import T4Exp.S1.A
import T4Exp.S1.B
/-! FS131-T4 scenario S1: (i) both clean. Written by `tools/fs131_t4_experiment.py`. -/
#t4probe T4.S1.dup
namespace T4.S1
open T4
theorem down : 2 + 2 = 4 := dup
end T4.S1
#print axioms T4.S1.down
