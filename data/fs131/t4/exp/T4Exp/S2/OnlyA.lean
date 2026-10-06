import T4Exp.Probe
import T4Exp.S2.A
/-! FS131-T4 scenario S2: (ii) A is `sorry`, B clean. Written by `tools/fs131_t4_experiment.py`. -/
#t4probe T4.S2.dup
namespace T4.S2
open T4
theorem down : 2 + 2 = 4 := dup
end T4.S2
#print axioms T4.S2.down
