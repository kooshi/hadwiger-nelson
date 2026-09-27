*Brief template for job **FS112-NB**, the blind verifier of FS-112's proof side. Opus 5.5. Written by the milestone planner FS112-P; **the owner adds
at launch the list of claim ids FS112-N's report gives verdicts on, with each verdict withheld** (FS-110's practice: a separate instance file,
`data/fs112/briefs/NB112-instance.md`). **Sized for about 300k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/fs112/briefs/STANDING-RULES.md` is part of this brief; read it in
full, rule 0 first.** You verify a proof you have not seen: derive first, read second.

## Reading

`CLAUDE.md` § The aim, § Counter-priors, G82, G79, G21, G51; `LEDGER.md` rows 131–134; **`data/fs112/claims.md` in full**; `plans/FS112-unit-arc-half.md`
§G part 3, §PA, §IQ (not §5.3, the registered expectations, until your stage 1 is committed); `plans/FS112-PA-reading.md`; FS-110's close as the proof side's brief lists it (`data/fs112/briefs/N112-proof.md` § Reading — you may
read that brief, not the side's record); the held papers it names.

## The job

1. **Stage 1, blind:** the quotation check; then, for each claim id in your instance file, **your own verdict** — TRUE with your derivation, FALSE with a
   counterexample, GAP at a named step, or MISSTATED with the corrected statement — graded, derived from the statements alone. Commit stage 1 **before**
   you open the side's record.
2. **Stage 2:** read `plans/FS112-N-proof.md` and its tools; list every divergence from your verdicts — of truth, of scope (a hypothesis dropped or added),
   of grade — each with both addresses. Say which divergences change a verdict and which are wording.
3. The chain walk first if it is among your ids: a step the side calls surviving and you find failing (or the reverse) is the result the contest exists
   for.

## Rules

- **Touch only** your record `plans/FS112-NB-verification.md`, `data/fs112/fs112-nb/` and `tools/fs112_nb_*.py`. Neutral subjects "FS112-NB: stage n"; push;
  never amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about.
- **The ban** (standing rule 3), with its "would have searched here" log.
- **Fences** until your stage 1 is committed: `plans/FS112-N-proof.md`, `data/fs112/fs112-n/`, `tools/fs112_n_*`. Always: the transcripts, `chats-bak/`,
  every shared scratchpad file you did not create (work in `scratchpad/fs112-nb/`); the construction side's files (`plans/FS112-Y-construction.md`,
  `data/fs112/fs112-y/`, `tools/fs112_y_*`) and its verifier's; both advisors' records; `plans/FS112-close-inventory.md`, `data/fs112/reports/`; every
  brief but this one, `N112-proof.md` and `STANDING-RULES.md`; `git log` beyond the start-up snapshot and `git log -p`. Log any touch.
- **Contact:** only `"main"`; never the side or the advisor. Report per standing rule 9 to `data/fs112/reports/FS112-NB.md` and to `"main"`. Final turn's
  text: "FS112-NB idle; report sent to the owner by SendMessage".

Thank you.
