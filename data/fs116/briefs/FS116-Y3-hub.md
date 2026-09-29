# Brief FS116-Y3 — Ephodos: FS-116's construction side, round 3

*Written 2026-09-29 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS116-Y3
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job's procedure, opening with `ephodos-recognition` invoked fresh with the Skill tool
  role: a construction job on FS-116's frozen claim list, round 3: fragments given by formula, checked exactly, or a derived obstruction
  launch: now, beside FS116-S1 (SAT-STRIP; not blind to you), FS116-V3 (a blind verifier on other claims) and FS-121's jobs
  mission: § Why this job
  statements: § Your claims
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — a construction job; but write nothing about your work where FS116-V3, FS121-V3 or FS121-V4 could read it before their verdicts (standing rule 8): only your record, your data directory, your tools and your report
  channel: message the coordinator ("main") by SendMessage with any question mid-flight; the report goes to `data/fs116/reports/FS116-Y3.md` and to "main" by message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` is part of it too: you build exact checkers (its § Make the gate fail, and watch it fail)
  record: `plans/FS116-Y3-construction.md`
  touches: `plans/FS116-Y3-construction.md`, `data/fs116/y3/`, `tools/fs116_y3_*.py`, `data/fs116/reports/FS116-Y3.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 550k

Hello. You are Ephodos, on the construction side of FS-116's first round.

## Why this job

Round 3's proof side (`plans/FS116-N2-proof.md`) derived what a "hub" carries — a change point of a four-colour vertex's ring whose four germs
at ±60° lie off (Q) arcs, so that RING-GERM places a four-colour vertex there — and built lemmas on hubs (FS116-N2-STAR, -RECIP, -ANTI,
-HEX6, -HEX3; one mind each). But no held fragment has a hub, so those lemmas have no model at six colours (its § 2.4). The sharp question is
yours: is there a valid six-coloured fragment, on a closed disc of radius above 2 about a four-colour vertex p, whose ring carries no arc of Γ
(a Γ-free ring, so every change point is a hub)? Build one by formula and check it exactly, or derive why none exists at a named radius. A
fragment answers the lemmas' vacuity; an obstruction removes the Γ-free type from the exclusion's case list. The ban on finite-witness search
runs to 2026-10-01: colourings given by formula and exact checks of them are in; nothing enumerates maps, colourings, tile graphs or ring types.

## Your claims

The question above is a case of Y-QRING's class only when the ring carries a (Q) arc, which a Γ-free ring does not; it is posed here as its
own target, with Y-QRING's form:

> - **Y-QRING** *(this list; `.claude/skills/grokkings/SKILL.md` G83's killing test)*: a valid fragment on a closed disc of radius above `φ²/√2` about a vertex
>   of at least four colours whose ring carries a (Q) arc — or a derived obstruction at a named radius.
> — source: data/fs116/claims.md § 7. Y — construction (each checked exactly on an object given by formula)

Read the target as: a valid fragment on a closed disc of radius above 2 about a four-colour vertex whose ring carries no arc of Γ — or a derived
obstruction at a named radius. The list's § 9 names the controls every checker must accept before any refusal is believed.

## What you read

`plans/FS116-N2-proof.md` in full (hubs, the star, HEX6's Kneser reading, § 2.4's question), `plans/FS116-N1-proof.md` §§ 3–4 (RING-GERM and
its one-mind extensions), round 2's construction record `plans/FS116-Y2-construction.md` (the six-colour fragment and its tools, read-only to
you), the frozen list's §§ 0, 9, 10, and the grokkings in your context.

## Done means

1. **Your record**, `plans/FS116-Y3-construction.md`, passing `python3 .claude/skills/ephodos/scripts/derive_gate.py all
   plans/FS116-Y3-construction.md` from the repository root before each stage's commit: the readback, the recognition stage, and for each
   claim either an object given by formula with an exact checker (`tools/fs116_y3_*.py`) that accepts the controls first and fires on a
   planted fault, or a derived obstruction at a named radius, or the families tried with their free parameters against the
   configuration's (the plan's stop rule).
2. **The report** in the standing rules' form. Your last words are exactly "FS116-Y3 idle; report sent to the coordinator": the report
   goes by message, and the hand-back carries nothing else.

## What is yours to decide

Your families, your checkers, and your order. A candidate that fails the exact check measures the candidate, not the question.
If a claim is wrong as posed, say so.

## Stages (save and commit each; standing rule 2)

1. The readback, then recognition on the target.
2. and on: one family or one obstruction per stage.
Last: the report.

Thank you.
