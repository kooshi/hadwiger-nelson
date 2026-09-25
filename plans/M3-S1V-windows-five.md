# M3 — J22, the blind verifier of J21's windows-at-five claims (FS-64 at five colours over ℚ(√167))

*Job J22 of the 2026-09-25 crunch; de Bruijn, Opus 5.5. Brief: `data/crunch-2026-09-25/briefs/J22-M3-windows-five-verifier.md` with
`STANDING-RULES.md`. Blind: J21's record `plans/M3-S1D-windows-five.md`, `data/m3/j21/`, `tools/crunch_j21_*.py`, J21's brief and
report, `plans/M3-exotic-colourings.md`, `plans/M3-close-inventory.md`, commits whose subject begins "J21:", and
`plans/CRUNCH-2026-09-25-INDEX.md` are fenced until B1 (and B2, if any) are committed. The owner added three J21 claims (MX, TH, RED),
quoted from the fenced record's lines 29–37, to verify in B1 after the fixed list's deciding claim, and one number to settle exactly
(the place above 59).*

## Theorems this phase proved

- **J22-T1** [tools exact, two code bases] `Γ₅₉`'s nontrivial spectrum lies in `(−15, 15)`: `λ_min = −14.91757700177875`, `λ_max = 14.51093575399911`; `λ* = 0.2486262833630 < 1/4`; Hoffman `0.199119854095 < 1/5` — `tools/crunch_j22_spectrum_exact.py`, `tools/crunch_j22_spectrum_check.gp`, `data/m3/j22/spectrum-p59.out`, `gp-check-59-plant0.out`.
- **J22-T2** [tools exact] level-one `λ*` of the standard compact piece: 0.625 (`q = 9`), 0.4106 (25), 0.2772 (49), 0.3317 (23), 0.3393 (29), 0.2719 (43), 0.2557 (61), all `≥ 1/4`; 0.2220 (67), 0.1831 (121) `< 1/4` — `data/m3/j22/`.
- **J22-T3** [hand] C14.2 (c) holds at `q = 2`: the dyadic local graph of ℚ(√167) has ratio 0 (error `3/(2n+4)`) — §2.3 D1-2.
- **J22-T4** [hand] at every split place the full local graph has clopen cross-independent sets `C, D` of window density `≥ 2/9` each (`C = {d₀(u) ∈ A₁, d₋₁(w) ∈ B₁}`, `D` with the complements: every edge preserves `d₀(u)` or `d₋₁(w)`) — so no density-threshold selection runs on compact windows `⊇ π⁻¹O²` — §2.1.
- **J22-T5** [hand] D3: `χ_µ(UD(ℝ²) × UD(ℝ²)) = χ_µ(UD(ℝ²))`, also Borel, by shifted diagonals — §2.3.
- **J22-T6** [hand] J21-MX re-derived (Borel, and measurable to N′) — §2.2.
- **J22-T7** [hand] D2(a) ⟸; ⟹ in the Borel form when every factor of `B` is 5-thick — §2.1.
- **J22-T8** [hand] at a split place with odd `p`, a level-`m ≥ 2` character with equal negative valuations has `|ν̂| ≤ 2/(q−1)` (stationary phase); Lemma P re-derived — §2.2.
- **J22-T9** [hand] D2(b) ⟺ D2(a) for each `B`, given D3 — §2.3.

## Stage 1 — SAVED

### 1.1 The quotation check (standing rule 5)

| # | quotation in the brief or the owner's message | source | result |
|---|---|---|---|
| Q1 | the Q2 definitions (`G_v = F_v²`, `T_v`, `Γ_S`, `ι_S`, measurable window `k`-colouring), "J21's and J22's briefs quote these, and FS86-Cx-C14 and FS86-CL1 verbatim" | the definitions' own source is the M3 plan (fenced); compared with `plans/FS86-C-Coxeter.md` round 2 step 5 "Setting" and FS86-Cx-C14 (`plans/FS86-derivation.md` §9) | **not verbatim to C14, and equivalent to it.** C14's setting takes `G_v = O_v` at odd stable places and the hyperbola `F_v × F_v` at split ones; the brief takes `G_v = F_v²` everywhere. At a stable place `T_v ⊂ O_v²` (a unit vector has no pole when `−1` is a non-square), so `Cay(F_v², T_v)` is a disjoint union of translates of `Cay(O_v², T_v)`; at a split place `(x, y) ↦ (x + iy, x − iy)` carries `x² + y² = 1` onto `uw = 1` (a unimodular map at odd `p`). Colourability and ratios agree. The brief quotes neither C14's nor CL1's statement in full; its fragments are checked below. |
| Q2 | CL1 "is graded "[hand, one mind (the close planner)]"" | `plans/FS86-derivation.md` §9, FS86-CL1 | **truncated**: the source reads "[hand, one mind (the close planner), from C14.1–C14.3 (two derivations) and the all-levels ratios; external input AmbrusEtAl2023 at real places]". The quotation closes the bracket early and drops the inputs; no widening. |
| Q3 | "C14.2 (c) at `p = 2` is **not checked**" | FS86-CL1 | verbatim ✓ |
| Q4 | "`[AmbrusEtAl2024]`'s `m₁(ℝ²) ≤ 0.2470` and Croft's `m₁ ≥ 0.22936` (external, second-hand: carry them as such)" | `BIBLIOGRAPHY.md` rows `[AmbrusEtAl2024]`/`[Ambrus2023]` (l. 187) and `[AmbrusEtAl2023]` (l. 258); FS86-Cx-C14 | **key discrepancy, same paper**: C14 and CL1 cite `[AmbrusEtAl2023]` Thm 1 for `≤ 0.2470`; both keys name arXiv:2207.14179. The `[AmbrusEtAl2023]` row says the PDF is held and §2, §5 read; the `[AmbrusEtAl2024]` row says "not held … not read — second-hand". Content consistent; Croft's bound is quoted in CL1 as "restated in `[AmbrusEtAl2024]`'s row" ✓. I carry `m₁ ≤ 0.2470` as external, computer-assisted, unchecked here. |
| Q5 | the fixed list D0–D4 "quoted verbatim from `plans/M3-exotic-colourings.md` §S" | fenced | **not checkable** (the source is fenced); taken as the statements to verify. |
| Q6 | the owner's J21-MX, J21-TH, J21-RED, "quoted verbatim from `plans/M3-S1D-windows-five.md` lines 29–37" | fenced | **not checkable**; taken as the statements to verify. |
| Q7 | the owner's news: J01-7 verified (band characters of `R_F` torsion plus archimedean, `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`); M1's CLG verified blind | no source named | not checked; not used below. |
| Q8 | "`plans/FS86-derivation.md` Lemma P and C9", "`LEDGER.md` rows 69, 75, 92, 94, 95, 96", "`plans/FS66-derivation.md` T8", "`[Zhang2012]` Thm 1.8 and Prop. 1.7 (held)", "`[KechrisMarks2020]` §4.6–§4.7 (path)" | the files | all exist ✓ (FS86-LP, FS86-Cx-C9; rows present; FS66-T8 at l. 345; Zhang's PDF held, read in full per its row; the Kechris–Marks PDF present). |
| Q9 | D1-fac's attributions: "FS-66's all-levels certificate" at 23, "Lemma P" at 167, "C14.2 (c)" at odd split places | row 75; FS86-LP; FS86-Cx-C14's proof | ✓ each names an existing result: row 75 gives `U(23) = 97.984637` against `529/5`; FS86-LP covers ramified towers; C14.2 (c) is the split-place ratio-0 lemma. |
| Q10 | D4: "C9's colouring `⌊4θ⌋` over ℚ(√11) … over `{∞, 7}`" | FS86-Cx-C9 | consistent: C9 reads "`θ = (2x + 3y)/7` read at the stable prime above 7, plus an archimedean linear term `ℓ` with `0 < max ℓ ≤ 1/28`". **Scope note:** ℚ(√11) has two real places and 7 splits in it (`(11/7) = (4/7) = 1`), so "`{∞, 7}`" means one real place and one place above 7. |
| Q11 | D1-2: "Each dyadic place of ℚ(√167) (split in `F(i)/F`)" | arithmetic | ✓ with a note: 2 is ramified in ℚ(√167) (`167 ≡ 3 mod 4`), so there is **one** dyadic place; its completion is `ℚ₂(√167) = ℚ₂(i)` because `−167 ≡ 1 (mod 8)` is a 2-adic square, so `i ∈ F_v` and the place splits in `F(i)/F`; residue field `𝔽₂`. |
| Q12 | D1-3: "FS-64's configuration (ii)" | `plans/STUB-adelic-window-colouring.md` l. 75 | configuration (ii) is "the barrier prime, 3" ✓. **Fence note:** I read this stub's lines naming the configurations. It is a stub, not a crunch record; its last edit is `2ac6a338` (FS-89's close, 14:08), before the crunch queue (`d2e4dcca`, 14:46) and before J06 opened M3 (`22bd1d12`, 15:50), so it carries no M3 route. Logged as a deliberate read, not a slip. |

**Fence log:** no fenced file opened. `git log --oneline` output (which the harness also shows) listed "J21:" subjects; no `git show` of any.

### 1.2 The deciding claim

**D2(a)** decides M3's five-colour question in the window format: with D0 (any `S` with a real place contains the real plane's
measurable question) and D1 (no real place: a count), D2(a)–(b) and D3 would make "a measurable window five-colouring over `S`" equivalent
to `χ_µ(ℝ²) ≤ 5` for every `S` whose finite factors have ratio `< 1/5`. It is verified first; then the owner's three J21 claims; then the
rest.

### 1.3 C0 — a probability per claim before derivation

*Honesty note:* written after reading the verified inputs (FS86 §9 with Coxeter's C14 proof, rows 69/75/92/94–96, FS66-T8), during which
I re-walked C14.1 and C14.3 and thought through D3's diagonal; so the priors for D1, D3 and D1-2 are not clean.

| claim | TRUE | GAP | FALSE | why |
|---|---|---|---|---|
| **D2(a)** (deciding) | 0.10 | 0.85 | 0.05 | "ratio `< 1/5`" is a counting hypothesis; a selection (a colouring of `A` read off `A × B`) usually needs a spectral one; a FALSE needs `χ_µ(ℝ²) ≥ 6`, out of reach |
| D2(b) | 0.10 | 0.85 | 0.05 | same as D2(a), plus D3 |
| D0 | 0.95 | 0.03 | 0.02 | definitional plus a pullback |
| D1 | 0.85 | 0.12 | 0.03 | C14.1/C14.3 at five colours |
| D1-fac | 0.75 | 0.20 | 0.05 | the exact margin at 59 is the risk |
| D1-43 | 0.15 | 0.80 | 0.05 | the level-one certificate `α(Γ₄₃) ≤ 365` is not an all-levels bound (FS-69 open) |
| D1-2 | 0.80 | 0.15 | 0.05 | C14.2 (c) at `q = 2` not checked in FS-86 |
| D1-3 | 0.90 | 0.08 | 0.02 | arithmetic plus C14.2 (c) at `q = 9` |
| D3 | 0.85 | 0.12 | 0.03 | a shifted diagonal is a copy of the factor |
| D4 | 0.90 | 0.08 | 0.02 | C9 plus the hexagonal colouring |
| J21-MX | 0.85 | 0.12 | 0.03 | the standard mixing selection, measurable form |
| J21-TH | 0.55 | 0.15 | 0.30 | Weil leaves 59 to an exact spectrum; the non-thick side at 61 is close to Weil's bound |
| J21-RED | 0.65 | 0.15 | 0.20 | rests on TH's thick side and on MX |

### 1.4 "Would have searched here" log

*(one line per move; filled as they come)*
- D2(a), the split places: *would have searched* for a cross-independent pair of density `≥ 1/5` in the level-one Kloosterman graph
  `Cay(𝔽_q², {(ε, ε⁻¹)})` at `q = 9, 61` (is `κ < 1/5` on the standard piece?); *did instead:* the structural construction J22-T4 on
  the full local graph, and recorded `κ` on the standard piece as the open step.
- D1-43: *would have run* a fibre-share relaxation `B₁` at 43 (FS-69; machine-long); *did instead:* recorded GAP with the step named.
- 59 (the owner's number): nothing searched — an exact spectrum of a graph fixed by the statement, decided by Sturm counts (in, logged).
- 23 (D1-fac): re-ran the frozen FS-66 checker on the existing certificate (an existing checker on an existing certificate: in).

## Stage 2 — SAVED (phase B1, blind)

### 2.0 Conventions

**Ratio.** For a local graph `Γ_v = Cay(F_v², T_v)`, "measurable independence ratio `r`" is read as C14's (`plans/FS86-C-Coxeter.md`
round 2 step 5): (R1) every measurable independent set has window density `≤ r + η(n)`, `η → 0`, on a fixed Følner sequence of compact
open (or box) windows; (R2) near-optimal sets can be averaged. At a stable place `T_v ⊂ O_v²`, so the graph is a disjoint union of
copies of `Cay(O_v², T_v)` and `r_v = sup_k α(G_k)/|G_k|` (FS66-T8), with (R2) by Haar averaging over `O_v²`. At a split place (R2) is
trivial at `r = 0`. So every local graph of ℚ(√167) meets (R2) at its true ratio, and the verdicts below do not depend on the reading.
**Thick** (J21's word): a compact Cayley subgraph `Cay(K, T_K)`, `T_K ⊆ T_v ∩ K`, with a probability `ν` on `T_K` and
`λ* = sup_{ξ≠0} |ν̂(ξ)| < 1/4`. **Formats:** E = measurable classes, proper on every edge; N′ = proper on edges between points outside a
null vertex set; Borel = Borel classes, proper everywhere.

### 2.1 The deciding claim — **D2(a): GAP**

*Statement (verbatim):* "Let `A` be the unit-distance graph of `ℝ²` and `B` a product of finitely many of ℚ(√167)'s finite places' local
graphs, every factor of `B` of measurable independence ratio `< 1/5`. Then `A × B` has a measurable proper five-colouring iff `A` does."

- **⟸ TRUE.** `c ∘ π_A` is a measurable proper colouring of `A × B` (an edge of `A × B` projects to an edge of `A`; the preimage of a
  Lebesgue-measurable set is measurable for the completed product Haar measure).
- **⟹ in the Borel form, TRUE when every factor of `B` is 5-thick** (J22-T7): restrict `W` to `A × ∏ Cay(K_v, T_{K_v})` (a subgraph)
  and remove the factors one at a time by the mixing selection (J21-MX, verified in 2.2).
- **⟹ as stated: GAP, at two named steps.**
  1. **Non-thick factors.** The hypothesis "ratio `< 1/5`" is a counting hypothesis; no selection follows from it. The counting itself
     (C14.3) gives the product `A × B` ratio `max(m₁, r_B) = m₁ ≥ 0.22936 > 1/5` (Croft, external), which does not obstruct five classes.
     The only selection available, J21-MX's, needs `λ* < 1/4`, and at ℚ(√167) the factors that meet the hypothesis but are **not**
     5-thick on their standard compact piece are the stable places above **23** (ratio `≤ 97.984637/529 = 0.18523` by row 75's
     certificate, but `λ* = 0.3317`, J22-T2) and the split places above **2, 3, 5, 7, 29, 61** (ratio 0 by C14.2 (c) and J22-T3; `λ*`
     from `0.2557` at 61 to `1` at 2, J22-T2). A threshold selection needs only the weaker **cross-independence ratio** `κ < 1/5` (no two
     cross-independent measurable sets both of measure `≥ 1/5`) on some compact piece; `κ ≤ λ*/(1 + λ*)` gives `0.2036` at 61 and more
     elsewhere, never `< 1/5`; and **on the full split graph `κ ≥ 2/9`** (J22-T4), so the method cannot run on any compact window
     `⊇ π⁻¹O²`. Whether `κ < 1/5` on the standard piece `Cay(O², {(ε, ε⁻¹)})` at those six residue fields, or at 23, is open (finite
     questions; after the ban). The missing step, named: **a measurable selection `A × B → A` for a factor that is not 5-thick.**
  2. **E → N′ even at thick factors.** For a Lebesgue-measurable `W` the fibre classes `W(x, ·)⁻¹(j)` are measurable only for almost
     every `x`, so the selection gives a colouring of `A` that is measurable and proper **off a null vertex set** (N′), not a measurable
     proper colouring (E). On `UD(ℝ²)` a null set cannot be recoloured afterwards in general (a circle through a bad point may carry all
     five colours), and I know no upgrade N′ → E for this graph. The missing step, named: **N′ ⟹ E for `UD(ℝ²)` at five colours**, or a
     Borel hypothesis on `W`.
- **FALSE is out of reach**: a counterexample needs `χ_µ(ℝ²) ≥ 6`, which is open.

### 2.2 The owner's three J21 claims

**J21-MX — TRUE [hand].** *Proof (re-derived from the statement).* For `x ∈ X` let `C_j(x) = W(x, ·)⁻¹(j) ⊆ K`. If `x ~ x'` in `X`,
then no `a ∈ C_j(x)`, `t ∈ T_K` has `a + t ∈ C_j(x')` (that pair is an edge of the product), so `∫∫ 1_{C_j(x)}(a) 1_{C_j(x')}(a + t)
dν(t) dμ(a) = 0` (`ν` is carried by `T_K`). By Plancherel on `K` the left side is `μ_A μ_B + Σ_{ξ≠0} ν̂(ξ)·(Fourier terms)`, whose sum is
at most `λ*·√(μ_A(1−μ_A)μ_B(1−μ_B))` in absolute value (Cauchy–Schwarz; no symmetry of `ν` used). So `μ_A μ_B ≤ λ*√(μ_A(1−μ_A)μ_B(1−μ_B))`,
i.e. `√(μ_A/(1−μ_A) · μ_B/(1−μ_B)) ≤ λ*`. With `τ = λ*/(1+λ*)`, `μ > τ ⟺ μ/(1−μ) > λ*`, so two cross-independent classes cannot both
exceed `τ`. Every fibre has a class of measure `≥ 1/k`, and `1/k > τ ⟺ λ* < 1/(k−1)`. So `φ(x) = min{j : μ(C_j(x)) > τ}` is defined
everywhere and proper. Borel: `x ↦ μ(C_j(x))` is Borel for Borel `W` on a standard Borel `X × K` (measurable dependence of section
measures). Measurable form: if `W` is measurable and proper off a null `N`, then off the null set `{x : μ(N_x) > 0 or a section is
non-measurable}` the sections are measurable, the classes minus `N_x` are cross-independent with unchanged measures, and `φ` is measurable
for the completed measure and proper off that null set. ∎ *Scope agreement:* the statement's measurable clause concludes N′, which is
exactly what the proof gives (compare D2(a) step 2).

**J21-TH — TRUE [tools exact, two code bases + hand].** *The owner's number:* **the two places above 59 are 5-thick, decided exactly.**
`Γ₅₉ = Cay(𝔽₅₉², x² + y² = 1)`, `|T| = 60`: every nontrivial eigenvalue lies in `(−15, 15)` — Sturm counts 0 and 0 on the 60 Galois-orbit
minimal polynomials (each checked to have rational-integer coefficients, degree 29), confirmed by PARI's `minpoly` + `polsturm` in an
independent script. `λ_min ∈ [−14.9175770017788, −14.9175770017787]`, `λ_max ∈ [14.5109357539991, 14.5109357539991]` (exact rational
isolating intervals), so **`λ* = 0.2486262833630`, `1/4 − λ* = 1.374·10⁻³`**, the positive side (`14.511/60 = 0.2419`) not binding. Higher
levels: a character new at level `m ≥ 2` has `|λ| ≤ 2p^{m−1}` against `|S_m| = p^{m−1}(p+1)` (Lemma P, re-derived: a coset of `𝔽_p^×`
meets `μ_{p+1}` in `≤ gcd(p−1, p+1) = 2` points), so `≤ 2/60`. The rest of the thick side: stable places `p ≥ 67` by Weil
(`2√p/(p+1) < 1/4` iff `p > 61.98`; 67 also exact, `λ* = 0.2220`); the ramified 167 by Weil + Lemma P (`≤ 0.154`); places split in
`F(i)/F` with `q = p²` (`p` inert in `F`) for `p ≥ 11` (`q = 121` exact, `λ* = 0.1831`; Weil `2p/(p²−1) < 1/4` for `p ≥ 9`); with `q = p`
(`p ≡ 1 mod 4` split in `F`) for `p ≥ 73` by Weil (none between 62 and 72); at split places higher levels have `|E| ≤ 2/(q−1)`
(stationary phase, `p` odd; J22-T8), unequal negative valuations give 0 and one negative valuation `−1/(q−1)` or 0 (C14.2 (c)'s
computation). *The non-thick side (the twelve):* exact level-one `λ*` = **0.625** (3, `q = 9`), **0.4106** (5, `q = 25`), **0.2772**
(7, `q = 49`), **0.3317** (23), **0.3393** (29), **0.2719** (43), **0.2557** (61, the closest: `λ_min = −15.3418 ≤ −15`); at 2 the
character `(x, y) ↦ (−1)^{(x+y) mod 𝔭}` equals `−1` on every integral circle point (`x + y ≡ x² + y² = 1` in `𝔽₂`), so `λ* = 1` for every
measure. *Uniform optimal:* `λ*` is convex in `ν` and invariant under the norm-one group acting by multiplication (it preserves `K`,
`T_K`, and permutes nontrivial characters), which is transitive on `T_K`; averaging an optimal `ν` gives the uniform measure. The count
"twelve" checks: 2, 3, 5, 7 one place each (2 ramified in `F`; 3, 5, 7 inert); 23, 29, 43, 61 split in `F`, two places each.

**J21-RED — TRUE [hand, given MX and TH's thick side].** Removing a thick place `v`: `Γ_{S∖v} × Cay(K_v, T_{K_v})` is a subgraph of
`Γ_S`, so MX gives a Borel colouring over `S ∖ v`; conversely a colouring over `S ∖ v` pulls back along the projection. Merging a conjugate
pair: the two real places, and the two places above a split prime, have **identical** local graphs (`ℝ²` with the unit circle; `ℚ_p²`
with `x² + y² = 1`), and for `s ∈ G_v` the shifted diagonal `{(g, g + s)}` is a copy of `Γ_v` inside `Γ_v × Γ_v`
(`(g, g+s) ~ (g', g'+s)` iff `g' − g ∈ T_v`); restricting to `D_s × Γ_{rest}` merges the pair, Borel for every `s`, measurable for a.e. `s`
with the null vertex set meeting a.e. slice in a null set (Fubini) — so N′ is preserved; the converse pulls back along one coordinate.
`S_red ⊆ {∞, 2, 3, 5, 7, 23, 29, 43, 61}` follows from TH. The measurable clause's weakening E → N′ is necessary for this route (D2(a)
step 2). *Edge case:* if every place of `S` is thick, `S_red = ∅` and `Γ_∅` is one looped vertex, so both sides fail: consistent.

### 2.3 The rest of the fixed list

| claim | verdict | the derivation, in one or two lines |
|---|---|---|
| **D0** | **TRUE** | Over `{∞₁}`, `G_S = ℝ²`, `T_S = S¹`, Haar = Lebesgue: the definition is a measurable proper colouring of `UD(ℝ²)`. For `S ∋` a real place `v₀`, `c ∘ π_{v₀}` is measurable (completed product measure) and proper (every edge of `Γ_S` has its `v₀`-coordinate a unit step). The "hence" is the contrapositive. |
| **D1** | **TRUE** [hand; C14.1 and C14.3 re-walked] | With `S` finite, no real place, each factor of ratio `r_v < 1/5` (and (R2), §2.0), C14.3 by induction gives `Γ_S` ratio `max r_v < 1/5` with error `→ 0`; five measurable independent classes of window densities summing to 1 give `1 ≤ 5(max r_v + η(n))`, false for large `n`. Works in formats E and N′. |
| **D1-fac** | **TRUE** [cert + tools exact + hand] | 23: row 75's certificate, `U(23) = 97.984637 < 529/5`, all-levels ratio `≤ 0.18523` (the frozen checker re-run: §2.4). Stable `p ≥ 59`: Hoffman at level one, exact at 59 (`0.199119854095 < 1/5`, J22-T1), Weil from 67; constant up the tower by Lemma P (`2/(p+3) < 1/5`). 167: Weil (`2√167 < 42`) + Lemma P (ramified). Odd split: C14.2 (c). **Scope note:** the list omits 43 and 2, handled by D1-43 and D1-2. |
| **D1-43** | **GAP** | Level one: `α(Γ₄₃) ≤ 365` (row 69's certificate), ratio `0.19741 < 1/5`. Higher levels: Hoffman gives only `0.213755422119` (exact, J22-T2's run) at every level, `> 1/5`; the fibre-share certificate at 43 does not exist (FS-69, priced at 84 GPU-days; machine-long, out under the ban); and levels can gain locally (Lemma W, row 75). **Missing step: an all-levels bound `sup_k α(G_k)/43^{2k} < 1/5`.** FALSE would need `α(G_k) ≥ 43^{2k}/5` at some level — unknown. |
| **D1-2** | **TRUE** [hand; J22-T3] | One dyadic place (2 ramified, `167 ≡ 3 mod 4`), completion `ℚ₂(i)` (`−167 ≡ 1 mod 8`), split in `F(i)/F`, residue `𝔽₂`. C14.2 (c)'s proof holds at `q = 2`: the substitution `ε ↦ ε(1 + π^{−b}x)` needs only `v(π^{−b}) ≥ 1` and a character of conductor `O`, nothing about `p`; so `(2n+1)ν̂_n ≥ −1 − 2/(q−1) = −3` and the ratio is `≤ 3/(2n+4) → 0`. The linear map `(x, y) ↦ (x + iy, x − iy)` (det `−2i ≠ 0`, not unimodular at 2) carries the brief's `T_v` onto the hyperbola; take the windows to be the preimages of `π^{−n}O²`. |
| **D1-3** | **TRUE** | `(167/3) = (2/3) = −1`: 3 inert in `F`, completion `ℚ₉ ∋ i`, split in `F(i)/F`; configuration (ii)'s 3-adic factor has ratio 0 by C14.2 (c) at `q = 9`. |
| **D2(b)** | **GAP** | Given D3, D2(b) ⟺ D2(a) for the same `B`: `D_s × B ≅ Γ_∞ × B` sits inside `Γ_{∞₁} × Γ_{∞₂} × B` (shifted diagonal), so ⟹ for D2(b) gives ⟹ for D2(a) and conversely through D3. The same two missing steps. |
| **D3** | **TRUE** [hand; J22-T5] | `≤`: pull back. `≥`: `Γ_{∞₁} = Γ_{∞₂} = UD(ℝ²)`, and `D_s = {(g, g+s)}` is a copy of `UD(ℝ²)` in the product; `(g, s) ↦ (g, g+s)` preserves Lebesgue measure on `ℝ⁴`, so for a.e. `s` the slice colouring is measurable (Fubini), and it is proper everywhere because `W` is. Also in the Borel form (every `s`). |
| **D4** | **TRUE** | C9: `θ(g) = ψ₇((2x + 3y)/7) + ℓ(g_∞)` is a continuous character of `ℝ² × ℚ₇²`; on `T_S` its values lie in `[2/7 − 1/28, 5/7 + 1/28] = [1/4, 3/4]`, so `⌊4θ⌋` separates every edge of `Γ_S` (points of one quarter-arc are at circular distance `< 1/4`); classes are Borel; it depends on both coordinates (`ℓ ≠ 0`, `θ₇ ≠ 0`), so it is no pullback from one factor. `{∞, 7}` means one of ℚ(√11)'s two real places and one of its two places above 7. The hexagonal seven-colouring (side `s ∈ (1/(√21 − 2), 1/2)`, half-open boundaries) is a Borel proper colouring of `UD(ℝ²)`, a window over `{∞₁}` for every real field. |

### 2.4 Pending in this stage

- The frozen FS-66 checker re-run on `data/fs66/b1/cert-p23.json --m 5` (checker sha256 `735b926798ffac14…`, matching row 75's) is running
  under `scripts/slot.py`; its verdict is recorded at the next save. D1-fac's 23 clause rests on row 75's CERTIFIED record regardless.

### 2.5 The tools

- `tools/crunch_j22_spectrum_exact.py` (Python, sympy): every eigenvalue of `Cay(𝔽_p², x² + y² = 1)` exact in `ℤ[ζ_p]`; checks (S)
  structure, (I) integrality of every Galois-orbit polynomial, (T) trace `= −|T|`, (P) Parseval `= p²|T| − |T|²`, (W) Weil; Sturm counts at
  `±|T|/4`; exact isolating intervals. **Controls:** `λ_min` at 11, 19, 23, 31, 43 reproduce FS-86 B1's high-precision table
  (`data/fs86/b1/gamma_spectra.out`) to 13 digits (31: `−10.66651049380006`, G54's margin). **Plants** (at `p = 23`, each exit 2 at its
  own check; the faithful run exit 0): `drop-point` → (S); `orbit-drop` → (I); `trace-skew` → (T). *The first `trace-skew` fired (S), the
  wrong reason (one character skewed breaks orbit constancy first); re-planted as a whole circle-group orbit, it fires (T).* Outputs:
  `data/m3/j22/spectrum-p*.out`, `data/m3/j22/plant-*-p23.out`.
- `tools/crunch_j22_spectrum_check.gp` (PARI, independent): `minpoly` + `polsturm` at 59, 61, 23 (agree to all printed digits), and the
  split residue fields `q = 9, 25, 49, 121, 29` in hyperbola coordinates (`q = 29` agrees with the circle form: the identification's
  control). **Plant** `j22check(59, 1)` (a point dropped) prints CHECK (S) FAILED, exit value 2. Outputs `data/m3/j22/gp-*.out`.
