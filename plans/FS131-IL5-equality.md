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

## Stage 3 — SAVED: the gate on one commit

**The commit.** `113ca8ece` (branch `fs131-il5`): the module, its root import and map row, the three records in
`scripts/Axioms.lean` (Stage 2's `8333a01d9`), and the gate inputs the records need by the gate's own rules (this stage):

- `scripts/axioms-controls.txt` — the two controls that read the library's state, **seen red first**: the self-test on the
  new audit failed exactly `baseline` (expected `imported=60`, got 62) and `imported_declared` (expected 61, got 63), with
  `declared` and `library` unchanged and the other 21 controls behaving (`data/fs131/il5/prep/axioms-selftest-red.log`) —
  the predicted red, for the predicted reason. Moved by the file's own rule (`imported` by the records; the `old` digests'
  texts follow; the header's tally: sixty-two IMPORTED records, Weil's bound 48, the five-colour theorem 6, E–L 18, 10 on
  both — 48 + 6 + 18 − 10 = 62), then green, 23 of 23 (`prep/axioms-selftest-green.log`).
- `scripts/assumptions-ledger.txt` — **seen red first**: the step failed on exactly four `unlisted-consumer` rows, the four
  `RESTS` pairs (each new theorem on `positive_entropy_rigidity` and on `kloosterman_bound`), and flagged `rests 74 → 78`
  stale and nothing else (`prep/assumptions-red.log`). Written by `./scripts/assumptions.sh --write-ledger`: four rows in, none
  out, 184 → 188 rows, the header's `rests=78` (`prep/assumptions-write-ledger.log`). No `AssumptionAudit.declared` line:
  the theorems take no hypothesis standing for an assumption.
- `scripts/vacuity-baseline.txt` — the header's count line, `declarations=22238` → `22241`, after the scan flagged it stale
  and nothing else (`prep/vacuity.log`).
- `tools/fs131_il5_coverage.py` — the audit checks no module's coverage, so this checks it for the new module: every
  constant the compiled module declares (the kernel's list, `print-new.log`: three) is filed once in `scripts/Axioms.lean`,
  under the section its printed axioms require. Clean run exit 0; `--plant` (a constant nobody filed) exit 1, naming it;
  `--plant-misfile` (the CLEAN model read as filed under IMPORTED) exit 1, naming the section (`prep/coverage*.log`).

**The pass.** `data/fs131/il5/run-gate.sh` (this morning's steps, logs to `data/fs131/il5/gate/`), 04:59:55–05:14:12 UTC,
`HEAD=113ca8ece…`, tracked files modified at the start 0 and after the pass 0. Every step exited 0; read from the saved logs:

| step | this morning (`clone1`, `16a2d4499`) | this pass (`113ca8ece`) | the change, explained |
|---|---|---|---|
| up to date | exit 0 | exit 0 (4 s) | — |
| `sorry` (narrow) | 0 lines | 0 lines | — |
| line-initial `axiom` | 5 lines | 5 lines, the same files and lines | — |
| doubled names | OK, 31 generated on demand | OK, 31, the list identical | the module generates no constant (`print-new.log`: 3 declared, 3 written) |
| its self-test | 15 of 15 | 15 of 15 | — |
| axiom audit | 11284 records: 10650 clean, 569 axiom-free, 60 imported, 5 purchases | 11287: **10651** clean, 569, **62** imported, 5 | +3 records: `localBound_bot_le_two` CLEAN (+1), the two theorems IMPORTED (+2); declared imports 3, library axioms 3, native auxiliaries 10, unchanged |
| its self-test | 23 of 23 | 23 of 23 | after the two state controls moved (above) |
| vacuity | declarations=22238, refutations-skipped=240; sites=1455 vacuous=0 stale=0 declared=3 witnessed=38 generic=1412 unknown=2 | declarations=**22241**, the rest identical | +3 declarations, the three theorems; **no site** — the scan is silent on the module, its binders being `F : Subfield ℝ`, `[NumberField F]` and `localBound F ≤ 5`, none a tracked carrier |
| its self-test | 65 of 65 | 65 of 65 | — |
| assumptions | axioms=3 rests=74 named=19 inline=14 outside=7 ours=21 open=5 takes=108 mentions=2 | rests=**78**, the rest identical | +4 `RESTS` rows; also (not among the nine) constants 21917 → 21920 and theorems 16043 → 16046 (the three), hypotheses 26310 → 26313 (the two `[NumberField F]` binders and `h`), `unseen` 21275 → 21276 (`h : localBound F ≤ 5`, a condition on the theorem's own variable, which the step counts and cannot decide), theorems on E–L 16 → 18 and on Weil's bound 52 → 54 |
| its self-test | 33 of 33 | 33 of 33 | — |
| architecture | PASS | PASS, 618 modules, 618 rows | +1 module and row |
| lint | 14 linters `(2/2) Passed!`, "Linting passed for Proofs." | the same | — |
| digests | every count matches `CLAUDE.md` and the two ledgers' headers | the two headers match (9 of 9 each); `CLAUDE.md` flagged stale in exactly three places: § The gate `declarations 22238 → 22241`; § Trust ledger `rests 74 → 78`; § Trust ledger `10650 clean → 10651, 60 imported → 62` | `CLAUDE.md` is Keryx's to write: drafts D6, D7 below |

The receipt (`gate/receipt-axioms.log`) files `chromaticNumber_planeOver_eq_localBound_of_le_five` and
`min_chromaticNumber_five_eq_min_localBound_five` under IMPORTED, each on `[propext, Classical.choice, Quot.sound,
Rigidity.positive_entropy_rigidity, StandingFive.kloosterman_bound]`, and `localBound_bot_le_two` under CLEAN on the
standard three.

**Negative controls watched going red in this job**: the audit's two state controls and the assumptions step's four rows
(above, each red for its named cause before its input moved); the coverage check's two plants; and the architecture check
on two planted copies of the map — the new row deleted (`FAIL module coverage`, "missing: ['Rigidity/MainClauseFive']") and
its imports cell set to `Rigidity/SqrtClassFive` (`FAIL imports of Rigidity/MainClauseFive: stated-only
['Rigidity/SqrtClassFive'], real-only ['Rigidity/ChainHeadline']`), the unplanted map PASS (`prep/arch-plant-*.log`,
`prep/arch-clean.log`). Each self-test plants its own (15, 23, 65, 33 controls). **Not run: a lint plant** — the lint step
is the driver over the whole library; a plant in this leaf module costs two rebuilds of it (about 7 minutes each,
`LEAN.md` § Building, FS131-LGT1's measurement), and the driver's control was watched at FS131-LGT1; this morning's pass
ran none either.

**Models, by hand** (the scan adds no site, so the landing names them): `[NumberField F]` and `localBound F ≤ 5` hold at
once at `F = ℚ` — `UpperHalf.instNumberFieldBot` and `Rigidity.localBound_bot_le_two`, both kernel theorems on the standard
three; the spec `example`s read both new theorems there. At `L(F) = 5`, the hypothesis is inhabited in mathematics where row
123 reads `χ = L = 5` (ℚ(√47), at [hand] for `L ≤ 5`'s side); no declaration states `L(ℚ(√47)) ≤ 5`, so the kernel's model is
the one at `ℚ`, as the module docstring says.

**`ARCHITECTURE.md` § 5 (Trust)**: no edit. Its import rows' consumer columns name principal consumers, not every record
(E–L's names seven of sixteen, ending at the headline), so the two new records are not owed a mention there.

**Read aloud, against `ROADMAP.md` § 3 item 1** — "**`χ(F²) = L(F)` whenever `L(F) ≤ 5`, as one named theorem.** It is a
two-line composition of `Rigidity.min_localBound_five_le_chromaticNumber` with
`UpperHalf.chromaticNumber_planeOver_le_localBound`". The kernel stores
`HadwigerNelson.Rigidity.chromaticNumber_planeOver_eq_localBound_of_le_five : ∀ (F : Subfield ℝ) [NumberField ↥F],
localBound F ≤ 5 → (SimpleGraph.induce (planeOver F) (unitDistance ℂ)).chromaticNumber = localBound F`. Read: for every
subfield `F` of `ℝ` that is a number field — a real number field as the library takes one, an embedded image in `ℝ` — if
`L(F)`, the infimum over the conjugation-stable primes `P` of `F(i)` of the chromatic number of the level-one residue target
(`SpectralChain.localBound`, valued in `ℕ∞`), is at most five, then the chromatic number (Mathlib's
`SimpleGraph.chromaticNumber`, valued in `ℕ∞`, `⊤` when no finite colouring exists) of the unit-distance graph of `ℂ`
induced on `planeOver F = {z : Re z, Im z ∈ F}`, which is `F²`, equals `L(F)`. That is the item's statement, with no other
hypothesis; its proof is the item's two-line composition (`le_antisymm` of the upper half and the headline read at
`min(L(F), 5) = L(F)`). It names the theorem a reader cites, and it is one theorem, not the conditional form over the chain's
named hypotheses (`UpperHalf.chromaticNumber_eq_localBound_of_chain`, which also asks `[NumberField.IsTotallyReal F]`). The
`min` form, `min(χ(F²), 5) = min(L(F), 5)` for every real number field, is read the same way and is strictly stronger than
the item (Stage 1). Neither moves a value of `χ(ℝ²)`.
