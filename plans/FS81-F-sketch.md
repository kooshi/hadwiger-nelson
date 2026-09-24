# FS-81 §F — the planner's proof sketch of F-T4 (grade [hand], one mind; checked but not independently derived)

> **Stage-C verifier: do not open this file until your own verdict on L1–L4 is committed** (`plans/FS81-quadratic-four-colours.md`
> §S.C). Everyone else may read it.

*Written 2026-09-24 by the FS-81 planner (de Bruijn). The statements are in the plan's §F. What has been checked:*
- *Poros attacked points 1–5 below and found no break. It re-scanned T40's cells at step 1/300, re-derived the dual lattice, and
  proposed the indexing used in L1.*
- *The owner re-derived L2's lattice arithmetic and the case split, and grid-checked T40 at 1/600 (close inventory item 22).*

*Nobody has derived it independently. That is stage C.*

**Notation.**
- F ⊆ ℝ is a subfield, U_F the unit vectors of F² read in F(i), and `R_F = ℤ[U_F]` their additive span.
- R_F is a ring, because U_F is a multiplicative group and products distribute. It is the component of 0 of F²'s unit-distance
  graph, so χ(F²) = χ(Cay(R_F, U_F)).
- `R₅ = ℤ[i][1/5]`, `w = (3+4i)/5 = (2+i)/(2−i)`, `U₅ = {iᵏwᵐ}`.
- `θ₂(x) = (x mod (1+i))/2`. It is well defined on R₅ because 1/5 ≡ 1 (mod 1+i).
- `λ_e(x) = Re(ē x) = ⟨e, x⟩` (mod 1), for e ∈ ℂ.

## L1. χ(F²) ≤ 3 ⟹ Θ₃(F) ≠ ∅

1. For each finite symmetric S ⊂ U_F, `Cay(⟨S⟩, S)` is a subgraph of F²'s graph, so it is three-colourable.
2. By T22's ⟹ direction (FS73-T21–T22, T42: torsion-free, S = −S finite, no generation hypothesis) some θ ∈ Hom(⟨S⟩, ℝ/ℤ) has
   θ(S) ⊆ [1/3, 2/3].
3. It extends to R_F because ℝ/ℤ is divisible. So `K_S = {ψ ∈ Hom(R_F, ℝ/ℤ) : ψ(S) ⊆ [1/3, 2/3]}` is closed and nonempty.
4. `K_{S ∪ S′} ⊆ K_S ∩ K_{S′}`, so the family has the finite intersection property. The dual group is compact, so
   `⋂_S K_S = Θ₃(F)` is nonempty. (This indexing is Poros's; the planner's first version indexed by the chain Λ_M.)

## L2. Θ(U₅) = {θ₂ + λ_e : |e| ≤ 1/6} ∪ F4, where F4 is the four characters through ℤ[i]/3 nonzero on ±1, ±i

1. **Level one.** Characters of `(1/5)ℤ[i]` are represented by μ ∈ ℝ²/5ℤ², via x ↦ ⟨μ, x⟩. Those putting U^(5) (the 12 rational
   unit vectors of denominator dividing 5) in the band are exactly `c0 + (D0 ∪ F4) + 5ℤ²`. Here c0 = (5/2, 5/2) represents θ₂, D0
   is the dodecagon `{|⟨δ, x⟩| ≤ 1/6 on U^(5)}` with circumradius 0.1757, and F4 = c0 + (±5/6, ±5/6).
   - This is FS73-T40, computed exactly by E and V2 and re-run on 2026-09-24 (`tools/fs73v2_thetaR.py`).
   - Poros grid-checked it at step 1/300 and the owner at 1/600.
   - Every point is in D0's disc or exactly at F4.
2. **Translates.** For θ ∈ Θ(U₅), let ψₘ = θ(wᵐ·) restricted to (1/5)ℤ[i]. Then ψₘ is in the level-one set, because wᵐU^(5) ⊂ U₅.
   Let eₘ be its unique representative in D0 ∪ F4 (the pieces are disjoint mod 5ℤ²).
3. **Compatibility.** Let `L″ = {x ∈ (1/5)ℤ[i] : wx ∈ (1/5)ℤ[i]}`. Then 5x = y ∈ ℤ[i] with (2−i) | (2+i)y, so (2−i) | y, and
   L″ = ((2−i)/5)ℤ[i].
   - For x ∈ L″, ψ_{m+1}(x) = ψₘ(wx), and ⟨μ, wx⟩ = ⟨w̄μ, x⟩.
   - θ₂ is w-invariant (w ≡ 1 mod (1+i)), so c0 − w̄c0 lies in the dual lattice (L″)*. (The owner computed it: −1 + 3i.)
   - 5ℤ[i] ⊆ (L″)*, and w̄·5ℤ[i] ⊆ (L″)*.
   - Hence e_{m+1} − w̄eₘ ∈ (L″)*.
4. **The dual lattice.** Under ⟨a, b⟩ = Re(ā b), the dual of αℤ[i] is (1/ᾱ)ℤ[i]. So (L″)* = (5/(2+i))ℤ[i] = (2−i)ℤ[i], whose shortest
   nonzero vector has length √5 ≈ 2.236.
5. **Norms.** Differences between two points of D0 are at most 0.351. Differences between D0 and F4 lie in [1.003, 1.354], and are
   nonzero. Both ranges are below √5. So consecutive types agree (no D0 ↔ F4 switch), and on D0, e_{m+1} = w̄eₘ exactly. Differences
   between two F4 points can reach 2.357 > √5, but they are never used.
6. **Generation.** wᵐ(1/5)ℤ[i] = (2+i)^{2m}5^{−m−1}ℤ[i], and the pieces for m and −m sum to 5^{−(m+1)}ℤ[i], because (2+i)^{2m} and
   (2−i)^{2m} are coprime. So the translates generate R₅.
7. **Disc type.** θ and θ₂ + λ_{e₀} agree on every piece, since θ₂(wᵐx) = θ₂(x) and ⟨e₀, wᵐx⟩ = ⟨w̄ᵐe₀, x⟩. So θ = θ₂ + λ_{e₀}.
   Each w̄ᵐe₀ lies in D0, and w has infinite order, so e₀ lies in the intersection of all rotations of D0 by powers of w, which is
   the disc |e| ≤ 1/6. Conversely, every such θ is in Θ(U₅).
8. **F4 type.** Every ψₘ has order 3 (3·(10/3) = 10 ∈ 5ℤ), so 3θ vanishes on every piece, so 3θ = 0. Then θ factors through
   R₅/3R₅ = ℤ[i]/3 = 𝔽₉. The image of U₅ there is {±1, ±i}, so θ(1), θ(i) ∈ {1/3, 2/3}, which gives four characters, all of which
   lie in Θ(U₅).

## L3. Layers

For θ ∈ Θ₃(F) and b ∈ U_F: bR₅ ⊂ R_F, because R_F is a ring containing b and R₅ = ℤ[U₅] ⊂ R_F. So x ↦ θ(bx) is a character of R₅,
and θ(bu) ∈ [1/3, 2/3] for u ∈ U₅ because bu ∈ U_F. So θ_b ∈ Θ(U₅), and by L2 it is of disc type or F4 type.

**A lemma used twice.** An archimedean character of finite order on R₅ is zero. If kλ_E = 0, then k·Re(Ē·5^{−j}) and
k·Re(Ē·i·5^{−j}) are integers for every j, so E = 0. The same holds on N·R₅ for any N ≥ 1.

## L4. Gluing

Suppose `1 = Σ_j c_j u_j` with u_j ∈ U_F, 3 | c_j for every j, and Σ_j c_j even. For b ∈ U_F and x ∈ R₅, applying θ to
bx = Σ c_j (b u_j) x gives

  θ_b = Σ_j c_j θ_{b u_j}   on R₅.   (R1)

- **θ_b of F4 type is impossible.** Each F4 term on the right is killed by c_j, since 3 | c_j. Each disc term contributes
  c_j θ₂ + λ. So θ_b = εθ₂ + λ_E, and λ_E = θ_b − εθ₂ has finite order, so E = 0. Then θ_b = εθ₂ has order at most 2 and
  divides 3, so θ_b = 0, which contradicts θ_b(1) ∈ [1/3, 2/3].
- **So every layer is of disc type.** The right side's parity coefficient is Σ c_j ≡ 0 (mod 2), so θ₂ + λ_{e_b} = λ_E. Then θ₂ is
  archimedean of finite order, so θ₂ = 0, which is impossible.

Hence Θ₃(F) = ∅.

## F-T4

- **Constructing the relation.** 1/3 ∈ ℤ[U_F] gives 1 = Σ 3a_j u_j. Let the parity of Σ a_j be p.
  - If Σ 3a_j is even, that relation serves.
  - If it is odd: F² is not 2-colourable, so there is an odd closed walk, that is, a relation 1 = Σ d_j u_j with Σ d_j even (by
    ASTRA-T3's walk-parity homomorphism, or Fischer's Thm 3). Then 1 = 3·Σ d_j u_j − 2·Σ 3a_j u_j has coefficients divisible by
    3, and its coefficient sum is 3Σd_j − 6Σa_j ≡ 0 (mod 2).
- **So L4 applies, Θ₃(F) = ∅, and by L1 χ(F²) ≥ 4.**
- **For ℚ(√d), d ≡ 11 (mod 12), explicitly.** n = (d+1)/4 is an integer and 3 | n. v = ((2n−1) + i√d)/(2n) is a unit vector, and
  v + v̄ = 2 − 1/n, so `1 = n(2 − v − v̄)`. The coefficients are 2n, −n, −n: all divisible by 3, and summing to 0.
  - This is `[Fischer1990]` Thm 10(ii)'s relation, and his Example 4 at 167.
  - Only the layers {1, v, v̄, v², v̄²}·U₅ are used.

## §F.5 Poros's extension (hand, Poros; both mixed cases re-derived by the planner)

Let d ≡ 3 (mod 4) with 3 ∤ n, that is d ≡ 3, 7 (mod 12). Apply R1 to the relation 1 = n(2 − v − v̄):

  θ_b = n(2θ_b − θ_{bv} − θ_{bv̄}).

Suppose θ_b is of disc type.
- **Both neighbours disc:** parity coefficient 0, a contradiction as above (this case never needs 3 | n).
- **Exactly one neighbour F4:** (1 − n)θ₂ + nχ = λ. So λ = 0, and (1 − n)θ₂ = −nχ, where the left side has order at most 2 and the
  right side order dividing 3. So nχ = 0, and 3 | n, a contradiction.
- **Both neighbours F4:** θ₂ = λ − n(χ + χ′). So λ = 0, and θ₂ is of order dividing 3, a contradiction.

So every layer is of F4 type, θ(R_F) ⊆ (1/3)ℤ/ℤ (R_F = Σ_b b·R₅), and θ factors through R_F/3R_F: an additive colouring mod 3.
**Every three-colouring slope of ℚ(√d)², d ≡ 3, 7 (mod 12), is additive mod 3.** `[Fischer1990]` Thm 9's three-colourings are
additive mod 3 in his text (re-read 2026-09-24, the plan's §PA.3), so the negative control passes.

## Where it could fail (the planner's list for stage C)

1. L1's reliance on T22 ⟹ (hand, derived twice plus V2's forward lift; never in the kernel).
2. L2's single computational input (T40's cell list). Re-derive it on a second code path.
3. The dual-lattice arithmetic and the norm margins in L2 step 5.
4. Hidden finite generation in any step.
5. Consistency with known fields. At ℚ(√3), ℚ(√7) and d ≡ 3, 7 (mod 12), 1/3 ∉ ℤ[U] because of a stable prime above 3. At ℚ(√11)
   the kernel agrees with the conclusion.
