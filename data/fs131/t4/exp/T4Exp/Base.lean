/-! FS131-T4's scratch package: what the scenarios share. Written by `tools/fs131_t4_experiment.py`. -/
namespace T4

/-- A two-element type for the instance scenarios. -/
inductive Tok where
  | a
  | b

/-- A recursive function, so that Lean generates its equation lemmas on demand (`T4.fn.eq_1`). -/
def fn : Nat → Nat
  | 0 => 1
  | n + 1 => fn n

end T4
