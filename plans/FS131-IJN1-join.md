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

## Stage 3 — SAVED: the landing rulings that are code, each shown from the kernel's side

All in build 2 (stage 2). **The statement check** (`tools/fs131_ijn1_statements.py`, new; the merged dump of stage 1
against build 2's, `statements-after.txt`, 321 MB, `.xz` + sha256; with `drop-expect.txt`):
**PASS** (`statements-compare.out`) — 46 → 47 modules; **1,132 named constants** compared (kind, module, propness, stored
type up to hygienic binder names), **246 data definitions' values**, 4 example heads of the base commit's eight touched
files; the ruled changes and nothing else: **4 RULED MOVE**, **6 RULED DROP** (each second type equal to the kernel's
term surgery on the first), **1 NEW** (the headline); 4 new private constants (stage 2's helpers), 0 private constants
gone, 0 new examples. **Control** (`--control`, ten plants: a leaf's statement, a definition's value, a leaf gone, a move
to the wrong module, a drop not as ruled, a new public constant, an axiom, a kind, an unruled drop, an unruled move):
**10 of 10 planted constants reported, 0 reports naming no plant** (`statements-control.out`). Its first control run
counted reports, 12 against 10 (a wrong move is also "the ruled move not seen"), and read a value change made in the
`VALUE` line alone as proof-only (the plant had left the proof-erased `DATA` line equal): both fixed in the reader (count
planted constants; plant both lines) before the run above. Its first real run stopped at a name declared by two modules —
`SpectralChain.corr.eq_1`, generated on demand in two (`dupnames.sh`'s one `GENERATED` row): the reader now keeps both
copies of an internal name.

1. **`entropySplit`, `zeroEntropyCarried` and its readers moved to `Rigidity/ZeroEntropyClosed`** (item 761 ruling 5,
   item 811 ruling 1). Cut so that no cycle forms: `ZeroEntropyClosed` imports `EntropySplitMax` (for
   `entropySplit_of_admissiblePair`; `UnitCircle`'s `exists_admissiblePair` comes through `Pieces`); nothing imports
   `ZeroEntropyClosed` but the new `ChainHeadline` and the root. Moved, each its own name, kind and propness, module exactly
   `ChainAtTA` → `ZeroEntropyClosed`:
   - `entropySplit (F) [NumberField F] : EntropySplit F := entropySplit_of_admissiblePair (exists_admissiblePair (F := F)).some`
     — stored type unchanged (the brief's `(exists_admissiblePair _).some`: the theorem takes `F` implicitly).
     **Axioms: the standard three and the declared `positive_entropy_rigidity`; no `sorry`.**
   - `zeroEntropyCarried (F) [NumberField F] : ZeroEntropyCarried F := zeroEntropyCarried_of_numberField F` — **the scope
     binder `h : NoRamifiedStableDyadic F` dropped** (RULED DROP). It and `zeroEntropyCarried_of_numberField` now have one
     stored type; both are kept (no ruling removes either) — held for the coordinator. **Axioms: the standard three.**
   - `mrPlus (F) [NumberField F] : MRPlus F` — its scope binder dropped, unread once `zeroEntropyCarried` has none (RULED
     DROP; "the scope binder dropped where unread"). **Axioms: the standard three and the declared theorem.**
   - `min_localBound_five_le_chromaticNumber_closed` — stored type unchanged; its `hEF` is now `fun _ => zeroEntropyCarried F`.
     **Axioms: the standard three and the declared theorem.**
2. **`Rigidity.positive_entropy_rigidity` registered with the audit** (`scripts/Axioms.lean`): one `declareImport` line
   and its eight records (every public declaration of the branch on it and on no `sorryAx`, from `axioms-all.txt`:
   `positive_entropy_rigidity_of_polishSpace`, `haar_or_zero_entropy`, `isHaarFourier_or_ksEntropy_eq_zero`,
   `ksEntropy_eq_zero_of_not_smul_le`, `entropySplit_of_admissiblePair`, `entropySplit`, `mrPlus`,
   `min_localBound_five_le_chromaticNumber_closed`) after FS131-KC1's block; the banner's count of imports ("three" →
   "four") and its sentence. **Its four items** (`LEAN.md` § Assumptions), as KN6 § Stage 6 and KN7 § 3.3 leave them: (1)
   the docstring names `[EinsiedlerLindenstrauss2022]` Thm 1.3, § 1.1, pp. 2–3 of arXiv:2101.11120v1, and the page and line
   of clause (4)'s σ-algebra — it lacks the journal's page numbers; (2) the read-back, clause by clause, KN3 § 5.3 and, for
   clause (4) after R1, KN7 § 3.3 — no second reader against the page yet; (3) the model `positive_entropy_rigidity_model`,
   degenerate (the one-point solenoid); (4) **`ARCHITECTURE.md` § Trust, a new row** (this commit), with KN3's draft, KN6's
   "infimum form" and KN7's σ-algebra added, the page quoted in fragments with their lines. **From the kernel's side:**
   `./scripts/axioms.sh` on the joined tree **OK — 7447 clean, 28 axiom-free, 34 imported, 5 declared purchases**
   (`logs/axioms-sh-1.log`; 26 imported before, 8 added; "declared imports (4)"; the digest flags this branch's `CLAUDE.md`
   count, 26, as stale, which is the landing's to refile). **Control:** the `declareImport` line removed in place — the
   audit fails, 18 FAILs, `undeclared-library-axiom HadwigerNelson.Rigidity.positive_entropy_rigidity` among them, and each
   of the eight records `undeclared-in-imported` and `stale-import` (`logs/axioms-sh-plant.log`); restored by copy
   (`cmp` equal) and run again green (`logs/axioms-sh-2.log`), so `build/gate/axioms/latest` is not the planted run.
   **`scripts/assumptions-ledger.txt`:** the nine `RESTS` rows of the declared theorem, exactly the rows the step prints
   (`./scripts/assumptions.sh`, `logs/assumptions-1-full.log`), inserted in the file's sort order (the eight records and the
   headline); the header's counts are left for the landing's `--write-ledger`. The step's other findings on this branch
   are the landing's (§ Drafts).
3. **The five unread binders of lane N dropped** (item 770 ruling 2), each RULED DROP from the kernel's side:
   `mul_card_heavyNames_le` [`hc : 0 < c`], `mul_measureReal_light_le_blockEntropy` [`hγ : 0 ≤ γ`], `rpow_mul_exp_le_exp`
   [`hθ : 0 ≤ θ`], `card_words_badStarts_le` [`hθ : 0 ≤ θ`, `hn : k ≤ n`]; their `have _ :=` lines and comments removed;
   the callers in `exists_forall_exp_le_measureReal_nameCell` pass the variable by name where the dropped proof had fixed it
   (`(c := …)`, `(γ := β / 8)`, `(θ := θ) (n := n)`) and one local left unread (`hkn`) is removed; docstrings say what
   was dropped and why. The `example` that models `card_words_badStarts_le`'s hypotheses still lists the two dropped
   clauses (a superset, unchanged: not mine to change). **Axioms: each the standard three.**
4. **Lemma F public if a second module reads it** (item 801 ruling 1): **no second module reads it** — `Pieces`'
   `finiteIndex_range_nsmul_prime` and `finiteIndex_range_nsmul` are read only in `Pieces`. The nearest fact elsewhere is
   `BochnerTau.finite_quotient_nsmul` (`R ⧸ N·R` finite, the instance `G = R`, proved separately, J28V-7), in a module that
   `Pieces` does not import. Left private; a note for the landing planner with `main`'s
   `ThreeColourCriterion.finite_quotient_span_prime`.
5. **M3's private copies of `main`'s `Plane/OneClass/InvariantLaw` helpers** (noted for the landing): `Rigidity/InvariantMeasure`
   holds private copies of `avgMeasure_apply`, `isProbabilityMeasure_avgMeasure`, `avgMeasure_map`, `integral_avgMeasure`,
   `map_eq_of_tendsto`, `map_eq_of_tendsto_of_eventually`, `measure_compl_eq_zero_of_tendsto`, `isClosed_setOf_of_tendsto`,
   `exists_fixed_of_average`, `exists_common_fixed` (and the definition `avgMeasure`), all `private` on `main` too. **They
   cannot be shared on this branch**: `Plane/OneClass/InvariantLaw` is not in this tree's ancestry. The landing, which
   joins `main`, can make one copy public in a module both import, or leave both private (private names do not meet).
6. **Docstrings** where a moved or proved declaration's text was stale: `UnitCircle`'s four (lane A's D2, item 897 ruling
   1: the title, the module paragraph, the models, `exists_admissiblePair`'s plan replaced by its proof's route);
   `ClassRatio`'s title ("skeleton" → "composed by FS131-ICM1 over six named private leaves"); `ChainAtTA`'s title and
   module paragraph and `noRamifiedStableDyadic_of_tca`'s; `EntropySplitMax`'s sentence on where `entropySplit` sits;
   `RingScope`'s on the scope lemma; `PositiveEntropy`'s (stage 2). Twenty-eight other module titles on the branch still say
   "skeleton" though their modules hold no `sorry` (`rg -n 'skeleton\)' Proofs/HadwigerNelson/Rigidity`): the landing's
   sweep, not done here.
7. **`ARCHITECTURE.md`**: rows of `ChainAtTA`, `PositiveEntropy`, `ZeroEntropyClosed`, `ZeroEntropyNames`, `TraceSplit`,
   `APlus` (the last two said M2b "until it lands"), a new row for `Rigidity/ChainHeadline`, and the § Trust row;
   `tools/check_architecture.py`: PASS (`logs/arch-1.log`). `Proofs.lean`: the new module.
