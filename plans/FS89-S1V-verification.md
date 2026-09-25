# FS-89 Stage 1 — the blind verifier's record (verifier H, "V")

*De Bruijn (Opus 5.5), acting as the blind verifier, 2026-09-25. Brief: `data/fs89/briefs/S1-V-verifier-brief.md` (commit
bc22114d). Read before this record was opened: the brief; the plan `plans/FS89-rational-band-rigidity.md` §0.1–§0.3, §PA.1–§PA.2
and §IQ only; S0A's record up to the line "**Lemma N₀.**" (lines 1–65) and its C4 table header rows; S0B's record except §6
(lines 210–245). Not opened: S0A's proof of Lemma N₀ and the rest of S0A §C1 after it, S0B §6, the plan's §0.4, §PA.3–4, §S, §C.1,
anything of the derivation agent's, the close inventory.*

## C0 — predictions (a probability per statement, before any derivation was written)

Honesty note (the S0A verifier's form): these were written after reading the brief and the fenced sources above, and after a
few minutes of mental pass over the statements. For V-A1 that pass already contained the argument (a character torsion on every
`R_S` is determined by one rational, by the injectivity of `ℚ(i)` into each completion), so its number is a posterior of that
pass, not a prior of a blank mind. The others are priors.

| statement | predicted verdict | probability |
|---|---|---|
| V-A1 (U1: `RS₄(S)` for all finite `S ⊇ S₀` ⟹ RQ₄) | TRUE; the last step holds with no band input | 0.90 |
| V-A1's last step alone ("torsion on every `R_S` ⟹ torsion on `Q`") | TRUE | 0.90 |
| V-A2, N₀ (S0A-3) as quoted | TRUE | 0.80 |
| V-A2, U2 as quoted (the list and the four margins) | TRUE | 0.60 (the likeliest failure: an order-8 type with margin 1/8, or a 2-part of order 16) |
| V-A3 (S0B-T6, a second prime kills every rational heteroclinic with torsion difference prime to 13), in the form I derive | TRUE | 0.55 |
| V-A4 (a rank-`r` orbit model with one step rule per prime and a gluing condition; the `T + A` criterion "one leaf everywhere") | derivable as described | 0.85 |

## V-A1 — verdict: TRUE; the last step needs no band, no weak approximation and no bound from Lemma N₀

**Statement (quoted, the plan §0.3 U1):** "if `RS₄(S)` holds for every finite `S ⊇ S₀` (some fixed `S₀`), then RQ₄ holds." With the
brief's rider: if the last step ("a character of `Q` torsion on every `R_S` is torsion, or at least in `T + A`, given the band")
fails, say exactly how. It does not fail.

**Theorem V1.** Let `φ` be a character of `Q` and `𝒮` a family of finite nonempty sets of split primes, directed under inclusion,
with `⋃_{S∈𝒮} R_S = Q`. If `φ|_{R_S} ∈ T(R_S) + A(R_S)` for every `S ∈ 𝒮`, then `φ ∈ T(Q) + A(Q)`; more precisely `φ = τ + λ_e`
with one `e ∈ ℂ` and `τ` torsion of order equal to the order of `(φ − λ_e)|_{ℤ[i]}`. [hand, elementary]

*Proof.*
1. **One archimedean part.** Write `φ|_{R_S} = τ_S + λ_{e_S}`. For `S ⊆ S′` in `𝒮`, restricting the `S′` decomposition to `R_S`
   gives `λ_{e_{S′} − e_S} = τ_S − τ_{S′}|_{R_S}` on `R_S`, a torsion character in `A(R_S)`. `T(R_S) ∩ A(R_S) = 0` because `R_S` is
   `p`-divisible for any `p ∈ S` (nonempty): if `Nλ_c = 0` on `R_S`, then `N Re(c̄ p^{−k}) ∈ ℤ` and `N Re(c̄ i p^{−k}) ∈ ℤ` for all
   `k`, so `N Re c, N Im c ∈ p^kℤ` for all `k`, so `c = 0`. Hence `e_S = e_{S′}`, and by directedness one `e` serves every `S`.
2. **The torsion order is read on `ℤ[i]`.** Put `ψ := φ − λ_e`; then `ψ|_{R_S} = τ_S` is torsion for every `S ∈ 𝒮`. Let `N_S` be
   the order of `τ_S`. (a) `N_S` is prime to every `p ∈ S`: if `N_S = pM`, then for `x ∈ R_S`, `Mτ_S(x) = Mτ_S(p · x/p) =
   N_Sτ_S(x/p) = 0`, contradicting minimality. (b) The restriction `τ_S|_{ℤ[i]}` has order exactly `N_S`: let `M` be its order; for
   `x = y/s ∈ R_S` (`y ∈ ℤ[i]`, `s` a product of primes of `S`) choose `s′` with `ss′ ≡ 1 (mod N_S)`; then `(1 − ss′)x ∈ N_S R_S`, so
   `Mτ_S(x) = Mτ_S(ss′x) = s′·Mτ_S(y) = 0`, whence `M = N_S`. (c) All the restrictions `τ_S|_{ℤ[i]}` are the one character
   `ψ|_{ℤ[i]}`; so `N_S = N := ord(ψ|_{ℤ[i]})`, the same finite number for every `S`.
3. **Torsion on `Q`.** Every `x ∈ Q` lies in some `R_S`, `S ∈ 𝒮`, and there `Nψ(x) = Nτ_S(x) = 0`. So `Nψ = 0` on `Q`, and
   `φ = ψ + λ_e ∈ T_N(Q) + A(Q)`. ∎

**Corollary (U1).** If `RS₄(S)` holds for every finite `S ⊇ S₀`, then RQ₄ holds. [hand] *Proof.* For `θ ∈ Θ₄(Q)` and finite
`S ⊇ S₀ ∪ {5}`: `U_S ⊆ U_ℚ`, so `θ|_{R_S} ∈ Θ₄(R_S) ⊆ T + A`; the family `{S ⊇ S₀ ∪ {5} finite}` is directed, nonempty-membered and
exhausts `Q`; apply V1. ∎

**What the proof actually uses, and a sharper form.**
- **No band, no weak approximation, no Lemma N₀.** The planner's worry (a character torsion on every `R_S` with orders growing in
  `S`) cannot happen: the order of a torsion character of `R_S` is the order of its restriction to `ℤ[i]`, and that restriction is
  the same character for every `S`. The band enters only to make the restrictions band characters.
- **The equivalence it gives, which is the usable form.** RQ₄ ⟺ for every finite `S`, the *restriction image* `Θ₄(Q)|_{R_S}` lies
  in `T + A`. (⟸ is V1; ⟹ because restriction maps `T + A` into `T + A`.) The restriction image is the set of band characters of
  `R_S` that extend to band characters of `Q`; by compactness it is `⋂_{S″ ⊇ S} (Θ₄(R_{S″})|_{R_S})`, generally a proper subset of
  `Θ₄(R_S)`. So **U1's hypothesis is strictly stronger than what RQ₄ needs**: RS₄(S) asks about every band character of `R_S`,
  and `RS₄({5})` is false (S0B-T3/T4) while RQ₄ is open. If `RS₄(S)` fails for every finite `S` (U3's and U5's reading), U1 is a
  true implication with a false hypothesis and routes nothing; the restriction-image form is the one that can.
- **In adelic words** (the same fact): a character of `Q` has a representative `(e; (b_v)_{v∈S_all})` with every `b_v ∈ O_v`
  (partial fractions move finitely many poles into `Q`), restriction to `R_S` keeps the components at `S`, and `T + A` on `R_S` is
  "the components at `S` are the images of one `r ∈ ℚ(i)`" (S0B-T2's criterion, one prime at a time). Since `ℚ(i) → ℚ(i)_v` is
  injective, the rationals `r_S` for nested `S` coincide, so one `r` serves every split place. This is V1 again; the elementary
  proof above is the one the verdict rests on.

**Divergence table (against the planner's reason in §0.3).**

| step | the planner | V | kind |
|---|---|---|---|
| restrictions are band characters | yes | yes (`U_S ⊆ U_ℚ`) | agree |
| archimedean parts agree | by 5-divisibility, `T ∩ A = 0` (S0A-2) | by `p`-divisibility of `R_S` for any `p ∈ S`; needs `S ≠ ∅` | agree; `5` incidental |
| the last step | "a Lemma-N₀-type weak-approximation argument should bound its order"; flagged unverified | the order is `ord(ψ|_{ℤ[i]})`, independent of `S`, by one line of arithmetic; no band, no approximation | **simplification**: the step is not hard, and the bound comes from `ℤ[i]`, not from the band |
| usefulness | "if RS₄(S) for every finite S" | hypothesis likely false for every `S` (S0B at `{5}`; U3/U5 readings); the restriction-image form is an equivalence | **addition** |

## V-A2 — verdicts: N₀ TRUE; U2 TRUE (29 band torsion characters, six types up to symmetry)

**Statements (quoted).** N₀ = S0A-3: "Lemma N₀: `Θ₄(ℤ[U_ℚ]) ∩ (T + A) ⊆ T_{168} + A`; the torsion part is a 2-part of order ∣ 8, or an
order-3 part (`|α| ≤ 1/12`), or an order-7 part (`|α| ≤ 1/28`), and each occurs". U2: "`Θ₄(Q) ∩ (T + A)` is exactly the finite union
of leaf discs over the band torsion characters of `Q/168Q`, with margins `1/4` (parity), `1/12` (the order-3 types), `1/28` (the
order-7 types) and `0` (the order-4 and order-8 types)." Derived blind: S0A's proof of Lemma N₀ and S0B §6 unopened.

*Conventions.* `‖x‖` is the distance from `x ∈ ℝ/ℤ` to 0; `B = B₄ = {x : ‖x − 1/2‖ ≤ 1/4}`. A torsion character of `Q` has order `N`
built from non-split primes only (`Q` is divisible by every split prime), and factors through `Q/NQ ≅ ℤ[i]/N`; write it
`τ(x + yi) = (αx + βy)/N`, i.e. `τ = Re(ā ·)` on `ℤ[i]` with `a = (α + βi)/N`. For `v` non-split let `T(ℚ_v)` be the norm-one
elements of `ℚ_v(i)` (all units, so `T(ℚ_v) = T(ℤ_v)`, compact), and `G_N` the image of `∏_{v|N} T(ℤ_v)` in `(ℤ[i]/N)^×`.

**Step 0 — joint density (the leaf formula at `Q`).** The Cayley map `t ↦ (1 + it)/(1 − it)` is a homeomorphism `ℙ¹(k) → T(k)` for
`k = ℝ` and for `k = ℚ_v`, `v` non-split (there `−1` is not a square, so `1 − it ≠ 0`; the inverse is `t = (u − 1)/(i(u + 1))`, and
`t̄ = t`). `ℙ¹(ℚ)` is dense in `ℙ¹(ℝ) × ∏_{v∈F} ℙ¹(ℚ_v)` for finite `F` (weak approximation for ℚ). So `U_ℚ = T(ℚ)` is dense in
`S¹ × ∏_{v|N} T(ℤ_v)`. Hence for `θ = τ + λ_d` (`τ` of order `N`) the values `θ(u) = τ(u mod N) + Re(d̄u)` are dense in
`{τ(c) + s : c ∈ G_N, |s| ≤ |d|}`, and `B` is closed:

> **(★)** `τ + λ_d ∈ Θ₄(Q)` ⟺ `τ(G_N) ⊆ [1/4 + |d|, 3/4 − |d|]`. So `τ + λ_d ∈ Θ₄(Q)` iff `τ(G_N) ⊆ B` and `|d| ≤ r_τ :=
> min_{c∈G_N} dist(τ(c), {1/4, 3/4})`. [hand]

Also `τ ≠ 0`: `λ_d` takes values within any `ε` of `0` on the dense `U_ℚ`.

**Step 1 — the local pieces.** By CRT `ℤ[i]/N = ∏_{q^k ∥ N} ℤ[i]/q^k` and `G_N = ∏ G_{q^k}` (Step 0's density is joint), so
`τ = Σ_q τ_q` and the value set is the sumset `V = Σ_q V_q`, `V_q := τ_q(G_{q^k})`. Each `V_q` is symmetric (`−1 ∈ G`). The condition
is `V ⊆ B`.

**Lemma V2a (odd level collapse).** If `q ≡ 3 (mod 4)` and `V ⊆ B`, then `τ_q` has level ≤ 1. *Proof.* `T` is smooth over `ℤ_q`
(`q` odd), so `G_{q^k}` is all of `{x mod q^k : xx̄ ≡ 1}`, which for `k ≥ 2` contains `1 + q^{k−1}bi` for every `b ∈ ℤ/q`
(`N(1 + q^{k−1}t) ≡ 1 + q^{k−1}(t + t̄)`). So `V_q ⊇ τ_q(c) + ⟨τ_q(q^{k−1}ic)⟩` for every `c ∈ G`. If `τ_q(q^{k−1}ic) ≠ 0` for some
`c`, `V` contains a full coset of `(1/q)ℤ/ℤ` (plus any point of the other summands), and a coset of spacing `1/q ≤ 1/3 < 1/2` meets the
open arc `(−1/4, 1/4)`: contradiction. So `τ_q(q^{k−1}y) = 0` for `y ∈ iG`, whose additive span mod `q` is `𝔽_{q²}` (`μ_{q+1} ⊄ 𝔽_q`
contains 1); so `τ_q` has level `k − 1`. Induct. ∎

**Lemma V2b (an odd piece is the middle half).** If `τ_q ≠ 0` (level one) and `V ⊆ B`, then `V_q = A_q/q` with
`A_q = {(q+1)/4, …, (3q−1)/4}` (the `(q+1)/2` residues in the middle half), and every point of `Y := Σ_{q′≠q} V_{q′}` has
`‖y‖ ≤ 1/(4q)`. *Proof.* With `τ_q = Tr(a′·)/q`, `V_q = {Tr η : N η = N a′}/q`; an `η` of norm `n` is a root of `X² − tX + n`, so the
traces of norm-`n` elements are the `t` with `t² − 4n` a non-square or 0, and `|V_q| = (q+1)/2` if `n` is a non-square, `(q+3)/2` if a
square. For any `y ∈ Y`, `V_q + y ⊆ B`, an arc of length `1/2`, which holds at most `(q+1)/2` points of `(1/q)ℤ`. So `n` is a
non-square and `V_q` is exactly a run of `(q+1)/2` consecutive points; a run of even length (`q ≡ 3 mod 4`) that is symmetric under
negation is unique, the run centred at `1/2`, i.e. `A_q/q`. Its extreme points are `1/2 ± (1/4 − 1/(4q))`, so `V_q + y ⊆ B` iff
`‖y‖ ≤ 1/(4q)`. ∎

**Lemma V2c (only 3 and 7).** `V_q = A_q/q` forces `q ∈ {3, 7}`. *Proof.* The complement `C = ℤ/q ∖ V(n)` is `{x + n/x : x ∈ 𝔽_q^×}`
(the traces of split elements; each value twice), and must equal the interval `I = {−(q−3)/4, …, (q−3)/4}`. Compare Fourier coefficients
at frequency 1: `|Σ_{t∈I} e(t/q)| = sin(π(q−1)/(2q))/sin(π/q) = 1/(2 sin(π/(2q))) ≥ q/π`, while `Σ_{t∈C} e(t/q) = ½ K(1, n)`, a
Kloosterman sum, `|K(1, n)| ≤ 2√q` (Weil). So `q/π ≤ √q`, `q ≤ π² < 10`: `q ∈ {3, 7}`. Both occur: at 3, `n = −1`, the four
characters with `N(a′) = 2`, values `{1/3, 2/3}`; at 7, `τ = (αx + βy)/7` with one of `α, β` in `{±2}` and the other in `{±3}`
(eight; e.g. `(2x + 3y)/7`, values `{2, 3, 4, 5}/7`), found by hand from `μ₈ = {±1, ±i, ±2 ± 2i} ⊂ 𝔽₄₉`. ∎ [hand, given Weil's bound]

**Lemma V2d (the 2-part).** Let `τ₂` have order `2^k`. (i) If `V ⊆ B` with `V = V₂` (no odd part), then `k ≤ 3`. (ii) If some odd
`τ_q ≠ 0`, then `τ₂ = 0`. *Proof.* `T(ℤ₂) = {(±√(1 − b²), b), (b, ±√(1 − b²)) : b ∈ 4ℤ₂}` (`1 − b²` is a 2-adic square iff `4 | b`);
`|G_{2^k}| = 2^k` for `k ≥ 2`. For `k ≥ 3` the kernel of `G_{2^k} → G_{2^{k−1}}` is `{1, 1 + 2^{k−1}i}` (from `b = 4c`,
`a ≡ 1 − 8c²`), so `V₂ ∋ τ₂(g), τ₂(g) + τ₂(2^{k−1}ig)`, and `τ₂(2^{k−1}·)` is a non-zero character of `ℤ[i]/2` (else the order drops),
equal on `ig` to `β/2` for `g = a′ + b′i` of type I (`a′` odd, `4 | b′`) and to `α/2` for type `iI`. (i) Say `β` odd. Then every
type-I `g` has `τ₂(g), τ₂(g) + 1/2 ∈ B`, so `τ₂(g) ∈ {1/4, 3/4}`. At `g = 1`: `α = 2^{k−2}s`, `s` odd. At `g = √(1−16c²) + 4ci`:
`τ₂(g) = s/4 + βc/2^{k−2}`, which must lie in `{1/4, 3/4}` for every `c ∈ ℤ₂`, so `2^{k−3} | β`, so `k ≤ 3`. `α` odd is symmetric (type
`iI`). (ii) By V2b every value of `τ₂` on `G` is within `1/(4q) ≤ 1/12` of `0`. At `k = 1, 2` the values lie in `(1/4)ℤ`, so they
are 0, and `G_{2^k}` spans `ℤ[i]/2^k`, so `τ₂ = 0`; at `k ≥ 3` the pair `τ₂(g), τ₂(g) + 1/2` cannot both be within `1/12` of 0. ∎

**Lemma V2e (one odd prime at most).** Two odd pieces `τ_q, τ_{q′} ≠ 0` are impossible: by V2b applied to `q`, `V_{q′} + y″ ⊆
D(0, 1/(4q))` for a point `y″`, but `V_{q′} = A_{q′}/q′` has two points `1/2 ± (1/4 − 1/(4q′))`, at distance `1/2 − 1/(2q′) ≥ 1/3 >
1/(2q)` apart. ∎

**Theorem V2 (N₀, re-derived).** Every `θ ∈ Θ₄(Q) ∩ (T + A)` is `τ + λ_d` with `τ` exactly one of: a character of order 2, 4 or 8
(pure 2-adic); a character of order 3 (level one at 3) with `|d| ≤ 1/12`; a character of order 7 (level one at 7) with `|d| ≤ 1/28`;
each occurs. In particular `τ ∈ T₁₆₈`. [hand; Weil's bound for Kloosterman sums is the one external input] *Proof.* Step 0, V2a–V2e, and
the margins below. ∎ **Verdict on N₀: TRUE as quoted.**

**Theorem V3 (U2).** `Θ₄(Q) ∩ (T + A) = ⋃_τ (τ + D(r_τ))` over exactly **29** band torsion characters, all in `T₁₆₈`; the discs are
pairwise disjoint in `Q̂` (`T ∩ A = 0` on `Q`), though their layer-0 shadows overlap (S0B's lens). Up to the `U`-action, conjugation
and negation there are **six types**:

| type | representative `τ(x + yi)` | count | `U`-orbits (before conjugation, negation) | values on `G_N` | margin `r_τ` |
|---|---|---|---|---|---|
| parity | `(x + y)/2` | 1 | 1 | `{1/2}` | **1/4** |
| order 3 | `(x + y)/3` (`a′` of norm 2 in `𝔽₉`) | 4 | 1 (one `μ₄`-orbit) | `{1/3, 2/3}` | **1/12** |
| order 4, "half-parity" | `(x + y)/4` | 4 | 1 | `{1/4, 3/4}` | **0** |
| order 4, mixed | `(x + 2y)/4` | 4 | 1 | `{1/4, 1/2, 3/4}` | **0** |
| order 7 | `(2x + 3y)/7` | 8 | 1 (one `μ₈`-orbit) | `{2, 3, 4, 5}/7` | **1/28** |
| order 8 | `(3x + 2y)/8` | 8 | 1 (`G₈` has 8 elements; `1 + 4i` joins the two `μ₄`-orbits) | `{1/4, 3/8, 5/8, 3/4}` | **0** |

[hand, each row; tools exact, `tools/fs89_s1v_n0_check.py`: for every divisor `N` of 336 and for `N = 9, 11, 19, 23, 32, 49` it builds
`G_N` from `T(ℤ_v)` and lists every band character of exact order `N` with its margin — exactly the rows above (1, 4, 8, 8, 8 at orders
2, 3, 4, 7, 8; none at 6, 9, 11, 12, 14, 16, 19, 21, 23, 24, 28, 32, 42, 48, 49, 56, 84, 112, 168, 336); three planted faults fire:
non-liftable residues at `2^k` change the order-4 and order-8 counts, a band shrunk by `1/(8N)` deletes exactly the margin-0 types, and
dropping the level-collapse cosets at 49 admits four order-49 characters.] **Verdict on U2: TRUE as quoted**, with two precisions:
the order-4 margin-0 set has two symmetry types, not one; and "RQ₄ is the statement `Θ₄(Q) = 𝓛₄(Q)`" holds, with `𝓛₄(Q)` the
compact union of 13 discs (parity 1, order 3 four, order 7 eight) and 16 points (orders 4 and 8).

**Comparison with S0B's table at `R₅`.** Orders 2, 3, 4, 7, 8 have the same counts and margins at `R₅` and at `Q` because `U₅` reduces
onto the whole of `G_N` there (`|U₅ mod N| = |G_N|` = 2, 4, 4, 8, 8). S0B's other orders (22, 26, 31, 41, 48, 76, 79) involve a split
prime (26, 41), are mixed (22, 48, 76), or sit at an inert prime where `U₅` is not dense (`|U₅ mod 31| = 16 < 32 = |G_{31}|`,
`|U₅ mod 79| = 20 < 80`): at `Q` they disappear, which is Lemmas V2b–V2e at work (the band set of `Q` sees `G_N`, the full local circle).

**Divergence table** (S0A §C1's proof of Lemma N₀, opened after commit 78b5638d).

| step | S0A (verifier G) | V | kind |
|---|---|---|---|
| density | Cayley `u = (1 + is)²/(1 + s²)`, weak approximation for the rational torus | the same map written `(1 + it)/(1 − it)`, a homeomorphism `ℙ¹(ℚ_v) → T(ℚ_v)` at every non-split `v` | agree |
| odd level ≥ 2 | the lines `t̄₀·i·𝔽_q` give a full coset of step `1/q` | Hensel gives `1 + q^{k−1}bi ∈ G`, same coset; the span of `iG` mod `q` is `𝔽_{q²}` | agree (two wordings) |
| middle half | arc `(B − c) ∩ (B + c)` holds `(q+1)/2` residues only if `‖c‖ ≤ 1/(4q)`; the arc about 0 holds too few | `V_q + y` lies in an arc of length 1/2, so `n` is a non-square and `V_q` is the unique symmetric run of `(q+1)/2` points | agree |
| `q ≥ 11` excluded | two routes: `λ` would four-colour `Γ_q` (`χ(Γ_q) ≥ 5`), and the Fourier coefficient `1/sin(π/2q)` of the middle-half multiset exceeds Weil's `2√q` from 11 on | one route: the complement is `{x + n/x}`, a Kloosterman sum; `1/sin(π/2q) ≥ 2q/π ≤ 2√q` forces `q ≤ π²` | agree (the same inequality; V has no graph-colouring input) |
| 2-level ≤ 3 | at `k ≥ 4` the values over `s′ mod 4` fill a coset of step `1/4` | at `k ≥ 3` the kernel `{1, 1 + 2^{k−1}i}` forces the values of one type to `{1/4, 3/4}`; then `b′ = 4c` sweeps `βc/2^{k−2}`, forcing `k ≤ 3` | agree in result; different mechanism; S0A's is shorter |
| 2-part beside an odd part | a non-zero 2-part of order ∣ 8 takes a non-zero value in `(1/8)ℤ`, and `1/8 > 1/(4q)` | levels 1, 2: values in `(1/4)ℤ`, and `G` spans; level ≥ 3: the pair `x, x + 1/2` | agree |
| two odd primes | too many residues of `(1/q′)ℤ` for an arc of length `1/(2q)` | the extreme points of `A_{q′}/q′` are `1/2 − 1/(2q′)` apart | agree |
| types that occur | parity, `(x + y)/4`, `(3x + 2y)/8`, order 3, `(2x + 3y)/7` | the same, plus a second order-4 type `(x + 2y)/4` (values `{1/4, 1/2, 3/4}`), with counts 1, 4, 4 + 4, 8, 8 and an exact check | **addition** (a precision; N₀'s "each occurs" does not claim a complete list) |
| U2 | (not in S0A) | the union is 13 discs and 16 points; the discs are disjoint in `Q̂` though their layer-0 shadows overlap | **addition** |

## V-A3 — verdict: TRUE, and the hypothesis "prime to 13" is not needed: any second split prime kills every rational heteroclinic

**Statement (quoted, S0B-T6's one-line form; §6 unopened):** "a second prime (13) kills every rational heteroclinic whose torsion
difference is prime to 13". I read "kills" as: no band character of `R_{5,13}` restricts on `R₅` to such a heteroclinic. S0B §6's full
form is outside my fence until this verdict is committed; the divergence table below is written after.

*Conventions.* `S₊ := ℤ[i][1/π̄₅]` (the group spanned by the forward layers `w₅^mℤ[i]`, `m ≥ 0`), `S₋ := ℤ[i][1/π₅]`;
`S₊ ∩ S₋ = ℤ[i]`, `S₊ + S₋ = R₅`. On `S₊`, `T ∩ A = 0` (it is `π̄₅`-divisible; S0B-T4's argument). A **rational heteroclinic** is
`θ ∈ Θ₄(R₅)` with `θ|_{S₊} = τ₁ + λ_{d₁}`, `θ|_{S₋} = τ₂ + λ_{d₂}` (`τ_j` torsion) and `θ ∉ T + A`. This is S0B's `(e; q₁, q₂)` with
`q₁ ≠ q₂` rational. On `ℤ[i]` both decompositions hold, so `δ := τ₁ − τ₂ = λ_D` there, with `D := d₂ − d₁`. Hence
`D ∈ (1/M)ℤ[i]` exactly as a complex number (`M` = the order of `δ|_{ℤ[i]}`), `|D| ≤ r(τ₁) + r(τ₂) ≤ 1/2`, and `θ ∉ T + A` iff `D ≠ 0`.
(If `D = 0`, then `θ − λ_{d₁}` is torsion on `S₊` and on `S₋`, hence on `S₊ + S₋ = R₅`.) For a split `p ≠ 5`, `w := w_p = π_p/π̄_p`.

**Lemma V3a (the rows).** Let `θ ∈ Θ₄(R_{5,p})` restrict on `R₅` to a rational heteroclinic. For `b ∈ ℤ` put `θ^{(b)}(x) := θ(w^b x)`,
`x ∈ R₅`. Then `θ^{(b)} ∈ Θ₄(R₅)` is a rational heteroclinic with archimedean parts `w̄^b d₁` (forward) and `w̄^b d₂` (backward). So its
torsion difference on `ℤ[i]` is `λ_{w̄^b D}`. *Proof.* Band: `w^bU₅ ⊆ U_{5,p}`. Take `b ≥ 0` (`b < 0` is symmetric) and `x ∈ S₊`. Since
`p^b w^b = π_p^{2b} ∈ ℤ[i]`, we get `p^b θ(w^b x) = θ(π_p^{2b}x) = τ₁(π_p^{2b}x) + λ_{d₁}(π_p^{2b}x)`, and `p^b λ_{w̄^b d₁}(x) = Re(d̄₁ w^b
p^b x) = λ_{d₁}(π_p^{2b}x)`. So `p^b(θ^{(b)} − λ_{w̄^b d₁})` is killed by `ord τ₁` on `S₊`, and `θ^{(b)}|_{S₊} − λ_{w̄^b d₁}` is torsion.
The decomposition is unique (`T ∩ A = 0` on `S₊`). The backward half is the same. ∎

**Lemma V3b (the step rule on the torsion parts).** Let `τ_j^{(b)}` be the torsion parts of the rows and `c_j^{(b)} ∈ ℚ(i)/ℤ[i]` their
parameters on `ℤ[i]` (`τ = Re(c̄ ·)`). Then `c_j^{(b+1)} ≡ w̄ c_j^{(b)} (mod π_p^{−1}ℤ[i])`, so their prime-to-`p` parts are `w̄^b` times
those at `b = 0` (same order for all `b`), and their `π̄_p`-parts vanish for `b ≥ b₀`. *Proof.* For `x ∈ π̄_pS₊`, `wx ∈ S₊`, so
`θ^{(b+1)}(x) = θ^{(b)}(wx)`. The archimedean parts match (`λ_{w̄^b d}(wx) = λ_{w̄^{b+1}d}(x)`), so `τ^{(b+1)} = τ^{(b)}∘w` on
`π̄_pℤ[i]`. Its annihilator in parameters is `π_p^{−1}ℤ[i]`. Multiplication by `w̄ = π̄_p/π_p` lowers the `π̄_p`-level by one and adds
nothing there. ∎

**Lemma V3c (the sweep bound).** Let `τ` be a torsion character of `S₊` with values in `B` on the forward unit vectors. Suppose it has no
`π̄_p`-part, its prime-to-`p` part has order `M′`, and its `π_p`-part has level `k`. Then `k ≤ J(M′) := v_{π_p}(w₅^o − 1)`, where
`o = lcm(ord_{M″}(w₅), ord_{π_p}(w₅))` and `M″` is `M′` with its `π₅`-part removed. (Levels are read on the parameter `c`: a
`π_p`-denominator `π_p^{−k}` in `c` means `τ = Re(c̄·)` reads `x` modulo `π̄_p^k`. Since `w̄₅ = w₅^{−1}`, the orders and valuations of
`w₅` at `π_p` and at `π̄_p` coincide, so `o` and `J` do not depend on which of the two places is meant.) *Proof.* Put `g := w₅^o`;
then `g ≡ 1` mod `M″` and mod `π̄_p`, and `g ≠ 1`. Put `j := v_{π̄_p}(g − 1) = v_{π_p}(g − 1)`, finite. Since `π̄_p` is unramified
over the odd `p`, the image of `⟨g⟩` in `(ℤ[i]/π̄_p^k)^× ≅ (ℤ/p^k)^×` is the whole subgroup `1 + p^jℤ/p^k`. Take `u₀ = w₅^m`, with `m` at least the `π₅`-level, so that the
`π₅`-part vanishes along the sweep. Then `τ(u₀g^t) = τ(u₀) + s·ũ₀(g̃^t − 1)/p^k`, with `s·ũ₀` a unit. So the values fill the coset
`τ(u₀) + (1/p^{k−j})ℤ/ℤ` if `k > j`. That coset has step `≤ 1/p < 1/2`, so it meets `(−1/4, 1/4)`: contradiction. ∎

**Theorem V4 (the kill).** For every split prime `p ≠ 5`, no `θ ∈ Θ₄(R_{5,p})` restricts on `R₅` to a rational heteroclinic, whatever
its torsion difference. The same holds with the roles of the two primes exchanged, and with `R_{5,p}` replaced by any `R_S ∋ 5, p`
(restriction). [hand] *Proof.* Take `b ≥ b₀` (V3b). Both `τ_j^{(b)}` are band torsion characters on the forward unit vectors (S0B-T2 ⟹,
on the forward half: each value class of the forward semigroup is still dense in the circle). They have no `π̄_p`-part, and their
prime-to-`p` orders `M′_j` are fixed. By V3c their `π_p`-levels are `≤ J := max_j J(M′_j)`, so the `π_p`-level of their difference on
`ℤ[i]` is `≤ J`. By V3a that difference is `λ_{w̄^bD}`, whose `π_p`-level is `b − v_{π_p}(D)`. Since `D ≠ 0`, this exceeds `J` for large
`b`. ∎

**The instance (S0B-T3's `θ*`: forward order 3, backward parity, `D = ±conj((1+i)/6)`, `|D| = √2/6`).** Here `M″ ∈ {3, 2}`, and
`ord_3(w₅) = 4` (`w₅ ≡ −i mod 3`), `ord_{π₁₃}(w₅) = 12` (`w₅ ↦ 2` in `𝔽₁₃`, `i ↦ 5`), so `o = 12`. Also `Im((2+i)^{12}) = −10296 =
−2³·3²·11·13`, so `J = v_{π₁₃}(w₅^{12} − 1) = 1` (exact, checked). The row-2 difference `w̄₁₃²D` has `π₁₃`-level 2 > 1. So `θ*` has no
extension to the three rows `b = 0, 1, 2` of `R_{5,13}`. [hand + exact arithmetic]

**Verdict: TRUE** as quoted, with a **strengthening**: "whose torsion difference is prime to 13" can be dropped. A difference
divisible by 13 only moves `v_{π₁₃}(D)` by a constant, and every second split prime does the same job. **What V4 does not reach:** the
irrational heteroclinics (S0B-T5, `b₊ ∉ ℚ(i)`) and the switching family. The proof needs `T + A` on each half-line (V3a's `p^b`
trick), so U4's "13 kills the infinitely-switching family" is not addressed here. **Bearing:** V4 says the rational-heteroclinic part of
`Θ₄(R₅)` is outside the restriction image `Θ₄(R_{5,p})|_{R₅}`. That is the image V-A1 shows RQ₄ is about.

*Correction made after the commit of this verdict (d3f88806), before any other file was opened: V3c's first text read the sweep at
`π_p` where the character reads `x` at `π̄_p`. The numbers are the same at both places (`w̄₅ = w₅^{−1}`), so the verdict is unchanged. It
was found by re-deriving the adelic form of V3b while writing the table below.*

**Divergence table** (S0B §6, opened after commit d3f88806).

| step | S0B §6 | V | kind |
|---|---|---|---|
| rows | `Θ∘w₁₃ⁿ|_{R₅}` is heteroclinic between `T₁⁽ⁿ⁾`, `T₂⁽ⁿ⁾` | V3a, with the `p^b w^b = π_p^{2b}` proof that each half stays `T + A` and the archimedean parts rotate | agree; V supplies the proof |
| the difference | "the character of `w̄₁₃ⁿ(q₁ − q₂)` minus its 13-principal part. Its 13-part has exact order `13^{|n|}`" | exactly `λ_{w̄ⁿD}` on `ℤ[i]`, `D = d₂ − d₁`, with nothing subtracted. Its `π₁₃`-level is `n − v_{π₁₃}(D)` | **wording slip in S0B**: taken literally, the subtraction deletes the 13-part that the next sentence uses. The intended content agrees |
| "prime to 13" | a hypothesis | not needed: a 13 in the difference shifts `v(D)` by a constant | **strengthening** |
| bounded prime-to-13 part | asserted | V3b: the prime-to-`p` part of each row is `w̄ⁿ` times row 0's, so it has the same order | agree; V supplies the proof |
| the sweep | "the image of `⟨w₅⟩` contains `1 + π₁₃^{v′}ℤ[i]/π₁₃^k` on the kernel of the prime-to-13 part" | V3c needs the 13-part to sit at **one** of the two places above 13. With parts at both, `w₅ ↦ (α, α^{−1})` does not sweep a full coset. V3b gives this for `|n| ≥ b₀`: the part at the other place loses a level per row and gains none | **gap in S0B, filled**: a missing step, not a wrong one |
| `w₅ mod π₁₃` | `≡ 2`, order 12 | the same; and `J = 1` exactly (`Im((2+i)^{12}) = −2³·3²·11·13`) | agree; V adds `J` |
| order-26 characters | consistent (`k = 1` allowed) | consistent (`J = 1`) | agree |
| the switching family | a reading, with a sketch and a killing test | not reached by V4 | no divergence (not claimed) |

## V-A4 — the rank-`r` orbit model: derived (arrays, one step rule per prime, a unique square fill, orthant reading, one leaf ⟺ `T + A`)

**Task (quoted):** "Derive the rank-`r` orbit model: `Θ_β(U_S)` for `|S| = r` as arrays `(e_m)_{m ∈ ℤ^r}` in `Q_β` with one step rule
per prime; state the gluing condition across directions, and the criterion for `T + A` (the rank-`r` form of S0B-T2)."

*Notation.* `S = {p₁, …, p_r}` split, `π_j := π_{p_j}`, `w_j := π_j/π̄_j`, `w^m := ∏ w_j^{m_j}`. The layers are
`A_m := w^mℤ[i] = ∏_j π_j^{m_j}π̄_j^{−m_j}ℤ[i]`, fractional ideals. The pairing is `⟨e, x⟩ = Re(ē x)`, and `ℤ[i]` is self-dual under it.

**Theorem V5 (the model).** [hand; tools exact at `S = {5, 13}`]
1. *Layers.* `θ|_{A_m}` is `w^m z ↦ ⟨e_m, z⟩` for a unique `e_m ∈ ℂ/ℤ[i]`; equivalently `e_m = θ(w^m) + i·θ(iw^m)`.
2. *One step rule per prime.* `A_m ∩ A_{m+ε_j} = w^mπ_jℤ[i]`, and the two layers agree there iff
   **`e_{m+ε_j} − w̄_j e_m ∈ π_j^{−1}ℤ[i]`**. This is S0B's rule, with `(π, w)` replaced by `(π_j, w_j)`.
3. *Gluing.* An array satisfying every step rule is the array of exactly one character of `R_S`.
   - For any `m, m′`, `A_m ∩ A_{m′}` lies in every `A_{m″}` with `m″` in the box between them. So the adjacent agreements along any
     monotone path give agreement on `A_m ∩ A_{m′}`.
   - Fractional ideals of `ℤ[i]` form a distributive lattice, so pairwise-compatible characters glue box by box, into the divisible
     group `ℝ/ℤ`.
   - `Σ_{|m_j|≤K} A_m = ∏_j p_j^{−K}ℤ[i]` exhausts `R_S`.
   - So `Hom(R_S, ℝ/ℤ) ≅ {(e_m) ∈ (ℂ/ℤ[i])^{ℤ^r} : all step rules}`.
4. *Band.* `θ(i^k w^m) = ⟨e_m, i^k⟩ ∈ {±Re e_m, ±Im e_m}`. So `θ ∈ Θ_β(U_S)` iff every `e_m` lifts into `Q_β = [β, 1 − β]²`, and that
   lift is unique. So **`Θ_β(U_S) ≅ {(e_m)_{m∈ℤ^r} : e_m ∈ Q_β, e_{m+ε_j} − w̄_j e_m ∈ π_j^{−1}ℤ[i] ∀m, j}`**.

**The gluing condition across directions: the square is forced, not free.** For `j ≠ k`, the two rules around a unit square pin the
fourth corner uniquely mod `ℤ[i]`:
`e_{m+ε_j+ε_k} ∈ (w̄_k e_{m+ε_j} + π_k^{−1}ℤ[i]) ∩ (w̄_j e_{m+ε_k} + π_j^{−1}ℤ[i])`.
- The two cosets meet: their difference is `w̄_k a − w̄_j b` with `a ∈ π_j^{−1}ℤ[i]`, `b ∈ π_k^{−1}ℤ[i]`, which lies in
  `(π_jπ_k)^{−1}ℤ[i] = π_j^{−1}ℤ[i] + π_k^{−1}ℤ[i]` (coprime).
- Their intersection is one coset of `π_j^{−1}ℤ[i] ∩ π_k^{−1}ℤ[i] = ℤ[i]`: a single point of `ℂ/ℤ[i]`.

Consequences:
- **A point of the rank-`r` model is `r` one-prime orbits (S0B-T1) through a common `e₀`**, i.e. `2r` half-orbits. The rest of the array
  is their CRT fill. Algebraically: `R_S = Σ_j R_{p_j}` with pairwise intersections `ℤ[i]`.
- **Every constraint across directions is the band at the off-axis sites.** Freedom lives on the axes (at most `p_j` candidates per
  step on axis `j`). The fill has no freedom, and the band must hold on it. This is where U4's "13 kills the switching family" would
  have to be decided, and where IQ's wall set lives.

**Orthant reading (rank-`r` form of "forward reads `b₊`, backward reads `b₋`").** Write `θ = (e; (b_{π_j}, b_{π̄_j})_j)` with every
`b` integral. Then `e_m` is `w̄^m e` plus, for each `j` with `m_j > 0`, a term read from `b_{π̄_j}` modulo `π̄_j^{m_j}`, and, for each
`j` with `m_j < 0`, a term read from `b_{π_j}` modulo `π_j^{|m_j|}`. (At `π̄_j` the element `w^m` has a pole of order `m_j`.) So the
sites of the orthant of sign vector `σ` read `e` and exactly the `r` components `b_{σ_j}`, one per prime. The faces read fewer.
[checked exactly: perturbing an unread component moves no `e_m` in a 7 × 7 box; perturbing a read one moves some; the swapped reading
is refuted]

**Theorem V6 (`T + A`, rank `r`).** For a character `θ` of `R_S`, the following are equivalent. [hand]
- (a) `θ ∈ T + A`.
- (b) The `2r` normalized local components are the images of one `q ∈ ℚ(i)`.
- (c) One leaf everywhere: `e_m = c_τ(m) + w̄^m d` for all `m`, with one torsion `τ` (order prime to `S`) and one `d ∈ ℂ`. Here
  `c_τ(m)`, the `ℤ[i]`-parameter of `τ∘w^m`, is periodic modulo the finite-index lattice `{m : w^m ≡ 1 mod ord τ}`.
- (d) One leaf on the cross: (c) for `m` on the `r` coordinate axes only.
- (e) The `2r` half-axis restrictions (to `ℤ[i][1/π_j]` and `ℤ[i][1/π̄_j]`) are all in `T + A` with **one common archimedean part**.

*Proof.*
- (a)⟺(b) is V-A1's adelic remark.
- (a)⟹(c)⟹(d) are trivial.
- (d)⟹(c): the axes determine the array (the square is forced), and `τ + λ_d` has an array that agrees on the axes.
- (c)⟹(a): the array determines the character.
- (e)⟺(a): if every half-axis is `τ_{j,±} + λ_d` with one `d`, then `θ − λ_d` is torsion on each half-axis group. Those groups sum to
  `R_S`, so `θ − λ_d` is torsion. The converse is trivial.
- If the half-axis archimedean parts differ, the torsion differences `D = d′ − d ∈ ℚ(i)` are non-zero. That is S0B-T4, one pair of
  half-axes at a time.

**The leaves and margins in rank `r` (rank-`r` S0B-T2).** `τ + λ_d ∈ Θ_β(U_S)` iff `|d| ≤ r_τ := min_{u∈U_S} dist(τ(u), ∂B_β)`
(with `τ(U_S) ⊆ B_β`). ⟸ because `|λ_d(u)| ≤ |d|`. ⟹ because each value class `{u : u ≡ c mod ord τ}` is a coset of the group
`{w^m : m ∈ P_τ}`, and that group is dense in the circle, since it contains a non-trivial power of `w₁`, not a root of unity. So a leaf
meets `Q_β` in a disc of radius `r_τ` about `c_τ(m)`, moving with `m ∈ ℤ^r` through a finite set of centres. The margin is read on
`U_S mod N`, which grows with `S`. At `S = all` it becomes V-A2's `G_N` and V3's list.

**Checked** (`tools/fs89_s1v_array_check.py`, exact rationals, 5-adic and 13-adic precision `5^{10}`, `13^{10}`, six random characters
of `ℤ[i][1/65]`, box `|m_j| ≤ 3`, 0.7 s):
- the step rule for both primes at every edge;
- the square rule, by brute force over `π₁₃^{−1}ℤ[i]/ℤ[i]`: exactly one class, and it is the array's;
- the orthant reading;
- (b)⟹(c) at `q = (1+i)/3`, with `c_τ` of period 4 in `m₁`.

Two planted faults fire: the step lattice `π̄_j^{−1}ℤ[i]`, and the swapped reading.

**Verdict: derived as asked. The prediction (0.85, "derivable as described") is met, with one sharpening the statement did not
carry: the gluing across directions is a uniquely solvable CRT square, so the model's freedom is `2r` half-orbits and its whole
difficulty is the band on the fill.** No divergence table: V-A4 is a derivation task, not a claim of another agent's. The comparable
Stage-0 text (S0B §1, rank 1) agrees.

## Would-have-searched-here log

(one line per move I would have made by search, and what I did instead)

- **V-A2, the torsion list.** I would have enumerated band characters of `ℤ[i]/N` for every `N` up to a few hundred to "see" that
  nothing beyond order 8, 3, 7 appears. Instead the classification was derived (V2a–V2e, with the Kloosterman bound closing all
  `q ≥ 11` at once), and the exact check was run only on a fixed list the derivation names (the divisors of 336, and 9, 11, 19, 23,
  32, 49), with three planted faults; it is a check of a derived finite claim, labelled so, 0.5 s.
- **V-A3.** I would have run a rank-two window (the `(e_{m,n})` array over `R_{5,13}`) outward from `θ*` to see it die. Instead the
  death was derived (Theorem V4) and located by hand at row 2 from one exact number, `v_{π₁₃}(w₅^{12} − 1) = 1`.
- **V-A4.** I would have enumerated rank-two windows to see the square rule. Instead the rule was derived and checked on six random
  characters built from adelic data, a fixed small box, no enumeration of windows.

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| S1V-1 | a character of `Q` whose restriction to every `R_S` (a directed exhausting family of finite nonempty `S`) is in `T + A` is in `T + A`, with one archimedean part and torsion order `ord(ψ|_{ℤ[i]})` | hand | § V-A1, Theorem V1 |
| S1V-2 | U1: `RS₄(S)` for all finite `S ⊇ S₀` ⟹ RQ₄; and RQ₄ ⟺ `Θ₄(Q)|_{R_S} ⊆ T + A` for every finite `S` | hand | § V-A1 |
| S1V-3 | the leaf formula at `Q`: `τ + λ_d ∈ Θ₄(Q)` iff `τ(G_N) ⊆ [1/4 + |d|, 3/4 − |d|]`, `G_N` the image of the local norm-one groups (joint density by the Cayley map) | hand | § V-A2 (★) |
| S1V-4 | band torsion characters of `Q`: odd levels collapse to 1; an odd piece is the middle half and exists only at 3 and 7 (Kloosterman/Weil); the 2-part has order ∣ 8 and dies beside an odd piece; at most one odd prime (N₀ re-derived) | hand (Weil's bound external) | § V-A2, V2a–V2e, Theorem V2 |
| S1V-5 | U2: `Θ₄(Q) ∩ (T + A)` = 13 discs (parity 1/4; four order-3, 1/12; eight order-7, 1/28) and 16 points (orders 4, 8); six types up to symmetry | hand + tools exact (`tools/fs89_s1v_n0_check.py`) | § V-A2, Theorem V3 |
| S1V-6 | rows of a band character of `R_{5,p}` over a rational heteroclinic of `R₅` are rational heteroclinics with archimedean parts rotated by `w̄_p^b` (the `p^b w_p^b = π_p^{2b}` trick) | hand | § V-A3, V3a |
| S1V-7 | the sweep bound: a band torsion character of `S₊` with no `π̄_p`-part has `π_p`-level `≤ v_{π_p}(w₅^o − 1)`, `o` fixed by its prime-to-`p` order | hand | § V-A3, V3c |
| S1V-8 | any second split prime `p ≠ 5` kills every rational heteroclinic of `Θ₄(R₅)` (no torsion-difference hypothesis); `θ*` dies by row 2 of `R_{5,13}` | hand + exact arithmetic | § V-A3, Theorem V4 |
| S1V-9 | the rank-`r` orbit model: `Θ_β(U_S)` ≅ arrays in `Q_β` with `e_{m+ε_j} − w̄_j e_m ∈ π_j^{−1}ℤ[i]`; the square is a uniquely solvable CRT fill; site `m` reads `e` and one local component per prime with `m_j ≠ 0` | hand + tools exact (`tools/fs89_s1v_array_check.py`) | § V-A4, Theorem V5 |
| S1V-10 | rank-`r` `T + A`: one rational at all `2r` places ⟺ one leaf on the axes ⟺ one leaf everywhere ⟺ one archimedean part on all half-axes; leaf discs of radius `min_{U_S} dist(τ, ∂B)` | hand | § V-A4, Theorem V6 |
