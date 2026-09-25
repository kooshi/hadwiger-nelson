# J12 — lemma statements for the blind verifier (statements only; no proofs)

*From `plans/FS91-S1D-one-prime.md` (J12's record, crunch of 2026-09-25). Each statement is self-contained; ids are J12's.*

## Notation (fixed for every statement)

- `p` a prime `≡ 1 (mod 4)`, `p = π π̄` in `ℤ[i]` (any choice of `π`); `w := π/π̄`; `R := R_{{p}} = ℤ[i][1/p]`; `U := ⟨i⟩ × ⟨w⟩ ⊂ R^×` (the unit
  vectors of `ℚ(i)` with `p`-power denominators); `S₊ := ℤ[i][1/π̄]`, `S₋ := ℤ[i][1/π]`.
- `⟨c, x⟩ := Re(c̄ x)`; `λ_d := ⟨d, ·⟩ mod 1` (archimedean characters, `d ∈ ℂ`); for `c ∈ ℚ(i)` whose order in `ℚ(i)/ℤ[i]` is prime to `p`, `τ_c`
  is `⟨c, ·⟩ mod 1` on `ℤ[i]`, extended uniquely to `R`. `T` = torsion characters of `R`, `A` = archimedean characters.
- `B := [1/4, 3/4] ⊂ ℝ/ℤ`; `Θ₄(R) := {θ ∈ Hom(R, ℝ/ℤ) : θ(U) ⊆ B}`. `P := (1+i)/2`, `C := (1+i)/3`, `θ₂ := τ_P`.
- For `p = 5` only: `π = 2 + i`, `w = (3+4i)/5`, `u := iw`, `ω := ū = (−4−3i)/5`, `Q₀ := [−1/4, 1/4]² ⊂ ℂ`, `R_c(z) := c + ω(z − c)`,
  `C₉ := {0, (±1 ± i)/6, ±1/3, ±i/3}`, `c₀ := −(1+i)/6`. S0B-T1's layer sequence of `θ` is `e_m := θ(w^m) + iθ(iw^m) ∈ ℂ/ℤ[i]`.
- A *centre word* is a finite sequence in `C₉`; a sequence `(z_m)` in `Q₀` is *admissible with centres `(c_m)`* if `z_{m+1} = R_{c_m}(z_m)` for
  all `m`. The *margin* of an admissible (finite or periodic) orbit is `min_m (1/4 − max(|Re z_m|, |Im z_m|))`.

## ONE-a (any `p`)

- **J12-A1.** `S₊ ∩ S₋ = ℤ[i]`; `S₊ + S₋ = R`; `iᵏwᵐ ∈ S₊` for `m ≥ 0` and `iᵏwᵐ ∈ S₋` for `m ≤ 0`.
- **J12-A2.** If `χ₊ ∈ Hom(S₊, ℝ/ℤ)` and `χ₋ ∈ Hom(S₋, ℝ/ℤ)` agree on `ℤ[i]`, there is exactly one `θ ∈ Hom(R, ℝ/ℤ)` restricting to both.
- **J12-A3.** For every `u ∈ U`: `θ₂(u) = 1/2` and `τ_C(u) ∈ {1/3, 2/3}`.
- **J12-ONEa.** The character `θ` equal to `τ_C` on `S₊` and to `θ₂ + λ_{C−P}` on `S₋` exists, lies in `Θ₄(R)`, and is not in `T + A`. Hence
  "`Θ₄(R_{{p}}) ⊄ T + A` for every prime `p ≡ 1 (mod 4)`."
- **J12-HL.** If `τ₁ ≠ τ₂` are torsion characters of `R` of order prime to `p` and `d₁, d₂ ∈ ℂ` satisfy `τ_j + λ_{d_j} ∈ Θ₄(R)` (`j = 1, 2`) and
  `τ₁ + λ_{d₁} = τ₂ + λ_{d₂}` on `ℤ[i]`, then gluing `τ₁ + λ_{d₁}` on `S₊` to `τ₂ + λ_{d₂}` on `S₋` gives an element of `Θ₄(R)` outside `T + A`.

## ONE-b (`p = 5` unless marked)

- **J12-B1.** The map `θ ↦ (z_m)`, `z_m := lift(ī^m e_m) − P` with the lift of `ī^m e_m` taken in `[1/4, 3/4]²`, is a homeomorphism from `Θ₄(R₅)`
  onto the set of sequences `(z_m)_{m∈ℤ}` in `Q₀` admissible with centres in `C₉`; it carries `θ ↦ θ∘u` to the shift and `θ ↦ θ∘i` to `z ↦ −iz`.
  (The centre at step `m` is `(z_{m+1} − ωz_m)/(1 − ω)`.)
- **J12-B2.** `θ ∈ Θ₄(R₅)` lies in `T + A` iff its centre sequence is (bi-infinitely) periodic.
- **J12-B3.** If `(q_m)` is admissible with centres `(c_m)` and margin `r`, then for every `δ ∈ ℂ` with `|δ| ≤ r` the sequence `q_m + ω^m δ` is
  admissible with the same centres.
- **J12-B4.** A `U₅`-minimal closed subset of `Θ₄(R₅)` that meets `T + A` is either a finite `U₅`-orbit of torsion characters or a finite union of
  sets `{σ + λ_d : |d| = ρ}` (`ρ > 0` fixed, `σ` running over a finite `U₅`-orbit of torsion characters).
- **J12-B5.** "Every `U₅`-minimal closed subset of `Θ₄(R₅)` is contained in `T + A`" fails iff some `θ ∈ Θ₄(R₅)` is uniformly recurrent under `U₅`
  and has a non-periodic centre sequence.
- **J12-B6.** If centre words `A`, `B` are each admissible from every point of a nonempty compact `K ⊆ Q₀` and their composites map `K` into `K`,
  then `A` and `B` are powers of one word. Also: two distinct torsion characters in `Θ₄(R₅)` never have the same `z₀`.
- **J12-CL.** Let `(q_m)`, `(q′_m)` be admissible periodic orbits with primitive centre words `W`, `W′`, `q₀ = Q`, `q′₀ = Q′`, `D := |Q − Q′| > 0`,
  margins at least `r`, `r′ > 0`. For `a, b ≥ 1` let `x := ω^{a|W|}`, `y := ω^{b|W′|}`, `R^a(z) := Q + x(z − Q)`, and let `Q″` be the fixed point of
  `z ↦ Q′ + y(R^a(z) − Q′)`; in coordinates with `Q = 0` and `Q′ = D > 0`, `Q″ = D(1 − y)/(1 − xy)`. If `|Q″ − Q| ≤ r` and `|R^a(Q″) − Q′| ≤ r′`, then
  the periodic sequence with centre word `W^a W′^b` from `Q″` is admissible, with margin at least `min(r − |Q″ − Q|, r′ − |R^a(Q″) − Q′|)`.
- **J12-CL′.** In J12-CL, if the open lens `B(Q, r) ∩ B(Q′, r′)` is nonempty, then the points `Q″` obtained from pairs `a, b ≥ 2` for which both
  inequalities hold strictly are dense in that lens. Necessary for any solution: `r + r′ > D`.
- **J12-H.** There are admissible periodic orbits `τ₀, τ₁, τ₂, …` with centre words `W₀ = (0)`, `W₁ = (c₀)`, `W_{n+1} = W_n^{a_n} W_{n−1}^{b_n}` for
  some `a_n, b_n ≥ 2`, and positive margins.
- **J12-W.** For any `a_n, b_n ≥ 2`, the words of J12-H are primitive, strictly increasing in length, and `W_nW_n` is a factor of `W_{n+1}`.
- **J12-Ω.** For the words of J12-H, `Ω := {s ∈ C₉^ℤ : every finite factor of s is a factor of some W_n}` is a minimal subshift with no
  periodic point.
- **J12-MS.** There is a `U₅`-minimal closed subset of `Θ₄(R₅)` disjoint from `T + A`; i.e. "Is every `U₅`-minimal closed subset of `Θ₄(R₅)`
  contained in `T + A`?" has the answer **no**. Its points are switching characters between the parity leaf and the `X₃` leaf through `C`,
  uniformly recurrent, with bounded runs in both directions.
- **J12-MSp (any `p`).** The same holds for `R_{{p}}` at every prime `p ≡ 1 (mod 4)`.

## ONE-c (`p = 5` unless marked)

- **J12-C1.** For `e ∈ N^{−1}ℤ[i]/ℤ[i]` of order `N`, `5 ∤ N`: `τ_e ∈ Θ₄(R₅)` iff every point `(tπ̄²)^m e` (`m ≥ 0`, `t ∈ ℤ`, `5t ≡ 1 mod N`) lies
  in `[1/4, 3/4]²` modulo `ℤ[i]`.
- **J12-C2.** If `z₀, …, z_L` is admissible with centre word `V`, every point at distance `≥ r` from `∂Q₀`, and `|z_L − z₀| ≤ r|1 − ω^L|`, then the
  periodic sequence with centre word `V^∞` through the fixed point of `V`'s composite is admissible.
- **J12-C3.** For every pair `a, b ≥ 1` with `|Q″ − c₀| ≤ 1/12` and `|R^a(Q″)| ≤ 1/4` (J12-CL with `W = (c₀)`, `Q = c₀`, `r = 1/12`, `W′ = (0)`,
  `Q′ = 0`, `r′ = 1/4`), the character `τ_{a,b}` with centre word `c₀^a 0^b` is a band torsion character, of order `N_{a,b} > √(a + b)`; there are
  infinitely many such pairs. Hence "the orders of band torsion characters of `R₅` are unbounded".
- **J12-C4.** `N_{a,b}` divides `2·Nm(π^L − (−i)^L π̄^L)`, `L = a + b`.
- **J12-C3p (any `p`).** The orders of band torsion characters of `R_{{p}}` at four colours are unbounded, at every prime `p ≡ 1 (mod 4)`.
- **Instances (exact).** The pairs `(a, b)`, `1 ≤ a, b ≤ 10`, satisfying J12-C3's two inequalities are exactly `(1,5), (1,10), (2,5), (2,10), (3,5),
  (4,5), (4,10), (6,5), (6,10), (7,5), (7,10), (9,5), (9,10), (10,5)`, with orders `234, 9111, 498, 20592, 224, 3834, 152886, 6074, 236096, 20592,
  848643, 50962, 2029123, 56142`.
