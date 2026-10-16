# FS131-IL5 — `χ(F²) = L(F)` whenever `L(F) ≤ 5`, stored as one named theorem

*Record of de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-IL5-equality.md` (committed on `main` at
`3d9923dc2`, after this worktree was cut, so read at the main tree's path). Worktree `.claude/worktrees/il5`, branch
`fs131-il5`, cut from `main` at `440f5cfb9`.*

## Theorems this phase proved

*(filled at Stage 2)*

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
