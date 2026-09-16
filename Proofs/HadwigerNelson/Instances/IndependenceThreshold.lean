import Proofs.HadwigerNelson.LocalGlobal

/-!
# The independence threshold: what a certified `α(UD(𝔽_p, 2)) ≤ a` buys

A `k`-colouring of a graph on `n` vertices splits it into `k` independent sets, so it needs one of at
least `⌈n/k⌉` points. Turned around (`add_one_le_chromaticNumber_of_indepNum_le`, `LocalGlobal.lean`):
an upper bound on the largest independent set that leaves `k · a < n` refutes `k` colours outright.

This module names three instances, at the finite Euclidean planes 11, 23 and 83. **Each is a
conditional statement and nothing more**: its hypothesis is a numerical fact about the plane which the
kernel does not decide here, and the docstrings say so rather than reading as a bound on `χ`.

## Where the hypotheses come from, and what they are worth

FS-50's deliverable is an *exact rational certificate* of such a bound, in a proof system that is not
resolution: a nonnegative combination of the triple-level semidefinite relaxation's constraints that
is identically `N − tr Y`, checked coefficient by coefficient in exact arithmetic by a program of a
few hundred standard-library lines. The pieces live outside Lean:

* `plans/FS50-certificate-soundness.md` — the one-page derivation that the identity implies the bound;
* `data/fs50/cert-p11-N29.json` — the certificate at `p = 11`, giving `α(UD(𝔽₁₁, 2)) ≤ 29`;
* `tools/fplane_cert_check.py` — the checker, which rebuilds the whole constraint system from `p`
  alone and accepts that file in 0.2 s (`--self-test` plants faults and watches each refuse).

**All three hypotheses are now held, each by an exact certificate checked outside the kernel**, so each
conclusion rests on that checker's word and on nothing this module decides:

* at 11, `α ≤ 29` — `data/fs50/cert-p11-N29.json`, `tools/fplane_cert_check.py`; the conclusion is also a
  kernel theorem by a different route (`chromaticNumber_finitePlane11 = 5`), which makes this instance a
  consistency check on the certificate pipeline;
* at 83, `α ≤ 1046 ≤ 1148` — `data/fs50/p83-refusal/cert-p83-N1046-polish-208500.json` (FS-50), the same
  checker;
* at 23, `α ≤ 105` — `data/fs54/cert-q23-l3-N105.json` (FS-56), the level-3 relaxation, checked by
  `tools/fs54_l3_cert_check.py`.

Discharging them in the kernel is FS-52's question.

## Vacuity

These theorems assume a `≤` between two natural numbers, not a structure, so `scripts/Vacuity.lean`
records no carrier site for them and no `VACUITY DECLARED:` marker belongs here — writing one would
claim a provable emptiness that is not proved, which that gate reads as `STALE`.
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

`⌈6889/6⌉ = 1149`. **The hypothesis is held outside the kernel**: FS-50's exact certificate
`data/fs50/p83-refusal/cert-p83-N1046-polish-208500.json`, accepted by `tools/fplane_cert_check.py`, gives
`α ≤ 1046`; the largest set exhibited is 597. -/
theorem seven_le_chromaticNumber_finitePlane83_of_indepNum_le
    (h : (finitePlane 83).indepNum ≤ 1148) : (7 : ℕ∞) ≤ (finitePlane 83).chromaticNumber := by
  simpa using add_one_le_chromaticNumber_of_indepNum_le (k := 6) h six_mul_lt_card_finitePlane83

/-- **At `23`, the five-colour threshold** — FS-17's first digit. *If* no independent set of the
finite Euclidean plane at `23` exceeds 105 points, its 529 points need at least six colours.

`⌈529/5⌉ = 106`. **The hypothesis is held outside the kernel**: the level-3 certificate
`data/fs54/cert-q23-l3-N105.json`, accepted by `tools/fs54_l3_cert_check.py`, gives `α ≤ 105`
(`N ≈ 105.4306`, FS-56); the largest set held is 87 (`data/fs50/alpha-p23-ge87.json`). -/
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
