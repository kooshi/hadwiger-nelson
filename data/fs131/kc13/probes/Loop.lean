-- kernel micro-benchmark: a trivial Nat loop with an accumulator
def loopA : Nat → Nat → Nat
  | 0, acc => acc
  | n+1, acc => loopA n (acc + (n * n) % 7)

-- strict variant: the accumulator is forced through a Bool test each step
def loopS : Nat → Nat → Nat
  | 0, acc => acc
  | n+1, acc => let a := acc + (n * n) % 7; if a == 0 then 0 else loopS n a

-- fuel-free variant via Nat.rec with the iteration count bounded
#eval (loopA 100000 0, loopA 400000 0, loopS 100000 1, loopS 400000 1)
set_option profiler true in
theorem tA1 : loopA 100000 0 = 199999 := by decide +kernel
set_option profiler true in
theorem tA2 : loopA 400000 0 = 800001 := by decide +kernel
set_option profiler true in
theorem tS1 : loopS 100000 1 = 200000 := by decide +kernel
set_option profiler true in
theorem tS2 : loopS 400000 1 = 800002 := by decide +kernel
