# FS-89 Stage 0A — blind verification of the gluing (verifier G)

Brief: `data/fs89/briefs/S0A-gluing-verifier-brief.md` (commit 0a346e98). Verifier G, Opus 5.5, 2026-09-25.
Closed until every C1 verdict is saved: the advisor's record, the FS-89 stub's banner, the close inventory, the S0B record and
`data/fs89/s0b/`, `git log` from 052707ac on. None opened.

## C0 — predictions (written before any file other than the brief was read and before any derivation was written)

Honesty note: these were written after reading the brief and a first mental pass over the statements (a few minutes of thought,
nothing written, no file read). They are priors of that moment, not of a blank mind.

| statement | predicted verdict | probability |
|---|---|---|
| G0 (setup: the rational ring, the layers, restriction is a band character) | true, elementary | 0.97 |
| G1 (the gluing), as stated with a fixed `N` | true | 0.85 |
| G1 without a fixed `N` (only `⊆ T + A`) | true, because the band condition itself bounds the torsion order on `ℤ[U_ℚ]` | 0.6 |
| G1's "hence HD1 for ℚ(√59), ℚ(√83), ℚ(√131)" via FS86-dB-Theta | true, if dB-Theta's hypothesis is exactly `T + A` | 0.7 |
| G2 (ℚ(√47): `Θ₄(R) = ∅` under the hypothesis) | true conditionally; needs a per-place argument that the gluing does not supply | 0.7 |
| G3 (ℚ(√167): `Θ₅(R) = ∅` under the five-band rational statement) | true conditionally, but the per-place and product (several places at once) facts it needs are real work | 0.55 |
| the four-band rational statement `Θ₄(ℤ[U_ℚ]) ⊆ T + A` itself | open; it carries the same "infinitely many split places" difficulty as HD1 | 0.5 true |

Where I expect the weight to sit: the gluing step itself should be easy because `ℤ[U_ℚ]` is 5-divisible, which makes the
archimedean part of a character canonical; the real content is (a) whether the fixed `N` is automatic and (b) whether the
rational statement moves the infinitely-many-places difficulty rather than removing it.

## C1 — blind verdicts

Conventions. `F ⊆ ℝ` any subfield (not only number fields); `L = F(i)`; `U = U_F`; `R = R_F = ℤ[U]`, which is the additive span of `U`
(a product of unit vectors is a unit vector). `Q := ℤ[U_ℚ]`. `A(X)` for `X ⊆ L` is the set of `x ↦ ℓ(x) mod 1` with `ℓ ∈ Hom_ℚ(L, ℝ)`;
this is the brief's "restriction of a real-linear functional on `L ⊗ ℝ`", because `Hom_ℝ(L ⊗_ℚ ℝ, ℝ) = Hom_ℚ(L, ℝ)` (a ℚ-basis of `L` is an
ℝ-basis of `L ⊗ ℝ`). `T_N(X)`: characters killed by `N`.

### G1 (the gluing) — verdict: TRUE as stated; and the fixed `N` is automatic, so it is also true with only `Θ₄(Q) ⊆ T + A`

**Theorem G1.** If `Θ₄(Q) ⊆ T_N(Q) + A(Q)` for a fixed `N`, then for every subfield `F ⊆ ℝ`, `Θ₄(R_F) ⊆ T_N(R_F) + A(R_F)`. [hand]

*Proof.* Let `θ ∈ Θ₄(R_F)` and put `φ := Nθ`.
1. **Each layer.** For `b ∈ U`, `θ_b(y) := θ(by)` is a character of `Q` (`y ↦ by` is additive and `bQ ⊆ R`, since `R` is a ring containing
   `b` and `U_ℚ`), and for `y ∈ U_ℚ`, `by ∈ U`, so `θ_b ∈ Θ₄(Q)` (G0). By hypothesis `θ_b = τ_b + α_b` with `Nτ_b = 0`, so
   `φ(by) = ℓ_b(y) mod 1` for all `y ∈ Q`, with `ℓ_b : ℚ(i) → ℝ` ℚ-linear.
2. **Every `x ∈ R` is a finite sum of unit vectors**, `x = Σ_j ε_j u_j` (`ε_j = ±1`), and `x/5^k = Σ_j ε_j u_j·5^{−k}` with `5^{−k} ∈ Q`
   (G0). So by step 1, `φ(x/5^k) = c_x/5^k mod 1` **for every `k ≥ 0`**, where `c_x := Σ_j ε_j ℓ_{u_j}(1) ∈ ℝ`.
3. **`c_x` depends only on `x`, not on the decomposition.** For `k` large, `|c_x/5^k| < 1/2`, so `c_x = 5^k·rep(φ(x/5^k))`, `rep` the
   representative in `(−1/2, 1/2]`. Hence `Φ(x) := lim_k 5^k·rep(φ(x/5^k))` is well defined on `R` and equals `c_x` for every
   decomposition. It is additive: for `k` large the representatives of `φ(x/5^k)`, `φ(x′/5^k)` and their sum are small, so they add
   without wrapping.
4. **`Φ` lifts `φ`:** `φ(x) = φ(5^k · x/5^k) = 5^k·φ(x/5^k) = 5^k·(c_x/5^k) = c_x = Φ(x)` in `ℝ/ℤ` (step 2 at any one `k`).
5. `Φ : R → ℝ` is additive and `R ⊗ ℚ = L`, so `Φ` extends uniquely to an element of `Hom_ℚ(L, ℝ)`. So `φ ∈ A(R)`.
6. Put `α := (Φ/N) mod 1 ∈ A(R)` and `τ := θ − α`. Then `Nτ = φ − Φ = 0` in `ℝ/ℤ`, so `τ ∈ T_N(R)`, and `θ = τ + α`. ∎

**Where the gluing lives, stated plainly.** The per-layer functionals `ℓ_b` agree on overlaps and relations (`Σ_j ε_j u_j = 0` forces
`Σ_j ε_j ℓ_{u_j}(1) = 0` **exactly in ℝ**, not merely mod 1) because every layer is uniquely 5-divisible: a character in `A` of a
5-divisible group has exactly one real lift that is compatible with division by 5 (`T(Q) ∩ A(Q) = 0`: if `Nℓ(Q) ⊆ ℤ` then
`Nℓ(5^{−k}) ∈ ℤ` and `Nℓ(i·5^{−k}) ∈ ℤ` for all `k`, so `ℓ = 0`). Nothing else is used: no field arithmetic, no place of `F`, no band. So
the step that makes the per-layer data one global functional is **sound, and it is the cheap part.** Three sharpenings of what it
actually uses (each checked against the proof above):
- **only the rational line of each layer**: the proof reads `θ_b` only on `ℤ[1/5] ⊂ Q`; so the hypothesis could be weakened to "for every
  `φ ∈ Θ₄(Q)`, `Nφ|_{ℤ[1/5]} ∈ A`". 5 is incidental: any one prime `p ≡ 1 (mod 4)` works the same way (`1/p ∈ Q`).
- **the band is never used** in the gluing: the same proof gives, at any band `[1/k, 1 − 1/k]`, `Θ_k(Q) ⊆ T_N + A ⟹ Θ_k(R_F) ⊆ T_N + A`
  (this is what G3 needs).
- **`F` can be any subfield of ℝ**, of any degree, with or without √3.

**Is "torsion of order dividing a fixed `N`" what the rational statement can deliver? Yes, automatically: `N = 168`.**

**Lemma N₀.** Every `φ ∈ Θ₄(Q) ∩ (T(Q) + A(Q))` has `φ = τ + α` with `τ` exactly one of: `0` (impossible, see below), a character of
2-power order dividing 8 read at the ramified prime `(1+i)`, a character of order 3 read at the inert prime 3 (then `|α| ≤ 1/12` on the
unit circle), or a character of order 7 read at the inert prime 7 (then `|α| ≤ 1/28`). So `Θ₄(Q) ∩ (T + A) ⊆ T_{168}(Q) + A(Q)`, and the
four types occur: `(3x + 2y)/8`, `(x + y)/4`, parity, the order-3 characters with both coordinates non-zero mod 3, and `(2x + 3y)/7`
(Coxeter's FS86-Cx-C9 functional). [hand; the existence of each type checked by hand on the residue circles]

*Proof.* `Q = ℤ[i][1/p : p ≡ 1 (4)]` is an `S`-integer ring, so `Q/MQ ≅ ∏_{v | M, v ∤ S} ℤ_v[i]/M` (CRT) and a torsion `τ` of order `M`
is a finite sum of local characters `τ_v` at the non-split places `v` of `ℚ(i)` (the ramified `(1+i)` and the inert `q ≡ 3 (4)`); it has
no component at a split `p` (Q is `p`-divisible). The norm-one torus `T = {x² + y² = 1}` is ℚ-rational (Cayley:
`u = (1 + is)²/(1 + s²)`), so it has **weak approximation**: `U_ℚ` is dense in `S¹ × ∏_{v ∈ S′} T(ℚ_v)` for every finite `S′`. So on
unit vectors `φ(u) = α(u_∞) + Σ_v τ_v(u_v)` with the coordinates independent and each summand continuous, and the closed band holds on
the whole product.
- *Odd `q`, level ≤ 1.* If `τ_q` has exact level `k ≥ 2` (kills `q^k`, not `q^{k−1}`), the elements `w = (1 + is)²/(1 + s²)`,
  `s ∈ q^{k−1}ℤ_q`, satisfy `w ≡ 1 + 2is (mod q^k)`, so for `t₀ ∈ T(ℤ_q)`, `τ_q(t₀w) = τ_q(t₀) + λ(t̄₀·2i s̄′)` with `λ ≠ 0` the
  character induced on `q^{k−1}/q^k ≅ 𝔽_{q²}`. The lines `t̄₀·i·𝔽_q`, `t̄₀ ∈ μ_{q+1}`, are `(q+1)/2 ≥ 2` distinct lines, so for some
  `t₀`, `λ` is onto on the line; fixing every other coordinate (weak approximation) the values of `φ` then fill a full coset
  `c + (1/q)ℤ/ℤ`, which meets the open arc `(−1/4, 1/4)` (length `1/2 > 1/q`). Contradiction.
- *Odd `q`, level 1: the middle half, and only at 3 and 7.* `C_q := τ_q(T(ℤ_q)) = {Tr(at)/q : t ∈ μ_{q+1}}` is symmetric and has at least
  `(q+1)/2` distinct values (a line `Tr(at) = c` meets the anisotropic conic `N(t) = 1` in at most 2 points). For every value `c` of
  the rest (α and the other places), `c + C_q` and `−c + C_q` lie in the band (the rest is symmetric), so `C_q` lies in
  `(band − c) ∩ (band + c)`: an arc centred at 1/2 of half-length `1/4 − ‖c‖` or at 0 of half-length `1/4 − ‖c − 1/2‖`. With
  `q = 4m + 3`, the arc about 0 holds at most `2m + 1 < (q+1)/2` residues; the arc about 1/2 holds `2m + 2 = (q+1)/2` residues only if
  `‖c‖ ≤ 1/(4q)`. So `C_q = {m+1, …, 3m+2}/q`, each value taken exactly twice, and every value of the rest is within `1/(4q)` of 0. Then
  `λ = Tr(a·)/q` four-colours `Γ_q`, impossible for every `q ≥ 11` (`χ(Γ_q) ≥ 5`: 11 kernel, 19, 23, 31, 43, 47 by G56's floors, the rest
  spectral; independently, the Fourier coefficient of the middle-half multiset is `1/sin(π/2q)`, which exceeds the Weil bound `2√q`
  from `q = 11` on: 7.03 > 6.63). At 3 and 7 it occurs (3: `Tr(a)`, `Tr(ai)` both non-zero; 7: `2x + 3y` takes each of 2, 3, 4, 5 exactly
  twice on the eight points of the 𝔽₇ circle, hand-checked). And the rest within `1/(4q)` of 0 kills every other torsion component (a
  second odd `q′` has `≥ (q′+1)/2` residues, more than the `q′/(2q) + 1` that fit in an arc of length `1/(2q)`; a non-zero 2-part takes a
  non-zero value in `(1/8)ℤ/ℤ` on `T(ℤ₂)`, since `T(ℤ₂) ∋ 1, i` spans `ℤ₂[i]`, and `1/8 > 1/(4q)`) and bounds `|α| ≤ 1/(4q)`.
- *At 2, level ≤ 3.* With `s = 2^j s′`, `w ≡ 1 + 2^{j+1} i s′ (mod 2^{2j+1})`. If `τ₂` has exact 2-level `k ≥ 5`, take `j = k − 3`: the
  values over `s′ mod 4` form a full coset of step `1/4` for `t₀ ∈ {1, i}` chosen so that `τ₂(2^{k−1}·i t₀) ≠ 0` — contradiction (the open
  arc of length 1/2 exceeds 1/4). At `k = 4`, directly: `w ≡ 1 + 4is′ − 8s′² (mod 16)` gives values `0, A − B, 2A, 3A − B` over
  `s′ = 0..3` with `A = τ₂(4it₀)` of order 4, again a full coset of step 1/4. So `k ≤ 3`: order divides 8; `(3x + 2y)/8` is band (unit
  vectors mod 8 are `(±1, 0), (±1, 4), (0, ±1), (4, ±1)`: `x² ≡ 1 (mod 16)` forces the odd coordinate to be `±1 (mod 8)` and the even one
  `≡ 0 (mod 4)`; values 3, 5, 2, 6).
- *τ = 0* is impossible: `α(U_ℚ)` is dense in `α(S¹) = [−r, r] ∋ 0`. ∎

**Consequence.** The brief's two readings of the hypothesis coincide: `Θ₄(Q) ⊆ T + A` ⟺ `Θ₄(Q) ⊆ T_{168} + A`. So G1 holds with the
weaker hypothesis too, and **no band character of any `R_F` can have layer restrictions in `T + A` of unbounded order**. [hand]
The number 168 = 8·3·7 is the product of the places of ℚ(i) whose residue targets have `χ_f ≤ 4` — the same 168 that decides
`L ≥ 5` among real quadratic fields (`d ≡ 47, 143, 167 mod 168`, G61).

**The adversarial attempt, by formula (C1's requirement).** The only way a band character could have every layer restriction in
`T + A` and not be in `T + A` globally is for the layer torsion orders to be unbounded (if `θ = τ + α` globally with `Mτ = 0`, each
`θ_b = τ|_b + α|_b` and `T ∩ A = 0` on `Q` makes that the layer decomposition). The natural formula: `F = ℚ(√2)`, where 3 is inert in
`F` with residue field `𝔽₉ ∋ i`, so the prime `𝔓` of `L` above 3 is **split** in `L/F` and `1/3 ∈ R_F`; take
`θ(x) = {Tr(a·ι_𝔓(x))}₃`, a 3-adic character. Its restriction to the layer `bQ` is `y ↦ {Tr(a ι_𝔓(b) y)}₃` with `y ∈ ℤ₃[i]`: a torsion
character at the inert 3 of `ℚ(i)`, of order `3^{m − v_𝔓(b)}`, unbounded as `b` runs over unit vectors with deeper poles at `𝔓` (they
exist: `b = z/z̄`, `z ∈ 𝔓^n`). So every layer restriction is in `T` and `θ ∉ T + A` (`R_F` is 3-divisible, so `θ` is no torsion
character, and it is not archimedean). **It fails to be a band character, and Lemma N₀ says exactly why:** on a layer where its 3-level
is ≥ 2 its values fill a coset of step 1/3. The attempt fails, and every attempt of this shape fails: **G1 has no gap.** [hand]

**G1's "hence HD1 for ℚ(√59), ℚ(√83), ℚ(√131)".** G1 gives `θ = τ + α` with `τ` a torsion character of `R_F`; a torsion character of
`R_F` is automatically "torsion at the stable places" (`R/NR` is supported there, since `1/p ∈ R` for every `p` with no stable prime,
G55). That is exactly FS86-dB-Theta's hypothesis, whose conclusion is that `θ` is a pullback character. So **conditional HD1 holds for the
three type-(B) fields**, at the grade of dB-Theta [hand, given V3 (FS-66's certificates at 11 and 19), `[Zhang2012]`, Lemma R].
**The condition is the whole content**: see C3 — the rational statement is itself the case `F = ℚ` of "`Θ₄(R_F) ⊆ T + A`", and it carries
the same infinitely-many-split-places difficulty at which both FS-86 competitors stopped.

### G0 (setup) — verdict: TRUE, all three parts [hand, elementary]

- *`Q = ℤ[i][1/p : p ≡ 1 (4)]`, so `1/5 ∈ Q`.* ⊇: `i ∈ U_ℚ`; for `p = ππ̄`, `π = a + bi`, `w = π/π̄ ∈ U_ℚ` and
  `w + w̄ = 2(a² − b²)/p` with `p ∤ 2(a² − b²)` (else `p | a², b²`, so `p² | p`); Bezout on `2(a² − b²)` and `p` gives
  `1/p = x(w + w̄) + y ∈ Q`. ⊆: every `u ∈ U_ℚ` is `z/z̄` (Hilbert 90) with `z ∈ ℤ[i]` divisible by no rational prime; then
  `u = z²/N(z)`, an inert `q | N(z)` would divide `z`, and a factor `(1+i)` of `z` contributes `(1+i)/(1−i) = i`; so the denominators of
  `u` are products of split primes. (For `5`: `w₅ = (3 + 4i)/5`, `w₅ + w̄₅ = 6/5`, `1/5 = w₅ + w̄₅ − 1`.)
- *Layers.* `bQ ⊆ R` because `R` is a ring containing `b` and `U_ℚ ⊆ U_F` (a rational unit vector is a unit vector of `F²`); `b ∈ bQ`,
  so the layers cover `U_F`, and `R = Σ_b bQ` (R is the additive span of `U_F`). Two layers are equal (`b′/b ∈ U_ℚ`) or meet in 0
  (distinct ℚ(i)-lines of the ℚ(i)-space `L`); the *relations* among layers are what the gluing has to control (G1, "where the gluing
  lives").
- *Restriction.* `θ_b` is additive and, since the unit vectors of `Q ⊆ ℚ(i)` are exactly `U_ℚ` and `bU_ℚ ⊆ U_F`, `θ_b(U_ℚ) ⊆ [1/4, 3/4]`.
  The same holds at every band.

### G2 (ℚ(√47): `Θ₄(R) = ∅` under the four-band rational statement) — verdict: TRUE (conditional), by a route that needs fewer inputs than FS86-CL1

**Theorem G2.** Let `F ⊆ ℝ` be a real field in Lemma R's scope (FS86-B1-LR: `L/ℚ` Galois, no stable prime ramified in `L/F`) whose stable
places are all odd with **prime** residue field `𝔽_q`, `q ≥ 11`. Then `Θ₄(R_F) ∩ (T + A) = ∅`. With G1 (under the four-band rational
statement), `Θ₄(R_F) = ∅`. ℚ(√47) qualifies: 47 ≡ 7 (mod 8), so both primes above 2 split in `L/F` (the wall is broken); 3 and 7 are
inert in `F` with residue fields 𝔽₉ and 𝔽₄₉, which contain `i`, so they split in `L/F`; the stable places are the two primes above each
`q ≡ 3 (4)` with `(47/q) = 1` (11, 19, 23, 31, 43, …) and the ramified 47 (residue field 𝔽₄₇). [hand, given Lemma R (hand, B1) and the
Weil bound for `Γ_q` (G44), checked numerically at `q ≤ 83` in `data/fs89/s0a/circle_spectra.py`]

*Proof.* Let `θ = τ + α ∈ Θ₄(R) ∩ (T + A)`, `Nτ = 0`.
1. *Local form.* By Lemma R, `R` is the ring of elements of `L` integral at every stable prime, so `R/NR ≅ ∏_{stable 𝔓 | N} O_𝔓/N` (CRT)
   and `τ(u) = Σ_𝔓 τ_𝔓(u_𝔓)` with `τ_𝔓` continuous on `T(F_𝔓)`.
2. *Independence.* The norm-one torus of `L/F` is `F`-rational (Cayley, `u = (1 + is)²/(1 + s²)`, `s ∈ F`), so `U` is dense in
   `T(ℝ)² × ∏_{𝔓 | N} T(F_𝔓)` (weak approximation for `F`, pushed through the Cayley map, a homeomorphism onto the complement of `−1` at
   every place where `i ∉ F_v`). The closed band therefore holds for independent coordinates.
3. *Level 1.* If `τ_𝔓` has level `k ≥ 2`, the fibre `{s + π^{k−1}sa : Tr a = 0}` (FS86-LP, unramified or ramified) with every other
   coordinate fixed gives a full coset of step `1/q` in the values of `θ`, which meets `(−1/4, 1/4)`. So every `τ_𝔓` has level 1:
   `τ_𝔓(t) = Tr(a_𝔓 t̄)/q`, `t̄ ∈ μ_{q+1}`.
4. *Middle half.* `τ ≠ 0`: otherwise `θ = α` takes values near 0 on the dense set `U`. Pick `𝔓` with `τ_𝔓 ≠ 0`. As in Lemma N₀, its value
   set is exactly the middle half `{m+1, …, 3m+2}/q` (`q = 4m + 3`), each value taken twice, because every value of the rest must be within
   `1/(4q)` of 0. The Fourier coefficient of that multiset at frequency 1 has modulus `1/sin(π/2q)`, and it equals an eigenvalue of
   `Γ_q`, whose modulus is at most `2√q` (Weil, via G44's Kloosterman form). `1/sin(π/2q) > 2√q` for every `q ≥ 11` (7.03 > 6.63 at 11;
   the gap widens). Contradiction. ∎

**Compared with FS86-CL1** (which already excludes measurable window colourings over finitely many places at ℚ(√47), T + A characters
included): this route uses no archimedean independence count (`[AmbrusEtAl2023]`), no all-levels certificate (FS-66 at 11 and 19), and no
`[Zhang2012]` — the band collapses every tower to level 1 and the middle-half count replaces the product theorem. It needs Lemma R (for the
local form) and Weil. Grades unchanged in kind (hand).

### G3 (ℚ(√167): `Θ₅(R) = ∅` under the five-band rational statement) — verdict: TRUE (conditional); what is needed at each stable place is listed

**Theorem G3.** Assume `Θ₅(Q) ⊆ T + A` (at the band `[1/5, 4/5]`). Then `Θ₅(R_F) = ∅` for `F = ℚ(√167)`. [hand + cert]

*Proof.*
1. *Fixed `N`, five-band.* Lemma N₀'s argument at `[1/5, 4/5]`: odd levels collapse to 1 (a coset of step `1/q ≤ 1/3` meets the open arc
   `(−1/5, 1/5)` of length `2/5`); the 2-level is at most 3 (a coset of step `1/4` meets it); and only finitely many `q` occur (the value
   multiset of `Tr(a·)/q` on `μ_{q+1}` is Weil-equidistributed, so for large `q` every translate meets an arc of length `2/5`). So the
   hypothesis upgrades to `⊆ T_N + A` for a finite `N` (not computed).
2. *Gluing.* G1's proof never uses the band: `Θ₅(R_F) ⊆ T_N + A`.
3. *The archimedean part is harmless.* For `θ = τ + α`, `τ` is constant on the cosets of the finite-index `U_N = ker(U → (R/NR)^×)`, each
   coset is dense in `T(ℝ)²` (it contains a translate of `U^M`, and `z ↦ z^M` is open), and `α(T(ℝ)²) = [−r, r]`. So every torsion value
   `c` satisfies `c + [−r, r] ⊆ [1/5, 4/5]`: `τ` is itself a five-band character and `τ ≠ 0`. (So **Croft's `m₁ ≥ 0.229 > 1/5`, which stops
   FS86-CL1 at five colours for measurable windows, does not enter for characters**: a linear archimedean part averages away.)
4. *Level 1 and the product.* By Lemma R (in scope: 167 ≡ 7 mod 8, no stable dyadic place) and step 3 of G2, `τ = Σ_𝔓 τ_𝔓` with every
   `τ_𝔓` at level 1, and `U` maps onto `∏_𝔓 μ_{q_𝔓+1}`. So `x ↦ ⌊5τ(x)⌋` properly five-colours the categorical product `∏_𝔓 Γ_{q_𝔓}` over
   the stable places with `τ_𝔓 ≠ 0`. A vertex-transitive graph with a proper five-colouring has independence ratio `≥ 1/5`; by
   `[Zhang2012]` the ratio of a categorical product of vertex-transitive graphs is the largest factor's; so some `Γ_q` has ratio `≥ 1/5`.
5. *Each stable place refuses* (what is needed, place by place — **level one only**, `χ_f(Γ_q) > 5`):

| stable place of ℚ(√167) | residue target | needed | source | grade |
|---|---|---|---|---|
| the two primes above 23 | `Γ₂₃` | `α < 105.8` | `α ≤ 105` (FS-56, level 3) and `α ≤ 97` (FS-66); Hoffman 0.24908 does **not** suffice | cert |
| the two primes above 43 | `Γ₄₃` | `α < 369.8` | `α ≤ 365` (FS-53, row 69); Hoffman 0.21376 does **not** suffice | cert |
| the two primes above 59 | `Γ₅₉` | ratio `< 1/5` | Hoffman 0.19912 (exact spectrum; recomputed here in float, margin 9·10⁻⁴) | tools exact |
| the primes above every usable `q ≥ 67` (67, 71, 79, 83, …) | `Γ_q` | ratio `< 1/5` | Weil: `2√q/(q + 1 + 2√q) < 1/5` once `8√q < q + 1`, i.e. `q ≥ 63` | derived |
| the ramified 167 | `Γ₁₆₇` (level 1 of the ramified tower) | ratio `< 1/5` | Weil, as above; the fibre structure for step 3 is FS86-LP's ramified case | derived |

   The stable places are exactly these: the dyadic places split (167 ≡ 7 mod 8), and 3, 7, 11, 19, 31, 47 are inert in `F` (`(167/q) = −1`),
   so their residue fields contain `i` and they split in `L/F`. ∎

**Not needed at any place:** an all-levels certificate (the band collapses every tower to level 1, given the density of `U`), any archimedean
count, or anything at a split place. **Needed beyond the places:** the five-band rational statement itself, which is *stronger* than the
four-band one (`Θ₄ ⊆ Θ₅`), and Lemma R and `[Zhang2012]`.

## Would-have-searched-here log

- G2/G3: I would have searched for band characters of `Γ₂₃`, `Γ₄₃` and their products by solver. Instead: the product theorem plus the held
  certificates (FS-53, FS-56, FS-66), and one exact spectrum evaluation (`circle_spectra.py`: every character evaluated, nothing selected).
- G1 / Lemma N₀: I would have enumerated the band characters of `Γ₇` and of `ℤ[i]/8` by machine to confirm the order-7 and order-8 cases.
  Instead: hand evaluation on the 8 points of the 𝔽₇ circle and the 8 unit-vector classes mod 8 (a formula, checked, not searched).
