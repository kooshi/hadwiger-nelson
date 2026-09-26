# FS103-F — the fractional shadow: do our field-level arguments run one colour class at a time?

*Derivation record of job **FS103-F**, de Bruijn, Opus 5.5, 2026-09-26. Brief: `data/fs103/briefs/F103-fractional-shadow.md`, with
`data/fs103/briefs/STANDING-RULES.md` as part of it. Not blind: every file is open to me. No subagents; no finite-witness search (ban to
2026-10-01); I touch only this file, `data/fs103/fs103-f/` and `tools/fs103_f_*.py`. Two blind verifiers run on FS-103; I have not
contacted them. Contact: `main` only.*

## Theorems this phase proved

*(filled stage by stage; grades per `CLAUDE.md` § Notation; every one is **one mind** — this job — unless marked)*

| id | statement (one line) | grade | where |
|---|---|---|---|
| FS103-F-SI | J45's SI per class: for a translation-invariant random independent set `I`, `∫_{R̂∖E_S} χ(u) dσ_g = −E[p(0)p(u)] ≤ 0`; equality at every `u` ⟹ `J = {P(x ∈ I \| 𝒜_S) > 0}` is an `𝒜_S`-measurable equivariant independent set `⊇ I` | [hand; one mind; J45's proof transcribed] | §2.1 |
| FS103-F-EXT | R88-TC-ext per class: an independent set with spectrum on `T + A` extends to a `G_∅`-stationary, CP, jointly measurable, a.e.-independent set of the same density | [hand; one mind; J28D C1–C3 transcribed] | §2.2 |
| FS103-F-FRAC | given MR(F) (`R_F = O′`): every `R ⋊ U`-invariant random independent set of `F²` has density `≤ ρ(F) = max(m₁(ℝ²), sup_v r_v)`; so `α₁(F²) = α_inv(F²) = ρ(F)`; unconditionally, density `> ρ(F)` gives an SP witness | [hand; one mind; a composition of held lemmas, each per class in its proof (J45 N2, RU, SP-oi; X25B-L1, PZ, T; FS100-CX)] | §2.3 |
| FS103-F-TJ | T-J39-3 per class: a density-`δ` invariant independent set gives `max(m₁, max_{v∈N_δ} r_v) ≥ δ` or an SP witness, `N_δ` the places with `λ*_v ≥ δ/(1−δ)`; the mixing selection per class keeps only density `≥ (δ−ϑ)/(1−ϑ)` | [hand; one mind] | §2.4 |
| FS103-F-ROUND | row 123's lower bound is `χ(F²) ≥ ⌈1/ρ(F)⌉`: the colour count enters only as the pigeonhole on the densest class; `1/ρ(F) ≤ 4.36` at every field, so this route never gives six | [hand; one mind; a reading of FRAC] | §2.5 |
| FS103-F-DV | given MR(ℚ(√635087)): `α₁(ℝ²) = m₁(ℝ²)`, i.e. `f(n)/n → m₁(ℝ²)` (`[DuczVarga2026]` Conjecture 1, first clause); `χ_f,0(ℝ²) = χ_f(ℝ²) = 1/m₁(ℝ²) ≥ 4.04876` | [hand + tools exact; one mind; MR's grade] | §3.2 |
| FS103-F-TF | given MR(ℚ(√635087)): for every `ε > 0` a finite **triangle-free** unit-distance graph has independence ratio `≤ m₁(ℝ²) + ε ≤ 0.24699 + ε` | [hand; one mind; MR's grade] | §3.2 |
| FS103-F-47 | given MR(ℚ(√47)) (row 121's own hypothesis), with only held certificates: `α₁(ℚ(√47)²) ≤ 1/4 − 2.745·10⁻⁶` (31's Hoffman bound binds), a triangle-free finite graph with `χ_f ≥ 4.0000439` | [hand + cert; one mind] | §3.2 |
| FS103-F-PL | ℚ(√635087) (and ℚ(√2351)) has no stable dyadic place and every stable place has Weil–Hoffman ratio `< 0.22936`: max `0.16330` (103) and `0.22219` (47) | [tools exact; plants fire] | §3.1, `tools/fs103_f_places.py` |

## Would-have-searched-here log (standing rule 3)

- (running; see each stage)

## Stage 1 — SAVED (quotation check; the controls of question 4; an order slip)

### 1.0 An order slip, recorded first

The brief asks for the controls to be written **before** questions 1–2. I read the sources for the quotation check and, in doing so, walked
questions 1–2 mentally and sent the owner the brief's one-line alert (a per-class theorem implying `χ_f > 4`) **before** writing this
section. So the controls below were written knowing where the derivation was heading: they are not a blind pre-registration. I wrote them as
if they were (each one names what would make the per-class claim wrong), and stage 2 scores them honestly.

### 1.1 Quotation check (standing rule 5)

| # | quoted in the brief | source | result |
|---|---|---|---|
| Q1 | "**if the chain's direction "a colouring of `F²` gives a CP colouring of `ℝ²`" runs on one colour class at a time** — … refuting the published conjecture" | `plans/FS103-G-prior-art.md` §2.3 item 2 | **verbatim** (the source's sentence opens with "So"; the brief drops it) |
| Q2 | `[MatolcsiEtAl2025]` "Conjecture 1. χf,0(R²) = 4, and for all finite unit distance graphs G ⊆ R² we have χf(G) < 4" | arXiv:2311.10069 v4, §4 end (`pdftotext` line 640) | **verbatim**: "Conjecture 1. χf,0 (R2 ) = 4, and for all finite unit distance graphs G ⊆ R2 we have χf (G) < 4." |
| Q3 | "(also `[AmbrusEtAl2023]` §4 Remark)" — cited, not quoted; §2.3 quotes it | arXiv:2207.14179 v3, the Remark after Corollary 2 | §2.3's quotation **verbatim**: "we venture to conjecture that χf (R2 ) = χgf (R2 ) = 4. This would imply that α1 (R2 ) = 1/4 and m1 (R2 ) ≤ 0.247 hold simultaneously, providing an interesting example of a natural infinite graph for which the measurable and the non-measurable variants of a parameter have different values." |
| Q4 | row 123: "every stable place of `F(i)` has all-levels four-colour ratio `< 1/4` ⟺ no stable residue target is four-colourable ⟺ `L(F) ≥ 5`" | `LEDGER.md` row 123 | **verbatim** |
| Q5 | "`m₁(ℝ²) ≤ 0.2470` (`[AmbrusEtAl2023]` Thm 1)" | arXiv:2207.14179 Theorem 1 | agrees: "Any Lebesgue measurable, 1-avoiding planar set has upper density at most 0.2470." — **every measurable set, not only periodic ones** (their §2 reduces to periodic sets for the Fourier side, citing [deOV10, KeMOR16]) |
| Q6 | "their Lemma 1 works with finite-dimensional distributions" (the owner's reading) | same, Lemma 1 | Lemma 1 is **stated for "a measurable, periodic, 1-avoiding set A"**; its atoms `a_X(ε)` are densities of Venn atoms of translates of `A`, i.e. the finite-dimensional probabilities of the process `x ↦ 1_A(x + t)`, `t` uniform on a period cell. So the reading is fair in substance, but the lemma as printed assumes periodicity (answered in stage 3) |
| Q7 | "at `F_dG` (every stable place has `λ* ≤ 0.1734 < 1/3`)" | §2.3; `data/fs103/claims.md` C-131 ("Weil's `2√131/132 = 0.17342…`") | consistent |
| Q8 | "T-J39-3's forward direction (`plans/POROS-2026-09-25-wanted-poster-167.md` §3.2; `plans/FS100-BC-verification.md`) and the extension it uses (`plans/R88-derivation.md` R88-TC-ext)" | the three files | addresses resolve; T-J39-3 at wanted-poster §3.2, BC's L1–L6 at §2.1, R88-TC-ext in R88-derivation |

**The premise "refuting the published conjecture" is out of date — found at the quotation check.** `[MatolcsiEtAl2025]`'s Conjecture 1 was
**disproved in print on 26 June 2026** by `[DuczVarga2026]` (arXiv:2606.28157), held here and "read in full (2026-09-16, FS-56 §PA)"
(`BIBLIOGRAPHY.md`). Its abstract, verbatim: "We prove that there exists a finite unit-distance graph in the plane with independence ratio
strictly smaller than 1/4, answering a question of Erdős. … This disproves their Conjecture 1, and implies that the fractional chromatic
number of the plane is strictly larger than 4." Their G29 has `χ_gf(G29) > 4.0007` ("a rational dual witness, not claimed optimal", our
bibliography row). **And they pose a new conjecture** (§2.1, verbatim): "Conjecture 1. f (n)/n = m1 (R2 ) + o(1) and in particular that
m1 (R2 ) = δCroft." Here `f(n)` is the least independence number of an `n`-point unit-distance graph in the plane, so `lim f(n)/n = α₁(ℝ²)`
(disjoint far-apart copies), and **their conjecture's first clause is `α₁(ℝ²) = m₁(ℝ²)`**. Neither `plans/FS103-G-prior-art.md` nor the
milestone plan cites `[DuczVarga2026]`; `BIBLIOGRAPHY.md`'s own `[MatolcsiEtAl2025]` row says "see `[DuczVarga2026]`". A G50 instance (a held,
read paper that bears, not consulted), for the close. **What this changes:** the flattering outcome of the brief cannot be "a refutation of a
published conjecture" — that has been done. The live question becomes whether the per-class chain gives something *beyond* Dúcz–Varga:
a quantitative bound, or their own Conjecture 1.

### 1.2 The controls of question 4, with what a wrong-reason "per class" would look like

The per-class claim under test (the brief's, in my words): *given MR(F), every translation- (and rotation-) invariant random independent set
of `F²` has density at most the best local ratio of `F`*. Each control is a field where a per-class argument **must not** conclude a density
bound below the truth.

| control | the truth, independently | what a correct per-class argument must say there | where a wrong one would show |
|---|---|---|---|
| **CTL-K**: `K = ℚ(√3,√11)` | `χ_f(K²) = 4` (G60; lower bound `[MatolcsiEtAl2025]`'s G27 blown up inside `K²`, upper the dyadic residue colouring); `[Ducz2026]`: "the entire Moser lattice is geometrically integer 4-colorable". So the finitary ratio `α₁(K²) = 1/4`, and there **is** an invariant random independent set of density exactly `1/4` (a residue class at a dyadic place, pulled back with a random translate) | its bound must be **exactly `1/4`**, carried by the two stable dyadic places (inert in `K(i)/K`, target `𝔽₄` with the norm-one group `μ₃`, i.e. `K₄`, tight at `1/4` at every level — row 67) | a bound `< 1/4` at `K`: it would mean the argument treated a tight dyadic place as removable (thick). At density `δ = 1/4` the thickness threshold must be `λ* < δ/(1−δ) = 1/3`, and `K₄`'s `λ* = 1/3` exactly — **the boundary**, so a correct argument keeps the dyadic places, and a wrong one would use a non-strict threshold |
| **CTL-11**: ℚ(√11) | `χ(ℚ(√11)²) = 4`; the stable place above 7 has target `Γ₇`, `α(Γ₇)/49 = 2/7`, and every finite subgraph maps to it, so `α₁(ℚ(√11)²) ≥ 2/7` | bound exactly `2/7` (the place at 7 is not thick at `δ = 2/7`: `λ*(Γ₇) = 0.5617 > (2/7)/(5/7) = 0.4`) | a bound below `2/7` |
| **CTL-√3**: ℚ(√3) and ℚ(√7) | three-chromatic, a stable place with residue field `𝔽₃` of ratio `1/3` (G38; row 99) | bound `1/3` | below `1/3` |
| **CTL-EXC**: ℚ(√5) (row 100's exception) | bipartite; a ramified stable dyadic place, ratio `1/2` | the argument is **out of scope** (MR is not claimed there, row 120); if run anyway its dyadic factor has Hoffman ratio `1/2` | any claim below `1/2`, or any claim at all that uses MR there |
| **CTL-ℤ[√2]** (arithmetic-free analogue of the planner's CTL-ABS): `Λ = ℤ + ℤ√2 ⊂ ℝ`, connection set `{±1, ±√2}` | finite subgraphs are subgraphs of the grid `ℤ²`, bipartite, so the finitary ratio is `1/2`; a measurable set of `ℝ` avoiding `{1, √2}` has density `< 1/2` (density `1/2` forces `A + 1 = A^c = A + √2` a.e., so `A` is invariant under the irrational `√2 − 1`, so null or conull) | the gap between finitary (`1/2`) and measurable (`< 1/2`) must be carried by a **torsion character** — here the parity `a + b√2 ↦ a + b (mod 2)`, a "place" of ratio `1/2`. The analogue of the chain gives `max(measurable, torsion) = 1/2`, the truth. (There is no rotation group here, so no MR analogue; this controls the arithmetic of the bound, not branch (B)) | a claim "finitary = measurable" in a group whose torsion quotients beat the measurable ratio |
| **CTL-DV** (a published positive result the conclusion must be consistent with) | `[DuczVarga2026]`: `α₁(ℝ²) < 1/4`, `χ_f(ℝ²) > 4` | any per-class conclusion `α₁(ℝ²) ≤ ρ` must have `ρ ≥ m₁(ℝ²) ≥ 0.22936` (Croft) and is consistent with `α₁ < 1/4` | a conclusion `α₁(ℝ²) < m₁(ℝ²)` (impossible: `m₁ ≤ α₁` by averaging translates of a periodic set) |

**Wrong-reason lines** (a pass for the wrong reason would look like this):
- **WR-1 (a hidden second class).** A "per-class" step that selects `min M(x)` or any choice from a support *because every point has some
  colour*. Per class the object must be the support set `J = {x : P(x ∈ I | 𝒜) > 0}`, and `J ⊇ I` must come from `P(x ∈ I, p(x) = 0) = 0`,
  not from a pigeonhole over colours.
- **WR-2 (the count).** Any use of `Σ_j δ_j = 1`, or of "four classes", or of `1/k` as a threshold.
- **WR-3 (the real place).** Using Hoffman's `0.2871` for `UD(ℝ²)` (too weak to matter), or using `m₁` on a set that is not shown measurable.
  `m₁` bounds measurable sets (Q5); the argument must produce a measurable version first.
- **WR-4 (Følner backwards).** Claiming `α₁(F²) ≥ α_inv(F²)`: the true direction is `α₁(F²) ≤ α_inv(F²)` (invariant sets are built from
  finite ones), and the conclusion needs exactly that direction.
- **WR-5 (MR on the wrong measure).** Applying MR to the spectral measure of a merely translation-invariant set: MR needs `U`-invariance, so
  the random set must be `R ⋊ U`-invariant (J45 SP-Cor's first lines; BC's L2, note 2).
- **WR-6 (level one).** Using a level-one ratio where the all-levels ratio is needed (e.g. 43's `0.1974` at level one against Hoffman's
  `0.21376` at every level): the per-class count reads the full-depth compact planes.
- **WR-7 (a thick place read non-strictly).** At density `δ`, a place may be dropped only when `λ*_v < δ/(1−δ)` strictly; CTL-K sits on the
  boundary.

### 1.3 Would-have-searched-here log (stage 1)

- None: reading and quotation only.

## Stage 2 — SAVED (questions 1 and 2)

### 2.0 Verdicts

- **Question 1 — row 123's lower bound: it runs one colour class at a time.** Every step through the density bound transcribes to a single
  translation- and rotation-invariant random independent set, with the same proofs. The colour count enters at exactly one load-bearing
  step, the last one — the pigeonhole that turns a per-class density bound into "no four-colouring". Verbatim, in its two derivations:
  - X25B-T (`plans/FS100-X25B-derivation.md`): "its classes `I_j` are stationary, a.e.-independent (Fubini on `P(c̃(x) = c̃(x+w)) = 0`), with
    `Σ_j P(0 ∈ I_j) = 1`, so `max_j P(0 ∈ I_j) ≥ 1/4`";
  - J28D §3.3 (`plans/FS86-R88-D-derivation.md`): "the count reads `1 = Σ_j p_j ≤ 4 max(α(Y′), r_X) < 1`".

  Earlier steps *mention* the simplex and a second class, but not load-bearingly: the spectral measure is defined through the tetrahedral
  embedding (J45 §1.2), SI-1 uses "`C(u) = −1/3` because `c` is proper surely", and SI-4 selects a colour from a support ("`c′ = f ∘ M` is
  a.s. a proper four-colouring"). Per class these become `P(0 ∈ I, u ∈ I) = 0` and the support set `J = {p > 0}`, with the same conclusions.
  **The per-class theorem it proves is FS103-F-FRAC (2.3).** Its bound is `max(m₁(ℝ²), sup_v r_v)` at every density; row 123's five is
  that bound's reciprocal rounded up (2.5).
- **Question 2 — T-J39-3's forward direction: steps 1–5 run per class; step 6 does not, as a construction.** Step 6, the mixing selection
  that deletes the thick places, uses the colour count to make the selection total. Verbatim:
  - BC's L5: "(some `j` has `m_K(P_j(x)) ≥ 1/k > ϑ`)";
  - T-J39-3 step 6: "Choose the threshold `θ′` uniformly in `(λ*/(1+λ*), 1/k)`".

  **Per class, the selection is still proper but loses density.** At density `δ`, with a threshold `ϑ` in `[λ*/(1+λ*), δ)`, it gives an
  independent set of density at least `(δ − ϑ)/(1 − ϑ)`, not `δ`. The density-preserving per-class form of step 6 is Zhang's count in
  stationary form (X25B-PZ), with the thick factor's Hoffman ratio `λ*/(1+λ*)`. So **a place is thick at density `δ` iff
  `λ*_v < δ/(1−δ)`** (equivalently `λ*/(1+λ*) < δ`), which is `1/(k−1)` at `δ = 1/k`. The per-class forward direction is FS103-F-TJ
  (2.4).
- **The extension R88-TC-ext runs per class unchanged** (2.2, FS103-F-EXT).
- **The controls of 1.2, scored:** all pass, none for a wrong reason (2.6). The per-class bound reproduces the known truth where it is
  known: `1/4` at K, `2/7` at ℚ(√11), `1/3` at ℚ(√3). **No control can reach MR, which carries the whole weight** (2.6, last row).

### 2.1 The per-class SI (J45's SI-1 to SI-4 with one class)

**FS103-F-SI [hand; J45 SI-1–SI-4 transcribed].** Setting:
- `F` a real number field, `S` a finite set of split places, `μ` a translation-invariant law of a random independent set `I` of `Cay(R, U)`;
- `g = 1_I(0) ∈ L²(μ)` with spectral measure `σ_g` on `R̂`, so `σ̂_g(y) = P(0 ∈ I, y ∈ I)`;
- `𝒜_S` J45's `E_S`-factor, `p(x) = P(x ∈ I | 𝒜_S)` (versions chosen as in J45 §2.2, `p(x) = p(0) ∘ T_x`).

Then for every `u ∈ U`: `∫_{R̂∖E_S} χ(u) dσ_g = −E[p(0)p(u)] ≤ 0` (and it is real). Equality holds iff a.s. `p(x)p(x + u) = 0` for every
`x ∈ R`. If equality holds at every `u ∈ U`, then `J := {x : p(x) > 0}` is, almost surely:
- an independent set;
- `𝒜_S`-measurable and translation-equivariant;
- with `J ⊇ I`, so `P(0 ∈ J) ≥ P(0 ∈ I)`.

*Proof.* Split `g = Πg + (1 − Π)g`, with `Π = Π(E_S) = E[· | 𝒜_S]` (J45-N2). `Π` commutes with the translations `V_u`, so
`0 = P(0 ∈ I, u ∈ I) = ⟨V_u g, g⟩ = ⟨V_u Πg, Πg⟩ + ∫_{R̂∖E_S} χ(u) dσ_g`. Here `0 = …` is independence at the edge `(0, u)`, the place
where the colouring's "`C(u) = −1/3`" stood. The first term is `E[p(u)p(0)] ≥ 0`, which proves the identity and its sign. The
equality case: `p ≥ 0`, and stationarity carries it to every `x`; `R` and `U` are countable.

`J ⊇ I`: `P(x ∈ I, p(x) = 0) = E[1[p(x) = 0] p(x)] = 0` (J45's SI-2, same line). `J` is a function of `p`, which is `𝒜_S`-measurable,
and `J(x + y) = J(x) ∘ T_y` by the choice of versions. ∎

*No second class, no count:* `J` is the support set itself, and `J ⊇ I` comes from SI-2, not from a pigeonhole (WR-1 avoided). If `μ` is
`R ⋊ U`-invariant, `σ_g` and `E_S` are `U`-invariant (BC's L2: `σ_{ρ_u f} = (u⁻¹)_* σ_f` and `ρ_u g = g`), so the integral does not depend
on `u`: strict at one `u` means strict at every `u`.

### 2.2 The per-class extension (R88-TC-ext with one class)

**FS103-F-EXT [hand; R88-TC-ext's proof, J28D C1–C3, with `{0, 1}` in place of `{e_j}`].** Let `J` be a translation-invariant random
independent set of `Cay(R, U)` whose indicator `1_J(0)` has spectral measure carried by `T + A`. Put `G_∅ = (L ⊗ ℝ) × ∏_{stable w} O_w`,
with `R` dense in it (Lemma C′'s scope: `R = O′`), and let `T_∅` be the closure of `U` in `G_∅`, the full product of the local circles
(X25B-W). Then `J` extends to a random set `J̃` of `G_∅` which is:
- `G_∅`-stationary, continuous in probability, and jointly measurable;
- equal to `J` on `R` a.s., so `P(0 ∈ J̃) = P(0 ∈ J)`;
- a.s. a.e.-independent in `Cay(G_∅, T_∅)`: `P(x ∈ J̃, x + w ∈ J̃) = 0` for every `x` and every `w ∈ T_∅`.

*Proof.* `P(1_J(0) ≠ 1_J(y)) = ‖V_y f − f‖²` for `f = 1_J(0)`. By J45-N2 this tends to 0 as `y → 0` in the topology of `G_∅` exactly
when `σ_f` is carried by `T + A`. Uniform continuity in probability (stationarity) extends the finite-dimensional laws to `G_∅`, and
Doob–Cohn gives a jointly measurable version. `w ↦ P(0 ∈ J̃, w ∈ J̃)` is continuous and vanishes on `U`, hence on `T_∅`; Fubini against
`Haar × ν` gives a.e.-independence. ∎ This is J28D's C1–C3 word for word with the one-point function `P(c(0) ≠ c(y)) = 3(1 − C(y))/4`
replaced by `2(P(0 ∈ J) − P(0 ∈ J, y ∈ J))`.

### 2.3 Question 1: the per-class theorem

**FS103-F-FRAC — the fractional local–global principle, given MR [hand; one mind (this job); a composition of held lemmas each already per
class in its proof].** Let `F` be a real number field with `R_F = O′` (row 100's scope). Define:
- `r_v` = the all-levels independence ratio at a stable place `v`: the measurable independence ratio of its compact local plane, equal to
  `sup_k α(G_{v,k})/|G_{v,k}|` by X25B-L1 and pullback;
- `m₁ = m₁(ℝ²)`;
- `ρ(F) = max(m₁, sup_v r_v)`. The supremum is a maximum: by Weil and the two-point bound, `r_v ≤ w/(1 + w)` with `w = 2√q/(q+1) → 0`.

**Then, given MR(F):** every `R ⋊ U`-invariant random independent set `I` of `Cay(R, U)` has `P(0 ∈ I) ≤ ρ(F)`. Consequently:
- **`α₁(F²) = α_inv(F²) = ρ(F)`.** Here `α₁(F²)` is the infimum of `α(G)/|G|` over finite unit-distance graphs `G` with vertices in
  `F²`, and `α_inv(F²)` is the supremum of `P(0 ∈ I)` over `R ⋊ U`-invariant random independent sets.
- **Unconditionally:** an `R ⋊ U`-invariant random independent set of density `> ρ(F)` gives an SP witness over `F`, so MR(F) fails.

*Proof (the steps of row 123's chain, one class each).*
1. *(Følner: `α_inv(F²) ≥ α₁(F²)`.)*
   - Let `B_n ⊂ R` be a Følner sequence of the countable abelian group `R`, and `I_n` a maximum independent set of the induced (finite,
     unit-distance) graph on `B_n`.
   - Put `μ_n = |B_n|⁻¹ Σ_{y∈B_n} δ_{I_n − y}` on `{0,1}^R`. Each `I_n − y` is independent in `Cay(R, U)`, and
     `μ_n{0 ∈ I} = |I_n|/|B_n| ≥ α₁(F²)`.
   - A weak-* limit is translation-invariant (Følner) and keeps `P(0 ∈ I) ≥ α₁(F²)`.
   - Average its rotations `v_*μ` over Følner sets of the abelian group `U`. Rotations about 0 fix the event `{0 ∈ I}` and conjugate
     translations to translations, so the limit is `R ⋊ U`-invariant with the same density.

   (Replaces SP-Cor's "If `X₄(F) ≠ ∅` … take an invariant `μ`"; WR-4's direction.)
2. *(`U`-invariance.)* For an `R ⋊ U`-invariant `I`, `σ_g` is `U`-invariant (2.1's last paragraph; SP-Cor's "`C(vy) = C(y)`"). WR-5 avoided.
3. *(R-U, colouring-free.)* `σ_g(E ∖ (T + A)) = 0` (J45-RU).
4. *(MR.)* `τ := σ_g|_{R̂∖E}` is finite, positive, `U`-invariant and `E`-null, so `τ = a·Haar`. Then
   `∫_{R̂∖E_∅} χ(u) dσ_g = ∫ χ(u) d(a·Haar) = 0` for `u ≠ 0`.
5. *(Per-class SI at `S = ∅`.)* By FS103-F-SI, equality holds at every `u`, so `J = {P(x ∈ I | 𝒜_∅) > 0}` is an independent set, with
   spectrum on `T + A`, `J ⊇ I`, and `P(0 ∈ J) ≥ P(0 ∈ I)`. (Replaces A⁺'s appeal to SI-4.)
6. *(Extension.)* FS103-F-EXT gives `J̃` on `G_∅`, a stationary a.e.-independent set with `P(0 ∈ J̃) = P(0 ∈ J)`.
7. *(Per-class T-C(A), the count without the sum.)* This is X25B-T's chain, which is already per class:

   `P(0 ∈ J̃) ≤ r(G_∅) ≤ sup_k r(ℂ^{r₁} × Y_k) ≤ max(r(ℂ^{r₁}), sup_k r(Y_k)) ≤ max(m₁, sup_v r_v)`.
   - The steps use X25B-L1, then X25B-PZ (Zhang's count in stationary form, "`r(G × H) ≤ max(r(G), r(H))`"), then `r(ℂ, S¹) ≤ m₁`, iterated
     over the real places.
   - A complex place enters through its compact real form, ratio `≤ m₁` (FS100-CX).
   - J28D's C5 is the same count ("`p_j ≤ ¼(1 − β_j) + r_X β_j`" per colour `j`; with no tight factor, `α(Y′)` in place of `¼`).

   **The sum `Σ_j p_j = 1` is never formed.**
8. *(Equality.)* `α_inv(F²) ≥ ρ(F)`:
   - At the real place: pull back a periodic measurable 1-avoiding set of density near `m₁` along one real embedding, with a uniformly
     random translate and rotation.
   - At a stable place: pull back a maximum independent set of the level-`k` plane, with a random translate.

   The same maps give every finite subgraph `G` of `F²` the bound `α(G) ≥ ρ(F)·|G|`. Averaging translates of a measurable set is the
   argument of `[MatolcsiEtAl2025]`'s (14) (their `m₁ ≤ α₁`); residue maps are homomorphisms (row 52). So
   `ρ ≤ α₁(F²) ≤ α_inv(F²) ≤ ρ`.
9. *(Unconditional form.)* Without MR, step 4 can fail only with `∫_{R̂∖E_∅} Re χ(1) dσ_g < 0` (by 2.1 the integral is `≤ 0` and constant in
   `u`), and then `τ` is an SP witness (J45 SP-oi). ∎

### 2.4 Question 2: T-J39-3 per class

**FS103-F-TJ [hand; one mind; T-J39-3 with Zhang's count in place of the mixing selection].** Let `F` be totally real, outside row 100's
exception, and `0 < δ < 1/2`. Define:
- `N_δ(F)` = the stable places with `λ*_v ≥ δ/(1−δ)`, the places that are **not `δ`-thick**;
- `Y_{F,δ} = UD(ℝ²) × ∏_{v ∈ N_δ(F)} G_v`.

**Forward:** if `F²` carries an `R ⋊ U`-invariant random independent set of density `δ`, then **either (A_δ)** `r(Y_{F,δ}) ≥ δ`,
equivalently `max(m₁, max_{v ∈ N_δ} r_v) ≥ δ`, **or (B)** an SP witness exists over `F`.

**Conversely:** (A_δ) gives, for every `ε > 0`, such sets of density `≥ δ − ε`, by pullback along `R → Y_{F,δ}` (BC's L4).

*Proof.* Steps 1–7 of FRAC, without assuming MR; step 4 either gives (B) or equality. In the count, put the `δ`-thick places into one
compact factor `K`. `K`'s characters are finitely supported, so `λ*(K) ≤ max_{thick} λ*_v` (BC's L6). The measurable Hoffman bound
(`[BachocEtAl2014]` Thm 2.2) gives `r(K) ≤ λ*(K)/(1 + λ*(K)) < δ`. X25B-PZ then gives `δ ≤ max(r(Y_{F,δ}), r(K))`, so
`r(Y_{F,δ}) ≥ δ`. The identity `r(Y) = max(m₁, max_{N_δ} r_v)`: `≤` by PZ; `≥` by pulling back along the projections. ∎

**What step 6 of T-J39-3 does per class, and why it is not the right tool.** BC's L5 with one class:
- `P(x) = {a ∈ K : (x, a) ∈ J̃}`, and `ψ(x) = 1[m_K(P(x)) > ϑ]`, with `ϑ` uniform on `[λ*/(1+λ*), δ)`.
- `ψ` is a.s. independent at each fixed edge (the same mixing lemma, one class), stationary, and continuous in probability
  (`P(ψ(x) ≠ ψ(y)) ≤ E|m(x) − m(y)|/|I|`).
- But `E m = δ` gives only `P(ψ = 1) ≥ (δ − ϑ)/(1 − ϑ)`. With `k` classes the selection loses nothing only because every `x` has some
  class above `1/k`; that is the count.

So in T-J39-3 the colour count is load-bearing for the **construction** of a CP colouring of `Y`, and only there. For the **ratio**, PZ
suffices and is per class.

### 2.5 What row 123 is, read through FRAC

At a field in row 123's class, `ρ(F) < 1/4`: CLS gives every stable `r_v < 1/4`, and `m₁ ≤ 0.246989`. Every colour class of a `k`-colouring
is an `R ⋊ U`-invariant random independent set when the colouring's law is, and some class has density `≥ 1/k`. So row 123's lower bound is

`χ(F²) ≥ ⌈1/ρ(F)⌉`, which is `≥ 5` exactly when `ρ(F) < 1/4`.

**The integer five is the ceiling of a fractional bound near 4.05.** Two readings follow:
- Row 123 **cannot be pushed to six by this route**: `1/ρ(F) ≤ 1/m₁ ≤ 1/0.22936 = 4.36 < 5` at every field. This is G60's cap
  ("it can never prove more than five colours"), now reached from the MR side.
- G24's "the step to seven is integrality" has a twin at five. Integrality does not supply the five's *content* (FRAC does); it supplies
  only the rounding up. Any six must come from integrality beyond `⌈χ_f⌉`: for FS-103, from the construction step (L5, PL), never from
  densities.

### 2.6 The controls, scored

| control | FRAC says | the truth | verdict |
|---|---|---|---|
| CTL-K | `ρ(K) = max(1/4, m₁, …) = 1/4`. K's two stable dyadic places are inert in `K(i)/K` with target `𝔽₄`/`μ₃` = `K₄`, tight at `1/4` at every level (row 67); K is outside row 100's exception, so MR(K) is in row 120's scope and FRAC applies | `α₁(K²) = 1/4` (`χ_f(K²) = 4`, G60; `[Ducz2026]`) | **pass**; no place removed, no threshold used (WR-7 moot for FRAC; strict in TJ, where `K₄`'s `λ* = 1/3` is not `< (1/4)/(3/4)`) |
| CTL-11 | `ρ = max(2/7, 1/4 (dyadic, `ℚ₂(√11) = ℚ₂(√3)`, tight — row 93's "every unramified quadratic dyadic tower containing √3"), …) = 2/7` | `α₁ ≥ 2/7` by the pullback from `Γ₇`, `≤ 2/7` by FRAC | **pass** (consistent; no independent upper bound to compare) |
| CTL-√3 | `ρ(ℚ(√3)) = 1/3` (the stable place above 3, `Γ₃`) | `1/3` (triangles; a three-colouring) | **pass** |
| CTL-EXC | out of scope (MR not claimed at ℚ(√5)); its dyadic factor would read Hoffman `1/2` anyway | `1/2` | **pass** (no overreach) |
| CTL-ℤ[√2] | the analogue bound is `max(measurable < 1/2, torsion parity 1/2) = 1/2` | `1/2` | **pass**: the finitary–measurable gap is carried by a torsion character, the same way K's gap (`1/4 > m₁`) is carried by its dyadic place |
| CTL-DV | `α₁(ℝ²) ≤ ρ(F)` for every `F` with MR(F); `ρ(F) ≥ m₁ ≥ 0.22936` | `α₁(ℝ²) < 1/4` (`[DuczVarga2026]`) and `α₁ ≥ m₁` | **consistent** |
| WR-1 … WR-7 | each checked against 2.1–2.4: the support set, no sum, `m₁` on a Doob version (X25B-T's density-point step), Følner in the right direction, `R ⋊ U` throughout, all-levels ratios (X25B-L1), strict thickness | — | none fired |
| **the limit of every control** | the controls check the arithmetic of `ρ` and the per-class logic. **They cannot check MR**, and FRAC is exactly as strong as MR: without it, branch (B) | — | FRAC makes MR testable by finite graphs (stage 3) |

### 2.7 Would-have-searched-here log (stage 2)

- None. The one computation is `tools/fs103_f_places.py`: the stable places of ℚ(√635087) and ℚ(√2351) and their Weil–Hoffman bounds, a
  Legendre-symbol list over a range the derivation fixed, in seconds. It is filed with stage 3.

## Stage 3 — SAVED (question 3: the consequence, its links, what it contradicts; proposals)

### 3.0 Verdicts

- **Per class, given MR:** `α₁(F²) = ρ(F)` at every real number field outside row 100's exception (FRAC). At a field whose stable places
  all have ratio below Croft's `0.22936`, `ρ(F) = m₁(ℝ²)`.
- **Hence, given MR at one such field** (ℚ(√635087), FS-103's headline field), `α₁(ℝ²) = m₁(ℝ²)`. That is **the first clause of
  `[DuczVarga2026]`'s Conjecture 1**, "f (n)/n = m1 (R2 ) + o(1)". It also answers `[MatolcsiEtAl2025]` §2's open question ("it is not
  known whether equality holds") with `χ_f,0(ℝ²) = χ_f(ℝ²) = 1/m₁(ℝ²) ≥ 4.04876`. The grade is [hand], one mind, conditional on MR (row 120).
- **It contradicts nothing in print that still stands.** `[MatolcsiEtAl2025]`'s Conjecture 1 fell to `[DuczVarga2026]` in June 2026.
  What FRAC contradicts, given MR, is two published *readings*: MRVZ's and Ambrus et al.'s expectation that the measurable and finitary
  ratios differ (3.3).
- **The three links** hold as needed (3.4). `m₁` bounds a CP stationary independent set through a measurable version: Theorem 1 of
  `[AmbrusEtAl2023]` covers every measurable set, so their Lemma 1's periodicity is never needed.
- **The owner's three possibilities:**
  1. *Integrality at a named step:* yes — only the terminal pigeonhole, and it rounds up, it does not bound.
  2. *A refutation of a published conjecture, given MR:* the conjecture was already refuted in print, and the live content is a
     conditional **proof** of Dúcz–Varga's replacement conjecture.
  3. *An error in a [hand] result:* none found. FRAC makes MR testable by finite graphs (3.5).

### 3.1 The fields (FS103-F-PL) [tools exact]

`tools/fs103_f_places.py` computes the stable places, with exact Legendre symbols:
- An odd `p` is stable iff `p ≡ 3 (mod 4)` and `(d/p) ∈ {0, 1}`.
- The dyadic place is not stable when `d ≡ 7 (mod 8)`: `F_v = ℚ₂(√7) = ℚ₂(i)`.

For each stable place it bounds the all-levels ratio by `h(q) = w/(1 + w)`, with `w = max(2√q, 2)/(q+1)`: Weil at level one, the two-point
bound at new levels (X26B-L1), and the measurable Hoffman bound. It bounds the tail beyond 1000 by `h` at the next prime `≡ 3 (mod 4)`.

| field | first stable places (all split; plus the ramified `d`) | `max h` | outputs |
|---|---|---|---|
| ℚ(√635087) | 103, 107, 127, 163, 191, … (42 below 1000); 635087 ramified (`h = 0.0025`) | **`0.16330`** (at 103) | `data/fs103/fs103-f/places-635087.out`, exit 0 |
| ℚ(√2351) | 47, 67, 71, 83, 139, …; 2351 ramified | **`0.22219`** (47, Weil; the exact spectrum gives `0.2111`) | `places-2351.out`, exit 0 |

- **Plants:** `PLANT=1` swaps in `d = 47` and must fail because 11 is stable (`h = 0.35599 > 0.22936`); it exits 1 for that reason
  (`places-plant1.out`). `PLANT=2` breaks Euler's criterion; the Legendre self-test fires with exit 1 (`places-plant2.out`).
- **Cross-check:** ℚ(√635087)'s list agrees with the claims list's C-635-PL ("its usable places are 103, 107, 127, 163, 191, …").
- **Scope:** the tool does not check the ratios at the certificate level beyond Weil and Hoffman; it does not need to, since every value is
  below `0.22936 ≤ m₁`.

### 3.2 The consequences, as theorem statements

**FS103-F-DV [hand + tools exact; one mind; given MR(ℚ(√635087)), row 120's scope].**

`α₁(ℝ²) = m₁(ℝ²)`. Equivalently `f(n)/n → m₁(ℝ²)`, where `f(n)` is the least independence number of an `n`-point unit-distance graph in the
plane. Hence `χ_f,0(ℝ²) = χ_f(ℝ²) = 1/m₁(ℝ²) ∈ [1/0.246989, 1/0.22936] = [4.04876, 4.35987]`.

*Proof.*
1. By 3.1, `ρ(ℚ(√635087)) = max(m₁, ≤ 0.16330) = m₁`, since `m₁ ≥ 0.22936` (Croft).
2. FRAC gives `α₁(ℚ(√635087)²) = m₁`. So `α₁(ℝ²) ≤ α₁(ℚ(√635087)²) = m₁ ≤ α₁(ℝ²)`: the infimum over more graphs is smaller, and
   `[MatolcsiEtAl2025]` (14) gives `m₁ ≤ α₁`.
3. `lim f(n)/n = α₁(ℝ²)`: `f(n) ≥ α₁ n` always; far-apart disjoint copies of a near-optimal graph, padded by fewer than `|G|` points, give
   the other side.
4. `χ_f,0 = 1/α₁` is `[MatolcsiEtAl2025]` Theorem 2. For `χ_f`: translates of a periodic measurable 1-avoiding set of density `m` form a
   fractional colouring of weight `1/m` (the argument behind their bound (13), `χ_f ≤ 1/δ_Croft`). `m₁` is approached by periodic sets
   (`[AmbrusEtAl2023]` §2, citing [deOV10, KeMOR16]), so `χ_f ≤ 1/m₁`. With `χ_f,0 ≤ χ_f`, both equal `1/m₁`. ∎

*The same at every `F` outside row 100's exception whose stable places all have `r_v ≤ m₁` (ℚ(√2351), ℚ(√167), …). ℚ(√635087) is chosen
because FS-103 already needs MR there.*

**FS103-F-TF [hand; one mind; given MR(ℚ(√635087))].** For every `ε > 0` there is a finite unit-distance graph **without triangles** whose
independence ratio is at most `m₁(ℝ²) + ε ≤ 0.24699 + ε`, so its fractional chromatic number is at least `4.0487 − O(ε)`.
- *Proof:* FRAC's `α₁(ℚ(√635087)²) = m₁`. The plane over ℚ(√635087) has no unit triangle, since `√3 ∉ F` (G57, `[Krebs2022]` Lemma 5.1).
- *Reading:* triangle-freeness does not raise the plane's finitary independence ratio. Every graph of `[DuczVarga2026]`'s blow-up contains
  triangles: its field holds `ω₁ = ζ₆`.

**FS103-F-47 [hand + cert; one mind; given MR(ℚ(√47)), row 121's own hypothesis].** With only held certificates,
`α₁(ℚ(√47)²) ≤ max(0.246989, 0.2331 (11, FS-66), 0.2147 (19), 0.18523 (23), 1/4 − 2.745·10⁻⁶ (31, Hoffman), 0.21376 (43, Hoffman),
0.2222 (47 ramified, Weil), Weil beyond) = 1/4 − 2.745·10⁻⁶`. So some finite triangle-free unit-distance graph over ℚ(√47) has
`χ_f ≥ 4.0000439`.
- This is **weaker than** `[DuczVarga2026]`'s `4.0007` (theirs is unconditional).
- The binding place is 31. There, Hoffman misses `1/4` by `2.7·10⁻⁶` (J28V-3's table), while the level-one ratio is probably near `0.15`
  (G59's `c(31) = 0.846`, a found set). A certificate of 31's all-levels ratio below `0.247` would lift ℚ(√47) to FS103-F-DV's bound. That
  certificate is a machine-long relaxation, out under the ban; logged.

### 3.3 `[MatolcsiEtAl2025]` §§1–3, and what exactly FRAC would contradict

**Read** (this job; 2026-09-26): §1 (the introduction, including "we are tempted to conjecture that this bound cannot be testified by any
finite graph"); §2 (the definitions of `χ_f(ℝ²)`, `χ_f,0(ℝ²)`, `α₁(ℝ²)`, `m₁(ℝ²)`, (12)–(14)); §3 (Theorem 1 with its Følner proof,
Theorem 2 with its discrete-cube proof, and "The significance of Theorem 2"); and Conjecture 1 at the end of §4. Given MR at ℚ(√635087),
each claim fares as follows:

| their statement, verbatim | status |
|---|---|
| "Conjecture 1. χf,0 (R2 ) = 4, and for all finite unit distance graphs G ⊆ R2 we have χf (G) < 4." | **false, in print** (`[DuczVarga2026]` Thm 1, Cor. 1). Given MR, false by a margin: `χ_f,0 = 1/m₁ ≥ 4.0487` |
| "(14) 0.22936... = δCroft ≤ m1 (R2 ) ≤ α1 (R2 ) ≤ 1/4 … we conjecture that the following equalities hold: δCroft = m1 (R2 ) and α1 (R2 ) = 1/4" | the second equality is false in print (DV). **Given MR, the middle inequality `m₁ ≤ α₁` is an equality**, the one place the chain has content. The first equality is untouched |
| "It is clear that χf,0 (R2 ) ≤ χf (R2 ), but it is not known whether equality holds." | **given MR: equality** (FS103-F-DV) |
| "if Conjecture 1 turns out to be true, we obtain the following very interesting property … α1 (R2 ) ̸= m1 (R2 ), i.e. the finitary independence ratio and the measurable independence ratio of R2 do not agree" | the hypothesis is false (DV); the conclusion is **false given MR** |
| `[AmbrusEtAl2023]` §4 Remark: "… providing an interesting example of a natural infinite graph for which the measurable and the non-measurable variants of a parameter have different values" | **false given MR**: the fractional variants agree |
| `[DuczVarga2026]` §2.1: "Conjecture 1. f (n)/n = m1 (R2 ) + o(1) and in particular that m1 (R2 ) = δCroft." | **first clause proved given MR**; the second clause untouched |

**Why the published expectation pointed the other way, read through FRAC.** The graphs of Ambrus et al., MRVZ and `[Ducz2026]` live in the
Moser lattice, inside `K²`. There FRAC's `ρ(K) = 1/4`: the dyadic places are tight. So no finite graph in `K²` can go below `1/4`, and
`[Ducz2026]`'s "the entire Moser lattice is geometrically integer 4-colorable" is the same fact.
- The finitary–measurable gap they saw is the **dyadic place's**, a torsion phenomenon of one field.
- It is not a property of `ℝ²`. It disappears in any field whose places are all below `m₁`, and there FRAC says the finitary ratio *is*
  `m₁`.
- `[DuczVarga2026]` needed a point outside `K`, and "such augmentations are exceedingly rare". In FRAC's terms, they had to leave the
  field whose dyadic place pins `1/4`.
- This is CTL-ℤ[√2]'s mechanism in the plane.

### 3.4 The three links, each on its own

1. **`m₁(ℝ²) ≤ 0.2470` bounds a stationary random independent set continuous in probability.** It holds, by the route FRAC uses:
   - Doob–Cohn gives a jointly measurable version.
   - The reverse Fatou lemma (`E[limsup_R avg_{B_R} 1_W] ≥ P(0 ∈ W)`) gives a realisation of upper density `≥ P(0 ∈ W)`.
   - Its Lebesgue density points are a genuinely 1-avoiding measurable set with the same density (X25B-T; R88-TC-reg).
   - `[AmbrusEtAl2023]` Theorem 1 then applies as printed: "Any Lebesgue measurable, 1-avoiding planar set".

   **It needs no more than that.** Their Lemma 1 is stated for "a measurable, periodic, 1-avoiding set A", and its atoms are exactly the
   finite-dimensional probabilities of a randomly translated periodic set. So the owner's reading is right in substance. But a direct route
   through Lemma 1 for a non-periodic stationary process would need their §5 Fourier step redone for a continuous positive-definite `f`
   with non-discrete spectral measure (Bochner). That route is not needed and not checked here. Several real places: `UD(ℝ²)^{×n}` has
   ratio `m₁` (X25B-PZ iterated; FS100-TCA's C14.3).
2. **The invariant density of an independent set of `F²` is at least `α₁(ℝ²)`** — more exactly, `α_inv(F²) ≥ α₁(F²) ≥ α₁(ℝ²)`. It holds:
   - The Følner averaging of maximum independent sets of finite pieces is FRAC step 1, then rotation averaging.
   - The second inequality is monotonicity of an infimum.
   - This is the direction FRAC needs (WR-4). The reverse (`α₁(F²) ≥ α_inv`) is false in general and never used.
3. **Fractional colouring passes to finite subgraphs.** It holds, with no compactness:
   - `α₁(F²) ≤ ρ` gives finite graphs with `α(G)/|G| ≤ ρ + ε`.
   - Then `χ_f(G) ≥ |G|/α(G)` (MRVZ's (12)).
   - The statement about `χ_f,0` is MRVZ's Theorem 2.
   - The infinite graph's `χ_f` enters only in FS103-F-DV's last line, through the measurable upper bound.

### 3.5 Where this leaves MR, and FS-103 (proposals; I edit none of these files)

- **A new killing test for MR (G80, row 120):** any proof that `α₁(ℝ²) > m₁(ℝ²)` refutes MR at ℚ(√635087), by FRAC's unconditional form.
  So does any lower bound `α₁(ℝ²) ≥ c` with `c > 0.246989` — for instance a non-measurable averaging argument. So does, at a field `F`, a
  finite-graph proof that `α₁(F²) > ρ(F)`. Before this job, MR's only consequences were five-colour statements, falsifiable only by
  colourings of whole planes. **Now it has a consequence about finite graphs**, a published conjecture of the people best placed to test
  it. That is a reason to check MR harder, not a confirmation of it.
- **FS-103's F1 (the collapse) has a fractional shadow that is free given MR:** `χ_f(ℝ²) = χ_f,0(ℝ²) = 1/m₁ = the CP fractional number`.
  It needs neither T-J39-3's selection nor any product lemma (PL). It cannot reach six (2.5). So F1's content at six lies entirely in the
  integral steps: the construction in BC's L5 and product colourability. That is where the verifiers' GAPs, if any, will be.
- **Proposed `LEDGER.md` row** (after a second, blind mind): "The fractional local–global principle, given MR: `α₁(F²) = max(m₁(ℝ²),
  sup_v r_v)` for every real number field outside row 100's exception; at ℚ(√635087), `α₁(ℝ²) = m₁(ℝ²)`, the first clause of
  `[DuczVarga2026]`'s Conjecture 1, and `χ_f,0(ℝ²) = χ_f(ℝ²) = 1/m₁(ℝ²)`; triangle-free finite unit-distance graphs reach it." Grade
  [hand], its chain's links graded as above, MR's grade. **Not claimed:** `m₁ = δ_Croft`; any value of `m₁`; anything at six.
- **Grokkings** (the close's):
  - G24: add the five-colour twin — "at five the content is per class; integrality only rounds `⌈1/ρ⌉`" (FS103-F-ROUND).
  - G60: its cap is now reached from the MR side (`χ_f(F²) = 1/ρ(F)` given MR). R-C's `3.48` at ℚ(√167) is superseded given MR:
    `ρ(ℚ(√167)) = m₁`.
  - G80: the killing test above.
  - G50: an instance (below).
- **`CLOSED-QUESTIONS.md`:**
  - `[DuczVarga2026]`'s Conjecture 1, first clause: answered **conditionally on MR** (a new entry).
  - `[MatolcsiEtAl2025]`'s "whether equality holds": likewise.
  - Erdős's `f(n)` asymptotics: `f(n)/n → m₁`, given MR.
  - All three are conditional and one mind: not closed until a second mind and MR's status.
- **`BIBLIOGRAPHY.md` read-status:**
  - `[MatolcsiEtAl2025]`: §§1–3 re-read by FS103-F.
  - `[AmbrusEtAl2023]`: Theorem 1, Lemma 1 and the §4 Remark re-read.
  - `[DuczVarga2026]`: §§1–2.2 re-read; its Conjecture 1 (§2.1) is new to the row.
  - arXiv:1401.7183 (*On the independence ratio of distance graphs*) seen in a search listing only.
- **Stub to mint:** "FS-10x — the fractional collapse". A blind verification of FRAC and FS103-F-DV (two minds), with this record's
  statements quoted verbatim and its proofs fenced; then a prior-art gate on "finitary = measurable independence ratio" under the
  descriptive-combinatorics names ("measurable independence ratio", "Borel fractional chromatic number"). **Bearing on χ ≥ 6: none**
  (2.5). It carries the programme's first statement about finite graphs that is not about four colours.
- **FS-102 (the fallback write-up):** FS103-F-DV is a candidate section. It is conditional on the same MR the write-up already rests on,
  and it answers a conjecture posed in print three months ago.

### 3.6 Prior art for FRAC and FS103-F-DV (searched; not found)

| # | where | query | hits / verdict |
|---|---|---|---|
| z1 | zbMATH | `ab:"independence ratio" & ab:"unit distance"` | 2: MRVZ 2023, DV 2026 (both held, read) |
| z2 | zbMATH | `ab:"1-avoiding" & ab:"finite"` | 7: MRVZ; the rest off topic |
| z3 | zbMATH | `ab:"fractional chromatic number" & ab:"unit distance" & py:2023-2026` | 4: MRVZ, `[Ducz2026]`, DV, one withheld record |
| z4 | zbMATH | `ab:"Hall ratio" & ab:plane` | 1: MRVZ |
| w1 | web | "finitary independence ratio" OR "measurable independence ratio" unit distance graph plane m1 equality 2026 | DV (arXiv, html, Pith review), MRVZ, arXiv:1401.7183 (listing only) — nothing proving `α₁ = m₁` |

Negative, at the scope of five queries (G21). The statement is DV's own conjecture as of June 2026, so a proof of it in print before then
is unlikely, and a proof after it would have to be under three months old. A prior-art gate in descriptive-combinatorics vocabulary is
owed (the stub above).

### 3.7 Would-have-searched-here log (stage 3)

- Would have certified 31's all-levels ratio (a level-two moment relaxation, FS-66's instrument) to lift FS103-F-47 to `4.0487` at
  ℚ(√47). Instead: moved to a field whose places are all below Croft's bound, where no certificate is needed (3.1). The 31 certificate is
  machine-long and out under the ban.
- Would have searched ℚ(√635087)'s plane for a finite graph of independence ratio near `m₁`. Instead: none. FS103-F-DV is existence
  through MR, and the ban forbids the finder.
