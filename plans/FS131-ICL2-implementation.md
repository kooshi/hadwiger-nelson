# FS131-ICL2 — the count's lanes joined with the chain's line; the finite side (Λ2) and the completion (Λ3)

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-ICL2-count-finite-completion.md` (on `main`). Branch `fs131-wcl2`,
cut from the chain's line at `1e438c171` with `fs131-wcl` merged into it, in the tree `.claude/worktrees/fs131-wch`. Working
files: `data/fs131/icl2/`. Report: `data/fs131/reports/FS131-ICL2.md`. Commits by explicit path, not pushed (the brief: the
server is unreachable).*

## Theorems this phase proved

Read from the built tree after build 2 (`data/fs131/icl2/axioms.out`, `axioms-read.out`): 120 records of the five files,
**CLEAN 112** (the standard three or fewer), **UPSTREAM 8** (`sorryAx` only through named leaves), **FAIL 0**. Grade
[kernel] where clean; "[kernel, over named leaves]" otherwise, the leaves named.

- `Rigidity/FiniteZhang`: `card_le_mul_card_closedNbhd`, `ratioLe_prod` (`[Zhang2012]` Thm 1.8's count, two finite
  factors), `ratioLe_pi`, `ratioLe_subgroup` — [kernel], the standard three.
- `Rigidity/CountResidue`: `ofUnitRing_mem_localRing`, `isIndepSet_levelTarget_iff`, `neg_mem_normOneQ`, `finite_quot`,
  `ratioLe_normOneQ`, `exists_normOneL_residue` and `exists_normOneL_residues` (`[S9]`, Hilbert 90 modulo `P^m`),
  `exists_unitRing_of_normOneL`, `exists_mem_nsmul_of_resR_eq_zero` (Lemma C (d)), `resR_eq_zero_of_le`, `mem_level`,
  `exists_level_mem_nsmul` — [kernel], the standard three; `image_levR_unitVectors`, `ratioLe_levR_range` — [kernel, over
  named leaves]: `Rigidity.noRamifiedStableDyadic_of_tca` (lane M9-S).
- `Rigidity/CountTorus`: `mem_normOneL_iff`, `Delta_ratCast`, `Delta_circle_mem_closure`, `mem_closure_pow` (weak
  approximation by `h`-th powers), `Delta_circle_mul_mem_closure_pow`, `pow_mem_normOneL`, `mul_mem_normOneL` — [kernel], the
  standard three.
- `Rigidity/CountCompletion`: `CompactSpace (K F)`, `continuous_proj`, `range_proj`, `proj_eq_zero_of_le`,
  `hasBasis_nhds_zero_K`, `IsProbabilityMeasure (haarK F)`, `IsAddLeftInvariant`, `haarK_proj_preimage`, `denseRange_ιG`,
  `mem_closure_ιG` — [kernel], the standard three. **Open:** `tendsto_haarK_bad`.
- `Rigidity/CountDescent`: `measurableSet_levelRows`, `volume_colour_le` — [kernel], the standard three;
  `rowsEdgeNull_levelRows` (statement repaired by ruling) — [kernel, over named leaves]: `noRamifiedStableDyadic_of_tca`;
  `tendsto_bad` — over `tendsto_haarK_bad`; `false_of_slice` — over `tendsto_haarK_bad`, `noRamifiedStableDyadic_of_tca`,
  `Rigidity.tca_uniform` (M13); **`count_of_oneAvoidingDensityBound`** — over those three and
  `Plane.upperDensity_le_of_oneAvoidingDensityBound` (the density bound's job).

## Stage 1 — SAVED: the merge, the readback, and the stored statements before any edit

### 1.1 The quotations (standing rule 3)

`tools/fs131_icl2_quotes.py` (FS131-ICL1's checker with this brief's path) requires each block quotation of the brief, the
`> ` prefix and a list marker removed, as one whole line of its source on `main`'s working tree. Output
`data/fs131/icl2/quotes.out`: **7 quotations, 7 IDENTICAL** — W2 (`data/fs131/REQUEST-2026-10-13.md`), the two dated lines of
2026-10-14 (`data/fs131/claims-NF2.md`), inventory items 832, 847, 863 and 871 (`plans/FS131-close-inventory.md`). Control
(`--plant`, `data/fs131/icl2/quotes-plant.out`): one character changed in each quotation in memory, **7 of 7 reported**.

### 1.2 The merge, and one build

`git checkout -b fs131-wcl2 1e438c171`, then `git merge --no-ff fs131-wcl` (commit `807810605`): **no conflict anywhere** —
`ARCHITECTURE.md` merged by `ort` on its own (the two sides touched different rows) and `Proofs.lean` was touched by neither
side. The merged sources hold no reader of the deleted `Counting.toL` (`grep`: the one `toL` left in `Proofs/` is
`StandingFive.toL`, another declaration). Build 1 under the slot (`--mem 10 --cpus 4`, `MEMMAX=10G BATCH=8
./scripts/build.sh`; `data/fs131/icl2/logs/build-1.log`, full output `build/gate/build/20261014T155443Z-3735757.log`):
**OK — 256 of 256 batches, 23 modules rebuilt, 15 with warnings, 8 m 22 s, exit 0**. One line sent to the coordinator.

*Slip:* the merge commit's message carries no attribution lines (written with `-m` before I wrote any other); standing rule 6
forbids amending, so it stays, and every later commit carries them.

### 1.3 The stored statements, dumped before any edit

`data/fs131/icl2/lean/StatementDump.lean` (FS131-ICL1's dumper over this job's five modules: every constant of their compiled
data — kind, stored type with its hash, a definition's stored value, a pretty print with full names), run by `lake env lean`:

- `data/fs131/icl2/statements-0-wcl-compiled.txt` — the tree as given, before the merge build replaced any `.olean`
  (`fs131-wcl`'s compiled library): 140 constants.
- `data/fs131/icl2/statements-before.txt` — **the base of this job**: the merged tree after build 1, before any edit:
  136 constants (FiniteZhang 9, CountTorus 13, CountResidue 70, CountCompletion 33, CountDescent 11), 78 public.

**The merge, from the kernel's side** (`tools/fs131_icl2_statements.py` on the two dumps; `data/fs131/icl2/statements-merge.out`):
74 public constants SAME; `Counting.toL` MISSING (deleted), `toL_mem_localRing` MISSING and `ofUnitRing_mem_localRing` ADDED
(renamed), and three CHANGED — `exists_unitRing_of_normOneL` (type), `toLocal` (type and value), `ιG` (type and value) — each
**identical to its old stored term once `Counting.toL` is read as `Rigidity.ofUnitRing` and `toL_mem_localRing` as
`ofUnitRing_mem_localRing`** (`data/fs131/icl2/statements-merge-rename.out`). So the merge moved nothing in these five files but
FS131-IJ1's ruled replacement (item 863).

**Class binders against their sections** (item 847's defect; `fs131_icl2_statements.py --binders-only`,
`data/fs131/icl2/binders-before.out`). The check reads a *binder* whose type is the class (` : NumberField.{0} (…)` in the raw
print). Its first version tested for the word `NumberField` anywhere and passed `finite_quot`, whose type mentions
`NumberField.RingOfIntegers` — exactly the shape that hid item 847's defect. The control (`--plant`, `data/fs131/icl2/statements-plant-selftest.out`) now plants that shape — the binder's class removed, the mention `NumberField.RingOfIntegers` kept — and the comparator's three other plants (a character of a stored type, a constant dropped, a public constant added): **4 of 4 fired**. The merge-rename check's control (`statements-merge-rename-plant.out`): one character of a renamed field, **fired**. Ten
misses among 78 public constants, each classed:

| constant | module | miss | class |
|---|---|---|---|
| `SIndep`, `RatioLe` | FiniteZhang | `Finite G` | definitions, whose bodies read no finiteness (`Nat.card`); every theorem that reads them binds `Finite` — by design |
| `iL`, `normOneL`, `mem_normOneL_iff` | CountTorus | `NumberField` | declared above the module's `variable [NumberField F]`; `mem_normOneL_iff` (`x x̄ = 1 ⟺ x ∈ U`) is true over every subfield — by design |
| `Delta` | CountTorus | `NumberField` | a definition with a body (no `sorry`) that reads no number field (`mixedEmbedding` asks a field) — by design |
| `normOneQ`, `unitVectorsR` | CountResidue, CountCompletion | `NumberField` | definitions of sets, reading none — by design |
| `stablePrime_injective` | CountResidue | `NumberField` | proved, under `omit [NumberField F] in` — by design |
| **`finite_quot`** | CountResidue | `NumberField` | **the defect item 847 ruled** (a `sorry`-bodied instance; believed false as stored): repaired by its proof (stage 2) |

No other stored statement lacks a class binder its section declares: nothing to send.

### 1.4 The leaves, restated beside their plans (41 `sorry`s: FiniteZhang 4, CountResidue 14, CountDescent 5, CountTorus 7, CountCompletion 11)

*Each statement in one line as the kernel holds it (`statements-before.txt`'s pretty print); the plan is the planner's record
`plans/FS131-K12A-count.md` § 3.2, row by row.*

| module | leaf | statement | plan |
|---|---|---|---|
| FiniteZhang | `card_le_mul_card_closedNbhd` | `S` symmetric, `RatioLe S c`, `I` independent ⟹ `|I| ≤ c·|N[I]|` | a maximum independent `J`, translates; the scratch leaf `LeafZ` |
| | `ratioLe_prod` | both factors symmetric of ratio `≤ c` ⟹ `RatioLe (S₁ ×ˢ S₂) c` | rows, lonely/social points, the neighbourhood ratio twice (Zhang) |
| | `ratioLe_pi` | `0 ≤ c`, each factor symmetric of ratio `≤ c` ⟹ ratio `≤ c` on `∏ H i` with `{d | ∀ i, d i ∈ S i}` | induction on the finite index |
| | `ratioLe_subgroup` | `S ⊆ A`, `RatioLe S c` in `G` ⟹ `RatioLe {d : A | ↑d ∈ S} c` | translate by a transversal; `|G| = [G:A]|A|` |
| CountResidue | `ofUnitRing_mem_localRing` | `ofUnitRing F r ∈ P.localRing` | `ofUnitRing_mem_stableIntegers`, `mem_stableIntegers` (item 863) |
| | `isIndepSet_levelTarget_iff` | `1 ≤ m`: `(levelTarget P m).IsIndepSet s ↔ SIndep (normOneQ P m) s` | `fromRel_adj`; `0 ∉ normOneQ` at `m ≥ 1` |
| | `neg_mem_normOneQ` | `x ∈ normOneQ ⟹ -x ∈ normOneQ` | `map_neg`, `neg_mul_neg` |
| | `finite_quot` | `Finite (𝓞 L ⧸ P^m)` (stored without `[NumberField F]`: item 847) | `Ideal.finiteQuotientOfFreeOfNeBot`, `P^m ≠ ⊥` |
| | `ratioLe_normOneQ` | `RatioAtMost P c`, `1 ≤ m` ⟹ `RatioLe (normOneQ P m) c` | the iff above |
| | `exists_normOneL_residue` | `¬ IsRamified P`, `s ∈ normOneQ P m` ⟹ `∃ x ∈ normOneL, res_m x = s` | Hilbert 90 mod `P^m`; the scratch leaf `LeafR` |
| | `exists_normOneL_residues` | the same jointly at a finite `Φ` of unramified stable primes | CRT (`exists_forall_sub_mem_ideal`) for `a` and for `w` |
| | `exists_unitRing_of_normOneL` | `x ∈ normOneL` ⟹ `∃ r : R, ofUnitRing r = x ∧ ↑r ∈ U` | `mem_normOneL_iff`, `unitVectors_subset_unitRing` |
| | `exists_mem_nsmul_of_resR_eq_zero` | `N ≠ 0` ⟹ `∃ Φ m, ∀ r, (∀ P ∈ Φ, resR P m r = 0) → ∃ y, r = N • y` | `c·O′ ⊆ R`; valuations at the primes over `N c` |
| | `resR_eq_zero_of_le` | `m ≤ k`, `resR P k r = 0` ⟹ `resR P m r = 0` | `Ideal.Quotient.factor` through the localization |
| | `mem_level` | `P ∈ level F k ↔ absNorm P.P ≤ k` | `Set.Finite.mem_toFinset` |
| | `exists_level_mem_nsmul` | `N ≠ 0` ⟹ `∃ k, ∀ r, levR F k r = 0 → ∃ y, r = N • y` | the Lemma above at `k` past `m` and every norm in `Φ` |
| | `image_levR_unitVectors` | `TCA F` ⟹ `levR F k '' U = normOneLev F k` | `residue_conj` (⊆); `exists_normOneL_residues` (⊇) |
| | `ratioLe_levR_range` | `TCA F`, `0 ≤ c`, `∀ P, RatioAtMost P c`, `1 ≤ k` ⟹ ratio `≤ c` on `(levR F k).range` with `normOneLev` | `ratioLe_pi`, `ratioLe_subgroup` |
| CountDescent | `measurableSet_levelRows` | `Measurable φ` ⟹ `MeasurableSet (levelRows φ j k q)` | `measurable_measure_prodMk_left` |
| | `rowsEdgeNull_levelRows` | `Measurable φ`, `SliceEdgeNull φ` ⟹ `RowsEdgeNull normOneLev (levelRows φ j k)` | Haar translation by `ιK u`; two fills `> 3/4` share `> 1/2`; Tonelli |
| | `volume_colour_le` | window measure of colour `j` `≤ |range|⁻¹ Σ_q λ(rows_q ∩ W) +` the badly filled points | Tonelli; `haarK_proj_preimage` |
| | `tendsto_bad` | the badly filled points of a window `→ 0` as `k → ∞` | `tendsto_haarK_bad` at `κ = 1/4`, dominated convergence |
| | `false_of_slice` | `TCA F`, `m₁ < 1/4`, `φ` measurable with null slice edges ⟹ `False` | `tca_uniform`, `exists_nrWindow`, `sum_volume_inter_sq_le` at a level |
| CountTorus | `mem_normOneL_iff` | `x ∈ normOneL F ↔ ↑x ∈ unitVectors F` | `Complex.mul_conj`, `normSq` |
| | `Delta_ratCast` | `Δ(q₁ + q₂ i) = e(q₁ + q₂ i)` | additivity of `mixedEmbedding` |
| | `Delta_circle_mem_closure` | `Δ(e^{iθ}) ∈ closure (e '' normOneL)` | rational points of the circle |
| | `mem_closure_pow` | `x ∈ normOneL`, `1 ≤ h` ⟹ `e x ∈ closure (e '' ((·^h) '' normOneL))` | weak approximation by `h`-th powers (the block's hard leaf) |
| | `Delta_circle_mul_mem_closure_pow` | `Δ(e^{iθ})·e x ∈ closure (e '' ((·^h) '' normOneL))` | the closure of a submonoid |
| | `pow_mem_normOneL`, `mul_mem_normOneL` | closure of `normOneL` under powers and products | `map_pow`, `map_mul` of `conjOn` |
| CountCompletion | `CompactSpace (K F)` | `K F` is compact | the scratch leaf `LeafK` |
| | `continuous_proj` | `Continuous (proj F k)` | `continuous_apply` on the subtype |
| | `range_proj` | `range (proj F k) = range (levR F k)` | clopen preimage of the range holds the dense image |
| | `proj_eq_zero_of_le` | `k' ≤ k`, `proj k x = 0` ⟹ `proj k' x = 0` | a closed set holding `range ιK` |
| | `hasBasis_nhds_zero_K` | the level kernels are a basis at `0` | `nhds_pi`, `proj_eq_zero_of_le` |
| | `IsProbabilityMeasure (haarK F)`, `IsAddLeftInvariant` | Haar at `⊤` | `addHaarMeasure_self`; the scratch leaf `LeafK` |
| | `haarK_proj_preimage` | a level coset has measure `|range|⁻¹` | translates of one open subgroup |
| | `tendsto_haarK_bad` | for measurable `Y`, the points badly filled at level `k` `→ 0` | regularity and clopen cylinders (the block's hard leaf) |
| | `denseRange_ιG` | `DenseRange (ιG F)` | `M·R` dense in `L ⊗ ℝ`, `M ∈ P^k` |
| | `mem_closure_ιG` | `(Δ(e^{iθ}), ιK u) ∈ closure (ιG '' U)` | the exponent of the units of a level; `Delta_circle_mul_mem_closure_pow` |

## Stage 2 — SAVED: lane Λ2's first two modules — `Rigidity/FiniteZhang` (4 leaves) and `Rigidity/CountResidue` (14 leaves) proved

Both files hold no `sorry`; each compiles in the farm (`data/fs131/icl2/lean1.sh`: the tree's compiled library as symlinks,
the module written over its link, the lakefile's options and `linter.missingDocs`) with **exit 0 and no warning**
(`logs/fz-3.log`, `logs/cr-4.log`). The build that is evidence is stage 6's.

**`FiniteZhang`** (274 lines net, against block Z's 400–550). `card_le_mul_card_closedNbhd` is the planner's scratch leaf
`LeafZ`, folded in. `ratioLe_prod`, **the lane's opening leaf, green at the third elaboration**: J28D's count in finite form —
the rows `X b`, their lonely points `L b` (independent), the social columns `A a` (independent; the neighbourhood of `A a`
misses the touched columns `B a`), `|I| = Σ_b |L b| + Σ_a |A a|` and `Σ_b |N[L b]| = Σ_a |B a|` by indicator sums, then the
neighbourhood ratio in each factor. `ratioLe_pi` by `Finite.induction_empty_option`, the motive applied to `H S hS h` (a
`revert` made the implicit-lambda feature eat the motive's binders); the equivalence step through
`Equiv.piCongrLeft' H e.symm` (its `toFun` is a plain composition, so additivity is `rfl`) and the option step through
`Equiv.piOptionEquivProd` and `ratioLe_prod`. `ratioLe_subgroup` by the transversal `(i, q) ↦ i + q.out`. Private helpers:
`ratioLe_nonneg`, `ratioLe_of_addEquiv`, `card_eq_sum_ite`. **Two import lines added**, `Mathlib.Algebra.BigOperators.Ring.Finset`
(`Finset.mul_sum`) and `Mathlib.Tactic.Ring`; the stage-6 dump compares every stored statement across them.

**`CountResidue`** (≈250 lines net, against block R's 500–650). `ofUnitRing_mem_localRing` is `PlaceSizes`'
`ofUnitRing_mem_stableIntegers` written out (that module is not upstream of this one): `unitRing_le_stableIntegers` and
`mem_stableIntegers`. `[S9]` is the scratch leaf `LeafR` cut at its joints into four private helpers
(`mk_mem_normOneQ_iff`, `exists_add_mul_conj_notMem`, `sub_mul_conj_mem`, `div_conj_mem_normOneL`, `residue_div_conj`), which
`exists_normOneL_residues` reuses after two Chinese remainder steps (`IsDedekindDomain.exists_forall_sub_mem_ideal` at the
exponent `m` for the lift `a`, at the exponent `1` for `w`). **Lemma C (d)** by another route than the plan's valuations:
`M = N c` (`c·O′ ⊆ R`), `m = absNorm (M)`; then `M ∉ P^m` at every stable prime (`absNorm P ≥ 2`, `2^m > m`), and since
`𝓞_P` is a valuation ring, `r/M ∉ 𝓞_P` would put `M` in `r·𝓞_P`, whose residues are zero — so residues zero at the stable
primes of norm at most `m` put `r/M` in `O′` and `c·(r/M) = r/N` in `R`. `Φ` is that finite set, written out (the module's
`level` and `mem_level` are declared below the lemma, and nothing is moved). `finite_quot` by
`Ideal.finiteQuotientOfFreeOfNeBot` with `P^m ≠ ⊥` — **its stored type now binds `[NumberField ↥F]`** (`probes/FiniteQuot.out`;
item 847 ruling 2; stage 6 dumps it). One timeout met and named: `Finset.le_sup` unified at `Ideal.absNorm P.P` runs out of
heartbeats in `whnf` (`probes/LevelProbe2.lean`, `LevelProbe3.lean`); a bound stated for any function `f` first, then
instantiated, takes 2 s.

**Unread binders dropped (item 726's word), four statements of `CountResidue`:** `[NumberField F]` from
`isIndepSet_levelTarget_iff`, `neg_mem_normOneQ`, `ratioLe_normOneQ` and `exists_unitRing_of_normOneL` — each proof reads no
number field, and the build's `unusedSectionVars` linter warns on each with the binder kept. Stage 6 lists them from the
kernel's side.

**Re-priced from the lane's first two leaves** (`ratioLe_prod`, 130 lines in three elaborations; `card_le_mul_card_closedNbhd`,
73 lines, the scratch leaf): blocks Z and R came in at 0.4–0.7 of their planned lines (≈ 524 against 900–1,200). Λ2 was
planned at 1,350–1,900 lines; at that ratio it is **≈ 700–1,100 lines**, about half a day at the measured rate — far under a
week. Block D (`CountDescent`, measure theory over the completion) is next.

## Stage 3 — SAVED: lane Λ2 complete — `Rigidity/CountDescent` (5 leaves) proved; one statement defect found, ruled and repaired

`CountDescent` holds no `sorry` and compiles in the farm with **exit 0 and no warning** (`logs/cd-3.log`; ≈ 330 lines net,
against block D's 450–700). With stage 2, **lane Λ2 is done: 23 leaves in three files, ≈ 850 lines** (planned 1,350–1,900).

**The statement defect** (message to the coordinator, this stage). `rowsEdgeNull_levelRows` as typed —
`Measurable φ → SliceEdgeNull φ → RowsEdgeNull {d : (levR F k).range | ↑d ∈ normOneLev F k} (levelRows φ j k)` — is false
without `TCA F`: its connection set is all of `normOneLev ∩ range`, while `SliceEdgeNull` speaks only of translations by
`ιK u`, `u` a unit vector, i.e. of `levR k '' U`, and the two differ at a ramified stable prime. **Counterexample** (by hand,
one mind; nothing run): `F = ℚ` (`⊥`), `k = 4`. The only stable prime of norm `≤ 4` is `(1 + i)`, so
`Lev ℚ 4 = ℤ[i]/(1+i)^4 = ℤ[i]/(4)`. Its norm-one residues are the eight `a + bi` with `a² + b² ≡ 1 (mod 4)`; the residues of
true unit vectors are only `±1, ±i` (if `a''² + b''² = 1` 2-adically with `b''` even, then `a''² ≡ 1 (mod 8)` forces
`b'' ≡ 0 (mod 4)`). Let `c : ℤ[i]/4 → ZMod 4 ≅ Fin 4`, **`c(a + bi) = a + 2b`** — additive, nonzero on `±1, ±i`, zero at
**`s = 2 + i`** (in `normOneLev`: `4 + 1 ≡ 1`; in the range: `2 + i ∈ ℤ[i] ⊆ R`). Then `φ(z, x) = c(proj 4 x)` is measurable
and no slice edge along a unit vector is monochromatic (`φ` moves by `c(levR u) ∈ {±1, ±2}`), so `SliceEdgeNull φ` holds; at
colour `0` the rows `levelRows φ 0 4 0` and `levelRows φ 0 4 (2 + i)` are all of `ℂ` (each coset, of positive Haar measure,
is filled by colour `0`), and `pairSet ℂ ℂ` has infinite measure: `RowsEdgeNull` fails at `q = 0`, `s = 2 + i`.
**The coordinator's ruling** (by message, 2026-10-14): add `(hT : TCA F)` to the public statement and prove it — a ruled
statement change, dumped before and after (stage 6); the alternative `∀ P, ¬ IsRamified P` declined (`TCA F` is what the
reader holds and what `image_levR_unitVectors` takes). Done: the statement now opens `theorem rowsEdgeNull_levelRows
(hT : TCA F) {φ …}`, and its one reader, `false_of_slice`, passes its own `hT` (`rowsEdgeNull_levelRows hT hφ h j k`).

**The proofs.** `measurableSet_levelRows`: `measurableSet_lt` over the fibre measure `z ↦ haarK ({x : φ(z,x) = j} ∩ C)`
(private `measurable_haarK_fibre`, from `measurable_measure_prodMk_left`; cosets open, private `measurableSet_proj_preimage`).
`rowsEdgeNull_levelRows`: `s = levR k u` (`image_levR_unitVectors`); translation by `ιK u` carries the coset `q` onto `q + s`
and preserves `haarK` (`measure_preimage_add`, written as `g + x`); the colour-`j` fills of the coset `q` at `z` and of its
translate at `z + e θ` each exceed three quarters, so they cannot be almost disjoint (private `false_of_three_quarters`, in
`ℝ`), and their intersection is monochromatic slice edges at `u`; `((z, x), θ) ↦ ((z, θ), x)` is measure-preserving
(`measurePreserving_prodAssoc` twice and `measurePreserving_swap`), so `Measure.measure_ae_null_of_prod_null` makes almost
every `(z, θ)`-section null. `volume_colour_le`: a cover by the rows times their cosets and the bad points, each coset of
measure `1/n` (`haarK_proj_preimage`, `range_proj`), with `n` read as the subgroup's card through
`Equiv.subtypeEquivRight`; **it reads no measurability of `φ`** (outer measure only): the hypothesis is kept as stated and
touched once (`have _ := hφ`) so that the build's unused-variable linter stays quiet — the statement is true without it (a
generalization, INVENTORY). `tendsto_bad`: the bad sets are measurable (a finite union over the level-`k` residues), Tonelli
(`Measure.prod_apply`), each fibre is `tendsto_haarK_bad`'s set at `κ = 1/4` (`1 − 1/4 = 3/4` in `ℝ≥0∞`), dominated
convergence with bound `1` on the window. `false_of_slice`: as planned — `c = max (c₀, 0)` from `tca_uniform`,
`ε = (1 − 4 max (m₁, c))/16`, `s₀` from `Plane.exists_nrWindow`, a level `k ≥ 1` where every colour's bad points are under
`ε s₀²` (`eventually_all`), each colour `≤ (max (m₁, c) + 2ε) s₀²`, four colours fill `squareWin 0 s₀ × K` (measure `s₀²`).

## Stage 4 — SAVED: lane Λ3's first module — `Rigidity/CountTorus` (7 leaves) proved; block A re-priced

`CountTorus` holds no `sorry` and compiles in the farm with **exit 0 and no warning** (`logs/ct-8.log`; ≈ 510 lines net,
against block A's 600–900). **The opening leaf, `mem_closure_pow`, is green** (eight elaborations of the module, each ≈ 10 s).

**Route of `mem_closure_pow`** (the plan's, with the place bookkeeping made one lemma). For `h = 1` the point is its own
power; `−1 = i · i` from the case `x ≠ −1` (the closure of the `h`-th powers is a submonoid, private `powSubmonoid`); for
`x ≠ −1`, `h ≥ 2`: `x = (1 + i t₀)/(1 − i t₀)` with `t₀ = Im x / (1 + Re x) ∈ F`. Every place of `L = F(i)` is complex
(`isComplex_place`: `w(i)² = −1` has no real solution) and `w(i) = ±i` (`embedding_iL`). **One lemma carries the places**
(`exists_coord`): for each place `w` of `L`, with `φ = w ∘ ι` and `v = InfinitePlace.mk φ`, a continuous
`λ_w : mixedSpace F → ℂ` with `λ_w (e_F t) = w (ι t)` for `t ∈ F` — `a ↦ a.1 v` at a real `v`, `a ↦ a.2 v` or its conjugate at
a complex `v` as `InfinitePlace.embedding_mk_eq` says — and whose value at the one point `Ypt t₀ g` (the function
`g = cayRoot h` read at each place's embedding of `t₀`) is `g (w t₀)` or `conj (g (conj (w t₀)))`. The principal `h`-th Cayley
root `cayRoot h z = (ξ − 1)/(i(ξ + 1))`, `ξ = exp (log c / h)`, `c = (1 + iz)/(1 − iz)`, has `ξ ≠ −1` because
`cos (Im (log c)/h) ≥ 0` at `h ≥ 2` (`exp_div_ne_neg_one`), is real at real points (`cayRoot_im`: `|ξ| = 1` there), and in each
of the four cases (sign `±i`, root or conjugated root) its Cayley image to the `h` is the target (`cay_pow_eq`). Then
`Ψ(a) = (cayI (w i) (λ_w a))^h` is continuous at `Ypt t₀ g`, takes the value `e x` there, sends `e_F t` to `e (cay(t)^h)`, and
`F` is dense in its mixed space (`dense_range_mixedEmbedding`: rational multiples of `latticeBasis`, as `RingScope`'s density
does): `mem_closure_image`. No weak approximation for the torus in full, no root of `F`'s places chosen by hand.

**The others.** `mem_normOneL_iff` from `UnitRing.mem_normOne_conjOn_iff`; `Delta_ratCast` by `map_rat_smul`;
`Delta_circle_mem_closure` by the rational Cayley points (`Rat.denseRange_cast`) where `cos (θ/2) ≠ 0` and `e^{iθ} = −1 ∈ U`
where it vanishes; `Delta_circle_mul_mem_closure_pow` in the submonoid's closure; `pow_mem_normOneL`, `mul_mem_normOneL` by
`map_pow`, `map_mul`.

**Unread binders dropped (item 726's word), four statements of `CountTorus`:** `[NumberField F]` from `Delta_ratCast`,
`Delta_circle_mem_closure`, `pow_mem_normOneL`, `mul_mem_normOneL` (each proof reads no number field; the build's
`unusedSectionVars` linter warns otherwise). `mem_closure_pow` and `Delta_circle_mul_mem_closure_pow` keep it (the density of
`F` in its mixed space reads `latticeBasis`).

**Re-priced:** block A at ≈ 510 lines against 600–900 (0.6–0.85, the least favourable ratio of the job — the place
bookkeeping the planner flagged). Λ3 was 1,300–1,850; block K (`CountCompletion`, 11 leaves) is left, its hard leaf
`tendsto_haarK_bad`; at the job's ratios ≈ 400–650 lines. Nothing prices over a week.

## Stage 5 — SAVED: `Rigidity/CountCompletion`, ten of eleven leaves; the one leaf left; the model not reached

`CountCompletion` compiles in the farm with exit 0 and one warning, its open leaf's `declaration uses 'sorry'`
(`logs/cc-2.log`; ≈ 250 lines net for ten leaves). Proved: `CompactSpace (K F)` (the scratch leaf `LeafK`),
`continuous_proj`, `range_proj` and `proj_eq_zero_of_le` (each a closed set of the product holding the diagonal image of `R`:
every set of a discrete level is clopen; private `mem_closure_range`), `hasBasis_nhds_zero_K` (`mem_nhds_subtype`, `nhds_pi`,
`Filter.mem_pi`, a bound on the finite index set and `proj_eq_zero_of_le`), `IsProbabilityMeasure (haarK F)` (`LeafK`),
`IsAddLeftInvariant`, `haarK_proj_preimage` (the cosets are translates, finitely many, covering `K`:
`measure_biUnion_finset`, `ENNReal.eq_inv_of_mul_eq_one_left`), `denseRange_ιG` (private `exists_coset_subset`: a
neighbourhood of `κ` holds a level coset of `κ`; `r = r₀ + M s` with `M = |Lev F k|`, which kills every level-`k` residue,
`card_nsmul_eq_zero'`, and `dense_mixedEmbedding_nsmul_unitRing` at `N = M`) and `mem_closure_ιG` (`h = Monoid.exponent
(Lev F k)ˣ`, positive as the group is finite; a unit vector `v` with `e(u) e(v)^h` near `Δ(e^{iθ})` from
`Delta_circle_mul_mem_closure_pow` at `ū`; `levR k v` is a unit, its inverse the residue of `v̄`, so `levR k (u v^h) = levR k u`).

**Left open: `tendsto_haarK_bad`** (block K's hard leaf; statement unchanged), with the route I would take — the plan's,
made precise. (0) The bad set is monotone in `κ` (`1 − κ` grows as `κ` falls), so take `κ ≤ 1`. (1) Given `δ > 0`: a compact
`C ⊆ Y` and an open `U ⊇ Y` with `haarK (Y \ C) < δ`, `haarK (U \ Y) < δ` (`haarK` is a Haar measure on a compact
second-countable group, so regular: `MeasurableSet.exists_isCompact_diff_lt`, `MeasurableSet.exists_isOpen_diff_lt`).
(2) Each `x ∈ C` has a level coset `x + ker proj_{k_x} ⊆ U` (`exists_coset_subset`, now in the file); finitely many cover `C`
(`IsCompact.elim_finite_subcover`); `Z` their union, `k₀` the largest level. (3) For `k ≥ k₀` a level-`k` coset meeting `Z`
lies in `Z` (`proj_eq_zero_of_le`). (4) A bad point is in `Y \ Z ⊆ Y \ C` (measure `< δ`) or in a bad coset inside `Z`; on a
bad coset `D`, `κ·haarK D ≤ haarK (D \ Y)`, and the bad cosets inside `Z` are disjoint with `D \ Y ⊆ U \ Y`, so their union
has measure `≤ δ/κ`. (5) So the bad set at every `k ≥ k₀` has measure `≤ δ + δ/κ`: `ENNReal.tendsto_atTop_zero`. Price, at
this job's measured rate: 150–250 lines, under an hour.

**The model at the rationals** (`Rigidity/CountModels`, an `InvariantColouring` at `F = ℚ`, the last implementer's § 6.2
route): **not reached** — I stopped for the gate at a context reading near the brief's line. Nothing of it is written; the
module is not created and the build's lists are untouched. The `NumberField ⊥` instance it needs is the library's
`UpperHalfValues.instNumberFieldBot` (`Instances/UpperHalfValues`), which the count's modules do not import.

## Stage 6 — SAVED: build 2, the statements from the kernel's side, the axioms, the drafts

**Build 2** (`data/fs131/icl2/logs/build-2.log`, full output `build/gate/build/20261014T165056Z-3908851.log`): **OK — 256 of
256 batches, 8 modules rebuilt, 7 m 44 s, exit 0**. The one warning from the five files is
`Rigidity/CountCompletion.lean:180:8: declaration uses 'sorry'` — `tendsto_haarK_bad`, the open leaf. `tools/check_architecture.py`:
**PASS** (`logs/architecture.log`), the five rows' state cells rewritten.

**No statement and no definition changed but the ruled ones, from the kernel's side.** The dump after build 2
(`statements-after.txt.xz`, 247 constants) against stage 1's (`statements-before.txt.xz`), `tools/fs131_icl2_statements.py`:
**SAME 68, RULED 10, CHANGED 0, MISSING 0, ADDED-PUBLIC 0**, ADDED-INTERNAL 110 (private helpers and their generated names),
ADDED-GENERATED 1 (`closedNbhd.congr_simp`, generated in `FiniteZhang` itself) — `statements-compare.out`, PASS; with no
ruled list the same ten read CHANGED (`statements-compare-unruled.out`, FAIL (10)); the comparator's four plants all fire
(`statements-plant.out`). **Each ruled change is exactly what was ruled** (`tools/fs131_icl2_ruled.py`, `ruled.out`: 10 of 10
EXACT): eight `[NumberField F]` binders dropped (item 726: `isIndepSet_levelTarget_iff`, `neg_mem_normOneQ`,
`ratioLe_normOneQ`, `exists_unitRing_of_normOneL`, `Delta_ratCast`, `Delta_circle_mem_closure`, `pow_mem_normOneL`,
`mul_mem_normOneL`), `finite_quot` gaining `[NumberField ↥F]` (item 847 ruling 2) and `rowsEdgeNull_levelRows` gaining
`TCA F` (the coordinator's ruling of this job) — each stored type equal, character for character, to the other dump's with that
one binder struck; the control strips nothing and all ten read DIFFERS (`ruled-plant.out`). The stored types before and
after, for the two ruled additions:
- `finite_quot` before: `∀ {F : Subfield ℝ} (P : StablePrime F) (m : ℕ), Finite (𝓞 ↥(fieldI F) ⧸ P.P ^ m)`; after:
  `∀ {F : Subfield ℝ} [NumberField ↥F] (P : StablePrime F) (m : ℕ), Finite (𝓞 ↥(fieldI F) ⧸ P.P ^ m)`.
- `rowsEdgeNull_levelRows` before: `∀ {F} [NumberField ↥F] {φ : ℂ × K F → Fin 4}, Measurable φ → SliceEdgeNull φ → ∀ (j : Fin 4)
  (k : ℕ), RowsEdgeNull {d | ↑d ∈ normOneLev F k} (levelRows φ j k)`; after: the same with `TCA F →` after the instance
  binder. Its one reader `false_of_slice` composes (build 2) and passes its own `hT` (`rowsEdgeNull_levelRows hT hφ h j k`).

**Axioms** (`data/fs131/icl2/lean/Axioms.lean`, FS131-ICL1's printer over the five modules; `tools/fs131_icl2_axioms.py`
with `--leaves Counting.tendsto_haarK_bad`): **120 records — CLEAN 112, UPSTREAM 8, FAIL 0** (`axioms-read.out`). The
eight: `count_of_oneAvoidingDensityBound` (`sorryAx` from `Plane.upperDensity_le_of_oneAvoidingDensityBound`,
`Counting.tendsto_haarK_bad`, `noRamifiedStableDyadic_of_tca`, `tca_uniform`), `false_of_slice` (the last three),
`tendsto_bad` and `tendsto_haarK_bad` itself (the open leaf), `image_levR_unitVectors`, `ratioLe_levR_range`,
`ratio_unramified_of_tca`, `rowsEdgeNull_levelRows` (each `noRamifiedStableDyadic_of_tca` only). Control
(`AxiomsPlant.lean`: a planted `sorry` and a planted axiom, counted as this job's): **2 of 2 read FAIL**
(`axioms-plant-read.out`). Not run by this job: `scripts/dupnames.sh` and `lake lint` (no public name was added; the landing
runs both on the joined tree).

### Drafts for the landing

**The audit block for the five files** (for `scripts/Axioms.lean`, by the landing): `Rigidity/FiniteZhang`,
`Rigidity/CountTorus`, `Rigidity/CountResidue` — every record CLEAN once `noRamifiedStableDyadic_of_tca` lands (now
UPSTREAM through it at `image_levR_unitVectors`, `ratioLe_levR_range`, `ratio_unramified_of_tca`); `Rigidity/CountCompletion`
— CLEAN but `tendsto_haarK_bad` (open); `Rigidity/CountDescent` — CLEAN at `measurableSet_levelRows`, `volume_colour_le`;
the rest UPSTREAM as listed above. CLEAN in full only when `tendsto_haarK_bad`, `tca_uniform` (M13),
`noRamifiedStableDyadic_of_tca` (M9-S) and `Plane.upperDensity_le_of_oneAvoidingDensityBound` land.

**The models** (`LEAN.md` § The gate: every theorem whose hypothesis is a structure names its inhabitant): `ratioLe_prod`,
`ratioLe_pi`, `ratioLe_subgroup` — `RatioLe S 1` holds for every `S` (`ratioLe_one`, in the file); `exists_normOneL_residue`
— an inert `p ≡ 3 (mod 4)` of `ℚ(i)` at `F = ℚ` (the module docstring's model; the instance `NumberField ⊥` is
`UpperHalfValues.instNumberFieldBot`); `rowsEdgeNull_levelRows`, `volume_colour_le`, `tendsto_bad`, `false_of_slice` — a step
inside the count's proof by contradiction, refuted by `false_of_slice` itself under `TCA F`; and the ruled leaf's
counterexample at `F = ℚ`, `k = 4` (stage 3), which shows the hypothesis `TCA F` is needed and fails at `ℚ`. **The model owed
at `F = ℚ` (an `InvariantColouring`, item 871 ruling 2) is not written** (stage 5).

**`LEAN.md` § Searching — Lean, lines** (each to follow the last):
- `Finset.le_sup` unified at `Ideal.absNorm P.P` (`f := fun P => Ideal.absNorm P.P`) runs out of heartbeats in `whnf`; a
  bound stated for any `f : ι → ℕ` first (`∃ B, ∀ P ∈ s, f P ≤ B` from `s.sup f`) and then instantiated takes two seconds
  (`data/fs131/icl2/probes/LevelProbe2.lean`, `LevelProbe3.lean`; FS131-ICL2).
- An unused explicit binder prints as an arrow in a stored type's raw print (`(A) -> (∀ more, B)`), and the printer merges
  the binders around it: a statement check that strips a ruled binder strips the arrow and the parentheses and re-merges
  `∀ binders, ∀ more,` (`tools/fs131_icl2_ruled.py`; FS131-ICL2).
- A class binder in a raw print is ` : NumberField.{0} (…)`; a check for the word `NumberField` passes a statement that only
  mentions `NumberField.RingOfIntegers` — the shape that hid item 847's defect (`tools/fs131_icl2_statements.py`; FS131-ICL2).
- Every infinite place of `F(i)` is complex and `w(i) = ±i`; one place of `F(i)` is read on `F`'s mixed space through
  `InfinitePlace.mk (w.embedding.comp ι)` and `InfinitePlace.embedding_mk_eq`, a coordinate of `F`'s mixed space or its
  conjugate — no correspondence of places built (`Counting.exists_coord`, private; FS131-ICL2). `F` is dense in its mixed
  space by the rational multiples of `latticeBasis` (`Counting.dense_range_mixedEmbedding`, private).
- At the pin `continuous_add_right`, `continuous_add_left`, `continuous_mul_left` are deprecated for `continuous_add_const`,
  `continuous_const_add`, `continuous_const_mul`; `IsUnit.of_mul_eq_one` (not `isUnit_of_mul_eq_one`); `card_nsmul_eq_zero'`
  is `Nat.card G • x = 0`; `Monoid.exponent_ne_zero_of_finite`; `mem_nhds_subtype` takes its three arguments explicitly
  (FS131-ICL2).
