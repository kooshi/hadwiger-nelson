# FS84-S1V — blind verification of FS-84 stage S1 (claims V1–V3)

*Crunch job FS84-S1V (2026-09-25), Opus 5.5, one mind. Brief: `data/crunch-2026-09-25/briefs/J29-S1V-FS84-blind-verifier.md` with
`STANDING-RULES.md`, as amended by the owner's launch message (run now under the search ban; the fence widened to `reports/J31.md`, the
deriver's brief, every `tools/fs84_s1_*` and every "J31" commit body; V1 watched for the ~10⁻⁶ margin and the statement's scope; the
deriver's §4.2 claim S1e added to phase 2, non-blind). Budget 300k, hand back by 420k.*

*Blindness: until stage 1 was committed I opened none of `plans/FS84-five-colours-47.md`, `plans/FS84-S1-derivation.md`, `data/fs84/`,
`plans/CRUNCH-2026-09-25-INDEX.md`, `data/crunch-2026-09-25/reports/J31.md`, the deriver's brief, any `tools/fs84_s1_*`, or any J31 commit
body. (A directory listing showed two file names, `tools/fs84_s1_band_candidates.py` and `tools/fs84_s1_ratio_table.py`; neither was
opened.) Inputs read: `CLAUDE.md`, `LEDGER.md` rows 75 and 95–110, the `[Zhang2012]` bibliography row, `data/fs66/b1/level-one-sets.json`.*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| S1V-1 | Every finite quotient `Cay(R/L, U+L)` of the plane over ℚ(√47) (`R = ℤ[U]`, `U ∩ L = ∅`) has independence ratio at most the maximum, over the stable places `w`, of `sup_k i(G_k^{(w)})`, `G_k^{(w)}` the full level-`k` residue graph at `w` | hand (with `[Zhang2012]` Thm 1.8, weak approximation for the norm-one torus, prime inversion) | §V1.2 steps 1–5 |
| S1V-2 | At an unramified inert place (`ℤ_p[i]`, `p` odd) and at a ramified place with unramified `F_v(i)/F_v` (`O = ℤ_p[π]`), every character of `G_k` new at level `k ≥ 2` has `\|λ\| ≤ 2p^{⌈k/2⌉}`; so `λ_min(G_k)/d_k = λ_min(G_1)/d_1` whenever `\|λ_min(G_1)\| ≥ 2` | hand; float sanity at 7 (both kinds, `k = 2, 3`) and 31 (`k = 2`) | §V1.2 step 6; `tools/fs84_s1v_ratio_check.py` part C |
| S1V-3 | `λ_min(Γ₃₁) = −10.6665104938…`, so `λ_min + 32/3 ≥ 1.5617·10⁻⁴` and Hoffman gives `i ≤ 0.249997254763… = 1/4 − 2.7452·10⁻⁶` at every level of the 31-tower | exact (interval arithmetic at 80 digits, and an exact Sturm count on the integer polynomial `∏_c (x − λ(c))`) | part A, A′ |
| S1V-4 | `ρ_per(ℚ(√47)) ≤ 0.2499972548 < 1/4`; the bound binds at 31; the supremum itself lies in `[28/121, 0.2499972548]` and is attained at 11 or at 31, which one not decided | hand + exact + row 75's certificates at 11 and 19 | §V1.3 |
| S1V-5 | V2: for countable amenable `G` acting on a graph, `k`-colourable ⟺ a `G`-invariant probability on proper `k`-colourings; hence `ι_G ≥ 1/k`. Amenability load-bearing: an explicit `F₂`-graph, 6-colourable, whose proper 6-colourings map equivariantly onto `∂F₂` | hand | §V2 |
| S1V-6 | V3: a point (rational or not) of `Θ_k(Λ)` gives a proper `k`-colouring `⌊kθ̃⌋`, periodic under `ker θ` of finite index when `θ` is rational; `Θ₄(R) = ∅` ⟹ some saturated `Λ_M` of an exhausting chain has `Θ₄(Λ_M) = ∅` (non-effective) | hand | §V3 |
| S1V-7 | `Cay(ℤ, ±{1,3,4,5})` is four-colourable (period 8, classes `{0,2},{1,3},{4,6},{5,7}` mod 8) with `Θ₄ = ∅` | hand | §V3 (ii) |
| S1V-8 | S1e (non-blind): (i) holds once `Γ` is assumed four-colourable (as worded it fails vacuously otherwise), also with matrix coefficients; (ii) and (iii) hold as stated | hand | §2.3 |
| S1V-9 | `ρ_per(ℚ(√47)) = max_w τ_w` with equality (the single-place reductions are admissible `L`; no surjectivity of `R → A_w` needed) | hand | §2.1 |

## Stage 0 — quotation check (standing rule 5)

The brief's three claims are quoted "verbatim from the plan's §M.1". That plan is fenced until stage 1 is committed, so the check is done in
stage 2 (§2.0). No other quotation in the brief is load-bearing. The ledger rows the brief names as inputs (75, 88, 92, 95, 96) were read at
their own addresses; row 96's clause used below is quoted from `LEDGER.md` line 124: "ℚ(√47)'s plane has no character four-colouring (`Θ₄ = ∅`)".

## Stage 1 — SAVED: blind verdicts

| claim | verdict | one line |
|---|---|---|
| **V1** `ρ_per(ℚ(√47)) < 1/4` | **TRUE** | bound `0.2499972548`, binding at 31 with margin `2.7452·10⁻⁶` (exact); needs row 75's certificates at 11 and 19 (not at 23), `[Zhang2012]`, weak approximation, prime inversion; **not** `[AmbrusEtAl2023]` |
| V1 "which prime attains the supremum" | **GAP** (undecided, not false) | the supremum is `max(τ₁₁, τ₃₁)`: `τ₁₁ ∈ [0.231405, 0.233094]`, `τ₃₁ ∈ [?, 0.2499973]`; every other stable place is below `0.2314`. It is 11 iff `τ₃₁ ≤ τ₁₁`, unproved |
| **V2** (amenable ⟹ invariant measure ⟺ colourable; `ι_G ≥ 1/k`) | **TRUE**; amenability **load-bearing** | Markov–Kakutani on the compact space of colourings; counterexample for `F₂` |
| **V3 (i)** a rational point of `Θ₄(Λ)` four-colours periodically | **TRUE** | `⌊4θ̃⌋`, period `ker θ` |
| **V3 (ii)** "`Θ₄(Λ) = ∅` implies nothing about four-colourability" | **TRUE** as "no theorem gives non-4-colourability from `Θ₄ = ∅`" and in the class of abelian Cayley graphs (S1V-7); **GAP** in the stated class | no f.g. `Λ ⊆ ℤ[U_F]` with `Θ₄(Λ) = ∅` and a four-colouring is exhibited; the other half (`Θ₄ = ∅` does not imply colourable) has trivial witnesses |
| **V3 (iii)** `Θ₄(R₄₇) = ∅` ⟹ some saturated `Λ_M` has `Θ₄(Λ_M) = ∅` | **TRUE** | inverse limit of non-empty compact sets; needs the chain exhausting `R` with `S_M = U ∩ Λ_M`, and the band closed; non-effective |

### V1 — `ρ_per(ℚ(√47)) < 1/4`

**V1.1 Reading and scope.** `R = ℤ[U_F]` for `F = ℚ(√47)`, `E = F(i)`; `U = T(F)`, `T` the norm-one torus of `E/F`; `U` is a multiplicative
group, so `R` is the ℤ-span of `U`, and the unit-distance graph on `F² = E` is `[E : R]` disjoint copies of `Cay(R, U)`. The supremum
ranges over **every** finite-index additive subgroup `L ≤ R` with `U ∩ L = ∅` — ideals or not, no finite generation (`R` is not finitely
generated: it holds `1/2, 1/3, 1/7, 1/5, …`). **"Periodic"** therefore covers: colourings of `Cay(R, U)` (equivalently of each `R`-coset of
the plane) constant on the cosets of some finite-index `L`. A periodic proper `k`-colouring forces `U ∩ L = ∅` and factors through
`Cay(R/L, U+L)`, so it gives `α ≥ [R:L]/k`; **`ρ_per < 1/4` excludes exactly these**. It does **not** cover: (a) colourings of a finitely
generated `Λ ⊆ R` periodic under `NΛ` with generators `U ∩ Λ` — their quotients carry fewer generators and may exceed ratio 1/4; (b)
non-periodic colourings, measurable or not; (c) invariant random colourings — V2's `ι_R(Cay(R, U))` is `≥ ρ_per` (a periodic independent set
spread uniformly over its finite orbit is an invariant measure) and nothing in V1–V3 gives `ι_R ≤ ρ_per`, so **V1 with V2 does not give
`χ(ℚ(√47)²) ≥ 5`**.

**V1.2 Proof (mine).**
1. *Stable places.* `Gal(E/ℚ) = {1, c, τ, cτ}`, `c` complex conjugation (fixes √47). For `p ∤ 94`, a prime of `E` above `p` is `c`-stable iff
   `Frob_p = c` iff `p ≡ 3 (mod 4)` and `(47/p) = 1`. At 2: `−47 ≡ 1 (mod 8)`, so 2 is unramified (split) in ℚ(√−47) and the decomposition
   group is `{1, cτ}`, not containing `c`: no stable prime. At 47: `e = f = 2`, `g = 1`: stable. So the stable set is `T = {47} ∪ {p ≡ 3 (4) :
   (47/p) = 1} = {11, 19, 23, 31, 43, 47, 67, 107, …}` (tool part B; 2, 3, 7 excluded, as the frontier says).
2. *Integrality.* For stable `𝔓` and `u ∈ U`: `v_𝔓(u) = v_𝔓(ū)` and `v_𝔓(u) + v_𝔓(ū) = 0`, so `u ∈ O_𝔓^×`; hence `R ⊆ ⋂_{stable} O_𝔓`.
   Since `E/ℚ` is abelian, all primes above `p ∈ T` are stable, so `R_(p) := R ⊗ ℤ_(p) ⊆ O_E ⊗ ℤ_(p)`, a finitely generated `ℤ_(p)`-module;
   `U` spans `E` over ℚ (`(3+4i)/5` gives `i`; `(−46 + 2√47 i)/48 ∈ U \ ℚ(i)`), so `p^c(O_E ⊗ ℤ_(p)) ⊆ R_(p)` for some `c`.
3. *Only stable primes divide `[R:L]`.* By prime inversion (`1/p ∈ R` iff no stable prime above `p`: `[Fischer1990b]` Thms 1, 3, 4 for
   real quadratic fields; G55; the valuation form is row 105, kernel), `R` is `p`-divisible for `p ∉ T`, so `R/L` is a `T`-group.
4. *To full levels.* With `NR ⊆ L`, `Cay(R/L)` is a quotient of `Cay(R/NR)` by a subgroup meeting no generator; pulling an independent set
   back keeps its density, so `i(Cay(R/L)) ≤ i(Cay(R/NR))`. `R/NR = ⊕_{p∈T} R/p^{e_p}R`, and `R/p^eR = R_(p)/p^eR_(p)` is a quotient of
   `R_(p)/p^{e+c}O_(p)`, a subgroup of `A_p := ∏_{w|p} O_w/p^{e+c}O_w` containing the image of `U`; `Cay(A_p, U)` is a disjoint union of copies
   of `Cay(R_(p)/p^{e+c}O_(p), U)`, so the ratios agree and `i(Cay(R/p^eR)) ≤ i(Cay(A_p, U))`.
5. *Products.* `T ≅ {x² + y² = 1}` has the rational point `(1, 0)`, so it is `F`-rational and `U = T(F)` is dense in `∏_{v∈V} T(F_v)` for
   every finite `V` (weak approximation). The map `U → ⊕_p R/p^{e_p}R` is locally constant for the `V`-adic topology (`u ≡ u'` mod
   `p^{e+c}O_(p)` at every `w | p` gives `u − u' ∈ R ∩ p^eR_(p) = p^eR`, since multiplication by `m` prime to `p` is invertible on
   `R/p^eR`), hence extends to the closure, and its image is the product of the local images. So `Cay(R/NR, U)` is the categorical product
   of `Cay(R/p^{e_p}R, U)` over `p`, and `Cay(A_p, U)` the categorical product of the full level graphs `G^{(w)}` over `w | p`. By
   `[Zhang2012]` Thm 1.8 (vertex-transitive factors; iterated), `i(product) = max i(factor)`. Hence
   `ρ_per(F) ≤ max_{w} sup_k i(G_k^{(w)})` (S1V-1), with `G_k = UD(ℤ/p^k, 2)` at the two places over each `p ∈ T \ {47}` and the ramified
   tower `O_w/π^k` (`O_v = ℤ₄₇[√47]`, `F_v(i)/F_v` unramified because −1 is a non-square mod 47) at 47, whose level one is `Γ₄₇`.
6. *Constant Hoffman ratio up a tower (S1V-2).* Characters of `G_k` are `x ↦ e(Tr(ax)/p^k)` (trace form perfect, `p` odd). If `a = p^j b`,
   `b` a unit, `λ_k(a) = p^j λ_{k−j}(b)` (fibres of `S_k → S_{k−j}` have `p^j` points), so pulled-back characters keep `λ/d`. For `a` a unit
   and `k ≥ 2`, put `m = ⌈k/2⌉`, `n = k − m`; `K = ker(S_k → S_m) = {1 + p^m s i : s mod p^n}`, and the sum over each `K`-coset `u₀K` is
   `p^n e(Tr(au₀)/p^k)` if `Im(au₀) ≡ 0 (mod p^n)`, else 0. `au₀ ≡ r ∈ ℤ_p (mod p^n)` forces `r² ≡ N(a)`: at most two `r`, each fixing
   `u₀` mod `p^n`, i.e. `2p^{m−n}` cosets. So `|λ_k(a)| ≤ 2p^m`. The ramified case is the same computation with `π` for `p`, `Tr_{M/O}(ti) =
   −2 Im t`, the inverse different `π^{−1}O`, and `O/π^n` local with 2 invertible (square roots of a unit unique up to sign). Since
   `⌈k/2⌉ ≤ k − 1` for `k ≥ 2`, new characters satisfy `|λ| ≤ 2p^{k−1} < |λ_min(G_1)| p^{k−1}` whenever `|λ_min(G_1)| > 2` (true at every
   `p ∈ T`, table below), so `λ_min(G_k) = p^{k−1}λ_min(G_1)` and `d_k = p^{k−1}d_1`. (This is row 75's `|λ| ≤ 2p^{k−1}` sharpened, and
   G54's "inert tower" scaling, re-derived; the ramified case is new here as far as I know.) Tool part C: the bound is met with equality at
   the ramified `k = 2` and to 3·10⁻⁴ at 31, `k = 2`.
7. *The bounds per place* (`i(G_k) ≤ h_p := −λ₁/(d₁ − λ₁)` for every `k` by Hoffman and step 6, unless a certificate is better):

| place | `λ_min(Γ_p)` | Hoffman `h_p` | used bound, every level | source |
|---|---|---|---|---|
| 11 (×2) | −4.795754778 | 0.28553 (useless) | `28.204320/121 = 0.2330936` | row 75 certificate |
| 19 (×2) | −7.609728632 | 0.27562 (useless) | `77.511742/361 = 0.2147140` | row 75 certificate |
| 23 (×2) | −7.960687187 | **0.2490775** (`< 1/4` by 9.2·10⁻⁴) | `97.984637/529 = 0.1852262` (or Hoffman) | row 75, or Hoffman alone |
| **31 (×2)** | **−10.6665104938** | **0.2499972548** | the same | exact (A, A′) |
| 43 (×2) | −11.962230123 | 0.2137554 | the same | exact |
| 47 (ramified) | −12.846527722 | 0.2111300 | the same (step 6, ramified) | exact |
| 67 (×2) | −15.056703350 | 0.1812822 | the same | exact |
| `p ≥ 107` in `T` | `\|λ\| ≤ 2√p` (Weil) | `≤ 2√p/(p+1+2√p) ≤ 0.1609` | the same | Weil; decreasing in `p`; `6√p < p+1` iff `p > 17+12√2 ≈ 33.97` |

**V1.3 Verdict.** **TRUE**: `ρ_per(ℚ(√47)) ≤ 0.2499972548 < 1/4`. **The proof's binding place is 31**, where the only available bound is
Hoffman's and `λ_min(Γ₃₁) + 32/3 = 1.56173·10⁻⁴` (so `1/4 − h₃₁ = 2.74524·10⁻⁶`), certified two ways: interval arithmetic at 80 digits, and an
exact route — the degree-30 integer polynomial `∏_{c∈𝔽₃₁^×}(x − λ(c))` (integer coefficients: the multiset is Galois-stable, `σ_t: λ(c) ↦
λ(t²c)`, and the `λ(c)` are algebraic integers; each coefficient's interval certified to hold one integer) has no real root in
`[−32, −32/3]` (exact Sturm count). Plants: a threshold `10⁻³` above `−32/3` fails at 31 (P1), Hoffman at 11 exceeds 1/4 (P2), a dropped
circle point trips its assertion (P3), a negated Legendre symbol changes the stable list (P4) — all fired.
**Which prime attains the supremum — GAP (undecided).** `ρ_per = max_w τ_w`, `τ_w = sup_k i(G_k^{(w)})`. `τ₁₁ ≥ 28/121 = 0.231405`
(the 28-point set in `data/fs66/b1/level-one-sets.json`, re-checked independent here) and `≤ 0.233094`; every place but 11 and 31 is bounded
below `0.2314` (table), so the maximum is attained, at 11 or at 31. It is 11 iff `τ₃₁ ≤ τ₁₁`, which needs `α(G_k^{(31)}) ≤ 0.2314·31^{2k}` at
every level: not known (no certificate at 31; level one alone is bounded only by Hoffman, `α(Γ₃₁) ≤ 240`, and five-colourability of `Γ₃₁` is
open). A claim that 31 "attains" the supremum would confuse the binding bound with the supremum. **Margin:** the proof certifies
`1/4 − ρ_per ≥ 2.7452·10⁻⁶`; the truth lies in `[2.7452·10⁻⁶, 0.018595]`.
**Inputs:** row 75's certificates at 11 and 19 (not needed at 23: Hoffman suffices there, margin `9.2·10⁻⁴`); `[Zhang2012]` Thm 1.8, needed
because the certificate bounds are not spectral and must pass through products; Hoffman; Weil; weak approximation; prime inversion.
**`[AmbrusEtAl2023]` is not needed.** Nothing in the proof reads a real place.

### V2 — invariant measures on colourings

**Proof.** The proper `k`-colourings form a closed subset `X_k` of the compact space `[k]^{V(Γ)}`, invariant under `(g·c)(v) = c(g⁻¹v)`,
which acts by homeomorphisms. If `Γ` is `k`-colourable, `X_k ≠ ∅`; a countable amenable group fixes a probability measure on every non-empty
compact `G`-space (average `δ_{c₀}∘g` against an invariant mean; Riesz), which is Borel (regular; metrizable when `V(Γ)` is countable).
Conversely a probability on `X_k` needs `X_k ≠ ∅`. For the consequence, `c ↦ c⁻¹(j)` is a continuous equivariant map into the independent
sets; the pushforwards `ν_j` are invariant and `Σ_j ν_j{I ∋ v₀} = 1`, so some `ν_j{I ∋ v₀} ≥ 1/k`. Vertex-transitivity is not used; it only
makes `ι_G` independent of `v₀` (invariance moves `v₀` along its orbit). **TRUE.** Local finiteness is not needed.

**Amenability is load-bearing (dropped once).** `G = F₂ = ⟨a, b⟩`, `D = {a, a⁻¹, b, b⁻¹}`, six colours `D ∪ {L, R}`. `Γ`: a palette `K₆`
`{p_c}` fixed pointwise by `G`; hubs `h_g` (lists `D`: joined to `p_L, p_R`); edge vertices `e_{g,x}`, `x ∈ {a, b}`, for the tree edge
`{g, gx}` (list `{L, R}`); gadgets (a vertex of list `{s, t}` joined to all other palette vertices): `w_{g,x} ∈ {x, R}` joined to `h_g` and
`e_{g,x}` gives "`h_g = x ⟹ e_{g,x} = L`"; `w_{g,x,t} ∈ {t, L}`, `t ∈ D \ {x}`, likewise gives "`h_g = t ⟹ e_{g,x} = R`"; symmetrically at
`h_{gx}`: `{x⁻¹, L}` gives "`h_{gx} = x⁻¹ ⟹ e = R`" and `{t, R}`, `t ≠ x⁻¹`, gives "`h_{gx} = t ⟹ e = L`". So in every proper
6-colouring, `h_g = x ⟺ e_{g,x} = L ⟺ h_{gx} ≠ x⁻¹`: every tree vertex points to one neighbour and every edge is pointed along by exactly one
end — an out-degree-one orientation of the 4-regular tree, i.e. an end `ω ∈ ∂F₂` (every vertex points to its neighbour towards `ω`).
Left multiplication acts by automorphisms; `Γ` is 6-colourable (pick any end; every gadget is satisfiable); and `c ↦ ω(c)` (read the hubs
against the palette) is continuous and equivariant. `∂F₂` carries no `F₂`-invariant probability: with `C_x` the ends starting with `x`,
`C_a = a(C_a ⊔ C_b ⊔ C_{b⁻¹})` gives `μ(C_b ⊔ C_{b⁻¹}) = 0`, and symmetrically `μ(C_a ⊔ C_{a⁻¹}) = 0`. So no invariant probability on proper
6-colourings exists although `Γ` is 6-colourable: the "only if" fails without amenability. (Not vertex-transitive; whether the `ι` clause
alone fails for some non-amenable vertex-transitive action I did not settle — logged, not needed: the claim assumes amenability.)

### V3 — `Θ₄` at the lattice level

`Θ_k(Λ) = {θ ∈ Hom(Λ, ℝ/ℤ) : θ(S) ⊆ [1/k, 1 − 1/k] + ℤ}`, `S = U ∩ Λ` (G71's closed band).
**(i) TRUE.** For any `θ ∈ Θ_k(Λ)` put `c(x) = ⌊kθ̃(x)⌋`, `θ̃(x) ∈ [0, 1)` the representative: two points in one class differ by a value in
`(−1/k, 1/k) + ℤ`, disjoint from the band, so `c` is proper (this needs no rationality). If `θ` is rational, `θ(Λ) ⊆ (1/N)ℤ/ℤ`, `c` is constant
on cosets of `ker θ`, of index `≤ N`: periodic.
**(ii) "implies nothing".** One half is immediate: `Θ₄ = ∅` does not imply four-colourability (every non-4-colourable `Λ` has `Θ₄ = ∅` by (i);
e.g. the ℤ-span of the edge vectors of any five-chromatic unit-distance graph, a subgroup of `ℤ[U_F]`, saturated). The other half — `Θ₄ = ∅`
does not imply non-4-colourability — is **TRUE among abelian Cayley graphs** (S1V-7: `Cay(ℤ, ±{1,3,4,5})` four-colours with period 8, and
`Θ₄ = ∅`: `4θ` in the band puts `θ ∈ [5/16, 7/16]` up to sign, `3θ` then puts `θ ∈ [5/12, 7/16]`, where `5θ ∈ [25/12, 35/16]` has fractional
part in `[0.083, 0.19]`), and **TRUE as "no theorem"** (no height at four colours, G71, row 80). **In the stated class — finitely generated
`Λ ⊆ ℤ[U_F]` with `S = U ∩ Λ` — GAP**: no four-colourable `Λ` with `Θ₄(Λ) = ∅` is exhibited, and without one the implication is unrefuted
there. A route to a witness (not run): a real field with `χ(F²) ≤ 4` and `Θ₄(R_F) = ∅` (by row 95 and weak approximation, `Θ₄(R_F) ≠ ∅`
iff some torsion character of `R_F/168R_F` is band on `U`), then (iii). The obvious fields fail: K and every field with a stable `𝔽₃` or `𝔽₇`
place carry band characters (Fischer's `ℤ/4`; order-3 characters; at `Γ₇` the characters `Tr(ax)/7` with `N(a) = 5` take the values
`{2, 3, 4, 5}/7`).
**(iii) TRUE**, given row 96 (`Θ₄(R₄₇) = ∅`). Let `Λ₁ ⊆ Λ₂ ⊆ ⋯` be finitely generated with `⋃ Λ_M = R` and `S_M = U ∩ Λ_M` (saturated). Each
`S_M` is finite (`Λ_M ⊆ N⁻¹O_E`, discrete in `ℂ²` under the two complex embeddings, and `U` lies in the compact `S¹ × S¹`). `Θ₄(Λ_M)` is closed
in the torus `Hom(Λ_M, ℝ/ℤ)` (closed band); restriction maps `Θ₄(Λ_{M+1})` into `Θ₄(Λ_M)` (as `S_M ⊆ S_{M+1}`). If every `Θ₄(Λ_M)` were
non-empty, the inverse limit of non-empty compact sets would be non-empty, and a compatible family is a character of `R = ⋃Λ_M` band on
`U = ⋃S_M`: a point of `Θ₄(R)`, contradiction. **Conditions the statement needs:** the chain exhausts `R` (if "the saturated chain" is built
from a subset of `U`, it proves `Θ₄ = ∅` only for the ring that subset generates); saturation; the closed band. **Non-effective:** no bound
on `M`.

## Would-have-searched log

| where | the search | what I did instead |
|---|---|---|
| V1, the attaining prime | a large independent set in `Γ₃₁` (or at level 2) to compare `τ₃₁` with `τ₁₁` | reported undecided with the exact bracket |
| V1, the ramified tower at 47 | the level-2 spectrum of `O_w/π²` (`47⁴` characters × 2,256 points) | derived the bound; checked the same derivation at the ramified place of ℚ(√7) at levels 2 and 3 (seconds) |
| V3 (ii) | a `Θ₄` tree over candidate lattices plus a colouring finder, for a four-colourable `Λ` with `Θ₄ = ∅` | GAP, with the route named |
| V2 | a vertex-transitive non-amenable counterexample to the `ι` clause | not needed for the claim; logged |

## Stage 2 — SAVED: the deriver's record opened; divergences

*Opened after stage 1's commit (`3bb6b771`): `plans/FS84-S1-derivation.md` (J31, 379 lines, read in full) and `plans/FS84-five-colours-47.md`
§5.1–§5.2 and its §G line for R96. Still unopened: `data/crunch-2026-09-25/reports/J31.md`, the deriver's brief, `tools/fs84_s1_*`.*

### 2.0 Quotation check, completed (standing rule 5)

| brief's claim | source | verdict |
|---|---|---|
| V1 | plan §5.1 first bullet | **verbatim** |
| V2 | plan §5.1 second bullet | **verbatim** |
| V3, first sentence ("implies nothing …; a rational point … periodically") | not in the plan (grep for its phrases in the plan and in the deriver's record: nothing) | **not a quotation**: the planner's own formulation of "S1c's frame". The deriver's nearest text, §3.1: "A rational band character of `Λ_M` is a periodic four-colouring; whether `Θ₄(Λ_M) ≠ ∅` at all is a finder's question (out)." |
| V3, second sentence (compactness) | plan §G, line 236: "R96 — bears: `Θ₄(R_{ℚ(√47)}) = ∅`; by compactness some finitely generated `Λ_M` already has `Θ₄ = ∅`" | **paraphrase**, "finitely generated" → "saturated"; harmless given an exhausting saturated chain (§V3 (iii)), but the brief's "verbatim from the plan's §M.1" is wrong for V3 |
| "`[Zhang2012]` Thm 1.8(i)" (brief, verified inputs) | `BIBLIOGRAPHY.md` row: Thm 1.8 is the ratio equality; "(i)" is the MIS-normal half | the step both derivations use is Thm 1.8's equality, not (i). Wording only |

### 2.1 Divergences on V1 (the deriver's S1a, claims 1–6 of its §4.3)

| # | kind | the deriver | this record | resolution |
|---|---|---|---|---|
| D1 | truth | `ρ_per ≤ h*(31) = 0.2499972548 < 1/4`, binding at 31, margin `2.7452·10⁻⁶` (`1.5617·10⁻⁴` in `λ_min`) | the same numbers, independently | **agree** — P-S1a's "two derivations without `[AmbrusEtAl2023]`" is now met |
| D2 | truth | "`ρ_per = max_𝔓 r_𝔓` exactly, `∈ [28/121, h*(31)]`"; "the true maximum is probably at 11" | the same bracket; attaining prime undecided (11 or 31) | **agree**. The deriver never says 31 attains the supremum ("attained in the bound at 31"). **The plan does** — §5.2 a4: "**The sup is attained** at 31 (`1/4 − 2.745·10⁻⁶`)" — which confuses the binding bound with the supremum: correction owed to the plan. Equality `ρ_per = max`: my route gives `≥` without Lemma R (a single-place reduction's image is a subgroup of `A_w` containing the image of `U`, whose Cayley graph has the ratio of `Cay(A_w, S_w)`), S1V-9 |
| D3 | route | step 2 (finite quotients live at stable places) via Lemma R (`R` = the localisation at the stable primes; `ρ_N` onto) or J07's Lemma C + C′ | via integrality at stable primes, full rank, prime inversion (`p`-divisibility off `T`) and the "component" trick (`R_(p)/p^{e+c}O_(p)` a subgroup of `A_p`); surjectivity never used | **third route**, weaker input: needs only `R ⊆ ⋂_{stable} O_𝔓` and `1/p ∈ R` off `T` (`[Fischer1990b]`), not `R = ⋂ O_𝔓` |
| D4 | route | step 3 (joint image) by the Cayley map `(1+is)/(1−is)` and weak approximation in `F` | rationality of the conic, weak approximation for `T`, and local constancy of `U → R/p^eR` (`R ∩ p^eR_(p) = p^eR`) | same substance |
| D5 | route (sharper) | Lemma P: new characters at level `m ≥ 2` have `\|λ\| ≤ 2p^{m−1}` (one-step fibres) | `\|λ\| ≤ 2p^{⌈m/2⌉}` (the half-level kernel) | both TRUE; mine sharper from `m = 3`; they coincide at `m = 2`, where both the deriver's 47-ramified control (94 = `2·47`) and mine at the ramified place of ℚ(√7) (14 = `2·7`) attain the bound |
| D6 | route | `λ_min` by interval arithmetic at 40 digits | at 80 digits, **and** an exact Sturm count on the integer polynomial `∏(x − λ(c))` (degree 30 at 31; 42 at 43; 46 at 47) | agree to every digit printed (`−10.666510494`, `−11.962230123`, `−12.846527722`, `−7.960687187`, …) |
| D7 | route | the tail from 67 by Weil (`h ≤ 0.194033`) | 67 exact (`0.1812822`), Weil from 107 | immaterial |
| D8 | extra | Theorem E at the ramified 47: levels 1–2 are homomorphically equivalent to `Γ₄₇`, so there the ratio is exactly `α(Γ₄₇)/47²` | not derived | not load-bearing; consistent (homomorphisms both ways between vertex-transitive graphs force equal ratios by the no-homomorphism lemma; level 2 is `𝔽_{47²}[ε]`, a ring containing its residue field) |
| D9 | re-checks | FS-66's certificates at 11 and 19 re-run CERTIFIED at `--m 4` (6.9 s; 8 min 59 s, the latter without `slot.py`, logged by the deriver) | consumed at row 75's grade, not re-run | none |
| D10 | scope | Corollary S1a′: no four-colouring of `Cay(R, U)` invariant under a finite-index `L`; "no proper colouring of ℚ(√47)² with four colours is periodic on any `R`-coset" | the same, plus what "periodic" does **not** cover (periodic colourings of a f.g. `Λ` with generators `U ∩ Λ`; invariant random colourings, since `ι ≥ ρ_per` only) | wording: the deriver's §2.3 item 4 has `ι ≥ ρ_per` too; no conflict |
| D11 | the stable list | 11, 19, 23, 31, 43, 47, 67, 107, … and "59 is not stable" (a slip in the plan's §1.2) | the same list, computed independently (`(47/59) = −1`) | agree; the plan's §1.2 correction stands |

### 2.2 Divergences on V2 (the deriver's S1b-i, S1b-ii)

| # | kind | the deriver | this record | resolution |
|---|---|---|---|---|
| E1 | truth | S1b-i, S1b-ii TRUE, "Amenability is used only in ⟹" | the same | agree |
| E2 | **necessity of amenability** | §2.4: "**not examined**: no non-amenable counterexample to S1b-i is exhibited. The plan's sketch (a free-group Cayley tree) does not work as stated" | an explicit counterexample: `F₂` acting on a 6-colourable graph whose proper 6-colourings map equivariantly onto `∂F₂` (§V2) | **the gap the deriver recorded is closed here**; the deriver's diagnosis of the plan's sketch agrees with mine (a connected bipartite graph has two 2-colourings, uniform measure invariant) |
| E3 | wording | S1b-ii stated for "`G` amenable and transitive" | transitivity is not used for `≥ 1/k` at a given `v₀` | agree in substance (the deriver's Q4 says transitivity only fixes `v₀`-independence) |
| E4 | route | Følner averaging of one colouring, weak* limit; symmetrise over `S_k`, read class 1 (`= 1/k` exactly) | invariant mean (Markov–Kakutani); pigeonhole a class `≥ 1/k` | same substance |
| E5 | out of my list | S1b-W, S1b-iii (`ι_G = 1/χ_{f,0} = 1/ρ = 1/χ_{gf,G,0}`), claim 8 (`ι < 1/4` iff a finite `H` has `α(H) < \|H\|/4`) | **not verified** here (outside V1–V3); read without finding an error | a second check is owed if a ledger row rests on S1b-iii |

### 2.3 Divergences on V3, and the verdict on S1e (non-blind)

- **V3 (i):** agree (deriver §3.1).
- **V3 (ii):** the deriver asserts nothing about non-four-colourability from `Θ₄ = ∅`; its S1c null ("no band character of order dividing 168, nor
  of order 11, 19, 23, 31, 43 or 47" on the ten survivors, §3.2) is correctly graded there as **GAP** per lattice. No divergence of truth; my
  GAP (no unit-distance witness for "four-colourable with `Θ₄ = ∅`") stands.
- **V3 (iii):** not in the deriver's record (it is the plan's §G line). No divergence. The deriver's S1c tested ten saturated lattices from a
  finite range (`M ≤ 2,520`, `24 | M`), which (iii) does not reach: (iii) is non-effective.
- **Deriver's claim 9 (S1c's exact enumeration):** outside my list; not re-run.

**S1e (the deriver's §4.2), non-blind verdicts:**
- **(i) TRUE with one hypothesis added.** As worded — "a linear identity … valid for every proper four-colouring `c` of a lattice graph `Γ` has
  `κ = 0`" — it fails when `Γ` has no proper four-colouring (then every `κ` is "valid"); the deriver's own next paragraph says "on a lattice
  that is not four-colourable an identity is vacuous". Add "`Γ` four-colourable" to the statement. Proof checked: averaging over `S₄` (colour
  permutations preserve properness) kills `κ`; `Σ_j A_j t_j = 0` with the `t_j` affinely independent forces `A_j` equal; conversely equal
  `A_j` give 0. It survives **matrix** coefficients too: with `Σ_x M_x g(x) = κ` and `S₄` acting on the tetrahedron by `O_σ`, averaging gives
  `κ = 0`, and `Σ_j B_j t_{π(j)} = 0` for every permutation `π` (`B_j` the class sums of the `M_x`) gives `(B_j − B_k)(t_a − t_b) = 0` for all
  `a ≠ b`, so all `B_j` are equal. So "linear" may be read in either sense.
- **(ii) TRUE.** Translate the gapped colouring so the gap sits at `x` with `a_x ≠ 0` (translation preserves properness on a Cayley graph);
  recolour `x` with its missing colour: still proper, and two class weights move by `∓a_x`. The conclusion is in fact "every four-colouring
  is gap-free at **every** vertex" (translation moves a gap anywhere), which is what the deriver's gloss "rigidity with no gap anywhere" says.
- **(iii) TRUE.** An equilateral triangle in `F² = E` has third vertex `x + ζ₆^{±1}(y − x)`, so `ζ₆ ∈ E`, i.e. `√−3 ∈ F(i)`, i.e. `√3 ∈ F`
  (for real `F`: `(a + bi)² = −3` forces `a = 0`, `b² = 3`); `√3 ∉ ℚ(√47)`. So no triangle of any side, and G75's `√3`-triple mechanism has
  nothing to act on.

## Stage 3 — not needed

Phase 1 did not stall on any claim; the fallback (lemma statements only) was not used.
