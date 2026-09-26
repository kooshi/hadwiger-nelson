*Brief for job **X23D** (wave 3): SP-Cor and the class for every real number field, and ℚ(√3,√5). Opus 5.5. Written by the crunch planner
(`plans/CRUNCH-2026-09-26-x2x3-queue.md` §7, list X23, revised 06:27 on the advisor's F1 and F4). **Sized for about 45 minutes and 250k
harness tokens.** A blind verifier, X23V, works on the same claims; never contact it.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. `CLAUDE.md` is in your context (G35, G48, G54, G56, G59 bear).
**`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` is part of this brief; read it in full.** Its clock is replaced here: **your stop
time is 12:30 UTC.**

**If your record already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS100-X23D-derivation.md`.

## The question

MR(F) now holds for every real number field (at [hand] grade, with row 100's exception; §7's first paragraph). The step from MR to five
colours, SP-Cor, was derived at ℚ(√47) (J45) and carried to the real quadratic `L ≥ 5` family (row 117, K0). **Does it hold for every real
number field, and is its hypothesis T-C(A) exactly `L(F) ≥ 5`?** If both hold, `χ(F²) ≥ min(L(F), 5)` for every real number field: the
local–global conjecture's main clause through `L = 5`, in full. The advisor's named risk: A⁺'s archimedean step at `n > 2` real places
(X03D's `Λ = 0.4028 > 1/3` shows first moments alone cannot do it). **A FALSE or a GAP counts in full.** The advisor's falsifier for SPC and
CLS together: a field with `L ≥ 5` and a known four-colouring. Name the fields where one would have been expected.

## The claims

Copy §7's first paragraph and **list X23** (SPC, CLS, COR, CTL, Q35, D-1, with the quoted inputs) into your record first, verbatim.

## Read first

- `plans/FS84-SI-D-derivation.md` §4.2 and §5.4 (SP-Cor, A⁺ and the lemma statements) and J45's proof of A⁺ (§3); X05V's re-derivation P0–P8
  (`plans/FS100-X05V-verification.md` §2.1: which steps are field-general).
- `LEDGER.md` rows 67, 75, 100, 112, 113, 117; `plans/FS100-derivation.md` §2 (FS100-T1 and its inputs: the dyadic place, FS-66 at 11 and 19,
  Lemma P, Hoffman's table, Weil); `CLAUDE.md` G54 (tower constancy), G56 (the trichotomy above 2; `U_Q`), G59.
- X03D's FL-K and SPEC (`plans/FS100-X03D-derivation.md` §3.2–§3.3), for the archimedean step.

## Stages

1. Quotation check; C0 per claim. Save.
2. CTL first (the controls must come out as stated; say what a wrong-reason pass would look like). Then CLS. Save.
3. SPC: A⁺'s archimedean step at `n` real places, then the chain. COR. Save.
4. Q35 (an exact residue-degree table of seconds is in; the finite set of primes is fixed by the derivation first), then D-1. Save; the report.

**Stop rule:** at 230k harness tokens or 12:30 UTC, finish the current claim, save, report. Do not lean toward TRUE.

## Rules

- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about. If the work outgrows your context, stop at a saved stage and say what is left.
- **The ban** (standing rule 3); keep a "would have searched here" log. Exact arithmetic of seconds that checks a derived claim is in.
- **Record** `plans/FS100-X23D-derivation.md` with "Theorems this phase proved"; working files `data/fs100/x23d/`; checks `tools/x23d_*.py` with plants watched firing.
  Do not edit `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, the stub or the queue; propose edits in your record.
- **Commits:** by explicit path, subjects "X23D: stage n"; never amend; push after each commit; never force-push.
- **Report** (standing rule 9) to `data/crunch-2026-09-26-x2x3/reports/X23D.md`, committed, and by SendMessage to "main". Final turn text:
  "X23D idle; report sent to the owner by SendMessage".

Thank you.

## Addendum (06:24, the advisor; one mind; X23V does not have it)

- The advisor poses SPC and CLS for **totally real** `F` (its D-5, D-6). Waves 1–2 found that the height `H` over finite places misbehaves when
  `F` has a complex place (X01V, X02V, X12B: `U_1` is infinite there). **If a claim holds for totally real `F` and fails or is ill-posed with
  a complex place, record both verdicts.** "SP-Cor(F) holds with J45's proofs over every totally real F in T-C(A)'s class. The job must name
  every step of J45 that uses [F:ℚ] = 2."
- The advisor's exact check of Q35's input (sympy, Legendre symbols; one mind, re-check it): "the stable odd places of ℚ(√3,√5) below 200 are
  11, 59, 71, 131, 179, 191; 7, 19, 23, 31, 43, 47 have residue degree 2, so they are not stable; 3 has residue field 𝔽₉; the wall is broken
  (15 ≡ 7 mod 8), so no dyadic place is stable and the field is outside the exception. So D-2's only real risk is D-6's archimedean step at
  n = 4."
