# FS-6 — A family-keeping thickening: where M57's principle could bite (STUB, 2026-09-06, minted at the M57 close)

*Read beside this: `plans/M57-additive-rigidity.md` §R4–§R5 (the F₂₄₇ cross lattice's 5-divisibility, the cumulative
dial 1,728 → 960 → 640 → 0, Heule-510's 3,456 → 96), §M1.6 (the dial's axis is the direction set), M56 §M1.7 (L7:
1/5 ∈ Σ₀ of every plane), `CLAUDE.md` G42.*

## 1. Mission context, in plain language

M57's design principle — make every 5-colouring of a unit-distance chunk additive, so a 5Λ-pair is forced and a spindle
gives χ(ℝ²) ≥ 6 — needs two things at once: a NONZERO additive family (some ℤ/5-hom of the chunk's lattice nonzero on
its unit vectors) and a CLOSED one (every {a, b}-subgraph of every hom connected, γ = 0). Every unit-distance object we
hold fails the second by orders of magnitude, and the one way we know to add material where the first still holds —
in-field (K) points, always in-lattice — sits on 4-colourable unit parts that can never be rigid. The wall-broken
thickening that moves M54's redundancy dial (F₂₄₇'s cross lattice) kills the family at depth one: the 63 cross points'
unit vectors generate a lattice in which 500 of W's unit vectors are 5-divisible. Fischer's 1/5 ∈ Σ₀ says every plane's
rich chunks lose their ℤ/5-homs eventually; the question is whether ANY construction adds directions slowly enough —
keeps the joint lattice 5-indivisible — to close the Kempe subgraphs before the family dies.

## 2. What we know

| fact | where |
|---|---|
| W (1,175, F₂₄₇): 1,728 homs; W + first 48 cross points: 640; W + 63: 0 with 500 units in 5Λ | M57 §R5 |
| the depth-2 F₂₄₇ stage: no hom at any radius; 98 % of every ball's units in 5Λ | M57 §R5 |
| Heule-510: 3,456 homs on its inner 428 points, 96 on the whole (the last ring, |S₅| 42 → 60) | M57 §R5 |
| the 1581: ≥ 2,981 homs (rank 16); its gen-1 half-spindle closure (24,065 points): the dial running at the M57 close | M56 §R3; `build/m57/richness-degrey.log` |
| in-lattice points never kill a hom by coverage; a new-direction point kills a hom iff its neighbours' colours cover the group | M57 D5 / §M1.5 |

## 3. Derivations first

**D1 — when does a new unit vector make an old one 5-divisible?** u ∈ 5Λ′ with Λ′ = Λ + ℤv means u = 5(a + m v), a ∈ Λ:
5m v ∈ u − 5Λ. Derive the condition on v's coordinates in ℚΛ (v ∈ ℚΛ ∖ Λ of order m with 5 | m is the F₂₄₇ case —
the index-5 points of §R4); a new-direction v (v ∉ ℚΛ) can never do it. So a thickening keeps the family iff its new
points are in-lattice or new-direction, never rational of order divisible by 5 — a per-point exact test, before any
hom is computed.

**D2 — the closure's growth.** The half-spindle words act on the 1581's 67 direction classes; the gen-1 closure's
directions are their images plus the chords between orbit points. Predict: rank grows past 16 (new-direction points)
and the family survives longer than in F₂₄₇ (whose cross points are all rational-of-order-5 or in-lattice).

## 4. Phases

| phase | what | cost |
|---|---|---|
| 0 | D1 as an exact per-point classifier (`additive.py extend` already reports the case; add the 5 ∣ m flag) | an hour |
| A | the de Grey dial (finish), the Heule-field closure (the 510 under its own words), each with the classifier's tally | a day |
| B | on the best field: grow by in-lattice and new-direction points only, read γ̄ per step | a day |

## 5. Registered predictions

| # | prediction | confidence |
|---|---|---|
| P1 | the gen-1 closure keeps ℤ/5-homs on its r² ≤ 1 ball (11,053 points) and loses them by r² ≤ 4 | low |
| P2 | no in-lattice-plus-new-direction thickening of W reaches γ̄ below half its value before its family falls below 100 | medium |

## 6. Failure and jackpot clauses

P2 refuted on any object: the principle is live — HALT the survey, run `rigid` on that object under the jackpot protocol.
P1 refuted in the "loses" direction (homs survive the whole closure): the family is far more robust than F₂₄₇'s, and B
runs on de Grey's field first.

## 7. Bearing on 6, honestly

Medium. It is the only place M57's principle could apply; a negative closes the principle at five colours as a design
route and hands the question back to FS-2 (what carries forcing without rigidity).
