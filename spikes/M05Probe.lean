import Init.Data.Nat.Power2.Lemmas

/-! Does core already prove the "exactly one bit set" lemma the spike declared absent? -/

-- The exact obligation `plans/spike-kernel-lrat.md` § 6 said was "genuinely not in Mathlib".
example (x : Nat) (hx : x ≠ 0) (h : x &&& (x - 1) = 0) : ∃ i, x = 2 ^ i :=
  Nat.ne_zero_and_sub_one_eq_zero_iff_isPowerOfTwo.mp ⟨hx, h⟩

-- ...and the converse, which the checker's completeness rests on.
example (i : Nat) : (2 ^ i) &&& (2 ^ i - 1) = 0 :=
  (Nat.ne_zero_and_sub_one_eq_zero_iff_isPowerOfTwo.mpr ⟨i, rfl⟩).2

#print axioms Nat.ne_zero_and_sub_one_eq_zero_iff_isPowerOfTwo
