# The geometric fractional blow-up stays inside the field

*FS-56 phase B, 2026-09-16. The derivation `tools/fs56_gf_check.py` cites. Written for a reader who trusts none of this project and
has `[MatolcsiEtAl2025]` (arXiv:2311.10069, v4) open beside it; section and equation numbers below are theirs.*

## Statement

For a subfield `F ⊆ ℝ` write `F²` for the unit-distance graph on the points of the plane with both coordinates in `F`. For a
finite `H ⊂ F²` and an integer `k ≥ 1`, let `χ_gf(H; k)` be the least weight `Σ_S γ(S)` of a function `γ ≥ 0` on the independent
sets of `H` whose aggregate `γ̄(Y) = Σ_{S ⊇ Y} γ(S)` is constant on each congruence class of subsets of `H` with at most `k` points
and equals 1 on single points. (`k = |H|` is `χ_gf(H)` of MRVZ §2; `k = 1` is `χ_f(H)`.)

> **Theorem.** For every subfield `F ⊆ ℝ`, every finite `H ⊂ F²`, every `k` and every `ε > 0` there is a finite `G ⊂ F²` with
> `χ_f(G) ≥ χ_gf(H; k) − ε`. Hence `χ(F²) ≥ ⌈χ_gf(H; k)⌉`.

> **Corollary.** `χ_f(ℚ(√3,√11)²) = 4`, and every finite unit-distance graph over `ℚ(√3,√11)` has independence ratio at least
> `1/4`, with ratios arbitrarily close to `1/4` attained.

The corollary answers the first question of `[CranstonRabern2015]`'s conclusion (*"What is the fractional chromatic number of
ℚ(√3,√11) × ℚ(√3,√11)?"*), which they bracketed below by `76/21`; the upper bound 4 is Theorem B of this project
(`chromaticNumber_seamPlane`, kernel-checked). Prior-art search (FS-56 §PA, 2026-09-16): no citing work of either paper states
either result.

## B1 — every congruence between subsets of `F²` is an isometry of `F²`

Read points as complex numbers `x + iy`. Every isometry of `ℂ` is `z ↦ uz + t` or `z ↦ u z̄ + t` with `|u| = 1`. Let `φ` carry
`Y ⊂ F²` onto `Y′ ⊂ F²`, `|Y| ≥ 2`, and pick `y₁ ≠ y₂` in `Y`. In the first case `u = (φ(y₂) − φ(y₁))/(y₂ − y₁)`, in the second
`u = (φ(y₂) − φ(y₁))/(ȳ₂ − ȳ₁)`; both lie in `F(i)` because `F(i)` is a field closed under complex conjugation (`F` is real).
Then `t = φ(y₁) − u y₁` (or `− u ȳ₁`) lies in `F(i)`. So `φ` maps `F(i)` to itself, and `F²` onto `F²`. ∎

The set `Isom(F²)` of such maps is a group: translations by `F(i)`, rotations by `U_F = {u ∈ F(i) : uū = 1}`, and one reflection.
It is solvable — the translations are an abelian normal subgroup with quotient `U_F ⋊ ⟨conj⟩`, whose rotation subgroup is abelian of
index 2 — so every subgroup of it is solvable, and a solvable discrete group is amenable.

## B2 — MRVZ Theorem 1, with the field kept

Fix `F`, `H`, `k`, and write `𝒞` for the set of pairs `(Y, Y′)` of congruent subsets of `H` with `2 ≤ |Y| ≤ k`.

1. **The transformations.** Let `T` be the set of isometries `φ` with `φ(Y) = Y′` for some `(Y, Y′) ∈ 𝒞`, together with the
   identity. For each pair and each distance-preserving bijection `Y → Y′` there are at most two such isometries (one per
   orientation), so `T` is finite; it is closed under inverses (`(Y′, Y) ∈ 𝒞` too). By B1, `T ⊂ Isom(F²)`, so the group
   `K = ⟨T⟩` is countable and solvable, hence amenable, hence has a right Følner sequence: finite `R_m ⊂ K` with
   `|R_m T ∖ R_m| / |R_m| → 0` (MRVZ (15)–(16); `id ∈ T` gives `R_m ⊆ R_m T`).
2. **The graphs.** `G_m = ⋃_{σ ∈ R_m} σH` is a finite subset of `F²`, since each `σ ∈ Isom(F²)`.
3. **The average.** Let `γ` be a regular fractional colouring of `G_m` of weight `χ_f(G_m)` (regular colourings attain the minimum,
   MRVZ (5)). For `σ ∈ R_m`, `σ` is a graph isomorphism `H → σH` (it preserves distances), so pulling back the restriction of `γ`
   to `σH` gives a regular fractional colouring of `H` of the same weight, with aggregate `S ↦ γ̄(σS)` (MRVZ (9)–(11)). The
   average `γ₀` of these `|R_m|` colourings is a regular fractional colouring of `H` of weight `χ_f(G_m)`, with
   `γ̄₀(Y) = |R_m|⁻¹ Σ_{σ∈R_m} γ̄(σY)`.
4. **Near-invariance.** Let `(Y, Y′) ∈ 𝒞` and `τ ∈ T` with `τY = Y′`. Then
   `|R_m|·(γ̄₀(Y′) − γ̄₀(Y)) = Σ_{σ∈R_m} γ̄(στY) − Σ_{σ∈R_m} γ̄(σY) = Σ_{ρ∈R_mτ} γ̄(ρY) − Σ_{ρ∈R_m} γ̄(ρY)`.
   Every term is defined: for `ρ = στ` with `σ ∈ R_m`, `ρY = σY′ ⊆ σH ⊆ G_m`. The terms not cancelled are indexed by
   `R_mτ ∖ R_m ⊆ R_mT ∖ R_m` and by `R_m ∖ R_mτ`, which `ρ ↦ ρτ⁻¹` maps into `R_mτ⁻¹ ∖ R_m ⊆ R_mT ∖ R_m`. Each term is at most
   the weight `χ_f(G_m) ≤ χ(ℝ²) ≤ 7` (MRVZ use 4.36; any finite bound serves). So
   `|γ̄₀(Y′) − γ̄₀(Y)| ≤ 14·|R_mT ∖ R_m| / |R_m| → 0`, uniformly over the finitely many pairs.
5. **Compactness** (MRVZ (7)–(8)). The regular fractional colourings of `H` of weight at most 7 form a compact polytope, on which
   `γ ↦ max_{(Y,Y′)∈𝒞} |γ̄(Y) − γ̄(Y′)|` is continuous and vanishes exactly on the feasible set of `χ_gf(H; k)`. If weights
   `≤ χ_gf(H; k) − ε` occurred along violations tending to 0, a limit point would be feasible with weight `≤ χ_gf(H; k) − ε`.
   So for `m` large, `χ_f(G_m) = weight(γ₀) > χ_gf(H; k) − ε`. ∎

The colour count: `χ(F²) ≥ χ(G_m) ≥ χ_f(G_m) > χ_gf(H; k) − ε` for every `ε`, so `χ(F²) ≥ ⌈χ_gf(H; k)⌉`.

## B3 — the corollary

`G27` (MRVZ Definition 2) has Moser coefficients `(a, b, c, d) ∈ ℤ⁴`, so its points `a + bω₁ + cω₃ + dω₁ω₃` with
`ω₁ = 1/2 + i√3/2`, `ω₃ = 5/6 + i√11/6` lie in `K²`, `K = ℚ(√3,√11)`. MRVZ Theorem 3: `χ_gf(G27) ≥ 4` (with `k = |G27|`). By B2,
finite `G ⊂ K²` have `χ_f(G) > 4 − ε`; a fractional colouring of `K²` restricts to one of `G` of no larger weight, so
`χ_f(K²) ≥ 4`. A proper four-colouring of `K²` (Theorem B) is a fractional colouring of weight 4. ∎

**Independence ratio.** Every finite `G ⊂ K²` is four-colourable, so `α(G) ≥ |G|/4`. For the other direction, MRVZ Theorem 2's
proof bounds `χ_f(G) ≤ 1/α₁` where `α₁` is the infimum of independence ratios over finite subgraphs, using an independent subset
of a large cube in the lattice spanned by `G`'s vertices — a lattice inside `K²`. So the infimum over finite `G ⊂ K²` is `1/4`. ∎

**Re-verified here, not taken on trust.** `tools/fs56_mrvz_import.py` converts MRVZ's published witness (bit.ly/fcn-4: Moser
coefficients, 16,855 congruence maps, the rational dual `y`) into the class-sum form below, taking nothing else from the authors;
`tools/fs56_gf_check.py` recomputes the graph from exact arithmetic in `ℚ(√3,√11)` (49 unit edges, matching their adjacency
matrix), decides every congruence by its own isometry test, enumerates all 182,304 independent sets (the authors' count), and
CERTIFIES `χ_gf(G27) ≥ 4` in 12 s (`data/fs56/g27/check-g27.log`). Five planted faults, each with its expected reason, and a
relabelled faithful twin: 5/5 as designed (`data/fs56/g27/controls-g27.json`).

## B4 — a consistency check against `[DuczVarga2026]`

Their `G29 = G27 ∪ {p, q}` has `χ_gf(G29) > 4.0007`. By B2 no field containing `G29` can have a four-colourable plane. Their `p`
involves `√5` and their `q` involves `η = i√((415 + 79√33)/8)`: both leave `K`, as Theorem B requires.

## The certificate form the checker reads

A finite `H ⊂ F²` with `F = ℚ(√d₁,…,√d_r)` (squarefree, pairwise coprime `d_j > 1`), a level `k`, and rational weights `y_Y` on
listed sets `1 ≤ |Y| ≤ k` such that (i) each congruence class of listed sets with `|Y| ≥ 2` sums to 0; (ii) the singletons sum to
`w`; (iii) every independent set `S` of `H` has `Σ_{Y ⊆ S} y_Y ≤ 1`. **Lemma.** Then `χ_gf(H; k) ≥ w`. *Proof.* For feasible `γ`:
`Σ_S γ(S) ≥ Σ_S γ(S) Σ_{Y⊆S} y_Y = Σ_Y y_Y γ̄(Y)`, and `γ̄` is constant on each class — `γ̄_c` — with value 1 on the singletons, so
the sum is `Σ_c γ̄_c Σ_{Y∈c} y_Y = w`. ∎ Grouping congruent sets into several classes only weakens (i)'s demands on `γ`, so the
lemma needs only that sets grouped together are congruent, which the checker's exact isometry test guarantees.

**Dependencies, stated plainly.** B1, B2, the lemma: hand proofs above. B3: B2, MRVZ Theorem 3 as re-verified by our checker, and
Theorem B (kernel). Nothing here is kernel-checked beyond Theorem B; a formal B2 would need amenability and Følner sequences for
countable solvable groups.
