# FS67-J27V — blind verification of FS-67's fixed claim list (crunch job J27V)

*De Bruijn, blind verifier, Opus 5.5, 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J27V-FS67-verifier.md` (+ `STANDING-RULES.md`).
Blind phase = stages 1–2: nothing fenced was opened before stage 2's commit.*

## Theorems this phase proved

*(Filled at each stage; grades per `CLAUDE.md` § Notation. "Inputs" are the brief's verified inputs.)*

- J27V-T1 (= V-DA-1′) — TRUE [hand]; §2.1.
- J27V-T2 (= V-DA-2′) — TRUE [hand]; §2.2.
- J27V-T3 (= V-DA-3) — TRUE [hand, given `[GreenwellLovasz1974]` Cor. 1]; §2.3.
- J27V-T4 (= V-DA-4) — TRUE [hand, given `[Tardif2023]` Thm 1 (its graphs are finite, checked in the PDF) and T3]; §2.4.
- J27V-T5 (V-DB-1, partial) — GAP at a named step; proved: the non-3-colourable case (via El-Zahar–Sauer as cited in `[Tardif2023]`), and a
  winding invariant `w₂` constant on components of `K₃^G`; §2.5.
- J27V-T6 (= V-DB-2) — TRUE [hand + tools exact: `tools/crunch_j27v_fq9.py`]; §2.6.
- J27V-T7 (= V-DC-1) — TRUE [hand, given `[GodsilEtAl2020]` Result 1 and Thm 4.16(1)]; §2.7.
- J27V-T8 (= V-DC-2 with `τ_k = 1/(k−1)`, sharp) — TRUE [hand, from J21-MX's mixing lemma]; §2.8.
- J27V-T9 (= V-DD-1) — TRUE [hand, given `[GodsilEtAl2020]` Results 1 and 5]; §2.9.
- J27V-T10 (V-DD-2) — GAP at a named step; the reduction to a spectral Hedetniemi pair is proved; §2.10.

## Stage 1 — SAVED (the quotation check, C0)

### 1.1 The quotation check (standing rule 5)

| item | source | result |
|---|---|---|
| the eleven claims V-DA-1′ … V-DC-3 and the §4.1 definitions | `plans/FS67-tight-products.md` §4.1, §4.3, §5.1 (fenced) | **not checkable** in the blind phase — the plan is fenced; to be checked at stage 4 against the plan. Every verdict below is on the brief's wording |
| `[GreenwellLovasz1974]` Theorem 1, Corollaries 1 and 3 | held PDF pp. 335–336 (scanned; read as page images) | **verbatim match** with `plans/PA-products-GL1974-LT2002.md` §1.2 (Thm 1: "Suppose G is a connected graph such that any two n-colourings of G differ in at least two points. Then each n-colouring of K_n × G is induced by an n-colouring of one of the factors."; Cor 1: "If χ(G) > n and G is connected then K_n × G is uniquely n-colourable."; Cor 3: "(K_n)^k has exactly k n-colourings.") |
| `[Tardif2008]` §4.2 A(n), B(n), "A(n) implies B(n) and B(n) implies H(n)"; Thm 3.2 | held PDF, text layer | present as the brief says (§4.2: "In [17] it is proved that A(n) implies B(n) and B(n) implies H(n)"; Thm 3.2: "Let G be a graph such that every vertex of G is in an n-clique. For every graph H, if χ(G × H ) = n , then min { χ(G), χ(H ) } = n .") |
| `[Tardif2023]` Theorem 1 | held PDF | "For any integers n ≥ 4 and m > n, there exist graphs G, H such that χ(G) ≥ m, χ(H) > n and χ(G × H) ≤ n." Its §2 makes both graphs finite (`G = Ω_w(K_m)`, tuples of subsets of `V(K_m)`; `H = K_n^G`). |
| `[GodsilEtAl2020]` Results 1–5, §4 | held PDF (arXiv 1801.08243) | present; Result 5: "Let G and H be graphs such that χv (G) = χv (H). If both G and H admit connected strictly complementary dual solutions, then every optimal vector coloring of G × H is a convex combination of vector colorings induced by the factors." Thm 4.16(1): "If G is a 1-walk-regular graph … If H is a connected graph and χv (G) < χv (H), then every optimal vector coloring of G × H is induced by G." |
| `[GodsilRobersonRooney2017]` §4.3 Thm 4.9 | held PDF (arXiv 1512.04972) | present; its proof gives, for 1-walk-regular `G` of degree `r`, least eigenvalue `τ`, optimal strict colouring with edge inner product `τ/r`, i.e. `χv = 1 − r/τ` |
| `[Zhang2012]` Thm 1.8 | held PDF | present, cases (i)–(iii) as the stub states |
| J21-MX | `plans/M3-S1D-windows-five.md` §3.2 | present (lemma, consequence `θ = λ*/(1+λ*)`, Theorem J21-MX) |
| G54, row 72 | `CLAUDE.md`, `LEDGER.md` | present |

**Fence log.** Read before stage 2's commit: the stub `plans/STUB-tight-product-colourings.md` (allowed), which itself carries a one-sentence sketch of
DA-2′ ("every loop of `K_k^G` is adjacent only to itself …", from `plans/PA-tardif2023.md` §5.4). My §2.2 proof is written independently but that
sentence was seen. Also read (not fenced): `[TardifWrochna2019]` pp. 1–5 (abstract, §1.2) while working V-DB-1. Nothing fenced opened.

### 1.2 C0 — probabilities per claim (set after the stage-1 reading, before any written derivation)

| claim | P(TRUE as worded) | why |
|---|---|---|
| V-DA-1′ | 0.97 | the stub's `C₅ × K₄` recolouring, generalised |
| V-DA-2′ | 0.95 | stub's sketch; the loop argument is short |
| V-DA-3 | 0.90 | GL Cor 1 plus Weichsel-type connectivity |
| V-DA-4 | 0.85 | needs finiteness in Tardif 2023 |
| V-DB-1 | 0.50 | "every connected non-bipartite `G`" is stronger than El-Zahar–Sauer; unclear |
| V-DB-2 | 0.85 | needs `UD(𝔽₉,2)` tight and 3-colourable |
| V-DC-1 | 0.85 | simplex vector colouring + GEA Thm 4.16 |
| V-DC-2 | 0.80 | J21-MX gives a colouring of `G`; pulling back needs a bootstrap |
| V-DD-1 | 0.50 | Result 5 gives convex combinations; the colouring's discreteness must kill the mixture |
| V-DD-2 | 0.35 | existence of a regular tight counterexample is unclear |

### 1.3 Would-have-searched log (running)

1. *Would have run a colouring search on `E₃(C₅)` (213 maps) to probe V-DB-1.* Instead derived its winding classes by hand (§2.5).
2. *Would have enumerated the 80 `𝔽₃`-functionals on `𝔽₉²` for a linear 3-colouring of `UD(𝔽₉,2)`.* Instead derived the functional
   `Tr((1−i)u + iv)` from three trace conditions (§2.6) and checked only that one, exactly.
3. *Would have searched for a regular graph `X` with `λ_min(X) ≥ −d_X/(k−1)` and a Hedetniemi partner (V-DD-2).* Declined; GAP recorded (§2.10).

## Stage 2 — SAVED (the blind phase: a verdict per claim, from my own routes)

*Conventions.* `K_k^G`: vertices all maps `V(G) → [k]`, `f ∼ g` iff `f(u) ≠ g(v)` for every ordered edge `(u, v)`; loops are exactly the proper
colourings; `E_k(G)` is the induced subgraph on improper maps (loopless). A `k`-colouring `β` of `G × H` is the same as a homomorphism
`h ↦ f_h := β(·, h)`, `H → K_k^G` (currying). "Pulled back from `G`" ⟺ `h ↦ f_h` is constant with value a proper colouring.

**Lemma L0 (loops).** *If `f` is a proper `k`-colouring of `G` and `g ∼ f`, then `g(x) ∈ [k] ∖ f(N(x))` for every `x`. If `f` is gap-free then
`g = f`; if `f` has a gap at `u` (colour `c ∉ f(N[u])`), then `g := f` with `g(u) := c` is a second proper colouring with `f ∼ g`.*
Proof. `g ∼ f` says `g(x) ∉ f(N(x))`. Gap-free and proper give `f(N(x)) = [k] ∖ {f(x)}`, so `g(x) = f(x)`. In the gap case `g(x) = f(x) ∉ f(N(x))`
for `x ≠ u` and `g(u) = c ∉ f(N(u))`, so `g ∼ f`; `g` is proper since `c ∉ f(N(u)) = g(N(u))`. ∎

### 2.1 V-DA-1′ — TRUE [hand]

`f` a proper `k`-colouring with a gap at `u`, `g` as in L0: `f, g` are two distinct loops, adjacent. Any map `V(H) → {f, g}` is a homomorphism
`H → K_k^G`; with `|V(H)| ≥ 2` take a non-constant one. Its colouring `β(x, h) = f_h(x)` is proper and not pulled back (`f_h` is not constant). ∎
(With no edges in `H` the statement is still true, since every map is then a proper colouring of `G × H`.)

### 2.2 V-DA-2′ — TRUE [hand]

(⟸) `H` connected, `χ(H) > k`, `β` a `k`-colouring of `G × H`. If some `f_h` is a loop, L0 (gap-free) and connectivity give `f_{h'} = f_h` for all
`h'`: pulled back. Otherwise `h ↦ f_h` maps `H` into `E_k(G)`, so `χ(H) ≤ χ(E_k(G)) ≤ k`, a contradiction.
(⟹) If `χ(E_k(G)) > k`, some component `H` of `E_k(G)` has `χ(H) > k` (a graph whose components are all `k`-colourable is `k`-colourable; choice
is used for infinite `G`). The evaluation colouring `β(x, f) = f(x)` of `G × H` is proper (`(x, f) ∼ (y, g)` gives `f(x) ≠ g(y)`) and not pulled back
(each `f` is improper). ∎ Gap-freedom is used only in (⟸), and only through L0. No finiteness of `G` or `H` is used.

### 2.3 V-DA-3 — TRUE [hand, given GL Cor. 1]

*Connected:* `k ≥ 3`, so `K_k` has a closed walk of every length `≥ 2` between any two vertices; `X` connected with an edge has walks `x → y` of
length `ℓ₀ + 2j` for all `j`; pair them coordinatewise. *Uniquely `k`-colourable:* GL Cor. 1 (`χ(X) > k`, `X` connected); its colourings are
`(a, x) ↦ σ(a)`, gap-free since `x` has a neighbour and `N[(a, x)] ∋ (b, y)` for all `b ≠ a`, `y ∼ x`. *The equivalence.* (⟸) `c : X × H → [k]`
proper; `β((a, x), h) = c(x, h)` is proper on `(K_k × X) × H` and not of the form `σ(a)` (it ignores `a`, and `k ≥ 2`). (⟹) FS67 fails with a
connected `H`, `χ(H) > k`, and `β` not pulled back. `X × H` is connected (the same walk argument with `X` non-bipartite, `H` connected with an
edge). If `χ(X × H) > k`, GL Cor. 1 on `K_k × (X × H)` makes `β = σ(a)`, which is pulled back from the colouring `(a, x) ↦ σ(a)` of `G`. So
`χ(X × H) ≤ k`. ∎

### 2.4 V-DA-4 — TRUE [hand, given `[Tardif2023]` Thm 1 and §2.3]

(First part.) `n = k ≥ 4`, `m = k + 1`: finite `G₀, H₀`, `χ(G₀) ≥ k + 1`, `χ(H₀) > k`, `χ(G₀ × H₀) ≤ k` (finite: Tardif's §2, `G₀ = Ω_w(K_m)`,
`H₀ = K_n^{G₀}`). Take components `X ⊆ G₀`, `H ⊆ H₀` with `χ > k`; `X × H ⊆ G₀ × H₀`, so `χ(X × H) ≤ k`; `G = K_k × X` is finite, connected, uniquely
`k`-colourable, and FS67 fails (§2.3 ⟸). (Second part, `k ≥ 3`.) If `χ(X × H) ≤ k` with `χ(X), χ(H) > k` finite, pass to components as above;
`K_k × X` is finite connected `k`-gap-free and FS67 fails for it — contrapositive. ∎ (At `k = 3` the conclusion is El-Zahar–Sauer.)

### 2.5 V-DB-1 — GAP at "3-colouring the improper maps in a component of `K₃^G` whose winding class is non-zero on every odd closed walk"

What the blind route proved:
1. **Equivalent form** (currying, as in §2.2): `χ(E₃(G)) ≤ 3` ⟺ for every connected `H` with `χ(H) > 3` and every `φ : G × H → K₃`, some slice
   `φ(·, h)` is a proper colouring of `G`.
2. **Non-3-colourable `G`: TRUE** — then `E₃(G) = K₃^G`, and `K₃` multiplicative (El-Zahar–Sauer, as `[Tardif2023]` §1 states it; `[external]`
   via that relay) gives `K₃^G → K₃`.
3. **A winding invariant.** For an odd closed walk `c = (v₀, …, v_{n−1})` and any map `f`, let `w₂^c(f) = (1/3) Σ_{i ∈ ℤ_n} δ(f(v_{i+2}) − f(v_i))`,
   `δ(0) = 0, δ(±1) = ±1` (the lazy winding of `f` along the step-2 cycle of `c`). For an arc `f ∼ g`, the closed walk
   `f(v₀), g(v₁), f(v₂), …` of length `2n` in `K₃` has winding `−2 w₂^c(f)` (each two-step `f(v_i) → g(v_{i+1}) → f(v_{i+2})` has lifted
   displacement `0` or `∓2`, since `g(v_{i+1}) ∉ {f(v_i), f(v_{i+2})}`), and the same walk read from `g`'s positions is a rotation of it, so
   `w₂^c(f) = w₂^c(g)`: **`w₂^c` is constant on components of `K₃^G`**, for every odd closed walk `c`. For a proper colouring `f`,
   `w₂^c(f) = −w^c(f)`, odd, hence non-zero. So a component with a loop has `w₂^c ≠ 0` for every odd `c`.
4. **Zero class** — if `w₂^c = 0` on a component for some odd `c`, the component restricts into the winding-zero part of `K₃^c`, which is
   3-colourable by the square-free theory of `[TardifWrochna2019]` (the constants' component `K_ε^{C_n}` maps to `K`; `[external]`, not in my
   verified inputs, and the identification "winding zero = the constants' component" is theirs, unchecked). Such components are 3-coloured
   uniformly by a fixed enumeration of odd walks (adjacent maps share every `w₂^c`).
5. **Check at `G = C₅`** [hand]: in the class `w₂ = −1` there are 45 maps: 15 loops, 15 improper maps of step type `(0,0,−1,−1,−1)`, 15 of type
   `(+1,−1,−1,−1,−1)`. Each type-A improper map has exactly 4 neighbours (2 type-A improper, 1 type-B, 1 loop); each type-B map has exactly one
   neighbour (type-A). So the improper part is a 2-regular graph with pendant leaves: 3-colourable. No counterexample at `C₅`.

**The missing step, named:** a 3-colouring of the improper maps lying in components where every `w₂^c` is non-zero (for 3-gap-free `G`: such
components contain no loop, by L0, and I could neither show they are empty nor colour them). The "hence" clause follows from the first clause by
§2.2 (a connected 3-gap-free graph is non-bipartite, since a 2-colouring would be a gapped 3-colouring). **Verdict: GAP**, route stalled; stage 3
candidate.

### 2.6 V-DB-2 — TRUE [hand + tools exact]

*Level one* (`tools/crunch_j27v_fq9.py`, output `data/fs67/j27v/fq9.out`, plant `--plant` fires at C3): `UD(𝔽₉, 2) = Cay(𝔽₉², S)`, `|S| = 8`
(`x² + y² = (x+iy)(x−iy)` splits, `S ≅ {(t, t⁻¹)}`), `S` spans `𝔽₉²` over `𝔽₃` (connected), spectrum `{8, 5⁸, 2²⁴, −1³², −4¹⁶}` so `λ_min = −4 = −d/2`
(tight at 3), and the derived colouring `c = Tr((1−i)u + iv)` (`u = x+iy`, `v = x−iy`) is proper — derived from three trace conditions: at
`t = ±1` need `Tr(α+β) ≠ 0`, at `t = ±i` need `Tr((α−β)i) ≠ 0`, at the four norm-`−1` units need `α − β̄ ∈ {±1, ±i}`. Tight + 3-colourable ⟹
every 3-colouring balanced and gap-free (G54; Hoffman equality puts `d/2 > 0` neighbours of each vertex in each other class). *Every level:*
the reduction `(O/3^m)² → 𝔽₉²` maps the unit circle onto the unit circle (lift `t` to any unit), so it is a homomorphism (3-colourable at every
level) and the subgroup `Λ_m` generated by `S_m` satisfies `Λ_m + 3M = M`, `M = (O/3^m)²` a finite abelian 3-group, so `Λ_m = M` (the Frattini
subgroup of `M` is `3M`): connected at every level. Then at any level that is spectrally tight at three colours, G54 gives gap-free. ∎
*Caveat for stage 4:* the claim's "every level … that is Hoffman-tight" is read with row 72's tower `(O/3^m)²` and the circle `x² + y² = 1`; if the
plan means another tower model, the Frattini step must be re-read.

### 2.7 V-DC-1 — TRUE [hand, given `[GodsilEtAl2020]` Result 1 and Thm 4.16(1)]

`β` a proper `k`-colouring of `G × H`; `p(x, h) = √(k−1)·e_{β(x,h)}` (regular simplex, `⟨e_i, e_j⟩ = −1/(k−1)`) is a vector `k`-colouring in GEA's
normalisation (`pᵀp = k − 1`, `−1` on edges). Result 1: `χv(G × H) = min(k, χv(H)) = k`, so `p` is optimal. Thm 4.16(1) (1-walk-regular `G`,
`H` connected, `χv(G) < χv(H)`): `p` is induced by `G`, i.e. `p(x, h)` does not depend on `h`; the `e_i` are distinct, so `β(x, h) = c(x)`, and `c`
is proper (take an edge `hh'` of `H`: `c(x) = β(x, h) ≠ β(y, h') = c(y)` for `x ∼ y`). ∎ Finite graphs (GEA's SDP setting).

### 2.8 V-DC-2 — TRUE with `τ_k = 1/(k−1)`, and that constant is sharp [hand, from J21-MX]

Let `m_j(x) = |β(x, ·)⁻¹(j)|/|A|`. For `x ∼ y` and any `j`, the sets `P = β(x,·)⁻¹(j)`, `Q = β(y,·)⁻¹(j)` have no `b ∈ P`, `t ∈ T` with `b + t ∈ Q`,
so the mixing lemma (J21-MX §3.2, finite `A`, `ν` uniform on `T`) gives, with odds `r = m/(1 − m)`: **`r_j(x) r_j(y) ≤ λ*²`** (and `m_j(x) = 1 ⟹
m_j(y) = 0`). *Step 0:* `λ* < 1/(k−1)` ⟺ `θ = λ*/(1+λ*) < 1/k`, so J21-MX makes `φ(x) = min{j : m_j(x) > θ}` a proper `k`-colouring of `G`; `G` is
`k`-gap-free, so for `j ≠ φ(x)` some neighbour `y` has `φ(y) = j`, `m_j(y) > θ`, `r_j(y) > λ*`, hence `r_j(x) < λ*`: `ε₁ := sup_{x, j ≠ φ(x)} m_j(x) ≤ θ`.
*Bootstrap:* then `m_{φ(y)}(y) ≥ 1 − (k−1)ε_n`, so `ε_{n+1} ≤ F(ε_n)`, `F(ε) = cε/(1 − (k−1)ε + cε)`, `c = (k−1)λ*²`, `F` increasing, and
`F(ε)/ε ≤ F(θ)/θ < 1` ⟺ `c(1−θ) < 1 − (k−1)θ` ⟺ `(k−1)λ*² + (k−2)λ* − 1 < 0` ⟺ `((k−1)λ* − 1)(λ* + 1) < 0` ⟺ `λ* < 1/(k−1)`. So
`ε_n ≤ ρ^{n−1}θ → 0`; as `m ∈ (1/|A|)ℤ`, eventually `m_j(x) = 0` for all `j ≠ φ(x)`: `β = φ ∘ pr_G`, pulled back. ∎ Neither connectivity of
`G` nor finiteness of `G` is used. **Sharpness:** `H = K_k = Cay(ℤ/k, ℤ/k ∖ 0)` has `λ* = 1/(k−1)` exactly, and `(x, a) ↦ a` is a `k`-colouring of
`G × K_k` not pulled back from `G`; so no `τ_k > 1/(k−1)` makes the claim true. (`λ* < 1` already forces `T` to generate `A`, so `H` is connected, and
`λ* < 1/(k−1)` forces `α(H) < |A|/k`, so `χ(H) > k`.)

### 2.9 V-DD-1 — TRUE [hand, given `[GodsilEtAl2020]` Results 1 and 5]

`p` as in §2.7 is optimal (`χv(G × H) = k`). Result 5: its Gram matrix is `α(M^q ⊗ J) + β′(J ⊗ M^r)`, `α + β′ = 1`, `α, β′ ≥ 0`, `q, r` vector
`k`-colourings (diagonals `k − 1`, `≤ −1` on edges, entries in `[−(k−1), k−1]`); every entry of Gram(`p`) is `k − 1` (same colour) or `−1`.
If `0 < α < 1`: for an edge `hh′` of `H`, the entry at `((x, h), (x, h′))` is `α(k−1) + β′r_{hh′} ≤ (k−1) − kβ′ < k − 1`, so it is `−1`, so
`r_{hh′} = −(1 + α(k−1))/β′ ≥ −(k−1)` gives `α ≤ (k−2)/(2(k−1))`; symmetrically an edge `xy` of `G` gives `β′ ≤ (k−2)/(2(k−1))`; summing,
`1 ≤ (k−2)/(k−1)`, false. `α = 0` makes `β(x, h)` depend on `h` only, a `k`-colouring of `H` (as `G` has an edge), against `χ(H) > k`. So `α = 1`,
`⟨p(x,h), p(x,h′)⟩ = k − 1`, `β(x, h) = β(x, h′)`: pulled back. ∎ `H` connected is not needed; the conclusion is the claim's.

### 2.10 V-DD-2 — GAP at "a regular `X`, `χ(X) > k`, with `λ_min(X) ≥ −d_X/(k−1)` and a connected `H`, `χ(H) > k`, `χ(X × H) ≤ k`"

Proved: for `X` `d_X`-regular connected, `G = K_k × X` is `(k−1)d_X`-regular with spectrum `{(k−1)μ} ∪ {−μ}` (`μ` over `X`'s spectrum), so
`λ_min(G) = min(−d_X, (k−1)μ_min(X))`, and **`G` is Hoffman-tight at `k` iff `μ_min(X) ≥ −d_X/(k−1)`**; with §2.3, FS67(G, k) fails iff some connected
`H`, `χ(H) > k`, has `χ(X × H) ≤ k`. So V-DD-2 follows from a Hedetniemi-deficient pair whose one factor is regular with Hoffman ratio `≥ k`.
`[Tardif2023]`'s `Ω_w(K_m)` is not evidently regular, and I did not construct one (would-have-searched, item 3). Also noted: if `G` is also
1-walk-regular (e.g. `X` arc-transitive), §2.7 forces any witness `H` to have `χv(H) ≤ k < χ(H)`. **Verdict: GAP**, route stalled at the named
construction; stage 3 candidate. (Reading "Hoffman-tight" purely spectrally, a tight regular `G` with `χ(G) > k` in a Hedetniemi-deficient pair
would also witness it vacuously; the same missing construction.)

### 2.11 Stage-2 summary

| claim | blind verdict | inputs used |
|---|---|---|
| V-DA-1′ | TRUE | none |
| V-DA-2′ | TRUE | none |
| V-DA-3 | TRUE | GL Cor. 1 |
| V-DA-4 | TRUE | Tardif 2023 Thm 1 (+ finiteness from its §2) |
| V-DB-1 | GAP (non-zero-winding improper components) | EZS via Tardif 2023 (non-3-colourable case); TW 2019 [external] (zero class) |
| V-DB-2 | TRUE | G54; exact tool |
| V-DC-1 | TRUE | GEA Result 1, Thm 4.16(1) |
| V-DC-2 | TRUE, `τ_k = 1/(k−1)`, sharp | J21-MX lemma |
| V-DD-1 | TRUE | GEA Results 1, 5 |
| V-DD-2 | GAP (regular spectrally-fat Hedetniemi factor) | GL Cor. 1 |
| V-DC-3 | stage 4 only | — |

C0 against the blind verdicts: the two claims I put at 0.50 split (V-DB-1 GAP, V-DD-1 TRUE); V-DD-2 at 0.35 is GAP, not FALSE.
