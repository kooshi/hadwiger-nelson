# FS103-M — where `χ_CP(ℝ²)` sits: against `χ_m⁰(ℝ²)`, `χ_m(ℝ²)` and `χ_B(ℝ²)`

*Job FS103-M (de Bruijn), Opus 5.5, 2026-09-26. Brief `data/fs103/briefs/M103-where-cp-sits.md`; standing rules
`data/fs103/briefs/STANDING-RULES.md`. Not blind: every file open. Definitions are `data/fs103/claims.md` D-CP (b) and D-M, used verbatim.
Grades are `CLAUDE.md` § Notation's; every count of minds says whose.*

## Theorems this phase proved

- **M1** — C-FMT (c): `χ_CP(ℝ²) ≤ χ_m⁰(ℝ²)`; general form for Rajchman edge measures on `ℝⁿ`. [hand, one mind; A-E5's route] — §2.2.
- **M1′** — `χ_CP(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ)` (`[BachocEtAl2014]`'s operator chromatic number). [hand; with C-FMT (b) at two blind] — §2.2–2.3.
- **M1″** — C-CPM with no MR: `χ_CP(ℝ²) ≤ χ_m(ℝ²) ≤ χ_B(ℝ²)`. [hand, derived] — §2.2.
- **M1.1, M1.2** — continuity in probability is free for invariant measures on fractional colourings; properness survives weak-* limits when
  `σ̂ → 0`, not otherwise (C3). [hand; tools exact for the controls] — §2.2.
- **NR** — the product-topology Følner route fails: a proper Borel 7-colouring with a discontinuous limit. [hand, sketch; two minds with V2] — §2.4.
- **A-E3′** — `χ_m⁰(Cay(ℝ, {±1, ±√2})) = 3`. [hand, one mind] — §2.1.
- **D1–D5** — the null-set step reduced to a finite list-colouring problem on Falconer's `E` (lists ≥ 2); slack suffices and gives Borel;
  slack costs a colour (`χ^{sl} ≥ 6`, `[CurrieEggleton2016]`). [hand, one mind; D5 + external, read] — §3.1.
- **Q4** — given MR: `χ(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ) = χ(ℚ(√635087)²)`. [hand; weakest link M1] — §3.3.
- **Exact checks** — `tools/fs103_m_controls.py` (C1–C4, each with a plant that fires for its own reason), output `data/fs103/fs103-m/controls.out`.

## Would-have-searched-here log (standing rule 3)

- Stage 1: none. Reading only.
- Stage 2: none. The controls are exact identities (C1–C4), not searches; the naive-route counterexample is constructed, not found.
- Stage 3: would have searched tight 5- and 6-colourings for a non-list-colourable boundary configuration (question 2); instead characterised it
  (D1–D5) and stated it as the obstruction. Two zbMATH queries (the forbidden-interval literature) located `[CurrieEggleton2016]` Thm 1, already
  held.

## Stage 1 — SAVED (Falconer first-hand; the quotation check)

### 1.0 Resuming check

`plans/FS103-M-derivation.md` did not exist at start; `data/fs103/fs103-m/` did not exist. Fresh start at stage 1.

### 1.1 The quotation check of the brief (standing rule 5)

| brief's text | source checked | result |
|---|---|---|
| "**`χ(ℝ²) = χ_CP(ℝ²) = χ(ℚ(√635087)²) = χ(F_dG²)`**", both verifiers' stage 3 | `plans/FS103-V1-verification.md` Stage 3 ("So, given MR (row 120), **χ(ℝ²) = χ_CP(ℝ²) = χ(ℚ(√635087)²) = χ(F_dG²)** at my one-mind [hand] grade"); V2 Stage 3 table | matches V1 verbatim; V2 states it claim by claim (C-635-F1, C-dG-F1) |
| V1: "the Følner limit of random translates need not be continuous in probability" | V1 Stage 3 table, row C-FMT (c) | verbatim |
| V1: "colouring the null set of non-density points (the rest proved: density-point classes avoid distance 1 everywhere)" | V1 Stage 3 table, row C-FMT (d) | verbatim |
| Kooshi: *"If we end up at a wall which collapses HN to another known open problem, that in itself would be a writeup."* | `CLAUDE.md` § Publication | verbatim |
| D-CP (b) "verbatim there" | `data/fs103/claims.md` §0 | present; used below exactly as written there |
| A-E5 "`χ_CP = χ_m⁰`" | `plans/POROS-2026-09-26-fs103-collapse.md` table: "`χ_CP(ℝ²) = χ_m⁰(ℝ²)`, so `χ(ℝ²) ≤ χ_CP(ℝ²) ≤ χ_m(ℝ²)`"; body E5 | matches; E5 is "a sketch [hand, one mind — FS103-A; unverified]" |
| A-E3 "`Cay(ℝ, {±1, ±√2})` with `χ = 2 < 3 = χ_CP`" | same file, table row A-E3 and E3 | matches |
| "the gate's record §2.3 (Payne 2009's 'ambiguous chromatic number'; `[BachocEtAl2014]`'s null-set-tolerant chromatic number; Shelah–Soifer 2003; Soifer 2024 Open AC Problem 62.14)" | `plans/FS103-G-prior-art.md` | **address slip (minor):** only Payne's term is in §2.3 (item 1). `[BachocEtAl2014]` is §2.2; Shelah–Soifer 2003 and Soifer's 62.14 are §2.1's table. All four read there |
| "The gate read it second-hand (`plans/FS103-G-prior-art.md` §3)" | §3.1: "**Primary not held; … The reading below is second-hand**" | matches |
| C-FMT (a), (b), (c), (d), C-CPM verdicts | V1 Stage 3 table; V2 Stage 3 table and Stage 2b | match (V2's (d) text: "**GAP** (null-set step, not derived)") |

**The gate's quotations of the printed sources, re-checked first-hand against the held texts** (all match, modulo OCR ligatures):
- `[Payne2009]` (arXiv:0707.1177v3, held `library/pdf/arXiv-0707.1177.pdf`), §1: "We say that a graph has ambiguous chromatic number when
  χ ≠ χm." Abstract: "…may be seen as further evidence that the chromatic number of the plane might depend on set theory." §3: "In the most
  famous case of the plane we have χ(TQ²) = 2 while χm(TQ²) ≥ 5." **Payne poses no numbered question** about the plane itself being
  ambiguous; the abstract's sentence is the nearest thing.
- `[BachocEtAl2014]` (held, arXiv:1301.1054), Def. 2.1: "A measurable set I ⊆ V is called an independent set of A if (Af, f) = 0 for each
  f ∈ L2 (V) which vanishes almost everywhere outside of I. Notice that sets of µ-measure zero are always independent." §2.4: "The chromatic
  number of A, denoted by χ(A), equals the smallest number k such that one can partition V into k independent sets." §3.1 (their (9)):
  "(Aν f)(x) = (f ∗ ν)(x) = ∫ f(x − y)dν(y)", and "So Aν respects G(Rⁿ, N) and χ(Aν) ≤ χm(G(Rⁿ, N))."
- `[KechrisMarks2020]` Example 5.1 (pp. 45–46): "the unit distance graph on R², … is known to have 5 ≤ χ(U) ≤ χµ(U) ≤ χB(U) ≤ 7, see [DG]
  and [So], but the exact values of χ(U), χµ(U), χB(U) are unknown."
- Shelah–Soifer 2003 (held `data/fs103/fs103-g/shelah-soifer-2003-…pdf`): "Falconer, for example, showed [F] that χ is at least 5 if
  monochromatic sets are Lebesgue measurable"; "DC is sufficient for Falconer's result [F]"; the Conditional Theorem and the closing question,
  as the gate quotes them.
- `[Soifer2024]` p. (ch. 62): "Open AC Problem 62.14 For which values of n is the chromatic number χ(En) of the n-space En is defined 'in the
  absolute,' i.e., in ZF regardless of the addition of the Axiom of Choice or its relative?"

### 1.2 `[Falconer1981]`, first-hand

**Held:** `~/source/library/papers/falconer-1981-realization-distances-measurable-subsets-covering-Rn-jcta-31-184-189.pdf` (Kooshi's upload,
6 pp., JCTA 31 (1981) 184–189). **Read in full** (all six pages, text layer and page images of pp. 186–188 checked against each other).

**What it proves, verbatim.**
- **Theorem 2** (p. 188): "Suppose that Rⁿ is covered by n + 2 measurable sets S₁,…,S_{n+2}. Then one of the sets contains a pair of points at
  unit distance apart." So `χ_m(ℝⁿ) ≥ n + 3`, and `χ_m(ℝ²) ≥ 5`.
- **Theorem 1** (p. 186): "Suppose that in Rⁿ there is a configuration C of M points with critical distance 1 and critical number D. Then if Rⁿ
  is covered by M/D or fewer measurable sets Sⱼ, there is a set in the covering within which all distances are realized." With the remark (p.
  186–187): "Theorem 1 gives an improvement of one for the chromatic number in the measurable case if the configuration employed has M/D
  integral."
- The tools. **Lemma 1** (a rigid motion `ρ` of a countable configuration `C` meets a given null set `E` in exactly one point, "for almost all
  … rotations"; Croft's Lemma 3). **Lemma 2**: "Let S be a measurable subset of Rⁿ with v(S) > 0 and v(Rⁿ∖S) > 0 then (i) ∂S is non-empty and
  v(∂S) = 0, (ii) S̃ is a Borel set", where "the metrical boundary ∂S of S [is] those points of Rⁿ at which the Lebesgue density of S either
  fails to exist, or exists and has a value other than 0 or 1" and "the essential part S̃ of S [is] those points … where the Lebesgue density of
  S exists and equals 1". **The null set:** "Now let S₁,…,S_k be disjoint measurable subsets of Rⁿ with union equal to Rⁿ. If E = Rⁿ∖⋃ S̃ⱼ then
  E is the aggregate of the metrical boundaries of the Sⱼ." **Lemma 3** (Croft, his Theorem 8): "Suppose that x₁,…,x_M are points in Rⁿ such
  that x₁ ∈ E, say x₁ ∈ ∂S₁ ∩ ⋯ ∩ ∂S_r, and xᵢ ∈ S̃_{k(i)} for 2 ≤ i ≤ M. Then for every j (1 ≤ j ≤ r) there exists a small translation p such
  that p(x₁) ∈ Sⱼ, and p(xᵢ) ∈ S_{k(i)} if 2 ≤ i ≤ k." **Lemma 4** (the circle, `r > 1/2`, `θ = 2 sin⁻¹(1/2r)` an irrational multiple of `π`,
  "almost all points of T … belong to either S̃₁ or S̃₂" ⟹ a unit pair inside `S₁` or inside `S₂`), proved by Kronecker and "a set with
  arbitrarily small periods has either zero or full measure". The plane case: `sin⁻¹(1/(2√3)) = 2cos⁻¹(5/6)` … "(5 + i√11)^m = 6^m" is
  impossible by unique factorisation in `k(√−11)`.
- **An open remark** (p. 185–186): the closure of `∂S` has non-zero `(n−1)`-dimensional Hausdorff measure; "It would be useful to know if the
  same was true of ∂S itself."

**The format: proper everywhere, measurable classes.** The theorem's conclusion is one pair of points at unit distance **inside one set** `Sⱼ`;
so the colourings it refutes are measurable colourings whose classes avoid distance 1 **everywhere** (`χ_m`, D-M). The proof exhibits single
unit pairs (Lemma 3 gives "a small translation p", one translation, not a positive-measure set of them), so **as written it needs properness at
the exhibited edges, i.e. everywhere**; the paper says nothing about colourings proper only almost everywhere. Whether it survives for `χ_m⁰`
is a reading (the gate's, §2.2), and it is moot for the value five, which `χ_m⁰` has by the edge-null density bound (I-CP57's lower half).

**Against the gate's second-hand reading** (`plans/FS103-G-prior-art.md` §3.1, from `[Soifer2024]` ch. 9's print of Falconer's 2005
exposition, and `[Payne2009]`):

| item | gate (second-hand) | first-hand (1981) | verdict |
|---|---|---|---|
| statement | Soifer's Thm 9.1 (`n = 2`, four disjoint measurable sets); Payne: "χm(Rⁿ) ≥ n + 3" | Theorem 2, general `n`, `n + 2` measurable sets **covering** `ℝⁿ` (not assumed disjoint) | agree; the 1981 form is general `n`, as Payne reported |
| format | "Classes measurable and **proper everywhere**" | the same (the conclusion is a pair inside one set) | agree |
| translations | "translated by a positive-measure set of small vectors `v`" | Lemma 3: "there exists a small translation p" — existence only | **differs**: the positive-measure form is the 2005 exposition's (or Croft's proof), not the 1981 statement. It matters exactly for the a.e. question: the 1981 text does not supply what an a.e. adaptation needs |
| irrationality | Soifer: "(1 − i√11)^{2m} ≠ (−12)^m" | "(5 + i√11)^m = 6^m" impossible | agree: `(1 − i√11)² = −2(5 + i√11)` and `(−12)^m = (−2)^m 6^m` |
| the null set | "the density boundary `∂A` is null and non-empty" | Lemma 2 (i), and `E = ℝⁿ∖⋃S̃ⱼ`, "the aggregate of the metrical boundaries" | agree; **`E` is exactly the null set of question 2 (C-FMT (d))** |

**Bearing on this job (a recognition, not a result).** Falconer's proof lives on the null set `E` that question 2 must colour: its first move
(Lemmas 1 and 3) makes a point `x₁ ∈ ∂S₁ ∩ ∂S₂` "belong to two or more of the Sⱼ" (p. 186, proof of Theorem 1). Question 2 meets the same point
from the other side: a point of `E` needs a colour, and it sees at least two classes of positive density (§3 below).

**Proposed `BIBLIOGRAPHY.md` row change** (the close writes it): `[Falconer1981]` — copy: the path above; read status: **read in full,
first-hand (2026-09-26, FS103-M)**; role: `χ_m(ℝⁿ) ≥ n + 3` for measurable colourings proper everywhere (Thm 2); the essential parts `S̃` and
the null set `E` (Lemma 2, p. 186).

## Stage 2 — SAVED (question 1: C-FMT (c), controls first)

**Verdict: C-FMT (c) is TRUE. `χ_CP(ℝ²) ≤ χ_m⁰(ℝ²)`, hence (with C-FMT (b)) `χ_CP(ℝ²) = χ_m⁰(ℝ²)`** — [hand, one mind (mine), not blind: it
completes the advisor's sketch A-E5, whose route it follows; so two minds on the route, one on the proof]. The verifiers' GAP is real **for
the route they tried** (a limit of random translates in the product topology of `[k]^{ℝ²}`), and the counterexample to that route stands (§2.4).
The limit that works is taken in the weak-* topology of fractional colourings, where continuity in probability is automatic and properness
survives because the circle's Fourier transform decays.

### 2.1 Controls, before any argument

| control | what the argument must do there | where it stops, and why (exact facts: `tools/fs103_m_controls.py`, output `data/fs103/fs103-m/controls.out`) |
|---|---|---|
| **positive:** the randomly translated hexagonal 7-colouring `h` (side `s = 2/5`) | reproduce it | the orbit closure of `h` is its torus of translates `ℝ²/Λ₇`; the invariant measure is Haar there; the construction returns `c(x) = h(x + Z)`, `Z` uniform on a period cell (§2.3 (P)). C1: `2s = 4/5 < 1` and `√21·s − 2s > 1` exactly, so `h` has slack on both sides and any boundary convention is proper |
| **negative (A-E3):** `Cay(ℝ, {±1, ±√2})`, `χ = 2 < 3 = χ_CP` | must **not** prove `χ_CP ≤ 2` | stops at its hypothesis and again at step M1.2. (a) There is no measurable 2-colouring proper at a.e. edge: it would be a.e.-invariant under `2ℤ + 2√2ℤ`, a dense group, hence a.e. constant, contradicting `f(x+1) ≠ f(x)` a.e.; so `χ_m⁰ = 3` there, and the argument yields only `χ_CP ≤ 3`, true. (b) The ZFC 2-colouring cannot be fed in: step 1 needs `z ↦ τ_z F` to be a Borel map into the space of measurable functions. (c) M1.2's decay hypothesis fails: `σ̂(ξ) = (cos ξ + cos √2ξ)/2` has `σ̂(2πq) > 1 − 4.5·10⁻⁹` at the Pell denominator `q = 33461` (C2) |
| **negative for step M1.2 (mine):** `Cay(ℝ², {±e₁})`, `f(x, y) = (⌊x⌋ + ⌊N(y)·{x}⌋) mod 2`, `N(y) = 2⌈\|y\|⌉ + 2` | shows the decay hypothesis is used, not decorative | `f` is measurable and proper at **every** `e₁`-edge (C3, exact), yet its window averages tend to `1/2` as `N` grows (C3), so the orbit-closure measure of the random translates is the point mass at the constant fractional colouring `(1/2, 1/2)`, for which `⟨G(0), G(e₁)⟩ = 1/2 ≠ 0`: properness is lost in the limit. `σ̂ = cos ξ₁` does not decay. (The inequality is not refuted there: `⌊x + U⌋ mod 2` is a CP 2-colouring. The construction fails from this `f`, not the claim) |

### 2.2 The theorem

**Theorem M1 (C-FMT (c), and its general form).** Let `T ⊂ ℝⁿ` be compact and symmetric, `σ` a probability measure with `supp σ = T`, symmetric,
with `σ̂(ξ) → 0` as `|ξ| → ∞`. If `f : ℝⁿ → [k]` is Lebesgue measurable and `f(x) ≠ f(x + w)` for `Leb ⊗ σ`-almost every `(x, w)`, then
`Cay(ℝⁿ, T)` has a CP `k`-colouring in the sense of D-CP (b). For `n = 2`, `T = S¹`, `σ` normalised arc length (`σ̂(ξ) = J₀(|ξ|)`, `|J₀(r)| ≤
√(2/(πr))`): **`χ_CP(ℝ²) ≤ χ_m⁰(ℝ²)`.**

*Proof.* Write `F(x) = e_{f(x)} ∈ Δ_k ⊂ ℝ^k`, `⟨·,·⟩` the dot product, `|·|` the `ℓ¹` norm, `(g ⋆ σ)(x) = ∫ g(x + w) dσ(w)` (well defined on
`L^∞` classes: changing `g` on a null set `Z` changes `g(x + w)` only on `{(x, w) : x + w ∈ Z}`, which is `Leb ⊗ σ`-null). `Q = [0, 1)ⁿ`.

**Step 1 (the compact space and the invariant measure).** `M = {g ∈ L^∞(ℝⁿ, ℝ^k) : g(x) ∈ Δ_k a.e.}` with the weak-* topology `σ(L^∞, L¹)`. It
is convex, bounded and weak-* closed (the constraints `g_j ≥ 0`, `Σ_j g_j = 1` are tested against non-negative `L¹` functions), hence compact,
and metrisable because `L¹` is separable. Translation `(z, g) ↦ τ_z g = g(· + z)` is jointly continuous (`⟨τ_{z_m} g_m − τ_z g, φ⟩ = ⟨g_m,
τ_{−z_m}φ − τ_{−z}φ⟩ + ⟨g_m − g, τ_{−z}φ⟩`, the first term `≤ ‖τ_{−z_m}φ − τ_{−z}φ‖₁ → 0`). Let `μ_m` be the law of `τ_Z F`, `Z` uniform on
`[−m, m]ⁿ` (a Borel probability on `M`, since `z ↦ τ_z F` is continuous), and `μ` a weak limit along a subsequence. Then `‖(τ_t)_*μ_m − μ_m‖_TV
≤ |B_m Δ (B_m + t)|/|B_m| → 0` and `τ_t` is continuous, so `μ` is translation-invariant; it is carried by the orbit closure of `F`.

**Step 2 (M1.2 — properness survives the limit; this is where decay is used).** `Φ(g) = ∫_Q ⟨g, g ⋆ σ⟩ dx` is weak-* continuous on `M`. Let
`g^m → g` in `M` and `ψ ∈ C_c^∞` with `ψ = 1` on `Q + T`; on `Q`, `g^m ⋆ σ = (ψ g^m) ⋆ σ`. With `h_m = ψ(g^m − g)` (componentwise):
`ĥ_m(ξ) = ⟨g^m − g, ψ e^{−iξ·}⟩ → 0` pointwise, `|ĥ_m| ≤ 2‖ψ‖₁`, and `‖h_m ⋆ σ‖²₂ = (2π)^{−n}∫ |σ̂|²|ĥ_m|² ≤ (2π)^{−n}∫_{|ξ|≤R} |ĥ_m|² +
sup_{|ξ|>R}|σ̂|²·‖h_m‖²₂`; the first term tends to 0 by dominated convergence, the second is small for large `R` uniformly in `m` (`‖h_m‖₂ ≤
2√k‖ψ‖₂`). So `g^m ⋆ σ → g ⋆ σ` in `L²(Q)` strongly while `g^m → g` weakly in `L²(Q)`, and `Φ(g^m) → Φ(g)`. Now `Φ ≥ 0`, and `Φ(τ_z F) =
(Leb ⊗ σ){(x, w) : x ∈ Q + z, f(x) = f(x + w)} = 0`; by continuity `Φ = 0` on the orbit closure, and the same for `Q + t`, `t ∈ ℤⁿ`. Hence
**`μ`-almost surely `⟨g(x), g(x + w)⟩ = 0` for `Leb ⊗ σ`-a.e. `(x, w)`** — a fractional colouring proper at almost every edge.

**Step 3 (M1.1 — a process defined at every point, continuous in probability for free).** On `(M, μ)` let `G(g) = g`, `ρ_ε` a mollifier,
`G^ε(x) = (G ∗ ρ_ε)(x) = ⟨G, ρ_ε(x − ·)⟩`: continuous in `x`, a continuous functional of `G`, so `(G^ε, G^δ)` is jointly stationary. Hence
`E|G^ε(0) − G^δ(0)| = E∫_Q |G^ε − G^δ| dz → 0` (for each `g`, mollifiers converge in `L¹_loc`; dominated by `2`). So `G̃(x) := lim_{ε→0}
G^ε(x)` exists in `L¹(μ)` for **every** `x`, is `Δ_k`-valued, and is stationary (its finite-dimensional laws are limits of invariant ones). And

`E|G̃(0) − G̃(h)| = lim_ε E∫_Q |G^ε(z) − G^ε(z + h)| dz ≤ E∫_{Q′} |G(z) − G(z + h)| dz → 0` as `h → 0`

(`Q′` a unit neighbourhood of `Q`; `L¹`-continuity of translation for each `g`, then dominated convergence). **So `G̃` is continuous in
probability, with no hypothesis beyond stationarity and measurability** — the advisor's "one way is Doob; the other is `E|F(0) − F(h)| =
E∫_{[0,1]²}|F(z) − F(z+h)| dz → 0`" (A-E5), made to apply to a process defined at every point.

**Step 4 (M1.3 — from almost every edge to every edge).** `φ(w) := E⟨G̃(0), G̃(w)⟩` is continuous in `w` (`|φ(w) − φ(w′)| ≤ E|G̃(0) − G̃(w′ −
w)|`, since `|⟨a, b⟩ − ⟨a, b′⟩| ≤ |b − b′|` on `Δ_k`) and `≥ 0`. By stationarity and Fubini, `∫ φ dσ = lim_ε E∫_Q ⟨G^ε, G^ε ⋆ σ⟩ dz = E Φ(G) =
0` (for each `g`, `G^ε → g` and `G^ε ⋆ σ = (g ⋆ σ) ∗ ρ_ε → g ⋆ σ` in `L²(Q)`; the exchange of `lim_ε` with `∫dσ` is uniform, `|E⟨G^ε(0), G^ε(w)⟩ −
φ(w)| ≤ 2E|G^ε(0) − G̃(0)|`). So `φ = 0` `σ`-a.e., hence on `supp σ = T` by continuity: **`⟨G̃(x), G̃(x + w)⟩ = 0` a.s. for every `x` and every
`w ∈ T`** — the supports of `G̃(x)` and `G̃(x + w)` in `[k]` are disjoint almost surely.

**Step 5 (M1.4 — rounding by one threshold).** Take `U` uniform on `[0, 1)`, independent of `G̃`, and `c(x) = min{j : Σ_{i≤j} G̃_i(x) > U}`.
Then `G̃_{c(x)}(x) > 0`, so `c(x) ∈ supp G̃(x)` and `P(c(x) = c(x + w)) = 0` for every `x` and `w ∈ T` (Step 4); `c` is stationary (`U` is
translation-free); and `P(c(0) ≠ c(h)) ≤ E Σ_{j<k} |S_j(0) − S_j(h)| ≤ (k − 1)E|G̃(0) − G̃(h)| → 0` (`S_j` the partial sums; C4 checks the
one-threshold bound exactly on 3,000 rational pairs). So `c` is a CP `k`-colouring: a random map `ℝⁿ → [k]` on one probability space, law
translation-invariant, `P(c(x) ≠ c(y)) → 0` as `y → x`, `P(c(x) = c(x + w)) = 0` for every `x` and `w ∈ T` — D-CP (b) word for word. ∎

**Corollary M1′.** With C-FMT (b) (V1, V2: `χ_m⁰ ≤ χ_CP`), **`χ_CP(ℝ²) = χ_m⁰(ℝ²)`** — and the same equality for `Cay(ℝⁿ, T)` under M1's hypotheses
(`(b)`'s Fubini argument needs only `P(c(x) = c(x + w)) = 0` for every `w ∈ T` and a jointly measurable version, C-FMT (a)). In particular
`χ_CP(ℝⁿ) = χ_m⁰(ℝⁿ)` for the unit sphere, every `n ≥ 2`.

**Corollary M1″ (C-CPM, no MR).** `χ_CP(ℝ²) = χ_m⁰(ℝ²) ≤ χ_m(ℝ²) ≤ χ_B(ℝ²)`. **C-CPM is TRUE unconditionally** (the verifiers' GAP closes);
and C-FMT (e)'s "`χ_B` against `χ_CP`" is `χ_CP ≤ χ_B`.

### 2.3 The three routes the brief names

- **(ii) Regularising the limit — this is the proof.** Take the limit of random translates in the weak-* topology of fractional colourings `M`,
  not in the product topology of `[k]^{ℝ²}`. The limit is a random *fractional* colouring; continuity in probability is then a theorem (Step 3);
  properness passes to the limit through the compactness of the localised circle-convolution (Step 2); one common threshold rounds it back to
  `[k]` (Step 5). **(P) the positive control through the proof:** for the periodic `h`, the orbit closure is `{τ_z h}`, compact and
  homeomorphic to `ℝ²/Λ₇` (`Λ₇` the colour-period lattice, index 7 in the hexagon lattice); `μ` is its Haar measure; `G̃(x) = e_{h(x + Z)}` a.s.
  because `x + Z` lies on a hexagon boundary with probability 0; so `c(x) = h(x + Z)`. Reproduced.
- **(iii) `[BachocEtAl2014]`'s operator framework — it names the object and holds the key step.** With `A_σ f = f ∗ σ` on `L²(ℝ²)` (their (9),
  `ν = σ` on `N = S¹`), a measurable `I` is independent for `A_σ` (their Def. 2.1) iff `(Leb ⊗ σ){(x, w) : x, x + w ∈ I} = 0` (take `f =
  1_{I ∩ B_R}` one way; the integrand of `(A_σ f, f)` vanishes off that null set the other). So their "chromatic number of `A`" (§2.4) at `A_σ`
  is exactly **`χ(A_σ) = χ_m⁰(ℝ²)`**, and M1′ reads **`χ_CP(ℝ²) = χ(A_σ)`**. Step 2 is a property of the operator: `A_σ M_ψ` is compact on `L²`
  (its symbol `σ̂` vanishes at infinity), which BDOV do not state or use; it is what fails for `σ` on `{±1, ±√2}` (C2) and on `{±e₁}` (C3).
- **(i) Choosing a better colouring, one with a uniform `L¹`-modulus — not an independent route, and its a-priori form is blocked by slack.**
  *A priori:* the natural regularisation, mollify `F` and round, produces fractional values on the boundary layer, and properness then needs
  `F ∗ ρ_ε(x)` and `F ∗ ρ_ε(x + w)` to have disjoint supports — i.e. no colour within `ε` of both `x` and `x + w`, a colouring that avoids every
  distance in `[1 − 2ε, 1 + 2ε]`. A colouring proper only at distance exactly 1 need not have that slack; this is the named obstruction to route
  (i), and supplying slack is a different (stronger) chromatic problem. *A posteriori:* M1 gives it anyway, in averaged form. The ergodic
  components of `μ` are stationary and jointly measurable, so each is continuous in probability (Step 3 applies to each), and for almost every
  component `φ = 0` on `T` (the components' `φ`s are `≥ 0`, continuous and average to `0`); the rounded colouring of an ergodic component has,
  by the ergodic theorem, a realisation `f′` with `|B_m|⁻¹|{z ∈ B_m : f′(z) ≠ f′(z + h)}| → P(c(0) ≠ c(h))` for all rational `h` at once, which
  tends to 0 with `h`. A **uniform** (sup over unit boxes) modulus is not obtained, and is not needed.

### 2.4 The verifiers' route and why it fails — the counterexample, sharpened

The naive route takes finite-dimensional laws of `(f(Z_m + x₁), …, f(Z_m + x_r))` along a subsequence (on a countable dense index set, by a
diagonal argument). Then `P(c(x) ≠ c(y)) = lim_m |{z ∈ B_m : f(z + x) ≠ f(z + y)}|/|B_m|`, and nothing makes this small uniformly in `m` as
`y → x`. **Counterexample** (V2's, made explicit; two minds on the obstruction): take the hexagonal 7-colouring with `s = 2/5` (slack `ε₀ =
min(1 − 2s, (√21 − 2)s − 1) > 0.033`, C1) and replace every hexagon edge whose midpoint lies in the annulus `j ≤ |z| < j + 1` by a zigzag of
amplitude `a = ε₀/4` and wavelength `1/j`, shared by the two tiles it separates. Each tile moves by at most `a` in Hausdorff distance, so tiles
keep diameter `< 1` and same-colour tiles stay more than 1 apart: `f` is proper **at every edge** (Borel, even). For a fixed `h` of length
`δ ≪ a` along an edge direction, the pairs `(z, z + h)` inside a zigzag band of wavelength `≪ δ` differ with probability bounded below (the
zigzag's phase shifts by `δj` mod 1), the bands occupy a fixed positive fraction `≍ a·(perimeter/area)` of the plane, and `B_m` is dominated by
large `|z|`. So the naive limit has `P(c(0) ≠ c(h)) ≥ c₀ > 0` for every small `h` in that direction: not continuous in probability. In the weak-*
route the same `f` gives a blurred fractional colouring on the bands, proper by Step 2 because `a < ε₀/2`. **The difference between the two
routes is exactly which topology the limit is taken in.**

### 2.5 Theorems this stage proved

- **M1** (C-FMT (c), general form): Rajchman edge measure `σ` with `supp σ = T` ⟹ `χ_CP(Cay(ℝⁿ, T)) ≤ χ_m^{0,σ}`; `χ_CP(ℝ²) ≤ χ_m⁰(ℝ²)`. [hand,
  one mind (mine); route: A-E5's] — §2.2.
- **M1′**: `χ_CP(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ)` (`[BachocEtAl2014]`'s operator chromatic number). [hand, one mind + C-FMT (b) at two blind] — §2.2–2.3.
- **M1″** (C-CPM, no MR): `χ_CP(ℝ²) ≤ χ_m(ℝ²) ≤ χ_B(ℝ²)`. [hand, derived from M1] — §2.2.
- **M1.1**: a translation-invariant probability on the weak-* space of fractional colourings defines, at every point, a stationary process
  continuous in probability. [hand, one mind; A-E5's Fubini line] — Step 3.
- **M1.2**: `Φ(g) = ∫_Q ⟨g, g ⋆ σ⟩` is weak-* continuous when `σ̂ → 0`; false for `σ` on `{±e₁}` (C3). [hand + tools exact for the control] — Step 2.
- **NR** (the naive route fails): a proper Borel 7-colouring whose product-topology Følner limit is not continuous in probability. [hand, sketch;
  two minds with V2] — §2.4.
- **A-E3′**: `χ_m⁰(Cay(ℝ, {±1, ±√2})) = 3` (so `χ = 2 < χ_m⁰ = χ_CP = 3` there). [hand, one mind] — §2.1.

## Stage 3 — SAVED (questions 2–4)

### 3.1 Question 2 — C-FMT (d), `χ_m⁰(ℝ²) = χ_m(ℝ²)`: **GAP**, reduced to a finite list-colouring problem on Falconer's null set, with one sufficient condition proved and shown to cost a colour

Fix a measurable `f : ℝ² → [k]` proper at `Leb ⊗ σ`-a.e. edge; classes `S_j = f⁻¹(j)`; `S̃_j` their points of density 1 (Borel, `[Falconer1981]`
Lemma 2 (ii)); **`E = ℝ² ∖ ⋃_j S̃_j`, Falconer's null set** ("the aggregate of the metrical boundaries", p. 186). For `x ∈ ℝ²` let `d̄_j(x) =
limsup_{r→0} |S_j ∩ B(x, r)|/|B(x, r)|` and **`P(x) = {j : d̄_j(x) > 0}`**.

- **D1 (V1's density-point lemma, strengthened to one-sided).** If `y ∈ S̃_j` and `d̄_j(x) = θ > 0`, then `|x − y| ≠ 1`. *Proof.* Take `r`
  small with `|S_j ∩ B(y, r)| ≥ (1 − η)πr²` and (along the limsup) `|S_j ∩ B(x, r/2)| ≥ (θ/2)π r²/4`. For `x′ ∈ B(x, r/2)` every `w ∈ S¹` within
  angle `r/2` of `v = y − x` has `x′ + w ∈ B(y, r)`, so `W = {(x′, w) : x′ ∈ S_j ∩ B(x, r/2), x′ + w ∈ B(y, r)}` has `Leb ⊗ σ`-measure `≥ θr³/16`.
  The part with `x′ + w ∉ S_j` has measure `≤ ηπr² · σ(A)`, `A` the arc of `w` within angle `2r` of `v`, so `≤ Cηr³`. For `η < θ/(16C)` a
  positive-measure set of monochromatic unit pairs remains — contradicting a.e.-properness. ∎ (V1's case: `θ = 1`.) [hand, one mind]
- **D2 (every boundary point sees two colours).** For `x ∈ E`, `|P(x)| ≥ 2`. *Proof.* `Σ_j |S_j ∩ B(x,r)| = |B(x,r)|`, so `P(x) ≠ ∅`; if
  `P(x) = {j}`, every other class has density 0 at `x`, so `S_j` has density 1 and `x ∈ S̃_j`. ∎ This is Falconer's "we may regard x₁ as
  'belonging to two or more of the Sⱼ'" (p. 186), read from the colouring side. [hand, one mind]
- **D3 (the reduction; both directions).** `χ_m(ℝ²) ≤ k` **iff** there are an a.e.-proper measurable `k`-colouring `f` and a null set `D ⊇ E_f`
  such that the unit-distance graph on `D` has a proper colouring `c` with `c(x) ∈ L_D(x) := {j : C(x, 1) ∩ (S̃_j ∖ D) = ∅}`. *Proof.* ⟸: colour
  `S̃_j ∖ D` by `j` (proper there by D1 with `θ = 1`), `D` by `c`; edges into `D` are proper by the lists; the colouring is Lebesgue measurable
  because `D` is null and Lebesgue measure is complete. ⟹: given a proper measurable `g`, take `f = g` and `D = E ∪ {x ∈ ⋃ S̃_j : g(x) ≠` the
  `j` with `x ∈ S̃_j}` (null), `c = g|_D`. ∎ By D1, `L_{E}(x) ⊇ P(x)` for `x ∈ E`, so **every list has at least two colours** (D2). **No
  measurability is needed on `D`: for `χ_m`, question 2 is pure combinatorics** (choice allowed), and by de Bruijn–Erdős for list colourings
  (finite lists; Rado's selection) it is a question about **finite** unit-distance configurations inside `D`. [hand, one mind]
- **D4 (slack suffices, and gives Borel).** Say `f` has *slack* if for some `ε > 0`, `(Leb ⊗ Leb){(x, y) : f(x) = f(y), 1 − ε < |x − y| < 1 + ε}
  = 0`. Let `supp S_j = {x : |S_j ∩ B(x, r)| > 0 ∀ r > 0}` (closed; the supports cover `ℝ²`, the set of `j` with `|S_j ∩ B(x,r)| > 0` being
  non-empty and decreasing as `r ↓ 0`). **Then `c(x) = min{j : x ∈ supp S_j}` is proper at every pair at distance in `(1 − ε, 1 + ε)`, and its
  classes are differences of closed sets (Borel).** *Proof.* If `c(x) = c(y) = j` and `|x − y| ∈ (1 − ε, 1 + ε)`, pick `r, r′` with `r + r′ < ε −
  ||x − y| − 1|`; `(S_j ∩ B(x, r)) × (S_j ∩ B(y, r′))` has positive measure in `ℝ⁴` and consists of monochromatic pairs at distances in `(1 − ε,
  1 + ε)`. ∎ [hand, one mind] So **`χ_m⁰ ≤ χ_m ≤ χ_B ≤ χ^{sl}`**, `χ^{sl}(ℝ²)` the least `k` with a measurable `k`-colouring having slack.
- **D5 (slack costs a colour).** `χ^{sl}(ℝ²) ≥ 6`. *Proof.* D4 turns a slack `k`-colouring into a proper colouring of the graph joining points at
  distance in `[1, 1 + ε′]` for small `ε′`; `[CurrieEggleton2016]` Theorem 1, verbatim: "Fix ǫ, 0 < ǫ < 3√2/4 − 1. Let H be the graph whose
  vertices are the points of R², with an edge between every pair of points whose distance lies in the interval [1, 1 + ǫ]. Then 6 ≤ χ(G) ≤ 7"
  (read first-hand for this: statement and the proof's first page; held `library/pdf/arXiv-1509.03667.pdf`). ∎ [hand + external (read);
  `≤ 7` by the hexagonal colouring, which has slack (C1)] **Consequence: if `χ_m⁰(ℝ²) = 5`, no a.e.-proper measurable 5-colouring has slack, and
  question 2 must be settled at a tight colouring** — route (i) of §2.3 and the slack route to question 2 are the same route, and it is closed
  below six by a theorem.

**The named obstruction (question 2).** A finite unit-distance configuration `x₁, …, x_m` inside the metrical boundary `E` (or a null `D ⊇ E`)
of an a.e.-proper measurable `k`-colouring, whose lists `L(xᵢ) ⊇ P(xᵢ)` — each of size at least two — admit no proper choice. Adjacent boundary
points can share a colour of positive density: `S_j = {x₁ < 0}` near `x = 0` and `S_j = {x₁ > 1}` near `y = e₁` have no unit pair and put `j`
in `P(x) ∩ P(y)` — the "facing-away" pair, which slack forbids and tightness allows. So the rule "`c(x) = min P(x)`" fails in general, and
question 2 is a genuine list-colouring question. *Would have searched here:* a search over tight 5- or 6-colourings for a non-list-colourable
boundary configuration; instead, the configuration was characterised (D1–D5) and left as the stated obstruction. *A hunch, not claimed:* two
adjacent points of `E` cannot have `P(x) = P(y) = {a, b}` (a blow-up argument makes the colouring locally a function of `(· − x)·v`, and the
unit-pair constraint then forces it constant); killing test: an a.e.-proper colouring with such a pair. Even if true it does not close D3
(lists of size two on non-cycles can fail).

### 3.2 Question 3 — C-FMT (e), `χ_B(ℝ²)`

`χ(ℝ²) ≤ χ_CP(ℝ²) = χ_m⁰(ℝ²) ≤ χ_m(ℝ²) ≤ χ_B(ℝ²) ≤ χ^{sl}(ℝ²) ≤ 7`, with `χ_m⁰ ≥ 5` (the edge-null density bound, I-CP57) and `χ^{sl} ≥ 6`
(D5); the first inequality is FS-103's F1 direction (given MR it is an equality), the second M1′, the last two D4 and C1. **`χ_B` against `χ_m`:
GAP**, at the same step as question 2 with a Borel choice required: every a.e.-proper colouring agrees a.e. with one whose classes and `E` are
Borel (the `S̃_j`), so `χ_B = χ_m⁰` iff some such `E` (or a Borel null `D ⊇ E`) has a **Borel** list colouring from the lists of D3. Here a
genuinely Borel obstruction is available in principle and absent for `χ_m`: a circle of radius `r` with `2 sin⁻¹(1/2r)` an irrational multiple
of `π` (Falconer's Lemma 4 circle) carrying 2-element lists is a Borel copy of the irrational-rotation graph, which has a ZFC 2-colouring and no
Borel one. Whether a boundary `E` can carry such a circle with equal 2-lists is exactly the hunch above.

### 3.3 Question 4 — the statement the collapse makes, at the grade reached

**Statement (given MR).** With MR (`LEDGER.md` row 120, [hand]), FS-103's load-bearing step at ℚ(√635087) (C-635-F1, [hand, two blind: V1, V2])
and M1′ (this record, [hand, one mind]):

**`χ(ℝ²) = χ_CP(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ) = χ(ℚ(√635087)²)`,** equivalently:
**`χ(ℝ²) ≤ k` iff the plane has a Lebesgue-measurable `k`-colouring in which almost every unit pair (for `Leb ⊗ σ` on `ℝ² × S¹`) is
bichromatic.** Grade: [hand]; weakest link M1, one mind. (The `F_dG` instance is the same statement given MR(`F_dG`), C-MR16 unwalked.)

**The known problem it lands on, precisely.** `χ_m⁰(ℝ²)` is `[BachocEtAl2014]`'s chromatic number of the operator `A_σ` (§2.4 with (9), `ν =`
arc length on `N = S¹`; §2.3 (iii) above) — **defined in print, its value never posed as an open problem there or anywhere the gate found**
(`plans/FS103-G-prior-art.md` §2.2: "Not found in print, as a question or as either inequality"). The posed problem next to it is the measurable
chromatic number `χ_m(ℝ²)` itself: `[Falconer1981]` p. 185 ("a lower bound of 5 for the chromatic number of R² in the case of a measurable
colouring, though this is still rather far from the known upper bound of 7"), `[KechrisMarks2020]` Example 5.1 ("the exact values of χ(U),
χµ(U), χB(U) are unknown"). **Given MR, Hadwiger–Nelson is the measurable chromatic number of the plane modulo null sets; it is Falconer's
measurable chromatic number exactly when question 2 closes.**

**What it answers, at this grade.**
- The plane is **not ambiguous modulo null sets**, given MR: in `[Payne2009]`'s words ("a graph has ambiguous chromatic number when χ ≠ χm"),
  `χ = χ_m⁰` for the plane. The full non-ambiguity `χ(ℝ²) = χ_m(ℝ²)` needs question 2.
- **Every lower bound that tolerates null sets of pairs becomes a lower bound for `χ(ℝ²)`**, given MR: the density bound (`m₁(ℝ²) ≤ 0.2470 <
  1/4`, edge-null form) gives `χ(ℝ²) ≥ 5` by a route with no witness graph; BDOV's Theorem 2.3 at `A_σ` gives only `≥ 1 + 1/0.40276`, i.e. 4.
  Falconer's own argument transfers only if it survives for a.e.-proper classes (his 1981 proof exhibits single pairs; §1.2).
- **Six becomes an analytic statement**, given MR: `χ(ℝ²) ≥ 6` iff every measurable 5-colouring of the plane has a positive-measure set of
  monochromatic unit pairs. And, by D5, **if `χ(ℝ²) = 5` then no a.e.-proper measurable 5-colouring has slack** — the five colours, if they
  exist, are tight.

**What it does not answer.**
- **Falconer's `χ_m`** (and Payne's full ambiguity question for the plane): needs question 2 (§3.1, GAP).
- **Shelah–Soifer's axiom question and `[Soifer2024]` Open AC Problem 62.14 at `n = 2`.** The statement is a ZFC theorem (given MR) comparing
  ZFC's `χ(ℝ²)` with ZFC's `χ_m⁰`; the axiom question compares ZFC's `χ(ℝ²)` with the value in ZF + DC + LM, where every colouring is measurable
  and `χ = χ_m`. *Reading, with its killing test:* if the whole chain — MR, the load-bearing step from `χ(F²)` to a CP colouring, and M1 — is
  provable in ZF + DC (every object in it is countable or a measure; no step I have read uses more than DC), and question 2 closes in ZF + DC,
  then in ZF + DC + LM `χ(ℝ²) = χ_m(ℝ²) = χ_m⁰(ℝ²) = χ(ℚ(√635087)²)`, the ZFC value — **the plane's chromatic number would be absolute between
  the two theories**, answering 62.14 at `n = 2` and the Shelah–Soifer closing question ("…precisely because the answer depends upon the system
  of axioms we choose for set theory?") in the negative for the plane. Killing test: a step of the chain that needs more than DC. Not claimed.
- **MR is [hand]** (row 120), and so is everything that rests on it here.

### 3.4 Theorems this stage proved

- **D1** one-sided density lemma (positive upper density at one end, density 1 at the other ⟹ not at distance 1). [hand, one mind] — §3.1.
- **D2** every point of Falconer's null set `E` has at least two colours of positive upper density. [hand, one mind] — §3.1.
- **D3** `χ_m ≤ k` iff some a.e.-proper `k`-colouring's boundary (a null `D ⊇ E`) is list-colourable from `L_D ⊇ P`, lists of size ≥ 2; finite
  by compactness; no measurability needed. [hand, one mind] — §3.1.
- **D4** a slack colouring becomes proper on the annulus, with locally closed classes: `χ_B ≤ χ^{sl}`. [hand, one mind] — §3.1.
- **D5** `χ^{sl}(ℝ²) ≥ 6`; so if `χ_m⁰ = 5`, a.e.-proper 5-colourings have no slack. [hand + external `[CurrieEggleton2016]` Thm 1, read] — §3.1.
- **Q4** given MR: `χ(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ)`; `χ(ℝ²) ≥ 6` iff every measurable 5-colouring has positive-measure monochromatic unit pairs.
  [hand; M1 one mind, F1 two blind, MR row 120] — §3.3.

### 3.5 Proposals for the close (I edit none of these files)

- **`LEDGER.md`** (with FS-103's row): C-FMT (c) and C-CPM from GAP to **TRUE** by M1 [hand, one mind]; the collapse then reads `χ(ℝ²) =
  χ_m⁰(ℝ²) = χ(A_σ)` given MR. § B lines for M1, M1′, M1″, D1–D5, Q4.
- **`CLAUDE.md`** § Frontier (Where the problem stands / the target): "given MR, HN is the measurable chromatic number of the plane modulo null
  sets" — at [hand], one mind on M1, with the null-set step (question 2) named as what separates it from Falconer's `χ_m`.
- **`BIBLIOGRAPHY.md`:** `[Falconer1981]` held, read in full first-hand (§1.2); `[BachocEtAl2014]` add "§3.1 (9) and the respects-`G` paragraph
  read (2026-09-26, FS103-M); `χ(A_σ) = χ_m⁰(ℝ²)`"; `[CurrieEggleton2016]` Thm 1 re-read for D5; debt: Croft 1982 (Quart. J. Math. 33, 71–83,
  the source of Falconer's Lemmas 1 and 3), unheld.
- **Stubs:** (1) question 2, "colour the metrical boundary" — D3's finite list problem at tight colourings, with the hunch's killing test first;
  (2) the ZF + DC audit of the chain (§3.3), which with (1) would answer Soifer's 62.14 at `n = 2`; (3) a blind check of M1 before anything
  rests on "the known problem".
