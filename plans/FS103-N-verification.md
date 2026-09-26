# FS103-N — blind verification of Phase 3 (where the random-colouring number sits)

*Job FS103-N, Coxeter (verifier), Opus 5.5, 2026-09-26. Brief: `data/fs103/briefs/N103-measurable-blind-check.md` with
`data/fs103/briefs/STANDING-RULES.md`. Claims checked: `data/fs103/claims-m2.md` (statements only). Blind: nothing on the brief's fence
list opened until stage 3 is committed.*

## Theorems this phase proved

*(Filled at each stage; one line per theorem, grade, address.)*

- (stage 1: none — quotations and controls only)

## "Would have searched here" log

- (none yet)

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
