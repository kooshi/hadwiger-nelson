# FS103-N — blind verification of Phase 3 (where the random-colouring number sits)

*Job FS103-N, Coxeter (verifier), Opus 5.5, 2026-09-26. Brief: `data/fs103/briefs/N103-measurable-blind-check.md` with
`data/fs103/briefs/STANDING-RULES.md`. Claims checked: `data/fs103/claims-m2.md` (statements only). Blind: nothing on the brief's fence
list opened until stage 3 is committed.*

## Theorems this phase proved

*(Filled at each stage; one line per theorem, grade, address.)*

- (stage 1: none — quotations and controls only)
- **N-M1** (stage 2, §2.1): for a finite positive Rajchman measure `σ` on `ℝⁿ` and a symmetric `T ⊆ supp σ`,
  `χ_CP(Cay(ℝⁿ, T)) ≤ χ_m⁰(ℝⁿ, σ)`; at `σ` = arc length on `S¹`, `χ_CP(ℝ²) ≤ χ_m⁰(ℝ²)`. [hand, one mind, blind]
- **N-SUPP** (§2.1): without `T ⊆ supp σ` the general form is false: `T = ±[1, 2] ∪ {±3}`, `σ` Lebesgue on `±[1, 2]`, has
  `χ_m⁰ ≤ 3 < 4 ≤ χ_CP`. [hand, one mind]
- **N-M1.1** (§2.2): the Lebesgue-point version of any translation-invariant Borel probability measure on `Δ_k`-valued `L^∞(ℝⁿ)`
  (weak-*) is a stationary, jointly Borel process continuous in `L¹(P)`, hence in probability. [hand, one mind]
- **N-M1.2** (§2.3): for Rajchman `σ` the set of `σ`-a.e.-proper fractional colourings is weak-* closed; for `σ = (δ₁ + δ₋₁)/2` on `ℝ`
  it is not (a sequence of everywhere-proper 2-colourings tends to `(1/2, 1/2)`). [hand, one mind]
- **N-FMTa** (§2.4): a stationary `[k]`-valued process on `ℝⁿ`, continuous in probability, has a jointly measurable version (dyadic
  discretisation + Borel–Cantelli); hence `χ_m⁰(ℝ²) ≤ χ_CP(ℝ²)`. [hand, one mind; re-derives the held C-FMT (a), (b)]
- **N-OP** (§2.4): `I` is independent for `[BachocEtAl2014]`'s `A_σ` (Def. 2.1 with (9)) iff `(Leb × σ){(x, w) : x, x + w ∈ I} = 0`;
  so `χ(A_σ) = χ_m⁰(ℝ²)`. [hand, one mind]
- **N-AE3** (§2.6): `χ(Cay(ℝ, {±1, ±√2})) = 2`, `χ_CP = 3`, `χ_m⁰ = χ_m = χ_B = 3`. [hand + tools exact, one mind]
- **N-Q4** (stage 3, §3.1): given MR(ℚ(√635087)) and the held collapse, `χ(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ) = χ(ℚ(√635087)²)`. [hand;
  a composition — its links' grades in §3.1]
- **N-EASY** (§2.7, C6): `χ(ℝ²) ≤ χ_m⁰(ℝ²)` with no MR and no CP (random rigid motion + Fubini + de Bruijn–Erdős). [hand, one mind;
  classical in shape]

## "Would have searched here" log

- Stage 2: none. Every step was a derivation or an exact check of seconds (`tools/fs103_n_checks.py`).

## Stage 1 — SAVED

### 1.1 Quotation check

Every quotation in the brief and in `data/fs103/claims-m2.md` whose source is open, checked against that source on disk.

| # | quotation (where it appears) | source checked | result |
|---|---|---|---|
| Q1 | D-CP (b), cited by claims-m2 § Definitions as "verbatim there" (`data/fs103/claims.md` §0) | `plans/FS100-BC-verification.md` lines 68–71 | **verbatim match** ("a random map `c : G → [k]` … No joint measurability is part of the definition. `χ_CP(ℝ²)`: the least `k` for which `UD(ℝ²)` carries one.") |
| Q2 | D-M's quoted clause "`χ_µ` is `[KechrisMarks2020]`'s (a µ-measurable colouring proper at every edge)" | `plans/M3-derivation.md` line 40 | **verbatim match**. The rest of D-M is `claims.md`'s own wording, as it says |
| Q3 | claims-m2 "Held, by statement": "every CP `k`-colouring of `UD(ℝ²)` has a jointly measurable version; hence `χ_m⁰(ℝ²) ≤ χ_CP(ℝ²)` (C-FMT (a), (b))" | `data/fs103/claims.md` C-FMT (a), (b) | **match** in substance and wording ("(a) every CP `k`-colouring of `UD(ℝ²)` has a jointly measurable version; (b) hence `χ_m⁰(ℝ²) ≤ χ_CP(ℝ²)`") |
| Q4 | M1 "C-FMT (c): `χ_CP(ℝ²) ≤ χ_m⁰(ℝ²)`" | `claims.md` C-FMT (c) | **verbatim match** |
| Q5 | M1″ "C-CPM with no MR: `χ_CP(ℝ²) ≤ χ_m(ℝ²) ≤ χ_B(ℝ²)`" | `claims.md` C-CPM: "`χ_CP(ℝ²) ≤ χ_m(ℝ²)`. … Judge it with no MR" | **match**; M1″ adds the trivial `≤ χ_B` |
| Q6 | claims-m2's "`χ(A_σ)` … read its definition there (§2.4, §2.6)" | `[BachocEtAl2014]` (arXiv 1301.1054, held at `~/source/library/pdf/arXiv-1301.1054-…pdf`) §2.4, §2.6 | **sections exist and hold the definitions**: §2.4 "The chromatic number of `A`, denoted by `χ(A)`, equals the smallest number `k` such that one can partition `V` into `k` independent sets" (independent: Def. 2.1, §2.3, "A measurable set `I ⊆ V` is called an independent set of `A` if `(Af, f) = 0` for each `f ∈ L²(V)` which vanishes almost everywhere outside of `I`"); §2.6 defines `χ_m(G)` (partition into measurable independent sets of the graph — every edge). **The operator `A_σ` itself is defined in §3.1, eq. (9)** (`(A_ν f)(x) = ∫ f(x − y) dν(y)`, `ν` a centrally symmetric signed Borel measure supported in `N`), which claims-m2 does not cite; it is the one used below |
| Q7 | the brief: `χ_m⁰` is "the measurable chromatic number with null sets of pairs ignored, which Bachoc–DeCorte–Oliveira–Vallentin (2014) define" | BDOV §2.3–2.4, §3.1 | **correct in substance only through an identification**: BDOV define `χ(A)` for an operator, and their `χ_m` is everywhere-proper (§3: "two points which are adjacent receive different colors"); the name `χ_m⁰` is not theirs. That `χ(A_σ) = χ_m⁰(ℝ²)` is M1′'s second equality, checked in stage 2, not a quotation |
| Q8 | the brief: "`Cay(ℝ, {±1, ±√2})`, where `χ = 2` and `χ_CP = 3` (**A-E3 in the claims**)" | `claims-m2.md`, `claims.md` | **A-E3 does not appear in either open claim file** (only A-E3′, `χ_m⁰(…) = 3`, in claims-m2). Its source is presumably a fenced file; not opened. The two values are re-derived in stage 2 (control C2) rather than taken as quoted |
| Q9 | `[Falconer1981]` "now held at `~/source/library/papers/falconer-1981-…-jcta-31-184-189.pdf`" | the file system; `BIBLIOGRAPHY.md` line 168 | file **present**; `BIBLIOGRAPHY.md` still reads "not held" — a correction owed (proposed row edit at the close of this record) |
| Q10 | I-CPUP "`χ(F²) ≤ χ_CP(ℝ²)` for every countable `F ⊆ ℝ`" (claims.md §1) | `LEDGER.md` row 125 | **verbatim match** |
| Q11 | the collapse "Given MR (row 120) and FS-103's collapse (two blind minds): `χ(ℝ²) = χ_CP(ℝ²) = χ(ℚ(√635087)²)`" (claims-m2, last line) | its proof is fenced; `claims.md` C-635-F1 has the same statement "given MR(ℚ(√635087))" | statement **consistent** with C-635-F1; taken as held by statement per claims-m2, grade and count as stated there |

`CLAUDE.md` G21 and G60 read from disk (lines 493 and 1104); they match the loaded text. `LEDGER.md` rows 92, 110, 120–127 read in full.

### 1.2 Controls — written before any derivation was written down

*Honest sequencing:* a sketch of a route for M1 formed while reading D-CP (b) and BDOV §2–§3; nothing was derived on paper or checked
before these controls were written. Each control says what a wrong-reason pass would look like.

**C1 — known positive, periodic: the randomly translated hexagonal 7-colouring `H`.** Hexagons of side `a = 2/5` in the plane's hexagonal
tiling, boundaries assigned half-open, coloured by the index-7 sublattice. Same hexagon: distance `≤ 2a = 4/5 < 1`; two same-coloured
hexagons: centres `√21·a` apart, so points `≥ (√21 − 2)a > 1` apart (`21 > 20.25`). So `H` is a Borel colouring proper at **every** edge,
and `H(· + T)`, `T` uniform on a fundamental domain of the period lattice, is a CP 7-colouring. Every claim must hold on it and every
construction applied to it must return it: `χ_CP, χ_m⁰, χ_m, χ_B ≤ 7`, and M1's construction fed `H` must output (a law equal to) the random
translate. *Wrong-reason pass:* `H` is periodic, so its orbit under translation is compact and a Følner limit of its translates is already
a measure on integral colourings — **C1 cannot exercise a weak-* / fractional step**; a proof whose fractional step is broken passes C1.
Hence C1b.

**C1b — known positive, non-periodic, with fractional limits.** Split each colour `j` of `H` into `j, j′` by a checkerboard of side
`ε_n` inside the annulus `n ≤ |x| < n + 1`, `ε_n → 0` (14 colours; a refinement of a proper colouring is proper at every edge). Translates
far out converge weak-* to the **fractional** colouring `g(x) = (e_{H(x)} + e_{H(x)′})/2`, still proper in the fractional sense. M1's route
fed this `f` must produce a CP 14-colouring (e.g. `H`-translate with a coin deciding primes), never an improper one. *Wrong-reason pass:*
a route that "handles" C1b by claiming Følner limits of translates are integral (false here).

**C2 — the arithmetic-free graph `Cay(ℝ, {±1, ±√2})` (brief).** Claimed `χ = 2`, `χ_CP = 3` (A-E3, quoted by the brief, source not open),
`χ_m⁰ = 3` (A-E3′). I re-derive all three. *What it can catch:* an argument for M1 or Q4 that never uses measurability of the input
colouring proves `χ_CP ≤ χ`, false here (3 > 2). *What it cannot catch:* M1's conclusion holds here (`3 ≤ 3`), and the edge measure
(atoms at `±1, ±√2`) is **not Rajchman** (`σ̂(q) → 1` along the Pell denominators `q`), so M1's Rajchman hypothesis puts this graph outside
M1's scope; C2 tests M1's *proof* only at its Rajchman step, where it must visibly stop. *Wrong-reason pass for A-E3′:* inferring
`χ_m⁰ = 3` from `χ_CP = 3` by an M1-type equality — circular here, since M1 is not claimed for atomic measures.

**C2′ — the same shape where the answer is 2: `Cay(ℝ, {±1, ±3})`.** `f(x) = ⌊x⌋ mod 2` is Borel and proper at every edge, so
`χ_m⁰ = χ_m = χ = 2`. Any lower-bound argument for A-E3′ must stop here, and at a named step (expected: the subgroup generated by the
"even" words is `2ℤ`, not dense).

**C3 — "almost every edge" to "every edge".** A CP colouring must satisfy `P(c(x) = c(x + w)) = 0` for **every** `w ∈ S¹`; measurable data
give it for almost every `w`. *Wrong-reason pass:* getting every `w` from translation invariance (that gives every `x` from almost every
`x`, never every `w`), or from a rotation invariance the construction never established. The step must use continuity in probability of
`w ↦ P(c(0) = c(w))` and full support of the edge measure on the connection set. *Control where it must stop:* a connection set larger than
the support of the edge measure (e.g. `T = S¹ ∪ {±(2, 0)}` with `σ` arc length): the construction then has no reason to be proper at
`±(2, 0)`. So the general form ("Rajchman edge measures on `ℝⁿ`") needs `T ⊆ supp σ` — checked in stage 2.

**C4 — M1.2 (properness under weak-* limits).** Positive: the circle measure is Rajchman (`σ̂(ξ) = J₀(2π|ξ|) → 0`). Negative (must exist
if "not otherwise" holds): `Cay(ℝ, {±1})` with `g_n(y) = ⌊ny⌋ mod 2` on `[0, 1)`, `g_n(y + 1) = 1 − g_n(y)`: every `g_n` proper at every
edge, `g_n ⇀ (1/2, 1/2)` weak-*, which is improper. *Wrong-reason pass:* "properness passes to limits because the set of proper colourings
is convex" — false (the fractional set `{g : g(x)·g(x + w) = 0 a.e.}` is not convex: `(e₁ + e₂)/2` against `(e₂ + e₃)/2` gives `1/4`); or
taking the **barycentre** `∫ g dμ` of the limit measure instead of the measure (the barycentre of an invariant measure is a constant
function, improper).

**C5 — M1.1 (continuity in probability).** Must stop at the i.i.d. uniform colouring of `ℝ²`: translation-invariant, `P(c(x) ≠ c(y)) =
1 − 1/k` for all `x ≠ y`, not continuous in probability, and it has no jointly measurable version. *Wrong-reason pass:* an argument that would
make **every** translation-invariant `[k]`-valued process continuous in probability; the argument must use that the measure lives on
`L^∞` (jointly measurable paths).

**C6 — Q4's easy half, as a consistency check.** With no MR and no CP: from a measurable colouring proper at almost every edge, every finite
unit-distance graph is `k`-colourable (random rigid motion + Fubini), so `χ(ℝ²) ≤ χ_m⁰(ℝ²)` by de Bruijn–Erdős. Q4's content given MR is
therefore the other direction, `χ_m⁰(ℝ²) ≤ χ(ℝ²)`; any account of Q4 that locates its strength elsewhere has misread it. Known bounds the
chain must respect: `5 ≤ χ_m⁰(ℝ²)` (I-CP57's density route: `m₁ < 1/4` bounds edge-null sets too) and `≤ 7` (C1).

**C7 — M1′ (the operator chromatic number).** `χ(A_σ)` must satisfy BDOV Thm 2.3's bound `χ(A_σ) ≥ (M − m)/(−m) = (1 + 0.40276)/0.40276
= 3.48…`, so `≥ 4`, and `≤ χ_m(ℝ²) ≤ 7` (BDOV §3.1). *Wrong-reason pass:* identifying `χ(A_σ)` with BDOV's `χ_m` (everywhere-proper) — that
would make M1′ assert `χ_m⁰ = χ_m`, which is C-FMT (d), not claimed here.

### 1.3 What stage 2 must decide (from the controls)

- M1: the route must pass C1, C1b, C3, C4 and stop at C2's Rajchman step.
- The general form's scope: `T ⊆ supp σ` (C3).
- M1.2 "not otherwise": existential (C4's example) or universal over non-Rajchman `σ`.

## Stage 2 — SAVED

*Notation.* `Δ_k ⊂ ℝ^k` the simplex spanned by the basis `e₁, …, e_k`. `X = {g ∈ L^∞(ℝⁿ; ℝ^k) : g(x) ∈ Δ_k a.e.}` with the weak-* topology
`σ(L^∞, L¹)`: compact (a weak-* closed subset of a ball) and metrizable (`L¹` separable); translations `(τ_t g)(x) = g(x + t)` act jointly
continuously. A colouring `f : ℝⁿ → [k]` is identified with `e_f ∈ X`. `σ` a finite positive Borel measure on `ℝⁿ`; **`σ`-a.e.-proper**
means `f(x) ≠ f(x + w)` for `(Leb × σ)`-a.e. `(x, w)`, and for `g ∈ X`, `g(x)·g(x + w) = 0` for `(Leb × σ)`-a.e. `(x, w)` (well defined on
classes: changing `g` on a null set `N` changes the pairs with `x + w ∈ N`, a `Leb × σ`-null set). `χ_m⁰(ℝⁿ, σ)` the least `k` with a
measurable `σ`-a.e.-proper `k`-colouring; at `σ` = arc length on `S¹` this is D-M's `χ_m⁰(ℝ²)`.

### 2.1 M1 — derived blind: TRUE (with the general form's scope made precise)

**Statement proved (N-M1).** Let `σ` be a finite positive **Rajchman** measure on `ℝⁿ` (`σ̂(ξ) → 0`), `T = −T ⊆ supp σ`. If `ℝⁿ` has a
measurable `σ`-a.e.-proper `k`-colouring `f`, then `Cay(ℝⁿ, T)` carries a CP `k`-colouring (D-CP (b)). At `n = 2`, `σ` = arc length,
`T = S¹ = supp σ`, `σ̂(ξ) = J₀(2π|ξ|) → 0`: **`χ_CP(ℝ²) ≤ χ_m⁰(ℝ²)`.**

*Proof.*

- **S1 (a Følner limit).** `μ_R = |B_R|⁻¹ ∫_{B_R} δ_{τ_t e_f} dt` is a Borel probability on `X` (`t ↦ τ_t e_f` is continuous). By compactness
  some `μ_{R_m} → μ` weak-*; `‖τ_s μ_R − μ_R‖_TV ≤ |B_R Δ (B_R + s)|/|B_R| → 0`, so `μ` is translation-invariant.
- **S2 (the edge functional is weak-* continuous — the Rajchman step).** `Φ(g) = ∫_{[0,1)ⁿ} ∫ g(x)·g(x + w) dσ(w) dx`, `0 ≤ Φ ≤ σ(ℝⁿ)`.
  For compactly supported `σ`: with `B` a ball containing `[0,1)ⁿ + supp σ`, `Φ(g) = ⟨1_Q g, K(1_B g)⟩`, `K h = 1_Q (h ⋆ σ)`, and `K` is a
  **compact** operator `L²(B) → L²(Q)`: it is the Fourier multiplier `σ̂` between two cut-offs; approximating `σ̂ ∈ C₀` uniformly by
  `ψ_N ∈ C_c`, each `1_Q M_{ψ_N} 1_B` has kernel `1_Q(x) ψ̌_N(x − y) 1_B(y) ∈ L²`, so is Hilbert–Schmidt, and the error is `≤ ‖σ̂ − ψ_N‖_∞`.
  If `g_m → g` weak-* in `X`, then `1_B g_m ⇀ 1_B g` weakly in `L²`, so `K(1_B g_m) → K(1_B g)` in norm, and `Φ(g_m) → Φ(g)`. For a finite
  `σ` of unbounded support: `φσ`, `φ ∈ C_c`, has Fourier transform `φ̂ ∗ σ̂ ∈ C₀`, and `|Φ_σ − Φ_{φσ}| ≤ ‖σ − φσ‖`, so `Φ_σ` is a uniform limit
  of continuous functionals.
- **S3 (the limit is a.e.-proper).** `Φ(τ_t e_f) = 0` for every `t` (that is `f`'s a.e.-properness on `[0,1)ⁿ + t`), so `∫Φ dμ = lim ∫Φ dμ_{R_m}
  = 0`; `Φ ≥ 0` gives `Φ = 0` `μ`-a.s., and by invariance `Φ(τ_z g) = 0` for all `z ∈ ℤⁿ` a.s.; summing over the tiles, `μ`-a.s. `g` is
  `σ`-a.e.-proper. **The limit need not be integral** (control C1b), which is why S4–S5 round.
- **S4 (a jointly Borel stationary version).** `A_r(g, x) = |B_r|⁻¹∫_{B(x, r)} g` is jointly continuous on `X × ℝⁿ`; `G(g, x) =
  lim_{m→∞} A_{1/m}(g, x)` where the limit exists, `e₁` elsewhere. `G` is Borel, `Δ_k`-valued, `G(g, ·) = g` a.e. (Lebesgue
  differentiation), and **`G(τ_t g, x) = G(g, x + t)` exactly**, so `(G(·, x))_{x}` under `μ` is stationary.
- **S5 (M1.1).** `E|G(h) − G(0)|₁ = E ∫_{[0,1)ⁿ} |g(x + h) − g(x)|₁ dx → 0` as `h → 0` (stationarity, Fubini, `L¹_loc`-continuity of
  translation for each `g`, dominated convergence). So `G` is continuous in `L¹(P)`.
- **S6.** By S3 and Fubini on `μ ⊗ Leb ⊗ σ` (the integrand `1[G(x)·G(x + w) > 0]` is jointly Borel), `p(w) := P(G(0)·G(w) > 0) = 0` for
  `σ`-a.e. `w`.
- **S7 (rounding by one shared threshold).** `U` uniform on `[0, 1)`, independent of `g`; `S_j = G₁ + ⋯ + G_j`; `c(x) = j` iff
  `S_{j−1}(x) ≤ U < S_j(x)`. Then:
  (i) **stationary** (a fixed Borel function of the stationary `G` and the independent `U`);
  (ii) **continuous in probability**: `c(x) ≠ c(y)` forces `U` between `S_j(x)` and `S_j(y)` for some `j`, so `P(c(x) ≠ c(y)) ≤
  k·E|G(x) − G(y)|₁ → 0` by S5;
  (iii) if `G(x)·G(x + w) = 0` then for each `j` one of the two intervals `[S_{j−1}, S_j)` at `x`, `x + w` is empty, so `c(x) ≠ c(x + w)`;
  hence `q(w) := P(c(0) = c(w)) ≤ p(w) = 0` for `σ`-a.e. `w`;
  (iv) **every edge**: `|q(w) − q(w′)| ≤ P(c(0) ≠ c(w′ − w))`, so `q` is continuous; `{q = 0}` is closed and `σ`-full, hence contains
  `supp σ ⊇ T`; by stationarity `P(c(x) = c(x + w)) = 0` for every `x` and every `w ∈ T`. ∎

**Where the controls bite.**
- **C1** (the hexagonal colouring `H`): `μ` is the uniform law of `τ_t H`, `t` on the period torus; `G` is `e_{H}` off the cell boundaries
  (a null set for each fixed `x`), so `c` has the law of the random translate. **Reproduced.**
- **C1b** (fine checkerboard splits): `μ` is carried by `g = (e_{H(·+t)} + e_{H(·+t)′})/2`; S7 gives `H`-translate with one global coin
  choosing primes, proper at every edge. **Passes, and exercises S3–S7 on a fractional limit.**
- **C2** (`Cay(ℝ, {±1, ±√2})`, `σ` atomic): the proof **stops at S2**: `σ̂(q) → 1` along Pell denominators (`tools/fs103_n_checks.py`
  `nonraj`: `0.99999999` at `q = 13860`), `K` is not compact, and C4 shows the loss is real. The proof uses the measurable input `f`
  throughout, so it cannot yield `χ_CP ≤ χ` (false there: `3 > 2`). **Stops where it must; proves nothing too much.**
- **C3** (every `w`): used exactly at S7 (iv), through continuity of `q` and `T ⊆ supp σ`.

**The general form's scope (N-SUPP).** `T ⊆ supp σ` cannot be dropped. `T = ±[1, 2] ∪ {±3} ⊂ ℝ`, `σ` Lebesgue on `±[1, 2]` (Rajchman,
absolutely continuous). `f(x) = ⌊x⌋ mod 3` is Borel and proper at every `w ∈ [1, 2]` (`⌊x + w⌋ − ⌊x⌋ ∈ {1, 2}`), so `χ_m⁰(ℝ, σ) ≤ 3`; but
`{x, x + 1, x + 2, x + 3}` is a `K₄` in `Cay(ℝ, T)` (differences `1, 2, 3, 1, 2, 1`), so `χ_CP ≥ χ ≥ 4`. **So if M1's "general form for
Rajchman edge measures on `ℝⁿ`" is `Cay(ℝⁿ, T)` with `σ` merely carried by `T`, it is FALSE; with `T ⊆ supp σ` (e.g. `T = supp σ`) it is
TRUE.** The exact wording is trimmed from claims-m2; scored at stage 4.

### 2.2 M1.1, first half — TRUE (N-M1.1)

"Continuity in probability is free for invariant measures on fractional colourings": for any translation-invariant Borel probability on
`X`, S4–S5 give a stationary, jointly Borel version continuous in `L¹(P)`. **Control C5 stops it where it must:** the i.i.d. uniform
colouring is translation-invariant and not continuous in probability, and it is not the law of any `X`-valued (jointly measurable) field —
the argument uses `L¹_loc`-continuity of translation of each sample, which only `L^∞` samples have.

### 2.3 M1.2 — the positive half TRUE; "not otherwise" TRUE as an existential (N-M1.2)

- **Rajchman ⟹ closed:** `{g ∈ X : σ`-a.e.-proper`} = ⋂_{z ∈ ℤⁿ} {Φ∘τ_z = 0}`, closed by S2.
- **"not otherwise", existential:** `σ = (δ₁ + δ₋₁)/2` on `ℝ`: `g_m(y) = ⌊m y⌋ mod 2` on `[0, 1)`, `g_m(y + 1) = 1 − g_m(y)`; each `g_m` is a
  2-colouring proper at every edge, and `g_m → (1/2, 1/2)` weak-*, which is improper (`g·g(· + 1) = 1/2`). (C4.)
- **"not otherwise", universal** (for **every** non-Rajchman `σ` some sequence of `σ`-a.e.-proper colourings has an improper weak-* limit):
  **not derived here.** `Φ` is discontinuous whenever `σ̂ ↛ 0` (a small-amplitude high-frequency perturbation of a fractional point), but
  closedness of the proper set is a different statement. If the trimmed claim means the universal form, it is **GAP at "every non-Rajchman
  σ"**; as an existential it is TRUE.
- **Wrong-reason lines checked:** the proper set is not convex (`(e₁ + e₂)/2 · (e₂ + e₃)/2 = 1/4`); the barycentre `∫ g dμ` of an invariant
  measure is constant and improper — S3 works with the measure, never its barycentre.

### 2.4 M1′ — TRUE: `χ_CP(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ)`

- `χ_CP ≤ χ_m⁰`: N-M1.
- `χ_m⁰ ≤ χ_CP`: the held C-FMT (a), (b), which I also re-derived (N-FMTa). *Version:* for a CP colouring `c` of `ℝⁿ`, let `c_m(x) = c(d_m(x))`,
  `d_m(x)` the dyadic corner of `x` at scale `2⁻ᵐ` (jointly measurable); `sup_x P(c_m(x) ≠ c(x)) ≤ ε_m := sup_{|h| ≤ √n 2⁻ᵐ} P(c(0) ≠ c(h))
  → 0` (stationarity makes continuity in probability uniform); along `m_j` with `Σ ε_{m_j} < ∞`, Borel–Cantelli makes `c_{m_j}(x)` eventually
  equal to `c(x)` a.s. for each `x`; `c̃ = lim c_{m_j}` (where it exists; `1` elsewhere) is jointly measurable and `c̃(x) = c(x)` a.s. for
  each `x`. *Then:* `E ∫∫ 1[c̃(x) = c̃(x + w)] dσ(w) dx = ∫∫ P(c(x) = c(x + w)) = 0`, so almost every sample path is a measurable
  `σ`-a.e.-proper `k`-colouring.
- `χ_m⁰ = χ(A_σ)` (N-OP). `[BachocEtAl2014]` §3.1 eq. (9): `A_σ f = f ∗ σ` on `L²(ℝ²)`, `σ` centrally symmetric, supported in `N = S¹`
  (bounded, `0` not in its closure: the section's hypotheses hold). Def. 2.1: measurable `I` is independent iff `(A_σ f, f) = 0` for every
  `f ∈ L²` vanishing a.e. off `I`. *If* `I` is edge-null (`(Leb × σ){x ∈ I, x − y ∈ I} = 0`), the integrand `f(x − y) f(x)` of `(A_σ f, f)`
  vanishes a.e. (BDOV's own argument, §3.1, run with "a.e." for "every"); *conversely* `f = 1_{I ∩ B_r}` gives `(Leb × σ){x, x − y ∈ I ∩ B_r}
  = 0` for every `r`. §2.4: `χ(A)` is the least `k` partitioning `V` into `k` independent sets; a measurable `k`-colouring is `σ`-a.e.-proper
  iff each class is edge-null. Hence `χ(A_σ) = χ_m⁰(ℝ²)` — **definitional given BDOV's definitions; the equality is not stated in BDOV**,
  whose §3.1 states only `χ(A_ν) ≤ χ_m`. Control C7: BDOV Thm 2.3 gives `χ(A_σ) ≥ (1 + 0.40276)/0.40276 = 3.48`, consistent.

### 2.5 M1″ — TRUE: `χ_CP(ℝ²) ≤ χ_m(ℝ²) ≤ χ_B(ℝ²)`, no MR

`χ_m⁰ ≤ χ_m` (everywhere-proper is a.e.-proper) and `χ_m ≤ χ_B` (Borel is Lebesgue measurable); with N-M1, `χ_CP ≤ χ_m⁰ ≤ χ_m ≤ χ_B`.
**C-CPM therefore holds with no MR and not only through C-dG-F1 or C-635-F1.** With the known bounds: `5 ≤ χ_CP = χ_m⁰ ≤ χ_m ≤ χ_B ≤ 7`
(lower: I-CP57; upper: C1).

### 2.6 A-E3′ — TRUE; and A-E3's two values re-derived (N-AE3)

- **Upper, `χ_B ≤ 3`:** `f(x) = ⌊3{(2/5)x}⌋`. For `s ∈ [1/3, 2/3]`, `t` and `t + s mod 1` never share a third; `2/5 ∈ [1/3, 2/3]` and
  `(2/5)√2 = √8/5 ∈ [1/3, 2/3]` (`25/9 ≤ 8 ≤ 100/9`), and `s ↦ 1 − s` handles `−d`. Exact: `tools/fs103_n_checks.py` `circ` (plant
  `α = 1/2` fires: `√2/2 > 2/3`).
- **Lower, `χ_m⁰ ≥ 3`:** a measurable `f : ℝ → {0, 1}` with `f(x + d) = 1 − f(x)` a.e. for `d = 1, √2` is a.e.-invariant under `1 + √2` and
  `1 − √2`, hence under `Λ = {m + n√2 : m ≡ n (mod 2)}`, which is dense (`checks cosets`: `1154 − 816√2 ≈ 1.7·10⁻³` lies in it). `t ↦
  ∫ f(x + t)φ(x) dx` is continuous and constant on `Λ`, so constant; `f` is a.e. constant, contradicting `f(x + 1) = 1 − f(x)`. **C2′
  stops it where it must:** for `{±1, ±3}`, `Λ = 2ℤ`, not dense, and `⌊x⌋ mod 2` is a Borel 2-colouring.
- **A-E3 (quoted by the brief, source fenced), re-derived:** `χ = 2` — a cycle's `±1` steps and `±√2` steps each sum to 0, so it has even
  length; colour each coset of `ℤ + ℤ√2` by the parity of `m + n` (choice of coset representatives). `χ_CP = 3` — `≤`: `⌊3{(2/5)x + U}⌋`,
  `U` uniform; `≥`: a CP 2-colouring has `c(x + λ) ≠ c(x)` a.s. for every `λ = m + n√2` with `m + n` odd (finitely many a.s. steps), and
  such `λ` tend to 0 (`577 − 408√2 ≈ 8.7·10⁻⁴`), contradicting continuity in probability.

### 2.7 Control C6 — the easy half of Q4, unconditional (N-EASY)

From a measurable `σ`-a.e.-proper `k`-colouring `f` of `ℝ²` and a finite unit-distance graph with vertices `v_i`: for each edge, the map
`(ρ, t) ↦ (t + ρv_i, ρ(v_j − v_i))` pushes Haar × Lebesgue onto a multiple of `Leb × σ`, so for almost every rigid motion `(ρ, t)` every edge
is proper under `f(ρ· + t)`; by de Bruijn–Erdős `χ(ℝ²) ≤ χ_m⁰(ℝ²)`. (M1 with I-CPUP and I-DBE gives the same.) **So Q4's content given MR is
the other direction, `χ_m⁰(ℝ²) ≤ χ(ℝ²)`, and it rests entirely on the collapse (`χ_CP ≤ χ` given MR) and C-FMT (b).**

### 2.8 Reading: `[Falconer1981]` (held, `~/source/library/papers/falconer-1981-…pdf`)

Read in full (§§1–3, pp. 184–189). Theorem 2 (`ℝⁿ` covered by `n + 2` measurable sets: one contains a unit pair) gives `χ_m(ℝ²) ≥ 5`. Its
method **places a configuration meeting the null boundary set `E` in exactly one point** (Lemma 1) and transfers by small translations
(Lemma 3); the pair it produces is a single pair, so as written it bounds `χ_m` (everywhere-proper) and **not** `χ_m⁰`. `χ_m⁰(ℝ²) ≥ 5`
comes instead from the density route (I-CP57: a class of upper density `≥ 1/4` against `m₁ ≤ 0.2470`, the autocorrelation of an edge-null
set vanishing on all of `S¹` by continuity). Bears on C-FMT (d) (not this job's claim): Falconer's argument cannot by itself turn an
a.e.-proper colouring into an everywhere-proper one.

### 2.9 Files

`tools/fs103_n_checks.py` (four exact checks, each with a plant that fires alone); output `data/fs103/fs103-n/checks-stage2.txt`
(script exit statuses read directly: all 0; each plant "fired alone, as it must").

## Stage 3 — SAVED (committed before anything fenced was opened)

### 3.1 Q4 — TRUE given MR and the held collapse, as a composition of four links

"given MR: `χ(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ) = χ(ℚ(√635087)²)`" (claims-m2). The chain:

| link | statement | status here |
|---|---|---|
| L1, the collapse | given MR(ℚ(√635087)): `χ(ℝ²) = χ_CP(ℝ²) = χ(ℚ(√635087)²)` | **held by statement** (claims-m2: two blind minds); its proof is fenced from this job and **not checked here** |
| L2 | `χ_CP(ℝ²) ≤ χ_m⁰(ℝ²)` | N-M1, derived blind (§2.1) |
| L3 | `χ_m⁰(ℝ²) ≤ χ_CP(ℝ²)` | held C-FMT (a), (b) (two blind minds); re-derived here (N-FMTa) |
| L4 | `χ_m⁰(ℝ²) = χ(A_σ)` | N-OP, definitional from `[BachocEtAl2014]` Def. 2.1, §2.4, §3.1 (9) |

L2 ∧ L3 ∧ L4 is M1′, unconditional; with L1, Q4 follows. **Grade: [hand], conditional on MR at ℚ(√635087) (row 120's grade, EL2021 Thm 1.2
external) and on L1 at its held grade.** MR applies: `635087` is prime and `≡ 7 (mod 8)` (sympy, seconds), so `ℚ₂(√635087) = ℚ₂(√7) =
ℚ₂(i)`, the dyadic place splits in `F(i)`, no stable dyadic place exists and `R = O′` — row 120's hypothesis, consistent with C-635-PL (not
this job's claim).

**Where Q4's strength lives (C6).** `χ(ℝ²) ≤ χ_m⁰(ℝ²)` holds with no MR (N-EASY). So Q4's new content is `χ_m⁰(ℝ²) ≤ χ(ℝ²)`, which comes
from L1 (`χ_CP ≤ χ` given MR) through L3. **Q4 is exactly as strong as the collapse; M1 adds the identification, not the strength.** The
flattering reading "Hadwiger–Nelson is a question about measurable colourings" is correct given MR and L1, and in this form: *the least
number of colours for a colouring of the plane equals the least number for a measurable colouring whose monochromatic unit pairs form a
null set of `ℝ² × S¹`* (not the everywhere-proper `χ_m`, whose relation to `χ_m⁰` is C-FMT (d), not claimed here).

**G21 audit of the pleasing result.** The acceptance tests were the controls: C1 and C1b (known positives) reproduced; C2, C2′, C4, C5
stopped the arguments where they must; C3 found a real scope condition (N-SUPP), i.e. one statement in the family is false as it may be
worded; C7 consistent. The one link that could make Q4 false and that this job did not check is L1.

### 3.2 Verdicts (count of minds: this job's, blind; FS103-M's derivation not yet read)

| claim | verdict | grade | note |
|---|---|---|---|
| **M1** (`χ_CP(ℝ²) ≤ χ_m⁰(ℝ²)`) | **TRUE** | [hand], one mind here (blind) | §2.1, route: Følner limit on the weak-* space of fractional colourings; Rajchman compactness; Lebesgue-point version; one shared threshold; continuity for every `w` |
| M1, "general form for Rajchman edge measures on `ℝⁿ`" | **TRUE with `T ⊆ supp σ`; FALSE without** | [hand], one mind | N-SUPP counterexample `T = ±[1, 2] ∪ {±3}` (`χ_m⁰ ≤ 3 < 4 ≤ χ_CP`); MISSTATED if the trimmed wording lacks the support condition — scored at stage 4 |
| **M1′** | **TRUE** | [hand], one mind; `χ_m⁰ ≤ χ_CP` also held (two) | the equality with `χ(A_σ)` is definitional, not stated in BDOV (§3.1 there gives only `χ(A_ν) ≤ χ_m`) |
| **M1″** | **TRUE** | [hand], one mind | trivial from M1; **C-CPM holds with no MR**, not only through C-dG-F1 or C-635-F1 |
| **M1.1** | **TRUE** | [hand], one mind | needs the `L^∞` (jointly measurable) setting; C5 (i.i.d.) shows it fails for general invariant random colourings |
| **M1.2** | **TRUE** for "survives when `σ̂ → 0`"; **TRUE** for "not otherwise" as an existential (C4); **GAP** if "not otherwise" means every non-Rajchman `σ` | [hand], one mind | |
| **A-E3′** | **TRUE** | [hand + tools exact], one mind | and A-E3's `χ = 2`, `χ_CP = 3` re-derived (§2.6) |
| **Q4** | **TRUE given MR and L1** | [hand], a composition | L1 unchecked here (fenced) |

### 3.3 Items for the owner (proposed; the close writes them)

- **Correction owed, `BIBLIOGRAPHY.md` line 168** `[Falconer1981]`: "not held" → held at `~/source/library/papers/falconer-1981-…-jcta-31-184-189.pdf`;
  "read in full (§§1–3), 2026-09-26, FS103-N"; "its Lemma 1 meets the null boundary in one point, so Theorem 2 bounds `χ_m`, not `χ_m⁰`".
- **`BIBLIOGRAPHY.md` `[BachocEtAl2014]` read status:** add §2.5, §2.6 to Thm 2.5's statement, §3.1 (eq. (9) and the respect argument), §3.2's opening.
- **`BIBLIOGRAPHY.md` `[KechrisMarks2020]` read status:** §3's definitions of `χ⁰_B`, `χ⁰_µ`, `χ^ap_µ` (p. 18) and §5 Example 5.1 (pp. 45–46).
- **Naming clash (for FS-20 / any write-up):** Kechris–Marks' `χ⁰_µ` is the minimum over **invariant conull vertex sets**; on the connected
  `UD(ℝ²)` it equals `χ_B`. The project's `χ_m⁰` ignores **null sets of edges**. Write-ups should rename (e.g. `χ_m^{a.e.}`) or say so.
- **Scope condition for any ledger row of M1's general form:** `T ⊆ supp σ` (N-SUPP).
- **Prior-art debt:** "an a.e.-proper measurable colouring of an amenable group with a Rajchman edge measure yields a stationary colouring
  continuous in probability" not searched (invariant random colourings; factor-of-i.i.d. and ergodic-theory literatures). BDOV do not state
  `χ(A_σ) = χ_m⁰`.
