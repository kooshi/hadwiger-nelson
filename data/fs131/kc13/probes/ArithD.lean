-- per-op cost: instance-notation arithmetic vs direct Nat.* calls, 100k iterations of 8 ops
def stepI (k acc : Nat) : Nat := (acc + (k * 7 + 3) % 11 * 5 + k / 3) % 1000003
def stepD (k acc : Nat) : Nat := Nat.mod (Nat.add acc (Nat.add (Nat.mul (Nat.mod (Nat.add (Nat.mul k 7) 3) 11) 5) (Nat.div k 3))) 1000003
def loopI (n : Nat) : Nat → Nat :=
  Nat.rec (motive := fun _ => Nat → Nat) (fun acc => acc) (fun k ih acc => ih (stepI k acc)) n
def loopD (n : Nat) : Nat → Nat :=
  Nat.rec (motive := fun _ => Nat → Nat) (fun acc => acc) (fun k ih acc => ih (stepD k acc)) n
theorem t : loopD 100000 0 = 111650 := by decide +kernel
