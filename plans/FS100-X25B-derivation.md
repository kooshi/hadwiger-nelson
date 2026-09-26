# X25B — a blind second derivation of R88-TCA's class form (TCA-cls) and FS100-T1

*Job X25B of the ×2×3 crunch (2026-09-26), Coxeter (Opus 5.5), brief `data/crunch-2026-09-26-x2x3/briefs/X25B-tca-class-blind-derivation.md`
with `STANDING-RULES.md`. Working files `data/fs100/x25b/`. Stop 12:50 UTC.*

## Theorems this phase proved

*(filled at stage 3)*

## Stage 1 — SAVED

**Quotation check** (11:44 UTC), each by `grep -cF` of the brief's quotation against its source, count 1 each:
- TCA-cls: the brief's text is a verbatim substring of `plans/R88-derivation.md` line 161 (R88-TCA's bold statement). OK.
- T1: the brief's text is a verbatim substring of `LEDGER.md` row 117 (line 155). OK. The same claim as `plans/FS100-derivation.md` line 116
  (FS100-T1's bold statement, open by the brief), worded "(T-C(A)'s class, R88-TCA's class form)" in the middle; no difference of content.

**Fence log.**
1. **Touch (06:40):** reading R88-TCA's statement, I printed `plans/R88-derivation.md` lines 150–175 with `sed`, which showed the bodies under
   R88-TC-tab, R88-TCA and the first line of R88-J28V-6's body — fenced. What I saw of R88-TCA's body: "every factor of `G_S` has ratio
   `< 1/4` (11 and 19 by FS-66, the tail by Hoffman …, the ramified 47 by Lemma P, the real places `m₁`, split places 0), so four classes
   cannot cover: `1 ≤ 4 max(α(Y′), r_X) < 1` (J28D) or `1 ≤ 4(r + η(n))` (J28V)". This is a route sketch, not a proof; it is also, at the
   same level of detail, the open text of `LEDGER.md` rows 112–113. **So my route to "four classes cannot cover" is not blind to the prior
   derivations' outline**; what stays blind is every step of how the count is justified (the product step, the passage from finite levels
   to the measure, the archimedean factor). The owner should weigh this.
2. Afterwards only bold statement lines of `plans/R88-derivation.md` (by `grep '^\*\*R88'`) and its header notation block (lines 1–30,
   above any statement) were read. `plans/FS100-derivation.md`: bold statements of T1 and K0 only.

**C0 probabilities, sealed before any derivation (06:44):**
- TCA-cls at `S = ∅`, as a mathematical statement: **0.80 TRUE**; that I reach TRUE in this window with every step derived: 0.45 (the
  product step over a continuous archimedean factor is where I expect a GAP).
- TCA-cls for finite `S`: **0.75 TRUE**.
- T1: **0.85 TRUE** (risk: a stable place I forget — ramified places above `p | d`, the dyadic cases — or a ratio at 23 or 31 that is
  level-one only).

## Stage 2 — SAVED

**Verdict on TCA-cls.** **At `S = ∅`: TRUE over every totally real field in the class; GAP over a real field with a complex place, at one
named step (X25B-G1 below).** **For finite `S`: TRUE given the pair-factor input** (a split place `w` of `F` with both places `v, v̄` of `L`
above it in `S` has ratio 0 — R88-J28V-6's statement, C14.2 (c), used as an input by statement, not derived here); a split `v ∈ S` with
`v̄ ∉ S` is derived (ratio 0, one line). Route mine throughout, except as the fence log records (the outline "four classes cannot cover").

**Inputs, by statement only.** R88-TC-ext (the extension lemma; two derivations): a translation-invariant `μ` on `X₄(F)` with spectrum
carried by `T + A + Fin_S` gives a `G_S`-stationary, jointly measurable, `{e_j}`-valued `c̃` with `c̃ = c` on `R` a.s. and
`P(c̃(x) = c̃(x + w)) = 0` for every `x ∈ G_S`, `w ∈ T_S`. `[AmbrusEtAl2023]`: `m₁(ℝ²) ≤ 0.247`. `[Zhang2012]` §2 (read in print, arXiv v1, this
session: Prop. 1.7 and the proof of Thm 1.8, pp. 5–7) — its *argument* is transcribed below, not its statement. The all-levels ratios (the
claim's hypothesis). For the tail of the stable places: Weil's bound and G54's inert-tower scaling (`λ_min(G_j) = Q^{j−1}λ_min(G₁)`).

**Definitions.** For an LCA group `G` (second countable) with a symmetric closed `T ⊆ G` carrying a σ-finite symmetric measure `ν` of full
support in `T`: a measurable `W ⊆ G` is *a.e.-independent* if `(m × ν){(x, t) : x, x + t ∈ W} = 0`; `N(W) = {x : ν{t : x − t ∈ W} > 0}`,
`N[W] = W ∪ N(W)`. The *stationary ratio* `r(G, T)` is the supremum of `P(0 ∈ W)` over jointly measurable, `G`-stationary random
a.e.-independent sets `W`. A product `(G × H, T_G × T_H, ν_G × ν_H)` is the categorical product of the two Cayley graphs.

**X25B-P (Prop. 1.7, stationary form).** If `A` is a `G`-stationary random a.e.-independent set, `P(0 ∈ A) ≤ r(G,T)·P(0 ∈ N[A])`.
*Proof.* Let `S` be an independent copy of a stationary a.e.-independent set with `P(0 ∈ S) ≥ r − ε`. `W = (S \ N[A]) ∪ A` is stationary and
a.e.-independent (`A` is; `S \ N[A] ⊆ S` is; the pairs from `A` into `G \ N(A)` are null by Tonelli, the integrand `ν{t : y − t ∈ A}` being 0
off `N(A)`). `A ⊆ N[A]`, so `P(0 ∈ W) = P(0 ∈ S) − P(0 ∈ S)P(0 ∈ N[A]) + P(0 ∈ A)` by independence, and `P(0 ∈ W) ≤ r`: so
`P(0 ∈ A) ≤ r·P(0 ∈ N[A]) + ε(1 − P(0 ∈ N[A]))`; let `ε → 0`. ∎ For a finite vertex-transitive Cayley graph it is Zhang's Prop. 1.7 with
`r = α/|G|`.

**X25B-PZ (Zhang's count, stationary, both factors arbitrary LCA).** `r(G × H) ≤ max(r(G), r(H))`.
*Proof* (Zhang's §2 with sums replaced by probabilities at the origin; `r := max`). Let `J ⊆ G × H` be stationary, a.e.-independent. For
`a ∈ G` let `X_a = {x : (a, x) ∈ J}`, `X*_a = X_a \ N_H(X_a)`, `X′_a = X_a ∩ N_H(X_a)`; for `x ∈ H` let `A_x = {a : x ∈ X′_a}`; `Y_a = X*_a`.
(1) `P((0,0) ∈ J) = P(0 ∈ Y_0) + P(0 ∈ A_0)` (a partition of the event). (2) `Y_0` is an `H`-stationary a.e.-independent set (for fixed `a`,
the pairs `(y, t)` with `y ∈ X*_a`, `y + t ∈ X_a` are null by definition of `N_H`), so `P(0 ∈ Y_0) ≤ r·P(0 ∈ N_H[Y_0])` by X25B-P. `A_0` is
`G`-stationary and a.e.-independent: `a, a + s ∈ A_x` with `s ∈ T_G` gives, for a `ν_H`-positive set of `t`, `(a, x − t), (a + s, x) ∈ J`,
an edge; so `P(0 ∈ A_0) ≤ r·P(0 ∈ N_G[A_0])`. (3) The set `{(a, x) : a ∈ N_G[A_x] and x ∈ N_H[Y_a]}` is null, in four cases:
`a ∈ A_x, x ∈ Y_a` — impossible (`X′_a ∩ X*_a = ∅`); `a ∈ A_x, x ∈ N_H(Y_a)` — `x ∈ X_a` within `ν`-positively many `t` of `Y_a`, null by
the definition of `X*_a`; `a ∈ N_G(A_x), x ∈ Y_a` — `a − s ∈ A_x` for `ν_G`-positive `s`, so `(a − s, x − t) ∈ J` for `ν_H`-positive `t`, an
edge to `(a, x) ∈ J`; `a ∈ N_G(A_x), x ∈ N_H(Y_a)` — `(a − s, x) ∈ J` and `(a, x − t) ∈ J`, difference `(s, −t) ∈ T_G × T_H` (symmetry). Each
positive-measure case gives a positive measure of edges inside `J`. By stationarity `P(0 ∈ N_G[A_0], 0 ∈ N_H[Y_0]) = 0`, so
`P(0 ∈ N_G[A_0]) ≤ 1 − P(0 ∈ N_H[Y_0])`. (4) Sum: `P((0,0) ∈ J) ≤ r·P(0 ∈ N_H[Y_0]) + r(1 − P(0 ∈ N_H[Y_0])) = r`. ∎
*Audit.* Zhang's (1)–(5) index `Y_i` over finitely many sets; the measure form needs no partition, only (3) pointwise a.e. Nothing uses
vertex-transitivity beyond X25B-P, which stationarity supplies. The ratio bound is all that is claimed (not MIS-normality).

**X25B-L1 (the profinite reduction).** Let `Y = lim Y_k` be a compact group with open subgroups `K_k ↓ 0`, `T_Y` compact with its Haar
probability, `S_k` its image in `Y_k = Y/K_k` (uniform image measure; `0 ∉ S_k`). For any `(X, T_X)`:
`r(X × Y) ≤ sup_k r(X × Y_k)`. *Proof.* For a stationary a.e.-independent `I`, let `φ_k(x, a)` be the Haar share of `I`'s `Y`-fibre over `x`
in the coset `a + K_k`, and `J_k = {φ_k > 1/2} ⊆ X × Y_k`, stationary. `J_k` is a.e.-independent: for `(x, a), (x + s, a + b)` in `J_k` with
`s ∈ T_X`, `b ∈ S_k`, the function `f(y) = ν_Y{u ↦ b : y + u ∈ I^{x+s}}` on `a + K_k` has values in `[0, 1/|S_k|]` and integral
`m(K_k)φ_k(x + s, a + b)/|S_k|`, so `∫ 1_{I^x} f ≥ m(K_k)(φ_k(x,a) + φ_k(x+s,a+b) − 1)/|S_k| > 0` — a positive measure of `I`-edges.
Then `P(0 ∈ I) = E φ_k ≤ P(0 ∈ J_k) + E[φ_k·1{φ_k ≤ 1/2}]`, and the last term → 0 by martingale convergence on the fibres. ∎ With `X` a point:
the measurable ratio of a profinite Cayley graph is at most its all-levels ratio.

**X25B-W (weak approximation for the circle).** `U` is dense in `∏_{v ∈ Σ} U_v` for every finite set `Σ` of places of `F` (real, stable,
split). *Proof:* `t ↦ ((1 − t²) + 2ti)/(1 + t²)` maps `F_w ∪ {∞}` onto the local circle; approximate `t_v = y_v/(1 + x_v)` in `F` (weak
approximation in `F`) and use continuity. ∎ Hence `T_∅` is the full product of the local circles, and `T_S` adds, per split `w`, the
closure in `L_v` (all of `F_w` if `v̄ ∉ S`) or the hyperbola `{(a, a⁻¹)}` if both `v, v̄ ∈ S`.

**X25B-T (TCA-cls at `S = ∅`, totally real `F`).** *Proof.* Suppose `μ` exists. R88-TC-ext gives `c̃` on
`G_∅ = ℂ^{r₁} × Y`, `Y = ∏_{stable} O_{L_v}`; its classes `I_j` are stationary, a.e.-independent (Fubini on `P(c̃(x) = c̃(x+w)) = 0`), with
`Σ_j P(0 ∈ I_j) = 1`, so `max_j P(0 ∈ I_j) ≥ 1/4`. But by X25B-W the graph is the categorical product of the local ones, and
`r(G_∅) ≤ sup_k r(ℂ^{r₁} × Y_k)` (X25B-L1) `≤ max(r(ℂ^{r₁}), sup_k r(Y_k))` (X25B-PZ) `≤ max(m₁(ℝ²), sup_v r_v)`: `r(ℂ, S¹) ≤ m₁` (the
ergodic average of a realisation has upper density `≥ P(0 ∈ W)` in some realisation, and an edge-null set is a.e. its Lebesgue density
points, which avoid distance 1), PZ iterated over the real places; `Y_k` is a finite product of level graphs `G_{v,k}`, PZ iterated,
`r(G_{v,k}) = α/|G_{v,k}| ≤ r_v`. **`sup_v r_v < 1/4`:** each `r_v < 1/4` by hypothesis; all but finitely many stable places are unramified
with residue norm `Q → ∞`, and there the level-`j` Hoffman bound, `λ_min(G_j) = Q^{j−1}λ_min(G₁)`, `|λ_min(G₁)| ≤ 2√Q` (Weil), gives
`r_v ≤ 2√Q/(Q + 1 + 2√Q) → 0`, so the supremum is a maximum. `max(0.247, max_v r_v) < 1/4`: contradiction. ∎
*Finite `S`:* each split factor joins the product by PZ; `v ∈ S`, `v̄ ∉ S`: the factor is `Cay(F_w, F_w)` (every two points adjacent), whose
a.e.-independent sets are null (`∫_W ν(W − x)dx > 0` for `ν ~ Haar`), ratio 0; `v, v̄ ∈ S`: ratio 0 is C14.2 (c) (R88-J28V-6, input).
So TRUE for finite `S` over totally real `F`, given that input.

**X25B-G1 (the GAP, by scope).** A real field with a complex place `w` has an archimedean split factor `Cay(ℂ², {(a, a⁻¹)})` in `G_S`. Its
ratio is not derived here and is not among the named inputs (m₁ covers real places; C14.2 (c) is non-archimedean). Its neighbourhood of 0
has triangles (`b = ωa`) and no `K₄`, so no clique bound gives `< 1/4` for free. Every field in T1 is totally real, so T1's consumers are
unaffected; the class statement's "every real field" needs this step or a restriction to totally real fields.

**Audit against selection (standing rule 4).** Where could this be wrong in the flattering direction? (a) PZ's step (3) — each case was
written out; the fourth uses the symmetry of `T_H` and `ν_H` (true: unit circles and hyperbolas are symmetric). (b) L1's inequality needs
the image measure on `S_k` uniform (reduction of a compact group by a homomorphism: fibres are cosets) — true at stable places, where
`S_k` is the image of `U_v → (O/𝔭^k)^×`. (c) `r(ℂ) ≤ m₁` uses R88-TC-reg's density-point fact in its elementary form (a Lebesgue density
point of an edge-null planar set has no density point at distance 1: two density points at distance 1 would give positively many
unit-distance pairs). (d) The strict `sup < 1/4` needed a tail argument; without the tail (infinitely many places each `< 1/4` accumulating at
`1/4`) the proof would fail — the Weil tail excludes it.

## Would-have-searched-here log

- Stage 2: none. Every step is a hand derivation; no enumeration was run or wanted.
