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
