# FS103-V1 — blind verification of FS-103's claim list (the collapse)

*Job FS103-V1 (Coxeter, verifier), Opus 5.5, 2026-09-26. Brief `data/fs103/briefs/V1-collapse-verifier.md`; standing rules
`data/fs103/briefs/STANDING-RULES.md`; the fixed list `data/fs103/claims.md`. Blind: nothing on the brief's fence list (nor the owner's two
additions of 2026-09-26: `plans/FS103-F-*.md`, `data/fs103/fs103-f/`, `tools/fs103_f_*`, `data/fs103/briefs/F103-*.md`, commit bodies "FS103-F…")
opened before stage 3's commit.*

## Theorems this phase proved

- **V1-LB (C-LB)** — for totally real `F` outside row 100's exception and any `k ≥ 2` with `N_k(F) = ∅`: `F²` `k`-colourable ⟹ `UD(ℝ²)` has a CP
  `k`-colouring, or an SP witness exists; no MR; general form keeps the non-thick factors. [hand, one mind, blind] — §Stage 2a.
- **V1-L2** — the `T + A` spectral subspace of a translation-invariant colouring measure is `L²` of a factor (conditional expectation). [hand] — §2a.
- **V1-L3** — the dichotomy: `τ = σ|_{R̂∖(T+A)}` always has `∫χ(1)dτ ≤ 0`; `= 0` iff adjacent conditional colour laws have disjoint supports. [hand] — §2a.
- **V1-L5** — extension of the conditional-law process to `G_∅` (I-EXT4's form at `k` colours, `S = ∅`). [hand] — §2a.
- **V1-L6** — selection over a compact factor with `λ* < 1/(k−1)` by a randomised threshold on fibre masses, sharp at `K_k`. [hand] — §2a.
- **V1-L8** — merging real places by the diagonal (I-MERGE's needed direction, one line). [hand] — §2a.
- **C-635-F1 / C-F1-GEN (scope)** — given MR, `χ(ℝ²) = χ_CP(ℝ²) = χ(F²)` for every totally real `F` outside the exception with `N₆(F) = ∅`;
  instances ℚ(√635087), `F_dG`. [hand, assembly one mind] — §2b.
- **Density-point lemma** (C-FMT (d)'s partial step) — density-point regularisation of an a.e.-proper measurable colouring avoids distance 1
  everywhere off a null set. [hand, one mind] — §2b.
- **Places and spectra** — ℚ(√635087)'s stable places below 1000, `F_dG`'s below 600 (131, 479 only), dyadic splitting, level-one `λ*(Γ_p)`
  for 17 primes incl. 131 (`0.168047`) and the non-6-thick list. [tools exact, two code bases] — `tools/fs103_v1_checks.py`,
  `data/fs103/fs103-v1/{places,dyadic}.gp`, `checks.out`.

## Stage 1 — SAVED (quotation check, C0, wrong-reason lines and controls)

### 1.1 Quotation check of `data/fs103/claims.md` (standing rule 5)

| item | source | result |
|---|---|---|
| D-RUL, D-STAB, D-GV, D-THK (c), D-CP (b), D-SP, D-NY's `UD(ℝ²)` gloss, the spectral-measure gloss in D-TAE | `plans/FS100-BC-verification.md` §1.2 | fenced — deferred to stage 4 |
| D-THK (a), D-M's quoted `χ_µ` gloss | `plans/M3-derivation.md` header | fenced — deferred to stage 4 |
| D-THK (b), D-NY, D-CP (a), C-LB's quoted clause | wanted-poster §3, §3.2 | fenced — deferred to stage 4 |
| D-USE (both clauses) | `CLAUDE.md` § Notation | **verbatim** |
| D-TAE (first sentence) | `plans/R88-derivation.md` l. 21–23 | **verbatim** |
| D-MR | `LEDGER.md` row 120 | **verbatim** |
| D-S | `CLAUDE.md` G64 | **verbatim** |
| `F_dG` gloss ("span K(√5,√7)") | `CLAUDE.md` G43 | **verbatim** |
| I-MR's grade bracket | row 120 | **verbatim** |
| FS100-PE2, FS100-EFP (I-MR's components) | `plans/FS100-derivation.md` l. 189, 160 | **verbatim** (the list quotes the statement clauses only; the `; equivalently …` / `; hence EF_F` tails are omitted, not altered) |
| I-C′ | row 100 | **verbatim** |
| I-RU | `plans/FS84-SI-D-derivation.md` §4.1 | **verbatim**; its stage-4 verdict line scopes it "for every real number field, every finite `S`" (not quoted in the list; recorded here because C-LB needs that scope) |
| I-SEL | row 124 | **verbatim** |
| I-EXT4 | `plans/R88-derivation.md` l. 114 (R88-TC-ext) | **verbatim** |
| I-MX | sealed | deferred to stage 4 |
| I-MERGE, I-CP57's upper bound | `plans/FS100-X21V-verification.md` | fenced — deferred to stage 4 (row 125, open, restates I-MERGE: "`G × G` is CP-`k`-colourable iff `G` is" — consistent) |
| I-CPUP | row 125 | **verbatim** |
| I-CP57 lower half (`m₁(ℝ²) ≤ 0.246989`) | row 92 | the number verbatim |
| I-WEIL's X26B-L1 quote | row 123 | **verbatim** |
| C-dG-PL's quotes "no prime below 131 is usable"; "first usable primes 131, 479" | `CLAUDE.md` G43; row 53 | **verbatim** (the second is row 53's, not 52's) |
| C-F1-GEN, C-635-PL, C-dG-F1, C-CPM | `plans/STUB-collapse-cp-plane.md` | fenced — deferred to stage 4 |
| C-S | `plans/RERANK-2026-09-26.md` §1.1 | fenced — deferred to stage 4 |

**One note on the list itself:** `plans/FS100-derivation.md` l. 277 (open) carries two constants I use as controls: "`λ*(Γ₁₁) = 0.476413`,
`λ*(Γ₁₉) = 0.380486 > 1/3`"; row 110 carries "59 has ratio `0.199119854095` exactly".

### 1.2 C0 — each claim in my words, my wrong-reason line, my control

| claim | in my words | wrong-reason pass would look like | my control |
|---|---|---|---|
| **C-LB** | For totally real `F` with `R = O′` and every stable place `k`-thick: a proper `k`-colouring of `F²` yields either a CP `k`-colouring of the real plane's unit-distance graph, or a rotation-invariant, `E`-null, positive finite measure on `R̂` whose pairing with evaluation at 1 is negative. | (i) treating the spectral projection onto `T + A` as simplex-valued without proving it is a conditional expectation (the bound `≥ −1/(k−1)` then has no reason); (ii) transferring properness from `U` to the closed edge set without `U`'s density in it; (iii) (B)'s `τ(E) = 0` asserted without R-U; (iv) a selection over the compact places that would still run with a non-thick place present, or reads only level one; (v) using MR where the claim has none. | **Known answers at `k = 4`, fixed before deriving** (from `LEDGER.md`): (K1) ℚ(√167) — `N₄ = ∅` (first stable place 23, row 115: `Γ_p` has `λ* < 1/3` "from 23"), so the chain with MR and `χ_CP ≥ 5` must give `χ ≥ 5`: row 123 / FS100-167's second route. (K2) ℚ(√11) — `χ = 4` (row 73) with the stable 7 (`Γ₇`, not 4-thick): the chain must **not** refute four colours; it must stop at the selection over `G₇`, and its (A) must then be `UD(ℝ²) × G₇`, which does carry a CP 4-colouring. Secondary: ℚ(√47) (`χ = 5`, row 121) with `N₄ = {11}` (`λ*(Γ₁₁) = 0.476`). **Arithmetic-free control of the selection step:** `K_{k+1} × K_k` is `k`-colourable while `K_{k+1}` is not; `K_k` has `λ* = 1/(k−1)` exactly, so a selection lemma must fail at equality — strictness must be used. |
| **C-CPUP** | The plane's chromatic number is at most the CP one, and a subfield's is at most the plane's. | restricting a CP colouring to all of `ℝ²` (uncountably many edges; "a.s. proper at each edge" does not give one proper realisation). | the argument must pass through a countable `F` and de Bruijn–Erdős; a proof with no countability step is the wrong one. |
| **C-635-PL** | 635087 is a prime `≡ 7 (mod 8)`; every prime `≡ 3 (mod 4)` below 103 is inert in ℚ(√635087); the stable places are those above split or ramified primes `≡ 3 (mod 4)`. | checking inertia by Kronecker symbol only, never the dyadic place or the ramified place; a script whose plant cannot fire. | the same script on ℚ(√167) must return first stable place 23 and dyadic split; plant: replace 635087 by a number `≡ 3 (mod 8)` (dyadic place then stable) and a number with an early split prime. |
| **C-635-THK** | Every stable place of ℚ(√635087) has full-depth mixing constant `< 1/5`. | Weil at level one only (higher levels, the ramified place's `e = 2` tower, and dyadic places forgotten). | my level-one spectrum code must reproduce `λ*(Γ₁₁) = 0.476413`, `λ*(Γ₁₉) = 0.380486`, `λ*(Γ₅₉) = 0.199119854095`. |
| **C-635-F1** | Given MR at ℚ(√635087): its plane, the real plane and the CP plane have one chromatic number. | applying C-LB at `k = 6` only, never at `k = χ(F²)` (which may be 5); or equality with `χ(ℝ²)` with no C-CPUP. | ℚ(√167): the same assembly must stop (`N₆ ∋ 23, 43`, so C-LB's hypothesis fails at `k = 6`; row 125 keeps the factors `G₂₃ × G₄₃`). |
| **C-635-TF** | ℚ(√635087)'s plane has no unit triangle; with C-635-F1 and `χ(ℝ²) ≥ 6` a finite triangle-free unit-distance graph of chromatic number ≥ 6 exists. | "no √3" asserted without the `ζ₆ ∈ L` step; the finite graph asserted without de Bruijn–Erdős. | ℚ(√3,√5): `√3 ∈ F`, triangles present, the argument must refuse to call it triangle-free. |
| **C-dG-F1** | Given MR at `F_dG` and its place list: `χ(ℝ²) = χ_CP(ℝ²) = χ(F_dG²)`. | de Grey's `χ ≥ 5` read as thickness; 11's residue degree 2 missed; dyadic places not classified. | Heule's field K(√5): sealed at 5 by `Γ₁₁` (`λ* = 0.476 ≥ 1/5`, not 6-thick) — the assembly must stop there. |
| **C-S** | (a) S rules out a six-chromatic plane; (b) over totally real number fields, given MR, "no field is six" ⟺ `χ_CP = 5` or (`χ_CP = 7` and no field with a non-6-thick place is exactly six); (c) is the residual family finite; (d) what is missing beyond. | (a) treated as needing C-dG-F1 (for subfields of ℝ it is trivial — ℝ is one; the number-field form is what needs it); (c) counting residue fields and calling that counting local planes. | (c): ℚ₂₃ and ℚ₂₃(√23) both give stable places with residue field `𝔽₂₃`, different towers. |
| **C-FMT, C-CPM** | Format comparisons between CP, measurable-a.e., measurable and Borel chromatic numbers. | a Følner-limit construction assumed to keep continuity in probability. | a measurable colouring whose local `L¹` modulus of continuity degrades at infinity: its box averages need not converge to a process continuous in probability. |

### 1.3 Would-have-searched-here log

*(none yet)*

## Stage 2a — SAVED (the load-bearing claim C-LB, derived blind)

*Inputs used, each by statement only: I-RU, I-C′ (`R = O′`), I-WEIL, I-CP57 (controls), I-MR (only where marked "given MR"). Not used:
I-SEL, I-EXT4 (re-derived below in the form needed, at `k` colours and `S = ∅`), I-MX (sealed; my selection lemma is my own), I-MERGE
(its needed direction is one line, V1-L8). Classical tools named at use: Bochner–Herglotz on discrete and on second-countable LCA groups,
strong approximation for `𝔾_a`, weak approximation for the norm-one torus (via Hilbert 90), existence of a jointly measurable modification of
a process continuous in probability on a separable metric index set, Parseval on a compact metrizable abelian group.*

**Setting.** `F` totally real of degree `d`, outside row 100's exception, so `R = O′` (I-C′): the elements of `L` integral at every stable
prime. Stable places of `F`: odd `v` whose residue field is `𝔽_q`, `q ≡ 3 (mod 4)` (then `L_w/F_v` is unramified quadratic, residue
field `𝔽_{q²}`; for odd `v`, `i ∈ F_v` iff `−1` is a square in the residue field, by Hensel), and dyadic `v` with `L_w/F_v` inert (the
ramified case is the exception). `G_∅ := (L ⊗ ℝ) × K`, `K := ∏_{w stable} O_w` (compact metrizable), `T_∅ := ∏_{v|∞} S¹ × ∏_w T_w`, `T_w`
the norm-one group of `L_w` (`⊆ O_w^×`, since `|u|_w = |ū|_w` at a conjugation-fixed `w`); `L ⊗ ℝ = ℂ^d` because `F` is totally real, so
`Cay(G_∅, T_∅) = UD(ℝ²)^{×d} × ∏_w Cay(O_w, T_w)` (categorical). `ν := ⊗_w ν_w`, `ν_w` Haar on `T_w`.

**V1-L0 (invariant random colouring).** If `F²` is `k`-colourable, `[k]^R` carries an `R ⋊ U`-invariant probability `μ` on proper
`k`-colourings of `Cay(R, U)`. *Proof.* `R ⋊ U` (affine maps `x ↦ ux + r`) is countable and solvable, hence amenable; it preserves the
closed set of proper colourings (`u⁻¹(x + w − r) − u⁻¹(x − r) = u⁻¹w ∈ U`); average the orbit of one colouring over a Følner sequence and take
a weak-* limit. ∎

**V1-L1 (spectral measure).** With `g(x) = e_{c(x)}` (simplex, `⟨e_a, e_b⟩ = (k/(k−1))δ_ab − 1/(k−1)`), `r(x) := E⟨g(0), g(x)⟩` is positive
definite, real and even, `r(0) = 1`; Herglotz gives `σ` on `R̂` with `r(x) = ∫ χ(x) dσ`, total mass 1, symmetric; rotation invariance of `μ`
gives `r(ux) = r(x)`, hence `u_*σ = σ` for `(u·χ)(r) = χ(ur)`; properness gives `r(w) = −1/(k−1)` for `w ∈ U`, in particular
`∫ χ(1) dσ = −1/(k−1)`. ∎

**V1-L2 (the `T + A` factor).** Let `H := {f ∈ L²(μ) : σ_f(R̂ ∖ (T + A)) = 0}` (spectral measures for the Koopman translation action). Then
(a) `T + A` is exactly the set of restrictions to `R` of characters of `G_∅` (so Borel, σ-compact, `U`-invariant); (b) `f ∈ H` iff
`y ↦ f∘τ_y` is continuous at 0 in `L²` for the `G_∅`-topology on `R`; (c) `H = L²(𝓕)` for a translation-invariant sub-σ-algebra `𝓕`, so the
spectral projection onto `T + A` is `E[· | 𝓕]`. *Proof.* (a) `R/nR = O′/nO′ ≅ ∏_{w stable, w|n} O_w/nO_w` (`O′` integral exactly at the
stable primes), so the torsion characters are the restrictions of `K̂ = ⊕_w Ô_w`; the archimedean ones are the restrictions of
`(L⊗ℝ)^`; sums give `Ĝ_∅`'s restrictions (a countable union of translates of an image of `ℝ^{2d}`). `u` acts on `G_∅` by a homeomorphism
(multiplication; `u ∈ O_w^×` at stable `w`), so the set is `U`-invariant. (b) ⟹: `‖f∘τ_y − f‖² = 2∫(1 − Re χ(y)) dσ_f → 0` by dominated
convergence, each `χ ∈ T + A` being `G_∅`-continuous (`G_∅` metrizable, sequences suffice). ⟸: `φ(y) = ⟨f∘τ_y, f⟩` is positive definite and
`G_∅`-continuous on `R`, hence uniformly continuous (`|φ(x) − φ(y)|² ≤ 2φ(0)(φ(0) − Re φ(x − y))`), so it extends to the closure of `R` in
`G_∅`, a closed subgroup, positive definite there; Bochner there and Pontryagin extension of its characters to `G_∅` put `σ_f` on the
restrictions of `Ĝ_∅`, i.e. on `T + A` by (a) (uniqueness of Fourier–Stieltjes transforms on the discrete `R`). (c) The bounded elements of
`H` with `G_∅`-continuous orbit form a unital `*`-algebra (`‖(fh)∘τ_y − fh‖ ≤ ‖f‖_∞‖h∘τ_y − h‖ + ‖h‖_∞‖f∘τ_y − f‖`), closed under
bounded `L²` limits (uniformly in `y`, since `τ_y` is unitary), so it is `L^∞(𝓕)` for the σ-algebra `𝓕` it generates; every `f ∈ H` is an
`L²` limit of Lipschitz truncations of its real and imaginary parts, which keep a continuous orbit and are bounded, so `H = L²(𝓕)`;
`τ_y` commutes with spectral projections, so `𝓕` is translation-invariant. ∎

**V1-L3 (the dichotomy — C-LB's two cases).** Put `τ := σ|_{R̂∖(T+A)}` and `p_x(a) := P(c(x) = a | 𝓕)`. Then `τ` is a `U`-invariant finite
positive measure with `τ(E) = 0`, and `∫ χ(1) dτ ≤ 0`. **Either** `∫ Re χ(1) dτ < 0` — case (B) — **or** `∫ χ(1) dτ = 0`, and then
`Σ_a p_x(a) p_{x+u}(a) = 0` a.s. for every `x ∈ R`, `u ∈ U` (the conditional colour laws at adjacent vertices have disjoint supports).
*Proof.* `U`-invariance: restriction of the `U`-invariant `σ` to the `U`-invariant Borel set `R̂ ∖ (T + A)`. `τ(E) = σ(E ∖ (T + A)) = 0` by
**I-RU** (applied to the finite `U`-invariant `σ`) — the one place R-U is used, and it is what makes (B)'s witness `E`-null rather than
merely `(T + A)`-null. By V1-L2 (c), `ḡ(x) := E[g(x) | 𝓕] = Σ_a p_x(a) e_a` is the spectral projection of `g(x)` onto `T + A`, so
`E⟨ḡ(0), ḡ(u)⟩ = ∫_{T+A} χ(u) dσ = ∫_{T+A} χ(1) dσ` (`U`-invariance of `σ|_{T+A}`). For probability vectors `p, q`,
`⟨Σ p_a e_a, Σ q_b e_b⟩ = (k/(k−1))Σ_a p_a q_a − 1/(k−1) ≥ −1/(k−1)`. Hence `∫ χ(1) dτ = −1/(k−1) − ∫_{T+A} χ(1) dσ ≤ 0`, with equality iff
`E Σ_a p_0(a) p_u(a) = 0`; stationarity moves `0` to any `x`. ∎

**V1-L4 (density).** `R` is dense in `G_∅`, and `U` is dense in `T_∅`. *Proof.* Strong approximation for `L` omitting one split prime `w₀`:
an adelic basic open set prescribing `L ⊗ ℝ` to within `ε`, finitely many stable residues modulo `𝔭^n`, and integrality at every other
finite place `≠ w₀` contains some `x ∈ L`; such `x` is integral at every stable prime, so `x ∈ O′ = R`. For `U`: by Hilbert 90
`U = {y/ȳ : y ∈ L^×}`; weak approximation makes `L^×` dense in `∏_{v∈S} (L ⊗ F_v)^×` for every finite `S`, and `y ↦ y/ȳ` maps
`(L ⊗ F_v)^×` continuously onto the local norm-one group (local Hilbert 90; `S¹` at a real place), so `U` is dense in every finite
sub-product of `T_∅`, hence in `T_∅` (product topology). ∎

**V1-L5 (extension; I-EXT4's form at `k` colours, `S = ∅`).** In case (not B), `p` extends to a `G_∅`-stationary, `Δ_k`-valued process `p̃`,
continuous in probability, with a jointly measurable version, such that `Σ_a p̃_z(a) p̃_{z+t}(a) = 0` a.s. for every `z ∈ G_∅`, `t ∈ T_∅`.
*Proof.* Each `p_·(a)` is `(E[1_{c(0)=a} | 𝓕])∘τ_x`, in `H`, so `‖p_y − p_0‖₂ → 0` as `y → 0` in `G_∅` (V1-L2 (b)), uniformly in the base
point by stationarity; for `z ∈ G_∅` take `y_n → z` in `R` (V1-L4): `p_{y_n}` is Cauchy in `L²`, set `p̃_z` its limit (a probability vector
a.s.). Finite-dimensional laws are limits of translates, so `p̃` is `G_∅`-stationary. For `z`, `t ∈ T_∅`, take `y_n → z` in `R`, `u_n → t`
in `U`: `(p,q) ↦ Σ_a p_a q_a` is bounded bilinear, so `E Σ_a p̃_z(a) p̃_{z+t}(a) = lim E Σ_a p_{y_n}(a) p_{y_n+u_n}(a) = 0`. Jointly
measurable version: the classical theorem for processes continuous in probability on a separable metric index set. ∎

**V1-L6 (selection over a mixing compact factor).** Let `G₀` be a second-countable LCA group, `S₀ ⊆ G₀`, `K` compact metrizable abelian,
`ν` a symmetric probability on `T_K ⊆ K`, `λ* := sup_{ξ ∈ K̂∖0} |ν̂(ξ)| < 1/(k−1)`. If `p̃` is a jointly measurable, `G₀ × K`-stationary,
continuous-in-probability `Δ_k`-valued process with `Σ_a p̃_z(a) p̃_{z+(s,t)}(a) = 0` a.s. for every `z`, `s ∈ S₀`, `t ∈ T_K`, then
`Cay(G₀, S₀)` carries a CP `k`-colouring. *Proof.* Fibre masses `m_x(a) := ∫_K p̃_{(x,h)}(a) dh`, `Σ_a m_x(a) = 1`. **Edge inequality:** for
`s ∈ S₀`, Fubini (joint measurability) turns the a.s. statements into: a.s., `∫∫ φ(h) ψ(h + t) dh dν(t) = 0` for `φ = p̃_{(x,·)}(a)`,
`ψ = p̃_{(x+s,·)}(a)`, `[0,1]`-valued with means `α = m_x(a)`, `β = m_{x+s}(a)`. Parseval on `K`:
`0 = αβ + Σ_{ξ≠0} \overline{φ̂(ξ)} ψ̂(ξ) ν̂(ξ) ≥ αβ − λ*‖φ − α‖₂‖ψ − β‖₂ ≥ αβ − λ*√(α(1−α)β(1−β))`, so, if `α, β > 0`,
`√((α/(1−α))(β/(1−β))) ≤ λ*`. Since `λ* < 1/(k−1)`, `λ*/(1 + λ*) < 1/k`; fix `λ*/(1+λ*) < θ₁ < θ₂ < 1/k`. **Randomised threshold:** draw
`θ` uniform on `[θ₁, θ₂]`, independent, and set `f(x) :=` the least `a` with `m_x(a) ≥ θ` (exists: `max_a m_x(a) ≥ 1/k > θ`). *Proper at
every edge:* `f(x) = f(x+s) = a` gives `α, β ≥ θ`, so `√(·) ≥ θ/(1−θ) > λ*`, contradicting the edge inequality, which holds a.s.; so
`P(f(x) = f(x+s)) = 0`. *Continuous in probability:* `f(x) ≠ f(y)` needs `θ` between `m_x(a)` and `m_y(a)` for some `a`, so
`P(f(x) ≠ f(y)) ≤ Σ_a E|m_x(a) − m_y(a)|/(θ₂ − θ₁) ≤ Σ_a E|p̃_{(x,0)}(a) − p̃_{(y,0)}(a)|/(θ₂ − θ₁) → 0` (stationarity in `K`).
*Translation-invariant:* the joint law of finitely many `m_x` is determined by `p̃`'s finite-dimensional laws (each `m_x(a)` is the `L²`
limit of `N⁻¹Σ_{j≤N} p̃_{(x,H_j)}(a)`, `H_j` i.i.d. Haar, independent; error `≤ N^{−1/2}`), and those are `G₀`-invariant; `θ` is independent.
∎ **Sharp:** `ν` uniform on `ℤ/k ∖ 0`, `K = ℤ/k`, has `λ* = 1/(k−1)`, and `K_{k+1} × K_k` is `k`-colourable while `K_{k+1}` is not — the
strict inequality is used exactly at `θ₁ > λ*/(1+λ*)`.

**V1-L7 (thickness is uniform).** If every stable place is `k`-thick (D-THK (c)), then `λ*(K, ν) = sup_w λ*_w < 1/(k−1)`. *Proof.* A
non-trivial character of `K` is `⊗_w ξ_w` with finitely many `ξ_w ≠ 1`, and `ν̂ = ∏_w ν̂_w(ξ_w)`, so `|ν̂| ≤ λ*_{w₀}` for any `w₀` with
`ξ_{w₀} ≠ 1`; hence `λ*(K,ν) = sup_w λ*_w`. By I-WEIL every odd stable `w` of residue field `𝔽_q` has `λ*_w ≤ max(2√q/(q+1), 2/(q+1)) → 0`,
and dyadic stable places are finitely many, so the sup is a maximum over finitely many places, each `< 1/(k−1)`. ∎

**V1-L8 (merging real places).** A CP `k`-colouring `f` of `UD(ℝ²)^{×d}` gives one of `UD(ℝ²)`: `x ↦ f(x, …, x)`. *Proof.* The diagonal
is a continuous group homomorphism `ℝ² → ℝ^{2d}` carrying `S¹` into `(S¹)^d`; invariance, continuity in probability and properness at
each fixed edge all pull back. ∎ (This is I-MERGE's needed direction; the converse is projection. Both are one line; I-MERGE as held is
not needed.)

**Theorem V1-LB (C-LB).** For every totally real `F` outside row 100's exception and every `k ≥ 2` with `N_k(F) = ∅`: if `F²` is
`k`-colourable, then either (A) `UD(ℝ²)` carries a CP `k`-colouring, or (B) some `U`-invariant finite positive `τ` on `R̂` has `τ(E) = 0` and
`∫ Re χ(1) dτ < 0`. **No MR.** *Proof.* V1-L0, L1; V1-L3 gives (B) or disjoint supports; in the second case V1-L5 extends to
`Cay(G_∅, T_∅)`, V1-L6 with `G₀ = L ⊗ ℝ = ℝ^{2d}`, `S₀ = (S¹)^d`, `K = ∏_w O_w`, `ν = ⊗ν_w` (V1-L7 supplies `λ* < 1/(k−1)`) gives a CP
`k`-colouring of `UD(ℝ²)^{×d}`, and V1-L8 gives (A). ∎ **General form (same proof, `N_k(F)` arbitrary):** select only over
`K_thick = ∏_{w ∉ N_k} O_w`; (A) becomes "`UD(ℝ²) × ∏_{w∈N_k(F)} Cay(O_w, T_w)` carries a CP `k`-colouring" (diagonal merge on the real
factors only), which is D-NY's `Y_{F,k}` with the compact pieces in place of `Cay(L_w, T_w)` — equivalent for CP colourability (`Cay(L_w, T_w)`
is a union of `O_w`-cosets, each a copy of `Cay(O_w, T_w)`; restrict one way, independent copies over the countably many cosets the other).
**Given MR(F): (B) is impossible** (`τ = a·Haar` and `∫ χ(1) dHaar = 0`, `χ ↦ χ(1)` being a non-trivial character of the compact group
`R̂` since `1 ≠ 0` in `R`), so `k`-colourability of `F²` gives (A).

**Where each hypothesis is used.** *Totally real:* V1-L6's `G₀ = ℝ^{2d}` with edge set `(S¹)^d`; a complex place would put its norm-one
group, a non-compact `ℂ^×`, in `T_∅`, and neither V1-L6 (needs the compact factor mixing) nor V1-L8 handles it — the claim's scope is
right to exclude it. *Outside the exception:* `R = O′` in V1-L2 (a) and V1-L4 (with `R ≠ O′` the closure of `R` is a proper subgroup of
`∏ O_w` and V1-L6's product structure is lost). *`N_k(F) = ∅`:* V1-L7. *I-RU:* only V1-L3's `τ(E) = 0`. *Rotation invariance:* only V1-L1's
`U`-invariance of `σ` (hence of `τ`, and `∫_{T+A} χ(u) dσ = ∫_{T+A} χ(1) dσ`).

**The controls, run.** (K1) ℚ(√167) at `k = 4`: stable places 23, 43, 59, … (PARI, `data/fs103/fs103-v1/places.gp`; dyadic split,
`dyadic.gp`), level-one `λ*(Γ₂₃) = 0.331695 < 1/3` (`tools/fs103_v1_checks.py`), higher levels `≤ 2/24`: `N₄ = ∅`, so V1-LB with MR and
I-CP57's `χ_CP ≥ 5` gives `χ(ℚ(√167)²) ≥ 5` — row 123's / FS100-167's second route, **reproduced**. (K2) ℚ(√11) at `k = 4`: the dyadic place is
stable inert with level-one piece `U₂ = Cay(𝔽₄, 𝔽₄^×) = K₄`, `λ* = 1/3` exactly; the split 7 gives `Γ₇`, `λ* = 0.5617`; the ramified 11
gives `Γ₁₁`, `0.4764` — `N₄ ≠ ∅`, the chain **stops** at V1-L7/L6 (and at the dyadic factor exactly at the sharpness case `K_4`), and the
general form's (A) — `UD(ℝ²) × ∏_{N₄} Cay(O_w, T_w)` CP-4-colourable — **holds**, by the residue colouring at the dyadic place pulled back
and randomly translated: consistent with `χ(ℚ(√11)²) = 4` (row 73). (Secondary, ℚ(√47): `N₄ ∋` the split 11, `λ* = 0.476`; the general form
leaves `UD(ℝ²) × G₁₁`, whose CP 4-colourings are excluded by the product ratio bound (`m₁ < 1/4` and `G₁₁`'s ratio `< 1/4`) — the SP-Cor
route of rows 121, 123, not re-derived here.) **Wrong-reason lines (stage 1) avoided:** (i) V1-L2 (c); (ii) V1-L4, L5; (iii) I-RU in V1-L3;
(iv) V1-L6 uses full-depth `K̂`, strictness, and stops at `K₄`; (v) no MR in V1-LB.

**Verdict C-LB: TRUE** at `k = 4, 5, 6` (indeed every `k ≥ 2`), as stated and with no MR. [hand; one mind (this derivation), blind to the
two held proofs of T-J39-3; exact checks tools-grade].

## Stage 2b — SAVED (the rest, blind)

**C-CPUP.** *`χ(F²) ≤ χ_CP(ℝ²)` for countable `F`, re-derived in one line:* restrict a CP `k`-colouring of `UD(ℝ²)` to `F²`; each of the
countably many edges is proper a.s., so a.s. all are, and one realisation is a proper colouring of `F²` (no measurability needed — D-CP (b)
asks none). *Then:* every finite subgraph of `UD(ℝ²)` has coordinates in a countable (finitely generated) `F ⊆ ℝ`, so its chromatic number is
`≤ χ_CP(ℝ²)`; de Bruijn–Erdős (I-DBE) gives `χ(ℝ²) ≤ χ_CP(ℝ²)`. `χ(F²) ≤ χ(ℝ²)`: induced subgraph. No Tarski, no MR. **TRUE** [hand, classical].

**C-635-PL.** PARI (`data/fs103/fs103-v1/places.gp`, `dyadic.gp`) and pure Python (`tools/fs103_v1_checks.py`, three plants, each firing for
its own reason: `--plant-d` at "= 7 mod 8", `--plant-sign` at the first-stable list and at ℚ(√167)'s control, `--plant-spec` at the spectrum
controls): 635087 is prime, `≡ 7 (mod 8)`, `3d` not a square; every prime `≡ 3 (mod 4)` below 103 is inert; **stable places below 1000**:
the two places above each of 103, 107, 127, 163, 191, 211, 239, 263, 271, 311, 359, 379, 383, 443, 467, 479, 487, 491, 499, 503, 523, 563,
599, 607, 643, 647, 659, 719, 727, 739, 743, 751, 787, 859, 883, 887, 907, 911, 919, 967, 971, 983 (all `e = f = 1`), and the ramified
place above 635087 (`e = 2, f = 1`, residue `𝔽_635087`, `635087 ≡ 3 (mod 4)`: stable). **Dyadic:** one place of `F` above 2 (`e = 2`), two of
`L` above it — split in `L/F` (`ℚ₂(√635087) = ℚ₂(√7) = ℚ₂(i)`), so not stable; the wall is broken; no ramified stable dyadic place, so outside
row 100's exception and `R = O′`. Control ℚ(√167): first stable 23, 43, 59; dyadic split. Non-split control: ℚ(√3), ℚ(√11) (one prime of `L`
above 2, `f` doubled: stable inert). **TRUE** [tools exact, two code bases].

**C-635-THK.** Stable places: residue fields `𝔽_q`, `q ≥ 103` (split `p ≡ 3 (mod 4)` from 103, and `q = 635087`); level one `Γ_q`,
`λ* ≤ 2√q/(q+1) ≤ 2√103/104 = 0.19517` (exact at 103: `0.192617`; 107: `0.187135`; 127: `0.171642`); new levels `≤ 2/(q+1) ≤ 0.0193`
(I-WEIL, "any base ramification", covering the ramified place's `e = 2` tower); no dyadic stable place. So `sup_v λ*_v ≤ 0.1952 < 1/5`,
`N₄ = N₅ = N₆ = ∅`. **TRUE** [hand + tools exact; I-WEIL by statement].

**C-635-F1.** Given MR(ℚ(√635087)) (held for this field by row 120: real, `R = O′`): by C-LB at `k = 4` (`N₄ = ∅`) with MR, `F²`
4-colourable would give `χ_CP(ℝ²) ≤ 4`, contradicting I-CP57; so `χ(F²) ≥ 5`. Let `k := χ(F²) ∈ {5, 6, 7}` (`≤ 7`: C-CPUP and I-CP57's
upper bound). `N_k = ∅`, so C-LB with MR gives `χ_CP(ℝ²) ≤ k`; C-CPUP gives `k ≤ χ(ℝ²) ≤ χ_CP(ℝ²)`. Hence
**`χ(ℚ(√635087)²) = χ(ℝ²) = χ_CP(ℝ²)`**. **TRUE** given MR [hand; one mind for the assembly, on V1-LB].

**C-635-TF.** A unit triangle `0, a, b` in `F² = L` forces `b/a ∈ {ζ₆, ζ₆⁻¹} ⊂ L`, so `√−3 ∈ L = F(i)`, so `(−3)(−1) = 3` is a square in `F`
(`F` real): `√3 ∈ ℚ(√635087)` is false (`3·635087` not a square). With C-635-F1 and `χ(ℝ²) ≥ 6`: `χ(F²) ≥ 6`, and de Bruijn–Erdős gives a
finite subgraph of `F²`'s unit-distance graph — triangle-free as a subgraph — with chromatic number `≥ 6`. **TRUE** (a consequence of
C-635-F1) [hand].

**C-dG-F1 (assembly), with C-dG-PL, C-131, C-dG-THK re-checked.** PARI, `F_dG` of degree 16, signature `[16, 0]`: stable places below 600
are the 16 places above 131 and the 16 above 479 (all `f = 1`), nothing else (also by Legendre symbols: unramified `p ≡ 3 (mod 4)` stable
iff 3, 5, 7, 11 are all squares mod `p`; the ramified 3, 7, 11 have residue field `𝔽_{p²}` — 5, 3, 7 respectively non-residues — and 5 is
`≡ 1 (mod 4)`; the dyadic places are split because `√7 ∈ F_dG` and `−7` is a square in `ℚ₂`). **C-131:** level-one
`max|λ|/(q+1) = 0.168047` at 131 (a positive eigenvalue; `λ_min/d = −0.159911`), beside Weil's `0.173417`, `< 1/5`. **C-dG-THK:** every
stable place has `q ≥ 131` (residue degrees in a multiquadratic field are 1 or 2, so `q = p`), level one `≤ 0.1734`, new levels
`≤ 2/132`: `N₆ = ∅` [hand + tools exact; bound 600]. **Assembly:** `χ(F_dG²) ≥ 5` (I-DG5, no MR); for `k = χ(F_dG²) ∈ {5, 6, 7}`, C-LB with
MR(`F_dG`) and C-CPUP give `χ(ℝ²) = χ_CP(ℝ²) = χ(F_dG²)`; in R1's form, `χ(F_dG²) ≤ k ⟺ χ_CP(ℝ²) ≤ k` for `k = 5, 6`. **TRUE given
MR(F_dG)** [hand; the assembly one mind]. **C-MR16: unreached** (budget; the brief makes it optional).

**C-F1-GEN.** *The stub's text* ("a real field `F` with no non-thick stable place"): **MISSTATED**, three ways. (1) "Real field" admits
complex places, where `T_∅` has a non-compact archimedean factor V1-LB does not treat. (2) "Thick" names no `k`: with 5-thick only (D-THK
(a)), the chain stops at `χ(F²) = 6` — `χ(F²) ≥ 5` and `χ(F²) ≤ 5 ⟹ χ_CP ≤ 5` and `χ(F²) = 7 ⟹ χ_CP = 7` all go through, but
`χ(F²) = 6` gives only `χ_CP ≥ 6`, so `χ_CP = 7 > χ(F²) = 6` is not excluded. The needed condition is `N₆(F) = ∅`. (3) Row 100's exception
needs no clause in practice — its ramified stable dyadic place has level-one edge set `≡ 1 (mod 𝔭)`, so `ν̂(ξ) = ξ(1) = ±1` and `λ* = 1`: it is
never thick — but the proof uses `R = O′`, which is where the exclusion lives. *The proposed scope* (totally real, outside the exception,
`N₆(F) = ∅`, given MR(F)): **TRUE**, by C-635-F1's assembly verbatim (`N₆ = ∅ ⟹ N₄ = N₅ = ∅`). "Given T-J39-3" is not needed: V1-LB replaces
it. Corollary worth recording: **given MR, every totally real `F` outside the exception with `N₆(F) = ∅` has the same `χ(F²)`, namely
`χ_CP(ℝ²)`** (e.g. ℚ(√635087) and `F_dG` have equal chromatic numbers).

**C-S.** (a) **TRUE.** For S as D-S states it (all subfields of ℝ) it is immediate: ℝ is a subfield. Its content is the number-field form:
S_nf ⟹ `χ(ℝ²) ≠ 6` given MR at one `N₆ = ∅` field — `F_dG` by C-dG-F1 as R1 says, or more cheaply ℚ(√635087) (MR at degree 2). (b) **TRUE**
for S_nf over totally real fields, given MR at each (row 120 covers all outside the exception; exception fields have `χ ≤ 2`), reading "drops
to six" as `χ(F²) = 6` and "a non-6-thick place" as `N₆(F) ≠ ∅`: if `χ_CP = 6`, ℚ(√635087) is six; if `χ_CP = 5`, every `F` has `χ(F²) ≤ 5`
(C-CPUP); if `χ_CP = 7`, every `N₆ = ∅` field is seven (C-F1-GEN's scope), so six can occur only with `N₆(F) ≠ ∅`. For such `F`, V1-LB's
general form with MR and the restriction direction give `F²` `j`-colourable ⟺ `UD(ℝ²) × ∏_{N_j(F)} Cay(O_w, T_w)` CP-`j`-colourable (`j = 5,
6`). (c) **MISSTATED as "a finite family".** Finite: the residue fields of non-6-thick stable places — odd `q ∈ {3, 7, 11, 19, 23, 27, 31, 43,
47, 59, 67, 71, 79, 83}` (level-one `λ* ≥ 1/5`; exact here for the primes, `tools/fs103_v1_checks.py`; 27 and the dyadic `U_Q`, `Q ≤ 64`, by
Hoffman from G56's floors, `k`-colourable ⟹ `λ* ≥ 1/(k−1)`; `U₁₂₈` not computed), with `q ≥ 99` 6-thick by Weil. **Not finite:** the local
graphs `Cay(O_w, T_w)` — each `q` is the residue field of infinitely many local fields `F_v` (e.g. `ℚ_p(p^{1/e})`, `e ≥ 1`, all with
`i ∉ F_v`), each realised as a completion of a totally real field, and different `[F_v : ℚ_p]` give non-isomorphic groups `O_w ≅ ℤ_p^{2[F_v:ℚ_p]}`;
products of any finite subset occur. Finiteness would need an equivalence, for CP colourability, between towers with one residue field — the
inclusion `ℤ_p[i] ⊂ O_w` gives a homomorphism one way only. (Note on the window: 71 is non-6-thick through its **positive** eigenvalue
`0.2204` although its `λ_min/d = −0.1968` refuses six by Hoffman — mixing is two-sided, Hoffman one-sided.) (d) *Missing for all subfields of
ℝ:* algebraic subfields of infinite degree follow from S_nf (a supremum of values `≠ 6` in `{1,…,7}` is `≠ 6`, by de Bruijn–Erdős); fields of
positive transcendence degree need G63's Q-const (or an S for finitely generated fields: Tarski specialisation puts each finite subgraph into
some number field's plane, which bounds `χ(E²)` by a maximum but does not exclude 6). *Complex places:* V1-LB's archimedean factor becomes the
non-compact norm-one group at each complex place; neither the selection nor the merge covers it, and MR's complex-place case has no exercised
instance (row 123).

**C-FMT.** (a) **TRUE** [classical]: a process continuous in probability on a separable metric index set has a jointly measurable
modification. (b) **TRUE** [hand]: with such a version, Fubini gives `E ∫∫ 1[c(x) = c(x + w)] dx dw = 0`, so a.s. a realisation is a
Lebesgue-measurable colouring proper at almost every edge: `χ_m⁰ ≤ χ_CP`. (c) **GAP** at the Følner step: from a measurable a.e.-proper `f`,
the random translates `f(· + Z_n)`, `Z_n` uniform on growing boxes, have limit laws that are translation-invariant and a.e.-proper, but
`P(f(x+Z) ≠ f(y+Z)) = |{z ∈ B_n : f(z+x) ≠ f(z+y)}|/|B_n|` need not tend to 0 uniformly in `n` as `y → x` (the local `L¹` modulus of `f`
may degrade at infinity), so the limit need not be continuous in probability; nothing here forces it. Not rescued by MR (it would need
`χ(ℝ²) ≤ χ_m⁰`, itself open). (d) **GAP** at colouring a null set: replacing each class by its Lebesgue density points gives disjoint classes
avoiding distance 1 **everywhere** (if `x, x + w` are density points of `A`, then `{(y, w′) : y, y + w′ ∈ A}` has positive measure in
`ℝ² × S¹` — proved here), covering all but a null set `N`; colouring `N` properly against its neighbours' colours is a list-colouring
problem nothing here solves. (e) `χ(ℝ²) ≤ χ_m ≤ χ_B ≤ 7` (half-open hexagons are Borel), `χ_m⁰ ≤ χ_m`, `χ_m⁰ ≥ 5` by the edge-null Hoffman
bound (I-CP57's lower half applies to a.e.-proper colourings); `χ_B` against `χ_CP`: the same Følner GAP as (c).

**C-CPM.** Without MR: **GAP** — the same Følner step as C-FMT (c); C-FMT's parts give `χ_m⁰ ≤ χ_CP`, the opposite direction, so it does
**not** follow from them. Given MR(ℚ(√635087)) (held, row 120): **TRUE through C-635-F1 only**, `χ_CP = χ(ℝ²) ≤ χ_m`.

### Would-have-searched-here log

- None. Every computation was an exact spectrum or a PARI place list of seconds; no colouring, independent-set or quotient search was
  contemplated (the claims are derivational).


## Stage 3 — SAVED (the write-up; committed before anything fenced was opened)

| claim | verdict | grade · minds (mine) | the step, if not TRUE |
|---|---|---|---|
| **C-LB** | **TRUE**, `k = 4, 5, 6` (every `k ≥ 2`), **with no MR** | [hand] · 1 blind (V1-LB); inputs I-RU, I-C′, I-WEIL by statement | — |
| C-F1-GEN, stub's text | **MISSTATED** | — | "real" must be "totally real" (complex places untreated); "no non-thick place" must be `N₆(F) = ∅` (with 5-thick only, `χ(F²) = 6 < χ_CP = 7` is not excluded) |
| C-F1-GEN, proposed scope | **TRUE** given MR(F); T-J39-3 not needed | [hand] · 1 | — |
| C-CPUP | **TRUE** | [hand, classical] · 1 | — |
| C-635-PL | **TRUE** (lists above, bound 1000) | [tools exact, two code bases] | — |
| C-635-THK | **TRUE**, `sup λ* ≤ 0.1952` | [hand + tools; I-WEIL] · 1 | — |
| C-635-F1 | **TRUE** given MR(ℚ(√635087)) | [hand] · 1 | — |
| C-635-TF | **TRUE** given C-635-F1 | [hand] · 1 | — |
| C-dG-PL, C-131, C-dG-THK | **TRUE** (bound 600; `λ*(Γ₁₃₁) = 0.168047`) | [tools exact] · 1 (other verifier's by assignment; checked anyway) | — |
| C-dG-F1 (assembly) | **TRUE** given MR(`F_dG`) and the place list | [hand] · 1 | — |
| C-MR16 | **unreached** | — | budget (optional per brief) |
| C-S (a) | **TRUE** (trivial for S; the S_nf form via either instance) | [hand] · 1 | — |
| C-S (b) | **TRUE** for S_nf over totally real fields, given MR, "drops to six" = `χ(F²) = 6` | [hand] · 1 | — |
| C-S (c) | **MISSTATED** | [hand + tools] · 1 | finite in residue fields (14 odd `q` + dyadic `Q ≤ 64`, `U₁₂₈` unchecked), infinite in local planes (`[F_v:ℚ_p]` unbounded) |
| C-S (d) | answered: Q-const (G63) for transcendental subfields; complex places untreated by V1-LB and MR unexercised there | [hand] · 1 | — |
| C-FMT (a), (b) | **TRUE** | [classical; hand] · 1 | — |
| C-FMT (c) | **GAP** | — | the Følner limit of random translates need not be continuous in probability |
| C-FMT (d) | **GAP** | — | colouring the null set of non-density points (the rest proved: density-point classes avoid distance 1 everywhere) |
| C-FMT (e) | relations stated: `χ ≤ χ_m ≤ χ_B ≤ 7`, `χ_m⁰ ≤ χ_m`, `χ_m⁰ ≥ 5`; `χ_B` vs `χ_CP` the (c) GAP | [hand] · 1 | — |
| C-CPM | **GAP** without MR (the Følner step; not a consequence of C-FMT); **TRUE** through C-635-F1 given MR | [hand] · 1 | the Følner step |

**What the owner should know first.** C-LB holds without MR and without T-J39-3's proofs, by a route whose one non-routine step is V1-L2 +
V1-L3: condition the colouring on its `T + A` factor; the positive-definite pairing at an edge splits into a factor part `≥ −1/(k−1)` and an
`E`-null part, so either the `E`-null part is an SP witness or the factor's conditional colour laws have disjoint supports at every edge — a
"fractional colouring" that extends to the adelic completion and is then collapsed onto the real factor by a mixing selection. So, given MR
(row 120), **χ(ℝ²) = χ_CP(ℝ²) = χ(ℚ(√635087)²) = χ(F_dG²)** at my one-mind [hand] grade.

**Corrections owed (proposed; the close writes them).** (1) The stub's C-F1-GEN text: "totally real" and "`N₆(F) = ∅`". (2) C-S (c): "a
finite family" → "finitely many residue fields; infinitely many local planes". (3) I-MERGE's needed direction is the diagonal homomorphism
(one line) — if a held proof works harder, the row can say so. (4) My stage-1 control misread row 110's "59 has ratio 0.199119854095" as
`λ*`; it is the Hoffman ratio `λ*/(1+λ*)` (`λ*(Γ₅₉) = 0.248626`, so **59 is not 6-thick**) — a reading slip of mine, fixed in the tool before
any verdict used it.

## Stage 4 — SAVED (the sealed half scored; the fenced proofs read)

*Opened after stage 3's commit `d1864bd8`: `data/fs103/claims-sealed.md` (with the owner's CTL-FRAC), the wanted-poster §3 notation and §3.2,
`plans/FS100-BC-verification.md` §2.1–§2.2. Nothing else fenced was opened.*

### 4.1 The sealed sub-claims

| sub-claim | score |
|---|---|
| I-MX (Borel/measurable, one factor) | not used; V1-L6 is its CP form over a countable product, with fractional input |
| **C-THKDEL** | **agree** — V1-L6 (+ V1-L7 for `λ*(⊗ν_v) = sup_v λ*(ν_v)`, with its line). Mine is stronger in one respect: the input may be a `Δ_k`-valued disjoint-support process, not only a colouring |
| **C-EXTk** | **agree**, by a different object: I extend the conditional-law process `p` (V1-L5), never a colouring; with I-SEL or with `c′ = min supp p` the claim's form follows the same way |
| **C-APX** (a), (b) | **agree**; (a) by Hilbert 90 for the norm-one torus of the quadratic `L/F` (the list's wrong-reason line — "weak approximation for tori in general" — avoided by naming it), (b) V1-L2 (a) + V1-L4 |
| **C-MERGE-n** | **agree** — V1-L8's diagonal, converse by projection |

### 4.2 The wrong-reason lines (sealed §B) against my derivation

C-LB (i) no T-J39 cited, nothing fenced read before stage 3 — avoided; (ii) deletion by `λ* < 1/(k−1)`, never by independence ratio —
avoided; (iii) two-sided `sup|ν̂|` — avoided, and the tool shows where it matters (71: `λ_min/d = −0.1968`, `λ* = 0.2204`); (iv) one global
`θ` from V1-L7's maximum — avoided; (v) jointly measurable modification of `p̃` produced (V1-L5) — avoided; (vi) properness at each **fixed**
edge from the a.s. edge inequality at that edge — avoided; (vii) CTL-ABS: my chain stops there (below) — avoided; (viii) the fibre masses'
law fixed from finite-dimensional laws by `L²` limits of i.i.d. Haar averages, written in V1-L6 — avoided. C-F1-GEN: never applied at `k = 7`
(if `χ(F²) = 7` nothing is needed); needs MR and thickness; complex places excluded — avoided. C-635-PL: "2 ramified in `F`, split in `L/F`" as
the list says — avoided. C-635-THK, C-dG-PL: ramified and dyadic places included; residue degrees read in `F_dG` itself — avoided. C-S: S
beyond number fields names Q-const; types not counted by residue field — avoided; (c)'s registered expectation ("not finite at full depth;
finite at most up to level-one type") — **agree**, and my stage-3 verdict says the same.

### 4.3 The controls

CTL-167-4 **agree** (my K1). CTL-dG4 **agree** (`q ≥ 131`, `λ* ≤ 0.1734 < 1/3`; gives `≥ 5`, matching I-DG5). CTL-K-4 **agree** (my K2 is the same
boundary on ℚ(√11): the dyadic `K₄`, `λ* = 1/3` exactly). CTL-K7-6 **agree** (`λ*(Γ₈₃) = 0.2108 ≥ 1/5`, stops at `k = 6`; at `k = 5` goes
through). CTL-K5-5 **agree** (`λ*(Γ₁₁) = 0.4764`). CTL-167-5 **agree** (`N₅` = the places above 23 (`0.3317`) and 43 (`0.2719`); 59 is
`0.2486 < 1/4`, just). CTL-Q2 **agree** (the exception; `λ* = 1`, as stage 2b's C-F1-GEN (3) found). **CTL-ABS** — both values checked:
`χ = 2` (parity of `a + b` on `ℤ + ℤ√2`, extended by cosets); `χ_CP = 3` (upper: `⌊x⌋ mod 3` randomly translated — `⌊x + √2⌋ − ⌊x⌋ ∈ {1, 2}`;
lower: a CP 2-colouring is a.s. invariant under `2ℤ + 2√2ℤ`, dense, so by continuity in probability constant in law along every
translation, contradicting properness at 1). My chain stops at V1-L7: the closure of the finite edge set in the profinite factor is finite,
`ν` uniform on four points, and the character `(−1)^{a+b}` has `|ν̂| = 1`.

**CTL-FRAC (the owner's addition).** My derivation runs **one colour class at a time through V1-L3 and V1-L5** — for one invariant random
independent set of density `δ`, the `E`-null part pairs to `−E[p₀p_u] ≤ 0`, so either an SP witness or a `[0,1]`-valued conditional density
`p` with `p_x p_{x+u} = 0` on edges, which extends. **The second class enters at V1-L6's covering step**: "some colour has fibre mass
`≥ 1/k > θ`" holds because the `k` fibre masses sum to 1. With one class the selection returns only `{x : m_x > θ}`, independent, of density
`≥ (δ − θ)/(1 − θ)` by Markov — not `δ`. So the chain does **not** transfer `α₁(F_dG²) ≤ m₁(ℝ²)`, does not refute the conjectures of
`[AmbrusEtAl2023]` §4 and `[MatolcsiEtAl2025]`, and integrality (the partition into `k` classes) carries F1 at exactly that step.

### 4.4 The fenced proofs of T-J39-3, against mine — divergences

| | wanted-poster §3.2 (J39) | BC §2.1–2.2 (J48) | mine (V1) |
|---|---|---|---|
| dichotomy | SI at `k`, `S = ∅`, R-U | L1–L2, R-U | V1-L3 — **same** |
| object carried to the completion | honest `c′ = min supp` of the conditional law | `c′`, as J39 | the conditional-law **process** `p` itself (fractional) |
| extension | Mackey's point realisation | limits in probability (N2 gives `c′` continuity in probability) | `L²` limits of `p` + Doob–Cohn modification |
| completion's compact part | "`R̂_prof = ∏_{stable w} O_{L_w}`", stated for every totally real `F` | Lemma C, C′: `Ĝ` open of finite index in `Ĝ⁺`, independent copies on its cosets — covers row 100's exception | `R = O′` assumed (the claim's scope); via `R/nR ≅ ∏ O_w/n` |
| selection | random threshold, "fibrewise" | L5: random threshold, Doob–Cohn version | V1-L6: random threshold, fractional input, **and** the `L²`-averaging step fixing the fibre masses' law |
| thickness | max over thick places | L6 (Weil + two-point bound) | V1-L7 (I-WEIL by statement) |
| merge | J21-SL, random form | L4 diagonal | V1-L8 diagonal |

**Divergences of route:** (1) I never select at the factor level; the fractional process goes through extension and selection intact, so no
point realisation and no continuity-in-probability lemma for `c′` is needed. (2) Both held proofs assert the stationarity of the fibre masses
"because `c` is" — the sealed list's (viii); mine writes the step. It is routine and true; recorded as a completeness note, not a gap in
truth. (3) The poster's `R̂_prof = ∏_{stable} O_{L_w}` is true only for `R = O′`; its "every totally real `F`" therefore has a small gap at
row 100's exception, which BC's Lemma C′ closes (and exception fields have `χ ≤ 2`, so nothing downstream moves). My stage-2a remark that
the exception is *needed* is over-cautious: BC shows it is not for C-LB; it is needed for MR (row 120). **Divergences of truth: none** — all
three derivations make C-LB TRUE at every `k ≥ 2`, with no MR.

**Count of minds for C-LB:** three (J39; J48 blind; V1 blind, a different carried object). For the assemblies C-635-F1 and C-dG-F1: mine,
one mind here (the other verifier's may make two).

### 4.5 Proposed `BIBLIOGRAPHY.md` rows

The measurable-modification theorem I cite (Doob 1953; D. L. Cohn, "Measurable choice of limit points and the existence of separable and
measurable processes", Z. Wahrsch. verw. Gebiete 22 (1972)) — BC cites "Doob–Cohn" too; `grep -i cohn BIBLIOGRAPHY.md` finds no entry: the close
should add one row, marked "cited by statement, unread".
