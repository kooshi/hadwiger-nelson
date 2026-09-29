# Brief FS116-Y1 — Ephodos: FS-116's construction side, round 1

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS116-Y1
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job's procedure, opening with `ephodos-recognition` invoked fresh with the Skill tool
  role: a construction job on FS-116's frozen claim list: fragments given by formula, checked exactly, or a derived obstruction
  launch: now, beside FS116-N1 (the proof side, same milestone, not blind to you) and FS116-V1 (a blind verifier on other claims)
  mission: § Why this job
  statements: § Your claims
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — a construction job; but write nothing about your work where FS116-V1 or FS121-DB1 could read it before their verdicts (standing rule 8): only your record, your data directory, your tools and your report
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/fs116/reports/FS116-Y1.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` is part of it too: you build exact checkers (its § Make the gate fail, and watch it fail)
  record: `plans/FS116-Y1-construction.md`
  touches: `plans/FS116-Y1-construction.md`, `data/fs116/y1/`, `tools/fs116_y1_*.py`, `data/fs116/reports/FS116-Y1.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are Ephodos, on the construction side of FS-116's first round.

## Why this job

FS-116's question has two answers, and this side works the one a proof would miss: a fragment. Your first claim scores the plan's P1
(does the capped strip's midline configuration survive saturation?) from the side opposite FS116-N1's SAT-STRIP, and your second is the
killing test that the working theory's G83 names (a four-colour vertex whose ring carries a (Q) arc, held beyond `φ²/√2`). The ban on
finite-witness search runs to 2026-10-01: colourings given by formula and exact checks of them are in; nothing enumerates maps,
colourings, tile graphs or ring types (the frozen list's § 9).

## Your claims

> - **Y-SAT** *(this list)*: a valid fragment on `B̄(p, R)`, saturated on `B̄(p, R − 1)`, about a vertex `p` of at least four colours, for the largest `R`
>   reached (first: the capped strip made saturated at its midline, which decides SAT-STRIP from the other side) — or a derived obstruction at a named radius.
> — source: data/fs116/claims.md § 7. Y — construction (each checked exactly on an object given by formula)

> - **Y-QRING** *(this list; `.claude/skills/grokkings/SKILL.md` G83's killing test)*: a valid fragment on a closed disc of radius above `φ²/√2` about a vertex
>   of at least four colours whose ring carries a (Q) arc — or a derived obstruction at a named radius.
> — source: data/fs116/claims.md § 7. Y — construction (each checked exactly on an object given by formula)

The list's § 9 names the controls every checker must accept before any refusal is believed: the capped strip, the disk, FS114-Y2-BOWTIE,
R7 at `k = 7` and SQ9 at `k = 9`.

## What you read

The plan (`plans/FS116-local-exclusion.md` § 4.3–4.6), the frozen list, the stub, the construction records of FS-114
(`plans/FS114-Y*-construction.md`, the strip's `data/fs114/fs114-y6/`) and FS-111's saturation entries (`plans/FS111-derivation.md`:
FS111-VM2-STRIP-MID, M-PINCH, W-SQ9), and the grokkings in your context. Other jobs' tools are read-only to you (standing rule 7).

## Done means

1. **Your record**, `plans/FS116-Y1-construction.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all
   plans/FS116-Y1-construction.md` from the repository root before each stage's commit: the readback, the recognition stage, and for each
   claim either an object given by formula with an exact checker (`tools/fs116_y1_*.py`) that accepts the controls first and fires on a
   planted fault, or a derived obstruction at a named radius, or the families tried with their free parameters against the
   configuration's (the plan's stop rule).
2. **The report** in the standing rules' form. Your last words are exactly "FS116-Y1 idle; report sent to the coordinator": the report
   goes by message, and the hand-back carries nothing else.

## What is yours to decide

Your families, your checkers, your order after Y-SAT. A candidate that fails the exact check measures the candidate, not the question.
If a claim is wrong as posed, say so.

## Stages (save and commit each; standing rule 2)

1. The readback, then recognition on each claim.
2. Y-SAT: the strip saturated at its midline, or why not.
3. Y-QRING.
4. The report.

Thank you.
