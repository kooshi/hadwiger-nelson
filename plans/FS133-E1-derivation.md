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
