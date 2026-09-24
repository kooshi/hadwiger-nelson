# FS-85 round 3: the 5-part lemma (de Bruijn's working file)

*Opened 2026-09-24 by de Bruijn (Opus 5.5). Brief: `data/fs85/briefs/R3-five-part-brief.md`. Only writer: de Bruijn. Tools:
`data/fs85/r3/`. The finite-witness-free week is in force: no colouring of any quotient is enumerated or searched.*

**The target.** *The 5-part lemma:* every proper four-colouring of de Grey's lattice `Cay(Λ, U)` is `24Λ`-periodic. By Coxeter's
Corollary U (`F ⊇ 120Λ` from Parts's G481, prior art) this says the spectrum carries no weight on the 48 order-10 characters of
`Θ_{−2..2}`; with his alternate-triple lemma C15 and Theorem R it gives `F ⊇ 8Λ` and all of Hubai's description on `Λ`.

## State (a fresh agent resumes from here)

- **2026-09-24, later: the 5-part lemma is PROVED** (§1, FS85-R3a), in a stronger form: the five-family graph alone forces it.
  Stop rule's first condition met; standing down after report 2 (commit 2199e552). Owed: the blind verifier; the step to check
  first is F5's plane complementarity with Step 4(a), then Step 2. Slip: report 1 gave ~190k tokens; the harness counter read ~330k
  (about 370k at report 2).
- 2026-09-24: brief and the six inputs read in the brief's order (`CLAUDE.md` from context, checked current against `git log`; the
  FS-85 plan §0, §IQ, §R-review; Coxeter R2.0–R2.12; de Bruijn dB5–dB11; the verification; Poros §13). §IQ and the prediction below
  written before any tool beyond `lat.py` (the unit vectors) and `phi.py` (the 48 order-10 characters, recomputed from the
  definition; it agrees with Coxeter's `sub5.py`: 8 per admissible pair index).

## §IQ. The invariant question for this sub-question (WORKFLOW 3.3)

1. **The existence form.** Is there a proper four-colouring of `Cay(Λ, U)` whose Fourier spectrum puts weight on one of the 48
   order-10 characters `π/2 + θ₅` of `Θ_{−2..2}`? Equivalently: a colouring that is not `24Λ`-periodic.
2. **The structural form.** Classify *every* tetrahedron-valued function on `Λ₅/40Λ₅` whose spectrum lies in the 90 characters of
   `Θ_{−2..2}|_{Λ₅}` (42 of 2-power order, 48 of order 10). By C7 and G481 this is exactly the set of proper four-colourings of one
   component of the **five-family graph** `Cay(Λ, U_{|k|≤2})` — the most general graph on which the spectral input holds, with the
   outer families ±3, ±4 stripped. In the frame's words (Poros §13): `Λ/40Λ = Λ/8Λ × Λ/5Λ` and the graph is a sparse subgraph of the
   categorical product of the tight 2-adic quotient with the (five-chromatic) plane at 5; must every colouring be pulled back from
   the 2-adic factor?
3. **The invariant it forces.** Not named in advance by the discipline; my candidate, from the CRT: the **slice function**
   `b ↦ (chirality, slice colouring)` on the 625 cosets of `5Λ₅` in a component (no edge lies inside a slice). Each slice sees all of
   `Λ/8Λ = Λ/P₊ × Λ/P₋`, so a tetrahedron splitting applies slice by slice. The second invariant is the **line structure of the
   5-part**: for each admissible pair index `π`, the 8 characters `θ₅` with `π/2 + θ₅ ∈ Θ_{−2..2}` are the nonzero points of two
   lines of the dual `𝔽₅⁴` (`phi.py`). A function whose Fourier support is two lines is a sum `φ₁(ℓ₁(b)) + φ₂(ℓ₂(b))` of two
   one-variable functions — which a {−1, 0, 1}-valued function can only be in two rigid shapes.
4. **The route.** Derivation only: tetrahedron splitting across the product; Fourier disjointness of the 5-part between pair
   indices; the sumset shapes of a two-line function. Exact computer algebra only to compute the finite sets the derivation names
   (`Θ_all`, the two chirality lattices `P_±`, the lines and planes of the 5-part) and to check derived identities.
5. **The open instances it would decide.** `F ⊇ 8Λ` on de Grey's lattice from Parts's G481 alone (with C15 and Theorem R), replacing
   row 78's 2,044-point certificate; Coxeter's open question whether the five-family graph alone forces the 5-part (R2.12 item 3);
   the "middle case" shape of R2-dB1 / gap B (a slack product of a tight factor with a non-colourable one).

## Prediction (registered before the route is written)

| outcome | probability |
|---|---|
| **proof** of the 5-part lemma, given Parts's G481 and Coxeter's Θ tables | **0.75** |
| reduction to one named finite statement I cannot close | 0.15 |
| a proved no-go for a named certificate format (beyond C14) | 0.03 |
| an error found upstream (a counterexample would contradict row 78's certificate) | 0.07 |

**Not blind, stated plainly:** while reading Coxeter's R2.10 and Poros's §13 I sketched a route in my head — split every
`5Λ₅`-slice by the tetrahedron splitting across the two primes above 2, then kill the 5-part with its line structure — before
writing anything. The 0.75 is conditioned on that sketch; the named risks are (i) the three planes spanned by the 5-part lines at
one prime might coincide (then the sumset argument needs a second step), (ii) a mis-identification of which order-2 characters
factor through which chirality lattice, (iii) a gap in the Fourier bookkeeping between `Λ₅`-cosets.

## §1. The theorem, and its proof (FS85-R3a) [hand + tools exact; on Parts's G481 (prior art) and Coxeter's C7, C8, C10]

**Theorem (the 5-part lemma, in a stronger form).** Every proper four-colouring of the **five-family graph** `Cay(Λ, U_{|k|≤2})`
is `8Λ₅`-periodic on each of its 81 components `y + Λ₅`, hence `24Λ`-periodic (`3Λ ⊆ Λ₅`, F0). On each component it is moreover
local at one prime above 2: `c(y + x) = f(x mod P_ε)` for one `ε ∈ {+, −}`. Since `Cay(Λ, U)` has more edges, every proper
four-colouring of de Grey's lattice is `24Λ`-periodic: **the 5-part lemma**. The outer families ±3, ±4 are not used (this answers
Coxeter's R2.12 item 3: the five-family graph alone kills the 5-part).

**Corollary (with Coxeter's C15, twice, and Theorem R).** `F ⊇ 8Λ` on de Grey's lattice, uniform chirality, (PL), the collapse onto
`Cay(T₀/8T₀, μ₆ ∪ 3μ₆)` and the count 9,120 — **all from Parts's G481 and derivation, with no solver refusal of ours.** Grade of the
chain: prior art (G481's trees, a computer case analysis, transferred into `Λ` by Poros's exact check; ruling 4's "K1 by prior art")
+ hand + tools exact.

**Notation.** `u_{j,k} = ζ^jη^k`; `Λ₅ = ⟨U_{|k|≤2}⟩`, index 81 (F0). Colours are `𝔽₂²`; `g(x) = v_{c(x)}` with
`v_a = ((−1)^{a₁}, (−1)^{a₂}, (−1)^{a₁+a₂})`, a regular tetrahedron `V` centred at 0 (C7 needs only `Σv = 0` and affine
independence). `β = (5 + √33)/2 = 2 + ζ + w − 2ζw` (norm −2 in ℚ(√33)) generates a prime `𝔭` above 2, `β'` its conjugate `𝔭'`;
`P₊ = (1/9)β³O_E`, `P₋ = (1/9)β'³O_E`. F-numbers are the exact facts of `data/fs85/r3/split.py` (each with a planted fault that fires).

**Input.** By G481, NT holds in families `|k| ≤ 2`, so (C7, C8, C10) `ĝ` is supported on `Θ_{−2..2}`, and on a component the
function `g_y(x) = g(y + x)`, `x ∈ Λ₅`, has spectrum in the 90 characters of `Λ₅` of order dividing 40 lying in every `Z_k`, `|k| ≤ 2`
(F6): the 42 of `Θ_all` (F1) and 48 of the form `π/2 + θ₅`, `π` one of the six admissible pair indices, `θ₅ ∈ Φ_π` (F6).

**Step 0 (three independent coordinates).** `[Λ : Λ₅]` is prime to 40, so `Λ₅/40Λ₅ ≅ Λ/40Λ ≅ Λ/P₊ × Λ/P₋ × Λ/5Λ` (F2: each `P_±`
has index 64, `P₊ + P₋ = Λ`, `β³β'³ = −8`, so `P₊ ∩ P₋ = 8Λ`). Write `x ↦ (X, Y, b)`. `Θ_all = C₊ ⊔ C₋` with `C_± ⊆ Ann(P_±)`
(F3), so a character of `C₊` is a function of `X`, of `C₋` of `Y`. The six order-2 characters split three and three, `π₁⁺, π₂⁺,
π₃⁺ = π₁⁺ + π₂⁺ ∈ C₊` (F4), and `ξ := (π₁⁺, π₂⁺)(X) ∈ 𝔽₂²`. Hence
`g_y = A(X, b) + B(Y, b)`, `A = G₊(X) + P(ξ, b)`, `P(ξ, b) = Σ_j (−1)^{π_j⁺(ξ)} H_j(b)`, and `B` likewise at `−`,
where `G₊` has spectrum in `C₊` (so mean 0, as `0 ∉ Θ_all`) and `H_j` spectrum in `Φ_{π_j}` (mean 0).

**Tetrahedron splitting** (Coxeter's, C9): if `a(s) + d(t) ∈ V` for all `s, t`, then `a` or `d` is constant — two distinct
translates of `V` share at most one point, because the twelve directed edge vectors `v_i − v_j` are pairwise distinct.

**Step 1 (each slice is local at one prime).** Fix `b`. The slice `{x ∈ y + Λ₅ : x ≡ b}` is a coset of `5Λ₅`, which maps onto
`Λ/8Λ`, so every pair `(X, Y)` occurs in it. By the splitting `A(·, b)` or `B(·, b)` is constant, and a constant one is 0 (its
mean over `X` is `mean G₊ + Σ_j H_j(b)·mean(−1)^{π_j} = 0`). Not both, as `g ≠ 0`. So `g` on the slice is `A(X, b)` or `B(Y, b)`,
a `V`-valued function of mean 0, which therefore uses each colour with density 1/4.

**Step 2 (one chirality per component).** Suppose slices of both kinds occur. `U_{≤2}` generates `Λ₅`, so some `u ∈ U_{≤2}` joins
an `A`-slice `b` to a `B`-slice `b + ū`. For `x` in slice `b`, `c(x) ~ A(X(x), b)` and `c(x+u) ~ B(Y(x) + Y(u), b + ū)`; as `x` runs
over the slice, `(X, Y)` runs over everything, so properness says `A(X, b) ≠ B(Y', b + ū)` for **all** `X, Y'` — impossible, as both
take all four values. So WLOG `B ≡ 0` on the component: averaging over `b`, `G₋ = 0`, and then every `H⁻ = 0`.

**Step 3 (the dichotomy).** For `ξ ∈ 𝔽₂²` let `K_ξ` be the 16 values of `X` over `ξ`. On `K_ξ ×` (all `b`), `g = G₊(X) + P(ξ, b)`, so
by the splitting `G₊` is constant on `K_ξ` or `P(ξ, ·) ≡ 0`. Let `T = {ξ : P(ξ, ·) ≢ 0}`. The three `Φ_{π_j}` are disjoint (the six
lines at one chirality are distinct, F5), so for `θ ≠ 0` the Fourier coefficient `P̂(ξ, θ) = (−1)^{π_{j(θ)}(ξ)} Ĥ_{j(θ)}(θ)` has one
term. One `ξ ∉ T` therefore kills every `Ĥ_j(θ)`, and `P ≡ 0`. **So either `P ≡ 0` (no 5-part: done), or `T = 𝔽₂²` and `G₊` is a
function of `ξ` alone** — the *residue case*: `g_y = Γ(ξ, b) = Σ_j (−1)^{π_j(ξ)} F_j(b)`, `F_j = c_j + H_j`, spectrum of `F_j` in
`L_{j,1} ∪ L_{j,2}`, the two lines (with 0) of `Φ_{π_j}` (F5).

**Step 4 (the residue case collapses).** For each `b`, `x ↦ Γ(ξ(x), b)` is `V`-valued with spectrum in `C₊ ⊆ Θ_all`, so it is
equitable in every family, hence proper (C7 item 1: an equitable hexagon is proper); `U` reduces onto the three nonzero `ξ` (F4), so
`ξ ↦ Γ(ξ, b)` is a bijection `Ψ_b : 𝔽₂² → 𝔽₂²` (colours). **Every permutation of `𝔽₂²` is affine** (`|AGL(2,2)| = 24`), so for each
nonzero functional `α` on the colours, `α∘Ψ_b = μ_{α,b} + e_{α,b}` with `μ_{α,b} ∈ {π₁, π₂, π₃}` (a bijection in `α`) and
`e_{α,b} ∈ 𝔽₂`, `e_{α₁+α₂} = e_{α₁} + e_{α₂}`. Reading the `α`-coordinate of `F_j = ¼ Σ_ξ (−1)^{π_j(ξ)} Γ(ξ, ·)`:
`M_{j,α}(b) := (F_j(b))_α = (−1)^{e_{α,b}} · [μ_{α,b} = π_j] ∈ {−1, 0, 1}`, with spectrum in `L_{j,1} ∪ L_{j,2}`.
- *(a) Linear parts are constant.* `Σ_j M_{j,α}(b)² = 1`. The spectrum of `M_{j,α}²` lies in `(L_{j,1} ∪ L_{j,2}) + (L_{j,1} ∪ L_{j,2}) ⊆
  Π_j`, the plane the two lines span, and **the three planes meet pairwise only in 0** (F5: `dim(Π_i + Π_j) = 4`). So at every `θ ≠ 0`
  at most one term of the sum has a coefficient, and it must vanish: each `M_{j,α}²` is constant, i.e. `μ_{α,b} = μ_α` for all `b`.
- *(b) Translation parts are constant.* `f_α(b) := (−1)^{e_{α,b}} = M_{μ_α, α}(b)` is `±1`-valued with spectrum in two lines.
  *Two-line lemma:* such an `f` is `φ₁(ℓ₁(b)) + φ₂(ℓ₂(b))` (real parts of the two line projections), `(ℓ₁, ℓ₂)` is onto `𝔽₅²`, so
  `range φ₁ + range φ₂ ⊆ {±1}`; since `|A + B| ≥ |A| + |B| − 1`, one `φ_i` is constant, and `f` has spectrum in **one** line. Now
  `f_{α₃} = f_{α₁} f_{α₂}`, the three lines lie in the three different `Φ_{μ_α}` and are pairwise distinct (F5). If `f_{α₁}` is not
  constant, the coefficient of `f_{α₁}f_{α₂}` at a nonzero point `aℓ₁` of its line is `f̂_{α₁}(aℓ₁) · mean(f_{α₂})` (the two lines
  meet only in 0), nonzero for some `a` because a `±1` function on the five points of `𝔽₅` has nonzero mean; but `f_{α₃}` has no
  spectrum off its own line. So `f_{α₁}`, and likewise `f_{α₂}`, `f_{α₃}`, are constant.
So `Ψ_b` does not depend on `b`, `P(ξ, b) = Γ(ξ) − G₊(ξ)` does not depend on `b`, and having mean 0 in `b` it is 0.

**Step 5 (assembly).** On every component `g_y` has no order-10 component and spectrum in `Θ_all|_{Λ₅}`, so it is `8Λ₅`-periodic and a
function of `x mod P_ε`. Globally, for each order-10 `ψ` of `Λ₅` the coefficients of its 81 extensions satisfy
`Σ_{a ∈ Ann(Λ₅)} ĉ_{θ₀+a} e(a(y)) = 0` for every `y`, so all vanish (Fourier on `Λ/Λ₅`): `ĝ` has no 5-torsion, and what is left of
`Θ_{−2..2}` has orders dividing 24. ∎

**Where the arithmetic enters, and where triangles do.** *Triangles:* only through the input (NT and C7's factorisation
`(1+X)(1+Y)(X+Y)`). *2-adic:* the chirality lattices `P_± = (1/9)β^{±3}O` (the two primes above 2) and the affine group of
`𝔽₄ = O/𝔭` (Step 4). *5-adic:* the line structure — each `Φ_π` is two lines of `(Λ/5Λ)^∨` and, at one prime above 2, the three
planes are complementary in pairs. *Arithmetic of 5:* that 5 is odd (a `±1` function on `𝔽₅` has nonzero mean; the sumset step).
Poros's reading (§13) is borne out in shape: the instrument is pointwise (tetrahedron splitting, twice) plus exact Fourier
bookkeeping, and the Greenwell–Lovász question "must every colouring of the sparse product be pulled back from the tight factor?"
has the answer yes here.

## Theorems this phase proved

- **FS85-R3a (the 5-part lemma, stronger form).** Every proper four-colouring of the five-family graph `Cay(Λ, U_{|k|≤2})` is, on each
  component `y + Λ₅`, a function of `x mod P_ε` for one chirality `ε` (so `8Λ₅`-periodic), hence `24Λ`-periodic; so every proper
  four-colouring of `Cay(Λ, U)` is `24Λ`-periodic. [hand + tools exact (`split.py` F0–F6); given Parts's G481 (prior art, computer
  case analysis) and Coxeter's C7, C8, C10] §1.
- **FS85-R3b (corollary).** `F ⊇ 8Λ` on de Grey's lattice, with uniform chirality, (PL), the collapse and the count 9,120, from G481 by
  derivation (R3a, then C15 over `Λ₅` and over `Λ₇`, then Theorem R). [prior art + hand + tools exact] §1.
- **Lemmas inside R3a, each [hand]:** slice locality (Step 1); one chirality per component of the five-family graph (Step 2); the
  dichotomy via Fourier disjointness (Step 3); the two-line lemma for `±1` functions on `𝔽₅ⁿ` (Step 4b); the plane-complementarity
  collapse (Step 4a). **[tools exact]:** F0–F6 of `split.py` (index 81; `Θ_all` = 42 and equals the 2-power part for `|k| ≤ 2`;
  `P_± = (1/9)β^{±3}O`, index 64, `P₊ + P₋ = Λ`; `C_±` 21 + 21; the six order-2 characters three and three, summing to 0, onto the
  nonzero residues; each `Φ_π` two lines, six distinct lines per chirality, planes pairwise complementary; the 90 = 6 + 12 + 24 + 48).

## Retractions

*(none)*

## "Would have searched here" log

1. The first impulse on reading the target: colour `Cay(Λ₅/40Λ₅, U_{≤2})` (40⁴ = 2,560,000 points, one component) with a solver
   and look for order-10 spectrum. Not done: the structural form above replaces it.
2. Would have confirmed the theorem by colouring `Cay(Λ₅/40Λ₅, U_{≤2})` with a solver and reading its spectrum. Not done; the
   derivation is checked step by step instead, and by the blind verifier to come.
3. Not a search, logged so the close can judge: `split.py` F6 enumerates the **characters** of order dividing 40 (4,096 × 625) and
   tests the defining condition of `Θ_{−2..2}` — a derived finite set of characters, never a colouring.
