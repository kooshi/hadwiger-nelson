# FS131-IE1 — the entropy base of the five-colour chain: the port of three files of `[OAIMath2026]` family 015, and the leaves of `Rigidity/Entropy` over them

*The implementer's record (de Bruijn, the implementer). Brief: `data/fs131/briefs/FS131-IE1-entropy-base.md` (in the
coordinator's tree). Plan: `plans/FS131-KN6-chain-first-layer.md` § Stage 5. Worktree `fs131-wch`, branch `fs131-we1`,
cut from `afd9df200`. Working files: `data/fs131/ie1/`. Not pushed (the brief: the server is unreachable).*

## Theorems this phase proved

*(filled as the stages fall; each line: the declaration, its axioms as printed, where it is)*

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
