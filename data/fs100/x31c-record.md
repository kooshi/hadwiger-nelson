# X31C — the follow-on fold of X27D and X27V (TR-ROT): close-math and front page in one small job (record)

*de Bruijn (Opus 5.5), job X31C, 2026-09-26, from 12:26 UTC (launched after X30F's hand-back, last commit `efa56d37`). Brief:
`data/crunch-2026-09-26-x2x3/briefs/X31C-tr-rot-fold.md`, with `STANDING-RULES.md` and the owner's three added notes (from X30F's report).
Launch HEAD for the fact audit's `--base`: `efa56d37`. One mind; no subagents.*

## Theorems this phase proved

None. X31C files and folds; every theorem below is X27D's or X27V's, graded at `plans/FS100-derivation.md` §5.

## Stage 1 — SAVED (quotation check; the derivation entries, §5)

### 1.1 Quotation check (standing rule 5)

| quotation in the brief | source checked | result |
|---|---|---|
| NA₀: "no non-zero finite E-null measure on `R̂` has all its `U`-Følner averages converging onto `T₄`" | `plans/FS100-X27D-derivation.md` §2.6: "No nonzero finite positive `E`-null measure on `R̂` is `T₄`-attracted under `U`" (every `U`-Følner average of it converging onto `T₄`) | **paraphrase; drops "positive"**. Same statement for the measures in question (spectral remainders are positive); every text X31C writes quotes §2.6 verbatim |
| "pure dynamics of `U ↷ R̂`" | X27D §2.6: "NA₀ is pure dynamics of the algebraic action `U ↷ R̂`" | verbatim in substance |
| "X27V's COL-E is the same step in measure form, and NA₀ ⟹ COL-E" | `plans/FS100-X27V-verification.md` §4.1: "agree on the wall; the two named steps differ in strength. NA₀ ⟹ COL-E, and given MR COL-E ⟺ Q-μ (COL-E is the exact equivalent, NA₀ a sufficient condition that might be false while Q-μ holds …)" | **"the same step" overstates**: one wall, two strengths — COL-E is exact given MR, NA₀ sufficient. Written so in every text below |
| "given MR, TR-ROT is all of Q-μ at the type-(B) fields (X27D-EQ = X27V-EQ, blind)" | X27D §2.1; X27V §2.1 (committed `9feb1e73` before any fenced file), §4.1 row 1 | verbatim in substance |
| "X27D-E = X27V-TA+FS: given MR, every translation-invariant random four-colouring has `σ_μ(E ∖ T₄) = 0`, so T-C′'s (R1) is closed given MR" | X27D's table: "`σ_μ|_E = σ_μ|_{T₄}`"; X27V's table X27V-FS: "`σ_μ(E ∖ D) = 0`", X27V-R1 | equivalent (`T₄ ⊂ E`); verbatim in substance |
| X22V's qualifiers "affine, `U`-invariant" | X27D §1.2, quoting X22V §2.2: "a continuous, affine, `U`-invariant functional on `M_T` that vanishes on the Pull-measures and is positive on `M′`" | verbatim |
| owner note 1: "a bracket, not a value", "the value five is not claimed", "ℚ(√167) … still at a proven three" (§1.7); "all have degree 8" (§3); "Our answer" (§2.6) | `CLOSED-QUESTIONS.md` lines 299, 304, 309, 529, 498 | all present at launch |

### 1.2 The derivation entries

`plans/FS100-derivation.md` §5 (home FS100, entries parsed by `tools/fs71_ledger_b_check.py`'s `ENTRY_RE`): FS100-X27D-EQ, FS100-X27D-E (with
X27V-R1 as its corollary line), FS100-X27D-ATT, FS100-X27D-FL, FS100-X27D-SIERP, FS100-X27V-PM. Grades under the owner's rulings (the brief):
E two derivations, blind; EQ and FL two blind (X27V §2.1, §2.4 committed before any fenced file); ATT one mind with (S1)–(S2) matched blind and
(S3), Haar-singularity re-derived from the statements; SIERP and PM one mind. Prior art in every entry: not searched; home discipline homoclinic
points of algebraic actions (`[LindSchmidt1999]`, reviews only, unread) — logged as a prior-art debt. Kernel: declined.

### 1.3 Would have searched here (Stage 1)

- None.

### 1.4 The owner's two additions (message received during Stage 1, after X11K3 landed)

1. A kernel row after the TR-ROT row (so row 127, TR-ROT being row 126), in M2's kernel-row form, for
   `SpectralChain.min_localBound_five_le_chromaticNumber` and `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five_of_chain`; FS-101's stub
   and FRONTIER row updated (first slot done; next L1 as Markov–Kakutani, then the upper half via row 57's gap, then Herglotz–Bochner). The L1
   repair (`[Countable (unitRing F)]`) stays in the kernel record only (owner ruling). Sources: `data/crunch-2026-09-26-x2x3/reports/X11K3.md`,
   `plans/FS100-K-kernel-47.md` §X11K3.
2. Stale gate counts in `CLAUDE.md` § Trust ledger and § The gate, read from `build/gate/axioms/latest` and `build/gate/vacuity/latest`; the
   reviewed transition in `tools/claude_md_fact_audit.py`'s gate-count table; the counts comment in `scripts/vacuity-baseline.txt` (precedent
   `2071cfdf`). Both files added to the touch list for those lines only.

§ B lines for §5 were added in this stage (six, pointing at row 126, written at Stage 3) so that `fs71 --strict` passes at every commit:
exit 0, PASS, 784 rows.

## Stage 2 — SAVED (the plan's §R-close (stage 5, wave 3b); the wave-3 inventory, items 122–150, appended and ticked)

`plans/FS100-three-field-lemma.md` § "§R-close (stage 5, wave 3b)": verdicts per claim (EQ, E, TR-ROT, ATT, FL, SIERP, PM), the owner's rulings
1–7, both C0 tables scored, the ban log, slips (X27V's two, the owner's, the brief's), §G/§IQ/prior art. Items 147–149 are ticked for work in
Stages 3–4 of this record (CLOSED-QUESTIONS, `--dupes`, the kernel row, the gate counts); a later stage that does not land one reopens it.

### Would have searched here (Stage 2)

- None.

## Stage 3 — SAVED (the front page; the owner's two additions)

- `LEDGER.md`: **row 126** (TR-ROT's verdict, X27D-EQ and E, NA₀ quoted verbatim from X27D §2.6) and **row 127** (FS-101's first slot, M2's
  kernel-row form: the headline and `χ(ℚ(√47)²) = 5` over named hypotheses, `χ(ℚ(√47)²) ≤ 5` unconditional; gate numbers from X11K3's report,
  the axiom counts re-read from `build/gate/axioms/20260926T122606Z-1387817.log`: 1,247 records in CLEAN of which 11 axiom-free, so 1,236 clean,
  and 5 purchased — 1,252 records); row 124's "TR-ROT (under attack …)" replaced by "a GAP at one named step (row 126)"; § B lines (Stage 1).
  Rows 88 and 113 carried no "under attack" text; unchanged.
- `CLAUDE.md`: item 24, rank 3 and rank 8 rows (verdict for "under attack"); rank 3′ (FS-101's first slot); the ledger pointer 1–125 → 1–127; the
  kernel paragraph (FS-101's first slot, row 127); the Last-updated line (wave 3b); G21's clause (the owner's slip); G79's clause (the data point).
  **Gate counts** (owner's addition 2), from `build/gate/axioms/latest` and `build/gate/vacuity/latest` (`20260926T122608Z-1388046.log`:
  `declarations=7438 refutations-skipped=313`, `sites=279 vacuous=0 stale=0 declared=3 witnessed=17 generic=257 unknown=2`): § Trust ledger
  1193 → 1236 clean, 1,209 → 1,252 records; § The gate 7279 → 7438, 309 → 313. `scripts/vacuity-baseline.txt` comment line likewise.
  `tools/claude_md_fact_audit.py`: ALLOWs `1–125`, `X27D/X27V` (the FS-98 row's "attacked it at the close", superseded by row 126), `7279`,
  `declarations=7279`, `309`, `refutations-skipped=309`, `1193`, `1209`; GATE_CHANGES `(1193, 5) → (1236, 5)`, X11K3's gate log.
- `plans/R88-derivation.md` §G T-C′: (R1) closed given MR; Q-μ = (R2) = TR-ROT given MR; NA₀ / COL-E left.
- Stubs: FS-100's (wave-3 status sentence; a wave-3b line closing the J38 block, NA₀ verbatim); FS-98's (TR-ROT's verdict, NA₀ beside T-B1);
  FS-101's (first slot done; next Markov–Kakutani, row 57's gap, Herglotz–Bochner).
- `plans/FRONTIER-STUBS.md`: the open-milestones summary, rank 3 (FS-100), rank 3′ (FS-101), rank 8 (FS-98), and the wave-3 closed-list entry.
- **`--dupes`: 11 at launch → 12 after row 126 was appended → 10.** Two second tellings made pointers to their one home (row 123's Fischer §1
  quotation → "quoted in row 99"; row 123's copy of X24R's gate extent → "its extent in row 121"). **Left, with the reason:** the three runs
  that are table structure, not retold facts — the milestone cell "FS-100 stage 5, wave 3 (crunch 2026-09-26)" closing rows 123, 124, 125 and
  run into the next row's opening bar (two tellings; the second appeared when row 126 was appended after row 125), and two § B lines whose
  statements both end "`L ≥ 5`" beside the same grade cell. The seven older runs predate the crunch's wave 3 and are outside the owner's note.

Gates at this stage: fact audit `--base efa56d37` exit 0 PASS; `--dupes` 10 runs / 628 B; `fs71 --strict` exit 0 PASS; `bib_audit` exit 0;
`check_architecture` exit 0 PASS. `CLAUDE.md` 295,503 → 296,094 bytes.

### Would have searched here (Stage 3)

- None.
