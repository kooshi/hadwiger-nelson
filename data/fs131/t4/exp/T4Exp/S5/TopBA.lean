import T4Exp.Probe
import T4Exp.S5.B
import T4Exp.S5.A
/-! FS131-T4 scenario S5: (v) the types differ. Written by `tools/fs131_t4_experiment.py`. -/
#t4probe T4.S5.dup
namespace T4.S5
open T4
theorem down : 2 + 2 = 4 := dup
end T4.S5
#print axioms T4.S5.down
