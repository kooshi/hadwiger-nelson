def loopBig (n : Nat) : Nat → Nat :=
  Nat.rec (motive := fun _ => Nat → Nat) (fun acc => acc)
    (fun k ih acc => ih (acc + ((k % 1000 + 1) <<< (256 * ((k * 7919) % 4000))))) n
set_option profiler true in
theorem t : (loopBig 20000 (1 <<< (256*4000))) % 1000007 = 991719 := by decide +kernel
