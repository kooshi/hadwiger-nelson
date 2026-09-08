# FS-16 — The residue-allowed distances: where a five-colour virtual edge can live over a sealed field (STUB, 2026-09-07; minted at the M60 close)

> **Build triage 2026-09-08 (for Opus 5, `plans/BACKLOG-FOR-OPUS.md` B5):** see that file for the spec, the acceptance gate and the stop rule before starting; results go into a `## §B. Built` section here.

*Read beside: `plans/M60-five-colour-residue-obstruction.md` §S3, §R3, §R7 (the distance law and the M55 census); `Instances/ResidueObstruction11.lean`
(`not_separated_of_pairsAt_11`: a virtual edge at five colours over the `√7`-free tower needs `d² ≡ 1 (mod 11)`); `data/fplane/residue-filter-W-plus-cross-depth2-p11.json`.*

## 1. Mission context, in plain language

M60 proved that over a field where 11 is usable and the plane at 11 is 5-colourable (every field the descent ever used), a pair
separated by every 5-colouring of a unit-distance graph — a virtual edge, the gadget χ(ℝ²) ≥ 6 needs at two distances — has
residues that are ADJACENT in the finite plane: its squared distance is ≡ 1 modulo the prime above 11. So the only distances at
which a five-colour virtual edge can exist over such a field are the residue-allowed ones: `d² ∈ {1, 12, 23, 34, 45, 56, 67, 78, 89,
100, …}` and rationals like `64/9` — `1, 2√3, √23, √34, 3√5, 2√14, √67, √78, √89, 10, 8/3, …`. Neither hex-shell distance is among
them, so no 6-forcer; but a five-colour virtual edge at `2√3` or `8/3` is NOT excluded, and none has ever been found or refuted.
M60's re-reading of M55's 108 theorem-admitted virtual-edge asks on the 10,541-point grown witness found that of the 86 the solver
left undecided, the 35 at residue norm ≠ 1 fall to the theorem with a verified colouring each, and **51 sit at residue norm 1** — far
more than a uniform residue would give (1/11) — at 41 distinct exact squared distances, 41 of them cross–cross pairs. Those 51 are
exactly the asks the residue theorem cannot touch, and they are still undecided.

## 2. What we know

| fact | where |
|---|---|
| the distance law (kernel at 11): forced-equal ⟹ `d² ≡ 0`, virtual edge ⟹ `d² ≡ 1` | `Instances/ResidueObstruction11.lean` |
| the 51 residue-allowed asks (pairs, residues) and the 35 settled | `data/fplane/residue-filter-W-plus-cross-depth2-p11.json` |
| the theorem-admitted candidates come from the critical-set localization (M54): a virtual edge needs `C ⊆ N(u) ∪ N(v)` | `plans/M55-absorption.md` §R6 |

## 3. Derivations first

**D1 — why do the admitted candidates concentrate at residue norm 1?** (T44.) The candidates are pairs with the stage's one critical
vertex (the fused centre) in `N(u) ∪ N(v)`; derive the residue-norm distribution of such pairs from the stage's construction (the
cross lattice's glue points are at unit distance from two W points) before reading anything into 59 %. If the concentration is
structural (glue points of W-pairs are residue-adjacent to … ), it says the localization theorem and the residue theorem select
overlapping populations, i.e. the residue filter is weakest exactly on the theorem-admitted asks.

**D2 — the residue-allowed graph of a stage.** For a stage over a sealed field, the graph whose edges are the pairs at `d² ≡ 1 (mod 11)`
(with the unit edges among them) is the ONLY place any five-colour virtual edge can be; its structure (is it much bigger than the
unit graph? which distances dominate?) is a census, exact and cheap (`fpcompel.py filter` over all pairs).

**D3 — the two named distances.** `2√3` (the doubled hex-shell distance; a spindle there adjoins `√47`, and `K(√47)` keeps 11 usable —
so a virtual edge at `2√3` cannot make a 6-forcer either, consistent) and `8/3` (the K-fabric's forced-equal distance at FOUR colours,
M53's dial): is either a five-colour virtual edge anywhere on the grown witness? The 51 asks may contain instances.

## 4. Phases

| phase | what | cost |
|---|---|---|
| 0 | D1 by derivation from the candidate generator; D2's census on the grown witness | hours |
| A | the 51 asks with a longer wall / cube-and-conquer (they refused 900 s) | a day of CPU |

## 5. Registered predictions

| # | prediction | confidence |
|---|---|---|
| P1 | the norm-1 concentration is structural (D1 has a derivation), not chance | medium |
| P2 | none of the 51 is a virtual edge (the stage is absorbed, M55's reading) | medium-high |

## 6. Bearing on 6, honestly

Low-medium: a filter and a census on the descent's genre; no object; its value is negative knowledge made cheap (every future
five-colour ask over a sealed field is residue-screened first) and one open reading (T44).

## 7. Addresses

`tools/fpcompel.py filter`, `data/fplane/residue-filter-*.json`, `Instances/ResidueObstruction11.lean`.
