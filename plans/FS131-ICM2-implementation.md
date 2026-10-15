# FS131-ICM2 — the five-colour chain: M13's six remaining leaves, Lemma P first

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-ICM2-m13-leaves.md` (on `main`). Branch `fs131-wcm2`, cut
from `fs131-wcm` at `0dea51730`, in the tree `.claude/worktrees/fs131-wch`. Working files: `data/fs131/icm2/`. Report:
`data/fs131/reports/FS131-ICM2.md`. Commits by explicit path, not pushed (the brief: the server is unreachable).*

## Theorems this phase proved

Read from the built tree after build 3 (`data/fs131/icm2/axioms3.out`, `axioms3-read.out`): 159 records of `ClassRatio`,
`CountCompletion`, `CountModels` and `count_of_oneAvoidingDensityBound` — **CLEAN 146, IMPORTED 5, UPSTREAM 8, FAIL 0**.

- `Rigidity.tca_uniform`, `Rigidity.exists_uniform_tail` (`Rigidity/ClassRatio`, public) — [kernel], imported records:
  `[propext, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]` — the standard three and Weil's bound, the
  declared outside theorem; no `sorry`. Read against: "T-C(A) with one constant — the tail's constant and the finitely many primes below `B`"
  (its docstring), the form the count reads.
- Private, the standard three: `card_fibre` (Hensel's fibre count), `norm_charSum_new_le` (a character new at a level),
  and so `charBound_of_charBound_one` (Lemma P), with their helpers (`SqZeroInv.card_lift`, `SqZeroInv.norm_sum_le`,
  `SqZeroInv.pm_of_good`, `card_res_fibre`, `card_levelSet_succ`, …).
- `Rigidity.Counting.count_of_oneAvoidingDensityBound` (`CountDescent`, not this job's file) — its `sorryAx` now comes
  only from `Plane.upperDensity_le_of_oneAvoidingDensityBound` and `Rigidity.noRamifiedStableDyadic_of_tca`; no leaf of
  M13 is under it.
- `chromaticNumber_le_four_of_small` (private, stage 3) — the standard three: at `Q ∈ {3, 7}` the level-one target is
  four-colourable.
- `charBound_one_of_circleCos` (private, stage 4) — the standard three: at a prime `Q`, the circle's cosine sums bound
  the level-one characters; `charBound_one_exact` is proved over two children.
- Still `sorry` (four, all private): `ratioAtMost_dyadic`; `circleCos_bound` (`Q ∈ {23, 31}`, a closed statement about
  `UD(𝔽_Q, 2)`); `charBound_one_exact_27`; `ratioAtMost_cert` (stays named, by the brief). So
  `ratioAtMost_of_five_le_chromaticNumber` and `tca_of_five_le_localBound` rest on these four and Weil's bound.

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

## Stage 3 — SAVED: the exclusions at `Q ∈ {3, 7}`; build 2

**`chromaticNumber_le_four_of_small` proved** (≈ 60 lines; one import line, `Arith/GapSeven`, for its four-colouring of
`UD(𝔽₇, 2)`). The level-one target maps into the unit-quadrance graph of the fixed field `k₀ = {x : σx = x}` of the
residue field by `x ↦ (u(x + σx), −uι(x − σx))` (`u = 1/2`): it is injective (`x = a + bι`) and carries the norm to
`a² + b²` (`(2u)² = 1`, `ι² = −1`). `|k₀| = Q` (`StandingFive.card_fixed_of_involution`), so `k₀ ≃+* ZMod Q`
(`Arith.nonempty_ringEquiv_zmod_of_card`), and `unitQuadrance.map` lands in `finitePlane Q`; at `3` it is
`finitePlane3_colorable_three`, at `7` `GapSeven.gamma` with `gamma_proper`. This is the recorded route ("the level-one
target as `Γ_Q`"), with a homomorphism in place of K3's isomorphism; the price was 300–500 lines with K3, and the
homomorphism needs none of K3's surjectivity. **Re-priced:** ≈ 60 lines.

**Build 2** under the slot (`data/fs131/icm2/logs/build-2.log`, full output `logs/build-2-full.log.xz`,
`build/gate/build/20261014T184454Z-141180.log`): **OK — 257 of 257 batches, 7 modules rebuilt, 8 m 6 s, exit 0**; the
only warnings from this job's files are the three remaining leaves' `declaration uses 'sorry'` (`ClassRatio.lean` lines
962, 1034, 1041); the count's five downstream modules rebuilt with none. `tools/check_architecture.py`: **PASS**
(`logs/architecture-2.log`, the imports cell of `Rigidity/ClassRatio`'s row now names `Arith/GapSeven`); with the cell
put back as it was, **FAIL** "imports of Rigidity/ClassRatio: … real-only ['Arith/GapSeven']" (`logs/architecture-plant.log`),
then restored.

**No statement and no definition changed across the new import** (`statements-after2.txt.xz` against stage 1's;
`statements-compare2.out`): **SAME 44, PRIVATE-SAME 69, CHANGED 0, MISSING 0, ADDED-PUBLIC 0** — PASS; five plants fire
(`statements-plant2.out`). `Arith/GapSeven`'s one instance (`Decidable (Gapped v m)`) is on its own predicate and moved
no stored term.

**Axioms** (`axioms2-read.out`, the three remaining leaves named): **156 records — CLEAN 145, IMPORTED 5, UPSTREAM 6, FAIL
0**; `chromaticNumber_le_four_of_small` CLEAN; the IMPORTED five as in stage 2 (`tca_uniform`, `exists_uniform_tail`
among them). Without the leaf list **FAIL 5** (`axioms2-read-noleaves.out`, exit 1); plants **2 of 2 FAIL**
(`axioms2-plant-read.out`).

## Stage 4 — SAVED: the exact spectra at 23 and 31 reduced to `UD(𝔽_Q, 2)`; build 3; the job's state from the kernel's side

**`charBound_one_exact` proved over two children** (≈ 200 lines). `charBound_one_of_circleCos` (proved, the standard
three): at a prime `Q`, with `k = k₀ ⊕ k₀ι` and `e : k₀ ≃+* ZMod Q` as in stage 3, the coordinate map
`x ↦ (A x, B x)` is a bijection `k → (ZMod Q)²` (injective, `x = A + Bι`; `|k| = Q²`) carrying `N(x) = 1` exactly onto
`a² + b² = 1`; `ψ(Q·1) = ψ(0)`, so `ψ(1)`, `ψ(ι)` are `Q`-th roots of unity, `ζ^α`, `ζ^β` (`Complex.isPrimitiveRoot_exp`,
`IsPrimitiveRoot.eq_pow_of_pow_eq_one`), `ψ(x) = ζ^{(αA(x) + βB(x)) mod Q}`, `(α, β) ≠ 0` as `ψ ≠ 1`, and
`Re ζ^m = cos(2πm/Q)`. The two children (named, `sorry`):

| child | statement | route (for the next implementer) |
|---|---|---|
| `circleCos_bound` | `Q ∈ {23, 31}` ⟹ `∃ κ < 1/3, 2/(Q+1) ≤ κ ∧ ∀ α β < Q, (α, β) ≠ 0 → −κ(Q+1) ≤ Σ_{a²+b²=1} cos(2π((αa.val + βb.val) mod Q)/Q)` — no number field | rational lower bounds `c_j ≤ cos(2πj/Q)`, `j < Q`: `Complex.exp_bound'` (an `n`-term Taylor bound for `‖x‖ ≤ (n+1)/2`) at a rational `x` below `2πj/Q` with `π` bracketed by `Real.pi_gt_d20`, `Real.pi_lt_d20`, and `cos` 1-Lipschitz (`Real.abs_cos_sub_cos_le`); then one kernel check, as a `Bool` over `List.all`, of the integer-scaled sums over all `(α, β)` (528 at 23, 960 at 31) |
| `charBound_one_exact_27` | `Q = 27` ⟹ `∃ κ < 1/3, 2/(Q+1) ≤ κ ∧ CharBound P 1 κ` | KC13 § 5.3: `λ_min = −8`, an integer in characteristic 3; a model of `𝔽₇₂₉` and its `𝔽₃`-functionals |

**The child is true as stated, read in floating point** (`tools/fs131_icm2_circlecos.py`, an evaluation of the stated
formula, not a search; `data/fs131/icm2/circlecos.out`): the least normalised sum is `−0.331695299` at 23 (at
`(α, β) = (3, 9)`, margin `1.638·10⁻³`) and `−0.333328453` at 31 (at `(0, 11)`, margin `4.880·10⁻⁶`), each circle of
`Q + 1` points — KC13 § 5.3's margins, from a second instrument. Control (`--plant`, `circlecos-plant.out`): at 11 and 19,
where Hoffman is known to fail, the same reading **FAILS** (`−0.3996`, `−0.3805`). So at 31 each cosine is needed to about
`5·10⁻⁶` (an absolute margin of `1.56·10⁻⁴` over 32 terms).

**Build 3** under the slot (`logs/build-3.log`, full output `logs/build-3-full.log.xz`,
`build/gate/build/20261014T190801Z-213347.log`): **OK — 257 of 257 batches, 7 modules rebuilt, 9 m 54 s, exit 0**; the
only warnings from this job's files are the four remaining leaves' `declaration uses 'sorry'` (`ClassRatio.lean` lines
962, 1034, 1184, 1193); the five downstream modules built with none. `tools/check_architecture.py`: **PASS**
(`logs/architecture-3.log`; ClassRatio's row reworded to its state).

**No statement and no definition changed** (`statements-after3.txt.xz` against stage 1's dump; `statements-compare3.out`):
**SAME 44, PRIVATE-SAME 69, CHANGED 0, MISSING 0, ADDED-PUBLIC 0**, ADDED-INTERNAL 81 — PASS; five plants fire
(`statements-plant3.out`; among them one character of the private leaf `card_fibre`'s stored type, read PRIVATE-CHANGED).

**Axioms** (`axioms3-read.out`, the four leaves named): **159 records — CLEAN 146, IMPORTED 5, UPSTREAM 8, FAIL 0**.
IMPORTED: `tca_uniform`, `exists_uniform_tail`, `charBound_one_weil`, `ratioAtMost_weil`, `ratioAtMost_weil_lt`, each
`[propext, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]`. UPSTREAM: the four leaves; `charBound_one_exact`
over its two children; `ratioAtMost_of_five_le_chromaticNumber`, `tca_of_five_le_localBound` over the four and Weil;
`count_of_oneAvoidingDensityBound` over `Plane.upperDensity_le_of_oneAvoidingDensityBound` and
`Rigidity.noRamifiedStableDyadic_of_tca` only. Without the leaf list **FAIL 7** (`axioms3-read-noleaves.out`, exit 1);
the planted `sorry` and axiom **2 of 2 FAIL** (`axioms3-plant-read.out`). Not run by this job (the landing runs them on the
joined tree): `scripts/dupnames.sh`, `lake lint`, `scripts/vacuity.sh`; this job added no public name.

**Re-priced** (each from its first part): Lemma P ≈ 617 lines (the record's 350–700); the exclusions at 3 and 7 ≈ 60
(KR1's 300–500 with K3); the exact spectra at 23 and 31 ≈ 200 of bridge, and the child `circleCos_bound` ≈ 300–600 more
(KC13's 700–1,200 for the whole); 27: KC13's 400–600 stands, unread here; the dyadic branch: not begun — KR1 § 2.6 (c)'s
route (64 exact, 128 by `Floor128`, `Q ≥ 256` by EN1-UQ4, the exclusions at dyadic `Q ≤ 32`, and a dyadic Lemma P, which
the algebra here does not give: it asks `2` a unit) stands at its map price.

## Drafts for the landing

### The audit's block (`scripts/Axioms.lean`, by the landing)

- `Rigidity/ClassRatio`: `RatioAtMost`, `tca_iff` CLEAN; **`tca_uniform` and `exists_uniform_tail` are IMPORTED records**
  (`[propext, Classical.choice, Quot.sound, StandingFive.kloosterman_bound]`, no `sorry`) — two lines for the IMPORTED
  section under the existing `AxiomAudit.declareImport` of `StandingFive.kloosterman_bound`; `ratioAtMost_of_five_le_chromaticNumber`
  and `tca_of_five_le_localBound` UPSTREAM through `ratioAtMost_dyadic`, `circleCos_bound`, `charBound_one_exact_27` and
  `ratioAtMost_cert` (private), and on Weil's bound.
- `Rigidity/CountDescent`'s `count_of_oneAvoidingDensityBound`: UPSTREAM only through
  `Plane.upperDensity_le_of_oneAvoidingDensityBound` (lane P) and `Rigidity.noRamifiedStableDyadic_of_tca` (M9-S); IMPORTED
  on Weil's bound once those land.

### `LEAN.md` § Searching — Lean (each to follow the last)

- Inside a declaration named into a structure's namespace (`SqZeroInv.card_Kn_sq`), a bare name resolves there first:
  `rw [sq]` used the structure's field `SqZeroInv.sq` ("did not find `?a * ?b`"), and `norm_sum_le` inside
  `SqZeroInv.norm_sum_le` named the theorem being proved; write `pow_two`, `_root_.norm_sum_le` (FS131-ICM2).
- `rwa [map_ofNat] at h` for `h : mk 2 * ↑hu.unit⁻¹ = 1` (`hu : IsUnit (mk 2)`) is "motive is not type correct": the unit's
  proof mentions `mk 2`. `convert h using 2; exact (map_ofNat _ 2).symm` (`sqZeroInvAt`, FS131-ICM2).
- `open Classical in` goes before a declaration's docstring; between the docstring and the keyword it is "unexpected token
  'open'; expected 'lemma'" (FS131-ICM2).
- `obtain ⟨x, hx⟩ := (Ideal.Quotient.factor_surjective _ : Function.Surjective (red P n)) t` stores `hx` with `factor`,
  which a `rw` against `red P n x` does not find; state the type, `obtain ⟨x, hx⟩ : ∃ x, red P n x = t := …`, and name the
  map in `RingHom.quotientKerEquivOfSurjective (f := red P n)` (FS131-ICM2).
- `|𝓞 ⧸ P^m| = |𝓞 ⧸ P|^m` is the root-namespace `cardQuot_pow_of_prime` (`[P.IsPrime]`, `P ≠ ⊥`), read with
  `Submodule.cardQuot_apply`; the kernel of a surjective ring map has `|R| / |S|` elements by
  `Submodule.card_eq_card_quotient_mul_card` with `RingHom.quotientKerEquivOfSurjective`. In `Finset.sum_nbij'` the last
  argument is `f a = g (i a)`: `i` runs from the left sum's index to the right's (FS131-ICM2).
- A character of a finite ring of characteristic `p` takes `p`-th roots of unity: `ψ(p·1) = ψ 0`, then
  `(Complex.isPrimitiveRoot_exp p _).eq_pow_of_pow_eq_one` writes `ψ 1 = ζ^α`; `AddChar.map_nsmul_eq_pow` and
  `Complex.exp_ofReal_mul_I_re` give `Re ψ = cos` (`charBound_one_of_circleCos`, FS131-ICM2).

### `ARCHITECTURE.md`

`Rigidity/ClassRatio`'s row: its imports cell names `Arith/GapSeven` (stage 3); its state sentence rewritten to this job's
state (stage 4). `tools/check_architecture.py`: PASS.

### For the landing to read

- `ClassRatio`'s module docstring still says "skeleton" (not edited: the brief allowed proofs, private helpers and import
  lines); FS131-ICM1's rewording stands, with "Lemma P and the exclusions at 3 and 7 proved (FS131-ICM2)".
- `isUnit_mk_of_notMem` (private, this module) and `UpperHalf.isUnit_mk_pow` (public) say nearly one thing in two forms
  (an element outside `P`; an element of `P`'s prime complement): no doubled name, a tidy for the landing.
