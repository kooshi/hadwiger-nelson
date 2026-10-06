import T4Exp.Probe
import T4Exp.S10.A
/-! FS131-T4 scenario S10: a data-valued instance under its generated name, one body. Written by `tools/fs131_t4_experiment.py`. -/
namespace T4.S10
open T4
instance : Inhabited Tok := ⟨.a⟩
end T4.S10
#t4probe T4.S10.instInhabitedTok
#t4locals
