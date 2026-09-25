# FS-86 stage B2–B3: the dyadic profile of `Λ₅₁₀` and exact certificates for "rich"

*de Bruijn (Opus 5.5), briefed by the product owner 2026-09-25 (`data/fs86/briefs/B2-profile-brief.md`, commit d3a523c1). Plan:
`plans/FS86-dyadic-rigidity.md` §S.1, §B, §P, §G.3, §R-review. Tools and outputs: `data/fs86/b2/`. Every number is exact unless
labelled float. The finite-witness-free week applies: no colouring search of any kind.*

## §state (the resume point)

- C0 written (below), committed before any result (fb0039df).
- Positive control PASSED and both planted faults went red (§1). Next: the embedding of `U₅₁₀` into `O` and `m*` (§2).

## C0. My predictions, written before any computation

Registered against the plan's §P rows. Reasons are mine, from reading the plan and row 67 only; nothing computed yet.

| id | the plan's prediction | plan p | my p | my reason |
|---|---|---|---|---|
| P-sat | `m* ≥ 5` (`U ↠ S_5`, 48 residues) | 0.55 | **0.65** | 324 unit vectors against 48 residues, and `U` is closed under `z ↦ −z, iz, z̄` and the flip `√59 ↦ −√59` (the local `√3 ↦ −√3`), so it covers in orbits; 48 residues are about 3–6 orbits under that group against about 20 orbits of `U`. Against it: `U` is a few layers of structured rotations (`U₅`, `U₁₇`, the type-M `v₁₅`), not random, and a structured set can miss a whole coset. I expect `m* ∈ {5, 6}` most likely, `m* ≤ 7` certainly (`|S_8| = 384 > 324`) |
| P-slack | some `Q_m` slack at four colours by the injective level | 0.80 | **0.85** | past saturation the level map `T_{m+1} → T_m` loses its constant fibres, so FS38-L1's propagation and FS38-L2's pairing both break; at the injective level `Q_m ≅ Cay(O/𝔓^m, U)` and the 45 pulled-back minimisers read `Σ_s f(s)χ(s)` with `f` the fibre sizes of `U → S_4`, which is `−d/3` only if `f` is orthogonal to every minimiser — no reason for that. I expect the first slack level at `m* + 1` or `m* + 2` |
| P-undec | at least one slack level stays "slack, undecided" this week | 0.70 | **0.75** | deciding whether a finite slack `Q_m`'s four-colourings all pull back from a tight quotient needs either a search (banned) or a structural argument; row 87's L16 was decided only because the infinite lattice was already solved (row 85). A derivation could still close it if `T_m` keeps both lifts of enough generators to force fibre-constancy (the `K_{2,2}` structure of FS-38 §0), so not near 1 |

Also registered, mine (not in the plan): **P-B2-inj** — `U mod 𝔓^m` is injective by `m ≤ 12` (p = 0.6); **P-B2-L3** — the lattice
analogue of FS38-L3 is weaker than the full tower's: `𝔓⁴ ⊄ M_Λ ⊗ ℤ₂` (p = 0.5; I have no strong reason either way); **P-B3** — every
listed prime's (R4) certificate is exact and refuses four colours, except that 29 (Hoffman float 0.2533, open) rests on `χ(UD(𝔽₂₉,2)) ≥ 5`,
whose grade I have not yet checked and which may be a measurement, not a theorem (p = 0.5 that 29 is certified by theorem).

## §1. The positive control: row 67's table, reproduced on the full `S_m` (B2, first)

**Instrument** (`data/fs86/b2/tower.py`, built for this stage from the ring axioms, not from FS-38's code): `O = ℤ₂[ω][√3]` in the basis
`(1, ω, √3, ω√3)`, conjugation `ω ↦ ω²` with `√3` fixed, `𝔓 = (1 + √3)`, canonical residues mod `𝔓^m`; `S_m = {z : z z̄ ≡ 1}` built by lifting
level by level; characters `u ∈ (ℤ/N)⁴`, `N = 2^⌈m/2⌉` (for odd `m`, `u₀ + u₂` and `u₁ + u₃` even). **Every eigenvalue is held exactly** as an
integer vector in `ℤ[ζ_N]` (basis `ζ⁰ … ζ^{N/2−1}`); "`λ = −d/3`" is decided exactly; "nothing below `−d/3`" by float with margin `10⁻⁶` on the
characters not exactly equal (float error ≤ `d·10⁻¹⁵`), and a character within the margin but not exactly equal is flagged (none occurred).

**Result** (`control.py` → `control.out`, 1.6 s): `|S_m| = 3·2^{m−1}`, norm one, `S = −S`, `S_m ↠ S_{m−1}` at levels 1–8; and the table, every
entry **exact** and equal to `plans/FS38-derivation.md` §D-2(b):

| m | n | d | λ_min | tight (exact) | # minimisers | \|H_min\| | H_min = 𝔓⁴/𝔓^m | second-least |
|---|---|---|---|---|---|---|---|---|
| 1 | 4 | 3 | −1 | yes | 3 | 1 | — | 3 |
| 2 | 16 | 6 | −2 | yes | 9 | 1 | — | 2 |
| 3 | 64 | 12 | −4 | yes | 21 | 1 | — | 0 |
| 4 | 256 | 24 | −8 | yes | 45 | 1 | yes | 0 |
| 5 | 1024 | 48 | −16 | yes | 45 | 4 | yes | −8 |
| 6 | 4096 | 96 | −32 | yes | 45 | 16 | yes | −16 |
| 7 | 16384 | 192 | −64 | yes | 45 | 64 | yes | −32 |
| 8 | 65536 | 384 | −128 | yes | 45 | 256 | yes | −64 |

**Planted faults, both red** (same script): (1) *a wrong generator* — at each level ≥ 2 the pair `±s₀` replaced by `±(s₀ + π^{m−1}ω)`: the
table mismatches at levels 2, 4, 5, 6, 8 (at 2 and 4 `λ_min` drops below `−d/3`; at 5, 6, 8 the second-least eigenvalue moves). **Honest limit:**
this plant is invisible at levels 3 and 7 (the table there is unchanged), so one level's match would not have caught it; the eight-level table
does. (2) *a wrong conjugation* (`√3 ↦ −√3`, `ω` fixed — another torus): mismatches at every level (`d` itself changes). The control's failure
mode is reachable and was reached.

## "Would have searched here" log

(one line per move I would have made by search, and what I did instead)

## Theorems this phase proved

(none yet)
