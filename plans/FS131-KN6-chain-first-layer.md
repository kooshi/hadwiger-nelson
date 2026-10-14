# FS131-KN6 — the chain under "five colours at the square root of 47": its first layer through a build, the modeling passes, the re-cut of two modules, and the entropy base planned to its leaves

*de Bruijn, the planner; successor of FS131-KN3 on the same branch. Brief: `data/fs131/briefs/FS131-KN6-chain-first-layer.md`.
Branch `fs131-wch`, worktree `.claude/worktrees/fs131-wch`. Claims: `data/fs131/claims-NF2.md`. Stands on the first planner's
record `plans/FS131-KN3-chain-plan.md` (cited as KN3 § n) and the deriver's `plans/FS131-EN2-derivation.md` (EN2 § n) and
`plans/FS131-EN1-derivation.md` § 8.1. Working files: `data/fs131/kn6/`.*

## Theorems this phase proved

A planning job: the chain's leaves are not proved here. What it proved while testing its plans, each **[kernel]**, through
`./scripts/build.sh` (build 2), axiom lists from the built tree (`data/fs131/kn6/logs/AxiomsCheck.log`) — the standard
three unless said:

- `Rigidity.colorable_two_levelTarget_one_of_isRamified` — at a stable prime on whose residue field conjugation is the
  identity, the level-one target is two-colourable — `Rigidity/ChainAtTA.lean`
- `Rigidity.noRamifiedStableDyadic_of_three_le_localBound` — `3 ≤ L(F)` excludes a ramified stable prime, for every
  subfield `F` of `ℝ` — `Rigidity/ChainAtTA.lean`
- `Rigidity.IsRamified.isDyadic`, `Rigidity.noRamifiedStableDyadic_iff` — a ramified stable prime is dyadic — `Rigidity/ChainAtTA.lean`
- `Rigidity.partitionEntropy_le_liminf` — the infimum form of the entropy on a partition is below the `liminf` form, for
  every measure and map — `Rigidity/Entropy.lean`
- `Rigidity.mem_nameCell_self` (no axioms), `partitionEntropy_le`, `partitionEntropy_le_ksEntropyOn`,
  `partitionEntropy_le_ksEntropy`, `ksEntropy_eq_zero_iff`, `ksEntropyOn_le_ksEntropy`, `blockEntropy_nonneg` — the entropy
  definitions' reasoning surface — `Rigidity/Entropy.lean`

**Not theorems of the library**: `Rigidity.min_localBound_five_le_chromaticNumber_of_closed` with eight hypotheses is a
composition the kernel checked over leaves that are `sorry` (it prints `sorryAx`). In a scratch bundle only, not in the
library: `nameCell_eq_orbitName_fibre`, `blockEntropy_eq_observationEntropy` (`data/fs131/kn6/bridge-statements.lean`).
The branch is a skeleton — fifteen `sorry` leaves and one undeclared `axiom` — and is not at the gate.

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_kn6_readback.py` takes every line `> <text>` of the brief whose next line is `> — source: <path> …` and requires
`<text>` to be one whole line of that file, character for character. Run against `main`'s tree (`--root
/home/kooshi/source/lean-dir`, where the brief and the inventory live until the join):

- `quotations=9 identical=9 differing=0`, exit 0: W2 (`data/fs131/REQUEST-2026-10-13.md`); NF2-MRPLUS, -MRPLUS-SCOPE,
  -FROM-TWO, -NC, -LEAF-17, -LEAF-18 (`data/fs131/claims-NF2.md`); items 661 and 711 (`plans/FS131-close-inventory.md`).
- Control (`--plant`: the last character of every matching source line changed in memory): `identical=0 differing=9`, exit 1.

No mismatch: nothing for the coordinator from the readback of text.

### 1.2 The four files, each definition and statement beside the claim-list line it answers

Read in full by me: the four modules (587 lines), KN3's record and report, the four draft claim lists M0, M1, M7, M8, EN2
§§ 1, 3.0, 3.5–3.7, 4.0–4.3, 5.1–5.3, EN1 § 8.1, the nine inventory items the brief names (642, 646, 649, 651, 658, 659, 666,
706, 707).

| module | declaration | kind | answers |
|---|---|---|---|
| `Rigidity/Entropy` | `nameCell`, `blockEntropy`, `partitionEntropy`, `ksEntropyOn`, `ksEntropy` | definitions | NF2-LEAF-13 (entropy, with the form on a sub-σ-algebra) |
| | `ksEntropyOn_self`, `nameCell_zero`, `measurableSet_nameCell`, `ksEntropyOn_mono`, `blockEntropy_zero_measure`, `ksEntropy_zero_measure` | proved | drift checks of the definitions |
| | `blockEntropy_one`, `ksEntropy_id`, `ksEntropy_map` | `sorry` | draft M1, statement 1 |
| `Rigidity/Solenoid` | `IsSolenoid`, `ZdAction` (+ `trivial`, `InvariantOn`, `IsIrreducible`, `IsTotallyIrreducible`, `IsVirtuallyCyclicMod`, `IsVirtuallyCyclic`, `NoVirtuallyCyclicFactors`, `IsErgodicOn`) | definitions | NF2-LEAF-14 (the page's predicates; the pieces themselves are M6's) |
| | `isVirtuallyCyclicMod_bot`, `isSolenoid_unit`, `trivialAction_noVirtuallyCyclicFactors`, `trivialAction_isErgodicOn` | proved | the degenerate model |
| `Rigidity/PositiveEntropy` | `positive_entropy_rigidity` | **axiom** | NF2-LEAF-16 by ruling 642 (b) / 658: `[EinsiedlerLindenstrauss2022]` Thm 1.3, declared |
| | `positive_entropy_rigidity_model` | proved | the axiom's item 3 (degenerate) |
| | `haar_or_zero_entropy` | `sorry` | NF2-LEAF-16's Thm 1.2, ours to prove (FS105-DED; module M5) |
| `Rigidity/ChainAtTA` | `torsionChars`, `archChars`, `TA`, `one_mem_TA` | definitions, one proof | NF2-LEAF-01 (the set) |
| | `measurableSet_TA`, `rot_preimage_TA` | `sorry` | NF2-LEAF-01 (its measurability and stability; module C0) |
| | `exists_nonTorsion_unitVector` | `sorry` | EN1-FROM-TWO's step 3 (module C0) |
| | `chainInterface`, `interface_mr_iff` | definition, `Iff.rfl` | NF2-LEAF-02 |
| | `MRPlus` | definition | NF2-MRPLUS |
| | `EntropySplit`, `entropySplit` | definition, `sorry` | NF2-LEAF-20 (PE-2; module M7) |
| | `ZeroEntropyCarried`, `zeroEntropyCarried` | definition, `sorry` | NF2-LEAF-21 (EF_F⁺; module M8) |
| | `IsDyadic`, `IsRamified`, `NoRamifiedStableDyadic`, `noRamifiedStableDyadic_of_tca` | definitions, `sorry` | NF2-MRPLUS-SCOPE's field hypothesis; FS100-EXC (module M9) |
| | `mrPlus_of_split_of_carried` | proved over one leaf | NF2-FROM-TWO, NF2-LEAF-22 |
| | `mrPlus` | proved over the leaves | NF2-MRPLUS with NF2-MRPLUS-SCOPE |
| | `five_le_chromaticNumber_of_mrPlus` | proved over the leaves | NF2-SPCOR |
| | `min_localBound_five_le_chromaticNumber_of_closed`, `…_closed` | proved over the leaves | NF2-LEAF-02's headline; nine closed hypotheses, then six |

Ten `sorry` leaves and one axiom, as KN3 § Stage 6 "Sizes" counts.

### 1.3 What the first planner left undone, restated

From its report's HELD lines and inventory item 661:

1. **No build.** The four files went through `lake env lean` one at a time (with `autoImplicit` off by flag) and never through
   `./scripts/build.sh`; the lakefile's linters have not run on them. Stage 2 here.
2. **No modeling pass as a fresh Skill invocation.** Each definition was weighed against one second form and sent to the
   coordinator; the domain pass on `ksEntropy`/`ksEntropyOn`, `TA` and `IsRamified` is owed before anything is proved over
   them, and the obligation and experience passes with it. Stage 3 here.
3. **The entropy base (M0 with M1) is surveyed by statement only**: no cone computed, nothing of the release built, no proof
   read; "the axiom's read-back has a hole until `ksEntropy` is pinned to the textbook's number". Stage 5 here.
4. Two questions for the derive lane — answered since by FS131-EN2 (§ 1.4). Stage 4 here.
5. Owed and not this job's: the journal's page numbers of Thm 1.3 and a second reader against the page (item 661 (b)).

### 1.4 The deriver's two answers, against the two draft claim lists they change

**Draft M8** (`data/fs131/kn3/claims-M8-zero-entropy-carried.md`), statement 3: "Lemma 3.1′ (X01D l. 226): zero entropy gives
few names. **Open classical input**: Shannon–McMillan–Breiman in its almost-everywhere, non-ergodic form … unless Steps 4–5
run on convergence in mean along chosen scales (a question for the derive lane)."

- The scheme as the draft words it is **not derived** (EN2 § 3.0: "it stalls at the choice of the subsequence"; a zero-entropy
  invariant measure with `H_n ≥ c·n/log n`, EN2-MEAN-RATE).
- What replaces the classical input is **EN2-ZE** (EN2 § 3.5), with EN2-CNT under it and EN2-L31 (Lemma 3.1′, statement
  unchanged) over it. Its inputs, EN2 § 5.1's table: the rate of one partition is zero (the definition); Markov on the terms
  of one `H_k` (fresh, two lines); **the maximal ergodic inequality for the indicator of a set** (the release's
  `excessiveOccupation_measure_bound` over `finite_hopf_maximal`, or fresh); EN2-CNT (fresh, combinatorics); a geometric series.
- Leaves the list of classical inputs of M8: Shannon–McMillan–Breiman, Egorov, Jacobs's formula and the ergodic decomposition
  for the single map `u*`, conditional information, the martingale theorem.

**Draft M7** (`data/fs131/kn3/claims-M7-entropy-split.md`), statement 3: "from `Γ` to `U` (X02D § 3.2), over the ergodic
decomposition for the countable group `U_F` (T1; existence from M0's port; **uniqueness is cited at ll. 205, 209, 225 and is
not in the release by name**)."

- **Derived, and more** (EN2 § 4.0): no uniqueness of an ergodic decomposition, no permutation of components, no ergodic
  decomposition for `U`. Two routes: the Lebesgue decomposition with respect to Haar measure (EN2 § 4.2: EN2-LEB-INV,
  EN2-AC-ERG, EN2-SING-COMP, EN2-PE2-SING; reads Mathlib's Lebesgue decomposition with uniqueness and the ergodicity of Haar
  measure under one non-torsion unit vector), and the variant **EN2-PE2-MAX** (EN2 § 5.2: `a` the largest Haar multiple below
  `τ`; reads neither).
- Both read: the release's `action_ergodic_decomposition` at `H = Γ ≅ ℤ²` (existence, canonical form) and
  `measureEntropy_kernel_zero`; Lemma Γ and Lemma W by statement; T4 (Fourier uniqueness).
- Leaves the list: uniqueness of the ergodic decomposition; the decomposition for `U`; the measurability of `{m}` in a space
  of measures; Jacobs's formula as a formula (KN3 § 4.2 had already reduced it to the mixture lemma); on the variant, the
  ergodicity of Haar measure and the Lebesgue decomposition.
- The deriver's two points of typing (EN2 § 5.2, end): `ρ` is the point mass at the trivial character when `τ′ = 0`; one `m`
  with `IsHaarFourier m` throughout.

The route and the port-or-write call are this job's (item 711 (a)); they are made in Stage 4.

## Stage 2 — SAVED: the join and the first build

### 2.1 The join

`git merge main` at `82b4bc2b9` (the brief names `232a2f0d4`; `main` had since gained the two inventory commits that
carry this job's brief). One conflict: `ARCHITECTURE.md`'s module table, where `main` had added the three upper-half rows
and this branch the four `Rigidity/` rows — both kept, `main`'s first. `Proofs.lean` merged by itself.
`tools/check_architecture.py`: PASS. Commit `50004bb97` (a merge commit cannot be made by explicit path; the index held
the merge and nothing else, and no other agent writes in this worktree).

### 2.2 The compiled library, brought up to date by copy (the condition of inventory items 694 and 709)

- **From where**: `.claude/worktrees/fs131-wnf/.lake/build/`, the tree whose gate passed today; its `HEAD` was
  `1e9014443` before and after the copy, its work tree clean, and `git diff 1e9014443 main -- Proofs Proofs.lean
  lakefile.toml lean-toolchain lake-manifest.json` is empty: its Lean sources are `main`'s.
- **What and how**: `rsync -a --checksum` with no `--delete`, into this tree's `.lake/build/`. Nothing was written in the
  other tree and nothing run there.
- **How it was compared**: a dry run with `--itemize-changes` before (`data/fs131/kn6/logs/rsync-dry-before.out`: 1,434
  lines, of which 176 are `.olean` — 27 absent here, 8 differing in content, 141 identical in content with another time);
  the copy (`rsync-real.out`, the same 1,434 lines); a dry run after (`rsync-dry-after.out`: **0 lines** — every file of
  that tree's build is byte for byte in this one). The copy ran 02:06:07–02:06:53 UTC (`copy-times.txt`).
- **The manifest** made after the copy and before the build: `olean-manifest-after-copy.sha256` (SHA-256 of each of the
  1,906 `.olean` under `.lake/build/lib/lean`) and `olean-times-after-copy.txt`. A later reader shows that no compiler has
  rewritten a copied file by `sha256sum -c` against it: the only files that may differ are the ones the builds below report
  as rebuilt.
- **What Lake then recompiled is what this tree changed**: the first build rebuilt five modules and no other (§ 2.3).

### 2.3 The first build of the first layer

`data/fs131/kn6/build.sh <tag> [BATCH]` runs `./scripts/build.sh` under the slot (`--mem 12 --cpus 4`, `MEMMAX=12G`) and
keeps the log (last line `exit=<status>`), the wall time, and a memory sample every 5 s over the `lean` and `lake`
processes whose working directory is this worktree. `BATCH=8`: `./scripts/build.sh --plan` puts the four stale modules
in three batches (`Entropy` with `Solenoid`; `PositiveEntropy`; `ChainAtTA`), so at most two compile at once
(`logs/plan-batch8.out`).

| | |
|---|---|
| result | `==> build: OK — 249 of 249 batches, 5 module(s) rebuilt, 3 module(s) with warnings, 6m57s`; `exit=0` (`logs/build-1.log`) |
| rebuilt | `Rigidity.Solenoid` (1.6 s), `Rigidity.Entropy` (1.9 s), `Rigidity.PositiveEntropy` (1.5 s), `Rigidity.ChainAtTA` (2.1 s), `Proofs` (2.3 s) |
| warnings | ten, each `declaration uses 'sorry'`: `Entropy` 98, 104, 110; `PositiveEntropy` 84; `ChainAtTA` 66, 71, 75, 188, 193, 198. **No other warning**: the lakefile's linters (docstrings among them) are quiet on the four files |
| wall | 421 s by the wrapper's clock (`logs/build-1.times`) |
| memory | 3.01 GiB summed, 2.11 GiB the largest process (`logs/build-1.rss`). **What that measures**: 5-second samples; they include two single-file checks I ran beside the build; each of the four modules compiled in about 2 s, so a compile can fall between two samples. The 12 GiB cap was not approached |
| environment linters | `lake lint --no-build -- --no-build --trace` under the slot: `exit=0`, `-- Linting passed for Proofs.`, 14 linters each `(2/2) Passed!` (`logs/lint-1.log`). With `sorry` bodies `unusedArguments` cannot see a binder a proof will not read: that reading is the domain pass's (Stage 3: `ksEntropy_id`) |

Nothing was flagged, so nothing was fixed at this stage. The one line went to the coordinator with the wall time and the
memory figures as measured.

## Stage 3a — SAVED: the domain pass (`debruijn-domain-modeling`, a fresh invocation, scoped to the four files)

Run on every definition and headline of the four files, in the skill's order: simulate, reframe, search the shelf, read
the ugliness, validate the seams. Both changes of form went to the coordinator before they were written and were accepted
(Amendment 1 of the brief). Every changed file elaborates under `data/fs131/kn6/lean1.sh` (the lakefile's two
`autoImplicit` options by flag; logs `data/fs131/kn6/logs/lean1-*.log`, each `exit=0`); the build is Stage 5's.

### 3a.1 What it changed

| # | declaration | old form | new form | reason |
|---|---|---|---|---|
| D1 | `Rigidity.partitionEntropy` (definition) | `liminf (fun n : ℕ => ENNReal.ofReal (blockEntropy μ T P (n + 1) / (n + 1))) atTop` | `⨅ n : ℕ, ENNReal.ofReal (blockEntropy μ T P (n + 1) / (n + 1))` | (a) the axiom concludes "entropy = 0", and the infimum is below the `liminf` for every measure and map with nothing to prove (`partitionEntropy_le_liminf`, new, proved by `iInf_le_liminf`): the axiom over the infimum is implied by the axiom over any reading of the limit, so the unverified direction of the read-back is the safe one by construction; (b) it is the release's form (`sInf {H_N / N}`), so `ksEntropy = measureEntropy` needs no invariance; (c) it is the form EN2-ZE is stated in ("If `inf_{n ≥ 1} H_n/n = 0`"). For an invariant probability measure the two are one number: the pinning theorem `tendsto_blockEntropy_div` (new, a leaf) |
| D2 | `Rigidity.ksEntropy_id` (leaf) | `(μ : Measure X) [IsFiniteMeasure μ] : ksEntropy μ id = 0` | `(μ : Measure X) : ksEntropy μ id = 0` | the statement does not read finiteness (`μ.real` is finite; `H_n = H_1` for `n ≥ 1`); with a `sorry` body no linter would have said so |
| D3 | `Rigidity.min_localBound_five_le_chromaticNumber_of_closed` (headline) | nine hypotheses, among them `(hScope : TCA F → NoRamifiedStableDyadic F)` | eight: `hScope` is gone; the proof reads `noRamifiedStableDyadic_of_three_le_localBound F (le_trans (by decide) h5)` | **a shorter route.** `Arith/UpperHalf` (landed on `main` today, joined in Stage 2) carries `IsRamified P` word for word as the binder `hram` of `UpperHalf.two_mem_of_conj_trivial` and `colorable_two_planeOver_of_ramified`. New and proved here: `IsRamified.isDyadic`; `noRamifiedStableDyadic_iff` (the word "dyadic" in the scope is free); `colorable_two_levelTarget_one_of_isRamified` (at a ramified stable prime `𝓞 ⧸ P` has characteristic 2 and trivial conjugation, so adjacency in the level-one target is `x − y = 1`, and `TwoColourResidue.exists_addMonoidHom_zmod_two_apply_one_ne_zero` colours it); `noRamifiedStableDyadic_of_three_le_localBound`. `ChainAtTA` gains the import `Arith/UpperHalf` |
| D4 | `Rigidity.noRamifiedStableDyadic_of_tca` (leaf) | on the headline's path | **stated, off the headline's path**; docstring says so and gives its route (a colour class of that two-colouring holds at least half of `𝓞 ⧸ P`) | FS100-EXC in its own words stays a statement of the library (the hand record under row 121 cites it); the headline needs only the local-bound form |
| D5 | the axiom's docstring, `Rigidity/PositiveEntropy` (no change to the statement) | — | four sentences: the entropy in clause (4) is the infimum form; for a preserved probability measure it is the textbook's number by `tendsto_blockEntropy_div`; the statement is implied by the printed one whether or not that is proved, because the entropy occurs once, in the conclusion, as "= 0"; a later edit that puts the entropy into a hypothesis of a declared statement reverses the direction and may not be made before the pinning theorem is proved | Amendment 1 (2) |

`Rigidity/Entropy` also gains the import `Mathlib.Dynamics.Ergodic.MeasurePreserving` (the pinning theorem's hypothesis).

### 3a.2 What it weighed and kept, with what decided

- **`ksEntropy` stays this library's own definition; the release's `measureEntropy` is not put under the axiom.** The
  first layer then builds over Mathlib alone and does not wait on the port, and the axiom is read against five short
  definitions in one file. After D1 the two are the same number for every `μ` and `T` (a leaf of Stage 5), so nothing is
  paid for having both.
- **`ksEntropyOn` as the form on a sub-σ-algebra** (no separate conditional entropy): the one statement that reads it is
  `ksEntropy_map`, true as typed with no invariance (the cells of a factor pull back to cells).
- **`blockEntropy` in `ℝ` through `μ.real`; `ksEntropy` in `ℝ≥0∞`.** Entropy is read here only for a probability measure
  the map preserves (checked at every occurrence: the axiom's clause (4), `haar_or_zero_entropy`, `EntropySplit`,
  `ZeroEntropyCarried`); elsewhere it is a junk value, and the module's docstring now says so. `EntropySplit`'s `b • ρ`
  with `ρ` a probability is what keeps it that way, and is kept.
- **`TA F` as a `Set (Dual F)`, a product of two sets written by comprehension.** Against `Subgroup (Dual F)` (the join
  of Mathlib's `CommGroup.torsion` and the range of `ψ ↦ exp ∘ ψ`): every consumer reads membership or the measure of the
  set, the interface takes sets, the comprehension is the claim's sentence, and closure under multiplication is one lemma
  away (`Subgroup.mem_sup`) for the one reader that may want it (M10). No change.
- **`IsRamified P := ∀ x, conjO F x - x ∈ P.P`.** Against Mathlib's ramification index: both proofs that read the
  predicate (FS100-EXC's matching; the two-colour theorem on `main`) consume "conjugation is the identity on `𝓞 ⧸ P`", and
  `main` chose the same sentence independently. The equivalence with `e(P | P ∩ 𝓞_F) = 2` is a readability lemma owed to
  module M9, not a change of definition. `IsDyadic` is kept so that the scope reads as the claim line does.
- **`IsSolenoid` as a `Prop`-structure with instance-valued fields; `ZdAction` as a structure.** Against mixin classes and
  `Multiplicative (Fin d → ℤ) →* …`: the axiom's hypothesis then reads as the page's sentence, with no `Multiplicative` in
  the statement. Owed to M5/M6 as lemma API, not typed here: `α (-n) (α n x) = x`, `α (k • n) = (α n)^[k]`-forms,
  measurability of `α n`.
- **`IsErgodicOn` on strictly invariant sets** — Mathlib's own convention for one map (`PreErgodic`). As the axiom's
  hypothesis this is formally the weaker property; for a countable group it is the textbook's (an almost invariant set
  differs by a null set from the intersection of its translates). Listed for the second reader (Stage 6).
- **`NoVirtuallyCyclicFactors`** quantifies over every closed invariant `Y ≠ ⊤`: the strongest reading of the hypothesis,
  hence the weakest axiom; a connected group has no proper closed subgroup of finite index, so "non-trivial factor" has
  one meaning.
- **`MRPlus`, `EntropySplit`, `ZeroEntropyCarried`, `chainInterface`**: no change. `EntropySplit` asserts that a measure
  with `IsHaarFourier` exists (even at `τ = 0`); that is module M4's theorem (or `BochnerHerglotz`'s), noted for the re-cut.

### 3a.3 The seams

- *Models.* `MRPlus`, `EntropySplit`: the zero measure. `ZeroEntropyCarried`: the point mass at the trivial character with
  `(3 + 4i)/5` — every clause exercised (it is rotation-invariant, a probability, of entropy zero, and carried by `T + A`
  because `1 ∈ TA F`); the two facts it needs are leaves of Stage 5 (`ksEntropy_dirac`, and in C0 "the point mass at `1`
  is rotation-invariant"). The headline: `ℚ(√47)`, module M15, not in the library — the docstring now says so.
- *The unsampled member.* `partitionEntropy` at a measure the map does not preserve: the infimum and the `liminf` differ
  there and nothing reads it. `ksEntropy_map` at `k = 0` with `X` empty and `Y` not: no label map `Y → Fin 0` exists, and
  both sides are `0` (a case split for its implementer, Stage 3b).
- *The adversarial member for the axiom.* `J = 1`, `Λ = ⊤`, `G = ⊤` gives translation invariance (Haar); `G = ⊥` gives
  entropy zero on `X` itself: the two ends of Theorem 1.2, as they should be. At the degenerate model the conclusion is
  true (`J = 1`, `G = ⊤`, the one-point quotient).

## Stage 3b — SAVED: the obligation pass (`debruijn-obligation-modeling`, a fresh invocation) on the leaves the plan calls long

No statement changed. For each long leaf: the statement the proof derives from, its children (each one library
application or one identity), and what is hard. The children that belong to the entropy base are typed in Stage 5.

1. **Subadditivity of `H_n` and the pinning theorem.** The statement the proof derives from is not about names: it is
   about *the Shannon entropy of a finite-valued observation* `Q : X → A` — `H(Q, R) ≤ H(Q) + H(R)`, `H(Q ∘ T) = H(Q)`
   under invariance, `H(e ∘ Q) = H(Q)` for an equivalence `e` — and `name_{a+b} ≃ (name_a, name_b ∘ T^a)`. That factoring
   **is** the release's file (`observationEntropy`, `observationEntropy_joint_le`, `observationEntropy_comp_preserving`,
   `orbitName_add`, `orbitEntropy_subadditive`), which elaborates here (Stage 5.1). So the children are: the port; `nameCell`
   is a fibre of `orbitName`; `blockEntropy` is `observationEntropy ∘ orbitName` (both proved in the scratch bundle);
   then `Subadditive.tendsto_lim` or the release's `tendsto_observationEntropyRate`, with
   `Monotone.map_csInf_of_continuousAt` for `ENNReal.ofReal (sInf S) = ⨅ …` (every `H_n ≥ 0`: `blockEntropy_nonneg`,
   proved). Hard: nothing; the `Fin (a + b)` plumbing is already paid by the release. Fallback if the port is refused:
   the one real inequality is `H(Q, R) ≤ H(Q) + H(R)` (Gibbs, from `Real.log_le_sub_one_of_pos`), about sixty lines.
2. **EN2-CNT, the count.** The hand proof's parse is an injection into token sequences; the Lean proof should not build
   that object. Define on lists `singles : List α → ℕ` by the parse's own recursion (a block of `𝒢` at the head: recurse
   on `drop k`; otherwise `1 +` the tail) and prove two statements by functional induction on it:
   (A) *the weighted count, as an inequality*: `∑ over words of length m of t^(singles w) ≤ ρ^m`, with `t = 1/(2a)`,
   `ρ = g^(2/k)`, by strong induction on `m` — the words whose head block is in `𝒢` inject into `𝒢 × words (m − k)` and
   the others into `α × words (m − 1)`; `a·t = 1/2`, `#𝒢·ρ^(−k) ≤ 1/2`, `ρ ≥ 1`. (The hand proof's *equality* recursion
   and the bijection onto token sequences are not needed: this is the weakening that makes each case local.)
   (B) `singles w ≤ badStarts w + (k − 1)`: three cases — a block (the bad starts of `drop k w` are bad starts of `w`), a
   single at a bad start (`badStarts w ≥ 1 + badStarts (tail)`), a single in the last `k − 1` letters (then
   `singles w = length w < k`).
   (C) from (A) and (B): `#W · t^(θn + k) ≤ ρ^n`. Hard: the bookkeeping between `Fin n → α` (the consumer's words) and
   `List α` (the recursion's); quarantine it in one corollary that restates (C) for `Fin n → α` through `List.ofFn`.
3. **EN2-ZE.** Six children, in the deriver's order, each typed in words: (Z0) a block length `k` with `γk ≥ log 2` and
   `H_k ≤ γθ²k` — `exists_blockEntropy_le_mul`, typed; (Z1) Markov on the terms of `H_k`: with `𝒢` the words of mass
   `≥ e^(−γk)` and `B` the union of the other cells, `γk · μ.real B ≤ H_k`, and `#𝒢 ≤ e^(γk)`; (Z2) the maximal
   inequality, `ENNReal.ofReal θ * μ (excessiveOccupation T B θ) ≤ μ B` — the port; (Z3) off that set, the bad starts of
   the name of `x` of length `n` are among the visits of the orbit to `B` (the block at `j` of the name of `x` is the name
   of `T^j x`: `Function.iterate_add_apply`), so at most `θn`; (Z4) with EN2-CNT, at most `e^(βn/2)` such names once
   `n ≥ k/θ` — the arithmetic stated as its own real-variable lemma; (Z5) the union of their cells of mass `< e^(−βn)`
   has mass `≤ e^(−βn/2)`; (Z6) the set, a geometric series and `measure_iUnion_le`. Hard: (Z3)–(Z4), where the dynamics
   meets the count — the deriver's own first place to attack.
4. **`ksEntropy_map`.** Children: a label map measurable for `mY.comap π` is `Q ∘ π` for a measurable `Q` (hard part:
   when `X` is empty and `Y` is not there is no `Q : Y → Fin 0`, and both sides are `0` — split on `IsEmpty X`); the
   cells of `(T, Q ∘ π)` are the preimages under `π` of the cells of `(S, Q)` (`Function.Semiconj.iterate_right`);
   `Measure.map_apply` on a measurable cell (`measurableSet_nameCell`, which is why `hS` is in the statement).
5. **`measurableSet_TA`** (module C0's; longer than "an implementer, no planner" suggested). Children: (i) `χ ∈ TA F ↔
   ∃ N ≠ 0, χ ^ N ∈ archChars` (`⇐`: divide the lift by `N`); (ii) `χ ↦ χ ^ N` is measurable for the cylinder σ-algebra;
   (iii) `archChars` is the image of a finite-dimensional real space under a continuous map into `unitRing F → Circle`
   — an additive `ψ : R → ℝ` extends to a `ℚ`-linear functional on `F(i)`; (iv) that image is a countable union of
   compact sets, closed in the product, measurable there (`Pi.borelSpace`, `Countable (unitRing F)`), and pulled back
   along the evaluation map that defines the cylinder σ-algebra; (v) the union over `N`. Hard: (iii). Lemma F (the
   countability of the torsion characters) is **not** read on this route.

## Stage 3c — SAVED: the experience pass (`debruijn-experience-modeling`, a fresh invocation)

For the three readers of the four files: a mathematician at the headline and the axiom; the implementers of the next
modules; `simp` and `exact?`.

**Changed (no statement's meaning; additions and one attribute).** `Rigidity/Entropy` gains the reasoning surface the
next modules read, proved over Mathlib alone so that nobody unfolds a definition: `mem_nameCell` (`@[simp]`),
`mem_nameCell_self`, `partitionEntropy_le`, `partitionEntropy_le_ksEntropyOn`, `partitionEntropy_le_ksEntropy`,
`ksEntropy_eq_zero_iff` (the form in which every consumer takes "entropy zero"), `ksEntropyOn_le_ksEntropy`,
`blockEntropy_nonneg`; `ksEntropyOn_self` is now `@[simp]` (normal form: `ksEntropy`). The headline's docstring names the
model of its hypotheses and says that none is in the library yet.

**Found while writing them — a trap for every later statement about a sub-σ-algebra.** With two `MeasurableSpace X`
binders in scope, `(μ : Measure X)` is a measure for the *last* one: `ksEntropyOn_le_ksEntropy` written with
`{m} {𝒜} … (μ : Measure X)` was a statement about a measure on `𝒜`, caught by a type mismatch in its one-line proof.
The measure's σ-algebra is written out, `(μ : @Measure X m)`, as the first planner's `ksEntropyOn_mono` already does;
the file says so in a comment. A draft line for `LEAN.md` is in the report's drafts.

**Weighed and left.** The two headline names differ by `_of` (`…_of_closed`, eight hypotheses; `…_closed`, six): opaque
to a cold reader, but both are quoted in two records, an inventory item and an amendment, and the landing's read-aloud
is the place to rename them. `IsRamified`, `IsDyadic` are not in `StablePrime`'s namespace (`P.IsRamified` does not
read); `h.isDyadic` does. Explicit `(hμ : IsProbabilityMeasure μ)` in the axiom: the read-back's form, kept. No
notation is minted anywhere.

## Stage 4 — SAVED: the re-cut of the two modules the deriver's answers change

`tools/fs131_kn6_recut.py` writes `data/fs131/kn3/claims-M7-entropy-split.md` and `claims-M8-zero-entropy-carried.md`
from the templates `data/fs131/kn6/recut-M7.tmpl`, `recut-M8.tmpl`: every statement of the deriver's is its entry's
`statement:` field copied by script (eight entries: EN2-CNT, -ZE, -L31; EN2-PE2-MAX, -PE2-SING, -LEB-INV, -AC-ERG,
-SING-COMP), every leaf line the fixed claim list's. `--check`: both identical; `--check --plant` (one character of
EN2-ZE changed in memory): M8 `DIFFERS`, exit 1. The first drafts are in git at `758af9d28`; the first planner's
`tools/fs131_kn3_claimlists.py --check` now reports these two files as differing from its regeneration, as it should.

**The choices.**
- **M8 reads EN2-ZE in place of the entropy theorem**, and is cut in two: **M8a**, the names at entropy zero (EN2-CNT,
  EN2-ZE — pure, one new file, an implementer from Stage 3b's decomposition), and **M8b**, the model, the pigeonhole
  and the wandering step (its own planner). **The maximal inequality is ported, not written fresh** (my call, item 711
  (a)): its used cone is 243 lines that elaborate at this pin after two renames (Stage 5.1), against a fresh proof of
  about the same length with nothing to copy.
- **M7 is built on the deriver's variant, EN2-PE2-MAX** (the largest Haar multiple below the measure), not on the
  Lebesgue decomposition: the typed `EntropySplit` is exactly the sentence the variant proves; it reads neither the
  Lebesgue decomposition nor the ergodicity of Haar measure; and the Fourier uniqueness it reads instead is read by
  Lemma Γ already and is module M2's theorem. The Lebesgue route (EN2-PE2-SING with its three lemmas) is kept in the
  claim list as the second route — it gives more (`τ′ ⟂ m`; the ergodic form), and is the one to build if a later
  statement reads the ergodic form; none of the chain's does.
- **Where each classical statement now comes from** is each claim list's table. In one line: from Mathlib — conditional
  expectation and its kernel, the difference of measures, a geometric series; from the release by port — the maximal
  inequality, the mixture lemma, the limit along σ-algebras, the ergodic decomposition in canonical form (existence);
  fresh — Markov on the terms of one `H_k`, EN2-CNT; from another module of the chain — Fourier uniqueness (M2), Haar
  measure on the dual (M4).
- **What leaves the chain's list of classical inputs**: Shannon–McMillan–Breiman; Egorov; Jacobs's formula as a
  formula; the ergodic decomposition for a single map and for the whole group `U`; the uniqueness of the ergodic
  decomposition; the measurability of `{m}` in a space of measures; conditional information and the martingale theorem
  (for M8); the Lebesgue decomposition and the ergodicity of Haar measure (on M7's chosen route).

**Dated lines drafted for `data/fs131/claims-NF2.md` § Dated lines** (Keryx files; each follows the last line there):

- "2026-10-14 — **NF2-LEAF-18 is answered (FS131-EN2, inventory item 706; re-cut by FS131-KN6).** Lemma 3.1′ needs
  neither Shannon–McMillan–Breiman nor the scheme the chain's first planner asked about; it reads the deriver's EN2-ZE
  (rate zero puts no atom of the names of length `n` below `e^{−βn}` on a set of measure `≥ 1 − η`, for every large
  `n`), whose inputs are the definition of entropy, Markov's inequality at one block length, a count of words (EN2-CNT)
  and the maximal ergodic inequality for the indicator of a set — the last by port from `[OAIMath2026]` family 015 (243
  lines that elaborate at this library's pin). Module M8's draft claim list is rewritten
  (`data/fs131/kn3/claims-M8-zero-entropy-carried.md` on branch `fs131-wch`)."
- "2026-10-14 — **NF2-LEAF-17 is answered in part (FS131-EN2, inventory item 707; FS131-KN3 § 4.2; re-cut by
  FS131-KN6).** T1 is read only as existence in canonical form, for `Γ ≅ ℤ²`, never its uniqueness and never for `U`
  (by port from the release's `action_ergodic_decomposition`; its used cone is not yet measured); T3 is read only as
  'a mixture of invariant measures of entropy zero has entropy zero' (by port, measured); T2 and T4 are read inside
  Lemma Γ, T2 by port, T4 from Herglotz–Bochner's uniqueness. No page is owed for T1–T3 as theorems to declare: none is
  declared. Module M7's draft claim list is rewritten on the deriver's variant EN2-PE2-MAX."
- "2026-10-14 — **The headline with closed hypotheses takes eight, not nine (FS131-KN6, Amendment 1 of its brief).**
  `Rigidity.min_localBound_five_le_chromaticNumber_of_closed` no longer takes `TCA F → NoRamifiedStableDyadic F`: at a
  stable prime on whose residue field conjugation is trivial the level-one target is two-colourable (proved, over
  `Arith/UpperHalf`), so `5 ≤ L(F)` excludes one. The leaf that left the headline's path is FS100-EXC's
  (`Rigidity.noRamifiedStableDyadic_of_tca`); it stays stated in module M9's draft claim list, marked off the path."

## Stage 5 — SAVED: the entropy base, planned to its leaves

### 5.1 The port (module M0): which files, their cones, and what they need at this pin — measured

Declared cones, by `tools/fs131_kn6_import_cone.py` (the closure of `import` lines inside the release, read only;
`--self-test` plants a commented import and requires it to be ignored; `data/fs131/kn6/logs/import-cone.out`). The used
cone and the needs at this pin, by **trial elaboration of scratch copies** (Amendment 2 of the brief):
`tools/fs131_kn6_release_copy.py make` writes each bundle under the ignored `build/fs131-kn6/release-copies/` (not
committed) with its import lines replaced by `import Mathlib` and the recorded renames applied; `scan` searches the copy
for `#eval`, `run_cmd`/`run_elab`/`run_meta`, `initialize`, `unsafe`, `IO.`, a `macro`/`elab`/`syntax` declaration and any
other import, and `--plant` requires a planted `#eval` and a second import to be reported; `data/fs131/kn6/trial.sh`
elaborates one copy at a time under an 8 GiB slot, writing no compiled file, only when the scan has no hit. Logs:
`data/fs131/kn6/logs/{make,scan,trial}-*`.

| lane | release files | lines | declared cone | scan | needs at this pin | elaboration |
|---|---|---|---|---|---|---|
| **M0-shannon** | `PrimePackets/ShannonEntropy.lean` | 453 | 1 file (Mathlib only) | 0 hits; control fired | 2 renames: `Set.ofPred_and` → `Set.setOf_and` | 0 errors, 8 s |
| **M0-mix** | `PrimePackets/EntropyMixtures.lean` | 540 | 2 files, 993 lines | 0 hits; control fired | 3 renames: `ite_eq_right` → `if_neg` (2), `ite_eq_left` → `if_pos` (1) | 0 errors, 7 s (with the file above) |
| **M0-max** | `DukePrimeDegree/Dynamics/HopfMaximal.lean`, `Dynamics/MaximalOccupation.lean`, and `PrimePackets/InverseEntropy.lean` ll. 247–257, 285–290 (`visitCount`, `visitCount_cast`, `measurable_visitCount`) | 107 + 120 + 16 | 89 files, 43,434 lines | 0 hits; control fired | 2 renames: `birkhoffSum_succ_apply'` → `birkhoffSum_succ'`, `Set.ofPred_mem_eq` → `Set.setOf_mem_eq` | 0 errors, 4 s and 5 s |
| M0-gen (T2; module M7's input) | `PrimePackets/EntropyGeneratingSupremum.lean` and eight more | — | 11 files, 1,843 lines, all entropy | not trialled | — | — |
| M0-erg (T1; module M7's input) | `PrimePackets/ErgodicDecomposition.lean` | 509 | 28 files, 22,632 lines | not trialled | **used cone unmeasured** | — |
| M0-inv (module M5's input) | `DukePrimeDegree/Entropy/EntropyInverse.lean` | 92 | 2 files, 545 lines | not trialled | — | — |

**The three numbers.** (a) Of the gap between the pins (1,502 Mathlib commits by the release's own count), these 1,236
lines hit **five names, each a rename, seven tokens in all; no proof was repaired**. (b) The maximal inequality's used
cone is **243 lines** against a declared 89 files and 43,434 lines: with its two import lines replaced nothing is
missing, as the deriver read. (c) **The bridge types against the real constants** (bundle `Bridge`: the release's file,
this library's `Rigidity/Entropy`, and `data/fs131/kn6/bridge-statements.lean`; 0 errors): `nameCell_eq_orbitName_fibre`
and `blockEntropy_eq_observationEntropy` are proved there; `partitionEntropy_eq_ofReal_observationEntropyRate` and
`ksEntropy_eq_measureEntropy` are typed with `sorry`, for a probability measure and every map, with no invariance.
*What the times measure*: elaboration with Mathlib's compiled files in the page cache; the first run of the first file
read 484 s on the wrapper's clock because it waited for the slot behind another job.

**How the port is made** (`LEAN.md` § Assumptions, "An outside Lean proof may be ported"): by FS-132's generator's method
(`tools/fs132_i2_port.py`: copy by line range, refuse a patch to a statement or a definition, the licence text beside the
modules — `Proofs/HadwigerNelson/Outside/OAIMath2026-LICENSE.txt` is already there — and each header the notice of
change), into `Outside/OAI015Shannon`, `Outside/OAI015Mixtures`, `Outside/OAI015Maximal`; the renames above are the whole
patch list for these three. The release's four scoped-instance and namespace questions are the generator's. **Held for
the coordinator**: the read-back across pins compares stored terms and needs the release's compiled constants; for
M0-shannon and M0-mix that is two files over the release's Mathlib, for M0-max it would be its declared cone of 89 files
— I propose the read-back for the first two and, for M0-max, the generator's text identity alone (the kernel checks the
proofs here either way; the statement is the classical maximal inequality, read against EN2 § 5.1 row 4 by me: it is
that row word for word).

### 5.2 The chain's entropy pinned to the number the printed theorem means — the read-back

The page's number (`[EinsiedlerLindenstrauss2022]` Thm 1.3 (4), "`h_{µ_j}(αⁿ_{X/G_j}) = 0`"): for a probability measure
`µ` preserved by `T`, `h_µ(T) = sup_ξ lim_n (1/n) H_µ(ξ ∨ T⁻¹ξ ∨ … ∨ T^{−(n−1)}ξ)` over finite measurable partitions
`ξ`, natural logarithm (no page for the definition is held: the first planner's prior-art debt stands).

| the textbook's clause | this library | relation | how it is known |
|---|---|---|---|
| a finite measurable partition `ξ` | a measurable label map `P : X → Fin k` (empty cells allowed; a cell of mass `0` adds `negMulLog 0 = 0`) | the same supremum | by reading; `ksEntropy_eq_measureEntropy` (typed) says the release's independent definition agrees |
| the atoms of `⋁_{j<n} T^{−j}ξ` | `nameCell T P n w` | equal | `mem_nameCell` (proved, `Iff.rfl`) |
| `H_µ` of that partition | `blockEntropy μ T P n` | equal | the definition; drift checks `blockEntropy_one` (leaf), `blockEntropy_nonneg` (proved) |
| `lim_n H_n / n` | `partitionEntropy μ T P = inf_n H_{n+1}/(n+1)` | **`≤` for every measure and map, with nothing to prove** (`partitionEntropy_le_liminf`, proved); **`=` for a preserved probability measure** | the pinning theorem `tendsto_blockEntropy_div` — **a leaf, not proved** |
| the supremum over `ξ` | `ksEntropy μ T` | equal | the definition |
| the factor `X/G_j` | the quotient σ-algebra: `ksEntropy` of the pushed measure is `ksEntropyOn` of the pulled-back σ-algebra | equal | `ksEntropy_map` — a leaf |

**What this closes and what it leaves.** The first planner's hole was "is `ksEntropy` larger than the textbook's number
anywhere the axiom reads it?" — **closed by construction**: the entropy occurs in the declared statement once, in the
conclusion, as "`= 0`" (the stored statement re-read from the kernel after this job, Stage 5.5), and the infimum is below
every reading of the limit. Left, and read only by our own proofs: that it is not *smaller* (the pinning theorem), and
the positive model (the two-shift at `log 2`, draft M1's statement 6) — **not typed here**: it needs a product measure
on sequences, and its lower bound wants the release's `measureEntropy_lower_of_good_atoms` through the bridge.

### 5.3 The statements, typed and compiled

In `Rigidity/Entropy` (through the build, Stage 5.5), `sorry` at the leaves only: `tendsto_blockEntropy_div`,
`blockEntropy_one`, `ksEntropy_id`, `ksEntropy_dirac`, `ksEntropy_map`, `exists_blockEntropy_le_mul`,
`ksEntropy_eq_iSup_ksEntropyOn`, `ksEntropy_bind_eq_zero`. In `data/fs131/kn6/bridge-statements.lean` (compiled only in
the scratch bundle, because their constants exist in the library only after the port): the four bridge lemmas, two
proved. **Not typed in Lean by this job**: EN2-CNT and EN2-ZE (their statements are in M8's claim list, EN2-ZE also in
this library's words) — lane M8a's first step is a planner's, or this record's successor's; and the two-shift.

### 5.4 A plan per leaf (lane M1: one file, `Rigidity/Entropy`)

Every Mathlib name below was `#check`ed at the pin under `import Mathlib` (`data/fs131/kn6/checks.lean`, log
`logs/checks.log`: 31 names found; one asked for and absent, `Measure.sub`, which no leaf here uses). A name exists at the
pin; whether the module's imports see it is checked by the implementer where it is used (`LEAN.md`).

*Needing no port — can start today:*

1. **`blockEntropy_one`.** Reindex the sum over `Fin 1 → Fin k` by `Equiv.funUnique (Fin 1) (Fin k)` (`Fintype.sum_equiv`);
   the cell of `w` at length one is `P ⁻¹' {w 0}` (`Set.ext`, `mem_nameCell`, `Function.iterate_zero`). Nothing hard.
2. **`ksEntropy_id`.** `ksEntropy_eq_zero_iff`; child `blockEntropy_id : blockEntropy μ id P (n + 1) = blockEntropy μ id P 1`
   (a word that is not constant has an empty cell, `Real.negMulLog_zero`; the constant word `c` has cell `P ⁻¹' {c}`;
   `Function.iterate_id`); then `partitionEntropy_le` at every `n` and `H_1 / (n + 1) → 0`. Hard: the reindexing in the
   child (constant words against labels) — `Finset.sum_subset` over the image of `c ↦ fun _ => c`.
3. **`ksEntropy_dirac`.** `ksEntropy_eq_zero_iff`; each cell is measurable (`measurableSet_nameCell hT hP`), so
   `Measure.dirac_apply'` makes its mass `0` or `1`; `Real.negMulLog_zero`, `Real.negMulLog_one`; every `H_n` is `0` and
   so is the infimum. Nothing hard.
4. **`ksEntropy_map`.** Stage 3b item 4 (three children and the case `IsEmpty X`).

*After M0-shannon lands* (the lane's first act then: add the import, and move the four bridge lemmas of
`data/fs131/kn6/bridge-statements.lean` into the file, the first two with their proofs):

5. **`partitionEntropy_eq_ofReal_observationEntropyRate`** (bridge). `Monotone.map_csInf_of_continuousAt` for
   `ENNReal.ofReal` (`ENNReal.ofReal_mono`, `ENNReal.continuous_ofReal`) on the image over `Set.Ici 1`, bounded below by
   `0` (`blockEntropy_nonneg` through `blockEntropy_eq_observationEntropy`); then `sInf_image` and the reindexing
   `n ∈ Ici 1 ↔ n = j + 1`. Hard: that reindexing, and the cast `((j + 1 : ℕ) : ℝ) = (j : ℝ) + 1` (`Nat.cast_succ`).
6. **`ksEntropy_eq_measureEntropy`** (bridge). `iSup_congr` twice; `Measurable P ↔ ∀ a, MeasurableSet {y | P y = a}` for
   a map into `Fin k` (`→` by `measurableSet_singleton`, `←` by `measurable_to_countable'`); leaf 5.
7. **`tendsto_blockEntropy_div`** (the pinning theorem). The release's `tendsto_observationEntropyRate μ hT P _` (its
   fibre hypothesis from `hP`), composed with `ENNReal.continuous_ofReal`, shifted by `tendsto_add_atTop_iff_nat 1`, and
   rewritten by leaves 5 and `blockEntropy_eq_observationEntropy`. (Fekete's lemma itself is Mathlib's
   `Subadditive.tendsto_lim`, already used inside the release's proof.)
8. **`exists_blockEntropy_le_mul`.** Leaf 7 with `h0` gives convergence to `0`; `tendsto_order` gives eventually
   `< ENNReal.ofReal ε`; with `Filter.eventually_ge_atTop K` take one `n`; `ENNReal.ofReal_lt_ofReal_iff hε` and
   `div_lt_iff₀` give `H_{n+1} < ε (n + 1)`. Nothing hard.

*After M0-mix lands:*

9. **`ksEntropy_bind_eq_zero`.** Leaf 6 on both sides (a Markov kernel's values and `τ.bind κ` are probability
   measures), then the release's `measureEntropy_kernel_zero τ κ hT hκ _`, whose `κ ∘ₘ τ` is `τ.bind κ` (the implementer
   confirms the unfolding at the pin). Nothing hard.

*After M0-gen lands (module M7's input; not needed by M8a):*

10. **`ksEntropy_eq_iSup_ksEntropyOn`** (T2). `≥`: `ksEntropyOn_le_ksEntropy` with `𝒜 i ≤ m` from `hgen`. `≤`: the
    release's `measureEntropy_eq_iSup_generating` for finite partitions `Q_n` that increase and generate — built from
    countable generators of the `𝒜 i` by a diagonal enumeration, `Q_n` measurable for `𝒜 n` by `hmono`; then
    `partitionEntropy_le_ksEntropyOn`. **Hard, and open in this plan**: I read that theorem only by its head in the
    first planner's survey; lane M0-gen's implementer reads its exact hypotheses before this leaf is started, and if
    they do not fit the statement typed here the leaf comes back to a planner.

### 5.5 The second build, and the declared statement read again from the kernel

After the passes and the typing: `./scripts/build.sh` under the slot, `BATCH=8` — `==> build: OK — 249 of 249 batches,
4 module(s) rebuilt, 3 module(s) with warnings, 6m54s`, `exit=0` (`logs/build-2.log`); rebuilt: `Rigidity.Entropy`,
`Rigidity.PositiveEntropy`, `Rigidity.ChainAtTA`, `Proofs`; fifteen warnings, each `declaration uses 'sorry'` (`Entropy`
8, `PositiveEntropy` 1, `ChainAtTA` 6), **no other**. Memory sample 7.86 GiB summed, 6.22 GiB the largest — **that
figure is my own `import Mathlib` check that ran beside the build**, not a compiler of the build (each module compiled
in under 3 s). `lake lint`: `exit=0`, `Linting passed for Proofs`, 14 linters passed (`logs/lint-2.log`).
`tools/check_architecture.py`: PASS (it failed, as it should, on `ChainAtTA`'s new import until the map's row said so).

- **The axiom's stored statement is unchanged**: `#check @positive_entropy_rigidity` from the built tree
  (`logs/FirstLayerCheck-after.log`) is character for character the first planner's print (1,764 characters);
  `tools/fs131_kn3_axiom_binders.py` on the new print: the four instance binders are bound.
- **The headline as the kernel has it** takes eight hypotheses; the first planner's print has nine, the one that left
  being `(SpectralChain.TCA F → NoRamifiedStableDyadic F)` — read by eye from the two prints. (A comparison I scripted
  inline for the headline found neither block and so compared nothing with nothing; it is not cited.)
- Axiom lists from the built tree (`logs/AxiomsCheck.log`): § Theorems this phase proved.

### 5.6 The lanes, and what each writes

| lane | writes | needs | who |
|---|---|---|---|
| **P** — the port, M0-shannon, M0-mix, M0-max | three new files under `Outside/`; their rows in `Proofs.lean` and `ARCHITECTURE.md` | Mathlib | an implementer, with FS-132's generator; hours |
| **E** — entropy, M1 | `Rigidity/Entropy.lean` only | leaves 1–4 nothing; 5–9 lane P's first two files; 10 M0-gen | an implementer from § 5.4 |
| **N** — the names at entropy zero, M8a | one new file, `Rigidity/ZeroEntropyNames.lean` | lane P's `OAI015Maximal`; `exists_blockEntropy_le_mul` (stated) | first a planner's hour to type EN2-CNT and EN2-ZE, then an implementer from Stage 3b items 2–3 |
| **C** — the smaller set, C0 | `Rigidity/ChainAtTA.lean` only: `measurableSet_TA` (Stage 3b item 5), `rot_preimage_TA`, `exists_nonTorsion_unitVector`, and "the point mass at `1` is rotation-invariant" | — | an implementer |

No two lanes write one module. `Proofs.lean` and `ARCHITECTURE.md` gain one row per new module in lanes P and N; the
landing joins them.

## Stage 6 — SAVED: what the four items of the declared theorem still lack (for the coordinator)

`Rigidity.positive_entropy_rigidity`, against `LEAN.md` § Assumptions' four items, after this job:

1. **Docstring** — names the key, the theorem, § 1.1, pp. 2–3 of arXiv:2101.11120v1, and now says in what sense its
   entropy is meant and in which direction. **Lacks**: the journal's page numbers (ETDS 42 (2022) 691–736; only the
   arXiv text was read).
2. **Read-back** — the first planner's table (KN3 § 5.3) stands, and this job adds § 5.2's table for the entropy.
   **Lacks**: a second reader against the page. **What that reader should be told**:
   - *the entropy*: clause (4) is stated with the infimum of `H_n / n`, not a limit. It is the textbook's number for the
     measures the clause is about (a leaf, `tendsto_blockEntropy_div`, not proved), and the statement is within the
     page whether or not that leaf is ever proved, because the entropy occurs once, in the conclusion, as "`= 0`" —
     the reader should confirm exactly that against the stored statement, and that no hypothesis mentions an entropy;
   - *three senses the page leaves open*: "no virtually cyclic factors" (FS105-VC's forced sense — the residual trust
     of the axiom; a reading that asked less of the action would make the axiom stronger than the page); "ergodic" as
     triviality of the *strictly* invariant sets — formally the weaker property, hence the stronger axiom, and equal to
     the textbook's for a countable group by an argument that is **not a theorem of this library**; the `ν j` as
     probability measures;
   - *the factor*: the σ-algebra on `X/G_j` is the quotient σ-algebra. That it is the Borel σ-algebra of the quotient
     for a solenoid is asserted in the first planner's table from Mathlib's `QuotientAddGroup.borelSpace` and is **not
     a theorem of this library for `IsSolenoid X`** (it needs the solenoid to be Polish, from the countable dual). Read
     measure-theoretically the two agree with no topology: the quotient σ-algebra pulled back to `X` is the
     `G_j`-invariant Borel sets, which is what "the factor `X/G_j`" means for a measure;
   - "compact group" is read as Hausdorff; `d ≥ 2` is explicit; every binder is in the signature and the stored type
     was read from the kernel after this job.
3. **A model of the hypotheses** — `positive_entropy_rigidity_model`, on the standard three axioms, **degenerate** (the
   one-point solenoid: the clause on factors is empty). **Lacks**: the model that exercises every clause, PE-1′ (module
   M6). The axiom's conclusion is true at the degenerate model (`J = 1`, `G = ⊤`); that is said here and is not a
   theorem of the library.
4. **`ARCHITECTURE.md` § Trust and the audit** — nothing is written: the branch is a skeleton. **Lacks, at the first
   landing that proves a record from it**: the § Trust line (KN3 § 5.3 item 4's draft, to which add "its entropy is the
   infimum form; see the docstring") and one `AxiomAudit.declareImport` line. Also owed by the pipeline, not by this
   statement: the `LEAN.md` rule on an axiom's binders (inventory item 659 (a)).

## Drafts for files I do not write

- **`LEAN.md` § Searching — Lean**, a new line: "With two `MeasurableSpace X` binders in scope, `(μ : Measure X)` is a
  measure for the last one, even when both are implicit: a statement about a sub-σ-algebra `𝒜` of `m` writes
  `(μ : @Measure X m)` (`Rigidity.ksEntropyOn_mono`, `ksEntropyOn_le_ksEntropy`; found by a type mismatch in a one-line
  proof — with a `sorry` body it would have stood as a statement about a measure on `𝒜`) (FS131-KN6)."
- **`LEAN.md` § Assumptions**, to follow the port paragraph: "A port is priced from a trial, not from a line count:
  copy the files into the ignored `build/` with their imports replaced, scan the copies for anything that runs code at
  elaboration (with a planted control), and elaborate one at a time at this pin
  (`tools/fs131_kn6_release_copy.py`, `data/fs131/kn6/trial.sh`): four entropy files of `[OAIMath2026]` family 015,
  1,236 lines, needed seven one-token renames and no repaired proof; a declared import cone (89 files) can be 370 times
  the used one (243 lines) (FS131-KN6)."
- **`data/fs131/claims-NF2.md` § Dated lines**: the three lines of Stage 4.
- **`BIBLIOGRAPHY.md`, `[OAIMath2026]`**, reading status, to follow the first planner's line: "family 015's
  `PrimePackets/ShannonEntropy.lean`, `EntropyMixtures.lean`, `DukePrimeDegree/Dynamics/HopfMaximal.lean`,
  `MaximalOccupation.lean` and three declarations of `PrimePackets/InverseEntropy.lean` elaborated at this library's pin
  in scratch copies by FS131-KN6 (2026-10-14; 0 errors after seven renames; no proof read by it beyond the lines its
  errors named)."
