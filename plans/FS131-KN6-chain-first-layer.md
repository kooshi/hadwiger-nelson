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
