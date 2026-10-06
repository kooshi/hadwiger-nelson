import T4Exp.Probe
import T4Exp.S9.B
/-! FS131-T4 scenario S9: a `Prop`-valued instance under its generated name. Written by `tools/fs131_t4_experiment.py`. -/
namespace T4.S9
open T4
instance : Nonempty Tok := ⟨.a⟩
end T4.S9
#t4probe T4.S9.instNonemptyTok
#t4locals
