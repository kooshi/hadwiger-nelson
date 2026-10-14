import Mathlib.Data.Nat.Bitwise
-- FS131-ICM4 probe: the kernel's cost of the five checks, before the module is written.
def step (n P x : ℕ) : ℕ := if x.testBit (n - 1) then (x <<< 1) ^^^ P else x <<< 1

def orbitOk (n P : ℕ) : ℕ → ℕ → Bool
  | 0, x => x == 1
  | fuel + 1, x => x != 1 && orbitOk n P fuel (step n P x)

def primCheck (n P : ℕ) : Bool := decide (0 < n) && P >>> n == 1 && orbitOk n P (2 ^ n - 2) (step n P 1)

def colourCheck (n P Q e₁ e₂ : ℕ) : Bool :=
  (List.range (Q + 1)).all fun j =>
    (step n P)^[e₁ + (Q - 1) * j] 1 % 2 == 1 || (step n P)^[e₂ + (Q - 1) * j] 1 % 2 == 1

def pass (n P d : ℕ) : ℕ → ℕ → ℕ → ℕ → ℕ × ℕ
  | 0, x, _, acc => (x, acc)
  | fuel + 1, x, i, acc =>
    pass n P d fuel (step n P x) (if i = d - 1 then 0 else i + 1) (acc + ((x &&& 1) <<< (8 * i)))

def counts64 : ℕ × ℕ := pass 12 4179 63 4095 1 0 0

set_option profiler true in
theorem p12 : primCheck 12 4179 = true := by decide +kernel
set_option profiler true in
theorem p10 : primCheck 10 1033 = true := by decide +kernel
set_option profiler true in
theorem c32 : colourCheck 10 1033 32 3 344 = true := by decide +kernel
set_option profiler true in
theorem c16 : colourCheck 8 285 16 0 28 = true := by decide +kernel
set_option profiler true in
theorem k64 : ((List.range 63).all fun i => (counts64.2 >>> (8 * i)) &&& 255 ≤ 40) = true := by decide +kernel
set_option profiler true in
theorem k64' : ((List.range 63).all fun i => (counts64.2 >>> (8 * i)) &&& 255 ≤ 39) = false := by decide +kernel
set_option profiler true in
theorem c32bad : colourCheck 10 1033 32 3 3 = false := by decide +kernel
