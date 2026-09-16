# FS-54 D4 — a relaxation strong enough to refuse five colours at 27: derivation, sizes, controls, price

*Written 2026-09-16 by the D4 subagent for the FS-54 milestone (`plans/FS54-twenty-seven.md` §D4). Everything
numeric here is re-derived by `tools/fs54_d4_quad.py` (docstring has the subcommands); records under `data/fs54/d4/`.
**Every value below is a floating-point READING of a relaxation, never a bound**: a bound needs an exact rational
certificate checked by a stranger's checker, and none is produced here (§3 says what one would be).*

**The question.** `G = UD(𝔽₂₇,2)`, 729 points. Five colours need `α ≥ 146`. The triple-level relaxation (FS-50's
certificate programme) is converged at **147.578**, two integers short. D4 asks for the next level, derived,
sized exactly, controlled at small planes, and priced on graphics card A — and stops there.

---

## §PA What was read (2026-09-16)

All five are now in `~/source/library/pdf/` (arXiv copies); the sections named were read, not skimmed.

| key (proposed) | work | read | what it gave this page |
|---|---|---|---|
| `[GMS2012]` | D. C. Gijswijt, H. D. Mittelmann, A. Schrijver, *Semidefinite code bounds based on quadruple distances*, IEEE Trans. Inf. Theory 58 (2012) 2697–2705; arXiv:1005.4959 | §1–2 (the bound `A_k(n,d)`, Prop. 1, the remark that `A(20,8)=256` needs only `S = ∅` and `|S| = 4`), Table 1 | the level-4 moment matrices `M_S(x)`, `S ∈ N_4`, indexed by `N(S) = {S′ ⊇ S : |S| + 2|S′∖S| ≤ 4}`; that the programme is solved by block-diagonalising under the stabiliser of each `S`; that their gains over the triple bound are **0.3–3 %** on binary codes (e.g. `A(19,6)`: 1280 → 1237) |
| `[LPS2017]` | B. Litjens, S. Polak, A. Schrijver, *Semidefinite bounds for nonbinary codes based on quadruples*, Des. Codes Cryptogr. 84 (2017); arXiv:1602.02531 | §1, §1.1 | the **pure level-2 Lasserre** form: only the `C₂ × C₂` moment matrix `x(C ∪ C′)` PSD plus `x ≥ 0`; the remark that adding the localising `S(D)` matrices to that moment matrix "might be superfluous" for codes. **Not tested here**: this page uses the localising family *without* the `C₂ × C₂` matrix (§6 measures what that alone does), so it neither confirms nor refutes the remark; the moment matrix is the second candidate of §8 |
| `[GLV2009]` | N. Gvozdenović, M. Laurent, F. Vallentin, *Block-diagonal semidefinite programming hierarchies for 0/1 programming*, Oper. Res. Lett. 37 (2009) 27–31; arXiv:0712.3079 | all | **the programme used here.** `L_t(G)`: for every `T` of size `t−1`, `M(T;y) ⪰ 0`, which by their Lemma 2.2 is `A(S,T)(y) = Σ_{S⊆S′⊆T} (−1)^{|S′∖S|} A_{S′}(y) ⪰ 0` for all `S ⊆ T` — matrices of order `n+1`. `L_3` is exactly "localise at a pair, every sign pattern". Their Table 2 (Paley graphs, 61 ≤ q ≤ 809): `L_3` sits **8–22 % below** `L_2`, and nonnegativity `y ≥ 0` changes only decimals |
| `[dLMOV2021]` | D. de Laat, F. C. Machado, F. M. de Oliveira Filho, F. Vallentin, *k-point semidefinite programming bounds for equiangular lines*, Math. Program. 194 (2022) 533–567; arXiv:1812.06045 | §1, §2 (derivation of `Δ_k`), §3.1 | a weaker cousin, `M_Q(ν) ⪰ 0` for `Q ∈ I_{k−2}` with no complement patterns; the "remove ∅ and renormalise" move, which is Schrijver's normalisation |
| `[BGSV2012]` | C. Bachoc, D. C. Gijswijt, A. Schrijver, F. Vallentin, *Invariant semidefinite programs*, in *Handbook on Semidefinite, Conic and Polynomial Optimization* (2012); arXiv:1007.2905 | fetched; not read beyond the contents | held for the block-diagonalisation vocabulary |

**Not found:** any level-4 (quadruple) bound computed on a finite Euclidean graph, or on any Cayley graph over
`𝔽_p^n` other than the binary and `q`-ary Hamming schemes; the searches were in the discipline's words (*quadruple
bound*, *Lasserre hierarchy stable set Cayley graph*, *block-diagonal hierarchy Paley*), not ours. `[Schrijver2005]`
and `[Laurent2007]` (*Strengthened semidefinite programming bounds for codes*, Math. Program. 109) remain listing-only.

---

## §1 The matrices a set carries

Fix `V = 𝔽₂₇²` (or `𝔽_q²`, `q ≡ 3 mod 4`), adjacency `Q(u − v) = 1`. Let `S` be a nonempty independent set,
`s = |S|`. For a finite set `T ⊆ V` put

    N(T) = #{ z ∈ V : z + T ⊆ S }.

For `z ∈ V` let `ξ^z ∈ {0,1}^V`, `ξ^z[u] = [z + u ∈ S]`. For `d ∈ V` and a **sign pattern** `σ = (σ₀, σ_d)`, write
`[P]⁺ = [P]` and `[P]⁻ = 1 − [P]`, and

    A^σ_d = (1/s) · Σ_{z ∈ V}  [z ∈ S]^{σ₀} · [z + d ∈ S]^{σ_d} · ξ^z (ξ^z)ᵀ .

| | fact | why |
|---|---|---|
| Q1 | `A^σ_d ⪰ 0` for every `d` and `σ` | a sum of `xxᵀ` with weights 0 or 1 |
| Q2 | `A^{++}_d[u,v] = N({0,d,u,v})/s` | `[z∈S][z+d∈S][z+u∈S][z+v∈S] = [z + {0,d,u,v} ⊆ S]`; `{0,d,u,v}` is a **set** and may have fewer than four points |
| Q3 | `A^{+−}_d[u,v] = (N({0,u,v}) − N({0,d,u,v}))/s`, `A^{−−}_d[u,v] = (N({u,v}) − N({0,u,v}) − N({d,u,v}) + N({0,d,u,v}))/s` | expand `1 − [·]` in Q2's product |
| Q4 | `N(T) = 0` if `T` contains two adjacent points; `N({p}) = s` | `z + T ⊆ S` would put an edge in `S`; a point lies in `S` exactly `s` times over the translates |
| Q5 | `N(T + t) = N(T)` | substitute `z ↦ z − t` |
| Q6 | `Σ_u N({0,u}) = s²` | `Σ_u #{z ∈ S : z + u ∈ S} = Σ_{z∈S} s` — FS-50's P7, the fact that makes the objective linear |

The one-point matrices of the triple level are the case "no `d`": `Y = (1/s)Σ_{z∈S} ξξᵀ` (entries `N({0,u,v})/s`) and
`M − Y = (1/s)Σ_{z∉S} ξξᵀ` (entries `(N({u,v}) − N({0,u,v}))/s`). They are **implied** by the pair matrices, since
`Y = A^{++}_d + A^{+−}_d` and `M − Y = A^{−+}_d + A^{−−}_d` for any `d`; they are kept in the programme because they cost
four blocks of ~180. The pattern `−+` at `d` is `+−` at `−d` relabelled by `u ↦ u − d` (Q5), so it is omitted. At a unit
vector `d`, `A^{++}_d = 0` (Q4) and `A^{+−}_d = Y`, so only `−−` survives there. FS-50's `le_diag` rows (`Y[u,v] ≤
Y[u,u]`) are the diagonal entries of `A^{+−}_u`.

## §2 Averaging over the symmetries, and the programme

`Aut(G) = V ⋊ G₀`, `G₀ = O(2, 𝔽₂₇) ⋊ Gal(𝔽₂₇/𝔽₃)`, `|G₀| = 168`, `|Aut| = 122,472` (nauty; the tool rebuilds `G₀` from
the rotations, the reflection and the Frobenius and asserts each of the 168 elements fixes 0, is additive and
preserves the unit set). For `g ∈ Aut`, `N_{gS}(gT) = N_S(T)` (`g(z + T) = g₀z + g(T)` and `z ↦ g₀z` is a bijection).
Define the average over the `|Aut|` independent sets `gS`, all of size `s`:

    ȳ(T) = (1/|Aut|) Σ_{g ∈ Aut} N_{gS}(T) / s .

Every entry in Q2–Q3 is linear in `N/s` with coefficients that do not depend on `S`, so **averaging the matrices
`A^σ_d` of the sets `gS` entrywise gives the matrix with `N/s` replaced by `ȳ`, and an average of PSD matrices is
PSD.** No relabelling argument is needed for that step. Then:

* `ȳ(hT) = ȳ(T)` for `h ∈ Aut`, so `ȳ` is a function `y_{[T]}` of the **Aut-orbit** of `T`;
* `y_{[point]} = 1`; `y_{[T]} = 0` if `T` is not independent (Q4);
* `Σ_u y_{[{0,u}]} = s` (Q6, averaged);
* for `g₀ ∈ G₀`, `A^σ_{g₀d}(y)[g₀u, g₀v] = A^σ_d(y)[u,v]` because every set in Q2–Q3 is moved by `g₀` as a whole, so
  **one `d` per `G₀`-orbit of `V ∖ {0}` suffices**: 10 classes at 27 (sizes 84 ×8 and 28 ×2; one is the unit circle).

> **The programme L₃.** Maximise `Σ_u y_{[{0,u}]}` over real `y` indexed by the Aut-orbits of independent sets of size
> 2, 3, 4, with `y_{[point]} = 1` and `y_{[non-independent]} = 0` substituted, subject to `y ≥ 0`, `Y(y) ⪰ 0`,
> `(M − Y)(y) ⪰ 0`, and `A^{++}_d(y), A^{+−}_d(y), A^{−−}_d(y) ⪰ 0` for one `d` in each `G₀`-orbit.
>
> **Soundness.** Every nonempty independent set `S` yields the feasible point `ȳ` with objective `s`. So
> `α ≤ value(L₃)`. ∎

It is `[GLV2009]`'s `L_3(G)` with two changes, each recorded: (i) **Schrijver's normalisation** — divide by `s`
rather than fixing `y_∅ = 1` — which makes Q6 an *equality* and the objective linear, and drops the all-ones
coordinate (`GLV`'s index `0`); that coordinate carries `|V|/s`, which is not linear in `y`, and can be restored for
sets with `s ≥ s₀` by writing `|V|/s₀` in its corner (a larger diagonal keeps PSD) — the tool's `--border --s0`, a
programme that refuses `s ≥ s₀` rather than bounding `α` in general; (ii) the complement pattern `−+` is dropped as a
relabelling of `+−`.

**The implementation's soundness control is the programme's own statement**: `checkset` computes `ȳ` from a real
set *exactly* — `y_{[T]} = #{T′ ⊆ S : T′ ∈ [T]} · |Stab_Aut(T)| / (s · |G₀|)`, which is `(1/(s|O|))Σ_{T∈O} N(T)` because
each `T′ ⊆ S` in `O` arises from exactly one `(T, z)` per `z ∈ V` — assembles every block from it, and asserts the
objective equals `s` and every block is PSD. Four planted faults, each chosen so that its failure is *reachable*,
must make a block indefinite (§6.1).

## §3 What a certificate would be (not produced here), and the evaluation that stands in for one

Exactly FS-50's shape, with one more valid row. **Q7:** `N(T) ≤ N({t}) = s` for `t ∈ T`, so `0 ≤ y_{[T]} ≤ 1`. A
certificate is a rational `N`, rational PSD matrices `Z^σ_d` (one per pattern and class, in any block presentation
`Σ_b U_b Z_b U_bᵀ`), and nonnegative rationals `λ_O`, `μ_O`, such that, **identically in `y`** (coefficient by
coefficient over the 77,238 orbit variables, and in the constant term):

    N − Σ_u y_{[{0,u}]}  =  Σ_{d,σ} ⟨Z^σ_d, A^σ_d(y)⟩  +  Σ_O λ_O y_O  +  Σ_O μ_O (1 − y_O) .              (★)

At `y = ȳ(S)` every term on the right is `≥ 0` and the left is `N − s`, so `s ≤ N`. **Given any PSD `Z` the rest is
determined**: with `a_O = (Σ⟨Z, A(y)⟩ + objective)`'s coefficient of `y_O`, take `μ_O = max(0, a_O)`, `λ_O = max(0, −a_O)`,
and `N = 1 + (constant part of Σ⟨Z, A⟩) + Σ_O μ_O`. So rounding can only cost `Σ μ`, never soundness — the Q7 rows are
what let an *infeasible* iterate be turned into a valid identity (FS-50 needed its `le_diag` structure for the same job).

`certificate_shaped_value` in the tool evaluates exactly this `N` **in floating point** on a projected iterate. It is a
reading, but a bound-shaped one: its only gap from a bound is float arithmetic and the rational rounding of `Z`. Its own
control (§6.1): at the verified 117-set, `N − 117` equals `⟨Z, blocks(ȳ_S)⟩ + λ·ȳ_S + μ·(1 − ȳ_S)` to `2.7·10⁻¹³`, every
term nonnegative, and a plant dropping `μ` breaks the identity (difference `4.2·10⁻³`, fired).

**What an exact certificate at 27 would weigh.** The projected dual at 8,000 iterations is low-rank: `Σ_b rank_b · m_b²
= 1.41·10⁸`, **10 % of `Σ m³`**, many blocks of rank 0 or 1 (`data/fs54/d4/evaluate-q27-admm8000.json`). Rational Gram factors
`Z_b = B_bᵀB_b` would therefore hold roughly half a million integers, and a standard-library checker's dominant cost —
`⟨B_bᵀB_b, A_b(y)⟩` per orbit — is about `10⁸` integer products plus a pure-Python rebuild of the 2.9 M canonical forms
(the census of §5): tens of minutes, not days. The blocks are real with `±1/√|Stab|` bases, so no cosine rounding.

## §4 Symmetry reduction — how the matrices are cut into blocks

Not on the trust surface of a certificate (§3), but it decides the price. Each matrix is invariant under a small
group acting on its index set `V`:

| matrix | group | why |
|---|---|---|
| `Y`, `M − Y` | `{±I, ±ρ}` (`ρ(x,y) = (x,−y)`) — a Klein subgroup of `G₀` | `y` is `G₀`-invariant |
| `A^{++}_d`, `A^{−−}_d` | `H_d = {id, s_d, τ_d, s_dτ_d}`, `s_d` the reflection of `O(2)` fixing `d`, `τ_d(z) = d − z` | `H_d` maps `{0,d}` to itself |
| `A^{+−}_d` | `{id, s_d}` | `τ_d` swaps the roles of `0` and `d` |

For an abelian group `H` of involutions and a character `χ`, the vectors `f_O = Σ_h χ(h) e_{h·o}` over the `H`-orbits
`O` on which `χ` kills the stabiliser form an orthogonal basis of `ℝ^V`; `A ⪰ 0` iff every block
`B_χ[O,O′] = Σ_h χ(h) A[o, h·o′] / √(|St o||St o′|)` is. The full `G₀` (168) and the `ℤ₃` of the two classes whose
stabiliser has order 6 are **not** used — so the blocks below are about 3× larger than necessary at those two
classes, and `Y`, `M − Y` could be Fourier-reduced much further (FS-50's form). Neither matters to the price (§7).

---

## §5 The exact sizes

**Orbit census** (`tools/fs54_d4_quad.py count`, `data/fs54/d4/census-q27.json`). Every Aut-orbit key is a canonical
form (least image over `4 × 168` translate-then-`g₀` maps); **completeness is checked, not assumed**: the orbit sizes
`|Aut|/|Stab|` (the stabiliser read off as the multiplicity of the least image) must sum to the number of independent
`k`-sets counted directly from the non-neighbourhood of 0. The canonical form was also checked on **every** 4-subset
at `q = 7` (211,876 sets, orbit–stabiliser exact for all 338 orbits) and for invariance under random automorphisms.

| `q` | `k` | independent `k`-sets | Aut-orbits (**the variables**) | `G₀`-orbits of those containing 0 | check |
|---|---|---|---|---|---|
| 27 | 2 | 255,150 | **9** | 9 | exact |
| 27 | 3 | 57,157,002 | **545** | 1,505 | exact |
| 27 | 4 | 9,217,814,256 | **76,684** | 302,724 | exact |
| 23 | 3 / 4 | 21,329,280 / 2,436,700,960 | 1,001 / 98,459 | 2,741 / 386,773 | exact |
| 19 | 3 / 4 | 6,548,540 / 493,266,790 | 555 / 35,472 | 1,505 / 138,154 | exact |
| 11 | 3 / 4 | 209,088 / 4,441,184 | 105 / 1,727 | 257 / 6,340 | exact |
| 7 | 3 / 4 | 10,584 / 68,796 | 23 / 120 | 53 / 385 | exact |

The plan's measure ("`G₀`-orbits of independent `k`-sets containing 0") overcounts the variables by the relabelling
`T ~ T − t`: 302,724 pointed classes are 76,684 variables. **The Frobenius is worth its factor**: at 23, with no
Frobenius, the same programme has 98,459 four-set variables and 22 `d`-classes against 27's 76,684 and 10.

**The programme at 27** (`data/fs54/d4/count-q27-l3.json`):

| item | value |
|---|---|
| variables | **77,238** = 9 + 545 + 76,684 |
| `d`-classes | 10 (8 of size 84, 2 of size 28; one is the unit circle) |
| matrices of order 729 | 30: `Y`, `M − Y`, `++` × 9, `+−` × 9, `−−` × 10 |
| PSD blocks | **102**: 21 × 169, 42 × 182, 21 × 196, 9 × 351, 9 × 378 |
| PSD rows (scaled lower triangles) | 2,607,180; `Σ m³` = 1.388·10⁹ |
| SCS data (with `y ≥ 0`) | 2,684,418 rows × 77,238 columns, **14,619,724 nonzeros, 168 MiB** |
| `G = VᵀV` | 2,011,456 nonzeros; **an arrowhead**: 76,684-diagonal plus a 554-variable border (§7.2) |
| process memory (measured) | **1.5 GB RSS** for the ADMM at 27 (15 threads); 2.2 GB RSS plus 1.4 GB on the GPU for SCS `gpu_indirect` |

For scale: FS-53's triple-level certificate at 27 has 1,847 pair orbits and 15 real blocks of order ≤ 27. The new
level has 42× the variables and blocks 14× larger — **but 23 and 27 are the same size** (3.17 M rows, `Σm³` 1.20·10⁹ at
23), and 19 is a quarter of it (1.21 M rows, `Σm³` 3.1·10⁸).

## §6 Controls

### 6.1 The implementation against the derivation

| control | what would be wrong if it failed | result |
|---|---|---|
| SCS vectorisation (`selftest`): `max x` s.t. `[[1,x,0],[x,4,½],[0,½,1]] ⪰ 0`, truth `√3.75` | the PSD cone read in the wrong triangle or scaling | x = 1.9364917 = truth: **PASS** |
| true set at 7 (a 14-set, CP-SAT optimal) and 11 (the verified 28-set): `ȳ(S)` computed exactly from the subsets of `S`, every block assembled | an entry formula, a sign, a translation or a block map | objective **14.000000000** and **28.000000000**; least block eigenvalue −1.0·10⁻¹⁵ / −1.8·10⁻¹⁵: **PASS** |
| **true set at 27** (KaMIS's verified 117-set, `data/fs54/kamis-smoke/alpha-q27-kamis.json`) | the same, plus the Frobenius in `G₀` | objective **117.000000000**; least of 102 block eigenvalues −4.3·10⁻¹⁴: **PASS** (`data/fs54/d4/checkset-q27-l3-kamis117.json`) |
| four planted faults at 11: `+−` as `Y − 2A⁺⁺`; `−−` without its 4-set term; `{d,u,v}` translated by `+d`; `M` read at `u+v` | the true-set control being blind | least eigenvalues −4.0, −3.7, −2.2, −7.3: **4 of 4 FIRED**; restored code −1.8·10⁻¹⁵ |
| **a plant that could not fire, caught**: the first plant flipped `+−` to `Y + A⁺⁺`, a sum of two PSD matrices, and "did not fire" | — | replaced by the four above; recorded because a pass from it would have meant nothing |
| **random maximal independent sets** (random-order greedy; not maxima): 12 at 11 (sizes 20–24), 6 at 19 (49–54), 3 at 27 (83, 84, 78) | a constraint that holds at the maxima only | objective = `|S|` to 10⁻⁹ and every block PSD (least −1.1·10⁻¹⁴): **all PASS** (`data/fs54/d4/randsets-q{11,19,27}.json`) |
| the certificate-shaped identity (★) with `0 ≤ y ≤ 1` evaluated **at a real set** (`evaluate --set`): 28-set at 11, 117-set at 27 | the float evaluator of §3 computing something other than (★) | `N − s` equals the three nonnegative terms to 2.5·10⁻¹³ / 2.7·10⁻¹³; **plant** dropping `μ` breaks it by 3.4·10⁻⁴ / 4.2·10⁻³: **FIRED** |
| `G = VᵀV` is an arrowhead at 27 | the ADMM's exact solve would be wrong | off-diagonal 4-set coupling ≤ 2.7·10⁻¹⁵ (cancellation noise; the solver refuses above 10⁻⁹); Schur solve residual 1.4·10⁻¹⁵ |

### 6.2 The values: **true α ≤ new ≤ triple level**

| `q` | true `α` | triple level, this tool | triple level, FS-50/53 | **L₃** | reading |
|---|---|---|---|---|---|
| 7 | 14 | **14.087850** (with FS-50's `le_diag` rows; 14.132542 without — they bind at 7 only) | 14.0879 (`fplane_sdp_blocks.py --real`) | **14.000000** (SCS, solved at 1e-8, 300 iterations) | PASS — the gap is closed exactly |
| 11 | 28 | **29.176799** (solved, 1e-8) | 29.1768 | **28.07116** primal / 28.07115 dual (SCS, 100,000 iterations, stable to 10⁻³ since 25,000); ADMM 28.0794 from above at 30,000 | PASS — 93 % of the gap closed |
| 19 | ≥ 76 (77 undecided since M61) | — | 85.665 (FS-50 `sdp-p19-linear.json`) | **81.48** dual-side reading, **81.547** certificate-shaped, at 6,090 iterations and still falling (ADMM; paused, checkpointed) | consistent; the drop is already 4.8 % |
| 27 | ∈ [117, 147] | **147.577438** / 147.577438, gap 1.2·10⁻⁷ at 32,000 iterations, **full group with Frobenius** | 147.577433 (FS-53 arms, no Frobenius) | §7.3 | **symmetry control PASS** (difference 5·10⁻⁶) |

| `q` | certificate-shaped float value `N` (§3) on the projected iterate | iterations | residual absorbed `Σμ` | `⌊N⌋` would be |
|---|---|---|---|---|
| 11 | **28.0812** (ADMM) | 30,000 | 0.0018 | 28 = α (known) |
| 19 | **81.547** | 6,090 (paused) | 0.063 | 81 (α ≥ 76; nothing decided) |
| **27** | **145.477** | 2,827 | 0.265 | **145 — five refused** |
| **27** | **143.055** | 8,000 (capped) | 0.139 | **143 — five refused with two integers to spare** |

Records: `data/fs54/d4/evaluate-q11-admm30000.json`, `certshape-q19-it6090.json`, `certshape-q27-it2827.json`, `evaluate-q27-admm8000.json` (the last also holds the rank measurement and the identity check at the 117-set). **Each is a float evaluation of a bound-shaped identity, not a bound.**

## §7 The price

### 7.1 What was measured, instrument by instrument (desktop, graphics card A pinned by UUID)

| instrument on L₃ at `q = 27` | per iteration | where the time goes | verdict |
|---|---|---|---|
| SCS 3.3.1 `gpu_indirect`, the GPU venv as built (reference netlib LAPACK) | **> 3.9 s** (a 100-iteration chunk had not returned after ~6.5 min of solving; stopped by pid; its log held no chunk line and was not kept) | CPU cone projections on unoptimised LAPACK, plus the GPU CG | not usable |
| the same with the CPU wheel's OpenBLAS **preloaded** (`LD_PRELOAD`, venv untouched) | **9.69 s** (20 iterations, 193.9 s); verbose split over 6: lin-sys **41.2 s**, cones 3.6 s, accel 0.01 s, rest 15.4 s | the GPU conjugate-gradient linear solve: ~6 s per iteration | too slow: 20,000 iterations = 54 h |
| SCS `gpu_indirect` at `q = 19` (for scale) | 1.82 s (lin-sys 30.0 of 36.5 s over 20) | the same CG | — |
| SCS `qdldl` (CPU direct) at `q = 19` | first factorisation unfinished after 10 min at 3.9 GB | KKT fill | dead at 27 |
| SCS `cudss` | `ModuleNotFoundError: scs._scs_cudss` — not built into this SCS | — | unavailable |
| cuSOLVER `dsyevd` + cuBLAS reconstruction of the 102 blocks on card A (ctypes, device-synchronised) | **457 ms** | a fixed per-call overhead at orders 169–378 | **no faster than 4 CPU threads (457 ms)**; the GPU buys nothing here |
| **the arrowhead ADMM** (this tool, `--method admm --proj-threads 14`, CPU only) | **0.16–0.18 s** (1,380.8 s for 8,000 iterations, including reports) | exact linear solve 2 ms; sparse products 75–95 ms (single-threaded scipy); eigen-projections 63–81 ms (thread pool, BLAS single-threaded) | **the instrument**: 55× cheaper per iteration than SCS on the GPU |

**Why SCS is the wrong instrument here, and the ADMM the right one.** SCS solves `(ρI + AᵀRA)x = r` by conjugate
gradients every iteration, and this `AᵀA` is ill-conditioned for CG — but it is an **arrowhead** (§5): diagonal on the
76,684 four-set variables, because each entry of each pattern matrix holds exactly one of them, plus a 554-variable
border. The Wen–Goldfarb–Yang alternating-direction method on the dual needs `AᵀA` itself, fixed, so the Schur
complement on the border is factored **once** (2.1 s) and each solve is 2 ms, exact (residual 1.4·10⁻¹⁵). SCS cannot be
given that solver without rebuilding it.

Setup at 27: canonical-form tables 45 s, assembly < 1 s, `AᵀA` and the Schur factor 2.1 s. Memory: **1.5 GB RSS**. No GPU.

### 7.2 The trajectory at 27 (8,000 iterations, capped; `data/fs54/d4/runs/admm-q27-pricing.log`)

| iteration | dual-side reading (`1 + ⟨C, Π_K X⟩`) | primal-side reading | primal / dual infeasibility |
|---|---|---|---|
| 372 | 150.029 | 152.074 | 4.0·10⁻³ / 5.5·10⁻³ |
| 1,086 | 147.410 — below the triple level | 149.667 | 8.2·10⁻⁴ / 2.2·10⁻³ |
| 2,138 | 145.819 — below 146 | 148.148 | 6.2·10⁻⁴ / 1.4·10⁻³ |
| 4,163 | 144.350 | 146.546 | 4.0·10⁻⁴ / 8.5·10⁻⁴ |
| 6,271 | 143.433 | 145.545 | 3.3·10⁻⁴ / 6.2·10⁻⁴ |
| **8,000** | **142.916** | **144.904** | 2.3·10⁻⁴ / 5.0·10⁻⁴ |

Still falling at the cap (−0.086 over the last 341 iterations). Both readings are of an unconverged iterate; the
certificate-shaped value (§3) is the number that matters, and it is **143.055** at 8,000.

### 7.3 The price, stated as the decision needs it

FS-53's standard existed because its certificate needs a near-feasible dual: its rounding broke on the rest. Here the
rows `0 ≤ y ≤ 1` make **every** PSD iterate certifiable, at the explicit cost `Σμ` (§3), so the quantity to buy is a low
certificate-shaped `N`, not a solver status.

| goal | compute | status |
|---|---|---|
| **FS-53's convergence standard** (SCS status `solved` at `eps = 1e-8`) with SCS `gpu_indirect` | at `q = 11` SCS had **not** reached it after 100,000 iterations of `L₃`; at 27 that is **> 100,000 × 9.7 s > 270 GPU-hours** | **not recommended** — and not needed (next row) |
| a float certificate-shaped value below 146 at 27 | **~2,800 iterations ≈ 8 min of desktop CPU** | **done** (145.477 at 2,827; 143.055 at 8,000) |
| a deeper margin, and the relaxation's own value | the capped run resumes from its checkpoint; at `q = 11` the same method took ~30,000 iterations to `10⁻³`; **estimated** 30,000–60,000 at 27 → **1.5–3 CPU-hours**, 0 GPU-hours | not run (over the 30-minute line) |
| **an exact certificate and a stranger's checker** — the thing that makes it a bound | engineering, not compute: a rational rounding of `Z` into low-rank Gram factors (§3), the `μ`/`λ` rule in exact arithmetic, and a standard-library checker that rebuilds the 77,238 orbits from the number 27 and verifies (★); **estimated** checker run tens of minutes | not started — a work order |

## §8 Recommendation

**The relaxation chosen:** `[GLV2009]`'s `L₃` in Schrijver's normalisation (§2), with the `0 ≤ y ≤ 1` rows for the
certificate (§3). **The instrument:** the arrowhead ADMM on the CPU, not SCS on the GPU (§7.1). **The finding:** its
certificate-shaped float value at 27 is **143.055 after 8,000 iterations (23 minutes)**, 2.95 below the 146 that refusing
five needs, and still falling. It is a reading. It becomes `α(UD(𝔽₂₇,2)) ≤ 143`, hence **χ ≥ 6 at 27**, only through an
exact rational certificate and a stranger's checker.

### Decisions for the product owner (ranked)

| # | decision | recommendation | alternative weighed | why | confidence | if nothing is said |
|---|---|---|---|---|---|---|
| 1 | build the exact certificate path for `L₃` (producer: rational low-rank Gram factors of `Z`, the `λ`/`μ` rule in exact arithmetic; a standard-library checker that rebuilds the 77,238 orbits from the number 27 and verifies (★); a derivation page promoted from §1–3 here) | **yes — it is the only thing between the reading and a bound** | a longer solve first, then decide | the reading already clears 146 by 2.95; nothing about compute is uncertain any more, and the checker is the part a stranger trusts | **high** that an exact rounding lands at `⌊N⌋ ≤ 145`: the residual cost is explicit (`Σμ` = 0.139) and Gram rounding at `10⁻¹⁰` denominators costs orders less. The one fact that would lower it: the independent checker rebuilding a different orbit table or coefficient than this tool (the census and the true-set controls say it should not) | nothing is built; 27 stays at floor five |
| 2 | resume the 27 run before rounding | **yes, 1–3 CPU-hours, no GPU** (resume line in `data/fs54/d4/runs/RESUME.md`; the checkpoint at 8,000 iterations is kept) | round the 8,000-iteration iterate now | a better-converged dual gives a smaller `Σμ` and a lower `N`, and tells how far `L₃` reaches (does it pass 140? 130?) — a fact about 27 worth having | high (it is monotone in practice here; the estimate of 30–60 k iterations to `10⁻³` is from `q = 11`, **not measured at 27**) | the 8,000-iteration checkpoint waits on disk |
| 3 | the same instrument at **23** | **yes, after #1** — same size as 27 (§5), so the same price | leave 23's first digit to search (FS-17) | five at 23 is refused iff `N < 106`, a **2.35 %** drop from 108.546; at 27 `L₃` already dropped **3.1 %**, at 19 **≥ 4.8 %** | medium — the drops at 11/19/27 are 3.8 %, ≥ 4.8 %, ≥ 3.1 %; 23 needs 2.35 % | 23 stays at floor five |
| 4 | the same instrument at **47**, where refusing **six** needs only a **0.76 %** drop (`N < 369` from the converged 371.84) and would take 47 **out of the window** | **price it next, do not launch it** | skip 47 as "converged and final" (FS-53's close) | FS-53's "final" was a statement about the triple level; `L₃` is a different relaxation and its measured drops are 4× what 47 needs. **Estimated, not measured**: 46 `d`-classes, blocks up to ~1,104, ~4 M variables, `Σm³` ~130× 27's and ~10⁸ PSD rows → **~10–15 s per iteration** on this CPU before any GPU work, and ~7 GB of sparse data (at orders 552–1,104 a GPU eigensolver does start to win) | medium-low on the price, medium-high on the value | 47 stays in the window |
| 5 | the second candidate (the level-2 Lasserre moment matrix of `[LPS2017]`/`[GMS2012]`, and GLV's all-ones border with a size threshold) | **not needed at 27**; keep in reserve for 47 | build it now | `L₃` alone clears 146; the moment matrix has full translation symmetry (blocks ≤ 365) but ~729 variables per entry (≳10⁸ nonzeros, estimated) | medium | not built |

### Settled here (skip unless curious)

| choice | alternative | why | confidence |
|---|---|---|---|
| `L₃` (localise at a pair, every sign pattern) over the quadruple moment matrix | GMS/LPS level-4 `C₂ × C₂` matrix | same variables, blocks of 169–378 with `nnz` 14.6 M against ≳10⁸ estimated; and it measurably closes 100 % / 93 % of the gap at 7 / 11 | high |
| Schrijver's normalisation (objective = trace, exact) over GLV's `y_∅ = 1` | keep the all-ones coordinate | the `|V|/s` corner is not linear; the threshold form is kept as an option (`--border --s0`), unused | high |
| only the Klein subgroups of each stabiliser for block-diagonalising | full `G₀` / the `ℤ₃` at two classes | blocks are already cheap to project (62 ms for all 102); the full group would shrink only `Y`, `M − Y` and two classes | high |
| the arrowhead ADMM over SCS | SCS `gpu_indirect` (measured 9.7 s/it), `qdldl` (factorisation unfinished at 19), `cudss` (not built) | 55× per iteration, exact linear solve | high |
| CPU eigen-projections in a thread pool over cuSOLVER on card A | GPU projections | measured 62 ms against 457 ms at these orders | high at 27; **reverses** at orders ≳ 500 (47) |
| a capped 23-minute run at 27 inside the 30-minute line | stop at a timing-only run | the trajectory *is* the projection basis, and its checkpoint is the warm start of any approved run | high |

### What the controls can and cannot catch

They catch a wrong entry formula, sign, translation, block map, vectorisation, group element, or orbit table (the
census's orbit–stabiliser sum is exact at every `k`), and they have been seen to fire. **They cannot catch a
constraint that is invalid for some untested independent set yet valid for all tested ones**: the tested sets are the
maxima at 7 and 11, the 117-set at 27, 18 random maximal sets at 11 and 19 and 3 at 27. The derivation (§1–2) is the
argument that no such set exists, and an independent checker is the second implementation that makes it believable.
