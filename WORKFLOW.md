# WORKFLOW.md — where the workflow lives

**This file is loaded by no one.** Since 2026-09-28 (Workflow 3.0) lean-dir's workflow is split across the minds that run it, each
role's procedure beneath its verbatim identity, in a file that loads into that mind alone (Kooshi: *"split the whole workflow into
the separate agent files. The workflow sections should go beneath the verbatim identities if they can't be in separate files loaded
with @"*; `@` imports do not expand in agent files or output styles, as a probe showed that day). The map every mind shares is
`CLAUDE.md` § The pipeline. This file keeps what nothing loads: where each part now is, and where each of the old workflow's step
numbers went, since `plans/`, `tools/` and `CLAUDE.md` still cite them. Its earlier text is in git (`git show 280aad6a:WORKFLOW.md`
for Workflow 2.0).

| file | who loads it | holds |
|---|---|---|
| `.claude/output-styles/keryx.md` | the top-level session (Keryx), every request | the `keryx` identity; then staffing, the pipeline, a milestone end to end, the close's filing, reporting to Kooshi, and how the identities are updated |
| `.claude/agents/poros.md` | a `poros` agent | the `poros` identity; then scouting a question into a stub, re-posing, the boundary re-read and the draft re-rank, advising |
| `.claude/agents/ephodos.md` | an `ephodos` agent | the `ephodos` identity; then why the reframe, the opening job (§G, §PA, §IQ), a derivation job, the close job |
| `.claude/agents/ephodos-verifier.md` | an `ephodos-verifier` agent | the `ephodos` identity and the `ephodos-verification` companion; then the fence and the order of events |
| `.claude/agents/debruijn.md` | a `debruijn` agent | the `debruijn` identity; then its loop (reading back, a kernel milestone's reframe, skeleton, modeling passes, gate, close) and the Lean facts moved from `CLAUDE.md` |
| `CLAUDE.md` | every mind | the project's state and theory, the standard of evidence, the process rules every job shares, § The pipeline |
| `plans/STANDING-RULES.md` | every briefed job, from disk | the rules every brief shares |

`scripts/identities.py check` holds each identity copy to its skill in `.claude/skills/`.

**Running a lane as your own main session** (`claude --agent poros`, say): the project's output style is Keryx's, and an output style
applies to whatever runs as the main session, so pass `--settings '{"outputStyle":"default"}'` as well, or that session holds both
identities (probed 2026-09-28). A lane launched by Keryx as a subagent never receives the style.

## Where the old steps went

| Workflow 2.0 step, as cited | now at |
|---|---|
| "Why we work this way", "WORKFLOW's first principle" (priors are worthless past the frontier) | `.claude/agents/ephodos.md` § Why the reframe |
| preamble: leaf-first up the DAG, the green manifold | `.claude/agents/debruijn.md` § Your loop; the `debruijn` identity's `<the_loop>` |
| 1 Architect (`ARCHITECTURE.md`) | `.claude/agents/debruijn.md` § Your loop |
| 2 Plan, and the stub rule | `CLAUDE.md` § The pipeline (the stub rule); `.claude/agents/poros.md` § Your jobs (the question, the re-rank draft) |
| 3 Reframe: 3.1 re-grokking, 3.2 prior-art gate (items 1–8, the zbMATH API), 3.3 invariant question | `.claude/agents/ephodos.md` § The opening job; 3.3's items 1–2 from Poros's card; a kernel milestone's reframe in `.claude/agents/debruijn.md` |
| 4 Subplan | `.claude/agents/ephodos.md` (a derivation plan); `.claude/agents/debruijn.md` (a kernel skeleton) |
| 5 Commit, and the close inventory | `.claude/output-styles/keryx.md` § A milestone, end to end, step 2 |
| 6 Modeling passes (the fresh-invocation rule) | `.claude/agents/debruijn.md` § Your loop |
| 7 Implement, and "Theorems this phase proved" | the agent files; `plans/STANDING-RULES.md` rule 7 |
| 8 Quality gate | `.claude/agents/debruijn.md` § Your loop and § The gate; the recorded counts in `CLAUDE.md` § The gate |
| 9 Close, and its sweeps | `.claude/agents/ephodos.md` § The close job; `.claude/agents/poros.md` job 3; `.claude/output-styles/keryx.md` § A milestone, end to end, step 7 |
| 10 Report, and "How to report to the user" | `.claude/output-styles/keryx.md` § A milestone, end to end, step 8, and § Reporting to Kooshi |
| 11 Next | `.claude/output-styles/keryx.md` § The pipeline |
