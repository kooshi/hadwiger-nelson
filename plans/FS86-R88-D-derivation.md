# Row 88's question — J28D's derivation record (crunch job J28D, de Bruijn, Opus 5.5, 2026-09-25)

*Brief: `data/crunch-2026-09-25/briefs/J28D-row88-derivation.md` (with `STANDING-RULES.md`). Plan: `plans/FS86-row88-rigidity.md` §S.0–S.2,
§M. Targets T-A, T-B1, T-B2, T-C, T-C(A), T-C′ (verbatim in §S.1 there; quoted in §1.1 below). Blind verifier J28V: not read, not messaged.
Data `data/fs86r88/j28d/`; tools `tools/crunch_j28d_*.py`. Grades are `CLAUDE.md` § Notation's.*

## Theorems this phase proved

*(one line each; filled per stage)*

- Stage 1: none (quotation check and priors).
- **T-A (i)–(vi)** — the decomposition, TRUE; (i) with `τ` read as commuting with conjugation (automatic for type (B)); (v) with the clopen correspondence proved in place. [hand] §Stage 2
- **T-A1** — `T-B1 ⟹ Q-tr ⟹ T-B2`. [hand] §Stage 2
- **TC (Theorem C over real S2 fields)** — every translation-invariant random four-colouring whose spectral measure is carried by `T + A + Fin_S` (finite `S`) is a.s. a pullback; route: continuity ⟹ extension to `G_S` ⟹ H*-places absorbed into the tight factor ⟹ stationary Zhang count. [hand, one mind; inputs listed in §3] §3.2
- **TC-Y′** — `O_𝔓 × ∏_{H*} O_v` is Hoffman-tight at four colours with least eigenspace the `𝔓`-minimisers. [hand] §3.2 C4
- **TC-reg** — in a doubling LCA Cayley graph an edge-null set is a.e. equal to an independent set (its density points); so C14.1 holds for edge-null sets with essential neighbourhoods. [hand] §3.2 C4
- **TC-count** — the stationary Zhang count: one tight compact factor `× X` with `r_X < 1/4` forces a.e. fibre to be a proper colouring of the tight factor. [hand] §3.2 C5
- **TC(A)** — over ℚ(√47) (and every real field whose stable places all have all-levels ratio `< 1/4`) no invariant measure on `X₄` has spectral measure on any `T + A + Fin_S`. [hand, one mind] §3.3
- **TC-tab** — the factor table: `B = {11}` (ℚ(√59)), `{19}` (ℚ(√83), ℚ(√131)), `{11, 19}` (ℚ(√47)); every other stable place below 72 satisfies H*. [tools, float with controls and a plant] §3.2
- **B2-1, B2-2, B2-3** — propagation (`D` infinite); `d*(z + kU) = 0` for every `k`; sparse defect ⟹ transient. [hand] §Stage 4
- **T-B1, T-B2** — GAP, steps named. §Stage 4
- **T-A2** — a FALSE for T-B1 or T-B2 exhibits a non-pullback, so `F(R) = 0`. [hand] §Stage 2

## Stage 1 — SAVED (quotation check, C0, the log)

### 1.1 The quotation check (standing rule 5)

| # | quoted in the brief | source | result |
|---|---|---|---|
| Q1 | §S.0's six definitions and §S.1's six statements, with the controls paragraph (34 non-empty lines) | `plans/FS86-row88-rigidity.md` §S.0–S.1 | **verbatim**: `diff` of the brief's block against the plan's block is empty (the two blocks extracted by `awk`, blank lines dropped) |
| Q2 | S2's gloss "real fields with exactly one stable place whose local planes have `χ_f ≤ 4`, that place four-tight at every level" | `plans/FS86-derivation.md` Notation | **verbatim** (the source breaks the line after "stable place") |
| Q3 | J21-MX, "a compact factor with `λ* < 1/(k−1)` can be deleted from a Borel `k`-colouring of a product" (plan §0.3) | `plans/CRUNCH-2026-09-25-INDEX.md` line 560 | **verbatim**; the theorem itself read in `plans/M3-S1D-windows-five.md` §3.2 |
| Q4 | Theorem C "under H*", D's `𝒳 = T + A + Fin` | `plans/FS86-V-D-verification.md` § VD-C (2) | matches; D's proof is the spectral one with weights, **not** the continuity route of §S.2 |
| Q5 | C14 "with `[AmbrusEtAl2023]`'s `m₁ ≤ 0.2470`", C14′ "proper off a null set" | `plans/FS86-C-Coxeter.md` Round 2 step 5; `plans/FS86-derivation.md` §9 | matches; **scope note carried forward**: C14 reads the tight place at finite level `m` only (its "Not covered (1)": infinite depth), and C14′'s format is "`W(z) ≠ W(z+τ)` whenever `z`, `z+τ` both lie in a conull `Ω`" — not the edge-a.e. format a random extension produces (used in §3) |

**One conflict in the instructions, logged:** standing rule 6 says "never push"; the brief and the launching message say "push; never
force-push". I follow the brief (the job-specific instruction, restated by the owner at launch).

### 1.2 C0 — probabilities per claim (written after reading the sources and one mental pass, before any written derivation)

| claim | TRUE | FALSE | GAP | note |
|---|---|---|---|---|
| T-A (i)–(vi) | 0.90 | 0.03 | 0.07 | (v) rests on the Furstenberg-correspondence lemma for clopen cylinders; (i) needs `τ(U) = U` |
| T-C | 0.55 | 0.05 | 0.40 | the plan's step (2)–(3) cannot use C14′ or J21-MX as black boxes (formats differ); a stationary count is needed |
| T-C(A) | 0.50 | 0.05 | 0.45 | tied to T-C's count |
| T-B1 | 0.05 | 0.01 | 0.94 | a FALSE is a non-pullback, i.e. decides row 88 "no" |
| T-B2 | 0.10 | 0.01 | 0.89 | the same: a FALSE decides row 88 "no" |

*Coherence note on the plan's §P (for the owner):* P-TB1 prices FALSE at 0.10 and P-TB2 at 0.15, while P-decide prices "row 88 decided no" at
0.02. A FALSE for either (a converging family of non-pullbacks; a sparse defect) exhibits a non-pullback four-colouring, hence `F(R) = 0` by
the frame — the two sets of numbers cannot both be right.

### 1.3 Would-have-searched-here log (running)

- (stage 1) Would have sampled colourings of lattice balls over ℚ(√59) agreeing with a pullback on a patch, to price T-B1 and T-B2. Not done
  (ban); both are posed as derivations in §4.

## Stage 2 — SAVED (T-A)

*Setting:* `F` as in T-A (the frame holds: `F(R) ∈ {0, P(R)}`, `P(R) = R ∩ 𝔓⁴`, every periodic four-colouring a pullback); `ρ₄ : R → O/𝔓⁴`
the reduction, onto (Lemma R (b); for ℚ(√59) also VD-1); `S₄ = U mod 𝔓⁴ = T mod 𝔓⁴` (`U` dense in `T`). Translation `(t·c)(z) = c(z − t)`.

**Verdict: T-A (i)–(vi) TRUE [hand], with one scope repair in (i).**

**(i) — TRUE, given `τ(U) = U` for every `τ` in the group (automatic for type (B)).** *Finite:* `γ ↦ γ∘ρ₄` is a bijection from the
proper four-colourings of `P₄` onto Pull (`ρ₄` onto), so `|Pull| = 1,179,936` (row 67). *In `X₄`:* `ρ₄(U) ⊆ S₄ ∌ 0`, so every edge maps to an
edge. *Closed:* finite in a Hausdorff space. *Translations:* `t·(γ∘ρ₄) = γ(· − ρ₄t)∘ρ₄`. *Rotations:* `u ∈ U` is a unit at `𝔓` and `uT = T`,
so `x ↦ ρ₄(u)x` is an automorphism of `P₄`. *`τ`:* the action `(g·c)(z) = c(g⁻¹z)` preserves `X₄` only if `g` maps edges to edges, i.e.
`τ(U) = U`. "Preserving `R`" does not obviously give this: `τ(U)` is the norm-one group for `τcτ⁻¹`, equal to `U` when `τ` commutes with `c`.
**Repair (scope):** read `Aff_F`'s `τ` as ranging over automorphisms of `F(i)` commuting with complex conjugation (equivalently, preserving
`U`). For type (B), `Gal(F(i)/ℚ) ≅ V₄` is abelian, so nothing is lost. Such a `τ` maps stable primes to stable primes and tight ones to
tight ones, so it fixes the unique tight `𝔓`, extends continuously to `O`, induces an automorphism of `O/𝔓⁴` preserving `S₄`, and maps
Pull to Pull.

**(ii) — TRUE.** *Subgroup:* `μ{c(0) = c(δ₁)} = 1` and, by invariance, `μ{c(δ₁) = c(δ₁+δ₂)} = μ{c(0) = c(δ₂)} = 1`; so
`δ₁ + δ₂ ∈ F_μ`; `−δ` by invariance. *`U`-stable:* for `u ∈ U` and translation-invariant `ν`, `μ := (u⁻¹)_*ν` is translation-invariant
(`t·(u⁻¹·c) = u⁻¹·((ut)·c)`), and `μ{c(0) = c(δ)} = ν{c′(0) = c′(uδ)}`; so `δ ∈ F_μ ⟹ uδ ∈ F_μ`. Hence an ideal (`R = ℤ[U]`) — §M.1's
point that `Aff_F`-invariance of `μ` is not needed is right. *`F ⊆ F_μ`:* a forced difference holds for every colouring. *`F_μ ⊆ P`:* the
uniform measure on the finite translation orbit of a periodic colouring is invariant and charges each point. *Dichotomy:* if `F_μ ≠ 0` it has
finite index (V2), so every invariant `μ` is a.s. `F_μ`-periodic (countably many `δ`), hence a.s. a pullback (frame); pullbacks identify
exactly `R ∩ 𝔓⁴` (`P₄` is pairwise free, row 67), so `F_μ ⊇ R ∩ 𝔓⁴ = P(R)`, and `F_μ = P(R)`.

**(iii) — TRUE.** ⟹ is (ii)'s dichotomy step. ⟸: every invariant `μ` carried by Pull gives `μ{c(0) = c(δ)} = 1` for `δ ∈ R ∩ 𝔓⁴ ∋ 4`.

**(iv) — TRUE.** ⟹: `F(R) ≠ 0` gives `F(R) = P(R)`, so every colouring is `R ∩ 𝔓⁴`-periodic, hence a pullback: `X₄ = Pull`, and Q-μ holds and
Q-tr is vacuous. ⟸: if `F(R) = 0` then `(0, 4)` is not forced, so some `c` has `c(0) ≠ c(4)`, and `c ∉ Pull`; by Q-tr `c` is not transient, so
some invariant measure on its orbit closure is not carried by Pull, against Q-μ. So **Q-μ ∧ Q-tr ⟺ `X₄ = Pull` ⟺ `F(R) ≠ 0`.**

**(v) — TRUE, given the correspondence lemma (standard; proof included).** *Lemma CL (clopen correspondence):* for a countable abelian group
`R` acting on a compact space, a point `c`, and a clopen `C`, with `V = {t : t·c ∈ C}`: `d*(V) = max{μ(C) : μ` invariant on `O(c)‾}`, where
`d*(V) = lim_n sup_t |V ∩ (F_n + t)|/|F_n|` for a Følner sequence `(F_n)` (the limit exists and is independent of the sequence). *Proof:*
≥ — given `μ` with `μ(C) = a` and finite `F`, `∫ |F|⁻¹Σ_{g∈F} 1_C(g·x) dμ = a`, so some `x ∈ supp μ ⊆ O(c)‾` has average `≥ a`; that set of
`x` is clopen, so some `t·c` lies in it: `|V ∩ (F + t)| ≥ a|F|`. ≤ — pick `t_n` attaining the sup on `F_n`; the averages
`|F_n|⁻¹Σ_{g∈F_n} δ_{(g+t_n)·c}` are asymptotically invariant; a weak-* limit is invariant, lives on `O(c)‾`, and gives `C` the limit value
(`C` clopen). ∎ *Then:* `C_B = {x : x|_B ∉ Pull|_B}` is clopen, and `X₄ ∖ Pull = ⋃_B C_B` over an exhaustion (a colouring all of whose
finite restrictions are pullback restrictions is a pullback: Pull is finite, so one `p` agrees on a cofinal family of `B`). So `μ` is
carried by Pull iff `μ(C_B) = 0` for every `B`, and transience of `c` is `d*{t : (t·c)|_B ∉ Pull|_B} = 0` for every `B`, by Lemma CL.

**(vi) — TRUE.** If `c ∉ Pull` is transient, `O(c)‾` carries an invariant measure (amenability), carried by Pull, so some `p ∈ Pull ∩ O(c)‾`;
`p` isolated means `{p}` is open, so `t·c = p` for some `t`, and `c = (−t)·p ∈ Pull` — a contradiction. So Q-tr. Then (ii)–(iv): `F_μ ≠ 0 ⟹`
Q-μ `⟹ F(R) ≠ 0 ⟹ F = P = F_μ`; `F_μ = 0 ⟹ F ⊆ F_μ = 0`. ∎

**Two consequences recorded (hand, from the above):**
- **T-A1 (the hierarchy).** `T-B1 ⟹ Q-tr ⟹ T-B2`. The first is (vi). For the second: if `D = {c ≠ p}` has `d*(D) = 0`, every invariant
  measure on the orbit closure of the pair `(c, p)` in `X₄ × Pull` is carried by the diagonal (`λ{x(z) ≠ q(z)} ≤ d*(D) = 0` for each `z`), and
  invariant measures on `O(c)‾` lift to it, so `c ∈ Pull` or `c` is transient; under Q-tr, `c = p′ ∈ Pull`, and `{p′ ≠ p}` is a union of
  cosets of the finite-index `R ∩ 𝔓⁴`, so `d* > 0` unless `p′ = p`.
- **T-A2 (FALSE decides the question).** A FALSE for T-B1 (non-pullbacks converging to `p`: a converging sequence in the finite Pull is
  eventually constant) or for T-B2 (a sparse defect: `c ∈ Pull` would make `D` a union of `R ∩ 𝔓⁴`-cosets) exhibits a colouring outside
  Pull, so `F(R) = 0`. This is the coherence note of §1.2.

**Controls (P-controls) read against T-A.** *ℚ(√11):* outside T-A's hypotheses — the frame's "every periodic colouring a pullback" fails
(periodic non-pullbacks exist there, FS86-VX-11 and `Γ₇`); C9's `⌊4(θ + s)⌋`, `s` uniform, is an invariant measure not carried by Pull
(non-periodic for every `s`), so Q-μ fails there, as the plan says. *K:* two tight places; with Pull read as the union of the two places'
pullbacks, `X₄ = Pull` per coset (VK), and both halves hold. *ℚ(√2,√3):* in S2 (frame argued, row 93) and rigid given T721, so `X₄ = Pull`.
**P-controls met.**

### Would-have-searched-here log (stage 2)
- None: T-A is soft dynamics.

## Stage 3 — SAVED (T-C and T-C(A))

**Verdicts. T-C: TRUE [hand, one mind], at the stated scope and on all of S2. T-C(A): TRUE [hand, one mind].** Inputs, by name:
`[AmbrusEtAl2023]` Thm 1 (`m₁(ℝ²) ≤ 0.2470`, through C14.2 (a); external, audited by J26); FS-66's certificates at 11 (ℚ(√59), ℚ(√47)) and 19
(ℚ(√83), ℚ(√131), ℚ(√47)); Lemma P; Lemma D and FS38-D2-B (minimisers of every `P_m` kill `𝔓⁴`); VC-C2; C14.1–C14.4 as window lemmas
(two derivations); weak and strong approximation; Lemma R (b) (or J07's Lemma C) for the continuity of torsion characters; Bochner; Doob–Cohn
(a process continuous in probability on a Polish index space has a jointly measurable modification); Lebesgue differentiation on doubling
metric measure spaces. **Not used:** J21-MX, J21-RED, V3, `[Zhang2012]`, C14's main count or C14′ as black boxes.

### 3.1 Why the plan's route (§S.2) cannot run as written
- **C14 and C14′ do not apply to the extended colouring.** C14 reads the tight place at a finite level `m` ("Not covered (1): infinite
  depth") and finitely many places; C14′'s format is "proper on every edge inside a conull `Ω`". The extension of a random colouring (C2
  below) reads `O_𝔓` at infinite depth and **every** stable place, and is proper only on almost every *edge* (`G_S × T_S`-null), which does not
  give a conull `Ω` (a null set of bad edges can touch every vertex).
- **J21-MX is the wrong tool for this job.** It returns a selected colouring `φ` of the other factors; it says nothing about the structure of
  `c` itself, so deleting factors with it cannot end in "`c` is a pullback".
- **The replacement (§3.2):** spectra where spectra work, counts where they do not. Every stable place with `λ/d > −1/3` at every level (D's
  H*) is absorbed into the tight compact factor, whose least eigenspace does not grow (Lemma Y′). The finitely many places where Hoffman
  fails (11 or 19), the real places and `S` stay in a factor `X` of ratio `< 1/4`, handled by a stationary Zhang count (§3.2 C5) whose inputs
  are C14's window lemmas made a.e. by regularisation.

### 3.2 The proof of T-C (class form)

*Class (TC-class):* `F` real; one stable place `𝔓` whose tower is row 67's (tight at four colours at every level, every minimiser killing
`𝔓⁴`); every other stable place of all-levels independence ratio `< 1/4` (this is S2); `S` a finite set of split places. Type (B) is in it
(factor table below).

**C1 (continuity) [hand].** `G_S := (L ⊗ ℝ) × ∏_{v stable} O_{L_v} × ∏_{v∈S} L_v`, Polish, with `R` embedded diagonally. *Dense:* by strong
approximation for `L` omitting one place above a split place outside `S` — the approximant is integral at every stable place, so lies in
`R` (Lemma R (a)). *Its characters restricted to `R` are exactly `T + A + Fin_S`:* characters of `∏ O_{L_v}` read finitely many coordinates
and are torsion; torsion characters of `R` are continuous for the stable topology (`R ∩ ∏_{𝔔|N} 𝔔^K ⊆ NR`, Lemma C (d); Lemma R (b) for type
(B)). So `σ` is carried by `T + A + Fin_S` **iff** `C(y) = E⟨g(0), g(y)⟩ = σ̂(y)` is `τ_S`-continuous on `R` (⟹ dominated convergence;
⟸ Bochner on `G_S` and uniqueness on `R̂`). Since `P(c(0) ≠ c(y)) = 3(1 − C(y))/4`, **the hypothesis is exactly: `P(c(0) ≠ c(y)) → 0` as
`y → 0` in `G_S`.**

**C2 (extension) [hand + Doob–Cohn].** So `z ↦ c(z)` is uniformly continuous in probability and extends to `G_S`, stationary under `G_S`
(limits of stationary finite-dimensional laws), with a jointly measurable modification `c̃`; `c̃ = c` on `R` a.s. (`R` countable).

**C3 (a.e.-proper) [hand].** `T_S := ∏_v T(F_v)` over the real, stable and `S` places is the closure of `U` in `G_S` (weak approximation,
CLG-c (W)). `C̃` is continuous and `= −1/3` on `U`, so for every `x ∈ G_S`, `w ∈ T_S`: `P(c̃(x) = c̃(x + w)) = (1 + 3C̃(w))/4 = 0`. With `ν_S` a
symmetric full-support probability on `T_S` (Haar at compact factors, equivalent to Haar at split ones), Fubini: **a.s. the monochromatic
edges `{(x, w) : c̃(x) = c̃(x + w)}` are `Haar × ν_S`-null.**

**C4 (the split `G_S = X × Y′`) [hand + tools].** `H` := the stable places `v ≠ 𝔓` with `λ/d > −1/3` for every non-trivial character at every
level; `B` := the other stable places `≠ 𝔓`, finitely many (Weil and Lemma P: `2√p/(p+1) < 1/3` from `p = 37`, `2/(p+1) < 1/3` from 7).
`Y′ := O_𝔓 × ∏_{v∈H} O_{L_v}`, `X := (L⊗ℝ) × ∏_{v∈B} O_{L_v} × ∏_{v∈S} L_v`.
- **Lemma Y′ [hand].** With `ν′ = ⊗` Haar on the local circles, `ν̂′(ξ) = ν̂_𝔓(ξ_𝔓)∏_{v∈H} ν̂_v(ξ_v) ≥ −1/3` for `ξ ≠ 0`, with equality iff every
  `ξ_v` is trivial and `ξ_𝔓` is a minimiser (each factor lies in `[−1/3, 1]`, `H`-factors in `(−1/3, 1)` when non-trivial — `ν̂_v(ξ) = 1` forces
  `ξ = 0` since `⟨T_v − T_v⟩ = O_{L_v}`, VC-C2 — and a product of numbers in `[−1/3, 1]` is `≥ −1/3`, with equality only as stated). So `Y′`
  is Hoffman-tight at four colours with least eigenspace the 45 `𝔓`-minimisers, all killing `𝔓⁴`.
- **Lemma X′ [hand, from C14.2–C14.4].** `X` has ratio `r_X = max(m₁, max_{v∈B} r_v, 0) < 1/4` with error `η_X(n) → 0` in C14's window sense
  (C14.2 (a) real, (b) stable at full level, (c) split; C14.3 products). *Regularisation:* `X` with the max of the factor metrics is a doubling
  metric measure space; if `Z ⊆ X` has `Haar × ν_X`-null edge set, its Lebesgue density points `Z′` form an **independent** set with
  `Z′ = Z` a.e. (if `x, x + s ∈ Z′`, then for `s′ ∈ T_X ∩ B(s, δ)`, `μ(B(x,δ) ∖ (Z − s′)) ≤ μ(B(x + s, 2δ) ∖ Z) ≤ εC_dμ(B(x, δ))`, so the edges
  `(x′, s′)` inside `Z` near `(x, s)` have positive measure). Hence C14.1 holds for **edge-null** sets with the **essential** neighbourhood
  `N_e[Z] := Z ∪ {x : ν_X{s : x + s ∈ Z} > 0}` (**C14.1-e**): `d_n(Z) ≤ r_X d_n(N_e[Z]) + η_X(n)` — C14.1's proof verbatim, since
  `J_t = ((I − t) ∖ N_e[Z]) ∪ Z` is edge-null and edge-null sets obey (R1) through `Z′`.
- **Factor table** (`tools/crunch_j28d_factors.py` → `data/fs86r88/j28d/factors.out`; level one exact-float, controls: H* fails at 7, 11, 19
  and holds at 23, 31, matching B1's table to 9 digits; plant — the split conic — fires on the circle-size assert, exit 1,
  `factors-plant.out`):

| field | `B` (stays in `X`; all-levels ratio) | `H` below 72 (absorbed; `λ_min/d + 1/3` at level one) | `r_X` |
|---|---|---|---|
| ℚ(√59) | 11 (0.2331, FS-66) | 23 (`+1.6·10⁻³`), 31 (`+4.9·10⁻⁶`), 43, 47, 59 ram. (`+8.5·10⁻²`), 67 | `m₁ ≤ 0.2470` |
| ℚ(√83) | 19 (0.2147, FS-66) | 43, 47, 67, 71, ramified 83 (V3ram 0.1741) | `m₁` |
| ℚ(√131) | 19 (0.2147) | 23, 31, 47, 67, 71, ramified 131 (0.1379) | `m₁` |
| ℚ(√47) (T-C(A)) | 11, 19 | 23, 31, 43, 47 ram., 67 | `m₁` |
| ℚ(√11) (control) | **7 (all-levels ratio ≥ 2/7 > 1/4)**, 11 ram., 19 | 43, … | — (fails) |

**C5 (the stationary Zhang count) [hand].** Fix a sample with C3's null set; write `c` for `c̃`, points `(x, b) ∈ X × Y′`, `ν_X, ν_Y` the
factors of `ν_S`. For a colour `j` and `b ∈ Y′`: `X^j_b = {x : c(x, b) = j}`; `x ∈ X^j_b` is **social** if `ν_X{s : x + s ∈ X^j_b} > 0`,
else **lonely**; `X^{j*}_b` = the lonely points; `A^j_x = {a : x` social in `X^j_a}`, `L^j_x = {a : x ∈ X^{j*}_a}`, so the fibre class
`{a : c(x, a) = j} = A^j_x ⊔ L^j_x`; `B^j(x) = {b : x ∈ N_e[X^{j*}_b]}`. All are jointly measurable (Tonelli).
- **(i)** For a.e. `x`, `A^j_x` is edge-null in `Y′`: `a, a + t ∈ A^j_x` gives `c(x, a + t) = j = c(x + s, a)` for a `ν_X`-positive set of `s`,
  and `((x + s, a), (x, a + t))` is an edge; C3 makes the set of such `(x, a, s, t)` null.
- **(ii′)** For a.e. `x`, `μ(N_e[A^j_x] ∩ B^j(x)) = 0`, in three cases, each a null set of monochromatic edges or of social–lonely pairs:
  `b ∈ A^j_x` with `x + s` lonely for positive-measure `s` (null: `∫∫ 1[x ∈ X^j_b] 1[x + s ∈ X^{j*}_b] = 0` by the definition of lonely);
  `x` lonely at `b` with `b − t ∈ A^j_x` for positive-measure `t` (edges `((x, b), (x + s, b − t))`); `x + s` lonely at `b` and `b − t ∈ A^j_x`
  for positive-measure `s`, `t` (edges `((x + s, b), (x, b − t))`).
- **NH-Y′** (compact, tight): an edge-null `A ⊆ Y′` has `μ(A) ≤ ¼μ(N_e[A])` — C14.1's proof with `I` the pull-back of a maximum independent
  set of `P₄` averaged over all of `Y′`, and (R1) = Hoffman, which needs exactly edge-nullity (`⟨1_J, ν′ * 1_J⟩ = 0`).
- **NH-X** (stationary): for each `b`, `X^{j*}_b` is edge-null in `X` (a lonely point has a null set of neighbours in `X^j_b`), and
  `X`-stationary; C14.1-e samplewise, then expectation (`E d_n(Z) = P(x₀ ∈ Z)` by Fubini and stationarity), then `n → ∞`, then `∫ db`:
  **`ℓ_j ≤ r_X β_j`**, where `ℓ_j = ∫ P(x₀ ∈ X^{j*}_b) db` and `β_j = ∫ P(x₀ ∈ N_e[X^{j*}_b]) db`.
- **The count.** `p_j := P(c(0) = j) = E μ(A^j_x) + ℓ_j ≤ ¼(1 − β_j) + r_X β_j` (NH-Y′ with (ii′)). Summing, `1 ≤ 1 − (¼ − r_X)Σ_j β_j`, so
  every `β_j = 0` and then `ℓ_j = 0`. **So a.s., for a.e. `x`, every fibre colouring `g_x = c(x, ·)` has edge-null classes `A^j_x`.**

**C6 (fibres are pullbacks) [hand].** Four edge-null classes of measure `≤ ¼` (Hoffman) summing to 1 each have measure `¼`; Hoffman equality
puts `1_{A^j} − ¼` in the least eigenspace, which is spanned by `𝔓`-minimisers (Lemma Y′). So `g_x = γ_x ∘ ρ₄ ∘ π_𝔓` a.e., and `γ_x` is a proper
colouring of `P₄` (an edge `b̄ ~ b̄ + s̄` inside one class would be a positive-measure set of `Y′`-edges).

**C7 (propagation) [hand].** For a.e. `(x, s)`, a.e. `(a, t)`: `γ_{x+s}(ā + t̄) ≠ γ_x(ā)` for every `ā`, `t̄ ∈ S₄` (each pair is a positive-measure
set). `γ_x` is gap-free (tight `P₄`), so `γ_{x+s} = γ_x`. The translations fixing `x ↦ γ_x` a.e. form a closed subgroup containing
`ν_X`-almost all of `T_X`, hence `⟨T_X⟩‾ = X` (`⟨S¹⟩ = ℂ`; VC-C2 at `B`; `⟨T_v⟩ = L_v` at split `v`; one coordinate at a time since `1 ∈ T_v`).
So `γ_x = γ` a.e.: **a.s. `c̃ = γ ∘ ρ₄ ∘ π_𝔓` a.e. on `G_S`.**

**C8 (back to `R`) [hand].** For `δ ∈ R ∩ 𝔓⁴`, `C(δ) = C̃(δ) = E[|Φ|⁻¹∫_Φ ⟨g(z), g(z + δ)⟩dz] = 1` (stationarity, Fubini, C7). So `c` is a.s.
`R ∩ 𝔓⁴`-periodic, i.e. a proper colouring of `R/(R ∩ 𝔓⁴) = O/𝔓⁴` in which every edge of `P₄` lifts: a pullback. **T-C holds.** ∎

### 3.3 T-C(A) [hand]
Over ℚ(√47) there is no stable dyadic place (47 ≡ 7 mod 8: the wall is broken, the dyadic place is split) and every stable place has
all-levels ratio `< 1/4` (the table; FS86-CL1's list). Run C1–C5 with `Y′ = ∏_{v∈H} O_{L_v}` (no tight factor): Hoffman gives
`α(Y′) ≤ max_{v∈H} h_v < 1/4` (the maximum is attained: 31's `1/4 − 2.745·10⁻⁶`), NH-Y′ holds at ratio `α(Y′)` (averaging a near-optimal set over
the compact `Y′`), and the count reads `1 = Σ_j p_j ≤ 4 max(α(Y′), r_X) < 1` — no such `μ`. The second clause follows (an orbit closure carries
an invariant measure). **If `S` contains the dyadic (split) place**, C14.2 (c) is needed at `q = 2`: J21-D1-2 (one mind); I re-read its case
analysis — the residue size enters only through `1/(q − 1) ≤ 1` — and concur (a second reading, not a second derivation). *Class form:*
every real field with no stable place of all-levels ratio `≥ 1/4`.

### 3.4 Controls, the mutation audit, and what T-C scores
- **ℚ(√11) (T-C must fail, and does):** C9's `⌊4(θ + s)⌋` has spectral measure on `{kθ} ⊆ T + A` and is no pullback. The proof breaks at
  C4: the stable 7 fails H* (`λ_min/d = −0.5617`) and has all-levels ratio `≥ 2/7 > 1/4`, so it fits neither `Y′` nor `X`.
- **K:** the second tight place fails H* with equality and has ratio exactly `1/4`; C4 fails; the conclusion is VK's per-coset choice.
- **VD-7's quartic:** a ramified dyadic stable place, `λ = −d`: C4 fails, and its two-colouring is the escape.
- **Mutation:** deleting "`r_v < 1/4` on `B`" admits ℚ(√11); deleting H* on `H` (putting 7 into `Y′`) breaks Lemma Y′'s equality case;
  replacing `m₁` by Hoffman's 0.2871 at the real place makes `r_X > 1/4` and the count's sign flips (C14's own control). Each hypothesis is
  the one a control violates.
- **P-real (0.40): won.** On `T + A + Fin_S` the real place is an input (`m₁ < 1/4`, a higher-order fact), not an obstruction; G76's reading
  survives only outside every `T + A + Fin_S`.
- **What T-C does not reach** (T-C′, §5): spectral measures carried by `⋃_S (T + A + Fin_S)` but by no single one (the completion over all
  split places is the full product, not locally compact), and those charging characters that read infinitely many split places.

### Would-have-searched-here log (stage 3)
- Would have estimated the stationary ratio at the real place by an LP on sampled configurations. Instead: C14.2 (a) through the
  regularisation lemma, no computation.
- The factor table is a complete enumeration over a set a derivation fixed (every character of `Γ_p` for the listed `p`) — the ban's edge,
  logged as such.

## Stage 4 — SAVED (T-B1, T-B2; written tersely — the budget was spent, see the report)

**T-B1: GAP.** A FALSE is a non-pullback (T-A2), i.e. row 88 "no"; none is offered. Two routes, each stopped at a named step:
- *Re-centring (§S.2's route).* Exhaust `R` by norm balls of `𝔸 = (L⊗ℝ) × ∏′_{split} L_v` (finite in `R`, which is discrete there); re-centre
  non-pullbacks `c_n → p` at a nearest defect `z_n`. If the norm of `z_n` is archimedean-dominated, the re-centred agreement set tends to an
  archimedean half-space and Theorem H closes the case. **Named step:** if it is split-dominated, the re-centred region is
  `{w : |w + z_n|_v < |z_n|_v}`, an ultrametric sphere around `−z_n`, whose liminf is empty — no half-space, and no ultrametric analogue of H
  is available from a finite set.
- *Pinned bootstrap.* `z` is forced once three neighbours in the pinned set show the three colours `≠ p(z)` (gap-freeness). Plausibly this
  fills a lattice `R_N` from a finite seed; **named step:** passing from `R_N` to `R_{N′}` needs unit vectors in prescribed cosets of `R_N`
  with no poles outside `N′`, and `T(O_S)` is discrete in `∏_{v∈S} T(F_v) × (S¹)²` — the obstruction of `plans/FS86-C-deBruijn.md` §7.5.

**T-B2: GAP at B2-growth**, with three proved partials [hand]:
- **B2-1 (propagation).** `z ∈ D`, `c(z) = j` ⟹ `z + U_j(z) ⊆ D`, `U_j(z) = {u : γ(z̄ + ū) = j}`, a union of `|S₄|/3` residue classes of `U`; so
  `D` is infinite (no finite defect).
- **B2-2 (bounded chains are thin).** `kU` lies in the archimedean ball of radius `k`, while every Følner set of `R` has archimedean extent
  `→ ∞`; so `d*(z + kU) = 0` for every `k`. A proof must use unboundedly long, colour-dependent chains.
- **B2-3.** `d*(D) = 0` makes `c` transient (T-A1): T-B2 is Q-tr's single-pullback case, invisible to every invariant measure, so no
  measure argument (T-C's included) can reach it.

### Would-have-searched-here log (stage 4)
- Would have run the pinned bootstrap on a lattice `R_N` over ℚ(√59) by computer. Instead: named its number-theoretic obstruction.

## Stage 5 — SAVED (T-C′, lemma statements for J28V, C0 scored)

### 5.1 T-C′ — the remainder, named (no truth claim)
Beyond T-C, Q-μ needs every translation-invariant `μ` whose spectral measure is **(R1)** carried by `⋃_S (T + A + Fin_S)` but by no single
one (the completion over all split places is their full product, Polish but not locally compact: no Haar measure for C3–C5's Fubini), or
**(R2)** charges characters outside every `T + A + Fin_S` (reading infinitely many split places — HD1's infinite type). **Entropy:** the
colouring constraint is `σ̂|_U = −1/3`, a linear condition on Fourier coefficients along `U`; I see no mechanism by which it forces positive
entropy for the `U`-action on `R̂`, so Rudolph–Johnson, Host and Einsiedler–Lindenstrauss (positive entropy) do not visibly apply, and the
zero-entropy case is Furstenberg's measure question's analogue. Further, the spectral measure of a merely translation-invariant `μ` is not
`U`-invariant; those theorems see only `U`-averages, which can carry mass onto Pull (§M.1) — so even a full classification of `U`-invariant
measures would leave Q-μ open without T-B1-type isolation.

### 5.2 Lemma statements for J28V
- L-A: T-A (i)–(vi) as stated, with `τ` ranging over automorphisms of `F(i)` commuting with complex conjugation.
- L-A1: `T-B1 ⟹ Q-tr ⟹ T-B2`.  L-A2: a FALSE for T-B1 or T-B2 exhibits a four-colouring outside Pull.
- L-CL: for a countable abelian group acting on a compact space, a point `c` and a clopen `C`, `d*{t : t·c ∈ C} = max μ(C)` over invariant `μ` on `O(c)‾`.
- L-C1: `σ` is carried by `T + A + Fin_S` iff `P(c(0) ≠ c(y)) → 0` as `y → 0` in `G_S = (L⊗ℝ) × ∏_{stable} O_{L_v} × ∏_{v∈S} L_v`.
- L-C2: then `c` has a `G_S`-stationary, jointly measurable extension `c̃` with `c̃ = c` on `R` a.s.
- L-C3: `P(c̃(x) = c̃(x + w)) = 0` for every `x ∈ G_S` and `w ∈ T_S`, the closure of `U` in `G_S`.
- L-C4: if every stable `v ≠ 𝔓` in `H` has `λ/d > −1/3` for every non-trivial character at every level, `O_𝔓 × ∏_H O_{L_v}` is Hoffman-tight at four colours with least eigenspace the `𝔓`-minimisers.
- L-C4b: in a doubling LCA Cayley graph with a full-support connection measure, an edge-null measurable set is a.e. equal to an independent set.
- L-C5: (the count) a stationary a.e.-proper four-colouring of `X × Y′`, `Y′` compact tight at `1/4`, `X` of window ratio `< 1/4`, has a.e. fibre `c(x, ·)` an a.e.-proper colouring of `Y′`.
- L-C6: an a.e.-proper measurable four-colouring of `Y′` is a.e. `γ ∘ ρ₄ ∘ π_𝔓` for a proper colouring `γ` of `P₄`.
- L-C(A): over ℚ(√47) no stationary a.e.-proper four-colouring of `G_S` exists, for any finite set `S` of split places.
- L-tab: `B = {11}` for ℚ(√59), `{19}` for ℚ(√83) and ℚ(√131), `{11, 19}` for ℚ(√47); 23 and 31 satisfy H* (margins `1.6·10⁻³`, `4.9·10⁻⁶`).
- L-B2-2: `d*(z + kU) = 0` for every `z ∈ R` and `k ≥ 1`.

### 5.3 C0 scored; the plan's §P
C0: T-A TRUE (0.90) — met; T-C TRUE (0.55) — met at one mind; T-C(A) TRUE (0.50) — met at one mind; T-B1 GAP (0.94), T-B2 GAP (0.89) — met.
§P: P-TA won; P-TC (0.40) won pending J28V; P-TCA won pending J28V; P-TB1, P-TB2: GAP; P-decide: neither; **P-real won**; P-controls won;
P-G75″ not met; P-log won (four lines).

### Proposed edits (front-page lane; not made here)
- `plans/FS86-row88-rigidity.md` §S.2: the T-C route note should name the stationary count in place of J21-MX + C14 (§3.1 here).
- G76's reading "the obstruction is the real place": true only outside every `T + A + Fin_S` (P-real).
- FS-84's stub: a falsifier at ℚ(√47) has spectral measure outside every `T + A + Fin_S` (T-C(A)).
