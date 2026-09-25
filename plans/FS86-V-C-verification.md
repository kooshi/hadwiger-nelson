# Verifier C — FS-86 blind verification record

## C0 — predictions (saved 2026-09-25, before reading any source beyond the brief; nothing derived yet)

| statement | proved | gap | refuted | where I expect trouble |
|---|---|---|---|---|
| VC-14 (window no-go, S2) | 0.35 | 0.50 | 0.15 | the measurable transplant of Zhang: an exact-extremal structure theorem (MIS is a preimage) does not transfer to densities on windows without a *stability* form; the upper bound i(P_m x X) <= 1/4 needs the true measurable density of the archimedean factor (Hoffman there is 0.287 > 1/4), so Hoffman cannot do it; the a.e. -> pointwise step on a countable (null) coset |
| VC-12.1 (unramified dyadic towers) | 0.75 | 0.20 | 0.05 | (i) should be the norm-one filtration (graded pieces = ker of residue trace F4 -> F2, size 2); (iii) should follow from the Q2-span of T being the whole algebra; risk is in (ii)/"iff tight at levels <= c" (the D2-B induction may need more than M ⊇ P^c) |
| VC-13.0 (sqrt(-3) mod P^m) | 0.90 | 0.08 | 0.02 | looks like N(1+2w) = 3 and N(1+P^m) = 1+p^m; only edge cases (m = 0, which sqrt) |
| VC-10 (finite-type characters) | 0.65 | 0.30 | 0.05 | needs T_S = product of local circles (weak approximation for the norm-one torus) and a spread/circular-chromatic argument at the tight factor |

## Would-have-searched-here log
(none yet)

## Sources read before C1 (all open to me)
The brief; CLAUDE.md § Notation, G21, G30, G54, G55, G59, G60, G66, G68, G71, G73, G74, G75 (in context); LEDGER rows 66, 67, 75;
FS38-derivation D2-A, D2-B, L1, L2, L3 and §D-2; FS86 plan §0, §IQ, §S.4, Stage A theorems, §R-review; FS86-B1 Lemma P, the spectral
table, V3, Lemma D; [Zhang2012] arXiv v1 §1–3 in full (Prop 1.7, Thm 1.8 and its proof, Prop 3.1). I did not reopen the Ambrus paper:
I use only its Theorem 1 as stated in BIBLIOGRAPHY.md (m1(R^2) <= 0.2470, where m1 is the supremum of upper densities of measurable
1-avoiding sets).

## C1 — blind derivations

### VC-14 — the window no-go for class S2 — **PROVED, in a stronger form than stated** [hand; mine; external inputs listed at the end]

**Set-up and reading of the statement.** Let F be real and in S2, and let 𝔓 be the tight dyadic place. Take S finite, with 𝔓 ∈ S. Then:
- G_S = ∏_{v∈S} G_v and T_S = ∏_{v∈S} T_v, where T_v is the local circle: S_m at 𝔓 (level m), the norm-one group of O_v(i) at an odd
  stable place, {(a, a^{-1})} ⊂ F_v × F_v at a split place, and the unit circle at ∞.
- **Scope condition (S-prod).** Γ_S = Cay(G_S, T_S) is then the categorical product P_m × H, with H = Γ_∞ × ∏_odd Γ_v × ∏_split Γ_v.
  If the side's T_S is instead the closure of ι_S(U_F), the two agree by weak approximation for the norm-one torus (a one-dimensional
  torus, hence rational). If T_S is the bare countable image ι_S(U_F), Γ_S is not a product and the argument below does not apply.
  That is a divergence to check in C2.
- W is a proper colouring **pointwise** (W(z) ≠ W(z + t) for every z and every t ∈ T_S), and its four classes are measurable.

**Theorem (VC-14, my form).** Under S-prod, W(a, x) = c(a) for **every** (a, x) ∈ P_m × H, for one proper four-colouring c of P_m.
There are no exceptional points and no cosets. Hence every plane colouring r ↦ W(ι_S(r) + t), for **every** t, equals
c(ι_𝔓(r) + t_𝔓 mod 𝔓^m): it is periodic under R ∩ 𝔓^m and local at 𝔓.

The proof has two halves. Half 1 is purely combinatorial and uses only the tightness of P_m. Half 2 is the measure theory, and it
only has to produce **one** good point.

**Half 1 (combinatorial). For x ∈ H write W_x := W(·, x) : P_m → [4]. Either every W_x is a proper colouring of P_m, or none is.
If every one is, then W = c∘π.**

Inputs: P_m is Hoffman-tight at four colours at every level (B1's Lemma D; the brief's note on FS38-L1). So by FS38-D2-A (i) and (iv),
every proper four-colouring of P_m is balanced (each class is a maximum independent set, of size |P_m|/4) and gap-free.

- (a) **Improper spreads along edges.** Suppose W_x is improper: there are a ~ b in P_m with W(a,x) = W(b,x) = j. Let y ~ x in H.
  - For every c ~ a in P_m, (c, y) ~ (a, x) in the product, so W(c, y) ≠ j. Likewise for every c ~ b.
  - So W_y avoids colour j on N(a) ∪ N(b). This set contains both a and b, because a ~ b.
  - Therefore colour j is absent from N[a] under W_y. If W_y were proper, it would have a fan gap at a, which contradicts gap-freeness.
  - Hence W_y is improper, and E := {x : W_x improper} is closed under H-adjacency.
- (b) **H is connected.** Every factor is connected: at ∞ trivially; at a compact factor because T_v + T_v has interior, so the ℤ-span of
  T_v is an open subgroup, and it is the whole group (at odd stable places, the closed ℤ_p-span of T_v − 1 is multiplicatively closed and
  holds the unit −2, so it contains 1 and all of ℤ_p[T_v] = O_v). At a split place, the ℤ-span is open and contains (p^{-n}, p^n) for
  every n. Every factor is also non-bipartite: F² has odd cycles, and their images are odd closed walks in each factor. Two points of a
  connected non-bipartite graph are joined by walks of every sufficiently large length, and there are finitely many factors, so the
  categorical product H is connected.
- So E = ∅ or E = H.
- (c) **If E = ∅, W_x is constant along edges.** Take x ~ y. For each colour j, W_x^{-1}(j) and W_y^{-1}(j) have no edge between them:
  a ~ b with W(a,x) = W(b,y) = j would give (a,x) ~ (b,y) with one colour. So their union is independent. Both are maximum independent
  sets (by balance), so they are equal. Hence W_x = W_y, and W_x is constant on the connected graph H. ∎(Half 1)

**Half 2 (measure). If the classes are measurable, E ≠ H: some fibre W_x is proper.** This is the measurable transplant of
[Zhang2012]'s proof of Thm 1.8, Case 1. Put G := P_m, which is finite, has ratio exactly 1/4, and satisfies Prop 1.7 exactly (the
no-homomorphism averaging; I re-derived it: ((S+g) \ N[A]) ∪ A is independent, then average over g).

- *H has independence density β_H < 1/4, in the window sense.*
  - Use windows W_R = Q_R × K, where Q_R is a square of side R in ℝ² and K is the compact product of the non-archimedean factors.
    At split places, restrict T_v to the compact T_v ∩ (p^{-n}O)². This gives a spanning subgraph whose components are cosets of
    (p^{-n}O)², and W is still proper on it. Run the argument on one coset.
  - Define m_H(R) := sup over measurable independent Z and over squares of μ(Z ∩ W_R)/|Q_R|.
  - **Tiling:** copies of Z ∩ W_R at spacing R + 2 form a periodic independent set, because points of different copies are at ℝ²-distance
    more than 1. So m_H(R)(R/(R+2))² ≤ β^per ≤ liminf m_H. Hence **β_H := lim m_H(R) exists, and periodic sets approach it.**
  - **Bound:** β_H ≤ max(m1, β_K) + 0. This comes from the same Zhang chain with the compact K in the G-role (sums over a become Haar
    integrals over K, and Prop 1.7 holds exactly on a compact Cayley graph) and ℝ² in the H-role, using the window form of Prop 1.7
    below with ratio m1.
  - **β_K < 1/4.** For a profinite factor, measurable density ≤ sup over levels of the level ratios. Proof: the cosets on which I has
    relative density above 1/2 form an independent set at that level, since two such cosets at an edge would put x and x + t both in I;
    then martingale convergence. Finite products of levels obey Zhang Thm 1.8. The per-level values:
    - V3's all-levels bounds: 11 is 0.2331 (FS-66 certificate); 23 and 31 below 1/4 by Hoffman and Lemma P; ramified 59 is at most
      0.1991.
    - Split windows: Hoffman on the compact group, with normalised eigenvalue (2n+1)^{-1} Σ_{|j|≤n} I_j(ξ). Each |I_j| ≤ 1, and I_j < 0
      for at most three shells: the two Ramanujan shells (−1/(p−1)) and one Kloosterman shell. In every other shell I_j is 1 or 0
      (the conductor argument u ↦ u(1 + p^{r−1}y)). So λ_min ≥ −3/(2n+1), and the ratio tends to 0. **The side's second step checks.**
- *Window Prop 1.7 for H.* For measurable independent Y: μ(Y ∩ W_R) ≤ β_H μ(N_H[Y] ∩ W_R) + ε(R)|Q_R|, with ε(R) → 0 uniformly in Y
  and in the position of the square.
  - Proof: take a periodic independent S of density ≥ β_H − ε. Then Z_h := ((S+h) \ N[Y]) ∪ Y is independent, so μ(Z_h ∩ W_R) ≤
    m_H(R)|Q_R|.
  - Averaging h over the compact fundamental domain gives exactly dens(S)·μ(N[Y] ∩ W_R) for the (S+h) ∩ N[Y] term (Fubini).
- *The chain, per window, for one class S ⊆ W^{-1}(j)* (replaced by a σ-compact subset of full measure). Write X_a, X*_a, X'_a, A_x as
  in Zhang, with F_x = A_x ⊔ A*_x.
  - Zhang's (2): |A_x| ≤ ¼|N_G[A_x]|.
  - Zhang's (3): |N_G[A_x]| ≤ σ̃(x) := #{a : x ∉ N_H[X̃*_a]}. This holds pointwise for every x ∈ H, and trivially when A_x = ∅. Here
    X̃*_a ⊆ X*_a is σ-compact of full measure, so N_H[X̃*_a] is σ-compact, and N_H[X̃*_a] ⊆ N_H[X*_a] only weakens σ in the safe
    direction.
  - Hence μ(S ∩ (G × W_R)) = Σ_a μ(X*_a ∩ W_R) + ∫_{W_R} |A_x| ≤ ¼|G||Q_R| − Σ_a D_a − ∫_{W_R} slack(x), where
    D_a := ¼μ(N_H[X̃*_a] ∩ W_R) − μ(X̃*_a ∩ W_R) and slack(x) := ¼σ̃(x) − |A_x|, which is ≥ 0 and lies in ¼ℤ.
  - Window Prop 1.7 gives D_a ≥ (¼ − β_H)μ(N_H[X̃*_a] ∩ W_R) − ε(R)|Q_R|.
  - **Sum over the four classes.** The classes cover G × H, so the left-hand sides sum to |G||Q_R|. Hence
    Σ_{j,a} (¼ − β_H)μ(N_H[X̃*^j_a] ∩ W_R) + Σ_j ∫ slack_j ≤ 4|G|ε(R)|Q_R|.
  - So for R large, some x ∈ W_R lies in no N_H[X^{j*}_a] (null sets aside) and has slack_j(x) = 0 for every j. For that x:
    - σ̃_j(x) = |G|, so N_G[A^j_x] = G and |A^j_x| = |G|/4 = α(P_m);
    - F^j_x = A^j_x, for all j.
  - So the four fibres are maximum independent sets partitioning P_m: **W_x is proper.** ∎(Half 2)

Measurability needed only: σ-compact inner approximations (so every N_H[·] above is σ-compact), universally measurable sections
(analytic / co-analytic sets, e.g. X'_a), and Fubini on the completed product measure. Non-measurable sets never enter, because the
pointwise combinatorics uses the true X*_a, A_x, and the measure uses σ̃ ≥ σ.

**What each hypothesis does (the "fails exactly where violated" check).**
- **Tightness of P_m** gives gap-freeness (Half 1 a) and balance (Half 1 c).
- **β_H < 1/4** gives the good point (Half 2).
- **At ℚ(√11):** the stable 7 has α(Γ₇)/49 = 14/49 > 1/4, so β_H > 1/4 and Half 2 fails; the pullback from Γ₇ is then a counterexample
  form. Half 1 still holds.
- **At K:** the second tight place P'_m sits inside H, so β_H = 1/4 and Half 2 fails. Half 1 still gives the dichotomy "pullback from P_m,
  or every P_m-fibre improper", and the pullback from P'_m is exactly the second alternative (C3).

**Adversarial attempt (by formula).**
- A domain wall: W = c₁∘π on one half-plane and c₂∘π on the other, with c₁ ≠ c₂. It dies at the interface by Half 1 (c): two
  cross-proper Hoffman colourings are equal.
- A wall region of improper fibres between the two halves: it spreads to all of H by Half 1 (a).
- The character colouring ⌊4(θ_𝔓 + θ_∞)⌋ with θ_∞ ≠ 0: see VC-10 below.

**Inputs and grades.** Half 1 [hand, mine] rests on Lemma D (B1) and FS38-D2-A (i), (iv). Half 2 [hand, mine] rests on:
- [AmbrusEtAl2023] Thm 1 [external];
- FS-66's B₁ certificate at 11 (at 19 for 83 and 131) [cert];
- Hoffman plus Lemma P at the other odd stable places [hand, B1];
- [Zhang2012] Prop 1.7 (re-derived) and the structure of its Thm 1.8 proof (re-derived here in window form).

**My verdict on the side's two flagged steps.**
- (1) The measurable transplant goes through; the version above is mine.
- (2) The choice of a good point in every coset is **not needed**: one good point anywhere suffices, by Half 1.
- Any a.e.-only version of the side's argument is weaker than the statement ("every" plane colouring). I will check in C2 whether the
  side's cosets carry that gap.

**VC-14 amendment (made before reading the side).** ℚ(√59) has **two** real places, so the archimedean part is (ℝ²)^r, with r the
number of real places. Nothing breaks:
- Windows become Q_R^r × K.
- The tiling runs in every archimedean coordinate.
- The product bound β_{(ℝ²)^r × K} ≤ max(m1, β_K) follows from the same chain. With a non-compact G-role factor, Zhang's (2) is used
  in its window form, and the error is uniform, so integrating over x keeps it o(|Q_R|^r).
- Half 1's connectivity holds for any finite product.

### VC-12.1 — unramified quadratic dyadic towers — **PROVED; its "iff" is true but vacuous, because both sides always hold** [hand; mine]

Notation: E/ℚ₂ finite with residue field 𝔽₂; L = E(i), unramified quadratic over E (so L = E(ζ₃), residue field 𝔽₄); π a uniformiser
of E, and hence of L; 𝔓 = πO_L; T the norm-one units; T^(k) = T ∩ (1 + 𝔓^k).

- **(i) PROVED.** For k ≥ 1:
  - N(1 + π^k x) ≡ 1 + π^k Tr(x) (mod π^{k+1}), since 2k ≥ k + 1. So the graded norm map U_L^(k)/U_L^(k+1) → U_E^(k)/U_E^(k+1) is the
    residue trace 𝔽₄ → 𝔽₂, which is onto.
  - N maps U_L^(k) onto U_E^(k) (unramified; Serre, *Local Fields* V §2).
  - Snake lemma: |T^(k)/T^(k+1)| = 4/2 = 2.
  - T/T^(1) = μ₃ = 𝔽₄^× (Hensel), so S_m = T/T^(m) has 3·2^{m−1} elements, and S_{m+1} → S_m is exactly 2-to-1.
  - **Scope note:** "2-to-1" is true of the connection sets. On vertices, O/𝔓^{m+1} → O/𝔓^m is 4-to-1.
- **(ii) PROVED.** The fibre of S_m → S_{m−1} over s̄ is {s₀, s₀u} with u ∈ T^(m−1) \ T^(m). Then u ≡ 1 + π^{m−1}x₀ with x₀ the non-zero
  element of ker(Tr: 𝔽₄ → 𝔽₂), and that element is 1. So u ≡ 1 + π^{m−1} (mod 𝔓^m), which is FS38-L2's pairing verbatim. The rest of
  L2 is too: ψ(t) := χ(π^{m−1}t) is a non-trivial character of 𝔽₄, equal to 1 on exactly one a₀ ∈ 𝔽₄^×. The sum runs over the 2^{m−2}
  classes s̄ ≡ a₀, using (i). Equality forces χ to be trivial on a₀M_m.
- **(iii) PROVED.** Let V be the ℚ₂-span of T^(1) − 1.
  - V is closed under products, because (t−1)(s−1) = (ts−1) − (t−1) − (s−1).
  - V ≠ 0, so the minimal polynomial of any v ≠ 0 gives 1 ∈ V. So V is a subfield of L containing T^(1).
  - t ↦ t + t^{-1} maps T^(1) \ {1} onto a set with interior in E: its differential at t₀ ≠ ±1 is y ↦ (t₀ − t₀^{-1})y, a non-zero map
    from the trace-zero line to E (the p-adic inverse function theorem). So V ⊇ E, and V ∋ t ∉ E. Hence **V = L**.
  - So M contains 2[E:ℚ₂] ℚ₂-independent vectors. Their ℤ₂-span has finite index in O, so **M ⊇ 2^n O = 𝔓^{ne} =: 𝔓^c**.
- **The consequence, and a scope divergence.**
  - With M ⊇ 𝔓^c: M_m ⊇ 𝔓^{m−1}/𝔓^m for m ≥ c + 1, using FS38-L3's direction (the image of M lies in M_m). So primitive characters
    satisfy |λ| < d_m/3, and tightness at level m−1 gives tightness at level m. The stated "iff" holds.
  - **But tightness needs no c at all.** L2's non-strict half (|λ| ≤ 2^{m−1} = d_m/3 for every primitive character, with no hypothesis on
    M_m; this is B1's Lemma D) plus pull-back ratio invariance makes **every such tower four-tight at every level, unconditionally**.
    Both sides of the "iff" are always true.
  - What c really buys is **the D2-B analogue**: for m ≥ c + 1 the minimisers of P_m are exactly pullbacks, so H_min(P_m) ⊇ 𝔓^c/𝔓^m.
    **Every four-colouring of every level m ≥ c is pulled back from P_c** (by FS38-D2-A (iii)). The finite colouring space is P_c's.
- *Adversarial attempt:* E = ℚ₂(√6). Here E(i) is not E(√−3) (because 3 ∉ E^{×2}), so E(i)/E is ramified and E is excluded.
  - In general, E(i)/E is unramified quadratic iff E(i) = E(√−3) iff 3 ∈ E^{×2}.
  - So **the class is exactly {E : √3 ∈ E, f(E/ℚ₂) = 1}**, and the tower's ring is O_E[ω] with conjugation ω ↦ ω².
  - Row 67 is e = 2; the dyadic place of ℚ(√2,√3) is e = 4.

### VC-13.0 — √−3 mod 𝔓^m — **PROVED** [hand; mine]

- L = E(ζ₃) (the unique unramified quadratic extension). √−3 = 1 + 2ω is a unit, with N_{L/E}(1 + 2ω) = 1 + 2(ω + ω²) + 4 = 3.
- For m ≥ 1: there is t ∈ T with t ≡ √−3 (mod 𝔓^m) iff t = √−3·u with u ∈ U_L^(m) and N(u) = 1/3. Since N(U_L^(m)) = U_E^(m)
  (unramified), this holds iff 1/3 ∈ 1 + 𝔭^m, iff v_E(2/3) = e ≥ m.
- **So exactly m ≤ e.** The ⇐ direction is in fact trivial, with t = 1: √−3 − 1 = 2ω ∈ 2O = 𝔓^e.
- *Adversarial attempt:* E = ℚ₂(√2, √3) (the dyadic place of ℚ(√2,√3); e = 4, f = 1, and E(i) = E(√5) is unramified, since −5 ~ 3 is a
  square in E). The formula predicts m ≤ 4, and the argument does not care that ℤ₂[√2,√3] is not maximal.
- *Use:* with ζ₆ = (1 + √−3)/2, the triangle direction ζ₆ is itself a norm-one unit when √3 ∈ F. I record nothing further; it is a
  statement about √−3, not about ζ₆.

### VC-10 — finite-type Θ₄ points are torsion characters of the tight tower — **PROVED, as a corollary of VC-14** [hand; mine]

- The torsion part of θ kills some NR. R/NR ≅ ∏_{stable 𝔔 | N} O'/𝔔^{v_𝔔(N)}, because R = O' is the ring of elements integral at every
  stable prime (B1 Lemma R). So θ = Θ∘ι_S for a continuous character Θ = Σ_{v∈S} θ_v of G_S, where S is the archimedean places, 𝔓, the
  stable 𝔔 in question (at full level), and the finitely many split places.
- Weak approximation gives ι_S(U_F) dense in T_S = ∏ T_v. Θ is continuous and [1/4, 3/4] is closed, so Θ(T_S) ⊆ [1/4, 3/4].
- So ⌊4Θ⌋ is a Borel proper four-colouring of Γ_S. By VC-14 it equals c∘π_𝔓 everywhere.
- On K := ker(G_S → O/𝔓^m): ⌊4Θ(k)⌋ = ⌊4Θ(0)⌋ = 0. So Θ(K) is a subgroup of ℝ/ℤ contained in [0, 1/4), hence {0}. Every θ_v with
  v ≠ 𝔓 vanishes, and θ = θ_𝔓 is torsion at 𝔓. ∎
- *Adversarial attempt:* θ = θ_𝔓 + θ_∞ with θ_𝔓 Fischer's ℤ/4 colouring (whose values on S_m are {1/4, 1/2, 3/4}) and a small θ_∞ ≠ 0.
  - θ_∞(T_∞) = [−|ξ|, |ξ|], which contains 0. So θ(s, u) = 1/4 + ⟨ξ, u⟩ leaves [1/4, 3/4] for some u, at every ξ ≠ 0.
  - The attempt fails at once, and on the side predicted.
- *A route not through measure* (partial, recorded only): the circular chromatic number of P_m is at least χ_f(P_m) = 4. So when θ_∞ ≠ 0
  and the non-𝔓 components' value set C contains 0, A_𝔓 ⊆ [1/4 + |ξ|, 3/4 − |ξ|] is a contradiction. I did not close the case 0 ∉ C this
  way; VC-14 closes it.

## C2 — comparison with the side's working file

Opened only after every C1 verdict above was saved: `fs86-comp-coxeter/FS86-C-Coxeter.md` (round 2, steps 1–6, and "Theorems this
phase proved") and `SUCCESSOR-PREAMBLE.md`. The side's names are C14 = VC-14, C12.1 = VC-12.1, C13.0 = VC-13.0, C10 = VC-10.

**Divergences of truth: none.** No statement of the side's that I checked is false. One numeric slip, harmless:
- C14.4 says that at ℚ(√59) the largest odd ratio, at 31, is "≈ 1/4 − 10⁻⁵". B1's exact table gives 1/4 − 2.745·10⁻⁶ (Hoffman
  0.2499972548). Only r_X < 1/4 is used, so the conclusion stands.

### VC-14 against C14

| # | item | side (C14) | mine | kind |
|---|---|---|---|---|
| 1 | T_S | defined as ∏T_v, with ι_S(U) ⊆ T_S. So my scope condition S-prod holds by definition, and no density is needed for the plane colourings to be proper | S-prod as a stated condition | none (resolved) |
| 2 | the measurable transplant | C14.1 (window No-Homomorphism, via averageable near-optimal sets), C14.2 (local ratios), C14.3 (the product), the main count | the same four steps, derived blind: window Prop. 1.7, tiling, Zhang's chain per window, the four-class sum | none; the same route, derived twice independently. **The owner's step (1) checks.** |
| 3 | split ratio | (2n+1)ν̂ ≥ −1 − 2/(q−1) ≥ −3, ratio ≤ 3/(2n+4) | λ_min ≥ −3/(2n+1), with the same three shells (two Ramanujan, one Kloosterman) and the same vanishing substitution | none. **The owner's step (2) checks.** |
| 4 | the good point | x ∉ ⋃X^{j*}_b suffices: then every class of the fibre is A^j_x, which is independent by Zhang's (i), so the fibre is proper | I asked, in addition, for slack = 0, which makes each fibre class maximum | **route: the side's is simpler, and mine is redundant there** |
| 5 | propagation | forward: g_x = γ proper and y − x ∈ T_X give g_y = γ (gap-freeness) | the contrapositive (improper spreads), plus balance for equality | route; equivalent |
| 6 | cosets | "finitely many ⟨T_X⟩-cosets", because ⟨T_v − T_v⟩ is open of finite index in O_v | **the index is 1**, so X is connected (argument below) | **scope: the side's statement is true but weaker. There is one pullback for all of G_S, and "a good point in every coset" is one good point** |
| 7 | archimedean places | Q_n^s (s places) from the start | added as an amendment before C2 | none |
| 8 | measurability | inner regularity, Borel X*, analytic N[·] | inner regularity, with a σ-compact X̃* inside X* | route; both sound |

**Argument for row 6 (index 1).** At each odd stable place v, A_v := ⟨T_v − T_v⟩ is open (T − T has interior), so it is closed, so it is a
ℤ_p-module. It is closed under products, since (t−1)(s−1) = (ts−1) − (t−1) − (s−1). It contains −2, a unit, so it contains 1 and T_v, and
in particular i. Also:
- A_v maps onto the residue field 𝔽_{q²}, because μ_{q+1} lies in no proper subfield.
- A_v contains an element of valuation exactly 1, namely (t−1)/i for t ∈ T^(1) \ T^(2); here L_v/F_v is unramified.

Hence A_v + 𝔭^n = O_{L_v} for every n, and A_v is closed, so **A_v = O_{L_v}**. The archimedean and split factors are all of G_v already
(the side's own argument). So ⟨T_X⟩ ⊇ ∏A_v = G_X.

### C14-K (the window form of VK) against my C3 route

| side | mine | kind |
|---|---|---|
| a sketch that rests on VK, the field-level theorem, through the surjection R → P | **local, with no VK:** P = P_m × P′_m is four-tight, and its least eigenspace is exactly the pure characters (for non-trivial χ, χ′: |λλ′| < dd′/3). So each class indicator is F(a) + G(a′) with values in {0,1}, hence one of F, G is constant. Two classes from different factors would intersect, so every proper four-colouring of P is a pullback from one factor. This is the argument of plan §0.4 (Poros / dB6 / the owner's union step), applied to the fibre. | route; mine removes C14-K's dependence on VK |

### VC-12.1 against C12.1

| item | side | mine | kind |
|---|---|---|---|
| (i), (ii) | identical content | identical | none |
| (iii) | M is a module over ℤ₂[T¹], which has full rank | the ℚ₂-span of T^(1) − 1 is a multiplicatively closed subspace, hence a subfield, hence all of L | route; the same idea |
| (iv), the "iff" | "tight at every level iff tight at levels ≤ c"; C12 then checks levels 1–8 of ℚ₂(ζ₂₄) exactly | **both sides are always true.** FS38-L2's non-strict half (B1's Lemma D) makes every such tower four-tight at every level, with no computation. What c buys is H_min stabilisation: every four-colouring at level m ≥ c is pulled back from P_c | **scope.** The side's C12 exact-tightness run at levels 1–8 is **not needed for tightness**; it is still needed, together with 𝔓⁴ ⊆ M, for "pullback from P₄" |
| the class | "every E with residue 𝔽₂" (E(ζ₃) is assumed) | exactly the E ∋ √3 with f = 1 (E(i)/E is unramified iff 3 ∈ E^{×2}) | scope, a clarification |
| "2-to-1" | stated for S_m → S_{m−1} | the same; on vertices the map is 4-to-1 | none; the brief's wording is loose |

### VC-13.0 against C13.0

- The same proof (N(1 + 2ω) = 3; N(1 + 𝔓^m) = 1 + 𝔭^m). The side also has exact checks at levels 1–6 of both towers. I add only that the
  "if" is trivial with t = 1, because √−3 − 1 = 2ω ∈ 𝔓^e. **No divergence.**

### VC-10 against C10

| side | mine | kind |
|---|---|---|
| C10.0 (unique components, by strong approximation), then the split sweep (t = π^{−N}ε), then C8's circular-chromatic case analysis, including the E-centred-at-1/2 case through χ_f > 4 at the odd factor | a corollary of VC-14/C14: ⌊4Θ⌋ is a Borel window colouring, and Θ vanishes on the kernel | route. **C8 closes the case I left open on the measure-free route** (the value set of the components away from 𝔓 sits in an arc centred at 1/2, against χ_f > 4 of the odd factor) |
| hypothesis "χ_f > 4 at every level" | "all-levels ratio < 1/4" | none: characters of finite type see finitely many levels |

### What the side has that I did not derive (not verified here, and not in the brief's list)

C14′ (the a.e. form, via Choquet–Deny), C15 (U-invariant cosets in Θ₄ are finite and torsion), C1–C9, C11, C13. I read C14′ and C15
and found no error on one reading, but I did not verify them.

## C3 — scope

1. **Does VC-14 need F real?** It uses realness at one point only: every real place contributes UD(ℝ²), and m1 ≤ 0.2470 < 1/4 is used
   there, at the Erdős-conjecture strength. The side is right that Hoffman's 0.287 has the wrong sign.
   - A complex place w gives L_w = ℂ × ℂ, which is split, with T_w = {(z, 1/z)} ≅ ℂ^×: the archimedean hyperbola graph.
   - On windows, with the generating measure averaged over log|z| ∈ [−n, n], its normalised eigenvalues are averages of Bessel-type
     integrals whose negative mass sits in O(1) of log-scale. So its ratio → 0, as at a split place.
   - So the proof should extend to non-real F with complex places. **[sketch, one mind; not claimed]** One caveat: the windows must then
     be balls in ℂ², since there is no compact open subgroup, and Hoffman's bound is then used for positive-density measurable sets in ℝ⁴.
   - If i ∈ F, every place splits, there is no stable place, and S2 is empty.
2. **ℚ(√2, √3), which has triangles: yes, VC-14 holds.**
   - Its dyadic place: E = ℚ₂(√2, √3), e = 4, f = 1, √3 ∈ E. By my VC-12.1 scope remark, the tower is four-tight at every level with
     no computation (the side's C12 checks levels 1–8 exactly).
   - Its odd stable places are the p ≡ 23 (mod 24) with residue 𝔽_p: 23 by Hoffman (0.24908, every level by Lemma P), and p ≥ 47 by
     Weil. 3 is not stable.
   - So it is in S2, and every measurable window colouring of its plane is a P_m pullback at the dyadic place, whose four real places
     give (ℝ²)⁴. The theorem is **triangle-blind**, as the side says.
3. **Why K gives "one of two dyadic places" and not a contradiction.**
   - Put P_m in the tight role and the second dyadic tower P′_m inside X. Then r_X = 1/4 exactly, so κ = 1/(4r_X) − 1 = 0 and the count
     produces no good point.
   - Half 1 still gives the dichotomy "W is a P_m pullback, or every fibre over P_m is improper". The colourings local at 𝔓′ realise the
     second branch: they are constant in the P_m coordinate, so every fibre is monochromatic.
   - The correct bookkeeping puts both towers in the finite factor P = P_m × P′_m, with ratio 1/4 and four-tight. The count then gives a
     proper fibre colouring of P, and product tightness (the C2 table on C14-K) makes it a pullback from exactly one factor; it is
     gap-free in P, so it propagates. With ⟨T_X⟩ = G_X (C2, row 6), **one W is local at one dyadic place on all of G_S**. Different
     R_K-cosets of K² can still choose different places (VK), because different cosets need not come from one W.

## Theorems this phase proved

- **VC-C1 (VC-14, window no-go, class S2, sharpened).** In S2, every proper measurable four-colouring of Γ_S = P_m × X (T_S the product
  of the local circles; r real places; odd stable places at full level; split places) is c∘π_𝔓 at every point, for one proper
  four-colouring c of P_m. Every plane colouring W(ι_S(·) + t) is periodic and local at 𝔓, for every t.
  - [hand, mine; this file, VC-14 section and C2 row 6]
  - Inputs: [AmbrusEtAl2023] Thm 1 [external]; FS-66 certificate at 11 (and 19) [cert]; B1 Lemma P, Lemma D [hand]; FS38-D2-A;
    [Zhang2012] Prop. 1.7 (re-derived).
  - Agrees with the side's C14 and sharpens its "finitely many cosets" to one.
- **VC-C2 (connectedness).** For every odd stable place v, ⟨T_v − T_v⟩ = O_{L_v}. Hence the non-tight part X of Γ_S is connected.
  [hand, mine; C2 row 6]
- **VC-C3 (the dichotomy, used by VC-C1 and valid without S2).** If P_m is Hoffman-tight at four colours, then for any four-colouring of
  P_m × H with H connected, either every fibre over P_m is proper (and then W is a pullback) or none is. [hand, mine; VC-14 Half 1]
- **VC-C4 (VC-12.1, with its scope).** (i), (ii) and (iii) hold for every E/ℚ₂ with √3 ∈ E and f = 1. Every such tower is four-tight at
  every level unconditionally (L2's non-strict half). With M ⊇ 𝔓^c, every four-colouring at every level m ≥ c is a pullback from P_c.
  [hand, mine; VC-12.1 section]
- **VC-C5 (VC-13.0).** √−3 is congruent to a norm-one unit mod 𝔓^m iff m ≤ e(E/ℚ₂); the "if" holds with t = 1. [hand, mine]
- **VC-C6 (VC-10).** Finite-type points of Θ₄(F) in S2 are torsion characters of the tight tower. [hand, mine; a corollary of VC-C1; the
  side's C10 is an independent route]
- **VC-C7 (window form at K, local).** Over any real field whose stable places are either four-tight at every level or of all-levels
  ratio < 1/4, every measurable window colouring is a pullback from exactly one tight place, on all of G_S. [hand, mine; C3 item 3; no
  VK, product tightness instead; the side's C14-K rests on VK]
- **Sketch, not claimed:** VC-14 for non-real F with complex places (C3 item 1).

No checker was written, so there was no plant to fire. Every claim above is a hand derivation; the only computed inputs are others'
(B1's exact spectra, FS-66's certificate).

## Would-have-searched-here log (final)

- None. No move of mine wanted a search. I considered one exact membership check (listing S_3 for E = ℚ₂(√3), to confirm VC-13.0 at
  m = 3); it is allowed under the ban, but the norm argument made it unnecessary, so I skipped it.
