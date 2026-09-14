import Proofs.HadwigerNelson.LocalGlobal

/-!
# The independence threshold: what a certified `α(UD(𝔽_p, 2)) ≤ a` buys

A `k`-colouring of a graph on `n` vertices splits it into `k` independent sets, so it needs one of at
least `⌈n/k⌉` points. Turned around (`add_one_le_chromaticNumber_of_indepNum_le`, `LocalGlobal.lean`):
an upper bound on the largest independent set that leaves `k · a < n` refutes `k` colours outright.

This module names the three instances FS-50 cares about, at the three finite Euclidean planes whose
independence number the milestone measures. **Each is a conditional statement and nothing more**: its
hypothesis is a numerical fact about the plane which the kernel does not decide here, and the
docstrings say so rather than reading as a bound on `χ`.

## Where the hypotheses come from, and what they are worth

FS-50's deliverable is an *exact rational certificate* of such a bound, in a proof system that is not
resolution: a nonnegative combination of the triple-level semidefinite relaxation's constraints that
is identically `N − tr Y`, checked coefficient by coefficient in exact arithmetic by a program of a
few hundred standard-library lines. The pieces live outside Lean:

* `plans/FS50-certificate-soundness.md` — the one-page derivation that the identity implies the bound;
* `data/fs50/cert-p11-N29.json` — the certificate at `p = 11`, giving `α(UD(𝔽₁₁, 2)) ≤ 29`;
* `tools/fplane_cert_check.py` — the checker, which rebuilds the whole constraint system from `p`
  alone and accepts that file in 0.2 s (`--self-test` plants faults and watches each refuse).

So `five_le_chromaticNumber_finitePlane11_of_indepNum_le` below has its hypothesis discharged **by an
exact certificate outside the kernel**, and its conclusion is already a kernel theorem by a different
route (`Instances/FinitePlane11.lean`, `chromaticNumber_finitePlane11 = 5`) — which makes it a
consistency check on the certificate pipeline rather than a new bound. The other two hypotheses are
**open questions**: `α(UD(𝔽₈₃, 2)) ≤ 1148` is FS-50's own, and `α(UD(𝔽₂₃, 2)) ≤ 105` is FS-17's. The
best sets known are 597 points at 83 and 87 at 23 (`data/fs50/wo18/`), so neither hypothesis is known
to be false either; the relaxation's exact value at those primes is what would decide them.

## Vacuity

These theorems assume a `≤` between two natural numbers, not a structure, so `scripts/Vacuity.lean`
records no carrier site for them and no `VACUITY DECLARED:` marker belongs here — writing one would
claim a provable emptiness that is not proved, which that gate reads as `STALE`. The honest statement
is the one above: the hypotheses at 83 and at 23 are open, and until a certificate supplies one the
corresponding conclusion is asserted by nobody.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ### The vertex counts -/

/-- `|𝔽₈₃²| = 6889`, and six classes of at most 1,148 points cannot cover it. -/
theorem six_mul_lt_card_finitePlane83 : 6 * 1148 < Fintype.card (ZMod 83 × ZMod 83) := by
  rw [Fintype.card_prod, ZMod.card]; norm_num

/-- `|𝔽₂₃²| = 529`, and five classes of at most 105 points cannot cover it. -/
theorem five_mul_lt_card_finitePlane23 : 5 * 105 < Fintype.card (ZMod 23 × ZMod 23) := by
  rw [Fintype.card_prod, ZMod.card]; norm_num

/-- `|𝔽₁₁²| = 121`, and four classes of at most 29 points cannot cover it. -/
theorem four_mul_lt_card_finitePlane11 : 4 * 29 < Fintype.card (ZMod 11 × ZMod 11) := by
  rw [Fintype.card_prod, ZMod.card]; norm_num

example : Fintype.card (ZMod 83 × ZMod 83) = 6889 := by rw [Fintype.card_prod, ZMod.card]
example : Fintype.card (ZMod 23 × ZMod 23) = 529 := by rw [Fintype.card_prod, ZMod.card]
example : Fintype.card (ZMod 11 × ZMod 11) = 121 := by rw [Fintype.card_prod, ZMod.card]

/-! ### The three consumers -/

/-- **At `83`, the six-colour threshold.** *If* no independent set of the finite Euclidean plane at
`83` exceeds 1,148 points, then its 6,889 points cannot be split into six colour classes and its
chromatic number is at least 7.

The hypothesis is FS-50's open question: `⌈6889/6⌉ = 1149`, and the largest set anybody here has
exhibited is 597 (`data/fs50/wo18/p83-chain.json`). **This theorem asserts nothing about `χ` until
that hypothesis is supplied**, by a certificate of the kind `data/fs50/cert-p11-N29.json` is at 11. -/
theorem seven_le_chromaticNumber_finitePlane83_of_indepNum_le
    (h : (finitePlane 83).indepNum ≤ 1148) : (7 : ℕ∞) ≤ (finitePlane 83).chromaticNumber := by
  simpa using add_one_le_chromaticNumber_of_indepNum_le (k := 6) h six_mul_lt_card_finitePlane83

/-- **At `23`, the five-colour threshold** — FS-17's first digit. *If* no independent set of the
finite Euclidean plane at `23` exceeds 105 points, its 529 points need at least six colours.

Open on the same terms: `⌈529/5⌉ = 106`, and the largest set held is 87
(`data/fs50/alpha-p23-ge87.json`). -/
theorem six_le_chromaticNumber_finitePlane23_of_indepNum_le
    (h : (finitePlane 23).indepNum ≤ 105) : (6 : ℕ∞) ≤ (finitePlane 23).chromaticNumber := by
  simpa using add_one_le_chromaticNumber_of_indepNum_le (k := 5) h five_mul_lt_card_finitePlane23

/-- **At `11`, where the hypothesis is actually held.** `data/fs50/cert-p11-N29.json`, accepted by
`tools/fplane_cert_check.py`, proves `α(UD(𝔽₁₁, 2)) ≤ 29` in exact rational arithmetic — the first
bound below the eigenvalue bound (34.55) for any finite Euclidean plane. Four classes of 29 points
cover 116 of 121, so the plane needs five colours.

That conclusion is **already kernel-checked by a different route** (`chromaticNumber_finitePlane11`),
which is the point of stating it: the certificate pipeline reproduces a fact this library proves
independently, and a disagreement would have been a defect in the pipeline. -/
theorem five_le_chromaticNumber_finitePlane11_of_indepNum_le
    (h : (finitePlane 11).indepNum ≤ 29) : (5 : ℕ∞) ≤ (finitePlane 11).chromaticNumber := by
  simpa using add_one_le_chromaticNumber_of_indepNum_le (k := 4) h four_mul_lt_card_finitePlane11

end HadwigerNelson
