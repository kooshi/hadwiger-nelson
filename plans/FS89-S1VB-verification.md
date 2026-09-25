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

### B1.2 My route to `RS_k(S)`, `|S| ≥ 2`, and where it stalls

Let `M ⊆ Θ_k(R_S)` be minimal. By VB2 it is enough to show `M ⊆ T + A`. Two cases, exhaustive: **(A)** some neighbourhood `N` of 0 has
`x, y ∈ M, y − x ∈ N ⟹ y − x ∈ A`; **(B)** there are `x_n, y_n ∈ M` with `y_n − x_n → 0` and `y_n − x_n ∉ A`.

**Theorem VB5 (case A).** In case (A), `M ⊆ T + A`. [hand] *Proof.* Cover `M` by finitely many balls about `z_1, …, z_m ∈ M` of
radius small against `N`: then `M ⊆ ⋃_j (z_j + A)`. `U_S` maps cosets of `A` to cosets of `A` (`u·λ_e = λ_{ūe}`), so it permutes the
finitely many cosets meeting `M`, and a finite-index `U′` fixes each: `z∘u − z ∈ A` for `u ∈ U′`. Take `u ∈ U′` of infinite order. In
data, `z∘u − z` has `v`-components `(u − 1)b_v`, so `z∘u − z ∈ A` means `(u − 1)b_v = r` in every `K_v` for one `r ∈ R_S`; so every
`b_v` is the image of the one rational `q = r/(u − 1)`, and `z = (e; q, …, q) ∈ T + A` (split `q` into a part in `R_S` and a part
integral at `S`). So `M ⊆ ⋃_j (z_j + A) ⊆ T + A`. ∎

**Case (B).** Lemma E (with `Y = M`, `U₀ = U_S`) gives `x₀ ∈ M`, `v | p`, `c₀ ∈ K_v^×` with `x₀ + c̄₀ ∈ M`. Let `V_v := {u ∈ U_S :
|u|_v = 1} = ⟨i, w_{p′} : p′ ∈ S ∖ {p}⟩`, which rotates the `v`-coordinate by units and is the only part of `U_S` that does not
rescale it. Put `F(x) := {c ∈ K_v : x + c̄ ∈ M}`: its graph is closed, `F(ux) = u_v F(x)`, and the set of `x` whose `F(x)` meets a
fixed sphere of `K_v` is closed and `V_v`-invariant. So `x₀` may be replaced by a point `x₁` of a `V_v`-minimal set `M′ ⊆ M`, with
`c₁ ∈ F(x₁)`, `|c₁| = |c₀|`. Let `Ŵ` be the closure of `V_v` in `O_v^×`, `Z` the orbit closure of `(x₁, 1)` in `M′ × Ŵ` under the
diagonal action, and `H′ := {s ∈ Ŵ : Zs = Z}`. `Z` is minimal (`x₁` is uniformly recurrent and `Ŵ`-rotation is distal), and its fibre
over `x₁` is exactly `H′`.

**Theorem VB6 (case B with an infinite fibre group is impossible).** If `H′` is infinite, contradiction. [hand] *Proof.* For `t ∈ H′`,
a net `g_α ∈ V_v` has `g_α x₁ → x₁` and `g_{α,v} → t`, so `g_α(x₁ + c̄₁) → x₁ + (tc₁)‾ ∈ M`: `F(x₁) ⊇ c₁H′`. An infinite closed
subgroup of `ℤ_p^×` is open, so `F(x₁)` contains a ball about `c₁`: Lemma SW. ∎

**The stall (the step I cannot make): case (B) with a finite fibre group.** If `H′` is finite, `x ↦ Z_x` is a continuous equivariant
map of `M′` onto the infinite profinite rotation `(Ŵ/H′, V_v)`: the `V_v`-minimal set `M′` has a `p`-adic odometer as an
equicontinuous factor (every `p`-power root of unity an eigenvalue of `w_{p′}`, with a continuous eigenfunction). **Nothing in my
route excludes this.** Three attempts, each failing:
- *More expansion.* `w_p` commutes with `V_v`, so `w_p^j M′` is another `V_v`-minimal set with the same factor and rescaled pairs:
  no new information.
- *Restriction.* `x ↦ x|_{R_{S∖p}}` maps `M′` onto a `V_v`-minimal subset of `Θ_k(R_{S∖p})`, at `S = {5, 13}` a rank-one system at 13.
  Rank one carries switching freedom (S0B-T5 at 5, and the lens is prime-independent, plan U3), and a switching schedule with a
  `5`-adic Toeplitz structure would be such a factor there. I know no reason it cannot exist in rank one.
- *The fill.* In rank two a point is its two axes plus the forced CRT fill (V5), and the band on the fill is the only constraint
  across directions. That is where a proof would have to use `p′`'s rotation of the `v`-digits against `p`'s expansion; I have no
  argument that the band on the fill forbids an odometer factor.

**So my route proves:** `RS_k(S)` (and `MS_k(S)`) for `|S| ≥ 2` **unless** some `V_v`-minimal subset of `Θ_k(R_S)` carries a pure
`v`-adic pair (`x, x + c̄`, `c ≠ 0`) and a `p`-adic odometer factor with finite fibre group. At three colours or with a pure
archimedean obstacle nothing changes; the stall is band-independent.

### B1.3 The verdicts (each claim quoted verbatim from the brief)

**Claim 1, D1-T1 (`MS₄(S)`).** "For every finite set `S` of primes `≡ 1 (mod 4)` with `|S| ≥ 2`, every `U_S`-minimal closed subset of
`Θ₄(R_S)` is either one finite orbit of torsion characters, or a finite union of leaf circles `τ + {λ_d : |d| = r}` with `0 < r ≤ r_τ`.
In both cases it is contained in `T + A`. **Inhabitant** `S = {5, 13}`: `{θ₂}`, and the parity circle of radius ¼."
- **Verdict: GAP** at case (B) with a finite fibre group (B1.2). Everything else is derived: the two kinds are exactly the minimal
  subsets of `Θ₄ ∩ (T + A)` (Lemma L); case (A) lands in `T + A` (VB5); an infinite fibre group is impossible (VB6). And for each
  `S` with `|S| ≥ 2` the claim is **equivalent** to `RS₄(S)` (VB2).
- Inhabitant checked: `θ₂∘u = θ₂` (every `u ≡ 1` mod `1 + i`), and `θ₂ + λ_d ∈ Θ₄` iff `|d| ≤ 1/4`; the circle `|d| = 1/4` is
  minimal (Lemma L). TRUE.
- **Hardest step:** excluding a minimal set with a `p`-adic odometer factor for the rotating prime.

**Claim 2, D1-T2 (`RS₄({5, 13})`).** "`Θ₄(ℤ[i][1/65]) ⊆ T + A`." with "**Inhabitant:** `Θ₄(R₆₅) ∋ θ₂` (margin ¼)."
- **Verdict: GAP**, at the same step with `S = {5, 13}` (equivalent to claim 1 there, VB2). What is derived: every point of
  `Θ₄(R₆₅)` whose orbit closure meets `T + A` is in `T + A` (VB1); every minimal set in case (A) or with an infinite fibre group is in
  `T + A`. Inhabitant TRUE.
- **Hardest step:** the same.

**Claim 3, D1-C2.** "The torsion characters in `Θ₄(R₆₅)` are finitely many. So `Θ₄(R₆₅)` is a finite union of leaf discs `τ + D(r_τ)`."
- **Verdict: TRUE conditional on D1-T2** (VB3, a non-effective expansion argument; the "So" also uses D1-T2). **Standalone: GAP.** I
  have no route to the finiteness that avoids D1-T2. A direct one would be a Furstenberg-type density statement in finite quotients
  (the multiplicative group `⟨i, w₅, w₁₃⟩` modulo large `N` meeting every arc of length 1/2 after dilation), which is of
  Bourgain–Lindenstrauss–Michel–Venkatesh type; I have nothing in hand for `ℤ[i]`-elements.
- **Hardest step:** none beyond D1-T2; VB3 is short.

**Claim 4, D2-T1 (RQ₄).** "`Θ₄(ℤ[i][1/p : p ≡ 1 (4)]) ⊆ T + A`."
- **The implication "D1-T2 and D1-C2, hence D2-T1": TRUE** (VB4, S0A's G1 with base `R₆₅`). D1-C2 is not needed as a separate input,
  since D1-T2 implies it (VB3); and D1-T2 gives more: `RS₄(S′)` for every `S′ ⊇ {5, 13}`.
- **D2-T1 itself: GAP**, resting on D1-T2.

**Claim 5, D5-T1 (`RS₅({5, 13})`).** "`Θ₅(ℤ[i][1/65]) ⊆ T + A`." (band `[1/5, 4/5]`)
- **Verdict: GAP**, same step: B1.1–B1.2 hold verbatim at `k = 5` (Lemma SW: a coset of step `≤ 1/5` meets the open arc
  `(−1/5, 1/5)` of length `2/5`). The stall is band-independent, so the five-colour claim is no easier and carries larger leaf discs.

**Claim 6, D5-C2.** "`Θ₅(R₆₅) ∩ T` is finite."
- **Verdict: TRUE conditional on D5-T1** (VB3 at `k = 5`); **standalone GAP**, as claim 3.

**Claim 7, D5-T2 (RQ₅).** "`Θ₅(ℤ[i][1/p : p ≡ 1 (4)]) ⊆ T + A`." with "**Inhabitant:** `θ₂`."
- **The implication "D5-T1 and D5-C2, hence D5-T2": TRUE** (VB4 at `k = 5`; D5-C2 redundant). **D5-T2 itself: GAP**, resting on D5-T1.
  Inhabitant TRUE (`1/2 ∈ [1/5, 4/5]`, margin `3/10`).

**Scope.** The seven headline statements are about characters only, and none is stated wider than that. Nothing here touches
non-character colourings or `χ(ℚ(√47)²)`.

**C0 against B1 (not yet scored; the owner scores after B3):** the implications came out TRUE as predicted. The three substantive
claims came out GAP at one step, which is what C0 expected of my route, not a verdict on their truth.
