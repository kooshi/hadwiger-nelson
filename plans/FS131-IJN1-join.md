# FS131-IJN1 — the five-colour chain joined on one branch, its small leaves closed, its headline read from the kernel

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-IJN1-chain-join.md` (on `main`). Branch `fs131-wj`, cut from
`fs131-wt5` at `54c2bc166` in the worktree `.claude/worktrees/fs131-wq1`. Working files: `data/fs131/ijn1/`. Laptop: 12
cores, 31 GB.*

## Theorems this phase proved

[kernel], printed from build 5's tree (`data/fs131/ijn1/axioms-final.txt`; reader `tools/fs131_ijn1_axioms.py` PASS, control
4 of 4); all under `HadwigerNelson.Rigidity`; "standard three" = `[propext, Classical.choice, Quot.sound]`.
- `noRamifiedStableDyadic_of_tca : ∀ (F : Subfield ℝ), TCA F → NoRamifiedStableDyadic F` (M9-S; FS100-EXC) — standard three.
- `ZdAction.mulTwoThree_model : mulTwoThree.IsIrreducible ∧ ¬ mulTwoThree.IsVirtuallyCyclic` (the model of FS105-NVC's
  hypotheses) — standard three.
- `entropySplit : ∀ (F) [NumberField F], EntropySplit F` (PE-2 at one non-torsion rotation; moved, proved) — standard three
  and the declared `positive_entropy_rigidity`; no `sorry`.
- `zeroEntropyCarried : ∀ (F) [NumberField F], ZeroEntropyCarried F` (EF_F⁺; moved, scope dropped, proved) — standard three.
- `mrPlus : ∀ (F) [NumberField F], MRPlus F` (MR⁺ over every real number field; moved, scope dropped) — standard three and
  the declared theorem; no `sorry`.
- `min_localBound_five_le_chromaticNumber_closed` (moved, unchanged) — standard three and the declared theorem.
- **`min_localBound_five_le_chromaticNumber : ∀ (F : Subfield ℝ) [NumberField F], Plane.OneAvoidingDensityBound →
  (localBound F ≤ 4 → localBound F ≤ χ) → min (localBound F) 5 ≤ χ`** (the headline, `Rigidity/ChainHeadline`) —
  standard three, `positive_entropy_rigidity`, `StandingFive.kloosterman_bound` and **`sorryAx`, through seven leaves of
  other lines** (Stage 4's table). Not a closed theorem until they land.
- Restated by drops, each stronger and on the standard three: `Counting.ratio_unramified_of_tca`, `card_words_badStarts_le`,
  `mul_card_heavyNames_le`, `mul_measureReal_light_le_blockEntropy`, `rpow_mul_exp_le_exp`.

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

## Stage 4 — SAVED: the headline, read from the kernel

**`Rigidity.min_localBound_five_le_chromaticNumber`** (`Proofs/HadwigerNelson/Rigidity/ChainHeadline.lean`, new):
`min_localBound_five_le_chromaticNumber_of_closed F (bochnerHerglotz_of_countable (unitRing F))
(invariantMeasureOnClosed_of_countable F) (Counting.count_of_oneAvoidingDensityBound hOA) (aPlusOfR88 F) (entropySplit F)
(fun _ => zeroEntropyCarried F) (tca_of_five_le_localBound F) hRow99`. Six of the old headline's eight hypotheses are
discharged by proved theorems; `hCount` by the count over `hOA`; `hRow99` kept.

**The stored statement** (`data/fs131/ijn1/lean/HeadlineCheck.lean` → `headline-check.txt`, run on build 5; `pp.explicit` there):

```
∀ (F : Subfield ℝ) [NumberField ↥F],
  HadwigerNelson.Plane.OneAvoidingDensityBound →
    (localBound F ≤ 4 → localBound F ≤ (SimpleGraph.induce (planeOver F) (unitDistance ℂ)).chromaticNumber) →
      min (localBound F) 5 ≤ (SimpleGraph.induce (planeOver F) (unitDistance ℂ)).chromaticNumber
```

**Read aloud.** For every real number field `F`: if every Lebesgue-measurable set of the plane with no two points at
distance exactly 1 has upper density at most `0.2470` about every centre (`[AmbrusEtAl2023]` Thm 1 as printed), and if
`L(F) ≤ 4` implies `L(F) ≤ χ(F²)` (row 99's lower half at four, a theorem on `main` on Weil's bound), then
`min(L(F), 5) ≤ χ(F²)`, where `L(F)` is the least chromatic number of the level-one residue targets at the
conjugation-stable primes of `F(i)` and `χ(F²)` the chromatic number of the unit-distance graph on `F²` (in `ℕ∞`). **Against
the old headline's conclusion**, as the kernel stores both: the two types opened at the same `F` and instance, every
hypothesis stripped, the conclusions compared as terms — **SAME**; control, the old headline's conclusion against its
`hRow99`'s, **DIFFERENT**; `hRow99` new against old: **SAME**. Against the informal claim (the local–global conjecture's
main clause through five, its lower half, `CLAUDE.md` § The local–global conjecture): `χ(F²) ≥ min(L(F), 5)` is what the
chain was built to give; with `UpperHalf.chromaticNumber_planeOver_le_localBound` (`χ(F²) ≤ L(F)`, on `main` and here) it
gives `χ(F²) = L(F)` wherever `L(F) ≤ 5`.

**Its axioms** (`axioms-final.txt`, from build 5's tree; build 2's print, `axioms-after.txt`, was the same): `[propext, sorryAx, Classical.choice, Quot.sound,
HadwigerNelson.Rigidity.positive_entropy_rigidity, HadwigerNelson.StandingFive.kloosterman_bound]` — the standard three,
two declared outside theorems (Einsiedler–Lindenstrauss through `entropySplit`; Weil through M13's `charBound_one_weil`),
and `sorryAx`. **Every leaf its `sorryAx` comes through** (the printer's `SORRY-LEAF`, the line of each name; the build's
warnings name the same lines):

| leaf | module, line | whose |
|---|---|---|
| `card_fibre` (private; Lemma P, Hensel's fibre count) | `Rigidity/ClassRatio` l. 214 | M13's leaves, `fs131-wcm2` |
| `norm_charSum_new_le` (private; Lemma P, a character new at a level) | `Rigidity/ClassRatio` l. 224 | M13's leaves |
| `ratioAtMost_dyadic` (private; the dyadic branch) | `Rigidity/ClassRatio` l. 346 | M13's leaves |
| `chromaticNumber_le_four_of_small` (private; the exclusions at `q ∈ {3, 7}`) | `Rigidity/ClassRatio` l. 351 | M13's leaves |
| `ratioAtMost_cert` (private; **the certificates' link** at `q ∈ {11, 19}`) | `Rigidity/ClassRatio` l. 359 | M13's leaves / the certificates, `fs131-wc16` |
| `charBound_one_exact` (private; the exact spectra at `q ∈ {23, 27, 31}`) | `Rigidity/ClassRatio` l. 366 | M13's leaves |
| `upperDensity_le_of_oneAvoidingDensityBound` (**the density bound's instance**: the paper's form carried to `ℂ`) | `Plane/OneAvoidingDensity` l. 54 | the density bound, `fs131-wdb3` |

As the brief expected: M13's six leaves, the certificates' link among them, and the density bound's instance; nothing
else. `RingScope`'s `unitRing_eq_stableIntegers` (l. 247) is not on the headline's path. **What the headline's `sorryAx`
does not come through:** the entropy side, the zero-entropy side, M11, the count's own modules, M2a/M2b/M3/M10, lane A —
each proved on this branch; on the branch's 870 public records (`axioms-all.txt`, build 5), 851 are on the standard three, 8 on the declared
Einsiedler–Lindenstrauss and no `sorry`, and 11 carry `sorryAx`, every one through the seven leaves above or `RingScope`'s
(`draft-axioms-block.lean`).

**The two hypotheses kept.** `hOA : Plane.OneAvoidingDensityBound` is a named hypothesis standing for an outside theorem
(its docstring: "External: a named hypothesis standing for an outside theorem, not proved in the library"; not declared
as an axiom by the coordinator's ruling of 2026-10-14) — not declared to the assumptions step on this branch (§ Drafts).
`hRow99` is discharged at the landing by `ThreeFourColours.localBound_le_chromaticNumber_of_le_four` (`main`, FS131-LJ1;
its statement, read in `main`'s source, is `hRow99`'s text for text; its stored type is not compared here), which rests on `StandingFive.kloosterman_bound`. So on the
joined `main` the headline would take one hypothesis, the printed theorem of `[AmbrusEtAl2023]`, and rest on two declared
axioms and the seven leaves.

## Stage 5 — SAVED: the gate items of § Done means, from the kernel's side; two more ruled drops

**5.1 Two ruled drops after the lint** (the coordinator's rulings of 2026-10-14, by message, item 726's word for an unread
binder; listed with stage 3's). The guarded lint on the planted build (§ 5.3) named, besides the plant, one real finding:
**`noRamifiedStableDyadic_of_tca`'s `[NumberField ↥F]` unused** once its proof was in. Ruled: drop it (the alternative,
`@[nolint]`, declined: a theorem without it is only stronger). Dropped (build 4, `logs/build4-full.log`: OK, 26 rebuilt,
9m58s). Its one reader, `CountResidue` l. 315, compiled — and its theorem `Counting.ratio_unramified_of_tca` then carried an
unread section instance (`unusedSectionVars` in build 4, `unusedArguments` in the lint, `logs/lint-build4.log`). Ruled as
the cascade: `omit [NumberField ↥F] in` above it, with a `--` reason (its one reader, l. 381, is inside a proof with the
instance in scope; no stored type outside `CountResidue` moves). Done (**build 5**, `logs/build5-full.log`, gate log
`build/gate/build/20261014T195639Z-385836.log` → `logs/build5-gate.log`: **`OK — 257 of 257 batches, 7 module(s) rebuilt,
3 module(s) with warnings, 8m20s`, exit 0**). Each expected type computed from the kernel's term on the build before its
drop (`lean/DropExpect2.lean` on build 3 → `drop-expect-2.txt`; `lean/DropExpect3.lean` on build 4 → `drop-expect-3.txt`;
an anonymous instance binder matched by its kind and its type's head); each `BEFORE` equal to the merged dump's.

**5.2 No other statement or definition changed** (`tools/fs131_ijn1_statements.py`, the merged dump against build 5's,
`statements-after-5.txt`, `.xz` + sha256, with the three expect files): **PASS** (`statements-compare-5.out`) — 1,132 named
constants, 246 data definitions' values, 5 example heads of the base commit's nine touched files; **4 RULED MOVE, 8 RULED
DROP** (`zeroEntropyCarried`, `mrPlus`, lane N's four statements with five binders, `noRamifiedStableDyadic_of_tca`,
`Counting.ratio_unramified_of_tca`), **1 NEW** (the headline), 4 new private helpers, nothing else. **Control** (ten
plants): **10 of 10, 0 stray** (`statements-control-5.out`).

**5.3 The build and the lint.** Build 5: its every warning is ``declaration uses `sorry` `` of another line's leaf
(`OneAvoidingDensity` l. 54; `ClassRatio` ll. 214, 224, 346, 351, 359, 366; `RingScope` l. 247), 0 others. **The guarded
lint** (`lake lint --no-build -- --no-build --trace` under the slot, `logs/lint-build5.log`): **exit 0, 14 of 14 `(2/2)
Passed!`, `-- Linting passed for Proofs.`** **Its control** (`data/fs131/ijn1/lint-plant.sh`, FS131-LJ1's with the module
and the plant's name changed): `theorem zz_ijn1_lint_plant [Nonempty ℕ] : (1 : ℕ) = 1 := rfl` planted at the end of
`ChainHeadline`, the tree built (OK, 2 rebuilt), the lint **exit 1 naming the plant** (`synTaut` and `unusedArguments`,
`logs/lint-plant.log`) — and the real finding of § 5.1 —, the module restored by `git checkout` (digest equal, 0 tracked
files modified, `lint-plant-restore.txt`); build 3 rebuilt it from the restored text (OK, 2 rebuilt).

**5.4 `dupnames`** (`./scripts/dupnames.sh` on the joined tree, build 5, `logs/dupnames-2.log`): **OK — no name declared
by two modules** (25 generated on demand, e.g. `SpectralChain.corr.eq_1`). Not run: its `--self-test` and the audit's
(the landing's whole-library gate).

**5.5 The architecture check** (`logs/arch-3.log`): **RESULT: PASS.**

**5.6 The axioms of every public declaration in the files I touch** (`lean/Axioms.lean` over the ten modules this job writes
— `ChainAtTA`, `ZeroEntropyClosed`, `ChainHeadline`, `PositiveEntropy`, `ZeroEntropyNames`, `UnitCircle`, `ClassRatio`,
`EntropySplitMax`, `RingScope`, `CountResidue` — → `axioms-final.txt`, private helpers included; reader
`tools/fs131_ijn1_axioms.py` → `axioms-final-verdict.out`): **PASS, 235 records** — `ChainAtTA` 35 CLEAN; `ZeroEntropyClosed`
2 CLEAN, 3 IMPORTED; `ChainHeadline` 1 OPEN-LEAF (the headline); `PositiveEntropy` 16 CLEAN, 2 IMPORTED; `ZeroEntropyNames`
58 CLEAN; `UnitCircle` 33 CLEAN; `ClassRatio` 19 CLEAN, 1 IMPORTED (`charBound_one_weil`, private, on Weil), 13 OPEN-LEAF
(its six leaves and what reads them); `EntropySplitMax` 8 CLEAN, 2 IMPORTED; `RingScope` 8 CLEAN, 1 OPEN-LEAF
(`unitRing_eq_stableIntegers`); `CountResidue` 33 CLEAN. Every OPEN-LEAF's `sorry` is sourced in M13's six private leaves,
the density bound's instance or `RingScope`'s leaf; the planted record (`positive_entropy_rigidity_of_polishSpace`) reads
IMPORTED. **Control** (`--control`, four plants: an unknown axiom, a `sorry` sourced in a proved leaf, the declared theorem
in a record that must be clean, a ninth leaf under the headline): **4 of 4** (`axioms-final-control.out`). The public
records, one per line, are `axioms-final.txt`'s `AXIOMS … public …` lines. **`./scripts/axioms.sh`** on build 5
(`logs/axioms-sh-3.log`): **OK — 7447 clean, 28 axiom-free, 34 imported, 5 declared purchases.**

**5.7 Spec examples and models.** No `#eval`/`example` added or removed (5 example heads in order). Models of the new
statements' hypotheses: `noRamifiedStableDyadic_of_tca`'s `TCA F` — at `ℚ(√47)` (the instances' module, M15; not in the
library), its conclusion `NoRamifiedStableDyadic` is false at `ℚ` (the prime `(1 + i)`), so `TCA ⊥` is false, which is
the theorem's contrapositive; `mulTwoThree_model` is itself a model; the headline's: § Stage 4's paragraph. The vacuity
scan was not run (the landing's).

## Drafts for the landing (files this job does not write; each names its slot)

**D1. The audit's block for the joined chain** (`scripts/Axioms.lean`): `data/fs131/ijn1/draft-axioms-block.lean`,
generated by `tools/fs131_ijn1_audit_block.py` from `axioms-all.txt` (every public declaration of the branch's 54 chain
modules: `Rigidity/*` with `ChainHeadline`, the five `Outside/OAI015*` ports, `Plane/OneAvoidingDensity`,
`Plane/WindowDensity`; build 2's tree). **870 public records: 851 CLEAN** (one `#print axioms` line each, grouped by
module, for the CLEAN section above the PURCHASED banner), **8 IMPORTED on `Rigidity.positive_entropy_rigidity`** (filed on
this branch, stage 3; the block repeats them), **0 on any other import**, **11 not auditable** (`sorryAx`; listed with their
sources: the count, M13's public theorems, `mOne_le_…`, `mOne_lt_quarter`, the density bound's instance, `RingScope`'s
`unitRing_eq_stableIntegers`, and the new headline). The ports' records may want the port block's form
(`open private … from …`) where the landing's port job keeps one. Control: an unknown axiom planted in one record stops the
generator, naming it (exit 1).

**D2. The assumptions ledger's lines** (`scripts/assumptions-ledger.txt` and `scripts/Assumptions.lean`'s
`AssumptionAudit.declared`): `data/fs131/ijn1/draft-assumptions.txt`, read from `./scripts/assumptions.sh` on the joined
branch (`logs/assumptions-1.log`; exit 1, 45 checks failed — the branch was never at this gate). (a) **23 rows the ledger
lacks**: 9 `RESTS` of `StandingFive.kloosterman_bound` (M13's public theorems, the count, the headline), the `TAKES` of
`BochnerHerglotz`, `InvariantMeasureOnClosed`, `Interface.Count`, `Interface.APlusOfR88`, `Interface.APlus0` by
`five_le_chromaticNumber_of_mrPlus`, `min_localBound_five_le_chromaticNumber_of_closed` and `_closed`, one `TAKES` of
`SpectralInputs.BochnerOn` (`isSpectralMeasureOf_condExpL2`), one `MENTIONS` of `Interface.MR` (`interface_mr_iff`) —
`--write-ledger` adds them once (b) is filed. (b) **13 entries**: `Plane.OneAvoidingDensityBound` is undeclared — a
`.former` of kind `outside`, source `[AmbrusEtAl2023]` (its docstring says "External: a named hypothesis"), which also
clears the five `undeclared-closed-hypothesis` rows (`mOne_le_…`, `mOne_lt_quarter`, `upperDensity_le_…`, the count, the
headline's `hOA`); four `.condition` entries are now stale because the chain concludes them (`SpectralChain.IsTraceSpectral`
by `aplus_model` and `Counting.exists_invariantColouring_rat`; `SpectralChain.TCA` by `tca_of_five_le_localBound`;
`SpectralInputs.IsHaarFourier` by `exists_isHaarFourier`, `isHaarFourier_dualHaar`; `SpectralInputs.IsSpectralMeasureOf` by
`IsSpectralMeasureOf.add_of_orthogonal`, `spectral_null_model`) — remove each; three `Prop`-formers no theorem concludes
need a `.condition` with its model or the statement that no declaration exhibits one (`Rigidity.EntropySplitEvery`,
`Rigidity.IsRamified` — at `ℚ` the prime `(1 + i)`, `Rigidity.SIndep`). Then the nine counts move (this branch's run:
`axioms=4 rests=45 named=19 inline=15 outside=7 ours=22 open=5 takes=118 mentions=2`, before (b)) — the landing's, on
`main`'s ledger.

**D3. `LEAN.md` lines** (§ Searching — Lean, appended at its end): `data/fs131/ijn1/draft-lean-md.txt`, five lines — the
term surgery that gives a ruled drop's expected stored type; unique factorisation at 2 and 3 with no valuation;
`Finset.card_filter_add_card_filter_not` and the infinite case of a `Nat.card` bound; `findDeclarationRanges?` and
`selectionRange` for a leaf's line; the module in a moved statement's hygienic names.

**D4. `ARCHITECTURE.md` § Trust's count sentence and the front page** (`CLAUDE.md` § Trust ledger, at the landing): the
declared imports become four with `Rigidity.positive_entropy_rigidity`, eight records on it on this branch (nine `RESTS`
rows, the headline the ninth, not auditable until its leaves land). `CLAUDE.md` § Trust ledger's sentence "The library
declares three outside axioms" → four, naming `Rigidity.positive_entropy_rigidity` — `[EinsiedlerLindenstrauss2022]`
Thm 1.3 — "with eight records"; the counts themselves are the landing's audit on the joined `main`.
