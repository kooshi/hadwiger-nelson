# FS-91 — band rigidity at six colours, and at one prime (stub)

*Minted 2026-09-25 at FS-89's close by the close planner (de Bruijn, Opus 5.5). Rank 2 in `plans/FRONTIER-STUBS.md` (the planner's
proposal; Kooshi and a next-step advisor choose the next milestone). Written for a session with zero conversation memory. Solver-free.*

## What FS-89 proved, in plain words

A **band character** at `k` colours is a group homomorphism `θ` from a ring of Gaussian rationals to the circle `ℝ/ℤ` that sends every
rational unit vector into the band `[1/k, 1 − 1/k]`; the colouring `x ↦ ⌊kθ(x)⌋` is then a proper `k`-colouring of the unit-distance
graph. FS-89 proved (`LEDGER.md` row 95; `plans/FS89-derivation.md`) that at four and five colours every band character of
`Q = ℤ[i][1/p : p ≡ 1 (mod 4)]` — and, by a gluing, of every real field's unit-vector ring — is a torsion character plus an archimedean
one. The route is Berend's closed-set dichotomy with the rotated (archimedean) plane set aside: at two or more primes an orbit closure
either has archimedean small differences (and meets `T + A`) or has every difference (D1-L3); then the parity character is a difference,
and the band forces a point `x` with `2x = θ₂` (a corner) into it; an orbit closure meeting `T + A` pins the point (VB1). At one prime it
fails (row 97).

## The questions

1. **Six colours (the headline).** Does the same route give `RS₆(S)` at every `|S| ≥ 2`, hence RQ₆ and `Θ₆(R_F) ⊆ T + A` for every real
   `F`? The close planner's reading (`plans/FS89-derivation.md` §10, one mind, **unchecked**): the route's band steps are only (a) Lemma SW
   (a pure local sweep moves `θ(u)` through a coset of step `1/p ≤ 1/5`, which must meet the excluded interval `(−1/k, 1/k)` — true for
   every `k ≤ 9`) and (b) the parity line (`x, x + ½ ∈ B_k` gives `2x ∈ B_{k/2}`: at `k = 6` that is `Θ₃`, rigid by FS81-T3; at `k = 8` it is
   `Θ₄`, rigid by row 95). So step one is to re-read VB1 and Lemma SW (`plans/FS89-S1VB-verification.md` §B1.0–B1.1) at band 1/6 and 1/8
   and say exactly which line uses `k ∈ {4, 5}`. D's own route needs the band-1/6 exit lemma (`plans/FS89-S1D-derivation.md` §5 "Where it
   stops"), which VB1 would make unnecessary.
   **Since the Berend reading (`plans/FS89-PA-berend1984.md` §5, at the close):** (i) the minimal-set step needs no band at all —
   `[Berend1984]` Thm I.2 with Prop. II.6 gives "a minimal `M` with `M − M = R̂_S` is `R̂_S`" for this action, so `MS_k(S)` holds at every
   `k` and every `|S| ≥ 2` (FS89-PA-B2, hand, one mind, resting on D1-L2 and D1-L3), and only the point step (VB1, Lemma SW) carries the
   band; (ii) the reader reached the same widening from Lemma SW — `RS_k(S)` for every `k < 2·min S`, so `RQ_k` for every `k ≤ 9` via
   `{5, 13}`, and `RS₅(S)` without `5 ∈ S` (PA-B3). **The same observation twice, not independent evidence, and unverified.** So the
   milestone's first act is a **blind verifier** given PA-B2's and PA-B3's statements (not their arguments), asked to re-derive VB1 and
   SW at `k = 6, 8, 9` and say which line, if any, uses `k ≤ 5`.
2. **What six would give.** At ℚ(√167) the conjecture predicts at least six (CLAUDE.md, the target). A character six-colouring of
   ℚ(√167)'s plane would then be a torsion character at the stable places 23, 43, … in the band at level one; whether `Γ₂₃` and `Γ₄₃` admit
   a six-colour band character is a finite exact question at level one (`α(Γ₂₃) ≤ 97` gives ratio 0.183 > 1/6, so the five-colour argument
   of FS89-S0A-9 does not transfer). Scope: characters only, never `χ`.
3. **One prime** (FS-89's open side questions): U3, `RS₄({p})` false at every single prime `p ≡ 1 (4)` (proved at 5 only, S0B-T3); and
   `MS₄({5})`, whether the rank-one minimal sets are all in `T + A` (D predicted false at 0.75: Berend's Lemma 3.3 shape); U5, whether the
   one-prime torsion orders are unbounded (a reading of two minds; `data/fs89/s0b/torsion-points-k4-N130.txt` lists 12 orders below 130).
4. **Absorbed:** FS-83's `k ≥ 6` remainder (FS-83 is answered at `k = 4, 5` at the exposed fields, row 96).

## Provisional bearings (the minting session's; the re-grokking replaces them)

G76 (the closed-set frame and its Do line), G74 (layers; its reading fired at one prime), G71/G73 (from four colours up emptiness of `Θ_k`
is one-sided), G56/G59/G64 (the window for six; six hides between `L(F)` and `χ(F²)`), G48 (the conjecture), G72 (the structural form),
G21 (a finite window measures its depth), G49/G50 (`[Berend1984]` and 1983 held since FS-89's close; the prior-art reader's record
`plans/FS89-PA-berend1984.md`).

## Bearing on χ ≥ 6

Speculative and indirect: a character statement at six colours is not a statement about `χ`. It would decide whether the layer method
(FS-83) or any single character can six-colour ℚ(√167)'s plane, the conjecture's widest gap.
