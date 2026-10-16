theorem t1 (n : Nat) (hk : 1 ≤ n) : n = n := by
  have _ := hk
  rfl
theorem t2 (n : Nat) (hk : 1 ≤ n) : n = n := by
  clear hk
  rfl
