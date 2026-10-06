import T4Exp.Probe
import T4Exp.S9.B
/-! FS131-T4 scenario S9: a `Prop`-valued instance under its generated name. Written by `tools/fs131_t4_experiment.py`. -/
#t4probe T4.S9.instNonemptyTok
namespace T4.S9
open T4
theorem down : Nonempty Tok := inferInstance
end T4.S9
#print axioms T4.S9.down
