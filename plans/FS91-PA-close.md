# FS-91 (crunch milestone M1) — the close-time prior-art gate (crunch job J23p)

*WORKFLOW 3.2's eight questions run on the theorems M1 filed. de Bruijn, Opus 5.5, 2026-09-25. Brief:
`data/crunch-2026-09-25/briefs/J23p-M1-prior-art-gate.md` (+ `STANDING-RULES.md`). Query files and raw output: `data/fs91/j23p/`
(`pa.py` is the helper: zbMATH Open API with two retries after 20 s on a 502 or timeout, logged `UNANSWERED`, never a negative; arXiv API;
OpenAlex; Semantic Scholar by `curl`). Papers downloaded to `~/source/library/pdf/`. Every negative below measures its query's words
(G21). Nothing here is called new: the verdicts are "in print", "partly in print", "not found by these searches" or "undecided".*

## Stage 0 — SAVED (quotation check, tool control, the opening gate's debts)

### 0.1 Quotation check (standing rule 5)

The brief quotes no statement in quotation marks; its seven result lines are paraphrases with addresses. Each was checked against the
record's own statement:

| # | brief's paraphrase | the record's statement (verbatim) | finding |
|---|---|---|---|
| 1 | "every closed `U_S`-invariant set of characters of `ℤ[i][1/p : p ∈ S]` missing a neighbourhood of 0 lies in torsion plus archimedean" | J03a-3: "`RS_k(S)` and `MS_k(S)` for every `k ≥ 2` and finite `\|S\| ≥ 2`; equivalently every character of `R_S` outside `T + A` takes values arbitrarily close to 0 on `U_S`" (`plans/FS91-S0V2-SWm-second-reading.md` line 293) | **paraphrase, ambiguous**: "a neighbourhood of 0" must mean a neighbourhood of 0 in `ℝ/ℤ` avoided by the values `θ(u)` (a band), not a neighbourhood of the trivial character in `R̂_S`, which would be a much weaker hypothesis. The search used the record's form |
| 2 | "a character colouring … exists with `k` colours iff one exists on the residue plane at a single stable place" | J07-7 / §3.1: "Let `k ≥ 3` satisfy `H_k` … Then `Θ_k(R_F) ≠ ∅` if and only if some stable place `𝔓` of `F(i)` and some level `m ≥ 1` have a band `k`-character of `T_{𝔓,m}`" (`plans/FS91-S1D-character.md` line 179) | **paraphrase drops two things**: "some level `m ≥ 1`" (not only the residue plane at level one; level collapse needs `p > k/2`) and "given `H_k`" |
| 3 | "the plane is three-colourable iff the local bound is at most three" | J02-T2: "**S1**: `χ(F²) ≤ 3 ⟺ Θ₃ ≠ ∅ ⟺ Θ₃ ∩ T₆ ≠ ∅ ⟺` (the two prime types) `⟺ L(F) ≤ 3`, every real number field" | agrees |
| 4 | Lemma C/C′: "`R_F/NR_F`" | J07-3, J07-4 (`plans/FS91-S1D-character.md` lines 362–363) | agrees |
| 5 | "a spectral form of Burr–Erdős–Lovász `χ(G × K_n) = min`" | J21-MX (`plans/M3-S1D-windows-five.md` line 266); its text: "the classical `χ(G × K_n) = min(χ(G), n)` (Burr–Erdős–Lovász 1976, as cited in `[Zhu2025]` §1)" | agrees |
| 6 | "at a single prime, a minimal set of characters outside torsion plus archimedean exists, and torsion orders are unbounded" | J12-MS: "`MS₄({5})` is false: a `U₅`-minimal closed subset of `Θ₄(R₅)` disjoint from `T + A` exists"; J12-MSp "the same at every `p ≡ 1 (mod 4)`"; J12-C3 "the orders of band torsion characters of `R₅` are unbounded" (`plans/FS91-S1D-one-prime.md` lines 356–365) | **paraphrase drops "inside `Θ₄`"**, which is the whole content (without a band, one-parameter minimal sets of positive dimension are `[Berend1984min]` Lemma 3.3). Grade per the owner: one derivation, blind check (J13) pending |
| 7 | "the fewest colours of a character colouring of `UD(𝔽_q, 2)`" | J08-1 … J08-5 (`plans/FS91-S1D-six.md` lines 304–308) | agrees |

### 0.2 Tool control

`pa.py zb` on `au:"Berend, Daniel"` returned 149 hits, the count FS-89's gate recorded (`plans/FS89-rational-band-rigidity.md` §PA.2
row 1): the query path reads real counts. The arXiv path was first silent (a regex over the Atom feed printed counts but no titles);
fixed by splitting entries, re-run, and it now prints `1101.0321v3 | 2011 | Rigidity of Commutative Non-hyperbolic Actions …` for a
title query known to hit. A 404 from zbMATH is its empty result (0); no query in stages 0–1 went unanswered.

### 0.3 Debts inherited from the opening gate (`plans/FS91-character-local-global.md` §PA.3 item 5)

`[Johnson2000]`, `[Johnson2006]` (unread, not held; routes in `BIBLIOGRAPHY.md` § R); Johnson 2011 survey (held as `[Johnson2010]`, read);
Liu's 2008 survey, DeVos et al. 2007 (not held); eight zbMATH queries unanswered on 2026-09-25 (re-run in stage 2 below).

### 0.4 Would-have-searched-here log

Empty for the whole job: a literature search is not a finite-witness search, and nothing here was tempted toward one.

## Stage 1 — SAVED (result 1: band rigidity at every band)

**Statement searched** (J03a-3, J03a-7, J03a-8; J01-2 = PA-B2 for the minimal-set form): for finite `|S| ≥ 2`, every character of
`R_S = ℤ[i][1/p : p ∈ S]` whose values on `U_S = ⟨i⟩ × ⟨w_p⟩` avoid a neighbourhood of 0 in `ℝ/ℤ` is torsion plus archimedean; every
`U_S`-minimal closed set lies in `T + A`; over every `F ⊆ ℝ`, `Θ_k(R_F) ⊆ T_{N_k}(R_F) + A(R_F)`.

**Named in the discipline's words:** closed invariant sets (orbit closures) of a totally irreducible, not virtually cyclic `ℤ^d`-action
by automorphisms of an `S`-adic solenoid, *without Berend's hyperbolicity*: the archimedean place is an **isometric** common
eigen-direction. The classical form is "every orbit closure is dense or the point is a torsion point translated along the isometric
subspace". Harmonic analysis: the Bohr-type set `{χ : χ(Θ) ∩ (−ε, ε) = ∅}`; combinatorial geometry: **the pyjama problem** (covering the
plane by rotated strips is exactly asking that every character's values on the rotations come near 0).

### 1.1 Queries

| database | query | hits | what bears |
|---|---|---|---|
| zbMATH | `ab:"non-hyperbolic" & ab:"toral"` | 5 | two records withheld by licence; Peng Sun 2011 (entropy); off the question |
| zbMATH | `ti:"non-hyperbolic" & ab:"invariant"` | 30 | smooth dynamics (Díaz–Gorodetski etc.); off |
| zbMATH | `au:"Wang, Zhiren"` (the author listing) | 43 | **Zbl 1278.37007, Wang, *Rigidity of commutative non-hyperbolic actions by toral automorphisms*, ETDS 2012 (summary)**; Lindenstrauss–Wang, Duke 2012; Wang 2011 IMRN; Wang 2018 nilmanifolds |
| zbMATH | `ab:"Furstenberg" & ab:"semigroup" & ab:"compact abelian"` | 1 | Haynes–Munday 2013 (held since FS-89) |
| zbMATH | `au:"Muchnik, Roman"` | 9 | **Zbl 1071.37008, *Semigroup action on `T^n`*, Geom. Dedicata 2005** (text withheld by licence) |
| zbMATH | `au:"Starkov, A. N."` | 40 | Starkov 1999 (minimal sets of commutative algebraic actions on a torus; withheld); Guivarc'h–Starkov 2004 (non-abelian) |
| zbMATH | `ab:"ID property" \| ab:"ID-property"` | 2 | Berend 1983 only |
| zbMATH | `ab:"times 2 times 3"` | 26 | Han Yu 2022 (×2×3×5 on `T²`), Kloeckner 2017; off |
| zbMATH | `ti:"generalization of Furstenberg"` | 1 | Kra 1999 PAMS (review read: sums `Σ p_i^n q_i^m α_i` dense); real, hyperbolic |
| zbMATH | `ab:"pyjama"`; `ti:"pyjama"` | 5; 3 | **Manners, *A solution to the pyjama problem*, Invent. Math. 2015 (Zbl 1332.52009)**; Malikiosis–Matolcsi–Ruzsa 2013; **Kravitz–Leng 2025, *Quantitative pyjama*** ; Malikiosis 2017 |
| zbMATH | `au:"Manners, Freddie"` | 21 | the pyjama paper is his only one on the question |
| zbMATH | `ab:"S-integer dynamical systems"` | 5 | Ward 1998, 2000 (periodic points; off) |
| zbMATH | `ab:"orbit closure" & ab:"solenoid"` | 1 | Singhal 2021 (absolute games; off) |
| zbMATH | `ab:"Gaussian integers" & ab:"Furstenberg"` | 1 | Tao 2006 (constellations; off) |
| zbMATH | `ab:"Furstenberg" & ab:"diophantine" & ab:"p-adic"` | 2 | Harrap–Haynes 2013 (mixed Littlewood); off |
| zbMATH, 0 hits (404) | `ab:"Berend" & ab:"non-hyperbolic"`; `ab:"closed invariant" & ab:"solenoid"`; `ab:"invariant" & ab:"solenoid" & ab:"Furstenberg"`; `ab:"multiplicative semigroup" & ab:"solenoid"`; `ab:"infinite invariant" & ab:"dense" & ab:"automorphisms"`; `ab:"central direction" & ab:"closed invariant"`; `ab:"partially hyperbolic" & ab:"orbit closures" & ab:"toral"`; `ab:"S-adic" & ab:"invariant" & ab:"closed" & ab:"rigidity"`; `ab:"Furstenberg" & ab:"x2x3"`; `ab:"Furstenberg's theorem" & ab:"number field"`; `ab:"Bohr" & ab:"multiplicative semigroup" & ab:"characters"`; `ab:"minimal sets" & ab:"commuting automorphisms" & ab:"compact abelian"` | 0 | — |
| arXiv | `ti:"non-hyperbolic" AND ti:"toral automorphisms"` | 1 | 1101.0321 (Wang) |
| arXiv | `abs:"times 2 times 3" AND abs:"orbit closures"` | 1 | 2009.00441 (Han Yu) |
| arXiv, 0 hits | `abs:"non-hyperbolic" AND abs:"toral automorphisms" AND abs:Berend`; `abs:Furstenberg AND abs:solenoid AND abs:invariant`; `abs:"S-adic" AND abs:Furstenberg AND abs:"orbit closure"`; `abs:Berend AND abs:"invariant sets" AND abs:"compact abelian"`; `abs:Furstenberg AND abs:"Gaussian integers" AND abs:"orbit"`; `abs:"multiplicatively independent" AND abs:"orbit closures" AND abs:"torus"`; `abs:"isometric" AND abs:"Furstenberg" AND abs:"toral"`; `abs:"ID property" AND abs:"tori"`; `au:Muchnik AND ti:semigroup` | 0 | — |
| OpenAlex + Semantic Scholar | works citing Wang 2012 (journal W2963788883 and arXiv W1967026739; S2 `arXiv:1101.0321`) | 4 + 2; 7 | Manners 2015; Einsiedler–Lindenstrauss 2021/22 (*Rigidity properties for commuting automorphisms on tori and solenoids*); a 2021 survey; Brown's 2019 notes; Lindenstrauss–Wang. The two databases agree |
| OpenAlex | works citing Manners 2015 (W2011752056) | 2 | (the count; Kravitz–Leng 2025 found by zbMATH, not by the citation count — a preprint) |

Raw output: `data/fs91/j23p/r1-zb.out`, `r1-zb2.out`, `r1-arx.out`, `r1-oa-wang-citers.out`.

### 1.2 Papers opened, and what was read

- **`[Manners2015]`** F. Manners, *A solution to the pyjama problem*, Invent. Math. (2015), doi 10.1007/s00222-014-0571-7, Zbl 1332.52009;
  arXiv 1305.1514v2, held `~/source/library/pdf/Manners2015-solution-pyjama-problem.pdf`. **Read in full: §1–§5** (pp. 1–13); §6.4–6.5
  read in part (the orbit-closure lemma and Def. 6.7, "non-Archimedean limit point"); §6.1–6.3, §7, Appendix A **not read**.
  - His object is ours at `S = {5, 13}`, with half the places: `A = ℤ[i][1/P₅, 1/P₁₃]` (one Gaussian prime above each of 5 and 13),
    `Θ = {θ₅^r θ₁₃^s : r, s ≥ 0}` with `θ_p = P_p/P̄_p` in some orientation (the overline is lost in the PDF's text layer), acting on
    `Â` by `(θχ)(a) = χ(θa)`; pyjama stripe `E₁* = {χ : χ(1) ∈ (−ε, ε)}`.
  - **Lemma 5.3 (infinitary rationality lemma), verbatim:** "As above, treat `(Θ, Â)` as a topological dynamical system. If `Y ⊆ Â` is a
    closed, Θ-invariant set such that the image of the evaluation map `Y(1) = {χ(1) : χ ∈ Y}` is not all of `T`, then `Y` is contained in a
    set of the form `U = ⋃_{i=1}^k B^C_{1/2}(u_i)` where `u_1, …, u_k` is a finite collection of torsion points of `Â`." (`B^C_R(x)` is `x`
    plus the image of the closed complex ball of radius `R`, i.e. torsion plus a small archimedean character.)
  - Remark 2.2(iii): "The significance of the numbers 5 and 13 is merely that they are primes of the form 4k + 1. Any pair of such numbers
    would work" (asserted, not proved). Remark 5.4(i): "We know of no reason why the result could not be strengthened to give `Y = Â` as
    one part of the dichotomy; but we do not need this strengthening, and our proof does not provide it." §5.5: "the appropriate results
    are false for the smaller set `{θ₅^r : r ≥ 0}`; … we might say this set is 'lacunary'" (asserted; no proof in §1–§5). §2.3: "Lemma 5.3
    does not follow from any of these results [Berend 1984, Muchnik 2005, Wang 2012], or (as far as the author is aware) from any others in
    the published literature". Method: Boshernitzan's variant of Furstenberg's proof, with "non-Archimedean limit points" replacing limit
    points (§6.5) — the same move as the records' `T + A` with the archimedean leaf set aside.
- **`[Wang2012]`** Z. Wang, *Rigidity of commutative non-hyperbolic actions by toral automorphisms*, ETDS 32 (2012) 1752–1782, doi
  10.1017/S0143385711000484, Zbl 1278.37007; arXiv 1101.0321v3, held `~/source/library/pdf/Wang2012-rigidity-commutative-non-hyperbolic-toral.pdf`.
  **Read: abstract, §1 in full (1.1–1.6), §2.3, §4.1 (Lemma 4.2's proof, Prop. 4.3 in full), the start of §4.2**; §2.1–2.2, §3 not read.
  - **Theorem 1.8 with `S = ∅` (Remark 1.9):** for a `ℤ^r`-action on `T^d` by toral automorphisms with some irreducible element, `r ≥ 2`
    and some totally irreducible element, the orbit of `y` is dense unless `y = y* + v` with `y*` rational and `v` in the **isometric
    subspace** `{v : C⁻¹|v| ≤ |αⁿv| ≤ C|v|}`. Theorem 1.10 adds that otherwise the (restricted) orbit closure is a finite set of such points.
  - **Prop. 4.3:** a minimal invariant closed set contains a `V_⟨S⟩`-translated torsion point; its three cases (finite orbit ⟹ torsion;
    differences along `V` ⟹ `V`-translated torsion; otherwise `M − M = X`, contradicting **Lemma 4.2**, "no pair of minimal sets with
    `M + M′ = X`", proved with congruence subgroups `G^{(f)}` mod `p^f`). This is J01-2's (PA-B2's) architecture — J01-1's congruence
    subgroups `Σ^{(k)}` mod `q^{k−1}`, J03a-4's joining — in the torus setting.
- **`[EinsiedlerLindenstrauss2022]`** *Rigidity properties for commuting automorphisms on tori and solenoids*, arXiv 2101.11120 (FS-89 read
  its abstract only), held `~/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf`. **Read
  §1 pp. 1–3.** Verbatim, p. 3: "In the totally irreducible case Berend [2] gave an if-and-only-if condition for a `ℤ^d`-action to have the
  property that every orbit is either finite or dense, and the same methods could be pushed further to give a complete classification of
  closed invariant subsets for a totally irreducible `ℤ^d`-action on the solenoid; for `ℤ^d`-action on tori this is due to Z. Wang [36, Thm
  1.10] and his proof certainly works also for solenoids though this does not seem to have been written (a special case, with a very nice
  application, can be found in Manner's paper [32])."
- **`[KravitzLeng2025]`** N. Kravitz, J. Leng, *Quantitative pyjama*, arXiv 2510.17744 (2025), held
  `~/source/library/pdf/KravitzLeng2025-quantitative-pyjama.pdf`. **Read: abstract, §1 pp. 1–3 (Theorem 1.2).** Theorem 1.2 is an
  effective Lemma 5.2 of Manners on the same half ring: every point of `X = Â` either has a `Θ_N`-orbit point in `E₁*(ε)` or lies within
  `δ` of `B^C_{1/2}(r)` for a torsion point `r` of order at most `n_ε = exp exp exp(ε^{−C})`. Method: Bourgain–Lindenstrauss–Michel–Venkatesh
  entropy.
- **Malikiosis–Matolcsi–Ruzsa 2013**, *A note on the pyjama problem*, Eur. J. Combin. (Zbl 1292.52016; arXiv 1211.6138): abstract only —
  "there exist no periodic coverings for `ε < 1/3`", i.e. rational rotations always leave torsion "rational obstructions" (our torsion band
  characters at band `< 1/3`).
- **Muchnik 2005**, *Semigroup actions on `T^n`*, Geom. Dedicata 110, doi 10.1007/s10711-004-4321-7, Zbl 1071.37008: **not reached** (text
  withheld by zbMATH's licence; not on arXiv by author/title query; Springer blocks scripts). Manners names it among "generalizations that
  allow an isometric direction". On Kooshi's list.

### 1.3 The verdict for result 1 — **partly in print**

1. **The band-rigidity conclusion is in print for one ring at `|S| = 2`**: `[Manners2015]` Lemma 5.3 proves, for
   `A = ℤ[i][1/P₅, 1/P₁₃]` under the semigroup `⟨θ₅, θ₁₃⟩₊`, that a closed invariant set whose values at 1 miss any point of `ℝ/ℤ` lies in
   finitely many "torsion point plus archimedean character of norm ≤ 1/2" — the records' `RS_k` shape, at every band and in a stronger
   form (any missed value, finitely many torsion points, bounded archimedean part). Kravitz–Leng 2025 make it effective (torsion orders
   `≤ exp exp exp(ε^{−C})`, against the records' non-effective `N_k`, J03a-6).
2. **What is not in it, as far as read:** (a) the ring the records use, `R_S = ℤ[i][1/p : p ∈ S]` with **both** Gaussian primes above each
   `p` inverted and the **group** `U_S` — `R_S = A + Ā`, and passing from `A` and `Ā` to `R_S` is a gluing of two conjugate halves, which is
   exactly the step J12 shows fails at one prime (ONE-a glues two band pieces into a character outside `T + A`), so it is not formal and not
   claimed here either way; (b) any `S` other than `{5, 13}` (Manners asserts "any pair … would work"); (c) the field clause
   `Θ_k(R_F) ⊆ T_{N_k} + A(R_F)` for every `F ⊆ ℝ` (J03a-8), and the correction `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1` (J03a-9); (d) the parity
   lemma J01-3 and Lemma SW-m (J01-5, J03a-1) as statements.
3. **The general solenoid statement is expert folklore, unwritten**: `[EinsiedlerLindenstrauss2022]` p. 3 says Wang's classification "certainly
   works also for solenoids though this does not seem to have been written". Its `S = ∅` case, transplanted, would give *density* of every
   orbit outside `T + A` — stronger than the records' "values arbitrarily close to 0".
4. **The method is in print** for tori: `[Wang2012]` Prop. 4.3 and Lemma 4.2 (minimal sets contain isometric-translated torsion points;
   congruence subgroups exclude `M + M′ = X`) are J01-2's and J03a-4's architecture; FS-89's close already recorded Berend's method.

**Wording to use:** "Band rigidity at every band for `R_S` is not found in print as stated; the same conclusion is `[Manners2015]` Lemma 5.3
for `ℤ[i][1/P₅, 1/P₁₃]` (one prime above each of 5 and 13, a semigroup), and the solenoid form of `[Wang2012]` Thm 1.10 is stated by
`[EinsiedlerLindenstrauss2022]` as following from Wang's proof but unwritten." **Undecided until read:** Muchnik 2005 (could hold an
isometric-direction solenoid statement; Manners says his lemma does not follow from it).

**What this teaches about our own object** (for the close's §PA sweep): the band condition "every unit vector's value avoids `(−1/k, 1/k)`"
is the pyjama condition — a band character of `R_S` is a point of the dual not covered by the rotated stripes `E*_u`, and **the pyjama
problem's answer (Manners) is the statement that over rational rotations the only uncovered points are near torsion**. MMR 2013's "rational
obstructions" are our torsion band characters; Manners's "irrational trick" (adding three rotations `ζ₁, ζ₂, ζ₃` with `n(ζ₁ + ζ₂) = ζ₃`) is a
chain-theorem-shaped closing move (G55). The one-prime failure (result 6) is Manners's asserted "lacunary" case.

## Stage 6 — SAVED (result 6: one prime; done second, because it leans on stage 1's Manners reading)

**Statements searched** (J12's record, grade per the owner: one derivation, blind check J13 pending): J12-ONEa "`Θ₄(R_{{p}}) ⊄ T + A`
for every prime `p ≡ 1 (mod 4)`"; J12-MS "`MS₄({5})` is false: a `U₅`-minimal closed subset of `Θ₄(R₅)` disjoint from `T + A` exists"
(J12-MSp at every `p ≡ 1 (4)`); J12-C3 "the orders of band torsion characters of `R₅` are unbounded"; J12-B1 "`Θ₄(U₅)` ≅ bi-infinite orbits
in `Q₀ = [−1/4,1/4]²` of the rotation `ω = (−4−3i)/5` about one of nine centres per step" (`plans/FS91-S1D-one-prime.md` lines 339–365).

**Named in the discipline's words:** the one-parameter ("lacunary") case of Furstenberg–Berend on an `S`-adic solenoid with an isometric
archimedean direction; in piecewise-isometry language, a **rotation by a Pythagorean angle (`cos = −4/5`) with a finite set of re-centrings
("round-off")**, whose admissible codings are the band characters (J12-B1, B2: torsion ⟺ periodic coding); the minimal set's coding is a
primitive aperiodic **`S`-adic subshift** (J12-W, J12-Ω). Periodic codings of unbounded period are "infinitely many periodic orbits".

### 6.1 Queries

| database | query | hits | what bears |
|---|---|---|---|
| zbMATH | `ti:"round-off errors and p-adic numbers"` | 1 | **Bosio–Vivaldi, Nonlinearity 13 (2000), Zbl 1009.65077 (author summary, a claim):** a lattice discretisation of a planar rotation with rational trace of prime-power denominator `p^n` embeds in "a smooth expansive dynamical system over the `p`-adic integers, consisting of multiplication by a unit composed with a Bernoulli shift" |
| zbMATH | `au:"Vivaldi, Franco"` (listing) and its titles with rotation / lattice / round-off / `p`-adic | 66; 11 | Vivaldi 2006 *The arithmetic of discretized rotations* (review withheld); Kouptsov–Lowenstein–Vivaldi 2002 *Quadratic rational rotations of the torus and dual lattice maps*; Lowenstein–Vivaldi 1998, 2000, 2010; Vivaldi–Vladimirov 2003 |
| zbMATH | `ti:"discretized rotation"`; `ab:"discretized rotation"` | 2; 5 | **Akiyama–Pethő, *Discretized rotation has infinitely many periodic orbits*, Nonlinearity 2013** (summary: `(x, y) ↦ (y, −⌊x + λy⌋)` has infinitely many periodic orbits for every `λ ∈ (−2, 2)`); Akiyama–Mance 2026; Nouvel–Rémila 2004, 2005; Berthé–Nouvel 2007 (discrete rotations and symbolic dynamics) |
| zbMATH | `ti:"non-ergodic piecewise affine maps of the torus"` | 1 | **Adler–Kitchens–Tresser, ETDS 2001** (summary: a minimal uniquely ergodic invariant set; periodic octagons coded by "an equal length substitution rule or the triadic odometer") |
| zbMATH | `ab:"piecewise rotation" & ab:"rational"`; `au:"Goetz, Arek"` | 2; 18 | Goetz–Poggiaspalla 2004 (rotations by `π/7`); Goetz 1998–2006 (piecewise isometries); off the arithmetic question |
| zbMATH | `ab:"S-adic" & ab:"minimal" & ab:"primitive" & ab:"substitution"` | 3 | Bédaride–Hilion–Lustig 2021; Arbulú–Durand–Espinoza 2024; Durand–Perrin 2022 (the `S`-adic subshift vocabulary; general) |
| zbMATH | `ab:"piecewise isometry" & ab:"periodic" & ab:"aperiodic"` | 1 | Akiyama–Harriss 2013 (pentagonal domain exchange) |
| zbMATH | `ab:"rotation" & ab:"round-off" & ab:"p-adic"` | 1 | Vivaldi–Vladimirov 2003 |
| zbMATH, 0 hits | `ab:"Pythagorean" & ab:"rotation" & ab:"lattice"` (2 conference volumes only); `ab:"pyjama" & ab:"lacunary"`; `ab:"Furstenberg" & ab:"lacunary" & ab:"counterexample"`; `ab:"heteroclinic" & ab:"solenoid"`; `ab:"one-parameter" & ab:"minimal set" & ab:"torus" & ab:"positive dimension"` | 0 | — |
| arXiv | `au:Vivaldi AND ti:rotations` | 4 | 1709.08904 (nonlinear rotations on a lattice), 1208.1132 (discretised rotations), 0909.3458, 2303.17955 |
| arXiv | `abs:"discretized rotation" AND abs:"periodic orbits"` | 1 | 1206.3868 (Akiyama–Pethő) |
| arXiv, 0 hits | `au:Vivaldi AND abs:"p-adic" AND abs:rotation`; `abs:"Pythagorean" AND abs:"rotation" AND abs:"p-adic"`; `abs:"rational rotation" AND abs:"lattice" AND abs:"minimal" AND abs:"odometer"` | 0 | — |

Raw output: `data/fs91/j23p/r6-zb.out`, `r6-rev.out`, `r6-arx.out`.

### 6.2 Read

- `[Manners2015]` §5.5 (read in stage 1), verbatim: "we could not have used a much smaller semigroup. Indeed, the appropriate results are
  false for the smaller set `{θ₅^r : r ≥ 0}`; by analogy with Theorem 4.1, we might say this set is 'lacunary' in some sense." **No proof or
  example is given in §1–§5** (§6–§7 and the appendix, unread, were not searched for one; `grep` of the full text for "lacunary" finds only
  §4 and §5.5).
- `[Berend1984min]` Lemma 3.3 (FS-89's reading): a one-parameter semigroup has minimal sets of positive Hausdorff dimension — without any
  band condition.
- Bosio–Vivaldi 2000, Akiyama–Pethő 2013, Adler–Kitchens–Tresser 2001: **author summaries only** (not readings; G50). Bosio–Vivaldi and
  Adler–Kitchens–Tresser are not on arXiv (on Kooshi's list); Akiyama–Pethő is (1206.3868), not opened (budget).

### 6.3 The verdict for result 6 — **not found as stated; the negative half-statement is asserted in print without proof**

- **ONE-a / J12-MS (a band-1/4 minimal set outside `T + A` at one prime):** not found. **The nearest printed statement is `[Manners2015]`
  §5.5's assertion** that the analogue of his Lemma 5.3 is false for the single-prime semigroup `{θ₅^r}` — asserted, no proof in the part
  read, and about his half ring `ℤ[i][1/P₅]` and a semigroup, not `R_p` and the group `U_p` with the band `1/4`. J12's ONE-a, if J13
  confirms it, is a proof of a form of that assertion. `[Berend1984min]` Lemma 3.3 is the band-free fact.
- **J12-C3 (unbounded torsion orders):** not found for band characters. Analogue in print: Akiyama–Pethő 2013 (infinitely many periodic
  orbits of an integer-rounded rotation) — a different, deterministic system; J12-B2 makes torsion band characters the periodic codings of a
  multi-valued re-centred rotation, so "unbounded orders" is "periodic codings of unbounded period" there.
- **J12-B1/H/W/Ω (the coding and its `S`-adic hierarchy):** the discipline exists — Pythagorean-trace discretised rotations with a `p`-adic
  embedding (Bosio–Vivaldi 2000, Vivaldi 2006) and substitution/odometer codings of piecewise affine torus maps (Adler–Kitchens–Tresser
  2001) — **undecided until Bosio–Vivaldi 2000 and Vivaldi 2006 are read**: they are the likeliest place for a coding of rational-cosine
  rotations by `p`-adic dynamics of the J12-B1 kind.

**Wording to use:** "not found in print as stated; `[Manners2015]` §5.5 asserts without proof that the two-prime rigidity fails for one
prime; the discretised-rotation literature (Bosio–Vivaldi 2000; Akiyama–Pethő 2013) holds analogues, unread beyond summaries."
**`CLOSED-QUESTIONS.md` candidate:** none as a posed question — Manners's sentence is an assertion, not a question; but if J13 confirms ONE-a,
the record can say it supplies a proof of the one-prime failure Manners asserts (in the band form on `R_p`).

## Stage 2 — SAVED (result 2: the class theorem CLG, and the opening gate's unanswered queries)

**Statement searched** (J07-7, verbatim at `plans/FS91-S1D-character.md` line 179): "Let `k ≥ 3` satisfy `H_k`, and let `F` be a real number
field. Then `Θ_k(R_F) ≠ ∅` if and only if some stable place `𝔓` of `F(i)` and some level `m ≥ 1` have a band `k`-character of `T_{𝔓,m}`.
Hence `χ_char(F²) = min_{𝔓,m} χ_char(T_{𝔓,m})` …"; with its inputs CLG-a (pullback), CLG-b/b_n (the peeling lemma), CLG-c (weak
approximation on the norm-one torus), CLG-d.

**Named in the disciplines' words:** `χ_char` is the **regular chromatic number** of the graph — the name `[BarajasSerra2008]` gives, for
circulant and distance graphs, to "`min{k : ∃λ ∈ ℤ_N such that |λd|_N ≥ N/k for each d ∈ D}`" (verbatim, arXiv 0710.4495 §1): the least `k`
admitting a colouring by a character, i.e. our band characters in rank 1 and on cyclic groups. CLG is a **local–global principle for the
regular (character) chromatic number of the unit-distance Cayley graph of a number field**, whose local objects are the norm-one circles
`T(F_𝔭)` and whose gluing is weak approximation on the norm-one torus plus a sumset lemma on the circle group.

### 2.1 Queries (zbMATH unless marked; raw `data/fs91/j23p/r27-*.out`, `r5-oa.out`)

| query | hits | what bears |
|---|---|---|
| the opening gate's eight unanswered queries, re-run: `ab:"circular chromatic number" & ab:"Cayley graph"`; `… & ab:"abelian group"`; `ab:"finite Euclidean" & ab:"chromatic number"`; `ab:"quadratic residue" & ab:"polynomial" & ab:"interval"`; `ab:"view obstruction" & ab:"chromatic"`; `ab:"multiplicative subgroup" & ab:"interval" & ab:"finite field" & ab:"avoid"`; `ab:"lonely runner" & ab:"chromatic number" & ab:"Cayley"`; `ab:"unit distance graph" & ab:"field" & ab:"chromatic number" & py:2000-2026` | 0; 0; 1; 3; 0; 0; 1; 1 | all answered this time (no 502). Krebs 2023 (held `[Krebs2022]`); Watson 1962, Mazur 1969 (residues of polynomials); the EuroComb'07 volume (Barajas–Serra); `[BardestaniMallahiKarai2017]` (held). **The eight debts are discharged** |
| word-form re-asks: `ab:circular & ab:chromatic & ab:Cayley & ab:abelian`; `ti:circular & ti:chromatic & ti:circulant`; `ab:circular & ab:chromatic & ab:"distance graphs" & ab:"lonely runner"`; `ti:"chromatic number of circulant graphs"` | 2; 1; 3; 2 | García-Marco–Knauer–Menara 2026 (semiminimal Cayley graphs, `χ_c ≤ 4`); Liu–Zhu 2003, 2005; **Barajas–Serra 2007, 2008, 2009** |
| `ab:"regular chromatic number"`; `ti:"regular chromatic number"`; `ab:"regular coloring" & ab:"distance graph"`; `au:"Serra, Oriol" & ab:"chromatic"` | 4; 1; 1; 13 | **the vocabulary: Barajas–Serra's "regular chromatic number"** (EuroComb'07; EJC 2008; Discrete Math. 2009, text withheld); Zhu 1998 JCTB *Pattern periodic coloring of distance graphs* (review); Montejano–Serra (rainbow-free 3-colourings of abelian groups; off) |
| `ab:"Hasse principle" & ab:"graph" & ab:"coloring"`; `ab:"local-global" & ab:"coloring" & ab:"Cayley"`; `ab:"chromatic number" & ab:"number field" & ab:"plane"`; `ab:"lonely runner" & ab:"Cayley graph"`; `ab:"circular chromatic number" & ab:"distance graph" & ab:"character"`; `ab:"homomorphism" & ab:"circle" & ab:"Cayley graph" & ab:"abelian" & ab:"chromatic"`; `ab:"unit-distance" & ab:"rational points" & ab:"circular"`; `ti:circular & ti:chromatic & ti:Cayley`; `ab:circular & ab:colouring & ab:"unit distance"` | 0 each | — |
| `ab:"weak approximation" & ab:"norm one torus"` | 6 | Koymans–Rome 2024 (Compositio, *Weak approximation on the norm one torus*, review); Colliot-Thélène–Harari–Skorobogatov 2003; Frei–Loughran–Newton 2018: CLG-c's input is standard (for a quadratic `L/F` the norm-one torus is rational, so weak approximation holds) |
| arXiv: `abs:"regular chromatic number"`; `abs:"lonely runner" AND abs:"Cayley graph"`; `abs:"lonely runner" AND abs:"circular chromatic"`; `abs:"circular chromatic number" AND abs:"abelian" AND abs:"Cayley"`; `abs:"chromatic number" AND abs:"unit circle" AND abs:"finite field"`; `abs:"unit distance" AND abs:"number field" AND abs:"chromatic"` | 1; 0; 0; 1; 0; 0 | 0710.4495 (Barajas–Serra); 2607.26942 (García-Marco et al.) |
| OpenAlex t&a: `regular chromatic number lonely runner`; `circular chromatic number Cayley graph abelian group character`; `unit distance graph number field chromatic number` | 4; 0; 8 | Barajas's thesis *Coloring problems in Cayley graphs* (UPC 2007; abstract read: cyclic groups, the "Prime Filtering Lemma"); `[Fischer1990]`, `[BardestaniMallahiKarai2017]`, `[Krebs2022]`; the rest off (two 2026 "resolutions" of Hadwiger–Nelson via octonions, not opened) |

### 2.2 Read

- **`[BarajasSerra2008]`** J. Barajas, O. Serra, *The lonely runner with seven runners*, Electron. J. Combin. 15 (2008) R48, Zbl 1206.11030;
  arXiv 0710.4495, held `~/source/library/pdf/BarajasSerra2008-lonely-runner-seven-runners.pdf`. **Read: abstract and §1 (the definition of
  the regular chromatic number and its motivation)**; the rest not read.
- Barajas 2007 thesis: abstract only (OpenAlex). Barajas–Serra 2009 (circulant graphs): text withheld; not held.

### 2.3 The verdict for result 2 — **not found by these searches**

No work found states a local–global principle for character (regular) colourings of a field's plane, or of any Cayley graph of a
non-finitely-generated abelian group, or computes `χ_char` of a number-field plane. **The concept is in print in rank 1**: Barajas–Serra's
regular chromatic number is `χ_char` of a circulant or distance graph, and the lonely-runner literature (Wills, Cusick, Chen; Liu's 2008
survey, `[Liu2008]`) is its `κ`; Kang–Maharaj 2010 (the opening gate) is the one-place colouring of distance graphs. CLG-c's weak approximation
is standard (Koymans–Rome 2024 for the general norm-one torus). **The peeling lemma CLG-b** (a sumset of symmetric sets inside a band has a
summand inside the band) was not found as stated; it is two lines, and folklore-grade is the honest grade. **Undecided:** `[Johnson2000]`
and `[Johnson2006]` (the status report and compendium of the question's lineage), unread.

**Wording to use:** "CLG not found in print; the character chromatic number is Barajas–Serra's regular chromatic number, extended from cyclic
groups to the unit-distance graph of a number field."
