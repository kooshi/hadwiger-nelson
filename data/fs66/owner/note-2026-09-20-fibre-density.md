# FS-66, owner's note (2026-09-20): a level-ONE necessary condition for colouring ANY level of the tower

*Written by the product owner while the planner was at the prior-art gate. Status: the inequality is a hand derivation, checked
numerically at the spectra it uses; the optimisation results are local-search numerics — **nulls at a budget, never refusals** —
but their controls come out right and the landscape is rigid. Offered to the planner as a candidate refusal-side instrument; two
corrections to my own brief are at the end. Scripts and outputs beside this file.*

## 1. The spectrum of the tower, by character depth [hand; checked by FFT at (3; 2,3,4), (7; 2,3), (11; 2)]

`G_k = UD(ℤ/p^k, 2) = Cay((ℤ/p^k)², S_k)`, `p ≡ 3 (mod 4)`, degree `p^{k−1}(p+1)`. A character has **depth** `j` if it factors through
level `j` and no lower. Depth ≤ 1 characters are pulled back from level one and carry eigenvalue `p^{k−1}·λ₁`. For a unit `w` at
level two, writing `S₂ = {s̃(1 + p·i·a)}`: the inner sum over `a ∈ 𝔽_p` vanishes unless `w̄s̄` is real mod `p`, which needs `N(w)` a
nonzero square and then picks `s̄ = ±w/√N(w)`, so

> depth-2 eigenvalues are `0` (non-square norm) or `2p·cos(2πm/p²)` — all in `[−2p, 2p]`; at level `k`, depth `j ≥ 2` eigenvalues are
> bounded by `2p^{k−j/2} ≤ 2p^{k−1}` in absolute value, with depth 2 extremal (`depth-spectrum.out`: at 7, level 3, depth 2 reads
> `[−97.80, 97.20]` against `2p² = 98`; depth 3 reads `±37.04 = 2p^{3/2}`).

So `λ_min(G_k) = p^{k−1}λ_min(G₁)` (G54's constant Hoffman ratio, re-derived) **and the whole part of `G_k` orthogonal to level one is
an expander with `|λ| ≤ 2p^{k−1}` against degree `p^{k−1}(p+1)`.** Define `c = c(p) = −λ_min(depth 2 at level two)/p`; `c < 2`
(1.999326 at 11; 1.995891 at 7), and the same `c` serves every level `k ≥ 2`.

## 2. The fibre-density inequality [hand]

Let `I` be an independent set of `G_k` and `φ(x) ∈ [0,1]` the fraction of the fibre over the level-one vertex `x` that `I` occupies.
Split `1_I = Pφ + g` (fibre-constant part plus the rest); `A_k` preserves both parts, `⟨Pφ, A_k Pφ⟩ = p^{3(k−1)}⟨φ, A₁φ⟩`,
`‖g‖² = p^{2(k−1)} Σφ(1−φ)` and `⟨g, A_k g⟩ ≥ −c·p^{k−1}‖g‖²`. Independence is `⟨1_I, A_k 1_I⟩ = 0`, hence

> **`⟨φ, A₁φ⟩ ≤ c · Σ_x φ(x)(1 − φ(x))`** — for every independent set of every level `k ≥ 2`.

Pure `φ` (0/1-valued) satisfies it iff it is an independent set of `G₁`. For an `m`-colouring of `G_k`, the class densities form a
row-stochastic `Φ ∈ ℝ^{p² × m}`, and summing over classes:

> **`Q(Φ) := tr(Φᵀ(A₁ + cI)Φ) ≤ c·p²`** (the *budget*). A proper `m`-colouring of `G₁`, pulled back, meets it with equality.
> **If `min_Φ Q > c·p²` over row-stochastic `Φ`, then NO level of the `p`-adic tower is `m`-colourable** — a 484-variable
> non-convex quadratic programme at `(11, 4)` decides the whole tower in the negative, if its minimum can be certified.

It is necessary, never sufficient (an isolated level-one edge supports `φ`-weight 4/3 under it, where the truth is 1), so a
satisfiable instance says nothing.

## 3. What the numerics say (`fuzzy-*.out`; block-coordinate descent with exact row best responses, random and min-conflict starts)

| `(p, m)` | known truth | best `Q`/budget found | reading |
|---|---|---|---|
| (7, 3) | level one needs 4; every level needs 4 (row 73's graph maps in) | **1.1911** — min = 5th percentile = median over 60 starts | not satisfied — a control where refusal IS the truth (the condition is only necessary, so it could have been satisfiable; it was not) |
| (7, 4) | 4-colourable | 0.8813 | satisfiable, as it must be |
| (11, 5) | 5-colourable | 0.8930 | satisfiable, as it must be |
| **(11, 4)** | **the pilot question** | **1.1115 — min = 5th percentile = median over 300 starts** | **never satisfied: a candidate refusal of four colours at every level of the 11-adic tower** |

The best pure 4-colouring of `UD(𝔽₁₁,2)` seen has 18 monochromatic edges (`Q`/budget 1.1488); fuzziness buys back only a third of
that. The minimiser is structured: 79 pure rows, 42 two-colour rows in orbits of 6 and 3, class weights 30.40, 30.40, 30.40, 29.80.
**At 19 and 23** (`fuzzy-19-23.out`; fewer starts, and the min-conflict seeds are poor there — 103 monochromatic edges at (19, 5), where a proper colouring exists — so these are weaker nulls): (19, 4) **1.2763**, min = median over 40 starts; (19, 5) 0.9549, satisfiable as it must be; **(23, 5) 1.4656** over 30 starts — the case that bears on ℚ(√167), whose usable planes below the spectral refusals (59 up, where the constant Hoffman ratio already carries the refusal to every level, G54) are 23 and 43 only; (23, 6) 1.1780; (23, 7) 0.9893 and (23, 8) 0.8627, satisfiable — 8 as it must be, 7 saying nothing.

**What would make it a theorem: a certified lower bound on a non-convex QP over a product of simplices.** Any certificate must in
particular prove `χ(UD(𝔽₁₁,2)) > 4`, which `ϑ`/`ϑ′`-strength relaxations cannot (Hoffman allows 34.5 > 30.25) and the triple-level
relaxation can (29.18). So the symmetric first-level (doubly non-negative) relaxation is useless here — by hand, it collapses to
`12τ₁ + cτ₀ ≥ −2`, which the proper-colouring point saturates — and the honest candidates are: (a) a second-level moment/SOS
relaxation with the symmetry of `Aut(G₁) × S₄` (order 69,696) divided out — the FS-50 machinery pointed at a different polynomial;
(b) the KKT reformulation as a mixed-integer LINEAR programme (a QP's minimum is attained at a KKT point, where `Q` is linear in the
multipliers; one binary per (vertex, colour) for complementarity) with the symmetry broken; (c) a human proof from the minimiser's
structure. None is priced.

## 4. Two corrections to my own brief

* **`ϑ′(G₂)` is pinned and not worth running.** A feasible point of level one's Delsarte LP lifts to level two, so `ϑ′(G₂)/p⁴ ≥
  ϑ′(G₁)/p²`, which equals the Hoffman ratio (measured on every plane, row 68); and `ϑ′ ≤ ϑ =` Hoffman by arc-transitivity. Equality.
  The same lifting shows the triple-level value at level two is `≥ 121 × 29.18 = 3,530` (ratio 0.2411), as the brief said.
* **The "unions of parallel lines" family is dead by a short argument, recorded so nobody re-derives it.** Only the projection of a
  fibre set `A_x ⊆ 𝔽_{p²}` along `s̄·i` matters to an edge in direction `s̄` (six direction classes at 11). A union of `m` parallel lines
  is a genuine gain on its own direction's `p`-cycle (`x + j·s̄` is an 11-cycle; integer weights with adjacent sums ≤ `p` reach
  `(p²−1)/2p = 60/11` against 5 for a 0/1 set) but projects fully in the other five directions, so every vertex of the cycle's
  line silences its ten other neighbours: a used line empties six of its eleven parallels entirely (checked: the lines at offsets
  ±1, ±3, ±5 are each wholly adjacent to it), at most three parallels are mutually free (offsets `{0, 2, 4}`), and the family tops out
  near 16–27 of 121 against level one's 28. A rise, if there is one, needs fibre sets with small projections in several directions
  at once — and the inequality of §2 says how little room that leaves.

## 5. Level two is a union of complete bipartite blocks, and that gives a SAT encoding a tenth the size [checked; `fs66_owner_biclique.py`]

Between the fibres over two adjacent level-one points `x` and `y = x + s̄`, the graph `UD(ℤ/p², 2)` is **`p` disjoint copies of
`K_{p,p}`**: the second digits `u ∈ 𝔽_p²` of a fibre fall into `p` lines of direction `s̄·i` (indexed by the `s̄`-component
`s₀a + s₁b mod p`), and line `t` over `x` is completely joined to exactly one line `t′ = t + γ(x, s̄)` over `y` and to nothing else
(checked on 32 level-one edges at 7 and 48 at 11, 0 failures). So the 966,306 edges at 11 are 726 × 11 = 7,986 bicliques `K_{11,11}`.

**The encoding** (`fs66_owner_biclique_cnf.py P K out.cnf`): beside the colour variables `c[v, a]`, one *line variable*
`z[x, d, t, a]` per level-one point, direction class `d` (six at 11), line and colour, with `c[v, a] → z[x(v), d, t(v, d), a]`, and
ONE conflict clause `¬z[x, d, t, a] ∨ ¬z[y, d, t′, a]` per biclique and colour in place of 121. At `(11, 4)`: 90,508 variables and
**397,972 clauses against 3.9 million**, and unit propagation now reasons about whole lines. A triangle through the origin is
pinned (`ω = 3` at 11), which leaves no colour symmetry at four colours.

**Controls, run and passed:** `(7, 3)` UNSATISFIABLE — the true answer; `(7, 4)` SATISFIABLE, decoded and **verified by
`tools/fs66_owner_verify.py`** (class sizes 583, 582, 615, 621 — not multiples of 49, so a colouring the solver was never handed
and that is not pulled back from level one). Both in seconds, single-threaded CaDiCaL. **The probes at 11** (single-threaded CaDiCaL from the toolchain, this encoder):

| ask | pin | verdict | cost |
|---|---|---|---|
| `(11, 4)` — the pilot | triangle `(0,0), (0,1), (47,61)` | **UNSATISFIABLE** | 0.97 s, 1,279 conflicts |
| `(11, 4)` | **none at all** | **UNSATISFIABLE** | 56 s, 83,102 conflicts — so the refusal is no artefact of a pin |
| `(11, 5)` — the control | triangle | SATISFIABLE in 775 s; decoded and **VERIFIED** on all 966,306 edges by `tools/fs66_owner_verify.py`; class sizes 2683, 2904, 2787, 3000, 3267 — not pulled back, never handed over | |

The planner reached the same refusal first and independently (plain encoding, 1.7 s; four solvers on the bare core; `data/fs66/planner/`), and caught that my first `(11, 4)` probe had never run: `cd X && (A) & (B) &` put the second subshell in the repository root, where its input did not exist, and it 'finished' in 0 s saying nothing — this file's own failure mode, a probe that reports nothing because it could not run. **`χ(UD(ℤ/121, 2)) = 5` on the solvers' word: the ceiling does not drop at level two of 11.** Not certified, not kernel; that is the plan's phase 1.

**A consequence for every larger ask [hand]:** a resolution refutation of level two projects onto level one — substitute `c[v, a] ↦ c[x(v), a]` and every line variable `z[x, ·, ·, a] ↦ c[x, a]`; clauses go to clauses or to tautologies — so **level two's shortest refutation is at least as long as level one's.** Five colours at 23 was never decided by CDCL at level one (G56), so `UD(ℤ/529, 2)` at five cannot be refused by CDCL unless level one is first; there the all-levels inequality of §2 is the only refusal-side instrument in sight.
