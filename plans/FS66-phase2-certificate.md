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

**The file as something a reviewer opens.** Keys are written in the order above, so the first 300 bytes show the claim. Two
further top-level keys are allowed and ignored by the checker, and it says so in its narration (`note: "producer" and "spec"
are provenance, not checked`): `"spec"`, the fixed string naming this section and the soundness page, and `"producer"`, an
object of provenance (solver, tolerance, digits, shift, the float value, the tool's SHA-256, UTC). **No free-text claim lives
in the file** — prose inside a certificate is a certainty nobody established. Any other unknown top-level key is `MALFORMED`
(it catches `"U_nmu"`). **The instance a person can read whole is `p = 3`**: 9 points, 28 canonical monomials, six blocks of
size ≤ 7, 27 rows, 4 KB (`data/fs66/b1/proto-cert-p3.json`; `U = 3.00011`, so two colours are refused at every level of the
3-adic tower — true and trivial, which is what a worked example should be). `SOUNDNESS.md` walks it.

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

*A consequence that doubles as the chain's sharpest falsifier:* at 7 the bound gives `α(UD(ℤ/49, 2)) ≤ ⌊14.0152 × 49⌋ = 686`, and
the pull-back of a 14-set has 686 points — so **`α(UD(ℤ/49, 2)) = 686` exactly**, which settles the main plan's §I6 (its killing
test of "the tower never rises" cannot fire at level two of 7) and means **a verified independent set of 687 points there would
refute this phase's hand links or its checker.** At 11: `3,388 ≤ α(UD(ℤ/121, 2)) ≤ ⌊28.2043 × 121⌋ = 3,412` (production certificates, Phase 2B; the prototype's figures were 14.0176, 28.2251 and 3,415).

---

## §ST. The statement the certificate licenses, in words — and what it does not say

> **At `p = 11`: for every `k ≥ 1`, every independent set of `UD(ℤ/11^k, 2)` has at most `U·121^{k−1}` points with
> `U = 28.204320…` (the exact rational in `cert-p11.json`); hence no level of the tower is four-colourable, the chromatic number of every
> level is exactly 5, the clopen chromatic number of `ℤ₁₁²` is 5 (main plan §S2), the fractional chromatic number of every level
> lies in `[121/U, 121/28] = [4.2901, 4.3215]`, and the supremum of the Haar measure of a measurable independent set of `ℤ₁₁²`
> lies in `[28/121, U/121] = [0.23140, 0.23310]`.** At `p = 7` the same with `U = 14.015224…`, three colours, `χ = 4`,
> `χ_f ∈ [3.4961, 3.5]`.

**What each clause rests on** (trust word for the sentence: `CERTIFIED (fs66_b1_cert_check)` + the hand links named; never the kernel):

| clause | rests on |
|---|---|
| `α(G_k) ≤ U·p^{2(k−1)}` for every `k ≥ 1`; no level is `m`-colourable | the checker's `CERTIFIED` + L1–L6 |
| `α(UD(ℤ/49, 2)) = 686` exactly; `3,388 ≤ α(UD(ℤ/121, 2)) ≤ 3,412` | the same + an **explicit** level-one independent set of 14 (28) points, committed and verified from the definition (Phase 2B) — only `α(G₁) ≥ 28` is used, never FS-54's `α(G₁) = 28` |
| `χ(G_k) = 5` at 11 (`= 4` at 7) | the first clause + the pull-back of a level-one colouring (kernel at 11: `chromaticNumber_finitePlane11`; at 7 `[Moorhouse2010]`'s value, a verified 4-colouring suffices) |
| `χ_f(G_k) ∈ [p²/U, p²/α(G₁)-set]` | the first two clauses + vertex-transitivity of a Cayley graph |
| the clopen chromatic number; the Haar-measure bracket | the above + main plan §S2 (clopen colourings are colourings of some level; the more-than-half-filled cosets of a measurable independent set are independent, and Lebesgue density) — **hand, the main plan's, not re-derived here** |

**Owner's addendum to the statement (2026-09-21) — the Borel clause, in the literature's own terms.** `[BardestaniMallahiKarai2017]` pose *the p-adic Hadwiger–Nelson problem* for the **Borel** chromatic number of `ℚ_p²` and prove only `O(p²)` from above. The certificate gives exact values: a Borel colour class meets `ℤ_p²` in a measurable independent set, of Haar measure at most `U/p²` by the last clause above, so `χ_Bor ≥ ⌈p²/U⌉`; a level-one colouring pulled back is clopen, hence Borel, and extends over the countably many cosets of `ℤ_p²` in `ℚ_p²` (unit vectors are integral), so `χ_Bor ≤ χ(UD(𝔽_p, 2))`. Hence, once the certificates are `CERTIFIED`: **`χ_Bor(ℚ₇²) = 4` and `χ_Bor(ℚ₁₁²) = 5`** (and `= 3` at 3) — as far as the first planner's gate found, the first exact values of that problem for an anisotropic plane; with the owner's note §7 (`χ_Bor(ℚ_p²) ≥ 1 + (p+1)/(2√p)`, so their Question 1's answer is no) this is the `CLOSED-QUESTIONS.md` candidate of the milestone. Rests on: the measure clause (main plan §S2, hand) + the certificate + L1–L6. **The implementer states this clause in `SOUNDNESS.md` beside the others, with the same trust word; the prior-art re-check (the authors' later papers; zbMATH) is the owner's, at the close.**

**It does not say:** anything about the plain (non-clopen) `χ(ℚ₁₁²)` or about any number field's plane beyond the ceiling staying
5 (main plan §S2: the local–global conjecture lives at the link this does not touch); anything at `(23, 5)` (out of reach, main
plan §Q4); that `B₁ = α(G₁)` (the main plan's §S5 conjecture stays a conjecture — `U` is 0.8 % above 28).

---

## §K. The checker — `tools/fs66_b1_cert_check.py`

**Standard library only; imports nothing from `tools/`; shares no code with the producer or the probe; reads no float.** It is
written from THIS section and §C, not by porting `tools/fs66_b1_probe.py` — independence of the bookkeeping is the point, and the
prototype's files are its first test inputs, so a disagreement is informative whichever side is wrong.

### K.1 Interface — designed from the consumer's side of the wire

*Four consumers, and what each holds when the output arrives.* The **owner** holds an exit status and a last line. A **script**
holds the first word of the last line and a record. A **hostile reviewer** holds the certificate file, the checker's source and
`SOUNDNESS.md`, and nothing else. **The implementer at 19** holds this file. Everything the checker knows and they need must
cross that wire; nothing else should.

```
fs66_b1_cert_check.py CERT.json [--m M] [--ldl] [--record FILE]
fs66_b1_cert_check.py --self-test [--cert CERT.json]
fs66_b1_cert_check.py                  (no arguments: prints these lines with the repository's real paths, exit 2)
```

**The last line always begins with one of four words, and the exit status says the same thing** — never a traceback, never
silence (wrap `main`; Python's own uncaught-exception status is 1, which would read as a refusal):

| first word | exit | meaning |
|---|---|---|
| `CERTIFIED` | 0 | the file is a valid proof of `Σφ ≤ U`; and if `--m` was given, `M·U < p²` |
| `BOUND ONLY` | 3 | the file is valid, `--m M` was given, and `M·U ≥ p²`: *this file does not refuse `M` colours — which says nothing about whether `M` colours suffice* (silence must not read as a positive) |
| `REFUSED <CODE>` | 1 | the file is not a valid certificate; `<CODE>` from the closed list below |
| `ERROR <CODE>` | 2 | the checker could not do its job — `CANNOT_READ` (missing or unparseable file), `USAGE`, `SELF_CHECK_FAILED` (a rebuilt map is not a symmetry: a bug in the checker, never the file's fault), `INTERNAL` (any exception, with its text) |

**The `CERTIFIED` line asserts only what the checker established, and marks the rest as hand links** (a reviewer who reads
"CERTIFIED: no level is 4-colourable" would rightly object that the checker never touched the tower):

```
CERTIFIED: every phi in [0,1]^121 with q(phi) >= 0 has sum(phi) <= U = 28.225133 (exactly U_num/scale of the file, sha256 3f…9a); 4*U = 112.900532 < 121, so BY THE HAND-PROVED LINKS L1, L2, L6 (data/fs66/b1/SOUNDNESS.md) no UD(Z/11^k, 2), k >= 1, is 4-colourable. Standard-library checker, NOT the Lean kernel.
```

Without `--m` the sentence stops after the hash. **Before the last line** the checker narrates, one flushed line per step of
§K.2, in §G's vocabulary and with counts — `step 6/7: identity (★) holds on 3,760 canonical monomials (22 blocks, 3,838 rows)` —
and one progress line per block while accumulating (at 19 a silent half hour is indistinguishable from a hang).

**Refusals carry three things the checker knows at that moment: what, in which space, what next.** Closed list:
`NOT_AN_INTEGER`, `MALFORMED` (shape, index range, an unknown top-level key, a row with `len(A)+len(B) > 4` — the detail names
the JSON path), `BAD_PRIME` (says why: `p` must be a prime `≡ 3 (mod 4)` — the anisotropic case is the only one this plan's group, counts and
statement were written and checked for; nothing here was examined for `p ≡ 1 (mod 4)`), `NONPOSITIVE_SCALE`,
`NEGATIVE_MULTIPLIER`, `BLOCK_NOT_POSITIVE_DEFINITE` (block index, its `times` and weights, size, the first non-positive leading
minor and its index; "next: raise the producer's diagonal shift, §R′.2"), `IDENTITY_MISMATCH` (how many canonical monomials
disagree; the first three by degree with both coefficients; **and, when the only disagreement is at `[]`, the `U_num` the file's
blocks and rows actually support** — knowledge that otherwise dies with the process). Every noun in a message is a §G word.

`--record FILE` appends the check record of §R′ (the checker never writes into the tree unasked: a reviewer's run must leave
`git status` clean). `--ldl` is §S.5's slow route.

### K.2 What it does, in order of marginal evidential value (cheap and decisive first)

1. Parse strictly: format string, every number a JSON integer (`NOT_AN_INTEGER` — a float, a string, a boolean), shapes and
   index ranges (`MALFORMED`), `p` prime and `≡ 3 (mod 4)` (`BAD_PRIME`).
2. Signs: `scale > 0` (`NONPOSITIVE_SCALE`); every row multiplier `≥ 0` (`NEGATIVE_MULTIPLIER`).
3. Rebuild from `p` alone: points, `S`, the `2(p+1)` linear maps, **and verify each is a bijection with `h(x+s) − h(x) ∈ S` for
   all `x, s`** (`ERROR SELF_CHECK_FAILED` — it cannot fire on a correct construction and is never the file's fault; it is the
   guard of the one property soundness needs, and the self-test sees it fire once on a deliberately wrong map).
4. Rows: `A`, `B` lists of valid point indices with `len(A) + len(B) ≤ 4` (`MALFORMED`).
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

Every plant is applied to a **copy** of a certifying file (`--cert`, default `data/fs66/b1/proto-cert-p7.json`), the twin — the
same file re-serialised through the same scaffolding, no fault — is run beside it, **the plant's digest must differ from the
twin's** (a plant that did not apply is invisible wherever the expected word is `CERTIFIED`), and after the last plant the
original is re-checked and its SHA-256 compared (a harness must verify its own restore). Each control prints one row —
`ok   7b  expected REFUSED NONPOSITIVE_SCALE | observed REFUSED NONPOSITIVE_SCALE: scale = -10^30 …` or `FAIL …` followed by the
failing run's whole output — **matching the code in the last line, never the exit status alone** (a checker that crashes on a
malformed plant is a wrong-reason red). The self-test's own last line is `SELF-TEST PASSED: k of k controls behaved as designed`
(exit 0) or `SELF-TEST FAILED: <first failing control, expected, observed>` (exit 1). Expected last lines:

| # | plant | must end on |
|---|---|---|
| 0 | faithful twin | `CERTIFIED` (at 7 with `--m 3`) |
| 1 | `U_num` lowered by 1 (one part in 10³⁰ of `U`) | `REFUSED IDENTITY_MISMATCH` at `[]` — **the overclaim, the fault that matters most** |
| 2 | `U_num` raised by `scale` (the bound weakened by 1) **and** the row `[[], [], scale]` added (`1 ≥ 0`, multiplier 1) | `CERTIFIED` — a weaker true claim must pass (the plant's both-sides bound) |
| 3 | `U_num` raised by `scale`, no row added | `REFUSED IDENTITY_MISMATCH` |
| 4 | one diagonal entry of a character block negated | `REFUSED BLOCK_NOT_POSITIVE_DEFINITE` |
| 5 | a character block replaced by a symmetric matrix with a zero eigenvalue and positive diagonal | `REFUSED BLOCK_NOT_POSITIVE_DEFINITE` (semidefinite is refused: Sylvester's strict form is what is checked) |
| 6 | a row multiplier's sign flipped, identity repaired by hand elsewhere | `REFUSED NEGATIVE_MULTIPLIER` |
| 7 | a row with `len(A) + len(B) = 5`; a row with a point index `n`; a top-level key misspelt (`"U_nmu"`) | `REFUSED MALFORMED`, the detail naming the JSON path |
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
fast code never takes. (The `p = 3` input exists: `data/fs66/b1/proto-cert-p3.json`, `U = 3.00011`, which with `--m 2` must end `CERTIFIED`.) (c) *Elimination twin:* on every block of the `p = 7` file, and on
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
writes the third word; only a checker run with `--record` does: `{"kind": "fs66-b1-check", "record_version": 1, "utc", "command",
"checker_sha256", "cert", "cert_sha256", "p", "m": int | null, "verdict": "CERTIFIED" | "BOUND ONLY" | "REFUSED" | "ERROR", "code":
str | null, "U_num", "scale", "U_float", "canonical_monomials", "blocks", "rows", "ldl": bool, "wall_s", "python", "machine",
"last_line"}` — flat, typed, closed vocabularies; nothing a script must parse out of prose.

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
the same at 3 with `--m 2` and at 11 with `--m 4`; `--m 5` at 11 must exit 3 on a line starting `BOUND ONLY`; a missing path must
exit 2 on a line starting `ERROR CANNOT_READ`; `git status --short` is unchanged by any of these; `python3 tools/fs66_b1_cert_check.py --self-test; echo $?`;
`grep -c "^import\|^from" tools/fs66_b1_cert_check.py` against a standard-library list.
- [ ] `tools/fs66_b1_cert_check.py`: standard library only, no float read, §K.1's three last lines and exit codes.
- [ ] `--self-test` runs plants 0–8, 10, 11 of §K.3 on a copy, each ending on the named line, the faithful twin green beside
      each, and the restore verified by digest. (Plants 9 and 12 need the producer: Phase 2B.)
- [ ] The orbit twin at 3 and 7, the assembled twin at 3 and the elimination twin are green — and each has been **seen red
      once** on a deliberate break (say which break in §R). `--ldl` agrees with the default route on `proto-cert-p11.json`.
- [ ] `python3 tools/fs66_b1_links_test.py 7 2 400; echo $?` ends `NO VIOLATION`, exit 0 (the planner's falsifier of L1–L2 —
      kept as is; extend it only by adding families of independent sets, e.g. the best sets a local search on level two finds).
- [ ] **Cold read** (experience pass): run the no-argument call, then the naive first call it teaches, then one deliberate
      mistake from each of: wrong path, `--m 5`, a float in the file, `p` edited — and confirm each response names what happened,
      in which space, and what to do next, in §G's words. Paste the four last lines into §R.
- [ ] `data/fs66/b1/SOUNDNESS.md` lifted from §S, ending with the `p = 3` instance walked through (its six blocks printed), with the checker's actual refusal codes; every sentence of it re-read against
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

### Phase 2C — 19 at four colours (optional; the owner's call after 2B; §19, §X) — **DONE, §R″**
- [x] The builder's cost measured on a sample before the full build (60.8 µs per canonical form, projecting 3.1 min
      single-threaded; the full build then took 26 s on 16 cores); caches under `data/fs66/ckpt/b1-p19/` with their own README;
      the float reading (**77.506086**) recorded **before** any rounding, in `records.jsonl` with trust `float reading
      (untrusted)`; **P-B6 scored NOT MET** on its first conjunct (the reading is 77.506, below the predicted `[80.6, 87]`, and
      below the 80.59 §19 said it could not go below — §19's premise was wrong, R″.8) and **MET** on its second (a certificate
      lands under 90.25); `data/fs66/b1/cert-p19.json` **`CERTIFIED` with `--m 4`**, `U = 77.511742…`, `4·U = 310.046968… < 361`.
- [x] The solve resumed from a checkpoint on purpose — rehearsed at `p = 11` before 19 was touched, then at 19 after the
      300-chunk run was killed, and at every chunk boundary thereafter (R″.9).

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

**Experience modeling (`debruijn-experience-modeling`, fresh invocation, 2026-09-20).** *Inhabit the user:* four consumers, each
holding something different when the output arrives (§K.1's first paragraph); the surface was redrawn from their side. *Quality
maxim — assert only what you established:* the draft's `CERTIFIED: no level is 4-colourable` claimed for the checker what rests
on hand links; the line now certifies the polynomial bound and marks L1, L2, L6 as the hand steps, in capitals, in the same
sentence. *Implicature:* `BOUND ONLY` must not read as "M colours suffice" — it now says so. *Silence and wrong-reason reds:* a
Python traceback exits 1, the same status as a refusal; the last line now always begins with one of four words, errors exit 2,
and the self-test matches the refusal **code**, never the status, and requires every plant's digest to differ from its twin's.
*Let breakdown teach:* each refusal carries what / in which space / what next, and `IDENTITY_MISMATCH` at the constant prints
the `U_num` the file actually supports — knowledge the checker holds and that otherwise dies. `NOT_A_SYMMETRY` was reclassified
from a refusal to `ERROR SELF_CHECK_FAILED`: it is never the file's fault. *Budget:* two codes merged into `MALFORMED`; `--m`
made optional (a consumer who wants only the bound should not invent a colour count); the checker writes nothing unless
`--record` is given. *The file as a surface:* key order puts the claim first; provenance allowed, free-text claims forbidden;
and the pass asked for an instance a person can read whole — **`p = 3` was run (4 KB, 28 canonical monomials, `U = 3.00011`,
the from-the-spec evaluator agrees)** and is now the soundness page's worked example and the assembled twin's input.
*Validate as the user:* a cold-read item in Phase 2A's checklist.

---

## §R. Results — filled by the implementer, phase by phase (predictions scored here; decisions implementation overturned, in four parts)

### Phase 2A — the checker, its soundness page, its controls (implementer, 2026-09-21). **LANDED.**

**The headline.** `tools/fs66_b1_cert_check.py`, written from §C, §S and §K and sharing no code with the
producer or the probe, **certifies all three prototype files**, at the planner's own counts: 28 canonical
monomials at `p = 3`, 495 at 7, **3,760 at 11**. At 11, `U = 28.225133…`, `4U = 112.900532… < 121`, in
**6.6 s and 136 MB**, single-threaded pure Python. `--m 5` at 11 exits 3 on `BOUND ONLY`. `--ldl` agrees
(22.9 s at 11). `--self-test`: **25 of 25**, 97 s. Nothing in this phase was compute-bound and none of it
used more than one core.

| deliverable | state |
|---|---|
| `tools/fs66_b1_cert_check.py`, standard library only (11 imports, all stdlib), no float read | done |
| §K.1's four last-line words and four exit codes, including `BOUND ONLY` (3) | done |
| `--self-test` plants 0–8, 10, 11 (17 runs), each on the code, each digest-compared to the faithful twin | done, +2 error rows (`E.1`, `E.2`) and +1 harness row (`H`) |
| the three twins, each **seen red once** on a deliberate break | done (below) |
| `--ldl` agrees with the default route on `proto-cert-p11.json` | done: `CERTIFIED`, 22.9 s |
| `python3 tools/fs66_b1_links_test.py 7 2 400` still ends `NO VIOLATION`, exit 0 | done, 2.1 s, unmodified |
| cold read | done (below) |
| `data/fs66/b1/SOUNDNESS.md`, with the `p = 3` instance and the Borel clause | done, 9 sections |
| P-B1, P-B2, P-B3 scored | done (below) |

**R.1 The first run did NOT agree with the prototype, and the fault was the checker's.** At `p = 3` it
refused with `IDENTITY_MISMATCH` at six of **31** canonical monomials where there are 28. Cause: in the
reflection map `z ↦ s·z̄` the imaginary part was written `bc − ad` instead of `ad − bc`, so the map built was
`conj(s)·z` — a rotation — and **conjugation dropped out of the group entirely**. The canonicaliser was then
incomplete (it had `p + 1` distinct maps, not `2(p+1)`), classes that are genuinely `Γ`-equivalent stayed
separate, and the identity could not close. Two things about this are worth keeping:

* **The failure was in the safe direction, exactly as §K.2 says it must be.** An incomplete canonicaliser
  makes (★) *stricter*: it can refuse a valid certificate, never pass a false one. That is what happened.
* **The symmetry guard did not fire, and was right not to.** Every map the checker built *was* a genuine
  symmetry (`h(x+s) − h(x) ∈ S`), so step 3 passed. The guard checks the property soundness uses, not that
  the list is the intended one — and completeness of the list is not on the trust surface (§C.3). The
  diagnosis came from the *count*: 31 against the record's 28.

Nothing in §C was wrong or ambiguous here, so **P-B2's stated mechanism did not occur**: the disagreement
was a transcription error in the checker's own rebuilt arithmetic, not a convention read differently. §C was
executable as written — the representative order ("in order of the smaller index"), which factor of
`a·τ_t(a′)` is translated, and the sub-multisets of `B` all worked first time, with no guessing.

**R.2 Predictions scored.**

| id | outcome |
|---|---|
| **P-B1** | **MET.** `CERTIFIED` at 11 with `--m 4` and `U = 28.225133…`, inside [28.20, 28.30]. |
| **P-B2** | **MET in its letter, missed in its mechanism.** The first run did not certify (predicted, low-medium) — but the named cause, "a convention read differently from §C", is not what happened; see R.1. Since §C's conventions were all read right the first time, the honest reading is that the specification *was* unambiguous and the prediction was right for the wrong reason. |
| **P-B3** | **MET, with an order of magnitude to spare.** 6.6 s and 136 MB at 11, against "under 3 minutes, under 1 GB", and against the planner's from-the-spec evaluator at 36 s. The gain is one design choice: `canon` is memoised in two stages, the outer on the translation-normal form, so the products `a·τ_t(a′)` and `a′·τ_{−t}(a)` — translates of one another — share the expensive minimisation. Building the 465,124-entry product table is 4.0 s of the 6.6. |

**R.3 The three twins, each seen red once.** Breaks were made on copies of the checker under the session
scratchpad; none was ever in the tree. Each break reds its own twin and leaves the others green, so the twins
discriminate rather than merely co-fire.

| break | what went red |
|---|---|
| `canon` tries only one point of `m` as the new origin | **twin (a)** at `p = 3` (`monomial [5,7,8]: fast [0,1,4], brute force [0,1,3]`) and at `p = 7`; twin (b) too, since the two routes then key translates differently; twin (c) green |
| the cross term `2·R[0][a]·c·σ` loses its factor 2 | **twin (b)** (`first y([0,0]): fast −315154655298·10¹⁸, assembled 0`); (a) and (c) green |
| Bareiss accepts a zero pivot (`piv <= 0` → `piv < 0`) | **twin (c)**, naming both planted matrices (`singular positive semidefinite: Bareiss 0, LDL 2`); (a) and (b) green |

**R.4 What the first break exposed about the harness, and the fix.** The twins used to run *after* the
plants, behind the gate "if the input itself does not certify, no plant would mean anything". A
canonicaliser bug makes the input not certify — **so the diagnostic for a bookkeeping fault was suppressed
by exactly that fault**, and the first two breaks printed only the gate's message. The twins now run first
and depend on nothing certifying; when the gate does fire it says the twins above already ran and are where
to look. This is `CLAUDE.md`'s "order a verification's steps by marginal evidential value" in its sharpest
form: the checks that decide the question were queued behind one that cannot.

**R.5 Two other repairs made before believing a green run.**

* **A display rounding turned a red into something that read like a pass.** Large integers were abbreviated
  to seven significant digits, so the overclaim plant (`U_num` lowered by 1) printed *"left 1.401757e+31,
  right 1.401757e+31"* — a mismatch message showing two identical numbers. Integers now print exactly to 45
  digits (every scale, `U_num`, `m·U_num` and multiplier is under 40), the abbreviation carries a digit count
  and handles the sign, and an identity mismatch always prints `left − right`.
* **The plant-did-not-apply branch had never been seen.** Added row `H`: a deliberately empty plant, checked
  to have the twin's digest, so the branch that would mark a non-applying plant is known to be reachable.

**R.6 The cold read (four deliberate mistakes; last lines verbatim).**

```
$ python3 tools/fs66_b1_cert_check.py data/fs66/b1/cert-p7.json                    # a path that does not exist
ERROR CANNOT_READ: data/fs66/b1/cert-p7.json: No such file or directory. The certificates in this repository
are data/fs66/b1/proto-cert-p11.json, data/fs66/b1/proto-cert-p3.json, data/fs66/b1/proto-cert-p7.json.   [2]

$ … proto-cert-p7.json --m 5                                                       # a colour count it does not refuse
BOUND ONLY: every phi in [0,1]^49 with q(phi) >= 0 has sum(phi) <= U = 14.017576… (exactly U_num/scale of the
file, sha256 502351003ab0…); but 5*U = 70.087884… >= 49, so this file does not refuse 5 colours -- which says
nothing about whether 5 colours suffice.                                                                  [3]

$ … float.json                                                                     # one integer replaced by 1.0
REFUSED NOT_AN_INTEGER: blocks[3]["R"][2][2] is the float 1.0, not a JSON integer. Every number in a
certificate is an exact integer over one scale; a float cannot be read back exactly, so the producer must
write integers only.                                                                                      [1]

$ … p11.json                                                                       # the 7 file with "p" edited to 11
REFUSED MALFORMED: weights[0] has 50 entries; a weight vector over {[]} + V has 1 + n = 122 (the constant,
then one per point index 0..120). Is the file's "p" = 11 the prime it was made for?                       [1]
```

The read changed one thing: the missing-path message said what happened but not what next, so it now lists
the certificates in the repository. The no-argument call prints the three usage lines with the repository's
real relative paths and a first call to try, and exits 2 on `ERROR USAGE`.

**R.7 Decisions the implementer took (choice · alternative · why · confidence).**

| choice | alternative weighed | why this one | confidence |
|---|---|---|---|
| **The orbit twin runs the COMPLETE degree-≤4 family at `p = 3` and `p = 7`** (715 and 292,825 monomials against all 72 and 784 group elements) | §X's fallback: restrict `p = 7` to monomials through the origin if the twin exceeds 15 minutes | it costs 97 s, so the fallback's condition never arose — and the fallback would have been blind to exactly the half of the fast route that chooses the *translation*, which is the half the first real bug lived in. An intermediate (degree ≤ 3 complete plus a 20,000 sample of degree 4) was built, measured at 13 s, and then discarded as strictly weaker for 84 s | high |
| **Block size is checked in step 1 from `p` arithmetically** (`2 + (n+1)/2`, or 2), not only when the representatives are built in step 6 | leave it where the representatives are constructed | §K.2 puts index ranges in step 1, and a reader who mistypes `p` should not pay for five steps first; the step-6 construction still guards it redundantly | high |
| **A non-symmetric `R` is `MALFORMED`, not symmetrised** | symmetrise and test `(R + Rᵀ)/2`, which would be sound | the identity's value is unchanged by symmetrising, so accepting one would be sound — but then the matrix a reviewer *reads* is not the matrix that was *tested*, and the elimination would be run on something the file does not contain | high |
| **Two-stage memoisation of `canon`** (translation-normal form, then the full minimisation) | one memo on the raw monomial | halves the expensive minimisations, because `a·τ_t(a′)` and `a′·τ_{−t}(a)` are translates; it is why the checker is 5× faster than the planner's evaluator. It rests only on canon being translation-invariant, which is immediate from its own construction | high |
| **`--orbit-twin-full` was added and then removed** | keep the flag | once the complete family became the default the flag could only weaken the test; a flag that only makes a control worse is surface with no consumer | high |
| **The record's `U_float` is the one float the program creates**, formatted from the exact decimal | emit only `U_num`/`scale` and let a consumer divide | §R′ names the field, and a record is provenance; the certificate is still never *read* as a float, which is the property that matters. Stated in the module docstring so the claim "reads no float" is not overclaimed | high |

**R.8 What Phase 2B should know.**

1. **The checker is the specification now.** Three conventions it fixes from `p` alone, on which the producer
   must agree exactly: the representative order (`φ_0`, then `φ_{−h}φ_h` by ascending smaller index of
   `{h, −h}`); the block size `1 + #reps`, so a character block must be **padded** with the constant row
   `[1, 0, …, 0]` as the prototype does; and `κ(t) = Σ_x w_x w_{x+t}`. All three were right in the prototype.
2. **`U` is printed truncated with an ellipsis** (`28.225133…`), never rounded up: a printed `U` is never
   smaller than the exact one, so the printed claim is never stronger than the proved one.
3. **Provenance keys are allowed and ignored** — `"spec"` and `"producer"` only, and the checker says so in
   its narration. **Any other unknown top-level key is `MALFORMED`**, so a misspelt field cannot be read as
   an absent one. Free-text claims inside the file remain forbidden.
4. **Plants 9 (`c = 1`) and 12 (arbitrary weights) are still owed**, as §H says; they need the producer.
   Plant 12's expected outcome is `CERTIFIED` or `BOUND ONLY` with a larger `U` — a refusal there would mean
   the weights are on the trust surface, i.e. a design error.
5. **Cost at 19, re-estimated from measurement rather than from §19's guess.** The checker's time is
   dominated by the product table, `#reps² × n` canonical forms: 465,124 at 11 for 4.0 s. At 19 that is
   `182² × 361 ≈ 12.0 M`, about 26× more, so **2–4 minutes** if the per-entry cost holds, plus an
   elimination on 19 blocks of size 183 (Bareiss is `O(size³)` big-integer operations on minors of ~2,500
   digits — this, not the table, is the part that could surprise). Well inside a reviewer's patience; §19's
   "tens of minutes" looks pessimistic.
6. **`--record` is the only thing that writes**, and it appends. A reviewer's run leaves `git status` clean;
   that is checked by hand here and is worth keeping.

**R.9 The handover sweep (WORKFLOW step 9's two greps; the close itself is the owner's).**

*"conjecture" / "not claimed" in this file* — **two hits, one of them owed a decision at the close.**
(i) §ST's last sentence, that `B₁ = α(G₁)` stays the main plan's §S5 conjecture: flagged by §H itself, lives
in the main plan, nothing owed here. (ii) **§PA's last sentence — "the main plan's §S5 conjecture (the tower
never rises) may be *provable* at 7 by an exact certificate at the optimal face. That is a stub candidate,
not this phase."** That is a conjecture-with-a-route surfaced inside a section about something else, which is
the exact shape the sweep rule was minted for (M56's prime inversion, buried in a lemma paragraph, proved by
an outsider eight days later). **It is owed a stub or an explicit decline in the owner's close**; the
implementer does not mint it, `plans/STUB-*.md` being the owner's. Note that it would need what §E lists as
deliberately *not added*: a positive-**semi**definite block form, since an exact-face certificate has a
singular block. The checker as written refuses those by name (`BLOCK_NOT_POSITIVE_DEFINITE`, plant 5), so
that direction is a format change and not just a producer change.

*§PA read back for what this phase taught about the object* — three things, all small:

1. **The bound is auditable in one addition, independently of the identity.** At the constant monomial only
   two terms can contribute: `R[0][0]·c²` of a `times "1"` block whose weight has `c ≠ 0` (the character
   blocks all have `c = 0`), and the multiplier of a row with `A = []`. The cascade produces exactly one of
   each, so **`U_num` is always one matrix entry plus one row multiplier** — verified by hand at `p = 3` in
   `SOUNDNESS.md` §9. A reviewer can check the *value* of `U` before checking anything else, and a write-up
   gets a one-line account of where the number comes from.
2. **The product table is symmetric in its representatives and even in its shift**: `a·τ_t(a′)` and
   `a′·τ_{−t}(a)` are translates of one another, and (the representatives being negation-stable)
   `F(a,a′,−t) = F(a,a′,t)`. The checker exploits only the first, through a memo on the translation-normal
   form, and that alone is most of the 5× it has over the planner's evaluator. At 19, where the table is 26×
   larger, the second is worth taking as well.
3. **The specification was executable by a third program with no convention guessing**, which is now three
   independent implementations of §C (the prototype, the planner's evaluator, this checker) agreeing on
   `U = 28.225133…`. The one disagreement in the phase was arithmetic inside the checker, not a reading of
   the format.

---

### Phase 2B — the production producer, the certificates, the records (implementer, 2026-09-21). **LANDED.**

**The headline.** `tools/fs66_b1_cert_make.py`, written from §R′, produced two certificates that the frozen
checker of Phase 2A calls **`CERTIFIED`**:

| | `data/fs66/b1/cert-p7.json` | `data/fs66/b1/cert-p11.json` |
|---|---|---|
| `U = U_num/scale`, exact | **14.015224…** | **28.204320…** |
| `U_num` | `14015224526962403621588626098460` | `28204320001863099628721379861820` |
| `scale` | `10^30` | `10^30` |
| the claim | `3·U = 42.045673… < 49` (`--m 3`, exit 0) | **`4·U = 112.817280… < 121`** (`--m 4`, exit 0) |
| not the claim | `4·U = 56.060898… ≥ 49` (`--m 4`, exit 3) | `5·U = 141.021600… ≥ 121` (`--m 5`, exit 3) |
| sha256 | `f4b2ffa7c42727f3b63f651e94fc2f1052ef10e0d13e8e43eb6a8fcf1c9fe1b4` | `683236677e0d55a4f9bd37d5266b370cebbb682831b3f0bc7493bce214bf0661` |
| blocks / rows / weights / bytes | 14 / 524 / 13 / 96,888 | 22 / 3,821 / 21 / 706,712 |
| producer: build + solve + exact | 0.3 s + 3.3 s + 0.07 s | 5.1 s + 91.5 s + 1.86 s, 744 MB |
| checker: wall | 0.31 s | **6.53 s** |

**Both are tighter than the prototype's** (14.017576…, 28.225133…), and the gain is the *scan*, not the
solve: the rounding loss against the float reading falls from 0.024 to **0.0028** at 11. `⌊U·121⌋` therefore
improves §S.7's level-two bracket from `3,388 ≤ α(UD(ℤ/121,2)) ≤ 3,415` to **`≤ 3,412`**; at 7 the
conclusion is unchanged and has more room (`⌊14.015224·49⌋ = 686 = 14·49`, so `α(UD(ℤ/49,2)) = 686` exactly).

| deliverable (§H Phase 2B) | state |
|---|---|
| `tools/fs66_b1_cert_make.py` per §R′, two float controls at 7 | done: **24.5**, **49.0**, **14.0**, all exact (`controls.out`) |
| the scan of §R′.4 recorded; the kept certificate at 11 has `U < 28.3`; both `CERTIFIED` | done: `scan.out`, 28.2043 |
| plants 9 and 12 as documented manual controls, outputs in `controls.out`; P-B4 scored | done; **plant 12 went red first and found a producer bug (R′.4 below)** |
| explicit 28-set at 11 and 14-set at 7, verified from the definition | done: `data/fs66/b1/level-one-sets.json`, `tools/fs66_b1_sets_check.py` (18 controls, seen red twice) |
| `README.md` extended: each file, what it licenses (§ST verbatim, Borel clause), trust word | done |
| B11 / P-B5 recorded | already recorded by the planner (§P, and `README.md`); nothing owed |

**R′.1 Predictions scored.**

| id | outcome |
|---|---|
| **P-B4** | **MET.** Plant 12 at 11 ends `BOUND ONLY` with `U = 7.156644 × 10¹⁹` — far above 40, sound and useless. Caveat on how much it proves: the plant replaces *every* entry including the constant `c`, so the magnitude of `U` is set by `c² ≈ 10¹⁸` rather than by the structure. The finding worth keeping is qualitative and stronger than the prediction — arbitrary weights give a bound `10¹⁸` times weaker and still **valid**, so the cosine/sine choice does all the work for the *quality* of the bound and none for its *validity*, which is §C.3 exactly. |
| **P-B1** | **MET again, on the production files** (it was scored in Phase 2A on the prototype): `CERTIFIED` at 11, `--m 4`, `U = 28.204320…` inside [28.20, 28.30]. |
| **P-B3** | **MET again:** 6.53 s at 11 against "under 3 minutes". |
| **P-B2** | not re-scorable: it is about the checker's first run, Phase 2A's. Worth recording that **the producer's first output, at `p = 3`, was `CERTIFIED` by the frozen checker on the first attempt** — three independently written programs (prototype, planner's evaluator, checker) plus this one now agree on §C. |
| P-B5, P-B6 | untouched (the planner's; P-B6 is Phase 2C's). |

**R′.2 The rounding scan, widened, and the law it yields (`data/fs66/b1/scan.out`, 42 attempts).**
§R′.4's grid is this tool's default `--scan`; the committed certificates come from it exactly. Widening it
in both directions gives the curve the next prime needs, and it is sharper than §T.3's "six digits are not
enough":

> **Positive definiteness survives exactly when `shift ≥ 10^(3−D)`** — at `p = 7` and at `p = 11` alike, in
> all 42 attempts, with no exception on either side. The shift and the digits are **not independent knobs**:
> the rescaling divides the solver-basis block by `n`, so a shift below the rounding granularity is rounded
> away and the block falls back onto the boundary the solver sits on.

Above that threshold the loss `U − float` is linear in the shift and then flattens onto a rounding floor:
at 11, `1e-4 → 30.5445` (**which no longer refuses four colours**), `1e-5 → 28.4361`, `1e-6 → 28.2253`
(the prototype's), `1e-7 → 28.2043` (shipped), `1e-8 → 28.2023`, `1e-9 → 28.2021`, `1e-10` not positive
definite. So for `p = 19`: round at `shift = 10^(3−D)` for the largest affordable `D`, and expect `U` within
about `10⁻⁴` of the float reading — a rounding loss of ~0.001 on an expected margin of 4–10 %.

**R′.3 What the phase at 19 should know** (measured here, not estimated).

1. **The builder is far cheaper than §19 feared.** At 11 the whole build is **5.1 s**, of which the product
   table `F(a,a′,t)` is **4.1 s for 465,124 canonical forms — 8.8 µs each** (with Phase 2A's two-stage memo,
   which this producer adopted). At 19 the table is `182² × 361 = 11,957,764` forms and the per-call
   minimisation is over 40 maps instead of 24, so **3–6 minutes single-threaded**, not the 30–60 of §19. The
   `Q` forms cost 0.1 s at 11 because the memo already holds their monomials; the scalar rows 0.5 s.
2. **The exact rounding scales like the table**, `#reps² × n`: 1.86 s at 11 → **≈ 50 s per attempt at 19**.
   The scan is then ~10 minutes over six workers and still not the bottleneck. **The solve is.**
3. **Parallelism buys little at 11 and will buy a lot at 19.** Six rounding attempts of 1.4 s each finish in
   1.6 s wall on six forked workers — about 4×, the rest being the fork's copy of the build. At 19, with
   50 s attempts, the fork cost vanishes and the scan is genuinely parallel. Use `multiprocessing`'s **`fork`
   context explicitly**: Python 3.14's default `forkserver` re-imports the module and leaves the module-level
   build empty in the worker.
4. **Nothing in this phase came close to needing a checkpoint**, so none was built: the longest single run is
   the 92 s solve at 11, and the producer is restartable from its command line with nothing on disk to
   resume from. At 19 that changes and §X's requirement stands — the natural checkpoint boundary is the
   **build** (cache `F` and the `Q` forms), because it is the part that is expensive *and* deterministic,
   and then SCS's warm-started chunks. No `timeout` wall was used anywhere in this phase.
5. **A GPU is not appropriate at 7 or 11 and was not used**, as §R′.1 says: the per-iteration work is eleven
   62 × 62 eigendecompositions and one cached sparse factorisation. The solve at 11 used 4 threads, 92 s,
   744 MB. Said plainly because the hardware was offered.
6. **Memory at 11 is 744 MB for the solve**; the plan's 8 GB ceiling was never approached.

**R′.4 The control that fired, and what it caught.** **Plant 12 was `REFUSED IDENTITY_MISMATCH` on its first
run, and the fault was the producer's, not the design's.** The certificate's linear form was accumulated in
three shapes — the all-ones block, a character block, a `q` block — instead of the one shape §C.2 states, and
in the character and `q` shapes the padded constant row's term `R[0][0]·c²` (and its cross term
`2·R[0][1+j]·c·σ`) was simply absent. With the real weights `c = 0`, so the missing term is zero: **the
production certificates were never affected, and no control with `c = 0` could ever have seen it.** Three
things are worth keeping.

* **The plant had to be run in its strongest form to fire.** §K.3 says "weights replaced by arbitrary
  integers"; a reading that kept the structural constant entries (1 for the all-ones vector, 0 for the
  character vectors) would have passed and taught nothing. §C.3's claim is about the whole vector, `c`
  included, so the plant must be too.
* **The fix removed the bug class, not the bug.** The accumulation is now one loop over
  (block × weight vector) applying the three terms of (★) as written, to every block including the padded
  ones — which is also the checker's own shape, so the two programs are now provably asking the same
  question in the same order.
* **The repair forced everything downstream to be regenerated.** A change to the producer changes its
  sha256, which appears inside every certificate's `producer` provenance; a file claiming a maker that no
  longer exists is the kind of inconsistency this phase is about. Both certificates, all records and all
  controls were re-made after the fix, and **the producer is frozen from that point.**

**R′.5 The checker was re-run as `--self-test --cert data/fs66/b1/cert-p7.json`** — all 25 of Phase 2A's
controls applied to *this* phase's certificate rather than the prototype: **25 of 25, 97 s**, and
`git status` clean afterwards.

**R′.6 The level-one sets, and a self-test that was itself caught.**
`data/fs66/b1/level-one-sets.json` holds a 14-set of `UD(𝔽₇,2)` (a union of two cosets of an additive
`𝔽₇`-line missing the unit circle) and a 28-set of `UD(𝔽₁₁,2)` (randomised greedy plus (1,2)-swap local
search; 28 is not a multiple of 11 and the coset route reaches only 22). Each point is written **twice**, as
the pair `[a, b]` and as the index `a·p + b`, and `tools/fs66_b1_sets_check.py` refuses the file if the two
disagree — the one convention error a two-spelling format can carry. Only `α(G₁) ≥ size` is used anywhere;
maximality is FS-54's and is neither re-derived nor needed.

The verifier's `--self-test` was **seen red twice**, on copies of it under the session scratchpad: cutting
the pair/index bridge reds one row, and cutting the independence loop to the first unit vector reds two.
**The second break exposed a defect in the self-test itself**: its single independence plant put the
violating pair at unit vector 1, the very one the break kept, so a verifier reduced to `S[:1]` passed all
eleven controls. A control whose failure mode is unreachable has not been tested by passing. The plant now
runs **once per unit vector** (8 at `p = 7`), and the self-test has 18 controls.

**R′.7 Where the plan, Phase 2A's hand-over or the brief needed a word.** Nothing was wrong; four sentences
are stale or narrower than they read.

1. **§R′.1's control "`--no-q` → `n/2`-ish" is `n/2` only with a cut present.** The planner's B2 was measured
   on the *full* relaxation, which carries the edge-cut localiser; in the **minimal** relaxation this phase
   ships, dropping `q` reads **49 = n**, because `φ ≡ 1` is feasible for the moment blocks and the box rows.
   Both are run and both are in `controls.out`: with the edge row **24.5**, without it **49**. The second is
   the sharper statement — in the minimal relaxation `q` is the *only* thing that binds.
2. **§ST and `SOUNDNESS.md` §8 carry the prototype's numbers.** Every clause there is true and is implied by
   the committed certificates; one number changes, `α(UD(ℤ/121,2)) ≤ 3,415` → **`≤ 3,412`**, and the brackets
   tighten (`χ_f ∈ [4.2901, 4.3215]` at 11, `[3.4961, 3.5]` at 7; Haar `∈ [0.231404, 0.233093]`). **Not
   edited here**: §ST is the planner's and `SOUNDNESS.md` is frozen except for a sentence shown to be
   *wrong*, which none of these is. The live statement is in `data/fs66/b1/README.md` under Phase 2B, with a
   line saying so. **Owner's call** whether §ST and §8 are updated in place.
3. **The frozen checker's usage text names only the three `proto-cert-*.json` files.** Its `CANNOT_READ` hint
   globs the directory and so lists the new certificates correctly, but `--help` and the no-argument call now
   under-report what is in the repository. Cosmetic, in a frozen file: flagged, not touched.
4. **§R′'s closed trust vocabulary has no word for a production producer's own bound.** Its middle word reads
   `"prototype bound (producer's own arithmetic, untrusted)"`; a fourth word was not minted, because a closed
   vocabulary is worth more than an adjective and the parenthetical is the meaning. Every record carries
   `tool_sha256` and `command`, which say which program it was.

**R′.8 Decisions the implementer took (choice · alternative · why · confidence).**

| choice | alternative weighed | why this one | confidence |
|---|---|---|---|
| **Ship the certificate the plan's own §R′.4 grid selects (28.2043), not the best the widened scan found (28.2021)** | ship the 28.2021 file | the committed artifact is then reproducible by the documented default command, `--scan` with no arguments; the gain is 0.002 on a margin of 2.05, and §R′.4 says in as many words that anything under 28.3 is as good as 28.21. The widened scan is recorded as a measurement, in `scan.out`, and is what 19 will use | high |
| **The producer writes the two provenance keys `spec` and `producer`, which the prototype left out** | write only the seven checked keys | it puts the specification's address and the solver, tolerance, digits, shift and tool digest inside the artifact, where a reviewer opening the file first meets them — and it exercises the checker's "provenance, not checked" narration on a real file. Key order is the claim first (`format`, `p`, `scale`, `U_num`), then `spec`, then `producer`, then the data | high |
| **No build cache and no checkpointing in this phase** | build the `F`/`Q` cache under `data/fs66/ckpt/b1-p{p}/` now, since §X asks Phase 2C for one | the longest run here is 92 s, so a cache would save 5 s and add an untested reload path to the one program whose output is the milestone's artifact; §X's requirement is Phase 2C's, and R′.3 gives it the measured per-canonical-form cost to size it from. **Reversal condition:** if 2C is run by the same producer, the cache is its first commit, not an afterthought | high |
| **Plant 12 replaces every entry of every weight vector, the constant `c` included** | replace only the point entries, keeping the structural constants | §C.3's claim is about the whole vector, so the control must be too — and only this form has a reachable failure, as the bug it found proves. The cost is that `U` comes out at `10¹⁹` and P-B4's "> 40" is met trivially; the qualitative finding is recorded instead | high |
| **A separate standard-library verifier for the level-one sets** (`tools/fs66_b1_sets_check.py`), with its own three last-line words, exit codes and `--self-test` | verify the sets inside the certificate checker, or in a throwaway script | the certificate checker is frozen and these sets are a different claim with a different trust word; a throwaway script is not an artifact a reviewer can re-run. The cost is one more file to read; the benefit is that the lower halves of §ST have a checkable owner | high |
| **The scan is parallel by `multiprocessing` with an explicit `fork` context** | run the six attempts in sequence (they cost 9 s in total at 11) | the brief asks for it and it is the shape 19 needs, where an attempt is ~50 s; it is honest to say that at 11 it saves seconds, not hours, and the report says so | high |
| **The float controls print through `print`, not the narration channel** | leave them as narration | the first run of the controls under `--quiet` printed **nothing**, and a probe's silence is never a verdict — a control whose output is suppressed reads exactly like a control that never ran | high |
| **The `c ≠ 2` and arbitrary-weights warnings print twice, before and after the bound, and survive `--quiet`** | the single warning at the top the tool first had | under `--quiet` that warning vanished while the confident line "refuses 3 colours at every level, by the hand links" still printed — for the *wrong problem*. A warning must be louder than the claim it qualifies | high |

**R′.9 The handover sweep** (WORKFLOW step 9's two greps over this phase's own additions; the close is the
owner's).

*"conjecture" / "not claimed"* — no new hit. §R.9's two hits stand unchanged, and its item (ii) — that
§S5's conjecture "may be provable at 7 by an exact certificate at the optimal face" — **is now one integer
sharper and still owed a stub or a decline.** The certificate at 7 proves `U = 14.015224…` against
`α(G₁) = 14`, so the gap is 0.0152 and the exact-face question is "is there a certificate with `U = 14`
exactly". This phase adds one measurement bearing on it: the widened scan's smallest positive-definite `U`
at 7 is **14.014996…**, reached at `shift = 1e-9`, and the trend flattens there rather than approaching 14 —
the residual 0.0149 is the *relaxation's* gap (the minimal relaxation's float value is 14.014904), not the
rounding's. So an exact-face certificate would need a **tighter relaxation** as well as a singular block, and
§E's "not added: a positive-semidefinite block form" is only half the price. (At 11 the corresponding gap is
0.2015 against `α = 28`, and B11's tightened relaxation reads 28.0427: the tightening closes three quarters
of it and is still not exact.)

*§PA read back for what this phase taught about the object* — two things.

1. **The bound's sensitivity is entirely in the rounding, not in the mathematics.** One knob — the diagonal
   shift — moves `U` at 11 from 28.2021 to 30.5445, i.e. across the line that decides whether four colours
   are refused at all, while the relaxation's own value never moves from 28.2015. Anyone reading a number
   like "28.2" off this method must be told which shift produced it.
2. **The producer's freedom is enormous and entirely one-sided.** Arbitrary integer weights, a wrong table, a
   wrong block structure: each gives a valid certificate of a worse bound. The only thing the producer can do
   that is *not* one-sided is get `q`'s constant wrong (plant 9), because `c` is not a weight — it is part of
   the *problem*, and the checker rebuilds it. That is the sharp statement of where this design's trust
   boundary actually lies, and it is one line: **everything the producer chooses is off the trust surface
   except the problem it is solving.**

---

### Phase 2C — 19 at four colours (implementer, 2026-09-21). **LANDED.**

**The headline.** `data/fs66/b1/cert-p19.json`, `U = 77.511742…`, **`CERTIFIED`** by Phase 2A's frozen
checker with `--m 4`: `4·U = 310.046968… < 361`, so **no level of the 19-adic tower is four-colourable**, and
19 joins 7 and 11 as a prime whose whole tower is decided. The reading was 77.506086 against the 90.25 the
certificate needed — a margin of 14 %, against 11's 6.8 %.

**The go/no-go, sent to the owner as a message before any rounding: GO.** The minimal second-level relaxation
at `p = 19` reads **about 77.4**, against the `361/4 = 90.25` that a four-colour certificate needs — a margin
of about 14 %. The best level-one independent set is 76, so the relaxation's own optimum is pinned in roughly
`[76, 78]`.

**R″.1 The build is two orders of magnitude cheaper than §19 priced it, because of two symmetries.**

> `a' · τ_{−t}(a)` is the translate `τ_{−t}(a · τ_t(a'))`, so `F[ib][ia][t] = F[ia][ib][t]`; and `z ↦ −z` is
> the rotation by the circle point `−1`, under which every representative (`φ_0` and `φ_{−h}φ_h`) is stable,
> so `F[ia][ib][−t] = F[ia][ib][t]`.

Together they make the product table a **quarter** of its naive size: **3,014,193 canonical forms against
11,957,764**, and the constraint matrix **53,676,794 nonzeros against §19's "near 10⁸"**. Both identities are
checked on 300 random `(ia, ib, t)` before they are used (`Build._check_symmetries`); a wrong table could only
weaken `U` (§C.3), so this guards the bound's quality, not its validity.

| at `p = 19` | |
|---|---|
| whole build | **26.1 s** — product table 14.0 s on 16 forked workers, q forms 5.3 s, box rows 4.2 s, assembly 2.4 s |
| peak memory | 4.4 GB (the assembly; the build alone is under 1 GB) |
| orbits `K` | **52,370** (§19 guessed ~55,000) |
| blocks | 183, 18 × 182, 2 × 2 — **20**, no reflection split needed |
| scalar rows | **259,271** (§19 guessed ~300,000) |
| constraint matrix | 575,864 × 52,369, **53,676,794 nonzeros** |
| build cache | `data/fs66/ckpt/b1-p19/build-p19-c2.npz`, 12 MB; reload 0.4 s |

The q forms are memoised on `canon(m)`, which at 19 turns the 363 forms the relaxation asks for into a dozen
distinct ones. The memo is on the **fast path only**: it changes the order in which new orbits are discovered,
hence the orbit numbering, hence the bytes of the file — which must not move at 7 and 11.

**R″.2 The two controls that make the extended producer safe.**

* **`--twin-build`** builds the relaxation BOTH ways at one prime and compares them without ever comparing an
  orbit *number* (the two paths number orbits differently on purpose): the orbit sets, the product table and
  the q forms as canonical monomials, the scalar rows as `(kind, payload) → {canonical monomial: coefficient}`,
  and **every row of the assembled matrix evaluated at one pseudo-random moment functional**. Green at
  `p = 3, 7, 11`; at 11 the two matrices agree in shape, in nnz (1,202,121) and to 1.1e−12 on every row.
* **Seen red on four deliberate breaks**, each in a different part and each leaving the other checks green:
  the shift multiplicity dropped (block rows differ by 9.98); one shift of the product table wrong (1,352 of
  33,124 entries, and the assembled rows by 4.91); the q-localiser class grouping losing the class size (rows
  by 30.6); the pair symmetry read with a transposed index (15,652 of 33,124 entries).
  **Two earlier plants applied textually and were semantic no-ops** — one broke the branch `j == 0`, which is
  the zero shift where the "broken" expression is the correct one, and one made the q-form memo a pure
  recomputation. A plant whose failure mode is unreachable has not been tested by passing; both were replaced.
* **`--regression`** reproduces `cert-p7.json` and `cert-p11.json` from the documented production command and
  compares **every key** against the committed files: identical, except `producer.utc` (which changes on every
  run) and `producer.tool_sha256` (this file's own digest, which any edit must move). The committed
  certificates are **left untouched on disk**; they were made by the production producer at commit `3c740871`,
  and the extended producer reproduces them in every key but those two provenance fields.

**R″.3 The hardware, measured rather than assumed.** 50 iterations at the real problem size, on a quiet
machine, same iterate:

| backend | seconds per iteration | objective at iteration 50 |
|---|---|---|
| **`gpu_indirect`, graphics card A** (`build/venv-sdp-gpu`) | **0.675** | 99.8221 |
| `cpu_indirect`, 16 threads (`~/venvs/fs66`) | 2.037 | 99.8227 |

**3.0×, and the two agree to five digits.** GPU memory 2.4 GB of 32. In the long run the per-iteration cost
rises to about 1.0 s as the conjugate-gradient inner solve works harder. A chunk measured while a niced
one-core rounding probe ran alongside read **1.310 s/it against 0.968 s/it uncontended** — the same trap
`CLAUDE.md` names: a contended-wall timing is not a quiet-CPU cost, and the 0.675/2.037 pair is the one that
travels.

**R″.4 The rounding is 5× what §R′.3 predicted, and — the phase's sharpest finding — `U` tracks the DUAL
residual, not the objective.**

| | |
|---|---|
| one exact rounding attempt at 19 | **242.9 s** (§R′.3 predicted ≈ 50 s by scaling `#reps² × n`) |
| the certificate it writes | 38 blocks, 54,056 rows, 31,306 cascade steps, 9.3 MB |

and then, from three duals of the *same* solve:

| dual | `res_pri` | `res_dual` | rounded `U` |
|---|---|---|---|
| 605 iterations, after a five-iteration warm-started continuation | 1.95 | 4.7e−01 | **192.574282** |
| 1,200 iterations | 1.75e−04 | 6.0e−01 | **213.926704** — *worse, on a better primal* |
| (for comparison, `p = 11` converged) | < 1e−07 | < 1e−07 | loss 0.0028 |

So the objective converging says nothing: the cascade pays for the dual's infeasibility in box rows, and at
`res_dual ≈ 0.6` that costs **more than 100** in `U`. Anyone reading a number off this method must be told the
dual residual as well as the shift (§R′.9 item 1, sharpened).

**R″.5 Two things about reaching a checkpoint's dual, both measured.**
1. **Re-entering SCS to get at a checkpoint destroys the dual one came for.** Five warm-started
   `cpu_indirect` iterations from the 600-iteration checkpoint took `res_pri` from 1.33e−03 to **1.95**. The
   remedy is `--round-only`: load `y` out of the checkpoint and call no solver at all — which also skips the
   assembly, since only the block offsets are needed, keeping 4.4 GB out of every forked worker.
   **Control:** at `p = 11` the normal path and `--round-only` from its own checkpoint produce
   **byte-identical** certificates.
2. **Chunk size is not free.** The same relaxation at 11 solved in 4,000-iteration chunks gives
   `U = 28.204515…` against the committed `28.204320…` from one uninterrupted call — SCS's adaptive scaling
   is not checkpointed and drifts (FS-50's finding, here at a harmless magnitude *when the solve converges*).
   At 19 with **300**-iteration chunks it was not harmless: over five chunks `res_pri` fell 1.19e−02 → 2.02e−04
   while `res_dual` **did not move** (4.7e−01, 3.7e−01, 6.7e−01, 6.0e−01, 5.6e−01). That run was killed at
   1,500 iterations (nothing forfeited: its checkpoint and log are kept as
   `solve-gpu-300chunks-1500it.npz` and `p19-solve-300chunks.log`) and relaunched with **3,000**-iteration
   chunks, the granularity that converged at 11, plus a second differently-configured solve
   (`acceleration_lookback=0`) on the idle second GPU.

**R″.6 The frozen checker handles 19, measured on a real 19-sized certificate before anything depended on it.**
`tools/fs66_b1_cert_check.py`, unmodified, on the 9.3 MB dry certificate: **8 min 21 s wall, 3.17 GB resident**,
all seven steps, the identity verified coefficient by coefficient on all **52,370** canonical monomials with 38
blocks and 54,056 rows, ending `BOUND ONLY` (the correct word for `U = 192.57`). §R.8 item 5 estimated 2–4
minutes and flagged the eliminations on blocks of size 183 as the part that could surprise: **they were not the
surprise** — they passed, and the cost is the naive `#reps² × n = 11,957,764`-form product table, which the
checker rebuilds without the two symmetries the producer now uses. Within a reviewer's patience, and the
checker was not touched.

**R″.7 The certificate. `data/fs66/b1/cert-p19.json`, `U = 77.511742…`, `CERTIFIED`.**

| | |
|---|---|
| `U_num / scale` | `7751174208860938222570365201256712 / 10^32` = **77.511742…** |
| the claim | **`4·U = 310.046968… < 361`** — `--m 4`, exit 0 |
| not the claim | `5·U = 387.558710… ≥ 361` — `--m 5`, exit 3, `BOUND ONLY` |
| blocks / rows / weights / bytes | 38 / 53,545 / 37 / 10,383,708 |
| sha256 | `055f031d1e69…` |
| checker | **`CERTIFIED` in 8 min 31 s, 3.17 GB** |
| rounded from | the **converged** solve: 13,950 iterations, `status solved`, `res_pri` 6.3e−07, `res_dual` 1.12e−05, 12,210 s on graphics card A |
| rounding loss | **0.005656** against the float reading 77.506086 |

**The solve converged**, at `eps = 1e-7`, in 13,950 iterations across five 3,000-iteration chunks, 3 h 23 m.
The trajectory is the record the next prime needs: `res_dual` 1.32e−01 (3,000) → 4.92e−03 (6,000) →
1.43e−03 (9,000) → 3.03e−05 (12,000) → 1.12e−05 (13,950, `solved`), and the bound rounded from each:
**111.203356 → 78.774941 → 77.831624 → 77.533210 → 77.511742.** Four colours were already refused at
6,000 iterations.

**The shift/digit scan, and §R′.2's law at a third prime.** The 11-era default grid
(`shift ∈ {1e-7, 1e-6, 1e-5} × D ∈ {10, 12}`) gives 77.532568 at best. The widened grid §R′.2 itself
prescribes for the next prime — *round at `shift = 10^(3−D)` for the largest affordable `D`* — gives
**77.511742** at `shift = 1e-10`, `D = 14`, a **4.7× smaller rounding loss** (0.005656 against 0.026482).
And the law is exact again: `shift = 1e-10` with `D = 12` leaves **19 blocks not positive definite**
(`1e-10 < 10^(3−12)`), while with `D = 14` it is fine. Three primes, no exception.

| shift | `U`, `D = 12` | `U`, `D = 14` |
|---|---|---|
| `1e-10` | not positive definite | **77.511742…** (shipped) |
| `1e-09` | 77.512147… | 77.511890… |
| `1e-08` | 77.513532… | 77.513710… |
| `1e-07` | 77.532568… | — |

**What it licenses**, with the committed 76-point set: no level of the 19-adic tower is four-colourable, so
`χ(UD(ℤ/19^k, 2)) = 5` at every `k`; `χ_f` of every level in `[4.6574, 4.7500]`; the Haar-measure supremum
in `[0.210526, 0.214714]`; **`χ_Bor(ℚ₁₉²) = 5`**, a third exact value for `[BardestaniMallahiKarai2017]`'s
problem; **`α(UD(𝔽₁₉,2)) ≤ 77`**, hence 76 or 77; and `27,436 ≤ α(UD(ℤ/361,2)) ≤ 27,981`.

**`U < 77` is not attainable by this route, ever** (the owner asked): the certificate is a feasible point of
the relaxation's dual, so `U ≥` the relaxation's own optimum, and that optimum is `77.506086…`. Extra
shift/digit attempts can only approach it, and six of them did (77.5117 against 77.5061). Closing the last
gap is a question about a *tighter relaxation*, not about rounding.

**R″.8 P-B6.** Its first half is **NOT MET, on the low side**: the reading is about 77.4, below the predicted
band `[80.6, 87]`. Its premise was wrong, and the error is worth keeping: §19 argued the reading "cannot be
below FS-62's level-3 value 80.59" because `B₁ ≥ α`. But the second-level moment relaxation *of `B₁`* is
stronger than the level-3 relaxation *of `α`*, and that dominates the gap `B₁ − α`. The consequence is a
result the phase was not aiming at: since `B₁ ≥ α(G₁)`, a certified `U` is also an upper bound on the
independence number of level one, so `α(UD(𝔽₁₉,2)) ≤ ⌊U⌋` — against FS-62's 80 from the level-3 relaxation.
`U` can never be below the relaxation's own optimum (the certificate is a feasible point of its dual), so with
that optimum at ≈ 77.4 the attainable floor is `⌊U⌋ = 77`, never 76.

**R″.9 The deliberate resume, and every checkpoint exercised.** The solve was resumed from its checkpoint
**three times on purpose**, by PID, verified by effect: once at `p = 11` as a rehearsal before 19 was
touched (`build cache reloaded … q forms 0.0 s`, `RESUMED from …: 200 iterations already done`, the value
moving 28.33 → 28.20); once at 19 when the 300-chunk run was killed at 1,500 iterations; and once more
implicitly at every chunk boundary, since each chunk reloads the iterate it saved. The build cache was
written, reloaded and **checked to hold what it claims**: the first version saved it *before* the q forms
existed, so a reload silently rebuilt them — cheap (5 s) but a cache that does not hold what its docstring
says is the wrong kind of file, and it was fixed and the round trip re-exercised.

Every kill in this phase was by **PID** and verified **by effect** — the PID absent from `ps`, and the
checkpoint's digest identical across ten seconds — never by a pattern. One scan of `/proc/*/cmdline` for a
producer pattern did report a live match: **the shell running the scan**, whose own command line contained
the pattern. It was recognised, and the verdict was taken from the CPU listing instead.

**R″.10 Decisions the implementer took (choice · alternative · why · confidence).**

| choice | alternative weighed | why this one | confidence |
|---|---|---|---|
| **Extend `fs66_b1_cert_make.py` in place, every new flag default-off, and prove it with `--regression`** | a second producer `fs66_b1_cert_make19.py` importing this one as a library | one program, one place; the import route needs an argv shim (this file parses arguments at import) and would record the *base* file's digest in its own records. The cost is that `producer.tool_sha256` inside `cert-p7.json` and `cert-p11.json` now names a digest that only exists in git — those files were made by the production producer at commit `3c740871`, they are **left untouched on disk**, and `--regression` shows every other key still reproduces | high |
| **A structural twin, comparing canonical monomials and one random evaluation of every assembled row** | compare the two paths' certificates byte for byte at 7 and 11 | the two paths number orbits differently **on purpose** (the fast one deterministically by (degree, tuple), the reference by discovery order), so a byte comparison would fail for a reason that is not a fault. Comparing the linear forms compares the mathematics. Seen red on four breaks, each in a different part | high |
| **Use the two product-table symmetries, verified on a sample before use** | build the full `#reps² × n` table as the reference does | a quarter of the work and of the matrix, which is the whole reason 19 was cheap; and a wrong table could only weaken `U` (§C.3), so the sample check guards quality, not validity. The frozen checker still does it the naive way, which is where its 8 minutes go | high |
| **`--round-only`: round a checkpoint's dual with no solver call** | reach the dual by warm-starting SCS for a few iterations, as the first attempt did | measured: five warm-started iterations took `res_pri` from 1.33e−03 to 1.95 and the bound from ~78 to 192.574282. The remedy also skips the assembly, keeping 4.4 GB out of every forked worker. Controlled at 11: byte-identical to the normal path | high |
| **Ship the widened-grid certificate (77.511742), not the default grid's (77.532568)** | ship the default-grid file, as Phase 2B did at 11, for reproducibility by the bare `--scan` | §R′.2 *itself* wrote the widened recipe down for the next prime, so the widened grid **is** the documented command here, and it is in the README verbatim. It buys 4.7× in rounding loss. Phase 2B's reasoning (reproducible by the documented default) is honoured, the default having changed for this prime | high |
| **Kill the second, differently-configured solve on the idle 3090 once the first was clearly converging** | keep it as a hedge | it had produced no chunk line in 60 minutes and was measurably slowing the critical-path solve through the CPU-side eigendecompositions. Nothing is claimed about `acceleration_lookback=0` beyond "slower per iteration"; it was killed before its first measurement | medium-high — a hedge abandoned before it paid is a hedge that cost something |
| **Commit the 31 MB of caches** | leave them on disk, untracked | the solve iterate is 2.5 GPU-hours and is what the certificate was rounded from; the repository already carries 80–120 MB artifacts, so the norm allows it. A README beside them says what regenerates each and gives the resume commands | medium-high |

**R″.11 Where the plan, the earlier phases' hand-overs or the brief was wrong.**

1. **§19's cost model was wrong in both directions.** The build is 26 s, not 30–60 min, and the matrix is
   53.7 M nonzeros, not "near 10⁸" — both because of two symmetries nobody had used. But the **rounding** is
   243 s, not §R′.3's ≈ 50 s, and the **checker** is 8.5 minutes, not §R.8's 2–4 — and §R.8's guess about
   *which part* would surprise was wrong too: the Bareiss eliminations on blocks of size 183 passed without
   incident, and the cost is the naive product table.
2. **§19's "it cannot be below FS-62's level-3 value 80.59" was false**, and the brief repeated it. See R″.8.
3. **§X's "cache `F` and the `Q` forms" needed doing literally.** The first implementation saved before the
   q forms existed.
4. **The plan gives no guidance on chunk size, and it is not a free parameter.** 300-iteration chunks left
   the dual residual flat; 3,000-iteration chunks converged. `tools/fplane_sdp_scs.py`'s 2,000 is the right
   order of magnitude, and §X should say so.
5. **Nothing in the plan says the rounded bound tracks the DUAL residual.** It is the single most important
   operational fact about this method at a new prime, and it is R″.4.

**R″.12 The handover sweep** (WORKFLOW step 9's two greps over this phase's additions; the close is the
owner's). *"conjecture" / "not claimed"* — **no new hit**; §R.9's two hits stand. *§PA read back for what
this phase taught about the object* — two things:

1. **The product table is symmetric in its representatives AND even in its shift, and both are exactly the
   statement that `−1` lies on the unit circle and fixes every representative.** §R.8 item 2 had spotted the
   first and half of the second and said "at 19 the second is worth taking as well". Taking both makes the
   table a quarter, not a half: the constraint matrix at 19 is 53.7 M nonzeros where the plan priced 10⁸, and
   the frozen checker — which uses neither — spends its whole 8 minutes rebuilding what the producer gets in
   14 seconds on 16 cores. **If the checker is ever re-opened, this is the one change worth making**, and it
   is safe in the strong sense: a canonicaliser that merges *fewer* monomials only makes (★) stricter
   (§K.2), and these two identities merge nothing new — they say the same orbit is reached twice.
2. **`B₁(p) ≥ α(UD(𝔽_p,2))` makes every certificate of this milestone a bound on a finite plane's
   independence number**, which nobody had said. At 7 and 11 it is vacuous (`⌊U⌋ = α` already). At 19 it is
   **new information**: `α ≤ 77` against FS-62's 80, from an instrument built for the tower. Any future prime
   this milestone certifies pays the same dividend, and at 23 it would read `α(UD(𝔽₂₃,2)) ≤ ⌊U⌋` against
   FS-56's certified 105 — a stub candidate the owner's close should consider.

**R″.13 The `p = 23` extension (the owner's, mid-phase): the build and the solve exist; the reading does
not yet. Handed over running.** Five colours at 23 need `U < 529/5 = 105.8`. Everything below is measured.

| at `p = 23` | |
|---|---|
| representatives / orbits | 266 / **134,447** |
| blocks | one 267, twenty-two 266, one 2 × 2 — **24** |
| scalar rows | 667,774 |
| constraint matrix | 1,484,797 × 134,446, **204,658,963 nonzeros** |
| build | **87 s** (product table 52 s on 16 workers: 9,410,415 canonical forms, a quarter of 37,429,924); cache 39 MB |
| memory | **16.0 GB** host peak at assembly, 6.3 GB steady; **4.0 GB of 32 on the GPU** |
| per iteration, `gpu_indirect` on card A | **3.926 s at 50 iterations**; **at least 6.6 s in the long run** (5 h 30 m had not finished 3,000 iterations) |

**Nothing at 23 is rounded or certified, deliberately.** The solve is left **running and detached** in the
shape a certifying run needs (3,000-iteration chunks, the granularity that converged at 19), with its PID and
process group in `data/fs66/ckpt/b1-p23/solve.{pid,pgid}`, its log beside them, and a README holding the
resume command, the stopping criterion, the rounding command and how to find the process **by the log file it
holds open** rather than by a pattern. Phase 2D picks up the converged iterate.

**The per-iteration cost at 19 FELL over the run, monotonically** — 1.132 → 0.932 → 0.814 → 0.769 → 0.648
s/iteration across the five chunks (the first contended with a rounding probe; the rest did not). Average
0.875 against 0.675 measured at 50 iterations. **So the "×1.3" is not the cost climbing: it is the first
chunk being the most expensive, by 1.7× over the last**, and the 50-iteration figure is close to the *final*
rate rather than the average. If 23 has the same shape its first chunk is its worst, and the 19–28 h
projection should fall as chunks land. *This corrects my own framing in the message that carried it.*

**In-chunk progress is available and costs nothing.** `solve_scs` sets `verbose=False`, but the
`--scs-setting` loop runs **after** that dict literal, so **`--scs-setting verbose=1` turns SCS's own
iteration table back on** — it prints every 250 iterations, i.e. every ~28 minutes at 6.6 s/iteration —
without touching convergence or the chunk shape. That is the answer to "3,000-iteration chunks mean no
visibility": they do not.

**Would 1,500-iteration chunks have converged at 19? Untested, and I would not assume it.** What is measured:
300 failed (`res_dual` flat at ~0.6 over five chunks), 3,000 converged, and at 11 4,000-iteration chunks gave
`U` within 2e−4 of the unchunked value. The damage is per **restart**, so the question is how many a run can
absorb — 5 at 3,000, about 9 at 1,500, 47 at 300. **The test is cheap at 11 and nowhere else**: a
1,500-chunk run at 11 costs about four minutes and either reaches a clean `status solved` or does not. Run
that before shortening the interval at 23.
