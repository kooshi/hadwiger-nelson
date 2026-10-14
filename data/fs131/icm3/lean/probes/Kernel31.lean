import Mathlib.Analysis.Complex.Exponential
import Mathlib.Analysis.Real.Pi.Bounds
import Mathlib.Data.ZMod.Basic

namespace Probe

def reIPow (m : ℕ) : ℚ := if m % 4 = 0 then 1 else if m % 4 = 2 then -1 else 0

def taylorCos (r : ℚ) (n : ℕ) : ℚ := ∑ m ∈ Finset.range n, r ^ m / (m.factorial : ℚ) * reIPow m

def piLo : ℚ := 31415926535 / 10 ^ 10

def cosLow (Q j : ℕ) : ℚ :=
  taylorCos (2 * piLo * (min j (Q - j) : ℕ) / Q) 26 -
    (2 * piLo * (min j (Q - j) : ℕ) / Q) ^ 26 / ((26 : ℕ).factorial : ℚ) * 2 -
    2 * (min j (Q - j) : ℕ) / Q / 10 ^ 10

def circ31 : List (ℕ × ℕ) := [(0, 1), (0, 30), (1, 0), (2, 11), (2, 20), (4, 4), (4, 27), (5, 10), (5, 21), (7, 13), (7, 18), (10, 5), (10, 26), (11, 2), (11, 29), (13, 7), (13, 24), (18, 7), (18, 24), (20, 2), (20, 29), (21, 5), (21, 26), (24, 13), (24, 18), (26, 10), (26, 21), (27, 4), (27, 27), (29, 11), (29, 20), (30, 0)]
def tab31 : List ℤ := [1000000000, 979529941, 918957811, 820763441, 688966919, 528964010, 347305252, 151427777, -50649169, -250652533, -440394152, -612105983, -758758123, -874346617, -954139257, -994869324, -994869324, -954139257, -874346617, -758758123, -612105983, -440394152, -250652533, -50649169, 151427777, 347305252, 528964010, 688966919, 820763441, 918957811, 979529941]

set_option profiler true in
theorem tab31_ok : ((List.range 31).all fun j => decide (((tab31.getD j 0 : ℤ) : ℚ) ≤ 10 ^ 9 * cosLow 31 j)) = true := by
  decide +kernel

def circCheck (Q : ℕ) (circ : List (ℕ × ℕ)) (C : List ℤ) (M : ℤ) : Bool :=
  (List.range Q).all fun α => (List.range Q).all fun β =>
    (α == 0 && β == 0) || decide (-M ≤ (circ.map fun x => C.getD ((α * x.1 + β * x.2) % Q) 0).sum)

set_option profiler true in
theorem check31 : circCheck 31 circ31 tab31 10666510510 = true := by decide +kernel

set_option profiler true in
theorem circ31_eq : ((Finset.range 31 ×ˢ Finset.range 31).filter fun x : ℕ × ℕ => (x.1 ^ 2 + x.2 ^ 2) % 31 = 1) = circ31.toFinset := by
  decide +kernel

set_option profiler true in
theorem circ31_nodup : circ31.Nodup := by decide +kernel

end Probe
