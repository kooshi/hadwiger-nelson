import Proofs.HadwigerNelson.Instances.IndependenceThreshold

/-!
# FS-53 — the sixth colour: the window's thresholds, the equality schema, and a field's bound

Which finite Euclidean plane, if any, needs exactly six colours? Six colours on `UD(𝔽_q, 2)` need an
independent set of `⌈q²/6⌉` points, which the ratio bound permits only while `5|λ_min| ≥ q + 1`; with
Weil's `|λ_min| ≤ 2√q` that fails from `q = 98` up, 71's exact spectrum already fails it, and 83 was
refused by an exact certificate on 2026-09-15 (FS-50, `data/fs50/p83-refusal/`). **So a plane with `χ`
exactly six can live only at `q ∈ {23, 27, 31, 43, 47, 59, 67, 79}`, and none of the eight is decided.**

This module holds the kernel content that does **not** wait on a digit:

* the **equality schema** — a verified `(k+1)`-colouring together with a certified bound on the
  independence number pins `χ` exactly;
* the **window's thresholds**, one conditional statement per prime member and per colour count, in the
  shape `Instances/IndependenceThreshold.lean` established at 83, 23 and 11;
* a **field's bound at the ring level**: a ring homomorphism from an order into `𝔽_q` is a graph
  homomorphism of unit-quadrance graphs, so every colouring of the plane colours the order's plane.

## What is asserted here, and what is not

Every threshold statement below is a **conditional** whose hypothesis is a numerical fact about a plane
that the kernel does not decide: an upper bound on its independence number, to be discharged outside the
kernel by an exact rational certificate of the kind `tools/fplane_cert_check.py` accepts. Until such a
certificate exists for a given plane, the corresponding conclusion is asserted by nobody. The largest
independent sets anybody here has exhibited are 87 points at 23 and nothing at all at 27, 31, 43, 47,
59, 67 and 79, so no hypothesis below is known to be false either.

## The seven, not the eight

`finitePlane q` is `unitQuadrance (ZMod q)` — the unit-quadrance graph of the **ring** `ℤ/q`. For the
seven prime members that is the finite Euclidean plane. For the window's eighth member, `q = 27`, it is
**not**: `ℤ/27` is not `𝔽₂₇`, and `finitePlane 27` is a different graph about which this milestone
claims nothing. The plane over `𝔽₂₇ = 𝔽₃[t]/(t³ − t − 1)` needs a concrete finite field with decidable
equality that this library has not got, and the subplan prices it (§S7 D-8).

## Vacuity

The threshold theorems assume a `≤` between natural numbers, not a structure, so `scripts/Vacuity.lean`
records no carrier site for them. The equality schema is parametric in the graph — `GENERIC`, the
caller's obligation. `unitQuadrance O23` is inhabited by its own zero, and the field bound's hypothesis
is a `Colorable`, which the schema's callers supply.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ### The equality schema -/

/-- **A colouring plus an independence bound pins `χ` exactly.** If a finite graph is `(k+1)`-colourable
and no independent set exceeds `a` points while `k · a` is fewer than the vertices, then `χ = k + 1`.

This is the shape of every headline FS-53 can produce: the upper half is a verified colouring table
(`CayleyCertificate.lean`'s `CayleyCert.sound`, which this module deliberately does not import: the
threshold statements are independent of how an upper bound is certified), the lower half an exact rational certificate consumed through
`add_one_le_chromaticNumber_of_indepNum_le`. Neither half alone is a digit. -/
theorem chromaticNumber_eq_succ_of_colorable_of_indepNum_le {V : Type*} [Fintype V]
    {G : SimpleGraph V} {k a : ℕ} (hcol : G.Colorable (k + 1)) (hα : G.indepNum ≤ a)
    (hlt : k * a < Fintype.card V) : G.chromaticNumber = (k + 1 : ℕ) := by
  sorry

/-! ### The window's vertex counts

For every `q` coprime to 6 the count is exact: `6 · (⌈q²/6⌉ − 1) = q² − 1`, and likewise at five when
`5 ∤ q`. So each arithmetic side condition below is `q² − 1 < q²`, decided by `norm_num`. -/

theorem six_mul_lt_card_finitePlane23 : 6 * 88 < Fintype.card (ZMod 23 × ZMod 23) := by
  rw [Fintype.card_prod, ZMod.card]; norm_num

theorem six_mul_lt_card_finitePlane31 : 6 * 160 < Fintype.card (ZMod 31 × ZMod 31) := by
  rw [Fintype.card_prod, ZMod.card]; norm_num

theorem six_mul_lt_card_finitePlane43 : 6 * 308 < Fintype.card (ZMod 43 × ZMod 43) := by
  rw [Fintype.card_prod, ZMod.card]; norm_num

theorem six_mul_lt_card_finitePlane47 : 6 * 368 < Fintype.card (ZMod 47 × ZMod 47) := by
  rw [Fintype.card_prod, ZMod.card]; norm_num

theorem six_mul_lt_card_finitePlane59 : 6 * 580 < Fintype.card (ZMod 59 × ZMod 59) := by
  rw [Fintype.card_prod, ZMod.card]; norm_num

theorem six_mul_lt_card_finitePlane67 : 6 * 748 < Fintype.card (ZMod 67 × ZMod 67) := by
  rw [Fintype.card_prod, ZMod.card]; norm_num

theorem six_mul_lt_card_finitePlane79 : 6 * 1040 < Fintype.card (ZMod 79 × ZMod 79) := by
  rw [Fintype.card_prod, ZMod.card]; norm_num

theorem five_mul_lt_card_finitePlane31 : 5 * 192 < Fintype.card (ZMod 31 × ZMod 31) := by
  rw [Fintype.card_prod, ZMod.card]; norm_num

theorem five_mul_lt_card_finitePlane43 : 5 * 369 < Fintype.card (ZMod 43 × ZMod 43) := by
  rw [Fintype.card_prod, ZMod.card]; norm_num

theorem five_mul_lt_card_finitePlane47 : 5 * 441 < Fintype.card (ZMod 47 × ZMod 47) := by
  rw [Fintype.card_prod, ZMod.card]; norm_num

/-! ### The six-colour thresholds — a refusal of six at each prime member

Each says: *if* the plane's independence number is at most `⌈q²/6⌉ − 1`, its `q²` points do not split
into six classes and `χ ≥ 7`, so that member leaves the window. By the subplan's §S2.2 the exact
certificate should reach this at 79 and 67, is expected to miss at 59, and is 10–25 % out of reach at
23, 31, 43 and 47 — which is a fact about the instrument, not about those planes. -/

theorem seven_le_chromaticNumber_finitePlane23_of_indepNum_le
    (h : (finitePlane 23).indepNum ≤ 88) : (7 : ℕ∞) ≤ (finitePlane 23).chromaticNumber := by
  simpa using add_one_le_chromaticNumber_of_indepNum_le (k := 6) h six_mul_lt_card_finitePlane23

theorem seven_le_chromaticNumber_finitePlane31_of_indepNum_le
    (h : (finitePlane 31).indepNum ≤ 160) : (7 : ℕ∞) ≤ (finitePlane 31).chromaticNumber := by
  simpa using add_one_le_chromaticNumber_of_indepNum_le (k := 6) h six_mul_lt_card_finitePlane31

theorem seven_le_chromaticNumber_finitePlane43_of_indepNum_le
    (h : (finitePlane 43).indepNum ≤ 308) : (7 : ℕ∞) ≤ (finitePlane 43).chromaticNumber := by
  simpa using add_one_le_chromaticNumber_of_indepNum_le (k := 6) h six_mul_lt_card_finitePlane43

theorem seven_le_chromaticNumber_finitePlane47_of_indepNum_le
    (h : (finitePlane 47).indepNum ≤ 368) : (7 : ℕ∞) ≤ (finitePlane 47).chromaticNumber := by
  simpa using add_one_le_chromaticNumber_of_indepNum_le (k := 6) h six_mul_lt_card_finitePlane47

theorem seven_le_chromaticNumber_finitePlane59_of_indepNum_le
    (h : (finitePlane 59).indepNum ≤ 580) : (7 : ℕ∞) ≤ (finitePlane 59).chromaticNumber := by
  simpa using add_one_le_chromaticNumber_of_indepNum_le (k := 6) h six_mul_lt_card_finitePlane59

theorem seven_le_chromaticNumber_finitePlane67_of_indepNum_le
    (h : (finitePlane 67).indepNum ≤ 748) : (7 : ℕ∞) ≤ (finitePlane 67).chromaticNumber := by
  simpa using add_one_le_chromaticNumber_of_indepNum_le (k := 6) h six_mul_lt_card_finitePlane67

theorem seven_le_chromaticNumber_finitePlane79_of_indepNum_le
    (h : (finitePlane 79).indepNum ≤ 1040) : (7 : ℕ∞) ≤ (finitePlane 79).chromaticNumber := by
  simpa using add_one_le_chromaticNumber_of_indepNum_le (k := 6) h six_mul_lt_card_finitePlane79

/-! ### The five-colour thresholds — raising a floor to six

At 59, 67 and 79 the spectrum already refuses five, so only 23, 31, 43 and 47 need these. The one at 23
(`α ≤ 105`) is FS-17's and already stated in `Instances/IndependenceThreshold.lean`; the relaxation's own
optimum there is 108.546075, so it cannot reach it. At 43 and 47 it should. -/

theorem six_le_chromaticNumber_finitePlane31_of_indepNum_le
    (h : (finitePlane 31).indepNum ≤ 192) : (6 : ℕ∞) ≤ (finitePlane 31).chromaticNumber := by
  simpa using add_one_le_chromaticNumber_of_indepNum_le (k := 5) h five_mul_lt_card_finitePlane31

theorem six_le_chromaticNumber_finitePlane43_of_indepNum_le
    (h : (finitePlane 43).indepNum ≤ 369) : (6 : ℕ∞) ≤ (finitePlane 43).chromaticNumber := by
  simpa using add_one_le_chromaticNumber_of_indepNum_le (k := 5) h five_mul_lt_card_finitePlane43

theorem six_le_chromaticNumber_finitePlane47_of_indepNum_le
    (h : (finitePlane 47).indepNum ≤ 441) : (6 : ℕ∞) ≤ (finitePlane 47).chromaticNumber := by
  simpa using add_one_le_chromaticNumber_of_indepNum_le (k := 5) h five_mul_lt_card_finitePlane47

/-! ### The field half, at the level of the ring

The design target is a real field whose only usable prime is a window member: the 2-adic wall broken, 3,
7, 11 and 19 all unusable, `q` usable, and every other usable prime's plane already at six colours or
more. `ℚ(√2, √3, √31)` is the stub's candidate for `q = 23`: `31 ≡ 7 (mod 8)` breaks the wall, and 2, 3
and 31 are all squares modulo 23 (`5² = 2`, `7² = 3`, `10² = 8 ≡ 31`). The exclusions — that no other
prime below 200 is usable for it — are exact Legendre-symbol arithmetic, the designer's job in phase C.1
and not a kernel statement.

What the kernel says is the reduction itself, and it says it about the **order**, not the field: the
step from `ℤ[√2, √3, √31]` to `ℚ(√2, √3, √31)` is the `𝔭`-integrality of unit vectors, the standing hand
gap of `CLAUDE.md` row 57, unchanged by this milestone. -/

/-- The order `ℤ[√2, √3, √31]`, the stub's candidate field for `q = 23`. -/
abbrev O23 : Type := Adjoin 31 (Adjoin 3 (Adjoin 2 ℤ))

/-- The residue homomorphism `ℤ[√2, √3, √31] → 𝔽₂₃`: `√2 ↦ 5`, `√3 ↦ 7`, `√31 ↦ 10`. -/
def O23.res : O23 →+* ZMod 23 :=
  Adjoin.lift (Adjoin.lift (Adjoin.lift (Int.castRingHom (ZMod 23)) 5 (by decide)) 7 (by decide))
    10 (by decide)

/-- **The field half at 23, at the ring level.** Every colouring of the finite Euclidean plane at 23
colours the unit-quadrance graph of `ℤ[√2, √3, √31]`. So whatever digit FS-53 pins at 23 is an upper
bound for that order — and, through row 57's hand step, for `χ(ℚ(√2, √3, √31)²)`. -/
theorem colorable_unitQuadrance_O23 {k : ℕ} (h : (finitePlane 23).Colorable k) :
    (unitQuadrance O23).Colorable k :=
  -- `Nontrivial (ZMod 23)` is what stops the reduction collapsing an edge; kept local, since an
  -- unscoped `Fact (1 < 23)` is speech into every future instance search (DEBRUIJN, global_speech_acts).
  haveI : Fact (1 < 23) := ⟨by norm_num⟩
  h.of_hom (unitQuadrance.map O23.res)

end HadwigerNelson
