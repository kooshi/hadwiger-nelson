
## Stage 14 — SAVED (FS131-K10c): the four rows — two stated, two designed and handed to a fourth pass (`debruijn-domain-modeling` and `debruijn-obligation-modeling` not invoked: see § 14.5)

### 14.1 The level row (ruling 507 (b)) — stated: `Arith/LevelGraph.lean`

**Settled from the entry, no question for the deriver.** X25B-T's chain (`plans/FS100-X25B-derivation.md:89`): "`r(G_∅) ≤
sup_k r(ℂ^{r₁} × Y_k)` (X25B-L1) `≤ max(r(ℂ^{r₁}), sup_k r(Y_k))` (X25B-PZ)", then "`r(G_{v,k}) = α/|G_{v,k}| ≤ r_v`". What it
reads of the level is the **upper bound** `r(Y_k) ≤ α(Y_k)/|Y_k|` after X25B-PZ has split the product. In Lean X25B-PZ applies
to the pulled-back level directly (it is a measure on `X × Y`), so the chain's middle term — the product with the finite
quotient *as a group* — is never formed and no quotient system is built.

| declaration | read aloud | state |
|---|---|---|
| `levelGraph ν K : SimpleGraph (Y ⧸ K)` | cosets `a ≠ b` adjacent when `ν(π⁻¹(b − a)) > 0` or `ν(π⁻¹(a − b)) > 0` — `Cay(Y/K, S̄)` | definition; `levelGraph_adj`; two spec examples (`K₂` from `δ₁` on `ZMod 2`; `⊥` from the zero measure) |
| `StationarySet.prob_mul_card_le_indepNum` | a stationary set a.e.-independent for `ν ∗ m_K` has `P(B)·|Y ⧸ K| ≤ α(levelGraph ν K)` | **leaf** |
| `ratio_conv_cosetAverage_le` | `ratio (ν ∗ m_K) ≤ α / |Y ⧸ K|` — **the row** | proved over the leaf |
| `map_neg_conv_cosetAverage` | the smoothed measure of a symmetric measure is symmetric | **leaf** |
| `ratio_prod_le_max_iSup_levelGraph` | `ratio (ν_X × ν_Y) ≤ max (ratio ν_X) (⨆ k, α(Y_k)/|Y_k|)` — **the form X25B-T's chain reads**: L1, PZ at each level, the row | proved over the two leaves |

**Read back against the row** (ruling 507 (b): "the comparison of the pulled-back level with the finite quotient graph";
X25B-L1: "at most the supremum over its finite levels"). Differences, each a widening of the second pass's shape (§ 8.7),
reported as a generalization: **no symmetry of `ν_Y` and no `ν_Y(K) = 0`** in the row itself — `fromRel` symmetrizes and drops
loops, and where `ν_Y(K) > 0` an independent set for the smoothed measure is null (the leaf's first child at `s = 0`), so the
bound holds with room; `ν_Y` s-finite. The composition asks symmetry of both measures (X25B-PZ reads it) and `ν_Y` finite.
Only the upper bound is stated; equality (`r(Y_k) = α/|Y_k|`, the entry's word) is true and unread. **Vacuity**: generic in
`Y`, `ν`, `K`; instantiated at `ZMod 2`, `δ₁`, `⊥`, where `ratio_dirac_one_zmod_two` gives equality `1/2 = α(K₂)/2`.
**Not stated, and whose it is**: X25B-T itself is no row of this wave; it will also read that the level of a product is the
product of the levels (`(ν₁ × ν₂) ∗ (m_{K₁} × m_{K₂}) = (ν₁ ∗ m_{K₁}) × (ν₂ ∗ m_{K₂})`), which nothing here states.

### 14.2 J45-N1 (a), (b) — the interface, stated and inhabited: `Arith/PlaceFilter.lean`

**Decision: the two-fact interface, not (a), (b).** Reason: (i) every row of this wave that reads (a), (b) reads exactly two
facts of the filter `𝓝[τ′_S] 0` (`IsPlaceFilter`: every subgroup of finite index is in it; it is not eventually inside a
finite set) — and with them J45-SI-J's instance, J45-SI-5 and J45-SI-C land with no adic foundation; (ii) (a), (b) in the
row's words need a foundation no other row of the backlog reads: the `S`-adic completions of `L` against `unitRing F ⊆ ℂ`,
the profinite topology on `R`, the extension of characters from a closed subgroup of an LCA group and the dual of a product
(for "exactly the continuous characters"), weak approximation on the norm-one torus (for "dense") — a planning pass and
about two implementer jobs (my estimate, 1,500–2,500 lines, the LCA duality the uncertain part); (iii) the row's one reader
of the rest (the Borel isomorphism) is R-U, not in this wave. **So the row J45-N1 stands in the kernel as (c)
(`contChars_haar_null`, landed) and this interface; (a), (b) proper are owed by a later job, and what they owe this wave is
one theorem: `IsPlaceFilter (𝓝[τ′_S] 0)`** — its first clause by the definition of `τ′_S`, its second N1 (b)'s content.

`IsPlaceFilter l` (a `Prop` structure, two fields); `profiniteFilter R`; `IsPlaceFilter.eventually_map_eq_zero` (a finite
quotient is eventually trivial: J45-SI-J's `h₁`), `IsPlaceFilter.infinite_of_mem`; **the inhabitant
`isPlaceFilter_profiniteFilter`, proved**: on any infinite commutative group. All sorry-free. Read back: the two fields are
§ 8.4's two facts verbatim; `frequently_notMem` is `contVec_prod_eq`'s `hl` verbatim. **A third fact SI-5 will read** and
the interface does not carry: `τ′_S` is invariant under multiplication by `U` (its step (a), "multiplication by `v` is a
`τ′_S`-homeomorphism"); it enters SI-5's statement as a hypothesis on the rotation used (§ 14.4), not here, because SI-J and
SI-C do not read it.

### 14.3 What stating J45-SI-C and J45-SI-5 needs — the design, for the fourth pass (not stated here: my budget)

**The model must be the canonical one, and `SpectralChain.InvariantColouring` does not serve.** Both rows speak of the
`E_S`-factor *of the process `c`* (`𝒜_S(c)`, the factor of the factor system; SI-J's last sentence), so the sample space is
`R → Fin 4` with the shift, not the extension `(Φ, c₂, ε)`: the conditional laws given the extension's factor differ.
`InvariantColouring F` (the second pass's candidate, § 8.3 (i)) also demands rotation invariance (`rot_inv`), which SI-5's
constructed `μ` and SI-C's noisy colouring do not have (`γ_Φ ∘ π_𝔓` is not rotation-invariant). So a new carrier:

```
structure RandomColouring (U : Set R) where        -- R a countable commutative group, canonical space R → Fin 4
  μ : Measure (R → Fin 4);  isProb;  proper : ∀ᵐ c ∂μ, ∀ x, ∀ u ∈ U, c x ≠ c (x + u)
  shift_inv : ∀ y, MeasurePreserving (fun c x => c (x + y)) μ μ
M.factor l := factorSigma shift M.shift_inv l
M.Equality l := ∀ x, ∀ u ∈ U, ∀ j, ∫ c, (μ[1{c x = j} | M.factor l]) c * (μ[1{c (x+u) = j} | M.factor l]) c ∂μ = 0   -- si4's hdisj
M.Carries l := ∃ c′, (∀ x, Measurable[M.factor l] (c′ · x)) ∧ a.s. proper ∧ ∀ y, a.s. c′ (shift y c) = c′ c (· + y)
```
(sketched, **not elaborated**). `Equality` is written at every `x` so that it is `si4`'s hypothesis; the row's "at every
`u`" (at `x = 0`) is equivalent by `condExp_comp_measurePreserving` and `comap_factorSigma_eq_of_action`, a child.

**J45-SI-C**, over `IsPlaceFilter l`: for `π : R →+ ZMod 7 × ZMod 7` with `π u` a unit vector of `𝔽₇²` for `u ∈ U`, the law of
`c(z) = 3 if π z + a ∈ Z̄ ∧ ω z, else γ(π z + a)` (`a` uniform, `ω` fair bits under `Measure.infinitePi`; `GapSeven`'s `gamma`,
`zbar`) is a `RandomColouring U` with `Equality l` **for every place filter `l`**, and its last clause in the form the
kernel can say: `{c | c 0 = 3} ∉ factorSets shift _ l` — the centred noise `1[c(0) = 3] − p₃(0)` is not zero (by
`indicatorConstLp_mem_contVec_iff` this is the orthogonality form of § 8.1). **A sharper clause the fourth pass should weigh**:
`∫ (1[c 0 = 3] − μ[1[c 0 = 3] | 𝒜_l])² = 1/28` for every `l` (`|Z̄|/49 = 1/7`, noise `±1/2` there): it is uniform in `l`, which
is what the literal `σ_μ(R̂ ∖ E) > 0` (with `E = ⋃_S E_S`) needs — a bound for each `S` separately does not give it.
Inputs, all held: `contVec_prod_eq` (now proved, with its coin model), `comap_factorSigma_le`, `GapSeven`'s eight facts,
`ae_eq_measurable_of_majority`, `IsPlaceFilter.eventually_map_eq_zero`.

**J45-SI-5**, over `IsPlaceFilter l`, a **(G2) datum** (a finite group `V`, `π : R →+ V`, `γ : V → Fin 4` with
`γ v ≠ γ (v + π u)` for `u ∈ U`, vertices `ā`, `b̄` gapped with one missing colour `m`, and `u₁ ∈ U` with `π u₁ = b̄ − ā`), and
**a rotation hypothesis** — for `u, u₀ ∈ U` an additive automorphism `ρ` of `R` with `ρ '' U = U`, `l.map ρ = l`, `ρ u = u₀`
(multiplication by `u₀u⁻¹` in the row's setting; this is where `U`-invariance of `τ′_S` enters):
`(∀ M : RandomColouring U, M.Carries l → M.Equality l) ↔ ∀ M : RandomColouring U, M.Equality l`. The content is `⟹`'s
contrapositive, the row's construction (§ 2.2 (a)–(d) of the derivation). **My reading of the argument at this class**: (b)
properness reads `γ v ≠ γ (v + π u)` (so `π u ≠ 0` on `U`) and the gap at `π''U ∪ {0}`; (c) reads SI-J (`hl`, `h₁` from the
interface), the majority vote on each fibre of `π` (infinite: `infinite_of_mem` on `ker π`), and `mem_factorSets_iff` for
"moved through a finite quotient"; (d) reads the tower property over `𝒜_l(c) ⊆ σ(Φ) ∨ 𝒜_l(c₂)`. **The step I could not close
on paper in the time I had, and the fourth pass must**: (d)'s formula `p^c_m(x) = E[(1/3) q_{j₀}(x) | 𝒜_l(c)]` on `W_Φ` uses
that the conditional law of `c(x)` given `σ(Φ) ∨ 𝒜_l(c₂)` *in the extension* is the product formula; with `𝒜_l(c)` the
canonical factor this is a statement about two σ-algebras on two spaces, and its Lean form decides whether `Equality` is
best defined on the canonical space (as above) or on any system with a factor map. If it does not close, it is a question
for the deriver. Model of the hypotheses at once: `R = (ZMod 7 × ZMod 7) × ℤ`, `U = {unit vectors} × {0}`, `π = fst`,
`l = profiniteFilter`, rotations by norm-one elements of `𝔽₄₉` (to be built with the statement).

Price: the fourth planning pass about 120k (statements, the carrier with its inhabitant, the read-backs); then one
implementer job, about 900 lines (the second pass's 700 for the two rows, and about 200 for the carrier and the noisy
colouring as a factor of `prodMap₃`).

### 14.4 Generalizations of this stage (reported in the hand-back; none is built on by another job)

The level row holds with no symmetry and no `ν(K) = 0`; J45-N1 (a), (b)'s readers need two facts of a filter and the
profinite filter of any infinite group has them.

### 14.5 The modeling passes

Not invoked as fresh Skill passes in this job: the two statements written (`levelGraph`, `IsPlaceFilter`) are a definition
of one line each over the landed vocabulary, and the budget went to the import. The fourth pass owes
`debruijn-domain-modeling` on the `RandomColouring` carrier of § 14.3 — that is the modeling decision of this wave still
open — and `debruijn-obligation-modeling` on SI-5's step (d). A slip of process, mine, stated.
