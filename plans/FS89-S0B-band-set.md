# FS-89 Stage 0, part B — the exact four-colour band set of the rational unit circle at 5

*The Stage-0B agent's record (de Bruijn, Opus 5.5), from the owner's brief `data/fs89/briefs/S0B-band-set-brief.md`
(commit `0a346e98`). Outputs under `data/fs89/s0b/`. No SAT, no finder, no sweep; exact rational arithmetic only.*

**Objects.** `R₅ = ℤ[i][1/5]`; `U₅ = {iᵏwᵐ}` with `w = (3+4i)/5 = π/π̄`, `π = 2+i`; the band `B₄ = [1/4, 3/4]` mod 1;
`Θ₄(U₅) = {θ ∈ Hom(R₅, ℝ/ℤ) : θ(U₅) ⊆ B₄}`. `T + A` = torsion characters plus archimedean ones `λ_e(x) = Re(ē x)`.

## C0 — prediction, written before any computation (2026-09-25)

- **Is `Θ₄(U₅) ⊆ T + A`?** Probability **0.40** that it is (one prime suffices); **0.60** that a non-`T + A` point exists.
- *Why not lower:* a two-minute hand check (not a computation) of the slice `θ₂ + (a character trivial on ℤ[i] with
  zero π-component)` shows it rigid: one new 5-adic digit `t ∈ (1/5)ℤ/ℤ` shifts the pair `(θ(wᵐ), θ(iwᵐ))` by `(t, 2t)`,
  and no nonzero `t` keeps both within 1/4 of 0, so near the parity point the digit tree does not branch at all. The
  advisor's `5·(1/2)² = 1.25` assumes the base pair uniform; it is not.
- *Why not higher:* the rational pattern's four-colour cell set is larger than FS73-T40's three-colour one (order-3
  points become discs of radius 1/12; order-4 and mixed order-6 torsion points enter), so cell-to-cell transitions with
  nonzero digits can exist, and one branching strongly connected component is enough for a Cantor family.
- *Side predictions:* the four-colour cell list per period `5ℤ²` has 10–40 cells; the torsion part of `Θ₄(U₅)` is finite.

## Would-have-searched-here log

- (none yet)
