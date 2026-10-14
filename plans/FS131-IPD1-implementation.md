# FS131-IPD1 — the port of `[OAIMath2026]`'s transfer proof, last lane: the generator's revision, lane D, the switch, the registration

*de Bruijn, the implementer; job FS131-IPD1 (brief: `data/fs131/briefs/FS131-IPD1-port-lane-d.md`, on `main`).
Branch `fs131-wpl`, cut from `fs131-wpb` at `f4085d2ac` in the worktree `.claude/worktrees/fs132-wi1`. Working files:
`data/fs131/ipd1/`. The plan is `plans/FS131-KO1-port-plan.md`; the earlier implementers' records are
`plans/FS131-IPA1-implementation.md` and `plans/FS131-IPB1-implementation.md` (all this branch). The outside release is
`[OAIMath2026]` family 158 at commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a` of `/home/kooshi/source/math` (read,
never written or run).*

## Theorems this phase proved

None of this project's mathematics. The phase makes modules of the release's own lemmas, each elaborated at this pin
with every proof checked by this kernel, registers the port's thirty-one modules, and turns the declared outside
theorem `Outside.OAI158.proper_to_borel_weak` into the release's theorem under its name (the switch, stage 5). The
kernel receipts are in the stages below.

## Stage 1 — SAVED: the readback

**1.1 The brief's quotations** — `tools/fs131_ipd1_readback.py` (FS131-IPB1's reader with the brief's path changed,
nothing else; pointed at the main tree, where the brief and its sources are committed): **9 matched, 0 mismatched**,
exit 0 (`data/fs131/ipd1/readback-brief.out`) — W4 against `data/fs131/REQUEST-2026-10-13.md`; items 759, 758, 763,
764, 767, 768, 772 and 786 against `plans/FS131-close-inventory.md`. `--fault` (the last character of each quotation
changed): 0 matched, 9 mismatched, exit 1 (`readback-brief-fault.out`). No finding about the brief.

**1.2 The branch.** `fs131-wpl` cut from `fs131-wpb` at `f4085d2ac` (the tree's head at launch, clean).

**1.3 The generator** (`tools/fs131_ko1_port.py` at `7deb20414`, unchanged), on the 25 modules generated so far (lanes
A, B and C; the list is `data/fs131/ipd1/modules25.txt`):
- `--parse-all`: `PARSE OK: every file of the plan reads as scopes, declarations and scaffolding` (exit 0;
  `data/fs131/ipd1/gen-parse-all.out`);
- `--self-test`: `SELF-TEST OK: 21 plants refused and 5 partners accepted` (exit 0; `gen-selftest.out`);
- `--check --modules` the 25: `CHECK OK` (exit 0; `gen-check-25.out`: 25 modules and the licence copy OK).

**1.4 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building and § Make the
gate fail; the plan whole (stages 1–4 and the drafts); both earlier implementers' records whole; the generator whole;
`scripts/Axioms.lean`'s instruments and banners, and `scripts/axioms.sh`'s record parser (for the revision's first
change).

**1.5 A probe for the revision's first change** (`data/fs131/ipd1/probes/OpenPrivate{1,2}.lean` with their `.out`, under `import Proofs` as
`scripts/Axioms.lean` is): Batteries' `open private … from <module>` is in the library's import closure; inside a
`section` it makes a private declaration of another module nameable by its user name, and `#print axioms` then prints
the record as `'_private.<module>.0.<name>' depends on axioms: [...]`, the form `scripts/axioms.sh` reads; after `end`
the name is unknown again (exit 1, `Unknown constant`, the probe's last line). The port holds one private declaration
(`BorelTransfer.lean:380`, `pickSupport`); the 25 modules so far hold none, and 63 instances.

## Stage 2 — SAVED: the generator's revision (item 786 ruling 1), three changes, each its own commit

*Order of the commits: change 1, then change 3, then change 2 (the header), so that the one change that rewrites every
module's docstring is made last and its kernel-side check covers the generator as finally revised. Working files:
`data/fs131/ipd1/rev/`. The scratch variants of the generator used as controls are kept there (`port_c*_*.py`).*

**2.1 Change 1 — `--axioms-block` covers instances and private declarations** (commit `4ae70f53e`). The block is now
`axioms_block(sel, full)`: one `#print axioms` line per copied declaration in source order — theorems, definitions,
structures **and instances**, each by the name the kernel gives it here (the name map, then the read-back's ANON rule:
an anonymous instance's `_oAI` suffix is `_proofs` here) —, **the instances a `deriving` clause declares** (four in the
31 files: `Spectral.instCommGroupDiscreteE`, `instCommGroupDiscreteF`, `InvariantMean.instAddCommGroupPeriodGroup`,
`Spectral.instAddCommGroupRot`; they have no text of their own and no other record reads them) after their owner's
record, and **every private declaration** in one `section` per module that opens it by `open private <name> from
<module>` (stage 1.5's probe: the record then prints the private name in full). A generated auxiliary has no record.
Each module's block opens with a count line (`-- Outside/<mod>: N records (i instances, d derived instances, p
private)`).
- `--check` on the 25 modules: `CHECK OK`, every file byte-identical to its committed text (`c1-check-after.out`;
  `data/fs131/ipd1/rev-files-before.sha256`); `--parse-all` passes.
- The new self-test partner (on `OAI158Basic`: 16 instances, 2 derived; a private declaration planted by giving one
  copied theorem the release's private form of its name in its `DECL` and `CONE` rows): exactly one record per copied
  declaration and per derived instance, the private one alone inside `section` / `open private … from
  Proofs.HadwigerNelson.Outside.OAI158Basic` / its record / `end` — `COMPLETE`. Self-test: **21 plants refused and 6
  partners accepted** (`c1-selftest.out`).
- Controls, each a scratch copy of the generator with part of the change withdrawn — the whole change, the derived
  instances, the private records, the `section` line: the partner reads **FAILED** in each, the self-test exits 1
  (`c1-control-{withdrawn,noderived,noprivate,nosection}.out`).
- Against the compiled modules (the farm's oleans, dumped whole: 2.4): the block's 1,103 records on the 25 modules
  name 1,103 constants of the dump, none missing; the dump's other named public constants are structure projections,
  constructors and recursors, `congr_simp`/`eq_def` lemmas made on demand, `ext_iff` and `@[simps]` companions, and the
  three derived instances of these modules — which is what the derived-instance clause was added for
  (`axioms-block-25.txt`, 1,106 records with it).

**2.2 Change 3 — a rename matches whole names only** (commit `a558cef8b`). `rename_pattern`: the token may be neither
followed by any of Lean's identifier characters (`isIdRest`, `Init/Meta/Defs.lean` at v4.32.0: ASCII letters and digits,
`_`, `'`, `!`, `?`, the letter-like blocks, the subscripts) nor preceded by one (`!` and `?` excepted: they begin no
identifier); a `.` stays allowed on both sides (a longer qualified name of the same constant before, dot notation
after), as before. The old pattern let `_`, `!`, `?`, letter-like characters and subscripts follow, so a token matched
the start of a longer name (`lipschitzWith` in `lipschitzWith_thickenedIndicator`, FS131-IPB1's note).
- `--check` on the 25: `CHECK OK`, byte-identical — **no table relied on a prefix match** (`c3-check-after.out`);
  `--parse-all` passes.
- The new partner: on the last line of a copied theorem of a source copy, a comment holding the planted token alone,
  qualified and in dot notation (each renamed) and as the start of five longer names (`_long`, `₀`, `'`, `?`, `!`; each
  left alone) — `WHOLE`. Self-test **21 plants refused and 7 partners accepted** (`c3-selftest.out`). Control: the old
  pattern in a scratch copy — the partner **FAILED**, exit 1 (`c3-control-withdrawn.out`).

**2.3 Change 2 — the header worded for a whole-file selection** (commit `68a2a3e24`). The generated title read
"ported: the part the transfer's proof uses" and item 1 "*A selection*: N of its N declarations … — those the transfer
`proper_to_borel_weak` uses", over every declaration of the file. Now: title "ported whole: a file of the transfer's
proof"; item 1 "*The whole file*: all N of its declarations (n of its m lines; its other lines declare nothing). The
cone of the transfer …, as the release's own compiled constants give it (`ConeDump.out`), is the check that the file
holds what the cone names here; the rest is copied too, because a cone computed from compiled constants misses what a
proof uses only definitionally (plan § 3.2)." A selection that is not the whole file is now refused (the wording would
be false). *The title line is changed with item 1*: it made the same claim, and the brief names item 1 — held for the
coordinator below. The cone's count is deliberately not printed: with it, the existing partner "the CONE lines of a
theorem removed change nothing" failed on my first version (the header's count moved), and that partner is the
whole-file method's own invariant, so the count went and the partner stands.
- The 25 modules regenerated; **only the title and item 1 differ** in each: `tools/fs131_ipd1_header_diff.py HEAD
  <the 25>` — `HEADER-DIFF OK: 25 of 25` (`c2-header-diff.out`: outside the docstring every line identical; inside it,
  with the title and item 1's paragraph masked, identical); its control (`--control HEAD OAI158Centers`): a code line
  changed — REPORTED, item 2 changed — REPORTED, item 1 changed (the partner) — PASSED (`c2-header-diff-control.out`).
- `--check` `CHECK OK`, `--parse-all` passes, self-test **21 plants refused and 8 partners accepted**
  (`c2-selftest.out`); the new partner (the header of Basic says all 110 declarations, none of the old wording) —
  `WHOLE FILE`. Control: the old wording in a scratch copy writing to its own output folder, whose 25 outputs are
  byte-identical to the committed files before the change (`c2-control-old-outputs.txt`): the partner **FAILED**, exit 1
  (`c2-control-withdrawn.out`).
- **No stored term moved, from the kernel's side.** Every constant of the 25 modules' own compiled data dumped from the
  farm before any change (`data/fs131/ipd1/lean/ModuleDumpHead.lean` by `data/fs131/ipd1/dump-modules.sh`; FS124-L2's
  line format: kind, name, stored type raw, universe parameters, the value's hash): **1,777 constants**
  (`rev/dump-before.out.xz`); all 25 re-elaborated in dependency order from the regenerated text, **0 errors and 0
  warnings each** (`data/fs131/ipd1/farm/*-rev.out`); dumped again: **byte-identical**, sha256 `7ec0eaee…` both
  (`dump-before.out.sha256`, `dump-after.out.sha256`), and `tools/fs131_ipd1_dumpdiff.py`: `1777 IDENTICAL, 0
  reported` (`c2-dumpdiff.out`). Controls of the comparator: a changed type, a changed value hash, a removed constant
  and a module count off by one, each REPORTED by name (`dumpdiff-control.out`); and of the dump itself, a real stored
  change — `exists_terminal_factor` given a binder `(_hplant : True)` in a copy of `OAI158Stationary`, elaborated into a
  scratch farm of symlinks with that module over it (`plant-OAI158Stationary.lean`, `plant-elab.out`, 0 errors) and
  dumped (`DumpPlant.lean`, `dump-plant-stationary.out`): exactly that constant reported DIFFERENT, 35 IDENTICAL
  (`dumpdiff-plant-stationary.out`).

**2.4 Not changed** (the brief's fence: the revision's three changes only). The generator's own docstring item 4 still
describes a cone selection ("declarations outside the cone are left out") — documentation of the tool, not generated
text; the header's item "Patches …, each to a proof and none to a statement or a definition" is still wrong in letter for
FourierTests' RULED patch (item 763's note); `--self-test` still reads the generated modules from `Proofs/` (item 759
ruling 4); the textual statement guard (item 763) stays covered by the read-back. Tool notes only.

*A slip of bookkeeping:* change 2's commit also carries the farm's logs of lane D's first module (`farm/
OAI158Representations-try{1,2}.*`), written into the same folder while the 25 re-elaborated; nothing of lane D's tables
or modules is in it.

## Stage 3 — SAVED: lane D, its first four modules, and a ruling asked for SpectralMeasure

*Everything here is from `lean -o` in the scratch farm (`data/fs131/ko1/farm1.sh`, unchanged, driven by
`data/fs131/ipd1/farm-run.sh`, FS131-IPB1's with its log folder changed), not from `./scripts/build.sh`. Table entries
written with FS131-IPB1's `data/fs131/ipb1/addentry.py`, run unchanged (its reason keys `ipm_proof`, `eventuallyConst`
reused, the rest written out).*

**3.1 The tables' instances** (every lane D instance is on a type built from the release's own definitions, so
global, as lanes A–C's): Representations 12, 13 (`Rot`), 18, 24, 27, 30 (the actions of `Rot`), 63 (`Space k`), 117
(`measure k ω`), 209 (`ContinuousVectors.space U`), 438, 439 (`measure Φ v`); SpectralMeasure 106, 119, 122
(`CommutingSpectral.algebra U`); Ergodicity 327 (`Countable Rot`, as Stationary 112's `Countable K`); BorelTransfer 44
(`space` of `representation k ω`); Energy 91 is a `local instance`. `drop_imports` of
`Mathlib.Order.CompletePartialOrder` in Representations, the one lane D file whose dump lists it.

**3.2 Per module.**

| module | table (each entry with its reason) | elaboration |
|---|---|---|
| `OAI158Representations` | rename `Set.ofPred_forall` → `Set.setOf_forall`; patch 323 `Complex.isometry_ofReal.lipschitzWith.comp` → `….lipschitz.comp` (as Functions 551) | try1 3 errors; **try2 0, 0** |
| `OAI158Energy` | patches 286 (the `have`'s type `EventuallyEmptyOrUniv (q ⁻¹' s) (ae μ)` written `EventuallyConst (q ⁻¹' s) (ae μ)`, as this pin's `ErgodicVAdd` concludes) and 293 `eventuallyEmptyOrUniv_iff` → `Filter.eventuallyConst_set` (as Amenability 385, Kernels 510) | try1 3 errors; **try2 0, 0** |
| `OAI158RadialEnergy` | patches 86, 389, 454: `haveI := Measure.isProbabilityMeasure_map (hq.aemeasurable (μ := μ));` before the proof's first tactic that needs `IsProbabilityMeasure (μ.map q)` (the third for the RULED instance `differenceLaw_probability`); `hq` is the statement's | try1 8 errors; try2 not generated (my line 87 for 86: the generator refused, "patch 0 does not apply"); **try3 0, 0** |
| `OAI158SpectralMeasure` | **two definition patches proposed, not written: a ruling is asked** (3.3); proof patches in `adjoin_comm` | try1 24 errors, 8 warnings |
| `OAI158Ergodicity` | patch 266 `eventuallyEmptyOrUniv_iff` → `Filter.eventuallyConst_set`; rename `Measurable.of_eval` → `measurable_pi_iff.mpr` (Kernels' reason) | **0, 0 against the experimental SpectralMeasure** (3.3; `data/fs131/ipd1/expt/erg2.out`); in the farm after the ruling |

**3.3 SpectralMeasure — sent to the coordinator by message (2026-10-14).** Two sites lie in definitions, and neither
fits an earlier class:
- `CommutingSpectral.algebra_commRing` (an instance with data). At the release `let := adjoin_comm U; inferInstance`
  finds `IsMulCommutative.instCommRing` through Mathlib's `StarSubalgebra.isMulCommutative_topologicalClosure`, which
  v4.32.0 does not have (the release's print with `pp.explicit`: `data/fs131/ipd1/probes/ReleaseCommRing2.out`). The
  proposed patch supplies the one `Prop` instance at the same place: `inferInstance` → `@inferInstance _
  (@IsMulCommutative.instCommRing _ _ ⟨⟨(StarSubalgebra.commRingTopologicalClosure _ (fun x y => mul_comm x
  y)).mul_comm⟩⟩)`. That keeps the release's stored shape and data, and only the proof differs.
- `BoundedMeasurable.mulLp` (a def). `MemLp.fun_mul` (v4.34.1) is `MemLp.mul'` here, with its arguments swapped and
  the same conclusion. It stands only in the proof argument of `MemLp.toLp`, which the release stores as
  `mulLp._proof_1` (`ReleaseCommRing.out`). The value is expected IDENTICAL, with `_proof_1` differing.
- `algebra_commCStar` needs no change of text; its value goes through an instance absent here, so a pin difference is
  expected (item 763 (3)'s class).
- In the proof of `adjoin_comm`: `StarAlgebra.isMulCommutative_adjoin` has lost its `IsStarNormal` hypothesis and takes
  `∀ x ∈ s, ∀ y ∈ s, …` for `Set.Pairwise` here, so its `apply` becomes a `refine` that keeps the release's three
  bullets, and two `rintro` patterns drop their last `_`.

The experimental copy elaborates **0 errors, 0 warnings** with exactly these changes
(`data/fs131/ipd1/expt/SpectralMeasure-candidate.diff`, against the generated text; `sm4.out`, `sm5.out`). It was
compiled into a scratch farm of symlinks (`build/ipd1/exptfarm`) where Ergodicity was then elaborated. None of the
sites is a target, a declaration the density branch shares (`shared_names()`), or named by a statement of ours.
`residual_fourier`'s statement names none of them.

## Stage 4 — SAVED: lane D's modules, the switch (steps 0–5), the registration, the build, and the join's step 0

**4.1 SpectralMeasure under the coordinator's rulings (Amendment 1 of this brief, by message)** — written into its table:
`algebra_commRing` as an ADAPTATION in a definition's value (`SpectralMeasure.lean:121`, the one token `inferInstance`,
item 758's class); `mulLp` as a PROOF patch (`:64`) — written under the table's `adaptations` key, since the generator
refuses every `patches` entry inside a definition; its reason says it is a proof patch by ruling, and the read-back must
show the definition IDENTICAL with only `mulLp._proof_1` differing; `algebra_commCStar` nothing patched (a pin
difference, item 763 (3)); the three proof patches of `adjoin_comm` (109, 112, 115). Elaboration in the farm:
**SpectralMeasure try2 0 errors, 0 warnings**; **Ergodicity try1 0, 0** (the table of stage 3).

**4.2 BorelTransfer** — it imports `Outside/OAI158Palette`, hence `Outside/OAI158`, which declared the axiom of the same
name, so it was elaborated after the switch's step 1, in a second scratch farm, `build/ipd1/farm2`: a symbolic copy of
the tree's compiled library (`cp -as`, every file a link into `.lake/build`) with the ported modules' oleans linked in and
each module elaborated there written over its link — the link removed first (`data/fs131/ipd1/farm2-run.sh`), and the
two upstream oleans of `.lake/build` checked unchanged by hash after (`OK`). Table: renames `isAlgebraic_ratCast` →
`isAlgebraic_rat` (Basic's reason), `dite_eq_left` → `dif_pos` (Approximation's), `measurableSet_setOfPred` →
`measurableSet_setOf`; patches 284 — `summable_norm_of_tsum_eLpNorm_ne_top` takes `(hf : ∀ n, AEStronglyMeasurable (f n)
μ)` at v4.32.0 (item 764's `eLpNorm` class, **in a proof**; each `f n` is in `Lp`, so `Lp.aestronglyMeasurable (g n)`;
no lane D statement names `eLpNorm`) — and 186 (an unused `simp` argument the linter reports here). try1 6 errors;
**try2 0 errors, 0 warnings** (`data/fs131/ipd1/farm2/OAI158BorelTransfer-try2.out`).

**4.3 The five receipts, lane D.**
1. `--check` on all 31 modules: **`CHECK OK`** (`data/fs131/ipd1/gen-check-31.out`, 31 modules and the licence copy);
   `--parse-all` passes; `--self-test` **21 plants refused and 8 partners accepted**.
2. Every module **0 errors, 0 warnings** (farm logs above; and the build, 4.6: 0 modules with warnings).
3. Axioms (`data/fs131/ipd1/axioms/`, FS131-IPA1's footer generator run unchanged, every constant the six modules and
   `OAI158Collapse` declare): **`SUMMARY constants=562 clean=562 other=0`**; the control (a scratch `PlantSorry`
   importing BorelTransfer): `NOTCLEAN PlantSorry ipd1PlantedSorry #[sorryAx]`, `constants=563 clean=562 other=1`.
4. The read-back across pins: stage 5.
5. Every table entry has its reason; the protected-declaration check: stage 5.

**4.4 The switch** (plan § 4.4; `tools/fs131_ipd1_switch.py`, `tools/fs131_ipd1_switchdiff.py`, `data/fs131/ipd1/switch/`).
- **Step 0**, before any edit: every named constant (and private one) of `Outside/OAI158` and of its 24 downstream
  modules (`data/fs131/ipd1/switch-downstream.txt`), from the build as it stands, in FS132-I2's full and erased prints
  (`data/fs131/ipd1/lean/SwitchDump.lean`, FS131-KO1's footer functions with a last command reading each module's own
  compiled data): **485 constants, 25 modules** (`step0.out.xz`); `OAI158` 29, `Plane/RadiusOutside` 8,
  `Plane/LebesgueNumber` 34 — the exposure test's counts (plan § 3.5).
- **Steps 1–2** (`fs131_ipd1_switch.py apply 5692c3288`, the stage-1 commit; the files were unchanged since): the axiom and
  its docstring deleted; the five theorems and the `example` moved to `Outside/OAI158Collapse` (imports
  `Outside/OAI158BorelTransfer`, `Plane/YesLimit`; `open MeasureTheory`; the namespace); `OAI158`'s module docstring
  rewritten for one outside theorem and the transfer as a theorem of the port, and its heading over the outside theorems
  made singular; the one import line in each leaf module. `check`: **`SWITCH-CHECK OK`: 6 blocks moved, 71 lines** — each
  block byte for byte once in `OAI158Collapse` and absent from `OAI158`, `OAI158` its old text less exactly those blocks and
  the axiom, the leaf modules differing in exactly the import line. Control: four plants each REPORTED
  (`step1-control.out`).
- **Step 3**: the build (4.6), exit 0, no warning from any module.
- **Step 4**: the same dumper after the build (`SwitchDump4.lean`, the 25 modules and `OAI158Collapse`,
  `OAI158BorelTransfer`): `fs131_ipd1_switchdiff.py step0 step4`: **484 IDENTICAL and `proper_to_borel_weak`
  TYPE-IDENTICAL** — kind `axiom` → `theorem`, its full type print the axiom's; the five moved now in `OAI158Collapse`, the
  transfer in `OAI158BorelTransfer`, nothing else changed module (`step4-diff.out`). Its control: an instance-only change,
  a real change, a removed constant, the transfer's type, the transfer left an axiom, another constant moved — each
  REPORTED as planted (`switchdiff-control.out`). No kernel check of leaf R was needed (TYPE-IDENTICAL).
- **Step 5**: `./scripts/axioms.sh` on the registered library: **OK — 8961 clean, 32 axiom-free, 26 imported, 5
  declared purchases; declared imports 2, library axioms 2**, every one declared (`axioms.out.xz`, the receipt
  `axioms-receipt.log.xz`). The twelve records that rested on the transfer, and the transfer itself, each print
  **exactly `[propext, Classical.choice, Quot.sound]`** (`step5-records.txt`, 13 lines). The audit flags CLAUDE.md's
  recorded count as stale (7531 → 8961 clean, 38 → 26 imported): the landing's filing.

**4.5 The registration** (`tools/fs131_ipd1_register.py apply 5692c3288`; `check`: **`REGISTER-CHECK OK`: 32 modules,
32 rows, 1,422 generated records and 12 moved**; its control: an extra line in each of the three files and a record of
the transfer left under IMPORTED, each REPORTED). `Proofs.lean`: 32 lines after `OAI158AngularBoundary`'s.
`ARCHITECTURE.md`: 32 rows after `Outside/OAI158AngularBoundary`'s, and the text of **three** rows — `Outside/OAI158`
(one outside theorem; the transfer a theorem of the port; its consumers moved), `Plane/RadiusOutside` and
`Plane/LebesgueNumber` (their imports cell, required by `tools/check_architecture.py`, and the words calling the
transfer a declared outside theorem); `tools/check_architecture.py`: exit 0, 382 rows, 0 import mismatches.
`scripts/Axioms.lean`: the transfer's `declareImport` removed; its twelve records with their comment lines moved from
IMPORTED to CLEAN, above the PURCHASED banner, under a header; under them the 1,422 records of `--axioms-block` on the 31
modules (one private, `pickSupport`, in a `section` with `open private`); the IMPORTED prose on the number of imports
made true.

**4.6 The build** — `./scripts/build.sh` under the slot (`--mem 10 --cpus 4`, `MEMMAX=10G BATCH=8`): **OK — 253 of 253
batches, 58 modules rebuilt, 0 with warnings, 11 m 15 s** (`build/gate/build/20261014T082252Z-2310929.log`; the job's
log kept as `data/fs131/ipd1/build.log`). Resumable by Lake: a relaunch rebuilds only what is out of date.

**4.7 The join recipe's step 0** (plan § 4.5; `data/fs131/ipd1/join/`). The density side: every named constant of
`Outside/OAI158Transfer` (50) and Rigidity's 7 copies with its axiom `residual_fourier`, from `fs133-wk1`'s compiled
library (read only; tree at `110f1c923`, branch `fs133-wpq`; the two oleans' hashes `density-oleans.sha256`), by
`data/fs131/ipd1/lean/JoinDensity.lean`; the port's side, the same 58 names from this tree's registered build
(`JoinPorted.lean`); compared by FS131-KO1's exposure reader: **54 IDENTICAL, 3 INSTANCES-ONLY** — `approxField`,
`approxIndex`, `measurableField` (BorelTransfer's definitions): types IDENTICAL, values differing only in which generated
proof auxiliary they cite — the density copy `Koopman.isometry._proof_1` (`IsTopologicalAddGroup ℂ`) and `_proof_2`
(`Nat.AtLeastTwo (1 + 1)`), the port `LabelModel.projected._proof_1` and `approxIndex._proof_1` / `_proof_2`, whose types
print alike on both sides (`aux-density.out`, `aux-ported.out`); the port holds `Koopman.isometry._proof_1/_2` too, and the
elaborator shares an earlier identical auxiliary of the file, which whole files put elsewhere. And `residual_fourier`:
axiom there, theorem of `OAI158Ergodicity` here, **its type IDENTICAL** (full print), which the join's step 8 will see.
Sent at once; **ruled (by message): the three up to proof arguments, the join may proceed** — on two conditions: this
record names the auxiliaries each side cites and that their types print alike (above), and the join's step 8 dump of the
eight density modules must read IDENTICAL, or the join stops and comes to the coordinator.

## Stage 5 — SAVED: the protected-declaration check, the whole-library steps, and lane D's read-back

**5.1 The protected-declaration check across the whole port** (plan § 4.3; `data/fs131/ipd1/lean/ProtectedCheck.lean`,
`protected-check.out`). The modules of ours that can name a ported constant are those downstream of the 31 generated
modules: `Outside/OAI158Collapse`, `Plane/RadiusOutside`, `Plane/LebesgueNumber` (from the import graph). Every
constant of their compiled data, its stored type and its stored value, was read for constants declared in a generated
module: **one line in all** — `nonempty_aeColouring_of_colorable`'s **value** (its proof) names `proper_to_borel_weak`.
**No stored statement of ours names a ported constant**, and the one ported constant a term of ours names is the target,
which no table entry touches: none is ADAPTED or RULED (lanes A–C's RULED 32 and ADAPTED 4, `verdicts.tsv`; lane D adds
`algebra_commRing`, ADAPTED, which nothing of ours names). The generator refuses an adaptation on a target or a shared
declaration and was asked for none there.

**5.2 The whole-library steps on the registered library** (not the landing's gate; what it will read):
- `./scripts/dupnames.sh`: **OK — no name declared by two modules** (26 generated on demand; new since the last run:
  `OAI158.angularSum.eq_1`, `MeasureTheory.Measure.addHaar.congr_simp`, `MeasureTheory.measureUnivNNReal.eq_1`, each
  GENERATED; `gate-dupnames.out`).
- `./scripts/vacuity.sh`: **OK** — `declarations=17785 refutations-skipped=232 sites=1454`, `vacuous=0 stale=0
  declared=3 witnessed=38 generic=1411 unknown=2`: the port adds 1,660 declarations, 4 skipped refutations and **no
  site** (`gate-vacuity.out`).
- `./scripts/assumptions.sh`: **12 FAIL `stale-consumer`**, exactly the twelve: `scripts/assumptions-ledger.txt` still
  lists `RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak <record>` for each, and no axiom of that name exists
  now. Digest: `axioms=2 rests=27 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1` (only `axioms`
  3 → 2 and `rests` 39 → 27 move). The ledger file is not this job's to write: the landing runs `--write-ledger`
  (`gate-assumptions.out`).

**5.3 Lane D's read-back across pins** (`data/fs131/ipd1/readback/laneD/`; 524 constants: 328 source declarations, 196
generated auxiliaries). *Why the dumps took three tries.* The release-side dump wrote nothing for 24 minutes and was
stopped (forfeit: that run). `#eval` holds what the dumper prints in its captured stdout until the whole run is done,
and lane D's prints are about 1.4 GB on each side: FS132-I2's printer writes terms as trees, and
`CommutingSpectral.character_apply` (222 MB), `character._proof_6` (206 MB), `LabelModel.representation` (104 MB; its
value is a term of 5.5 million nodes) and a few more are large. Constants dumped alone took seconds, and the progress
file of a split run showed every constant started. The run that worked is the same dumper with one change, in
`runAll`: stdout re-pointed at the output file for the loop (`{Release,Here}DumpFile.lean`). Both sides **`DONE
524`, exit 0, about two minutes each**; the here side from the registered build (`lake env lean`); `prints.sha256`
(release `8574ca43…`, here `43aa2be5…`). The prints are not committed (1.4 GB each); the dumpers are, and they
reproduce them. The comparator: FS131-IPA1's `tools/fs131_ipa1_readback_port.py` with this job's rules (ADAPTED_VALUE,
PROOF_ONLY, the `algebra_commCStar` PIN-DIFFERENCE with its note, TARGETS_HERE), each with planted controls. A first
comparison was killed at its 14 GiB cap; the second runs at 20 GiB, alone on the machine (result: 5.4).

**5.4 The comparison** (`compare.out`, `verdicts.tsv`, `instance-constants.txt`, 128 constants recorded; the 20 GiB run
finished): **`READBACK FAILED` — 13 failing, 1 fatal, of 524.** What passed: definitions 62 IDENTICAL, 22
UP-TO-INSTANCES, 1 ADAPTED; lemmas 161 IDENTICAL, 77 UP-TO-INSTANCES; auxiliaries 111 IDENTICAL, 21 UP-TO-INSTANCES,
1 PIN-DIFFERENCE, 26 AUX-ABSENT and 29 AUX-DIFFERS (counted). **The three rulings of Amendment 1 hold as ruled:**
`algebra_commRing` is ADAPTED (UP-TO-INSTANCES, ADAPTED_VALUE); `mulLp` is IDENTICAL and `mulLp._proof_1` AUX-DIFFERS
(PROOF_ONLY: no fatal); `algebra_commCStar` is UP-TO-INSTANCES (its value through `NormedCommRing.mk` here,
`IsMulCommutative.instCommCStarAlgebra` there), with `_proof_3` PIN-DIFFERENCE. **The transfer
`proper_to_borel_weak` is IDENTICAL to the release's statement.** What is open, each item with the class it falls in:
1. `ConvexAverage.setIntegral_bm` and `setIntegral_of_limit` — "EQSET rewrote a constant it does not list": `s =ᵐ[μ]
   t` of sets, FS131-IPB1's EQSET class (standing word, item 772). Owed: the two added to `EQSET_LEMMAS`, then
   PIN-DIFFERENCE (EQSET).
2. `Spectral.instAddCommGroupRot` (from `def Rot := Additive K deriving AddCommGroup`) and 9 of its `_proof_n` — differ
   by its own `_aux_n`, the `Monoid` parents class of item 763 (3), as `instCommGroupDiscreteE`. Owed: the instance added
   to `PIN_DIFFERENCE` (its full type identical, which the rule requires).
3. `CommutingSpectral.generator_unitary` — its statement's instance path passes through the release's own
   `algebra_commRing` there and not here (UP-TO-INSTANCES refused, since the differing constants include a release
   declaration). **Not ruled; for the coordinator**: both paths give the monoid of `algebra U`, whose data is the
   closure's ring at both pins. The evidence would be a check at this pin that the two instance terms agree by `rfl`,
   which was not run.
4. **FATAL `TARGETS_HERE`: `Spectral.residual_fourier` reads UP-TO-INSTANCES against the release's statement, not
   IDENTICAL.** The differing constants are Mathlib's alone (`CommSemiring.toSemiring Complex.instCommSemiring
   Semifield.toCommSemiring SubsemiringClass.toCommSemiring` there, `DivisionSemiring.toSemiring
   Semifield.toDivisionSemiring` here): the hierarchy reflow. Against the density branch's declared axiom at this pin
   it is IDENTICAL (4.7), and FS133-IA1's leaf R checked that axiom's type against the release's rebuilt statement by
   `Eq.refl`. My rule asked for more than the plan does (§ 4.4 step 4 allows INSTANCES-ONLY with leaf R).
   **For the coordinator**: whether the target rule is IDENTICAL-or-UP-TO-INSTANCES with Mathlib's constants only.
Not run: the comparator's `--self-test` on lane D with the new rules, the ADAPTED_VALUE elaboration control (the
variant module is written: `build/ipd1/ctlsrc/…/OAI158SpectralMeasure.lean`, with `commRingTopologicalClosure` as the
whole value), and level one for lane D. The comparator's new rules are committed untested by their self-test.

## Stage 6 — SAVED: what the landing reads (drafts; none of these files is this job's)

- **`CLAUDE.md` § Trust ledger** (the sentence "the current audit reads 7531 clean and 5 declared purchases, and 38
  imported (and 28 axiom-free; 7,602 records …)"): *"the current audit reads 8961 clean and 5 declared purchases, and 26
  imported (and 32 axiom-free; 9,024 records at the landing of the port of `[OAIMath2026]`'s transfer proof,
  FS131-IPD1)"*; the following sentence: the library declares **two** outside axioms, `StandingFive.kloosterman_bound`
  (twenty imported records) and `Outside.OAI158.no_proper_five_coloring` (six); `Outside.OAI158.proper_to_borel_weak`
  is the release's theorem, its proof ported (31 modules `Outside/OAI158Basic` … `OAI158BorelTransfer`), on the
  standard three, and its twelve former records are CLEAN. The digest line: `axioms=2 rests=27 named=19 inline=14
  outside=7 ours=21 open=5 takes=102 mentions=1` (5.2), after `./scripts/assumptions.sh --write-ledger` retires the
  twelve `RESTS … proper_to_borel_weak` lines of `scripts/assumptions-ledger.txt`.
- **`CLAUDE.md` § The gate**: `declarations=17785 refutations-skipped=232 sites=1454`, `vacuous=0 stale=0 declared=3
  witnessed=38 generic=1411 unknown=2` (the landing reads the four new skipped refutations).
- **`CLAUDE.md` § The aim, § Where the problem stands, the Frontier**: every "on the declared outside theorem
  `Outside.OAI158.proper_to_borel_weak`" (the collapse `χ(ℝ²) = χ_m⁰(ℝ²)`, the criterion `7 ≤ χ(ℝ²) ⟺ lim µ₆(ε) < 1`, `χ(ℝ²)
  = χ_m(ℝ²)`, the half of the disc criterion toward seven) becomes "on the standard three axioms (the transfer is a
  theorem of the port since FS131-IPD1)"; "This library holds `6 ≤ χ(ℝ²) ≤ 7` on one declared outside theorem" stays
  (that one is H).
- **`ARCHITECTURE.md` § Trust**: the row of `Outside.OAI158.proper_to_borel_weak` (`Outside/OAI158`) removed, or rewritten
  as "no longer a purchase: a theorem of `Outside/OAI158BorelTransfer` since FS131-IPD1".
- **`scripts/axioms-controls.txt`** (its baseline counts read the library's state): `COUNT imported=38` → `26`,
  `declared=3` → `2`, `library=3` → `2`, the `old` digests' texts and `banner_dropped`'s consequences as its header
  describes, and the header's sentence on three declared imports. `./scripts/axioms.sh --self-test` fails on the baseline
  until then (not run here).
- **`LEAN.md`**, gathered: plan § Drafts F1 (the adaptation line; the whole-file line) and F2 (three § Searching
  bullets); FS131-IPA1's ruled-statement-change class; FS131-IPB1's COEFF, CLASS_PARAMS, EQSET, the ascription and
  instance adaptations, inductive constructors; and this job's —
  (a) § Assumptions, after the adaptation line: *"An adaptation may stand in a definition's value: the release's own
  instance named with the `Prop` it asks proved explicitly, where this pin lacks the instance that proves it
  (`CommutingSpectral.algebra_commRing`); a proof patch inside a definition's proof argument goes under the same table
  key, and the read-back requires the definition IDENTICAL and only its auxiliary differing (`BoundedMeasurable.mulLp`;
  FS131-IPD1)."*
  (b) § Searching — Lean: *"`#eval` holds what the evaluated code prints in a captured stdout and emits it as one message
  when it ends, so a dump of hundreds of MB never finishes and a flush shows nothing: re-point stdout at a file for the
  loop (`IO.setStdout (IO.FS.Stream.ofHandle h)`), or write to a handle (`data/fs131/ipd1/readback/laneD/
  ReleaseDumpFile.lean`). A tree print of a term is its size as a tree, and a definition's value can be millions of nodes
  (`LabelModel.representation`: 5.5 million) (FS131-IPD1)."*
  (c) § Searching — Lean: *"A private declaration of another module is nameable in a `section` that opens it with
  Batteries' `open private <name> from <module>`, in the library's import closure; `#print axioms` then prints the record
  under its full private name (`scripts/Axioms.lean`'s port block; FS131-IPD1)."*
  (d) § Building: *"A module whose upstream must change before it can elaborate (a port whose name an upstream axiom
  holds) is elaborated in a symbolic copy of the compiled library (`cp -as` of `.lake/build/lib/lean/Proofs`), each
  module compiled there written over its link after the link is removed, and the copied-from oleans checked unchanged by
  hash (`data/fs131/ipd1/farm2-run.sh`; FS131-IPD1)."*
- **`ARCHITECTURE.md` § 3**: written by this job (4.5).
- **The landing's tree needs**: this branch (`fs131-wpl`) merged onto `main`; a rebuild of the downstream of
  `Outside/OAI158` (this tree's `.lake/build` holds it, 58 modules, gated by this job's build); the gate in full, with
  `scripts/assumptions-ledger.txt` rewritten (`--write-ledger`) and `scripts/axioms-controls.txt` brought to the new
  counts; the read-back items of 5.4; and, at the density equality's join, steps 1–9 of plan § 4.5 under the ruling of
  4.7.
