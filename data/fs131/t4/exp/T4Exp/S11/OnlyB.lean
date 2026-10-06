import T4Exp.Probe
import T4Exp.S11.B
/-! FS131-T4 scenario S11: two `def`s of one name, type and body. Written by `tools/fs131_t4_experiment.py`. -/
#t4probe T4.S11.dup
namespace T4.S11
open T4
def down : Nat := dup
end T4.S11
#print axioms T4.S11.down
