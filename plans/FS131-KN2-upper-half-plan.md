# FS131-KN2 — the residue upper half: statements typed, the skeleton, and a plan per leaf

*de Bruijn, the planner; brief `data/fs131/briefs/FS131-KN2-upper-half-plan.md`; branch `fs131-wnf`, worktree
`.claude/worktrees/fs131-wnf`. Opened 2026-10-13. Working files: `data/fs131/kn2/`. Successor of FS131-KN1, whose record is
`plans/FS131-KN1-number-field-kernel-map.md`. The stages below are saved in order; a successor resumes at the first stage not
marked SAVED.*

## Theorems this phase proved

A planning job; what it proved is what typing showed to be a corollary of the library. Each is in
`Proofs/HadwigerNelson/Arith/UpperHalf.lean`, namespace `HadwigerNelson.UpperHalf`, elaborated by `lake env lean` and by the
build of stage 3; none has been through the gate (no axiom audit was run by this job).

- `nonempty_hom_unitQuadrance`, `nonempty_hom_finitePlane` — the residue homomorphism at a usable prime, with no transcendental.
- `chromaticNumber_planeOver_le_unitQuadrance`, `chromaticNumber_planeOver_le_finitePlane` — **NF1-S1A, both clauses**.
- `colorable_planeOver_of_finitePlane` — the form the instances call.
- `coe_conjO`, `conjO_conjO`, `conjO_mem_iff`, `residue_algebraMap` — API of the definitions (`heightOne_asIdeal` is `rfl`).
- Proved **from leaves that are still `sorry`** (so not theorems yet): `mem_localRing_of_mul_conj_eq_one`,
  `nonempty_hom_levelTarget_one`,
  `chromaticNumber_planeOver_le_levelTarget`, `chromaticNumber_planeOver_le_localBound`,
  `chromaticNumber_eq_localBound_of_chain`; in `Arith/QuadraticPrime`: `exists_maximal_card_of_padic`, `exists_maximal_card_eq`,
  `exists_maximal_card_eq_sqrt` (NF1-S2's own form); in `Instances/UpperHalfValues`: `colorable_planeOver_fieldOfRadicands` and
  the four instances.

## Stage 1 — SAVED: the readback

**The brief's quotations.** Nine blocks: `W2` against `data/fs131/REQUEST-2026-10-13.md`, and `NF1-S1A`, `NF1-S1B`, `NF1-S2`,
`NF1-MODULE`, `NF1-WAIT-S1A`, `NF1-WAIT-S1B`, `NF1-WAIT-S2`, `NF1-NC` against `data/fs131/claims-NF1.md`, compared character for
character by `data/fs131/kn2/readback.py`: nine `IDENTICAL`. The claim list's three leaves and their waiting rows against the
second and third columns of the map's § X1 table (`[S1a]`, `[S1b]`, `[S2]`): six `IDENTICAL`. Control (`--control`: one word
changed in every quotation): fifteen `DIFFERS`. **No mismatch.** (The brief says "the eight quoted lines"; eight are from the
claim list and the ninth is Kooshi's word.)

**What each statement is typed over, read from the source.**

| symbol | declaration | where | what it is, as declared |
|---|---|---|---|
| `planeOver F` | `HadwigerNelson.planeOver (F : Subfield ℝ) : Set ℂ` | `SquareClass.lean:63` | `{z | z.re ∈ F ∧ z.im ∈ F}` |
| `χ(planeOver F)` | `((unitDistance ℂ).induce (planeOver F)).chromaticNumber` | `UnitDistance.lean:40`; Mathlib | `unitDistance V` has `Adj x y := dist x y = 1`; `chromaticNumber : ℕ∞` |
| `unitQuadrance R` | `SimpleGraph (R × R)` | `UnitQuadrance.lean:51` | the Cayley graph on `{v | v.1² + v.2² = 1}` |
| `finitePlane p` | `abbrev … := unitQuadrance (ZMod p)` | `UnitQuadrance.lean:57` | |
| `Arith.IsUsablePrime 𝔭` | `{F : Subfield ℝ} (𝔭 : Ideal (𝓞 F)) : Prop` | `Arith/PlaceHom.lean:25` | `𝔭.IsMaximal ∧ Nat.card (𝓞 F ⧸ 𝔭) % 4 = 3` |
| `fieldI F` | `abbrev … : Subfield ℂ := UnitRing.planeOverSubfield F` | `SpectralChain.lean:254` | carrier `planeOver F` (`mem_fieldI` is `Iff.rfl`) |
| `conjO F` | `𝓞 (fieldI F) →+* 𝓞 (fieldI F)` | `SpectralChain.lean:276` | `RingOfIntegers.mapRingHom (conjOn (fieldI_conj F))` |
| `StablePrime F` | structure | `SpectralChain.lean:279` | `P : Ideal (𝓞 (fieldI F))`, `isMaximal`, `comap_conj : P.comap (conjO F) = P` |
| `levelTarget P m` | `SimpleGraph (𝓞 (fieldI F) ⧸ P.P ^ m)` | `SpectralChain.lean:294` | `fromRel fun x y => (x − y) * quotientMap (P.P ^ m) (conjO F) _ (x − y) = 1` |
| `localBound F` | `ℕ∞` | `SpectralChain.lean:301` | `⨅ P : StablePrime F, (levelTarget P 1).chromaticNumber` |
| `ℚ(√d)`, `ℚ(√D)` | `SquareClass.fieldOfRadicands (D : Set ℕ) : Subfield ℝ` | `SquareClass.lean:306` | `Subfield.closure ((fun d : ℕ => √d) '' D)` |

Three things the source shows that the map's summary does not:

1. **`levelTarget P 1` lives on `𝓞 ⧸ P.P ^ 1`, not on `𝓞 ⧸ P.P`**: every statement about level one is a statement about the
   ideal `P.P ^ 1`. Typed at a general level `m` this costs nothing and removes the mismatch (stage 2).
2. **The library holds no `NumberField` instance for `fieldOfRadicands D`** (grep: the only instances on a `Subfield ℝ` or
   `Subfield ℂ` are `fieldI F` and `StandingFive.standingField`). The claim's "with its `NumberField` instance" is a leaf.
3. **Mathlib at the pin holds the localization at a prime of a Dedekind domain as a valuation subring**
   (`IsDedekindDomain.HeightOneSpectrum.valuationSubringAtPrime`, with its `IsLocalization` instance, and
   `ValuationSubring.eq_of_le_of_ne_top`), so `[S1b]` needs no restatement of `Arith/PlaceHom`'s two localization lemmas — the
   map's estimate ("must be restated for a number field given as `fieldI F`") is retired.

**The first measurement of this machine** (laptop, 12 cores, 31 GiB; `data/fs131/kn2/logs/`): one `lake env lean` under the
slot at `--mem 8 --cpus 2` on a probe importing `Arith/PlaceHom`, `SpectralChain` and Mathlib's `Padics` — **23.8 s wall, 3.56 GB
peak** (first read of the `.olean`s); `Arith/UpperHalf.lean` (225 lines, eleven `sorry`) afterwards — **3.0 s, 3.59 GB**.

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

## Stage 3 — SAVED: the skeleton, and the machine measured

**The skeleton.** Three modules, 518 lines; `sorry` is the whole body of 24 theorems and occurs nowhere else (counted:
`grep -c '^  sorry$'` and `grep -c sorry` agree per file — 12, 9, 3). Every definition has a body with no `sorry`
(`StablePrime.heightOne`, `.localRing`, `.residue`; the last takes the leaf `isUnit_mk_pow` as its proof argument).
In the build's lists: three `import` lines at the end of `Proofs.lean`; three rows in `ARCHITECTURE.md` § 3 after
`Arith/NegCircleModel`, each with its imports cell and `—` for ledger rows. `tools/check_architecture.py`: `RESULT: PASS`
(`data/fs131/kn2/logs/check_architecture.out`); run with the rows absent and the files present it fails `module coverage`
(`check_architecture.base.out`) — the control, seen by accident and kept.

**A spec example per headline** (all elaborate; those that rest on a leaf rest on its `sorry` until it is proved):
in `Arith/QuadraticPrime` — `ℚ → ℚ_5` as the model of `exists_maximal_card_of_padic`'s hypothesis; `exists_maximal_card_eq` at
`({11}, 7)`; `exists_maximal_card_eq_sqrt` at `(47, 11, s = 5)`; the ramified clause at `({3}, q = 11, p = 11)`, which is `K`;
`¬ IsSquare ((2 : ℕ) : ZMod 11)` — the hypothesis refusing the false reading; the `NumberField` instance at `{3, 11, 5}`.
In `Instances/UpperHalfValues` — the upper half at `ℚ`; `Nonempty (StablePrime ⊥)`; a usable prime of `ℚ(√11)` with 7 elements
in its quotient. `Arith/UpperHalf` itself carries no `example`: its hypotheses' models need the other two modules, and its
module docstring names them (`LEAN.md` § The gate: "or a one-line note naming the theorem that supplies one").

**Vacuity, read by hand** (no scan was run). No new binder is a colouring. `IsUsablePrime 𝔭` and `P : StablePrime F` are the
structure-valued hypotheses: the first is inhabited at `ℚ(√11)` (7), `ℚ(√47)` (11), `ℚ(√167)` (23) by `exists_maximal_card_eq`
once Q4–Q7 are proved; the second at `ℚ` by `exists_stablePrime_rat` once I3 is proved, and today at the standing field by
`StandingFive.exists_stablePrime_two`. `colorable_two_planeOver_of_ramified`'s `hram` is inhabited at `ℚ` by the same leaf.
`exists_stablePrime_of_valuationSubring`'s `A`: `P.localRing` for any stable `P` (`localRing_ne_top`, `conj_mem_localRing`).
`nonempty_ringHom_zmod_of_ramified_sqrt`'s hypotheses have no model in the kernel until Q9 builds one at `ℚ(√3, √11)`.

**The machine** (laptop, 12 cores, 31 GiB; logs under `data/fs131/kn2/logs/`):

| run | what was stale | wall | peak memory | what the number measures |
|---|---|---|---|---|
| `lake env lean`, probe importing `Arith/PlaceHom`, `SpectralChain`, Mathlib's `Padics` (first read) | — | 23.8 s | 3.56 GB | one file, cold `.olean`s |
| `lake env lean Arith/UpperHalf.lean` (246 lines) | — | 3.0–3.1 s | 3.59 GB | one file, warm; the implementers' iteration |
| `lake env lean Arith/QuadraticPrime.lean` (162 lines) | — | 2.3 s | 3.35 GB | the same |
| build 1: slot `--mem 18 --cpus 10`, `MEMMAX=18G BATCH=2 ./scripts/build.sh` | the three new modules and the root | **23 m 51 s** | 4.52 GB (largest single process; never two `lean` alive at a 3 s sample) | 947 Lake starts; compiling was 12.0 s of it (1.8 + 2.6 + 1.0 s, root 6.6 s) |
| build 2: the same at `BATCH=8` | `Arith/UpperHalf`, `Instances/UpperHalfValues`, the root | **6 m 37 s** | 4.53 GB (largest single process; one `lean` alive at every 1 s sample, at most 4.19 GB) | 249 Lake starts; compiling was 6.5 s (2.7 + 1.9 s, root 1.9 s). The walk is the cost, and it scales with the batch count: 1.51 s a batch at width 2, 1.59 s at width 8 |

A build under another job's slot waits: this job's second probe sat 24 minutes behind a slot named `kc1` (18 GiB, 10 cores)
— on this machine two builds do not overlap, and a `lake env lean` at `--mem 8` does not fit beside one (18 + 8 > 22).

## Stage 4 — SAVED: a plan per leaf

*For an implementer with none of this record's context. Twenty-four leaves are `sorry`; every other declaration in the three
modules is proved, from the leaves or from the library. **No statement may change**: a change a proof needs comes back through
the coordinator. Names marked ✓ were confirmed with `#check` under the module's own imports
(`data/fs131/kn2/probes/p1.lean`, `p2.lean`, `p3.lean`; outputs in `data/fs131/kn2/logs/`); names marked (read) were read in
Mathlib's or the library's source at the pin and not `#check`ed. I typed no leaf's proof except where a line says "compiled".
No size is given for a leaf I did not type. Iterate with `data/fs131/kn2/lean1.sh <file>` (seconds per run, 3.6 GB).*

Notation: `K = fieldI F` (`F(i) ⊂ ℂ`), `𝓞 = 𝓞 (fieldI F)`, `B = P.localRing`, `σ = conjOn (fieldI_conj F)`.

### A. `Arith/UpperHalf.lean` — twelve leaves, in dependency order

**U1 `mem_localRing`**: `x ∈ P.localRing ↔ ∃ a s : 𝓞, s ∉ P.P ∧ x = (a : K) / (s : K)`.
Route: `P.localRing` is `ValuationSubring.ofSubring (Localization.subalgebra.ofField K _ _).toSubring _`
(`HeightOneSpectrum.valuationSubringAtPrime_toSubring` is `rfl` (read)), whose membership is by definition
`∃ a s (_ : s ∈ P.P.primeCompl), x = algebraMap 𝓞 K a * (algebraMap 𝓞 K s)⁻¹`. The library has this proof verbatim for a
usable prime: `Arith/PlaceHom.lean:113–117` (`rw [ValuationSubring.mem_ofSubring]; show (∃ (a s) (_ : s ∈ _), x = _ * _⁻¹) ↔ _`,
then both directions by `⟨a, s, hs, by rw [div_eq_mul_inv]⟩`). Mathlib destructs the same membership as `⟨a, s, hs, rfl⟩`
(`AdicValuation.lean:486`).

**U2 `conj_mem_localRing`**: `∀ z ∈ B, σ z ∈ B`.
Route: `obtain ⟨a, s, hs, rfl⟩ := (mem_localRing P).1 hz`; give `⟨conjO F a, conjO F s, mt (conjO_mem_iff P).1 hs, _⟩`; the equation is
`map_div₀ σ _ _` with `coe_conjO` (which is `rfl`). The library's general form of this step is
`conj_mem_valuationSubringAtPrime` (`ResidueColouring.lean:501`), stated for ring *equivalences*; `σ` here is a ring
homomorphism, so the three lines above are shorter than adapting it.

**U3 `isUnit_mk_pow`**: for `y ∉ P.P`, `Ideal.Quotient.mk (P.P ^ m) y` is a unit.
Route: `haveI := P.isMaximal`; `Ideal.IsMaximal.exists_inv_pow P.P (hx : ↑y ∉ P.P) m : ∃ z, ∃ i ∈ P.P ^ m, z * ↑y + i = 1` (read,
`Mathlib/RingTheory/Ideal/Operations.lean:1238`); then `IsUnit.of_mul_eq_one` ✓ with `mk z`, the equation by
`Ideal.Quotient.eq` / `Ideal.Quotient.eq_zero_iff_mem` ✓ after `map_mul`, `map_add`.

**U4 `residue_div`**: `P.residue m ⟨a / s, _⟩ * mk s = mk a`.
Route: `Arith/PlaceHom.lean:149–157` verbatim with `L := P.residue m`, `hLa := residue_algebraMap P m`: in `B`,
`⟨a / s, _⟩ * algebraMap 𝓞 B s = algebraMap 𝓞 B a` (`Subtype.ext`, `div_mul_cancel₀`; `s ≠ 0` because `s ∉ P.P` and `0 ∈ P.P`),
then `rw [← residue_algebraMap P m s, ← map_mul, key, residue_algebraMap]`.

**U5 `residue_conj`**: `P.residue m ⟨σ z, _⟩ = Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) (P.residue m z)`.
Route: two ring homomorphisms `B →+* 𝓞 ⧸ P.P ^ m` — `(P.residue m).comp (σ.restrict B.toSubring B.toSubring (conj_mem_localRing P))`
and `(Ideal.quotientMap …).comp (P.residue m)` — agree on `algebraMap 𝓞 B a` (the first is `mk (conjO F a)` by
`residue_algebraMap` after `Subtype.ext rfl`; the second by `residue_algebraMap` and `Ideal.quotientMap_mk` ✓), so they are
equal by `IsLocalization.ringHom_ext` ✓ at `M := P.heightOne.asIdeal.primeCompl`; apply at `z`. The `restrict` form is the one
`colorable_two_unitDistance_induce_of_valuationSubring` states (`TwoColourResidue.lean:149`), so U10 reads this lemma with no
re-proof.

**U6 `coe_mem_nonunits_localRing_iff`**: `(a : K) ∈ B.nonunits ↔ a ∈ P.P`.
Route: `ValuationSubring.mem_nonunits_iff_exists_mem_maximalIdeal` ✓ (used at `PlaceHom.lean:254`), or elementary through
`x ∈ B.nonunits ↔ x = 0 ∨ x⁻¹ ∉ B` (the library uses `ValuationSubring.mem_nonunits_iff_or` ✓, Mathlib's, at `UnitRing.lean:112`).
(⟸) `a ∈ P.P`, `a ≠ 0`: if `a⁻¹ = b / s` with `s ∉ P.P` then `s = a * b` in `𝓞` (`RingOfIntegers.coe_injective` (read)), so
`s ∈ P.P`. (⟹, contrapositive) `a ∉ P.P` gives `a⁻¹ = 1 / a ∈ B` by U1 and `a ∈ B`, so `a` is a unit of `B`. Mathlib's
`IsLocalization.AtPrime.to_map_mem_maximal_iff` ✓ is the same fact on `B` as a localization, if the instance route is smoother.

**U7 `localRing_ne_top`**. Route: Mathlib proves it inside `valuationSubringAtPrime_eq_valuationSubring`
(`AdicValuation.lean:509–512`): `rw [HeightOneSpectrum.valuationSubringAtPrime_eq_valuationSubring]` ✓, after which the goal is that proof's third
argument, `(v.valuation K).valuationSubring ≠ ⊤`, closed there by
`by simp only [ne_eq, Valuation.valuationSubring_eq_top_iff, not_not]; infer_instance` (read; not compiled here). Elementary alternative: `P.heightOne.ne_bot` gives `a ∈ P.P`, `a ≠ 0`
(`Submodule.exists_mem_ne_zero_of_ne_bot` ✓); `a⁻¹ ∈ ⊤`; contradiction with U6.

**U8 `exists_hom_levelTarget` — the module's main leaf.** `∃ h : (unitDistance ℂ).induce (planeOver F) →g levelTarget P m, ∀ x y hd, h x - h y = P.residue m ⟨_, hd⟩`, for `1 ≤ m`.
The template is `Arith.exists_hom_of_isPlaceHom` (`Arith/PlaceHom.lean:308–361`), which builds the same homomorphism at a
usable prime with two real coordinates; here there is one complex coordinate. Steps, with `k := 𝓞 ⧸ P.P ^ m`, `r := P.residue m`:
1. `A : AddSubgroup ℂ := (B.toSubring.map K.subtype).toAddSubgroup`; `e := Subring.equivMapOfInjective B.toSubring K.subtype Subtype.val_injective` ✓ and `ψ : A →+ k := (r.comp e.symm.toRingHom).toAddMonoidHom` (the pair `e`, `r'.comp e.symm.toRingHom` is built at `PlaceHom.lean:189–191`).
2. `h x := cosetResidue ψ (x : ℂ)` (`ResidueColouring.lean:193`; reason through `cosetResidue_sub`, `cosetResidue_apply_of_mem`, never by unfolding — the definition is sealed).
3. The formula: from `hd`, `(x : ℂ) - y ∈ A` (`⟨_, hd, rfl⟩`); `rw [cosetResidue_sub ψ hmem, cosetResidue_apply_of_mem ψ hmem]`; `e.symm ⟨_, _⟩ = ⟨_, hd⟩` by `RingEquiv.symm_apply_eq` and `Subtype.ext rfl` (as `PlaceHom.lean:213–214`).
4. Adjacency. `dist x y = 1` gives `u * σ u = 1` for `u := (⟨x, x.2⟩ - ⟨y, y.2⟩ : K)`: `sub_mem_normOne_conj_iff.mpr` (`ResidueColouring.lean:538`) then `Subtype.ext` and `simpa [mem_normOne, map_sub]`, exactly `ResidueColouring.lean:608–612`. So `hd : u ∈ B` by `mem_localRing_of_mul_conj_eq_one` (proved), and with `t := r ⟨u, hd⟩`: `t * quotientMap … t = r ⟨u, _⟩ * r ⟨σ u, _⟩ = r 1 = 1` by `residue_conj`, `← map_mul`, `Subtype.ext hu`, `map_one`.
5. `SimpleGraph.fromRel_adj` ✓: `h x ≠ h y ∧ (rel ∨ rel')`. The relation's left disjunct is step 4 after `rw` with the formula. `h x ≠ h y`: otherwise `t = 0` and `0 = 1` in `k`, but `k` is nontrivial: `Ideal.Quotient.nontrivial_iff` ✓ with `P.P ^ m ≠ ⊤` from `Ideal.pow_le_self (by omega) : P.P ^ m ≤ P.P` ✓ and `P.isMaximal.ne_top`.
What is hard: nothing mathematical. The friction is the three faces of one point — `x : planeOver F`, `⟨x, x.2⟩ : K`, `(x : ℂ)` —
which are definitionally one (`mem_fieldI` is `Iff.rfl`); when `simp` will not see through it, `show` the form wanted.

**U9 `two_mem_of_conj_trivial`**: `hram` gives `2 ∈ P.P`.
Route: `StandingFive.lean:760–775` builds `iO : 𝓞 (fieldI standingField)` with `iO_sq`, `conjO_iO` for one field; do the same
for any `F` (`Complex.I ∈ fieldI F`: `SpectralChain.lean:639`'s example; integral: a root of `X² + 1`, or `IsIntegral.of_pow` ✓
from `I ^ 2 = -1`). Then `StandingFive.lean:1150–1163` (`exists_conjO_sub_notMem`, second branch) is this argument in the
other direction: `conjO i - i = -(2 * i) ∈ P.P`, primality gives `2 ∈ P.P` or `i ∈ P.P`, and `i ∈ P.P` gives `-1 = i² ∈ P.P`.

**U10 `colorable_two_planeOver_of_ramified`**.
Route: `colorable_two_unitDistance_induce_of_valuationSubring (fieldI_conj F) B (conj_mem_localRing P) (k := 𝓞 ⧸ P.P ^ 1) (P.residue 1) hψσ (S := planeOver F) (fun _ hz => hz)` ✓ (`TwoColourResidue.lean:146`). It asks `[IsReduced k] [CharP k 2]`: with
`e : P.P ^ 1 = P.P := pow_one _`, `(P.P ^ 1).IsMaximal` (rewrite `e`), `Ideal.Quotient.field` ✓ makes `k` a field (reduced), and
`CharTwo.of_one_ne_zero_of_two_eq_zero` ✓ gives `CharP k 2` from `mk 2 = 0` (U9, `Ideal.Quotient.eq_zero_iff_mem`). `hψσ z`:
`residue_conj` turns the left side into `quotientMap … (P.residue 1 z)`, and `quotientMap (P.P ^ 1) (conjO F) _ = RingHom.id _`
by `Ideal.Quotient.ringHom_ext` ✓ (`mk (conjO F a) = mk a` because `conjO F a - a ∈ P.P = P.P ^ 1`).

**U11 `exists_stablePrime_of_valuationSubring`**: `A ≠ ⊤`, `A` conjugation-stable ⟹ `∃ P, P.localRing = A`.
Steps: (1) `𝓞 ⊆ A`: `x : 𝓞` is integral over `ℤ` (`RingOfIntegers.isIntegral_coe` ✓), hence over `A` (`IsIntegral.tower_top` ✓),
hence in `A` (`IsIntegrallyClosed.isIntegral_iff` ✓; `IsIntegrallyClosed A` and `IsFractionRing A K` are instances —
`Mathlib/RingTheory/Valuation/LocalSubring.lean:38`, and the probe's `inferInstance`). (2) `Q := {a : 𝓞 | (a : K) ∈ A.nonunits}`
as an ideal — the comap of `IsLocalRing.maximalIdeal A` along the inclusion `𝓞 →+* A` — prime (`Ideal.comap_isPrime` ✓).
(3) `Q ≠ ⊥`: otherwise every nonzero `a : 𝓞` is a unit of `A`, every `a / s ∈ A`, and every `x : K` is such a quotient
(`IsFractionRing.div_surjective` ✓ for `𝓞`), so `A = ⊤`. (4) `Q` maximal: `Ideal.IsPrime.isMaximal` ✓ (a nonzero prime of a
Dedekind domain). (5) `Q.comap (conjO F) = Q`: `σ` maps `A` into `A` and is an involution (`conjOn_conjOn`), so it preserves units
and non-units of `A`. (6) With `P := ⟨Q, _, _⟩`: `P.localRing ≤ A` (`a / s` with `s ∉ Q` a unit of `A`), and
`ValuationSubring.eq_of_le_of_ne_top` ✓ (`[Ring.KrullDimLE 1 P.localRing]` is Mathlib's instance, `AdicValuation.lean:499`)
gives `P.localRing = A`.
What is hard: step (2)–(3)'s bookkeeping between `𝓞`, `A` and `K`; state `hQ : ∀ a : 𝓞, a ∈ Q ↔ (a : K) ∈ A.nonunits` first and
use only it afterwards.

**U12 `inv_natCast_mem_unitRingOver_iff_forall_stablePrime`**.
Route: `rw [UnitRing.inv_natCast_mem_unitRingOver_iff F hn]` ✓ (`UnitRing.lean:191`; its valuation subrings are of
`UnitRing.planeOverSubfield F`, which `fieldI F` abbreviates, and its conjugation is `conjOn (UnitRing.conj_mem_planeOverSubfield F)`,
which `fieldI_conj F` is). (→) at `P`: instantiate with `P.localRing`, `conj_mem_localRing P`, and U6 at `a := (n : 𝓞)`
(`map_natCast` for the cast). (←) a stable `B` with `(n : K) ∈ B.nonunits` is not `⊤` (in `⊤` the nonzero `n` is a unit);
`obtain ⟨P, rfl⟩ := exists_stablePrime_of_valuationSubring B _ hσ`; U6 the other way.

### B. `Arith/QuadraticPrime.lean` — nine leaves

**Q1 `isIntegral_sqrt_natCast`**: `IsIntegral.of_pow (n := 2)` ✓ from `Real.sq_sqrt (Nat.cast_nonneg d)` ✓ and
`isIntegral_algebraMap` ✓ (`((d : ℕ) : ℝ) = algebraMap ℚ ℝ d` by `map_natCast`).

**Q2 `fieldOfRadicands_eq_adjoin`**: `unfold fieldOfRadicands; rw [IntermediateField.adjoin_toSubfield]` ✓, then `le_antisymm`:
`Subfield.closure_mono Set.subset_union_right` ✓, and `Subfield.closure_le` with the range of `algebraMap ℚ ℝ` inside every
subfield (`eq_ratCast`, `SubfieldClass.ratCast_mem`). Template: `Arith/PlaceHom.lean:83–95`.

**Q3 `numberField_fieldOfRadicands`**: the structure is `{ to_finiteDimensional := _ }` (as `SpectralChain.lean:270`). The
inclusion `fieldOfRadicands D → IntermediateField.adjoin ℚ S` (`S := (fun d : ℕ => √d) '' D`; membership by Q2) is an injective
`ℚ`-linear map, so `Module.Finite.of_injective` ✓ (the pattern of `StandingFive.lean:701`) with
`IntermediateField.finiteDimensional_adjoin` ✓ — it asks `[Finite ↑S]` (`(hD.image _).to_subtype`) and
`∀ x ∈ S, IsIntegral ℚ x` (Q1).

**Q4 `isMaximal_ker_and_card`** (compiled, `data/fs131/kn2/probes/p3.lean`):
`haveI : Fact p.Prime := ⟨hp⟩; have hs := ZMod.ringHom_surjective f; exact ⟨RingHom.ker_isMaximal_of_surjective f hs, by rw [Nat.card_congr (RingHom.quotientKerEquivOfSurjective hs).toEquiv, Nat.card_zmod]⟩`.

**Q5 `exists_ringHom_zmod_of_padic`**: `∃ f : 𝓞 K →+* ZMod p, ∀ x z, (z : ℚ_[p]) = ι x → f x = PadicInt.toZMod z`.
Route: for `x : 𝓞 K`, `IsIntegral ℤ (ι x)` (`RingOfIntegers.isIntegral_coe x` ✓ pushed along `ι.toIntAlgHom` by `IsIntegral.map` ✓),
so `IsIntegral ℤ_[p] (ι x)` (`IsIntegral.tower_top` ✓), so `ι x` is the image of some `z : ℤ_[p]`
(`IsIntegrallyClosed.isIntegral_iff` ✓; `IsIntegrallyClosed ℤ_[p]` and `PadicInt.isFractionRing` ✓ are instances — both
`inferInstance` in the probe), i.e. `‖ι x‖ ≤ 1` (`PadicInt.norm_le_one` ✓). `g : 𝓞 K →+* ℤ_[p]` is `ι.comp (algebraMap (𝓞 K) K)` with its values in `ℤ_[p]`: Mathlib defines `ℤ_[p]` as the subtype
`{x : ℚ_[p] // ‖x‖ ≤ 1}` (`PadicIntegers.lean:60`) and `PadicInt.subring p` ✓ as the subring with that carrier
(`PadicInt.mem_subring_iff` ✓ is `Iff.rfl`), so write `g` by its five fields, `toFun x := ⟨ι x, h x⟩`, each law by `Subtype.ext`;
`f := PadicInt.toZMod.comp g`; the specification is `congrArg _ (Subtype.ext h.symm)`.

**Q6 `exists_padicInt_sq_eq`** (Hensel): `d` a nonzero square modulo odd `p` ⟹ `∃ r : ℤ_[p], r ^ 2 = d`.
Route: `hd` gives `s : ZMod p`, `d = s * s`; pick `n : ℕ` with `(n : ZMod p) = s` (`ZMod.natCast_zmod_surjective` ✓). Apply
`hensels_lemma` ✓ to `F := X ^ 2 - C (d : ℤ) : ℤ[X]` at `a := (n : ℤ_[p])`: `aeval a F = a ^ 2 - d` and
`aeval a (derivative F) = 2 * a` (`simp`). `‖a ^ 2 - d‖ < 1` by `PadicInt.norm_int_lt_one_iff_dvd` ✓ from
`(p : ℤ) ∣ n ^ 2 - d` (`ZMod.intCast_zmod_eq_zero_iff_dvd` ✓); `‖2 * a‖ = 1` because `p ∤ 2 * n` (`p` odd; `p ∤ n` since
`s ≠ 0` by `hd0`): the same lemma negated with `PadicInt.norm_le_one` ✓. So `‖aeval a F‖ < 1 = ‖aeval a F'‖ ^ 2`, and the root
`z` has `z ^ 2 = d` (`sub_eq_zero`).

**Q7 `nonempty_ringHom_padic`**: `Nonempty (fieldOfRadicands D →+* ℚ_[p])`.
Route: `IntermediateField.nonempty_algHom_adjoin_of_splits` ✓ at `F := ℚ`, `E := ℝ`, `K := ℚ_[p]`, `S := (fun d : ℕ => √d) '' D`:
for `√d ∈ S`, integral (Q1) and `((minpoly ℚ √d).map (algebraMap ℚ ℚ_[p])).Splits`: `minpoly.dvd ℚ √d` ✓ gives
`minpoly ∣ X ^ 2 - C (d : ℚ)`; map it (`Polynomial.map_dvd` ✓); the image is `(X - C r) * (X - C (-r))` for `r` the root of Q6
in `ℚ_[p]` (`ring_nf` after `simp`), which splits (`Polynomial.Splits.mul` ✓, `Polynomial.Splits.X_sub_C` ✓); conclude with
`Polynomial.Splits.of_dvd` ✓ (it asks the product `≠ 0`: monic). Compose the algebra homomorphism with the inclusion of Q2.
What may cost an iteration: `↥(E.toSubfield)` and `↥E` are one type up to unfolding; if the composition does not elaborate,
write the ring homomorphism by its five fields with `⟨x, Q2 ▸ x.2⟩`.

**Q8 `nonempty_ringHom_zmod_of_ramified_sqrt` — the largest leaf; none of NF1-MODULE's four instances needs it** (it serves
row 52's two values, at 11 in `K(√5)` and `K(√247)`). Statement: `K₀ : Subfield K`, `ι₀ : K₀ →+* ℚ_[p]`, `p` odd, `π ^ 2 = q`,
`p ∣ q`, `p² ∤ q`, `Subfield.closure (K₀ ∪ {π}) = ⊤` ⟹ `Nonempty (𝓞 K →+* ZMod p)`. Children, to be stated as private lemmas in
this order (each smaller than its parent: it removes one of the five things the parent must build):
- (a) **no square root of `q` in `K₀`**: `∀ c : K₀, (c : K) ^ 2 ≠ q`. Else `ι₀ c ^ 2 = q` in `ℚ_[p]` and
  `2 * (ι₀ c).valuation = (q : ℚ_[p]).valuation = 1` (`Padic.valuation_mul`-type lemmas; `Padic.valuation_natCast`/`padicValNat`
  with `hq`, `hq2`) — an even integer equal to 1. So `π ∉ K₀`.
- (b) **coordinates exist**: `∀ x : K, ∃ a b : K₀, x = a + b * π`. The set of such `x` is a subfield containing `K₀` and `π`
  (inverse: `(a + bπ)(a − bπ) = a² − b²q ≠ 0` unless `a = b = 0`, by (a) applied to `a / b`); conclude with `hgen`. The library
  did this for `ℚ(√47)` over `ℚ`: `Instances/SqrtFortySeven.lean:37–190` (`q47`, `mem_q47_of_mem`, `re47`, `im47`, `coords_add`,
  `coords_mul`) — the template, with `ℚ` replaced by `K₀`.
- (c) **coordinates are unique** (from `π ∉ K₀`), so `re, im : K → K₀` with `coords_add`, `coords_mul`
  (`re (x y) = re x re y + im x im y q`), and `conj' : K →+* K`, `a + bπ ↦ a − bπ`, is a ring homomorphism.
- (d) **integers have integral coordinates**: for `x : 𝓞 K`, `‖ι₀ (re x)‖ ≤ 1` and `‖ι₀ (im x)‖ ≤ 1`. `conj' x` is integral
  (`IsIntegral.map` ✓), so `2 re x = x + conj' x` and `re x² − im x² q = x · conj' x` are integral over `ℤ` and lie in `K₀`
  (`isIntegral_algebraMap_iff` ✓ along the injection `K₀ → K`); their images under `ι₀` are in `ℤ_[p]` as in Q5. `p` odd gives
  `‖ι₀ (re x)‖ ≤ 1`; then `‖ι₀ (im x)‖² · ‖q‖ ≤ 1` with `‖q‖ = p⁻¹` and `‖·‖ ∈ p^ℤ` gives `‖ι₀ (im x)‖ ≤ 1` (the parity step).
- (e) **the homomorphism** `x ↦ toZMod (ι₀ (re x))`: additive by `coords_add`; multiplicative because
  `toZMod (ι₀ (im x) · ι₀ (im y) · q) = 0` (`p ∣ q`); `re 1 = 1`.
What is hard: (d)'s parity step, and keeping `K₀`'s elements, their images in `K`, and their images in `ℚ_[p]` apart. A second
route I did not take: Chevalley's extension (`Ideal.image_subset_nonunits_valuationSubring`, used at row 105) gives a valuation
subring of `K` over `ι₀⁻¹ ℤ_p` and removes (c) and the automorphism at the price of a general-valuation form of the parity
step; it still needs (a) and (b).

**Q9 `exists_maximal_card_eq_of_ramified`** (the glue). With `E := fieldOfRadicands (insert q D)` as the field `K` of Q8:
`K₀ := (fieldOfRadicands D).comap E.subtype`; `ι₀` the embedding of Q7 composed with `K₀ → fieldOfRadicands D`,
`x ↦ ⟨(x : E), x.2⟩`; `π := ⟨√q, sqrt_mem_fieldOfRadicands (Set.mem_insert q D)⟩` (`SquareClass.lean:311`); `hπ` by
`Real.sq_sqrt`; `hgen`: `E`'s elements lie in the closure of the `√d`, `d ∈ insert q D`, each of which is `π` or in `K₀`
(`Subfield.closure_induction` on `x.2`, or `Subfield.closure_le` after mapping to `ℝ`). Then Q4 on the homomorphism of Q8.

### C. `Instances/UpperHalfValues.lean` — three leaves

**I1 `numberField_bot`**: `fieldOfRadicands ∅ = ⊥` (`unfold fieldOfRadicands; rw [Set.image_empty, Subfield.closure_empty]` ✓),
then `h ▸ QuadraticPrime.numberField_fieldOfRadicands Set.finite_empty`.

**I2 `two_le_chromaticNumber_planeOver`**: `0, 1 ∈ planeOver F` (`F.zero_mem`, `F.one_mem`; imaginary parts `0`), adjacent
(`dist 0 1 = 1`), and `SimpleGraph.two_le_chromaticNumber_of_adj` ✓.

**I3 `exists_stablePrime_rat`**: a maximal ideal `P` of `𝓞 (ℚ(i))` with `2 ∈ P`, `P.comap conjO = P`, and `x̄ − x ∈ P` for all `x`.
Route: (1) `2` is not a unit of `𝓞`: `1/2` would be integral over `ℤ` and rational, so an integer
(`IsIntegrallyClosed.isIntegral_iff` ✓ for `ℤ ⊂ ℚ`). `Ideal.exists_le_maximal` ✓ gives a maximal `P ∋ 2`. (2) **`Im x ∈ ℤ` for
`x : 𝓞`**: `Re x, Im x ∈ ℚ` (`x ∈ fieldI ⊥`; `Subfield.bot_eq_of_charZero`, as `Transcendental.lean:381`); `T := 2 Re x = x + x̄`
and `N := Re x² + Im x² = x x̄` are integral and rational, so integers; `(2 Im x)² = 4N − T²` is an integer, so `2 Im x` is one
(integral: a root of `X² − n`); `T² + (2 Im x)² ≡ 0 (mod 4)` forces both even (squares are `0, 1` modulo 4: `decide` over
`ZMod 4`). (3) So `x̄ − x = 2 · (−Im x · i)` with `−Im x · i ∈ 𝓞`, in `P`. (4) `P.comap (conjO ⊥) = P` from (3):
`conjO x = x + (conjO x − x)`, and the other inclusion by `conjO_conjO` (proved in `Arith/UpperHalf`).
`Arith/NegCircleModel.lean:63` (`exists_odd_rep_of_unitVector`) is the library's one other place that does parity in `ℚ(i)`.

### D. The split, and what the landing needs

- **Three implementers at once, no shared file**: one on `Arith/UpperHalf.lean` (U1–U12; order U1, U2, U3, U4, U5, U6, U7,
  U9, U10, U8, U11, U12); one on `Arith/QuadraticPrime.lean` (Q1–Q7, then Q9, then Q8); one on
  `Instances/UpperHalfValues.lean` (I1–I3) — its file reads only the *statements* of the other two, so it compiles against
  the skeleton's `.olean`s from the first minute and is not blocked by either. With two implementers, the instances file goes
  to whoever finishes first. Q8 is separable: it can be handed to a fourth mind, or deferred behind the landing of the rest,
  at the cost of one `sorry` (`exists_maximal_card_eq_of_ramified` through it) and no instance.
- Each implementer makes the statement dump of `LEAN.md` (FS124-I5's `statements.sh`) on the skeleton before its first edit.
- **The landing**, after the leaves: (1) the full build and the `sorry` scan; (2) `scripts/dupnames.sh` — the new names
  `coe_conjO`, `conjO_conjO` are in `HadwigerNelson.UpperHalf` and `StandingFive` has its own `conjO_conjO` under its namespace:
  no clash, but it is the scan's to say; (3) records in `scripts/Axioms.lean` for the public theorems; (4) **the assumptions
  step moves**: `scripts/Assumptions.lean:799` declares `.site ``HadwigerNelson.SpectralChain.chromaticNumber_eq_localBound
  `hUpper "UpperHalf" .ours`, and once `UpperHalf.chromaticNumber_planeOver_le_localBound` proves that binder over the
  theorem's own variables the step fails on it ("a declared hypothesis … a theorem proves over its own variables"): the line
  leaves, `scripts/assumptions-ledger.txt:129` with it, and the new `chromaticNumber_eq_localBound_of_chain` enters as a taker
  of each of the headline's other hypotheses (two written out in binders: `hCLS`, `hRow99` — two `.site` lines). The nine
  counts in `CLAUDE.md` § Trust ledger change (`ours` 23 → 22, `inline` 16 → 15, `takes` by the new theorem's pairs); (5) the
  vacuity scan: no colouring binder is new; `StablePrime F` and `IsUsablePrime` are the carriers to name models for
  (stage 2); (6) two new global instances (`instNumberFieldFieldOfRadicands`, `instNumberFieldBot`) — named, `Prop`-valued.
