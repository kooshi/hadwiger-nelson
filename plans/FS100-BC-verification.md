# FS-100 stage 1 — the bundled blind check of the wanted-poster theorems (crunch job J48)

*de Bruijn (Opus 5.5), 2026-09-25, blind verifier. Brief: `data/crunch-2026-09-25/briefs/J48-FS100-stage1-blind-check.md`, with
`data/crunch-2026-09-25/briefs/STANDING-RULES.md` as part of it. Grades are `CLAUDE.md` § Notation's. **Fenced until stage 2 is committed,
and not opened:** the three poster records `plans/POROS-2026-09-25-wanted-poster-{47,59,167}.md`; the reports
`data/crunch-2026-09-25/reports/J37.md`, `J38.md`, `J39.md`, `J47.md`; the FS-100 stub `plans/STUB-measure-rigidity-three-fields.md`;
`data/crunch-2026-09-25/j47-record.md`; `plans/FS84-close-inventory.md`; `plans/CRUNCH-2026-09-25-post-close-inventory.md`; the crunch
index; `tools/crunch_j38_*`, `tools/crunch_j39_*`; and the bodies of commits whose subjects start "J37", "J38", "J39" or "J47" (subjects are
shown by the harness; no body was read). **Read before deriving:** `CLAUDE.md`, `DEBRUIJN.md`, `WORKFLOW.md` (in context), the brief and the
standing rules; `LEDGER.md` rows 88–98 (a grep of the whole ledger for "J37", "J38", "J39", "poster", "MR(F)", "FS-100", "J47" returned
nothing, so no fenced content reached me through it); `plans/FS84-SI-D-derivation.md` §§ Theorems, 1.2–1.3, 2.1, 4, 5 (J45's lemmas and
their proofs; permitted); `plans/R88-derivation.md` header, §1, §2, §3, §G; `plans/M3-derivation.md` header and §6 (SL, D3, MX, UNIF, TH,
J22-T8, RED) and the J22-T1/T2 lines; `plans/FS91-derivation.md` FS91-J07-3 and J07-4 (Lemmas C, C′). Of `plans/FS84-SI-V-verification.md`
(J46) only the first 30 lines were read — its header names a claim "W1 (T-J37-1)", and I stopped there so that J46's reading of a J37 claim
cannot reach BC-5.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| J48-SIk | J45's SI-1, SI-3, SI-4 at `k` colours (simplex embedding) and `S = ∅`: `∫_{R̂∖(T+A)} Re χ(u) dσ_μ = −(k/(k−1)) Σ_j E[p_j(0)p_j(u)] ≤ 0`; equality at every `u` ⟹ `min supp` is an `𝒜_∅`-measurable equivariant proper `k`-colouring | [hand; J45's route transcribed] | §2.1 L1 |
| J48-ROT | for `R ⋊ U`-invariant `μ`: `σ_μ` is `U`-invariant, `𝒜_∅` is rotation-invariant, the selection is rotation-equivariant; so the off-`(T+A)` integral is the same at every `u ∈ U` | [hand] | §2.1 L2 |
| J48-EXT | a stationary colouring of `R` with spectrum on `T + A` extends to a CP colouring of `(L⊗ℝ) × ∏_{stable} O_w` with edge set `∏ S¹ × ∏ T_w`; given Lemmas C, C′ | [hand] | §2.1 L3 |
| J48-PB | CP colourings pull back along continuous homomorphisms that map edges to edges; restricted to a countable subgraph they are a.s. proper | [hand; elementary] | §2.1 L4 |
| J48-MXcp | J21-MX for CP colourings, with a uniformly random threshold in `[λ*/(1+λ*), 1/k)` | [hand] | §2.1 L5 |
| J48-THK | `λ*_v ≤ max(2√q_v/(q_v+1), 2/(q_v+1))` at every stable place unramified in `L/F`; so `N_k(F)` is finite and `sup_{v thick} λ*_v < 1/(k−1)` | [hand; given Weil and FS86-LP / M3-J22-T8's two-point bound] | §2.1 L6 |
| J48-B⁺ | J45's B⁺ re-derived, on every S2 field: given T-C and FS38-D2-A, equality at every `u` ⟹ `μ` carried by Pull | [hand] | §2.1 L7 |
| J48-BC1 | BC-1 TRUE | [hand, one mind here; inputs listed in §2.2] | §2.2 |
| J48-N4 | `N₄(ℚ(√167)) = ∅`: every stable place of ℚ(√167) is 4-thick, 23 by `0.331695… < 1/3` (margin `1.6·10⁻³`) | [tools, rigorous interval arithmetic; plants fire] | §2.4, `tools/crunch_j48_places.py` |
| J48-BC3 | BC-3 TRUE, by BC-1 and J48-N4 and de Grey's graph (no T-C(A), no `m₁`); a second route through T-C(A)'s class form | [hand + tools] | §2.4 |
| J48-N4cor | for every totally real `F` with `N₄(F) = ∅`: MR(F) ⟹ `χ(F²) ≥ 5` | [hand; a corollary of BC-1] | §2.4 |
| J48-BC2, BC4–BC8 | BC-2, BC-4, BC-5, BC-6, BC-7, BC-8 TRUE (BC-4 (ii) with one unused hypothesis; BC-7 per `R`-coset) | [hand; given the inputs named per claim] | §2.3, §2.5–§2.9 |
| J48-C11 | at ℚ(√11), `k = 4`: C9's colouring is a CP four-colouring of `Y_{ℚ(√11),4}` — branch (A); whether (B) also holds is ¬MR(ℚ(√11)), undecided | [hand + tools exact] | §2.10, `tools/crunch_j48_controls.py` |
| J48-N11 | the stable places of ℚ(√11) below 200 and `N₄(ℚ(√11)) = {2, 7, 7′, 11, 19, 19′}` | [tools, rigorous; plants fire] | §2.10 |

## Stage 1 — SAVED (readings, quotation check, C0)

### 1.1 Quotation check (standing rule 5)

| # | quotation in the brief | source | result |
|---|---|---|---|
| Q1 | the fixed claim list BC-1 … BC-8, the definition of MR(F), PL(23, 43), the J39 notation paragraph, T-J38-2/T-J38-3 as "quoted in §2.3" | the FS-100 stub §6.1, §2.3, §5 (fenced) and J38/J39 (fenced) | **deferred to stage 3** — every source is fenced until the blind phase is committed. Judged here exactly as the brief quotes them. |
| Q2 | T-B1: "every point of Pull is isolated in `X₄(F)`" (R88 §G) | `plans/R88-derivation.md` §G | **matches in substance**; §G's full form adds "for each `p ∈ Pull` there is a finite `B ⊂ R` such that every `c ∈ X₄(F)` with `c|_B = p|_B` equals `p`", which is isolation in the product topology — the same statement. |
| Q3 | "J45 SP-oi" ("an SP witness, so MR(F) fails") | `plans/FS84-SI-D-derivation.md` Lemma SP-only-if | **matches**: SP-oi says an SP witness is a `U`-invariant `E`-null finite measure that is not a multiple of Haar. |
| Q4 | "J21-TH; §2.3" for `N₅(ℚ(√167))`; "merging … (J21-SL)" | `plans/M3-derivation.md` M3-J21-TH, M3-J21-SL | TH **matches**: its non-thick stable places are exactly "the two above 23 and the two above 43"; its other eight non-thick places are split. SL **matches** its corrected scope (σ-compact `G`, σ-finite `Y`). "§2.3" is a J39 section (fenced). |
| Q5 | "C9, row 94" (four-colourings of ℚ(√11)'s plane exist) | `LEDGER.md` row 94 | **matches**: C9's `⌊4θ⌋`, `θ = (2x+3y)/7` at a stable place above 7 plus an archimedean term below 1/28, proper and non-periodic. |
| Q6 | "T-C(A)'s class", "Theorem C's class S2" | `plans/R88-derivation.md` R88-TCA, R88-TC | **match**; both class forms are J28D's, one mind (R88-TC's and R88-TCA's grade lines). |
| Q7 | "Levitz–Mott" (BC-8) | `plans/R88-derivation.md` R88-J28V-7 (`[LevitzMott1972]` Thm 2.3) | **matches**: every non-zero ideal of `ℤ[U_F]` has finite index, every real number field. |

### 1.2 Readings — every term fixed

`F` is a real number field (totally real where a claim says so), `L = F(i)`, `U = {z ∈ L : z z̄ = 1}` (the unit vectors of `F² = L`),
`R = ℤ[U]` (the additive group generated by `U`, a ring because `U` is multiplicative). `F²`'s unit-distance graph is `Cay(L, U)`, a disjoint
union of copies of `Cay(R, U)`, so "`F²` is `k`-colourable" means `X_k(F) ≠ ∅`, `X_k(F)` the proper `k`-colourings of `Cay(R, U)` (compact).
`R̂ = Hom(R, S¹)`; `U` acts on it by `(u·χ)(r) = χ(ur)`; `T`, `A`, `Fin_S`, `E_S = T + A + Fin_S`, `E = ⋃_S E_S`, `𝒜_S` are J45's §1.2
(verbatim readings, R88's Notation); `S` ranges over finite sets of split places.

- **Stable place** of `F`: a finite place `v` whose prime of `L` above it is conjugation-fixed, i.e. `i ∉ F_v` (`L_w/F_v` inert or ramified).
  Split: `i ∈ F_v`.
- **The full-depth local plane** `G_v` at a stable `v`: `Cay(L_w, T_w)`, `T_w = {t ∈ L_w : t t̄ = 1}` ⊆ `O_w^×` (compact). It is a disjoint
  union of translates of `Cay(O_w, T_w)`, and a CP colouring of one gives one of the other (restriction; independent copies on the countably
  many cosets), so either reading gives the same statements. **Its compact local piece** is `(O_w, T_w, ν_w)`, `ν_w` Haar probability on
  `T_w`; **mixing constant** `λ*_v = sup_{ξ ≠ 0} |ν̂_w(ξ)|` over all non-trivial characters of `O_w`, every level (full depth).
- **`k`-thick** (J39's gloss, quoted in the brief): `λ*_v < 1/(k−1)`; `k ≥ 2`. `N_k(F)`: the stable places that are not `k`-thick. The
  claim calls it finite; I check that (it is, stage 2).
- **`UD(ℝ²)`**: `Cay(ℝ², S¹)`. Products `×` are categorical (an edge moves every coordinate along an edge). `Y_{F,k} = UD(ℝ²) ×
  ∏_{v ∈ N_k(F)} G_v`, one real factor however many real places `F` has.
- **CP `k`-colouring** of a Cayley graph `Cay(G, T)`, `G` a second-countable LCA group (J39's gloss): a random map `c : G → [k]` (a family of
  random variables on one probability space) whose law is invariant under every translation of `G`, with `P(c(x) ≠ c(y)) → 0` as `y → x`, and
  `P(c(x) = c(x + w)) = 0` for every `x ∈ G` and `w ∈ T`. No joint measurability is part of the definition. `χ_CP(ℝ²)`: the least `k` for
  which `UD(ℝ²)` carries one.
- **SP witness** (BC-1 (B), BC-6 (ii)): a finite positive `U`-invariant Borel measure `τ` on `R̂` with `τ(E) = 0` and `∫ Re χ(1) dτ < 0`.
  **MR(F)** as the brief quotes it. **Spectral measure** of a translation-invariant `μ` on `X_k(F)`: that of the simplex embedding
  `g(x) = e_{c(x)} ∈ ℝ^{k−1}`, `⟨e_i, e_j⟩ = (k/(k−1))δ_ij − 1/(k−1)` (J45's tetrahedral embedding at `k = 4`), `σ̂_μ(y) = E⟨g(0), g(y)⟩`.
- **Pull** (type (B)): `γ ∘ π₄`, `γ` a proper four-colouring of row 67's `P₄`; for another member of S2, the tight place's stabilised level
  (R88-TA's scope note). **Aff_F**, **T-B1 = Iso(F)**, **T-C**, **T-C(A)**, **S2**, **type (B)**: `plans/R88-derivation.md`, verbatim.
  **Row 88** (BC-6 (iii)): the question whether `F(R) ≠ 0` (equivalently, whether `(0, 4)` is forced); "row 88 is equivalent to T-B1" is read
  as "`F(R) ≠ 0` ⟺ T-B1".
- **"every four-colouring of `F²` is a pullback from a tight place"** (BC-7): on each `R`-coset `a + R`, `c(a + ·) ∈ Pull`; with no tight
  place (T-C(A)'s class) it says `X₄(F) = ∅`.
- **PL(23, 43)** as quoted: "every CP five-colouring of `UD(ℝ²) × G₂₃ × G₄₃` yields one of `UD(ℝ²)`" — read as: if the product carries a CP
  five-colouring, so does `UD(ℝ²)`.
- **"43's all-levels ratio"**: the measurable independence ratio of the full-depth compact piece at a place above 43 (the limit of the tower
  ratios `α(G_m)/43^{2m}`, G66).
- **BC-8's "averaged spectrum"**: `σ_μ` for an `R ⋊ U`-invariant `μ` (the spectral measure is then `U`-invariant).
- **BC-6's ellipsis**: the claim is judged as quoted; stage 2 says whether the elided text is needed.

### 1.3 C0 — probabilities per claim

*Honest timing: written after reading the permitted sources and one mental pass over each claim, before any written derivation (as J45's
C0 was). The mental pass had already found a route for BC-1, and noticed that BC-4 (ii)'s hypothesis on 43 does no visible work, so these are
not independent of that pass.*

| claim | TRUE | FALSE | GAP | ill-posed | note |
|---|---|---|---|---|---|
| BC-1 | 0.70 | 0.05 | 0.20 | 0.05 | route: SI at `k` colours on an `R ⋊ U`-invariant measure; equality gives a `(T+A)`-colouring, which extends to the completion; thick places removed by a CP form of J21-MX. Risks: the completion vs the stable places (Lemma C), a uniform bound on `λ*` over the thick places, the real places' merge |
| BC-2 | 0.80 | 0.05 | 0.10 | 0.05 | rests on J21-TH's stable half and on the definition of `N_k`; "merging (J21-SL)" is a measurable-colouring lemma, the CP merge is simpler |
| BC-3 | 0.80 | 0.05 | 0.15 | 0.00 | through BC-1 at `k = 4`; needs (A) to fail — by a count, or by `N₄ = ∅` if 23 is 4-thick |
| BC-4 | 0.80 | 0.05 | 0.10 | 0.05 | (i) a pullback along a real embedding; (ii) BC-1 + BC-2 + PL; the 43 hypothesis looks unused |
| BC-5 | 0.75 | 0.05 | 0.20 | 0.00 | the window gives a band, row 98 gives `T + A`, then T-C |
| BC-6 | 0.75 | 0.05 | 0.15 | 0.05 | (ii) needs B⁺ (equality ⟹ Pull) applied to a measure on `X′` |
| BC-7 | 0.70 | 0.05 | 0.15 | 0.10 | the class forms of T-C and T-C(A) are one mind; the per-coset reading |
| BC-8 | 0.90 | 0.03 | 0.05 | 0.02 | atoms of a finite invariant measure have finite orbits; finite-index stabiliser; Levitz–Mott |

### 1.4 Would-have-searched-here log (running)

- (none yet)

## Stage 2 — SAVED (the blind phase)

*Written before opening anything fenced. Inputs are named per claim; "given X" means X is used as its statement stands in its source.*

### 2.0 Verdicts

| claim | verdict | grade | the route in one line | inputs beyond J45's N1, N2, R-U, SP-oi |
|---|---|---|---|---|
| BC-1 | **TRUE** | [hand] | an `R ⋊ U`-invariant measure; SI at `k` colours: strict ⟹ (B), equality ⟹ a colouring with spectrum on `T + A`, which extends to the completion and loses its thick places by a CP mixing selection and its extra real places by the diagonal; (⟸) is a pullback along `R → Y` | Lemmas C, C′ (FS91-J07-3/4); weak approximation for the norm-one torus; J21-MX's mixing lemma; Weil and the two-point bound (FS86-LP, M3-J22-T8) |
| BC-2 | **TRUE** | [hand + tools] | the stable places of ℚ(√167) are the `p ≡ 3 (mod 4)` split in `F`, and 167; non-thick at 5 exactly 23, 23′, 43, 43′; CP merging is the diagonal and the projection (J21-SL is not needed and is about another format); split places are outside `N_k` by definition, and BC-1's proof is why that loses nothing | J21-TH at 167 (full depth); `tools/crunch_j48_places.py` |
| BC-3 | **TRUE** | [hand + tools] | `N₄(ℚ(√167)) = ∅` (23 is 4-thick by `1.6·10⁻³`), so (A) says `UD(ℝ²)` has a CP four-colouring, which de Grey's graph refutes; so (B) | BC-1; the kernel-checked `χ(de Grey) = 5`; the places tool |
| BC-4 | **TRUE** | [hand] | (i) pull back a CP five-colouring of `ℝ²` along a real embedding; (ii) MR + BC-1 + BC-2 + PL. **The hypothesis "43's all-levels ratio `< 1/5`" is not used** | BC-1, BC-2 |
| BC-5 | **TRUE** | [hand] | properness a.e. puts `θ(U)` in the closed set where every class's autocorrelation vanishes, which misses a neighbourhood of 0: `θ` is a band-`K` character for some `K`, so `θ ∈ T + A` (row 98); `t ↦ c_t` is an invariant measure with spectrum on `ℤθ ⊆ T + A`; T-C | row 98 (band rigidity at every band, field clause); R88-TC at `S = ∅` |
| BC-6 | **TRUE** | [hand] | (i) T-B1 makes the finite Pull open; T-C forbids such a measure on `X′`; (ii) an `R ⋊ U`-invariant measure on the compact `X′`: equality would put it on Pull (B⁺), so SI is strict and its off-`(T+A)` spectrum is an SP witness; (iii) MR kills (ii), so `X₄ = Pull`; the converse is R88-TA1. The ellipsis hides nothing the claim needs | R88-TC, R88-TA (i), R88-TA1, FS38-D2-A (via B⁺) |
| BC-7 | **TRUE** | [hand] | T-C(A)'s class: SI strict or T-C(A) contradicted, so MR ⟹ `X₄ = ∅`; S2: BC-6's argument with the tight place's own level | R88-TCA and R88-TC in their class forms (J28D, one mind); FS38-D2-A |
| BC-8 | **TRUE** | [hand] | an atom's `U`-orbit consists of atoms of equal mass, so it is finite; its stabiliser has finite index, contains some `u ≠ 1`, and the atom kills the non-zero ideal `(u − 1)R`, of finite index by Levitz–Mott | `[LevitzMott1972]` (R88-J28V-7) |

**Controls: all three run and behave** (§2.10): at seven colours BC-1's (⟸) gives `χ(F²) ≤ 7` for every `F`; at ℚ(√11), `k = 4`, branch (A) holds by C9's colouring, and (B) is exactly ¬MR(ℚ(√11)), which I cannot decide; BC-5 transposed to ℚ(√11) fails, at the T-C step.

### 2.1 Shared lemmas

**L1 (SI at `k` colours, `S = ∅`) [hand; J45's SI-1/3/4 transcribed].** Let `μ` be a translation-invariant probability on `X_k(F)`,
`g(x) = e_{c(x)}` the simplex embedding (`⟨e_i, e_j⟩ = (k/(k−1))δ_ij − 1/(k−1)`, `Σ e_j = 0`), `𝒜 = 𝒜_∅` (N2: the σ-algebra whose `L²` is the
spectral subspace of `T + A`), `p_j(x) = P(c(x) = j | 𝒜)`, `h(x) = Σ_j p_j(x) e_j = E[g(x) | 𝒜]`. For `u ∈ U`, `c(0) ≠ c(u)` a.s., so
`E⟨g(0), g(u)⟩ = −1/(k−1)`. Splitting each coordinate `f` of `g(0)` as `Πf + (1 − Π)f` with `Π` the spectral projection of `T + A`
(which commutes with the translations and equals `E[· | 𝒜]` by N2): `−1/(k−1) = E⟨h(0), h(u)⟩ + ∫_{R̂∖(T+A)} χ(u) dσ_μ`, and
`E⟨h(0), h(u)⟩ = (k/(k−1)) Σ_j E[p_j(0)p_j(u)] − 1/(k−1)`. So **`∫_{R̂∖(T+A)} χ(u) dσ_μ = −(k/(k−1)) Σ_j E[p_j(0)p_j(u)] ≤ 0`**, with equality
iff the supports `M(0) = supp p(0)` and `M(u)` are a.s. disjoint (and then, by stationarity, `M(x)`, `M(x+u)` for every `x`). If equality
holds for every `u ∈ U` — countably many edges — then a.s. every edge has disjoint supports, and `c′(x) = min M(x)` is proper, `𝒜`-measurable
and translation-equivariant (`p_j(x)(ω) = p_j(0)(T_x ω)`); `c(x) ∈ M(x)` a.s. (J45's SI-2). Each indicator `1{c′(0) = j}` lies in `L²(𝒜)`, so
the law of `c′` has spectral measure on `T + A`.

**L2 (rotations) [hand].** If `μ` is also invariant under the rotations `ρ_u c = c(u ·)`, `u ∈ U` (i.e. `R ⋊ U`-invariant), then `V_y ρ_u =
ρ_u V_{u⁻¹y}` gives `σ_{ρ_u f} = (u⁻¹)_* σ_f`: `σ_μ` is `U`-invariant, the spectral subspace of the `U`-invariant set `T + A` is `ρ_u`-invariant,
so `𝒜` is, `p_j(x) ∘ ρ_u = p_j(ux)`, and `c′` is rotation-equivariant; its law is `R ⋊ U`-invariant. And `∫_{R̂∖(T+A)} χ(u) dσ_μ =
∫_{R̂∖(T+A)} χ(1) dσ_μ` for every `u ∈ U`, since `R̂ ∖ (T + A)` is `U`-invariant. So for such `μ`: **either the integral is `< 0` at `u = 1`
(hence at every `u`), or `c′` exists.**

**L3 (extension to the completion) [hand; given Lemmas C and C′].** Let `c′` be stationary on `R` with spectrum on `T + A`. By N2,
`P(c′(0) ≠ c′(y)) → 0` as `y → 0` in `τ′_∅` (the topology of `R → R̂_prof × (L⊗ℝ)`), uniformly by stationarity. Put `Ĝ = R̂_prof × (L⊗ℝ)`, in
which `R` is dense (N1 (b)). Limits in probability along `r_n → x` define `c̃` on `Ĝ`: stationary under `Ĝ`, continuous in probability, and
`P(c̃(x) = c̃(x+w)) = 0` for every `x ∈ Ĝ` and every `w` in the closure `T̂` of `U` (the map `(a, b) ↦ P(c̃(a) = c̃(b))` is continuous and vanishes
on the dense set of `(r, r + u)`). **Lemma C** (FS91-J07-3, every real number field): `R/NR ≅ ∏_{p | N} R̄_p / N R̄_p`, `R̄_p` the closure of
`R` in `∏_{stable 𝔓 | p} Ô_𝔓`, open of finite index; so `R̂_prof = ∏_p R̄_p` and the profinite and stable topologies on `R` agree. **Lemma
C′** (FS91-J07-4, three derivations): `R̄_p` is the full product except possibly at `p = 2` when a stable dyadic place is ramified in `L/F`, and
inert stable dyadic places split off as full factors. So `Ĝ` is an open subgroup of finite index of `Ĝ⁺ = (L⊗ℝ) × ∏_{stable w} O_w`, the
index living in the ramified stable dyadic factors. **Weak approximation** for the norm-one torus (a rational curve) makes `U` dense in
`∏_{v ∈ S} T(F_v)` for every finite `S`, hence `T̂ = ∏_{real} S¹ × ∏_{stable} T_w` (and `T̂ ⊆ Ĝ`). Extend `c̃` from `Ĝ` to `Ĝ⁺` by independent
copies on the finitely many cosets, each read through a fixed section: stationarity under `Ĝ⁺` holds because translating by `t` permutes the
independent copies and shifts each by an element of `Ĝ`; edges `w ∈ T̂` stay inside cosets. Result: **a CP `k`-colouring of
`∏_{real} UD(ℝ²) × ∏_{stable w} Cay(O_w, T_w)`** (categorical product, `F` totally real so `L⊗ℝ = ℂⁿ`).

**L4 (pullbacks and restrictions) [hand; elementary].** If `φ : G₁ → G₂` is a continuous homomorphism of LCA groups with `φ(T₁) ⊆ T₂` and
`c` is a CP colouring of `Cay(G₂, T₂)`, then `c ∘ φ` is a CP colouring of `Cay(G₁, T₁)`: translation by `g` acts as translation by `φ(g)`;
continuity in probability passes through `φ`; every fixed edge maps to a fixed edge. Instances: the diagonal `ℝ² → (ℝ²)ⁿ` (merges real
places), the diagonal `G_v → G_v × G_{v′}` for an isomorphic pair (merges conjugate places), a projection (adds factors back), and
`R → Y`, `r ↦ (ι_∞(r), (ι_v(r))_v)` into any `Y` whose factors are the local planes at a real place and at stable places (`ι_v(U) ⊆ T_v`).
And restricted to a countable subgraph, a CP colouring is a.s. proper (countably many null events).

**L5 (the mixing selection for CP colourings) [hand; J21-MX's engine].** `K` compact abelian, `ν` a probability on `T_K`, `λ* =
sup_{ξ≠0} |ν̂(ξ)| < 1/(k−1)`, `X = Cay(G, T)` second-countable LCA. Let `c` be a CP `k`-colouring of `X × Cay(K, T_K)`; take a jointly
measurable version (continuity in probability; Doob–Cohn), and `ϑ` uniform on `[λ*/(1+λ*), 1/k)` — non-empty exactly because
`λ* < 1/(k−1)` — independent of `c`. Put `P_j(x) = {a ∈ K : c(x, a) = j}` and `φ(x) = min{j : m_K(P_j(x)) > ϑ}` (some `j` has
`m_K(P_j(x)) ≥ 1/k > ϑ`). *Proper at each fixed edge:* for `x ~ x′`, Fubini over `(ω, a, t) ∈ Ω × K × T_K` with `m_K ⊗ ν` gives, a.s.,
`∫∫ 1_{P_j(x)}(a) 1_{P_j(x′)}(a + t) dν(t) dm_K(a) = 0` for every `j`; the compact mixing lemma (Fourier and Parseval on `K`) gives
`m(P)m(Q) ≤ λ*√(m(P)(1−m(P))m(Q)(1−m(Q)))` for such `P, Q`, so `m(P), m(Q) > λ*/(1+λ*)` is impossible and `φ(x) ≠ φ(x′)` a.s.
*Stationary* under `G` (because `c` is under `G × K`). *Continuous in probability:* `P(φ(x) ≠ φ(y)) ≤ Σ_j E|m P_j(x) − m P_j(y)| / |I|`
(`I` the threshold interval) `≤ (k/|I|) P(c(x, 0) ≠ c(y, 0)) → 0`. So `X` carries a CP `k`-colouring. (J21-MX is the Borel and measurable
form; the random threshold is what the CP format needs, since a fixed threshold can make `φ` discontinuous in probability.)

**L6 (thickness is eventual) [hand; given Weil and the two-point bound].** At a stable `w` unramified in `L/F` with `F`-residue field `𝔽_q`:
level one, `|Σ_{t ∈ μ_{q+1}} ψ(Tr(at))| ≤ 2√q` (Weil, the norm-one torus a conic); level `m ≥ 2`, `|ν̂| ≤ 2/(q+1)` (the character is
linear on `T^{(⌈m/2⌉)}`, and its sum survives only on the `ζ ∈ μ_{q+1}` meeting a line through 0, at most two — FS86-LP, M3-J22-T8). So
`λ*_w ≤ max(2√q/(q+1), 2/(q+1)) → 0`; ramified stable places are finitely many. Hence **`N_k(F)` is finite for every `k ≥ 2`**, and the
thick places' product `K = ∏_{thick} O_w`, `ν = ⊗ Haar(T_w)`, has `λ*(K) = sup_{ξ≠0} ∏_{w ∈ supp ξ} |ν̂_w(ξ_w)| ≤ max_{thick} λ*_w <
1/(k−1)` (characters of a product are finitely supported; the sup over thick places is a maximum because `λ*_w → 0`).

**L7 (B⁺ on every S2 field) [hand; given T-C and FS38-D2-A].** Let `F` be in S2, `P_c` its tight place's stabilised level, Pull the
pullbacks `γ ∘ π_c`. If `μ` (translation-invariant on `X₄(F)`) has equality at every `u` in L1, then a.s. every edge has disjoint supports, so
**every** pointwise selection from `x ↦ M(x)` is a proper colouring. `c′ = min M` has spectrum on `T + A`, so by T-C its law is on Pull:
`c′ = γ ∘ π_c` a.s. If some `M(x₀)` held a second colour `b` with positive probability, change `c′` at `x₀` alone to `b`: still proper.
But `γ` is gap-free (tight ⟹ gap-free, FS38-D2-A), so some `z ~ π_c(x₀)` in `P_c` has `γ(z) = b`, and `U → S_{𝔓,c}` is onto (weak
approximation), so some `u` has `π_c(x₀ + u) = z` and `c′(x₀ + u) = b`: a conflict. So `M(x)` is a.s. a singleton, `c = c′` a.s., and
**`μ` is carried by Pull.**

### 2.2 BC-1 — TRUE [hand]

*(⟸)* A CP `k`-colouring `c` of `Y_{F,k}` restricted along the homomorphism `R → Y` of L4 is a.s. proper on the countable graph
`Cay(R, U)`; one realisation `k`-colours `Cay(R, U)`, hence `F²`. No hypothesis.

*(⟹)* Let `X_k(F) ≠ ∅`. It is compact, and `R ⋊ U` (countable, abelian-by-abelian, amenable) acts on it by `c ↦ c(u· + y)`; take an invariant
probability `μ`. By L2 either **(B)**: `τ := σ_μ|_{R̂∖(T+A)}` has `∫ Re χ(1) dτ < 0`; `τ` is finite, positive, `U`-invariant, and
`τ(E) = σ_μ(E ∖ (T + A)) = 0` by R-U — an SP witness; or **(A′)**: L1's `c′` exists, with law `R ⋊ U`-invariant and spectrum on `T + A`. In
case (A′), L3 extends `c′` to a CP `k`-colouring of `∏_{real} UD(ℝ²) × ∏_{stable} Cay(O_w, T_w)`; L5 with L6's `K` removes every thick
stable place at once; L4's diagonal merges the real places; independent copies on the countably many `O_w`-cosets of `L_w` pass from
`Cay(O_w, T_w)` to `G_v`. Result: a CP `k`-colouring of `Y_{F,k}` — **(A)**. The last sentence: MR(F) excludes (B) by SP-oi (an SP witness
has non-zero mean at `1`, which no multiple of Haar has), and (A) ⟹ colourable unconditionally.

**Notes.** (1) The split places are absent because L1's selection lives on `𝒜_∅`: once equality holds, nothing of the colouring reads a
split place; R-U is used only for `τ(E) = 0` in (B). (2) The `R ⋊ U`-invariance is what makes the dichotomy clean — L2's `u`-independence;
a merely translation-invariant `μ` could be strict at some `u` and not others. (3) Inputs: J45's N1, N2, R-U, SP-oi as stated; Lemmas C and
C′ (the only place the stable completions enter; without Lemma C the extension would live on `R̂_prof`, which might see more than the
stable places); weak approximation; Weil and the two-point bound; Doob–Cohn. (4) At `k = 2`, `1/(k−1) = 1`, and L6 still gives finiteness.

### 2.3 BC-2 — TRUE [hand + tools]

Stable places of `F = ℚ(√167)` (`tools/crunch_j48_places.py`, exact Legendre symbols to 200): for odd `p ∤ 167`, a place above an inert `p`
has residue field `𝔽_{p²} ∋ i`, and above `p ≡ 1 (4)` `i ∈ 𝔽_p`, so both split in `L/F`; the stable ones are the two places above each
`p ≡ 3 (4)` with `(167/p) = 1` — 23, 43, 59, 67, 71, 79, 83, 103, … — and the place above 167 (`i ∉ 𝔽₁₆₇`). At 2, `−167 ≡ 1 (mod 8)`, so
`ℚ₂(√167) = ℚ₂(i)`: split. **Thickness at `k = 5`** (`λ* < 1/4`), rigorous interval arithmetic for level one (`mpmath.iv`, 40 digits),
reproducing M3-J22-T2's 0.3317, 0.2719 and M3-J22-T1's `0.2486262833630`: `λ*₁(23) = 0.331695…`, `λ*₁(43) = 0.271869…` — not thick;
`λ*₁(59) = 0.248626…`, `λ*₁(67) = 0.221976…` — thick; `p ≥ 71` by Weil (`2√p/(p+1) < 1/4` for `p ≥ 60`); higher levels `≤ 2/(p+1)` (L6);
the place above 167 (ramified in `F`, so L6's unramified bound needs its own full-depth computation) by J21-TH, `λ* = 0.15160`. So
`N₅(F) = {23, 23′, 43, 43′}` exactly. **Merging:** the two places above 23 have isomorphic completions (`ℚ₂₃`, `L_w = ℚ₂₃(i)`), and the
diagonal `G₂₃ → G₂₃ × G₂₃′` and the projection back are L4 pullbacks, so `Y_{F,5}` carries a CP five-colouring iff `UD(ℝ²) × G₂₃ × G₄₃`
does. J21-SL (the claim's citation) is the measurable-window form and is not needed for CP colourings; citing it is harmless (its corrected
scope covers `ℚ₂₃(i)`). **"The split places 2, 3, 5, 7, 29, 61 do not appear"**: true by the definition of `N_k`; the content is BC-1's —
the (A) branch never reads a split place — which is where this differs from J21-RED's window reduction (there 2, 3, 5, 7, 29, 61 stay,
because a window colouring need not be rotation-invariant). J21-TH lists exactly these six split primes' places among its non-thick twelve;
they are non-thick and irrelevant here.

### 2.4 BC-3 — TRUE [hand + tools]; and a corollary

**`N₄(ℚ(√167)) = ∅`** (J48-N4): every stable place is 4-thick (`λ* < 1/3`): 23 by `0.331695 < 0.333333` (margin `1.64·10⁻³`, rigorous),
43, 59, 67 and the rest a fortiori, 167 by J21-TH, higher levels `≤ 1/12`. So `Y_{ℚ(√167),4} = UD(ℝ²)`. **(A) fails:** a CP four-colouring
of `UD(ℝ²)`, restricted to de Grey's 1581-vertex unit-distance graph (finitely many fixed edges), would four-colour it a.s. (L4);
`χ = 5` there is kernel-checked (rung B). So BC-1 at `k = 4` leaves (B): **a four-colouring of ℚ(√167)'s plane yields an SP witness**, and
MR(ℚ(√167)) ⟹ `χ(ℚ(√167)²) ≥ 5`. **A second route** (J45's SP-Cor, transposed): every stable place of ℚ(√167) has all-levels ratio `< 1/4`
(23 by FS-66's certificate or Hoffman at every level from `λ_min`; the rest by Hoffman), the real place `m₁ < 1/4`, so ℚ(√167) is in T-C(A)'s
class (J28D's class form, one mind); then L1–L2 with T-C(A) give strictness. The first route uses neither T-C(A) nor `[AmbrusEtAl2023]`;
its one numerical input is the 23 margin.

**Corollary (J48-N4cor) [hand].** For every totally real `F` with `N₄(F) = ∅` — every stable place 4-thick — MR(F) ⟹ `χ(F²) ≥ 5`, by the
same two lines. (With `N₄(F) ≠ ∅` the analogous statement needs a CP count on `UD(ℝ²) × ∏ G_v`.)

### 2.5 BC-4 — TRUE [hand]

*(i)* Contrapositive: if `UD(ℝ²)` carries a CP five-colouring `c`, then `c ∘ ι_∞` (L4, `ι_∞` a real embedding of `F² → ℝ²`, which maps unit
vectors to unit vectors) is a.s. proper on `Cay(R, U)`; so `χ(F²) ≤ 5` — for every real field `F`, ℚ(√167) among them. Unconditional.
*(ii)* Contrapositive: let `χ(ℚ(√167)²) ≤ 5`. MR and BC-1 (`k = 5`) give a CP five-colouring of `Y_{F,5}`; BC-2 merges it to one of
`UD(ℝ²) × G₂₃ × G₄₃`; PL(23, 43) gives one of `UD(ℝ²)`; so `χ_CP(ℝ²) ≤ 5`. **The hypothesis "43's all-levels ratio is `< 1/5`" is not used**
by this route — the implication holds without it (and PL(23, 43) is the only place a statement about 43 could enter). Wording divergence to
compare at stage 3: either J39's route needs it for a step I do not take, or it is a leftover. *Remark:* with (i), (ii) says: given MR,
PL(23, 43), `χ(ℚ(√167)²) ≥ 6 ⟺ χ_CP(ℝ²) ≥ 6`. And `χ_CP(ℝ²) ≥ χ(ℝ²) ≥ 5` (L4 on finite subgraphs, de Bruijn–Erdős), `≤ 7` (§2.10).

### 2.6 BC-5 — TRUE [hand]

Let `A_j = W⁻¹(j)` and `f_j(s) = m(A_j ∩ (A_j + s))`, continuous on `ℝ/ℤ` with `f_j(0) = m(A_j)`. Properness of `c_t` at the edge `(0, u)` for
a.e. `t` is `Σ_j f_j(θ(u)) = 0`. Some `j` has `m(A_j) ≥ 1/4`, so `f_j > 0` on a neighbourhood `(−δ, δ)` of 0: **`θ(U) ⊆ {‖s‖ ≥ δ}`**, i.e.
`θ ∈ Θ_K(R_F)` for every integer `K ≥ 1/δ` (`B_K = {‖z‖ ≥ 1/K}`, FS-91's Notation). Row 98's field clause (every `F ⊆ ℝ`, every `k ≥ 2`):
`θ ∈ T + A`. Now `t ↦ c_t`, `t` uniform, is a translation-invariant probability on `X₄(F)` (translation by `y` is `t ↦ t + θ(y)`), with
`σ̂(y) = ∫⟨G(t), G(t + θ(y))⟩dt = Σ_n |Ĝ(n)|² e(nθ(y))` for `G = e ∘ W`: spectrum on `{nθ} ⊆ T + A`. R88-TC at `S = ∅` (over the three
type-(B) fields, two derivations): carried by Pull — `c_t ∈ Pull` for a.e. `t`. Note the claim's `W` need not be an interval partition;
the band comes from the autocorrelations alone, which is why no `⌊4·⌋` shape is needed.

### 2.7 BC-6 — TRUE [hand]

*(i)* Pull is finite and `Aff_F`-invariant (R88-TA (i)); T-B1 makes each of its points isolated, so Pull is open in `X₄` and `X′` is closed,
and `Aff_F`-invariant. A translation-invariant probability on `X′` with spectrum on some `T + A + Fin_S` is one on `X₄`, so T-C puts it on
Pull, which it does not charge: none exists. (T-B1 is used only for closedness.)
*(ii)* `X′ ≠ ∅` is compact and `R ⋊ U`-invariant (`R ⋊ U ⊆ Aff_F`); take an invariant `μ` on it. If L1's equality held, L7 (B⁺) would put
`μ` on Pull, contradicting `μ(X′) = 1`; so by L2 the inequality is strict and `τ = σ_μ|_{R̂∖(T+A)}` is an SP witness (`τ(E) = 0` by R-U).
By SP-oi it is a `U`-invariant `E`-null measure that is not a multiple of Haar.
*(iii)* MR ∧ T-B1: (ii) and SP-oi force `X′ = ∅`, so `X₄ = Pull`, and every `δ ∈ R ∩ 𝔓⁴ = P(R) ≠ 0` is forced: `F(R) ≠ 0`. Conversely
`F(R) ≠ 0` ⟹ T-B1 with no hypothesis (R88-TA1: `F(R) ≠ 0` makes `X₄ = Pull` finite). So given MR, `F(R) ≠ 0 ⟺ T-B1`. **The ellipsis**:
the quoted text states both ends; what could sit in between ("so `X′ = ∅`, `X₄ = Pull`", and the converse's citation) is supplied above,
and nothing the claim needs is missing.

### 2.8 BC-7 — TRUE [hand; given the class forms]

*T-C(A)'s class* (no tight place; "pullback from a tight place" then means `X₄ = ∅`): if `X₄ ≠ ∅`, an `R ⋊ U`-invariant `μ`; equality would
give L1's `c′` with spectrum on `T + A`, excluded by T-C(A); so strict, an SP witness, excluded by MR. *S2*: BC-6's argument verbatim with
the tight place's stabilised level `P_c` in place of `P₄` — what it uses is: Pull finite and `R ⋊ U`-invariant (translation and rotation act on
`P_c` by automorphisms, so this needs no part of row 88's frame), T-B1 = Iso(F), T-C (class form), L7 (FS38-D2-A at the tight place), R-U,
SP-oi. Read per `R`-coset (§1.2): on each coset `a + R` of `F²`, `c(a + ·) ∈ Pull`. **Grade note:** T-C and T-C(A) outside ℚ(√47) and the
three type-(B) fields are J28D's class forms, one mind each (R88 grade lines); BC-7 inherits that.

### 2.9 BC-8 — TRUE [hand]

`σ_μ` is a finite `U`-invariant measure (L2). If `σ_μ({χ₀}) = a > 0`, every `u·χ₀` is an atom of mass `a`, so the orbit is finite and the
stabiliser `V` has finite index in `U`. `U` is infinite (`(3/5, 4/5) ∈ U` generates an infinite cyclic group), so `V ∋ u ≠ 1`, and
`χ₀((u − 1)r) = 1` for every `r`: `χ₀` kills the non-zero ideal `(u − 1)R`, of finite index by `[LevitzMott1972]` (R88-J28V-7). So `χ₀` has
finite order: every atom is torsion, `T ⊆ E`, and `σ_μ|_{R̂∖E}` is atomless. (The claim's parenthesis names exactly this route.)

### 2.10 The three controls

1. **Seven colours** (`tools/crunch_j48_controls.py` C7, exact): hexagons of side `9/20` in the index-7 pattern are proper at every unit
   edge (diameter `9/10 < 1`; same-colour separation `√21·s − 2s > 1` since `21 > 1444/81`); a uniformly random translation makes it CP. By
   L4 (projection `Y → UD(ℝ²)`), `Y_{F,7}` carries a CP seven-colouring for every `F`, and BC-1's (⟸) gives `χ(F²) ≤ 7`. **Behaves.** (It
   also gives `χ_CP(ℝ²) ≤ 7`.)
2. **ℚ(√11), `k = 4`** (`tools/crunch_j48_places.py`, `crunch_j48_controls.py` C9): the stable places below 200 are 2 (`−11 ≢ 1 (mod 8)`),
   the two above 7, 11, the two above 19, 43, 79, 83, …; level one gives `λ*₁ = 0.5617, 0.4764, 0.3805` at 7, 11, 19 (`≥ 1/3`), 0.2719 at 43;
   the dyadic place is `U₂ = K₄` with `λ* = 1/3`, not `< 1/3`. So `N₄ = {2, 7, 7′, 11, 19, 19′}`. C9's `c̃(y) = ⌊4(θ₇(y₇) + ℓ(y_∞) + s)⌋`,
   `s` uniform, with `θ₇` the continuous character `z ↦ {(2x + 3y)/7}₇` of `L₇ = ℚ₇(i)` and `|ℓ| ≤ 1/28` on unit vectors, is a CP four-colouring
   of `Y_{ℚ(√11),4}` (exact: the eight circle points mod 7 give `(2a+3b)/7 ∈ [2/7, 5/7]`, the band `[1/4, 3/4]`, and `⌊4·⌋` separates any
   phase difference in `[1/4, 3/4]`). **So branch (A) holds.** Branch (B) is, by SP-if and SP-oi, exactly ¬MR(ℚ(√11)): **undecided here.**
   (The `R ⋊ U`-orbit closure of C9's colouring has spectrum on the `U`-orbit multiples of `θ`, all in `T + A`, so L1 is at equality for it
   — consistent with (A).)
3. **BC-5 over ℚ(√11)**: `c_t = ⌊4(θ + t)⌋` is proper for every `t` and non-periodic, so not a pullback: the transposed statement fails, as it
   must. In my route the failing step is T-C (ℚ(√11)'s stable 7 has ratio `≥ 2/7 > 1/4`, so it is outside S2), while the band step and row 98
   hold there (`θ = θ₇ + ℓ ∈ T + A`). **Behaves.**

**Tools and plants.** `tools/crunch_j48_places.py` (4 s): plants `drop-point`, `wrong-trace`, `dyadic-167` each fire at their own check. A
first `wrong-trace` (dropping the factor 2 of the trace) **could not fire** — `a ↦ 2a` permutes the non-zero `a`, so the maximum is unchanged;
replaced by dropping the `βy` term, which fires; the docstring keeps the record. `tools/crunch_j48_controls.py` (< 1 s): plants `coeff-11`,
`wide-arch`, `big-hex` each fire at their own check.

### 2.11 Would-have-searched-here log

- BC-3: would have searched for a four-colouring pattern of a finite piece of ℚ(√167)'s plane to test (A). Instead: `N₄ = ∅` by exact
  mixing constants, which reduces (A) to `UD(ℝ²)` and de Grey's certified graph.
- BC-1 control at ℚ(√11): would have searched for an SP witness (a non-Haar `U`-invariant `E`-null measure) to decide (B). Instead: recorded
  (B) as ¬MR(ℚ(√11)), undecided.
- The places tool enumerates `a` over all of `𝔽_{p²}^×` for `p ≤ 43`: a complete exact enumeration of a set whose extent the derivation
  fixed (norm classes); in, by rule 3's edge clause.

## Stage 3 — SAVED (the comparison)

*Opened after stage 2's commit (e848ad8c): the FS-100 stub §2.3 and §6.1; the poster records — J39 §3.1–§3.3, J38 §3.4, §3.5, §4.7, J37
§3.3 (b) (the atom paragraph) and its theorems row; the reports J37, J38, J39, J47; a grep of J47's record. No commit body was read.*

### 3.1 Quotation check, completed

The brief's eight claim cells are **byte-identical** to the stub's §6.1 cells (a script compared them cell by cell). The stub's BC-1…BC-8
cells agree verbatim with the poster records' statements (J39 §3.2 and §3.3 (e)–(f), J38 §3.4, §3.5, §4.7, J37's theorems table). The J39
notation paragraph and MR(F) match (MR's wording is J38 §3.5 (iii)'s). **The ellipsis in T-J38-2 (iii)** hides: "where **MR(F)** is … (J45:
MR(F) ⟺ no SP witness). Since `F(R) ≠ 0` gives `X₄ = Pull`, finite, hence T-B1:" — the converse half, which §2.7 supplied from R88-TA1.
Nothing the claim needs was hidden.

### 3.2 Divergence table

| claim | truth (mine / poster) | route | wording | independent? |
|---|---|---|---|---|
| BC-1 | TRUE / TRUE | the same seven steps (SI at `k`, `S = ∅`, R-U, extension, random-threshold MX, diagonal merge; (⟸) by `R → Y`). **One substantive divergence, at J39's step 5:** J39 asserts "`R̂_prof = ∏_{stable w} O_{L_w}`" with no input. It needs **Lemma C** (torsion characters are stable-continuous) and is **false as stated wherever Lemma C′'s exception occurs** — a ramified stable dyadic place with `R̄₂` a proper finite-index subring (J10-T6 names ℚ(√5), ℚ(√17), ℚ(α)); ℚ(√5) is totally real. The theorem survives: `Ĝ` is then an open finite-index subgroup of the product and independent copies on its cosets extend the colouring (my L3). The stub's worry — "if the closure of `U` … is a proper subgroup of the product of circles" — does not arise (weak approximation at every finite set gives the full product of circles); the proper subgroup that can arise is the closure of `R`, the vertex group. Minor: J39's continuity reason "θ′ a.s. misses their values" is not the reason; the bounded density of `θ′` against `E|m_j(x) − m_j(x′)| → 0` is (J39 states that inequality too). J39 extends by Mackey's point realisation, I by limits in probability. | J39's "Weil makes all but finitely many small" needs the two-point bound at higher levels as well (J39's P1 has it) | blind, **same route**; the Lemma C/C′ repair is mine alone |
| BC-2 | TRUE / TRUE | same (thickness table; CP merge). My interval-arithmetic tool reproduces J39's `0.331695, 0.271869, 0.248626` from independent code | "merging (J21-SL)": the CP merge is the diagonal homomorphism, elementary; SL (a measurable-window lemma) is not needed — harmless | blind, independent tool, same route |
| BC-3 | TRUE / TRUE | **different last step.** Both get `N₄(ℚ(√167)) = ∅`, so `Y_{F,4} = UD(ℝ²)`. J39 refutes a CP four-colouring of `UD(ℝ²)` by `m₁ ≤ 0.2470` (`[AmbrusEtAl2023]`, external, computer-assisted); I refute it by de Grey's 1581-vertex graph (kernel-checked in this repository) through L4 | the stub's named check "does `m₁` apply to a CP class": **yes** — a jointly measurable version's class is a.s. edge-null, a.e. equal to a 1-avoiding set (R88-TC-reg), and reverse Fatou gives upper density `≥ 1/4` with positive probability; so J39's route closes too | blind; **independent last step**, with the weaker input |
| BC-4 | TRUE / TRUE | same ((i) a pullback; (ii) MR, BC-1, BC-2, PL) | **the hypothesis "43's all-levels ratio is `< 1/5`" is used by neither proof** — J39's own proof of (ii) never invokes it. The stub's named check "(ii) needs that the 43 hypothesis makes `G₄₃` refuse five in the CP sense" is not borne out: J39 §3.3 (d) J2 shows its role is motivational (with it, PL is D2(a) with its ratio hypothesis met). Correction owed: drop it from T-J39-5 (ii), or state it as context. The corrected statement is stronger: given MR(ℚ(√167)) and PL(23, 43), `χ(ℚ(√167)²) ≥ 6 ⟺ χ_CP(ℝ²) ≥ 6` | blind, same route |
| BC-5 | TRUE / TRUE | same (autocorrelation / Steinhaus → band → row 98 → Theorem C at `S = ∅`) | the stub's named check "from a measure carried by Pull to `c_t ∈ Pull` a.e.": the measure is the push-forward of Lebesgue measure under `t ↦ c_t`, and Pull is finite, so "carried" is "a.e. `t`" | blind, same route |
| BC-6 | TRUE / TRUE | same (clopen Pull; T-C on `X′`; an `R ⋊ U`-invariant measure on `X′`, B⁺, R-U, SP-oi; the converse by R88-TA1) | the stub's named check "B⁺ applied to a non-ergodic `ν`": **B⁺ needs no ergodicity** — my L7 and J45's statement both hold for every translation-invariant `μ` | blind, same route |
| BC-7 | TRUE / TRUE | same (J45-SP-Cor on T-C(A)'s class, T-J38-2's argument on S2) | "every four-colouring of `F²` is a pullback" is per `R`-coset of `F²` (§1.2); J38 does not say so. Both inherit the one-mind class forms of T-C and T-C(A) (R88 grade lines), which the poster's "[hand, one mind]" does not flag | blind, same route |
| BC-8 | TRUE / TRUE | identical (finite orbit, finite-index stabiliser, `(u − 1)R`, Levitz–Mott) | J37's "Its stabiliser `u ≠ 1`" skips why the stabiliser contains some `u ≠ 1`: `U` is infinite and the stabiliser has finite index | blind, same route |

**Summary.** Eight TRUE against eight TRUE: no difference of truth. Routes coincide everywhere except BC-3's last step (independent, with a
kernel-checked input in place of an external computer-assisted one). The confirmation is therefore **route-dependent** for BC-1, BC-2,
BC-4 to BC-8: both minds composed the same permitted lemmas (J45's SI, R-U, SP; R88's T-C, T-C(A); row 98; J21-MX) the same way, and a flaw
common to those inputs would be common to both. Found by the blind route and absent from the posters: the Lemma C/C′ input at BC-1's step 5
(and its false-as-stated equality), the redundancy of BC-4 (ii)'s 43 hypothesis, and the ergodicity worry's dissolution.

### 3.3 C0 scored

Every modal outcome was met (all TRUE). Mean probability on the realised outcome: `(0.70 + 0.80 + 0.80 + 0.80 + 0.75 + 0.75 + 0.70 + 0.90)/8
= 0.775`. C0 followed one mental pass, so it partly measures that pass (G21); the GAP mass it carried on BC-1 (0.20) was placed on exactly the
step where the divergence sits (the completion vs the stable places), which the pass had flagged.

### 3.4 Corrections owed (proposed; the front-page lane decides)

1. **T-J39-3, step 5** (J39 §3.2): replace "`R̂_prof = ∏_{stable w} O_{L_w}`" by "by Lemma C (FS91-J07-3) the profinite and stable
   topologies on `R` agree, and by Lemma C′ (FS91-J07-4) `Ĝ = (L⊗ℝ) × R̂_prof` is an open subgroup of finite index of
   `(L⊗ℝ) × ∏_{stable w} O_{L_w}`, equal to it unless a stable dyadic place is ramified in `L/F` with `R̄₂` proper (e.g. ℚ(√5)); in that
   case extend by independent copies on the finitely many cosets." Add Lemmas C, C′ to T-J39-3's inputs. The theorem is unchanged.
2. **T-J39-5 (ii)**: drop "43's all-levels ratio is `< 1/5`" (unused), or move it to a remark on PL's provability.
3. **T-J39-4**: record the de Grey route beside the `m₁` route — the lower bound "MR(ℚ(√167)) ⟹ `χ ≥ 5`" then rests on no external
   computer-assisted input; its only numerical input is the 23 margin `1.6·10⁻³` (now computed twice, independently, the second time in
   rigorous interval arithmetic).
4. **T-J38-3**: say "on each `R`-coset of `F²`", and flag that outside ℚ(√47) and type (B) it rests on the one-mind class forms of T-C and
   T-C(A).
5. **The stub's §6.1 named checks** for BC-4 and BC-6 can be closed as above (the 43 hypothesis is idle; B⁺ needs no ergodicity).

### 3.5 Would-have-searched-here log (stage 3)

- None.

## Stage 4 — SAVED (the report)

The report is `data/crunch-2026-09-25/reports/J48.md`, committed with this stage and sent to the owner by SendMessage.
