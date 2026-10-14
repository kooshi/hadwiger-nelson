# FS131-ICM2 — the five-colour chain: M13's six remaining leaves, Lemma P first

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-ICM2-m13-leaves.md` (on `main`). Branch `fs131-wcm2`, cut
from `fs131-wcm` at `0dea51730`, in the tree `.claude/worktrees/fs131-wch`. Working files: `data/fs131/icm2/`. Report:
`data/fs131/reports/FS131-ICM2.md`. Commits by explicit path, not pushed (the brief: the server is unreachable).*

## Theorems this phase proved

*(filled at each saved stage)*

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_icm2_quotes.py` (FS131-ICM1's checker with this brief's path) requires each block quotation of the brief, the
`> ` prefix and a list marker removed, as one whole line of its source on `main`'s working tree. Output
`data/fs131/icm2/quotes.out`: **7 quotations, 7 IDENTICAL** — W2 (`data/fs131/REQUEST-2026-10-13.md`), the two dated lines
of 2026-10-14 (`data/fs131/claims-NF2.md`), inventory items 823, 848, 893 and 886 (`plans/FS131-close-inventory.md`).
Control (`--plant`, `data/fs131/icm2/quotes-plant.out`): one character changed in each quotation in memory, **7 of 7
reported**. The brief's restatements of the last implementer's record (§ Stage 3, § Stage 4) were read against that
record at `0dea51730`: the six leaves, their routes and the price "≈ 350–700" for Lemma P's two are as the record has them.

### 1.2 The stored statements, dumped before any edit

`data/fs131/icm2/lean/StatementDump.lean` (FS131-ICM1's dumper, renamed; the same four modules: `Rigidity/ClassRatio`,
`CountCompletion`, `CountDescent`, `CountModels`), run by `lake env lean` under the slot on the tree as given (its compiled
library current for `0dea51730`): `data/fs131/icm2/statements-before.txt` — **194 constants** (ClassRatio 64,
CountCompletion 50, CountDescent 25, CountModels 55). Every stored type and value in it is **byte-identical** to FS131-ICM1's
last dump (`data/fs131/icm1/statements-after3.txt.xz`, the `PP` lines aside), and the comparator reads it SAME against that
dump (`data/fs131/icm2/statements-vs-icm1.out`): the tree holds what the last implementer left.

**The comparator now reads the private declarations.** This job's six leaves are private theorems, and `levelSet`,
`CharBound` and `red`, which their statements use, are private definitions; FS131-ICM1's comparator skipped every internal
name. `tools/fs131_icm2_statements.py` adds a check of every `_private.…` constant with a user name (not `_proof_n`,
`_simp_n`, `match_n`, …): PRIVATE-SAME, or PRIVATE-CHANGED / PRIVATE-MISSING, which fail. On the dump against itself:
SAME 44, PRIVATE-SAME 69, PASS (`statements-selftest.out`); **five controls fire** (`statements-selftest-plant.out`: a
character of a public stored type, a public constant dropped, a public constant added in an old module, a class binder
removed, and — new — a character of the private leaf `card_fibre`'s stored type, read PRIVATE-CHANGED).

**Class binders against their sections** (item 847's defect; `--binders-only`, `data/fs131/icm2/binders-before.out`): six
public constants name `Subfield` without binding `NumberField` — `RatioAtMost`, `tca_iff` (ClassRatio's section declares
`variable {F : Subfield ℝ}` only, no class binder), `unitVectorsR` (a set, reading no number field), and CountModels'
three (`ratColouring`, `exists_invariantColouring_rat`, `not_r88TCA_rat`, stated at `⊥`, the rationals, where no class
binder is asked). Each is by design, as FS131-ICM1 classed the first three. The six private leaves and Lemma P's induction
each bind `[NumberField F]` in the stored type (read from the dump). No stored statement lacks a class binder its section
declares: nothing to send.

### 1.3 The six leaves, restated, beside their routes

*As the kernel holds them (`statements-before.txt`); all private, all in `Rigidity/ClassRatio`; each with `[NumberField F]`,
`P : StablePrime F`. `S_m` is `levelSet P m` (norm one in `𝓞 ⧸ P^m`), `red P n : 𝓞 ⧸ P^{n+2} → 𝓞 ⧸ P^{n+1}`.*

| leaf | statement | route (recorded) | route taken |
|---|---|---|---|
| `card_fibre` | `2 ∉ P`, `|𝓞 ⧸ P| = Q²`, `t ∈ S_{n+1}` ⟹ `#{x ∈ S_{n+2} : red x = t} = Q` | ICM1 § Stage 4: lifts of norm one form an affine `k₀`-line, `P` inert, a σ-fixed uniformizer | the same count with no uniformizer (§ Stage 2) |
| `norm_charSum_new_le` | the same, `ψ` non-trivial on `ker red` ⟹ `‖Σ_{S_{n+2}} ψ‖ ≤ (2/(Q+1))·|S_{n+2}|` | ICM1 § Stage 3 (B): average over fibres; one `k₀`-line in `ker ψ|_K`; met by two residues | averaged over the subgroup `1 + K⁻` instead of the fibres (§ Stage 2) |
| `chromaticNumber_le_four_of_small` | `2 ∉ P`, `|𝓞 ⧸ P| = Q²`, `Q ∈ {3, 7}` ⟹ `χ(levelTarget P 1) ≤ 4` | KR1 § 2.6 (a): the level-one target as `Γ_Q`, the library's colourings of `UD(𝔽₃, 2)`, `UD(𝔽₇, 2)` | — |
| `ratioAtMost_dyadic` | `2 ∈ P`, `¬ IsRamified P`, `5 ≤ χ(levelTarget P 1)` ⟹ `∃ c < 1/4, RatioAtMost P c` | KR1 § 2.6 (c): `Q = 64` exact, `128` `Floor128`, `Q ≥ 256` EN1-UQ4; Lemma P's dyadic form | — |
| `charBound_one_exact` | `2 ∉ P`, `|𝓞 ⧸ P| = Q²`, `Q ∈ {23, 27, 31}` ⟹ `∃ κ < 1/3, 2/(Q+1) ≤ κ ∧ CharBound P 1 κ` | KC13 § 5.3: exact rational cosine bounds at 23 and 31, the integer spectrum at 27 | — |
| `ratioAtMost_cert` | `2 ∉ P`, `|𝓞 ⧸ P| = Q²`, `Q ∈ {11, 19}` ⟹ `∃ c < 1/4, RatioAtMost P c` | stays named: the link to line `fs131-wc15`/`fs131-wc16` | — |
