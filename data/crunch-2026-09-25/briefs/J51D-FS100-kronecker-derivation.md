*Brief for job **J51D**: the derivation of FS-100's stage 4, Kronecker selection. Opus 5.5. Written by J51, the FS-100 planner
(`plans/FS100-three-field-lemma.md` §S, which you may read in full). **Sized for about 2 hours and 300k harness tokens.** Runs beside J51V,
a blind verifier of the same claims; never contact J51V.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`,
`WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.**
The owner coordinates; the choices are Kooshi's, through the owner.

**If your record already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS100-J51D-derivation.md` and
continue at the first stage not SAVED.

## The claims (verbatim from `plans/FS100-three-field-lemma.md` §S; per claim TRUE / FALSE with a counterexample / GAP at a named step)

KS-1, KS-2, KS-3, KS-4, KS-5, KS-C, K0 — **quote them from §S's table into your record first, verbatim**, and work from that copy. Their
background: the stub `plans/STUB-measure-rigidity-three-fields.md` §2–§3 (read in full), the plan's §PA.3 and §S (the factor reading of
"the (T + A)-part"; J51-T3's sketch of KS-2, which you must write out or refute, not trust).

## Read first

- `LEDGER.md` rows 94, 95, 96, 97, 98, 102, 109, 113; `plans/FS91-derivation.md` for row 98's statement and proof shape (RS_k, SW-m,
  Berend's Thm I.2 with the rotated plane set aside); `plans/M3-derivation.md` M3-J21-MX (row 109); `plans/R88-derivation.md` R88-TCA.
- J37's poster `plans/POROS-2026-09-25-wanted-poster-47.md` §3.3–§4.5 (Kronecker selection's origin, T-J37-1, T-J37-4).
- `plans/FS84-SI-D-derivation.md` §5.4 (J45's lemma statements, for K0).
- Literature (§PA.2): EL2021 at `data/fs100/j51/el2021.pdf` (§1 read by the planner; read what KS-3 needs); Lindenstrauss–Wang 2012 and
  Z. Wang 2012 (fetch; zbMATH 1258.37031, 1278.37007) — the closed-set theory of non-irreducible and non-hyperbolic actions. Mark reading
  status per section (G50).

## Stages

1. Quotation check; §M: invoke `debruijn-domain-modeling` and then `debruijn-obligation-modeling` **freshly with the Skill tool**, applied
   to KS-1's statement (is the factor reading right; what is the statement from which the proof derives). A C0 table of your probabilities
   per claim. Save.
2. KS-2 and KS-4, KS-5 (the reduction and the controls). Save.
3. KS-3: rank one first (for `θ ∉ T + A`, is `cl θ(U)` the circle — weak approximation for the norm-one torus, rows 95/98), then rank `n`
   (orbit closures of the diagonal action). Save.
4. KS-1 and KS-C; K0 last, if budget remains. Save; the report.

**Stop rule:** at 250k harness tokens, finish the current claim, save, and report what is left. A GAP with the step named is a complete
result; a FALSE with its counterexample over ℚ(√11) is "the first control the gap has ever had". Do not lean toward TRUE.

## Rules

- **No subagents, forks or workflows** — delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about. If the work outgrows your context, stop at a saved stage and say what is left.
- **The finite-witness ban runs to 2026-10-01**: no SAT, MILP, Θ trees, finders, quotient searches or sweeps; exact arithmetic of seconds
  that checks a derived claim is in. Keep a "would have searched here" log.
- Record: `plans/FS100-J51D-derivation.md`, with "Theorems this phase proved" (grade and address per line); working files
  `data/fs100/j51d/`; exact checks `tools/j51d_*.py`, each with a planted fault watched firing.
- Do not edit `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, the stub or the planner's plan; propose edits.
- Commits by explicit path, subjects "J51D: stage n", never amend, push after each commit, never force-push.
- Report (standing rule 9) to `data/crunch-2026-09-25/reports/J51D.md`, committed, and by SendMessage to "main"; final turn text
  "J51D idle; report sent to the owner by SendMessage".

Thank you.
