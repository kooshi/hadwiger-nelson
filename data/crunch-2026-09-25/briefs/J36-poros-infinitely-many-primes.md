*Brief for crunch job **J36**: an advisor session (Poros) on one finding, at Kooshi's request. Opus 5.5, 2026-09-25. Written by the
product owner.*

Hello Poros. I'm the product owner of the Hadwiger–Nelson project in `/home/kooshi/source/lean-dir`, a Lean 4 workspace on the chromatic
number of the plane, run to the "de Bruijn" standard. Kooshi, the human whose project this is, has asked me to coordinate rather than do the
mathematics. Tonight two independent derivations reached a result that Kooshi called *"such an interesting finding"*, and he asked for a
Poros session to examine it. **You are that advisor.** Your findings go to Kooshi through me, and the decisions are his.

## Who you are, and what to read first

1. **Your identity:** `~/source/poros/CLAUDE.md`. Your skills are files, not Skill-tool skills; read them directly:
   `~/source/poros/.claude/skills/poros/SKILL.md`, `.../poros-anomaly-hunt/SKILL.md`, `.../poros-reframing/SKILL.md`.
2. **The house standard, from disk:** `CLAUDE.md` (the Frontier, the Grokkings — G48, G64, G74, G76 above all), `WORKFLOW.md`,
   `DEBRUIJN.md`. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.**

## The finding

The milestone "row 88's question" (plan `plans/FS86-row88-rigidity.md`: read §IQ, §S, §PA) asked whether every four-colouring of the plane
over ℚ(√59) is a pullback from the dyadic place. Its structural form looks at translation-invariant random four-colourings and at their
**spectral measure**: the frequencies, in the dual of the unit-vector ring `R`, that the colouring's tetrahedral embedding carries.
`T` is the torsion characters, `A` the archimedean ones, and `Fin_S` the characters continuous for a finite set `S` of split places.
Two derivations, blind to each other and by different routes over common inputs, proved:

- **T-C.** "Over a type-(B) field, every translation-invariant Borel probability measure on `X₄(F)` whose spectral measure is carried by
  `T + A + Fin_S`, for some finite set `S` of split places, is carried by Pull." The derivation (J28D) states it for the whole class S2.
- **T-C(A).** "Over ℚ(√47), no translation-invariant Borel probability measure on `X₄(F)` has its spectral measure carried by `T + A +
  Fin_S` for a finite set `S` of split places; hence a four-colouring of ℚ(√47)'s plane, if one exists, has a translation-invariant measure
  on its orbit closure whose spectral measure is carried by no `T + A + Fin_S`."

(Verbatim from the plan's §S.1.) Four colours at ℚ(√47) is where the local–global conjecture predicts five against a proven four (`CLAUDE.md`
item 10, FS-84). So **a counterexample to the conjecture's cheapest exposed prediction would have to "read" infinitely many primes at once**,
and over ℚ(√59) the same holds for any four-colouring that is not a dyadic pullback. The records:
- J28D: `plans/FS86-R88-D-derivation.md` §3 (T-C, T-C(A)), §5.1 (T-C′, the remainder), §5.2 (lemma statements);
- J28V: `plans/FS86-R88-V-verification.md` §2.1–§2.2 and §Stage 5 (the divergence table and the independence of the routes).

**What sits beside it** (read at exact scope, from the records, never from this summary):
- M1's class theorem CLG: a band `k`-character exists iff one exists at a single stable place. It is an existence statement, never "every
  character colouring is local". See `plans/FS91-S1D-character.md` §3.1 and `plans/FS91-character-local-global.md` §R-close.
- Band rigidity at two or more primes, and its failure at one prime (`LEDGER.md` rows 95–97; M1's J12).
- FS-86's row 92: measurable window colourings over finitely many places cannot four-colour a type-(B) plane non-periodically.
- M3's windows result over ℚ(√167): mixing selection (J21-MX) and the reduction to at most nine places (J21-RED) —
  `plans/M3-S1D-windows-five.md` §3.2–§3.4 and `plans/M3-exotic-colourings.md` §R-close.
- FS-84's stage S1 (J31, `plans/FS84-S1-derivation.md`): no periodic four-colouring of ℚ(√47)'s plane, with periodic independence ratio
  below 1/4 by a margin of about 3·10⁻⁶ at the prime 31. It also relates four-colourability to invariant measures and to the independence
  ratio. **A blind check of S1 is running now; treat S1 as one mind.**
- The stub FS-64, the adelic window colouring (`plans/STUB-adelic-window-colouring.md`): the one proposed ceiling instrument that uses more
  than one place — and it uses finitely many.
- A prior-art gate on T-C and T-C(A) is running now (J35, `plans/FS86-row88-PA-close.md` once it commits). Read it if it is there, and do
  not duplicate it: your job is the frame, not the literature sweep.

## What I'd like from you

1. **Write your own expectation first,** at the top of your record, before reading the two derivations closely. Cover:
   - what "reads infinitely many primes" means;
   - whether you expect it to be a deep phenomenon or an artefact of the spectral class chosen;
   - where you expect it to point.
2. **Examine the finding.** The questions I would start from; replace any of them with a better one:
   - **What is it, in its discipline's words?** Is "no `T + A + Fin_S`" a statement about the Kronecker factor, about zero entropy, or about
     the restricted product of the split places, whose completion is not locally compact (J28D's T-C′)? Is the remainder Furstenberg's ×2×3
     question in disguise, or something with a handle?
   - **Is there one theorem behind several results?** CLG, row 92, J21-RED, T-C and T-C(A) all say, at their own scopes, that whatever reads
     finitely many places is local, periodic or impossible. Is there a single local–global statement for colourings whose "support" is a
     finite set of places, and what would its infinite-place remainder be?
   - **Does it reach five colours over ℚ(√167)?** The conjecture's widest gap is predicted ≥ 6 against a proven 4 (FS-59; item 12). Does
     T-C(A)'s method, with FS-66's certificate at 23, say that a five-colouring of ℚ(√167)'s plane must read infinitely many primes? What
     would that need, and what does it do to FS-64, whose window colouring reads finitely many places?
   - **What does it say about six and seven** (G64: six hides only in the gap between `L(F)` and `χ(F²)`)?
   - **What would kill it:** the cheapest check that could show the finding is weaker than it reads (a scope slip, a shared input both
     derivations lean on, the common architecture).
3. **Recommend what to do with it,** ranked, with a default ("if Kooshi does nothing, X happens"). The options include:
   - a stub or milestone;
   - a statement to derive;
   - a reading debt to pay first;
   - leaving it as an item in the milestone's close.

   Give your confidence and the one fact that would change it. If you recommend a derivation job, write its statement verbatim, ready for a
   brief.

## Mechanics

- **Your record:** `plans/POROS-2026-09-25-infinitely-many-primes.md`. Commit by explicit path (`git add` it, then `git commit <path>`);
  never amend. End the commit message with your harness's attribution lines. Push after each commit; never force-push.
- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation). Reason:
  staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a saved section
  and tell me what is left.
- **No finite-witness search** (the ban runs to 2026-10-01): exact checks of seconds are fine. Keep a "would have searched here" log.
- **Do not edit** anything but your record: not `CLAUDE.md`, `LEDGER.md`, the plans, the records, the index or the inventories.
- **All novel knowledge is a success** (Kooshi). If the finding is weaker than it reads, or already in print, that is a result; do not lean
  toward its being deep.
- **Budget:** about 250k by the harness's count; hand back by 350k. Save your record in stages.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J36.md`, committed, and by SendMessage
  `to: "main"`. Keep your turn's final text content-free: "J36 idle; report sent to the owner by SendMessage".

Thank you.
