import T4Exp.Probe
import T4Exp.S3.B
/-! FS131-T4 scenario S3: (iii) A rests on a declared `axiom`, B clean. Written by `tools/fs131_t4_experiment.py`. -/
#t4probe T4.S3.dup
namespace T4.S3
open T4
theorem down : 2 + 2 = 4 := dup
end T4.S3
#print axioms T4.S3.down
