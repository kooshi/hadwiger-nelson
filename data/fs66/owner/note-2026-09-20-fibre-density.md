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

## 6. The single-class form: 121 variables, and numerically the independence ratio never rises [numerics; `alpha-fuzzy.out`]

Take ONE colour class: **`B₁(p) := max Σφ` over `φ ∈ [0,1]^{p²}` subject to `φᵀ(A₁ + cI)φ ≤ c·Σφ`** bounds `α(G_k)/p^{2(k−1)}` at every
level `k ≥ 2`, and `m·B₁ < p²` refuses `m` colours at every level. (The planner and I reached this form independently within the
hour, with the same numbers.) SLSQP, random and greedy-independent-set starts:

| `p` | best `Σφ` found | level one's `α` | needed to refuse | starts |
|---|---|---|---|---|
| 7 | **14.0000**, pure | 14 | < 16.33 (three colours) | 30 |
| 11 | **28.0000**, pure; fractional local maxima at 26.856, 26.999, 27.999 | 28 | **< 30.25 (four colours): 8 % of slack** | 200 |
| 19 | **76.0000**, pure | best known 76 (`α ∈ [76, 80]`) | < 90.25 (four): 19 % | 12 |
| 23 | 87.5111, with 16 fractional entries (0.889, 0.8, 0.667 — edge-like pairs) | best known 87 (`α ≤ 105`) | < 105.8 (five): 17 % | 8 |

If `B₁ = α(G₁)` were a theorem the independence ratio — hence the fractional chromatic number — would be **constant up the whole
tower**, the cleanest negative answer FS-66 could have. It is not a theorem about graphs in general (an isolated edge carries 4/3, a
triangle `3c/(2+c) ≈ 1.4997`), and at 11 it survives by a hair: "25 full vertices + two half-weight triangles" reaches 27.9995 because
`c` is just below 2. A pure maximum independent set is a strict local maximum exactly when every outside vertex has two neighbours in it.

**Linear cuts valid at every level.** If a subgraph `K` of level one *lifts* to level `k` (a section that is a homomorphism), its
translates by the kernel partition the fibres over `K` into disjoint copies of `K`, so `Σ_{x∈K} φ(x) ≤ α(K)`. Edges lift, triangles lift
(Hensel), odd cycles using two directions lift (the closing condition is a surjective linear map in one free parameter per edge):
`φ_x + φ_y ≤ 1`, `φ_x + φ_y + φ_z ≤ 1`, `Σ_C φ ≤ (ℓ−1)/2`. They cut off exactly the near-ties above (and 23's fractional pairs). The
single-direction `p`-cycles do not lift (holonomy 1) and are where a genuine level-two gain lives. `G₁` itself does not lift (G45),
which is why this stays a relaxation.

**What a certificate must do.** Prove `B₁(11) < 30.25`, which includes proving `α(UD(𝔽₁₁,2)) ≤ 30`. No first-level relaxation can
(Shor + RLT, symmetrised, contains `ϑ′ =` Hoffman `= 34.55`); the candidates are a second-level moment relaxation with `Aut(G₁)` (order
2,904) divided out — which cannot read below the triple-level 29.18 — or exact spatial branch-and-bound on 121 variables, where the
8 % is real slack. At `(23, 5)` no certifier we own can land it (it would have to prove `α(UD(𝔽₂₃,2)) < 105.8`, which took the level-3
relaxation with 0.4 to spare): **the ℚ(√167) row stays numerics-only in this milestone.** Side effect worth keeping: this continuous
relaxation found a 76-set at 19 in 12 starts, the size FS-62's local search needed 521,874 restarts to plateau at.

## 7. The owner's check of the plan's §S3 (Bardestani–Mallahi-Karai's Question 1) — read first-hand, 2026-09-20 [hand]

Read in the held PDF (`~/source/library/pdf/arXiv-1507.05300-…`, arXiv v4): **Question 1, p. 2**, verbatim — *"(The p–adic
Hadwiger-Nelson problem). Is it true that there exists a universal constant B (independent of p) such that χ_Bor(QG_{𝒬_p}) ≤ B,
holds as p ranges over all primes of the form 4k + 3?"*, after the sentence that their proof gives `χ_Bor = O(p²)`; and **Theorem
2.5, p. 5** (credited to Bachoc–DeCorte–de Oliveira Filho–Vallentin): for `F = ℝ` or `ℚ_p`, `S ⊂ Fⁿ` bounded, symmetric, Borel,
origin not in its closure, and any symmetric finite Borel measure `μ` supported in `S`, `1 − sup μ̂ / inf μ̂ ≤ χ_Bor(Cay(Fⁿ, S))`,
with `μ̂(u) = ∫ ψ̄(x·u) dμ(x)` and `ψ` the Tate character (kernel `ℤ_p`), p. 4–5. Sections read: §1, §2.1 (pp. 1–5). Not read: §3–4.

**The argument stands on my reading, and it does not need `[MMST1998]`.** For `p ≡ 3 (mod 4)` the circle `S = {a² + b² = 1}` lies
in `ℤ_p²` (anisotropy), is compact, symmetric, and misses the origin; `μ` = Haar probability measure of the compact group `S`
(symmetric because `−1 ∈ S`). Reduction `S → S_k` is a surjective homomorphism (Hensel), so Haar pushes forward to the uniform
measure and, for `u` of exact level `k`, `μ̂(u) = λ_{p^k u}(G_k)/|S_k|`. `sup μ̂ = μ̂(0) = 1`. Level one: `λ_min(G₁) < 0` and
`|λ_min(G₁)| ≤ 2√p` (Weil; the eigenvalues are Kloosterman sums, G44). **Level `k ≥ 2`, elementary:** the fibre of `S_k → S_{k−1}` over
`s` is `{s(1 + p^{k−1}·i·a) : a ∈ 𝔽_p}`, and summing the character over `a` gives `0` unless `s̄ ∈ 𝔽_p·ū′` (`u′ = p^k u`, a unit
mod `p`), which holds for at most two `s̄ ∈ S₁`; so at most `2p^{k−1}` of the `p^{k−1}(p+1)` terms survive and **`|μ̂(u)| ≤ 2/(p+1)`
at every level `k ≥ 2`** (the FFTs in `depth-spectrum.out` show it is attained at depth 2). Hence `inf μ̂ ≥ −max(2√p, 2)/(p+1)` and

> **`χ_Bor(QG_{ℚ_p}) ≥ 1 + (p+1)/(2√p) > √p/2`** for every `p ≡ 3 (mod 4)`: no universal `B` exists, and Question 1's answer is no.
> With `χ_Bor ≤ χ_clopen ≤ χ(UD(𝔽_p, 2))` (plan §S2) the Borel chromatic number of the anisotropic `p`-adic plane grows like `√p` up
> to the unknown gap between Hoffman and `χ` at level one. It bounds the **Borel** number only — nothing about the plain `χ(ℚ_p²)`.

The same elementary step gives my §1's bound with `c = 2` at every level without citing anyone — so **the fibre-density inequality
(§2) and the single-class problem (§6) rest on nothing unread** (the sharper `c < 2` is the FFT's, per prime). Prediction P8 of the
plan: scored *met* on the hypotheses and the normalisation; what is NOT checked is whether someone has already said this in print
(the planner found no citing work that does; the close should re-ask zbMATH for the authors' later papers before anything is
written into `CLOSED-QUESTIONS.md`).

## 8. Prior-art re-check for the Borel clause (zbMATH Open API, 2026-09-21) — a negative, which measures its queries

Asked because the certificate, once `CERTIFIED`, gives **`χ_Bor(ℚ₇²) = 4` and `χ_Bor(ℚ₁₁²) = 5`** (phase-2 plan §ST, owner's addendum)
and, with §7, answers `[BardestaniMallahiKarai2017]`'s Question 1. Queries, each through
`api.zbmath.org/v1/document/_search`: the complete author listings of **Mallahi-Karai** (31 entries) and **Bardestani** (14) — after
2017 they return to chromatic numbers only in the two papers the first planner read (`…2018`, structured Cayley graphs;
`…2020`, polynomial configurations over local fields), never to the anisotropic `p`-adic plane; `ab:"Borel chromatic number"` (31
entries: descriptive set theory throughout; the only `p`-adic items are those same two); `ab:"chromatic number" & ab:"p-adic"` (3:
the 2020 paper, a proceedings volume, and **Kang–Maharaj, *Distance graphs from p-adic norms*, Integers 10 (2010)** — by its title a
different object, distance graphs on the integers under a `p`-adic norm; seen in a listing only, owed a bibliography row marked so);
`ti:"Hadwiger-Nelson" & py:2015-2026` (8: nothing `p`-adic beyond Madore and BMK). **Found: no exact value, and no lower bound, for
the Borel or the plain chromatic number of an anisotropic `p`-adic plane.** Not searched: MathSciNet, the citing lists of BMK 2017 in
OpenAlex / Semantic Scholar (the first planner walked them: nothing addresses Question 1), Russian-language literature.
