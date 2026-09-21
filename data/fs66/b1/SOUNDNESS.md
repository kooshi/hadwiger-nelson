# Why the certificate proves the statement

*The one page a reviewer needs. It is self-contained: it assumes no acquaintance with this repository, it
cites nothing of ours, and its only claim is that the mechanical checks in `tools/fs66_b1_cert_check.py`,
together with the six elementary links below, imply the sentence of §7. Written for FS-66 phase 2A,
2026-09-21. The companion objects are the checker (standard library, exact integer arithmetic, reads no
floating-point number) and the certificates `data/fs66/b1/proto-cert-p{3,7,11}.json`. The producer that
makes a certificate is untrusted and is not described here except to say what it cannot do.*

---

## 0. The claim

Fix a prime `p ≡ 3 (mod 4)`. For each `k ≥ 1` let `G_k` be the **unit-distance graph over `ℤ/p^k`**: its
points are the pairs `(a, b)` with `a, b ∈ ℤ/p^k`, and two points are adjacent when the sum of the squares of
their coordinate differences is `1`. These graphs form a tower — reducing coordinates modulo `p^{k−1}` sends
`G_k` onto `G_{k−1}` — and `G_1` is the plane over the field with `p` elements.

> **What a certificate claims.** For an explicit rational number `U`, *every* independent set of *every*
> `G_k` has at most `U · p^{2(k−1)}` points. Consequently, if `m · U < p²` then no `G_k` is `m`-colourable,
> for any `k`.

A refusal at one level of a tower says nothing about the next, so the value of this object is that one finite
check settles all levels at once. The certificate is one algebraic identity between integer linear forms,
plus the positive definiteness of a dozen small integer matrices. Nothing below needs a computer to follow.

**Notation used throughout.** `V = 𝔽_p²` is the plane over the field with `p` elements and `n = p² = |V|`;
the point `(a, b)` is written as the integer `a·p + b`, so the origin is `0`. `S ⊆ V` is the **unit circle**
`{(a, b) : a² + b² = 1}`, which has exactly `p + 1` points because `p ≡ 3 (mod 4)`. For a vector
`φ ∈ [0, 1]^V` put

```
q(φ) = 2 · Σ_x φ_x (1 − φ_x)  −  Σ_x Σ_{s ∈ S} φ_x φ_{x+s}.
```

A **monomial** is a multiset of at most four points of `V`, written as a sorted list; `[]` is the constant
`1` and `[x, x]` is `φ_x²`.

---

## 1. Above level one, every eigenvalue is small (L1)

`G_k` is the Cayley graph of `(ℤ/p^k)²` on the set `S_k` of solutions of `x² + y² = 1` modulo `p^k`.

*Hensel's count.* The gradient `(2x, 2y)` of `x² + y² − 1` is nonzero modulo `p` at every point of the
circle, so each point of `S_j` has exactly `p^{k−j}` lifts in `S_k`; in particular `|S_k| = p^{k−1}(p + 1)`.

*The bound.* Let `k ≥ 2`. The set `N = {1 + p^{k−1}·i·a : a ∈ 𝔽_p}` is a subgroup of the circle group of
`ℤ/p^k` — its elements have norm `1 + p^{2k−2}a² ≡ 1`, because `2k − 2 ≥ k` — so `S_k` is a union of cosets
`sN = {s + p^{k−1}a·(i·s) : a ∈ 𝔽_p}`. Let `χ_u` be an additive character whose index `u` is nonzero modulo
`p` ("of exact level `k`"). Summing `χ_u` over one coset gives

```
Σ_a χ_u(s + p^{k−1} a · i s)  =  χ_u(s) · Σ_a e(a · ⟨ū, i·s̄⟩ / p),
```

which vanishes unless `⟨ū, i·s̄⟩ = −ū₁s̄₂ + ū₂s̄₁ = 0`, that is, unless `s̄` lies on the line through `ū`. That
line meets `S₁` in at most two points, which have `2p^{k−1}` lifts between them, i.e. `2p^{k−2}` cosets, each
contributing modulus at most `p`. Hence `|λ_u(G_k)| ≤ 2p^{k−1}`. A character of exact level `j` with
`2 ≤ j < k` factors through level `j`, and Hensel's count gives `λ_u(G_k) = p^{k−j} λ_u(G_j)`, so the same
bound holds. The characters of exact level `≤ 1` span exactly the functions that are constant on the fibres
of `G_k → G_1`. Therefore:

> **L1.** Every eigenvalue of the adjacency operator of `G_k` on the orthogonal complement of the
> fibre-constant functions is at least `−2p^{k−1}`.

*(Surjectivity of `S_k → S_{k−1}` is not used. The argument needs only that `S_k` is a union of cosets of `N`
and Hensel's lift count.)*

## 2. The fibre-density inequality (L2)

Let `I` be an independent set of `G_k`, `k ≥ 2`. For a point `x` of `V = G_1`'s vertex set, let `φ(x) ∈ [0,1]`
be the share of the fibre over `x` that `I` fills. Decompose the indicator `1_I = Pφ + g`, with `Pφ` the
fibre-constant part and `g` orthogonal to it; the adjacency operator preserves both parts. Then

```
⟨Pφ, A_k Pφ⟩ = p^{3(k−1)} · ⟨φ, A₁ φ⟩,     ‖g‖² = p^{2(k−1)} · Σ_x φ(x)(1 − φ(x)),
```

and `⟨g, A_k g⟩ ≥ −2p^{k−1}‖g‖²` by **L1**. Independence says `⟨1_I, A_k 1_I⟩ = 0`. Adding the two parts and
dividing by `p^{3(k−1)}` gives `⟨φ, A₁φ⟩ ≤ 2 Σ φ(1 − φ)`, which is exactly `q(φ) ≥ 0`; and
`|I| = p^{2(k−1)} · Σ φ`. At `k = 1`, `φ = 1_I` is a 0/1 vector and `q(φ) = −⟨φ, A₁φ⟩ = 0`. Therefore:

> **L2.** Every independent set of every level yields a vector `φ ∈ [0,1]^V` with `q(φ) ≥ 0` and
> `|I| = p^{2(k−1)} · Σφ`. So a bound `Σφ ≤ U` valid on the whole region `{φ ∈ [0,1]^V : q(φ) ≥ 0}` bounds
> every level's independence number at once.

The constant `2` in `q` is the one place `L1`'s eigenvalue bound enters, and it is built into the checker: the
file carries no constant to read there.

## 3. Symmetrised moments (L3)

Let `Γ` be the group **generated by** the translations of `V` and by the linear maps the checker verified.
The checker rebuilds `2(p+1)` maps from `p` alone and verifies of each that it is a bijection `h` of `V` with

```
h(x + s) − h(x) ∈ S     for every point x and every s ∈ S.
```

That property is closed under composition and inverse, so the whole group `Γ` has it, and the closure of the
list never has to be checked. For `γ ∈ Γ` the map `s ↦ γ(x+s) − γ(x)` is an injection of the finite set `S`
into itself, hence a bijection, so `q(φ∘γ) = q(φ)`, `Σ(φ∘γ) = Σφ`, and `φ∘γ ∈ [0,1]^V`.

For a feasible `φ` define the **symmetrised moment** of a monomial `m`:

```
ȳ(m) = |Γ|^{−1} · Σ_{γ ∈ Γ} Π_{x ∈ m} φ(γ x).
```

Six properties, each immediate:

| | fact | why |
|---|---|---|
| M1 | `ȳ([]) = 1` | the empty product |
| M2 | `n · ȳ([0]) = Σφ` | the translations act transitively on `V` |
| M3 | `ȳ(γ m) = ȳ(m)` for `γ ∈ Γ` | re-indexing the average |
| M4 | `ȳ(m) ≥ 0` | an average of products of numbers in `[0,1]` |
| M5 | `ȳ(m ∖ x) − ȳ(m) ≥ 0` | the same average against the factor `1 − φ(γx) ≥ 0` |
| M6 | `Σ_{i,j} 𝒵_{ij} ȳ(m_i m_j) ≥ 0` for positive semidefinite `𝒵` | an average of quadratic forms `vᵀ𝒵v` |
| M7 | `Σ_{i,j} 𝒵_{ij} Q(m_i m_j)(ȳ) = q(φ) · Σ_{i,j} 𝒵_{ij} ȳ(m_i m_j) ≥ 0` | `q(φ∘γ) = q(φ) ≥ 0`, and M6 |

Here `Q(m)` is the linear form "the moment of `q` times `m`", written out from the definition of `q`:

```
Q(m) = 2·Σ_x y(m ∪ x)  −  2·Σ_x y(m ∪ x ∪ x)  −  Σ_x Σ_{s ∈ S} y(m ∪ x ∪ (x+s)).
```

## 4. The identity the checker verifies (L4)

A **certificate** is a JSON file holding: a prime `p`; a positive integer `scale` `L` and an integer `U_num`,
so that the bound claimed is `U = U_num / L`; a list of integer **weight vectors** `ŵ = [c, w_0, …, w_{n−1}]`;
a list of **blocks**, each a symmetric positive definite integer matrix `R` together with a set of weight
vectors and a flag `times ∈ {"1", "q"}`; and a list of **rows** `[A, B, lam]` with `lam ≥ 0` an integer and
`A`, `B` lists of points with `|A| + |B| ≤ 4`.

A block is indexed by the constant and by a fixed list of **representative** monomials that depends only on
`p`: for `times = "1"` these are `φ_0` and then `φ_{−h}φ_h`, one for each class `{h, −h}`, ordered by the
smaller index; for `times = "q"` the single monomial `φ_0`. Write `Y(m)` for `y(m)` when `times = "1"` and for
`Q(m)` when `times = "q"`, and for a weight vector put `σ = Σ_x w_x` and `κ(t) = Σ_x w_x w_{x+t}`. The block's
contribution and a row's contribution are

```
T_block(y)  =  Σ_ŵ [ R[0][0]·c²·Y([])  +  2·Σ_a R[0][a]·c·σ·Y(a)  +  Σ_{a,a′} R[a][a′]·Σ_t κ(t)·Y(a · τ_t a′) ]
box(A,B)(y) =  Σ_{T ⊆ positions of B} (−1)^{|T|} · y(A ∪ B_T)
```

and the identity checked, **coefficient by coefficient over the monomials, in exact integers**, is

```
(★)   U_num · y([])  −  L · n · y([0])  =  Σ_blocks T_block(y)  +  Σ_rows lam · box(A,B)(y).
```

**Why (★) gives the bound.** Evaluate both sides at `y = ȳ`. By M1 and M2 the left side is `U_num − L·Σφ`.
On the right:

* Index the monomials of degree `≤ 2` as `[]` and `(x, a) ↔ τ_x(a)`, and for a weight vector let `E_ŵ` be the
  matrix from the block's index set to that space with `E_ŵ[[], 0] = c` and `E_ŵ[(x,a), a] = w_x`. Expanding
  `⟨E_ŵ R E_ŵᵀ, M⟩`, where `M` is the moment matrix of `ȳ` (for `times = "1"`) or of `q·ȳ` on monomials of
  degree `≤ 1` (for `times = "q"`), reproduces the three terms of `T_block` — the third because
  `Σ_{x,x′} w_x w_{x′} ȳ(τ_x a · τ_{x′} a′) = Σ_t κ(t) ȳ(a · τ_t a′)`, which uses only `ȳ(τ_x m) = ȳ(m)`.
  `E R Eᵀ` is positive semidefinite whenever `R` is, so by M6 (resp. M7) each `T_block(ȳ) ≥ 0`.
* Each `box(A,B)(ȳ)` is the symmetrised moment of a product of numbers in `[0,1]` and numbers `1 − φ_x` in
  `[0,1]`, hence `≥ 0` by M4 and M5; and `lam ≥ 0`.

So `U_num − L·Σφ ≥ 0`, and **because `L > 0`** we may divide: `Σφ ≤ U_num/L = U`. That division is the only
place the sign of the scale is used, which is why a non-positive scale is a named refusal and not a
formatting nicety: negating `scale`, `U_num`, every `R` and every `lam` together leaves (★) true and reverses
the conclusion.

> **L4.** If (★) holds, every `R` is positive definite, every `lam ≥ 0` and `L > 0`, then every
> `φ ∈ [0,1]^V` with `q(φ) ≥ 0` satisfies `Σφ ≤ U`.

**Two things are deliberately *not* on the trust surface.** The **weight vectors**: `E R Eᵀ` is positive
semidefinite for *any* integers in `ŵ`, so wrong weights — or a wrong number of blocks, or a clipped
multiplier, or a bad rounding — can only make `U` larger, never make a false certificate. (The producer takes
the weights to be rounded cosines and sines because that makes `U` small; that is a fact about the producer.)
And the **representatives need not be canonical**: any list of monomials of degree `≤ 2` indexes a — possibly
repeated — principal submatrix of the moment matrix, and M6 applies unchanged. The checker nonetheless fixes
the list from `p`, because the file does not carry one and the two sides must agree on what `R`'s rows mean.

**Why the canonical form cannot make a false certificate pass.** (★) is checked on *canonical* monomials: the
checker replaces each monomial by the least image it can find under a translation followed by one of the
verified maps. Two monomials are therefore merged only when one really is `γm` for a `γ ∈ Γ`, and then
`ȳ` gives them the same value by M3, so the merge is sound. Failing to merge two equivalent monomials only
makes (★) a stricter requirement. A canonicaliser that is incomplete is safe; one that merges wrongly is
impossible by construction, because every merge is witnessed by an explicit group element.

The same merge is applied to the forms `Q(m)`, and it needs the same property and nothing more: substituting
`x ↦ γx` in the definition of `Q` and using that `s ↦ γ(x+s) − γ(x)` permutes `S` turns `Q(γm)` term by term
into `Q(m)`, so the two are the same linear form in the canonical variables.

## 5. Positive definiteness (L5)

The checker's default route uses two classical facts. **Sylvester:** a symmetric real matrix all of whose
leading principal minors are positive is positive definite. **Bareiss:** in fraction-free elimination without
pivoting, the `k`-th pivot *is* the `k`-th leading principal minor, and every division is exact. So walking
the elimination and demanding a positive pivot at each step is exactly Sylvester's test, in integers. (The
checker verifies each of those divisions has zero remainder, and treats a nonzero remainder as a bug in
itself rather than a fault of the file.)

A reader who prefers to assume neither theorem runs the checker with `--ldl`. It then computes an exact
rational `R = L·D·Lᵀ` with `L` unit lower triangular, **re-multiplies it and compares entry by entry with
`R`**, and checks every `D_k > 0`; then `xᵀRx = (Lᵀx)ᵀ D (Lᵀx) > 0` for `x ≠ 0` is two lines with no named
theorem, and the elimination code itself leaves the trust surface. The two routes agree on every block of
every certificate here, and the self-test additionally demands `D_k = minor_k / minor_{k−1}`.

Only symmetric matrices are tested, and a non-symmetric `R` is refused rather than silently symmetrised.

## 6. From the bound to the colours (L6)

By **L2** and **L4**, `α(G_k) ≤ U · p^{2(k−1)}` for every `k ≥ 1`. An `m`-colouring of `G_k` covers its
`p^{2k}` points with `m` independent sets, so `p^{2k} ≤ m · U · p^{2(k−1)}`, that is `p² ≤ m·U`. Hence:

> **L6.** If `m · U < p²`, then no `G_k` is `m`-colourable, at any level `k ≥ 1`. And since `G_k` is
> vertex-transitive, its fractional chromatic number is `p^{2k}/α(G_k) ≥ p²/U`.

The checker performs this last comparison in integers, as `m · U_num < p² · L`, and says `CERTIFIED` only
then. If `m·U ≥ p²` it says `BOUND ONLY` and exits 3 — the file is still a valid proof of `Σφ ≤ U`, it simply
does not refuse that many colours, **which is not evidence that that many colours suffice**.

---

## 7. Where each obligation is discharged

| obligation | discharged by | rung |
|---|---|---|
| (★); positive definiteness; `lam ≥ 0`; `L > 0`; that the rebuilt maps are symmetries; `m·U_num < p²·L` | the checker, every run, in exact integers | **checked** |
| that the checker's fast bookkeeping equals the definitions (canonical forms; the `κ` route; Bareiss) | `--self-test`'s three twins, each of which has been seen red on a deliberate break | **tested** |
| that L1 and L2 are not false | `tools/fs66_b1_links_test.py`: the inequality `q(φ) ≥ 0` verified in exact integers on 803 explicit independent sets of levels two and three at `(3;2)`, `(3;3)`, `(7;2)` — no violation, and the pull-back of a level-one set is tight (`q = 0`). **An example can falsify, never verify** | **tested (falsifier)** |
| that L1–L6 are true | this page, by hand; each link is elementary and under a dozen lines | **paper** |
| the clopen and measure statements of §8 | by hand, in the milestone's main plan | **paper** |
| nothing | — | **assumed** |

**What the checker refuses, and what each refusal means.** The list is closed; nothing is accepted and
ignored. `NOT_AN_INTEGER` — a float, a string or a boolean where an integer belongs (the checker reads no
floating-point number at all). `MALFORMED` — a shape, an index out of range, a row of degree above four, a
block of the wrong size, a non-symmetric `R`, or an unknown top-level key (so a misspelt field cannot be read
as an absent one). `BAD_PRIME` — `p` is not a prime `≡ 3 (mod 4)`; nothing here was examined for
`p ≡ 1 (mod 4)`, where the circle is a different object. `NONPOSITIVE_SCALE` — §4's division. 
`NEGATIVE_MULTIPLIER`. `BLOCK_NOT_POSITIVE_DEFINITE` — naming the block and the first non-positive minor.
`IDENTITY_MISMATCH` — naming how many monomials disagree and the first three, and, when the only
disagreement is at the constant, the `U_num` the file's blocks and rows actually support. Separately,
`ERROR SELF_CHECK_FAILED` says a rebuilt map is not a symmetry — a bug in the checker, never the file's
fault.

**What `CERTIFIED` is not.** It is a standard-library program's word, not a proof assistant's, and it asserts
only the polynomial bound `Σφ ≤ U`. Everything about the tower is carried by L1, L2 and L6 above, which is
why the checker names them in its own last line.

---

## 8. The statement this licenses, clause by clause

At `p = 11`, with `U = 28.204320…` (the production certificate `cert-p11.json`):

> For every `k ≥ 1`, every independent set of `UD(ℤ/11^k, 2)` has at most `U · 121^{k−1}` points. Hence no
> level of the tower is four-colourable; the chromatic number of every level is exactly 5; the fractional
> chromatic number of every level lies in `[121/U, 121/28] = [4.2901, 4.3215]`; the clopen chromatic number
> of `ℤ₁₁²` is 5; and the supremum of the Haar measure of a measurable independent set of `ℤ₁₁²` lies in
> `[28/121, U/121] = [0.23140, 0.23310]`.

At `p = 7`, with `U = 14.015224…` (`cert-p7.json`): the same with three colours, `χ = 4`, `χ_f ∈ [3.4961, 3.5]`; and since the
pull-back of a level-one independent set of 14 points has `14 · 49 = 686` points while
`⌊14.017576 · 49⌋ = 686`, the independence number of `UD(ℤ/49, 2)` is **exactly 686**. A verified independent
set of 687 points there would refute either this page's hand links or the checker.

| clause | rests on |
|---|---|
| `α(G_k) ≤ U·p^{2(k−1)}` for every `k`; no level is `m`-colourable | the checker's `CERTIFIED` + L1, L2, L6 |
| `α(UD(ℤ/49,2)) = 686`; `3,388 ≤ α(UD(ℤ/121,2)) ≤ 3,412` | the same + an explicit level-one independent set of 14 (resp. 28) points, verified from the definition |
| `χ(G_k) = 5` at 11 (`= 4` at 7) | the first clause + a verified colouring of level one, pulled back |
| `χ_f(G_k) ∈ [p²/U, p²/α(G₁)]` | the first two clauses + vertex-transitivity of a Cayley graph |
| the clopen chromatic number; the Haar-measure bracket | the above + two hand steps: a clopen colouring of `ℤ_p²` is a colouring of some level, and the cosets more than half filled by a measurable independent set are themselves independent (Lebesgue density) |

**The Borel clause.** `[BardestaniMallahiKarai2017]` pose the *`p`-adic Hadwiger–Nelson problem* for the
**Borel** chromatic number of `ℚ_p²` and prove only `O(p²)` from above. The certificate gives exact values. A
Borel colour class meets `ℤ_p²` in a measurable independent set, of Haar measure at most `U/p²` by the last
clause above, so `χ_Bor ≥ ⌈p²/U⌉`; and a colouring of level one, pulled back, is clopen, hence Borel, and
extends over the countably many cosets of `ℤ_p²` in `ℚ_p²` because unit vectors are integral, so
`χ_Bor ≤ χ(UD(𝔽_p, 2))`. The two meet: **`χ_Bor(ℚ₇²) = 4` and `χ_Bor(ℚ₁₁²) = 5`** (and `= 3` at `p = 3`).
This clause rests on the measure clause above (hand), the certificate, and L1–L6 — the same trust word as
everything else on this page, and not a proof assistant's.

**At `p = 19` and `p = 23`, the same clauses with the same links** (`cert-p19.json`, `U = 77.511742…`;
`cert-p23.json`, `U = 97.984637…`). At 19: four colours refused at every level, `χ(G_k) = 5`,
`χ_f ∈ [4.6574, 4.7500]`, Haar supremum in `[0.210526, 0.214714]`, `χ_Bor(ℚ₁₉²) = 5`, and
`27,436 ≤ α(UD(ℤ/361, 2)) ≤ 27,981`. At 23: **five** colours refused at every level, so `χ(G_k) ≥ 6` at
every `k`, `χ_f ∈ [5.3988, 6.0805]`, Haar supremum in `[0.164461, 0.185226]`, and
`46,023 ≤ α(UD(ℤ/529, 2)) ≤ 51,833`.

**Two of those clauses read differently at 23, and the difference is a fact about 23 rather than about the
certificate.** (i) *The chromatic number of a level is not pinned*, only floored: `χ(UD(𝔽₂₃, 2))` is
undecided — FS-53 and FS-56 leave it in `{6, 7, 8}` — so the pull-back argument that gave `χ(G_k) = 5` at
11 and 19 gives only `6 ≤ χ(G_k) ≤ χ(UD(𝔽₂₃, 2))` here. (ii) *The Borel clause does not close*: the lower
half stands, `χ_Bor(ℚ₂₃²) ≥ ⌈529/U⌉ = 6`, and the upper half is that same undecided `χ(UD(𝔽₂₃, 2))`, so
this page licenses `6 ≤ χ_Bor(ℚ₂₃²) ≤ 8` and not an exact value. A verified six-colouring of `UD(𝔽₂₃, 2)`
would close both at once.

**One clause that is new at 19 and 23, and rests on §6 alone.** `B₁(p) ≥ α(UD(𝔽_p, 2))`, because a level-one
independent set is itself a feasible `φ` (§2's `k = 1` case), so **the same `U` bounds the independence
number of the finite plane**: `α(UD(𝔽₁₉, 2)) ≤ 77` and `α(UD(𝔽₂₃, 2)) ≤ 97`. At 7 and 11 this is vacuous
(`⌊U⌋` is already `α`); at 19 and 23 it beats what a relaxation built for `α` itself had proved (80 and
105). It uses no hand link beyond §2 and §6.

**What none of this says:** anything about the ordinary (non-clopen) chromatic number of `ℚ_p²`; anything
about a number field's plane beyond a ceiling; and nothing that would decide whether `U` is the true maximum
— at 11 it is 0.8 % above the level-one independence number 28, and whether that gap is real is open.

---

## 9. The instance a person can read whole: `p = 3`

`data/fs66/b1/proto-cert-p3.json` is 4,417 bytes. Here `n = 9`, the nine points `(a,b)` are numbered
`3a + b`, and the unit circle is

```
S = { (0,1), (0,2), (1,0), (2,0) } = { 1, 2, 3, 6 },     |S| = p + 1 = 4.
```

So `G₁` is a 4-regular graph on 9 points, with `α = 3` and `χ = 3`. The six **representative** monomials the
blocks are indexed by, computed from `p` alone, are

```
[0],   [0,0],   [1,2],   [3,6],   [4,8],   [5,7]
```

— `φ_0`, then `φ_{−h}φ_h` for the five classes `{h,−h}` in order of the smaller index `h = 0, 1, 3, 4, 5`.
The file's five **weight vectors** are the constant one and, for each of the two classes of nonzero
characters, a rounded cosine and a rounded sine at `10⁹`:

```
0:  c = 1,  w = (1, 1, 1, 1, 1, 1, 1, 1, 1)
1:  c = 0,  w = 10⁹ · (1, −½, −½,  1, −½, −½,  1, −½, −½)
2:  c = 0,  w = 10⁹ · (0,  √3/2, −√3/2,  0,  √3/2, −√3/2,  0,  √3/2, −√3/2)
3:  c = 0,  w = 10⁹ · (1, −½, −½, −½, −½,  1, −½,  1, −½)
4:  c = 0,  w = 10⁹ · (0,  √3/2, −√3/2,  √3/2, −√3/2,  0, −√3/2,  0,  √3/2)
```

and the scale is `L = 10³⁰` — which is `10¹² · (10⁹)²`, the rounding digits of the blocks times the square of
the weights' digits. **Nothing in the last two paragraphs is on the trust surface** (§4): they say where the
numbers came from, not why they work.

**The six blocks.** Blocks 0 and 5 carry the constant weight and their entries are all multiples of `10¹⁸`;
they are shown here divided by `10¹⁸`, and the file holds the undivided integers. Every one of the six is
symmetric, and the checker confirms each is positive definite.

```
block 0   times "1"   weight 0    7 × 7   (entries ÷ 10¹⁸)
  [ 3000017321469,  -782094738890,  -24750147794,  -121317637298,  -121317637298,  -193164706094,  -193164706094 ]
  [ -782094738890,   213798672356,    6899297356,    26896918410,    26896918410,    40002990385,    40002990385 ]
  [  -24750147794,     6899297356,    1197787714,     1274079930,     1274079930,      153257050,      153257050 ]
  [ -121317637298,    26896918410,    1274079930,     8316600649,     6499172396,    12268602173,    12268602173 ]
  [ -121317637298,    26896918410,    1274079930,     6499172396,     8316600649,    12268602173,    12268602173 ]
  [ -193164706094,    40002990385,     153257050,    12268602173,    12268602173,    24232819872,    24232606074 ]
  [ -193164706094,    40002990385,     153257050,    12268602173,    12268602173,    24232606074,    24232819872 ]

block 1   times "1"   weights 1, 2    7 × 7
  [ 1,             0,             0,             0,             0,             0,             0 ]
  [ 0,  280343717377,   44531927263,  -44532056014,   88654121247,  -44326996231,  -44326996231 ]
  [ 0,   44531927263,   14251776099,  -11220098065,   28626805175,  -11282065945,  -11282065945 ]
  [ 0,  -44532056014,  -11220098065,   17277538068,  -22569515183,   17341980664,   17341980664 ]
  [ 0,   88654121247,   28626805175,  -22569515183,   57534320821,  -22709860140,  -22709860140 ]
  [ 0,  -44326996231,  -11282065945,   17341980664,  -22709860140,   17423395114,   17406709435 ]
  [ 0,  -44326996231,  -11282065945,   17341980664,  -22709860140,   17406709435,   17423395114 ]

block 2   times "q"   weights 1, 2    2 × 2        [ 1, 0 ; 0, 4185197835 ]

block 3   times "1"   weights 3, 4    7 × 7
  [ 1,          0,            0,            0,            0,            0,            0 ]
  [ 0,   13210714,   -140979376,    141044088,    141044088,   -268882533,    127773331 ]
  [ 0, -140979376,   1505109201,  -1505834609,  -1505834609,   2870685523,  -1364115731 ]
  [ 0,  141044088,  -1505834609,   1507199927,   1506560841,  -2872706901,   1364781887 ]
  [ 0,  141044088,  -1505834609,   1506560841,   1507199927,  -2872706901,   1364781887 ]
  [ 0, -268882533,   2870685523,  -2872706901,  -2872706901,   5476528543,  -2601786528 ]
  [ 0,  127773331,  -1364115731,   1364781887,   1364781887,  -2601786528,   1236340066 ]

block 4   times "q"   weights 3, 4    2 × 2        [ 1, 0 ; 0, 2680847 ]

block 5   times "q"   weight 0    2 × 2   (entries ÷ 10¹⁸)
  [ 282095086231,  29883665858 ;  29883665858,  4289213210 ]
```

Beside them the file holds 27 rows — box products with nonnegative multipliers: eight of the form
`[A, [], lam]` with `|A| = 4`, eight `[A, [x], lam]` with `|A| = 3`, seven with `|A| = 2`, three with
`|A| = 1`, and one with `A` empty.

**One coefficient of (★), by hand.** Take the constant monomial `[]`. On the left of (★) its coefficient is
`U_num`. On the right, a block with `times = "q"` contributes nothing, because every term of `Q` has degree
at least one; a block with `times = "1"` contributes `R[0][0]·c²`, which is zero for the four character
blocks since their weights have `c = 0`; and a row contributes `lam` exactly when `A` is empty. So the whole
right-hand side at `[]` is one matrix entry plus one row multiplier:

```
  block 0, R[0][0] · 1²        3000017321469000000000000000000
  row 24, [[], [0], lam]     +         92439606576234051993752640
                             ----------------------------------
                               3000109761075576234051993752640   =  U_num  ✓
```

and `U = U_num / 10³⁰ = 3.000109761…`. Since `2 · U = 6.00021… < 9 = p²`, **no level of the 3-adic tower is
two-colourable** — true and trivial, which is what a worked example should be: `α(G₁) = 3`, and the
certificate reads `3.0001`, within `0.004 %` of the truth. The remaining 27 canonical monomials of the
identity are verified the same way by the checker, in about a twentieth of a second:

```
$ python3 tools/fs66_b1_cert_check.py data/fs66/b1/proto-cert-p3.json --m 2
…
step 6/7: identity (*) holds on 28 canonical monomials (6 blocks, 27 rows), coefficient by coefficient in exact integers
step 7/7: 2 * U_num = 6000219522151152468103987505280 < 9 * scale = 9000000000000000000000000000000
CERTIFIED: every phi in [0,1]^9 with q(phi) >= 0 has sum(phi) <= U = 3.000109… (exactly U_num/scale of the
file, sha256 e47f4901721c…); 2*U = 6.000219… < 9, so BY THE HAND-PROVED LINKS L1, L2, L6
(data/fs66/b1/SOUNDNESS.md) no UD(Z/3^k, 2), k >= 1, is 2-colourable. Standard-library checker, NOT the
Lean kernel.
```
