# FS131-KN6 — the chain under "five colours at the square root of 47": its first layer through a build, the modeling passes, the re-cut of two modules, and the entropy base planned to its leaves

*de Bruijn, the planner; successor of FS131-KN3 on the same branch. Brief: `data/fs131/briefs/FS131-KN6-chain-first-layer.md`.
Branch `fs131-wch`, worktree `.claude/worktrees/fs131-wch`. Claims: `data/fs131/claims-NF2.md`. Stands on the first planner's
record `plans/FS131-KN3-chain-plan.md` (cited as KN3 § n) and the deriver's `plans/FS131-EN2-derivation.md` (EN2 § n) and
`plans/FS131-EN1-derivation.md` § 8.1. Working files: `data/fs131/kn6/`.*

## Theorems this phase proved

*(filled in as the stages land; a planning job — the chain's leaves are not proved here)*

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
