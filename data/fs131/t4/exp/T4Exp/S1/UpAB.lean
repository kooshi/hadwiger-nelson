import T4Exp.Probe
import T4Exp.S1.A
/-! FS131-T4 scenario S1: (i) both clean. Written by `tools/fs131_t4_experiment.py`. -/
namespace T4.S1
open T4
theorem markB : 2 + 2 = 4 := rfl
theorem dup : 2 + 2 = 4 := markB
end T4.S1
#t4probe T4.S1.dup
#t4locals
