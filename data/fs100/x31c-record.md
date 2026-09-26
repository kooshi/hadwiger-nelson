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
