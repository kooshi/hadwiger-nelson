def loopB (n : Nat) : Nat → Nat :=
  Nat.rec (motive := fun _ => Nat → Nat) (fun acc => acc) (fun _ ih acc => ih acc) n
set_option profiler true in
theorem tB : loopB 400000 5 = 5 := by decide +kernel
