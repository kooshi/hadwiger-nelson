# FS-84 S1 — the derivation stage of "ℚ(√47): five colours"

*Crunch job **J31** (2026-09-25), de Bruijn, Opus 5.5. Brief: `data/crunch-2026-09-25/briefs/J29-S1-FS84-derivation.md` (written by J29) with
`data/crunch-2026-09-25/briefs/STANDING-RULES.md`; the plan `plans/FS84-five-colours-47.md` (read in full). **Owner's ruling:** S1 runs now,
during the crunch, under the finite-witness ban (to 2026-10-01); anything needing a solver is handed to the post-ban stages, named. Tools
`tools/fs84_s1_*.py`; data `data/fs84/s1/`. A blind verifier (S1V) checks this record later; its files are not read here.*

## Theorems this phase proved

| id | statement (short) | grade | address |
|---|---|---|---|
| S1a | `ρ_per(ℚ(√47)) ≤ h*(31) = 0.2499972548… < 1/4`; binding place 31, margin `2.745·10⁻⁶`; so no periodic four-colouring of any `R`-coset of ℚ(√47)² | hand + cert + tools exact; one derivation here (inputs named in §1.4) | §1.3–§1.5 |
| S1a-P | Lemma P at every odd stable tower (re-derived): a character new at level `m ≥ 2` has `\|λ\| ≤ 2p^{m−1}`; so the tower's Hoffman ratio is `L/(p+1+L)`, `L = max(\|λ_min(Γ_p)\|, 2)`, at every level | hand (second derivation after FS86-LP) + tools (FFT at 47-ramified and 31-inert, level 2) | §1.3 step 7 |
| S1a-J | the joint image: `ρ_N(U) = ∏_{𝔓 ∈ S_N} S_{𝔓,K_𝔓}` for ℚ(√47) (weak approximation for the rational torus) | hand (same route as J07's CLG-c (W), (J)) | §1.3 step 3 |
| S1b | invariant-measure equivalence (i), the `1/k` density (ii), the window form (W), and the identities `ι_G = 1/χ_{f,0} = 1/ρ = 1/χ_{gf,G,0}` (iii) | hand; one derivation | §2.2 |
| S1b-47 | `ρ_per(ℚ(√47)) = max_𝔓 r_𝔓 ∈ [28/121, h*(31)]`; `ι(ℚ(√47)) < 1/4` iff a finite `H` has `α(H) < |H|/4` (would refute `[MatolcsiEtAl2025]`'s `α₁(ℝ²) = 1/4`) | hand | §2.3 |
| S1c | no band character of order dividing 168 or of stable prime order ≤ 47 on any of the ten minimal survivors | tools exact (complete enumeration of a derived set) | §3.2 |
| S1d-K | the window graph is `K_{2,3}`-free: `e(W) ≤ w(1 + √(8w−7))/4`; radius-1 windows are stars | hand | §4.1 |
| S1e | linear tetrahedral identities are class-balance statements; none exists on a lattice with one gapped four-colouring; G75's mechanism is vacuous without `√3` | hand; one derivation | §4.2 |

## Stage 1 — SAVED

### 1.1 Quotation check (standing rule 5)

| # | the brief's (or the owner's) statement | source | verdict |
|---|---|---|---|
| Q1 | S1a: "`ρ_per(ℚ(√47)) < 1/4`", where "`ρ_per(F) = sup_L α(Cay(R/L, U+L)) / [R : L]` over finite-index `L ≤ R = ℤ[U_F]` with `U ∩ L = ∅`" | plan §5.1 first bullet | **verbatim** |
| Q2 | "Obligations a1–a4 of plan §M.2; **do not use `[AmbrusEtAl2023]`**" | plan §5.2 a1–a4 | **faithful**; a1 is marked there "[A: Lemma C, J07, one mind — flag it]", a2 "[A: CLG-c]" — both re-derived below (§1.3 steps 2–3), so neither is assumed |
| Q3 | "State the ramified 47-place's all-levels ratio explicitly (Lemma P, Theorem E). Name the binding prime and its margin." | plan §5.1 ("Unsampled member: the ramified 47-place (Lemma P, Theorem E) — its all-levels ratio must be stated, not assumed"); "The binding factor is **31** … `1/4 − 2.745·10⁻⁶`" | **faithful** |
| Q4 | S1b: "For a countable amenable group `G` acting on a graph `Γ` by automorphisms: `Γ` is `k`-colourable iff there is a `G`-invariant Borel probability measure on its proper `k`-colourings; hence … `k`-colourable ⟹ `ι_G(Γ) ≥ 1/k`." | plan §5.1 second bullet | **faithful with an ellipsis that drops a hypothesis**: the elided text is "with `ι_G(Γ) = sup_μ μ{I ∋ v₀}` over `G`-invariant measures on independent sets (vertex-transitive `G`)" — the vertex-transitivity of `G` is what makes `ι_G` independent of `v₀`; restored in Stage 2's statement |
| Q5 | Johnson 1996 (Zbl 0856.05036), Johnson 2000 *surprises* (Zbl 0945.05021), Johnson–Rodger 2005 (Zbl 1059.05050) | plan §3.1 PA5 | **faithful** |
| Q6 | S1c: "a **rational** `θ` on a ℤ-basis of `Λ_M` with every `θ(u) mod 1 ∈ [1/4, 3/4]`, `u ∈ U_M`, checked in Fractions, or a named obstruction. The candidate set is the finite set of torsion-type assignments per layer that rows 95 and 97 allow — fix it by derivation before any check" | plan §5.1 S1c bullet; §5.2 c1–c2 ("the finite set of torsion-type assignments per layer that row 95's six types and row 97's leaves allow") | **faithful** |
| Q7 | "only 1560 and 2040 have two primes ≡ 1 (mod 4) below 2,520; Λ₁₅₆₀ four-colours by a quotient" | plan §5.1 S1c bullet ("among `M ≤ 2,520` with `24 \| M` only 1560 (`5·13`) and 2040 (`5·17`) have two primes ≡ 1 (mod 4)") | **faithful, but the brief drops "with `24 \| M`"** — the restriction is what makes the count two; re-checked in Stage 3 |
| Q8 | S1d: "the window `W` (radius ≥ 2, row 87), the symmetry quotient, the orbit-reduced variable and constraint counts, the dual's form as an identity, and a price" | plan §5.1 last bullet, §IQ item 3 | **faithful** |
| Q9 | S1e: "a local pattern forbidden in every four-colouring … linear on the tetrahedral embedding (G75, row 85's NT)"; "P-G75 predicts none" | G75; plan §4.3 P-G75 | **faithful** |
| Q10 | "ℚ(√47)'s plane needs four colours and at most five (rows 73, 82, 52)" | row 73 (169-point certified witness, `[certified, tools]`), row 82 (`d ≡ 11 mod 12`, hand), row 52 (11 usable, degree one) | **faithful**; grades omitted (row 73's is a checker's word, not the kernel's) |
| Q11 | "Every periodic, character and measurable-window four-colouring is already excluded (rows 92, 96)" | row 92 ("**Type (A), the close's corollary (one mind):** every factor has ratio `< 1/4` …"; rests at the real place on `[AmbrusEtAl2023]`); row 96 | **faithful, grade omitted**: row 92's type-(A) clause is one mind and external-dependent; S1a below is a second, AmbrusEtAl-free derivation of its periodic case |
| Q12 | the owner: CLG_k is "a band k-character of the plane exists iff some stable place carries one at some level; hence χ_char(F²) = min over the targets" (`plans/FS91-S1D-character.md` line 366) | line 366: "\| J07-7 \| CLG_k for every real number field and every `k ≥ 2`, given `H_k`; `χ_char(F²) = min χ_char(T_{𝔓,m})`; the converged `κ` form \|"; plan Q5 quotes §3.1's form | **faithful paraphrase, not verbatim**, dropping "given `H_k`" (per J07, `H_k` holds at every `k` by the owner's ruling). Not used by S1a |
| Q13 | the plan's "every stable place is odd with prime `q ∈ {11, 19, 23, 31, 43, 47 (ramified), 59, …}`" (§1.2) | computed (tool (A), rule and PARI agree below 400) | **one slip: 59 is not stable** — `(47/59) = −(59/47) = −(12/47) = −1`, so 59 is inert in ℚ(√47); the stable list is 11, 19, 23, 31, 43, 47, **67**, 107, 127, … (§1.3 step 7). Harmless to every conclusion (59 would only be handled by Weil) |

### 1.2 Notation for this record

`F = ℚ(√47)`, `E = F(i) = ℚ(√47, i)`, `c` complex conjugation (the generator of `Gal(E/F)`). `U = {z ∈ E : z·c(z) = 1}` (the unit vectors of
`F²`, via `(x, y) ↦ x + iy`); `R = ℤ[U]` — since `U` is closed under products, **`R` is the additive group generated by `U`**, so the
unit-distance graph `Cay(E, U)` is a disjoint union of copies of `Cay(R, U)`, one per coset. A **stable place** is a prime `𝔓` of `E` with
`c(𝔓) = 𝔓`. For such `𝔓` over `𝔭` of `F`: `O_𝔓` the completion's integers, `T(O_𝔓) = {z ∈ O_𝔓 : z·c(z) = 1}`, `A_{𝔓,m} = O_𝔓/𝔓^m`,
`S_{𝔓,m}` the image of `T(O_𝔓)` in `A_{𝔓,m}`, `G_{𝔓,m} = Cay(A_{𝔓,m}, S_{𝔓,m})`, and the **all-levels ratio**
`r_𝔓 = sup_{m ≥ 1} α(G_{𝔓,m}) / |A_{𝔓,m}|`.

### 1.3 S1a — the periodic independence ratio of ℚ(√47)

> **Theorem S1a.** `ρ_per(ℚ(√47)) ≤ sup_𝔓 r_𝔓 ≤ h*(31) = 0.2499972548… < 1/4`, where `h*(p) = L_p/(p + 1 + L_p)`,
> `L_p = max(|λ_min(Γ_p)|, 2)`, and `|λ_min(Γ₃₁)| = 10.666510494…`. The binding place is 31 (two stable primes, conjugate under
> `√47 ↦ −√47`); the margin is `1/4 − h*(31) = 2.7452·10⁻⁶`.
>
> **Corollary S1a′.** No proper four-colouring of `Cay(R, U)` is invariant under a finite-index subgroup `L ≤ R`; so no proper colouring of
> ℚ(√47)² with four colours is periodic on any `R`-coset, and every periodic colouring of one needs `≥ ⌈1/ρ_per⌉ = 5` colours.

**Proof.**

1. *Unit vectors are units at stable places.* For `z ∈ U`, `0 = v_𝔓(z·c(z)) = v_𝔓(z) + v_{c(𝔓)}(z) = 2v_𝔓(z)`. So `U ⊆ T(O_𝔓)` for every
   stable `𝔓`.
2. *Finite quotients live at stable places (a1).* For `N ≥ 1` let `S_N` be the stable primes dividing `N` and `K_𝔓 = v_𝔓(N)`. Then
   `ρ_N : R → ∏_{𝔓∈S_N} A_{𝔓,K_𝔓}` is onto with kernel `NR`. **Two routes.** (i) *Lemma R* (FS86-B1-LR, two derivations; for real
   quadratic `F` it is `[Fischer1990b]` Thms 1, 3, 4, prime inversion): `R = {x ∈ E : v_𝔓(x) ≥ 0 at every stable 𝔓}`, a localisation of
   `O_E` whose maximal ideals are the stable primes; its hypotheses hold here (`F` real, `E/ℚ` biquadratic hence Galois, `E/F` ramified only
   above 2, where no prime is stable — step 7). CRT gives `R/NR ≅ ∏_{𝔓∈S_N} R/𝔓^{K_𝔓} ≅ ∏ A_{𝔓,K_𝔓}`. (ii) *J07's Lemma C (c) with C′*
   (`plans/FS91-S1D-character.md` §2.3–2.4, one mind, no Lemma R): `R/NR ≅ ∏_{stable 𝔓|N} O_𝔓/NO_𝔓`, the exception being a ramified stable
   dyadic place, which `E` does not have. If `S_N = ∅` then `NR = R`.
3. *The joint image (a2).* `ρ_N(U) = ∏_{𝔓∈S_N} S_{𝔓,K_𝔓}`. "⊆" is step 1. "⊇": each `𝔭` below a stable `𝔓` has only `𝔓` above it
   (`E ⊗ F_𝔭 = E_𝔓` is a field, `i ∉ F_𝔭`), so distinct stable primes lie over distinct places of `F`. The Cayley map
   `φ(s) = (1 + is)/(1 − is)` sends `F` into `U` and `F_𝔭` continuously onto `T(F_𝔭) ∖ {−1}` (`s = b/(1 + a)` for `a + bi ≠ −1`;
   `1 + s² ≠ 0` as `i ∉ F_𝔭`). A target `t_𝔓 ∈ S_{𝔓,K}` has preimage in `T(O_𝔓) = T(F_𝔭)` a coset of the open subgroup `T(1 + 𝔓^K)`,
   infinite, so it contains points `≠ −1`, and its `φ`-preimage in `F_𝔭` is open and non-empty. `F` is dense in `∏_𝔭 F_𝔭` (weak
   approximation), so some `s ∈ F` lies in every preimage, and `φ(s) ∈ U` hits every `t_𝔓`. ∎ (This is J07's CLG-c (W), (J); derived here
   without reading theirs beyond the statement.)
4. *The quotient is a categorical product.* By steps 2–3, `Cay(R/NR, U + NR) ≅ Cay(∏ A_𝔓, ∏ S_𝔓)`, and `Cay(A × B, S × T)` **is** the
   categorical product `Cay(A, S) × Cay(B, T)` (adjacent iff adjacent in every coordinate). So `Cay(R/NR, U + NR) ≅ ×_{𝔓∈S_N} G_{𝔓,K_𝔓}`.
5. *Pullback (a3).* Let `[R : L] = N`, `U ∩ L = ∅`. Then `NR ⊆ L`, and `π : R/NR → R/L` is an onto homomorphism with `π(U + NR) = U + L ∌ 0`.
   For an independent `I` of `Cay(R/L, U + L)`, `π⁻¹(I)` is independent (if `x, x + u ∈ π⁻¹(I)`, then `π(x), π(x) + π(u) ∈ I` with
   `π(u) ∈ U + L`), with the same density. So `α(Cay(R/L, U + L))/[R : L] ≤ α(×G_{𝔓,K})/∏|A_{𝔓,K}|`.
6. *The product's ratio (a3, second half).* `[Zhang2012]` Thm 1.8 (arXiv v1, held and read in full; as the bibliography records it: "for
   vertex-transitive G, H with α(G)/|G| ≥ α(H)/|H|, α(G × H) = α(G)|H|"); every `G_{𝔓,K}` is a Cayley graph, a categorical product of
   Cayley graphs is a Cayley graph, so by induction on `|S_N|` the product's ratio is `max_{𝔓∈S_N} α(G_{𝔓,K})/|A_{𝔓,K}| ≤ max r_𝔓`.
   Hence `ρ_per ≤ sup_𝔓 r_𝔓`. (Zhang is needed only because the bounds at 11 and 19 are certificates, not Hoffman bounds: for Hoffman
   factors alone, `λ_min(G × H) = min(d_G·λ_min(H), d_H·λ_min(G))` and the product's Hoffman ratio is already the factors' maximum.)
7. *The stable places (a4).* A prime `𝔭` of `F` is under a stable prime iff it does not split in `E/F`. For odd `p ≠ 47`: if `p` is inert in
   `F` the residue field is `𝔽_{p²}`, `−1` a square, so `𝔭` splits in `E` — not stable; if `p` splits in `F` (`(47/p) = 1`), residue `𝔽_p`,
   stable iff `p ≡ 3 (mod 4)`. `p = 47` is ramified in `F`, residue `𝔽₄₇`, `47 ≡ 3 (mod 4)`: stable (inert in `E/F`). `p = 2` is ramified in
   `F` (`47 ≡ 3 mod 4`) and its prime splits in `E` (`−47 ≡ 1 mod 8`, so `2` splits in `ℚ(√−47) ⊂ E`): not stable. So the stable places lie
   over **47 and the primes `p ≡ 3 (mod 4)` with `(47/p) = 1`** (equivalently `(p/47) = −1`) — below 400: 11, 19, 23, 31, 43, 47, 67, 107,
   127, 139, 151, 163, 167, 179, 199, 211, 223, 227, 311, 359, 367 (rule and PARI agree: tool (A)). **3 and 7 are not stable** (both inert
   in `F`), which is why `L(ℚ(√47)) = 5`: `Γ₃` and `Γ₇` have ratio `1/3` and `2/7`. For `p ≠ 47`, `O_𝔓 = ℤ_p[i]` and `G_{𝔓,m} =
   UD(ℤ/p^m, 2)` (the inert tower); at 47, `O_𝔓 = ℤ₄₇[π][i]` with `π = √47` **fixed by `c`**, `𝔓² = (47)`, `A_m = O_𝔓/π^m`. At every
   stable place `A_{𝔓,1} = 𝔽_{p²}` and `S_{𝔓,1} = μ_{p+1}`, so `G_{𝔓,1} = Γ_p`; and `S_{𝔓,m}` is the whole norm-one set of `A_m` (the
   norm from the unramified `E_𝔓` maps `1 + 𝔓^m` onto `1 + 𝔭^m`), of size `(p+1)p^{m−1}`.

   **Lemma P (re-derived).** *At every stable place, a character `ψ` of `(A_m, +)`, `m ≥ 2`, non-trivial on `π^{m−1}A_m` has
   `|λ_ψ| = |Σ_{s∈S_m} ψ(s)| ≤ 2p^{m−1}`.* The norm-one elements above `s̄ ∈ S_{m−1}` are `s(1 + π^{m−1}x)` with `x ∈ 𝔽_{p²}`,
   `x + x̄ = 0` (as `c(π) = π` and `2(m − 1) ≥ m`): `p` of them, forming `s + π^{m−1}·s₀·γ𝔽_p` (`s₀ = s mod π`, `γ𝔽_p` the trace-zero line).
   `ψ` restricted to `π^{m−1}A_m ≅ 𝔽_{p²}` is `y ↦ e_p(Tr(βy))`, `β ≠ 0`, so the fibre sums to `ψ(s)·p` if `βs₀ ∈ 𝔽_p` and to 0
   otherwise. `β⁻¹𝔽_p^× ∩ μ_{p+1}` has at most two points (a quotient of two lies in `𝔽_p^× ∩ μ_{p+1} = {±1}`), and each `s₀` has
   `p^{m−2}` points of `S_{m−1}` above it; so `|λ_ψ| ≤ 2·p^{m−2}·p`. ∎ A character that factors exactly through level `j` has eigenvalue
   `p^{m−j}` times a level-`j` primitive one, so every eigenvalue of `G_m` is `≥ −p^{m−1}·L_p`, and Hoffman's ratio bound gives
   `α(G_m)/|A_m| ≤ L_p/(p + 1 + L_p) = h*(p)` **at every level**. (FS86-LP's statement, same route; this is a second derivation.)
   *Controls* (tool (E), numpy FFT): at the ramified 47, level 2 (`|A₂| = 47⁴`), `|S₂| = 2,256 = 48·47`, `max |λ_primitive| = 94.000000`
   (the bound, attained), `λ_min(G₂) = −603.786803 = 47·λ_min(Γ₄₇)`; at the inert 31, level 2 (`UD(ℤ/961, 2)`), `|S₂| = 992`,
   `max |λ_primitive| = 61.99967 ≤ 62`, `λ_min(G₂) = −330.661825 = 31·λ_min(Γ₃₁)`.
8. *The numbers* (tool `tools/fs84_s1_ratio_table.py`, output `data/fs84/s1/ratio_table.out`, JSON `ratio_table.json`; `λ_min` in
   rigorous interval arithmetic at 40 digits, widths `≤ 1.1·10⁻³⁸`; `h* < 1/4` decided by `L < (q+1)/3` on the interval's upper end):

   | stable `p` | level-one `λ_min(Γ_p)` | Hoffman `h*(p)` | bound used for `r_𝔓` | how |
   |---|---|---|---|---|
   | 11 | −4.795754778 | 0.285534 (fails) | **0.233094** = `U/121`, `U = 28.204320…` | FS-66 certificate (`cert-p11.json`, sha256 `683236677e0d…`), **re-checked here: CERTIFIED at `--m 4`, 6.9 s** (`data/fs84/s1/fs66-check-p11-m4.out`); links L1–L6 |
   | 19 | −7.609728632 | 0.275618 (fails) | **0.214714** = `U/361`, `U = 77.511742…` | FS-66 certificate (`cert-p19.json`, `055f031d1e69…`); re-check: see §1.5 |
   | 23 | −7.960687187 | 0.249077 | 0.185226 (`U/529`) or Hoffman 0.249077 | either |
   | **31** | **−10.666510494** | **0.2499972548** | **0.2499972548** | Hoffman + Lemma P — **binding** |
   | 43 | −11.962230123 | 0.213755 | 0.213755 | Hoffman + Lemma P |
   | 47 (ramified) | −12.846527722 | 0.211130 | **0.211130 at every level** | Hoffman + Lemma P; levels 1–2 exactly equal by Theorem E (below) |
   | `≥ 67` | `\|λ\| ≤ 2√p` (Weil) | `≤ 2√p/(p+1+2√p) ≤ 0.194033` | `h(67) = 0.194033` | Weil + Hoffman + Lemma P |

   *The tail:* `2√p/(p + 1 + 2√p) < 1/4 ⟺ 36p < (p + 1)² ⟺ p(p − 34) + 1 > 0`, true for every `p ≥ 34`; `2s/(s + 1)²` is decreasing in
   `s = √p > 1`, so the tail's sup is at its least member, 67. Weil's bound for the eigenvalues of `Γ_p` (Kloosterman sums over the
   norm-one torus, G44; FS86-B1 `kloosterman_check.py`) is the one external analytic input. **The ramified 47-place, stated:**
   `r_47 ≤ h*(47) = 12.8465/(48 + 12.8465) = 0.2111300 < 1/4` at every level (Lemma P, Hoffman); by FS-66's **Theorem E**
   (`plans/FS66-tower-conjecture.md` §3.2: "the first `e` levels of the tower of a ramified place are impotent") levels 1 and 2 are
   homomorphically equivalent to `Γ₄₇`, so there the true ratio is exactly `α(Γ₄₇)/47²`; from level 3 on only the Hoffman bound is claimed.
9. *Assembly.* `sup_𝔓 r_𝔓 ≤ max(0.233094, 0.214714, 0.185226, 0.2499972548, 0.213755, 0.211130, 0.194033) = h*(31)`, attained in the
   bound at 31 and strictly below 1/4. With steps 5–6, `ρ_per(ℚ(√47)) ≤ h*(31)`. *Corollary:* a proper four-colouring of `Cay(R, U)`
   invariant under finite-index `L` has `U ∩ L = ∅` (else `c(0) = c(u)` for the edge `0 ~ u`) and descends to `Cay(R/L, U + L)`, whose
   largest colour class is independent of ratio `≥ 1/4 > ρ_per`: impossible. `1/h*(31) = 4.000044`, so five colours is also the least for
   periodic colourings. ∎

### 1.4 What S1a rests on, by name, and what it does not

- **Rests on:** Lemma R (FS86-B1-LR, two derivations; `[Fischer1990b]` for real quadratic fields) **or** J07's Lemma C + C′ (one mind) —
  two independent routes to step 2; weak approximation for `F` (standard); `[Zhang2012]` Thm 1.8 (held, read in full; external); FS-66's
  certificates at 11 and 19 (frozen checker; links L1–L6 hand, `data/fs66/b1/SOUNDNESS.md`); Lemma P (FS86-LP, two derivations, plus
  this one and two FFT controls); Weil's bound (external, standard) for `p ≥ 67`; interval arithmetic for 23, 31, 43, 47.
- **Does not rest on:** `[AmbrusEtAl2023]` (no real place enters: a periodic colouring factors through finitely many finite places);
  CLG or `H_k`; row 92's measurable-window machinery; any solver.
- **Load-bearing numbers:** the margin at 31 (`2.745·10⁻⁶` in the ratio, `1.5617·10⁻⁴` in `λ_min`); the certificates at 11 and 19 (Hoffman
  fails there, 0.2855 and 0.2756). If FS-66's certificate at 11 were withdrawn, S1a has a gap exactly at 11 (as FS86-V3 does).
- **Plants** (all fired; `data/fs84/s1/ratio_table-plant-*.out`): `seven` (7 declared stable: the max fails at `2/7`-type ratio 0.3597);
  `thirty-one` (`λ_min(Γ₃₁)` shifted by `−2·10⁻⁴`, past the margin: fails, and the level-2 control fails with it); `lemmaP` (the
  primitive bound tightened to `2q − 1/2`: fails at the ramified 47, where the bound is attained).
- **Scores P-S1a** (plan §4.3, "S1a's no-periodic theorem stands on two derivations without `[AmbrusEtAl2023]`", 0.85): **one derivation
  here, without AmbrusEtAl**; with row 92's type-(A) corollary (one mind, but *with* AmbrusEtAl) it is not yet two AmbrusEtAl-free
  derivations — S1V's blind check would make it two. The GAP the plan feared at the ramified 47 did not open: Lemma P's proof uses only
  `c(π) = π`, which holds at 47.

### 1.5 Stage 1 notes

- The FS-66 re-check at 19 (`--m 4`) was launched in the background; its output is `data/fs84/s1/fs66-check-p19-m4.out` (read at Stage 2).
- **Would have searched here:** none in Stage 1 (every step was a derivation or an exact computation of seconds on a derived finite set:
  the stable-place table below 400, eight level-one spectra, two level-2 spectra).
- **Proposed correction** (for the front-page lane / plan owner): `plans/FS84-five-colours-47.md` §1.2's stable list "…, 47 (ramified), 59,
  …" → "…, 47 (ramified), 67, …" (59 is inert in ℚ(√47)).

## Stage 2 — SAVED

### 2.1 The Johnson reading (G50; read status per item)

| key (proposed) | what was obtained | read status |
|---|---|---|
| Johnson 1996, *About two definitions of the fractional chromatic number*, Geombinatorics 5(3) (1996) 99–108, Zbl 0856.05036 | zbMATH review (Marek Kubale), `data/fs84/s1/zbmath-0856.05036.json`: the LP and set-colouring definitions of `χ_f` agree when `χ_f` is finite; open problems "with a particular emphasis on infinite graphs" | **review only**; the paper is in Geombinatorics, whose archive refuses scripted fetches |
| Johnson 2000, *Infinite graphs and the fractional chromatic number: some recent surprises*, Zbl 0945.05021 | zbMATH review (Arthur T. White), `…-0945.05021.json`: answers the 1996 questions on `χ_f` of infinite graphs, "with emphasis on the relation between the fractional chromatic number of the full graph and the fractional chromatic number of finite subgraphs"; relies on Scheinerman–Ullman | **review only** (Geombinatorics; not obtainable by script) |
| Johnson–Rodger 2005, *Coloring the vertices of a graph with measurable sets in a probability space*, European J. Combin. 26(2) (2005) 251–257, doi 10.1016/j.ejc.2004.01.004, Zbl 1059.05050 | metadata only: zbMATH gives no text ("contents unavailable due to conflicting licenses"); OpenAlex: open access (bronze) at ScienceDirect, no abstract, 3 citers, 4 references (`openalex-johnson-rodger-2005.json`) | **not read**: ScienceDirect blocks scripted fetches (memory note, paper-fetch routes). **Hand-off:** a browser save by Kooshi, filename `JohnsonRodger2005-measurable-set-colourings.pdf` |
| Scheinerman–Ullman, *Fractional graph theory* (the textbook form, ch. 3) | the authors' free PDF (`ams.jhu.edu/ers/…/fgt.pdf`) answered with a Cloudflare challenge | **not read** |
| `[MatolcsiEtAl2025]` (arXiv:2311.10069 v4, held) | §2 and Theorem 1's proof re-read here (pp. 3–6): the definitions of `χ_gf`, regular and aggregate functionals, the approximation property (7)–(8), `χ_f,0`, `α₁(ℝ²)`, the Følner blow-up | **§2–§3 up to Theorem 1's proof read** (this stage); the rest as recorded in the bibliography |

What the reading changes: Johnson–Rodger's object — a vertex ↦ event map in a probability space, adjacent events disjoint — **is** S1b's
`ι` with the invariance dropped (§2.3's `E_v = {I : v ∈ I}`); so the equality S1b-iii below, which holds with or without invariance for
the finitary number, is plausibly their theorem or near it. **Prior-art debt:** not verified; "new" is not claimed for S1b-iii's
invariance-free half.

### 2.2 S1b — the invariant-measure equivalence

*Setting.* `Γ` a graph on a countable vertex set `V`; `G` a countable group acting on `Γ` by automorphisms; `Col_k(Γ) ⊆ [k]^V` the proper
`k`-colourings and `Ind(Γ) ⊆ {0,1}^V` the independent sets, both closed in the (compact, metrizable) product topology, `G` acting by
`(g·c)(v) = c(g⁻¹v)`. For `G` transitive and `v₀ ∈ V`: `ι_G(Γ) = sup_ν ν{I : v₀ ∈ I}` over `G`-invariant Borel probability measures
`ν` on `Ind(Γ)` (independent of `v₀` by transitivity).

> **S1b-i.** If `G` is amenable: `Γ` is `k`-colourable ⟺ `Col_k(Γ)` carries a `G`-invariant Borel probability measure.
>
> **S1b-ii.** If `G` is amenable and transitive: `Γ` `k`-colourable ⟹ `ι_G(Γ) ≥ 1/k`.
>
> **S1b-W (the window form, S2's bridge).** If `G` is amenable: for every finite `W ⊆ V`, let `P_k(W)` be the set of probability vectors
> `p` on `Col_k(Γ[W])` with `p_Y(σ) = p_{gY}(σ ∘ g⁻¹)` for all `Y ⊆ W`, `g ∈ G` with `gY ⊆ W`, and patterns `σ` on `Y` (`p_Y` the
> marginal). If `P_k(W) = ∅` for one `W`, then `Γ` is not `k`-colourable. Conversely, `Γ` is `k`-colourable iff `P_k(W) ≠ ∅` for every `W`.
>
> **S1b-iii (the identities).** For `Γ = Cay(R, U)`, `R` a countable abelian group acting by translation, and every amenable `G` with
> `R ≤ G ≤ Aut(Γ)`: `ι_G(Γ) = ι_R(Γ) = 1/χ_{f,0}(Γ) = 1/ρ(Γ) = 1/χ_{gf,G,0}(Γ)`, where `χ_{f,0} = sup` of `χ_f` over finite induced
> subgraphs, `ρ = sup |H|/α(H)` (the Hall ratio), and `χ_{gf,G,0} = sup` over finite `H` of the `G`-geometric fractional chromatic number
> (`[MatolcsiEtAl2025]`'s (6), with congruences restricted to elements of `G`). In particular **`ι_G = inf_H α(Γ[H])/|H|`**.

**Proofs.**
- *S1b-i.* ⟸: a probability measure needs `Col_k ≠ ∅`. ⟹: `Col_k` is a non-empty compact metrizable `G`-space. Fix `c ∈ Col_k` and
  right Følner sets `F_n ⊂ G`; `μ_n = |F_n|⁻¹ Σ_{g∈F_n} δ_{g⁻¹·c}` has `‖h_*μ_n − μ_n‖ ≤ |F_n h⁻¹ Δ F_n|/|F_n| → 0`; any weak* limit
  point is `G`-invariant (Banach–Alaoglu; equivalently Day's fixed-point theorem). ∎ Amenability is used only in ⟹.
- *S1b-ii.* Average `μ` over the colour permutations `S_k` (they commute with `G`): `μ′` is `G`- and `S_k`-invariant. `Φ(c) = c⁻¹(1)` is
  continuous and `G`-equivariant into `Ind`; `ν = Φ_*μ′` is `G`-invariant with `ν{v₀ ∈ I} = μ′{c(v₀) = 1} = 1/k`. ∎
- *S1b-W.* If `Γ` is `k`-colourable, S1b-i's invariant `μ` has its `W`-marginal in `P_k(W)` (the consistency conditions are `μ`'s
  invariance read on cylinders). Conversely, if every `P_k(W_n)` is non-empty along `W_n ↑ V`, a diagonal limit of the marginals is a
  consistent family, so by Kolmogorov a measure on `Col_k(Γ)` exists — in particular `Col_k ≠ ∅` (no amenability needed there). ∎
- *S1b-iii.* (a) `ι_R ≤ α(H)/|H|` for finite `H`: `E_ν|I ∩ H| = |H|·ι(ν)` and `|I ∩ H| ≤ α(H)`. So `ι_R ≤ 1/ρ`. (b) `ι_R ≥ 1/ρ`: with Følner
  sets `F_n ⊂ R` and a maximum independent set `J_n` of `Γ[F_n]`, `μ_n = |F_n|⁻¹ Σ_{g∈F_n} δ_{J_n − g}` has `μ_n{0 ∈ I} = |J_n|/|F_n|
  ≥ 1/ρ` and is asymptotically invariant; a limit point (the cylinder `{0 ∈ I}` is clopen) gives `ι_R ≥ 1/ρ`. (c) `ι_R ≤ 1/χ_f(H)` for
  every finite `H`: `γ(S) = ι⁻¹ν{I ∩ H = S}` is a regular fractional colouring of `H` of weight `1/ι` (for every invariant `ν` with
  `ι(ν) > 0`); so `χ_{f,0} ≤ 1/ι_R = ρ ≤ χ_{f,0}`: equality. The same `γ` is `G`-geometric when `ν` is `G`-invariant, so `ι_G ≤
  1/χ_{gf,G,0} ≤ 1/χ_{f,0}`. (d) `ι_G ≥ 1/χ_{f,0}`, `G` amenable: with right Følner sets `F_n ⊂ G`, weights `m(v) = #{g ∈ F_n : g·v₀ = v}`
  on `H_n = F_n·v₀`, and `J_n` independent in `Γ[H_n]` of maximum weight (`m(J_n) ≥ m(H_n)/χ_f(H_n)`, averaging an optimal fractional
  colouring), `μ_n = |F_n|⁻¹ Σ_{g∈F_n} δ_{g⁻¹J_n}` has `μ_n{v₀ ∈ I} = m(J_n)/|F_n| ≥ 1/χ_{f,0}` and is asymptotically `G`-invariant. So
  `1/χ_{f,0} ≤ ι_G ≤ 1/χ_{gf,G,0} ≤ 1/χ_{f,0}` and `ι_G ≤ ι_R = 1/χ_{f,0}`: every term is equal. ∎ (Step (d) is `[MatolcsiEtAl2025]`
  Thm 1's Følner mechanism in measure form; (b) is their Thm 2's "large discrete cubes" in measure form. Neither needs the plane.)

*Grades:* S1b-i, ii, W — [hand; standard (amenability ⟹ invariant measures); one derivation here]. S1b-iii — [hand; one derivation;
its steps are MatolcsiEtAl's Thms 1–2 transposed to a countable group acting on a countable graph].

### 2.3 Consequences at ℚ(√47)

`R = ℤ[U]` is countable abelian; the isometries of `F²` that preserve `R` include `G_full = R ⋊ (U ⋊ ⟨c⟩)` (`z ↦ uz + t`, `z ↦ u·c(z) + t`)
and the Galois flip `√47 ↦ −√47` (it preserves `U` and `R`); the group they generate is virtually abelian, hence amenable, and every
congruence between subsets of a finite `H ⊆ R` lies in `G_full` (`t = y′ − uy ∈ R`).

1. **ℚ(√47)² is four-colourable ⟺ it carries a translation-, rotation-, reflection- and Galois-invariant random proper four-colouring**
   (S1b-i, per `R`-coset). *Inhabitants* (G30.5): the ⟸ side at `k = 5` — ρ₁₁'s pullback of a five-colouring of `Γ₁₁`, uniform over its
   finite `G`-orbit (multiplication by `u` and `c` preserve the ideal `R ∩ 𝔓₁₁`, the flip moves it to the conjugate prime); the refusing
   side at `k = 3` — row 82 (`χ(ℚ(√47)²) ≥ 4`): no invariant measure on `Col₃`.
2. **S2's bridge (S1b-W):** an infeasible four-class window LP on any `R`-invariant lattice piece `Λ_M` (any finite window, any amenable
   group of symmetries of `Cay(Λ_M, U_M)`) is a proof that `χ(ℚ(√47)²) ≥ 5`. A feasible one at `W` says nothing.
3. **The single-class route, priced (P-int):** by S1b-iii, `ι(ℚ(√47)) = inf_H α(H)/|H|` over finite unit-distance graphs `H ⊆ ℚ(√47)²`.
   So **`ι(ℚ(√47)) < 1/4` iff some finite `H ⊆ ℚ(√47)²` has `α(H) < |H|/4`, which would give `α₁(ℝ²) < 1/4` and `χ_{f,0}(ℝ²) > 4`, refuting
   `[MatolcsiEtAl2025]`'s conjecture** "we conjecture that the following equalities hold: δCroft = m1(R2) and α1(R2) = 1/4" (arXiv:2311.10069
   v4, §2, after (14)). The single-class averaged route at ℚ(√47) is therefore exactly as hard as that published conjecture's refutation;
   P-int's 0.03 stands, now with a named reason.
4. **Brackets:** `ι(ℚ(√47)) ≥ ρ_per(ℚ(√47)) ≥ α(Γ₁₁)/121 = 28/121 = 0.231405` (a periodic independent set gives an invariant measure; `α(Γ₁₁)
   = 28` by FS-66: `28 ≤ α ≤ ⌊28.2043⌋`). And **`ρ_per(ℚ(√47)) = max_𝔓 r_𝔓` exactly** (S1a's steps 5–6 give `≤`; each single-place
   quotient `R → A_{𝔓,m}` is an admissible `L`, `U ∩ L = ∅` since unit vectors map to units, giving `≥`), so
   `ρ_per ∈ [28/121, h*(31)] = [0.231405, 0.249997]`. The true maximum is probably at 11 (the true ratios at 31, 43, 47 are near
   `0.15, 0.14, 0.12` on G59's `c`-measurements, found sets only); proving it needs a certificate at 31 below `28/121` [not attempted: an
   SDP certificate at 31 is a machine computation, post-ban at best].

### 2.4 What S1b does not do

- **Necessity of amenability** (plan §5.1's "adversarial member") is **not examined**: no non-amenable counterexample to S1b-i is exhibited.
  The plan's sketch (a free-group Cayley tree) does not work as stated — a connected bipartite graph has exactly two proper 2-colourings and
  the uniform measure on them is invariant under every automorphism group. Recorded, not repaired.
- It proves nothing about `χ(ℚ(√47)²)`; it names the object an averaged certificate must refute and prices the single-class form.

### 2.5 Stage 2 notes

- FS-66's `cert-p19.json` re-check at `--m 4`: see §3's first line (it was still running at this save).
- **Would have searched here:** would have sampled a large random ball of `Cay(R, U)` and computed its independence ratio to estimate `ι`;
  instead derived `ι = inf α(H)/|H|` and priced the route against `[MatolcsiEtAl2025]`'s conjecture.

## Stage 3 — SAVED

*First line owed from Stage 2:* FS-66's `cert-p19.json` at `--m 4`: **CERTIFIED** (`4U = 310.047 < 361`), 8 min 59 s single-threaded
(`data/fs84/s1/fs66-check-p19-m4.out`). **Slip:** it ran without `scripts/slot.py` although it exceeded 2 minutes (memory under 1 GiB,
one thread); logged for the owner.

### 3.1 S1c — the candidate set, fixed by derivation before any check

A rational band character of `Λ_M` is a periodic four-colouring; whether `Θ₄(Λ_M) ≠ ∅` at all is a finder's question (out). On a single
rank-4 lattice "torsion plus archimedean" restricts nothing (every character of `Λ_M` is archimedean: `Λ_M ⊗ ℝ = E ⊗ ℝ`); the structure
of rows 95–97 bites only through the layers. So the candidate set is defined by what a *field-level* band character looks like on each
layer, with its archimedean part set to zero:
- **Family A (the `T₁₆₈` family).** Row 95/FS89-CL2: every band character of a real field's ring is `τ + ψ` with `τ` of order dividing
  168 on each rational layer (six types, 29 characters: parity, order 3, two order-4 types, order 7, order 8). `Λ_M` is spanned by its
  layers `b·U_ℚ`, so every `θ` whose layer restrictions are `T₁₆₈`-types with `ψ = 0` has order dividing 168. **Candidate set:
  `Hom(Λ_M, (1/168)ℤ/ℤ)`, all `168⁴ = 7.97·10⁸` elements** — a superset of the derived family, enumerated completely.
- **Family B (the local family).** CLG's existence form: a field-level band character comes from one stable place at some level, and
  FS-89 collapses the tower to level one. **Candidate set: `Hom(Λ_M, (1/q)ℤ/ℤ)` for the stable `q ∈ {11, 19, 23, 31, 43, 47}`** (it
  contains the single-place characters and their sums over the two places above `q`).
- **Not in the set, by name:** row 97's heteroclinic characters (irrational in general; the rational ones at one prime have orders the
  families do not fix), the eight order-20 depth-one point cells of FS89-CL1, every character with a non-zero archimedean part, and every
  level-≥2 local character. The enumeration is the ban's edge: a complete exact enumeration of finite sets a derivation fixed first.

### 3.2 S1c — the result (`tools/fs84_s1_band_candidates.py`; `data/fs84/s1/band_candidates.{out,json}`; 342 s under `slot.py`)

| `M` | 240 | 360 | 408 | 840 | 1272 | 1464 | 2136 | 2184 | 2328 | 2424 |
|---|---|---|---|---|---|---|---|---|---|---|
| `\|U_M\|` | 108 | 108 | 196 | 204 | 188 | 188 | 188 | 204 | 188 | 196 |
| family A hits | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| family B hits (each `q`) | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

**No survivor carries a band character of order dividing 168, nor of order 11, 19, 23, 31, 43 or 47.** Per lattice: **GAP** — no
rational witness in the derived families, and no obstruction to `Θ₄(Λ_M) ≠ ∅`: the missing step is the part of `Θ₄(Λ_M)` outside the
families (non-zero archimedean parts, heteroclinics, other orders), which only a `Θ₄` decision procedure settles (post-ban, S4(i)).
*Controls:* (pos) on the rank-2 rational pattern over 5 the same enumerator finds 557 band characters of order dividing 168, among them
all six of row 95's type representatives, transported to `(1/5)ℤ[i]`; (neg) `θ = 0` refused, parity and the order-4 point accepted by the
Fractions checker; (plant `band`, `band_candidates-plant-band2.out`) the checker's band narrowed by `1/168` refuses the order-4 point
(values on `1/4`, `3/4`) and keeps parity (values `1/2`) — it fired for its reason. *A first plant could not fire* (it narrowed the band
where only parity was tested; `band_candidates-plant-band.out`, exit 4 expected) — replaced, recorded. *FS-81 consistency:* the null is
implied at `N = 7, 11` wherever FS-81's quotient screen was UNSAT, and is new at every order it never asked (8, 12, 21, 24, 28, 42, 56,
84, 168, 19, 23, 31, 43, 47). The main run's output predates the controls' last edit (the enumeration code is unchanged).

**P-1p** (0.25): unscored — S1c colours nothing; S4(i) is where a one-prime character would be found. **The confound** (Q7): among
`M ≤ 2,520` with `24 | M`, two primes `≡ 1 (mod 4)` need `M ≥ 24·5·13 = 1560`; the multiples of 24 up to 2,520 with two such primes are
1560 and 2040 (`24·65`, `24·85`), and `24·5·17 = 2040`, `24·5·29 > 2520` — confirmed by hand.

### 3.3 Would have searched here (Stage 3)

- Would have run a float `Θ₄` finder or a relation tree on each survivor; instead enumerated the two derived finite families exactly.
- Would have asked the survivors' quotient graphs at `N = 16–20` by SAT; instead covered the linear (character) part of every order
  dividing 168 exactly, and left the non-linear part to S4.

## Stage 4 — SAVED

### 4.1 S1d — the four-class window LP, its shape (no LP runs here)

- **Object** (S1b-W): a probability vector `p` on `Col₄(Γ[W])`, `Γ = Cay(Λ_M, U_M)`, consistent on every overlap `W ∩ (W + g)`,
  `g ∈ (W − W) ∖ 0`, and invariant under the point group. Infeasible at one `W` ⟹ `χ(ℚ(√47)²) ≥ 5`.
- **Symmetry quotient:** `P = ⟨z ↦ iz, z ↦ z̄, √47 ↦ −√47⟩` preserves every `U_M` (in coordinates `(a,b,c,e) ↦ (−c,−e,a,b)`,
  `(a,b,−c,−e)`, `(a,−b,c,−e)`), order 16; with colour permutations `S₄` the reduction group has order `16·24 = 384`. Multiplication by
  other unit vectors does not preserve `Λ_M` and is not available.
- **The window must reach radius 2 and close odd cycles:** `Γ` is triangle-free (`ζ₆ ∉ E`), so the radius-1 window `{0} ∪ U_M` induces a
  star, `|Col₄| = 4·3^{|U_M|}`, and carries nothing beyond pair statistics (row 87's radius-1 no-go in this field's form).
- **Density cap (derived):** two unit circles meet in at most two points, so `Γ[W]` is `K_{2,3}`-free and
  `e(W) ≤ w(1 + √(8w − 7))/4` for `|W| = w` (`Σ_v C(d_v, 2) ≤ 2·C(w, 2)` and convexity). Windows are therefore sparse: `w = 16` allows at
  most 48 edges (average degree 6).
- **Counts:** variables `= |Col₄(Γ[W])/(P_W × S₄)| ≥ |Col₄(Γ[W])|/384`; constraints `= Σ_{g ∈ (W−W)∖0 / P_W}` (patterns on
  `W ∩ (W + g)` up to symmetry) `+ 1`. With `e ≤ 48` at `w = 16`, a sparse window keeps most of `4^w ≈ 4.3·10⁹` colourings; the LP is a
  machine-scale object from `w ≈ 14` on.
- **The dual as an identity (Farkas):** potentials `y_g` on overlap patterns with `Σ_g [y_g(σ|_{W∩(W−g)}) − y_g((σ∘τ_g)|_{W∩(W−g)})]
  ≥ 1` for every `σ ∈ Col₄(Γ[W])` — a discharging identity whose every term has mean 0 under an invariant measure. A refutation is read
  back as that inequality, checked on every window colouring exactly.
- **Price: GAP.** The window is not fixed: fixing it needs the lattice's short odd cycles through 0 (the odd girth of `Cay(Λ₂₄₀, U₂₄₀)`
  and its cycle orbits), an exact computation not run here for budget. The next step is that computation, then `W` = the union of the
  shortest odd cycles' `P`-orbit, then its count.

### 4.2 S1e — linear identities on the tetrahedral embedding

> **S1e.** Let `g = Σ_j 1[c = j]·t_j` be a four-colouring read on the regular tetrahedron (`Σ t_j = 0`). (i) A linear identity
> `Σ_{x∈P} a_x g(x) = κ` valid for every proper four-colouring `c` of a lattice graph `Γ` has `κ = 0` and says exactly that **every colour
> class has the same `a`-weight on `P`** in every colouring. (ii) If some proper four-colouring of `Γ` has a gap (a vertex whose closed
> neighbourhood misses a colour), then **no non-trivial such identity exists on `Γ`**. (iii) Over ℚ(√47) (and every field without `√3`)
> `Γ` has no triangles of any side, so G75's `√3`-triple mechanism is vacuous.

*Proof.* (i) Colour permutations preserve properness; averaging the identity over `S₄` gives `κ = 0`; then `Σ_j A_j t_j = 0` with
`A_j = Σ_{c(x)=j} a_x`, and the only linear relation among the `t_j` is `Σ t_j = 0`, so all `A_j` are equal. (ii) Translate the gapped
colouring so that the gap sits at a vertex `x` with `a_x ≠ 0` (translates of proper colourings are proper); recolouring `x` alone with its
missing colour gives a proper colouring in which two class weights move by `∓a_x`, breaking (i). (iii) A third vertex of an equilateral
triangle is `x + ζ₆(y − x)`, and `ζ₆ ∉ ℚ(√47, i)`. ∎ [hand; one derivation]

**What it does to P-G75** (0.85, "no local linear identity pins a ℚ(√47) lattice's spectrum to torsion"): an identity needs a lattice
that is four-colourable **and** frozen at every vertex of its support in every colouring — rigidity with no gap anywhere, the G68 question.
On a lattice that is not four-colourable an identity is vacuous (G30.5). So P-G75 is reduced, not scored: it holds on every four-colourable
ℚ(√47) lattice that has one gapped colouring. On de Grey's lattice every colouring is gap-free (`F = P = 8Λ`), consistent with NT existing.

### 4.3 The claim list for the verifier (S1V), verbatim

1. "`ρ_per(ℚ(√47)) ≤ sup_𝔓 r_𝔓 ≤ h*(31) = 0.2499972548… < 1/4`, where `h*(p) = L_p/(p + 1 + L_p)`, `L_p = max(|λ_min(Γ_p)|, 2)`, and
   `|λ_min(Γ₃₁)| = 10.666510494…`." (§1.3)
2. "No proper four-colouring of `Cay(R, U)` is invariant under a finite-index subgroup `L ≤ R`." (§1.3, Corollary S1a′)
3. "The stable places of ℚ(√47, i) lie over 47 and the primes `p ≡ 3 (mod 4)` with `(47/p) = 1`; 59 is not among them." (§1.3 step 7)
4. "At every stable place, a character `ψ` of `(A_m, +)`, `m ≥ 2`, non-trivial on `π^{m−1}A_m` has `|λ_ψ| ≤ 2p^{m−1}`." (§1.3 step 7)
5. "`ρ_N(U) = ∏_{𝔓∈S_N} S_{𝔓,K_𝔓}`." (§1.3 step 3)
6. "`ρ_per(ℚ(√47)) = max_𝔓 r_𝔓` exactly, and `ρ_per ∈ [28/121, h*(31)]`." (§2.3 item 4)
7. S1b-i, S1b-ii, S1b-W, S1b-iii as stated in §2.2.
8. "`ι(ℚ(√47)) < 1/4` iff some finite `H ⊆ ℚ(√47)²` has `α(H) < |H|/4`, which would give `α₁(ℝ²) < 1/4`." (§2.3 item 3)
9. "No survivor carries a band character of order dividing 168, nor of order 11, 19, 23, 31, 43 or 47." (§3.2; tools exact)
10. S1e (i)–(iii) as stated in §4.2.

### 4.4 Would have searched here (Stage 4)

- Would have computed the odd girth of `Cay(Λ₂₄₀, U₂₄₀)` by a meet-in-the-middle sum search to fix `W`; not run (budget), named as S1d's
  next step.
- Would have run a small window LP to price S2; instead derived the density cap and the dual's form.

### 4.5 Proposed edits and hand-offs (this job edits none of the front-page files)

- `plans/FS84-five-colours-47.md` §1.2: "59, …" → "67, …" (Q13).
- Bibliography: Johnson 1996 and 2000 — zbMATH reviews read; Johnson–Rodger 2005 not read (a browser save wanted,
  `JohnsonRodger2005-measurable-set-colourings.pdf`, doi 10.1016/j.ejc.2004.01.004).
- FS-84's §P: P-S1a — one AmbrusEtAl-free derivation (S1V would make two); P-int's price named (`[MatolcsiEtAl2025]`'s `α₁(ℝ²) = 1/4`);
  P-1p and P-G75 unscored (reduced as above).
- S4(i) should start from §3's null: its finder's calibration must include a positive at a non-zero archimedean part (Ga26).
