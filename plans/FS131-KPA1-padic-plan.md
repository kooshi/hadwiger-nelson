# FS131-KPA1 — the p-adic plane at the kernel: the map, the skeleton and the price

*de Bruijn, the kernel lane's planner. Brief `data/fs131/briefs/FS131-KPA1-padic.md` (on `main` at `9a545b3c4`; a copy is
`data/fs131/kpa1/brief-copy.md`). Branch `fs131-kpa1`, worktree `.claude/worktrees/il5`, cut from `main` at `99e78e428`. No
fence: nothing in this milestone is blind. Started 2026-10-16.*

## Theorems this phase proved

None: a planning job. The skeleton's leaves are `sorry` (stage 3 lists every one); nothing with a `sorry` leaves this branch.

## Stage 1 — SAVED: the readback

### 1.1 The quotations

Six quotations in the brief, each checked mechanically against its named source with line breaks folded
(`tools/fs131_kpa1_quotes.py data/fs131/kpa1/brief-copy.md`, output `data/fs131/kpa1/quotes.out`): **all six verbatim**
(W2 in `data/fs131/REQUEST-2026-10-13.md` l. 4; the default order in `plans/POROS-2026-10-13-number-field-findings.md`
§ 3.5 l. 484; the declined line in `plans/FS66-derivation.md` l. 444; the theorem and the first objection in POROS § 3.3,
rank 4, ll. 392–403; row 75 in `LEDGER.md` l. 119, 4,470 characters, identical on `main`). The tool's planted control
(one character of the first quotation changed) is refused, exit 1 (`data/fs131/kpa1/quotes-plant.out`).

### 1.2 The result, in my words

The graph: vertices `ℚ_p × ℚ_p`, `x ~ y` iff `(x₁ − y₁)² + (x₂ − y₂)² = 1` — `[BardestaniMallahiKarai2017]`'s quadratic graph
`QG_{𝒬_p}`, `𝒬_p = (ℚ_p², x₁² + x₂²)` (Definition 2.6, p. 6; §1 p. 2), and the library's own `unitQuadrance ℚ_[p]`
(`UnitQuadrance.lean`: `addCayley {v | v.1² + v.2² = 1}` over any commutative ring). Its Borel chromatic number is the least
`k` such that the plane is partitioned into `k` Borel sets none holding an edge (the paper's §1, p. 1: "the least cardinal `c`
such that the set `V(𝒢)` can be partitioned into `c` Borel subsets none of which contains two adjacent vertices").

1. **The bound.** For every prime `p ≡ 3 (mod 4)`, `χ_Bor(QG_{𝒬_p}) ≥ 1 + (p + 1)/(2√p)`. Since the right side exceeds
   `√p/2`, no constant bounds `χ_Bor` over those primes: the posers' Question 1 (p. 2, read first-hand here) is answered **no**.
2. **The values.** `χ_Bor = 4` at `p = 7`; `5` at `11` and at `19`; `6 ≤ χ_Bor ≤ 8` at `23`.
3. **Not claimed.** The plain chromatic number `χ(ℚ_p²)` (no colouring is asked to be Borel there, and nothing here bounds it
   from below); seven or six colours at 23 in either direction beyond `[6, 8]`.

The one new step, which the posers' objection asks the statement to show, is a bound on **every level of the residue tower at
once**: every independent set of `UD(ℤ/p^k, 2)` holds at most a fraction `c` of its `p^{2k}` points, with `c` independent of `k`
— `c = 2√p/(p + 1 + 2√p)` for the bound (Weil at level one, the fibre argument above it), `c = U/p²` for a value (an
accepted certificate's `U`). A measurable independent set of `ℤ_p²` inherits the fraction (its well-filled cosets are an
independent set of a level), so a Borel colouring needs at least `1/c` colours.

### 1.3 What it rests on, and what the library holds

**Printed theorems the derivation reads.**

| theorem | where the derivation uses it | in this library |
|---|---|---|
| `[BardestaniMallahiKarai2017]` Thm 2.5 (credited there to Bachoc–DeCorte–de Oliveira Filho–Vallentin), p. 5: `1 − sup μ̂ / inf μ̂ ≤ χ_Bor(Cay(Fⁿ, 𝒮))` for `𝒮` bounded, symmetric, Borel, `0 ∉ 𝒮̄`, `μ` symmetric finite Borel on `𝒮` | FS66-T7's proof, with `μ` the Haar probability of the circle `S ⊂ ℤ_p²` | nothing. **The route planned below does not read it** (§ 2.2): the finite ratio bound at every level and one measure step replace it |
| Weil's bound for Kloosterman sums, `[Weil1948]` p. 207 | level one: `λ_min(Γ_p) ≥ −2√p` | the declared import `StandingFive.kloosterman_bound` (`Arith/WeilKloosterman`), read through `StandingFive.normOne_charSum_ge` into `Rigidity/ClassRatio`'s private `charBound_one_weil` — **in the declared form, no new reading** |
| `[Madore2015]` Prop. 3.2 with Rem. 3.6 (pp. 6–7, read here): for a valuation ring with anisotropic residue form, `χ(K^d) = χ(A^d) ≤ χ(κ^d)`, by a homomorphism `x ↦ x − ξ_C` on each coset `C` of `A^d` | the upper half `χ_Bor(ℚ_p²) ≤ χ(Γ_p)` | nothing for `ℚ_p`; `ResidueTower.lean` holds the finite tower's monotonicity (Prop. 3.8's second inequality) |
| `[Moorhouse2010]` Table 6.1 | the level-one values `χ(Γ_7) = 4`, `χ(Γ_11) = χ(Γ_19) = 5`, `χ(Γ_23) ≤ 8` | each in the kernel: `finitePlane7_colorable_four` (`Instances/PlaneFreedom`), `chromaticNumber_finitePlane11` (`Instances/FinitePlane11`), `finitePlane19_colorable_five` (`Instances/LocalGlobal19`), `CayleyCert.colorable_finitePlane23_eight` (`CayleyCertificate`), all on the standard three |

**The certificates.** FS-66's `data/fs66/b1/cert-p{7,11,19,23}.json` (format `fs66-b1-cert-v2`, `CERTIFIED` by the frozen
checker `tools/fs66_b1_cert_check.py`), and the Searcher's reduced `data/search/2026-10-14/certs/v-p19-phi0-13-qs.json`.

| p | FS-66 file | blocks / rows / bytes | `U` | needed below | in the kernel |
|---|---|---|---|---|---|
| 3 | `proto-cert-p3.json` | 6 / 27 / 4.4 KB | 3.0001 | `< 9/2` | **yes**, `FibreCert.cert3_ok` (`Arith/FibreCert3`, under a second) |
| 7 | `cert-p7.json` | 14 / 524 / 97 KB | 14.015225 | `< 49/3 = 16.33` | **no** |
| 11 | `cert-p11.json` | 22 / 3,821 / 707 KB | 28.204320 | `< 121/4 = 30.25` | **yes**, `cert11_ok`, `FibreCertSound.sum_le_eleven` (`Arith/FibreCert11Bound`) |
| 19 | `cert-p19.json` | 10.4 MB | 77.511742 | `< 361/4 = 90.25` | **no**; the kernel holds the Searcher's reduced certificate instead, `U = 88.6434…` (`cert19_ok`, `sum_le_nineteen`, `Arith/FibreCert19Bound`) |
| 23 | `cert-p23.json` | 46 / 138,706 / 26.3 MB | 97.984637 | `< 529/5 = 105.8` | **no** |

**The hand links** (`plans/FS66-derivation.md`; `data/fs66/b1/SOUNDNESS.md` §§ 1–6, 8):

| link | content | in this library |
|---|---|---|
| L1 | characters of `G_k` new above level one sum to at most `2p^{k−1}` over `S_k` | at every odd stable prime of a real number field: `Rigidity.newCharBound_of_two_notMem` (public; Lemma P, `Rigidity/ClassRatio`) — not for `ZMod (p^k)` directly |
| L2 | the fibre-share inequality `q(φ) ≥ 0` | in the abstract, `FibreShare.fibreShare_le` (`Arith/FibreShareIneq`); at stable primes, inside `CertLink.card_le_of_fibreShareBound` |
| L3–L5 | the certificate's identity, positive definiteness, the bound on the region | `FibreCertSound.sum_le_of_certOK` (`Arith/FibreCertSound`), no `sorry`, standard three |
| L6 | from the region bound to every level's independence number | `CertLink.card_le_of_fibreShareBound` (at stable primes) |
| T7 (Weil branch at every level) | `|I|/|G_k| ≤ 2√p/(p + 1 + 2√p)` | at every odd stable prime: `Rigidity/ClassRatio`'s **private** `ratioAtMost_weil` |
| T8 (clopen = tower limit; Haar supremum = tower limit) | the measure step | nothing for `ℤ_p`; the closest analogue is `Rigidity/CountCompletion`'s density along cosets (`tendsto_haarK_bad`, regularity of Haar, no martingale) |

The axiom audit of `main` (`build/gate/axioms/20261016T035140Z-2739309.log`) prints `card_le_of_fibreShareBound`,
`henselCount_of_two_notMem`, `newCharBound_of_two_notMem`, `sum_le_eleven`, `sum_le_nineteen` and the four colourings on the
standard three, `cert3_ok` on `propext` alone.

### 1.4 Mismatches and findings

1. **None in the quotations.**
2. **The ledger's `U` at 19 is not the kernel's.** Row 75's `U = 77.511742` (19) is FS-66's `cert-p19.json`; the kernel holds
   the Searcher's reduced certificate, `U = 88.6434…`. Both are below `361/4`, so `χ_Bor(ℚ₁₉²) ≥ 5` reaches the kernel either
   way; but row 75's `α(Γ₁₉) ∈ {76, 77}` and its Haar bracket at 19 (`≤ 0.214714`) rest on the 77.51 file, which is not in the
   kernel — with the kernel's `U` they read `α(Γ₁₉) ≤ 88` and `≤ 0.2455`. Those two clauses stay `[cert]` until
   `cert-p19.json` is checked in the kernel. Nothing is wrong; the landing's ledger line must say which certificate it read.
3. **The route needs no Theorem 2.5.** POROS § 3.3 says the bound is "conditional on two printed theorems: the measurable
   ratio bound as the posers' own Theorem 2.5 states it, and Weil's bound". Planned from the statement, the bound needs only
   Weil: Hoffman's ratio bound at each finite level `UD(ℤ/p^k, 2)` (the library's `RatioBound.card_mul_le_of_indep`, already
   composed with Weil and L1 at every level as `ratioAtMost_weil`), and one measure step — **the cosets of `p^kℤ_p²` that a
   measurable independent set fills to more than half form an independent set of level `k`, and by the regularity of Haar
   measure those cosets carry all of its measure as `k → ∞`** (FS66-T8's measure half). So the bound rests on one declared
   outside theorem, not two, and Theorem 2.5 (an operator-theoretic statement on `L²(ℚ_p²)` with Fourier analysis over
   `ℚ_p`, which Mathlib does not hold) need not be imported. A second route; filed as a finding (`generalization`, § 2.4).
4. **Two simplifications of FS66-T8's measure half.** Two adjacent well-filled cosets give an edge inside the set by **one**
   lift of the connecting unit vector (`C' = C + s`, and two subsets of `C` of measure above `μ(C)/2` meet) — no Fubini over
   the lifts; and "their share tends to `I`'s measure" needs no Lebesgue density theorem: a compact set inside `I` and an open
   set outside, finitely many cosets between (Haar on a compact metrizable group is regular), as `Rigidity/CountCompletion`
   did for its profinite group.
5. **The citation of `[Madore2015]` for the chain.** FS66-T8 flagged "a discrepancy between the two sources not resolved by
   this audit" (Prop. 3.2 in `plans/FS66-residue-tower-drop.md` § S2, Prop. 3.8 in row 75). Read here (`~/source/library/pdf/
   arXiv-1509.07023-madore-hadwiger-nelson-over-fields.pdf`, pp. 6–8, ¶1.5, ¶6.6): **Prop. 3.2** (anisotropic residue form)
   gives `χ(K^d) = χ(A^d) ≤ χ(κ^d)`, and Rem. 3.6 states its instance `χ((ℚ_p)²) ≤ χ((𝔽_p)²)` for `p ≡ 3 (mod 4)`; **Prop. 3.8**
   is the variant under a hypothesis modulo `m²` (written for `p = 2`), `χ(K^d) = χ(A^d) ≤ χ((A/m²)^d) ≤ χ((A/m)^d)`. Neither
   states the tower's limit. So the chain `χ(F²) ≤ χ(ℚ_p²) = χ(ℤ_p²) ≤ lim_k χ(G_k) ≤ χ(G₁)` at `p ≡ 3 (mod 4)` is Prop. 3.2
   (first equality and the outer inequality) with the trivial monotonicity of the tower; Prop. 3.8's second inequality is
   `ResidueTower`'s kernel statement, correctly cited there. **Correction owed** (wording only): row 75's "Prior art" clause and
   `CLOSED-QUESTIONS.md` § 1.8's first paragraph cite Prop. 3.8 for the whole chain; drafted in § 5.
6. **The upper half is Borel by Madore's construction.** `x ↦ x − ξ_C` is locally constant on `ℚ_p²` (each coset of `ℤ_p²` is
   open), so the residue colouring pulled back through it has clopen classes: `χ_Bor(ℚ_p²) ≤ χ(Γ_p)`. The posers prove only
   `O(p²)` (their Lemma 3.3, box colourings). The construction is Madore's; that it gives a Borel colouring is one line on it.
   SOUNDNESS § 8 says the same ("a colouring of level one, pulled back, is clopen, hence Borel, and extends over the countably
   many cosets"); POROS says "the upper halves prior art". Wording for novelty, unchanged: the upper half is prior art in
   construction.
7. **`p = 3` is a free value.** The bound at `p = 3` is `1 + 4/(2√3) = 2.15…`, so `χ_Bor(ℚ₃²) ≥ 3`, and `χ(Γ₃) = 3`
   (`finitePlane3_colorable_three`): `χ_Bor(ℚ₃²) = 3` falls out of the bound itself, with no certificate. SOUNDNESS § 8 names
   it ("and `= 3` at `p = 3`"); row 75 does not.

## Stage 2 — SAVED: the map

### 2.1 The coordinator's ruling (inventory item 997, 2026-10-16)

(1) Plan the Weil-only route. (2) Make the `κ_p` constant the head statement if it costs little, with T7's `2√p` form as a
corollary. (3) Record the wider class of local fields as a reading for a stub of its own. (4) Draft row 75's grade note
here. **Channel:** making `ratioAtMost_weil` and `charBound_of_charBound_oneT` public is an edit to `Rigidity/ClassRatio.lean`,
which the collapse implementer's branch (`fs131-ico1`) also edits. So the edit is drafted (§ 5), not made here, and what this
module needs from those theorems is stated as its own `sorry` leaf (`PadicPlane.ratioAtMost_of_charSum_levelOne`). Read on
that branch (`.claude/worktrees/kcl1/Proofs/HadwigerNelson/Rigidity/ClassRatio.lean`, l. 2071): its new public
`Rigidity.norm_charSum_le_weil` bounds every non-trivial character of `𝓞 ⧸ P^m`, `m ≥ 1`, over the norm-one set by
`2√Q/(Q + 1)` of its size, **in modulus**. It gives T7's tower ratio directly — at each level, with
`RatioBound.card_mul_le_of_indep` and `Re ≥ −‖·‖` — but not the `κ` form: the `κ` form's level-one hypothesis is one-sided
(Hoffman reads only `λ_min`; at 11 `λ_max = 5.72` beats `|λ_min| = 4.80`), and that theorem's private engine
`norm_charSum_le_of_one` is two-sided. So the leaf keeps its own route (§ 2.3, T0).

### 2.2 The route, step by step

FS66-T7, rebuilt for the kernel (the Weil-only route; `[BardestaniMallahiKarai2017]` Thm 2.5 is not read):

1. **Level one** (Weil). Every non-trivial character `ψ` of `(ℤ/p)²` has `Re Σ_{a²+b²=1} ψ(a, b) ≥ −2√p`.
2. **Every level** (Lemma P, FS-66's L1, Hoffman). If level one has `Re Σ ≥ −κ`, `κ ≥ 2`, then every independent set of
   `UD(ℤ/p^k, 2)`, `k ≥ 1`, holds at most `κ/(p + 1 + κ)` of the `p^{2k}` points (`TowerRatio p (κ/(p+1+κ))`).
3. **The tower is the stable prime's.** At `p ≡ 3 (mod 4)`, the prime of `ℚ(i)` above `p` is a stable prime `P` with `p²`
   residues, and `UD(ℤ/p^k, 2)` embeds in `levelTarget P k` as an induced subgraph on all its points; so step 2 is the
   library's Lemma P at `P`, read through the embedding.
4. **Measure** (FS66-T8's lower half). For `I ⊆ ℤ_p²` Borel and independent, the level-`k` cosets that `I` fills to more
   than half are independent at level `k`, and the rest of `I` has measure tending to `0`; so `haar I ≤ c` for every tower
   ratio `c`.
5. **Borel colourings.** A Borel `k`-colouring of `ℚ_p²` meets `ℤ_p²` in `k` Borel independent sets covering measure `1`:
   `1 ≤ k·c`, so `χ_Bor(ℚ_p²) ≥ ⌈1/c⌉ = ⌈1 + (p + 1)/κ⌉`. At `κ = 2√p`: T7.
6. **Unboundedness.** `1 + (p + 1)/(2√p) > √p/2`; Dirichlet's theorem (Mathlib, `Nat.forall_exists_prime_gt_and_eq_mod`)
   gives primes `p ≡ 3 (mod 4)` beyond any bound.

The values (FS-66's L2–L6 with the certificates, and T8's upper half):

7. **Certificates.** `FibreShareBound p U` (`Σφ ≤ U` on FS-66's region) gives `TowerRatio p (U/p²)` through FS-66's L2 and
   L6 at the stable prime (`CertLink.card_le_of_fibreShareBound`) and step 3; then step 5 gives `χ_Bor ≥ ⌈p²/U⌉`.
8. **Upper half** (`[Madore2015]` Prop. 3.2, Borel). `x ↦` (the residue modulo `p` of `x` minus its coset's representative)
   carries edges of `ℚ_p²` to edges of `UD(𝔽_p, 2)` and is locally constant: `χ_Bor(ℚ_p²) ≤ χ(UD(𝔽_p, 2))`.

### 2.3 Each step against this library, Mathlib at `v4.32.0` and the release under `~/source/math`

The release (`~/source/math/lean`, `[OAIMath2026]`): 72 files name `Padic`, `ℤ_[` or `ℚ_[` (searched by name; listing
`data/fs131/kpa1/release-padic-files.txt`). None states a chromatic number, a colouring or a unit-distance graph over `ℚ_p`
(the one file under `Geometry/UnitDistances` uses `PadicAlgCl` for absolute values of a number field). Two hold patterns
this route uses, neither worth a port: `OAI/NumberTheory/PrimePackets/HaarBounds.lean` l. 18, `haar_kernel_eq_inv_card`
(an invariant probability gives the kernel of a hom with finite range the measure `1/|range|`, ten lines over Mathlib's
`AddSubgroup.index_mul_measure`), which makes M4 short; and `OAI/Analysis/BackwardIntertwiners/HaarBase.lean` l. 13–21,
the Borel instance and `Measure.addHaarMeasure ⊤` on `PadicInt 2` with `Regular` by `inferInstanceAs` — the set-up the
skeleton's `PadicPlane/Measure` makes on `ℤ_p²`. Every Mathlib name below was
confirmed in the source at the pin (`.lake/packages/mathlib`), and the skeleton elaborates against them.

| step | held | missing, as a leaf (stage 3 names it) | price (lines) |
|---|---|---|---|
| 1 | `StandingFive.normOne_charSum_ge` (`Arith/FloorPlanes`, public; over a field with `Q²` elements, the norm-one set `{u^{Q+1} = 1}`, on the declared import through `kloostermanBound_of_ringChar_ne_two`); `CertLink.exists_addEquiv_zmod` (K3, public: `𝓞 ⧸ P ≃+ (ℤ/q)²`, norm-one onto the circle); `StandingFive.involution_eq_pow`, `card_fixed_of_involution` | T5 `charSum_unitCircle_ge_weil` (the residue field of `P` as a field, the norm-one set as `{u^{p+1} = 1}` as in `ClassRatio.charBound_one_weil`'s preamble, carried to `(ℤ/p)²` by K3) | 70 |
| 2 | at stable primes: `Rigidity.henselCount_of_two_notMem`, `newCharBound_of_two_notMem` (public: Hensel's count and FS-66's L1), `FibreShare.exists_eq_compAddMonoidHom` (descent), `RatioBound.card_mul_le_of_indep` (Hoffman, any finite abelian group); the composition itself is `ClassRatio`'s **private** `charBound_of_charBound_oneT` + `ratioAtMost_of_charBound` | T0 `ratioAtMost_of_charSum_levelOne` (route A: from the public pieces, the level plumbing of `CertLink.card_le_of_fibreShareBound`'s proof; route B: one line from the two private theorems once the drafted visibility edit lands after the collapse merges); T4 `charSum_levelOne_of_unitCircle` (K3 transport) | A 150 / B 20; T4 40 |
| 3 | `UpperHalf.instNumberFieldBot`, `UpperHalf.exists_stablePrime_rat` (the prime above 2: the pattern for "p is not a unit"), `UpperHalf.exists_I_integer`, `Ideal.absNorm_span_natCast` (`= n ^ finrank ℤ 𝓞`), `NumberField.RingOfIntegers.rank`, `Ideal.absNorm_dvd_absNorm_of_le`, `cardQuot_pow_of_prime`, `FiniteField.isSquare_neg_one_iff`, `ZMod.castHom_injective` | T1 `exists_stablePrime_above` (needs `finrank ℚ (fieldI ⊥) = 2`, from `SpectralChain.toFieldI` on `⊥ × ⊥`); T2 `exists_levelEmbedding` (`CharP (𝓞 ⧸ P^k) (p^k)` from `p^{k−1} ∉ P^k` by the norm); T3 `towerRatio_of_ratioAtMost` | 120; 100; 40 |
| 4 | Mathlib: `PadicInt.toZModPow`, `PadicInt.ker_toZModPow`, `PadicInt.appr_spec`, `hensels_lemma` (`Mathlib/NumberTheory/Padics/Hensel.lean` l. 459), `PadicInt.compactSpace`, `Measure.addHaarMeasure` with `⊤ : PositiveCompacts` (Haar on `ℤ_p²` elaborates: second countable, Borel product, compact group), `MeasurableSet.exists_isCompact_sdiff_lt`, `exists_isOpen_sdiff_lt`, `nonempty_inter_of_measure_lt_add`; this library: `Rigidity/CountCompletion`'s `haarK_bad_le` and `tendsto_haarK_bad_of_le_one`, the pattern for density along cosets | M1–M8 (`res_surjective`, `isOpen_res_fibre`, `haar_univ`, `haar_res_fibre`, `exists_unitVector_lift`, `isIndepSet_wellFilled`, `exists_level_haar_bad_le`, `haar_le_of_towerRatio`); M4 by `AddSubgroup.index_mul_measure` and `AddSubgroup.index_ker` | 8 + 30 + 5 + 25 + 80 + 60 + 120 + 60 |
| 5 | `borelChromaticNumber` and its faces (skeleton, proved) | M9 `one_le_mul_of_borelColoring`, M10 `le_borelChromaticNumber_of_towerRatio`; V1, V2 | 50 + 15 + 20 + 5 |
| 6 | Mathlib's Dirichlet, `Nat.forall_exists_prime_gt_and_eq_mod` (`Mathlib/NumberTheory/LSeries/PrimesInAP.lean` l. 484) | V3 `not_exists_uniform_bound` | 50 |
| 7 | `CertLink.card_le_of_fibreShareBound`, `fibreShareBound_eleven`, `exists_fibreShareBound_nineteen` (standard three); the checker `Arith/FibreCert`, its soundness `FibreCertSound.sum_le_of_certOK`; the generator `tools/fs131_ikc1_gen.py` and the split tooling `tools/fs131_ikc4_*` | T6 `towerRatio_of_fibreShareBound`; C7 `fibreShareBound_seven`; C23 `fibreShareBound_twentyThree`; the level clauses (row 75's) and the values | 20; C7 60 + generated; C23 § 2.5; 30; 75 |
| 8 | `unitQuadrance.map`; the colourings `finitePlane3_colorable_three`, `finitePlane7_colorable_four`, `finitePlane11_colorable_five`, `finitePlane19_colorable_five`, `CayleyCert.colorable_finitePlane23_eight` | B3 `norm_le_one_of_sq_add_sq_eq_one`; U1 `exists_residueMap`; U2, U3 | 50; 90; 25 + 15 |

**The hand links L1–L6 against the route.** L1 (new characters) and the Hensel count are Lemma P's two public theorems at
the stable prime; L2 and L6 are `CertLink.card_le_of_fibreShareBound`; L3–L5 are `FibreCertSound.sum_le_of_certOK`. Nothing
of L1–L6 is re-derived. **T8** is needed only in its two halves: the lower (step 4, new here) and the upper (step 8, new
here); its equality `χ_clopen(ℤ_p²) = lim_k χ(G_k)` and the Haar supremum's equality are not read by any value.

### 2.4 The printed theorems: formalize or declare

- **`[BardestaniMallahiKarai2017]` Theorem 2.5**: **not read** by the route, so neither formalized nor declared. Were it
  wanted for itself it is far over an hour: it needs `L²(ℚ_pⁿ)`, the Fourier transform over `ℚ_p` (Tate's character), and
  Plancherel, none of which Mathlib holds at the pin (`Mathlib/NumberTheory/Padics/AddChar.lean` treats characters of
  `ℤ_p` only). Not priced further.
- **Weil's bound** (`[Weil1948]` p. 207): already declared, `StandingFive.kloosterman_bound`, with its four items in place;
  T5 reads it through `StandingFive.normOne_charSum_ge` exactly as `ClassRatio.charBound_one_weil` does. **No new import.**
  Landing it on the standard three is a separate question already owed for the whole library (the Kloosterman bound; for the
  circle of `𝔽_p²` the sum is a Salié-type sum with an explicit elementary evaluation, which would be a smaller target than
  Weil's general bound — a reading, not checked here).
- **`[Madore2015]` Prop. 3.2**: formalized here (U1, about 90 lines, well under an hour). **`[Moorhouse2010]` Table 6.1**:
  every value read is already a kernel colouring. **Dirichlet**: in Mathlib.

### 2.5 The certificates: sizes, route and a measured cost

The route is the library's: the kernel checker `Arith/FibreCert` (`decide +kernel`, no `native_decide`, core-only data
modules), its soundness `FibreCertSound.sum_le_of_certOK`, data generated by `tools/fs131_ikc1_gen.py` (untrusted; its Python
model runs first), split into segments and PSD blocks by `tools/fs131_ikc4_gen.py`/`fs131_ikc4_checks.py` when one
declaration would not fit.

**Measured at `p = 7`** (`data/fs131/kpa1/cert7/`): FS-66's `cert-p7.json` (sha256 `f4b2ffa7c427…`) generates 8,598 ops,
495 slots, 69 orbits, 14 diagonally dominant PSD blocks, a 707 KB Lean file; the model's identity holds. Checked by the
kernel as three `decide +kernel` theorems in one file (`globalOK`, the one identity segment, `psdAll`): **48.8 s wall,
2.89 GB peak resident** (type checking 7.1 s, 29.4 s, 7.5 s; `data/fs131/kpa1/cert7/check.log`), under the laptop's slot at
8 GiB. So leaf C7 is one generated data module `Arith/FibreCert7`, one check module `Arith/FibreCert7Check` (the three
theorems, measured), and `Arith/FibreCert7Bound` (`cert7_ok`, `sum_le_seven`, `model_seven`), about 60 hand-written lines,
built at `BATCH=2` under `MEMMAX=6G`.

**At `p = 23`**: FS-66's `cert-p23.json` (26.3 MB, 46 blocks, 138,706 rows) generates **1,444,136 ops** over 35,511 pairs
and 1,697 orbits (the generator's model, `data/fs131/kpa1/cert23/model.log`) — 168 times the ops at 7 and 27 times those at
11. At the 7's rate (about 3.4 ms of segment checking per op) that is about 80 minutes of segment checking split over at
least 150 segments of the memory the 7's one needed, plus a phase 1 seventeen times the 19's. It is a job of the IKC3–IKC4
kind, larger than both. **The cheaper route is a reduced certificate**, as at 19, where the Searcher's variant
(`v-p19-phi0-13-qs.json`, 1.5 MB, 1,885 rows, `U = 88.64`) replaced FS-66's 10.4 MB file for the kernel. At 23 the margin is
thinner: FS-66's `U = 97.98` against `529/5 = 105.8` (8 %), while the reduction at 19 cost 14 % of `U`. **Search request**
(INVENTORY): a fibre-share certificate at `p = 23` in format `fs66-b1-cert-v2` with `U < 105.8` and at most about 2,000 rows
and 20 PSD blocks, made by the 2026-10-14 variants' producer. Until it exists, C23 stays a leaf and
`six_le_borelChromaticNumber_padicPlane_twentyThree` waits on it; nothing else does.

## Stage 3 — the skeleton, the passes and the plan (in progress)

### 3.1 The modeling passes

**Domain modeling** (`debruijn-domain-modeling`, fresh, on the five modules). The representations, read against the cut
between structure intrinsic to the problem and structure incidental to it:

- `borelChromaticNumber` is generic in the space and the graph, with the posers' class-wise wording (each colour class in
  `borel X`), so `ℚ_p²`, `ℤ_p²` and any later local field read one definition; `⊤` stands for every infinite cardinal, which
  no statement reads. Kept.
- `TowerRatio p c` is the interface between the finite tower and the measure step: the measure step reads only the levels
  `k ≥ 1`, and `k ≥ 1` is load-bearing (at `k = 0` the one-point level would force `c ≥ 1`). The count `p^{2k}` is the
  level's size, intrinsic. Kept, with its model `towerRatio_one`.
- The tower as the stable prime of `ℚ(i)` above `p` is the library's own object: `UD(ℤ/p^k, 2)` is an induced subgraph on
  all of `levelTarget P k` (T2), so every all-levels theorem at stable primes is read with no new character theory. The
  hypothesis `p ≡ 3 (mod 4)` is where it belongs — T1, where the prime must stay prime — and nowhere else in the tower.
- The `κ` form's hypothesis is one-sided and on `(ℤ/p)²`, the finite plane's own coordinates, so a reader instantiates it
  with `κ = max(2, −λ_min(UD(𝔽_p, 2)))` without meeting `ℚ(i)`. `κ ≥ 2` is the method's (FS-66's L1 constant), stated as a
  named hypothesis. A closed form with `λ_min` defined was weighed and declined: it buys one definition and an API for no
  consumer.
- `haar p` on `ℤ_p²` with the Borel σ-algebra scoped (Mathlib declares none on `ℤ_[p]`), as `[OAIMath2026]` does on
  `PadicInt 2` (`OAI/Analysis/BackwardIntertwiners/HaarBase.lean`). The well-filled set is stated as "more than half of its
  coset", with no appeal to the coset's measure, so it does not wait on M4.
- **Changed by the pass:** the upper half now exposes the Borel colouring itself (`exists_borelColoring_of_colorable`), with
  `borelChromaticNumber_le_of_colorable` one line from it. That is the inhabitant the colouring binder of
  `one_le_mul_of_borelColoring` needs — the binder the vacuity scan reads (`GENERIC` in `k`): at `p = 3`, `k = 3`, `c = 1`
  every hypothesis holds at once.
- The unsampled members: `k = 0` in `exists_unitVector_lift` (true: `ZMod 1` is one point) and in `isIndepSet_wellFilled`
  (a single vertex); `I = ∅`; `κ = p + 1` (every character sum is at least `−(p+1)`), which makes the `κ` form's
  conclusion `χ_Bor ≥ 2`. None breaks a statement.
