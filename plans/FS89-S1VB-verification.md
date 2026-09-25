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

## B2 — the lemma statements (opened after commit de933eb4)

`data/fs89/briefs/S1-VB-lemma-statements.md` read in full after the B1 verdicts were committed. Each lemma below is derived or refuted
from its statement; proofs are mine. **One disclosure first:** D1-L3's statement is what closed my B1 stall. My B1 route based its
differences at a point of `M`, whose returns under the rotating subgroup it could not control. Furstenberg's original lemma bases the
difference set at `0`, which every automorphism fixes, and so needs no recurrence at all. I did not see this until I read the
statement. The proof below is mine; the idea of looking at `M − M` is not.

### D1-L2 (case 2 ⟹ a point of `T + A`) — **TRUE** [hand]
Quoted: "If `M ≠ ∅` is in case 2, then `M ∩ (T + A) ≠ ∅`. If `M` is minimal, then `M ⊆ T + A`, and `M` is a finite union of sets
`τ + {λ_d : |d| = r}` (one `r`, possibly `0`)."
- The agent's case 2 (small differences have `S`-adic part 0) implies my case (A) (small differences lie in `A`).
- A minimal `M₀ ⊆ M` inherits case 2 (`M₀ − M₀ ⊆ M − M`), so VB5 gives `M₀ ⊆ T + A`.
- The minimal form is VB5 plus Lemma L.

### D1-L3 (case 1 ⟹ `M − M = G`, when `|S| ≥ 2`) — **TRUE** [hand; the agent's named weakest link, derived with most care]
Quoted: "If `M` is closed, invariant and in case 1, and `|S| ≥ 2`, then `M − M = G`."

*Proof.* Put `D := M − M`. It is compact, contains 0, and is `U_S`-invariant, since `u(x − y) = ux − uy` for the automorphism `u`.
1. **A pure local element.** Case 1 gives `z_k ∈ D`, `z_k → 0`, with chart representatives `(a_k; b_k) → 0` and `b_k ≠ 0`.
   - Fix a place `v | p` with `b_{k,v} ≠ 0` along a subsequence.
   - Apply Lemma E to `D`, with `x_k = 0` and `y_k = z_k`. This is legitimate because `h·0 = 0`. It gives `c̄ ∈ D`, with `c ∈ K_v^×`
     pure `v`-adic.
   - Continuity of `ℂ × ∏K_v → G` carries the limit through, whatever the charts.
2. **Its orbit.** `u·c̄ = (u_v c)‾ ∈ D`, and `D` is closed, so `(tc)‾ ∈ D` for every `t` in the closure of the image of `U_S` in
   `K_v^×`.
   - Take `p′ ∈ S ∖ {p}`, which is where `|S| ≥ 2` is used. The closure of `⟨w_{p′}⟩` in `O_v^×` is an infinite closed subgroup, so
     it contains some `1 + p^jℤ_p`.
   - `w_p` has `|w_p|_v = p^{±1}`.
   - So `D ⊇ (w_p^k c + w_p^k c p^j O_v)‾ = (w_p^k c)‾ + Γ_k` for every `k`, where `Γ_k` is the image of the ball
     `B_k := w_p^k c p^j O_v`.
   - No base point's recurrence is needed, because `c̄` has archimedean part 0.
3. **`Γ_k` exhausts a dense subgroup.** As `k → ±∞` (the sign that grows `B_k`), `B_k ↑ K_v`.
   - The image of `K_v` is dense in `G`. Its annihilator in `Ĝ = R_S` is `{r : ψ_v(K_v r) = 0} = {0}`.
   - The `Γ_k` are increasing compact subgroups whose union is dense. By compactness each `Γ_k` is `ε_k`-dense, with `ε_k → 0`.
4. **Conclusion.** So `D` contains an `ε`-dense translate for every `ε`. `D` is closed, so `D = G`. ∎
- **Sanity:** with `|S| = 1` step 2 yields only the discrete multipliers `i^a w_p^k`, and the lemma fails, as it must (S0B: `Θ₄(R₅)`
  has case-1 orbit closures).
- **Stronger than stated:** the closure of the orbit of any non-zero pure local element is `G`.

### D1-L4 (the parity line) — **TRUE** [hand, two lines]
Quoted: "If `M ⊆ Θ₄(R_S)` and `θ₂ ∈ M − M`, then `M` contains a **corner**: a character `x` with `2x = θ₂`, i.e. `x = ⟨e, ·⟩` with
`e ∈ (1+i)/4 + ½ℤ[i]`. There are four corners; they form one `U_S`-orbit of order-4 torsion characters, of margin 0."
- Take `x − y = θ₂` with `x, y ∈ M ⊆ Θ₄`. Since `θ₂(u) = 1/2` for every `u ∈ U_S` (each `u ≡ 1 mod 1 + i`), `y(u)` and `y(u) + 1/2`
  both lie in `[1/4, 3/4]`. So `y(u) ∈ {1/4, 3/4}`, hence `2y = θ₂` on `U_S`, and so on its additive span `R_S`.
- `{y : 2y = θ₂}` is a coset of `G[2] ≅ Hom(ℤ[i]/2, ℤ/2)`, which has four elements: the `e` stated. They lie in `Θ₄` (values in
  `{1/4, 3/4}`, margin 0). `i` alone cycles them (`(1+i)/4 → (3+i)/4 → (3+3i)/4 → (1+3i)/4`).

### D1-L5 — **TRUE** [hand + tools exact]
Quoted: "… Suppose a band array has `|e_{m,n} − c_{m,n}| < 0.13` at `(m, n)` and at `(m+1, n)`. Then `e_{m,n} = c_{m,n}` and
`e_{m+1,n} = c_{m+1,n}`."
- The corner array is `(−1)^m c₀`: `w₅ ≡ −1` and `w₁₃ ≡ 1 mod 4`, and a corner is read mod 4. Checked: it satisfies both step rules in
  both directions.
- Put `δ = e − c`. Then `δ′ − w̄₅δ ∈ π₅^{−1}ℤ[i]`, with norm `< 0.26`, and `0.26² < 1/5` (the least non-zero squared norm there), so
  `δ′ = w̄₅δ`.
- `δ` lies in the closed quadrant of `Q − c` at its corner, and `δ′` in the opposite quadrant (the corner flips). Rotation by `w̄₅`
  (−53.13°) cannot carry a quadrant into its opposite, so `δ = 0`.
- Exact check (`tools/fs89_s1vb_corner_check.py`): the norm bound, and the cone intersection for all 4 corners × both parities × both
  directions. 0 meetings.

### D1-L6 — **TRUE** [hand + tools exact]
Quoted: "Suppose a band array equals the corner pattern at `(m, n)` and `(m, n+1)`. Then it equals the pattern at `(m ± 1, n)` and
`(m ± 1, n+1)`. Suppose it equals the pattern at `(m, n)`, `(m+1, n)` and `(m+2, n)`. Then it equals the pattern at `(m, n ± 1)`,
`(m+1, n ± 1)` and `(m+2, n ± 1)`."
- **By hand (first half, one corner).** From an exact site, a neighbour's deviation lies in the step lattice.
  - Near `(3/4, 3/4)` the 5-lattice offers `{0, (−1−2i)/5}`.
  - The 13-step between the two rows multiplies the `π₅`-class by `w̄₁₃ ≡ 3 (mod π₅)`, so a non-zero class cannot repeat. The only
    survivor is `δ = 0`.
- **By hand (second half).** Near `(1/4, 1/4)` the 13-lattice offers the classes `{0, 2, 4, 5}` (the coordinate `x` of
  `(x + yi)/13`, `y ≡ 8x`). Near `(3/4, 3/4)` it offers their negatives.
  - Along the row, `w̄₅ ≡ 7 (mod π₁₃)`.
  - `x₀ = 5` survives two sites (`7·5 ≡ 9 = −4`) and dies at the third (`10·5 ≡ 11`).
  - So length 3 is needed and suffices.
- **Exact check:** the survivors, over the finite lattice candidates, for all 4 corners, both parities and all 8 neighbour directions
  (48 cases): 0 non-zero chains.
- **Plant "short-row"** (a row segment of 2): exactly one survivor chain per case, the `x₀ = 5` chain predicted by hand.

### D1-C1 — **TRUE** [hand + tools exact, from D1-L5 and D1-L6]
Quoted: "A band array that equals a corner pattern on a `3 × 2` box is that corner. Hence every `θ ∈ Θ₄(R₆₅)` within `0.13` of a corner on
the window `|m| ≤ 2, |n| ≤ 1` is that corner."
- D1-L6's first move takes a vertical domino to whole rows, and its second takes rows to rows. A single vertical domino already
  suffices, which is stronger than the `3 × 2` box stated. The exact check confirms that the moves close up a `7 × 7` box from one
  domino. The array determines the character (V5), so the first sentence holds.
- The second sentence: D1-L5 applies to every horizontal pair of the window, so the window is exact, and the first sentence applies.
- (The window values are continuous in `θ`: `e_m = θ(w^m) + iθ(iw^m)`.)

### D2-L1 (bounded-order layering) — **TRUE** [hand]
Quoted: "Let `R ⊆ Q` be a subring with `U_R := U_ℚ ∩ R` and `ℤ[U_R] = R`. Suppose `R` is `p`-divisible for some prime `p` (so `λ_c`
vanishes on a nonzero ideal of `R` only if `c = 0`). Suppose also that `Θ_β(R) ⊆ T_N + A` for some `N`. Then `Θ_β(Q) ⊆ T_N + A`."
- This is VB4 / S0A's G1 with base `R`.
- One check: the layers `u·R`, `u ∈ U_ℚ`, carry band characters of `R` because `uU_R ⊆ U_ℚ`.
- `R₆₅` qualifies: `U_ℚ ∩ R₆₅ = U₆₅` by Hilbert 90.

### D5-L1 — **TRUE** [hand]
Quoted: "Let `M ⊆ Θ₅(R_S)` be closed, with `5 ∈ S`, and suppose `θ₂ ∈ M − M`. Then `M` meets `𝒞 := ⋃_{x₀ corner} (x₀ + {λ_d : |d| ≤
1/20})`, the four **corner leaf discs**. At band 1/5 the corners have margin 1/20."
- `y, y + θ₂ ∈ Θ₅` puts `y(U_S)` within `1/20` of `{1/4, 3/4}`, so `φ := 2y − θ₂` has `φ(U_S) ⊆ [−1/10, 1/10]`.
- **Narrow-band rigidity** (mine, for `5 ∈ S`):
  - In the array of `φ`, lifted into `[−1/10, 1/10]²`, a 5-step changes the value by a vector of norm `≤ 0.283 < 1/√5`, so it is exact:
    `e_{m+ε₅} = w̄₅e_m`.
  - For any other prime `p_j`, the 5-rows then force `w̄₅^m ℓ ∈ π_j^{−1}ℤ[i]` for all `m`, where `ℓ` is the `p_j`-step defect. So
    `ℓ = 0` (a pole at `π₅` otherwise).
  - So `φ = λ_{e₀}` with `|e₀| ≤ 1/10`, and `y = x₀ + λ_{e₀/2}` for a corner `x₀`, since `{y : 2y = θ₂ + λ_{e₀}}` is a coset of `G[2]`.
- Margin: `1/4 − 1/5 = 1/20`.

### D5-L2 — **TRUE** [hand]
Quoted: "Let `y = x₀ + λ_d` with `|d| ≤ 1/20`. Suppose an array is within 0.13 of `y`'s array on a connected window. Then it equals the
leaf array of `x₀ + λ_{d′}` there, for some `d′`."
- Every step changes the deviation by a lattice vector of norm `< 0.26`, which is below both `1/√5` and `1/√13 = 0.277`. So the
  deviation follows the leaf rule exactly, `δ_{next} = w̄_j δ`, along any path. `d′` is well defined on a connected window.
- The hypothesis `|d| ≤ 1/20` is not used; the lemma holds for any leaf at any band.

### D5-L3 — **TRUE** [hand + tools exact]
Quoted: "Suppose an array equals a corner-leaf array `c_{m,n} + w̄^{(m,n)}d′`, with `|d′| ≤ 0.06`, on a column segment of height 3. Then
it equals it on the two neighbouring columns at those rows. On a row segment of length 4 it equals it on the neighbouring rows."
- The continuous parameter `d′` is handled soundly: candidate deviations at a neighbour site are the lattice points of `(Q₅ − c)`
  enlarged by `0.06` in each coordinate. This is a superset, valid for every `|d′| ≤ 0.06`.
- The consecutive sites along the segment satisfy the other prime's step rule on the deviation. Survivors over all 48 cases: 0.
- **The lengths are tight for this over-approximation.** Plants "short-col" (height 2) and "short-row5" (length 3) give 32 and 16
  survivor chains. Plant "wide-leaf" (`|d′| ≤ 0.2`) gives 320.

**Plants.** "lattice" (the forward 5-step lattice replaced by `π̄₅^{−1}ℤ[i]`) fires first where it should: the corner array fails the step
rule. "cone" (the next site's quadrant taken equal to this one's) makes D1-L5 report 16 meetings. Output: `data/fs89/s1vb/corner-check.txt`;
0.1 s.

### The assembly: do the lemmas, as stated, give the seven claims?

| claim | derivation from the lemmas (as stated) | verdict |
|---|---|---|
| 1. D1-T1 | minimal `M`: case 2 ⟹ D1-L2 ⟹ `T + A`, one of the two kinds. Case 1 ⟹ D1-L3 ⟹ `θ₂ ∈ M − M = G` ⟹ D1-L4 ⟹ `M` holds a corner ⟹ `M` is its finite orbit ⟹ `0` isolated in `M − M`, contradicting case 1. Every `|S| ≥ 2`; no finite lemma needed | **TRUE** |
| 2. D1-T2 | `M` = orbit closure of `θ`. Case 2: some `gθ` is near `x ∈ M ∩ (T + A)` (D1-L2) with difference of `S`-adic part 0, so `θ ∈ T + A` (one line the statements leave implicit). Case 1: `M` holds a corner (D1-L3, L4), so some `gθ` is within 0.13 on the window, so `gθ` is the corner (D1-C1). **Alternative, finite-lemma-free:** VB1 | **TRUE** |
| 3. D1-C2 | not derivable from the listed lemma statements alone; VB3 gives it from D1-T2 (non-effective expansion). The derivation agent's own route is for B3 | **TRUE** |
| 4. D2-T1 | D2-L1 with `R = R₆₅`, `N` = lcm of the finitely many orders (D1-T2 + D1-C2) | **TRUE** |
| 5. D5-T1 | as claim 2 with D5-L1 (case 1 ⟹ `M` meets a corner leaf disc), then D5-L2 and D5-L3 to propagate the leaf over the whole array. Alternative: VB2's minimal-set form with D5-L1 (a minimal case-1 set would contain a `T + A` point, hence lie in `T + A`, hence be case 2), then VB1 | **TRUE** |
| 6. D5-C2 | VB3 at `k = 5` | **TRUE** |
| 7. D5-T2 | D2-L1 at band 1/5 | **TRUE** |

**Consequence worth stating (derived here, not claimed by the agent's headlines):** the argument proves `MS₄(S)` and `RS₄(S)` for
**every** `S` with `|S| ≥ 2`, and `RS₅(S)` for every `S ∋ 5` with `|S| ≥ 2`, with no finite computation at all:
- D1-T1 comes from D1-L2, L3 and L4.
- RS then comes from VB1, which needs no isolation lemma.

The finite lemmas at `{5, 13}` (D1-L5, L6, C1; D5-L2, L3) are needed only for the agent's isolation route, which VB1 replaces.

**B1 against B2.** B1 returned GAP on claims 1, 2, 5 (and on the standalone halves of 3, 6, and on 4′, 7′) at the step "a minimal
set with a `p`-adic odometer factor". That step does not arise: D1-L3 shows a case-1 set has `M − M = G`, and at both bands `θ₂ ∈ M − M`
forces a torsion (or `T + A`) point into `M`. **All seven claims: TRUE.** The B1 verdicts were my route's, not the claims'.

**Hardest step, after B2:** D1-L3's step 2 to 3, the passage from one pure local element to density. It is short once the difference set
is based at `0`, and the whole milestone rests on it.

## B3 — divergence table (the derivation agent's record `plans/FS89-S1D-derivation.md` §2–§6, opened after commit 1eb9a783)

**Truth: no divergence.** Every lemma and every claim is TRUE in both records. The differences are of route and of scope:

| item | the derivation agent (D) | verifier I (V-B) | kind |
|---|---|---|---|
| D1-L2 | `x` in a `⟨w_p⟩`-minimal subset is recurrent; case 2 makes `x∘c = λ_v` with `c = w_pⁿ − 1`; `y = x − λ_{v/c̄}` kills the ideal `cR_S`, so it is torsion | finitely many cosets of `A` cover `M`; a finite-index subgroup fixes each; `(u − 1)b_v = r` puts every `v`-component at one rational (VB5) | **route**; D's is shorter and gives "meets `T + A`" for any closed invariant set directly |
| D1-L3 | expand at `v`, rotate by `⟨i, w_q⟩` (open in `ℤ_v^×`); density of the image of `ℚ_v` by strong approximation with `v` omitted | the same expansion and rotation, based at `0`; density by the annihilator of the image of `K_v` in `Ĝ = R_S` being 0 | **route** (density argument only); same idea, both sound. **V-B found this idea only after reading D's statement** (B2 disclosure) |
| D1-L4 | same two-line argument | same | none |
| D1-T1 | case 2 ⟹ D1-L2; case 1 ⟹ D1-L3, L4 ⟹ a finite corner orbit, which contradicts case 1 | same | none |
| D1-L5 | the same cone argument (`Re(w̄₅ζ) = (3s + 4t)/5 > 0` on the first quadrant) | cone intersection, checked exactly over all corners and directions | none |
| D1-L6 | admissible 13-classes `{5, 6, 10}` / `{3, 7, 8}` (D's labelling of `𝔽₁₃`); orbits `6 → 3 → 8`, `7 → 10 → 5` | admissible classes `{2, 4, 5}` / negatives (V-B's labelling: the real coordinate of `(x + yi)/13`); `5 → 9 → 11`; independent tool, 48 cases, 0 survivors; the plant at row length 2 leaves exactly the one predicted chain per case | **none of truth**; labellings differ. Both find length 3 necessary and sufficient |
| D1-C1 | from a `3 × 2` box | from a single vertical domino, which is stronger; its closure is checked | **minor strengthening** |
| D1-T2 | case 1 forces a corner into the orbit closure, and D1-C1 (isolation at `{5, 13}`) finishes | **VB1**: an orbit closure meeting `T + A` puts the point in `T + A` (expansion, rotation by the second prime, sweep), for **every** `|S| ≥ 2`, with no isolation lemma | **route; scope**. V-B's route needs no finite computation |
| D1-C2 | the closure of the non-corner band torsion characters is case 1, so it holds a corner, which contradicts D1-C1 | **VB3**: expansion from an accumulation point produces a non-`T + A` point, contradicting RS (any `S`) | **route**; D's is specific to `{5, 13}`, V-B's general and non-effective |
| D2-L1 | the archimedean parts are aligned on the ideals `R ∩ uR`, then `Nψ = 0` on every layer | S0A's G1 (the 5-adic real lift) with base `R` | **route**; both sound |
| D5-L1 | FS81-T3 (`Θ₃(R₅)`) gives `Θ_{2/5}(R₅) = θ₂ + D(1/10)`, layered by D2-L1 to `R_S` | narrow-band rigidity proved directly: 5-steps are exact (`0.283 < 1/√5`), and the other primes' defects are killed by `w̄₅^m` | **route**; V-B's is elementary and needs no FS-81 input |
| D5-L2 | digit spacing | the same; its hypothesis `|d| ≤ 1/20` is not needed | none |
| D5-L3 | admissible sets computed by D's tool; exits die by step 2 (columns) or step 3 (rows) | independent tool with a sound over-approximation of the continuous `d′`; the plants show the stated lengths (3 and 4) are exactly tight | none |
| D5-T1, D5-C2 | isolation near the corner leaf (D5-L2, L3) on the window `|m| ≤ 3, |n| ≤ 2` | VB1/VB2 with D5-L1; VB3 | **route** (as D1-T2, D1-C2) |
| D2-T1, D5-T2 | D2-L1 with `N` from D1-C2 / D5-C2 | VB4 (`RS_k(S)` alone suffices, since VB3 gives the bound) | **route**; D1-C2 is not an independent input |
| **scope of RS** | §3: "D1-T2 is about `R₆₅` exactly … What is missing [for `S ⊋ {5, 13}`] is D1-L6 in each new direction `p′` … not a theorem for all `p′`" | `RS₄(S)` holds for **every** `S` with `|S| ≥ 2`, and `RS₅(S)` for every `S ∋ 5` with `|S| ≥ 2` (VB1 with D1-L2 to L4 and D5-L1). And even on D's own route, D's general D2-L1 (its theorem table: `R ⊆ R′ ⊆ Q`) already gives `RS_k(S′)` for every `S′ ⊇ {5, 13}` | **scope: D understates what is proved.** D's §3 scope paragraph is inconsistent with its own D2-L1 in general form |
| `MS₄({5})` | "not decided here" | not decided here either. The minimal sets of the rank-one system are untouched by both | none |

**Claims stated wider than proved?** None. Every headline is about characters only, and D repeats the plan's §0.2 scope line at §4 and
§5. The consequences D lists (C-HD1, C-47, C-167) are marked "at their own grades (not re-derived here)". I did not re-derive them
either; they are outside this brief.

**What D asked V to hit hardest** (§6): D1-L3, then the exit lemmas, then finiteness, layering, D1-L2 and D5-L1. All six are re-derived
here, each by at least one route different from D's. The two routes that differ most, D1-T2 without isolation (VB1) and D1-C2 by
expansion (VB3), agree with D's conclusions.

## C0 scored

| claim | predicted P(TRUE) | outcome |
|---|---|---|
| 1. D1-T1 | 0.45 | TRUE (B1: GAP at my route's step; B2: TRUE) |
| 2. D1-T2 | 0.40 | TRUE |
| 3. D1-C2 standalone | 0.40 | TRUE |
| 3′. D1-T2 ⟹ D1-C2 | 0.85 | TRUE (VB3) |
| 4. the implication to D2-T1 | 0.92 | TRUE |
| 4′. D2-T1 | 0.38 | TRUE |
| 5. D5-T1 | 0.30 | TRUE |
| 6. D5-C2 | 0.30 | TRUE |
| 7. the implication to D5-T2 | 0.92 | TRUE |
| 7′. D5-T2 | 0.28 | TRUE |

The implications were called right. The substantive claims were under-predicted: I expected the isometric direction to block a proof,
and it does block the route I took (base points in `M`). It does not block the difference set based at `0`.

## Would-have-searched-here log

- **B1, the stall.** I would have run the rank-two window at `{5, 13}` outward from S0B's lens, to look for a switching array or a
  Toeplitz-type minimal set with a 5-adic odometer factor. Instead I recorded the stall as a named GAP and moved on; B2 closed it by
  derivation.
- **D1-C2.** I would have enumerated band torsion characters of `ℤ[i]/N` modulo `⟨i, w₅, w₁₃⟩` for growing `N`, to "see" finiteness.
  Instead: VB3 (finiteness from rigidity, by expansion).
- **The finite lemmas (B2).** `tools/fs89_s1vb_corner_check.py` loops over the lattice points of a fixed bounded box and the corner and
  direction cases each lemma names. No witness is sought; each check asserts that the survivor set is exactly the corner pattern. It is
  logged here because it loops over classes. Six planted faults fire, each for its stated reason.

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| S1VB-1 | Lemma E (expansion): small differences with a non-zero local part in a closed invariant set expand to a pure local difference | hand | § B1.0 |
| S1VB-2 | Lemma SW: no ball of pure local translates lies in `Θ_k(R_S)`, `k ∈ {4, 5}` | hand | § B1.0 |
| S1VB-3 | Lemma JC: `⟨(w̄_{p′}, w_{p′}|_v)⟩` is dense in `S¹ × W₀`, `W₀` open in `ℤ_p^×` | hand | § B1.0 |
| S1VB-4 | VB1: for `|S| ≥ 2`, a band point whose orbit closure meets `T + A` is in `T + A` (bands 1/4, 1/5) | hand | § B1.1 |
| S1VB-5 | VB2: for `|S| ≥ 2`, `MS_k(S) ⟺ RS_k(S)` ⟺ every minimal subset of `Θ_k(R_S)` meets `T + A` | hand | § B1.1 |
| S1VB-6 | VB3: `RS_k(S)` ⟹ `Θ_k(R_S) ∩ T` finite (any nonempty `S`; non-effective) | hand | § B1.1 |
| S1VB-7 | VB4: `RS_k(S)` ⟹ `RS_k(S′)` for every `S′ ⊇ S`, finite or not; in particular RQ_k | hand | § B1.1 |
| S1VB-8 | VB5: a minimal set whose small differences are archimedean lies in `T + A` | hand | § B1.2 |
| S1VB-9 | VB6: a minimal set with a pure local pair and an infinite fibre group is impossible | hand | § B1.2 |
| S1VB-10 | D1-L3 re-derived: case 1 and `|S| ≥ 2` ⟹ `M − M = G`; the orbit closure of any non-zero pure local element is `G` | hand | § B2 |
| S1VB-11 | D1-L4 re-derived (parity line ⟹ corner) | hand | § B2 |
| S1VB-12 | narrow-band rigidity: for `5 ∈ S`, a character with `φ(U_S) ⊆ [−1/10, 1/10]` is `λ_e`, `|e| ≤ 1/10`; hence D5-L1 | hand | § B2 |
| S1VB-13 | D1-L5, D1-L6, D1-C1 (from one vertical domino), D5-L3 checked exactly; the stated segment lengths 3 and 4 are tight | tools exact (`tools/fs89_s1vb_corner_check.py`, `data/fs89/s1vb/corner-check.txt`) | § B2 |
| S1VB-14 | **`RS₄(S)` and `MS₄(S)` for every finite `S` with `|S| ≥ 2`; `RS₅(S)` and `MS₅(S)` for every `S ∋ 5`, `|S| ≥ 2`**; with VB4, RQ₄ and RQ₅ (no finite computation) | hand (D1-L2 to L4, D5-L1, VB1, VB4) | § B2 assembly |
