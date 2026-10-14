# FS131-ICM1 — the five-colour chain: the count's last leaf, its model at `ℚ`, and the class-ratio module M13

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-ICM1-count-leaf-m13.md` (on `main`). Branch `fs131-wcm`, cut
from `fs131-wcl2` at `ffa957c75`, in the tree `.claude/worktrees/fs131-wch`. Working files: `data/fs131/icm1/`. Report:
`data/fs131/reports/FS131-ICM1.md`. Commits by explicit path, not pushed (the brief: the server is unreachable).*

## Theorems this phase proved

*(Filled from the built tree at the last saved stage.)*

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_icm1_quotes.py` (FS131-ICL2's checker with this brief's path) requires each block quotation of the brief, the
`> ` prefix and a list marker removed, as one whole line of its source on `main`'s working tree. Output
`data/fs131/icm1/quotes.out`: **7 quotations, 7 IDENTICAL** — W2 (`data/fs131/REQUEST-2026-10-13.md`), the two dated lines
of 2026-10-14 (`data/fs131/claims-NF2.md`), inventory items 823, 848, 884 and 886 (`plans/FS131-close-inventory.md`).
Control (`--plant`, `data/fs131/icm1/quotes-plant.out`): one character changed in each quotation in memory, **7 of 7
reported**.

### 1.2 The stored statements, dumped before any edit

`data/fs131/icm1/lean/StatementDump.lean` (FS131-ICL2's dumper over this job's modules: every constant of their compiled
data — kind, stored type with its hash, a definition's stored value, a pretty print with full names), run by `lake env lean`
on the tree as given (`fs131-wcl2`'s compiled library, current for `ffa957c75`): `data/fs131/icm1/statements-before.txt` —
75 constants (`Rigidity/ClassRatio` 7, `CountCompletion` 43, `CountDescent` 25, the last for reference: it holds
`count_of_oneAvoidingDensityBound`), 41 public.

**Class binders against their sections** (item 847's defect; `tools/fs131_icm1_statements.py --binders-only`,
`data/fs131/icm1/binders-before.out`): a constant whose stored type names `Subfield` must bind ` : NumberField.{0} (…)`.
Three misses, each by design:

| constant | module | class |
|---|---|---|
| `RatioAtMost`, `tca_iff` | ClassRatio | the module's section declares no class binder (`variable {F : Subfield ℝ}` only); each statement that needs one states `[NumberField F]` itself |
| `unitVectorsR` | CountCompletion | a definition of a set, reading no number field (FS131-ICL2 classed it the same) |

No stored statement lacks a class binder its section declares: nothing to send. The comparator's four controls
(`data/fs131/icm1/statements-selftest-plant.out`, the dump against itself): a character of a stored type, a constant
dropped, a public constant added in an old module, and a binder's class removed with a mention of
`NumberField.RingOfIntegers` kept — **4 of 4 fired**.

### 1.3 Each leaf, restated, beside its plan

*Each statement in one line as the kernel holds it (`statements-before.txt`'s pretty print).*

| module | leaf | statement | plan |
|---|---|---|---|
| CountCompletion | `Counting.tendsto_haarK_bad` | for measurable `Y ⊆ K` and `κ > 0`: `haarK {x ∈ Y : haarK (Y ∩ coset_k x) ≤ (1 − κ)·haarK (coset_k x)} → 0` as `k → ∞` | FS131-ICL2 § Stage 5: Haar is regular — compact `C ⊆ Y ⊆` open `U`; finitely many level cosets in `U` cover `C`; a bad coset in their union leaves a `κ`-share of itself in `U \ Y` |
| ClassRatio | `ratioAtMost_of_five_le_chromaticNumber` | `[NumberField F]`, `P` stable, `5 ≤ χ(levelTarget P 1)` ⟹ `∃ c < 1/4, RatioAtMost P c` | KR1 § 2.6 (a)–(d); KC13 § 5.1–5.3 (the exclusions at `L ≥ 5`, Lemma P, level one by residue size, the certificates at 11 and 19) |
| ClassRatio | `exists_uniform_tail` | `[NumberField F]` ⟹ `∃ c < 1/4, ∃ B, ∀ P, B < absNorm P.P → RatioAtMost P c` | KR1 § 2.6 (e): Weil at level one and Lemma P at every level |
| ClassRatio | `tca_uniform` | `[NumberField F]`, `TCA F` ⟹ `∃ c < 1/4, ∀ P, RatioAtMost P c` | the docstring's: the tail's constant and the finitely many stable primes of norm at most `B` (`Ideal.finite_setOf_absNorm_le`) |

**The model at the rationals** (item 871 ruling 2; FS131-ICL1 § 6.2's route): an `InvariantColouring ⊥` with a trace
spectral measure carried by `T + A`, in a new module `Rigidity/CountModels`.

## Stage 2 — SAVED: the count's leaf proved, and its model at `ℚ`

**`Counting.tendsto_haarK_bad`** (`Rigidity/CountCompletion`; ≈ 120 lines net with three private helpers, against the
plan's 150–250): the plan's route, as written in FS131-ICL2 § Stage 5. `mul_le_of_le_one_sub` is the per-coset inequality
(`a ≤ (1 − κ)(a + b)`, `κ ≤ 1`, finite ⟹ `κ(a + b) ≤ b`, in `ℝ`). `haarK_bad_le` bounds the bad set at level `k` by
`μ(Y \ Z) + μ(Z \ Y)/κ` for any `Z` that is a union of level-`k` cosets: the bad cosets inside `Z`, disjoint, each leave a
`κ`-share of themselves in `Z \ Y` (`measure_biUnion_finset`). `tendsto_haarK_bad_of_le_one`: `C ⊆ Y` compact and `U ⊇ Y`
open with `μ(Y \ C), μ(U \ Y) < κε/2` (`MeasurableSet.exists_isCompact_sdiff_lt`, `exists_isOpen_sdiff_lt`; `haarK` is
inner and outer regular), a level coset inside `U` about each point of `C` (`exists_coset_subset`, moved above the leaf:
a private helper, its statement unchanged), finitely many covering `C` (`IsCompact.elim_nhds_subcover`); their union `Z` is
a union of level-`k` cosets for every `k` past their levels (`proj_eq_zero_of_le`). The leaf: `κ' = min κ 1`, since the bad
set only grows as `κ` falls. **Statement unchanged** (§ the check below). **Re-priced:** at about half the plan's low end.

**The model at `ℚ`** (`Rigidity/CountModels`, new, ≈ 300 lines with its docstrings, against the § 6.2 price of 150–300):
the dyadic stable prime `P` of `ℚ(i)` (`UpperHalf.exists_stablePrime_rat`, ramified), `ρ = resR P 1`. Every unit vector
has `ρ(u) = 1` (its residue has norm one, conjugation is the identity modulo `P`, and `y² = 1 ⟹ y = 1` in characteristic
2), so by closure induction `ρ(R) ⊆ {0, 1}`; the bit `b(x) ∈ ZMod 2` is additive, rotation-invariant and `b(u) = 1`. The two
colourings `c_s = b + s` are proper, `μ = ½(δ_{c₀} + δ_{c₁})` is translation-invariant (a shift by `y` permutes the atoms
when `b(y) = 1`) and rotation-invariant (both atoms fixed), `corr(y) = 1` or `−1/3` as `b(y) = 0` or not, and
`σ = ⅓δ₁ + ⅔δ_χ` with `χ = ZMod.toCircle ∘ b` is trace spectral; `χ² = 1`, so `χ ∈ T + A` and `σ (T + A)ᶜ = 0` (singletons
of `R̂` are measurable, `R` being countable). Public: `ratColouring : InvariantColouring ⊥`,
**`exists_invariantColouring_rat`** (the hypotheses of `measure_ne_eq`, `tendsto_measure_ne`, `exists_extension`,
`exists_slice` at once), **`not_r88TCA_rat`** (`¬ (chainInterface ⊥).R88TCA`). Spec examples: the model's slice
(`exists_slice` at it), the correlation `−1/3` at the unit vector `1` (added after build 1, elaborated; in build 2), and
given the density bound the count and the model refute `TCA ℚ`. `Proofs.lean` and `ARCHITECTURE.md` carry its row;
`tools/check_architecture.py`: **PASS** (`data/fs131/icm1/logs/architecture-1.log`).

**Build 1** under the slot (`--mem 10 --cpus 4`, `MEMMAX=10G BATCH=8`; `data/fs131/icm1/logs/build-1.log`, full output
`build/gate/build/20261014T172603Z-4035510.log`): **OK — 257 of 257 batches, 5 modules rebuilt, 8 m 7 s, exit 0**;
`CountCompletion`, `CountExtension`, `CountDescent`, `CountModels` built with no warning; the only warnings from this job's
files are `ClassRatio`'s three `sorry`s (unchanged).

**No statement changed, from the kernel's side** (`data/fs131/icm1/statements-after1.txt` against stage 1's;
`data/fs131/icm1/statements-compare1.out`): **SAME 41, CHANGED 0, RULED 0, MISSING 0, ADDED-PUBLIC 0**, ADDED-INTERNAL
59, NEW-MODULE 3 (`ratColouring`, `exists_invariantColouring_rat`, `not_r88TCA_rat`) — PASS; the four plants fire
(`statements-plant1.out`).

**Axioms** (`data/fs131/icm1/lean/Axioms.lean`, FS131-ICL2's printer over `ClassRatio`, `CountCompletion`, `CountModels`
and `count_of_oneAvoidingDensityBound`; reader `tools/fs131_icm1_axioms.py`, which adds the class IMPORTED for Weil's
bound): **75 records — CLEAN 70, UPSTREAM 5, FAIL 0** (`axioms1-read.out`). `tendsto_haarK_bad`,
`exists_invariantColouring_rat`, `not_r88TCA_rat`, `ratColouring`: `[propext, Classical.choice, Quot.sound]`. The five:
`ClassRatio`'s three leaves and `tca_of_five_le_localBound` (over `ratioAtMost_of_five_le_chromaticNumber`), and
**`count_of_oneAvoidingDensityBound`, whose `sorryAx` now comes only from `Plane.upperDensity_le_of_oneAvoidingDensityBound`,
`Rigidity.noRamifiedStableDyadic_of_tca` and `Rigidity.tca_uniform`** — no leaf of the count's own (the one line sent to
the coordinator). Control (`AxiomsPlant.lean`: a planted `sorry` and a planted axiom): **2 of 2 read FAIL**
(`axioms1-plant-read.out`).
