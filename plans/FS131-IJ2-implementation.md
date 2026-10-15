# FS131-IJ2 — the five-colour chain: one attribute on `archTop`; M3 (`InvariantMeasure`) and M2b (`BochnerTau`)

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-IJ2-m3-m2b.md` (on `main`). Branch `fs131-wt4`, cut from
`fs131-wt3` at `1e438c171` in the worktree `.claude/worktrees/fs131-wq1`. Working files: `data/fs131/ij2/`. Laptop: 12
cores, 31 GB.*

## Theorems this phase proved

Each [kernel], axioms exactly `[propext, Classical.choice, Quot.sound]`, printed from build 2's tree
(`data/fs131/ij2/axioms-after.txt`; reader `tools/fs131_ij2_axioms.py` PASS, control 4 of 4); under
`HadwigerNelson.Rigidity`.
- **M3, `Rigidity/InvariantMeasure`** (2 leaves): `exists_shiftInvariant_on`, `exists_rotInvariant_of_shiftInvariant`;
  with them **`invariantMeasureOnClosed_of_countable : ∀ (F : Subfield ℝ) [Countable ↥(unitRing F)],
  InvariantMeasureOnClosed F`** (every nonempty closed measurable set of colourings `R → Fin 4` stable under the shifts
  and the rotations carries a probability measure invariant under both) has no leaf below it. 19 records, all CLEAN.
- **M2b, `Rigidity/BochnerTau`**, three of its four leaves: **`finite_quotient_nsmul : ∀ (F : Subfield ℝ) [NumberField ↥F]
  (N : ℕ), N ≠ 0 → Finite (↥(unitRing F) ⧸ (nsmulAddMonoidHom N).range)`** (J28V-7); **`exists_twisted_parts`** (a
  finite measure on `R̂` with `τ′_∅`-continuous transform `φ` has `φ = Σ_{t ∈ T} ψ_t` pointwise, each `t̄·ψ_t`
  positive-definite and `archTop`-continuous, the masses `Re ψ_t(0)` summable). 53 of the module's 55 records CLEAN.
- **Not a theorem yet**: `bochnerOn_tauPrime` is proved over `archimedean_support`, the one leaf left `sorry`; both print
  `sorryAx`, sourced in `archimedean_support` alone.
- The attribute on `archTop` (`ContinuityGroup`): its 28 records CLEAN, as before.

## Stage 1 — SAVED: the readback, the leaves beside their plans, the stored statements before any edit

**1.1 The brief's quotations** (standing rule 3; `tools/fs131_ij2_quotes.py`, FS131-IJ1's reader unchanged in logic, against
`main`'s tree): **5 quotations, 5 MATCH** (`data/fs131/ij2/logs/quotes.log`) — W2 (`data/fs131/REQUEST-2026-10-13.md`),
the two dated lines of 2026-10-14 (`data/fs131/claims-NF2.md`), inventory items 823 and 863
(`plans/FS131-close-inventory.md`). **Control** (`--plant`): one character of each quotation changed in turn, each
planted quotation MISMATCH and the other four MATCH, 5 of 5 (`logs/quotes-plant.log`). No finding about the brief.

**1.2 The tree.** `lake build --no-build` under the slot: "All targets up-to-date (6113 jobs)", exit 0
(`logs/nobuild0.log`): the compiled library is current for `fs131-wt3` at `1e438c171`, as the brief says.

**1.3 Each leaf, its statement in one line, beside its plan** (plans: `plans/FS131-KR1-chain-map.md` § 2.1, § 2.2 and the
table of § 4.3; the last implementer's notes, `plans/FS131-IJ1-implementation.md` § 5.5). `R = unitRing F`,
`X = R → Fin 4`, `T + A = TA F`.

| module | leaf | the statement | the plan's route |
|---|---|---|---|
| M3 `InvariantMeasure` | `exists_shiftInvariant_on` | `R` countable, `K ⊆ X` nonempty, closed, measurable and shift-stable ⇒ a probability measure on `X` with `μ Kᶜ = 0`, fixed by every shift `c ↦ c(· + y)` | average the push-forwards of `δ_c` with the weights `(w n)²`; a limit point (§ 4.3); or (IJ1 § 5.5) a cluster point in `FiniteMeasure K` |
| | `exists_rotInvariant_of_shiftInvariant` | `K` closed, measurable and rotation-stable, `μ₀` a shift-invariant probability with `μ₀ Kᶜ = 0` ⇒ a probability with `μ Kᶜ = 0`, fixed by every shift and every rotation `c ↦ c(u ·)` | the same averaging over the unit vectors, `shift_y ∘ rot_u = rot_u ∘ shift_{uy}` |
| | (composed) `invariantMeasureOnClosed_of_countable` | `InvariantMeasureOnClosed F` when `R` is countable | the two leaves |
| M2b `BochnerTau` | `finite_quotient_nsmul` | `R ⧸ N·R` is finite for `N ≠ 0` (number field) | finite subsets of `R` span free groups of rank `≤ [L:ℚ]` |
| | `archimedean_support` | a finite measure on `R̂` whose transform is `archTop`-continuous is carried by `archChars R` | (hard) lattices `5^{−k}c₀𝓞_L`, tightness, Prokhorov on `V*`, uniqueness |
| | `exists_twisted_parts` | a finite `σ` with `τ′_∅`-continuous transform `φ`: `φ = Σ_{t ∈ T} ψ_t` pointwise (`HasSum`), each `t̄·ψ_t` positive-definite and `archTop`-continuous, `Σ_t Re ψ_t(0)` summable | (hard, first) twisted Riemann sums over `R ⧸ N′R`, Cauchy by uniform continuity of `φ` |
| | `bochnerOn_tauPrime` | `BochnerOn (tauPrime F)` | M2a on each part, `archimedean_support`, the sum, uniqueness |

**1.4 The stored statements before any edit.** `data/fs131/ij2/lean/StatementDump.lean` (FS131-IJ1's dumper aimed at the
eight modules this job's edits can reach: the three it writes — `ContinuityGroup` (the attribute), `InvariantMeasure`,
`BochnerTau` — and the five downstream of `ContinuityGroup` that the attribute recompiles — `CountTorus`, `CountResidue`,
`CountCompletion`, `CountExtension`, `CountDescent`), run on the current build before any edit: `statements-before.txt`
(13.4 MB; committed as `.xz`, sha256 in `statements-before.sha256`), 189 constants (49, 3, 4, 13, 70, 33, 6, 11 by module).

**1.5 Class binders** (item 847's defect). Each of the three files declares one section variable, `variable (F : Subfield
ℝ)` (`ContinuityGroup` l. 35, `InvariantMeasure` l. 29, `BochnerTau` l. 32): no section declares a class binder, so no
stored type can lack one. The files declare no instance; their definitions are `ContinuityGroup`'s `profTop`, `archTop`,
`tauPrime` and the private `archHom`, `fivePow`, each with its written binders in its stored type (`archTop`, `tauPrime`,
`archHom` carry `[NumberField ↥F]`, as written; `profTop`, `fivePow` none). No finding.

## Stage 2 — SAVED: the attribute on `archTop`, and the lint

**2.1 The attribute** (item 863 ruling 1). `Proofs/HadwigerNelson/Rigidity/ContinuityGroup.lean` l. 43–44: `@[reducible]`
became `@[reducible, nolint unusedArguments]` (one attribute block, `LEAN.md` FS131-LP1), with a one-line `--` comment
above it giving the reason ("`[NumberField F]` is not read by the value at the pin; it is kept, since dropping it moves the
stored types of `archTop`, `tauPrime` and every statement over them (FS-131 inventory item 863, ruling 1)"). `git diff`
on the file: that comment line and that attribute line, nothing else.

**2.2 Build 1** (with M3's proofs in their module, stage 3; `./scripts/build.sh` under the slot, `MEMMAX=10G BATCH=8`;
`logs/build1.log`, full output `logs/build1-full.log`, gate log `build/gate/build/20261014T151200Z-3563909.log`): `OK — 256 of
256 batches, 9 module(s) rebuilt, 17 module(s) with warnings, 7m57s`, exit 0. Rebuilt: `InvariantMeasure`,
`ContinuityGroup`, `BochnerTau`, `CountTorus`, `CountResidue`, `CountCompletion`, `CountExtension`, `CountDescent`,
`Proofs`. **No warning from `ContinuityGroup` or `InvariantMeasure`**; `BochnerTau`'s four warnings are its four leaves'
``declaration uses `sorry` ``.

**2.3 The lint** (`lake lint --no-build -- --no-build --trace` under the slot). **Control first, on the tree before the
attribute** (`logs/lint-before.log`): exit 1, `unusedArguments` "Failed with 1 messages", the one message
`ContinuityGroup.lean:42:1: error: HadwigerNelson.Rigidity.archTop 1 unused argument: argument 2: [NumberField ↥F]` — the
finding present, the gate red and naming it. **After build 1** (`logs/lint-after1.log`): exit 0, 14 of 14 linters
"Passed!", `-- Linting passed for Proofs.`

**2.4 No statement changed, from the kernel's side** (stage 1's dump against build 1's, `statements-b1.txt`, `.xz` +
sha256; `tools/fs131_ij2_statements.py before b1 1e438c171`, FS131-IJ1's reader aimed at the eight modules, its ruled-change
options unused): **PASS** (`statements-compare-b1.out`) — 111 named constants (kind, stored type, module), 30 data
definitions' values (`profTop`, `archTop`, `tauPrime` among them: the attribute moved no stored term), 3 example heads; no
new public constant; 16 new private constants, all `InvariantMeasure`'s helpers (stage 3); internal constants 78 → 80.
The five downstream modules unchanged. **Control** (`--control`, 8 plants: an M3 leaf's type, `archTop`'s value, an M2b
leaf missing, `count_of_oneAvoidingDensityBound`'s type downstream, `tauPrime` moved, a new public constant, an axiom, a
leaf become a definition): **8 of 8 reported** (`statements-control-b1.out`).

## Stage 3 — SAVED: M3, `Rigidity/InvariantMeasure`, both leaves

Written against a copy (`data/fs131/ij2/work/InvariantMeasure.lean`; rounds `logs/M3-1.log`, `M3-2.log`, the second exit 0
with **no warning**, under `lake env lean` with the lakefile's two options), then copied over the module; built in build 1
(§ 2.2) with no warning. `git diff -U0` on the module removes the two `sorry` lines and adds proofs, private helpers and
one `--` comment; no statement, docstring or import changed. About 305 lines against the plan's 500–800 (about 0.5).

| leaf | route as planned? |
|---|---|
| `exists_shiftInvariant_on` | **another route, shorter** (no almost-invariant weights): FS133-IB1's (`Plane/OneClass/InvariantLaw` on `main`, private there): a closed nonempty class of probabilities on a compact space, stable under one continuous map and under finite uniform averages, holds a probability the map fixes (a Cesàro limit along an ultrafilter); a commuting family is fixed at once by compactness of the class (`IsCompact.inter_iInter_nonempty`), the finite case by induction. Here the class is `{μ : μ Kᶜ = 0}` (closed by the portmanteau inequality for the closed `K`), the maps the shifts, the start the point mass at `c₀ ∈ K` |
| `exists_rotInvariant_of_shiftInvariant` | the same theorem with the class `{μ : μ Kᶜ = 0 ∧ every shift fixes μ}` (closed: a weak limit of fixed probabilities is fixed) and the maps the rotations, which commute with each other; a rotation keeps the class by `shift_y ∘ rot_u = rot_u ∘ shift_{uy}` |

**Private helpers** (16): from `Plane/OneClass/InvariantLaw` (FS133-IB1) with their proofs — `avgMeasure` (a private
definition), `avgMeasure_apply`, `isProbabilityMeasure_avgMeasure`, `avgMeasure_map`, `integral_avgMeasure`,
`map_eq_of_tendsto`, `map_eq_of_tendsto_of_eventually`, `measure_compl_eq_zero_of_tendsto`, `isClosed_setOf_of_tendsto`,
`exists_fixed_of_average`, `exists_common_fixed` (its averaging step through `avgMeasure_map_eq`); new —
`avgMeasure_eq_zero`, `avgMeasure_map_eq`, `continuous_shiftCol`, `continuous_rotCol`, `map_compl_eq_zero`. The copies
are private, so no name is declared twice (their stored names carry the module); `Plane/OneClass/InvariantLaw` is not on
this branch's ancestry and imports the `[OAIMath2026]` port, so it is not imported here. No import added (a trial with
`Mathlib.MeasureTheory.Measure.Portmanteau` showed it unneeded: `logs/M3noimp.log`). Every hypothesis of both leaves is
read (`hmeas` by `Measure.map_apply` and `Measure.dirac_apply'`).

**Re-priced:** M3 at about 0.5 of its plan, in two elaboration rounds. **A docstring now describes another route**: the
module's docstring and `Herglotz`'s docstring of `exists_almostInvariant_weights` ("Read by M2a … and M3") name the
weights; M3 reads none. Docstrings are not mine to edit here; a correction owed (report).

## Stage 4 — SAVED: M2b's hard leaf, `exists_twisted_parts`, proved over `finite_quotient_nsmul`

Written against copies (`data/fs131/ij2/work/BochnerTwist.lean`, `chunk2.lean` … `chunk4.lean`, assembled as
`work/BochnerTau.lean`; rounds `logs/M2b-1.log` … `M2b-9.log`, the last exit 0 with no warning but the three remaining
leaves' ``declaration uses `sorry` ``), then copied over the module. `exists_twisted_parts` has no `sorry` of its own; it
reads `finite_quotient_nsmul` (a leaf, still `sorry`). Not built yet (the build is a later stage).

**The route** (the plan's twisted Riemann sums, made positive and taken along an ultrafilter; no Cauchy argument). At level
`n`, with `N = (n+1)!` and representatives `x_c` of the cosets `c ∈ R ⧸ N·R` of archimedean size `< 1/(n+1)`:
- the weight `W_n(t, χ) = |Σ_c t̄(x_c) χ(x_c)|² / |R ⧸ NR|² ∈ [0, 1]` and the part `K_n(t, y) = ∫ χ(y) W_n(t, χ) dσ`, kept
  only for `t` trivial on `N·R`; `t̄·K_n(t, ·)` is positive-definite (a non-negative weight, `posDef_twisted`);
- **Parseval** over the complex characters of the finite quotient (`AddChar.sum_apply_eq_ite`, read on `R` by `liftChar`,
  back by `descChar`): `Σ_t W_n(t, χ) = 1`, so any finite set of such `t` has weight `≤ 1` (Bessel, `sum_twW_le`) and
  `‖φ(y) − Σ_S K_n(t, y)‖ ≤ σ(univ) − Σ_S K_n(t, 0)` (`norm_sub_sum_twK_le`);
- **concentration** (`concentration`): from `τ′_∅`-continuity, `∫ ‖χ(w) − 1‖ dσ < ε` on `M·R ∩ B_δ` (`exists_E_small`),
  so at every finer level the characters of `R ⧸ (M+1)!·R` keep weight `≥ σ(univ) − ε` (orthogonality on the coarse
  quotient and Cauchy–Schwarz on the fibre sizes, `card_sq_le_pairs`);
- **continuity** (`twK_cont`): reindexing the cosets by `c ↦ c + [z]` gives `‖t̄(z)χ(z) − 1‖·W ≤ |G|⁻¹ Σ_c ‖χ(w_c) − 1‖`
  with `w_c ∈ N·R` small, so `t̄·K_n(t, ·)` moves by `≤ ε` under arch-small `z`;
- `ψ_t(y)` is the limit of `K_n(t, y)` along an ultrafilter finer than `atTop` (compactness of a closed ball in `ℂ`); the
  four clauses pass to the limit. Representatives of small size need no density theorem: `r ↦ r/5` permutes the finite
  quotient, so `r/5^{ek}` lies in the coset of `r` (`exists_small_rep`).

**Imports added**: `Mathlib.Analysis.Fourier.FiniteAbelian.PontryaginDuality` (characters of finite abelian groups),
`Mathlib.Algebra.Order.Chebyshev` (`sq_sum_le_card_mul_sum_sq`); the module's `open` line gains `Filter Topology`.
Whether either moved a stored term is the build stage's dump. **Private helpers of `ContinuityGroup` read** through
Batteries' `open private` (`archHom`, `archTop_eq`, `eventually_archTop`, `norm_archHom_nsmul`, `fivePow`, `nsmul_fivePow`,
`inv_five_mem`, `exists_nsmul_mem_of_mem_nhds_profTop`), not restated: one fact proved once, `ContinuityGroup` unedited.

**Re-priced from the hard leaf** (the brief's ask): the leaf with its helpers is about 900 lines (the module grew from 65
to 972), against IJ1's 900–1,200 for all of M2b. The rest, priced from this leaf's rate: `finite_quotient_nsmul` 80–150,
`bochnerOn_tauPrime` 120–200 (a composition over M2a, `archimedean_support` and uniqueness), `archimedean_support`
450–700 (the lattices `5^{−k}Λ`, a one-variable Dirichlet bound for tightness uniform in `k`, Mathlib's Prokhorov on
`EuclideanSpace ℝ (Fin d)`, uniqueness): **M2b about 1,550–1,950 lines in all** — under the 2,000 the brief names, so no
message was sent; about 1.3–1.6 times IJ1's re-price, 0.7–0.8 of the planner's 2,000–2,500.

## Stage 5 — SAVED: M2b's other two proved leaves, build 2, the receipts; `archimedean_support` left

**5.1 `finite_quotient_nsmul`** (`work/FQ.lean`, rounds `logs/FQ-1.log`, `FQ-2.log`; about 60 lines): by contradiction, an
infinite quotient has `N^d + 1` cosets (`d = [L : ℚ]`); their lifts span a finitely generated, torsion-free, hence free
(`Module.free_of_finite_type_torsion_free'`) `ℤ`-module `B` of rank `≤ d` (a basis stays independent over `ℚ` in `L`,
`LinearIndependent.iff_fractionRing`); two lifts agree in their coordinates modulo `N` (pigeonhole into
`Fin r → ZMod N`), so their difference is in `N·B ⊆ N·R`. Two private helpers: `toFieldI` (the inclusion `R →+ L`, a
private definition) and `toFieldI_injective`.

**5.2 `bochnerOn_tauPrime`** (about 90 lines; over `archimedean_support`): the parts of `exists_twisted_parts`; each
`t̄·ψ_t` is the transform of a finite `ρ_t` (`bochnerHerglotz_of_countable`), carried by `A` (`archimedean_support`); `ν =
Σ_t (· * t)_* ρ_t` (`Measure.sum`) has mass `Σ_t Re ψ_t(0) < ∞` and transform `Σ_t ψ_t = φ` (`integral_sum_measure`,
`HasSum.tsum_eq`); uniqueness (`measure_eq_of_fourier`) gives `σ = ν`; `ν` is carried by `T·A = TA F`
(`measurableSet_TA`, `measurable_mulRight`), and `contChars_tauPrime` turns that into the statement.

**5.3 Build 2** (`./scripts/build.sh` under the slot, `MEMMAX=10G BATCH=8`; `logs/build2.log`, full output
`logs/build2-full.log`, gate log `build/gate/build/20261014T160009Z-3758166.log`): `OK — 256 of 256 batches, 2 module(s)
rebuilt, 17 module(s) with warnings, 7m32s`, exit 0 (rebuilt: `BochnerTau`, `Proofs`). **The only warning from my three
files is `BochnerTau.lean:106:8: declaration uses `sorry`` — `archimedean_support`, the remaining leaf.**

**5.4 No statement and no definition changed, from the kernel's side** (stage 1's dump against build 2's,
`statements-after.txt`, `.xz` + sha256): **PASS** (`statements-compare.out`) — 111 named constants, 30 data definitions'
values, 3 example heads; no new public constant; 67 new private constants (16 of `InvariantMeasure`, 51 of `BochnerTau`);
internal 78 → 132. **The two imports added to `BochnerTau` and its `open … Filter Topology` moved no stored term**, and
the five downstream modules are unchanged. Control: 8 of 8 (`statements-control.out`).

**5.5 The axioms of every declaration of my three files** (`data/fs131/ij2/lean/Axioms.lean` → `axioms-after.txt`;
`tools/fs131_ij2_axioms.py` → `axioms-verdict.out`): **PASS** — 102 records: `ContinuityGroup` 28, `InvariantMeasure` 19,
all CLEAN; `BochnerTau` 55, 53 CLEAN, 2 OPEN-LEAF (`archimedean_support` and `bochnerOn_tauPrime`, each sourced in
`archimedean_support` alone). The planted record (`positive_entropy_rigidity_of_polishSpace`) is reported resting on the
declared printed theorem. `--control`: 4 of 4 (`axioms-control.out`).

**5.6 Lint and architecture.** `lake lint --no-build -- --no-build --trace` after build 2 (`logs/lint-after2.log`): exit 0,
14 of 14 Passed (its control is § 2.3's red run). `tools/check_architecture.py` (`logs/architecture.log`): RESULT PASS,
with the rows of `InvariantMeasure` ("no `sorry`") and `BochnerTau` ("1 leaf `sorry`") updated on this branch. Not run
(as for FS131-IJ1): `scripts/axioms.sh`, `assumptions.sh`, `vacuity.sh`, `dupnames.sh` — my new constants are all
private, so no name can be doubled.

**5.7 Why `archimedean_support` is left, and its route.** My count read about 390k at build 2; the leaf priced at
450–700 lines would not close with the receipts inside the brief's line, so it is handed on with its route. **The route,
refined here (the plan's, made concrete; one mind, not elaborated):**
1. A `ℚ`-basis `b_j ∈ R` of `L` (`c·`(an integral basis), `c·𝓞_L ⊆ R` by `ContinuityGroup`'s private
   `exists_nat_mul_integers_mem`, read by `open private` as this module reads `archHom`), with additive coordinates
   `q_j : R → ℚ`, `r = Σ_j q_j(r) b_j`.
2. `t_k : R̂ → E = EuclideanSpace ℝ (Fin d)`, `t_k(χ)_j = 5^k · arg χ(b_j / 5^k)` (`fivePow`; measurable by
   `Complex.measurable_arg`). For `y = Σ n_j b_j/5^k`, `exp(i⟨t_k χ, Q y⟩) = χ(y)` with `Q y = (q_j(y))_j`; so
   `charFun (t_k)_*ρ` agrees with `ψ` on `Q(Λ_k)`, `Λ_k = ⊕ ℤ b_j/5^k`.
3. **Tightness, uniform in `k`**: `ρ{|t_k(χ)_j| > M} ≤ 2·sup{m − Re ψ(y) : ‖ι y‖ ≤ 4π‖ι b_j‖/M}`, from the one-variable
   inequality `(1/L)Σ_{n<L}(1 − cos nθ) ≥ 1/2` for `2π/L ≤ |θ| ≤ π` (`|Σ_{n<L} e^{inθ}| ≤ π/|θ|`), with `L =
   ⌈2π·5^k/M⌉`; for `M > π·5^k` the event is empty. Then `isCompact_closure_of_isTightMeasureSet` (root namespace) and
   a cluster point `μ̃` along an ultrafilter, as `exists_twisted_parts` takes its limit.
4. `e : E → R̂`, `e(t)(r) = Circle.exp ⟨t, Q r⟩`, an archimedean character; `ν = e_*μ̃` has transform `charFun μ̃ ∘ Q`,
   equal to `ψ` on `D = ⋃_k Λ_k`, and on all of `R` by density: `Q(D) = ℤ[1/5]^d` is dense in `E`, and `Q(d_m) → Q(r)`
   forces `ι(d_m − r) = Σ_j q_j(d_m − r) ι(b_j) → 0`, so `ψ(d_m) → ψ(r)` (only continuity at `0` is read, through
   `∫ ‖χ(w) − 1‖ dρ`, as in `exists_E_small`).
5. Uniqueness (`measure_eq_of_fourier`): `ρ = ν`; `ν` is carried by `range e ⊆ A`, measurable as a countable union of
   compact images of balls (the route of `measurableSet_TA` in `ChainAtTA`).

## Drafts for the landing (files this job does not write; each names its slot)

**The audit's block** (`scripts/Axioms.lean`, CLEAN section, after FS131-IJ1's block): `data/fs131/ij2/draft-axioms-block.lean`,
5 `#print axioms` lines — `InvariantMeasure`'s 3 public declarations and `BochnerTau`'s `finite_quotient_nsmul`,
`exists_twisted_parts` — CLEAN at build 2, generated from the built tree's print. `archTop`'s attribute adds no record.
`bochnerOn_tauPrime` and `archimedean_support` join when the leaf lands.

**The models** (`LEAN.md` § The gate). `exists_shiftInvariant_on`: any `F` with `unitRing F` countable (`F = ⊥`), `K =
Set.univ` (nonempty, closed, measurable, stable under every shift). `exists_rotInvariant_of_shiftInvariant`: `K =
Set.univ` and `μ₀` the point mass at a constant colouring (a shift fixes it); `X₄(⊥)` with the two-colouring of `ℚ²` is
the consumer's model (`SpectralChain.isClosed_X4`, `measurableSet_X4`, `shift_mem_X4`, `rot_mem_X4`).
`finite_quotient_nsmul`: `N = 1`. `exists_twisted_parts`, `archimedean_support`: the point mass at the trivial character
(constant transform `1`, continuous for every topology). Each note names objects for the hypotheses they satisfy only;
none is a declaration (this job adds no public constant).

**`LEAN.md` § Searching — Lean**, five lines (each follows the last line there):
- "A proof module may read another module's private lemmas with Batteries' `open private <names> from <module>` (after
  the module's `variable`s): `Rigidity/BochnerTau` reads `ContinuityGroup`'s `archHom`, `eventually_archTop`, `fivePow`,
  `exists_nsmul_mem_of_mem_nhds_profTop`, … — one fact proved once, the other module unedited; a statement that names
  `‖archHom F r‖` is elaborated under `open scoped Classical in` so its norm instance is the private lemma's (FS131-IJ2)."
- "A bounded complex sequence needs no Cauchy argument to have a limit with every closed property it has eventually: take
  an ultrafilter finer than `atTop` (`Ultrafilter.of atTop`, `Ultrafilter.of_le`) and
  `(isCompact_closedBall 0 m).ultrafilter_le_nhds`; positive-definiteness, sums over a finite set and inequalities pass to
  it by `tendsto_finsetSum`, `ge_of_tendsto`, `le_of_tendsto_of_tendsto'` (`Rigidity.exists_twisted_parts`, FS131-IJ2)."
- "At the pin `HasSum` is `HasProd`'s additive form over a `SummationFilter`: `unfold HasSum` and
  `rw [SummationFilter.unconditional_filter, Metric.tendsto_atTop]` give the `ε`–finite-set form. `AddChar.ext` takes
  both characters explicitly (`AddChar.ext _ _ fun g => …`); `Fintype (ZMod N)` needs `NeZero N` as an instance
  (`haveI : NeZero N := ⟨hN⟩` first); the complex characters of a finite abelian group sum by `AddChar.sum_apply_eq_ite`
  (`Mathlib.Analysis.Fourier.FiniteAbelian.PontryaginDuality`) (FS131-IJ2)."
- "`set G := <a type>` in a proof whose hypotheses mention that type replaces it in their types and shadows the variables
  (`x✝`): later hypotheses then speak of the shadowed copy and `rw [hx]` finds nothing. Write the type out (FS131-IJ2,
  `twK_cont`). A docstring must directly precede its declaration: `open scoped Classical in` goes before the docstring."
- "Representatives of small archimedean size for the cosets of `N·R` need no density theorem: `r ↦ r/5` permutes the
  finite quotient (`1/5 ∈ R`), so by pigeonhole `r/5^e ≡ r` and then `r/5^{ek} ≡ r` for every `k`
  (`BochnerTau`'s private `exists_small_rep`, FS131-IJ2)."
