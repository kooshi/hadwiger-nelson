# FS-131, wave 10 — implementation record: the spectral inputs and the character colouring's last leaf

*Job FS131-I10A (de Bruijn, the implementer), 2026-10-06, branch `fs131-w10` (from the planner's `f919973e`). Brief:
`data/fs131/briefs/FS131-I10A-wave10.md`. Plan: `plans/FS131-w10-kernel-plan.md` §§ 2, 3, 5.1, 5.2, 5.5.*

**What I may change, and what I may not.** Mine: the proof of each open leaf of `Proofs/HadwigerNelson/Arith/SpectralInputs.lean` (eight) and of
`mem_archimedean_unitRing_iff` in `Proofs/HadwigerNelson/Arith/CharacterColouring.lean`; new helper declarations in those two files, under names no
other module declares; a block "FS131-I10A" in `scripts/Axioms.lean`; this record; `tools/fs131_i10a_*.py`; `data/fs131/i10a/`; the report. Not mine: any
statement, hypothesis, conclusion or definition of the skeleton (a leaf that is false or too weak as stated goes to Keryx by message); a new `axiom`;
`native_decide`; the wave's other files (`StationaryRatio`, `StandingFive`); any landed module; `main`; the gate; another branch.

## Theorems this phase proved

All kernel-checked on this branch by `./scripts/build.sh` under the slot (the log named at each stage); axioms `[propext, Classical.choice, Quot.sound]`
for each, printed with a control that shows `sorryAx` (the stage's axioms log). The branch does not run the gate, so the audit is the landing's.

- **`SpectralInputs.measurableSet_factorSigma_iff`** — J45-N2 (i): the events with `l`-continuous indicators are a σ-algebra. [kernel on this branch]
  `Proofs/HadwigerNelson/Arith/SpectralInputs.lean`. Read against Lemma N2 (`plans/FS84-SI-D-derivation.md:126–135`): "the sets whose indicators lie in
  `H_S` form a σ-algebra `𝒜_S`".
- **`SpectralInputs.contVec_eq_lpMeas`** — J45-N2 (ii): "these `f` form `L²(𝒜_S)`". [kernel on this branch] same file. Read against the same lemma:
  "`H_S = L²(𝒜_S)`".
- **`SpectralInputs.measurableSet_preimage_factorSigma`** — J45-N2 (iii): "for a translation-invariant σ-algebra". [kernel on this branch] same file.
- **`SpectralInputs.condExpL2_mem_contVec`, `condExpL2_eq_self_iff`, `inner_sub_condExpL2_eq_zero`** — J45-N2's last clause, "`Π(E_S) = E[·|𝒜_S]`", in
  the form the plan asked to be stated at the first leaf (§ 4's table, row J45-N2): Mathlib's `condExpL2` for `factorSigma` takes its values in
  `contVec`, fixes exactly `contVec`, and its residual is orthogonal to `contVec`. **New statements, one mind (mine)**: they are not in the planner's
  skeleton and are owed its read-back. [kernel on this branch] same file.
- Helpers (same file, [kernel on this branch]): `mem_factorSets_iff` (`A ∈ factorSets ↔ MeasurableSet A ∧ μ(T_y⁻¹A ∆ A) → 0`), `isClosed_contVec`,
  `add_mem_contVec`, `neg_mem_contVec`, `sub_mem_contVec`, `const_mem_contVec`, `indicatorConstLp_mem_contVec(_iff)`, `compMeasurePreserving_compLp`,
  `lipschitz_comp_mem_contVec`, `empty_`/`compl_`/`union_`/`iUnion_mem_factorSets`, `setOf_lt_mem_factorSets`, `aestronglyMeasurable_of_mem_contVec`,
  `mem_contVec_of_aestronglyMeasurable`, `norm_indicatorConstLp_two`, `norm_comp_indicator_sub`, `tendsto_sqrt_toReal_iff`, `lipschitzWith_clamp`,
  `abs_clamp_sub_le`; definitions `factorSetsSpace` (the σ-algebra whose sets are `factorSets`) and `clamp`, each with a spec example.

## Stage 1 — SAVED (FS131-I10A): the readback, the build as given

**Quotations** (standing rule 3), by script — `grep -F` of each quoted string in the file the brief names; `data/fs131/i10a/logs/quotations.txt`:
**seven of seven match** (`CLAUDE.md` § Counter-priors; inventory items 484, 485, 477, 478 in `plans/FS131-close-inventory.md`, read on `main`, where
they are filed; the plan's §§ 5.2 and 5.5 headings in this worktree).

**Read**: the planner's record whole; `SpectralInputs.lean` and `CharacterColouring.lean` whole; `SpectralChain.lean` lines 51–230 and 400–530 (the
foundation: `Dual`, `rot`, `RotInv`, `PosDef`, `BochnerHerglotz`, `Interface`, `posDef_corr`, `rotInv_of_isTraceSpectral`); the derivation entries
J45-N1, -N2, -SI-4, -SP-oi, -SP-if (`plans/FS84-SI-D-derivation.md:419–556`) and their lemmas (§ 2.1 lines 105–135, § 2.2 lines 142–162, § 4.2 lines
296–319); the erratum for `A` (`plans/FS89-derivation.md:32`).

**The branch as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0, "all 1771 modules already up to
date", 21 `declaration uses 'sorry'` warnings: `CharacterColouring` 1, `SpectralInputs` 8, `StationaryRatio` 3, `StandingFive` 9
(`data/fs131/i10a/logs/build-0-as-given.log`).

**The statement check** is `tools/fs131_i10a_statements.py <base> <files>`: every declaration of the base commit's file must appear verbatim in the
working tree — a theorem up to its first ` :=`, anything else whole, docstrings included. Its two planted faults fire (`--self-test`: one character of
a theorem's statement changed; one line of a definition dropped).

## Stage 2 — SAVED (FS131-I10A): group 1, the factor trio (J45-N2's measure-theoretic half)

**The statement the proofs derive from** is simpler than the plan's: `A ∈ factorSets ↔ MeasurableSet A ∧ μ(T_y⁻¹A ∆ A) → 0` along `l`
(`mem_factorSets_iff`; from Mathlib's `dist_indicatorConstLp_eq_norm` and the `rfl` `Lp.indicatorConstLp_compMeasurePreserving`). With it the empty
set, complements, finite unions and invariance under commuting maps are set identities; countable unions use `isClosed_contVec` and
`tendsto_indicatorConstLp_set`. Leaf (ii)'s `⊆` is the plan's route: `1_{f > t}` is the `L²`-limit of the clamps `max 0 (min 1 ((n+1)(f − t)))`, each in
`contVec` by `lipschitz_comp_mem_contVec`; the limit is bounded by `‖1_{0 < f − t < 1/(n+1)}‖₂ → 0`, with no dominated-convergence theorem. `⊇` is
`Lp.induction_stronglyMeasurable`. **A route that fails, found on paper before any Lean**: Chebyshev on `{f ∘ T_y > t} ∆ {f > t}` leaves `μ{f = t}`,
which need not vanish — the clamp limit is what crosses an atom of `f` at `t`.

**Evidence.** Build: `data/fs131/i10a/logs/build-1-trio.log` (exit 0; `SpectralInputs` rebuilt in 3.1 s; its warnings are the five remaining `sorry`
leaves, lines 61, 112, 561, 579, 603). Axioms: `data/fs131/i10a/axioms-group1.lean`, log `data/fs131/i10a/logs/axioms-group1.log` — ten records on the
standard three, and the control (`sp_if`, still open) prints `sorryAx`. Statements: `tools/fs131_i10a_statements.py f919973e` on both files — 24 and 33
base declarations, all unchanged; self-test fired.

**Re-priced from these leaves** (the brief's ask). The trio with N2's last clause: about 330 lines of Lean, five elaboration rounds, one build of eight
minutes (the walk; the module itself compiles in 3 s), about 45k of my own tokens — against the plan's 540 lines. At that rate the six leaves left
(about 1,000 lines by the plan) are about 135k of my own tokens; the job stays inside the brief's guidance. Iteration is on scratch files importing the
built module (3 s a round), so the price is in the proofs, not the machine.

**A Lean fact met here** (draft for `LEAN.md` § Searching — Lean, Keryx's file): `T ⁻¹' A ∆ A` parses as `T ⁻¹' (A ∆ A)` — `⁻¹'` binds looser than `∆`;
write `(T ⁻¹' A) ∆ A`.
