import T4Exp.Probe
import T4Exp.S6.A
/-! FS131-T4 scenario S6: both are `axiom`s of the name and type. Written by `tools/fs131_t4_experiment.py`. -/
namespace T4.S6
open T4
axiom dup : 2 + 2 = 4
end T4.S6
#t4probe T4.S6.dup
#t4locals
