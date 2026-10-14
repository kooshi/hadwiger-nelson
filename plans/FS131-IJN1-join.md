# FS131-IJN1 — the five-colour chain joined on one branch, its small leaves closed, its headline read from the kernel

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-IJN1-chain-join.md` (on `main`). Branch `fs131-wj`, cut from
`fs131-wt5` at `54c2bc166` in the worktree `.claude/worktrees/fs131-wq1`. Working files: `data/fs131/ijn1/`. Laptop: 12
cores, 31 GB.*

## Theorems this phase proved

(Filled at the last stage, from the final build's print.)

## Stage 1 — SAVED: the readback, the merges, build 1, the dumps taken after the merges

**1.1 The brief's quotations** (standing rule 3; `tools/fs131_ijn1_quotes.py`, FS131-ICM1's reader with its brief path
changed, against `main`'s tree): **6 quotations, 6 IDENTICAL** (`data/fs131/ijn1/logs/quotes.log`) — W2
(`data/fs131/REQUEST-2026-10-13.md`), the three dated lines of 2026-10-14 (`data/fs131/claims-NF2.md`), inventory items 761
and 791 (`plans/FS131-close-inventory.md`). **Control** (`--plant`, one character of each quotation changed): 6 of 6
MISMATCH (`logs/quotes-plant.log`). No finding about the brief.

**1.2 The merges.** `git checkout -b fs131-wj` at `54c2bc166`. `git merge-tree` named `ARCHITECTURE.md` alone for each.
- `git merge --no-ff fs131-wla` (M11 and lane A, at `afd71e422`) → **`e985c44e8`**. `ContinuityGroup` auto-merged (lane A's
  `mem_nhds_profTop` made public beside this branch's eight). The conflict in `ARCHITECTURE.md`: both sides edited the rows
  of `InvariantMeasure`, `ContinuityGroup` and `BochnerTau`; this branch's rows kept (they say "proved", the other's
  "skeleton"), with lane A's sentence "`mem_nhds_profTop` public for M11 (FS131-IM11)." added to `ContinuityGroup`'s; lane
  A's three new rows (`SpectralSubspace`, `TraceSplit`, `APlus`) added.
- `git merge --no-ff fs131-wcm` (the count and M13's composition, at `0dea51730`) → **`891b8eb4d`**. `Proofs.lean`
  auto-merged. The conflict in `ARCHITECTURE.md`: the two lines edited **disjoint** rows (this branch: M3, M10, M2b, M11
  and the entropy rows; the count line: M13, M12's eight modules, the new `CountModels`), checked by listing each side's
  changed rows against the merge base; both sides kept, row for row.
- `tools/check_architecture.py` on the joined tree: RESULT PASS.

**1.3 Build 1** (`./scripts/build.sh` under the slot, `MEMMAX=10G BATCH=8`; `logs/build1-full.log`, gate log
`build/gate/build/20261014T182448Z-82406.log`, copied to `logs/build1-gate.log`): **`OK — 257 of 257 batches, 20 module(s)
rebuilt, 5 module(s) with warnings, 8m53s`**. Rebuilt: `FiniteZhang`, `Plane/WindowDensity`, `PlaneZhang`,
`AdmissiblePrime`, `UnitCircle`, `ContinuityGroup`, `SpectralSubspace`, `CountTorus`, `BochnerTau`, `TraceSplit`, `Pieces`,
`APlus`, `EntropySplitMax`, `ClassRatio`, `CountResidue`, `CountCompletion`, `CountExtension`, `CountDescent`,
`CountModels`, `Proofs`. **Every warning is ``declaration uses `sorry` ``** (0 others, by `grep -v`): `Plane/OneAvoidingDensity`
l. 54 (`upperDensity_le_of_oneAvoidingDensityBound`), `ChainAtTA` ll. 550, 555, 562 (`entropySplit`, `zeroEntropyCarried`,
`noRamifiedStableDyadic_of_tca`), `ClassRatio` ll. 214, 224, 346, 351, 359, 366 (M13's six private leaves),
`PositiveEntropy` l. 365 (`mulTwoThree_model`), `RingScope` l. 247 (M9's `R = O′`, off the path). The one line to the
coordinator sent when it was green.

**1.4 The dumps taken after the merges** (before any edit is compiled; § Done means item 5's baseline):
- `data/fs131/ijn1/lean/StatementDump.lean` — FS131-IJ3's dumper, its module list replaced by every imported module under
  `Proofs.HadwigerNelson.Rigidity` (46 now; no module outside `Rigidity/` imports one, `Proofs.lean` aside): kind, full
  name, stored type, a definition's value and its value with proofs erased. Output `statements-merged.txt` (321 MB; committed
  as `.xz`, sha256 `3f7eb2c5…` in `statements-merged.sha256`): **46 modules, 1,899 constants**, 841 s with the slot's wait.
- `data/fs131/ijn1/lean/DropExpect.lean` — the stored types the ruled binder drops must produce, **computed from the
  kernel's terms before the drop**: for each ruled constant the stored type with the named `∀`-binder removed
  (`Expr.lowerLooseBVars`, refused if the body depends on it), printed in the dump's format. A stored non-dependent
  hypothesis prints as `(P) -> …` with no name, and dropping one regroups the printed binders (`forall {θ} {n}, …` for
  `forall {θ}, (…) -> (forall {n}, …)`), so a text surgery on the print is not exact; the surgery on the term is.
  `drop-expect.txt`: six constants — `mul_card_heavyNames_le` [`hc`], `mul_measureReal_light_le_blockEntropy` [`hγ`],
  `rpow_mul_exp_le_exp` [`hθ`], `card_words_badStarts_le` [`hθ`, `hn`], `zeroEntropyCarried` [`h`], `mrPlus` [`h`]; each
  `BEFORE` hash equal to the merged dump's (`zeroEntropyCarried`: 1878386089).

The pre-merge build's dump (FS131-IJ3's `statements-after.txt`) and the merged lines' own last dumps (`data/fs131/ila1/`,
`im11/`, `icl2/`, `icm1/`) are their jobs' receipts; this job's comparisons are against the merged dump.
