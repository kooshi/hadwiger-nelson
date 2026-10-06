# FS-131, wave 10 — implementation record: the stationary ratio

*Job FS131-I10B (de Bruijn, the implementer), 2026-10-06, branch `fs131-w10b` (from the planner's `f919973e`). Brief:
`data/fs131/briefs/FS131-I10B-wave10.md` (on `main`). Plan: `plans/FS131-w10-kernel-plan.md` §§ 2, 3, 5.3, 5.5.*

**What I may change, and what I may not.** Mine: the proof of each of the three open leaves of
`Proofs/HadwigerNelson/Arith/StationaryRatio.lean` (`StationarySet.prob_le_ratio_mul`, `ratio_prod_le`, `ratio_prod_le_iSup_levels`); new helper
declarations in that file, under names no other module declares (all in the namespace `HadwigerNelson.StationaryRatio`, which only this module
opens); Mathlib imports the helpers need; a block "FS131-I10B" in `scripts/Axioms.lean`; this record; `tools/fs131_i10b_*.py`; `data/fs131/i10b/`;
the report. Not mine: any statement, hypothesis, conclusion, docstring or definition of the skeleton (a leaf that is false or too weak as stated goes
to Keryx by message); a new `axiom`; `native_decide`; the wave's other files (`SpectralInputs`, `CharacterColouring`, `StandingFive`); any landed
module; `main`; the gate; another branch.

## Theorems this phase proved

**All three leaves of the brief are proved; `Proofs/HadwigerNelson/Arith/StationaryRatio.lean` has no `sorry`.** Kernel-checked on this branch by
`./scripts/build.sh` under the slot (`data/fs131/i10b/logs/build-3-final.log`, exit 0); axioms a subset of `[propext, Classical.choice, Quot.sound]`
for each of the 51 records of the "FS131-I10B" block of `scripts/Axioms.lean`, printed with a control that shows `sorryAx`
(`data/fs131/i10b/logs/axioms-all.log`). The branch does not run the gate, so the audit is the landing's. No named hypothesis enters: the three
rows hold with no assumption from outside Mathlib.

The rows, each [kernel on this branch], each read against its derivation entry:

- **`ratio_prod_le`** — **X25B-PZ**. The row (`plans/FS100-derivation.md:399`, verbatim): "the stationary ratio of a categorical product of two LCA
  Cayley graphs is at most the larger factor's (Zhang 2012 §2's argument, measure form)". Lean, read aloud: for commutative additive groups `G`,
  `H` with σ-algebras, measurable addition and negation, and σ-finite measures `νG`, `νH` each equal to its image under negation,
  `ratio (νG.prod νH) ≤ max (ratio νG) (ratio νH)` — the supremum of `P(B)` over stationary systems on `G × H` whose event is a.e.-independent
  for the product connection measure is at most the larger of the two factors' suprema. The row's "LCA Cayley graphs" is widened to measurable
  groups (the planner's finding 8, now a proof); not claimed, as in the row: equality.
- **`ratio_prod_le_iSup_levels`** — **X25B-L1**. The row (`plans/FS100-derivation.md:418`, verbatim): "a profinite factor's stationary ratio in a
  product is at most the supremum over its finite levels (fibre shares above `1/2` form an a.e.-independent set)". Lean, read aloud: `Y` a compact,
  locally compact, Hausdorff, second-countable commutative topological group with its Borel σ-algebra, `K : ℕ → OpenAddSubgroup Y` antitone and
  entering every neighbourhood of `0`, `νX` σ-finite on a measurable group `X`, `νY` finite:
  `ratio (νX.prod νY) ≤ ⨆ k, ratio (νX.prod (νY ∗ cosetAverage (K k)))`. **The difference the planner recorded stands and is not closed here**:
  level `k` is the graph pulled back to `X × Y` (`νY` smoothed by the Haar probability of `K k`), not the graph on `X × Y/K_k` (§ Findings, item 4).
- **`StationarySet.prob_le_ratio_mul`** — **X25B-P**, the derivation's lemma, not a backlog row (`plans/FS100-X25B-derivation.md:50`, verbatim):
  "If `A` is a `G`-stationary random a.e.-independent set, `P(0 ∈ A) ≤ r(G,T)·P(0 ∈ N[A])`." Lean: for a stationary system `W` on a measurable
  group with measurable negation and a σ-finite symmetric `ν`, a.e.-independent for `ν`: `W.P W.B ≤ ratio ν * W.P (W.B ∪ W.nbhd ν)`.

**New statements, one mind (mine), owed the planner's read-back** — each row at the class its proof reads (plan § 7.3 item 3), the leaves being
their corollaries with the statement's extra arguments:

- `StationarySet.prob_le_ratio_mul_of_symm` — X25B-P with no `MeasurableAdd₂ G`.
- `ratio_prod_le_of_symm` (with `StationarySet.prob_le_max_ratio`, the bound at one stationary set) — X25B-PZ with no `MeasurableAdd₂`.
- `ratio_prod_le_iSup_levels_of_shrink` (with `StationarySet.prob_le_ratio_level_add`, the bound at one stationary set and one level) — X25B-L1
  for any family `K : ι → OpenAddSubgroup Y` entering every neighbourhood of `0` (no order on `ι`, no `Antitone`), `νY` s-finite, any `νX`, no
  `MeasurableAdd₂ X`, no `T2Space Y`.
- `tendsto_measure_symmDiff_shift` — a jointly measurable measure-preserving action of a compact second-countable commutative group is continuous
  at `0` on events: `P(T_u⁻¹ C ∆ C) → 0` as `u → 0`.
- `StationarySet.ae_majority` (the pigeonhole), `StationarySet.measure_le_majority_add`, `lintegral_prod_conv_cosetAverage` — X25B-L1's children.

**The models** (`LEAN.md` § The gate: a named inhabitant that exercises every clause):

- `StationarySet.parity`, with `parity_aeIndependent`, `parity_prob` — `ZMod 2` acting on itself, the event `{0}`, `ν = δ₁`: the model the module
  docstring names, now a declaration; a.e.-independent with `P(B) = 1/2`.
- **`ratio_dirac_one_zmod_two : ratio (Measure.dirac (1 : ZMod 2)) = 2⁻¹`** — the definition evaluated at `K₂` (the model from below;
  `ratio_dirac_le`, "an edge halves the set", from above). The three rows are instantiated there in the Spec section: X25B-P reads
  `1/2 ≤ r · P(N[A])`, X25B-PZ reads `r(K₂ × K₂) ≤ 1/2`.
- `cantorLevel`, `cantorLevel_antitone`, `exists_cantorLevel_subset` — X25B-L1's hypotheses at a profinite factor that is not finite: `ℕ → ZMod 2`
  with the levels `{f | f i = 0 for i < k}`; the row is instantiated there (`X = ZMod 2`), and at `X = Y = ZMod 2` with the levels `{0}`.

The toolkit (general use): `ae_neg_iff`, `ratio_le_one`, `ratio_mul_le`; on a `StationarySet`: `T_add_apply`, `T_zero_apply`, `T_neg_T`, `T_T_neg`,
`measurable_T_apply`, `measurable_T_comp`, `measurable_T_left`, `ae_T_iff`, `notMem_nb_iff`, `nb_mono`, `measurableSet_nb`, `ae_nb_iff`,
`prod_null_iff`, `prod_apply_corr`, `measurable_corr`, `aeIndependent_iff`, `measurableSet_majority`; `cosetAverage_apply`, `cosetAverage_compl`,
`ae_mem_cosetAverage`, `cosetAverage_preimage_add`, `cosetAverage.instIsProbabilityMeasure`; `map_neg_dirac_one`, `mem_cantorLevel`. Definitions:
`StationarySet.nb`, `.pull`, `.couple`, `.majority`, `.parity`, `cantorLevel` — each with a spec example in the file's Spec section.

## Stage 1 — SAVED (FS131-I10B): the readback, the build as given

**Quotations** (standing rule 3), by script — `grep -cF` of each quoted string in the file the brief names: `data/fs131/i10b/quotations.sh`, log
`data/fs131/i10b/logs/quotations.txt`: **eight of eight match** (`CLAUDE.md` § Counter-priors; inventory items 484, 485, 477, 478, 493 in
`plans/FS131-close-inventory.md`, read on `main`, where they are filed; the plan's §§ 5.3 and 5.5 headings in this worktree). The script's control (a
quotation altered by one word) reads 0 matches.

**Read**: the brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` §§ Building, Make the gate fail; the planner's record
(`plans/FS131-w10-kernel-plan.md`) whole; `Proofs/HadwigerNelson/Arith/StationaryRatio.lean` whole (it imports Mathlib only, so its foundation is its
own five definitions); the derivation `plans/FS100-X25B-derivation.md` whole, its § Stage 2 (X25B-P l. 50–55, X25B-PZ l. 57–70, X25B-L1 l. 72–79)
against each leaf; inventory items 484–485 and 493–494 in full; the first implementer's record (`plans/FS131-I10A-implementation.md` on `fs131-w10`).

**The branch as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` in this worktree, exit 0, 9 m 15 s
(`data/fs131/i10b/logs/build-0-as-given.log`). **What it rebuilt**: five modules — `Arith.StationaryRatio`, `Arith.StandingFive`,
`Arith.SpectralInputs`, `Arith.CharacterColouring` (the wave's four, absent from the copied build) and `Proofs`. Warnings: 21, every one
`declaration uses 'sorry'`: `CharacterColouring` 1, `SpectralInputs` 8, `StandingFive` 9, `StationaryRatio` 3 (lines 100, 107, 121) — the 21 leaves
the planner reported.

**The statement check** is `tools/fs131_i10b_statements.py <base> <files>`, two checks of the working file against the base commit's: (A) every
base declaration appears verbatim, exactly once — a theorem from its keyword to the first ` :=`, *followed by* ` :=` (so nothing can be appended to a
conclusion), anything else whole, docstrings included; (B) the base's lines, `sorry` lines dropped, are a subsequence of the working file's lines
(imports, the module docstring, the spec examples). `--self-test` plants five faults and each fires: one character of a statement changed; a
conclusion widened by an appended disjunct; a definition's last line dropped; a docstring edited; a spec example removed. On the file as given:
PASS, 11 base declarations and 140 base lines.

**The planner's question for the first pass** (its § 2.2 item 8: "the widening is read off the derivation, not yet off a proof"), answered on paper
before any Lean, each leaf read against the derivation's proof:

- **The statement the three proofs derive from.** A.e.-independence is `∀ᵐ t ∂ν, ∀ᵐ ω ∂P, ω ∈ B → T t ω ∉ B` (Tonelli on the definition's product
  set), and every step of the derivation is one of four moves on such statements: shift the sample point (a measure-preserving `T h` with inverse
  `T (−h)`), reflect `ν` (its symmetry), exchange "for almost every shift" with "almost surely" (Tonelli; the event "`κ`-positively many shifts
  land in `D`" is where it is read), and change the event on the same system. No Haar measure on `G` is read: **the widening holds**, for X25B-P and
  X25B-PZ at measurable groups with σ-finite symmetric `ν`.
- **X25B-L1**: the pigeonhole of the plan's finding 8 goes through as stated there — two events of share above `1/2` under one probability meet,
  and a common parameter is an edge — with no integral bound; "martingale convergence on the fibres" is replaced by continuity at `0` of
  `u ↦ P(T_u⁻¹B ∆ B)`, which by stationarity is the mean over `ω` of `m((u + A_ω) ∆ A_ω)`, `A_ω = {v : T_v ω ∈ B}`, so it follows from Mathlib's
  continuity of translation in measure (`tendsto_measure_symmDiff_preimage_nhds_zero`) and dominated convergence — no bump functions and no density
  argument in `L¹(P)`.
- **Hypotheses the paper proofs do not read** (confirmed by the linter at Stage 2–3): `MeasurableAdd₂` in X25B-P; in X25B-L1, that `K` is
  antitone (one level inside a small neighbourhood of `0` is enough), `SigmaFinite ν_X`, `MeasurableAdd₂ X`, `T2Space Y`.

## Stage 2 — SAVED (FS131-I10B): group 1 — X25B-P (`prob_le_ratio_mul`) and X25B-PZ (`ratio_prod_le`)

**The statement the proofs derive from** (`debruijn`'s loop: found before the first tactic, on paper): a.e.-independence of the event `C` in a
system is `∀ᵐ t ∂ν, ∀ᵐ ω ∂P, ω ∈ C → T t ω ∉ C` (`StationarySet.aeIndependent_iff`, by `measure_prod_null`). On statements of that shape the
derivation's steps are four lemmas, and each case of X25B-PZ's step (3) is two or three lines over them:

- `ae_T_iff` — a property holds almost surely after a shift iff it holds almost surely (`T h` preserves `P`, with inverse `T (−h)`);
- `ae_neg_iff` — a symmetric `ν` sees a property and its reflection alike;
- `ae_nb_iff` — **Tonelli**: with `nb κ e D = {ω | κ{z | T (e z) ω ∈ D} > 0}` (the skeleton's `nbhd ν` is `nb ν Neg.neg B`, by `rfl`),
  `(∀ᵐ ω, ω ∈ C → ω ∉ nb κ e D) ↔ ∀ᵐ z ∂κ, ∀ᵐ ω, ω ∈ C → T (e z) ω ∉ D` — Mathlib's `Measure.ae_ae_comm` on one measurable set;
- `pull` (the same sample space, the action restricted along a homomorphism, another event) and `couple` (the independent coupling) — the two
  ways a new `StationarySet` is made; `AEIndependent` and `nbhd` of either unfold by `rfl` to statements about the old system.

**X25B-P.** `N(A)` is `nb ν Neg.neg A`. Tonelli gives, for almost every `t`: off `N(A)` no reflected shift lands in `A` (F1); by symmetry no
shift does (F2); shifting the sample point, a point of `A` is shifted into `N(A)` (F3). For a competitor `S`, the event
`(S ∖ N[A]) ∪ A` of `S.couple W` is a.e.-independent: the four cases are `tauto` over F2, F3 and the two independences lifted to the product by
`quasiMeasurePreserving_fst/snd`. Its mass is `P(S)·P(N[A]ᶜ) + P(A)` (`prod_prod`). The supremum over `S` is taken in `ℝ≥0∞` by `ratio_mul_le`
(`ENNReal.iSup_mul`), with `ratio ≤ 1` for the cancellation — no `ε`.

**X25B-PZ** (`StationarySet.prob_le_max_ratio`, then the supremum). `N = nb ν_H (t ↦ (0, −t)) B`, `Y = B ∖ N`, `A = B ∩ N`. One fact carries
(2) and three of (3)'s four cases: **G3**, for almost every `s`, almost surely `T (s, 0) ω ∈ B → ω ∉ N` (an `H`-neighbour of `ω` in the set would
be joined to the shift by the edge `(s, t)`): `ae_nb_iff` at `C = T (s, 0)⁻¹ B`, then `ae_T_iff` at `(0, −t)`. With G2 (off `N` no `H`-shift lands
in `B`): `Y` is `H`-independent, `A` is `G`-independent, and the closed neighbourhoods `Y ∪ N_H(Y)`, `A ∪ N_G(A)` meet in a null event — the cases
`A ∩ Y = ∅`; `B ∩ N_H(Y)` null (G2 shifted); `N_G(A) ∩ B` null (G3 shifted); `N_G(B) ∩ N` null (G3 and the symmetry of `ν_G` — the derivation's
fourth case uses the symmetry of `ν_H`; either serves). Then X25B-P in each factor through `pull` along `inl`, `inr`, and `measure_union₀`.
**The plan's `null_of_edges`** (one lemma to which each case reduces by one translation) is `ae_nb_iff` with `ae_T_iff`.

**Evidence.** Build: `data/fs131/i10b/logs/build-1-group1.log` — exit 0, 451 batches, 2 modules rebuilt (`Arith.StationaryRatio` 3.8 s, `Proofs`),
8 m 12 s; `StationaryRatio`'s one warning is the open leaf (`declaration uses 'sorry'`, line 454, `ratio_prod_le_iSup_levels`); no warning other
than `sorry` in the run. Axioms: `data/fs131/i10b/axioms-group1.lean`, log `data/fs131/i10b/logs/axioms-group1.log` — 26 records: 25 on a subset of
`[propext, Classical.choice, Quot.sound]`, and the control (`ratio_prod_le_iSup_levels`, open at this stage) prints `sorryAx`. Statements:
`tools/fs131_i10b_statements.py f919973e` — PASS (11 base declarations, 140 base lines; the five faults fire). `scripts/Axioms.lean`: block
"FS131-I10B" above the PURCHASED banner, 24 records (the audit itself is the landing's).

**The unused-arguments linter, with its control** (on a scratch copy of the file with `#lint` appended; iteration only): 0 errors in 59
declarations as committed; with the five consuming `have _ := …` lines removed it reports exactly `prob_le_ratio_mul`: `[MeasurableAdd₂ G]`, and
`ratio_prod_le_iSup_levels`: `[MeasurableAdd₂ X]`, `[T2Space Y]`, `[SigmaFinite νX]`, `(hK : Antitone K)`
(`data/fs131/i10b/logs/lint-control.txt`). Those are the statement's arguments the proofs do not read (§ Findings); each is consumed by a `have`
with a comment at the line, the statements unchanged.

**Re-priced from these two leaves** (the brief's ask). The plan: 1,100 lines for the two (400 + 700), and 800 for the third; 350k harness tokens for
the file. Written: about 330 lines for the two with their toolkit (toolkit 130, X25B-P 65, X25B-PZ 135), four elaboration rounds on a scratch copy
(the file imports Mathlib only, so a round is 4 s), one build. At that rate the third leaf is about 250 lines, and the job stays well inside the
brief's guidance. **Why the plan was high by three**: it priced the derivation's sets and integrals; in the almost-sure normal form there is no
integral in X25B-P or X25B-PZ at all — Tonelli is used once, inside `ae_nb_iff`.

## Stage 3 — SAVED (FS131-I10B): group 2 — X25B-L1 (`ratio_prod_le_iSup_levels`)

**All three leaves are proved; `StationaryRatio.lean` has no `sorry`.** The leaf in four children, each general in the parameter space `(Z, κ, e)`
(here `Z = Y`, `κ` the level average, `e u = (0, u)`):

- `majority κ e D = {ω | κ{z | T (e z) ω ∈ D} > 1/2}` — the fibre share above `1/2`. **`ae_majority`, the pigeonhole** (the plan's finding 8, now a
  proof): if almost surely the shift by `g` joins no two points of `D`, it joins no two points of the majority event — the two parameter sets
  have measure above `1/2` under one probability, so they meet in positive measure, and a common parameter is an edge inside `D`
  (`ae_nb_iff` at `C = univ`, `D ∩ T g⁻¹ D`). No integral bound over cosets, and no group structure on `Z`.
- `measure_le_majority_add`: `P(D) ≤ P(majority) + ∫ P(T_{e z}⁻¹ D ∆ D) dκ(z)` — where at most half the shifts land in `D`, the share is at most
  the share of shifts that disagree with the origin (Tonelli twice, `prob_compl_eq_one_sub`).
- `lintegral_prod_conv_cosetAverage`: smoothing by the level average does not change the integral of a function invariant under `K` in the
  second coordinate (`Measure.lintegral_conv`); with `cosetAverage_preimage_add` (the level average is `K`-invariant) the majority event is
  a.e.-independent for `ν_X × (ν_Y ∗ m_K)` (`prob_le_ratio_level_add`).
- **`tendsto_measure_symmDiff_shift`** — a jointly measurable measure-preserving action of a compact second-countable group is continuous at `0`
  on events, `P(T_u⁻¹ C ∆ C) → 0`. The plan's hard child (`continuous_translate_L1`, bump functions dense by Fubini) is replaced: by stationarity
  `m(Y) · P(T_u⁻¹ C ∆ C) = ∫ m((u + A_ω) ∆ A_ω) dP(ω)`, `A_ω = {v | T_v ω ∈ C}`; each integrand tends to `0` by Mathlib's
  `tendsto_measure_symmDiff_preimage_nhds_zero` (translation `u ↦ (u + ·)` is continuous into `C(Y, Y)`, by `ContinuousMap.curry`), boundedly by
  `m(Y)`, and `𝓝 0` is countably generated: `tendsto_lintegral_filter_of_dominated_convergence`. 70 lines.

The theorem: given `ε`, continuity gives a neighbourhood of `0`, `hK0` a level inside it, and `P(B) ≤ ratio(level) + ε`
(`ENNReal.le_of_forall_pos_le_add`). **One level suffices, so `hK : Antitone K` is not read**; nor are `[SigmaFinite νX]` (Tonelli is only ever
applied with `P` or a finite measure in the second slot), `[MeasurableAdd₂ X]`, `[T2Space Y]` (a topological group is regular, and Haar measure
regular, without it).

**Evidence.** Build: `data/fs131/i10b/logs/build-2-group2.log` — exit 0, 451 batches, 2 modules rebuilt (`Arith.StationaryRatio` 3.9 s, `Proofs`),
8 m 4 s; **no warning names `StationaryRatio.lean`**; the run's 18 warnings are all `declaration uses 'sorry'` in the wave's other files
(`CharacterColouring` 1, `SpectralInputs` 8, `StandingFive` 9 — other implementers', open on this branch). Axioms:
`data/fs131/i10b/axioms-group2.lean`, log `data/fs131/i10b/logs/axioms-group2.log` — 16 records: 15 on a subset of the standard three (the leaf,
its children, and group 1's two leaves again), and the control (`StandingFive.usable_card_ge`, open on this branch) prints `sorryAx`. Statements:
`tools/fs131_i10b_statements.py f919973e` — PASS, 11 base declarations and 140 base lines; five faults fire. `scripts/Axioms.lean`: the block now
holds 36 records. Two Mathlib imports added to the module (`Mathlib.MeasureTheory.Measure.ContinuousPreimage`,
`Mathlib.MeasureTheory.Integral.Lebesgue.DominatedConvergence`) and `open scoped symmDiff`.

## Stage 4 — SAVED (FS131-I10B): the rows at the class their proofs read, the models, the spec

- **The class each proof reads** (plan § 7.3 item 3). The proofs moved into `StationarySet.prob_le_ratio_mul_of_symm`, `ratio_prod_le_of_symm`,
  `ratio_prod_le_iSup_levels_of_shrink`, stated with exactly the arguments read; each leaf is now one `exact` after the `have _ := …` lines that
  consume the skeleton's extra arguments. If a ruling drops those arguments from the skeleton (as ruling 494 (a) did for I10A's), each pair
  becomes one statement and one of the two is deleted.
- **A model with an edge**: `StationarySet.parity` (`ZMod 2` on itself, uniform probability, `B = {0}`), `parity_aeIndependent` for `δ₁`,
  `parity_prob : P(B) = 2⁻¹`. `ratio_dirac_le`: for any `g` in any group with measurable singletons, `ratio (δ_g) ≤ 2⁻¹` (the event and its shift by
  `g` are almost surely disjoint and equiprobable). Together: **`ratio (δ₁ on ZMod 2) = 2⁻¹`**, the definition `#eval`-ed at `K₂` — a value that
  fails if `ratio`, `AEIndependent` or `StationarySet` drifts. The skeleton's `StationarySet.empty` has the empty event, where every hypothesis is
  trivially true and every conclusion is `0 ≤ …`; `parity` is the inhabitant at which they are not.
- **A profinite model that is not finite**: `cantorLevel k = {f : ℕ → ZMod 2 | f i = 0 for i < k}` as `OpenAddSubgroup`s, antitone, entering every
  neighbourhood of `0` (`isOpen_pi_iff`). Lean finds every instance X25B-L1 asks of `ℕ → ZMod 2` (topological group, compact, locally compact,
  Hausdorff, second countable, Borel) with no help, and the row is instantiated there.
- **Spec section**: one example per new definition (`nb` against `nbhd` by `rfl` and at the one-point system; `pull`, `couple` by `rfl` on
  their fields; `majority` at the one-point system; `cosetAverage` total mass and support; `cantorLevel 0 = ⊤` and a point of level 0 not of level
  1), and the three rows at `parity`, at `ZMod 2 × ZMod 2`, at the Cantor group.

**Evidence.** Build: `data/fs131/i10b/logs/build-3-final.log` — exit 0, 451 batches, 2 modules rebuilt (`Arith.StationaryRatio` 4.0 s, `Proofs`),
10 m 29 s; no warning names `StationaryRatio.lean`; the run's 18 warnings are `declaration uses 'sorry'` in `CharacterColouring` (1),
`SpectralInputs` (8), `StandingFive` (9). Axioms: `data/fs131/i10b/axioms-all.lean` (generated from the file's declarations,
`data/fs131/i10b/axioms-names.txt`), log `data/fs131/i10b/logs/axioms-all.log` — **52 records: this job's 51 on a subset of the standard three (none
missing from the print), and the control (`StandingFive.usable_card_ge`) on `sorryAx`**. Statements: PASS (11 base declarations, 140 base lines;
five faults fire). `sorry` in the file: 0. Environment linters on a scratch copy with `#lint` appended (iteration only, not the gate's run): 0
errors in 72 declarations (`data/fs131/i10b/logs/lint-pass.txt`); **its control** — the seven consuming lines removed — reports exactly the seven
unread arguments of § Findings item 1 (`data/fs131/i10b/logs/lint-control.txt`). `tools/check_architecture.py`: PASS (the module's Mathlib imports
grew by four: `Measure.ContinuousPreimage`, `Integral.Lebesgue.DominatedConvergence`, `Measure.Count`, `Topology.Instances.ZMod`). Names: every new
declaration is in `HadwigerNelson.StationaryRatio`, which no other module of `Proofs/` opens or mentions (`rg`, this branch).

**The price, final.** Planned (plan § 5.6): 1,900 lines, 350k harness tokens. Written: the module grew from 140 to 955 lines — toolkit 150, X25B-P
75, X25B-PZ 150, X25B-L1 with its four children 290, the models 95, spec examples 70; about twenty elaboration rounds on scratch copies and four
builds (one as given). The leaves with their children are about 660 lines against 1,900.

## Findings (for the report's inventory)

1. **Generalization — seven arguments of the three statements are not read** (statements unchanged; each consumed by a `have` with a comment at
   the line; the linter's control names exactly these): `prob_le_ratio_mul`: `[MeasurableAdd₂ G]`; `ratio_prod_le`: `[MeasurableAdd₂ G]`,
   `[MeasurableAdd₂ H]`; `ratio_prod_le_iSup_levels`: `[MeasurableAdd₂ X]`, `[T2Space Y]`, `[SigmaFinite νX]`, `(hK : Antitone K)`. Beyond the
   linter: `[IsFiniteMeasure νY]` weakens to `[SFinite νY]`, and the index `ℕ` to any type. The forms without them are theorems (Stage 4).
   **Why `Antitone` is not read**: given `ε`, one level inside the `ε`-neighbourhood of `0` already gives `P(B) ≤ r_k + ε`; no limit along `k` is
   taken. **Why no measurable addition**: the action is by `T (x + y) = T x ∘ T y`, an identity of functions; addition is never integrated.
2. **The planner's finding 8 is confirmed by proofs**: no Haar measure on `G` is read by X25B-P or X25B-PZ; and X25B-L1's independence of
   `{φ_k > 1/2}` is the pigeonhole (`ae_majority`), with no integral bound over cosets — it holds for any probability `κ` on any parameter space,
   with no group structure on it.
3. **A route replaced** (the brief: say so). The plan's `continuous_translate_L1` ("averages against bump functions are dense, by Fubini") and the
   derivation's "martingale convergence on the fibres" are both replaced by `tendsto_measure_symmDiff_shift`: stationarity turns
   `P(T_u⁻¹ C ∆ C)` into a mean of Haar measures of `(u + A_ω) ∆ A_ω`, and Mathlib has the continuity of translation in measure
   (`MeasureTheory.tendsto_measure_symmDiff_preimage_nhds_zero`); dominated convergence finishes. The plan's `null_of_edges` became `ae_nb_iff`.
4. **X25B-L1's Lean right-hand side is the pulled-back level, and the bridge to the row's "finite levels" is not stated anywhere in the wave.**
   The row's model line reads "the ratio of `Y` is at most the supremum of its levels' ratios" — ratios of the finite graphs on `Y/K_k`; the Lean
   statement bounds by `ratio (νX.prod (νY ∗ m_{K_k}))`, a supremum over stationary systems on `X × Y`. The planner recorded the difference (its
   Stage 4 table); what is owed, for the row's consumer (X25B-T's chain `r(G_∅) ≤ sup_k r(ℂ^{r₁} × Y_k) ≤ …`), is
   `ratio (νY ∗ m_K) ≤ α(Cay(Y/K, S))/|Y/K|`. **A route with no quotient system** (on paper, one mind, not in Lean): apply X25B-PZ first, to
   `νX` and `νY ∗ m_K` (symmetric if `νY` is), so that only `Y` is left; then for a system on `Y` a.e.-independent for `νY ∗ m_K`, the set of
   cosets `I_ω = {c ∈ Y/K : the K-share of c in W_ω is positive}` is almost surely independent in the finite level graph (two positive shares in
   adjacent cosets give a positive measure of edges for `νY ∗ m_K`), and `P(B) = E[share of the origin's coset] ≤ P(0 ∈ I_ω) = E|I_ω|/|Y/K| ≤
   α/|Y/K|` by stationarity. A quotient system over `Y/K` (the route the statement's docstring suggests: "K_k-invariant up to a larger
   independent one") needs the orbit space `Ω/K` and joint measurability there; the count above avoids it.
5. **The symmetry hypotheses of X25B-PZ cannot both be dropped** (a hand computation, one mind; it shows the hypotheses bite): `G = ℤ/3`,
   `H = ℤ/5`, `νG = δ₁`, `νH = δ₁`. A.e.-independence for `δ₁` is independence in the cycle (`P(B ∩ T_t⁻¹B) = P(B ∩ T_{−t}⁻¹B)` always), so
   the ratios are `1/3` and `2/5`; but `νG × νH = δ_{(1,1)}` on `ℤ/15` gives the cycle `C₁₅`, of ratio `7/15 > 2/5`. The categorical product of
   the two cycles also has the edges `(1, −1)`, which `δ₁ × δ₁` does not see. (One symmetric factor suffices on paper: then `νG × νH` and its
   reflection generate all four sign patterns. The Lean proof reads both `hG` and `hH`; the one-sided form is not stated.)
6. **The derivation's X25B-PZ step (2) reads the symmetry of `ν_H` where it says "by definition of `N_H`"**: `N_H` is defined through `x − t`,
   independence of `Y_0` needs `x + t`. No defect — `ν_H` is symmetric by hypothesis — but it is one of the two places symmetry enters
   (the other is X25B-P's fourth case, which the derivation names).
7. **Lean facts met** (drafts below): at the pin `add_le_add_left h a : b + a ≤ c + a` and `add_le_add_right h a : a + b ≤ a + c` — the side
   named is the side that *varies*, the reverse of the older convention (`#check`, `data/fs131/i10b/scratch/AddLe.lean`); `∆` on sets needs
   `open scoped symmDiff`; a module that imports Mathlib only is iterated on a scratch copy of the whole file (4 s a round, 2.4 GiB peak) with no
   build; `rw` with a lemma stated for a general `e` leaves `id p.1` where the goal has `p.1` — a `calc` step closed by `exact` sees through it.
8. **The vacuity gate** (the landing's): `StationarySet G` is not a tracked carrier in `scripts/Vacuity.lean` as read on this branch; if it is
   registered it reads GENERIC at a variable `G`. Named inhabitants for the note: `StationarySet.empty` (every `G`, every `ν`),
   `StationarySet.parity` with `parity_aeIndependent` (an edge, `P(B) = 1/2`), `cantorLevel` (X25B-L1's `K`, `hK`, `hK0` at a group that is not
   finite).

## Slips, mine

- **Iteration without the slot above the line.** One elaboration round on a scratch copy of the module peaks at 2.4 GiB for 4 s (measured at the
  end, `/usr/bin/time -v`); standing rule 9's line is "about 2 GiB or 2 minutes". The first round ran under the slot (`--mem 8`); about twenty
  later ones did not. Nothing was killed or refused; the measurement should have come first.
- **Order.** The three proofs were drafted on a scratch copy (`data/fs131/i10b/scratch/SR.lean`) while the as-given build ran, before Stage 1's
  commit, and the scratch was first committed with Stage 2. No file of a running build was edited, and the module itself was first changed after
  Stage 1 was pushed; but between Stage 1's commit and Stage 2's the proofs existed only as uncommitted files in the worktree (on disk under
  `data/`, not in `/tmp`).
- Each wait on a build read the log's `EXIT=` line, which the wrapper writes only when the build has ended; no waiter was armed on a pattern.

## Drafts for the front page

The gate's counts (`CLAUDE.md` § The gate, § Trust ledger) are the landing's: this branch does not run the gate, and 18 leaves of the wave's other
files are open on it. Drafts, each for the landing of wave 10, each naming its slot:

- **`CLAUDE.md` § Trust ledger** (the audit sentence's counts, at the landing): this job's block adds **51 clean records, no purchase, no
  import**.
- **`plans/LEAN-BACKLOG.md`, rows X25B-PZ and X25B-L1** (the state the landing records, after "Grade as filed"): X25B-PZ — [kernel]:
  `HadwigerNelson.StationaryRatio.ratio_prod_le`, axioms `[propext, Classical.choice, Quot.sound]`, no hypothesis from outside Mathlib; proved at
  a wider class than filed (measurable groups, σ-finite symmetric connection measures; `ratio_prod_le_of_symm` without measurable addition).
  X25B-L1 — [kernel]: `HadwigerNelson.StationaryRatio.ratio_prod_le_iSup_levels`, the same axioms, no hypothesis from outside Mathlib; **the
  levels are the graphs pulled back to `X × Y`** (`ν_Y ∗ m_{K_k}`): the comparison with the finite graphs on `X × Y/K_k` is not stated
  (FS131-I10B finding 4).
- **`LEDGER.md` § B, the line `FS100-TCA`** (after "`r(G × H) ≤ max`"): "— in the kernel in stationary form,
  `StationaryRatio.ratio_prod_le` (X25B-PZ) with its lemma `StationarySet.prob_le_ratio_mul` (X25B-P), standard three axioms".
- **`ARCHITECTURE.md`, the row `Arith/StationaryRatio`** (replacing "**FS-131 wave 10 (FS131-K10), skeleton.**" and the inhabitant clause):
  "**FS-131 wave 10 (FS131-K10; proved by FS131-I10B), no `sorry`.** … inhabitants `StationarySet.empty`, `StationarySet.parity` (`ZMod 2`,
  `P(B) = 1/2`, with `ratio_dirac_one_zmod_two : ratio δ₁ = 2⁻¹`), `cantorLevel` (X25B-L1's levels on `ℕ → ZMod 2`); the rows at the class their
  proofs read: `prob_le_ratio_mul_of_symm`, `ratio_prod_le_of_symm`, `ratio_prod_le_iSup_levels_of_shrink`."
- **`LEAN.md` § Searching — Lean** (two new bullets): "At the pin `add_le_add_left h a : b + a ≤ c + a` and `add_le_add_right h a : a + b ≤ a + c`
  (and `mul_le_mul_left/right` alike): the name says which side varies. `#check` before use." — "`s ∆ t` on sets needs `open scoped symmDiff`."
- **`plans/FS131-kernel-plan.md` § 7.4** (the named hypotheses' table): no row from this file — it has none. Its § 5.6 price row I-B: "1,900
  lines planned; about 660 written for the leaves and their children (FS131-I10B)".
- **`plans/FS131-w10-kernel-plan.md` § 2.2 item 8** (the planner's "To be confirmed by the implementer's first pass"): "confirmed by proofs
  (FS131-I10B): no Haar measure on the group is read; the pigeonhole holds for any probability on any parameter space."
- **Frontier line and Proof Atlas**: no change until the wave lands; at the landing X25B-PZ and X25B-L1 move from [hand; one mind] to [kernel]
  (L1 with finding 4's difference stated).
