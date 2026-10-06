-- FS131-K10b: the kernel cost of U_128's certified spectrum, measured (LEAN.md § The kernel's cost model).
-- Shape: one pass of the shift register x ↦ x·g mod P over 16,383 steps, the bit t(n) accumulated into 127 packed 8-bit
-- counters (n mod 127); then 127 comparisons. No table is built; the accumulator is one Nat.
namespace K10bCost

def P : Nat := 16427

def step (x : Nat) : Nat := if x.testBit 13 then (x <<< 1) ^^^ P else x <<< 1

def pass : Nat → Nat → Nat → Nat → Nat × Nat
  | 0, x, _, acc => (x, acc)
  | fuel + 1, x, i, acc => pass fuel (step x) (if i = 126 then 0 else i + 1) (acc + ((x &&& 1) <<< (8 * i)))

def counts : Nat × Nat := pass 16383 1 0 0

def check (bound : Nat) : Bool :=
  counts.1 == 1 && (List.range 127).all fun i => (counts.2 >>> (8 * i)) &&& 255 ≤ bound

set_option trace.profiler true in
set_option trace.profiler.threshold 50 in
theorem counts_le : check 74 = true := by decide +kernel

-- the control: the bound one lower must fail (some class has 74 ones)
example : check 73 = false := by decide +kernel

end K10bCost
