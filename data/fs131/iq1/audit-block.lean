/-! ## FS131-IQ1 — degree-one primes of fields of square roots (planned by FS131-KN2): `Arith/QuadraticPrime`.
NF1-S2: a field that embeds in `ℚ_p` has a maximal ideal of its integers with `p` elements in the quotient
(`exists_maximal_card_of_padic`); so has `ℚ(√D)` when every radicand is a nonzero square modulo the odd prime `p`
(`exists_maximal_card_eq`, with the claim's own form `exists_maximal_card_eq_sqrt`), and `ℚ(√D, √q)` with one more
radicand divisible by `p` exactly once (`exists_maximal_card_eq_of_ramified`). No import and no declared
hypothesis: every record is CLEAN. -/
-- FS131-IQ1: Arith/QuadraticPrime
#print axioms QuadraticPrime.isIntegral_sqrt_natCast
#print axioms QuadraticPrime.fieldOfRadicands_eq_adjoin
#print axioms QuadraticPrime.numberField_fieldOfRadicands
#print axioms QuadraticPrime.instNumberFieldFieldOfRadicands
#print axioms QuadraticPrime.isMaximal_ker_and_card
#print axioms QuadraticPrime.exists_ringHom_zmod_of_padic
#print axioms QuadraticPrime.exists_maximal_card_of_padic
#print axioms QuadraticPrime.exists_padicInt_sq_eq
#print axioms QuadraticPrime.nonempty_ringHom_padic
#print axioms QuadraticPrime.exists_maximal_card_eq
#print axioms QuadraticPrime.exists_maximal_card_eq_sqrt
#print axioms QuadraticPrime.nonempty_ringHom_zmod_of_ramified_sqrt
#print axioms QuadraticPrime.exists_maximal_card_eq_of_ramified
