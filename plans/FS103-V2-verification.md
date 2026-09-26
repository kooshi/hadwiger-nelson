*Verification record of job **FS103-V2**, a blind verifier for FS-103 (the collapse). de Bruijn, Opus 5.5, 2026-09-26. Brief:
`data/fs103/briefs/V2-collapse-verifier.md`, with `data/fs103/briefs/STANDING-RULES.md` as part of it. Claims: `data/fs103/claims.md`.
No subagents; no finite-witness search; I touch only this file, `data/fs103/fs103-v2/` and `tools/fs103_v2_*.py`.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| V2-PL635 | ℚ(√635087): 635087 prime ≡ 7 (mod 8); the 13 primes `p ≡ 3 (mod 4)` below 103 are inert; the one dyadic place is split in `L/F`; stable places below 1000 lie over 42 primes, first 103, 107, 127, 163, 191, 211, …; the ramified 635087 is stable | [tools exact, two code paths, 3 plants] | §2.1, `tools/fs103_v2_places.py` |
| V2-PLdG | `F_dG`: stable places below 600 lie over exactly 131 and 479 (16 each, residue degree 1); above 3, 5, 7, 11: `e = f = 2`, residue fields of size 9, 25, 49, 121, none stable; the 4 dyadic places each split in `L/F` | [tools exact, two code paths] | §2.1 |
| V2-SP | level one: `max|λ|/(q+1)` = 0.192617 at `q = 103` (Weil 0.195171), 0.168047 at `q = 131` (Weil 0.173417) | [tools, float64, error < 1e-12] | §2.1 |
| V2-NL | at an odd stable place, any `e`, every character of `O_w` new at level `j ≥ 2` has `|ν̂_w| ≤ 2/(q+1)` (the tangent-line count) | [hand, one mind; re-derives I-WEIL's second half] | §2.2 |
| V2-LB | C-LB at every `k ≥ 2`: for a real number field `F` with `N_k(F) = ∅` (Haar choice, D-THK (c)), `F²` `k`-colourable ⟹ (B) or `UD(ℝ²)` has a CP `k`-colouring; no "totally real" needed | [hand, one mind] | §2.3 |
| V2-MV | every CP `k`-colouring of a second-countable LCA Cayley graph has a jointly measurable version (C-FMT (a)) | [hand, one mind; classical] | §2.3 L2 |
| V2-CX | C-635-F1, C-dG-F1 and C-F1-GEN (proposed scope, widened to every real number field with `N₆ = ∅`) given MR(F) | [hand, one mind] | §2.4 |

## Stage 1 — SAVED (quotation check, C0, own lines and controls)

### 1.1 Fence log (standing rule 5; honest)

- **Slip, 2026-09-26, at my first ledger read:** `grep -n '109' LEDGER.md` printed **row 109 in full** (the mixing selection's statement,
  fenced until stage 3) and row 115, which cites it. I saw its **statement only** (not its proof; I opened no M3 file). The statement is
  also reconstructible from open text (`CLAUDE.md` item 27: "a spectral Burr–Erdős–Lovász", row 115's mechanism line). My selection step
  (§2.3 L3) is derived from scratch in the CP format, which row 109 does not treat; score its independence accordingly.
- Owner's fence additions (message of 2026-09-26): `plans/FS103-F-*.md`, `data/fs103/fs103-f/`, `tools/fs103_f_*`,
  `data/fs103/briefs/F103-*.md`, "FS103-F" commit bodies: not opened.
- `LEDGER.md` not read in full (409 kB against this job's budget): read rows 100, 110, 112, 113, 115 (by the slip), 116, 117, 120–127.

### 1.2 Quotation check of `data/fs103/claims.md`

| quote | source | verdict |
|---|---|---|
| D-USE, D-S, G43 "span K(√5,√7)", "no prime below 131 is usable" | `CLAUDE.md` § Notation, G64, G43 | verbatim ✓ |
| D-MR; I-MR's grade string; C-MR16's two quotes | `LEDGER.md` row 120 | verbatim ✓ |
| I-C′ | row 100 | verbatim ✓ |
| I-RU | `plans/FS84-SI-D-derivation.md` §4.1 | verbatim ✓ |
| I-SEL | row 124 | verbatim ✓ |
| I-CPUP | row 125 | verbatim ✓ |
| I-WEIL's X26B-L1 quote | row 123 | verbatim ✓ |
| D-TAE (R88 notation; `G_S`) | `plans/R88-derivation.md` l. 21 | verbatim ✓ (spans a line break) |
| I-EXT4 | `plans/R88-derivation.md` R88-TC-ext | verbatim ✓ (first clause checked) |
| "first usable primes 131, 479" | `LEDGER.md` | verbatim ✓ |
| D-RUL, D-STAB, D-GV, D-THK (a)–(c), D-NY, D-CP (a)–(b), D-M's M3 quote, I-MERGE, C-F1-GEN's and C-635-PL's stub text, C-S (R1) | fenced sources | deferred to stage 4 |
| brief: Kooshi, "If we end up at a wall which collapses HN …" | `CLAUDE.md` § Publication | verbatim ✓ |

### 1.3 C0 — each claim in my words, my wrong-reason line, my control (written before any derivation)

| claim | my words | wrong-reason pass would look like | my control |
|---|---|---|---|
| C-LB | a `k`-colouring of `F²` yields either a `U`-invariant `E`-null measure anticorrelated at unit distance, or a stationary colouring of the plane continuous in probability | (i) fibre masses of a CP colouring used with no measurable version; (ii) ratio `< 1/k` used where `λ* < 1/(k−1)` is needed; (iii) a product edge set `∏ T_w × S¹` assumed with no weak approximation; (iv) each place thick but no uniform `sup`; (v) spectrum on `E`, not `T + A`, extended (split places would enter as non-compact hyperbolic factors) | **known at k = 4, written first:** (K1) K and ℚ(√11) are 4-colourable (Theorem B; row 73): the chain must stop at `N₄ ≠ ∅` (a dyadic place with `U₂ = K₄`, `λ* = 1/3` exactly), and with that factor kept (A) must hold (the dyadic pullback), (B) fail; (K2) ℚ(√47), χ = 5 (row 121): `N₄ ∋` the places above 11, so (A) with those factors must be refuted by the ratio route (R88-TCA) and (B) then gives five given MR; (K3) a field with `N₄ = ∅` (ℚ(√635087)): the chain must give "4-colourable ⟹ (B)" since `χ_CP ≥ 5` — J45's A⁺ at `S = ∅`; (K4) ℚ at `k = 2`: `N₂ ∋ 2` (ramified dyadic, `λ* = 1`), chain stops, ℚ² is bipartite. Arithmetic-free: the selection must fail at `λ* = 1/(k−1)` exactly (`K₄` at `k = 4`) |
| C-635-PL / THK | the field's stable places are exactly the `p ≡ 3 (4)` split or ramified in `F`, first 103; `sup λ* ≤ 2√103/104` | trusting Weil where the exact spectrum is larger; forgetting deeper levels or the ramified prime; counting `p ≡ 1 (4)` places | plants: reversed reciprocity sign, wrong torus, `p ≡ 1 (4)` called stable — each must fail |
| C-dG-PL / C-131 / THK | stable places of `F_dG` start at 131; ramified 3, 5, 7, 11 and 2 not stable | classifying ramified primes by the Legendre rule (which assumes unramified) | two code paths (PARI `idealprimedec` vs Frobenius by hand) must agree on unramified primes |
| C-S | S ⟹ χ(ℝ²) ≠ 6; given MR, S ⟺ … | using ℝ ⊆ ℝ for S_nf, where it is not available | S_nf needs a bridge; check which one |
| C-FMT, C-CPM | measurable versions; formats | a Følner limit of random translates taken to be continuous in probability | a hexagonal colouring with ever finer boundary wiggles |
| C-F1-GEN | as C-LB plus MR plus the sandwich | "thick" left at an unspecified `k` | ℚ(√47): `N₆ ∋ 11`, chain must not apply |

### 1.4 Would-have-searched-here log
- None yet: the place lists are exact PARI of seconds (allowed), not a search.

## Stage 2a — SAVED (the headline field's places; the load-bearing step C-LB)

### 2.1 Places and level-one spectra (C-635-PL, C-dG-PL, C-131; exact, `tools/fs103_v2_places.py`, output `data/fs103/fs103-v2/`)

- **Stable, odd `p`:** `v` is stable iff `i ∉ F_v` iff the residue field `𝔽_q` of `F_v` has `q ≡ 3 (mod 4)` (Hensel; `ℚ_p(i)/ℚ_p` is
  unramified, so ramification of `F_v/ℚ_p` does not matter). Path A: PARI `idealprimedec`, `q = p^f`. Path B (unramified `p`): Frobenius
  order from Legendre symbols. They agree on every unramified prime below the bound.
- **ℚ(√635087)** (bound 1000): 635087 prime, `≡ 7 (mod 8)`; all 13 primes `p ≡ 3 (mod 4)` below 103 inert (residue `𝔽_{p²}`, not stable);
  stable places over 42 primes below 1000, first **103, 107, 127, 163, 191**, 211, 239, 263, 271, 311 (each split, two places); the
  ramified 635087 (residue `𝔽_{635087}`, `≡ 3 (mod 4)`) is stable. Dyadic: one prime of `F` (`e = 2, f = 1`), two of `L` above it:
  **split** in `L/F`, not stable (the wall is broken); no ramified stable dyadic place, so `R = O′` (I-C′). C-635-PL: **TRUE**.
- **`F_dG`** (bound 600): stable places over **131 and 479 only** (16 places each, `f = 1`); above 3, 5, 7, 11: four places each with
  `e = f = 2`, residue fields of 9, 25, 49, 121 elements, all `≡ 1 (mod 4)`: **not stable**; the four dyadic places (`e = f = 2`) each
  split into two in `L`: not stable. C-dG-PL: **TRUE** (no stable place above a prime below 131).
- **Level one** (float64; each value a sum of `q + 1` cosines, error < 1e-12): `max|λ|/(q+1)` = **0.192617** at 103 (Weil 0.195171),
  **0.168047** at 131 (Weil 0.173417). C-131: **TRUE** (0.168047 < 0.17342 < 1/5). Smaller primes, for the controls:
  `data/fs103/fs103-v2/level-one-ratios.out` (3: 0.5, 7: 0.561745, 11: 0.476413, 19: 0.380486, 23: 0.331695, 31: 0.333328, 43: 0.271869,
  47: 0.275974, 59: 0.248626, 67: 0.221976, 71: 0.220416, 79: 0.213774, 83: 0.210818) — 7 and 23 agree with G60's independently recorded
  −0.5617 and −0.3317.
- **Plants** (each exits 1 for its own reason): `legendre-flip` → paths A and B disagree, B listing 3, 7, 11, …; `wrong-torus` (`μ_{q−1}`)
  → ratio 1.000000 (the split torus lies on a line a character kills), "exceeds Weil"; `stable-mod` (`p ≡ 1 (4)` stable) → path A lists
  3, 5, 7, … and disagrees with B.

### 2.2 V2-NL: new levels at an odd stable place are at most `2/(q+1)` [hand, one mind]

`F_v` with residue field `𝔽_q`, `q ≡ 3 (4)`, any ramification `e`; `L_w = F_v(i)` unramified, residue `𝔽_{q²}`; `π` a uniformiser of `F_v`
(conjugation-fixed). Let `ξ` be a character of `O_w` trivial on `𝔓^j`, not on `𝔓^{j−1}`, `j ≥ 2`. Cosets of `T′ = T_w ∩ (1 + 𝔓^{j−1})` in
`T_w`: for `δ ∈ 𝔓^{j−1}`, `N(1 + δ) ≡ 1 + δ + δ̄ (mod 𝔓^j)` (as `2j − 2 ≥ j`), so `T′` mod `𝔓^j` is `{1 + π^{j−1}x : x + x^q = 0}`, an
`𝔽_q`-line `ℓ ⊂ 𝔽_{q²}`, every point lifting to `T_w` (the torus is smooth). On the coset `t₀T′`, `ξ(t₀(1 + π^{j−1}x)) = ξ(t₀)ξ(t₀π^{j−1}x)`,
and `x ↦ ξ(t₀π^{j−1}x)` is a non-trivial additive character of `𝔽_{q²}` restricted to `t̄₀ℓ` (bar = reduction): its sum over the line is
`q` or `0`, and it is `q` for exactly one line through 0 (a non-trivial `ψ(Tr_{q²/p}(a·))` kills the line `𝔽_q z` iff `Tr_{q²/q}(az) = 0`).
`t̄₀ ∈ μ_{q+1}` and `t̄₀ℓ = t̄₁ℓ` iff `t̄₀/t̄₁ ∈ 𝔽_q^× ∩ μ_{q+1} = {±1}`; so exactly 2 of the `q + 1` residues `t̄₀` give a non-zero coset sum,
and Haar measure is uniform over cosets: `|ν̂_w(ξ)| ≤ 2/(q+1)`. ∎ (Agrees with I-WEIL's second half; dyadic inert towers not re-derived.)

### 2.3 C-LB, derived blind [hand, one mind]

**Setting.** `F` a real number field (not assumed totally real), `L, U, R, R̂, E, T, A` as D-RUL/D-TAE; `k ≥ 2`; `N_k(F) = ∅` under
D-THK (c) with the Haar `ν_w`. **Step 0.** A ramified stable dyadic place has `λ* = 1` (every `t ∈ T_w` is `≡ 1 (mod 𝔓_w)`, since
`t̄ ≡ t` and `t² ≡ 1` in characteristic 2; a level-one character with `ξ(1) = −1` gives `ν̂_w(ξ) = −1`), so `N_k = ∅` puts `F` outside row
100's exception and `R = O′` (I-C′). Also `λ* := sup_v λ*_v < 1/(k−1)`: each term is, finitely many places have residue size below any
`Q₀`, and above it `λ*_v ≤ 2√q/(q+1)` (I-WEIL level one, V2-NL deeper) tends to 0.

**Step 1.** If `F²` is `k`-colourable, so is `Cay(R, U)`; its colourings `X_k` form a non-empty compact space on which the countable
solvable group `R ⋊ U` acts; take an invariant probability `μ`. Let `σ` be the trace spectral measure of `g(x) = e_{c(x)}` (D-TAE):
`σ(R̂) = 1`, `σ̂(u) = −1/(k−1)` for every `u ∈ U` (properness), and `v_*σ = σ` for `v ∈ U` (rotation invariance).

**L1 (the `T + A` factor).** `G := R̂_prof × (L ⊗ ℝ)`, `R ↪ G` diagonal. (a) `R̂_prof = ∏_{stable} O_w` (`R/nR ≅ ∏_{stable 𝔓|n} O/𝔓^{v_𝔓(n)}`
as `R = O′`). (b) `R` is dense in `G`: strong approximation for `G_a` off one split prime `𝔔` gives `x ∈ L` integral at every finite place
`≠ 𝔔` and close to any target at finitely many stable and all archimedean places, and such `x` lies in `O′ = R`. (c) The `τ_G`-continuous
characters of `R` are exactly `T + A` (restrictions of `Ĝ = (R̂_prof)^ × (L⊗ℝ)^`, injective by density). (d) `H := {f ∈ L²(μ) : y ↦ V_y f` is
`τ_G`-continuous`}` is the spectral subspace of `T + A`: ⟸ by dominated convergence; ⟹ because `y ↦ ⟨V_y f, f⟩` is then uniformly continuous
positive definite on `R`, extends to `G`, and Bochner on `G` plus uniqueness on `R̂` puts `σ_f` on the image of `Ĝ`. (e) `H = L²(𝒜)` for a
translation-invariant σ-algebra `𝒜`: `H` is closed, conjugation-closed, contains constants, and `‖V_y φ(f) − φ(f)‖ ≤ Lip(φ)‖V_y f − f‖` makes
it closed under Lipschitz maps and bounded products; so `𝒜 = {A : 1_A ∈ H}` is a σ-algebra and every `f ∈ H` is `𝒜`-measurable. (This is
J45-N1/N2 at `S = ∅`, re-derived.)

**Step 2 (the dichotomy).** `p_j(x) = P(c(x) = j | 𝒜)`, `h(x) = Σ p_j(x)e_j = E[g(x)|𝒜]`, the spectral projection of `g(x)` onto `T + A`.
For `u ∈ U`: `∫_{T+A} χ(u) dσ = E⟨h(0), h(u)⟩ = (k/(k−1))·E Σ_j p_j(0)p_j(u) − 1/(k−1)`, hence
`∫_{R̂∖(T+A)} χ(u) dσ = −(k/(k−1))·E Σ_j p_j(0)p_j(u) ≤ 0`, the same number for every `u` (`σ` and `T + A` are `U`-invariant). Put
`τ := σ|_{R̂∖(T+A)}`: finite, positive, `U`-invariant, and `τ(E) = σ(E ∖ (T+A)) = 0` by R-U (`σ` is `U`-invariant).
- If `E Σ_j p_j(0)p_j(1) > 0`: `∫ Re χ(1) dτ < 0` — **(B)**.
- If it is 0: then for every `x ∈ R`, `u ∈ U` (stationarity) a.s. `supp p(x) ∩ supp p(x+u) = ∅`; `c′(x) := min supp p(x)` is an
  `𝒜`-measurable, translation-equivariant, a.s. proper `k`-colouring of `Cay(R, U)`, and the spectral measure `σ′` of `e_{c′(0)}` is carried
  by `T + A` (its coordinates lie in `H`). Go to L2.

**L2 (extension; V2-MV).** `P(c′(0) ≠ c′(y)) = ((k−1)/k)∫(1 − Re χ(y)) dσ′ → 0` as `y → 0` in `τ_G` (L1 (c), dominated convergence), so by
stationarity `c′` is uniformly continuous in probability and extends (limits in probability along `x_n → g`) to `c̃` on `G`: stationary,
continuous in probability, and `P(c̃(g) = c̃(g + w)) = 0` for every `g ∈ G`, `w ∈ T_G := cl_G(U)` (approximate by `x_n → g`, `u_n → w`).
*Measurable version:* with an invariant metric `d` on `G` and a dense `{d_i}`, pick `δ_n` with `P(c̃(0) ≠ c̃(z)) < 2^{−n}` for `d(z, 0) < δ_n`,
set `c_n(g) = c̃(d_{i_n(g)})`, `i_n(g)` the least `i` with `d(g, d_i) < δ_n`; `c_n` is jointly measurable, `P(c_n(g) ≠ c̃(g)) < 2^{−n}`, so
(Borel–Cantelli) the eventual value `c̄` (0 if none) is jointly measurable and `c̄(g) = c̃(g)` a.s. for every `g`. This works for every
second-countable LCA Cayley graph — **C-FMT (a)**.

**L-WA (the edge set is a product).** The circle `x² + y² = 1` over `F` is a rational curve with the point `(1, 0)`, so `U = T(F)` is
dense in `∏_{v ∈ S} T(F_v)` for every finite set `S` of places (weak approximation for rational varieties); with the product topology,
`T_G = ∏_{v|∞} T(F_v) × ∏_{stable} T_w`. So `Cay(G, T_G) = X × Cay(K, T_K)`, categorical, with `X := Cay(L ⊗ ℝ, ∏_{v|∞} T(F_v))`,
`K := ∏_{stable} O_w` (compact metrisable), `T_K := ∏ T_w`.

**L3 (mixing selection in the CP format).** `ν := ⊗_w ν_w` on `T_K`; a non-trivial character of `K` is non-trivial on finitely many
factors, so `|ν̂(ξ)| ≤ λ* < 1/(k−1)`. With `c̄` from L2, `m_j(x) := Haar{y ∈ K : c̄(x, y) = j}`. Fix an edge `(x, x + w)` of `X`: every
`((x, y), (x + w, y + t))`, `t ∈ T_K`, is an edge, so by Fubini, a.s. `(Haar ⊗ ν){(y, t) : c̄(x, y) = c̄(x + w, y + t)} = 0`. For
`A = {c̄(x, ·) = j}`, `B = {c̄(x + w, ·) = j}` of masses `a, b`, Parseval gives
`0 = ∫∫ 1_A(y)1_B(y + t) dy dν(t) ≥ ab − λ*√(a(1−a)b(1−b))`, so `a, b` are not both `> θ := λ*/(1 + λ*)`; and `θ < 1/k` iff
`λ* < 1/(k−1)`. With an independent threshold `θ′ ~ Unif(θ, 1/k)`, `c″(x) := min{j : m_j(x) > θ′}` (defined: some `m_j ≥ 1/k`) is proper
at each fixed edge a.s.; stationary (the law of `(m(x_i))` is fixed by the finite-dimensional laws of `c̃`: `m_j(x)` is the `L²(P)`-Bochner
integral of the continuous `y ↦ 1[c̃(x, y) = j]`); and continuous in probability:
`P(c″(x) ≠ c″(x′)) ≤ 2kδ/(1/k − θ) + (k/δ²)·P(c̃(x, 0) ≠ c̃(x′, 0))` for every `δ > 0`. (The random threshold is what removes the atoms of
`m_j(x)` at a fixed threshold; a fixed `θ` can break continuity in probability.) So `X` carries a CP `k`-colouring.

**L4 (restriction).** Restricting a CP colouring along a continuous injective homomorphism that maps edges into edges gives a CP
colouring (the process is defined pointwise; no measurability is involved). At a real `v`, `T(F_v) = S¹ ⊂ ℂ`; at a complex `v`,
`L ⊗_F F_v ≅ ℂ × ℂ` with conjugation swapping, `T(F_v) = {(z, z⁻¹)}`, and `a ↦ (a, ā)` maps `ℝ² ≅ ℂ` onto a closed subgroup carrying the
circle `(z, z̄)`, `|z| = 1` (the compact real form). With the diagonal `ℝ² → (ℝ²)^{r₁ + r₂}`, `UD(ℝ²)` maps into `X`. **(A).** ∎

**Verdict C-LB: TRUE** at every `k ≥ 2`, in particular 4, 5, 6 [hand, one mind], over every real number field with `N_k(F) = ∅` — wider
than the claim list's scope (totally real is not used; row 100's exception is implied). Inputs used: I-C′, I-RU, I-WEIL (level one), and
classical facts (Bochner, strong approximation for `G_a`, weak approximation for a rational curve, Parseval); not I-SEL, I-EXT4, I-MX
or I-MERGE (L4 replaces the merge by the diagonal).

**Controls (as registered in 1.3).** (K1) K, ℚ(√11): the dyadic place with `U₂ = K₄` has `λ* = 1/3`, so `N₄ ≠ ∅`; L3 is exactly where it
stops (at `λ* = 1/3`, `a = b = 1/4 = θ` meets the inequality with equality), and keeping the factor, (A) holds by the dyadic pullback
(spectrum on `T`, so `τ = 0` and (B) fails) — reproduced. (K2) ℚ(√47): 11 splits (`(47/11) = 1`), `λ*(Γ₁₁) = 0.476 > 1/3`, so the chain does
not apply at `k = 4`; with those factors kept, refuting (A) needs the ratio route (R88-TCA), after which (B) and MR give five — consistent
with row 121, not re-derived here. (K3) ℚ(√635087), `N₄ = ∅`: `χ_CP(ℝ²) ≥ 5` (I-CP57) forces (B) — J45's A⁺ at `S = ∅` (strict
anticorrelation off `E`), reproduced by a route that uses `λ* < 1/3` instead of T-C(A). (K4) ℚ at `k = 2`: `N₂ ∋ 2` (ramified dyadic,
`λ* = 1`), the chain stops, and ℚ² is bipartite — consistent.

**Wrong-reason lines, avoided:** (i) the measurable version is proved (L2), not assumed; (ii) the threshold is `λ* < 1/(k−1)`, used through
the mixing inequality, never a ratio; (iii) the product edge set is weak approximation (L-WA); (iv) `sup_v λ*_v < 1/(k−1)` is shown
(Step 0); (v) the extension is on `T + A` only — `E ∖ (T + A)` is removed by R-U before the selection, so no split place enters.

## Stage 2b — SAVED (the other claims) [all hand, one mind — mine — unless marked]

- **C-CPUP: TRUE.** A CP `k`-colouring of `UD(ℝ²)` restricted to a countable `F²` is a.s. proper on all its (countably many) edges, so some
  proper colouring exists: `χ(F²) ≤ χ_CP(ℝ²)`. A finite subgraph of `UD(ℝ²)` lies in `F²` for its (countable) coordinate field, so DBE gives
  `χ(ℝ²) ≤ χ_CP(ℝ²)`. `χ(F²) ≤ χ(ℝ²)`: subgraph. No Tarski, no MR.
- **C-635-THK: TRUE** (Haar choice). Every stable place has `q = p ≥ 103` (§2.1) or is the ramified 635087. Level one: 0.192617 at 103
  (exact, §2.1), `≤ 2√q/(q+1) ≤ 0.19155` for `q ≥ 107` (I-WEIL; decreasing in `q`); new levels `≤ 2/104` (V2-NL). So
  `sup_v λ*_v = 0.192617 < 1/5`, `N₄ = N₅ = N₆ = ∅`. The stub's 0.1952 is Weil's bound; the exact value is lower. [tools + hand, given
  I-WEIL's level-one bound above 103]
- **C-635-F1: TRUE given MR(ℚ(√635087))** (the field is outside row 100's exception, §2.1). Let `k = χ(F²) ≤ 7`. C-CPUP:
  `k ≤ χ(ℝ²) ≤ χ_CP(ℝ²) ≤ 7` (I-CP57). If `k ≤ 6`: `N_k = ∅`, C-LB gives (A) or (B); (B) is a non-Haar `U`-invariant `E`-null measure
  (`∫ χ(1) d(Haar) = 0`), excluded by MR; so `χ_CP(ℝ²) ≤ k`. If `k = 7`: `χ_CP ≤ 7 = k`. Either way all three are equal.
- **C-635-TF: TRUE given C-635-F1 and `χ(ℝ²) ≥ 6`.** Three mutual unit distances in `F²` force `√3 ∈ F` (G57, `[Krebs2022]` L. 5.1), and
  `635087 ≠ 3·(square)`, so `F²`'s graph is triangle-free; `χ(F²) = χ(ℝ²) ≥ 6` and DBE give a finite triangle-free subgraph with `χ ≥ 6`.
- **C-dG-THK: TRUE** (Haar choice). `F_dG/ℚ` has group `(ℤ/2)⁴`, so residue degrees are 1 or 2; stable needs `f` odd, so `f = 1`, `q = p`;
  stable places lie over 131, 479, … (§2.1; ramified 3, 5, 7, 11 and 2 not stable). `sup λ* = 0.168047` (exact at 131; Weil below it
  beyond; V2-NL deeper) `< 1/5`. [tools + hand, given I-WEIL]
- **C-dG-F1: TRUE given MR(`F_dG`)**, by C-635-F1's argument (`F_dG` totally real, outside the exception, `N₆ = ∅`). Needs MR at degree 16;
  C-635-F1 gives the same conclusion with MR at degree 2 only.
- **C-MR16: NOT REACHED** (budget). Goes to FS-105.
- **C-F1-GEN.** *Stub text: MISSTATED* — (i) "real field" must be "real number field" (stable places and MR are number-field notions);
  (ii) "no non-thick stable place" must name `k`: the sandwich uses C-LB at `k = χ(F²) ∈ {5, 6}`, so `N₆(F) = ∅` is needed; with only
  `N₅ = ∅`, a field with `χ(F²) = 6` gives nothing. *Corrected:* "given MR(F), for every real number field `F` with `N₆(F) = ∅` (D-THK (c)),
  `χ(ℝ²) = χ_CP(ℝ²) = χ(F²)`" — **TRUE** (C-LB widened, §2.3). *Proposed scope (totally real, outside the exception, `N₆ = ∅`, MR(F)):* **TRUE**;
  "totally real" and "outside the exception" are not needed (the first by L4, the second implied by `N₆ = ∅`). "Given T-J39-3" is not
  needed as an input: C-LB supplies the forward direction used.
- **C-S.** (a) For D-S the first sentence is trivial (ℝ is a subfield; G64) and its parenthesis is not needed; for S_nf it is **TRUE given
  C-dG-F1** — and given C-635-F1, with MR at degree 2 only. (b) **TRUE** for S_nf over every real number field (not only totally real),
  given MR(F) at every `F` with `N₆(F) = ∅` and at ℚ(√635087): ⟸ — `χ_CP = 5` makes every countable `F` at most 5 (C-CPUP, no MR); `χ_CP = 7`
  and the conjunct: a field with `N₆ = ∅` and `χ = 6` would give `χ_CP ≤ 6` (C-LB, MR); ⟹ — S_nf and C-635-F1 exclude `χ_CP = 6`, and the
  conjunct is S_nf itself restricted. The conjunct is S_nf on the non-6-thick fields, so the content of (b) is "every 6-thick field is
  decided by `χ_CP`". (c) **GAP (as exact).** Finitely many residue sizes can be non-6-thick: odd `q ≤ 97` (Weil), by my table exactly the
  primes 3, 7, 11, 19, 23, 31, 43, 47, 59, 67, 71, 79, 83 (all `λ* ≥ 1/5` at level one) and possibly 27 (not computed); dyadic inert `Q ≤ 64`
  (`U₆₄`: `15/65`, G56) and ramified dyadic. Those at 3, 7, 11, 19, dyadic `Q ≤ 32` and ramified dyadic have 5-colourable targets, so their
  fields have `χ ≤ L ≤ 5` and drop out. But each remaining residue size is realised by infinitely many local fields `F_v` (unbounded
  ramification `e`; `O_w/𝔓²` is `(ℤ/p²)^{2f}` at `e = 1` and `𝔽_p^{4f}` at `e ≥ 2` — the carry of G66), and a field can have unboundedly many
  such places; so the family of products `UD(ℝ²) × ∏ G_v` is infinite on the page. "Finite" needs a lemma not on record (level collapse of
  CP-colourability to finitely many types, plus merging of multiplicities — I-MERGE covers only identical factors). (d) For all subfields of
  ℝ: S reduces to finitely generated subfields (a 6-chromatic `F` has a finite 6-chromatic graph whose coordinate field `E` has
  `χ(E²) = 6`); number fields, including those with complex places, are (b); transcendence degree `≥ 1` is **missing**: a formally real place
  of `E` gives `χ(E²) ≤ χ(F′²)` for its residue number field, the wrong direction — the step needed is Q-const (G63, open), `χ(E²) = χ(F₀²)`
  for the constant field `F₀`.
- **C-FMT.** (a) **TRUE** (L2; classical: measurable modification of a process continuous in probability). (b) **TRUE**: for the jointly
  measurable version `c̄`, `P(c̄(x) = c̄(x + w)) = 0` for every `(x, w)`, so by Fubini on `Ω × ℝ² × S¹`, for a.e. `ω` the section is a
  Lebesgue-measurable colouring proper at a.e. edge. (c) **GAP at continuity in probability.** The natural construction — a weak limit of
  `f(ρ_Θ x + V_N)`, `V_N` uniform on growing boxes, `Θ` an independent uniform rotation — is stationary and proper at every fixed edge (the
  rotation turns "a.e. `(x, w)`" into "every `w`"), but continuity in probability is not inherited: a hexagonal 7-colouring (tiles of
  diameter `< 1`, same-colour gaps `> 1`, slack on both) whose tile boundaries wiggle at scales tending to 0 far from the origin gives a limit
  with `P(c(0) ≠ c(h)) ↛ 0`. That kills the construction, not the inequality. (d) **GAP** — the null-set step (row 110's GAP-1); not derived.
  `χ_m⁰ ≤ χ_m` is trivial. (e) `χ ≤ χ_m ≤ χ_B ≤ 7` (a Borel colouring is measurable; the hexagonal colouring is Borel); `5 ≤ χ_m⁰` (I-CP57's
  measurable Hoffman bound on edge-null sets); `χ_B` against `χ_CP` is (c)'s GAP.
- **C-CPM: GAP with no MR** — it is (c) for everywhere-proper colourings, and the same construction fails at the same step; it does not follow
  from C-FMT (a)–(b), which give the other direction (`χ_m⁰ ≤ χ_CP`). **TRUE given C-635-F1** (so given MR at degree 2): `χ_CP = χ ≤ χ_m`.

### Would-have-searched-here log (stage 2)
- Would have run a SAT/finder at 27 for `λ*`: not needed — 27 is only named as "possibly non-6-thick"; the spectrum at 27 (exact, seconds)
  is left to the close.

## Stage 3 — SAVED (verdicts; committed before any fenced file is opened)

| claim | verdict | grade | minds (mine) |
|---|---|---|---|
| C-LB | **TRUE** at every `k ≥ 2` (so 4, 5, 6), over every real number field with `N_k(F) = ∅` — wider than stated | [hand] | 1 |
| C-CPUP | **TRUE** | [hand] | 1 |
| C-635-PL | **TRUE** (usable 103, 107, 127, 163, 191, …, ramified 635087 stable; dyadic split) | [tools exact, 2 paths, 3 plants] | 1 |
| C-635-THK | **TRUE**, `sup λ* = 0.192617` (exact at 103), not the stub's Weil 0.1952 | [tools + hand, given I-WEIL] | 1 |
| C-635-F1 | **TRUE given MR(ℚ(√635087))** | [hand] | 1 |
| C-635-TF | **TRUE given C-635-F1 and `χ(ℝ²) ≥ 6`** | [hand] | 1 |
| C-dG-PL | **TRUE** (131, 479 below 600; ramified 3, 5, 7, 11 and 2 not stable) | [tools exact] | 1 |
| C-131 | **TRUE**, 0.168047 < 0.17342 < 1/5 | [tools, float with error bound] | 1 |
| C-dG-THK | **TRUE**, `sup λ* = 0.168047` | [tools + hand, given I-WEIL] | 1 |
| C-MR16 | **NOT REACHED** | — | — |
| C-dG-F1 | **TRUE given MR(`F_dG`)** | [hand] | 1 |
| C-F1-GEN | stub text **MISSTATED** ("real field"; thickness's `k` unnamed); corrected form **TRUE** given MR(F): every real number field with `N₆(F) = ∅`; proposed scope **TRUE** | [hand] | 1 |
| C-S | (a) **TRUE** (trivial for D-S; for S_nf given C-635-F1 or C-dG-F1); (b) **TRUE** given MR, over every real number field; (c) **GAP** at "finitely many local types" (infinitely many local fields per residue size; unbounded multiplicities); (d) **GAP** at Q-const for transcendence degree `≥ 1` | [hand] | 1 |
| C-FMT | (a) **TRUE**; (b) **TRUE**; (c) **GAP** at continuity in probability of the Følner limit; (d) **GAP** (null-set step, not derived); (e) `χ ≤ χ_m ≤ χ_B ≤ 7`, `5 ≤ χ_m⁰ ≤ χ_m`; `χ_B` vs `χ_CP` is (c)'s GAP | [hand] | 1 |
| C-CPM | **GAP** with no MR (the (c) step); **TRUE given C-635-F1** | [hand] | 1 |

**The headline, as I now hold it:** given MR at the single real quadratic field ℚ(√635087), `χ(ℝ²) = χ_CP(ℝ²) = χ(ℚ(√635087)²)`, and the
load-bearing step needs none of T-J39-3's proofs: invariant measure, the `T + A` factor, a support selection, extension to the completion,
weak approximation for the circle, and a mixing selection over the (infinite) compact stable product in the format of processes continuous in
probability. Confidence: medium-high. **The two facts that would change it:** a defect in L3's use of a jointly measurable version inside a
Bochner-integral law argument (I believe it sound), or R-U failing for the trace spectral measure (it needs only `U`-invariance, which
rotation-invariance of `μ` gives).

**Corrections proposed (the close decides):** the stub's C-635-THK number should read "exactly 0.192617 (Weil 0.1952)"; C-F1-GEN's text
should read "every real number field `F` with `N₆(F) = ∅`"; C-S (c)'s "a finite family" should read "a family indexed by finitely many
residue sizes, infinite as stated".

**Stage 4 not started** (budget; the brief's stop rule). Nothing fenced has been opened after the slip logged in §1.1, so a resume can run
stage 4 blind-clean: open `data/fs103/claims-sealed.md` (including the owner's added control), score it, then read the two fenced proofs of
T-J39-3.

## Stage 4 — scoring the sealed half and the fenced proofs (opened only after stage 3's commit e5d65927)

### 4.1 CTL-FRAC first (the owner's addition): does my C-LB run on one colour class at a time? — **No. A second class enters at L3.**

**Steps 1–2, L1, L2, L-WA and L4 do run one class at a time.** Take a rotation- and translation-invariant random independent set `I` of
`Cay(R, U)` of density `δ`, with `p(x) = P(x ∈ I | 𝒜)`. The spectral measure of `1_I − δ` is `U`-invariant, and
`∫_{R̂∖(T+A)} χ(u) dσ_I = −E[p(0)p(u)] ≤ 0`. So either (B) holds, and MR excludes it, or `{p > 0}` is an `𝒜`-measurable independent superset
of `I` with spectrum on `T + A`. That superset extends to a CP random independent set `Ĩ` of `Cay(G, T_G) = X × Cay(K, T_K)`, of density
`δ′ ≥ δ`. The `k`-colour Step 2 is these `k` computations summed over `j`. Its one cross-class use, "some support is non-empty at every
`x`", holds class by class because `I_j ⊆ {p_j > 0}`.

**L3 is where the classes meet.** Its selection `c″(x) = min{j : m_j(x) > θ′}` is defined at every `x` only because the fibre masses sum
to one: `Σ_j m_j(x) = 1`, so `max_j m_j(x) ≥ 1/k > θ′`. The hypothesis `λ* < 1/(k−1)` is exactly `θ = λ*/(1 + λ*) < 1/k`, which is this
pigeonhole value.

For one class, the mixing inequality still makes `{x : m(x) > θ′}` independent in `X`. But the fibre mass `m` only has mean `δ′`, and it
may sit at or below `θ` on a set of positive measure. So the selected set has density at least `(δ′ − θ)/(1 − θ)` and no more.
- Example: at `F_dG`, `θ = 0.168047/1.168047 = 0.1439`.
- From `δ = 1/4`, this gives a CP independent set of `UD(ℝ²)` of density at least `(0.25 − 0.1439)/0.8561 = 0.124`.
- That says nothing against `m₁(ℝ²) ≤ 0.247`.

If `m ≡ δ` were constant, the reader's condition `λ* < δ/(1−δ)` (that is, `θ < δ`) would contradict the edge constraint. That is why
`m` must vary. Once it varies, the one-class transfer loses density.

**So my derivation transfers colourings, not densities.** It gives no bound on `α₁(ℝ²)` against `m₁(ℝ²)`, and the published conjecture of
`[AmbrusEtAl2023]` §4 and `[MatolcsiEtAl2025]` (Conjecture 1) is untouched by it. In the reader's words, the second class enters at "the
step where the other classes enter … where integrality carries F1": **L3's pigeonhole `max_j m_j(x) ≥ 1/k`**, written in my stage 2a as
"(defined: some `m_j ≥ 1/k`)".

Scope of this answer: it covers my derivation only. Whether a cleverer one-class selection could keep the density is not settled here. A
positive answer would imply `α₁(ℝ²) ≤ m₁(ℝ²)` at a 6-thick field under MR. [hand, one mind]

### 4.1′ The owner's follow-up: does L3's random threshold involve a second class? — No.

- **The threshold serves continuity in probability.** The law of `m_j(0)` has at most countably many atoms. A threshold that sits on an
  atom can break continuity in probability, so it must avoid the atoms. Two ways do this:
  - my random `θ′ ~ Unif(θ, 1/k)`, independent of everything else;
  - a fixed `θ′ ∈ (θ, 1/k)` chosen outside the atoms of `m₁(0), …, m_k(0)` — simpler, equally good.
- **For one class, any `θ′ ≥ θ` works.** The set `{m > θ′}` is independent in `X` whatever the threshold.
- **The upper end `1/k` is where the second class enters.** It is the pigeonhole value, and it guarantees that at every `x` some class's
  fibre mass exceeds `θ′`. That coverage is the only cross-class step (§4.1).

### 4.2 The sealed half, scored against my derivation

**§0 I-MX.** My L3 is its form for colourings continuous in probability (CP), over a countably infinite product. The sealed half says that
form is not an input; I derived it (after the logged slip, having seen I-MX's statement only). The two forms diverge in one step:
- I-MX selects with the fixed threshold `λ*/(1+λ*)`. That is sound for Borel and measurable colourings.
- In the CP format, the threshold must avoid the atoms of `m_j(0)`, or the selected colouring may fail continuity in probability. I-MX does
  not need this, since it has no continuity requirement.

**§A sub-claims.**

| sub-claim | score |
|---|---|
| C-THKDEL | **agree** — it is my L3, with `H = L ⊗ ℝ` (the proof is written for any second-countable LCA `H`). `λ*(⊗ν_v) ≤ sup_v λ*(ν_v)`, with its line: a non-trivial character is non-trivial on finitely many factors, and the product of those coefficients is at most any one of them. Only "≤" is needed. The advisor's control checked: at `λ* = 1`, `θ = 1/2 = 1/k`, so L3 has no room for a threshold and stops. The values `χ(Cay(ℝ, {±1, ±√2})) = 2` and `χ_CP = 3` are both confirmed. **Lower:** odd elements `a + b√2` (`a + b` odd) accumulate at 0, and each flips the colour a.s., so continuity in probability fails for two colours. **Upper:** `⌊3·frac(0.4x + β)⌋` with `β` uniform, since `0.4` and `0.4√2 ≡ 0.5657` both lie strictly inside `(1/3, 2/3)` mod 1. **Found extra:** the threshold-atom step (above). |
| C-EXTk | **agree** — it is my L2, over every real number field with `R = O′`, not only totally real ones. The extension is to all of `G_∅`, by L1 (b)'s density. Properness is proved on `cl ι(U)` by approximating `w` with `u_n ∈ U`. Both wrong-reason lines are avoided. |
| C-APX | **agree** — (a) is my L-WA and (b) is my L1 (b)–(c). The wrong-reason line is avoided: the reason is named — the norm-one torus of `F(i)/F` is the conic `x² + y² = 1` with the rational point `(1, 0)`, so it is `F`-rational, and rational varieties satisfy weak approximation. Density in the infinite product follows from density at every finite set of places (product topology). |
| C-MERGE-n | **agree for totally real `F`** — "⟹" by my L4 (the diagonal); "⟸" by pulling back along one coordinate's projection. **Found extra:** at a complex place, "⟸" fails by this route. No continuous additive map `ℂ² → ℝ²` sends the hyperbola `{(z, 1/z)}` into the circle (boundedness as `z → ∞` forces it to be 0). Only "⟹" is available there, and "⟹" is all that C-LB and C-F1-GEN use. |

**§B wrong-reason lines.**
- **C-LB (i)–(viii):** all avoided.
  - (i) Nothing fenced was cited or read before stage 3, apart from row 109's statement (the logged slip).
  - (ii) Deletion is by `λ* < 1/(k−1)` through the mixing inequality, never by an independence ratio.
  - (iii) `max|λ|` is taken over all non-trivial characters, both signs (§2.1).
  - (iv) There is one threshold for all places at once, from `sup_v` (Step 0).
  - (v) The jointly measurable version is proved (L2).
  - (vi) Fubini is applied per fixed edge `(x, x+w)` of `X`, over `Ω × K × T_K`, and yields properness at that edge a.s.
  - (vii) The argument does not run on CTL-ABS: its compact factor carries the parity character with `λ* = 1`.
  - (viii) The law of `m_j` is fixed through its `L²(P)`-Bochner-integral form (L3).
- **C-635-PL:** avoided. I recorded 2 as ramified in `F` (`e = 2`), with its one place split in `L/F`. My reason is PARI's prime counts;
  the advisor's reason (`ℚ₂(√635087) = ℚ₂(√7) = ℚ₂(i)`, as `635087 ≡ 7 ≡ −1 (mod 8)`) agrees.
- **C-635-THK:** avoided. The ramified 635087 is included. The dyadic place is not stable, so it is not in the product. Weil is applied
  only at `q ≡ 3 (mod 4)`.
- **C-dG-PL:** avoided. Residue fields are read from `F_dG` itself (PARI; 11 has `f = 2`), and ramified primes are listed.
- **C-S:** avoided — (d) names the transcendence gap, and (c) counts local fields, not residue fields.
- **C-S (c), the registered expectation:** **agree** — infinite at full depth. I add two things: multiplicities are unbounded, and residue
  sizes 3, 7, 11, 19, dyadic `Q ≤ 32` and ramified dyadic drop out, because their fields already have `χ ≤ L ≤ 5`.
- **C-F1-GEN:**
  - Line (1) is avoided. At `k = 7` I use `χ_CP ≤ 7` directly, never C-LB. At `F_dG`, 131 gives `0.168047 > 1/6`, so C-LB at 7 would be
    wrong.
  - Line (2) is avoided: MR and `λ* < 1/(k−1)` are both used.
  - **Line (3) — "a chain valid for fields with complex places" — I dispute.** My chain is valid there, and I hold that this is correct,
    not a wrong-reason sign. At a complex place, the only step that changes is L4, and it restricts to the compact real form (the circle
    inside the hyperbola, as row 123 describes the complex-place step). No step needs the failing "⟸" of the merge. Every input — I-C′, R-U,
    MR (row 120: every real number field with `R = O′`), strong and weak approximation — holds at any real number field. **For the owner:**
    either the line guards against a merge "⟸" that my chain does not use, or it names a step I have missed. I cannot find one.

**§C controls.**
- **CTL-167-4: reproduced.** The stable places of ℚ(√167) start at 23: by Legendre, 3, 7, 11, 19, 31 are inert and 23, 43 split; 167 is
  ramified and stable; the dyadic place is split. `sup λ* = 0.331695 < 1/3` at 23 — a margin of `0.0016`. So `N₄ = ∅`, and C-LB at 4 with
  I-CP57 gives (B), hence `χ ≥ 5` given MR. This agrees with row 123.
- **CTL-dG4: reproduced.** `sup λ* = 0.168 < 1/3`, so given MR, `χ(F_dG²) ≥ 5`, agreeing with I-DG5.
- **CTL-K-4 = my K1: reproduced.**
- **CTL-K7-6: agree.** `λ*(83) = 0.210818`: at least `1/5`, so not 6-thick, and below `1/4`, so 5-thick. The claim list's `0.217` is
  Weil's bound. The chain stops at `N₆ ≠ ∅` and goes through at `k = 5`. "First stable place at 83" is taken from row 68 and G43, not
  recomputed. At 3, 7 and 11 the residue degree in `K(√7)` is 2 (my Legendre check), and the dyadic place is split.
- **CTL-K5-5: reproduced.** `λ*(11) = 0.476 ≥ 1/4`; the chain stops.
- **CTL-167-5: agree.** `λ*(23) = 0.3317` and `λ*(43) = 0.2719` are both at least `1/4`. 47 is inert, and 59 splits with
  `λ* = 0.248626 < 1/4` (a margin of `0.0014`). Row 110's "0.199119854095" at 59 is a different quantity (a ratio), not `λ*`.
- **CTL-ABS: checked** (above).
- **CTL-Q2 = my K4: reproduced.**
- **CTL-FRAC:** §4.1.

### 4.3 The fenced proofs of T-J39-3, against mine

The sources, both read in full at their proof sections:
- the wanted poster (J39, Poros), `plans/POROS-2026-09-25-wanted-poster-167.md` §3.2 — **P**;
- J48's blind check, `plans/FS100-BC-verification.md` §2.1 (L1–L7) and §2.2 (BC-1) — **B**.

**Divergences of truth: none found.** All three derivations reach the same dichotomy by the same five movements, with the same threshold
interval `(λ*/(1+λ*), 1/k)` and the same threshold placed at random. The movements are:
1. an `R ⋊ U`-invariant measure;
2. the simplex identity at `k`;
3. R-U for `τ(E) = 0`;
4. the support selection;
5. extension to the completion, weak approximation, and the mixing selection over the product of all thick places.

P's number at 59, `0.24863`, matches my exact `0.248626`. That the skeleton is shared looks forced by the statement, not copied: I wrote
mine before opening either.

**Divergences of route and of rigour:**

| step | P | B | mine |
|---|---|---|---|
| the `T + A` factor, and `R` dense in `G` | J45-N1/N2, cited | N1/N2 plus FS-91's Lemmas C and C′ (profinite = stable topology) | re-derived. The factor comes from Bochner on `G`. Density comes from strong approximation for the additive group off one split prime, plus `R = O′`. |
| row 100's exception | not treated | handled: `Ĝ` has finite index in `Ĝ⁺`, and the colouring is extended by independent copies on the cosets | excluded, because `N_k = ∅` forces it out (a ramified stable dyadic place has `λ* = 1`). That suffices for C-LB, but **not for T-J39-3 in general**, where `N_k ≠ ∅` is allowed. B's coset step is the one needed there. |
| the extension | Mackey's point realisation | limits in probability | limits in probability (as B) |
| the measurable version | **not taken**: "runs fibrewise" and uses `Haar{b : C(x, b) = j}` directly — wrong-reason line (v) of the sealed half | taken, citing Doob–Cohn | proved (my L2, Borel–Cantelli on a dense sequence) |
| the law of `m_j` (sealed line (viii)) | not addressed | "stationary … because `c` is under `G × K`" — **line (viii) as the advisor wrote it**. True, but the step fixing the law of `m_j` from finite-dimensional laws is not written | written: `m_j(x)` is the `L²(P)`-Bochner integral of `y ↦ 1[c̃(x, y) = j]`, whose law is fixed by finite-dimensional laws |
| continuity in probability of the selection | `E|m_j(x) − m_j(x′)| ≤ P(…)`, the threshold missing the values a.s. | `P(φ(x) ≠ φ(y)) ≤ Σ_j E|Δm_j|/|I|` — cleaner than mine | a `δ`-split bound, equivalent |
| new levels, `2/(q+1)` | cited | the two-point bound (FS86-LP, M3-J22-T8) | re-derived (V2-NL): the same count of lines through 0, found independently |
| merging real places | J21-SL (`C(x, x + s, y)`) | a diagonal pullback (L4) | a diagonal restriction (L4) — as B |
| complex places | "Not claimed" | "`F` totally real so `L⊗ℝ = ℂⁿ`" | **claimed**, by restriction to the compact real form. **One mind; the owner should weigh it** (§4.2, sealed line C-F1-GEN (3)). |

**Count of minds for C-LB's statement at `N_k = ∅`:**
- Three derivations: P, B and mine. Mine is blind to both proofs; my only exposure was row 109's statement, as logged.
- The three share the forced skeleton, and none contradicts another.
- Mine alone writes the law of `m_j` (line (viii)); P omits the measurable version; B's is cited.
- **Grade:** C-LB for totally real `F` with `N_k = ∅`: [hand, three derivations, one of them — mine — blind to the other two]. The
  complex-place widening: [hand, one mind].

**Stage 4 — SAVED** (4.1 accf865d, 4.2 f0fb8887, 4.3 45407020). Would-have-searched-here: none in stage 4 (the control checks were one line of float arithmetic).
