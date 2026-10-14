# FS131-IE1 — the entropy base of the five-colour chain: the port of three files of `[OAIMath2026]` family 015, and the leaves of `Rigidity/Entropy` over them

*The implementer's record (de Bruijn, the implementer). Brief: `data/fs131/briefs/FS131-IE1-entropy-base.md` (in the
coordinator's tree). Plan: `plans/FS131-KN6-chain-first-layer.md` § Stage 5. Worktree `fs131-wch`, branch `fs131-we1`,
cut from `afd9df200`. Working files: `data/fs131/ie1/`. Not pushed (the brief: the server is unreachable).*

## Theorems this phase proved

*Each line: the declaration, its axioms as printed from the built tree (Stage 4), the file. Grade: [kernel] for every
line. The informal statement each was read against is § 1.3's column.*

- `HadwigerNelson.Rigidity.blockEntropy_one` — `[propext, Classical.choice, Quot.sound]` — `Rigidity/Entropy.lean`
- `HadwigerNelson.Rigidity.ksEntropy_id` — `[propext, Classical.choice, Quot.sound]` — same
- `HadwigerNelson.Rigidity.ksEntropy_dirac` — `[propext, Classical.choice, Quot.sound]` — same
- `HadwigerNelson.Rigidity.ksEntropy_map` — `[propext, Classical.choice, Quot.sound]` — same
- `HadwigerNelson.Rigidity.nameCell_eq_orbitName_fibre` — `[propext, Quot.sound]` — same (FS131-KN6's statement and proof, compiled in the library for the first time)
- `HadwigerNelson.Rigidity.blockEntropy_eq_observationEntropy` — `[propext, Classical.choice, Quot.sound]` — same (FS131-KN6's statement and proof)
- `HadwigerNelson.Rigidity.partitionEntropy_eq_ofReal_observationEntropyRate` — `[propext, Classical.choice, Quot.sound]` — same (FS131-KN6's statement)
- `HadwigerNelson.Rigidity.ksEntropy_eq_measureEntropy` — `[propext, Classical.choice, Quot.sound]` — same (FS131-KN6's statement)
- `HadwigerNelson.Rigidity.tendsto_blockEntropy_div` (the pinning theorem) — `[propext, Classical.choice, Quot.sound]` — same
- `HadwigerNelson.Rigidity.exists_blockEntropy_le_mul` — `[propext, Classical.choice, Quot.sound]` — same
- `HadwigerNelson.Rigidity.ksEntropy_bind_eq_zero` (the mixture lemma) — `[propext, Classical.choice, Quot.sound]` — same
- Private helpers, each `[propext, Classical.choice, Quot.sound]` or fewer by the same audit's file: `blockEntropy_id`,
  `preimage_nameCell`, `partitionEntropy_map`, `exists_measurable_comp_of_comap` — same file
- **The port: 72 declarations of `[OAIMath2026]` family 015, kernel-checked here** (the release's theorems, not ours),
  each `[propext, Classical.choice, Quot.sound]` or fewer (`orbitName` axiom-free), none the declared theorem's: the full
  list is `data/fs131/ie1/port-names.txt`; among them `Outside.OAI015.tendsto_observationEntropyRate`,
  `orbitEntropy_subadditive`, `measureEntropy_lower_of_good_atoms` (`Outside/OAI015Shannon`),
  `observationEntropyRate_finite_mixture`, `measureEntropy_kernel_zero` (`Outside/OAI015Mixtures`),
  `finite_hopf_maximal`, `excessiveOccupation_measure_bound`, `ae_uniform_small_occupation_of_decreasing`
  (`Outside/OAI015Maximal`)
- Not proved, not this job's: `HadwigerNelson.Rigidity.ksEntropy_eq_iSup_ksEntropyOn` (the tenth leaf) —
  `[propext, sorryAx, Classical.choice, Quot.sound]`

## Stage 1 — SAVED: the readback, the leaves restated, the statements as the kernel holds them before any edit

**1.1 The brief's quotations** (standing rule 3). `tools/fs131_ie1_readback.py` (each quoted line a substring of its
source, read in the coordinator's tree, where the brief is committed): **3 matched, 0 mismatched**, exit 0
(`data/fs131/ie1/readback-brief.out`) — W2 against `data/fs131/REQUEST-2026-10-13.md`; NF2-LEAF-13 and the dated line
of 2026-10-14 on NF2-LEAF-18 against `data/fs131/claims-NF2.md`. With `--fault` (the last character of each quoted line
changed): 0 matched, 3 mismatched, exit 1 (`readback-brief-fault.out`). No finding about the brief.

**1.2 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building and § Make the
gate fail; the plan's Stages 3a–3c and 5–7 (`plans/FS131-KN6-chain-first-layer.md` ll. 170–580); the two draft claim
lists (`data/fs131/kn3/claims-M0-entropy-port.md`, `claims-M1-entropy.md`); `Rigidity/Entropy.lean` whole; the
planner's `data/fs131/kn6/bridge-statements.lean`, `tools/fs131_kn6_release_copy.py`, `data/fs131/kn6/{lean1,trial}.sh`;
the last two ports' generators and records (`tools/fs132_i2_port.py` whole; `plans/FS133-IA1-implementation.md`
Stages 1–2, in `fs133-wk1`); of the release, read only: `PrimePackets/ShannonEntropy.lean` whole,
`DukePrimeDegree/Dynamics/HopfMaximal.lean` and `MaximalOccupation.lean` whole, `PrimePackets/EntropyMixtures.lean`
ll. 1–240 and its outline, `PrimePackets/InverseEntropy.lean` ll. 1–50, 240–295.

**1.3 Each leaf, in one line, beside the plan's route** (the file's text is the statement; this is a reading aid).

| leaf | the statement, in one line | the plan's route (§ 5.4) |
|---|---|---|
| **P** | no statement of ours: the release's `ShannonEntropy.lean`, `EntropyMixtures.lean`, and the maximal inequality (`HopfMaximal.lean`, `MaximalOccupation.lean`, three declarations of `InverseEntropy.lean`), as three generated modules under `Outside/` | copy by line range with a generator that refuses a patch to a statement or a definition; the scan before any copy; seven one-token renames expected |
| 1 `blockEntropy_one` | `blockEntropy μ T P 1 = ∑ c : Fin k, negMulLog (μ.real (P ⁻¹' {c}))`, any measure, any map | reindex words of length one by `Equiv.funUnique`; the cell of `w` is `P ⁻¹' {w 0}` |
| 2 `ksEntropy_id` | `ksEntropy μ id = 0`, any measure | `ksEntropy_eq_zero_iff`; `H_{n+1} = H_1` for the identity (non-constant words have empty cells); `H_1/(n+1) → 0` |
| 3 `ksEntropy_dirac` | `ksEntropy (dirac x) T = 0` for measurable `T` | every cell is measurable, so of mass `0` or `1`; `negMulLog` vanishes at both; every `H_n = 0` |
| 4 `ksEntropy_map` | `π ∘ T = S ∘ π`, `π` and `S` measurable: `ksEntropy (μ.map π) S = ksEntropyOn (mY.comap π) μ T` | a `comap`-measurable label map is `Q ∘ π`; cells pull back; `Measure.map_apply`; the case `IsEmpty X` |
| 5 `partitionEntropy_eq_ofReal_observationEntropyRate` (bridge; statement in `data/fs131/kn6/bridge-statements.lean`) | for a probability measure, `partitionEntropy μ T P = ENNReal.ofReal (observationEntropyRate μ T P)` | `Monotone.map_csInf_of_continuousAt` for `ENNReal.ofReal`; reindex `Ici 1` by `j + 1` |
| 6 `ksEntropy_eq_measureEntropy` (bridge; same file) | for a probability measure and every map, `ksEntropy μ T = measureEntropy μ T` | `iSup_congr`; `Measurable P ↔ ∀ a, MeasurableSet {y \| P y = a}` into `Fin k`; leaf 5 |
| 7 `tendsto_blockEntropy_div` | for a probability measure that `T` preserves and measurable `P`: `ofReal (H_{n+1}/(n+1)) → partitionEntropy μ T P` | the release's `tendsto_observationEntropyRate`, shifted by one, through `ENNReal.continuous_ofReal` and leaf 5 |
| 8 `exists_blockEntropy_le_mul` | the same hypotheses and `partitionEntropy μ T P = 0`: for `ε > 0` and `K`, some `n ≥ K`, `n > 0`, `H_n ≤ ε n` | leaf 7 at limit `0`; eventually below `ofReal ε` |
| 9 `ksEntropy_bind_eq_zero` | `τ` a probability, `κ` a Markov kernel, `T` measurable, a.e. `κ z` preserved by `T` with `ksEntropy (κ z) T = 0`: `ksEntropy (τ.bind κ) T = 0` | leaf 6 on both sides; the release's `measureEntropy_kernel_zero` (`κ ∘ₘ τ` is `τ.bind κ`) |
| 10 `ksEntropy_eq_iSup_ksEntropyOn` | **not this job's** (waits on a port not planned) | — |

**1.4 The statements as the kernel holds them, before any edit of mine** (the compiled library as the planner left it
for `afd9df200`; every `.olean` of `Rigidity/` is newer than its source; made before anything was recompiled).
`data/fs131/ie1/lean/StatementDump.lean` prints every constant stored in the compiled data of `Rigidity/Entropy` (35),
`Rigidity/Solenoid` (45), `Rigidity/PositiveEntropy` (3) and `Rigidity/ChainAtTA` (31):
`data/fs131/ie1/statements-before.txt` — 114 constants, 97 named and 17 internal; one axiom,
`Rigidity.positive_entropy_rigidity`. The three other modules are dumped because two of them import `Rigidity/Entropy`
and this job puts new imports under it: which instance a stored term names can depend on the imports (`LEAN.md`,
FS132-I1; FS133-IA1 met it), so "no statement changed" is read on all four. The reader,
`tools/fs131_ie1_statements.py`, compared the dump with itself (PASS, 97 compared; `statements-self.out`) and, with
`--control`, reported 6 of 6 planted faults (a character of `ksEntropy_bind_eq_zero`'s stored type; the value of
`partitionEntropy`; a character of the axiom's type; the axiom become a theorem; `ksEntropy_map` gone; a new public
constant outside the allow-list) (`statements-control.out`). The dumper prints a `private` declaration with the name
the file gives it, so the helpers are listed and not hidden among the internal names (`LEAN.md`, FS131-IU1).

## Stage 2 — SAVED: P, the port

*Everything in this stage is from `lake env lean` (the lakefile's two `autoImplicit` options by flag) and from oleans
written by `lean -o` (iteration: `LEAN.md` § Building); the build under the slot and the prints from the built tree are
Stage 4's.*

**2.1 The scan, before any file of the release was copied.** The planner's `tools/fs131_kn6_release_copy.py` (`make`
into the ignored `build/fs131-kn6/release-copies/`, then `scan` and `scan --plant` per bundle): **0 hits** in
`ShannonEntropy`, `EntropyMixtures`, `HopfMaximal`, `MaximalOccupation` (456, 996, 109, 258 lines), and the planted
`#eval` and second import reported in each — `control FIRED` four times (`data/fs131/ie1/logs/kn6-scan-*.out`). The
generator has its own scan on exactly the lines it copies (below), so the scan travels with every regeneration.

**2.2 The generator** — `tools/fs131_ie1_port.py` (this job's; FS132-I2's `tools/fs132_i2_port.py` is the pattern
and is not edited). It copies whole files (and, for `InverseEntropy.lean`, the three SELECT declarations with the
file's `namespace`, `section` and `open` lines), so it reads the declarations off the text: a declaration starts at a
keyword in column 0 and runs to the next line that starts in column 0; any other column-0 line it cannot classify
refuses the generation. What it changes, all of it, is in its docstring and in every module's header: the namespaces
(`OAI.PrimeDegreePackets`, `OAI.DukePrimeDegree` → one namespace, `HadwigerNelson.Outside.OAI015`; a collision is
refused); the imports (measured, 2.4); the `open` lines (a namespace absent under the module's imports is taken out,
2.4); a source address in every docstring; the seven patches. A patch before a declaration's top-level `:=`, inside a
`def` (with or without `:=`), or inside an instance whose value is a term is refused; an `instance` must be in exactly
one of the tables `SCOPED` / `GLOBAL_INSTANCES` (the one instance, `kernelCell_probability`, is global: its term's head
is the release's own `kernelCell`). `--check`: the three files are the generated text, the licence copy is the
release's `LICENSE` byte for byte, `CHECK OK` (`data/fs131/ie1/port-check.out`). `--self-test`
(`port-selftest.out`): **19 plants refused and 1 partner accepted** — a generated file changed, absent; a patch that
does not apply, into a statement, into a definition, into a definition with no `:=`; a declared patch withdrawn; the
clone at another commit; on a scratch clone at a commit of its own, an `#eval` and an `initialize` at column 0
(refused as unclassified lines), `unsafe` and `IO.` inside proofs (refused by the scan), an instance in neither
table, two ported declarations of one name, a selected declaration absent, an unmapped namespace; the licence copy
changed by a byte, absent; a module generated with `import Mathlib` whole. Each plant must be refused **for its own
reason** (the message is matched), so a plant refused by another check reads as silent.

**2.3 The measurement: what the port needed at this pin.**

| module | release file | lines | declarations copied | patches on proof lines | refused |
|---|---|---|---|---|---|
| `Outside/OAI015Shannon` | `PrimePackets/ShannonEntropy.lean` | 453 | 26 (whole file) | 2: `Set.ofPred_and` → `Set.setOf_and` (ll. 190, 205) | 0 |
| `Outside/OAI015Mixtures` | `PrimePackets/EntropyMixtures.lean` | 540 | 30 (whole file) | 3: `ite_eq_right` → `if_neg` (ll. 220, 264), `ite_eq_left` → `if_pos` (l. 264) | 0 |
| `Outside/OAI015Maximal` | `PrimePackets/InverseEntropy.lean` | 513 | 3 (`visitCount`, `visitCount_cast`, `measurable_visitCount`; 14 lines) | 0 | 0 |
| | `DukePrimeDegree/Dynamics/HopfMaximal.lean` | 107 | 7 (whole file) | 1: `birkhoffSum_succ_apply'` → `birkhoffSum_succ'` (l. 47) | 0 |
| | `DukePrimeDegree/Dynamics/MaximalOccupation.lean` | 120 | 6 (whole file) | 1: `Set.ofPred_mem_eq` → `Set.setOf_mem_eq` (l. 109) | 0 |
| **all** | | | **72 declarations, 947 source lines** | **7, each a one-token rename** | **0** |

The planner's trial predicted exactly these seven tokens (its Stage 5.1); no proof was repaired, no statement or
definition touched. Each module elaborates with **0 errors and 0 warnings** under its measured imports
(`data/fs131/ie1/logs/min2-OAI015*.log`), in 3–5 s each. *Wall time*, first line of the generator to three modules that
elaborate under minimal imports: about 50 minutes, of which about 20 waiting for the slot behind other jobs and 5 on a
linter run that was stopped (2.5).

**2.4 The imports and the `open` lines.** The release's files import `Mathlib` whole; a ported module here does not
(no module of `Proofs/` does, and `Rigidity/Entropy` imports these, under the declared theorem's module). Measured in
two steps: the modules generated with `import Mathlib` (`--mathlib-whole`) and compiled by `lean -o`, then
`data/fs131/ie1/lean/ImportsDump.lean` (FS132-I2's dumper, for whole modules): per module, the modules declaring the
constants its own stored constants name, reduced to those no other of the list imports
(`logs/imports-dump.log`, `imports-dump-2.log`); then the elaboration decides. `OAI015Shannon`: six Mathlib modules;
`OAI015Maximal`: six; `OAI015Mixtures`: `OAI015Shannon` and three Mathlib modules — the dump's list for it also held
three RingTheory modules (`Etale.Weakly`, `Flat.TorsionFree`, `TotallySplit`), which are left out: the module
elaborates without them and its stored terms are the release's (2.6). Which of its constants named them I could not
show: the probe I wrote for that printed nothing, **its own control included**, so it was a broken instrument and was
deleted, not read. The `open` lines: `--open-probe` writes, per module, its imports and every namespace its release
files open, each opened alone (`data/fs131/ie1/lean/OpenProbe-*.lean`); the namespaces reported `unknown` are taken
out and no other (`logs/openprobe-*.log`): for `OAI015Shannon` `IsDiscreteValuationRing`, `IsLocalRing`,
`NumberField`, `ArithmeticFunction.zeta`, `ArithmeticFunction`, `BoundingSieve`, `UniqueFactorizationMonoid`,
`FractionalIdeal`, `RealInnerProductSpace`; for the other two the same less `IsLocalRing`, `UniqueFactorizationMonoid`,
`RealInnerProductSpace`, plus `Matrix.Norms.Elementwise`; and `PrimeDegreePackets` where `MaximalOccupation.lean`
opens it inside `DukePrimeDegree` (one namespace here). The release's entropy files carry the flattened `open` header
of a number-theory development; a name of the text cannot have resolved through a namespace that is absent here and
still elaborate, and the read-back (2.6) shows the stored statements unchanged.

**2.5 Slips.** (a) My first run of the planner's scan wrote its five scratch copies into the worktree's root: I
assigned the output directory after `git check-ignore build &&`, which exits 1 on that path, so the directory was
empty and the tool wrote to `.`. Found by `git status` at once; the five untracked files (my own output, never
staged) were removed and the scan rerun into `build/`; nothing was elaborated from them. (b) A first measurement of
the imports by Mathlib's `linter.minImports` on `OAI015Shannon` under `import Mathlib` ran over five minutes with no
output and was stopped by its PID (exit 143; the process gone from `ps`); what it forfeited is the linter's reading of
the minimal list, replaced by the dump-then-elaborate route of 2.4, which cannot see a tactic's or a notation's module
but is checked by the elaboration itself.

**2.6 The read-back across the two pins** (Shannon and Mixtures; `tools/fs131_ie1_port_readback.py`, FS132-I2's
comparator imported as a module and not edited, with this job's table). The release's side: the release's two files'
text with their imports replaced by `import Mathlib`, and the dumper, in a scratch file under the ignored `build/`,
elaborated at the release's pin in the audit's working copy by `data/fs131/ie1/release-dump.sh` (`lake env lean`
under an 8 GiB slot; no compiled file written; exit 0, `DONE 56`). This pin's side: `data/fs131/ie1/readback/HereDump.lean`
over the compiled module. On the 56 declarations (`compare.out`): **`READBACK OK` — 52 IDENTICAL, 4 UP-TO-INSTANCES,
none DIFFERENT, none absent**; the four (`observationEntropy_finite_mixture_bounds`,
`observationEntropyRate_finite_mixture`, `weighted_kernelCell`, `kernel_finite_cells`) differ only inside one instance
argument, where Mathlib's `MeasureTheory.Measure.instSMul` takes its arguments in another order at the two pins (the
measurable space after the scalar type at the release's pin), and **no constant differs** (the record of differing
instance constants is empty; `up-to-instances-diff.txt` prints the first difference of each). RENAMED: `Set.ofPred` →
`setOf` only (the set-builder notation). `--self-test` (`selftest.out`): **10 plants refused**, the unplanted pair
passes. The prints are kept compressed (`ReleaseDump.out.xz`, `HereDump.out.xz`, `prints.sha256`). The maximal
inequality's module is not read back (the brief: its release-side print would need 89 files compiled; the generator's
refusal to patch a statement is enough there).

**2.7 The port's axioms** (from the oleans written by `lean -o`; Stage 4 prints them again from the built tree):
`tools/fs131_ie1_axioms.py` on `data/fs131/ie1/port-axioms.out` (`data/fs131/ie1/lean/PortAxioms.lean`, the generator's
`--axioms-block` under the two imports): **72 records, each a subset of `[propext, Classical.choice, Quot.sound]`**
(one axiom-free), none `sorryAx`, none the declared theorem's; its control reports a planted `sorryAx`, a planted
import's axiom and a removed record (3 of 3).

**2.8 The map.** `ARCHITECTURE.md`: three rows (after `Outside/OAI158AngularBoundary`), and `Rigidity/Entropy`'s row
(its imports cell: `Outside/OAI015Mixtures`; its state); `Proofs.lean`: three lines; `tools/check_architecture.py`:
exit 0, 351 rows, 0 mismatches.

## Stage 3 — SAVED: E, leaves 1 to 9 (from `lake env lean`; the build is Stage 4's)

`Rigidity/Entropy` gains one import, `Outside/OAI015Mixtures`, and a `section Bridge` (placed before the pinning
theorem, which reads it) holding the four bridge lemmas of `data/fs131/kn6/bridge-statements.lean` — the planner's
statements and docstrings, checked as text by `tools/fs131_ie1_bridge_text.py` (4 of 4 heads match; its control, one
word of one head changed, mismatches; `data/fs131/ie1/bridge-text*.out`), the namespace opened in the section being
`HadwigerNelson.Outside.OAI015` in place of `OAI.PrimeDegreePackets`. Private helpers, each a stated lemma with a
docstring: `blockEntropy_id` (for the identity `H_{n+1} = H_1`), `preimage_nameCell`, `partitionEntropy_map`,
`exists_measurable_comp_of_comap` (a label map measurable for `mY.comap π` is `Q ∘ π` with `Q` measurable — built by
induction on a list of labels, so `Mathlib.MeasureTheory.Function.FactorsThrough` and the standard-Borel machinery are
not imported).

| leaf | route taken | against the plan |
|---|---|---|
| 1 `blockEntropy_one` | the cell at length one is `P ⁻¹' {w 0}`; `Fintype.sum_equiv (Equiv.funUnique …)` | the plan's |
| 2 `ksEntropy_id` | `blockEntropy_id` by `Fintype.sum_of_injective` on the constant words (the others have empty cells); `H_1 / (n + 1) → 0`; `ge_of_tendsto'` | the plan's, with `sum_of_injective` for `sum_subset`; written without `ksEntropy_eq_zero_iff` and `partitionEntropy_le`, which stand later in the file |
| 3 `ksEntropy_dirac` | every cell measurable, so of mass `0` or `1` (`Measure.dirac_apply'`); `H_1 = 0` | the plan's (one block length suffices) |
| 4 `ksEntropy_map` | `≤` by `Q ↦ Q ∘ π`; `≥` by `exists_measurable_comp_of_comap`, the case `IsEmpty X` by `μ = 0` | the plan's |
| 5 `partitionEntropy_eq_ofReal_observationEntropyRate` | `Monotone.map_csInf_of_continuousAt` for `ENNReal.ofReal`, `sInf_image`, the reindexing `N = n + 1` | the plan's |
| 6 `ksEntropy_eq_measureEntropy` | `iSup_congr` twice, `iSup_congr_Prop` with `measurable_to_countable'` | the plan's |
| 7 `tendsto_blockEntropy_div` | the release's `tendsto_observationEntropyRate` shifted by one, `ENNReal.tendsto_ofReal`, leaf 5 | the plan's |
| 8 `exists_blockEntropy_le_mul` | leaf 7 at `0`; `gt_mem_nhds` and `eventually_ge_atTop`; `div_lt_iff₀` | the plan's |
| 9 `ksEntropy_bind_eq_zero` | leaf 6 on both sides and the release's `measureEntropy_kernel_zero`; `κ ∘ₘ τ` is `τ.bind κ` at the pin as stated (the term is accepted with no unfolding) | the plan's |

The file elaborates: exit 0, **one warning, the tenth leaf's `sorry`** (`ksEntropy_eq_iSup_ksEntropyOn`, not this
job's) (`data/fs131/ie1/logs/entropy-3.log`; the first full pass had two other warnings, a deprecated
`Set.left_mem_Ici` and an unused simp argument, both fixed). **Re-pricing** (the brief's item 3): leaves 1–3 took one
elaboration each and leaf 4 one more; leaves 5–9 went through on the first elaboration once the port was in. The
plan's routes were exact; nothing is left of lane E but the tenth leaf.

## Stage 4 — SAVED: the build under the slot, and every receipt from the built tree

**4.1 A stored definition moved, and why it no longer does.** The first build (`data/fs131/ie1/logs/build-1.log`: OK,
249 of 249 batches, 7 modules rebuilt, 7m12s) and the statement dump after it: **two stored terms of `Rigidity/Entropy`
had moved** — the value of the definition `ksEntropyOn` and the stored type of the tenth leaf
(`statements-compare-1.out`, `statements-after-1.txt`; nothing moved in the other three modules, the declared theorem
included). The cause, read off the two terms: the supremum `⨆` in `ℝ≥0∞` was stored through
`ConditionallyCompletePartialOrder…` and is now stored through `CompletePartialOrder.toSupSet`, the instance of
`Mathlib.Order.CompletePartialOrder` — a module the imports dump had listed for `OAI015Shannon` and `OAI015Maximal`
because their terms, compiled under `import Mathlib`, name that instance. No other import of the new closure brings it
(`tools/fs131_ie1_closure.py`, Mathlib's import graph read from the source headers; its controls: the module itself and
`Mathlib` read `holds`; `data/fs131/ie1/logs/closure.out`). Taken out of both lists (the generator's MATHLIB table says
why): the ported modules elaborate without it, 0 errors, 0 warnings (`logs/min3-*.log`); the read-back now reads 51
IDENTICAL and 5 UP-TO-INSTANCES — `measureEntropy` joins the four of 2.6, its supremum stored through the same
`ConditionallyCompletePartialOrder` path as `ksEntropy`'s, and its ten differing instance constants are recorded
(`data/fs131/ie1/readback/instance-constants.txt`, every one Mathlib's); `READBACK OK`; the self-test's 10 plants
refused again. The generator's `--check` and `--self-test` (19 plants, 1 partner) pass on the regenerated text. *This is
the statement check doing its job*: a check that compared text would have passed, since no line of `Rigidity/Entropy`'s
definitions changed.

**4.2 The build.** `./scripts/build.sh` under a 10 GiB slot, `BATCH=8` (`logs/build-2.log`; full output
`build/gate/build/20261014T034451Z-1444368.log`): **OK — 249 of 249 batches, 7 modules rebuilt** (`Outside.OAI015Shannon`,
`OAI015Maximal`, `OAI015Mixtures`, `Rigidity.Entropy`, `Rigidity.PositiveEntropy`, `Rigidity.ChainAtTA`, `Proofs`),
7m58s, exit 0. Warnings from this job's files: **one**, `Entropy.lean:384:8: declaration uses 'sorry'` — the tenth leaf;
none from the three ported modules (the other warnings are the six leaves of `ChainAtTA` and one of `PositiveEntropy`,
another lane's).

**4.3 No statement and no definition changed, from the kernel's side.** `StatementDump.lean` again on the built tree
(`statements-after.txt`) against Stage 1's dump: **PASS — 97 named constants compared (types; values of definitions),
none moved**; the modules' one axiom the same in both; new public constants exactly the allow-list, the four bridge
lemmas (`data/fs131/ie1/allowed-new.txt`); new private constants the four helpers (`statements-compare.out`). The
control on the same pair: **6 of 6 planted faults reported** (`statements-compare-control.out`). The first run (4.1)
is the unplanted fault the check caught.

**4.4 Axioms, from the built tree.** `Rigidity/Entropy` (`data/fs131/ie1/lean/EntropyAxioms.lean`, every public
declaration, 32): **31 records clean** — a subset of the standard three, three of them axiom-free — and the tenth leaf
apart, `[propext, sorryAx, Classical.choice, Quot.sound]` (`axioms-entropy-verdict.out`, `axioms-tenth-leaf.out`); no
record holds the declared theorem. **The planted records, watched showing** (`EntropyAxiomsPlanted.lean`: the same 31
and two more printed by the kernel): the declared theorem `Rigidity.positive_entropy_rigidity` and the `sorry` leaf
`Rigidity.haar_or_zero_entropy` — the reader fails naming exactly those two (`axioms-entropy-planted-verdict.out`). The
port: **72 records clean** again (`axioms-port-verdict.out`).

**4.5 `lake lint`** (`lake lint --no-build -- --no-build --trace` under a slot; `logs/lint.log`): **exit 1** — 13
linters pass and `unusedArguments` fails on three ported statements of `EntropyMixtures.lean`, each taking an instance
argument its proof does not use: `observationEntropy_finite_mixture_bounds` (`[IsProbabilityMeasure μ]`, source l. 84),
`kernelCell_preserving` (`[IsProbabilityMeasure τ]`, l. 174), `kernelCell_real` (`[IsProbabilityMeasure τ]`, l. 215).
They are the release's statements; the generator refuses to touch a statement; the library has no `nolint` and no
`nolints.json`. **Sent to the coordinator at once** (the brief's channel: the port needs a change on something other
than a proof line), with three options — an `@[nolint unusedArguments]` attribute placed by the generator (no stored type
moves), a `nolints.json` entry, or the landing's ruling — and my preference, the first. Nothing of `Rigidity/Entropy` is
reported by any linter.

**4.6 `sorry`.** None in the three ported modules (their headers say "no `sorry`" in prose, the only matches); one in
`Rigidity/Entropy`, the tenth leaf's.

**4.7 Nothing running or queued.** Every process of this job ended with its command; the slot ledger holds no `ie1`
entry after the last run.

## Stage 5 — SAVED: Amendment 1 carried out (the three unused instance arguments), and every receipt from the third build

**5.1 The ruling, carried out.** The generator's new table `NOLINT` places `@[nolint unusedArguments]` on exactly
`observationEntropy_finite_mixture_bounds`, `kernelCell_preserving` and `kernelCell_real` (`Outside/OAI015Mixtures`),
each with a `--` comment beside it: *the release's statement takes this instance and its proof does not read it; kept
so that the statement stays the release's*. The module header's list of changes names the three (item 7). The script
refuses a `NOLINT` entry whose declaration is not ported, an entry for a linter it does not silence, and a `nolint`
already in the release's text; the self-test gains three plants (an entry for an unported declaration, an entry for
another linter, an entry withdrawn — the files then differ): **22 plants refused and 1 partner accepted**
(`port-selftest.out`); `--check` OK (`port-check.out`). **These are the first `nolint` attributes in the library.**
The headers of `OAI015Shannon` and `OAI015Maximal` now also say that `Mathlib.Order.CompletePartialOrder` is left out of
their imports and why (4.1), and each header says whether the module is read back across the pins.

**5.2 The attributes move no stored type.** `HereDump.lean` printed again on the third build: the print of all 56
read-back declarations — every stored type and value, full and with instance and proof arguments erased — is **byte
for byte the print made before the attributes** (`cmp`); the three by name: unchanged; control: an instance binder of
`kernelCell_real` made implicit in a copy of the print differs, as it must (`readback/nolint-unchanged.out`). The
read-back against the release: `READBACK OK`, as in 4.1 (`readback/compare.out`).

**5.3 The lint, green with its control red.** `lake lint --no-build -- --no-build --trace` on the third build
(`logs/lint-2.log`): **exit 0, `Linting passed for Proofs`, 14 linters `(2/2) Passed!`**. The control
(`logs/lint-control-{Green,Red}.log`): the generated module copied into the ignored `build/fs131-ie1/lint/` with
`#lint only unusedArguments` appended elaborates with *0 errors in 30 declarations*; the same copy with the attribute
taken off `kernelCell_real` fails, the linter naming `kernelCell_real`, argument 7, `[IsProbabilityMeasure τ]`.

**5.4 The third build and the receipts again.** `./scripts/build.sh` under a 10 GiB slot, `BATCH=8`
(`logs/build-3.log`): **OK — 249 of 249 batches, 7 modules rebuilt, 7m17s**; the only warning in this job's files the
tenth leaf's `sorry` (`Entropy.lean:384:8`). Statement check against Stage 1's dump: **PASS, 97 constants unchanged**,
new public constants the four bridge lemmas, control 6 of 6 (`statements-compare.out`, `statements-compare-control.out`).
Axioms: `Rigidity/Entropy` **31 of 31 clean**, the tenth leaf `[propext, sorryAx, Classical.choice, Quot.sound]`, the
planted pair (the declared theorem, a `sorry` leaf of `PositiveEntropy`) reported by name; the port **72 of 72 clean**
(`axioms-*-verdict.out`). `tools/check_architecture.py`: exit 0. The bridge's text check: 4 of 4. Nothing of this job
is running or queued (no `ie1` entry in the slot ledger).

## Drafts for the landing (files this job does not write; each names its slot)

**D1 — the audit's block** (`scripts/Axioms.lean`, under CLEAN, immediately above `#eval IO.println "=== PURCHASED ==="`):
the text of `data/fs131/ie1/draft-axioms-block.lean` — 103 records: the port's 72 (generated by
`tools/fs131_ie1_port.py --axioms-block`, so `--check` can compare it once filed) and `Rigidity/Entropy`'s 31 (every
public declaration but the tenth leaf, which joins the block when it is proved). Each is CLEAN on the third build (5.4).
The clean count then rises by 103; no purchase, no import.

**D2 — the model for each hypothesis** (for the landing's note under `LEAN.md` § The gate, "every theorem whose hypothesis
is a structure ships a named inhabitant"; none of these binders is one the vacuity scan tracks, so the scan is expected
to be silent on them, and this is the hand reading). One object satisfies every hypothesis of the leaves at once: `X`
any measurable space with a point `x`, `μ = Measure.dirac x` (a probability: Mathlib's instance), `T = id`
(`measurable_id`; `MeasureTheory.MeasurePreserving.id`), `P` any constant label map into `Fin k`, `k ≥ 1`
(`measurable_const`).

| declaration | its hypotheses | the model, and the theorem that makes it one |
|---|---|---|
| `blockEntropy_one`, `ksEntropy_id`, `nameCell_eq_orbitName_fibre`, `blockEntropy_eq_observationEntropy` | none | — |
| `ksEntropy_dirac` | `Measurable T` | `T = id` |
| `ksEntropy_map` | `Measurable π`, `Measurable S`, `π ∘ T = S ∘ π` | `Y = X`, `π = S = T = id`, the semiconjugacy by `rfl`; or any measurable `π` with `S = T = id` |
| `partitionEntropy_eq_ofReal_observationEntropyRate`, `ksEntropy_eq_measureEntropy` | `IsProbabilityMeasure μ` | `μ = dirac x` |
| `tendsto_blockEntropy_div` | the probability, `MeasurePreserving T μ μ`, `Measurable P` | `dirac x`, `id`, a constant `P` |
| `exists_blockEntropy_le_mul` | those, `partitionEntropy μ T P = 0`, `0 < ε` | the same, the entropy zero by `ksEntropy_id` with `partitionEntropy_le_ksEntropy`; `ε = 1` |
| `ksEntropy_bind_eq_zero` | `τ` a probability, `κ` a Markov kernel, `Measurable T`, a.e. `MeasurePreserving T (κ z) (κ z)`, a.e. `ksEntropy (κ z) T = 0` | `τ = dirac z₀`, `κ = Kernel.const Z (dirac x)` (Markov: Mathlib's instance), `T = id`, the last two by `MeasurePreserving.id` and `ksEntropy_id` |

Every clause is exercised by these (none is vacuous at them: the measure is a probability, the map preserves it, the
partition is measurable, the entropy is zero because it is, not because a hypothesis is empty). What they do not
exercise is positive entropy: the two-shift at `log 2` (draft M1's statement 6) is still not typed, and it is the one
model that would show the definition is not too small. No declaration in the library exhibits these models; the
landing either accepts this note or asks for a named `example` per row. The ported statements are the release's: their
models are the release's to give, and none is added here.

**D3 — what the port needed, per file, as a measurement** (for `LEAN.md` § Assumptions on ports and for the chain's
claim list M0): Stage 2.3's table, and two items beyond the seven proof patches — *three `@[nolint unusedArguments]`
attributes* in `EntropyMixtures.lean`'s port (5.1), and *one Mathlib import left out on purpose*,
`Mathlib.Order.CompletePartialOrder`, at the cost of one ported definition (`measureEntropy`) differing from the
release's in one instance path (4.1). Wall time for the port, generator to three modules that elaborate: about 50
minutes, of which about 20 waiting for the slot.

**D4 — `LEAN.md` § Assumptions**, to follow the port paragraph (the ruling's sentence, then the measured one):
- "A ported statement keeps the source's unused arguments; where this library's linter reports one, it is silenced by
  name on that declaration — `@[nolint unusedArguments]` with a comment beside it, placed by the generator and listed in
  the module's header — never by a global list (`Outside/OAI015Mixtures`, three declarations; FS131-IE1, Amendment 1)."
- "A ported module's imports reach every module downstream of it, and an import can move what a downstream definition
  stores: `Mathlib.Order.CompletePartialOrder` makes a supremum in `ℝ≥0∞` resolve through
  `CompletePartialOrder.toSupSet`, and importing it under `Rigidity/Entropy` moved the stored value of `ksEntropyOn`
  with no character of its text changed. Choose a port's imports by the stored statements of the modules that will
  import it — dump them before and after — and leave out an import that moves one; the port's read-back then records
  the instance path (FS131-IE1)."

**D5 — `LEAN.md` § Searching — Lean**, two lines:
- "Mathlib's `linter.minImports` (`-Dweak.linter.minImports=true`) on a 450-line file under `import Mathlib` ran five
  minutes with no output; for a port, read the modules declaring the constants its compiled terms name and reduce them
  (`data/fs131/ie1/lean/ImportsDump.lean`), then let the elaboration decide (FS131-IE1)."
- "A text reading of Mathlib's import graph reads the header only: `module  -- shake: …` carries a comment, licence block
  comments come first, and a docstring can hold an example `import Mathlib` (`tools/fs131_ie1_closure.py`) (FS131-IE1)."

**D6 — `CLAUDE.md` § Trust ledger**, after the sentence on FS-132's ported lemmas: "Three modules of `[OAIMath2026]`
family 015 — the entropy of a map, the mixture lemma and the maximal inequality (`Outside/OAI015Shannon`,
`OAI015Mixtures`, `OAI015Maximal`, 72 declarations) — are ported, not imported: kernel-checked at this pin on the
standard three, resting on no declared outside theorem, with the release's licence text beside them (FS131-IE1)." And
the audit's counts move by D1's 103 at the landing.

**D7 — `BIBLIOGRAPHY.md`, `[OAIMath2026]`**, reading status: "family 015's `PrimePackets/ShannonEntropy.lean` and
`EntropyMixtures.lean`, `DukePrimeDegree/Dynamics/HopfMaximal.lean` and `MaximalOccupation.lean` whole, and three
declarations of `PrimePackets/InverseEntropy.lean`, ported by FS131-IE1 (2026-10-14): every proof kernel-checked at this
library's pin; the first two read back against the release's stored terms (51 identical, 5 up to instance arguments);
statements read in full, proofs read only where a patch or a lint named a line."

**D8 — the chain's claim list** (`data/fs131/claims-NF2.md` § Dated lines, after the last line there): "2026-10-14 —
**NF2-LEAF-13 is answered (FS131-IE1)**: `Rigidity.ksEntropy` is pinned to the textbook's number for every invariant
probability measure (`tendsto_blockEntropy_div`, [kernel]) and is the ported `measureEntropy` of `[OAIMath2026]` family
015 for every probability measure and map (`ksEntropy_eq_measureEntropy`, [kernel]); the mixture lemma
(`ksEntropy_bind_eq_zero`) and the maximal inequality (`Outside.OAI015.excessiveOccupation_measure_bound`) are kernel
theorems on the standard three. The conditional form along increasing σ-algebras (`ksEntropy_eq_iSup_ksEntropyOn`, T2)
is the one leaf of `Rigidity/Entropy` left, waiting on a port not planned."
