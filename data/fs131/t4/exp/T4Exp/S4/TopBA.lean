import T4Exp.Probe
import T4Exp.S4.B
import T4Exp.S4.A
/-! FS131-T4 scenario S4: (iv) A is an `axiom` of the name and type, B a theorem. Written by `tools/fs131_t4_experiment.py`. -/
#t4probe T4.S4.dup
namespace T4.S4
open T4
theorem down : 2 + 2 = 4 := dup
end T4.S4
#print axioms T4.S4.down
