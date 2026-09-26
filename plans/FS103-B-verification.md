# FS103-B — blind verification of the fractional shadow (FS103-F's claims)

*Job FS103-B, Opus 5.5, 2026-09-26. Verifier ("Coxeter" seat). Blind to `plans/FS103-F-fractional-shadow.md` and every fenced file until
stage 3 is committed. Claims: `data/fs103/claims-f2.md` (statements only). Brief: `data/fs103/briefs/B103-fractional-blind-check.md`.*

## Theorems this phase proved

*(filled per stage; grades per `CLAUDE.md` § Notation; "one mind" = this job, blind)*

| id | statement (one line) | grade | where |
|---|---|---|---|
| B-D3 | for an `R ⋊ U`-invariant random independent set, with `g = E[1_I \| 𝒜_∅]`: `E[g(0)g(u)] = −∫_{R̂∖E} Re χ(1) dσ` for every `u ∈ U` (per class; R-U used) | [hand] | §2.1 D3 |
| B-D4 | either `σ\|_{R̂∖E}` is an SP witness, or `J = {g > 0}` is an `𝒜_∅`-measurable invariant independent set of density `≥ δ` | [hand] | §2.1 D4–D5 |
| B-D6 | a `{0,1}`-process on `R` with spectrum on `T + A` extends to a `G_∅`-stationary CP process proper at every fixed edge of `T_∅`; `T_∅` is the full product (the norm-one torus of `F(i)/F` is rational) | [hand] | §2.1 D6 |
| B-FRAC | FS103-F-FRAC: given MR(F), `R_F = O′`: every `R ⋊ U`-invariant random independent set has density `≤ ρ(F)`; unconditionally `> ρ(F)` ⟹ SP witness | [hand; one mind blind + held C14.1–C14.3, J45-N1/N2, R-U] | §2.1 |
| B-AMEN | `α₁(F²) = α_inv(F²)` for every real number field (no MR); `α_inv(F²) ≥ ρ(F)` (pullbacks; no MR) | [hand] | §2.1 "The equalities" |
| B-TJ | FS103-F-TJ, both clauses, with `ϑ = λ*/(1 + λ*)` | [hand] | §2.2 |
| B-ROUND | FS103-F-ROUND: the route gives `χ ≥ ⌈1/ρ⌉ ≤ 5`, `1/ρ ≤ 4.35987…` | [hand] | §2.3 |
| B-635 | ℚ(√635087): `635087` prime, `≡ 15 (mod 16)` (dyadic place not stable); stable places below 2000 = 159, smallest `q = 103`, ramified 635087 stable (`L/F` inert); every stable place has `r_v ≤ 0.163300 < 0.22936` | [tools exact (PARI), two routes agreeing; plants fire] | §3.1, `tools/fs103_b_places.py`, `data/fs103/fs103-b/places*.out` |
| B-31 | level-one Hoffman ratio of `Γ₃₁` = `0.249997254763781` (`1/4 − 2.74524·10⁻⁶`), `1/ratio = 4.0000439243` | [tools, 50-digit float, margin `10⁻¹¹`] | §3.3, same tool |
| B-DV | FS103-F-DV: given MR(ℚ(√635087)), `α₁(ℝ²) = m₁(ℝ²)`, `f(n)/n → m₁(ℝ²)`, `χ_f,0(ℝ²) = χ_f(ℝ²) = 1/m₁(ℝ²)` | [hand + tools exact] | §3.2 |
| B-CHIF | `χ_f(ℝ²) ≤ 1/m₁(ℝ²)` (whole-plane, finitely many sets): open regularisation of a 1-avoiding set, then a finite grid of translates | [hand; one mind; likely folklore, MRVZ state only `1/δ_Croft`] | §3.2 (v) |
| B-TF | FS103-F-TF, given MR(ℚ(√635087)) | [hand] | §3.4 |
| B-47 | FS103-F-47, given MR(ℚ(√47)) | [hand + tools] | §3.3 |

## Stage 1 — SAVED (quotation check; controls written before deriving)

### 1.1 Quotation check (standing rule 5)

| quoted text (where it appears) | source | result |
|---|---|---|
| claims-f2 §"Definitions" and §"The claims" (FS103-F §2.3 and its theorem table) | `plans/FS103-F-fractional-shadow.md` — **fenced** | not checkable until stage 4; checked there |
| "MR(F): `LEDGER.md` row 120, verbatim there" (claims-f2 Known inputs) | row 120; `data/fs103/claims.md` D-MR | matches word for word |
| D-SP "a finite positive `U`-invariant Borel measure `τ` on `R̂` with `τ(E) = 0` and `∫ Re χ(1) dτ < 0`" | `plans/FS100-BC-verification.md` l.72 | matches |
| "`m₁(ℝ²) ≤ 0.246989` (`[AmbrusEtAl2023]` Thm 1; row 92)" | row 92 | matches ("its certificate re-checked here … `m₁(ℝ²) ≤ 0.246989`") |
| "Croft's `m₁ ≥ 0.22936` (`BIBLIOGRAPHY.md` `[Croft1967]`)" | BIBLIOGRAPHY l.706; `[DuczVarga2026]` §2.1 "δCroft = 0.22936 . . ."; `[MatolcsiEtAl2025]` (13) "1/δCroft = 4.35987..." | matches; Croft's paper itself unheld, unread (the value is by statement, via two held papers) |
| brief: "`χ_f(K²) = 4` (G60)" | `CLAUDE.md` G60 "instance: χ_f(K²) = 4" | matches |
| brief: "the first clause of a conjecture published in 2026 (`[DuczVarga2026]`, Conjecture 1)" | `[DuczVarga2026]` §2.1, p. 3 (held copy `library/pdf/arXiv-2606.28157-ducz-varga-…pdf`): "**Conjecture 1.** f (n)/n = m1 (R2 ) + o(1) / and in particular that m1 (R2 ) = δCroft ." | matches; the conjecture has two clauses joined by "and in particular" (the second does not follow from the first); "first clause" = `f(n)/n = m₁(ℝ²) + o(1)`. `f(n)` is their §1: "the minimum possible independence number of a unit-distance graph arising from n points in the plane" |
| claims-f2 FS103-F-DV "`χ_f,0(ℝ²) = χ_f(ℝ²)`" | `[MatolcsiEtAl2025]` §2 p. 4–5: "χf,0 (R2 ) := sup{χf (G) : G ⊆ R2 , G is finite}. It is clear that χf,0 (R2 ) ≤ χf (R2 ), but it is not known whether equality holds"; `χ_f(ℝ²)` there = inf over fractional colourings of the whole plane | the notation is MRVZ's (not DV's; DV do not use `χ_f,0`); the claim's middle equality is therefore a claim about the *whole-plane* number, checked at stage 3 |
| claims-f2's `α₁(F²)` | MRVZ p. 5: "α1 (R2 ) = inf{α1 (G) : G ⊆ R2 , G is finite}" | the claim's definition is MRVZ's with `F²` for `ℝ²` |
| "31's `1/4 − 2.745·10⁻⁶`" (claims-f2 FS103-F-47) | row 117 "the Hoffman table (31's `1/4 − 2.745·10⁻⁶` the largest)"; G54 | matches; re-computed exactly at stage 3 |
| "X25B-L1" (claims-f2 definition of `r_v`) | `plans/FS100-X25B-derivation.md` l.72 "X25B-L1 (the profinite reduction)" | exists; its statement is the profinite reduction, not the Weil/level bound `X26B-L1` that row 123 quotes (two different lemmas with near-identical names — noted, not an error) |

### 1.2 Controls, written before deriving (each: what must come out; what a wrong-reason pass looks like)

- **K = ℚ(√3, √11)** (G60: `χ_f(K²) = 4`). K's two dyadic places have `K_v = ℚ₂(√3) ∌ i`, stable, `L_w/K_v` unramified (inert), target
  `U₂ = Cay(𝔽₄, μ₃) = K₄`, ratio `1/4` at every level (the 2-adic tower is tight, row 67). So any correct FRAC must give `ρ(K) = 1/4`, attained by
  the dyadic pullback, **not** by `m₁`. *Wrong-reason pass:* a chain that bounds the density by `m₁ < 1/4` (dropping the tight place), or whose
  product step needs every factor `< 1/4` — it would "prove" `χ_f(K²) > 4`, contradicting Theorem B. *Where the chain must stop:* nowhere; it must
  reproduce `1/4` exactly.
- **ℚ(√3).** Triangles give `α_inv ≤ 1/3`; the three-colouring gives `≥ 1/3`. The place above 3 (ramified, residue `𝔽₃`, `Γ₃`, ratio `3/9`) must
  give `ρ = 1/3`. *Wrong-reason pass:* `ρ` computed from `m₁` or from the dyadic `1/4`.
- **ℚ(√11).** Stable 7 (`(11/7) = 1`), `Γ₇` ratio `2/7`. FRAC must give `ρ ≥ 2/7`, so `χ_f(ℚ(√11)²) = 7/2` given MR; G60's unconditional ceiling
  (`χ_f(F²) ≤ χ_f(Γ₇) = 3.5`) is the independent check of the direction `ρ ≥ ` truth. *Wrong-reason pass:* a `ρ` below `2/7` (would contradict the
  pullback from `Γ₇`, which exists unconditionally).
- **Arithmetic-free `Cay(ℝ, {±1, ±√2})`** on `Λ = ℤ + ℤ√2 ≅ ℤ²`: here "`E`" is `T + A` (torsion plus `x ↦ e(ξx)`), there is no `U` and no MR; the
  Kronecker sets `{x : {βx} ∈ [0, 1/2 − ε)}` with `{β}, {β√2}` near `1/2` show the measurable ratio of `ℝ` is `1/2`, and the parity set shows
  `α_inv(Λ) = 1/2`. The chain's non-arithmetic steps (the `E`-factor, the per-class positivity trick, extension, product count) must run
  unchanged and give nothing false; the MR step has no analogue (off-`E` invariant measures that are not Haar abound — a point mass at a generic
  `θ ∉ T + A`), so only the unconditional clause survives, vacuously (`ρ = 1/2`). *Wrong-reason pass:* any step of FRAC that silently uses
  arithmetic (strong approximation, R-U, weak approximation of the torus) but is labelled generic would be exposed here as unjustified.

### 1.3 Would-have-searched-here log

- None at stage 1.

## Stage 2 — SAVED (FRAC derived blind; TJ; ROUND)

**Verdicts.** **FS103-F-FRAC: TRUE** (given MR(F), `R_F = O′`) [hand; one mind blind, over held lemmas named below]. Its three parts: the density
bound given MR; `α₁(F²) = α_inv(F²) = ρ(F)` (the equality `α₁ = α_inv` and `α_inv ≥ ρ` need no MR); the unconditional SP clause. **FS103-F-TJ:
TRUE**, with `ϑ = λ*/(1 + λ*)` (the claim leaves `ϑ` undefined; with `ϑ = λ*` the bound is weaker and still true). **FS103-F-ROUND: TRUE** (with
one reading note). Notation as `data/fs103/claims.md` §0 (D-RUL, D-STAB, D-GV, D-TAE, D-SP); `G_∅ = (L ⊗ ℝ) × ∏_{v stable} O_{L_w}`, `T_∅` the
closure of `U` in it.

### 2.1 FRAC, step by step (one class; the count of classes never appears)

Let `I` be an `R ⋊ U`-invariant random independent set of `Cay(R, U)`, `δ = P(0 ∈ I)`, `f = 1_I`.

- **D1 (spectral measure).** `φ(r) = P(0 ∈ I, r ∈ I)` is positive definite on the discrete group `R`: `φ = σ̂`, `σ` finite positive on `R̂`,
  symmetric, `σ(R̂) = δ`. Rotation invariance gives `φ(ur) = φ(r)`, so `σ` is `U`-invariant. Independence: `φ(u) = 0` for `u ∈ U`. *[classical]*
- **D2 (the `E`-factor).** `𝒜_∅` := events whose indicators have spectral measure on `E_∅ = T + A`; `L²(𝒜_∅)` is exactly the spectral subspace of
  `E_∅`, and the orthogonal projection onto it is `E[· | 𝒜_∅]` (held: J45-N1, J45-N2 [hand, two]; my own check: the bounded vectors of the
  spectral subspace are those `r ↦ f∘T_r` continuous for the `G′_∅`-topology, an algebra closed under 1-Lipschitz truncation, so its
  `L²`-closure is `L²` of a σ-algebra). `𝒜_∅` is `R`-invariant (it is a spectral subspace) and `U`-invariant (`E_∅` is). *[hand, held]*
- **D3 (split the correlation).** `g(x) := E[f(x) | 𝒜_∅] ∈ [0, 1]`, `g(x) = g(0)∘T_x`. Cross terms vanish (`f − g ⊥ L²(𝒜_∅)`, preserved by
  translations), so for `u ∈ U`: `0 = φ(u) = E[g(0)g(u)] + ∫_{R̂∖E_∅} χ(u) dσ`, and by `U`-invariance of `σ' := σ|_{R̂∖E_∅}` the last term is
  `∫ Re χ(1) dσ'`. By R-U (held, J45-RU [hand, two]: `σ(E ∖ (T + A)) = 0`), `σ' = σ|_{R̂∖E}`: **`σ'` is finite, positive, `U`-invariant and
  `E`-null.** *[hand; this is J45-SI-1/SI-3 for one class: `−∫_{R̂∖E} Re χ(u) dσ = E[g(0)g(u)] ≥ 0`]*
- **D4 (MR, or the SP clause).** Given MR(F): `σ' = a·m` (Haar), and `∫ χ(1) dm = 0` because `1 ≠ 0` in `R`; so `E[g(0)g(u)] = 0`. Without MR:
  if `σ'` is not an SP witness then `∫ Re χ(1) dσ' ≥ 0`, so `E[g(0)g(u)] ≤ 0`, hence `= 0` since `g ≥ 0`. **Either way (unless SP), `g ≥ 0` and
  `E[g(0)g(u)] = 0` give `g(0)g(u) = 0` a.s.**; by invariance and countability of `R × U`, a.s. `g(x)g(x + u) = 0` for all `x ∈ R`, `u ∈ U`.
  *[hand, one mind; this is the per-class trick: it needs `g ≥ 0`, i.e. that the class indicator is non-negative — nothing about other classes]*
- **D5 (the selected set).** `J := {x ∈ R : g(x) > 0}` is a.s. independent, `𝒜_∅`-measurable, with `R ⋊ U`-invariant law, and
  `P(0 ∈ J) ≥ E[g(0)] = δ`. Its spectral measure is carried by `E_∅ = T + A` (it lives in `L²(𝒜_∅)`). *[hand]*
- **D6 (extension to `G_∅`).** `R` is dense in `G_∅` when `R = O′` (J45-N1's density in `R̂_prof × (L⊗ℝ)`, and `R̂_prof = ∏_{stable} O_{L_w}` by
  Lemma C′, row 100). `y ↦ P(1_J(0) ≠ 1_J(y)) = 2(φ_J(0) − Re φ_J(y))` is continuous for the `G_∅`-topology (dominated convergence on `Ĝ_∅`), so
  `J` is uniformly continuous in probability, extends to a `G_∅`-stationary `{0,1}`-process `J̃`, continuous in probability, with a jointly
  measurable version (Doob); and `P(J̃(x) = 1 = J̃(x + t)) = 0` for every `x ∈ G_∅`, `t ∈ T_∅` (approximate `(x, t)` from `R × U`). This is R88-TC-ext's
  argument, which never uses that the process is a four-colouring (Bochner + Doob); its held statement is at four colours, so here it is my
  re-derivation for a `{0,1}`-process. *[hand, one mind for this form]* **`T_∅` is the full product** `(S¹)^{r₁} × (complex places) × ∏ T_w`: the
  norm-one torus of `F(i)/F` is rational (`(a, b) = ((1 − t²)/(1 + t²), 2t/(1 + t²))`), so `U` is dense in `∏_{v∈S} T(F_v)` for every finite `S`
  (weak approximation, the parametrisation being a homeomorphism `P¹(F_v) → T(F_v)`), hence in the full product. *[hand, one mind; R88's inputs list
  "weak approximation" for the same step]* **This matters:** a proper closed subgroup would remove edges and could raise the ratio above every factor's.
- **D7 (samples).** By Fubini over `G_∅ × T_∅`, a.s. the sample `J̃_ω` is edge-null; regularised (Lebesgue density points; R88-TC-reg / R88-J28V-2
  [hand, held]) it is a.e. equal to a set independent at every pair. **The real factor exactly:** on `UD(ℝ²)` the density points of an
  edge-null measurable set are 1-avoiding at every pair (if `x, y` are density points with `|x − y| = 1`, the pairs `(x′, x′ + w)`, `x′ ∈ B(x, r)`,
  `w` in an arc of length `≤ r` about `y − x`, both in the set have positive measure in `ℝ² × S¹` — my derivation), so the bound is the literal
  `m₁(ℝ²)` of `[DuczVarga2026]` §2.1 ("the supremum of the upper densities of measurable sets A ⊆ R2 containing no two points at distance 1"),
  through C14.2 (a)'s window form, whose error is uniform in the set (periodise `A ∩ Q_n`).
- **D8 (the product count).** Split the places: a finite head `H` (every stable `v` with `λ*_v/(1 + λ*_v) > δ_Croft`, finite since
  `λ*_v ≤ 2√q/(q + 1)` at level one (Weil) and `≤ 2/(q + 1)` above it (X26B-L1)) and the tail. The tail's measurable Hoffman ratio is
  `≤ a/(1 + a)`, `a = sup_{tail} λ*_v` (a character of the product has finitely many non-trivial components, each in `[−λ*_v, 1]`, so the product
  is `≥ −a`; `[BachocEtAl2014]` Thm 2.2 for edge-null sets), hence `≤ δ_Croft ≤ m₁`. The archimedean factor `ℂ^{r₁}` (with its circles) has
  ratio `m₁` by C14.3 induction over the real places from C14.2 (a); complex places enter with ratio 0 (FS100-CX / X26B-L3, held, not re-derived
  here). C14.3 (held, two derivations at FS-86; I re-walked its proof: Zhang's observations (i)–(ii) and the Fubini identity, and C14.1's
  window No-Homomorphism inequality `d(Y) ≤ r·d(N[Y]) + η`) gives the product ratio `max(m₁, max_{v∈H} r_v, tail) = max(m₁, sup_v r_v) = ρ(F)`.
  Stationarity turns the samplewise window bound into `δ ≤ P(0 ∈ J̃) ≤ ρ(F)`. *[hand; C14.1–C14.3 held (two), the split and tail one mind]*
  X25B's derivation reaches the same bound (`plans/FS100-X25B-derivation.md` l.89: "`r(G_∅) ≤ … ≤ max(m₁(ℝ²), sup_v r_v)`"; read only that line).

**So given MR(F): `δ ≤ ρ(F)`; without MR: `δ > ρ(F)` ⟹ `σ|_{R̂∖E}` is an SP witness** (D4's alternative), and an SP witness refutes MR
(J45-SP-oi). *Where a second class, or the count, is used in row 123's chain as written:* (i) J45-SI-1–SI-4 run on the simplex embedding of all four
classes at once — each identity is linear in the classes, so it splits class by class (D3 is SI-3 for one class); (ii) A⁺'s selection
`c′ = min ∘ M` needs every support `M(x)` non-empty, i.e. `Σ_j p_j = 1` — the classes cover; the one-class analogue is D5's `J`, which needs
nothing; (iii) R88-TCA's "four classes cannot cover: `1 ≤ 4 max(α(Y′), r_X) < 1`" — the count, the only place `k` enters; (iv) R88-TC's tight
factor (gap-freeness propagated through all four classes) is used by B⁺ and row 124, **not** by row 123. Nothing else.

**The equalities.** `α₁(F²) ≥ α_inv(F²)`: an invariant `I` meets a finite `G` in `δ|G|` points on average (copies on each coset of `R`; edges stay
in cosets). `α_inv(F²) ≥ α₁(F²)`: for Følner sets `G_n ⊂ R` (countable abelian), take a maximum independent `I_n ⊆ G_n`, average `δ_{I_n − r}` over
`r ∈ G_n` (density exactly `|I_n|/|G_n|`), take a weak* limit (`R`-invariant, supported on independent sets), then a `U`-fixed point by Markov–
Kakutani on the compact convex set of such measures (`U` countable abelian; rotations preserve density and independence). `α_inv(F²) ≥ ρ(F)`: at a
stable place, pull back a maximum independent set of `G_{v,k}` through `R → O_{L_w}/𝔭^k` (onto, by density), translated by a uniform element and
multiplied by a uniform element of `S_k` (an automorphism group of `G_{v,k}`); at the real place, pull back a periodic 1-avoiding set of density
near `m₁` under a uniform rigid motion. Density `r_v` resp. `→ m₁`. **None of this uses MR.** `r_v = sup_k α(G_{v,k})/|G_{v,k}|`: `≥` by
pullback; `≤` by the full-coset argument (a coset in which the set has density `> 1/2` — the martingale theorem makes these carry all but `o(1)`
of the mass — is adjacent to no other such coset; the held C14.2 (b) is the same argument).

**Controls (1.2), run:** K — the dyadic places have `r_v = 1/4`, so `ρ(K) = 1/4` and FRAC gives `χ_f(K²) = 4`, agreeing with G60 (D8's product
count uses `max`, never a threshold `< 1/4`, so it does not stop at K; the held TCA's *threshold* form does stop there — its sharpness note says
so). ℚ(√3): `ρ = 1/3` from `Γ₃`, as the triangle and the three-colouring force. ℚ(√11): `ρ ≥ 2/7` from `Γ₇`, so FRAC predicts `χ_f(ℚ(√11)²) = 7/2`
given MR (every other stable place and `m₁` are below `2/7`), matching G60's unconditional ceiling 3.5 — the chain reproduces the known side and
predicts the unknown one. Arithmetic-free `Cay(ℝ,{±1,±√2})`: D1–D5 and D7–D8 run verbatim; D6's density and D8's torus step are arithmetic there
(the "`T_∅`" is the product of `{±1}`-circles — `±1, ±√2` generate a group whose closure in `ℝ` is all of it); D4 has no MR, so only the
unconditional clause holds, vacuously at `ρ = 1/2`. The chain stops exactly at D4, as it must.

### 2.2 FS103-F-TJ

*Statement (claims-f2):* "T-J39-3 per class: a density-`δ` invariant independent set gives `max(m₁, max_{v∈N_δ} r_v) ≥ δ` or an SP witness,
`N_δ` the places with `λ*_v ≥ δ/(1−δ)`; the mixing selection per class keeps only density `≥ (δ−ϑ)/(1−ϑ)`".
- **First clause TRUE** [hand, one mind]: by FRAC's unconditional form, no SP witness gives `ρ(F) ≥ δ`. A place with `λ*_v < δ/(1 − δ)` has
  `r_v ≤ λ*_v/(1 + λ*_v) < δ` (measurable Hoffman: `a² ≤ λ*·a(1 − a)`). The sup of `r_v` is attained (`r_v → 0`), so `ρ ≥ δ` puts `m₁ ≥ δ` or
  some `r_v ≥ δ` with `v ∈ N_δ`. `N_δ` is finite (`λ*_v → 0`). (Empty `N_δ` reads as `m₁ ≥ δ`.)
- **Second clause TRUE with `ϑ = λ*/(1+λ*)`** [hand, one mind]: for an independent set of density `δ` in `X × H` with `H` a compact Cayley graph of
  mixing constant `λ*`, the fibre densities `f(x)` of adjacent `x ~ y` satisfy `f(x)f(y) ≤ λ*²(1 − f(x))(1 − f(y))` (expander mixing, no edges
  between fibres), so `{f > ϑ}` is independent in `X` and has density `≥ (δ − ϑ)/(1 − ϑ)` (Markov). `λ* < δ/(1 − δ)` ⟺ `ϑ < δ`, matching `N_δ`.
  The claim does not define `ϑ`: **MISSTATED only as written** (undefined symbol); with `ϑ = λ*` the bound `(δ − λ*)/(1 − λ*)` is smaller and also
  true. Its content — the mixing selection loses density and cannot give TJ's first clause by iteration over infinitely many thick places — is right.

### 2.3 FS103-F-ROUND

*Statement:* "row 123's lower bound is `χ(F²) ≥ ⌈1/ρ(F)⌉`: the colour count enters only as the pigeonhole on the densest class; `1/ρ(F) ≤ 4.36` at
every field, so this route never gives six".
- **TRUE** [hand, one mind]. A `k`-colouring of `F²` gives (amenability of `R ⋊ U`, as SP-Cor) an invariant random `k`-colouring; its densest class
  has density `≥ 1/k` and `≤ ρ(F)` (FRAC), so `k ≥ ⌈1/ρ⌉`; the count enters only there (2.1 (iii)). `ρ(F) ≥ m₁ ≥ δ_Croft = 0.22936…`, so
  `1/ρ ≤ 4.35987… ≤ 4.36` and `⌈1/ρ⌉ ≤ 5`: **no bound on one class's density can exclude five colours, so this route never gives six.**
- *Reading note:* row 123 states `χ ≥ min(L(F), 5)`, citing row 99 below five. The MR route itself gives `⌈1/ρ⌉` everywhere; the two agree
  (`⌈1/ρ⌉ = min(L, 5)`) because no stable target has an integrality gap at the thresholds `1/2, 1/3, 1/4` (CLS at four; the lists at two and
  three) — I did not re-derive CLS. "Row 123's lower bound is `⌈1/ρ⌉`" is therefore true of its five-clause route, and equal to its stated bound.

### 2.4 Would-have-searched-here log (stage 2)

- None: every step is a derivation or a held lemma read by statement and proof.

## Stage 3 — SAVED (DV, TF, 47, each link on its own; committed before opening anything fenced)

**Verdicts.** **FS103-F-DV: TRUE given MR(ℚ(√635087))** [hand + tools exact; one mind blind]. **FS103-F-TF: TRUE given MR(ℚ(√635087))** [hand].
**FS103-F-47: TRUE given MR(ℚ(√47))** [hand + tools]. No GAP found. MR at both fields is row 120's (in its scope: neither has a stable dyadic
place, so no ramified one), which is where every one of these rests; nothing here re-proves or strengthens MR.

### 3.1 The place list of ℚ(√635087) (`tools/fs103_b_places.py`, `data/fs103/fs103-b/places.out`, exit 0)

- `635087` is prime; `635087 ≡ 7 (mod 8)`, `≡ 15 (mod 16)`, so `−635087 ≡ 1 (mod 8)` is a 2-adic square and `F_v = ℚ₂(√635087) = ℚ₂(i)` at the one
  (ramified) dyadic place: **not stable**, so `R = O′` is not in doubt and MR's scope holds.
- Stable places by two routes (A: `p ≡ 3 (mod 4)` with odd residue degree; B: PARI `idealprimedec` over `F` and over the absolute field of `L`,
  a place stable iff one prime of `L` lies over it), agreeing at every prime below 2000: 159 stable places, smallest residue field `𝔽₁₀₃`
  (103, 107, 127, 163, 191, 211, 239, 263, 271, 311, …, each split, two places), and the ramified `635087` (`L/F` inert there: PARI gives one prime
  of `L` with `f = 2`). No stable place lies above `p < 103`.
- Every stable place: `λ*_v ≤ 2√q/(q + 1)` (Weil at level one, I-WEIL; X26B-L1's `2/(q + 1)` above it), so `r_v ≤ λ*/(1 + λ*) ≤ 0.163300` (at
  `q = 103`) `< 0.22936 ≤ m₁(ℝ²)`; above 2000, `< 0.0428`. **So `ρ(ℚ(√635087)) = m₁(ℝ²)`.**
- Plants: `PLANT=1` flips route A's rule to `p ≡ 1 (mod 4)` — 292 disagreements, first at `p = 17` (route B: split in `L/F`), exit 1;
  `PLANT=2` substitutes `d = 635083` — "not prime", exit 1. Each fires for its own reason (`places-plant1.out`, `places-plant2.out`).

### 3.2 DV, link by link

- **(i) FRAC at ℚ(√635087):** `α_inv(F²) ≤ ρ(F) = m₁` given MR (stage 2). *The object and `m₁`* (the brief's first bullet): the object is a
  `G_∅`-stationary `{0,1}`-process continuous in probability (D6), with a jointly measurable version (Doob); a.s. its sample is an edge-null
  measurable subset of `G_∅ = ℂ² × ∏ O_{L_w}` (two real places: `UD(ℝ²) × UD(ℝ²)`, ratio `m₁` by C14.3); its density points are independent at
  every pair (D7), and the everywhere-1-avoiding sets are exactly those in `[DuczVarga2026]`'s definition of `m₁(ℝ²)`. Stationarity then gives
  `P(0 ∈ J̃) ≤` the window ratio. No weaker notion (a.e.-avoiding, Borel, CP) enters the value: they all have sup density `m₁` (density points).
- **(ii) `α₁(F²) ≤ α_inv(F²)`** (B-AMEN, Følner in `R` then Markov–Kakutani in `U`; no MR). So `α₁(F²) ≤ m₁`.
- **(iii) `α₁(ℝ²) ≤ α₁(F²)`**: an infimum over a larger family.
- **(iv) `m₁(ℝ²) ≤ α₁(ℝ²)`**: `[DuczVarga2026]` Claim 1 ("For any unit-distance graph G, m1 (R2 ) ≤ 1/χf (G)"), and directly: a periodic
  1-avoiding set of density `d` (C14.2 (a)'s periodisation, `d → m₁`) under a uniform translation meets a finite `G` in `d|G|` points on average.
  **So `α₁(ℝ²) = m₁(ℝ²)`.**
- **(v) `f(n)/n → α₁(ℝ²)`**: `f(n)/n ≥ α₁(ℝ²)`, and `f(a + b) ≤ f(a) + f(b)` (two configurations placed far apart), so by Fekete
  `lim f(n)/n = inf_n f(n)/n = α₁(ℝ²)`. **This is `[DuczVarga2026]` Conjecture 1's first clause in its own words: "f (n)/n = m1 (R2 ) + o(1)".**
  Its second clause, "m1 (R2 ) = δCroft", is untouched.
- **(vi) `χ_f,0(ℝ²) = χ_f(ℝ²) = 1/m₁`**: `χ_f,0 = 1/α₁` is `[MatolcsiEtAl2025]` Theorem 2 (read, proof checked: the discrete-cube averaging);
  `χ_f,0 ≤ χ_f` is theirs; the upper bound `χ_f(ℝ²) ≤ 1/m₁(ℝ²)` for the **whole-plane** number (MRVZ: "it is not known whether equality holds",
  and they state only `≤ 1/δCroft`) is B-CHIF: for a periodic 1-avoiding `A′` of density `d`, `A_r = {x : |A′ ∩ B(x, r)| > (1 − η)|B(x, r)|}`
  (`η < 1/2`) is open and 1-avoiding (translate `B(x, r)` onto `B(y, r)` by `y − x`), of density `→ d` as `r → 0`; an inner finite union of
  squares keeps it; a fine finite grid of translates covers every point with fraction `≥ d − ε`, uniformly. So all three equal `1/m₁ ≥
  1/0.246989 = 4.048763…`. **The equality `χ_f,0(ℝ²) = χ_f(ℝ²)` — a question MRVZ state as unknown — is part of this conditional too**, a second
  published question the claim answers (given MR); worth its own line at the close.
- **Wrong-reason audit** (the flattering outcome): (a) *does the chain use `m₁ < 1/4` anywhere as a threshold?* No — D8 uses `max`; the K control
  (`ρ = 1/4` exactly) would expose a threshold. (b) *Could `ρ(F)` undercount?* Only by a place or a product structure missed: the place list is
  exact to 2000 and Weil above; `T_∅` is the full product (D6). (c) *Could the per-class selection lose the class?* `P(0 ∈ J) ≥ E[g(0)] = δ`
  exactly. (d) *Is `m₁` the right real-place number?* Yes (D7). (e) The conclusion is conditional on MR at a degree-2 field, which row 120 holds
  at [hand] with EL2021 Thm 1.2 by statement; any flaw in MR is the flaw here.

### 3.3 FS103-F-47

ℚ(√47): dyadic place not stable (`−47 ≡ 1 (mod 8)`); 3, 7 inert; stable places below 60: 11, 19, 23, 31, 43 (split), 47 (ramified). Held
all-levels bounds: 11 — FS-66 `B₁ = 28.204320`, ratio `0.23309`; 19 — FS-66 `77.511742`, `0.21471`; 23 — level-one Hoffman `0.249077` (the tool;
all levels, since new characters are `≥ −2/24`), or row 75's `97.984637/529 = 0.18523`; **31 — level-one Hoffman `0.249997254763781 = 1/4 −
2.74524·10⁻⁶`** (new levels `≥ −2/32`, so all levels); 43 — `0.21376`; 47 — `0.21113` (level one; X26B-L1 above, any base ramification); `q ≥ 59`
— Weil `≤ 0.2038`; real places `m₁ ≤ 0.246989`. So `ρ(ℚ(√47)) ≤ 1/4 − 2.74524·10⁻⁶` and **31 binds** among held bounds (the true `α(Γ₃₁)` ratio is
likely lower; no certificate is held). Given MR(ℚ(√47)): `α₁(ℚ(√47)²) = ρ ≤ 1/4 − 2.745·10⁻⁶`, so `χ_f(ℚ(√47)²) = 1/ρ ≥ 4.0000439243 >
4.0000439`, and some finite `G ⊂ ℚ(√47)²` has `χ_f(G) ≥ |G|/α(G) ≥ 4.0000439`; `√3 ∉ ℚ(√47)`, so `G` has no unit triangle (G57, `[Krebs2022]` Lemma
5.1). **TRUE** [hand + tools].

### 3.4 FS103-F-TF

`√3 ∉ ℚ(√635087)` (`3·635087` is not a square: 635087 is a prime other than 3), so every finite unit-distance graph in `ℚ(√635087)²` is
triangle-free; with 3.2 (ii) and `ρ = m₁`, for every `ε` some such graph has `α(G)/|G| ≤ m₁ + ε ≤ 0.246989 + ε`. **TRUE** given MR [hand].

### 3.5 Reading record (G50; proposed `BIBLIOGRAPHY.md` status lines)

- `[DuczVarga2026]` (held, `library/pdf/arXiv-2606.28157-ducz-varga-independence-ratio-below-quarter.pdf`): §1, §2.1, §2.2 (first paragraph), §3
  (definitions) read here, 2026-09-26 — Conjecture 1 quoted verbatim in 1.1.
- `[MatolcsiEtAl2025]` (held): §2 pp. 4–5 (definitions of `χ_f(ℝ²)`, `χ_f,0`, `α₁`, `ρ(ℝ²)`, `m₁`; the chain (14); their conjecture
  "δCroft = m1 (R2 ) and α1 (R2 ) = 1/4") and §3 Theorem 2 with proof, re-read here. **Note for the close:** MRVZ write `ρ(ℝ²) = 1/α₁(ℝ²)` (the
  finitary Hall ratio) — a clash with FS103-F's `ρ(F)` (an independence ratio); a write-up should rename one.

### 3.6 Would-have-searched-here log (stage 3)

- None. (The place list is a complete exact enumeration below a bound a derivation fixed, and Weil above it — not a search.)

## Stage 4 — SAVED (the fence opened: `plans/FS103-F-fractional-shadow.md` read, §§ theorems, 2.1–2.6, 3.0–3.6)

**Agreement.** Every one of the six claims has the same verdict from both minds (FS103-F; this job, blind until `f457e527`): FRAC, TJ, ROUND, DV,
TF, 47 TRUE, DV/TF/47 given MR at the named field. The claims file's definitions and statements match F §2.3 and F's table verbatim (the owner's
"grade note trimmed" is disclosed; the rows FS103-F-SI, -EXT, -PL were not copied — a selection, not a paraphrase).

**Divergences of route** (none changes a verdict):

| step | FS103-F | this job | note |
|---|---|---|---|
| the count on `G_∅` | X25B-L1 (profinite reduction) + X25B-PZ (stationary Zhang) + X25B-T | C14.1–C14.3 (FS-86, two derivations) on a finite head, the tail by measurable Hoffman | same content; two held derivations of Zhang's count |
| `T_∅` = full product | X25B-W | rationality of the norm-one torus of `F(i)/F` ⟹ weak approximation | independent |
| complex places | ratio `≤ m₁` (FS100-CX) | ratio 0 (X26B-L3) | either is `≤ ρ`; totally real instances untouched |
| `α₁ = α_inv` | via `ρ ≤ α₁ ≤ α_inv ≤ ρ` (needs MR) | unconditional both ways (B-AMEN) | see divergence of truth (1) |
| TJ's `ϑ` | a random threshold, uniform on `[λ*/(1+λ*), δ)` | the fixed `λ*/(1+λ*)` | consistent; the claims file drops the definition |
| the place list | Legendre symbols, one route; tail by the next prime | PARI `idealprimedec` over `F` and `L` against the criterion, two routes; ramified place's inertness checked | same list (103 first; max `0.16330`) |
| `m₁` and the object | reverse Fatou on a Doob version, then `[AmbrusEtAl2023]` Thm 1 on its density points | window form (C14.2 (a)), density points | same |

**Divergences of truth** (slips in the F record; no claim affected):
1. **F §3.4 item 2: "The reverse (`α₁(F²) ≥ α_inv`) is false in general and never used." False.** For every real field, an invariant random
   independent set of density `δ` meets any finite `G ⊂ F²` in `δ|G|` points on average (copies on each coset of `R`; edges stay inside cosets),
   so `α(G) ≥ δ|G|` and `α₁(F²) ≥ α_inv(F²)`, unconditionally (B-AMEN). FRAC's own equality `α₁ = α_inv` contains it. What is false in general is
   `α₁(ℝ²) ≥ α_inv(F²)` (at K: `1/4 > α₁(ℝ²)`, by `[DuczVarga2026]`); the sentence probably meant that. **Correction owed** (one line).
2. **F §3.2, DV proof step 4:** "translates of a periodic measurable 1-avoiding set of density `m` form a fractional colouring of weight `1/m`".
   MRVZ's `χ_f(ℝ²)` takes finitely many (equivalently countably many) independent sets covering **every** point; a continuum of translates of a
   merely measurable set is not such a colouring, and a finite family need not cover every point uniformly. **A small GAP, closed** by B-CHIF
   (open regularisation `A_r`, then an inner union of squares and a finite grid of translates), so `χ_f(ℝ²) ≤ 1/m₁(ℝ²)` holds as needed and the
   claim stands. **Correction owed:** cite the regularisation in step 4.
3. The claims file's FS103-F-TJ uses `ϑ` without defining it (F §2.4 defines it inside the proof). **Correction owed** to the statement.

**What F has that I lack:** the ℚ(√2351) instance; the §3.3 table of published readings contradicted given MR (I found the MRVZ equality question
independently, 3.2 (vi), not the `[AmbrusEtAl2023]` §4 Remark); the G24/G60/G80 proposals; a prior-art gate (five queries, negative). **What I have
that F lacks:** B-AMEN unconditional; B-CHIF (closes item 2); the two-route place list with the ramified place's `L/F`-inertness checked by
PARI; the exact level-one Hoffman ratios at 11, 19, 23, 43, 47 (23's `0.249077` is itself below 31's, so ℚ(√47)'s bound needs no certificate at
23); the arithmetic-free control run to the step where it stops (D4).

**Grade proposal for the close.** FRAC, DV, TF, 47: [hand], **two minds** (FS103-F; FS103-B blind to F's proofs and route until `f457e527`),
over held lemmas (J45-N1/N2, J45-RU, J45-SP-oi, C14.1–C14.3 / X25B-PZ, R88-TC-ext's argument), conditional on MR at the named field (row 120's
grade, EL2021 Thm 1.2 by statement). **The whole weight is MR's**: nothing in either derivation adds evidence for MR, and FS103-F §3.5's
killing test (any proof of `α₁(ℝ²) > m₁(ℝ²)` refutes MR at ℚ(√635087)) is right — it is the unconditional clause read backwards.

### Would-have-searched-here log (stage 4)

- None.
