import T4Exp.Probe
import T4Exp.S5.B
/-! FS131-T4 scenario S5: (v) the types differ. Written by `tools/fs131_t4_experiment.py`. -/
namespace T4.S5
open T4
theorem markA : 2 + 2 = 4 := rfl
theorem dup : 2 + 2 = 4 := markA
end T4.S5
#t4probe T4.S5.dup
#t4locals
