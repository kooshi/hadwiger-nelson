# FS-91 crunch job J07 — the character local–global theorem (derivation record)

*Crunch milestone M1 (FS-91), job J07, de Bruijn (Opus 5.5), 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J07-M1-character-local-global.md`
with `STANDING-RULES.md`, and the owner's launch message (news: J03a TRUE at every `k`; `A(R_F)` corrected; J02's theorems verified by J09).
Grades are `CLAUDE.md` § Notation's. Every statement here is about **characters** (colourings `x ↦ ⌊kθ(x)⌋`), never about `χ`: from four
colours up emptiness of `Θ_k` is one-sided (G71). Fenced from me by rule: J10's record. Not opened by choice: J09's proof of its J2 (see
Stage 2, Lemma C′, independence note).*

## Stage 1 — SAVED

### 1.1 Quotation check (standing rule 5)

| # | quotation (brief or owner's message) | source | result |
|---|---|---|---|
| Q1 | CLG_k, "Let `k ≥ 3` satisfy `H_k`, … is `k`-colourable." | `plans/FS91-character-local-global.md` §S | **verbatim** (grep, one hit) |
| Q2 | the converged form "`κ(R_F, U_F) = max over stable places 𝔓 of κ(O_𝔓, S_𝔓)`, under `H_β` for the `β` in question." | same, §M.1 | **verbatim** (the source's sentence begins "CLG in its converged form:", which the brief omits) |
| Q3 | CLG-a to CLG-g | same, §S, "J07 — the class theorem" | read there, verbatim; used from the source, not the brief |
| Q4 | Kooshi: "A proven theorem about why its impossible is also valid. All novel knowledge is a success." | `CLAUDE.md` Frontier item 23; `STANDING-RULES.md` rule 4 | **verbatim** |
| Q5 | the brief's unquoted "FS-89 proved (row 95) that at four and five colours every band character is a torsion character plus an archimedean one" | `LEDGER.md` row 95 | **agrees**, with the scope row 95 states: on `Q`, then "by the gluing the same holds for every real field (`Θ₄(R_F) ⊆ T₁₆₈ + A`, `Θ₅(R_F) ⊆ T + A`)" |
| Q6 | the brief's hypothesis line ("`H_k` … at every `k` … given J01-7, one reader") | superseded by the owner's message: J03a TRUE, `plans/FS91-S0V2-SWm-second-reading.md` §3.6 | **checked**: J03a-7, J03a-8 read there: `Θ_k(R_F) ⊆ T_{N_k}(R_F) + A(R_F)` for every `F ⊆ ℝ`, every `k ≥ 2`, `N_k` finite, non-effective |
| Q7 | the owner: "Over R_F the archimedean part is A(R_F) = Hom_ℚ(F(i), ℝ) mod 1 … With the one-embedding reading, FS89-CL2 is FALSE" | J03a record §3.4 (J03a-9); FS89-S0A §C1 "Conventions" | **agrees**; S0A's own convention was the wide one from the start ("`A(X)` … `ℓ ∈ Hom_ℚ(L, ℝ)`") |
| Q8 | the owner: J02-T2, T3, C1 verified by J09; J09's J2 and J4 one mind | `plans/FS91-S0FV-three-colours-blind.md` (headings only read) | **agrees** as to what J09 filed; J2's heading (read while grepping for this check, **after** Lemma C′ below was derived in my working notes) is "the unit-vector ring is the stable-integral ring at every prime with no ramified stable place [hand, one mind]". Its proof was not opened |
| Q9 | reading list: S0A-2/3/4/7/8/9, CL2–CL5; J02-L2, L3, T1, §2.8; FS86-B1-LR, LP, dB-Sv; rows 88, 89, 94–96 | the named files | all exist and were read; `plans/PA-tardif2023.md` §5.2–5.3 **not read** — the brief makes it the fallback "only if the peeling route fails", and it did not |

No brief slip found. One ambiguity logged: CLG-c's "the image of `U_F` in `R_F/NR_F` is the product, over the stable places `𝔓 | N`, of
the images of the local norm-one groups" presumes `R_F/NR_F` splits over places; it does not at a ramified stable dyadic place (FS86-CL2's
diagonal). Stage 2 states the form that is true in general.

### 1.2 C0 — probabilities

*Honest timing: written after the reading and after an unwritten first sketch of the route (the peeling plus weak approximation), before
any step below was written down or checked. Not a blind prior.*

| statement | probability TRUE |
|---|---|
| CLG_k at `k ≤ 9`, totally real `F` in Lemma R's scope | 0.90 |
| CLG_k at every `k`, every real number field (given the owner's ruling that `H_k` holds at every `k`) | 0.75 |
| CLG-c without Lemma R's scope (some true form; the literal "product" form may need the ramified-dyadic exception) | 0.75 |
| CLG-d for fields with complex places | 0.85 |
| CLG-e as stated (level one when `p > k/2`), odd `p` | 0.90; dyadic: 0.6 |
| CLG-g with an explicit exception | 0.80; that the exception is empty at `k ≤ 5`: 0.6 |
| CL3, CL4, CL5 survive under the corrected `A(R_F)` | 0.85 each |

### 1.3 Would-have-searched-here log

- (stage 1) Would have sampled random band characters of `ℤ[i]/3^m` to see whether level collapse fails at band 1/6; instead derived the
  level bound (Stage 3) and checked it on the complete, derivation-fixed character list (Stage 4).

## Stage 2 — SAVED (the core: CLG-a, CLG-b, Lemma C, CLG-c, CLG-d)

**Notation** (the plan's §S, with the owner's correction). `F` a real number field, `L = F(i)`, `c` complex conjugation, `n = [L : ℚ]`,
`U = U_F = {u ∈ L : u·c(u) = 1} = T(F)` for the norm-one torus `T = R¹_{L/F}𝔾_m`, `R = R_F = ℤ[U]` (the additive span of `U`). A **stable
place** is a prime `𝔓` of `L` with `c(𝔓) = 𝔓`; then `𝔭 = 𝔓 ∩ F` is non-split in `L/F`, `𝔓` is the only prime above it, and
`T(F_𝔭) = {x ∈ L_𝔓 : x·c(x) = 1}` is compact. `S_{𝔓,m}` is the image of `T(F_𝔭)` in `O_𝔓/𝔓^m`; `T_{𝔓,m} = Cay(O_𝔓/𝔓^m, S_{𝔓,m})`.
`B_β = {z ∈ ℝ/ℤ : ‖z‖ ≥ β}` for `0 < β ≤ ½` (`B_k := B_{1/k} = [1/k, 1 − 1/k]`); `Θ_β(R) = {θ ∈ Hom(R, ℝ/ℤ) : θ(U) ⊆ B_β}`. `A(R_F) = {ℓ mod 1 :
ℓ ∈ Hom_ℚ(L, ℝ)}` (**all** archimedean places; J03a-9). **`H_k`** (J03a-8, the owner's ruling, every `k ≥ 2`): `Θ_k(R_F) ⊆ T_{N_k}(R_F) +
A(R_F)`, `N_k` finite. Since `Θ_β ⊆ Θ_{⌈1/β⌉}`, `H_k` at every `k` gives the same at every band `β` (**`H_β`**).

Three facts used throughout, each one line:
- **(U1)** `U ⊆ O_𝔓^×` for every stable `𝔓`: `v_𝔓(c(u)) = v_{c(𝔓)}(u) = v_𝔓(u)` and `u·c(u) = 1` give `2v_𝔓(u) = 0`. Hence `R ⊆ O_𝔓`.
- **(U2)** `R ⊗ ℚ = L`: `R ∋ i` and, for `s ∈ F` and `u = (1+is)/(1−is)`, `u + u⁻¹ = 4/(1+s²) − 2` and `u − u⁻¹ = 4is/(1+s²)`; the
  ℚ-span of `R` is a subfield containing `1/(1+s²)` and `s/(1+s²)`, hence `s`.
- **(U3)** `−1, i ∈ U`, so every value set `λ(S_{𝔓,m})` of a character is symmetric.

### 2.1 CLG-a (pullback) — TRUE [hand, one line]

*"A band `k`-character of `T_{𝔓,m}` composed with `R_F → O_𝔓/𝔓^m` lies in `Θ_k(R_F)`."* By (U1) the reduction `ρ : R → O_𝔓/𝔓^m` is a ring
homomorphism, and `ρ(U) ⊆ S_{𝔓,m}` since `U ⊆ T(F_𝔭)`. So `λ∘ρ` is a character with `λ(ρ(U)) ⊆ λ(S_{𝔓,m}) ⊆ B_k`. ∎ No hypothesis on `F`
(any band `β`, any stable place, dyadic ramified included).

### 2.2 CLG-b (the peeling lemma) and its `n`-fold form — TRUE [hand]

**CLG-b.** *"Let `k ≥ 2`, `X, Y ⊆ ℝ/ℤ`, `X = −X`, `X + Y ⊆ B_k`. If some `x ∈ X` lies outside `B_k`, then `Y ⊆ [1/k + ‖x‖, 1 − 1/k − ‖x‖]`."*
Proved at every band `β ∈ (0, ½]`: `x ∉ B_β` means `d := ‖x‖ < β`, and `±x ∈ X`. Let `y ∈ Y`, read `y ∈ (−½, ½]`, and suppose `|y| < β + d`.
If `y ≥ 0` then `y − d ∈ [−d, β)`, an interval inside `(−½, ½)` (as `d < β ≤ ½`), so `‖y − d‖ = |y − d| < β`; but `y − d` is `y + x` or
`y − x`, both in `B_β`. If `y < 0`, the same with `y + d`. So `‖y‖ ≥ β + d`. ∎ (Only `X`'s symmetry is used; `Y` is arbitrary.)

**CLG-b_n.** *If `X_1 + ⋯ + X_n ⊆ B_β` with every `X_j` non-empty and symmetric, then some `X_j ⊆ B_β`.* Induction on `n`; `n = 1` is the
hypothesis. For `n ≥ 2`: if `X_1 ⊆ B_β`, stop; else CLG-b with `X = X_1`, `Y = X_2 + ⋯ + X_n` gives `Y ⊆ B_{β + ‖x‖} ⊆ B_β`, and induct. ∎
The survivor exists and need not be unique ("some", never "exactly one"); a summand containing 0 is never the survivor.

### 2.3 Lemma C (the completed unit-vector ring) — TRUE [hand; new here, one mind]

*For every real number field `F` and every prime `p`, put `V = L ⊗ ℚ_p = ∏_{𝔓|p} L_𝔓`, `V_s = ∏_{stable 𝔓|p} L_𝔓`, `V_n = ∏_{non-stable
𝔓|p} L_𝔓`, and let `R̄_p` be the closure of `R` in `∏_{stable 𝔓|p} Ô_𝔓`. Then (a) inside `V`, `R ⊗ ℤ_p = R̄_p × V_n`; (b) `R̄_p` is an
order (an open subring of finite index) in `∏_{stable 𝔓|p} Ô_𝔓`; (c) `R/p^jR ≅ R̄_p/p^jR̄_p` for every `j`, so `R/NR ≅ ∏_{p|N} R̄_p/NR̄_p`
for every `N`, and `dim_{𝔽_p} R/pR = Σ_{stable 𝔓|p} [L_𝔓 : ℚ_p]`; (d) there is `K` with `R ∩ ∏_{stable 𝔓|N} 𝔓^K ⊆ NR` — the map
`R → R/NR` is continuous for the topology of the stable places above `N`.*

*Proof.* `M := R ⊗ ℤ_p ⊆ V` (flatness), a ring spanning `V` by (U2).
1. *`π_s(M)` is a lattice in `V_s`.* By (U1) the image of `R` in each `L_𝔓`, `𝔓` stable, lies in `Ô_𝔓`, so `π_s(M) ⊆ ∏ Ô_𝔓`, a finitely
   generated free `ℤ_p`-module; `π_s(M)` spans `V_s`; so it is free of rank `a_p = dim V_s`, open of finite index. It is the closure of
   the image of `R` (the `ℤ_p`-span of a subgroup of a finitely generated free `ℤ_p`-module is its closure), i.e. `π_s(M) = R̄_p`: (b).
2. *`M ⊇ L_𝔔` for every non-stable `𝔔 | p`.* Let `h` be the class number of `L`, `(a) = 𝔔^h`, and `u = c(a)/a ∈ U`: `v_𝔔(u) = −h`,
   `v_{c𝔔}(u) = h` (as `𝔔 ≠ c𝔔`), `u` a unit at every other prime. For `𝔓 ≠ 𝔔` above `p` let `χ_𝔓 ∈ ℤ_p[X]` be the characteristic
   polynomial of `u` on `L_𝔓` (integral: `u ∈ Ô_𝔓` there), and `P = ∏_{𝔓 ≠ 𝔔} χ_𝔓`. Then `z := P(u) ∈ ℤ_p[u] ⊆ M` vanishes at every
   `𝔓 ≠ 𝔔` (Cayley–Hamilton) and `z_𝔔 ≠ 0` (every root of every `χ_𝔓` has valuation `≥ 0`; `u_𝔔` has valuation `< 0`). `Λ := π_𝔔(M)` is a
   ring containing a full lattice `Γ₀ ⊇ p^{c}Ô_𝔔` (the projection of `Ω ⊗ ℤ_p`, `Ω ⊂ R` a full ℤ-lattice of `L`) and `u_𝔔^m`, `m ≥ 0`, of
   valuation `−hm`; so `Λ ⊇ u_𝔔^m p^c Ô_𝔔` for all `m`, i.e. `Λ = L_𝔔`. Then `M·z = L_𝔔 × {0}` lies in `M`.
3. So `M ⊇ V_n`, and `M = π_s(M) × V_n` (`x = (π_s x, 0) + (0, π_n x)`): (a). Then `R/p^jR = M/p^jM = R̄_p/p^jR̄_p` (`V_n = p^jV_n`): (c).
4. (d): take `j₀` with `p^{j₀}∏Ô_𝔓 ⊆ R̄_p` and `K` with `𝔓^K ⊆ p^{j+j₀}Ô_𝔓` at every stable `𝔓 | p`. If `x ∈ R` is in `∏ 𝔓^K`, then
   `π_s(x) ∈ p^jR̄_p`, so `x ∈ p^jM + V_n = p^jM`, and `R ∩ p^jM = p^jR`. CRT over `p | N`. ∎

*Corollaries.* Prime inversion (G55; Astra) is (c) with no stable prime above `p` (`R/pR = 0`, so `1/p ∈ R`); J02-L2(a)'s `dim R/pR ≤ n` is
(c). **No Galois hypothesis and no condition at ramified places** is used.

### 2.4 Lemma C′ (when `R̄_p` is the whole product) — TRUE [hand; one mind]

*`R̄_p = ∏_{stable 𝔓|p} Ô_𝔓` — equivalently `R/NR ≅ ∏_{stable 𝔓|N} O_𝔓/NO_𝔓` — for every prime `p`, except possibly `p = 2` when some stable
dyadic place is ramified in `L/F`; at `p = 2` the inert stable places always split off as full factors.* So Lemma R's conclusion
(FS86-B1-LR (b)) holds with **no Galois hypothesis**, and FS86-CL2's ramified-dyadic exception is exactly where it can fail.

*Proof.* By weak approximation (2.5 (W)), the closure of `U` in `∏_{stable 𝔓|p} Ô_𝔓` is `∏ T(F_𝔭)`, so `R̄_p ∋ (t, 1, …, 1) − 1 = (t − 1, 0,
…, 0)` for `t ∈ T(F_𝔭)`. *Idempotent:* if `𝔓` is odd or inert dyadic, `S_{𝔓,1} = μ_{q+1}` (J02-L2(c); inert: `μ_{Q+1}`) has an element
`≠ 1`, so some `t − 1` is a unit and `(t − 1)^{(q²−1)p^r} → e_𝔓`; `R̄_p` is closed, so `e_𝔓 ∈ R̄_p`. *Each factor is full:* `e_𝔓R̄_p` is a
closed subring of `Ô_𝔓` onto `κ_𝔓` (`μ_{q+1}` generates `𝔽_{q²}` as a ring, J02-L2(c)) containing an element of valuation 1 — odd `p`:
`t = (1+iπ)/(1−iπ)`, `π` a uniformizer of `F_𝔭` (and of `L_𝔓`, `L/F` unramified at odd places), `t − 1 = 2iπ/(1−iπ)`; inert dyadic:
`t = 1 + πa`, `ā ∈ 𝔽_Q^×`, from the fixed point `δ = w(−2a₁ − π N(a₁ + δ))` on `𝔓` (`Tr w = 1`; a contraction), `a = a₁ + δ`. A closed
subring of a complete DVR onto the residue field with an element `π′` of valuation 1 is everything (`x = a₀ + π′a₁ + π′²a₂ + ⋯`). ∎
At a ramified stable dyadic `𝔓`, `S_{𝔓,1} = {1}` and no idempotent need exist (CL2's diagonal at ℚ(√17)).

*Independence note.* C′ was derived in my working notes before I saw (Stage 1, Q8) the heading of J09's J2, whose statement it matches at
the level of completions; J2's proof was not opened. So C′ is a second, independent derivation of J2's content in its completed form
(`R_(p) = O′_(p)` ⟺ `R ⊗ ℤ_p = O′_(p) ⊗ ℤ_p`, since `O′_(p)/R_(p)` is `p`-primary torsion).

### 2.5 CLG-c (joint surjectivity) — TRUE in the form below [hand; weak approximation standard]

- **(W) Weak approximation for the rational torus.** For every finite set `Σ` of places of `F`, `U` is dense in `∏_{v∈Σ} T(F_v)`. The
  Cayley map `φ(s) = (1+is)/(1−is)` is continuous on `F_v` minus `{s : s² = −1}`, onto a dense subset of `T(F_v)` (onto `T(F_v) ∖ {−1}`
  when `i ∉ F_v`; at a complex place `T(F_w) = {(z, 1/z)} ≅ ℂ^×` and the image is `ℂ^× ∖ {−1}`); `F` is dense in `∏ F_v`; `φ(F) ⊆ U`. ∎
- **(J) The joint image.** For every `N`, the image of `U` in `R/NR ≅ R̄_N/NR̄_N` (Lemma C) is the image of `∏_{stable 𝔓|N} T(F_𝔭)`, and
  when no stable place above `N` is ramified dyadic it is `∏_𝔓 S_{𝔓, v_𝔓(N)}` under `R/NR ≅ ∏ O_𝔓/NO_𝔓` (C′). Every fibre of
  `U → R/NR` is dense in `∏_{w|∞} T(F_w)`: it contains a coset of `U^M` (`M` the exponent of `(R/NR)^×`), and `z ↦ z^M` is a continuous
  surjection of `S¹` and of `ℂ^×`, so it carries the dense `U` onto a dense subset.
- **The literal statement** ("the product over the stable places of the images of the local norm-one groups") is TRUE when no stable
  place above `N` is ramified dyadic, and meaningless as worded otherwise (`R/NR` need not split over places). It needs no Lemma R.
  J02-L3 is its reduced level at `N = 6`.

### 2.6 CLG-d (the archimedean factor) — TRUE, complex places included [hand; two routes]

*"If `θ = τ + ψ ∈ Θ_k(R_F)` with `τ` torsion and `ψ` archimedean, then `τ ∈ Θ_k(R_F)`."* Proved with more: write `ψ = ℓ mod 1`, `ℓ ∈
Hom_ℚ(L, ℝ) = Hom_ℝ(L ⊗ ℝ, ℝ)`, `L ⊗ ℝ = ∏_{w|∞} L ⊗_F F_w`, `ℓ = Σ_w ℓ_w`.
1. *Real place:* `L ⊗ F_w = ℂ`, `T(F_w) = S¹`, `ℓ_w(z) = Re(ē_w z)`, `ℓ_w(S¹) = [−|e_w|, |e_w|]`.
2. *Complex place:* `L ⊗ F_w = ℂ × ℂ` with `c` swapping the factors, `T(F_w) = {(z, 1/z)}`, `ℓ_w(z, z′) = Re(az) + Re(bz′)`. If
   `(a, b) ≠ 0`, `ℓ_w(T(F_w)) = ℝ` (continuous on the connected `ℂ^×`, unbounded both ways as `z → ∞` or `z → 0`).
3. Let `τ` be killed by `N`. For `u ∈ U`, the fibre of `u` in `U → R/NR` is dense in `∏_w T(F_w)` (2.5 (J)), `τ` is constant on it and
   `θ` is band on it; `B_k` is closed. So `τ(u) + E ⊆ B_k` with `E = ℓ(∏_w T(F_w)) = Σ_w ℓ_w(T(F_w))`. If some complex `ℓ_w ≠ 0` then
   `E = ℝ` and `B_k ⊇ ℝ/ℤ`, false. So **`ℓ_w = 0` at every complex place**, `E = [−r, r]` with `r = Σ_{w real} |e_w|`, and
   `τ(U) ⊆ B_{k}` with margin: `τ(U) + [−r, r] ⊆ B_k`. ∎
The second route is 2.7's step 3 (Lemma C and (W)). This repairs FS89-S0A-7 at complex places (J02 §2.8's warning) by an unboundedness
argument, not compactness; it answers P-CM (predicted 0.60): **TRUE**.

### 2.7 CLG_k (⟹), the assembled core — TRUE given `H_k` [hand]

*Let `θ ∈ Θ_β(R_F)`. Then some stable place `𝔓` and level `K` have a band-`β` character of `T_{𝔓,K}`.*
1. `H_β`: `θ = τ + α`, `Nτ = 0` (`N = N_{⌈1/β⌉}`), `α = ℓ mod 1`, `ℓ ∈ Hom_ℚ(L, ℝ)`.
2. *Localise `τ`* (Lemma C (c), (d)): with `S_N` the stable places above `N` and `K` from (d), `τ` factors through
   `ρ_K : R → ∏_{𝔓∈S_N} O_𝔓/𝔓^K` (its kernel lies in `NR`); a character of the image extends to the product (`ℝ/ℤ` is divisible), so
   `τ = Σ_{𝔓∈S_N} λ_𝔓∘ρ_{𝔓,K}` with `λ_𝔓` a character of `O_𝔓/𝔓^K`. (No Lemma R, no Galois hypothesis.)
3. *Extend to the product of places* (W): on `G = ∏_{𝔓∈S_N} T(F_𝔭) × ∏_{w|∞} T(F_w)`, `Φ(g) = Σ_𝔓 λ_𝔓(g_𝔓 mod 𝔓^K) + ℓ(g_∞) mod 1` is
   continuous and agrees with `θ` on the dense diagonal image of `U`; so `Φ(G) ⊆ B_β`, i.e. **`Σ_{𝔓∈S_N} X_𝔓 + E ⊆ B_β`** with
   `X_𝔓 = λ_𝔓(S_{𝔓,K})` (symmetric, (U3)) and `E = ℓ(∏_w T(F_w))`; by 2.6, `E = [−r, r] ∋ 0`.
4. *Peel* (CLG-b_n): some summand lies in `B_β`; not `E` (`0 ∉ B_β`). So some `λ_𝔓(S_{𝔓,K}) ⊆ B_β`. If `S_N = ∅`, `Σ = E ⊄ B_β`: so
   `Θ_β ≠ ∅` forces a stable place above `N`. ∎

With 2.1 this is CLG_k's equivalence; Stage 3 assembles it and adds the level.

### Would-have-searched-here log (stage 2)

- Would have computed `ℤ[U_F]/pℤ[U_F]` for a non-Galois cubic with a mixed prime by sampling unit vectors and row-reducing, to test
  whether it splits over places; instead derived Lemma C/C′, which decide it for every field.

## Stage 3 — SAVED (CLG_k assembled; CLG-e and the level bound; CLG-g)

### 3.1 CLG_k — TRUE for every real number field and every `k ≥ 2`, given `H_k` [hand; inputs named]

*"Let `k ≥ 3` satisfy `H_k`, and let `F` be a real number field. Then `Θ_k(R_F) ≠ ∅` if and only if some stable place `𝔓` of `F(i)` and some
level `m ≥ 1` have a band `k`-character of `T_{𝔓,m}`. Hence `χ_char(F²) = min_{𝔓,m} χ_char(T_{𝔓,m})`, and a character `k`-colouring of
`F²` exists only if some residue target of `F` is `k`-colourable."*

⟸ is CLG-a (2.1); ⟹ is 2.7. "Hence": `Θ_k ⊆ Θ_{k+1}`, so `χ_char(F²) = min{k : Θ_k ≠ ∅}` and the equivalence at every `k` gives the
equality. Last clause: a band `k`-character `λ` of `T_{𝔓,m}` makes `x ↦ ⌊kλ(x)⌋` a proper `k`-colouring of `T_{𝔓,m}` (adjacent values differ
by `λ(s) ∈ [1/k, 1 − 1/k]`). ∎ **Inputs, by name:** `H_k` (J03a-8, verified at every `k` by the owner's ruling; J01 at `k ≤ 9`); Lemma C
(this record, one mind); weak approximation for the rational torus (standard); CLG-b_n (this record; the planner's J03-1, one mind before
it). **Not used:** Lemma R (FS86-B1-LR), its Galois scope, `[Zhang2012]`, `[Zhu2011]`/PA-T4, any certificate, J02 or J09.

**The converged form** (§M.1) — TRUE: *`κ(R_F, U_F) = max over stable 𝔓 of κ_loc(𝔓)`*, with `κ(R, U) = max{β : Θ_β(R) ≠ ∅}` and
`κ_loc(𝔓) = sup{β : some T_{𝔓,m} has a band-β character}`. `≥` is CLG-a at band `β`; `≤` is 2.7 applied to a `θ` attaining `κ(R_F)`
(`Θ_β` is compact and decreasing in `β`, so the maximum is attained), under `H_β` (which follows from `H_k` at every `k`, Stage 2
notation). The maximum over places is attained at that `θ`'s survivor. `χ_char = ⌈1/κ⌉`.

**Scope.** Every real number field, including fields with complex places and non-Galois `F(i)/ℚ` (ℚ(α, √7), J02's instance). Not for
infinite-degree `F ⊆ ℝ` (Lemma C uses a class number and a lattice; FS-39's gap). **Characters only**: nothing about `χ(F²)`.

### 3.2 The level bound, and CLG-e — TRUE at odd `p` (every `k`), and at inert dyadic places for `k = 3` [hand]

**Lemma LB.** *Let `𝔓` be a stable place over an odd prime `p`, `e = e(𝔭|p)`, `κ_𝔭 = 𝔽_q`, and let `λ` be a band-`β` character of
`T_{𝔓,m}` of exact level `L ≥ 2` (it kills `𝔓^L/𝔓^m`, not `𝔓^{L−1}/𝔓^m`). Then `2β·p^a ≤ 1` with `a = ⌊(⌊L/2⌋ − 1)/e⌋ + 1`.*

*Proof.* Put `j′ = ⌈L/2⌉`. `L/F` is unramified at `𝔓`, so a uniformizer `π ∈ F_𝔭` is one of `L_𝔓`.
1. *Tangent line.* For `s ∈ 𝔭^{j′}`, `t_s = (1+is)/(1−is) ∈ T(F_𝔭)` and `t_s − 1 = 2is/(1−is) ≡ 2is (mod 𝔓^L)` (as `2j′ ≥ L`); and
   `t ↦ t − 1 mod 𝔓^L` is a homomorphism on `T(F_𝔭) ∩ (1 + 𝔓^{j′})` (`(t−1)(t′−1) ∈ 𝔓^{2j′}`).
2. *Sweep.* For `σ ∈ T(F_𝔭)`: `λ(σt_s) = λ(σ) + ψ_σ(s)` with `ψ_σ(s) := λ(2iσs)`, a character of `𝔭^{j′}/𝔭^L ≅ O_𝔭/𝔭^{⌊L/2⌋}` whose
   image is a cyclic group `p^{−a′}ℤ/ℤ`. All of `λ(σ) + p^{−a′}ℤ/ℤ` lies in `λ(S_{𝔓,m}) ⊆ B_β`; a coset of step `p^{−a′}` meets every open
   arc of length `2β > p^{−a′}`, and `(−β, β)` is one. So `2β·p^{a′} ≤ 1` for every `σ`.
3. *Some `σ` has large `a′`.* `λ ≠ 0` on `𝔓^{L−1}/𝔓^L = π^{L−1}κ_𝔓`; the `𝔽_q`-lines `σ̄·i·𝔽_q` (`σ̄ ∈ μ_{q+1}`, `(q+1)/2 ≥ 2` distinct ones)
   span `κ_𝔓`, so some `σ` has `ψ_σ ≠ 0` on the socle `𝔭^{L−1}/𝔭^L`, at some `y₀`. Write `y₀ = p^b y₁`, `y₁ ∈ 𝔭^{j′}`, possible for
   `b = ⌊(⌊L/2⌋ − 1)/e⌋` (`𝔭^{L−1} ⊆ 𝔭^{eb + j′}`); then `ψ_σ(y₁)` has order `≥ p^{b+1}`, so `a′ ≥ a`. ∎

**CLG-e** — *"At a stable place of residue characteristic `p > k/2`, every band `k`-character of `T_{𝔓,m}` factors through `T_{𝔓,1}`."*
- *Odd `p`:* `L ≥ 2` would give `a ≥ 1` and `2p ≤ 2p^a ≤ k`. So `L = 1`. **TRUE** (FS89-S0A-4 is its `k = 4, 5` case).
- *Inert dyadic, `k = 3`:* the same with step ½ — the tangent set at depth `j ≥ 1` contains `π^j·𝔽_Q` (the fixed point of 2.4), the
  lines `σ̄𝔽_Q` (`σ̄ ∈ μ_{Q+1}`, distinct since `μ_{Q+1} ∩ 𝔽_Q^× = 1`) span `𝔽_{Q²}`, and a coset `{c, c + ½}` never fits in `[1/3, 2/3]`.
  **TRUE.** (At level one `U_Q` has no band character at all: its values lie in `{0, ½}` and `Σ_{μ_{Q+1}} t = 0` with `Q + 1` odd — J02-L4(b).)
- *Ramified dyadic, `k = 3`:* **not decided here** (values in `(1/8)ℤ ∩ [1/3, 2/3] = {3/8, ½, 5/8}` are not excluded by one sweep).
  Harmless: such a field has `L(F) = 2` (G56), so CLG-g never needs it.

**The level bound in numbers** (`e = 1`): band-`k` characters at an odd stable place have level 1 if `k < 2p`, level `≤ 3` if
`2p ≤ k < 2p²`, level `≤ 2r + 1` if `2p^r ≤ k < 2p^{r+1}`. At `p = 3`: level `≤ 3` for `6 ≤ k ≤ 17`. So **every stable odd place contributes
one finite target**, `T_{𝔓, M_k(p,e)}`. Sharpness of the level-2/3 allowance at `2p ≤ k` is checked in Stage 4 (tool).

### 3.3 CLG-g (the conjecture for characters), with the exception explicit — TRUE [hand + tools-grade inputs named]

*"Under `H_k`, for every real number field `F`: a character `k`-colouring of `F²` exists only if `L(F) ≤ k`, except possibly through a place
of residue characteristic `p ≤ k/2` above level one."* Proved in the sharper form:

**Theorem CLG-g.** *Let `k ≥ 3`, `F` a real number field, `Θ_k(R_F) ≠ ∅`. Then `L(F) ≤ k`, unless every stable place carrying a band
`k`-character carries it only above level one and is of one of two kinds:*
- ***(E1)*** *odd, with residue field `𝔽_q`, `q = p^f`, **`f ≥ 3`**, `2p ≤ k < χ(Γ_q)` (level `≤ M_k(p, e)`);*
- ***(E2)*** *inert dyadic of norm **`Q ≥ 64`**, `k < χ(U_Q)`, and `k` at least `U_Q`'s Hoffman floor (6 at `Q = 64`, 8 at `Q = 128`).*

*Proof.* `L(F) = min_𝔓 χ(T_{𝔓,1})` over stable `𝔓` (the notation's definition: `Γ_q` at odd places, `U_Q` at inert dyadic ones, and
`χ = 2` at ramified dyadic ones, G56). Let `𝔓` be a survivor (CLG_k).
1. Ramified dyadic: `L(F) = 2`.
2. Odd with `2p > k`, or inert dyadic with `k = 3`: CLG-e gives level one, `χ(T_{𝔓,1}) ≤ k`.
3. Odd with `2p ≤ k` and `f = 1`: `χ(Γ_p) ≤ p + 1 ≤ k` (Brooks; `Γ_p` is connected of degree `p + 1`, neither complete nor a cycle).
4. Inert dyadic, `k ≥ 4`: `Q ≤ 32` gives `χ(U_Q) ≤ 4 ≤ k` (G56: four-colourings found by CaDiCaL, FS-54 [tools]). `Q ≥ 64`: a band
   `k`-character at level `m` forces `α(T_{𝔓,m})/|T_{𝔓,m}| ≥ 1/k` (**Lemma AV**: for a band-`β` character of a finite Cayley graph, the
   arc sets `λ⁻¹[y, y + β)` are independent and average `β|G|` over `y`, so `α ≥ β|G|`), and the inert tower keeps its Hoffman ratio at every
   level (G54, GPT Astra, recomputed at 2 by `tools/fs54_wall_feedback_verify.py`); so `k` is at least the floor. What is left is (E2).
5. Odd with `2p ≤ k`, `f ≥ 3`: `χ(Γ_q) ≤ k` gives `L ≤ k`; otherwise (E1). ∎

**Corollaries** [hand]:
- **(g1) No exception at `k ≤ 5`**: (E1) needs an odd `p ≤ 5/2`; (E2) needs `k ≥ 6`. So *for every real number field, a character four- or
  five-colouring exists only if `L(F) ≤ 4`, resp. `≤ 5`.* (C0 predicted 0.6 for an empty exception at `k ≤ 5`.)
- **(g2) No exception in degree ≤ 2, at any `k`**: (E1) needs residue degree `f ≥ 3`, so `[F : ℚ] ≥ 3`; (E2) needs `f(𝔭|2) ≥ 6`, so
  `[F : ℚ] ≥ 6`. *For every real quadratic field and every `k ≥ 3`: a character `k`-colouring exists only if `L(F) ≤ k`.* This is SIX-e's
  hypothesis at ℚ(√167) with no exception: every stable place is odd with prime `q ≥ 23 > 7/2`, so a character six- or seven-colouring of
  ℚ(√167)'s plane exists iff some level-one `Γ_q`, `q` stable, has a band six- (seven-) character.
- **(g3) At `k ∈ {6, 7}`**, the exception is at most `q = 27` (levels 2–3; `χ(Γ₂₇) ≥ 6`, G56) and `Q = 64` (`6 ≤ χ(U₆₄) ≤ 8`), *given* the
  odd-tower Hoffman ratio at `q = p^f` for every level (FS86-LP is stated at prime `q`; its fibre argument reads one `𝔽_q`-line per
  fibre and should give `max(h(Γ_q), 2/(q+3))` — sketched, one mind, not relied on). Without it, add every `q = 3^f`, `f ≥ 5`, at levels
  2–3.

**What CLG-g does not say:** anything about non-character colourings; that the exception is ever realised (open: a band six-character of
`UD(ℤ/729-analogue)` at `q = 27` level 2, or of the 64-tower at level `≥ 2`); anything for `k ≤ 2` beyond `Θ₂ ⊆ T₂` (J03a-5).

### Would-have-searched-here log (stage 3)

- Would have enumerated band six-characters of the level-2 target at `q = 27` to see whether (E1) is realised; not done — it is a finite
  question a derivation fixes (`|O/𝔓²| = 3⁶·… `), but it bears only on fields of degree ≥ 3 and is J08's territory (SIX-d); logged as a
  SPAWN candidate instead.
