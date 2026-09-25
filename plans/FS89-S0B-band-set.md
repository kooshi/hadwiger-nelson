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

## C1 — the positive control: FS-81's three-colour result, reproduced on two code paths (2026-09-25)

Two exact models of the same set, written for this stage (each imports only the frozen clipping routine of
`tools/fs81_verify_thetaR.py`; nothing frozen is edited):
- **the L-layer model** (FS81-C-verification §1.2's): layers `wᵐL`, `L = (1/5)ℤ[i]`, states `μ ∈ ℂ/5ℤ[i]` in the cells of
  the rational pattern (`tools/fs89_s0b_cells.py`, `tools/fs89_s0b_graph.py`, `data/fs89/s0b/count_words.py`);
- **the orbit model** (derived in §1 below): layers `wᵐℤ[i]`, states `e ∈ ℂ/ℤ[i]` in the square `Q = [lo, hi]²`, one step
  `e' − w̄e ∈ π⁻¹ℤ[i]` (`tools/fs89_s0b_orbits.py`).

| check (band `[1/3, 2/3]`) | result | file |
|---|---|---|
| cells of the rational pattern | exactly FS73-T40: the 12-gon `c0 + D0` and the four points `c0 + (±5/6, ±5/6)` | `data/fs89/s0b/cells-k3.txt` |
| realizable L-layer words of length `n = 1..12` | 5 at every length (FS81-T8(a)) | `layerL-words-k3.txt` |
| orbit-model pieces at depth `K = 0..8` | 5 at every `K ≥ 1`: one polygon containing the centre `(1/2, 1/2)` and the four points `(a/3, b/3)`, `a, b ∈ {1, 2}` — the parity character's shrinking polygon (`→` the disc `|e − (1+i)/2| ≤ 1/6`) and `X₃` (FS81-T3) | `control-k3-none.txt` |
| planted fault 1: the forward digit lattice `π̄⁻¹ℤ[i]` in place of `π⁻¹ℤ[i]` | red: 0 pieces from `K = 1` (the parity character is no longer an orbit) | `control-k3-lattice-pibar.txt` |
| planted fault 2: the band's top edge moved in by 1/15 | red: one polygon, no `X₃` points | `control-k3-band-hi.txt` |
| cell-tool plants (drop the direction `(3+4i)/5`; band top −1/15) | red, each | (run log, this record) |

**The two models agree exactly at four colours too**: the number of orbit-model pieces at depth `K` equals the number of
L-layer words of length `2K − 1` — 29, 157, 593, 2017, 6349, 19113 at `K = 1..6` — and so do the point pieces (16, 88,
324, 1032, 3104, 8924). Both count the connected components of FS81-T8's `Θ_K` (characters of `5^{−K}ℤ[i]` with the band
on `|m| ≤ K`), by different layerings; the agreement is the cross-check.

**Four-colour depth table** (orbit model, `data/fs89/s0b/orbit-counts-k4.txt`; cells `data/fs89/s0b/cells-k4.txt`):

| depth K | pieces of `Θ_K` | point pieces | polygon pieces | ratio to K−1 |
|---|---|---|---|---|
| 1 | 29 | 16 | 13 | — |
| 2 | 157 | 88 | 69 | 5.41 |
| 3 | 593 | 324 | 269 | 3.78 |
| 4 | 2017 | 1032 | 985 | 3.40 |
| 5 | 6349 | 3104 | 3245 | 3.15 |
| 6 | 19113 | 8924 | 10189 | 3.01 |

At three colours the count is constant (5); at four it grows (about 1.7 per layer at `K = 6`, two layers per depth). The
rational pattern's four-colour cell list: 29 cells per period `5ℤ²` — one 12-gon (the parity cell), four hexagons (the
order-3 characters `X₃`, fattened), eight quadrilaterals, sixteen points (eight are the order-4 torsion characters
`(a + bi)/4`-type, in four 2-cycles; eight have `5 | ` the order of their restriction to `L`, so no torsion character
restricts to them). *Side prediction scored:* 10–40 cells — met (29).

## Would-have-searched-here log

- (none yet)
