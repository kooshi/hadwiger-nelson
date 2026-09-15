import Proofs.HadwigerNelson.Instances.IndependenceThreshold

/-!
# FS-53 — the sixth colour: the window's threshold and a field's bound

Which finite Euclidean plane, if any, needs exactly six colours? Six colours on `UD(𝔽_q, 2)` need an
independent set of `⌈q²/6⌉` points, which the ratio bound permits only while `5|λ_min| ≥ q + 1`; with
Weil's `|λ_min| ≤ 2√q` that fails from `q = 98` up, 71's exact spectrum already fails it, and 83 was
refused by an exact certificate on 2026-09-15 (FS-50, `data/fs50/p83-refusal/`). **So a plane with `χ`
exactly six can live only at `q ∈ {23, 27, 31, 43, 47, 59, 67, 79}`, and none of the eight is decided.**

This module holds the kernel content that does **not** wait on a digit:

* the **window's threshold**, one statement on `finitePlane q` with the vertex count folded in (a per-member
  named form is minted only when its certificate exists — subplan §S12.1 D-14);
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

## Where the equality schema went

`chromaticNumber_eq_succ_of_colorable_of_indepNum_le` — a verified `(k+1)`-colouring together with a
certified bound on the independence number pins `χ` exactly — is a statement about any finite graph,
so it is library rather than instance and lives in `LocalGlobal.lean` beside
`add_one_le_chromaticNumber_of_indepNum_le`, whose lemma API it is (subplan §S12.1 D-15). A reader
looking for "colouring plus independence bound gives `χ` exactly" finds it next to the bound they
already have in hand.

## Vacuity

The threshold theorems assume a `≤` between natural numbers, not a structure, so `scripts/Vacuity.lean`
records no carrier site for them. `unitQuadrance O23` is inhabited by its own zero, and the field
bound's hypothesis is a `Colorable`, which its callers supply — at 23,
`CayleyCert.colorable_finitePlane23_eight` supplies one today (eight colours), so
`colorable_unitQuadrance_O23` is not an empty statement.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ### The window's thresholds, in one statement

`finitePlane q` has `q * q` vertices, so the side condition of `add_one_le_chromaticNumber_of_indepNum_le`
is `k * a < q * q`; at every window member `6 · (⌈q²/6⌉ − 1) = q² − 1` (`q` coprime to 6) and
`5 · (⌈q²/5⌉ − 1) = q² − 1` (`5 ∤ q`), so each is `norm_num` at use time. A per-member named statement is
minted only when its certificate exists (subplan §S12.1 D-14; FS-50's
`seven_le_chromaticNumber_finitePlane83_of_indepNum_le` in `Instances/IndependenceThreshold.lean` is the
shape), never ahead of it. -/

/-- **A certified independence bound raises a finite plane's chromatic number**, stated on `finitePlane q`
with its vertex count `q * q` folded in: if `k · a < q²` and no independent set exceeds `a` points, then
`χ ≥ k + 1`. The hypothesis `indepNum ≤ a` is what an exact rational certificate of the triple-level
semidefinite bound supplies (`tools/fplane_cert_check.py`, its `⌊N⌋`); the kernel never decides it. -/
theorem add_one_le_chromaticNumber_finitePlane_of_indepNum_le {q k a : ℕ} [NeZero q]
    (h : (finitePlane q).indepNum ≤ a) (hk : k * a < q * q) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (finitePlane q).chromaticNumber :=
  add_one_le_chromaticNumber_of_indepNum_le h (by simpa [Fintype.card_prod, ZMod.card] using hk)

/-- The spec at the window's most-watched cell: six refused at 23 needs `α ≤ 88`, and would read `χ ≥ 7`. -/
example (h : (finitePlane 23).indepNum ≤ 88) : (7 : ℕ∞) ≤ (finitePlane 23).chromaticNumber := by
  simpa using add_one_le_chromaticNumber_finitePlane_of_indepNum_le (k := 6) h (by norm_num)

/-- And the floor raised to six at 43 needs `α ≤ 369`, inside the certificate's measured reach (§S2.2). -/
example (h : (finitePlane 43).indepNum ≤ 369) : (6 : ℕ∞) ≤ (finitePlane 43).chromaticNumber := by
  simpa using add_one_le_chromaticNumber_finitePlane_of_indepNum_le (k := 5) h (by norm_num)

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
