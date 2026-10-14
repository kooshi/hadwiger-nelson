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
