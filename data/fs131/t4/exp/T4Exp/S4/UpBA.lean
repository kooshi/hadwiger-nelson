import T4Exp.Probe
import T4Exp.S4.B
/-! FS131-T4 scenario S4: (iv) A is an `axiom` of the name and type, B a theorem. Written by `tools/fs131_t4_experiment.py`. -/
namespace T4.S4
open T4
axiom dup : 2 + 2 = 4
end T4.S4
#t4probe T4.S4.dup
#t4locals
