# FS-86 stage B — verifier B1: the blind verification of the frame (V0–V4, V3-ram, VK)

*Verifier B1 (de Bruijn standard; Opus 5.5), briefed by the product owner, 2026-09-24. Brief: `data/fs86/briefs/B1-verifier-brief.md`
(committed at d3a523c1). Tools under `data/fs86/b1/`. No subagents; finite-witness-free week (no SAT, no enumeration, no finders).*

## Exposure log (what I saw of the frame before C1, stated so the owner can weigh independence)

1. **Start-up context, commit subjects** (harness snapshot, not opened by me): 632c24de's subject names the plan's frame in outline —
   "`F(R) ∈ {0, P(R)}`, `P(R) = R ∩ 𝔓⁴`, the question is `F(R)`; the K classification as a candidate" (the statements I am asked to
   verify, no proofs) and "the vector-colouring handle: Godsil–Roberson–Rooney 2017 … Zhang 2012's MIS-normal half"; cbeb1903's names
   "item 11's hypothesis closed by hand (the ramified 59-tower)" and "G54's ratio bound for a ramified base".
2. **`git log -- CLAUDE.md`** (run to check CLAUDE.md's freshness) printed commit 46f42ca1's message: "FS-86 chosen …; the close
   inventory opened; the session handoff". No route in it. I opened no diff from 46f42ca1 on.
3. **`BIBLIOGRAPHY.md` row `[Zhang2012]`** (read while locating prior art, which the brief allows): it records that Thm 1.8(i) — with
   a strict ratio inequality and `H` connected, every maximum independent set of `G × H` is a preimage from `G` — "makes every
   periodic four-colouring of a type-(B) field plane a pullback from the dyadic tower (FS-86 plan §0.3 (iii), Poros's FR-1)".
   So I know the plan's V3 route passes through a categorical product and Zhang's structure theorem. I derive V3 my own way
   (Hoffman's equality case on the product, FS38-D2-A), and use Zhang only where my route cannot run; §C2 compares.

## C0 — predicted verdicts, written before any written derivation or computation

Written after reading the brief, `CLAUDE.md` (G21, G30, G43, G54–G59, G66, G68, G75), `LEDGER.md` rows 66, 67, 75, 78, 82, 85,
`plans/FS38-derivation.md` D2-A/D2-B/L1–L3, `plans/FS79-derivation.md` T1/T2/T6, `plans/FS85-derivation.md` dB6/C9/R3a/V2-T8 and the
stub — and after some unwritten thinking about the shape of V1–V3 while reading. Probabilities are that the verdict will be **proved
as stated** (the scope and hypotheses exactly as written in the brief).

| statement | predicted verdict | P(proved as stated) | the risk I see now |
|---|---|---|---|
| V0 | proved | 0.97 | none beyond arithmetic slips; `ℚ₂(√d) = ℚ₂(√3)` for `d ≡ 3 (mod 8)` |
| V1 | proved | 0.95 | the compactness step (`forces_iff_exists_finite`) and translation-invariance of `F`; the inclusion `P(Λ) ⊆ P(R) ∩ Λ` looks elementary |
| V2 | proved | 0.85 | "every non-zero ideal of `R` has finite index": `R = ℤ[U_F]` is not a finitely generated ℤ-module (it holds `1/3`), so this needs `R` to sit with finite index in a Dedekind overring |
| V3 | proved, perhaps with a scope repair | 0.55 | (a) that `R/nR` is the product of the local quotients at the stable places (needs `R` locally maximal and the norm-one group dense in the product of local norm-one groups); (b) that every odd stable place's tower has independence ratio `< 1/4` at **every** level — at 11 I do not yet know whether Hoffman's ratio bound is below `1/4`, and if not the argument needs row 75's certificate plus a product theorem for independence (Zhang), i.e. a heavier input than "free"; (c) the thin margin at 31 |
| V3-ram | proved (with "ratio" read as Hoffman's ratio bound) | 0.7 | "ratio at level 1" is ambiguous (Hoffman bound or true independence ratio); `2/62` looks like a primitive-character Hoffman bound `2·59^{m−1}` against degree `60·59^{m−1}` |
| V4 | proved given V2, V3 | 0.85 | the "distance-4 pair" clause: every `δ` with `|δ| = 4` is `4u`, `u ∈ U`, so the pair `(0,4)` stands for all of them; the finite-graph clause by compactness |
| VK | gap or scope repair | 0.4 | needs `F(R_K) ≠ 0` (Harder's `8/3`, or row 85's `8Λ`, which rests on Parts's trees), V2 over K, and V3's product argument at **two** tight dyadic factors plus K's odd stable places (the two ramified 11-towers, then 83, …); the two-tight-factor step needs dB6's tetrahedron splitting in the product; the 11-adic question is the same risk as V3(b) |


## C1 — the blind derivations (V2 and V3 first, as the brief asks)

**Setting and notation (mine).** `F` a real field with `L = F(i)` Galois over ℚ (here `F = ℚ(√d)`, `d ∈ {59, 83, 131}`, or `K`);
`c` complex conjugation, the generator of `Gal(L/F)`; `U = U_F = {u ∈ L : u ū = 1}` (a unit vector `(a, b) ∈ F²` is `a + bi`);
`R = ℤ[U]`. A prime `𝔔` of `L` is *stable* when `c𝔔 = 𝔔`. Since `L/ℚ` is abelian, all primes above one rational `p` have the
same decomposition group, so stability is a property of `p`; `T` := the rational primes with **no** stable prime above them.
`O' := {x ∈ L : v_𝔔(x) ≥ 0 for every stable 𝔔} = O_L[1/T]`. For a stable 𝔔 the local norm-one group is
`T(O_𝔔) := {u ∈ L_𝔔 : u ū = 1}` (compact: `2v_𝔔(u) = v_𝔔(u ū) = 0`, as `v_𝔔(ū) = v_{c𝔔}(u) = v_𝔔(u)`). Every stable place of
the fields here is **inert** in `L/F` (checked place by place below), so `T(O_𝔔)` reduces onto the norm-one group `μ_{Q+1}` of the
residue extension `𝔽_{Q²}/𝔽_Q`.

### Lemma R (the ring). `ℤ[U_F] = O'`: the ring the unit vectors generate is exactly the ring of elements integral at every conjugation-stable prime. **[hand; mine]**

*Proof.* (1) `R ⊆ O'`: each `u ∈ U` is a unit at every stable 𝔔 (above).
(2) **Prime inversion, the half used: `p ∈ T ⟹ 1/p ∈ R`.** Let `𝔔 | p` be non-stable. By CRT pick `z ∈ O_L` with `v_𝔔(z) = 0`,
`v_{c𝔔}(z) = 1`; then `u := z/z̄ ∈ U` and `v_𝔔(u) = v_𝔔(z) − v_{c𝔔}(z) = −1`. So `R ⊄ O_𝔔` for every 𝔔 above `p`. If `1/p ∉ R`,
some maximal ideal `𝔪 ∋ p` of `R` exists; Chevalley's extension theorem gives a valuation ring `V ⊇ R` of `L` with `𝔪_V ∩ R = 𝔪`,
so `p ∈ 𝔪_V`, `V ≠ L`, `V ⊇ O_L` (integrally closed, contains ℤ), hence `V = (O_L)_𝔔` for a prime `𝔔 | p` — contradicting the
previous sentence. (The converse, a stable 𝔔 above `p` ⟹ `1/p ∉ R`, is (1).) This is `[Fischer1990b]` Thms 1, 3 and ASTRA's
prime inversion (G55); the Chevalley route is mine.
(3) **`cO' ⊆ R` for some `c ∈ ℤ ∖ 0`.** `R ⊇ ℤ[1/T]` by (2), and `R` holds four ℚ-independent elements: `1, i, u, iu` with
`u = (1 + i√d)/(1 − i√d) = ((1−d) + 2i√d)/(1+d)` (for `K` add the analogous element for `√11`). Their `ℤ[1/T]`-span `M ⊆ R` and
`O' = O_L ⊗ ℤ[1/T]` are both free of rank 4 over the PID `ℤ[1/T]`, so `O'/M` is killed by some `c ≠ 0`.
(4) **Density: for `p ∉ T`, `R` is dense in `∏_{𝔔|p} O_𝔔`.** *Weak approximation for the norm-one torus:* for a stable place
`v` of `F`, `−1` is not a square in `F_v` (else `v` would split in `L`), so `t ↦ (1+it)/(1−it)`, `∞ ↦ −1`, is a continuous bijection
`ℙ¹(F_v) → T(F_v)` (Hilbert 90 for `u ≠ −1`: `u = (1+u)/\overline{(1+u)}` and `1 + u ∉ iF_v`), hence a homeomorphism; `F` is dense
in `∏_{v ∈ S} F_v` (approximation theorem), so `U` is dense in `∏_{v|p} T(F_v)`. *Generation:* the closure of `R` is a closed
ℤ_p-algebra containing `G = ∏_{𝔔|p} T(O_𝔔)`. For each 𝔔 pick a Teichmüller `t ∈ T(O_𝔔)` of order `Q+1` (so `t − 1` is a unit);
the element `y = (…,1,t,1,…) − 1` has `y_𝔔 = t − 1 ∈ O_𝔔^×` and zeros elsewhere, and a subsequence of `y^k` tends to the
idempotent `e_𝔔` (positive powers of an element of a compact group accumulate at 1). So the algebra is `∏ e_𝔔(…)`, and each slot
holds `ℤ_p[T(O_𝔔)] ⊇ W(k_𝔔)` (the Teichmüller group `μ_{Q+1}` generates the residue field `𝔽_{Q²}` over `𝔽_p`, as the order of `p`
mod `Q+1` is `2f` when `Q = p^f > 1`) and an element of valuation 1 (odd `p`: `u(t) − 1 = 2it/(1 − it)` with `t` a uniformizer of
`F_v`; `p = 2`: `ζ₁₂ = (√3 + i)/2 ∈ T` already gives `ℤ₂[ζ₁₂] = O_𝔓`), hence all of `O_𝔔` (Eisenstein).
(5) **Conclusion.** `O'/R` is finite (a quotient of `O'/cO'`). For `p ∉ T`, density gives `O' = R + p^N O'` for all `N` (approximate
`x ∈ O'` by `r ∈ R` modulo `p^N` at every 𝔔 above `p`; `(x − r)/p^N` is then integral at every stable prime), so `O'/R = p^N(O'/R)`
has no `p`-torsion; for `p ∈ T`, `p` is a unit of `R` and acts invertibly on `O'/R`. So `O'/R = 0`. ∎

*Consequences used below.* (a) `ℤ`-span of `U` = `R` (`U` is a multiplicative group containing 1), so `Cay(R, U)` is connected.
(b) For `n ≥ 1`, `R/nR = O'/nO' ≅ ∏_{𝔔 stable, 𝔔 | n} O_𝔔/nO_𝔔` (CRT in the Dedekind ring `O'`), and the image of `U` is
`∏_𝔔 S_𝔔` with `S_𝔔` the image of `T(O_𝔔)` (the image of a dense set in a finite discrete quotient is the image of its closure).
So **`Cay(R/nR, U mod n)` is the categorical (direct) product `×_{𝔔 | n} Cay(O_𝔔/nO_𝔔, S_𝔔)` of the local towers.** (c) For
`K`: `R_K ∩ 𝔓₁⁴ ∩ 𝔓₂⁴ = O' ∩ 4O_{(2)} = 4O' = 4R_K` (`2 = (𝔓₁𝔓₂)²` in `K(i)`, each `e = 2`).

*Adversarial attempt (by formula).* Could `ℤ[U]` be a proper suborder at a stable prime — say only `ℤ[1/T][i, √d]` at 2, which
misses the dyadic integer `(1 + √d·i)/2`-type elements of `O_L`? No: `R` holds every `u(t) = (1+it)/(1−it)`, `t ∈ F`, and these
approximate every element of `T(O_𝔓)`, in particular `ζ₁₂`, whose ℤ₂-span is all of `O_𝔓`. The attempt fails at step (4): a
suborder would have to be closed in the dyadic topology, and `R`'s dyadic closure is `O_𝔓`; `O'/R` is finite with no torsion at
any prime, so there is no room.

### V2 — `F(R)` is an ideal, every non-zero ideal has finite index, hence `F(R) ∈ {0, P(R)}` — **PROVED** [hand; mine; scope: `Cay(R, U_F)`, so every `R`-coset of `F²`]

*Proof.* **Subgroup:** if `δ, δ'` are forced, `c(x) = c(x + δ) = c(x + δ + δ')`; `−δ` by `x ↦ x − δ`. **`U`-stable:** for `u ∈ U`,
`x ↦ ux` is an automorphism of `Cay(R, U)` (`uR = R` since `u, ū = u^{−1} ∈ R`; `u(x − y) ∈ U ⟺ x − y ∈ U`, `U` a group), so
`c ∘ (u·)` is a proper colouring, `c(ux) = c(ux + uδ)` for all `x`, and `ux` runs over `R`: `uδ ∈ F(R)`. A subgroup stable under
`U` is stable under the ℤ-span of `U`, which is `R` (Lemma R (a)): an ideal. **Finite index:** for `0 ≠ α ∈ I`,
`I ⊇ αR ⊇ αcO'` (Lemma R (3)), and `[O' : αcO'] < ∞` (`O'` is a localisation of `O_L`, Dedekind, residue fields finite), so
`[R : I] ≤ [O' : αcO'] < ∞`. **Dichotomy:** if `F(R) ≠ 0` it has finite index, every proper four-colouring is constant on its cosets,
hence periodic; so every colouring is periodic and `P(R) ⊆ F(R)`; `F ⊆ P` always. ∎

*Adversarial attempt.* An ideal of infinite index would need `R/αR` infinite; e.g. `α = 2` over ℚ(√59): `R/2R = O'/2O' = O/𝔓²`,
16 elements — finite, as the proof says. A non-Noetherian subring of `L` could have such ideals; `R` is not one, by Lemma R.
*Note (scope):* V2 uses only Lemma R and the automorphisms `x ↦ ux`; it holds for every real `F` with `L/ℚ` Galois (so for `K`).

### Lemma P (the primitive bound, every odd stable tower, unramified or ramified). **[hand; mine; checked by FFT at 7 (l = 3), 11 (unram l = 2; ram l = 2, 3), 19 (unram l = 2), 23 and 59 (ram l = 2): `data/fs86/b1/tower_spectra.py`, `.out`]**

Let `v` be an odd stable place with residue field `𝔽_p` of `F` (split, or ramified with `p | d`), `A_m = O_{F,v}/𝔭^m`, and
`G_m = UD(A_m, 2) = Cay(A_m², S_m)` the level-`m` local plane (`G₁ = Γ_p` in both cases; for a ramified `v`, `A_m` is
`ℤ_p[ε]/(ε² − p, ε^m)`). Then `|S_m| = (p+1)p^{m−1}` (Hensel: the gradient `(2x, 2y)` is a unit on the circle); a character of exact
level `j ≥ 2` has `|λ| ≤ 2p^{m−1}`; one of level `≤ 1` has `λ = p^{m−1}λ(Γ_p)`. *Proof:* `N = {1 + ε^{m−1}·i·a : a ∈ 𝔽_p}`
(`ε = p` unramified, `ε = √p` ramified) is a subgroup of the circle group (norm `1 + ε^{2m−2}a² ≡ 1`, `2m − 2 ≥ m`), so `S_m` is a
union of `N`-cosets; a character nontrivial on `ε^{m−1}A_m² ≅ 𝔽_p²` sums to zero over the coset `sN` unless `s̄` lies on one line
through the origin, which meets `S₁` in `≤ 2` points, carrying `2p^{m−2}` cosets of modulus `≤ p` — the argument of FS-66's L1
(`data/fs66/b1/SOUNDNESS.md` §1), which I re-derived before reading it and which needs only the coset structure and Hensel's count,
both valid at a ramified place. **Consequences:** (i) Hoffman's ratio bound at every level is `max(h(Γ_p), 2/(p+3))`
(`h = −λ_min/(d − λ_min)`); (ii) FS-66's fibre-density inequality (L2) and hence **every `B₁` certificate bound every level of
the ramified tower too**: `α(G_m) ≤ p^{2(m−1)}·U(p)`. The FFT check found the bound attained exactly (22, 242, 46, 118) on the
ramified towers: it is sharp. Plant (the circle replaced by its full fibre): claims (a), (b) fire.

### The spectral inputs, exact. **[tools exact; `data/fs86/b1/gamma_spectra.py` (direct circle sums) and `kloosterman_check.py` (the formula `λ = −K(1, c/4)`, derived in its docstring), agreeing to 45 digits at 60-digit precision; plants fire]**

| `p` | `λ_min(Γ_p)` | `λ_min + (p+1)/3` | Hoffman ratio `h(Γ_p)` | four colours refused by Hoffman? |
|---|---|---|---|---|
| 11 | −4.795754778 | −0.7958 | 0.285534 | **no** |
| 19 | −7.609728632 | −0.9431 | 0.275618 | **no** |
| 23 | −7.960687187 | +0.039313 | 0.249077 | yes |
| 31 | −10.666510494 | **+1.5617·10⁻⁴** | 0.2499972548 (`= 1/4 − 2.745·10⁻⁶`) | yes, strictly |
| 43 | −11.962230123 | +2.7044 | 0.213755 | yes |
| 47 | −12.846527722 | +3.1535 | 0.211130 | yes |
| 59 | −14.917577002 | +5.0824 | 0.199120 | yes |
| 83 | −17.708727742 | +10.291 | 0.174112 | yes |
| 131 | −21.108297496 | +22.892 | 0.137865 | yes |

For every `p ≥ 37`, Weil (`|K| ≤ 2√p`) gives `λ_min > −(p+1)/3`, since `p + 1 > 6√p` exactly when `p > 33.97`.

### V3 — `P(R) = R ∩ 𝔓⁴` over ℚ(√59) (and 83, 131); every periodic four-colouring of `Cay(R, U_F)` is pulled back along `R → O/𝔓⁴` from a four-colouring of `P₄` — **PROVED, but not by spectra alone** [hand + cert + a published theorem; mine; scope: `Cay(R, U_F)`, so every `R`-coset]

*The stable places* (PARI, `data/fs86/b1/stable_primes_run.gp` → `stable_primes.out`, conjugation located as the automorphism
fixing `√d` and negating `i`, ideals compared in HNF; plant: the wrong automorphism gives a different list): ℚ(√59): 2 (one prime,
`e = f = 2`), 11, 23, 31, 43, 47, 67, 83, … (two primes each, `e = 1, f = 2`), 59 (one prime, `e = f = 2`); ℚ(√83): 2, 19, 43, 47,
67, 71, 79, 83 (ramified), …; ℚ(√131): 2, 19, 23, 31, 47, 67, …, 131 (ramified), …. **The brief's lists are right; 19 is not
stable for ℚ(√59) (`(59/19) = (2/19) = −1`), confirming the stub's error.** 3 and 7 are stable for none of the three. Every stable
place is inert in `L/F`.

*Proof.* **(1) Periodic ⟹ through `R/nR`.** If `c` is constant on the cosets of `H`, `[R : H] = n`, then `nR ⊆ H`.
**(2) The quotient is a product.** By Lemma R (b), `Cay(R/nR, U)` is the categorical product of the local planes `G^{(𝔔)}` at the
stable 𝔔 dividing `n`, at the level `v_𝔔(n)`: the dyadic `P_{2v₂(n)}` (row 67; V0 below) if `n` is even, and odd factors — for
ℚ(√59) two copies of `UD(ℤ/p^k, 2)` for each split `p ∈ {11, 23, 31, 43, 47, …}` and the ramified tower at 59.
**(3) Every odd factor has independence ratio `< 1/4` at every level.** 23, 31, every `p ≥ 37`, and every ramified tower (level one
is `Γ_d`, `d ≥ 59`): by Hoffman and Lemma P (i), with the table above. **11 (and 19 for ℚ(√83), ℚ(√131)): Hoffman's bound is above
`1/4` at every level (0.2855, 0.2756), so the spectrum does not do it**; row 75's certificate does — `α(UD(ℤ/p^k,2)) ≤ U(p)·p^{2(k−1)}`
with `U(11) = 28.2043 < 121/4`, `U(19) = 77.5117 < 361/4` [cert, FS-66; the checker's exit 0 and the hand links L1–L6 are FS-66's,
not re-audited here], ratios 0.2331 and 0.2147.
**(4) The product theorem.** `[Zhang2012]` Thm 1.8 (read in the held arXiv v1, 2026-09-24): for vertex-transitive `G, H` with
`α(G)/|G| ≥ α(H)/|H|`, `α(G × H) = α(G)|H|`, and if the inequality is strict and `H` is connected, `G × H` is MIS-normal (every maximum
independent set is the preimage of an independent set of one factor). Iterating the equality, the product `H` of the odd factors has
ratio `max < 1/4`. `H` is connected: each factor is (its connection set spans additively — the ℤ-span of `U` is `R`) and none is
bipartite (`λ_min > −d`), so the only character with eigenvalue `d_H` on `H` is the trivial one.
  - *No dyadic factor* (`n` odd): the product has ratio `< 1/4`, so it has no four-colouring — no periodic colouring has odd period.
  - *Dyadic factor `P_m`, `m = 2v₂(n) ≥ 2`* (ratio exactly `1/4`: four-colourable, and Hoffman-tight by Lemma D below — **not**
    by FS38-L1, whose tightness half has a wrong-direction step, see the log at the end of this section): `P_m × H` is MIS-normal
    with `α = |V|/4`, so the four classes of a four-colouring are four maximum independent sets, each the preimage of a set of one
    factor; a preimage from `H` has at most `|P_m|·α(H) < |V|/4` points, so each class is `I_j × V(H)`: **the colouring depends only
    on the dyadic coordinate** and is a proper colouring of `P_m` (lift any edge of `P_m` by any edge of `H`).
  - *No odd factor:* the graph is `P_m` itself.

**(5) Down to `P₄`.** For `m ≥ 5`, FS38-D2-B: every four-colouring of `P_m` is `𝔓⁴`-periodic; for `m ≤ 4`, `P_m` is a quotient of `P₄`
(the level map is a graph homomorphism), so its colourings pull back to `P₄`'s. Conversely every colouring of `P₄` pulls back along
the surjection `R → O/𝔓⁴` (Lemma R (4) at 2) to a proper periodic colouring. So `P(R) = {δ : δ mod 𝔓⁴ is forced in P₄}`, and
`P₄` is pairwise free at four colours (row 67, kernel `twoAdicFour_forces_iff`): **`P(R) = R ∩ 𝔓⁴O_𝔓`.** ∎

**Lemma D (the dyadic tower is Hoffman-tight at every level, without FS38-L1). [hand, re-derived from FS38-L2's non-strict half;
tools: an independent build at even levels 2, 4, 6, 8, `data/fs86/b1/dyadic_tower.py`, `.out`]** Every eigenvalue of every `P_m` is
`≥ −d_m/3`, and `−d_m/3` is attained: a character pulled back from level `j` keeps its ratio `λ/d`; at level 1, `P₁ = K₄`
(`λ/d ∈ {1, −1/3}`); a character primitive at level `j ≥ 2` has `|λ| ≤ 2^{j−1} = d_j/3` — FS38-L2's pairing argument, which needs
only that the kernel of `S_j → S_{j−1}` is `{1, 1 + π^{j−1}a₁}` (two elements: `|S_j| = 3·2^{j−1}`, Hensel on the smooth norm-one
torus; the norm of `1 + π^{j−1}a` is `≡ 1 + π^{j−1}a + π̄^{j−1}ā (mod 𝔓^j)` as `2(j−1) ≥ j`) and that a nontrivial character of
`(𝔽₄, +)` is `1` on exactly one element of `𝔽₄^×`, so the sum runs over one residue class of `S_{j−1}`, `2^{j−2}` terms, times 2. So
`α(P_m) = |P_m|/4` at every level (Hoffman, plus four-colourability). The strict half of FS38-L2 (with L3) is needed only for
D2-B's `H_min`, which I use in step (5) and which the independent build reproduces at levels 6 and 8 (45 minimisers, `H_min = 4O`).
Plants: dropping one `±` pair fires (a)–(c); the automorphism `ζ ↦ ζ⁵` (the circle over `ℚ₂(i)`) is an **unreachable** plant — a
second smooth unramified norm-one torus, tight with the same counts — kept and labelled so, not counted as a control.

*Inputs and grades.* Lemma R, Lemma P, Lemma D [hand, mine]; weak approximation for the norm-one torus (elementary, via the parametrisation);
FS38-D2-B [hand, FS-38] and row 67's kernel freedom of `P₄`; **FS-66's `B₁` certificate at 11 (and 19)** [cert]; `[Zhang2012]`
Thm 1.8 [external, published; its proof not re-derived here]. **Nothing in V3 is "free" in the sense of a one-line spectral
argument: at 11 it needs a certified semidefinite bound and a product theorem for independent sets.**

*The same argument for 83 and 131, place by place.* ℚ(√83): 19 by FS-66's certificate; 43, 47, 67, … by Hoffman (≥ 37, Weil); the
ramified 83-tower by Hoffman + Lemma P (0.1741, `2/86`). ℚ(√131): 19 by the certificate; 23, 31 by Hoffman (margins 0.0393 and
`1.56·10⁻⁴`); 47, … by Weil; ramified 131 (0.1379, `2/134`). **V3 holds for both, with the same grade.**

*Adversarial attempts, by formula.*
  - *Read a stable odd place:* `c(x) = γ(x mod 𝔔)` for a proper colouring `γ` of the 11-adic plane at some level — needs `Γ₁₁` or a
    level of its tower to be four-colourable; it is not (ratio `≤ 0.2331`). The attempt fails at step (3).
  - *Mix two places:* `c(x) = f(x mod 𝔓^m, x mod 𝔔)` genuinely depending on both — the colour classes would be maximum independent
    sets of `P_m × G^{(𝔔)}` not of product form, which MIS-normality forbids. Fails at step (4).
  - *Read the ramified place 59:* `Γ₅₉` has ratio `≤ 0.1991`; no level four-colours. Fails at step (3).
  - *Read the dyadic place at a level above 4 non-trivially:* `c(x) = γ(x mod 𝔓⁵)` with `γ` not `𝔓⁴`-periodic — forbidden by D2-B.

*What V3 does not say.* Nothing about non-periodic colourings (that is `F(R)`, the milestone's question); nothing at 11 without
FS-66's certificate. **If FS-66's certificate at 11 were withdrawn, V3 would have a gap exactly at the 11-adic factor** (and at 19
for 83, 131); `α(Γ₁₁) = 28` (known) covers level one only.


### Log: the owner's message on FS38-L1 (received 2026-09-24, after V3 was committed at 5991dbae)

The owner reported that FS38-L1's tightness half has a wrong-direction step ("`P_{m+1}` is 4-colourable, so Hoffman's bound gives
`≥`" — colourability with Hoffman gives `λ_min ≤ −d/3`, the same direction as the pull-back bound) and that the general sentence
"tightness propagates up any tower with constant fibres" (G54, row 67, FS38-D3) fails on a finite lattice. **Where my derivation
touched it:** V3 step (4) needs `α(P_m) = |P_m|/4` at every level, and my committed text sourced it to "row 67". **Re-sourced** to
Lemma D (FS38-L2's non-strict pairing bound, re-derived; the lower bound `λ ≥ −d/3` comes from the primitive characters, not from
colourability) and checked by an independent build at levels 2–8. D2-B's `H_min` (step (5)) rests on its own induction through L2–L3
and level 4's exact spectrum, not on L1; the independent build reproduces it at 6 and 8. I use nowhere the general propagation
sentence. **V3's verdict is unchanged.** (I agree with the direction of the defect: Hoffman's bound `α ≤ n(−λ_min)/(d − λ_min)`
together with `α ≥ n/4` gives `−λ_min/(d − λ_min) ≥ 1/4`, i.e. `λ_min ≤ −d/3` — an upper bound on `λ_min`, which cannot certify
tightness.)
