# FS131-KM15 — the five-colour chain's instances, `ℚ(√47)` first: typed, priced, proved as far as reached

*de Bruijn, the planner and first prover of module M15 (brief `data/fs131/briefs/FS131-KM15-instances.md`, on `main`).
Branch `fs131-wm15`, cut from `fs131-wj` at `bda6a98f2`, in the worktree `.claude/worktrees/fs131-wq1`. Working files:
`data/fs131/km15/`.*

## Theorems this phase proved

(Filled as leaves fall; see the last stage.)

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_km15_quotes.py` reads every `>` block of the brief that has a `— source:` line, and looks for its text, with
whitespace collapsed, in the source. **6 of 6 found** (`data/fs131/km15/quotes.out`): Kooshi's word in
`data/fs131/REQUEST-2026-10-13.md`; NF2-LEAF-23 and NF2-NC in `data/fs131/claims-NF2.md`; inventory items 918, 905 and 908
in `plans/FS131-close-inventory.md`. The sources were read on `main` (`/home/kooshi/source/lean-dir`), because items 918, 905
and 908 are logged there and not in this tree. **Control:** `--plant` changes one character of the first quotation, and the
check reports it NOT FOUND and exits 1 (`quotes-plant.out`). No mismatch, so there is no finding about the brief.

### 1.2 The branch

`git checkout -b fs131-wm15` at `bda6a98f2` (`fs131-wj`'s head, "FS131-IJN1: the report"), 2026-10-14 20:26 UTC.

### 1.3 From the kernel (`data/fs131/km15/probes/ReadBack.lean`, output `ReadBack.out`, exit 0)

- **The headline** `Rigidity.min_localBound_five_le_chromaticNumber : ∀ (F : Subfield ℝ) [NumberField F],
  Plane.OneAvoidingDensityBound → (localBound F ≤ 4 → localBound F ≤ χ(F²)) → min (localBound F) 5 ≤ χ(F²)`. In words: for
  every real number field, given the density bound and row 99 at `L ≤ 4`, `χ(F²) ≥ min(L(F), 5)`. Axioms:
  `[propext, sorryAx, Classical.choice, Quot.sound, Rigidity.positive_entropy_rigidity, StandingFive.kloosterman_bound]`,
  as item 918 recorded.
- **`localBound F = ⨅ P : StablePrime F, (levelTarget P 1).chromaticNumber`**, valued in `ℕ∞`: the least chromatic number of
  a level-one target.
- **`StablePrime F`**: a structure holding an ideal `P` of `𝓞 (fieldI F)`, a proof that it is maximal, and a proof that
  `P.comap (conjO F) = P`. In words: a maximal ideal of the integers of `F(i)` that complex conjugation fixes.
- **`levelTarget P m = fromRel (fun x y => (x − y) · σ̄(x − y) = 1)`** on `𝓞 ⧸ P^m`, where `σ̄` is conjugation reduced mod
  `P^m` (`Ideal.quotientMap`). In words: the Cayley graph of the residue ring on its norm-one elements.
- `F47 = SquareClass.fieldOfRadicands {47}` (reducible). `NumberField F47` is the library's instance
  `QuadraticPrime.instNumberFieldFieldOfRadicands {47}` (`#synth`). The upper half
  `chromaticNumber_planeOver_sqrt47_le_five : χ(F47²) ≤ 5`.

### 1.4 § 2.7's reading, step by step, and what each step needs at this pin

`plans/FS131-KR1-chain-map.md` § 2.7 reads `5 ≤ L(ℚ(√47))` as follows. After each step: the names it reads, each
`#check`ed (`ReadBack.out`), and whether my route needs the step (§ 2.1 of stage 2 below; ruled by the coordinator).

1. *"`47 ≡ 7 (mod 8)` puts no stable prime above 2."* My route: `ω = (1 + i√47)/2` is integral
   (`StandingFive.isIntegral_of_sq_add`). It has `ω(1 − ω) = 12 ∈ 2𝓞` and `conj ω = 1 − ω`. A stable prime is prime
   (`Ideal.IsPrime.mem_or_mem`) and conjugation-closed (`UpperHalf.conjO_mem_iff`). **Needed.**
2. *"`3` and `7` are inert in `ℚ(√47)` (residue `𝔽_9`, `𝔽_49` already hold `i`, so they split in `L`)."* My route: at an
   odd stable prime the residue of `√47` is fixed by conjugation, so it lies in the fixed field
   (`StandingFive.card_fixed_of_involution`). That makes `47` a square modulo the residue characteristic `p`
   (`FiniteField.card'`, `StandingFive.mod_four_of_pow`, `pow_char_eq_of_sq_natCast`, `exists_natCast_of_pow_eq`,
   `CharP.natCast_eq_natCast`), which is false at 3 and at 7. **Needed**, in that form.
3. *"No odd prime ramifies in `L/F`."* **Not needed.** M13's odd branch never reads ramification.
4. *"So every stable prime lies over a `p ≡ 3 (mod 4)` with `(47/p) = 1` or `p = 47`, residue `𝔽_{p²}`."* The
   classification is the brief's statement of its own. The step `Q = p` reads the norm: `Ideal.absNorm_dvd_absNorm_of_le`,
   `Ideal.absNorm_span_natCast`, `RingOfIntegers.rank`, `LinearMap.finrank_le_finrank_of_surjective` with
   `SpectralChain.toFieldI_surjective`, `Module.finrank_prod`, `Nat.dvd_prime_pow`. **Typed for the brief; the composition
   reads only steps 1–2.**
5. *"The floor needed is `χ(Γ_p) ≥ 5` at `p ∈ {11, 19, 23, 31}` and at every `p ≥ 43` (Weil)."* These are M13's
   residue-size facts, read through the public theorem `ratioAtMost_of_two_notMem` that M13's line adds (ruling of
   2026-10-14). The level-one ratio then gives the colour count: `Coloring.isIndepSet_colorClass`,
   `Finset.exists_le_card_fiber_of_mul_le_card_of_maps_to`, `add_one_le_chromaticNumber_iff_not_colorable`.
   `Coloring.color_classes_independent` is deprecated at the pin. **Needed.**
6. *Composition:* the headline and `chromaticNumber_planeOver_sqrt47_le_five`. **Needed.**

## Stage 2 — SAVED: the statements typed, the two passes

### 2.1 The route (ruled by the coordinator, 2026-10-14)

M13's per-prime leaves read a stable prime only through `2 ∉ P` and `|𝓞 ⧸ P| = Q²`, `Q ∉ {3, 7}`. So M15 computes no
ramification or inertia. It needs three integers of `F(i)` (`√a`, `i`, `ω = (1 + i√a)/2`) and one public fact from M13's
line, `Rigidity.ratioAtMost_of_two_notMem`. That fact is added to `Rigidity/ClassRatio` by FS131-ICM3, with the statement
I sent, verbatim. Here it is the private `sorry` link `ratioAtMost_two_notMem_link`; the join deletes it and points its
one reader at M13's name. The coordinator also ruled that M15 types the general form over D:116's class, with the fields
as corollaries, and the equivalence `TCA F ↔ 5 ≤ L(F)`.

### 2.2 Two modules (elaborated against a farm, `data/fs131/km15/farm.sh`; logs `logs-A4.txt`, `logs-B3.txt`: exit 0, no warning but `sorry`)

**`Rigidity/SqrtClassFive`** (imports `Rigidity/ChainHeadline`). Its statements, as the kernel stores them
(`probes/Sigs.out`), read aloud:

| declaration | read aloud |
|---|---|
| `add_one_le_chromaticNumber_of_indep_le` (private) | a finite nonempty graph whose independent sets hold at most `c·|V|` vertices, `k·c < 1`, needs `k + 1` colours |
| `five_le_chromaticNumber_of_ratioAtMost` | at a stable prime with all-levels ratio `c < 1/4`, the level-one target needs five colours |
| `five_le_localBound_of_tca`, `tca_iff_five_le_localBound` | T-C(A) gives `L(F) ≥ 5`; with M13's CLS, T-C(A) ⟺ `L(F) ≥ 5` |
| `ratioAtMost_two_notMem_link` (private, `sorry`) | M13's `ratioAtMost_of_two_notMem`: an odd stable prime with `|𝓞⧸P| ∉ {9, 49}` has ratio `< 1/4` |
| `five_le_chromaticNumber_of_two_notMem` | an odd stable prime with `|𝓞⧸P| ∉ {9, 49}` has a level-one target needing five colours |
| `exists_sqrt_integer`, `exists_I_integer`, `exists_omega_integer` (private) | `r ∈ F` with `r² = d` is an integer of `F(i)` fixed by conjugation; `i` with `ī = −i`; `ω = (1 + ir)/2` with `ω(1−ω) = (a+1)/4`, `ω̄ = 1 − ω` when `a ≡ 3 (mod 4)` |
| `two_notMem_of_isSquare` | if some `a ≡ 7 (mod 8)` is a square in `F`, no stable prime holds 2 (no `NumberField` needed) |
| `stablePrime_card_of_two_notMem` | an odd stable prime lies above a prime `p ≡ 3 (mod 4)`; its residue field has `(pⁿ)²` elements with `n` odd; every natural number that is a square in `F` is a square mod `p` |
| `five_le_chromaticNumber_of_isSquare`, `five_le_localBound_of_isSquare` | squares in `F` of some `a ≡ 7 (mod 8)`, some `b ≡ 2 (mod 3)`, some `c` not a square mod 7 give five colours at every stable prime, so `L(F) ≥ 5` |
| `five_le_localBound_of_isSquare_class` | D:116's class: one `d ≡ 47, 143, 167 (mod 168)` square in `F` gives `L(F) ≥ 5` |
| `five_le_chromaticNumber_planeOver_of_five_le_localBound` | `L(F) ≥ 5` and `hOA` give `χ(F²) ≥ 5` (the headline; its row-99 hypothesis idle) |

**`Instances/SqrtFortySevenFive`** (imports `Rigidity/SqrtClassFive`, `Instances/SqrtFortySeven`):
`numberField_F47` (the library's instance, by `inferInstance`); `finrank_fieldI_F47_le : [ℚ(√47, i) : ℚ] ≤ 4`;
`isSquare_fortySeven : IsSquare (47 : F47)` (proved); **`stablePrime_card_sqrt47`** — every stable prime of
`ℚ(√47, i)` has `p²` residues, `p` prime, `p ≡ 3 (mod 4)`, `47` a square mod `p`; `exists_stablePrime_eleven` — a stable
prime holding 11 (the model); **`five_le_localBound_sqrt47`** (proved over the leaves); **`chromaticNumber_planeOver_sqrt47_eq_five`
: Plane.OneAvoidingDensityBound → χ(ℚ(√47)²) = 5** (proved over the leaves). Its axioms, from the farm:
`[propext, sorryAx, Classical.choice, Quot.sound, Rigidity.positive_entropy_rigidity, StandingFive.kloosterman_bound]`.

**Read against NF2-LEAF-23 and § 2.7.** "`NumberField` for `ℚ(√47)`'s `Subfield ℝ`": `numberField_F47`. "Every stable
prime of `ℚ(√47, i)` and its target": `stablePrime_card_sqrt47` names the residue size, `p²`. The target at such a prime
is `Γ_p` by `StandingFive.normOneCayley`'s reading; no isomorphism with `finitePlane p` is stated, because no consumer
reads one. § 2.7's list `p ∈ {11, 19, 23, 31}`, `p ≥ 43` is the statement's `p ≡ 3 (mod 4)` with `47` a square mod `p`,
minus `3` and `7` (spec: `IsSquare (47 : ZMod p)` at `11, 19, 23, 31, 43, 47`, not at `3, 7`). "`5 ≤ localBound`":
`five_le_localBound_sqrt47`. `χ(ℚ(√47)²) = 5` "over the density bound as a hypothesis at most": exactly `hOA`.
`hRow99` is discharged inside `five_le_chromaticNumber_planeOver_of_five_le_localBound`, since `L ≥ 5` refutes `L ≤ 4`
(ruling 918 (2)).

### 2.3 Models

- `StablePrime F47`: `exists_stablePrime_eleven` (a leaf; `1/11 ∉ ℤ[U]` because every unit vector is 11-integral,
  `unit_mem_A`, then `UpperHalf.inv_natCast_mem_unitRingOver_iff_forall_stablePrime`). It makes the classification and the
  floor non-vacuous.
- `five_le_chromaticNumber_of_isSquare`'s hypotheses at once: `F47` with `a = b = c = 47` (`isSquare_fortySeven`; the
  class spec) and the stable prime above 11.
- `five_le_chromaticNumber_of_ratioAtMost`'s hypotheses: the stable prime of `F47` above 11, where `c < 1/4` is M13's
  (through the link: no sorry-free model exists today; the theorems that give a ratio sorry-free, `ratioAtMost_weil` at
  `Q ≥ 35`, are private to `ClassRatio`).
- `add_one_le_chromaticNumber_of_indep_le`: the graph with one vertex and no edge, `k = 0`, `c = 1`.
- `hOA`: an outside theorem (`Plane.oneAvoidingDensityBound_model` models its clause).

### 2.4 The domain pass (`debruijn-domain-modeling`, fresh; commit `c2…` below) — no new definition; what it changed

1. **Three radicands, not one.** The class's three conditions are each read once, by a different step: `a ≡ 7 (mod 8)`
   by the dyadic step, `b ≡ 2 (mod 3)` against residue size 3, `c` a non-square mod 7 against 7. Bundling them into one
   `d` was incidental to the quadratic case. The general statement takes three squares of `F`; D:116's class is
   `a = b = c = d`. The widening reaches `ℚ(√3, √5)` (D:301) with `a = 15`, `b = 5`, `c = 3` — sent to the coordinator as
   a generalization.
2. **"`d` is a square in `F`" (`IsSquare (d : F)`), not `Real.sqrt d ∈ F`.** The proof reads only `r² = d` and
   `r̄ = r`; `Real.sqrt` was incidental.
3. **"A square mod `p`" as `IsSquare (d : ZMod p)`**, Mathlib's language and `UpperHalfValues`'s, not
   `∃ c, c·c ≡ d [MOD p]`; it is decidable (`Data/Fintype/Parity`), so the spec checks it by `decide`.
4. Kept: the class written inline (`d % 168 = 47 ∨ …`) — no definition with one reader; the residue size as
   `(pⁿ)²` with `Odd n`; the link's `≠ 9`, `≠ 49` (ruled).

### 2.5 The obligation pass (`debruijn-obligation-modeling`, fresh) — children and the hypotheses each proof reads

1. `five_le_chromaticNumber_of_ratioAtMost` reads `RatioAtMost` at `m = 1` only, and `[NumberField F]` for the finite
   quotient (`Ideal.finiteQuotientOfFreeOfNeBot`, `StablePrime.heightOne`). Its child is a graph fact, stated once at
   every `k` (private `add_one_le_chromaticNumber_of_indep_le`): the colour classes partition `V`
   (`Finset.card_eq_sum_card_fiberwise`), each is independent (`Coloring.isIndepSet_colorClass`), so
   `|V| ≤ k·c·|V| < |V|`. Mathlib has no `χ·α ≥ |V|` at the pin (searched `Combinatorics/SimpleGraph`).
2. `two_notMem_of_isSquare` reads `ha`, `h8`, and `P` prime and conjugation-closed; **no `NumberField`** (dropped from
   the skeleton's draft).
3. `stablePrime_card_of_two_notMem`'s children: (a) the residue field `k` with `σ̄` (`Ideal.quotientMap`,
   `UpperHalf.conjO_conjO`); (b) `ῑ² = −1`, `σ̄ῑ = −ῑ`, `2 ≠ 0`; (c) `card_fixed_of_involution`; (d) `FiniteField.card'`
   on the fixed field `K₀`, then `mod_four_of_pow`; (e) per `d`, the residue of `r` in `K₀`, then `pow_char_eq_of_sq_natCast`,
   `exists_natCast_of_pow_eq`, `CharP.natCast_eq_natCast`. **Strengthened by the pass:** it now also says that `P` lies
   above `p` (`(p : 𝓞) ∈ P.P`), which the instance's degree step reads and which `CharP K₀ p` gives for free.
4. `five_le_chromaticNumber_of_isSquare` reads every hypothesis. Mutation audit, by known residue fields ([hand], one
   mind): drop `h8` — `ℚ(√5)` (`b = c = 5`) has a stable prime above 2 ramified in `F(i)/F`, target two-colourable, so
   `L ≤ 2`; drop `h3` — `ℚ(√31)` (`a = c = 31`): 3 splits in `ℚ(√31)` and each prime is inert in `F(i)`, so
   `Q = 3` and `L ≤ 4`; drop `h7` — `ℚ(√23)` (`a = b = 23`, `23 ≡ 2 ≡ 3² (mod 7)`): `Q = 7`, `L ≤ 4`. **Each hypothesis
   is load-bearing.**
5. `stablePrime_card_sqrt47`: from 2–3 with `a = 47`. Then `n = 1` by the norm: `absNorm P ∣ absNorm (p) =
   p^[L:ℚ]` (`Ideal.absNorm_dvd_absNorm_of_le`, `absNorm_span_natCast`, `RingOfIntegers.rank`), `[L:ℚ] ≤ 4`
   (`finrank_fieldI_F47_le`), so `2n ≤ 4` (`Nat.pow_dvd_pow_iff_le_right`) and `n` is odd.
6. `exists_stablePrime_eleven`: (a) `ℤ[U] ⊆` the subring of `z` whose two coordinates lie in `A` (`Subring.closure_le`,
   `unit_mem_A`); (b) so `1/11 ∉ ℤ[U]` (`re47 (1/11) = 1/11 ∉ z11`); (c) `inv_natCast_mem_unitRingOver_iff_forall_stablePrime`.
7. The prove / test / assume partition: **prove** every statement above; **test** the spec lines (the class, squares
   mod `p`); **assume** `hOA` (an outside theorem, the headline's) and the link (M13's, by ruling).

**Binders, from the kernel** (`probes/Sigs.out`): every `[NumberField F]` stored is read by its proof's children
(finiteness of a residue ring, or M13's theorem). No section `variable` carries an instance. No definition or instance is
new.
