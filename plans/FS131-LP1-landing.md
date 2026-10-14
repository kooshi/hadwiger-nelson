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
