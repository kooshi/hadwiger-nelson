*Brief for job **FS111-V0**, FS-111 (the cone scale), phase 0: a blind second mind on card 1. Opus 5.5. Drafted by the milestone planner FS111-P
for the owner to launch. **Sized for about 200k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/fs111/briefs/STANDING-RULES.md` is part of this brief; read it in
full, rule 0 first.** Kooshi (2026-09-26, verbatim, `CLAUDE.md` § The aim): *"My goal is to fully solve, and then verify in Lean, HN. Then we publish."*

**No children.** Do not use the Agent tool, a fork, a workflow or any other way of starting another agent. Only the top-level session launches agents,
because staffing is Kooshi's budget decision and the owner can only review work it knows about. If the work outgrows your context, stop at a saved
stage and say what is left.

## Why this job exists

The front page says FS-111's cone scale, "with FS-114's NO", is "the route to `χ_m⁰(ℝ²) = 7`" — a composition graded one mind (FS107-MEET). The night
advisor asked (`plans/POROS-2026-09-27-night-aim.md` §3, card 1, verbatim): *"Does FS-114's NO at every complexity bound plus FS-111's cone-scale bound
give seven, or is a third statement needed — R's (A) at unbounded complexity, a hole bound uniform in K, or a NO for the boundaries a limit produces?"*
FS-111's planner answered it by derivation, one mind. **A correction to the front page will rest on the answer; it needs a second mind that did not
read the first one's derivation.**

## Reading

From disk, in this order: `data/fs111/briefs/STANDING-RULES.md`; `CLAUDE.md` § The aim, § Counter-priors, G82, G21; `LEDGER.md` rows 130–135;
`plans/FS107-derivation.md` in full (FS107-RR, FS107-R-CP, W-EQ-K, W-TAN, MEET); `plans/FS107-W-near-colourings.md` §2.1–§2.2 (the generator image
and W-EQ-K's proof); `plans/FS107-R-stability.md` §3.2 and §3.4; `plans/STUB-global-step.md` (FS-114's NO); `data/fs106/claims.md` §0–§1 (D-NF,
D-SLACK, I-D1); **`data/fs111/claims.md` in full — work its §2 and the ARG claims of §3 (C-SEVEN-M, C-SIX-M, C-REG-EQ) and C-HULL, C-FILL; quote them,
never paraphrase them.**

**Fences** (standing rule 13). Do not open, list or grep, until your stage 2 (your verdicts) is committed: **`plans/FS111-cone-scale.md`** (the planner's
record, which holds the derivations you are checking), `data/fs111/fs111-p/`, `tools/fs111_p_*`, `plans/POROS-2026-09-27-night-aim.md` beyond card 1's
text quoted above, and `data/fs111/reports/`. Always fenced: the session transcripts (everything under `~/.claude/projects/-home-kooshi-source-lean-dir/`,
memory included), `chats-bak/` in the repository, every file in the shared harness scratchpad you did not create (work in your own subdirectory
`fs111-v0/` there), `plans/FS111-close-inventory.md`, every other brief in `data/fs111/briefs/`, and `git log -p` on fenced paths. An accidental open is a
**fence touch**: log it and report it; a disclosed touch costs nothing.

## Stages (save and commit each, "Stage n — SAVED"; standing rule 2)

1. **Quotation check** of this brief against its sources (standing rule 5). Then state, in your own words beside the quotations, what the map NO
   (Q-NO), FS107-RR's (A) and (B), W-EQ-K and H-EQ each quantify over — object, complexity, boundary class.
2. **Your verdicts, blind.** For each claim of `data/fs111/claims.md` §2 (C1-UNIF, C1-PW, C1-GAP, C1-FALS, C1-ROUTES), the ARG claims C-SEVEN-M, C-SIX-M,
   C-REG-EQ, and C-HULL, C-FILL: TRUE (your derivation), FALSE (a counterexample), GAP at a named step, or MISSTATED (the corrected statement, graded).
   Work the card itself too: is there a derivation that the map NO at every complexity bound plus a cone-scale bound gives `lim µ₆(ε) < 1`? The card's
   falsifier, verbatim: *"a derivation that every family with holes → 0 and cone scale ≥ s₀ has a subsequence of bounded complexity whose limit is a
   segment-and-arc map"*. Audit a TRUE at a FALSE's rate (standing rule 4); C1-UNIF's equality form has a rasterisation step — check it.
3. **Reconcile.** Only now read `plans/FS111-cone-scale.md` stages 2, 3b (its two corrections) and 5; list every divergence of statement or of truth, and
   settle each by derivation, or name it open.

## Deliverables

Record `plans/FS111-V0-verification.md` (with "Theorems this phase proved" and the "would have searched here" log); working files in
`data/fs111/fs111-v0/`; any exact check in `tools/fs111_v0_*.py` with a planted fault that fires for its own reason. Report per standing rule 9 to
`data/fs111/reports/FS111-V0.md` and to "main". Commit subjects "FS111-V0: stage n". Your final text: "FS111-V0 idle; report sent to the owner by
SendMessage".

Thank you.
