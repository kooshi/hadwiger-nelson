def stepA (k acc : Nat) : Nat := acc + (k * k) % 7
def loopR (n : Nat) : Nat → Nat :=
  Nat.rec (motive := fun _ => Nat → Nat) (fun acc => acc) (fun k ih acc => ih (stepA k acc)) n
set_option profiler true in
theorem tR2 : loopR 400000 0 = 800001 := by decide +kernel
