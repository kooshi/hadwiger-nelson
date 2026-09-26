# FS-100, ×2×3 crunch, job X01V — blind verification of route (A), Einsiedler–Fish

*Coxeter (Opus 5.5), blind verifier. Brief: `data/crunch-2026-09-26-x2x3/briefs/X01V-einsiedler-fish-verifier.md`, with
`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md`. Fences kept: nothing of X01D, the advisor's record or the advisor's directory was
opened except `data/crunch-2026-09-26-x2x3/poros/einsiedler-fish-0804.3586.pdf`'s text `ef.txt`; §6 of the queue plan was not read.*

## Theorems this phase proved

*(grades as in `CLAUDE.md` § Notation; every proof is in this record, § Stage 2)*

- **X01V-T1** [hand] For every real number field `F` and `u ∈ U`: `h_m(u) = Σ_{w ∈ supp(u) ∪ ∞} log max(1, |u|_w)` over the places of `L`;
  for totally real `F` this is `log H(u)`. — §2.2 (a)
- **X01V-T2** [tools exact + hand] Over `F = ℚ(∛2)`, `u = (1 + ∛2·i)/(1 − ∛2·i) ∈ U` has `h_m(u) = log 5 + 2.465761… > log 5 = log H(u)`; so
  EF-G (a) is false for real fields with a complex place. — §2.2 (a), `tools/x01v_entropy_check.py`, `data/fs100/x01v/entropy-check.out`
- **X01V-T3** [hand] For totally real `F`, `liminf_N log #U_N / log N ≥ 1/h_L > 0`; for `F` with a complex place, `#U_N = ∞` for every `N ≥ 1`.
  — §2.2 (b)
- **X01V-T4** [hand] Over every real `F`, normalised arc length on a circle of archimedean characters at one place of `L` over a real place of
  `F` is `U`-invariant, `U`-ergodic (over ℚ, via `(3+4i)/5`), atomless, of zero entropy for every `u`, and carried by `A`. — §2.1
- **X01V-T5** [hand] Every `U`-ergodic probability `μ` with `μ(E) = 1` lives on finitely many translates of the isometric part of `A` and has
  `h_μ(u) = 0` for every `u ∈ U`; every `U`-invariant coset `t + A` lies in `T + A`. — §2.3 (entropy transfer; no counterexample)
- **X01V-T6** [hand] PE-2 ∧ EF_F⁰ ⟹ MR(F), and PE-2 ∧ EF_F⁰ ⟹ EF_F, where EF_F⁰ is EF_F with "for some non-torsion `u`" replaced by "for every
  `u`". — §2.3, §2.4
- **X01V-T7** [hand; a statement about the route] In EF Lemma 3.2's transfer, the multipliers that keep Lemma 3.1's thin neighbourhood thin
  are `U_{supp(u)}`, with `≍ (log M)^k` elements of height `≤ M`; the pigeonhole needs `M^{α}`. — §2.3

## Stage 1 — SAVED (quotation check, the claim list, the paper's theorem, C0)

### 1.1 The claim list, copied verbatim from `plans/CRUNCH-2026-09-26-x2x3-queue.md` §2

**Notation** (from `data/crunch-2026-09-25/briefs/J51V-FS100-kronecker-verifier.md`, verbatim): "`F ⊆ ℝ` a real number field, `L = F(i)`,
`U = U_F` the unit vectors (norm-one elements of `L/F`), `R = ℤ[U]`, `R̂` its dual; `T` the torsion characters, `A(R_F)` the archimedean ones,
`E = ⋃_S (T + A + Fin_S)` (`Fin_S`: continuous at the finite set `S` of split places) — `LEDGER.md` rows 98, 113." Added here: `U` acts on
`R̂` by `(u·χ)(x) = χ(ux)`; `m` is Haar probability on `R̂`; `h_μ(u)` is the Kolmogorov–Sinai entropy of `χ ↦ u·χ` for `μ`; for `u ∈ U`,
`H(u) = ∏_w max(1, |u|_w)` over the finite places `w` of `L` (normalised absolute values); `U_N = {u ∈ U : H(u) ≤ N}`.

### List X01 — route (A), Einsiedler–Fish (X01D derives, X01V verifies blind)

- **EF-G.** "For every real number field `F`: (a) `h_m(u) = log H(u)` for every `u ∈ U`; (b) `liminf_{N→∞} log #U_N / log N > 0`."
- **EF_F** [Poros's target, P-1]. "For every real number field `F`: every `U`-invariant, `U`-ergodic probability measure `μ` on `R̂` such that
  `h_μ(u) = 0` for some non-torsion `u ∈ U` satisfies `μ(E) = 1`."
- **EF-MR.** "PE-2 (list X02) and EF_F together imply MR(F) for every real number field `F`; over ℚ(√47), with SP-Cor and T-C(A) at `S = ∅`,
  they imply `χ(ℚ(√47)²) = 5`."
- **EF-X** (a control; the conclusion's shape). "Over `F = ℚ` there is a `U`-invariant, `U`-ergodic probability measure on `R̂` with
  `h_μ(u) = 0` for every `u ∈ U` that is not finitely supported; so EF_F's conclusion cannot be strengthened to finite support."

The input to quote from the paper itself (a reading item, not a claim): Einsiedler–Fish, *Rigidity of measures invariant under the action of
a multiplicative semigroup of polynomial growth on 𝕋*, Ergodic Theory Dynam. Systems 30 (2010) 151–157, Zbl 1189.37005 — its main theorem,
verbatim, with its hypotheses.


PE-2, which EF-MR names (list X02, same section, verbatim):
- **PE-2** (PE-lim). "For every real number field `F` and every `U`-invariant finite positive measure `τ` on `R̂`: `τ = a·m + τ′` with
  `a ≥ 0`, `τ′` a `U`-invariant finite positive measure, and `h_{τ′}(u) = 0` for every `u ∈ U`."

### 1.2 Quotation check (standing rule 5)

| quotation in the brief | source | result |
|---|---|---|
| MR(F): "every `U`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure" (J38 §3.5, T-J38-2 (iii)) | `plans/STUB-measure-rigidity-three-fields.md` line 58 | **matches**, verbatim |
| Einsiedler–Fish, ETDS 30 (2010) 151–157, Zbl 1189.37005; arXiv 0804.3586 | zbMATH API record `an:1189.37005` (title, authors, pages 151–157, ETDS); `ef.txt` header "arXiv:0804.3586v2 [math.DS] 4 Sep 2008" | **matches** |
| "prove rigidity for multiplier semigroups of polynomial growth on 𝕋" | EF Thm 1.2 (quoted in 1.3) | **matches** in substance (a paraphrase in the brief; the theorem itself is quoted below) |
| the list X01 and PE-2 | queue plan §2, copied in 1.1 by `sed` from the file, not retyped | **verbatim by construction** |
| SP-Cor's statement at `plans/FS84-SI-D-derivation.md` §4.2 | §4.2, "Corollary SP-Cor": "Over ℚ(√47): if every finite positive `U`-invariant measure on `R̂` with `τ(E) = 0` is a multiple of Haar measure, then `χ(ℚ(√47)²) ≥ 5`." [hand; given T-C(A) at `S = ∅`] | **exists, as addressed**; note it concludes `≥ 5`, not `= 5` (used in stage 2 on EF-MR) |
| "EL2021 §1 (`data/fs100/j51/el2021.pdf`)" | that path does not exist | **wrong address**; the owner's correction (message, 05:5x): `~/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf` (commit 8e941a76) |

### 1.3 The paper's main theorem, verbatim (`ef.txt`, p. 1)

> "**Theorem 1.2.** Let α > 0 and let Σ ⊂ N be a multiplicative semigroup with
> (1.1) lim inf_{N→∞} #(Σ ∩ [1, N]) / N^α > 0.
> Let µ be an ergodic Σ-invariant Borel probability measure on T = R/Z. Then either µ is supported on a finite number of points or µ is
> Lebesgue measure."

The proof's parts, as the paper states them (verbatim):
- Lemma 3.1: "In the setting of Theorem 1.2, if hµ(Tp) = 0 for some p ∈ Σ, then for any ε > 0 and any β > 0, there exist δ0 > 0 and X′ ⊂ T of
  measure µ(X′) > 1 − ε, such that for every positive δ ≤ δ0 and every x ∈ X′, µ(Bδ(x)) > δ^β".
- Lemma 3.2: "Under the assumptions of Theorem 1.2, if hµ(Tp) = 0 for some p ∈ Σ, then the measure µ has finite support."
- Positive entropy: Johnson's theorem (Theorem 2.2): "If Σ is a nonlacunary multiplicative semigroup of integers whose action on T as
  multiplication (mod 1) has an ergodic invariant Borel probability measure µ, then either µ is Lebesgue measure or the entropy of each map Tn,
  n ∈ Σ, has µ-entropy zero."
- "Theorem 1.2 follows from A.Johnson theorem cited in Section 2 combined with Lemma 3.2."

**Reading status (G50):** EF §§1–4 read in full, from `ef.txt` (the arXiv v2 text; the journal version not compared). Johnson 1992 and
Rudolph 1990 not read (cited by EF; not needed below). **Bibliography:** no `BIBLIOGRAPHY.md` entry for arXiv 0804.3586 or Zbl 1189.37005
(grepped); not in `~/source/library/pdf/` (grepped "einsiedler", "fish"); proposed row in stage 3.

### 1.4 C0 — probabilities before any derivation (written after reading EF once)

| claim | P(TRUE as stated) | the reason, one line |
|---|---|---|
| EF-G (a) | 0.35 | the Lind–Ward/Yuzvinskii entropy of an automorphism of a solenoid sums over the archimedean places too; `H` omits them, which is right only if `\|u\|_w = 1` at every archimedean place — true for totally real `F`, doubtful for a real `F` with a complex place |
| EF-G (b) | 0.85 | one element per split prime of degree one already gives `#U_N ≫ N^{1/h}/log N` |
| EF_F | 0.10 (GAP 0.70, FALSE 0.20) | EF Lemma 3.2 needs every multiplier to expand the one direction where the ball is thin; each `u ∈ U` expands only its own split places, and the archimedean directions are isometric for all of `U` |
| EF-MR | 0.85 | a composition; the risks are measurability of `E` and entropy's affinity over the ergodic decomposition, and `= 5` needs the upper bound too |
| EF-X | 0.90 | Haar measure on a circle of archimedean characters is rotated by `U` |

### 1.5 Would-have-searched-here log

- (none at stage 1)

## Stage 2 — SAVED (the derivations, controls first)

Conventions. `F ⊆ ℝ` of degree `d`, `L = F(i)` of degree `2d`, conjugation `x ↦ x̄` of `L/F`. For `u ∈ U`: `u ū = 1`, so `u⁻¹ = ū ∈ U ⊂ R`
and `U ⊂ R^×`. At a conjugation-stable prime `𝔓 = 𝔓̄`, `v_𝔓(u) = v_𝔓(ū) = −v_𝔓(u)`, so `u` is a unit there; at a split pair `𝔓 ≠ 𝔓̄`,
`|u|_{𝔓̄} = |u|_𝔓⁻¹`. At an archimedean place `w` of `L` over a **real** place of `F`, conjugation is complex conjugation, so `|u|_w = 1`; over a
**complex** place `v` of `F` there are two places `w, w′` of `L`, swapped by conjugation, and `|u|_{w′} = |u|_w⁻¹` (normalised values).
Structure of `R̂` (used below only through these facts): with `S` any finite set of split places containing `supp(u)`, the ring `R_S` of
elements integral outside `S` is `u`-stable, `R = ⋃_S R_S`, so `R̂ = lim← R̂_S` with `u`-equivariant factor maps; `R̂_S` is the `S`-adic
solenoid `(L_∞ × ∏_{w∈S} L_w)/R_S` (trace-form duality).

### 2.1 Control EF-X — TRUE [hand]

**Construction.** `F = ℚ`, `L = ℚ(i)`, `L_∞ = ℂ`. For `a ∈ ℂ` let `χ_a(x) = exp(2πi Re(a x))` on `R`; then `(u·χ_a)(x) = χ_a(ux) = χ_{au}(x)`.
Fix `r > 0`, let `λ_r` be normalised arc length on `C_r = {|a| = r}` and `μ = (a ↦ χ_a)_* λ_r`.
1. *Injective.* `χ_a = χ_b` ⟹ `Re((a − b)x) ∈ ℤ` for all `x ∈ R`. Now `1/5 ∈ R` (`(3+4i)/5 + (3−4i)/5 − 1 = 1/5`, both fractions in `U`),
   so `5^{−n}, i·5^{−n} ∈ R` for all `n`, giving `Re(a − b), Im(a − b) ∈ ⋂_n 5^n ℤ = {0}`. So `a ↦ χ_a` is a continuous injection of the
   compact `C_r`, a homeomorphism onto its image, and `(R̂, μ, U) ≅ (C_r, λ_r, rotations by u ∈ U ⊂ S¹)`.
2. *Invariant, ergodic.* Rotations preserve `λ_r`; `u₀ = (3+4i)/5 ∈ U` is not a root of unity (the roots of unity of `ℚ(i)` are `±1, ±i`), so
   rotation by `u₀` is ergodic for `λ_r`, a fortiori `U` is.
3. *Entropy.* Every `u` acts as an isometry of `C_r`: `h_μ(u) = 0` for every `u ∈ U`.
4. *Not finitely supported:* `λ_r` is atomless and the map is injective. *Carried by `A`* (the characters `x ↦ exp(2πi λ(x))`, `λ` ℚ-linear
   `L → ℝ`), so `μ(E) = 1`: consistent with EF_F, and the conclusion cannot be finite support. ∎

**What a wrong-reason pass would look like (G21).** (i) `r = 0`: `δ_0`, finitely supported — the claim fails there, so `r > 0` is load-bearing.
(ii) Not checking injectivity: over a ring where `a ↦ χ_a` had a large kernel the image could be finite. (iii) A field where `U` acted on
the circle through a finite group (no such real field: `U` is always infinite). (iv) Using a character off `A`: its orbit closure is not a
circle and the "measure" is not defined. None applies. **Every real `F`** has the same example (a circle of archimedean characters at one
complex place of `L` over a real place of `F`: `SP-if`'s `λ` in `plans/FS84-SI-D-derivation.md` §4.2 is this measure).

### 2.2 Control EF-G — (a) FALSE as stated (TRUE for totally real `F`); (b) TRUE for totally real `F`, degenerate otherwise

**(a), the formula.** `h_m(u) = Σ_{w ∈ supp(u) ∪ ∞} log max(1, |u|_w)` over places of `L` (normalised). Proof: `h_m(u) = sup_S h(R̂_S, u)`
(entropy of Haar measure on an inverse limit of equivariant factors whose σ-algebras increase to the full one), and
`h(R̂_S, u) = Σ_{w ∈ S ∪ ∞} log max(1, |u|_w)` (Lind–Ward's formula for `S`-adic solenoids: the log-modulus of the expanding part at each place;
the archimedean places always contribute, as on the torus `ℤⁿ`); the terms for `w ∈ S ∖ supp(u)` vanish. [hand; the two inputs are standard:
Lind–Ward 1988 (ETDS 8), and the inverse-limit continuity of entropy]
- **Totally real `F`:** every archimedean `|u|_w = 1`, and `u` is a unit at every stable prime, so `h_m(u) = Σ_{w finite} log max(1,|u|_w) = log H(u)`.
  **TRUE.**
- **`F` with a complex place: FALSE.** Counterexample: `F = ℚ(∛2)`, `u = (1 + ∛2·i)/(1 − ∛2·i)`. Exact (`tools/x01v_entropy_check.py`,
  output `data/fs100/x01v/entropy-check.out`): `u ū = 1`; minimal polynomial `5x⁶ + 18x⁵ + 75x⁴ + 60x³ + 75x² + 18x + 5`, so `u` has degree
  6 = `[L:ℚ]`, `log H(u) = log 5`; the trace polynomial `5t³ + 18t² + 60t + 24` has exactly **1** real root in `[−2, 2]` (Sturm, exact), so
  two conjugates of `u` are off the unit circle (moduli 3.431099 and 0.291452, 60-digit numerics), and
  `h_m(u) = log 5 + 2.465761… > log H(u)`. (The two roots of modulus 1 are the complex place over `F`'s real place, as predicted.)
  Control: `F = ℚ(√2)`, `u = (1+√2 i)/(1−√2 i)`, minimal polynomial `3x² + 2x + 3`, trace polynomial `3t + 2`, root in `[−2, 2]`: on the circle,
  `h_m(u) = log H(u) = log 3`. Plants: P1 (a `u` of norm ≠ 1) fired the membership assertion; P2 (the two expectations swapped) fired both
  on-circle assertions. **Tool defect found by its own run:** the first version tested non-reciprocity as the certificate of a root off the
  circle; `u⁻¹ = ū` is a conjugate of `u`, so the minimal polynomial is always reciprocal and the test could never fire; the counterexample
  run went red for that reason, and the test was replaced by the trace-polynomial Sturm count before any verdict was drawn.
- **What a wrong-reason pass looks like:** checking (a) only over ℚ or ℚ(√47) (both totally real) and passing it "for every real number field".

**(b).** *Totally real `F`:* `U ∩ O_L^×` is torsion (every archimedean `|u|_w = 1`, Kronecker), so `u` is determined up to finite torsion by its
divisor `Σ n_𝔭(𝔓 − 𝔓̄)` and `U_N` is finite. For a prime `𝔓` of `L` above a rational prime `p` that splits completely in the Galois closure `M`
of `L/ℚ`, `𝔓 ≠ 𝔓̄` and, with `h = h_L`, `𝔓^h = (z)`, `u_𝔓 = z/z̄ ∈ U` has `H(u_𝔓) = N𝔓^h = p^h`. Distinct `𝔓` give distinct `u_𝔓`, so
`#U_N ≥ #{p ≤ N^{1/h} : p splits completely in M} ≫ N^{1/h}/log N` (Chebotarev), and `liminf log #U_N / log N ≥ 1/h_L > 0`. **TRUE** [hand].
*`F` with a complex place:* the relative units `U ∩ O_L^×` have rank `r₂(F) ≥ 1` (Dirichlet: `r₁ + 2r₂ − 1` for `L` against `r₁ + r₂ − 1` for `F`)
and `H = 1` on them, so `#U_N = ∞` for every `N ≥ 1`: (b) holds only in the extended reals. The same units expand archimedean places: `H` is
the wrong height there, and the right one is `exp h_m(u) = ∏_{all w} max(1, |u|_w)`.

**Bearing on route (A):** ℚ(√47), the type-(B) fields and ℚ(√167) are totally real, so (a)'s failure does not touch the three fields; it
does make "for every real number field" wrong in (a), and it flags that any EF-style argument over a non-totally-real `F` must count by the
full height.

### 2.3 EF_F — GAP (at EF's Lemma 3.2, the multiplier step; with Lemma 3.1's analogue weaker than the paper's)

EF's proof, lemma by lemma, with the two changes the brief names: **(Δ1)** each `u ∈ U` expands only its own split places
(`{w : |u|_w > 1}`, one place of each split pair in `supp(u)`), contracts their conjugates, and is an isometry at every other finite place;
**(Δ2)** for totally real `F` every `u ∈ U` is an isometry at every archimedean place (for `F` with complex places, relative units expand
archimedean places, and `u = z/z̄` can too).

- **Theorem 2.1 (Shannon–McMillan–Breiman).** Holds verbatim for `(R̂, μ, u)`: `R̂` is compact metrisable (`R` countable), so the Borel
  σ-algebra is countably generated. *No change.*
- **Theorem 2.2 (Johnson), the positive-entropy half.** Not used by EF_F's zero-entropy argument; its role is PE-2's (list X02) and, in finite
  rank, EL2021 Thm 1.2: "Let α be a totally irreducible, not virtually-cyclic Zd action by automorphisms of a solenoid X. Let µ be an
  α-invariant and ergodic probability measure. Then either µ = mX is the Haar measure of X, or the entropy hµ(αn) = 0 vanishes for all n ∈ Zd."
  (`~/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf`, p. 2; read: §1's theorem
  statements only.) *See the entropy-transfer remark below: EF_F contains this half.*
- **Lemma 3.1 (zero entropy ⟹ zero dimension).** In EF the refined partition `⋁_{i<n} T_p^{−i} ξ` consists of intervals of length `p^{−n}`,
  because `T_p` expands the only direction. Here, by (Δ1)–(Δ2), the atoms of `⋁_{i<n} u^{−i} ξ` (even two-sided, using `h_μ(u⁻¹) = 0`) shrink
  only in the directions `L_w`, `w ∈ supp(u)`; in the archimedean directions and at every other split place they keep the partition's fixed
  scale `ε`. So SMB yields only: for `β, ε > 0` there are `δ₀` and `X′`, `μ(X′) > 1 − ε`, with `μ(N_{ε,δ}(x)) > δ^β` for `δ ≤ δ₀`, where
  `N_{ε,δ}(x)` is **`δ`-thin at the places of `supp(u)` and `ε`-fat everywhere else** — leafwise dimension zero along `u`'s unstable
  subgroup (Einsiedler–Lindenstrauss's leafwise measures), not `μ(B_δ(x)) > δ^β` for a ball. *Changes: the conclusion, fundamentally.*
- **Lemma 3.2 (zero dimension + many multipliers ⟹ finite support).** Its steps, verbatim where quoted:
  1. "every image interval Aq = qBδ(x) has µ-measure at least δβ" — survives (`μ(u′N) = μ(N)`, `u′` an automorphism).
  2. The images are small: "|q1 (i1 − x) − q2 (i2 − x)| ≤ 2δM". **Fails.** For `u′ ∈ U_M`, `u′N_{ε,δ}(x)` stays thin at `supp(u)` (expanded by
     at most `M`), but at each place `w ∈ supp(u′) ∖ supp(u)` with `|u′|_w > 1` the neighbourhood was fat and `u′` expands it by `|u′|_w`;
     at the archimedean places it stays `ε`-fat. The multipliers that keep `N_{ε,δ}` thin wherever it is thin and do not expand where it is
     fat are those with `supp(u′) ⊆ supp(u)`: the group `U_{supp(u)}`, of rank `k` = number of split pairs in `supp(u)`, with
     `#{u′ ∈ U_{supp(u)} : H(u′) ≤ M} ≍ (log M)^k` — **lacunary**; (1.1) fails for it, whatever EF-G (b) says about `U`.
  3. The pigeonhole "M^{α/2} δ^β = M^{α/4} > 1" therefore has only `(log M)^k · M^{−5β} → 0`: **no overlap is forced. This is the gap.**
  4. The Diophantine step, even granted an overlap: `(u₁ − u₂)x ≈ r ∈ R` must be divided by `u₁ − u₂`, and (i) `|u₁ − u₂|_∞` can be tiny
     (`U` is dense in the archimedean circles, so among `#U_M ≥ M^{α}` points some pair is `≪ M^{−α/d}` apart), which amplifies the
     archimedean error, where EF has `|q₁ − q₂| ≥ 1`; (ii) at finite places outside `supp(u)` where `u₁ − u₂` has positive valuation the
     division amplifies too. So the step needs an adelic replacement (the product formula with heights), with archimedean slack — which is
     why the natural conclusion is `E` (torsion modulo archimedean and finitely many places), not finite support.
  5. "X′ has only finitely many points … By ergodicity, we get that µ has a finite support" — would become "`μ(E) = 1`" by ergodicity (`E` is
     `U`-invariant, and a countable union of the `U`-invariant `E_S`), were steps 2–4 available.
- **Strengthening the hypothesis does not close it.** With `h_μ(u) = 0` for **every** `u` (which PE-2 reduces to), each place is thin for its
  own `u_𝔓`, but step 2 needs one neighbourhood thin at every place some `u′ ∈ U_M` expands — all split places of norm `≤ M`, `≍ M/log M`
  of them — with `μ > δ^β` uniformly in `M`. The only SMB source is a single element `u_M = ∏ u_𝔓` over those places, and Lemma 3.1's
  `δ₀`, `X′` depend on the element: EF fixes `p` once and lets `M → ∞` with `δ = M^{−5} ≤ δ₀(p)`; here `δ₀(u_M)` moves with `M`. **Named
  missing lemma (UZ):** *a uniform-in-`M` lower bound `μ(N_M(x)) > δ^β` on a set of `x` of measure `≥ 1/2`, where `N_M(x)` is `δ = M^{−5}`-thin at
  every split place of norm `≤ M` and fat elsewhere, for `U`-ergodic `μ` with all entropies zero.* Neither EF nor SMB supplies it.
- **Entropy transfer, and why EF_F is stronger than route (A) needs [hand].** Every `U`-ergodic `μ` with `μ(E) = 1` has `h_μ(u) = 0` for every
  `u`: each `E_S` is `U`-invariant, so `μ(E_S) = 1` for some finite `S`; `E_S` is a countable union of cosets `t + V`, `V` the injective image
  of `L_∞ × L_S`, which `U` permutes, so `μ` sits on finitely many cosets, a finite-index `U′ ⊆ U` fixing each; on `t + V` each `u ∈ U′` acts
  affinely, and an invariant probability under an affine map expanding `L_w` (some `u_𝔓^j ∈ U′` does, for each `w ∈ S`) has a point
  marginal at `w` (dilation: the annuli about the fixed point have equal mass); so `μ` lives on finitely many translates of `A`'s isometric
  part, where every `u` is an isometry: zero entropy. Hence **EF_F ⟹ "`h_μ(u₀) = 0` for one non-torsion `u₀` ⟹ `h_μ(u) = 0` for all `u`"**, a
  positive-entropy rigidity statement (EL2021 Thm 1.2's dichotomy, for the infinite-rank action) that EF's Lemma 3.2 gets on 𝕋 only because
  every `T_q` expands the one direction. EF-MR needs only the zero-entropy half, **EF_F⁰:** "every `U`-invariant, `U`-ergodic probability
  measure `μ` on `R̂` with `h_μ(u) = 0` for every `u ∈ U` satisfies `μ(E) = 1`"; and PE-2 ∧ EF_F⁰ ⟹ EF_F (an ergodic `μ` is `m` or `τ′`, and
  `h_m(u₀) > 0` for non-torsion `u₀`: some place has `|u₀|_w > 1`, else Kronecker makes `u₀` torsion).
- **No counterexample.** A counterexample to EF_F, given PE-2, is a `U`-ergodic zero-entropy measure off `E` — the zero-entropy
  Furstenberg-type question for this action, which nothing here decides; without PE-2 it is a measure with `h(u₀) = 0 < h(u₁)`, i.e. a failure
  of PE-2 itself. Measures along cosets of `A` are no counterexample: a `U`-invariant coset `t + A` has `(u − 1)t ∈ A` for every `u`, which
  forces `t`'s finite adelic part into `L`, so `t + A ⊆ T + A ⊆ E`.

**Verdict: GAP**, at EF Lemma 3.2's multiplier step (item 2–3): the multipliers that preserve the thin neighbourhood Lemma 3.1's analogue
produces form a group of polynomial-in-`log M` growth, so EF's growth hypothesis (EF-G (b), true for `U`) is the wrong one; closing it needs
UZ, and the statement as posed also contains a positive-entropy entropy-transfer statement that EF's route cannot supply (use EF_F⁰).

### 2.4 EF-MR — TRUE, as a conditional (with one input to name for "= 5")

**Part 1: PE-2 ∧ EF_F ⟹ MR(F)** [hand]. Let `τ` be `U`-invariant, finite, positive, `τ(E) = 0`. PE-2: `τ = a·m + τ′`, `h_{τ′}(u) = 0` for every
`u`. Suppose `τ′ ≠ 0`; normalise. `U` is countable and `R̂` compact metrisable, so `τ′ = ∫ μ_ξ dP(ξ)` into `U`-ergodic probabilities. Entropy
is affine over any decomposition into `u`-invariant measures (decompose each `μ_ξ` into `u`-ergodic parts; by uniqueness this is `τ′`'s
`u`-ergodic decomposition, and Jacobs' formula applies), so `h_{μ_ξ}(u) = 0` for `P`-a.e. `ξ`, for all `u` at once (`U` countable). `U` has a
non-torsion element (its torsion is the finite group of roots of unity of `L` of norm one; `U` is infinite). EF_F (indeed EF_F⁰) gives
`μ_ξ(E) = 1` a.e., so `τ′(E) = τ′(R̂) > 0`; `E` is Borel (a countable union over finite `S` and over the countable `T` of σ-compact images of
`L_∞ × L_S`). Then `τ(E) ≥ τ′(E) > 0`, a contradiction. So `τ = a·m`. ∎
**Part 2, over ℚ(√47).** SP-Cor (`plans/FS84-SI-D-derivation.md` §4.2, verbatim in 1.2) has MR(ℚ(√47)) word for word as its hypothesis and
concludes `χ(ℚ(√47)²) ≥ 5`, given T-C(A) at `S = ∅`. **`= 5` needs one more input the claim does not name:** `χ(ℚ(√47)²) ≤ 5`, the plane at
11 (Theorem A; `LEDGER.md` row 84's "proven `4 ≤ χ ≤ 5`"). With it, TRUE. ∎
**Wrong-reason pass to watch for:** reading PE-2's `τ′` as ergodic (it is not), or using EF_F on `τ′` directly; both avoided above.

### 2.5 Would-have-searched-here log

- EF-G (a): would have searched fields for a `u` with `h_m(u) ≠ log H(u)`; instead derived where the archimedean term lives (complex places of
  `F`) and wrote down one element by hand, then checked it exactly (one field, one element, seconds).
- EF_F: would have searched for a zero-entropy non-`E` measure (e.g. random invariant measures on finite quotients); instead derived the
  entropy-transfer content and the coset argument, and left the question as the named gap.

## Stage 3 — SAVED (the write-up, before anything fenced was opened)

### 3.1 Verdicts

| claim | verdict | grade | where |
|---|---|---|---|
| **EF-X** (control) | **TRUE** | [hand] | §2.1; X01V-T4 |
| **EF-G (a)** | **FALSE as stated** — counterexample `F = ℚ(∛2)`, `u = (1+∛2 i)/(1−∛2 i)`; **TRUE for totally real `F`** | [tools exact + hand] | §2.2; X01V-T1, T2 |
| **EF-G (b)** | **TRUE for totally real `F`** (`≥ 1/h_L`); for `F` with a complex place `#U_N = ∞` (true only in the extended reals) | [hand] | §2.2; X01V-T3 |
| **EF_F** | **GAP** at EF Lemma 3.2, steps 2–3 (the images `u′B` stay small / the pigeonhole): Lemma 3.1's analogue gives a neighbourhood thin only at `supp(u)`, and the multipliers that keep it thin are `U_{supp(u)}`, `(log M)^k` of them — lacunary. Named missing lemma **UZ** (§2.3). Also: as posed EF_F contains a positive-entropy entropy-transfer statement (X01V-T5) that EF's route cannot supply; the route needs only **EF_F⁰** | [hand] | §2.3; X01V-T5, T7 |
| **EF-MR** | **TRUE** as a conditional (part 1, with EF_F⁰ in place of EF_F); part 2's "`= 5`" needs the unnamed input `χ(ℚ(√47)²) ≤ 5` (Theorem A at 11), SP-Cor giving `≥ 5` | [hand] | §2.4; X01V-T6 |

**What route (A) buys, in one sentence.** Einsiedler–Fish's theorem does not transfer: its zero-entropy lemma works on 𝕋 because every
multiplier expands the one direction the zero-entropy map shrinks, while in `R̂` each `u ∈ U` expands only its own split places and none
expands the archimedean ones (totally real `F`); so polynomial growth of `U` (true) is the wrong hypothesis, and MR's zero-entropy half
(EF_F⁰) stays exactly as open as before, with UZ as the named step an EF-style proof would need.

### 3.2 C0 scored

| claim | C0 P(TRUE as stated) | outcome |
|---|---|---|
| EF-G (a) | 0.35 | FALSE (true on the totally real part) |
| EF-G (b) | 0.85 | TRUE (totally real); degenerate otherwise |
| EF_F | 0.10 (GAP 0.70, FALSE 0.20) | GAP |
| EF-MR | 0.85 | TRUE as a conditional, one input to name |
| EF-X | 0.90 | TRUE |

### 3.3 Corrections and proposals (the front-page lane decides; nothing edited here)

1. **EF-G (a)** should read "for every **totally real** `F`", or use the full height `∏_{all w} max(1, |u|_w) = exp h_m(u)`.
2. **EF-MR** part 2 should name `χ(ℚ(√47)²) ≤ 5` (Theorem A at 11) beside SP-Cor, or conclude `≥ 5`.
3. **EF_F** should be replaced by **EF_F⁰** ("… with `h_μ(u) = 0` for every `u ∈ U` …") wherever it serves MR: the "for some `u`" form is
   strictly stronger and its extra content is PE-2's.
4. **The brief's address for EL2021** (`data/fs100/j51/el2021.pdf`) does not exist; the file is
   `~/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf` (owner's message).
5. **`BIBLIOGRAPHY.md` row proposed:** `[EinsiedlerFish2010]` M. Einsiedler, A. Fish, *Rigidity of measures invariant under the action of a
   multiplicative semigroup of polynomial growth on 𝕋*, Ergodic Theory Dynam. Systems 30 (2010) 151–157, Zbl 1189.37005, arXiv:0804.3586.
   Copy: `data/crunch-2026-09-26-x2x3/poros/einsiedler-fish-0804.3586.pdf` (+ `ef.txt`); not in `~/source/library/`. Read: §§1–4 in full
   (arXiv v2). What rests on it here: FS-100 route (A)'s verdict (EF_F GAP). Also cited, not read: Lind–Ward 1988 (entropy of `S`-adic
   solenoids; used for X01V-T1 by statement), Johnson 1992.
6. **Stub re-aim (FS-100 stage 5):** route (A) as "transfer EF" is closed at a named step; what is left of it is UZ, a uniform-in-`M`
   local-dimension bound for all-zero-entropy `U`-ergodic measures, and that is the zero-entropy half of MR restated, not a reduction of it.

### 3.4 Would-have-searched-here log (stage 3)

- none (write-up only).

## Stage 4 — not run (the fallback was not triggered)

Every claim reached a verdict in stage 2 (EF_F's is a GAP at a named step, not a stall), so X01D's lemma statements were not opened; at
05:56 X01D was still at its stage 2, so a statement-by-statement check belongs to the close, where both records are final.

## Stage 4 — SAVED (triggered by the owner after stage 3: X01D's §3 read, proofs included, and checked step by step)

*The owner's instruction (message, after 05:57): X01D reports EF_F TRUE in the stronger form EF_F⁺; read `plans/FS100-X01D-derivation.md`
§2.0–§2.1 and §3 and decide whether its argument closes my named gap. This check is therefore **not blind**: it is a second reading of one
derivation.* X01D's statement (§3.0, verbatim): "**EF_F⁺.** For every real number field `F`: every `U`-invariant finite positive Borel measure
`μ` on `R̂` such that `h_μ(u*) = 0` for **one** non-torsion `u* ∈ U` satisfies `μ(R̂ ∖ (T + A)) = 0`."

### 4.1 Step by step

| X01D step | what it needs | my check |
|---|---|---|
| §3.1 Lemma PF | product formula, stable places bounded by `C_Λ` (`Λ = R^∨` a fractional ideal) | **valid** |
| §3.2 Step 0 | a place `v*` with `\|u*\|_{v*} > 1` (Kronecker + product formula); `v*` split or archimedean | **valid** |
| §3.3 Lemma 3.1′ | local injectivity: if `u*^i a₀ ∈ Q′` then `y′ = u*^{i+1}a₀ − b ∈ Λ` has product `< 1/C_Λ` by the choice of `ε`, so `y′ = 0`; hence every Bowen atom lies in a box `2ε`-fat at `∞`, `O_w`-fat at split `w`, and `s^{−(n−1)}`-thin at `v*`; SMB + Jacobs + Egorov give `μ(box) ≥ δ^β` for **every** `β > 0` | **valid** (the non-ergodic SMB limit handled by Jacobs, as written) |
| §3.4 Step 3 | multipliers `V_M ⊆ U_ℚ`, `#V_M ≥ c₀M^{α}`, `α = 1/[F:ℚ]` (Lehmer's count; `H_L = H_{ℚ(i)}^{[F:ℚ]}` on `ℚ(i)`); each an isometry at every archimedean place of `L`; `δ = M^{−K}`, `β = α/(2K)`, so `Σ μ(vB) ≥ c₀M^{α/2} > μ(R̂)` | **valid**; the table's bounds (`\|e\|_w ≤ m(w)` at split `w ≠ v*`, `∏_w m(w) ≤ M²`) checked |
| §3.5 Step 4 | `z = ℓ₂r₁ − ℓ₁r₂ = ℓ₁e₂ − ℓ₂e₁ ∈ Λ`; product `< (16ε)^{[L:ℚ]}·M^{3−K}·M⁶ < 1/C_Λ` for `K = 16`, `ε < 1/16`, `M` large; so `z = 0` — **only multiplication, no division** | **valid** |
| §3.6 Step 5 | divide at `v*` only: `\|ℓ_j\|_{v*} ≥ 4^{−[L:ℚ]/2}M_j^{−2}` by Lemma PF for the single `ℓ_j ∈ R`; scales `M, M², M⁴, …` share one `t`; `(x̃ − t)_{v*} = 0` | **valid** |
| §3.7 Step 6 | disjoint injective leaves `π(t + W_{v*})`; `L/Λ ≅ ⊕_{w stable} L_w/Λ_w` has finite `U`-orbits; on a leaf `U_t` acts linearly | **valid** |
| §3.8 Step 7 | wandering shells at each split `w ≠ v*` (finite `ν_t`, `g^k ∈ U_t` rescales the `w`-coordinate) | **valid** (my stage 2's coset argument, X01V-T5, is the same mechanism) |

**Verdict: X01D's step is VALID; EF_F⁺ holds, and with it EF_F** [hand: one derivation (X01D) and this checking reading, not independent].
I found no failing line.

### 4.2 Which of my stage-2 reasons was wrong

1. **§2.3, Lemma 3.2 item 2 ("The images are small … Fails") and item 3 (the pigeonhole, "(log M)^k").** Wrong premise: I required the
   images `u′B` to stay small at every place, as EF's Euclidean diameter argument does. The adelic argument needs only that the *product* over
   all places of the error `z` be `< 1/C_Λ`. Fatness at a split `w ≠ v*` costs a factor `≤ m(w)`, whose product is bounded by the multipliers'
   heights (polynomial in `M`), and Lemma 3.1′ lets the thinness at the one place `v*` be `M^{−K}` for any fixed `K` (because `β` may be taken
   `α/(2K)`). So all of `U_ℚ ∩ U_M` are usable multipliers, not only `U_{supp(u)}`. **UZ is not needed; X01V-T7 is withdrawn as a no-go** (its
   count is true and irrelevant).
2. **§2.3 item 4 (division by `u₁ − u₂` amplifies errors at `∞` and at finite places).** Avoided: Step 4 multiplies (`z = ℓ₁e₂ − ℓ₂e₁`), and the
   only division, at `v*` in Step 5, is bounded below by Lemma PF for one element of height `≤ M²`.
3. **§2.3 "Entropy transfer … a positive-entropy statement that EF's route cannot supply" and the proposal to use EF_F⁰.** Wrong: the transfer
   comes out of the zero-entropy argument itself, as EF's Lemma 3.2 gives it on 𝕋. X01V-T5 stands as a lemma (a measure carried by `E` has zero
   entropy for every `u`), but **corrections 3.3 item 3 (EF_F → EF_F⁰) and item 6 (route (A) closed at UZ) are withdrawn**.

### 4.3 Revised verdicts (supersede §3.1 for EF_F and EF-MR)

| claim | X01V after stage 4 | X01D | difference of truth |
|---|---|---|---|
| EF-X | TRUE | TRUE | none |
| EF-G (a) | FALSE as stated (ℚ(∛2), `u = (1+∛2 i)/(1−∛2 i)`), TRUE for totally real `F` | FALSE (ℚ(∛2), a relative unit with `H = 1`), TRUE for totally real `F` | none (two different counterexamples) |
| EF-G (b) | TRUE for totally real `F`; `#U_N = ∞` otherwise | TRUE, degenerate when not totally real | none |
| EF_F | **TRUE** (via EF_F⁺), [hand, one derivation + a checking reading] | TRUE (EF_F⁺) | my stage-3 GAP was an error of mine, not a difference in the mathematics |
| EF-MR | TRUE as a conditional (EF_F now usable as stated); "`= 5`" still needs `χ(ℚ(√47)²) ≤ 5` named | (not read) | — |

**Consequence (hand, from the two):** PE-2 ∧ EF_F⁺ ⟹ MR(F) for every real number field `F` (§2.4's argument, with EF_F⁺ in place of EF_F⁰).
Route (A) is **open only at PE-2**. **Caveat for the close:** EF_F⁺ is a strong statement (one zero-entropy element forces `T + A`, with no
ergodicity), so it deserves a blind second derivation before it enters `LEDGER.md` as more than one mind's.

### 4.4 Would-have-searched-here log (stage 4)

- none (reading and checking only).
