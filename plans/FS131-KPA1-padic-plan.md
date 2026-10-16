# FS131-KPA1 — the p-adic plane at the kernel: the map, the skeleton and the price

*de Bruijn, the kernel lane's planner. Brief `data/fs131/briefs/FS131-KPA1-padic.md` (on `main` at `9a545b3c4`; a copy is
`data/fs131/kpa1/brief-copy.md`). Branch `fs131-kpa1`, worktree `.claude/worktrees/il5`, cut from `main` at `99e78e428`. No
fence: nothing in this milestone is blind. Started 2026-10-16.*

## Theorems this phase proved

None as results: a planning job. The skeleton's 38 leaves are `sorry` (§ 3.3 lists every one); the declarations it proves
(§ 3.0) are the definition's faces and compositions of leaves. Nothing with a `sorry` leaves this branch.

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

## Stage 3 — SAVED: the skeleton, the passes and the plan

### 3.0 The skeleton

Five modules under `Proofs/HadwigerNelson/PadicPlane/` — `Basic`, `Measure`, `Upper`, `Tower`, `Values` — imported by
`Proofs.lean`, with their rows in `ARCHITECTURE.md` § 3.14 (`tools/check_architecture.py` exit 0). **Built through
`./scripts/build.sh` under the slot** (`MEMMAX=7G BATCH=10`, 239 batches, 6 modules rebuilt, 7 m 26 s; the only warnings
are the 38 `declaration uses sorry` of the 38 leaves (Basic 3, Measure 10, Upper 3, Tower 7, Values 15); `data/fs131/kpa1/build-gate.log`). Proved in the skeleton, no `sorry`:
`borelChromaticNumber_le_of_coloring`, `le_borelChromaticNumber`, `chromaticNumber_le_borelChromaticNumber`,
`TowerRatio.mono`, `res_apply`, `borelChromaticNumber_le_of_colorable` (from U2), `towerRatio_of_charSum` and
`towerRatio_weil` (compositions of leaves), `borelChromaticNumber_padicPlane_twentyThree_le_eight` (from U2), and the
spec examples. Nothing with a `sorry` reaches `main`.

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

**Obligation modeling** (`debruijn-obligation-modeling`, fresh, on the hard leaves). For each, the statement the proof
derives from and its named children; every child is a separate fact, so the burn-down descends by leaf count. The
partition: **assume** Weil's bound only (the declared import); **test** the spec examples (`res p k (1, 0) = (1, 0)`, the
adjacency of `(0, 0)` and `(1, 0)` in `padicPlane p`, the empty graph's Borel one-colouring); **prove** everything else.

- **M7 `exists_level_haar_bad_le`** derives from one inequality at a saturated set, `Rigidity/CountCompletion`'s
  `haarK_bad_le` at `κ = 1/2`, which is simpler here: in a badly filled coset `D ⊆ Z`, `μ(I ∩ D) ≤ μ(D)/2 ≤ μ(D \ I)`, so
  `μ(bad_k) ≤ μ(I \ Z) + μ(Z \ I)` with no division. Children: **M7a** `haar_bad_le` (that inequality, for `Z` a union of
  level-`k` cosets); **M7b** `exists_level_coset_subset` (an open set holds a whole coset `x + p^jℤ_p²` about each of its
  points: `Metric.isOpen_iff`, and `‖y − x‖ ≤ p^{−j}` iff `res p j (y − x) = 0` by `PadicInt.ker_toZModPow` and
  `PadicInt.norm_le_pow_iff_mem_span_pow`); **M7c** `res_eq_zero_of_le` (`j ≤ k`: what `res p k` kills `res p j` kills,
  `PadicInt.cast_toZModPow`). Then the leaf: `MeasurableSet.exists_isCompact_sdiff_lt` and `exists_isOpen_sdiff_lt` at
  `ε/2` (Haar on a compact second-countable group is regular by instance, as `CountCompletion` used), a finite subcover of
  the compact set by the cosets of M7b (`IsCompact.elim_nhds_subcover`), `Z` their union, saturated at every `k` beyond the
  largest level (M7c).
- **M8 `haar_le_of_towerRatio`** derives from `μ(I) ≤ μ(bad_k) + μ(good_k)` at every `k ≥ 1`, with
  `good_k ⊆ ⋃_{x ∈ J_k} res⁻¹{x}` for `J_k` the well-filled residues as a `Finset` (`Finset.univ.filter`). Children:
  **M8a** `haar_good_le` (`μ(good_k) ≤ |J_k|·p^{−2k}`, by `measure_biUnion_finset_le` and M4); **M8b** the arithmetic
  (`|J_k| ≤ c·p^{2k}` from `TowerRatio` and M6, read in `ℝ≥0∞`); then `ENNReal.le_of_forall_pos_le_add` with M7.
- **M5 `exists_unitVector_lift`** derives from a congruence form of Hensel. Children: **M5a** `exists_sq_eq_of_unit`
  (`p ≠ 2`, `‖b₀‖ = 1`, `a² + b₀² − 1 ∈ span{p^k}` ⟹ some `b` with `a² + b² = 1` and `b − b₀ ∈ span{p^k}`: `hensels_lemma`
  for `X² − (1 − a²)` at `b₀`, then `(b − b₀)(b + b₀) ∈ span{p^k}` with `b + b₀` a unit); **M5b** one coordinate of a lift of
  a residue unit vector is a unit (`k ≥ 1`; else `1 ∈ pℤ_p`); **M5c** `toZModPow k x = toZModPow k y ↔ x − y ∈ span{p^k}`
  (`PadicInt.ker_toZModPow`). `k = 0` is its own one-line case (`(1, 0)`); the two coordinates are symmetric (swap).
- **T0 `ratioAtMost_of_charSum_levelOne`**, route A (no edit of `ClassRatio`), derives from Hoffman at each level with
  `m = κQ^n` at level `n + 1`. Children: **T0a** `charSum_descend` (a character trivial on the kernel of `toLevelOne P n`
  is `χ ∘ toLevelOne P n`, `FibreShare.exists_eq_compAddMonoidHom`, and its sum over `S_{n+1}` is `Q^n` times `χ`'s over
  `S₁`, by `CertLink.HenselCount` with `CertLink.toLevelOne_mem_normOneSet`); **T0b** `card_normOneSet_succ`
  (`|S_{n+1}| = Q^n (Q + 1)`, the same count, with `|S₁| = Q + 1` from `StandingFive.card_normOne` through the residue
  field); **T0c** `charSum_re_ge_of_levelOne` (every non-trivial character at level `n + 1` has `Re Σ ≥ −κQ^n`: descended,
  by T0a and the hypothesis; new, by `CertLink.NewCharBound`, `2Q^n ≤ κQ^n`); then `RatioBound.card_mul_le_of_indep` and
  the field algebra `κQ^n/(Q^n(Q+1) + κQ^n) = κ/(Q+1+κ)`. The plumbing (finite quotients, `Fintype.ofFinite`, the level
  set as a `Finset`) is `CertLink.card_le_of_fibreShareBound`'s, to be copied. Route B, once the collapse has merged and
  the drafted visibility edit (§ 5.1) is applied: `charBound_of_charBound_oneT` at `κ/(Q + 1)` and
  `ratioAtMost_of_charBound`, about 20 lines.
- **T1 `exists_stablePrime_above`** derives from the absolute norm of `(p)`. Children: **T1a**
  `finrank_fieldI_bot : Module.finrank ℚ (fieldI ⊥) = 2` (`SpectralChain.toFieldI` is a linear bijection from `⊥ × ⊥`,
  and `finrank ℚ ⊥ = 1`); **T1b** `absNorm (span {(p : 𝓞)}) = p²` (`Ideal.absNorm_span_natCast`,
  `NumberField.RingOfIntegers.rank`); **T1c** every maximal `P ∋ p` has `|𝓞 ⧸ P| = p²` (`absNorm_dvd_absNorm_of_le`,
  `Nat.dvd_prime_pow`; not `1`; not `p`, because `𝓞 ⧸ P` holds `ι` with `ι² = −1`, `UpperHalf.exists_I_integer`, and
  `FiniteField.isSquare_neg_one_iff` refuses it at `p ≡ 3 (mod 4)`); **T1d** stability (`P' = P.comap conj` is maximal and
  holds `p`, so T1c gives it `p²` residues; were `P' ≠ P`, `(p) ≤ P ⊓ P' = P·P'` and `p⁴ ∣ p²`); **T1e** `2 ∉ P` (else
  `1 ∈ P` from `p` odd). `p` is not a unit by T1b (`absNorm ⊤ = 1`), with no real-part argument.
- **T2 `exists_levelEmbedding`** derives from `CharP (𝓞 ⧸ P^k) (p^k)`. Children: **T2a** `card_quot_pow`
  (`|𝓞 ⧸ P^k| = p^{2k}`, `cardQuot_pow_of_prime`); **T2b** `p^j ∈ P^k → k ≤ j` (`absNorm` divisibility, `p^{2k} ∣ p^{2j}`);
  **T2c** `charP_quot_pow` (an integer `m = p^j u`, `p ∤ u`, vanishes modulo `P^k` only if `p^k ∣ m`: `u` is a unit modulo
  `P^k` since `u ∉ P`, and T2b); **T2d** the map `(a, b) ↦ θa + θb·ι` with `θ = ZMod.castHom`, its conjugate
  `θa − θb·ι`, its norm `θ(a² + b²)`; **T2e** injectivity (conjugate, add, `2` and `ι` units, `ZMod.castHom_injective`);
  then adjacency reflection is one line from the norm (T2d) and T2e.

**Experience modeling** (`debruijn-experience-modeling`, fresh, on the head statements, as a mathematician would cite them
and as `exact?` would find them). Changes made:

- **`padicPlane p`**, an `abbrev` for `unitQuadrance ℚ_[p]` beside the library's `finitePlane p`, so that every headline
  reads `borelChromaticNumber (padicPlane p)` — the domain's words — while every `unitQuadrance` lemma still applies. The
  posers' name `QG_{𝒬_p}` is in its docstring.
- **The citable form of T7**: `one_add_div_le_of_borelColoring` — *every* proper colouring of `padicPlane p` with Borel
  classes and `k` colours has `1 + (p + 1)/(2√p) ≤ k`, a real inequality with no ceiling and no `ℕ∞`; the `ℕ∞` form
  `le_borelChromaticNumber_padicPlane` (`⌈1 + (p + 1)/(2√p)⌉ ≤ χ_Bor`) stays beside it for composition.
- **Question 1** is stated in the posers' own shape (`¬ ∃ B, ∀ p ≡ 3 (mod 4), χ_Bor ≤ B`) and named for its conclusion,
  `not_exists_bound_borelChromaticNumber_padicPlane`.
- **Row 75's level clauses** are named as the library's existing level-two theorem is
  (`unitQuadrance_zmod121_not_colorable_four`): `unitQuadrance_zmod_seven_pow_not_colorable_three`, …
- Kept: `borelChromaticNumber` (the posers' `χ_Bor`, generic in the space); the value names
  `borelChromaticNumber_padicPlane_seven` etc., on the pattern of `chromaticNumber_finitePlane11`.

### 3.3 The plan, per leaf

Every leaf is a `sorry` in the skeleton. The implementer may not change a statement; a change it needs comes back through
the coordinator. **Order** (the riskiest first, so the price is re-measured on them): Tower T1, T2, T3 (the number-field
bridge); Basic B1–B3; Tower T4, T5, T6, T0; Measure M1–M10; Upper U1–U3; the certificate C7; Values. Re-price the phase
from the first two leaves (`CLAUDE.md` § What compute actually helps).

| leaf | module | route and the names it uses (each confirmed in Mathlib's source at the pin, or a library theorem) | children | hard part | lines |
|---|---|---|---|---|---|
| B1 `towerRatio_one` | Basic | `Finset.card_le_univ`, `Fintype.card_prod`, `ZMod.card` | — | `NeZero (p ^ k)` | 10 |
| B2 `not_colorable_of_towerRatio` | Basic | colour classes `univ.filter (C · = i)` are independent; `Finset.card_eq_sum_card_fiberwise`; `m·c·p^{2k} < p^{2k}` | — | — | 30 |
| B3 `norm_le_one_of_sq_add_sq_eq_one` | Basic | ultrametric: `‖a‖ ≠ ‖b‖ ⟹ ‖a² + b²‖ = max` (`IsUltrametricDist.norm_add_eq_max_of_norm_ne_norm`); `‖a‖ = ‖b‖ > 1` ⟹ `u = b/a ∈ ℤ_p` with `u² + 1 ∈ pℤ_p`, `PadicInt.toZMod`, `ZMod.exists_sq_eq_neg_one_iff` | — | the case split | 50 |
| M1 `res_surjective` | Measure | `ZMod.natCast_zmod_val`, `map_natCast` | — | — | 8 |
| M2 `isOpen_res_fibre` | Measure | fibre = `x₀ + ker`; `PadicInt.ker_toZModPow`, `PadicInt.norm_le_pow_iff_mem_span_pow`; `Metric.isOpen_iff` on the product | — | the product's sup norm | 30 |
| M3 `haar_univ` | Measure | `Measure.addHaarMeasure_self`, `PositiveCompacts.coe_top` | — | — | 5 |
| M4 `haar_res_fibre` | Measure | `AddSubgroup.index_mul_measure` (`Mathlib/MeasureTheory/Group/Measure.lean` l. 278), `AddSubgroup.index_ker`, M1; fibres are translates (`measure_preimage_add`) | — | `MeasurableSet` of the kernel (M2) | 25 |
| M5 `exists_unitVector_lift` | Measure | `hensels_lemma` (`Mathlib/NumberTheory/Padics/Hensel.lean` l. 459), `PadicInt.ker_toZModPow` | M5a–M5c (§ 3.1) | the congruence modulo `p^k` from `‖z − b₀‖ < 1` | 80 |
| M6 `isIndepSet_wellFilled` | Measure | M5; the translate `(I ∩ C') − s ⊆ C`; `nonempty_inter_of_measure_lt_add` (`MeasureSpace.lean` l. 464); `measure_preimage_add` | — | — | 60 |
| M7 `exists_level_haar_bad_le` | Measure | after `Rigidity/CountCompletion`'s `haarK_bad_le`, `tendsto_haarK_bad_of_le_one`; `MeasurableSet.exists_isCompact_sdiff_lt`, `exists_isOpen_sdiff_lt`, `IsCompact.elim_nhds_subcover` | M7a–M7c (§ 3.1) | saturation of the finite union | 120 |
| M8 `haar_le_of_towerRatio` | Measure | M6, M7, M4; `measure_biUnion_finset_le`, `ENNReal.le_of_forall_pos_le_add` | M8a, M8b | `ENNReal` arithmetic | 60 |
| M9 `one_le_mul_of_borelColoring` | Measure | classes pulled back along `PadicInt.Coe.ringHom` (continuous: `continuous_subtype_val`), measurable for the product of Borels (`Prod.borelSpace`); independent through `unitQuadrance.map`; `measure_iUnion_fintype_le`, M8 | — | Borel on `ℚ_p²` versus the product σ-algebra on `ℤ_p²` (LEAN.md l. 420's pattern, `measurable_generateFrom`) | 50 |
| M10 `le_borelChromaticNumber_of_towerRatio` | Measure | `le_borelChromaticNumber`, M9, `Nat.ceil_le` | — | — | 15 |
| U1 `exists_residueMap` | Upper | the subgroup `(PadicInt.subring p).toAddSubgroup.prod …` of `ℚ_p²`, a representative per coset (`Quotient.out`), `ρ x = (toZMod, toZMod)` of `x − rep`; edges stay in a coset by B3; `ρ` constant on `x + pℤ_p²` | — | membership bookkeeping in the subtype `ℤ_[p]` | 90 |
| U2 `exists_borelColoring_of_colorable` | Upper | `Coloring.mk (col ∘ ρ)`; each class a finite union of open fibres; `IsOpen.measurableSet` at `borel` (`@… ⟨rfl⟩`) | — | — | 25 |
| U3 `borelChromaticNumber_le_chromaticNumber` | Upper | `SimpleGraph.colorable_chromaticNumber_of_fintype`, U2 | — | `ℕ∞` casts | 15 |
| T0 `ratioAtMost_of_charSum_levelOne` | Tower | route A: `CertLink.HenselCount`, `CertLink.NewCharBound` at `henselCount_of_two_notMem`, `newCharBound_of_two_notMem`; `FibreShare.exists_eq_compAddMonoidHom`; `RatioBound.card_mul_le_of_indep`; plumbing after `CertLink.card_le_of_fibreShareBound`. Route B: § 5.1 | T0a–T0c (§ 3.1) | the level plumbing | A 150 / B 20 |
| T1 `exists_stablePrime_above` | Tower | `Ideal.absNorm_span_natCast`, `NumberField.RingOfIntegers.rank`, `Ideal.absNorm_dvd_absNorm_of_le`, `Ideal.exists_le_maximal`, `FiniteField.isSquare_neg_one_iff`, `UpperHalf.exists_I_integer`, `Ideal.absNorm_mul`, `Ideal.inf_eq_mul_of_isCoprime` | T1a–T1e (§ 3.1) | `finrank ℚ (fieldI ⊥) = 2`; LEAN.md's coercion notes on `𝓞` (l. 284, 289) | 120 |
| T2 `exists_levelEmbedding` | Tower | `cardQuot_pow_of_prime`, `CharP` by `CharP.cast_eq_zero_iff`, `ZMod.castHom`, `ZMod.castHom_injective`, `Ideal.quotientMap` for the conjugate | T2a–T2e (§ 3.1) | T2c's unit argument | 100 |
| T3 `towerRatio_of_ratioAtMost` | Tower | T2; `Finset.card_image_of_injective`; the image independent; T2a | — | the `Finset` coercions | 40 |
| T4 `charSum_levelOne_of_unitCircle` | Tower | K3 `CertLink.exists_addEquiv_zmod`; `AddChar.compAddMonoidHom`; `Finset.sum_nbij'` | — | — | 40 |
| T5 `charSum_unitCircle_ge_weil` | Tower | `StandingFive.normOne_charSum_ge` (`Arith/FloorPlanes` l. 374) at the residue field, `StandingFive.kloostermanBound_of_ringChar_ne_two`, `StandingFive.involution_eq_pow`, K3 the other way; `ClassRatio.charBound_one_weil`'s preamble is the template | — | the norm-one set as `{u^{p+1} = 1}` | 70 |
| T6 `towerRatio_of_fibreShareBound` | Tower | `CertLink.card_le_of_fibreShareBound` with Lemma P's two public theorems; T3 | — | — | 20 |
| V1 `le_borelChromaticNumber_of_charSum` | Values | `towerRatio_of_charSum`, M10, `1/(κ/(p+1+κ)) = 1 + (p+1)/κ` | — | — | 20 |
| V2 `one_add_div_le_of_borelColoring`, `le_borelChromaticNumber_padicPlane` | Values | `towerRatio_weil`, M9; V1 at `κ = 2√p` | — | — | 20 |
| V3 `not_exists_bound_borelChromaticNumber_padicPlane` | Values | `Nat.forall_exists_prime_gt_and_eq_mod` (`a = 3 : ZMod 4`, a unit) at `n = 4(B + 1)²`; `√p/2 < 1 + (p+1)/(2√p)`; V2 | — | the `Fact` instance inside `∀ p [Fact p.Prime]` (`haveI`) | 50 |
| C7 `fibreShareBound_seven` | Values, from new `Arith/FibreCert7Bound` | `tools/fs131_ikc1_gen.py data/fs66/b1/cert-p7.json … --name cert7 --nseg 1` (measured, § 2.5) → `Arith/FibreCert7` (data, 707 KB), `Arith/FibreCert7Check` (`cert7_global`, `cert7_seg0`, `cert7_psd`, `decide +kernel`, 49 s, 2.9 GB), `Arith/FibreCert7Bound` (`cert7_ok`, `sum_le_seven`, `model_seven`, after `Arith/FibreCert11Bound`) | — | the generator's output read once against the JSON (its own model) | 60 + generated |
| C23 `fibreShareBound_twentyThree` | Values | a reduced certificate (search request, § 2.5), then as C7 split by `tools/fs131_ikc4_*`; or FS-66's file as an IKC4-sized job | — | the margin `U < 105.8` | open |
| V4 the four level clauses | Values | B2 with `towerRatio_of_fibreShareBound` and C7, `fibreShareBound_eleven`, `exists_fibreShareBound_nineteen`, C23 | — | `norm_num` on the numerals | 32 |
| V5 the values at 3, 7, 11, 19 and 23's floor | Values | V2 (at 3: `√3 < 2`), M10 with T6 and the certificates; U3 or `borelChromaticNumber_le_of_colorable` with `finitePlane3_colorable_three`, `finitePlane7_colorable_four`, `finitePlane11_colorable_five`, `finitePlane19_colorable_five`; `le_antisymm` in `ℕ∞` | — | `⌈49/U⌉ = 4` etc. by `Nat.ceil_eq_iff` and `norm_num` | 70 |

### 3.4 The price

| module | hand-written lines (route A for T0) |
|---|---|
| `PadicPlane/Basic` | 90 |
| `PadicPlane/Measure` | 455 |
| `PadicPlane/Upper` | 130 |
| `PadicPlane/Tower` | 540 (410 with route B) |
| `PadicPlane/Values` | 260 |
| `Arith/FibreCert7*` (three new modules) | 60, and 707 KB generated |
| **total** | **about 1,535** (about 1,405 with route B), **without C23** |

C23 is priced in § 2.5: with a reduced certificate under about 2,000 rows, one module family like C7 (an estimate of tens
of lines and a few minutes of kernel time, extrapolated from the 19's reduced certificate, not measured); with FS-66's
file, a job of its own, larger than FS131-IKC4.

### 3.5 Vacuity and models (`LEAN.md` § The gate)

- The one binder the vacuity scan reads in these modules is the colouring `(col : (padicPlane p).Coloring (Fin k))` of
  `one_le_mul_of_borelColoring` and `(c : …)` of `one_add_div_le_of_borelColoring`, both `GENERIC` in `k`. Inhabited at
  `p = 3`, `k = 3` (`exists_borelColoring_of_colorable` with `finitePlane3_colorable_three`; at `p = 7`, `k = 4`; at
  `p = 11` and `19`, `k = 5`; at `23`, `k = 8`). Empty at every `k` below the bound: that emptiness is the theorem, not an
  assumption, and no statement takes it as one.
- Structures of hypotheses: `TowerRatio p c`, modelled by `towerRatio_one` and inhabited at the constants of
  `towerRatio_weil` and `towerRatio_of_fibreShareBound`; the stable-prime hypotheses of T2, T3, T4 (`P ∋ p`, `2 ∉ P`,
  `p²` residues), modelled by `exists_stablePrime_above`; `CertLink.FibreShareBound p U`, modelled by
  `fibreShareBound_eleven`; the `κ` hypothesis, modelled at `κ = 2√p` (T5).
- No new `axiom`, no new hypothesis standing for a hand result: the assumptions step's counts do not move; `RESTS` gains
  the records that read Weil (`charSum_unitCircle_ge_weil` and everything downstream of `towerRatio_weil`), which the
  landing reads and files as IMPORTED.

### 3.6 The head statements, read back aloud

Read from the kernel's print of the built modules (`data/fs131/kpa1/heads.lean`, output `heads.out`; the σ-algebra of the
Borel clause with `pp.explicit`, `heads-explicit.out`: `@borel (ℚ_[p] × ℚ_[p])` at the product topology), against the
result of § 1.2:

- `borelChromaticNumber G = ⨅ k, ⨅ (_ : ∃ c : G.Coloring (Fin k), ∀ i, MeasurableSet[borel X] (c ⁻¹' {i})), k`. *The least
  number of colours of a proper colouring whose every colour class is a Borel set* — the posers' `χ_Bor`, read in `ℕ∞`.
- `padicPlane p = unitQuadrance ℚ_[p]`: *vertices `ℚ_p × ℚ_p`, `x ~ y` iff `x ≠ y` and `(x₁ − y₁)² + (x₂ − y₂)² = 1`* —
  `QG_{𝒬_p}` (`x ≠ y` is automatic, `Q(0) = 0 ≠ 1`).
- `one_add_div_le_of_borelColoring : ∀ p [Fact p.Prime], p % 4 = 3 → ∀ {k} (c : (padicPlane p).Coloring (Fin k)),
  (∀ i, MeasurableSet[borel] (c ⁻¹' {i})) → 1 + (p + 1)/(2√p) ≤ k`. *Every Borel colouring of the anisotropic p-adic plane
  uses at least `1 + (p + 1)/(2√p)` colours.* That is the asking lane's theorem, word for word, with "Borel" in the
  statement as its objection required.
- `le_borelChromaticNumber_padicPlane : … → ⌈1 + (p + 1)/(2√p)⌉ ≤ borelChromaticNumber (padicPlane p)`. The same, as a
  number.
- `not_exists_bound_borelChromaticNumber_padicPlane : ¬ ∃ B : ℕ, ∀ p [Fact p.Prime], p % 4 = 3 →
  borelChromaticNumber (padicPlane p) ≤ B`. *There is no universal constant `B` with `χ_Bor(QG_{𝒬_p}) ≤ B` for all primes
  `p = 4k + 3`* — Question 1's sentence, negated.
- `le_borelChromaticNumber_of_charSum : … → 2 ≤ κ → (∀ ψ : AddChar ((ℤ/p)²) ℂ, ψ ≠ 1 → −κ ≤ Re Σ_{a²+b²=1} ψ(a, b)) →
  ⌈1 + (p + 1)/κ⌉ ≤ χ_Bor(padicPlane p)`. *If every non-trivial character sums over the circle of `𝔽_p²` to at least
  `−κ` (`κ ≥ 2`), the Borel p-adic plane needs `1 + (p+1)/κ` colours* — Hoffman's bound of the finite plane, carried.
- The values: `borelChromaticNumber (padicPlane 3) = 3`, `(padicPlane 7) = 4`, `(padicPlane 11) = 5`,
  `(padicPlane 19) = 5`, `6 ≤ (padicPlane 23)`, `(padicPlane 23) ≤ 8`. *4 at 7, 5 at 11 and 19, between 6 and 8 at 23* —
  the asking lane's sentence, with 3 at 3 beside it.
- The one new step, visible: `towerRatio_weil : p % 4 = 3 → TowerRatio p (2√p/(p + 1 + 2√p))`, where `TowerRatio p c` is
  *for every `k ≥ 1`, every independent set of `UD(ℤ/p^k, 2)` has at most `c · p^{2k}` points*; and
  `towerRatio_of_fibreShareBound` for the certificates.
- **Not claimed**, and not stated by any declaration: the plain `χ(ℚ_p²)` (`chromaticNumber_le_borelChromaticNumber` goes
  one way only and nothing bounds `χ` from below); any value at 23 beyond `[6, 8]`; anything at `p ≡ 1 (mod 4)` or `p = 2`
  (every head carries `p % 4 = 3`, or is at a fixed `p ≡ 3 (mod 4)`).

## 4. The two routes, compared

No fence applied (the brief: nothing in this milestone is blind), so the derivation (`plans/FS66-derivation.md` FS66-L1–L6,
T7, T8) was read in stage 1. The routes differ in two places, and the implementer builds the second of each:

| step | the derivation's route | the route planned | why |
|---|---|---|---|
| the bound | `[BardestaniMallahiKarai2017]` Thm 2.5 (the spectral bound for `A_μ` on `L²(ℚ_p²)`) with the Haar measure of the circle, its Fourier transform computed level by level | Hoffman's ratio bound at each finite level `UD(ℤ/p^k, 2)` (the library's `RatioBound`), then the measure step | one outside theorem fewer; Theorem 2.5 needs Fourier analysis on `ℚ_p` that Mathlib does not hold; every finite piece is already in the kernel at stable primes |
| the measure step (T8's lower half) | the cosets more than half filled are independent "by Fubini over the lifts"; their share tends to `I`'s measure "by Lebesgue density" | one Hensel lift suffices (two subsets of one coset, each above half, meet); regularity of Haar replaces density | no density theorem for `ℤ_p` exists in Mathlib; the regularity route is `Rigidity/CountCompletion`'s, already in the kernel for another profinite group |

## 5. Drafts for files this lane does not write

### 5.1 `Rigidity/ClassRatio.lean` — the visibility edit (to apply after the collapse merges, on a branch cut from that `main`)

Append, after `ratioAtMost_of_five_le_chromaticNumber` (no `private` declaration changes; the new theorem is the public
face of two private ones, in the public vocabulary of `CertLink`):

```lean
/-- **Lemma P with Hoffman's ratio bound, in public words** (FS131-KPA1's leaf `PadicPlane.ratioAtMost_of_charSum_levelOne`):
at a stable prime not above `2` with `|𝓞 ⧸ P| = Q²`, a lower bound `−κ`, `κ ≥ 2`, on the real parts of the non-trivial
character sums over the norm-one residues at level one gives the all-levels ratio `κ/(Q + 1 + κ)`
(`charBound_of_charBound_oneT` at `κ/(Q + 1)`, `ratioAtMost_of_charBound`). -/
theorem ratioAtMost_of_charSum_levelOne [NumberField F] (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P) {Q : ℕ}
    (hQ : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2) {κ : ℝ} (hκ : 2 ≤ κ)
    (h1 : ∀ (hfin : (CertLink.normOneSet P 1).Finite) (ψ : AddChar (𝓞 (fieldI F) ⧸ P.P ^ 1) ℂ), ψ ≠ 1 →
      -κ ≤ (∑ s ∈ hfin.toFinset, ψ s).re) :
    RatioAtMost P (κ / ((Q : ℝ) + 1 + κ)) := by
  -- `levelSet P 1` is `CertLink.normOneSet P 1` by definition; `card_levelSet_oneT` gives `|S₁| = Q + 1`, so `h1` is
  -- `CharBound P 1 (κ / (Q + 1))`; `2/(Q+1) ≤ κ/(Q+1)` from `hκ`; then `charBound_of_charBound_oneT` at every level,
  -- `ratioAtMost_of_charBound`, and `κ'/(1 + κ') = κ/(Q + 1 + κ)` for `κ' = κ/(Q + 1)`.
  sorry
```

It recompiles `ClassRatio` and about 25 dependents (the coordinator's count); its name differs from the `PadicPlane` leaf,
which then closes as one line, `Rigidity.ratioAtMost_of_charSum_levelOne P h2 hQ hκ h1`. If the edit is declined, route A
stands (§ 3.3, T0).

### 5.2 `LEDGER.md` row 75 — the grade note, and the kernel clause at the landing

*Now (the coordinator's ruling (4)), after the row's `**[cert]**` clause's sentence "… `α(Γ₂₃) ≤ 97` (was 105; …)":*

> The kernel's certificate at 19 is not FS-66's: `cert19_ok` (`Arith/FibreCert19Bound`) checks the Searcher's reduced
> certificate (`data/search/2026-10-14/certs/v-p19-phi0-13-qs.json`, `U = 88.6434…`), not `cert-p19.json`
> (`U = 77.511742`); so at 19 the kernel holds `Σφ ≤ 88.64` and the clauses `α(Γ₁₉) ∈ {76, 77}`, `27,981` and the Haar
> bracket at 19 rest on `cert-p19.json`, `[cert]`.

*At the landing of FS131-KPA1's module, a `**[kernel]**` clause before the `**[hand]**` one:*

> **[kernel]** (FS131-KPA1's module `PadicPlane/`, on the declared import `StandingFive.kloosterman_bound` for the bound and
> on the standard three for the values) `PadicPlane.one_add_div_le_of_borelColoring` — every Borel colouring of `ℚ_p²` at
> `p ≡ 3 (mod 4)` uses at least `1 + (p + 1)/(2√p)` colours; `not_exists_bound_borelChromaticNumber_padicPlane` —
> `[BardestaniMallahiKarai2017]` Question 1 answered no; `le_borelChromaticNumber_of_charSum` — Hoffman's bound of
> `UD(𝔽_p, 2)` carried to `χ_Bor(ℚ_p²)`; `χ_Bor(ℚ_p²) = 3, 4, 5, 5` at `p = 3, 7, 11, 19` and `6 ≤ χ_Bor(ℚ₂₃²) ≤ 8`
> (`borelChromaticNumber_padicPlane_seven`, …); no level `UD(ℤ/p^k, 2)` three-colourable at 7, four-colourable at 11 or 19,
> five-colourable at 23 (`unitQuadrance_zmod_seven_pow_not_colorable_three`, …). With no `[BardestaniMallahiKarai2017]`
> Theorem 2.5: Hoffman's bound at every level and the well-filled cosets. *(The 23 clauses only once C23 lands.)*

*The row's "Prior art" clause, its first sentence, replaced:*

> **Prior art:** the chain `χ(F²) ≤ χ(ℚ_p²) = χ(ℤ_p²) ≤ lim_k χ(G_k) ≤ χ(G₁)` at `p ≡ 3 (mod 4)` is `[Madore2015]` Prop. 3.2
> with Rem. 3.6 (`χ((ℚ_p)²) ≤ χ((𝔽_p)²)`), the levels between being the tower's monotonicity, whose step
> `χ((A/m²)^d) ≤ χ((A/m)^d)` is his Prop. 3.8;

### 5.3 `CLOSED-QUESTIONS.md` § 1.8

*In the opening quotation's paragraph, "and his Prop. 3.8 is the chain `χ(F²) ≤ χ(ℚ_p²) = χ(ℤ_p²) ≤ lim_k χ(UD(ℤ/p^k, 2)) ≤
χ(UD(𝔽_p, 2))` this whole entry stands on." replaced by:*

> and his Prop. 3.2 with Rem. 3.6 gives the ends of the chain `χ(F²) ≤ χ(ℚ_p²) = χ(ℤ_p²) ≤ lim_k χ(UD(ℤ/p^k, 2)) ≤
> χ(UD(𝔽_p, 2))` this whole entry stands on (`χ((ℚ_p)²) ≤ χ((𝔽_p)²)` at `p ≡ 3 (mod 4)`), the levels between being the
> tower's monotonicity (his Prop. 3.8 is the variant modulo `m²`).

*At the landing, after the first bullet's last sentence:*

> In the kernel (FS131-KPA1) the bound is proved without Theorem 2.5: Hoffman's ratio bound at every finite level
> `UD(ℤ/p^k, 2)`, and the cosets a Borel colour class fills to more than half, which form an independent set of a level.

### 5.4 `BIBLIOGRAPHY.md`

- `[Madore2015]`, read status: add "pp. 6–8 (Prop. 3.2 with its proof, Cor. 3.4, Rem. 3.5–3.6, ¶3.7, Prop. 3.8 with its
  proof, Prop. 3.9's statement), ¶1.5, ¶6.6 and ¶7's opening read 2026-10-16 (FS131-KPA1)".
- `[BardestaniMallahiKarai2017]`, read status: add "§1–§2 re-read 2026-10-16 (FS131-KPA1): Definition 2.6, Theorem 2.2,
  Lemma 2.4, Theorem 2.5, Question 1".

### 5.5 A stub to mint (the coordinator's ruling (3))

**The Borel bound at every anisotropic local field — a reading.** *Claim (one mind, not checked line by line):* for every
non-archimedean local field `K` of odd residue characteristic whose residue field `𝔽_q` has `q ≡ 3 (mod 4)` — the fields
over which `x² + y²` is anisotropic — `χ_Bor(K²) ≥ 1 + (q + 1)/(2√q)`, and with the certificates `χ_Bor(K²) = 4, 5, 5` and
`≥ 6` whenever `𝔽_q = 𝔽₇, 𝔽₁₁, 𝔽₁₉, 𝔽₂₃`, ramified extensions of `ℚ_p` and `𝔽_q((t))` included. *Why:* the route reads `ℚ_p`
only as a complete discrete valuation ring with odd residue characteristic: Lemma P's square-zero algebra
(`Rigidity/ClassRatio`'s `SqZeroInvT`) never reads the ramification; Madore's Prop. 3.2 (any valuation ring) makes unit
vectors integral; Hensel lifts the circle; Haar on `𝓞_K²` is regular. *Killing test:* a level of `UD(𝓞_K/𝔪^k, 2)` at a
ramified `K` with an independent set above `2√q/(q + 1 + 2√q)` of its points. *Bearing on the answer:* none on `χ(ℝ²)`;
it widens the answer to the posers' question from `ℚ_p` to every local field they consider (their Theorem 1.1 is for
characteristic zero; their Rem. 1.5 asks for positive characteristic). *Lean:* Mathlib at the pin has no general local
field API this would read; `ℚ_p(√p)` or `𝔽_q((t))` as instances would each be a job.

### 5.6 `LEAN.md` § Searching — Lean (lines learned here)

- `MeasurableSet[m] s` is notation scoped in `MeasureTheory`: a module that writes it without `open MeasureTheory` fails
  with `failed to synthesize GetElem (Set ?m → Prop) (MeasurableSpace …)` (FS131-KPA1).
- Mathlib at the pin declares no `MeasurableSpace` on `ℚ_[p]` or `ℤ_[p]` and no continuity lemma for `PadicInt.toZModPow`;
  a scoped `noncomputable` Borel instance on `ℤ_[p]` makes `Measure.addHaarMeasure ⊤` on `ℤ_[p] × ℤ_[p]` elaborate with no
  further instance (compact, second countable, Borel product). An `abbrev` over `unitQuadrance ℚ_[p]` must be
  `noncomputable` (`instCommRingPadic`). `PadicInt.subring`, `PadicInt.Coe.ringHom`, `PadicInt.norm_le_pow_iff_mem_span_pow`,
  `PadicInt.cast_toZModPow` and `hensels_lemma` (`Mathlib/NumberTheory/Padics/Hensel.lean` l. 459) are the names
  (FS131-KPA1).
- `[OAIMath2026]`'s `OAI/NumberTheory/PrimePackets/HaarBounds.lean` l. 18 (`haar_kernel_eq_inv_card`) is the ten-line pattern
  for the measure of a kernel of finite index, over `AddSubgroup.index_mul_measure` (FS131-KPA1).

*§ The kernel's cost model:*

- FS-66's fibre-share certificate at `p = 7` (8,598 ops, 495 slots, 14 PSD blocks; 707 KB of literals) checks as three
  `decide +kernel` theorems in one file in 48.8 s at 2.89 GB (shape 7.1 s, the identity 29.4 s, positive definiteness 7.5 s);
  its certificate at `p = 23` is 1,444,136 ops over 35,511 pairs, 168 times the 7's (FS131-KPA1, `data/fs131/kpa1/`).
