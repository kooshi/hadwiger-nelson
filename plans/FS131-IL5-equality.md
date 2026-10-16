# FS131-IL5 — `χ(F²) = L(F)` whenever `L(F) ≤ 5`, stored as one named theorem

*Record of de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-IL5-equality.md` (committed on `main` at
`3d9923dc2`, after this worktree was cut, so read at the main tree's path). Worktree `.claude/worktrees/il5`, branch
`fs131-il5`, cut from `main` at `440f5cfb9`.*

## Theorems this phase proved

- `HadwigerNelson.Rigidity.chromaticNumber_planeOver_eq_localBound_of_le_five` — `χ(F²) = L(F)` for every real number field
  with `L(F) ≤ 5` — [kernel], `Proofs/HadwigerNelson/Rigidity/MainClauseFive.lean`; axioms `[propext, Classical.choice,
  Quot.sound, Rigidity.positive_entropy_rigidity, StandingFive.kloosterman_bound]`.
- `HadwigerNelson.Rigidity.min_chromaticNumber_five_eq_min_localBound_five` — `min(χ(F²), 5) = min(L(F), 5)` for every real
  number field, no hypothesis — [kernel], same module; the same five axioms.
- `HadwigerNelson.Rigidity.localBound_bot_le_two` — `L(ℚ) ≤ 2`, the model of the hypotheses — [kernel], same module; axioms
  `[propext, Classical.choice, Quot.sound]`.

## Stage 1 — SAVED: the readback

**The quotations, checked against their sources** (a byte comparison of each quoted block with the file, in the worktree
at `440f5cfb9`; the inventory also at the main tree's head):

| quotation in the brief | source | result |
|---|---|---|
| `ROADMAP.md` item 1, its first line | `ROADMAP.md` l. 99 | verbatim |
| inventory item 980, in full | `plans/FS131-close-inventory.md` l. 9414 (worktree and main tree) | verbatim |
| `theorem min_localBound_five_le_chromaticNumber (F : Subfield ℝ) [NumberField F] : …` (two lines) | `Proofs/HadwigerNelson/Rigidity/ChainHeadline.lean` l. 52–53 | verbatim |
| `theorem chromaticNumber_planeOver_le_localBound : …` (two lines) | `Proofs/HadwigerNelson/Arith/UpperHalf.lean` l. 296–297 | verbatim |
| "`UpperHalf.chromaticNumber_eq_localBound_of_chain`, `Proofs/HadwigerNelson/Arith/UpperHalf.lean` l. 300" | same file | its docstring opens at l. 300, the `theorem` line is l. 302 — the address is right to the declaration's first line; not a defect |

No mismatch. One fact the brief's quotation does not show, read from the file: `chromaticNumber_planeOver_le_localBound`
takes `F` explicitly (`variable (F) in`, l. 293) and `[NumberField F]` from the section's `variable {F : Subfield ℝ}
[NumberField F]` (l. 92). `localBound F : ℕ∞` (`Proofs/HadwigerNelson/SpectralChain.lean` l. 301: `⨅ P : StablePrime F,
(levelTarget P 1).chromaticNumber`).

**The target, restated.** For every `F : Subfield ℝ` with `[NumberField F]` and every proof of `localBound F ≤ 5`:

```lean
((unitDistance ℂ).induce (planeOver F)).chromaticNumber = localBound F
```

— that is, `χ(F²) = L(F)`, with no hypothesis beyond `L(F) ≤ 5`; in particular none of the chain's named hypotheses that
`UpperHalf.chromaticNumber_eq_localBound_of_chain` takes (`hBH`, `hL1`, `I`, `hCount`, `hAP`, `hRU`, `hMR`, `hCLS`,
`hRow99`), and not `[NumberField.IsTotallyReal F]`, which that conditional form also takes.

**The proof, planned.** Over `ℕ∞`, `localBound F ≤ 5` gives `min (localBound F) 5 = localBound F` (`min_eq_left`), so the
headline gives `localBound F ≤ χ`; the upper half gives `χ ≤ localBound F`; `le_antisymm`. The sibling at four,
`ThreeFourColours.chromaticNumber_planeOver_eq_localBound_of_le_four` (`Arith/ThreeFourColours` l. 622), has this shape
with signature `(F : Subfield ℝ) [NumberField F] (h : localBound F ≤ 4)`; the new theorem mirrors it.

**A stronger statement, as short** (the brief's § What is yours to decide). The brief's example — the equality wherever
the lower bound reaches `L(F)`, `min (L F) 5 = L F` — is the same hypothesis over `ℕ∞` (`min_eq_left_iff`), not a
stronger one. What is strictly stronger and as short is the hypothesis-free form

```lean
min ((unitDistance ℂ).induce (planeOver F)).chromaticNumber 5 = min (localBound F) 5
```

— `χ(F²)` and `L(F)` agree through five, at every real number field. It implies the target (if `L ≤ 5` then
`min χ 5 = L ≤ 5`, so `χ ≤ 5` — else `min χ 5 = 5 = L` and `χ ≤ L = 5` — hence `χ = L`) and the headline's lower bound
(`min L 5 = min χ 5 ≤ χ`); it does not imply the upper half `χ ≤ L` at `L > 5`. Plan: store **both** — the brief's target
under the name a reader cites, proved directly as the two-line composition `ROADMAP.md` names, and the `min` form beside
it — neither proved from the other, so each reads as its own composition of the same two theorems.

**Module.** A new leaf module, `Proofs/HadwigerNelson/Rigidity/MainClauseFive.lean`, importing `Rigidity/ChainHeadline`
(which imports `Arith/ThreeFourColours`, hence `Arith/UpperHalf`). Editing `ChainHeadline` itself would recompile the
three modules that import it or its importer (`Rigidity/SqrtClassFive`, `Instances/SqrtClassValues`,
`Instances/SqrtFortySevenFive`) and the root; a leaf recompiles only itself and the root, and leaves every existing
module's stored data untouched, so no statement-dump comparison of an existing module is owed. The new module gets its
row in `ARCHITECTURE.md` and its import in `Proofs.lean` in the same commit (`LEAN.md` § The package).

**Gate inputs the new records will need, by the gate's own rules** (read, not yet run): the two `#print axioms` lines in
`scripts/Axioms.lean`'s IMPORTED section, beside `min_localBound_five_le_chromaticNumber` under the
`positive_entropy_rigidity` block, where every record resting on both declared imports is filed; four `RESTS` rows in
`scripts/assumptions-ledger.txt` (two theorems, each on `Rigidity.positive_entropy_rigidity` and
`StandingFive.kloosterman_bound`), written by `./scripts/assumptions.sh --write-ledger`; no `AssumptionAudit.declared`
line (the theorems take no hypothesis standing for an assumption: `h : localBound F ≤ 5` is a condition on the
statement's own variable).

## Stage 2 — SAVED: the theorem

**The module.** `Proofs/HadwigerNelson/Rigidity/MainClauseFive.lean` (new; imports `Rigidity/ChainHeadline` only), its
import in `Proofs.lean` after the headline's, its row in `ARCHITECTURE.md` § 3 after `Rigidity/ChainHeadline` (imports
cell `Rigidity/ChainHeadline`, ledger row 123). Three theorems, each proved in one or two lines:

- `chromaticNumber_planeOver_eq_localBound_of_le_five (F : Subfield ℝ) [NumberField F] (h : localBound F ≤ 5)` —
  `le_antisymm` of the upper half and `(min_eq_left h).symm.le.trans` the headline: the composition `ROADMAP.md` names;
- `min_chromaticNumber_five_eq_min_localBound_five (F : Subfield ℝ) [NumberField F]` — `le_antisymm` of `min_le_min` (the
  upper half under `min · 5`) and `le_min` (the headline, `min_le_right`);
- `localBound_bot_le_two : localBound (⊥ : Subfield ℝ) ≤ 2` — the stable prime of `ℚ(i)` above 2 from
  `UpperHalf.exists_stablePrime_rat` is ramified (its third clause is `IsRamified` verbatim), so
  `colorable_two_levelTarget_one_of_isRamified` two-colours its level-one target, and `iInf_le` bounds `L(ℚ)` by it.
  No other declaration bounds `L` from above at a named field (`rg 'localBound'` over `Proofs/`: at named fields only
  `5 ≤ localBound …`, in `Instances/SqrtFortySevenFive` and `Instances/SqrtClassValues`): `Instances/UpperHalfCorollaries`'
  docstring says no declaration proved `localBound F ≤ 2` at `ℚ` (written before `ChainAtTA`'s two-colouring of a
  ramified target existed); that sentence is now out of date — an INVENTORY item (correction owed), not edited here.

Two spec `example`s read the theorems at the model: `localBound ⊥ = 2` from the first theorem with
`UpperHalf.chromaticNumber_planeOver_rat` (either half alone would give one inequality, not the equation), and
`min (localBound ⊥) 5 = 2` from the `min` form with no hypothesis supplied.

**The docstrings** say, for each theorem: what it states in words; whose each half is — the upper half prior art
(`LEDGER.md` row 52: `[Moorhouse2010]` §8.2/§10.3, `[Manturov2012]` Thms 17–19, `[Madore2015]` Cor. 3.4), its kernel proof
this project's; the lower half this project's derivation (rows 120–123), at `ℚ(√47)` "prior art: not found in print"
(row 121); and what it rests on — the declared outside theorems `positive_entropy_rigidity` (`[EinsiedlerLindenstrauss2022]`
Thm 1.3) and `StandingFive.kloosterman_bound` (`[Weil1948]` p. 207), through the headline. The module docstring carries the
read-aloud, the two halves' attributions, what the module rests on, and the inhabitants: `[NumberField F]` and
`localBound F ≤ 5` hold at once at `F = ℚ` (`UpperHalf.instNumberFieldBot`, `localBound_bot_le_two`); at `L(F) = 5` no
declaration states `L(ℚ(√47)) ≤ 5`, so the kernel's model of the hypothesis is the one at `ℚ` (said in the docstring).

**Iteration.** `lake env lean` on the module under a slot (8 GiB): exit 0, no message (`data/fs131/il5/iter1.log`).

**The build.** Before it, the copied build was current: `lake build --no-build Proofs` under a slot, "All targets
up-to-date (6457 jobs)" (`data/fs131/il5/uptodate-before.log`). Then `slot.py --mem 10 --cpus 4 -- env MEMMAX=10G BATCH=10
./scripts/build.sh`: **OK — 239 of 239 batches, 2 module(s) rebuilt (`Rigidity.MainClauseFive` 1.0 s, `Proofs` 4.4 s),
0 module(s) with warnings, 7 m 16 s** (`data/fs131/il5/build1.log`). `BATCH=10` in place of the brief's `4`: the stale set
was known to be the new leaf and the root, and `LEAN.md` § Building measures `BATCH=10` at a two-module rebuild on this
laptop (5½–6 minutes against about 2.5 times as many Lake starts at `4`); the cap was the brief's.

**No existing statement moved, from the kernel's side.** The only existing file the build recompiled is the root
`Proofs.lean`, which declares nothing; no module that existed before imports the new one, so every other `.olean` is the
copied gated build's, unrecompiled (the log names two rebuilt modules). No before/after statement dump is owed.

**The kernel's print** (`data/fs131/il5/lean/PrintNew.lean` under a slot, `pp.fullNames`; `data/fs131/il5/print-new.log`):

```
HadwigerNelson.Rigidity.chromaticNumber_planeOver_eq_localBound_of_le_five : ∀ (F : Subfield ℝ) [NumberField ↥F],
  HadwigerNelson.SpectralChain.localBound F ≤ 5 →
    (SimpleGraph.induce (HadwigerNelson.planeOver F) (HadwigerNelson.unitDistance ℂ)).chromaticNumber =
      HadwigerNelson.SpectralChain.localBound F
HadwigerNelson.Rigidity.min_chromaticNumber_five_eq_min_localBound_five : ∀ (F : Subfield ℝ) [NumberField ↥F],
  Min.min (SimpleGraph.induce (HadwigerNelson.planeOver F) (HadwigerNelson.unitDistance ℂ)).chromaticNumber 5 =
    Min.min (HadwigerNelson.SpectralChain.localBound F) 5
HadwigerNelson.Rigidity.localBound_bot_le_two : HadwigerNelson.SpectralChain.localBound ⊥ ≤ 2
'…chromaticNumber_planeOver_eq_localBound_of_le_five' depends on axioms: [propext, Classical.choice, Quot.sound,
 HadwigerNelson.Rigidity.positive_entropy_rigidity, HadwigerNelson.StandingFive.kloosterman_bound]
'…min_chromaticNumber_five_eq_min_localBound_five' depends on axioms: [propext, Classical.choice, Quot.sound,
 HadwigerNelson.Rigidity.positive_entropy_rigidity, HadwigerNelson.StandingFive.kloosterman_bound]
'…localBound_bot_le_two' depends on axioms: [propext, Classical.choice, Quot.sound]
constants declared by the module: 3   (the three above; no generated `eq_1` or `congr_simp`)
```

The stored binders are exactly the brief's — `(F : Subfield ℝ) [NumberField ↥F]` and `localBound F ≤ 5` — with no
`[NumberField.IsTotallyReal F]` and none of the chain's named hypotheses; the conclusion is the conditional form's
(`UpperHalf.chromaticNumber_eq_localBound_of_chain`) symbol for symbol. The axioms are the headline's, as expected: the
upper half adds none.

**The gate inputs, filed** (to be run at Stage 3): `scripts/Axioms.lean` — the two theorems under IMPORTED, after
`five_le_chromaticNumber_planeOver_of_five_le_localBound` in the `positive_entropy_rigidity` block where the records on
both imports are, with a comment line naming the job; `localBound_bot_le_two` under CLEAN in its own block above the
PURCHASED banner. `data/fs131/il5/run-gate.sh` is `data/fs131/clone1/run-gate.sh` with its log folder pointed at
`data/fs131/il5/gate/` and its slot names `il5-*` (the diff is those four lines).
