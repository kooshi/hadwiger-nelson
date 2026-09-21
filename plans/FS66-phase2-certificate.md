# FS-66 Phase 2 — the all-levels certificate. Subplan

*Opened 2026-09-20 by the Phase-2 planner (one Fable agent). The implementer arrives with no memory of the planner or of any
conversation: **everything needed is in this file or at a path it names.** The milestone's main plan is
`plans/FS66-residue-tower-drop.md` (read its §0, §G, §S2, §S4–S5 for the mathematics this phase certifies; this file replaces
its §I3, §I4 and "Phase 2" checklist, which were written before the measurements below). Measurements and prototype outputs:
`data/fs66/b1/` (its `README.md` is the record this file cites as §M). Read order for a cold reader: §0, §M, §C, §S, then your
phase in §H.*

---

## 0. What this phase is, in plain language, and what the planner found on its first evening

**The question.** For a prime `p ≡ 3 (mod 4)` the unit-distance graphs `G_k` over the rings `ℤ/p^k` (points `(a, b)` modulo `p^k`,
adjacent when the squared differences sum to 1) form a tower `… → G₃ → G₂ → G₁`, and a number field's plane that reduces into the
tower needs at most `χ(G_k)` colours for every `k`. At `p = 11`, levels one, two and three each refuse four colours — but a refusal
at one level says nothing about the next. **This phase produces one finite object that refuses four colours at every level at
once**, and a small independent program that checks it.

**The instrument** (the owner's inequality, main plan §S4; re-derived in §S below). If `I` is an independent set of `G_k` and
`φ(x) ∈ [0,1]` is the share of the fibre over the level-one point `x` that `I` fills, then `φ` satisfies one quadratic inequality
that does not mention `k`:

> `q(φ) := 2·Σ_x φ_x(1 − φ_x) − Σ_x Σ_{s ∈ S} φ_x φ_{x+s} ≥ 0`  (`S` = the `p + 1` unit vectors of level one).

So `B₁(p) := max {Σφ : φ ∈ [0,1]^{p²}, q(φ) ≥ 0}` bounds `α(G_k)/p^{2(k−1)}` for every `k`, and **`m·B₁(p) < p²` refuses `m` colours
at every level.** Four colours at 11 need `B₁(11) < 30.25`. `B₁` is a non-convex quadratic programme in 121 variables; what is
wanted is a **certificate** of an upper bound `U`: an explicit algebraic identity plus positive definiteness of a dozen small
rational matrices, checkable in exact arithmetic by a program that trusts no solver.

**What the planner measured (§M).** The second-level moment (sum-of-squares) relaxation reads **14.01 at 7** (need < 16.33) and
**28.2016 at 11** (need < 30.25) on two solver code bases — a margin of 2.05, 6.8 % — and needs far less than was sketched: no
edge or triangle cuts, no matrix localisers of the box, eleven blocks of size ≤ 63, **83 seconds on two CPU threads in ordinary
double precision.** A prototype then rounded the solver's dual to an exact rational identity: **`U = 14.0176` at 7 and
`U = 28.2251` at 11, every block positive definite by exact integer elimination, 1.5 s of exact arithmetic.** That prototype
checks its own work with its own bookkeeping, so **it is a measurement of the design and not a certificate.** What is left — and
it is the whole value of the phase — is the trust engineering: the independent checker, its controls, the soundness page, the
records. **No GPU, no Julia, no extended precision is needed at 11** (said plainly because all three were offered).

---

## §G. Words

| word | meaning here |
|---|---|
| **owner / planner / implementer** | the session that briefs and reviews by artifact / this file's author / you |
| **`V`, `n`, `S`, `G₁`** | the level-one plane `𝔽_p²`, `n = p²`, the unit circle `{s : s₁² + s₂² = 1}` (`p + 1` points), and `G₁ = Cay(V, S)` |
| **point index** | the point `(a, b)` is the integer `a·p + b`; the origin is `0`. Every file and both tools use this numbering |
| **monomial** | a multiset of at most four points, written as a sorted list of point indices; `[]` is the constant 1, `[x, x]` is `φ_x²` |
| **`Γ`** | the symmetry group: all translations of `V`, the `p + 1` rotations `z ↦ s·z` (`s ∈ S`, `V = 𝔽_p[i]`) and those composed with conjugation `(a, b) ↦ (a, −b)`; order `2p²(p+1)` — 784 at 7, 2,904 at 11. Every element preserves `S`, hence `q`, the box and `Σφ` |
| **canonical form** `canon(m)` | the least (as a sorted tuple) image of the monomial `m` under `Γ`; computed by trying each point of `m` as the new origin and each of the `2(p+1)` linear maps. **It is always a genuine image `γ·m`** — the property soundness uses (§K.2) |
| **moment functional `y`** | a `Γ`-invariant real function on monomials with `y([]) = 1`; the symmetrised moments `ȳ` of a feasible `φ` are one (§S.3) |
| **representatives** | the `1 + (n+1)/2` monomials `φ_0` and `φ_{−h}φ_h` (one per class `{h, −h}`, in order of the smaller index; `h = 0` gives `φ_0²`): every monomial of degree 1 or 2 is a unique translate `τ_x(a)` of a unique representative `a`. 26 at 7, 62 at 11 |
| **`F(a, a′, t)`** | `canon(a · τ_t(a′))` for representatives `a, a′` and a shift `t ∈ V` — the table through which the big moment matrix is read |
| **`Q(m)`** | the linear form "moment of `q · m`": `2·Σ_x y(m ∪ x) − 2·Σ_x y(m ∪ x ∪ x) − Σ_x Σ_{s∈S} y(m ∪ x ∪ (x+s))` |
| **box product, box row** | `Π_{x∈A} φ_x · Π_{x∈B} (1 − φ_x)` with `|A| + |B| ≤ 4`; its symmetrised moment is ≥ 0 at any `φ ∈ [0,1]^V`. The relaxation uses only `B = ∅` (`y(m) ≥ 0`) and `|B| = 1` (`y(m∖x) − y(m) ≥ 0`); the certificate's one row type admits all of them |
| **cascade** | the producer's rule that absorbs any leftover of either sign into box rows, down to the constant, so that `U` is computed, never guessed (§C.4) |
| **trust word** | main plan §D's closed list, extended by one: `CERTIFIED (fs66_b1_cert_check)` — the checker's word plus the named hand steps of §S, never the kernel |

---

## §M. What has been measured (2026-09-20, planner; full tables and logs: `data/fs66/b1/README.md`)

*Desktop, beside a running Lean build, 2–8 threads. Single runs: prices, not benchmarks. Floating point unless
marked. Venv: **`~/venvs/fs66`** (outside `build/`; created with `--system-site-packages`, then `pip install clarabel scs`).*

| # | what | result |
|---|---|---|
| B1 | full second-level relaxation at 7 (moment blocks, 50 × 50 localisers of `φ_0`, `1 − φ_0` and an edge cut, `q` localiser, box rows), `c = 2` | **14.0034** (need < 16.33), Clarabel 6.7 s. **GO.** |
| B2 | controls at 7: `q` dropped → **24.5000**; `φ² = φ` added (the 0/1 problem) → **14.0000** `= α(G₁)` | both as they must be |
| B3 | ablations at 7: no box rows 14.345; `q` only as the scalar `L(q) ≥ 0` 14.065; no edge localiser 14.0039; no box rows *and* no box localisers **1649.7** (the box rows carry the box) | which parts work |
| B4 | **the minimal relaxation** — moment blocks + `q` localiser + box rows, nothing else — at 7 | **14.0149** (Clarabel 2.9 s; SCS 14.0149, 2.0 s) |
| B5 | the minimal relaxation at **11**: 3,759 moment variables, blocks 63 + 10 × 62 + a 2 × 2, 18,223 scalar rows | **28.2016** Clarabel (4 threads, 635 s, 7.3 GB); **28.2015** SCS (2 threads, **82 s**). Need < 30.25: margin **2.05** |
| B6 | the un-reduced 122 × 122 box localisers at 11 | killed at 6 min: 24 GB, no first iteration. Not needed (B4–B5) |
| B7 | local search at `c = 2` exactly, with the cuts | 7: **14.0000** (60 starts); 11: **28.0000** (200 starts; local maxima 27.998, 27.986, …; fractional *ties* at 28, nothing above). Nulls at a budget |
| B8 | **exact-rounding prototype** (`tools/fs66_b1_probe.py --round 12 --wdigits 9 --shift 1e-6`), duals from SCS at `1e-7` | 7: **`U = 14.01758`**; 11: **`U = 28.22513`** (`4U = 112.90 < 121`); all blocks positive definite exactly; 0.1 s / 1.5 s of exact arithmetic. Outputs `proto-cert-p7.json`, `proto-cert-p11.json` (3,838 rows), since re-emitted in format v2 (§C) |
| B9 | how the rounding fails when it fails | never on the identity; on **positive definiteness**: 6 digits, or no diagonal shift, and blocks fail; a shift applied *after* the basis rescaling cost 0.9 in `U` at 7 (apply it in the solver's basis, §R.2) |
| B10 | one independent control of the prototype's bookkeeping, at 7 | a block's linear form on moments averaged over all 784 group elements equals the brute-force quadratic form to 9 digits, at a pure independent set and at a random fractional feasible point |
| B12 | **the specification has an inhabitant**: a second program written from §C's formulas alone (`data/fs66/b1/planner_spec_inhabitant.py`, standard library, the planner's scratch — not the checker) evaluates (★) on the prototype files | 7: 0 mismatches over 495 canonical monomials, 14 blocks positive definite, 1.6 s; **11: 0 mismatches over 3,760, 22 blocks positive definite, 36 s**; the overclaim `U_num − 1` (one part in 10³⁰) is caught at `[]` |
| B11 | the tightened relaxation at 11 (every box product of degree ≤ 4 and the edge/triangle cuts times monomials of degree ≤ 3, as scalar rows: 198,501 rows) — at 7 this reads **14.0000** | **28.0427** (SCS `1e-6`, 2 threads, 59 s build, 204 s solve): tighter than the minimal 28.2015, **not exact** as at 7. A certificate from it would give `α(UD(ℤ/121,2)) ≤ 3,393` against the pull-back's 3,388. Side reading; not on the path |
| B13 | **falsifier of the hand links** (`tools/fs66_b1_links_test.py`, exact integers, `data/fs66/b1/links-test.out`) | 803 explicit independent sets of levels two and three at (3;2), (3;3), (7;2): **no violation** of `q(φ) ≥ 0`; the pull-back of a level-one set is tight (`q = 0` exactly); Hensel's count asserted |

**Three corrections to what the planner was handed.** (1) *"The relaxation cannot read below the three-point bound, 29.18"* — it
reads 28.20: the second level is stronger than the triple level; its true floor is the second Lasserre level for `α(G₁)`, between
28 and 28.20. (2) *"About eleven blocks of size 62–126 and 122 × 122 multiplier blocks for the box, the cuts and `q`"* — the
blocks are real of size 62–63 (centred representatives make them real), and the 122 × 122 localisers are unnecessary: **the box
lives in scalar rows and the cuts are not needed at all.** (3) *"An extended-precision interior-point solve is what makes
rounding easy"* — the margin does; a first-order solver's double-precision dual rounds with a loss of 0.024.

---

## §F. The formulation

**The problem certified is the BARE problem** `B₁(p) = max {Σφ : φ ∈ [0,1]^V, q(φ) ≥ 0}` with `c = 2`, without the edge and
triangle cuts. Its feasible set contains the feasible set with cuts, so an upper bound for it is an upper bound for the main
plan's registered quantity (`B₁` with cuts, main plan §S5). Chosen because B3–B5 show the cuts buy nothing the certificate needs,
and every constraint left out is one fewer thing for a reviewer to believe valid at every level.

**The relaxation** (the producer's business; nothing in it is on the trust surface). Unknowns: one real `y_k` per `Γ`-orbit of
monomials of degree ≤ 4 (`K` = 495 at 7, 3,760 at 11), `y([]) = 1`. Maximise `n·y([0])` subject to:

1. **the moment matrix is positive semidefinite**, read in the translation-Fourier basis: for the trivial character the matrix on
   `{1} ∪ {ā}` (`ā` = the average of the translates of representative `a`) with entries `y(a)` and `(1/n)·Σ_t y(F(a,a′,t))`;
   for one character `u` per nonzero norm class (`p − 1` of them; rotations permute the characters of one class and the blocks
   are conjugate) the matrix `B_u[a,a′] = Σ_t cos(2π⟨u,t⟩/p)·y(F(a,a′,t))`. Real and symmetric because the representatives are
   centred and `y` is invariant under `x ↦ −x`, so `F(a,a′,−t) = F(a,a′,t)` (asserted in the probe);
2. **the localiser of `q`**: the 2 × 2 matrix `[[Q([]), Q([0])], [Q([0]), (1/n)Σ_t Q([0,t])]]` is positive semidefinite, and
   `Σ_t cos(2π⟨u,t⟩/p)·Q([0,t]) ≥ 0` for each class representative `u`;
3. **the box rows**: `y(m) ≥ 0` for every orbit, and `y(m ∖ x) − y(m) ≥ 0` for every orbit and every point `x` of its canonical
   monomial.

Sizes: 7 → blocks 27, 6 × 26, 2; 2,288 scalar rows. 11 → blocks 63, 10 × 62, 2; 18,223 scalar rows. **Available and unused**
(each only tightens; `tools/fs66_b1_probe.py` has the switches): the box localisers (`--no-boxloc` off), cut localisers, all box
products (`--sa`), cuts times monomials (`--edge-rows`). If a later prime needs a tighter reading, the scalar-row families come
first — they cost rows, not matrices, and the certificate's shape (§C) does not change.

---

## §C. The certificate — what exactly it IS

### C.1 The file (`format: "fs66-b1-cert-v2"`, JSON, **integers only** — a float or a string where an integer belongs is refused)

The certificate is the algebraic statement `U − Σφ = σ₀ + σ₁·q + Σ λ·(box products)` with `σ₀`, `σ₁` sums of squares — and the
file has exactly that shape: **one block type** (a sum-of-squares multiplier of `1` or of `q`), **one row type** (a box product),
one scale.

```
{ "format": "fs66-b1-cert-v2", "p": 11,
  "scale": L,                          integer > 0.  The bound claimed is U = U_num / L
  "U_num": int,
  "weights": [ [c, w_0, ..., w_{n-1}], ... ],     integer vectors on {[]} + V: entry 0 is the weight of the constant
                                                  monomial, then one weight per point index
  "blocks":  [ {"times": "1" | "q", "weights": [i, ...], "R": [[int]]}, ... ],
                                       R symmetric POSITIVE DEFINITE, of size 1 + #reps(times); index 0 is the constant,
                                       index 1 + j the j-th representative.  reps("1") = the representatives of §G
                                       (phi_0, then phi_{-h} phi_h by smaller index of {h,-h}); reps("q") = [phi_0]
  "rows":    [ [A, B, lam], ... ]      lam integer >= 0: the multiplier of the box product  prod_{x in A} phi_x * prod_{x in B} (1 - phi_x),
                                       A and B lists of point indices (repeats allowed), len(A) + len(B) <= 4
}
```

The colour count `m` is **not** in the file: the file proves a bound; whether it refuses `m` colours is the checker's arithmetic
(`m·U_num < p²·L`), asked on the command line. Unknown keys inside a block (the prototype writes `"u"`, the character the
producer had in mind) are comments and ignored. What v1 of this format had and the domain pass removed: two block kinds, a
separate `q0`/`mu`, two row kinds, a `slack` field and three denominators — each was the same object in a second costume (§E).

### C.2 The identity the checker verifies — (★)

For a weight vector `ŵ = [c, w_0, …]` put `σ = Σ_x w_x` and `κ(t) = Σ_x w_x·w_{x+t}` (its autocorrelation, an integer). For a
block, `Y(m)` means the form `y(canon(m))` when `times = "1"` and the form `Q(m)` (§G) when `times = "q"`. With `a, a′` over the
block's representatives and `t` over `V`:

```
T_block(y) = Σ_{ŵ in the block's weights} [  R[0][0]·c²·Y([])  +  2·Σ_a R[0][a]·c·σ·Y(a)  +  Σ_{a,a′} R[a][a′]·Σ_t κ(t)·Y(a · τ_t(a′))  ]
box(A,B)(y) = Σ_{T ⊆ positions of B} (−1)^{|T|}·y(canon(A ∪ B_T))

(★)   U_num·y([]) − L·n·y([0])  =  Σ_blocks T_block(y)  +  Σ_rows lam·box(A,B)(y)
```

an equality of **integer** linear forms in the unknowns `y(k)`, `k` a canonical monomial of degree ≤ 4 — coefficient by
coefficient, the constant `y([])` included. Beside (★) the checker verifies: `L > 0` (**a non-positive scale would flip the
inequality** — the one adversarial file the type alone does not exclude); every `R` symmetric, of the right size, and positive
definite (exact fraction-free elimination, every leading minor > 0); every `lam ≥ 0`; every index in range.

*What the producer puts there (not the checker's concern):* weight 0 is all ones (`c = 1`): its `times "1"` block is the
trivial-character block with the constant row, its `times "q"` block the 2 × 2 localiser of `q`. Each nonzero character class
gets two weights `[0, round(10⁹cos)]`, `[0, round(10⁹sin)]` sharing one block `R = [[1, 0], [0, R_b]]` (the constant row is
multiplied by `c = 0` and costs nothing) and one `times "q"` block `[[1, 0], [0, mu]]` when `mu > 0`. At 11: 21 weights,
22 blocks, 3,838 rows, 775 KB.

### C.3 Why each term is nonnegative at a feasible point — and why the weights are NOT trusted

Let `ȳ` be the symmetrised moments of a feasible `φ` (§S.3). Index monomials of degree ≤ 2 as `[]` and `(x, a) ↔ τ_x(a)`. For a
weight vector `ŵ` let `E_ŵ` be the matrix from the block's index set to that monomial space with `E_ŵ[[], 0] = c` and
`E_ŵ[(x, a), a] = w_x`. Then `T_block(ȳ) = Σ_ŵ ⟨E_ŵ R E_ŵᵀ, M⟩` where `M` is the moment matrix of `ȳ` (for `times "1"`) or the
moment matrix of `q·ȳ` on monomials of degree ≤ 1 (for `times "q"`), using only that `ȳ` and `Q` are translation-invariant.
`E R Eᵀ` is positive semidefinite for positive definite `R` **whatever the integers in `ŵ` are**. The producer takes them to be
rounded cosines and sines because that makes `U` small — a fact about the producer, exactly as in FS-50
(`plans/FS50-certificate-soundness.md` §7). Wrong weights, a wrong block structure, a wrong table *in the producer*: each can
only weaken `U`. Likewise the representatives need not be "centred" for soundness: any list of monomials of degree ≤ 2 indexes
a (possibly repeated) principal submatrix of the moment matrix. A box product of numbers in `[0, 1]` is nonnegative, so its
symmetrised moment is.

### C.4 The cascade — `U` is an output, and the rounding cannot fail to produce an identity

After rounding the blocks and the solver's own row multipliers (negative ones clipped to zero), compute the linear form still
owed, `need(y) = −n·y([0]) − (all T terms) − (rounded rows)`, and walk the canonical monomials **by decreasing degree**: a
positive coefficient is paid by the row `[m, [], ·]` (the moment of `m` is ≥ 0); a negative one by `[m ∖ x, [x], ·]` with `x` the
last point of `m` (`y(m∖x) − y(m) ≥ 0`), which moves the debt to `canon(m ∖ x)`, one degree down. At the constant,
`U_num := −need([])`. With integer blocks and one scale every leftover is an integer, so the rows' multipliers are too. Every step is a maximum against zero, so **any**
rational positive definite blocks yield a valid certificate for *some* `U`; rounding is scored by the bound it proves, never by a
residual (FS-50 §5's rule, transplanted). Measured loss: 0.0027 at 7, 0.024 at 11 (B8).

---

## §S. Why the certificate proves the statement — the reviewer's page

*Self-contained; the implementer lifts it to `data/fs66/b1/SOUNDNESS.md` and keeps it in step with the checker. The checker
checks §C.2; this page is what turns §C.2 into the sentence of §ST. Each link is elementary and hand-checkable.*

**S.1 The spectrum above level one (L1).** `G_k = Cay((ℤ/p^k)², S_k)`. *Hensel:* each point of `S_j` has exactly `p^{k−j}` lifts in
`S_k` (the gradient `(2x, 2y)` of `x² + y² − 1` is nonzero modulo `p` on the circle), so `|S_k| = p^{k−1}(p+1)`. For `k ≥ 2`,
`N = {1 + p^{k−1}·i·a : a ∈ 𝔽_p}` is a subgroup of the circle group `S_k` (norm `1 + p^{2k−2}a² ≡ 1`, as `2k − 2 ≥ k`), so `S_k` is a
union of cosets `sN = {s + p^{k−1}a·(i·s) : a ∈ 𝔽_p}`. Let `χ_u` be a character with `ū := u mod p ≠ 0` ("exact level `k`"). On a
coset, `Σ_a χ_u(s + p^{k−1}a·is) = χ_u(s)·Σ_a e(a·⟨ū, i·s̄⟩/p)`, which is `0` unless `⟨ū, i·s̄⟩ = −ū₁s̄₂ + ū₂s̄₁ = 0`, i.e. `s̄` lies on the
line through `ū`; that line meets `S₁` in at most two points, which have `2p^{k−1}` lifts, i.e. `2p^{k−2}` cosets, each
contributing modulus `p`: **`|λ_u(G_k)| ≤ 2p^{k−1}`.** A character of exact level `j`, `2 ≤ j < k`, factors through level `j` and
`λ_u(G_k) = p^{k−j}·λ_u(G_j)` (Hensel's count again): the same bound. The characters of exact level ≤ 1 span exactly the
fibre-constant functions, so **every eigenvalue of `A_k` on the orthogonal complement of the fibre-constant functions is
`≥ −2p^{k−1}`.** *(Surjectivity of `S_k → S_{k−1}` is not used — the obligation pass removed it. Checked by FFT at (3; 2–4),
(7; 2–3), (11; 2): main plan §M7, owner's `depth-spectrum.out`.)*

**S.2 The inequality (L2).** `I` independent in `G_k`, `k ≥ 2`; `φ(x)` = share of the fibre over `x` in `I`. `1_I = Pφ + g`,
`Pφ` fibre-constant, `g` orthogonal to fibre-constant functions; the adjacency operator preserves both parts. `⟨Pφ, A_k Pφ⟩ =
p^{3(k−1)}·⟨φ, A₁φ⟩`; `‖g‖² = p^{2(k−1)}·Σφ(1−φ)`; `⟨g, A_k g⟩ ≥ −2p^{k−1}‖g‖²` by S.1. Independence is `⟨1_I, A_k 1_I⟩ = 0`, so
`⟨φ, A₁φ⟩ ≤ 2Σφ(1−φ)`, i.e. `q(φ) ≥ 0`, and `|I| = p^{2(k−1)}·Σφ`. For `k = 1`, `φ = 1_I` is 0/1 and `q(φ) = −⟨φ,A₁φ⟩ = 0`. So:
**every independent set of every level gives a feasible `φ` with `|I| = p^{2(k−1)}Σφ`.**

**S.3 Symmetrised moments (L3).** Let `Γ` be the group **generated by** the translations and the linear maps the checker verified
(step 3 of §K.2: bijections `h` with `h(x+s) − h(x) ∈ S` for all `x`, `s` — a property closed under composition, so closure of
the list is never needed). For such `γ`, `s ↦ γ(x+s) − γ(x)` is an injection `S → S`, hence a bijection, so `q(φ∘γ) = q(φ)`,
`Σ(φ∘γ) = Σφ` and `φ∘γ ∈ [0,1]^V`. For feasible `φ` put `ȳ(m) = |Γ|⁻¹·Σ_{γ∈Γ} Π_{x∈m} φ(γx)`. Then: `ȳ([]) = 1`; `n·ȳ([0]) = Σφ` (translations are transitive); `ȳ(γm) = ȳ(m)`;
`ȳ(m) ≥ 0` and `ȳ(m∖x) − ȳ(m) ≥ 0` (a product of numbers in `[0,1]`, times `1 − ψ_x ≥ 0`); for any positive semidefinite `𝒵`
indexed by monomials `m_i`, `Σ 𝒵_ij·ȳ(m_i m_j) ≥ 0` (an average of `vᵀ𝒵v`); and with `Q`, `Σ 𝒵_ij·Q(m_i m_j)(ȳ) = q(φ)·Σ 𝒵_ij·ȳ(m_i m_j)
≥ 0` because `q(φ∘γ) = q(φ) ≥ 0`.

**S.4 The identity (L4).** Evaluate (★) at `y = ȳ`. Left side: `U_num − L·Σφ` (S.3: `ȳ([]) = 1`, `n·ȳ([0]) = Σφ`). Right side:
each `T_block(ȳ) = Σ_ŵ ⟨E_ŵ R E_ŵᵀ, M⟩ ≥ 0` (§C.3 — the rewriting of `Σ_{x,x′} w_x w_{x′}·ȳ(τ_x a·τ_{x′} a′)` as `Σ_t κ(t)·ȳ(a·τ_t a′)`
uses only `ȳ(τ_x m) = ȳ(m)`; for `times "q"`, `Q(m)(ȳ) = q(φ)·ȳ(m)` and `q(φ) ≥ 0`), each `lam·box(A,B)(ȳ) ≥ 0`. So
`U_num − L·Σφ ≥ 0`, and **because `L > 0`**, `Σφ ≤ U_num/L = U`. (★) is checked on canonical monomials; since `canon(m) ∈ Γm` and
`ȳ` is `Γ`-invariant, equality of the integer coefficient vectors implies equality at `ȳ`. *The division by `L` is the only place
the sign of the scale is used — which is why `NONPOSITIVE_SCALE` is a refusal and not a formatting nicety.*

**S.5 Positive definiteness (L5).** Two theorems are relied on: *Sylvester* (a symmetric real matrix with all leading principal
minors positive is positive definite) and *Bareiss* (in fraction-free elimination without pivoting the `k`-th pivot **is** the
`k`-th leading principal minor, and every division is exact). A reader who wants neither runs `--ldl`: the checker then computes
`R = L·D·Lᵀ` in exact rationals, **re-multiplies and compares with `R`**, and checks `D > 0`; then `xᵀRx = (Lᵀx)ᵀD(Lᵀx) > 0` is two
lines with no named theorem, and the elimination code itself is off the trust surface. The self-test runs both on every block
of a real certificate and demands the same verdict and `D_k = minor_k/minor_{k−1}` (§K.3 twin (c)).

**S.6 The count (L6).** By S.2 and S.4, `α(G_k) ≤ U·p^{2(k−1)}` for every `k ≥ 1`. An `m`-colouring of `G_k` covers `p^{2k}` points
with `m` independent sets, so `p^{2k} ≤ m·U·p^{2(k−1)}`, i.e. `p² ≤ mU`. **If `m·U < p²`, no `G_k` is `m`-colourable.** Also, `G_k`
being vertex-transitive, `χ_f(G_k) = p^{2k}/α(G_k) ≥ p²/U` at every level.

**S.7 Where each obligation is discharged — decided once, here.**

| obligation | discharged by | rung |
|---|---|---|
| (★), positive definiteness, signs, `L > 0`, the maps are symmetries, `m·U_num < p²·L` | the checker, every run, exact integers | **checked** |
| the fast bookkeeping equals the definition (canonical forms; the `κ` route; Bareiss) | `--self-test`'s three twins, each seen red once | **tested** |
| L1–L2 are not false | `tools/fs66_b1_links_test.py`: the inequality in exact integers on explicit independent sets of levels two and three (803 sets at (3;2), (3;3), (7;2): no violation; the pull-back is tight, `q = 0`), and the FFT spectra; **an example can falsify, never verify** | **tested (falsifier)** |
| L1–L6 are true | §S, by hand — elementary, each link ≤ 8 lines | **paper** |
| the clopen and measure statements of §ST | main plan §S2, by hand | **paper** |
| nothing | — | **assumed** |

*A consequence that doubles as the chain's sharpest falsifier:* at 7 the bound gives `α(UD(ℤ/49, 2)) ≤ ⌊14.0176 × 49⌋ = 686`, and
the pull-back of a 14-set has 686 points — so **`α(UD(ℤ/49, 2)) = 686` exactly**, which settles the main plan's §I6 (its killing
test of "the tower never rises" cannot fire at level two of 7) and means **a verified independent set of 687 points there would
refute this phase's hand links or its checker.** At 11: `3,388 ≤ α(UD(ℤ/121, 2)) ≤ ⌊28.2251 × 121⌋ = 3,415`.

---

## §ST. The statement the certificate licenses, in words — and what it does not say

> **At `p = 11`: for every `k ≥ 1`, every independent set of `UD(ℤ/11^k, 2)` has at most `U·121^{k−1}` points with
> `U = 28.2251…` (the exact rational in the file); hence no level of the tower is four-colourable, the chromatic number of every
> level is exactly 5, the clopen chromatic number of `ℤ₁₁²` is 5 (main plan §S2), the fractional chromatic number of every level
> lies in `[121/U, 121/28] = [4.2869, 4.3215]`, and the supremum of the Haar measure of a measurable independent set of `ℤ₁₁²`
> lies in `[28/121, U/121] = [0.23140, 0.23327]`.** At `p = 7` the same with `U = 14.0176`, three colours, `χ = 4`,
> `χ_f ∈ [3.4956, 3.5]`.

**What each clause rests on** (trust word for the sentence: `CERTIFIED (fs66_b1_cert_check)` + the hand links named; never the kernel):

| clause | rests on |
|---|---|
| `α(G_k) ≤ U·p^{2(k−1)}` for every `k ≥ 1`; no level is `m`-colourable | the checker's `CERTIFIED` + L1–L6 |
| `α(UD(ℤ/49, 2)) = 686` exactly; `3,388 ≤ α(UD(ℤ/121, 2)) ≤ 3,415` | the same + an **explicit** level-one independent set of 14 (28) points, committed and verified from the definition (Phase 2B) — only `α(G₁) ≥ 28` is used, never FS-54's `α(G₁) = 28` |
| `χ(G_k) = 5` at 11 (`= 4` at 7) | the first clause + the pull-back of a level-one colouring (kernel at 11: `chromaticNumber_finitePlane11`; at 7 `[Moorhouse2010]`'s value, a verified 4-colouring suffices) |
| `χ_f(G_k) ∈ [p²/U, p²/α(G₁)-set]` | the first two clauses + vertex-transitivity of a Cayley graph |
| the clopen chromatic number; the Haar-measure bracket | the above + main plan §S2 (clopen colourings are colourings of some level; the more-than-half-filled cosets of a measurable independent set are independent, and Lebesgue density) — **hand, the main plan's, not re-derived here** |

**It does not say:** anything about the plain (non-clopen) `χ(ℚ₁₁²)` or about any number field's plane beyond the ceiling staying
5 (main plan §S2: the local–global conjecture lives at the link this does not touch); anything at `(23, 5)` (out of reach, main
plan §Q4); that `B₁ = α(G₁)` (the main plan's §S5 conjecture stays a conjecture — `U` is 0.8 % above 28).

---

## §K. The checker — `tools/fs66_b1_cert_check.py`

**Standard library only; imports nothing from `tools/`; shares no code with the producer or the probe; reads no float.** It is
written from THIS section and §C, not by porting `tools/fs66_b1_probe.py` — independence of the bookkeeping is the point, and the
prototype's files are its first test inputs, so a disagreement is informative whichever side is wrong.

### K.1 Interface

```
fs66_b1_cert_check.py CERT.json --m M        ->  last line, exit status
fs66_b1_cert_check.py --self-test            ->  one GREEN/RED row per control, exit 0 iff all as designed
```

Last line is exactly one of: `CERTIFIED: …` (exit 0) — (★) holds, everything is signed and positive definite, **and**
`M·U < p²`; `BOUND ONLY: …` (exit 3) — the file is a valid proof of `Σφ ≤ U`, but `M·U ≥ p²`, so it refuses nothing at `M`
colours (the reachable uninformative outcome: `--m 5` at 11, `--m 4` at 7 must end here); `REFUSED <CODE>: <detail>` (exit 1).
Usage errors exit 2. The `CERTIFIED` sentence states `p`, `M`, `U` as an exact fraction and to 6 decimals, `M·U` against `p²`,
the file's SHA-256, and the words "given the hand-proved links L1–L6 of plans/FS66-phase2-certificate.md §S; NOT the Lean kernel".

### K.2 What it does, in order of marginal evidential value (cheap and decisive first)

1. Parse strictly: format string, every number a JSON integer (`NOT_AN_INTEGER` — a float, a string, a boolean), shapes and
   index ranges (`MALFORMED`), `p` prime and `≡ 3 (mod 4)` (`BAD_PRIME`).
2. Signs: `scale > 0` (`NONPOSITIVE_SCALE`); every row multiplier `≥ 0` (`NEGATIVE_MULTIPLIER`).
3. Rebuild from `p` alone: points, `S`, the `2(p+1)` linear maps, **and verify each is a bijection with `h(x+s) − h(x) ∈ S` for
   all `x, s`** (`NOT_A_SYMMETRY` — cannot fire on its own construction; it is the guard of the one property soundness needs).
4. Rows: `A`, `B` lists of valid point indices with `len(A) + len(B) ≤ 4` (`ROW_MALFORMED`).
5. Positive definiteness of every `R` by fraction-free elimination (`BLOCK_NOT_POSITIVE_DEFINITE`, naming the block and the
   first non-positive minor).
6. Build the autocorrelations `κ`, the products `a·τ_t(a′)` and the `Q` forms; accumulate the right side of (★) in integers per canonical monomial; compare
   with the left (`IDENTITY_MISMATCH`, naming the canonical monomial and both coefficients — the constant first, because that
   is where an overclaimed `U` shows).
7. `M·U_num < p²·scale` in integers → `CERTIFIED`, else `BOUND ONLY`.

**Why `canon` cannot make a false certificate pass.** `canon(m)` is computed as an explicit image of `m` under a translation
followed by a verified symmetry, so two monomials are merged only if they really are `Γ`-equivalent; *failing* to merge
equivalent monomials only makes (★) stricter. So an incomplete canonicaliser is safe and a wrong-merging one is impossible by
construction — say this in the checker's docstring.

Cost at 11 (pure Python): ≈ 0.6 M canonicalisations (memoised), 2.6 M big-integer multiply-adds, 22 eliminations of size ≤ 63:
**36 s, measured on the planner's from-the-spec evaluator (B12)**; the checker adds parsing, the symmetry guard and messages [P-B3].

### K.3 Controls (`--self-test`) — each red for a named reason, beside a faithful twin that stays green

Every plant is applied to a **copy** of a certifying file (`proto-cert-p7.json` until the production file exists), the twin —
the same file re-serialised through the same scaffolding, no fault — is run beside it, and after the last plant the original is
re-checked and its SHA-256 compared (a harness must verify its own restore). Expected last lines:

| # | plant | must end on |
|---|---|---|
| 0 | faithful twin | `CERTIFIED` (at 7 with `--m 3`) |
| 1 | `U_num` lowered by 1 (one part in 10³⁰ of `U`) | `REFUSED IDENTITY_MISMATCH` at `[]` — **the overclaim, the fault that matters most** |
| 2 | `U_num` raised by `scale` (the bound weakened by 1) **and** the row `[[], [], scale]` added (`1 ≥ 0`, multiplier 1) | `CERTIFIED` — a weaker true claim must pass (the plant's both-sides bound) |
| 3 | `U_num` raised by `scale`, no row added | `REFUSED IDENTITY_MISMATCH` |
| 4 | one diagonal entry of a character block negated | `REFUSED BLOCK_NOT_POSITIVE_DEFINITE` |
| 5 | a character block replaced by a symmetric matrix with a zero eigenvalue and positive diagonal | `REFUSED BLOCK_NOT_POSITIVE_DEFINITE` (semidefinite is refused: Sylvester's strict form is what is checked) |
| 6 | a row multiplier's sign flipped, identity repaired by hand elsewhere | `REFUSED NEGATIVE_MULTIPLIER` |
| 7 | a row with `len(A) + len(B) = 5`; a row with a point index `n` | `REFUSED ROW_MALFORMED` |
| 7b | `scale` and `U_num` and every `R` and `lam` negated (the identity still holds; the inequality is flipped) | `REFUSED NONPOSITIVE_SCALE` — the adversarial file the domain pass found |
| 8 | one integer replaced by the float `1.0`; another by the string `"1"` | `REFUSED NOT_AN_INTEGER` |
| 9 | a certificate produced for the WRONG problem, `c = 1` (`fs66_b1_probe.py … --c 1`; a stronger, false constraint) | `REFUSED IDENTITY_MISMATCH` — the checker has no `c` to read; `q` is rebuilt with 2 |
| 10 | the 7 file checked with `--m 4`; the 11 file with `--m 5` | `BOUND ONLY` (exit 3) — both are colourable at every level, so `CERTIFIED` here would be a false theorem |
| 11 | the 7 file with its `"p"` edited to 11; to 5; to 9 | `REFUSED MALFORMED` (lengths); `BAD_PRIME`; `BAD_PRIME` |
| 12 | weights replaced by arbitrary integers, `U` and rows recomputed by the producer | `CERTIFIED` or `BOUND ONLY` with a larger `U` — **never refused**: shows the weights are off the trust surface |

**Three independent twins of the bookkeeping, run in `--self-test`.** (a) *Orbit twin:* at `p = 3` and `p = 7`, canonical forms
against brute-force orbits (apply all of `Γ` to every monomial of degree ≤ 4, union-find): same partition. (b) *Assembled twin:*
at `p = 3`, build the full matrices `Σ_ŵ E_ŵ R E_ŵᵀ` (§C.3) and the moment matrix of symbols explicitly, read the
coefficient of every canonical monomial by brute force over all index pairs, and compare with the `F`/`κ` route — the path the
fast code never takes. (A `p = 3` certificate: the producer at `p = 3`, `m = 2`; if `B₁(3)`'s relaxation does not refuse two
colours the file ends `BOUND ONLY`, which serves the twin equally.) (c) *Elimination twin:* on every block of the `p = 7` file, and on
three planted matrices (indefinite with a positive diagonal; singular positive semidefinite; a 1 × 1 zero), the Bareiss verdict
against the re-multiplied rational `L·D·Lᵀ` of §S.5 — same verdict, and `D_k = minor_k/minor_{k−1}`. `--ldl` runs the slow route
on every block of any file (expect minutes at 11: the rationals reach ~2,000 digits).

---

## §R′. The producer — `tools/fs66_b1_cert_make.py` (untrusted; may use numpy, scipy, scs, clarabel)

1. **Build and solve** the minimal relaxation of §F (the probe is the recipe; keep its controls `--no-q` → `n/2`-ish and
   `--pure` → `α`). **Solver: SCS 3.3, `eps 1e-7`, double precision, 2–4 CPU threads** — 83 s at 11; Clarabel as the second
   opinion on the value only (its KKT system is 7 GB at 11; do not give it matrix localisers). *No GPU:* the per-iteration work is
   eleven 62 × 62 eigendecompositions and one cached sparse solve — nothing a GPU helps. *No extended precision:* the margin is
   2.05 and the measured rounding loss 0.024.
2. **Round** (B8–B9): take the dual blocks `Z`; add `shift·max(diag Z)·I` **in the solver's basis**; rescale by the congruence
   that turns the solver's normalisation into §C.2's (all-ones weight: `diag(1, 1/n, …)`; character blocks `1/√n`; the 2 × 2
   of `q`: `diag(1, 1/n)`; `mu = dual/n`); multiply by `D = 10^{12}` and round to integers; weights `round(W·cos)`,
   `round(W·sin)` with `W = 10⁹`; the file's `scale` is `D·W²`, and the all-ones blocks are multiplied by `W²` to sit on it.
   Check positive definiteness exactly; on failure raise the shift (×10) and retry; record every attempt.
3. **Rows and cascade** (§C.4), then write the file and a record.
4. **Scan** `shift ∈ {1e-7, 1e-6, 1e-5}` × `D ∈ {10¹⁰, 10¹²}` and keep the smallest `U` whose blocks are all positive definite.
   There is no reason to chase digits: anything under 28.3 is as good as 28.21.

Every run appends one record to `data/fs66/b1/records.jsonl` (main plan §D's discipline — flat, typed, a trust word):
`{"kind": "fs66-b1", "record_version": 1, "utc", "command", "tool_sha256", "p", "c": 2, "relaxation": "minimal", "solver",
"solver_eps", "threads", "float_value", "float_dual", "iterations", "solve_s", "rss_mb", "digits", "weight_digits", "shift",
"pd_failures": [...], "U_num", "scale", "U_float", "rows", "cert": "<path>", "cert_sha256", "machine", "trust": "float reading
(untrusted)" | "prototype bound (producer's own arithmetic, untrusted)" | "CERTIFIED (fs66_b1_cert_check)"}`. The producer never
writes the third word; only a checker run does (a second record, `"kind": "fs66-b1-check"`, carrying the checker's last line, its
exit status, its SHA-256, `m`, and wall seconds).

---

## §P. Registered predictions (2026-09-20, before any implementer phase; scored in §R)

| id | prediction | confidence | what would refute it | both outcomes reachable? |
|---|---|---|---|---|
| P-B1 | the independent checker ends `CERTIFIED` on a certificate at 11 with **`U` in [28.20, 28.30]**, `--m 4` | high | a refusal that is not a plant — then the prototype's bookkeeping and the checker's disagree, and finding which is wrong is the phase's most valuable hour | yes: the prototype is self-consistent but has never been checked by other code |
| P-B2 | the checker's **first** run on `proto-cert-p7.json` does *not* certify, because of a convention read differently from §C (representative order, which factor of `a·τ_t(a′)` is translated, sub-multisets of `B`) rather than a mathematical error — *registered at medium before B12; after B12 showed §C executable as written by a second program, the planner holds it at* | low-medium | a first-run `CERTIFIED` (then §C was unambiguous) | yes |
| P-B3 | checker wall time at 11 **under 3 minutes**, pure Python, under 1 GB (the planner's bare evaluator: 36 s, B12) | medium-high | over 10 minutes — a reviewer's patience is part of the trust surface; find what the evaluator does not do | yes |
| P-B4 | plant 12 (arbitrary weights) yields `U > 40` at 11 — sound and useless | high | a refusal (the weights would be on the trust surface: a design error) | yes |
| P-B5 | the tightened relaxation at 11 (B11) reads **28.00 ± 0.02** — the relaxation is exact at 11 as at 7 | low-medium | a reading above 28.05 | yes; the run is cheap. **Scored by the planner the same evening: NOT MET — 28.0427.** Outside the predicted band though under the named refutation line; the honest reading is that the tightened second level is *not* exact at 11 |
| P-B6 | at 19 (Phase 2C, if run) the minimal relaxation reads **in [80.6, 87]** and a certificate lands under 90.25 | low-medium — no measurement at 19 | a reading ≥ 90.25 (the second level is not enough at 19), or a build that does not fit (then §19's reductions are owed first) | yes |

---

## §X. Checkpoints, costs, hardware

| run | cost [status] | if it dies now, what is redone? |
|---|---|---|
| producer at 7 / 11 | 3 s / ≈ 100 s incl. build [measured] | everything; under the 15-minute rule's threshold |
| checker at 7 / 11 | seconds / 2–5 min [estimated] | everything; same |
| `--self-test` | the `p = 7` orbit twin dominates: 292,825 monomials × 784 group elements, pure Python — **10–30 min [estimated]**. Cache nothing; if over 15 minutes in practice, restrict the orbit twin at 7 to monomials through the origin (every orbit has one) and say so in the docstring | the self-test; acceptable |
| Phase 2C at 19 | build ≈ 30–60 min single-thread unless vectorised; solve 1–3 h on CPU with SCS's indirect solver, or minutes on the GPU build of SCS (`build/venv-sdp-gpu`, keyword `linear_solver=`; **this is the one place a GPU is appropriate**) [all estimated] | **must checkpoint**: cache `F` and the `Q` forms to `data/fs66/ckpt/b1-p19/` (never under `build/`); drive SCS in warm-started chunks saving `(x, y, s)` per chunk, as `tools/fplane_sdp_scs.py` does; resume command written in the docstring and in §R before launch; never under a `timeout` wall |

Nothing in Phases 2A–2B needs more than 4 threads and 8 GB. One heavy job at a time; ask the owner before Phase 2C's solve.

---

## §19. The price of the same certificate at `p = 19`, four colours (needs `U < 90.25`)

Sizes after the same reduction: `n = 361`, `|Γ| = 14,440`, 182 representatives, **19 real blocks of size 182–183** plus the 2 × 2,
about 55,000 moment variables (orbits of monomials of degree ≤ 4), roughly 300,000 box rows, and a constraint matrix near 10⁸
nonzeros. The same producer and checker code serves unchanged in shape; what changes is cost: the pure-Python canonicaliser
(6 M + 3 M calls) wants vectorising or the rooted shortcut, SCS must run with its indirect (or GPU) linear solver and
checkpointed chunks, the checker's exact accumulation grows to ≈ 10⁸ big-integer operations (tens of minutes), and splitting
each block by the reflection that fixes its character (182 → 91 + 91) halves all of it if needed. The reading is unmeasured:
it cannot be below FS-62's level-3 value 80.59 and the best set known is 76, so the expected margin is 4–10 % — comparable to
11's 6.8 %. **Worth a phase (2C) after 11 lands, not before**: it would make 19 the second prime whose whole tower is decided,
and it subsumes main plan §I5's level-two ask at `(19, 4)` exactly as 11's certificate subsumed level three. It is P-B6.

---

## §H. Phases for the implementer — each well under 400k tokens; one brief each

*Rules that bind every phase (from `CLAUDE.md` and the main plan §H): no child agents of any kind; never `lake build` (no Lean
is touched in this phase); kill by PID and verify by effect; venvs and checkpoints outside `build/`; commit by explicit path;
a probe that reports nothing because it could not run reads like a slow solver — check the artifact exists and is non-empty.*

### Phase 2A — the checker, its soundness page, its controls (the trusted half; do this FIRST, from §C, §S, §K — not from the probe)
*Scoring (the owner runs these):* `python3 tools/fs66_b1_cert_check.py data/fs66/b1/proto-cert-p7.json --m 3; echo $?`;
the same at 11 with `--m 4`; `--m 5` at 11 must exit 3; `python3 tools/fs66_b1_cert_check.py --self-test; echo $?`;
`grep -c "^import\|^from" tools/fs66_b1_cert_check.py` against a standard-library list.
- [ ] `tools/fs66_b1_cert_check.py`: standard library only, no float read, §K.1's three last lines and exit codes.
- [ ] `--self-test` runs plants 0–8, 10, 11 of §K.3 on a copy, each ending on the named line, the faithful twin green beside
      each, and the restore verified by digest. (Plants 9 and 12 need the producer: Phase 2B.)
- [ ] The orbit twin at 3 and 7, the assembled twin at 3 and the elimination twin are green — and each has been **seen red
      once** on a deliberate break (say which break in §R). `--ldl` agrees with the default route on `proto-cert-p11.json`.
- [ ] `python3 tools/fs66_b1_links_test.py 7 2 400; echo $?` ends `NO VIOLATION`, exit 0 (the planner's falsifier of L1–L2 —
      kept as is; extend it only by adding families of independent sets, e.g. the best sets a local search on level two finds).
- [ ] `data/fs66/b1/SOUNDNESS.md` lifted from §S, with the checker's actual refusal codes; every sentence of it re-read against
      the code ("what must someone who trusts none of this actually check?").
- [ ] P-B1 (on the prototype file), P-B2, P-B3 scored in §R; any disagreement with the prototype resolved **and its cause
      written down** — if §C of this file was ambiguous, fix the sentence here in the same commit.

### Phase 2B — the production producer, the certificates, the records
*Scoring:* `data/fs66/b1/cert-p7.json` and `cert-p11.json` exist; `records.jsonl` has a `fs66-b1` record and a `fs66-b1-check`
record for each whose `cert_sha256` match the files; the 11 check record's last line starts `CERTIFIED` with `m = 4`.
- [ ] `tools/fs66_b1_cert_make.py` (§R′) with its two float controls reproduced at 7 (`q` dropped → 24.5; `φ² = φ` → 14.0).
- [ ] The scan of §R′.4 recorded; the kept certificate at 11 has `U < 28.3`; both certificates `CERTIFIED` by Phase 2A's checker.
- [ ] Plants 9 (`c = 1`) and 12 (arbitrary weights) added to `--self-test`'s documented manual controls with their outputs in
      `data/fs66/b1/controls.out`; P-B4 scored.
- [ ] An explicit independent set of 28 points of `UD(𝔽₁₁, 2)` and of 14 points of `UD(𝔽₇, 2)` committed
      (`data/fs66/b1/level-one-sets.json`) with a standard-library verification from the definition — the lower halves of §ST's
      brackets rest on these and on nothing else.
- [ ] `data/fs66/b1/README.md` extended: what each file is, what it licenses (§ST's sentence verbatim), its trust word.
- [ ] B11 / P-B5 recorded if not already.

### Phase 2C — 19 at four colours (optional; the owner's call after 2B; §19, §X)
- [ ] The builder's cost measured on a sample before the full build; caches under `data/fs66/ckpt/b1-p19/`; the float reading
      recorded **before** any rounding; P-B6 scored; a certificate `CERTIFIED` with `--m 4`, or a typed null saying which of
      "reads ≥ 90.25", "did not fit", "rounded but not positive definite" happened.
- [ ] The solve resumed from a checkpoint at least once on purpose.

### The close is the owner's. The implementer hands over: §R filled; the sweep of this file for "conjecture" and "not claimed"
(one: §ST's last sentence points at the main plan's §S5); and §PA below read back for what it taught about the object.

---

## §PA. Prior art — what this phase rests on, and what was NOT searched

This phase certifies an inequality minted inside the milestone; the main plan's §PA is the gate for the tower question. The
*method* is prior art and named as such: the moment/sum-of-squares hierarchy (Lasserre; Parrilo), symmetry reduction of invariant
semidefinite programmes (Gatermann–Parrilo; de Klerk–Pasechnik–Schrijver; Bachoc–Gijswijt–Schrijver–Vallentin's survey),
rational rounding of sum-of-squares certificates (Peyrl–Parrilo), and — inside this repository — FS-50's certificate shape
(`plans/FS50-certificate-soundness.md`), from which the "rational weights are off the trust surface" and "`U` is an output"
ideas are taken whole. **These are recalled, not re-read for this plan** (marked so per G50); none is relied on for soundness,
which §S proves from scratch. **Not searched, and owed at the close if §ST's sentence goes into the ledger:** whether the
independence ratio / fractional chromatic number of `UD(ℤ/p^k, 2)` or the measurable independence density of the `p`-adic
plane has been bounded in print (the discipline's words: *measurable chromatic number*, *independence density*, *p-adic
distance graph*, *Cayley graph over ℤ/p^k independence number*; zbMATH `cc:05C15 & ab:"p-adic"`). **What the phase taught
about the object** (for WORKFLOW step 9's sweep): the fibre-density inequality is *strong* — its second-level relaxation pins
the whole tower's independence ratio to within 0.8 % of level one's at 11 and 0.13 % at 7, and at 7 a slightly tighter
relaxation reads `α` exactly; the main plan's §S5 conjecture (the tower never rises) may be *provable* at 7 by an exact
certificate at the optimal face. That is a stub candidate, not this phase.

---

## §T. Traps found while planning

1. **A 122 × 122 localiser per linear constraint is a trap at 11**: 24 GB and no first iteration in Clarabel. The box belongs in
   scalar rows; if a matrix localiser is ever wanted, reduce it by its stabiliser first.
2. **Apply the diagonal shift in the solver's basis, before the congruence rescaling** — after it, the shift is relative to the
   one large entry and cost 0.9 in `U` at 7 (B9).
3. **Six digits are not enough**: the rescaled blocks have entries near `10⁻⁶`; rounding to `10⁻⁶` destroys positive
   definiteness. Use `D ≥ 10¹⁰`.
4. **Clarabel uses every core by default** (`settings.max_threads`), and reports `AlmostSolved` on this problem at `1e-6`; that
   status is fine for a reading and for rounding. SCS agrees to `1e-4`.
5. **The probe's `--edge-rows` builds ≈ 10⁵ rows at 11** and takes several minutes to build in pure Python: a side reading only.
6. **`canon` is memoised on sorted tuples**; without the memo the checker's time triples.
7. **The prototype's own check is not a check** (it shares the producer's `F` table). Do not quote `U = 28.2251` as certified
   anywhere until Phase 2A's checker has said so.

---

## §W. Decisions that were the planner's (choice · alternative · why · confidence)

| choice | alternative weighed | why this one | confidence |
|---|---|---|---|
| **Python-first, hand-rolled symmetry reduction** | Julia `SumOfSquares.jl` + `SymbolicWedderburn.jl` (automatic reduction, `BigFloat` solvers) | the hand reduction is 40 lines once the centred representatives are seen, ran the first time, and yields blocks whose *exact* presentation (rational weights) is what the certificate needs — an automatic Wedderburn basis would have had to be re-expressed for the checker anyway; no new language in the repository | high (it ran: B4–B8) |
| **Certify the bare problem, minimal relaxation** | the registered `B₁` with cuts; the full second level with localisers | reads 28.20 against 30.25 already; every omitted constraint is one fewer validity argument for a reviewer; 24 GB saved | high |
| **Double precision, first-order solver, no GPU at 11** | extended-precision interior point (the owner's sketch); GPU SCS | margin 2.05 against a measured rounding loss of 0.024; 83 s on two threads | high |
| **Positive definiteness by exact elimination on integer blocks** | FS-50's `Z = BᵀB` factor form (positive semidefinite by construction) | blocks are ≤ 63, so elimination costs seconds and the file holds the matrix a reviewer can look at; a factor form would double the file and hide the matrix. The strict form (definite, not semidefinite) is free because the producer shifts the diagonal | medium-high — at 19 (size 183) still seconds; revisit only if a block must be singular, which an exact-face certificate (§PA) would need |
| **The colour count is a command-line argument, not a field of the file** | `"m"` inside the file | the file proves a bound; one file serves `χ`, `χ_f` and the density statement; and the `BOUND ONLY` control (`--m 5`) becomes a one-flag run | high |
| **Checker first, from the specification; the prototype's files as its inputs** | producer first, checker ported from it | the checker is the trusted half and deserves the fresh context and the independent bookkeeping; a disagreement with the prototype is then evidence about one of two independently written programs | medium-high |
| **One block per norm class, no expansion over rotations** | the full `Γ`-invariant multiplier (every character) | for `Γ`-invariant `y` the inner product with one class representative's block equals that with the class average, up to a factor the block absorbs; soundness needs only positive semidefiniteness, which holds either way; the file is 12× smaller | high |
| **19 is priced, not planned in detail** | a full Phase 2C design now | unmeasured reading; the design is 11's with checkpoints; the owner rules after 2B | medium |

---

## §E. The modeling passes (WORKFLOW step 5) — what each changed

**Domain modeling (`debruijn-domain-modeling`, fresh invocation, 2026-09-20).** *The one cut:* what is intrinsic is the algebra —
`U − Σφ = σ₀ + σ₁·q + Σ λ·(box products)`, a degree-4 certificate in the quadratic module of the box and `q`; what was incidental
in format v1 was the producer's SDP showing through. *Ugliness read ("N declarations identical modulo naming"):* the "trivial"
block was a "character" block with all-ones weights plus a constant row; `q0` and `mu` were the same block type one degree down
with `Q` in place of `y`; `nonneg`, `le` and `slack` were the box products with `|B| = 0`, `|B| = 1` and `A = B = ∅`; three
denominators were one scale. **Changed:** format v2 — one block type (`times`, weights with a constant entry, `R`), one row type
(`[A, B, lam]`), integers only over one `scale`; the checker has one formula per term instead of three, and the tightening
family (all box products) became expressible at no cost. *Adversarial member:* every sign negated together — the identity
holds and the inequality flips — so `scale > 0` is a named refusal and a plant (7b). *Exhibit the model of the hypotheses:* the
specification was run as written by a second program on the re-emitted prototype files (B12: 0 mismatches at 7 and 11; the
overclaim `U_num − 1` caught at `[]`). *Placement cut:* the colour count stays outside the file (only some consumers need it);
the character `u` is a comment, not a field (no consumer inspects it). *Not added:* rows of the form `q × box product`, cut
rows, a positive-*semi*definite block form — no ugliness demands them at 11; the last is what an exact-face certificate would
need (§PA) and is named there.

**Obligation modeling (`debruijn-obligation-modeling`, fresh invocation, 2026-09-20).** *The local obligation:* the global
claim ("no level, no colouring") is unenumerable; the chain makes it six local links and one finite check, and the statement
from which it derives is level-free — `∀ φ feasible, Σφ ≤ U` — so no induction on `k` exists anywhere. *Elided steps found and
repaired:* L1 leaned on surjectivity of `S_k → S_{k−1}`; it needs only that `S_k` is a union of cosets of `{1 + p^{k−1}ia}` plus
Hensel's lift count, now explicit. L3 averaged over "the symmetries", a list whose closure nobody checks; it now averages over
the group *generated* by the verified maps, and the verified property is the one closed under composition. L4 hid the division
by the scale; it is now the named place where `L > 0` is used. L5 rested on Bareiss's identity silently; it is named, and given
a trust-minimal twin (`R = LDLᵀ`, re-multiplied). *Partition made once (§S.7):* checked / tested / paper / assumed (nothing).
*Mutation audit of the chain's hypotheses:* drop `q` → 24.5 (B2); drop the box → 1,649 (B3); strengthen `c` to 1 → refused
(plant 9); negate every sign → refused (plant 7b). *An example can falsify:* the hand links got a falsifier
(`tools/fs66_b1_links_test.py`, B13: 803 explicit independent sets above level one, exact integers, no violation, the pull-back
tight) — and the pass noticed that the certificate at 7 **settles the main plan's §I6**: `α(UD(ℤ/49, 2)) = 686` exactly, so a
687-set would now refute this phase rather than a conjecture. §ST gained a clause-by-clause table of what rests on what; its
lower brackets were resting on FS-54's exact `α = 28` where an explicit 28-set suffices — now an artifact in Phase 2B.

*(the remaining pass is appended when committed)*

---

## §R. Results — filled by the implementer, phase by phase (predictions scored here; decisions implementation overturned, in four parts)
