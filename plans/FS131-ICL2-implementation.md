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
