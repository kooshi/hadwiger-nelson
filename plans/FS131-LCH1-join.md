# FS131-LCH1 — the five-colour chain's landing, part 1: the join with `main`, and the ruled integrations

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-LCH1-join.md` (with its two amendments of 2026-10-14 21:34
and 21:36 UTC). Branch `fs131-wlc`, cut from `fs131-wm15` at `77d9d27ce` in the tree `.claude/worktrees/fs131-wq1`.*

## Theorems this phase proved

Each is [kernel], from the joined tree's compiled library at build 5 (`data/fs131/lch1/axioms-all-5.txt`):
- `Rigidity.min_localBound_five_le_chromaticNumber : ∀ (F : Subfield ℝ) [NumberField F], min (localBound F) 5 ≤ χ(F²)`, no hypothesis (`Rigidity/ChainHeadline`) — `[propext, Classical.choice, Quot.sound, Rigidity.positive_entropy_rigidity, StandingFive.kloosterman_bound]`.
- `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five : χ(ℚ(√47)²) = 5`, no hypothesis (`Instances/SqrtFortySevenFive`) — the same five.
- `Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound`, and in `Instances/SqrtClassValues` `χ = 5` at `ℚ(√143)`, `ℚ(√311)`, `ℚ(√335)`, `ℚ(√3, √5)` and `χ ≥ 5` at `ℚ(√167)`, each with `hOA` dropped — the same five.
- `Plane.mOne_le_0_2470 : mOne ≤ ENNReal.ofReal 0.2470`, `Plane.mOne_lt_one_quarter : mOne < ENNReal.ofReal (1 / 4)` (`Plane/MOneBound`) — the standard three.
- `Rigidity.henselCount_of_two_notMem`, `Rigidity.newCharBound_of_two_notMem`, `CertLink.exists_fibreShareBound_nineteen` (`Rigidity/ClassRatio`; FS131-IKL1's drafts, stated here), `CertLink.fibreShareBound_three`, `CertLink.card_le_of_fibreShareBound_model` (`Rigidity/CertLinkModels`) — as `axioms-all-5.txt` prints them (none `sorryAx`).
No statement of the skeletons was changed but the ruled ones (stage 4–5's statement check).

## Stage 1 — SAVED (the readback)

**Quotations.** `tools/fs131_lch1_quotes.py` checks each `> …` block of the brief against its named source at
`bd3bd9541`: **7/7 match** (`data/fs131/lch1/quotes.out`); its control mutates one character of every block and
requires every block to fail: **7/7 failed** (`quotes-plant.out`). No mismatch: no finding about the brief.

**The stored statements, dumped before any edit was compiled** (`data/fs131/lch1/lean/StatementDump.lean`, every constant
of every `Proofs.*` module; full text for the modules named in `$LCH1_FULL`, hashes for the rest), run by
`data/fs131/lch1/dump-before.sh` inside one slot:
- the chain tree, its compiled library current for `fs131-wm15` at `77d9d27ce` (`lake build --no-build` under the slot:
  "All targets up-to-date (6125 jobs)", `nobuild-before.log`): **1,938 modules, 27,186 constants**, 2,480 in full-text
  modules (`Rigidity/*`, `Plane/WindowDensity`, `Plane/OneAvoidingDensity`, `Instances/SqrtFortySeven*`,
  `Instances/SqrtClassValues`, `Outside/OAI015*`, `Arith/UpperHalf`, `SpectralChain`);
- `main`'s gated build (`fs131-w10g`): **2,010 modules, 32,014 constants**, 634 in full-text modules
  (`Plane/OneAvoidingDensity`, `Plane/OneClass/*`, `Arith/ThreeFourColours`, `Instances/SqrtFortySeven`, `Arith/UpperHalf`,
  `SpectralChain`, `Plane/DensityBound/Theorem`).

The raw dumps (474 MB and 1.59 GB, `statements-before-{chain,main}.txt`, sha256 in `statements-before.sha256`) stay on
disk uncommitted; what is committed is `data/fs131/lch1/split_dump.py`'s split of each: an index of every constant
(module, kind, name, flags, type hash, value hash, data hash: `statements-before-*.index.tsv.xz`) and the full text of
the full-text modules (`statements-before-*.full.txt.xz`). M13's line (`fs131-wcm3`) is read from FS131-ICM3's own last
dump on that branch (`data/fs131/icm3/statements-after4.txt.xz`, copied to `data/fs131/lch1/m13-icm3-after4.txt`), made
in its worktree (LEAN.md § Searching — Lean: "a module from another branch with a dump made in that branch's worktree").

**The collision scan, predicted and read.** Prediction, written before the kernel-side scan from a source-level prescan
of the 783 names the chain's added files declare against the 3,907 main's added files declare: two names declared in two
modules — `Plane.mOne` (known, item 916) and `Plane.mOne_le_one` (`Plane/WindowDensity` l. 378 against
`Plane/OneClass/Defs` l. 217) — and nothing else. `tools/fs131_lch1_collisions.py` on the three dumps: the chain lines'
57 modules (2,416 constants) and the add/add copy against main's 2,010 modules (32,014 constants): **2 collisions,
exactly the predicted two** (`data/fs131/lch1/collisions.out`); in the add/add module, the chain's copy holds one name
main's lacks (`DEF Plane.mOne`) and main's holds two the chain's lacks (`mOne_eq_iSup_bandFree`, `BandFree.eq_1`). The
control plants one collision and one dropped name and requires both reported: **both reported**
(`collisions-plant.out`). Both collisions were sent to the coordinator at once; ruled (the brief's amendment of 21:36
UTC). The eleven `InvariantLaw` helpers to be made public and `UpperHalf.exists_I_integer` are names neither dump
declares publicly (checked by name in both dumps): making them public collides with nothing.

**Integration 6 does not go through as ruled** (sent at once; ruled in the amendment of 21:34 UTC): `Plane.oneAvoidingDensityBound`
is declared in `Plane/DensityBound/Theorem`, which imports `Plane/DensityBound/Window`, which imports
`Plane/OneAvoidingDensity`; the two corollaries live in a new module `Plane/MOneBound`.

## Stage 2 — SAVED (the merges)

1. **`main` at `bd3bd9541`**, merged as `f50277130`. Conflicts, each resolved by `data/fs131/lch1/resolve_main.py`
   (decisions printed to `resolve-main.out`):
   - `Plane/OneAvoidingDensity` (add/add): **main's whole** (`git diff bd3bd9541 -- <file>` empty).
   - `Proofs.lean`: both sides (the chain's five `OAI015` imports, main's 32 port imports); one duplicate
     `import Proofs.HadwigerNelson.Plane.OneAvoidingDensity` (both lines added it) removed.
   - `ARCHITECTURE.md`, four hunks: (1) main's (the OneAvoidingDensity row and the density bound's 82 rows; the chain's
     skeleton row dropped); (2), (3) both sides (the chain's Rigidity and Instances rows with main's Arith rows; the chain's
     `OAI015` rows with main's 32 port rows); (4) the trust table: the chain's `positive_entropy_rigidity` row kept, its
     `proper_to_borel_weak` row dropped (a theorem on main since FS131-LP1), main's sentence with its count three.
   - `scripts/Axioms.lean`, one hunk of prose: joined — three imports (Weil's bound, `no_proper_five_coloring`,
     `positive_entropy_rigidity`), the transfer a theorem. The `declareImport` lines auto-merged to exactly those three.
   - `scripts/assumptions-ledger.txt`: the chain's nine `RESTS` rows on `positive_entropy_rigidity` kept; its twelve
     `RESTS` rows on the transfer dropped (main's deletion). The counts are part 2's.
2. **M13's line `fs131-wcm3` at `c0b6798ed`**, merged as `06840bd6a`. One conflict, `ARCHITECTURE.md`'s Rigidity rows
   (`resolve-wcm3.out`): the chain's six current rows kept, M13's `ClassRatio` row taken (its imports cell names
   `Arith/GapSeven` and `Arith/CircleCos`, as the merged module does). `Rigidity/ClassRatio` and `Proofs.lean` auto-merged.

**Neither merge builds alone, by construction**: main's `Plane/OneAvoidingDensity` declares no `mOne`, so the chain's
readers of KR1's definition by its shape (`Plane/WindowDensity`) fail until integration 1; and integration 3 needs M13's
`ratioAtMost_of_two_notMem`. The first build is therefore of both merges with the integrations; every upstream edit
(`Arith/UpperHalf`, `Plane/OneClass/InvariantLaw`) is made before it, so that main's modules are compiled once.

## Stage 3 — SAVED (the integrations, written; commit `bf6436b54`, unbuilt)

Every integration is written before the first build, so that `main`'s modules compile once. Each is checked from the
kernel's side after the build (stage 4): `tools/fs131_lch1_statements.py` against stage 1's dumps, with the ruled
changes undone by `data/fs131/lch1/lean/ReAdd.lean`'s term surgery.

1. **The old `mOne` through its bridge.** `Plane/WindowDensity`: `volume_inter_sq_le`'s `le_iSup₂` and
   `exists_dense_window`'s `lt_iSup_iff` read `main`'s `mOne` through `Plane.mOne_eq_iSup_bandFree` (one `rw` each);
   `mOne_ne_top` and `mOne_toReal_le_one` through `main`'s `Plane.mOne_le_one`; **the chain's `Plane.mOne_le_one`
   deleted** (no reader; amendment of 21:36). `Rigidity/CountDescent` and `Rigidity/PlaneZhang` read `mOne` as a value
   only (`mOne.toReal`, `mOne < …`): no source edit; their stored types keep the constant name `Plane.mOne`, which now
   names `main`'s definition (`Plane/OneClass/Defs`, a supremum over Borel sets), equal to the deleted one's value by
   `mOne_eq_iSup_bandFree`.
2. **`hOA` and `hRow99` discharged.** `Rigidity.min_localBound_five_le_chromaticNumber` takes no hypothesis: `hCount` is
   `Counting.count_of_oneAvoidingDensityBound Plane.oneAvoidingDensityBound`, `hRow99` is
   `ThreeFourColours.localBound_le_chromaticNumber_of_le_four F`; `Rigidity/ChainHeadline` imports `Plane/MOneBound` (and
   so `Plane/DensityBound/Theorem`) and `Arith/ThreeFourColours`. The seven χ statements of M15, `hOA` dropped:
   `Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound`,
   `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five`, and in `SqrtClassValues` the values at `ℚ(√143)`,
   `ℚ(√311)`, `ℚ(√335)`, `ℚ(√3, √5)` and `five_le_chromaticNumber_planeOver_sqrt167`. One form each: no conditional
   form is kept beside them.
3. **The link deleted.** `Rigidity/SqrtClassFive`'s private `ratioAtMost_two_notMem_link` (its one `sorry`) deleted;
   `five_le_chromaticNumber_of_two_notMem` reads M13's `Rigidity.ratioAtMost_of_two_notMem`. Text of the two
   statements identical (`SqrtClassFive.before.lean` l. 104–106; `ClassRatio` l. 2430 on `fs131-wcm3`); the kernel-side
   comparison in stage 4.
4. **One copy of each fact.**
   - `Plane/OneClass/InvariantLaw`: `private` removed from the eleven helpers (`avgMeasure`, `avgMeasure_apply`,
     `isProbabilityMeasure_avgMeasure`, `avgMeasure_map`, `integral_avgMeasure`, `map_eq_of_tendsto`,
     `map_eq_of_tendsto_of_eventually`, `measure_compl_eq_zero_of_tendsto`, `isClosed_setOf_of_tendsto`,
     `exists_fixed_of_average`, `exists_common_fixed`), a docstring added to the four that had none; no statement
     touched. `Rigidity/InvariantMeasure`: M3's eleven copies deleted, `Plane.OneClass.InvariantLaw` imported, the
     readers qualified (`OneClass.…`; 13 occurrences); M3's own `avgMeasure_eq_zero`, `avgMeasure_map_eq`,
     `continuous_shiftCol`, `continuous_rotCol`, `map_compl_eq_zero` kept.
   - `zeroEntropyCarried` kept (three readers: `ChainHeadline` l. 56, `ZeroEntropyClosed` ll. 53, 64);
     `zeroEntropyCarried_of_numberField` (one reader, `zeroEntropyCarried` itself) removed, its proof moved into
     `zeroEntropyCarried`; the docstrings say so.
   - `UpperHalf.exists_I_integer` public (statement untouched); `Rigidity/SqrtClassFive`'s private copy deleted, its one
     reader reads `UpperHalf.exists_I_integer`. `ClassRatio`'s copy (`exists_I_int`) stays until part 2.
5. **The old conditional retired.** `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five_of_chain` deleted from
   `Instances/SqrtFortySeven` (its module doc points to the new theorem); its `#print axioms` line removed from
   `scripts/Axioms.lean`. Its six `TAKES` rows in `scripts/assumptions-ledger.txt` go with part 2's `--write-ledger`.
6. **The two corollaries**, in the new module `Plane/MOneBound` (amendment of 21:34):
   `Plane.mOne_le_0_2470 : mOne ≤ ENNReal.ofReal 0.2470` and `Plane.mOne_lt_one_quarter : mOne < ENNReal.ofReal (1 / 4)`,
   each one line; the module is in `Proofs.lean` and `ARCHITECTURE.md`.
7. **`Rigidity.archTop`'s `[NumberField ↥F]`**: already in the ruled else-form on the chain's line —
   `@[reducible, nolint unusedArguments]` with its reason in a comment (`ContinuityGroup` l. 43: dropping it moves the
   stored types of `archTop`, `tauPrime` and every statement over them; inventory item 863, ruling 1). Nothing to do.
8. **The docstring sweep.** 32 module titles that said "skeleton" (31 of `Rigidity/`, `Plane/WindowDensity`): "; skeleton"
   removed where the module holds no `sorry`, and `RingScope`'s rewritten to name its one open leaf,
   `unitRing_eq_stableIntegers` (`titles.out`). `UnitCircle`'s four docstrings (item 897's D2) were already done by
   FS131-IJN1 (read: title, module paragraph, models, `exists_admissiblePair`). Stale prose the merge exposed:
   `ChainHeadline`'s module doc and headline docstring, `SqrtClassFive`'s, `SqrtFortySevenFive`'s, `SqrtClassValues`'s,
   `ZeroEntropyClosed`'s, `CountDescent`'s two sentences on "the named outside hypothesis", `WindowDensity`'s two on `m₁`,
   `InvariantMeasure`'s comment; `ARCHITECTURE.md` rows of `InvariantMeasure`, `ChainHeadline`, `ZeroEntropyClosed`,
   `SqrtClassFive`, `SqrtFortySevenFive`, `SqrtClassValues`, `Pieces` (no `sorry` since IJ3), `OneClass/InvariantLaw`,
   `Instances/SqrtFortySeven`, `WindowDensity`, and the new `Plane/MOneBound` row. **Comment-stripped code unchanged**
   in the 30 files whose edits are prose only (`tools/fs131_lch1_code_only.py` from `06840bd6a` to `bf6436b54`: 30/30 the
   same, `code-only.out`; its control adds one code character to each and sees 30/30 differ, `code-only-plant.out`).

## Stage 2b — SAVED (two more merges, by the brief's third amendment, 22:32 UTC)

**The first build, stopped twice.** (1) `BATCH=8` (`data/fs131/lch1/build-1-oom.log`, full log `build-1-oom-full.log`):
batch 21 of 275, eight `Plane/DensityBound/Cells/PartNN` modules, exit 143 twice ("Terminated") after 125 and 129 s; the
user journal records `The kernel OOM killer killed some processes in this unit` / `Failed with result 'oom-kill'` for
both scopes (`build-1-oom-journal.txt`). **Mechanism:** eight `decide +kernel` cell modules at about 2 GB each
(LEAN.md: "1.95 GB resident", "1.6–2.4 GB") exceed the 10 GiB cap; the cap killed its own scope, nothing else. Rerun
at `BATCH=3`. (2) At `BATCH=3` (`build-1-stopped.log`): stopped by me at batch 364 of 699 (22:36 UTC), process group
845264 signalled, the group absent from `ps` and the log static over 10 s, so that the third amendment's merges could
be made without editing files a running build would compile ("a run that blocks something is presumed killable"). It
forfeited only the walk's position: the 32 modules it had compiled are kept (Lake skips them).

3. **M13's dyadic certificates, `fs131-wcm4` at `ff3ac0c73`** (contains `fs131-wcm3`), merged on top as `eba5fc3a4`. One
   conflict, `ARCHITECTURE.md`'s Rigidity rows (`data/fs131/lch1/resolve_rows.py`, `resolve-wcm4.out`): the chain's rows
   kept, M13's `ClassRatio` row taken. `Rigidity/ClassRatio`, `Proofs.lean` auto-merged; `Arith/BinaryField`,
   `Arith/DyadicCerts` added. Not edited by me (the amendment).
4. **The bound at p = 19, `fs131-wc17` at `3aeb2c624`** (contains `fs131-wc16`), merged as `a9d839f8b`. No conflict on the
   tree that already held `wcm4`: `ARCHITECTURE.md` and `Proofs.lean` auto-merged (no doubled import, no doubled row);
   81 `Arith/FibreCert*` modules added. Not edited by me.

**Collisions, for the late lines** — prediction: none. Source-level prescan of the 370 public names the two lines'
added or changed files declare against both before-dumps' names: **0 declared in another module**
(`collisions-late-prescan.out`). The kernel-side scan for them is `scripts/dupnames.sh` on the joined tree (stage 4),
which reads each module's compiled constants. `tools/check_architecture.py` on the joined source: PASS (`arch-pre.out`).
The build of the four-way join: `data/fs131/lch1/build-2.log`, `BATCH=3`, `MEMMAX=10G`.

## Stage 2c — SAVED (the certificate link, by the brief's fourth amendment, 22:52 UTC)

**The second build, stopped twice.** `BATCH=3`, 10 GiB (`build-2-oom.log`, `build-2-oom-full.log`): batch 201 of 725 —
`Additive`, `Arith/FibreCert11Seg5`, `Arith/FibreCert19C0` — exit 143 twice, the journal's `oom-kill` for both scopes
(`build-2-oom-journal.txt`). **Mechanism:** FS131-IKC4's check modules peak at 5.4–7.3 GiB each (its record § 3.2: `C0`–`C7`
5.36–6.61, `Seg0`–`Seg3` 5.64–7.28, `Psd*` 4.85–5.85); two in one batch pass 10 GiB. Rerun at `BATCH=2` under
`--mem 16 MEMMAX=16G` (2 × 7.3 < 16; the slot was empty: "reserved 0 GiB"). That run (`build-3-stopped.log`) was
stopped by me at batch 489 of 1,084 for the fourth amendment's merge (process group signalled, absent, log static); it
forfeited the walk's position only.

5. **The certificate link, `fs131-wkl` at `b2a2b06d3`**, merged as `5b164748f`. Conflicts (`resolve-wkl.out`):
   `ARCHITECTURE.md`, two hunks — the chain's rows kept, the link's `Rigidity/CertLink` and `Rigidity/CertLinkModels` rows
   added; `Proofs.lean` — the link's two imports added, its duplicate `Plane.OneAvoidingDensity` import removed.
6. **The link's drafts applied** (its record `fs132-wi1:plans/FS131-IKL1-implementation.md` § 4.1–4.2, 4.5), commit
   `7f5ecfbd8`: `Rigidity/ClassRatio` imports `Rigidity.CertLink` and `Arith.FibreCert19Bound`; the two discharge lemmas
   `henselCount_of_two_notMem`, `newCharBound_of_two_notMem` verbatim from `data/fs131/ikl1/scratch/discharge-wcm4.lean.txt`
   (public, as drafted), before the leaf; `CertLink.exists_fibreShareBound_nineteen : ∃ U : ℝ, U < 361 / 4 ∧
   CertLink.FibreShareBound 19 U := ⟨_, by norm_num, FibreCertSound.sum_le_nineteen⟩`, stated in `ClassRatio` (as
   `_root_.HadwigerNelson.CertLink.…`: the first module where both `Arith/FibreCert19Bound` and `Rigidity/CertLink` are in
   scope and that the one line can read); `ratioAtMost_cert`'s body the one line, its docstring the drafted one, the module
   docstring's "certificates at 11 and 19" sentence naming `Rigidity/CertLink`. `Rigidity/CertLinkModels` imports
   `Rigidity.ClassRatio` and holds the full model (`fibreShareBound_three`, `card_le_of_fibreShareBound_model`, from
   `data/fs131/ikl1/scratch/landing/FullModel.lean`, its `#print axioms` line left out). `ARCHITECTURE.md`: `ClassRatio`'s
   row and imports cell, `CertLinkModels`' imports cell (`check_architecture.py` PASS, `arch-pre2.out`).
7. **"`i` is an integer of `F(i)`", one public copy** (integration 4 extended): `UpperHalf.exists_I_integer` (public since
   stage 3) is upstream of all three other modules (`ThreeFourColours`, `CertLink` import `Arith/UpperHalf`; `ClassRatio`
   through `Rigidity/CertLink`); their private copies `exists_I_integer'`, `exists_I_mem`, `exists_I_int` (one statement
   text, `∃ i : 𝓞 (fieldI F), i ^ 2 = -1 ∧ conjO F i = -i`, the one `SpectralChain.conjO`, `{F : Subfield ℝ}`) deleted,
   their 4 + 1 + 5 readers reading `UpperHalf.exists_I_integer`.

The build of the five-way join: `build-4.log`, `BATCH=2`, `--mem 16`, `MEMMAX=16G`.

## Stage 4 — SAVED (the five-way join built; the headline and χ(ℚ(√47)²) = 5 with no `sorryAx`; the gate's steps that read the tree)

**Build 4** (`build-4.log`, full `build-4-full.log`; `--mem 16`, `MEMMAX=16G`, `BATCH=2`): **OK, 1,087 of 1,087
batches**, 128 modules rebuilt in this run, **one module with warnings: `Rigidity/RingScope` l. 247, `declaration uses
sorry`** (`unitRing_eq_stableIntegers`). No other warning.

**From the built tree** (`after.sh 4`: `statements-after-4.*`, `readd-4b.txt`, `axioms-all-4.txt`):
- `Rigidity.min_localBound_five_le_chromaticNumber` and `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five`, each
  with no hypothesis but `[NumberField F]` (the headline) and none (the value): axioms `[propext, Classical.choice,
  Quot.sound, Rigidity.positive_entropy_rigidity, StandingFive.kloosterman_bound]` — **no `sorryAx`** (sent to the
  coordinator at once). `Plane.mOne_le_0_2470`, `Plane.mOne_lt_one_quarter`: the standard three.
- The only `sorryAx` among the 1,453 records printed: `Rigidity.unitRing_eq_stableIntegers` itself (its one SORRY-LEAF),
  read by no record. Ruled (amendment of 23:59): deleted at this landing — stage 5.

**The statement check** (`tools/fs131_lch1_statements.py`, against stage 1's dumps and FS131-ICM4's own last dump for
M13's four modules; the ruled changes undone by `ReAdd.lean`): **expected 34,480 constants: 34,429 the same, 2 the same
read back under M3's private names (`avgMeasure_eq_zero`, `avgMeasure_map_eq`), 25 ruled deletions (with their internal
constants), 16 made public (the eleven helpers, `UpperHalf.exists_I_integer`, internal constants), 8 dropped binders put
back — each hash equal to the type before (the headline's `362919061`, as dumped in stage 1) —, 16 ruled new, 0
instance moves, 1,288 incoming (the p = 19 line's and the link's modules, merged whole); 0 reports**
(`statements-compare-4.out`). So `ClassRatio`'s stored constants after its two new imports are FS131-ICM4's (the
amendment's question): no instance moved. Controls: five plants (a changed type, a changed value, a missing constant, an
unruled new constant, a wrong re-added hash) — first run 4/5 (`statements-plant-4-first.out`: the value plant changed
the value hash and not the proof-erased one, so the DATA fallback hid it — a control that could not fire); planted in
both, **5/5** (`statements-plant-4.out`). `ReAdd`'s own control (each re-added binder replaced by `True`) gives eight
hashes all different from the before-types (`readd-4b.txt`, `CONTROL` lines). The first ReAdd missed one rename
(`avgMeasure._proof_1`, an internal constant under a helper) and the tool counted M3's two kept helpers as deleted
(a substring test): both fixed before the pass above; `readd-4.txt` is the first print.

**The gate's steps that read the tree** (`gate-steps.sh` in one slot; logs here): `scripts/dupnames.sh` **OK — no name
declared by two modules (31 generated on demand)** (prediction for the late lines: none — met); `scripts/axioms.sh`
**OK — 9,451 clean, 355 axiom-free, 34 imported, 5 declared purchases**; the guarded lint `lake lint --no-build --
--no-build --trace` **14/14 passed** (its negative control not run here: it needs a planted build, part of the full
gate); `tools/check_architecture.py` **PASS**.

**The chain's audit block, brought current** (`draft-axioms-block.lean`, generated by FS131-IJN1's
`tools/fs131_ijn1_audit_block.py` from `axioms-all-4-chain.txt` — the chain's modules on the joined tree, main's two touched
modules and `MOneBound` left out, their records already in `scripts/Axioms.lean`): **919 public records — 887 CLEAN, 16 on
`positive_entropy_rigidity`, 15 on `kloosterman_bound`, 1 OPEN (`unitRing_eq_stableIntegers`, deleted in stage 5)**;
the generator's control (an unknown axiom planted) stops it, exit 1.


## Stage 5 — Lemma C′ deleted (the fifth amendment, 23:59 UTC); its statement kept

`Rigidity.unitRing_eq_stableIntegers` — the one `sorry` stage 4 found, read by no record — is deleted from
`Rigidity/RingScope` (commit `2fcba050a`); `RingScope`'s title and docstring say that `R = O′` in the scope (Lemma C′,
`LEDGER.md` row 100) is not in the library and where it is kept; its `ARCHITECTURE.md` row likewise (`check_architecture.py`
PASS, `arch-5.log`). No gate input named it (`scripts/Axioms.lean`, `scripts/assumptions-ledger.txt`,
`scripts/vacuity-baseline.txt`: no match); the drafted chain block's one OPEN record was it. The statement check allows
this one deletion and nothing else (`tools/fs131_lch1_statements.py`, `DELETED`).

**Kept for the roadmap** (`data/fs131/lch1/ring-scope-lemma-c-prime.lean`), verbatim from the module before the edit
(`ac60951d5`, ll. 241–249):

```lean
/-- **`R = O′` in the scope** (Lemma C′, FS91-J07-4 = FS91-J10-T6; `LEDGER.md` row 100): for a real number field with no
ramified stable dyadic prime, the unit-vector ring is the ring of elements integral at every stable prime. Route
(FS91-J10's, plan § Stage 3): by `exists_mul_stableIntegers_le`, `R = O′` iff `R` maps onto `O′/cO′`, a finite product of
`O_𝔓/𝔓^m` over the stable `𝔓 ∣ c`; there the image of `U` is the product of the local norm-one images (weak approximation
for the norm-one torus, FS91-J10-L2), and the ring it generates is everything unless some `𝔓` is ramified and dyadic (at a
ramified dyadic level one the norm-one image is `{1}`). -/
theorem unitRing_eq_stableIntegers [NumberField F] (h : NoRamifiedStableDyadic F) :
    UnitRing.unitRing (conjOn (fieldI_conj F)) = stableIntegers F := by
  sorry
```

**Its route, verbatim from FS131-KN9's record** (`plans/FS131-KN9-chain-zero-entropy.md` § 3.3):

### 3.3 `R = O′` (Lemma C′), in words only — off M8b's path

Statement as typed: for a real number field with `NoRamifiedStableDyadic F`, `UnitRing.unitRing (conjOn (fieldI_conj F)) =
stableIntegers F`. Route (FS91-J10's, the shortest of the three derivations): by `exists_mul_stableIntegers_le`, `R = O′` iff
`R + c·O′ = O′` iff `R → O′/cO′` is onto; `O′/cO′ ≅ ∏_{stable 𝔓 ∣ c} 𝓞_𝔓/𝔓^{m_𝔓}` (CRT in `O′`); the image of `U` there is the
product of the local norm-one images (weak approximation for the norm-one torus, FS91-J10-L2, by the stereographic
parametrisation and the approximation theorem for `F`); the subring of a finite product of local rings generated by a product
of subgroups containing `−1` is the product of the generated subrings (idempotents from the local rings' distinct maximal
ideals); and at each stable `𝔓` the norm-one image generates `𝓞_𝔓/𝔓^m` — at an inert `𝔓` from level one (`μ_{q+1}` generates
`𝔽_{q²}`) through the graded pieces `1 + π^{m−1}H` (J10-L6's computation), and it fails exactly at a ramified dyadic level one,
where the image is `{1}` (FS100-EXC). Not sized; not on the headline's path after § Stage 4's plan; a stub-sized job (Lemma C
and C′ in the kernel are FS-47's stub, inventory item 79 of FS-91).

Build 5 (`build-5.log`, `--mem 10`, `MEMMAX=10G`, `BATCH=8`): running at this save.

**Build 5: OK, 291 of 291 batches, 26 modules rebuilt, 0 modules with warnings** (`build-5.log`, `build-5-full.log`). From
the built tree (`after-5.log`): **no `sorryAx` in any of the chain's records** (`axioms-all-5.txt`: 0); the statement
check against stage 1's dumps: **34,480 expected — 34,428 the same, 2 renamed back, 26 ruled deletions (one more than
stage 4: Lemma C′), 16 public, 8 dropped binders re-added equal, 16 new, 0 instance moves, 1,288 incoming; 0 reports**
(`statements-compare-5.out`); plants **5/5** (`statements-plant-5.out`). Gate steps on the same tree: `dupnames.sh` OK (no
doubled name, 31 generated), `axioms.sh` **OK — 9,451 clean, 355 axiom-free, 34 imported, 5 declared purchases**, lint
**14/14**, `check_architecture.py` **PASS** (`*-5.log`). Commit of the tree checked: `80fb92d1e` (sources as at
`2fcba050a`).

## Drafts for part 2 — what is left, in order (for the full gate on one commit)

Nothing is left to join: `main`, M13's line (`fs131-wcm3`, then `fs131-wcm4`), the p = 19 line (`fs131-wc17`) and the
certificate link (`fs131-wkl`) are merged, and the tree builds with no `sorry`. What is left is the full gate, as
FS131-LDB1 ran it (`plans/FS131-LDB1-landing.md` § Stage 5; previous digests `data/fs131/ldb1/gate/`):
1. **`scripts/Axioms.lean`, the chain's block**: `data/fs131/lch1/draft-axioms-block.lean` (887 CLEAN, 16 on
   `positive_entropy_rigidity`, 15 on `kloosterman_bound`; its one OPEN record is now deleted — regenerate from
   `axioms-all-5.txt` filtered as stage 4 did); the link's block (FS131-IKL1 § 4.3, plus `henselCount_of_two_notMem`,
   `newCharBound_of_two_notMem`, `exists_fibreShareBound_nineteen` under CLEAN and `card_le_of_fibreShareBound_model`
   under IMPORTED with Weil); the blocks of `Arith/FibreCert*`, `Arith/BinaryField`, `Arith/DyadicCerts` from FS131-IKC4's
   and FS131-ICM4's records; then a coverage run as FS131-LDB1's `Coverage.lean` (every public constant a record or reached).
2. **The assumptions step**: `--self-test`, a run, `--write-ledger` (it drops the retired conditional's six `TAKES` rows
   and adds the chain's); FS131-IJN1's `draft-assumptions.txt` (b) lists the entries the step asked for on the chain's line
   (`stale-condition` ×4, `undeclared-never-concluded` ×3); `hOA`'s takers now read `ESTABLISHED`; the link's three formers
   are concluded (IKL1 § 4.4); the nine counts for `CLAUDE.md`.
3. **Vacuity**: `vacuity.sh` and `--self-test`; the counts reconciled; the link's binders' model at `q = 3` (IKL1 § 4.4).
4. **The guarded lint's negative control** (a planted unused instance binder, FS131-IJN1's `lint-plant.sh` pattern, at
   `BATCH=8`: the stale set is one module and the root).
5. **The read-aloud** of the headline and of `χ(ℚ(√47)²) = 5` against `data/fs131/claims-NF2.md`, and the front page's
   drafts, each slot checked by a script.
Build width for any build that recompiles the density bound's cells or the p = 19 checks: `BATCH ≤ 2` at 16 GiB, or
`BATCH ≤ 3` at 10 GiB for the cells alone (stages 2b, 2c).

## Drafts for `LEAN.md` (§ Building and § Searching — Lean; Keryx files)

- `decide +kernel` modules in one batch share no memory: eight `Plane/DensityBound/Cells/PartNN` (about 2 GB each) are
  OOM-killed in a 10 GiB scope (exit 143, `Terminated`, the user journal's `oom-kill`), and two FS131-IKC4 check modules
  (5.4–7.3 GiB each) in one 10 GiB scope likewise; a rebuild of either needs `BATCH=3` (cells) or `BATCH=2` at
  `MEMMAX=16G` (the checks) (FS131-LCH1).
- `Expr.hash` reads no binder name: a non-dependent binder a landing drops is checked by putting it back with `mkArrow`
  inside `forallBoundedTelescope` and comparing the hash with the type dumped before (the headline's `362919061`, equal;
  a `True` in its place differs) (`data/fs131/lch1/lean/ReAdd.lean`; FS131-LCH1).
- Making a private declaration public renames every internal constant under it (`avgMeasure._proof_1`), and every stored
  value that names one moves: a comparison renames back by prefix (`Name.replacePrefix`), not by the declaration's name
  alone (FS131-LCH1).
- A corollary of a theorem cannot live in a module the theorem's module imports: check the direction before placing it
  (`Plane/DensityBound/Window` imports `Plane/OneAvoidingDensity`; FS131-LCH1's `Plane/MOneBound`).
