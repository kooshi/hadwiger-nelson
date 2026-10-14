# FS131-LP1 — the landing of the port of `[OAIMath2026]`'s transfer proof

*de Bruijn, the implementer; job FS131-LP1 (brief: `data/fs131/briefs/FS131-LP1-landing.md`, on `main`). Branch
`fs131-wlp`, cut from `fs131-wpl` at `4ecf6eaeb` in the worktree `.claude/worktrees/fs132-wi1`. Working files:
`data/fs131/lp1/`. The plan is `plans/FS131-KO1-port-plan.md`; the lanes' records are `plans/FS131-IPA1-implementation.md`,
`plans/FS131-IPB1-implementation.md`, `plans/FS131-IPD1-implementation.md` (this branch). The outside release is
`[OAIMath2026]` family 158 at commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a` of `/home/kooshi/source/math` (read,
never written).*

## Theorems this phase proved

None of this project's mathematics. The landing takes the port — the release's own declarations, every proof checked by
this kernel at this pin — through the gate. The kernel theorem it makes held is `[OAIMath2026]`'s:
`HadwigerNelson.Outside.OAI158.proper_to_borel_weak` (ported; its axioms are read in stage 5 below).

## Stage 1 — SAVED (FS131-LP1): the readback

**1.1 The brief's quotations** — `tools/fs131_lp1_readback.py` (FS131-IPD1's reader with the brief's path changed and
nothing else; the diff is three lines, two of them its docstring): **8 matched, 0 mismatched**, exit 0
(`data/fs131/lp1/readback-brief.out`) — W4 and W2 against `data/fs131/REQUEST-2026-10-13.md`; items 759, 807, 758, 763,
767 and 772 against `plans/FS131-close-inventory.md`. `--fault` (the last character of each quotation changed): 0
matched, 8 mismatched, exit 1 (`readback-brief-fault.out`). No finding about the brief.

**1.2 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole (§ The gate, § Assumptions and § Trust
ledger as they stand on `main`); `RUNNING.md` § Building and § Make the gate fail; FS131-IPD1's record whole; the plan's
§ 4.3–4.7 and its drafts; FS131-IPB1's stage 5; the comparator `tools/fs131_ipa1_readback_port.py` whole and the parts of
FS132-I2's `tools/fs132_i2_readback.py` it calls (`load`, `judge`, `compare`, the dumper's `report`).

**1.3 The branch and the merge.** `fs131-wlp` cut from `fs131-wpl` at `4ecf6eaeb` (clean). The trial (`git merge
--no-commit --no-ff main`, `main` at `e928d4aa2`): no conflict; 40 files, every one under `plans/` or `data/` but
`BIBLIOGRAPHY.md`; no `.lean` file, lakefile, manifest, toolchain, script or tool; no file changed on both sides. Merged
as `c1725a7d8`.

**1.4 The build as it stands.** `lake build --no-build` under the slot: `All targets up-to-date (6177 jobs)`, exit 0,
4.7 s (`data/fs131/lp1/nobuild-0.out`) — the tree's compiled library is current for the merged commit.

**1.5 The stored statements before any edit** — `data/fs131/lp1/lean/StmtDump.lean`, FS131-IPD1's switch dumper
`data/fs131/ipd1/lean/SwitchDump4.lean` with its header changed and its body byte-identical (`diff` of everything after
the header: none): every named and private constant of `Outside/OAI158`, of the 24 modules downstream of it that the
switch read (`Plane/RadiusOutside` and `Plane/LebesgueNumber` among them), of `Outside/OAI158Collapse` and of
`Outside/OAI158BorelTransfer`, from the build by `lake env lean` under the slot: **`DONE 541`**, exit 0, 1 m 15 s, 5.5 GiB
resident (`data/fs131/lp1/stmt/before.out`, its sha256 `1e6ae66d…`). It is **byte-identical** to FS131-IPD1's step-4 dump
(`data/fs131/ipd1/switch/step4.out.xz`, the same sha256): nothing moved between that job's build and this landing.

## Stage 2 — SAVED (FS131-LP1): the read-back finished — the comparator within 8 GiB, the four items, READBACK OK

**2.1 Lane D's prints, regenerated** (`data/fs131/lp1/dump-laneD.sh`: FS131-IPD1's file-writing dumpers with their
output path changed, the release side by `data/fs131/ko1/leanrel.sh` at v4.34.1, this side by `lake env lean` from this
tree's build): both `DONE 524`, exit 0, 6 m 11 s for the two; **sha256 identical to FS131-IPD1's** (`8574ca43…`,
`43aa2be5…`; `data/fs131/lp1/readback/laneD/prints.sha256`). The prints (1.42 and 1.45 GB) are not committed; the
script reproduces them. The largest block is `CommutingSpectral.character_apply`, 221.7 MB on one line; no line over 5 MB
holds a head that makes the comparator build a tree (`Algebra.algebraMap`, the antidiagonal, `EventuallyEqSet`).

**2.2 The streaming reader (item 807 ruling 4).** Where the 20 GiB went: the in-memory `ruled_compare` holds both prints
whole as Python strings, splits them into lines, keeps every constant's four normalised prints in two dicts, and loads
the release's print three times over (once in FS132-I2's `compare`, once again, once more per release-side rewrite).
Every verdict is a function of one constant's two blocks, except PIN-DIFFERENCE, which reads its owner's kind, universe
parameters and full type. `ruled_compare_stream` (in `tools/fs131_ipa1_readback_port.py`, FS131-IPA1's comparator, the
in-memory functions kept unchanged as the oracle) reads the two prints block by block in the cone's row order with one
block of lookahead, parses each block with FS132-I2's own `load` on that block's text alone, keeps per constant only its
row of the table (and, for the PIN_DIFFERENCE owners, the three fields the rule reads, resolved after the pass), and
makes the aggregate checks at the end in the in-memory order. One deliberate difference: a block out of the row order —
a label printed twice, out of order, or not a row — is consumed and reported FATAL, where the in-memory reader kept the
last copy in silence.
- **Equivalence**, a command (`equivalence LABEL`), on every label whose prints are small — FS131-IPA1's `laneA`,
  `laneB1` and FS131-IPB1's `laneA-regress`, `laneB`, `laneB1`, `laneB-centers`, `laneC1`, `laneC2`: the same rows, the
  same failing, fatal and recorded constants, with the record as committed and with none; with a block removed and with
  the print truncated at half its lines, the same failing count and fatal list; with a block printed twice, the
  in-memory reader as unplanted and the streaming one as unplanted plus exactly one fatal. **EQUIVALENCE OK on all
  eight** (`data/fs131/lp1/readback/equivalence/*.out`). Its control: a copy of the comparator with the AUX-DIFFERS class
  withdrawn from the streaming reader alone — **EQUIVALENCE FAILED**, five lines DIFFER (`control-noauxdiffers-laneC2.out`).
- **Lane D under an 8 GiB cap, the rules as committed at `4ecf6eaeb`**: 1 m 0 s, 4.2 GB resident, exit 1 as it must be;
  its printed text is FS131-IPD1's 20 GiB run's line for line (that run's first line, `--record`'s, aside), and its
  `verdicts.tsv` byte-identical (`compare-oldrules.out`, `verdicts-oldrules.tsv`).
- `emit-level1` reads the release's print block by block as well: on `laneA` its three files are byte-identical to the
  in-memory emitter's; on `laneC2` its `ReleaseLevel1.lean` is a byte prefix of the committed file, which carries
  FS131-IPB1's hand-appended EQSET `rfl` examples after it (restored by `git checkout`; nothing of that job's written).

**2.3 The four items, under the coordinator's rulings 1–3.**
1. *`ConvexAverage.setIntegral_bm`, `setIntegral_of_limit`* — added to `EQSET_LEMMAS` (item 772's standing word):
   **PIN-DIFFERENCE (EQSET)**.
2. *`Spectral.instAddCommGroupRot` and its auxiliaries* — added to `PIN_DIFFERENCE` (item 763 (3)'s class; the owner's
   kind, universe parameters and full type identical at both pins, which the rule requires): the owner **PIN-DIFFERENCE**,
   and under the rule as FS131-IPA1 wrote it every one of its auxiliaries not IDENTICAL or UP-TO-INSTANCES — 9 DIFFERENT,
   3 AUX-DIFFERS, 2 AUX-ABSENT — **PIN-DIFFERENCE** too (14).
3. *`CommutingSpectral.generator_unitary`* (ruling 1). The difference, read from the two prints: the `Monoid` of
   `↥(algebra U)` that `unitary` takes is `SubmonoidClass.toMonoid (algebra U)` at the release and `Semiring.toMonoid`
   through the ported instance `algebra_commRing` here; the erased types are identical. **The kernel check**
   (`data/fs131/lp1/rfl/GeneratorUnitary.lean`, at this pin from this build, exit 0, 5 s): `monoid_paths_agree :
   (SubmonoidClass.toMonoid (algebra U) : Monoid (algebra U)) = (inferInstance : Monoid (algebra U)) := rfl` and
   `statement_paths_agree : (generator U g ∈ @unitary (algebra U) (SubmonoidClass.toMonoid (algebra U)) _) = (generator U
   g ∈ unitary (algebra U)) := rfl`, both accepted. The same file prints, with the read-back's own dumper, `here_form` —
   the lemma's text elaborated there, whose stored type is **exactly** `generator_unitary`'s in lane D's print here — and
   `release_form` — the lemma written with the release's path — whose erased type is the release print's and whose full
   type differs from it by five constants, none the release's own (`Monoid.toSemigroup`, `Semigroup.toMul` here,
   `MulOne.toMul` there: Mathlib's `Monoid`-parents change, item 763 (3); `SubmonoidClass.toMulMemClass`,
   `SubmonoidClass.toMonoid._proof_5`). **The planted non-agreeing term** (`GeneratorUnitaryPlant.lean`: the release's
   instance with `npow := fun n x => npowRec n x`, the same type and multiplication): the kernel refuses it — "Not a
   definitional equality … is not definitionally equal to the right-hand side", exit 1, the errors at its lines 16 and 20
   and none at its partner `monoid_paths_agree` (line 14). The comparator's rule **INSTANCE_EVIDENCE**: a listed
   declaration that differs inside instance arguments by constants of the release's own reads UP-TO-INSTANCES when those
   constants are among the ones listed for it (`algebra_commRing`) and the receipt
   (`data/fs131/lp1/readback/evidence.out`, written by `tools/fs131_lp1_instance_evidence.py` only when all four of its
   checks pass) holds its line; a listed declaration that then does not read so is fatal. **UP-TO-INSTANCES**, with that
   evidence.
4. *`Spectral.residual_fourier`* (ruling 2). The rule **TARGET_IN_LIBRARY**: a target reads IDENTICAL, or
   UP-TO-INSTANCES when it is listed, every constant by which its prints differ is one its own print's `USES` lines
   place in Mathlib or core (here: `CommSemiring.toSemiring`, `Complex.instCommSemiring`, `Semifield.toCommSemiring`,
   `SubsemiringClass.toCommSemiring` there; `DivisionSemiring.toSemiring`, `Semifield.toDivisionSemiring` here — all
   `Mathlib.`), and the receipt holds `IN-LIBRARY OK`: the evidence tool's check that the density branch's dump
   (`data/fs131/ipd1/join/density.out.xz`, FS131-IPD1's, from that branch's build) holds the axiom with exactly the
   universe parameters, full type and erased type of the theorem in lane D's print here (the two dumpers' print function
   is one text, a binder variable's name aside). **UP-TO-INSTANCES**, with that evidence. `proper_to_borel_weak` reads
   **IDENTICAL** to the release's statement, with no rule.

The evidence tool's controls (`--control`, eight plants in memory, `evidence-control.out`): the evidence file failed;
an error in its output; `generator_unitary`'s stored type here changed at one instance constant; a constant of the
release's own in the release print's instance argument; the planted control accepted; the planted control's error moved
to its partner; `residual_fourier`'s type here changed; the density branch's constant not an axiom — **each REFUSED**,
the unplanted inputs pass.

**2.4 Lane D, the new rules**: with the record as FS131-IPD1 left it, `failing: 0` and one fatal, the record — the 19
constants of `generator_unitary`'s difference, now UP-TO-INSTANCES (`compare-newrules-oldrecord.out`); re-recorded
(`compare --record`): 128 → 147 constants, **19 added, 0 removed, every one among `generator_unitary`'s differing
constants** (the old record kept as `instance-constants-ipd1.txt`). Then **`READBACK OK` — 524 constants, failing 0,
fatal 0** (`data/fs131/lp1/readback/laneD/compare.out`, `verdicts.tsv`): definitions 62 IDENTICAL, 22 UP-TO-INSTANCES,
1 ADAPTED (`algebra_commRing`), 1 PIN-DIFFERENCE (`instAddCommGroupRot`); lemmas 161 IDENTICAL, 78 UP-TO-INSTANCES, 2
PIN-DIFFERENCE (EQSET); auxiliaries 111 IDENTICAL, 21 UP-TO-INSTANCES, 15 PIN-DIFFERENCE, 26 AUX-DIFFERS, 24 AUX-ABSENT.

**2.5 The ADAPTED_VALUE elaboration control** (`data/fs131/lp1/advalue-run.sh`; label
`data/fs131/lp1/readback/advalue/`, the one module `OAI158SpectralMeasure`, 130 constants). FS131-IPD1's variant
(`algebra_commRing`'s whole value `StarSubalgebra.commRingTopologicalClosure _ (fun x y => mul_comm x y)`; the copy
`OAI158SpectralMeasure-variant.lean`, one line differing) compiled with `lean -o` into a scratch farm of links
(`build/lp1/advfarm`, the link at its `.olean` removed first): exit 0, no error or warning; the real `.olean`'s sha256
the same before and after. Three prints, each `DONE 130`. The partner (this side from the build): **READBACK OK**,
`algebra_commRing` ADAPTED (`compare-partner.out`). The variant: **`algebra_commRing` DIFFERENT** ("value, erased
print, at char 5810: … `inferInstance` … | here … `StarSubalgebra.commRingTopologicalClosure`") and **`FATAL:
ADAPTED_VALUE lists §.CommutingSpectral.algebra_commRing, which reads DIFFERENT`**, READBACK FAILED, exit 1
(`compare-variant.out`). The rule refuses another instance path, as ruled.

**2.6 The comparator's `--self-test`, streaming, with every new rule.** `self_test_stream`: the in-memory self-test's
plants, each planted into the stream (a block replaced or removed, a truncation, a rule's list or flag changed for one
pass) and each a full streaming pass under the 8 GiB cap; its selections (the first theorem with an explicit binder, the
first definition with a numeral, the users of a ruled head, …) made by one streaming survey with the in-memory
predicates. **Its equivalence, plant for plant**: on every small label where the unplanted pair passes (seven of the
eight; FS131-IPA1's early `laneB1` fails unplanted in both readers alike), the streaming self-test prints the in-memory
one's plant lines exactly — every plant, verdict and count (`data/fs131/lp1/readback/selftest-small/*-{inmemory,stream,stream2}.out`:
0 differing lines, before and after the two changes below).
- **First run on lane D** (`selftest-run1.out`, exit 1): 30 plants, 28 REFUSED and two not. (i) *CLASS_PARAMS
  `Algebra.algebraMap` withdrawn*: SILENT — lane D's one user of the head (`BoundedMeasurable.avg_orbit_const`) has
  the same argument 3 at both pins, so withdrawing the rule can fire nothing here; the plant's failure mode is
  unreachable on this label (`RUNNING.md` § Make the gate fail: a control whose failure is unreachable has not been
  tested by passing). The self-test now measures it: the survey reads every user with the rule withdrawn, and where no
  user's erased prints differ it prints `UNREACHABLE … not a plant, not counted`; where one does (FS131-IPB1's `laneC2`,
  `NumberFields`) the plant runs as before (the small labels' lines unchanged). Its partner, *its argument 2 changed*,
  stays REFUSED. (ii) *ADAPTED_VALUE: the value changed outright*: REFUSED FOR ANOTHER REASON — FS131-IPD1's plant
  changed `IsMulCommutative.instCommRing`, which stands in an instance argument (erased), so the read-back reads
  UP-TO-INSTANCES, which the rule accepts by its ruling; only the record of instance constants refused it. The rule
  refuses what is not IDENTICAL or UP-TO-INSTANCES, so its plant now changes the value's head `inferInstance` (an
  explicit position) and wants the ADAPTED_VALUE fatal, and the instance-argument plant is kept as a second plant that
  wants the record's refusal. Neither change loosens a rule: the first removes a plant that cannot fire, with the count
  that shows it cannot; the second aims the plant at what the ruling refuses.
- **Second run on lane D** (`selftest.out`, exit 0): **`SELF-TEST OK: 30 plants refused, the unplanted pair passes`**,
  the CLASS_PARAMS withdrawal `UNREACHABLE` (0 of 1 user). The new rules' plants, each REFUSED: PIN-DIFFERENCE —
  `instAddCommGroupRot`'s full type changed (15 failing), taken out of the list (10 failing); EQSET —
  `setIntegral_of_limit` taken out of the list (1 failing), with the three EQSET plants on `setIntegral_bm`;
  INSTANCE_EVIDENCE — no receipt, the allowed constants withdrawn, another constant of the release's own planted in
  `generator_unitary`'s instance argument, the receipt's line reading FAILED (each 1 failing and the rule's fatal);
  TARGET_IN_LIBRARY — `residual_fourier` taken out of the list, no receipt, a constant outside Mathlib planted in its
  instance argument, a differing constant's `USES` line placed outside Mathlib (each the TARGETS_HERE fatal);
  ADAPTED_VALUE — the head changed (its fatal), an instance argument changed (the record's fatal); PROOF_ONLY's two; the
  two TARGETS_HERE plants on the full types of `proper_to_borel_weak` and `residual_fourier`.
- About two minutes a plant on this machine (each pass reads and normalises 2.9 GB); the run is resumable
  (`--resume`, its progress in `data/fs131/lp1/readback/selftest-progress/`), not needed.

**2.7 Level one for lane D** (`emit-level1`, then `ReleaseLevel1.lean` at v4.34.1 and `HereLevel1.lean` here; FS131-IPB1's
EQSET `rfl` examples appended to the release side, copied from `laneC2`): the release side `DONE 309`, exit 1 with
exactly one error, the EQSET control's (`tᶜ`, line 453: "Type mismatch … `(s =ᶠ[l] t) = (s =ᶠ[l] tᶜ)`"), so the two
`rfl` examples beside it are accepted by the release's kernel; this side `DONE 308` (the one UNFOLDED name not printed
here). **`LEVEL1 OK` — 252 IDENTICAL, 21 MOVED, 35 DIFFERENT of 308** (`data/fs131/lp1/readback/laneD/level1.out`).
MOVED: each a module path (`Mathlib.Basic.*` there, `Mathlib.Data.*` here; `SubNegMonoid`'s `_autoParam`s,
`IsMulCommutative`). DIFFERENT, read by hand, every one in a class already named: the hierarchy's instance paths —
`Monoid.toMul`/`Semigroup.toMul`, `AddMonoid.toAdd`/`AddSemigroup.toAdd`, `CommSemiring.toSemiring`/`DivisionSemiring.toSemiring`,
`AddSubmonoidClass.toAddCommMonoid`/`AddCommGroup.toAddCommMonoid` (item 763 (3), item 769's standing word):
`AddCommGroup`, `AddCommGroup.mk`, `AddCommMonoid`, `AddGroup`, `CommCStarAlgebra`, `CommCStarAlgebra.mk`, `CommGroup`,
`CommRing`, `ContinuousMap.toLp`, `InnerProductSpace`, `IntermediateField`, `LinearMap.extendOfNorm`,
`Lp.compMeasurePreserving`, `Measure.restrict`, `NormedAddCommGroup`, `NormedSpace`, `Semiring`,
`Submodule.HasOrthogonalProjection`, `Submodule.orthogonal`, `Submodule.starProjection`, `SubtractionMonoid`,
`Unitary.linearIsometryEquiv`, `WeakDual.characterSpace`, `algebraicClosure`; `eLpNorm`/`MemLp`/`Lp` (lane A's class):
`MeasureTheory.eLpNorm`, `MemLp`, `Lp`; `Measure.map` (item 758's): `MeasureTheory.Measure.map` (its hygienic auxiliary's
name); EQSET: `ErgodicSMul`, `ErgodicVAdd`; the order of `max`'s arguments in a structure's universe:
`LinearIsometry`, `.mk`, `LinearIsometryEquiv`, `.mk`; a proof auxiliary's number: `StarAlgEquiv.toStarAlgHom`. Lane C's
level one (FS131-IPB1) differed at 17 constants, every one of them in this list or its classes.

**2.8 Lane D's print here, from the library rebuilt after stage 3's docstrings** (the queued step `dump-here`): sha256
`43aa2be5…`, **byte-identical** to the print the read-back above was made on. So the read-back's verdicts are those of
the module as recompiled on this branch; the gate's pass runs the comparison again.

## Stage 3 — SAVED (FS131-LP1): the docstrings, prose only

Commit `5fab41e17`. The script that made every edit is kept (`data/fs131/lp1/doc_edits.py`: each replacement asserted
to match exactly once). What each file said of the transfer, and what it says now:
- `Outside/OAI158Collapse` (6 edits): the module docstring's apology ("Where a docstring below says a theorem 'rests on
  the standard three axioms and `proper_to_borel_weak`', it now names a theorem") replaced by the sentence it pointed
  at; the four docstrings that said "Rests on the standard three axioms and `proper_to_borel_weak`" now say the
  standard three, through the ported transfer; "holds on this import in its place" and "(which rests on the other
  import)" — written while two imports stood — now name the standard three and `no_proper_five_coloring`.
- `Outside/OAI158` (2 edits; FS131-IPD1 had rewritten the module docstring at the switch): the read-back sentence ("the
  statements of H and T are … term for term") now says "of T while it was declared here", and that T as the port's
  theorem is read back by this landing (IDENTICAL, stage 2); the models paragraph says T's model is kept as its model.
- `Plane/RadiusOutside` (7 edits): the title ("on the two outside theorems"), the bullets for `radius_down` and the join,
  and the four docstrings that said "rests on the declared outside theorem `Outside.OAI158.proper_to_borel_weak`" now
  say the standard three, through the release's transfer, its proof ported. The two `--` line comments in the proofs
  ("the half on the declared outside theorem") are left as they are: a line comment is code to the code-only check, and
  the brief says docstrings.
- `Plane/LebesgueNumber` (9 edits): "composes the result with a declared outside theorem", its bullet "**The declared
  outside theorem**", the statements' summary, the read-aloud's "given the outside theorem", the section heading
  `/-! ## On the declared outside theorem … -/` and the three docstrings of its last section.
Every "declared outside theorem" left in the four files names `no_proper_five_coloring`, the one still declared.

**Docstrings only, in text**: `data/fs131/lc1/code_only_diff.py c7122cf10 <the four>` — **SAME** four times (1534, 7312,
3329, 19754 characters of code before and after); its plant (the first `:=` made `:≡` in memory) **DIFFERS** four
times (`data/fs131/lp1/code-only.out`, `code-only-plant.out`). **From the kernel's side**: stage 4's build, then the
stage-1 dumper again.

**From the kernel's side.** The build of `5fab41e17` (queued after the self-test's first run; `./scripts/build.sh` under
the slot, `--mem 10 --cpus 4`, `MEMMAX=10G BATCH=8`): **`build: OK — 253 of 253 batches, 28 module(s) rebuilt, 0
module(s) with warnings, 9m10s`** (`data/fs131/lp1/build/build1.log`; Lake's full log
`build/gate/build/20261014T103833Z-2652823.log`) — `Outside/OAI158` and every module downstream of it (the palette chain,
`SixRing`, `BorelTransfer`, `Collapse`, the two leaves) and the root. Then the stage-1 dumper again
(`data/fs131/lp1/stmt/after.out`, `DONE 541`): **byte-identical** to the dump made before any edit (`cmp`; sha256
`1e6ae66d…` both). No stored type and no definition's value moved.

## Stage 4 — SAVED (FS131-LP1): the registrations

Logs under `data/fs131/lp1/stage4/` (each step's own output, and the gate's full output as `*.full.log.xz`).

**4.1 The audit's state-reading controls** (`scripts/axioms-controls.txt`). Seen red first, on the file as it stood:
`./scripts/axioms.sh --self-test` — **`FAIL — 3 of 23 control(s) did not behave as designed`**, exactly the three that
read the library's state (`axioms-selftest-old-controls.log`): `baseline` ("passed; expected COUNTS imported=38 …
declared=3 … library=3", and the `old` digest's text), `imported_declared` (39, 4, 4), `banner_dropped` ("expected 'FAIL
outside-banners' naming seven_le_chromaticNumber_plane_iff, expected 'FAIL stale-declaration' naming
proper_to_borel_weak"); the other twenty behaved. Then moved by the file's own rule (its header: per declared import
`declared` and `library` by one in both controls and `imported` by its records, the `old` digests' texts with them, and
`banner_dropped` losing that import's two expectations) — `data/fs131/lp1/controls_edit.py`, four blocks, each matched
exactly once: `imported` 38 → 26 and 39 → 27, `declared` and `library` 3 → 2 and 4 → 3, the two `old` texts, the two
lines of `banner_dropped`, and the header's description of the state (two declared imports; the transfer a theorem since
the switch, its twelve records CLEAN since this landing). Then: **`axioms self-test: OK — every planted fault fired, and
every partner passed`** (23 of 23; `axioms-selftest-new-controls.log`), 3 m 54 s, 5.3 GiB.

**4.2 The assumptions step, then its ledger by its own flag.** Run as it stood (`assumptions-before-ledger.log`):
**`FAIL — 12 check(s) failed`, each `FAIL stale-consumer`**, each the transfer's consumer — "the ledger lists 'RESTS
HadwigerNelson.Outside.OAI158.proper_to_borel_weak <record>' and the scan does not find it" for the five of
`Outside/OAI158Collapse`, the four of `Plane/RadiusOutside`, the three of `Plane/LebesgueNumber`; nothing else failed;
"assumed: axioms=2 rests=27 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1". Then `./scripts/
assumptions.sh --write-ledger` (`assumptions-write-ledger.log`): "rows the ledger gains (+) and loses (-)": **twelve
lost, none gained**, exactly those twelve `RESTS` rows; "ledger written (130 rows)"; the ledger's header counts
`axioms=3 rests=39` → `axioms=2 rests=27`, the other seven unchanged (`git diff`: 1 line in, 13 out). Then the step
again: **`assumptions: OK — 2 outside theorem(s) as axioms, with 27 theorem(s) resting on them; 19 named and 14 inline
hypotheses (7 outside, 21 ours, 5 open), taken by 102 statement(s) and mentioned by 1`**, and "RECORDED COUNTS ARE STALE
in CLAUDE.md § Trust ledger — update it: axioms 3 → 2, rests 39 → 27" (draft 3). `scripts/Assumptions.lean` needs no
edit: it declares no hypothesis the port touches (its one mention of the family is `no_proper_five_coloring`'s, in two
sources).

**4.3 The vacuity scan** (`vacuity.log`): **OK** — `declarations=17785 refutations-skipped=232`, `sites=1454 vacuous=0
stale=0 declared=3 witnessed=38 generic=1411 unknown=2`, as the brief predicts; flagged stale, not failed, in the
baseline's header and in `CLAUDE.md` § The gate ("declarations 16125 → 17785, refutations-skipped 228 → 232"). The
baseline's header refiled (one line; its two entries unchanged). **The four new skipped refutations, by name**
(`data/fs131/lp1/lean/Refutations.lean`, the scan's own `isRefutation` and filter copied, over the constants of every
`Outside/OAI158*` module: six, of which two are the palette chain's, FS132-L2's — `triangleAngle_ratio_irrational`,
`two_state_impossible`): `FiniteModule.common_fiber_contradiction` (`OAI158ConditionalSelection`),
`Spectral.finite_uniform_successor_contradiction` and `Spectral.finite_uniform_precision_contradiction`
(`OAI158ConditionalSpectrum`), `Spectral.ambient_uniform_precision_contradiction` (`OAI158ConditionalLimits`) — each the
release's own step inside a proof by contradiction, concluding `False` from hypotheses meant to be jointly unsatisfiable;
none is a statement of ours. The scan adds **no site** for the port (FS131-IPD1's reading: its colourings and measures
are the release's own structures, which the scan does not track — `LEAN.md` § The gate's silence clause); the twelve
consumers' sites are as before.

**4.4 The doubled-name check** (`dupnames.log`): **OK — no name is declared by two modules** (26 generated on demand).
**The architecture check** (`arch.out`): `RESULT: PASS`, exit 0. **The registration** (FS131-IPD1's
`tools/fs131_ipd1_register.py check 5692c3288`): `REGISTER-CHECK OK: 32 modules, 32 rows, 1422 generated records and 12
moved`. **The generator** on the 31 modules (`--check`): `CHECK OK`.

**4.5 Not edited, a note for the tooling job**: `scripts/Vacuity.lean` line 561, inside FS132-L1's paragraph of its
history, still calls the transfer "the imported `proper_to_borel_weak`" — history, and not a file this brief opens.

## Stage 5 — SAVED (FS131-LP1): read aloud

**The transfer's stored statement against the release's.** `HadwigerNelson.Outside.OAI158.proper_to_borel_weak`, as
the kernel stores it here (lane D's print at this pin, `data/fs131/lp1/readaloud/transfer-Here.txt`), and
`OAI.EuclideanFiveColor.proper_to_borel_weak` as the kernel stores it at the release's pin, v4.34.1
(`transfer-Release.txt`): kind `theorem`, no universe parameters, at both; **the full type print (564 characters) and the
erased print identical** once each library's root is written `§.` — the read-back's verdict IDENTICAL (stage 2), and
my own comparison of the two lines. Term for term:

```
(pi.i k (c Nat [])
 (pi.c inst ((((c NeZero [0]) (c Nat [])) (((c MulZeroClass.toZero [0]) (c Nat [])) (c Nat.instMulZeroClass []))) #0)
 (pi.i c (pi.d a (c Complex []) ((c Fin []) #2))
 (pi.d hc (((c §.ProperColoring []) #2) #0)
  (((c Exists [(S 0)]) (pi.d a (c Complex []) ((c Fin []) #4)))
   (lam.d d (pi.d a (c Complex []) ((c Fin []) #4))
    (((c And []) ((((((c Measurable [0,0]) (c Complex [])) ((c Fin []) #4)) (c Complex.measurableSpace []))
                    ((c Fin.instMeasurableSpace []) #4)) #0))
                 (((c §.WeakColoring []) #4) #0))))))))
```

Read: *for every natural number `k` with `k ≠ 0` (`NeZero k`, through `Nat`'s own zero) and every map `c : ℂ → Fin k`,
if `c` is a `ProperColoring k` — gives different colours to every two points `x, y` with `‖x − y‖ = 1` — then there is a
map `d : ℂ → Fin k` that is Borel measurable (`Complex.measurableSpace`, `Fin`'s measurable space) and a `WeakColoring
k` — almost-everywhere measurable, and `d p.1 ≠ d (p.1 + direction p.2)` for almost every pair `p` of a point of the plane
and an angle, plane measure times normalized Haar measure on the circle of angles.* `ProperColoring`, `WeakColoring`,
`Angles`, `angularMeasure` and `direction` are the release's definitions copied into `Outside/OAI158` and read back term
for term against the release at FS132-I1; the source text of the theorem is the release's `BorelTransfer.lean:436–437`
(`lemma proper_to_borel_weak {k : ℕ} [NeZero k] {c : ℂ → Fin k} (hc : ProperColoring k c) : ∃ d : ℂ → Fin k, Measurable
d ∧ WeakColoring k d`), copied by the generator with no patch to it (it is a target: the generator refuses one). Against
the informal claim on the front page ("a proper `k`-colouring of the plane gives a Borel one proper at almost every unit
pair"): the same, with `k ≥ 1` explicit (at `k = 0` there is no map `ℂ → Fin 0`, so nothing is lost), and "proper at
almost every unit pair" read as the release reads it — almost every point and almost every direction, not almost every
pair of the plane's unit-distance graph in another measure. It says nothing of how `d` relates to `c`. **Its stored
type is also the deleted axiom's** (FS131-IPD1's switch, TYPE-IDENTICAL), so every statement of this library that cited
the axiom cites a theorem of the same type.

**Its axioms, and the twelve records that rested on it, from the audit run on this branch at stage 4's commit**
(`data/fs131/lp1/stage4/receipt-axioms.log`; the gate's pass prints them again):

| record | banner | axioms |
|---|---|---|
| `HadwigerNelson.Outside.OAI158.proper_to_borel_weak` | CLEAN | `[propext, Classical.choice, Quot.sound]` |
| `HadwigerNelson.Outside.OAI158.nonempty_aeColouring_of_colorable` | CLEAN | `[propext, Classical.choice, Quot.sound]` |
| `HadwigerNelson.Outside.OAI158.colorable_iff_nonempty_aeColouring` | CLEAN | `[propext, Classical.choice, Quot.sound]` |
| `HadwigerNelson.Outside.OAI158.chiM0_le_chromaticNumber_plane` | CLEAN | `[propext, Classical.choice, Quot.sound]` |
| `HadwigerNelson.Outside.OAI158.chromaticNumber_plane_eq_chiM0` | CLEAN | `[propext, Classical.choice, Quot.sound]` |
| `HadwigerNelson.Outside.OAI158.seven_le_chromaticNumber_plane_iff` | CLEAN | `[propext, Classical.choice, Quot.sound]` |
| `HadwigerNelson.Plane.exists_isWeakColouringOn_of_colorable` | CLEAN | `[propext, Classical.choice, Quot.sound]` |
| `HadwigerNelson.Plane.radius_down` | CLEAN | `[propext, Classical.choice, Quot.sound]` |
| `HadwigerNelson.Plane.colorable_iff_forall_ball` | CLEAN | `[propext, Classical.choice, Quot.sound]` |
| `HadwigerNelson.Plane.seven_le_chromaticNumber_plane_iff_exists_ball` | CLEAN | `[propext, Classical.choice, Quot.sound]` |
| `HadwigerNelson.Plane.colorable_iff_exists_nullMeasurable_proper` | CLEAN | `[propext, Classical.choice, Quot.sound]` |
| `HadwigerNelson.Plane.chromaticNumber_plane_eq_chiLebesgue` | CLEAN | `[propext, Classical.choice, Quot.sound]` |
| `HadwigerNelson.Plane.chromaticNumber_euclidean_plane_eq_chiLebesgue` | CLEAN | `[propext, Classical.choice, Quot.sound]` |

`tools/fs131_lp1_records.py` on that receipt: **records: PASS** — the transfer and the twelve under CLEAN on exactly the
three; no record rests on the transfer and no `DECLARED IMPORT` names it; the declared imports exactly Weil's bound and
`no_proper_five_coloring`; IMPORTED 26 records, 20 on the first alone and 6 on the second alone; 9,024 records, none
printed twice. Its five plants (an axiom added to the transfer's list; a moved record put under IMPORTED; a DECLARED
IMPORT of the transfer; an IMPORTED record removed; a record printed twice) each FAIL, the unplanted receipt passes.
