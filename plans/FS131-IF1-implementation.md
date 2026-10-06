# FS131-IF1 — `[Falconer1981]` Lemma 2 (i) becomes a theorem: the implementer's record

*Job FS131-IF1 (de Bruijn, the implementer), branch `fs131-wf1`, cut from `main` at `ca598960`. Brief:
`data/fs131/briefs/FS131-IF1-falconer-lemma2.md`. Working files: `data/fs131/if1/`.*

## What I may and may not change

- **May**: the keyword `axiom` → `theorem` of `falconer_lemma2_nonempty` in `Proofs/HadwigerNelson/Plane/FalconerReduction.lean`, its
  docstring, and what the change forces there (an import line); a new module of my own under `Proofs/HadwigerNelson/Plane/` with its
  lines in `Proofs.lean` and `ARCHITECTURE.md`; `ARCHITECTURE.md` § 5's row "Imported outside theorems"; `scripts/Axioms.lean` (the
  `declareImport` line, the four records, my registrations); the self-test's expected counts where they move with mine;
  this record, `tools/fs131_if1_*.py`, `data/fs131/if1/`, `data/fs131/reports/FS131-IF1.md`.
- **May not**: the statement of `falconer_lemma2_nonempty` (name, binders, conclusion), any other statement or definition, a new
  `axiom`, `native_decide`; `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `BIBLIOGRAPHY.md` (drafts go below); `main`. I do not land, merge
  another branch, or run the full gate.

## Stage 1 — SAVED (FS131-IF1): readback, and the branch built as given

**Quotations checked against their sources** (`grep -F`, each line of the brief's § Why this job and § The statement; script kept
as `data/fs131/if1/quote-check.sh`): 12 of 12 match — the axiom's two lines, `densityRatio`, `densitySet`, the planner's § 12.1 line,
the four consumers' first lines, `LEAN.md`'s two lines, inventory item 548's line.

**The statement read against the paper's page, first-hand** (`[Falconer1981]` p. 185, the library's copy
`library/papers/falconer-1981-realization-distances-measurable-subsets-covering-Rn-jcta-31-184-189.pdf`, pp. 184–186 read):

> Suppose now that S is a Lebesgue measurable subset of Rⁿ; we define the *metrical boundary* ∂S of S to be those points of Rⁿ at
> which the Lebesgue density of S either fails to exist, or exists and has a value other than 0 or 1. (The Lebesgue density of S
> at x is defined as lim_{δ→0} v(B_δ(x) ∩ S)/v(B_δ(x)), where B_δ(x) is the ball of centre x and radius δ.)

> LEMMA 2. Let S be a measurable subset of Rⁿ with v(S) > 0 and v(Rⁿ∖S) > 0 then (i) ∂S is non-empty and v(∂S) = 0, (ii) S̃ is a
> Borel set. — Proof. […] The author's proof that ∂S is non-empty is given for Lemma 4 of Croft [1] in the plane case; an
> identical proof holds in Rⁿ.

The Lean statement (`Proofs/HadwigerNelson/Plane/FalconerReduction.lean:290–291`):
`{S : Set ℂ} (hS : MeasurableSet S) (h1 : volume S ≠ 0) (h2 : volume Sᶜ ≠ 0) : ∃ x : ℂ, x ∉ densitySet S ∧ x ∉ densitySet Sᶜ`.
Read: `x ∉ densitySet S` is "the density of `S` at `x` does not exist with value `1`"; `x ∉ densitySet Sᶜ` is, for measurable `S`
(the ratios of `S` and `Sᶜ` on a closed ball of positive radius sum to `1`, `densityRatio_add_compl`), "it does not exist with value
`0`"; together, `x ∈ ∂S`. Closed balls against the paper's unspecified ball: a sphere is Lebesgue-null. **Verdict: the paper's (i),
first clause, at `n = 2`, with one difference of scope** — the paper's `S` is Lebesgue measurable, the Lean `S` is `MeasurableSet`
(Borel). As an axiom that is the weaker assumption, so nothing false was assumed; as a theorem it is the paper's lemma on Borel sets.
All four consumers apply it to Borel classes. Not a statement defect; logged as an inventory line. The general theorem of Stage 3
is stated for null-measurable sets in any finite dimension, which is the paper's sentence in full.

**Read**: `FalconerReduction.lean` lines 1–32 and 270–420 (the § on Lemmas 2–4, the model `upperHalfPlane_falconer_hyp`, the one
call site in `exists_mem_falconerE`); `UnitPairs.lean` whole; `Cover.lean`'s density lemmas (`ae_restrict_mem_densitySet`,
`volume_diff_densitySet`, `densityRatio_add_compl`, `densitySet_disjoint_compl`, `volume_closedBall_ofReal`,
`tendsto_densityRatio_compl_of_mem`, `mem_densitySet_of_tendsto_compl`, `measurable_densityRatio_centre`, `densitySet_iff_rat`,
`measurableSet_densitySet`); the planner's § 12.1 (`plans/FS131-w2-kernel-plan.md:671–686`); `scripts/Axioms.lean:1–206` (the
instruments and the IMPORTED banner's procedure); `scripts/axioms.sh` whole; `scripts/axioms-controls.txt` whole.

**Who rests on the axiom**: one call site, `exists_mem_falconerE` (`FalconerReduction.lean:374`); `fan_tip_ae_mem`,
`falconer_reduction` and `le_chiM_of_falconerFan` through it. Modules importing `Plane/FalconerReduction`: `Plane/Slack`,
`Plane/ValidMap/Dense`, `Proofs.lean`.

**The self-test and an empty import list** (found at the readback; the brief asked): three controls in
`scripts/axioms-controls.txt` read the library's state — `baseline` (`imported=4 declared=1 library=1`, and its `old` digest's
text), `imported_declared` (`5 / 2 / 2`), and `banner_dropped` (two consequences naming `falconer_reduction` and
`falconer_lemma2_nonempty`). The file's history (`a09b2254`, FS131-T3) shows the design with no declared import: `0 / 0 / 0`,
`1 / 1 / 1`, and `banner_dropped` expecting only `FAIL banners IMPORTED`; every IMPORTED control plants its own axiom
(`t3c_import`), so the self-test needs no library import. The brief's touch list names `scripts/axioms.sh` for these counts; they
live in `scripts/axioms-controls.txt`, which I will edit in Stage 4 (held for the coordinator as a touch outside the list's letter).

**Build as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0, "all 1805 modules
already up to date, nothing built, 0 module(s) with warnings" (`data/fs131/if1/build-stage1.log`).

## Stage 2 — SAVED (FS131-IF1): the route attacked, the lemmas confirmed, the skeleton stated, the price

**The candidate route, step by step** (the brief's § A candidate route; `φ_S(c, r) = |S ∩ B̄(c, r)| / |B̄(c, r)|`).

| step | what it reads | verdict |
|---|---|---|
| (1) both `S` and `Sᶜ` have density points | Lebesgue's density theorem, `Besicovitch.ae_tendsto_measure_inter_div` (closed balls, `𝓝[>] 0`, any set) with `Measure.exists_mem_of_measure_ne_zero_of_ae` | **accepted** |
| (2) the step: a ball of ratio `1/2` and radius `≤ δ` inside `B` | at small `ρ`, `φ_S(a, ρ) > 1/2` and `φ_{Sᶜ}(b, ρ) > 1/2`, hence `φ_S(b, ρ) < 1/2` (the two ratios sum to `1`: this is where measurability is read); `c ↦ φ_S(c, ρ)` continuous; intermediate value | **accepted, one change**: the centres allowed are the whole convex ball `B̄(c₀, R − ρ)` (`convex_closedBall`, `Convex.isPreconnected`, `IsPreconnected.intermediate_value`), not the segment — no parametrization, and `B̄(c, ρ) ⊆ B̄(c₀, R)` is one triangle inequality |
| (2′) continuity in the centre | `S ∩ B̄(c′, ρ) ⊆ (S ∩ B̄(c, ρ)) ∪ (B̄(c, ρ + d) ∖ B̄(c, ρ))`, `d = dist c′ c`; the annulus has measure `|B̄(0, ρ + d)| − |B̄(0, ρ)| → 0` (`Measure.addHaar_closedBall'`); both directions by symmetry; `ENNReal.tendsto_nhds` | **accepted**; needs no measurability of `S` |
| (3) a ball of ratio `1/2` holds a density point of each in its interior | positive measure of `S` and `Sᶜ` in the open ball (`Measure.addHaar_sphere_of_ne_zero`), then (1) in the open ball | **accepted** |
| (3′) the sequence | dependent choice on the subtype of balls of ratio `1/2` (`choose` on the step, `Nat.iterate`) | **accepted** |
| (4) the common point | nested compact sets (`IsCompact.nonempty_iInter_of_sequence_nonempty_isCompact_isClosed`, `ProperSpace`); `B̄(cₙ, rₙ) ⊆ B̄(x, 2 rₙ)` and `|B̄(x, 2 rₙ)| = 2^d |B̄(cₙ, rₙ)|` (`Measure.addHaar_closedBall_mul`), so both ratios at `x` along `2 rₙ` are at least `1 / (2 · 2^d)`; neither tends to `1` | **accepted**; at `d = 2` the bound is the brief's `1/8` |

No step refuted. Two things the attack added, both the brief's "better outcomes":

- **Any dimension, and the paper's hypothesis.** Nothing in the argument reads the plane: it runs in a finite-dimensional real
  normed space `E` with an additive Haar measure `μ`, for a `μ`-null-measurable `S` (for Lebesgue measure, a Lebesgue measurable
  set — the paper's "measurable"). The axiom's statement is the instance `E = ℂ`, `μ = volume`, `S` Borel, **by unfolding**:
  `data/fs131/if1/lean/Bridge.lean` elaborates `H hS.nullMeasurableSet h1 h2` against the axiom's conclusion.
- **A quantitative form**: at the point found, along radii `→ 0`, `S` and `Sᶜ` both have ratio `≥ 1 / (2 · 2^d)` — both have
  positive upper density there, with an explicit constant. The paper's statement is its corollary.

**Lemmas confirmed with `#check` at the pin** (`data/fs131/if1/lean/Checks.lean`, `lake env lean`):
`Besicovitch.ae_tendsto_measure_inter_div`, `MeasureTheory.Measure.addHaar_closedBall`, `…addHaar_closedBall'`,
`…addHaar_closedBall_center`, `…addHaar_sphere` (needs `Nontrivial E`; `addHaar_sphere_of_ne_zero` does not),
`…addHaar_closedBall_mul`, `MeasureTheory.measure_inter_add_diff₀` (deprecated at the pin for `measure_inter_add_sdiff₀`),
`MeasureTheory.measure_diff` (deprecated for `measure_sdiff`), `IsPreconnected.intermediate_value`, `convex_closedBall`
(`Mathlib/Analysis/Normed/Module/Convex.lean`), `Convex.isPreconnected`, `ENNReal.tendsto_nhds`, `ENNReal.Tendsto.sub`,
`IsCompact.nonempty_iInter_of_sequence_nonempty_isCompact_isClosed`, `Metric.closedBall_subset_closedBall'`,
`MeasureTheory.ae_restrict_of_ae_restrict_of_subset`, `Metric.ball_union_sphere`, `MeasureTheory.Measure.restrict_apply`;
by grep, `MeasureTheory.Measure.exists_mem_of_measure_ne_zero_of_ae` (`Mathlib/MeasureTheory/Measure/Restrict.lean:414` — under
`Measure`). Instances resolved: `HasBesicovitchCovering E`, `ProperSpace E`, `SecondCountableTopology E` for finite-dimensional
real normed `E`; `(volume : Measure ℂ).IsAddHaarMeasure`, `FiniteDimensional ℝ ℂ`.

**The skeleton** (`data/fs131/if1/lean/MetricalBoundary.skeleton.lean`; elaborates with 13 `sorry`s, the last theorem's
assembly from its two children already a proof): `measure_inter_closedBall_le_add`, `tendsto_measure_closedBall_sub`,
`continuous_measure_inter_closedBall`, `measure_inter_closedBall_div_add_compl`, `exists_mem_ball_tendsto_ratio`,
`measure_inter_ball_ne_zero_of_ratio_eq_half`, `exists_closedBall_ratio_eq_half` (the step),
`exists_closedBall_subset_ratio_eq_half`, `exists_closedBall_ratio_eq_half_of_measure_ne_zero`,
`exists_nested_closedBalls_ratio_eq_half`, `ratio_two_mul_ge`, `exists_ratio_ge_and_compl_ge` (the quantitative form),
`not_tendsto_ratio_compl_of_ratio_ge`, `exists_not_tendsto_ratio_and_compl` (the paper's statement, any dimension). No new
definition: the ratio is written out, in the shape of Besicovitch's theorem in Mathlib.

**Price, after the attack**: about 250 lines of Lean in one new module `Proofs/HadwigerNelson/Plane/MetricalBoundary.lean`
(imports Mathlib only), one line of proof and one import in `FalconerReduction`; the `ENNReal` arithmetic of
`ratio_two_mul_ge` and the continuity lemma are where the lines go. The working file stays out of the library (and of
`Proofs.lean`) until it has no `sorry`; snapshots are committed under `data/fs131/if1/lean/`.

## Stage 3 — SAVED (FS131-IF1): the general theorem, proved and in the library

`Proofs/HadwigerNelson/Plane/MetricalBoundary.lean` (new; 338 lines, Mathlib imports only; in `Proofs.lean` and in
`ARCHITECTURE.md` § 3.11): every leaf of Stage 2's skeleton closed, no `sorry`, no statement of the skeleton changed. One child
added, `measure_compl_inter_closedBall_div_eq_half` (ratio one half for `S` gives ratio one half for `Sᶜ`; used twice). Three
theorems carry `omit [BorelSpace E] in` (the build's unused-section-variable linter named them). Spec examples at the foot: a
model of the hypotheses in dimension one (`Ioi 0 ⊆ ℝ`), an adversary (`S = univ`: the conclusion fails, so `μ Sᶜ ≠ 0` cannot be
dropped), and the quantitative constant at dimension one (`1/4`).

The proofs went through as Stage 2 priced them; the first elaboration of the whole file failed at five leaves, each a name or a
rewrite target (`ENNReal.one_half_lt_one` is stated at `2⁻¹`; `ENNReal.div_eq_iff` does not exist — `ENNReal.eq_div_iff`;
`Set.diff_eq` deprecated for `sdiff_eq`; a `rw` with `addHaar_closedBall'` took `closedBall 0 1` for its target; a
`rw [← ENNReal.add_halves 1]` rewrote every `1`), none an obstacle of the mathematics.

**Build**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0, "467 of 467 batches, 2
module(s) rebuilt, 0 module(s) with warnings, 8m19s" (`data/fs131/if1/build-stage3a.log`; rebuilt: `Plane/MetricalBoundary`,
`Proofs`). `tools/check_architecture.py`: `RESULT: PASS`, exit 0 (`data/fs131/if1/check-architecture-stage3a.log`).

**Axioms, with a control that fires**: `data/fs131/if1/lean/AxiomsPrint.lean` prints the fifteen theorems and one planted
theorem resting on `sorry`; `tools/fs131_if1_axioms_check.py <output> 15` judges both with one predicate — fifteen records, each
exactly `[propext, Classical.choice, Quot.sound]`, and the control prints `[sorryAx]` and fires
(`data/fs131/if1/axioms-print-stage3a.out`). The tool's own faults, each watched (`data/fs131/if1/axioms-check-controls.log`):
(a) a dirty record judged as a library record → exit 1; (b) one record missing → exit 1, `count: 14 … expected 15`; (c) a
control made clean → exit 1, `did NOT fire`; (d) the unmodified output → exit 0. This is iteration evidence
(`lake env lean`); the gate's receipt is Stage 4's `scripts/axioms.sh`.

## Stage 4 — SAVED (FS131-IF1): the axiom is a theorem, and the audit moved with it

**The swap** (`Proofs/HadwigerNelson/Plane/FalconerReduction.lean`). `git diff ca598960` on the statement:

```
-axiom falconer_lemma2_nonempty {S : Set ℂ} (hS : MeasurableSet S) (h1 : volume S ≠ 0) (h2 : volume Sᶜ ≠ 0) :
-    ∃ x : ℂ, x ∉ densitySet S ∧ x ∉ densitySet Sᶜ
+theorem falconer_lemma2_nonempty {S : Set ℂ} (hS : MeasurableSet S) (h1 : volume S ≠ 0) (h2 : volume Sᶜ ≠ 0) :
+    ∃ x : ℂ, x ∉ densitySet S ∧ x ∉ densitySet Sᶜ :=
+  exists_not_tendsto_ratio_and_compl volume hS.nullMeasurableSet h1 h2
```

The keyword, and the `:=` with its one-line proof — the general theorem at `E = ℂ`, `μ = volume`, by unfolding `densitySet`.
Same name, binders, conclusion. What else the change forced in that file, and nothing more: one import line
(`Plane/MetricalBoundary`); the lemma's docstring (what is now proved, by which theorem, and that the proof is not claimed to
be Croft's); two phrases of the section's module doc that said "imported"; the first words of
`upperHalfPlane_falconer_hyp`'s docstring ("Model of the import's hypotheses" → "Model of `falconer_lemma2_nonempty`'s
hypotheses"). No other statement or definition anywhere changed; no `axiom`, no `native_decide`, no `sorry`.

**The audit** (`scripts/Axioms.lean`): the `declareImport` line removed; the four records (`falconer_reduction`,
`le_chiM_of_falconerFan`, `exists_mem_falconerE`, `fan_tip_ae_mem`) moved from IMPORTED to CLEAN, beside wave 2's
`FalconerReduction` records (after `falconer_lemma4` — not at the foot of CLEAN, where every wave appends and a merge would
meet them); `falconer_lemma2_nonempty` itself and the fifteen theorems of `Plane/MetricalBoundary` registered there; two
sentences of the IMPORTED banner's prose brought to the current state (the section is empty; the procedure stays).
`ARCHITECTURE.md`: § 5's row for the import removed, with one line of current state under the table's header; § 3.11's row
for `Plane/FalconerReduction` names the theorem and the new import.

**Receipts** (all from the worktree, under the slot; logs in `data/fs131/if1/`):

| check | command | exit | reading |
|---|---|---|---|
| build | `slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` | 0 | "467 of 467 batches, 9 module(s) rebuilt, 0 module(s) with warnings, 10m23s" (`build-stage4.log`; rebuilt: `Plane/FalconerReduction` and its dependents through `Plane/Slack` and `Plane/ValidMap/Dense`, `Proofs`) |
| axiom audit | `slot.py --mem 16 --cpus 4 -- ./scripts/axioms.sh` | 0 | "audited: 5825 records — 5803 clean on the standard axioms, 17 axiom-free, 0 imported […], 5 declared purchase(s)"; "declared imports (0): none"; "library axioms other than native auxiliaries (0): none; native auxiliaries: 10"; "RECORDED COUNT IS STALE in CLAUDE.md § Trust ledger — update it: 5783 clean → 5803, 4 imported → 0" (`axioms-gate-stage4.log`; the whole receipt, `axioms-gate-stage4-full.log`) |
| the five records | read in the saved receipt, lines 2700–2704 | — | `falconer_lemma2_nonempty`, `falconer_reduction`, `le_chiM_of_falconerFan`, `exists_mem_falconerE`, `fan_tip_ae_mem`: each `[propext, Classical.choice, Quot.sound]` |
| self-test, **red before** | `slot.py --mem 16 --cpus 4 -- ./scripts/axioms.sh --self-test`, controls file unchanged | 1 | "3 of 23 control(s) did not behave as designed": `baseline` (got `imported=0 declared=0 library=0`), `imported_declared` (got `1 / 1 / 1`), `banner_dropped` (the two consequences naming `falconer_reduction` and `falconer_lemma2_nonempty` did not fire) (`axioms-selftest-red-before.log`) |
| self-test, **green after** | the same, after `data/fs131/if1/controls-edit.py` | 0 | "OK — every planted fault fired, and every partner passed", 23 of 23 (`axioms-selftest-green-after.log`) |
| doubled names | `slot.py --mem 16 --cpus 4 -- ./scripts/dupnames.sh` | 0 | "OK — no name is declared by two modules (23 generated on demand […])" (`dupnames-stage4.log`) |
| module map | `python3 tools/check_architecture.py` | 0 | `RESULT: PASS` (`check-architecture-stage4.log`); on copies, a row without the new import → exit 1, "imports of Plane/FalconerReduction: stated-only [], real-only ['Plane/MetricalBoundary']"; the new module's row removed → exit 1, "module coverage" (`check-architecture-controls.log`) |
| linters (one cheap check beyond the brief's list, to spare the landing a round trip) | `slot.py --mem 8 --cpus 4 -- lake lint --no-build -- --no-build --trace` | 0 | every linter "(2/2) Passed!", "-- Linting passed for Proofs." (`lint-stage4.log`) |

`rg -uu '^\s*axiom '` over `Proofs/` finds one line, an example inside `Sat/Lrat.lean`'s prose; the environment's own count
is the audit's `LIBRARY SUMMARY axioms=0 native=10`.

**The self-test with no declared import** (the brief's question). Its design does not need one: every IMPORTED control plants
its own axiom (`t3c_import`) in a copy of the audit, and FS131-T3 wrote the controls for an empty list (`a09b2254`). Three
controls read the library's state and move with it, in `scripts/axioms-controls.txt` (not `scripts/axioms.sh`, which the
brief's touch list names; the counts live in the controls file): `baseline` (`imported / declared / library`, and the text of
its `old` digest), `imported_declared` (the same three, each one higher), and `banner_dropped` (with records in the IMPORTED
section, dropping its banner also strands them and their declaration). They are back at FS131-T3's values: `0 / 0 / 0` with
the older-form digest matching, `1 / 1 / 1`, and the banner alone. **At the landing where this branch meets the Weil import's**:
per declared import, `declared` and `library` rise by one in both controls and `imported` by its record count, the two `old`
digests' texts follow (`…and the audit has N imported`), and `banner_dropped` regains `FAIL outside-banners <one of its
records>` and `FAIL stale-declaration <the axiom>` — FS131-I2n's edit (`082f86c9`) is the pattern, and the file's header now
says so. Three places will meet in that merge: the IMPORTED section of `scripts/Axioms.lean` (this branch deletes the lines
the other appends beside), `ARCHITECTURE.md` § 5's table (a row deleted here, a row added there; the "None at present" line
then goes), and those control lines.

**Not run, by the brief** (the landing runs the full gate): `./scripts/vacuity.sh`. Its counts in `CLAUDE.md` § The gate will
move — the new module adds fifteen theorems, whose hypotheses are parametric (a set, a measure, radii), and
`falconer_lemma2_nonempty` is now a theorem with a model in its file (`upperHalfPlane_falconer_hyp`).

## Stage 5 — SAVED (FS131-IF1): the statements read aloud, the drafts, the report

**The final statements, read against the informal claim.**

- `HadwigerNelson.Plane.falconer_lemma2_nonempty` — "for a (Borel) measurable `S ⊆ ℂ` with `volume S ≠ 0` and `volume Sᶜ ≠ 0`
  there is `x` with `x ∉ densitySet S` and `x ∉ densitySet Sᶜ`", `densitySet A = {x | the ratio volume (A ∩ B̄(x, r)) / volume
  B̄(x, r) → 1 as r → 0⁺}`. Against `[Falconer1981]` p. 185, Lemma 2 (i), first clause, "∂S is non-empty": **the same at
  `n = 2` for Borel `S`** (Stage 1's reading). Unchanged from the axiom, character for character.
- `HadwigerNelson.Plane.exists_not_tendsto_ratio_and_compl` — "`E` a finite-dimensional real normed space with its Borel
  σ-algebra, `μ` an additive Haar measure, `S` `μ`-null-measurable with `μ S ≠ 0`, `μ Sᶜ ≠ 0`: there is `x` at which neither
  `μ (S ∩ B̄(x, r)) / μ B̄(x, r)` nor `μ (Sᶜ ∩ B̄(x, r)) / μ B̄(x, r)` tends to `1` as `r → 0⁺`". Against the paper's sentence in
  full ("a measurable subset of Rⁿ", Lebesgue measurable by the paragraph above it): **the same, in every dimension and for
  every norm**, since the two ratios sum to `1` — "not `1`" for `Sᶜ` is "not `0`" for `S`. A model of the hypotheses and an
  adversary (`S = univ`) are in the module.
- `HadwigerNelson.Plane.exists_ratio_ge_and_compl_ge` — the same hypotheses; "there are `x` and radii `sₙ > 0`, `sₙ → 0`, with
  both ratios at `(x, sₙ)` at least `1 / (2 · 2 ^ dim E)` for every `n`". Not in the paper: it says `S` and `Sᶜ` both have
  upper density at least that constant at `x`. At `E = ℂ` the constant is `1/8`.

**The report**: `data/fs131/reports/FS131-IF1.md`, in standing rule 11's form; its text is the job's hand-back. Wall clock, from
the commits: launch about 12:50, Stage 1 saved 12:58, Stage 3 (the general theorem built) 13:16, Stage 4 (the audited swap)
13:33 — about 45 minutes, 19 of them two builds. No background process is left running; everything this record cites is under
`data/fs131/if1/` or in the tree.

## Drafts for the front page

*For Keryx to file; I edited none of these files. Counts are this branch's, at `d64a78a7`, cut from `main` at `ca598960`;
at the landing they are added to whatever `main` then reads.*

1. **`CLAUDE.md` § Trust ledger** — the sentence "the current audit reads 5783 clean and 5 declared purchases, and 4 imported
   (and 17 axiom-free; 5,809 records at wave 10's first landing, FS131-L10A, 2026-10-06)". From this branch alone it reads:
   **"the current audit reads 5803 clean and 5 declared purchases, and 0 imported (and 17 axiom-free; 5,825 records at
   `[Falconer1981]` Lemma 2 (i)'s proof, FS131-IF1, 2026-10-06)"**. The deltas, to apply to `main`'s numbers at the landing:
   clean **+20** (the four records moved from IMPORTED, `falconer_lemma2_nonempty` itself, fifteen new theorems), imported
   **−4** (to 0 if no other import has landed), records **+16**, purchases and axiom-free unchanged; declared imports 1 → 0,
   library axioms 1 → 0. The clause "an imported record rests on a declared outside theorem (`LEAN.md` § Trust ledger)" stays:
   it defines the count, and the Weil import will use it.
2. **`CLAUDE.md` § The gate** — the vacuity counts will move (fifteen new declarations in `Plane/MetricalBoundary`, and
   `falconer_lemma2_nonempty` now a theorem). **Not measured here**: the brief keeps the full gate with the landing.
3. **`CLAUDE.md` § Frontier, "What the kernel holds"** — after the clause on FS-101's first slot, or wherever the landing's line
   for wave 2 sits: *"the library declares no axiom: `[Falconer1981]` Lemma 2 (i), its one import, is proved — in any finite
   dimension, for null-measurable sets and any additive Haar measure (`Plane.exists_not_tendsto_ratio_and_compl`, FS131-IF1), so
   Falconer's reduction (`falconer_reduction`, `le_chiM_of_falconerFan`; FS129-SA1-FALC-RED) reads the standard three"*.
4. **`LEDGER.md` row 152** (Falconer's fan at every number of colours; "kernel pending" today) — when wave 2's landing
   regrades its FALC-RED clause to [kernel]: declaration `Plane.falconer_reduction` / `Plane.le_chiM_of_falconerFan`
   (`Proofs/HadwigerNelson/Plane/FalconerReduction.lean`), axioms `[propext, Classical.choice, Quot.sound]`, **resting on no
   import and no named hypothesis** — the assumption `Plane.falconer_lemma2_nonempty` it carried is the theorem of that name.
5. **`BIBLIOGRAPHY.md`, the `[Falconer1981]` row** (line 169), appended to its third cell: *"Lemma 2 (i) — the metrical boundary
   of a measurable set neither null nor conull is nonempty — was imported as an axiom by FS-131 wave 2 and is no longer
   assumed: FS131-IF1 proved it in the kernel (`Plane.exists_not_tendsto_ratio_and_compl`: any finite-dimensional real normed
   space, any additive Haar measure, null-measurable sets, with a quantitative form, `exists_ratio_ge_and_compl_ge`;
   `Plane.falconer_lemma2_nonempty` is its instance at `ℂ`), by an argument derived here — nested balls in which the set has
   ratio one half — which has not been compared with Croft's Lemma 4 (the paper's ref. [1], unheld) and is not claimed new:
   the statement is classical."* And its read status gains *"p. 185 re-read first-hand for the statement (FS131-IF1)"*.
   **The Croft debt row** (line 882, "the source of `[Falconer1981]`'s Lemmas 1 and 3"): add *"and of its Lemma 2 (i) (Croft's
   Lemma 4), which the library no longer needs from it (FS131-IF1)"*. **No work was read for the density theorem**: it is
   Mathlib's `Besicovitch.ae_tendsto_measure_inter_div`, so no new row. The planner's attribution of the classical statement
   (the density topology on `ℝⁿ` is connected; Goffman–Neugebauer–Nishiura 1961) stays **recalled, not read** — a prior-art
   debt, below.
6. **`LEAN.md` § Trust ledger** — no line needed: the section describes the mechanism (an import, its four items, the
   `declareImport` line), which is unchanged; the state is `CLAUDE.md`'s sentence and `ARCHITECTURE.md` § 5. **`LEAN.md`
   § Searching — Lean**, one bullet offered, after the `add_le_add_left` bullet:
   *"`ENNReal`: `ENNReal.one_half_lt_one` is stated at `2⁻¹`, not `1 / 2` (`ENNReal.half_lt_self` gives `a / 2 < a`);
   there is no `ENNReal.div_eq_iff` — `ENNReal.eq_div_iff : b = c / a ↔ a * b = c`. `Measure.exists_mem_of_measure_ne_zero_of_ae`
   is under `Measure`. `Measure.addHaar_sphere` asks `Nontrivial E`; `addHaar_sphere_of_ne_zero` does not. A `rw` with
   `Measure.addHaar_closedBall'` takes the first closed ball about `0` in the goal, `closedBall 0 1` included: name the radius.
   An intermediate value on a convex set needs no path: `(convex_closedBall c r).isPreconnected.intermediate_value` (FS131-IF1)."*
7. **`ARCHITECTURE.md`** — edited on this branch (it is in the brief's touch list): § 3.11 rows for `Plane/MetricalBoundary`
   (new) and `Plane/FalconerReduction`; § 5 "Imported outside theorems", the row gone and one line of current state.
8. **The Proof Atlas** — `falconer_lemma2_nonempty` changes kind (axiom → theorem); `exists_mem_falconerE`, `fan_tip_ae_mem`,
   `falconer_reduction`, `le_chiM_of_falconerFan` lose their dependence on an import; one new module, fifteen theorems.

## Theorems this phase proved

*Kernel theorems, each `[propext, Classical.choice, Quot.sound]` (Stage 3's print; Stage 4's audit for the receipt). All in
`Proofs/HadwigerNelson/Plane/MetricalBoundary.lean`, namespace `HadwigerNelson.Plane`, for a finite-dimensional real normed
space `E` with an additive Haar measure `μ`.*

- `exists_not_tendsto_ratio_and_compl` [kernel] — **`[Falconer1981]` Lemma 2 (i) in any finite dimension**: a `μ`-null-measurable
  `S` with `μ S ≠ 0`, `μ Sᶜ ≠ 0` has a point that is a density point neither of `S` nor of `Sᶜ`.
- `exists_ratio_ge_and_compl_ge` [kernel] — the quantitative form: at some point, along radii tending to `0`, `S` and `Sᶜ`
  both have ratio at least `1 / (2 · 2 ^ dim E)`.
- `exists_closedBall_ratio_eq_half` [kernel] — the step: a ball of ratio exactly `1/2` and radius at most `δ` inside a closed
  ball whose interior holds a density point of `S` and one of `Sᶜ`.
- `exists_nested_closedBalls_ratio_eq_half` [kernel] — nested closed balls of ratio `1/2`, radii at least halving.
- `continuous_measure_inter_closedBall` [kernel] — `c ↦ μ (S ∩ B̄(c, ρ))` is continuous, any `S`, `ρ > 0`.
- `not_tendsto_ratio_compl_of_ratio_ge` [kernel] — ratio at least `κ > 0` along radii tending to `0` excludes density `1` of
  the complement.
- `falconer_lemma2_nonempty` [kernel] (`Proofs/HadwigerNelson/Plane/FalconerReduction.lean`) — **the axiom, now a theorem**, same
  statement: a measurable `S ⊆ ℂ` with `volume S ≠ 0`, `volume Sᶜ ≠ 0` has a point outside `densitySet S` and `densitySet Sᶜ`.
  Audit (Stage 4): `[propext, Classical.choice, Quot.sound]`.
- Moved from IMPORTED to CLEAN, statements untouched, each now `[propext, Classical.choice, Quot.sound]` in the audit:
  `exists_mem_falconerE`, `fan_tip_ae_mem`, `falconer_reduction`, `le_chiM_of_falconerFan` (FS129-SA1-FALC-RED).
- Children [kernel]: `measure_inter_closedBall_le_add`, `tendsto_measure_closedBall_sub`,
  `measure_inter_closedBall_div_add_compl`, `measure_compl_inter_closedBall_div_eq_half`, `exists_mem_ball_tendsto_ratio`,
  `measure_inter_ball_ne_zero_of_ratio_eq_half`, `exists_closedBall_subset_ratio_eq_half`,
  `exists_closedBall_ratio_eq_half_of_measure_ne_zero`, `ratio_two_mul_ge`.
