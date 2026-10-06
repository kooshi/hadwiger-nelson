import T4Exp.Probe
import T4Exp.S2.B
/-! FS131-T4 scenario S2: (ii) A is `sorry`, B clean. Written by `tools/fs131_t4_experiment.py`. -/
namespace T4.S2
open T4
theorem dup : 2 + 2 = 4 := sorry
end T4.S2
#t4probe T4.S2.dup
#t4locals
