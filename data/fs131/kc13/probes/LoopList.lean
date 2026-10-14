-- iterate a list built by List.range (cost model warns) vs Nat.rec
def sumSq : List Nat → Nat → Nat
  | [], acc => acc
  | k :: ks, acc => sumSq ks (acc + (k * k) % 7)
set_option profiler true in
theorem tL : sumSq (List.range 100000) 0 = 299997 ∨ True := by decide +kernel
