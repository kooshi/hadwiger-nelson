# FS-83 — the layer method at four and five colours: can one character colour a whole field's plane? (stub)

*Minted 2026-09-24 at FS-81's close, from FS-81's §IQ item 5, the plan-phase advisor's open question (close inventory items 12 and 18),
and `plans/FS81-derivation.md` §5 R7. Solver needs: **none** (exact cell computations and derivation).*

## Mission, in plain language

FS-81 decided three colours over every real quadratic field by one object: the **field-level slope** — a character `θ` of the ring
`ℤ[U_F]` that the unit vectors generate, putting every unit vector in the middle band `[1/3, 2/3]` mod 1 — read one **layer** at a time
(each rotated copy `b·U₅` of the rational unit vectors with 5-power denominators; G74). At three colours the slope exists for every
colouring (FS-73's height lift), so emptiness proves four colours are needed.

**At four and five colours the same object exists and means less.** A point of `Θ_k(F) = {θ : θ(U_F) ⊆ [1/k, 1 − 1/k]}` still gives a
proper `k`-colouring of the whole plane (colour `x` by `⌊k·{θ(x)}⌋`: a unit step moves `θ` by at least `1/k` and at most `1 − 1/k`). But
from four colours up no height exists (G71, G73), so **emptiness of `Θ_k(F)` proves only that no character colouring exists, never that
`χ(F²) > k`**. The method is one-sided there, and the stub must stay honest about it.

**Why the one-sided half matters.** The local–global conjecture (G48) predicts `χ = L(F)`, and a finite refusal only confirms it; it
falls only to a whole-plane colouring with fewer than `L(F)` colours that is local at no prime. A character colouring with a real
(archimedean) part is exactly such a colouring. So:
- **a point of `Θ₅(ℚ(√167))`** (where the conjecture predicts at least six) **falsifies the conjecture**;
- **a point of `Θ₄(ℚ(√47))`** (predicted exactly five) **falsifies its five-clause**;
- **emptiness** at those fields says character colourings cannot falsify it there — which sends the falsification hunt to FS-64's
  mixed-place colourings or closes it.

The advisor's guess (inventory item 12) is emptiness: a character with finite image reduces to `[Fischer1990]`'s additive colourings,
none with few colours at these fields; its sketch breaks at one step (the archimedean part). By compactness, `Θ_k(F) ≠ ∅` iff every
finite set of unit vectors has a point, so FS-79's and FS-81's finite `Θ₄` computations are its finite shadows.

## Shape

1. **The rational layer at band `[1/k, 1 − 1/k]`**: `Θ_k(U₅)` by FS73-T40's exact cell computation at the new band (k = 4, 5), then
   FS81-T3's chain argument — which types survive (parity plus an archimedean disc of radius?, orders 4, 5, …?).
2. **Gluing by relations** at ℚ(√47) and ℚ(√167): the type-M relation `1 = 2n − nv − nv̄` and the field's other short relations; does a
   torsion character like T4's `τ` exist at band `1/k`, and what does a relation force on it?
3. **The finite shadows**: an exact empty `Θ₄` on one of ℚ(√47)'s 25 survivors (FS-84) or `Θ₅` on a ℚ(√167) lattice proves the field
   has no character colouring at that `k` (the pull-back lemma, FS81-T1); P3b's finder and FS-79's partial census are the tools.
4. **Not in scope:** any lower bound on `χ` at `k ≥ 4` from this object alone.

## Predictions to register at the opening

The advisor's: `Θ₅(ℚ(√167)) = ∅` and `Θ₄(ℚ(√47)) = ∅`. Both outcomes reachable: no theorem forbids an archimedean-part character at
band `1/k ≤ 1/4`, and the rational layer's archimedean disc grows as the band widens.

## Provisional bearings (to be replaced by the re-grokking)

G74 (the layer method; its trigger is a field-level colouring question), G71 and G73 (why the method is one-sided from four colours),
G48 and G64 (the conjecture falls only to a whole-plane colouring local at no prime), G60 (fractional colourings: capped, a different
object), G66 (the residue ceiling does not drop), G62 (layers). FS-64 (the adelic window colouring) is its neighbour: a mixed-place
colouring where this stub's is a character. `LEDGER.md` rows 79–84.

## Bearing on χ ≥ 6

Speculative, and the only solver-free instrument aimed at the conjecture's falsifier at the fields where it is exposed. A no-go at
`k = 5` over ℚ(√167) says the conjecture cannot fall to a character colouring there.

**Cost:** the rational layer at two bands, a day (T40's code); the gluing at one field, unpriced.
