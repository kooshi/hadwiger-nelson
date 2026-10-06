import T4Exp.Probe
import T4Exp.S12.A
/-! FS131-T4 scenario S12: an equation lemma Lean generates on demand (`T4.fn.eq_1`), asked for in both. Written by `tools/fs131_t4_experiment.py`. -/
#t4probe T4.fn.eq_1
namespace T4.S12
open T4
theorem down : T4.fn 0 = 1 := T4.fn.eq_1
end T4.S12
#print axioms T4.S12.down
