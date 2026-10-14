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
