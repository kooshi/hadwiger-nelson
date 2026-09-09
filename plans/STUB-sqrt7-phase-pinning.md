# STUB — the `√7` route: phase-pinning with the Moser twist instead of `√5`

*Minted 2026-09-09. Coxeter's line, recorded here so it is not lost; the derivation is its work,
not mine.*

## The idea

`[Parts2020hv]`'s human-verifiable proof of `χ(ℝ²) ≥ 5` runs: (a) every `√3`-triple is
non-monochromatic — his computer step, 221 vertices; (b) hence the hexagonal lattice is, in one of
three directions, a stack of alternating two-coloured lines; (c) doubling; (d) two such sets at a
common centre, **one rotated by `arccos(7/8)`**, pin the phases so that every distance-4 pair is
monochromatic; (e) spindle at `arccos(31/32)`, adjoining `√63 = 3√7`.

Steps (a)(b)(c) live in `K = ℚ(√3,√11)`. **`√5` enters at exactly one step — (d) — and its only job
is phase-pinning.** `arccos(7/8)` is the rotation bringing the radius-2 shells of two copies of
`ℤ[ζ₆]` to unit distance. The **Moser twist `arccos(5/6)` brings the radius-`√3` shells to unit
distance**, and norm-3 elements are lattice points, so it is exactly as natural and it is native
to `K`.

**If the Moser twist pins the phases the way `arccos(7/8)` does**, then every distance-4 pair is
monochromatic in a pure `K`-object, and the `arccos(31/32)` spindle gives a 5-chromatic
unit-distance graph in **`ℚ(√3, √7, √11)`** — degree 8, no `√5`.

## Why the field matters

By M58's sieve, `ℚ(√3,√7,√11)` is the **only 6-open field** among the mascot candidates: `K(√5)`,
`K(√23)`, `K(√247)` are all sealed at five. It also answers `plans/FIELD-WALL-THEOREM.md` §8 item 2
("`√7` without `√5`"), a question this project posed itself on 2026-09-05 and never ranked.

## The open step

Let `L₀ = ℤ[ζ₆]`, `L₁ = ρL₀` with `ρ` the Moser twist. Given a proper 4-colouring of `L₀ ∪ L₁` with
no monochromatic `√3`-triple, do the cross edges force both phase sequences constant? Finite,
hand-checkable, no solver.

## The honest caveat

It still imports Parts's step (a), which is computer-found. It would improve the *field* of the best
published human-verifiable proof, not its self-containedness.
