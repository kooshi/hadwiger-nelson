*Brief for crunch jobs **J37, J38, J39**: three advisor sessions (Poros), one per target, each assembling the "wanted poster" of a
counterexample at one of the conjecture's live walls. At Kooshi's request, 2026-09-25: *"Queue a Poros session for each, to launch after the
current milestones close out."* Opus 5.5. Written by the product owner. The launch message tells you which job you are; this file is
shared by all three.*

Hello Poros. I'm the product owner of the Hadwiger–Nelson project in `/home/kooshi/source/lean-dir`, a Lean 4 workspace on the chromatic
number of the plane, run to the "de Bruijn" standard. Kooshi, the human whose project this is, has asked me to coordinate rather than do the
mathematics. Your findings go to him through me, and the decisions are his.

## Who you are, and what to read first

1. **Your identity:** `~/source/poros/CLAUDE.md`. Your skills are files, not Skill-tool skills; read them directly:
   `~/source/poros/.claude/skills/poros/SKILL.md`, `.../poros-anomaly-hunt/SKILL.md`, `.../poros-reframing/SKILL.md`.
2. **The house standard, from disk:** `CLAUDE.md` (the Frontier, and the Grokkings — G48, G64, G74 and G76 above all), `LEDGER.md` (rows
   75 and 84–110), `WORKFLOW.md`, `DEBRUIJN.md`. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in
   full.**
3. **The session that ran before you:** `plans/POROS-2026-09-25-infinitely-many-primes.md` (J36), on the finding that set this off.
   Build on it; do not redo it.

## Why this session exists

When one of this project's methods hits a wall, it often leaves behind a theorem that says what any counterexample would have to look like.
One example: tonight two independent derivations proved that a four-colouring of ℚ(√47)'s plane, if one exists, has a translation-invariant
measure whose spectrum reads infinitely many primes. That result is T-C(A), in `plans/FS86-R88-D-derivation.md` §3.3 and
`plans/FS86-R88-V-verification.md` §2.2. Each such result came from a different instrument. **Nobody has put them side by side.** Put
together, they describe one suspect. The conjunction is either:
- a single theorem, a local–global statement that closes the question; or
- a precisely named gap, a class of colourings that evades every constraint, which becomes a construction problem or the next derivation.

## Your target (the launch message names one)

- **J37 — four colours over ℚ(√47).** The conjecture predicts exactly five; four is proven (`4 ≤ χ ≤ 5`). The counterexample is a
  four-colouring of the plane over ℚ(√47). Start from:
  - `CLAUDE.md` items 10 and 14;
  - FS-84: `plans/FS84-five-colours-47.md` and its stub;
  - the S1 derivation `plans/FS84-S1-derivation.md` and its blind check `plans/FS84-S1V-verification.md`;
  - rows 75, 84, 92 and 96;
  - `CLOSED-QUESTIONS.md` §1.7;
  - T-C(A).
- **J38 — four-colour rigidity over ℚ(√59)** (and ℚ(√83), ℚ(√131)). The counterexample is a four-colouring that is not a pullback from the
  dyadic place, which would show that `(0, 4)` is not forced. Start from:
  - rows 88–94 and 96, and G76;
  - the milestone's plan `plans/FS86-row88-rigidity.md` (its §R-close first), its derivation and verification records, and its prior-art
    gate `plans/FS86-row88-PA-close.md`;
  - the partial results toward transience (no finite defects; bounded defect chains are thin; a defect set of density zero makes the
    colouring transient).
- **J39 — five colours over ℚ(√167).** The conjecture predicts at least six against a proven four; this is its widest gap. The
  counterexample is a five-colouring of the plane over ℚ(√167) that is local at no prime. Start from:
  - `CLAUDE.md` items 12, 17 and 22, and FS-59's stub `plans/STUB-four-colours-167.md` (§0 first);
  - row 75 (five is refused at 23 at every level of the tower);
  - row 96 (no character five-colouring);
  - M3's windows result over ℚ(√167): `plans/M3-exotic-colourings.md` §R-close, `plans/M3-S1D-windows-five.md` §3.2–§3.4 (mixing selection;
    at most nine places);
  - FS-64's adelic window colouring, `plans/STUB-adelic-window-colouring.md`;
  - whether a T-C(A)-type result reaches five colours here (J36 may have answered this).

Read every result at exact scope and grade, from its record. The index `plans/CRUNCH-2026-09-25-INDEX.md` points to the day's work. A
summary, including this brief, is never a source.

## What I'd like from you

1. **Write your own expectation first,** at the top of your record, before assembling anything: what you expect the poster to say, and
   whether you expect one theorem or a gap.
2. **Assemble the poster.** Give one row per constraint on the counterexample, with these columns: the constraint, verbatim; its scope; its
   grade ([kernel], [cert], [hand, two derivations], [hand, one mind], [measured], [reading]); its address; the instrument it came from.
   Keep **measured nulls apart from theorems**: a search that found nothing constrains nothing (G21).
3. **Compose them.** Answer these questions:
   - Do the constraints add up to one statement? Write it verbatim, graded as what it rests on.
   - Or do they leave a gap? Name the class of colourings that evades all of them, as precisely as the records allow, and say whether that
     class is known to be non-empty for some related field or graph (a control).
   - Where two constraints overlap, which one is redundant?
   - Where do two constraints almost meet, and what small lemma would join them?
4. **Name it in its discipline's words.** Is the poster, or its gap, a known object in some literature — a class of colourings, subshifts,
   measures or tilings? Give the search queries a prior-art job should run. Do not run the literature sweep yourself.
5. **The killing test:** the cheapest check that would show the poster is weaker than it reads (a scope slip, a shared input, a grade
   inflated on the way).
6. **Flip the poster: find the example invariant** (Kooshi, 2026-09-25: *"walls often show up as 'the (impossible?) counter-example
   invariant' and we have had a successful breakthrough when looking for the 'example invariant'."*). The poster lists invariants of a
   counterexample that may not exist — theorems about a class that may be empty. Every breakthrough here came instead from an invariant
   that **every actual solution** carries: the slope of every three-colouring (G71, G72, G74), the eigen-equation of every four-colouring
   of de Grey's lattice (G75), locality at the tight place (G76), band rigidity (row 95). For your target, name the property that every
   colouring we can prove exists carries and that, held by **all** colourings, would empty the poster's class; say which constraint on
   the poster is its shadow, whether the milestone's structural question (§IQ, G72) already names it, and whether looking for it beats
   closing the poster's gap directly.
7. **Recommend,** ranked, with a default ("if Kooshi does nothing, X happens"): a derivation (its statement verbatim, ready for a brief), a
   construction problem, a reading debt, or a stub. Give your confidence and the one fact that would change it.

## Mechanics

- **Your record:** `plans/POROS-<launch date>-wanted-poster-<47 | 59 | 167>.md`. If another poster's record exists when you finish, add a
  short section on what the posters share.
- Commit by explicit path (`git add` it, then `git commit <path>`); never amend. End the commit message with your harness's attribution
  lines. Push after each commit; never force-push. Save your record in stages.
- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation). Reason:
  staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a saved section
  and tell me what is left.
- **No finite-witness search** while the ban runs (to 2026-10-01): exact checks of seconds are fine. Keep a "would have searched here" log.
- **Do not edit** anything but your record.
- **All novel knowledge is a success** (Kooshi). A poster that closes into a theorem, a poster with a named gap, and a poster that turns out
  to be in print are all results. Lean toward none of them.
- **Budget:** about 250k by the harness's count; hand back by 350k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/<J37 | J38 | J39>.md`, committed, and by
  SendMessage `to: "main"`. Keep your turn's final text content-free: "<id> idle; report sent to the owner by SendMessage".

Thank you.
