# FS131-LP1 — the landing of the port of `[OAIMath2026]`'s transfer proof

*de Bruijn, the implementer; job FS131-LP1 (brief: `data/fs131/briefs/FS131-LP1-landing.md`, on `main`). Branch
`fs131-wlp`, cut from `fs131-wpl` at `4ecf6eaeb` in the worktree `.claude/worktrees/fs132-wi1`. Working files:
`data/fs131/lp1/`. The plan is `plans/FS131-KO1-port-plan.md`; the lanes' records are `plans/FS131-IPA1-implementation.md`,
`plans/FS131-IPB1-implementation.md`, `plans/FS131-IPD1-implementation.md` (this branch). The outside release is
`[OAIMath2026]` family 158 at commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a` of `/home/kooshi/source/math` (read,
never written).*

## Theorems this phase proved

None of this project's mathematics. The landing takes the port — the release's own declarations, every proof checked by
this kernel at this pin — through the gate on `75a0035f1` (stage 7). The theorems it makes held on the standard three,
each **[kernel]**, axioms as the gated audit printed them (`data/fs131/lp1/gate/receipt-axioms-final.log`):
- `HadwigerNelson.Outside.OAI158.proper_to_borel_weak` (`Outside/OAI158BorelTransfer`) — `[OAIMath2026]`'s transfer,
  its proof ported — `[propext, Classical.choice, Quot.sound]`;
- its twelve former consumers, each `[propext, Classical.choice, Quot.sound]` and each this library's composition with
  it: `Outside.OAI158.nonempty_aeColouring_of_colorable`, `colorable_iff_nonempty_aeColouring`,
  `chiM0_le_chromaticNumber_plane`, `chromaticNumber_plane_eq_chiM0` (`χ(ℝ²) = χ_m⁰(ℝ²)`),
  `seven_le_chromaticNumber_plane_iff` (`7 ≤ χ(ℝ²) ⟺ lim µ₆(ε) < 1`) (`Outside/OAI158Collapse`);
  `Plane.exists_isWeakColouringOn_of_colorable`, `Plane.radius_down`, `Plane.colorable_iff_forall_ball`,
  `Plane.seven_le_chromaticNumber_plane_iff_exists_ball` (`Plane/RadiusOutside`);
  `Plane.colorable_iff_exists_nullMeasurable_proper`, `Plane.chromaticNumber_plane_eq_chiLebesgue` (`χ(ℝ²) =
  χ_m(ℝ²)`), `Plane.chromaticNumber_euclidean_plane_eq_chiLebesgue` (`Plane/LebesgueNumber`);
- and the port's 1,422 generated records, every one CLEAN or axiom-free (the gated audit: 1,418 and 4).
Evidence files of this job, not library theorems: `data/fs131/lp1/rfl/GeneratorUnitary.lean`'s `monoid_paths_agree`
and `statement_paths_agree` (kernel-checked by `rfl` at this pin, stage 2.3).

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

## Stage 6 — SAVED (FS131-LP1): the guarded lint, red on the port, then green by the generator's `nolint` key (Amendment 1)

**6.1 What the lint said, before** (the lint's planted-control run on `3f63a1219`, `data/fs131/lp1/nolint/run1-lint-plant.log`;
the plant's own two messages aside): 25 findings, every one on a declaration of a generated module — `defsWithUnderscore` 11
(the release's names `Spectral.K_rootable`, `CommutingSpectral.algebra_commRing`, `algebra_commCStar`, and eight
anonymous instances whose generated names carry ANON's `_proofs`: `instMeasurableSpaceCircle_proofs[_3]` ×5,
`instDecidableEq_proofs` ×3), `simpNF` 1 (`Spectral.norm_char`, the release's `@[simp]` lemma whose left side simp
rewrites), `unusedArguments` 13 (the release's binders). FS131-IPD1 had not run the lint on the registered library;
the library had no exemption mechanism. Sent to the coordinator at once; **ruled (inventory item 831, Amendment 1 of
the brief): the generator writes `@[nolint <linter>]` in the file**, by name, with its reason.

**6.2 The probe** (`data/fs131/lp1/nolint/probes/attrs.lean`, at this pin): two attribute blocks on one declaration do
not parse ("unexpected token '@['"), so an entry on a declaration that already has a block is merged into it;
`@[nolint defsWithUnderscore]` attaches to an anonymous instance (its generated name then carries the parameter) —
the ruling's condition holds, and the fallback is not needed. A linter's name must be declared where the attribute is
elaborated: every one of the fourteen modules has `unusedArguments`, `simpNF` and `defsWithUnderscore` in its
environment (the build below: no error).

**6.3 The generator's change** (its own commit, `38d91c4fe`; `tools/fs131_ko1_port.py`): the table key `nolint`,
entries `[declaration, linter, reason]`, the declaration by its name here (the name map and ANON, as the lint prints
it), the reason one of three classes — `name` ("the release's name"), `binder` ("the release's binder"), `simpnf`
("simp's normal form of the release's lemma"). Written: a comment line `-- nolint (FS131-LP1, inventory item 831):
<class>, kept as it is (<linter>)` and the line `@[nolint <linter>]` directly before the keyword line, or `nolint
<linter>, ` merged at the head of the attribute block the keyword line already carries. Refused: an entry naming no
declaration copied in its module (outside the port, private, or another module's), an unknown reason, a linter that is
not an identifier, an entry given twice, an unused entry. Self-test: **23 plants refused and 9 partners accepted**
(`gen-selftest-before-tables.out`, before any table had an entry): the new plants — an entry on
`HadwigerNelson.Plane.radius_down` (outside the port), an entry whose reason is no class — REFUSED; the new partner —
an entry on a copied theorem of `OAI158Basic` adds exactly its comment and attribute lines (`Spectral.K_pow_surjective`,
its own line) or one comment line and the keyword line with the attribute merged (`Spectral.embed_one`, under
`@[simp]`), nothing else — EXACT. Its controls, each a scratch copy of the generator with part of the change
withdrawn: the comment not written — the partner FAILED, exit 1; the refusal of an entry outside the module withdrawn
(both its checks) — the plant SILENT, exit 1 (`gen-control-{nocomment,nostray}.out`). `--check` on the 31 modules with
no entry yet: `CHECK OK`, byte-identical (`gen-check-before-tables.out`).

**6.4 The entries and the regenerated text** (`a1082de98`). `data/fs131/lp1/nolint/add_entries.py` read the 25 findings
from the lint's own log, the class by linter, refusing any finding outside a generated module but the lint control's
plant: **25 entries in 14 tables**, each table the old one with exactly the key `nolint` added, every other key
unchanged and in order, written in its own format. The 14 modules regenerated; `tools/fs131_lp1_nolint_diff.py HEAD`
(line-by-line against the commit before): **`NOLINT-DIFF OK` — 14 files, 25 entries met (1 merged into an attribute
block: `Spectral.norm_char`'s `@[simp]`), 0 unexplained** — 25 comment lines, 24 attribute lines, one keyword line
changed by the merge; its plant (one attribute line changed by one character; a stray line added to another module):
both reported, `NOLINT-DIFF FAILED`, exit 1. Then `--check` on all 31: **CHECK OK**; `--parse-all`: PARSE OK;
`--self-test` with the tables: **23 plants refused and 9 partners accepted**.

**6.5 From the kernel's side.** The build (`./scripts/build.sh`, `--mem 10 --cpus 4`, `MEMMAX=10G BATCH=8`): **OK — 253 of 253
batches, 31 module(s) rebuilt, 0 module(s) with warnings, 10m15s** (`nolint/build2.log`). Then, each against its dump
before the change: lanes A–C's 25 modules by FS131-IPD1's module dumper (every constant, its raw stored type and its
value's hash; `nolint/dump25.sh`): **1,777 constants, byte-identical**; lane D's print at this pin: **sha256 `43aa2be5…`,
byte-identical** (524 constants, full and erased prints); the stage-1 dumper (541 constants of `Outside/OAI158`, its
downstream, `Collapse`, `BorelTransfer`): **byte-identical**. No stored type and no value moved.

**6.6 The lint.** `lake lint --no-build -- --no-build --trace` under the slot: **exit 0, `-- Linting passed for Proofs.`,
14 linters each `(2/2) Passed!`** (`nolint/lint.log`). Its planted control again (`data/fs131/lp1/lint-plant.sh`, the
plant in `Plane/LebesgueNumber`, outside the port): **`LINT CONTROL FIRED: exit 1, the plant named`** — `synTaut` and
`unusedArguments` each `Failed with 1 messages`, both the plant's, nothing else; the module restored byte for byte
(`nolint/lint-plant-run2.out`, `lint-plant.log`).

## Stage 7 — SAVED (FS131-LP1): the full gate on one commit — `75a0035f1` — green on its first pass

One pass ran every step in order, one at a time, under the slot (`data/fs131/lp1/run-gate.sh final e928d4aa2 8`, launched
from a snapshot copy, `build/lp1/run-gate-snapshot.sh`). Every log is under `data/fs131/lp1/gate/` with its exit status
on its last line; `run-pass-final.out` holds every step's exit, `measure-final.txt` every step's wall time and memory
(the scope's charged peak and the largest process's resident set, by FS131-LJ1's `in-scope.sh`), and
`run-gate-final.head` the commit, **`75a0035f1daa5d7955b9a119acb170b40b830b07`**, with **no tracked file modified at its
start**. **Every step exited 0 but the one planted control that must exit 1** (the scan difference's plants). After the
pass one tracked file had changed: `data/fs131/lp1/readback/laneD/HereDumpFile.err`, the memory tool's admission line
written by the pass's own `dump-here` step. It is committed with this stage. Every count below is read from the saved
logs.

| step | result, read from its saved log (`data/fs131/lp1/gate/<step>-final.*`) | wall | peak / max-rss |
|---|---|---|---|
| build (`BATCH=8`, `--mem 10 --cpus 4`) | "build: OK — 253 of 253 batches, 2 module(s) rebuilt, 0 module(s) with warnings, 7m1s" (`Plane/LebesgueNumber`, restored after the lint's control, and the root); the one log line holding "warning" is that sentence; Lake's full log has 0; then `lake build --no-build Proofs`: "All targets up-to-date (6177 jobs)" | 535 s (slot wait included) | its batches are sibling scopes |
| `sorry` | the narrow pattern over `Proofs/` and `Proofs.lean`: **0** lines; `\bsorry\b`: 55, every one prose (41 the port's headers' "no axiom, no `sorry`"); the search's plant fired before the pass (`data/fs131/lp1/sorry-plant.out`) | — | — |
| `axiom` lines in `Proofs/` | 3 line-initial: the two axioms and one line of a docstring's code block (4 on `main`: the third axiom is gone) | — | — |
| doubled names, before the audit | "dupnames: OK — no name is declared by two modules (26 generated on demand)"; its self-test "OK — all 15 controls behaved" | 4.5 s; 23 s | 0.53 / 4.46 GiB; 0.64 / 1.53 |
| axioms | "audited: 9024 records — **8961 clean** on the standard axioms, **32 axiom-free**, **26 imported** (resting on a declared outside theorem), **5 declared purchase(s)**"; "declared imports (2): HadwigerNelson.StandingFive.kloosterman_bound, HadwigerNelson.Outside.OAI158.no_proper_five_coloring"; "axioms: OK"; `CLAUDE.md` § Trust ledger flagged stale, "7531 clean → 8961, 38 imported → 26" (draft 1) | 9.8 s | 1.15 / 4.97 |
| its self-test | "axioms self-test: OK — every planted fault fired, and every partner passed" (23 of 23; its three state-reading controls moved at stage 4 after being seen red) | 216 s | 1.43 / 5.21 |
| the records check (`tools/fs131_lp1_records.py`) | "records: PASS": the transfer and its twelve former consumers under CLEAN on exactly the three; no record rests on it, no DECLARED IMPORT names it; IMPORTED 26 = 20 + 6; 9,024 records, none twice; its five plants each "FAILED (as it must)" | 0.1 s | — |
| the registration; the generator | `REGISTER-CHECK OK: 32 modules, 32 rows, 1422 generated records and 12 moved`; `--check` on the 31 modules **CHECK OK**; `--parse-all` PARSE OK; `--self-test` "23 plants refused and 9 partners accepted" | 5.6 s; 0.8 s; 6.7 s | — |
| vacuity | "scanned: **declarations=17785 refutations-skipped=232**"; "sites: **sites=1454 vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2**"; "vacuity: OK"; the baseline's header "match (9 of 9 compared)"; `CLAUDE.md` § The gate flagged stale, "declarations 16125 → 17785, refutations-skipped 228 → 232" (draft 2) | 129 s | 0.61 / 4.62 |
| the scan against the last landing's, row for row (`tools/fs131_l5_vacdiff.py`) | "by module: declarations +1660, refutations +4: equal to the scans difference"; "vacdiff: PASS"; its plants "vacdiff: FAIL (5)", exit 1, as they must | 0.1 s | — |
| its self-test | "OK — all 65 controls behaved: every one fired, and the silent ones stayed silent." | 144 s | 0.61 / 4.62 |
| assumptions | "assumptions: OK — 2 outside theorem(s) as axioms, with **27** theorem(s) resting on them; 19 named and 14 inline hypotheses (7 outside, 21 ours, 5 open), taken by 102 statement(s) and mentioned by 1"; the ledger's header "match (9 of 9 compared)"; `CLAUDE.md` § Trust ledger flagged stale, "axioms 3 → 2, rests 39 → 27" (draft 3) | 128 s | 0.67 / 4.68 |
| its self-test | "OK — all 33 checks behaved: every planted fault fired, and every partner stayed silent." | 132 s | 0.70 / 4.72 |
| architecture | "RESULT: PASS" | 4.5 s | — |
| guarded lint (`lake lint --no-build -- --no-build --trace`, `--mem 8`) | exit 0, "-- Linting passed for Proofs.", 14 linters each "(2/2) Passed!"; its control red outside the port before the pass (stage 6.6) | 15 s | 1.10 / 5.08 |
| notes, as the last landing ran them | "notes read: 196 LOCAL-SAID=31 NO-OBJECT=48 NONE-SAID=59 no-conflict=58", `main`'s count; "self-test: OK (6 controls, 1 planted)" | 4.4 s | — |
| the stored statements (541 constants of `Outside/OAI158`, its downstream, `Collapse`, `BorelTransfer`) | "statements: BYTE-IDENTICAL to the dump made before any edit (541 constants)"; its plant DIFFERS | 81 s | 1.70 / 5.54 |
| the four edited files in text, block comments removed, against `c7122cf10` | "SAME" four times; the plant "DIFFERS" four times | — | — |
| lane D's print here, then the evidence and the read-back across pins | the print `DONE 524`; "EVIDENCE OK: 2 receipt lines"; its control "CONTROL OK: every plant refused"; **"constants: 524 failing: 0 fatal: 0 — READBACK OK"** (streaming, `--mem 8`) | 351 s; 7.5 s; 66 s | —; —; 4.03 / 4.03 |
| the baseline and the scans' sources against `main`'s | baseline entries unchanged (2); lines that differ: `scripts/Axioms.lean` 1,508 (FS131-IPD1's registration: 1,422 records and the twelve moved), `scripts/axioms-controls.txt` 30, `scripts/assumptions-ledger.txt` 14, `scripts/vacuity-baseline.txt` 2; every other script and the scans' own sources 0 | — | — |
| the three digests against FS131-LJ1's receipts (`data/fs131/lj1/gate/receipt-*-final.log`) | **axioms**: 1,422 rows added, 0 removed, 12 changed (each `IMPORTED […, proper_to_borel_weak] → CLEAN [propext, Classical.choice, Quot.sound]`); stale: `CLAUDE.md` § Trust ledger's "7531 clean … 38 imported". **vacuity**: "counts: declarations 16125 → 17785, refutations-skipped 228 → 232", "rows: none changed"; stale: `CLAUDE.md` § The gate's count line. **assumptions**: `AXIOM … proper_to_borel_weak` and its twelve `RESTS` rows removed, none added; "axioms 3 → 2, rests 39 → 27" (and the scan's own constants and hypotheses up by the port); stale: `CLAUDE.md` § Trust ledger's nine counts | — | — |

**The brief's prediction, against the gate**: the audit 9,024 records — 8,961 clean, 32 axiom-free, 26 imported, 5
purchases — with 2 declared imports and 2 library axioms; `axioms=2 rests=27`, the other seven unchanged;
`declarations=17785 refutations-skipped=232` with no new site. **Met, each count.**

**Read aloud against the informal claim** (stage 5 in full). The claim of this landing: `[OAIMath2026]`'s transfer —
a proper `k`-colouring of the plane gives a Borel one proper at almost every unit pair — is a theorem of this library,
its proof the release's, checked by this kernel, so that `χ(ℝ²) = χ_m⁰(ℝ²)`, `7 ≤ χ(ℝ²) ⟺ lim µ₆(ε) < 1`, `χ(ℝ²) =
χ_m(ℝ²)` and the disc criterion's half toward seven rest on the standard three. What the gate shows: no `axiom` and no
`sorry` enters `Proofs/`; the library declares two axioms, neither the transfer; the transfer and its twelve consumers
are audited on exactly the three; no name is declared twice, so each printed list is the list of the proof the kernel
checked; the stored statement is the release's term for term, read across the pins; no stored statement of the
library moved between the build before this landing and this commit. **What the gate does not show, and this record
says**: that the ported proofs are read (they are compiled, not read); that the release's own mathematics is right
beyond what its Lean proves (the kernel checks the proofs of exactly these statements); that anything here is new.
None of it is this project's mathematics.

## Drafts for the front page (FS131-LP1)

*For the coordinator to file; this job files none of them. Each draft names its slot: the file, the section, and **the
exact words on `main` it replaces or follows**; `data/fs131/lp1/drafts-slots.py` checks that each slot occurs exactly
once on `main` (output `drafts-slots.out`: 24 slots, each once; the control string absent). Each count names the log
line it comes from; the gated commit and its logs are in stage 7 (`data/fs131/lp1/gate/*-final.*`; the scans' full
outputs `receipt-axioms-final.log`, `receipt-vacuity-final.log`, `receipt-assumptions-final.log`). **Whose it is**: the
transfer `proper_to_borel_weak` and every ported proof are `[OAIMath2026]`'s (family 158, the release's Lean at commit
`adc7f124`); the port — the generator, the tables, the adaptations, the ruled statement changes, the read-back across
pins, the `nolint` lines — and the kernel check at this pin are this project's. Nothing here moves a value.*

**1. `CLAUDE.md` § Trust ledger, the audit's sentence.** *Replaces* "the current audit reads 7531 clean and 5 declared
purchases, and 38 imported (and 28 axiom-free; 7,602 records at the landing of FS-131's three-and-four-colours line,
FS131-LJ1, 2026-10-14)". From `axioms-final.log`, "audited: 9024 records — 8961 clean on the standard axioms, 32
axiom-free, 26 imported (resting on a declared outside theorem), 5 declared purchase(s)":

> the current audit reads 8961 clean and 5 declared purchases, and 26 imported (and 32 axiom-free; 9,024 records at the
> landing of the port of `[OAIMath2026]`'s transfer proof, FS131-LP1, 2026-10-14)

7,602 + 1,422 = 9,024 (the 31 generated modules' records, FS131-IPD1's registration); clean 7,531 + 12 (the transfer's
former consumers) + 1,418 = 8,961; axiom-free 28 + 4 = 32 (four generated records); imported 38 − 12 = 26.

**1b. The same paragraph, the declared imports.** *Replaces* "The library declares three outside axioms: … run again at
the landing on the module as recompiled there);" (the whole run of the slot) *by*

> The library declares two outside axioms: `StandingFive.kloosterman_bound` — Weil's bound for Kloosterman sums,
> `[Weil1948]` p. 207, read against its page by two readers — with twenty imported records (twelve of them the
> three-colour criterion's and row 99's, FS131-LJ1); and, from `[OAIMath2026]` family 158, a Lean development built and
> audited here at its own pin, `Outside.OAI158.no_proper_five_coloring` — no map `ℂ → Fin 5` separates every unit pair —
> with six; no record rests on both, and the second is the release's stored statement term for term
> (`tools/fs132_i1_readback.py`, run again at the landing on the module as recompiled there). The release's transfer
> `Outside.OAI158.proper_to_borel_weak` — a proper `k`-colouring of the plane gives a Borel one proper at almost every
> unit pair — is no longer an import: it is the release's theorem with its proof ported (31 modules generated whole from
> the release's files, `Outside/OAI158Basic` … `OAI158BorelTransfer`; FS131-KO1 to FS131-IPD1), every proof checked by
> this kernel at this pin on the standard three; its stored statement is the release's term for term and the deleted
> axiom's (FS131-LP1's read-back across pins; FS131-IPD1's switch), and the twelve records that rested on it are clean
> (three of them FS-131's: `χ(ℝ²) = χ_m(ℝ²)`, the Lebesgue-measurable chromatic number, in two forms and colour by
> colour, `Plane/LebesgueNumber`);

From `axioms-final.log`, "declared imports (2): HadwigerNelson.StandingFive.kloosterman_bound,
HadwigerNelson.Outside.OAI158.no_proper_five_coloring"; `records-final.txt`, "IMPORTED: 26 records, 20 on Weil's bound
alone, 6 on the five-colour theorem alone" and "the twelve records that rested on it, each under CLEAN on exactly the
three (12 of 12)".

**1c. The same paragraph, the palette lemmas.** *Replaces* "kernel-checked at this pin on the standard three, and rest
on neither declared outside theorem;" *by* "kernel-checked at this pin on the standard three, and rest on no declared
outside theorem;" (one of the two is gone).

**2. `CLAUDE.md` § The gate, the vacuity scan's counts.** *Replaces* "`declarations=16125 refutations-skipped=228
sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`." From `vacuity-final.log`, "scanned:
declarations=17785 refutations-skipped=232" and "sites: sites=1454 vacuous=0 stale=0 declared=3 witnessed=38
generic=1411 unknown=2":

> `declarations=17785 refutations-skipped=232 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`.

Two counts move: declarations +1,660 (the port's), refutations +4 (stage 4.3 names them: the release's own steps
inside proofs by contradiction). No site is added: the scan does not track the release's structures. The baseline's
header is refiled on the branch.

**3. `CLAUDE.md` § Trust ledger, the nine counts.** *Replaces* "`axioms=3 rests=39 named=19 inline=14 outside=7
ours=21 open=5 takes=102 mentions=1` — three outside theorems declared as axioms, with thirty-nine theorems resting on
them;" *by* (from `receipt-assumptions-final.log`, its `=== TOTALS ===` line, "axioms=2 rests=27 named=19 inline=14
outside=7 ours=21 open=5 takes=102 mentions=1")

> `axioms=2 rests=27 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1` — two outside theorems declared
> as axioms, with twenty-seven theorems resting on them;

**3b.** *Follows* "now the theorem `ThreeFourColours.localBound_le_chromaticNumber_of_le_four`, which rests on Weil's
bound)." *with* " One outside theorem has left the axioms since: at FS131-LP1, 2026-10-14, the transfer
`Outside.OAI158.proper_to_borel_weak`, now `[OAIMath2026]`'s theorem with its proof ported, and its twelve `RESTS` rows
with it." Two of the nine move (`axioms` 3 → 2, `rests` 39 → 27); the ledger is rewritten on the branch by the script
(`--write-ledger`: twelve rows lost, none gained, 130 rows).

**4. `tools/claude_md_fact_audit.py`, `GATE_CHANGES`.** One entry after `(("7447", "5"), ("7531", "5")):`'s:

```python
    (("7531", "5"), ("8961", "5")): "FS-131, the landing of the port of [OAIMath2026]'s transfer proof — the release's theorem proper_to_borel_weak (a proper k-colouring of the plane gives a Borel one proper at almost every unit pair) with its proof ported whole, 31 generated modules, every proof checked by this kernel at v4.32.0; the axiom of that name deleted, its twelve records clean (chi(R^2) = chi_m0(R^2), 7 <= chi(R^2) iff lim mu_6 < 1, chi(R^2) = chi_m(R^2), the disc criterion's half toward seven); the mathematics [OAIMath2026]'s, the port and the kernel check ours (FS131-LP1; copy data/fs131/lp1/gate/receipt-axioms-final.log, gated commit 75a0035f1): 9,024 records, 8,961 clean, 32 axiom-free, 26 imported, 5 purchases",
```

**4b. The same file's table of superseded counts.** Every token the drafts retire, in that table's form, each with its
value as the reason: `"7531"` (8961 clean); `"7,602"` and `"7602"` (9,024 records); `"38 imported"` (26 imported);
`"28 axiom-free"` (32); `"declarations=16125"`, `"16125"`, `"refutations-skipped=228"` and `"declarations=16125
refutations-skipped=228 sites=1454"` (17785, 232); `"axioms=3 rests=39"`, `"rests=39"` (27) and `"axioms=3 rests=39
named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1"` (the new nine); `"three outside theorems declared as
axioms"` (two); `"thirty-nine theorems resting"` (twenty-seven); `"three outside axioms"` (two). The reason for each:
"superseded gate count, refiled at FS131-LP1's landing from data/fs131/lp1/gate/receipt-axioms-final.log (the vacuity
count from receipt-vacuity-final.log, the assumption counts from receipt-assumptions-final.log); the old count stays in
data/fs131/lj1/gate/ and in GATE_CHANGES". **The next landing's previous receipts are
`data/fs131/lp1/gate/receipt-{axioms,vacuity,assumptions}-final.log`.**

**5. `CLAUDE.md` § The mission, row D.** *Replaces* "in this library a theorem on the second declared outside theorem,
`Outside.OAI158.proper_to_borel_weak`:" *by* "in this library a theorem on the standard three axioms, through
`[OAIMath2026]`'s transfer `Outside.OAI158.proper_to_borel_weak`, its proof ported and checked by this kernel
(FS131-LP1):". (The row's "This library holds `6 ≤ χ(ℝ²) ≤ 7` on one declared outside theorem" stands: that one is
`no_proper_five_coloring`.)

**6. `CLAUDE.md` § Where the problem stands, the measurable number.** *Replaces* "kernel-checked from the declared
outside theorem `Outside.OAI158.proper_to_borel_weak` (the release's transfer, term for term) and this library's own
N-EASY, and row 131's criterion read for the plane itself is `seven_le_chromaticNumber_plane_iff`, on that import
alone —" *by* "kernel-checked on the standard three axioms from `Outside.OAI158.proper_to_borel_weak` — the release's
transfer, its proof ported and checked by this kernel, its stored statement the release's term for term (FS131-LP1) —
and this library's own N-EASY, and row 131's criterion read for the plane itself is
`seven_le_chromaticNumber_plane_iff`, on the standard three —".

**7. The same paragraph, the Lebesgue number.** *Replaces* "so `χ(ℝ²) = χ_m(ℝ²)` on the declared outside theorem
`Outside.OAI158.proper_to_borel_weak` (`Plane.chromaticNumber_plane_eq_chiLebesgue`; through the gate, FS131-LC1)"
*by* "so `χ(ℝ²) = χ_m(ℝ²)` on the standard three axioms (`Plane.chromaticNumber_plane_eq_chiLebesgue`; through the
gate, FS131-LC1; the transfer ported, FS131-LP1)".

**8. The same paragraph, the discs.** *Replaces* "*such a disc gives seven* is the contrapositive of `radius_down` and
rests on the declared outside theorem `Outside.OAI158.proper_to_borel_weak`. So an exclusion on a disc reaches seven
only through the transfer," *by* "*such a disc gives seven* is the contrapositive of `radius_down` and rests on the
standard three axioms, through the release's transfer `Outside.OAI158.proper_to_borel_weak`, ported (FS131-LP1). So an
exclusion on a disc reaches seven only through the transfer — `[OAIMath2026]`'s theorem —,".

**9. § Frontier, Open milestones, FS-124's disc criterion.** *Replaces* "the half toward six on the standard three
axioms and the half toward seven on the declared outside theorem `Outside.OAI158.proper_to_borel_weak`;" *by* "both
halves on the standard three axioms, the half toward seven through `[OAIMath2026]`'s transfer
`Outside.OAI158.proper_to_borel_weak`, ported (FS131-LP1);".

**10a. § The aim, item 5.** *Replaces* "toward seven over the outside theorem on Borel transfer (row 161; [kernel] since
FS124-L1)" *by* "toward seven through the release's Borel transfer (row 161; [kernel] since FS124-L1, on the standard
three since its proof was ported, FS131-LP1)".

**10b. § Where the problem stands, item 31.** *Replaces* "the direction toward seven over the outside theorem on Borel
transfer (row 161, [kernel] since FS124-L1)" *by* "the direction toward seven through the release's Borel transfer (row
161, [kernel] since FS124-L1, on the standard three since FS131-LP1)".

**11. § Frontier, Open milestones, the frontier's ground.** *Replaces* "in this library since FS132-L1, each
kernel-checked from one declared outside theorem (`Outside/OAI158`)." *by* "in this library since FS132-L1 — the first
kernel-checked from one declared outside theorem (`Outside.OAI158.no_proper_five_coloring`), the second on the standard
three axioms since the transfer's proof was ported (FS131-LP1)."

**12. § Frontier, Last filed.** *Replaces* "Last filed: **the landing of FS-131's three-and-four-colours line**
(FS131-LJ1, 2026-10-14:" *by* "Last filed: **the landing of the port of `[OAIMath2026]`'s transfer proof** (FS131-LP1,
2026-10-14: the release's `proper_to_borel_weak` a theorem of this library, its proof ported whole — 31 generated
modules, 1,422 records on the standard three; the axiom deleted, the library's outside axioms three → two; `χ(ℝ²) =
χ_m⁰(ℝ²)`, `7 ≤ χ(ℝ²) ⟺ lim µ₆(ε) < 1`, `χ(ℝ²) = χ_m(ℝ²)` and the disc criterion's half toward seven on the standard
three; the stored statement the release's term for term; other people's mathematics, ported; no value moved); before
it **the landing of FS-131's three-and-four-colours line** (FS131-LJ1, 2026-10-14:". The later clause of the same line,
FS131-LC1's "on the declared outside theorem `Outside.OAI158.proper_to_borel_weak`", is history true at that landing;
it may stay.

**13. `ARCHITECTURE.md` § Trust, Imported outside theorems.** The row whose head is "| `Outside.OAI158.proper_to_borel_weak`
(`Outside/OAI158`) | `[OAIMath2026]` family 158, `lean/OAI/Geometry/PlaneColoring/BorelTransfer.lean` lines 436–437 at
commit `adc7f124`" *removed*; and "Three at present." *replaced by* "Two at present. The third, `Outside.OAI158.proper_to_borel_weak`
(`[OAIMath2026]` family 158), is no longer a purchase: the release's theorem, its proof ported whole into
`Outside/OAI158Basic` … `OAI158BorelTransfer` (FS131-KO1 to FS131-IPD1; the switch deleted the axiom) and its twelve
records clean since FS131-LP1."

**14. `LEAN.md`** — the port's classes, from the four records (the plan's F1 and F2, FS131-IPA1's, FS131-IPB1's,
FS131-IPD1's (a)–(d), and this job's).
- *(a) § Assumptions, following* "scoping changes no stored term, so the read-back prints the same bytes.":
  *"**A port of the release's whole proof** (`Outside/OAI158Basic` … `OAI158BorelTransfer`, FS131-KO1 to FS131-LP1)
  copies whole files: a cone computed from the source's compiled constants misses what a proof uses only definitionally
  (an `rfl` lemma a `simp` rewrites with leaves no constant in the term), so where the cone's files import nothing outside
  it the files are copied whole and the cone checks that nothing it names is missed. Its tables name, each entry with its
  reason and its mechanical check in the read-back: **renames** and **proof patches** (never in a statement or a
  definition); **adaptations** — a release-internal statement or definition whose Mathlib API changed between the pins
  (`Measure.map`, `ProbabilityMeasure.map` between v4.32.0 and v4.34.1) rewritten to name the same object by inserting a
  closed measurability argument, never a hypothesis or a binder, or in a definition's value the release's own instance
  named with the `Prop` it asks proved explicitly (`CommutingSpectral.algebra_commRing`); flagged ADAPTED, checked to
  differ from the source's print only by the inserted argument; **ruled statement changes** — exactly the release's own
  section variables as binders where the statement as written is false at this pin
  (`DifferenceFourier.differenceLaw_probability`), and **the cascade** of that change to every declaration whose type
  names the changed definition (`CosetCenter.Embedding.frequencyLaw`, `center`; a dropped `omit … in` listed), each
  checked by stripping exactly those binders; **`nolint`** — an environment linter silenced on one declaration, by name,
  in the file, with its reason class (the release's name, the release's binder, or simp's normal form of the release's
  lemma; `@[nolint …]` merged into an existing attribute block where there is one). Every class is refused on the
  target statements, on a declaration another branch holds a copy of, and on anything a statement of ours names. **Pin
  differences** — a Mathlib definition whose stored form changed between the pins without changing what it names
  (`Monoid`'s parents, `Finset.HasAntidiagonal`'s class parameter, `eLpNorm`/`MemLp`/`Lp`, `Algebra.algebraMap`'s
  instance path, `Polynomial.coeff`'s type, `Filter.EventuallyEqSet`) — are patched nowhere: the read-back
  (`tools/fs131_ipa1_readback_port.py`) has a named rule for each with planted controls (PIN-DIFFERENCE, CLASS_PARAMS,
  COEFF, EQSET), and a release-own constant in an instance argument is accepted only with a kernel check at this pin
  that the two instance terms agree by `rfl`, its non-agreeing plant refused (INSTANCE_EVIDENCE, `generator_unitary`);
  a target may read up to Mathlib's instances only with its stored type IDENTICAL to the axiom it replaces
  (TARGET_IN_LIBRARY, `Spectral.residual_fourier`) (FS131-KO1, FS131-IPA1, FS131-IPB1, FS131-IPD1, FS131-LP1)."*
- *(b) § Searching — Lean, following* "(`data/fs131/kj1/copy_build.sh`, FS131-KJ1; inventory item 694's condition).":
  - *"Between Mathlib `v4.32.0` and `v4.34.1` `Measure.map` changed: at `v4.32.0` the push-forward by a map that is not
    almost-everywhere measurable is `0`, at `v4.34.1` a measure of the same mass; and `ProbabilityMeasure.map (ν) {f}
    (f_aemble : AEMeasurable f ν)` there takes only `(f)`. A text written at the later pin names the same object here as
    `ν.map (f := g) h` and `⟨μ.map g, isProbabilityMeasure_map h⟩` (FS131-KO1)."*
  - *"Importing `Mathlib.Order.CompletePartialOrder` reroutes the `SupSet` of a `⨆` in a complete lattice through
    `CompletePartialOrder.toSupSet`: four stored statements of this library moved, instance arguments only, when a
    module saw it; a port leaves it out of its imports (FS131-IE1, FS131-KO1)."*
  - *"`convert h using 1` can leave two goals at the pin where the source's pin left one; run the source's closing
    tactic with `all_goals` (FS132-I2, FS131-KO1). `isAlgebraic_natCast` is `isAlgebraic_nat` at the pin."*
  - *"`#eval` holds what it prints in a captured stdout and emits it at the end, so a dump of hundreds of MB never
    finishes: re-point stdout at a file for the loop (`IO.setStdout (IO.FS.Stream.ofHandle h)`;
    `data/fs131/ipd1/readback/laneD/ReleaseDumpFile.lean`). A definition's value printed as a tree can be millions of
    nodes (`LabelModel.representation`: 5.5 million) (FS131-IPD1)."*
  - *"A private declaration of another module is nameable in a `section` that opens it with Batteries' `open private
    <name> from <module>`; `#print axioms` then prints its full private name (`scripts/Axioms.lean`'s port block;
    FS131-IPD1)."*
  - *"A declaration takes one attribute block: `@[a]` on one line and `@[b]` before the keyword on the next does not
    parse; merge (`@[nolint simpNF, simp]`). `@[nolint <linter>]` attaches to an anonymous instance, and the linter's name
    must be declared where the attribute is elaborated (`data/fs131/lp1/nolint/probes/attrs.lean`; FS131-LP1)."*
- *(c) § Building, following* "and the manifest is then what shows that no copied file has been rewritten.": *"A module
  whose upstream must change before it can elaborate (a port whose name an upstream axiom holds) is elaborated in a
  symbolic copy of the compiled library (`cp -as` of `.lake/build/lib/lean/Proofs`), each module compiled there written
  over its link after the link is removed, and the copied-from `.olean`s checked unchanged by hash
  (`data/fs131/ipd1/farm2-run.sh`, FS131-IPD1; `data/fs131/lp1/advalue-run.sh`, FS131-LP1)."*
- *(d) § The gate, following* "an unused anonymous instance binder is, and the build's own linters do not warn about
  it.": *"A port's own text meets the linters as the source wrote it: 25 findings in the release's family 158 (its
  names with underscores, its unused binders, one `@[simp]` lemma simp rewrites) are silenced in the file by the
  generator's `nolint` table, each by name with its reason class, and the lint's planted control is run again outside
  the port after (FS131-LP1). A read-back across pins whose prints run to gigabytes is read block by block, never whole
  (`ruled_compare_stream`, within 8 GiB where the whole read took 20), its equivalence with the whole read shown on
  every small label and its self-test planted into the stream; a planted control whose failure cannot be reached on a
  label (a rule idle there) is reported UNREACHABLE with the count that shows it, never counted as passing
  (FS131-LP1)."*

**15. `BIBLIOGRAPHY.md`, `[OAIMath2026]`'s row.**
- *(a) What rests on it, replaces* "Imported by FS132-I1 and landed by FS132-L1 as two declared outside theorems
  (`Outside/OAI158`: `no_proper_five_coloring`, `proper_to_borel_weak`), on which ten records of the library rest, five
  each;" *by* "Imported by FS132-I1 and landed by FS132-L1 as two declared outside theorems (`Outside/OAI158`); one
  remains, `no_proper_five_coloring`, with six records; the other, the transfer `proper_to_borel_weak`, is the release's
  theorem with its proof ported since FS131-IPD1's switch and FS131-LP1's landing, and its twelve records are clean;".
- *(b) Its reading, replaces* "rest on the imported `proper_to_borel_weak`, `Plane.radius_five` on the imported
  `no_proper_five_coloring`; nine and six records of the audit rest on the two." *by* "go through the transfer
  `proper_to_borel_weak`, `Plane.radius_five` on the imported `no_proper_five_coloring`. **The transfer's proof, ported
  whole** (FS131-KO1 to FS131-LP1): 31 files of `lean/OAI/Geometry/PlaneColoring/` and `lean/OAI/Analysis/PlaneSpectrum/`
  at commit `adc7f124` — 1,299 source declarations, 12,005 lines of declarations (15,964 with scaffolding) — generated
  into `Outside/OAI158Basic` … `OAI158BorelTransfer` by `tools/fs131_ko1_port.py`, every proof checked by this kernel at
  v4.32.0, each module's header the notice of change and the licence beside them. Read for the port: every copied
  declaration as text (by the generator), the stored statements against the release's across the pins (the read-backs
  of FS131-IPA1, FS131-IPB1, FS131-IPD1, and lane D's at FS131-LP1: READBACK OK, 524 constants), the transfer's
  statement by eye term for term (FS131-LP1 stage 5); the proofs compiled, not read."

## Open gate items at this landing

*Each named, with what would close it; none of them is a red check of this gate.*

1. **The density equality's join** (plan § 4.5, steps 1–9). Step 0 is FS131-IPD1's (54 IDENTICAL, 3 up to proof
   arguments, ruled). On `fs133-wb1`, `Spectral.residual_fourier` is still an axiom; this landing's evidence that the
   ported theorem's stored type is that axiom's (stage 2's IN-LIBRARY receipt) is what the join reads. Owed to that
   landing.
2. **`lean4checker`** (the publication gate, `LEAN.md` § Trust ledger) has not been run over the port's 31 modules.
3. **The comparator's whole-print path** (`ruled_compare`, `self_test`) is kept as the streaming reader's oracle and as
   `--self-test-inmemory`. On lane D it needs 20 GiB; nothing calls it there.
4. **Lane D's prints are not committed** (1.42 and 1.45 GB). `data/fs131/lp1/dump-laneD.sh` reproduces them, and their
   sha256 are in `prints.sha256`. The tree has them now, and the hand-back deletes them.
5. **ADAPTED_VALUE accepts a value that differs only in instance arguments.** That is its ruling: such a value reads
   UP-TO-INSTANCES, and the record of instance constants is what refuses a new constant there (stage 2.6). A rule that
   compared the full value would need a new ruling.
6. **The generator's textual statement guard** (item 763's tool defect) still stands. The read-back across pins is the
   per-module gate for it, and it reads OK.
7. **`scripts/Vacuity.lean` line 561** (inside FS132-L1's history paragraph) still says "the imported
   `proper_to_borel_weak`". That is history, and the file is not this brief's.
8. **Owed elsewhere, from item 759:** the correction to `plans/EXT-OAI1-audit.md` § The pieces to adopt ("about 16,600
   lines" → 12,005 lines of declarations, 15,964 with scaffolding). Item 758 asked whether the trial's generated
   copies under `data/fs131/ko1/trial/generated/` stay; they are untouched here.
9. **`hexShell_plane5`'s classing** (the tooling job's question since FS132-L1) is unchanged by this landing.

## Stage 8 — SAVED (FS131-LP1): the green line, and where the branch stands

- **The gated commit is `75a0035f1`**, on `fs131-wlp` in `.claude/worktrees/fs132-wi1`; this stage's commit adds only
  records (this file, `data/fs131/lp1/`, the report) and the one log the pass rewrote. Nothing is pushed (the brief:
  the server is unreachable); the merge into `main` is the coordinator's. The tree's `.lake/build` is the gated build
  (the pass's `lake build --no-build`: up to date), kept for that merge.
- **Sent to the coordinator**: the lint's 25 findings on the port (ruled, Amendment 1); the green line.
- **No process of this job is running or queued** (the self-test, queue and gate groups checked gone; no `lp1` slot in
  the ledger). Deleted at the hand-back, each reproducible by its committed script and named by its committed sha256:
  lane D's two prints (1.42 and 1.45 GB, `dump-laneD.sh`), the level-one prints (their `.xz` committed), the stored-
  statement dumps (`stmt/before.out.xz` committed; `after` by sha256), the 25-module dump after (sha256), and the scratch
  farm and the gate's snapshot under `build/lp1/`.
