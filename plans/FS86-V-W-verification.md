# FS-86 — verifier W: blind derivation of W-A, W-A1, W-B, W-C0, W-D₀

*Verifier W (Opus 5.5), briefed by the product owner (brief in the owner's scratch). Scratch only; nothing committed. Every
statement is scoped: **local** (the plane `𝒫 = Cay(L, T)` over `ℚ₂(√3)`), **global** (`Cay(R, U_F)` for a named `F`), **coset**,
or **K**.*

## Exposure log (what I had read before C0)

Read before C0, from disk: the brief; `CLAUDE.md` (in context: § Notation, G54, G55, G60, G66, G68, G71, G73, G75, G21, G30);
`plans/FS86-dyadic-rigidity.md` §0, §IQ, §S.1–S.4, stage-A records, §R-review; `plans/FS86-B1-verification.md` C1 (Lemma R,
V0–V4, V3-ram, Lemma P, Lemma D, VK); `LEDGER.md` rows 67, 75, 78, 85, 87; `plans/FS38-derivation.md` index head and §D-2
(D2-A, Lemmas 1–3, D2-B). **Not opened:** the competitor's working file or `SUCCESSOR-PREAMBLE.md`, any other scratch directory,
the close inventory, `git log`.

**Honest note on independence of C0.** C0 below was written after reading the five statements and the background above. While
reading, I formed in my head the routes I expected to use (for W-A: one forced pair from K placed in `𝒫`, the ideal it generates,
then D2-B; for W-C0: the pointwise bound `Σ ≥ −1/3` at non-unit distances). No derivation was written and no computation was run
before C0 was saved; the probabilities are informed by that mental first pass.

## C0 — predicted verdicts (saved before any written derivation or computation)

| statement | predicted verdict | p | the reason, in one line |
|---|---|---|---|
| W-A | **proved** | 0.85 | Place one forced pair from K inside `𝒫`. Rotations make the forced group an ideal of `ℤ[T] = O`. D2-B then lowers it to `𝔓⁴`. I expect it needs far less than VK (one forced pair, not the classification). |
| W-A1 | **proved** | 0.85 | (⇐) is W-A; (⇒) is B1's V2 + V3. |
| W-B | **proved** | 0.80 | Extend to open balls around `R`, get properness from the density of `R` in `O` and of `U_F` in `T`, place compactness forcers on the dense open set, and close by local constancy. |
| W-C0 | **scope repair** (proved at unit-distance scope; the "so" overreaches) | 0.55 (proved as stated 0.35; refuted 0.10) | The uniform-circle measure gives `Σ(z) = J₀(2πr₀|z|)`, which dips to −0.40276 < −1/3 at a non-unit distance. A tetrahedral field has `Σ ≥ −1/3` everywhere. I expect a repaired archimedean measure (an atom at 0 plus the circle at `j₁,₁`) to save the conclusion. |
| W-D₀ | **proved, with a non-degeneracy condition** (`h ≠ 0`) | 0.55 (proved as stated 0.35; refuted 0.10) | With `h = 0` and a constant threshold, `c = γ₁∘π` is proper whatever `γ₂` is. With `h ≠ 0` I expect a gap-freeness (tightness) argument at the wall. |

## C1 — the blind derivations

**Setting (mine).** `L = ℚ₂(ζ₁₂) = ℚ₂(√3)(i)`, `L⁺ = ℚ₂(√3)`, conjugation fixing `L⁺`, `i ↦ −i`. `L/L⁺` is **unramified** (`e(L/ℚ₂) = 2 =
e(L⁺/ℚ₂)`, `f` goes 1 → 2), so `v_𝔓|_{L⁺} = v_𝔭` and `𝔓^m ∩ L⁺ = 𝔭^m`. `O = ℤ₂[ζ₁₂]` (cyclotomic integers), ℤ₂-basis `1, ζ, ζ², ζ³`
(`ζ = ζ₁₂`). `T = {t : t t̄ = 1} = {x + iy : x, y ∈ L⁺, x² + y² = 1} ⊂ O^×`. `S_m := {z ∈ O/𝔓^m : z z̄ ≡ 1 (mod 𝔓^m)}`, and `P_m =
Cay(O/𝔓^m, S_m)` (row 67). **Forced group** of a graph on an abelian group `G` with connection set `C`: `F = {δ ∈ G : c(x) = c(x+δ) for
every proper four-colouring c and every x}`. A **P₄-pullback** on a coset `y + O` is `c(y + a) = γ(a mod 𝔓⁴)` with `γ` a proper
four-colouring of `P₄`.

### W-A — local rigidity — **PROVED** [hand + one certificate; scope: **local**, the plane `𝒫 = Cay(L, T)`, every proper four-colouring, arbitrary]

**Statement proved.** The components of `𝒫` are exactly the cosets `y + O`. Every proper four-colouring `c` of `𝒫` is on each
coset `y + O` a P₄-pullback, and `F(𝒫) = 𝔓⁴ = 4O`.

**Lemma W1 (`ℤ[T] = O`, elementary).** Here `ℤ[T]` is the ℤ-span of `T`, a ring because `T` is a multiplicative group.
- `ℤ[T] ⊆ O` because `T ⊂ O`.
- *`ℤ₂ ⊆ ℤ[T]`.* For `x ∈ 4ℤ₂`, `1 − x² ≡ 1 (mod 16)` is a square `y²` with `y ∈ ℤ₂ ⊂ L⁺`. So `t = x + iy ∈ T`, and `t + t̄ = 2x ∈ ℤ[T]`.
  Hence every element of `8ℤ₂` is in `ℤ[T]`, and `ℤ₂ = ℤ + 8ℤ₂ ⊆ ℤ[T]`.
- *All of `O`.* `ζ^k ∈ T` and `ℤ[T]` is a ring, so `ℤ₂ζ^k ⊆ ℤ[T]` for `k = 0, …, 3`, and `O = Σ ℤ₂ζ^k ⊆ ℤ[T]`.
- *Consequence.* `−1 ∈ T`, so the ℤ-span of `T` is its set of `±`-sums. So `Cay(O, T)` is connected, and the components of `𝒫`
  are the `O`-cosets.

**Lemma W2 (Hensel, standard).** For every `m ≥ 1`, the reduction `T → S_m` is onto.
- Take `z ∈ O` with `z z̄ ≡ 1 (mod 𝔓^m)`. Then `a = z z̄ ∈ 1 + 𝔭^m`, with `z` a unit.
- The norm of the unramified extension `L/L⁺` maps `1 + 𝔓^m` onto `1 + 𝔭^m` (Serre, *Local Fields* V §2). So `a = w w̄` with
  `w ∈ 1 + 𝔓^m`.
- Then `t = z/w` satisfies `t t̄ = 1` and `t ≡ z (mod 𝔓^m)`.

**Lemma W3 (the forced group is an ideal).** `F(𝒫)` is a subgroup of `L`:
- if `δ` and `δ′` are forced, then `c(x) = c(x+δ) = c(x+δ+δ′)`;
- if `δ` is forced, apply the forcing at the point `x − δ` to get `−δ`.

It is also `T`-stable. For `t ∈ T`, the map `x ↦ tx` is an automorphism of `𝒫` (because `tT = T`), so `c(t·)` is a proper colouring
and `c(tx) = c(tx + tδ)` for every `x`. So `F(𝒫)` is a `ℤ[T]`-module, which is an `O`-module by Lemma W1. Being a subgroup of `O`
(Lemma W4 below), it is an ideal of `O`.

**Lemma W4 (`F(𝒫) ⊆ 𝔓⁴`).**
- A `δ ∉ O` joins two different components, which are coloured independently, so it is not forced.
- For `δ ∈ O ∖ 𝔓⁴`: `P₄` is pairwise free at four colours (row 67, kernel `twoAdicFour_forces_iff`). So some proper colouring `γ`
  of `P₄` has `γ(0) ≠ γ(δ̄)`.
- Pull `γ` back: `c(y + a) = γ(a mod 𝔓⁴)` on every coset. This is proper on `𝒫`, since each `t ∈ T` reduces into `S₄`, and
  `t̄ ≠ 0` because `t` is a unit. It separates `(y, y + δ)`.

**Lemma W5 (one forced pair lies in `𝒫`).** `33 ≡ 1 (mod 8)`, so `11/3` is a square in `ℚ₂`, and `K = ℚ(√3, √11)` embeds in `L⁺`
(two embeddings, one for each dyadic place of `K`). Extend the embedding by `i ↦ i` to `K(i) → L`.
- It commutes with conjugation, so `U_K ↦ T`.
- De Grey's lattice `Λ = (1/9)O_E` (with `E = ℚ(√−3, √−11) ⊂ K(i)`) lands in `O`: 9 is a 2-adic unit and `O_E` is integral.
- Row 78's 2,044-point graph forces `(0, v)` at four colours, with `v = −(4/9)(1 + √−11)` **[cert, frozen checker
  `tools/fs73_cert_check.py`]**. Its image lies in `𝒫`, and the induced subgraph of `𝒫` on the image contains every edge of the graph.
  More edges can only shrink the set of colourings, so `(0, v)` is forced in `𝒫`, and by translation `v ∈ F(𝒫)`.
- `v_𝔓(v) = 6` at both dyadic primes of `K(i)` [PARI, exact: `wa_check.gp`; plant: `4 → 2` reads 4, and fires].
- Alternative source: row 85's `8 ∈ F(Λ)` [hand + tools exact, given Parts's trees], also of valuation 6.

**Proof of W-A.**
1. **The forced group reaches `𝔓⁶`.** By W3 and W5, `F(𝒫) ⊇ O·v = 𝔓⁶`.
2. **Each coset reads a colouring of `P₆`.** Fix a coset `y + O` and set `γ_y(a mod 𝔓⁶) := c(y + a)`. This is well defined by
   step 1. It is a proper colouring of `P₆`: an edge `ā ~ ā + s` with `s ∈ S₆` lifts to `t ∈ T` by Lemma W2, and `c(y+a) ≠
   c(y+a+t)`.
3. **D2-B lowers it to `P₄`.** By FS38-D2-B at `m = 6`, `γ_y` is `𝔓⁴`-periodic. D2-B rests on Lemmas 2–3, the level-4 spectrum and
   Hoffman's equality case; B1's independent build reproduces `H_min(P₆) = 4O`. So `γ_y = γ′ ∘ ρ_{6→4}`, where `γ′` is proper on
   `P₄` because `S₆` maps onto `S₄`. Hence `c(y + a) = γ′(a mod 𝔓⁴)`: a P₄-pullback.
4. **The forced group is exactly `𝔓⁴`.** Every colouring is `𝔓⁴`-periodic, so `F(𝒫) ⊇ 𝔓⁴`, and Lemma W4 gives equality.

The two forms in the statement are equivalent. The forced group being `𝔓⁴` makes every colouring `𝔓⁴`-periodic on each coset, and
Lemma W2 makes the induced map a proper colouring of `P₄`. Conversely, pullbacks on each coset give `F ⊇ 𝔓⁴`, and Lemma W4 gives
`F ⊆ 𝔓⁴`. ∎

**What W-A uses, graded.**
- One nonzero forced difference inside `𝒫`: row 78 [cert], or row 85 [hand + tools exact, given (S″)], or Harder's `8/3` [measured].
- Lemmas W1–W4 [hand, mine; W2 standard].
- D2-B at level 6 [hand, FS-38; not FS38-L1, whose defect does not touch D2-B's induction, as B1 showed].
- The kernel's pairwise freedom of `P₄`, for "exactly".

**No compactness, no measurability, no VK classification, and no V2 or V3.** Nothing about `ℚ(√59)` enters: W-A is a statement
about `ℚ₂(√3)` alone.

*Adversarial attempts, by formula.*
- **(a) Read a finer level on a small ball.** Take `c = γ∘π₄` off `B = a₀ + 𝔓^{10}` and `c = γ′∘π₄` on `B`, with `γ′(ā₀) ≠ γ(ā₀)`.
  Every neighbour of a point of `B` lies off `B`, since `t` is a unit. So properness asks `γ′(ā₀) ∉ γ(N_{P₄}(ā₀))`. `P₄` is
  four-tight, so `γ` has no fan gap (D2-A (iv)) and `γ(N(ā₀))` is every colour except `γ(ā₀)`. That forces `γ′(ā₀) = γ(ā₀)`, a
  contradiction. The attempt fails at P₄'s gap-freeness, which is step 3 in miniature: `c` would be a colouring of `P₁₀` that is
  not `𝔓⁴`-periodic.
- **(b) A non-measurable wall.** Take a ℚ-linear `λ : L → ℝ` (a Hamel functional, discontinuous) and set `c = γ₁∘π₄` where `λ < 0`,
  `γ₂∘π₄` elsewhere, with `γ₁ ≠ γ₂`. Whatever `λ` is, W-A's proof kills it. Place the 2,044-point forcer at any point `x` and at every
  rotation: `c(x) = c(x + tv)` for all `t ∈ T`, so `c` is `𝔓⁶`-periodic. Then D2-B makes it `𝔓⁴`-periodic, which forces `γ₁ = γ₂`
  on every residue class that the wall meets on both sides.
  (When `λ` takes both signs on `T` inside each residue class, the descent argument of W-D₀ below gives the same conclusion without
  the forcer. I do not claim that property for an arbitrary Hamel functional.) Both attempts fail where they must. **No counterexample by formula.**

### W-A1 — the extension form — **PROVED** [hand; scope: **global**, `F = ℚ(√59)` (and 83, 131), each `R`-coset of `F²`]

**Setting.**
- `R = ℤ[U_F] = O′` is integral at the stable prime above 2 (B1, Lemma R). So the unique dyadic place gives `R ⊂ O` with `U_F ⊂ T`.
- For `r, r′ ∈ R`: `r − r′ ∈ T ⟺ r − r′ ∈ U_F`, because the difference lies in `F(i)` and has norm 1. So `Cay(R, U_F)` is the
  **induced** subgraph of `Cay(O, T)` on `R`.
- A colouring of `F²` is a colouring `c_y(r) = c(y + r)` on each coset `y + R`.

**(⇐), from W-A alone.** Suppose every colouring of `Cay(R, U_F)` has an extension `C` to `Cay(O, T)`.
- By W-A, `C` is a P₄-pullback, so `c(r) = C(r) = C(r + δ) = c(r + δ)` for every `δ ∈ R ∩ 𝔓⁴`.
- So `F(R) ⊇ R ∩ 𝔓⁴ ∋ 4 ≠ 0`.
- This direction holds for **every** real `F` with an embedding `F ⊂ ℚ₂(√3)` (so also ℚ(√11) and K). Neither V2 nor V3 is used.

**(⇒), from B1's V2 + V3.** Suppose `F(R) ≠ 0`.
- V2 gives `F(R) = P(R)`, so every colouring is periodic.
- V3 gives that every colouring is `c_y = γ ∘ π₄` along `R → O/𝔓⁴`, with `γ` proper on `P₄`.
- Then `C := γ ∘ π₄` on `O` is proper, since `T` maps into `S₄`, and it extends `c_y`.

So **`F(R) ≠ 0 ⟺ every colouring extends ⟺ every colouring is a P₄-pullback`**. ∎

**What (⇒) needs.** V3, and through it FS-66's certificate at 11 and `[Zhang2012]` Thm 1.8. That is B1's grade, not mine.

*Adversarial attempt (the transfer).* ℚ(√11) is in the same dyadic tower and has `F(R′) = 0` (row 66). So by (⇐) some colouring
does not extend, and there is an explicit one: `c(z) = β(z mod 7)` with `β` a proper colouring of `Γ₇`.
- If it extended, W-A would make it `4`-periodic.
- But `4` is a unit mod 7, so translation by `4` moves the 7-adic coordinate, and `β(w) = β(w + 4·e₁)` for all `w` would make `β`
  constant on the horizontal lines of `𝔽₇²`.
- Those lines contain edges (`e₁ = (1, 0)` is a unit vector). Contradiction.

Consistent: this is the transfer failing where it must (C3).

### W-B — a continuous colouring is a pullback — **PROVED** [hand; scope: **global**, `Cay(R, U_F)` for ℚ(√59), and every real `F ⊂ ℚ₂(√3)` whose `R` is dense in `O` and whose `U_F` is dense in `T`]

**Hypothesis.** Each `z ∈ R` has an `N_z` with `c` constant on `R ∩ B(z, N_z)`, where `B(z, n) := z + 𝔓^n`.

**Density inputs.** `R` is dense in `O`, and `U_F` is dense in `T` (B1, Lemma R(4): the Cayley parametrisation `t ↦ (1+it)/(1−it)`
and weak approximation). Both hold for `ℚ(√59)`.

**Step 1 (the extension).** Put `U := ⋃_{z ∈ R} B(z, N_z)`: open, and dense because it contains `R`. Set `G(y) := c(z)` for any
`z ∈ R` with `y ∈ B(z, N_z)`.
- *Well defined.* Two 2-adic balls that meet are nested (ultrametric). So if `y ∈ B(z, N_z) ∩ B(z′, N_{z′})`, one ball contains the
  other, say `B(z′, N_{z′}) ⊆ B(z, N_z)`. Then `z′ ∈ R ∩ B(z, N_z)`, and `c(z′) = c(z)`. No density is needed here.
- `G` is constant on each ball `B(z, N_z)`, so it is locally constant on `U`, and `G|_R = c`.

**Step 2 (`G` properly colours `𝒫[U]`). This is the step the brief asks me to scrutinise, and it holds.**
- Let `y, y + t ∈ U` with `t ∈ T`, `y ∈ B(z, N_z)` and `y + t ∈ B(z′, N_{z′})`. Put `n = max(N_z, N_{z′})`.
- By density pick `w ∈ R ∩ B(y, n)` and `u ∈ U_F ∩ B(t, n)`.
- Then `B(y, n) ⊆ B(z, N_z)`, since `y` lies in the latter and `n ≥ N_z`. So `w ∈ R ∩ B(z, N_z)` and `c(w) = G(y)`.
- Likewise `w + u ∈ R ∩ B(y + t, n) ⊆ B(z′, N_{z′})`, so `c(w + u) = G(y + t)`.
- `u ∈ U_F`, so `c(w) ≠ c(w + u)`. **Both densities are used, and nothing else.**

**Step 3 (the forcers fit into `U`).**
- *A finite forcer exists.* For `δ ∈ R ∩ 𝔓⁴`, W-A says `(0, δ)` is forced in `𝒫`. The kernel's `forces_iff_exists_finite` (stated for
  any graph) gives a finite `X_δ ∋ 0, δ` on which `(0, δ)` is forced in `𝒫[X_δ]`.
- *Without compactness.* `X_δ` can also be built explicitly: representatives of `O/𝔓⁶`, one lift in `T` for each edge of `P₆`
  (Lemma W2), and finitely many copies of the 2,044-point forcer to join each lift to its representative. W-A's proof then runs on
  that finite set.
- *The copies fit.* `V_δ := {y : y + X_δ ⊆ U} = ⋂_{x ∈ X_δ} (U − x)` is a finite intersection of open dense sets, so it is open and
  dense.
- For `y ∈ V_δ`, `G` is proper on `𝒫[y + X_δ] ≅ 𝒫[X_δ]` by Step 2, so `G(y) = G(y + δ)`.

**Step 4 (close by local constancy).** For `z ∈ R`, take `n ≥ N_z, N_{z+δ}` and a point `y ∈ V_δ ∩ B(z, n)`. Then `G(y) = c(z)` and
`G(y + δ) = c(z + δ)`, so `c(z) = c(z + δ)`. Hence `c` is `(R ∩ 𝔓⁴)`-periodic. It factors through `R/(R ∩ 𝔓⁴) = O/𝔓⁴`, which is
onto by density. The factor is proper on `P₄`, because `U_F` maps onto `S₄` (density of `U_F` in `T`, then Lemma W2). ∎

**What it rests on.** W-A, both densities, and compactness (kernel), or the explicit finite forcer. **"At every point" is used in
Step 4 at both `z` and `z + δ`.** A colouring locally constant only on a dense subset of `R` is not covered.

*Adversarial attempts.*
- **(a) ℚ(√11).** `β(z mod 7)` is a colouring that is not a P₄-pullback. **Where the hypothesis fails:** `R′` is dense in `O × ℤ₇²`
  (CRT on `R′/(2^k·7)R′`), so every 2-adic ball meets every 7-residue, and `c` is locally constant at no point. W-B is not
  contradicted.
- **(b) K.** A colouring pulled back at `𝔓₂` (VK) is not locally constant at `𝔓₁`, for the same reason: `R_K` is dense in
  `O_{𝔓₁} × O_{𝔓₂}`. The hypothesis is not met.
- **(c) A colouring locally constant at a large finite level `N_z = 10`**, but not `𝔓⁴`-periodic, would be a colouring of `P₁₀` that
  is not `𝔓⁴`-periodic. D2-B rules it out.

No counterexample.

### W-C0 — the Bessel obstruction — **PROVED as literally stated (unit-distance data); GAP in the "so" step (the stated measure fails the pointwise pair law); REPAIRED by a different archimedean measure** [hand + mpmath (40 digits; the grid scan a float check) + classical facts; scope: **global**, every real field `F ⊂ ℝ`, `G = F(i)` or `R`]

**Setting.**
- A stationary random proper four-colouring of `Cay(G, U_F)`, with `g = e_{c(·)}` its tetrahedral field: `|e_a| = 1` and
  `e_a·e_b = −1/3` for `a ≠ b`.
- `Σ(z) = E[g(0)·g(z)]` is positive definite, since `Σ a_j ā_k Σ(z_k − z_j) = E Σ_ℓ |Σ_j a_j g_ℓ(z_j)|² ≥ 0`. So by Herglotz–Bochner
  on the discrete group `G`, `Σ = μ̂` for a probability measure `μ` on `Ĝ`.
- Properness gives exactly `Σ(u) = −1/3` for every `u ∈ U_F`.
- Pointwise, `g(0)·g(z) ∈ {1, −1/3}`, so **`−1/3 ≤ Σ(z) ≤ 1` at every `z`**.
- *Archimedean characters:* `χ_α(z) = e(Re(ᾱ σ₁ z))`, with `σ₁ : F(i) ⊂ ℂ`.
- *Pinning*, for this record, means `μ` supported on torsion characters (the dual of a finite-index subgroup, which is what
  periodicity needs).
- For `α ≠ 0`, `χ_α` is **not** torsion on `R`: `σ₁(R) ⊇ ℤ[1/p] + iℤ[1/p]` for a non-stable `p` is dense in `ℂ`, so
  `Re(ᾱσ₁R)` is dense in `ℝ`, not inside `(1/N)ℤ`.

**(A) The literal statement — proved.**
- Let `μ₀` be uniform on `{χ_α : |α| = r₀}`. Then `μ̂₀(z) = (1/2π)∫e^{2πi r₀|z| cos θ} dθ = J₀(2πr₀|z|)`.
- Every unit vector of a real field has `|σ₁u| = 1`, so `μ̂₀(u) = J₀(2πr₀) = −1/3` on all of `U_F`, and `μ̂₀(0) = 1`.
- `min J₀ = J₀(j₁,₁) = −0.402759395702553`, so `J₀(x) = −1/3` has roots `x = 3.252420888432` and `x = 4.442692268485`, that is,
  `r₀ = 0.5176388614` or `0.7070764352` [mpmath].
- So the unit-distance equalities, with positivity, are met by a purely archimedean spectrum on every real field plane. ∎

**(B) The defect in "so pair correlations alone can never pin".**
- `μ̂₀(z) = J₀(2πr₀|z|)` reaches `−0.40276 < −1/3` at `|z| = j₁,₁/(2πr₀)`: `1.1781089` for the first root, `0.8624739` for the second.
- `F(i)` is dense in `ℂ` and `J₀` is continuous, so `Σ < −1/3` at some `z ∈ G`.
- So **`μ₀` is the spectrum of no stationary random four-colouring**. It meets the unit-distance data and violates the pair law
  `P(c(0) = c(z)) ≥ 0` off the unit circle.
- The conclusion does not follow from the measure stated.

**(C) The repair — proved.** Put `m = −J₀(j₁,₁)` and `w = (m − 1/3)/(1 + m) = 0.0494924949937`, and take
`μ₁ = w·δ_{χ₀} + (1 − w)·uniform{χ_α : 2π|α| = j₁,₁}`. Then:
1. `Σ(s) = w + (1 − w)J₀(j₁,₁ s) ≥ w − (1 − w)m = −1/3`, with **equality iff `s = 1`**. The global minimum of `J₀` on `[0, ∞)` is
   attained only at `j₁,₁`, because the extremal values `|J₀(j₁,ₖ)|` strictly decrease. That is classical (Watson §15.31, Sonine's
   lemma); checked here: `J₀(j₁,ₖ) = −0.40276, +0.30012, −0.24970, +0.21836, −0.19647`.
2. It meets **every two-point constraint**. Colour-symmetric pair laws `M_z(a, a) = (1 + 3Σ)/16` and `M_z(a, b) = (1 − Σ)/16` have
   entries `≥ 0` iff `Σ ∈ [−1/3, 1]`, and marginals `1/4`. `M_0` is `diag(1/4)`, and `M_u` has zero diagonal at unit `u`.
   `z ↦ M_z = J/16 + Σ(z)(4I − J)/16` is a positive-definite matrix kernel, since `4I − J ⪰ 0` and `Σ` is positive definite.
3. Its mass off the torsion characters is `1 − w ≈ 0.95`.

[mpmath: `Σ(1) + 1/3 = 0` to 40 digits. A float grid on `s ∈ [0, 60]` has its minimum `−1/3` at `s = 1`; for `s > 60`,
`|J₀| < 0.06`. **Plant `w = 0` fires.** Script `wc0_check.py`, exit 0.]

So **with every two-point constraint imposed, the pair data still admits a spectrum with 95 % of its mass on non-torsion
archimedean characters. The conclusion "pair correlations alone cannot pin the spectrum" holds**, by `μ₁`, not by the stated `μ₀`.

**Prior art.**
- `μ₁` is the dual extremiser of the theta-type bound for the measurable independence ratio of the unit-distance graph of `ℝ²`:
  `m/(1 + m) = 0.28712`, and `(w + 1/3)·3/4 = 0.287119` here. See `[BachocEtAl2009]` and `[OliveiraVallentin2010]`, held; not
  re-read for this verdict.
- The same numbers are G60's `−0.40276` and `χ_f ≥ 3.48 = 1/0.2871`.
- The row-87 no-go (C14 on `Λ_dG`) is the torsion-character instance; W-C0 is the archimedean one, valid on every real field.

**Not addressed** (outside "pair correlations" as defined here): inequalities on pair data that follow from three-point
consistency, such as the triangle inequalities `q(x−y) + q(y−z) − q(x−z) ≤ 1` or `[KMOR2016]`'s strengthenings. Whether those
exclude every non-torsion spectrum is **open here**. It is the next format to test (G73's averaged route at radius ≥ 2).

*Adversarial attempt.* Could the full two-point law force every admissible spectrum onto torsion characters? No: `μ₁` is admissible
and has only the trivial torsion atom. That atom is compatible with every period and pins nothing.

The same computation gives an *upper* bound `w ≤ (m − 1/3)/(1 + m)` on the trivial atom of any radial archimedean solution (from
`Σ(1) ≥ w − m(1 − w)`). Whether an atom-free archimedean solution exists I **do not claim either way**, and nothing above needs it.

### W-D₀ — no threshold walls — **PROVED under `h ≠ 0`; REFUTED as written without it (counterexample `h = 0`)** [hand; scope: **global**, every real `F` with a stable dyadic place whose local plane is `𝒫` — ℚ(√59), ℚ(√83), ℚ(√131), **and ℚ(√11) and K**; every `N ≥ 1`]

**Data.**
- `γ₁, γ₂` are proper four-colourings of `P_N`.
- `h : R → ℝ` is additive.
- `Q = R/I` with `I` of finite index and `I ⊆ R ∩ 𝔓^N`, so `π = π_N` factors through `Q`.
- `ε : Q → ℝ`, and `c(z) = γ₁(πz)` if `h(z) < ε(z̄)`, else `γ₂(πz)`.
- `Ū` denotes the image of `U_F` in `Q`.

**Counterexample without a hypothesis on `h`.** Take `h = 0` and `ε ≡ 1`. Then `c = γ₁ ∘ π`, which is proper for every `γ₂ ≠ γ₁`. The
statement needs `h ≠ 0` (or "both branches meet some class", which for additive `h` is the same thing).

**Three density facts** (for `h ≠ 0`).
- **(F1) Unit vectors of both signs in every class.** In every class `ū ∈ Ū` there is a `u ∈ U_F` with `h(u) < 0`.
  - `h` extends ℚ-linearly, and continuously, to `F(i) ⊗ ℝ`.
  - `∏_{v|∞} T(F_v)` spans `F(i) ⊗ ℝ` over ℝ: a circle spans `ℂ`, the curve `{(t, t⁻¹)}` spans `ℂ²`, and products of spanning sets
    span. So `h ≠ 0` somewhere on that product, and `−1 ∈ T` gives both signs.
  - Weak approximation for the rational torus `T` holds at the archimedean places and at the finitely many stable primes
    dividing `[R : I]`. Those primes fix the class, because `R/nR = ∏_{𝔔 | n} O_𝔔/n` (B1, Lemma R(b)).
- **(F2) `h` is dense on every class.** `h(R) ⊇ ℤ`-span of `h(U_F)`, and `h(U_F)` is dense in an interval around 0 by (F1), so
  `h(R)` is dense. Then `h(I) ⊇ n·h(R)` is dense.
- **(F3) The quotient's edges cover `P_N`'s.** `π(Ū) = S_N`: `U_F` is dense in `T`, and Lemma W2 applies.

**Lemma D0-1 (a cross edge from branch 2 to branch 1).** If `c` is proper, then for every `q ∈ Q` and every `ū ∈ Ū` with
`ε(q) ≤ ε(q + ū)`: `γ₂(πq) ≠ γ₁(πq + πū)`.
- Take `u ∈ ū` with `h(u) < 0` (F1). The interval `J = [ε(q), ε(q + ū) − h(u))` then has positive length.
- Take `z ∈ q` with `h(z) ∈ J` (F2). Then `z` is on branch 2, and `z + u ∈ q + ū` is on branch 1, since
  `h(z + u) < ε(q + ū)`.
- `z ~ z + u`, so `γ₂(πz) ≠ γ₁(πz + πu)`. ∎

**Theorem.** If `h ≠ 0` and `c` is proper, then `γ₁ = γ₂`.

*Proof.* Suppose `D = {a : γ₁(a) ≠ γ₂(a)}` is non-empty. Take `q₀ ∈ Q` over some `a₀ ∈ D`; the map `Q → O/𝔓^N` is onto. Given `q_k`
over `a ∈ D`, build the next point as follows.
1. **A neighbour carrying the other colour.** Put `κ = γ₂(a) ≠ γ₁(a)`. `P_N` is four-tight at every level (row 67; B1, Lemma D),
   so by D2-A (iv) `γ₁` has no fan gap. So some neighbour `a′ = a + s`, with `s ∈ S_N`, has `γ₁(a′) = κ`.
2. **The threshold must drop.** Lift `s` to `ū ∈ Ū` (F3). If `ε(q_k) ≤ ε(q_k + ū)`, Lemma D0-1 gives `κ = γ₂(a) ≠ γ₁(a′) = κ`,
   which is absurd. So `ε(q_k + ū) < ε(q_k)`.
3. **The neighbour is also a disagreement.** `γ₂(a′) ≠ γ₂(a) = κ = γ₁(a′)`, so `a′ ∈ D`.
4. **Recurse.** Put `q_{k+1} = q_k + ū`.

The values `ε(q_k)` strictly decrease forever inside the finite set `ε(Q)`, which is impossible. So `D = ∅`. ∎

**What it uses.** Only four inputs:
- `γ₁`'s gap-freeness on `P_N`, that is, the tightness of the dyadic tower;
- `π(Ū) = S_N`;
- the two density facts.

It does **not** use V3, W-A, or any property of the odd places. So it holds on ℚ(√11), where `F(R) = 0` (row 66), and on K at
either dyadic place.

**Consequence for the milestone (the scope finding).** W-D₀ is a no-go of one *format* of non-periodic colouring, a dyadic
threshold wall. It holds equally on a field with `F = 0`, so **it cannot by itself decide `F(R)` for ℚ(√59)**. ℚ(√11)'s
non-periodic colourings come from `Γ₇`'s gaps, not from dyadic walls. At ℚ(√59) no stable place has a gapped four-colourable
level (V3's list), so the mechanism that frees ℚ(√11) is absent. Any non-periodic colouring of ℚ(√59) would have to be of a third
kind, neither a dyadic wall nor an odd-place gap.

*Adversarial attempts, by formula.*
- **(a) Kill one cross direction on every edge.** Take `ε = M·φ` with `φ` injective and `M` far above `sup|h(U_F)|`. Then each
  edge carries only one cross constraint. The descent above needs only the one that fires, from the lower `ε` to the higher, and
  it still kills the wall.
  - Equivalently: sweeping a threshold `θ` gives colourings `Ψ_θ = (γ₂ below θ, γ₁ above)` of the `Q`-graph, each proper.
  - They change one vertex at a time.
  - Each change at a disagreement vertex would need a fan gap in `γ₁`.
- **(b) Hide the wall in a gapped odd factor.** Put `Γ₇` into `Q` over ℚ(√11) and let `ε` read the 7-adic coordinate. It still
  dies, because the descent uses `γ₁`'s gap-freeness on `P_N`, never the gap-freeness of `Q`'s own colourings.

No counterexample with `h ≠ 0`.

## C2 — comparison with the competitor's working file (opened only after every C1 verdict above was saved)

Read: `FS86-C-deBruijn.md` §1.1–§1.4, §4.1 and §6.1, and nothing else there; `SUCCESSOR-PREAMBLE.md` was not opened.

**No divergence of truth on the five theorems as the competitor proves them.** Two scope errors in surrounding claims (D3, D8), and
one missing hypothesis (D7), which the competitor's own proof needs. The full list follows.

| # | where | kind | the divergence | resolution |
|---|---|---|---|---|
| D1 | §1.2 step 1 vs my W5 | **route / input (substantive)** | The competitor gets `4 ∈ F_loc` from VK (`F(R_K) = 4R_K`) and compactness. So W-A is graded "given VK", which pulls in V2, FS-66's certificate at 11 (K's ramified 11-towers) and `[Zhang2012]`. I use only row 78's forced `v` (`v_𝔓(v) = 6`, PARI), the ideal it generates (`𝔓⁶`) and D2-B at level 6. | **Resolved: both routes are sound, and mine has strictly fewer inputs.** W-A's grade should read "[hand + cert (row 78) or given (S″) (row 85); D2-B]", not "given VK". The competitor's route avoids D2-B for the `⊇` half; mine avoids VK. |
| D2 | §1.2 steps 3–4 vs my W1 | route | The open set comes from the analytic submersion theorem at `(1, i)` in the competitor's file; mine is elementary (`x ∈ 4ℤ₂ ⟹ 1 − x²` is a square, so `2x ∈ ℤ[T]`, so `ℤ[T] = O`). I re-checked the competitor's differential: the tangent space at `i` is `ℚ₂(√3)`, so the image is `L`. Correct. | Resolved; both fine. Mine also gives the connectivity of `Cay(O, T)` directly. The competitor's "`𝒫` is a disjoint union of copies of `Cay(O, T)`" leaves connectivity implicit; it follows from `F_loc ⊇ 4O` together with `F_loc ⊆ ℤ`-span(`T`). |
| D3 | §1.2 step 5 | citation | "FS38-D2-B gives a `P_m` colouring separating `0` and `δ`." Separation is `P₄`'s pairwise freedom (row 67, the kernel's `twoAdicFour_forces_iff`, or D2-B's corollary (2), which rests on the level-4 tables), not D2-B's periodicity. | Resolved: re-cite. No truth issue. |
| D4 | §1.3, second paragraph | **scope, a false sentence** | "The same statement holds for K (where the answer is yes, VK)", and the parenthetical scope "any `F ⊂ ℚ₂(√3)` with `R_F` dense in `O` and `U_F` dense in `T`". **False for K along a fixed embedding.** Take `ι₁` at `𝔓₁` and `c = γ(z mod 𝔓₂⁴)`, a VK colouring at the other prime. An extension along `ι₁` would be `(R_K ∩ 𝔓₁⁴)`-periodic by W-A. But `R_K ∩ 𝔓₁⁴` maps **onto** `O_{𝔓₂}/𝔓₂⁴`, because `R_K` is dense in `O_{𝔓₁} × O_{𝔓₂}` (B1, Lemma R(4)). So `γ` would be constant. So `F(R_K) ≠ 0` while some colouring does not extend along `ι₁`. | **Escalated as a scope correction.** Corollary A1 holds for the fields with one dyadic place where V3 holds (59, 83, 131); the (⇒) direction cites V3, which is proved only there. For K the correct form is "extends along `ι₁` or `ι₂`, chosen per coset". "K's plane inherits the rigidity" should read "each coset of K's plane inherits it from one of its two dyadic embeddings". |
| D5 | §1.4 | none | The same proof as mine: nested balls, density for properness, open dense placement of the forcers, local constancy. The competitor's closing step (an open set missing a dense set is empty) is my Step 4. The hypothesis names only `U_F` dense in `T`; the density of `R` in `O` follows, since the closure of `ℤ[U_F]` contains the closure of `ℤ[T] = O`. | Agree. The competitor's "Reading" (a pullback on the continuity set whenever that set is dense) is **provable** by the same proof: the open set `U` built from the dense continuity set, `γ` defined on every `𝔓⁴`-class, and properness by `U ∩ (U − t)` being dense. I checked it. |
| D6 | §1.2 vs §1.4 | wording | "no compactness argument is needed" (§1.2) against "Theorem A's proof supplies (compactness) a finite forcer" (§1.4). | Harmless: compactness enters only in the countable graph `K²` (§1.2 step 1). Mine lists both routes. |
| D7 | §6.1, the statement and step 3 | **missing hypothesis `h ≠ 0`** | The statement "c is proper only if `γ₁ = γ₂`" is false at `h = 0` (take `ε ≡ 1`, `c = γ₁∘π`). The proof's "`ε(y) − ε(x) ≤ −ρ`, i.e. `ε(y) < ε(x)`" needs `ρ > 0`, which is exactly `h ≠ 0`. `h ≠ 0` appears only in the preamble's bullet. | **Resolved: add `h ≠ 0` to the statement.** With it, my proof and the competitor's are **the same descent**, found independently: my C0 predicted "a gap-freeness argument at the wall" before I read anything. |
| D8 | §6.1, the first two bullets | scope | "Every additive `h` is `Re(ᾱ₁σ₁·) + Re(ᾱ₂σ₂·)`, since `R ⊗ ℝ = ℂ²`", and "On a real field `h(U_F)` is bounded". Both hold for real **quadratic** `F`. For K (degree 4) there are four terms. For a non-totally-real `F ⊂ ℝ`, `h(U_F)` is **unbounded**, because a unit vector's image at a complex place of `F` is not on a circle. | Harmless to the theorem: an unbounded `h` makes step 2 fire on every edge, and walls die at once, as the competitor says for non-real fields. My (F1) covers every real `F` uniformly by a spanning argument. Correct the two bullets' scope to "totally real". |
| D9 | §6.1, "What it kills" | reading | The competitor presents D₀ as killing "the one way the real place's compact circle could be exploited", aimed at ℚ(√59). My derivation shows the proof uses no odd place and no W-A, so **it holds verbatim on ℚ(√11), where `F(R) = 0`**. | Not a truth divergence; the conclusion should say so. D₀ is a no-go of a format. It excludes one kind of non-periodic colouring on every field of this dyadic tower, including one where non-periodic colourings exist, so it cannot by itself move `F(R)` for ℚ(√59). ℚ(√11)'s non-periodic colourings are odd-place gap colourings, which ℚ(√59) lacks (V3). |
| D10 | §4.1 vs the brief's paraphrase | scope, **the brief's, not the competitor's** | The competitor's conclusion is scoped correctly: "no argument that uses **only the unit-distance** pair correlations can prove … periodic". The brief's paraphrase ("pair correlations alone can never pin") drops "unit-distance". My C1 "gap in the 'so' step" was against the paraphrase. The stated `μ₀` does violate `Σ ≥ −1/3` off the unit circle (−0.40276 at `|z| = 1.178` or `0.862`), so it could not support the stronger claim. | **Resolved in the competitor's favour on truth.** My repaired measure `μ₁` (atom `w = 0.04949` at the trivial character, circle at `2π|α| = j₁,₁`) **extends** the no-go: with every two-point constraint imposed (pointwise range, the pair laws, the positive-definite matrix kernel), the spectrum still cannot be pinned. That is worth recording with the no-go, since a certificate might have tried to add `Σ ≥ −1/3` at other distances. Three-point-derived inequalities stay open. |
| D11 | §4.1 | a detail | The competitor's "least circle mean −0.3996 at 11" is `λ_min(Γ₁₁)/12 = −4.795754778/12 = −0.39965`, matching B1's exact table. | Agree. |

**Tally.** Five statements. None divergent in truth as the competitor states and proves them, with two exceptions: W-D₀'s
statement is missing `h ≠ 0` (D7), and §1.3 carries a false side sentence about K (D4). Divergences of route: D1, D2, D6. Of scope:
D3, D4, D8, D9, D10. Escalated to the owner: D4 (a sentence to correct before anything is filed), D1 (W-A's grade), and D7 (the
statement).

## C3 — scope

**What W-A needs from VK: one nonzero forced difference placed in `𝒫`, not the classification.**
- **Needed:** any `δ ≠ 0` in `O` forced by a finite unit-distance graph inside `ℚ₂(√3)²`. Row 78's certified `v` suffices
  (`v_𝔓(v) = 6`), as do row 85's `8` and Harder's `8/3` (measured). Also D2-B at level 6, and `P₄`'s kernel pairwise freedom for
  "exactly".
- **Not needed:** VK's statement `F(R_K) = 4R_K`, V2, V3, FS-66's certificate, `[Zhang2012]`, and compactness in the uncountable
  graph.
- **Using VK's `4` instead** (the competitor's route) trades D2-B, in the `⊇` direction, for all of VK's inputs.
- **Either way the input needs `√3`.** De Grey's lattice `(1/9)O_E`, with `E = ℚ(√−3, √−11)`, is built on triangles.

**W-A on ℚ(√11)'s plane, restricted from `𝒫`.**
- *The plane embeds.* ℚ(√11) is in the same dyadic tower (`11 ≡ 3 mod 8`), so its plane `Cay(R′, U′)` embeds in `𝒫`. Every colouring
  of `𝒫` restricts to a P₄-pullback on it. **So W-A holds for the restricted colourings.**
- *It has more colourings.* Its colouring space is strictly larger: `β(z mod 7)`, with `β` a four-colouring of `Γ₇`, is proper and
  not a pullback (W-A1's adversarial attempt), and `F(R′) = 0` (row 66). W-A is a statement about `𝒫` only.
- **The step that fails in the transfer is W5,** the existence of a nonzero forced difference inside the global plane. The forcer
  uses `√3` (`ω`, triangles), and `√3 ∉ ℚ(√11)`; indeed ℚ(√11)'s plane is triangle-free (G57), and no finite subgraph of it forces
  any pair (row 66).
- *What does transfer.* The remaining steps of W-A transfer verbatim to any global plane: the ideal property (W3 → V2's
  `F(R) ⊲ R` with finite index) and the lowering by D2-B.
- *A second failure at ℚ(√11).* V3 fails there too: its periodic colourings include `Γ₇`-pullbacks, so W-A1's (⇒) has no analogue.
- **At ℚ(√59) V3 holds, so W5 is the only missing step.** The milestone's question is exactly W-A's step 1 at the global field: is
  some pair forced by a finite triangle-free unit-distance graph over ℚ(√59)?

**Every result stated at its exact scope.**

| result | scope |
|---|---|
| W-A | local, `𝒫` over `ℚ₂(√3)` |
| W-A1 | global, ℚ(√59), 83, 131, per `R`-coset; (⇐) for every real `F ⊂ ℚ₂(√3)`; K only with the embedding chosen per coset (D4) |
| W-B | global, every real `F ⊂ ℚ₂(√3)` whose `U_F` is dense in `T`, per coset |
| W-C0 | global, every real field; literal at unit-distance data, extended by `μ₁` to all two-point data |
| W-D₀ | global, every real `F` with the dyadic tower `P_N`, with `h ≠ 0`; it does not separate ℚ(√59) from ℚ(√11) |

## C4 — Theorems this phase proved

- **W-A: the plane over `ℚ₂(√3)` is four-colour rigid.** Every four-colouring is a P₄-pullback on each coset of `O`, and
  `F(𝒫) = 4O`.
  - *Grade:* [hand + cert].
  - *Inputs:* row 78's certificate (or row 85, given (S″)), FS38-D2-B at level 6, and row 67's kernel pairwise freedom.
  - *Proof:* this record, § W-A, Lemmas W1–W5.
  - *Scope:* local.
- **W1: `ℤ[T] = O`.** The ℤ-span of the norm-one units of `ℚ₂(ζ₁₂)` is its ring of integers, so `Cay(O, T)` is connected.
  - *Grade:* [hand, elementary].
  - *Proof:* § W-A.
- **W-A1: the extension form.** For ℚ(√59), 83, 131, `F(R) ≠ 0` ⟺ every colouring extends to `𝒫` ⟺ every colouring is a
  P₄-pullback. (⇐) holds for every real `F ⊂ ℚ₂(√3)`.
  - *Grade:* [hand; (⇒) at B1's grade: V2, V3].
  - *Proof:* § W-A1.
- **W-A1 at K, with a fixed embedding: false.** A `𝔓₂`-pullback does not extend along `ι₁`.
  - *Grade:* [hand].
  - *Proof:* C2, D4.
- **W-B: 2-adically locally constant colourings are P₄-pullbacks.** The same proof gives agreement with one pullback on the
  continuity set whenever that set is dense (the competitor's reading, checked).
  - *Grade:* [hand, given W-A].
  - *Proof:* § W-B; C2, D5.
  - *Scope:* global, per coset.
- **W-C0: pair correlations cannot pin the spectrum.**
  - (A) Unit-distance data admit the archimedean `μ₀`. *Grade:* [hand + mpmath].
  - (B) `μ₀` violates `Σ ≥ −1/3`. *Grade:* [mpmath, 40 digits].
  - (C) `μ₁ = w·δ₀ + (1 − w)·circle(j₁,₁)` meets every two-point constraint with 95 % of its mass on non-torsion characters.
    *Grade:* [hand + mpmath + classical Bessel monotonicity].
  - *Proof:* § W-C0 and `wc0_check.py`.
  - *Scope:* every real field.
  - *Prior art:* `[BachocEtAl2009]` and `[OliveiraVallentin2010]` (the 0.2871 extremiser).
- **W-D₀: no dyadic threshold walls, for `h ≠ 0`.** It is false at `h = 0`.
  - *Grade:* [hand].
  - *Proof:* § W-D₀; the same descent as the competitor's.
  - *Scope:* every real `F` with this dyadic tower, including ℚ(√11) and K.
- **Supporting check.** `v_𝔓(v) = v_𝔓(8) = v_𝔓(8/3) = 6` and `v_𝔓(4) = 4` at both dyadic primes of `K(i)`.
  - *Grade:* [tools exact, PARI].
  - *Script:* `wa_check.gp`. The plant fires.

**Kernel decisions: none made here.** The owner and the close decide. The cheapest candidate for the kernel is W1, a
one-paragraph lemma over `ℤ₂[ζ₁₂]`.

## "Would have searched here" log

1. **W-A's adversarial attempt.** A finder for a four-colouring of a finite piece of `𝒫` reading level 5 or above on a ball. *Instead:*
   the attempt by formula, killed by D2-A (iv) and D2-B.
2. **W-C0.** An LP or SDP search for a radial `ν` with no atom at 0 meeting all two-point constraints. *Instead:* left explicitly
   open; I derived only the upper bound on the atom.
3. **W-D₀.** A search over threshold functions `ε` on `P₄ × Γ₇` for a proper wall at ℚ(√11). *Instead:* the descent, which kills
   every `ε` at once.

No searches were run. The computations are `wa_check.gp` (PARI, exact valuations) and `wc0_check.py` (mpmath, with one float grid
scan labelled as a check). Each has a plant, and each plant fired.

## State

Complete: C0, C1 (all five), C2, C3, C4. Nothing is in flight. Nothing was committed.

## Owner's rulings on the escalations (received after hand-back; recorded here for the close)

| item | ruling |
|---|---|
| D1 | Theorem A takes the grade "hand + certificate (row 78), or given Parts's trees (row 85); plus D2-B". |
| D7 | D₀ is filed with `h ≠ 0`. |
| D4 | §1.3's sentence about K is corrected to "per coset, along one of the two embeddings". The owner checked the argument: a pullback invariant under a subgroup that maps onto `O_{𝔓₂}/𝔓₂⁴` is constant. |
| W-C0 | The missing "unit-distance" was the brief's paraphrase, logged by the owner against himself. The repaired measure `μ₁` is filed beside C0 as an extension of the no-go to every two-point constraint. |
| W1 | Noted as a kernel candidate. |

Stood down. The record and both checkers stay in this scratch directory until the competition ends.
