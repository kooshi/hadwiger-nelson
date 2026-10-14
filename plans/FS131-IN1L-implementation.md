# FS131-IN1L — three ready lanes of the five-colour chain: the largest Haar multiple (H), the smaller set's leaves (C), the names at entropy zero (N)

*The second implementer on the chain under "five colours at the square root of 47" (brief
`data/fs131/briefs/FS131-IN1-three-lanes.md`, written 2026-10-14 04:53 UTC). Branch `fs131-wl1` in the worktree
`.claude/worktrees/fs131-wch`, cut from `fs131-we1` at `aef432ef2`. **The job id is FS131-IN1L, not FS131-IN1.** An
earlier job (the torsion theorem, brief `FS131-IN1-leaves.md`, finished at `cd657318f`) already holds the id and every
path the brief named. I asked the coordinator on 2026-10-14 at about 04:56 UTC, and the coordinator accepted the
rename: this record, `data/fs131/in1l/`, `data/fs131/reports/FS131-IN1L.md`, `tools/fs131_in1l_*.py`, and commit
subjects "FS131-IN1L".*

## Theorems this phase proved

(filled at each stage; see the last stage)

## Stage 1 — SAVED: the join, the readback, the dump before any edit

### 1.1 The join

`git switch -c fs131-wl1` at `aef432ef2`, then `git merge --no-ff fs131-wk7` (at `6b7ec2426`). This made the merge
commit `ac70d2c87`, with no conflict. The merge auto-merged `ARCHITECTURE.md` and `Proofs.lean`, and brought in 107
files: the three new modules, the edits to `ChainAtTA` and `PositiveEntropy`, the planner's `data/fs131/kn7/`, its
record and its tools.

**The build** (`data/fs131/in1l/build.sh 1 8`, under the slot at 10 GiB and 4 CPUs): `==> build: OK — 249 of 249
batches, 6 module(s) rebuilt, 6 module(s) with warnings, 7m8s`, `exit=0` (`data/fs131/in1l/logs/build-1.log`). It rebuilt
`Rigidity.ChainAtTA`, `HaarMultiple`, `PositiveEntropy`, `SolenoidErgodic`, `ZeroEntropyNames` and `Proofs`. Peak memory
was 4.35 GiB summed, 3.48 GiB for one process (`build-1.times`). The only warnings are `declaration uses 'sorry'`. No
module of the library imports the five rebuilt modules except `Proofs`.

### 1.2 The quotations (standing rule 3)

`tools/fs131_in1l_quotes.py` checks each `> ` run of the brief against its source on the main checkout, byte for byte.
All four quotations match (`logs/quotes.out`, exit 0):

- W2, in `data/fs131/REQUEST-2026-10-13.md`;
- the two dated lines in `data/fs131/claims-NF2.md`;
- inventory item 750, in `plans/FS131-close-inventory.md`.

**The planted control** changes one digit in each quotation and requires every quotation to mismatch. It reports
"plant fires" four times (`logs/quotes-plant.out`).

**Two findings about the brief**, both sent to the coordinator and both ruled:

1. *The id collision* (above).
2. *Lane C's fourth leaf is absent.* The brief names it "the rotation-invariance of the point mass at the trivial
   character". It is not in `Rigidity/ChainAtTA.lean`. The file's six `sorry`s are `measurableSet_TA`,
   `rot_preimage_TA`, `exists_nonTorsion_unitVector`, `entropySplit`, `zeroEntropyCarried` and
   `noRamifiedStableDyadic_of_tca`. No statement in the tree is about `RotInv` of a point mass. The leaf exists only in
   words, in `plans/FS131-KN6-chain-first-layer.md` § 3a.3 (l. 226) and § 5.6 (l. 510).

   **The ruling (2026-10-14, received about 05:00 UTC):** add both new public declarations, `rotInv_dirac_one` and
   `zeroEntropyCarried_model`, in `Rigidity/ChainAtTA.lean`. Conditions:
   - no existing statement or definition changes;
   - the dump lists these two as ADDED and everything else as SAME, with the planted control firing;
   - the model is read aloud against § 3a.3;
   - its rotation is quantified as the definition now quantifies it: every non-torsion vector;
   - both declarations print the standard three axioms.

### 1.3 The leaves, each restated in one line beside its plan

**Lane H** (`Rigidity/HaarMultiple`; plan: `plans/FS131-KN7-chain-next.md` § 6.2). Here `a := maxMultiple τ m :=
sSup {c | c • m ≤ τ}`, in `ℝ≥0∞`.

| leaf | the statement, in one line | the plan's route |
|---|---|---|
| `maxMultiple_smul_le` | `a • m ≤ τ` | `Measure.le_iff`, `ENNReal.sSup_mul`, `iSup₂_le` |
| `smul_le_iff_le_maxMultiple` | `c • m ≤ τ ↔ c ≤ a` | `le_maxMultiple`, and monotonicity of `c ↦ c • m` through `maxMultiple_smul_le` |
| `maxMultiple_le_measure_univ` | `a ≤ τ univ` when `m` is a probability | the first leaf at `univ` |
| `sub_maxMultiple_add` | `τ − a • m + a • m = τ` (`τ` finite, `m` a probability) | `Measure.sub_add_cancel_of_le`, with `a • m` finite |
| `not_smul_le_sub_maxMultiple` | `c ≠ 0 → ¬ c • m ≤ τ − a • m` | `(a + c) • m ≤ τ`, so `a + c ≤ a`, so `c = 0` because `a ≠ ⊤` |
| `map_sub_maxMultiple` | a measurable equivalence `e` preserving `τ` and `m` preserves `τ − a • m` | the plan cancels `a • m` after `Measure.map_add` |
| `maxMultiple_self` | `maxMultiple m m = 1` for a probability `m` | `c • m ≤ m` at `univ`, and `one_smul` |

**Lane C** (`Rigidity/ChainAtTA`; plan: `plans/FS131-KN6-chain-first-layer.md` Stage 3b item 5, § 5.6, § 3a.3).

| leaf | the statement, in one line | the plan's route |
|---|---|---|
| `measurableSet_TA` | `T + A` is measurable for the cylinder σ-algebra (`[NumberField F]`) | (i) `χ ∈ TA ↔ ∃ N ≠ 0, χ^N ∈ A`; (ii) `χ ↦ χ^N` is measurable; (iii) `A` is the image of a finite-dimensional real space; (iv) it is a countable union of compact sets, pulled back along the evaluation; (v) the union over `N` |
| `rot_preimage_TA` | `rot u ⁻¹' TA F = TA F` for every unit vector `u` | `rot u` keeps order and carries `ψ` to `ψ ∘ (u ·)`; its inverse is `rot ū` |
| `exists_nonTorsion_unitVector` | `∃ u : unitVectors F, ∀ n ≠ 0, u^n ≠ 1` (every `F`) | `(3 + 4i)/5`, whose powers' numerators are `≡ 3 + 4i (mod 5)` |
| `rotInv_dirac_one` (added by ruling) | `RotInv F (Measure.dirac 1)` | `rot u 1 = 1`, `measurable_rot`, `Measure.map_dirac` |
| `zeroEntropyCarried_model` (added by ruling) | the point mass at `1` meets every hypothesis of `ZeroEntropyCarried`'s clause, at every non-torsion `u`, and its conclusion | `rotInv_dirac_one`, `ksEntropy_dirac`, `one_mem_TA`, `exists_nonTorsion_unitVector` |

**Lane N** (`Rigidity/ZeroEntropyNames`, `Rigidity/SolenoidErgodic`; plan: `plans/FS131-KN7-chain-next.md` § 5.4).

| leaf | the statement, in one line | the plan's route |
|---|---|---|
| N1 `card_words_badStarts_le` | at most `(2a)^{θn+k} g^{2n/k}` words of length `n` have at most `θn` bad starts | `singles` on lists; (A) the weighted count by strong induction; (B) `singles ≤ badStarts + (k − 1)`; (C) sum |
| N2 `mul_card_heavyNames_le` | `c · #heavy ≤ 1` | the cells partition a probability space |
| N3 `mul_measureReal_light_le_blockEntropy` | `γ n · μ(light points) ≤ H_n` | Markov on `−p log p`, and `p < e^{−s} → s p ≤ negMulLog p` |
| N4 `rpow_mul_exp_le_exp` | `(2a)^{θn+k} e^{2(β/8)n} ≤ e^{βn/2}` under `θ log 2a ≤ β/8`, `k ≤ θn` | `Real.rpow_def_of_pos`, products as `have`s, `linarith only` |
| N5 `badStarts_nameOf_le_visits` | bad starts of a name are at most the visits to the light points | `Finset.card_le_card` and `wordBlock_nameOf` |
| N6 `measureReal_lightCells_le` | the light cells of `W` have mass at most `#W · c` | a sum over `W.filter` |
| N7 `exists_forall_exp_le_measureReal_nameCell` (EN2-ZE) | entropy zero gives `μ([x]_n) ≥ e^{−βn}` on a set of mass `≥ 1 − η` for `n ≥ N₀` | the deriver's six steps |
| N8 `measure_frequentVisits_le` | `θ μ{x \| ∃ n, θ n < visits} ≤ μ B` | the port's `Outside.OAI015.excessiveOccupation_measure_bound`, unfolded |
| N9 `IsErgodicOn.null_or_conull_of_ae_invariant` | strict ergodicity gives ergodicity for almost-invariant sets | `⋂_{n ∈ Λ} α n ⁻¹' s` |

### 1.4 The stored statements before any edit

`data/fs131/in1l/lean/StatementDump.lean` is FS131-IE1's dumper, aimed at this job's four modules. It ran on the built
joined tree before any edit. The result is `data/fs131/in1l/statements-before.txt`, 70 constants:

| module | constants |
|---|---|
| `HaarMultiple` | 10 |
| `ZeroEntropyNames` | 26 |
| `SolenoidErgodic` | 1 |
| `ChainAtTA` | 33 |

Of the 70, 61 are named and 9 are internal; the modules declare no axiom.

The reader is `tools/fs131_in1l_statements.py`, FS131-IE1's reader aimed at these modules. It takes the two dumps, the
base commit `ac70d2c87` (for the `example` heads), and `--allow-new data/fs131/in1l/allowed-new.txt` (the two ruled
additions).

- **Against itself:** PASS, with 61 constants and 2 example heads compared (`logs/statements-self.out`).
- **Its control** plants six faults; all 6 are reported (`logs/statements-control.out`):
  - a changed stored type;
  - a changed definition value;
  - a missing leaf;
  - a theorem made a definition;
  - a new public constant off the allow-list;
  - an axiom.

## Stage 2 — SAVED: lanes H and C proved (through `lake env lean`; the build comes at Stage 4)

**Lane H** (`Rigidity/HaarMultiple`): all seven leaves are proved, by the plan's routes with one change:
`map_sub_maxMultiple` needs no cancellation. On a measurable `s`, `Measure.sub_apply` evaluates both sides as
`τ(e⁻¹' s) − a·m(e⁻¹' s)` and `τ s − a·m s`. `MeasurableEquiv.map_apply` holds at every set, and `hτ`, `hm` equate the
terms. So the plan's "hard step" is gone. Two private helpers: `maxMultiple_ne_top` and
`isFiniteMeasure_maxMultiple_smul`. `lake env lean`: 0 errors, 0 warnings (`logs/lean-haar-1.log`).

Axioms, printed from a copy with a planted false `example` (`logs/lean-haar-ax.log`): `maxMultiple_smul_le`,
`map_sub_maxMultiple`, `not_smul_le_sub_maxMultiple` and `maxMultiple_self` each rest on `[propext, Classical.choice,
Quot.sound]`. The plant is reported as an error, and the run exits 1.

**Lane C** (`Rigidity/ChainAtTA`): the three typed leaves and the two ruled additions are proved. `lake env lean`
reports 0 errors, and the only warnings are the three `sorry`s that are not mine: `entropySplit`,
`zeroEntropyCarried` and `noRamifiedStableDyadic_of_tca` (`logs/lean-chain-4.log`).

- `exists_nonTorsion_unitVector`: `u = ⟨3/5, 4/5⟩`. The private `pow_three_add_four_I` gives
  `(3 + 4i)^(n+1) = a + bi` with `a ≡ 3`, `b ≡ 4 (mod 5)` (induction, `linear_combination` with `Complex.I_sq`,
  `omega`). Then `u^n = 1` forces `b = 0`, which is false.
- `rot_preimage_TA`: three private helpers.
  - `rot_mem_TA`: a rotation carries `t · a` to `rot u t · rot u a`, of the same order, with lift
    `ψ ∘ mulLeft (uvRing u)`.
  - `conj_mem_unitVectors`.
  - `rot_conj_rot`: `rot ū ∘ rot u = id`, from `u ū = 1`.
- `rotInv_dirac_one`: `Measure.map_dirac'` with `measurable_rot`; `rot u 1 = 1` closes by `congr 1`.
- `zeroEntropyCarried_model` (`[NumberField F]`, for the measurability of `T + A`). Read aloud against KN6 § 3a.3, l. 224:
  "`ZeroEntropyCarried`: the point mass at the trivial character with `(3 + 4i)/5` — every clause exercised (it is
  rotation-invariant, a probability, of entropy zero, and carried by `T + A` because `1 ∈ TA F`)". The theorem
  states, for `ρ := dirac 1`:
  - `IsProbabilityMeasure ρ`;
  - `RotInv F ρ`;
  - a non-torsion unit vector exists (the planner's `(3 + 4i)/5`, through `exists_nonTorsion_unitVector`);
  - **for every non-torsion `u`**, `ksEntropy ρ (rot u) = 0` (as the definition now quantifies its rotation, by the
    ruling);
  - `ρ (TA F)ᶜ = 0` (`Measure.dirac_apply'` with `measurableSet_TA`, and `one_mem_TA`).

  Every clause of the planner's sentence is there, with the rotation widened from one vector to every non-torsion
  vector. Equal, by the ruling's wording.
- `measurableSet_TA`, by the plan's route (KN6 Stage 3b item 5) in four private lemmas, in a nested
  `section ArchMeasurable`:
  1. `mem_torsion_mul_arch_iff` (route (i)): `χ ∈ T·A ↔ ∃ N ≠ 0, χ^N ∈ A`. The `⇐` direction divides the lift by
     `N` and takes `t := χ · a⁻¹`.
  2. `eq_zero_of_mem_span`: an additive `Δ : G → ℝ` that vanishes on `s` vanishes at every `g` whose image under an
     injective additive `ι : G → W` (a `ℚ`-space) lies in `span_ℚ (ι '' s)`. By `Submodule.span_induction`, a non-zero
     multiple of each such vector is `ι` of an element of `AddSubgroup.closure s`. The `smul` case uses
     `c.den • (c • x) = c.num • x`. `ℝ` has no torsion.
  3. `exists_rat_coords` (route (iii)): a `ℚ`-basis of `span_ℚ (ι G)` chosen inside `ι G`
     (`exists_linearIndependent`, finite by `LinearIndependent.finite`), with coordinates `q j : G →+ ℚ`. Every
     additive `ψ` is `∑ q_j · ψ(g_j)`, by (2) at `Δ := ψ − ∑ ψ(g_j) q_j`, which vanishes on the basis.
  4. `measurableSet_archFun` (route (iv)): `{f : G → ℂ | ∃ ψ, f = exp ∘ ψ}` is `⋃_k Φ(closedBall 0 k)`, with `Φ` the
     continuous parametrization by `ℝ^κ`. Each image is compact, hence closed, hence measurable for the product
     σ-algebra, which is Borel because `G` is countable (`Pi.borelSpace`).

  The theorem itself takes `W := fieldI F` (finite-dimensional by the `NumberField` instance) and
  `ι g := ⟨g, unitRingOver_le_planeOverSubring F g.2⟩`. Then `TA F = ev ⁻¹' ⋃_{N ≠ 0} (·^N)⁻¹' archFun` (route (v)),
  measurable in the cylinder σ-algebra by its definition as a comap. As the plan said, Lemma F is not read. A scratch
  copy printed `[propext, Classical.choice, Quot.sound]` (`logs/lean-ta-ax.log`).

**Docstrings left stale** (not mine to edit: the brief allows proofs, private helpers and imports). `ChainAtTA`'s module
docstring still lists `measurableSet_TA`, `rot_preimage_TA` and `exists_nonTorsion_unitVector` among its leaves.
`HaarMultiple`'s and `ZeroEntropyNames`' headers still say "skeleton". A draft for the landing is in § Drafts.

**Re-price** (Done means 2, from the first leaves finished). Lane H's seven leaves took about 15 minutes, lane C's three
easy leaves about 15. `measurableSet_TA`, the leaf the second planner called long, took about 25 minutes: one scratch
file, six elaborations, about 120 lines. Every route held as planned, and no statement resisted. Lane N is priced at:
- N1, the count: 1–2 hours;
- N7, the assembly: 1–2 hours;
- the other seven: about 10 minutes each.

That is three to four hours for lane N, against the planner's "N1 is the longest leaf". The slowest steps are the
`ℝ≥0∞`/`ℝ` bookkeeping and the `List`/`Fin` bridge of N1, as both planners said.
