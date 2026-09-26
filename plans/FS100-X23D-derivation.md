*Derivation record of crunch job **X23D** (wave 3), de Bruijn, Opus 5.5, 2026-09-26. Brief:
`data/crunch-2026-09-26-x2x3/briefs/X23D-spcor-every-field-derivation.md`, with `data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` as part of
it; stop time 12:30 UTC. No subagents; no finite-witness search (ban to 2026-10-01). I touch only this file, `data/fs100/x23d/` and
`tools/x23d_*.py`. A blind verifier (X23V) works the same list; I have not contacted it.*

## Theorems this phase proved

*(filled at each stage)*

## Stage 1 — SAVED (the claims, quotation check, C0)

### 1.1 The claims, copied verbatim

From `plans/CRUNCH-2026-09-26-x2x3-queue.md` §7, first paragraph after Kooshi's words (verbatim):

> **Where waves 1–2 left MR** (from the reports, `data/crunch-2026-09-26-x2x3/reports/`): EF_F⁺ is TRUE by two derivations (X01D; X12B blind,
> by its own route), and X01V's GAP at the multiplier step was absorbed by X12B's rational-unit-vector multipliers. PE-2 is TRUE by X02D and
> X02V blind, given EL2021 Thm 1.2 through (★); PE-1 as stated is FALSE. SP-Cor passed X05V blind. So **MR(F) holds for every real number
> field at [hand] grade, with the scope of row 100's exception** (a ramified stable dyadic place, where `R = O′` is not proved; X09C's audit).
> Every claim below is stated with that scope and asks whether its field is outside the exception. **"Given MR"** below means: given MR(F) at
> the grade and scope just described; each job names it as an input and does not re-derive it.

List X23 (same file, §7, verbatim):

> Inputs quoted verbatim: row 117 (quoted in list X21); SP-Cor and A⁺ at `S = ∅` (`plans/FS84-SI-D-derivation.md` §4.2, §5.4); X05V's re-derivation
> P0–P8 (`plans/FS100-X05V-verification.md` §2.1); J48-N4cor (quoted in list X21).
>
> - **SPC(F)** (SP-Cor for every real number field; the advisor's F1 (a)). "For every real number field `F` outside row 100's exception: if T-C(A)
>   holds at `S = ∅` (every stable place of `L = F(i)` has all-levels four-colour ratio `< 1/4`), then J45's A⁺ and SP-Cor hold with J45's
>   proofs, and, given MR, `χ(F²) ≥ 5`." **Named risk (the advisor):** A⁺'s archimedean step when `F` has `n = [F:ℚ] > 2` real places. X03D's
>   `Λ = 0.4028 > 1/3` shows that first moments alone cannot do it; J45 did it at `n = 2`.
> - **CLS(F)** (the class; the advisor's F1 (b)). "For every real number field `F` outside row 100's exception: T-C(A) holds at `S = ∅` iff
>   `L(F) ≥ 5`." **Named risks (the advisor):** `q = 27`; the dyadic `U_Q` for `Q ≥ 64`; ramified stable places; the archimedean part at `n`
>   places.
> - **COR.** "SPC and CLS together give `χ(F²) ≥ min(L(F), 5)` for every real number field outside row 100's exception."
> - **CTL** (controls; each must come out as stated, and each can fail). "T-C(A) at `S = ∅` fails at K = ℚ(√3,√11), ℚ(√2,√3), ℚ(√11) and ℚ(√23),
>   where `L ≤ 4`. At ℚ(√47) it holds."
> - **Q35.** "ℚ(√3,√5) lies outside row 100's exception. Its stable places are exactly those above 11, 59 and the other primes of residue
>   degree one in `L/ℚ(√3,√5)` that are inert in `L/F`; 3, 7, 19, 23, 31, 43 and 47 are not stable; and T-C(A) holds there at `S = ∅`. Hence,
>   given MR and SPC, `χ(ℚ(√3,√5)²) = 5`." (The advisor's F4; its Legendre-symbol list is one mind. An exact check of seconds is in.)
> - **D-1** (the J48 route, kept). "Given MR, for every totally real number field `F` outside row 100's exception with `N₄(F) = ∅`: `χ(F²) ≥ 5`."

Quoted inputs (from list X21, verbatim): row 117 — "For `ℚ(√d)` real quadratic: every stable place of `ℚ(√d, i)` has all-levels four-colour
ratio `< 1/4` ⟺ `d ≡ 47, 143, 167 (mod 168)` ⟺ `L(ℚ(√d)) ≥ 5`; and over every real number field where T-C(A) holds at `S = ∅`, J45's A⁺ and
SP-Cor hold with J45's proofs — so MR(F) ⟹ `χ(F²) ≥ 5` at ℚ(√143), ℚ(√311), ℚ(√335) as at ℚ(√47)."; J48-N4cor — "For every totally real `F`
with `N₄(F) = ∅` — every stable place 4-thick — MR(F) ⟹ `χ(F²) ≥ 5`".

The brief's addendum (06:24, the advisor): "If a claim holds for totally real `F` and fails or is ill-posed with a complex place, record both
verdicts." and "The job must name every step of J45 that uses [F:ℚ] = 2."

### 1.2 Quotation check (standing rule 5)

| # | quoted in the brief | source | result |
|---|---|---|---|
| Q1 | §7's first paragraph and list X23 | `plans/CRUNCH-2026-09-26-x2x3-queue.md` §7, ll. 249–254 and 306–327 | copied above from the file itself (no retyping) |
| Q2 | row 117 (in list X21) | `LEDGER.md` row 117 | the ⟺ sentence found byte-identical (`grep -cF` = 1) |
| Q3 | K0 (in list X21), "J45's A⁺ and SP-Cor hold, with the same proofs, over every …" | `data/crunch-2026-09-25/briefs/J51V-FS100-kronecker-verifier.md` | found (`grep -cF` = 1) |
| Q4 | J48-N4cor | `plans/STUB-measure-rigidity-three-fields.md` l. 184–185 | agrees verbatim ("For every totally real `F` with `N₄(F) = ∅` — every stable place 4-thick — MR(F) ⟹ `χ(F²) ≥ 5`") |
| Q5 | addendum: "SP-Cor(F) holds with J45's proofs over every totally real F in T-C(A)'s class. The job must name every step of J45 that uses [F:ℚ] = 2." | advisor record `plans/POROS-2026-09-26-x2x3-crunch.md` l. 450–451: "**D-6** (SP-Cor with J45's proofs over every totally real `F` in the class, naming each step that uses degree 2)" | **not verbatim** in the advisor's record (a paraphrase in the brief); agrees in substance |
| Q6 | addendum: "the stable odd places of ℚ(√3,√5) below 200 are 11, 59, 71, 131, 179, 191; 7, 19, 23, 31, 43, 47 have residue degree 2 …" | advisor record l. 415–418 (F4): "Below 200 the stable odd places are **11, 59, 71, 131, 179, 191**. The primes 7, 19, 23, 31, 43, 47 are **not** stable, since their residue degree is 2. 3 has residue field `𝔽₉`, and no dyadic place is stable, since 15 ≡ 7 mod 8." | **not verbatim** (a paraphrase); agrees in substance |
| Q7 | Q35's phrase "the other primes of residue degree one in `L/ℚ(√3,√5)` that are inert in `L/F`" | the claim itself | **internally inconsistent as worded**: a place inert in `L/F` has residue degree 2 in `L/F`, not 1. I read it as "primes of residue degree one in `F/ℚ` … inert in `L/F`" (which is the advisor's F4 list) and score it under that reading, noting the wording |

### 1.3 Notation (fixed here)

`F ⊆ ℝ` a number field with `r₁ ≥ 1` real and `r₂` complex places, `n = [F:ℚ] = r₁ + 2r₂`; `L = F(i)`; a place `v` of `F` is **stable** iff it
does not split in `L/F`; `𝕋` the norm-one torus of `L/F`; `U = 𝕋(F)`; `R = ℤ[U]`; `E_S = T + A + Fin_S` as J45 N1. **T-C(A)@∅ (class form)**:
every stable place has all-levels four-colour ratio `r_v := sup_m α(G_{v,m})/|G_{v,m}| < 1/4`. **R88-TCA@∅ (spectral form)**: no
translation-invariant Borel probability on `X₄(F)` has spectral measure carried by `T + A`. **H*-place** (J28D; J48's "4-thick"): every non-trivial
character of every level has normalised eigenvalue `> −1/3`.

### 1.4 C0 — probabilities per claim (written after reading the sources and one mental pass, before any written derivation)

| claim | TRUE | FALSE | GAP | note |
|---|---|---|---|---|
| CTL | 0.90 | 0.05 | 0.05 | each control is a few Legendre symbols plus row 67's dyadic tightness |
| CLS (totally real) | 0.70 | 0.10 | 0.20 | risk: `q = 27` (Weil does not reach 1/4 there: `2√27/(28+2√27) = 0.271`) |
| CLS (with complex places) | 0.70 | 0.10 | 0.20 | CLS reads only finite places; same risks |
| SPC (totally real) | 0.80 | 0.02 | 0.18 | the mental pass says the count uses `m₁` per real place and C14.3's max over factors, not first moments; risk: a hidden degree-2 step in R88-TCA's route |
| SPC (with complex places) | 0.50 | 0.05 | 0.45 | the complex place's archimedean factor is a hyperbola, not a circle |
| COR | 0.65 | 0.05 | 0.30 | the conjunction; plus MR's own scope at complex places (waves 1–2) |
| Q35 | 0.80 | 0.05 | 0.15 | exact Legendre symbols; the field has no stable 23, 27, 31 |
| D-1 | 0.85 | 0.02 | 0.13 | `N₄ = ∅` is a sub-case of the class |

### 1.5 Would-have-searched-here log (running)

- (stage 1) none.

## Stage 2 — SAVED (CTL, then CLS)

**Verdicts. CTL: TRUE** as stated, every control for the stated reason [hand + tools exact]. **CLS: TRUE for every real number field**,
totally real or not, and with or without row 100's exception (a ramified stable dyadic place makes both sides false) [hand + tools exact; one
mind]. The advisor's named risks: **`q = 27` is not a risk** — `λ_min(Γ₂₇) = −8` exactly, Hoffman ratio `2/9`, and 27 is even an H*-place
(`−8/28 = −0.2857 > −1/3`); the dyadic `U_Q`, `Q ≥ 64`, and the ramified stable odd places close by Lemma P, transcribed (below); the
archimedean part does not enter CLS (it reads finite places only; it is SPC's, stage 3).

### 2.1 The tools (exact; plants watched)

- `tools/x23d_norm_one_spectrum.py` → `data/fs100/x23d/spectrum.out` (exit 0). Exact integer spectra of `U_Q = Cay(𝔽_{Q²}, μ_{Q+1})` for
  `Q = 2^f, 3^f` (for these `p` the eigenvalues are rational integers: `−1 ∈ μ_{Q+1}` makes them real, and they lie in `ℚ(ζ_p)`). Controls,
  all PASS: `Q = 3` → `−2` (Γ₃ Hoffman-tight at three colours), `Q = 2` → `−1` (`K₄`), `Q = 32` → `−11` (tight at four, G54), `Q = 64` →
  `−15` (G56). **Target: `Γ₂₇` (degree 28) has spectrum `{−8: 112, −5: 84, −2: 168, 1: 84, 4: 168, 7: 84, 10: 28}` on the 728 non-trivial
  characters** (sum `−28` = minus the degree, as it must be), so `λ_min(Γ₂₇) = −8`, Hoffman ratio `8/36 = 2/9`, Hoffman floor `χ(Γ₂₇) ≥ 4.5`,
  i.e. `≥ 5`. Plants: `mu-minus` (`μ_{Q−1}`) and `drop-pair` (one inverse pair removed) each turn three controls red, exit 1
  (`spectrum-plant-*.out`). **A plant that could not fire, kept and labelled:** `trace-coord` (the first coordinate in place of the trace)
  stays green, because every non-zero `𝔽_p`-linear functional is `x ↦ Tr(cx)` and only permutes the spectrum — logged as a slip caught by
  running it (G21: a control whose failure mode is unreachable tests nothing).
- `tools/x23d_class.py` → `data/fs100/x23d/class.out` (exit 0). For real multiquadratic `F`: the dyadic place by 2-adic square classes
  (`ℚ₂^×/ℚ₂^{×2} = ⟨−1, 2, 5⟩`: split iff `−1 ∈ H`; else inert iff adjoining `−1` doubles the residue degree), odd `p` by exact Legendre
  symbols (residue degree 1 iff every class prime to `p` is a square mod `p`; stable iff `p ≡ 3 (mod 4)` and `f = 1`). The derivation (2.3)
  fixes the finite set that decides the class: the dyadic place and `p ∈ {3, 7}`; the list of stable places below 200 is a sanity check.
  Cross-check: row 117's `d ≡ 47, 143, 167 (mod 168)` for every squarefree `d < 2000`, 0 mismatches. Plants: `f-even-stable` (residue degree
  2 treated as usable) and `dyadic-ignore-minus1` both fire (exit 1; 34 and 51 row-117 mismatches; `class-plant-*.out`).

### 2.2 CTL

| field | stable dyadic place | stable odd places that break the class | class | `L` | reason `L ≤ 4` |
|---|---|---|---|---|---|
| K = ℚ(√3,√11) | inert, residue `𝔽₂`, target `U₂ = K₄` (ratio exactly `1/4`; row 67's tight tower) | none (11 is stable with `e = 2`: class-good by FS-66 via Lemma P (ii); 3 has `𝔽₉`, 7 has `𝔽₄₉`) | **fails** | 4 | `χ(K₄) = 4` |
| ℚ(√2,√3) | inert (`F_v = ℚ₂(√2,√3)` totally ramified, `e = 4`; `L_v ∋ √5 = i√3`), `U₂` | none (23, 47, 71, … stable) | **fails** | 4 | `U₂` |
| ℚ(√11) | inert, `U₂` | 7 (`(11/7) = 1`, `Γ₇` ratio `2/7`) | **fails** | 4 | `U₂`, `Γ₇` |
| ℚ(√23) | split (`23 ≡ 7 mod 8`) | 7 (`(23/7) = 1`) | **fails** | 4 | `Γ₇` |
| ℚ(√47) | split | none (11, 19, 23, 31, 43, ramified 47, …) | **holds** | 5 | — |

**What a wrong-reason pass would look like, and why this is not one:** K or ℚ(√2,√3) failing through a stable 3 or 7 (neither is stable
there — the tool lists the breakers, and for both only the dyadic `U₂` breaks), or ℚ(√23) failing through its dyadic place (split). Each
failure above is at the place whose level-one target has `χ ≤ 4`, which is CLS's mechanism; and ℚ(√47)'s pass is row 117's. The controls
can fail: `dyadic-ignore-minus1` makes ℚ(√47) and ℚ(√3,√5) fail and K pass.

### 2.3 CLS

**Notation.** For a stable place `v` (`v` does not split in `L/F`), `G_{v,m} = Cay(O_{L_w}/𝔓^m, S_m)` its tower (`S_m` the image of `U`, the
whole norm-one group mod `𝔓^m` by weak approximation and smoothness of `𝕋`), `r_v = sup_m α(G_{v,m})/|G_{v,m}|`.

**Lemma CLS-0 (the stable places and their level-one targets) [hand].** `L/F` is unramified at every odd place (`disc(x² + 1) = −4`). An odd
place with residue field `𝔽_q`, `q = p^f`, is stable iff `−1` is a non-square in `𝔽_q` iff `q ≡ 3 (mod 4)` iff `p ≡ 3 (mod 4)` and `f` odd;
its level-one target is `Γ_q = Cay(𝔽_{q²}, μ_{q+1})`, whatever `e(v|p)`. A dyadic place is non-stable iff `i ∈ F_v`; if stable it is inert
(target `U_Q`, `Q = N(v)`) or ramified in `L/F` (every unit vector reduces to 1; the target is bipartite, ratio `1/2`, G56 — row 100's
exception). Stable places exist (Chebotarev: `L ≠ F` since `F ⊆ ℝ`).

**Lemma CLS-1 (monotonicity) [hand].** `G_{v,m+1} → G_{v,m}` is a homomorphism with constant fibres, so pulling back an independent set
gives `α(G_{v,m+1})/|G_{v,m+1}| ≥ α(G_{v,m})/|G_{v,m}|`: `r_v ≥ α(G_{v,1})/|G_{v,1}|`. Hence `r_v < 1/4 ⟹ χ(G_{v,1}) ≥ 5`.

**Lemma CLS-2 (the ratio table, every stable place) [hand + tools exact; inputs named].** The usable `q ≤ 33` are exactly
`3, 7, 11, 19, 23, 27, 31` (primes `≡ 3 mod 4`, and the one odd-exponent power `27 = 3³`; the next is `243`). Then:
- `q = 3, 7`: level-one ratio `1/3`, `2/7`, so `r_v ≥ 1/4`, and `χ(Γ₃) = 3`, `χ(Γ₇) = 4`.
- `q = 11, 19` (necessarily `f = 1`): `r_v < 1/4` at every level of the unramified tower (FS-66's certificates `U(11) = 28.2043`,
  `U(19) = 77.5117`, row 75) and of every ramified one (Lemma P (ii), B1-LP: "FS-66's L1–L2 need only the coset structure and Hensel's count,
  both valid at a ramified place"; checked by FFT at `e = 2`). *Not re-checked here at `e ≥ 3`*; the cited argument does not use `e`.
- `q = 23, 31`: Hoffman at level one (0.249077; `1/4 − 2.745·10⁻⁶`) and Lemma P (i) at every level.
- **`q = 27`**: `λ_min(Γ₂₇) = −8` (2.1), Hoffman `2/9`; every level by Lemma P (i) transcribed (next item), primitive normalised bound `2/28`.
- `q ≥ 43`, prime or a power: Weil (`|λ| ≤ 2√q`, the eigenvalues of `Γ_q` being Kloosterman sums over `𝔽_q`) gives Hoffman
  `≤ 2√q/(q + 1 + 2√q) < 1/4` iff `q > (3 + 2√2)² = 33.97`; Lemma P at every level.
- **Lemma P, transcribed to residue field `𝔽_q` [hand].** The proof (`plans/FS84-S1-derivation.md`; B1-LP) is verbatim with `𝔽_q, 𝔽_{q²},
  μ_{q+1}` for `𝔽_p, 𝔽_{p²}, μ_{p+1}`: the fibre of `S_m → S_{m−1}` over `s̄` is `s + π^{m−1}s₀·γ𝔽_q` (`q` points), a primitive `ψ` sums to
  `qψ(s)` or 0 on it, and `β⁻¹𝔽_q^× ∩ μ_{q+1}` has at most two points (`𝔽_q^× ∩ μ_{q+1} = {±1}`): `|λ_ψ| ≤ 2q^{m−1}`.
- **Dyadic inert, `Q = 2^f`** [hand + tools]: `Q ≤ 32`: `U_Q` is four-colourable (G56, FS-54), so `r_v ≥ 1/4` and `χ ≤ 4`. `Q ≥ 64`:
  Weil gives Hoffman `≤ 2√Q/(Q + 1 + 2√Q) ≤ 16/81`, and exactly `λ_min(U₆₄) = −15` (2.1): `15/80`. Every level: **the dyadic Lemma P [hand,
  new]** — for `L_𝔓/F_v` unramified with residue fields `𝔽_{Q²}/𝔽_Q`, `N(1 + π^{m−1}x) ≡ 1 + π^{m−1}Tr(x) (mod π^m)` for `m ≥ 2`, so the
  fibre is `s + π^{m−1}s₀𝔽_Q` (`Q` points; in characteristic 2 the trace-zero line is `𝔽_Q`); a primitive `ψ` is trivial on it iff
  `βs₀ ∈ 𝔽_Q`, and two such `s₀` differ by an element of `𝔽_Q^× ∩ μ_{Q+1} = {1}` (`gcd(Q − 1, Q + 1) = 1`): `|λ_ψ| ≤ Q^{m−1}`, normalised
  `≤ 1/(Q + 1)`. It holds whatever `e(v|2)`. (For the unramified-over-ℚ₂ tower G54's exact constancy says the same.)
- Dyadic ramified in `L/F`: ratio `1/2`, target `χ ≤ 2`.

**Theorem CLS [hand + tools exact; one mind].** For every real number field `F`: every stable place has `r_v < 1/4` ⟺ no stable place's
level-one target has `χ ≤ 4` ⟺ `L(F) ≥ 5`; and the same with `L` read at every level (row 75's reading).
*Proof.* (⟹) CLS-1. (⟸) By CLS-2 the stable places with `r_v ≥ 1/4` are exactly those with `q ∈ {3, 7}`, dyadic inert `Q ≤ 32`, or dyadic
ramified, and each of these has a level-one target of `χ ≤ 4` (3, 4, `≤ 4`, `≤ 2`). If `L(F) ≥ 5` none occurs, so every stable place has
`r_v < 1/4`. The all-levels reading: `r_v < 1/4` bounds `χ ≥ 5` at every level, and the four exceptional kinds have `χ ≤ 4` at level one. ∎
*Scope.* No step uses the degree, real or complex places, or row 100's exception (whose fields have `L = 2` and fail both sides).
*What changes from degree 2:* residue fields `𝔽_{p^f}` with `f ≥ 3` (only `q = 27` below Weil's threshold), ramification `e ≥ 3` at 11 and 19
(cited, not re-checked), dyadic `Q ≥ 8` (four-colourable to 32, Hoffman-and-Lemma-P from 64).

### Would-have-searched-here log (stage 2)

- Would have searched for a large independent set in `Γ₂₇` or a four-colouring of it. Instead: its exact spectrum (728 integer eigenvalues, a
  complete computation whose extent CLS-2 fixed: the one usable non-prime `q` below 33.97); logged at the ban's edge as a complete exact
  enumeration of a set the derivation fixed.
