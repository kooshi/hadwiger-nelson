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
