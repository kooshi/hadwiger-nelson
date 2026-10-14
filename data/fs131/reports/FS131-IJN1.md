JOB FS131-IJN1 — DONE   harness≈450k (own≈300k)
RESULT: the five-colour chain is joined on branch `fs131-wj`, both small leaves are proved, and the headline is stated with every hypothesis the chain proves discharged. I read its axioms from the kernel.
- `Rigidity.noRamifiedStableDyadic_of_tca : ∀ (F : Subfield ℝ), TCA F → NoRamifiedStableDyadic F` — TRUE, [kernel], on the standard three. Informal statement read against it (FS100-EXC): T-C(A) leaves no stable, dyadic, ramified prime. Its `[NumberField F]` was dropped by your ruling.
- `Rigidity.ZdAction.mulTwoThree_model : mulTwoThree.IsIrreducible ∧ ¬ mulTwoThree.IsVirtuallyCyclic` — TRUE, [kernel], on the standard three. Informal statement: `×2, ×3` acting on `ℝ` is irreducible and not virtually cyclic. About 100 lines (priced 100–150), with no new import.
- `Rigidity.entropySplit` (PE-2 at one non-torsion rotation; moved to `ZeroEntropyClosed`) — TRUE, [kernel], on the standard three and the declared `positive_entropy_rigidity`, with no `sorry`.
- `Rigidity.zeroEntropyCarried : ∀ F [NumberField F], ZeroEntropyCarried F` (EF_F⁺ with no scope) — TRUE, [kernel], on the standard three.
- `Rigidity.mrPlus : ∀ F [NumberField F], MRPlus F` (MR⁺ over every real number field, no scope) — TRUE, [kernel], on the standard three and `positive_entropy_rigidity`.
- `Rigidity.min_localBound_five_le_chromaticNumber : ∀ (F : Subfield ℝ) [NumberField F], Plane.OneAvoidingDensityBound → (localBound F ≤ 4 → localBound F ≤ χ(F²)) → min (localBound F) 5 ≤ χ(F²)` — the headline. Informal statement: the local–global conjecture's main clause through five, lower half: `χ(F²) ≥ min(L(F), 5)`. Its conclusion is the closed headline's: the kernel compared the two terms and found them the SAME, and the control fired. It rests on `[propext, sorryAx, Classical.choice, Quot.sound, positive_entropy_rigidity, kloosterman_bound]`. Its `sorryAx` comes through exactly these seven leaves of other lines:
  - `ClassRatio` l. 214 `card_fibre`
  - `ClassRatio` l. 224 `norm_charSum_new_le`
  - `ClassRatio` l. 346 `ratioAtMost_dyadic`
  - `ClassRatio` l. 351 `chromaticNumber_le_four_of_small`
  - `ClassRatio` l. 359 `ratioAtMost_cert` (the certificates' link)
  - `ClassRatio` l. 366 `charBound_one_exact`
  - `Plane/OneAvoidingDensity` l. 54 `upperDensity_le_of_oneAvoidingDensityBound` (the density bound's instance)
  It keeps two hypotheses:
  - `hOA`: `[AmbrusEtAl2023]` Thm 1 as printed, a named hypothesis standing for an outside theorem.
  - `hRow99`: on `main`, `ThreeFourColours.localBound_le_chromaticNumber_of_le_four` states it text for text, so the landing can discharge it.
- Ruled restatements, each a strictly stronger theorem, checked from the kernel's side against the type computed by surgery on the old term:
  - eight binder drops: lane N's five unread hypotheses, the scope binders of `zeroEntropyCarried` and `mrPlus`, and `noRamifiedStableDyadic_of_tca`'s instance;
  - `Counting.ratio_unramified_of_tca`'s section instance, omitted as the cascade of that drop.
- `positive_entropy_rigidity` is declared to the audit with its eight records. `axioms.sh` reads OK: 7447 clean, 34 imported (26 before). The control (the declare line removed) fired.
- The gate on build 5:
  - Build: green (257/257), every warning a `sorry` of another line's leaf.
  - Statements: PASS, 1,132 constants — 4 moves, 8 drops, 1 new — control 10/10.
  - Axioms: 235 records PASS, control 4/4.
  - Guarded lint: 14/14, with its plant fired and restored.
  - `dupnames`: OK.
  - Architecture check: PASS.
RECORD: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/plans/FS131-IJN1-join.md (branch `fs131-wj`)   COMMITS: e985c44e8 891b8eb4d (merges) de970db4d f691d58ee 22eb91aac a234607d2, and the report's commit
INVENTORY:
- result — on this branch, 851 of the chain's 870 public records rest on the standard three and 8 on the declared Einsiedler–Lindenstrauss alone. Only 11 carry `sorryAx`, all through the seven leaves above or `RingScope`'s off-path `R = O′` — `data/fs131/ijn1/draft-axioms-block.lean`
- result — the entropy side, the zero-entropy side, M11, lane A, M2a/M2b/M3/M10 and the count's own modules compose with no `sorry`: `mrPlus` (MR⁺ over every real number field) is a kernel theorem on one declared outside theorem — record § Stage 4
- generalization — `noRamifiedStableDyadic_of_tca` holds over every real subfield (no `NumberField`); lane N's four statements hold with no sign or length hypothesis; `ratio_unramified_of_tca` likewise — record §§ 3, 5.1
- correction owed — 28 module titles of the branch still say "skeleton" though their modules hold no `sorry`; the landing's docstring sweep — record § 3 item 6
- correction owed — `zeroEntropyCarried` and `zeroEntropyCarried_of_numberField` now have one stored type (two names for one fact); both kept, since no ruling removes one — record § 3 item 1
- statement defect (minor) — the `example` modelling `card_words_badStarts_le`'s hypotheses still lists the two dropped clauses (a superset of what the theorem now takes); unchanged — record § 3 item 3
- question for another lane — Lemma F (`Pieces`, private): no second module reads it, so it stays private. `BochnerTau.finite_quotient_nsmul` is its instance `G = R`, proved separately; a note for the landing planner, beside `main`'s `ThreeColourCriterion.finite_quotient_span_prime` — record § 3 item 4
- question for another lane — M3's ten private copies of `main`'s `Plane/OneClass/InvariantLaw` helpers (and `avgMeasure`) cannot be shared before the landing joins `main` — record § 3 item 5
- tool defect (own, fixed) — the statement reader's first control counted reports rather than planted constants, and read a VALUE-only plant as proof-only; its first run stopped at `SpectralChain.corr.eq_1`, which two modules declare. All three were fixed before the receipts — record § 3
HELD FOR THE COORDINATOR:
- drafts to file at the landing:
  - the audit's CLEAN block for the chain (851 lines), `data/fs131/ijn1/draft-axioms-block.lean`;
  - the assumptions step's 23 ledger rows and 13 entries, `data/fs131/ijn1/draft-assumptions.txt` — `Plane.OneAvoidingDensityBound` undeclared (an outside former, `[AmbrusEtAl2023]`), four conditions now stale because the chain concludes them, three formers needing a `.condition`;
  - five `LEAN.md` lines, `data/fs131/ijn1/draft-lean-md.txt`;
  - the § Trust sentence's "four outside axioms", record § Drafts D4.
- `scripts/assumptions-ledger.txt`: this job added only the nine `RESTS` rows of `positive_entropy_rigidity`. The header counts are left for the landing's `--write-ledger`; `./scripts/assumptions.sh` on this branch exits 1 with 45 checks, every one listed in the draft.
- not run (the landing's): `vacuity.sh`, the self-tests of `axioms.sh`, `dupnames.sh` and `assumptions.sh`. The audit's self-test has count-reading controls that will need the 34 imported records.
- the build: this tree's compiled library is current for `fs131-wj` at build 5. The raw dumps were deleted after compression; their `.xz` and sha256 are committed. Nothing is running or queued. Nothing is pushed (the brief).
