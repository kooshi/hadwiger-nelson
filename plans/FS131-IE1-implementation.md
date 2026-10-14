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
