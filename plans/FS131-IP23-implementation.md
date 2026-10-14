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
