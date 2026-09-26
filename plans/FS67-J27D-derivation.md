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
paper's graphs are finite (they are built from finite exponential-graph pieces; the abstract's claim is about graphs, and its §2 proof builds
finite ones — **[external]**, not re-derived here). A finite graph's chromatic number is attained on a component: take components `X ⊆ X′`,
`H ⊆ H′` with `χ(X) = χ(X′)`, `χ(H) = χ(H′)`; `X × H ⊆ X′ × H′`, so `χ(X × H) ≤ k`. DA-3 (⟸ and (b), (c)): `G = K_k × X` is finite, connected,
uniquely `k`-colourable, and FS67(G, k) fails (witness `H`). *Second clause.* Given finite `X′, H′` with `χ > k`, take max-`χ` components `X, H`;
`K_k × X` is finite, connected, `k`-gap-free (DA-3); FS67 there and DA-3 (⟹, contrapositive) give `χ(X × H) > k`, hence `χ(X′ × H′) > k`. ∎
**Reading of the headline (the brief's "graded a reading until proved"):** *the gap-free form fails at every `k ≥ 4`* is now [hand, from
`[Tardif2023]`], and it needs neither Duffus–Sands–Woodrow nor Shitov: DA-3's two lines plus Tardif 2023's range `n ≥ 4` do it directly.
Tardif 2023 Thm 1 alone covers every `k ≥ 4` (its `n` is arbitrary `≥ 4`), so no monotonicity-in-`k` lemma is needed. At `k = 3` the
second clause is El-Zahar–Sauer's `H(3)` (true), so FS67 at `k = 3` survives this route — DB's question.

*Theorems of this stage:* DA-1′, L1, DA-2′ with the characterisation, GL re-derived (FS67(K_k, k)), DA-3, DA-4 — [hand]; checks A–C [tools].
