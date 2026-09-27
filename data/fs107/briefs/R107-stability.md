*Brief for job **FS107-R**, competitor R of FS-107: prove stability. Opus 5.5. Drafted by the planner FS107-P, 2026-09-27, for the owner to launch
beside FS107-W. **`data/fs107/briefs/SHARED-107-competition.md` is part of this brief, word for word identical to W's; read it first, then
`STANDING-RULES.md`.***

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`.

## Your object and your question

**Your question is claim R of `data/fs107/claims.md` §1** — C-Q-STAB in its exact disc form: "for some `R` and `δ₀ > 0` and every `ε > 0`, every
partial six-colouring of `U_R(0)` with no monochromatic pair at distance in `[1 − ε, 1 + ε]` leaves at least `δ₀|U_R|` uncovered." Its sufficient form
R′ (C-VOID) and the rung R″ are yours too. **You choose your object and say which, per lemma:** the sequence object SEQ (route R-Q, periodic
grid-square colourings, where the only gap is the hole gap) or the limit object LIM (route R-S, through §5's named steps). Label every lemma "on SEQ",
"on LIM" or "on both".

## What the re-grokking asks of you (plan §G part 3, X1–X6, X18)

1. **Test before you write (X1).** Before any argument is written out, run it against the five killing tests of `claims.md` §3 — Parts calibration,
   seven-colour control, strip test, pinhole test, normalisation — and put the results as its first lines. An argument that survives the strips is in
   hitting form (capped at `ε`); one that survives pinholes is capped at `ε²`.
2. **Where does the pigeonhole live? (X2)** Voronov's proof is a trichromatic-point pigeonhole composed with kills (G15). On SEQ the pixel lemma
   (K-PIX) removes every multichromatic coloured point at arbitrarily small cost. Say where your argument's pigeonhole lives — in the holes, in the
   limit, or averaged over positive measure — what its carrier size is (G17), and why the free colour on the holes cannot absorb it (G40).
3. **Shapes, not routes (X3).** Candidates the corpus offers for a count no hole arrangement can defeat: the measure fan at a kept point (FS106-REM;
   G13); a counting compulsion on each unit circle (G53); PD-EQ's quadratic form `⟨g, g ⋆ ν_ε⟩` on `L^∞(ℝ², Δ₆)` (G75; `claims.md` §6); junction types
   and complementary pairs at scale 2 (K-C6, K-TAN, K-KILL). And the harmonic-analysis literature on sets avoiding distances (Bukh; Falconer–Marstrand;
   Furstenberg–Katznelson–Weiss; §PA row 8) — none held; ask the owner for any you need.
4. **Integrality (X4).** Name the step where the count six enters and why the same step fails at seven (K-INT; the hexagonal control).
5. **Rank (X6).** S–V's Question 2 and the other special cases are tools, ranked below the equivalence; on SEQ, index swaps cannot occur (grid
   boundaries), on LIM the no-swap lemma is owed (FS106-IND-X).
6. **Closed shadow (X18).** R's finite-graph shadow — bounded non-colourable graphs near the band for every `ε` (row 41's limit lemma) — is closed as a
   route by Kooshi's ruling. Do not pursue it.

## Stages

1. Quotation check; your restatement of R, R′, R″ beside the quotations; your answer to the advisor's question (which step of W's programme fails);
   the killing tests' five objects written down concretely (eroded Parts tiling; slack hexagonal 7-colouring; strips at spacing 2; pinholes at junctions;
   the area normalisation).
2. Your first argument's shape, tested per item 1, and item 2's answer.
3. The argument, or the named obstruction it meets — a theorem about a class of arguments is a result.
4. Verdicts on R, R′, R″ and every §5 step you touched; the rung R″ if reached.
5. After hand-back only: read W's record, and record every divergence of truth and of route.

## Rules

- **Your record:** `plans/FS107-R-stability.md`; working files `data/fs107/fs107-r/`; tools `tools/fs107_r_*.py` (exact checks only, each with a
  planted fault). Touch nothing else.
- **Fenced (SHARED § Fences):** W's record `plans/FS107-W-near-colourings.md` and `data/fs107/fs107-w/`, until you have handed back.
- The advisor's id comes from the owner. Report per standing rule 9 to `data/fs107/reports/FS107-R.md`.

Thank you.
