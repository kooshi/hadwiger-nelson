# FS131-ICM3 — the five-colour chain: M13's last three leaves on this line

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-ICM3-m13-last-leaves.md` (on `main`). Branch `fs131-wcm3`, cut
from `fs131-wcm2` at `a7501c681`, in the tree `.claude/worktrees/fs131-wch`. Working files: `data/fs131/icm3/`. Report:
`data/fs131/reports/FS131-ICM3.md`. Commits by explicit path, not pushed (the brief: the server is unreachable).*

## Theorems this phase proved

*(filled at each saved stage)*

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_icm3_quotes.py` (FS131-ICM2's checker with this brief's path) requires each block quotation of the brief, the
`> ` prefix and a list marker removed, as one whole line of its source on `main`'s working tree. Output
`data/fs131/icm3/quotes.out`: **7 quotations, 7 IDENTICAL** — W2 (`data/fs131/REQUEST-2026-10-13.md`), the two dated lines
of 2026-10-14 (`data/fs131/claims-NF2.md`), inventory items 823, 848, 905 and 886 (`plans/FS131-close-inventory.md`).
Control (`--plant`, `data/fs131/icm3/quotes-plant.out`): one character changed in each quotation in memory, **7 of 7
reported**. The brief's pointers to the last implementer's record (§ Stage 4's table) and to KC13 § 5.3 were read: the
three leaves and their recorded routes are as § 1.3 below has them.

### 1.2 The stored statements, dumped before any edit

`data/fs131/icm3/lean/StatementDump.lean` (FS131-ICM2's dumper, renamed; the same four modules: `Rigidity/ClassRatio`,
`CountCompletion`, `CountDescent`, `CountModels`), run by `lake env lean` under the slot (`data/fs131/icm3/lean1.sh`) on the
tree as given — its compiled library current for `a7501c681` (the `.olean` of `ClassRatio` is later than its source, and
`a7501c681` differs from build 3's commit `80f40724b` only by the report): `data/fs131/icm3/statements-before.txt` —
**275 constants** (ClassRatio 145, CountCompletion 50, CountDescent 25, CountModels 55). It is **byte-identical**, `PP` lines
included, to FS131-ICM2's last dump (`data/fs131/icm2/statements-after3.txt.xz`), and the comparator
(`tools/fs131_icm3_statements.py`, ICM2's, renamed) reads it against that dump **SAME 44, PRIVATE-SAME 129, CHANGED 0 —
PASS** (`statements-vs-icm2.out`): the tree holds what the last implementer left.

### 1.3 The three leaves, restated (as the kernel holds them), beside their routes

*All private, all in `Rigidity/ClassRatio`. `S_m` is `levelSet P m`, `CharBound P m κ`: every non-trivial additive character
of `𝓞 ⧸ P^m` sums to real part at least `−κ·|S_m|` over `S_m`.*

| leaf | stored statement (from `statements-before.txt`, `PP`) | recorded route (ICM2 § Stage 4; KC13 § 5.3; KR1 § 2.6 (c)) |
|---|---|---|
| `circleCos_bound` | `∀ {Q : ℕ}, Q = 23 ∨ Q = 31 → ∀ [inst : NeZero Q], ∃ κ < 1 / 3, 2 / (↑Q + 1) ≤ κ ∧ ∀ (α β : ℕ), α < Q → β < Q → α ≠ 0 ∨ β ≠ 0 → -(κ * (↑Q + 1)) ≤ ∑ v with v.1 ^ 2 + v.2 ^ 2 = 1, Real.cos (2 * Real.pi * ↑((α * v.1.val + β * v.2.val) % Q) / ↑Q)` | rational lower bounds on `cos(2πj/Q)` (`Complex.exp_bound'`, `π` bracketed), then one kernel check over the 528 and 960 pairs |
| `charBound_one_exact_27` | `∀ {F : Subfield ℝ} [NumberField ↥F] (P : StablePrime F), 2 ∉ P.P → ∀ {Q : ℕ}, Nat.card (𝓞 (fieldI F) ⧸ P.P) = Q ^ 2 → Q = 27 → ∃ κ < 1 / 3, 2 / (↑Q + 1) ≤ κ ∧ CharBound P 1 κ` | `λ_min = −8` (FS100-G27): a model of `𝔽₇₂₉` and its `𝔽₃`-functionals |
| `ratioAtMost_dyadic` | `∀ {F : Subfield ℝ} [NumberField ↥F] (P : StablePrime F), 2 ∈ P.P → ¬IsRamified P → 5 ≤ (levelTarget P 1).chromaticNumber → ∃ c < 1 / 4, RatioAtMost P c` | `Q ≤ 32` four-colourable; a dyadic Lemma P; `Q = 64` exact; `128` by `Floor128`; `Q ≥ 256` by EN1-UQ4 |

`ratioAtMost_cert` (`Q ∈ {11, 19}`) stays named, by the brief.
