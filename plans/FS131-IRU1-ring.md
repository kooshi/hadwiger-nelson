# FS131-IRU1 — the ring of unit vectors in the kernel: Lemma C′, the components clause and the dichotomy (implementer)

*Implementer: de Bruijn (FS131-IRU1), on branch `fs131-kru1` in the worktree `.claude/worktrees/il5`, from `e27c45182` (the
planner's skeleton with `main` merged in). Brief: `data/fs131/briefs/FS131-IRU1-ring.md` (on `main` at `fe00e94d1`). The plan:
`plans/FS131-KRU1-ring-plan.md`. Nothing in this milestone is blind.*

## Theorems this phase proved

None yet.

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
