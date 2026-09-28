*Brief template for job **FS114-NB**, the blind verifier of FS-114's proof side. Opus 5.5. Written by the milestone planner FS114-P; **the owner adds at
launch the list of claim ids FS114-N's report gives verdicts on, with each verdict withheld** (FS-110's and FS-112's practice: a separate instance file,
`data/fs114/briefs/NB114-instance.md`). **Sized for about 300k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/fs114/briefs/STANDING-RULES.md` is part of this brief; read it in
full, rule 0 first.** You verify a proof you have not seen: derive first, read second. Audit at the rate of a result you would want false (G21): a NO
flatters this project's hopes.

## Reading

`CLAUDE.md` § The aim, § Counter-priors, G83, G82, G79, G71, G60, G21, G15, G13, G51; `LEDGER.md` rows 131–136; **`data/fs114/claims.md` in full**;
`plans/FS114-unit-arc-question.md` §G part 3, §PA, stage 5b and §IQ (not stage 5's 5.3, the registered expectations, until your stage 1 is committed); the
proof side's brief `data/fs114/briefs/N114-proof.md` § Reading — you may read that brief and the sources it lists, never the side's record before your
stage 1 is committed.

## The job

1. **Stage 1, blind:** the quotation check; then, for each claim id in your instance file, **your own verdict** — TRUE with your derivation, FALSE with a
   counterexample, GAP at a named step, or MISSTATED with the corrected statement — graded, derived from the statements alone. For any claim that states
   a radius, derive the radius it reads. For a counting claim, run the positive control C114-FIVE-COUNT through it. Commit stage 1 **before** you open the
   side's record.
2. **Stage 2:** read `plans/FS114-N-proof.md` and its tools; list every divergence from your verdicts — of truth, of scope (a hypothesis dropped or added,
   a complexity bound used where the statement has none), of grade — each with both addresses. Say which divergences change a verdict and which are wording.
3. **The local controls first** if among your ids: a step the side calls local that reads beyond its stated radius, or a step that the strip (radius
   `≈ 1.834` about a midline four-colour vertex) or the disk refutes, is the result the verification exists for.

## Rules

- **Touch only** your record `plans/FS114-NB-verification.md`, `data/fs114/fs114-nb/` and `tools/fs114_nb_*.py`. Neutral subjects "FS114-NB: stage n"; push;
  never amend or force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about.
- **The ban** (standing rule 3), with its "would have searched here" log.
- **Fences** until your stage 1 is committed: `plans/FS114-N-proof.md`, `data/fs114/fs114-n/`, `tools/fs114_n_*`. Always: the transcripts (everything under
  `~/.claude/projects/-home-kooshi-source-lean-dir/`), `chats-bak/`, every shared scratchpad file you did not create (work in `scratchpad/fs114-nb/`); the
  construction side's files (`plans/FS114-Y-construction.md`, `data/fs114/fs114-y/`, `tools/fs114_y_*`) and its verifier's; `plans/FS114-CV-verification.md`;
  the advisor's record if one runs; BASE-V's record until it has reported; `plans/FS114-close-inventory.md`, `data/fs114/reports/`; every brief but this
  one, `N114-proof.md`, your instance file and `STANDING-RULES.md`; `git log` beyond the start-up snapshot and `git log -p`. Log any touch.
- **Contact:** only `"main"`; never the side or the advisor. Report per standing rule 9 to `data/fs114/reports/FS114-NB.md` and to `"main"`. Final turn's
  text: "FS114-NB idle; report sent to the owner by SendMessage".

Thank you.
