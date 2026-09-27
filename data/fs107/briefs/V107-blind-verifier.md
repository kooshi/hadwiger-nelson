*Brief for job **FS107-V**, the blind verifier of FS-107's first finished side. Opus 5.5. Drafted by the planner FS107-P, 2026-09-27; the owner
fills in the instance block below and launches it when R or W hands back a result (it takes the finished side's slot: at most three agents at once).
`data/fs107/briefs/STANDING-RULES.md` is part of it — read it in full, rule 0 first.*

**Instance block (the owner fills in):** the side verified (R or W); the claim ids; the finished side's **final statements, quoted verbatim** from its
record's "Theorems this phase proved"; for W, the member files and the family's formula; the record path, to be opened only at stage 4.

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`.

## Your object

You verify, blind, one side's result on FS-107's question (`data/fs107/claims.md` §1): claim R (stability, `χ_m⁰(ℝ²) ≥ 7`) or claim W (vanishing holes,
`χ(ℝ²) ≤ 6` with no MR). Read `CLAUDE.md` § The aim, § Counter-priors, G21, G82; `LEDGER.md` row 131; `data/fs107/claims.md` in full; the papers it names.
**Derive your own verdict on each quoted statement before you read the finished side's proof.**

## What I'd like from you, in this order

1. **Stage 1.** Quotation check (standing rule 5): the instance block's statements against the claim list. Restate each in your own words. Register
   your expectation, with both outcomes reachable.
2. **Stage 2 — the load-bearing step first** (§ The standard of evidence: order a verification by marginal value). For R: run the five killing tests of
   `claims.md` §3 on the statement as you reconstruct the argument's shape from the statement alone; then derive or refute the statement. For W: write
   your own exact checker (`tools/fs107_v_*.py`, a planted pair beside a faithful stub, never W's tool), check the given members, then derive the
   family's band-properness for every parameter value yourself — the members are controls, the family is a derivation (G21).
3. **Stage 3.** Verdicts: TRUE / FALSE / GAP-at-step / MISSTATED, minds, grade. A member or step that fails one killing test is checked against all of
   them. Audit a TRUE at a FALSE's rate: the flattering result here is the one that would move the answer.
4. **Stage 4, only after stage 3 is committed:** read the finished side's record; record every divergence, of truth and of route.

## Fences (by path; no `git log -p` on any of them) until your stage 3 is committed

- both competitors' records and working directories: `plans/FS107-R-stability.md`, `data/fs107/fs107-r/`, `plans/FS107-W-near-colourings.md`,
  `data/fs107/fs107-w/`, and their tools `tools/fs107_r_*`, `tools/fs107_w_*`;
- both competitors' and the advisors' messages — never message a competitor or an advisor;
- the advisors' records `plans/POROS-2026-09-27-fs107-stability.md`, `data/fs107/fs107-a/`, and any competition-phase advisor record;
- `plans/FS107-close-inventory.md`, `data/fs107/reports/`, and `git log` beyond `git log -1 --format=%h`;
- the session transcripts (everything under `~/.claude/projects/-home-kooshi-source-lean-dir/`, memory included), `chats-bak/`, and every file in the
  shared harness scratchpad you did not create (work in `<scratchpad>/FS107-V/`).

A fence touch is disclosed at once in your record and your report.

## Rules

- **Touch only** `plans/FS107-V-verification.md`, `data/fs107/fs107-v/`, `tools/fs107_v_*.py`. Commit subjects "FS107-V: stage n".
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about.
- The ban (standing rule 3) and Kooshi's ruling beyond it apply: exact checks of given objects only.
- **Budget:** about 300k tokens by the harness's count; hand back with your record saved before 400k.
- Report per standing rule 9 to `data/fs107/reports/FS107-V.md`; your hand-back is content-free: "FS107-V idle; no content in this hand-back; my
  reports go to the owner by SendMessage".

Thank you.
