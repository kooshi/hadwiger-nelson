
## Stage 2 — SAVED: the statements typed, and read back

Three modules, each elaborated by `lake env lean` with the lakefile's two options and by the build of stage 3:
`Proofs/HadwigerNelson/Arith/UpperHalf.lean` (namespace `HadwigerNelson.UpperHalf`, three definitions under
`SpectralChain.StablePrime`), `Proofs/HadwigerNelson/Arith/QuadraticPrime.lean` (`HadwigerNelson.QuadraticPrime`),
`Proofs/HadwigerNelson/Instances/UpperHalfValues.lean` (`HadwigerNelson.UpperHalf`). The claim list carries two dated lines since
this job's mid-job message (the coordinator's word: the defect and the three generalizations accepted; "type the corrected and
widened forms, keeping each claim's own form as a corollary"); they are on `main`, not in this tree's copy.

### NF1-S1A — proved, no leaf

| claim's clause | Lean | read back |
|---|---|---|
| `χ(planeOver F) ≤ χ(unitQuadrance (𝓞 F ⧸ 𝔭))` | `chromaticNumber_planeOver_le_unitQuadrance (F : Subfield ℝ) [NumberField F] {𝔭 : Ideal (𝓞 F)} (h𝔭 : IsUsablePrime 𝔭)` | term for term; no hypothesis added, none dropped |
| `≤ χ(finitePlane p)` when `Nat.card (𝓞 F ⧸ 𝔭) = p` is prime | `chromaticNumber_planeOver_le_finitePlane … (hp : p.Prime) (hcard : Nat.card (𝓞 F ⧸ 𝔭) = p)` | term for term. `h𝔭` and `hcard` together force `p % 4 = 3`; the statement does not say so and need not |

Both are four-line corollaries of `Arith.placeHom_base` and `Arith.exists_hom_of_isPlaceHom` (not of `exists_placeHom` at
`n = 0`, which would drag `pureTranscendental F t` into the vertex type). With them `nonempty_hom_unitQuadrance`,
`nonempty_hom_finitePlane` (the homomorphisms) and `colorable_planeOver_of_finitePlane` (the form instances call). **The map
was right that the row's bound was in the kernel unsaid; what was missing is five lines.**

### NF1-S1B

| claim's clause | Lean | read back |
|---|---|---|
| a graph homomorphism from the unit-distance graph on `planeOver F` into `levelTarget P 1` | `nonempty_hom_levelTarget_one (P : StablePrime F) : Nonempty ((unitDistance ℂ).induce (planeOver F) →g levelTarget P 1)`, from the leaf `exists_hom_levelTarget (P) {m : ℕ} (hm : 1 ≤ m) : ∃ h : … →g levelTarget P m, ∀ (x y : planeOver F) (hd : (⟨x, x.2⟩ - ⟨y, y.2⟩ : fieldI F) ∈ P.localRing), h x - h y = P.residue m ⟨_, hd⟩` | the claim's form is the corollary. **Wider**: every level `m ≥ 1`, and the map is named on each coset (the difference formula, the analogue of `exists_placeHom`'s). **Added hypothesis**: `[NumberField F]` — the claim's "real number field". `1 ≤ m` is needed: at `m = 0` the target is one vertex with no edge |
| so `χ(planeOver F) ≤ SpectralChain.localBound F` | `chromaticNumber_planeOver_le_localBound (F) [NumberField F]` | term for term; proved from the leaf by `le_iInf`. If `F(i)` had no stable prime both sides would allow `⊤`; `ℚ(i)` has one (`exists_stablePrime_rat`, a leaf), so the bound is not vacuous at `ℚ` |
| (row 127's `inline:UpperHalf`) | `chromaticNumber_eq_localBound_of_chain` — `SpectralChain.chromaticNumber_eq_localBound` with `hUpper` gone, every other hypothesis verbatim | proved from the leaf; changes no gated statement |
| converse half: a conjugation-stable valuation subring of `fieldI F` other than the field is the localization at a stable prime | `exists_stablePrime_of_valuationSubring (A : ValuationSubring (fieldI F)) (hA : A ≠ ⊤) (hσ : ∀ z ∈ A, conjOn (fieldI_conj F) z ∈ A) : ∃ P : StablePrime F, P.localRing = A` | "other than the field" is `A ≠ ⊤`; "the localization" is `P.localRing`, Mathlib's `valuationSubringAtPrime`, whose elements are the `a / s`, `s ∉ P` (`mem_localRing`, a leaf). With `conj_mem_localRing` and `localRing_ne_top` the correspondence is exact in both directions |
| (row 105, the consumer the converse was asked for) | `inv_natCast_mem_unitRingOver_iff_forall_stablePrime (F) [NumberField F] {n : ℕ} (hn : n ≠ 0) : (n : ℂ)⁻¹ ∈ UnitRing.unitRingOver F ↔ ∀ P : StablePrime F, (n : 𝓞 (fieldI F)) ∉ P.P` | not in the claim list: the sentence row 105 files as "Not claimed: the number-field reading". Stated because the converse half has no other reader |
| (row 63, "no instance over a real field yet") | `colorable_two_planeOver_of_ramified (P : StablePrime F) (hram : ∀ x : 𝓞 (fieldI F), conjO F x - x ∈ P.P) : ((unitDistance ℂ).induce (planeOver F)).Colorable 2` | not in the claim list as a statement; NF1-MODULE's instance `χ(ℚ²) = 2` needs it. The hypothesis "`2 ∈ P`" I first wrote is implied (`two_mem_of_conj_trivial`: `ī − i = −2i`) and was dropped by the modeling pass |

**Definitions** (each with an inhabitant: they are total functions of a `StablePrime F`, and `StablePrime ⊥` is inhabited once
`exists_stablePrime_rat` is proved; `StandingFive.exists_stablePrime_two` inhabits another field today):
`StablePrime.heightOne` (the prime as a `HeightOneSpectrum`), `StablePrime.localRing` (an `abbrev` for Mathlib's valuation
subring), `StablePrime.residue P m : P.localRing →+* 𝓞 (fieldI F) ⧸ P.P ^ m` (`IsLocalization.lift` of the quotient map).

### NF1-S2

| claim's clause | Lean | read back |
|---|---|---|
| squarefree `d > 1`, `F = ℚ(√d) ⊂ ℝ`, an odd prime `p`, `d ≡ s² ≢ 0 (mod p)`: a maximal ideal `𝔭` of `𝓞 F` with `Nat.card (𝓞 F ⧸ 𝔭) = p` | `exists_maximal_card_eq_sqrt {d : ℕ} (_hd : Squarefree d) (_hd1 : 1 < d) {p : ℕ} (hp : p.Prime) (hp2 : p ≠ 2) {s : ℕ} (hs : (d : ZMod p) = (s : ZMod p) ^ 2) (hs0 : (s : ZMod p) ≠ 0) : ∃ 𝔭 : Ideal (𝓞 (fieldOfRadicands {d})), 𝔭.IsMaximal ∧ Nat.card (𝓞 (fieldOfRadicands {d}) ⧸ 𝔭) = p` | the claim's own form, term for term; proved from the widened form. **`_hd` and `_hd1` are not used** (underscored so the linter is silent; the docstring says so) |
| (widened; dated line) | `exists_maximal_card_eq (D : Set ℕ) {p : ℕ} (hp : p.Prime) (hp2 : p ≠ 2) (hD : ∀ d ∈ D, (d : ZMod p) ≠ 0 ∧ IsSquare (d : ZMod p))` | any set of radicands, finite or not, squarefree or not. Proved from three leaves |
| "with its `NumberField` instance" | `numberField_fieldOfRadicands {D : Set ℕ} (hD : D.Finite)`, and the global named instance `instNumberFieldFieldOfRadicands (D) [Finite D]` | the library had none (stage 1). The statements about `𝓞 F` do not need it; `IsUsablePrime`'s consumers in `Arith/UpperHalf` do |
| the same for a multiquadratic field at a prime where every radicand is a square, a ramified radicand included (11 in `K`) | `exists_maximal_card_eq_of_ramified (D : Set ℕ) (q : ℕ) {p : ℕ} (hp : p.Prime) (hp2 : p ≠ 2) (hD : ∀ d ∈ D, (d : ZMod p) ≠ 0 ∧ IsSquare (d : ZMod p)) (hq : p ∣ q) (hq2 : ¬ p ^ 2 ∣ q) : ∃ 𝔭 : Ideal (𝓞 (fieldOfRadicands (insert q D))), …` | **corrected** (the defect sent mid-job): one radicand divisible by `p`, exactly once; with two the claim's sentence is false (`ℚ(√11, √22)` at 11). The split multiquadratic case is `exists_maximal_card_eq` |

What the widening rests on, stated as theorems of their own: `exists_maximal_card_of_padic {K} [Field K] {p} [Fact p.Prime]
(ι : K →+* ℚ_[p]) : ∃ 𝔭 : Ideal (𝓞 K), 𝔭.IsMaximal ∧ Nat.card (𝓞 K ⧸ 𝔭) = p` — any field that embeds in `ℚ_p`; no number-field
hypothesis, and true at `p = 2`.

### The instances, each from two held halves

`colorable_planeOver_fieldOfRadicands (D : Set ℕ) [Finite D] {p} (hp : p.Prime) (hp4 : p % 4 = 3) (hD : …) {k}
(hk : (finitePlane p).Colorable k) : ((unitDistance ℂ).induce (planeOver (fieldOfRadicands D))).Colorable k` is the general
statement; each instance is one application. Axioms of the other halves as the last gate's receipt prints them
(`data/fs124/l2/gate/receipt-axioms-final.log`; each `[propext, Classical.choice, Quot.sound]`):

| instance | Lean | upper half | lower half (kernel, std3) |
|---|---|---|---|
| `χ(ℚ(√11)²) = 4` | `chromaticNumber_planeOver_eleven` | this module at `p = 7` (`11 ≡ 2²`), with `HadwigerNelson.finitePlane7_colorable_four` (receipt line 1015) | `HadwigerNelson.four_le_chromaticNumber_planeOver_eleven` (line 1239) |
| `χ(ℚ²) = 2` | `chromaticNumber_planeOver_rat` | `colorable_two_planeOver_of_ramified` at `exists_stablePrime_rat`, over `HadwigerNelson.colorable_two_unitDistance_induce_of_valuationSubring` (line 1028) | `two_le_chromaticNumber_planeOver` — **not held by name before**: a leaf here (one unit edge); the map's "the kernel holds the lower half for the instances listed" is true of the other three and needs this line for `ℚ` |
| `χ(ℚ(√167)²) ≤ 8` | `chromaticNumber_planeOver_sqrt167_le_eight` | `p = 23` (`167 ≡ 11²`), with `HadwigerNelson.CayleyCert.colorable_finitePlane23_eight` (line 1209) | no equality claimed; the held lower bound is `HadwigerNelson.four_le_chromaticNumber_planeOver_sqrt167` (line 1496): `4 ≤ χ ≤ 8` |
| `χ(ℚ(√47)²) ≤ 5`, the control | `chromaticNumber_planeOver_sqrt47_le_five_of_prime` | `p = 11` (`47 ≡ 5²`), with `HadwigerNelson.chromaticNumber_finitePlane11` (line 293) | the same statement is `HadwigerNelson.SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five` (line 1512), by a route with no ring of integers: two proofs of one sentence |

Each instance is proved in the skeleton from the leaves and the held half **and nothing else**: no instance has a `sorry` of
its own except `χ(ℚ²) = 2`'s three (`numberField_bot`, `two_le_chromaticNumber_planeOver`, `exists_stablePrime_rat`).

### The modeling pass (`debruijn-domain-modeling`, a fresh invocation scoped to this job)

Changes it made: (a) the three definitions moved under `SpectralChain.StablePrime` so that `P.localRing`, `P.residue m` read
by dot notation; (b) `2 ∈ P` dropped from the two-colour theorem (implied); (c) the ramified clause checked against an
adversarial member and found too wide as claimed — already sent. What it left: the vertex of the plane as an element of
`F(i)` is written `⟨x, x.2⟩` in the difference formula (the carriers are definitionally one set; a named coercion would be
a definition with one use). A generalization it saw and did not add, no second use asking for it: the ramified clause holds
whenever the radicands lie in two square classes of `ℚ_p`, the trivial one and one of odd valuation (`{11, 33}` at 11).
`debruijn-obligation-modeling` and `debruijn-experience-modeling` were **not** invoked (budget): the decompositions of stage 4
are mine without that pass, and the one consumer boundary — what the instances file calls — was exercised by writing the
instances against the statements.
