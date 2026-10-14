# FS131-LCH1 — the five-colour chain's landing, part 1: the join with `main`, and the ruled integrations

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-LCH1-join.md` (with its two amendments of 2026-10-14 21:34
and 21:36 UTC). Branch `fs131-wlc`, cut from `fs131-wm15` at `77d9d27ce` in the tree `.claude/worktrees/fs131-wq1`.*

## Theorems this phase proved

*(filled at the hand-back)*

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
