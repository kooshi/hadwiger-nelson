# FS-85 — verifier 2: an independent derivation of `F = P = 8Λ` on de Grey's lattice from Parts's (S′)

*Verifier 2 (Opus 5.5), briefed by the product owner, `data/fs85/briefs/V2-verifier-brief.md`. Record opened 2026-09-24.
Tools under `data/fs85/v2/`. No subagents; no search for a finite witness (the week's ban); exact algebra only.*

## §0. A slip, recorded before anything else (independence)

At start-up, before any derivation, I ran `git log --oneline -15` to see the repository's state. That printed the subjects of this
week's commits, which the brief closes to me. Two of them describe a route for W3:
- `2199e552`: "the 5-part lemma PROVED, in a stronger form … Route: tetrahedron splitting slice by slice over
  `Λ/40Λ = Λ/P₊ × Λ/P₋ × Λ/5Λ`, one chirality per component by an edge, Fourier disjointness of the 5-part, and in the residue
  case the plane complementarity (dim Π_i + Π_j = 4) and a two-line ±1 lemma";
- `5d93e873`: "the 48 order-10 characters from their definition: 8 per admissible pair index, each set two lines of the dual `F5^4`".

I opened no diff and no closed file. The words above are all I saw. **Consequence for scoring:** my W3 derivation is blind to the
agents' proofs but not to that one-line route outline; where my route coincides with it, the coincidence is weaker evidence than it
would otherwise be. I derive my own anyway, and say at each step whether the outline suggested it.

## §C0. Predicted verdicts (written before any derivation)

| statement | predicted verdict | probability | reason for the doubt |
|---|---|---|---|
| W1 | proved | 0.95 | (a) is a count on a 6-cycle; (b)–(c) are the standard point-support theorem for distributions |
| W2 | the numbers reproduce | 0.90 | exact Smith-form arithmetic |
| W3 | proved as stated | 0.55 | **scope of (S′):** Parts's triple sits in the family `k = 0` (his Golomb root at the centre, the triple `{ζ₆, ζ₆⁻¹, −1}`); a copy of G481 whose triple is in family `k ≠ 0` is `η^k·G481`, whose edges are families `k−2..k+2`, which leave `U_{|k|≤2}`. So (S′) on the *five-family* graph needs either an automorphism of that graph moving families or the full graph. The "hence 24Λ-periodic" half on `Cay(Λ, U)`: 0.80 |
| W4 | proved | 0.65 | the statement as written looks like it needs more than the spectrum (a triple sum is not determined by `Θ_all` alone) |
| W5 | proved | 0.75 | |
| W | proved given (S′) | 0.70 | |

(The W3 probability was written after the slip above; the commit subject claims "proved", which I discount.)

## §S. The input's scope: what Parts's G481 gives on the five-family graph (settled before W3)

**Verdict: (S′) as the brief states it is not what G481 supplies. On the five-family graph `Cay(Λ, U_{|k|≤2})` G481 gives NT_0 only.
On the full graph `Cay(Λ, U)` it gives NT_k for every `|k| ≤ 2` — call that (S″).** [tools exact + hand]

- Parts's coordinates `(a + b√33 + ic√3 + id√11)/12` map into `Λ` exactly; the nine trees' 268 vertices (his "268 used") all lie in
  `Λ₅ = 3Λ`, and every one of the 1,203 tree edges is a vector of `U_{|k|≤2}`, all five families used (`data/fs85/v2/s_prime.py`).
- The refuted triple is `{ζ₆, ζ₆⁻¹, −1}` about the centre (tree S's roots `(6,0,6,0)`, `(6,0,−6,0)`, `(−12,0,0,0)`): **family 0**.
- Every ℤ-linear map `φ: Λ₅ → Λ` with `φ(U₅) ⊆ U₅`, injective or not, is one of the 24 point-group automorphisms, and each sends
  family 0 to family 0 (it induces `k ↦ ±k`) (`s_prime.py`, `s_prime_hom.py`). **Control:** allowing images anywhere in `U`, the same
  enumeration finds maps sending family 0 to each of `±1, ±2` (multiplication by `ζ₆^j η^{±1}, η^{±2}` and conjugates), so the
  instrument can see family-moving maps when they exist. *(A non-linear graph homomorphism is not excluded by this; deciding that is a
  search, and nothing in the input claims one.)*
- `η^k·G481` (on the tree vertices) lies in `Λ` for `|k| ≤ 2`, with edge families `k−2..k+2` — inside `U`, outside `U_{|k|≤2}` for
  `k ≠ 0` (`s_prime.py`). Hence (S″).
- **So R3a's "the five families alone" is overstated as an unconditional claim.** Its content survives in the conditional form below,
  which uses NT as a hypothesis; the theorem W needs only (S″).

Also, a correction to the brief's objects: `P_− = (1/9)β^{−3}O_E` **contains** `Λ` (`β^{−1} = −β̃/2`, `β̃ = (5−√33)/2`), so "`x mod P_−`"
is trivial. The ideal the statements need is `P_− = (1/9)β̃³O_E = (8/9)β^{−3}O_E`. With `𝔓 = βO_E`, `𝔓̃ = β̃O_E` (the two primes above
2, each conjugation-stable with residue field `𝔽₄`, `ββ̃ = −2`): `P_+ = (1/9)𝔓³`, `P_− = (1/9)𝔓̃³`, `[Λ : P_±] = 64`, and on a component
`P_± ∩ Λ₅ = (1/3)𝔓_±³`, of index 64 in `Λ₅`.

## §W1. The spectral lemma — **proved** [hand]

*(a)* In a proper colouring, the six points `x + ζ₆^jη^k` are neighbours of `x` and consecutive ones differ by `ζ₆^{j+2}η^k ∈ U`, so the
rim is a proper 3-colouring of `C₆` avoiding `c(x)`. With `v₁..v₄` the tetrahedron (`Σv_i = 0`, any three independent),
`Σ_rim g = Σ_{b ≠ c(x)} n_b v_b` and `−2g(x) = 2Σ_{b≠c(x)} v_b`; these agree iff every `n_b = 2`. A colour used three or more times on
`C₆` occupies an independent 3-set, i.e. an alternate triple. So `A_k g = −2g` at `x` ⟺ no alternate triple is monochromatic.
*(b)* `A_k` is convolution with a finite symmetric measure, multiplier `m_k(θ) = 2[cos 2πt₀ + cos 2πt₁ + cos 2π(t₁−t₀)]`,
`t_j = θ(ζ₆^jη^k)` (using `ζ₆² = ζ₆ − 1`). The identity `1 + cos a + cos b + cos(a−b) = 4 cos(a/2) cos(b/2) cos((a−b)/2)` gives
`m_k(θ) = −2` ⟺ one of `t₀, t₁, t₁ − t₀` is `1/2` ⟺ `θ(ζ₆^jη^k) = 1/2` for some `j ∈ {0,1,2}`. For bounded `g`, `ĝ` is a distribution
on the torus and `(m_k + 2)ĝ = 0`; off the zero set of the smooth function `m_k + 2` one divides a test function by it, so
`supp ĝ ⊆ ⋂_k {m_k = −2} = Θ_K`.
*(c)* **Lemma.** A bounded `g: ℤ^r → ℂ^d` whose transform has finite support `Θ` is `Σ_{θ∈Θ} a_θ e(θ(x))`. *Proof.* A distribution
supported at a point is a finite sum of derivatives of δ there (Schwartz), whose inverse transforms are `p(x)e(θ(x))`, `p` a
polynomial; so `g ∈ V := span{x^α e(θx)}`, finite-dimensional and translation-invariant. Put on `V` the norm `max_{x∈B}|f(x)|` over a
finite uniqueness set `B`; then `‖τ_y g‖ ≤ sup|g|` for all `y`. `V = ⊕_θ V_θ` (generalised eigenspaces of the commuting translations,
`V_θ = {p·e(θ·)}`), the projections commute with `τ_y`, so each `τ_y g_θ` is bounded; on `V_θ`, `τ_{ne_i} = e(nθ_i)(1 + N_i)^n` with `N_i`
nilpotent, and `(1+N_i)^n g_θ` is a vector polynomial in `n`, bounded only if `N_i g_θ = 0`. So `g_θ(x + e_i) = e(θ_i)g_θ(x)` for every
`i`, i.e. `g_θ = g_θ(0)e(θ·)`. ∎ Hence `c` (recovered from `g` since the `v_i` are distinct) is `P(Θ_K)`-periodic when `Θ_K` is finite.
*Scope:* (a) needs only that family `k`'s six vectors are edges; (b)–(c) need `g` bounded, true for any colouring.

## §W3. The 5-part lemma — **proved in its conditional form** [hand + tools exact]; **as the brief states it (unconditional on the
five-family graph), it rests on (S′), which G481 does not supply (§S)**

**Statement proved.** Let `c` be a proper four-colouring of `Cay(Λ, U_{|k|≤2})` satisfying NT_k for `|k| ≤ 2` at every point. Then on
each component `y + Λ₅` (`Λ₅ = 3Λ = (1/3)O_E`) `c` is a function of `x mod (1/3)𝔓_ε³` for one `ε ∈ {+, −}` (the two primes above 2),
hence `8Λ₅`-periodic. With (S″), every proper four-colouring of `Cay(Λ, U)` satisfies the hypothesis, so it is `8Λ₅ = 24Λ`-periodic.

**Exact facts used** (`data/fs85/v2/w3_facts.py`, each asserted; plants below). On `M = Λ₅`:
- **F1.** `Θ₅(M)` (the `Θ_{|k|≤2}` of the group `M`) has 90 characters: 21 local at `𝔓` (trivial on `(1/3)𝔓³`), 21 local at `𝔓̃`, and
  48 of order 10; no 2-power character is mixed; `0 ∉ Θ`. (On `Λ` this is the brief's 7,290 = 90 × 81: the preimage.)
- **F2.** Each order-10 character is `α + ψ` with `α ∈ A₊ ∪ A₋` — the three nonzero characters of `O/𝔓 ≅ 𝔽₄` and of `O/𝔓̃` (F4) — and
  `ψ` of order 5; for each `α` the 5-parts form `L_α`, the nonzero points of **two distinct lines** in the dual of `M/5M ≅ 𝔽₅⁴`.
- **F3.** Within `A₊` (and within `A₋`) the sets `L_α` are pairwise disjoint (six distinct lines a side).
- **F5.** `U₅` generates `M/5M`. (F6, F7: the second routes' checks, below.)

**Setup.** CRT: `M/40M ≅ R₊ × R₋ × F`, `R_± = M/(1/3)𝔓_±³ ≅ O/𝔓_±³` (64 each), `F = M/5M`; write `x ↦ (x₊, x₋, y)` and `r_± ∈ 𝔽₄` the
residue of `x_±`. By W1 on the component, `ĝ ⊆ Θ₅(M)`, so by F1–F2
`g = Φ₊(x₊, y) + Φ₋(x₋, y)`, `Φ_± = G_±(x_±) + K_±(r_±, y)`, `K_±(r, y) = Σ_{α∈A_±} α(r)H_α(y)`,
with `G_±` spectrum in the 21 local characters (no constant term) and `H_α` spectrum in `L_α` (so mean zero in `y`).

**Lemma T (splitting).** If `A + B ⊆ T` (the four tetrahedron vertices), then `|A| = 1` or `|B| = 1`. *Proof:* `|T ∩ (T + d)| ≤ 1` for
`d ≠ 0`, since `t₃ − t₁ = t₄ − t₂` with `{t₁,t₃} ≠ {t₂,t₄}` would make four vertices coplanar or three collinear. With `a ≠ a'` in `A`,
`B ⊆ (T − a) ∩ (T − a')`. The same holds for the two-point set `{±1}`. ∎

**Step 1 (slice).** Fix `y`. `(x₊, x₋)` range independently, so by Lemma T one of `Φ₊(·, y)`, `Φ₋(·, y)` is constant — and then it is
`0`, its mean over `x_±` being `0` (`G_±` has no constant term; `Σ_r K_±(r, y) = 0`). Let `Y_± = {y : Φ_±(·, y) ≡ 0}`; `Y₊ ∪ Y₋ = F`, and
`Y₊ ∩ Y₋ = ∅` (else `g = 0`). On `Y₊`, `G₊(x₊) = −K₊(r₊, y)`, so **`Y₊ ≠ ∅` ⇒ `G₊` factors through `r₊`**; likewise for `−`.

**Step 2 (not both non-residue — one chirality per component).** If neither `G₊` nor `G₋` factors through its residue, `Y₊ = Y₋ = ∅`,
contradicting `Y₊ ∪ Y₋ = F`.

**Step 3 (the non-residue case: the 5-part vanishes by Fourier disjointness).** Say `G₊` does not factor through `r₊`. Then `Y₊ = ∅`,
`Y₋ = F`, `Φ₋ ≡ 0`: `G₋(x₋) = −K₋(r₋, y)` for all `y`, so `K₋(r, ·)` is constant in `y`, hence `0`, and `G₋ = 0`. So `g = G₊(x₊) + K₊(r₊, y)`.
For each residue `r`, `(x₊ ∈ r + 𝔓/𝔓³, y)` range independently, so by Lemma T `G₊` is constant on that fibre or `K₊(r, ·) ≡ 0`. Some
fibre `r₁` has `G₊` non-constant, so `Σ_{α∈A₊} α(r₁)H_α ≡ 0`; the `H_α` have pairwise disjoint Fourier supports (F3) and `α(r₁) = ±1`,
so every `H_α = 0`: `K₊ ≡ 0` and **`g = G₊(x₊)`**, a function of `x mod (1/3)𝔓³`. *(Properness is not used in this step.)*

**Step 4 (the residue case: both `G_±` factor through residues).** Then `g = Ψ₊(r₊, y) + Ψ₋(r₋, y)`, a function of `x mod 10M`.
- *4a, one prime on every slice.* For `y ∈ Y₊`, `g` on the slice is a function of `r₋` alone whose four values are the four vertices
  (a multiset of four vertices summing to `0` is all four); for `y ∈ Y₋` likewise in `r₊`. If `y ∈ Y₋` and `y + u₅ ∈ Y₊` for an edge
  `u`, the edge `(r₊, r₋, y) → (r₊ + u₊, r₋ + u₋, y + u₅)` joins a colour that runs over all four as `r₊` varies to one that runs over
  all four as `r₋` varies, independently — some edge is monochromatic. So `Y₋ + u₅ ⊆ Y₋` for every `u ∈ U₅`, and `U₅` generates `F`
  (F5): `Y₋ ∈ {∅, F}`. Say `Y₋ = F`, so `g = Ψ₊(r₊, y)`, `π_y := Ψ₊(·, y)` a bijection `𝔽₄ → colours`. *(Second route, spectrum only,
  F7: with `k_α(y) = 1_{Y₋}(y)(−1)^{α(π_y^{-1}(a))}`, `k_α` has spectrum in `{0} ∪ L_α`, so `1_{Y₋} = k_α²` has spectrum in the plane
  `Π_α = span L_α` for all three `α ∈ A₊`, and those three planes meet only in `0`.)*
- *4b, no 5-part (the two-line lemma).* For colour `a` let `φ_a(y) = π_y^{-1}(a)`, so `1_a(r, y) = [r = φ_a(y)]` and its
  `(α, ψ)`-coefficient is `¼·ĥ_{a,α}(ψ)` with `h_{a,α} = (−1)^{α∘φ_a}`. Since `1_a = (1 + 3⟨g, v_a⟩)/4`, its spectrum lies in
  `{0} ∪ Θ`, so `ĥ_{a,α} ⊆ {0} ∪ L_α`. **Two-line ±1 lemma:** a `±1` function on `F` with spectrum in `{0} ∪ ℓ₁ ∪ ℓ₂` (two distinct
  lines, F2) is `c + p(λ₁(y)) + q(λ₂(y))` with `(λ₁, λ₂)` onto `𝔽₅²`, so by Lemma T for `{±1}` one of `p, q` is `0`: it is a function of
  one line. **Full support:** a non-constant `±1` function on `ℤ/5` has every nonzero Fourier coefficient nonzero (a nonempty proper
  subset of the fifth roots of unity never sums to 0, `Φ₅` having all coefficients 1). Now `h_{a,α₃} = h_{a,α₁}h_{a,α₂}`. If exactly
  one of `h_{a,α₁}, h_{a,α₂}` is non-constant, `h_{a,α₃}` is ± it, supported on a line of `L_{α₁}` (or `L_{α₂}`), not in `L_{α₃}` (F3).
  If both are, on lines `λ₁ ≠ λ₂` (F3), `h_{a,α₃}` has nonzero coefficients at all 16 points `aλ₁ + bλ₂` (`a, b ≠ 0`) — four lines,
  not two. So every `h_{a,α}` is constant, `φ_a` is constant, and `g = ρ(r₊)`: **the residue colouring at `𝔓`** (a function of
  `x mod 𝔓`, a fortiori of `x mod 𝔓³`).

**Conclusion.** In every case `g` on the component is a function of `x₊` or of `x₋`. ∎ The per-component choice `ε` is not coupled
across components here (W5 does that).

**Where properness enters:** only W1(a) and step 4a's first route. The tetrahedron-valuedness and the spectrum do the rest.

**Coincidence with the route outline I saw (§0):** the CRT slice decomposition over `Λ/P₊ × Λ/P₋ × Λ/5Λ` (my step 1) and a
"two-line ±1 lemma" (my step 4b) match words in that outline, as does "one chirality per component" (my step 2) and "Fourier
disjointness of the 5-part" (probably my step 3). My step 4a's first route (properness) is not in it; its "plane complementarity"
matches my second route for 4a (F7 — derived here from the `k_α² = 1_{Y₋}` identity; I found that the three planes of *one side*
already meet only in 0, while only 6 of the 9 cross pairs `Π_α, Π_β` are complementary). I cannot certify that I would have chosen
the CRT slicing unprompted; I would note that F1 (no mixed 2-power character) makes it the first thing to try.

**The adversarial attempt (by formula, `data/fs85/v2/attempt.py`).** The natural candidate: the residue colouring at `𝔓` twisted by
a 5-adic ridge, `c(x) = [x + s(λ(x))·d] ∈ M/(1/3)𝔓`, with `λ` the form of a line `ℓ₁ ∈ L_{α₁}` (so the ridge sits where the spectrum
allows it for `α₁`), `d` a unit vector with `α₁(d) = 1/2`, `s = 1_{{1,2}}`. Four-valued and not `24Λ`-periodic (it depends on `x mod 5`).
It fails exactly where the proof says: **(i)** its `α₂`-coordinate (`α₂` the other character with `α₂(d) = 1/2`) has spectrum
`α₂ + τℓ₁`, `τ ≠ 0`, and `ℓ₁ ∉ L_{α₂}` (F3) — so it is not in `Θ₅` and, by W1(a), NT fails somewhere — this is step 4b's
obstruction; **(ii)** it is not proper: `u = (0,3,0,−1)` (M-coordinates) `∈ U₅` has `u ≡ d (mod 𝔓)` and `λ(u) = 1 ≠ 0`, and the edge
`0 → u` is monochromatic (exact). No candidate in step 3's shape exists either: there the spectrum alone forces `K₊ ≡ 0`.

**Plants** (each fired, at its own assertion): (1) drop a family from `K` → F1's count (666 ≠ 90); (2) a wrong unit vector → the
solver's rank assertion (a choice of four becomes singular); (3) `β²` for `β³` → F1's split (9, 9, 48); (4) two `α` share a line →
F3; (5) generators from family 0 only → F5; (6) a spurious common vector → F7.

**Would have searched here:** (1) "colour `Λ/40Λ` with the spectrum constraint and see if anything non-local survives" — replaced by
steps 1–4; (2) "find a mono edge of the attempt by scanning points" — replaced by the formula (`x = 0`, `u` with `u ≡ d`, `λ(u) = 1`).

## §W2. The exact character sets — **reproduced** [tools exact]

From the definition, by my own solver (`data/fs85/v2/theta.py`: for each choice of `j` on four families, the exact solutions of
`A₄t ≡ ½`, then a filter on the other families by "some `j` has `θ = ½`", then every element re-checked against the definition):
`|Θ_all| = 42`, orders 2, 4, 8 (6, 12, 24), `P(Θ_all) = 8Λ`; `|Θ_{|k|≤2}| = 7290`, orders 2, 4, 6, 8, 10, 12, 24, 30,
`P(Θ_{|k|≤2}) = 120Λ`. Supplementary: the 2-power part of `Θ_{|k|≤2}` is exactly `Θ_all`; on the component group `Λ₅` the set is 90
(F1); on `Λ₇`, `Θ_{|k|≤3}` has 42 characters, all 2-power, `P = 8Λ₇` (`w45_facts.py` G3). `Λ₅ = 3Λ = (1/3)O_E` (index 81) and
`Λ₇ = (√−3/9)O_E` (index 9) (`basics.py`).

## §W4. The alternate-triple lemma — **proved** [hand + tools exact], in a form that needs no properness

**Lemma.** Let `g: Λ → T` be any tetrahedron-valued function (a four-colouring, proper or not) with spectrum in `Θ_all + Ann(Λ_K)`,
`[Λ : Λ_K]` odd. If an alternate triple of the family-`k` hexagon at `x` lies in one coset `z + Λ_K`, it is not monochromatic. So NT_k
holds at every `x` for every family `k` whose even and odd alternate triples each lie in one coset.

*Proof.* The decomposition `χ = θ + ψ` (2-part, odd part) is unique. On `z + Λ_K`, `ψ` is constant, so `g(w) = Σ_{θ∈Θ_all} b_θ e(θ(w))`
there. Let `G_z(x) := Σ_θ b_θ e(θ(x))` on all of `Λ`: it is `8Λ`-periodic, and `z + Λ_K + 8Λ = Λ` (odd index), so every value of `G_z`
is a value of `g` on `z + Λ_K`: **`G_z` is tetrahedron-valued everywhere** and agrees with `g` on the coset. Its spectrum lies in
`Θ_all ⊆ {m_k = −2}` for every `k`, so `A_k G_z = −2G_z` everywhere. For a tetrahedron-valued function (proper or not),
`Σ_rim = −2·(centre)` forces the rim counts `(0, 2, 2, 2)` (the `v_i` have one linear relation), so no alternate triple of `G_z` is
monochromatic; the triple in `z + Λ_K` carries `g = G_z`. ∎

**Hence NT_{±3} and NT_{±4}, given W3 and (S″).** Every alternate triple of families `±3` lies in one `Λ₅`-coset and of `±4` in one
`Λ₇`-coset: both ideals are `ζ₆`-stable and `√−3·η^k ∈ Λ₅` for `|k| ≤ 3`, `∈ Λ₇` for `|k| ≤ 4` (G1, exact; hand: `η^k ∈ 𝔮₁^k𝔮₂^{−k}`
with `(η) = 𝔮₁/𝔮₂` the primes above 3, `(√−3) = 𝔮₁𝔮₂`). W3 makes `g` on each `Λ₅`-coset a combination of the 21 local characters,
restrictions of `Θ_all` (restriction is bijective on 2-primary characters, the index being 81), and `1_{y+Λ₅}` has spectrum
`Ann(Λ₅)`: so `ĝ ⊆ Θ_all + Ann(Λ₅)`, `[Λ:Λ₅] = 81`: NT_{±3}. For `Λ₇`, two routes: (i) W1 on each `Λ₇`-component with NT for `|k| ≤ 3`
and G3 (`Θ_{|k|≤3}(Λ₇)` is exactly the 42 restrictions of `Θ_all`) gives `ĝ ⊆ Θ_all + Ann(Λ₇)`; (ii) with no computation: in
`χ = θ + ψ ∈ Θ_all + Ann(Λ₅)`, `ψ` is `a` on family 3's even vectors and `−a` on the odd ones, so `m₃(χ) = 2 Re(e(a)E)` with
`E = −1 + 2i·sin(2πt)`, `t ∈ ⅛ℤ` (each of the three cases of `θ ∈ Θ_all` at family 3 gives this form); `m₃(χ) = −2` with
`a = ±1/3` needs `sin(2πt) = ∓√3/2`, impossible at an eighth, so `a = 0`: `ψ` kills families `±3`, `ψ ∈ Ann(Λ₇)`. `[Λ:Λ₇] = 9`:
NT_{±4}.

**My C0 doubt resolved:** I expected the lemma to need more than the spectrum; it needs the coset-wise extension `G_z` (the step that
makes `G_z` tetrahedron-valued is `Λ_K + 8Λ = Λ`), and nothing else.

## §W5. The collapse — **proved** [hand + tools exact]

Assume NT for all nine families (every proper four-colouring of `Cay(Λ, U)`).
1. **`8Λ`-periodic:** W1 with `Θ_all` finite and `P(Θ_all) = 8Λ` (W2).
2. **Local at one prime, one chirality throughout:** `Θ_all` = 21 characters trivial on `P₊` + 21 trivial on `P₋`, none mixed (G2, exact).
   CRT: `Λ/8Λ ≅ Λ/P₊ × Λ/P₋`, so `g = G₊(x mod P₊) + G₋(x mod P₋)` and Lemma T makes one of them `0` — for the whole of `Λ`, one `ε`.
   The two primes are the two chiralities: `η ≡ 3ω (mod P₊)` and `η ≡ −3ω² (mod P₋)` (`ω = ζ₆²`, G4), so the Moser rotation `η²`
   acts as `ω²` at one prime and `ω` at the other — Hubai's "rotation by `k·arccos(5/6)` acts as `±k·120°`".
3. **Pair-linear.** *Stripe lemma (derived here):* a proper four-colouring of the triangular lattice `ℤ[ζ₆]` with NT_0 everywhere is
   striped. Each wheel's rim is `abcabc` (type O: all three diagonals monochromatic) or, up to rotation, `b c b d c d` (type P: exactly
   one monochromatic diagonal), these being the only proper 3-colourings of `C₆` with counts `(2,2,2)`. At a type-P point `x` with
   diagonal `±v` (colour `c`, centre `a`), writing `u, w` for the rim neighbours of `v` (`u + w = v`), the rim of `x + v` has `b` at its
   `−u` and `−w` positions and `a` at `−v`, which forces `(d, a, d)` on `+u, +v, +w`: `x + v` is type P along `v` again, so the line
   `x + ℤv` alternates `a, c`. A point of the next parallel line is adjacent to two consecutive points of this one, so avoids their two
   colours; induction gives every line parallel to `v` two-coloured, the pairs alternating with the line index: `pair = (line index mod 2)`,
   a homomorphism `ℤ[ζ₆] → 𝔽₂`. If every point is type O, `c(x + 2u) = c(x)`: the colouring factors through `ℤ[ζ₆]/2 = 𝔽₄` and is a
   bijection onto the colours (all pairs linear). *Descent:* the colouring factors through `Λ/P_ε`, and `ℤ[ζ₆] → Λ/P_ε` is onto
   (`ℤ[ζ₆] ∩ P_ε = 8ℤ[ζ₆]`, both quotients of order 64, G4), so the affine pair function descends to `Λ/P_ε` and lifts to an affine
   `Λ → 𝔽₂`; label so that `c(0)`'s pair is 0.
4. **Exactly 9,120 colourings of `Cay(Λ/8Λ, U)`, by derivation.** They are the `8Λ`-periodic colourings of `Cay(Λ, U)`
   (`U ∩ 8Λ = ∅`); each is local at exactly one prime (local at both is constant). `Λ/P₊ ≅ ℤ[ζ₆]/8 = R` and `U mod P₊` is exactly the 12
   classes `N₁ = {±1, ±3}·{1, ω, ω²}` (G4, exact, every class hit), so the count is `2·N`, `N` the number of proper four-colourings of
   `Q = Cay(R, N₁)`. By 3, each is pair-linear for some nonzero `β: R/2R = 𝔽₄ → 𝔽₂`; with `δ` the nonzero element of `ker β`, the
   within-pair edges are `N₁ ∩ (δ + 2R) = δ{±1, ±3}`, whose graph is 8 cosets of `δ·ℤ/8`, each `Cay(ℤ/8, odd) = K_{4,4}`, connected and
   bipartite. So the colourings pair-linear for `β` number `6 · 2⁸ = 1536` (3 splittings of the colours into pairs × 2 assignments ×
   a 2-colouring per component); a colouring pair-linear for two `β`s is a function of `x mod 2`, a bijection `𝔽₄ →` colours (24 of
   them), and those are pair-linear for all three. Inclusion–exclusion: `N = 3·1536 − 3·24 + 24 = 4560`; `2N = 9120`. ∎ No colouring
   was enumerated; the only computations are G4's reductions of the 54 unit vectors.
5. **`F = P = 8Λ`.** `F ⊇ 8Λ` by 1. For `P ⊆ 8Λ = P₊ ∩ P₋`: for `0 ≠ d ∈ R`, if `d ∉ 2R` the residue colouring separates `x, x + d`;
   if `d ∈ 2R`, choose `δ ∈ μ₃` with `d ∉ δ·ℤ/8` (the three lines `δℤ/8` meet only in 0), so `x` and `x + d` lie in different
   components of that `β`'s graph and independent flips separate them. Every such colouring is `8Λ`-periodic; translating puts the
   separated pair at `(0, d)`. Same at `P₋`.

## §W. The theorem — **proved, given (S″)** [hand + tools exact; the input is Parts's trees (prior art, walked as a certificate by the
FS-85 input audit, not by me)]

(S″) → W3 (each `Λ₅`-component local at one prime, `24Λ`-periodic) → W4 (NT_{±3} via `Λ₅`, then NT_{±4} via `Λ₇`) → W5: **every proper
four-colouring of `Cay(Λ, U)` is `8Λ`-periodic and local at one prime above 2; `F = P = 8Λ`; `Cay(Λ/8Λ, U)` has exactly 9,120 proper
four-colourings (4,560 at each prime).** Nothing of row 78's certificate is used: no solver output enters, and every computation is
on characters, lattices and the reductions of the 54 unit vectors. **The grade the chain reaches: proved given (S″)**, i.e. given
Parts's G481 refutation in the five orientations `η^k·G481`, `|k| ≤ 2`, all inside `Λ` with edges in `U` (§S). The one input
statement the brief wrote as (S′) — on the five-family graph — is not supplied by G481 and is not needed.

**Tools and plants for §W4–§W5:** `data/fs85/v2/w45_facts.py` (G1–G4); plants: (1) family 4 inside `Λ₅` → G1 fires; (2) `β̃²` for `β̃³`
→ G2's split (42, 21, 9) fires.

## Theorems this phase proved

*(filled as verdicts land)*
