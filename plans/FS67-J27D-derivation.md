# FS-67 — derivation record (crunch job J27D)

*De Bruijn (Opus 5.5), 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J27D-FS67-derivation.md` with `STANDING-RULES.md`. Plan:
`plans/FS67-tight-products.md` (§4.1, §4.3, §5.1). Data `data/fs67/j27d/`; tools `tools/crunch_j27d_*.py`. **Fenced from J27V until J27V's
blind phase is committed.***

## Theorems this phase proved

*(Filled at stage 5; grades per `CLAUDE.md` § Notation.)*

## Stage 1 — SAVED (quotation check, C0)

### 1.1 Quotation check (standing rule 5)

`tools/crunch_j27d_quotes.py` extracts every claim statement the brief quotes (`**ID** (§x.y) "…"`, the §4.1 definitions block and FS67's
inner quote) and requires each to occur verbatim (whitespace-normalised) in `plans/FS67-tight-products.md`. Result
`data/fs67/j27d/quotes.out`: **12 quotes, 0 missing** — DA-1′, DA-2′, DA-3, DA-4, DB-1, DB-2, DC-1, DC-2, DD-1, DD-2, the definitions, FS67.
Plant (`--plant`: `k ≥ 3` → `k ≥ 2` in one quote): exit 1, 1 missing (`quotes-plant.out`) — the check fires.

Unquoted brief text, compared by eye: DC-3's "(exact arithmetic of seconds; no search)" against the plan's "(exact, seconds; no search)" —
a faithful paraphrase; DC-2's "that you state and prove" against "that J27D states and proves" (outside the quotation marks) — faithful. The
brief's "Delete 'connected' once" for DC-2 is an instruction, not a quote.

External statements this record rests on, quoted from the held PDFs (text extracted with `pdftotext -layout`):
- `[Tardif2023]` Theorem 1: "For any integers n ≥ 4 and m > n, there exist graphs G, H such that χ(G) ≥ m, χ(H) > n and χ(G × H) ≤ n."
- `[GodsilEtAl2020]` Result 1: "For any graphs G and H, we have that χv (G × H) = min{χv (G), χv (H)}." Result 4: "Let G and H be graphs such
  that χv (G) < χv (H) and H is connected. If G admits a strictly complementary dual solution with strictly positive diagonal, then every
  optimal vector coloring of G × H is induced by G." §1.2: "It follows from results in [5] that any 1-walk-regular graph has a strictly
  complementary dual solution with strictly positive diagonal." Result 5: "Let G and H be graphs such that χv (G) = χv (H). If both G and H
  admit connected strictly complementary dual solutions, then every optimal vector coloring of G × H is a convex combination of vector
  colorings induced by the factors." Definition (§1): "a vector coloring of G × H is induced by G if and only if the (i, ℓ)(j, k)-entry of its
  Gram matrix only depends on i and j."
- `[TardifWrochna2019]` §1.1: K is strongly multiplicative if "If G and H are connected graphs and C, C′ odd cycles in G and H, respectively,
  such that (G × C′) ∪ (C × H) admits a homomorphism to K, then G or H admits a homomorphism to K." Theorem 1 ("[ES85; Häg+88]"): "The odd
  cycle graphs are strongly multiplicative."
- `[Tardif2008]` §4.2: "In [17] it is proved that A(n) implies B(n) and B(n) implies H(n)." (as the plan quotes).

### 1.2 C0 — priors per claim (TRUE / FALSE / GAP)

*Honest deviation:* registered after reading the sources and after informal reasoning on DA-1′–DA-3 and DC-2 had begun (not before any
derivation, as the brief asked); the priors on those claims are therefore informed, and are marked so.

| claim | TRUE | FALSE | GAP | note |
|---|---|---|---|---|
| DA-1′ | 0.97 | 0.02 | 0.01 | informed |
| DA-2′ | 0.95 | 0.03 | 0.02 | informed |
| DA-3 | 0.93 | 0.04 | 0.03 | informed |
| DA-4 | 0.85 | 0.05 | 0.10 | rests on `[Tardif2023]` Thm 1 (finiteness to be checked) |
| DB-1 | 0.35 | 0.20 | 0.45 | the nonzero-winding components are the risk |
| DB-2 | 0.80 | 0.05 | 0.15 | "tower" must be identified |
| DC-1 | 0.85 | 0.05 | 0.10 | rests on GRRSV Result 4 |
| DC-2 at some τ_k > 0 | 0.95 | 0.02 | 0.03 | informed |
| DC-2 at τ_k = 1/(k−1) | 0.70 | 0.10 | 0.20 | informed (a bootstrap reaching it was sketched) |
| DD-1 | 0.60 | 0.10 | 0.30 | rests on Result 5's convex form |
| DD-2 | 0.15 | 0.05 | 0.80 | |

## Stage 2 — SAVED (DA-1′, DA-2′, DA-3, DA-4)

**Conventions.** Graphs may be infinite unless "finite" is said; `K_k^G` has vertex set all maps `V(G) → [k]`, `f ∼ g` iff `f(u) ≠ g(v)` for every
ordered edge `(u, v)`; its looped vertices are exactly the proper colourings, and `E_k(G)` is the (loopless) induced subgraph on the rest.
**Currying** (definitional): a map `β : V(G × H) → [k]` is a proper colouring iff `Φ_β : h ↦ β(·, h)` is a homomorphism `H → K_k^G` (a loop
at `Φ(h)` licenses an edge `h ∼ h′` with `Φ(h) = Φ(h′)`). "Pulled back from `G`" is "`Φ_β` constant with value a proper colouring"; when `H` has an
edge, constancy alone suffices (the constant value is then a looped vertex).

### DA-1′ — TRUE [hand; the construction checked exactly]

*Proof.* Let `c` be a proper `k`-colouring of `G` with a gap: `b ∉ c(N[x])`. Pick `h₀ ≠ h₁` in `H`. Put `β(y, h) = c(y)` except `β(x, h₀) = b`.
An edge `(y, h) ∼ (y′, h′)` of `G × H` with neither end `(x, h₀)` sees `c(y) ≠ c(y′)`; one with an end `(x, h₀)` has the other end `(y′, h′)`, `y′ ∈ N(x)`
(`y′ ≠ x`, loopless), so it sees `b ≠ c(y′)`. So `β` is proper, and `β(x, h₀) = b ≠ c(x) = β(x, h₁)`: not constant on `x`'s fibre, so not pulled
back. ∎ *Hypothesis use:* `k`-colourable and not gap-free give `(c, x, b)`; `|V(H)| ≥ 2` gives `h₁`. Nothing else (no connectivity, no edge of
`H`, any cardinality). *Check* (`tools/crunch_j27d_da.py` A, `data/fs67/j27d/da.out`): `G = C₅`, `c = (0,1,0,1,2)` (vertex 1 misses colour 2),
`H = K₄`: proper, not pulled back. Plant (recolour into `c(N(1))`): improper — fires (`da-plant.out`).

### DA-2′ — TRUE [hand; the key lemma checked exactly at `K₄`]

*Lemma L1 (loops are isolated).* If `c` is a gap-free proper `k`-colouring of `G`, its only neighbour in `K_k^G` is `c`. *Proof.* `c ∼ g` means
`g(v) ∉ c(N(v))` for every `v`; gap-free and proper give `c(N(v)) = [k] ∖ {c(v)}`, so `g(v) = c(v)`. ∎ (Gap-free at `k ≥ 2` also excludes isolated
vertices.) So when `G` is `k`-gap-free, `K_k^G` is the disjoint union of isolated looped vertices (its proper colourings) and `E_k(G)`.

*(⟸)* Let `χ(E_k(G)) ≤ k` via `γ`, `H` connected with `χ(H) > k`, `β` proper on `G × H`. `H` has an edge. If some `Φ_β(h)` is a looped vertex `c`,
L1 and connectivity of `H` force `Φ_β ≡ c`: pulled back. Otherwise `Φ_β : H → E_k(G)` and `γ ∘ Φ_β` is a proper `k`-colouring of `H`: impossible.
*(⟹)* If `χ(E_k(G)) > k`, some component `D` of `E_k(G)` has `χ(D) > k` (else colour the components separately — the axiom of choice when there
are infinitely many). Put `β(u, f) = f(u)` on `G × D`: an edge `(u, f) ∼ (v, g)` has `u ∼ v`, `f ∼ g`, so `f(u) ≠ g(v)` — proper. Its curried map
is the inclusion `D ↪ E_k(G)`, not constant at a proper colouring (every `f ∈ D` is improper), so `β` is not pulled back; `D` is connected with
`χ(D) > k`. ∎ *Hypothesis use:* gap-freedom only in (⟸), through L1. **By-product (FS67 characterised, [hand]):** combining with DA-1′,
FS67(G, k) ⟺ every proper `k`-colouring of `G` is gap-free (vacuous when `G` is not `k`-colourable) ∧ `χ(E_k(G)) ≤ k`; for non-`k`-colourable `G`
the same proof reads FS67(G, k) ⟺ `χ(E_k(G)) = χ(K_k^G) ≤ k`, i.e. `G × H` is not `k`-colourable for every connected `H` with `χ(H) > k` —
FS-67 contains Hedetniemi's `H(k)` verbatim on that side. *Check* (B): at `G = K₄`, `k = 4`, all 24 proper colourings have only themselves as
neighbour; at `G = C₅`, `k = 3`, the gapped `c` has another neighbour (the contrast L1 predicts).

### DA-3 — TRUE [hand; GL re-derived]

Let `k ≥ 3`, `X` connected, `χ(X) > k` (so `X` has an edge and an odd cycle).
- *(a) Connected.* Weichsel, re-derived for arbitrary cardinality: `X` connected with an edge has walks between any two vertices of lengths
  `ℓ₀ + 2m` (every `m ≥ 0`); `K_k` (`k ≥ 3`) has walks between any two vertices of every length `≥ 2`; take a common length.
- *(b) GL, re-derived as FS67(K_k, k).* `K_k` is `k`-gap-free (its colourings are bijections). `γ(f)` = the least colour a non-injective
  `f : [k] → [k]` repeats is a proper colouring of `E_k(K_k)`: if `f(u₁) = f(u₂) = a` and `f ∼ g`, every `v` differs from `u₁` or `u₂`, so
  `g(v) ≠ a` — `g` misses `a` and cannot repeat it. By DA-2′, every `k`-colouring of `K_k × Y` (`Y` connected, `χ(Y) > k`) is a bijection of the
  `K_k` coordinate: **`K_k × Y` is uniquely `k`-colourable** (`[GreenwellLovasz1974]`, here re-derived). *Check* (C): `γ` proper on `E_3(K_3)`
  (21 vertices, 30 edges) and `E_4(K_4)` (232, 1,314); plant (least *missing* colour) gives 2 and 122 monochromatic arcs — fires.
- *(c) Gap-free.* By (b) with `Y = X` every `k`-colouring of `K_k × X` is `σ ∘ π₁`; vertex `(i, x)` has neighbours `(j, y)`, `j ≠ i`, `y ∼ x` (exists),
  so `N[(i, x)]` sees all colours.
- *(d) ⟸.* Given connected `H`, `χ(H) > k`, and a `k`-colouring `c` of `X × H`: `β((i, x), h) = c(x, h)` is proper on `(K_k × X) × H` (an edge needs
  `x ∼ y`, `h ∼ h′`). If it were pulled back, `c(x, h) = δ(x)` would not depend on `h`, and `δ` would be a proper colouring of `X` (for `x ∼ y`
  pick `h ∼ h′`): impossible.
- *(e) ⟹.* Let `β` on `(K_k × X) × H` be proper and not pulled back, `H` connected, `χ(H) > k`. If `χ(X × H) > k`: `X × H` is connected (both
  factors connected and non-bipartite, (a)'s argument), so (b) with `Y = X × H` makes `β(i, (x, h)) = σ(i)` — pulled back from `σ ∘ π₁` on `K_k × X`.
  Contradiction; so `χ(X × H) ≤ k` and `H` itself is the witness. ∎

### DA-4 — TRUE [hand from `[Tardif2023]` Thm 1 (external, read here)]

*First clause.* Fix `k ≥ 4`; `[Tardif2023]` Thm 1 with `n = k`, `m = k + 1` gives `X′, H′` with `χ(X′) ≥ k + 1`, `χ(H′) > k`, `χ(X′ × H′) ≤ k`. The
paper's graphs are finite — read in its §2: "Our graph G is Ωw (Km )", whose vertices are tuples of subsets of `V(K_m)`, and "Our graph H is
the exponential graph KnG . Its vertices are the n|V (G)| functions" (**[external]**, the construction not re-derived here). A finite graph's chromatic number is attained on a component: take components `X ⊆ X′`,
`H ⊆ H′` with `χ(X) = χ(X′)`, `χ(H) = χ(H′)`; `X × H ⊆ X′ × H′`, so `χ(X × H) ≤ k`. DA-3 (⟸ and (b), (c)): `G = K_k × X` is finite, connected,
uniquely `k`-colourable, and FS67(G, k) fails (witness `H`). *Second clause.* Given finite `X′, H′` with `χ > k`, take max-`χ` components `X, H`;
`K_k × X` is finite, connected, `k`-gap-free (DA-3); FS67 there and DA-3 (⟹, contrapositive) give `χ(X × H) > k`, hence `χ(X′ × H′) > k`. ∎
**Reading of the headline (the brief's "graded a reading until proved"):** *the gap-free form fails at every `k ≥ 4`* is now [hand, from
`[Tardif2023]`], and it needs neither Duffus–Sands–Woodrow nor Shitov: DA-3's two lines plus Tardif 2023's range `n ≥ 4` do it directly.
Tardif 2023 Thm 1 alone covers every `k ≥ 4` (its `n` is arbitrary `≥ 4`), so no monotonicity-in-`k` lemma is needed. At `k = 3` the
second clause is El-Zahar–Sauer's `H(3)` (true), so FS67 at `k = 3` survives this route — DB's question.

*Theorems of this stage:* DA-1′, L1, DA-2′ with the characterisation, GL re-derived (FS67(K_k, k)), DA-3, DA-4 — [hand]; checks A–C [tools].

## Stage 3 — SAVED (DC-1, DC-2, DC-3)

### DC-1 — TRUE [hand, conditional on `[GodsilEtAl2020]` Results 1, 4 and §1.2, and `[GodsilRobersonRooney2017]` Thm 4.9 — external, read here]

*The link.* `[GodsilRobersonRooney2017]` Thm 4.9's proof, for 1-walk-regular `r`-regular `G` with `τ = λ_min(A)`: the scaled least-eigenvalue
framework satisfies "p̃ᵢᵀ p̃ᵢ = 1, for all i ∈ [n] and p̃ᵢᵀ p̃ⱼ = τ/r for all i ∼ j", and Cor. 4.10(i): "The assignment i ↦ √(n/d) pᵢ is an optimal
strict vector coloring of G." So **`χv(G) = 1 − r/λ_min = 1 + r/|λ_min|` for 1-walk-regular `G`**, and `χv(G) = k` ⟺ `λ_min = −r/(k−1)` ⟺ `G` is
Hoffman-tight at `k` (G54's sense). DC-1 is therefore: *1-walk-regular + Hoffman-tight at `k`* ⟹ the pullback property against every connected
`H` with `χv(H) > k` — equivalently (Γ as `H`, arc-transitive) `|λ_min(H)|/d(H) < 1/(k−1)` when `H` is 1-walk-regular.

*Proof.* Let `β` be a proper `k`-colouring of `G × H` (finite graphs, as in GRRSV). Send colour `j` to the vertex `s_j` of a regular simplex
(`|s_j| = 1`, `⟨s_i, s_j⟩ = −1/(k−1)`, `i ≠ j`); `p(x, h) = s_{β(x,h)}` is a vector `k`-colouring of `G × H`. Result 1 gives `χv(G × H) = min(k,
χv(H)) = k`, so `p` is optimal. `G` 1-walk-regular has a strictly complementary dual solution with strictly positive diagonal (GRRSV §1.2), `H` is
connected and `χv(G) < χv(H)`: Result 4 says `p` is induced by `G`, i.e. its Gram entry at `(x, h)(x, h′)` depends only on `(x, x)`, hence equals
the diagonal entry 1; unit vectors with inner product 1 coincide, so `s_{β(x,h)} = s_{β(x,h′)}` and `β(x, h) = β(x, h′)`. `H` has an edge
(`χv(H) > k ≥ 2`), so `c = β(·, h₀)` is proper and `β = c ∘ π₁`. ∎ *Hypothesis use:* `χv(G) = k` for optimality; 1-walk-regular for Result 4's
dual condition; `H` connected and `χv(H) > k` are Result 4's. **Reach:** `χv(H) ≤ χ_f(H)`, so DC-1 never sees the gap `χ_f(H) ≤ k < χ(H)`; and
it needs no vertex-transitivity of `H`, unlike `[Zhang2012]` (i). For `G` not `k`-colourable the same proof says `χ(G × H) > k`.

### DC-2 — TRUE at `τ_k = 1/(k−1)`, Pak–Vilenchik's threshold [hand; the algebra checked exactly]

Let `H = Cay(A, T)`, `A` finite abelian, `T = −T ∌ 0`, `λ* = max_{χ ≠ 1} |Σ_{t∈T} χ(t)|/|T| < 1/(k−1)`; `G` `k`-gap-free (any cardinality). Let `β` be a
proper `k`-colouring of `G × H` and `m_c(x) = |{a : β(x, a) = c}|/|A|` (the fibre measures; `Σ_c m_c(x) = 1`); `r(μ) = μ/(1 − μ)`.

- **(M) Mixing.** For `S, S′ ⊆ A` of measures `μ, μ′`: `|P(a ∈ S, a + t ∈ S′) − μμ′| ≤ λ* √(μ(1−μ)μ′(1−μ′))` (`a` uniform in `A`, `t` in `T`). *Proof:*
  Fourier expansion gives `P = Σ_χ f̂(χ) conj(ĝ(χ)) E_t conj(χ(t))`; the trivial character contributes `μμ′`, each other `|E_t χ(t)| ≤ λ*`; Cauchy–
  Schwarz and Parseval (`Σ_{χ≠1} |f̂|² = μ − μ²`). For `x ∼ y` in `G` and a colour `c`, `S = β(x,·)⁻¹(c)` and `S′ = β(y,·)⁻¹(c)` have `P = 0`
  (properness), so `μμ′ ≤ λ*√(μ(1−μ)μ′(1−μ′))`: **`r(m_c(x))·r(m_c(y)) ≤ λ*²`** when both are in `(0, 1)`, and `m_c(x) = 1 ⟹ m_c(y) = 0`.
- **(P) Plurality is proper.** `φ(x) ∈ argmax_c m_c(x)` has `m_{φ(x)}(x) ≥ 1/k`, `r ≥ 1/(k−1)`; `x ∼ y` with `φ(x) = φ(y)` would give a product
  `≥ 1/(k−1)² > λ*²`. So `φ` is a proper `k`-colouring of `G`, hence **gap-free** (the only use of the hypothesis on `G`).
- **(B) Bootstrap.** Let `s = (k−1)λ*²` and let `e` bound `m_c(x)` for all `x` and all `c ≠ φ(x)`. For such `(x, c)`, gap-freedom gives `x_c ∈ N(x)` with
  `φ(x_c) = c`. *Start:* `m_c(x_c) ≥ 1/k` gives `r(m_c(x)) ≤ s`, so `e₀ = s/(1+s)`. *Step:* `m_c(x_c) ≥ 1 − (k−1)e` gives `r(m_c(x)) ≤ λ*²(k−1)e/(1 −
  (k−1)e)`, so `e ↦ F(e) = s e / (1 − (k−1−s)e)`. `F` is increasing, `F(e) < e` exactly on `(0, e*)` with `e* = (1−s)/(k−1−s)`, and
  **`e* − e₀ = (1 − (k−1)s)/((1+s)(k−1−s))`, positive iff `λ* < 1/(k−1)`**. Then `e_n = Fⁿ(e₀)` decreases to the only fixed point of `F` below
  `e*`, namely 0. So `m_c(x) = 0` for `c ≠ φ(x)`: on finite `A`, `β(x, a) = φ(x)` for every `a` — **`β = φ ∘ π₁`, pulled back.** ∎

*"Connected" deleted:* the proof never uses connectivity of `G` (gap-freedom is local; the bootstrap bound is a supremum over all vertices), so
DC-2 holds for every `k`-gap-free `G`, connected or not, finite or not; `H`'s connectivity, non-bipartiteness and `χ(H) > k` are consequences of
`λ* < 1/(k−1)` (M with `S = S′` independent gives `α(H)/|A| ≤ λ*/(1+λ*) < 1/k`), not hypotheses. With `A` compact abelian and `β` measurable
the conclusion holds almost everywhere on each fibre. *Checks* (`tools/crunch_j27d_dc.py` A, `data/fs67/j27d/dc.out`): both identities (the
rewrite of `F(e) < e` and `e* − e₀`) reduce to 0 in sympy; exact rational iteration at `λ* = 1/(k−1) ∓ 1/1000`, `k = 3, 4, 5, 8`, descends below
the threshold (`e₄₀ ≤ 5·10⁻¹¹`) and does not start above it (`e₀ > e*`) — the method's boundary is exactly the threshold.
*Relation to print:* at `G = K_k` it is `[PakVilenchik2013]` Thm 3; J21-MX's plurality step is (P); GRRSV Result 4 needs a spectral condition on
`G` and none on `H` beyond `χv(H) > k`, DC-2 the reverse — **no spectral or transitivity condition on `G`, only gap-freedom**. Not claimed new
until a gate is run on "uniquely colourable graph × expander" (prior-art debt).

### DC-3 — the residue planes as `H` [tools: 50-digit arithmetic, controls]

`Γ_p = Cay(𝔽_p², {x² + y² = 1})`, `d = p + 1`, one character per norm class; `Y`/`n` = DC-1's hypothesis on `H` (`|λ_min|/d < 1/(k−1)`, i.e.
`χv(Γ_p) > k`, Γ_p being arc-transitive hence 1-walk-regular) / DC-2's (`λ* < 1/(k−1)`). Source: `data/fs67/j27d/dc.out`.

| `p` | `λ_min/d` | `λ₂/d` | `λ*` | `k = 3` | `k = 4` | `k = 5` |
|---|---|---|---|---|---|---|
| 3 | −0.5 (tight) | 0.25 | 0.5 | nn | nn | nn |
| 7 | −0.56174 | 0.33650 | 0.56174 | nn | nn | nn |
| 11 | −0.39965 | 0.47641 | 0.47641 | YY | nn | nn |
| 19 | −0.38049 | 0.37544 | 0.38049 | YY | nn | nn |
| 23 | −0.33170 | 0.32908 | 0.33170 | YY | YY | nn |
| 31 | −0.333328 | 0.29287 | 0.333328 | YY | YY (margin 4.9·10⁻⁶) | nn |
| 43 | −0.27187 | 0.26012 | 0.27187 | YY | YY | nn |
| 47 | −0.26764 | 0.27597 | 0.27597 | YY | YY | nn |
| 59–103 | | | ≤ 0.2486 | YY | YY | YY |

(59, 67, 71, 79, 83, 103 rows in `dc.out`.) Smallest margin to a threshold, `p > 3`: `4.88·10⁻⁶` (31 at `k = 4`), far above the arithmetic's
error. Controls: `λ_min/d = −1/2` at 3 exactly (G54's tight case) and `λ_min + d/3 = 1.5617·10⁻⁴` at 31 (G54's number). Plant (drop one antipodal
pair from every circle): the 31 control fails — fires (`dc-plant.out`). **Reading of the table:** at every usable prime the two hypotheses
coincide (the least eigenvalue dominates except at 11, 47, 67, 71, where `λ₂` does and both still hold); so for `k = 3` every `Γ_p`, `p ≥ 11`, is an
`H` against which *every* `k`-gap-free `G` pulls back (DC-2) — `Γ₇` and `Γ₃` are in the gap regime (`χv(Γ₇) = 2.78 < 3 < χ(Γ₇) = 4`); at `k = 4`
from 23; at `k = 5` from 59, which is where Hoffman already refuses five colours (G44).

*Theorems of this stage:* the link `χv = 1 + r/|λ_min|` (GRR2017, quoted); DC-1 [hand, conditional]; (M), (P), (B) and DC-2 at `τ_k = 1/(k−1)`
without connectivity [hand]; DC-3's table [tools].
