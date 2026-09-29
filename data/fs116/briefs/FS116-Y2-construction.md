# Brief FS116-Y2 — Ephodos: FS-116's construction side, round 2

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS116-Y2
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job's procedure, opening with `ephodos-recognition` invoked fresh with the Skill tool
  role: a construction job on FS-116's frozen claim list, round 2: fragments given by formula, checked exactly, or a derived obstruction
  launch: now, beside a successor on FS116-N1's brief (the proof side, on SAT-STRIP and SAT-QFREE; not blind to you), FS116-V2 (a blind verifier on other claims) and FS-121's jobs
  mission: § Why this job
  statements: § Your claims
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — a construction job; but write nothing about your work where FS116-V2 or FS121-V2 could read it before their verdicts (standing rule 8): only your record, your data directory, your tools and your report
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/fs116/reports/FS116-Y2.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` is part of it too: you build exact checkers (its § Make the gate fail, and watch it fail)
  record: `plans/FS116-Y2-construction.md`
  touches: `plans/FS116-Y2-construction.md`, `data/fs116/y2/`, `tools/fs116_y2_*.py`, `data/fs116/reports/FS116-Y2.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are Ephodos, on the construction side of FS-116's first round.

## Why this job

Round 1's construction side (FS116-Y1, record `plans/FS116-Y1-construction.md`) built a strip fragment saturated on a small disc and proved
that the capped strip's family cannot be saturated at radius 1 (FS116-Y1-STRIPCEIL); it built no fragment beyond `φ²/√2` about a vertex whose
ring carries a (Q) arc. Round 1's proof side (FS116-N1, record `plans/FS116-N1-proof.md`) found that RING-Q fails at small radius: the disk's
corner `A₀` has a change point with only two colours whose ±60° points lie inside (Q) arcs (FS116-N1-QDISK, exact), and that fragment holds
`B̄(A₀, R)` for every `R < 1.5985`. So the plan's P3 route applies: the construction side builds at that ring first
(`plans/FS116-local-exclusion.md` § 4.5). A fragment by formula holding the disk-corner configuration beyond radius 2 makes RING-Q FALSE
outright and meets G83's killing test; a derived obstruction at a named radius is RING-Q's missing step. The ban on finite-witness search
runs to 2026-10-01: colourings given by formula and exact checks of them are in; nothing enumerates maps, colourings, tile graphs or ring types.

## Your claims

First Y-QRING, aimed at the disk-corner configuration (a four-colour vertex whose ring has a two-colour change point with its ±60° points
inside (Q) arcs), extended beyond radius 2 about it, or obstructed at a named radius:

> - **Y-QRING** *(this list; `.claude/skills/grokkings/SKILL.md` G83's killing test)*: a valid fragment on a closed disc of radius above `φ²/√2` about a vertex
>   of at least four colours whose ring carries a (Q) arc — or a derived obstruction at a named radius.
> — source: data/fs116/claims.md § 7. Y — construction (each checked exactly on an object given by formula)

Then, if the budget holds, Y-SAT in the direction round 1 found open — a four-straight-edge four-colour vertex whose midline does not run
straight through the unit disc (FS121-D1-EROSION at `θ = π/2`, as round 1 read it; FS116-Y1-STRIPCEIL rules out the strip itself):

> - **Y-SAT** *(this list)*: a valid fragment on `B̄(p, R)`, saturated on `B̄(p, R − 1)`, about a vertex `p` of at least four colours, for the largest `R`
>   reached (first: the capped strip made saturated at its midline, which decides SAT-STRIP from the other side) — or a derived obstruction at a named radius.
> — source: data/fs116/claims.md § 7. Y — construction (each checked exactly on an object given by formula)

Round 1 found Y-SAT's parenthetical ("the capped strip made saturated at its midline, which decides SAT-STRIP from the other side") cannot
hold as written; read the target as "a geometry differing from the strip inside the unit disc, saturated on `B̄(p, 1)`". The list's § 9 names
the controls every checker must accept before any refusal is believed.

## What you read

Round 1's records in full (`plans/FS116-Y1-construction.md`, its tools `tools/fs116_y1_*.py` — read-only to you, standing rule 7 — and
`plans/FS116-N1-proof.md` § 3, with its tool `tools/fs116_n1_ring.py` and FS116-N1-QDISK); the plan (`plans/FS116-local-exclusion.md`
§ 4.3–4.6); the frozen list; FS-112's disk (`plans/FS112-derivation.md`, FS112-DISC) and FS-114's construction records
(`plans/FS114-Y*-construction.md`); and the grokkings in your context.

## Done means

1. **Your record**, `plans/FS116-Y2-construction.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all
   plans/FS116-Y2-construction.md` from the repository root before each stage's commit: the readback, the recognition stage, and for each
   claim either an object given by formula with an exact checker (`tools/fs116_y2_*.py`) that accepts the controls first and fires on a
   planted fault, or a derived obstruction at a named radius, or the families tried with their free parameters against the
   configuration's (the plan's stop rule).
2. **The report** in the standing rules' form. Your last words are exactly "FS116-Y2 idle; report sent to the coordinator": the report
   goes by message, and the hand-back carries nothing else.

## What is yours to decide

Your families, your checkers, and whether Y-SAT fits after Y-QRING. A candidate that fails the exact check measures the candidate, not the question.
If a claim is wrong as posed, say so.

## Stages (save and commit each; standing rule 2)

1. The readback, then recognition on each claim.
2. Y-QRING at the disk-corner configuration.
3. Y-SAT off the strip, if the budget holds.
4. The report.

Thank you.
