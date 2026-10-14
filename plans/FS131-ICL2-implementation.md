# FS131-ICL2 — the count's lanes joined with the chain's line; the finite side (Λ2) and the completion (Λ3)

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-ICL2-count-finite-completion.md` (on `main`). Branch `fs131-wcl2`,
cut from the chain's line at `1e438c171` with `fs131-wcl` merged into it, in the tree `.claude/worktrees/fs131-wch`. Working
files: `data/fs131/icl2/`. Report: `data/fs131/reports/FS131-ICL2.md`. Commits by explicit path, not pushed (the brief: the
server is unreachable).*

## Theorems this phase proved

*(filled at the gate stage)*

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
