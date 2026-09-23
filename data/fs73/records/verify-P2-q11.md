# FS-73 P2 — independent verification: ℚ(√11)'s 3-integral lattice Λ₁₀ at three colours, `F = P = 3Λ`

*Verifier: the same independent de Bruijn (Opus 5.5) agent that verified P1d (`verify-P1d.md`), briefed by the product owner,
2026-09-23. One writer. Machine: the desktop. The claim is implementer B's (phase P2), measured and pending this check.*

**Independence.** Before the verdicts were written, this agent read only the brief and FS-58's frozen forcer files
(`data/fs58/witness-11/forcer.json`, and in `data/fs58/witness-11/steps.jsonl` the step
`forcer/scan/separate/u=-3,-2,-6,1/span3`), plus the header lines of `data/fs58/witness-11/forcer.out`. It did not read
`tools/fs73_table.py`, anything under `data/fs73/table/`, or B's phase record. All code is `tools/fs73v_q11.py`, written from
the definition; it reuses only the generic integer Hermite-normal-form and membership routines of `tools/fs73v_lattice.py`.

## Theorems this phase proved

None. Verification is measurement. The facts, for the close:

| fact | grade | where |
|---|---|---|
| The unit vectors of ℚ(√11)(i) with denominator dividing 10 number exactly 36; their ℤ-span Λ₁₀ has rank 4 and index 4 in `(1/10)ℤ⁴` | [tools], exact | `tools/fs73v_q11.py` |
| Every proper 3-colouring of FS-58's 52-point graph identifies `0` and `3u₁`, and of its 65-point graph `0` and `3u₂` | [cert] Glucose DRUP proofs accepted by drat-trim; **and** [tools] exhaustive enumeration of all colourings, no solver involved | checks 3, 3′ |
| The linear automorphisms of Λ₁₀ preserving U form a group of order 16; `3u₂`'s orbit spans a rank-4 sublattice of index 9 in `3Λ`; `3u₁`'s orbit spans rank 2; together they span exactly `3Λ` | [tools], exact | check 4 |
| The point group has 10 orbits on the 40 lines of `Λ/3Λ`, and each orbit's representative is separated from 0 by a `3Λ`-periodic proper 3-colouring (all ten are affine) | [tools], colourings exhibited and verified | check 5 |

With the hand argument of check 5, these give **`F = P = 3Λ`** on `Cay(Λ₁₀, U)` at three colours: every proper 3-colouring is
`3Λ`-periodic, and no `δ ∉ 3Λ` is identified by every periodic 3-colouring.

## Verdicts

| check | verdict | evidence |
|---|---|---|
| 1. Λ₁₀ and its complete U: 36 vectors, rank 4 | **pass** | 36 found by exhaustive integer enumeration; the HNF of `10Λ₁₀` has rows `(1,0,0,1), (0,1,1,0), (0,0,2,0), (0,0,0,2)`, index 4 in ℤ⁴ |
| 2. The forcers' points lie in Λ₁₀; edges re-derived exactly | **pass** | 52 and 65 distinct points, all in Λ₁₀, each holding `0` and `3u`, with `0` and `3u` non-adjacent. Edges: 111 (FS-58 recorded 111) and 139 |
| 3. "graph + edge {0, 3u}" refused at three colours | **pass, both** | Glucose UNSAT; each DRUP proof **VERIFIED** by drat-trim; each planted satisfiable formula **NOT VERIFIED** |
| 3′. The same without any solver | **pass, both** | exhaustive backtracking: 122,900 colourings of the u₁ graph with `c(0) = 0` and 1,814,256 of the u₂ graph; **none** gives `3u` a colour different from `0` |
| 4. Point group; `3u₂`'s orbit spans index 9 in `3Λ`; `3u₁` and `3u₂` together span `3Λ` | **pass** | group of order 16; orbit sizes 8 and 16; spans of rank 2, of index 729 in Λ (= 9 in `3Λ`), and of index 81 in Λ, equal to `3Λ` |
| 5. The upper half, `P ⊆ 3Λ` | **pass** | 10 orbits of lines; 10 of 10 separated by `3Λ`-periodic colourings, each verified on the quotient and pulled back to 2,401 lattice points (7,156 edges, 0 monochromatic) |

## Check 1 — Λ₁₀ and U

Representation: `z = x + iy` on the basis `(1, i, √11, i√11)`, scaled by 10 to integers `(p, q, r, s)`, so that
`x = (p + r√11)/10` and `y = (q + s√11)/10`. FS-58's `(a, b, c, e)` is `(p, r, q, s)`. A unit vector is exactly
`p² + q² + 11r² + 11s² = 100` together with `pr + qs = 0`. The enumeration bounds `|p|, |q| ≤ 10` and `|r|, |s| ≤ 3` are exact,
since `11·4² > 100`. `ℤ[√11]` is the ring of integers of ℚ(√11), so "denominator divides 10" means `x, y ∈ (1/10)ℤ[√11]`.
**U is complete:** Λ₁₀ is spanned by vectors in `(1/10)ℤ⁴`, so every element has denominator dividing 10, and its unit vectors
are exactly the 36. Rank 4. U is closed under negation.

## Check 2 — the forcers

| forcer | FS-58 step | `u` | points | in Λ₁₀ | edges (recorded) | 0 and 3u present | 0 ~ 3u |
|---|---|---|---|---|---|---|---|
| u₁ | `forcer/scan/separate/u=-6,0,8,0/span2` | `(−3/5, 4/5)` | 52 | all | 111 (111) | yes | no |
| u₂ | `forcer/scan/separate/u=-3,-2,-6,1/span3` | `((−3−2√11)/10, (−6+√11)/10)` | 65 | all | 139 (not recorded) | yes | no |

The edges are every pair whose difference lies in U. A difference of two points of Λ₁₀ lies in Λ₁₀, so this is the full
unit-distance graph of the point set over ℚ(√11). Each forcer is connected.

## Check 3 — the refusals (Glucose and drat-trim, the builds of `verify-P1d.md`)

**Encoding.** Seeded random vertex and clause order; colour-major variables; exactly one colour per vertex; for every edge and
colour, the two endpoints do not both take it. Then the added edge `{0, 3u}` and the pins `c(0) = 0`, `c(3u) = 1`.
**The break and its soundness:** in any proper 3-colouring of the graph plus `{0, 3u}`, `c(0) ≠ c(3u)`, so relabelling the
colours sends them to 0 and 1. With two of the three colours pinned, no colour symmetry is left, so there is no second break.
**UNSAT therefore means every proper 3-colouring of the graph gives `0` and `3u` the same colour.**

| forcer | CNF sha256 (clauses) | Glucose | proof (bytes, sha256 prefix) | drat-trim faithful | planted formula | drat-trim planted |
|---|---|---|---|---|---|---|
| u₁ | `87c95b88…` (546) | UNSAT | 5,689, `655ac2d1` | **VERIFIED** | SAT | **NOT VERIFIED** |
| u₂ | `a96613a9…` (682) | UNSAT | 8,043, `150ab9a3` | **VERIFIED** | SAT | **NOT VERIFIED** |

**The planted formula** drops the added edge and the pin on `3u`, which removes 4 clauses. It is satisfiable, and Glucose returns
a model; so no refutation of it exists, and drat-trim's refusal is the proof checker's live negative control. Both proofs are
committed in `data/fs73/records/verify-P2-q11/`. The CNFs are regenerated byte-identically by the tool: the seeds are fixed and
the digests above.

**Controls.**
- *Non-vacuity.* Each graph alone is 3-colourable. Glucose found a colouring, verified with 0 monochromatic edges, and it has
  `c(0) = c(3u)`. Without this, the forcing would be vacuous.
- *Consistency with the claim.* For every vertex `w` of each forcer not adjacent to 0, the tool asked whether `0` and `w` can
  be separated in that graph. For the u₁ graph, 44 pairs were separable, each colouring verified, and exactly one pair was
  forced, `3u₁`. For the u₂ graph, 55 were separable and exactly two were forced: `3u₂`, and `(−9, 9, 3, 3)/10` in this file's
  coordinates. **Every forced pair lies in `3Λ`, as `F = 3Λ` requires.** Some pairs in `3Λ` are separable inside these small
  graphs (2 and 4 of them); that is expected, because a small graph does not force everything the lattice forces.

## Check 3′ — the forcings without any solver

`fs73v_q11.py --exhaustive` enumerates **every** proper 3-colouring with `c(0) = 0`, by plain backtracking in breadth-first
order from 0. It counts all of them and those with `c(3u) ≠ c(0)`.

| forcer | colourings with `c(0) = 0` | with `c(3u) ≠ c(0)` | CPU s |
|---|---|---|---|
| u₁ | 122,900 | **0** | 2.5 |
| u₂ | 1,814,256 | **0** | 47.0 |

**The enumerator's own negative control.** For the u₁ graph, the enumerator was re-run 50 times, each time with one vertex other
than `0` and `3u₁` deleted. **All 50 runs report colourings separating `0` from `3u₁`.** So the enumerator can say "not forced",
and FS-58's claim that this forcer is 1-minimal (no single vertex removable) is confirmed along the way. The run took about 4
minutes on one core.

## Check 4 — the point group and the spans

The point group is computed, not assumed: every ℤ-linear bijection of Λ₁₀ that maps U onto U. The search fixes images of the
basis `(1, i, u₂, i·u₂)` in U, staged through the 12 rational-coordinate unit vectors `(±1, 0)`, `(0, ±1)`, `(±3/5, ±4/5)` and
`(±4/5, ±3/5)`, in exact rational arithmetic. **Order 16**, as expected for multiplication by `i` combined with
`Gal(ℚ(i, √11)/ℚ)`.

| vectors | orbit size | span rank | index in Λ | equals `3Λ` |
|---|---|---|---|---|
| orbit of `3u₁` | 8 | 2 | — | no; inside `3Λ` |
| orbit of `3u₂` | 16 | 4 | **729 = 81 · 9** (so index 9 in `3Λ`) | no; inside `3Λ` |
| both | 24 | 4 | **81** | **yes** |

So, unlike K (where `v`'s orbit alone spans `8Λ`, `verify-P1d.md` Doubt 1), **both forcers are needed here**. `3u₂` alone gives
index 9, and `3u₁` supplies the rest.

## Check 5 — the upper half, `P ⊆ 3Λ`

**Argument (hand).**
1. Given the refusals and check 4, `3Λ ⊆ F ⊆ P`, and `P` is stable under the point group `G`.
2. `P/3Λ` is a subspace of `Λ/3Λ ≅ 𝔽₃⁴`. If it is nonzero, it contains a whole line `{0, x, −x}`.
3. A `G`-image of that line is the line of some orbit representative `r`, so `r ∈ P` (P is `G`-stable and a union of cosets
   of `3Λ`).
4. So `P = 3Λ` once each orbit representative is separated from 0 by a periodic colouring.

**Computation.**
- U reduces to 8 classes modulo `3Λ`, none zero, so there are no loops. The quotient `Cay(Λ/3Λ, U mod 3Λ)` has 81 vertices and
  324 edges.
- The 40 lines fall into **10 orbits**, of sizes 2, 2, 4, 8, 2, 4, 4, 8, 4, 2.
- For each representative, Glucose found a 3-colouring of the quotient with `c(0) = 0` and `c(r) = 1`. Every one was verified
  with 0 monochromatic quotient edges, and pulled back to the 2,401 lattice points with basis coefficients in `[−3, 3]`:
  7,156 edges, 0 monochromatic.
- Two representatives are themselves unit classes, adjacent to 0, so any colouring separates them.
- **All ten colourings are affine**: `c(v) − c(0)` is an 𝔽₃-linear function of the class. This is consistent with G61's
  observation that periodic 3-colourings of 3-integral pools are affine.

**Hence `F = P = 3Λ`.** B's finding `P_N = 3Λ` at `N = 6, 9, 12` is consistent with this. My check needs only `N = 3`.

## Doubts, however small

1. **None about the claim.** Every leg passes, and the forcings stand on three independent instruments: Glucose, drat-trim, and
   an exhaustive enumeration that uses no solver.
2. *A note on the brief:* "u₂'s orbit alone spans rank 4, of index 9 in 3Λ" is right. The contrast with K is worth recording:
   at K one vector's orbit carried `8Λ`; here both forcers are load-bearing.
3. *About my own process:* the exhaustive checks ran outside the shared lock: the u₂ enumeration (47 s) and the planted control
   (about 4 minutes). Each is a single-core Python process under 100 MB, not a heavy job, but the planted control ran past the
   ~2-minute guideline.

## Reproduction

```
python3 tools/fs73v_q11.py                  # checks 1–5 (2.3 s; needs the Glucose and drat-trim builds of verify-P1d.md)
python3 tools/fs73v_q11.py --exhaustive     # check 3′ (50 s)
```
