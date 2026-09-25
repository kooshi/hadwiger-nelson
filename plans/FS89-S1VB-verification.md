# FS-89 Stage 1 — the blind verifier's record, second verifier (verifier I, "V-B")

*De Bruijn (Opus 5.5), acting as the blind verifier of the derivation agent's seven claims, 2026-09-25. Brief:
`data/fs89/briefs/S1-VB-verifier-brief.md` (commit a81918cf). Read before this record was opened: the brief; `CLAUDE.md`,
`WORKFLOW.md`, `DEBRUIJN.md` (loaded); the plan `plans/FS89-rational-band-rigidity.md` §0.1–§0.3, §PA.1–§PA.2 and §IQ only; Stage 0 in
full (`plans/FS89-S0A-gluing-verification.md`, `plans/FS89-S0B-band-set.md`); verifier H's record in full
(`plans/FS89-S1V-verification.md`). Not opened: `plans/FS89-S1D-derivation.md`, `data/fs89/s1d/`, `tools/fs89_s1d_*`, the derivation
agent's brief and scratch, its commits' diffs, the close inventory, `data/fs89/briefs/S1-VB-lemma-statements.md`.*

*Objects and notation are the plan's §0.1 and verifier H's: `R_S = ℤ[i][1/p : p ∈ S]`, `U_S = ⟨i⟩ × ⟨w_p⟩`, `w_p = π_p/π̄_p`;
`R̂_S ≅ (ℂ × ∏_{v|S} K_v)/Δ(R_S)`, a point written `(e; (b_v)_v)`; `T`, `A`, `λ_d`; leaves `τ + D(r_τ)` (V6, rank `r`). Throughout,
`R₆₅ := R_{5,13}`.*

## C0 — predictions (a probability per claim, written before any derivation was written down)

Honesty note (the predecessors' form): written after reading the fenced sources and after a mental pass over the claims of perhaps
twenty minutes, nothing written. That pass already contained two arguments (below, §B1.2 and §B1.3), so the numbers for the
implications are posteriors of it; the numbers for the three substantive claims are priors.

| claim | predicted verdict | probability TRUE |
|---|---|---|
| 1. D1-T1 (`MS₄(S)`, every `|S| ≥ 2`) | TRUE, but I expect my own route to stall at the isometric direction and to return GAP | 0.45 |
| 2. D1-T2 (`RS₄({5, 13})`) | as claim 1 at `S = {5, 13}` (the mental pass suggested the two are equivalent there) | 0.40 |
| 3. D1-C2 (finitely many torsion characters in `Θ₄(R₆₅)`), standalone | TRUE iff D1-T2 is, roughly; the finiteness looks like a Furstenberg-type (×a×b in finite quotients) statement, not an elementary one | 0.40 |
| 3′. D1-T2 ⟹ D1-C2 | TRUE (a non-effective expansion argument) | 0.85 |
| 4. "D1-T2 and D1-C2, hence D2-T1" (the implication) | TRUE (S0A's gluing with base `R₆₅`) | 0.92 |
| 4′. D2-T1 (RQ₄) itself | rests on claim 2 | 0.38 |
| 5. D5-T1 (`RS₅({5, 13})`) | the five-band set is larger (more discs, larger lenses); weaker odds | 0.30 |
| 6. D5-C2, standalone | as claim 5 | 0.30 |
| 7. "D5-T1 and D5-C2, hence D5-T2" (the implication) | TRUE, band-free gluing | 0.92 |
| 7′. D5-T2 (RQ₅) itself | rests on claim 5 | 0.28 |

Where I expect the weight: the implications are soft (gluing, compactness, expansion) and should hold at both bands. The substance is
the rank-two rigidity itself, which carries the plan's isometric-direction difficulty; I expect to find an honest reduction and a
named missing step, not a proof.

## B1 — blind verdicts

### B1.0 Four lemmas every verdict below uses (hand; band-free except SW)

*Conventions.* `R̂_S = (ℂ × ∏_{v|S} K_v)/Δ(R_S)`, `(e; b)` ↦ `x ↦ Re(ē x) − Σ_v ψ_v(b_v x)`, `ψ_v` the local component of the standard
additive character of the adeles of `ℚ(i)` (trivial on `O_v`, non-trivial on `π_v^{−1}O_v`; every `v | S` is split and unramified).
`Δ(R_S)` is discrete, so a neighbourhood of 0 in the product maps homeomorphically onto one in `R̂_S`. `A` is the image of
`ℂ × {0}`. For `c ∈ K_v` write `c̄` for the image of `(0; c at v, 0 elsewhere)`: a **pure `v`-adic element**; `c̄ ≠ 0` for `c ≠ 0`
(a global element vanishing at ∞ is 0). `u ∈ U_S` acts by `x ↦ x∘u`, on data by `e ↦ ū e`, `b_v ↦ u b_v`; so `u·c̄ = (u_v c)‾`. For
`v | p`, `|w_p|_v = p` at `v = π̄_p`, `1/p` at `π_p`, and `|w_{p′}|_v = 1` for `p′ ≠ p`; every `|u|_∞ = 1`.

- **Lemma E (expansion).** Let `Y ⊆ R̂_S` be closed and `U_S`-invariant, `U₀ ⊆ U_S` of finite index, and `x_n, y_n ∈ Y` with
  `δ_n := y_n − x_n → 0` and `δ_n ∉ A`. Then, along a subsequence, there are `h_n ∈ U₀`, a place `v | S` and `c ∈ K_v^×` with
  `h_n x_n → x*` and `h_n y_n → x* + c̄`. *Proof.* Take representatives `δ̃_n → 0` in the product. `δ_n ∉ A` means some `v`-component
  is non-zero; fix one `v` along a subsequence, say `v = π̄_p` (for `π_p` use `w_p^{−1}`). With `w_p^a ∈ U₀`, let `k_n` be least with
  `|w_p^{a k_n} δ̃_{n,v}|_v ≥ p^{−a}`; `k_n → ∞`. `h_n := w_p^{a k_n}` keeps the archimedean and the other primes' components at their
  (vanishing) sizes, contracts `π_p`, and puts the `v`-component in the compact annulus `[p^{−a}, 1]`. Pass to a subsequence where it
  and `h_n x_n` converge. ∎
- **Lemma SW (the sweep).** Let `k ∈ {4, 5}`, `v | p ∈ S`, `x ∈ R̂_S`, `c₀ ∈ K_v`, `s ∈ ℤ`. Not every `x + c̄` with `c ∈ c₀ + π_v^s O_v`
  lies in `Θ_k(R_S)`. *Proof.* Take `u = w_p^{±t} ∈ U_S` with `π_v^s u O_v = π_v^{−1}O_v`. Then `(x + c̄)(u) = (x + c̄₀)(u) − ψ_v(b u)`,
  `b ∈ π_v^s O_v`, and `ψ_v` restricted to `π_v^{−1}O_v/O_v ≅ 𝔽_p` is a non-trivial character: the values fill a coset of `(1/p)ℤ/ℤ`,
  step `≤ 1/5`, which meets the open arc `(−1/k, 1/k)` of length `2/k ≥ 2/5`. ∎
- **Lemma JC (joint closure).** For `v | p`, `p′ ≠ p` in `S`, `b ≥ 1`: the closure of `{(w̄_{p′}^{bn}, w_{p′}^{bn}|_v) : n ∈ ℤ}` in
  `S¹ × O_v^×` is `S¹ × W₀`, with `W₀ ⊇ 1 + p^jℤ_p` for some `j`. *Proof.* A character `(z, y) ↦ z^a χ(y)` (`χ` of finite order)
  trivial on the set makes `w̄_{p′}^{ab}` a root of unity, so `a = 0`, and then `χ` is trivial on `W₀ :=` the closure of `⟨w_{p′}^b⟩`.
  `W₀` is an infinite closed subgroup of `ℤ_p^× ≅ μ_{p−1} × ℤ_p`, hence open. ∎
- **Lemma L (minimal sets inside `T + A`).** For `x = τ + λ_d ∈ Θ_k(R_S)`, `S ≠ ∅`, the orbit closure of `x` is the finite orbit `U_Sτ`
  (`d = 0`) or `⋃_{τ′ ∈ U_Sτ} τ′ + {λ_{d′} : |d′| = |d|}` (`d ≠ 0`); each is minimal. *Proof.* `Stab(τ)` has finite index and contains
  a power of some `w_p`, whose conjugate is not a root of unity, so it rotates `d` densely. ∎ So the minimal subsets of
  `Θ_k(R_S) ∩ (T + A)` are exactly D1-T1's two kinds, with `|d| ≤ r_τ` by V6's leaf formula.

### B1.1 Two theorems that reduce the claims to one question

**Theorem VB1 (a band point whose orbit closure meets `T + A` is in `T + A`; `|S| ≥ 2`, `k ∈ {4, 5}`).** Let `y ∈ Θ_k(R_S)` and suppose
the closure `Ō(y)` of its orbit contains some `x = τ₀ + λ_d ∈ T + A`. Then `y ∈ T + A`. [hand]

*Proof.* `U₀ := Stab(τ₀)`. Take `g_n y → x`, `δ_n := g_n y − x`. If `δ_n ∈ A` for some `n`, then `g_n y ∈ τ₀ + A` and `y ∈ T + A`
(`T + A` is invariant). Otherwise Lemma E (with `x_n = x`) gives `h_n ∈ U₀`, `v | p` and `c ∈ K_v^×` with `h_n x → x′ := τ₀ + λ_{d′}`
and `x′ + c̄ ∈ Ō(y) ⊆ Θ_k`. Pick `p′ ∈ S ∖ {p}` (here `|S| ≥ 2` is used) and `b` with `w_{p′}^b ∈ U₀`. For `t ∈ W₀` (Lemma JC) take
`n_j` with `w̄_{p′}^{bn_j} → 1` and `w_{p′}^{bn_j} → t` at `v`; then `w_{p′}^{bn_j}(x′ + c̄) = τ₀ + λ_{…d′} + (w_{p′}^{bn_j}c)‾ →
x′ + (tc)‾`. So `x′ + (tc)‾ ∈ Θ_k` for every `t ∈ W₀ ⊇ 1 + p^jℤ_p`, i.e. for every `c′` in the ball `c + c p^j O_v`. Lemma SW
refutes this. ∎

**Corollary VB2 (`MS_k(S) ⟺ RS_k(S)` for `|S| ≥ 2`).** `RS_k(S)` holds iff every minimal subset of `Θ_k(R_S)` meets `T + A`, iff
`MS_k(S)` holds in D1-T1's form. [hand] *Proof.* ⟸: every orbit closure contains a minimal set; VB1. ⟹: a minimal set of
`Θ_k ⊆ T + A` is described by Lemma L. ∎

**Theorem VB3 (finiteness follows from rigidity; any nonempty `S`).** If `RS_k(S)` holds then `Θ_k(R_S) ∩ T` is finite, and so
`Θ_k(R_S)` is the finite union of the leaf discs `τ + D(r_τ)`. [hand] *Proof.* Distinct `τ_n ∈ Θ_k ∩ T` accumulate at some
`φ ∈ Θ_k ⊆ T + A`, `φ = τ₀ + λ_d`. `τ_n − φ ∈ A` would make `τ_n − τ₀ ∈ T ∩ A = 0` (`R_S` is `p`-divisible), so for large `n`
Lemma E applies and gives `z = τ₀ + λ_{d′} + c̄ ∈ Θ_k`, `c ∈ K_v^×`. `z ∉ T + A`: a point of `T + A` has data `(e; q, …, q)` with one
`q ∈ ℚ(i)` up to the diagonal; `z`'s data agree with `τ₀`'s rational `q₀` at every place but `v`, so `q = q₀` there and `c = 0`.
This contradicts `RS_k(S)`. The second clause is V6's leaf formula. ∎ (Non-effective: it gives no bound on the orders.)

**Theorem VB4 (the layering; any finite nonempty `S`).** If `RS_k(S)` holds and the torsion characters in `Θ_k(R_S)` have bounded
order `N`, then `RS_k(S′)` holds for every set `S′ ⊇ S` of split primes, finite or not; in particular RQ_k. By VB3 the second
hypothesis is automatic. [hand] *Proof.* S0A's G1 with the base `R_S` in place of `ℤ[U_ℚ]`: for `θ ∈ Θ_k(R_{S′})` and `u ∈ U_{S′}`,
`y ↦ θ(uy)` is a band character of `R_S` (`uU_S ⊆ U_{S′}`), so it is `τ_u + λ_{e_u}` with `τ_u` band (V6), hence `Nτ_u = 0`. With
`p ∈ S`, `1/p^k ∈ R_S`, and every `x ∈ R_{S′}` a signed sum of unit vectors, G1's steps 2–6 apply verbatim with `p` for 5: `Nθ` has
a real additive lift, so `θ ∈ T_N + A`. ∎

**What this does to the seven claims.** At `S = {5, 13}` the whole list reduces to one statement, `RS₄({5, 13})` (and `RS₅({5, 13})` at
five colours): D1-T1 at `{5, 13}` is equivalent to it (VB2), D1-C2 follows from it (VB3), and D2-T1 follows from it (VB4). So
**everything rests on D1-T2 (resp. D5-T1)**. My route to that statement follows.
