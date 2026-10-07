# FS133-E1 — the one-class transfer: the opening's record and the derivation of its claims

*Ephodos, job FS133-E1 (brief: `data/fs133/briefs/FS133-E1-opening-and-derivation.md`). The plan, with §G, §PA and §IQ, is
`plans/FS133-one-class-transfer.md`; the claim list is `data/fs133/claims.md`. The outside release is `[OAIMath2026]` family 158 at
commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a` of `/home/kooshi/source/math` (read, never written); **M** is its
`preprints/The-Euclidean-plane-is-not-five-colorable-September-23-2026/build/sections/`. Checks: `tools/fs133_e1_*.py`; their
outputs and the search files: `data/fs133/e1/`, `data/fs133/pa/`.*

*Notation, fixed once.* `F = ℚ̄ ∩ ℝ`, `E = F(i)` the algebraic plane (Johnson's `𝒜²`), `K = {u ∈ E : |u| = 1}`, `D` the compact dual
of the discrete group `E`, `C ⊂ D` the continuous characters `z ↦ exp(iξ·z)` (M's Definition 2.1). `UD(X)`: the unit-distance graph
on `X ⊆ ℝ²`. `σ`: normalised arc length on `S¹`. For a finite `G ⊂ ℝ²`, `α(G)` is the independence number of `UD(G)` and
`α₁(G) = α(G)/|G|`; `α₁(X) = inf{α₁(G) : G ⊆ X finite}` for `X = ℝ²` or `E` (`[MatolcsiEtAl2025]` p. 5 for `ℝ²`). A measurable
`A ⊆ ℝ²` is *1-avoiding* if no two of its points are at distance 1, and *edge-null* if `(Leb × σ){(x, u) : x ∈ A, x + u ∈ A} = 0`.
`m₁(ℝ²)`: "the supremum of the upper densities of measurable sets A ⊆ R2 containing no two points at distance 1"
(`[DuczVarga2026]` § 2.1). A *window sequence* is a sequence `(X_n)` of bounded measurable subsets of `ℝ²` of positive measure; the
*upper density of `A` along it* is `limsup_n |A ∩ X_n|/|X_n|`. `χ_f(ℝ²)`, `χ_f,0(ℝ²)`: `[MatolcsiEtAl2025]` p. 4, quoted in the
plan's § PA.3.

## Theorems this phase proved

(Filled stage by stage; each line: the entry, its verdict, its grade, its address.)

- Stage 1 proved none (a readback and an opening).
- Stage 2 proved none (recognition).
- **C133-DENS-CLASS** — the reverse-Fatou step at its class (any σ-finite space, any window sequence, mean `≥ α` almost everywhere): TRUE. [hand], one mind. Stage 3, § Argument for C133-DENS.
- **C133-DENS** (posed) — TRUE. [derived] from C133-DENS-CLASS. Stage 3.
- **C133-INV-CLASS** — for every symmetric `K`-invariant connection set on `E`, an `E ⋊ K`-invariant law on independent sets with vertex marginal equal to the infimum of `α(G)/|G|` over finite `G ⊂ E`, and no translation-invariant law above it: TRUE. [hand], one mind. Stage 4, § Argument for C133-INV.
- **C133-INV** (posed) — TRUE. [derived] from C133-INV-CLASS. Stage 4.
- **C133-EASY** — `m₁(ℝ²) ≤ α(G)/|G|` for every finite `G`: TRUE. [hand], one mind; known. Stage 5, § Argument for the relay-results.
- **C133-PER** — periodisation, and the three printed definitions of `m₁(ℝ²)` are one number: TRUE. [hand], one mind; known. Stage 5.
- **C133-DP** — the density points of an edge-null measurable set are 1-avoiding: TRUE. [hand], one mind; the release's Lemma 4.3 for one class. Stage 5.
- **C133-CHIF** — `χ_f(ℝ²) ≤ 1/m₁(ℝ²)`: TRUE. [derived] from C133-PER; a checking re-derivation of FS103-B-CHIF. Stage 5.
- **C133-ALG** — every `E ⋊ K`-invariant random independent set of the algebraic plane has density at most `m₁(ℝ²)`: TRUE. [hand] over `[OAIMath2026]` family 158's Theorem 2.3 (`wild_fourier`), one mind. Stage 5, § Argument for C133-ONE.
- **C133-ONE** (posed) — `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)` and `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`, no hypothesis: TRUE. [derived] from C133-ALG, C133-INV-CLASS, C133-EASY, C133-CHIF; one mind; over the same outside theorem. Stage 5.
- **C133-FN** — `f(n)/n → m₁(ℝ²)`: TRUE. [derived] from C133-ONE. Stage 5.
- **C133-PAIR** — for finitely many labels and forbidden label pairs at a countable set of algebraic distances: a labelling of the plane exists iff one of the algebraic plane exists iff a measurable one exists almost everywhere: TRUE, each direction argued. [hand] over `[OAIMath2026]` family 158's Theorem 2.3, one mind. Stage 6, § Argument for C133-PAIR, § Converse for C133-PAIR.
- **C133-HOM** (posed) — TRUE, both directions. [derived] from C133-PAIR. Stage 6.

## Stage 1 — SAVED: the readback, the definitions at their pages, and the opening

**1.1 The readback.** `tools/fs133_e1_readback.py` reads every quotation of a file (a run of `> ` lines closed by
`> — source: <path>`) and looks for each quoted line verbatim in its source.
- The brief: **7 quotations, 7 lines matched, 0 mismatched**, exit 0 (`data/fs133/e1/readback-brief.out`).
- The claim list: **4 quotations, 4 matched**, exit 0 (`data/fs133/e1/readback-claims.out`).
- Planted fault (`--fault` changes the last character of each quoted line): 0 matched, 7 mismatched, exit 1
  (`data/fs133/e1/readback-brief-fault.out`) — the check fires.
- No mismatch, so no finding about the brief's quotations. Two notes on what the quoted sources say, neither a mismatch:
  (a) the stub cites FS103-B-AMEN's Følner half as "two blind minds … `plans/FS103-derivation.md` l. 86", and that line grades the
  entry "[hand, one mind (B)]"; row 129 is the source of "two blind: F, B; FS105-W-D1". C133-INV below re-derives the half at `E`
  and rests on neither count. (b) C133-DENS is posed with "`= α` for every `x`"; the field the transfer produces has that mean
  only at almost every `x` (M/transfer.tex:221–224, "correct as an `L²(μ)` representative for almost every `x`"). The derivation
  below is stated at the weaker hypothesis, which is the one the use needs — a statement note for the claim list, reported.

**1.2 What was read before any derivation.** The brief; `plans/STANDING-RULES.md`; `data/fs133/claims.md`;
`plans/STUB-one-class-transfer.md` whole; `plans/EXT-OAI2-reading.md` ll. 1–400 (stages 1–2, § 2.6 whole); `M/transfer.tex` whole
(316 lines) and `M/spectral.tex` ll. 1–100; `plans/EXT-OAI1-audit.md` stage 6 and stage 8; `LEDGER.md` row 129; `plans/FS103-derivation.md`
whole; `plans/FS103-B-verification.md` §§ 2–3; `plans/FS103-F-fractional-shadow.md` § 3; `CLOSED-QUESTIONS.md` ll. 654–667; the
grokkings (preloaded). The four printed sources at their pages (the plan's § PA.3): `[MatolcsiEtAl2025]` pp. 4–5,
`[DuczVarga2026]` pp. 1–4, `[Johnson1996fcn]` pp. 102–107, `[Johnson2000surprises]` pp. 142–143.

**1.3 Three definitions of upper density are in use, and the claims must not depend on which.** `[DuczVarga2026]` and
`[AmbrusEtAl2023]` say "upper density" without a window; `[MatolcsiEtAl2025]` defines `m₁(ℝ²) = inf_X m₁(X)` over sets of finite
positive measure; DeCorte–de Oliveira Filho–Vallentin (arXiv:1804.09099 § 6) use `sup_p limsup_T` over cubes `p + [−T, T]ⁿ`. So
C133-DENS is derived for every window sequence, and the periodisation lemma (stage 5) shows the three suprema are one number.

**1.4 The opening.** §G (twelve entries bear, the rest listed silent), §PA (fifteen arXiv queries, two web searches, four printed
questions read at their pages; zbMATH down, owed at the second pass; **nothing found stating the claim, no listing after
2026-09-28**) and §IQ are in `plans/FS133-one-class-transfer.md`, with the routes, five registered predictions and the stage table.

**1.5 The gate at this stage.** `derive_gate.py all` on this record exits 1 with its one failure "no derivation entry", as it must
before stage 3 writes the first entry; from stage 3 on it is run before every commit.

## Stage 2 — SAVED: recognition (`ephodos-recognition`, invoked fresh), one pass per claim, before any derivation

*Per claim: the problem written for a stranger in the field that owns it; the features sorted (determines / accompanies / unsorted,
each with its receipt or the receipt owed); several homes, each tested; the forced description; the class. A recognition that
differs from the plan's picture is marked **finding**.*

### 2.1 C133-DENS

**For a probabilist.** A jointly measurable random field `H(x, ω) ∈ [0, 1]` on a σ-finite measure space, with mean at least `α` at
almost every point. Show that with positive probability the support `{H(·, ω) > 0}` has upper density at least `α` along a given
sequence of windows. *This is the reverse Fatou lemma applied to the window averages of `1_{H>0} ≥ H`.*

| feature | sort | receipt |
|---|---|---|
| `H ≤ 1` | determines | consumed as `1_{H>0} ≥ H`; without it `H = 2·1_A` has mean `α` and support of density `α/2` |
| `H ≥ 0` | determines (the second clause only) | consumed as "`H(x)H(x+u) = 0` iff not both positive"; a signed `H` can have zero product-integral with overlapping supports |
| mean `= α` at **every** `x` | accompanies | the argument runs with "`≥ α` at almost every `x`" (Tonelli reads the mean only under `dx`) |
| the plane, discs | accompanies | the argument runs on any σ-finite space and any window sequence |
| the unit distance, `S¹` | accompanies the density clause | the edge-null clause holds for almost every `ω` by hypothesis; the density clause holds on an event of positive probability; they meet |
| stationarity of the field | accompanies | not in the hypothesis, not consumed |
| "for **some** `ω`" | determines the conclusion | cannot be "almost every": a half-half mixture of the empty set and a set of density `2α` (§ Argument for C133-DENS, (c)) |
| **upper** density | determines the conclusion | cannot be lower density: the alternating-blocks field (control `dens-direction`) |

**Homes.** (1) *Probability — reverse Fatou.* Applies at once; nothing to change. **Adopted.** (2) *Ergodic theory — Wiener's
pointwise theorem for `ℝ²`.* Gives more (almost sure convergence), but its dictionary has a false line here: it needs a jointly
measurable **action**, and the field is only an `L²` class at almost every `x` (M/transfer.tex:133, "No pointwise action of `ℝ²` is
needed"). Killed at that line. (3) *Functional analysis — a Banach limit of the window averages.* `LIM A_n ≤ limsup A_n` and
`∫ LIM = LIM ∫` would do it, but a Banach limit of measurable functions need not be measurable. Killed at measurability.
**Class.** Any σ-finite `(X, λ)`, any window sequence, mean `≥ α` almost everywhere. **Finding:** the claim holds more widely than
posed, and its two clauses are independent. The route is the stub's hunch.

### 2.2 C133-INV

**For an ergodic theorist.** A countable amenable group (`E ⋊ K`, abelian by abelian) acts by automorphisms on a countable graph,
transitively on its vertices. Show that some invariant probability on the compact space of independent sets has vertex marginal at
least the infimum of `α(G)/|G|` over finite induced subgraphs. *This is the invariant-measure form of the independence ratio of an
amenable vertex-transitive graph.*

| feature | sort | receipt |
|---|---|---|
| amenability of `E` and of `K` | determines | consumed twice: Følner sets in `E`; a fixed point for the abelian `K` on a compact convex set. A counterexample without it is recalled (Conley–Kechris, not read), so its necessity is **unsorted** here and not claimed |
| countability | accompanies the existence, determines the use | Tychonoff needs none; C133-ONE needs a standard probability space |
| local finiteness | accompanies | never consumed: each edge constraint is clopen in `{0,1}^E` whatever the degree (here every degree is infinite) |
| the unit distance | accompanies | the argument runs for `Cay(E, S)`, any symmetric `K`-invariant `S ⊆ E ∖ {0}` |
| the infimum over `G ⊂ E`, not `G ⊂ ℝ²` | determines the statement | the Følner pieces are subsets of `E`; this is the direction C133-ONE needs, so no redrawing |

**Homes.** (1) *Amenability — Følner averaging and Markov–Kakutani.* Applies at once. **Adopted.** (2) *Descriptive combinatorics —
the measurable independence number of an amenable action* (plan § PA.4). Same statement in the locally finite setting; explains,
and predicts nothing new here. (3) *Fractional graph theory — for a vertex-transitive graph `χ_f = |V|/α`.* **It predicts a
neighbour:** an invariant law with vertex marginal `δ` restricts to a fractional colouring of weight `1/δ` of every finite `G ⊂ E`,
so `sup_G χ_f(G) = 1/α₁(E)` — `[MatolcsiEtAl2025]`'s Theorem 2 at the algebraic plane, in two lines and without their discrete
cubes. Used in stage 5. **Class.** `Cay(E, S)` as above, with equality: the supremum of `P(0 ∈ I)` over invariant laws **is** the
infimum. **Finding:** equality, and a wider class, where the claim poses `≥` at the unit distance.

### 2.3 C133-ONE

**For a harmonic analyst.** A stationary `{0,1}`-valued process on the discrete additive group of the algebraic plane, invariant
under multiplication by algebraic numbers of modulus 1, never 1 at two points at distance 1. Show its mean is at most the density
of a measurable planar set avoiding distance 1. *Its covariance is a positive-definite function on the discrete plane, radial under
the algebraic rotations; this is the decomposition of an isotropic covariance into a continuous part and a nugget* — the classical
statement for measurable radial positive-definite functions on `ℝ²` is Crum's and Gneiting–Sasvári's (named by the manuscript,
M/spectral.tex:81–88; **recalled by me, not read**), and the release's Theorem 2.3 is its form on `E` with no measurability.

| feature | sort | receipt |
|---|---|---|
| the field is all of `ℚ̄ ∩ ℝ` | determines | consumed by Theorem 2.3 (divisibility of `K`, square roots; the reading § 2.2). Counterexample at a number field: over `K₀ = ℚ(√3,√11)` a class of Theorem B's residue colouring is an invariant independent set of density `1/4 > 0.247 ≥ m₁` (row 129's mechanism line; G60) |
| invariance under the rotations | consumed; necessity **unsorted** | Theorem 2.3's hypothesis; no translation-invariant, rotation-variant counterexample is exhibited, and none is claimed |
| the indicator is nonnegative | determines | consumed twice: `p ≥ 0` turns `⟨p, T_u p⟩ = 0` into disjoint supports, and `p ≤ 1` feeds C133-DENS |
| the other classes; `Σ p_i = 1` | accompanies | the manuscript consumes it once, at the choice of a label (M/transfer.tex:248–251); one class needs no choice |
| the unit distance | accompanies | consumed only as "`K` is transitive on the algebraic unit circle and dense in `S¹`", true of every algebraic radius |
| dimension two | consumed; necessity **unsorted** | amenability of `E ⋊ K` and the homomorphisms `u ↦ uⁿ` (the reading § 2.4) |

**Homes.** (1) *This project's own: row 129's fractional local–global principle (FS103-F-FRAC, steps D1–D8 of
`plans/FS103-B-verification.md` § 2.1), at the field with no stable place, with MR(F) replaced by Theorem 2.3.* The old proof
applies at once: D1–D5 word for word, D6's completion is `ℝ²` alone, D8's product count has one factor. The exceptions vanish (no
head, no tail, no torus). It predicts neighbours: the formula `max(m₁, sup_v r_v)` with an empty supremum; the same for any
algebraic distance. **Adopted.** (2) *Positive-definite functions: continuous part plus nugget.* The same statement in another
field's words; it predicts that **cross**-covariances split the same way (C133-HOM). Kept as the name. (3) *Descriptive
combinatorics: a Rokhlin tiling.* Killed: the dictionary line "an independent set of a Følner tile ↔ a measurable set" is false in
the plane — the tiles of the discrete plane are not measurable sets, which is the whole content of the rigidity theorem.
**Class.** Every `E ⋊ K`-invariant random independent set of `UD(E)` has vertex marginal at most `m₁(ℝ²)`; hence
`α₁(E) = m₁(ℝ²)`. **No finding against the plan:** the description is the stub's. Two additions: the `χ_f` clauses rest on a
measurable half that row 129 holds at one mind (FS103-B-CHIF — its home is `[Johnson1996fcn]`'s Question 5 and, in the locally
finite world, Bernshteyn's theorem), so it is re-derived; and the remaining step is **not** the problem renamed — it is a kernel-checked
outside theorem.

### 2.4 C133-HOM

**For an ergodic theorist.** A stationary process of unit coordinate vectors `(f_i)_{i ∈ V(H)}` on the discrete algebraic plane,
rotation-invariant, with `P(f_i(0) = 1 = f_j(u)) = 0` at unit `u` for every pair `(i, j)` not an edge of `H`. Show the continuous
parts `p_i` have `𝔼[p_i(0) p_j(u)] = 0` for those pairs. *This is the spectral theory of a multivariate stationary process: its
spectral measure is a positive-semidefinite matrix of measures, and each off-diagonal entry is dominated by the two diagonal ones.*

| feature | sort | receipt |
|---|---|---|
| the constraint is on **pairs** | determines | consumed as "the constraint is the vanishing of second moments `⟨f_i, T_u f_j⟩`"; a three-point constraint is a third moment, which Theorem 2.3 does not address — necessity **unsorted**, not claimed |
| `H` is a graph; the forbidden pairs are its non-edges | accompanies | the argument runs for any set of forbidden label pairs |
| the unit distance | accompanies | as in 2.3: any set of algebraic distances |
| the labels partition; `Σ p_i = 1` | determines | consumed at the selection of a label; with it dropped the statement is C133-ONE's, not a homomorphism |
| `V(H)` finite | consumed | compactness of `V(H)^E` and of `V(H)^{ℝ²}`; necessity unsorted |

**Homes.** (1) *Multivariate spectral theory.* Two routes to the cross terms, by different mathematics: **polarisation** (apply
Theorem 2.3 to the vectors `b_i + b_j` and `b_i + i·b_j`), and **domination** (the cross measure is absolutely continuous to Haar
with a bounded density, its Fourier coefficients are constant on the infinite orbits `Kz` and square-summable, hence zero off 0).
Both applied at once. **Adopted, both.** (2) *The release's Proposition 4.2 with `K_k` replaced by `H`* — the stub's picture; the
one changed step is the cross term. Same content. (3) *Constraint satisfaction on amenable groups.* Explains the shape; predicts
nothing more. **Class.** Finitely many labels; for each algebraic distance `r` in a countable set, a set of forbidden label pairs.
**Finding:** C133-HOM is an instance of that class statement (entry C133-PAIR, stage 6); the argument is the same line for line.

## Stage 3 — SAVED: C133-DENS, the unchecked step — derived

**Verdict: TRUE as posed, and at a wider class.** The posed statement is the entry `C133-DENS`, quoted from the stub; the statement
its argument carries is `C133-DENS-CLASS`, which is the form C133-ONE consumes (the transfer's field has its mean only at almost
every `x`). The step is the reverse Fatou lemma; this project had already used it in words at the same place of row 129's chain
(`plans/FS103-F-fractional-shadow.md` § 3.4, link 1: "The reverse Fatou lemma (`E[limsup_R avg_{B_R} 1_W] ≥ P(0 ∈ W)`) gives a
realisation of upper density `≥ P(0 ∈ W)`"), so the reading's "unchecked step" was a step held but not cited there.

derivation: C133-DENS-CLASS
  statement: let `(X, λ)` be a σ-finite measure space, `(Ω, μ)` a probability space, `α ≥ 0`, and `H : X × Ω → [0, 1]`
    measurable for the product σ-algebra, with `∫ H(x, ω) dμ(ω) ≥ α` for `λ`-almost every `x`; let `(X_n)` be measurable subsets
    of `X` with `0 < λ(X_n) < ∞`; then `D(ω) = limsup_n λ({x ∈ X_n : H(x, ω) > 0}) / λ(X_n)` is measurable and `∫ D dμ ≥ α`, so
    `μ{D ≥ α} > 0` and every event of full `μ`-measure contains an `ω` with `D(ω) ≥ α`
  uses only: Tonelli on each `X_n × Ω`; the pointwise bound `1_{H>0} ≥ H`, which is `H ≤ 1`; Fatou's lemma for the nonnegative
    functions `1 − A_n`; that `μ` is a probability
  not claimed: that almost every `ω` has `D(ω) ≥ α` — in the mixture of § Argument for C133-DENS (c) half of them have
    `D = 0`; nor the same with `liminf` in place of `limsup` — false for the alternating annuli (control `dens-direction`); nor
    that the window averages converge — no stationarity is assumed
  argument: § Argument for C133-DENS
  verdict: derived
  grade: hand
  minds: 1
  model: `X = ℝ²`, `Ω` the period torus of the packing of open discs of radius 1/2 centred on `2(ℤ(1,0) + ℤ(1/2, √3/2))`,
    `H(x, t) = 1_A(x + t)`: the mean is the density `π/(8√3) = 0.2267…` at every `x`, and `D(t)` is that density for every `t`
    and every sequence of discs of radius tending to infinity (control `dens-model`)
  prior art: known: the reverse Fatou lemma; used at this place in `plans/FS103-F-fractional-shadow.md` § 3.4 link 1
  handoff: de Bruijn — the statement as written, over Mathlib's product measures (Tonelli) and Fatou's lemma; no outside theorem

derivation: C133-DENS
  statement: Let `H : ℝ² × Ω → [0, 1]` be jointly measurable with `∫ H(x, ω) dμ(ω) = α` for every
    `x` and, for `μ`-almost every `ω`, `H(x, ω) H(x + u, ω) = 0` for almost every `(x, u) ∈ ℝ² × S¹`. Then for some `ω` the set
    `{x : H(x, ω) > 0}` has upper density at least `α` and is unit-avoiding almost everywhere.
  uses only: `C133-DENS-CLASS` at `X = ℝ²`, `X_n = B(0, n)`, with the full-measure event of the second hypothesis; and that for
    `H ≥ 0` the product `H(x, ω) H(x + u, ω)` is positive at just those `(x, u)` with both `x` and `x + u` in the set
  not claimed: that the set is 1-avoiding at every pair — that is the density-point step, entry `C133-DP`; nor anything for
    almost every `ω`; nor lower density
  argument: § Argument for C133-DENS
  verdict: derived
  grade: derived from: C133-DENS-CLASS
  minds: 1
  model: the model of `C133-DENS-CLASS`: the packing is 1-avoiding, so the second hypothesis holds for every `t`
  prior art: known: an instance of `C133-DENS-CLASS`
  handoff: none — subsumed by `C133-DENS-CLASS`, which crosses

control: dens-direction
  of: C133-DENS-CLASS — the direction of the conclusion, on the alternating-annuli field of mean 1/2 at every point: for both
    samples the largest exact window average over discs of radius 2^(k+1), 6 ≤ k ≤ 40, is at least 1/2
  run: python3 ../tools/fs133_e1_dens_control.py upper
  expect: True
  fault: python3 ../tools/fs133_e1_dens_control.py lower

control: dens-model
  of: C133-DENS-CLASS — the model: discs of radius 1/2 on the lattice of spacing 2 are 1-avoiding (all centres at distance ≥ 2)
  run: python3 ../tools/fs133_e1_dens_control.py packing 2
  expect: True
  fault: python3 ../tools/fs133_e1_dens_control.py packing 19/10

### Argument for C133-DENS

**The class statement.** Put `W = {(x, ω) : H(x, ω) > 0}`, a measurable subset of `X × Ω`, and
`A_n(ω) = λ({x ∈ X_n : (x, ω) ∈ W}) / λ(X_n)`. Since `λ(X_n) < ∞`, Tonelli on `X_n × Ω` makes each `A_n` measurable, with
`0 ≤ A_n ≤ 1`, and gives

`∫ A_n dμ = λ(X_n)⁻¹ ∫_{X_n} ∫_Ω 1_W dμ dλ ≥ λ(X_n)⁻¹ ∫_{X_n} ∫_Ω H dμ dλ ≥ α`.

The first inequality is `1_W ≥ H` pointwise (where `H > 0` it reads `1 ≥ H`; where `H = 0` it reads `0 ≥ 0`); the second is the
hypothesis on the mean, read under `dλ`, so a `λ`-null set of `x` is invisible to it. `D = limsup_n A_n` is measurable. Fatou's
lemma for `1 − A_n ≥ 0` gives `∫ liminf_n (1 − A_n) dμ ≤ liminf_n ∫ (1 − A_n) dμ`, that is `∫ D dμ ≥ limsup_n ∫ A_n dμ ≥ α`
(here `μ(Ω) = 1` is used). If `μ{D ≥ α} = 0` then `α − D > 0` almost everywhere and `∫ D dμ < α`: so `μ{D ≥ α} > 0`, and an
event of full measure meets it.

**The posed statement.** Take `X = ℝ²` with Lebesgue measure and `X_n = B(0, n)`. The upper density of a set,
`limsup_{R→∞} |A ∩ B(0, R)| / |B(0, R)|` over real `R`, is at least its `limsup` over integers, which is `D(ω)`. Let `N` be the
event of the second hypothesis. For `ω ∈ N` and `A = {x : H(x, ω) > 0}`: as `H ≥ 0`, `1_A(x) 1_A(x + u) = 1` iff
`H(x, ω) H(x + u, ω) > 0`, which happens on a `(Leb × σ)`-null set of `(x, u)`; so `A` is edge-null, which is what "unit-avoiding
almost everywhere" means. An `ω ∈ N` with `D(ω) ≥ α` is the one asked for. "`= α` for every `x`" was used only as "`≥ α` for almost
every `x`".

**What the conclusion cannot be.** (a) *Not lower density.* Let `S_0`, `S_1` be the unions of the annuli
`{4^k ≤ |x|² < 4^{k+1}}` with `k` even, odd (the unit disc in `S_0`), `A` the packing of the model with density `d`, `t` uniform on
its period torus, `j` a fair coin, `H(x, (j, t)) = 1_A(x + t) 1_{S_j}(x)`. The mean is `d/2` at every `x` and every sample is
1-avoiding. In `B(0, 2^{k+1})` the set `S_j` has area fraction `4/5` or `1/5` in the limit, as `k ≡ j` or not (mod 2) (exact
fractions: the control), so every sample has upper density `4d/5 ≥ d/2` and lower density `d/5 < d/2`. (b) *The windows matter to
which `ω`, not to the bound:* the statement is for each window sequence separately. (c) *Not almost every `ω`.* With the same `A`
and `t`, let `H(x, (j, t)) = j·1_A(x + t)`: the mean is `d/2` at every `x`; the samples with `j = 0` are empty and those with
`j = 1` have density `d`. Half of the `ω` work.

**Is the claim the right statement for its use?** Yes, in the class form. The transfer's field represents `T_x p` "for almost
every `x`" (M/transfer.tex:223–224), and `∫ T_x p dμ = ⟨T_x p, 1⟩ = ⟨p, 1⟩` for every `x` because the extended operators are
unitary and fix the constant; so the field's mean is `∫ p dμ` at almost every `x`, which is the class statement's hypothesis and
not the posed one's.

**Theorems this stage proved** (also listed at the head): `C133-DENS-CLASS` — TRUE, [hand], one mind; `C133-DENS` (posed) — TRUE,
[derived] from it.

## Stage 4 — SAVED: C133-INV — derived, with equality and at its class

**Verdict: TRUE.** The posed clause is entry `C133-INV`; its class is `C133-INV-CLASS`. It reads **no statement of the release**
(the manuscript's step F2 averages a point mass over a Følner sequence of `E ⋊ K`; this averages maximum independent sets of
Følner pieces of `E` and then fixes the rotations). No redrawing lemma and no Tarski: the infimum is over finite subsets of `E`.

derivation: C133-INV-CLASS
  statement: let `S ⊆ E ∖ {0}` be symmetric and invariant under multiplication by `K`, let `𝓘_S ⊆ {0,1}^E` be the compact space
    of independent sets of `Cay(E, S)`, and let `a_S` be the infimum of `α(G)/|G|` over finite nonempty `G ⊂ E`, `α(G)` the
    independence number of the subgraph of `Cay(E, S)` induced on `G`; then some `E ⋊ K`-invariant Borel probability on `𝓘_S` has
    `P(0 ∈ I) = a_S`, and every `E`-invariant Borel probability on `𝓘_S` has `P(0 ∈ I) ≤ a_S`
  uses only: that `E` is a countable abelian group (a Følner sequence; a compact metrizable `{0,1}^E`); that each edge constraint
    is a clopen condition on two coordinates; that `K` is abelian, fixes `0`, and normalises the translations
    (`τ_z ρ_u = ρ_u τ_{uz}`); the Markov–Kakutani fixed-point theorem; linearity of expectation
  not claimed: that the invariant law is ergodic, or unique; that a single independent set of `E` has density `a_S` in any
    sense; anything with the infimum taken over finite subsets of `ℝ²` (that infimum is smaller or equal, and its equality with
    `a_S` at the unit distance is `C133-ONE`'s, by another route); necessity of amenability
  argument: § Argument for C133-INV
  verdict: derived
  grade: hand
  minds: 1
  model: `S = K` (the unit distance): the Moser spindle is seven points of `E` with eleven unit pairs and independence number 2
    (control `inv-spindle`), and a proper 7-colouring exists, so `1/7 ≤ a_K ≤ 2/7` and the law is not trivial
  prior art: known: the invariant-measure form of the independence ratio of an amenable vertex-transitive graph; this project's
    FS103-B-AMEN at number fields (`plans/FS103-B-verification.md` § 2.1, "The equalities"); `[MatolcsiEtAl2025]` Theorem 1's
    Følner averaging is the same device on fractional colourings
  handoff: de Bruijn — the statement at `S = K` suffices for `C133-ONE`; over Mathlib's weak-* compactness of probability
    measures on a compact metrizable space and a fixed-point or second-average step for `K`; no outside theorem

derivation: C133-INV
  statement: At the algebraic plane `E = ℚ̄`: there is an `E ⋊ K`-invariant probability on the independent subsets of
    the unit-distance graph of `E` with `P(0 ∈ I) ≥ inf α(G)/|G|` over finite `G ⊂ E`
  uses only: `C133-INV-CLASS` at `S = K`; `K` is symmetric (`−1 ∈ K`) and closed under multiplication by `K`
  not claimed: the items of `C133-INV-CLASS`'s line; in particular nothing about finite subsets of `ℝ²` outside `E`
  argument: § Argument for C133-INV
  verdict: derived
  grade: derived from: C133-INV-CLASS
  minds: 1
  model: the model of `C133-INV-CLASS`
  prior art: known: FS103-B-AMEN's Følner half, restated at `E`
  handoff: none — subsumed by `C133-INV-CLASS`, which crosses

control: inv-spindle
  of: C133-INV-CLASS — the model at the unit distance: the Moser spindle in exact arithmetic over ℚ(√−3, √−11) ⊂ E, printed as
    points, unit pairs, independence number
  run: python3 ../tools/fs133_e1_spindle.py 11
  expect: 7 11 2
  fault: python3 ../tools/fs133_e1_spindle.py 13

### Argument for C133-INV

*Set-up.* `{0,1}^E` is compact and metrizable because `E` is countable; `𝓘_S` is the intersection of the clopen sets
`{I : not (z ∈ I and z' ∈ I)}` over pairs with `z − z' ∈ S`, so it is closed. For `z ∈ E` and `u ∈ K` put `τ_z I = I − z` and
`ρ_u I = u⁻¹ I`. Both are homeomorphisms of `{0,1}^E` preserving `𝓘_S` (for `ρ_u`: `u⁻¹z − u⁻¹z' ∈ S` iff `z − z' ∈ uS = S`),
`τ` and `ρ` are actions of `E` and `K`, and `ρ_u τ_w I = u⁻¹I − u⁻¹w = τ_{u⁻¹w} ρ_u I`, that is `τ_z ρ_u = ρ_u τ_{uz}`: together
they are an action of `E ⋊ K`.

*(1) The upper bound, for every `E`-invariant law.* Let `ν` be an `E`-invariant Borel probability on `𝓘_S` and `G ⊂ E` finite,
nonempty. `ν{g ∈ I} = ν{0 ∈ τ_g I} = ν{0 ∈ I}` for each `g`, so `∫ |I ∩ G| dν = |G|·ν{0 ∈ I}`; and `|I ∩ G| ≤ α(G)` for every
`I ∈ 𝓘_S`. Hence `ν{0 ∈ I} ≤ α(G)/|G|`, and `ν{0 ∈ I} ≤ a_S`.

*(2) A translation-invariant law of density at least `a_S`.* A countable abelian group has a Følner sequence: finite nonempty
`G_n ⊂ E` with `|(G_n + z) △ G_n| / |G_n| → 0` for every `z` (amenability of abelian groups and the Følner criterion, as the
manuscript cites them at M/transfer.tex:157–161; concretely, `E` is torsion-free, so the subgroup generated by the first `n`
elements of an enumeration is free of finite rank, and a cube of side `n²` in a basis of it will do). Let `I_n ⊆ G_n` be a maximum
independent set of the induced graph, `|I_n| = α(G_n) ≥ a_S |G_n|`, and `ν_n = |G_n|⁻¹ Σ_{r ∈ G_n} δ_{τ_r I_n}`, a probability on
`𝓘_S`. Then `ν_n{0 ∈ I} = |{r ∈ G_n : r ∈ I_n}| / |G_n| = α(G_n)/|G_n| ≥ a_S`. For `z ∈ E`,
`(τ_z)_* ν_n = |G_n|⁻¹ Σ_{r ∈ G_n + z} δ_{τ_r I_n}`, so its total-variation distance from `ν_n` is at most
`|(G_n + z) △ G_n| / |G_n| → 0`. Take a weak-* convergent subsequence, with limit `ν`: it is carried by the closed set `𝓘_S`, it
is `τ_z`-invariant for every `z`, and since `{0 ∈ I}` is clopen, `ν{0 ∈ I} = lim ν_n{0 ∈ I} ≥ a_S`.

*(3) The rotations.* Let `M` be the set of `E`-invariant Borel probabilities `ν` on `𝓘_S` with `ν{0 ∈ I} ≥ a_S`. It is nonempty
by (2), convex, and weak-* compact (each condition is closed). For `u ∈ K` the map `ν ↦ (ρ_u)_* ν` is affine and continuous and
maps `M` into itself: `(τ_z)_*(ρ_u)_* ν = (ρ_u)_*(τ_{uz})_* ν = (ρ_u)_* ν`, and `(ρ_u)_* ν{0 ∈ I} = ν{0 ∈ u⁻¹I} = ν{0 ∈ I}`
because `u⁻¹·0 = 0`. These maps commute (`K` is abelian), so by Markov–Kakutani they have a common fixed point `μ ∈ M`: an
`E ⋊ K`-invariant probability on `𝓘_S` with `μ{0 ∈ I} ≥ a_S`, and `= a_S` by (1).

*The posed clause.* `S = K`: `Cay(E, K)` is the unit-distance graph of `E`, `−1 ∈ K`, and `K·K = K`.

**Theorems this stage proved:** `C133-INV-CLASS` — TRUE, [hand], one mind; `C133-INV` (posed) — TRUE, [derived] from it.

## Stage 5 — SAVED: C133-ONE — derived, over the release's Theorem 2.3; five relay-results first

*Two words from the coordinator arrived during this stage and were read before it went on. (1) The claim list now names
`C133-DENS-CLASS` as the form C133-ONE consumes — this stage does consume that form. (2) New scripts and their outputs go under
`data/fs133/e1/`, not `tools/`, while a landing is in flight; this stage's one script is `data/fs133/e1/chif_count.py`, and the
three already in `tools/` stay.*

**Verdict: TRUE** — `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)` and `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`, with no hypothesis, at [hand], one
mind, **over one outside theorem**: `[OAIMath2026]` family 158, Theorem 2.3 (in its Lean, `wild_fourier`), which this argument
reads itself — not through the release's transfer theorem. No step of F3–F9 uses `Σ p_i = 1` but the choice of a label, which one
class does not make. No Tarski and no redrawing lemma is used. `m₁(ℝ²)` is the same number under each of the three printed
definitions (`C133-PER`).

derivation: C133-EASY
  statement: for every finite nonempty `G ⊂ ℝ²` and every measurable 1-avoiding `A ⊆ ℝ²`, `α(G) ≥ d·|G|`, where `d` is the upper
    density of `A` along the discs `B(0, R)`; hence `m₁(ℝ²) ≤ α₁(ℝ²)`
  uses only: that `{g ∈ G : g + t ∈ A}` is independent in `UD(G)` for every `t`; that `|B(0, R) ∖ B(0, R − r)| / |B(0, R)| → 0`
  not claimed: the reverse inequality (that is `C133-ONE`); the weighted form with `χ_f(G)` (`[DuczVarga2026]` Claim 1)
  argument: § Argument for the relay-results
  verdict: derived
  grade: hand
  minds: 1
  model: `G` the Moser spindle, `α(G)/|G| = 2/7 = 0.2857…`, above every known bound on `m₁(ℝ²) ≤ 0.247`
  prior art: known: `[MatolcsiEtAl2025]` (14); `[DuczVarga2026]` § 2.1, "the standard averaging argument"
  handoff: de Bruijn — crosses, as one half of `C133-ONE`; no outside theorem

derivation: C133-PER
  statement: for every measurable 1-avoiding `A ⊆ ℝ²`, every `L > 1` and every `q ∈ ℝ²`, the set
    `(A ∩ (q + [1/2, L − 1/2)²)) + Lℤ²` is measurable, `Lℤ²`-periodic and 1-avoiding, of density at least
    `|A ∩ (q + [0, L)²)| / L² − 2/L`; consequently four numbers coincide — the supremum of the densities of periodic measurable
    1-avoiding sets, the supremum of upper densities of measurable 1-avoiding sets along the discs `B(0, R)`, the same with
    `sup_p limsup_T` over the squares `p + [−T, T]²`, and `inf_X sup_A |A|/|X|` over `X` of finite positive measure and
    measurable 1-avoiding `A ⊆ X`
  uses only: that two points of different copies differ by more than 1 in some coordinate; that a strip of width 1/2 inside a
    square of side `L` has area below `2L`; averaging over the squares of a tiling, and over the translates of a periodic set
  not claimed: that any of the suprema is attained (held separately, FS106-SUP, row 131); anything in dimension three or more
  argument: § Argument for the relay-results
  verdict: derived
  grade: hand
  minds: 1
  model: `A` the disc packing of stage 3 and `L = 4`: `A` is already periodic and the statement only loses the strip
  prior art: known: periodisation is standard (`[AmbrusEtAl2023]` § 2 cites it; `plans/FS103-B-verification.md` D7 uses it);
    `[MatolcsiEtAl2025]` p. 5 asserts the agreement of two of the definitions
  handoff: de Bruijn — crosses only if the Lean statement of `C133-ONE` is wanted for more than one definition of `m₁`

derivation: C133-DP
  statement: if `W ⊆ ℝ²` is measurable and edge-null, then the set `W*` of points at which `W` has Lebesgue density 1 is
    measurable, differs from `W` by a null set, and contains no two points at distance 1
  uses only: the Lebesgue density theorem; that a point uniform in `B(x, h)` plus an independent unit vector uniform on an arc
    of length comparable to `h` has a law with density at most `1/(πh²)`, carried by a disc of radius `2h`
  not claimed: anything about points of positive upper density that are not density points (FS103-M-D's (D1) says more)
  argument: § Argument for the relay-results
  verdict: derived
  grade: hand
  minds: 1
  model: `W` the disc packing with a null set of points added at distance 1 from it: `W*` is the packing
  prior art: known: `[OAIMath2026]` family 158, Lemma 4.3 (M/transfer.tex:266–295), whose proof uses one class at a time;
    FS103-M-D (D1); the method is `[Falconer1981]`'s (the manuscript's attribution)
  handoff: de Bruijn — crosses; the release's Lean does not contain its Lemma 4.3 (`plans/EXT-OAI1-audit.md` stage 6)

derivation: C133-CHIF
  statement: for every `ε > 0` there are finitely many 1-avoiding subsets `U_1, …, U_N` of `ℝ²` and an integer
    `n ≥ (m₁(ℝ²) − ε)·N` such that every point of `ℝ²` lies in `n` of them; hence `χ_f(ℝ²) ≤ 1/m₁(ℝ²)` for the fractional
    chromatic number of `[MatolcsiEtAl2025]` p. 4 and for `[Johnson1996fcn]`'s
  uses only: `C133-PER` with an integer period; that `{x : |P ∩ B(x, r)| > (3/4)|B(x, r)|}` is open and 1-avoiding when `P` is;
    that an open set is a union of half-open dyadic squares; that a half-open square of side `s` contains one point of each
    coset of `sℤ²`
  not claimed: `χ_f(ℝ²) ≥ 1/m₁(ℝ²)` (that is `C133-ONE`); that the sets can be taken to be translates of a set of density
    `m₁(ℝ²)` itself; anything for geometric fractional colourings
  argument: § Argument for the relay-results
  verdict: derived
  grade: derived from: C133-PER
  minds: 1
  model: the disc packing, which is open: with it the construction gives `χ_f(ℝ²) ≤ 8√3/π + o(1) = 4.41…`
  prior art: known: FS103-B-CHIF (`plans/FS103-B-verification.md` § 3.2 (v), one mind, read before this was written — so this
    is a checking re-derivation, not a blind one); the assertion is Fisher–Ullman's, and `[Johnson1996fcn]` p. 105, Question 5,
    asks "if that assertion at the end of [7] is true, and … for a proof"
  handoff: de Bruijn — crosses, for the `χ_f` clauses of `C133-ONE`; no outside theorem

control: chif-count
  of: C133-CHIF — the counting step, exactly: 16 half-open grid cells in a period, 36 translates, every tested point (cell
    interiors, edges and corners) in the same number of translates as there are cells
  run: python3 ../data/fs133/e1/chif_count.py halfopen
  expect: 16 [16]
  fault: python3 ../data/fs133/e1/chif_count.py closed

derivation: C133-ALG
  statement: every `E ⋊ K`-invariant Borel probability on the space of independent sets of the unit-distance graph of the
    algebraic plane `E` has `P(0 ∈ I) ≤ m₁(ℝ²)`
  uses only: from `[OAIMath2026]` family 158 — Theorem 2.3 through one consequence, that a `K`-invariant probability `ν` on `D`
    with `ν(C) = 0` has `Re ∫ ψ_1 dν ≥ 0` (the theorem gives `= 0`), and Lemma 4.1 (the continuous vectors are `L²` of a factor
    and the spectral subspace on `C`, with a strongly continuous positive unitary extension to `ℝ²` that commutes with the
    rotations); that the indicator of `{0 ∈ I}` is `[0, 1]`-valued and rotation-fixed; that `K` is dense in `S¹`; a jointly
    measurable version of an `L²`-continuous field; Tonelli; `C133-DENS-CLASS`; `C133-DP`
  not claimed: the same at any number field's plane — over `ℚ(√3,√11)` a colour class of Theorem B's residue colouring is an
    invariant independent set of density `1/4 > m₁(ℝ²)`, and every step below but Theorem 2.3 runs there; the same for laws
    invariant under translations alone; the form with several algebraic distances (the argument reads the distance only as
    "`K` is transitive on the algebraic circle of that radius and dense in the real one", but no entry is written)
  argument: § Argument for C133-ONE
  verdict: derived
  grade: hand
  minds: 1
  model: the law of `C133-INV-CLASS` at `S = K`: an `E ⋊ K`-invariant probability with `P(0 ∈ I) = α₁(E) ∈ [1/7, 2/7]`
  prior art: partly: the chain is this project's FS103-F-FRAC (row 129; `plans/FS103-B-verification.md` § 2.1, D1–D7) with MR
    replaced by the release's theorem; the observation that one class runs is `plans/EXT-OAI2-reading.md` § 2.6; not found in
    print — fifteen arXiv queries and two web searches on 2026-10-07 UTC, zbMATH owed (the plan's § PA.2)
  handoff: de Bruijn — over `wild_fourier` as a declared outside theorem (the import's third); the release's label-model lemmas
    (`projected_unit_correlation`, `fieldVector_unit_correlation`, `exists_label_field`) are stated for its `LabelModel.measure`
    and are not consumable here — see § What C133-ONE reads of the release

derivation: C133-ONE
  statement: `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`, and `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`
  uses only: `C133-INV-CLASS` at `S = K` (a law of density `α₁(𝒜²)`); `C133-ALG`; `C133-EASY`; that an infimum over fewer
    graphs is larger; `C133-CHIF`; `χ_f(G) ≥ |G|/α(G)` for finite `G`; that a fractional colouring restricts to a subgraph
  not claimed: any value of `m₁(ℝ²)` or of a chromatic number; `m₁(ℝ²) = δ_Croft`; that some finite graph attains
    `sup χ_f(G)` (`[Johnson1996fcn]` Question 2); anything at a number field's plane (row 129's field form keeps "given MR");
    anything at six colours — `1/m₁(ℝ²) ≤ 4.36`; that the release states any of this
  argument: § Argument for C133-ONE
  verdict: derived
  grade: derived from: C133-ALG, C133-INV-CLASS, C133-EASY, C133-CHIF
  minds: 1
  model: every term is a number in `[0.2293, 0.2470]` or its reciprocal in `[4.0487, 4.3599]` (`[AmbrusEtAl2023]` Theorem 1;
    Croft's set), so no side of an equality is vacuous
  prior art: partly: row 129 holds both lines given MR at ℚ(√635087) (FS103-F-DV, two minds); the questions are
    `[MatolcsiEtAl2025]` § 2, `[Johnson1996fcn]` Questions 1 and 3, `[Johnson2000surprises]` Problems 3 and 4, read at their
    pages; with no hypothesis: not found in print, at the scope of the plan's § PA.2
  handoff: de Bruijn — the statement over `wild_fourier`; the planner chooses how many of the six equalities to state

derivation: C133-FN
  statement: `f(n)/n → m₁(ℝ²)` as `n → ∞`, where `f(n)` is the minimum of `α(G)` over `n`-point subsets `G` of the plane
  uses only: `C133-ONE`'s `α₁(ℝ²) = m₁(ℝ²)`; `α₁(ℝ²) = inf_n f(n)/n` by definition; `f(a + b) ≤ f(a) + f(b)` (two
    configurations placed far apart); Fekete's lemma
  not claimed: any rate; `m₁(ℝ²) = δ_Croft`, the second clause of `[DuczVarga2026]` Conjecture 1
  argument: § Argument for C133-ONE
  verdict: derived
  grade: derived from: C133-ONE
  minds: 1
  model: `f(7) ≤ 2` (the Moser spindle), so `f(7)/7 ≤ 0.2857…`
  prior art: partly: `[DuczVarga2026]` Conjecture 1, first clause, "f (n)/n = m1 (R2 ) + o(1)"; held given MR as FS103-F-DV
  handoff: none — a corollary of `C133-ONE` by Fekete's lemma; the planner may state it

### Argument for the relay-results

**C133-EASY.** Let `G ⊂ B(0, r)`, and `R_n → ∞` with `|A ∩ B(0, R_n)| / |B(0, R_n)| → d`. For `t ∈ ℝ²` the set
`J(t) = {g ∈ G : g + t ∈ A}` is independent in `UD(G)`, since two of its points at distance 1 would give two points of `A` at
distance 1; so `|J(t)| ≤ α(G)`. Averaging over `t ∈ B(0, R_n)`:
`α(G) ≥ |B(0, R_n)|⁻¹ Σ_{g ∈ G} |A ∩ (B(0, R_n) + g)| ≥ |G|·(|A ∩ B(0, R_n)| − |B(0, R_n) ∖ B(0, R_n − r)|) / |B(0, R_n)| → d·|G|`.
The supremum over `A` gives `α(G)/|G| ≥ m₁(ℝ²)` for every finite `G`.

**C133-PER.** Put `Q' = q + [1/2, L − 1/2)²` and `A' = (A ∩ Q') + Lℤ²`. Two points of one copy are translates of two points of
`A`. Two points `a + Lv`, `a' + Lv'` with `v ≠ v'` and `a, a' ∈ Q'` differ in some coordinate by at least `L − |a_i − a'_i| > 1`,
because `|a_i − a'_i| < L − 1`. So `A'` is 1-avoiding; its density is `|A ∩ Q'| / L² ≥ |A ∩ (q + [0, L)²)| / L² − (2L − 1)/L²`.
*The four numbers.* Write `m_per` for the periodic supremum. A periodic set has its density as upper density along any of the
windows, so `m_per` is at most the second and third numbers. Conversely let `A` have upper density `d` along discs (or along
squares about some `p`), and `ε > 0`; fix `L > 2/ε`. For a window `X` of the sequence, the squares of the tiling by
`[0, L)² + Lℤ²` that lie inside `X` cover all of `X` but a boundary layer of relatively vanishing area, so along the sequence
their average of `|A ∩ Q| / L²` exceeds `d − ε`, some one square does as well, and the first part gives a periodic 1-avoiding
set of density above `d − 2ε`. For the fourth number: given a periodic 1-avoiding `P` of density `d` and any `X`, the average
of `|(P + t) ∩ X|` over `t` in a period is `d·|X|`, so `sup_{A ⊆ X} |A|/|X| ≥ d`; and with `X = [0, L)²` the first part gives
`sup_{A ⊆ X} |A|/|X| ≤ m_per + 2/L`. So the infimum over `X` is `m_per`.

**C133-DP.** `W*` is measurable and `|W △ W*| = 0` by the Lebesgue density theorem (almost every point of `W` is a density
point of `W`, almost every point of the complement is a density point of the complement). Suppose `x, y = x + u ∈ W*` with
`|u| = 1`. For small `h > 0` let `x'` be uniform in `B(x, h)` and, independently, `u'` uniform on the arc
`{u' ∈ S¹ : |u' − u| < h}`. Then `P(x' ∉ W) = |B(x, h) ∖ W| / |B(x, h)| → 0`. The law of `x' + u'` is a mixture of uniform laws
on discs `B(x + u', h) ⊆ B(y, 2h)`, so it has density at most `1/(πh²)` and
`P(x' + u' ∉ W) ≤ |B(y, 2h) ∖ W| / (πh²) = 4·|B(y, 2h) ∖ W| / |B(y, 2h)| → 0`. So for small `h` the event
`{x' ∈ W, x' + u' ∈ W}` has positive probability; the law of `(x', u')` is absolutely continuous to `Leb × σ`; hence
`(Leb × σ){(x, u) : x ∈ W, x + u ∈ W} > 0`, against edge-nullness. (This is the manuscript's proof of its Lemma 4.3 with the
other classes deleted; it never mentions them.)

**C133-CHIF.** Let `ε > 0`. By `C133-PER` there is a measurable 1-avoiding `P`, periodic under `Lℤ²` with `L` an integer, of
density `d ≥ m₁(ℝ²) − ε`. *Open regularisation.* For `r > 0` let `P_r = {x : |P ∩ B(x, r)| > (3/4)·|B(x, r)|}`. It is open
(`x ↦ |P ∩ B(x, r)|` is continuous) and `Lℤ²`-periodic. It is 1-avoiding: if `x, y ∈ P_r` and `|x − y| = 1`, the sets
`P ∩ B(y, r)` and `(P ∩ B(x, r)) + (y − x)` both lie in `B(y, r)` and each has more than three quarters of its area, so they
share a point `z`; then `z` and `z − (y − x)` are points of `P` at distance 1. By the density theorem `1_{P_r} → 1_P` almost
everywhere as `r → 0`, so by dominated convergence on a period the density of `P_r` tends to `d`; fix `r` with density at
least `d − ε`. *An inner union of grid squares.* An open set is a disjoint union of half-open dyadic squares
`[a, a + 2^{−j}) × [b, b + 2^{−j})` with corners in `2^{−j}ℤ²`; as `L` is an integer these grids are `Lℤ²`-periodic. Finitely
many of the squares in one period carry all but `εL²` of the area of `P_r` there; cut them to a common side `s = 2^{−j}`, say
`n'` squares, and let `U` be their union with all its `Lℤ²`-translates: `U ⊆ P_r` is 1-avoiding and has density
`n's²/L² ≥ d − 2ε`. *The count.* Let `Θ = sℤ² / Lℤ²`, `N = |Θ| = (L/s)²`. For `x ∈ ℝ²`, `x ∈ U + t` iff `x − t ∈ U`, and as
`t` runs over `Θ` the point `x − t` runs once over the coset `x + sℤ²` modulo `Lℤ²`, which meets each half-open grid square of
side `s` in one point. So `x` lies in `n = n'` of the `N` translates `U + t`, each of which is 1-avoiding, and
`n/N = n's²/L² ≥ m₁(ℝ²) − 3ε`. Giving each translate the weight `1/n` is a fractional colouring of the plane of weight
`N/n ≤ 1/(m₁(ℝ²) − 3ε)` with finitely many sets (it is an `n`-fold colouring with `N` colours), so `χ_f(ℝ²) ≤ 1/m₁(ℝ²)` in
`[MatolcsiEtAl2025]`'s definition; `[Johnson1996fcn]`'s is the same number by his Proposition (pp. 102, 106, read).

### Argument for C133-ONE

**C133-ALG.** Let `μ` be an `E ⋊ K`-invariant Borel probability on `𝓘 = 𝓘_K`, with `τ_z`, `ρ_u` as in stage 4, and
`δ = μ{0 ∈ I}`. `(𝓘, μ)` is a standard probability space. Put `(T_z g)(I) = g(τ_z I)`, `(V_u g)(I) = g(ρ_u I)` on `L²(μ)`:
unitary, with `T_z T_w = T_{z+w}`, and `V_u T_z V_u⁻¹ = T_{uz}` (compute: `(V_u T_z V_u⁻¹ g)(I) = g(u(u⁻¹I − z)) = g(I − uz)`).
The steps are the manuscript's F3–F9 (`plans/EXT-OAI2-reading.md` § 2.1), for one indicator.

- *F3.* `f(I) = 1[0 ∈ I]`. Then `(T_z f)(I) = 1[z ∈ I]`, `V_u f = f` (as `u⁻¹·0 = 0`), `∫ f dμ = δ`, and for `u ∈ K`,
  `⟨f, T_u f⟩ = μ{0 ∈ I, u ∈ I} = 0` because `0` and `u` are adjacent.
- *F4* (Lemma 4.1, M/transfer.tex:25–142, read whole; its hypotheses are a standard probability space, a measure-preserving
  action of `E`, and rotations with the covariance above — all hold). `𝓗_c = {v : ‖T_z v − v‖₂ → 0 as z → 0 in E}` is `L²(𝓕_c)`
  for a factor `𝓕_c`, is the spectral subspace on `C`, carries a strongly continuous unitary extension `T_x`, `x ∈ ℝ²`,
  preserving the positive cone and the constant 1, and its projection commutes with every `V_u`.
- *F5.* `p = 𝔼(f ∣ 𝓕_c)`, `b = f − p`. So `0 ≤ p ≤ 1`, `∫ p dμ = δ`, `V_u p = p`, `V_u b = b`, `b ⊥ 𝓗_c`. Let `λ_b` be the
  spectral measure of `b`: `⟨b, T_z b⟩ = ∫_D ψ_z dλ_b`. It gives `C` mass 0 (`b` is orthogonal to the spectral subspace on `C`).
  It is `K`-invariant: `⟨b, T_{uz} b⟩ = ⟨V_u⁻¹ b, T_z V_u⁻¹ b⟩ = ⟨b, T_z b⟩`, and `ψ_{uz}(d) = ψ_z(ud)`, so `λ_b` and its image
  under `d ↦ ud` have the same Fourier coefficients. **Nothing here mentions another class.**
- *F6.* If `λ_b ≠ 0`, its normalisation is a `K`-invariant probability on `D` null on `C`, so by **Theorem 2.3** it is Haar and
  `⟨b, T_z b⟩ = 0` for `z ∈ E ∖ {0}`. For `u ∈ K`: `T_u` preserves `𝓗_c` and its orthogonal complement, so
  `0 = ⟨f, T_u f⟩ = ⟨p, T_u p⟩ + ⟨b, T_u b⟩ = ⟨p, T_u p⟩`. *What is consumed:* since `p ≥ 0` gives `⟨p, T_u p⟩ ≥ 0`, the theorem
  is needed only as `Re ∫ ψ_u dλ_b ≥ 0` at one `u ∈ K` — in this project's words, that the algebraic plane has no SP witness.
- *F7.* `x ↦ ⟨p, T_x p⟩` is continuous on `ℝ²` and vanishes on `K`, which is dense in `S¹` (the rational points of the circle
  are in `K`); so `⟨p, T_u p⟩ = 0` for every `u ∈ S¹`, and `⟨T_x p, T_{x+u} p⟩ = ⟨p, T_u p⟩ = 0` for every `x ∈ ℝ²`.
- *F8.* There is a product-measurable `H : ℝ² × 𝓘 → [0, 1]` with `H(x, ·) = T_x p` in `L²(μ)` for almost every `x`. (On a unit
  square `Q` the map `Φ(x) = T_x p` is uniformly continuous into `L²(μ)`; take simple maps `Φ_m`, constant on the cells of a
  partition of `Q`, with `sup_Q ‖Φ_m − Φ‖₂ ≤ 2^{−m}`, and measurable `[0, 1]`-valued representatives of their finitely many
  values — `0 ≤ T_x p ≤ 1` because `T_x` preserves positivity and 1. The resulting `H_m` are product-measurable and
  `‖H_m − H_{m+1}‖_{L²(Q × 𝓘)}` is summable, so `H_m → H := limsup H_m` almost everywhere on `Q × 𝓘`; for almost every `x` the
  section converges `μ`-almost everywhere, and its limit must be the `L²` limit `Φ(x)`.) This is M/transfer.tex:212–227.
- *F9.* Let `N` be the null set of `x` where the representation fails. For almost every `x`,
  `∫ H(x, ω) dμ(ω) = ⟨T_x p, 1⟩ = ⟨p, T_{−x} 1⟩ = δ`. The set of `(x, u)` with `x ∈ N` or `x + u ∈ N` is `(Leb × σ)`-null, and
  off it `∫ H(x, ω) H(x + u, ω) dμ = ⟨T_x p, T_{x+u} p⟩ = 0`. By Tonelli,
  `∫ [∫∫ H(x, ω) H(x + u, ω) dσ(u) dx] dμ(ω) = 0`, so for `μ`-almost every `ω`, `H(x, ω) H(x + u, ω) = 0` for almost every
  `(x, u)`. **The manuscript's only use of `Σ_i p_i = 1` is the next line of its proof, the choice of "the least index with
  positive field" at each point (M/transfer.tex:248–251); with one class there is nothing to choose.**
- *The density step.* `C133-DENS-CLASS` with `X = ℝ²`, `X_n = B(0, n)`, `α = δ` and the full-measure event of F9 gives an `ω`
  for which `W = {x : H(x, ω) > 0}` is edge-null and has upper density at least `δ` along the discs.
- *Density points.* By `C133-DP`, `W*` is a measurable 1-avoiding set equal to `W` up to a null set. So
  `m₁(ℝ²) ≥ δ = μ{0 ∈ I}`.

**C133-ONE, first line.** `C133-INV-CLASS` at `S = K` gives an invariant law with `μ{0 ∈ I} = a_K`, and `a_K` is `α₁(𝒜²)` by
definition. So `α₁(𝒜²) ≤ m₁(ℝ²)` (`C133-ALG`), `m₁(ℝ²) ≤ α₁(ℝ²)` (`C133-EASY`), and `α₁(ℝ²) ≤ α₁(𝒜²)` because the infimum
defining `α₁(ℝ²)` runs over more point sets. The three are equal. **This closed chain is why no redrawing lemma is needed: the
inequality that Tarski's theorem would supply, `α₁(𝒜²) ≤ α₁(ℝ²)`, comes out as a consequence.**

**C133-ONE, second line.** For a finite `G`, `χ_f(G) ≥ |G|/α(G)` (in a fractional colouring of weight `w`,
`|G| ≤ Σ_J γ(J)|J| ≤ w·α(G)`), so `sup{χ_f(G) : G ⊂ 𝒜² finite} ≥ 1/α₁(𝒜²) = 1/m₁(ℝ²)`. A fractional colouring of a graph
restricts to any subgraph with the same weight, so
`sup{χ_f(G) : G ⊂ 𝒜² finite} ≤ χ_f(𝒜²) ≤ χ_f(ℝ²)` and `sup{χ_f(G) : G ⊂ 𝒜² finite} ≤ χ_f,0(ℝ²) ≤ χ_f(ℝ²)`; and
`χ_f(ℝ²) ≤ 1/m₁(ℝ²)` (`C133-CHIF`). Every term is squeezed to `1/m₁(ℝ²)`. (`[MatolcsiEtAl2025]`'s Theorem 2,
`χ_f,0(ℝ²) = 1/α₁(ℝ²)`, is not used; it comes out.)

**C133-FN.** `f(n) ≥ α₁(ℝ²)·n` and `inf_n f(n)/n = α₁(ℝ²)` by the definitions (`[DuczVarga2026]` p. 1 and § 3;
`[MatolcsiEtAl2025]` p. 5). If `P_a`, `P_b` realise `f(a)`, `f(b)`, translate `P_b` so that the two are more than 1 apart: the
union has `a + b` points and independence number `f(a) + f(b)`, so `f(a + b) ≤ f(a) + f(b)`. Fekete's lemma gives
`lim f(n)/n = inf_n f(n)/n = α₁(ℝ²) = m₁(ℝ²)`.

### The K control (prediction P-K), and what each step reads of the field

Run the chain at `K₀ = ℚ(√3,√11)`, `E₀ = K₀(i)`, with its unit group `U₀`. Stage 4 runs word for word (a countable abelian
group, an abelian rotation group): an invariant law of density `α₁(K₀²)`, which is `1/4` (Theorem B's four-colouring gives
`≥ 1/4`; the Moser-lattice graphs of `[MatolcsiEtAl2025]` give `≤ 1/4`; G60). F3–F5 run word for word: Lemma 4.1's proof reads
of the group only that it is a countable dense subgroup of `ℝ²`, and F7 that `U₀` is dense in `S¹` (it contains the rational
points). F8, F9, the density step and the density points do not see the field. **F6 is the only step that cannot be run**, and it
must not: its conclusion there would be `1/4 ≤ m₁(ℝ²) ≤ 0.247` (only `α₁(K₀²) ≥ 1/4` is used for this). So at `K₀` the spectral
measure of `b` is a `U₀`-invariant measure, null on the continuous characters, with `∫ ψ_1 dλ_b = −⟨p, T_1 p⟩ < 0` (for the law
given by a class of the residue colouring it is carried by characters of finite order; for a general law of density `1/4` only
the sign is shown). P-K is met: the field enters `C133-ALG` through Theorem 2.3 alone, as its `uses only:` line says.

### What C133-ONE reads of the release

| step | manuscript | the release's Lean, by name (`plans/EXT-OAI1-audit.md` stage 6; `BorelTransfer.lean`, `Representations.lean` listings read for names only) | read here as |
|---|---|---|---|
| F6 | **Theorem 2.3** (`thm:rigidity`, M/spectral.tex:64–70) | `PlaneFiveColor.Spectral.wild_fourier` (`Ergodicity.lean:334`) with `IsWild`, `D`, `C`, `E`, `K`, `eval` | **the statement itself** — at the normalised spectral measure of `b`, one Fourier coefficient. The import in progress declares H and T only; **this is a third outside theorem** |
| F4 | Lemma 4.1 (`lem:palettes-continuous-factor`) | no single statement: the generic `space`, `isClosed_space`, `nonlinear_mem`, `projection_fixed_of_contraction`, `orbitExtension_*`; the spectral identification sits in the `PlaneSpectrum` modules (not located by name here) | its proof, read in full; a standard-space argument (spectral theorem, Bochner) |
| F8 | the measurable sample (M/transfer.tex:212–227) | `exists_measurable_field` (`BorelTransfer.lean:301`, generic) | re-derived above |
| F3, F5–F7, F9 for labels | Proposition 4.2 | `color_unit_correlation`, `projected_unit_correlation`, `fieldVector_unit_correlation`, `exists_label_field`, `sample_field` | **not consumable**: stated for `LabelModel.Space k` with its `measure k ω`, the orbit mean of one proper labelling. `C133-ALG` needs the same steps for an arbitrary invariant law on independent sets |
| density points | Lemma 4.3 | not in the Lean | re-derived (`C133-DP`) |
| — | Theorem 1.3 (the transfer) | `proper_to_borel_weak` | **not read**: the transfer theorem as a statement gives no density, so `C133-ONE` cannot be drawn from the outside theorem T that the import declares |

A note for the planner, as a question and not a route: whether the release's label-model lemmas can be reused by realising an
invariant law of density near `α₁(𝒜²)` as the orbit mean of **one** labelling (an independent set coloured 0 and its complement
properly 7-coloured is a proper 8-labelling of `E`) turns on finding a single independent set of `E` whose density under the
release's fixed invariant mean is near `α₁(𝒜²)`. That is not derived here; stage 4's law is a limit of Følner pieces, not an
orbit mean.

**Theorems this stage proved:** `C133-EASY`, `C133-PER`, `C133-DP` — TRUE, [hand], one mind each, all known; `C133-CHIF` — TRUE,
[derived] (a checking re-derivation of FS103-B-CHIF); `C133-ALG` — TRUE, [hand] over `[OAIMath2026]` Theorem 2.3, one mind;
`C133-ONE` (posed) — TRUE, [derived]; `C133-FN` — TRUE, [derived].

## Stage 6 — SAVED: C133-HOM — derived, both directions, as an instance of a pair-constraint transfer

**Verdict: TRUE.** The cross terms close, by two routes. The statement the argument carries is `C133-PAIR`: finitely many labels,
a countable set of **algebraic** distances, and at each distance a set of forbidden label pairs. `C133-HOM` is its instance with
one distance and the non-edges of `H` forbidden. Like `C133-ALG` it reads Theorem 2.3 itself, now at every nonzero algebraic
displacement of the constrained lengths and for complex combinations of two remainders.

*Definitions for the two entries.* `Λ` a finite set; `R` a countable set of positive real algebraic numbers; for each `r ∈ R` a
symmetric `N_r ⊆ Λ × Λ`. For `X = ℝ²` or `E`, a map `ℓ : X → Λ` is **admissible** if `(ℓ(x), ℓ(y)) ∉ N_r` whenever
`|x − y| = r ∈ R`. A Lebesgue-measurable `ℓ : ℝ² → Λ` is **admissible almost everywhere** if for each `r ∈ R`,
`(ℓ(x), ℓ(x + ru)) ∉ N_r` for `(Leb × σ)`-almost every `(x, u) ∈ ℝ² × S¹`.

derivation: C133-PAIR
  statement: an admissible `ℓ : ℝ² → Λ` exists if and only if a Lebesgue-measurable `ℓ : ℝ² → Λ` admissible almost everywhere
    exists; and an admissible `ℓ : ℝ² → Λ` exists if and only if an admissible `ℓ : E → Λ` exists
  uses only: forward — restriction to `E`; an invariant probability on the compact space of admissible labellings of `E` (two
    uses of Markov–Kakutani); `[OAIMath2026]` family 158's Lemma 4.1 and Theorem 2.3, the latter at the spectral measures of
    `b_i`, `b_j`, `b_i + b_j` and `b_i + i·b_j`; that `{w ∈ E : |w| = r}` is `rK`, dense in the circle of radius `r`, for
    algebraic `r`; jointly measurable versions; Tonelli; `Σ_i p_i = 1`. Converse — Lebesgue density, as in `C133-DP`; that
    finitely many conull sets meet; Tychonoff for `Λ^{ℝ²}` with `Λ` finite
  not claimed: any constraint on three or more points (a monochromatic unit triangle, say) — it is a third moment, and nothing
    here addresses it; any distance that is not algebraic (the forward direction reads only `E`, where such a constraint is
    empty); infinitely many labels; that the measurable labelling resembles the one started from; a measurable labelling
    admissible at **every** pair (for colourings that is `χ_m` against `χ_m⁰`, FS103-M-D, a GAP)
  converse: § Converse for C133-PAIR
  argument: § Argument for C133-PAIR
  verdict: derived
  grade: hand
  minds: 1
  model: `Λ = {1, …, 7}`, `R = {1}`, `N_1` the diagonal: the hexagonal seven-colouring is admissible, measurable, and admissible
    almost everywhere, so all three sides hold together; with `Λ = {1, 2}` all three fail together (a unit triangle lies in `E`)
  prior art: partly: for `N_1` the diagonal this is `[OAIMath2026]` family 158's Theorem 1.3; `plans/EXT-OAI2-reading.md` § 2.4
    reads the distance as free within algebraic ones; the cross terms and the general pattern: not found in print at the scope
    of the plan's § PA.2
  handoff: de Bruijn — over `wild_fourier` as an outside theorem; the planner decides whether to state the class or the
    instance; the converse needs nothing outside Mathlib

derivation: C133-HOM
  statement: For a finite graph `H`: a homomorphism of the plane's unit-distance graph to `H` exists iff a measurable one
    exists almost everywhere.
  uses only: `C133-PAIR` with `Λ = V(H)`, `R = {1}` and `N_1` the set of pairs that are not edges of `H` (the diagonal
    included, `H` having no loops), where "a measurable one exists almost everywhere" is read as: a Lebesgue-measurable
    `c : ℝ² → V(H)` with `c(x)` adjacent to `c(x + u)` for `(Leb × σ)`-almost every `(x, u)`
  not claimed: the items of `C133-PAIR`'s line; for an infinite `H` nothing
  converse: § Converse for C133-PAIR
  argument: § Argument for C133-PAIR
  verdict: derived
  grade: derived from: C133-PAIR
  minds: 1
  model: `H = K_7` (the hexagonal colouring) and `H = K_2` (both sides fail)
  prior art: partly: `H = K_k` is the release's Theorem 1.3; other `H` not found in print at the scope of the plan's § PA.2
  handoff: none — subsumed by `C133-PAIR`, which crosses

control: pair-polarisation
  of: C133-PAIR — the cross-term step, exactly, on a non-Hermitian form over ℤ[i]: the cross term is recovered from the quadratic
    form at the four vectors `b_i`, `b_j`, `b_i + b_j`, `b_i + i·b_j`
  run: python3 ../data/fs133/e1/polarisation.py complex
  expect: True
  fault: python3 ../data/fs133/e1/polarisation.py real

control: pair-converse-support
  of: C133-PAIR — the converse direction, its density-point step: every sampled `x' + u'` with `x' ∈ B(x, h)` and
    `|u' − u| < h` lies in `B(y, 2h)`, in exact rationals (`h = 1/8`)
  run: python3 ../data/fs133/e1/converse_support.py 1
  expect: True
  fault: python3 ../data/fs133/e1/converse_support.py 3

### Argument for C133-PAIR

*An admissible labelling of `ℝ²` restricts to one of `E`*, since the constraints between points of `E` are among those of `ℝ²`.
So it is enough to prove: (F) an admissible labelling of `E` gives a measurable labelling of `ℝ²` admissible almost everywhere;
and (B), in the next section, that the latter gives an admissible labelling of `ℝ²`.

**(F1) An invariant law.** `Ω ⊆ Λ^E`, the admissible labellings of `E`, is closed, nonempty, compact and metrizable. `E` acts by
`(τ_z ℓ)(x) = ℓ(x + z)` and `K` by `(ρ_u ℓ)(x) = ℓ(ux)`; both preserve admissibility because `|ux − uy| = |x − y|`, and
`τ_z ρ_u = ρ_u τ_{uz}`. The `E`-invariant Borel probabilities on `Ω` form a nonempty compact convex set (Markov–Kakutani for
the commuting `τ_z`), on which the commuting affine maps `(ρ_u)_*` act (as in stage 4, step (3)); a common fixed point `μ` is
`E ⋊ K`-invariant. With `(T_z g)(ℓ) = g(τ_z ℓ)` and `(V_u g)(ℓ) = g(ρ_u ℓ)`: `V_u T_z V_u⁻¹ = T_{uz}`.

**(F2) The indicators.** `f_i(ℓ) = 1[ℓ(0) = i]`, `i ∈ Λ`: `(T_z f_i)(ℓ) = 1[ℓ(z) = i]`, `V_u f_i = f_i`, `Σ_i f_i = 1`. For
`r ∈ R`, `(i, j) ∈ N_r` and `w ∈ E` with `|w| = r`: `⟨f_i, T_w f_j⟩ = μ{ℓ(0) = i, ℓ(w) = j} = 0`.

**(F3) The continuous parts.** By Lemma 4.1, with `p_i = 𝔼(f_i ∣ 𝓕_c)` and `b_i = f_i − p_i`: `0 ≤ p_i ≤ 1`, `Σ_i p_i = 1`
(conditional expectation is linear and fixes 1), each `p_i` and `b_i` is rotation-fixed, and `b_i ⊥ 𝓗_c`.

**(F4) The remainders are uncorrelated at every nonzero algebraic displacement — the new step.** *First route (polarisation).*
Let `s, t ∈ ℂ` and `v = s·b_i + t·b_j`. Then `v ⊥ 𝓗_c` and `V_u v = v`, so the spectral measure of `v` is null on `C` and
`K`-invariant (the computation of F5 in stage 5 used nothing else), and by Theorem 2.3 `⟨v, T_z v⟩ = 0` for `z ∈ E ∖ {0}`. With
the inner product linear in its first argument,
`⟨v, T_z v⟩ = |s|²⟨b_i, T_z b_i⟩ + |t|²⟨b_j, T_z b_j⟩ + s·t̄·⟨b_i, T_z b_j⟩ + t·s̄·⟨b_j, T_z b_i⟩`. The choices `(1, 0)` and
`(0, 1)` kill the first two terms; `(1, 1)` gives `⟨b_i, T_z b_j⟩ + ⟨b_j, T_z b_i⟩ = 0`; `(1, i)` gives
`−i⟨b_i, T_z b_j⟩ + i⟨b_j, T_z b_i⟩ = 0`. Hence `⟨b_i, T_z b_j⟩ = 0` for all `i, j` and all `z ∈ E ∖ {0}`. (The real choice
`(1, 1)` alone gives only the symmetric part; `T_z` is not self-adjoint: the control.) *Second route (domination).* The cross
spectral measure `λ_ij(B) = ⟨P_B b_i, b_j⟩` satisfies `|λ_ij(B)|² ≤ λ_ii(B)·λ_jj(B)`; by Theorem 2.3 on the diagonal,
`λ_ii = c_i·m_D` and `λ_jj = c_j·m_D`, so `λ_ij = g·m_D` with `|g| ≤ √(c_i c_j)`, and `g ∈ L²(m_D)`. Its Fourier coefficients
`φ(z) = ⟨b_i, T_z b_j⟩` are then square-summable over `z ∈ E` (the `ψ_z` are an orthonormal basis of `L²(m_D)`), and
`φ(uz) = φ(z)` for `u ∈ K` because both vectors are rotation-fixed. For `z ≠ 0` the orbit `Kz` is infinite, so `φ(z) = 0`.
The two routes share Theorem 2.3 and nothing else.

**(F5) Zero correlations of the continuous parts, on whole circles.** For `(i, j) ∈ N_r` and `w ∈ E`, `|w| = r`: the mixed
terms vanish (`𝓗_c` and its complement are translation-invariant), so
`0 = ⟨f_i, T_w f_j⟩ = ⟨p_i, T_w p_j⟩ + ⟨b_i, T_w b_j⟩ = ⟨p_i, T_w p_j⟩`. Since `r` is real algebraic, `r ∈ E` and
`{w ∈ E : |w| = r} = rK`, dense in the circle of radius `r`; `x ↦ ⟨p_i, T_x p_j⟩` is continuous; so `⟨p_i, T_{ru} p_j⟩ = 0` for
every `u ∈ S¹`, and `⟨T_x p_i, T_{x+ru} p_j⟩ = 0` for every `x ∈ ℝ²`. (An `r` that is not algebraic has no `w ∈ E` of that
length: this is where the hypothesis on `R` is consumed.)

**(F6) A sample.** Take product-measurable `H_i : ℝ² × Ω → [0, 1]` with `H_i(x, ·) = T_x p_i` for almost every `x` (stage 5,
F8, once per label). For almost every `x`, `Σ_i H_i(x, ·) = T_x 1 = 1` almost surely. By Tonelli, as in stage 5's F9, for
`μ`-almost every `ω`: `Σ_i H_i(x, ω) = 1` for almost every `x`, and for every `r ∈ R` and `(i, j) ∈ N_r`,
`H_i(x, ω) H_j(x + ru, ω) = 0` for almost every `(x, u)` — countably many conditions. Fix such an `ω`, order `Λ`, and let
`ℓ(x)` be the least `i` with `H_i(x, ω) > 0` where the sum is 1, and any fixed label elsewhere. `ℓ` is measurable. If `x` and
`x + ru` are both in the good set and `(ℓ(x), ℓ(x + ru)) = (i, j) ∈ N_r`, then `H_i(x, ω) H_j(x + ru, ω) > 0`, which happens on
a null set of `(x, u)`; and the pairs with an endpoint in the null bad set are null. So `ℓ` is admissible almost everywhere.

### Converse for C133-PAIR

**(B)** Let `ℓ : ℝ² → Λ` be measurable and admissible almost everywhere, `A_i = ℓ⁻¹(i)`, and `A_i*` the set of density points of
`A_i`. The `A_i*` are pairwise disjoint and their union `Z` is conull. *No constrained pair inside `Z` is forbidden:* if
`x ∈ A_i*`, `y = x + ru ∈ A_j*` with `r ∈ R` and `(i, j) ∈ N_r`, take `x'` uniform in `B(x, h)` and `u'` uniform on
`{u' ∈ S¹ : |ru' − ru| < h}`; as in `C133-DP`, `P(x' ∈ A_i) → 1` and `P(x' + ru' ∈ A_j) → 1` as `h → 0`, the law of
`(x', u')` is absolutely continuous to `Leb × σ`, and so `(ℓ(x'), ℓ(x' + ru')) = (i, j) ∈ N_r` on a set of positive measure — a
contradiction. So the labelling "`i` on `A_i*`" of `Z` is admissible at every pair of `Z`. *Finite configurations:* for a finite
`P ⊂ ℝ²` the translations `t` with `P + t ⊆ Z` are a finite intersection of conull sets; any one gives an admissible labelling
of `P`. *Compactness:* in the compact space `Λ^{ℝ²}` each constraint is a closed condition on two coordinates, and every finite
family of constraints is satisfiable; so some `ℓ` satisfies them all. This is the manuscript's Lemma 4.3 and the last paragraph
of its § 4 with `K_k` replaced by the pattern; choice enters here (Tychonoff for a power of a finite set) and nowhere else in
this direction.

### What C133-PAIR adds, and a second route to one equality of C133-ONE

- **The structural form's first rung is "pair constraints at algebraic distances".** Circular colourings, `b`-fold colourings
  and `H`-colourings of the plane exist iff they exist measurably almost everywhere; so does a colouring avoiding several
  algebraic distances at once. What is **not** shown is "exactly those": no three-point constraint is proved to fail to
  transfer, and none is proved to transfer.
- **A second route to `χ_f(ℝ²) = 1/m₁(ℝ²)`, by different mathematics.** `[Johnson1996fcn]`'s Proposition gives `χ_f(ℝ²)` as
  the infimum of `a/b` over `b`-fold colourings with `a` colours, that is over homomorphisms to the Kneser graph `KG(a, b)`.
  By `C133-HOM` such a homomorphism gives a measurable map `c : ℝ² → KG(a, b)` adjacent at almost every unit pair; its `a`
  classes `A_j = {x : j ∈ c(x)}` are edge-null and `Σ_j 1_{A_j} = b`, so in each disc some class has relative measure at least
  `b/a`, some one class does so in infinitely many `B(0, n)`, and by `C133-DP` its density points are a 1-avoiding set of
  upper density at least `b/a`. So `m₁(ℝ²) ≥ 1/χ_f(ℝ²)`, and with `C133-CHIF`, `χ_f(ℝ²) = 1/m₁(ℝ²)` — without stage 4's
  Følner pieces and without the reverse Fatou step. It shares Theorem 2.3 and `C133-CHIF` with stage 5's route, and it does
  **not** give `α₁(ℝ²) = m₁(ℝ²)`: between `sup_G χ_f(G)` and `χ_f(ℝ²)` there is no compactness (Johnson's Question 1), and
  stage 5 crosses that gap with the invariant law.

**Theorems this stage proved:** `C133-PAIR` — TRUE, both directions, [hand] over `[OAIMath2026]` Theorem 2.3, one mind;
`C133-HOM` (posed) — TRUE, [derived] from it.
