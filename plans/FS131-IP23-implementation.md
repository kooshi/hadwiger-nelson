# FS131-IP23 — the five-colour chain's ports P2 and P3 (`[OAIMath2026]` family 015's ergodic decomposition and generating-sequence theorem), and the two leaves they close

*The implementer's record (de Bruijn, the implementer). Brief: `data/fs131/briefs/FS131-IP23-ports-p2-p3.md` (in the
coordinator's tree). Plan: `plans/FS131-KN7-chain-next.md` § Stage 4 (the trial and "What each needs at the consumer").
Worktree `fs131-wq1`, branch `fs131-wp23`, cut from `fs131-wpg` at `096f50deb`. Working files: `data/fs131/ip23/`.
Not pushed (the brief: the server is unreachable).*

## Theorems this phase proved

*None yet.*

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
