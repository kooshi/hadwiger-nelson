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

## Stage 2 — SAVED: the two leaves

Both written against scratch copies first (`data/fs131/ijn1/work/M9S.lean`, `M23.lean`; rounds `logs/M9S-1.log` …,
`logs/M23-1.log` … `M23-3.log`, the last of each exit 0 with no warning), then installed and compiled in a farm of the
tree's library (`data/fs131/ijn1/farm.sh`; `logs/F-ChainAtTA-1.log`, `F-PE-1.log`: exit 0, no warning), then **build 2**
(`./scripts/build.sh` under the slot, `MEMMAX=10G BATCH=8`; `logs/build2-full.log`, gate log
`build/gate/build/20261014T185624Z-174223.log`, copied to `logs/build2-gate.log`): **`OK — 257 of 257 batches, 30
module(s) rebuilt, 3 module(s) with warnings, 11m31s`, exit 0.** Its every warning is ``declaration uses `sorry` `` of
another line's leaf: `Plane/OneAvoidingDensity` l. 54, `ClassRatio` ll. 214, 224, 346, 351, 359, 366, `RingScope` l. 247
(0 other warnings). **No warning from `ChainAtTA` or `PositiveEntropy`.** Build 2 carries stage 3's edits too (one build
for both stages); the commit of this stage holds the two leaves' files.

- **M9-S, `Rigidity.noRamifiedStableDyadic_of_tca`** (`ChainAtTA`; FS100-EXC; item 791 ruling 3: a proof only). At a
  stable, dyadic, ramified `P`, T-C(A) gives `c < 1/4` bounding every independent set of the level-one target by
  `c · |𝓞 ⧸ P|`; `colorable_two_levelTarget_one_of_isRamified` gives a two-colouring `C`; each colour class is independent
  (`C.valid`). If `𝓞 ⧸ P` is finite the two classes (`Finset.filter`, `Finset.card_filter_add_card_filter_not`) cover it, so
  `|Q| ≤ 2c|Q| < |Q|/2` with `|Q| > 0` — `linarith` over the product `c·|Q| < |Q|/4` stated as a `have`; if it is infinite,
  `Nat.card` is `0` and the singleton `{0}` (independent, `Set.pairwise_singleton`) gives `1 ≤ 0`. 33 lines, no helper.
  The route is the docstring's ("a colour class … holds at least half"); the finite/infinite split is mine, so that no
  finiteness of the residue ring is needed. **Axioms: the standard three** (`axioms-after.txt`). Its docstring said "Off
  the headline's path"; the count reads it (`CountResidue` l. 315), so it now says that.
- **`Rigidity.ZdAction.mulTwoThree_model`** (`PositiveEntropy`; the model of FS105-NVC's hypotheses; priced 100–150 lines
  in FS131-IJ3's record § 6). *Irreducible:* `AddSubgroup.dense_or_cyclic` — a closed dense subgroup of `ℝ` is `⊤`
  (`IsClosed.closure_eq`, `Dense.closure_eq`); `closure {0}` is `⊥`, finite; for `a ≠ 0`, invariance at `![1, 0]` puts `a`
  in the doubled subgroup, `a = 2ka`, so `2k − 1 = 0` in `ℤ` (`omega`). *Not virtually cyclic:* `Λ.nsmul_index_mem` puts
  `(N, 0)` and `(0, N)` (`N = [ℤ² : Λ] ≠ 0`) in `Λ`; evaluating `α m = α (k • n)` at `1` gives `2^N = 2^{k₁n₀} 3^{k₁n₁}` and
  `3^N = 2^{k₂n₀} 3^{k₂n₁}`; three private helpers carry unique factorisation at `2` and `3` with **no new import**
  (`padicValRat` is outside the module's import closure — `logs/M23-1.log` — and an import would move the stored
  instances of every downstream statement): `two_pow_three_pow_nat` (in `ℕ`, `2^m = 3^n` or `2^m·3^n = 1` only at
  `m = n = 0`: parity, `Nat.pow_right_injective`, `Nat.eq_one_of_mul_eq_one_right/left`), `two_zpow_eq_three_zpow` (in `ℝ`
  with integer exponents, four sign cases by `Int.eq_nat_or_neg`), `two_three_zpow_inj` (`zpow_sub₀`, `div_eq_div_iff`,
  `linear_combination`); and `mulTwoThree_apply` (by `rfl`). Then `k₁n₁ = 0` with `k₁n₀ = N ≠ 0` forces `n₁ = 0`, and
  `N = k₂n₁ = 0`. About 100 lines with the helpers. **Axioms: the standard three.** The theorem's docstring now gives the
  route the proof takes (it named `Real.subgroup_dense_or_cyclic` "-shape" and "unique factorisation"); the module's title
  said "skeleton" and its last paragraph "stated here and not proved" of `haar_or_zero_entropy` (FS131-IJ3 proved it):
  both rewritten, no code character elsewhere.

**Re-priced:** M9-S was a few minutes; the model about 20 minutes and 100 lines against 100–150, three rounds.
