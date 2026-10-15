# FS131-ICM1 — the five-colour chain: the count's last leaf, its model at `ℚ`, and the class-ratio module M13

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-ICM1-count-leaf-m13.md` (on `main`). Branch `fs131-wcm`, cut
from `fs131-wcl2` at `ffa957c75`, in the tree `.claude/worktrees/fs131-wch`. Working files: `data/fs131/icm1/`. Report:
`data/fs131/reports/FS131-ICM1.md`. Commits by explicit path, not pushed (the brief: the server is unreachable).*

## Theorems this phase proved

Read from the built tree after build 3 (`data/fs131/icm1/axioms3.out`, `axioms3-read.out`): 102 records of
`ClassRatio`, `CountCompletion`, `CountModels` and `count_of_oneAvoidingDensityBound` — **CLEAN 87, IMPORTED 1, UPSTREAM
14, FAIL 0**.

- `Rigidity.Counting.tendsto_haarK_bad` (`Rigidity/CountCompletion`) — density along cosets of `K` — [kernel],
  `[propext, Classical.choice, Quot.sound]`. `CountCompletion` holds no `sorry`.
- `Rigidity.Counting.ratColouring` (definition), `exists_invariantColouring_rat`, `not_r88TCA_rat` (`Rigidity/CountModels`,
  new) — the count's hypotheses inhabited at `F = ℚ`, and its conclusion false there — [kernel], the standard three.
- `Rigidity.tca_uniform`, `Rigidity.exists_uniform_tail` (`Rigidity/ClassRatio`) — [kernel, over named leaves]: the
  standard three, `StandingFive.kloosterman_bound` (Weil's bound, declared), and `sorryAx` from Lemma P's two leaves
  `card_fibre` and `norm_charSum_new_le` (private) only.
- `Rigidity.ratioAtMost_of_five_le_chromaticNumber` (and `tca_of_five_le_localBound` over it) — [kernel, over named
  leaves]: the standard three, Weil's bound, and `sorryAx` from the six private leaves (§ Stage 4).
- Private, proved: `charBound_one_weil` (Weil at level one) — the standard three and Weil's bound;
  `ratioAtMost_of_charBound` (the ratio bound at every level), `exists_card_sq`, `card_ne_fifteen_sq`, `red_mem_levelSet`,
  `exists_addChar_descent` — the standard three; `charBound_of_charBound_one` (Lemma P's induction) — over `card_fibre`,
  `norm_charSum_new_le`.
- `Rigidity.Counting.count_of_oneAvoidingDensityBound` (`CountDescent`, not this job's file) now rests on Weil's bound and
  `sorryAx` from `Plane.upperDensity_le_of_oneAvoidingDensityBound`, `Rigidity.noRamifiedStableDyadic_of_tca`,
  `Rigidity.card_fibre` and `Rigidity.norm_charSum_new_le` — no leaf of the count's own.

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

## Stage 3 — SAVED: M13 — the three public leaves composed; Weil at level one, the ratio bound at every level and the tail proved; five named private leaves

`Rigidity/ClassRatio` (≈ 330 lines net; one import line added, `Rigidity/ChainAtTA`, for `IsRamified` and
`colorable_two_levelTarget_one_of_isRamified`; its `ARCHITECTURE.md` row's imports cell carries it). No statement and no
definition of the file changed (§ the check below); every addition is private. The private vocabulary: `levelSet P m`, the
connection set of `levelTarget P m`; `CharBound P m κ` — every non-trivial additive character of `𝓞 ⧸ P^m` sums to real
part at least `−κ·|S_m|` over it.

**Proved** (each private unless named):

| helper | what it says | lines |
|---|---|---|
| `ratioAtMost_of_charBound` | the ratio bound at every level: `CharBound P m κ` for all `m ≥ 1`, `κ ≥ 0` ⟹ `RatioAtMost P (κ/(1 + κ))` (`RatioBound.card_mul_le_of_indep`; `1 ∈ S_m`, so `|S_m| > 0`) | ≈ 50 |
| `charBound_one_weil` | **Weil at level one**: at a stable prime with `2 ∉ P` and `|𝓞 ⧸ P| = Q²`, `CharBound P 1 (2√Q/(Q + 1))` — the residue field with its involution (`card_fixed_of_involution` at the residue of `i` gives `Q ≡ 3 (mod 4)`, `involution_eq_pow` gives `σ = (·)^Q`, `card_normOne` gives `|S₁| = Q + 1`), then `StandingFive.normOne_charSum_ge` over `kloostermanBound_of_ringChar_ne_two` | ≈ 65 |
| `exists_card_sq` | at an odd stable prime, `|𝓞 ⧸ P| = Q²` with `Q ≡ 3 (mod 4)` | ≈ 20 |
| `card_ne_fifteen_sq` | no residue field has `15²` elements | ≈ 15 |
| `ratioAtMost_weil`, `weil_ratio_le`, `ratioAtMost_weil_lt` | the Weil branch at every level over Lemma P; its constant `κ/(1 + κ)` is `≤ c` when `2√Q(1 − c) ≤ c(Q + 1)`, so `< 1/4` (at `249/1000`) from `Q ≥ 35` and `≤ 2/9` from `Q ≥ 49` | ≈ 50 |
| `finite_stablePrime_absNorm_le`, `stablePrime_ext`, `ratioAtMost_mono`, `finite_quot_pow`, `exists_I_int`, `two_div_le_weil`, `sqrt_ge_of_sq_le` | small facts | ≈ 45 |
| **`exists_uniform_tail`** (public) | `c = 2/9`, `B = max (2^[𝓞 L : ℤ]) 2401`: a stable prime of norm above `2^[L:ℚ]` does not hold `2` (`Ideal.absNorm_dvd_absNorm_of_le`, `absNorm_span_natCast`), so `Q ≥ 49`, and the Weil branch | ≈ 25 |
| **`tca_uniform`** (public) | the tail's constant and the maximum of `TCA`'s constants over the finitely many stable primes of norm at most `B` (`Ideal.finite_setOf_absNorm_le`, `Finset.exists_max_image`) | ≈ 20 |
| **`ratioAtMost_of_five_le_chromaticNumber`** (public) | the case split: ramified — excluded (`χ ≤ 2`); dyadic unramified — leaf; odd: `Q ≥ 35` — the Weil branch; `Q < 35`, `Q ≡ 3 (mod 4)`: `3, 7` excluded by a leaf, `15` impossible, `11, 19` the certificate leaf, `23, 27, 31` the exact-spectrum leaf, then Lemma P and the ratio bound | ≈ 35 |

**The five named leaves** (private, `sorry`), each restated in one line:

| leaf | statement | route (owed) |
|---|---|---|
| `charBound_of_charBound_one` — **Lemma P** | `2 ∉ P`, `|𝓞 ⧸ P| = Q²`, `κ ≥ 2/(Q + 1)`, `CharBound P 1 κ` ⟹ `CharBound P m κ` for every `m ≥ 1` | below |
| `ratioAtMost_dyadic` | `2 ∈ P`, `¬ IsRamified P`, `5 ≤ χ(levelTarget P 1)` ⟹ `∃ c < 1/4, RatioAtMost P c` | KR1 § 2.6 (c): `Q = 64` exact, `128` `Floor128`, `Q ≥ 256` EN1-UQ4; Lemma P's dyadic form (`|λ| ≤ Q^{m−1}`) |
| `chromaticNumber_le_four_of_small` | `2 ∉ P`, `|𝓞 ⧸ P| = Q²`, `Q ∈ {3, 7}` ⟹ `χ(levelTarget P 1) ≤ 4` | the level-one target as `Γ_Q` (K3's isomorphism), then the library's colourings of `UD(𝔽₃, 2)`, `UD(𝔽₇, 2)` |
| `ratioAtMost_cert` — **the link to line `fs131-wc15`** | `2 ∉ P`, `|𝓞 ⧸ P| = Q²`, `Q ∈ {11, 19}` ⟹ `∃ c < 1/4, RatioAtMost P c` | closed at the join: K1 (`cert11_ok`, `cert19_ok`; not yet built), K2 `FibreCertSound.sum_le_of_certOK` (proved there; read by address, `Arith/FibreCertSound.lean:2620` at `1e0990dad`, not copied), K3 (`levelTarget P 1 ≃g Cay((ℤ/q)², S)`), K4's fibre-share half, K5 (`U₁₁/121`, `U₁₉/361 < 1/4`) |
| `charBound_one_exact` | `2 ∉ P`, `|𝓞 ⧸ P| = Q²`, `Q ∈ {23, 27, 31}` ⟹ `∃ κ < 1/3, 2/(Q + 1) ≤ κ ∧ CharBound P 1 κ` | KC13 § 5.3: rational cosine bounds at 23 and 31, the integer spectrum at 27 (FS100-G27) |

**Lemma P's route, made precise** (my reading; one mind; for the next implementer). `R_m = 𝓞 ⧸ P^m`, `K = P^{m−1}/P^m`
(a one-dimensional `𝓞/P`-space; `P` is inert: stable, and `σ` is non-trivial on `𝓞/P` because `2 ∉ P`), `S_m` the
norm-one set. Induction on `m`. For `m ≥ 2` and `x ∈ S_m`, `(x + e)σ(x + e) = 1 + Tr(σ(x)e)` for `e ∈ K` (`eσ(e) ∈ P^{2m−2}
⊆ P^m`), so `S_m ∩ (x + K) = x + W_x`, `W_x = {e ∈ K : Tr(σ(x)e) = 0}` — a `k₀`-line of `K` (`Q` elements) depending only on
`x mod P`, and every point of `S_{m−1}` lifts (Hensel), so the fibres of `S_m → S_{m−1}` all have `Q` points.
(A) `ψ` trivial on `K`: `ψ = ψ' ∘ π` with `ψ' ≠ 1` on `R_{m−1}`, and `Σ_{S_m} ψ = Q·Σ_{S_{m−1}} ψ'`, which the induction bounds by
`−κ·Q·|S_{m−1}| = −κ|S_m|`. (B) `ψ` non-trivial on `K`: averaging over the fibres, `Σ_{S_m} ψ = Σ_{x ∈ S_m} ψ(x)·avg_{W_x} ψ`,
and `avg_{W_x} ψ` is `1` or `0` as `ψ` is trivial on `W_x` or not; the kernel of `ψ|_K`, an `𝔽_p`-hyperplane, holds exactly
one `k₀`-line (a `k₀`-linear functional `λ` with `ψ = ψ₀ ∘ Tr ∘ λ` has its kernel there, and `λ` kills any other `k₀`-line it
contains), and `W_x = x̄⁻¹·V₀ = x·V₀` is that line for at most two residues `x mod P` (a ratio in `k₀` of norm one is `±1`).
So `|Σ_{S_m} ψ| ≤ 2|S_m|/(Q + 1) ≤ κ|S_m|`. Price, from this reading: 500–900 lines (fibre constancy by Hensel ≈ 150;
`K` as a one-dimensional space with `σ`, the line count ≈ 250; the character descent along `R_m → R_{m−1}` ≈ 100; assembly
≈ 100–200). The planner's K4 (1,000–1,800) holds Lemma P and the fibre shares together.

**Re-priced from the first two leaves** (`ratioAtMost_of_charBound`, ≈ 50 lines in two elaborations; `charBound_one_weil`,
≈ 65 lines in three): the Weil branch, the tail and `tca_uniform` came in at ≈ 330 lines in all, inside one stage. The
map priced M13 at 2,500–5,000 lines (KR1 § 2.6), with no line for this composition; what is left is the five leaves:
Lemma P 500–900 (above), the dyadic branch 400–800 (64 exact, 128's ratio from `Floor128`, EN1-UQ4 ≈ 300), the exclusions
at 3 and 7 with K3 300–500, the exact spectra 1,100–1,800 (KC13 § 5.3), and the certificate link's K3/K4/K5 on the join
(KC13 § 5.2, less K2, which is proved). About **2,800–4,500 lines left**, of which Lemma P alone unblocks the count:
`tca_uniform` now rests on Lemma P only (and Weil's bound).

**Build 2** under the slot (`data/fs131/icm1/logs/build-2.log`, full output
`build/gate/build/20261014T174250Z-4099276.log`): **OK — 257 of 257 batches, 7 modules rebuilt, 7 m 40 s, exit 0**;
`ClassRatio` rebuilt and its downstream (`CountResidue`, `CountCompletion`, `CountExtension`, `CountDescent`,
`CountModels`) with no warning; the only warnings from this job's files are the five named leaves' `declaration uses
'sorry'` (`ClassRatio.lean` lines 174, 242, 247, 255, 262). `tools/check_architecture.py`: **PASS**
(`logs/architecture-2.log`).

**No statement changed, from the kernel's side, across the new import line** (`statements-after2.txt` against stage 1's;
`statements-compare2.out`): **SAME 41, CHANGED 0, MISSING 0, ADDED-PUBLIC 0**, ADDED-INTERNAL 105, NEW-MODULE 3 — PASS;
the four plants fire (`statements-plant2.out`). The import of `Rigidity/ChainAtTA` moved no stored instance.

**Axioms** (`axioms2.out`, `axioms2-read.out`, the five leaves named by `--leaves`): **96 records — CLEAN 83, IMPORTED 1,
UPSTREAM 12, FAIL 0**. IMPORTED: `charBound_one_weil` — `[propext, Classical.choice, Quot.sound,
StandingFive.kloosterman_bound]`. UPSTREAM: the five leaves themselves; `ratioAtMost_weil`, `ratioAtMost_weil_lt`,
`exists_uniform_tail` and **`tca_uniform`** — Weil's bound and `sorryAx` from **Lemma P alone**
(`charBound_of_charBound_one`); `ratioAtMost_of_five_le_chromaticNumber`, `tca_of_five_le_localBound` — Weil and the five
leaves; and **`count_of_oneAvoidingDensityBound`** — Weil's bound and `sorryAx` from
`Plane.upperDensity_le_of_oneAvoidingDensityBound`, `Rigidity.noRamifiedStableDyadic_of_tca` and Lemma P. Control: **2 of
2 planted records read FAIL** (`axioms2-plant-read.out`).

## Stage 4 — SAVED: Lemma P's induction proved over two smaller leaves; build 3; the job's state from the kernel's side

**Lemma P, `charBound_of_charBound_one`, proved** (≈ 110 lines with three helpers) over two named private leaves that are
local to one level, by induction on the level. `red P n : 𝓞 ⧸ P^{n+2} →+* 𝓞 ⧸ P^{n+1}` (`Ideal.Quotient.factor`) carries
`S_{n+2}` into `S_{n+1}` (`red_mem_levelSet`); a character trivial on its kernel descends (`exists_addChar_descent`, by
`Function.surjInv`), its sum over `S_{n+2}` is `Q` times its sum one level down (`Finset.sum_fiberwise_of_maps_to` with the
fibre count) and `|S_{n+2}| = Q·|S_{n+1}|` (`Finset.card_eq_sum_card_fiberwise`), so the induction's bound passes up; a
character non-trivial on the kernel is bounded by the second leaf. The two leaves:

| leaf | statement | route (owed; § Stage 3's reading) |
|---|---|---|
| `card_fibre` — Hensel | `2 ∉ P`, `|𝓞 ⧸ P| = Q²`, `t ∈ S_{n+1}` ⟹ `#{x ∈ S_{n+2} : red x = t} = Q` | a lift `x̃` of `t` has `N(x̃) = 1 + d`, `d` in the σ-fixed part of `K = P^{n+1}/P^{n+2}`; the lifts `x̃ + e` of norm one are `Tr(σ(x̃)e) = −d`, an affine `k₀`-line (`P` inert: a σ-fixed uniformizer makes `K ≅ 𝓞/P` with `σ`) |
| `norm_charSum_new_le` | `2 ∉ P`, `|𝓞 ⧸ P| = Q²`, `ψ` non-trivial on `ker red` ⟹ `‖Σ_{S_{n+2}} ψ‖ ≤ (2/(Q + 1))·|S_{n+2}|` | averaged over the fibres the sum keeps the `x` whose line `W_x` `ψ` kills; one `k₀`-line in `ker ψ|_K`, met by at most two residues mod `P`; equidistribution over `S₁` by `card_fibre` |

Both are true as stated by § Stage 3's argument (one mind; not checked by a second). Re-priced: Lemma P's remainder is
these two, ≈ 350–700 lines (the `K ≅ 𝓞/P` structure with `σ` is shared).

**Build 3** under the slot (`data/fs131/icm1/logs/build-3.log`, full output
`build/gate/build/20261014T175227Z-4147475.log`): **OK — 257 of 257 batches, 7 modules rebuilt, 8 m 37 s, exit 0**; the
only warnings from this job's files are the six leaves' `declaration uses 'sorry'` (`ClassRatio.lean` lines 214, 224,
346, 351, 359, 366); `CountResidue` … `CountModels` rebuilt with none. `tools/check_architecture.py`: **PASS**
(`logs/architecture-3.log`).

**No statement and no definition changed, from the kernel's side** (`statements-after3.txt.xz` against stage 1's
`statements-before.txt.xz`; `statements-compare3.out`): **SAME 41, CHANGED 0, RULED 0, MISSING 0, ADDED-PUBLIC 0**,
ADDED-INTERNAL 116, NEW-MODULE 3 — PASS; planted changes (a character of a stored type, a constant dropped, a public
constant added in an old module, a class binder removed) **4 of 4 fired** (`statements-plant3.out`). No class binder is
missing (three misses, each by design, § 1.2). No binder was dropped and no statement ruled.

**Axioms** (`axioms3-read.out`, the six leaves named): **102 records — CLEAN 87, IMPORTED 1 (`charBound_one_weil`),
UPSTREAM 14, FAIL 0**; read without the leaf list the same output gives **FAIL 14** (`axioms3-read-noleaves.out`, exit 1:
the leaves are what the UPSTREAM records rest on, and nothing else); the planted `sorry` and axiom **2 of 2 FAIL**
(`axioms3-plant-read.out`). Not run by this job: `scripts/dupnames.sh`, `lake lint`, `scripts/vacuity.sh` (the landing runs
them on the joined tree; this job added three public names, in a new module).

## Drafts for the landing

### The audit's block (`scripts/Axioms.lean`, by the landing)

- `Rigidity/CountCompletion` — **every record CLEAN** (`tendsto_haarK_bad` among them; the module holds no `sorry`).
- `Rigidity/CountModels` (new) — every record CLEAN: `ratColouring`, `exists_invariantColouring_rat`, `not_r88TCA_rat`.
- `Rigidity/ClassRatio` — `RatioAtMost`, `tca_iff` CLEAN; `ratioAtMost_of_five_le_chromaticNumber`,
  `tca_of_five_le_localBound`, `exists_uniform_tail`, `tca_uniform` UPSTREAM through this module's named private leaves
  (the six of § Stage 4) and resting on Weil's bound (`StandingFive.kloosterman_bound`, declared) through
  `charBound_one_weil`; IMPORTED (no `sorry`) once the leaves land.
- `Rigidity/CountDescent`'s `count_of_oneAvoidingDensityBound` — UPSTREAM only through
  `Plane.upperDensity_le_of_oneAvoidingDensityBound` (lane P), `Rigidity.noRamifiedStableDyadic_of_tca` (M9-S) and
  `Rigidity.tca_uniform` (this module: through Lemma P's two leaves, `card_fibre`, `norm_charSum_new_le`), and on Weil's bound through `tca_uniform`. **The count
  now reads the declared import `StandingFive.kloosterman_bound`**: when the leaves land it is IMPORTED, not CLEAN — a
  line for `scripts/Axioms.lean`'s IMPORTED section (`AxiomAudit.declareImport` already names the axiom; the landing adds
  the records).

### The models (`LEAN.md` § The gate)

- `CountExtension`'s and `CountDescent`'s structure hypotheses `(μ : InvariantColouring F)`, `IsTraceSpectral F μ.μ σ`,
  `σ (TA F)ᶜ = 0`: inhabited at once at `F = ℚ` by the theorem `Counting.exists_invariantColouring_rat`
  (`Rigidity/CountModels`, standard three), every clause exercised (two colourings, both translations' cases, a non-trivial
  spectrum `⅓δ₁ + ⅔δ_χ`). It is a model of every hypothesis the count's lemmas take except `TCA F`, which fails at `ℚ`
  (the ramified prime `(1 + i)`); `not_r88TCA_rat` is the count's conclusion failing there, as it must.
- `Counting.tendsto_haarK_bad`: `Y = ∅` and `Y = univ` (measurable) at every `κ > 0`; no structure hypothesis.
- `Rigidity/ClassRatio`: `5 ≤ localBound F` at the standing field (`StandingFive.le_localBound`, through the floor at
  seven over Weil's bound) and at `ℚ(√47)` (module M15, not yet a theorem); `TCA F` is the open hypothesis of `tca_uniform`
  (the count's input) and its inhabitant is the CLS consequence at those fields.

### `LEAN.md` § Searching — Lean, lines (each to follow the last)

- `MeasurableSet.exists_isCompact_diff_lt`, `exists_isOpen_diff_lt` and `exists_isClosed_diff_lt` are deprecated at the
  pin for `…_sdiff_lt`; a Haar probability on a compact second-countable group (`Measure.addHaarMeasure ⊤`) is
  `InnerRegularCompactLTTop` and `OuterRegular` by instance, so density along clopen cosets needs no martingale theorem:
  a compact set inside and an open set outside, finitely many cosets between (`Counting.tendsto_haarK_bad`, FS131-ICM1).
- `map_add ρ ⟨a, ha⟩ ⟨b, hb⟩` elaborated against `ρ ⟨a + b, add_mem ha hb⟩ = …`, with `ρ` a ring map out of a subring of
  `ℂ` built from a residue map, ran out of heartbeats in `isDefEq`; `rw [show (⟨a + b, _⟩ : R) = ⟨a, ha⟩ + ⟨b, hb⟩ from
  Subtype.ext rfl, map_add]` is instant — inside a `Subring.closure_induction` state the motive explicitly over `z` and
  `hz` (`Counting.ρ_dichotomy`, private; FS131-ICM1).
- `Measure.map_dirac` asks `MeasurableSingletonClass` of both sides and no measurability of the map; for `R → Fin 4` with
  `R = ℤ[U]` over a number field, `Countable (unitRing F)` is `countable_unitRing` with `Countable F` from
  `Finsupp.Countable.of_moduleFinite (R := ℚ)`, and Pi's instance follows. The characters `AddChar R Circle` under the
  library's cylinder σ-algebra have measurable points by `MeasurableSpace.measurableSet_comap` at the singleton of the
  evaluation map (`Counting.measurableSet_singleton_dual`, private; FS131-ICM1).
- `u ∈ Finset.univ` is not `True` to `show`: `simp only [Finset.mem_univ, true_and]` first. `ENNReal.mul_div_cancel_left`
  is not a name at the pin; `ENNReal.div_le_of_le_mul` with `mul_comm` gives `κ·x / κ ≤ x` (FS131-ICM1).

### `ARCHITECTURE.md` (this job's pen for its rows)

`Rigidity/CountCompletion`'s state cell: proved, no `sorry`; `Rigidity/ClassRatio`'s: the three public leaves proved over
six named private leaves, its imports cell `Arith/WeilKloosterman`, `Rigidity/ChainAtTA`; `Rigidity/CountModels`: a new
row. `tools/check_architecture.py`: PASS.

### For the landing to read

- `ClassRatio`'s module docstring still says "skeleton" and names Lemma P as one step; its statements are unchanged and
  the docstring was not edited (the brief allowed proofs, private helpers and import lines). A reworded first line is the
  landing's: "the three public leaves proved over six named private leaves (FS131-ICM1)".
- `ratioAtMost_cert` is the link to line `fs131-wc15` (§ Stage 3): it closes there by K1's checks, K2
  (`FibreCertSound.sum_le_of_certOK`, proved), K3, K4's fibre-share half and K5 — not by K2 alone.
- The count now reads Weil's bound through `tca_uniform` (its docstring says so: "over Weil's bound").
