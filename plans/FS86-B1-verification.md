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

### V0 — the dyadic local field is `ℚ₂(ζ₁₂)` with row 67's conjugation, for `d ≡ 3 (mod 8)` and at both of K's dyadic primes — **PROVED** [hand; PARI for the splitting]

`d ≡ 3 (mod 4)`, so 2 ramifies in `F`; `3d ≡ 9 ≡ 1 (mod 8)`, so `d/3 ∈ ℚ₂^{×2}` and `F ⊗ ℚ₂ = ℚ₂(√d) = ℚ₂(√3)`. Then
`L_𝔓 = ℚ₂(√3, i) ∋ i√3 = √−3`, so it holds `ζ₃, i`, hence `ζ₁₂`; `[ℚ₂(ζ₁₂) : ℚ₂] = 4` (`ℚ₂(ζ₃)` unramified, `ℚ₂(i)` ramified) `= [L : ℚ]`:
one prime above 2, `e = f = 2` (PARI: `[2, 1, 2, 2]` for 59, 83, 131). Conjugation fixes `F`, so `√3`, and sends `i ↦ −i`:
`ζ₁₂ = (√3 + i)/2 ↦ ζ₁₂^{−1}`, `ω = ζ₁₂⁴ ↦ ω̄`, `√3 ↦ √3` — row 67's conjugation on `O = ℤ₂[ω][√3] = ℤ₂[ζ₁₂]` (`i = (2ω+1)√3/3`,
`ζ₁₂ = √3(2+ω)/3`, 3 a 2-adic unit). The stable place is inert in `L/F` (`k_F = 𝔽₂`, `k_L = 𝔽₄`), the norm-one torus is smooth, and
by Lemma R (4) the unit vectors are dense in `T(O_𝔓)`, so the dyadic local plane at level `m` is exactly `P_m = Cay(O/𝔓^m, S_m)`.
**For K:** `11 ≡ 3 (mod 8)` too, so `11 = 3·(11/3)` is a square in `ℚ₂(√3)` and `K ⊗ ℚ₂ = ℚ₂(√3) × ℚ₂(√3)`: two places, each with
`K(i)`-completion `ℚ₂(ζ₁₂)` and the same conjugation (PARI: `[2, 2, 2, 2]`). An independent build of `P_m` from this description
(`dyadic_tower.py`) reproduces row 67's counts (`|S₄| = 24`, 45 minimisers, `H_min(P₆) = H_min(P₈) = 4O`).

### V1 — `F(R) = ⋃ F(Λ)` over finitely generated `Λ ⊆ R` spanned by unit vectors, and `P(Λ) ⊆ P(R) ∩ Λ` — **PROVED** [hand, with the kernel's `forces_iff_exists_finite`; scope: any subgroup `R` of `F(i)` and its unit vectors]

*`⊇`:* `Cay(Λ, U ∩ Λ)` is the subgraph of `Cay(R, U)` induced on `Λ`, and each coset `x + Λ` induces a translate of it; restricting a
proper colouring `c` of `Cay(R, U)` to `x + Λ` gives `c(x) = c(x + δ)` for `δ ∈ F(Λ)`. *`⊆`:* for `δ ∈ F(R)`, compactness (row 78's
kernel `forces_iff_exists_finite`: forced iff forced on a finite induced subgraph — de Bruijn–Erdős by Rado selection) gives a finite
`V₀ ∋ 0, δ` on which `(0, δ)` is forced; each element of `V₀` is a ℤ-combination of finitely many unit vectors (the ℤ-span of `U` is `R`),
so `V₀ ⊆ Λ` for a finitely generated `Λ` spanned by unit vectors; forcing passes up to `Cay(Λ, U ∩ Λ)` (colourings restrict) and to every
`x ∈ Λ` by translation. *`P(Λ) ⊆ P(R) ∩ Λ`:* a colouring of `Cay(R, U)` constant on the cosets of `H` (finite index) restricts on every
`x + Λ` to a proper colouring of `Cay(Λ, U ∩ Λ)` constant on the cosets of `H ∩ Λ` (finite index in `Λ`). ∎
*Adversarial attempt (the converse, which V1 does not claim):* `Λ = ℤu` for one unit vector: `Cay(Λ, ±u)` is a path, `P(Λ) = 0`, while
`P(R) ∩ Λ = 4ℤu` (V3) — the inclusion is strict, so the statement is sharp in the direction written. Likewise on de Grey's lattice
(VK below) `F(Λ) = 8Λ ⊊ 4Λ = F(R_K) ∩ Λ`.

### V3-ram — the ramified 59-tower has independence ratio `≤ max(ratio at level 1, 2/62) < 1/5` at every level — **PROVED with "ratio at level 1" read as Hoffman's ratio bound; under the other reading, the middle inequality is open above level 2 but its conclusion `< 1/5` holds** [hand + tools exact]

The tower is `G_m = UD(A_m, 2)`, `A_m = ℤ₅₉[√59]/(√59)^m`, `G₁ = Γ₅₉` (𝔮 inert in `L/F`: `L_𝔮 = ℚ₅₉(√59, i)`, `i` unramified).
By Lemma P, Hoffman's ratio bound at level `m` is `max(h(Γ₅₉), 2/62)` with `h(Γ₅₉) = 0.199119854…` (`λ_min(Γ₅₉) = −14.9176 > −15`, the
exact condition for `h < 1/5`, margin 0.0824) and `2/62 = 0.0323` (the primitive bound `2·59^{m−1}` against degree `60·59^{m−1}`; FFT
at level 2 hit it exactly: 118). So `α(G_m)/59^{2m} ≤ 0.19912 < 1/5` at every level. *If* "ratio at level 1" means the true
`α(Γ₅₉)/59²`, the inequality `α(G_m)/|G_m| ≤ max(α(Γ₅₉)/59², 2/62)` holds at levels 1–2 (FS-66's Theorem E: `A₂ ⊇ 𝔽₅₉` so levels 1–2
are homomorphically equivalent) and is **unproved from level 3 on** (it is FS-68's "tower never rises" at a ramified place); V3 needs
only `< 1/4`, which holds under either reading. *Adversarial attempt:* a level-`m` independent set with ratio `> 0.19912` would need an
eigenvalue of `G_m` below `−14.9176·59^{m−1}`; pulled-back characters sit at `59^{m−1}λ(Γ₅₉)` and primitive ones within `±2·59^{m−1}`
(Lemma P), so none exists.

### V4 — given V2 and V3: `F(R) ≠ 0 ⟺ (0, 4)` is forced on `Cay(R, U_F)` `⟺` some finite unit-distance graph over ℚ(√59) forces a distance-4 pair — **PROVED given V2, V3** [hand]

`4 ∈ R` and `v_𝔓(4) = 4` (`𝔓² = (2)`), so `4 ∈ R ∩ 𝔓⁴ = P(R)`. If `F(R) ≠ 0`, V2 gives `F(R) = P(R) ∋ 4`; if `4 ∈ F(R)`, `F(R) ≠ 0`.
Finite form: `(⟹)` compactness gives a finite induced subgraph of `Cay(R, U)` forcing `(0, 4)`, a finite unit-distance graph over `F`.
`(⟸)` a finite graph with vertices in `F²` and unit-distance edges forcing `(x, y)`, `|y − x| = 4`: every four-colouring of `F²`
restricts to it, so `(x, y)` is forced in the plane; `y − x ∈ F(i)` has norm 16, so `y − x = 4u`, `u ∈ U`, lies in `R`, is in `F(R)`, and
`ū·4u = 4 ∈ F(R)` (ideal). ∎ *Adversarial attempt:* `F(R) ≠ 0` with `(0, 4)` free would need `F(R) ⊊ P(R)` or `4 ∉ P(R)`; V2 and V3
exclude both. The K control: `4 ∈ 4R_K = F(R_K)` (VK), consistent with G9's measured 791-point forcer.

### VK — over `K = ℚ(√3, √11)`: `F(R_K) = R_K ∩ 𝔓₁⁴ ∩ 𝔓₂⁴ = 4R_K`, and every proper four-colouring of every `R_K`-coset is the pullback of a four-colouring of `P₄` at ONE of K's two dyadic primes — **PROVED, given one non-zero forced difference** (row 78's certificate [cert], or row 85's derivation [hand + tools exact, given Parts's trees]) [hand + cert + a published theorem; scope: each coset `y + R_K` of `K²` separately — different cosets may choose different primes]

*Places* (PARI): stable primes of `K(i)`: 2 (two primes `𝔓₁, 𝔓₂`, `e = f = 2`), 11 (two primes, `e = f = 2`: ramified in `K`, inert in
`K(i)/K`), then 83, 107, 131, 167, … (four primes each, `e = 1, f = 2`); 3 is not stable, so `1/3 ∈ R_K` (Lemma R (2)).
*Proof.* **(1)** Lemma R holds for `K` (`L = K(i)` is multiquadratic, Galois; eight ℚ-independent elements of `R_K`: `1, i, ω = u(√3),
u(√11)` and products; local generation at 2 by `ζ₁₂`, at 11 by `u(√11) − 1`, elsewhere by Teichmüller units), so `R_K = O'_K` and
`R_K ∩ 𝔓₁⁴ ∩ 𝔓₂⁴ = 4R_K`. **(2)** A periodic four-colouring factors through `R_K/nR_K` = the categorical product of the dyadic
`P_m(𝔓₁) × P_m(𝔓₂)` (same `m = 2v₂(n)`), the two ramified 11-towers at level `2v₁₁(n)` and the unramified towers at `p ≥ 83`.
**(3)** Odd factors have ratio `< 1/4` at every level: the ramified 11-towers by FS-66's certificate `U(11) = 28.2043`, which bounds
them by Lemma P (ii) (FS-66's L1–L2 need only the coset structure and Hensel's count, both valid at a ramified place; FFT-checked at
levels 2 and 3) — ratio `≤ 0.2331`; `p ≥ 83` by Weil. **(4)** `[Zhang2012]` Thm 1.8 with `G = P_m(𝔓₁) × P_m(𝔓₂)` (vertex-transitive;
ratio exactly `1/4`: four-colourable, and Hoffman-tight since the least eigenvalue ratio of a product of two graphs with ratios in
`[−1/3, 1]` is `−1/3`) and `H` the odd product (connected, ratio `< 1/4`): every four-colouring factors through `G`. **(5)** `G` is
Hoffman-tight at four colours with minimising characters exactly `(χ, 1)` and `(1, χ')` (`χ, χ'` minimisers at `𝔓₁, 𝔓₂`: `xy = −1/3`
with `x, y ∈ [−1/3, 1]` forces one factor `= 1`, and eigenvalue `d` only at the trivial character, `P_m` being connected and not
bipartite). Hoffman's equality case (re-derived: `1_C = |C|/n + z`, `0 = 1_CᵀA1_C ≥ |C|²d/n + λ_min‖z‖²` with equality at `|C| = n/4`)
puts every class indicator in `span(1, E_min)`: `1_C(x, y) = a(x) + b(y)`. **A `{0,1}`-valued `a(x) + b(y)` has `a` or `b`
constant** (if `a₁ ≠ a₂` and `b₁ ≠ b₂`, the four sums lie in `{0,1}`, forcing `b₁ − b₂ = ±1` and then `a₁ = a₂`). The union of the
classes that depend on `x` is a function of `x`, its complement a function of `y`, so one of the two unions is empty: **the whole
colouring reads one dyadic prime**, and it is a proper colouring of `P_m` there, pulled back from `P₄` (D2-B, or the level map for
`m ≤ 4`). **(6)** Both primes occur, each surjectively, and `P₄` is pairwise free: `P(R_K) = (R_K ∩ 𝔓₁⁴) ∩ (R_K ∩ 𝔓₂⁴) = 4R_K`.
**(7)** `F(R_K) ≠ 0`: row 78's 2,044-point graph forces `(0, v)` in `Λ ⊆ R_K` (`Λ = (1/9)O_E ⊆ O'_K`, its 54 unit vectors in `U_K`), so
`v ∈ F(R_K)`; or row 85: `F(Λ) = 8Λ`, and V1 gives `8Λ ⊆ F(R_K)`. Then V2: `F(R_K) = P(R_K) = 4R_K`, every colouring is periodic, and
(2)–(5) classify it. ∎
*The controls.* `1/3 ∈ R_K` ✓ (3 unstable). `4, 8/3, 8/9, 16/3 ∈ 4R_K` (divided by 4 they are integral at every stable prime: 2, 11,
`p ≥ 83` do not divide `3`, `9`) ✓. `v = −(4/9)(1 + √−11)`: `v/4 = −(1 + i√11)/9` is integral at 2 and at 11 ✓. `2P ∉ 4R_K`: `P` is a
unit vector (`|P|² = (86 − 10√33 + 58 + 10√33)/144 = 1`), so `v_𝔓(2P/4) = v_𝔓(P) − 2 = −2 < 0` ✓ — consistent with `[Fischer1994]`'s
ℤ/4 colouring separating `(0, 2P)`. *Row 85 against VK, exactly:* `Λ = (1/9)O_E`, `E = ℚ(√−3, √−11)`; 2 is unramified in `E` (two primes,
`f = 2`) and `e(L_𝔓/E_𝔭) = 2`, so for `x ∈ Λ`: `x ∈ 4R_K ⟺ v_𝔓(x) ≥ 4` at both `𝔓 ⟺ v_𝔭(x) ≥ 2` at both `𝔭 ⟺ x ∈ 4Λ`. So
`F(R_K) ∩ Λ = 4Λ ⊋ 8Λ = F(Λ)`: **both hold because `F(Λ)` is the forced group of the smaller graph `Cay(Λ, U ∩ Λ)`**, whose four-colourings
include `8Λ`-periodic ones that do not extend to `K²`'s coset (V1 gives only `F(Λ) ⊆ F(R_K) ∩ Λ`). The extra differences `4Λ ∖ 8Λ` are
forced only by unit vectors of `K` outside `Λ`.
*Adversarial attempt, mixing the two dyadic places by formula:* `c(x) = γ(x mod 𝔓₁) + γ(x mod 𝔓₂)` in `𝔽₄` (`γ` the level-1 residue
colouring) — on `K₄ × K₄` this is `(a, b) ↦ a + b`, and the edge `(0,0) ~ (1,1)` is monochromatic (`1 + 1 = 0`): improper. Every
mixing attempt fails at step (5): a class indicator of a four-colouring of `P_m × P_m` is `a(x) + b(y)` and `{0,1}`-valued.
*What VK leans on:* FS-66's certificate at 11 (both ramified 11-towers), Zhang's Thm 1.8, D2-B (not L1), row 67's kernel freedom of
`P₄`, and **one** forced pair (row 78 [cert] or row 85 [given (S″)]). Harder's `8/3` (measured, G55) would also do, at a lower grade.


## C2 — comparison with the plan (§0.3–§0.4, §Y, §R-review) and the plan-phase advisor's record (§3 C4, §4)

Opened only after every C1 verdict was committed (5d6e7971). **No divergence of truth on any of V0–V4, V3-ram, VK.** Four steps the
sketches leave implicit are load-bearing (D2, D4, D6, D3), and one side claim in §0.4 is false (D8).

| # | where | kind | the divergence | resolution |
|---|---|---|---|---|
| D1 | §0.3 (ii), V2 | route | The sketch gets finite index as "the ideal holds a nonzero integer `c`, and `R/cR` is finite (`1/p ∈ R` off the stable primes, `R` `p`-integral of rank ≤ 4 at them)". Mine: `cO' ⊆ R` (Lemma R (3)). The sketch leaves unsaid why a nonzero ideal holds an integer: `R` is `Gal(L/ℚ)`-stable (each automorphism maps `U_F` to `U_F`), so `N_{L/ℚ}(α) ∈ αR`. | both valid; keep both |
| D2 | §0.3 (iii), V3 | completeness (true, step missing) | "A periodic colouring factors through a finite quotient of `R`, which is a product of stable local planes": weak approximation for the torus gives the **connection set** as a product, not the **vertex set**. `R/nR ≅ ∏ O_𝔔/nO_𝔔` needs `R` dense in `∏_{𝔔|p} O_𝔔` (the ℤ_p-algebra that the local norm-one groups generate is the whole local ring: idempotents, Teichmüller units, a uniformizer) plus `O'/R` finite. Without it, `Cay(R/nR, U)` could be a proper cover of the product. | closed by Lemma R (4)–(5) |
| D3 | §0.1, §0.3 (iii), V3 | source | The dyadic factor's ratio exactly `1/4` at every level is sourced to "FS38-L1, D2-A". The owner reports L1's tightness half defective. | re-sourced to Lemma D (FS38-L2's non-strict half) and D2-B; independent build at levels 2–8 |
| D4 | §0.3 (iii), V3 for 83 and 131 | scope | "11 and 23 by row 75; the split stable primes by G54's constant ratio". **For 83 and 131, 19 is a split stable prime and Hoffman's bound there is 0.2756 > 1/4**, so G54's constant (Hoffman) ratio does not give `α/n < 1/4`; row 75's certificate `U(19) = 77.51 < 361/4` does. P-83's "by the same argument" holds only with 19 added to the certificate list. (At 59, 23 goes either way: Hoffman 0.24908, or the certificate 0.1852.) | V3 true for 83 and 131, with 19 sourced to FS-66 |
| D5 | §0.3 (iii) | completeness | Zhang's (i) needs `H` connected; unstated in §0.3 (§PA l. 359 states the hypothesis). True: each factor's connection set spans additively (the ℤ-span of `U` is `R`) and none is bipartite. | closed in V3 step (4) |
| D6 | §0.4, VK | **completeness (true, step missing; the most substantive)** | "The odd part at K (11, then nothing below 83; G44) has `α/n < 1/4`", unsourced. **K's 11-adic places are ramified** (two primes, `e = f = 2`), Hoffman's bound there is 0.2855 at every level, and row 75's certificate is stated for the unramified `UD(ℤ/11^k, 2)`. It is needed for the ramified tower. | closed by Lemma P (ii): FS-66's L1–L2 need only the coset structure and Hensel's count, both valid at a ramified place (FFT at levels 2 and 3: the primitive bound attained exactly); levels 1–2 also by FS-66's Theorem E |
| D7 | §0.4, VK | route | `F(R_K) ≠ 0` from row 85 (`8Λ`, given Parts's trees). Mine also offers row 78's 2,044-point certificate (frozen checker), a source independent of Parts's trees. | keep both; the VK row can cite either |
| D8 | §0.4 "Negative" and the advisor's M5 (3a) | **truth, in a side claim** | "ℚ(√11) … has a usable 7 whose `Γ₇` has `α/n > 1/4`, so MIS-normality pulls back from `Γ₇` instead." **False as stated.** (1) Zhang's MIS-normality says nothing about four-colourings when the largest ratio exceeds `1/4` (`2/7` at 7): colour classes need not be maximum independent sets. (2) ℚ(√11)'s plane has periodic four-colourings pulled back from its dyadic `K₄` (`11 ≡ 3 mod 8`, the same `P_m` tower; `[Fischer1990]` Thm 10(i)), and these do not factor through `Γ₇`. | the conclusion `F(R_{ℚ(√11)}) = 0` stands by row 66 (pull back a gapped four-colouring of `Γ₇`, G54: gaps found at 7; `slack_addCayley_of_fanGap`, `Slack.forces_iff`); "recovered by the same theorem" should read "by row 66's gap transport". Not one of the V statements |
| D9 | advisor's C4 | wording | "`c⁻¹𝔽₅₉^×` meets `μ₆₀` in at most `±1`": the intersection is at most a coset `{±s₀}`, two points, not necessarily `{±1}`. The bound `2·59^{k−1}` is unaffected. | wording |
| D10 | V3-ram's statement | scope | "ratio at level 1": the advisor's C4 means Hoffman's ratio bound ("keeps its Hoffman ratio at every level"), my reading (a). Under the true-independence-ratio reading the middle inequality is FS-68-open from level 3. | agreed on reading (a) |
| D11 | §R-review R.2 item 3 | number | "At 31, Hoffman misses four-tightness by `4.4·10⁻⁵` (G54)". Not reproduced as `λ_min + d/3` (**1.5617·10⁻⁴**), as the ratio gap `1/4 − h` (2.745·10⁻⁶), or as `λ/d + 1/3` (4.880·10⁻⁶). It matches `9(λ_min + d/3)/d = 4.39·10⁻⁵` numerically, a normalisation G54 should state. **The sign, which is all V3 uses, is certain:** two code paths agree to 45 digits at 60-digit precision. | for G54's close: state what the `4.4·10⁻⁵` measures |
| D12 | V0, V1 | none | the same argument (V0: `issquare(3d)` and PARI; V1: compactness and monotonicity). Mine adds the strictness example `Λ = ℤu`. | — |
| D13 | V4 | not in the sketches I may read | V4 is the advisor's post-plan corollary; my proof stands alone. | — |

*Where I took a different route, both are kept:* D1 (finite index), D7 (the forced-pair source), and my V3 proof's first attempt,
Hoffman's equality case on the product. That route **fails at 11 and 19** (0.2855, 0.2756), which is why V3 and VK both need Zhang's
MIS-normal half plus FS-66's certificate there: the plan's route (Zhang), not mine, is the one that works. The advisor's C4 and my
Lemma P are the same argument, found independently.

## C3 — scope and margins

**Strictness at every odd stable place and every level** (independence ratio `< 1/4`, the hypothesis of Zhang's (i)). The worst case
at each place, over all levels:

| field | place | source | ratio bound (every level) | margin to 1/4 |
|---|---|---|---|---|
| 59 | 11 (×2, split) | FS-66 certificate `U(11)` [cert] | 0.23309 | 0.0169 |
| 59, 131 | 23 (×2) | Hoffman (level 1) + Lemma P; also FS-66 `U(23)` = 0.1852 | 0.249077 | `9.2·10⁻⁴` (λ: 0.0393) |
| 59, 131 | **31 (×2)** | Hoffman + Lemma P | **0.2499972548** | **`2.745·10⁻⁶` (λ: `1.5617·10⁻⁴`) — the thinnest; strict, certified** |
| 59, 83, 131 | 43, 47, … (`p ≥ 37`) | Weil + Hoffman + Lemma P | `≤ 2√p/(p+1+2√p)` ≤ 0.2296 | ≥ 0.020 |
| 83, 131 | 19 (×2) | FS-66 certificate `U(19)` [cert] (Hoffman 0.2756 fails) | 0.21471 | 0.035 |
| 59 / 83 / 131 | ramified `d` | Hoffman + Lemma P (V3-ram) | 0.19912 / 0.17411 / 0.13787 | ≥ 0.051 |
| K | 11 (×2, ramified) | FS-66 certificate via Lemma P (ii) [cert] | 0.23309 | 0.0169 |
| K | 83, 107, 131, … (×4) | Weil + Hoffman | ≤ 0.1741 | ≥ 0.076 |
| all | primitive characters at any level | Lemma P | `2/(p+3)` ≤ 0.143 | — |

*The margin at 31, confirmed explicitly (the owner's R.2 item 3):* `λ_min(Γ₃₁) = −10.66651049380006395962…` (= `−K(1, c/4)` at the
minimising `c`; direct circle sum and Kloosterman sum agree to 45 digits), so `λ_min + 32/3 = +1.5617·10⁻⁴ > 0`, Hoffman's ratio is
`1/4 − 2.745·10⁻⁶`, and by Lemma P (i) it is the same at every level (`|λ_min| > 2`). **Strict.** A finite product of odd factors has
ratio equal to its largest factor's (Zhang's equality, iterated), `< 1/4`.
*V3 for 83 and 131, place by place:* done in V3 and the table: **true, with 19 by FS-66's certificate** (D4).
*The dyadic factor* has ratio exactly `1/4` at every level (Lemma D). Zhang needs only that the odd side is strictly smaller.

**VK's prior-art check** (searched 2026-09-24; nothing classifying the four-colourings of `K²` or of `ℤ[U_K]` was found):
- *The held Polymath16 threads* (`~/source/library/notes/polymath16-threads-1-18-text.txt`, regex with ±220-character windows: "every
  4-colo(u)ring", "all 4-colorings", "4R", "periodic", "ring generated by", "2-adic", "number field", the field in four spellings,
  "Fischer", "dyadic", "pulled back", "local at"). **Nearest:**
  - **David Speyer, 25 April 2018** (second thread): for the Moser ring `R = ℤ[ω₁, ω₃] "= O_K[3^{-1}]"` (his `K = ℚ(√−3, √−11)`),
    `R/2R ≅ 𝔽₄ × 𝔽₄`, and the two projections are four-colourings. He asks: *"Can we show that, in any 4-coloring of R, the elements 0
    and 2 get the same color? If so, it follows that the only 4-colorings are the ones I found"*, and *"are there 4-colorings … which
    are not periodic modulo 2 A₂(ω₃)?"* De Grey answers *"there are many such colourings"*. This is VK's level-one picture, posed on the
    smaller ring. (His identification of `ℤ[ω₁, ω₃]` with `O_E[1/3]` conflicts with FS85-V2-T8; not examined here.)
  - **Gibbs** (earlier thread, relayed by Speyer) asks whether there are four-colourings of the Moser ring not periodic mod `4R`.
    **Speyer, 3 May 2018:** *"there are many 8R-periodic 4-colorings which are not 4-periodic"*, via one projection to `ℤ[ω]/8`. On the
    Moser ring the answer is `8R` (row 78/85, Hubai). **VK's `4R_K` is consistent:** the Moser ring's graph is a subgraph of `Cay(R_K, U_K)`
    (`R_E = O_E[1/3] ⊆ O'_K`, `U_E ⊆ U_K`), `4R_K ∩ R_E = 4R_E`, and its `8R`-periodic colourings do not extend to `K²`'s coset — the same
    mechanism as `F(Λ) = 8Λ ⊊ 4Λ`. The extra unit vectors `ζ₁₂` (the rotation by 30°), `i`, … are what force period 4.
- *The wiki's Algebraic formulation page* (`polymath16-algebraic-formulation-2018.txt`): the table covers `ℤ`, `R₁ = ℤ[ω]`, `R₂ = ℤ[ω, ω₃]`
  ("L+P 8", "all 4-colorings are periodic with period 8", computer-assisted), `R₃`, `R_H`, `R₄`, and one more. None of them contains `i` or
  `ζ₁₂` (no `ℤ[i]`, no `ζ₁₂`, no `π/6`): **the unit-vector ring of the plane over K is not in the table.**
- *`[Fischer1994]`* (text layer of the held scan; its row in `BIBLIOGRAPHY.md`): one additive ℤ/4-colouring of the plane over his family
  (which contains K), no classification. **Used here as a positive control on VK, by formula** (`data/fs86/b1/fischer_vk_control.gp` →
  `.out`, PARI, exact): his map `v = f mod 4`, `f(x) = 2(x₁ + x_i + x_{√33} + x_{i√33})`, kills `R_K ∩ 𝔓₁³` (hence `𝔓₁⁴`) and kills
  **no** power `𝔓₂^k`, `k ≤ 4`. **It reads exactly one dyadic prime, at level 3**, as VK predicts, and it does not kill `𝔓₁²`, as it must,
  since it separates `(0, 2P)`. Both outcomes were reachable. G41's reading ("the ℤ/4 colouring is local at 2 at a finite tower level") is
  thereby confirmed exactly.
- *Verdict:* **no prior statement of VK found.** The question was posed in 2018 at the ring level (Speyer; Gibbs) and answered there by
  computer (Hubai; 8-periodic). The field-level classification over K, with period `4R_K` and locality at one dyadic prime, was not found
  in the threads, the wiki page or Fischer. Not searched: zbMATH (the three sources above are where such a statement would be), and
  `[Johnson2000]`/`[Johnson2006]` (unread, not held; FS-81's standing debt).

## Theorems this phase proved

*(In the format of `plans/FS79-derivation.md`; these are candidate entries for `plans/FS86-derivation.md`, which the close owns.)*

**B1-LR — Lemma R: `ℤ[U_F] = {x ∈ F(i) : x integral at every conjugation-stable prime}` for every real field `F` with `F(i)/ℚ` Galois
(so every real quadratic field and K). [hand; verifier B1]** Prime inversion's `⟸` by Chevalley's extension theorem; `cO' ⊆ R`;
density of `R` in the product of the stable completions (weak approximation through the parametrisation `(1+it)/(1−it)`, idempotents,
Teichmüller units, a uniformizer); `O'/R` finite with no torsion. *Proof:* this record, Lemma R. *Proof verdict:* closes. *Rests on it:*
V2, V3, VK. *Prior art:* `[Fischer1990b]` Thm 5 (the ring in closed form for real quadratic fields) and Thms 1, 3 (prime inversion);
ASTRA's prime inversion (G55); the characterisation "integral at every stable prime" in this form not found. *Kernel:* **stub** —
FS-47 (the unit-vector ring in the kernel) is its natural home.

**B1-LP — Lemma P: the primitive-character bound `|λ| ≤ 2p^{m−1}` on every odd stable residue tower, unramified or ramified; hence
Hoffman's ratio is `max(h(Γ_p), 2/(p+3))` at every level, and FS-66's fibre-density inequality and every `B₁` certificate bound
every level of a ramified tower too. [hand + tools exact (FFT at five towers, bound attained on the ramified ones); verifier B1]**
*Proof:* this record, Lemma P. *Proof verdict:* closes. *Rests on it:* V3 (the ramified place), V3-ram, VK (K's ramified 11-towers).
*Prior art:* FS-66's L1 (`data/fs66/b1/SOUNDNESS.md` §1, unramified), the advisor's C4 (ramified 59, Hoffman only), `[MMST1998]`
(unramified spectra). The extension of the certificate to ramified towers is new here. *Kernel:* declined (finite character sums;
FS-41's stub would host it).

**B1-LD — Lemma D: the dyadic tower `P_m` is Hoffman-tight at four colours at every level, from FS38-L2's non-strict half (not
FS38-L1). [hand + tools exact (independent build, levels 2–8); verifier B1]** *Proof:* this record, Lemma D. *Proof verdict:* closes.
*Rests on it:* V3 step (4), VK step (4). *Prior art:* FS38-L2 (the pairing bound). *Kernel:* with FS-41's stub.

**B1-V2 — `F(R)` is an ideal of `R`, every non-zero ideal has finite index, so `F(R) ∈ {0, P(R)}` (field plane, per `R`-coset). [hand; verifier B1, blind; = the plan's §0.3 (ii), route D1]**
*Proof:* this record, V2. *Proof verdict:* closes. *Rests on it:* V4, VK, the competition's frame. *Prior art:* G55's transport; the
dichotomy's form not found. *Kernel:* **stub** — the ideal half is a short Lean lemma on `forcedSubgroup` (row 78's `Kempe.lean`), and
the finite-index half needs Lemma R.

**B1-V3 — for `F = ℚ(√d)`, `d ∈ {59, 83, 131}`: `P(R) = R ∩ 𝔓⁴`, and every periodic four-colouring of `Cay(R, U_F)` is pulled back from
`P₄`. [hand + cert (FS-66 at 11 and 19) + `[Zhang2012]` Thm 1.8; verifier B1, blind; = the plan's §0.3 (iii), with D2–D5]** *Proof:*
this record, V3. *Proof verdict:* closes, given FS-66's certificates and Zhang's theorem. *Rests on it:* V4, the competition's "the weak
yes is free". *Prior art:* Zhang (the product step); the field-level statement not found. *Kernel:* declined for now (Zhang's theorem and
FS-66's certificate are each a kernel project).

**B1-V3ram — the ramified 59-tower has Hoffman ratio `max(0.199120, 2/62) < 1/5` at every level (likewise 83: 0.1741; 131: 0.1379).
[hand + tools exact; verifier B1, blind; = the advisor's C4]** *Kernel:* declined (with B1-LP).

**B1-V4 — given B1-V2, B1-V3: `F(R) ≠ 0 ⟺ (0, 4)` forced `⟺` some finite unit-distance graph over `F` forces a distance-4 pair. [hand; verifier B1]**
*Kernel:* declined (a corollary).

**B1-VK — over `K = ℚ(√3, √11)`: `F(R_K) = P(R_K) = 4R_K`, and every proper four-colouring of each `R_K`-coset of `K²` is the pullback of
a four-colouring of `P₄` at exactly one of K's two dyadic primes. [hand + cert (FS-66 at 11, through B1-LP) + `[Zhang2012]`, given one
forced pair (row 78 [cert] or row 85); verifier B1, blind; = the plan's §0.4, with D6, D7; positive control: `[Fischer1994]`'s colouring
reads one prime, at level 3]** *Proof:* this record, VK. *Proof verdict:* closes under those inputs. *Rests on it:* a candidate ledger
row (the owner's inventory item 13); FS-87 (de Grey's lattice in the kernel) gains a field-level target. *Prior art:* Speyer 2018 posed
the ring-level question at level one; Hubai (8-periodic, ring, computer) and row 78/85 (lattice) answer it on smaller graphs; the
field-level classification not found (C3). *Kernel:* **stub** (with FS-87; the kernel form needs Lemma R, Zhang and FS-66).

**B1-D8 — ℚ(√11)'s plane has periodic four-colourings pulled back from its dyadic `K₄` (not through `Γ₇`), and `F = P = 0` there by row
66's gap transport, not by MIS-normality. [hand; verifier B1]** *Kernel:* declined (row 66 is kernel).

## "Would have searched here" log

1. Would have asked a solver for a four-colouring of `P₅ × Γ₁₁` not pulled back from `P₅`. Did instead: V3's proof (Zhang + FS-66).
2. Would have found maximum independent sets of `Γ₁₁` to see whether Hoffman's 0.2855 is loose there. Did instead: read row 75's
   certified `U(11)` and derived that it bounds every level (Lemma P (ii)).
3. Would have enumerated the four-colourings of `K₄ × K₄`, or of `P₂ × P₂`, to check the one-prime claim. Did instead: the `a(x) + b(y)`
   lemma, and Fischer's colouring by formula.
4. Would have searched the circle over the ramified 11-adic level 3 for independent sets. Did instead: exact FFT spectra (Lemma P), no
   colouring or independent set computed anywhere in this phase.
