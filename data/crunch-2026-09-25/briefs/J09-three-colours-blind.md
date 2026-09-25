*Brief for crunch job **J09**, milestone M1 (FS-91, stage 0): an independent, blind derivation of three statements about three-colour
planes over real number fields. Opus 5.5, 2026-09-25. Written by the crunch planner (`plans/CRUNCH-2026-09-25-queue.md` §2).*

Hello. You are de Bruijn (`DEBRUIJN.md`), working as a **blind deriver** in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. The house rules are `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md`; read all three from disk, since the
copy loaded at your start may be stale. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** The
product owner coordinates and reviews by artifact. The verdicts are yours.

## Why you, and why blind

The local–global conjecture (G48) says `χ(F²) = L(F)`, the best bound a residue plane gives, wherever `L(F) ≤ 6`. At three colours it
is proved for real quadratic fields and for fields containing √3. One class of real number fields is left open (FS-82,
`plans/STUB-three-colours-residue-degree-three.md`).

Another agent (J02) is working from an advisor's sketch that would close the class. **You work from the statements alone**, by your own
route, with everything this project has proved at your disposal.
- If you and J02 both reach a proof, the result carries the grade row 82 carries: "two independent derivations".
- If one of you finds a gap or a counterexample, that is the finding.

**Every outcome counts** (standing rule 4). A point of `Θ₃(ℚ(α, √7))`, the set defined below, would be a three-colouring of that
field's plane that is local at no prime: a falsifier of the conjecture. That is as valuable as a proof. Do not lean toward a yes.

## The statements (verbatim, as the planner fixed them from the advisor's record)

The advisor's words, `plans/POROS-2026-09-25-crunch-plan.md` §1.2 F1 (you may not open that file; the quotation is here): "**If this holds:
χ(F²) ≤ 3 ⟺ L(F) ≤ 3 for every real number field, so the conjecture's L ≤ 4 clause holds everywhere.**" Also: "First instance
ℚ(α,√7): Θ₃ = ∅, so χ = 4."

1. **S1.** For every real number field `F`: `χ(F²) ≤ 3 ⟹ L(F) ≤ 3`.
2. **S2.** The conjecture's `L ≤ 4` clause holds for every real number field: `χ(F²) = L(F)` whenever `L(F) ≤ 4`.
3. **S3.** `Θ₃(ℤ[U_F]) = ∅` for `F = ℚ(α, √7)`, `α³ = α + 1`, so `χ(F²) = 4`.

**The definitions:**
- `L(F)` and "usable prime": `CLAUDE.md` § Notation.
- `U_F`: the unit vectors of `F(i)`.
- `Θ₃(R) = {θ ∈ Hom(R, ℝ/ℤ) : θ(u) ∈ [1/3, 2/3] for every u ∈ U_F}`.
- The FS-82 stub gives the field's arithmetic; re-derive it.

For each statement give a verdict, TRUE / FALSE / GAP-at-a-named-step, with the hypotheses your proof actually uses. Say whether it
needs `[F : ℚ] < ∞`, and whether S1 extends to every subfield of ℝ.

## Read first, from disk: everything the project holds, except the fence below

- `CLAUDE.md` in full, from disk.
- `LEDGER.md` in full, or at least rows 52–97.
- The derivation files `plans/FS73-derivation.md`, `plans/FS81-derivation.md`, `plans/FS86-derivation.md` and `plans/FS89-derivation.md`,
  and the FS-89 stage records (`plans/FS89-S0A-…`, `-S0B-…`, `-S1D-…`, `-S1V-…`, `-S1VB-…`).
- The FS-82 stub in full.

Every theorem in them at its stated grade is yours to use; cite each by its id.

## What you must not open until your stage-3 verdicts are committed

- `plans/POROS-2026-09-25-crunch-plan.md`;
- `data/crunch-2026-09-25/briefs/J02-three-colours-stage0.md`;
- J02's record `plans/FS91-S0F-three-colours.md`, and `data/fs91/j02/`;
- `git log -p` or `git show` of any commit whose subject names J02;
- `plans/FS91-close-inventory.md`;
- M1's plan `plans/FS91-character-local-global.md`, which another job is writing now;
- `plans/CRUNCH-2026-09-25-queue.md` beyond its §1.

**After stage 3:** open `data/fs91/j02/lemma-statements.md` (J02's lemmas, statements only) for stage 4. After stage 4, open J02's record
for stage 5.

## Stages

- **Stage 1 (about 25k).** Check the quotations above against the sources you may open (the stub, `CLAUDE.md` § Notation). Write C0: a
  probability per statement, and the route you expect to take, before any derivation. Save.
- **Stage 2 (about 150k).** Derive S1 by your own route. If it stalls, the verdict is **GAP at the named step**, not a guess. Save after
  each lemma.
  - Exact checks go in `tools/crunch_j09_*.py`, with a planted fault.
  - A complete enumeration of a finite set that a derivation fixed first is at the ban's edge; log it.
- **Stage 3 (about 50k).** S2 and S3. Commit the verdicts. Save and report (a stage report).
- **Stage 4 (about 60k).** If `data/fs91/j02/lemma-statements.md` does not exist yet, save, report `STAGE 3 SAVED — waiting on J02`, and stop; the owner resumes you on this brief when it lands. Otherwise open J02's lemma statements. Derive or refute each one your route did not already establish, and check
  whether, as stated, they imply S1–S3. Save.
- **Stage 5 (about 30k).** The divergence table against J02's record: every difference of truth, scope or route. Save and report.

## Your record and your paths

- **Record:** `plans/FS91-S0FV-three-colours-blind.md`, with C0, the stages, the divergence table, the would-have-searched log, and
  "Theorems this phase proved".
- **Data and tools:** `data/fs91/j09/`, `tools/crunch_j09_*.py`.
- **Budget:** about 350k in the harness's count. Hand back by 420k.
- **Report:** standing rule 9, after stage 3 and at the end.
