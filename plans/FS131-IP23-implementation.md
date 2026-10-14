# FS131-IP23 — the five-colour chain's ports P2 and P3 (`[OAIMath2026]` family 015's ergodic decomposition and generating-sequence theorem), and the two leaves they close

*The implementer's record (de Bruijn, the implementer). Brief: `data/fs131/briefs/FS131-IP23-ports-p2-p3.md` (in the
coordinator's tree). Plan: `plans/FS131-KN7-chain-next.md` § Stage 4 (the trial and "What each needs at the consumer").
Worktree `fs131-wq1`, branch `fs131-wp23`, cut from `fs131-wpg` at `096f50deb`. Working files: `data/fs131/ip23/`.
Not pushed (the brief: the server is unreachable).*

## Theorems this phase proved

*Each line: the declaration, its axioms as printed from the built tree (Stage 5; build 3, Stage 6), the file. Grade:
[kernel] for every line. The informal statement each was read against is § 1.5's column.*

- `HadwigerNelson.Rigidity.ksEntropy_eq_iSup_ksEntropyOn` (T2, the entropy file's tenth leaf) —
  `[propext, Classical.choice, Quot.sound]` — `Rigidity/Entropy.lean`. Read against: "for countably generated
  sub-σ-algebras that increase and generate the whole σ-algebra, the entropy is the supremum of the entropies on them"
  (its docstring; `plans/FS100-X02D-derivation.md` l. 173), for a probability measure the map preserves.
- `HadwigerNelson.Rigidity.condExpKernel_ergodicDecomposition` (T1 in canonical form, the split's first leaf) —
  `[propext, Classical.choice, Quot.sound]` — `Rigidity/EntropySplitMax.lean`. Read against: "for a countable group
  acting on a standard Borel space and an invariant probability `μ`, the conditional-expectation kernel of `μ` on the
  invariant σ-algebra integrates to `μ`, and almost every value is ergodic" (its docstring; FS100-X02D l. 171) — the
  release's theorem, which is its proof.
- **The port: 64 declarations of `[OAIMath2026]` family 015, kernel-checked here** (the release's theorems, not ours),
  each `[propext, Classical.choice, Quot.sound]` or fewer, none axiom-free: the list is `data/fs131/ip23/port-names.txt`;
  among them `Outside.OAI015.measureEntropy_eq_iSup_generating`, `observationSigma`,
  `observationConditionalProbability_ae_eq_condExp`, `conditionalObservationEntropy_tendsto_zero`
  (`Outside/OAI015Generating`, 44), and `Outside.OAI015.action_ergodic_decomposition`, `actionInvariantSigma`,
  `ergodicSMul_of_orbit_indicator_limits`, `exists_invariant_orbit_average_limit`, `fixedPoint_mem_closed_convex_orbit`
  (`Outside/OAI015ErgodicDecomposition`, 20).
- No private helper was needed; no other leaf was touched.

## Stage 1 — SAVED: the readback, the bundles restated, the stored statements before any edit

**1.1 The branch and the build.** `git checkout -b fs131-wp23` at `096f50deb`. The tree's compiled library is current
for that commit: Lake's dry run under the slot (`lake build --no-build`, 4 GiB) prints `All targets up-to-date (6038
jobs).`, exit 0 (`data/fs131/ip23/logs/nobuild-0.log`). Laptop at the start: 31 GB of RAM, 28 available; 329 GB of disk
free (82 % used).

**1.2 The brief's quotations** (standing rule 3). `tools/fs131_ip23_readback.py` (FS131-IE1's reader aimed at this
brief; each quoted line a substring of its source, read in the coordinator's tree): **7 matched, 0 mismatched**, exit 0
(`data/fs131/ip23/readback-brief.out`) — W2 against `data/fs131/REQUEST-2026-10-13.md`; the dated line of 2026-10-14 on
NF2-LEAF-17 against `data/fs131/claims-NF2.md`; inventory items 750, 758, 763, 772 and 801 against
`plans/FS131-close-inventory.md`. With `--fault` (the last character of each quoted line changed): 0 matched, 7
mismatched, exit 1 (`readback-brief-fault.out`). **One wording note on the brief** (not a quotation): "the eleven files
of `EntropyGeneratingSupremum.lean`'s cone beyond the two already ported" — the trial's eleven files *include* the two
(KN7 § Stage 4: "the eleven files of `EntropyGeneratingSupremum.lean`'s declared cone, in import order (the first two
are lane P's `ShannonEntropy`, `EntropyMixtures`)"); the port is the **nine** beyond them, 850 lines. Read so; nothing
turns on it.

**1.3 The two bundles, restated from the trial and counted again at the clone** (`/home/kooshi/source/math`, at
`adc7f1241b42e322a6451854ab7e4b4c146bf78a`, the audited commit; read only, nothing run in it):

| bundle | files and lines | lines | KN7's count |
|---|---|---|---|
| **ErgDecomp** (P2) | `PrimePackets/KernelEntropy.lean` ll. 4–47 (44, the header: `namespace OAI`, `section`, `noncomputable section`, the `open` lines) and ll. 220–558 (339: `fixedPoint_mem_closed_convex_orbit` … `ergodicSMul_of_orbit_indicator_limits`, with the file's closing `end PrimeDegreePackets`, `end`, `end`, `end OAI`); `PrimePackets/ErgodicDecomposition.lean` ll. 4–179 (176: `condExpKernel_invariant`, `invariant_kernel_decomposition`, `condExpKernel_ae_constant`, `action_ergodic_decomposition`) | 559 | 559 ✓ |
| **Generating** (P3) | the nine files after lane P's two, in import order: `ConditionalShannon` 110, `ConditionalObservations` 135, `ObservationRefinement` 113, `ConditionalOrbitEntropy` 116, `ObservationConditionalProbability` 90, `ObservationSigmaAlgebra` 77, `ConditionalProbabilityExpectation` 60, `GeneratingObservationEntropy` 93, `EntropyGeneratingSupremum` 56 | 850 (1,843 with lane P's 993) | 850 / 1,843 ✓ |

The renames the trial needed, restated (KN7 § Stage 4's table; `tools/fs131_kn7_release_copy.py` PATCHES): in
ErgDecomp `Set.ofPred_forall` → `Set.setOf_forall`, `eventuallyEmptyOrUniv_iff` → `eventuallyConst_set`,
`Function.diag` → `(fun y => (id y, id y))` (4 uses), each inside a proof; in Generating `Set.mem_ofPred_eq` →
`Set.mem_setOf_eq` (7 uses, each in a `simp only` list). Re-made here into the ignored `build/fs131-ip23/release-copies/`
by the trial's tool (`logs/make.out`): ErgDecomp 572 lines, Generating 1,855, every bundle-specific patch matched.

**1.4 The stored statements before any edit.** `data/fs131/ip23/lean/StatementDump.lean` (FS131-IG1's dumper, aimed at
the two leaves' modules `Rigidity/Entropy` and `Rigidity/EntropySplitMax` and at every module downstream of either —
`PositiveEntropy`, `ChainAtTA`, `ZeroEntropyNames`, `Pieces` —, since the port's modules go in under `Entropy` and
`EntropySplitMax` and which instance a stored term names can depend on the imports, `LEAN.md` FS132-I1), run on the
built tree before anything was edited or recompiled: `data/fs131/ip23/statements-before.txt` (committed compressed,
`.xz`; sha256 in `statements-before.sha256`), 338 constants — `Entropy` 47, `PositiveEntropy` 4, `ChainAtTA` 55,
`ZeroEntropyNames` 112, `Pieces` 110, `EntropySplitMax` 10; one axiom, `Rigidity.positive_entropy_rigidity` (the
declared printed theorem). The reader is `tools/fs131_ip23_statements.py` (IG1's, aimed here, with the one declared axiom
required unchanged and any other refused). **Against itself:** PASS — 209 named constants (kinds and types), 48 data
definitions' values, 3 example heads (`statements-self.out`). **Its control** plants eight faults and all 8 are
reported, "the check can fail" (`statements-control.out`): the tenth leaf's stored type, `ksEntropyOn`'s value, the first
leaf missing, `Pieces`' `ksEntropy_rot_eq_iSup` (downstream), the declared axiom's type, a new public constant, a
second axiom, a leaf become a definition.

**1.5 The two leaves, in one line each, beside the plan's route.**

| leaf | the statement, in one line | the route |
|---|---|---|
| `Rigidity.ksEntropy_eq_iSup_ksEntropyOn` (`Entropy`, the tenth) | for a probability measure that `T` preserves and countably generated `𝒜 i` increasing to `m`: `ksEntropy μ T = ⨆ i, ksEntropyOn (𝒜 i) μ T` | KN7 § Stage 4: from the ported `measureEntropy_eq_iSup_generating`, with `Q n` the indicators of `A i j` for `i, j ≤ n` encoded as one label; `≥` by `ksEntropyOn_le_ksEntropy` |
| `Rigidity.condExpKernel_ergodicDecomposition` (`EntropySplitMax`, the split's first) | for a countable group acting on a standard Borel space and an invariant probability `μ`: the conditional-expectation kernel on `invariantSigma H Y` integrates to `μ`, and a.e. value is ergodic | the ported `action_ergodic_decomposition`, `actionInvariantSigma` being `invariantSigma` by its body |

## Stage 2 — SAVED: lanes P2 and P3, the port (Amendments 1 and 2)

*Elaborations in this stage are `lake env lean` (the lakefile's two `autoImplicit` options by flag) and oleans written by
`lean -o` into the tree's library for the two new modules only (`data/fs131/ip23/olean1.sh`; iteration, `LEAN.md`
§ Building); the build under the slot and the prints from the built tree are Stage 4's.*

**2.1 The scan, before any copy into `Proofs/`.** The trial's `tools/fs131_kn7_release_copy.py` (`make` into the ignored
`build/fs131-ip23/release-copies/`, then `scan` and `scan --plant` per bundle): **0 hits** in ErgDecomp (572 lines) and in
Generating (1,855), and the planted `#eval` and second import reported in each — `control FIRED` twice
(`data/fs131/ip23/logs/scan-*.out`). The generator's own scan, on exactly the lines it copies, ran at every generation
below. A grep of the bundles for what the generator refuses found `omit … in` above seven declarations of the generating
files and `@[instance_reducible]` alone on its line above `actionInvariantSigma` (KernelEntropy l. 277): the generator as
FS131-IE1 left it refuses both, and it had no line-range selection.

**2.2 The generator change** (`tools/fs131_ie1_port.py`; proposed by message with its diff, ruled twice, applied exactly
in commits of their own). **Amendment 1** (`data/fs131/ip23/generator-change.diff`, sha256 `0bc7347b…`, commit
`967a51fba`): `omit … in` lines and an attribute block alone on a line become part of the declaration below them
(copied, scanned, every patch on them refused as a patch to the statement; the address docstring goes after the
`omit` lines and before the attribute lines); a RANGES table (KernelEntropy ll. 4–47, 220–558; ErgodicDecomposition
ll. 4–179, 506–509 — the last four the file's own closing `end`s) with RANGE_DECLS, the declarations the ranges must
hold by name (16 and 4); a range that begins or ends inside a declaration, a docstring or a module docstring refused;
the two modules' rows in MODULES, MATHLIB, DROP_OPEN, IMPORT_NOTES, READBACK_NOTES, RELEASE_IMPORTS; JOB (each header
names the job that added the module); `--axioms-block <job>`, `--open-probe <job>`; 14 patches; seven self-test plants.
**Amendment 2** (`generator-change-2.diff`, sha256 `7e8297a1…`, commit `eb4e954cb`): the read-back tool and tables per
module (READBACK_TOOL) — the approved render had copied FS131-IE1's read-back sentence, a wrong address in the new
headers — and READBACK_EXTRA, one sentence in the ErgodicDecomposition header on the rule EVENTUALLYEQSET (2.5) and on
`ErgodicSMul`'s field (2.6). **In the real tree, after each:** the three IE1 modules regenerate byte-identical (`git
status` shows them unmodified; `--check` OK on the committed files: `logs/gen-check-before-generation.out`,
`gen-check.out`); the IE1 axioms block byte-identical (`logs/ie1-axioms-block-{before,after}.out`, sha256 `530ba773…`
both); `--self-test` **29 plants refused, 1 partner accepted** (`logs/gen-selftest.out`). The ranged cut was never
widened: both ranged modules elaborate inside the ranges.

**2.3 The measurement: what the port needed at this pin.**

| module | release files | lines copied | declarations | patches (each a proof line) |
|---|---|---|---|---|
| `Outside/OAI015Generating` | the nine files, whole | 850 | 44 | 8: `Set.ofPred_and` → `Set.setOf_and` (ConditionalObservations l. 25); `Set.mem_ofPred_eq` → `Set.mem_setOf_eq` (ConditionalObservations ll. 92, 102; ObservationRefinement ll. 25, 66; ObservationSigmaAlgebra ll. 24, 47; ConditionalProbabilityExpectation l. 53) |
| `Outside/OAI015ErgodicDecomposition` | KernelEntropy ll. 4–47, 220–558; ErgodicDecomposition ll. 4–179, 506–509 | 563 | 20 | 6: `Set.ofPred_forall` → `Set.setOf_forall` (KernelEntropy l. 306); `eventuallyEmptyOrUniv_iff` → `eventuallyConst_set` (l. 542); `Function.diag` → `(fun y => (id y, id y))` (ErgodicDecomposition ll. 63, 69, 114, 116) |

Generated with `import Mathlib` whole, the modules showed exactly these errors and no others (`logs/whole-1-*.log`:
`Unknown constant` / `Unknown identifier` at each token, and the failures downstream of them); with the patches, 0
errors, 0 warnings (`whole-2-*.log`). These are the trial's renames (KN7 § Stage 4) — the "*" renames of its copy tool
that fell on these files included.

**2.4 The imports and the `open` lines.** Measured as FS131-IE1 did: the `--mathlib-whole` modules compiled by `lean -o`,
then `data/fs131/ip23/lean/ImportsDump.lean` (IE1's dumper aimed at the two modules; `logs/imports-dump.log`), then the
elaboration decides. Generating: the dump lists `Mathlib.AlgebraicTopology.SimplexCategory.Basic`,
`Mathlib.Order.CompletePartialOrder`, `Mathlib.Probability.Martingale.Convergence` and `OAI015Mixtures`; kept:
`OAI015Mixtures` and `Mathlib.Probability.Martingale.Convergence`. ErgodicDecomposition: the dump lists eight; kept the
seven other than `Mathlib.Order.CompletePartialOrder` (`Algebra.Ring.IsFormallyReal`, `Dynamics.Ergodic.Action.Basic`,
`MeasureTheory.MeasurableSpace.Invariants`, `MeasureTheory.SetAlgebra`, `Probability.Kernel.Condexp`,
`Topology.EMetricSpace.Paracompact`, `Topology.Separation.CompletelyRegular`). `Mathlib.Order.CompletePartialOrder` is
left out of both, for inventory item 758's reason, and is in the closure of no kept import (`tools/fs131_ie1_closure.py`:
"lacks" for each). The `open` probe (`--open-probe FS131-IP23`; `lean/OpenProbe-*.lean`, `logs/openprobe-*.log`): none
absent for Generating; for ErgodicDecomposition `ArithmeticFunction`, `ArithmeticFunction.zeta`, `BoundingSieve`,
`FractionalIdeal`, `IsDiscreteValuationRing`, `NumberField` (DROP_OPEN). Under these, each module elaborates with **0
errors and 0 warnings** in 4–5 s (`logs/min1-OAI015Generating.log`, `min2-OAI015ErgodicDecomposition.log`, and from the
real path `elab-*.log`).

**2.5 The read-back across the two pins** (`tools/fs131_ip23_port_readback.py`, FS132-I2's comparator imported and not
edited, with this job's table; FS131-IE1's wrapper the pattern). The release's side: a scratch file under the ignored
`build/fs131-ip23/readback/` — the eleven files of the generating cone whole and the generator's RANGES of the two
partial files, under `import Mathlib`, then the dumper — elaborated at the release's pin in the audit's working copy by
`data/fs131/ip23/release-dump.sh` (`lake env lean`, 8 GiB slot, no compiled file; exit 0, `DONE 64`). This pin's side:
`data/fs131/ip23/readback/HereDump.lean` (`here-dump.sh`; exit 0, `DONE 64`). On the 64 declarations
(`logs/readback-compare.out`): **`READBACK OK` — 60 IDENTICAL, 4 UP-TO-INSTANCES, none DIFFERENT, none absent**. The
four: `observationConditionalProbability_tendsto`, `conditionalObservationEntropy_tendsto_zero`,
`measureEntropy_eq_iSup_generating` (suprema in `ℝ≥0∞` stored through `CompletePartialOrder.toSupSet` there and the
`ConditionallyComplete…` path here: item 758's dropped import, as in IE1's read-back) and `lp_convex_orbit_representative`
(`Lp`'s `AddCommGroup` path: item 772's `eLpNorm`/`MemLp`/`Lp`); the 30 constants recorded
(`readback/instance-constants.txt`). Two of the 60 are IDENTICAL **under a named rule, EVENTUALLYEQSET** (accepted by
Amendment 2 under item 772's standing word): `orbitConvexHull_aeSetIntegral` and
`invariant_set_independent_of_orbit_indicator_limit`. At v4.34.1 `s =ᵐ[μ] t` on sets is stored as
`Filter.EventuallyEqSet l s t` (a definition of its own: `EventuallyEq l (fun x => x ∈ s) (fun x => x ∈ t)`); here as
`Filter.EventuallyEq l s t`, the sets read as predicates. The kernel checks at the release's pin that the two are one
term by `rfl`, axiom-free, and refuses the control with the two sets exchanged (`lean/ReleaseEqSetRfl.lean`,
`logs/release-eqset-rfl.log`). RENAMED: `Set.ofPred` → `setOf` only. `--self-test` (`logs/readback-selftest.out`): **12
plants refused**, the unplanted pair passes — among them the rule withdrawn (exactly those two then read DIFFERENT) and a
real change under the rule (`EventuallyEqSet` made `EventuallySubset` in one statement: DIFFERENT). The prints are kept
(`readback/ReleaseDump.out`, `HereDump.out`, compressed at the stage's commit).

**2.6 A pin difference no comparison of statements can see** (the coordinator's condition (5)). `ErgodicSMul` is Mathlib's;
the statements name it and the comparator reads them IDENTICAL, but its field moved: at v4.32.0
`aeconst_of_forall_preimage_smul_ae_eq : MeasurableSet s → (∀ g, (g • ·) ⁻¹' s =ᵐ[μ] s) → Filter.EventuallyConst s (ae
μ)`; at v4.34.1 the same with `Filter.EventuallyEmptyOrUniv s (ae μ)`, where `def Filter.EventuallyEmptyOrUniv s l :=
Filter.EventuallyConst (fun x => x ∈ s) l` — one meaning ("`s` is almost empty or almost everything"). Evidence:
`#print ErgodicSMul` and `#print Filter.EventuallyEmptyOrUniv` at each pin (`lean/ErgodicSMul{Here,Release}.lean`,
`logs/pin-ErgodicSMul-{here,release}.log`). The one proof that read the field's form is patched (`eventuallyConst_set`,
the same disjuncts in the same order; KernelEntropy l. 542). Recorded in the module's header (Amendment 2).

**2.7 The port's axioms** (from the oleans written by `lean -o`; Stage 4 prints them again from the built tree):
`tools/fs131_ie1_axioms.py` (IE1's, run, not edited) on `data/fs131/ip23/port-axioms.out`
(`lean/PortAxioms.lean`, the generator's `--axioms-block FS131-IP23` under the two imports; `draft-axioms-block.lean`):
**64 records, each a subset of `[propext, Classical.choice, Quot.sound]`**, none axiom-free, none `sorryAx`; its
in-memory control reports 3 of 3 (`port-axioms-control.out`). **A planted `sorry`, compiled:** a copy of
`OAI015ErgodicDecomposition` with the proof of `actionInvariantSigma_le` replaced by `sorry`, elaborated with its
module's records (`build/fs131-ip23/planted/PlantedSorry.lean`): the checker fails and names `actionInvariantSigma_le`
and `action_ergodic_decomposition`, `['sorryAx'] beyond the standard three`, exit 1 (`logs/planted-sorry-verdict.out`).

**2.8 The map.** `ARCHITECTURE.md`: two rows after `Outside/OAI015Maximal`; `Proofs.lean`: two lines;
`tools/check_architecture.py`: PASS (`logs/arch-1.out`).

## Stage 3 — SAVED: the entropy file's tenth leaf, `ksEntropy_eq_iSup_ksEntropyOn` (T2)

*From `lake env lean` on a copy under `data/fs131/ip23/work/` against the build-1 library; the build and the kernel-side
statement check are Stage 5's.*

**The route** is the third planner's (KN7 § Stage 4, "What each needs at the consumer"), as written. `≥`:
`ksEntropyOn_le_ksEntropy` at each `i` (`𝒜 i ≤ m` from `hgen`). `≤`: for each `i`, `A i = natGeneratingSequence` of
`(X, 𝒜 i)` (`hcg i`; `MeasurableSpace.measurableSet_natGeneratingSequence`, `generateFrom_natGeneratingSequence`); the
stage-`n` observation `Q n x = equivFin (p ↦ decide (x ∈ A p.1 p.2))` over `p : Fin (n+1) × Fin (n+1)`, a label in
`Fin (card (Fin (n+1) × Fin (n+1) → Bool))`. Then: `Q n` is `𝒜 n`-measurable (`measurable_pi_lambda` with each
coordinate's two fibres `A`, `Aᶜ`, then `measurable_of_finite` for the equivalence; `A i j ∈ 𝒜 i ≤ 𝒜 n` by `hmono`);
the observation σ-algebras increase, since `Q n` factors through `Q (n+1)` (restriction along `Fin.castSucc`;
`MeasurableSpace.comap_comp`, `comap_mono`); they generate `m` (`≤` by measurability of each `Q n`; `≥` because each
`A i j` is `Q (max i j)`'s preimage of a set, `MeasurableSpace.generateFrom_le`); so the ported
`Outside.OAI015.measureEntropy_eq_iSup_generating` applies with exactly its hypotheses, after `ksEntropy_eq_measureEntropy`;
and each rate is `partitionEntropy μ T (Q n)` (`partitionEntropy_eq_ofReal_observationEntropyRate`) `≤ ksEntropyOn (𝒜 n)
μ T` (`partitionEntropy_le_ksEntropyOn`). The encoding of finitely many indicators as one label was the plan's one hard
step; nothing else needed.

**The edit to `Rigidity/Entropy.lean`:** the import `Outside/OAI015Mixtures` replaced by `Outside/OAI015Generating` (which
imports it) and the leaf's `sorry` by the proof; no other line (`diff` against the base: the import line and ll. 388–445).
No helper was needed. **Elaborated:** 0 errors, 0 warnings, no `sorry` left in the file (`logs/leaf-entropy-1.log`).
**Axioms**, the copy with `#print axioms` appended: `[propext, Classical.choice, Quot.sound]`
(`logs/leafcheck-EntropyAx.log`). **A planted fault fires:** the copy with `le_max_left` made `le_max_right` in the proof
is refused (`Application type mismatch`, exit 1; `logs/leafcheck-EntropyPlanted.log`).

## Stage 4 — SAVED: the split's first leaf, `condExpKernel_ergodicDecomposition` (T1, canonical form)

**The proof** is the ported theorem itself: `Outside.OAI015.action_ergodic_decomposition μ hp`. The release's
`actionInvariantSigma H Y` is `⨅ g : H, MeasurableSpace.invariants (fun y : Y => g • y)`, which is `invariantSigma H Y`'s
body word for word, so the two statements are one term up to unfolding the release's definition; the elaborator accepts
the release's proof term at the leaf's stated type with nothing else (the `trim` proofs agree by proof irrelevance). The
hypotheses are the release's exactly — `[Group H] [Countable H] [MulAction H Y] [MeasurableSpace Y]
[StandardBorelSpace Y] [Nonempty Y]`, a probability `μ`, each `g • ·` measure-preserving — so no binder is unread and
none is dropped. **The edit to `Rigidity/EntropySplitMax.lean`:** one import line (`Outside/OAI015ErgodicDecomposition`)
and the leaf's body (with a `--` comment saying why the term is accepted). **Elaborated:** 0 errors; the five `sorry`
warnings left are the module's other leaves, not this job's (`logs/leaf-split-1.log`). **Axioms:**
`[propext, Classical.choice, Quot.sound]` (`logs/leafcheck-SplitAx.log`). **A planted fault fires:** the release's theorem
applied at the wrong group (`H := Unit`) is refused (`Type mismatch`, exit 1; `logs/leafcheck-SplitPlanted.log`).

**The map** for both leaves: `ARCHITECTURE.md`'s rows of `Rigidity/Entropy` (state: no `sorry`; the tenth leaf proved;
imports cell `Outside/OAI015Generating`) and `Rigidity/EntropySplitMax` (5 leaves; the first proved; imports cell with
`Outside/OAI015ErgodicDecomposition`) — the imports cells are what `tools/check_architecture.py` holds against the
import graph; PASS (`logs/arch-2.out`).

## Stage 5 — SAVED: the build under the slot, and every receipt from the built tree

**5.1 Build 2** (`data/fs131/ip23/build.sh 2 8`: the slot at 10 GiB, `MEMMAX=10G BATCH=8 ./scripts/build.sh`): **exit 0**,
`250 of 250 batches, 9 module(s) rebuilt`, 8 m 05 s, peak 4.45 GiB summed, 3.59 GiB one process
(`logs/build-2.log`, `.times`, `.rss`; the full output `build/gate/build/20261014T094506Z-2501458.log`). Rebuilt: the two
ported modules (their Amendment 2 headers), `Rigidity/Entropy`, `PositiveEntropy`, `ZeroEntropyNames`, `ChainAtTA`,
`Pieces`, `EntropySplitMax`, `Proofs`. **No warning from any line this job wrote**: none from `Entropy` or the two
ported modules; `EntropySplitMax`'s five `declaration uses 'sorry'` are its other five leaves (ll. 79, 93, 101, 112,
117: `rotInv_sub_maxMultiple`, `measure_haarSet_eq_zero`, `ksEntropy_eq_zero_of_not_smul_le`,
`entropySplit_of_admissiblePair`, `not_smul_dualHaar_le_dirac_one`), not this job's. (Build 1, Stage 2, was the port
alone: exit 0, 7 m 30 s, the two modules rebuilt with no warning.)

**5.2 No statement changed, from the kernel's side.** The six modules dumped again from the built tree
(`statements-after.txt`, compressed at the commit) against Stage 1's dump: **PASS** — 209 named constants (kinds and
types), 48 data definitions' values, 3 example heads; the one declared axiom unchanged; no new public constant, no new
private constant; internal 129 and 129 (`statements-compare.out`). So neither the two proofs nor the two new import lines
moved a stored term of `Entropy`, `EntropySplitMax` or the four modules downstream of `Entropy`. **The control** on the
same pair: 8 of 8 planted faults reported, "the check can fail" (`statements-compare-control.out`). No binder was
dropped (no `--dropped` list).

**5.3 The axioms of every declaration of the two leaves' files**, printed from the built tree
(`lean/Axioms.lean`, IG1's printer aimed at the two modules; `axioms-after.txt`) and classed by
`tools/fs131_ip23_axioms.py` (`axioms-verdict.out`): **45 records, 40 CLEAN, 5 OTHER-LEAF, 0 failing; AXIOMS OK**.
`Rigidity/Entropy`: all 36 CLEAN (31 public, 4 private, plus `nameCell`'s generated record counted by the printer as
the file's) — among them **`ksEntropy_eq_iSup_ksEntropyOn`: `[propext, Classical.choice, Quot.sound]`**.
`Rigidity/EntropySplitMax`: 9 records — CLEAN `invariantSigma`, `invariantSigma_le`, `haarSet` and **
`condExpKernel_ergodicDecomposition`: `[propext, Classical.choice, Quot.sound]`**; OTHER-LEAF the five leaves not this
job's, each `sorryAx` from itself alone. The planted record (`positive_entropy_rigidity_of_polishSpace`) is read as
resting on the declared theorem. **The control**: 4 of 4 planted faults reported and the plant fired
(`axioms-control.out`) — a `sorry` in the tenth leaf, an unknown axiom, a `sorry` from a leaf outside the named five, and
the declared theorem in the first leaf.

**5.4 The port, again from the built tree.** The 64 records: all a subset of the standard three
(`port-axioms-built-verdict.out`); the print of this pin made again from the build's `.olean`s is byte-identical to
Stage 2's (`readback/HereDump.out`), and READBACK OK (`logs/readback-compare-built.out`).

**5.5 The environment linters** (`lake lint --no-build -- --no-build --trace` under a 7 GiB slot; `logs/lint-1.log`): 13 of
14 pass; **`unusedArguments` reports one declaration**, the port's `OAI015.condExpKernel_ae_constant`
(ErgodicDecomposition l. 104), whose release statement takes `[Nonempty Y]` that its proof does not read. The class is
FS131-IE1's Amendment 1 (the binder kept, the linter silenced by name in the generator's NOLINT table): proposed to the
coordinator as a third generator change (`generator-change-3.diff`, sha256 `79ff61ac…`, commit `2ab2e397f`), not applied
at this stage.

## Drafts for the landing (files this job does not write; each names its slot)

**D1 — the audit's block** (`scripts/Axioms.lean`, under CLEAN, immediately after FS131-IE1's block — that job's D1 —
or, where IE1's block is not yet filed, immediately above `#eval IO.println "=== PURCHASED ==="`): the text of
`data/fs131/ip23/draft-audit-block.lean` — 69 records: the port's 64 (generated by `tools/fs131_ie1_port.py
--axioms-block FS131-IP23`, so it can be compared again once filed), `Rigidity/Entropy`'s tenth leaf (which IE1's D1
said joins its block when proved), and `Rigidity/EntropySplitMax`'s four clean records (`invariantSigma`,
`invariantSigma_le`, `haarSet`, `condExpKernel_ergodicDecomposition`). Each is CLEAN from the built tree (5.3, 5.4,
6.x). The module's other five records rest on its own leaves' `sorry` and join when those are proved. The clean count
then rises by 69; no purchase, no import.

**D2 — `LEAN.md` § Assumptions**, after the paragraph "**An outside Lean proof may be ported instead of imported**":
- "A ported file may be copied by line ranges where its declared cone is far larger than what the wanted statement
  reads (`tools/fs131_ie1_port.py` RANGES, FS131-IP23: 563 lines of two files of `[OAIMath2026]` family 015 in place
  of a declared cone of 22,632): each range read by the whole-file parser, the declarations it holds named in
  RANGE_DECLS and checked, a range whose edge falls inside a declaration or a docstring refused. The elaboration of
  the ranged module is what shows the cut suffices; a line it needs from outside the ranges comes to the coordinator,
  never a range widened in silence."
- "A declaration's `omit … in` lines above it and an attribute block alone on its line above its keyword are part of
  its statement: the generator copies and scans them and refuses every patch on them (FS131-IP23)."
- "A read-back comparator may carry a named rule for a definition whose stored form moved between the pins while its
  meaning did not, with the kernel's `rfl` at the source's pin and a control that must be refused: EVENTUALLYEQSET
  (`s =ᵐ[μ] t` on sets is `Filter.EventuallyEqSet l s t` at v4.34.1, `Filter.EventuallyEq l s t` here;
  `tools/fs131_ip23_port_readback.py`, `data/fs131/ip23/lean/ReleaseEqSetRfl.lean`; FS131-IP23, inventory item 772's
  standing word). What no comparison of statements sees is a Mathlib definition named in a statement whose body moved:
  print it at both pins (`ErgodicSMul`, below)."

**D3 — `LEAN.md` § Searching — Lean**, new bullets at the section's end:
- "Between Mathlib v4.32.0 and v4.34.1: `ErgodicSMul`'s field is `EventuallyConst s (ae μ)` here and
  `EventuallyEmptyOrUniv s (ae μ)` there, where `EventuallyEmptyOrUniv s l := EventuallyConst (· ∈ s) l` (2026-08-25),
  so the later pin's `eventuallyEmptyOrUniv_iff` is `eventuallyConst_set` here, the same disjuncts in the same order;
  `s =ᵐ[μ] t` on sets elaborates to `Filter.EventuallyEqSet` there and to `Filter.EventuallyEq` at `Prop` here;
  `Function.diag` does not exist here, and `compProd_trim_condExpKernel` is stated with `fun ω ↦ (id ω, id ω)`; and
  `Set.ofPred_forall`, `Set.mem_ofPred_eq` are `Set.setOf_forall`, `Set.mem_setOf_eq` here (FS131-IP23;
  `data/fs131/ip23/logs/pin-ErgodicSMul-*.log`)."
- "A countably generated σ-algebra `𝒜` that is not the instance gives its generating sequence as
  `@MeasurableSpace.natGeneratingSequence X 𝒜 h`, with `@MeasurableSpace.measurableSet_natGeneratingSequence X 𝒜 h j`
  and `@MeasurableSpace.generateFrom_natGeneratingSequence X 𝒜 h`. Finitely many sets read as one `Fin` label are
  `Fintype.equivFin (ι → Bool)` applied to `p ↦ decide (x ∈ A p)` (under `classical`), measurable for any σ-algebra
  holding the sets by `measurable_pi_lambda` (the instances by `@`), `measurable_to_countable'` on each coordinate and
  `measurable_of_finite` for the equivalence. `comap Q ⊤ ≤ comap Q' ⊤` when `Q` factors through `Q'`
  (`MeasurableSpace.comap_comp`, `comap_mono le_top`), and `comap Q ⊤ ≤ m` is `measurable_iff_comap_le` of a measurable
  `Q` into `Fin k` (`Rigidity.ksEntropy_eq_iSup_ksEntropyOn`, FS131-IP23)."
- "`lean --root=<dir> -o <tree>/.lake/build/lib/lean/<Module/Path>.olean <dir>/<Module/Path>.lean`, under `lake env`,
  compiles a scratch copy kept outside `Proofs/` under its module's name, so a dumper can import a module before it is
  committed; the build later recompiles it, having no trace for it (`data/fs131/ip23/olean1.sh`; FS131-IP23)."

**D4 — the models of the two leaves' hypotheses** (for the landing's note under `LEAN.md` § The gate, "every theorem
whose hypothesis is a structure ships a named inhabitant"; none of these binders is one the vacuity scan tracks, so the
scan is expected to be silent on them; a hand reading). `ksEntropy_eq_iSup_ksEntropyOn`: `X = Bool` with `⊤` (countable,
so countably generated by Mathlib's instance for a countable type), `μ = dirac true`, `T = id` (`MeasurePreserving.id`), `𝒜 i = m` for every `i` (monotone;
`⨆ i, m = m` by `iSup_const`; countably generated as `m` is) — every clause holds at once and none is vacuous (the
measure is a probability, the map preserves it). `condExpKernel_ergodicDecomposition`: the release's hypotheses
exactly; `H` any countable group acting trivially on `Y = Bool` (the trivial action a local instance; `Bool` is standard Borel, countable and discrete), `μ = dirac true`, each `g • ·` the identity, so measure-preserving; at the
chain's use `H = Γ` acting on `Dual F` by rotations, whose instances are the chain's (a standing Borel structure on
`Dual F` is ruling (3) of item 750). No declaration in the library exhibits either model; the landing accepts this
note or asks for a named `example` per row.

**D5 — the two leaves' docstrings, now stale** (not edited: this job's touches are proofs, helpers and imports). In
`Rigidity/EntropySplitMax.lean`, `condExpKernel_ergodicDecomposition`'s docstring, the sentence "**Closed by the port at
the join** (lane P2, `plans/FS131-KN7-chain-next.md` § Stage 4: 559 release lines, three renames inside proofs)."
becomes "**Proved by the port** (lane P2, FS131-IP23): the release's theorem, `Outside.OAI015.action_ergodic_decomposition`,
is its proof, `actionInvariantSigma` being `invariantSigma` by its body."; and the module docstring's "closed by the port
(lane P2) at the join" becomes "proved by the port (lane P2, FS131-IP23)". In `Rigidity/Entropy.lean`, the § "The
reasoning surface" docstring's "Leaves: the point mass …, the limit along increasing σ-algebras
(`ksEntropy_eq_iSup_ksEntropyOn`, T2) and the mixture lemma … The last three and the pinning theorem are proved from the
release's entropy files once they are ported" becomes "Proved from the release's ported entropy files: … the limit along
increasing σ-algebras (`ksEntropy_eq_iSup_ksEntropyOn`, T2, over `Outside/OAI015Generating`, FS131-IP23) …"; the module
docstring's mention of `Outside/OAI015Mixtures` as its import stays true through `OAI015Generating`.

**D6 — a dated line for the chain's claim list** (`data/fs131/claims-NF2.md` § Dated lines): "2026-10-14 — **T1 and T2 are
kernel theorems (FS131-IP23).** T1, existence in canonical form for a countable group acting on a standard Borel space,
is `Rigidity.condExpKernel_ergodicDecomposition` (the release's `action_ergodic_decomposition`, ported:
`Outside/OAI015ErgodicDecomposition`, 563 lines by range); T2 is `Rigidity.ksEntropy_eq_iSup_ksEntropyOn` (over the
release's `measureEntropy_eq_iSup_generating`, ported: `Outside/OAI015Generating`). Both on the standard three; no
axiom declared."

## Stage 6 — SAVED: Amendment 3 (one NOLINT entry), build 3, the linters, and every receipt again

**6.1 The change** (`data/fs131/ip23/generator-change-3.diff`, sha256 `79ff61ac…`, ruled as Amendment 3, applied exactly
in its own commit `afcbd4c48`): `(ERGDEC, "condExpKernel_ae_constant", "unusedArguments")` in NOLINT — the release's
`[Nonempty Y]` kept, the linter silenced by name with the comment beside the attribute (FS131-IE1's Amendment 1 class).
Regenerated in the real tree: `git status` shows only `OAI015ErgodicDecomposition.lean` modified, the other four modules
byte-identical; the module's diff is exactly the header's item 7 and the two lines above the theorem
(`logs/gen-a3-module-diff.out`); `--check` OK (`gen-check-3.out`); `--self-test` 29 plants refused, 1 partner accepted
(`gen-selftest-3.out`).

**6.2 Build 3** (`data/fs131/ip23/build.sh 3 8`): **exit 0**, `250 of 250 batches, 3 module(s) rebuilt`
(`Outside.OAI015ErgodicDecomposition`, `Rigidity.EntropySplitMax`, `Proofs`), 6 m 43 s, peak 4.28 GiB summed, 3.42 GiB one
process (`logs/build-3.log`, `.times`, `.rss`; `build/gate/build/20261014T095637Z-2544098.log`). No warning from any
line this job wrote; the warnings are the `sorry`s of `ChainAtTA`, `PositiveEntropy`, `UnitCircle` and
`EntropySplitMax`'s five other leaves.

**6.3 The linters** (`lake lint --no-build -- --no-build --trace`, 7 GiB slot): **exit 0, `-- Linting passed for
Proofs.`, 14 of 14 `(2/2) Passed!`** (`logs/lint-2.log`). **The doubled-name gate** (`./scripts/dupnames.sh`, 7 GiB slot):
**OK — no name is declared by two modules**, 24 generated on demand, "no repeated name appeared or disappeared since the
previous complete run" (`logs/dupnames.log`).

**6.4 Every receipt from build 3's tree.** Statements of the six modules against Stage 1: PASS, the control 8 of 8
(`statements-compare-3.out`, `statements-compare-3-control.out`; the dump `statements-after-3.txt`, compressed). Axioms
of the two leaves' files: 45 records, 40 CLEAN, 5 OTHER-LEAF, AXIOMS OK; control 4 of 4 (`axioms-verdict-3.out`,
`axioms-control-3.out`). The port's 64 records: AXIOMS OK (`port-axioms-built-3-verdict.out`). This pin's print of the 64
ported declarations: byte-identical to build 2's — the attribute is not part of a stored statement — and READBACK OK
(`logs/readback-compare-build3.out`).

**6.5 What was not run**, and why: `scripts/axioms.sh` and the rest of the whole-library gate. This branch carries the
chain's skeleton and its axiom `Rigidity.positive_entropy_rigidity`, which no `declareImport` names yet (item 750,
ruling 1: the branch stays off `main`), so the audit fails on this tree for that reason and no other; the records this
job adds are drafted for it (D1), and each was printed and classed above.

**6.6 The machine and the tree at the hand-back.** No process of this job runs (`ps`: no `lean` or `lake` under this
tree); the tree keeps its compiled library, current for the branch (item 801's ruling 4). Scratch under the ignored
`build/fs131-ip23/` (the release copies, the scratch generator, the release-side dump file, the planted copies) is in
no commit; the release's text enters a commit only inside the two generated modules, which carry its licence notice.
