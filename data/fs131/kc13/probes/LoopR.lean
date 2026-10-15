-- direct Nat.rec loop (no brecOn): the step function applied to the accumulator
def stepA (k acc : Nat) : Nat := acc + (k * k) % 7
def loopR (n : Nat) : Nat → Nat :=
  Nat.rec (motive := fun _ => Nat → Nat) (fun acc => acc) (fun k ih acc => ih (stepA k acc)) n
#eval (loopR 100000 0, loopR 400000 0)
set_option profiler true in
theorem tR1 : loopR 100000 0 = 199999 := by decide +kernel
