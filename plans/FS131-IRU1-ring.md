# FS131-IRU1 — the ring of unit vectors in the kernel: Lemma C′, the components clause and the dichotomy (implementer)

*Implementer: de Bruijn (FS131-IRU1), on branch `fs131-kru1` in the worktree `.claude/worktrees/il5`, from `e27c45182` (the
planner's skeleton with `main` merged in). Brief: `data/fs131/briefs/FS131-IRU1-ring.md` (on `main` at `fe00e94d1`). The plan:
`plans/FS131-KRU1-ring-plan.md`. Nothing in this milestone is blind.*

## Theorems this phase proved

40 theorems, every one **[kernel]**, from build 3 (`45de7612d`; the library the gated commit carries unchanged, stage 3); axioms as `#print axioms` lists them
(`data/fs131/iru1/axioms-all.txt`). No outside theorem, no `native_decide`, no hypothesis standing for an assumption.

- `Rigidity.cayley_mul_conj_eq_one` — `Rigidity/NormOneGen` — [propext, Quot.sound]
- `Rigidity.closure_normOne_eq_top` — `Rigidity/NormOneGen` — [propext, Classical.choice, Quot.sound]
- `Rigidity.exists_fixed_add_mul` — `Rigidity/NormOneGen` — [propext, Classical.choice, Quot.sound]
- `Rigidity.exists_model_galoisField` — `Rigidity/NormOneGen` — [propext, Classical.choice, Quot.sound]
- `Rigidity.inv_mem_of_finite` — `Rigidity/NormOneGen` — [propext, Classical.choice, Quot.sound]
- `Rigidity.mem_closure_normOne_of_fixed` — `Rigidity/NormOneGen` — [propext, Classical.choice, Quot.sound]
- `Rigidity.div_natCast_mem_localRing` — `Rigidity/UnitRingEq` — [propext, Classical.choice, Quot.sound]
- `Rigidity.exists_eq_add_mul_of_mem_stableIntegers` — `Rigidity/UnitRingEq` — [propext, Classical.choice, Quot.sound]
- `Rigidity.exists_two_pow_mul_mem_unitRing` — `Rigidity/UnitRingEq` — [propext, Classical.choice, Quot.sound]
- `Rigidity.isUnit_add_mk_of_conj_eq` — `Rigidity/UnitRingEq` — [propext, Classical.choice, Quot.sound]
- `Rigidity.isUnit_mk_sub_conj` — `Rigidity/UnitRingEq` — [propext, Classical.choice, Quot.sound]
- `Rigidity.natCast_notMem_pow_absNorm` — `Rigidity/UnitRingEq` — [propext, Classical.choice, Quot.sound]
- `Rigidity.normOne_subset_range_resPi` — `Rigidity/UnitRingEq` — [propext, Classical.choice, Quot.sound]
- `Rigidity.not_isRamified_of_odd_mem` — `Rigidity/UnitRingEq` — [propext, Classical.choice, Quot.sound]
- `Rigidity.resPi_surjective` — `Rigidity/UnitRingEq` — [propext, Classical.choice, Quot.sound]
- `Rigidity.unitRing_eq_stableIntegers` — `Rigidity/UnitRingEq` — [propext, Classical.choice, Quot.sound]
- `Rigidity.dvd_scaleRoots_eval_sub_pow` — `Rigidity/UsablePrime` — [propext, Classical.choice, Quot.sound]
- `Rigidity.exists_Ioo_aeval_neg` — `Rigidity/UsablePrime` — [propext, Classical.choice, Quot.sound]
- `Rigidity.exists_dvd_eval_of_dvd_scaleRoots_eval` — `Rigidity/UsablePrime` — [propext, Classical.choice, Quot.sound]
- `Rigidity.exists_isUsablePrime` — `Rigidity/UsablePrime` — [propext, Classical.choice, Quot.sound]
- `Rigidity.exists_one_add_mul_div_pow_mem_Ioo` — `Rigidity/UsablePrime` — [propext, Classical.choice, Quot.sound]
- `Rigidity.exists_prime_mod_four_eq_three_dvd` — `Rigidity/UsablePrime` — [propext, Classical.choice, Quot.sound]
- `Rigidity.exists_prime_three_mod_four_dvd_eval` — `Rigidity/UsablePrime` — [propext, Classical.choice, Quot.sound]
- `Rigidity.exists_stablePrime_natCast_mem` — `Rigidity/UsablePrime` — [propext, Classical.choice, Quot.sound]
- `Rigidity.localBound_lt_top` — `Rigidity/UsablePrime` — [propext, Classical.choice, Quot.sound]
- `Rigidity.nonempty_stablePrime` — `Rigidity/UsablePrime` — [propext, Classical.choice, Quot.sound]
- `Rigidity.scaleRoots_eval_eq` — `Rigidity/UsablePrime` — [propext, Classical.choice, Quot.sound]
- `Rigidity.connected_or_infinite_planeOver` — `Rigidity/PlaneComponents` — [propext, Classical.choice, Quot.sound]
- `Rigidity.connected_planeOver_iff_isEmpty_stablePrime` — `Rigidity/PlaneComponents` — [propext, Classical.choice, Quot.sound]
- `Rigidity.connected_planeOver_iff_subset` — `Rigidity/PlaneComponents` — [propext, Classical.choice, Quot.sound]
- `Rigidity.infinite_connectedComponent_planeOver` — `Rigidity/PlaneComponents` — [propext, Classical.choice, Quot.sound]
- `Rigidity.infinite_connectedComponent_planeOver_of_not_mem` — `Rigidity/PlaneComponents` — [propext, Classical.choice, Quot.sound]
- `Rigidity.infinite_connectedComponent_planeOver_of_stablePrime` — `Rigidity/PlaneComponents` — [propext, Classical.choice, Quot.sound]
- `Rigidity.not_connected_planeOver` — `Rigidity/PlaneComponents` — [propext, Classical.choice, Quot.sound]
- `Rigidity.reachable_add_sum` — `Rigidity/PlaneComponents` — [propext, Classical.choice, Quot.sound]
- `Rigidity.reachable_iff_sub_mem_unitRingOver` — `Rigidity/PlaneComponents` — [propext, Classical.choice, Quot.sound]
- `UnitRingModels.exists_stablePrime_three_not_isRamified` — `Instances/UnitRingModels` — [propext, Classical.choice, Quot.sound]
- `UnitRingModels.noRamifiedStableDyadic_sqrt47` — `Instances/UnitRingModels` — [propext, Classical.choice, Quot.sound]
- `UnitRingModels.stableIntegers_sqrt47_ne_top` — `Instances/UnitRingModels` — [propext, Classical.choice, Quot.sound]
- `UnitRingModels.unitRing_eq_stableIntegers_sqrt47` — `Instances/UnitRingModels` — [propext, Classical.choice, Quot.sound]

## Stage 1 — SAVED: the readback

### 1.1 Quotations

All ten block quotations of the brief are verbatim in their named sources: `data/fs131/iru1/quote_check.py` (after the
planner's `data/fs131/kru1/quote_check.py`) strips the `> ` prefix, collapses whitespace and searches the source, read from
this worktree (the skeleton modules exist only on this branch). Run 2026-10-16 20:56 UTC: `ALL VERBATIM`, exit 0
(`data/fs131/iru1/quote_check.out`): W2 (278 chars), `LEDGER.md` row 100 (3,453), the five Lean statements (135, 167, 61, 184,
137), inventory items 1044 (3,246), 1040 (2,287) and 1025 (2,276). Planted control (`--plant`: one character changed in the
first and the last quotation): exactly quotations 0 and 9 reported `MISMATCH`, the others `OK`, `PLANT FIRED`, exit 0
(`quote_check_plant.out`). No mismatch: no finding about the brief.

The brief's other figures, checked against the skeleton: **40 leaves** — `Rigidity/NormOneGen` 6, `Rigidity/UnitRingEq` 10,
`Rigidity/UsablePrime` 11, `Rigidity/PlaneComponents` 9, `Instances/UnitRingModels` 4 (the module's `example` is proved by a
term); the five head statements at the lines inventory item 1044 names. **FS131-ICS1's bridge** (`UpperHalf.exists_stablePrime_card_eq_sq`,
`Arith/StableAboveUsable`) is not on `main` at `fe00e94d1` (grep of `Proofs/`, 2026-10-16 20:55 UTC): I take the plan's
fallback (`exists_stablePrime_natCast_mem` by `Arith.placeHom_base` and row 105's prime inversion), as the brief directs.

### 1.2 The target, the rulings, the order of work

**The target.** Replace each of the 40 `sorry`s of the five skeleton modules by a proof, changing no stored statement; make
public the three private lemmas of `Rigidity/AdmissiblePrime` that route E reads (`exists_integral_primitive`,
`exists_dvd_of_dvd_exponent`, `nonempty_residueHom`), each with the plan's § 3.7 item 1 docstring, in my first build; then the
full gate on one commit. The head statements: Lemma C′ as typed (`Rigidity.unitRing_eq_stableIntegers`), its odd part at every
real number field (`Rigidity.exists_two_pow_mul_mem_unitRing`), `F(i)` has a stable prime at every real number field
(`Rigidity.nonempty_stablePrime`), the dichotomy at every subfield of `ℝ` (`Rigidity.connected_or_infinite_planeOver`) and C8,
the components clause at every real number field (`Rigidity.infinite_connectedComponent_planeOver`).

**The rulings I work under** (inventory items 1044, 1040, 1025, quoted in the brief):
1. *`AdmissiblePrime`'s three private lemmas made public* — a ruled change of stored names (the three constants and their
   generated internals move from `_private.….0.` to public names, LEAN.md l. 369); their stored types must not change.
2. *The dichotomy rides* — `connected_or_infinite_planeOver`, `connected_planeOver_iff_isEmpty_stablePrime` are proved here.
3. *One implementer, sequential*: one branch, one gate.
4. *The elementary route E*, no outside theorem: the stable prime at every real number field from a usable prime of degree one
   found by the sign change of a minimal polynomial at its real root.
5. *History*: commits by explicit path on `fs131-kru1`, never pushed; the commit hook's privacy guard is obeyed, never
   bypassed.

**Not mine:** any stored statement of the skeleton or of `main` beyond the ruled `AdmissiblePrime` edit — a statement that
cannot be proved as typed goes to the coordinator, never edited.

**The order of work** (the plan's, § 3.5): module 1 (`NormOneGen`, Mathlib only), with the `AdmissiblePrime` edit in the first
build; module 2 (`UnitRingEq`); module 3 (`UsablePrime`); module 4 (`PlaneComponents`); module 5 (`UnitRingModels`). A saved stage
after each module's build. Iteration on a scratch farm (a symlink copy of the compiled library, `build/iru1-farm`), never in
`.lake/build`; the builds through `scripts/build.sh` under the slot, with the brief's command line.

### 1.3 The statement dump, before any proof edit

Taken at 2026-10-16 20:56 UTC from the planner's compiled modules as they stand (`lake build --no-build` under the slot: only
the root `Proofs` out of date, `data/fs131/iru1/uptodate0.log`), before any edit of any source:
`data/fs131/iru1/lean/StatementDump.lean` (FS131-ICO2's dumper, module list changed: the five skeleton modules and
`Rigidity/AdmissiblePrime`) → `data/fs131/iru1/statements-before.txt.gz` (166 lines; `AdmissiblePrime` 33 constants,
`NormOneGen` 6, `UnitRingEq` 14, `UsablePrime` 11, `PlaneComponents` 9, `UnitRingModels` 4). The sources it was made from:
`data/fs131/iru1/skeleton-sources.md5`.

## Stage 2 — the leaves (module 1 committed; modules 2–5 proved on the farm, build to follow)

### 2.1 Module 1, `Rigidity/NormOneGen` (6 leaves) and the ruled `AdmissiblePrime` edit

All six leaves proved as planned (§ 3.5 module 1 of the plan), with the two private helpers the plan names:
`add_conj_mul_inv_mem` (the Cayley element's denominator over `θ − σθ` lies in the generated ring) and
`unit_mem_closure_normOne` (`(θ − σθ)⁻¹` and `θ − σθ` lie in it). The model `exists_model_galoisField` exhibits `θ` with
`θ³ ≠ θ` by the root count of `X³ − X` (`Polynomial.card_le_degree_of_subset_roots`, `FiniteField.X_pow_card_sub_X_natDegree_eq`)
against `|𝔽₉| = 9`. **104 lines** of proof against the plan's 125. The three lemmas of `Rigidity/AdmissiblePrime` made public
with the plan's § 3.7 item 1 docstrings (commit `c01417289`), the ruled change; no other line of that module touched. Before
publicizing I checked that no module of this tree or of the branches `fs131-kcs1`, `fs131-kfr1`, `fs131-ktc1`, `fs131-pv2`,
`fs131-rdm1` declares a public constant of those names (each holds the three as `private`, a textual difference at a join,
no doubled name).

### 2.2 The re-price, from the first leaves

The first two leaves (`inv_mem_of_finite` 6 lines against 15, `exists_fixed_add_mul` 13 against 20) priced at 0.55 of the
plan; the whole of module 1 at 0.83. Carried through all five modules on the farm, the proof text added is **571 lines**
against the plan's ≈ 970: module 1 104, module 2 151 (plan 270), module 3 208 (plan 345, the fallback leaf included), module 4
103 (plan 195), module 5 5 (plan 35). The total moved by more than a third, downward; no reason to stop or to re-scope, and
the job is not slower than the brief assumed.

### 2.3 A statement defect, ruled (inventory item 1049)

`Rigidity.not_isRamified_of_odd_mem` stored `[NumberField ↥F]`, read by no step of its proof (`IsRamified.isDyadic` and
ideal arithmetic need none): the build's `unusedSectionVars` warning and Batteries' `unusedArguments` (run on every public
constant of modules 1–2 on the farm, `data/fs131/iru1/probes/Lint2.lean`: this was the only one flagged) both named it. Messaged
to the coordinator 2026-10-16 ~21:08 UTC with two forms; **ruled (a)**: `omit [NumberField F] in` above the declaration, a
ruled one-binder drop, to be checked from the kernel's side by the re-add and the stored-type comparison (§ the gate). Its
one consumer, `exists_two_pow_mul_mem_unitRing`, keeps its binders.

### 2.4 Modules 2–5 on the farm

Written in copies under `data/fs131/iru1/work/` while the first build walked (it reads the real modules, which still held the
skeleton), each elaborated against a farm (`data/fs131/iru1/farm.sh`: a symlink copy of the compiled library under
`build/iru1-farm`, the modules under work compiled over their removed links, `.lake/build` never written) with the lakefile's
options, every one with no error and no warning. Departures from the plan, each a choice within my brief:
- **Module 2.** `two_le_absNorm_stablePrime` (private) restates `Counting`'s private `two_le_absNorm` rather than opening it
  (five lines). Everything else as the plan says.
- **Module 3.** `exists_prime_mod_four_eq_three_dvd` by strong induction through `Nat.minFac` (not `induction_on_primes`);
  `exists_Ioo_aeval_neg` by the plan's factorization `g = (X − θ)·h` and the continuity of `h`; `localBound_lt_top` takes the
  finiteness of `𝓞 L ⧸ P` from `Ideal.absNorm ≠ 0` (`Nat.finite_of_card_ne_zero`), since `Ideal.finiteQuotientOfFreeOfNeBot`
  is outside the module's imports and I did not add an import (it can move stored instances). **The fallback was taken**:
  FS131-ICS1's bridge is not on `main`, so `exists_stablePrime_natCast_mem` is proved as the plan's fallback — the subring of
  points whose two coordinates lie in `Arith.placeHom_base`'s `V` holds `ℤ[U]`, `1/q` would make `φ(1/q)·φ(q) = 1` with
  `φ(q) = 0`, and row 105's prime inversion. It reads only the unit-vector clause of `IsPlaceHom`.
- **Module 4.** `reachable_iff_sub_mem_unitRingOver`'s `⟹` by induction on the walk (not `reflTransGen`).
- **Module 5.** Four short terms, as planned.

### 2.5 The builds

- **Build 1** (2026-10-16 21:00–21:23 UTC, on `c01417289`: module 1 and the ruled `AdmissiblePrime` edit; the brief's command
  line, `--mem 8 --cpus 4`, `MEMMAX=8G BATCH=3`): "build: OK — 739 of 739 batches, 20 module(s) rebuilt, 4 module(s) with
  warnings, 22m21s", exit 0 (`data/fs131/iru1/build1.out`). Rebuilt: `NormOneGen`, `AdmissiblePrime` and the 17 modules
  downstream of it (its docstrings and its three renames), and the root; the 34 warnings are the 34 `sorry` leaves of the
  four modules still holding the skeleton then; `NormOneGen` none.
- **Build 2** (21:24–21:42 UTC, on `bebe75273`: modules 2–5 in place, the five module titles retitled "proved by
  FS131-IRU1", `UsablePrime`'s docstring corrected and given its prior-art paragraph): "build: OK — 739 of 739 batches, 6
  module(s) rebuilt, 0 module(s) with warnings, 17m57s", exit 0 (`data/fs131/iru1/build2.out`, full log
  `data/fs131/iru1/build2-full.log`: 0 lines with `warning`). Sources checked unchanged against `build2.sources.md5` after.
- On that build: the statement comparison CLEAN with every plant fired (§ 3.2), the re-add equal, the environment linters
  passed (`data/fs131/iru1/lint-preview.log`, a preview before the gate's own run), and every head statement on the standard
  three (`data/fs131/iru1/readaloud.txt`).
- **One edit after build 2**: `infinite_connectedComponent_planeOver` was a term `let ⟨P⟩ := …`, which stored a public
  matcher `infinite_connectedComponent_planeOver.match_1_1` that the vacuity scan counts as a declaration
  (`data/fs131/iru1/vacuity-new.txt` of build 2); now `(nonempty_stablePrime F).elim …`, no matcher. Build 3 follows on the
  commit that carries it; the gate runs on that commit.

## Stage 2 — SAVED (all 40 leaves proved; build 2 green)

## Stage 3 — the gate

### 3.1 Build 3, the gated build

On `45de7612d` (the matcher removed; § 2.5): "build: OK — 739 of 739 batches, 3 module(s) rebuilt, 0 module(s) with warnings,
21m13s", exit 0 (`data/fs131/iru1/build3.out`, full log `data/fs131/iru1/build3-full.log`). Rebuilt: `PlaneComponents`,
`UnitRingModels`, the root. Sources checked unchanged after (`build3.sources.md5`).

### 3.2 No statement changed but the ruled ones (from the kernel's side)

`tools/fs131_iru1_statements.py` (FS131-ICO2's comparator, two ruled classes added) on the dump taken before any edit
(`data/fs131/iru1/statements-before.txt.gz`, stage 1) and the dump of build 3 (`statements-after-build3.txt.gz`):
**VERDICT CLEAN, 0 failures** (`data/fs131/iru1/statements-compare.out`). Per module: `AdmissiblePrime` 24 SAME and the three
**RENAMED OK** (private made public; stored type's `Expr.hash` equal and its text equal once the hygienic number of each
instance binder of the renamed constant is blanked); `NormOneGen` 6 SAME, 2 private added (`add_conj_mul_inv_mem`,
`unit_mem_closure_normOne`); `UnitRingEq` 11 SAME, **DROPPED OK** `not_isRamified_of_odd_mem` (the binder
`[NumberField ↥F]` removed exactly, inventory item 1049), 1 private added (`two_le_absNorm_stablePrime`); `UsablePrime` 11
SAME; `PlaneComponents` 9 SAME; `UnitRingModels` 4 SAME. No public constant added, none generated on demand (`eq_n`,
`congr_simp`). **Planted controls, each watched to fire and nothing else new**: a changed character in
`unitRing_eq_stableIntegers`'s stored type; that constant dropped; an unlisted public constant added; the dropped binder
removed one character short; a renamed constant with another stored hash — `PLANTS ALL FIRED`. The two `example` heads
(not stored) compared as text with the skeleton at `e27c45182`, block comments blanked first: SAME, a planted character
reported (`data/fs131/iru1/examples-compare.out`).

**The re-add** (`data/fs131/iru1/lean/ReAdd.lean` → `readd.txt`): `[NumberField ↥F]` put back after `{F}` in the stored
type of `not_isRamified_of_odd_mem` gives hash `619762426`, the skeleton's stored hash; the controls (domain `True`:
`1295855567`; the right domain one binder later: `1653348068`) differ.

### 3.3 The audit's records

`data/fs131/iru1/lean/AxiomsAll.lean` (FS131-ICT2's printer, module list changed) printed every record of the six modules
from build 3 (`axioms-all.txt`): 47 public (46 on `[propext, Classical.choice, Quot.sound]`, 1 on `[propext, Quot.sound]`),
25 private, none on `sorryAx`, none on an outside theorem. `tools/fs131_iru1_audit_block.py` (FS131-ICT2's generator):
47 public, 2 already filed (`exists_residueHom_unramified`, `exists_unitPair`), **45 CLEAN records** emitted
(`audit.clean.lean`) and placed in `scripts/Axioms.lean` above the PURCHASED banner under a block header naming this job;
its planted control (an unknown axiom, a `sorryAx`, a declared import, a misfiled record) reported all four, exit 1
(`audit-plant.out`); `--coverage` after: "COVERAGE OK: every one of the 47 public records is filed under its class"
(`audit-coverage.out`).

### 3.4 The vacuity scan's new declarations

`data/fs131/iru1/lean/VacuityNew.lean` on build 3 (`vacuity-new.txt`): the scan's declarations in the six modules are 47 —
`AdmissiblePrime` 5 (2 before: the three made public are new to it), `NormOneGen` 6, `UnitRingEq` 12, `UsablePrime` 11,
`PlaneComponents` 9, `UnitRingModels` 4 — so **+45 declarations** against the base library; **+1 refutation skipped**:
`UnitRingModels.noRamifiedStableDyadic_sqrt47`, whose type `NoRamifiedStableDyadic F47` unfolds to `∀ P, IsDyadic P →
IsRamified P → False`; it is a true refutation of the configuration it names (a ramified dyadic stable prime of
`ℚ(√47, i)`), and it is the model of item 1's scope, so its skip loses nothing.

### 3.5 The first full gate run (on `f73b481ad`): one failure, the gate's own

`data/fs131/iru1/run-gate.sh` (a copy of `data/fs131/clone1/run-gate.sh`, paths changed), run from a snapshot at
`build/iru1/snap/` (the script finds the root three levels up; a first snapshot at `build/` refused with exit 2, "not the
repository root", before running any step). Every step green but one (`data/fs131/iru1/gate-run1/run-pass.out`):
`assumptions exit=1` — "**FAIL stale-condition `HadwigerNelson.Arith.IsUsablePrime`** :: declared a condition, and it is
concluded by [`HadwigerNelson.Rigidity.exists_isUsablePrime`]: the entry is not needed". The landing brought a theorem that
concludes the former (LEAN.md § Searching — Lean, FS131-LGT1's line): the `.condition` entry is retired from
`AssumptionAudit.declared`, by the step's own rule. The vacuity step was green and said its recorded counts are stale:
"declarations 22519 → 22564, refutations-skipped 243 → 244" in `scripts/vacuity-baseline.txt`'s header and in `CLAUDE.md`
§ The gate — exactly the +45 and +1 of § 3.4; the baseline's header is refiled here, `CLAUDE.md` drafted (stage 5). The
audit read "axioms: OK — 10930 clean, 574 axiom-free, 83 imported, 5 declared purchase(s)": 10,885 + 45 against FS131-ICT3's
gate, the rest unchanged. The gate is run again in full on the commit that carries the two edits.

### 3.6 The gate on one commit (`ddb765bac`): green

`data/fs131/iru1/run-gate.sh` again in full, 2026-10-16 22:25–22:40 UTC (`data/fs131/iru1/gate/run-pass.out`; every log under
`data/fs131/iru1/gate/`, its exit on its last line): `HEAD=ddb765bac… tracked-modified=0`; **uptodate** 0 (Lake: nothing to
build); **sorry** (narrow) 0 lines; line-initial `axiom` lines 5 (the library's, unchanged); **dupnames** 0 ("no name is declared
by two modules (31 generated on demand)"); **dupnames self-test** 0 (15 of 15 controls); **axioms** 0 ("10930 clean, 574
axiom-free, 83 imported, 5 declared purchase(s)"); **axioms self-test** 0 (23 controls); **vacuity** 0 (`declarations=22564
refutations-skipped=244`, `sites=1465 vacuous=0 stale=0 declared=3 witnessed=40 generic=1420 unknown=2`; the baseline's header
"match (9 of 9 compared)"); **vacuity self-test** 0 (65 of 65); **assumptions** 0 (`axioms=3 rests=105 named=19 inline=14
outside=7 ours=21 open=5 takes=109 mentions=2`; `conditions=40 fails=0`); **assumptions self-test** 0 (33 of 33); **arch** 0
(PASS); **lint** 0 ("Linting passed for Proofs."; every linter `(2/2) Passed!`). The three digests exit 0; each flags only
`CLAUDE.md`'s recorded counts as stale (drafted, stage 5). The pass ends "tracked files modified after the pass: 2": this
record and `data/fs131/iru1/examples-compare.out`, edited while the pass ran; neither is read by any step.

**Every count change against `main`'s last gate (FS131-ICT3, `data/fs131/ict3/gate/`), explained:**

| count | ICT3 | here | change | why |
|---|---|---|---|---|
| audit records | 11,547 | 11,592 | +45 | the 45 CLEAN records of § 3.3 |
| clean | 10,885 | 10,930 | +45 | the same; none is axiom-free, imported or purchased |
| axiom-free, imported, purchases | 574, 83, 5 | 574, 83, 5 | 0 | no record of this job is one |
| vacuity declarations | 22,519 | 22,564 | +45 | the 45 public declarations of § 3.4 |
| refutations-skipped | 243 | 244 | +1 | `UnitRingModels.noRamifiedStableDyadic_sqrt47` (§ 3.4) |
| sites and their verdicts | 1,465 … | 1,465 … | 0 | no binder of a tracked carrier in the six modules |
| assumptions' nine counts | as here | as here | 0 | no hypothesis declared, none taken |
| conditions (decided, not one of the nine) | 41 | 40 | −1 | `IsUsablePrime`'s entry retired (§ 3.5) |

**Negative controls watched**: the four self-tests above (each plants its faults and reports every one fired); the first run's
red on the stale condition (a fault the landing made, named by the step, § 3.5); this job's own checks — the quotation check, the
statement comparison (five plants), the example heads, the audit block (four plants), the re-add (two controls) — each seen to
fire. `#print axioms` of every head statement and model on the gated build: `[propext, Classical.choice, Quot.sound]`, each
(`data/fs131/iru1/readaloud.txt`, 19 lines, rerun on build 3); the re-add rerun there gives the skeleton's hash again.

### 3.7 Structures in the hypotheses, and their models

The vacuity scan has no new site (no binder of a tracked colouring carrier); the structures the new statements take, each with
a model the kernel holds: `StablePrime F` — `Rigidity.nonempty_stablePrime` at every real number field, and the terms
`UnitRingModels.exists_stablePrime_three_not_isRamified` (`ℚ(i)`, above 3) and `SqrtFortySeven.exists_stablePrime_eleven`;
`¬ IsRamified P` (and `∀ P ∈ Φ, ¬ IsRamified P`) — the prime above 3 of `ℚ(i)`; `NoRamifiedStableDyadic F` —
`UnitRingModels.noRamifiedStableDyadic_sqrt47`; `IsUsablePrime 𝔭` — `Rigidity.exists_isUsablePrime` at every real number
field (whence the retired condition); the hypotheses of `closure_normOne_eq_top` and its children (a finite ring, an involution,
`θ − σθ` a unit, `a + θ` a unit for each fixed `a`) — `Rigidity.exists_model_galoisField`, every clause exercised;
`z ∈ planeOver F ∧ z ∉ ℤ[U]` of `infinite_connectedComponent_planeOver_of_not_mem` — exhibited inside
`infinite_connectedComponent_planeOver_of_stablePrime`'s proof at every real number field (a point outside `𝓞_P`), not as a
separate theorem; the integer-polynomial hypotheses of route E (`f` monic, a simple real root) — the minimal polynomial of an
integral primitive element of any real number field, as `exists_isUsablePrime`'s proof uses them.

## Stage 3 — SAVED (the gate green on `ddb765bac`)

## Stage 4 — the read-aloud

Read against the kernel's own print of each head statement (`data/fs131/iru1/readaloud.txt`, `#check @` with full names,
from the build gated in stage 3), against `LEDGER.md` row 100, the roadmap's typed form (`ROADMAP.md` § 3 item 2) and the
asking lane's C8 (`plans/POROS-2026-10-13-number-field-findings.md`, rank 8). Vocabulary, unfolded one step in the same
print: `UnitRing.unitRing σ = Subring.closure (normOne σ)`, `normOne σ = {u | u·σu = 1}`; `stableIntegers F = ⨅ P, P.localRing`
over `StablePrime F` (a maximal ideal `P` of `𝓞 (F(i))` with `P.comap conjO = P`); `IsRamified P := ∀ x, conjO x − x ∈ P`;
`IsDyadic P := 2 ∈ P`; `NoRamifiedStableDyadic F := ∀ P, IsDyadic P → ¬ IsRamified P`; `IsUsablePrime 𝔭 := 𝔭.IsMaximal ∧
Nat.card (𝓞 F ⧸ 𝔭) % 4 = 3`; `localBound F = ⨅ P, (levelTarget P 1).chromaticNumber`; the plane's graph
`(unitDistance ℂ).induce (planeOver F)`, `planeOver F = {z | z.re ∈ F ∧ z.im ∈ F}`.

1. **`Rigidity.unitRing_eq_stableIntegers : ∀ {F : Subfield ℝ} [NumberField ↥F], NoRamifiedStableDyadic F →
   UnitRing.unitRing (conjOn ⋯) = stableIntegers F`.** For a number field `F` given inside `ℝ`, if no conjugation-fixed prime
   of `𝓞 (F(i))` that holds 2 has conjugation acting trivially on its residue field, then the subring of `F(i)` generated by the
   elements of norm one equals the elements of `F(i)` lying in every localization at a conjugation-fixed prime. **Against row
   100**: "Lemma C′: `R_F = O′`, the ring integral at the stable primes, with no Galois hypothesis, except possibly at a ramified
   stable dyadic place" — the same statement with the exception as the scope. **Against the roadmap's typed form**: the same
   text, `[NumberField F]` and `F` implicit from the section, as the planner read it. **Against C8**: C8 says "the additive group
   generated by the unit vectors is the ring …"; the kernel's `R` is the *subring* the unit vectors generate, which is the same
   set (the unit vectors hold `1`, `−1` and are closed under products, so their additive span is a ring: the library's
   `UnitRing.exists_sum_eq_of_mem_unitRingOver`); and C8's scope "no prime above 2 fixed by conjugation ramifies in `F(i)`" is
   `NoRamifiedStableDyadic` read through `IsRamified` — conjugation trivial on the residue field, which at a stable prime is
   ramification in `F(i)/F` (the identification of the two is the derivation's, not stated in the kernel). **Not claimed:** the
   converse (false: `ℚ(√2)` has a ramified stable dyadic prime and `R = O′`, row 100); `R = O′` at a field with a ramified
   stable dyadic prime (false at `ℚ(√5)`, `ℚ(√17)`); Lemma C (`R ⊗ ℤ_p`); CLG; the injectivity half of `R/nR ≅ O′/nO′`.
2. **`Rigidity.exists_two_pow_mul_mem_unitRing : ∀ {F} [NumberField ↥F] {x : ↥(fieldI F)}, x ∈ stableIntegers F →
   ∃ a, 2 ^ a * x ∈ UnitRing.unitRing (conjOn ⋯)`.** At every real number field, with no scope, every element integral at the
   stable primes lands in `R` after multiplication by a power of 2: `R` and `O′` agree once 2 is inverted. FS91-J07-4's
   statement at every odd `p`, in its global form. **Not claimed:** any bound on `a`.
3. **`Rigidity.exists_eq_add_mul_of_mem_stableIntegers`**: for `n ≠ 0` such that no stable prime holding `n` is ramified, every
   `x ∈ O′` is `r + n·y` with `r ∈ R`, `y ∈ O′` — `R + n·O′ = O′`, the onto half of J07-4's `R/nR ≅ O′/nO′` at `n`.
4. **`Rigidity.nonempty_stablePrime : ∀ (F : Subfield ℝ) [NumberField ↥F], Nonempty (StablePrime F)`.** Every number field
   inside `ℝ` has, in `F(i)`, a conjugation-fixed maximal ideal of the ring of integers. With
   **`Rigidity.exists_isUsablePrime`**: for every `M ≠ 0`, a prime `q ∤ M` and a maximal ideal `𝔭 ∋ q` of `𝓞 F` with exactly
   `q` residues and `q ≡ 3 (mod 4)` (`IsUsablePrime` asks the residue count `≡ 3 (mod 4)`; here it is `q` itself) — a usable
   prime of degree one outside any finite set of rational primes. **Against row 105**: its sentence "That statement ranges over
   a type the kernel does not show to be non-empty (a stable prime exists by Chebotarev)" is now false of the kernel: the type is
   shown non-empty at every real number field, with no Chebotarev and no outside theorem. **Not claimed:** infinitely many such
   primes as a set (only "outside any finite set", which implies it but is not stated as `Set.Infinite`); a density; that the
   stable prime above `𝔭` is unique or inert; anything at a field with no real embedding.
5. **`Rigidity.localBound_lt_top : ∀ (F : Subfield ℝ) [NumberField ↥F], localBound F < ⊤`.** `L(F)` is a finite number at
   every real number field (`⨅` over a non-empty family of chromatic numbers of finite graphs).
6. **`Rigidity.connected_or_infinite_planeOver : ∀ (F : Subfield ℝ), (…induce (planeOver F)).Connected ∨ Infinite
   (…induce (planeOver F)).ConnectedComponent`.** For every subfield `F` of `ℝ`, number field or not, the unit-distance graph
   on `F²` is connected or has infinitely many connected components (Mathlib's `Connected`, `ConnectedComponent`, `Infinite`).
   **Not claimed:** which one at a field that is not a number field (`ℝ` itself is connected; not stated).
7. **`Rigidity.connected_planeOver_iff_isEmpty_stablePrime : ∀ {F} [NumberField ↥F], (…).Connected ↔ IsEmpty (StablePrime
   F)`**, and with item 4, **`Rigidity.not_connected_planeOver`** and **`Rigidity.infinite_connectedComponent_planeOver :
   ∀ (F : Subfield ℝ) [NumberField ↥F], Infinite (…induce (planeOver F)).ConnectedComponent`** — **C8's components clause**:
   "in every case the unit-distance graph on `F²` has infinitely many components", at every real number field, and nothing
   more. **Not claimed:** anything about a component's shape beyond `reachable_iff_sub_mem_unitRingOver` (two points are joined
   exactly when their difference lies in `ℤ[U]`, so the components are the cosets of `ℤ[U]` in `F²`, a reading not stated as
   an equivalence of types); a count of components beyond `Infinite`.
8. **The ruled drop**: `Rigidity.not_isRamified_of_odd_mem : ∀ {F} (P : StablePrime F) {n : ℕ}, Odd n → ↑n ∈ P.P →
   ¬ IsRamified P` — the skeleton's statement with `[NumberField ↥F]` removed (inventory item 1049), strictly more general.

**Axioms of every head statement**: `[propext, Classical.choice, Quot.sound]`, each (the same print); no outside theorem, no
`native_decide`, no hypothesis standing for an assumption.

**The models** (each a theorem of the landing, on the standard three): the scope of item 1 at `ℚ(√47)`
(`UnitRingModels.noRamifiedStableDyadic_sqrt47`), item 1 there (`unitRing_eq_stableIntegers_sqrt47`) and not trivially
(`stableIntegers_sqrt47_ne_top`: a stable prime above 11, so `O′ ≠ F(i)`); the local hypothesis `¬ IsRamified P` of items 3
and of `resPi_surjective` at the prime `(3)` of `ℚ(i)` (`exists_stablePrime_three_not_isRamified`); the hypotheses of the
generation lemma `closure_normOne_eq_top` at `𝔽₉` with `x ↦ x³` (`exists_model_galoisField`, every clause exercised: an
involution, `θ − θ³` a unit, `a + θ` a unit at each of the three fixed `a`); items 2, 4–7 take `NumberField F` or nothing, and
`ℚ` inhabits them (`UpperHalf.numberField_bot`); the components at `ℚ(√47)` as a spec example.

## Stage 4 — SAVED (the read-aloud)

## Drafts for the front page

*Each draft names its slot. Every count below is this branch's gate (stage 3) on `f73b481ad`, whose library is `main` at
`e27c45182`'s merge (the three-colour criterion's landing, FS131-ICT3) plus this job; `main` has since taken FS131-ICS1's landing
(five colours by field and by class), so at the join the counts are `main`'s plus this job's deltas, which are stated for that
purpose. No novelty wording: where the brief said "prior art not yet searched", FS131-PAS1 has since searched both statements
(inventory item 1052; its record § 5.3–5.4 and § 6.3–6.4), and the drafts below carry its verdicts by reference, held for this
landing by item 1052's ruling.*

**D1 — `CLAUDE.md` § Trust ledger**, the sentence "the current audit reads … clean and 5 declared purchases, and … imported
(and … axiom-free; … records at …)": this job adds **45 CLEAN records** and nothing else (no purchase, no import, no axiom-free
record): on this branch the audit reads "10930 clean and 5 declared purchases, and 83 imported (and 574 axiom-free; 11,592 records)" (gate on `ddb765bac`). `main`'s sentence now reads "10914 clean … 99 imported (and 574 axiom-free; 11,592 records at FS131-ICS1 …)"; at the join, with no record shared: **10959 clean, 99 imported, 574 axiom-free, 5 purchases, 11,637 records**, to be read off the join's own audit before filing. At the join: `main`'s clean count + 45, records + 45, the rest unchanged.
The assumptions step's nine counts are unchanged by this job (`axioms=3 rests=105 named=19 inline=14 outside=7 ours=21 open=5 takes=109 mentions=2` here, ICT3's; `main`'s after FS131-ICS1 stand at the join): it declares no hypothesis and adds no taker; it retires one `.condition` (`Arith.IsUsablePrime`, now concluded by `Rigidity.exists_isUsablePrime`), which none of the nine counts.

**D2 — `CLAUDE.md` § The gate**, the vacuity scan's counts line: on this branch `declarations=22564 refutations-skipped=244 sites=1465`, `vacuous=0 stale=0 declared=3 witnessed=40 generic=1420 unknown=2` (and `scripts/vacuity-baseline.txt`'s header refiled to match); against `main`'s line after FS131-ICS1 (`declarations=22566 refutations-skipped=243 sites=1465 …`) the join reads `declarations=22611 refutations-skipped=244 sites=1465`, the rest unchanged, if no declaration is shared; this job's deltas
**declarations +45, refutations-skipped +1, sites +0** (`data/fs131/iru1/vacuity-new.txt`; the skipped one is
`UnitRingModels.noRamifiedStableDyadic_sqrt47`, § 3.4).

**D3 — `LEDGER.md` row 100** (regraded in part; CLG stays [hand]):
- in the **Not claimed** field, replace "whether CLG-g's exception is ever realised; a kernel proof." by "whether CLG-g's exception
  is ever realised; a kernel proof of CLG or of Lemma C.";
- after the **Not claimed** field, before **Prior art**, add: "**Kernel** (since <landing>, on the standard three axioms, no
  hypothesis beyond the scope): Lemma C′ as typed, `Rigidity.unitRing_eq_stableIntegers` (`Rigidity/UnitRingEq`: `R = O′` when
  no stable dyadic prime is ramified); its odd part at every real number field, no scope, `Rigidity.exists_two_pow_mul_mem_unitRing`
  (`2^a·x ∈ R` for every `x ∈ O′`); the onto half of `R/nR ≅ O′/nO′` wherever no stable prime holding `n` is ramified,
  `Rigidity.exists_eq_add_mul_of_mem_stableIntegers`; the local step as a lemma on finite rings,
  `Rigidity.closure_normOne_eq_top` (a finite commutative ring with an involution moving some `θ` by a unit, `θ` plus every fixed
  element a unit, is generated by its norm-one elements; through the Cayley elements, with no counting and no Hensel); the
  model `UnitRingModels.unitRing_eq_stableIntegers_sqrt47`, not trivial there (`stableIntegers_sqrt47_ne_top`)."
- in the **Prior art** field, FS131-PAS1's § 5.4 item 1 (held for this landing by item 1052), unchanged.

**D4 — `LEDGER.md` row 105**, replace "That statement ranges over a type the kernel does not show to be non-empty (a stable prime
exists by Chebotarev), and the splitting itself is not stated" by "That statement's type is non-empty at every real number field
(`Rigidity.nonempty_stablePrime`, [kernel] since <landing>, on the standard three: a usable prime of degree one —
`Rigidity.exists_isUsablePrime`, a prime `q ∤ M`, `q ≡ 3 (mod 4)`, and a maximal ideal of `𝓞 F` with `q` residues, for every
`M ≠ 0` — from the sign change of the minimal polynomial of an integral primitive element at its real root and Kummer–Dedekind,
and the prime inversion above for the stable prime over it, with no Chebotarev and no outside theorem — classical: `[Nagell1969]`
Théorème 3 (every polynomial with a real zero has infinitely many prime divisors `≢ 1 (mod n)`, every `n ≥ 3`; proved in
`[Nagell1951]` Thm 97, after `[Bauer1916]`), at `n = 4`), and the splitting itself is not stated" — the second clause is
FS131-PAS1's § 6.4 item 1, folded in at the place it names; whether Nagell's route is the sign change is not read.

**D5 — `LEDGER.md`, a new row** (number Keryx's; or the same text appended to row 105 if a row is not wanted): "**The components
of the plane over a real number field, in the kernel: for every subfield `F ⊆ ℝ` the unit-distance graph on `F²` is connected or
has infinitely many connected components; over a real number field it is connected exactly when `F(i)` has no stable prime, so,
every real number field having one, it has infinitely many components; and `L(F) < ∞` at every real number field**
(FS-131; FS131-KRU1's plan § 1.3 F2, F7; FS131-IRU1). **[kernel]** on the standard three: `Rigidity.connected_or_infinite_planeOver`,
`Rigidity.connected_planeOver_iff_isEmpty_stablePrime`, `Rigidity.infinite_connectedComponent_planeOver`,
`Rigidity.not_connected_planeOver`, `Rigidity.localBound_lt_top`; the component lemma `Rigidity.reachable_iff_sub_mem_unitRingOver`
(two points of `F²` are joined by a path of unit steps iff their difference lies in `ℤ[U]`, `[Fischer1990b]` §§ 2–3 "stated in
passing"). **Not claimed:** the shape of a component beyond being a coset of `ℤ[U]`; which alternative holds at a subfield of `ℝ`
that is not a number field. **Prior art:** C8's components clause for multiquadratic fields is `[Fischer1990b]`'s Corollary; the
stable prime at every real number field is classical through `[Nagell1969]` Thm 3 (row 105); the dichotomy and the equivalence
with the existence of a stable prime: prior art not yet searched. | `Rigidity/PlaneComponents.lean`, `Rigidity/UsablePrime.lean` |
FS-131 |"

**D6 — `ROADMAP.md` § 3**, delete item 2 ("**Lemma C′** (row 100): … `data/fs131/lch1/ring-scope-lemma-c-prime.lean`.") from the
list of what is left, and add to the section's opening paragraph, after "with its form that takes no hypothesis, `min(χ(F²), 5) =
min(L(F), 5)` (`Rigidity.min_chromaticNumber_five_eq_min_localBound_five`).": "It holds Lemma C′ as typed
(`Rigidity.unitRing_eq_stableIntegers`, row 100), its odd part at every real number field, and the components clause: the plane
over every real number field has infinitely many components (`Rigidity.infinite_connectedComponent_planeOver`), through a stable
prime at every real number field with no Chebotarev (`Rigidity.nonempty_stablePrime`, row 105); so `L(F) < ∞` everywhere
(`Rigidity.localBound_lt_top`)." The appendix's row 100 entry stays (CLG is [hand]); row 105, if listed there for its Chebotarev
clause, leaves it.

**D7 — Proof Atlas grade changes**: row 100, Lemma C′ and its odd form [hand, three derivations] → [kernel]; row 105's existence
clause [hand: "by Chebotarev"] → [kernel] (no Chebotarev); C8's components clause [hand] → [kernel]; `L(F) < ∞` [derived] →
[kernel].

**D8 — `CLAUDE.md` § Frontier**, the "Last filed" line: "**the ring of unit vectors** (FS131-KRU1, FS131-IRU1, <date>: five modules
through the gate on <commit> — Lemma C′ as typed, `R = O′` with no ramified stable dyadic prime, and `2^a·O′ ⊆ R` at every real
number field; a stable prime at every real number field with no Chebotarev, so the plane over every real number field has
infinitely many components; on the standard three; rows 100, 105; no value of `χ(ℝ²)` moved)". In § Where the problem stands,
"**What the kernel holds, beyond the interval**", after the residue upper half's clause ("…`QuadraticPrime.exists_maximal_card_eq`,
`…_of_ramified`)"), add: "; **every real number field has a stable prime** (`Rigidity.nonempty_stablePrime`, no Chebotarev: a usable
prime of degree one, classical through `[Nagell1969]` Thm 3), so `L(F) < ∞` (`Rigidity.localBound_lt_top`) and the plane over it has
infinitely many components (`Rigidity.infinite_connectedComponent_planeOver`, with the dichotomy at every subfield of `ℝ`); **Lemma
C′** — the ring the unit vectors generate is the ring integral at the stable primes when no stable dyadic prime is ramified, and
after a power of 2 at every real number field (`Rigidity.unitRing_eq_stableIntegers`, `…exists_two_pow_mul_mem_unitRing`; row 100;
prior art: the general form not found in print, FS131-PAS1)".

**D9 — `LEAN.md` § Searching — Lean**, new lines (FS131-IRU1):
- "A term-mode `let ⟨P⟩ := h` in a theorem's value stores a public matcher `<thm>.match_1_1` that the vacuity scan counts as a
  declaration (its `isInternal` does not skip it) while a statement dump marks it internal; `h.elim f` stores none
  (`Rigidity.infinite_connectedComponent_planeOver`, FS131-IRU1)."
- "At the pin `Ideal.finiteQuotientOfFreeOfNeBot` is outside the import closure of `Rigidity/AdmissiblePrime` +
  `Arith/PlaceHom` + `Arith/UpperHalf`, and Mathlib's `Finite (𝓞 K ⧸ I)` for maximal `I` (`NumberTheory/NumberField/Ideal/Basic`)
  too; `Nat.finite_of_card_ne_zero` with `← Submodule.cardQuot_apply, ← Ideal.absNorm_apply` and `Ideal.absNorm_eq_zero_iff`
  gives `Finite (𝓞 L ⧸ P ^ m)` with no import (`Rigidity.localBound_lt_top`, FS131-IRU1)."
- "A sign change of an integer polynomial at a simple real root needs no derivative theorem: `g = (X − θ)·h`
  (`mul_divByMonic_eq_iff_isRoot`), `g′(θ) = h(θ)` by `derivative_mul`, and `h`'s sign near `θ` by
  `(h.continuous.continuousAt).eventually (gt_mem_nhds _)` with `Metric.eventually_nhds_iff` (`Rigidity.exists_Ioo_aeval_neg`,
  FS131-IRU1)."
- "`Polynomial.scaleRoots_eval₂_mul` at `Int.castRingHom R` gives the homogeneous value `kⁿ f(x/k)`; `rw [eq_intCast]` (not
  `simp only [Int.coe_castRingHom]`, which leaves a β-redex `(fun x => ↑x) …` that `rw` cannot see) turns the applied cast hom into
  the cast (`Rigidity.scaleRoots_eval_eq`, FS131-IRU1)."
- "The planner's § 3.7 item 6 line (`Mathlib.Data.Fintype.Units` deprecated for `Mathlib.Algebra.GroupWithZero.Units.Fintype`) stands
  as drafted."

**D10 — `plans/POROS-2026-10-13-number-field-findings.md` § 3.3 (C8)**, the planner's § 3.7 item 7, brought to what is proved: "C8
is in the kernel (FS131-IRU1): Lemma C′ as typed and its odd form; the components clause at every real number field, which is
equivalent there to the existence of a stable prime, and that existence is classical (`[Nagell1969]` Thm 3) and kernel-checked with
no Chebotarev."

**D11 — `plans/FS131-KCS1-class-plan.md` § 2.6** (superseded, item 1044's logged correction): a banner "Superseded by
`plans/FS131-KRU1-ring-plan.md` and proved by FS131-IRU1; the map here priced three leaves that were held (FS131-KRU1 § 1.3 F1)."

## Stage 5 — SAVED (the drafts)
