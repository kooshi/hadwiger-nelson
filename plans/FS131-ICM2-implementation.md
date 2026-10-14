# FS131-ICM2 — the five-colour chain: M13's six remaining leaves, Lemma P first

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-ICM2-m13-leaves.md` (on `main`). Branch `fs131-wcm2`, cut
from `fs131-wcm` at `0dea51730`, in the tree `.claude/worktrees/fs131-wch`. Working files: `data/fs131/icm2/`. Report:
`data/fs131/reports/FS131-ICM2.md`. Commits by explicit path, not pushed (the brief: the server is unreachable).*

## Theorems this phase proved

Read from the built tree after build 1 (`data/fs131/icm2/axioms1.out`, `axioms1-read.out`).

- `Rigidity.tca_uniform`, `Rigidity.exists_uniform_tail` (`Rigidity/ClassRatio`, public) — [kernel, outside]:
  `[propext, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]` — Weil's bound (declared) and the standard three;
  no `sorry`. Read against: "T-C(A) with one constant — the tail's constant and the finitely many primes below `B`"
  (its docstring), the form the count reads.
- Private, the standard three: `card_fibre` (Hensel's fibre count), `norm_charSum_new_le` (a character new at a level),
  and so `charBound_of_charBound_one` (Lemma P), with their helpers (`SqZeroInv.card_lift`, `SqZeroInv.norm_sum_le`,
  `SqZeroInv.pm_of_good`, `card_res_fibre`, `card_levelSet_succ`, …).
- `Rigidity.Counting.count_of_oneAvoidingDensityBound` (`CountDescent`, not this job's file) — its `sorryAx` now comes
  only from `Plane.upperDensity_le_of_oneAvoidingDensityBound` and `Rigidity.noRamifiedStableDyadic_of_tca`; no leaf of
  M13 is under it.

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

## Stage 2 — SAVED: Lemma P's two leaves proved; `tca_uniform` rests on Weil's bound and the standard three

**Proved** (≈ 617 lines net in `Rigidity/ClassRatio`, all private; no statement, no definition of the file changed —
§ the check below). The price was ≈ 350–700 lines; it came in at the top of that.

*The algebra, once, in the abstract* (`section LemmaPAlgebra`, ≈ 260 lines). `SqZeroInv R`: a finite commutative ring
with an involution `σ`, an ideal `K` with `K·K = 0` and `σK ⊆ K`, `2u = 1`, and `ι` with `ι² = −1`, `σι = −ι`. `Kn` is
`K`'s `−1` part, `Kp` its `+1` part.
- `card_Kn_sq`: `|Kn|² = |K|` (`K = Kp ⊕ Kn` by `f ↦ (u(f + σf), u(f − σf))`, and `ι·` swaps the parts).
- `card_lift` (**Hensel**): if `N(x₀) − 1 = d ∈ K`, the `e ∈ K` with `N(x₀ + e) = 1` are `e = (σx₀)⁻¹(w − ud)`, `w ∈ Kn`
  (`(σx₀)⁻¹ = x₀(1 − d)`), so there are `|Kn|` of them.
- `norm_sum_le` (**averaging over `1 + Kn`**): each `1 + w`, `w ∈ Kn`, has norm one (`w² = 0`), so
  `|Kn|·Σ_S ψ = Σ_{x∈S} ψ(x)·Σ_{w∈Kn} ψ(xw)`, the inner sum `|Kn|` or `0`, and `‖Σ_S ψ‖ ≤ #{x ∈ S : ψ kills x·Kn}`.
- `pm_of_good` (**two lines in `ker ψ` are one**): if `ψ` is non-trivial on `K` and kills `x·Kn` and `x'·Kn`, then
  `x' ≡ ±x` modulo any prime `M` outside which everything is a unit — else `σx'·x − x'·σx` is a unit, so `(a, b) ↦ xa + x'b`
  is injective on `Kn × Kn`, hence onto `K` by `|Kn|² = |K|`, and `ψ` is trivial on `K`.

*At the residue rings* (≈ 360 lines). `sqZeroInvAt P h2 n` at `R = 𝓞 ⧸ P^{n+2}`, `K = ker red`: `K·K ⊆ P^{2n+2}/P^{n+2} = 0`;
`2` a unit modulo `P^m` (`isUnit_mk_of_notMem`: `ya + i = 1`, `i ∈ P`, and a geometric sum); `ι` the residue of `i`.
`|𝓞 ⧸ P^m| = Q^{2m}` (`cardQuot_pow_of_prime`), so `|ker red| = Q²` (`Submodule.card_eq_card_quotient_mul_card` with
`RingHom.quotientKerEquivOfSurjective`) and `|Kn| = Q` (`card_Kn_at`).
- **`card_fibre`**: a lift `x₀` of `t`; `x ↦ x − x₀` carries the fibre onto the lifts of norm one; `card_lift`.
- **`norm_charSum_new_le`**: `norm_sum_le`; the good `x` lie in two residue classes modulo `P` (`pm_of_good` with
  `M = ker res`, `res : 𝓞 ⧸ P^{n+2} → 𝓞 ⧸ P`); each class has `Q^{n+1}` norm-one elements (`card_res_fibre`, by
  induction from `card_fibre`), and `|S_{n+2}| = Q^{n+1}(Q + 1)` (`card_levelSet_succ`, with `|S₁| = Q + 1` by
  `card_levelSet_one`, `card_normOne` as in `charBound_one_weil`). So `‖Σ‖ ≤ 2Q^{n+1} = (2/(Q + 1))·|S_{n+2}|`.

**The route differs from the recorded one, and needs less.** No uniformizer, no inertness of `P` over `F`, no
`k₀`-vector-space structure on `P^{n+1}/P^{n+2}`: the count of `K` from the norms of `P`'s powers replaces
one-dimensionality, and averaging over the subgroup `1 + Kn` replaces averaging over the fibres (the recorded route's
"`W_x` depends only on `x mod P`" is not used). The abstract lemmas need no number field: any finite ring with an
involution and a square-zero stable ideal in which `2` is a unit and `−1` is a square with `σι = −ι`.

**Build 1** under the slot (`--mem 10 --cpus 4`, `MEMMAX=10G BATCH=8`; `data/fs131/icm2/logs/build-1.log`, full output
`logs/build-1-full.log.xz`, `build/gate/build/20261014T183347Z-111841.log`): **OK — 257 of 257 batches, 7 modules
rebuilt, 7 m 51 s, exit 0**. `ClassRatio` (9.3 s) and its downstream `CountResidue`, `CountCompletion`, `CountExtension`,
`CountDescent`, `CountModels` rebuilt; the only warnings from this job's files are the four remaining leaves' `declaration
uses 'sorry'` (`ClassRatio.lean` lines 961, 966, 974, 981). `tools/check_architecture.py`: **PASS**
(`logs/architecture-1.log`).

**No statement and no definition changed, from the kernel's side** (`statements-after1.txt.xz` against stage 1's;
`statements-compare1.out`): **SAME 44, CHANGED 0, MISSING 0, ADDED-PUBLIC 0; PRIVATE-SAME 69, PRIVATE-CHANGED 0** (the six
leaves, `levelSet`, `CharBound`, `red` and every earlier private helper among them), ADDED-INTERNAL 76 — PASS; **five
plants fire** (`statements-plant1.out`, the private leaf's among them).

**Axioms** (`data/fs131/icm2/lean/Axioms.lean`, FS131-ICM1's printer; reader `tools/fs131_icm2_axioms.py`, the four
remaining leaves named by `--leaves`; `axioms1-read.out`): **156 records — CLEAN 144, IMPORTED 5, UPSTREAM 7, FAIL 0**.
IMPORTED (Weil's bound and the standard three, no `sorry`): **`tca_uniform`**, **`exists_uniform_tail`**, `charBound_one_weil`,
`ratioAtMost_weil`, `ratioAtMost_weil_lt`. UPSTREAM: the four leaves; `ratioAtMost_of_five_le_chromaticNumber` and
`tca_of_five_le_localBound` over them; `count_of_oneAvoidingDensityBound` over `Plane.upperDensity_le_of_oneAvoidingDensityBound`
and `Rigidity.noRamifiedStableDyadic_of_tca` only. Read with no leaf list the same output gives **FAIL 6**
(`axioms1-read-noleaves.out`, exit 1: the four leaves and their two consumers); the planted `sorry` and axiom **2 of 2
FAIL** (`axioms1-plant-read.out`). The one line was sent to the coordinator.
