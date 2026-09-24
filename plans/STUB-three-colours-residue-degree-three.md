# FS-82 — three colours at residue degree three: the one real number field class the three-colour theorem leaves open (stub)

*Minted 2026-09-24 at FS-81's close, from `plans/FS81-derivation.md` T7 (the verifier's contrapositive and its residual case) and §5 R6.
Solver needs: **none** (exact polytope trees and hand derivation; the week after FS-81's close bans SAT solvers).*

## Mission, in plain language

FS-81 proved (`LEDGER.md` row 82, [hand, two independent derivations]) that the plane over a subfield `F` of ℝ needs four colours
whenever `1/3` lies in the ring its unit vectors generate and the plane is not two-colourable. Together with two older facts — a prime
of `F` above 3 with residue field `𝔽₃` gives an additive three-colouring (through `𝔽₉`), and prime inversion (`1/3 ∈ ℤ[U_F]` iff no
conjugation-stable prime of `F(i)` lies above 3) — this gives, for every real number field (T7, [derived]):

> `χ(F²) = 3` ⟹ some prime of `F` above 3 has **odd** residue degree.

Residue degree 1 gives three colours; residue degree 2 makes the prime unstable. **The one case left open is a non-bipartite field whose
primes above 3 of odd residue degree all have degree ≥ 3.** There F-T4 is silent (`1/3 ∉ ℤ[U]`), and no additive three-colouring passes
through such a prime: the unit vectors reduce onto the whole norm-one group of `𝔽_{q²}` (Hilbert 90), so an additive colouring through
it would three-colour `Γ₂₇`, which needs at least six. So a three-colouring there must be **non-additive** — a field-level slope with
real (archimedean) parts, the kind FS-81's layer method classifies.

**First instance: `F = ℚ(α, √7)`, `α³ = α + 1`.** 3 is inert in the cubic (`x³ − x − 1` has no root mod 3) and splits in ℚ(√7)
(`7 ≡ 1 mod 3`), so both primes of `F` above 3 have residue field `𝔽₂₇`. `F` contains ℚ(√7), whose plane is three-chromatic
(`[Fischer1990]` Thm 9), so `F²` is not bipartite.

**Why it is an exposed test of the local–global conjecture** [derived by the close planner, 2026-09-24; re-derive at the opening]:
7 has a prime of residue degree 1 in the cubic (`x = 5` is a root mod 7: `125 − 5 − 1 = 119 = 17·7`) and ramifies in ℚ(√7), so `F`
has a prime above 7 with residue field `𝔽₇`, stable in `F(i)` (7 is inert in ℚ(i)): the plane at 7 four-colours `F²`. No residue
target of `F` is three-colourable (no `𝔽₃` prime; the dyadic targets have `χ ≥ 4`). So **L(F) = 4 and the conjecture predicts
χ(ℚ(α,√7)²) = 4**; a three-colouring of this plane — necessarily non-additive — would falsify it at L = 4, outside its proved range
(L ≤ 3 in general, L ≤ 4 with √3 or for real quadratic fields).

## Shape

1. **The rational layer is unchanged.** `U₅ ⊆ U_F` for every `F`, so FS81-T3 (C1(5)) classifies every layer: parity plus an
   archimedean disc, or order 3. T4's torsion character `τ = lim θ(25^{−k}·)` still exists.
2. **The question in the theory's terms:** does `Θ₃(F)` have a point? Every point's layers are typed; L4′ fails only because
   `1/3 ∉ ℤ[U_F]`. Which relations among unit vectors of `ℚ(α, √7)` constrain the layer types, and does any force a contradiction?
   The residue at the degree-3 primes is where the order-3 types would have to live, and Hilbert 90 forbids a purely additive answer.
3. **A finite route to `χ ≥ 4`, solver-free:** a finite configuration of unit vectors with empty `Θ₃`, certified by FS-73's frozen
   relation-tree checker or by a structural certificate in FS-81's form (T9, T12), gives `χ(F²) ≥ 4` at [cert + hand] by FS73-T22's
   ⟹ direction — and with the plane at 7, `χ = 4` exactly. Aim first at layers built from the type-M rotations that exist in `F`
   (G7's `cos θ = (2n−1)/(2n)` with `√(4n−1) ∈ F`), as FS-81 did.
4. **The other side:** if `Θ₃(F)` has a point, it is a three-colouring local at no prime (Hilbert 90), which the conjecture forbids —
   decide whether its gluing survives every relation before believing it (the finite-level trap, FS81-T8: finite configurations admit
   points the field does not).

**Cheap follow-ups carried here:** none of FS-81's leads bears on this field; the d ≡ 23 (mod 48) lead went to FS-75.

## Predictions to register at the opening

- `Θ₃(ℚ(α, √7)) = ∅`, so χ = 4 (the conjecture's prediction). Probability to set at the opening; the other outcome is reachable
  because no theorem forbids a non-additive slope here.

## Provisional bearings (to be replaced by the re-grokking)

G74 (the layer method; its killing test is this field), G71 (the `Θ₃` tree and its cells), G55/G35 (prime inversion at 3), G38 (additive
colourings and their thresholds), G43/G48 (the residue plane at 7; L(F)), G62 (layers as rotations of a base pattern), G21 (a finite
configuration's point is not the field's). `LEDGER.md` rows 79, 82, 83.

## Bearing on χ ≥ 6

None. On the programme: it completes the three-colour classification of real number fields, and it is a cheap, solver-free exposed test
of the conjecture at L = 4 in a field with neither √3 nor a four-chromatic quadratic subfield.

**Cost:** the field's small type-M rotations and a first configuration, an afternoon; a structural certificate, a day; the field-level
classification, unpriced.
