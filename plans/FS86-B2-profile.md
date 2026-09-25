# FS-86 stage B2–B3: the dyadic profile of `Λ₅₁₀` and exact certificates for "rich"

*de Bruijn (Opus 5.5), briefed by the product owner 2026-09-25 (`data/fs86/briefs/B2-profile-brief.md`, commit d3a523c1). Plan:
`plans/FS86-dyadic-rigidity.md` §S.1, §B, §P, §G.3, §R-review. Tools and outputs: `data/fs86/b2/`. Every number is exact unless
labelled float. The finite-witness-free week applies: no colouring search of any kind.*

## §state (the resume point)

- C0 written (below), committed before any result.

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

## "Would have searched here" log

(one line per move I would have made by search, and what I did instead)

## Theorems this phase proved

(none yet)
